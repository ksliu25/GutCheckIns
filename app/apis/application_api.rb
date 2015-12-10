class ApplicationApi < Grape::API
  format :json
  extend Napa::GrapeExtenders

  mount UsersApi => '/users'
  mount StoresApi => '/stores'
  mount VisitsAPI => '/visits'

  add_swagger_documentation
end

