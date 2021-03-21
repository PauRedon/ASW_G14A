json.extract! news, :id, :tittle, :url, :content, :created_At, :likes, :user_id, :created_at, :updated_at
json.url news_url(news, format: :json)
