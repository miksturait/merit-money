Sks.Router.map ->
  this.resource 'users', ->
  	this.resource 'user', path: ':user_id'