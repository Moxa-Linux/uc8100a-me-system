# Makefile
#	source:	entering source_code directory and compiling source code
#	install:mkdir directory for binary files and prepare package files
#	clean:	clean all binary files
#
# Wes Huang (Wes.Huang@moxa.com)

# source code name
FOLDER=base-system
SNAME=kversion
VERSION=$(ver)

all: source

source:
	cd $(FOLDER)/$(SNAME); make ver=$(VERSION);

clean:
	cd $(FOLDER)/$(SNAME); make clean;
