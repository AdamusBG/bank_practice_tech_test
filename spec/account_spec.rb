# frozen_string_literal: true

require 'account'

describe Account do
  let(:mock_account_printer) { double :mock_account_printer }
  let(:transaction_class_double) { double :transaction_class }
  let(:mock_transaction) { double :mock_transaction }
  subject { Account.new(mock_account_printer, transaction_class_double) }

  before do
    allow(transaction_class_double).to receive(:new).and_return(mock_transaction)
    allow(mock_transaction).to receive(:get_date_as_string).and_return("01/01/2021")
  end

  it 'Initializes with initial balance of 0' do
    expect(subject.balance).to eq 0
  end

  describe '#add' do
    it 'Account_printer sent correct message when called with negative amount' do
      expect(mock_account_printer).to receive(:print_negative_amount_message)
      subject.add(-1000)
    end

    it 'Account_printer sent correct message when called with invalid date' do
      expect(mock_account_printer).to receive(:print_invalid_date_message)
      subject.add(1000, "01/13/2021")
    end

    it 'Balance correct after one call' do
      subject.add(1000)
      expect(subject.balance).to eq 1000
    end

    it 'Transactions correctly stored' do
      expect(transaction_class_double).to receive(:new)
      subject.add(1000)
    end
  end

  describe '#withdraw' do
    it 'Account_printer sent correct message when called with negative amount' do
      expect(mock_account_printer).to receive(:print_negative_amount_message)
      subject.withdraw(-1000)
    end

    it 'Account_printer sent correct message when called with invalid date' do
      expect(mock_account_printer).to receive(:print_invalid_date_message)
      subject.add(1000, "01/01/2021")
      subject.withdraw(500, "01/13/2021")
    end

    it 'Account_printer sent correct message when transaction would take balance below 0' do
      expect(mock_account_printer).to receive(:print_insufficient_balance_message)
      subject.withdraw(1000)
    end

    it 'Balance correct after one call, following a #add call' do
      subject.add(1000)
      subject.withdraw(500)
      expect(subject.balance).to eq 500
    end

    it 'Transactions correctly stored' do
      subject.add(1000)
      expect(transaction_class_double).to receive(:new)
      subject.withdraw(500)
    end
  end

  it 'Account_printer receives correct message when #statement called' do
    expect(mock_account_printer).to receive(:print_statement)
    subject.statement
  end
end
