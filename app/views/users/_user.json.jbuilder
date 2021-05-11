json.extract! user, :id, :username, :password, :created_at
json.url user_url(user, format: :json)
