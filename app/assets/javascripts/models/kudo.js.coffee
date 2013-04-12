Sks.Kudo = DS.Model.extend
  user: DS.belongsTo 'Sks.User'
  receiver_id: DS.attr 'number'
  value: DS.attr 'number'
  comment: DS.attr 'string'