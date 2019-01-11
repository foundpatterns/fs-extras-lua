function fs.append_to_start(file_path, to_append)
  local file = assert(io.open(file_path, "r"))
  local file_content = file:read("*all")
  file:close()

  file = assert(io.open(file_path, "w"))
  file:write(to_append)
  file:write("\n")
  file:write(file_content)

  file:close()
end
