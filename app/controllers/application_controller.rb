# frozen_string_literal: true

class ApplicationController < ::ActionController::API
  include ActionController::MimeResponds

  private

  def authorize_user
    warden.authenticate!
  end
end
