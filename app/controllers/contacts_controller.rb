class ContactsController < ApplicationController
  before_action :authenticate_user!

  def index
    @contacts = Contact.order(created_at: :desc).page(params[:page])
  end
end
