
source ../utilities.nu
depend gpg

# DankLinux repository
curl -fsSL https://download.opensuse.org/repositories/home:AvengeMedia:danklinux/Debian_13/Release.key | sudo gpg --dearmor -o /etc/apt/keyrings/danklinux.gpg
echo "deb [signed-by=/etc/apt/keyrings/danklinux.gpg] https://download.opensuse.org/repositories/home:/AvengeMedia:/danklinux/Debian_13/ /" | sudo tee /etc/apt/sources.list.d/danklinux.list

# DMS stable repository
curl -fsSL https://download.opensuse.org/repositories/home:/AvengeMedia:/dms/Debian_13/Release.key | sudo gpg --dearmor -o /etc/apt/keyrings/avengemedia-dms.gpg
echo "deb [signed-by=/etc/apt/keyrings/avengemedia-dms.gpg] https://download.opensuse.org/repositories/home:/AvengeMedia:/dms/Debian_13/ /" | sudo tee /etc/apt/sources.list.d/avengemedia-dms.list

# DMS development repository
curl -fsSL https://download.opensuse.org/repositories/home:/AvengeMedia:/dms-git/Debian_13/Release.key | sudo gpg --dearmor -o /etc/apt/keyrings/avengemedia-dms-git.gpg
echo "deb [signed-by=/etc/apt/keyrings/avengemedia-dms-git.gpg] https://download.opensuse.org/repositories/home:/AvengeMedia:/dms-git/Debian_13/ /" | sudo tee /etc/apt/sources.list.d/avengemedia-dms-git.list
sudo apt update

sudo apt install --yes dms

"1\n3\n1\ny" | save /tmp/choices.txt
bash -c "dms setup < /tmp/choices.txt"
