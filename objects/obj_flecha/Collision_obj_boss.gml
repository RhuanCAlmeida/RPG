/// @description Inserir descrição aqui
var _dano = obj_personagem.dano[obj_personagem.level];

other.hit = true;
other.alarm[1] = 5;
other.vida -= _dano;

var _inst = instance_create_layer(x, y, "Instances", obj_dano);
_inst.alvo = other;
_inst.dano = obj_personagem.dano[obj_personagem.level];

instance_destroy();