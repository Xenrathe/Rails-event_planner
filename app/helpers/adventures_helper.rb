module AdventuresHelper
  def formatted_date(date)
    if user_signed_in?
      date = date.in_time_zone(current_user.timezone)
    else
      date = date.in_time_zone("Eastern Time (US & Canada)")
    end
    # Format the date, e.g.: Nov 21, 2023 - 4:25 pm
    if user_signed_in?
      date.strftime('%b %-d, %Y - %l:%M %P')
    else
      date.strftime('%b %-d, %Y - %l:%M %P') + ' EST'
    end
  end
end