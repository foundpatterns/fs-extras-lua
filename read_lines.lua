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
