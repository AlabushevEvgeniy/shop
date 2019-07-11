
if Gem.win_platform?
  Encoding.default_external = Encoding.find(Encoding.locale_charmap)
  Encoding.default_internal = __ENCODING__

  [STDIN, STDOUT].each do |io|
    io.set_encoding(Encoding.default_external, Encoding.default_internal)
  end
end

require_relative 'lib/product'
require_relative 'lib/book'
require_relative 'lib/film'
require_relative 'lib/disk'
require_relative 'lib/product_collection'

collection = ProductCollection.from_dir(File.dirname(__FILE__) + '/data')
collection.sort!(by: :price, order: :asc)

products = []
bought_products = []

puts "    Вот какие товары у нас есть. Что хотите купить?\n\r"

collection.to_a.each_with_index do |product, index|
  puts "    #{index + 1}. #{product}"
  products << product
end
puts "    0. Выход"

summ = 0
puts "Введите номер товара"
input = STDIN.gets.encode('UTF-8').to_i

until input == 0
  chosen_product = products[input - 1]
  amount_new = chosen_product.amount.to_i - 1

  chosen_product.update(amount: amount_new)
  puts "\n\n    Вы выбрали: #{products[input - 1]}"

  summ += chosen_product.price.to_i
  puts "\n    Итого товаров на сумму: #{summ}"
  bought_products << chosen_product

  if chosen_product.is_empty?(amount: amount_new)
    products.delete(chosen_product)
  end

  puts "\n\n    Вот какие товары у нас есть. Что хотите купить еще?\n\r"

  products.each_with_index do |product, index|
    puts "    #{index + 1}. #{product}"
  end
  puts "    0. Выход"

  puts "\n    Введите номер товара"
  input = STDIN.gets.encode('UTF-8').to_i
end

puts "Выкупили:"
bought_products.uniq.each_with_index do |product, index|
  puts product.short_info
end

puts "С Вас #{summ} рублей"
puts "Спасибо!"
