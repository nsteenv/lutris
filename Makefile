VERSION="0.3.5"

test:
	rm tests/fixtures/pga.db -f
	rm tests/coverage/ -rf
	nosetests --with-coverage --cover-package=lutris --cover-html --cover-html-dir=tests/coverage

deb-source:
	debuild -S

deb:
	git-buildpackage
	mv ../lutris_0* build

changelog-add:
	dch -i

changelog-edit:
	dch -e

upload-ppa:
	dput ppa:strycore/ppa ../lutris_${VERSION}_i386.changes

rpm:
	cd build && sudo alien lutris_${VERSION}_all.deb --scripts --to-rpm

clean:
	debclean

build-all: deb rpm

upload:
	scp build/lutris_${VERSION}_all.deb strycore.com:/srv/releases/lutris/
	scp build/lutris_${VERSION}.tar.gz strycore.com:/srv/releases/lutris/
	scp build/lutris-${VERSION}-2.noarch.rpm strycore.com:/srv/releases/lutris/
