class ImporterWorker
  include Sidekiq::Worker
  sidekiq_options retry: false

  def perform(import_id)
    import = Import.find(import_id)

    ContactsImporter.new(import).import!
  end
end
