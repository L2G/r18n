# encoding: utf-8
require File.expand_path('../spec_helper', __FILE__)

describe TestController, :type => :controller do
  render_views

  it "uses default locale" do
    get :locales
    response.should be_success
    response.body.should eq 'ru'
  end

  it "gets locale from param" do
    get :locales, :locale => 'ru'
    response.should be_success
    response.body.should eq 'ru, en'
  end

  it "gets locale from session" do
    get :locales, {}, { :locale => 'ru' }
    response.should be_success
    response.body.should eq 'ru, en'
  end

  it "gets locales from http" do
    request.env['HTTP_ACCEPT_LANGUAGE'] = 'ru,fr;q=0.9'
    get :locales
    response.should be_success
    response.body.should eq 'ru, fr, en'
  end

  it "loads translations" do
    get :translations, :locale => 'en'
    response.should be_success
    response.body.should eq 'R18n: supported. Rails I18n: supported'
  end

  it "returns available translations" do
    get :available
    response.should be_success
    response.body.should eq 'en ru'
  end

  it "adds helpers" do
    get :helpers, :locale => 'en'
    response.should be_success
    response.body.should eq "Name\nName\nName\nName\n"
  end

  it "formats untranslated" do
    get :untranslated
    response.should be_success
    response.body.should eq 'user.<span style="color: red">[not.exists]</span>'
  end

  it "adds methods to controller" do
    get :controller, :locale => 'en'
    response.should be_success
    response.body.should eq "Name Name Name"
  end

  it "localizes time by Rails I18n" do
    get :time, :locale => 'en'
    response.should be_success
    response.body.should eq "Thu, 01 Jan 1970 00:00:00 +0000\n01 Jan 00:00"
  end

  it "localizes time by R18n" do
    get :human_time, :locale => 'en'
    response.should be_success
    response.body.should eq "now"
  end

  it "translates models" do
    ActiveRecord::Schema.verbose = false
    ActiveRecord::Schema.define(:version => 20091218130034) do
      create_table "posts", :force => true do |t|
        t.string "title_en"
        t.string "title_ru"
      end
    end

    Post.unlocalized_getters(:title).should eq({ 'ru' => 'title_ru',
                                                 'en' => 'title_en' })
    Post.unlocalized_setters(:title).should eq({ 'ru' => 'title_ru=',
                                                 'en' => 'title_en=' })

    @post = Post.new
    @post.title_en = 'Record'

    R18n.set('ru')
    @post.title.should eq 'Record'

    @post.title = 'Запись'
    @post.title_ru.should eq 'Запись'
    @post.title_en.should eq 'Record'
    @post.title.should    eq 'Запись'
  end

  it "sets default places" do
    R18n.default_places.should eq [Rails.root.join('app/i18n'),
                                   R18n::Loader::Rails.new]
    R18n.set('en')
    R18n.get.user.name.should eq 'Name'
  end

  it "translates mails" do
    R18n.set('en')
    email = TestMailer.test.deliver
    email.body.to_s.should eq "Name\nName\nName\n"
  end

  it "reloads filters from app directory" do
    get :filter, :locale => 'en'
    response.should be_success
    response.body.should eq 'Rails'
    R18n::Rails::Filters.loaded.should eq [:rails_custom_filter]

    R18n::Filters.defined[:rails_custom_filter].block = proc { 'No' }
    get :filter, :locale => 'en'

    response.should be_success
    response.body.should eq 'Rails'
  end

  it "escapes html inside R18n" do
    get :safe, :locale => 'en'
    response.should be_success
    response.body.should eq(
      "<b> user.<span style=\"color: red\">[no_tr]</span>\n")
  end

  it "works with Rails build-in herlpers" do
    get :format
    response.should be_success
    response.body.should eq "1 000,1 руб.\n"
  end

  it "caches I18n object" do
    R18n.clear_cache!

    get :translations
    R18n.cache.keys.length.should eq 1

    get :translations
    R18n.cache.keys.length.should eq 1

    get :translations
    request.env['HTTP_ACCEPT_LANGUAGE'] = 'ru,fr;q=0.9'
    R18n.cache.keys.length.should eq 1

    get :translations, :locale => 'en'
    R18n.cache.keys.length.should eq 2
  end

  it "parameterizes strigns" do
    'One two три'.parameterize.should eq 'one-two'
  end

end
