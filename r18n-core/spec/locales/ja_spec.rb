# encoding: utf-8
require File.expand_path('../../spec_helper', __FILE__)

describe R18n::Locales::Ja do
  context 'formats Japanese lists' do
    subject { R18n.locale('ja') }
    specify { subject.format_list(%w(あ か)      ).should eq 'あ、か'         }
    specify { subject.format_list(%w(あ か さ)   ).should eq 'あ、か、さ'     }
    specify { subject.format_list(%w(あ か さ た)).should eq 'あ、か、さ、た' }
  end
end
