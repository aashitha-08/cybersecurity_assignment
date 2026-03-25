#!/bin/bash

# Total number of users
total_users=$(wc -l < /etc/passwd)

# System users (with uid less than 1000)
system_users=$(awk -F: '$3 < 1000 {count++} END {print count}' /etc/passwd)

# Regular users (with uid greater than or equal to 1000)
regular_users=$(awk -F: '$3 >= 1000 {count++} END {print count}' /etc/passwd)

# users that are currently logged in
logged_in=$(who | wc -l)
#display the user statistics
echo
echo "=== USER STATISTICS ==="
echo "Total Users           : $total_users"
echo "System Users (UID<1000): $system_users"
echo "Regular Users (>=1000) : $regular_users"
echo "Currently Logged In   : $logged_in"
#format regular user details
echo
echo "=== REGULAR USER DETAILS ==="
printf "%-15s %-8s %-20s %-15s %-15s\n" "Username" "UID" "Home Directory" "Shell" "Last Login"
echo "--------------------------------------------------------------------------"

# extractrequired user details from /etc/passwd
awk -F: '$3 >= 1000 {print $1 ":" $3 ":" $6 ":" $7}' /etc/passwd | while IFS=: read user uid home shell
do 
#find out when each user was last logged in using lastlog
    # Get last login using 'last' command
last_login=$(last "$user" | grep -v "still logged in" | head -1 | awk '{print $4,$5,$6,$7}')

if [ -z "$last_login" ]; then
    last_login="Never logged in"
fi

    printf "%-15s %-8s %-20s %-15s %-15s\n" "$user" "$uid" "$home" "$shell" "$last_login"
done
#group information formatting
echo
echo "=== GROUP INFORMATION ==="
printf "%-20s %-10s\n" "Group Name" "Members"
echo "-------------------------------"

#find the number of users that are there in each group
awk -F: '{print $1 ":" $4}' /etc/group | while IFS=: read group members
do
    if [ -z "$members" ]; then
        count=0
    else
        count=$(echo "$members" | tr ',' '\n' | wc -l)
    fi

    printf "%-20s %-10s\n" "$group" "$count"
done

echo
echo "=== SECURITY ALERTS ==="

# Users with uid=0 to find who has root permissions
root_users=$(awk -F: '$3 == 0 {print $1}' /etc/passwd)

echo "Users with root privileges (UID 0):"
echo "$root_users" | while read user
do
    echo " - $user"
done

# check users without passwords using /etc/shadow 
nopass=$(awk -F: '($2 == "" || $2 == "!") {print $1}' /etc/shadow 2>/dev/null)

if [ -z "$nopass" ]; then
    echo "All the users have set passwords"
else
    echo "Users without passwords:"
    echo "$nopass"
fi

# Inactive users or users who have never logged in 
echo "Inactive Users (Never Logged In):"

for u in $(awk -F: '$3 >= 1000 {print $1}' /etc/passwd)
do
    if ! last "$u" | grep -q "wtmp"; then
        echo " - $u"
    else
    echo "0"
    fi
done
