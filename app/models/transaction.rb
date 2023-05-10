class Transaction < ApplicationRecord
  validates :description, :amount, presence: true
end
