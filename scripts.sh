cd img
mkdir resized
find . -maxdepth 1 -iname "*.png" | xargs -L1 -I{} convert -resize 22% "{}" resized/"{}"
