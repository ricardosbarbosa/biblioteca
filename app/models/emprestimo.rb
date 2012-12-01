# encoding: utf-8
class Emprestimo < ActiveRecord::Base

  belongs_to :aluno
  belongs_to :livro
  attr_accessible :data_de_devolucao, :data_de_emprestimo, :aluno_id, :livro_id, :devolvido_em

  validates_presence_of :data_de_emprestimo, :data_de_devolucao, :aluno, :livro
  validate :validate_data_de_emprestimoo_no_passado, :on => :create
  validate :validate_data_de_devolucao_anterior_a_data_do_emprestimo
  validate :validate_data_de_devolucao_deve_ser_de_no_maximo_7_dias
  validate :validate_livro_nao_disponivel, :on => :create
  validate :validate_devolvido_em_anterior_a_data_de_emprestimo, :on => :update

  def status
    if devolvido_em
      if devolvido_em < data_de_devolucao
        "ENTREGUE"
      else
        "ENTREGUE COM ATRASO"
      end
    elsif Date.today > data_de_devolucao
      "ATRASADO"
    else
      "ALUGADO"
    end
  end

  def validate_data_de_devolucao_deve_ser_de_no_maximo_7_dias
    if data_de_devolucao and data_de_emprestimo
      errors.add(:data_de_devolucao, "A data de devolução deve ser de no máximo 7 dias após a data de empréstimo.") if (data_de_devolucao - data_de_emprestimo).days > 7.days
    end
  end

  def validate_data_de_emprestimoo_no_passado
    if data_de_emprestimo
      errors.add(:data_de_emprestimo, "Empréstimo não pode ser solicitado para o passado.") if data_de_emprestimo < Date.today
    end
  end

  def validate_data_de_devolucao_anterior_a_data_do_emprestimo
    if data_de_devolucao and data_de_emprestimo
      errors.add(:data_de_devolucao, "A data de devolução não pode ser anterior a data de empréstimo.") if data_de_devolucao < data_de_emprestimo
    end
  end

  def validate_devolvido_em_anterior_a_data_de_emprestimo
    if devolvido_em and data_de_emprestimo
      errors.add(:devolvido_em, "A data de 'devolvido em' não pode ser anterior a data de empréstimo.")  if devolvido_em < data_de_emprestimo
    end
  end

  def validate_livro_nao_disponivel
    if livro
      errors.add(:livro, "O livro não encontra-se disponível para empréstimo") if !livro.disponivel?
    end
  end
end
