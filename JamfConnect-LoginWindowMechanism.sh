#!/bin/sh

# LoginWindow Mechanism
# more Infos: https://learn.jamf.com/en-US/bundle/jamf-connect-documentation-current/page/Editing_the_macOS_loginwindow_Application.html

# Read authorization database once
authdb_output=$(security authorizationdb read system.login.console)

# Check for standard macOS login window mechanism
loginwindow_check=$(echo "$authdb_output" | grep -q 'loginwindow:login'; echo $?)

# Check for Jamf Connect specific mechanism
jamf_connect_check=$(echo "$authdb_output" | grep -q 'JamfConnect'; echo $?)

if [ $loginwindow_check == 0 ]; then
    echo "<result>macOS Default LoginWindow</result>"
elif [ $jamf_connect_check == 0 ]; then
    echo "<result>Jamf Connect LoginWindow</result>"
else
    echo "<result>Modified LoginWindow (Unknown)</result>"
fi
