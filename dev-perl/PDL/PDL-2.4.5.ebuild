# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/PDL/PDL-2.4.5.ebuild,v 1.4 2010/02/01 17:38:27 ssuominen Exp $

EAPI=2

MODULE_AUTHOR=CHM
inherit perl-module eutils multilib

DESCRIPTION="PDL Perl Module"

LICENSE="Artistic as-is"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~s390 ~sh ~sparc ~x86"
IUSE="badval fftw gsl opengl"

DEPEND=">=sys-libs/ncurses-5.2
	virtual/perl-Filter
	virtual/perl-File-Spec
	virtual/perl-PodParser
	dev-perl/Inline
	dev-perl/Astro-FITS-Header
	>=dev-perl/ExtUtils-F77-1.13
	virtual/perl-Text-Balanced
	opengl? ( virtual/opengl virtual/glu )
	dev-perl/Term-ReadLine-Perl
	gsl? ( sci-libs/gsl )
	fftw? ( sci-libs/fftw:2.1 )"

mydoc="DEPENDENCIES DEVELOPMENT MANIFEST* Release_Notes TODO"

#SRC_TEST="do"

src_prepare() {
	epatch "${FILESDIR}/PDL-2.4.2-makemakerfix.patch"

	# Unconditional -fPIC for the lib (#55238, #180807, #250335)
	epatch "${FILESDIR}/${PN}-2.4.4-PIC.patch"

	# TODO: everything in this function below this
	# TODO: line really belongs in src_compile() :

	# This 'fix' breaks compiles for non-opengl users
	#if ! use opengl ; then
	#	sed -e "s:WITH_3D => undef:WITH_3D => 0:" \
	#		${FILESDIR}/perldl.conf > ${S}/perldl.conf
	#fi

	if use badval ; then
		sed -i -e "s:WITH_BADVAL => 0:WITH_BADVAL => 1:" "${S}/perldl.conf"
	fi

	# Turn off GSL automagic:
	if use gsl ; then
		sed -i -e "s:WITH_GSL => undef:WITH_GSL => 1:" "${S}/perldl.conf"
	else
		sed -i -e "s:WITH_GSL => undef:WITH_GSL => 0:" "${S}/perldl.conf"
	fi
	# Turn off FFTW automagic too:
	if use fftw ; then
		sed -i -e "s:WITH_FFTW => undef:WITH_FFTW => 1:" "${S}/perldl.conf"
	else
		sed -i -e "s:WITH_FFTW => undef:WITH_FFTW => 0:" "${S}/perldl.conf"
	fi
}

src_install() {
	perl-module_src_install

	cp "${S}"/Doc/{scantree.pl,mkhtmldoc.pl} "${D}"/${VENDOR_ARCH}/PDL/Doc/ || die
}

pkg_postinst() {
	if [[ ${ROOT} = / ]] ; then
		perl ${VENDOR_ARCH}/PDL/Doc/scantree.pl
		elog "Building perldl.db done. You can recreate this at any time"
		elog "by running"
	else
		elog "You must create perldl.db by running"
	fi
	elog "perl ${VENDOR_ARCH}/PDL/Doc/scantree.pl"
	epause 3
	elog "PDL requires that glx and dri support be enabled in"
	elog "your X configuration for certain parts of the graphics"
	elog "engine to work. See your X's documentation for futher"
	elog "information."
}
