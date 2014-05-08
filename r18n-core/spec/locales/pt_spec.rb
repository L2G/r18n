# encoding: utf-8
require File.expand_path('../../spec_helper', __FILE__)

describe R18n::Locales::Pt do
  subject { R18n.locale('pt') }

  context "formats lists in Portuguese" do
    specify { subject.format_list(%w(A B)    ).should eq 'A e B'       }
    specify { subject.format_list(%w(A B C)  ).should eq 'A, B e C'    }
    specify { subject.format_list(%w(A B C D)).should eq 'A, B, C e D' }
  end
end
