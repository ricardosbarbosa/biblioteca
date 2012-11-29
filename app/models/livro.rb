class Livro < ActiveRecord::Base
  attr_accessible :autor, :titulo
  has_many :emprestimos, :dependent => :destroy

  validates_uniqueness_of :titulo

  def disponivel?
     if emprestimos.where(:data_de_devolucao => nil).count > 0
       false
     else
       true
     end
  end


end
