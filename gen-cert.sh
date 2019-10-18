

#!/bin/bash

# self-signed key generation for registry
# 生成服务器私钥
openssl genrsa -out ./certs/registry-selfsigned.key 2048
# 生成证书签名请求（CSR）
openssl req -new -key ./certs/registry-selfsigned.key -out ./certs/registry-selfsigned.csr \
	-subj "/C=CN/ST=GD/L=SZ/O=vihoo/OU=dev/CN=registry/emailAddress=yy@vivo.com"
# 设置别名，可设置多个
echo subjectAltName = IP:192.168.5.118 > ./certs/extfile.cnf
# 使用上一步的证书签名请求签发证书
openssl x509 -req -sha256 -days 365 \
	-in ./certs/registry-selfsigned.csr \
	-signkey ./certs/registry-selfsigned.key \
	-extfile ./certs/extfile.cnf \
	-out ./certs/registry-selfsigned.crt


# self-signed key generation for registry-frontend
openssl genrsa -out ./frontend/certs/frontend.key 2048

openssl req -new -key ./frontend/certs/frontend.key -out ./frontend/certs/frontend.csr \
	-subj "/C=CN/ST=GD/L=SZ/O=vihoo/OU=dev/CN=localhost/emailAddress=yy@vivo.com"
echo subjectAltName = IP:192.168.5.118 > ./frontend/certs/extfile.cnf

openssl x509 -req -sha256 -days 365 \
        -in ./frontend/certs/frontend.csr \
        -signkey ./frontend/certs/frontend.key \
        -extfile ./frontend/certs/extfile.cnf \
        -out ./frontend/certs/frontend.crt

./startup.sh
