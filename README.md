# Git Pack Difference Checker

This script helps you identify which files have been deleted from your Git repository after performing cleaning operations. It's valuable for understanding the impact of cleaning operations and ensuring no vital files were unintentionally removed.

## How It Works

The script operates by analyzing the difference between the smallest and largest pack files in your `.git/objects/pack` directory. The pack files are sorted by size, with the smallest treated as the "cleaned" pack and the largest as the "original."

The script then compares these two pack files, generating a list of hash values representing the files deleted in the cleaning process. Finally, it translates these hash values into actual file names, providing a clear, readable list of the files that have been removed.

## Usage

1. Make sure the script is executable. You can do this by running the command `chmod +x pack_diff_checker.sh` (replace `pack_diff_checker.sh` with the name of your script file).
2. Run the script using the command `./pack_diff_checker.sh`.

**NOTE**: This script requires at least two pack files to be present in your `.git/objects/pack` directory for comparison. If there's only one pack file, the script will terminate without performing the comparison.

## Conclusion

The Git Pack Difference Checker is a useful tool for Git repository management, giving you more visibility into the effects of your cleaning operations and helping to prevent accidental data loss.
