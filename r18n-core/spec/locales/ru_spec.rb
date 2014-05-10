require File.expand_path('../../spec_helper', __FILE__)

describe R18n::Locales::Ru do
  it "uses Russian pluralization" do
    ru = R18n.locale('ru')
    ru.pluralize(0).should eq 0

    ru.pluralize(1).should   eq 1
    ru.pluralize(21).should  eq 1
    ru.pluralize(101).should eq 1

    ru.pluralize(2).should   eq 2
    ru.pluralize(4).should   eq 2
    ru.pluralize(22).should  eq 2
    ru.pluralize(102).should eq 2

    ru.pluralize(5).should   eq 'n'
    ru.pluralize(11).should  eq 'n'
    ru.pluralize(12).should  eq 'n'
    ru.pluralize(57).should  eq 'n'
    ru.pluralize(111).should eq 'n'
  end
end
