# frozen_string_literal: true

class Transaction
  attr_reader :date, :movement, :balance, :number_in_day

  def initialize(date, movement, balance, number_in_day)
    @date = date_from_string(date)
    @movement = movement
    @balance = balance
    @number_in_day = number_in_day
  end

  def get_date_as_string
    @date.strftime('%d/%m/%Y')
  end

  private
  def date_from_string(date)
    split_date = date.split('/')
    Time.new(split_date[2], split_date[1], split_date[0])
  end
end
