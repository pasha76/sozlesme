json.extract! company, :id, :name, :address, :email, :tax_no, :created_at, :updated_at
json.url company_url(company, format: :json)