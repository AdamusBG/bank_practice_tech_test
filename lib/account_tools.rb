# frozen_string_literal: true

class AccountTools
  attr_reader :balance

  def initialize
    @balance = 0
    @transactions = []
  end

  def credit(amount, date = Time.now.strftime('%d/%m/%Y'))
    return print_negative_amount_message() unless amount.positive?

    return print_invalid_date_message() unless valid_date?(date)

    @balance += amount
    record_transaction(amount, date)
  end

  def debit(amount, date = Time.now.strftime('%d/%m/%Y'))
    return print_negative_amount_message() unless amount.positive?

    return print_invalid_date_message() unless valid_date?(date)

    if enough_money?(amount)
      @balance -= amount
      record_transaction(-1 * amount, date)
    else
      print_insufficient_balance_message
    end
  end

  def print_statement
    statement = 'date || credit || debit || balance'
    @transactions.reverse.each do |transaction|
      if transaction[0].negative?
        statement += "\n#{transaction[1]} || || %.2f || %.2f" % [(-1 * transaction[0]), transaction[2]]
      else
        statement += "\n#{transaction[1]} || %.2f || || %.2f" % [transaction[0], transaction[2]]
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
    !!Time.new(split_date[2], split_date[1], split_date[0]) rescue false
  end

  def enough_money?(to_deduct)
    @balance - to_deduct >= 0
  end

  def print_insufficient_balance_message
    puts 'The previous transaction has been cancelled as it would take the account\'s balance below 0'
  end

  def print_invalid_date_message
    puts 'The previous transaction was cancelled as the date was invalid, ensure a valid date is given in DD/MM/YYYY format'
  end

  def print_negative_amount_message
    puts 'The previous transaction has been cancelled as a negative amount was given, please try again with a positive amount'
  end
end
