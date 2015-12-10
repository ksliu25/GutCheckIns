require 'spec_helper'

def app
  ApplicationApi
end

describe UsersApi do
  include Rack::Test::Methods

  describe 'e.g. GET, POST, PUT, etc.' do
    it 'needs tests to be written!' do
      pending('write tests for UsersApi!')
    end
  end

end
