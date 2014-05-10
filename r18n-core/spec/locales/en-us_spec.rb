require File.expand_path('../../spec_helper', __FILE__)

describe R18n::Locales::EnUs do
  it "formats American English date" do
    enUS = R18n::I18n.new('en-US')
    enUS.l(Date.parse('2009-05-01'), :full).should eq  'May 1st, 2009'
    enUS.l(Date.parse('2009-05-02'), :full).should eq  'May 2nd, 2009'
    enUS.l(Date.parse('2009-05-03'), :full).should eq  'May 3rd, 2009'
    enUS.l(Date.parse('2009-05-04'), :full).should eq  'May 4th, 2009'
    enUS.l(Date.parse('2009-05-11'), :full).should eq 'May 11th, 2009'
    enUS.l(Date.parse('2009-05-21'), :full).should eq 'May 21st, 2009'
  end
end
