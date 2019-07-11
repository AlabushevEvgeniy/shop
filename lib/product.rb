class Product
  attr_accessor :price, :amount

  def initialize(params)
    @price = params[:price]
    @amount = params[:amount]
    @initial_amount = params[:amount]
  end

  def to_s
    "#{@price} руб. (осталось #{@amount})"
  end

  def update(params)
    @price = params[:price] if params[:price]
    @amount = params[:amount] if params[:amount]
  end

  def is_empty?(params)
    @amount == 0
  end

  def stuff
    @initial_amount.to_i - @amount.to_i
  end

  def self.from_file(file_path)
    raise NotImplementedError
  end
end
