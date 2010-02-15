class Date
  def to_words(*format)
    _days = self - Date.today
    case _days
      when 21...28 then "Four #{self.strftime("%A")}s from now"
      when 14...21 then "Three #{self.strftime("%A")}s from now"
      when 7...14 then "Next #{self.strftime("%A")}"
      when 2...7 then "This coming #{self.strftime("%A")}"
      when 1 then "Tomorrow"
      when 0 then "Today"
      when -1 then "Yesterday"
      when -7...-1 then "Last #{self.strftime("%A")}"
      when -14...-7 then "Two #{self.strftime("%A")}s ago"
      when -21...-14 then "Three #{self.strftime("%A")}s ago"
      when -28...-21 then "Four #{self.strftime("%A")}s ago"
      else
        self.strftime(*format)
    end
  end
end
