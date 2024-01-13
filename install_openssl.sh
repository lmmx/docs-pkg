yum install -y gcc make perl wget && \
OPENSSL_VERSION='openssl-1.1.1m' && \
wget https://www.openssl.org/source/${OPENSSL_VERSION}.tar.gz && \
tar -xzf ${OPENSSL_VERSION}.tar.gz && \
cd ${OPENSSL_VERSION} && \
./config --prefix=$HOME/openssl --openssldir=$HOME/openssl shared zlib && \
make && \
make install && \
openssl version
