class TaxProcessor::Order
  def self.call(order)
    order.products.each do |order_item|
      product_tax = TaxProcessor::Product.call(order_item[:product])
      order.add_product_tax(product_tax)
    end

    order
  end
end
