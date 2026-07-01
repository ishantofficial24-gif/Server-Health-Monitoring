#!/bin/bash
# Here we have the Server health report
source config/threshold.conf
status="Healthy"
get_hostname(){
	echo "Hostname : $(hostname)"
}

get_username(){
	echo "Username : $(whoami)"
}

get_date(){
	echo "Date : $(date)"
}

get_uptime(){
uptime | awk '{print "Uptime:",$3}'
}


get_CPU_usage(){
	top -b -n 1 | head -20 | awk -v limit="$CPU_LIMIT" '
	BEGIN{sum=0} 
	{if(NR>=8)sum+=$10} 
	END{
	print sum
	}'
}

cpu_usage=$(get_CPU_usage)

print_CPU_usage(){
	echo "CPU usage : $cpu_usage%"
}

get_RAM_usage(){
	free -h | awk -v limit="$RAM_LIMIT" 'NR==2{print ($3/$2)*100
		}'
}

ram_usage=$(get_RAM_usage)

print_RAM_usage(){
	echo "RAM usage : $ram_usage%"
}

get_disk_usage(){
	df -h | awk  'NR==3{
	gsub("%","",$5)
	print $5
		}'
}

disk_usage=$(get_disk_usage)

print_DISK_usage(){
	echo "Disk usage : $disk_usage%"
}

checking_threshold(){
	if (( $(echo "$cpu_usage >= $CPU_LIMIT" | bc -l) )) 
	then
		echo "Warning : CPU exceeded its threshold limit ($CPU_LIMIT)"
		status="Warning"
	fi

	if (( $(echo "$ram_usage >= $RAM_LIMIT" | bc -l) )) 
	then
		echo "Warning : RAM has excedded it's threshold limit ($RAM_LIMIT)"
		status="Warning"
	fi

	if (( $(echo "$disk_usage >= $DISK_LIMIT" | bc -l) ))
	then
		echo "Warning : DISK has exceeded it's threshold limit ($DISK_LIMIT)"
		status="Warning"
	fi
}

get_IP_address(){
ip a | awk ' {if($1=="inet"&&$NF!="lo")print "Server IP:",$2}'
}

get_ssh_check(){
systemctl is-active ssh | awk '{print "ssh service:",$0;print like}'
}
main(){
	echo "--------------------------"
	echo "Server health report"
	echo "--------------------------"
	get_hostname
	get_username
	get_date
	get_uptime
	echo "---------------------"
	print_CPU_usage
	print_RAM_usage
	print_DISK_usage
	echo "----------------------"
	get_IP_address
	get_ssh_check
	checking_threshold
	echo "Server status:$status"
	echo ""
	if [[ status=="Healthy" ]]
	then
		exit 0
	fi
	if [[ status=="Warning" ]]
	then
		exit 1
	fi

}
main | tee reports/server_report.txt | tee logs/server.log
