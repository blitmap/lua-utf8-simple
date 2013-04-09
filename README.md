lua-utf8
========

This "library" is meant to be a very thin helper that you can easily drop in to another project without really calling it a dependency.  It aims to provide the most minimal of handling functions for working with utf8 strings.  It does not aim to be feature-complete or even error-descriptive.  It works for what is practical but not complex.  You have been warned. =^__^=

The Only Function Worth Knowing
-------------------------------

```lua

-- utf8.iter() is the only function you need

-- c is the full utf8 character (as a string -- not always a single byte)
-- i is the byte index within the utf8 string
for c, i in utf8.iter('Αγαπώ τηγανίτες') do
	print(c, i)
end

```

Output:

	Α	1
	γ	3
	α	5
	π	7
	ώ	9
		11
	τ	12
	η	14
	γ	16
	α	18
	ν	20
	ί	22
	τ	24
	ε	26
	ς	28

Other Functions
---------------
- utf8.clen(s, i): return byte length of utf8 character at byte index i of string s (expects to be called on first byte of character)
- utf8.at(s, i): return utf8 character at "visual index" i in string s, also returns the byte index
- utf8.len(s): return the number of utf8 characters in string s (visual length, not byte length)
- utf8.reverse(s): return a reversed form of utf8 string s
- utf8.strip(s): return a string not containing any utf8 characters
- utf8.replace(s, map): map is a table where keys are the utf8 characters and values are their replacement
- utf8.sub(s, i, j): like string.sub() but you can use utf8 characters instead of numbers for i & j
