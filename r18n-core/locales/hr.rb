# encoding: utf-8
module R18n
  class Locales::Hr < Locale
    set :title => 'Hrvatski',

        :week_start => :monday,
        :wday_names => %w{Nedjelja Ponedjeljak Utorak Srijeda Četvrtak Petak
                          Subota},
        :wday_abbrs => %w{Ned Pon Uto Sri Čet Pet Sub},

        :month_names => %w{Siječanj Veljača Ožujak Travanj Svibanj Lipanj Srpanj Kolovoz
                           Rujan Listopad Studeni Prosinac},
        :month_abbrs => %w{Sij Velj Ožu Tra Svi Lip Srp Kol Ruj Lis Stu Pro},

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
