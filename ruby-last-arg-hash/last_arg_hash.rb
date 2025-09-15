def order_pizza(flavor, options)
  output = "Ordering a "

  output += "#{options[:size]} " if options[:size]

  output += "#{flavor} pizza "

  output += "with extra cheese " if options[:extra_cheese]

  puts output.rstrip + "."
end