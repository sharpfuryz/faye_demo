30.times do
  # Generates random word
  o = [('a'..'z'), ('A'..'Z')].map { |i| i.to_a }.flatten
  string = (0...50).map { o[rand(o.length)] }.join
  Item.create(name: string)
end