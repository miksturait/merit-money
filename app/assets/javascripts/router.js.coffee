Sks.Router.map ->
  @resource 'users', path: '/users'
  @resource 'user', path: '/users/:user_id'
  @resource 'comments'