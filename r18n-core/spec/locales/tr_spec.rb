# encoding: utf-8
require File.expand_path('../../spec_helper', __FILE__)

describe R18n::Locales::Tr do
  subject { R18n.locale('tr') }

  context "formats lists in Turkish" do
    specify { subject.format_list(%w(A B)    ).should eq 'A ve B'       }
    specify { subject.format_list(%w(A B C)  ).should eq 'A, B ve C'    }
    specify { subject.format_list(%w(A B C D)).should eq 'A, B, C ve D' }
  end
end
