function onCreatePost()
	--this makes the rating object
	if downscroll then
	makeAnimatedLuaSprite("ratings","ratings",1050,-20);
	else
	makeAnimatedLuaSprite("ratings","ratings",1050,550);
	end
	addLuaSprite("ratings",true);
	setScrollFactor('ratings',0,0);
	setObjectCamera('ratings','hud');
	scaleObject('ratings',0.6,0.6);
	
	--animations, this adds animations to the rating object so it can actually change ratings
	
	addAnimationByPrefix('ratings','PLUS','PLUS',24,false);
	addAnimationByPrefix('ratings','S','S',24,false);
	addAnimationByPrefix('ratings','A','A',24,false);
	addAnimationByPrefix('ratings','B','B',24,false);
	addAnimationByPrefix('ratings','C','C',24,false);
	addAnimationByPrefix('ratings','D','D',24,false);
	addAnimationByPrefix('ratings','E','E',24,false);
	addAnimationByPrefix('ratings','F','F',24,false);
	addAnimationByPrefix('ratings','?','?',24,false);
	
	--plays the ? animation when there's no rating
	playAnim('ratings','?',false)
	
end

--changes the rating, and it bops to the beat too
function onUpdate()
	--S+ rating code
    if rating >= 1 then
		function onBeatHit()
			if curBeat % 2 == 0 then
				playAnim('ratings','PLUS',false)
		end
	end
	--S rating code
	
    elseif rating >= 0.98 then
		function onBeatHit()
			if curBeat % 2 == 0 then
				playAnim('ratings','S',false)
		end
	end
	--A rating code
	
    elseif rating >= 0.90 then
		function onBeatHit()
			if curBeat % 2 == 0 then
				playAnim('ratings','A',false)
		end
	end
	--B rating code
	
    elseif rating >= 0.80 then
		function onBeatHit()
			if curBeat % 2 == 0 then
				playAnim('ratings','B',false)
		end
	end
	--C rating code
	
    elseif rating >= 0.70 then
		function onBeatHit()
			if curBeat % 2 == 0 then
				playAnim('ratings','C',false)
		end
	end
	--D rating code
	
    elseif rating >= 0.50 then
		function onBeatHit()
			if curBeat % 2 == 0 then
				playAnim('ratings','D',false)
		end
	end
	--E rating code
	
    elseif rating >= 0.21 then
		function onBeatHit()
			if curBeat % 2 == 0 then
				playAnim('ratings','E',false)
		end
	end
	--F rating code
	
    elseif rating <= 0.20 and ratings.animation ~= '?' then
		function onBeatHit()
			if curBeat % 2 == 0 then
				playAnim('ratings','F',false)
		end
	end
end
end

function onCreate() end
function onStartCountdown() end
function onCountdownStarted() end
function onCountdownTick(swagCounter) end
function onUpdateScore() end
function onNextDialogue(line) end
function onSkipDialogue(line) end
function onSongStart() end
function eventEarlyTrigger(name) end
function onResume() end
function onPause() end
function onSpawnNote(id, dir, type, sustain) end
function onUpdatePost(elapsed) end
function onGameOver() end
function onEvent(event, value1, value2) end
function onMoveCamera(target) end
function onEndSong() end
function onGhostTap(key) end
function onKeyPress(key) end
function onKeyRelease(key) end
function noteMiss(id, dir, type, sustain) end
function noteMissPress(dir) end
function opponentNoteHit(id, dir, type, sustain) end
function goodNoteHit(id, dir, type, sustain) end
function onStepHit() end
function onSectionHit() end
function onRecalculateRating() end
function onTweenCompleted(tag) end
function onSoundFinished(tag) end
function onTimerCompleted(tag, loops, loops_left) end
function onCustomSubstateCreate(name) end
function onCustomSubstateCreatePost(name) end
function onCustomSubstateUpdate(name, elapsed) end
function onCustomSubstateUpdatePost(name, elapsed) end
function onCustomSubstateDestroy(name) end
function onDestroy() end