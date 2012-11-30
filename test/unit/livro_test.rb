require 'test_helper'

class LivroTest < ActiveSupport::TestCase

  fixtures :livros

  validates_presence_of :data_de_emprestimo, :data_de_devolucao, :aluno, :livro
  validate :validate_data_no_passado
  validate :validate_data_de_devolucao_anterior_a_data_do_emprestimo
  validate :validate_livro_nao_disponivel
  validate :validate_devolvido_em_anterior_a_data_de_emprestimo

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
    assert livro.errors[:titulo].any?
  end


end
