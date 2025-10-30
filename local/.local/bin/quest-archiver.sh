#!/bin/bash

# quest-archiver - Move archived quests from 00-Quests to 03-Vault

VAULT_PATH="$HOME/Documents/127.0.0.1"
QUESTS_DIR="$VAULT_PATH/00-Quests"
VAULT_DIR="$VAULT_PATH/03-Vault"

# Check if directories exist
if [ ! -d "$QUESTS_DIR" ]; then
  echo "Error: 00-Quests directory not found at $QUESTS_DIR" >&2
  exit 1
fi

if [ ! -d "$VAULT_DIR" ]; then
  echo "Error: 03-Vault directory not found at $VAULT_DIR" >&2
  exit 1
fi

# Counter for moved files
moved_count=0

# Find all .md files in 00-Quests and check their front matter
while IFS= read -r file; do
  # Check if file contains the archived tag
  if grep -q "tags:" "$file" && grep -A 5 "tags:" "$file" | grep -q "archived"; then
    filename=$(basename "$file")
    echo "Moving archived quest: $filename"

    # Move the file to 03-Vault
    if mv "$file" "$VAULT_DIR/"; then
      echo "✓ Successfully moved to 03-Vault"
      ((moved_count++))
    else
      echo "✗ Failed to move $filename" >&2
    fi
  fi
done < <(find "$QUESTS_DIR" -name "*.md" -type f)

# Check if any files were moved
if [ "$moved_count" -eq 0 ]; then
  echo "No quests to archive."
else
  echo "Archiving complete. Moved $moved_count quest(s) to 03-Vault."
fi
