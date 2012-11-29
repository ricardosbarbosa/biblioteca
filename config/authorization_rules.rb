authorization do

  role :admin do
     has_permission_on [:livros], :to => [:index, :show, :new, :create, :edit, :update, :destroy]
     has_permission_on [:alunos], :to => [:index, :show, :new, :create, :edit, :update, :destroy]
     has_permission_on [:emprestimos], :to => [:index, :show, :new, :create, :edit, :update, :destroy]
  end

  role :guest do
    has_permission_on [:livros], :to => [:index]
  end

  role :biblioteca do
    includes :guest
    has_permission_on [:livros], :to => [:index, :show, :new, :create, :edit, :update, :destroy]
    has_permission_on [:alunos], :to => [:index, :show, :new, :create, :edit, :update, :destroy]
    has_permission_on [:emprestimos], :to => [:index, :show, :new, :create, :edit, :update, :destroy]
  end

end
