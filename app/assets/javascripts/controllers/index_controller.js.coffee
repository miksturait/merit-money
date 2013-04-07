Sks.IndexController = Ember.Controller.extend
  signOut: ->
    self = this
    token = $('meta[name="csrf-token"]').attr('content')
    jQuery.post("/sessions", _method: 'delete', id: 'fake', authenticity_token: token)