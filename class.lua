function class(name, super)
    local Class = {}
    Class.__index = Class
    Class.__super = super
    Class.__name = name

    if super then
        setmetatable(Class, super)
    end

    function Class:new(...)
        local that = setmetatable({}, Class)

        local _super = Class.__super
        
        while _super do
        	if _super.ctor then 
	        	_super.ctor(that,...)
	        end
        	_super = _super.__super
        end

        if that.ctor then
            that:ctor(...)
        end

        local prox = newproxy(true)
        getmetatable(prox).__gc = function()
            if that.dtor then
                that:dtor()
            end

            local _super = Class.__super
	        while _super do
	        	if _super.dtor then 
	        		_super.dtor(that) 
	        	end
	        	_super = _super.__super
	        end
        end

        return that
    end

    return Class
end