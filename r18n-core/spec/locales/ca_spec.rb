# encoding: utf-8
require File.expand_path('../../spec_helper', __FILE__)

describe R18n::Locales::Ca do
  subject { R18n.locale('ca') }

  context "formats lists in Catalan" do
    specify { subject.format_list(%w(A B)    ).should eq 'A i B'       }
    specify { subject.format_list(%w(A B C)  ).should eq 'A, B i C'    }
    specify { subject.format_list(%w(A B C D)).should eq 'A, B, C i D' }
  end
end
