Sks.CurrentUserController = Ember.ObjectController.extend
  disableAddingKudos: false
  decrementKudos: (num) ->
    @decrementProperty('kudosLeft', num)