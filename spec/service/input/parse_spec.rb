require_relative '../../../service/input'
require_relative '../../../service/input/parse'
require_relative '../../../service/input/validate'

RSpec.describe Input::Parse do
  describe '.call' do
    context 'when input is invalid' do
      it 'raises StandardError' do
        expect {
          described_class.call('invalid input', product_type: 'book')
        }.to raise_error('Invalid Input')
      end
    end

    context 'when input is valid and not imported' do
      let(:input) { '2 Book at 12,49' }

      it 'parses quantity correctly' do
        result = described_class.call(input, product_type: 'book')
        expect(result[:quantity]).to eq(2)
      end

      it 'creates a non-imported product with correct price' do
        result = described_class.call(input, product_type: 'book')
        product = result[:product]

        expect(product.name).to eq('Book')
        expect(product.price).to eq(12.49)
        expect(product.is_imported).to be false
        expect(product.type).to eq('book')
      end
    end

    context 'when input is valid and imported' do
      let(:input) { '1 imported Chocolate at 10,00' }

      before do
        allow(Input::Validate).to receive(:call).with(input).and_return(true)
      end

      it 'marks product as imported' do
        result = described_class.call(input, product_type: 'food')
        product = result[:product]

        expect(product.is_imported).to be true
      end
    end

    context 'when price has decimal comma' do
      let(:input) { '1 Book at 10,46' }

      before do
        allow(Input::Validate).to receive(:call).with(input).and_return(true)
      end

      it 'converts and rounds price to two decimals' do
        result = described_class.call(input, product_type: 'book')
        expect(result[:product].price).to eq(10.46)
      end
    end
  end
end
