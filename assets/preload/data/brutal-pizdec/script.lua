function onCreate()
    makeLuaSprite('blackFlash', nil, 0, 0)
    makeGraphic('blackFlash', screenWidth, screenHeight, '000000')
    setObjectCamera('blackFlash', 'camhud')
    addLuaSprite('blackFlash', false)
    setProperty('blackFlash.alpha', 0.0001)

    makeLuaSprite('endBl', nil, 0, 0)
    makeGraphic('endBl', screenWidth, screenHeight, '000000')
    setObjectCamera('endBl', 'camOther')
    addLuaSprite('endBl', false)
    setProperty('endBl.alpha', 0.0001)

    makeLuaSprite('pep', 'together_pep', 0, 0);
    setObjectCamera('pep', 'camhud')
    addLuaSprite('pep', true);

    makeLuaSprite('pea', 'together_pea', 0, 0);
    setObjectCamera('pea', 'camhud')
    addLuaSprite('pea', true);

    makeLuaSprite('squash', 'together_squash', 0, 0);
    setObjectCamera('squash', 'camhud')
    addLuaSprite('squash', true);

    makeLuaSprite('ghost', 'together_ghost', 0, 0);
    setBlendMode('ghost', 'ADD')
    setObjectCamera('ghost', 'camhud')
    addLuaSprite('ghost', true);

    setProperty('pep.alpha', 0.0001)
    setProperty('pea.alpha', 0.0001)
    setProperty('squash.alpha', 0.0001)
    setProperty('ghost.alpha', 0.0001)

    makeLuaSprite('bp', 'together_bp', 0, 0);
    setObjectCamera('bp', 'camhud')
    addLuaSprite('bp', true);

    setProperty('bp.alpha', 0.0001)
end

function onBeatHit()
    if curBeat == 576 then
        doTweenAlpha("sex", "blackFlash", 1, 1)
    end

    if curBeat == 592 then
        doTweenAlpha("sex", "blackFlash", 0.0001, 20)
    end

    if curBeat == 720 then
        doTweenAlpha("sex", "blackFlash", 1, 1)
        doTweenAlpha('AlphaTween1', 'timeBarBG', 0, 1) 
        doTweenAlpha('AlphaTween2', 'timeBar', 0, 1) 
        doTweenAlpha('AlphaTween3', 'timeTxt', 0, 1)  
        doTweenAlpha('AlphaTween4', 'scoreTxt', 0, 1)  
        doTweenAlpha('AlphaTween45', 'healthBarBGOverlay', 0, 1)  
        doTweenAlpha('AlphaTween46', 'healthBarBG', 0, 1)
        doTweenAlpha('AlphaTween467', 'healthBar', 0, 1)
        doTweenAlpha('AlphaTween4627', 'iconP1', 0, 1)
        doTweenAlpha('AlphaTween5', 'iconP2', 0, 1)

        for i = 0, 7 do
            noteTweenAlpha('CANNOT'..i, i, 0, 1)
        end
    end

    if curBeat == 731 then
        doTweenAlpha("pep_alpha", "pep", 1, 1)
        doTweenX("pep_move", "pep", 600, 10)
    end

    if curBeat == 738 then
        doTweenAlpha("pep_alpha_gone", "pep", 0, 3)
    end

    if curBeat == 742 then
        doTweenAlpha("pea_alpha", "pea", 1, 1)
        doTweenX("pea_move", "pea", -600, 10)
    end

    if curBeat == 755 then
        doTweenAlpha("pea_alpha_gone", "pea", 0, 3)
    end

    if curBeat == 757 then
        doTweenAlpha("squash_alpha", "squash", 1, 1)
        doTweenX("squash_move", "squash", 600, 10)
    end

    if curBeat == 768 then
        doTweenAlpha("squash_alpha_gone", "squash", 0, 3)
    end

    if curBeat == 770 then
        doTweenAlpha("ghost_alpha", "ghost", 1, 1)
        doTweenX("ghost_move", "ghost", -600, 10)
    end

    if curBeat == 778 then
        doTweenAlpha("ghost_alpha_gone", "ghost", 0, 3)
    end

    if curBeat == 784 then
        doTweenAlpha("bp_alpha", "bp", 1, 1)
        doTweenX('Bp_scalex', 'bp.scale', 1.5, 4)
        doTweenY('Bp_scaley', 'bp.scale', 1.5, 4)
    end

    if curBeat == 792 then
        doTweenAlpha("sex", "blackFlash", 0.0001, 0.001)
        doTweenAlpha("sex2", "bp", 0.0001, 0.001)
        doTweenAlpha('AlphaTween1', 'timeBarBG', 1, 1) 
        doTweenAlpha('AlphaTween2', 'timeBar', 1, 1) 
        doTweenAlpha('AlphaTween3', 'timeTxt', 1, 1)  
        doTweenAlpha('AlphaTween4', 'scoreTxt', 1, 1)  
        doTweenAlpha('AlphaTween45', 'healthBarBGOverlay', 1, 1)  
        doTweenAlpha('AlphaTween46', 'healthBarBG', 1, 1)
        doTweenAlpha('AlphaTween467', 'healthBar', 1, 1)
        doTweenAlpha('AlphaTween4627', 'iconP1', 1, 1)
        doTweenAlpha('AlphaTween5', 'iconP2', 1, 1)

        for i = 0, 7 do
            noteTweenAlpha('can'..i, i, 1, 1)
        end

        cameraFlash('camHUD', 'FFFFFF', 1)
    end

    if curBeat == 1192 then
        doTweenAlpha("sex", "endBl", 1, 0.001)
        cameraFlash('camOther', 'FFFFFF', 1)
    end
end