require_relative '../../../service/tax_processor'
require_relative '../../../service/tax_processor/order'
require_relative '../../../service/tax_processor/product'
RSpec.describe TaxProcessor::Product do
  describe '.call' do
    let(:price) { 100.0 }

    context 'when product is not tax exempt and not imported' do
      let(:product) do
        Product.new(
          name: 'Gadget',
          price: price,
          is_imported: false,
          type: 'other'
        )
      end

      it 'applies 10% tax' do
        expect(described_class.call(product)).to eq(10.0)
      end
    end

    context 'when product is tax exempt and not imported' do
      %w[book food medicinal].each do |exempt_type|
        it "applies 0% tax for #{exempt_type}" do
          product = Product.new(
            name: 'Exempt Item',
            price: price,
            is_imported: false,
            type: exempt_type
          )

          expect(described_class.call(product)).to eq(0.0)
        end
      end
    end

    context 'when product is not tax exempt but imported' do
      let(:product) do
        Product.new(
          name: 'Imported Gadget',
          price: price,
          is_imported: true,
          type: 'other'
        )
      end

      it 'applies 15% tax (10% + 5%)' do
        expect(described_class.call(product)).to eq(15.0)
      end
    end

    context 'when product is tax exempt and imported' do
      let(:product) do
        Product.new(
          name: 'Imported Book',
          price: price,
          is_imported: true,
          type: 'book'
        )
      end

      it 'applies only 5% import tax' do
        expect(described_class.call(product)).to eq(5.0)
      end
    end
  end

  describe '.tax_exempt_types' do
    it 'returns only book, food, and medicinal types' do
      expect(described_class.tax_exempt_types)
        .to contain_exactly('book', 'food', 'medicinal')
    end
  end
end
