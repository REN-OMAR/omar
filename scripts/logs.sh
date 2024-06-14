trap "exit" INT TERM ERR
trap "kill 0" EXIT

heroku logs -n 10 -d web -t -a sdbsto --force-colors &
sleep 3
PID=$(ps axf | grep "/c/Program Files/heroku/client/bin/heroku.cmd" | grep -v grep | awk '{printf $1}')
START_TIME=$(cut -d ' ' -f 22 /proc/$PID/stat)
last_modified_time=$(stat -c "%Y" /proc/${PID})
#find /proc -maxdepth 1 -name  -type d -mmin +5
/d/dev/sdb/sto/sto-heroku/scripts/dbBU.sh &
i=0
while [ "$(cut -d ' ' -f 22 /proc/$PID/stat 2>/dev/null)" = "$START_TIME" ]; do
	i=$((i + 1))
	[ "$(($(date +%s) - $(stat -L --format %Y /proc/${PID})))" -gt "$((20 * 60))" ] && echo "$PID ####################$i" || echo "$PID wait more###$i"
	if [ "$(($(date +%s) - $(stat -L --format %Y /proc/${PID})))" -gt "$((20 * 60))" ]; then
		if [ -n "$PID" -a -e /proc/$PID ]; then
			kill -15 $PID
			sleep 1 # echo "PROCESS IS RUNNING $PID"
		fi
		if [ -n "$PID" -a -e /proc/$PID ]; then
			kill -9 $PID
			sleep 1 # echo "PROCESS IS RUNNING $PID"
		fi
		echo "PROCESS TERMINATED $PID"
		# ps
		heroku logs -n 10 -d web -t -a sdbsto --force-colors &
		sleep 3
		PID=$(ps axf | grep "/c/Program Files/heroku/client/bin/heroku.cmd" | grep -v grep | awk '{printf $1}')
		START_TIME=$(cut -d ' ' -f 22 /proc/$PID/stat)
		last_modified_time=$(stat -c "%Y" /proc/${PID})
		i=0
	fi
	# echo "PROCESS IS RUNNING $PID $START_TIME"
	# ls -al /proc/$PID
	# cat /proc/$PID/stat
	sleep 60
done

echo "PROCESS TERMINATED $PID"

wait
echo 'All background processes have exited.'

# pause
# Usage: heroku logs [flags]

# display recent log output

# Flags:
# -a, --app APP        app to run command against
# -d, --dyno DYNO      dyno to limit filter by
# -n, --num NUM        number of lines to display
# -r, --remote REMOTE  git remote of app to use
# -s, --source SOURCE  log source to limit filter by
# -t, --tail           continually stream logs
# --force-colors       force use of colors (even on non-tty output)

# Example:

# $ heroku logs
# 2012-01-01T12:00:00+00:00 heroku[api]: Config add EXAMPLE by email@example.com
# 2012-01-01T12:00:01+00:00 heroku[api]: Release v1 created by email@example.com
