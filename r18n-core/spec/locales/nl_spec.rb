# encoding: utf-8
require File.expand_path('../../spec_helper', __FILE__)

describe R18n::Locales::Nl do
  subject { R18n.locale('nl') }

  context "formats lists in Dutch" do
    specify { subject.format_list(%w(A B)    ).should eq 'A en B'       }
    specify { subject.format_list(%w(A B C)  ).should eq 'A, B en C'    }
    specify { subject.format_list(%w(A B C D)).should eq 'A, B, C en D' }
  end
end
