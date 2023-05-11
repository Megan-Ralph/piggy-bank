class Transaction < ApplicationRecord
  validates :description, :amount, presence: true

  paginates_per 10
end
