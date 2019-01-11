function fs.get_all_files_in(directory)

  if directory.sub(-1, -1) ~= "/" then
    directory = directory .. "/"
  end

  local filenames = {}

  for filename in fs.entries(directory) do
    if fs.metadata(directory .. filename).type == "file" then
      table.insert(filenames, filename)
    end
  end

  return filenames
end
