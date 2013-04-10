Sks.CurrentUserView = Ember.View.extend
  elementId: 'dashboard'
  classNames: ['row-fluid']
  
  didInsertElement: ->
    this.$('#flash').hide()