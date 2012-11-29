class Emprestimo < ActiveRecord::Base
  belongs_to :aluno
  belongs_to :livro
  attr_accessible :data_de_devolucao, :data_de_emprestimo, :aluno, :livro
end
