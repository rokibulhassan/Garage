# The light representation of a vehicle. The goal is to embed it
# in order to provide basic informations to show while the complete
# version is loaded.

json.id     vehicle.id
json.userId vehicle.user_id

json.label  vehicle.label
json.type   vehicle.vehicle_type
json.keywords vehicle.keywords

json.partial!('vehicles/vehicle_urls', vehicle: vehicle)
json.partial!('vehicles/vehicle_avatars', vehicle: vehicle)
