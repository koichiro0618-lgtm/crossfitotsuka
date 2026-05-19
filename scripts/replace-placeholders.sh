#!/usr/bin/env bash
# ============================================
# Production placeholder substitution script
# ============================================
# Usage:
#   PROD_DOMAIN="https://example.com" \
#   PROD_PHONE="+81-3-1234-5678" \
#   PROD_PHONE_DISPLAY="03-1234-5678" \
#   PROD_COMPANY="株式会社サンプル" \
#   PROD_REP="山田太郎" \
#   PROD_EMAIL="info@example.com" \
#     bash scripts/replace-placeholders.sh
#
# Always commit on a branch first so you can review the diff with `git diff`.

set -euo pipefail

PROD_DOMAIN="${PROD_DOMAIN:-}"
PROD_PHONE="${PROD_PHONE:-}"
PROD_PHONE_DISPLAY="${PROD_PHONE_DISPLAY:-}"
PROD_COMPANY="${PROD_COMPANY:-}"
PROD_REP="${PROD_REP:-}"
PROD_EMAIL="${PROD_EMAIL:-}"

if [[ -z "$PROD_DOMAIN" ]]; then
  echo "ERROR: PROD_DOMAIN must be set (e.g. https://crossfit-otsuka.com)" >&2
  exit 1
fi
# Strip trailing slash
PROD_DOMAIN="${PROD_DOMAIN%/}"

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
cd "$ROOT"

# Files to process
mapfile -t TARGETS < <(find . \
  -type f \
  \( -name "*.html" -o -name "*.xml" -o -name ".htaccess" -o -name "robots.txt" \) \
  -not -path "./.git/*" -not -path "./node_modules/*")

echo "Replacing placeholders in ${#TARGETS[@]} files..."

for f in "${TARGETS[@]}"; do
  # Domain
  sed -i.bak "s|https://crossfit-otsuka.example.com|${PROD_DOMAIN}|g" "$f"

  # Phone (E.164 in JSON-LD / tel: links)
  if [[ -n "$PROD_PHONE" ]]; then
    sed -i.bak "s|+81-3-0000-0000|${PROD_PHONE}|g" "$f"
    # tel: links use compact form (digits only)
    TEL_DIGITS="${PROD_PHONE//[^0-9+]/}"
    sed -i.bak "s|tel:+81300000000|tel:${TEL_DIGITS}|g" "$f"
  fi

  # Phone (display format)
  if [[ -n "$PROD_PHONE_DISPLAY" ]]; then
    sed -i.bak "s|03-0000-0000|${PROD_PHONE_DISPLAY}|g" "$f"
  fi

  # 特商法の事業者情報
  if [[ -n "$PROD_COMPANY" ]]; then
    sed -i.bak "s|株式会社◯◯◯◯|${PROD_COMPANY}|g" "$f"
  fi
  if [[ -n "$PROD_REP" ]]; then
    sed -i.bak "s|◯◯ ◯◯|${PROD_REP}|g" "$f"
  fi
  if [[ -n "$PROD_EMAIL" ]]; then
    sed -i.bak "s|info@example.com|${PROD_EMAIL}|g" "$f"
  fi

  rm -f "${f}.bak"
done

echo "Done. Review with: git diff"
echo "Remaining placeholders still requiring manual review:"
grep -rn -E "(◯◯|◯)" --include="*.html" . | grep -v node_modules || echo "  (none)"
