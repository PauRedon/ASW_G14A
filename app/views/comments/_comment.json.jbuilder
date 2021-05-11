json.extract! comment, :id, :parent_id, :content, :created_at, :replies
json.url comment_url(comment, format: :json)
