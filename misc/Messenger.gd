extends Node

# Levels
signal enemy_gets_jumped(enemy_type)
signal player_forbidden_touch
signal player_change_to_win_state
signal win_stage(stage_id)
signal all_tangible_enemies_dead
signal key_acquired(key_group)

# Stage select
signal player_chose_menu
signal player_chose_state(stage_id)
signal player_selecting_level
signal player_stop_selecting_level
signal player_chose_level(stage, level)

# Bouncy head
signal bouncy_head_got_jumped
