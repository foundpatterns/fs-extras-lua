if torchbear.os == "windows" then
  path_separator = '\\'
else
  path_separator = '/'
end


function fs.basename(path)
  return string.match(path, "[^" .. path_separator .. "]+$")
end


function fs.join(...)
  return table.concat({...}, path_separator)
end


function fs.abs(...)
  local err = nil
  local path = fs.join(...)
  local abspath = fs.canonicalize(path)
  if abspath == nil then
  	err = "can't get absolute path of " .. path
  end
  return abspath, err
end


function fs.to_dir_name (path)
  if path.sub(-1, -1) ~= "/" then
    path = path .. "/"
  end
  return path
end


-- Basically io.lines except it doesn't fails if the file doesn't exist
function fs.read_lines(path, ...)
  local file = io.open(path, "r")

  -- Returning an empty function makes the for loop do nothing
  if not file then
    return function () end
  end

  local _f, s, var = file:lines(...)

  -- Returns the parameters as they are but if the first parameter is nil closes the file
  -- (lua loops stop after the first result of the iterator function is nil)
  local function bridge (var1, ...)
    if var1 == nil then
      file:close()
    end
    return var1, ...
  end

  -- A wrapper that closes the file when the iterator ends
  local function f (s, var)
    return bridge(_f(s, var))
  end

  return f, s, var
end

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


function fs.directory_list(directory)

  if directory.sub(-1, -1) ~= "/" then
    directory = directory .. "/"
  end

  local filenames = {}

  for filename in fs.entries(directory) do
    if fs.metadata(directory .. filename).type == "directory" then
      table.insert(filenames, filename)
    end
  end

  return filenames
end


function fs.copy(src_path, dest_path) 
  fs.copy_file(src_path, dest_path)
end


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


function fs.remove_recursive(dir)
  return fs.remove_dir(dir, true)
end


function fs.mklink(src, dest)
  return fs.symlink(src, dest)
end


function fs.read_file(path)
  local file = io.open(path, "r")

  if not file then
    return nil
  end

  local file_content = file:read("*all")
  file:close()
  return file_content
end

return fs
