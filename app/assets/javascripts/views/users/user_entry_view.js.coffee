App.UserEntryView = Em.View.extend
  tagName: 'li'
  templateName: 'users/user_entry'
  classNames: 'coworker'
  attributeBindings: ['data-userid']
  'data-useridBinding': 'content.id'

  toggleRow: ->
    @get('controller').send 'toggleRow'

  addKudo: ->
    $view = @$()
    $contentMore = $view.find '.content-more'
    kudoNum = $contentMore.find('.stars').raty('score') or 1
    kudoComment = $contentMore.find('.kudos-comment').val()
    userId = @get 'content.id'
    @get('controller.controllers.application').send 'addKudo', userId, kudoNum, kudoComment



