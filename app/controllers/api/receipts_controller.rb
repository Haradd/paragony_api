# frozen_string_literal: true

module Api
  class ReceiptsController < ApplicationController
    # before_action :authorize_user

    def analyze
      # analyzed_image_json_response = HTTParty.post('http://localhost:8080/get-text-detection',
      #                                              body: { encodedImage: params['encodedImage'] }.to_json,
      #                                              headers: { 'Content-Type' => 'application/json' })

      # render json: analyzed_image_json_response

      render json: mocked_response.to_json
    end

    private

    def mocked_response
      { 'products' =>
        [{ 'name' => 'C PAPRYKA CZERWONA KG ', 'quantity' => 0.228, 'price' => 12.99, 'totalPrice' => 2.96 },
         { 'name' => 'C CEBULA CZERWONA KG ', 'quantity' => 0.076, 'price' => 5.99, 'totalPrice' => 0.46 },
         { 'name' => 'C RABARBAR KG CT ', 'quantity' => 0.766, 'price' => 2.99, 'totalPrice' => 2.29 },
         { 'name' => 'C TWAROG ULUBIONY POL ', 'quantity' => 1.0, 'price' => 2.99, 'totalPrice' => 2.99 },
         { 'name' => 'C MLEKO UHT UCHATE 2% ', 'quantity' => 1.0, 'price' => 2.19, 'totalPrice' => 2.19 }],
        'shopDetails' => nil,
        'totalPrice' => 0.0,
        'errorMessage' => nil }
    end
  end
end
