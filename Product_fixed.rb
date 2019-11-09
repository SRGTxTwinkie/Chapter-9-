class Product
    attr_accessor :productNumber, :quantity, :cost, :retail,:arraypos
    def initialize(productNumber, description, quantityinstock, arraypos, cost)
      @productNumber = productNumber
      @description = description
      @cost = cost.to_f.round(2)
      @retail = cost * 3.round(2)
      @quantityinstock = quantityinstock
      @arraypos = arraypos
      OrderCheck()
    end

    def Display()
        puts
        puts "Information Aboout the Product #{@productNumber}"
        puts "Product #{@productNumber}: #{@description}."
        puts "Cost of Product $#{@cost}."
        puts "Retail of Product $#{@retail}."
        puts "We have #{@quantityinstock} available."
    end

    def OrderCheck
      puts
      if @quantityinstock.to_i <= 0
        print "Cannot order 0 product, enter value above 0 \n"
        print "Quantity: "
        x = gets.to_i
        if x<=0
            puts "Enter value above zefro"
            OrderCheck()
        else
            @quantityinstock = x
        end
      end
    end

end
