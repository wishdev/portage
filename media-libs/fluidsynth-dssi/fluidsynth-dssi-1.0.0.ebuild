# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/fluidsynth-dssi/fluidsynth-dssi-1.0.0.ebuild,v 1.3 2011/03/29 08:06:44 radhermit Exp $

EAPI=2

DESCRIPTION="DSSI Soft Synth Interface"
HOMEPAGE="http://dssi.sourceforge.net/"
SRC_URI="mirror://sourceforge/dssi/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc x86"
IUSE=""

RDEPEND=">=media-libs/dssi-0.9.0
	x11-libs/gtk+:2
	>=media-libs/liblo-0.12
	>=media-sound/fluidsynth-1.0.3"

DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc ChangeLog README TODO
}
