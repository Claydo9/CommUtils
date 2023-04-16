local cl9_cmutils = {}

local uiScale = ScrH() / 1080

local function doDerma()
    local canvas 
    
    if canvas then
        canvas:Show()
        canvas:MakePopup()
        return 
    end

    canvas = vgui.Create( "DFrame" )
    canvas:SetSize( 400 * uiScale, 800 * uiScale )
    canvas:Center()
    canvas:SetTitle( "Comm Utils" )
    canvas:SetDeleteOnClose( false )
    canvas:MakePopup()

    canvas.Paint = function( _, w, h )
        draw.RoundedBox( 8, 0, 0, w, h, Color( 51, 51, 51, 255 ) )
        draw.RoundedBox( 8, 0, 0, w, 30, Color( 37, 37, 38, 255 ) )
    end

    local playerList = vgui.Create( "DScrollPanel", canvas )
    playerList:SetPos( 10 * uiScale, 40 * uiScale )
    playerList:SetSize()
end


list.Set( "DesktopWindows", "cl9_cmutils", {
    title = "Comm Utils",
    icon = "cl9_cmutils/icons/cl9_cmutils_icon.png",
    init = function()

    end
} )