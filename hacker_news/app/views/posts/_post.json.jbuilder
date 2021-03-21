json.extract! post, :id, :tittle, :url, :content, :created_At, :likes, :user_id, :created_at, :updated_at
json.url post_url(post, format: :json)
