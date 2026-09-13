"""Update the formula from a stable release's verified binary archives."""

import hashlib
import json
import re
import subprocess
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
base_url = f"https://github.com/msdx321/codex-cleaner/releases/download/{tag}"
with urllib.request.urlopen(f"{base_url}/SHA256SUMS", timeout=60) as response:
    checksums = dict(
        line.split()[::-1] for line in response.read().decode().splitlines()
    )

formula = Path("Formula/codex-cleaner.rb")
text = formula.read_text()
current = re.search(r"/(?:refs/tags|releases/download)/v(\d+\.\d+\.\d+)", text)
if current is None:
    raise SystemExit("Formula has no stable release URL")
if tuple(map(int, version.split("."))) < tuple(map(int, current[1].split("."))):
    raise SystemExit("Refusing to downgrade the formula")

platforms = {
    "macos": {"arm": "aarch64-apple-darwin", "intel": "x86_64-apple-darwin"},
    "linux": {"arm": "aarch64-unknown-linux-gnu", "intel": "x86_64-unknown-linux-gnu"},
}
blocks = []
for platform, architectures in platforms.items():
    blocks.append(f"  on_{platform} do")
    for architecture, target in architectures.items():
        asset = f"codex-cleaner-{tag}-{target}.tar.gz"
        expected = checksums.get(asset)
        if expected is None or re.fullmatch(r"[0-9a-f]{64}", expected) is None:
            raise SystemExit(f"Missing or invalid checksum for {asset}")
        url = f"{base_url}/{asset}"
        with urllib.request.urlopen(url, timeout=60) as response:
            checksum = hashlib.file_digest(response, "sha256").hexdigest()
        if checksum != expected:
            raise SystemExit(f"Checksum mismatch for {asset}")
        previous = re.search(rf'url "{re.escape(url)}"\s+sha256 "([0-9a-f]+)"', text)
        if previous and previous[1] != checksum:
            raise SystemExit(f"Existing release checksum changed for {asset}")
        blocks.extend(
            [
                f"    on_{architecture} do",
                f'      url "{url}"',
                f'      sha256 "{checksum}"',
                "    end",
                "",
            ]
        )
        print(f"Verified {asset}: {checksum}")
    blocks[-1] = "  end"
    blocks.append("")

formula.write_text(
    "class CodexCleaner < Formula\n"
    '  desc "Prune old generated Codex state with a dry-run preview"\n'
    '  homepage "https://github.com/msdx321/codex-cleaner"\n'
    f'  version "{version}"\n'
    '  license "MIT"\n\n' + "\n".join(blocks) + "\n  def install\n"
    '    bin.install "codex-cleaner"\n'
    "  end\n"
    "end\n"
)
