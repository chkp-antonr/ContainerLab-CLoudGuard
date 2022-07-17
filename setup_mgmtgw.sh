#!/bin/bash
ssh -tt admin@172.20.20.100  <<'EOF'
lock database override
set user admin password-hash $1$Ynf5sP0g$ounsUG9IP.n0OKd/NYoYq/
set user admin shell /bin/bash
set expert-password-hash $1$Ynf5sP0g$ounsUG9IP.n0OKd/NYoYq/
set interface eth1 ipv4-address 10.10.1.100 mask-length 24
set interface eth1 state on
set interface eth2 ipv4-address 10.10.10.100 mask-length 24
set interface eth2 state on
set static-route 10.10.2.0/24 nexthop gateway address 10.10.10.101 on
save config
exit
EOF


# Now start to EXPERT mode
ssh -tt admin@172.20.20.100  <<'EOF'
echo "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDiGNsQq6pJuXBAcf7Iq/Fl2zTkSI6SFtuZEGckGQNI6VLi8l5qGuhTlMmDN8XbdkRPHuGHEqWflPV/OpJsU4ioCC4fpxCaPZ40cKLHHZLNtENP8sGHXQhlcZcGQBPGRIyg3llO8NYn/ooVm6fHKKwOtzLzirHKPEptw0LgdJcWb4N2PnYKsygi0IKFdf6jWTww6SW4Zc0iSo2yc8ZAw+Fu6wyWM/rTyeLfjpG8VRzgQ6Mm/sZaI1qzU9ms2wLZsyy4aHPR/kBfNyiCHq9NjgGJEpMwNaYsN08AL5mmjK08blb8OEY4Cl/9Ln/Nw6vr7DdBLFUyJUq6N/o33HEgG7Qr cparch\antonr@rtWin" > /home/admin/.ssh/authorized_keys
chmod 644 /home/admin/.ssh/authorized_keys
config_system -s "mgmt_admin_name=antonr&mgmt_admin_passwd=vpn123&mgmt_gui_clients_radio=any&install_security_managment=true&install_security_gw=true&install_mgmt_primary=true&install_mgmt_secondary=false&domainname=il.cparch.in"
exit
EOF

sleep 30

# Check RSA key auth
ssh -tt admin@172.20.20.100  <<EOF
for i in 0 1 2 do
    clish -c "show interface eth${i}"
done
exit
EOF
