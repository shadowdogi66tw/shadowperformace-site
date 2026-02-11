#!/bin/bash
# Dogi66 Dashboard Status Generator
# 每次執行產生 status.json

WORKSPACE="/Users/dogi/.openclaw/workspace"
DASHBOARD="$WORKSPACE/dashboard"

# 取得記憶體檔案大小
MEMORY_MAIN=$(du -h "$WORKSPACE/MEMORY.md" 2>/dev/null | cut -f1 || echo "0B")
MEMORY_DAILY=$(du -sh "$WORKSPACE/memory" 2>/dev/null | cut -f1 || echo "0B")

# 取得 cron 任務（簡化版）
CRON_TASKS='[
  {"name": "每日市場簡報", "active": true, "next": "08:00"},
  {"name": "每週記憶整理", "active": true, "next": "週日 23:00"}
]'

# 產生 status.json
cat > "$DASHBOARD/status.json" << EOF
{
  "status": "運作中",
  "statusColor": "green",
  "tokenUsed": 0,
  "tokenToday": 0,
  "tokenMonth": 0,
  "tokenPercent": 0,
  "cost": 0.00,
  "model": "claude-opus-4-5",
  "tasks": $CRON_TASKS,
  "memoryMain": "$MEMORY_MAIN",
  "memoryDaily": "$MEMORY_DAILY",
  "updatedAt": "$(date -u +"%Y-%m-%dT%H:%M:%SZ")"
}
EOF

echo "Status updated at $(date)"
