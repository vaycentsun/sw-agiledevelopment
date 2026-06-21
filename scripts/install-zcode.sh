#!/usr/bin/env bash
#
# One-step installer for the sw-agiledevelopment ZCode plugin.
#
# Usage:
#   bash scripts/install-zcode.sh
#
# This script will:
# 1. Clone (or update) the plugin source from GitHub.
# 2. Build a versioned plugin cache that matches ZCode's official plugin layout.
# 3. Register the plugin in ~/.zcode/cli/config.json under plugins.dirs.
# 4. Verify the SessionStart hook emits valid JSON.
#
# After the script finishes, fully restart ZCode so the plugin is loaded.

set -euo pipefail

REPO_URL="https://github.com/vaycentsun/sw-agiledevelopment.git"
SRC_DIR="${HOME}/.zcode/cli/plugins/cache/sw-agiledevelopment-src/sw-agiledevelopment"
CACHE_BASE="${HOME}/.zcode/cli/plugins/cache/sw-agiledevelopment/sw-agiledevelopment"
CONFIG_FILE="${HOME}/.zcode/cli/config.json"

# 1. Clone or update the source repository.
if [ -d "${SRC_DIR}/.git" ]; then
  echo "Updating existing source clone..."
  git -C "${SRC_DIR}" pull --ff-only
else
  echo "Cloning plugin source..."
  rm -rf "${SRC_DIR}"
  git clone "${REPO_URL}" "${SRC_DIR}"
fi

VERSION=$(cat "${SRC_DIR}/VERSION")
DST_DIR="${CACHE_BASE}/${VERSION}"

echo "Building plugin cache at ${DST_DIR}..."
rm -rf "${DST_DIR}"
mkdir -p "${DST_DIR}"

# Symlink to the manifest, package metadata, and README.
ln -s "../../../sw-agiledevelopment-src/sw-agiledevelopment/.zcode-plugin" "${DST_DIR}/.zcode-plugin"
ln -s "../../../sw-agiledevelopment-src/sw-agiledevelopment/package.json" "${DST_DIR}/package.json"
if [ -f "${SRC_DIR}/README.md" ]; then
  ln -s "../../../sw-agiledevelopment-src/sw-agiledevelopment/README.md" "${DST_DIR}/README.md"
fi

# Build a skills/ directory with absolute symlinks so the symlinks stay valid
# regardless of how the parent cache directory is accessed.
mkdir -p "${DST_DIR}/skills"
for src_skill_dir in "${SRC_DIR}"/sw-*/; do
  name=$(basename "${src_skill_dir}")
  abs_skill_dir=$(cd "${src_skill_dir}" && pwd)
  ln -s "${abs_skill_dir}" "${DST_DIR}/skills/${name}"
done

# Build a root hooks/ directory. The real hook scripts live under .zcode-plugin/hooks/,
# but ZCode loads plugin hooks from the plugin root's hooks/ directory, so we provide
# a thin wrapper here.
mkdir -p "${DST_DIR}/hooks"
cp "${SRC_DIR}/.zcode-plugin/hooks/run-hook.cmd" "${DST_DIR}/hooks/run-hook.cmd"
cp "${SRC_DIR}/.zcode-plugin/hooks/hooks.json" "${DST_DIR}/hooks/hooks.json"
cat > "${DST_DIR}/hooks/session-start" <<'EOF'
#!/usr/bin/env bash
# Root-level SessionStart hook wrapper for sw-agiledevelopment.
# The real hook lives under .zcode-plugin/hooks/ and resolves the repository
# root from its own location. This wrapper just forwards to it.
set -euo pipefail
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
PLUGIN_ROOT="$(cd "${SCRIPT_DIR}/.." && pwd)"
exec bash "${PLUGIN_ROOT}/.zcode-plugin/hooks/session-start" "$@"
EOF
chmod +x "${DST_DIR}/hooks/session-start" "${DST_DIR}/hooks/run-hook.cmd"

# 3. Register the plugin in ZCode's plugin configuration.
echo "Registering plugin in ${CONFIG_FILE}..."
mkdir -p "$(dirname "${CONFIG_FILE}")"
python3 - "${DST_DIR}" "${CONFIG_FILE}" <<'PY'
import json, os, sys
dst_dir = sys.argv[1]
config_path = sys.argv[2]

cfg = {}
if os.path.exists(config_path):
    with open(config_path, "r", encoding="utf-8") as f:
        cfg = json.load(f)
if not isinstance(cfg, dict):
    cfg = {}

cfg.setdefault("plugins", {})
cfg["plugins"]["enabled"] = True
# Keep any existing dirs and add ours at the front so the latest version wins.
existing = cfg["plugins"].get("dirs", [])
if not isinstance(existing, list):
    existing = []
# Remove any previous sw-agiledevelopment cache entries to avoid duplicates.
existing = [d for d in existing if "sw-agiledevelopment/sw-agiledevelopment/" not in d]
cfg["plugins"]["dirs"] = [dst_dir] + existing

with open(config_path, "w", encoding="utf-8") as f:
    json.dump(cfg, f, indent=2, ensure_ascii=False)
    f.write("\n")
PY

# 4. Verify the SessionStart hook runs and emits valid JSON.
echo "Verifying SessionStart hook..."
bash "${DST_DIR}/hooks/session-start" | python3 -m json.tool > /dev/null && echo "hook OK"

cat <<EOF

sw-agiledevelopment ${VERSION} has been staged for ZCode.

Next step: fully restart ZCode (Cmd + Q, then reopen).
After restart, open the /plugins panel and look for sw-agiledevelopment
(marketplace shown as "inline"). New sessions will auto-inject the
sw-using-agiledevelopment bootstrap.
EOF
