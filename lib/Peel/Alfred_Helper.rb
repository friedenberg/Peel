require 'Peel/Item'
require 'nokogiri'

module Peel
	
	class Alfred_Helper
		
		def put_results(items)
				if items.kind_of? Array
					raise ArgumentError.new('Cannot generate output for empty array') if items.empty?
					builder = Nokogiri::XML::Builder.new do |xml|
						xml.items {
							items.each do |item|
								xml.item(:uid => item.uid, :arg => item.arg, :valid => item.valid, :type => item.type) {
									xml.title item.title
									xml.subtitle item.subtitle
									
									item.mod_subtitles.each_pair do |key, value|
										xml.subtitle(value, :mod => key)
									end
								}
							end
						}
					end	
					return builder.to_xml
				elsif items.kind_of? Item
					return put_results [items]	
				else
					raise ArgumentError.new("Expected Item or Array, but got #{items.class}")
				end
		end
		
	end
	
end