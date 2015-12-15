class VisitsApi < Grape::API

  http_basic do |username, password|
    User.authenticate(username, password)
  end

  desc 'Create a visit'
  params do
    requires :store_id, type: Integer, desc: "Id of store where visit is occurring"
    requires :customer_id, type: Integer, desc: "Id of customer making the visit"
    requires :near_location, type: Boolean, desc: "Boolean that is checked by the client's geocode"
    requires :check_in_code, type: String, desc: "Code entered by customer to match store"
  end

  post do
    visit = Visit.create!(permitted_params)
    represent visit, with: VisitRepresenter
  end

  params do
    requires :id, desc: 'ID of the visit'
  end
  route_param :id do
    desc 'Get a visit'
    get do
      visit = Visit.find(params[:id])
      represent visit, with: VisitRepresenter
    end

  end
end
