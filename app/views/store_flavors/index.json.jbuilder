json.array!(@store_flavors) do |store_flavor|
  json.extract! store_flavor, :id, :store_id, :flavor_id
  json.url store_flavor_url(store_flavor, format: :json)
end
