#!/bin/bash

# Script to retrieve counter value from DynamoDB based on key
# Usage: ./get_dynamodb_item.sh <key>

# Check if key is provided
if [ $# -eq 0 ]; then
    echo "Error: Key not provided"
    exit 1
fi

# Extract key from command line argument
key=$1

# Validate if key is valid
if [ "$key" != "Client" ] && [ "$key" != "Server" ]; then
    echo "Error: Invalid key. Key must be either 'Client' or 'Server'"
    exit 1
fi

# Fetch counter value from DynamoDB based on the provided key
counter_value=$(aws dynamodb get-item --table-name to-do-app-db --key '{"Index": {"N": "0"}}' --query "Item.$key.N" --output text)

# Check if counter value is empty
if [ -z "$counter_value" ]; then
    echo "Counter value not found for key: $key"
else
    echo $counter_value
fi
