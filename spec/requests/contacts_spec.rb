require 'rails_helper'

RSpec.describe "Contacts", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get "/contacts"
      expect(response).to have_http_status(:success)
    end

    it "lists contacts" do
      contacts = create_list(:contact, 3)

      get "/contacts"

      contacts.each do |contact|
        expect(response.body).to include("#{contact.id}")
        expect(response.body).to include(contact.name)
        expect(response.body).to include(contact.email)
        expect(response.body).to include(contact.phone)
        expect(response.body).to include(contact.address)
      end
    end
  end

end
