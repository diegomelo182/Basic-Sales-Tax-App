require_relative '../../../service/tax_processor'
require_relative '../../../service/tax_processor/order'
require_relative '../../../service/tax_processor/product'

RSpec.describe TaxProcessor::Order do
  describe '.call' do
    let(:product1) {
      Product.new(
        name: 'Book',
        price: 29.99,
        is_imported: false,
        type: 'book'
      )
    }
    let(:product2) {
      Product.new(
        name: 'Another Product',
        price: 10.99,
        is_imported: true,
        type: 'other'
      )
    }

    let(:order) do
      order = Order.new
      order.add_product(product: product1, quantity: 1)
      order.add_product(product: product2, quantity: 1)

      order
    end

    let(:tax1) { 100 }
    let(:tax2) { 200 }

    before do
      allow(TaxProcessor::Product).to receive(:call)
        .with(product1).and_return(tax1)

      allow(TaxProcessor::Product).to receive(:call)
        .with(product2).and_return(tax2)

      allow(order).to receive(:add_product_tax)
    end

    it 'calls TaxProcessor::Product for each product' do
      described_class.call(order)

      expect(TaxProcessor::Product).to have_received(:call).with(product1)
      expect(TaxProcessor::Product).to have_received(:call).with(product2)
    end

    it 'adds each calculated tax to the order' do
      described_class.call(order)

      expect(order).to have_received(:add_product_tax).with(tax1)
      expect(order).to have_received(:add_product_tax).with(tax2)
    end

    it 'returns the order' do
      result = described_class.call(order)
      expect(result).to eq(order)
    end
  end
end
