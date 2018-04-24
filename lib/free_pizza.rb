class FreePizza

  def self.convert(min_orders, min_price, customers)
    return [] if customers.empty?
    qualifying_customers = []

    customers.each do |key, orders|
      qualifying_orders = 0
      orders.each do |order|
        qualifying_orders += 1 if order >= min_price.to_i
      end

      if qualifying_orders > 0 && qualifying_orders >= min_orders.to_i
        qualifying_customers << key
      end
    end

    qualifying_customers
  end
end
