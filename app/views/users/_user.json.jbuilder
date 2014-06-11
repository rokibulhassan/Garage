json.id       user.id
json.username user.username

json.country_code user.country_code
json.countryName  user.country

json.locale               user.locale
json.currency             user.currency
json.system_of_units_code user.system_of_units_code

json.avatarUrl   user.avatar? && user.avatar.url(:normal)
json.gravatarUrl user.gravatar_url
json.avatar_url  user.avatar_url

json.first_name_public user.first_name_public
json.last_name_public  user.last_name_public
json.emailing_allowed  user.emailing_allowed
json.city_public       user.city_public
json.pictures_count    user.pictures_count
json.modifications_count    user.modifications.count

if can? :manage, user
  json.city        user.city
  json.first_name  user.first_name
  json.last_name   user.last_name

  json.email    user.email

  json.facebookId user.facebook_id

  json.comparisonTables user.comparison_tables.recent do |json, comparison_table|
    json.id    comparison_table.id
    json.label comparison_table.label
  end
else
  json.city        user.city_public ? user.city : nil
  json.first_name  user.first_name_public ? user.first_name : nil
  json.last_name   user.last_name_public ? user.last_name : nil
end
