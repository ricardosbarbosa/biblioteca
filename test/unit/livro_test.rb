require 'test_helper'

class LivroTest < ActiveSupport::TestCase

  fixtures :livros

  test "Os aributos de livro nao devem ser nulos" do
    livro = Livro.new

    assert livro.invalid?
    assert livro.errors[:titulo].any?
    assert livro.errors[:autor].any?
  end

  test "Livro nao pode ter o mesmo nome" do
    livro1 = livros(:livro1)
    livro = Livro.new( {
                           :titulo => livro1.titulo,
                           :autor => livro1.autor
                       }
    )

    assert livro.invalid?
    assert livro.errors[:author].none?
    assert livro.errors[:titulo].any?

    livro.titulo = "XXX"

    assert livro.valid?
    assert livro.errors[:author].none?
    assert livro.errors[:titulo].none?
  end


end
