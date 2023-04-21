cl9_cmutils = {}
cl9_cmutils.playerButtons = {}
cl9_cmutils.paintList = nil
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
    cl9_cmutils.paintList = function()
        playerList.Paint = function( _, w, h )
            draw.RoundedBox( 0, 0, 0, w, h, Color( 37, 37, 38, 255 ) )     
            for i, v in SortedPairs( player.GetAll() ) do 
                cl9_cmutils.playerButtons[v:GetName()] = vgui.Create( "DButton", playerList )
                local btn = cl9_cmutils.playerButtons[v:GetName()]
                btn:SetPos( 5 * uiScale,  ( ( 42 * uiScale ) * ( i - 1 ) ) + ( 5 * uiScale ) + ( (5 * ( i - 1 ) ) * uiScale ) )
                btn:SetSize( 380 * uiScale, 42 * uiScale )
                btn:SetTextColor( Color( 255, 255, 255 ) )
                btn:SetFont( "ChatFont" )
                btn:SetText( v:GetName() )
                local avtr = vgui.Create( "AvatarImage", btn )
                avtr:SetPos( 5 * uiScale, 5 * uiScale )
                avtr:SetSize( 32, 32 )
                avtr:SetPlayer( v, 32 )
                
                btn.Paint = function( _s, bW, bH )
                    draw.RoundedBox( 0, 0, 0, bW, bH, Color( 51, 51, 51, 255 ) )
                    if _s:IsHovered() then 
                        draw.RoundedBox( 0, -10, -10, bW + 10, bH + 10, Color( 0, 132, 255 ) )
                    end
                end 
            end                   
        end
    end
    cl9_cmutils.paintList()
end

concommand.Add( "cl9_cmutils", cl9_cmutils.doDerma )

local function attemptPaint()
    if cl9_cmutils.paintList then 
        cl9_cmutils.paintList() 
    end
end

gameevent.Listen( "player_connect" )
hook.Add( "player_connect", "cl9_cmutils_playerinitialspawn", attemptPaint )
gameevent.Listen( "player_disconnect" )
hook.Add( "player_disconnect", "cl9_cmutils_playerdisconnect", function( _, _, name )
    if cl9_cmutils.paintList then
        if table.HasValue( cl9_cmutils.playerButtons, name ) then table.remove( cl9_cmutils.playerButtons, name ) end
        cl9_cmutils.paintList()
    end
end )
list.Set( "DesktopWindows", "cl9_cmutils", {
    title = "Comm Utils",
    icon = "materials/cl9_cmutils/icons/cl9_cmutils_icon.png",
    init = function()
        cl9_cmutils.doDerma()
    end
} )