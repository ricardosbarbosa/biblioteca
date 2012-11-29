class CreateEmprestimos < ActiveRecord::Migration
  def change
    create_table :emprestimos do |t|
      t.belongs_to :aluno
      t.belongs_to :livro
      t.date :data_de_emprestimo
      t.date :data_de_devolucao

      t.timestamps
    end
    add_index :emprestimos, :aluno_id
    add_index :emprestimos, :livro_id
  end
end
