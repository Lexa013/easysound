EasySound.Sounds = {}

local function openFrame()
    local frame = vgui.Create("DFrame")
    frame:SetSize(500, 500)
    frame:Center()
    frame:MakePopup()
    frame:SetTitle("EasySound - Menu")

    local scroll = vgui.Create("DScrollPanel", frame)
    scroll:Dock(FILL)

    net.Start("ES::GetSounds")
    net.WriteString(util.SHA256(util.TableToJSON(EasySound.Sounds)))
    net.SendToServer()

    net.Receive("ES::GetSounds", function()
        local isSameHash = net.ReadBool()
        
        if (not isSameHash) then
            print("Server updated list, updating cache")
            // Doesn't need to specify an action cause the client can only receive the sound list
            local tableSize = net.ReadUInt(9)
            local sounds = {}
            
            for i = 1, tableSize do
                local name = net.ReadString()
                local path = net.ReadString()
                sounds[name] = path
            end
            EasySound.Sounds = sounds
        end

        for name, path in pairs(EasySound.Sounds) do
            local soundButton = scroll:Add("DButton")
            soundButton:SetText(name)
            soundButton:Dock(TOP)
            soundButton:DockMargin(0, 0, 0, 5)
        end
    end)
end

concommand.Add("easysound", openFrame)