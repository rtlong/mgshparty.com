module ActionView
  module Helpers
    module DateHelper
      def time_ago_in_words_with_ago(from_time, include_seconds = false)
        time_ago_in_words_without_ago(from_time, include_seconds) + " ago"
      end
      alias_method_chain :time_ago_in_words, :ago
    end
  end
end
