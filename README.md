#lua class

简单易用的class

```lua
local List = class("List")

local List:ctor()
  self._raw = {}
end

function List:push(item)
  table.insert(self._raw,item)
end

function List:length()
  return #self._raw
end


local list = List:new()
list:push(1)
list:push(2)
print(list:length())
```
