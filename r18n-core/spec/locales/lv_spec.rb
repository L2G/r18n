# encoding: utf-8
require File.expand_path('../../spec_helper', __FILE__)

describe R18n::Locales::Lv do
  subject { R18n.locale('lv') }

  context "formats lists in Latvian" do
    specify { subject.format_list(%w(A Ā)    ).should eq 'A un Ā'       }
    specify { subject.format_list(%w(A Ā B)  ).should eq 'A, Ā un B'    }
    specify { subject.format_list(%w(A Ā B C)).should eq 'A, Ā, B un C' }
  end
end
