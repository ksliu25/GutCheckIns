class VisitRepresenter < Napa::Representer
  property :id, type: String
  property :store_id, type: Integer
  property :customer_id, type: Integer
  property :check_in_code, type: String
end
