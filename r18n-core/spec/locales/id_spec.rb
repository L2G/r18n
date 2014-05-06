# encoding: utf-8
require File.expand_path('../../spec_helper', __FILE__)

describe R18n::Locales::Id do
  subject { R18n.locale('id') }

  context "formats lists in Indonesian" do
    specify { subject.format_list(%w(A B)    ).should eq 'A dan B'        }
    specify { subject.format_list(%w(A B C)  ).should eq 'A, B, dan C'    }
    specify { subject.format_list(%w(A B C D)).should eq 'A, B, C, dan D' }
  end
end
