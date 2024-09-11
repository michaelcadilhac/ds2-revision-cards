package.path = package.path .. ";../lib/?/init.lua;../lib/?.lua"
package.path = package.path .. ";./lib/?/init.lua;./lib/?.lua"

function string:split(delimiter)
  local result = { }
  local from  = 1
  local delim_from, delim_to = string.find( self, delimiter, from  )
  while delim_from do
    table.insert( result, string.sub( self, from , delim_from-1 ) )
    from  = delim_to + 1
    delim_from, delim_to = string.find( self, delimiter, from  )
  end
  table.insert( result, string.sub( self, from  ) )
  return result
end

local lyaml = require ("yaml")
function parsetablestr (tab)
   local t = lyaml.eval (tab)
   local fields = t['description']['fields']
   local field_to_pos = {}
   local nfields = 0
   for i, v in pairs (fields) do
      field_to_pos[v] = i
      nfields = nfields + 1
   end
   for _, line in pairs (t['contents']) do
      for i, v in pairs (fields) do
         local f = line[v]
         if f ~= nil then
            tex.tprint (tostring (f):split ("\n"))
         end
         if i ~= nfields then
            tex.sprint ('&')
         end
      end
      tex.sprint ('\\\\')
   end
end

function parsetable (file)
   local f = assert(io.open(file, "rb"))
   local contents = f:read("*all")
   f:close()
   parsetablestr (contents)
end
