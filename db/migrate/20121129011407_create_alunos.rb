class CreateAlunos < ActiveRecord::Migration
  def change
    create_table :alunos do |t|
      t.string :nome
      t.string :cpf

      t.timestamps
    end

    add_index :alunos, :cpf,                :unique => true
  end
end
