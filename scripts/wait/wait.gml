// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function wait(millis, wait_id){
	if (waitTime <= 0){
		if(wait_id != waitTarget && waiting = false){
			waitTime = millis;
			waitTarget = wait_id;
			waiting = true;
			show_debug_message(wait_id);
		}else{
			waiting = false;
			return false;
		}
		
	}
	if(waitTime >= 0){
		waitTime -= delta_time / 1000;
		return true;
	}
	return false;
}