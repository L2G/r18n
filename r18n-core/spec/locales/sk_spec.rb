require File.expand_path('../../spec_helper', __FILE__)

describe R18n::Locales::Sk do
  subject { R18n.locale('Sk') }

  it "uses Slovak pluralization" do
    subject.pluralize(0).should == 0
    subject.pluralize(1).should == 1

    subject.pluralize(2).should == 2
    subject.pluralize(3).should == 2
    subject.pluralize(4).should == 2

    subject.pluralize(5).should   == 'n'
    subject.pluralize(21).should  == 'n'
    subject.pluralize(11).should  == 'n'
    subject.pluralize(12).should  == 'n'
    subject.pluralize(22).should  == 'n'
    subject.pluralize(57).should  == 'n'
    subject.pluralize(101).should == 'n'
    subject.pluralize(102).should == 'n'
    subject.pluralize(111).should == 'n'
  end

  context 'formats Slovak lists' do
    specify { subject.format_list(%w(A Ä)    ).should eq 'A a Ä'       }
    specify { subject.format_list(%w(A Ä B)  ).should eq 'A, Ä a B'    }
    specify { subject.format_list(%w(A Ä B C)).should eq 'A, Ä, B a C' }
  end
end
