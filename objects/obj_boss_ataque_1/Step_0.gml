/// @description Inserir descrição aqui
if (global.pause){
	image_speed = 0;
	exit;
}else{
	image_speed = 1;
}
if fim_da_animacao(){
	var _dir = 0;
	
	repeat(4){
		var _inst = instance_create_layer(x, y, "Instances", obj_boss_projetil);
		_inst.speed = 3;
		_inst.direction = _dir;
		
		_dir += 90;
	}
	instance_destroy();
}