function subfiles (pattern)
   local f = {}
   for file in lfs.dir ('src/') do
      if string.find (file, "^" .. pattern .. "$") then
         table.insert (f, file)
      end
   end
   table.sort (f)
   for i, el in ipairs (f) do
      tex.sprint ('\\subfile{' .. el .. '}')
   end
end

function autosubfiles ()
   local fname = status.filename:match ('[^/]*$')
   fname = fname:match ('^.*[0-9]'):gsub ('-', '\\-')
   subfiles (fname .. '[^0-9]+[0-9]+[^0-9]+.tex')
end
