App.GravatarImageComponent = Ember.Component.extend
  gravatarUrl: (->
    "http://www.gravatar.com/avatar/#{MD5(@get 'email')}"
  ).property('email')