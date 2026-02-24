require 'pry'

Dir[
  File.join(__dir__, 'service', '*.rb'),
  File.join(__dir__, 'service', '**', '*.rb'),
  File.join(__dir__, 'model', '*.rb')
].each { |file| require file }

repeat_product_registration = true

puts '[Basic Sales Tax App]'
products = []

while repeat_product_registration
  puts '------------------------------'
  puts 'please type the product you want to register'
  product = gets.chomp

  if Input::Validate.call(product)
    puts '------------------------------'
    puts 'which type of product is this?'
    puts '[0] Book'
    puts '[1] Food'
    puts '[2] Medicinal'
    puts '[any other key] Other'
    product_type_input = gets.chomp

    product_type = Product::SUPPORTED_TYPES[3] # set other by default
    product_type = Product::SUPPORTED_TYPES[product_type_input.to_i] if %w[0 1 2].include?(product_type_input)

    products << { text: product, type: product_type }
    puts '------------------------------'
    puts 'do you want to add a new product?'
    puts '[0] No'
    puts '[any other key] Yes'
    user_wants_to_continue = gets.chomp
    repeat_product_registration = false if user_wants_to_continue == '0'
  else
    puts '------------------------------'
    puts 'the product was filled up wrongly. Please use the following pattern'
    puts '1 imported box of chocolates at 10.00'
    puts 'PS. the imported word is optional\n'
  end
end

result = TaxProcessor::ReceiptView.call(products)

result[:products].each do |product|
  puts product
end
puts "Sales Taxes: #{result[:total_tax]}"
puts "Total: #{result[:total]}"

puts 'end of execution'
