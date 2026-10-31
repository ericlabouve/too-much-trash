# Processing workflows

`worker.py` claims queued capture rows from Postgres and executes each as a Prefect flow. It downloads the original from S3-compatible blob storage, creates a JPEG preview or poster, uploads the derivative, and records metadata and status. A stale `processing` claim can be reclaimed after 30 minutes following a worker crash. Failed attempts remain visible in the capture record.

The Prefect server records flow runs on the private Compose network. The worker currently runs one capture at a time. Event alignment, frame extraction, proposed labels, review processing, and model inference are future flows.
