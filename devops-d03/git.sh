#!/bin/sh
clear
echo "-------------------"
git add .
echo "-------------------"
echo "What the text for this commit ?"
read MESSAGE
git commit -m "$MESSAGE"
echo "-------------------"
git push origin 
