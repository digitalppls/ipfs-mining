echo "remove launched container";
docker rm ipfs -f;
echo "remove cache";
rm -rf data;
mkdir data;
export ipfs_staging=$(cd "$(dirname "$1")"; pwd)/$(basename "$1")nft
export ipfs_data=$(cd "$(dirname "$1")"; pwd)/$(basename "$1")data

echo "KILL IPFS OLD SERVER"
docker stop ipfs/kubo:latest && docker rm ipfs/kubo:latest && docker image rm ipfs/kubo:latest

echo "\n\nRUN"
docker run -d --restart always --name ipfs -v $ipfs_staging:/export -v $ipfs_data:/data/ipfs -p 127.0.0.1:5001:5001  -p 127.0.0.1:8080:8080 ipfs/kubo:latest
sleep 5;
echo "\n\nADD IMAGES FILES"
docker exec ipfs ipfs add -r export/images
sleep 1;
echo "\n\nADD VIDEO FILES"
docker exec ipfs ipfs add -r export/video
sleep 1;
echo "\n\nADD JSON FILES"
docker exec ipfs ipfs add -r export/json
sleep 1;
echo "\n\nADD TEST IMAGES FILES"
docker exec ipfs ipfs add -r export/images_testnet
sleep 1;
echo "\n\nADD JSON TESTNET FILES"
docker exec ipfs ipfs add -r export/json_testnet
sleep 1;
echo "\n\nLIST PINED FOLDERS"
docker exec ipfs ipfs pin ls --type recursive
sleep 1;
