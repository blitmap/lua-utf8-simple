package = 'utf8'
version = 'scm-1'

source = { url = 'git://github.com/Pogs/lua-utf8.git' }

description =
	{
		summary    = 'Minimal functions for basic UTF-8 handling on Lua strings',
		detailed   = 'Provides minimal functions for handling UTF-8 in Lua strings: iter(), map(), clen(), at(), len(), reverse(), strip(), replace(), & sub()',
		homepage   = 'https://github.com/Pogs/lua-utf8',
		license    = 'BSD',
		maintainer = 'Sir Pogsalot <sir.pogsalot@gmail.com>'
	}

build = { type = 'builtin', modules = { utf8 = 'utf8.lua' } }
