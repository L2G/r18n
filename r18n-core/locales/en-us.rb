# encoding: utf-8

require File.join(File.dirname(__FILE__), 'en')

module R18n::Locales
  class EnUs < En
    set :title => 'American English',
        :sublocales => %w{en},

        :time_format => ' %I:%M %p',
        :date_format => '%m/%d/%Y',
        :full_format => '%B %e',

        :list_end => '%1, and %2'
  end
end
