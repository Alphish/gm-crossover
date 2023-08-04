draw_set_font(fnt_Score);
draw_set_alpha(1);

draw_set_color(#40a0ff);
draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_text(40, 40, string(left));

draw_set_color(#ffa040);
draw_set_halign(fa_right);
draw_set_valign(fa_bottom);
draw_text(room_width - 40, room_height - 40, string(right));
