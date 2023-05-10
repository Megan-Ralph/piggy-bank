require 'rails_helper'

RSpec.describe TransactionsController, type: :controller do
  describe "GET #index" do
    it "returns a successful response" do
      get :index
      expect(response).to be_successful
    end

    it "assigns @transactions" do
      transactions = create_list(:transaction, 3)
      get :index
      expect(assigns(:transactions)).to eq(transactions)
    end
  end

  describe "POST #create" do
    context "with valid params" do
      let(:valid_params) { { transaction: { description: "Salary", amount: "1000.00" } } }

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
end
