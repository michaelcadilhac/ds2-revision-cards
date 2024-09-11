function readAll(file)
    local f = assert(io.open(file, "rb"))
    local content = f:read("*all")
    f:close()
    return content
end

local revision = "norev"
pcall (function ()
  revision = string.sub (readAll ("./.git/refs/heads/main"), 0, 8)
end)
tex.sprint ('\\gdef\\therevision{' .. revision .. '}')
