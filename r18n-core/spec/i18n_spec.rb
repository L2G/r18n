# encoding: utf-8
require File.expand_path('../spec_helper', __FILE__)

describe R18n::I18n do
  before do
    @extension_places = R18n.extension_places.clone
  end

  after do
    R18n::I18n.default = 'en'
    R18n.default_loader = R18n::Loader::YAML
    R18n.extension_places = @extension_places
  end

  it "parses HTTP_ACCEPT_LANGUAGE" do
    R18n::I18n.parse_http(nil).should eq []
    R18n::I18n.parse_http('').should eq []
    R18n::I18n.parse_http('ru,en;q=0.9').should eq ['ru', 'en']
    R18n::I18n.parse_http('ru;q=0.8,en;q=0.9').should eq ['en', 'ru']
  end

  it "has default locale" do
    R18n::I18n.default = 'ru'
    R18n::I18n.default.should eq 'ru'
  end

  it "loads locales" do
    i18n = R18n::I18n.new('en', DIR)
    i18n.locales.should eq [R18n.locale('en')]

    i18n = R18n::I18n.new(['ru', 'nolocale-DL'], DIR)
    i18n.locales.should eq [R18n.locale('ru'),
                            R18n::UnsupportedLocale.new('nolocale-DL'),
                            R18n::UnsupportedLocale.new('nolocale'),
                            R18n.locale('en')]
  end

  it "returns translations loaders" do
    i18n = R18n::I18n.new('en', DIR)
    i18n.translation_places.should eq [R18n::Loader::YAML.new(DIR)]
  end

  it "loads translations by loader" do
    loader = Class.new do
      def available; [R18n.locale('en')]; end
      def load(locale); { 'custom' => 'Custom' }; end
    end
    R18n::I18n.new('en', loader.new).custom.should eq 'Custom'
  end

  it "passes parameters to default loader" do
    loader = Class.new do
      def initialize(param); @param = param; end
      def available; [R18n.locale('en')]; end
      def load(locale); { 'custom' => @param }; end
    end
    R18n.default_loader = loader
    R18n::I18n.new('en', 'default').custom.should eq 'default'
  end

  it "loads translations" do
    i18n = R18n::I18n.new(['ru', 'en'], DIR)
    i18n.one.should    eq 'Один'
    i18n[:one].should  eq 'Один'
    i18n['one'].should eq 'Один'
    i18n.only.english.should eq 'Only in English'
  end

  it "loads translations from several dirs" do
    i18n = R18n::I18n.new(['nolocale', 'en'], [TWO, DIR])
    i18n.in.two.should eq 'Two'
    i18n.in.another.level.should eq 'Hierarchical'
  end

  it "uses extension places" do
    R18n.extension_places << EXT

    i18n = R18n::I18n.new('en', DIR)
    i18n.ext.should eq 'Extension'
    i18n.one.should eq 'One'
  end

  it "doesn't use extension without app translations with same locale" do
    R18n.extension_places << EXT

    i18n = R18n::I18n.new(['notransl', 'en'], DIR)
    i18n.ext.should eq 'Extension'
  end

  it "ignores case on loading" do
    i18n = R18n::I18n.new('nolocale', [DIR])
    i18n.one.should eq 'ONE'

    i18n = R18n::I18n.new('nolocale', [DIR])
    i18n.one.should eq 'ONE'
  end

  it "loads default translation" do
    i18n = R18n::I18n.new('nolocale', DIR)
    i18n.one.should eq 'ONE'
    i18n.two.should eq 'Two'
  end

  it "loads sublocales for first locale" do
    R18n::I18n.default = 'notransl'

    i18n = R18n::I18n.new('ru', DIR)
    i18n.one.should eq 'Один'
    i18n.two.should eq 'Two'
  end

  it "returns available translations" do
    i18n = R18n::I18n.new('en', DIR)
    i18n.available_locales.should =~ [R18n.locale('nolocale'),
                                      R18n.locale('ru'),
                                      R18n.locale('en')]
  end

  it "caches translations" do
    counter = CounterLoader.new('en')

    R18n::I18n.new('en', counter)
    counter.loaded.should eq 1

    R18n::I18n.new('en', counter)
    counter.loaded.should eq 1

    R18n.clear_cache!
    R18n::I18n.new('en', counter)
    counter.loaded.should eq 2
  end

  it "doesn't clear cache when custom filters are specified" do
    counter = CounterLoader.new('en')

    R18n::I18n.new('en', counter, :off_filters => :untranslated,
      :on_filters => :untranslated_html)
    counter.loaded.should eq 1

    R18n::I18n.new('en', counter, :off_filters => :untranslated,
      :on_filters => :untranslated_html)
    counter.loaded.should eq 1
  end

  it "caches translations by used locales" do
    counter = CounterLoader.new('en', 'ru')

    R18n::I18n.new('en', counter)
    counter.loaded.should eq 1

    R18n::I18n.new(['en', 'fr'], counter)
    counter.loaded.should eq 1

    R18n::I18n.new(['en', 'ru'], counter)
    counter.loaded.should eq 3

    R18n::I18n.new(['ru', 'en'], counter)
    counter.loaded.should eq 5
  end

  it "caches translations by places" do
    counter = CounterLoader.new('en', 'ru')

    R18n::I18n.new('en', counter)
    counter.loaded.should eq 1

    R18n::I18n.new('en', [counter, DIR])
    counter.loaded.should eq 2

    R18n.extension_places << EXT
    R18n::I18n.new('en', counter)
    counter.loaded.should eq 3

    same = CounterLoader.new('en', 'ru')
    R18n::I18n.new('en', same)
    same.loaded.should eq 0

    different = CounterLoader.new('en', 'fr')
    R18n::I18n.new('en', different)
    different.loaded.should eq 1
  end

  it "reloads translations" do
    loader = Class.new do
      def available; [R18n.locale('en')]; end
      def load(locale);
        @answer ||= 0
        @answer  += 1
        { 'one' => @answer }
      end
    end

    i18n = R18n::I18n.new('en', loader.new)
    i18n.one.should eq 1

    i18n.reload!
    i18n.one.should eq 2
  end

  it "returns translations" do
    i18n = R18n::I18n.new('en', DIR)
    i18n.t.should be_a(R18n::Translation)
    i18n.t.one.should eq 'One'
  end

  it "returns first locale with locale file" do
    i18n = R18n::I18n.new(['notransl', 'nolocale', 'ru', 'en'], DIR)
    i18n.locale.should      eq R18n.locale('nolocale')
    i18n.locale.base.should eq R18n.locale('ru')
  end

  it "localizes objects" do
    i18n = R18n::I18n.new('ru')

    i18n.l(-123456789).should eq '−123 456 789'
    i18n.l(-12345.67).should  eq '−12 345,67'

    time = Time.at(0).utc
    i18n.l(time, '%A').should      eq 'Четверг'
    i18n.l(time, :month).should    eq 'Январь'
    i18n.l(time, :standard).should eq '01.01.1970 00:00'
    i18n.l(time, :full).should     eq ' 1 января 1970 00:00'

    i18n.l(Date.new(0)).should eq '01.01.0000'
  end

  it "returns marshalizable values", :not_ruby => 1.8 do
    i18n    = R18n::I18n.new('en', DIR, :off_filters => :untranslated,
                                        :on_filters  => :untranslated_html)
    demarsh = Marshal.load(Marshal.dump(i18n.t.one))

    i18n.t.one.should        eq demarsh
    i18n.t.one.path.should   eq demarsh.path
    i18n.t.one.locale.should eq demarsh.locale

    demarsh = Marshal.load(Marshal.dump(i18n.t.no_translation))
    i18n.t.no_translation.should eq demarsh
  end

end
