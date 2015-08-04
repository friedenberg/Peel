module Peel
 
	class Item
		attr_accessor :uid, :arg, :valid, :autocomplete, :title, :subtitle, :mod_subtitles, :icon, :type, :object
		
		def initialize(title, opts = {})
			if title.length == 0 then raise ArgumentError.new('title must be non-zero') end
			@uid = opts[:uid]
			@arg = opts[:arg]
			@valid = opts[:valid] != nil ? opts[:valid] : true
			@autocomplete = opts[:autocomplete]
			@title = title
			@subtitle = opts[:subtitle]
			@mod_subtitles = opts[:mod_subtitles] != nil ? opts[:mod_subtitles] : {}
			@icon = opts[:icon]
			@type = opts[:type] ? opts[:type] : 'default'
			@object = opts[:object]
			self
		end
		
	end
	
end