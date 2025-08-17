# Mirror2PixelDrain

Mirror any file from a link to [PixelDrain](https://pixeldrain.com/) and automatically create a GitHub release with the uploaded file link.

This repository contains a GitHub Actions workflow that handles everything for you: downloading, uploading, and release creation.

---

## Features

- Download files from any URL.
- Upload them to PixelDrain using your API token.
- Automatically create a GitHub release with the uploaded file link and file size.
- Fully automated workflow via GitHub Actions.

---

## Usage

1. **Fork this repository** to your GitHub account.



3. **Trigger the workflow**:

   - Go to **Actions → Mirror2PixelDrain → Run workflow**.
   - Enter the following inputs:
     - **Input Link To Mirror**: URL of the file you want to mirror.
     - **Input PixelDrain Token**: Your PixelDrain API token.
   - Click **Run workflow**.

4. **Wait for completion**:

   - The workflow will download the file, upload it to PixelDrain, and create a release in your repository.
   - The release notes will contain the PixelDrain link and file size.

---

## PixelDrain API Token

To get your PixelDrain API token:

1. Sign in or create an account at [PixelDrain](https://pixeldrain.com/).
2. Go to **Account → API Key** and copy your token.
3. Use this token when triggering the workflow.

---

## Credits

- [PixelDrain CLI (`go-pd`)](https://pixeldrain.com/)
- Script created for automated mirroring and releases.

