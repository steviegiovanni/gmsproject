NineSliceBoxStretched(sTextboxBg, x1, y1, x2, y2, background);
draw_set_font(fText);
draw_set_halign(fa_center);
draw_set_valign(fa_top);
draw_set_color(c_black);

var _print = string_copy(textMessage, 1, textProgress);
draw_text((x1 + x2) / 2, (y1 + 8), _print);
draw_set_color(c_white);
draw_text((x1 + x2) / 2, (y1 + 7), _print);
