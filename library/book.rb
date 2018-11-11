class Book
  attr_reader :title, :author

  def initialize(args_hash)
    @title = title[:title]
    @author = author[:author]
  end

  def to_s
    "Author: #{@author.name}.\nTitle: #{@title}."
  end
end
