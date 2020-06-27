# frozen_string_literal: true

class ProductSerializer < ActiveModel::Serializer
  attributes :id, :name, :category, :price, :quantity, :total_price

  def id
    object.id.to_s
  end
end
