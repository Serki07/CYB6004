#!/bin/bash
#======================================================================================================
# Description  : This scritp is a webscraper and analyser. It scrape Scam Watch website and return
#                simple sumarised reports and reformated tables
# File name    : webscraper.sh  
# Required file: password.sh is required for authentication
# Written by   : Serki Ashagre
# Version      : 1.0  
#
#======================================================================================================

Red="\033[31m"
Reset="\033[0m"
Blue="\033[34m"
Purple="\033[35m"
Green="\033[32m"
Yellow="\033[33m"

#=====================================================================================================================
# Authentication process
#=====================================================================================================================

#run password checker script
./password.sh

#if password is correct show menu
if [ $? -eq 0 ]; then
    echo -e "${Green}Welcome to Scamwatch web Scraper. Please choose the reporting year from below.${Reset} " 
    echo -e "${Blue} 2020"
    echo " 2019 "
    echo " 2018 "
    echo -e " 2017${Reset}" 
    echo " exit" 

    correct=true  

#otherwise print error and exit
else   
    echo " Goodbye"
    correct=false
    exit 2

fi

#if password is correct run the case statment for selected menu
case $correct in
    true)

        while true 
        do 
            #accept input from user
            read -p "Please type the year from the menu or exit: " year
            
            #check the user input
            case $year in
                2017)
                    #if first case is correct, scarpe the website for that year
                    curl https://www.scamwatch.gov.au/api/scamwatch-statistics/all/2017  >2017.txt
                    ;;
                2018)
                    #if second case is correct, scarpe the website for that year
                    curl https://www.scamwatch.gov.au/api/scamwatch-statistics/all/2018 >2018.txt
                    ;;
                2019)
                    #if third case is correct, scarpe the website for that year
                    curl https://www.scamwatch.gov.au/api/scamwatch-statistics/all/2019 >2019.txt
                    ;;
                2020)
                    #if forth case is correct, scarpe the website for that year
                    curl https://www.scamwatch.gov.au/api/scamwatch-statistics/all/2020  >2020.txt
                    ;;
                exit)
                    #if fifth case is correct, exit
                    exit 3
                    ;;
                *)
                    #for all other inputs print error
                    echo -e "${Red}Please enter the correct year from menu!${Reset}"
                    exit 4
                    ;;
            esac
        
            #================================================================================================================================================================
            #the lines below clear the unwanted  texts and extract the reqired data
            #================================================================================================================================================================

            #search the file for the given regex and replece it with empty string
            sed -i  "s/[{]\"date_options\".*show_top_notes\"\:false\,//g; " $year.txt 
            #search for the string and put it in a new line
            sed  -i "s/\"dashboard_/\ndashboard_/g;" $year.txt 

            #match the given string and save the line in the approprate file 
            #grep -r stat_summary_amount_lost $year.txt >autosumary.txt
            grep -r dashboard_top_ten_amount_lost $year.txt >autotoptenamount.txt
            grep -r dashboard_top_ten_number $year.txt >autotopten.txt
            grep -r dashboard_amounts_lost_monthly $year.txt >automonthly.txt

            #match the given regular expressions and replace them appropraitley 
            sed -i "s/labels/\nScam_Catagory/g; s/datasets/\ndatasets/g; s/amount_lost\"\,\"tooltip\"/\nAmount_Lost/g; s/\legend\"\:\"/\nlegend/g; " autotoptenamount.txt 
            sed -i " s/labels/\nScam_Catagory/g; s/datasets/\ndatasets/g; s/number_of_reports\"\,\"tooltip\"/\nNumber_of_Reports/g; s/\"legend\"\:\"/\nlegend/g" autotopten.txt
            sed -i " s/labels/\nMonth/g; s/datasets/\ndatasets/g; s/amount_lost\"\,\"tooltip/\nAmount_Lost/g; s/number_of_reports\"\,\"tooltip\"/\nNumber_of_Reports/g; s/\"legend\"\:\"/\nlegend/g; s/\"type\":\"line\"/\ntype_line/g; s/\"type\":\"bar\"/\ntype_line/g " automonthly.txt
            
            sed -i "/datasets.*\"yAxisID\":\"/d; /dashboard/d; s/Amount lost\://g; /legend/d; s/\[//g; s/\]//g; s/[{]//g; s/[}]//g; s/\"//g; /Scam_Catagory/ {s/:/: /g; s/,/, /g}; s/, /: /g; s/,//g; s/[\]u0026 //g; s/life:  arrest/life, arrest/g " autotoptenamount.txt
            sed -i "/datasets.*\"yAxisID\":\"/d; /dashboard/d; s/Number of reports\://g; /legend/d; s/\[//g; s/\]//g; s/[{]//g; s/[}]//g; s/\"//g; /Scam_Catagory/ {s/:/, /g; s/,/, /g}; s/, /: /g; s/,//g; s/[\]u0026 //g; s/life:  arrest/life, arrest/g" autotopten.txt
            sed -i "/datasets.*\"yAxisID\":\"/d; /dashboard/d; /type_/d; /legend/d; s/\[//g; s/\[//g; /Month/ {s/:/, /g; s/,/, /g}; s/\]//g; s/[{]//g; s/[}]//g; s/\"//g; s/Number of reports\://g; s/Amount lost\://g; s/:/,/g; s/, /: /g; s/,//g; s/[\]u0026 //g" automonthly.txt
            
            #================================================================================================================================================================

            #declare varibale using awk output
            #when condition meet, print the required column of the given file and assign to a variable
            catagory=$(awk 'BEGIN{ FS=":"};{ if(NR~ 1) cat=$2;} END { print cat }' autotopten.txt)
            catagory2=$(awk 'BEGIN{ FS=":"};{ if(NR~ 1) cat2=$3;} END { print cat2 }' autotopten.txt)
            num=$(awk 'BEGIN{ FS=":"};{ if(NR~ 2) num=$2;} END { print num }' autotopten.txt)
            num2=$(awk 'BEGIN{ FS=":"};{ if(NR~ 2) num2=$3;} END { print num2 }' autotopten.txt)
            
            #calculate total sum of the given row and assign it to a varible
            total=$(awk 'BEGIN{ FS=":"};{ if($1 ~ /Number_of_Reports/)for (i=2;i<=NF;i++)report+=$i;} END { print report}' automonthly.txt)
            #calculate percentage and assign to a variable
            percentage=$(($num*100/ $total))
            percentage2=$(($num2*100/ $total))

            #use figlet to change the text style
            figlet Scamwatch Webscraper

            #========================================================================================================================================================================
            # process the data and start printing output
            #========================================================================================================================================================================

            #print the report header
            echo -e "${Purple}$year Scam Report Summary${Reset}"

            # calulate total, average, highest and lowest 
            sed "s/[$]//g" automonthly.txt |awk 'BEGIN{

                FS=":"; currency="$"
                print "________________________________________________________________________________________________\n"
            }

            {
                #calculate total amount of lost
                if($1 ~ /Amount_Lost/)
                    for (i=2;i<=NF;i++)lost+=$i;
                
            }
            {
                #calculate total number of reports
                if($1 ~ /Number_of_Reports/)
                    for (i=2;i<=NF;i++)report+=$i;
            }
            {
                #find the lowest amout of loss
                lowestloss=$2;
                for(i=2;i<=NF;i++)
                    if($i<lowestloss)
                    lowestloss=$i
                
                #find he highest amount of loss
                highestloss=$2;
                for(i=2;i<=NF;i++)
                    if($i>highestloss)            
                    highestloss=$i  
            }
        
        
                                
            END{ 
                #print calculated outputs    
                print "Total number of reported scams: ""\033[31m" report "\033[0m""\n" 
                print "Total amount of money lost due to Scam: " "\033[31m" currency lost "\033[0m" "\n"
                print "Average number of reported scam every month: " "\033[35m" int(report/12) "\033[0m" "\n" 
                print "Average amount of money lost every month: " "\033[35m" currency int(lost/12) "\033[0m" "\n" 
                print "The highest amount of money lost in a month ""\033[31m" currency highestloss "\033[0m" "\n"
                print "The lowest amount of money lost in a month " "\033[33m" currency lowestloss "\033[0m""\n"
                                
            }' 
            
            #print the percentage result
            echo -e "The highest reported Scam catagory was${Red}$catagory${Reset} at ${Red}$percentage%${Reset}, followed by${Yellow}$catagory2${Reset} at ${Yellow}$percentage2% ${Reset}of the total Scam reported. "
            #print the lower boarder of summary box
            echo "__________________________________________________________________________________________________________________________________________________"
            echo
            echo


            #====================================================================================================================================================================================================================================
            #Format and print tables
            #====================================================================================================================================================================================================================================


            #print table title
            echo -e "${Purple}Top 5 Reported Scam Catagories${Reset}"
            awk 'BEGIN{
                FS=":";
                printf("\033[36m_____________________\033[0m_________________________________________________________________________________________________________________________________________\n")
            }
            {

                printf("\033[36m|%-18s|\033[0m%-18s|%-33s|%-20s|%-31s|%-32s|\n",$1,$2,$3,$4,$5,$6);
            }
            END{
                printf("\033[36m|__________________|\033[0m__________________|_________________________________|____________________|_______________________________|________________________________|\n\n")
                printf("\n\n")
            }' autotopten.txt
            
            #print table title
            echo -e "${Purple}Top 5 Scam Catagories and Amount Lost${Reset}"
            awk 'BEGIN{
                FS=":";
                printf("\033[36m____________________\033[0m________________________________________________________________________________________________________________________________________________\n")
            }
            {

                printf("\033[36m|%-19s|\033[0m%-19s|%-19s|%-35s|%-30s|%-36s|\n",$1,$2,$3,$4,$5,$6);
            }
            END{
                printf("\033[36m|___________________|\033[0m___________________|___________________|___________________________________|______________________________|____________________________________|\n\n")
                printf("\n\n")
            }' autotoptenamount.txt
            
            #print table title
            echo -e "${Purple}Monthly Scam Report and Amount Lost${Reset}"
            awk 'BEGIN{
                FS=":";
                printf("\033[36m___________________\033[0m___________________________________________________________________________________________________________________________________\n")
            }
            {

                printf("\033[36m|%-17s|\033[0m%-10s|%-10s|%-10s|%-10s|%-10s|%-10s|%-10s|%-10s|%-10s|%-10s|%-10s|%-10s|\n",$1,$2,$3,$4,$5,$6,$7,$8,$9,$10,$11,$12,$13);
            }
            END{
                printf("\033[36m|_________________|\033[0m__________|__________|__________|__________|__________|__________|__________|__________|__________|__________|__________|__________|\n\n")
            }' automonthly.txt
            #=======================================================================================================================================================================================================


            #===================================================================================================================================
            #Download Report in CSV
            #===================================================================================================================================        
            #take input form user
            read -p "would you like to download monthly report in csv file? Please type Y for yes or N for no: " 
            case $REPLY in
                #if yes save data in csv
                Y)
                    awk 'BEGIN{
                        FS=":";
                        OFS=",";
                        }
                        {

                        print $1,$2,$3,$4,$5,$6,$7,$8,$9,$10,$11,$12,$13;
                        } 
                        END{
                        }' automonthly.txt >monthlyreport.csv
                    echo -e "${Green}Your file is dowloaded${Reset}"
                ;;
                #if no do nothing
                N)
                    
                ;;
                #for all other options, print error
                *)
                    echo -e "${Red}wrong entry!Only Y or N is accepted${Reset}"
                ;;
            esac 
        done
                  
    ;;

esac