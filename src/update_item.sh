#!/bin/bash

# Script to update counter value in DynamoDB
# Usage: ./update_dynamodb_item.sh <key> <new_value>

# Check if key and new value are provided
if [ $# -ne 2 ]; then
    echo "Error: Incorrect number of arguments. Usage: ./update_dynamodb_item.sh <key> <new_value>"
    exit 1
fi

# Update counter value in DynamoDB
aws dynamodb update-item --table-name to-do-app-db --key '{"Index": {"N": "0"}}' --update-expression "SET $1 = :newval" --expression-attribute-values '{":newval": {"N": "'"$2"'"}}'
