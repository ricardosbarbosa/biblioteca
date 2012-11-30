class Livro < ActiveRecord::Base
  attr_accessible :autor, :titulo
  has_many :emprestimos, :dependent => :destroy

  validates_presence_of :titulo, :autor
  validates_uniqueness_of :titulo

  def disponivel?
     if emprestimos.where(:devolvido_em => nil).count > 0
       false
     else
       true
     end
  end


end
