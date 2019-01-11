function fs.join(...)
  return table.concat({...}, path_separator)
end
