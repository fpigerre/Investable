class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def not_found
    if user_signed_in?
      render 'stocks/404'
    else
      respond_to do |format|
        format.html { render :file => '/public/404.html', status: 404 }
        format.all { render nothing: true, status: 404 }
      end
    end
  end

  def after_sign_in_path_for(resource_or_scope)
    user_root_path
  end

  def after_sign_out_path_for(resource_or_scope)
    root_path
  end

end