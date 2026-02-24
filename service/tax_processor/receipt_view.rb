class TaxProcessor::ReceiptView
  def self.call(products)
    order = Order.new
    products.each do |product|
      parsed_product = Input::Parse.call(product[:text], product_type: product[:type])
      order.add_product(product: parsed_product[:product], quantity: parsed_product[:quantity])
    end
    output_products = []
    total_tax = 0
    total = 0
    tax_processed_order = TaxProcessor::Order.call(order)
    tax_processed_order.products.each_with_index do |order, index|
      tax = tax_processed_order.products_taxes[index]
      price_plus_tax = order[:quantity] * (order[:product].price + tax[:product_tax_value])
      total += price_plus_tax
      total_tax += order[:quantity] * tax[:product_tax_value]
      output_products.push "#{order[:quantity]}#{order[:product].is_imported ? ' imported ' : ' '}#{order[:product].name}: #{sprintf("%.2f", price_plus_tax)}"
    end

    { total: sprintf("%.2f", total), total_tax: sprintf("%.2f", total_tax), products: output_products }
  end
end
