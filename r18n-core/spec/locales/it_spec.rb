# encoding: utf-8
require File.expand_path('../../spec_helper', __FILE__)

describe R18n::Locales::It do
  it "formats Italian date" do
    italian = R18n::I18n.new('it')
    italian.l(Date.parse('2009-07-01'), :full).should == "1º luglio 2009"
    italian.l(Date.parse('2009-07-02'), :full).should == ' 2 luglio 2009'
    italian.l(Date.parse('2009-07-12'), :full).should == '12 luglio 2009'
  end

  context "formats lists in Italian" do
    subject { R18n.locale('it') }
    specify { subject.format_list(%w(A B    )).should eq 'A e B'        }
    specify { subject.format_list(%w(A B C  )).should eq 'A, B, e C'    }
    specify { subject.format_list(%w(A B C D)).should eq 'A, B, C, e D' }
  end
end
