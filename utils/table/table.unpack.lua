-- By default, i is 1 and j is #list.
table.unpack = table.unpack or function (list, i, j)
     i = i or 1
     j = j or #list

     return unpack(list, i, j)
end