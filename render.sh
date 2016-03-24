

docker-compose up -d postgis

cd import 
wget http://download.geofabrik.de/asia/japan-latest.osm.pbf

cd ..

date
docker-compose up import-osm

date
docker-compose up import-water

date
docker-compose up import-natural-earth

date
docker-compose up import-labels

date
docker-compose up import-sql

date
docker-compose up update-scaleranks

date
docker-compose up export


