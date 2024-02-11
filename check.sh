#!/bin/bash

# FIND ALL .gg DIRECTORIES
echo
echo -n "CHECKING..."
repos=$(find ~ -type d -name "*.gg" 2>/dev/null)

# STYLING
echo -ne "\r\033[0K"
 
# NO .gg FOLDERS
if [ -z "$repos" ];then
	echo No git repositories found
	echo
	exit 0
fi

# LOOP THROUGH GIT REPOS & CHECK STATUS
for repo in $repos;do
	cd $repo;
	if [ -d "$repo/.git" ];then
		cd "$repo" || exit 1
		# Check git status
		CHANGES=$(git status | grep "Changes not staged")
		UNTRACKED=$(git status | grep "Untracked files")
		UNCOMMITTED=$(git status | grep "Changes to be committed")
		AHEAD=$(git status | grep "Your branch is ahead")
		if [ -z "$CHANGES" ] && [ -z "$UNTRACKED" ] && [ -z "$AHEAD" ] && [ -z "$UNCOMMITTED" ];then 
			echo -e "OK\t$repo"
		else
			echo -e "$(tput setaf 1)!!!\t$repo$(tput sgr0)"
		fi
		echo
	else
		echo -e "\t$repo --> NOT A GIT REPO"
		echo
	fi

done
