![logo](resources/GutCheckins.png)
# Welcome to GutCheckIns!
GutCheckins is a loyalty rewards webapp that allows a user to "check-in" to an establishment when they visit.
This specific repo is in regards to the backend of the app which was built using Napa and is hosted on heroku at gutcheckins.herokuapp.com

## Testing / Local hosting

After pulling down and bundling, simply run
<pre><code>
be rspec spec
</pre></code>
to ensure all the tests are properly running and passing.

## Security
There are 2 main validations for a visit creation, including the "near_location" boolean that ideally will check on the client side if the user is within the required distance to the store (hence why address, latitude, and longitude is provided) along with a "check_in_code" code that is checked alongside the store's "daily_code" to ensure the customer is present at that location.

Further, the password field on the users table isn't quite needed at this moment since there is no authorization happening, options are being explored in:
- Add corresponding password field to POST /stores in order to create a store? (Even then, to what end? Why abuse the creation of stores if there are no rewards set by the owner?)
- Implement some sort of token-auth such as Grape Token Auth
- Use Grape's authentication that is suggested in their 'authentication' section

## Usage and API Endpoints

### Create a user - POST /users

passwords are hashed through BCrypt into the database.

<pre><code>
curl -X POST -d username="ksliu25" -d password="password" http://gutcheckins.herokuapp.com/users
</pre></code>

<pre><code>
{
  "data": {
    "object_type": "user",
    "id": "1",
    "username": "ksliu25"
  }
}
</pre></code>

### Creating a store owned by a user - POST /stores

<pre><code>
curl -X POST -d name="DBC Burgers" -d address="351 W Hubbard, Chicago, IL 60654, USA" -d latitude=41.8897170 -d longitude=-87.6376110 -d daily_code="DBCRocks" -d owner_id=1 http://gutcheckins.herokuapp.com/users
</pre></code>

<pre><code>
{
  "data": {
    "object_type": "store",
    "id": "1",
    "name": "DBC Burgers",
    "daily_code": "DBCRocks",
    "owner_id": 1
  }
}
</pre></code>

### Creating a Visit at the store with a user - POST /visits

<pre><code>
curl -X POST -d store_id=1 -d customer_id=1 -d near_location=true -d check_in_code="DBCRocks" http://gutcheckins.herokuapp.com
</pre></code>

<pre><code>
{
  "data": {
    "object_type": "visit",
    "id": "1",
    "store_id": "1",
    "customer_id": "1",
    "check_in_code": "DBCRocks"
  }
}
</pre></code>

##Metrics

###Obtain a user's store breakdown - GET /users/:id/metrics

<pre><code>
curl GET "http://gutcheckins.herokuapp.com/users/1/metrics"
</pre></code>

<pre><code>
{
  "DBC Burgers": 1
}
</pre></code>

###Obtain all the stores a user has visited - GET /users/:id/stores
<pre><code>
curl GET "http://gutcheckins.herokuapp.com/users/1/stores"
</pre></code>

<pre><code>
["DBC Burgers"]
</pre></code>

###Obtain all visits in ascending order from user - GET /users/:id/visits
<pre><code>
curl GET "http://gutcheckins.herokuapp.com/users/1/visits"
</pre></code>

<pre><code>
[{"id":1,"store_id":1,"customer_id":1,"near_location":true,"check_in_code":"DBCRocks","created_at":"2015-12-13T04:02:33Z","updated_at":"2015-12-13T04:02:33Z"}]
</pre></code>

## Below are corresponding endpoints to stores
<pre><code>
curl GET "http://gutcheckins.herokuapp.com/stores/1/visits"
curl GET "http://gutcheckins.herokuapp.com/stores/1/customers"
curl GET "http://gutcheckins.herokuapp.com/stores/1/metrics"
</pre></code>



