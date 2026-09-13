"""Update the formula from a stable release's verified source archive."""

import hashlib
import io
import json
import re
import subprocess
import tarfile
import tomllib
import urllib.request
from pathlib import Path

release = json.loads(
    subprocess.check_output(
        [
            "gh",
            "release",
            "view",
            "--repo",
            "msdx321/codex-cleaner",
            "--json",
            "tagName",
        ],
        text=True,
    )
)
tag = release["tagName"]
match = re.fullmatch(r"v(\d+\.\d+\.\d+)", tag)
if match is None:
    raise SystemExit(f"Unsupported release tag: {tag}")
version = match[1]
url = f"https://github.com/msdx321/codex-cleaner/archive/refs/tags/{tag}.tar.gz"
with urllib.request.urlopen(url, timeout=60) as response:
    archive = response.read()
checksum = hashlib.sha256(archive).hexdigest()
with tarfile.open(fileobj=io.BytesIO(archive), mode="r:gz") as source:
    manifest = source.extractfile(f"codex-cleaner-{version}/Cargo.toml")
    if manifest is None:
        raise SystemExit("Release has no Cargo.toml")
    package = tomllib.loads(manifest.read().decode())["package"]
    if package["name"] != "codex-cleaner" or package["version"] != version:
        raise SystemExit("Release tag does not match Cargo.toml")

formula = Path("Formula/codex-cleaner.rb")
text = formula.read_text()
current = re.search(r'/refs/tags/v(\d+\.\d+\.\d+)\.tar\.gz"', text)
if current is None:
    raise SystemExit("Formula has no stable release URL")
if tuple(map(int, version.split("."))) < tuple(map(int, current[1].split("."))):
    raise SystemExit("Refusing to downgrade the formula")
if current[1] == version and f'  sha256 "{checksum}"' not in text:
    raise SystemExit("Existing release checksum changed")
for field, value in (("url", url), ("sha256", checksum)):
    text, count = re.subn(
        rf'^  {field} "[^"]+"$', f'  {field} "{value}"', text, flags=re.MULTILINE
    )
    if count != 1:
        raise SystemExit(f"Expected exactly one {field} stanza")
formula.write_text(text)
print(f"Verified codex-cleaner {version}: {checksum}")
