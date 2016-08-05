#/bin/bash
yum install automake libtool flex bison pkgconfig gcc-c++ boost-devel libevent-devel zlib-devel python-devel ruby-devel openssl-devel lbzip2

cd /usr/local/src
wget http://archive.apache.org/dist/thrift/0.9.0/thrift-0.9.0.tar.gz  
tar zxvf thrift-0.9.0.tar.gz  
cd thrift-0.9.0 
 
./configure  
make  
make install 

thrift --version  

cd ./contrib/fb303/  
./bootstrap.sh   
./configure  
make  
make install  

cd ../../tutorial  
thrift -r -gen cpp tutorial.thrift 

echo "/usr/local/lib" >> /etc/ld.so.conf
/sbin/ldconfig

cd /usr/local/src/
wget http://nchc.dl.sourceforge.net/project/boost/boost/1.45.0/boost_1_45_0.tar.bz2
tar -xf boost_1_45_0.tar.bz2
cd boost_1_45_0
./bootstrap.sh --prefix=/usr/local/boost
./bjam -s HAVE_ICU=1 --prefix=/usr/local/boost --includedir=/usr/local/boost/include --libdir=/usr/local/boost/lib
./bjam --prefix=/usr/local/boost install
export BOOST_ROOT=/usr/local/boost
export LD_LIBRARY_PATH=/usr/local/boost/lib:/usr/lib:/usr/local/lib
echo "/usr/local/boost/lib/" >> /etc/ld.so.conf
/sbin/ldconfig

cd /usr/local/src/
wget https://github.com/facebookarchive/scribe/archive/master.zip
unzip master
cd scribe-master

./bootstrap.sh --with-boost-filesystem=boost_filesystem --prefix=/usr/local/scribe
./configure --with-boost-filesystem=boost_filesystem --prefix=/usr/local/scribe CPPFLAGS="-DHAVE_INTTYPES_H -DHAVE_NETINET_IN_H"

make
make install

cp /usr/local/src/scribe-master/examples/scribe_cat /usr/local/scribe/bin/
cp /usr/local/src/scribe-master/examples/scribe_ctrl /usr/local/scribe/bin/
mkdir -p /usr/local/scribe/conf

export LD_LIBRARY_PATH=/usr/local/lib:/usr/lib
source /etc/profile