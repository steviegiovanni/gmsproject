/// @description essential entity setup
z = 0;
flash = 0;
uFlash = shader_get_uniform(shWhiteFlash, "flash");

// get current tilemap
collisionMap = layer_tilemap_get_id(layer_get_id("Col"));

// spawner parameters
spawner = noone;
