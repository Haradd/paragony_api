# frozen_string_literal: true

class Receipt < ApplicationRecord
  belongs_to :user

  has_many :products, dependent: :destroy
  accepts_nested_attributes_for :products
end
