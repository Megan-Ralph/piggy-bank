class TransactionsController < ApplicationController
  def index
    @transactions = Transaction.all
    @transactions = Kaminari.paginate_array(@transactions).page(params[:page]).per(5)
    @total = Transaction.sum(:amount)

    @chart_data = {
      labels: @transactions.pluck(:description),
      datasets: [
        {
          label: 'Transaction Amounts',
          backgroundColor: 'rgba(255, 99, 132, 0.2)',
          borderColor: 'rgba(255, 99, 132, 1)',
          borderWidth: 1,
          data: @transactions.pluck(:amount)
        }
      ]
    }
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
