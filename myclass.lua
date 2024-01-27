
---@class MyClass
---@field myarg number
local MyClass = {}
MyClass.__index = MyClass

---@return MyClass
function MyClass:new()
	self = setmetatable({}, MyClass)
	self.__index = self
	self.myarg = 10
	return self
end

function MyClass:duplicate()
	return self.myarg * 2
end

local t = MyClass:new()
print(t:duplicate())
