module ApplicationHelper
  def current_user
    @user ||= User.find(session[:user_id])
  end

  def current_corp
    @corp ||= current_user.main.nil? ? false : Corp.find_by_ccp_id(current_user.main.corporationID)
  end

  def user_signed_in?
    !session[:user_id].nil?
  end

  def page_title(title)
    content_tag :h1, class: "page-title" do
      link_to( icon('bars'), "#", class: "menu-toggle") +
      content_tag(:span, title)
    end
  end

  def flash_message(type, text)
    flash[type] ||= []
    flash[type] << text
  end

  def render_flash
    output = ""
    flash.each do |type, messages|
      messages.each do |m|
        output << content_tag( :div, m, class: "#{type} label" )
      end
    end
    output.html_safe
  end
end
