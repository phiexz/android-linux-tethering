# Linux <-> Android Reverse Tethering Script
# This script tether the internet from your PC *to* the phone
# Some apps will not recognize the connection

# See http://ajasmin.wordpress.com/2011/07/24/android-usb-tethering-with-a-linux-pc/

# Path to ADB
export ADB=/opt/android-sdk/platform-tools/adb

if [ $USER != "root" ]; then
	echo "Please run this script as root"
	exit
fi

echo "Enabling NAT on `hostname`..."
echo 1 > /proc/sys/net/ipv4/ip_forward
iptables -t nat -F
iptables -t nat -A POSTROUTING -j MASQUERADE

echo "Connecting to the phone via 'adb ppp'..."
$ADB ppp "shell:pppd nodetach noauth noipdefault defaultroute /dev/tty" nodetach noauth noipdefault notty 10.0.0.1:10.0.0.2

echo "Done."

