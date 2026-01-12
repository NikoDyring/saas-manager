require 'rails_helper'

RSpec.describe "Api::Subscriptions", type: :request do
  let(:organization) { Organization.create!(name: "Test Org", slug: "test-org") }
  let(:other_organization) { Organization.create!(name: "Other Org", slug: "other-org") }
  
  let(:user) { User.create!(email: "dev@example.com", password: "password123", organization: organization) }
  
  let(:vendor) { Vendor.create!(name: "Slack", category: "Comm") }
  
  let!(:my_subscription) do 
    Subscription.create!(
      organization: organization, 
      vendor: vendor, 
      amount_cents: 1000, 
      renewal_date: Date.today
    )
  end
  
  let!(:other_subscription) do 
    Subscription.create!(
      organization: other_organization, 
      vendor: vendor, 
      amount_cents: 5000, 
      renewal_date: Date.today
    )
  end

  let(:headers) { auth_headers(user) }

  describe "GET /api/subscriptions" do
    it "returnerer kun abonnementer tilhørende brugerens organisation" do
      get api_subscriptions_path, headers: headers, as: :json
      
      expect(response).to have_http_status(:ok)
      json = JSON.parse(response.body)
      
      # Tjek at vi kun får 1 tilbage (my_subscription), ikke 2.
      expect(json.size).to eq(1)
      expect(json.first["id"]).to eq(my_subscription.id)
    end

    it "inkluderer vendor data i JSON outputtet (N+1 tjek)" do
      get api_subscriptions_path, headers: headers, as: :json
      json = JSON.parse(response.body)
      
      expect(json.first["vendor"]).to be_present
      expect(json.first["vendor"]["name"]).to eq("Slack")
    end

    it "returnerer 401 hvis man ikke er logget ind" do
      get api_subscriptions_path, as: :json
      expect(response).to have_http_status(:unauthorized)
    end
  end

  describe "GET /api/subscriptions/:id" do
    it "giver adgang til eget abonnement" do
      get api_subscription_path(my_subscription), headers: headers, as: :json
      expect(response).to have_http_status(:ok)
    end

    it "nægter adgang (404) til en anden organisations abonnement" do
      get api_subscription_path(other_subscription), headers: headers, as: :json
      expect(response).to have_http_status(:not_found)
    end
  end

  it "virker med manuel token" do
    post "/login", 
        params: { user: { email: user.email, password: user.password } }.to_json, 
        headers: { 'Accept' => 'application/json', 'Content-Type' => 'application/json' }
    
    token = response.headers['Authorization']
    
    puts "Response: #{response.body}"
    puts User.count
    expect(response.status).to eq(200)
    expect(token).to be_present
  end
end