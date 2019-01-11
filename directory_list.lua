function fs.directory_list(directory)

  if directory.sub(-1, -1) ~= path_separator then
    directory = directory .. path_separator 
  end

  local filenames = {}

  for filename in fs.entries(directory) do
    if fs.metadata(directory .. filename).type == "directory" then
      table.insert(filenames, filename)
    end
  end

  return filenames
end
