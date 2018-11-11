class Author
  attr_reader :name, :biography

  def initialize(args_hash)
    @name = name[:name]
    @biography = biography[:biography]
  end

  def to_s
    "Author: #{@name}.\nBiography: #{@biography}."
  end
end
