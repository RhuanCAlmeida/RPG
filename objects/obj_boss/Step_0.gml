/// @description Inserir descrição aqui
if (global.pause){
	image_speed = 0;
	exit;
}else{
	image_speed = 1;
}
script_execute(estado);
if vida <= 0{
	instance_destroy();
}