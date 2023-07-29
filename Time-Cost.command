#!/bin/bash

RED='\033[0;31m'
NC='\033[0m'

# Function to convert time to minutes
function convert_to_minutes() {
    # Check if a colon is present in the input string: if so, time is HH:MM
    if [[ $1 == *:* ]]; then
        local hours=$(date -j -f "%H:%M" "$1" "+%H")
        local minutes=$(date -j -f "%H:%M" "$1" "+%M")
        echo $((${hours#0} * 60 + ${minutes#0}))
    else
        # No colon, assume the input is a single minutes value
        local minutes=$(date -j -f "%M" "$1" "+%M")
        echo $((${minutes#0}))
    fi
}

# Function to calculate the cost
function calculate_cost() {
    local duration_minutes=$1
    local rate=0.5

    # Calculate the number of 15-minute intervals
    local intervals=$(( (duration_minutes + 14) / 15 ))

    # Calculate the cost
    local cost=$(awk "BEGIN {printf \"%.2f\", $intervals * $rate}")
    echo $cost
}

function main() {
    # Clear the terminal
    clear

    echo "WSPL 3D Print Price Checker"
    echo "---------------------------"

    # Read input from user
    echo "Enter the duration in HH:MM format:"
    read -p "> " duration

    # Convert input to minutes
    duration_minutes=$(convert_to_minutes $duration)

    # Calculate the cost
    cost=$(calculate_cost $duration_minutes)

    echo -e "The cost of the 3D print is ${RED}\$${cost}${NC}."
    echo
    echo "Another? (Y/N)"

    read -p "> " -n 1 -r choice
    case "$choice" in 
        y|Y ) main;;
        n|N ) exit;;
        * ) exit;;
    esac
    
}

main