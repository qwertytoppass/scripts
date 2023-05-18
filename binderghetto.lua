script_author = "Oleg Mangal"
script_name = "EzBind"
script_version = "1.0"

require "lib.moonloader"
local memory = require 'memory'
local ev = require 'lib.samp.events'
local restore_text = false
local inicfg = require 'inicfg'
local dlstatus = require('moonloader').download_status
mem = require("memory")

update_state = false

local script_vers = 2
local script_vers_text = "1.01"

local update_url = "https://raw.githubusercontent.com/qwertytoppass/scripts/main/update.ini"
local update_path = getWorkingDirectory() .. "/update.ini"

local script_url = "https://raw.githubusercontent.com/qwertytoppass/scripts/main/binderghetto.lua"
local script_path = thisScript().path

local dialogs_data = {}
local dialogIncoming = 0

bike = {[481] = true, [509] = true, [510] = true}
moto = {[448] = true, [461] = true, [462] = true, [463] = true, [468] = true, [471] = true, [521] = true, [522] = true, [523] = true, [581] = true, [586] = true}

function main()
    while not  isSampAvailable() do wait(100) end

	downloadUrlToFile(update_url, update_path, function(id, status)
        if status == dlstatus.STATUS_ENDDOWNLOADDATA then
            updateini = inicfg.load(nil, update_path)
            if tonumber(updateini.info.vers) > script_vers then
                sampAddChatMessage("Вышло обновленное видео секса с мамой романика, его версия: " .. updateini.info.vers_text, -1)
                update_state = true
            end
            os.remove(update_path)
        end
    end)


	sampAddChatMessage("{FFFFFF}[INFO]: {228B22}Срипт загружен. {FFFFFF} Его автор: {808000}Ебырь мамы Романика голд")
	sampAddChatMessage("{FFFFFF}[INFO]: {006400}Романик голд сын проститутки.")
	print("Скрипт загружен. Автор:"..script_author)

	while true do wait(0)

		if update_state then
            downloadUrlToFile(script_url, script_path, function(id, status)
                if status == dlstatus.STATUS_ENDDOWNLOADDATA then
                    sampAddChatMessage("Скрипт успешно обновился до версии " .. updateini.info.vers_text, -1)
                    thisScript():reload()
                end
            end)
            break
        end

		mem.write(0x5109AC, 235, 1, true)
		mem.write(0x5109C5, 235, 1, true)
		mem.write(0x5231A6, 235, 1, true)
		mem.write(0x52322D, 235, 1, true)
		mem.write(0x5233BA, 235, 1, true)

		if dialogIncoming ~= 0 and dialogs_data[dialogIncoming] then
			local data = dialogs_data[dialogIncoming]
			if data[1] and not restore_text then
				sampSetCurrentDialogListItem(data[1])
			end
			if data[2] then
				sampSetCurrentDialogEditboxText(data[2])
			end
			dialogIncoming = 0
		end

		if isCharOnAnyBike(playerPed) and isKeyCheckAvailable() and isKeyDown(0xA0) then	-- onBike&onMoto SpeedUP [[LSHIFT]] --
			if bike[getCarModel(storeCarCharIsInNoSave(playerPed))] then
				setGameKeyState(16, 255)
				wait(10)
				setGameKeyState(16, 0)
			elseif moto[getCarModel(storeCarCharIsInNoSave(playerPed))] then
				setGameKeyState(1, -128)
				wait(10)
				setGameKeyState(1, 0)
			end
		end
		
		if isCharOnFoot(playerPed) and isKeyDown(0x31) and isKeyCheckAvailable() then -- onFoot&inWater SpeedUP [[1]] --
			setGameKeyState(16, 256)
			wait(10)
			setGameKeyState(16, 0)
		elseif isCharInWater(playerPed) and isKeyDown(0x31) and isKeyCheckAvailable() then
			setGameKeyState(16, 256)
			wait(10)
			setGameKeyState(16, 0)
		end

		if isKeyJustPressed(VK_X) then
            if isCharInAnyCar(PLAYER_PED) then
                freezeCarPosition(storeCarCharIsInNoSave(PLAYER_PED), false)
            else
                setPlayerControl(PLAYER_HANDLE, true)
                freezeCharPosition(PLAYER_PED, false)
                clearCharTasksImmediately(PLAYER_PED)
            end
        end

		if isKeyDown(VK_F) and isKeyJustPressed(VK_RBUTTON) then
			RunC(50)
			while isKeyDown(VK_F) do -- чтобы не спамилось куча патрон
				wait(0)
			end
		end
   repeat
      wait(0)
   until sampIsLocalPlayerSpawned()
   
	if isKeyJustPressed(VK_N) and not sampIsCursorActive() then 
		sampSendChat('/capture') -- Капт

	elseif isKeyJustPressed(VK_M) and not sampIsCursorActive() then
		sampSendChat('/usedrugs') --Наркотики

	elseif isKeyJustPressed(VK_B) and not sampIsCursorActive() then
	sampSendChat("/get guns") --Оружие

	elseif isKeyJustPressed(VK_L) and not sampIsCursorActive() then
	sampSendChat("/healme") --Аптечка
	
	elseif isKeyJustPressed(VK_0) and not sampIsCursorActive() then
	sampSendChat("Ну боже чел, ты слаб") --Слит
	
	elseif isKeyJustPressed(VK_9) and not sampIsCursorActive() then
	sampSendChat("Сосать нищий") --Слит x2
	
	elseif isKeyJustPressed(VK_P) and not sampIsCursorActive() then
	sampSendChat("Мне нечего сказать, ты просто 0") --Слит x3
	
	elseif isKeyJustPressed(VK_8) and not sampIsCursorActive() then
	sampSendChat("/bc Девочки, на каптик)))") --Сосать бомжи на вагосах
	
	elseif isKeyJustPressed(VK_K) and not sampIsCursorActive() then
	sampSendChat("/f На кулак бомжа!") --Сосать бомжи на вагосах x2
	
	elseif isKeyJustPressed(VK_J) and not sampIsCursorActive() then
	sampSendChat("/bc Девочка на вагосах не плачь только)") --Сосать бомжи на вагосах x3
	
	elseif isKeyJustPressed(VK_O) and not sampIsCursorActive() then
	sampSendChat("/bc Прости если трахнул") --Сосать бомжи на вагосах x4
	end

	end

end

--============Функции============--

function RunC(wt)
	if not sampIsChatInputActive() and not isSampfuncsConsoleActive() then
		if isWeaponReload() then
			setVirtualKeyDown(VK_LBUTTON, true)
			wait(wt)
			setVirtualKeyDown(VK_LBUTTON, false)
			setVirtualKeyDown(VK_RBUTTON, false)
			setVirtualKeyDown(VK_C, true)
			wait(wt)
			setVirtualKeyDown(VK_C, false)
			setVirtualKeyDown(VK_RBUTTON, true)
		end
	end
end

function getAmmoInClip()
  local struct = getCharPointer(playerPed)
  local prisv = struct + 0x0718
  local prisv = memory.getint8(prisv, false)
  local prisv = prisv * 0x1C
  local prisv2 = struct + 0x5A0
  local prisv2 = prisv2 + prisv
  local prisv2 = prisv2 + 0x8
  local ammo = memory.getint32(prisv2, false)
  return ammo
end

function isWeaponReload()
	modelId = getCharModel(PLAYER_PED)
    weapon = getCurrentCharWeapon(PLAYER_PED)
    ammo = getAmmoInClip()
    if weapon == 24 then
    	if ammo == 0 then return false end
    	return true
    end
    return false
end

function isKeyCheckAvailable()
	if not isSampLoaded() then
		return true
	end
	if not isSampfuncsLoaded() then
		return not sampIsChatInputActive() and not sampIsDialogActive()
	end
	return not sampIsChatInputActive() and not sampIsDialogActive() and not isSampfuncsConsoleActive()
end

function ev.onSendDialogResponse(dialogId , button , listboxId , input)
	dialogs_data[dialogId] = {listboxId, input}
end

function ev.onShowDialog(dialogId , style , title , button1 , button2 , text)
	dialogIncoming = dialogId
end