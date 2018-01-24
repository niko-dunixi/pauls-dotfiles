#!/usr/bin/env bash

# This makes life slightly easier, as it sets a convention.
# The original source for this:
# 	http://codeinthehole.com/tips/a-useful-template-for-commit-messages/

TEMPLATE_FILE=~/.git-commit-template.txt
echo "Placing template into ${TEMPLATE_FILE} and setting as default."
cat > $TEMPLATE_FILE<<_EOF_
# One sentence summary


# Paragraph summary, if needed. Place extra technical details here.


# Provide links to any relevant tickets, articles, or other resources


_EOF_
git config --global commit.template $TEMPLATE_FILE
