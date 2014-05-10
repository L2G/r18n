require File.expand_path('../../spec_helper', __FILE__)

describe R18n::Locales::En do
  it "formats English date" do
    en = R18n::I18n.new('en')
    en.l(Date.parse('2009-05-01'), :full).should eq  '1st of May, 2009'
    en.l(Date.parse('2009-05-02'), :full).should eq  '2nd of May, 2009'
    en.l(Date.parse('2009-05-03'), :full).should eq  '3rd of May, 2009'
    en.l(Date.parse('2009-05-04'), :full).should eq  '4th of May, 2009'
    en.l(Date.parse('2009-05-11'), :full).should eq '11th of May, 2009'
    en.l(Date.parse('2009-05-21'), :full).should eq '21st of May, 2009'
  end
end
