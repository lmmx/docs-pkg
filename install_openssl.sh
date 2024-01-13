yum install -y gcc make perl wget && \
OPENSSL_VERSION='openssl-1.1.1m' && \
wget https://www.openssl.org/source/${OPENSSL_VERSION}.tar.gz && \
tar -xzf ${OPENSSL_VERSION}.tar.gz && \
cd ${OPENSSL_VERSION} && \
./config --prefix=$HOME/openssl --openssldir=$HOME/openssl shared zlib && \
make 2>&1 > /dev/null && \
make install 2>&1 > /dev/null && \
which openssl && \
rm $(which openssl) && \
ln -s $HOME/openssl/bin/openssl /usr/bin/openssl && \
which openssl && \
openssl version
