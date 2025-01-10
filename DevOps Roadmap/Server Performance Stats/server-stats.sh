#!/bin/bash

# Total CPU usage
get_total_cpu_usage(){
    top -bn2 | grep "%Cpu(s)" | tail -n 1 | cut -d ',' -f 4 | awk '{print "CPU Usage: " 100-$1 "%"}'
}

# Total memory usage (Free vs Used including percentage)
get_total_memory_usage(){
    stats_memory_b=$(free | tr -s ' ' | sed -n '2p')
    used_memory_b=$(echo "$stats_memory_b" | awk '{print $3}')
    total_memory_b=$(echo "$stats_memory_b" | awk '{print $2}')
    used_percentage=$((100 * $used_memory_b / $total_memory_b))
    free_memory=$(free -h | tr -s ' ' | sed -n '2p' | cut -d' ' -f 4)
    used_memory=$(free -h | tr -s ' ' | sed -n '2p' | cut -d' ' -f 3)
    echo "Memory Usage: $used_percentage% (Used: $used_memory / Free: $free_memory)"
}

# Total disk usage (Free vs Used including percentage)
get_disk_usage(){
    df -h --total | grep 'total' | awk '{printf "Disk Usage:" $5 " (Used: " $3 " / Free: " $2 ")" "\n"}'
}

# Top 5 processes by CPU usage
get_top_process_cpu(){
    echo "Top 5 processes by CPU usage:"
    ps -eo pcpu,pid,user,cmd,comm --sort=-pcpu | head -n 6
}

# Top 5 processes by memory usage
get_top_process_memory(){
    echo "Top 5 processes by memory usage:"
    ps -eo pmem,pid,user,cmd,comm --sort=-pmem | head -n 6
}

# Extras: Get os version
get_os_version(){
     hostnamectl | grep 'Operating System:'
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
    w | head -n 1 | awk '{printf "- " $4 " users:" "\n"}'
    who | awk '{print "  - " $1}' | uniq
}

# Extras: failed login attemps
get_failed_logins(){
    echo "Failed logins:"
    grep "FAILED" /var/log/auth.log | awk '{printf "- " $0 "\n"}'
}   

main() {
    echo "Server Performance Stats:"
    echo
    get_total_cpu_usage
    echo
    get_total_memory_usage
    echo
    get_disk_usage
    echo
    get_top_process_cpu
    echo
    get_top_process_memory
    echo
    get_os_version
    echo
    get_uptime
    echo
    get_load_average
    echo
    get_logged_users
    echo
    get_failed_logins
}

main