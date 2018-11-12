# frozen_string_literal: true

class Reader
  attr_reader :name, :email, :city, :street, :house

  def initialize(args_hash)
    @name = args_hash[:name]
    @email = args_hash[:email]
    @city = args_hash[:city]
    @street = args_hash[:street]
    @house = args_hash[:house]
  end

  def to_s
    "Name: #{@name}\nE-mail: #{email}"
  end
end
