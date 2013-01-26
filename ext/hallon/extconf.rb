require 'mkmf'

# Miscellaneous
def error(message)
  abort "[ERROR] #{message}"
end

$CFLAGS << ' -ggdb -O0 -Wextra'

# Check for headers

error 'Missing ruby header' unless have_header 'ruby.h'

# Allow configuration of openal directory
dir_config 'openal'

if have_header('OpenAL/alc.h')
  # yay, probably mac os!
  # check if we have openal extensions
  have_header('OpenAL/alext.h')
elsif have_header('AL/alc.h')
  # woot, probably everybody else!
  # check if we have openal extensions
  have_header('AL/alext.h')
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

%w[alcOpenDevice alGetError].each do |func|
  error "Missing function #{func}" unless have_func(func)
end

create_makefile('openal_ext')
