require 'spec_helper'

describe Peel do
  it 'has a version number' do
    expect(Peel::VERSION).not_to be nil
  end

  it 'throws an exception for empty arrays' do
    expect{Peel.alfred_results []}.to raise_error(ArgumentError)
  end
  
  it 'generates XML for Peel::Item' do
    items = Peel::Item.new('Test')
    xml_string = Peel.alfred_results([items])
    xml_result = Nokogiri::XML(xml_string) {|c| c.strict}
    expect(xml_result.errors.empty?).to eq(true) 
    expect(xml_string).to have_xpath('/items/item/title').with_text('Test')
  end
  
  it 'generates XML for Arrays of Items' do
    items = [Peel::Item.new('Test'), Peel::Item.new('Test 2')]
    xml_string = Peel.alfred_results items
    xml_result = Nokogiri::XML(xml_string) {|c| c.strict}
    expect(xml_result.errors.empty?).to eq(true) 
    expect(xml_string).to have_xpath('/items/item/title')
  end
  
  it 'throws an exception for non-Array and non-Peel::Item' do
    expect {Peel.alfred_results nil}.to raise_error(ArgumentError)
  end
  
  it 'properly escapes XML' do
  	items = Peel::Item.new('Test', :arg => '&"<>\'', :subtitle => '&"<>\'')
    xml_string = Peel.alfred_results items
    xml_result = Nokogiri::XML(xml_string) {|c| c.strict}
    expect(xml_result.errors.empty?).to eq(true) 
    expect(xml_string).to have_xpath('/items/item')
  end
end

describe Peel::Item do
  it 'has values for required elements' do
    item = Peel::Item.new('Test')
    
    expect(item.title).to eq('Test')
    expect(item.valid).to eq(true)
  end
  
  it 'fails to initialize if the title is empty' do
    expect {Peel::Item.new('')}.to raise_error(ArgumentError)
  end
  
  it 'fails to initialize if there is no argument' do
    expect {Peel::Item.new()}.to raise_error(ArgumentError)
  end
end
