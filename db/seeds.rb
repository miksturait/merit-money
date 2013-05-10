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

users_raw = "Tomasz Bąk <t.bak@selleo.com>, Tomasz Borowski <t.borowski@selleo.com>, Rafał Bromirski <rafal.bromirski@gmail.com>, Tomasz Czana <tomasz.czana@gmail.com>, Michał Czyż <michalczyz@gmail.com>, Bartlomiej Danek <bartek.danek@gmail.com>, Sebastian Ewak <sebastian.ewak@gmail.com>, Arek Janik <arek.mp@gmail.com>, Radosław Jędryszczak <socjopata@gmail.com>, Szymon Kieloch <skieloch@gmail.com>, Blazej Kosmowski <blazejek@gmail.com>, Arkadiusz Kwaśny <arkadiusz.kwasny@gmail.com>, Tomasz Noworyta <tomasz.noworyta@gmail.com>, Adrian Osowski <aossowski@gmail.com>, Grzegorz Rduch <grduch@gmail.com>, Ireneusz Skrobis <irek.skrobis@gmail.com>, Bartłomiej Wójtowicz <wojtowicz.bartlomiej@gmail.com>, Wojciech Ryrych <wojtek.ryrych@gmail.com>, Dariusz Wylon <pract.pl@gmail.com>"
users_raw.split(', ').each do |user_info|
  name, email = *user_info.split(' <')
  ::AllowedUser.create(name: name, email: email.gsub('>', ''))
end

if Rails.env.development?
  AllowedUser.all.each do |au|
    #unless %w(michalczyz@gmail.com wojtek.ryrych@gmail.com).include?(au.email)
      User.create(name: au.name, email: au.email)
    #end
  end
end
