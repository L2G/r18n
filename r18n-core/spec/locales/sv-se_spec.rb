# encoding: utf-8
require File.expand_path('../../spec_helper', __FILE__)

describe R18n::Locales::SvSe do
  subject { R18n.locale('sv-se') }

  context "formats lists in Swedish" do
    specify { subject.format_list(%w(A B)    ).should eq 'A och B'       }
    specify { subject.format_list(%w(A B C)  ).should eq 'A, B och C'    }
    specify { subject.format_list(%w(A B C D)).should eq 'A, B, C och D' }
  end
end
