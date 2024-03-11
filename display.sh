#!/bin/bash

# Define absolute paths to wordlist files
prefix_wordlist="C:\Users\Dell_CSC\Desktop\sai\wordlist.txt"
suffix_wordlist="C:\Users\Dell_CSC\Desktop\sai\wordy.txt"
domain_wordlist="C:\Users\Dell_CSC\Desktop\sai\domain.txt"
common_wordlist="C:\Users\Dell_CSC\Desktop\sai\common.txt"

# Output file
output_file="output.txt"

# Function to write output to file and display on screen
write_output() {
    echo "$1" >> $output_file
    echo "$1"
}

# Fuzz common wordlist with specified domains
while IFS= read -r common_word; do
    common_word=$(echo "$common_word" | tr -d '[:space:]')  # Trim whitespace
    for domain in $(cat $domain_wordlist); do
        # Prepare the URL
        final_string="${common_word}.${domain}"
        # Write output to file and display on screen
        write_output "$final_string"
    done
done < "$common_wordlist"

# Fuzz prefix and suffix with wordlists
while IFS= read -r prefix; do
    prefix=$(echo "$prefix" | tr -d '[:space:]')  # Trim whitespace
    while IFS= read -r suffix; do
        suffix=$(echo "$suffix" | tr -d '[:space:]')  # Trim whitespace
        for domain in $(cat $domain_wordlist); do
            # Prepare the URL
            final_string="${prefix}${suffix}.${domain}"
            # Write output to file and display on screen
            write_output "$final_string"
        done
    done < "$suffix_wordlist"
done < "$prefix_wordlist"

echo "Output saved to $output_file"
