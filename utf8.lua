-- ABNF from RFC 3629
--
-- UTF8-octets = *( UTF8-char )
-- UTF8-char = UTF8-1 / UTF8-2 / UTF8-3 / UTF8-4
-- UTF8-1 = %x00-7F
-- UTF8-2 = %xC2-DF UTF8-tail
-- UTF8-3 = %xE0 %xA0-BF UTF8-tail / %xE1-EC 2( UTF8-tail ) /
-- %xED %x80-9F UTF8-tail / %xEE-EF 2( UTF8-tail )
-- UTF8-4 = %xF0 %x90-BF 2( UTF8-tail ) / %xF1-F3 3( UTF8-tail ) /
-- %xF4 %x80-8F 2( UTF8-tail )
-- UTF8-tail = %x80-BF

local utf8 = {}

-- returns the utf8 character length at i
utf8.clen =
	function (s, i)
		local c = string.byte(s, i)

		if not c              then return   end
		if c < 194 or c > 244 then return 1 end
		if c < 224            then return 2 end
		if c < 240            then return 3 end

		return 4
	end

-- generator to iterate over all utf8 chars
utf8.chars =
	function (s)
		local i = 0
		local c = '#'

		return
			function ()
				i = i + #c

				local n = utf8.clen(s, i)

				if not n then
					return
				end

				n = i + (n - 1)

				return string.sub(s, i, n), i
			end
	end

-- return the utf8 character at "character index" i, and the byte index
utf8.at =
	function (s, i)
		for c in utf8.chars(s) do
			i = i - 1
			if i == 0 then
				return c
			end
		end
	end

-- returns the number of characters in a UTF-8 string
utf8.len =
	function (s)
		local l = 0

		for c in utf8.chars(s) do
			l = l + 1
		end

		return l
	end

-- like string.sub() but i, j can be utf8 characters
utf8.sub =
	function (s, i, j)
		i = string.find(s, i, 1, true)

		if j then
			local tmp = string.find(s, j, 1, true)
			j = tmp + utf8.clen(j)
		end

		return string.sub(s, i, j)
	end

-- replace all utf8 chars with mapping
utf8.replace =
	function (s, map)
		local new = {}

		for c in utf8.chars(s) do
			table.insert(new, map[c] or c)

			if #new > 63 then
				new = { table.concat(new) }
			end
		end

		return table.concat(new)
	end

-- strip utf8 characters from a string
utf8.strip =
	function (s)
		local new = {}

		for c in utf8.chars(s) do
			if #c == 1 then
				table.insert(new, c)

				if #new > 63 then
					new = { table.concat(new) }
				end
			end
		end

		return table.concat(new)
	end

return utf8
