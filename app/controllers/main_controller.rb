class MainController < ApplicationController
  def index
  end

  def authorize
    if (params[:password] != params[:passwordConf])
      render body: 'Passwords do not match.', status: 400
    elsif params[:email] && params[:password]
      userData = { email: params[:email], password_digest: params[:password] }
      if user = User.create(userData) and user.persisted?
        session[:userId] = user.id
        redirect_to profile_path
      else
        render body: user.errors.full_messages.join, status: 401
      end
    elsif params[:logemail] && params[:logpassword]
      if user = User.authenticate(params[:logemail], params[:logpassword])
        session[:userId] = user.id
        redirect_to profile_path
      else
        render body: 'Wrong email or password.', status: 401
      end
    else
      render body: 'All fields required.', status: 400
    end
  end

  def profile
    unless @user = User.find_by_id(session[:userId])
      render body: 'Not authorized! Go back!', status: 400
    end
  end

  def logout
    session.destroy
    redirect_to root_path
  end

  def delete
    user = User.find(session[:userId])

    if user
      user.destroy
      session.destroy
      redirect_to root_path
    else
      render body: 'Not authorized! Go back!', status: 400
    end
  end
end