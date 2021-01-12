# frozen_string_literal: true

require 'account_tools'

describe AccountTools do
  it 'Initialises with a balance of 0' do
    expect(subject.balance).to eq 0
  end

  describe '#change_balance' do
    it 'Has the correct balance after a single call' do
      subject.change_balance(1000)
      expect(subject.balance).to eq 1000
    end

    it 'If an invalid date is given, a message is printed' do
      expect(STDOUT).to receive(:puts).with('The previous transaction was cancelled as the date was invalid, ensure a valid date is given in DD/MM/YYYY format')
      subject.change_balance(1000, '50/01/2020')
    end

    it 'If an invalid date is given, the balance does not change' do
      subject.change_balance(1000, '50/01/2020')
      expect(subject.balance).to eq 0
    end

    it "The balance of the account cannot be reduced below 0" do
      subject.change_balance(-500)
      expect(subject.balance).to eq 0
    end

    it 'If a transaction would take the account\'s balance below 0 a warning message is printed' do
        expect(STDOUT).to receive(:puts).with('The previous transaction has been cancelled as it would take the account\'s balance below 0')
        subject.change_balance(-500)
      end
  end

  describe '#print_statement' do
    it 'Correct after 0 transactions' do
      expect(STDOUT).to receive(:puts).with('date || credit || debit || balance')
      subject.print_statement
    end

    it 'Correct after 1 valid deposit' do
      subject.change_balance(1000, '01/01/2020')
      expect(STDOUT).to receive(:puts).with("date || credit || debit || balance\n01/01/2020 || 1000.00 || || 1000.00")
      subject.print_statement
    end

    it 'Correct after 1 valid deposit and 1 valid withdrawal' do
      subject.change_balance(1000, '01/01/2020')
      subject.change_balance(-500, '02/01/2020')
      expect(STDOUT).to receive(:puts).with("date || credit || debit || balance\n02/01/2020 || || 500.00 || 500.00\n01/01/2020 || 1000.00 || || 1000.00")
      subject.print_statement
    end

    it 'Correct after 1 valid deposit, 1 valid withdrawal and 1 invalid deposit' do
      subject.change_balance(1000, '01/01/2020')
      subject.change_balance(-500, '02/01/2020')
      subject.change_balance(1000, '01/13/2020')
      expect(STDOUT).to receive(:puts).with("date || credit || debit || balance\n02/01/2020 || || 500.00 || 500.00\n01/01/2020 || 1000.00 || || 1000.00")
      subject.print_statement
    end

    it 'Correct after 1 valid deposit, 1 valid withdrawal and 1 invalid withdrawal' do
      subject.change_balance(1000, '01/01/2020')
      subject.change_balance(-500, '02/01/2020')
      subject.change_balance(-1000, '03/01/2020')
      expect(STDOUT).to receive(:puts).with("date || credit || debit || balance\n02/01/2020 || || 500.00 || 500.00\n01/01/2020 || 1000.00 || || 1000.00")
      subject.print_statement
    end
  end
end
