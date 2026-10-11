


--[[
    Made By BBPanzu
    Improved By Cherry
    Fixed By Laztrix

    How To Use:
        Put this script in scripts folder
        if you want to use it on a certain script do this
            callScript('scripts/VideoSpriteHandler', 'makeVideoSprite', {'videotag', 'videoname', X, Y, 'camera', hasVolume})
       
        for the camera you can put
            -camHUD
            -camGame
            -camOther
        for hasVolume you can set it to true or false
        
    this have unfunny callback you can use when the video are finished by the tag.
    example:

        function onVideoFinished(name)
            if name == 'videotag' then
                --code here lma
            end
        end
]]--

local videoCache = {'boom'}
--[[ 
    put your videoname here to cache it
    example: {'videoname','videoname2'}
    or leave it like that if you do not want to cache it.

    do note!
        IF YOU DONT CACHE THE VIDEO YOU WILL RECEIVE A MASSIVE LAG SPIKE FOR A MOMENT
                ]]

-- [[the stuff ]] --
function onCreate()
    addHaxeLibrary('FlxVideo', 'hxcodec.flixel')
    addHaxeLibrary('Event', 'openfl.events')
    precacheVideos()
end
local videoSprites = {}
function makeVideoSprite(tag, videoPath, x, y, camera, hasVolume)
    runHaxeCode([[
        ]]..tag..[[ = new FlxVideo();
        ]]..tag..[[.play(Paths.video("]]..videoPath..[["));
        ]]..tag..[[.alpha = 0; 
        //]]..tag..[[.autoResize = false;
        setVar("]]..tag..[[hasVolume", ]]..(hasVolume and 1 or 0)..[[);
        ]]..tag..[[.onEndReached.add(function()
        { 
            ]]..tag..[[.dispose();
            game.remove(game.getLuaObject("]]..tag..[[")); 
            game.callOnLuas("onVideoFinished",["]]..tag..[["]);
            return;
        }, true);
        FlxG.stage.removeEventListener("enterFrame", ]]..tag..[[.onEnterFrame);
    ]])
    makeLuaSprite(tag, nil, x, y)
    setObjectCamera(tag, camera)
    addLuaSprite(tag)
    table.insert(videoSprites, tag)
end
function precacheVideos()
    if #videoCache == 0 then

    else
        for i = 1,#videoCache do
            local tag = videoCache[i]..'c'
            runHaxeCode([[
            ]]..tag..[[ = new FlxVideo();
            ]]..tag..[[.play(Paths.video("]]..videoCache[i]..[["));
            ]]..tag..[[.stop();
            ]])
        end
    end
end
function onUpdatePost()
    for _, __ in pairs(videoSprites) do
        runHaxeCode([[
            if (game.getLuaObject("]]..__..[[") != null)
            {
                game.getLuaObject("]]..__..[[").loadGraphic(]]..__..[[.bitmapData);
                if (getVar("]]..__..[[hasVolume"))
                    ]]..__..[[.volume = 1;
                else
                    ]]..__..[[.volume = 0;
            }
        ]])
    end
end
function onPause()
    for _, __ in pairs(videoSprites) do
        runHaxeCode([[
            ]]..__..[[.pause();
        ]])
    end
end
function onDestroy()
    for _, __ in pairs(videoSprites) do
        runHaxeCode([[
            ]]..__..[[.stop;
        ]])
    end     
end
function onResume()
    for _, __ in pairs(videoSprites) do
        runHaxeCode([[
            ]]..__..[[.resume();
        ]])
    end
end