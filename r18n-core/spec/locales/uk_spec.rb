# encoding: utf-8
require File.expand_path('../../spec_helper', __FILE__)

describe R18n::Locales::Uk do
  subject { R18n.locale('uk') }

  context "formats lists in Ukrainian" do
    specify { subject.format_list(%w(А Б)    ).should eq 'А та Б'       }
    specify { subject.format_list(%w(А Б В)  ).should eq 'А, Б та В'    }
    specify { subject.format_list(%w(А Б В Г)).should eq 'А, Б, В та Г' }
  end
end
