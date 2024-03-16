# HoaxHound

Cybersquatting detection using Permutation & Combination , through providing desired wordlist.

Currently this tool is only available on linux OS.



Installation Guide

```sh
git clone https://github.com/rakeshhokrani777/HoaxHound.git
```
```sh
cd HoaxHound/
```
```sh
pip3 install -r requirements.txt  ||  pip install -r requirements.txt
```
```sh
chmod +x install.sh run.sh
```
```sh
./install.sh
```
```sh
./run.sh
```
In ```extract_urls.py``` edit the file location.

```extract_urls.py``` is used to extract urls from web archieve wayback machine result produced. First save the displayed result of wayback machine in txt file save its location with filename in ```extract_urls.py``` file using your editor.

**Note**: Edit run.sh file with all the locations of wordlists before running tool.
