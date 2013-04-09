Sks.Comment = DS.Model.extend
	kudosReceived: DS.belongsTo 'Sks.KudoReceived'
	body: DS.attr 'string'