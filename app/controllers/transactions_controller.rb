class TransactionsController < ApplicationController
  def index
    @transactions = Transaction.all
    @total = Transaction.sum(:amount)
  end

  def new
    @transaction = Transaction.new
  end

  def create
    @transaction = Transaction.new(transaction_params)

    if @transaction.save
      redirect_to transactions_path
    else
      render :index
    end
  end

  private

  def transaction_params
    params.require(:transaction).permit(:description, :amount)
  end
end
