if SERVER then

-- Send Shared/Client Files to the client
    AddCSLuaFile("easysound/sh_config.lua")
    AddCSLuaFile("easysound/client/cl_main.lua")
    AddCSLuaFile("easysound/client/cl_networking.lua")

    include("easysound/sh_config.lua")
    include("easysound/server/sv_functions.lua")
    include("easysound/server/sv_networking.lua")
else
    -- Must be included first
    include("easysound/sh_config.lua")

    include("easysound/client/cl_main.lua")
    include("easysound/client/cl_networking.lua")
end


