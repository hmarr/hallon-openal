require 'mkmf'

# Miscellaneous
def error(message)
  abort "[ERROR] #{message}"
end

$CFLAGS << ' -ggdb -O0 -Wextra'

# Check for headers

error 'Missing ruby header' unless have_header 'ruby.h'

if have_header('OpenAL/alc.h')
  # yay, probably mac os!
elsif have_header('AL/alc.h')
  # woot, probably everybody else!
else
  error 'Missing openal headers'
end

# Add library
if RUBY_PLATFORM =~ /darwin/
  $LDFLAGS << ' -framework OpenAL '
elsif have_library('openal', 'alSourceQueueBuffers')
  $LDFLAGS << ' -lopenal '
else
  error 'Missing openal library'
end

create_makefile('openal_ext')
