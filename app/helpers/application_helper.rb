module ApplicationHelper

  def login_links
    if signed_in_user?
      str = "#{render partial: 'logged_in_header'}"
    else
      str = "#{render partial: 'logged_out_header'}"
    end
    str.html_safe
  end
end
