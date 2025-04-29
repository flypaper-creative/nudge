#!/data/data/com.termux/files/usr/bin/bash

# Load your OpenAI API key from the .env file
source ~/nudge/.env

# Ask the user for the context description
echo "Describe the context for the prompts:"
read CONTEXT

# Safety check if no context provided
if [ -z "$CONTEXT" ]; then
  echo "No context provided. Exiting."
  exit 1
fi

# Prepare the GPT prompt to generate dynamic prompts
GPT_INPUT="Generate 5 creative, varied, and context-aware user prompts that would guide ChatGPT effectively. The context is: \"$CONTEXT\". Each prompt should be natural, specific to the task, and encourage detailed responses."

# Send request to OpenAI API
RESPONSE=$(curl -s https://api.openai.com/v1/chat/completions \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer $OPENAI_API_KEY" \
  -d "{
    \"model\": \"gpt-4o\",
    \"messages\": [{\"role\": \"user\", \"content\": \"$GPT_INPUT\"}],
    \"temperature\": 0.8
  }")

# Parse the output using jq
if command -v jq >/dev/null 2>&1; then
  PROMPT_OUTPUT=$(echo "$RESPONSE" | jq -r '.choices[0].message.content // "No output generated."')
else
  echo "[ERROR] jq is required but not installed." >&2
  exit 1
fi

# Display the generated prompts
echo -e "\n[Generated Prompts Based on Your Context]:"
echo "$PROMPT_OUTPUT"

# Option to append to prompts.txt
echo -e "\nDo you want to save these prompts to ~/nudge/prompts.txt? (y/n)"
read SAVE_DECISION

if [ "$SAVE_DECISION" = "y" ] || [ "$SAVE_DECISION" = "Y" ]; then
  echo -e "\n$PROMPT_OUTPUT\n" >> ~/nudge/prompts.txt
  echo "Prompts saved to ~/nudge/prompts.txt"
else
  echo "Prompts not saved."
fi
