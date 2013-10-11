require "math"

debug = true

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

vectormt.__add = function(a,b)
	if #a ~= #b then
		print("cannot add vector" .. #a .. " and vector" .. #b)
		return nil
	end
	local v = vector({})
	for i in pairs(a) do
		v[i] = a[i] + b[i]
	end
	if debug then
		print(tostring(a).." + "..tostring(b).." = "..tostring(v))
	end
	return v
end

function vectormt:__tostring()
	local x = "<"
	for i,j in pairs(self) do
		x = x..tostring(j)
		if i ~= #self then
			x = x..","
		end
	end
	x = x..">"
	return x
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
	if debug then
		print(tostring(a).." + "..tostring(b).." = "..tostring(v))
	end
	return v
end

function vectormt:mag()
	local sum = 0
	for _,i in pairs(self) do
		sum = sum + i*i
	end
	local f = math.sqrt(sum)
	if debug then
		print("magnitude of "..tostring(self).." = "..f)
	end
	return f
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
	if debug then
		print(tostring(self).." dot "..tostring(other).." = "..sum)
	end
	return sum
end

function vectormt:normalize()
	local s = self:mag()
	local e = self / s
	return e
end

function vectormt.__div(a,b)
	local v = vector()
	for i,j in pairs(a) do
		v[i] = j/b
	end
	if debug then
		print(tostring(a).." / "..b.." = "..tostring(v))
	end
	return v
end

function vectormt.__mul(a,b)
	local v = vector()
	for i,j in pairs(a) do
		v[i] = j*b
	end
	if debug then
		print(tostring(a).." * "..b.." = "..tostring(v))
	end
	return v
end

function vectormt:proj(other)
	local theta = self:angle(other)
	local m = other:mag()
	local e = self:normalize()
	local result = e * (math.cos(theta) * m)
	if debug then
		print(tostring(other).." projected onto "..tostring(self).." = "..tostring(result))
	end
	return result
end

function vectormt:angle(other)
	local a = self:dot(other)
	local b = self:mag()
	local c = other:mag()
	local theta = math.acos(a/(b*c))
	if debug then
		print("arccos("..a.."/("..b.."*"..c..")) = ".. theta)
	end
	return theta
end

--a = vector(1,2,3)
--a:print()
