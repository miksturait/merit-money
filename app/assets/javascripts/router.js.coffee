Sks.Router.map ->
  this.resource 'users'
  this.resource 'user', path: '/users/:user_id'