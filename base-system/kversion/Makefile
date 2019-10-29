-include $(ARCH_CONFIG)

#VERSIONPKG=$()

#CC=arm-linux-gnueabihf-gcc
#STRIP=arm-linux-gnueabihf-strip
EXEC = kversion
OBJS = kversion.o
NOW=$(shell date +%y%m%d%H)
#CFLAGS += -DFIRM_VER='"$(VERSIONPKG)"' -DDATE='"$(NOW)"' $(VENDOR_CFLAGS)
CFLAGS += -DFIRM_VER='"$(ver)"' -DDATE='"$(NOW)"' -DPLATFORM='"$(platform)"'

all: clean $(EXEC)

$(EXEC): $(OBJS)
	$(CC) -o $@ $(OBJS)
	$(STRIP) -s $(EXEC)

romfs: clean $(EXEC)
	$(ROMFSINST) /bin/$(EXEC)
	chmod 755 $(ROMFSDIR)/bin/$(EXEC)

package:

clean:
	-rm -f $(EXEC) *.elf *.o *.gdb
