require File.expand_path('../../spec_helper', __FILE__)

describe R18n::Locales::Cs do
  it "uses Czech pluralization" do
    cs = R18n.locale('cs')
    cs.pluralize(0).should eq 0
    cs.pluralize(1).should eq 1

    cs.pluralize(2).should eq 2
    cs.pluralize(3).should eq 2
    cs.pluralize(4).should eq 2

    cs.pluralize(5).should   eq 'n'
    cs.pluralize(21).should  eq 'n'
    cs.pluralize(11).should  eq 'n'
    cs.pluralize(12).should  eq 'n'
    cs.pluralize(22).should  eq 'n'
    cs.pluralize(57).should  eq 'n'
    cs.pluralize(101).should eq 'n'
    cs.pluralize(102).should eq 'n'
    cs.pluralize(111).should eq 'n'
  end
end
