/// @description Insert description here
// You can write your code in this editor

if(canSpawn && (spawnTimer >= spawnDelay ) && (unitToSpawn != -1))
{
	with (instance_create_layer(x, y, "Instances", global.units[| unitToSpawn][? UNIT_DEFINITION.UNIT]))
	{
		spawner = other.id;
	}
	canSpawn = false;
	spawnTimer = 0;
}
else if(canSpawn)
{
	spawnTimer++;
}