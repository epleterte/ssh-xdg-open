#!/bin/bash -ue

prefix=~/.local/
destdir=${prefix}/share/applications

[ -d "${destdir}" ] || mkdir -p "${destdir}"

cp ssh.desktop "${destdir}/"
if [ -f "${destdir}/mimeapps.list" ]
then
  if $(grep -q 'x-scheme-handler/ssh=ssh.desktop' ${destdir}/mimeapps.list )
  then
    echo "${destdir} appears to be set up already"
  elif $(grep -q 'Desktop Applications' ${destdir}/mimeapps.list)
  then
    sed 1d mimeapps.list >> "${destdir}/mimeapps.list"
  else
    # meh
    cat mimeapps.list >> "${destdir}/mimeapps.list"
  fi
else
  cp mimeapps.list "${destdir}/"
fi
