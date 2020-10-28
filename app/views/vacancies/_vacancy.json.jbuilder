json.extract! vacancy, :id, :title, :description, :wage, :position, :created_at, :updated_at
json.url vacancy_url(vacancy, format: :json)
