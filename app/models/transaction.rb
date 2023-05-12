require 'csv'

class Transaction < ApplicationRecord
  validates :description, :amount, presence: true

  paginates_per 10
  
  enum category: [:general, :bills, :shopping, :holidays, :transport]

  def self.sort_options
    {
      'Amount (Ascending)' => 'date ASC',
      'Amount (Descending)' => 'date DESC',
      'Description (Ascending)' => 'description ASC',
      'Description (Descending)' => 'description DESC'
    }
  end

  def self.to_csv
    CSV.generate(headers: true) do |csv|
      csv << %w[ID Description Amount]

      all.each do |transaction|
        csv << [transaction.id, transaction.description, transaction.amount]
      end
    end
  end
end
