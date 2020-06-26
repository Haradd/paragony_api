# frozen_string_literal: true

class JwtAuthenticatable < Warden::Strategies::Base
  def authenticate! # rubocop:disable Metrics/MethodLength
    payload = JwtService.decode(token: token)
    user = User.find_by(id: payload['sub'])
    if user.present?
      success!(user)
    else
      fail!
    end
  rescue ::JWT::ExpiredSignature
    fail! 'Auth token has expired. Please login again'
  rescue ::JWT::DecodeError
    fail! 'Auth token is invalid'
  rescue StandardError
    fail!
  end

  def token
    authorization_header.split(' ').second
  end

  def valid?
    authorization_header.present? && has_bearer_token?
  end

  def store?
    false
  end

  private

  def authorization_header
    request.headers['X-Authorization'] || request.authorization
  end

  def has_bearer_token?
    authorization_header&.start_with?('Bearer ')
  end
end

Warden::Strategies.add(:jwt_authenticatable, JwtAuthenticatable)
