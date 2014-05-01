require File.expand_path('../../spec_helper', __FILE__)

describe R18n::Locales::EnUs do
  it "formats American English date" do
    enUS = R18n::I18n.new('en-US')
    enUS.l(Date.parse('2009-05-01'), :full).should ==  'May 1st, 2009'
    enUS.l(Date.parse('2009-05-02'), :full).should ==  'May 2nd, 2009'
    enUS.l(Date.parse('2009-05-03'), :full).should ==  'May 3rd, 2009'
    enUS.l(Date.parse('2009-05-04'), :full).should ==  'May 4th, 2009'
    enUS.l(Date.parse('2009-05-11'), :full).should == 'May 11th, 2009'
    enUS.l(Date.parse('2009-05-21'), :full).should == 'May 21st, 2009'
  end

  context "formats lists in English (with Oxford comma)" do
    subject { R18n.locale('en-US') }
    specify { subject.format_list(%w(A B)    ).should eq 'A and B'        }
    specify { subject.format_list(%w(A B C)  ).should eq 'A, B, and C'    }
    specify { subject.format_list(%w(A B C D)).should eq 'A, B, C, and D' }
  end
end
