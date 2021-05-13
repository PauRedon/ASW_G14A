json.extract! contribucio, :id, :author_id, :tittle, :url, :texto, :created_at, :like, :comments
json.url contribucio_url(contribucio, format: :json)
