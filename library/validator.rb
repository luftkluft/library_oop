# frozen_string_literal: true

module Validator
  include Errors

  def check_for_emptiness(string)
    raise EmptyStringError if string.empty?
  end

  def check_class(entity, klass)
    raise WrongClassError unless entity.is_a? klass
  end
end
