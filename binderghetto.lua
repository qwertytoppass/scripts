script_author = "Oleg Mangal"
script_name = "EzBind"
script_version = "1.0"

require "lib.moonloader"
local memory = require 'memory'
local inicfg = require 'inicfg'
local dlstatus = require('moonloader').download_status

update_state = false

local script_vers = 1
local script_vers_text = "1.00"

local update_url = "https://raw.githubusercontent.com/qwertytoppass/scripts/main/update.ini"
local update_path = getWorkingDirectory() .. "/update.ini"

local script_url = "https://raw.githubusercontent.com/qwertytoppass/scripts/main/binderghetto.lua"
local script_path = thisScript().path

function main()
    if not isSampLoaded() or not  isSampfuncsLoaded() then return end
    while not  isSampAvailable() do wait(100) end
	
	downloadUrlToFile(update_url, update_path, function(id, status)
		if status == dlstatus.STATUS_ENDDOWNLOADDATA then
			updateini = inicfg.load(nil, update_path)
			if tonumber(updateini.info.vers) > script_vers then
				sampAddChatMessage('Вышло обновление в котором я ебу мамку Романика Голда. Версия: ' .. updateini.info.vers_text, -1)
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
				sampAddChatMessage('Скрипт успешно обновлен!', -1)
				thisScript():reload()
			end
		end)
		break
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