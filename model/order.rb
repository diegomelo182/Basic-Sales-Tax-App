class Order
  attr_reader :products, :products_taxes

  def initialize
    @products = []
    @products_taxes = []
  end

  def add_product(product:, quantity:)
    @products.push({product: product, quantity: quantity})
  end

  def add_product_tax(product_tax)
    @products_taxes.push({product_tax_value: product_tax})
  end
end
