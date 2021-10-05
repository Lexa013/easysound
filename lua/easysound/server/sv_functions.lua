-- Used internally

local function getData()
    local rawData = file.Read("easysound.txt", "data")
    
    if (rawData == nil) then
        EasySound.Sounds = {}
        return
    end

    local data = util.JSONToTable(rawData)
    EasySound.Sounds = data
end

local function saveData(data)
    file.Write("easysound.txt", util.TableToJSON(data, true))

    EasySound.Sounds = data
end

--------------------------------------------------------------

/*
    Returns a list of sounds present in the server data
*/
function EasySound.GetSounds()
    if (EasySound.Sounds == nil) then
        getData()
    end

    return EasySound.Sounds
end

/*
    Add a sound to the existing data
    @param An idenitifier which will be shown in the menu
    @param The soound path
*/

function EasySound.AddSound(identifier, path)
    local data = EasySound.GetSounds()

    data[identifier] = path
    saveData(data)
end

/*
    Remove a sound from the existing data
    @param The key with the given value will be removed if it exists
*/ 

function EasySound.RemoveSound(identifier)
    local data = EasySound.GetSounds()

    data[identifier] = nil
    saveData(data)
end