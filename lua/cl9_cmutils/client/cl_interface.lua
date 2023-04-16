
cl9_cmutils = {}
cl9_cmutils.players = player.GetAll()
cl9_cmutils.playerButtons = {}
cl9_cmutils.canvas = nil
local uiScale = ScrH() / 1080

function cl9_cmutils.doDerma()
    local canvas 

    if cl9_cmutils.canvas then
        canvas = cl9_cmutils.canvas
        canvas:Show()
        canvas:MakePopup()
        return 
    end

    canvas = vgui.Create( "DFrame" )
    cl9_cmutils.canvas = canvas
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
    local function paintList()
        playerList.Paint = function( _, w, h )
            draw.RoundedBox( 0, 0, 0, w, h, Color( 37, 37, 38, 255 ) )     
            for i, v in SortedPairs( cl9_cmutils.players ) do 
                cl9_cmutils.playerButtons[i] = vgui.Create( "DButton", playerList )
                local btn = cl9_cmutils.playerButtons[i]
                btn:SetPos( 5 * uiScale,  ( ( 42 * uiScale ) * ( i - 1 ) ) + ( 5 * uiScale ) + ( (5 * ( i - 1 ) ) * uiScale ) )
                btn:SetSize( 380 * uiScale, 42 * uiScale )
                local avtr = vgui.Create( "AvatarImage", btn )
                avtr:SetPos( 5 * uiScale, 5 * uiScale )
                avtr:SetSize( 32, 32 )
                avtr:SetPlayer( v, 32 )
                
                btn.Paint = function( _, bW, bH )
                    draw.RoundedBox( 0, 0, 0, bW, bH, Color( 51, 51, 51, 255 ) )
                end 
            end                   
        end
    end
    paintList()

    hook.Add( "PlayerInitialSpawn", "cl9_cmutils_playerinitialspawn", paintList )
    hook.Add( "PlayerDisconnected", "cl9_cmutils_playerdisconnect", paintList )
end

concommand.Add( "cl9_cmutils", cl9_cmutils.doDerma )

list.Set( "DesktopWindows", "cl9_cmutils", {
    title = "Comm Utils",
    icon = "materials/cl9_cmutils/icons/cl9_cmutils_icon.png",
    init = function()
        cl9_cmutils.doDerma()
    end
} )