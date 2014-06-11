Unit.define('fuel') do |u|
  u.definition = Unit('1 l') / Unit('100 km')
end

Unit.define('fuel-us') do |u|
  u.definition = Unit('1 gallon') / Unit('1 mile')
end

Unit.define('fuel-uk') do |u|
  u.definition = Unit('454609/100000 l') / Unit('1 mile')
end

Unit.define('horsepower-eu') do |u|
  u.definition   = Unit('735.49875 watt')
  u.aliases      = %w{hp-eu horsepower-eu}
end
