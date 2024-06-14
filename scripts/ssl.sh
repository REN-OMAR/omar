echo "Script executed from: ${PWD}"

cd $(dirname $0) && cd ..
echo "Script executed from: ${PWD}"
mkdir -p ssl
openssl req -newkey rsa:4096 -x509 -new -nodes -keyout ./ssl/key.pem -out ./ssl/cert.pem -days 365