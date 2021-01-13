# frozen_string_literal: true

require 'transaction'

describe Transaction do
  subject { Transaction.new("01/01/2021", 1000, 2000, 1) }

  it 'Correctly returns date' do
    expect(subject.date.strftime('%d/%m/%Y')).to eq "01/01/2021"
  end

  it 'Correctly returns movement' do
    expect(subject.movement).to eq 1000
  end

  it 'Correctly returns balance' do
    expect(subject.balance).to eq 2000
  end

  it 'Correctly returns number_in_day' do
    expect(subject.number_in_day).to eq 1
  end

  it '#get_date_as_string works correctly' do
    expect(subject.get_date_as_string).to eq "01/01/2021"
  end

end
