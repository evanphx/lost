require 'mkmf'

$LDFLAGS += " -framework cocoa -framework CoreLocation "

create_makefile("lost")
