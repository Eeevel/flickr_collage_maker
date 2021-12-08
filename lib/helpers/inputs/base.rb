module Inputs
  class Base
    def self.options
      fail NotImplementedError
    end
  end
end
