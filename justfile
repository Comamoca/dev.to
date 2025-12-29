# Create a new article
new:
    #!/usr/bin/env bash
    set -euo pipefail

    # Get current date in YYYY-MM-DD format
    date=$(date +%Y-%m-%d)

    # Prompt for slug using gum
    echo "Enter article slug (hyphen-separated alphanumeric only):"
    slug=$(gum input --placeholder "my-awesome-article")

    # Validate slug format (alphanumeric and hyphens only)
    if ! echo "$slug" | grep -qE '^[a-z0-9-]+$'; then
        echo "Error: Slug must contain only lowercase letters, numbers, and hyphens"
        exit 1
    fi

    # Create filename
    filename="posts/${date}-${slug}.md"

    # Check if file already exists
    if [ -f "$filename" ]; then
        echo "Error: File $filename already exists"
        exit 1
    fi

    # Create posts directory if it doesn't exist
    mkdir -p posts

    # Create the file with a basic template
    printf '%s\n' \
        '---' \
        'title:' \
        'published: false' \
        'description:' \
        'tags:' \
        '---' \
        '' \
        > "$filename"

    echo "Created: $filename"
