function setup {
    MC_DIR=/aegis-HEAD
    WEB_DIR=/web

    # website
    cd "${WEB_DIR}"
    killall busybox
    markdown index.md > index.html
    nohup busybox httpd -f -p 80 &!
    ln "${MC_DIR}"/whitelist.json "${WEB_DIR}"/whitelist.json

    # python
    cd "${MC_DIR}"
    killall python
    killall python3
    ln "${WEB_DIR}"/minecraft_log_dm.py "${MC_DIR}"/minecraft_log_dm.py
    ln "${WEB_DIR}"/config.json "${MC_DIR}"/config.json
    python3 minecraft_log_dm.py &!

    # Minecraft
    cd "${MC_DIR}"
    java -jar *.jar
}

setup
