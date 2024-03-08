#!/usr/bin/env bash

##ssh-keygen -f "/home/richard/.ssh/known_hosts" -R "44.210.236.121"
#ssh -i /home/richard/.ssh/gdal_install.pem ec2-user@44.210.236.121 -o "ServerAliveInterval 60"

sudo yum -y install cmake gcc gcc-c++ binutils libcurl-devel sqlite sqlite-devel libtiff libtiff-devel

# S3cmd
sudo wget https://liquidtelecom.dl.sourceforge.net/project/s3tools/s3cmd/2.4.0/s3cmd-2.4.0.tar.gz
sudo tar xzf s3cmd-2.4.0.tar.gz
cd s3cmd-2.4.0
sudo python3 setup.py install

# Geos
cd /
sudo mkdir -p /usr/local/geos
cd usr/local/geos
sudo wget -O geos-3.12.1.tar.bz2 https://download.osgeo.org/geos/geos-3.12.1.tar.bz2
sudo tar -xjf geos-3.12.1.tar.bz2
cd geos-3.12.1
sudo mkdir build
cd build
sudo cmake -DCMAKE_BUILD_TYPE=Release ..
sudo cmake --build .
sudo cmake --build . --target install
sudo ldconfig
cd /usr/local/geos
sudo rm -f geos-3.12.1.tar.bz2
tar zcvf "/tmp/geos-3.12.1.tar.gz" *
s3cmd put "/tmp/geos-3.12.1.tar.gz" s3://gdal-binaries/dir/

# Proj4
cd /
sudo mkdir -p /usr/local/proj4
cd usr/local/proj4
sudo wget -O proj-9.3.1.tar.gz http://download.osgeo.org/proj/proj-9.3.1.tar.gz
sudo wget -O proj-data-1.16.tar.gz http://download.osgeo.org/proj/proj-data-1.16.tar.gz
sudo tar xzf proj-9.3.1.tar.gz
cd proj-9.3.1/data
sudo tar xzf ../../proj-data-1.16.tar.gz
cd ../..
cd proj-9.3.1
sudo mkdir build
cd build
sudo cmake ..
sudo cmake -DCMAKE_PREFIX_PATH=/opt/SQLite ..
sudo cmake --build .
sudo cmake --build . --target install
sudo ldconfig
cd /usr/local/proj4
sudo rm -f proj-9.3.1.tar.gz
sudo rm -f proj-data-1.16.tar.gz
tar zcvf "/tmp/proj4-9.3.1.tar.gz" *
s3cmd put "/tmp/proj4-9.3.1.tar.gz" s3://gdal-binaries/dir/

# GDAL
cd /
sudo mkdir -p /usr/local/gdal
cd usr/local/gdal
sudo wget -O gdal-3.7.3.tar.gz https://download.osgeo.org/gdal/3.7.3/gdal-3.7.3.tar.gz
sudo tar xzf gdal-3.7.3.tar.gz
cd gdal-3.7.3
sudo mkdir build
cd build
sudo cmake -DCMAKE_BUILD_TYPE=Release ..
sudo cmake --build .
sudo cmake --build . --target install
sudo ldconfig
cd /usr/local/gdal
sudo rm -f gdal-3.7.3.tar.gz
tar zcvf "/tmp/gdal-3.7.3.tar.gz" *
s3cmd put "/tmp/gdal-3.7.3.tar.gz" s3://gdal-binaries/dir/
