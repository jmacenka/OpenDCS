docker-compose up -d --build --force-recreate
echo "Creating new database: BW"
curl -XPOST 'http://localhost:8086/query' --data-urlencode "q=CREATE DATABASE BW"
echo "All Done."