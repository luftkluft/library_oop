# frozen_string_literal: true

class Reader
  attr_reader :name, :email, :city, :street, :house
  include Validator

  def initialize(name:, email:, city:, street:, house:)
    validate(name, email, city, street, house)
    @name = name
    @email = email
    @city = city
    @street = street
    @house = house
  end

  def validate(name, email, city, street, house)
    [name, email, city, street].each do |personal_data|
      check_class(personal_data, String)
      check_for_emptiness(personal_data)
    end
    check_class(house, Integer)
  end
end