#!/bin/bash -ue

destdir=~/.local/share/applications

[ -d "${destdir}" ] || mkdir -p "${destdir}"

cp ssh.desktop "${destdir}/"
[ -f "${destdir}/mimeapps.list" ] && sed 1d mimeapps.list >> "${destdir}/mimeapps.list" \
  [ -f "${destdir}/mimeapps.list" ] || cp mimeapps.list "${destdir}/"

