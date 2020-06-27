# frozen_string_literal: true

class ApplicationController < ::ActionController::API
  include ActionController::MimeResponds

  private

  def authorize_user
    warden.authenticate!
  end

  def render_json(data, status = :ok)
    render json: { data: data }, status: status
  end

  def render_errors(hash)
    render json: { errors: hash }, status: :unprocessable_entity
  end
end
