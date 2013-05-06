sksHelpers = do ->
  addKudo: ->
    $('li.coworker:first a:first').click()

  goToDetailedPage: ->
    $('li.coworker:first a:last').click()

  addKudoWithAComment: ->
    @goToDetailedPage()
    @fillInForm()
    $('a.btn').click()

  fillInForm: ->
    $form = $ 'form'
    $select = $form.find '#kudos-add'
    $comment = $form.find '#kudos-comment'

    # add 5 kudos
    $select.find('option:last').attr('selected', true)

    # add comment
    $comment.val 'my comment'

window.sksHelpers = sksHelpers
