require File.expand_path('../../spec_helper', __FILE__)

describe R18n::Locales::Pl do
  it "uses Polish pluralization" do
    pl = R18n.locale('pl')
    pl.pluralize(0).should eq 0
    pl.pluralize(1).should eq 1

    pl.pluralize(2).should   eq 2
    pl.pluralize(4).should   eq 2
    pl.pluralize(22).should  eq 2
    pl.pluralize(102).should eq 2

    pl.pluralize(5).should   eq 'n'
    pl.pluralize(11).should  eq 'n'
    pl.pluralize(12).should  eq 'n'
    pl.pluralize(21).should  eq 'n'
    pl.pluralize(57).should  eq 'n'
    pl.pluralize(101).should eq 'n'
    pl.pluralize(111).should eq 'n'
    pl.pluralize(112).should eq 'n'
  end
end
