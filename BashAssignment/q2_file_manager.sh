#!/bin/bash

choice=0
#first, we will create the menu for the choices
while [ $choice -ne 8 ]
do
    echo "----------------------------------------"
    echo "      FILE & DIRECTORY MANAGER          "
    echo "----------------------------------------"
    echo "1. List files in current directory"
    echo "2. Create a new directory"
    echo "3. Create a new file"
    echo "4. Delete a file"
    echo "5. Rename a file"
    echo "6. Search for a file"
    echo "7. Count files and directories"
    echo "8. Exit"
    echo "----------------------------------------"
    #we take the user input for choice
    read -p "Enter your choice: " choice
    #implement a switch case for all the choices
    case $choice in

    1)
        echo "Listing files..."
        ls -lh
        ;;

    2)
        read -p "Enter the name of directory: " dirname

        if [ -d "$dirname" ]; then
            echo "Directory exists"
        else
            mkdir "$dirname"
            echo "Directory created."
        fi
        ;;

    3)
        read -p "Enter filename: " filename

        if [ -f "$filename" ]; then
            echo "File exists."
        else
            touch "$filename"
            echo "File created."
        fi
        ;;

    4)
        read -p "Enter file name to delete: " delfile

        if [ -f "$delfile" ]; then
            read -p "Are you sure you want to delete this file? Confirm: (y/n): " confirm

            if [ "$confirm" = "y" ]; then
                rm "$delfile"
                echo "File deleted successfully."
            else
                echo "Deletion cancelled."
            fi
        else
            echo "File does not exist!"
        fi
        ;;

    5)
        read -p "Enter old file name: " oldname
        read -p "Rename the file: " newname

        if [ -f "$oldname" ]; then
            mv "$oldname" "$newname"
            echo "File renamed successfully."
        else
            echo "File not found!"
        fi
        ;;

    6)
        read -p "Enter file name pattern to search: " pattern
        echo "Searching..."
        find . -name "*$pattern*" 2>/dev/null
        ;;

    7)
        file_count=$(find . -type f | wc -l)
        dir_count=$(find . -type d | wc -l)

        echo "Number of files      : $file_count"
        echo "Number of directories: $dir_count"
        ;;

    8)
        echo "Exiting successfully"
        ;;

    *)
        echo "Invalid choice! Please try again."
        ;;
    esac

    echo
done
