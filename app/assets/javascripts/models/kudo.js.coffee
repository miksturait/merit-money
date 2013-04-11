Sks.Kudo = DS.Model.extend
  user: DS.belongsTo 'Sks.User'
  value: DS.attr 'number'
  comment: DS.attr 'string'