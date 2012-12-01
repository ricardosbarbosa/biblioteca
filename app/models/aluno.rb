class Aluno < ActiveRecord::Base
  attr_accessible :cpf, :nome
  has_many :emprestimos, :dependent => :destroy

  validates_presence_of :nome, :cpf
  validates_uniqueness_of :cpf

  def atrasos?
    if emprestimos.
        where(:data_de_devolucao => nil).
        where("date_part('day', age(date 'now'::timestamp, data_de_emprestimo::timestamp) )  > 7").
        #extract(dow from timestamp 'now')::int
        count > 0
      true
    else
      false
    end
  end
end
