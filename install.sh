#!/usr/bin/env bash

# Define color variables if not defined elsewhere
bred='\033[1;31m'
reset='\033[0m'
bblue='\033[1;34m'
bgreen='\033[1;32m'
byellow='\033[1;33m'

# Check Bash version
BASH_VERSION=$(bash --version | awk 'NR==1{print $4}' | cut -d'.' -f1)
if [[ ${BASH_VERSION} -lt 4 ]]; then
    printf "${bred}Your Bash version is lower than 4, please update${reset}\n"
    printf "%sYour Bash version is lower than 4, please update%s\n" "${bred}" "${reset}" >&2
fi

# Declaring Go tools and their installation commands
declare -A gotools
gotools["httpx"]="go install -v github.com/projectdiscovery/httpx/cmd/httpx@latest"

# Install Python packages and Golang tools
function install_tools() {
    eval pip3 install -I -r requirements.txt $DEBUG_STD

    printf "${bblue}Running: Installing Golang tools${reset}\n\n"
    go env -w GO111MODULE=auto
    
    if [[ $upgrade_tools == "false" ]]; then
        res=$(command -v "httpx")
        if [[ -n $res ]]; then
            printf "[${byellow}SKIPPING${reset}] httpx already installed in...${bblue}${res}${reset}\n"
        else
            eval go install -v github.com/projectdiscovery/httpx/cmd/httpx@latest $DEBUG_STD
            exit_status=$?
            if [[ $exit_status -eq 0 ]]; then
                printf "${byellow}httpx installed${reset}\n"
            else
                printf "${bred}Unable to install httpx, try manually${reset}\n"
                double_check=true
            fi
        fi
    fi
}

# Installing latest Golang version
version=$(curl -L -s https://golang.org/VERSION?m=text | head -1)
[[ $version == g* ]] || version="go1.20.7"

printf "${bblue}Running: Installing/Updating Golang${reset}\n\n"
if [[ $install_golang == "true" ]]; then
    if [[ $(type go $DEBUG_ERROR 2>/dev/null | grep -o 'go is') == "go is" ]] && [[ $version == $(go version | cut -d " " -f3) ]]; then
        printf "${bgreen}Golang is already installed and updated${reset}\n\n"
    else
        eval $SUDO rm -rf /usr/local/go $DEBUG_STD
        eval wget "https://dl.google.com/go/${version}.linux-amd64.tar.gz" -O /tmp/${version}.linux-amd64.tar.gz $DEBUG_STD
        eval $SUDO tar -C /usr/local -xzf /tmp/"${version}.linux-amd64.tar.gz" $DEBUG_STD
        eval $SUDO ln -sf /usr/local/go/bin/go /usr/local/bin/
        export GOROOT=/usr/local/go
        export GOPATH=${HOME}/go
        export PATH=$GOPATH/bin:$GOROOT/bin:${HOME}/.local/bin:$PATH
        cat <<EOF >>~/"${profile_shell}"

# Golang vars
export GOROOT=/usr/local/go
export GOPATH=\$HOME/go
export PATH=\$GOPATH/bin:\$GOROOT/bin:\$HOME/.local/bin:\$PATH
EOF
    fi
else
    printf "${byellow}Golang will not be configured according to the user's preferences${reset}\n"
fi

# Check GOPATH and GOROOT
[ -n "$GOPATH" ] || {
    printf "${bred}GOPATH env var not detected, add Golang env vars to your \$HOME/.bashrc or \$HOME/.zshrc:\n\n export GOROOT=/usr/local/go\n export GOPATH=\$HOME/go\n export PATH=\$GOPATH/bin:\$GOROOT/bin:\$PATH\n\n"
    exit 1
}
[ -n "$GOROOT" ] || {
    printf "${bred}GOROOT env var not detected, add Golang env vars to your \$HOME/.bashrc or \$HOME/.zshrc:\n\n export GOROOT=/usr/local/go\n export GOPATH=\$HOME/go\n export PATH=\$GOPATH/bin:\$GOROOT/bin:\$PATH\n\n"
    exit 1
}

# Stripping all Go binaries
eval strip -s "$HOME"/go/bin/* $DEBUG_STD

eval $SUDO cp "$HOME"/go/bin/* /usr/local/bin/ $DEBUG_STD

printf "${bgreen} Finished!${reset}\n\n"
