require('mobdebug').start();
local treasureng = RegisterMod("Treasureless NG", 2);

visited_t = false;
is_started = false;
local rng = RNG();

item_pool = {116, 247, 250, 260, 246, 337, 356, 208, 402, 372, 416, 204, 156, 248, 203, 252, 195, 199, 139,
  414, 425, 75, 380, 227, 376, 424, 205, 403, 251, 64, 232, 63, 21, 60, 249, 54};

stage = 0;

function treasureng:text_render( )
  Isaac.RenderText("Treasureless NG v0.0.4.1", 50, 15, 255, 255, 255, 255);
end

function treasureng:activate_treasureless( )
  game = Game();
  local player = game:GetPlayer(0);
  floor = game:GetLevel();
  stage = floor:GetAbsoluteStage();
  
  if stage == 1 and is_started == false then
    Isaac.DebugString("is_started");
    is_started = true;
    visited_t = false;
  end

  if stage < floor:GetAbsoluteStage() then
    Isaac.DebugString("is_new_stage");
    stage = floor:GetAbsoluteStage();

    if visited_t == false then
      player:AddCollectible(item_pool[rng:RandomInt(#item_pool)], 0, true);
    end

    visited_t = false;
  end

  local room = game:GetRoom();

  if room:GetType() == RoomType.ROOM_TREASURE and visited_t == false then
      Isaac.DebugString("is_in_treasure");
      visited_t = true;
  end
end

treasureng:AddCallback( ModCallbacks.MC_POST_RENDER, treasureng.text_render );
treasureng:AddCallback( ModCallbacks.MC_POST_UPDATE, treasureng.activate_treasureless );
