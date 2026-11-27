"""Framework-independent validation checkpoints and an auditable trial journal.

The caller owns optimization and inference-mode measurement. This monitor owns
the stopping/selection rule and saved evidence; it never fits on validation.
"""

from dataclasses import asdict, dataclass
from hashlib import sha256
import fcntl
import json
from math import isfinite
from pathlib import Path
import re
from time import monotonic
from .resources import FittingLease, fitting_settings
from .epoch_admission import PROTOCOL as EPOCH_ADMISSION_PROTOCOL, budget_stop

PROTOCOL = 'validation-checkpoints-v1'


@dataclass(frozen=True)
class TrainingPolicy:
    max_seconds: float = 300.
    patience: int = 10
    min_delta: float = .001
    min_epochs: int = 5

    def __post_init__(self):
        if (type(self.max_seconds) not in (int, float) or not isfinite(self.max_seconds)
                or self.max_seconds <= 0):
            raise ValueError('Training time budget must be finite and positive')
        if any(type(value) is not int or value < 1 for value in (self.patience, self.min_epochs)):
            raise ValueError('Patience and minimum epochs must be positive integers')
        if (type(self.min_delta) not in (int, float) or not isfinite(self.min_delta)
                or not 0 < self.min_delta <= 1):
            raise ValueError('Minimum score improvement must be in (0, 1]')


def policy_for(settings):
    """A trial cannot exceed its owning agent's existing time allocation."""
    minutes = settings.get('agent_minutes', 30)
    if type(minutes) not in (int, float) or not isfinite(minutes) or minutes <= 0:
        raise ValueError('Agent time allocation must be finite and positive')
    return asdict(TrainingPolicy(max_seconds=min(300., minutes * 60.)))


def canonical(value):
    return json.dumps(value, sort_keys=True, separators=(',', ':'), allow_nan=False)


def write(path, value):
    pending = path.with_suffix('.pending')
    pending.write_text(json.dumps(value, indent=2, allow_nan=False) + '\n')
    pending.replace(path)


def evidence(root, path):
    root, path = Path(root).resolve(), Path(path).resolve(strict=True)
    if not path.is_relative_to(root) or not path.is_file() or path.stat().st_size == 0:
        raise ValueError('Training evidence must stay inside its job')
    return {'path': str(path.relative_to(root)), 'sha256': sha256(path.read_bytes()).hexdigest()}


def journal(root, entry):
    """Serialize concurrent agent appends; do not erase unsuccessful trials."""
    with (Path(root) / 'trials.jsonl').open('a') as stream:
        fcntl.flock(stream, fcntl.LOCK_EX)
        stream.write(canonical(entry) + '\n')
        stream.flush()
        fcntl.flock(stream, fcntl.LOCK_UN)


def checkpoint_key(point):
    return (point['validation_score'], -point['validation_loss'], -point['epoch'])


def _verify_evidence(root, record):
    path = Path(root) / record['path']
    if evidence(root, path) != record:
        raise ValueError('Frozen training evidence changed')
    return path


class TrainingMonitor:
    def __init__(self, job, trial_id, plan, context, *, policy=None, clock=monotonic,
                 validation_validator=None, training_validator=None):
        if not isinstance(trial_id, str) or not re.fullmatch(r'[A-Za-z0-9_-]{1,80}', trial_id):
            raise ValueError('Use a unique simple trial ID')
        if not isinstance(plan, dict) or not isinstance(context, dict):
            raise ValueError('Plan and manifest context must be objects')
        required = ('candidate_name', 'hypothesis', 'objective', 'capacity', 'regularization')
        if any(not isinstance(plan.get(key), str) or not plan[key].strip() for key in required):
            raise ValueError('Declare the hypothesis, objective, capacity and regularization before fitting')
        if len(plan['objective']) > 2048:
            raise ValueError('Keep the objective label within 2048 characters')
        if ('measurement_note' in plan and (not isinstance(plan['measurement_note'], str)
                or len(plan['measurement_note']) > 2000)):
            raise ValueError('Measurement details must be text within 2000 characters')
        if validation_validator is not None and not callable(validation_validator):
            raise ValueError('The domain validation checker must be callable')
        if training_validator is not None and not callable(training_validator):
            raise ValueError('The domain training checker must be callable')
        if plan.get('kind') not in ('iterative', 'noniterative'):
            raise ValueError('Declare iterative or genuinely noniterative training')
        seed = plan.get('seed')
        if ('seed' not in plan or (seed is None and plan['kind'] != 'noniterative')
                or (seed is not None and (type(seed) is not int or seed < 0))):
            raise ValueError('Declare a nonnegative integer seed, or null for deterministic noniterative fits')
        aliases = plan.get('candidate_names')
        if aliases is not None and (not isinstance(aliases, list) or not aliases
                or any(not isinstance(name, str) or not name.strip() for name in aliases)
                or len(aliases) != len(set(aliases)) or plan['candidate_name'] not in aliases):
            raise ValueError('Candidate aliases must be unique nonempty names including the primary candidate')
        context_keys = {'train_manifest_sha256', 'validation_manifest_sha256'}
        if (set(context) != context_keys or any(not isinstance(context[key], str)
                or not re.fullmatch(r'[0-9a-f]{64}', context[key]) for key in context_keys)):
            raise ValueError('Pin both training and validation manifests')
        resources = plan.get('resources', {})
        if (not isinstance(resources, dict) or not isinstance(resources.get('device'), str)
                or not resources['device'].strip() or type(resources.get('threads')) is not int
                or resources['threads'] < 1):
            raise ValueError('Record training device and thread allocation')
        if plan['kind'] == 'iterative' and (type(plan.get('max_epochs')) is not int or plan['max_epochs'] < 1
                or not isinstance(plan.get('selection_decoder'), dict)):
            raise ValueError('Predeclare the epoch ceiling and fixed checkpoint-selection decoder')
        self.job, self.trial_id = Path(job).resolve(), trial_id
        if not self.job.is_dir():
            raise ValueError('Create the job directory before its training trials')
        self.directory = self.job / 'training' / trial_id
        if not self.directory.resolve().is_relative_to(self.job):
            raise ValueError('Training trial directory must stay inside its job')
        self.plan = json.loads(canonical(plan))
        if self.plan['kind'] == 'iterative':
            if self.plan.get('epoch_admission', EPOCH_ADMISSION_PROTOCOL) != EPOCH_ADMISSION_PROTOCOL:
                raise ValueError('New iterative trials require the epoch admission guard')
            self.plan['epoch_admission'] = EPOCH_ADMISSION_PROTOCOL
        self.validation_validator = validation_validator
        self.training_validator = training_validator
        self.context = dict(context)
        self.policy = TrainingPolicy(**(asdict(TrainingPolicy()) if policy is None else policy))
        self.clock, self.started = clock, clock()
        if type(self.started) not in (int, float) or not isfinite(self.started):
            raise ValueError('Training clock must produce finite timestamps')
        self.points, self.best, self.gain_score, self.gain_epoch = [], None, None, 0
        self.stop_reason, self.closed = None, False
        self.epoch_admission_stop = None
        self.fitting_lease = None
        self._checkpoint_record = None
        self._history_record = None
        self.directory.mkdir(parents=True, exist_ok=False)
        write(self.directory / 'plan.json', {'protocol': PROTOCOL, 'plan': self.plan,
                                            'context': self.context, 'policy': asdict(self.policy)})
        self._plan_record = evidence(self.job, self.directory / 'plan.json')
        journal(self.job, {'trial_id': trial_id, 'status': 'started',
                           'plan': self._plan_record})
        try:
            limit = fitting_settings(self.job)
            if limit is not None:
                self.fitting_lease = FittingLease(self.job, self.directory, limit).acquire()
                self.started = clock()  # Queueing is not optimization time.
        except BaseException as error:
            self.fail(error)
            raise

    def __enter__(self):
        return self

    def __exit__(self, error_type, error, traceback):
        if error is not None:
            self.fail(error)
        elif not self.closed:
            self.fail('Trial left its context without finish()')
            raise RuntimeError('Finish a trial or record its failure before leaving its context')
        return False

    def _elapsed(self):
        now = self.clock()
        if (type(now) not in (int, float) or not isfinite(now) or now < self.started
                or (self.points and now - self.started < self.points[-1]['elapsed_seconds'])):
            raise ValueError('Training clock moved backwards or became nonfinite')
        return now - self.started

    def can_start_epoch(self):
        if self.closed or self.stop_reason:
            return False
        elapsed = self._elapsed()
        if elapsed >= self.policy.max_seconds:
            self.stop_reason = 'time_budget'
            return False
        self.epoch_admission_stop = budget_stop(self.points, elapsed, self.policy.max_seconds)
        if self.epoch_admission_stop is not None:
            self.stop_reason = 'epoch_budget'
            return False
        return True

    def observe(self, *, train_loss, validation_loss, validation_score,
                validation_predictions, parameters, artifacts=(), training_predictions=None):
        if self.closed or self.stop_reason or self.plan['kind'] != 'iterative':
            raise ValueError('Cannot append another epoch to this trial')
        if any(type(value) not in (int, float) or not isfinite(value) for value in
               (train_loss, validation_loss, validation_score)) or min(train_loss, validation_loss) < 0 or not 0 <= validation_score <= 1:
            raise ValueError('Record finite losses and a validation score between zero and one')
        if (not isinstance(validation_predictions, dict) or not validation_predictions
                or any(not isinstance(key, str) or not key.strip()
                       for key in validation_predictions)):
            raise ValueError('Validation predictions must be a nonempty JSON object keyed by example/clip ID; ordered lists are not accepted')
        epoch = len(self.points) + 1
        if epoch > self.plan['max_epochs']:
            raise ValueError('Declared epoch ceiling exceeded')
        point = {'epoch': epoch, 'train_loss': train_loss, 'validation_loss': validation_loss,
                 'validation_score': validation_score, 'elapsed_seconds': self._elapsed()}
        frozen_predictions = json.loads(canonical(validation_predictions))
        frozen_training = None
        if training_predictions is not None:
            if (not isinstance(training_predictions, dict) or not training_predictions
                    or any(not isinstance(key, str) or not key.strip() for key in training_predictions)):
                raise ValueError('Training predictions must be a nonempty JSON object keyed by example/clip ID')
            frozen_training = json.loads(canonical(training_predictions))
            if self.training_validator is not None:
                self.training_validator(frozen_training)
        elif self.plan.get('record_training_predictions'):
            raise ValueError('This trial requires inference-mode training_predictions after every epoch')
        canonical(parameters)
        if self.validation_validator is not None:
            self.validation_validator(frozen_predictions, validation_score)
        if parameters is None:
            raise ValueError('A validation checkpoint needs frozen parameters')
        predictions_path = self.directory / f'validation-{epoch:04d}.json'
        write(predictions_path, frozen_predictions)
        point['predictions'] = evidence(self.job, predictions_path)
        if frozen_training is not None:
            training_path = self.directory / f'train-{epoch:04d}.json'
            write(training_path, frozen_training)
            point['training_predictions'] = evidence(self.job, training_path)
        self.points.append(point)
        if self.best is None or checkpoint_key(point) > checkpoint_key(self.best):
            self.best = point
            self._checkpoint(parameters, artifacts, epoch)
        if self.gain_score is None or validation_score >= self.gain_score + self.policy.min_delta:
            self.gain_score, self.gain_epoch = validation_score, epoch
        if point['elapsed_seconds'] >= self.policy.max_seconds:
            self.stop_reason = 'time_budget'
        elif epoch >= self.policy.min_epochs and epoch - self.gain_epoch >= self.policy.patience:
            self.stop_reason = 'patience'
        elif epoch == self.plan['max_epochs']:
            self.stop_reason = 'max_epochs'
        note = 'Post-epoch inference-mode losses; checkpoint selected by validation task score, then lower validation loss, then earlier epoch. Test excluded.'
        if self.plan.get('measurement_note'):
            note += ' ' + self.plan['measurement_note']
        write(self.directory / 'history.json', {'metric': self.plan['objective'], 'points': self.points,
                                               'note': note})
        self._history_record = evidence(self.job, self.directory / 'history.json')
        return self.stop_reason is not None

    def _checkpoint(self, parameters, artifacts, epoch):
        # Large/framework-specific tensors may be opaque files referenced from
        # parameters. Freeze those files here rather than forcing JSON tensors.
        files = [evidence(self.job, self.job / path) for path in artifacts]
        write(self.directory / 'selected-checkpoint.json', {'epoch': epoch,
              'parameters': parameters, 'artifacts': files})
        self._checkpoint_record = evidence(self.job, self.directory / 'selected-checkpoint.json')

    def selected_checkpoint(self):
        """Load the saved winner for restoring/exporting, rather than the last epoch."""
        if self._checkpoint_record is None:
            raise ValueError('No validation checkpoint has been recorded')
        checkpoint = json.loads(_verify_evidence(self.job, self._checkpoint_record).read_text())
        for record in checkpoint['artifacts']:
            _verify_evidence(self.job, record)
        return checkpoint

    def finish(self, *, parameters=None, artifacts=()):
        if self.closed:
            raise ValueError('Trial already closed')
        if self.plan['kind'] == 'noniterative':
            if parameters is None:
                raise ValueError('A completed noniterative fit needs frozen parameters')
            self._checkpoint(parameters, artifacts, None)
            self.stop_reason = 'noniterative_complete'
        elif not self.points or self.stop_reason is None:
            raise ValueError('Finish only after patience, epoch ceiling or time budget')
        elif parameters is not None or artifacts:
            raise ValueError('Iterative finish exports the saved winner; do not pass final-epoch parameters')
        _verify_evidence(self.job, self._plan_record)
        self.selected_checkpoint()
        for point in self.points:
            _verify_evidence(self.job, point['predictions'])
            if 'training_predictions' in point:
                _verify_evidence(self.job, point['training_predictions'])
        if self._history_record:
            _verify_evidence(self.job, self._history_record)
        receipt = {'protocol': PROTOCOL, 'trial_id': self.trial_id,
                   'plan': self._plan_record,
                   'checkpoint': self._checkpoint_record,
                   'selected_epoch': self.best['epoch'] if self.best else None,
                   'trained_epochs': len(self.points), 'stop_reason': self.stop_reason,
                   'elapsed_seconds': self._elapsed(),
                   'history': self._history_record}
        if self.epoch_admission_stop is not None:
            receipt['epoch_admission_stop'] = self.epoch_admission_stop
        if self.fitting_lease is not None:
            receipt['fit_lease'] = evidence(self.job, self.fitting_lease.release())
        write(self.directory / 'receipt.json', receipt)
        self.closed = True
        record = evidence(self.job, self.directory / 'receipt.json')
        journal(self.job, {'trial_id': self.trial_id, 'status': 'completed', 'receipt': record})
        return record

    def fail(self, reason):
        if not self.closed:
            if self.fitting_lease is not None:
                self.fitting_lease.release()
            message = str(reason).strip()
            if isinstance(reason, BaseException):
                message = f'{type(reason).__name__}: {message}' if message else f'{type(reason).__name__} (no exception message)'
            elif not message:
                message = 'Unspecified trial failure (empty reason supplied)'
            journal(self.job, {'trial_id': self.trial_id, 'status': 'crash', 'reason': message[:1000]})
            self.closed = True
