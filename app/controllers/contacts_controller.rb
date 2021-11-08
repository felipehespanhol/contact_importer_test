class ContactsController < ApplicationController
  before_action :authenticate_user!

  def index
    @contacts = Contact.page(params[:page])
  end
end
