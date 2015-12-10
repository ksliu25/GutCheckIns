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
    optional :name, type: String, desc: "Name of store"
    optional :address, type: String, desc: "Address of store"
    optional :latitude, type: Float, desc: "Latitude of address provided"
    optional :longitude, type: Float, desc: "Longitude of address provided"
    optional :daily_code, type: String, desc: "Daily code for store"
    optional :owner_id, type: Integer, desc: "Id of store's owner"
  end

  post do
    store = Store.create!(permitted_params)
    represent store, with: StoreRepresenter
  end

  params do
    requires :id, desc: 'ID of the store'
  end
  route_param :id do
    desc 'Get an store'
    get do
      store = Store.find(params[:id])
      represent store, with: StoreRepresenter
    end

    desc 'Update an store'
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
