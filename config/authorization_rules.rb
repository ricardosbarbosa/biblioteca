authorization do

  role :admin do

  end

  role :guest do
    has_permission_on [:livros], :to => [:index]
  end

  role :biblioteca do
    includes :guest

  end

end
