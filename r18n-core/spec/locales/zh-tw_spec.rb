# encoding: utf-8
require File.expand_path('../../spec_helper', __FILE__)

describe R18n::Locales::ZhTw do
  subject { R18n.locale('zh-tw') }

  context "formats lists in Chinese" do
    specify { subject.format_list(%w(Ａ Ｂ)      ).should eq 'Ａ和Ｂ'         }
    specify { subject.format_list(%w(Ａ Ｂ Ｃ)   ).should eq 'Ａ、Ｂ和Ｃ'     }
    specify { subject.format_list(%w(Ａ Ｂ Ｃ Ｄ)).should eq 'Ａ、Ｂ、Ｃ和Ｄ' }
  end
end
