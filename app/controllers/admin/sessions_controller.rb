class Admin::SessionsController < Admin::AdminController
  skip_filter :login_required

  def new
  end
  
  def create
    user = User.authenticate(params[:login], params[:password])
    if user
      session[:user] = user
      flash[:notice] = "Logged in successfully."
      redirect_to_target_or_default(admin_root_url)
    else
      flash.now[:error] = "Invalid login or password."
      render :action => 'new'
    end
  end
  
  def destroy
    session[:user] = nil
    flash[:notice] = "You have been logged out."
    redirect_to root_url
  end
end
