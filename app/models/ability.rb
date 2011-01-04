class Ability
 include CanCan::Ability
 def initialize(user)
    user||=User.new  #new Guest
    if user.is_admin?
    can :manage, :all
    else
    can :read, :all  
	can :create, Article
	can :update, Article do |article|
	article.try(:user) == user
	end
	can :create, Comment
	can :update, Comment do |comment|
	comment.try(:user)==user  
	end
	 can :create, Album
	 can :update, Album do |album|
	 album.try(:user)==user  
	  end
      end
   end  
end
