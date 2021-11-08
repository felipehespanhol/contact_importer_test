class ContactImportLogsController < ApplicationController
  def index
    @contact_import_logs = ContactImportLog.page(params[:page])
  end
end
