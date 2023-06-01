#!/bin/bash

# Temporary files
CLEANED_PACK="cleaned_pack.txt"
ORIGINAL_PACK="original_pack.txt"
CLEANED_FILENAMES="cleaned_filenames.txt"
ORIGINAL_FILENAMES="original_filenames.txt"
DELETED_FILES="deleted_files.txt"

rm -rf result.txt

# Find smallest and largest pack files
FILES=(.git/objects/pack/*.pack)
if [ ${#FILES[@]} -lt 2 ]; then
    echo "Need at least two pack files to compare."
    exit 1
fi

# Sort files by size
FILES=($(for file in "${FILES[@]}"; do echo "$(du -sb "$file" | cut -f1) $file"; done | sort -n | cut -d " " -f 2-))
PACK1="${FILES[0]}" # smallest
PACK2="${FILES[-1]}" # largest

# Verify packs and write outputs
git verify-pack -v $PACK1 > $CLEANED_PACK
git verify-pack -v $PACK2 > $ORIGINAL_PACK

# Get filenames
awk '{print $NF}' $CLEANED_PACK | sort > $CLEANED_FILENAMES
awk '{print $NF}' $ORIGINAL_PACK | sort > $ORIGINAL_FILENAMES
echo "Removing all files that won't be used again"
rm -rf $CLEANED_PACK $ORIGINAL_PACK

# Find difference
comm -23 $ORIGINAL_FILENAMES $CLEANED_FILENAMES > $DELETED_FILES
echo "Removing all files that won't be used again"
rm -rf $CLEANED_FILENAMES $ORIGINAL_FILENAMES

# Print deleted files
echo "Deleted files:"
cat $DELETED_FILES

# Print file names for deleted files
# echo "File names for deleted files:"
# while IFS= read -r line; do
#     git rev-list --objects --all | grep $line | grep / >> result.txt
# done < $DELETED_FILES

echo "File names for deleted files:"
while IFS= read -r line; do
    git rev-list --objects --all | grep $line | grep '[a-zA-Z0-9]'
done < $DELETED_FILES
