IUSE="encode mp2 oggvorbis aac alsa jack"

DESCRIPTION="IceCast live streamer delivering Ogg, mp3, mp2 or aac streams simultaneously to multiple hosts."
HOMEPAGE="http://darkice.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
RESTRICT="nomirror"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc ~sparc ~alpha ~hppa ~amd64"

DEPEND="encode?	( >=media-sound/lame-3.89 )
        mp2? ( >=media-sound/twolame-0.3.6 )
        oggvorbis? ( >=media-libs/libvorbis-1.0 )
		aac? ( >=media-libs/faac-1.24 )
        alsa? ( >=media-libs/alsa-lib-1.0.0 )
        jack? ( media-sound/jack-audio-connection-kit )"

src_compile() {
	if ! use encode && ! use mp2 && ! use oggvorbis && ! use aac
	then

		eerror "You need support for mp3, Ogg Vorbis or FAAC enconding for this"
		eerror "package. Please merge again with at least one of the "
		eerror "\`encode', \'mp2', \`oggvorbis' or \'aac' USE flags enabled:"
		eerror
		eerror "  # USE=\"encode\" emerge darkice"
		eerror "  # USE=\"mp2\" emerge darkice"
		eerror "  # USE=\"oggvorbis\" emerge darkice"
		eerror "  # USE=\"aac\" emerge darkice"
		die "Won't build without support for lame, mp2, vorbis or aac"
	fi

	econf `use_with alsa` \
	      `use_with encode lame` \
	      `use_with mp2 twolame` \
	      `use_with oggvorbis vorbis` \
	      `use_with aac faac` \
		  `use_with jack` || die

	emake || die "Compilation failed"
}

src_install() {
	einstall darkicedocdir=${D}/usr/share/doc/${PF} || die

	dodoc AUTHORS ChangeLog COPYING NEWS README TODO
}
