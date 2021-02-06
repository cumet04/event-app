if Rails.env.development? || Rails.env.test?
  Backend::Application.config.tap do |config|
    committee_params = {
      schema_path: Rails.root.join("../api/api.yml").to_s,
      prefix: "/api",
      raise: true,
      parse_response_by_content_type: true,
      check_content_type: false # minitestでparams: {...}で渡す場合に検証されると面倒なので無効化
    }
    config.middleware.use(Committee::Middleware::RequestValidation, committee_params)
    config.middleware.use(Committee::Middleware::ResponseValidation, committee_params)
  end
end
