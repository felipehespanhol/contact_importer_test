FactoryBot.define do
  factory :import do
    csv_content { File.read('fixtures/contacts_sample.csv') }
    column_options do
      {
        name: 'Name',
        phone: 'Phone',
        address: 'Address',
        email: 'Email',
        date_of_birth: 'Date of birth',
        credit_card: 'Credit Card'
      }
    end
  end
end
