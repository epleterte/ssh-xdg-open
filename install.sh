#!/bin/bash -ue

prefix=~/.local/
destdir=${prefix}/share/applications

[ -d "${destdir}" ] || mkdir -p "${destdir}"

cp ssh.desktop "${destdir}/"
if [ -f "${destdir}/mimeapps.list" ]
then
  sed 1d mimeapps.list >> "${destdir}/mimeapps.list"
else
  cp mimeapps.list "${destdir}/"
fi
