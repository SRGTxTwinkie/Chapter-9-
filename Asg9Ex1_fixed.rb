require_relative 'Product'

class Receipt
  def initialize(item)
    @item = item
    @subtotal = 0
    @Tax = 0
    @total = 0
    for i in $items
      if i.productNumber == item
        @subtotal = i.retail
        @Tax = i.retail * 0.6
        @total = @subtotal + @Tax
      else
        next
      end
    end
  end
end

$y = 0
$items = []
$productNumbers = []

def DefaultItem
   item = Product.new(0000, "Default Item", 5, $y, 3.50)
   $items.append(item)
   $productNumbers.append(item.productNumber)
   Menu()
end

def Visual
  puts
  print "Your subtotal is $#{@subtotal} \n"
  print "Your sales tax is $#{@Tax} \n"
  print "The total of your purchase is $#{@total} \n"
end


def Menu
  puts
  puts "1:) New Item"
  puts "2:) Item Finder"
  puts "3:) Product Purchase"
  print "[1/2/3]: "
  choice = gets.chomp
  if choice == "1"
    Newitem()
  elsif choice == "2"
    Lookup()
  elsif choice == "3"
    Purchase()
  else
    Menu()
  end
end

def Purchase
  puts
  for i in $items
    i.Visual
    puts
  end

  print "Please enter the item number for your purchase: "
  itemP = gets.chomp

  conf = ""
  until conf == "Y" or conf == "N"
    print "Does this look right?: \n"

    for i in $items
      if i.productNumber == itemP
        currentItem = i
        i.Visual
      else
        next
      end
    end
    print "[Y/N]: "
    conf = gets.chomp.upcase
  end

  if conf == "Y"
    print "How many would you like to purchase?: "
    itemnum = gets.to_i
    if itemnum > currentItem.quantityinstock
      puts "Sorry, we dont have that many in stock"
      Purchase()
    else
      receipt = Receipt.new(itemP)
    end

  else
    Purchase()
  end

  print receipt.Display

  currentItem.quantityinstock -= itemnum

  Menu()
end

def Lookup()
  puts
  print "What is the product number you are looking for?: "
  number = gets.chomp
  x = 0
  for i in $productNumbers
    if i == number.to_i
      break
    else
      x += 1
      next
    end
  end
  begin
    puts $items[x].Display
  rescue
    puts "Sorry, that item couldn't be found."
  end

  Menu()

end

def Newitem()
  puts
  print "Enter a product number: "
  productNumber = gets.chomp
  for i in $productNumbers
    if i == productNumber
      print "Product has already been taken \n"
      Newitem()
    else
      next
    end
  end
  $productNumbers.append(productNumber)

  print "Enter a brief product description: "
  description = gets.chomp

  print "Enter Cost of the Item: "
  cost = gets.to_i

  print "The usual markup rate is 300% \n"

  print "How many in stock?: "
  quantity = gets
  arraypos = $y

  $items.append(Product.new(productNumber, description, quantity, arraypos, cost))

  $y += 1

  Menu()
end

DefaultItem()
