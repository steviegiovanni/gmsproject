state = PlayerStateFree;
stateAttack = AttackSlash;
lastState = state;

collisionMap = layer_tilemap_get_id(layer_get_id("Col"));

image_speed = 0;
hSpeed = 0;
vSpeed = 0;
speedWalk = 2.0;
speedRoll = 3.0;
distanceRoll = 52;
distanceBonk = 40;
distanceBonkHeight = 12;
speedBonk = 1.5;
z = 0;

spriteIdle = Sprite1;
spriteRun = Sprite1_Walk;
spriteRoll = Sprite1_Roll;
localFrame = 0;


