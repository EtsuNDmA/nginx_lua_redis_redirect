redis-server --daemonize yes
cat redirects.txt | redis-cli --pipe
echo "Press [CTRL+C] to stop.."
while :
do
	sleep 1
done