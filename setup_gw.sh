#!/bin/bash
IP=172.20.20.101

wait_ssh() {
    SSH_UP=0
    while [ $SSH_UP -eq 0 ]
    do
        nc -zvw10 $IP 22 && SSH_UP=1
    done
    echo "SSH UP"
}


wait_ssh


ssh -tt admin@$IP  <<'EOF'
lock database override
set user admin shell /bin/bash
set expert-password-hash $1$Ynf5sP0g$ounsUG9IP.n0OKd/NYoYq/
set interface eth1 ipv4-address 10.10.10.101 mask-length 24
set interface eth1 state on
set interface eth2 ipv4-address 10.10.2.101 mask-length 24
set interface eth2 state on
set static-route 10.10.1.0/24 nexthop gateway address 10.10.10.100 on
save config
exit
EOF


# Now start to EXPERT mode
ssh -tt admin@$IP  <<'EOF'
echo "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDiGNsQq6pJuXBAcf7Iq/Fl2zTkSI6SFtuZEGckGQNI6VLi8l5qGuhTlMmDN8XbdkRPHuGHEqWflPV/OpJsU4ioCC4fpxCaPZ40cKLHHZLNtENP8sGHXQhlcZcGQBPGRIyg3llO8NYn/ooVm6fHKKwOtzLzirHKPEptw0LgdJcWb4N2PnYKsygi0IKFdf6jWTww6SW4Zc0iSo2yc8ZAw+Fu6wyWM/rTyeLfjpG8VRzgQ6Mm/sZaI1qzU9ms2wLZsyy4aHPR/kBfNyiCHq9NjgGJEpMwNaYsN08AL5mmjK08blb8OEY4Cl/9Ln/Nw6vr7DdBLFUyJUq6N/o33HEgG7Qr cparch\antonr@rtWin" > /home/admin/.ssh/authorized_keys
chmod 644 /home/admin/.ssh/authorized_keys
config_system -s "hostname=cloudguard_gw1&ftw_sic_key=qwerty&install_security_managment=false&install_security_gw=true&gateway_daip=false&install_ppak=true&gateway_cluster_member=false&domainname=il.cparch.in"
exit
EOF

wait_ssh

# Check RSA key auth
ssh -tt admin@$IP  <<'EOF'
for I in 0 1 2
do
    echo " -= eth${I} =-"
    clish -c "show interface eth${I}"
    echo ""
done
free
while true
do
    date
    sleep 15
done
exit
EOF
