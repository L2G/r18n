# encoding: utf-8
require File.expand_path('../spec_helper', __FILE__)

describe R18n::Translation do

  it "returns unstranslated string if translation isn't found" do
    i18n = R18n::I18n.new('en', DIR)
    i18n.not.exists.should be_a(R18n::Untranslated)
    i18n.not.exists.should_not be_translated
    (i18n.not.exists | 'default').should eq 'default'
    i18n.not.exists.locale.should eq R18n.locale('en')

    i18n.not.exists.should eq i18n.not.exists
    i18n.not.exists.should_not eq i18n.not.exists2

    (i18n.in | 'default').should eq 'default'

    i18n.one.should be_translated
    (i18n.one | 'default').should eq 'One'
  end

  it "returns html escaped string" do
    klass = Class.new(R18n::TranslatedString) do
      def html_safe
        '2'
      end
    end
    str = klass.new('1', nil, nil)

    str.should be_html_safe
    str.html_safe.should eq '2'
  end

  it "loads use hierarchical translations" do
    i18n = R18n::I18n.new(['ru', 'en'], DIR)
    i18n.in.another.level.should eq 'Иерархический'
    i18n[:in][:another][:level].should eq 'Иерархический'
    i18n['in']['another']['level'].should eq 'Иерархический'
    i18n.only.english.should eq 'Only in English'
  end

  it "saves path for translation" do
    i18n = R18n::I18n.new('en', DIR)

    i18n.in.another.level.path.should eq 'in.another.level'

    i18n.in.another.not.exists.path.should eq 'in.another.not.exists'
    i18n.in.another.not.exists.untranslated_path.should eq 'not.exists'
    i18n.in.another.not.exists.translated_path.should eq 'in.another.'

    i18n.not.untranslated_path.should eq 'not'
    i18n.not.translated_path.should eq ''
  end

  it "returns translation keys" do
    i18n = R18n::I18n.new('en', [DIR, TWO])
    i18n.in.translation_keys.should =~ ['another', 'two']
  end

  it "returns string with locale info" do
    i18n = R18n::I18n.new(['nolocale', 'en'], DIR)
    i18n.one.locale.should eq R18n::UnsupportedLocale.new('nolocale')
    i18n.two.locale.should eq R18n.locale('en')
  end

  it "filters typed data" do
    en = R18n.locale('en')
    translation = R18n::Translation.new(en, '', :locale => en, :translations =>
      { 'count' => R18n::Typed.new('pl', { 1 => 'one', 'n' => 'many' }) })

    translation.count(1).should eq 'one'
    translation.count(5).should eq 'many'
  end

  it "returns hash of translations" do
    i18n = R18n::I18n.new('en', DIR)
    i18n.in.to_hash.should eq({
      'another' => { 'level' => 'Hierarchical' }
    })
  end

  it "returns untranslated, when we go deeper string" do
    en = R18n.locale('en')
    translation = R18n::Translation.new(en, '',
      :locale => en, :translations => { 'a' => 'A' })

    translation.a.no_tr.should be_a(R18n::Untranslated)
    translation.a.no_tr.translated_path.should   eq 'a.'
    translation.a.no_tr.untranslated_path.should eq 'no_tr'
  end

  it "inspects translation" do
    en = R18n.locale('en')

    translation = R18n::Translation.new(en, 'a',
      :locale => en, :translations => { 'a' => 'A' })
    translation.inspect.should eq 'Translation `a` for en {"a"=>"A"}'

    translation = R18n::Translation.new(en, '',
      :locale => en, :translations => { 'a' => 'A' })
    translation.inspect.should eq 'Translation root for en {"a"=>"A"}'

    translation = R18n::Translation.new(en, '')
    translation.inspect.should eq 'Translation root for en {}'
  end

end
