Rails.configuration.middleware.use Warden::Manager do |manager|
  manager.default_strategies :password
end

Warden::Manager.serialize_into_session(&:id)
Warden::Manager.serialize_from_session do |id|
  User.find(id)
end

Warden::Strategies.add(:password) do
  def valid?
    u = params["user"]
    u && u["email"] && u["password"]
  end

  def authenticate!
    email = params["user"]["email"]
    pass = params["user"]["password"]
    u = User.authenticate(email, pass)
    u ? success!(u) : fail!("user not found")
  end
end

# rubocop:disable all
# monkey path for json input; refs https://github.com/wardencommunity/warden/issues/84#issuecomment-51390483
module Warden::Mixins::Common
  def request
    @request ||= ActionDispatch::Request.new(@env)
  end
end
# rubocop:enable all
