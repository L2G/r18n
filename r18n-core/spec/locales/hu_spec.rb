# encoding: utf-8
require File.expand_path('../../spec_helper', __FILE__)

describe R18n::Locales::Hu do
  it "uses Hungarian digits groups" do
    hu = R18n::I18n.new('hu')
    hu.l(1000).should   eq  '1000'
    hu.l(10000).should  eq  '10 000'
    hu.l(-10000).should eq '−10 000'
    hu.l(100000).should eq  '100 000'
  end

  it "uses Hungarian time format" do
    hu = R18n::I18n.new('hu')
    hu.l(Time.at(0).utc).should        eq '1970. 01. 01., 00:00'
    hu.l(Time.at(0).utc, :full).should eq '1970. január  1., 00:00'
  end
end
