require_relative '../../model/product'

RSpec.describe Product do
  describe '#initialize' do
    context 'with supported type' do
      it 'assigns all attributes correctly' do
        product = Product.new(
          name: 'Book',
          price: 29.99,
          is_imported: false,
          type: 'book'
        )

        expect(product.name).to eq('Book')
        expect(product.price).to eq(29.99)
        expect(product.is_imported).to be false
        expect(product.type).to eq('book')
      end
    end

    context 'with unsupported type' do
      it 'defaults type to "other"' do
        product = Product.new(
          name: 'Product',
          price: 10.00,
          is_imported: true,
          type: 'electronics'
        )

        expect(product.type).to eq('other')
      end
    end

    context 'when type is nil' do
      it 'defaults type to "other"' do
        product = Product.new(
          name: 'Just a product',
          price: 5.00,
          is_imported: false,
          type: nil
        )

        expect(product.type).to eq('other')
      end
    end

    context 'SUPPORTED_TYPES' do
      it 'contains the expected values' do
        expect(Product::SUPPORTED_TYPES).to contain_exactly(
          'book', 'food', 'medicinal', 'other'
        )
      end
    end
  end
end
