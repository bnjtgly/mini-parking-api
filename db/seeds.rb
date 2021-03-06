# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
api_client_admin = ApiClient.create(name: 'Mini Parking Admin')
api_client_web = ApiClient.create(name: 'Mini Parking Web')

role_admin = Role.create(role_name: 'SUPERADMIN', role_def: 'Mini Park administrator.')
role_user = Role.create(role_name: 'USER', role_def: 'Mini Park user.')

api_client_admin.update(api_key: '99ffe86f-ef93-4a12-be45-9e8c715e042a', secret_key: 'Ik4eHjqUivF-SqcUJdDUlQ')
api_client_web.update(api_key: '295d1181-d22f-4e3c-b3e7-06a0d2e2e2e7', secret_key: '86M0tiX9jF_CsN-s5xdGMA')

admin = User.create(email: 'superadmin@ayalacorp.com', password: '@Test123', first_name: 'Domingo', last_name: 'Roxas', api_client_id: api_client_admin.id)
user = User.create(email: 'johnsmith@email.com', password: 'Abc!23', first_name: 'John', last_name: 'Smith', api_client_id: api_client_web.id)

UserRole.create(user_id: admin.id, role_id: role_admin.id)
UserRole.create(user_id: user.id, role_id: role_user.id)

# Entities and Sub Entities
parking_slot = Entity.create(entity_number: 1001, entity_name: 'Parking Slot Type', entity_def: 'Type of parking slot.')
parking_slot_type1 = SubEntity.create(sort_order: '100', entity_id: parking_slot.id, display: 'Small', value_str: 'small', metadata: { price: 20.0 })
parking_slot_type2 = SubEntity.create(sort_order: '200', entity_id: parking_slot.id, display: 'Medium', value_str: 'medium', metadata: { price: 60.0 })
parking_slot_type3 = SubEntity.create(sort_order: '300', entity_id: parking_slot.id, display: 'Large', value_str: 'large', metadata: { price: 100.0 })

vehicle = Entity.create(entity_number: 1101, entity_name: 'Vehicle Type', entity_def: 'Type of vehicle.')
vehicle_type1 = SubEntity.create(sort_order: '100', entity_id: vehicle.id, display: 'Small', value_str: 'small')
vehicle_type2 = SubEntity.create(sort_order: '200', entity_id: vehicle.id, display: 'Medium', value_str: 'medium')
vehicle_type3 = SubEntity.create(sort_order: '300', entity_id: vehicle.id, display: 'Large', value_str: 'large')

parking_slot_status = Entity.create(entity_number: 1201, entity_name: 'Parking Slot Status', entity_def: 'Status of transaction')
parking_slot_status1 = SubEntity.create(sort_order: '100', entity_id: parking_slot_status.id, display: 'Available', value_str: 'available')
parking_slot_status2 = SubEntity.create(sort_order: '200', entity_id: parking_slot_status.id, display: 'Not Available', value_str: 'not available')

parking_status = Entity.create(entity_number: 1301, entity_name: 'Parking Status', entity_def: 'Status of transaction')
parking_status1 = SubEntity.create(sort_order: '100', entity_id: parking_status.id, display: 'Parked', value_str: 'parked')
parking_status2 = SubEntity.create(sort_order: '200', entity_id: parking_status.id, display: 'Unparked', value_str: 'unparked')

transaction_status = Entity.create(entity_number: 1401, entity_name: 'Transaction Status', entity_def: 'Status of transaction')
transaction_status1 = SubEntity.create(sort_order: '100', entity_id: transaction_status.id, display: 'Pending', value_str: 'pending')
transaction_status2 = SubEntity.create(sort_order: '200', entity_id: transaction_status.id, display: 'Settled', value_str: 'settled')

# Sample Data
parking_complex1 = ParkingComplex.create(name: 'Basement')
parking_complex2 = ParkingComplex.create(name: 'Roofdeck')

entry_point1 = EntryPoint.create(parking_complex_id: parking_complex1.id, name: 'north')
entry_point2 = EntryPoint.create(parking_complex_id: parking_complex1.id, name: 'east')
entry_point3 = EntryPoint.create(parking_complex_id: parking_complex1.id, name: 'west')

parking_slot_s = ParkingSlot.create(parking_complex_id: parking_complex1.id, name: 'SP-1', parking_slot_type_id: parking_slot_type1.id, parking_slot_status_id: parking_slot_status1.id)
parking_slot_m = ParkingSlot.create(parking_complex_id: parking_complex1.id, name: 'MP-1', parking_slot_type_id: parking_slot_type2.id, parking_slot_status_id: parking_slot_status1.id)
parking_slot_l = ParkingSlot.create(parking_complex_id: parking_complex1.id, name: 'LP-1', parking_slot_type_id: parking_slot_type3.id, parking_slot_status_id: parking_slot_status1.id)

parking_slot_s2 = ParkingSlot.create(parking_complex_id: parking_complex1.id, name: 'SP-2', parking_slot_type_id: parking_slot_type1.id, parking_slot_status_id: parking_slot_status1.id)
parking_slot_m2 = ParkingSlot.create(parking_complex_id: parking_complex1.id, name: 'MP-2', parking_slot_type_id: parking_slot_type2.id, parking_slot_status_id: parking_slot_status1.id)
parking_slot_l2 = ParkingSlot.create(parking_complex_id: parking_complex1.id, name: 'LP-2', parking_slot_type_id: parking_slot_type3.id, parking_slot_status_id: parking_slot_status1.id)

parking_slot_s3 = ParkingSlot.create(parking_complex_id: parking_complex1.id, name: 'SP-3', parking_slot_type_id: parking_slot_type1.id, parking_slot_status_id: parking_slot_status1.id)
parking_slot_m3 = ParkingSlot.create(parking_complex_id: parking_complex1.id, name: 'MP-3', parking_slot_type_id: parking_slot_type2.id, parking_slot_status_id: parking_slot_status1.id)
parking_slot_l3 = ParkingSlot.create(parking_complex_id: parking_complex1.id, name: 'LP-3', parking_slot_type_id: parking_slot_type3.id, parking_slot_status_id: parking_slot_status1.id)

# SlotEntrypoint.create(entry_point_id: entry_point1.id, parking_slot_id: parking_slot_s.id, distance: 1.0)
# SlotEntrypoint.create(entry_point_id: entry_point2.id, parking_slot_id: parking_slot_s.id, distance: 2.0)
# SlotEntrypoint.create(entry_point_id: entry_point3.id, parking_slot_id: parking_slot_s.id, distance: 3.0)
#
# SlotEntrypoint.create(entry_point_id: entry_point1.id, parking_slot_id: parking_slot_m.id, distance: 1.0)
# SlotEntrypoint.create(entry_point_id: entry_point2.id, parking_slot_id: parking_slot_m.id, distance: 2.0)
# SlotEntrypoint.create(entry_point_id: entry_point3.id, parking_slot_id: parking_slot_m.id, distance: 3.0)
#
# SlotEntrypoint.create(entry_point_id: entry_point1.id, parking_slot_id: parking_slot_l.id, distance: 1.0)
# SlotEntrypoint.create(entry_point_id: entry_point2.id, parking_slot_id: parking_slot_l.id, distance: 2.0)
# SlotEntrypoint.create(entry_point_id: entry_point3.id, parking_slot_id: parking_slot_l.id, distance: 3.0)
#
#
# SlotEntrypoint.create(entry_point_id: entry_point1.id, parking_slot_id: parking_slot_s2.id, distance: 1.2)
# SlotEntrypoint.create(entry_point_id: entry_point2.id, parking_slot_id: parking_slot_s2.id, distance: 2.2)
# SlotEntrypoint.create(entry_point_id: entry_point3.id, parking_slot_id: parking_slot_s2.id, distance: 3.2)
#
# SlotEntrypoint.create(entry_point_id: entry_point1.id, parking_slot_id: parking_slot_m2.id, distance: 1.2)
# SlotEntrypoint.create(entry_point_id: entry_point2.id, parking_slot_id: parking_slot_m2.id, distance: 2.2)
# SlotEntrypoint.create(entry_point_id: entry_point3.id, parking_slot_id: parking_slot_m2.id, distance: 3.2)
#
# SlotEntrypoint.create(entry_point_id: entry_point1.id, parking_slot_id: parking_slot_l2.id, distance: 1.2)
# SlotEntrypoint.create(entry_point_id: entry_point2.id, parking_slot_id: parking_slot_l2.id, distance: 2.2)
# SlotEntrypoint.create(entry_point_id: entry_point3.id, parking_slot_id: parking_slot_l2.id, distance: 3.2)
#
#
# SlotEntrypoint.create(entry_point_id: entry_point1.id, parking_slot_id: parking_slot_s3.id, distance: 1.3)
# SlotEntrypoint.create(entry_point_id: entry_point2.id, parking_slot_id: parking_slot_s3.id, distance: 2.3)
# SlotEntrypoint.create(entry_point_id: entry_point3.id, parking_slot_id: parking_slot_s3.id, distance: 3.3)
#
# SlotEntrypoint.create(entry_point_id: entry_point1.id, parking_slot_id: parking_slot_m3.id, distance: 1.3)
# SlotEntrypoint.create(entry_point_id: entry_point2.id, parking_slot_id: parking_slot_m3.id, distance: 2.3)
# SlotEntrypoint.create(entry_point_id: entry_point3.id, parking_slot_id: parking_slot_m3.id, distance: 3.3)
#
# SlotEntrypoint.create(entry_point_id: entry_point1.id, parking_slot_id: parking_slot_l3.id, distance: 1.3)
# SlotEntrypoint.create(entry_point_id: entry_point2.id, parking_slot_id: parking_slot_l3.id, distance: 2.3)
# SlotEntrypoint.create(entry_point_id: entry_point3.id, parking_slot_id: parking_slot_l3.id, distance: 3.3)
#
#



SlotEntrypoint.create(entry_point_id: entry_point1.id, parking_slot_id: parking_slot_s.id, distance: 1.0)
SlotEntrypoint.create(entry_point_id: entry_point1.id, parking_slot_id: parking_slot_s2.id, distance: 2.0)
SlotEntrypoint.create(entry_point_id: entry_point1.id, parking_slot_id: parking_slot_s3.id, distance: 3.0)

SlotEntrypoint.create(entry_point_id: entry_point2.id, parking_slot_id: parking_slot_s.id, distance: 2.0)
SlotEntrypoint.create(entry_point_id: entry_point2.id, parking_slot_id: parking_slot_s2.id, distance: 1.0)
SlotEntrypoint.create(entry_point_id: entry_point2.id, parking_slot_id: parking_slot_s3.id, distance: 3.0)

SlotEntrypoint.create(entry_point_id: entry_point3.id, parking_slot_id: parking_slot_s.id, distance: 3.0)
SlotEntrypoint.create(entry_point_id: entry_point3.id, parking_slot_id: parking_slot_s2.id, distance: 2.0)
SlotEntrypoint.create(entry_point_id: entry_point3.id, parking_slot_id: parking_slot_s3.id, distance: 1.0)


SlotEntrypoint.create(entry_point_id: entry_point1.id, parking_slot_id: parking_slot_m.id, distance: 1.1)
SlotEntrypoint.create(entry_point_id: entry_point1.id, parking_slot_id: parking_slot_m2.id, distance: 2.1)
SlotEntrypoint.create(entry_point_id: entry_point1.id, parking_slot_id: parking_slot_m3.id, distance: 3.1)

SlotEntrypoint.create(entry_point_id: entry_point2.id, parking_slot_id: parking_slot_m.id, distance: 2.1)
SlotEntrypoint.create(entry_point_id: entry_point2.id, parking_slot_id: parking_slot_m2.id, distance: 1.1)
SlotEntrypoint.create(entry_point_id: entry_point2.id, parking_slot_id: parking_slot_m3.id, distance: 3.1)

SlotEntrypoint.create(entry_point_id: entry_point3.id, parking_slot_id: parking_slot_m.id, distance: 3.1)
SlotEntrypoint.create(entry_point_id: entry_point3.id, parking_slot_id: parking_slot_m2.id, distance: 2.1)
SlotEntrypoint.create(entry_point_id: entry_point3.id, parking_slot_id: parking_slot_m3.id, distance: 1.1)


SlotEntrypoint.create(entry_point_id: entry_point1.id, parking_slot_id: parking_slot_l.id, distance: 1.23)
SlotEntrypoint.create(entry_point_id: entry_point1.id, parking_slot_id: parking_slot_l2.id, distance: 2.42)
SlotEntrypoint.create(entry_point_id: entry_point1.id, parking_slot_id: parking_slot_l3.id, distance: 3.12)

SlotEntrypoint.create(entry_point_id: entry_point2.id, parking_slot_id: parking_slot_l.id, distance: 2.43)
SlotEntrypoint.create(entry_point_id: entry_point2.id, parking_slot_id: parking_slot_l2.id, distance: 1.42)
SlotEntrypoint.create(entry_point_id: entry_point2.id, parking_slot_id: parking_slot_l3.id, distance: 3.75)

SlotEntrypoint.create(entry_point_id: entry_point3.id, parking_slot_id: parking_slot_l.id, distance: 3.23)
SlotEntrypoint.create(entry_point_id: entry_point3.id, parking_slot_id: parking_slot_l2.id, distance: 2.79)
SlotEntrypoint.create(entry_point_id: entry_point3.id, parking_slot_id: parking_slot_l3.id, distance: 1.02)













customer = Customer.create(vehicle_type_id: vehicle_type3.id, complete_name: 'Adam Smith', plate_number: 'APL-1207')
Customer.create(vehicle_type_id: vehicle_type2.id, complete_name: 'Eva Hong', plate_number: 'EVH-0165')