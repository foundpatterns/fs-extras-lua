function fs.abs(...)
  local err = nil
  local path = fs.join(...)
  local abspath = fs.canonicalize(path)
  if abspath == nil then
  	err = "can't get absolute path of " .. path
  end
  return abspath, err
end
