# encoding: utf-8
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
# Environment variables (ENV['...']) are set in the file config/application.yml.
# See http://railsapps.github.com/rails-environment-variables.html
unless Rails.env.production?
  ::AllowedUser.delete_all
  ::User.delete_all
  ::Kudo.delete_all
  ::Week.delete_all
  ::Fusion.delete_all
  ::WeeklyKudo.delete_all
end

users_raw = "Bartek Bąk <bartek.bak@mikstura.it>, Witek Borowski <witek.borowski@mikstura.it>, Rafał Kwaśny <rafal.kwasny@mikstura.it>, Marek Czana <marek.czana@mikstura.it>, Michał Kos <michal.kos@mikstura.it>, Tomek Dyś <tomek.dys@mikstura.it>, Sebastian Onet <sebastian.onet@mikstura.it>, Arek Piotr <arek.piotr@mikstura.it>"
users_raw.split(', ').each do |user_info|
  name, email = *user_info.split(' <')
  ::AllowedUser.create(name: name, email: email.gsub('>', ''))
end

if Rails.env.development?
  AllowedUser.all.each do |au|
    User.create(name: au.name, email: au.email)
  end

  last_sunday = DateTime.now.beginning_of_week - 1.day

  require 'factory_girl'
  require 'timecop'
  require 'pry'

  tom = User.where(email: 'tomek.dys@mikstura.it').first
  bart = User.where(email: 'bartek.bak@mikstura.it').first
  simon = User.where(email: 'witek.borowski@mikstura.it').first
  darek = User.where(email: 'marek.czana@mikstura.it').first
  wojtek = User.where(email: 'arek.piotr@mikstura.it').first

  Timecop.freeze(last_sunday - 8.days)

  tom.thanks_to_user(darek, {value: 3, comment: 'za pomoc przy setupowaniu środowiska do testowania embera'})
  tom.thanks_to_user(darek, {value: 2, comment: 'za modyfikacja na yougame :-)'})
  tom.thanks_to_user(darek, {value: 1, comment: 'Za widoczne postępy, używanie wzorców projektowych etc.'})
  simon.thanks_to_user(darek, {value: 5, comment: 'za ogrom roboty wykonanej/wykonywanej w sprzedaży : w tym w szczególności, za własne due dilligence prospectów/firm, telecons, analiza dużej ilości requirements / specs docs, myślenie z perspektywy klienta, dokładne, rozbudowane odpowiedzi w mejlach / proposale z dobrymi, wartościowymi dla klienta komentarzami i pytaniami, wskazujące na autentyczne zainteresowanie klientem z naszej strony'})
  simon.thanks_to_user(darek, {value: 1, comment: 'Zabranie głosu w dyskusji o rozdawaniu kudo (i angażowanie się w sprawy firmy)'})

  simon.thanks_to_user(tom, {value: 1, comment: 'za praktyczne wykorzystanie wiedzy o wzorcach programowania'})
  tom.thanks_to_user(darek, {value: 1})

  simon.thanks_to_user(darek, {value: 1})
  bart.thanks_to_user(darek, {value: 1})


  darek.current_weekly_kudo
  tom.current_weekly_kudo

  Timecop.freeze(last_sunday)

  simon.thanks_to_user(darek, {value: 8})
  tom.thanks_to_user(darek, {value: 2, comment: 'za udaną sprzedaż FPS'})
  tom.thanks_to_user(darek, {value: 1})
  simon.thanks_to_user(darek, {value: 5})
  simon.thanks_to_user(darek, {value: 1, comment: 'za wspólną walkę o lepsze Selleo'})

  simon.thanks_to_user(tom, {value: 1, comment: 'for pushing metreno forwards'})
  bart.thanks_to_user(darek, {value: 1})

  simon.thanks_to_user(darek, {value: 1})
  simon.thanks_to_user(wojtek, {value: 3, comment: 'za sks app'})

  User.where(["id != ?", darek.id]).all.each do |u|
    darek.thanks_to_user(u, {value: 1, comment: 'za pomoc przy marketingu'})
  end

  darek.current_weekly_kudo
  tom.current_weekly_kudo
  Timecop.return
end
