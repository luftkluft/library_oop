# frozen_string_literal: true

require_relative '../library/autoload'

RSpec.describe 'Library' do
  let(:library) { Library.new }
  let(:author) { Author.new('John') }
  let(:book) { Book.new('Alphabet', author) }
  let(:reader) do
    Reader.new(name: 'Sam', email: 'sam@gmail.com',
               city: 'Sam_city', street: 'Sam_street', house: 7)
  end
  let(:order) { Order.new(book, reader) }

  context 'Positive creation check' do
    it 'Positive creation off new Author' do
      expect(author.name).to eq('John')
      expect(author.biography).to eq('')
    end

    it 'Positive creation off new Book' do
      expect(book.title).to eq('Alphabet')
      expect(book.author).to eq(author)
    end

    it 'Positive creation off new Reader' do
      expect(reader.name).to eq('Sam')
      expect(reader.email).to eq('sam@gmail.com')
      expect(reader.city).to eq('Sam_city')
      expect(reader.street).to eq('Sam_street')
      expect(reader.house).to eq(7)
    end

    it 'Positive creation off new Order' do
      expect(order.book).to eq(book)
      expect(order.reader).to eq(reader)
      expect(order.date.class).to eq(Date)
    end
  end

  context 'Negative creation check' do
    it 'Negative creation off new Author' do
      expect { Author.new(1) }.to raise_error('Wrong class!')
      expect { Author.new('') }.to raise_error('You try to send empty string!')
    end

    it 'Negative creation off new Author' do
      expect { Book.new('str', 1) }.to raise_error('Wrong class!')
      expect { Book.new('', author) }.to raise_error('You try to send empty string!')
    end

    it 'Negative creation off new Reader' do
      expect do
        Reader.new(name: 'str', email: 'str', city: '', street: 'str', house: 1)
      end .to raise_error('You try to send empty string!')
      expect do
        Reader.new(name: 'str', email: 2, city: 'str',
                   street: 'str', house: 1)
      end.to raise_error('Wrong class!')
    end

    it 'Negative creation off new Order' do
      expect { Order.new(book, 2) }.to raise_error('Wrong class!')
    end
  end

  it 'Check positive add method' do
    new_author = Author.new('Matt')
    library.add(new_author)
    expect(new_author).to eq(library.authors.last)
  end

  it 'Check negative add method' do
    expect { library.add(1) }
      .to raise_error('Library accepts only Book, Author, Order, Reader classes!')
  end
end
