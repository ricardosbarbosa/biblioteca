class AddDevolvidoEmToEmprestimos < ActiveRecord::Migration
  def change
    add_column :emprestimos, :devolvido_em, :date
  end
end
