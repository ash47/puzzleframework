ENT.Type = "point"

function ENT:Initialize()
end

function ENT:AcceptInput( name, activator, caller, data )
	DB.PuzzleScore()
	self.Entity:Remove()
	return false
end
