require 'rails_helper'

RSpec.describe "ContactImportLogs", type: :request do
  describe "GET /" do
    it "returns http success" do
      get "/contact_import_logs"
      expect(response).to have_http_status(:success)
    end
  end

end
