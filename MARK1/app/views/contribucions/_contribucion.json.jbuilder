json.extract! contribucion, :id, :title, :url, :content, :created_at, :updated_at
json.url contribucion_url(contribucion, format: :json)
