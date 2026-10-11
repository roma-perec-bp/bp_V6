function onCreate()
    makeLuaSprite('intro', 'songIntro', 0, -60)
    scaleObject('intro', 0.8, 0.8)
    setObjectCamera('intro', 'other')
    addLuaSprite('intro', false)

    makeLuaText('nameSong', 'BRUTAL PIZDEC', 0, 450, 250)
    setTextAlignment('nameSong', 'center')
    setTextColor('nameSong', '0xFFff0000')
    setTextSize('nameSong', 100)
    setObjectCamera('nameSong', 'other')
    addLuaText('nameSong')

    makeLuaText('creditSong', 'song by: Kawaii Sprite, Saruky,\nSaster, Punkett,\nChurgney Gurgney, Bethoven,\nArtur Pirozhkov, Alexandr Pushkin,\nMy Music teacher, random person i met yesterday', 0, 450, 400)
    setTextAlignment('creditSong', 'center')
    setTextSize('creditSong', 50)
    setObjectCamera('creditSong', 'other')
    addLuaText('creditSong')

    doTweenX('hey', 'intro', -1500, 0.0001, 'quadinout')
    doTweenX('heyName', 'nameSong', -1000, 0.0001, 'quadinout')
    doTweenX('heyCred', 'creditSong', -1200, 0.0001, 'quadinout')
end

function onSongStart()
    doTweenX('hey', 'intro', 0, 1, 'quadinout')
    doTweenX('heyName', 'nameSong', 350, 1, 'quadinout')
    doTweenX('heyCred', 'creditSong', 200, 1, 'quadinout')
end

function onBeatHit()
    if curBeat == 8 then
        doTweenX('bye', 'intro', -1500, 2, 'quadinout')
        doTweenX('byeName', 'nameSong', -1000, 2, 'quadinout')
        doTweenX('byecree', 'creditSong', -1200, 2, 'quadinout')
    end
end