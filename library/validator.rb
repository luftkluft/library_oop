# frozen_string_literal: true

module Validator
  include Errors

  def check_for_emptiness(str)
    raise EmptyStringError if str.empty?
  end

  def check_class(entity, klass)
    raise WrongClassError unless entity.is_a? klass
  end
end