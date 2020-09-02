require 'stripe_mock'

RSpec.describe "POST /v1/subscriptions", type: :request do
  let(:stripe_helper) { StripeMock.create_test_helper }
  before(:each) { StripeMock.start }
  after(:each) { StripeMock.stop }
  let(:valid_token) { stripe_helper.generate_card_token }

  let(:product) { stripe_helper.create_product }
  let!(:plan) do
    stripe_helper.create_plan(
      id: "bds_subscription_plan",
      amount: 100,
      currency: "usd",
      interval: "month",
      interval_count: 12,
      name: 'Bidspace Subscription',
      product: product.id
    )
  end

  let(:user) { create(:user, role: 'registered')}
  let(:credentials) { user.create_new_auth_token }
  let(:headers) { { HTTP_ACCEPTS: "application/json" }.merge!(credentials) }

  describe 'successfully with valid params and headers' do
    before do
      post '/api/v1/subscriptions',
      params: {
        stripeToken: valid_token
      },
      headers: headers
    end

    it 'is expected to return 200 response status' do
      expect(response).to have_http_status 200
    end

    it 'is expected to return success message' do
      expect(response_json["message"]).to eq "Transaction was successful"
    end

    it 'is expected to change user role to subscriber' do
      user.reload
      expect(user.role).to eq 'subscriber'
    end
  end

  describe 'unsuccessfully when' do
    describe "with invalid parameters" do
      before do
        post "/api/v1/subscriptions", headers: headers
      end

      it "returns error message" do
        expect(response_json["message"]).to eq "Something went wrong. There was no token provided..."
      end

      it "returns error http code" do
        expect(response).to have_http_status 422
      end

      it "does NOT set user role to subsciber" do
        user.reload
        expect(user.role).not_to eq 'subscriber'
      end
    end

    describe "stripeToken is empty" do
      before do
        post "/api/v1/subscriptions",
             params: { stripeToken: "" }, headers: headers
      end

      it "returns a error http code" do
        expect(response).to have_http_status 422
      end

      it "does NOT set user role to subsciber" do
        user.reload
        expect(user.role).not_to eq 'subscriber'
      end

      it "returns an error message" do
        expect(response_json["message"]).to eq "Something went wrong. There was no token provided..."
      end
    end

    describe "credit card is declined" do
      before do
        StripeMock.prepare_card_error(:card_declined, :new_invoice)

        post "/api/v1/subscriptions",
          params: { stripeToken: valid_token 
          }, headers: headers
      end

      it "returns a error http code" do
        expect(response).to have_http_status 422
      end

      it "does NOT set user role to subsciber" do
        user.reload
        expect(user.role).not_to eq 'subscriber'
      end

      it "returns an error message" do
        expect(response_json["message"]).to eq "Something went wrong. The card was declined"
      end
    end

    describe "user is already subscriber" do
      let(:subscriber) { create(:user, role: :subscriber) }
      let(:subscriber_credentials) { subscriber.create_new_auth_token }
      let(:subscriber_headers) { { HTTP_ACCEPT: "application/json" }.merge!(subscriber_credentials) }

      before do
        post "/api/v1/subscriptions",
          params: { stripeToken: valid_token 
          }, headers: subscriber_headers
      end

      it "returns a error http code" do
        expect(response).to have_http_status 422
      end

      it "returns an error message" do
        expect(response_json["message"]).to eq "Something went wrong. You are already a subscriber"
      end
    end
  end
end