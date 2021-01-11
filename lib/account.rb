class Account
  attr_reader :balance

  def initialize
    @balance = 0
    @transactions = []
  end

  def credit(amount, date = Time.now.strftime('%d/%m/%Y'))
    return unless valid_date?(date)

    @balance += amount
    record_transaction(amount, date)
  end

  def debit(amount, date = Time.now.strftime('%Y/%m/%d'))
    reduce_balance(amount, date) if enough_money?(amount)
  end

  def print_statement
    statement = 'date || credit || debit || balance'
    @transactions.reverse.each do |transaction|
      if transaction[0] < 0
        statement = statement + "\n#{transaction[1]} || || #{'%.2f' % (-1 * transaction[0])} || #{'%.2f' % transaction[2]}"
      else
        statement = statement +"\n#{transaction[1]} || #{'%.2f' % transaction[0]} || || #{'%.2f' % transaction[2]}"
      end
    end
    puts statement
  end

  private

  def reduce_balance(amount, date)
    @balance -= amount
    record_transaction(-1 * amount, date)
  end

  def record_transaction(amount, date)
    @transactions << [amount, date, @balance]
  end

  def valid_date?(date)
    return false unless date.length == 10
    return false unless date[2] == '/' && date[5] == '/'
    split_date = date.split('/')
    return_value = !! Time.new(split_date[2], split_date[1], split_date[0]) rescue false
    print_invalid_date_message unless return_value
    return_value
  end

  def enough_money?(to_deduct)
    return_value = @balance - to_deduct >= 0 ? true : false
    print_insufficient_balance_message unless return_value
    return_value
  end

  def print_insufficient_balance_message
    puts 'The previous transaction has been cancelled as it would take the account\'s balance below 0'
  end

  def print_invalid_date_message
    puts 'The previous transaction was cancelled as the date was invalid, ensure a valid date is given in DD/MM/YYYY format'
  end

end
