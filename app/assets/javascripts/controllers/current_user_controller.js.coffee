Sks.CurrentUserController = Ember.ObjectController.extend
  decrementKudos: (num) ->
    @decrementProperty('kudosLeft', num)