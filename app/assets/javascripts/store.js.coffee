Sks.Store = DS.Store.extend
    revision: 12
    adapter: 'DS.RESTAdapter'

#Sks.Store.registerAdapter 'Sks.User', DS.FixtureAdapter
#Sks.Store.registerAdapter 'Sks.CurrentUser', DS.FixtureAdapter
Sks.Store.registerAdapter 'Sks.Hamster', DS.FixtureAdapter
Sks.Store.registerAdapter 'Sks.Top', DS.FixtureAdapter
Sks.Store.registerAdapter 'Sks.KudoReceived', DS.FixtureAdapter
Sks.Store.registerAdapter 'Sks.KudoLastWeek', DS.FixtureAdapter
Sks.Store.registerAdapter 'Sks.Comment', DS.FixtureAdapter