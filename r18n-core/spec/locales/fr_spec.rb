require File.expand_path('../../spec_helper', __FILE__)

describe R18n::Locales::Fr do
  it "formats French date" do
    fr = R18n::I18n.new('fr')
    fr.l(Date.parse('2009-07-01'), :full).should ==  '1er juillet 2009'
    fr.l(Date.parse('2009-07-02'), :full).should ==  ' 2 juillet 2009'
  end

  context "formats lists in French" do
    subject { R18n.locale('fr') }
    specify { subject.format_list(%w(A B)    ).should eq 'A et B'       }
    specify { subject.format_list(%w(A B C)  ).should eq 'A, B et C'    }
    specify { subject.format_list(%w(A B C D)).should eq 'A, B, C et D' }
  end
end
