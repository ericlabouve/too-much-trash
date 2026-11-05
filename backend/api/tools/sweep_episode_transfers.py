"""Remove expired resumable staging objects without touching accepted episodes.

Run periodically inside the API container. Owners are locked exactly as they
are during uploads, including revoked owners whose transfer can no longer resume.
Failures abort the current transaction and can be retried safely.
"""
from app.episode_transfer import sweep_expired


def main():
    print(f"Swept expired transfers for {sweep_expired()} installation(s).")


if __name__ == "__main__":
    main()
