# frozen_string_literal: true

module Api
  class ReceiptsController < ApplicationController
    before_action :authorize_user

    def index
      receipts = Receipt.where(user_id: current_user.id)
      render json: receipts
    end

    def show
      receipt = Receipt.where(user_id: current_user.id).find(params[:id])
      render json: receipt, include: [:products], serializer: ::ReceiptSerializer
    end

    def create
      receipt = Receipt.new(
        user: current_user,
        products_attributes: products_params,
        shop_details: permitted_params[:shopDetails],
        total_price: permitted_params[:totalPrice],
        date: permitted_params[:date]
      )

      if receipt.save
        render json: receipt
      else
        render_errors(receipt.errors)
      end
    end

    def destroy
      receipt = Receipt.where(user_id: current_user.id).find(params[:id])
      if receipt.destroy
        head :ok
      else
        render_error(receipt.errors)
      end
    end

    def analyze
      # analyzed_image_json_response = HTTParty.post('http://localhost:8080/get-text-detection',
      #                                              body: { encodedImage: params['encodedImage'] }.to_json,
      #                                              headers: { 'Content-Type' => 'application/json' })

      # render json: analyzed_image_json_response

      render json: mocked_response.to_json
    end

    private

    def permitted_params
      params.permit(:date, :shopDetails, :totalPrice, products:
        %i(name quantity price totalPrice category))
    end

    def products_params
      permitted_params.to_h[:products].map { |product| product.transform_keys(&:underscore).merge(user: current_user) }
    end

    def mocked_response
      # { 'products' =>
      #   [{ 'name' => 'C PAPRYKA CZERWONA KG ', 'quantity' => 0.228, 'price' => 12.99, 'totalPrice' => 2.96 },
      #    { 'name' => 'C CEBULA CZERWONA KG ', 'quantity' => 0.076, 'price' => 5.99, 'totalPrice' => 0.46 },
      #    { 'name' => 'C RABARBAR KG CT ', 'quantity' => 0.766, 'price' => 2.99, 'totalPrice' => 2.29 },
      #    { 'name' => 'C TWAROG ULUBIONY POL ', 'quantity' => 1.0, 'price' => 2.99, 'totalPrice' => 2.99 },
      #    { 'name' => 'C MLEKO UHT UCHATE 2% ', 'quantity' => 1.0, 'price' => 2.19, 'totalPrice' => 2.19 }],
      #   'shopDetails' => nil,
      #   'totalPrice' => 0.0,
      #   'errorMessage' => nil }

      {
        products: [
          {
            name: 'BUŁKA GRYCZANA ŚW. I ',
            quantity: 2.0,
            price: 0.89,
            totalPrice: 1.78
          },
          {
            name: 'PAPRYKARZ SZCZECIN. F ',
            quantity: 2.0,
            price: 1.99,
            totalPrice: 3.98
          },
          {
            name: 'BATON ZBOŻ.LION4X25 F ',
            quantity: 1.0,
            price: 3.99,
            totalPrice: 3.99
          },
          {
            name: 'F ',
            quantity: 1.0,
            price: 3.99,
            totalPrice: 3.99
          }
        ],
        shopDetails: [
          'Lidl sp. z 0.0. sp. k.',
          'Moniuszki 2',
          '59-220 Legnica'
        ],
        totalPrice: 13.74,
        errorMessage: nil,
        date: '2018-09-03'
      }
    end
  end
end
