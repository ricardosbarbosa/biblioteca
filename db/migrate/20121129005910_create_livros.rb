class CreateLivros < ActiveRecord::Migration
  def change
    create_table :livros do |t|
      t.string :titulo
      t.string :autor

      t.timestamps
    end

    add_index :livros, :titulo,                :unique => true
  end
end
