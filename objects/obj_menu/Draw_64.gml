draw_set_font(ft_menu);
var gui_width = display_get_gui_width();
var gui_heigth = display_get_gui_height();
var x1 = gui_width /2;
var y1 = gui_heigth /2;
var margin = 50;
var m_x = device_mouse_x_to_gui(0);
var m_y = device_mouse_y_to_gui(0);

draw_set_halign(fa_center);
draw_set_valign(fa_center);

for(var i = 0; i < op_max;i++){
	var y2 = y1 + (margin * i);
	var string_w = string_width(options[i]);
	var string_h = string_height(options[i]);
	
	if (point_in_rectangle(m_x, m_y, x1 - string_w/2, y2 -string_h/2, x1 + string_w /2, y2 + string_h /2)){
		draw_set_color(c_red);
		index = i;
		if(keyboard_check_pressed(vk_enter)){
			if(index == 1){
				game_end();
			}
		}
		if(keyboard_check_pressed(vk_enter)){
			if(index == 0){
				room_goto(Room1)
			}
		}
	}else{
		draw_set_color(c_white);
	}
	
	draw_text(x1, y2, options[i]);
}