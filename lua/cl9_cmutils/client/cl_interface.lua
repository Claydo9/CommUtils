
cl9_cmutils = {}
cl9_cmutils.players = player.GetAll()
local uiScale = ScrH() / 1080


function cl9_cmutils.doDerma()
    local canvas 
    
    if canvas then
        canvas:Show()
        canvas:MakePopup()
        return 
    end

    canvas = vgui.Create( "DFrame" )
    canvas:SetSize( 400 * uiScale, 600 * uiScale )
    canvas:Center()
    canvas:SetTitle( "Comm Utils" )
    canvas:SetDeleteOnClose( false )
    canvas:MakePopup()

    canvas.Paint = function( _, w, h )
        draw.RoundedBox( 8, 0, 0, w, h, Color( 51, 51, 51, 255 ) )
        draw.RoundedBox( 8, 0, 0, w, 30, Color( 37, 37, 38, 255 ) )
    end

    local playerList = vgui.Create( "DScrollPanel", canvas )
    playerList:SetPos( 5 * uiScale, 30 * uiScale )
    playerList:SetSize( 390 * uiScale , 560 * uiScale )
    playerList.Paint = function( _, w, h )
        draw.RoundedBox( 0, 0, 0, w, h, Color( 37, 37, 38, 255 ) )
    end 
end

function cl9_cmutils.updateList()
    cl9_cmutils.players = player.GetAll()
end

hook.Add( "PlayerInitialSpawn", "cl9_cmutils_playerinitialspawn", cl9_cmutils.updateList )
hook.Add( "PlayerDisconnected", "cl9_cmutils_playerdisconnect", cl9_cmutils.updateList )

concommand.Add( "cl9_cmutils", cl9_cmutils.doDerma )

list.Set( "DesktopWindows", "cl9_cmutils", {
    title = "Comm Utils",
    icon = "materials/cl9_cmutils/icons/cl9_cmutils_icon.png",
    init = function()
        cl9_cmutils.doDerma()
    end
} )