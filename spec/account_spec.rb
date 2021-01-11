# frozen_string_literal: true

require 'account'

describe Account do
  it 'Initialises with a balance of 0' do
    expect(subject.balance).to eq 0
  end

  it 'Prints expected statement when there have been no transactions' do
    expect { subject.print_statement }.to output('date || credit || debit || balance').to_stdout
  end

  it 'Has the correct balance after a single credit' do
    subject.credit(1000)
    expect(subject.balance).to eq 1000
  end

  it 'Has the correct balance after a single credit and a single debit' do
    subject.credit(1000)
    subject.debit(500)
    expect(subject.balance).to eq 500
  end

  it 'The balance of the account cannot be reduced below 0' do
    subject.debit(500)
    expect(subject.balance).to eq 0
  end

  it 'If a transaction would take the account\'s balance below 0 a warning message is printed' do
    expect { subject.debit(500) }.to output('The previous transaction has been cancelled as it would take the account\'s balance below 0').to_stdout
  end
end
