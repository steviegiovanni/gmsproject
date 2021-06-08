if(global.debug)
{
	draw_set_alpha(1);
	draw_set_color(c_white);
	draw_set_font(fDebugText);
	draw_set_halign(fa_center);
	draw_set_valign(fa_middle);
	draw_text(x, y - sprite_get_height(sprite_index) / 2, UnitStateToString(state));
}
