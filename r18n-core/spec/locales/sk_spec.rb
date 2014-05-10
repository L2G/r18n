require File.expand_path('../../spec_helper', __FILE__)

describe R18n::Locales::Sk do
  it "uses Slovak pluralization" do
    sk = R18n.locale('Sk')
    sk.pluralize(0).should eq 0
    sk.pluralize(1).should eq 1

    sk.pluralize(2).should eq 2
    sk.pluralize(3).should eq 2
    sk.pluralize(4).should eq 2

    sk.pluralize(5).should   eq 'n'
    sk.pluralize(21).should  eq 'n'
    sk.pluralize(11).should  eq 'n'
    sk.pluralize(12).should  eq 'n'
    sk.pluralize(22).should  eq 'n'
    sk.pluralize(57).should  eq 'n'
    sk.pluralize(101).should eq 'n'
    sk.pluralize(102).should eq 'n'
    sk.pluralize(111).should eq 'n'
  end
end
