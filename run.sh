#!/bin/bash

# Define absolute paths to wordlist files
prefix_wordlist="/home/rakesh/wordlist"
suffix_wordlist="/home/rakesh/wordy"
domain_wordlist="/home/rakesh/domain"
common_wordlist="/home/rakesh/common"

# Output file with date and time
current_date_time=$(date +'%Y-%m-%d_%H:%M:%S')
output_file="output_${current_date_time}.txt"

# HTTPX output file with date and time
httpx_output_file="httpx_output_${current_date_time}.txt"

# Function to write output to file and display on screen
write_output() {
    echo "$1" | tee -a "$output_file"
}

# 1.Fuzz common wordlist with specified domains
while IFS= read -r common_word; do
    common_word=$(echo "$common_word" | tr -d '[:space:]')  # Trim whitespace
    for domain in $(cat "$domain_wordlist"); do
        # Prepare the URL
        final_string="${common_word}.${domain}"
        # Write output to file and display on screen
        write_output "$final_string"
    done
done < "$common_wordlist"

# 2.Fuzz prefix and suffix with wordlists
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

# 3.Fuzz prefix with common wordlist and suffix with domain
while IFS= read -r prefix; do
    prefix=$(echo "$prefix" | tr -d '[:space:]')  # Trim whitespace
    while IFS= read -r common_word; do
        common_word=$(echo "$common_word" | tr -d '[:space:]')  # Trim whitespace
        for domain in $(cat "$domain_wordlist"); do
            # Prepare the URL
            final_string="${prefix}${common_word}.${domain}"
            # Write output to file and display on screen
            write_output "$final_string"
        done
    done < "$common_wordlist"
done < "$prefix_wordlist"

# 4.Fuzz common word with suffix from wordlists and prefix with domain
while IFS= read -r common_word; do
    common_word=$(echo "$common_word" | tr -d '[:space:]')  # Trim whitespace
    while IFS= read -r suffix; do
        suffix=$(echo "$suffix" | tr -d '[:space:]')  # Trim whitespace
        for domain in $(cat "$domain_wordlist"); do
            # Prepare the URL
            final_string="${common_word}${suffix}.${domain}"
            # Write output to file and display on screen
            write_output "$final_string"
        done
    done < "$suffix_wordlist"
done < "$common_wordlist"

# 5.Fuzz prefix, suffix, and common word with domain
while IFS= read -r prefix; do
    prefix=$(echo "$prefix" | tr -d '[:space:]')  # Trim whitespace
    while IFS= read -r suffix; do
        suffix=$(echo "$suffix" | tr -d '[:space:]')  # Trim whitespace
        for common_word in $(cat "$common_wordlist"); do
            for domain in $(cat "$domain_wordlist"); do
                # Prepare the URL
                final_string="${prefix}${common_word}${suffix}.${domain}"
                # Write output to file and display on screen
                write_output "$final_string"
            done
        done
    done < "$suffix_wordlist"
done < "$prefix_wordlist"

# 6.Fuzz prefix and suffix with common wordlist and domain
while IFS= read -r prefix; do
    prefix=$(echo "$prefix" | tr -d '[:space:]')  # Trim whitespace
    while IFS= read -r suffix; do
        suffix=$(echo "$suffix" | tr -d '[:space:]')  # Trim whitespace
        for common_word in $(cat "$common_wordlist"); do
            for domain in $(cat "$domain_wordlist"); do
                # Prepare the URL
                final_string="${prefix}${suffix}${common_word}.${domain}"
                # Write output to file and display on screen
                write_output "$final_string"
            done
        done
    done < "$suffix_wordlist"
done < "$prefix_wordlist"

# 7.Fuzz common wordlist with prefix and suffix and domain
while IFS= read -r common_word; do
    common_word=$(echo "$common_word" | tr -d '[:space:]')  # Trim whitespace
    while IFS= read -r prefix; do
        prefix=$(echo "$prefix" | tr -d '[:space:]')  # Trim whitespace
        while IFS= read -r suffix; do
            suffix=$(echo "$suffix" | tr -d '[:space:]')  # Trim whitespace
            for domain in $(cat "$domain_wordlist"); do
                # Prepare the URL
                final_string="${common_word}${prefix}${suffix}.${domain}"
                # Write output to file and display on screen
                write_output "$final_string"
            done
        done < "$suffix_wordlist"
    done < "$prefix_wordlist"
done < "$common_wordlist"

# 8.Fuzz prefix and suffix with wordlists
while IFS= read -r prefix; do
    prefix=$(echo "$prefix" | tr -d '[:space:]')  # Trim whitespace
    while IFS= read -r suffix; do
        suffix=$(echo "$suffix" | tr -d '[:space:]')  # Trim whitespace
        for domain in $(cat "$domain_wordlist"); do
            # Prepare the URL
            final_string="${prefix}.${suffix}.${domain}"
            # Write output to file and display on screen
            write_output "$final_string"
        done
    done < "$suffix_wordlist"
done < "$prefix_wordlist"

# 9.Fuzz prefix with common wordlist and suffix with domain
while IFS= read -r prefix; do
    prefix=$(echo "$prefix" | tr -d '[:space:]')  # Trim whitespace
    while IFS= read -r common_word; do
        common_word=$(echo "$common_word" | tr -d '[:space:]')  # Trim whitespace
        for domain in $(cat "$domain_wordlist"); do
            # Prepare the URL
            final_string="${prefix}.${common_word}.${domain}"
            # Write output to file and display on screen
            write_output "$final_string"
        done
    done < "$common_wordlist"
done < "$prefix_wordlist"

# 10.Fuzz common word with suffix from wordlists and prefix with domain
while IFS= read -r common_word; do
    common_word=$(echo "$common_word" | tr -d '[:space:]')  # Trim whitespace
    while IFS= read -r suffix; do
        suffix=$(echo "$suffix" | tr -d '[:space:]')  # Trim whitespace
        for domain in $(cat "$domain_wordlist"); do
            # Prepare the URL
            final_string="${common_word}.${suffix}.${domain}"
            # Write output to file and display on screen
            write_output "$final_string"
        done
    done < "$suffix_wordlist"
done < "$common_wordlist"

# 11.Fuzz common wordlist with prefix and suffix and domain
while IFS= read -r common_word; do
    common_word=$(echo "$common_word" | tr -d '[:space:]')  # Trim whitespace
    while IFS= read -r prefix; do
        prefix=$(echo "$prefix" | tr -d '[:space:]')  # Trim whitespace
        while IFS= read -r suffix; do
            suffix=$(echo "$suffix" | tr -d '[:space:]')  # Trim whitespace
            for domain in $(cat "$domain_wordlist"); do
                # Prepare the URL
                final_string="${common_word}.${prefix}.${suffix}.${domain}"
                # Write output to file and display on screen
                write_output "$final_string"
            done
        done < "$suffix_wordlist"
    done < "$prefix_wordlist"
done < "$common_wordlist"

# 12.Fuzz prefix, suffix, and common word with domain
while IFS= read -r prefix; do
    prefix=$(echo "$prefix" | tr -d '[:space:]')  # Trim whitespace
    while IFS= read -r suffix; do
        suffix=$(echo "$suffix" | tr -d '[:space:]')  # Trim whitespace
        for common_word in $(cat "$common_wordlist"); do
            for domain in $(cat "$domain_wordlist"); do
                # Prepare the URL
                final_string="${prefix}.${common_word}.${suffix}.${domain}"
                # Write output to file and display on screen
                write_output "$final_string"
            done
        done
    done < "$suffix_wordlist"
done < "$prefix_wordlist"

# 13.Fuzz prefix and suffix with common wordlist and domain
while IFS= read -r prefix; do
    prefix=$(echo "$prefix" | tr -d '[:space:]')  # Trim whitespace
    while IFS= read -r suffix; do
        suffix=$(echo "$suffix" | tr -d '[:space:]')  # Trim whitespace
        for common_word in $(cat "$common_wordlist"); do
            for domain in $(cat "$domain_wordlist"); do
                # Prepare the URL
                final_string="${prefix}.${suffix}.${common_word}.${domain}"
                # Write output to file and display on screen
                write_output "$final_string"
            done
        done
    done < "$suffix_wordlist"
done < "$prefix_wordlist"

# 14.Fuzz prefix and suffix with wordlists
while IFS= read -r prefix; do
    prefix=$(echo "$prefix" | tr -d '[:space:]')  # Trim whitespace
    while IFS= read -r suffix; do
        suffix=$(echo "$suffix" | tr -d '[:space:]')  # Trim whitespace
        for domain in $(cat "$domain_wordlist"); do
            # Prepare the URL
            final_string="${prefix}-${suffix}.${domain}"
            # Write output to file and display on screen
            write_output "$final_string"
        done
    done < "$suffix_wordlist"
done < "$prefix_wordlist"

# 15.Fuzz prefix with common wordlist and suffix with domain
while IFS= read -r prefix; do
    prefix=$(echo "$prefix" | tr -d '[:space:]')  # Trim whitespace
    while IFS= read -r common_word; do
        common_word=$(echo "$common_word" | tr -d '[:space:]')  # Trim whitespace
        for domain in $(cat "$domain_wordlist"); do
            # Prepare the URL
            final_string="${prefix}-${common_word}.${domain}"
            # Write output to file and display on screen
            write_output "$final_string"
        done
    done < "$common_wordlist"
done < "$prefix_wordlist"

# 16.Fuzz common word with suffix from wordlists and prefix with domain
while IFS= read -r common_word; do
    common_word=$(echo "$common_word" | tr -d '[:space:]')  # Trim whitespace
    while IFS= read -r suffix; do
        suffix=$(echo "$suffix" | tr -d '[:space:]')  # Trim whitespace
        for domain in $(cat "$domain_wordlist"); do
            # Prepare the URL
            final_string="${common_word}-${suffix}.${domain}"
            # Write output to file and display on screen
            write_output "$final_string"
        done
    done < "$suffix_wordlist"
done < "$common_wordlist"

# 17.Fuzz common wordlist with prefix and suffix and domain
while IFS= read -r common_word; do
    common_word=$(echo "$common_word" | tr -d '[:space:]')  # Trim whitespace
    while IFS= read -r prefix; do
        prefix=$(echo "$prefix" | tr -d '[:space:]')  # Trim whitespace
        while IFS= read -r suffix; do
            suffix=$(echo "$suffix" | tr -d '[:space:]')  # Trim whitespace
            for domain in $(cat "$domain_wordlist"); do
                # Prepare the URL
                final_string="${common_word}-${prefix}-${suffix}.${domain}"
                # Write output to file and display on screen
                write_output "$final_string"
            done
        done < "$suffix_wordlist"
    done < "$prefix_wordlist"
done < "$common_wordlist"

# 18.Fuzz prefix, suffix, and common word with domain
while IFS= read -r prefix; do
    prefix=$(echo "$prefix" | tr -d '[:space:]')  # Trim whitespace
    while IFS= read -r suffix; do
        suffix=$(echo "$suffix" | tr -d '[:space:]')  # Trim whitespace
        for common_word in $(cat "$common_wordlist"); do
            for domain in $(cat "$domain_wordlist"); do
                # Prepare the URL
                final_string="${prefix}-${common_word}-${suffix}.${domain}"
                # Write output to file and display on screen
                write_output "$final_string"
            done
        done
    done < "$suffix_wordlist"
done < "$prefix_wordlist"

# 19.Fuzz prefix and suffix with common wordlist and domain
while IFS= read -r prefix; do
    prefix=$(echo "$prefix" | tr -d '[:space:]')  # Trim whitespace
    while IFS= read -r suffix; do
        suffix=$(echo "$suffix" | tr -d '[:space:]')  # Trim whitespace
        for common_word in $(cat "$common_wordlist"); do
            for domain in $(cat "$domain_wordlist"); do
                # Prepare the URL
                final_string="${prefix}-${suffix}-${common_word}.${domain}"
                # Write output to file and display on screen
                write_output "$final_string"
            done
        done
    done < "$suffix_wordlist"
done < "$prefix_wordlist"

# Remove duplicate URLs
sort -u -o "$output_file" "$output_file"

echo "Output saved to $output_file"

# Check status using httpx
echo "Checking status using httpx..."
cat "$output_file" | httpx -sc -fr -title | tee -a "$httpx_output_file"

