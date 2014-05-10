# encoding: utf-8
module R18n
  class Locales::SrLatn < Locale
    set :title => 'Srpski',
        :sublocales => [],

        :week_start => :monday,
        :wday_names => %w{nedelja ponedeljak utorak sreda četvrtak petak
                          subota},
        :wday_abbrs => %w{ned pon uto sri čet pet sub},

        :month_names => %w{januar februar mart april maj juni juli avgust
                           septembar oktobar novembar decembar},
        :month_abbrs => %w{jan feb mar apr maj jun jul avg sep okt nov dec},

        :date_format => '%d.%m.%Y',
        :full_format => '%e. %B',

        :number_decimal => ",",
        :number_group   => ".",

        :list_2 => '%1 i %2'

    def pluralize(n)
      if 0 == n
        0
      elsif n == 1
        1
      elsif n >= 2 and n <= 4
        2
      else
        'n'
      end
    end
  end
end
