require 'flickraw'

module ImageSources
  class Base
    def initialize(tag, quantity)
      @tag = tag
      @quantity = quantity
    end

    def urls
      fail NotImplementedError
    end

    private

    attr_reader :tag, :quantity
  end
end
