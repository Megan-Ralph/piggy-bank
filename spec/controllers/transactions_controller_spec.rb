require 'rails_helper'

RSpec.describe TransactionsController, type: :controller do
  describe "GET #index" do
    it "returns a successful response" do
      get :index
      expect(response).to be_successful
    end

    it "returns transactions matching the search term" do
      transaction1 = create(:transaction, description: "Transaction 1", amount: 100)
      transaction2 = create(:transaction, description: "Transaction 2", amount: 200)

      get :index, params: { search: 'Transaction 1' }

      expect(assigns(:transactions)).to eq([transaction1])
      expect(response).to render_template(:index)
    end

    it "returns transactions filtered by category" do
      general_transaction = create(:transaction, category: 'general')
      holidays_transaction = create(:transaction, category: 'holidays')

      get :index, params: { category: 'general' }

      expect(assigns(:transactions)).to eq([general_transaction])
      expect(response).to render_template(:index)
    end

    it "returns transactions sorted by amount in descending order" do
      transaction1 = create(:transaction, description: "Transaction 1", amount: 100)
      transaction2 = create(:transaction, description: "Transaction 2", amount: 200)

      get :index, params: { sort_by: 'amount DESC' }

      expect(assigns(:transactions)).to eq([transaction1, transaction2])
      expect(response).to render_template(:index)
    end

    it "assigns @transactions" do
      transactions = create_list(:transaction, 3)
      get :index
      expect(assigns(:transactions)).to eq(transactions)
    end
  end

  describe "POST #create" do
    context "with valid params" do
      let(:valid_params) { { transaction: { description: "Salary", amount: "1000.00", category: :general } } }

      it "creates a new transaction" do
        expect {
          post :create, params: valid_params
        }.to change(Transaction, :count).by(1)

        expect(response).to redirect_to(transactions_path)
      end
    end

    context "with invalid params" do
      let(:invalid_params) { { transaction: { amount: "1000.00" } } }

      it "doesn't create a new transaction" do
        expect {
          post :create, params: invalid_params
        }.not_to change(Transaction, :count)
      end
    end
  end

  describe "GET export_csv" do
    it "exports the transactions as CSV" do
      transaction1 = create(:transaction, description: "Transaction 1", amount: 100)
      transaction2 = create(:transaction, description: "Transaction 2", amount: 200)

      get :export_csv, format: :csv

      expect(response.content_type).to eq('text/csv')
      expect(response.headers['Content-Disposition']).to include('transactions.csv')

      csv_data = CSV.parse(response.body, headers: true)
      expect(csv_data.count).to eq(2)
      expect(csv_data[0]['Description']).to eq('Transaction 1')
      expect(csv_data[1]['Description']).to eq('Transaction 2')
      expect(csv_data[0]['Amount']).to eq('100.0')
      expect(csv_data[1]['Amount']).to eq('200.0')
    end
  end
end
