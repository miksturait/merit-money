App.GravatarImageComponent = Ember.Component.extend
  gravatarUrl: (->
    email = @get 'email'
    "http://www.gravatar.com/avatar/#{MD5(@get 'email')}" if email?
  ).property('email')