Sks.Router.map ->
  this.resource 'users', path: '/users'
  this.resource 'user', path: '/users/:user_id'