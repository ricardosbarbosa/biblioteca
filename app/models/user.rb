class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
  # attr_accessible :title, :body

  has_many :assignments
  has_many :roles, :through => :assignments

  def role_symbols
    roles.map do |role|
      role.nome.underscore.to_sym
    end
  end

  def has_role? role
    role_symbols.include?(role)
  end

end
