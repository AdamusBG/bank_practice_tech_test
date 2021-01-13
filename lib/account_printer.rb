# frozen_string_literal: true

class AccountPrinter

  def print_statement(transactions)
    transactions.sort!{ |a, b| (a.date == b.date) ? a.number_in_day <=> b.number_in_day : a.date <=> b.date }
    statement = 'date || credit || debit || balance'
    transactions.each do |transaction|
      if transaction.movement.negative?
        statement += "\n#{transaction.get_date_as_string} || || %.2f || %.2f" % [(-1 * transaction.movement), transaction.balance]
      else
        statement += "\n#{transaction.get_date_as_string} || %.2f || || %.2f" % [transaction.movement, transaction.balance]
      end
    end
    puts statement
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
