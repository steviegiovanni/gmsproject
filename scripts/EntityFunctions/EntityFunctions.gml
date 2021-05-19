// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function EntityHitDestroy()
{
	instance_destroy();
}

function EntityHitSolid()
{
	flash = 0.5;
}

function ResetSpawner()
{
	if(instance_exists(spawner))
	{
		spawner.canSpawn = true;
		spawner.spawnTimer = 0;
	}
}