module SessionTestHelper
  def sign_in
    @current_user ||= create(:user)
    session[:user_id] ||= @current_user.id
  end
end
