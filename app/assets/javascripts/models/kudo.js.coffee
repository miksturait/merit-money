Sks.Kudo = DS.Model.extend
  receiver: DS.belongsTo 'Sks.User'
  receiver_id: DS.attr 'number'
  value: DS.attr 'number'
  comment: DS.attr 'string'