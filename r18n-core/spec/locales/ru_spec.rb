# encoding: utf-8
require File.expand_path('../../spec_helper', __FILE__)

describe R18n::Locales::Ru do
  subject { R18n.locale('ru') }

  it "uses Russian pluralization" do
    subject.pluralize(0).should == 0

    subject.pluralize(1).should   == 1
    subject.pluralize(21).should  == 1
    subject.pluralize(101).should == 1

    subject.pluralize(2).should   == 2
    subject.pluralize(4).should   == 2
    subject.pluralize(22).should  == 2
    subject.pluralize(102).should == 2

    subject.pluralize(5).should   == 'n'
    subject.pluralize(11).should  == 'n'
    subject.pluralize(12).should  == 'n'
    subject.pluralize(57).should  == 'n'
    subject.pluralize(111).should == 'n'
  end

  context "formats lists in Russian" do
    specify { subject.format_list(%w(A Б)    ).should eq 'A и Б'       }
    specify { subject.format_list(%w(A Б В)  ).should eq 'A, Б и В'    }
    specify { subject.format_list(%w(A Б В Г)).should eq 'A, Б, В и Г' }
  end
end
