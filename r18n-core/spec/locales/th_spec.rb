require File.expand_path('../../spec_helper', __FILE__)

describe R18n::Locales::Ru do
  it "uses Thai calendar" do
    th = R18n::I18n.new('th')
    th.l(Time.at(0).utc, '%Y %y').should eq  '2513 13'
    th.l(Time.at(0).utc).should eq '01/01/2513 00:00'
  end
end
