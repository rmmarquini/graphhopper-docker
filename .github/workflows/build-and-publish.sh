# This is a basic workflow to help you get started with Actions

name: Build and publish graphhopper image

on:
  schedule:
     - cron: 0 1 * * *

  # Allows you to run this workflow manually from the Actions tab
  workflow_dispatch:

# A workflow run is made up of one or more jobs that can run sequentially or in parallel
jobs:
  # This workflow contains a single job called "build"
  build-and-publish:
    # The type of runner that the job will run on
    runs-on: ubuntu-latest

    # Steps represent a sequence of tasks that will be executed as part of the job
    steps:
      # Checks-out your repository under $GITHUB_WORKSPACE, so your job can access it
      - uses: actions/checkout@v2

      # Runs a single command using the runners shell
      - name: Run a one-line script
        env:
          DOCKERHUB_USER: ${{ secrets.DOCKERHUB_USER }}
          DOCKERHUB_TOKEN: ${{ secrets.DOCKERHUB_TOKEN }}
        run: sh ./.github/build-and-upload.sh