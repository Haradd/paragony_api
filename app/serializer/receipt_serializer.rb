# frozen_string_literal: true

class ReceiptSerializer < ActiveModel::Serializer
  attributes :id, :date, :total_price, :shop_details
  has_many :products, serializer: ProductSerializer

  def id
    object.id.to_s
  end
end
