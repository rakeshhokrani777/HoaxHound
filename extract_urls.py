import re

def extract_domains_from_text(text):
    # Regular expression pattern to extract domain names from URLs
    pattern = r"https?://(?:www\.)?([^/]+)/?"

    # Find all matches of the pattern in the text
    matches = re.findall(pattern, text)

    # Return unique domain names
    return set(matches)

def extract_domains_from_file(file_path):
    with open(file_path, 'r') as file:
        text = file.read()
        return extract_domains_from_text(text)

# Provide the path to your text file containing URLs
file_path = "/home/kali/urls"

# Extract domain names from the file
domains = extract_domains_from_file(file_path)

# Print the extracted domains
for domain in domains:
    print(domain)
