# frozen_string_literal: true

# Controller for user resource
class UsersController < ApplicationController
  def create
    name = params.require(:user).require(:name)
    email = params.require(:user).require(:email)
    params.require(:user).require(:password)

    user = {
      id: "1",
      name: name,
      email: email
    }

    render json: { user: user }, status: :created
  end

  def login
    params.require(:user).require(:email)
    params.require(:user).require(:password)

    head :accepted
  end

  def logout
    head :accepted
  end

  def current
    user = {
      id: "1",
      name: "you",
      email: "you@example.com"
    }

    render json: { user: user }
  end
end
