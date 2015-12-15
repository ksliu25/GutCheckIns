class UsersApi < Grape::API

  desc 'Create an user'
  params do
    requires :username, type: String, desc: "username of user"
    requires :password, type: String, desc: "password for user"
  end

  post do
    user = User.create!(permitted_params)
    represent user, with: UserRepresenter
  end

  http_basic do |username, password|
    User.authenticate(username, password)
  end
  
  desc 'Get a list of users'
  params do
    optional :ids, type: Array, desc: 'Array of user ids'
  end
  get do
    users = params[:ids] ? User.where(id: params[:ids]) : User.all
    represent users, with: UserRepresenter
  end

  params do
    requires :id, desc: 'ID of the user'
  end
  route_param :id do
    desc 'Get a user'
    get do
      user = User.find(params[:id])
      represent user, with: UserRepresenter
    end

    desc 'Get user visits by descending order'
    get :visits do
      User.find(params[:id]).visits.order(created_at: :desc)
    end

    desc 'Get list of stores and visits per store'
    get :metrics do
      User.find(params[:id]).store_breakdown
    end

    desc 'Get list of stores visited'
    get :stores do
      User.find(params[:id]).array_of_stores
    end

    desc 'Update an user'
    params do
      optional :username, type: String, desc: "username of user"
      optional :password, type: String, desc: "password for user"
    end
    put do
      # fetch user record and update attributes.  exceptions caught in app.rb
      user = User.find(params[:id])
      user.update_attributes!(permitted_params)
      represent user, with: UserRepresenter
    end
  end
end
