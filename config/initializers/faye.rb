Thread.new do
  system("rackup faye.ru -E production -o 0.0.0.0") #" -s thin -E production")
end