"""Update the cask from the latest stable release and verify its download."""

import hashlib
import json
import re
import subprocess
import tempfile
from pathlib import Path

repository = "msdx321/proxybear"
release = json.loads(
    subprocess.check_output(
        ["gh", "release", "view", "--repo", repository, "--json", "tagName"],
        text=True,
    )
)
tag = release["tagName"]
match = re.fullmatch(r"v(\d+\.\d+\.\d+)", tag)
if match is None:
    raise SystemExit(f"Unsupported release tag: {tag}")
version = match[1]
asset = f"ProxyBear-{version}.dmg"

with tempfile.TemporaryDirectory() as directory:
    subprocess.run(
        [
            "gh",
            "release",
            "download",
            tag,
            "--repo",
            repository,
            "--pattern",
            asset,
            "--pattern",
            "SHA256SUMS",
            "--dir",
            directory,
        ],
        check=True,
    )
    download = Path(directory)
    with (download / asset).open("rb") as archive:
        checksum = hashlib.file_digest(archive, "sha256").hexdigest()
    checksums = {
        name: digest
        for digest, name in (
            line.split(maxsplit=1)
            for line in (download / "SHA256SUMS").read_text().splitlines()
            if line.strip()
        )
    }
    if checksums.get(f"dmg/{asset}") != checksum:
        raise SystemExit(f"Checksum mismatch for {asset}")

cask = Path("Casks/proxybear.rb")
text = cask.read_text()
for field, value in (("version", version), ("sha256", checksum)):
    text, count = re.subn(
        rf'^  {field} "[^"]+"$', f'  {field} "{value}"', text, flags=re.MULTILINE
    )
    if count != 1:
        raise SystemExit(f"Expected exactly one {field} stanza")
cask.write_text(text)
print(f"Verified ProxyBear {version}: {checksum}")
