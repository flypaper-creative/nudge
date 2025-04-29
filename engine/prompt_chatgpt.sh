#!/data/data/com.termux/files/usr/bin/bash

# Load API key
export $(grep -v '^#' ~/nudge/.env | xargs)

PROMPT=$(cat ~/nudge/prompts.txt)
OUTPUT_LOG=~/nudge/heartbeat_engine/logs/gpt_output.log

RESPONSE=$(curl -s https://api.openai.com/v1/chat/completions \
  -H "Authorization: Bearer $OPENAI_API_KEY" \
  -H "Content-Type: application/json" \
  -d "{
    \"model\": \"gpt-4o\",
    \"messages\": [{\"role\": \"system\", \"content\": \"You are a 3D logo designer using Blender and SVG workflows.\"},
                   {\"role\": \"user\", \"content\": \"$PROMPT\"}],
    \"temperature\": 0.7
  }" | jq -r '.choices[0].message.content')

echo -e "\n[GPT OUTPUT at $(date)]\n$RESPONSE" >> "$OUTPUT_LOG"
