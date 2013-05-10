Sks.Comment = DS.Model.extend
  value: DS.attr 'number'
  comment: DS.attr 'string'

Sks.Comment.FIXTURES = [
  id: 1
  value: 3
  comment: 'You gave me a helping hand yesterday!'
,
  id: 2
  value: 2
  comment: 'It was awesome!'
,
  id: 3
  value: 1
  comment: 'for no reason!'
,
  id: 4
  value: 5
  comment: 'Unbelievable!'
,
  id: 5
  value: 1
  comment: 'cool'
,
  id: 6
  value: 1
  comment: 'uh-oh'
,
  id: 7
  value: 3
  comment: 'super-duper!'
,
  id: 8
  value: 2
  comment: 'Because you are nice to me!'
,
  id: 9
  value: 2
  comment: 'you did amazing job'
,
  id: 10
  value: 4
  comment: 'Keep it up, dude!'
]