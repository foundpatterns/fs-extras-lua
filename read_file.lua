function fs.read_file(path)
  local file = io.open(path, "r")

  if not file then
    return nil
  end

  local file_content = file:read("*all")
  file:close()
  return file_content
end
