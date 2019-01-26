git clone https://github.com/ruanyf/fortunes.git ~/.local/src/fortunes
if [ $(uname) = "Darwin" ]; then
    strfile fortunes/data/fortunes
    strfile fortunes/data/chinese
    strfile fortunes/data/tang300
    strfile fortunes/data/song100
    strfile fortunes/data/diet
fi
