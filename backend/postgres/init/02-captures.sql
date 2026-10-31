CREATE TABLE IF NOT EXISTS captures (
    id uuid PRIMARY KEY,
    filename text NOT NULL,
    content_type text NOT NULL,
    media_kind text NOT NULL CHECK (media_kind IN ('image', 'video')),
    original_key text NOT NULL,
    size_bytes bigint NOT NULL,
    status text NOT NULL DEFAULT 'queued' CHECK (status IN ('queued', 'processing', 'completed', 'failed')),
    processed_key text,
    processed_content_type text,
    result jsonb,
    error text,
    created_at timestamptz NOT NULL DEFAULT now(),
    processing_started_at timestamptz,
    updated_at timestamptz NOT NULL DEFAULT now()
);

CREATE INDEX IF NOT EXISTS captures_pending_idx ON captures (created_at)
WHERE status IN ('queued', 'processing');
