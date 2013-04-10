# lua-utf8

This "library" is meant to be a very thin helper that you can easily drop in to another project without really calling it a dependency.  It aims to provide the most minimal of handling functions for working with utf8 strings.  It does not aim to be feature-complete or even error-descriptive.  It works for what is practical but not complex.  You have been warned. =^__^=

## The Only Function You Should Know

### utf8.iter(s)

s: (string) the utf8 string to iterate over (by characters)

```lua

-- c is the full utf8 character (string)
-- i is the byte index within the string
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

## Others

### utf8.clen(s, i)
s: (string) the utf8 string
i: (number) the **byte index** of a utf8 character within s (defaults to 1)

returns: (number) the length of the utf8 character at i

note: call this on the first byte of the utf8 character, continuing or invalid utf8 bytes will also return 1

```lua
> = utf8.clen('i ♥ cats', 3)
3
```

### utf8.at(s, i):
s: (string) the utf8 string
i: (number) the utf8 character index (not the byte index)

returns: (string) the utf8 character at that index (1-4 bytes)

```lua
> = utf8.at('Αγαπώ τηγανίτες', 4)
π
```

### utf8.len(s):
s: (string) the utf8 string

returns: (number) the number of utf8 characters in s (not the byte length)

note: be aware of "invisible" utf8 characters

```lua
> = utf8.len('Αγαπώ τηγανίτες')
15
```

### utf8.reverse(s):
s: (string) the utf8 string

returns: (string) the utf8-reversed form of s

note: reversing left-to-right utf8 strings that include directional formatting characters will look odd

```lua
> = utf8.reverse('Αγαπώ τηγανίτες')
ςετίναγητ ώπαγΑ
```

### utf8.strip(s):
s: (string) the utf8 string

returns: (string) s with all utf8 characters removed (characters > 1 byte)

```lua
> = utf8.strip('cat♥dog')
catdog
```

### utf8.replace(s, map):
s: (string) the utf8 string
map: (table) keys are utf8 characters to replace, values are their replacement

returns: (string) s with all the key-characters in map replaced

note: the keys must be utf8 characters, the values **can** be strings

```lua
> = utf8.replace('∃y ∀x ¬(x ≺ y)', { ['∃'] = 'E', ['∀'] = 'A', ['¬'] = '\r\n', ['≺'] = '<' })
Ey Ax 
(x < y)
```

### utf8.sub(s, i, j):
s: (string) the utf8 string
i: (string) the starting utf8 character
j: (stirng) the ending utf8 character

returns: (string) the substring formed from i to j, inclusive

```lua
> = utf8.sub('Μου αρέσει τηγανίτες', 'τ', 'ς')
τηγανίτες
```
