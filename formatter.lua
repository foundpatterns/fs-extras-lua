function fs.to_dir_name (path)
  if path.sub(-1, -1) ~= "/" then
    path = path .. "/"
  end
  return path
end
