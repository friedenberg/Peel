require 'Peel/Item'
require 'nokogiri'

module Peel
	def self.alfred_results(results)
			if results.kind_of? Array
				raise ArgumentError.new('Cannot generate output for empty array') if results.empty?
				builder = Nokogiri::XML::Builder.new do |xml|
					xml.items {
						results.each do |result|
							result.add_to_xml(xml)
						end
					}
				end	
				return builder.to_xml
			elsif results.kind_of? Item
				return alfred_results [results]	
			else
				raise ArgumentError.new("Expected Item or Array, but got #{results.class}")
			end
	end
end
