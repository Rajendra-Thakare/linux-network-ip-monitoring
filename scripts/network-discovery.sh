#!/usr/bin/env bash
set -euo pipefail

Example network discovery script.

Review and customize before running in your environment.

NETWORK="${1:-192.0.2.0/24}"
OUTPUT="${2:-network-icmp.json}"
TEMP_FILE="$(mktemp)"

cleanup() {
rm -f "$TEMP_FILE"
}
trap cleanup EXIT

if ! command -v nmap >/dev/null 2>&1; then
echo "ERROR: nmap is not installed." >&2
exit 1
fi

if ! command -v python3 >/dev/null 2>&1; then
echo "ERROR: python3 is not installed." >&2
exit 1
fi

echo "Discovering hosts in: $NETWORK"

if ! nmap -sn "$NETWORK" -oG - |
awk '/Status: Up/{print $2}' |
sort -u > "$TEMP_FILE"; then
echo "ERROR: Network discovery failed." >&2
exit 1
fi

python3 - "$TEMP_FILE" "$OUTPUT" <<'PY'
import json
import sys

source, output = sys.argv[1:3]

with open(source, encoding="utf-8") as file:
targets = [line.strip() for line in file if line.strip()]

data = [{
"targets": targets,
"labels": {
"job": "network_icmp",
"monitor_type": "icmp",
"environment": "example"
}
}]

with open(output, "w", encoding="utf-8") as file:
json.dump(data, file, indent=2)
file.write("\n")

print(f"Wrote {len(targets)} targets to {output}")
PY
