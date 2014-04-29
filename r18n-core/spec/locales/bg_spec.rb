# encoding: utf-8
require File.expand_path('../../spec_helper', __FILE__)

describe R18n::Locales::Bg do
  subject { R18n.locale('bg') }

  context "formats lists in Bulgarian" do
    specify { subject.format_list(%w(A Б)    ).should eq 'A и Б'       }
    specify { subject.format_list(%w(A Б В)  ).should eq 'A, Б и В'    }
    specify { subject.format_list(%w(A Б В Г)).should eq 'A, Б, В и Г' }
  end
end
