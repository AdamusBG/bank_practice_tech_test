# frozen_string_literal: true

class Account
  attr_reader :balance

  def initialize(account_printer = AccountPrinter.new, transaction_class = Transaction)
    @account_printer = account_printer
    @transaction_class = transaction_class
    @balance = 0
    @transactions = []
  end

  def withdraw(amount, date = Time.now.strftime('%d/%m/%Y'))
    return unless valid_details?(amount, date)

    return @account_printer.print_insufficient_balance_message unless enough_money?(amount)
    @balance -= amount
    record_transaction(-1 * amount, date)
  end

  def add(amount, date = Time.now.strftime('%d/%m/%Y'))
    return unless valid_details?(amount, date)

    @balance += amount
    record_transaction(amount, date)
  end

  def statement
    @account_printer.print_statement(@transactions)
  end

  private
  def record_transaction(amount, date)
    number_in_day = @transactions.select { |t| t.get_date_as_string == date}.length + 1
    @transactions << @transaction_class.new(date, amount, @balance, number_in_day)
  end

  def valid_details?(amount, date)
    return @account_printer.print_negative_amount_message unless amount.positive?

    return @account_printer.print_invalid_date_message unless valid_date?(date)

    true
  end

  def valid_date?(date)
    return false unless date.length == 10

    return false unless date[2] == '/' && date[5] == '/'

    split_date = date.split('/')
    !!Time.new(split_date[2], split_date[1], split_date[0]) rescue false
  end

  def enough_money?(amount)
    @balance - amount >= 0
  end
end
