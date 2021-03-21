json.extract! contribucio, :id, :tittle, :url, :content, :likes, :user_id, :created_at, :updated_at
json.url contribucio_url(contribucio, format: :json)
