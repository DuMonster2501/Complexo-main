@echo off
start artifacts\FXServer.exe +set onesync on +set onesync_enableInfinity 1 +set onesync_enableBeyond 1 +set onesync_forceMigration 1 +set onesync_distanceCullVehicles 1 +set sv_enforceGameBuild 2189 +exec server.cfg 
