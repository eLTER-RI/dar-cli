from dar_invenio_cli import core


def showcase_create_draft_from_title(config):
    title = "Sample Dataset"
    created_draft = core.create_draft_from_name(config, title)
    print(created_draft)


def showcase_create_draft_from_title_upload_data_from_paths(config):
    title = "Sample Dataset with File"
    created_draft = core.create_draft_from_name(config, title)
    created_draft_id = created_draft.get("id", None)
    if created_draft_id:
        # Change the file paths to actual files on your system
        core.upload_files_to_draft(
            config,
            draft_id=created_draft_id,
            file_paths=["./sample_data/file1.txt", "./sample_data/file2.txt"]
        )
        core.upload_files_to_draft_from_folder(
            config,
            draft_id=created_draft_id,
            folder_path="./sample_data/more_files"
        )
    else:
        print("Failed to create draft.")
    print(created_draft)


if __name__ == '__main__':
    # Configuration for the DAR instance - replace with actual values
    config = core.Config(
        api_token="zDwPUaCcIQoEroZnBapzqbx2VxSPt87QEiJdMcdH4xA2PcBR4G1OZOrX7jO3",
        base_api_url="https://dar.dev.elter-ri.eu/api",
        model="datasets",
        community="elter"
    )

    # Uncomment to run the showcase
    # showcase_create_draft_from_title(config)
    showcase_create_draft_from_title_upload_data_from_paths(config)
