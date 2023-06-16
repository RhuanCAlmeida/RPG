/// @description Inserir descrição aqui
var _dano = obj_personagem.dano[obj_personagem.level];
var _dir = point_direction(x, y, other.x, other.y);

other.empurrar_dir = _dir;
other.empurrar_veloc = 6;
other.hit = true;
other.alarm[1] = 5;
other.estado = scr_slime_hit;
other.vida -= _dano;

var _inst = instance_create_layer(x, y, "Instances", obj_dano);
_inst.alvo = other;
_inst.dano = obj_personagem.dano[obj_personagem.level];

instance_destroy();