require_relative '../../../service/input'
require_relative '../../../service/input/validate'

RSpec.describe Input::Validate do
  describe '.call' do
    context 'with valid input' do
      it 'validates standard input without imported' do
        input = '2 book at 12.49'
        expect(described_class.call(input)).to be true
      end

      it 'validates input with imported' do
        input = '1 imported chocolate at 10.00'
        expect(described_class.call(input)).to be true
      end

      it 'validates price with comma separator' do
        input = '3 imported perfume at 27,99'
        expect(described_class.call(input)).to be true
      end

      it 'is case insensitive' do
        input = '1 IMPORTED Book at 15.00'
        expect(described_class.call(input)).to be true
      end
    end

    context 'with invalid input' do
      it 'rejects input without quantity' do
        input = 'book at 12.49'
        expect(described_class.call(input)).to be false
      end

      it 'rejects input without price' do
        input = '1 book at'
        expect(described_class.call(input)).to be false
      end

      it 'rejects input without "at"' do
        input = '1 book 12.49'
        expect(described_class.call(input)).to be false
      end

      it 'rejects malformed price' do
        input = '1 book at 12.4'
        expect(described_class.call(input)).to be false
      end

      it 'rejects completely invalid string' do
        input = 'invalid input string'
        expect(described_class.call(input)).to be false
      end
    end
  end

  describe 'INPUT_REGEX' do
    it 'captures quantity, imported flag, name, and price' do
      match = described_class::INPUT_REGEX.match('2 imported book at 12.49')

      expect(match[1]).to eq('2')
      expect(match[2]).to eq('imported')
      expect(match[3]).to eq('book')
      expect(match[4]).to eq('12.49')
    end
  end
end
