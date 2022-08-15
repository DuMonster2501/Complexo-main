vRP.prepare("vRP/get_vrp_infos","SELECT * FROM vrp_infos WHERE steam = @steam")
vRP.prepare("vRP/get_characters","SELECT id,registration,phone,name,name2,bank FROM vrp_users WHERE steam = @steam and deleted = 0")
-----------------------------------------------------------------------------------------------------------------------------------------
-- PREPARE RACES
-----------------------------------------------------------------------------------------------------------------------------------------
vRP.prepare("vRP/get_winrace","SELECT user_id,raceid FROM vrp_races WHERE user_id = @user_id and raceid = @raceid")
vRP.prepare("vRP/update_winrace","UPDATE vrp_races SET vehicle = @vehicle, points = @points WHERE user_id = @user_id and raceid = @raceid")
vRP.prepare("vRP/insert_winrace","INSERT INTO vrp_races(user_id,vehicle,raceid,points) VALUES(@user_id,@vehicle,@raceid,@points)")
vRP.prepare("vRP/show_winrace","SELECT * FROM vrp_races WHERE raceid = @id ORDER BY points DESC LIMIT 13")
-----------------------------------------------------------------------------------------------------------------------------------------
-- PREPARE USERS
-----------------------------------------------------------------------------------------------------------------------------------------
vRP.prepare("vRP/get_vrp_users","SELECT * FROM vrp_users WHERE id = @id")
vRP.prepare("vRP/get_vrp_registration","SELECT id FROM vrp_users WHERE registration = @registration")
vRP.prepare("vRP/get_vrp_phone","SELECT id FROM vrp_users WHERE phone = @phone")
vRP.prepare("vRP/create_characters","INSERT INTO vrp_users(steam,name,name2) VALUES(@steam,@name,@name2)")
vRP.prepare("vRP/remove_characters","UPDATE vrp_users SET deleted = 1 WHERE id = @id")
vRP.prepare("vRP/update_characters","UPDATE vrp_users SET registration = @registration, phone = @phone WHERE id = @id")
vRP.prepare("vRP/rename_characters","UPDATE vrp_users SET name = @name, name2 = @name2 WHERE id = @id")
-----------------------------------------------------------------------------------------------------------------------------------------
-- PREPARE BANK
-----------------------------------------------------------------------------------------------------------------------------------------
vRP.prepare("vRP/set_bank","UPDATE vrp_users SET bank = @bank WHERE id = @id")
vRP.prepare("vRP/add_bank","UPDATE vrp_users SET bank = bank + @bank WHERE id = @id")
vRP.prepare("vRP/del_bank","UPDATE vrp_users SET bank = bank - @bank WHERE id = @id")
-----------------------------------------------------------------------------------------------------------------------------------------
-- PREPARE vRP_USERS
-----------------------------------------------------------------------------------------------------------------------------------------
vRP.prepare("vRP/create_user","INSERT INTO vrp_infos(steam) VALUES(@steam)")
vRP.prepare("vRP/set_banned","UPDATE vrp_infos SET banned = @banned WHERE steam = @steam")
vRP.prepare("vRP/set_whitelist","UPDATE vrp_infos SET whitelist = @whitelist WHERE steam = @steam")
-----------------------------------------------------------------------------------------------------------------------------------------
-- PREPARE vRP_USER_DATA
-----------------------------------------------------------------------------------------------------------------------------------------
vRP.prepare("vRP/set_userdata","REPLACE INTO vrp_user_data(user_id,dkey,dvalue) VALUES(@user_id,@key,@value)")
vRP.prepare("vRP/get_userdata","SELECT dvalue FROM vrp_user_data WHERE user_id = @user_id AND dkey = @key")
-----------------------------------------------------------------------------------------------------------------------------------------
-- PREPARE vRP_SRV_DATA
-----------------------------------------------------------------------------------------------------------------------------------------
vRP.prepare("vRP/set_srvdata","REPLACE INTO vrp_srv_data(dkey,dvalue) VALUES(@key,@value)")
vRP.prepare("vRP/get_srvdata","SELECT dvalue FROM vrp_srv_data WHERE dkey = @key")
-----------------------------------------------------------------------------------------------------------------------------------------
-- PREPARE vRP_PERMISSIONS
-----------------------------------------------------------------------------------------------------------------------------------------
vRP.prepare("vRP/get_perm","SELECT * FROM vrp_permissions WHERE user_id = @user_id")
vRP.prepare("vRP/get_group","SELECT * FROM vrp_permissions WHERE user_id = @user_id AND permiss = @permiss")
vRP.prepare("vRP/add_group","INSERT INTO vrp_permissions(user_id,permiss) VALUES(@user_id,@permiss)")
vRP.prepare("vRP/del_group","DELETE FROM vrp_permissions WHERE user_id = @user_id AND permiss = @permiss")
vRP.prepare("vRP/cle_group","DELETE FROM vrp_permissions WHERE user_id = @user_id")
vRP.prepare("vRP/upd_group","UPDATE vrp_permissions SET permiss = @newpermiss WHERE user_id = @user_id AND permiss = @permiss")
-----------------------------------------------------------------------------------------------------------------------------------------
-- PREPARE vRP_PRIORITY
-----------------------------------------------------------------------------------------------------------------------------------------
vRP.prepare("vRP/set_morechars","UPDATE vrp_infos SET chars = chars + 1 WHERE steam = @steam")
vRP.prepare("vRP/set_premium","UPDATE vrp_infos SET premium = @premium, predays = @predays, priority = @priority WHERE steam = @steam")
vRP.prepare("vRP/update_priority","UPDATE vrp_infos SET premium = 0, predays = 0, priority = 0 WHERE steam = @steam")
vRP.prepare("vRP/update_premium","UPDATE vrp_infos SET predays = predays + @predays WHERE steam = @steam")
-----------------------------------------------------------------------------------------------------------------------------------------
-- PREPARE vRP_HOMES
-----------------------------------------------------------------------------------------------------------------------------------------
vRP.prepare("vRP/get_homeuser","SELECT * FROM vrp_homes WHERE user_id = @user_id AND home = @home")
vRP.prepare("vRP/get_homeuserid","SELECT * FROM vrp_homes WHERE user_id = @user_id")
vRP.prepare("vRP/get_homeuserowner","SELECT * FROM vrp_homes WHERE user_id = @user_id AND home = @home AND owner = 1")
vRP.prepare("vRP/get_homeuseridowner","SELECT * FROM vrp_homes WHERE home = @home AND owner = 1")
vRP.prepare("vRP/get_homepermissions","SELECT * FROM vrp_homes WHERE home = @home")
vRP.prepare("vRP/add_permissions","INSERT IGNORE INTO vrp_homes(home,user_id) VALUES(@home,@user_id)")
vRP.prepare("vRP/buy_permissions","INSERT IGNORE INTO vrp_homes(home,user_id,owner,vault) VALUES(@home,@user_id,1,@vault)")
vRP.prepare("vRP/count_homepermissions","SELECT COUNT(*) as qtd FROM vrp_homes WHERE home = @home")
vRP.prepare("vRP/count_homes","SELECT COUNT(*) as qtd FROM vrp_homes WHERE user_id = @user_id")
vRP.prepare("vRP/rem_permissions","DELETE FROM vrp_homes WHERE home = @home AND user_id = @user_id")
vRP.prepare("vRP/rem_allpermissions","DELETE FROM vrp_homes WHERE home = @home")
vRP.prepare("vRP/upd_vaulthomes","UPDATE vrp_homes SET vault = vault + @vault WHERE home = @home AND owner = 1")
vRP.prepare("vRP/transfer_homes","UPDATE vrp_homes SET user_id = @nuser_id WHERE user_id = @user_id AND home = @home")
-----------------------------------------------------------------------------------------------------------------------------------------
-- PREPARE GARAGES
-----------------------------------------------------------------------------------------------------------------------------------------
vRP.prepare("vRP/get_vehicle","SELECT * FROM vrp_vehicles WHERE user_id = @user_id")
vRP.prepare("vRP/get_vehicle_plate","SELECT * FROM vrp_vehicles WHERE plate = @plate")
vRP.prepare("vRP/get_vehicle_phone","SELECT * FROM vrp_vehicles WHERE phone = @phone")
vRP.prepare("vRP/rem_vehicle","DELETE FROM vrp_vehicles WHERE user_id = @user_id AND vehicle = @vehicle")
vRP.prepare("vRP/get_vehicles","SELECT * FROM vrp_vehicles WHERE user_id = @user_id AND vehicle = @vehicle")
vRP.prepare("vRP/set_update_vehicles","UPDATE vrp_vehicles SET engine = @engine, body = @body, fuel = @fuel, doors = @doors, windows = @windows, tyres = @tyres WHERE user_id = @user_id AND vehicle = @vehicle")
vRP.prepare("vRP/set_arrest","UPDATE vrp_vehicles SET arrest = @arrest, time = @time WHERE user_id = @user_id AND vehicle = @vehicle")
vRP.prepare("vRP/move_vehicle","UPDATE vrp_vehicles SET user_id = @nuser_id WHERE user_id = @user_id AND vehicle = @vehicle")
vRP.prepare("vRP/add_vehicle","INSERT IGNORE INTO vrp_vehicles(user_id,vehicle,plate,phone,work) VALUES(@user_id,@vehicle,@plate,@phone,@work)")
vRP.prepare("vRP/con_maxvehs","SELECT COUNT(vehicle) as qtd FROM vrp_vehicles WHERE user_id = @user_id AND work = 'false'")
vRP.prepare("vRP/rem_srv_data","DELETE FROM vrp_srv_data WHERE dkey = @dkey")
vRP.prepare("vRP/update_garages","UPDATE vrp_users SET garage = garage + 1 WHERE id = @id")
vRP.prepare("vRP/update_plate_vehicle","UPDATE vrp_vehicles SET plate = @plate WHERE user_id = @user_id AND vehicle = @vehicle")
-----------------------------------------------------------------------------------------------------------------------------------------
-- PREPARE vRP_INVOICE
-----------------------------------------------------------------------------------------------------------------------------------------
vRP.prepare("vRP/add_invoice","INSERT INTO vrp_invoice(user_id,nuser_id,date,price,text) VALUES(@user_id,@nuser_id,@date,@price,@text)")
vRP.prepare("vRP/get_invoice","SELECT * FROM vrp_invoice WHERE user_id = @user_id")
vRP.prepare("vRP/get_myinvoice","SELECT * FROM vrp_invoice WHERE nuser_id = @nuser_id")
vRP.prepare("vRP/del_invoice","DELETE FROM vrp_invoice WHERE id = @id AND user_id = @user_id")
-----------------------------------------------------------------------------------------------------------------------------------------
-- PREPARE vRP_SALARY
-----------------------------------------------------------------------------------------------------------------------------------------
vRP.prepare("vRP/add_salary","INSERT INTO vrp_salary(user_id,date,price) VALUES(@user_id,@date,@price)")
vRP.prepare("vRP/get_salary","SELECT * FROM vrp_salary WHERE user_id = @user_id")
vRP.prepare("vRP/del_salary","DELETE FROM vrp_salary WHERE id = @id AND user_id = @user_id")
-----------------------------------------------------------------------------------------------------------------------------------------
-- PREPARE vRP_FINES
-----------------------------------------------------------------------------------------------------------------------------------------
vRP.prepare("vRP/add_fines","INSERT INTO vrp_fines(user_id,nuser_id,date,price,text) VALUES(@user_id,@nuser_id,@date,@price,@text)")
vRP.prepare("vRP/get_fines","SELECT * FROM vrp_fines WHERE user_id = @user_id")
vRP.prepare("vRP/del_fines","DELETE FROM vrp_fines WHERE id = @id AND user_id = @user_id")
-----------------------------------------------------------------------------------------------------------------------------------------
-- PREPARE vRP_WEAPONS
-----------------------------------------------------------------------------------------------------------------------------------------
vRP.prepare("vRP/add_weapon","INSERT INTO vrp_weapons(user_id,weapon,ammo) VALUES(@user_id,@weapon,@ammo)")
vRP.prepare("vRP/get_weapon","SELECT * FROM vrp_weapons WHERE user_id = @user_id")
vRP.prepare("vRP/update_weapon","UPDATE vrp_weapons SET ammo = @ammo WHERE user_id = @user_id and weapon = @weapon")
vRP.prepare("vRP/del_weapon","DELETE FROM vrp_weapons WHERE user_id = @user_id AND weapon = @weapon")
-----------------------------------------------------------------------------------------------------------------------------------------
-- PREPARE vRP_BARBERSHOP
-----------------------------------------------------------------------------------------------------------------------------------------
vRP.prepare("vRP/selectSkin","SELECT * FROM vrp_barbershop WHERE user_id = @user_id")
vRP.prepare("vRP/insertSkin","INSERT INTO vrp_barbershop(user_id) VALUES(@user_id)")
vRP.prepare("vRP/updateSkin","UPDATE vrp_barbershop SET fathers = @fathers, kinship = @kinship, eyecolor = @eyecolor, skincolor = @skincolor, acne = @acne, stains = @stains, freckles = @freckles, aging = @aging, hair = @hair, haircolor = @haircolor, haircolor2 = @haircolor2, makeup = @makeup, makeupintensity = @makeupintensity, makeupcolor = @makeupcolor, lipstick = @lipstick, lipstickintensity = @lipstickintensity, lipstickcolor = @lipstickcolor, eyebrow = @eyebrow, eyebrowintensity = @eyebrowintensity, eyebrowcolor = @eyebrowcolor, beard = @beard, beardintentisy = @beardintentisy, beardcolor = @beardcolor, blush = @blush, blushintentisy = @blushintentisy, blushcolor = @blushcolor WHERE user_id = @user_id")
-----------------------------------------------------------------------------------------------------------------------------------------
-- PREPARE vRP_PRISON
-----------------------------------------------------------------------------------------------------------------------------------------
vRP.prepare("vRP/set_prison","UPDATE vrp_users SET prison = prison + @prison, locate = @locate WHERE id = @user_id")
vRP.prepare("vRP/rem_prison","UPDATE vrp_users SET prison = prison - @prison WHERE id = @user_id")
vRP.prepare("vRP/fix_prison","UPDATE vrp_users SET prison = 1 WHERE id = @user_id")
vRP.prepare("vRP/resgate_prison","UPDATE vrp_users SET prison = 0 WHERE id = @user_id")
-----------------------------------------------------------------------------------------------------------------------------------------
-- PREPARE vRP_GEMS
-----------------------------------------------------------------------------------------------------------------------------------------
vRP.prepare("vRP/set_vRP_gemsitem","UPDATE vrp_infos SET gems = gems + 1 WHERE steam = @steam")
vRP.prepare("vRP/set_vRP_gems","UPDATE vrp_infos SET gems = gems + @gems WHERE steam = @steam")
vRP.prepare("vRP/rem_vRP_gems","UPDATE vrp_infos SET gems = gems - @gems WHERE steam = @steam")
vRP.prepare("vRP/set_rental_time","UPDATE vrp_vehicles SET premiumtime = @premiumtime WHERE user_id = @user_id AND vehicle = @vehicle")
-----------------------------------------------------------------------------------------------------------------------------------------
-- PREPARE vRP_CHESTS
-----------------------------------------------------------------------------------------------------------------------------------------
vRP.prepare("vRP/getExistChest","SELECT * FROM vrp_chests WHERE name = @name")
vRP.prepare("vRP/get_alltable","SELECT * FROM vrp_chests")
vRP.prepare("vRP/addChest","INSERT INTO vrp_chests (permiss,name,x,y,z,weight) VALUES (@permiss,@name,@x,@y,@z,@weight)")
-----------------------------------------------------------------------------------------------------------------------------------------
-- PREPARE vrp_benefactor
-----------------------------------------------------------------------------------------------------------------------------------------
vRP.prepare("vRP/get_ConceStock","SELECT * FROM vrp_benefactor")
vRP.prepare("vRP/update_ConceStock","UPDATE vrp_benefactor SET estoque = @estoque WHERE vehicle = @vehicle")
vRP.prepare("vRP/insert_ConceStock","INSERT INTO vrp_benefactor (estoque,vehicle) VALUES (@estoque,@vehicle)")