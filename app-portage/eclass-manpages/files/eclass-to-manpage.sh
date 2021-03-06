#!/bin/bash

: ${PORTDIR:=/usr/portage}
: ${ECLASSDIR:=${0%/*}/../../../eclass}
: ${FILESDIR:=${ECLASSDIR}/../app-portage/eclass-manpages/files}

while [[ $# -gt 0 ]] ; do
	case $1 in
	-e) ECLASSDIR=$2; shift;;
	-f) FILESDIR=$2; shift;;
	*) break;;
	esac
	shift
done

if [[ ! -d ${ECLASSDIR} ]] ; then
	echo "Usage: ${0##*/} [-e eclassdir] [-f eclass-to-manpage.awk FILESDIR] [eclasses]" 1>&2
	exit 1
fi

[[ $# -eq 0 ]] && set -- "${ECLASSDIR}"/*.eclass

for e in "$@" ; do
	gawk \
		-vPORTDIR="${PORTDIR}" \
		-f "${FILESDIR}"/eclass-to-manpage.awk \
		${e} > ${e##*/}.5 || rm -f ${e##*/}.5
done
