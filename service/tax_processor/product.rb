class TaxProcessor::Product
  def self.call(product)
    tax_value = 10

    tax_value = 0 if tax_exempt_types.include?(product.type)
    tax_value += 5 if product.is_imported

    get_nearest_0_05((tax_value * product.price)/100).to_f.round(2)
  end

  def self.tax_exempt_types
    Product::SUPPORTED_TYPES.select do |type|
      %w[book food medicinal].include?(type)
    end
  end

  def self.get_nearest_0_05(number)
    (number * 20).ceil / 20.0
  end
end
