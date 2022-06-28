# See LICENSE file for copyright and license details
# slstatus - suckless status monitor
.POSIX:

include config.mk

REQ = util
COM =\
	components/datetime\
	components/run_command\
	components/seperator\
	components/temperature\
	components/battery_icon\
	# components/battery\
	# components/cpu\
	# components/disk\
	# components/entropy\
	# components/hostname\
	# components/ip\
	# components/kernel_release\
	# components/keyboard_indicators\
	# components/keymap\
	# components/load_avg\
	# components/netspeeds\
	# components/num_files\
	# components/ram\
	# components/swap\
	# components/uptime\
	# components/user\
	# components/volume\
	# components/wifi\

all: slstatus

$(COM:=.o): config.mk $(REQ:=.h)
slstatus.o: slstatus.c slstatus.h arg.h config.h theme.h config.mk $(REQ:=.h)

.c.o:
	$(CC) -o $@ -c $(CPPFLAGS) $(CFLAGS) $<

config.h:
	cp config.def.h $@

slstatus: slstatus.o $(COM:=.o) $(REQ:=.o)
	$(CC) -o $@ $(LDFLAGS) $(COM:=.o) $(REQ:=.o) slstatus.o $(LDLIBS)

clean:
	rm -f slstatus-sm slstatus.o $(COM:=.o) $(REQ:=.o)

dist:
	rm -rf "slstatus-sm-$(VERSION)"
	mkdir -p "slstatus-sm-$(VERSION)/components"
	cp -R LICENSE Makefile README config.mk config.def.h \
	      arg.h slstatus.c $(COM:=.c) $(REQ:=.c) $(REQ:=.h) \
	      slstatus.1 "slstatus-sm-$(VERSION)"
	tar -cf - "slstatus-sm-$(VERSION)" | gzip -c > "slstatus-sm-$(VERSION).tar.gz"
	rm -rf "slstatus-sm-$(VERSION)"

install: all
	mkdir -p "$(DESTDIR)$(PREFIX)/bin"
	cp -f slstatus "$(DESTDIR)$(PREFIX)/bin/slstatus-sm"
	chmod 755 "$(DESTDIR)$(PREFIX)/bin/slstatus"
	mkdir -p "$(DESTDIR)$(MANPREFIX)/man1"
	cp -f slstatus.1 "$(DESTDIR)$(MANPREFIX)/man1"
	chmod 644 "$(DESTDIR)$(MANPREFIX)/man1/slstatus.1"

uninstall:
	rm -f "$(DESTDIR)$(PREFIX)/bin/slstatus-sm"
	rm -f "$(DESTDIR)$(MANPREFIX)/man1/slstatus.1"
