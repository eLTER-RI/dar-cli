# DAR CLI

Command line interface interacting application tool for creating draft records and uploading files in Invenio Dar component.

## Features

- Create record drafts
    - Single draft creation
    - Batch draft creation - not implemented yet
- Edit draft metadata - not implemented yet
- Upload files to drafts (maximum 100GB per file)
    - Single file upload
    - Batch file upload
- Delete drafts

## Requirements

- Python 3.10 or higher
- Generated user token in the **[Dar](https://dar.elter-ri.eu/account/settings/applications/)**

## Linux Installation and run

```bash
pip install mu-invenio-cli
mu-invenio-cli
```

## Alternate Installation (Windows)

```bash
py -m pip install --user pipx
py -m pipx ensurepath (reopen terminal)
pipx install mu-invenio-cli
mu-invenio-cli
```

## Updating -- to keep up with latest features

```
pip install --upgrade mu-invenio-cli
# or
pipx upgrade mu-invenio-cli
```

## Troubleshooting

If you encounter an error related to _tkinter_, you might need to install additional dependencies based on your
operating system.

**Linux** users might need to install  _tkinter_ dependencies:

```bash
sudo apt-get install python3-tk
```

**Windows** users might need to install _tcl/tk_ dependencies - if Python was installed via _chocolatey_:

```bash
choco install tcl
choco install tk
```

**MacOS** users might need to install _tcl/tk_ dependencies - if Python was installed via _brew_:

```bash
brew install tcl-tk
```

## Required configuration

_Config file is created during the first run and can be edited via the cli tool._

**Variables**:

- **BASE_API_URL** = URL of the Invenio API (for our dar repository: `https://dar.elter-ri.eu/api/`)
- **API_TOKEN** = User token generated in the **[Dar](https://dar.elter-ri.eu/account/settings/applications/)**
- **MODEL** = Model of the record (e.g. `datasets`, `external-datasets`)

