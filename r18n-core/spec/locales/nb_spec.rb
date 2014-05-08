# encoding: utf-8
require File.expand_path('../../spec_helper', __FILE__)

describe R18n::Locales::Nb do
  subject { R18n.locale('nb') }

  context "formats lists in Norwegian Bokmål" do
    specify { subject.format_list(%w(A Å)    ).should eq 'A og Å'       }
    specify { subject.format_list(%w(A Å Æ)  ).should eq 'A, Å og Æ'    }
    specify { subject.format_list(%w(A Å Æ B)).should eq 'A, Å, Æ og B' }
  end
end
