require 'rails_helper'

RSpec.describe "Imports", type: :request do
  before do
    sign_in create(:user)
  end

  describe "GET /" do
    it "returns http success" do
      imports = create_list(:import, 3)

      get "/imports"

      expect(response).to have_http_status(:success)

      imports.each do |import|
        expect(response.body).to include("#{import.id}")
        expect(response.body).to include("#{import.status}")
        expect(response.body).to include("#{import.created_at.strftime('%F %H:%M:%S')}")
      end
    end
  end

  describe "GET /new" do
    it "returns http success" do
      get "/imports/new"
      expect(response).to have_http_status(:success)
    end
  end

end
