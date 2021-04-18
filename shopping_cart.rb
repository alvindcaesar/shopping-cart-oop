class ShoppingCart
  attr_accessor :voucher
  attr_reader :paid, :products

  def initialize
    @products = [] # to store Product objects (as we add Product while shopping)
    @voucher = nil
    @paid = false
  end

  def total_price
    total = # TO-DO: calculate total price of items in @products
    if @voucher.nil?
      total
    else
      @voucher.calculate_price_after_discount(total)
    end
  end

  def add_product(product)
    # TO-DO
  end

  # sets @paid to true if money is equal or more than total_price()
  # returns the balance
  def pay(amount_given_by_cust)
    # TO-DO
  end
end

class Customer
  attr_accessor :name, :customer_id, :last_purchase
  def initialize(name, customer_id)
    @name = name
    @customer_id = validate_customer_id(customer_id)
    @last_purchase = nil
  end

  # TO-DO
  def validate_customer_id(id)
    # customer_id format is LKKKKKKKKL
    # i.e. first L must be either capital A, B or C only
    # KKKKKKKK is an 8 digit number ranging from 10000000 to 99999999
    # last L must be either capital W, X or Y only
    # examples of valid ID: B10004596Y, A49443556W, C99999999X
    # examples of invalid ID: A00000056W, D76840213X, C99999999V
    # put your regex as an argument to match? method below
    if id.match?(/TO-DO/)
      id # if it matches simply return the ID
    else
      raise 'Invalid customer ID!'
    end
  end

  def update_purchase_history(prod_array)
    raise 'Purchase history must be an Array!' if prod_array.class != Array
    # TO-DO: assign prod_array to @last_purchase
  end
end

class Product
  attr_accessor :name
  attr_accessor :price

  def initialize(name, price)
    @name = name
    @price = "TO-DO: Convert price to Float type"
  end
end

class Voucher
  attr_accessor :code, :minimum_purchase_amount, :discount

  def initialize(code, minimum_purchase_amount, discount)
    @code = code.upcase
    @minimum_purchase_amount = minimum_purchase_amount.to_i
    @discount = validate_discount(discount.to_i)
  end

  # TO-DO: check if the voucher can be applied to this total amount of purchase, returns boolean true or false
  def is_applicable?(price)
    # Hint: if price is greater than or equal to @minimum_purchase_amount, return appropriate boolean
  end

  def calculate_price_after_discount(price)
    if is_applicable?(price)
      # TO-DO: calculate price after discount
    else
      price # return original price as the voucher couldn't be applied
    end
  end

  private

  def validate_discount(discount)
    if !(1..100).include? discount
      # raises an error if discount is not an integer between 1 to 100
      raise 'Voucher discount amount must be an integer between 1 to 100'
    else
      # otherwise return the discount amount
      discount
    end
  end
end

class Supermarket
  def initialize(name='Baratas Supermarket')
    @name = name
    @customers = [] # to store a list of customers registered as supermarket member
    @products = [] # to store a list of available products in the supermarket
    @vouchers = [] # to store a list of available vouchers
  end

  def load_products_from_file(filename)
    File.open(filename, 'r') do |file|
      products = file.readlines(chomp: true)
      products.each do |prod_data|
        # TO-DO: insert product into @products
      end
    end
  end

  def load_customers_from_file(filename)
    File.open(filename, 'r') do |file|
      customers = file.readlines(chomp: true)
      customers.each do |cust_data|
        # TO-DO: insert customer into @products
      end
    end
  end

  def load_vouchers_from_file(filename)
    File.open(filename, 'r') do |file|
      vouchers = file.readlines(chomp: true)
      vouchers.each do |vouch_data|
        # TO-DO: insert customer into @products
      end
    end
  end

  def run
    if !@customers.empty? && !@products.empty?
      while true
        clear_console
        print_menu
        choice = prompt('Enter a valid choice (1-4) from the menu above')

        # run this loop if choice entered was invalid
        while choice.to_i == 0 || ![1,2,3,4].include?(choice.to_i)
          choice = prompt('Invalid number entered. Please enter a number from the menu above')
        end

        # if the choice entered is valid, specify specific method to run
        clear_console
        if choice.to_i == 1
          start_shopping
        elsif choice.to_i == 2
          print_list_of_products
          puts
          prompt('Press enter to go back to main menu')
        elsif choice.to_i == 3
          view_shopping_history
        elsif choice.to_i == 4
          break # end the outermost while loop and exit the whole program
        end
      end
    else
      if @customers.empty?
        puts 'Please load at least one customer into the system!'
      end

      if @products.empty?
        puts 'Please load at least one product into the system!'
      end
    end
  end

  private

  def clear_console
    puts "\e[H\e[2J"
  end

  def print_menu
    puts '=' * 80
    puts 'Welcome to Baratas Supermarket'
    puts '=' * 80
    puts '1. Shop now'
    puts '2. List all products'
    puts '3. View last shopping history'
    puts '4. Exit'
    puts '=' * 80
  end

  def prompt(text)
    print "#{text}: "
    gets.chomp
  end

  def find_customer(cust_id)
    # returns an array of containing a customer object with the specified cust_id
    search_result = @customers.select do |customer|
                      # TO-DO: refer to Ruby doc or StackOverflow
                    end
    if search_result.empty?
      nil
    else
      search_result.first
    end
  end

  def find_voucher(vouch_code)
    search_result = @vouchers.select do |voucher|
                      # TO-DO: refer to Ruby doc or StackOverflow
                    end
    if search_result.empty?
      nil
    else
      search_result.first
    end
  end

  def print_list_of_products
    @products.each_with_index do |product, index|
      # TO-DO
    end
  end


  def start_shopping
    customer_id = prompt('Please enter your customer ID')
    cust = find_customer(customer_id)
    while cust.nil?
      customer_id = prompt('Invalid ID entered. Please enter your customer ID')
      cust = find_customer(customer_id)
    end

    cart = # TO-DO: create a new shopping cart object

    clear_console
    puts "Hello, #{cust.name}!"
    puts
    print_list_of_products
    puts
    item_id = prompt("Please enter a product number (1-#{@products.size}) from above list, or enter 'x' to finish")
    while item_id != 'x'
      if (1..@products.size).include? item_id.to_i
        selected_product = @products[item_id.to_i - 1]
        cart.add_product(selected_product)
        puts "#{selected_product.name} has been added to your shopping cart. Current total is #{cart.total_price} "
        item_id = prompt("Please enter a product number (1-#{@products.size}) from above list, or enter 'x' to finish")
      else # invalid item_id (not in the printed menu)
        item_id = prompt("Invalid product number! Please enter a product number (1-#{@products.size}) from above list, or enter 'x' to finish")
      end
    end

    puts "Total price to pay is RM%.2f" % [cart.total_price]

    vouch_code = prompt("Enter a voucher code or 'x' to skip")
    while vouch_code != 'x'
      vouch = find_voucher(vouch_code)
      if !vouch.nil? # if the voucher exists
        # TO-DO: set voucher on cart
        break
      else
        vouch_code = prompt("Invalid voucher code. Enter a valid voucher code or 'x' to skip")
      end
    end

    if !cart.voucher.nil? # if voucher was applied
      puts "Total price after #{'TO-DO: read voucher code from cart'} is applied is RM%.2f" % ['TO-DO: read total price from cart']
    end

    paid_amount = prompt('Enter amount to pay')
    while !cart.paid
      if Float(paid_amount, exception: false)
        balance = cart.pay(paid_amount)
      else
        paid_amount = prompt('Invalid or insufficient amount entered, please re-enter amount to pay')
      end
    end

    # TO-DO: Update last purchase history (hint: call an appropriate method on cart object)

    puts "Balance returned is RM%.2f" % [balance]

    puts "Thank you for shopping with Bataras Supermarket, #{cust.name}!"

    sleep(5)
  end

  def view_shopping_history
    customer_id = prompt('Please enter your customer ID')
    cust = find_customer(customer_id)
    while cust.nil?
      customer_id = prompt('Invalid ID entered. Please enter your customer ID')
      cust = find_customer(customer_id)
    end

    # TO-DO: show last purchase history by making use of the Customer object
end

s = Supermarket.new
s.load_products_from_file 'products.txt' # change the filename if you use other filename
s.load_customers_from_file 'customers.txt' # change the filename if you use other filename
s.load_vouchers_from_file 'vouchers.txt' # change the filename if you use other filename
s.run
