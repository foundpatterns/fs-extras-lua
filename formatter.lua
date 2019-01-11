function fs.to_dir_name (path)
  if path.sub(-1, -1) ~= path_separator then
    path = path .. path_separator
  end
  return path
end
