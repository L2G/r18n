require File.expand_path('../../spec_helper', __FILE__)

describe R18n::Locales::Pl do
  subject { R18n.locale('pl') }

  it "uses Polish pluralization" do
    subject.pluralize(0).should == 0
    subject.pluralize(1).should == 1

    subject.pluralize(2).should   == 2
    subject.pluralize(4).should   == 2
    subject.pluralize(22).should  == 2
    subject.pluralize(102).should == 2

    subject.pluralize(5).should   == 'n'
    subject.pluralize(11).should  == 'n'
    subject.pluralize(12).should  == 'n'
    subject.pluralize(21).should  == 'n'
    subject.pluralize(57).should  == 'n'
    subject.pluralize(101).should == 'n'
    subject.pluralize(111).should == 'n'
    subject.pluralize(112).should == 'n'
  end

  context "formats lists in Polish" do
    specify { subject.format_list(%w(A Ą)    ).should eq 'A i Ą'       }
    specify { subject.format_list(%w(A Ą B)  ).should eq 'A, Ą i B'    }
    specify { subject.format_list(%w(A Ą B C)).should eq 'A, Ą, B i C' }
  end
end
