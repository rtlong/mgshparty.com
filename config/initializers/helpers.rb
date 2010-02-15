module ActionView
  module Helpers
    module DateHelper
      def time_ago_in_words_with_ago(from_time, include_seconds = false)
        time_ago_in_words_without_ago(from_time, include_seconds) + " ago"
      end
      alias_method_chain :time_ago_in_words, :ago
    end
    
    module NumberHelper
      def number_to_phone_with_e123(number, options = {})
        options = {:delimiter => " ", :area_code => true}.merge(options)
        number_to_phone_without_e123(number, options)
      end
      alias_method_chain :number_to_phone, :e123
    end
  end
end
