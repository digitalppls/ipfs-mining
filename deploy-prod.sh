SERVER="ipfsserver"
FOLDER="/www/ipfs"

echo "SERVER $SERVER";
echo "FOLDER $FOLDER";

tar czf ipfs.tar.gz nft start.sh logs.sh



echo "UPDLOAD"
rsync -ah --progress  ipfs.tar.gz root@$SERVER:$FOLDER

echo "EXTRACT"
ssh -tt root@$SERVER << EOF
 cd $FOLDER;
 tar -zxvf ipfs.tar.gz;
 rm ipfs.tar.gz;
 sh start.sh;
EOF
rm -rf ipfs.tar.gz



