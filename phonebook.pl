#!/usr/bin/perl
#Author Anuja Joshi
#open file input.txt
print "Enter file name that has the data \n>";
$fileName = <STDIN>;
open ( INPUTFILE, $fileName) || die "Sorry couldn't open file please enter a valid file! " ;
@phoneBookArray;
while (<INPUTFILE>){
    push (@phoneBookArray, $_);
}
&mainMenu;
sub mainMenu(){
    
    print "\n \n \n \n \n \n \n(1) Listing of records in alphabetical order of first name or last name \n";
    print "(2) Listing of records in reverse alphabetical order of first name or last name \n";
    print "(3) Search for a record by Last Name and print out the result.\n";
    print "(4) Search for a record by birthday in a given year or month.\n";
    print "(5) exit";
    print "choose from options 1, 2, 3, 4, 5 \n>";
    $choice = <STDIN>;
    if ($choice == 1){
        &printArray(&sortAlphaetical);
        &mainMenu;
    }
    elsif ($choice ==2){
        &printArray(&reverseArray);
        &mainMenu;
    }
    elsif ($choice ==3){
        &searchLastName;
        &mainMenu;
    }
    elsif ($choice ==4){
        &printArray( &searchBirthday );
        &mainMenu;
    }
    elsif ($choice == 5){
        print "Thank you for using this!"
    }
    else{
        print "Incorrect choice ";
        &mainMenu;
    }
}
sub printArray() {
    foreach( @_ ) {
        print  "$_";
        
    }
}
sub sortAlphaetical (){
    print "\ndo you want to sort by first name or last name?\n Enter 1 for first name or enter 2 for last name \n";
    $sortChoice = <STDIN>;
    if ($sortChoice == 1){
        print "Sorting by first name!\n";
        @sortedFirstName = sort(@phoneBookArray);
        return @sortedFirstName;
    }
    elsif ($sortChoice == 2){
        print "Sorting by last name!\n";
        @sortedLastName = `sort -k2 input.txt` ;
        return @sortedLastName;
        
    }
    else{
        &sortAlphaetical;
    }
}
sub reverseArray (){
    @temptoReverse = &sortAlphaetical;
    return reverse(@temptoReverse);
}
sub searchLastName(){
    print "To search for an entry by last name please enter the last name bellow \n > " ;
    $lastName = <STDIN>;
    chomp $lastName;
    #  1. FirstName LastName :
    # 2. Home Phone Number: (desired format is xxx-xxx-xxxx) :\
    # 3. Mobile Phone Number: (unique for every person, i.e. the primary key) \
    # 4. Address: Street address, City, State and Zip \
    # 5. Birth date: MM/DD/YYYY \
    # 6. Salary
    #given the above file format for every line, use the grep command to find the last name that matches the input, \
    # the reason that I added the rest of the fields to allow for a partial searach for example all last names that start \
    # with a B and not allow for matches to be printed unless they are in the Last name field.
    
    @name = grep  /^.*\s($lastName).*:.*:.*:.*:.*:.*$/ , @phoneBookArray;
    if (@name){
        print "Found: @name \n";
    }
    else {
        print "Enter a correct last name! ";
        &searchLastName;
    }
    
}
sub searchBirthday(){
    print "Do you want to search by the Month or the Year? \nEnter 1 to search by month\nEnter 2 to search by Year \n >";
    $input = <STDIN>;
    if ($input == 1 ){
        print "Enter month to search for in the number format,\nFor example: \nenter 01 for January \n02 for Febuary \n03 for March \n... \n11 for November \n12 for December \n >";
        $inputMonth = <STDIN>;
        #   1. FirstName LastName :\
        #   2. Home Phone Number: (desired format is xxx-xxx-xxxx) :\
        #   3. Mobile Phone Number: (unique for every person, i.e. the primary key) \
        #   4. Address: Street address, City, State and Zip \
        #   5. Birth date: MM/DD/YYYY \
        #   6. Salary
        #given the above file format for every line, use the grep command to
        chop $inputMonth;
        @entryMonth = grep  /^.*:.*:.*:.*:($inputMonth).*:.*$/ , @phoneBookArray;
        
    }
    elsif ($input ==2 ){
        print "Enter Year to search for \n>" ;
        $inputYear = <STDIN>;
        #  1. FirstName LastName :\
        #   2. Home Phone Number: (desired format is xxx-xxx-xxxx) :\
        #   3. Mobile Phone Number: (unique for every person, i.e. the primary key) \
        #   4. Address: Street address, City, State and Zip \
        #   5. Birth date: MM/DD/YYYY \
        #   6. Salary
        #given the above file format for every line, use the grep command to
        chop $inputYear;
        @entryMonth = grep  /^.*:.*:.*:.*:.*\/.*($inputYear):.*$/ , @phoneBookArray;
        
    }
    return @entryMonth;
}
