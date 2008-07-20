class UserController < Ramaze::Controller

  layout '/layout'

  helper :custom

  def index
    #TODO: Make a user profile
    redirect Rs(:login)
  end

  def register
    @user = User.new

    if request.post?
      @user.name = request[:name]
      @user.password = request[:password]
      @user.save
      
      flash[:message] = "Successfully registered, you can now log in with the name #{@user.name}"
      
      redirect Rs(:login)
    end
  rescue
    # Could look into redirecting the user instead because when you refresh with
    # a get it still puts the flash and ask to resend if ctrl+r
    flash[:error] = error_messages_for(@user)
  end

  def login
    if request.post?
      @user = User[:name => request[:name], :password => request[:password]]
    
      if @user.nil?
        flash[:error] = "Couldn't log in. Please try again"
      else
        @user.online = Time.now
        @user.save
        session[:user] = @user
        redirect :/
      end
    end
  end

  def logout
    session[:user] = nil
    redirect :/
  end

end

