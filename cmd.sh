find . -maxdepth 1 -iname "*.png" | xargs -L1 -I{} convert -resize 20% "{}" "{}"_p
