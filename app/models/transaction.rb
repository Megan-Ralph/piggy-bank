require 'csv'

class Transaction < ApplicationRecord
  validates :description, :amount, presence: true

  paginates_per 10

  def self.to_csv
    CSV.generate(headers: true) do |csv|
      csv << %w[ID Description Amount]

      all.each do |transaction|
        csv << [transaction.id, transaction.description, transaction.amount]
      end
    end
  end
end
