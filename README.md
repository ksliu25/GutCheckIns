![logo](resources/GutCheckins.png)
# Welcome to GutCheckIns!
GutCheckins is a loyalty rewards webapp that allows a user to "check-in" to an establishment when they visit.
This specific repo is in regards to the backend of the app which was built using Napa.

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

## Getting all users - GET /users

<pre><code>
curl GET "http://gutcheckins.herokuapp.com/users"
</pre></code>

<pre><code>
{
  "data": [{
    "object_type": "user",
    "id": "1",
    "username": "ksliu25"
  }]
}
</pre></code>

## Getting one user - GET /users/:user_id

<pre><code>
curl GET "http://gutcheckins.herokuapp.com/users/1"
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
