json.extract! user, :id, :uname, :pwdkey, :created_at, :updated_at
json.url user_url(user, format: :json)