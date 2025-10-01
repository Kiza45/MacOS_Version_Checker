#!/bin/bash

# This script fetches the latest macOS version from Apple's Security Releases page.
# It parses the HTML content to find the most recent version number.

# The URL for Apple's security releases.
URL="https://support.apple.com/en-us/100100"
FILE="version.txt"

file_content=$(cat "$FILE")
# Fetch the HTML content and use grep to find the line with the latest macOS version.
# Then, use sed to extract just the version number.
# We are looking for a line like "The latest version of macOS is 26."
LATEST_MACOS_VERSION=$(curl -s "$URL" | grep -o 'The latest version of macOS is [0-9.]*' | sed 's/The latest version of macOS is //')

# Check if the version was found before printing.
if [ -n "$LATEST_MACOS_VERSION" ]; then
    echo "The latest macOS version is: $LATEST_MACOS_VERSION"

    if [[ "$file_content" == "$LATEST_MACOS_VERSION" ]]; then
    echo "No new updates"

    else
        echo "THERE IS A NEW VERSION OF MACOS"
        echo "$LATEST_MACOS_VERSION" > "$FILE"

    fi
else
    echo "Could not find the latest macOS version on the page."

rm "$FILE"
fi

read -n 1 -s -r -p "Press any key to continue..."