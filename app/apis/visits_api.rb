class VisitsApi < Grape::API
  desc 'Get a list of visits'
  params do
    optional :ids, type: Array, desc: 'Array of visit ids'
  end
  get do
    visits = params[:ids] ? Visit.where(id: params[:ids]) : Visit.all
    represent visits, with: VisitRepresenter
  end

  desc 'Create an visit'
  params do
    optional :store_id, type: Integer, desc: "Id of store where visit is occurring"
    optional :customer_id, type: Integer, desc: "Id of customer making the visit"
    optional :near_location, type: Boolean, desc: "Boolean that is checked by the client's geocode"
    optional :check_in_code, type: String, desc: "Code entered by customer to match store"
  end

  post do
    visit = Visit.create!(permitted_params)
    represent visit, with: VisitRepresenter
  end

  params do
    requires :id, desc: 'ID of the visit'
  end
  route_param :id do
    desc 'Get an visit'
    get do
      visit = Visit.find(params[:id])
      represent visit, with: VisitRepresenter
    end

    desc 'Update an visit'
    params do
      optional :store_id, type: Integer, desc: "Id of store where visit is occurring"
      optional :customer_id, type: Integer, desc: "Id of customer making the visit"
      optional :near_location, type: Boolean, desc: "Boolean that is checked by the client's geocode"
      optional :check_in_code, type: String, desc: "Code entered by customer to match store"
    end
    put do
      # fetch visit record and update attributes.  exceptions caught in app.rb
      visit = Visit.find(params[:id])
      visit.update_attributes!(permitted_params)
      represent visit, with: VisitRepresenter
    end
  end
end
