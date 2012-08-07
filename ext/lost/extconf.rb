require 'mkmf'

$LDFLAGS += " -framework cocoa -framework CoreLocation "

if RUBY_VERSION > "1.8"
  $defs.push "-DRUBY_19"
end

create_makefile("lost")
