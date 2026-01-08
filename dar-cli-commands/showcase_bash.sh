#!/bin/bash

# This script automates the installation of the dar_invenio_cli library and its dependencies.
# It follows the recommended installation steps from the documentation,
# ensuring that all requirements are met to run the CLI commands.

# Exit immediately if a command exits with a non-zero status.
set -e

# --- Configuration ---
# Please set the following variables before running the script
API_TOKEN=""
# Choose from https://dar.dev.elter-ri.eu/api / https://dar.elter-ri.eu/api
BASE_API_URL=""
MODEL="datasets"
COMMUNITY="elter"

# Check if required variables are set
if [ -z "$API_TOKEN" ] || [ -z "$BASE_API_URL" ]; then
    echo "-------------- Configuration missing error ---------------------"
    echo "Error: API_TOKEN and BASE_API_URL must be set."
    echo "Please edit the script and provide the necessary values."
    exit 1
fi

VENV_DIR="dar_cli_venv"

# Trap to clean up the virtual environment on exit
trap 'echo "Cleaning up..."; rm -rf "$VENV_DIR";' EXIT


# --- Helper Functions ---

# Check if a command exists
command_exists() {
    command -v "$1" &> /dev/null
}

# Check if running on a Debian-based system
is_debian() {
    [ -f /etc/debian_version ]
}

# --- Installation Steps ---

echo "Starting dar_invenio_cli setup..."

# 1. Check for Python 3
if ! command_exists python3; then
    echo "Error: python3 is not installed. Please install it to continue."
    if is_debian; then
        echo "On Debian/Ubuntu, you can install it with: sudo apt update && sudo apt install python3"
    fi
    exit 1
fi

# 2. Check for pip3
if ! command_exists pip3; then
    echo "Error: pip3 is not installed. Please install it to continue."
    if is_debian; then
        echo "On Debian/Ubuntu, you can install it with: sudo apt update && sudo apt install python3-pip"
    fi
    exit 1
fi

# 3. Check for and install the 'venv' module if necessary
if ! python3 -c "import venv" &> /dev/null; then
    echo "Python 'venv' module not found."
    if is_debian; then
        echo "Installing python3-venv..."
        sudo apt update
        sudo apt install -y python3-venv
    else
        echo "Please install the package that provides the 'venv' module for your system."
        exit 1
    fi
fi

# 4. Create a virtual environment
if [ ! -d "$VENV_DIR" ]; then
    echo "Creating Python virtual environment in './$VENV_DIR'..."
    python3 -m venv "$VENV_DIR"
else
    echo "Virtual environment './$VENV_DIR' already exists."
fi

# 5. Install dar_invenio_cli into the virtual environment
echo "Installing dar_invenio_cli package..."
"$VENV_DIR/bin/pip" install dar-invenio-cli

# --- Final Instructions ---

echo ""
echo "--------------------------------------------------"
echo "✅ Setup complete!"
echo "--------------------------------------------------"
echo ""

# --- Showcase CLI Commands ---

echo ""
echo "--------------------------------------------------"
echo "🚀 Running showcase of dar-invenio-cli commands..."
echo "--------------------------------------------------"
echo ""

# Activate the virtual environment
source "$VENV_DIR/bin/activate"

# Check for jq
if ! command_exists jq; then
    echo "jq is not installed. Attempting to install..."
    if is_debian; then
        sudo apt-get install -y jq
    else
        echo "Please install jq to run the showcase."
        exit 1
    fi
fi


# Initialize configuration
echo "Initializing configuration..."
dar-invenio-cli config init --api-token "$API_TOKEN" --base-api-url "$BASE_API_URL" --model "$MODEL" --community "$COMMUNITY"

# Create a draft and capture the output
echo "Creating a new draft..."
DRAFT_OUTPUT_RAW=$(dar-invenio-cli create draft --from-title "My Awesome Dataset")
echo "Draft creation output: $DRAFT_OUTPUT_RAW"

# Extract the JSON part from the output, which is expected to be the last line.
DRAFT_ID=$(echo "$DRAFT_OUTPUT_RAW" | tail -n 1)

# The output is a Python dict representation, convert single quotes to double quotes for valid JSON
echo "Extracted Draft ID: $DRAFT_ID"

if [ -z "$DRAFT_ID" ] || [ "$DRAFT_ID" == "null" ]; then
    echo "Error: Failed to create a draft or extract its ID."
    exit 1
fi

echo "Draft created with ID: $DRAFT_ID"

# Upload files to the draft
echo "Uploading files to the draft..."
dar-invenio-cli upload files "$DRAFT_ID" "/absolute/path/to/dar-cli/dar-cli-commands/sample_data/file1.txt" "/absolute/path/to/dar-cli/dar-cli-commands/sample_data/file2.txt"

# Upload files from a folder to the draft
echo "Uploading files from a folder to the draft..."
dar-invenio-cli upload folder "$DRAFT_ID" "/absolute/path/to/dar-cli/dar-cli-commands/sample_data/more_files"

echo ""
echo "--------------------------------------------------"
echo "✅ Showcase complete!"
echo "--------------------------------------------------"
echo ""

# Deactivate the virtual environment
deactivate
