json.array!(@subs) do |sub|
  json.extract! sub, :id
  json.url sub_url(sub, format: :json)
end
