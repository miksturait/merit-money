Sks.KudoReceived = DS.Model.extend
	user: DS.belongsTo 'Sks.User'
	comments: DS.hasMany 'Sks.Comment'
	num: DS.attr 'number'