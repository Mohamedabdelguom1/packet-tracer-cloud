# Packet Tracer ships an Ubuntu 22.04 .deb, so stay on jammy.
FROM mcr.microsoft.com/devcontainers/base:jammy

ENV DEBIAN_FRONTEND=noninteractive

# Libraries Packet Tracer's bundled Qt needs, plus small desktop helpers
# (dialogs, a terminal, Arabic fonts for our messages).
RUN apt-get update && apt-get install -y --no-install-recommends \
        ca-certificates wget gnupg xterm zenity whiptail dbus-x11 xdg-utils \
        fonts-noto-core fonts-dejavu-core \
        libgl1 libgl1-mesa-glx libgl1-mesa-dri libegl1 libnss3 libasound2 \
        libxss1 libxkbcommon-x11-0 libxcb-xinerama0 libxcb-cursor0 \
        libxcb-icccm4 libxcb-image0 libxcb-keysyms1 libxcb-render-util0 \
        libxcb-shape0 libxcb-randr0 libxcb-xkb1 \
    && rm -rf /var/lib/apt/lists/*

# Firefox from Mozilla's own apt repo: Ubuntu's is a snap, and snaps do not
# run inside containers. Students use it to download Packet Tracer from
# NetAcad and to move lab files to and from the course site.
RUN install -d -m 0755 /etc/apt/keyrings \
    && wget -q https://packages.mozilla.org/apt/repo-signing-key.gpg \
         -O /etc/apt/keyrings/packages.mozilla.org.asc \
    && echo "deb [signed-by=/etc/apt/keyrings/packages.mozilla.org.asc] https://packages.mozilla.org/apt mozilla main" \
         > /etc/apt/sources.list.d/mozilla.list \
    && printf 'Package: *\nPin: origin packages.mozilla.org\nPin-Priority: 1000\n' \
         > /etc/apt/preferences.d/mozilla \
    && apt-get update && apt-get install -y --no-install-recommends firefox \
    && rm -rf /var/lib/apt/lists/*
