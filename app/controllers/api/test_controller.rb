# frozen_string_literal: true

module Api
  class TestController < ApplicationController
    before_action :authorize_user

    def index
      binding.pry
      render json: { test: 'ok' }
    end
  end
end
