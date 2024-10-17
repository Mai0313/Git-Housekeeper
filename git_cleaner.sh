#!/bin/bash

# Download BFG.jav
wget https://repo1.maven.org/maven2/com/madgag/bfg/1.13.0/bfg-1.13.0.jar

# Rename
mv bfg-1.13.0.jar bfg.jar

# Scan all files that are over 10MB and remove it
java -jar bfg.jar --strip-blobs-bigger-than 10M .git

# Remove csv, zip, xlsx, etc
java -jar bfg.jar --delete-files '{*.zip,*.xlsx}' .git

# Clean git
git reflog expire --expire=now --all && git gc --prune=now --aggressive

# Push to remote
git push


chmod +x ./git_diff.sh
./git_diff.sh
