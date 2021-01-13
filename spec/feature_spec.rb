# frozen_string_literal: true

require 'account'
require 'account_printer'
require 'transaction'

describe 'Feature' do
  it 'Whole program works as expected over a number of transactions' do
    my_account = Account.new
    my_account.add(1000, '01/01/2021')
    my_account.add(300, '01/01/2021')
    my_account.withdraw(700, '01/01/2021')
    my_account.add(100, '02/01/2021')
    my_account.withdraw(150, '02/01/2021')
    my_account.add(200, '03/01/2021')
    expect(STDOUT).to receive(:puts).with("date || credit || debit || balance\n01/01/2021 || 1000.00 || || 1000.00\n01/01/2021 || 300.00 || || 1300.00\n01/01/2021 || || 700.00 || 600.00\n02/01/2021 || 100.00 || || 700.00\n02/01/2021 || || 150.00 || 550.00\n03/01/2021 || 200.00 || || 750.00")
    my_account.statement
  end

  it 'Insufficient balance message is printed correctly' do
    my_account = Account.new
    my_account.add(1000)
    expect(STDOUT).to receive(:puts).with('The previous transaction has been cancelled as it would take the account\'s balance below 0')
    my_account.withdraw(2000)
  end

  it 'Invalid date message is printed correctly' do
    my_account = Account.new
    expect(STDOUT).to receive(:puts).with('The previous transaction was cancelled as the date was invalid, ensure a valid date is given in DD/MM/YYYY format')
    my_account.add(1000, '01/13/2021')
  end

  it 'Negative amount message is printed correctly' do
    my_account = Account.new
    expect(STDOUT).to receive(:puts).with('The previous transaction has been cancelled as a negative amount was given, please try again with a positive amount')
    my_account.add(-1000)
  end
end
