# encoding: utf-8
class CreateAllowedUsers < ActiveRecord::Migration

  def migrate(direction)
    super
    if direction == :up
      users_raw = "Tomasz Bąk <t.bak@selleo.com>, Tomasz Borowski <t.borowski@selleo.com>, Rafał Bromirski <rafal.bromirski@gmail.com>, Tomasz Czana <tomasz.czana@gmail.com>, Michał Czyż <michalczyz@gmail.com>, Bartlomiej Danek <bartek.danek@gmail.com>, Sebastian Ewak <sebastian.ewak@gmail.com>, Arek Janik <arek.mp@gmail.com>, Radosław Jędryszczak <socjopata@gmail.com>, Szymon Kieloch <skieloch@gmail.com>, Blazej Kosmowski <blazejek@gmail.com>, Arkadiusz Kwaśny <arkadiusz.kwasny@gmail.com>, Tomasz Noworyta <tomasz.noworyta@gmail.com>, Adrian Osowski <aossowski@gmail.com>, Grzegorz Rduch <grduch@gmail.com>, Ireneusz Skrobis <irek.skrobis@gmail.com>, Bartłomiej Wójtowicz <wojtowicz.bartlomiej@gmail.com>, Wojciech Ryrych <wojtek.ryrych@gmail.com>, Dariusz Wylon <pract.pl@gmail.com>"
      users_raw.split(', ').each do |user_info|
        name, email = *user_info.split(' <')
        ::AllowedUser.create(name: name, email: email.gsub('>', ''))
      end
    end
  end

  def change
    create_table :allowed_users do |t|
      t.string :name
      t.string :email

      t.timestamps
    end
  end
end
