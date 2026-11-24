#!/bin/bash

AEROSPACE=/opt/homebrew/bin/aerospace

# Count windows in current workspace
WIN_COUNT=$($AEROSPACE list-windows --json 2>/dev/null | python3 -c "
import json,sys
try: print(len(json.load(sys.stdin)))
except: print(0)
")

if [ "$WIN_COUNT" != "2" ]; then exit 0; fi

# Get focused monitor width
MONITOR_WIDTH=$($AEROSPACE list-monitors --focused --json 2>/dev/null | python3 -c "
import json,sys
try:
    d = json.load(sys.stdin)
    print(int(d[0]['frame']['w']))
except: print(1920)
")

$AEROSPACE balance-sizes
DELTA=$((MONITOR_WIDTH / 4))
$AEROSPACE resize smart +$DELTA
