#!/bin/sh

/usr/bin/tigervncserver :1 -geometry 1600x1200 -xstartup /usr/bin/firefox && \
/usr/bin/websockify --log-file=/var/log/websockify.log --web=/usr/share/novnc/ 80 localhost:5901
