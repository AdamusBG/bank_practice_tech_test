# frozen_string_literal: true

require 'account_printer'

describe AccountPrinter do
  let(:mock_transaction1) { double :mock_transaction1 }
  let(:mock_transaction2) { double :mock_transaction2 }
  let(:mock_transaction3) { double :mock_transaction3 }

  it "#print_insufficient_balance_message works correctly" do
    expect(STDOUT).to receive(:puts).with('The previous transaction has been cancelled as it would take the account\'s balance below 0')
    subject.print_insufficient_balance_message
  end

  it "#print_invalid_date_message works correctly" do
    expect(STDOUT).to receive(:puts).with('The previous transaction was cancelled as the date was invalid, ensure a valid date is given in DD/MM/YYYY format')
    subject.print_invalid_date_message
  end

  it "#print_negative_amount_message works correctly" do
    expect(STDOUT).to receive(:puts).with('The previous transaction has been cancelled as a negative amount was given, please try again with a positive amount')
    subject.print_negative_amount_message
  end

  describe "#print_statement" do
    before do
      allow(mock_transaction1).to receive(:date).and_return(Time.new(2021, 1, 1))
      allow(mock_transaction1).to receive(:movement).and_return(1000)
      allow(mock_transaction1).to receive(:balance).and_return(1000)
      allow(mock_transaction1).to receive(:number_in_day).and_return(1)
      allow(mock_transaction1).to receive(:get_date_as_string).and_return("01/01/2021")
      allow(mock_transaction2).to receive(:date).and_return(Time.new(2021, 1, 1))
      allow(mock_transaction2).to receive(:movement).and_return(-500)
      allow(mock_transaction2).to receive(:balance).and_return(500)
      allow(mock_transaction2).to receive(:number_in_day).and_return(2)
      allow(mock_transaction2).to receive(:get_date_as_string).and_return("01/01/2021")
      allow(mock_transaction3).to receive(:date).and_return(Time.new(2021, 1, 2))
      allow(mock_transaction3).to receive(:movement).and_return(300)
      allow(mock_transaction3).to receive(:balance).and_return(800)
      allow(mock_transaction3).to receive(:number_in_day).and_return(1)
      allow(mock_transaction3).to receive(:get_date_as_string).and_return("02/01/2021")
    end

    it "Prints correctly when given no transactions" do
      expect(STDOUT).to receive(:puts).with('date || credit || debit || balance')
      subject.print_statement([])
    end

    it "Prints correctly when given 1 transaction" do
      expect(STDOUT).to receive(:puts).with("date || credit || debit || balance\n01/01/2021 || 1000.00 || || 1000.00")
      subject.print_statement([mock_transaction1])
    end

    it "Prints correctly when given 3 transactions" do
      expect(STDOUT).to receive(:puts).with("date || credit || debit || balance\n01/01/2021 || 1000.00 || || 1000.00\n01/01/2021 || || 500.00 || 500.00\n02/01/2021 || 300.00 || || 800.00")
      subject.print_statement([mock_transaction1, mock_transaction2, mock_transaction3])
    end

    it "Prints correctly when given 3 transactions, regardless of the order" do
      expect(STDOUT).to receive(:puts).with("date || credit || debit || balance\n01/01/2021 || 1000.00 || || 1000.00\n01/01/2021 || || 500.00 || 500.00\n02/01/2021 || 300.00 || || 800.00")
      subject.print_statement([mock_transaction3, mock_transaction1, mock_transaction2])
    end
  end
end
