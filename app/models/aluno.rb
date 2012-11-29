class Aluno < ActiveRecord::Base
  attr_accessible :cpf, :nome
  has_many :emprestimos, :dependent => :destroy

  def atrasos?
    if emprestimos.
        where(:data_de_devolucao => nil).
        where("strftime('%s',date('now')) - strftime('%s', data_de_emprestimo)  > 7*24*60*60").
        count > 0
      true
    else
      false
    end
  end
end
