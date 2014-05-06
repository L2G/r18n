# encoding: utf-8
require File.expand_path('../../spec_helper', __FILE__)

describe R18n::Locales::Kk do
  subject { R18n.locale('kk') }

  context "formats lists in Kazakh" do
    specify { subject.format_list(%w(A Ә)    ).should eq 'A, Ә'       }
    specify { subject.format_list(%w(A Ә Б)  ).should eq 'A, Ә, Б'    }
    specify { subject.format_list(%w(A Ә Б B)).should eq 'A, Ә, Б, B' }
  end
end
