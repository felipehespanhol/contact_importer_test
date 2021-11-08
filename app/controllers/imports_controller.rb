require 'contacts_importer'

class ImportsController < ApplicationController
  def index
    @imports = Import.page(params[:page])
  end

  def new
    @import = Import.new
  end

  def create
    @import = Import.new(import_params)

    if @import.save
      ContactsImporter.new(@import).import!

      flash[:notice] = 'Import saved successfully.'
      redirect_to contacts_path
    else
      flash.now[:alert] = @import.errors.full_messages.first
      render :new
    end
  end

  private

  def import_params
    params.require(:import).permit(:file, column_options: [
      :name, :email, :address, :phone, :credit_card, :date_of_birth
    ])
  end
end
