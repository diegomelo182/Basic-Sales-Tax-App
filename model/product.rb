class Product
  SUPPORTED_TYPES = %w[book food medicinal other]

  attr_accessor :name, :price, :is_imported, :type

  def initialize(name:, price:, is_imported:, type:)
    @name = name
    @price = price
    @is_imported = is_imported
    @type = SUPPORTED_TYPES.include?(type) ? type : 'other'
  end
end
