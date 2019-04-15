# frozen_string_literal: true

module ApplicationHelper
  def formatted_date(date)
    date.try(:to_date).try(:strftime, '%d-%m-%Y')
  end

  def formatted_datetime(datetime)
    datetime.try(:strftime, '%d-%m-%Y %I:%M %p')
  end
end
