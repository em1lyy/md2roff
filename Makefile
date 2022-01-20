#
#	GNU make
# 
PREFIX = /usr/local
MANDIR = $(shell test -d $(PREFIX)/share/man && echo $(PREFIX)/share/man || echo $(PREFIX)/man)
LIBS   = -lc 
CFLAGS = -std=c99

all: md2roff md2roff.1.gz

md2roff: md2roff.c
	$(CC) $(CFLAGS) md2roff.c -o md2roff $(LDFLAGS) $(LIBS)

md2roff.1.gz: md2roff.md md2roff
	./md2roff --synopsis-style=1 md2roff.md > md2roff.1
	-groff md2roff.1 -Tpdf -man -P -e > md2roff.1.pdf
	gzip -f md2roff.1

install: md2roff md2roff.1.gz
	install -m 0755 -s md2roff $(DESTDIR)$(PREFIX)/bin/
	install -m 0644 md2roff.1.gz $(DESTDIR)$(MANDIR)/man1/

uninstall:
	-@rm $(DESTDIR)$(PREFIX)/bin/md2roff
	-@rm $(DESTDIR)$(MANDIR)/man1/md2roff.1.gz

clean:
	-@rm *.o md2roff md2roff.1*

