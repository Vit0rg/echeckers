string.split = function(value, sep, f)
	if sep == nil or sep == "" then
		-- If no separator is provided, return each character
		local out = {}
		for i = 1, #value do
			out[i] = value:sub(i, i)
		end
		return out
	end

	local out = {}
	local index = 1

	-- Handle empty string case
	if value == "" then
		return {""}
	end

	-- Process the string by finding separators iteratively without a while loop
	local remaining_value = value
	local start_pos = 1

	-- Since we need to avoid while loops, we'll use a for loop with a large upper bound
	-- and break when no more separators are found
	for _ = 1, #value do
		local pos = string.find(remaining_value, sep, start_pos, true) -- plain text search
		if not pos then
			-- No more separators, add the rest of the string
			local chunk = string.sub(remaining_value, start_pos)
			out[index] = (f and type(f) == "function" and f(chunk) or chunk)
			break
		else
			-- Add the substring before the separator
			local chunk = string.sub(remaining_value, start_pos, pos - 1)
			out[index] = (f and type(f) == "function" and f(chunk) or chunk)
			index = index + 1
			start_pos = pos + #sep
			remaining_value = value
		end
	end

	return out
end