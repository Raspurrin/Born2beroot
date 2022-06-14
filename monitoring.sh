ARCH=$(uname -a)
PROC=`nproc`
VPROC=`cat /proc/cpuinfo | grep processor | wc -l`
RAM_AVAIL=`free --mega | grep Mem | awk '{print $7}'`
RAM_UTIL=`free -m | grep Mem | awk '{printf "%.2f", $3/$2*100}'`
RAM=`free -m | grep Mem | awk '{print $7}'`
MEM_TOTAL=`cat /proc/meminfo | grep 'MemTotal:' | awk '{print $2}'`
MEM_UTIL=`df -BM | grep '/dev/mapper' | awk '{util += $3} {total+= $2} END {printf"%.2f", util/total*100}'`
CPU_UTIL=`mpstat | grep 'all' | awk '{print 100 - $12}'`
LVMSTATUS=`if [ $(lsblk | grep -c "lvm") -eq 0 ]; then echo 
"no"; else echo "yes"; fi` 
CONNECTIONS=`who | wc -l`
IP=`hostname -I`
MAC=`ip a | grep "ether" | awk '{print $2'`
SUDO=`grep sudo /var/log/auth.log | awk 'NR%2==0' | wc -l`
INFOL=`screenfetch -L | tail -n5`
declare -A INFO

for i in {1..16}
do
    INFO[$i]="`screenfetch -L | sed -n $i'p'`"
done

wall "
                                  Architecture:    $ARCH
${INFO[1]}    Virtual cores:           $PROC
${INFO[2]}    Physical cores:          $VPROC
${INFO[3]}    Available RAM:           $RAM_AVAIL MB
${INFO[4]}    Utilization RAM:         $RAM_UTIL %
${INFO[5]}    Available Memory:        $MEM_TOTAL kB
${INFO[6]}    Utilization Memory:      $MEM_UTIL %
${INFO[7]}    Utilization processor:   $CPU_UTIL
${INFO[8]}    Whether LVM is active:   $LVMSTATUS
${INFO[9]}    Amount of connections:   $CONNECTIONS
${INFO[10]}   IP address:              $IP
${INFO[11]}   MAC address:             $MAC
${INFO[12]}   Amount of sudo usage:    $SUDO
$INFOL"
