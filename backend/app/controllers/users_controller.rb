# frozen_string_literal: true

# Controller for user resource
class UsersController < ApplicationController
  def create
    name = params.require(:user).require(:name)
    email = params.require(:user).require(:email)
    pass = params.require(:user).require(:password)

    user = User.new(
      name: name,
      email: email,
      password: pass
    )

    unless user.save
      head :bad_request, content_type: "text/plain"
      return
    end

    data = {
      id: user.id.to_s,
      name: user.name,
      email: user.email
    }
    render json: { user: data }, status: :created
  end

  def login
    # read params[:user][:email], params[:user][:password] for authenticate!.
    # see config/initializers/warden.rb
    params.require(:user).require(:email)
    params.require(:user).require(:password)

    if warden.authenticate
      render_accepted
    else
      render_not_found
    end
  end

  def logout
    render_not_found and return unless warden.user

    warden.logout
    warden.clear_strategies_cache!
    render_accepted
  end

  def current
    user = warden.user
    render_not_found and return unless user

    data = {
      id: user.id.to_s,
      name: user.name,
      email: user.email
    }
    render json: { user: data }
  end
end
