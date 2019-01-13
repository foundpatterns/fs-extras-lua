function fs.join(...)
  path_separator = "/"
  return fs.sanitize(table.concat({...}, path_separator))
end
