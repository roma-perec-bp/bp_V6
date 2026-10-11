function onCreate()
    makeLuaSprite('intro', 'songIntro', 0, -60)
    scaleObject('intro', 0.8, 0.8)
    setObjectCamera('intro', 'other')
    addLuaSprite('intro', false)

    makeLuaText('nameSong', '666', 0, 520, 250)
    setTextAlignment('nameSong', 'center')
    setTextColor('nameSong', '0xFFFFFFFF')
    setTextSize('nameSong', 100)
    setObjectCamera('nameSong', 'other')
    addLuaText('nameSong')

    makeLuaText('creditSong', 'og song by: sibottle || cover by: random name lmao idk who else', 0, 350, 400)
    setTextAlignment('creditSong', 'center')
    setTextSize('creditSong', 35)
    setObjectCamera('creditSong', 'other')
    addLuaText('creditSong')

    doTweenX('hey', 'intro', -1500, 0.0001, 'quadinout')
    doTweenX('heyName', 'nameSong', -950, 0.0001, 'quadinout')
    doTweenX('heyCred', 'creditSong', -1100, 0.0001, 'quadinout')
end

function onSongStart()
    doTweenX('hey', 'intro', 0, 1, 'quadinout')
    doTweenX('heyName', 'nameSong', 520, 1, 'quadinout')
    doTweenX('heyCred', 'creditSong', 350, 1, 'quadinout')
end

function onBeatHit()
    if curBeat == 8 then
        doTweenX('bye', 'intro', -1500, 2, 'quadinout')
        doTweenX('byeName', 'nameSong', -950, 2, 'quadinout')
        doTweenX('byecree', 'creditSong', -1100, 2, 'quadinout')
    end
end