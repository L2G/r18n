# encoding: utf-8
require File.expand_path('../../spec_helper', __FILE__)

describe R18n::Locales::Hu do
  it "uses Hungarian digits groups" do
    hu = R18n::I18n.new('hu')
    hu.l(1000).should   ==  '1000'
    hu.l(10000).should  ==  '10 000'
    hu.l(-10000).should == '−10 000'
    hu.l(100000).should ==  '100 000'
  end

  it "uses Hungarian time format" do
    hu = R18n::I18n.new('hu')
    hu.l(Time.at(0).utc).should        == '1970. 01. 01., 00:00'
    hu.l(Time.at(0).utc, :full).should == '1970. január  1., 00:00'
  end

  context 'formats lists in Hungarian' do
    subject { R18n.locale('hu') }
    specify { subject.format_list(%w(A Á)    ).should eq 'A és Á'       }
    specify { subject.format_list(%w(A Á B)  ).should eq 'A, Á és B'    }
    specify { subject.format_list(%w(A Á B C)).should eq 'A, Á, B és C' }
  end
end
