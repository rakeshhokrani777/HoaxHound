#!/bin/bash

# Define absolute paths to wordlist files
prefix_wordlist="/home/kali/wordlist.txt"
suffix_wordlist="/home/kali/wordy.txt"
domain_wordlist="/home/kali/domain.txt"
common_wordlist="/home/kali/common.txt"

# Output file with date and time
current_date_time=$(date +'%Y-%m-%d_%H:%M:%S')
output_file="output_${current_date_time}.txt"

# HTTPX output file with date and time
httpx_output_file="httpx_output_${current_date_time}.txt"

# Function to write output to file and display on screen
write_output() {
    echo "$1" | tee -a "$output_file"
}

# Fuzz common wordlist with specified domains
while IFS= read -r common_word; do
    common_word=$(echo "$common_word" | tr -d '[:space:]')  # Trim whitespace
    for domain in $(cat "$domain_wordlist"); do
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
        for domain in $(cat "$domain_wordlist"); do
            # Prepare the URL
            final_string="${prefix}${suffix}.${domain}"
            # Write output to file and display on screen
            write_output "$final_string"
        done
    done < "$suffix_wordlist"
done < "$prefix_wordlist"

echo "Output saved to $output_file"

# Check status using httpx
echo "Checking status using httpx..."
cat "$output_file" | httpx -sc -fr -title | tee -a "$httpx_output_file"
