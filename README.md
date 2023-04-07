# Git Branch Updater

This PowerShell script helps you keep your local Git branches in sync with remote branches. It performs the following tasks:

1. Fetches remote branches and prunes local references of deleted remote branches.
2. Deletes local branches that are not present on the remote.
3. Stashes local changes (if any) with a timestamp before updating each branch.
4. Updates local branches by performing a pull. If a merge is required or an error occurs during the pull, the branch is skipped.

## Usage

1. Save the PowerShell script to a file with a ".ps1" extension (e.g., `update_git_branches.ps1`) in a permanent location on your computer, such as `C:\scripts\update_git_branches.ps1`.

2. Follow the instructions in this [answer](https://www.reddit.com/r/OpenAI/comments/txfh2k/ai_generated_code_pulls_all_git_branches_local/eylw3q1/) to create an alias for the script.

3. Now, you can use the `Update-GitBranches` command in any directory. Open a PowerShell window, navigate to the desired directory, and run the `Update-GitBranches` command. The script will execute and perform the described actions.

## Requirements

- Windows OS with PowerShell installed
- Git for Windows installed

## Notes

- The script assumes you have set up Git on your system and have appropriate permissions to access the repositories.
- Make sure your PowerShell environment allows running scripts. If not, modify the execution policy by running the `Set-ExecutionPolicy RemoteSigned` command.
