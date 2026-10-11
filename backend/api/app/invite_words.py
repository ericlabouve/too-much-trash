"""Two-word pilot invites, not BIP-39 wallet mnemonics or installation secrets."""
import hashlib
from pathlib import Path
import secrets

raw = (Path(__file__).parent / "data/bip39-english.txt").read_bytes()
if hashlib.sha256(raw).hexdigest() != "2f5eed53a4727b4bf8880d8f3f199efc90e58503646d9ff8eff3a2ed3b24dbda":
    raise RuntimeError("Pinned invite word list checksum mismatch")
WORDS = tuple(raw.decode("ascii").splitlines())
WORD_SET = frozenset(WORDS)
if len(WORDS) != 2048 or len(WORD_SET) != 2048:
    raise RuntimeError("Invite word list must have 2048 distinct entries")


def generate_invite_code() -> str:
    # Independent draws with replacement: identical words are valid (22 bits).
    return f"{secrets.choice(WORDS)} {secrets.choice(WORDS)}"


def normalize_invite_code(value: str) -> str:
    stripped = value.strip()
    words = stripped.split()
    if len(words) == 2 and all(word.isascii() and word.lower() in WORD_SET for word in words):
        return " ".join(word.lower() for word in words)
    # Legacy opaque tokens remain exact-case with outer whitespace removed.
    # Unknown words, punctuation and misspellings are never guessed/corrected.
    return stripped
