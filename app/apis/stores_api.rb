class StoresApi < Grape::API
  desc 'Get a list of stores'
  params do
    optional :ids, type: Array, desc: 'Array of store ids'
  end
  get do
    stores = params[:ids] ? Store.where(id: params[:ids]) : Store.all
    represent stores, with: StoreRepresenter
  end

  desc 'Create an store'
  params do
    requires :name, type: String, desc: "Name of store"
    requires :address, type: String, desc: "Address of store"
    requires :latitude, type: Float, desc: "Latitude of address provided"
    requires :longitude, type: Float, desc: "Longitude of address provided"
    requires :daily_code, type: String, desc: "Daily code for store"
    requires :owner_id, type: Integer, desc: "Id of store's owner"
  end

  post do
    store = Store.create!(permitted_params)
    represent store, with: StoreRepresenter
  end

  params do
    requires :id, desc: 'ID of the store'
  end
  route_param :id do
    desc 'Get a store'
    get do
      store = Store.find(params[:id])
      represent store, with: StoreRepresenter
    end

    desc 'Get store visits by descending order'
    get :visits do
      Store.find(params[:id]).visits.order(created_at: :desc)
    end

    desc 'Get list of visitors'
    get :customers do
      Store.find(params[:id]).array_of_customers
    end

    desc 'Get customers and visits per customer'
    get :metrics do
      Store.find(params[:id]).customer_breakdown
    end

    desc 'Update a store'
    params do
      optional :name, type: String, desc: "Name of store"
      optional :address, type: String, desc: "Address of store"
      optional :latitude, type: Float, desc: "Latitude of address provided"
      optional :longitude, type: Float, desc: "Longitude of address provided"
      optional :daily_code, type: String, desc: "Daily code for store"
      optional :owner_id, type: Integer, desc: "Id of store's owner"
    end
    put do
      # fetch store record and update attributes.  exceptions caught in app.rb
      store = Store.find(params[:id])
      store.update_attributes!(permitted_params)
      represent store, with: StoreRepresenter
    end
  end
end
