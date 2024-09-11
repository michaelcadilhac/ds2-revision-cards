function add_indentrule(filename)
   -- A table containing a "reader" function for reading a line.
   local ret = {}
   ret.file = io.open(filename)
   ret.reformat = false
   ret.reader =
      function(t)
         local line = t.file:read()
         if line == nil then return line end
         if (string.match (line, "begin{lstalgs4}.*#i")) then
            ret.reformat = true
            return line:gsub ('#i', '')
         elseif (string.match (line, "end{lstalgs4}")) then
            ret.reformat = false
            return line
         else
            if (ret.reformat) then
               -- If line ends with space, append U+200C (ZWNJ)
               return line:gsub('  ', '$\\indentrule$  ')
            else
               return line
            end
         end
      end
   return ret
end
luatexbase.add_to_callback('open_read_file', add_indentrule, 'add_indentrule')
