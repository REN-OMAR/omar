#!/bin/bash
git fetch --all 2>&1 >/dev/null
#fretch=$(git fetch --all 2>&1)
branch_name="$(git symbolic-ref HEAD 2>/dev/null)" ||
	branch_name="(unnamed branch)" # detached HEAD
branch_name=${branch_name##refs/heads/}

git_sha=$(git rev-parse HEAD)

ahead_behind() {
	curr_branch=$(git rev-parse --abbrev-ref HEAD 2>&1)
	if [ "$(git config remote.upstream.url)" == "" ]; then
		curr_remote=origin
	else #curr_remote=$(git config branch.$curr_branch.remote)
		curr_remote=upstream
	fi

	# echo "curr_branch: $curr_branch"
	# echo "curr_remote: $curr_remote"
	curr_merge_branch=$(git config branch.$curr_branch.merge | cut -d / -f 3)
	# echo "curr_merge_branch: $curr_merge_branch"
	#curr_merge_branch=pre
	difstr=$(git rev-list --left-right --count $curr_branch...$curr_remote/$curr_merge_branch 2>&1 | tr -s '\t' '|')
	if [ "$difstr" != "" ]; then
		echo "$curr_branch $difstr $curr_remote/$curr_merge_branch"
	fi
	#echo $difstr

}

echo "git_sha: $git_sha"
echo "branch_name: $branch_name"
ahead_behind
#echo $fretch
