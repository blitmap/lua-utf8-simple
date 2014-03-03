-- assuming you're running the tests from within the clone
package.path = './?.lua;' .. package.path

local utf8 = require('utf8_simple')

local WRONG = {}

local tests = {}

tests.chars =
	function ()
		-- 'Αγαπώ'
		local love, x  = { 'Α', 'γ', 'α', 'π', 'ώ' }, 0
		local byte_idx = { 1, 3, 5, 7, 9 }

		for i, c, b in utf8.chars('Αγαπώ') do
			x = x + 1

			local C = love[x]

			if
				c ~= C or
				i ~= x or
				b ~= byte_idx[x]
			then
				WRONG.chars = true
			end
		end

		if x == 0 then WRONG.chars = true end
	end

tests.len =
	function ()
		if utf8.len('Αγαπώ') ~= 5 then
			WRONG.len = true
		end
	end

tests.sub =
	function ()
		local s = 'i αγαπώ cats'

		if pcall(utf8.sub, s)                   then WRONG.sub = true end -- no-i substring
		if utf8.sub(s,   3)     ~= 'αγαπώ cats' then WRONG.sub = true end -- i-only substring
		if utf8.sub(s,  -7)     ~= 'πώ cats'    then WRONG.sub = true end -- i-only negative substring
		if utf8.sub(s,   6,  7) ~= 'πώ'         then WRONG.sub = true end -- normal positive-index substring
		if utf8.sub(s,  -7, -6) ~= 'πώ'         then WRONG.sub = true end -- normal negative-index substring
		if utf8.sub(s, -70, #s) ~= s            then WRONG.sub = true end -- impossible negative-index substring
		if utf8.sub(s,   1, 90) ~= s            then WRONG.sub = true end -- impossible positive-index substring
		if utf8.sub(s,   4,  4) ~= 'γ'          then WRONG.sub = true end -- single-character substring
		if utf8.sub(s,   8,  4) ~= ''           then WRONG.sub = true end -- start after end substring
	end

tests.replace =
	function ()
		if utf8.replace('∃y ∀x ¬(x ≺ y)', { ['∃'] = 'E', ['∀'] = 'A', ['¬'] = '-', ['≺'] = '<' }) ~= 'Ey Ax -(x < y)' then
			WRONG.replace = true
		end
	end

tests.reverse =
	function ()
		if utf8.reverse('Αγαπώ τηγανίτες') ~= 'ςετίναγητ ώπαγΑ' then
			WRONG.reverse = true
		end
	end

tests.strip =
	function ()
		if utf8.strip('cat♥dog∀cat♥dog') ~= 'catdogcatdog' then
			WRONG.strip = true
		end
	end

local keys =
	function (t)
		local ks = {}

		for k in pairs(t) do
			table.insert(ks, k)
		end

		return ks
	end

tests.run =
	function ()
		local testnames = { 'chars', 'len', 'sub', 'replace', 'reverse', 'strip' }

		for _, func in ipairs(testnames) do
			print('testing ' .. func .. '..')
			tests[func]()
		end

		if not next(WRONG) then
			print('all tests succeeded! :D-S-<')
		else
			print('problems in these functions: ' .. table.concat(keys(WRONG), '(), ') .. '()')
		end
	end

tests.run()
