for f in nft/images/**/*.jpg
 do
        ffmpeg -i $f -q:v 10 $f -y
done