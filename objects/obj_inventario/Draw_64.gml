/// @description Inserir descrição aqui
var _guil = display_get_gui_width();
var _guia = display_get_gui_height();

var _mx = device_mouse_x_to_gui(0);
var _my = device_mouse_y_to_gui(0);

if inventario == true{
	var _invx = _guil/2 - inventario_l/2;
	var _invy = _guia/2 - inventario_a/2;
	
	draw_sprite_ext(spr_inventario, 0, _invx * 1, _invy * 1, escala, escala, 0, c_white, 1);
	
	var ix = 0;
	var iy = 0;
	for (var i = 0; i <total_slots; i++){
		var _slotsx = _invx + comeco_x + ((tamanho_slot + buffer) * ix);
		var _slotsy = _invy + comeco_y + ((tamanho_slot + buffer) * iy);
		
		if point_in_rectangle(_mx, _my, _slotsx, _slotsy, _slotsx + tamanho_slot, _slotsy + tamanho_slot){
			draw_sprite_ext(spr_inventario_seletor, 0, _slotsx, _slotsy, escala, escala, 0, c_white, 1);
			
			if keyboard_check_pressed(ord("F")) and grid_items[# Infos.Item, i] != -1{
				var _inst = instance_create_layer(obj_personagem.x, obj_personagem.y, "Instances", obj_item);
				_inst.sprite_index = grid_items[# Infos.Sprite, i];
				_inst.image_index = grid_items[# Infos.Item, i];
				_inst.quantidade = grid_items[# Infos.Quantidade, i];
				
				grid_items[# Infos.Item, i] = -1;	
				grid_items[# Infos.Quantidade, i] = -1;
				grid_items[# Infos.Sprite, i] = -1;
			}
			
			if mouse_check_button_pressed(mb_left){
				//nenhum item
				if item_selecionado = -1{
					item_selecionado = grid_items[# Infos.Item, i];
					pos_selecionada = i;
				}//Já tem um item 
				else{
					//item igual
					if item_selecionado == grid_items[# Infos.Item, i] and pos_selecionada !=i and grid_items[# Infos.Sprite, i] == grid_items[# Infos.Sprite, pos_selecionada]{
						grid_items[# Infos.Quantidade, i] += grid_items[# Infos.Quantidade, pos_selecionada];
						
						grid_items[# Infos.Item, pos_selecionada] = -1;
						grid_items[# Infos.Quantidade, pos_selecionada] = -1;
						item_selecionado = -1;
						pos_selecionada = -1;
					}
					//slot vazio
					else if grid_items[# Infos.Item, i] == -1{
						grid_items[# Infos.Item, i] = grid_items[# Infos.Item, pos_selecionada];
						grid_items[# Infos.Quantidade, i] = grid_items[# Infos.Quantidade, pos_selecionada];
						grid_items[# Infos.Sprite, i] = grid_items[# Infos.Sprite, pos_selecionada];
						
						grid_items[# Infos.Item, pos_selecionada] = -1;
						grid_items[# Infos.Quantidade, pos_selecionada] = -1;
						grid_items[# Infos.Sprite, pos_selecionada] = -1;
						item_selecionado = -1;
						pos_selecionada = -1;
					}
					//trocar posição
					else if grid_items[# Infos.Item, pos_selecionada] != grid_items[# Infos.Item, i] or grid_items[# Infos.Sprite, pos_selecionada] != grid_items[# Infos.Sprite, i]{
						var _item = grid_items[# Infos.Item, i];
						var _quantidade = grid_items[# Infos.Quantidade, i];
						var _spr = grid_items[# Infos.Sprite, i];
						
						grid_items[# Infos.Item, i] = grid_items[# Infos.Item, pos_selecionada];
						grid_items[# Infos.Quantidade, i] = grid_items[# Infos.Quantidade, pos_selecionada];
						grid_items[# Infos.Sprite, i] = grid_items[# Infos.Sprite, pos_selecionada];
						
						grid_items[# Infos.Item, pos_selecionada] = _item;
						grid_items[# Infos.Quantidade, pos_selecionada] = _quantidade;
						grid_items[# Infos.Sprite, pos_selecionada] = _spr;
						
						item_selecionado = -1;
						pos_selecionada = -1;
					}
				}
			}
		}
		
		var _sprite = grid_items[# Infos.Sprite, i];
		
		if grid_items[# Infos.Item, i] != -1{
			draw_sprite_ext(_sprite, grid_items[# 0, i], _slotsx, _slotsy, escala, escala, 0, c_white, 1);
			
			draw_set_font(fnt_dano);
			draw_set_halign(fa_center);
			draw_text_colour_outline(_slotsx + tamanho_slot, _slotsy + tamanho_slot - 8, grid_items[# Infos.Quantidade, i], 4, c_black, 16, 100, 100);
		}
		
		ix++;
		if ix >= slots_h{
			ix = 0;
			iy++;
		}
	}
	
	if mouse_check_button_pressed(mb_right){
		item_selecionado = -1;
		pos_selecionada = -1;
	}
	
	if item_selecionado != -1{
		draw_sprite_ext(grid_items[# Infos.Sprite, pos_selecionada], item_selecionado, _mx, _my, escala, escala, 0, c_white, 0.5);
	}
}