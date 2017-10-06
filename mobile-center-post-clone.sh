#!/usr/bin/env bash

###################################
# DISCLAIMER
#
# THIS SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.
###################################

# Notes: 
# A "mobile-center-post-clone.sh" Bash script can be used for iOS & Android
# builds in Mobile Center.
# 
# The name of this file is important. Mobile Center builds key off the script
# name. A script with this name will tell the build that it should be run after 
# the build has cloned the repository, but before any further action is taken. 
#
# This file also needs to be placed in a particular location in your 
# app's folder structure. This location depends on how you've defined your 
# build in Mobile Center. For details, and additional info 
# about custom build scripts, see: 
#      https://docs.microsoft.com/en-us/mobile-center/build/custom/scripts/ 
#

# Purpose: 
# This script will look for any files that have been changed in a folder
# that you name, or its subfolders. If changes are found, the script will allow 
# the build to continue. If no changes are found within that folder or its 
# subfolders the script will exit with an exit code 1, which will terminate
# the build at that point. 
# 
# Another VERY IMPORTANT note:
# For this script to properly identify changes based on any number of commits that
# may be included in a push to a repository, you'll need to set up your branching
# similar to the following:
# 
#   remote/main : remote/topicBranchA
#   Commit local into topicBranchA 
#   When ready, Push to the remote/topicBranchA
#   When ready to merge into remote/main, 
#       USE A Pull Request and VERY IMPORTANT: squash changes when merging
# 
# IMPORTANT: In your pull request YOU MUST USE squash changes when merging. 
#
# This is what allows the script to see all the changes from the different 
# commits that are included in the topic branch when it's merged. 
# If you do not use squash changes when merging, only the last commit that 
# was made in the topic branch will be visible to the script. If the last 
# commit happens NOT to be a change to a file your target folder structure 
# the build will be termintated by the script. 
# 
##########################################################
# THIS IS WHERE YOU IDENTIFY YOUR TARGET FOLDER STRUCTURE. 
# Which folder and subfolders to look at? # Change it here. . . . 
# REMEMBER TO LEAVE THE SINGLE QUOTE MARKS AROUND THE FOLDER NAME
folderName='ios'

# That's it. You're done. 

echo "***************************************************** "
echo "******** post-clone script starting ***************** "
echo "******** post-clone script starting ***************** "
echo "******** post-clone script starting ***************** "
echo "******** post-clone script starting ***************** "
echo "***************************************************** "

echo "Looking for changes in this folder: '$folderName'"

decoratedFolderName='\/'$folderName'\/'

echo "git status"
git status

echo "git remote -v"
git remote -v

echo "git branch -v"
git branch -v

#echo "git fetch"
#git fetch 

#echo "git show origin/master"
#git show origin/master
#echo "END git show origin/master"

#echo "git show origin/master | grep -c -i diff.*a" $decoratedFolderName ".*b" $decoratedFolderName
#git show origin/master | grep -c -i a\/ios\/.*b\/ios\/
#git show origin/master | grep -c -i a$decoratedFolderName.*b$decoratedFolderName

echo "Begin logic to see if files in folder '$folderName' were changed. . . "
#refCount=$( git show | grep -c -i a\/ios\/.*b\/ios\/ ) # this is what it will resolve to
refCount=$( git show | grep -c -i a$decoratedFolderName.*b$decoratedFolderName )

echo "This many folder '$folderName' files were changed:" $refCount
if [ $refCount -gt 0 ]
then 
	echo "'$folderName' files changed. The build will continue."
	echo "*************************************************** "
	echo "******** post-clone script ending ***************** "
	echo "******** post-clone script ending ***************** "
	echo "******** post-clone script ending ***************** "
	echo "******** post-clone script ending ***************** "
	echo "******** post-clone script ending ***************** "
	echo "*************************************************** "

	exit 0
else
	echo "No '$folderName' files were changed. Exiting the script and stopping the build."
	echo "*************************************************** "
	echo "******* post-clone script terminating the build *** "
	echo "******* post-clone script terminating the build *** "
	echo "******* post-clone script terminating the build *** "
	echo "******* post-clone script terminating the build *** "
	echo "*************************************************** "
	exit 1
fi
