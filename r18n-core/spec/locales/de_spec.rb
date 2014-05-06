# encoding: utf-8
require File.expand_path('../../spec_helper', __FILE__)

describe R18n::Locales::De do
  subject { R18n.locale('de') }

  context "formats lists in German" do
    specify { subject.format_list(%w(A B)    ).should eq 'A und B'       }
    specify { subject.format_list(%w(A B C)  ).should eq 'A, B und C'    }
    specify { subject.format_list(%w(A B C D)).should eq 'A, B, C und D' }
  end
end
