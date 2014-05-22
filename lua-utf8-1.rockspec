package = 'utf8_simple'
version = 'scm-1'

source = { url = 'git://github.com/Pogs/lua-utf8-simple.git' }

description =
	{
		summary    = 'Minimal functions for basic UTF-8 handling on Lua strings',
		detailed   = 'Provides minimal functions for handling UTF-8 in Lua strings: chars(), map(), len(), reverse(), strip(), replace(), & sub()',
		homepage   = 'https://github.com/Pogs/lua-utf8-simple',
		license    = 'BSD',
		maintainer = 'Sir Pogsalot <coroutines+github@gmail.com>'
	}

build = { type = 'builtin', modules = { utf8_simple = 'utf8_simple.lua' } }
