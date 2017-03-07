#!/bin/sh
# This script will install a Git pre-commit hook that stop accidental commits to master and develop branches.
# There is also a variant that includes a core.whitespace check. See pre-commit-2 below.
# Install in current Git repo:
# curl -fL https://gist.githubusercontent.com/stefansundin/9059706/raw/install-pre-commit.sh | sh
# Install with core.whitespace check:
# curl -fL https://gist.githubusercontent.com/stefansundin/9059706/raw/install-pre-commit.sh | sh -s pre-commit-2
# Install with core.whitespace check and EOF-newline-check:
# curl -fL https://gist.githubusercontent.com/stefansundin/9059706/raw/install-pre-commit.sh | sh -s pre-commit-3
# Install only core.whitespace check:
# curl -fL https://gist.githubusercontent.com/stefansundin/9059706/raw/install-pre-commit.sh | sh -s pre-commit-3

# Uninstall:
# rm .git/hooks/pre-commit
# in each repository that you've added this to.

GITROOT=`git rev-parse --show-toplevel 2> /dev/null`

echo
echo

if [ "$GITROOT" == "" ]; then
	echo This does not appear to be a git repo.
	exit 1
fi

if [ -f "$GITROOT/.git/hooks/pre-commit" ]; then
	echo There is already a pre-commit hook installed. Delete it first.
	echo
	echo "    rm '$GITROOT/.git/hooks/pre-commit'"
	echo
	exit 2
fi

FILE=${1:-pre-commit}

echo Downloading $FILE hook from https://gist.github.com/stefansundin/9059706
echo

curl -fL -o "$GITROOT/.git/hooks/pre-commit" "https://gist.githubusercontent.com/stefansundin/9059706/raw/$FILE"
if [ ! -f "$GITROOT/.git/hooks/pre-commit" ]; then
	echo Error downloading pre-commit script!
	exit 3
fi

chmod +x "$GITROOT/.git/hooks/pre-commit"

echo "You're all set! Happy hacking!"

exit 0 