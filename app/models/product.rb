# frozen_string_literal: true

class Product < ApplicationRecord
  belongs_to :receipt
  belongs_to :user
end
