class TaxProcessor::Product
  def self.call(product)
    tax_value = 0.1

    tax_value = 0 if tax_exempt_types.include?(product.type)
    tax_value += 0.05 if product.is_imported

    (product.price * tax_value).to_f.round(2)
  end

  def self.tax_exempt_types
    Product::SUPPORTED_TYPES.select do |type|
      %w[book food medicinal].include?(type)
    end
  end
end
