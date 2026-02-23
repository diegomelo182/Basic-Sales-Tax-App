class Input::Parse
  def self.call(input, product_type:)
    raise 'Invalid Input' unless Input::Validate.call(input)

    parsed_input = input.split(Input::Validate::INPUT_REGEX).drop(1)
    if parsed_input.length > 3
      quantity, imported, product_name, price = parsed_input
    else
      quantity, product_name, price = parsed_input
    end
    product = Product.new(name: product_name, price: price&.sub(',', '.').to_f.round(2), is_imported: !imported.nil?, type: product_type)

    { quantity: quantity.to_i, product: product }
  end
end
