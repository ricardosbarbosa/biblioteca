class FillRoleTable < ActiveRecord::Migration
  def up
    Role.create(
        :nome=>"biblioteca"
    )

    Role.create(
        :nome=>"aluno"
    )

    Role.create(
        :nome=>"admin"
    )

  end

  def down
    Role.where(:nome=>"admin").delete
    Role.where(:nome=>"aluno").delete
    Role.where(:nome=>"biblioteca").delete

  end
end
