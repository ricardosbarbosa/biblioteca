# encoding: utf-8
class Emprestimo < ActiveRecord::Base
  belongs_to :aluno
  belongs_to :livro
  attr_accessible :data_de_devolucao, :data_de_emprestimo, :aluno_id, :livro_id, :devolvido_em

  validates_presence_of :data_de_emprestimo, :data_de_devolucao, :aluno, :livro
  validate :validate_data_de_emprestimoo_no_passado
  #validate :validate_data_de_devolucao_anterior_a_data_do_emprestimo
  #validate :validate_livro_nao_disponivel
  #validate :validate_devolvido_em_anterior_a_data_de_emprestimo

  def status
    if devolvido_em
      if devolvido_em - data_de_emprestimo <= 7
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

  def validate_data_de_emprestimoo_no_passado
    if data_de_emprestimo != nil
      errors.add(:data_de_emprestimo, "Empréstimo não pode ser solicitado para o passado.") if data_de_emprestimo < Time.now.to_date
    end
  end

  #def validate_data_de_devolucao_anterior_a_data_do_emprestimo
  #  if data_de_devolucao
  #    errors.add(:data_de_emprestimo, "A data de devolução não pode ser anterior a data de emprestimo.") if data_de_devolucao < data_de_emprestimo
  #  end
  #end
  #
  #def validate_devolvido_em_anterior_a_data_de_emprestimo
  #  if devolvido_em
  #    errors.add(:devolvido_em, "A data de devolvido em nao pode ser anterior a data de emprestimo.")  if devolvido_em < data_de_emprestimo
  #  end
  #end
  #
  #def validate_livro_nao_disponivel
  #  if livro
  #    errors.add(:livro, "O livro não encontra-se disponível para empréstimo") if !livro.disponivel?
  #  end
  #end
end
