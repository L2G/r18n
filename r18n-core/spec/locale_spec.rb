# encoding: utf-8
require File.expand_path('../spec_helper', __FILE__)
require 'bigdecimal'

describe R18n::Locale do
  before :all do
    @ru = R18n.locale('ru')
    @en = R18n.locale('en')
  end

  it "returns all available locales" do
    R18n::Locale.available.class.should eq Array
    R18n::Locale.available.should_not be_empty
  end

  it "checks is locale exists" do
    R18n::Locale.exists?('ru').should be_true
    R18n::Locale.exists?('nolocale').should be_false
  end

  it "sets locale properties" do
    locale_class = Class.new(R18n::Locale) do
      set :one => 1
      set :two => 2
    end
    locale = locale_class.new
    locale.one.should eq 1
    locale.two.should eq 2
  end

  it "loads locale" do
    @ru.class.should eq R18n::Locales::Ru
    @ru.code.should  eq 'ru'
    @ru.title.should eq 'Русский'
  end

  it "loads locale by Symbol" do
    R18n.locale(:ru).should eq R18n.locale('ru')
  end

  it "equals to another locale with same code" do
    @en.should_not eq @ru
    @en.should eq R18n.locale('en')
  end

  it "prints human readable representation" do
    @ru.inspect.should eq 'Locale ru (Русский)'
  end

  it "returns pluralization type by elements count" do
    @en.pluralize(0).should eq 0
    @en.pluralize(1).should eq 1
    @en.pluralize(5).should eq 'n'
  end

  it "uses UnsupportedLocale if locale file isn't exists" do
    @en.should be_supported

    unsupported = R18n.locale('nolocale-DL')
    unsupported.should_not be_supported
    unsupported.should be_a(R18n::UnsupportedLocale)

    unsupported.code.downcase.should  eq 'nolocale-dl'
    unsupported.title.downcase.should eq 'nolocale-dl'
    unsupported.ltr?.should be_true

    unsupported.pluralize(5).should eq 'n'
    unsupported.inspect.downcase.should eq 'unsupported locale nolocale-dl'
  end

  it "formats number in local traditions" do
    @en.localize(-123456789).should eq "−123,456,789"
  end

  it "formats float in local traditions" do
    @en.localize(-12345.67).should eq "−12,345.67"
    @en.localize(BigDecimal.new("-12345.67")).should eq "−12,345.67"
  end

  it "translates month, week days and am/pm names in strftime" do
    i18n = R18n::I18n.new('ru')
    time = Time.at(0).utc

    @ru.localize(time, '%a %A').should eq 'Чтв Четверг'
    @ru.localize(time, '%b %B').should eq 'янв января'
    @ru.localize(time, '%H:%M%p').should eq '00:00 утра'
  end

  it "generates locale code by locale class name" do
    R18n.locale('ru').code.should    eq 'ru'
    R18n.locale('zh-CN').code.should eq 'zh-CN'
  end

  it "localizes date for human" do
    i18n = R18n::I18n.new('en')

    @en.localize(Date.today + 2, :human, i18n).should eq 'after 2 days'
    @en.localize(Date.today + 1, :human, i18n).should eq 'tomorrow'
    @en.localize(Date.today,     :human, i18n).should eq 'today'
    @en.localize(Date.today - 1, :human, i18n).should eq 'yesterday'
    @en.localize(Date.today - 3, :human, i18n).should eq '3 days ago'

    y2k = Date.parse('2000-01-08')
    @en.localize(y2k, :human, i18n, y2k + 8  ).should eq '8th of January'
    @en.localize(y2k, :human, i18n, y2k - 365).should eq '8th of January, 2000'
  end

  it "localizes times for human" do
    minute = 60
    hour   = 60 * minute
    day    = 24 * hour
    zero   = Time.at(0).utc
    p = [:human, R18n::I18n.new('en'), zero]

    @en.localize( zero + 7  * day,    *p).should eq '8th of January 00:00'
    @en.localize( zero + 50 * hour,   *p).should eq 'after 2 days 02:00'
    @en.localize( zero + 25 * hour,   *p).should eq 'tomorrow 01:00'
    @en.localize( zero + 70 * minute, *p).should eq 'after 1 hour'
    @en.localize( zero + hour,        *p).should eq 'after 1 hour'
    @en.localize( zero + 38 * minute, *p).should eq 'after 38 minutes'
    @en.localize( zero + 5,           *p).should eq 'now'
    @en.localize( zero - 15,          *p).should eq 'now'
    @en.localize( zero - minute,      *p).should eq '1 minute ago'
    @en.localize( zero - hour + 59,   *p).should eq '59 minutes ago'
    @en.localize( zero - 2  * hour,   *p).should eq '2 hours ago'
    @en.localize( zero - 13 * hour,   *p).should eq 'yesterday 11:00'
    @en.localize( zero - 50 * hour,   *p).should eq '3 days ago 22:00'

    @en.localize( zero - 9  * day,  *p).should eq '23rd of December, 1969 00:00'
    @en.localize( zero - 365 * day, *p).should eq '1st of January, 1969 00:00'
  end

  it "uses standard formatter by default" do
    @ru.localize(Time.at(0).utc).should eq '01.01.1970 00:00'
  end

  it "doesn't localize time without i18n object" do
    @ru.localize(Time.at(0)).should_not eq Time.at(0).to_s
    @ru.localize(Time.at(0), :full).should_not eq Time.at(0).to_s

    @ru.localize(Time.at(0), :human).should eq Time.at(0).to_s
  end

  it "raises error on unknown formatter" do
    lambda {
      @ru.localize(Time.at(0).utc, R18n::I18n.new('ru'), :unknown)
    }.should raise_error(ArgumentError, /formatter/)
  end

  it "deletes slashed from locale for security reasons" do
    locale = R18n.locale('../spec/translations/general/en')
    locale.should be_a(R18n::UnsupportedLocale)
  end

  it "ignores code case in locales" do
    upcase   = R18n.locale('RU')
    downcase = R18n.locale('ru')
    upcase.should eq downcase
    upcase.code.should   eq 'ru'
    downcase.code.should eq 'ru'

    upcase   = R18n.locale('nolocale')
    downcase = R18n.locale('nolocale')
    upcase.should eq downcase
    upcase.code.should   eq 'nolocale'
    downcase.code.should eq 'nolocale'
  end

  it "loads locale with underscore" do
    R18n.locale('nolocale-DL').code.should eq 'nolocale-dl'
  end

end
