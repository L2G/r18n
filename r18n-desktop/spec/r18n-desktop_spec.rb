# encoding: utf-8
require File.expand_path('../spec_helper', __FILE__)

describe "r18n-desktop" do
  include R18n::Helpers

  before(:each) do
    R18n.reset!
  end

  it "returns array of system locales" do
    locale = R18n::I18n.system_locale
    locale.class.should eq String
    locale.should_not be_empty
  end

  it "loads I18n from system environment" do
    R18n.from_env
    r18n.class.should eq R18n::I18n
    r18n.locale.should_not be_empty if String == r18n.locale.class
    R18n.get.should eq r18n
  end

  it "loads i18n from system environment using specified order" do
    R18n.from_env(nil, 'en')
    r18n.locale.should eq R18n.locale('en')
    R18n.get.should eq r18n
  end

  it "allows to overide autodetect by LANG environment" do
    R18n::I18n.stub(:system_locale).and_return('ru')
    ENV['LANG'] = 'en'
    R18n.from_env
    r18n.locale.should eq R18n.locale('en')
  end

end
