function fs.sanitize(path) 
	local pattern = "[" .. path_separator .. "]+"
	local sanitized, _ = path:gsub(pattern, path_separator)
	return sanitized
end
