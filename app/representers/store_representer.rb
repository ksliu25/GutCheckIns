class StoreRepresenter < Napa::Representer
  property :id, type: String
  property :name, type: String
  property :daily_code, type: String
  property :owner_id, type: Integer

end
