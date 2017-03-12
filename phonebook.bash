#!/bin/bash
#Author: Anuja Joshi

echo "Enter file name that has the data"
read fileName;
if [ -O $fileName ]
then
    echo "$fileName is valid, welcome to the program!"
else
    echo "Error reading $fileName"
    exit 1
fi
printMenu(){
    echo "(1) Listing of records in alphabetical order of first name or last name "
    echo "(2) Listing of records in reverse alphabetical order of first name or last name "
    echo "(3) Search for a record by Last Name and print out the result."
    echo "(4) Search for a record by birthday in a given year or month."
    echo "(5) exit"
    echo "choose from options 1, 2, 3, 4, 5 \n>"
}
sortAlphabetical (){
    echo "do you want to sort by first name or last name?"
    echo "Enter 1 for first name or enter 2 for last name "
    read sortChoice
    case $sortChoice in
        "1" )
            sort $fileName
            ;;
        "2" )
            sort -t" " -k2 $fileName
            ;;
        "*")
            echo "Invalid Input Try again! "
            sortAlphabetical
    esac
}

sortReverse (){
    echo "do you want to sort by first name or last name? in reverse order"
    echo "Enter 1 for first name or enter 2 for last name "
    read sortReverse
    case $sortReverse in
        1 )
            sort -r $fileName
        ;;
        2 )
            sort -r -t" " -k2 $fileName
        ;;
        * )
            echo "Invalid Input Try again! "
    esac
}

printMenu
read option
echo "You choose $option "
until test $option -eq 5
do
    case $option in
    1 )
        sortAlphabetical
    ;;
    2 )
        sortReverse
    ;;
    3 )
        echo "Search by lastname "
    ;;
    4 )
        echo "Search birthday"
    ;;
    5 )
        echo "Thank you for using the program "
    ;;
    * )
        echo "Invalid input"
    esac
    sleep 2
    clear
    printMenu
    read option
done
