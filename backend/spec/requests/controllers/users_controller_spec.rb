# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Users", type: :request do
  let(:new_user_param) do
    {
      name: "newone",
      email: "newone@example.com",
      password: "Password0"
    }
  end
  let(:login_user_param) do
    {
      email: "newone@example.com",
      password: "Password0"
    }
  end

  it "register new user" do
    put users_url, params: { user: new_user_param }
    assert_response :created
  end

  it "get current user" do
    get users_current_url
    assert_response :success
  end

  it "login" do
    post users_session_url, params: { user: login_user_param }
    assert_response :accepted
  end

  it "logout" do
    delete users_session_url
    assert_response :accepted
  end
end
