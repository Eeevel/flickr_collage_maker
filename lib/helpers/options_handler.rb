class OptionsHandler
  def self.options(argv)
    {
      tag: argv[1],
      size: argv[3].to_sym,
      quanity: argv[5].to_i,
      file_name: argv[7]
    }
  end
end
