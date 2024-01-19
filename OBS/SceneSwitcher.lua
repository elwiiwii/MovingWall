local obs = obslua
local hotkey_id = obs.OBS_INVALID_HOTKEY_ID
local scene_names = {"Wall 1", "Wall 2"}
local current_scene = 1
local scenes = {}

function script_description()
	return "Switches between two scenes using a hotkey."
end

function switch_scenes(pressed)
	if not pressed then
		return
	end

	current_scene = current_scene % #scene_names + 1
	obs.obs_frontend_set_current_scene(scenes[current_scene])
end

function script_load(settings)
	hotkey_id = obs.obs_hotkey_register_frontend("Scene_Switcher", "Switch Scenes", switch_scenes)
	local hotkey_save_array = obs.obs_data_get_array(settings, "Scene_Switcher")
	obs.obs_hotkey_load(hotkey_id, hotkey_save_array)
	obs.obs_data_array_release(hotkey_save_array)

	local all_scenes = obs.obs_frontend_get_scenes()
	for i, scene in ipairs(all_scenes) do
		local name = obs.obs_source_get_name(scene)
		for j, scene_name in ipairs(scene_names) do
			if name == scene_name then
				scenes[j] = scene
			end
		end
	end
	obs.source_list_release(all_scenes)
end

function script_save(settings)
	local hotkey_save_array = obs.obs_hotkey_save(hotkey_id)
	obs.obs_data_set_array(settings, "scene_switcher", hotkey_save_array)
	obs.obs_data_array_release(hotkey_save_array)
end
