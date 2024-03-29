require 'test_helper'

class EmprestimoTest < ActiveSupport::TestCase

  fixtures :emprestimos, :livros

  def setup
    @emp = emprestimos(:emprestimo1)
    @emp.data_de_emprestimo = 1.day.from_now
    @emp.data_de_devolucao = 6.day.from_now
    @emp.livro = livros(:livro_sempre_disponivel)
  end

  def teardown
    @emp = nil
  end


  test "devolvido em anterior a data de emprestimo" do
    @emp.data_de_emprestimo = Date.today

    @emp.devolvido_em = @emp.data_de_emprestimo - 1.day
    assert @emp.invalid?
    assert @emp.errors[:devolvido_em].any?,@emp.errors.to_a.join
    @emp.devolvido_em = @emp.data_de_emprestimo - 1.month
    assert @emp.invalid?
    assert @emp.errors[:devolvido_em].any?
    @emp.devolvido_em = @emp.data_de_emprestimo - 1.year
    assert @emp.invalid?
    assert @emp.errors[:devolvido_em].any?

    @emp.data_de_emprestimo = Date.today
    @emp.devolvido_em = @emp.data_de_emprestimo + 1.day
    @emp.devolvido_em = @emp.devolvido_em.to_date
    @emp.data_de_emprestimo = @emp.data_de_emprestimo.to_date
    @emp.data_de_devolucao = @emp.data_de_devolucao.to_date
    assert @emp.errors[:devolvido_em].none?, @emp.errors[:devolvido_em].join
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
