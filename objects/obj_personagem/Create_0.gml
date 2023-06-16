event_inherited();

enum Armas{
	Espada,
	Arco,
	Altura
}

//movimentação
direita = -1;
cima = -1;
esquerda = -1;
baixo = -1;

hveloc = 0;
vveloc = 0;

veloc_dir = -1;

veloc = 2;

dir = 0;

//dash
dash_dir = -1;
dash_veloc = 6;

//estado
estado = scr_personagem_andando;

//combate
level = 1;
xp = 0;
max_xp[1] = 100;
max_xp[2] = 130;
max_xp[3] = 150;
max_xp[4] = 200;
max_xp[5] = 250;

max_estamina[1] = 100;
max_estamina[2] = 115;
max_estamina[3] = 130;
max_estamina[4] = 160;
max_estamina[5] = 180;
estamina = max_estamina[level];

max_vida[1] = 20;
max_vida[2] = 30;
max_vida[3] = 50;
max_vida[4] = 75;
max_vida[5] = 85;

vida = max_vida[level];

tomardano = true; 
empurrar_dir = 0;

dano[1] = 1;
dano[2] = 2;
dano[3] = 5;
dano[4] = 7;
dano[5] = 10;

atacar = false;

dano_alfa = -1;

arma = 0;