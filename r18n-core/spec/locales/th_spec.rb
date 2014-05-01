# encoding: utf-8
require File.expand_path('../../spec_helper', __FILE__)

describe R18n::Locales::Th do
  it "uses Thai calendar" do
    th = R18n::I18n.new('th')
    th.l(Time.at(0).utc, '%Y %y').should ==  '2513 13'
    th.l(Time.at(0).utc).should == '01/01/2513 00:00'
  end

  context 'formats Thai lists' do
    subject { R18n.locale('th') }
    specify { subject.format_list(%w(ก ข)    ).should eq 'กและข'      }
    specify { subject.format_list(%w(ก ข ฃ)  ).should eq 'ก ข และฃ'   }
    specify { subject.format_list(%w(ก ข ฃ ค)).should eq 'ก ข ฃ และค' }
  end
end
