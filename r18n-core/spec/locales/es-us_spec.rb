# encoding: utf-8
require File.expand_path('../../spec_helper', __FILE__)

describe R18n::Locales::EsUs do
  subject { R18n.locale('es-us') }

  context "formats lists in U.S. Spanish" do
    specify { subject.format_list(%w(A B)    ).should eq 'A y B'       }
    specify { subject.format_list(%w(A B C)  ).should eq 'A, B y C'    }
    specify { subject.format_list(%w(A B C D)).should eq 'A, B, C y D' }
  end
end
