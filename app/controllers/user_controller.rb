class UserController < ApplicationController
  layout '_stocks.html.erb'
  before_action :authenticate_user!

  def show
    @user = User.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @user }
    end
  end

  # GET /settings
  def edit
    @user = current_user
    respond_to do |format|
      format.html # edit.html.erb
    end
  end
end