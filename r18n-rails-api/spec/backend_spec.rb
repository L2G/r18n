# encoding: utf-8
require File.expand_path('../spec_helper', __FILE__)

describe R18n::Backend do
  before do
    I18n.load_path = [GENERAL]
    I18n.backend = R18n::Backend.new
    R18n.default_places = R18n::Loader::Rails.new
    R18n.set('en')
  end

  it "returns available locales" do
    I18n.available_locales.should =~ [:en, :ru]
  end

  it "localizes objects" do
    time = Time.at(0).utc
    date = Date.parse('1970-01-01')

    I18n.l(time).should eq 'Thu, 01 Jan 1970 00:00:00 +0000'
    I18n.l(date).should eq '1970-01-01'

    I18n.l(time, :format => :short).should eq '01 Jan 00:00'
    I18n.l(time, :format => :full).should eq '1st of January, 1970 00:00'

    I18n.l(-5000.5).should eq '−5,000.5'
  end

  it "translates by key and scope" do
    I18n.t('in.another.level').should               eq 'Hierarchical'
    I18n.t(:level, :scope => 'in.another').should   eq 'Hierarchical'
    I18n.t(:'another.level', :scope => 'in').should eq 'Hierarchical'
  end

  it "uses pluralization and variables" do
    I18n.t('users', :count => 0).should eq '0 users'
    I18n.t('users', :count => 1).should eq '1 user'
    I18n.t('users', :count => 5).should eq '5 users'
  end

  it "uses another separator" do
    I18n.t('in/another/level', :separator => '/').should eq 'Hierarchical'
  end

  it "translates array" do
    I18n.t(['in.another.level', 'in.default']).should eq ['Hierarchical',
                                                          'Default']
  end

  it "uses default value" do
    I18n.t(:missed, :default => 'Default').should eq 'Default'
    I18n.t(:missed, :default => :default, :scope => :in).should eq 'Default'
    I18n.t(:missed, :default => [:also_no, :'in.default']).should eq 'Default'
  end

  it "raises error on no translation" do
    lambda {
      I18n.backend.translate(:en, :missed)
    }.should raise_error(::I18n::MissingTranslationData)
    lambda {
      I18n.t(:missed)
    }.should raise_error(::I18n::MissingTranslationData)
  end

  it "reloads translations" do
    lambda { I18n.t(:other) }.should raise_error(::I18n::MissingTranslationData)
    I18n.load_path << OTHER
    I18n.reload!
    I18n.t(:other).should eq 'Other'
  end

  it "returns plain classes" do
    I18n.t('in.another.level').class.should eq ActiveSupport::SafeBuffer
    I18n.t('in.another').class.should eq Hash
  end

  it "returns correct unpluralized hash" do
    I18n.t('users').should eq({ :one => '1 user', :other => '%{count} users' })
  end

  it "corrects detect untranslated, whem path is deeper than string" do
    lambda {
      I18n.t('in.another.level.deeper')
    }.should raise_error(::I18n::MissingTranslationData)

    lambda {
      I18n.t('in.another.level.go.deeper')
    }.should raise_error(::I18n::MissingTranslationData)
  end

  it "doesn't call String methods" do
    I18n.t('in.another').class.should eq Hash
  end

  it "doesn't call object methods" do
    lambda {
      I18n.t('in.another.level.to_sym')
    }.should raise_error(::I18n::MissingTranslationData)
  end

  it "works deeper pluralization" do
    I18n.t('users.other', :count => 5).should eq '5 users'
  end

  it "returns hash with symbols keys" do
    I18n.t('in').should eq({
      :another => { :level => 'Hierarchical' },
      :default => 'Default'
    })
  end

  it "changes locale in place" do
    I18n.load_path << PL
    I18n.t('users', :count => 5).should eq '5 users'
    I18n.t('users', :count => 5, :locale => :ru).should eq 'Много'

    I18n.l(Date.parse('1970-01-01'), :locale => :ru).should eq '01.01.1970'
  end

  it "has transliterate method" do
    I18n.transliterate('café').should eq 'cafe'
  end

end
