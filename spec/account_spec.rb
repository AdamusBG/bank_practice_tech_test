# frozen_string_literal: true

require 'account'

describe Account do
  let(:mock_account_tools) { double :mock_account_tools }
  subject { Account.new(mock_account_tools) }

  it 'Account_tools receives correct message when balance is called' do
    expect(mock_account_tools).to receive(:balance)
    subject.balance
  end

  describe '#withdraw' do
    it 'A message is printed and no message sent to account_tools when a negative balance is given' do
      expect(STDOUT).to receive(:puts).with('The previous transaction has been cancelled as a negative amount was given, please try again with a positive amount')
      expect(mock_account_tools).to_not receive(:change_balance)
      subject.withdraw(-1000)
    end

    it 'Account_tools receives correct message when valid parameters given' do
      expect(mock_account_tools).to receive(:change_balance).with(-1000, anything)
      subject.withdraw(1000)
    end
  end

  describe '#add' do
    it 'A message is printed and no message sent to account_tools when a negative balance is given' do
      expect(STDOUT).to receive(:puts).with('The previous transaction has been cancelled as a negative amount was given, please try again with a positive amount')
      expect(mock_account_tools).to_not receive(:change_balance)
      subject.add(-1000)
    end

    it 'Account_tools receives correct message when valid parameters given' do
      expect(mock_account_tools).to receive(:change_balance).with(1000, anything)
      subject.add(1000)
    end
  end

  it 'Account_tools receives correct message when balance is called' do
    expect(mock_account_tools).to receive(:print_statement)
    subject.statement
  end
end
