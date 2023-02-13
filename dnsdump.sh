#!/usr/bin/env bash 

trap ctrl_c INT  

function ctrl_c(){
        printf "\n\nExiting....\n"
        tput cnorm;  exit 1
}

function  helpPanel(){
	echo -e "\n\tAuthor : IRVING ST."
	echo -e "\t\th) helpPanel"
	echo -e "\t\td) domain"
	echo -e "\t\tc) cookie"
	echo -e "\n\t\t Usage: ./dnsdump.sh -d <domain> -c <csrftoken>"
}


function  domain_enum(){
	curl --silent -0 -k -X POST -d "csrfmiddlewaretoken=6f0G2FF1I30OUikizxIUyRFyq2EuVphFaSPWqhqucNGIRPTtiKnioxlJsJNTi0Jl&targetip=${domain}&user=free" --cookie "csrftoken=${cookie}" -H "User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101 Firefox/102.0" -H "Origin: https://dnsdumpster.com" -H "Referer: https://dnsdumpster.com/" https://dnsdumpster.com/ | grep -Eo "(\w+\.)+${domain}" | sort  |  uniq -u  > dnsdump${domain}.txt
}


declare  -i  paramter_counter=0;   while  getopts ":h:d:c:" args ; do
      case  "${args}" in 
	h) helpPanel;;
	d) domain=$OPTARG; let  paramter_counter+=1 ;;
	c) cookie=$OPTARG; let  paramter_counter+=1 ;;

	*)
      esac  

done  

if  [[ $paramter_counter -ne 2 ]]; then   
        helpPanel
else
	domain_enum

fi  









