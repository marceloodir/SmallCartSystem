json.array!(@products) do |product|
  json.extract! product, :id, :nome, :preco
  json.url product_url(product, format: :json)
end
