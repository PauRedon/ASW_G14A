json.array!(@contribucios) do |contribucio|
  json.extract! contribucio, :id, :tittle, :url, :texto, :created_at, :like
  json.url contribucio_url(contribucio, format: :json)
end
