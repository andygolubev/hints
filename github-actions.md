# work with artifacts and releases

name: Deploy Lambda Function
on: [push]

jobs:

  lint:
    runs-on: ubuntu-latest
    steps: 
      - name: Check out code
        uses: actions/checkout@v4
      - name: Set up Python
        uses: actions/setup-python@v2
        with:
          python-version: 3.8
      - name: Install libraries
        run: pip install flake8
      - name: Lint with flake8
        run: |
            cd function
            flake8 . --count --select=E9,F63,F7,F82 --show-source --statistics
            flake8 . --count --exit-zero --max-complexity=10 --max-line-length=127 --statistics

  build:
    runs-on: ubuntu-latest
    needs: lint
    steps:
      - name: Check out code
        uses: actions/checkout@v4
      - name: Set up Python
        uses: actions/setup-python@v2
        with:
          python-version: 3.8
      - name: Install libraries
        run: |
            cd function
            python -m pip install --upgrade pip
            if [ -f requirements.txt ]; then pip install -r requirements.txt -t .; fi 
      - name: Zip bundle
        run: |
            cd function
            zip -r ../${{ github.sha }}.zip .
      - name: Archive artifact
        uses: actions/upload-artifact@v4
        with:
          name: zipped-bundle
          path: ${{ github.sha }}.zip
  release:
    runs-on: ubuntu-latest
    needs: build
    steps:
      - name: Checkout code
        uses: actions/checkout@v4
      - name: Create Release
        id: create_release
        uses: actions/create-release@v1
        env:
          GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }} # This token is provided by Actions, you do not need to create your own token
        with:
          tag_name: ${{ github.run_number }}
          release_name: Release ${{ github.run_number }}
          body: |
            Changes in this Release
            - First Change
            - Second Change
          draft: false
          prerelease: false
      - uses: actions/download-artifact@v4
        with:
          name: zipped-bundle
          path: ./
      - name: Upload Release Asset
        id: upload-release-asset 
        uses: actions/upload-release-asset@v1
        env:
          GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
        with:
          upload_url: ${{ steps.create_release.outputs.upload_url }} 
          asset_path: ./${{ github.sha }}.zip
          asset_name: ${{ github.sha }}.zip
          asset_content_type: application/zip



# deploy nonprod site

name: Deploy feature branches to nonproduction bucket

on:
  push:
    branches:
      - feature*

jobs:

  build:
    runs-on: ubuntu-latest
    env:
      BUCKET_NAME: <Nonproduction bucket name here>
    steps:
      - name: Check out code
        uses: actions/checkout@v2
      - name: configure aws cli
        uses: aws-actions/configure-aws-credentials@v1
        with:
          aws-access-key-id: ${{ secrets.AWS_ACCESS_KEY_ID }}
          aws-secret-access-key: ${{ secrets.AWS_SECRET_ACCESS_KEY }}
          aws-region: us-east-1
      - name: set up node.js
        uses: actions/setup-node@v2
        with:
          node-version: 14
      - name: build site
        run: |
          npm ci
          npm run build
      - name: deploy files to bucket
        run: aws s3 cp public s3://${{ env.BUCKET_NAME }} --recursive --acl public-read


# Add documentation to the project

documentation:
    runs-on: ubuntu-latest
    needs: lint
    steps:
      - name: Checkout code
        uses: actions/checkout@v2
      - name: Create docs folder
        run: mkdir docs
      - name: Convert md to html
        uses: docker://pandoc/core:2.9
        with:
          args: userguide.md -t html -o docs/index.html
      - name: Deploy Pages site
        uses: JamesIves/github-pages-deploy-action@4.1.4
        with:
          branch: gh-pages
          folder: docs