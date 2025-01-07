#!/bin/bash

# Get the URL of the current page from the clipboard
URL=$(pbpaste)

# Provide debug output of the captured URL
echo "Formatting: '$URL'"

# Initialize the FORMAT variable
FORMAT=""

# Extract necessary parts based on the URL structure
if [[ $URL =~ https?://[^/]+\.atlassian\.net/browse/([^ ]+) ]]; then
    TICKET="${BASH_REMATCH[1]}"
    FORMAT="<a href=\"$URL\">$TICKET</a>"
elif [[ $URL =~ https?://[^/]+\.bitbucket\.org/[^/]+/pull-requests/([0-9]+) ]]; then
    PR_NUMBER="${BASH_REMATCH[1]}"
    FORMAT="<a href=\"$URL\">#$PR_NUMBER</a>"
elif [[ $URL =~ https?://[^/]+\.bitbucket\.org/[^/]+/commits/([0-9a-f]+) ]]; then
    COMMIT_HASH="${BASH_REMATCH[1]}"
    FORMAT="<a href=\"$URL\">${COMMIT_HASH:0:7}</a>"
else
    echo "Unsupported URL structure."
    exit 1
fi

# Copy the formatted string to the clipboard
echo -n "$FORMAT" | pbcopy

# Optional: Feedback on successful copy
echo "Copied to clipboard: $FORMAT"
