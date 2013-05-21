Sks.UserInUsersView = Em.View.extend
  tagName: 'li'
  templateName: 'user_in_users'
  classNames: 'coworker'
  attributeBindings: ['data-userid']
  'data-useridBinding': 'content.id'

