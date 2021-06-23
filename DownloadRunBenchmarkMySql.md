#!/bin/sh

# Downloads and runs the DBT2 benchmark for MySQL.
# ================================================
#
# Tested with MySQL 8.0.17 - CentOS 8 - 2020-09-14
# Tested with MySQL 8.0.21 - Fedora 32 - 2020-09-14
#
# On a bare metal server, Xeon E5-1650v4 6x (12x HT) 3.60GHz, 64GB DDR4 2666, NVMe drive, with:
#  - innodb_buffer_pool_size = 32GB
#  - innodb_log_file_size = 1G
# I'm getting:
#  > 91161 new-order transactions per minute (NOTPM) 
#
# Doing better? Please let me know your setup & NOTPM score in the comments!
#
# INSTRUCTIONS - Before running this script:
# ------------------------------------------
#
# - edit this script with your MySQL hostname & credentials
#
# - install required packages:
#   $ sudo yum install -y wget gcc make autoconf mysql-devel
#
# - add these directives to my.cnf:
#   [client]
#   local-infile = 1
#
#   [server]
#   local-infile = 1
#
# - restart your MySQL server

set -e

host='127.0.0.1'
user='root'
pass=''

mysql_path=$(which mysql)
mysql_dir_path=$(dirname $mysql_path)

log() {
  echo
  echo -e "\e[37;42m$1\e[0m"
}

# Clean up previous builds
rm -rf /tmp/dbt2

# Set up working directories
mkdir -p /tmp/dbt2/data

log 'Downloading...'
wget -q -O - http://downloads.mysql.com/source/dbt2-0.37.50.15.tar.gz | tar xvz -C /tmp/dbt2

# Go to the directory extracted
cd /tmp/dbt2/dbt2-0.37.50.15

# Fix a non-nullable parameter
search='ol_delivery_d timestamp NOT NULL'
replace='ol_delivery_d timestamp NULL'
sed -i "s/$search/$replace/g" scripts/mysql/mysql_load_db.sh

log 'Configuring...'
./configure --with-mysql

log 'Compiling...'
make

log 'Generating the data files...'
src/datagen -w 30 -d /tmp/dbt2/data --mysql

# Convert customer data to UTF-8 (utf8mb4 is the default in MySQL 8.0)
log 'Converting to UTF-8...'

for filename in `find /tmp/dbt2/data -type f -name *.data`; do
    echo $filename
    mv $filename $filename.bak
    iconv -f ISO-8859-1 -t UTF-8 $filename.bak -o $filename
    rm $filename.bak
done

log 'Loading the data into the database...'
scripts/mysql/mysql_load_db.sh \
  --path /tmp/dbt2/data \
  --local \
  --mysql-path "$mysql_path" \
  --host "$host" \
  --user "$user" \
  --password "$pass"

log 'Loading the stored procedures...'
scripts/mysql/mysql_load_sp.sh \
  --client-path "$mysql_dir_path" \
  --sp-path storedproc/mysql \
  --host "$host" \
  --user "$user" \
  --password "$pass"

log 'Running the benchmark...'
scripts/run_mysql.sh \
  --connections 20 \
  --time 300 \
  --warehouses 30 \
  --zero-delay \
  --host "$host" \
  --user "$user" \
  --password "$pass"

# Clean up
rm -rf /tmp/dbt2