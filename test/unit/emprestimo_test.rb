require 'test_helper'

class EmprestimoTest < ActiveSupport::TestCase

  fixtures :emprestimos, :livros

  def setup
    @emp = emprestimos(:emprestimo1)
    @emp.data_de_emprestimo = 1.day.from_now
    @emp.data_de_devolucao = 6.day.from_now
  end

  def teardown
    @emp = nil
  end

  test "tentando salvar um emprestimo para um livro nao disponivel" do
    @emp = emprestimos(:emprestimo2)
    @emp.data_de_emprestimo = 0.day.from_now
    @emp.data_de_devolucao = @emp.data_de_emprestimo + 1.day
    @emp.livro = livros(:livro3)
    assert @emp.valid?
    @emp.save

    emprestimo2 = Emprestimo.new
    emprestimo2.data_de_emprestimo = 0.day.from_now
    emprestimo2.data_de_devolucao = emprestimo2.data_de_emprestimo + 1.day
    emprestimo2.aluno = @emp.aluno
    emprestimo2.livro = livros(:livro2)
    assert emprestimo2.valid?
    emprestimo2.livro = @emp.livro
    assert emprestimo2.invalid?

    @emp.delete
    assert emprestimo2.valid?
  end

  test "devolvido em anterior a data de emprestimo" do
    @emp.data_de_emprestimo = 0.day.from_now

    @emp.devolvido_em = @emp.data_de_emprestimo - 1.day
    assert @emp.invalid?
    assert @emp.errors[:devolvido_em].any?
    @emp.devolvido_em = @emp.data_de_emprestimo - 1.month
    assert @emp.invalid?
    assert @emp.errors[:devolvido_em].any?
    @emp.devolvido_em = @emp.data_de_emprestimo - 1.year
    assert @emp.invalid?
    assert @emp.errors[:devolvido_em].any?

    @emp.devolvido_em = @emp.data_de_emprestimo + 1.day
    assert @emp.errors[:devolvido_em].none?
    @emp.devolvido_em = @emp.data_de_emprestimo + 1.month
    assert @emp.errors[:devolvido_em].none?
    @emp.devolvido_em = @emp.data_de_emprestimo + 1.day
    assert @emp.errors[:devolvido_em].none?

  end

  test "data_de_devolucao deve ser de no maximo 7 dias" do
    @emp.data_de_emprestimo = 0.day.from_now

    @emp.data_de_devolucao = @emp.data_de_emprestimo + 1.day
    assert @emp.errors[:data_de_devolucao].none?
    @emp.data_de_devolucao = @emp.data_de_emprestimo + 2.day
    assert @emp.errors[:data_de_devolucao].none?
    @emp.data_de_devolucao = @emp.data_de_emprestimo + 3.day
    assert @emp.errors[:data_de_devolucao].none?
    @emp.data_de_devolucao = @emp.data_de_emprestimo + 4.day
    assert @emp.errors[:data_de_devolucao].none?
    @emp.data_de_devolucao = @emp.data_de_emprestimo + 5.day
    assert @emp.errors[:data_de_devolucao].none?
    @emp.data_de_devolucao = @emp.data_de_emprestimo + 6.day
    assert @emp.errors[:data_de_devolucao].none?
    @emp.data_de_devolucao = @emp.data_de_emprestimo + 7.day
    assert @emp.errors[:data_de_devolucao].none?

    @emp.data_de_devolucao = @emp.data_de_emprestimo + 8.day
    assert @emp.invalid?
    assert @emp.errors[:data_de_devolucao].any?

  end

  test "a data de devolucao nao deve ser menor que a data de emprestimo " do
    @emp.data_de_emprestimo= 0.day.from_now

    @emp.data_de_devolucao = @emp.data_de_emprestimo + 1.day
    assert @emp.errors[:data_de_devolucao].none?
    @emp.data_de_devolucao = @emp.data_de_emprestimo + 2.day
    assert @emp.errors[:data_de_devolucao].none?
    @emp.data_de_devolucao = @emp.data_de_emprestimo + 3.day
    assert @emp.errors[:data_de_devolucao].none?

    @emp.data_de_emprestimo= 0.day.from_now

    @emp.data_de_devolucao = 1.day.ago
    assert @emp.invalid?
    assert @emp.errors[:data_de_devolucao].any?
    @emp.data_de_devolucao = 2.day.ago
    assert @emp.invalid?
    assert @emp.errors[:data_de_devolucao].any?
    @emp.data_de_devolucao = 3.day.ago
    assert @emp.invalid?
    assert @emp.errors[:data_de_devolucao].any?
    @emp.data_de_devolucao = 4.day.ago
    assert @emp.invalid?
    assert @emp.errors[:data_de_devolucao].any?
    @emp.data_de_devolucao = 5.day.ago
    assert @emp.invalid?
    assert @emp.errors[:data_de_devolucao].any?
    @emp.data_de_devolucao = 6.day.ago
    assert @emp.invalid?
    assert @emp.errors[:data_de_devolucao].any?

  end

  test "data de emprestimo no passado" do

    @emp.data_de_emprestimo = 0.day.from_now
    @emp.data_de_devolucao = 6.day.from_now
    assert @emp.errors[:data_de_emprestimo].none?

    @emp.data_de_emprestimo = 0.day.from_now
    assert @emp.errors[:data_de_emprestimo].none?


    @emp.data_de_emprestimo = 1.day.ago
    @emp.data_de_devolucao = @emp.data_de_emprestimo + 1.day
    assert @emp.invalid?
    assert @emp.errors[:data_de_emprestimo].any?
    @emp.data_de_emprestimo = 1.month.ago
    @emp.data_de_devolucao = @emp.data_de_emprestimo + 1.day
    assert @emp.invalid?
    assert @emp.errors[:data_de_emprestimo].any?
    @emp.data_de_emprestimo = 1.year.ago
    @emp.data_de_devolucao = @emp.data_de_emprestimo + 1.day
    assert @emp.invalid?
    assert @emp.errors[:data_de_emprestimo].any?

    @emp.data_de_emprestimo = 1.day.from_now.to_date
    @emp.data_de_devolucao = @emp.data_de_emprestimo + 2.day
    assert @emp.errors[:data_de_emprestimo].none?
    @emp.data_de_emprestimo = 30.day.from_now.to_date
    @emp.data_de_devolucao= @emp.data_de_emprestimo + 1.day
    assert @emp.errors[:data_de_emprestimo].none?
    @emp.data_de_emprestimo = 360.year.from_now.to_date
    @emp.data_de_devolucao= @emp.data_de_emprestimo + 1.day
    assert @emp.errors[:data_de_emprestimo].none?

    assert @emp.errors[:data_de_emprestimo].none?

  end

  test "data de emprestimo nao pode ser nulo" do

    @emp.data_de_emprestimo = 0.day.from_now
    @emp.data_de_devolucao = 6.day.from_now

    assert @emp.errors[:data_de_emprestimo].none?

    @emp.data_de_emprestimo = nil

    assert @emp.invalid?
    assert @emp.errors[:data_de_emprestimo].any?
  end

  test "data_de_devolucao nao pode ser nulo" do

    assert @emp.errors[:data_de_devolucao].none?

    @emp.data_de_devolucao = nil

    assert @emp.invalid?
    assert @emp.errors[:data_de_devolucao].any?
  end

  test "aluno nao pode ser nulo" do

    assert @emp.errors[:aluno].none?

    @emp.aluno = nil

    assert @emp.invalid?
    assert @emp.errors[:aluno].any?
  end

  test "livro nao pode ser nulo" do
    @emp.data_de_emprestimo = 0.day.from_now
    @emp.data_de_devolucao = 6.day.from_now

    assert @emp.errors[:livro].none?

    @emp.livro = nil

    assert @emp.invalid?
    assert @emp.errors[:livro].any?

  end
end
