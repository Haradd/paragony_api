# frozen_string_literal: true

Rails.configuration.middleware.use RailsWarden::Manager do |manager|
  manager.failure_app = proc do |_env|
    ['401', { 'Content-Type' => 'application/json' }, [{ error: 'Unauthorized request' }.to_json]]
  end
  manager.default_strategies :jwt_authenticatable # needs to be defined
end
