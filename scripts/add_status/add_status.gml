/// @function add_status(_card, _icon, _x_rel, _y_rel)
function add_status(_card, _icon, _x_rel, _y_rel){
	with(_card){
		var inst = instance_create_layer(x, y, "Effects", _icon)
		inst.card_parent = _card;
		inst.x_rel = _x_rel;
		inst.y_rel = _y_rel;
	}
}