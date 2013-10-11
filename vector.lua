require "math"

vectormt = {}
vectormt.__index = vectormt

vector = function (...)
	local v = {}
	for i,j in pairs({...})do
		v[i] = j
	end
	setmetatable(v,vectormt)
	return v
end

ebug = true


function vectormt:print()
	local x = "<"
	for i,j in pairs(self) do
		x = x..tostring(j)
		if i ~= #self then
			x = x..","
		end
	end
	x = x..">"
	print(x)
end

vectormt.__add = function(a,b)
	if #a ~= #b then
		print("cannot add vector" .. #a .. " and vector" .. #b)
		return nil
	end
	local v = vector({})
	for i in pairs(a) do
		v[i] = a[i] + b[i]
	end
	return v
end

vectormt.__sub = function(a,b)
	if #a ~= #b then
		print("cannot add vector" .. #a .. " and vector" .. #b)
		return nil
	end
	local v = vector({})
	for i in pairs(a) do
		v[i] = a[i] - b[i]
	end
	return v
end

function vectormt:mag()
	local sum = 0
	for _,i in pairs(self) do
		sum = sum + i*i
	end
	return math.sqrt(sum)
end

function vectormt:dot(other)
	local sum = 0
	if #self ~= #other then
		print("cannot dot vector" .. #self .. " and vector" .. #other)
		return nil
	end
	for i in pairs(self) do
		sum = sum + self[i] * other[i]
	end
	return sum
end

function vectormt:angle(other)
	return math.acos(self:dot(other)/(self:mag()*other:mag()))
end

--a = vector(1,2,3)
--a:print()
