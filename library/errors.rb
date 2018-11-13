module Errors
  class ClassError < StandardError
    def initialize
      super('Сlass mismatch!')
    end
  end

  class StringError < StandardError
    def initialize
      super('It is empty string!')
    end
  end
end