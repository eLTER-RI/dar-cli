# DAR CLI

Command line interface tool for creating draft records and uploading files in Invenio Dar component.

## Features
- Create and edit record drafts
- Upload files to drafts
  - Single file upload
  - Batch file upload
- Delete drafts

## Requirements
- Python 3.10 or higher
- Generated user token in the **[Dar](https://dar.elter-ri.eu/account/settings/applications/)**

## Installation and run
```bash
pip install mu-invenio-cli
mu-invenio-cli
```

## Required configuration
_Config file is created during the first run and can be edited via the cli tool._ 

**Variables**:
- **BASE_API_URL** = URL of the Invenio API (for our dar repository: `https://dar.elter-ri.eu/api/`)
- **API_TOKEN** = User token generated in the **[Dar](https://dar.elter-ri.eu/account/settings/applications/)**
- **MODEL** = Model of the record (e.g. `datasets`, `external-datasets`)

