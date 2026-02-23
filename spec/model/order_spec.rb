require_relative '../../model/order'
require_relative '../../model/product'

RSpec.describe Order do
  describe '#initialize' do
    it 'initializes with empty products and products_taxes arrays' do
      order = Order.new

      expect(order.products).to eq([])
      expect(order.products_taxes).to eq([])
    end
  end

  describe '#add_product' do
    let(:order) { Order.new }
    let(:product) { Product.new(name: 'Product', price: 0.50, is_imported: false, type: 'other') }
    let(:product1) { Product.new(name: 'Product 1', price: 0.50, is_imported: false, type: 'other') }
    let(:product2) { Product.new(name: 'Product 2', price: 0.50, is_imported: false, type: 'other') }

    it 'adds a product with quantity to products array' do
      order.add_product(product: product, quantity: 2)

      expect(order.products).to eq([
        { product: product, quantity: 2 }
      ])
    end

    it 'adds multiple products correctly' do
      order.add_product(product: product1, quantity: 1)
      order.add_product(product: product2, quantity: 3)

      expect(order.products).to eq([
        { product: product1, quantity: 1 },
        { product: product2, quantity: 3 }
      ])
    end
  end

  describe '#add_product_tax' do
    let(:order) { Order.new }

    it 'adds a product tax value to products_taxes array' do
      order.add_product_tax(5.75)

      expect(order.products_taxes).to eq([
        { product_tax_value: 5.75 }
      ])
    end

    it 'adds multiple product tax values correctly' do
      order.add_product_tax(2.5)
      order.add_product_tax(3.25)

      expect(order.products_taxes).to eq([
        { product_tax_value: 2.5 },
        { product_tax_value: 3.25 }
      ])
    end
  end
end
