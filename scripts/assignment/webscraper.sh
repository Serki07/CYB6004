#!/bin/bash
Red="\033[31m"
Reset="\033[0m"
Blue="\033[34m"
Purple="\033[35m"
Green="\033[32m"
#run password checker script
./password.sh
#if password is correct show menu
if [ $? -eq 0 ]; then
    echo -e "${Green}Welcome to Scamwatch web Scraper. Please select the year from below or Exit${Reset} " 
    echo -e "${Blue} 2020"
    echo " 2019 "
    echo " 2018 "
    echo -e " 2017${Reset}" 
    echo " Exit" 

    correct=true  

#otherwise print error and exit
else   

    echo " Goodbye"

    correct=false
    exit

fi

#if password is correct run the case statment for selected menu

case $correct in

    true)

    while true 
    do 
        read -p "Please select the year: " year
        
        case $year in
            2017)
                curl https://www.scamwatch.gov.au/api/scamwatch-statistics/all/2017  >2017.txt
                ;;

            2018)
                curl https://www.scamwatch.gov.au/api/scamwatch-statistics/all/2018 >2018.txt

                ;;
            2019)
                curl https://www.scamwatch.gov.au/api/scamwatch-statistics/all/2019 >2019.txt
                ;;
            2020)
                curl https://www.scamwatch.gov.au/api/scamwatch-statistics/all/2020  >2020.txt
                ;;
            exit)
                exit 0
                ;;
            *)
                echo "Please enter the correct year!"
                ;;
        esac

        sed -i  "s/[{]\"date_options\".*show_top_notes\"\:false\,//g; " $year.txt 
        
        sed  -i "s/\"dashboard_/\ndashboard_/g;" $year.txt 
        grep -r stat_summary_amount_lost $year.txt >autosumary.txt
        grep -r dashboard_top_ten_amount_lost $year.txt >autotoptenamount.txt
        grep -r dashboard_top_ten_number $year.txt >autotopten.txt
        grep -r dashboard_amounts_lost_monthly $year.txt >automonthly.txt
        sed -i " s/\"stat_summary_number_of_reports/\nStat_Summary_Number_of_Reports/g; s/\"stat_summary_reports_with_financial_losses/\nStat_Summary_Reports_with_Financial_losses/g; " autosumary.txt
        sed -i "s/labels/\nScam_Catagory/g; s/datasets/\ndatasets/g; s/amount_lost\"\,\"tooltip\"/\nAmount_Lost/g; s/\legend\"\:\"/\nlegend/g; " autotoptenamount.txt #need to add more .....
        sed -i " s/labels/\nScam_Catagory/g; s/datasets/\ndatasets/g; s/number_of_reports\"\,\"tooltip\"/\nNumber_of_Reports/g; s/\"legend\"\:\"/\nlegend/g" autotopten.txt
        sed -i " s/labels/\nMonth/g; s/datasets/\ndatasets/g; s/amount_lost\"\,\"tooltip/\nAmount_Lost/g; s/number_of_reports\"\,\"tooltip\"/\nNumber_of_Reports/g; s/\"legend\"\:\"/\nlegend/g; s/\"type\":\"line\"/\ntype_line/g; s/\"type\":\"bar\"/\ntype_line/g " automonthly.txt
        #need to add newlines for each new text 

        sed -i "/datasets.*\"yAxisID\":\"/d; /dashboard/d; s/Amount lost\://g; /legend/d; s/\[//g; s/\]//g; s/[{]//g; s/[}]//g; s/\"//g; /Scam_Catagory/ {s/:/: /g; s/,/, /g}; s/, /: /g; s/,//g; s/[\]u0026 //g " autotoptenamount.txt
        sed -i "/datasets.*\"yAxisID\":\"/d; /dashboard/d; s/Number of reports\://g; /legend/d; s/\[//g; s/\]//g; s/[{]//g; s/[}]//g; s/\"//g; /Scam_Catagory/ {s/:/, /g; s/,/, /g}; s/, /: /g; s/,//g; s/[\]u0026 //g" autotopten.txt
        sed -i "/datasets.*\"yAxisID\":\"/d; /dashboard/d; /type_/d; /legend/d; s/\[//g; s/\[//g; /Month/ {s/:/, /g; s/,/, /g}; s/\]//g; s/[{]//g; s/[}]//g; s/\"//g; s/Number of reports\://g; s/Amount lost\://g; s/:/,/g; s/, /: /g; s/,//g; s/[\]u0026 //g" automonthly.txt


        figlet Scamwatch Webscraper
        echo -e "${Purple}$year Scam Report Summary${Reset}"

        sed "s/[$]//g" automonthly.txt |awk 'BEGIN{

            FS=":"; currency="$"
            print "________________________________________________________________________________________________\n"
        }

        {
        if($1 ~ /Amount_Lost/)
            for (i=2;i<=NF;i++)lost+=$i;
            
        }
        {
            if($1 ~ /Number_of_Reports/)
            for (i=2;i<=NF;i++)report+=$i;
        }
        {
            if($1 !~ /Amount_Lost/)
                lowestreport=$2;
                for(i=2;i<=NF;i++)
                    if($i<lowestreport)
                    lowestreport=$i
            if($1 !~ /Amount_Lost/)
                highestreport=$2;
                for(i=2;i<=NF;i++)
                    if($i>highestreport)
            
                    highestreport=$i   
        }

        {
            if($1 !~ /Number_of_Reports/)
                lowestloss=$2;
                for(i=2;i<=NF;i++)
                    if($i<lowestloss)
                    lowestloss=$i
                

                highestloss=$2;
                for(i=2;i<=NF;i++)
                    if($i>highestloss)            
                    highestloss=$i  
        }
                            
        END{     
            print "In the year ""\033[31m" report "\033[0m"" Scams are reported to Scamwatch and lost" "\033[31m" currency lost "\033[0m" "AUD in Scam\n"
            printf "An average of " int(report/12) " scams has been reported every month and an average of " currency int(lost/12) " AUD was lost in scam.\n" 
            print "In the reporting year the highest montly reported...  " highestreport " and the lowest was "lowestreport"\n"
            print "In the reporting year the highest montly loss...  " highestloss " and the lowest was "lowestloss"\n"
                        
            print "_________________________________________________________________________________________________\n\n" 
            
            printf("\n\n")
            }' 


        echo -e "${Purple}Top 5 Reported Scam Catagories${Reset}"
        awk 'BEGIN{
            FS=":";
            printf("\033[36m_____________________\033[0m________________________________________________________________________________________________________________________________\n")
            }
            {

            printf("\033[36m|%-18s|\033[0m%-18s|%-24s|%-20s|%-31s|%-32s|\n",$1,$2,$3,$4,$5,$6);
            }
            END{
            printf("\033[36m|__________________|\033[0m__________________|________________________|____________________|_______________________________|________________________________|\n\n")
            printf("\n\n")
            }' autotopten.txt
        echo -e "${Purple}Top 5 Scam Catagories and amount lost${Reset}"
        awk 'BEGIN{
            FS=":";
            printf("\033[36m____________________\033[0m_________________________________________________________________________________________________________________________________\n")
            }
            {

            printf("\033[36m|%-19s|\033[0m%-19s|%-19s|%-20s|%-30s|%-36s|\n",$1,$2,$3,$4,$5,$6);
            }
            END{
            printf("\033[36m|___________________|\033[0m___________________|___________________|____________________|______________________________|____________________________________|\n\n")
            printf("\n\n")
            }' autotoptenamount.txt
        echo -e "${Purple}Monthly Scam Report and Amount lost${Reset}"
        awk 'BEGIN{
            FS=":";
            printf("\033[36m___________________\033[0m__________________________________________________________________________________________________________________________________\n")
            }
            {

            printf("\033[36m|%-17s|\033[0m%-10s|%-10s|%-10s|%-10s|%-10s|%-10s|%-10s|%-10s|%-10s|%-10s|%-10s|%-9s|\n",$1,$2,$3,$4,$5,$6,$7,$8,$9,$10,$11,$12,$13);
            }
            END{
            printf("\033[36m|_________________|\033[0m__________|__________|__________|__________|__________|__________|__________|__________|__________|__________|__________|_________|\n\n")
            }' automonthly.txt


    done
                  
;;

esac