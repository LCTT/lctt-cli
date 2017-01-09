#!/bin/bash
echo -n "Please enter the Tables$(echo -e "\033[37;31;5m Need \"-t\" \033[39;49;0m"): "
read Table
Table="$Table"
echo "iptables $Table"

echo -n "Please enter the Chain :"
read Chain
echo "iptables $Table $(echo -e "\033[37;31;5mNext Query\033[39;49;0m") $Chain"

echo -n "Please enter the Parameter: "
read B_Chain
echo "iptables $Table $B_Chain $Chain "

echo -n "Please enter the Number: "
read Number
echo "iptables $Table $B_Chain  $Chain $Number"

echo -n "Please enter the Protocol: "
read protocol
protocol="-p $protocol"
echo "iptables $Table $B_Chain  $Chain $Number $protocol"

echo -n "Please enter the Protocol_type: "
read Protocol_type
echo "iptables $Table $B_Chain  $Chain $Number $protocol $Protocol_type"

echo -n "Please enter the Protocol_type_Other: "
read Protocol_type_Other
echo $Protocol_type_Other
echo "iptables $Table $B_Chain  $Chain $Number $protocol $Protocol_type_Other"

echo -n "Please enter the Allow_IP$(echo -e "\033[37;31;5m Need \"-s\" or \"-d\" \033[39;49;0m"): "
read Allow_IP
echo "iptables $Table $B_Chain  $Chain $Number $protocol $Protocol_type_Other $Allow_IP"

echo -n "Please enter the Source_Port$(echo -e "\033[37;31;5m Need \"--sport\" \033[39;49;0m"): "
read Source_Port
echo "iptables $Table $B_Chain  $Chain $Number $protocol $Protocol_type_Other $Allow_IP $Source_Port"

echo -n "Please enter the Destination_Port:$(echo -e "\033[37;31;5m Need \"--dport\" \033[39;49;0m"): "
read Destination_Port
echo "iptables $Table $B_Chain  $Chain $Number $protocol $Protocol_type_Other $Allow_IP $Source_Port $Destination_Port"

echo -e "\e[1;31mThe Others: \e[0m"
read The_Others
echo "iptables $Table $B_Chain  $Chain $Number $protocol $Protocol_type_Other $Allow_IP $Source_Port $Destination_Port $The_Others"

echo -e "Please enter the Action: "
read Action
Action="-j $Action"
echo "iptables $Table $B_Chain  $Chain $Number $protocol $Protocol_type_Other $Allow_IP $Source_Port $Destination_Port $The_Others $(echo -e "\e[1;31m $Action \e[0m")"
