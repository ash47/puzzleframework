DB = {}

-- Logging:
function DB.Log(text, force)
	if not text and not force then return end
	if not DB.File then
		if not file.IsDir("puzzle", "DATA") then
			file.CreateDir("puzzle")
		end
		if not file.IsDir("puzzle/logs", "DATA") then
			file.CreateDir("puzzle/logs")
		end
		DB.File = "puzzle/logs/"..os.date("%Y_%m_%d %H_%M")..".txt"
		file.Write(DB.File, os.date().. "\t".. text)
		return
	end
	file.Write(DB.File, (file.Read(DB.File) or "").."\n"..os.date().. "\t"..(text or ""))
end

function DB.Query(query, callback)
	--print(query)
	
	sql.Begin()
	local Result = sql.Query(query)
	sql.Commit()
	if callback then callback(Result) end
	--print("Result: "..tostring(Result))
	
	return Result
end

function DB.QueryValue(query, callback)
	callback(sql.QueryValue(query))
end

-- Make sure all our tables exist:
function DB.Init()
	sql.Begin()
		DB.Query("CREATE TABLE IF NOT EXISTS exp(steam INTEGER NOT NULL, exp INTEGER NOT NULL, PRIMARY KEY(steam));")
		DB.Query("CREATE TABLE IF NOT EXISTS money(steam INTEGER NOT NULL, money INTEGER NOT NULL, PRIMARY KEY(steam));")
		DB.Query("CREATE TABLE IF NOT EXISTS playtime(steam INTEGER NOT NULL, playtime INTEGER NOT NULL, PRIMARY KEY(steam));")
		DB.Query("CREATE TABLE IF NOT EXISTS donor(steam INTEGER NOT NULL, donor INTEGER NOT NULL, PRIMARY KEY(steam));")
		
		-- Shop Stuff:
		DB.Query("CREATE TABLE IF NOT EXISTS items(steam INTEGER NOT NULL, item INTEGER NOT NULL, PRIMARY KEY(steam, item));")
		DB.Query("CREATE TABLE IF NOT EXISTS equipped(steam INTEGER NOT NULL, item INTEGER NOT NULL, PRIMARY KEY(steam, item));")
	sql.Commit()
end

-- Load meta:
local meta = FindMetaTable("Player")

-- Used for saving Playtime:
function meta:SavePlaytime()
	if not self:IsValid() then return end
	local steamID = self:UniqueID()
	DB.QueryValue("SELECT playtime FROM playtime WHERE steam = "..steamID..";", function(r)
		if r then
			DB.Query("UPDATE playtime SET playtime = "..math.floor(self.playtime+CurTime()-self.playtimelast).." WHERE steam = "..steamID..";")
		else
			DB.Query("INSERT INTO playtime VALUES("..sql.SQLStr(steamID)..", "..math.floor(CurTime()-self.playtimelast)..");")
		end
	end)
	self.playtimelast = CurTime()
end

-- Used for loading Playtime:
function meta:LoadPlaytime()
	if not self:IsValid() then return end
	local steamID = self:UniqueID()
	DB.QueryValue("SELECT playtime FROM playtime WHERE steam = "..steamID..";", function(r)
		if r then
			self.playtime = r
			self.playtimelast = CurTime()
		else
			self.playtime = 0
			self.playtimelast = CurTime()
			self:SavePlaytime()
		end
	end)
end

-- Set Donor Status:
function meta:SetDonorStatus(status)
	if not self:IsValid() then return end
	local steamID = self:UniqueID()
	DB.QueryValue("SELECT donor FROM donor WHERE steam = "..steamID..";", function(r)
		if r then
			DB.Query("UPDATE donor SET donor = " .. math.floor(status) .. " WHERE steam = "..steamID..";")
		else
			DB.Query("INSERT INTO donor VALUES("..steamID..", "..math.floor(status)..");")
		end
	end)
end

-- Load Donor:
function meta:LoadDonor()
	if not self:IsValid() then return end
	local steamID = self:UniqueID()
	DB.QueryValue("SELECT donor FROM donor WHERE steam = "..steamID..";", function(r)
		if r then
			self.donor = r
		else
			self.donor = "0"
		end
	end)
end

function meta:IsDonor()
	return tostring(self.donor) ~= "0"
end

-- Used for saving EXP:
function meta:SaveExp()
	if not self:IsValid() then return end
	local steamID = self:UniqueID()
	DB.QueryValue("SELECT exp FROM exp WHERE steam = "..steamID..";", function(r)
		if r then
			DB.Query("UPDATE exp SET exp = "..math.floor(self.exp).." WHERE steam = "..steamID..";")
		else
			DB.Query("INSERT INTO exp VALUES("..steamID..", "..math.floor(self.exp)..");")
		end
	end)
end

-- Get Level:
function GetLevel(exp)
	return math.ceil(33*math.log(exp/3300 +1))
end

-- Used for loading EXP:
function meta:LoadExp()
	if not self:IsValid() then return end
	local steamID = self:UniqueID()
	DB.QueryValue("SELECT exp FROM exp WHERE steam = "..steamID..";", function(r)
		if r then
			self.exp = r
			self.lvl = GetLevel(self.exp)
			self.rlvl = self.lvl
		else
			self.exp = 1 --  Starting EXP
			self.lvl = GetLevel(self.exp)
			self.rlvl = self.lvl
			self:SaveExp()
		end
	end)
end

-- Used for saving money:
function meta:Savemoney()
	if not self:IsValid() then return end
	local steamID = self:UniqueID()
	DB.QueryValue("SELECT money FROM money WHERE steam = "..steamID..";", function(r)
		if r then
			DB.Query("UPDATE money SET money = "..math.floor(self.money).." WHERE steam = "..steamID..";")
		else
			DB.Query("INSERT INTO money VALUES("..steamID..", "..math.floor(self.money)..");")
		end
	end)
	
	-- Send to player:
	self:SendMoney()
end

-- Used for loading money:
function meta:Loadmoney()
	if not self:IsValid() then return end
	local steamID = self:UniqueID()
	DB.QueryValue("SELECT money FROM money WHERE steam = "..steamID..";", function(r)
		if r then
			self.money = tonumber(r)
			
			-- Send to player:
			self:SendMoney()
		else
			self.money = 0 --  Starting money
			self:Savemoney()
		end
	end)
	
	
end

function meta:SendMoney()
	net.Start("money")
	net.WriteInt(self.money, 16)
	net.Send(self)
end

-- Award Puzzle stuff:
function DB.PuzzleScore()
	for k,v in pairs(player.GetAll()) do
		v.exp = v.exp+3
		v.puzzlesbeaten = v.puzzlesbeaten+1
		v:SaveExp()
		v.money=v.money+(GetLevel(v.exp)-v.rlvl)*20
		v.rlvl = GetLevel(v.exp)
		v:Savemoney()
	end
end

function FiveMinuteFunction()
	for k,v in pairs(player.GetAll()) do
		-- Add Time Bonus:
		local gain = 1
		if v.OldPos then
			if v:GetPos() == v.OldPos then
				gain = 0
			end
		else
			v.OldPos = v:GetPos()
			gain = 0
		end
		v.timebonus = v.timebonus+gain
		
		-- Add money Bonus:
		v.money=v.money+gain
		v:Savemoney()
		v:SavePlaytime()
	end
end
if not GameLoaded then
	timer.Create("FiveMinuteFunction", 300, 0, FiveMinuteFunction)
end

-- When a map is finished:
function DB.FinshMap()
	for k,v in pairs(player.GetAll()) do
		if Spawn_Coop then
			-- Beat a coop map:
			local gain = 12 * v.timebonus
			v.exp = v.exp+gain
			v:SaveExp()
		else
			-- Beat a puzzle map:
			local gain = v.puzzlesbeaten*v.timebonus
			v.exp = v.exp+gain
			v:SaveExp()
		end
		v.money=v.money+(GetLevel(v.exp)-v.rlvl)*20
		v:Savemoney()
		v:SavePlaytime()
	end
end

-- Start our database:
DB.Init()
