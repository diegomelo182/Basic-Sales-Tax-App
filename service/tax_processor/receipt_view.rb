class TaxProcessor::ReceiptView
  def self.call(order)
    total_taxes = 0
    total = 0
    order.products.each_with_index do |product_item, index|
      product_tax = order.products_taxes[index]
      product = product_item[:product]
      quantity = product_item[:quantity]
      total_taxes += (quantity * product_tax[:product_tax_value]).to_f.round(2)
      product_price_plus_taxes = (quantity * (product_tax[:product_tax_value] + product.price)).to_f.round(2)
      total += product_price_plus_taxes

      puts "#{quantity} #{product.is_imported ? 'imported' : ''} #{product.name}: #{product_price_plus_taxes}"
    end

    puts "Sales Taxes: #{total_taxes.to_f.round(2)}"
    puts "Total: #{total.to_f.round(2)}"
  end
end
