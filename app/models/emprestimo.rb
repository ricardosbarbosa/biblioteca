# encoding: utf-8
class Emprestimo < ActiveRecord::Base
  belongs_to :aluno
  belongs_to :livro
  attr_accessible :data_de_devolucao, :data_de_emprestimo, :aluno_id, :livro_id

  validates_presence_of :data_de_emprestimo, :aluno, :livro
  validate :validate_data_no_passado
  validate :validate_data_de_devolucao_anterior_a_data_do_emprestimo
  validate :validate_livro_nao_disponivel

  def status
    if data_de_devolucao
      if data_de_devolucao - data_de_emprestimo <= 7
        "ENTREGUE"
      else
        "ENTREGUE COM ATRASO"
      end
    elsif Time.now.to_date - data_de_emprestimo > 7
      "ATRASADO"
    else
      "ALUGADO"
    end
  end

  def validate_data_no_passado
    if data_de_emprestimo
      errors.add(:data_de_emprestimo, "Empréstimo não pode ser solicitado para o passado.") if data_de_emprestimo < DateTime.now.to_date
    end
  end

  def validate_data_de_devolucao_anterior_a_data_do_emprestimo
    if data_de_devolucao
      errors.add(:data_de_emprestimo, "A data de devolução não pode ser anterior a data de emprestimo.") if data_de_devolucao < data_de_emprestimo
    end
  end

  def validate_livro_nao_disponivel
    if livro
      errors.add(:livro, "O livro não encontra-se disponível para empréstimo") if !livro.disponivel?
    end
  end
end