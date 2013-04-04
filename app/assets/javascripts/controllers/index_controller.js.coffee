Sks.IndexController = Ember.Controller.extend
  needs: ['currentUser', 'users', 'kudo', 'top']

  signOut: ->
    self = this
    token = $('meta[name="csrf-token"]').attr('content')
    jQuery.post("/sessions", _method: 'delete', id: 'fake', authenticity_token: token)