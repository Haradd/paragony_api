# frozen_string_literal: true

class JwtService
  def self.encode(payload:, exp: 8.hours.from_now)
    payload[:exp] = exp.to_i
    JWT.encode(payload, secret)
  end

  def self.decode(token:)
    JWT.decode(token, secret).first
  end

  def self.secret
    Rails.application.secrets.secret_key_base
  end
end
