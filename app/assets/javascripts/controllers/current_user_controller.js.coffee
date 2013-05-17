Sks.CurrentUserController = Ember.ObjectController.extend
  needs: ['application']
  disableAddingKudos: false
  decrementKudos: (num) ->
    @decrementProperty('kudosLeft', num)