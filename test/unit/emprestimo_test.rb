require 'test_helper'

class EmprestimoTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  #validates_presence_of :data_de_emprestimo, :data_de_devolucao, :aluno, :livro

  #validate :validate_data_de_emprestimoo_no_passado
  #validate :validate_data_de_devolucao_anterior_a_data_do_emprestimo
  #validate :validate_livro_nao_disponivel
  #validate :validate_devolvido_em_anterior_a_data_de_emprestimo

  fixtures :emprestimos

  test "data de emprestimo no passado" do
    emp = emprestimos(:emprestimo1)

    emp.data_de_emprestimo = 0.day.from_now
    emp.data_de_devolucao = 6.day.from_now
    assert emp.valid?

    #emp.data_de_emprestimo = 0.day.from_now
    #assert emp.valid?

    emp.data_de_emprestimo = 1.day.ago
    assert emp.invalid?, emp.data_de_emprestimo.to_s
    emp.data_de_emprestimo = 1.month.ago
    assert emp.invalid?, emp.data_de_emprestimo.to_s
    emp.data_de_emprestimo = 1.year.ago
    assert emp.invalid?, emp.data_de_emprestimo.to_s

    emp.data_de_emprestimo = 1.day.from_now.to_date
    assert emp.valid?, emp.data_de_emprestimo.to_s
    emp.data_de_emprestimo = 1.month.from_now.to_date
    assert emp.valid?, emp.data_de_emprestimo.to_s
    emp.data_de_emprestimo = 1.year.from_now.to_date
    assert emp.valid?, emp.data_de_emprestimo.to_s

    assert emp.errors[:data_de_emprestimo].none?

  end

  test "data de emprestimo nao pode ser nulo" do
    emp = emprestimos(:emprestimo1)

    emp.data_de_emprestimo = 0.day.from_now
    emp.data_de_devolucao = 6.day.from_now

    assert emp.valid?
    assert emp.errors[:data_de_emprestimo].none?

    emp.data_de_emprestimo = nil

    assert emp.invalid?
    assert emp.errors[:data_de_emprestimo].any?
  end

  test "data_de_devolucao nao pode ser nulo" do
    emp = emprestimos(:emprestimo1)

    emp.data_de_emprestimo = 0.day.from_now
    emp.data_de_devolucao = 6.day.from_now

    assert emp.valid?
    assert emp.errors[:data_de_devolucao].none?

    emp.data_de_devolucao = nil

    assert emp.invalid?
    assert emp.errors[:data_de_devolucao].any?
  end

  test "aluno nao pode ser nulo" do
    emp = emprestimos(:emprestimo1)

    emp.data_de_emprestimo = 0.day.from_now
    emp.data_de_devolucao = 6.day.from_now

    assert emp.valid?
    assert emp.errors[:aluno].none?

    emp.aluno = nil

    assert emp.invalid?
    assert emp.errors[:aluno].any?
  end

  test "livro nao pode ser nulo" do
    emp = emprestimos(:emprestimo1)
    emp.data_de_emprestimo = 0.day.from_now
    emp.data_de_devolucao = 6.day.from_now

    assert emp.valid?
    assert emp.errors[:livro].none?

    emp.livro = nil

    assert emp.invalid?
    assert emp.errors[:livro].any?
  end
end
