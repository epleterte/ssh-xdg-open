#!/bin/bash -ue
# very simple installer for ssh-handler

# defaults
prefix=~/.local

function print_usage() {
  cat <<EOF
Usage: ${0} [-h|-p <prefix]
  -h  This.
  -p  Install prefix. Defaults to ${prefix}
EOF
}

while getopts hp o
do
  case $o in
    h)
      print_usage ; exit ;;
    p)
      prefix="$OPTARG" ;;
  esac
done
shift $(($OPTIND-1))

destdir=${prefix}/share/applications

[ -d "${destdir}" ] || mkdir -p "${destdir}"

echo ">> Installing ssh.desktop to ${destdir}/"
cp -i ssh.desktop "${destdir}/"

echo ">> Installing mimeapps.list to ${destdir}/"
if [ -f "${destdir}/mimeapps.list" ]
then
  if $(grep -q 'x-scheme-handler/ssh=ssh.desktop' ${destdir}/mimeapps.list )
  then
    echo ">>> ${destdir} appears to be set up already"
  elif $(grep -q 'Desktop Applications' ${destdir}/mimeapps.list)
  then
    sed 1d mimeapps.list >> "${destdir}/mimeapps.list"
  else
    # meh
    cat mimeapps.list >> "${destdir}/mimeapps.list"
  fi
else
  cp -i mimeapps.list "${destdir}/"
fi

echo

h_installed="false"
for h in ssh-handler*
do
  while [ "${h_installed}" == "false" ];
  do
    read -p ">> Would you like me to install ${h} to ~/bin/ssh-handler ? [y|n] "
    if [ "$REPLY" == "y" ]
    then
      cp -i ${h} ~/bin/ssh-handler && chmod +x ~/bin/ssh-handler
      h_installed="true"
    elif [ "$REPLY" == "n" ]
    then
      break
    fi
  done
done

echo
echo "All done! Baby, I'm ready to go!"
