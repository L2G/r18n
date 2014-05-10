# encoding: utf-8
require File.expand_path('../../spec_helper', __FILE__)

describe R18n::Locales::It do
  it "formats Italian date" do
    italian = R18n::I18n.new('it')
    italian.l(Date.parse('2009-07-01'), :full).should eq "1º luglio 2009"
    italian.l(Date.parse('2009-07-02'), :full).should eq ' 2 luglio 2009'
    italian.l(Date.parse('2009-07-12'), :full).should eq '12 luglio 2009'
  end
end
