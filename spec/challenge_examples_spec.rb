require_relative '../model/order'
require_relative '../model/product'
require_relative '../service/tax_processor'
require_relative '../service/tax_processor/order'
require_relative '../service/tax_processor/receipt_view'

describe 'Challenge Input-Output' do
  describe "Input 1" do
    let(:products) {
      [
        { text: '2 book at 12.49', type: 'book' },
        { text: '1 music CD at 14.99', type: 'other' },
        { text: '1 chocolate bar at 0.85', type: 'food' }
      ]
    }

    let(:expected_values) {
      # 2 book: 24.98
      # 1 music CD: 16.49
      # 1 chocolate bar: 0.85
      # Sales Taxes: 1.50
      # Total: 42.32

      {
        products: [
          '2 book: 24.98',
          '1 music CD: 16.49',
          '1 chocolate bar: 0.85'
        ],
        total_tax: '1.50',
        total: '42.32'
      }
    }
    it "should return the output 1 values" do
      output = TaxProcessor::ReceiptView.call(products)
      output[:products].each_with_index do |text, index|
        expect(expected_values[:products][index]).to eq(text)
      end
      expect(sprintf("%.2f", output[:total])).to eq(expected_values[:total])
      expect(sprintf("%.2f", output[:total_tax])).to eq(expected_values[:total_tax])
    end
  end

  describe "Input 2" do
    let(:products) {
      [
        { text: '1 imported box of chocolates at 10.00', type: 'food' },
        { text: '1 imported bottle of perfume at 47.50', type: 'other' }
      ]
    }

    let(:expected_values) {
      # 1 imported box of chocolates: 10.50
      # 1 imported bottle of perfume: 54.65
      # Sales Taxes: 7.65
      # Total: 65.15
      {
        products: [
          '1 imported box of chocolates: 10.50',
          '1 imported bottle of perfume: 54.65'
        ],
        total_tax: '7.65',
        total: '65.15'
      }
    }
    it "should return the output 2 values" do
      output = TaxProcessor::ReceiptView.call(products)
      output[:products].each_with_index do |text, index|
        expect(expected_values[:products][index]).to eq(text)
      end
      expect(sprintf("%.2f", output[:total])).to eq(expected_values[:total])
      expect(sprintf("%.2f", output[:total_tax])).to eq(expected_values[:total_tax])
    end
  end

  describe "Input 3" do
    let(:products) {
      [
        { text: '1 imported bottle of perfume at 27.99', type: 'other' },
        { text: '1 bottle of perfume at 18.99', type: 'other' },
        { text: '1 packet of headache pills at 9.75', type: 'medicinal' },
        { text: '3 imported boxes of chocolates at 11.25', type: 'food' }
      ]
    }

    let(:expected_values) {
      # 1 imported bottle of perfume: 32.19
      # 1 bottle of perfume: 20.89
      # 1 packet of headache pills: 9.75
      # 3 imported boxes of chocolates: 35.55
      # Sales Taxes: 7.90
      # Total: 98.38
      {
        products: [
          '1 imported bottle of perfume: 32.19',
          '1 bottle of perfume: 20.89',
          '1 packet of headache pills: 9.75',
          '3 imported boxes of chocolates: 35.55'
        ],
        total_tax: '7.90',
        total: '98.38'
      }
    }
    it "should return the output 3 values" do
      output = TaxProcessor::ReceiptView.call(products)
      output[:products].each_with_index do |text, index|
        expect(expected_values[:products][index]).to eq(text)
      end
      expect(sprintf("%.2f", output[:total])).to eq(expected_values[:total])
      expect(sprintf("%.2f", output[:total_tax])).to eq(expected_values[:total_tax])
    end
  end
end
