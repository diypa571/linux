#!/bin/bash
# Diypa571
WEBSITE="http://manpages.net"  # Replace with your web server URL
// Current value, 10 is for 10 seconds, change it as you wish...
INTERVAL=10  # Monitoring interval in seconds

while true; do
    # Check web server status
    response=$(curl -sL -w "%{http_code}" "$WEBSITE" -o /dev/null)

    if [ "$response" == "200" ]; then
        echo "$(date): Web server is UP"
    else
        echo "$(date): Web server is DOWN (HTTP response code: $response)"
    fi

    # Monitor system
    system_info=$(top -bn1 | grep "Cpu(s)" | awk '{print "CPU Usage: " $2 "%"}'; free -m | awk 'NR==2{print "Memory Usage: " $3 "MB"}')

    echo "$(date): $system_info"

    sleep $INTERVAL
done
