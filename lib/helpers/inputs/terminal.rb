module Inputs
  class Terminal < Base
    def self.options
      {
        tag: ARGV[1],
        size: ARGV[3].to_sym,
        quantity: ARGV[5].to_i,
        file_name: ARGV[7]
      }
    end
  end
end
