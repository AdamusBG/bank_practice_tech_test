# frozen_string_literal: true

class Account
  def initialize(account_tools = AccountTools.new)
    @account_tools = account_tools
  end

  def balance
    @account_tools.balance
  end

  def withdraw(amount, date = Time.now.strftime('%d/%m/%Y'))
    return print_negative_amount_message() unless amount.positive?

    @account_tools.change_balance(-1 * amount, date)
  end

  def add(amount, date = Time.now.strftime('%d/%m/%Y'))
    return print_negative_amount_message() unless amount.positive?

    @account_tools.change_balance(amount, date)
  end

  def statement
    @account_tools.print_statement
  end

  private

  def print_negative_amount_message
    puts 'The previous transaction has been cancelled as a negative amount was given, please try again with a positive amount'
  end
end
