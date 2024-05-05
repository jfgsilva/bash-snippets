#!/bin/bash

# Default values
words=1
length=20
delimiter=""

# Function to display help text
display_help() {
    echo "Usage: $0 [--words/-w NUM] [--length/-l NUM] [--delimiter/-d CHAR]"
    echo "Generate random words with specified length and delimiter"
    echo
    echo "Options:"
    echo "  --words, -w     Number of words (default: 1)"
    echo "  --length, -l    Length of words (default: 20)"
    echo "  --delimiter, -d Delimiter character (default: none, use dash only if more than one word)"
    echo "  --help, -h      Display this help message"
    exit 0
}

# Parse command line arguments
while [[ $# -gt 0 ]]; do
    case "$1" in
        --words|-w)
            words="$2"
            shift 2
            ;;
        --length|-l)
            length="$2"
            shift 2
            ;;
        --delimiter|-d)
            delimiter="$2"
            shift 2
            ;;
        --help|-h)
            display_help
            ;;
        *)
            echo "Error: Unknown option $1"
            display_help
            ;;
    esac
done

# Validate input
if ! [[ "$words" =~ ^[0-9]+$ ]] || ! [[ "$length" =~ ^[0-9]+$ ]]; then
    echo "Error: Words and length must be integers."
    exit 1
fi

# Generate random words and format them
random_words=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w "$length" | head -n "$words")

# Check if delimiter should be added
if [[ "$words" -gt 1 && -z "$delimiter" ]]; then
    delimiter="-"
fi

# Output the result
echo "$random_words" | paste -sd "$delimiter"

