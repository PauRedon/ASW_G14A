json.array!(@contribucios) do |contribucio|
  json.extract! contribucio, :id, :tittle, :url, :texto, :created_at, :like, :comments
  json.url contribucio_url(contribucio, format: :json)
end
