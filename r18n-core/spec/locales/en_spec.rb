require File.expand_path('../../spec_helper', __FILE__)

describe R18n::Locales::En do
  it "formats English date" do
    en = R18n::I18n.new('en')
    en.l(Date.parse('2009-05-01'), :full).should ==  '1st of May, 2009'
    en.l(Date.parse('2009-05-02'), :full).should ==  '2nd of May, 2009'
    en.l(Date.parse('2009-05-03'), :full).should ==  '3rd of May, 2009'
    en.l(Date.parse('2009-05-04'), :full).should ==  '4th of May, 2009'
    en.l(Date.parse('2009-05-11'), :full).should == '11th of May, 2009'
    en.l(Date.parse('2009-05-21'), :full).should == '21st of May, 2009'
  end

  context "formats lists in English" do
    subject { R18n.locale('en') }
    specify { subject.format_list(%w(A B)    ).should eq 'A and B'       }
    specify { subject.format_list(%w(A B C)  ).should eq 'A, B and C'    }
    specify { subject.format_list(%w(A B C D)).should eq 'A, B, C and D' }
  end
end
