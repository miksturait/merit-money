Sks.UserInUsersView = Em.View.extend
  templateName: 'user_in_users'
  classNames: 'content'

  didInsertElement: ->
    # todo - init only once per element
    $('.stars').raty
      path: 'assets/raty'
      size: 54
      score: 1
      hints: ['', '', '', '', '']
