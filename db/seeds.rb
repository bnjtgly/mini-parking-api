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
parking_slot_type1 = SubEntity.create(sort_order: '100', entity_id: parking_slot.id, display: 'Small', value_str: 'small')
parking_slot_type2 = SubEntity.create(sort_order: '200', entity_id: parking_slot.id, display: 'Medium', value_str: 'medium')
parking_slot_type3 = SubEntity.create(sort_order: '300', entity_id: parking_slot.id, display: 'Large', value_str: 'large')

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

parking_slot_s = ParkingSlot.create(parking_complex_id: parking_complex1.id, name: 'SP-1', parking_slot_type_id: parking_slot_type1.id, price: 20.0,
                                    entry_point_distance: {
                                      north: 10,
                                      east: 20,
                                      west: 30
                                    })
parking_slot_m = ParkingSlot.create(parking_complex_id: parking_complex1.id, name: 'MP-1', parking_slot_type_id: parking_slot_type2.id, price: 60.0,
                                    entry_point_distance: {
                                      north: 10,
                                      east: 20,
                                      west: 30
                                    })
parking_slot_l = ParkingSlot.create(parking_complex_id: parking_complex1.id, name: 'LP-1', parking_slot_type_id: parking_slot_type3.id, price: 100.0,
                                    entry_point_distance: {
                                      north: 10,
                                      east: 20,
                                      west: 30
                                    })

customer = Customer.create(vehicle_type_id: vehicle_type1.id, complete_name: 'Adam Smith', plate_number: 'APL-1207')

customer_parking = CustomerParking.create(customer_id: customer.id, parking_slot_id: parking_slot_l.id, parking_status_id: parking_status1.id)