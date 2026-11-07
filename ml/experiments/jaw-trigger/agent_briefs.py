"""Generate shared evolutionary briefs with jaw-trigger evaluation guidance."""

from pathlib import Path
import sys

sys.path.insert(0, str(Path(__file__).resolve().parents[3]))
from ml.evolution.agent_briefs import main


if __name__ == "__main__":
    main(context=(
        "Use the configured fitting clips and pay particular attention to Clip 2. "
        "A false trigger costs twice a miss. Avoid clip identity, elapsed clip time, and "
        "labels at inference. Give concrete parameters and preserve a causal, phone-feasible runtime."
    ))
