product_by_categories = {
  makeup: ["Mascara",
           "Lip Gloss",
           "Blush",
           "Nail Polish",
           "Lip Stain",
           "Powder"],
  hair: [
    "Shampoo",
    "Shine Serum + Gloss",
    "Brushes + Combs",
    "Rollers, Curlers"
  ],
  face: [
    "Exfoliators, Scrubs",
    "Blemish + Acne Control",
    "Night Cream",
    "Self Tanners",
    "Lip Plumper",
    "Lightening Cream"
  ],
  body: [
    "Body Lotion",
    "Hand, Foot + Nail Treatments",
    "Sun Care",
    "Nail Tools"
  ]
}

product_by_categories.each do |category, products|
  products.each do |product_name|
    Product.create!(
      name: product_name,
      sold_out: Faker::Boolean.boolean,
      category: category,
      under_sale: Faker::Boolean.boolean,
      price: Faker::Number.between(1000, 10_000),
      sale_price: Faker::Number.between(1000, 10_000),
      sale_text: "#{Faker::Number.between(0, 90)}%"
    )
  end
end
