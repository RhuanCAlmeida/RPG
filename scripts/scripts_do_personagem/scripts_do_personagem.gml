function scr_personagem_colisao(){
 if place_meeting(x + hveloc, y, obj_parede){
	while !place_meeting(x + sign(hveloc), y, obj_parede){
		x += sign(hveloc);
	}
	
	hveloc = 0;

}

x += hveloc;



if place_meeting(x, y + vveloc, obj_parede){
	while !place_meeting(x, y + sign(vveloc), obj_parede){
		y += sign(vveloc);
	}
	vveloc = 0;
}

y += vveloc;
 }
	 
function scr_personagem_andando(){
	gamepad_set_axis_deadzone(global.controle, 0.25);
	//movimentação
		direita = keyboard_check(ord("D")) or gamepad_axis_value(global.controle, gp_axislh) > 0.25;
		cima = keyboard_check(ord("W")) or gamepad_axis_value(global.controle, gp_axislv) < -0.25;
		esquerda = keyboard_check(ord("A")) or gamepad_axis_value(global.controle, gp_axislh) < -0.25;
		baixo = keyboard_check(ord("S")) or gamepad_axis_value(global.controle, gp_axislv) > 0.25;

hveloc = (direita - esquerda);
vveloc = (baixo - cima);

veloc_dir = point_direction(x, y, x + hveloc, y + vveloc);

	if hveloc != 0 or vveloc != 0{
		veloc = 2;
	}else{
		veloc = 0;
	}
	

	hveloc = lengthdir_x(veloc, veloc_dir);
	vveloc = lengthdir_y(veloc, veloc_dir);

scr_personagem_colisao();


//mudar as sprites
if gamepad_is_connected(global.controle){
	if gamepad_axis_value(global.controle, gp_axislh) != 0 or gamepad_axis_value(global.controle, gp_axislv){
	dir = floor ((point_direction(x, y, x + gamepad_axis_value(global.controle, gp_axislh), y + gamepad_axis_value(global.controle, gp_axislv)) + 45)/90);
	}
}else{
dir = floor((point_direction(x, y, mouse_x, mouse_y) + 45)/90);
}
if hveloc == 0 and vveloc == 0{
	switch dir{
		default:
			sprite_index = spr_personagem_parado_direita;
		break;
		case 1:
			sprite_index = spr_personagem_parado_cima
		break;
		case 2:
			sprite_index = spr_personagem_parado_esquerda
		break;
		case 3:
			sprite_index = spr_personagem_parado_baixo
		break;
	}
	}else{
		switch dir{
				default:
					sprite_index = spr_personagem_correndo_direita;
				break;
				case 1:
					sprite_index = spr_personagem_correndo_cima
				break;
				case 2:
					sprite_index = spr_personagem_correndo_esquerda
				break;
				case 3:
					sprite_index = spr_personagem_correndo_baixo
				break;
			}
	 }
	
	 if estamina >= 10{
		 if mouse_check_button_pressed(mb_right) or gamepad_button_check_pressed(global.controle, gp_face1){
			 estamina -= 10;
			 alarm[1] = 180;
			 alarm[0] = 8;
			 if gamepad_is_connected(global.controle){
				if gamepad_axis_value(global.controle, gp_axislh) != 0 or gamepad_axis_value(global.controle, gp_axislv){
					dash_dir = point_direction(x, y, x + gamepad_axis_value(global.controle, gp_axislh), y + gamepad_axis_value(global.controle, gp_axislv));
					}
				}else{
					dash_dir = point_direction(x, y, mouse_x, mouse_y);
			}
			 estado = scr_personagem_dash;
		 }
	}
	
	if mouse_check_button(mb_left) or gamepad_button_check_pressed(global.controle, gp_face2){

		if arma == Armas.Espada{
			image_index = 0;
			switch dir{
				//direita
				default :
					sprite_index = spr_personagem_atacando_direita;

				break;
				//cima
				case 1:
					sprite_index = spr_personagem_atacando_cima;

				break;
				//esquerda
				case 2:
					sprite_index = spr_personagem_atacando_esquerda;

				break;
				//baixo
				case 3:
					sprite_index = spr_personagem_atacando_baixo;
				break;
			}
			estado = scr_personagem_atacando;
		}else if arma == Armas.Arco{
			image_index = 0;
			
			estado = scr_personagem_arco;
		}
	}
} 

function scr_personagem_dash(){
	tomardano = false;
	hveloc = lengthdir_x(dash_veloc, dash_dir); 
	vveloc = lengthdir_y(dash_veloc, dash_dir);
	
	scr_personagem_colisao();
	
	var _inst = instance_create_layer(x, y, "Instances", obj_dash);
	_inst.sprite_index = sprite_index;
}
function scr_personagem_atacando(){
	if image_index >=1{
		if atacar == false{
			switch dir{
				//Direita
				default:
					instance_create_layer(x + 10, y, "Instances", obj_personagem_hitbox);
				break;
				//Cima
				case 1 :
					instance_create_layer(x, y - 10, "Instances", obj_personagem_hitbox);
				break;
				//Esquerda
				case 2:
					instance_create_layer(x - 10, y, "Instances", obj_personagem_hitbox);
				break;
				//Baixo
				case 3:
					instance_create_layer(x, y + 10, "Instances", obj_personagem_hitbox);
				break;
				
			}
			atacar = true;
		}
	}

	if fim_da_animacao(){
		estado = scr_personagem_andando;
		atacar = false;
	}
}

function scr_personagem_hit(){
	if alarm[2] > 0{
	hveloc = lengthdir_x(3, empurrar_dir);
	vveloc = lengthdir_y(3, empurrar_dir);
	
	scr_personagem_colisao();
	}else{
		estado = scr_personagem_andando;
	}
}
	
function scr_personagem_arco(){
	dir = floor((point_direction(x, y, mouse_x, mouse_y) + 45)/90);
	
	switch dir{
		//direita
		default:
			sprite_index = spr_personagem_arco_direita;
		break;
		//cima
		case 1:
			sprite_index = spr_personagem_arco_cima;
		break;
		//esquerda
		case 2:
			sprite_index = spr_personagem_arco_esquerda;
		break;
		//baixo
		case 3:
			sprite_index = spr_personagem_arco_baixo;
		break;
	}
	if fim_da_animacao(){
		image_index = 4;
	}
	
	if mouse_check_button_released(mb_left){
		if image_index >=4{
			var _dir = point_direction(x, y, mouse_x, mouse_y);
			var _xx = lengthdir_x(5, _dir);
			var _yy = lengthdir_y(5, _dir);
			
			var _inst = instance_create_layer(x + _xx, y + _yy, "Instances", obj_flecha);
			_inst.direction = _dir;
			_inst.image_angle = _dir;
			_inst.speed = 12;
			
			empurrar_dir = point_direction(mouse_x, mouse_y, x, y);
			alarm[2] = 5;
			estado = scr_personagem_hit;
			
			
		}else{
			estado = scr_personagem_andando;
		}
	}
}
	
