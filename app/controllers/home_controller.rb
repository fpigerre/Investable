class HomeController < DeviseController
  layout '_home.html.erb'

  # GET /home
  def index
    if user_signed_in?
      redirect_to user_root_path
    else
      respond_to do |format|
        format.html # index.html.erb
      end
    end
  end

  def resource_name
    :user
  end

  def resource
    @resource ||= User.new
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end
end