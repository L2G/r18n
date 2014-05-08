# encoding: utf-8
require File.expand_path('../../spec_helper', __FILE__)

describe R18n::Locales::SrLatn do
  subject { R18n.locale('sr-latn') }

  context "formats lists in Serbian (Latin script)" do
    specify { subject.format_list(%w(A B)    ).should eq 'A i B'       }
    specify { subject.format_list(%w(A B C)  ).should eq 'A, B i C'    }
    specify { subject.format_list(%w(A B C Ć)).should eq 'A, B, C i Ć' }
  end
end
