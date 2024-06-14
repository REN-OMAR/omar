# Define a timestamp function
timestamp() {
	date +"%T" # current time
	date +"%s"
}

trap "exit" INT TERM ERR
trap "kill 0" EXIT

sleep 2 &
sleep 1 &

wait

# ls -alh /proc
find /proc -maxdepth 1 -regex '/proc/[0-9]*' -type d -mmin +5
sleep 10 &
PROC_ID=$!
# do something...
timestamp # print timestamp
PID=$PROC_ID
START_TIME=$(cut -d ' ' -f 22 /proc/$PID/stat)

while [ "$(cut -d ' ' -f 22 /proc/$PID/stat 2>/dev/null)" = "$START_TIME" ]; do
	# echo "PROCESS IS RUNNING $PROC_ID $START_TIME"
	# ls -al /proc/$PID
	# cat /proc/$PID/stat
	sleep 1
done

sleep 10 &
PROC_ID=$!

while kill -0 "$PROC_ID" >/dev/null 2>&1; do
	sleep 1 # echo "PROCESS IS RUNNING $PROC_ID"
done
echo "PROCESS TERMINATED $PROC_ID"

sleep 1 &
PID1=$!
sleep 2 &
PID2=$!

echo "PID1: $PID1"
echo "PID2: $PID2"

ps

wait $PID1
echo 'PID1 has ended.'
wait
echo 'All background processes have exited.'
