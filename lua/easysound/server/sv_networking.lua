util.AddNetworkString("ES::ManipulateSound")
util.AddNetworkString("ES::GetSounds")

net.Receive("ES::GetSounds", function(_, ply)
    if (!ply:IsAdmin() or !ply:IsSuperAdmin()) then return end

    local sounds = EasySound.GetSounds()
    print(sounds)
    local clientHash = net.ReadString()
    local serverHash = util.SHA256(util.TableToJSON(sounds))
    local isSameHash = clientHash == serverHash

    net.Start("ES::GetSounds")
    net.WriteBool(isSameHash)

    if (not isSameHash) then
        print("[ES] Client version differs from server, sending new version")

        net.WriteUInt(table.Count(sounds), 9)
        for name, path in pairs(sounds) do
            net.WriteString(name)
            net.WriteString(path)
        end
    end

    net.Send(ply)
end)