# frozen_string_literal: true

# API base controller
class ApplicationController < ActionController::API
  def warden
    request.env["warden"]
  end

  def render_accepted
    head :accepted, content_type: "text/plain"
  end

  def render_not_found
    head :not_found, content_type: "text/plain"
  end
end
