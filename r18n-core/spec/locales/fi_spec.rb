# encoding: utf-8
require File.expand_path('../../spec_helper', __FILE__)

describe R18n::Locales::Fi do
  subject { R18n.locale('fi') }

  context "formats lists in Finnish" do
    specify { subject.format_list(%w(A Å)    ).should eq 'A ja Å'       }
    specify { subject.format_list(%w(A Å Ä)  ).should eq 'A, Å ja Ä'    }
    specify { subject.format_list(%w(A Å Ä B)).should eq 'A, Å, Ä ja B' }
  end
end
