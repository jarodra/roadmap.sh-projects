#!/bin/bash

# Total CPU usage
get_total_cpu_usage(){
    top -bn1 | grep "%Cpu(s)" | cut -d ',' -f 4 | awk '{print "CPU Usage: " 100-$1 "%"}'
}

# Total memory usage (Free vs Used including percentage) - free
get_total_memory_usage(){
    echo "Memory Usage:"
}

# Total disk usage (Free vs Used including percentage) - df
get_disk_usage(){
    echo "Disk Usage:"
}

# Top 5 processes by CPU usage - ps
get_top_process_cpu(){
    echo "Top 5 processes by CPU usage:"
}

# Top 5 processes by memory usage -ps
get_top_process_memory(){
    echo "Top 5 processes by memory usage:"
}

# Extras: Get os version
get_os_version(){
    hostnamectl | awk -F 'Operating System: ' '{printf "OS Information: " $2}'; echo
}

# Extras: Uptime
get_uptime(){
    uptime -p | awk '{printf "Uptime: " $0}' ; echo
}

# Extras: Load Average
get_load_average(){
    echo "Load Average:"
    uptime | cut -d ',' -f 3 | awk -F 'load average:' '{print "- 1-minute load average: " $2}'
    uptime | cut -d ',' -f 4 | awk -F 'load average:' '{print "- 5-minute load average: " $1}'
    uptime | cut -d ',' -f 5 | awk -F 'load average:' '{print "- 15-minute load average: " $1}'
}

# Extras: logged in users 
get_logged_users(){
    echo "Logged users:"
    uptime | cut -d ',' -f2 | awk '{printf "- " $1 " " $2 ":"}'; echo
    who | awk '{print "  - " $1}' | uniq
}

# Extras: failed login attemps:
get_failed_logins(){
    echo "Failed logins:"
    grep "FAILED" /var/log/auth.log | awk '{printf "- " $0 "\n"}'
}   

main() {
    echo "Server Performance Stats:"
    get_total_cpu_usage
    get_uptime
    get_load_average
    get_logged_users
    get_failed_logins
}

main