; HEADER_BLOCK_START
; BambuStudio 02.07.01.62
; model printing time: 16m 9s; total estimated time: 24m 13s
; total layer number: 49
; total filament length [mm] : 380.29
; total filament volume [cm^3] : 914.72
; total filament weight [g] : 1.13
; filament_density: 1.24
; filament_diameter: 1.75
; max_z_height: 5.96
; filament: 1
; HEADER_BLOCK_END

; CONFIG_BLOCK_START
; accel_to_decel_enable = 0
; accel_to_decel_factor = 50%
; activate_air_filtration = 0
; additional_cooling_fan_speed = 70
; additional_fan_full_speed_layer = 0
; alternate_extra_wall = 0
; apply_scarf_seam_on_circles = 1
; auxiliary_fan = 0
; avoid_crossing_wall_includes_support = 0
; bed_custom_model = 
; bed_custom_texture = 
; bed_exclude_area = 
; bed_temperature_formula = by_first_filament
; before_layer_change_gcode = 
; best_object_pos = 0.7,0.5
; bottom_color_penetration_layers = 5
; bottom_shell_layers = 5
; bottom_shell_thickness = 0
; bottom_surface_density = 100%
; bottom_surface_pattern = monotonic
; bridge_angle = 0
; bridge_flow = 1
; bridge_no_support = 0
; bridge_speed = 50
; brim_object_gap = 0.2
; brim_type = no_brim
; brim_width = 0
; chamber_temperatures = 0
; change_filament_gcode = ;===== A1mini 20251031 =====\nG392 S0\nM1007 S0\nM620 S[next_extruder]A\nM204 S9000\nG1 Z{max_layer_z + 3.0} F1200\n\nM400\nM106 P1 S0\nM106 P2 S0\n{if old_filament_temp > 142 && next_extruder < 255}\nM104 S[old_filament_temp]\n{endif}\n\nG1 X180 F18000\n\n{if long_retractions_when_cut[previous_extruder]}\nM620.11 S1 I[previous_extruder] E-{retraction_distances_when_cut[previous_extruder]} F1200\n{else}\nM620.11 S0\n{endif}\nM400\n\nM620.1 E F{flush_volumetric_speeds[previous_extruder]/2.4053*60} T{flush_temperatures[previous_extruder]}\nM620.10 A0 F{flush_volumetric_speeds[previous_extruder]/2.4053*60}\nT[next_extruder]\nM620.1 E F{flush_volumetric_speeds[next_extruder]/2.4053*60} T{flush_temperatures[next_extruder]}\nM620.10 A1 F{flush_volumetric_speeds[next_extruder]/2.4053*60} L[flush_length] H[nozzle_diameter] T{flush_temperatures[next_extruder]}\n\nG1 Y90 F9000\n\n{if next_extruder < 255}\n\n{if long_retractions_when_cut[previous_extruder]}\nM620.11 S1 I[previous_extruder] E{retraction_distances_when_cut[previous_extruder]} F{flush_volumetric_speeds[previous_extruder]/2.4053*60}\nM628 S1\nG92 E0\nG1 E{retraction_distances_when_cut[previous_extruder]} F{flush_volumetric_speeds[previous_extruder]/2.4053*60}\nM400\nM629 S1\n{else}\nM620.11 S0\n{endif}\n\nM400\nG92 E0\nM628 S0\n\n{if flush_length_1 > 1}\n; FLUSH_START\n; always use highest temperature to flush\nM400\nM1002 set_filament_type:UNKNOWN\nM109 S[flush_temperatures[next_extruder]]\nM106 P1 S60\n{if flush_length_1 > 23.7}\nG1 E23.7 F{flush_volumetric_speeds[previous_extruder]/2.4053*60} ; do not need pulsatile flushing for start part\nG1 E{(flush_length_1 - 23.7) * 0.02} F50\nG1 E{(flush_length_1 - 23.7) * 0.23} F{flush_volumetric_speeds[previous_extruder]/2.4053*60}\nG1 E{(flush_length_1 - 23.7) * 0.02} F50\nG1 E{(flush_length_1 - 23.7) * 0.23} F{flush_volumetric_speeds[next_extruder]/2.4053*60}\nG1 E{(flush_length_1 - 23.7) * 0.02} F50\nG1 E{(flush_length_1 - 23.7) * 0.23} F{flush_volumetric_speeds[next_extruder]/2.4053*60}\nG1 E{(flush_length_1 - 23.7) * 0.02} F50\nG1 E{(flush_length_1 - 23.7) * 0.23} F{flush_volumetric_speeds[next_extruder]/2.4053*60}\n{else}\nG1 E{flush_length_1} F{flush_volumetric_speeds[previous_extruder]/2.4053*60}\n{endif}\n; FLUSH_END\nG1 E-[old_retract_length_toolchange] F1800\nG1 E[old_retract_length_toolchange] F300\nM400\nM1002 set_filament_type:{filament_type[next_extruder]}\n{endif}\n\n{if flush_length_1 > 45 && flush_length_2 > 1}\n; WIPE\nM400\nM106 P1 S178\nM400 S3\nG1 X-3.5 F18000\nG1 X-13.5 F3000\nG1 X-3.5 F18000\nG1 X-13.5 F3000\nG1 X-3.5 F18000\nG1 X-13.5 F3000\nM400\nM106 P1 S0\n{endif}\n\n{if flush_length_2 > 1}\nM106 P1 S60\n; FLUSH_START\nG1 E{flush_length_2 * 0.18} F{flush_volumetric_speeds[next_extruder]/2.4053*60}\nG1 E{flush_length_2 * 0.02} F50\nG1 E{flush_length_2 * 0.18} F{flush_volumetric_speeds[next_extruder]/2.4053*60}\nG1 E{flush_length_2 * 0.02} F50\nG1 E{flush_length_2 * 0.18} F{flush_volumetric_speeds[next_extruder]/2.4053*60}\nG1 E{flush_length_2 * 0.02} F50\nG1 E{flush_length_2 * 0.18} F{flush_volumetric_speeds[next_extruder]/2.4053*60}\nG1 E{flush_length_2 * 0.02} F50\nG1 E{flush_length_2 * 0.18} F{flush_volumetric_speeds[next_extruder]/2.4053*60}\nG1 E{flush_length_2 * 0.02} F50\n; FLUSH_END\nG1 E-[new_retract_length_toolchange] F1800\nG1 E[new_retract_length_toolchange] F300\n{endif}\n\n{if flush_length_2 > 45 && flush_length_3 > 1}\n; WIPE\nM400\nM106 P1 S178\nM400 S3\nG1 X-3.5 F18000\nG1 X-13.5 F3000\nG1 X-3.5 F18000\nG1 X-13.5 F3000\nG1 X-3.5 F18000\nG1 X-13.5 F3000\nM400\nM106 P1 S0\n{endif}\n\n{if flush_length_3 > 1}\nM106 P1 S60\n; FLUSH_START\nG1 E{flush_length_3 * 0.18} F{flush_volumetric_speeds[next_extruder]/2.4053*60}\nG1 E{flush_length_3 * 0.02} F50\nG1 E{flush_length_3 * 0.18} F{flush_volumetric_speeds[next_extruder]/2.4053*60}\nG1 E{flush_length_3 * 0.02} F50\nG1 E{flush_length_3 * 0.18} F{flush_volumetric_speeds[next_extruder]/2.4053*60}\nG1 E{flush_length_3 * 0.02} F50\nG1 E{flush_length_3 * 0.18} F{flush_volumetric_speeds[next_extruder]/2.4053*60}\nG1 E{flush_length_3 * 0.02} F50\nG1 E{flush_length_3 * 0.18} F{flush_volumetric_speeds[next_extruder]/2.4053*60}\nG1 E{flush_length_3 * 0.02} F50\n; FLUSH_END\nG1 E-[new_retract_length_toolchange] F1800\nG1 E[new_retract_length_toolchange] F300\n{endif}\n\n{if flush_length_3 > 45 && flush_length_4 > 1}\n; WIPE\nM400\nM106 P1 S178\nM400 S3\nG1 X-3.5 F18000\nG1 X-13.5 F3000\nG1 X-3.5 F18000\nG1 X-13.5 F3000\nG1 X-3.5 F18000\nG1 X-13.5 F3000\nM400\nM106 P1 S0\n{endif}\n\n{if flush_length_4 > 1}\nM106 P1 S60\n; FLUSH_START\nG1 E{flush_length_4 * 0.18} F{flush_volumetric_speeds[next_extruder]/2.4053*60}\nG1 E{flush_length_4 * 0.02} F50\nG1 E{flush_length_4 * 0.18} F{flush_volumetric_speeds[next_extruder]/2.4053*60}\nG1 E{flush_length_4 * 0.02} F50\nG1 E{flush_length_4 * 0.18} F{flush_volumetric_speeds[next_extruder]/2.4053*60}\nG1 E{flush_length_4 * 0.02} F50\nG1 E{flush_length_4 * 0.18} F{flush_volumetric_speeds[next_extruder]/2.4053*60}\nG1 E{flush_length_4 * 0.02} F50\nG1 E{flush_length_4 * 0.18} F{flush_volumetric_speeds[next_extruder]/2.4053*60}\nG1 E{flush_length_4 * 0.02} F50\n; FLUSH_END\n{endif}\n\nM629\n\nM400\nM106 P1 S60\nM109 S[new_filament_temp]\nG1 E5 F{flush_volumetric_speeds[next_extruder]/2.4053*60} ;Compensate for filament spillage during waiting temperature\nM400\nG92 E0\nG1 E-[new_retract_length_toolchange] F1800\nM400\nM106 P1 S178\nM400 S3\nG1 X-3.5 F18000\nG1 X-13.5 F3000\nG1 X-3.5 F18000\nG1 X-13.5 F3000\nG1 X-3.5 F18000\nG1 X-13.5 F3000\nG1 X-3.5 F18000\nG1 X-13.5 F3000\nM400\nG1 Z{max_layer_z + 3.0} F3000\nM106 P1 S0\n{if layer_z <= (initial_layer_print_height + 0.001)}\nM204 S[initial_layer_acceleration]\n{else}\nM204 S[default_acceleration]\n{endif}\n{else}\nG1 X[x_after_toolchange] Y[y_after_toolchange] Z[z_after_toolchange] F12000\n{endif}\n\nM622.1 S0\nM9833 F{outer_wall_volumetric_speed/2.4} A0.3 ; cali dynamic extrusion compensation\nM1002 judge_flag filament_need_cali_flag\nM622 J1\n  G92 E0\n  G1 E-[new_retract_length_toolchange] F1800\n  M400\n  \n  M106 P1 S178\n  M400 S7\n  G1 X0 F18000\n  G1 X-13.5 F3000\n  G1 X0 F18000 ;wipe and shake\n  G1 X-13.5 F3000\n  G1 X0 F12000 ;wipe and shake\n  G1 X-13.5 F3000\n  G1 X0 F12000 ;wipe and shake\n  M400\n  M106 P1 S0 \nM623\n\nM621 S[next_extruder]A\nG392 S0\n\nM1007 S1\n
; circle_compensation_manual_offset = 0
; circle_compensation_speed = 200
; close_additional_fan_first_x_layers = 1
; close_fan_the_first_x_layers = 1
; compatible_printers_condition = 
; complete_print_exhaust_fan_speed = 70
; cool_plate_temp = 30
; cool_plate_temp_initial_layer = 30
; cooling_filter_enabled = 0
; cooling_perimeter_transition_distance = 10
; cooling_slowdown_logic = uniform_cooling
; counter_coef_1 = 0
; counter_coef_2 = 0.008
; counter_coef_3 = -0.041
; counter_limit_max = 0.033
; counter_limit_min = -0.035
; curr_bed_type = Textured PEI Plate
; default_acceleration = 6000
; default_filament_colour = ""
; default_filament_profile = "Bambu PLA Basic @BBL A1M"
; default_jerk = 0
; default_nozzle_volume_type = Standard
; default_print_profile = 0.20mm Standard @BBL A1M
; deretraction_speed = 30
; detect_floating_vertical_shell = 1
; detect_narrow_internal_solid_infill = 1
; detect_overhang_wall = 1
; detect_thin_wall = 0
; diameter_limit = 50
; different_settings_to_system = enable_prime_tower;;
; draft_shield = disabled
; during_print_exhaust_fan_speed = 70
; elefant_foot_compensation = 0
; embedding_wall_into_infill = 0
; enable_arc_fitting = 0
; enable_circle_compensation = 0
; enable_filament_dynamic_map = 0
; enable_height_slowdown = 0
; enable_long_retraction_when_cut = 2
; enable_mixed_color_sublayer = 0
; enable_order_independent_overlap_carving = 0
; enable_overhang_bridge_fan = 1
; enable_overhang_speed = 1
; enable_pre_heating = 0
; enable_pressure_advance = 0
; enable_prime_tower = 0
; enable_support = 1
; enable_support_ironing = 0
; enable_tower_interface_features = 0
; enable_wrapping_detection = 0
; enforce_support_layers = 0
; eng_plate_temp = 30
; eng_plate_temp_initial_layer = 30
; ensure_vertical_shell_thickness = enabled
; exclude_object = 1
; extruder_ams_count = 
; extruder_clearance_dist_to_rod = 56.5
; extruder_clearance_height_to_lid = 180
; extruder_clearance_height_to_rod = 25
; extruder_clearance_max_radius = 73
; extruder_colour = #018001
; extruder_max_nozzle_count = 1
; extruder_nozzle_stats = 
; extruder_offset = 0x0
; extruder_printable_area = 
; extruder_type = Direct Drive
; extruder_variant_list = "Direct Drive Standard"
; fan_cooling_layer_time = 100
; fan_direction = undefine
; fan_max_speed = 100
; fan_min_speed = 100
; filament_adaptive_volumetric_speed = 0
; filament_adhesiveness_category = 600
; filament_bridge_speed = 25
; filament_change_length = 10
; filament_change_length_nc = 10
; filament_colour = #FFFFFF
; filament_cooling_before_tower = 0
; filament_cost = 20
; filament_density = 1.24
; filament_dev_ams_drying_ams_limitations = 1
; filament_dev_ams_drying_heat_distortion_temperature = 45
; filament_dev_ams_drying_temperature = 65
; filament_dev_ams_drying_time = 12
; filament_dev_chamber_drying_bed_temperature = 90
; filament_dev_chamber_drying_time = 16
; filament_dev_drying_cooling_temperature = 40
; filament_dev_drying_softening_temperature = 50
; filament_diameter = 1.75
; filament_enable_overhang_speed = 1
; filament_end_gcode = "; filament end gcode \n\n"
; filament_extruder_compatibility = 0
; filament_extruder_variant = "Direct Drive Standard"
; filament_flow_ratio = 1
; filament_flush_temp = 0
; filament_flush_temp_fast = 0
; filament_flush_volumetric_speed = 0
; filament_ids = GFU99
; filament_is_mixed = 0
; filament_is_support = 0
; filament_map = 1
; filament_map_2 = 0
; filament_map_mode = Auto For Flush
; filament_max_volumetric_speed = 2
; filament_metal_stickiness = High
; filament_minimal_purge_on_wipe_tower = 15
; filament_mixed_components = ""
; filament_mixed_gradient = 0
; filament_mixed_gradient_curve = ""
; filament_mixed_gradient_per_part = 0
; filament_mixed_gradient_range = ""
; filament_mixed_sublayer_ratios = ""
; filament_notes = 
; filament_nozzle_map = 0
; filament_overhang_1_4_speed = 0
; filament_overhang_2_4_speed = 50
; filament_overhang_3_4_speed = 30
; filament_overhang_4_4_speed = 10
; filament_overhang_totally_speed = 10
; filament_pre_cooling_temperature = 0
; filament_pre_cooling_temperature_nc = 0
; filament_preheat_temperature_delta = 0
; filament_prime_volume = 45
; filament_prime_volume_nc = 60
; filament_printable = 3
; filament_ramming_travel_time = 0
; filament_ramming_travel_time_nc = 0
; filament_ramming_volumetric_speed = -1
; filament_ramming_volumetric_speed_nc = -1
; filament_retract_length_nc = 14
; filament_retraction_length = 0.4
; filament_scarf_gap = 0%
; filament_scarf_height = 10%
; filament_scarf_length = 10
; filament_scarf_seam_type = none
; filament_self_index = 1
; filament_settings_id = "Generic TPU @BBL A1M"
; filament_shrink = 100%
; filament_soluble = 0
; filament_start_gcode = "; filament start gcode\n{if (bed_temperature[current_extruder] >35)||(bed_temperature_initial_layer[current_extruder] >35)}M106 P3 S255\n{elsif (bed_temperature[current_extruder] >30)||(bed_temperature_initial_layer[current_extruder] >30)}M106 P3 S180\n{endif} \n{if activate_air_filtration[current_extruder] && support_air_filtration}\nM106 P3 S{during_print_exhaust_fan_speed_num[current_extruder]} \n{endif}"
; filament_tower_interface_pre_extrusion_dist = 10
; filament_tower_interface_pre_extrusion_length = 0
; filament_tower_interface_print_temp = -1
; filament_tower_interface_purge_volume = 20
; filament_tower_ironing_area = 4
; filament_type = TPU
; filament_velocity_adaptation_factor = 1
; filament_vendor = Generic
; filament_volume_map = 0
; filename_format = {input_filename_base}_{filament_type[0]}_{print_time}.gcode
; fill_multiline = 1
; filter_out_gap_fill = 0
; first_layer_print_sequence = 0
; first_x_layer_fan_speed = 0
; first_x_layer_part_fan_speed = 0
; flush_into_infill = 0
; flush_into_objects = 0
; flush_into_support = 1
; flush_multiplier = 1
; flush_multiplier_fast = 1.2
; flush_volumes_matrix = 0
; flush_volumes_vector = 140,140,140,140,140,140,140,140
; full_fan_speed_layer = 0
; fuzzy_skin = none
; fuzzy_skin_first_layer = 0
; fuzzy_skin_mode = displacement
; fuzzy_skin_noise_type = classic
; fuzzy_skin_octaves = 4
; fuzzy_skin_persistence = 0.5
; fuzzy_skin_point_distance = 0.8
; fuzzy_skin_scale = 1
; fuzzy_skin_thickness = 0.3
; gap_infill_speed = 25
; gcode_add_line_number = 0
; gcode_flavor = marlin
; grab_length = 17.4
; group_algo_with_time = 0
; has_filament_switcher = 0
; has_scarf_joint_seam = 0
; head_wrap_detect_zone = 156x152,180x152,180x180,156x180
; hole_coef_1 = 0
; hole_coef_2 = -0.008
; hole_coef_3 = 0.23415
; hole_limit_max = 0.22
; hole_limit_min = 0.088
; hot_plate_temp = 30
; hot_plate_temp_initial_layer = 30
; hotend_cooling_rate = 2
; hotend_heating_rate = 2
; impact_strength_z = 10
; independent_support_layer_height = 1
; infill_combination = 0
; infill_direction = 45
; infill_instead_top_bottom_surfaces = 0
; infill_jerk = 9
; infill_lock_depth = 1
; infill_rotate_step = 0
; infill_shift_step = 0.4
; infill_wall_overlap = 15%
; inherits_group = ;;
; initial_layer_acceleration = 500
; initial_layer_flow_ratio = 1
; initial_layer_infill_speed = 15
; initial_layer_jerk = 9
; initial_layer_line_width = 0.5
; initial_layer_print_height = 0.2
; initial_layer_speed = 15
; initial_layer_travel_acceleration = 6000
; inner_wall_acceleration = 500
; inner_wall_jerk = 9
; inner_wall_line_width = 0.45
; inner_wall_speed = 25
; interface_shells = 0
; interlocking_beam = 0
; interlocking_beam_layer_count = 2
; interlocking_beam_width = 0.8
; interlocking_boundary_avoidance = 2
; interlocking_depth = 2
; interlocking_orientation = 22.5
; internal_bridge_support_thickness = 0.8
; internal_solid_infill_line_width = 0.42
; internal_solid_infill_pattern = zig-zag
; internal_solid_infill_speed = 25
; ironing_direction = 45
; ironing_fan_speed = -1
; ironing_flow = 10%
; ironing_inset = 0.21
; ironing_pattern = zig-zag
; ironing_spacing = 0.15
; ironing_speed = 30
; ironing_type = no ironing
; is_infill_first = 0
; layer_change_gcode = ; layer num/total_layer_count: {layer_num+1}/[total_layer_count]\n; update layer progress\nM73 L{layer_num+1}\nM991 S0 P{layer_num} ;notify layer change
; layer_height = 0.12
; line_width = 0.42
; locked_skeleton_infill_pattern = zigzag
; locked_skin_infill_pattern = crosszag
; long_retractions_when_cut = 0
; long_retractions_when_ec = 0
; machine_bed_mass_Y = 0
; machine_end_gcode = ;===== date: 20260513 =====================\n;turn off nozzle clog detect\nG392 S0\n\nM400 ; wait for buffer to clear\nG92 E0 ; zero the extruder\nG90\nG1 Z{max_layer_z + 0.4} F900 ; lower z a little\nG1 X0 Y{first_layer_center_no_wipe_tower[1]} F18000 ; move to safe pos\nG1 X-13.0 F3000 ; move to safe pos\n{if !spiral_mode && print_sequence != \"by object\"}\nM1002 judge_flag timelapse_record_flag\nM622 J1\nM400 P100\nM971 S11 C11 O0\nM400 P100\nM971 S11 C11 O0\nM400 P100\nM971 S11 C11 O0\nM400 P100\nM971 S11 C11 O0\nM400 P100\nM971 S11 C11 O0\nM400 P100\nM971 S11 C11 O0\nM400 P100\nM971 S11 C11 O0\nM400 P100\nM971 S11 C11 O0\nM400 P100\nM971 S11 C11 O0\nM400 P100\nM971 S11 C11 O0\nM400 P100\nM971 S11 C11 O0\nM400 P100\nM971 S11 C11 O0\nM400 P100\nM971 S11 C11 O0\nM400 P100\nM971 S11 C11 O0\nM400 P100\nM971 S11 C11 O0\nM400 P100\nM971 S11 C11 O0\nM400 P100\nM971 S11 C11 O0\nM400 P100\nM971 S11 C11 O0\nM400 P100\nM971 S11 C11 O0\nM400 P100\nM971 S11 C11 O0\nM400 P100\nM971 S11 C11 O0\nM400 P100\nM971 S11 C11 O0\nM400 P100\nM971 S11 C11 O0\nM400 P100\nM971 S11 C11 O0\nM400 P100\nM971 S11 C11 O0\nM400 P100\nM971 S11 C11 O0\nM400 P100\nM971 S11 C11 O0\nM400 P100\nM971 S11 C11 O0\nM400 P100\nM971 S11 C11 O0\nM400 P100\nM971 S11 C11 O0\nM991 S0 P-1 ;end timelapse at safe pos\nM623\n{endif}\n\nM140 S0 ; turn off bed\nM106 S0 ; turn off fan\nM106 P2 S0 ; turn off remote part cooling fan\nM106 P3 S0 ; turn off chamber cooling fan\n\n;G1 X27 F15000 ; wipe\n\n; pull back filament to AMS\nM620 S255\nG1 X181 F12000\nT255\nG1 X0 F18000\nG1 X-13.0 F3000\nG1 X0 F18000 ; wipe\nM621 S255\n\nM104 S0 ; turn off hotend\n\nM400 ; wait all motion done\nM17 S\nM17 Z0.4 ; lower z motor current to reduce impact if there is something in the bottom\n{if (max_layer_z + 100.0) < 180}\n    G1 Z{max_layer_z + 100.0} F600\n    G1 Z{max_layer_z +98.0}\n{else}\n    G1 Z180 F600\n    G1 Z180\n{endif}\nM400 P100\nM17 R ; restore z current\n\nG90\nG1 X-13 Y180 F3600\n\nG91\nG1 Z-1 F600\nG90\nM83\n\nM220 S100  ; Reset feedrate magnitude\nM201.2 K1.0 ; Reset acc magnitude\nM73.2   R1.0 ;Reset left time magnitude\nM1002 set_gcode_claim_speed_level : 0\n\n;=====printer finish  sound=========\nM17\nM400 S1\nM1006 S1\nM1006 A0 B20 L100 C37 D20 M100 E42 F20 N100\nM1006 A0 B10 L100 C44 D10 M100 E44 F10 N100\nM1006 A0 B10 L100 C46 D10 M100 E46 F10 N100\nM1006 A44 B20 L100 C39 D20 M100 E48 F20 N100\nM1006 A0 B10 L100 C44 D10 M100 E44 F10 N100\nM1006 A0 B10 L100 C0 D10 M100 E0 F10 N100\nM1006 A0 B10 L100 C39 D10 M100 E39 F10 N100\nM1006 A0 B10 L100 C0 D10 M100 E0 F10 N100\nM1006 A0 B10 L100 C44 D10 M100 E44 F10 N100\nM1006 A0 B10 L100 C0 D10 M100 E0 F10 N100\nM1006 A0 B10 L100 C39 D10 M100 E39 F10 N100\nM1006 A0 B10 L100 C0 D10 M100 E0 F10 N100\nM1006 A44 B10 L100 C0 D10 M100 E48 F10 N100\nM1006 A0 B10 L100 C0 D10 M100 E0 F10 N100\nM1006 A44 B20 L100 C41 D20 M100 E49 F20 N100\nM1006 A0 B20 L100 C0 D20 M100 E0 F20 N100\nM1006 A0 B20 L100 C37 D20 M100 E37 F20 N100\nM1006 W\n;=====printer finish  sound=========\nM400 S1\nM18 X Y Z\n
; machine_hotend_change_time = 0
; machine_load_filament_time = 28
; machine_max_acceleration_e = 5000,5000
; machine_max_acceleration_extruding = 20000,20000
; machine_max_acceleration_retracting = 5000,5000
; machine_max_acceleration_travel = 9000,9000
; machine_max_acceleration_x = 20000,20000
; machine_max_acceleration_y = 20000,20000
; machine_max_acceleration_z = 1500,1500
; machine_max_force_Y = 0
; machine_max_jerk_e = 3,3
; machine_max_jerk_x = 9,9
; machine_max_jerk_y = 9,9
; machine_max_jerk_z = 5,5
; machine_max_printed_mass = 0
; machine_max_speed_e = 30,30
; machine_max_speed_x = 500,200
; machine_max_speed_y = 500,200
; machine_max_speed_z = 30,30
; machine_min_extruding_rate = 0,0
; machine_min_travel_rate = 0,0
; machine_pause_gcode = M400 U1
; machine_prepare_compensation_time = 260
; machine_start_gcode = ;===== machine: A1 mini =========================\n;===== date: 20260513 ==================\n\n;===== start to heat heatbead&hotend==========\nM1002 gcode_claim_action : 2\nM1002 set_filament_type:{filament_type[initial_no_support_extruder]}\nM104 S170\nM140 S[bed_temperature_initial_layer_single]\nG392 S0 ;turn off clog detect\nM9833.2\n;=====start printer sound ===================\nM17\nM400 S1\nM1006 S1\nM1006 A0 B0 L100 C37 D10 M100 E37 F10 N100\nM1006 A0 B0 L100 C41 D10 M100 E41 F10 N100\nM1006 A0 B0 L100 C44 D10 M100 E44 F10 N100\nM1006 A0 B10 L100 C0 D10 M100 E0 F10 N100\nM1006 A43 B10 L100 C39 D10 M100 E46 F10 N100\nM1006 A0 B0 L100 C0 D10 M100 E0 F10 N100\nM1006 A0 B0 L100 C39 D10 M100 E43 F10 N100\nM1006 A0 B0 L100 C0 D10 M100 E0 F10 N100\nM1006 A0 B0 L100 C41 D10 M100 E41 F10 N100\nM1006 A0 B0 L100 C44 D10 M100 E44 F10 N100\nM1006 A0 B0 L100 C49 D10 M100 E49 F10 N100\nM1006 A0 B0 L100 C0 D10 M100 E0 F10 N100\nM1006 A44 B10 L100 C39 D10 M100 E48 F10 N100\nM1006 A0 B0 L100 C0 D10 M100 E0 F10 N100\nM1006 A0 B0 L100 C39 D10 M100 E44 F10 N100\nM1006 A0 B0 L100 C0 D10 M100 E0 F10 N100\nM1006 A43 B10 L100 C39 D10 M100 E46 F10 N100\nM1006 W\nM18\n;=====avoid end stop =================\nG91\nG380 S2 Z30 F1200\nG380 S3 Z-20 F1200\nG1 Z5 F1200\nG90\n\n;===== reset machine status =================\nM204 S6000\n\nM630 S0 P0\nG91\nM17 Z0.3 ; lower the z-motor current\n\nG90\nM17 X0.7 Y0.9 Z0.5 ; reset motor current to default\nM960 S5 P1 ; turn on logo lamp\nG90\nM83\nM220 S100 ;Reset Feedrate\nM221 S100 ;Reset Flowrate\nM73.2   R1.0 ;Reset left time magnitude\n;====== cog noise reduction=================\nM982.2 S1 ; turn on cog noise reduction\n\n;===== prepare print temperature and material ==========\nM400\nM18\nM109 S100 H170\nM104 S170\nM400\nM17\nM400\nG28 X\n\nM211 X0 Y0 Z0 ;turn off soft endstop ; turn off soft endstop to prevent protential logic problem\n\nM975 S1 ; turn on\n\nG1 X0.0 F30000\nG1 X-13.5 F3000\n\nM620 M ;enable remap\nM620 S[initial_no_support_extruder]A   ; switch material if AMS exist\n    G392 S0 ;turn on clog detect\n    M1002 gcode_claim_action : 4\n    M400\n    M1002 set_filament_type:UNKNOWN\n    M109 S[nozzle_temperature_initial_layer]\n{if (filament_type[initial_no_support_extruder] == \"PLA\") && (nozzle_diameter != 0.2)}\n    M104 S220\n{else}\n    M104 S250\n{endif}\n    M400\n    T[initial_no_support_extruder]\n    G1 X-13.5 F3000\n    M400\n{if (filament_type[initial_no_support_extruder] == \"PLA\") && (nozzle_diameter != 0.2)}\n    M620.1 E F{flush_volumetric_speeds[initial_no_support_extruder]/2.4053*60} T220\n    M109 S220 ;set nozzle to common flush temp\n{else}\n    M620.1 E F{flush_volumetric_speeds[initial_no_support_extruder]/2.4053*60} T{flush_temperatures[initial_no_support_extruder]}\n    M109 S250 ;set nozzle to common flush temp\n{endif}\n    M106 P1 S0\n    G92 E0\n    G1 E50 F200\n    M400\n    M1002 set_filament_type:{filament_type[initial_no_support_extruder]}\n{if (filament_type[initial_no_support_extruder] == \"PLA\") && (nozzle_diameter != 0.2)}\n    M104 S220\n{else}\n    M104 S{flush_temperatures[initial_no_support_extruder]}\n{endif}\n    G92 E0\n    G1 E50 F{flush_volumetric_speeds[initial_no_support_extruder]/2.4053*60}\n    M400\n    M106 P1 S178\n    G92 E0\n    G1 E5 F{flush_volumetric_speeds[initial_no_support_extruder]/2.4053*60}\n    M109 S{nozzle_temperature_initial_layer[initial_no_support_extruder]-20} ; drop nozzle temp, make filament shink a bit\n    M104 S{nozzle_temperature_initial_layer[initial_no_support_extruder]-40}\n    G92 E0\n    G1 E-0.5 F300\n\n    G1 X0 F30000\n    G1 X-13.5 F3000\n    G1 X0 F30000 ;wipe and shake\n    G1 X-13.5 F3000\n    G1 X0 F12000 ;wipe and shake\n    G1 X0 F30000\n    G1 X-13.5 F3000\n    M109 S{nozzle_temperature_initial_layer[initial_no_support_extruder]-40}\n    G392 S0 ;turn off clog detect\nM621 S[initial_no_support_extruder]A\n\nM400\nM106 P1 S0\n;===== prepare print temperature and material end =====\n\n\n;===== mech mode fast check============================\nM1002 gcode_claim_action : 3\nG0 X25 Y175 F20000 ; find a soft place to home\n;M104 S0\nG28 Z P0 T300; home z with low precision,permit 300deg temperature\nG29.2 S0 ; turn off ABL\nM104 S170\n\n; build plate detect\nM1002 judge_flag build_plate_detect_flag\nM622 S1\n  G39.4\n  M400\nM623\n\nG1 Z5 F3000\nG1 X90 Y-1 F30000\nM400 P200\nM970.3 Q1 A7 K0 O2\nM974 Q1 S2 P0\n\nG1 X90 Y0 Z5 F30000\nM400 P200\nM970 Q0 A10 B50 C90 H15 K0 M20 O3\nM974 Q0 S2 P0\n\nM975 S1\nG1 F30000\nG1 X-1 Y10\nG28 X ; re-home XY\n\n;===== wipe nozzle ===============================\nM1002 gcode_claim_action : 14\nM975 S1\n\nM104 S170 ; set temp down to heatbed acceptable\nM106 S255 ; turn on fan (G28 has turn off fan)\nM211 S; push soft endstop status\nM211 X0 Y0 Z0 ;turn off Z axis endstop\n\nM83\nG1 E-1 F500\nG90\nM83\n\nM109 S170\nM104 S140\nG0 X90 Y-4 F30000\nG380 S3 Z-5 F1200\nG1 Z2 F1200\nG1 X91 F10000\nG380 S3 Z-5 F1200\nG1 Z2 F1200\nG1 X92 F10000\nG380 S3 Z-5 F1200\nG1 Z2 F1200\nG1 X93 F10000\nG380 S3 Z-5 F1200\nG1 Z2 F1200\nG1 X94 F10000\nG380 S3 Z-5 F1200\nG1 Z2 F1200\nG1 X95 F10000\nG380 S3 Z-5 F1200\nG1 Z2 F1200\nG1 X96 F10000\nG380 S3 Z-5 F1200\nG1 Z2 F1200\nG1 X97 F10000\nG380 S3 Z-5 F1200\nG1 Z2 F1200\nG1 X98 F10000\nG380 S3 Z-5 F1200\nG1 Z2 F1200\nG1 X99 F10000\nG380 S3 Z-5 F1200\nG1 Z2 F1200\nG1 X99 F10000\nG380 S3 Z-5 F1200\nG1 Z2 F1200\nG1 X99 F10000\nG380 S3 Z-5 F1200\nG1 Z2 F1200\nG1 X99 F10000\nG380 S3 Z-5 F1200\nG1 Z2 F1200\nG1 X99 F10000\nG380 S3 Z-5 F1200\n\nG1 Z5 F30000\n;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;\nG1 X25 Y175 F30000.1 ;Brush material\nG1 Z0.2 F30000.1\nG1 Y185\nG91\nG1 X-30 F30000\nG1 Y-2\nG1 X27\nG1 Y1.5\nG1 X-28\nG1 Y-2\nG1 X30\nG1 Y1.5\nG1 X-30\nG90\nM83\n\nG1 Z5 F3000\nG0 X50 Y175 F20000 ; find a soft place to home\nG28 Z P0 T300; home z with low precision, permit 300deg temperature\nG29.2 S0 ; turn off ABL\n\nG0 X85 Y185 F10000 ;move to exposed steel surface and stop the nozzle\nG0 Z-1.01 F10000\nG91\n\nG2 I1 J0 X2 Y0 F2000.1\nG2 I-0.75 J0 X-1.5\nG2 I1 J0 X2\nG2 I-0.75 J0 X-1.5\nG2 I1 J0 X2\nG2 I-0.75 J0 X-1.5\nG2 I1 J0 X2\nG2 I-0.75 J0 X-1.5\nG2 I1 J0 X2\nG2 I-0.75 J0 X-1.5\nG2 I1 J0 X2\nG2 I-0.75 J0 X-1.5\nG2 I1 J0 X2\nG2 I-0.75 J0 X-1.5\nG2 I1 J0 X2\nG2 I-0.75 J0 X-1.5\nG2 I1 J0 X2\nG2 I-0.75 J0 X-1.5\nG2 I1 J0 X2\nG2 I-0.75 J0 X-1.5\n\nG90\nG1 Z5 F30000\nG1 X25 Y175 F30000.1 ;Brush material\nG1 Z0.2 F30000.1\nG1 Y185\nG91\nG1 X-30 F30000\nG1 Y-2\nG1 X27\nG1 Y1.5\nG1 X-28\nG1 Y-2\nG1 X30\nG1 Y1.5\nG1 X-30\nG90\nM83\n\nG1 Z5\nG0 X55 Y175 F20000 ; find a soft place to home\nG28 Z P0 T300; home z with low precision, permit 300deg temperature\nG29.2 S0 ; turn off ABL\n\nG1 Z10\nG1 X85 Y185\nG1 Z-1.01\nG1 X95\nG1 X90\n\nM211 R; pop softend status\n\nM106 S0 ; turn off fan , too noisy\n;===== wipe nozzle end ================================\n\n\n;===== wait heatbed  ====================\nM1002 gcode_claim_action:54\nM104 S0\nM190 S[bed_temperature_initial_layer_single];set bed temp\nM109 S140\n\nG1 Z5 F3000\nG29.2 S1\nG1 X10 Y10 F20000\n\n;===== bed leveling ==================================\n;M1002 set_flag g29_before_print_flag=1\nM1002 judge_flag g29_before_print_flag\nM622 J1\n    M1002 gcode_claim_action : 1\n    G29 A1 X{first_layer_print_min[0]} Y{first_layer_print_min[1]} I{first_layer_print_size[0]} J{first_layer_print_size[1]}\n    M400\n    M500 ; save cali data\nM623\n;===== bed leveling end ================================\n\n;===== home after wipe mouth============================\nM1002 judge_flag g29_before_print_flag\nM622 J0\n\n    M1002 gcode_claim_action : 13\n    G28 T145\n\nM623\n\n;===== home after wipe mouth end =======================\n\nM975 S1 ; turn on vibration supression\n;===== nozzle load line ===============================\nM975 S1\nG90\nM83\nT1000\n\nG1 X-13.5 Y0 Z10 F10000\nG1 E1.2 F500\nM400\nM1002 set_filament_type:UNKNOWN\nM109 S{nozzle_temperature[initial_extruder]}\nM400\n\nM412 S1 ;    ===turn on  filament runout detection===\nM400 P10\n\nG392 S0 ;turn on clog detect\n\nM620.3 W1; === turn on filament tangle detection===\nM400 S2\n\nM1002 set_filament_type:{filament_type[initial_no_support_extruder]}\n;M1002 set_flag extrude_cali_flag=1\nM1002 judge_flag extrude_cali_flag\nM622 J1\n    M1002 gcode_claim_action : 8\n    \n    M400\n    M900 K0.0 L1000.0 M1.0\n    G90\n    M83\n    G0 X68 Y-4 F30000\n    G0 Z0.3 F18000 ;Move to start position\n    M400\n    G0 X88 E10  F{outer_wall_volumetric_speed/(24/20)    * 60}\n    G0 X93 E.3742  F{outer_wall_volumetric_speed/(0.3*0.5)/4     * 60}\n    G0 X98 E.3742  F{outer_wall_volumetric_speed/(0.3*0.5)     * 60}\n    G0 X103 E.3742  F{outer_wall_volumetric_speed/(0.3*0.5)/4     * 60}\n    G0 X108 E.3742  F{outer_wall_volumetric_speed/(0.3*0.5)     * 60}\n    G0 X113 E.3742  F{outer_wall_volumetric_speed/(0.3*0.5)/4     * 60}\n    G0 Y0 Z0 F20000\n    M400\n    \n    G1 X-13.5 Y0 Z10 F10000\n    M400\n    \n    G1 E10 F{outer_wall_volumetric_speed/2.4*60}\n    M983 F{outer_wall_volumetric_speed/2.4} A0.3 H[nozzle_diameter]; cali dynamic extrusion compensation\n    M106 P1 S178\n    M400 S7\n    G1 X0 F18000\n    G1 X-13.5 F3000\n    G1 X0 F18000 ;wipe and shake\n    G1 X-13.5 F3000\n    G1 X0 F12000 ;wipe and shake\n    G1 X-13.5 F3000\n    M400\n    M106 P1 S0\n\n    M1002 judge_last_extrude_cali_success\n    M622 J0\n        M983 F{outer_wall_volumetric_speed/2.4} A0.3 H[nozzle_diameter]; cali dynamic extrusion compensation\n        M106 P1 S178\n        M400 S7\n        G1 X0 F18000\n        G1 X-13.5 F3000\n        G1 X0 F18000 ;wipe and shake\n        G1 X-13.5 F3000\n        G1 X0 F12000 ;wipe and shake\n        M400\n        M106 P1 S0\n    M623\n    \n    G1 X-13.5 F3000\n    M400\n    M984 A0.1 E1 S1 F{outer_wall_volumetric_speed/2.4} H[nozzle_diameter]\n    M106 P1 S178\n    M400 S7\n    G1 X0 F18000\n    G1 X-13.5 F3000\n    G1 X0 F18000 ;wipe and shake\n    G1 X-13.5 F3000\n    G1 X0 F12000 ;wipe and shake\n    G1 X-13.5 F3000\n    M400\n    M106 P1 S0\n\nM623 ; end of \"draw extrinsic para cali paint\"\n\n;===== extrude cali test ===============================\nM104 S{nozzle_temperature_initial_layer[initial_extruder]}\nG90\nM83\nG0 X68 Y-2.5 F30000\nG0 Z0.3 F18000 ;Move to start position\nG0 X88 E10  F{outer_wall_volumetric_speed/(24/20)    * 60}\nG0 X93 E.3742  F{outer_wall_volumetric_speed/(0.3*0.5)/4     * 60}\nG0 X98 E.3742  F{outer_wall_volumetric_speed/(0.3*0.5)     * 60}\nG0 X103 E.3742  F{outer_wall_volumetric_speed/(0.3*0.5)/4     * 60}\nG0 X108 E.3742  F{outer_wall_volumetric_speed/(0.3*0.5)     * 60}\nG0 X113 E.3742  F{outer_wall_volumetric_speed/(0.3*0.5)/4     * 60}\nG0 X115 Z0 F20000\nG0 Z5\nM400\n\n;========turn off light and wait extrude temperature =============\nM1002 gcode_claim_action : 0\n\nM400 ; wait all motion done before implement the emprical L parameters\n\n;===== for Textured PEI Plate , lower the nozzle as the nozzle was touching topmost of the texture when homing ==\n;curr_bed_type={curr_bed_type}\n{if curr_bed_type==\"Textured PEI Plate\"}\nG29.1 Z{-0.02} ; for Textured PEI Plate\n{endif}\n\nM960 S1 P0 ; turn off laser\nM960 S2 P0 ; turn off laser\nM106 S0 ; turn off fan\nM106 P2 S0 ; turn off big fan\nM106 P3 S0 ; turn off chamber fan\n\nM975 S1 ; turn on mech mode supression\nG90\nM83\nT1000\n\nM211 X0 Y0 Z0 ;turn off soft endstop\nM1007 S1\n\n\n\n
; machine_switch_extruder_time = 0
; machine_unload_filament_time = 34
; master_extruder_id = 1
; max_bridge_length = 0
; max_layer_height = 0.28
; max_travel_detour_distance = 0
; min_bead_width = 85%
; min_feature_size = 25%
; min_layer_height = 0.08
; minimum_sparse_infill_area = 15
; mmu_segmented_region_interlocking_depth = 0
; mmu_segmented_region_max_width = 0
; monotonic_travel_into_wall = 0%
; no_slow_down_for_cooling_on_outwalls = 0
; nozzle_diameter = 0.4
; nozzle_flush_dataset = 0
; nozzle_height = 4.76
; nozzle_temperature = 230
; nozzle_temperature_initial_layer = 230
; nozzle_temperature_range_high = 250
; nozzle_temperature_range_low = 200
; nozzle_type = stainless_steel
; nozzle_volume = 92
; nozzle_volume_type = Standard
; only_one_wall_first_layer = 0
; ooze_prevention = 0
; other_layers_print_sequence = 0
; other_layers_print_sequence_nums = 0
; outer_wall_acceleration = 500
; outer_wall_jerk = 9
; outer_wall_line_width = 0.42
; outer_wall_speed = 25
; overhang_1_4_speed = 60
; overhang_2_4_speed = 30
; overhang_3_4_speed = 10
; overhang_4_4_speed = 10
; overhang_fan_speed = 100
; overhang_fan_threshold = 95%
; overhang_threshold_participating_cooling = 95%
; overhang_totally_speed = 10
; override_filament_scarf_seam_setting = 0
; override_process_overhang_speed = 0
; physical_extruder_map = 0
; post_process = 
; pre_start_fan_time = 0,2,2,2,2
; precise_outer_wall = 0
; precise_z_height = 0
; pressure_advance = 0.02
; prime_tower_brim_width = 3
; prime_tower_enable_framework = 0
; prime_tower_extra_rib_length = 0
; prime_tower_fillet_wall = 1
; prime_tower_flat_ironing = 0
; prime_tower_infill_gap = 150%
; prime_tower_lift_height = -1
; prime_tower_lift_speed = 90
; prime_tower_max_speed = 90
; prime_tower_rib_wall = 1
; prime_tower_rib_width = 8
; prime_tower_skip_points = 1
; prime_tower_width = 35
; prime_volume_mode = Default
; print_compatible_printers = "Bambu Lab A1 mini 0.4 nozzle"
; print_extruder_id = 1
; print_extruder_variant = "Direct Drive Standard"
; print_flow_ratio = 1
; print_in_clockwise = 0
; print_sequence = by layer
; print_settings_id = 0.12mm Fine @BBL A1M
; printable_area = 0x0,180x0,180x180,0x180
; printable_height = 180
; printer_extruder_id = 1
; printer_extruder_variant = "Direct Drive Standard"
; printer_model = Bambu Lab A1 mini
; printer_notes = 
; printer_settings_id = Bambu Lab A1 mini 0.4 nozzle
; printer_structure = i3
; printer_technology = FFF
; printer_variant = 0.4
; printing_by_object_gcode = 
; process_notes = 
; raft_contact_distance = 0.1
; raft_expansion = 1.5
; raft_first_layer_density = 90%
; raft_first_layer_expansion = -1
; raft_layers = 0
; reduce_crossing_wall = 0
; reduce_fan_stop_start_freq = 1
; reduce_infill_retraction_mode = Auto
; required_nozzle_HRC = 3
; resolution = 0.012
; retract_before_wipe = 0%
; retract_length_toolchange = 2
; retract_lift_above = 0
; retract_lift_below = 179
; retract_restart_extra = 0
; retract_restart_extra_toolchange = 0
; retract_when_changing_layer = 1
; retraction_distances_when_cut = 18
; retraction_distances_when_ec = 0
; retraction_length = 0.8
; retraction_minimum_travel = 1
; retraction_speed = 30
; role_base_wipe_speed = 1
; scan_first_layer = 0
; scarf_angle_threshold = 155
; seam_gap = 15%
; seam_placement_away_from_overhangs = 0
; seam_position = aligned
; seam_slope_conditional = 1
; seam_slope_entire_loop = 0
; seam_slope_gap = 0
; seam_slope_inner_walls = 1
; seam_slope_min_length = 10
; seam_slope_start_height = 10%
; seam_slope_steps = 10
; seam_slope_type = none
; silent_mode = 0
; single_extruder_multi_material = 1
; skeleton_infill_density = 15%
; skeleton_infill_line_width = 0.45
; skin_infill_density = 15%
; skin_infill_depth = 2
; skin_infill_line_width = 0.45
; skirt_distance = 2
; skirt_height = 1
; skirt_loops = 0
; skirt_per_object = 1
; slice_closing_radius = 0.049
; slicing_mode = regular
; slow_down_for_layer_cooling = 1
; slow_down_layer_time = 8
; slow_down_min_speed = 10
; slowdown_end_acc = 100000
; slowdown_end_height = 400
; slowdown_end_speed = 1000
; slowdown_start_acc = 100000
; slowdown_start_height = 0
; slowdown_start_speed = 1000
; small_perimeter_speed = 50%
; small_perimeter_threshold = 0
; smooth_coefficient = 80
; smooth_speed_discontinuity_area = 1
; solid_infill_filament = 0
; sparse_infill_acceleration = 100%
; sparse_infill_anchor = 400%
; sparse_infill_anchor_max = 20
; sparse_infill_density = 15%
; sparse_infill_filament = 0
; sparse_infill_lattice_angle_1 = -45
; sparse_infill_lattice_angle_2 = 45
; sparse_infill_line_width = 0.45
; sparse_infill_pattern = gyroid
; sparse_infill_speed = 25
; spiral_mode = 0
; spiral_mode_max_xy_smoothing = 200%
; spiral_mode_smooth = 0
; standby_temperature_delta = -5
; start_end_points = 30x-3,54x245
; supertack_plate_temp = 0
; supertack_plate_temp_initial_layer = 0
; support_air_filtration = 0
; support_angle = 0
; support_base_pattern = default
; support_base_pattern_spacing = 2.5
; support_bottom_interface_spacing = 0.5
; support_bottom_z_distance = 0.24
; support_chamber_temp_control = 0
; support_cooling_filter = 0
; support_critical_regions_only = 0
; support_expansion = 0
; support_fast_purge_mode = 0
; support_filament = 0
; support_interface_bottom_layers = 2
; support_interface_filament = 0
; support_interface_loop_pattern = 0
; support_interface_not_for_body = 1
; support_interface_pattern = auto
; support_interface_spacing = 0.5
; support_interface_speed = 25
; support_interface_top_layers = 2
; support_ironing_direction = 0
; support_ironing_flow = 10%
; support_ironing_inset = 0
; support_ironing_pattern = zig-zag
; support_ironing_spacing = 0.15
; support_ironing_speed = 30
; support_line_width = 0.42
; support_object_first_layer_gap = 0.2
; support_object_skip_flush = 0
; support_object_xy_distance = 0.4
; support_on_build_plate_only = 0
; support_remove_small_overhang = 1
; support_speed = 25
; support_style = snug
; support_threshold_angle = 30
; support_top_z_distance = 0.24
; support_type = normal(auto)
; symmetric_infill_y_axis = 0
; temperature_vitrification = 30
; template_custom_gcode = 
; textured_plate_temp = 35
; textured_plate_temp_initial_layer = 35
; thick_bridges = 0
; thumbnail_size = 50x50
; time_lapse_gcode = ;===================== date: 20250206 =====================\n{if !spiral_mode && print_sequence != \"by object\"}\n; don't support timelapse gcode in spiral_mode and by object sequence for I3 structure printer\n; SKIPPABLE_START\n; SKIPTYPE: timelapse\nM622.1 S1 ; for prev firmware, default turned on\nM1002 judge_flag timelapse_record_flag\nM622 J1\nG92 E0\nG1 Z{max_layer_z + 0.4}\nG1 X0 Y{first_layer_center_no_wipe_tower[1]} F18000 ; move to safe pos\nG1 X-13.0 F3000 ; move to safe pos\nM400\nM1004 S5 P1  ; external shutter\nM400 P300\nM971 S11 C11 O0\nG92 E0\nG1 X0 F18000\nM623\n\n; SKIPTYPE: head_wrap_detect\nM622.1 S1\nM1002 judge_flag g39_3rd_layer_detect_flag\nM622 J1\n    ; enable nozzle clog detect at 3rd layer\n    {if layer_num == 2}\n      M400\n      G90\n      M83\n      M204 S5000\n      G0 Z2 F4000\n      G0 X187 Y178 F20000\n      G39 S1 X187 Y178\n      G0 Z2 F4000\n    {endif}\n\n\n    M622.1 S1\n    M1002 judge_flag g39_detection_flag\n    M622 J1\n      {if !in_head_wrap_detect_zone}\n        M622.1 S0\n        M1002 judge_flag g39_mass_exceed_flag\n        M622 J1\n        {if layer_num > 2}\n            G392 S0\n            M400\n            G90\n            M83\n            M204 S5000\n            G0 Z{max_layer_z + 0.4} F4000\n            G39.3 S1\n            G0 Z{max_layer_z + 0.4} F4000\n            G392 S0\n          {endif}\n        M623\n    {endif}\n    M623\nM623\n; SKIPPABLE_END\n{endif}\n\n\n
; timelapse_type = 0
; top_area_threshold = 200%
; top_color_penetration_layers = 5
; top_one_wall_type = all top
; top_shell_layers = 5
; top_shell_thickness = 0.6
; top_solid_infill_flow_ratio = 1
; top_surface_acceleration = 2000
; top_surface_density = 100%
; top_surface_jerk = 9
; top_surface_line_width = 0.42
; top_surface_pattern = monotonicline
; top_surface_speed = 25
; top_z_overrides_xy_distance = 0
; travel_acceleration = 10000
; travel_jerk = 9
; travel_short_distance_acceleration = 250
; travel_speed = 300
; travel_speed_z = 0
; tree_support_branch_angle = 45
; tree_support_branch_diameter = 2
; tree_support_branch_diameter_angle = 5
; tree_support_branch_distance = 5
; tree_support_wall_count = -1
; upward_compatible_machine = "Bambu Lab P1S 0.4 nozzle";"Bambu Lab P1P 0.4 nozzle";"Bambu Lab X1 0.4 nozzle";"Bambu Lab X1 Carbon 0.4 nozzle";"Bambu Lab X1E 0.4 nozzle";"Bambu Lab A1 0.4 nozzle";"Bambu Lab H2D 0.4 nozzle";"Bambu Lab H2D Pro 0.4 nozzle";"Bambu Lab H2S 0.4 nozzle";"Bambu Lab P2S 0.4 nozzle";"Bambu Lab H2C 0.4 nozzle";"Bambu Lab X2D 0.4 nozzle";"Bambu Lab A2L 0.4 nozzle"
; use_firmware_retraction = 0
; use_relative_e_distances = 1
; vertical_shell_speed = 80%
; volumetric_speed_coefficients = "0 0 0 0 0 0"
; wall_distribution_count = 1
; wall_filament = 0
; wall_generator = classic
; wall_loops = 3
; wall_sequence = inner wall/outer wall
; wall_transition_angle = 10
; wall_transition_filter_deviation = 25%
; wall_transition_length = 100%
; wipe = 1
; wipe_distance = 2
; wipe_speed = 80%
; wipe_tower_no_sparse_layers = 0
; wipe_tower_rotation_angle = 0
; wipe_tower_x = 15
; wipe_tower_y = 220
; wrapping_detection_gcode = 
; wrapping_detection_layers = 20
; wrapping_exclude_area = 
; xy_contour_compensation = 0
; xy_hole_compensation = 0
; z_direction_outwall_speed_continuous = 0
; z_hop = 0.4
; z_hop_types = Auto Lift
; CONFIG_BLOCK_END

; EXECUTABLE_BLOCK_START
M73 P0 R24
M201 X20000 Y20000 Z1500 E5000
M203 X500 Y500 Z30 E30
M204 P20000 R5000 T20000
M205 X9.00 Y9.00 Z5.00 E3.00
M106 S0
; FEATURE: Custom
;===== machine: A1 mini =========================
;===== date: 20260513 ==================

;===== start to heat heatbead&hotend==========
M1002 gcode_claim_action : 2
M1002 set_filament_type:TPU
M104 S170
M140 S35
G392 S0 ;turn off clog detect
M9833.2
;=====start printer sound ===================
M17
M400 S1
M1006 S1
M1006 A0 B0 L100 C37 D10 M100 E37 F10 N100
M1006 A0 B0 L100 C41 D10 M100 E41 F10 N100
M1006 A0 B0 L100 C44 D10 M100 E44 F10 N100
M1006 A0 B10 L100 C0 D10 M100 E0 F10 N100
M1006 A43 B10 L100 C39 D10 M100 E46 F10 N100
M1006 A0 B0 L100 C0 D10 M100 E0 F10 N100
M1006 A0 B0 L100 C39 D10 M100 E43 F10 N100
M1006 A0 B0 L100 C0 D10 M100 E0 F10 N100
M1006 A0 B0 L100 C41 D10 M100 E41 F10 N100
M1006 A0 B0 L100 C44 D10 M100 E44 F10 N100
M1006 A0 B0 L100 C49 D10 M100 E49 F10 N100
M1006 A0 B0 L100 C0 D10 M100 E0 F10 N100
M1006 A44 B10 L100 C39 D10 M100 E48 F10 N100
M1006 A0 B0 L100 C0 D10 M100 E0 F10 N100
M1006 A0 B0 L100 C39 D10 M100 E44 F10 N100
M1006 A0 B0 L100 C0 D10 M100 E0 F10 N100
M1006 A43 B10 L100 C39 D10 M100 E46 F10 N100
M1006 W
M18
;=====avoid end stop =================
G91
G380 S2 Z30 F1200
G380 S3 Z-20 F1200
G1 Z5 F1200
G90

;===== reset machine status =================
M204 S6000

M630 S0 P0
G91
M17 Z0.3 ; lower the z-motor current

G90
M17 X0.7 Y0.9 Z0.5 ; reset motor current to default
M960 S5 P1 ; turn on logo lamp
G90
M83
M220 S100 ;Reset Feedrate
M221 S100 ;Reset Flowrate
M73.2   R1.0 ;Reset left time magnitude
;====== cog noise reduction=================
M982.2 S1 ; turn on cog noise reduction

;===== prepare print temperature and material ==========
M400
M18
M109 S100 H170
M104 S170
M400
M17
M400
G28 X

M211 X0 Y0 Z0 ;turn off soft endstop ; turn off soft endstop to prevent protential logic problem

M975 S1 ; turn on

G1 X0.0 F30000
G1 X-13.5 F3000

M620 M ;enable remap
M620 S0A   ; switch material if AMS exist
    G392 S0 ;turn on clog detect
    M1002 gcode_claim_action : 4
    M400
    M1002 set_filament_type:UNKNOWN
    M109 S230

    M104 S250

    M400
    T0
    G1 X-13.5 F3000
    M400

    M620.1 E F49.8898 T250
    M109 S250 ;set nozzle to common flush temp

    M106 P1 S0
    G92 E0
M73 P2 R23
    G1 E50 F200
    M400
    M1002 set_filament_type:TPU

    M104 S250

    G92 E0
    G1 E50 F49.8898
    M400
    M106 P1 S178
    G92 E0
M73 P3 R23
    G1 E5 F49.8898
    M109 S210 ; drop nozzle temp, make filament shink a bit
    M104 S190
    G92 E0
M73 P7 R22
    G1 E-0.5 F300

    G1 X0 F30000
    G1 X-13.5 F3000
    G1 X0 F30000 ;wipe and shake
    G1 X-13.5 F3000
    G1 X0 F12000 ;wipe and shake
    G1 X0 F30000
    G1 X-13.5 F3000
    M109 S190
    G392 S0 ;turn off clog detect
M621 S0A

M400
M106 P1 S0
;===== prepare print temperature and material end =====


;===== mech mode fast check============================
M1002 gcode_claim_action : 3
G0 X25 Y175 F20000 ; find a soft place to home
;M104 S0
G28 Z P0 T300; home z with low precision,permit 300deg temperature
G29.2 S0 ; turn off ABL
M104 S170

; build plate detect
M1002 judge_flag build_plate_detect_flag
M622 S1
  G39.4
  M400
M623

G1 Z5 F3000
G1 X90 Y-1 F30000
M400 P200
M970.3 Q1 A7 K0 O2
M974 Q1 S2 P0

G1 X90 Y0 Z5 F30000
M400 P200
M970 Q0 A10 B50 C90 H15 K0 M20 O3
M974 Q0 S2 P0

M975 S1
G1 F30000
G1 X-1 Y10
G28 X ; re-home XY

;===== wipe nozzle ===============================
M1002 gcode_claim_action : 14
M975 S1

M104 S170 ; set temp down to heatbed acceptable
M106 S255 ; turn on fan (G28 has turn off fan)
M211 S; push soft endstop status
M211 X0 Y0 Z0 ;turn off Z axis endstop

M83
G1 E-1 F500
G90
M83

M109 S170
M104 S140
G0 X90 Y-4 F30000
G380 S3 Z-5 F1200
M73 P25 R18
G1 Z2 F1200
G1 X91 F10000
G380 S3 Z-5 F1200
M73 P25 R17
G1 Z2 F1200
G1 X92 F10000
G380 S3 Z-5 F1200
G1 Z2 F1200
G1 X93 F10000
G380 S3 Z-5 F1200
G1 Z2 F1200
G1 X94 F10000
G380 S3 Z-5 F1200
G1 Z2 F1200
G1 X95 F10000
G380 S3 Z-5 F1200
G1 Z2 F1200
G1 X96 F10000
G380 S3 Z-5 F1200
G1 Z2 F1200
G1 X97 F10000
G380 S3 Z-5 F1200
G1 Z2 F1200
G1 X98 F10000
G380 S3 Z-5 F1200
G1 Z2 F1200
G1 X99 F10000
G380 S3 Z-5 F1200
G1 Z2 F1200
G1 X99 F10000
G380 S3 Z-5 F1200
G1 Z2 F1200
G1 X99 F10000
G380 S3 Z-5 F1200
G1 Z2 F1200
G1 X99 F10000
G380 S3 Z-5 F1200
G1 Z2 F1200
G1 X99 F10000
G380 S3 Z-5 F1200

G1 Z5 F30000
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
G1 X25 Y175 F30000.1 ;Brush material
G1 Z0.2 F30000.1
G1 Y185
G91
G1 X-30 F30000
G1 Y-2
G1 X27
G1 Y1.5
G1 X-28
G1 Y-2
G1 X30
G1 Y1.5
G1 X-30
G90
M83

G1 Z5 F3000
G0 X50 Y175 F20000 ; find a soft place to home
G28 Z P0 T300; home z with low precision, permit 300deg temperature
G29.2 S0 ; turn off ABL

G0 X85 Y185 F10000 ;move to exposed steel surface and stop the nozzle
G0 Z-1.01 F10000
G91

G2 I1 J0 X2 Y0 F2000.1
G2 I-0.75 J0 X-1.5
G2 I1 J0 X2
G2 I-0.75 J0 X-1.5
G2 I1 J0 X2
G2 I-0.75 J0 X-1.5
G2 I1 J0 X2
G2 I-0.75 J0 X-1.5
G2 I1 J0 X2
G2 I-0.75 J0 X-1.5
G2 I1 J0 X2
G2 I-0.75 J0 X-1.5
G2 I1 J0 X2
G2 I-0.75 J0 X-1.5
G2 I1 J0 X2
G2 I-0.75 J0 X-1.5
G2 I1 J0 X2
G2 I-0.75 J0 X-1.5
G2 I1 J0 X2
M73 P26 R17
G2 I-0.75 J0 X-1.5

G90
G1 Z5 F30000
G1 X25 Y175 F30000.1 ;Brush material
G1 Z0.2 F30000.1
G1 Y185
G91
G1 X-30 F30000
G1 Y-2
G1 X27
G1 Y1.5
G1 X-28
G1 Y-2
G1 X30
G1 Y1.5
G1 X-30
G90
M83

G1 Z5
G0 X55 Y175 F20000 ; find a soft place to home
G28 Z P0 T300; home z with low precision, permit 300deg temperature
G29.2 S0 ; turn off ABL

G1 Z10
G1 X85 Y185
G1 Z-1.01
G1 X95
G1 X90

M211 R; pop softend status

M106 S0 ; turn off fan , too noisy
;===== wipe nozzle end ================================


;===== wait heatbed  ====================
M1002 gcode_claim_action:54
M104 S0
M190 S35;set bed temp
M109 S140

G1 Z5 F3000
G29.2 S1
G1 X10 Y10 F20000

;===== bed leveling ==================================
;M1002 set_flag g29_before_print_flag=1
M1002 judge_flag g29_before_print_flag
M622 J1
    M1002 gcode_claim_action : 1
    G29 A1 X80 Y76.1009 I20 J27.7982
    M400
    M500 ; save cali data
M623
;===== bed leveling end ================================

;===== home after wipe mouth============================
M1002 judge_flag g29_before_print_flag
M622 J0

    M1002 gcode_claim_action : 13
    G28 T145

M623

;===== home after wipe mouth end =======================

M975 S1 ; turn on vibration supression
;===== nozzle load line ===============================
M975 S1
G90
M83
T1000

G1 X-13.5 Y0 Z10 F10000
G1 E1.2 F500
M400
M1002 set_filament_type:UNKNOWN
M109 S230
M400

M412 S1 ;    ===turn on  filament runout detection===
M400 P10

G392 S0 ;turn on clog detect

M620.3 W1; === turn on filament tangle detection===
M400 S2

M1002 set_filament_type:TPU
;M1002 set_flag extrude_cali_flag=1
M1002 judge_flag extrude_cali_flag
M622 J1
    M1002 gcode_claim_action : 8
    
    M400
    M900 K0.0 L1000.0 M1.0
    G90
    M83
    G0 X68 Y-4 F30000
    G0 Z0.3 F18000 ;Move to start position
    M400
    G0 X88 E10  F70.9646
    G0 X93 E.3742  F118.274
    G0 X98 E.3742  F473.097
    G0 X103 E.3742  F118.274
    G0 X108 E.3742  F473.097
    G0 X113 E.3742  F118.274
    G0 Y0 Z0 F20000
    M400
    
    G1 X-13.5 Y0 Z10 F10000
    M400
    
    G1 E10 F29.5686
    M983 F0.49281 A0.3 H0.4; cali dynamic extrusion compensation
    M106 P1 S178
    M400 S7
    G1 X0 F18000
    G1 X-13.5 F3000
    G1 X0 F18000 ;wipe and shake
    G1 X-13.5 F3000
    G1 X0 F12000 ;wipe and shake
    G1 X-13.5 F3000
    M400
    M106 P1 S0

    M1002 judge_last_extrude_cali_success
    M622 J0
        M983 F0.49281 A0.3 H0.4; cali dynamic extrusion compensation
        M106 P1 S178
        M400 S7
        G1 X0 F18000
        G1 X-13.5 F3000
        G1 X0 F18000 ;wipe and shake
        G1 X-13.5 F3000
        G1 X0 F12000 ;wipe and shake
        M400
        M106 P1 S0
    M623
    
M73 P27 R17
    G1 X-13.5 F3000
    M400
    M984 A0.1 E1 S1 F0.49281 H0.4
    M106 P1 S178
    M400 S7
    G1 X0 F18000
M73 P28 R17
    G1 X-13.5 F3000
    G1 X0 F18000 ;wipe and shake
    G1 X-13.5 F3000
    G1 X0 F12000 ;wipe and shake
    G1 X-13.5 F3000
    M400
    M106 P1 S0

M623 ; end of "draw extrinsic para cali paint"

;===== extrude cali test ===============================
M104 S230
G90
M83
G0 X68 Y-2.5 F30000
G0 Z0.3 F18000 ;Move to start position
G0 X88 E10  F70.9646
G0 X93 E.3742  F118.274
G0 X98 E.3742  F473.097
G0 X103 E.3742  F118.274
G0 X108 E.3742  F473.097
G0 X113 E.3742  F118.274
G0 X115 Z0 F20000
G0 Z5
M400

;========turn off light and wait extrude temperature =============
M1002 gcode_claim_action : 0

M400 ; wait all motion done before implement the emprical L parameters

;===== for Textured PEI Plate , lower the nozzle as the nozzle was touching topmost of the texture when homing ==
;curr_bed_type=Textured PEI Plate

G29.1 Z-0.02 ; for Textured PEI Plate


M960 S1 P0 ; turn off laser
M960 S2 P0 ; turn off laser
M106 S0 ; turn off fan
M106 P2 S0 ; turn off big fan
M106 P3 S0 ; turn off chamber fan

M975 S1 ; turn on mech mode supression
G90
M83
T1000

M211 X0 Y0 Z0 ;turn off soft endstop
M1007 S1



; MACHINE_START_GCODE_END
; filament start gcode
M106 P3 S180
 
;VT0 H-1
G90
G21
M83 ; use relative distances for extrusion
M981 S1 P20000 ;open spaghetti detector
; CHANGE_LAYER
; Z_HEIGHT: 0.2
; LAYER_HEIGHT: 0.2
G1 E-.4 F1800
; layer num/total_layer_count: 1/49
; update layer progress
M73 L1
M991 S0 P0 ;notify layer change
M106 S0
; OBJECT_ID: 8
G1 X95.25 Y93.151 F18000
M204 S6000
G1 Z.4
M73 P30 R16
G1 Z.2
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.5
G1 F900
M204 S500
G1 X95.25 Y89.651 E.13302
G1 X98.75 Y89.651 E.13302
G1 X98.75 Y93.151 E.13302
G1 X95.31 Y93.151 E.13074
; WIPE_START
M73 P31 R16
G1 X95.276 Y91.151 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S6000
G1 X95.25 Y89.194 Z.6 F18000
G1 Z.2
G1 E.4 F1800
; FEATURE: Inner wall
G1 F900
M204 S500
G1 X94.707 Y89.194 E.02064
G1 X94.707 Y88.109 E.04123
G1 X99.293 Y88.109 E.17429
G1 X99.293 Y89.194 E.04123
G1 X95.31 Y89.194 E.15138
; WIPE_START
G1 X94.707 Y89.194 E-.11456
G1 X94.707 Y88.109 E-.20612
G1 X95.019 Y88.109 E-.05932
; WIPE_END
M73 P32 R16
G1 E-.02 F1800
M204 S6000
G1 X99.293 Y93.608 Z.6 F18000
G1 Z.2
M73 P33 R16
G1 E.4 F1800
G1 F900
M204 S500
G1 X99.293 Y94.693 E.04123
G1 X95.299 Y94.694 E.15179
G1 X95.295 Y95.169 E.01804
G1 X94.707 Y94.74 E.02766
G1 X94.707 Y93.608 E.04302
G1 X99.233 Y93.608 E.17201
; WIPE_START
G1 X99.293 Y94.693 E-.20645
G1 X98.379 Y94.693 E-.17356
; WIPE_END
G1 E-.02 F1800
M204 S6000
G1 X95.288 Y95.653 Z.6 F18000
G1 Z.2
G1 E.4 F1800
G1 F900
M204 S500
G1 X95.226 Y95.914 E.01021
G1 X95.16 Y96.035 E.00523
G1 X95.075 Y96.143 E.00523
G1 X94.972 Y96.235 E.00524
G1 X94.863 Y96.302 E.00484
G1 X94.682 Y96.368 E.00735
G1 X94.398 Y96.401 E.01087
G1 X94.327 Y96.19 E.00845
G1 X94.673 Y95.986 E.01527
G1 X95.114 Y95.563 E.02323
G1 X95.235 Y95.625 E.00516
; WIPE_START
G1 X95.226 Y95.914 E-.05488
G1 X95.16 Y96.035 E-.02616
G1 X95.075 Y96.143 E-.02616
G1 X94.972 Y96.235 E-.02619
G1 X94.863 Y96.302 E-.0242
G1 X94.682 Y96.368 E-.03674
G1 X94.398 Y96.401 E-.05433
G1 X94.327 Y96.19 E-.04223
G1 X94.673 Y95.986 E-.07632
G1 X94.721 Y95.94 E-.01279
; WIPE_END
G1 E-.02 F1800
M204 S6000
G1 X90.705 Y99.851 Z.6 F18000
G1 Z.2
G1 E.4 F1800
G1 F900
M204 S500
G1 X90.709 Y99.911 E.0023
G1 X90.666 Y100.385 E.01806
G1 X90.537 Y100.853 E.01847
G1 X90.331 Y101.281 E.01806
G1 X90.142 Y101.558 E.01272
G1 X89.923 Y101.809 E.0127
G1 X89.567 Y102.111 E.01773
G1 X89.283 Y102.286 E.01265
G1 X88.98 Y102.426 E.0127
G1 X88.524 Y102.56 E.01807
G1 X88.04 Y102.611 E.01847
G1 X87.567 Y102.575 E.01804
G1 X87.241 Y102.501 E.01273
G1 X86.928 Y102.388 E.01264
G1 X86.507 Y102.163 E.01812
G1 X86.127 Y101.86 E.01848
G1 X85.815 Y101.502 E.01806
G1 X85.635 Y101.22 E.01271
G1 X85.49 Y100.92 E.01265
G1 X85.349 Y100.465 E.01812
G1 X85.291 Y99.982 E.01848
G1 X85.32 Y99.508 E.01805
G1 X85.389 Y99.181 E.01272
G1 X85.497 Y98.866 E.01264
G1 X85.716 Y98.442 E.01814
G1 X86.014 Y98.058 E.01848
G1 X86.368 Y97.739 E.01813
G1 X86.646 Y97.555 E.01264
G1 X86.945 Y97.406 E.01271
G1 X87.397 Y97.259 E.01806
G1 X87.878 Y97.194 E.01847
G1 X88.353 Y97.215 E.01805
G1 X88.682 Y97.28 E.01273
G1 X89 Y97.383 E.01271
G1 X89.425 Y97.596 E.01806
G1 X89.805 Y97.881 E.01806
G1 X90.039 Y98.119 E.01271
G1 X90.244 Y98.383 E.01271
G1 X90.476 Y98.798 E.01806
G1 X90.629 Y99.248 E.01807
G1 X90.689 Y99.578 E.01273
G1 X90.702 Y99.791 E.00811
M204 S6000
G1 X90.249 Y99.878 F18000
; FEATURE: Outer wall
G1 F900
M204 S500
G1 X90.251 Y99.904 E.001
G1 X90.215 Y100.303 E.0152
G1 X90.107 Y100.692 E.01535
G1 X89.934 Y101.052 E.0152
G1 X89.78 Y101.278 E.01037
G1 X89.601 Y101.483 E.01036
G1 X89.297 Y101.74 E.01512
G1 X89.066 Y101.883 E.01031
G1 X88.819 Y101.997 E.01036
G1 X88.435 Y102.109 E.01521
G1 X88.034 Y102.152 E.01534
G1 X87.636 Y102.122 E.01517
G1 X87.369 Y102.061 E.01039
G1 X87.114 Y101.97 E.0103
G1 X86.76 Y101.78 E.01526
G1 X86.444 Y101.528 E.01534
G1 X86.181 Y101.227 E.01519
G1 X86.035 Y100.997 E.01037
G1 X85.917 Y100.753 E.01031
G1 X85.798 Y100.369 E.01526
G1 X85.75 Y99.968 E.01535
G1 X85.774 Y99.569 E.01518
G1 X85.831 Y99.302 E.01038
G1 X85.918 Y99.046 E.0103
G1 X86.103 Y98.689 E.01527
G1 X86.35 Y98.37 E.01534
G1 X86.649 Y98.101 E.01527
G1 X86.875 Y97.952 E.0103
G1 X87.119 Y97.83 E.01037
G1 X87.499 Y97.706 E.01519
G1 X87.899 Y97.652 E.01534
G1 X88.298 Y97.67 E.01519
G1 X88.566 Y97.723 E.01039
G1 X88.826 Y97.807 E.01036
G1 X89.183 Y97.986 E.01519
G1 X89.503 Y98.226 E.0152
G1 X89.695 Y98.42 E.01037
G1 X89.862 Y98.636 E.01037
G1 X90.056 Y98.985 E.01519
G1 X90.186 Y99.364 E.0152
G1 X90.234 Y99.632 E.01038
G1 X90.246 Y99.818 E.00708
; WIPE_START
G1 X90.251 Y99.904 E-.0164
G1 X90.215 Y100.303 E-.07598
G1 X90.107 Y100.692 E-.07671
G1 X89.934 Y101.052 E-.07596
G1 X89.78 Y101.278 E-.05186
G1 X89.601 Y101.483 E-.05177
G1 X89.475 Y101.589 E-.03131
; WIPE_END
G1 E-.02 F1800
M204 S6000
G1 X86.982 Y96.208 Z.6 F18000
G1 Z.2
G1 E.4 F1800
; FEATURE: Inner wall
G1 F900
M204 S500
G1 X89.142 Y96.208 E.08212
G1 X90.614 Y97.899 E.08521
G1 X90.822 Y98.206 E.01407
G1 X91.005 Y98.558 E.0151
G1 X91.195 Y99.105 E.02201
G1 X91.267 Y99.5 E.01525
G1 X91.292 Y99.901 E.01524
G1 X91.241 Y100.481 E.02214
G1 X91.154 Y100.844 E.0142
G1 X91.017 Y101.217 E.01511
G1 X90.838 Y101.569 E.015
G1 X90.505 Y102.038 E.02186
G1 X90.086 Y102.448 E.02227
G1 X89.76 Y102.682 E.01525
G1 X89.409 Y102.877 E.01526
G1 X88.859 Y103.079 E.02226
G1 X88.283 Y103.181 E.02227
G1 X87.707 Y103.18 E.02187
G1 X87.141 Y103.079 E.02186
G1 X86.751 Y102.947 E.01565
G1 X86.24 Y102.682 E.02187
G1 X85.922 Y102.454 E.01485
G1 X85.634 Y102.19 E.01485
G1 X85.373 Y101.885 E.01526
G1 X85.07 Y101.4 E.02173
G1 X84.911 Y101.039 E.015
G1 X84.798 Y100.665 E.01484
G1 X84.73 Y100.28 E.01486
G1 X84.708 Y99.89 E.01486
G1 X84.733 Y99.5 E.01484
G1 X84.803 Y99.116 E.01486
G1 X84.919 Y98.743 E.01485
G1 X85.082 Y98.376 E.01526
G1 X85.391 Y97.895 E.02172
G1 X86.856 Y96.208 E.08491
G1 X86.922 Y96.208 E.00251
; WIPE_START
G1 X88.922 Y96.208 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S6000
G1 X81.666 Y96.148 Z.6 F18000
G1 Z.2
G1 E.4 F1800
G1 F900
M204 S500
G1 X81.621 Y96.403 E.00983
G1 X81.308 Y96.367 E.01198
G1 X81.177 Y96.323 E.00524
G1 X81.036 Y96.242 E.0062
G1 X80.933 Y96.15 E.00524
G1 X80.777 Y95.923 E.01047
G1 X80.734 Y95.793 E.00519
G1 X80.695 Y95.458 E.01284
G1 X80.92 Y95.394 E.00888
G1 X81.064 Y95.704 E.013
G1 X81.244 Y95.918 E.01061
G1 X81.526 Y96.115 E.01308
G1 X81.608 Y96.135 E.0032
; WIPE_START
G1 X81.621 Y96.403 E-.0511
G1 X81.308 Y96.367 E-.05991
G1 X81.177 Y96.323 E-.02618
G1 X81.036 Y96.242 E-.031
G1 X80.933 Y96.15 E-.02617
G1 X80.777 Y95.923 E-.05235
G1 X80.734 Y95.793 E-.02595
G1 X80.695 Y95.458 E-.06417
G1 X80.914 Y95.396 E-.04317
; WIPE_END
G1 E-.02 F1800
M204 S6000
G1 X81.234 Y87.77 Z.6 F18000
G1 X81.685 Y77.018 Z.6
G1 Z.2
G1 E.4 F1800
G1 F900
M204 S500
G1 X81.325 Y77.212 E.01556
G1 X81.073 Y77.479 E.01397
G1 X80.922 Y77.803 E.01359
G1 X80.707 Y77.756 E.00837
G1 X80.713 Y77.519 E.009
G1 X80.743 Y77.374 E.00563
G1 X80.798 Y77.237 E.00562
G1 X80.925 Y77.059 E.00833
G1 X81.035 Y76.961 E.00558
G1 X81.23 Y76.858 E.00837
G1 X81.372 Y76.82 E.00558
G1 X81.633 Y76.81 E.00994
G1 X81.671 Y76.959 E.00584
; WIPE_START
G1 X81.325 Y77.212 E-.08132
G1 X81.073 Y77.479 E-.06983
G1 X80.922 Y77.803 E-.06795
G1 X80.707 Y77.756 E-.04183
G1 X80.713 Y77.519 E-.04497
G1 X80.743 Y77.374 E-.02813
G1 X80.798 Y77.237 E-.0281
G1 X80.852 Y77.16 E-.01788
; WIPE_END
G1 E-.02 F1800
M204 S6000
G1 X88.482 Y77.362 Z.6 F18000
G1 X95.292 Y77.542 Z.6
G1 Z.2
G1 E.4 F1800
G1 F900
M204 S500
G1 X95.115 Y77.639 E.00767
G1 X94.672 Y77.216 E.02329
G1 X94.327 Y77.011 E.01527
G1 X94.398 Y76.801 E.00845
G1 X94.682 Y76.834 E.01088
G1 X94.863 Y76.9 E.00734
G1 X94.964 Y76.962 E.00449
G1 X95.111 Y77.101 E.0077
G1 X95.178 Y77.197 E.00445
G1 X95.259 Y77.384 E.00774
G1 X95.279 Y77.483 E.00382
; WIPE_START
G1 X95.115 Y77.639 E-.04313
G1 X94.672 Y77.216 E-.11642
G1 X94.327 Y77.011 E-.07631
G1 X94.398 Y76.801 E-.04224
G1 X94.682 Y76.834 E-.05437
G1 X94.863 Y76.9 E-.0367
G1 X94.912 Y76.93 E-.01082
; WIPE_END
G1 E-.02 F1800
M204 S6000
G1 X98.836 Y78.966 Z.6 F18000
G1 Z.2
G1 E.4 F1800
G1 F900
M204 S500
G1 X98.835 Y84.637 E.21553
G1 X95.164 Y84.636 E.13951
G1 X95.165 Y78.965 E.21554
G1 X98.776 Y78.966 E.13723
M204 S6000
G1 X99.293 Y78.509 F18000
G1 F900
M204 S500
G1 X99.292 Y85.094 E.25027
G1 X94.707 Y85.093 E.17425
G1 X94.708 Y78.461 E.25204
G1 X95.299 Y78.03 E.02779
G1 X95.312 Y78.508 E.01815
G1 X99.233 Y78.509 E.14903
; WIPE_START
G1 X99.251 Y80.509 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S6000
G1 X94.377 Y86.383 Z.6 F18000
G1 X85.692 Y96.851 Z.6
G1 Z.2
G1 E.4 F1800
; FEATURE: Outer wall
G1 F900
M204 S500
G1 X81.515 Y96.851 E.15876
G1 X81.208 Y96.815 E.01171
G1 X81.002 Y96.747 E.00828
G1 X80.875 Y96.683 E.00538
G1 X80.757 Y96.605 E.00539
G1 X80.594 Y96.46 E.00828
G1 X80.415 Y96.219 E.01143
G1 X80.354 Y96.098 E.00516
G1 X80.286 Y95.892 E.00822
G1 X80.25 Y95.586 E.01171
G1 X80.25 Y77.608 E.68328
G1 X80.259 Y77.459 E.00567
G1 X80.303 Y77.243 E.00841
M73 P33 R15
G1 X80.385 Y77.037 E.00841
M73 P34 R15
G1 X80.454 Y76.917 E.00525
G1 X80.591 Y76.744 E.00841
G1 X80.756 Y76.597 E.00836
G1 X80.872 Y76.521 E.0053
G1 X81.073 Y76.427 E.00841
G1 X81.285 Y76.37 E.00836
G1 X81.428 Y76.353 E.00544
G1 X94.487 Y76.351 E.49633
G1 X94.788 Y76.386 E.01153
G1 X95.064 Y76.487 E.01115
G1 X95.244 Y76.598 E.00805
G1 X95.459 Y76.801 E.01124
G1 X95.58 Y76.973 E.008
G1 X95.697 Y77.246 E.01129
G1 X95.741 Y77.456 E.00813
G1 X95.757 Y78.051 E.02263
G1 X99.413 Y78.052 E.13896
G1 X99.496 Y78.067 E.00321
G1 X99.591 Y78.111 E.00397
G1 X99.711 Y78.245 E.00684
G1 X99.75 Y78.416 E.00666
G1 X99.749 Y85.214 E.25838
G1 X99.734 Y85.297 E.00322
G1 X99.689 Y85.395 E.0041
G1 X99.553 Y85.513 E.00685
G1 X99.385 Y85.551 E.00652
G1 X94.587 Y85.55 E.18237
G1 X94.426 Y85.503 E.00638
G1 X94.311 Y85.395 E.00596
G1 X94.267 Y85.3 E.00397
G1 X94.25 Y85.183 E.00453
G1 X94.251 Y78.388 E.25823
G1 X94.265 Y78.305 E.00319
G1 X94.358 Y78.151 E.00683
G1 X94.716 Y77.89 E.01685
G1 X94.395 Y77.582 E.01691
G1 X94.253 Y77.499 E.00625
G1 X94.026 Y77.451 E.00882
G1 X81.978 Y77.451 E.4579
G1 X81.78 Y77.486 E.00764
G1 X81.607 Y77.579 E.00748
G1 X81.456 Y77.739 E.00836
G1 X81.375 Y77.914 E.00733
G1 X81.35 Y78.083 E.00648
G1 X81.35 Y95.119 E.64749
G1 X81.375 Y95.288 E.00649
G1 X81.453 Y95.456 E.00705
G1 X81.555 Y95.578 E.00603
G1 X81.716 Y95.691 E.00747
G1 X81.971 Y95.751 E.00994
G1 X94.026 Y95.751 E.45818
G1 X94.253 Y95.703 E.00882
G1 X94.395 Y95.619 E.00625
G1 X94.716 Y95.312 E.0169
G1 X94.357 Y95.05 E.01685
G1 X94.267 Y94.9 E.00669
G1 X94.25 Y94.783 E.00448
G1 X94.25 Y88.019 E.25706
G1 X94.267 Y87.903 E.00445
G1 X94.325 Y87.788 E.00492
G1 X94.444 Y87.69 E.00584
G1 X94.583 Y87.652 E.0055
G1 X99.406 Y87.652 E.18328
G1 X99.541 Y87.684 E.00528
G1 X99.623 Y87.735 E.00369
G1 X99.688 Y87.807 E.00368
G1 X99.74 Y87.928 E.00499
G1 X99.75 Y94.779 E.26038
G1 X99.725 Y94.919 E.00541
G1 X99.661 Y95.03 E.00486
G1 X99.557 Y95.113 E.00508
G1 X99.413 Y95.15 E.00564
G1 X95.752 Y95.151 E.13913
G1 X95.748 Y95.669 E.01968
G1 X95.715 Y95.889 E.00846
G1 X95.647 Y96.096 E.00828
G1 X95.544 Y96.287 E.00827
G1 X95.409 Y96.458 E.00827
G1 X95.246 Y96.603 E.00828
G1 X95.064 Y96.715 E.00814
G1 X94.788 Y96.816 E.01115
G1 X94.485 Y96.851 E.01158
G1 X90.308 Y96.851 E.15878
G1 X90.972 Y97.615 E.03849
G1 X91.219 Y97.977 E.01664
G1 X91.423 Y98.372 E.01691
G1 X91.583 Y98.796 E.01721
G1 X91.641 Y99.003 E.00818
G1 X91.722 Y99.444 E.01706
G1 X91.75 Y99.892 E.01705
G1 X91.744 Y100.108 E.00819
G1 X91.692 Y100.554 E.01706
G1 X91.647 Y100.772 E.00847
G1 X91.59 Y100.983 E.00832
G1 X91.436 Y101.401 E.01691
G1 X91.233 Y101.801 E.01707
G1 X90.983 Y102.174 E.01706
G1 X90.847 Y102.341 E.00818
G1 X90.533 Y102.666 E.0172
G1 X90.37 Y102.807 E.00818
G1 X90.005 Y103.069 E.01706
G1 X89.612 Y103.286 E.01707
G1 X89.415 Y103.373 E.00818
G1 X88.987 Y103.519 E.0172
G1 X88.777 Y103.569 E.00818
G1 X88.33 Y103.636 E.01719
G1 X88.115 Y103.649 E.00818
G1 X87.666 Y103.636 E.01706
G1 X87.222 Y103.569 E.01706
G1 X87.013 Y103.518 E.00819
G1 X86.585 Y103.373 E.0172
G1 X86.388 Y103.286 E.00819
G1 X85.995 Y103.069 E.01706
G1 X85.633 Y102.809 E.01692
G1 X85.305 Y102.508 E.01692
G1 X85.013 Y102.168 E.01706
G1 X84.888 Y101.992 E.00818
G1 X84.662 Y101.609 E.01691
G1 X84.482 Y101.198 E.01707
G1 X84.353 Y100.772 E.01691
G1 X84.275 Y100.333 E.01692
G1 X84.25 Y99.889 E.01692
G1 X84.278 Y99.445 E.01691
G1 X84.359 Y99.007 E.01692
G1 X84.49 Y98.581 E.01692
G1 X84.673 Y98.171 E.01706
G1 X84.778 Y97.983 E.00818
G1 X85.028 Y97.615 E.01692
G1 X85.652 Y96.896 E.0362
; WIPE_START
G1 X83.653 Y96.874 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S6000
G17
G3 Z.6 I1.217 J0 P1  F18000
;===================== date: 20250206 =====================

; don't support timelapse gcode in spiral_mode and by object sequence for I3 structure printer
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
G92 E0
G1 Z0.6
G1 X0 Y90 ; move to safe pos
G1 X-13.0 F3000 ; move to safe pos
M400
M1004 S5 P1  ; external shutter
M400 P300
M971 S11 C11 O0
G92 E0
G1 X0 F18000
M623

; SKIPTYPE: head_wrap_detect
M622.1 S1
M1002 judge_flag g39_3rd_layer_detect_flag
M622 J1
    ; enable nozzle clog detect at 3rd layer
    


    M622.1 S1
    M1002 judge_flag g39_detection_flag
    M622 J1
      
        M622.1 S0
        M1002 judge_flag g39_mass_exceed_flag
        M622 J1
        
        M623
    
    M623
M623
; SKIPPABLE_END




G1 X81.871 Y96.301
G1 Z.2
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.68586
G1 F900
M204 S500
G1 X86.472 Y96.301 E.24597
M204 S6000
G1 X86.604 Y96.846 F18000
; LINE_WIDTH: 0.679009
G1 F900
M204 S500
G1 X87.251 Y96.743 E.03462
; LINE_WIDTH: 0.630729
G1 X87.569 Y96.719 E.01559
; LINE_WIDTH: 0.591063
G1 X87.833 Y96.702 E.01204
; LINE_WIDTH: 0.581765
G1 X88.393 Y96.712 E.0251
; LINE_WIDTH: 0.613207
G1 X88.617 Y96.732 E.01068
; LINE_WIDTH: 0.652652
G1 X88.8 Y96.75 E.00932
; LINE_WIDTH: 0.687558
G1 X89.392 Y96.843 E.03212
M204 S6000
G1 X89.273 Y97.028 F18000
; LINE_WIDTH: 0.485896
G1 F900
M204 S500
G1 X89.19 Y96.964 E.00385
; LINE_WIDTH: 0.514588
G1 X88.454 Y96.436 E.03552
; WIPE_START
G1 X89.19 Y96.964 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S6000
G1 X89.273 Y97.028 Z.6 F18000
G1 Z.2
G1 E.4 F1800
; LINE_WIDTH: 0.445271
G1 F900
M204 S500
G1 X89.355 Y97.092 E.0035
; LINE_WIDTH: 0.404646
G1 X89.438 Y97.156 E.00314
; LINE_WIDTH: 0.36402
G1 X89.521 Y97.22 E.00279
; LINE_WIDTH: 0.323395
G1 X89.603 Y97.284 E.00244
; LINE_WIDTH: 0.280531
G1 X89.747 Y97.416 E.00386
; LINE_WIDTH: 0.241654
G1 X89.873 Y97.533 E.00284
; LINE_WIDTH: 0.205357
G1 X89.999 Y97.65 E.00232
; LINE_WIDTH: 0.168624
G1 X90.383 Y98.082 E.00604
M73 P35 R15
G1 X90.566 Y98.354 E.00343
G1 X90.74 Y98.676 E.00382
G1 X90.911 Y99.173 E.00549
G1 X90.978 Y99.539 E.00389
G1 X91 Y99.92 E.00399
G1 X90.954 Y100.435 E.0054
G1 X90.809 Y100.949 E.00559
G1 X90.587 Y101.421 E.00544
G1 X90.368 Y101.736 E.00402
G1 X90.12 Y102.016 E.0039
G1 X89.733 Y102.347 E.00533
G1 X89.28 Y102.612 E.00548
G1 X88.778 Y102.794 E.00558
G1 X88.574 Y102.841 E.00219
G1 X88.05 Y102.896 E.00551
G1 X87.529 Y102.859 E.00546
G1 X87.163 Y102.78 E.00391
G1 X86.814 Y102.655 E.00387
G1 X86.353 Y102.408 E.00547
G1 X85.924 Y102.065 E.00574
G1 X85.605 Y101.706 E.00502
G1 X85.381 Y101.357 E.00433
G1 X85.219 Y101.022 E.00389
G1 X85.068 Y100.53 E.00538
G1 X85.003 Y99.996 E.00562
G1 X85.024 Y99.536 E.00481
G1 X85.088 Y99.186 E.00372
G1 X85.229 Y98.756 E.00472
G1 X85.473 Y98.293 E.00548
G1 X85.798 Y97.865 E.00562
G1 X85.986 Y97.673 E.00281
; LINE_WIDTH: 0.210275
G1 X86.167 Y97.489 E.00359
; LINE_WIDTH: 0.227485
G1 X86.177 Y97.48 E.00021
; LINE_WIDTH: 0.253754
G1 X86.315 Y97.359 E.00322
; LINE_WIDTH: 0.303555
G1 X86.453 Y97.238 E.00397
; LINE_WIDTH: 0.331337
G1 X86.466 Y97.227 E.00042
; LINE_WIDTH: 0.358379
G1 X86.564 Y97.151 E.00326
; LINE_WIDTH: 0.40667
G1 X86.662 Y97.075 E.00375
; LINE_WIDTH: 0.45496
G1 X86.761 Y96.999 E.00425
; LINE_WIDTH: 0.487018
G1 X86.788 Y96.979 E.00126
; WIPE_START
G1 X86.761 Y96.999 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S6000
G1 X89.526 Y96.301 Z.6 F18000
G1 Z.2
G1 E.4 F1800
; LINE_WIDTH: 0.68586
G1 F900
M204 S500
G1 X94.123 Y96.301 E.24573
; WIPE_START
G1 X92.123 Y96.301 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S6000
G1 X94.936 Y94.151 Z.6 F18000
G1 Z.2
G1 E.4 F1800
; LINE_WIDTH: 0.671412
G1 F900
M204 S500
G1 X99.064 Y94.15 E.21577
M204 S6000
G1 X99.25 Y93.379 F18000
; LINE_WIDTH: 0.58586
G1 F900
M204 S500
G1 X99.25 Y89.422 E.17864
M204 S6000
G1 X99.064 Y88.651 F18000
; LINE_WIDTH: 0.6707
G1 F900
M204 S500
G1 X94.936 Y88.651 E.21552
M204 S6000
G1 X94.75 Y89.422 F18000
; LINE_WIDTH: 0.58586
G1 F900
M204 S500
G1 X94.75 Y93.379 E.17864
; WIPE_START
G1 X94.75 Y91.379 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S6000
G1 X87.387 Y93.391 Z.6 F18000
G1 X80.803 Y95.189 Z.6
G1 Z.2
G1 E.4 F1800
; LINE_WIDTH: 0.691852
G1 F900
M204 S500
G1 X80.803 Y78.011 E.92691
; WIPE_START
G1 X80.803 Y80.011 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S6000
G1 X81.892 Y76.902 Z.6 F18000
G1 Z.2
G1 E.4 F1800
; LINE_WIDTH: 0.684579
G1 F900
M204 S500
G1 X94.123 Y76.901 E.65254
; WIPE_START
G1 X92.123 Y76.901 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S6000
G1 X97.694 Y79.148 Z.6 F18000
G1 Z.2
G1 E.4 F1800
; FEATURE: Bottom surface
; LINE_WIDTH: 0.51623
G1 F900
M204 S500
G1 X98.447 Y79.901 E.04191
G1 X98.447 Y80.571 E.02634
G1 X97.23 Y79.354 E.06771
G1 X96.561 Y79.354 E.02635
G1 X98.447 Y81.24 E.10497
G1 X98.447 Y81.909 E.02634
G1 X95.891 Y79.354 E.14224
G1 X95.554 Y79.353 E.01329
G1 X95.553 Y79.685 E.01305
G1 X98.447 Y82.578 E.16103
G1 X98.447 Y83.248 E.02634
G1 X95.553 Y80.354 E.16103
G1 X95.553 Y81.024 E.02634
G1 X98.447 Y83.917 E.16103
G1 X98.447 Y84.248 E.01304
G1 X98.108 Y84.248 E.01331
G1 X95.553 Y81.693 E.14222
G1 X95.553 Y82.362 E.02634
G1 X97.439 Y84.248 E.10496
G1 X96.769 Y84.248 E.02635
G1 X95.553 Y83.031 E.0677
G1 X95.553 Y83.701 E.02634
G1 X96.306 Y84.453 E.04189
; CHANGE_LAYER
; Z_HEIGHT: 0.32
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F900
G1 X95.553 Y83.701 E-.20225
G1 X95.553 Y83.031 E-.12716
G1 X95.741 Y83.22 E-.05059
; WIPE_END
G1 E-.02 F1800
; layer num/total_layer_count: 2/49
; update layer progress
M73 L2
M991 S0 P1 ;notify layer change
M106 S255
; open powerlost recovery
M1003 S1
; OBJECT_ID: 8
M204 S10000
G17
G3 Z.6 I-1.216 J-.055 P1  F18000
G1 X95.29 Y93.111 Z.6
G1 Z.32
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X95.29 Y89.691 E.06727
G1 X98.71 Y89.691 E.06727
G1 X98.71 Y93.111 E.06727
G1 X95.35 Y93.111 E.06609
; WIPE_START
M204 S6000
G1 X95.315 Y91.111 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X89.876 Y96.466 Z.72 F18000
G1 X89.229 Y97.104 Z.72
G1 Z.32
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X88.766 Y96.954 E.0103
G1 X88.393 Y96.88 E.00805
G1 X87.879 Y96.857 E.0109
G1 X87.501 Y96.897 E.00804
G1 X87.131 Y96.981 E.00804
G1 X86.762 Y97.126 E.00839
G1 X86.647 Y96.963 E.00423
G1 X87.011 Y96.544 E.01174
G1 X88.989 Y96.544 E.04188
G1 X89.336 Y96.942 E.01117
G1 X89.262 Y97.054 E.00283
; WIPE_START
M204 S6000
G1 X88.766 Y96.954 E-.09609
G1 X88.393 Y96.88 E-.07223
G1 X87.879 Y96.857 E-.09782
G1 X87.501 Y96.897 E-.07217
G1 X87.287 Y96.945 E-.04168
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X90.617 Y99.844 Z.72 F18000
G1 Z.32
G1 E.4 F1800
G1 F1500
M204 S500
G1 X90.622 Y99.901 E.0012
G1 X90.58 Y100.369 E.00995
G1 X90.455 Y100.822 E.00995
G1 X90.255 Y101.237 E.00975
G1 X90.073 Y101.504 E.00683
G1 X89.86 Y101.747 E.00684
G1 X89.511 Y102.042 E.00967
G1 X89.242 Y102.208 E.00671
G1 X88.949 Y102.344 E.00683
G1 X88.507 Y102.473 E.00975
G1 X88.039 Y102.522 E.00995
G1 X87.58 Y102.488 E.00975
G1 X87.265 Y102.416 E.00683
G1 X86.967 Y102.309 E.00671
G1 X86.556 Y102.089 E.00986
G1 X86.188 Y101.796 E.00996
G1 X85.879 Y101.442 E.00995
G1 X85.643 Y101.046 E.00975
G1 X85.52 Y100.748 E.00683
G1 X85.434 Y100.437 E.00683
G1 X85.379 Y99.979 E.00975
G1 X85.407 Y99.519 E.00975
G1 X85.474 Y99.204 E.00682
G1 X85.576 Y98.904 E.00671
G1 X85.79 Y98.49 E.00986
G1 X86.078 Y98.118 E.00996
G1 X86.427 Y97.803 E.00995
G1 X86.827 Y97.556 E.00995
G1 X87.256 Y97.388 E.00975
G1 X87.571 Y97.316 E.00683
G1 X87.892 Y97.282 E.00683
G1 X88.343 Y97.302 E.00955
G1 X88.659 Y97.365 E.00684
G1 X88.966 Y97.465 E.00683
G1 X89.37 Y97.666 E.00955
G1 X89.634 Y97.852 E.00683
G1 X89.874 Y98.068 E.00683
G1 X90.16 Y98.417 E.00956
G1 X90.326 Y98.694 E.00683
G1 X90.457 Y98.989 E.00683
G1 X90.58 Y99.433 E.00975
G1 X90.611 Y99.785 E.00748
M204 S250
G1 X90.209 Y99.881 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X90.211 Y99.901 E.00039
G1 X90.175 Y100.296 E.00779
G1 X90.07 Y100.678 E.0078
G1 X89.899 Y101.032 E.00773
G1 X89.749 Y101.253 E.00526
G1 X89.572 Y101.455 E.00526
G1 X89.271 Y101.71 E.00777
G1 X89.047 Y101.847 E.00515
G1 X88.805 Y101.96 E.00526
G1 X88.427 Y102.07 E.00773
G1 X88.033 Y102.111 E.0078
G1 X87.641 Y102.082 E.00773
G1 X87.38 Y102.023 E.00526
G1 X87.133 Y101.934 E.00516
G1 X86.782 Y101.746 E.00784
G1 X86.472 Y101.499 E.0078
G1 X86.211 Y101.2 E.0078
G1 X86.01 Y100.863 E.00773
G1 X85.908 Y100.615 E.00526
G1 X85.837 Y100.357 E.00526
G1 X85.79 Y99.967 E.00773
G1 X85.814 Y99.574 E.00774
G1 X85.869 Y99.313 E.00526
G1 X85.954 Y99.065 E.00516
G1 X86.137 Y98.711 E.00783
G1 X86.379 Y98.397 E.0078
G1 X86.674 Y98.132 E.0078
G1 X87.011 Y97.924 E.0078
G1 X87.377 Y97.78 E.00773
G1 X87.638 Y97.72 E.00526
G1 X87.904 Y97.692 E.00526
G1 X88.294 Y97.71 E.00767
G1 X88.556 Y97.762 E.00527
G1 X88.811 Y97.844 E.00526
G1 X89.159 Y98.019 E.00767
G1 X89.378 Y98.173 E.00526
G1 X89.577 Y98.352 E.00526
G1 X89.825 Y98.653 E.00767
G1 X89.962 Y98.883 E.00526
G1 X90.071 Y99.127 E.00526
G1 X90.175 Y99.506 E.00773
G1 X90.204 Y99.821 E.00622
; WIPE_START
M204 S6000
G1 X90.211 Y99.901 E-.0152
G1 X90.175 Y100.296 E-.0753
G1 X90.07 Y100.678 E-.07531
G1 X89.899 Y101.032 E-.07472
G1 X89.749 Y101.253 E-.05083
G1 X89.572 Y101.455 E-.05086
G1 X89.42 Y101.583 E-.03779
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X95.377 Y96.811 Z.72 F18000
G1 X98.955 Y93.944 Z.72
G1 Z.32
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X98.956 Y94.357 E.00872
G1 X95.043 Y94.358 E.08281
G1 X95.043 Y93.944 E.00875
G1 X98.895 Y93.944 E.08153
; WIPE_START
M204 S6000
G1 X98.956 Y94.357 E-.07915
G1 X97.373 Y94.357 E-.30085
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X95.29 Y88.857 Z.72 F18000
G1 Z.32
G1 E.4 F1800
G1 F1500
M204 S500
G1 X95.043 Y88.857 E.00522
G1 X95.043 Y88.445 E.00872
G1 X98.948 Y88.445 E.08265
G1 X98.949 Y88.857 E.00872
G1 X95.35 Y88.857 E.07617
; WIPE_START
M204 S6000
G1 X95.043 Y88.857 E-.05824
G1 X95.043 Y88.445 E-.07829
G1 X96.325 Y88.445 E-.24348
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X98.343 Y81.084 Z.72 F18000
G1 X98.956 Y78.845 Z.72
G1 Z.32
G1 E.4 F1800
G1 F1500
M204 S500
G1 X98.956 Y84.757 E.12513
G1 X95.044 Y84.756 E.0828
G1 X95.044 Y78.844 E.12514
G1 X98.896 Y78.845 E.08153
; WIPE_START
M204 S6000
G1 X98.916 Y80.845 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X94.164 Y86.817 Z.72 F18000
G1 X86.761 Y96.12 Z.72
G1 Z.32
G1 E.4 F1800
G1 F1500
M204 S500
G1 X94.064 Y96.12 E.15459
G1 X94.389 Y96.052 E.00701
G1 X94.619 Y95.916 E.00567
G1 X95.289 Y95.274 E.01964
G1 X94.619 Y94.784 E.01756
G1 X94.619 Y88.021 E.14315
G1 X99.372 Y88.021 E.10059
G1 X99.373 Y89.282 E.02668
G1 X94.881 Y89.282 E.09509
G1 X94.881 Y93.52 E.08971
G1 X99.119 Y93.52 E.08971
G1 X99.119 Y89.362 E.08802
G1 X99.374 Y89.361 E.00538
G1 X99.381 Y94.781 E.1147
G1 X95.386 Y94.782 E.08455
G1 X95.379 Y95.64 E.01817
G1 X95.355 Y95.803 E.00349
G1 X95.307 Y95.949 E.00324
G1 X95.234 Y96.083 E.00323
G1 X95.142 Y96.199 E.00313
G1 X94.977 Y96.337 E.00455
G1 X94.847 Y96.408 E.00313
G1 X94.711 Y96.453 E.00304
G1 X94.464 Y96.482 E.00527
G1 X89.497 Y96.482 E.10512
G1 X90.677 Y97.838 E.03805
G1 X91.001 Y98.344 E.01272
G1 X91.232 Y98.91 E.01293
M73 P36 R15
G1 X91.356 Y99.498 E.01273
G1 X91.374 Y100.1 E.01273
G1 X91.289 Y100.676 E.01233
G1 X91.171 Y101.07 E.00871
G1 X90.918 Y101.607 E.01254
G1 X90.57 Y102.097 E.01273
G1 X90.285 Y102.391 E.00867
G1 X89.974 Y102.644 E.00849
G1 X89.643 Y102.855 E.0083
G1 X89.273 Y103.032 E.00869
G1 X88.884 Y103.164 E.00869
G1 X88.292 Y103.269 E.01273
G1 X87.69 Y103.266 E.01274
G1 X87.116 Y103.164 E.01233
G1 X86.727 Y103.032 E.00869
G1 X86.357 Y102.855 E.00868
G1 X85.874 Y102.528 E.01234
G1 X85.571 Y102.251 E.00871
G1 X85.304 Y101.94 E.00868
G1 X84.994 Y101.446 E.01233
G1 X84.829 Y101.069 E.00871
G1 X84.713 Y100.686 E.00848
G1 X84.643 Y100.291 E.00849
G1 X84.62 Y99.89 E.00849
G1 X84.645 Y99.49 E.00848
G1 X84.72 Y99.086 E.00871
G1 X84.908 Y98.534 E.01234
G1 X85.097 Y98.17 E.00869
G1 X85.323 Y97.838 E.00849
G1 X86.503 Y96.482 E.03805
G1 X81.536 Y96.482 E.10513
G1 X81.289 Y96.453 E.00527
G1 X81.144 Y96.405 E.00324
G1 X80.889 Y96.231 E.00652
G1 X80.738 Y96.041 E.00513
G1 X80.648 Y95.812 E.0052
G1 X80.619 Y95.565 E.00528
G1 X80.619 Y77.619 E.37984
G1 X80.659 Y77.349 E.00578
G1 X80.761 Y77.125 E.00521
G1 X80.861 Y76.998 E.00342
G1 X80.982 Y76.89 E.00343
G1 X81.2 Y76.775 E.00521
G1 X81.449 Y76.723 E.0054
G1 X94.467 Y76.72 E.27553
G1 X94.702 Y76.748 E.005
G1 X94.893 Y76.818 E.00431
G1 X95.071 Y76.934 E.0045
G1 X95.173 Y77.036 E.00305
G1 X95.255 Y77.154 E.00305
G1 X95.343 Y77.358 E.00469
G1 X95.372 Y77.498 E.00303
G1 X95.397 Y78.42 E.01952
G1 X99.381 Y78.421 E.08431
G1 X99.38 Y85.182 E.14309
G1 X94.619 Y85.181 E.10076
G1 X94.62 Y78.417 E.14317
G1 X95.289 Y77.928 E.01753
G1 X94.619 Y77.286 E.01963
G1 X94.389 Y77.15 E.00567
G1 X94.064 Y77.082 E.00701
G1 X81.955 Y77.082 E.25631
G1 X81.696 Y77.12 E.00553
G1 X81.386 Y77.276 E.00735
G1 X81.147 Y77.529 E.00737
G1 X81.017 Y77.807 E.00649
G1 X80.981 Y78.056 E.00533
G1 X80.981 Y95.137 E.36153
G1 X81.005 Y95.346 E.00446
G1 X81.112 Y95.614 E.0061
G1 X81.296 Y95.847 E.00629
G1 X81.562 Y96.034 E.00689
G1 X81.928 Y96.12 E.00795
G1 X86.701 Y96.12 E.10103
; WIPE_START
M204 S6000
G1 X88.701 Y96.12 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X85.604 Y96.891 Z.72 F18000
G1 Z.32
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X81.512 Y96.891 E.08049
G1 X81.2 Y96.854 E.00619
G1 X80.987 Y96.784 E.00442
G1 X80.861 Y96.721 E.00277
G1 X80.611 Y96.534 E.00614
G1 X80.464 Y96.369 E.00435
G1 X80.383 Y96.246 E.00289
G1 X80.316 Y96.111 E.00296
G1 X80.247 Y95.901 E.00435
G1 X80.21 Y95.589 E.00619
G1 X80.21 Y77.607 E.35368
G1 X80.219 Y77.454 E.00301
G1 X80.265 Y77.231 E.00448
G1 X80.348 Y77.023 E.00441
G1 X80.421 Y76.895 E.0029
G1 X80.562 Y76.716 E.00448
G1 X80.732 Y76.565 E.00448
G1 X80.853 Y76.486 E.00283
G1 X81.059 Y76.389 E.00448
G1 X81.276 Y76.331 E.00441
G1 X81.425 Y76.313 E.00296
G1 X94.491 Y76.311 E.257
G1 X94.797 Y76.347 E.00605
G1 X95.078 Y76.449 E.00589
G1 X95.331 Y76.615 E.00594
G1 X95.488 Y76.772 E.00436
G1 X95.615 Y76.954 E.00436
G1 X95.736 Y77.234 E.00601
G1 X95.78 Y77.451 E.00435
G1 X95.796 Y78.011 E.01102
G1 X99.413 Y78.012 E.07116
G1 X99.536 Y78.037 E.00245
G1 X99.611 Y78.075 E.00166
G1 X99.697 Y78.151 E.00224
G1 X99.747 Y78.227 E.0018
G1 X99.79 Y78.413 E.00376
G1 X99.789 Y85.214 E.13377
G1 X99.764 Y85.337 E.00246
G1 X99.726 Y85.412 E.00165
G1 X99.647 Y85.5 E.00233
G1 X99.574 Y85.548 E.00171
G1 X99.388 Y85.591 E.00377
G1 X94.584 Y85.59 E.09449
G1 X94.406 Y85.537 E.00365
G1 X94.277 Y85.417 E.00347
G1 X94.229 Y85.312 E.00227
G1 X94.21 Y85.186 E.00252
G1 X94.211 Y78.385 E.13377
G1 X94.227 Y78.293 E.00182
G1 X94.276 Y78.187 E.00231
G1 X94.33 Y78.122 E.00166
G1 X94.653 Y77.886 E.00788
G1 X94.37 Y77.615 E.00771
G1 X94.238 Y77.536 E.00302
G1 X94.022 Y77.491 E.00435
G1 X81.985 Y77.491 E.23676
G1 X81.821 Y77.515 E.00325
G1 X81.634 Y77.609 E.00412
G1 X81.49 Y77.762 E.00413
G1 X81.413 Y77.925 E.00356
G1 X81.39 Y78.086 E.00319
G1 X81.39 Y95.113 E.33491
G1 X81.405 Y95.245 E.00261
G1 X81.47 Y95.407 E.00343
G1 X81.58 Y95.546 E.00349
G1 X81.733 Y95.653 E.00368
G1 X81.976 Y95.711 E.0049
G1 X94.022 Y95.711 E.23694
G1 X94.238 Y95.665 E.00435
G1 X94.37 Y95.587 E.00301
G1 X94.653 Y95.316 E.00771
G1 X94.332 Y95.082 E.00782
G1 X94.261 Y94.991 E.00227
G1 X94.229 Y94.914 E.00164
G1 X94.21 Y94.786 E.00255
G1 X94.21 Y88.019 E.13309
G1 X94.237 Y87.865 E.00307
G1 X94.29 Y87.767 E.00221
G1 X94.426 Y87.654 E.00347
G1 X94.58 Y87.612 E.00315
G1 X99.41 Y87.612 E.095
G1 X99.556 Y87.646 E.00295
G1 X99.647 Y87.702 E.00209
G1 X99.735 Y87.807 E.0027
G1 X99.781 Y87.934 E.00264
G1 X99.79 Y94.783 E.13471
G1 X99.763 Y94.933 E.00301
G1 X99.693 Y95.055 E.00276
G1 X99.575 Y95.149 E.00297
G1 X99.416 Y95.19 E.00322
G1 X95.792 Y95.191 E.07129
G1 X95.788 Y95.672 E.00946
G1 X95.754 Y95.898 E.0045
G1 X95.684 Y96.111 E.00442
G1 X95.577 Y96.309 E.00442
G1 X95.437 Y96.486 E.00443
G1 X95.209 Y96.677 E.00586
G1 X95.01 Y96.785 E.00444
G1 X94.8 Y96.854 E.00436
G1 X94.488 Y96.891 E.00619
G1 X90.396 Y96.891 E.08049
G1 X91.002 Y97.588 E.01817
G1 X91.256 Y97.962 E.00891
G1 X91.461 Y98.356 E.00873
G1 X91.621 Y98.783 E.00897
G1 X91.68 Y98.994 E.00431
G1 X91.762 Y99.443 E.00897
G1 X91.782 Y99.661 E.00431
G1 X91.784 Y100.117 E.00897
G1 X91.765 Y100.335 E.00431
G1 X91.688 Y100.771 E.00871
G1 X91.556 Y101.212 E.00905
G1 X91.378 Y101.618 E.00871
G1 X91.269 Y101.819 E.00451
G1 X91.021 Y102.189 E.00877
G1 X90.877 Y102.368 E.00451
G1 X90.562 Y102.693 E.0089
G1 X90.219 Y102.973 E.00872
G1 X90.027 Y103.103 E.00457
G1 X89.836 Y103.216 E.00436
G1 X89.427 Y103.412 E.00891
G1 X88.998 Y103.557 E.00891
G1 X88.785 Y103.608 E.00431
G1 X88.334 Y103.676 E.00897
G1 X88.116 Y103.689 E.0043
G1 X87.653 Y103.674 E.00911
G1 X87.215 Y103.608 E.00871
G1 X87.002 Y103.557 E.0043
G1 X86.573 Y103.412 E.00891
G1 X86.164 Y103.216 E.00891
G1 X85.976 Y103.105 E.00431
G1 X85.616 Y102.846 E.00871
G1 X85.276 Y102.536 E.00905
G1 X84.981 Y102.192 E.00891
G1 X84.854 Y102.014 E.0043
G1 X84.629 Y101.633 E.00871
G1 X84.444 Y101.211 E.00905
G1 X84.314 Y100.781 E.00885
G1 X84.236 Y100.338 E.00885
G1 X84.21 Y99.889 E.00885
G1 X84.239 Y99.44 E.00884
G1 X84.322 Y98.987 E.00905
G1 X84.454 Y98.564 E.00871
G1 X84.537 Y98.362 E.0043
G1 X84.745 Y97.96 E.00891
G1 X84.998 Y97.588 E.00885
G1 X85.565 Y96.936 E.01698
; WIPE_START
M204 S6000
G1 X83.565 Y96.914 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G17
G3 Z.72 I1.217 J0 P1  F18000
;===================== date: 20250206 =====================

; don't support timelapse gcode in spiral_mode and by object sequence for I3 structure printer
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
G92 E0
G1 Z0.72
G1 X0 Y90 ; move to safe pos
G1 X-13.0 F3000 ; move to safe pos
M400
M1004 S5 P1  ; external shutter
M400 P300
M971 S11 C11 O0
G92 E0
G1 X0 F18000
M623

; SKIPTYPE: head_wrap_detect
M622.1 S1
M1002 judge_flag g39_3rd_layer_detect_flag
M622 J1
    ; enable nozzle clog detect at 3rd layer
    


    M622.1 S1
    M1002 judge_flag g39_detection_flag
    M622 J1
      
        M622.1 S0
        M1002 judge_flag g39_mass_exceed_flag
        M622 J1
        
        M623
    
    M623
M623
; SKIPPABLE_END




G1 X81.448 Y96.237
G1 Z.32
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.0951797
G1 F1500
M204 S6000
G1 X81.349 Y96.194 E.00037
; LINE_WIDTH: 0.144705
G1 X81.251 Y96.15 E.00064
G1 X81.079 Y96.023 E.00127
; LINE_WIDTH: 0.160373
G1 X80.948 Y95.848 E.00146
; LINE_WIDTH: 0.126262
G1 X80.891 Y95.735 E.00064
; LINE_WIDTH: 0.0905809
G1 X80.864 Y95.628 E.00036
; WIPE_START
G1 X80.891 Y95.735 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X86.535 Y97.174 Z.72 F18000
M73 P37 R15
G1 Z.32
G1 E.4 F1800
; LINE_WIDTH: 0.473058
G1 F1500
M204 S6000
G1 X86.365 Y97.318 E.00499
; LINE_WIDTH: 0.438143
G1 X86.169 Y97.487 E.00533
; LINE_WIDTH: 0.401763
G1 X85.99 Y97.669 E.00478
; LINE_WIDTH: 0.359579
G1 X85.792 Y97.872 E.00473
G1 X85.464 Y98.3 E.00897
G1 X85.234 Y98.745 E.00834
G1 X85.09 Y99.179 E.00762
G1 X85.024 Y99.537 E.00606
G1 X85.004 Y100.005 E.00781
G1 X85.067 Y100.522 E.00866
G1 X85.186 Y100.937 E.0072
G1 X85.333 Y101.27 E.00605
G1 X85.607 Y101.709 E.00862
G1 X85.917 Y102.058 E.00778
G1 X86.336 Y102.396 E.00896
G1 X86.825 Y102.659 E.00925
G1 X87.17 Y102.778 E.00607
G1 X87.536 Y102.862 E.00626
G1 X88.03 Y102.9 E.00825
G1 X88.594 Y102.841 E.00945
G1 X89.07 Y102.701 E.00826
G1 X89.43 Y102.537 E.00659
G1 X89.744 Y102.342 E.00616
G1 X90.116 Y102.025 E.00814
G1 X90.364 Y101.741 E.00627
G1 X90.592 Y101.412 E.00667
G1 X90.814 Y100.941 E.00867
G1 X90.916 Y100.588 E.00612
G1 X90.977 Y100.237 E.00592
G1 X90.989 Y99.702 E.00892
G1 X90.945 Y99.352 E.00587
G1 X90.867 Y99.031 E.00549
G1 X90.663 Y98.519 E.00918
G1 X90.46 Y98.192 E.00643
G1 X90.139 Y97.797 E.00846
; LINE_WIDTH: 0.382517
G1 X89.876 Y97.53 E.00667
; LINE_WIDTH: 0.426858
G1 X89.751 Y97.418 E.00336
; LINE_WIDTH: 0.467442
G1 X89.627 Y97.306 E.0037
G1 X89.601 Y97.31 E.00058
; LINE_WIDTH: 0.435696
G1 X89.451 Y97.344 E.00313
; LINE_WIDTH: 0.407417
G1 X89.302 Y97.378 E.00292
; WIPE_START
G1 X89.451 Y97.344 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X94.538 Y96.256 Z.72 F18000
G1 Z.32
G1 E.4 F1800
; LINE_WIDTH: 0.149051
G1 F1500
M204 S6000
G1 X94.823 Y96.105 E.00199
G1 X95.135 Y95.786 E.00275
; WIPE_START
G1 X94.823 Y96.105 E-.22042
G1 X94.538 Y96.256 E-.15958
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X95.122 Y88.646 Z.72 F18000
G1 X95.453 Y84.347 Z.72
G1 Z.32
G1 E.4 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.419992
G1 F1500
M204 S6000
G1 X98.546 Y84.348 E.06085
G1 X98.547 Y79.254 E.10018
G1 X95.454 Y79.253 E.06085
G1 X95.453 Y84.287 E.09901
M204 S10000
G1 X95.847 Y83.953 F18000
G1 F1500
M204 S6000
G1 X98.152 Y83.954 E.04534
G1 X98.153 Y79.648 E.08468
G1 X95.848 Y79.648 E.04534
G1 X95.847 Y83.893 E.0835
M204 S10000
G1 X96.241 Y83.559 F18000
G1 F1500
M204 S6000
G1 X97.758 Y83.559 E.02983
G1 X97.759 Y80.043 E.06917
G1 X96.242 Y80.042 E.02983
G1 X96.241 Y83.499 E.06799
M204 S10000
G1 X96.636 Y83.165 F18000
G1 F1500
M204 S6000
G1 X97.364 Y83.165 E.01432
G1 X97.364 Y80.437 E.05366
G1 X96.636 Y80.437 E.01432
G1 X96.636 Y83.105 E.05248
M204 S10000
G1 X97 Y82.801 F18000
; LINE_WIDTH: 0.359632
G1 F1500
M204 S6000
G1 X97 Y80.861 E.03232
; WIPE_START
G1 X97 Y82.801 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X95.139 Y77.42 Z.72 F18000
G1 Z.32
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.155774
G1 F1500
M204 S6000
G1 X94.889 Y77.153 E.00238
G1 X94.771 Y77.061 E.00097
; LINE_WIDTH: 0.13004
G1 X94.536 Y76.95 E.00135
; WIPE_START
G1 X94.771 Y77.061 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X87.139 Y77 Z.72 F18000
G1 X81.504 Y76.955 Z.72
G1 Z.32
G1 E.4 F1800
; LINE_WIDTH: 0.0894045
G1 F1500
M204 S6000
G1 X81.397 Y76.991 E.00036
; LINE_WIDTH: 0.127933
G1 X81.19 Y77.083 E.00115
; LINE_WIDTH: 0.156625
G1 X81.07 Y77.195 E.00107
G1 X80.924 Y77.387 E.00157
; LINE_WIDTH: 0.103551
G1 X80.855 Y77.602 E.00088
; CHANGE_LAYER
; Z_HEIGHT: 0.44
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F1500
G1 X80.924 Y77.387 E-.38
; WIPE_END
G1 E-.02 F1800
; layer num/total_layer_count: 3/49
; update layer progress
M73 L3
M991 S0 P2 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z.72 I-.91 J.808 P1  F18000
G1 X94.881 Y93.111 Z.72
G1 Z.44
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X94.881 Y89.282 E.08105
G1 X99.119 Y89.282 E.08971
G1 X99.119 Y93.52 E.08971
G1 X94.881 Y93.52 E.08971
G1 X94.881 Y93.171 E.00739
M204 S250
G1 X95.29 Y93.111 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X95.29 Y89.691 E.06727
G1 X98.71 Y89.691 E.06727
G1 X98.71 Y93.111 E.06727
G1 X95.35 Y93.111 E.06609
; WIPE_START
M204 S6000
G1 X95.315 Y91.111 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X95.29 Y88.857 Z.84 F18000
G1 Z.44
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X95.043 Y88.857 E.00522
G1 X95.043 Y88.445 E.00872
G1 X98.957 Y88.445 E.08282
G1 X98.957 Y88.857 E.00872
G1 X95.35 Y88.857 E.07634
; WIPE_START
M204 S6000
G1 X95.043 Y88.857 E-.05824
G1 X95.043 Y88.445 E-.07829
G1 X96.325 Y88.445 E-.24348
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X98.957 Y93.944 Z.84 F18000
G1 Z.44
G1 E.4 F1800
G1 F1500
M204 S500
G1 X98.957 Y94.357 E.00872
G1 X95.043 Y94.358 E.08282
G1 X95.043 Y93.944 E.00875
G1 X98.897 Y93.944 E.08155
; WIPE_START
M204 S6000
G1 X98.957 Y94.357 E-.07914
G1 X97.373 Y94.357 E-.30086
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X90.141 Y96.796 Z.84 F18000
G1 X89.229 Y97.104 Z.84
G1 Z.44
G1 E.4 F1800
G1 F1500
M204 S500
G1 X88.766 Y96.953 E.01029
G1 X88.393 Y96.88 E.00804
G1 X87.863 Y96.856 E.01123
G1 X87.337 Y96.928 E.01124
G1 X86.973 Y97.034 E.00803
G1 X86.772 Y97.12 E.00462
G1 X86.653 Y96.956 E.00429
G1 X87.011 Y96.544 E.01155
G1 X88.989 Y96.544 E.04188
G1 X89.335 Y96.942 E.01116
G1 X89.262 Y97.054 E.00283
; WIPE_START
M204 S6000
G1 X88.766 Y96.953 E-.09608
G1 X88.393 Y96.88 E-.07221
G1 X87.863 Y96.856 E-.1008
G1 X87.337 Y96.928 E-.10088
G1 X87.286 Y96.942 E-.01003
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X90.617 Y99.844 Z.84 F18000
G1 Z.44
G1 E.4 F1800
G1 F1500
M204 S500
G1 X90.622 Y99.901 E.0012
G1 X90.58 Y100.37 E.00997
G1 X90.454 Y100.821 E.00991
G1 X90.326 Y101.108 E.00666
G1 X90.16 Y101.385 E.00683
G1 X89.867 Y101.741 E.00977
G1 X89.509 Y102.043 E.00992
G1 X89.242 Y102.208 E.00665
G1 X88.957 Y102.341 E.00665
G1 X88.508 Y102.473 E.00991
G1 X88.039 Y102.522 E.00997
G1 X87.58 Y102.488 E.00975
G1 X87.265 Y102.416 E.00683
G1 X86.969 Y102.31 E.00665
G1 X86.556 Y102.089 E.00992
G1 X86.188 Y101.796 E.00996
G1 X85.879 Y101.442 E.00995
G1 X85.643 Y101.046 E.00975
G1 X85.52 Y100.748 E.00683
G1 X85.434 Y100.437 E.00682
G1 X85.381 Y99.989 E.00956
G1 X85.39 Y99.666 E.00683
G1 X85.438 Y99.347 E.00683
G1 X85.574 Y98.907 E.00976
G1 X85.791 Y98.49 E.00994
G1 X86.078 Y98.118 E.00995
G1 X86.427 Y97.803 E.00995
G1 X86.819 Y97.561 E.00975
G1 X87.116 Y97.434 E.00683
G1 X87.426 Y97.344 E.00682
G1 X87.882 Y97.282 E.00976
G1 X88.343 Y97.302 E.00975
G1 X88.659 Y97.365 E.00683
G1 X88.966 Y97.465 E.00683
G1 X89.378 Y97.671 E.00975
G1 X89.754 Y97.953 E.00995
G1 X90.068 Y98.29 E.00975
G1 X90.249 Y98.557 E.00683
G1 X90.394 Y98.835 E.00663
G1 X90.504 Y99.128 E.00663
G1 X90.58 Y99.442 E.00683
G1 X90.611 Y99.784 E.00728
M204 S250
G1 X90.209 Y99.881 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X90.211 Y99.901 E.00039
G1 X90.175 Y100.296 E.0078
G1 X90.068 Y100.682 E.00788
G1 X89.962 Y100.919 E.00511
G1 X89.825 Y101.149 E.00526
G1 X89.575 Y101.453 E.00774
G1 X89.268 Y101.711 E.00788
G1 X89.047 Y101.847 E.00511
G1 X88.812 Y101.957 E.00511
G1 X88.428 Y102.07 E.00788
G1 X88.033 Y102.111 E.0078
G1 X87.641 Y102.082 E.00773
G1 X87.38 Y102.023 E.00527
G1 X87.136 Y101.935 E.00511
G1 X86.782 Y101.746 E.00788
G1 X86.472 Y101.499 E.0078
G1 X86.211 Y101.2 E.0078
G1 X86.01 Y100.863 E.00773
G1 X85.908 Y100.615 E.00526
G1 X85.837 Y100.358 E.00526
G1 X85.791 Y99.97 E.00767
G1 X85.799 Y99.703 E.00526
G1 X85.838 Y99.438 E.00526
G1 X85.954 Y99.062 E.00774
G1 X86.137 Y98.711 E.00779
G1 X86.379 Y98.397 E.0078
G1 X86.674 Y98.132 E.0078
G1 X87.008 Y97.925 E.00773
G1 X87.254 Y97.82 E.00526
G1 X87.511 Y97.745 E.00526
G1 X87.901 Y97.692 E.00774
G1 X88.294 Y97.71 E.00773
G1 X88.556 Y97.762 E.00526
G1 X88.811 Y97.844 E.00526
G1 X89.162 Y98.02 E.00773
G1 X89.479 Y98.258 E.0078
G1 X89.747 Y98.546 E.00774
G1 X89.897 Y98.767 E.00526
G1 X90.019 Y99.002 E.0052
G1 X90.112 Y99.249 E.0052
G1 X90.176 Y99.509 E.00526
G1 X90.204 Y99.821 E.00616
; WIPE_START
M204 S6000
G1 X90.211 Y99.901 E-.01521
G1 X90.175 Y100.296 E-.07536
G1 X90.068 Y100.682 E-.07614
G1 X89.962 Y100.919 E-.04936
G1 X89.825 Y101.149 E-.05082
G1 X89.575 Y101.453 E-.07475
G1 X89.42 Y101.583 E-.03836
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X92.372 Y94.544 Z.84 F18000
G1 X98.956 Y78.845 Z.84
G1 Z.44
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X98.956 Y84.757 E.12513
G1 X95.044 Y84.756 E.0828
G1 X95.044 Y78.844 E.12514
G1 X98.896 Y78.845 E.08153
; WIPE_START
M204 S6000
G1 X98.916 Y80.845 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X94.164 Y86.817 Z.84 F18000
G1 X86.761 Y96.12 Z.84
G1 Z.44
G1 E.4 F1800
G1 F1500
M204 S500
G1 X94.065 Y96.12 E.15459
G1 X94.388 Y96.052 E.007
G1 X94.619 Y95.915 E.00568
G1 X95.289 Y95.274 E.01963
G1 X94.619 Y94.784 E.01755
G1 X94.619 Y88.021 E.14315
G1 X99.381 Y88.021 E.10078
G1 X99.381 Y94.781 E.14307
G1 X95.386 Y94.782 E.08455
G1 X95.379 Y95.64 E.01817
G1 X95.355 Y95.804 E.00349
G1 X95.307 Y95.949 E.00324
G1 X95.234 Y96.084 E.00324
G1 X95.139 Y96.204 E.00324
G1 X95.031 Y96.299 E.00305
G1 X94.839 Y96.41 E.00469
G1 X94.711 Y96.453 E.00286
G1 X94.464 Y96.482 E.00527
G1 X89.497 Y96.482 E.10513
G1 X90.677 Y97.838 E.03806
G1 X90.997 Y98.338 E.01255
G1 X91.167 Y98.72 E.00886
G1 X91.326 Y99.3 E.01273
G1 X91.355 Y99.489 E.00405
G1 X91.374 Y100.1 E.01293
G1 X91.29 Y100.672 E.01224
G1 X91.168 Y101.079 E.009
G1 X90.914 Y101.614 E.01253
G1 X90.57 Y102.097 E.01255
G1 X90.285 Y102.391 E.00867
G1 X89.967 Y102.65 E.00868
G1 X89.643 Y102.855 E.00811
G1 X89.093 Y103.099 E.01273
G1 X88.697 Y103.208 E.00869
G1 X88.292 Y103.269 E.00868
G1 X87.909 Y103.28 E.00811
G1 X87.5 Y103.243 E.00869
G1 X87.107 Y103.161 E.0085
G1 X86.727 Y103.032 E.00849
G1 X86.2 Y102.762 E.01254
G1 X85.878 Y102.531 E.00839
G1 X85.571 Y102.25 E.0088
G1 X85.304 Y101.94 E.00867
G1 X84.996 Y101.45 E.01224
G1 X84.829 Y101.069 E.0088
G1 X84.713 Y100.686 E.00847
G1 X84.641 Y100.281 E.00869
G1 X84.627 Y99.689 E.01254
G1 X84.676 Y99.291 E.00849
G1 X84.771 Y98.901 E.00849
G1 X84.913 Y98.526 E.00849
G1 X85.097 Y98.17 E.00849
G1 X85.323 Y97.838 E.00849
G1 X86.503 Y96.482 E.03805
G1 X81.536 Y96.482 E.10513
G1 X81.289 Y96.453 E.00527
G1 X81.144 Y96.405 E.00324
G1 X80.982 Y96.312 E.00394
G1 X80.868 Y96.21 E.00324
G1 X80.735 Y96.032 E.00469
G1 X80.649 Y95.821 E.00482
G1 X80.619 Y95.565 E.00546
G1 X80.619 Y77.619 E.37984
G1 X80.66 Y77.34 E.00597
G1 X80.766 Y77.118 E.0052
G1 X80.861 Y76.998 E.00324
G1 X80.982 Y76.89 E.00343
G1 X81.2 Y76.775 E.00521
G1 X81.45 Y76.723 E.0054
G1 X94.469 Y76.72 E.27556
G1 X94.702 Y76.748 E.00496
G1 X94.902 Y76.821 E.00451
G1 X95.017 Y76.892 E.00286
G1 X95.178 Y77.044 E.00469
G1 X95.256 Y77.154 E.00286
G1 X95.343 Y77.358 E.00469
G1 X95.372 Y77.498 E.00304
G1 X95.397 Y78.42 E.01951
G1 X99.381 Y78.421 E.08431
G1 X99.38 Y85.182 E.14309
G1 X94.619 Y85.181 E.10076
G1 X94.62 Y78.417 E.14317
G1 X95.289 Y77.929 E.01753
G1 X94.619 Y77.286 E.01964
G1 X94.388 Y77.15 E.00568
G1 X94.064 Y77.082 E.007
G1 X81.946 Y77.082 E.2565
G1 X81.657 Y77.133 E.0062
G1 X81.387 Y77.278 E.00649
G1 X81.171 Y77.495 E.00649
G1 X81.019 Y77.798 E.00717
G1 X80.981 Y78.056 E.00552
G1 X80.981 Y95.137 E.36154
G1 X81.005 Y95.346 E.00445
G1 X81.112 Y95.614 E.0061
G1 X81.296 Y95.847 E.00629
G1 X81.562 Y96.033 E.00688
G1 X81.927 Y96.12 E.00794
G1 X86.701 Y96.12 E.10103
; WIPE_START
M204 S6000
G1 X88.701 Y96.12 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
M73 P38 R15
G1 X85.604 Y96.891 Z.84 F18000
G1 Z.44
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X81.512 Y96.891 E.08049
G1 X81.2 Y96.854 E.00619
G1 X80.986 Y96.784 E.00442
G1 X80.855 Y96.718 E.00289
G1 X80.732 Y96.637 E.00289
G1 X80.565 Y96.488 E.00442
G1 X80.382 Y96.243 E.00601
G1 X80.287 Y96.039 E.00442
G1 X80.247 Y95.904 E.00277
G1 X80.21 Y95.589 E.00625
M73 P38 R14
G1 X80.21 Y77.607 E.35368
G1 X80.219 Y77.454 E.00301
G1 X80.266 Y77.228 E.00454
G1 X80.315 Y77.093 E.00283
G1 X80.423 Y76.892 E.00448
G1 X80.562 Y76.716 E.00442
G1 X80.732 Y76.565 E.00448
G1 X80.853 Y76.486 E.00283
G1 X81.059 Y76.389 E.00448
G1 X81.274 Y76.332 E.00438
G1 X81.425 Y76.313 E.003
G1 X94.493 Y76.311 E.25703
G1 X94.797 Y76.347 E.00602
G1 X95.081 Y76.45 E.00595
G1 X95.267 Y76.565 E.0043
G1 X95.489 Y76.775 E.006
G1 X95.615 Y76.954 E.0043
G1 X95.736 Y77.234 E.006
G1 X95.78 Y77.451 E.00436
G1 X95.796 Y78.011 E.01101
G1 X99.414 Y78.012 E.07117
G1 X99.53 Y78.035 E.00233
G1 X99.611 Y78.075 E.00178
G1 X99.699 Y78.154 E.00232
G1 X99.747 Y78.227 E.00171
G1 X99.79 Y78.413 E.00376
G1 X99.789 Y85.214 E.13377
G1 X99.764 Y85.336 E.00245
G1 X99.726 Y85.412 E.00166
G1 X99.652 Y85.496 E.00221
G1 X99.574 Y85.548 E.00185
G1 X99.388 Y85.591 E.00375
G1 X94.583 Y85.59 E.0945
G1 X94.406 Y85.537 E.00364
G1 X94.277 Y85.417 E.00347
G1 X94.229 Y85.312 E.00227
G1 X94.21 Y85.186 E.00252
G1 X94.211 Y78.385 E.13375
G1 X94.229 Y78.288 E.00195
G1 X94.276 Y78.187 E.00218
G1 X94.33 Y78.122 E.00167
G1 X94.653 Y77.886 E.00788
G1 X94.371 Y77.615 E.00771
G1 X94.238 Y77.536 E.00302
G1 X94.022 Y77.491 E.00435
G1 X81.982 Y77.491 E.23682
G1 X81.793 Y77.524 E.00376
G1 X81.634 Y77.61 E.00355
G1 X81.507 Y77.737 E.00355
G1 X81.414 Y77.922 E.00407
G1 X81.39 Y78.085 E.00324
G1 X81.39 Y95.113 E.33492
G1 X81.405 Y95.245 E.00261
G1 X81.47 Y95.407 E.00343
G1 X81.58 Y95.546 E.00349
G1 X81.733 Y95.653 E.00367
G1 X81.975 Y95.711 E.0049
G1 X94.022 Y95.711 E.23695
G1 X94.238 Y95.665 E.00434
G1 X94.371 Y95.587 E.00302
G1 X94.653 Y95.316 E.00771
G1 X94.332 Y95.082 E.00782
G1 X94.263 Y94.993 E.00221
G1 X94.221 Y94.887 E.00225
G1 X94.21 Y94.789 E.00194
G1 X94.21 Y88.019 E.13315
G1 X94.237 Y87.866 E.00307
G1 X94.29 Y87.767 E.00221
G1 X94.426 Y87.654 E.00347
G1 X94.58 Y87.612 E.00315
G1 X99.41 Y87.612 E.095
G1 X99.556 Y87.646 E.00295
G1 X99.649 Y87.704 E.00215
G1 X99.722 Y87.785 E.00215
G1 X99.779 Y87.917 E.00283
G1 X99.79 Y94.783 E.13503
G1 X99.763 Y94.933 E.00301
G1 X99.693 Y95.055 E.00276
G1 X99.575 Y95.149 E.00297
G1 X99.417 Y95.19 E.00321
G1 X95.792 Y95.191 E.07129
G1 X95.788 Y95.672 E.00946
G1 X95.754 Y95.898 E.0045
G1 X95.684 Y96.111 E.00442
G1 X95.577 Y96.309 E.00442
G1 X95.438 Y96.485 E.00442
G1 X95.272 Y96.633 E.00436
G1 X95.008 Y96.786 E.00601
G1 X94.8 Y96.854 E.0043
G1 X94.488 Y96.891 E.00619
G1 X90.396 Y96.891 E.08049
G1 X91.002 Y97.588 E.01817
G1 X91.249 Y97.95 E.00862
G1 X91.363 Y98.154 E.0046
G1 X91.549 Y98.57 E.00897
G1 X91.619 Y98.777 E.0043
G1 X91.728 Y99.22 E.00897
G1 X91.782 Y99.661 E.00873
G1 X91.784 Y100.117 E.00897
G1 X91.765 Y100.335 E.00431
G1 X91.689 Y100.766 E.00862
G1 X91.555 Y101.215 E.00921
G1 X91.473 Y101.417 E.0043
G1 X91.267 Y101.821 E.00892
G1 X91.023 Y102.185 E.00862
G1 X90.877 Y102.368 E.0046
G1 X90.562 Y102.693 E.00891
G1 X90.211 Y102.979 E.00891
G1 X89.836 Y103.216 E.00873
G1 X89.424 Y103.413 E.00897
G1 X89.219 Y103.489 E.00431
G1 X88.782 Y103.609 E.00891
G1 X88.334 Y103.676 E.00891
G1 X87.891 Y103.689 E.00873
G1 X87.439 Y103.649 E.00891
G1 X86.999 Y103.556 E.00885
G1 X86.573 Y103.412 E.00885
G1 X86.164 Y103.216 E.00891
G1 X85.976 Y103.105 E.00431
G1 X85.62 Y102.849 E.00862
G1 X85.276 Y102.536 E.00914
G1 X84.981 Y102.192 E.00891
G1 X84.854 Y102.014 E.0043
G1 X84.632 Y101.637 E.00862
G1 X84.444 Y101.211 E.00914
G1 X84.314 Y100.781 E.00884
G1 X84.235 Y100.335 E.00891
G1 X84.216 Y100.117 E.00431
G1 X84.218 Y99.664 E.00891
G1 X84.273 Y99.217 E.00885
G1 X84.38 Y98.78 E.00885
G1 X84.538 Y98.359 E.00885
G1 X84.745 Y97.96 E.00885
G1 X84.998 Y97.588 E.00885
G1 X85.565 Y96.936 E.01698
; WIPE_START
M204 S6000
G1 X83.565 Y96.914 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G17
G3 Z.84 I1.217 J0 P1  F18000
;===================== date: 20250206 =====================

; don't support timelapse gcode in spiral_mode and by object sequence for I3 structure printer
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
G92 E0
G1 Z0.84
G1 X0 Y90 ; move to safe pos
G1 X-13.0 F3000 ; move to safe pos
M400
M1004 S5 P1  ; external shutter
M400 P300
M971 S11 C11 O0
G92 E0
G1 X0 F18000
M623

; SKIPTYPE: head_wrap_detect
M622.1 S1
M1002 judge_flag g39_3rd_layer_detect_flag
M622 J1
    ; enable nozzle clog detect at 3rd layer
    
      M400
      G90
      M83
      M204 S5000
      G0 Z2 F4000
      G0 X187 Y178 F20000
      G39 S1 X187 Y178
      G0 Z2 F4000
    


    M622.1 S1
    M1002 judge_flag g39_detection_flag
    M622 J1
      
        M622.1 S0
        M1002 judge_flag g39_mass_exceed_flag
        M622 J1
        
        M623
    
    M623
M623
; SKIPPABLE_END




G1 Z0.840
G1 X81.448 Y96.237
G1 Z.44
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.0954311
G1 F1500
M204 S6000
G1 X81.348 Y96.193 E.00038
; LINE_WIDTH: 0.149881
G1 X81.248 Y96.149 E.00068
G1 X81.098 Y96.043 E.00114
G1 X80.975 Y95.889 E.00122
G1 X80.849 Y95.684 E.00149
M204 S10000
G1 X80.864 Y95.628 F18000
; LINE_WIDTH: 0.0963252
G1 F1500
M204 S6000
G1 X80.997 Y96.028 E.00148
; WIPE_START
G1 X80.864 Y95.628 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X86.544 Y97.167 Z.84 F18000
G1 Z.44
G1 E.4 F1800
; LINE_WIDTH: 0.475201
G1 F1500
M204 S6000
G1 X86.369 Y97.315 E.00513
; LINE_WIDTH: 0.438819
G1 X86.169 Y97.487 E.00545
; LINE_WIDTH: 0.401764
G1 X85.99 Y97.669 E.00478
; LINE_WIDTH: 0.359681
G1 X85.628 Y98.073 E.00904
G1 X85.425 Y98.365 E.00593
G1 X85.231 Y98.75 E.00718
G1 X85.074 Y99.251 E.00875
G1 X85.013 Y99.642 E.00659
G1 X85.007 Y100.079 E.00727
G1 X85.068 Y100.522 E.00745
G1 X85.186 Y100.937 E.00719
G1 X85.335 Y101.273 E.00613
G1 X85.607 Y101.708 E.00855
G1 X85.939 Y102.078 E.00828
G1 X86.361 Y102.413 E.00898
G1 X86.828 Y102.66 E.00879
G1 X87.169 Y102.782 E.00604
G1 X87.554 Y102.867 E.00657
G1 X88.06 Y102.9 E.00844
G1 X88.596 Y102.841 E.00898
G1 X89.079 Y102.698 E.00839
G1 X89.43 Y102.537 E.00644
G1 X89.742 Y102.344 E.00611
G1 X90.026 Y102.109 E.00614
G1 X90.278 Y101.846 E.00606
G1 X90.584 Y101.42 E.00875
G1 X90.811 Y100.949 E.00871
G1 X90.952 Y100.423 E.00907
G1 X90.995 Y99.915 E.00848
G1 X90.975 Y99.541 E.00624
G1 X90.869 Y99.026 E.00876
G1 X90.732 Y98.674 E.0063
G1 X90.566 Y98.357 E.00596
G1 X90.372 Y98.064 E.00585
G1 X90.002 Y97.654 E.0092
; LINE_WIDTH: 0.395518
G1 X89.878 Y97.538 E.00314
; LINE_WIDTH: 0.431481
G1 X89.753 Y97.422 E.00345
; LINE_WIDTH: 0.467664
G1 X89.626 Y97.304 E.0038
; LINE_WIDTH: 0.46843
G1 X89.465 Y97.34 E.00365
; LINE_WIDTH: 0.433498
G1 X89.304 Y97.375 E.00336
; WIPE_START
G1 X89.465 Y97.34 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X94.532 Y96.239 Z.84 F18000
G1 Z.44
G1 E.4 F1800
; LINE_WIDTH: 0.0929875
G1 F1500
M204 S6000
G1 X94.632 Y96.2 E.00036
; LINE_WIDTH: 0.124104
G1 X94.732 Y96.162 E.00053
; LINE_WIDTH: 0.155423
G1 X94.863 Y96.072 E.00103
G1 X95.126 Y95.805 E.00243
; WIPE_START
G1 X94.863 Y96.072 E-.26668
G1 X94.732 Y96.162 E-.11332
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X95.197 Y88.544 Z.84 F18000
G1 X95.453 Y84.347 Z.84
G1 Z.44
G1 E.4 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.419992
G1 F1500
M204 S6000
G1 X98.546 Y84.348 E.06085
G1 X98.547 Y79.254 E.10018
M73 P39 R14
G1 X95.454 Y79.253 E.06085
G1 X95.453 Y84.287 E.09901
M204 S10000
G1 X95.847 Y83.953 F18000
G1 F1500
M204 S6000
G1 X98.152 Y83.954 E.04534
G1 X98.153 Y79.648 E.08468
G1 X95.848 Y79.648 E.04534
G1 X95.847 Y83.893 E.0835
M204 S10000
G1 X96.241 Y83.559 F18000
G1 F1500
M204 S6000
G1 X97.758 Y83.559 E.02983
G1 X97.759 Y80.043 E.06917
G1 X96.242 Y80.042 E.02983
G1 X96.241 Y83.499 E.06799
M204 S10000
G1 X96.636 Y83.165 F18000
G1 F1500
M204 S6000
G1 X97.364 Y83.165 E.01432
G1 X97.364 Y80.437 E.05366
G1 X96.636 Y80.437 E.01432
G1 X96.636 Y83.105 E.05248
M204 S10000
G1 X97 Y82.801 F18000
; LINE_WIDTH: 0.359632
G1 F1500
M204 S6000
G1 X97 Y80.861 E.03232
; WIPE_START
G1 X97 Y82.801 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X95.146 Y77.439 Z.84 F18000
G1 Z.44
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.14821
G1 F1500
M204 S6000
G1 X94.845 Y77.115 E.0027
G1 X94.783 Y77.067 E.00048
G1 X94.535 Y76.95 E.00167
; WIPE_START
G1 X94.783 Y77.067 E-.13091
G1 X94.845 Y77.115 E-.03773
G1 X95.146 Y77.439 E-.21136
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X87.518 Y77.169 Z.84 F18000
G1 X81.496 Y76.955 Z.84
G1 Z.44
G1 E.4 F1800
; LINE_WIDTH: 0.0897798
G1 F1500
M204 S6000
G1 X81.393 Y76.991 E.00035
; LINE_WIDTH: 0.130477
G1 X81.191 Y77.084 E.00116
; LINE_WIDTH: 0.15393
G1 X81.07 Y77.193 E.00104
G1 X80.935 Y77.369 E.00142
; LINE_WIDTH: 0.120669
G1 X80.894 Y77.487 E.00059
; LINE_WIDTH: 0.0908456
G1 X80.854 Y77.604 E.0004
; CHANGE_LAYER
; Z_HEIGHT: 0.56
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F1500
G1 X80.894 Y77.487 E-.38
; WIPE_END
G1 E-.02 F1800
; layer num/total_layer_count: 4/49
; update layer progress
M73 L4
M991 S0 P3 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z.84 I-.907 J.812 P1  F18000
G1 X94.881 Y93.111 Z.84
G1 Z.56
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X94.881 Y89.282 E.08105
G1 X99.119 Y89.282 E.08971
G1 X99.119 Y93.52 E.08971
G1 X94.881 Y93.52 E.08971
G1 X94.881 Y93.171 E.00739
M204 S250
G1 X95.29 Y93.111 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X95.29 Y89.691 E.06727
G1 X98.71 Y89.691 E.06727
G1 X98.71 Y93.111 E.06727
G1 X95.35 Y93.111 E.06609
; WIPE_START
M204 S6000
G1 X95.315 Y91.111 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X95.29 Y88.857 Z.96 F18000
G1 Z.56
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X95.043 Y88.857 E.00522
G1 X95.043 Y88.445 E.00872
G1 X98.957 Y88.445 E.08282
G1 X98.957 Y88.857 E.00872
G1 X95.35 Y88.857 E.07634
; WIPE_START
M204 S6000
G1 X95.043 Y88.857 E-.05824
G1 X95.043 Y88.445 E-.07829
G1 X96.325 Y88.445 E-.24348
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X98.957 Y93.944 Z.96 F18000
G1 Z.56
G1 E.4 F1800
G1 F1500
M204 S500
G1 X98.957 Y94.357 E.00872
G1 X95.043 Y94.358 E.08282
G1 X95.043 Y93.944 E.00875
G1 X98.897 Y93.944 E.08155
; WIPE_START
M204 S6000
G1 X98.957 Y94.357 E-.07914
G1 X97.373 Y94.357 E-.30086
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X90.128 Y96.757 Z.96 F18000
G1 X89.161 Y97.078 Z.96
G1 Z.56
G1 E.4 F1800
G1 F1500
M204 S500
G1 X88.604 Y96.915 E.01228
G1 X88.228 Y96.864 E.00804
G1 X87.863 Y96.859 E.00771
G1 X87.501 Y96.897 E.00771
G1 X87.131 Y96.981 E.00803
G1 X86.754 Y97.129 E.00858
G1 X86.638 Y96.967 E.00422
G1 X87.003 Y96.544 E.01181
G1 X88.922 Y96.544 E.04062
G1 X89.263 Y96.913 E.01063
G1 X89.192 Y97.027 E.00283
; WIPE_START
M204 S6000
G1 X88.604 Y96.915 E-.11378
G1 X88.228 Y96.864 E-.07219
G1 X87.863 Y96.859 E-.06923
G1 X87.501 Y96.897 E-.0692
G1 X87.216 Y96.962 E-.0556
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X90.617 Y99.844 Z.96 F18000
G1 Z.56
G1 E.4 F1800
G1 F1500
M204 S500
G1 X90.622 Y99.901 E.0012
G1 X90.58 Y100.369 E.00995
G1 X90.457 Y100.813 E.00975
G1 X90.326 Y101.108 E.00682
G1 X90.166 Y101.375 E.0066
G1 X89.868 Y101.74 E.00997
G1 X89.516 Y102.039 E.00977
G1 X89.242 Y102.208 E.00682
G1 X88.959 Y102.34 E.0066
G1 X88.508 Y102.473 E.00997
G1 X88.048 Y102.521 E.00977
G1 X87.726 Y102.507 E.00683
G1 X87.408 Y102.454 E.00683
G1 X86.97 Y102.312 E.00975
G1 X86.556 Y102.089 E.00995
G1 X86.188 Y101.796 E.00995
G1 X85.879 Y101.442 E.00995
G1 X85.643 Y101.046 E.00975
G1 X85.52 Y100.748 E.00683
G1 X85.434 Y100.437 E.00683
G1 X85.381 Y99.989 E.00955
G1 X85.39 Y99.666 E.00682
G1 X85.436 Y99.358 E.0066
G1 X85.574 Y98.908 E.00997
G1 X85.791 Y98.489 E.00997
G1 X86.078 Y98.118 E.00995
G1 X86.427 Y97.803 E.00995
G1 X86.827 Y97.556 E.00995
G1 X87.256 Y97.388 E.00976
G1 X87.571 Y97.316 E.00682
G1 X87.882 Y97.283 E.00663
G1 X88.196 Y97.288 E.00663
G1 X88.516 Y97.331 E.00683
G1 X88.958 Y97.46 E.00975
G1 X89.378 Y97.671 E.00995
G1 X89.754 Y97.952 E.00995
G1 X90.068 Y98.29 E.00975
G1 X90.249 Y98.557 E.00683
G1 X90.394 Y98.835 E.00664
G1 X90.504 Y99.129 E.00663
G1 X90.58 Y99.442 E.00683
G1 X90.611 Y99.785 E.00728
M204 S250
G1 X90.209 Y99.881 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X90.211 Y99.901 E.00039
G1 X90.175 Y100.296 E.0078
G1 X90.071 Y100.675 E.00774
G1 X89.962 Y100.919 E.00526
G1 X89.83 Y101.14 E.00506
G1 X89.575 Y101.452 E.00793
G1 X89.275 Y101.707 E.00774
G1 X89.048 Y101.847 E.00526
G1 X88.814 Y101.956 E.00506
G1 X88.428 Y102.07 E.00793
G1 X88.036 Y102.111 E.00774
G1 X87.769 Y102.099 E.00526
G1 X87.505 Y102.055 E.00526
G1 X87.131 Y101.934 E.00773
G1 X86.782 Y101.746 E.0078
G1 X86.472 Y101.499 E.0078
G1 X86.211 Y101.2 E.0078
G1 X86.01 Y100.863 E.00773
G1 X85.908 Y100.615 E.00526
G1 X85.837 Y100.357 E.00526
G1 X85.791 Y99.97 E.00767
G1 X85.799 Y99.703 E.00526
G1 X85.837 Y99.448 E.00506
G1 X85.954 Y99.063 E.00793
G1 X86.137 Y98.711 E.0078
G1 X86.379 Y98.397 E.0078
G1 X86.674 Y98.132 E.0078
G1 X87.011 Y97.924 E.0078
G1 X87.377 Y97.78 E.00774
G1 X87.638 Y97.72 E.00526
G1 X87.901 Y97.693 E.0052
G1 X88.165 Y97.697 E.0052
G1 X88.43 Y97.733 E.00526
G1 X88.808 Y97.843 E.00773
G1 X89.162 Y98.02 E.00779
G1 X89.479 Y98.258 E.0078
G1 X89.747 Y98.546 E.00774
G1 X89.897 Y98.767 E.00526
G1 X90.019 Y99.002 E.00521
G1 X90.112 Y99.249 E.0052
G1 X90.176 Y99.509 E.00526
G1 X90.204 Y99.821 E.00616
; WIPE_START
M204 S6000
G1 X90.211 Y99.901 E-.01519
G1 X90.175 Y100.296 E-.0753
G1 X90.071 Y100.675 E-.07475
G1 X89.962 Y100.919 E-.05078
G1 X89.83 Y101.14 E-.04887
G1 X89.575 Y101.452 E-.07662
G1 X89.421 Y101.583 E-.0385
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X92.372 Y94.545 Z.96 F18000
G1 X98.956 Y78.845 Z.96
G1 Z.56
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X98.956 Y84.757 E.12513
G1 X95.044 Y84.756 E.0828
G1 X95.044 Y78.844 E.12514
G1 X98.896 Y78.845 E.08153
; WIPE_START
M204 S6000
G1 X98.916 Y80.845 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X94.162 Y86.816 Z.96 F18000
G1 X86.752 Y96.12 Z.96
G1 Z.56
G1 E.4 F1800
G1 F1500
M204 S500
G1 X94.064 Y96.12 E.15476
G1 X94.388 Y96.052 E.007
G1 X94.619 Y95.916 E.00568
G1 X95.29 Y95.273 E.01966
G1 X94.619 Y94.784 E.01756
G1 X94.619 Y88.021 E.14315
G1 X99.381 Y88.021 E.10078
G1 X99.381 Y94.781 E.14307
G1 X95.386 Y94.782 E.08455
G1 X95.379 Y95.64 E.01817
G1 X95.355 Y95.804 E.00349
G1 X95.307 Y95.949 E.00324
G1 X95.234 Y96.084 E.00324
G1 X95.145 Y96.197 E.00305
G1 X94.975 Y96.339 E.0047
G1 X94.848 Y96.407 E.00305
G1 X94.711 Y96.453 E.00305
G1 X94.464 Y96.482 E.00527
G1 X89.442 Y96.482 E.1063
G1 X90.545 Y97.676 E.0344
G1 X90.784 Y97.985 E.00829
G1 X91.005 Y98.354 E.0091
G1 X91.232 Y98.91 E.01271
G1 X91.356 Y99.498 E.01273
G1 X91.374 Y100.1 E.01273
G1 X91.291 Y100.668 E.01215
G1 X91.168 Y101.08 E.0091
G1 X90.914 Y101.614 E.01252
G1 X90.696 Y101.94 E.0083
G1 X90.436 Y102.245 E.00848
G1 X90.133 Y102.522 E.00869
G1 X89.807 Y102.757 E.0085
G1 X89.464 Y102.947 E.0083
G1 X89.28 Y103.029 E.00427
G1 X88.884 Y103.164 E.00885
G1 X88.292 Y103.269 E.01273
G1 X87.699 Y103.267 E.01254
G1 X87.116 Y103.164 E.01254
G1 X86.728 Y103.032 E.00867
G1 X86.35 Y102.85 E.0089
G1 X85.874 Y102.529 E.01215
G1 X85.571 Y102.251 E.00869
G1 X85.31 Y101.947 E.00849
G1 X85.086 Y101.613 E.00849
G1 X84.9 Y101.248 E.00869
G1 X84.718 Y100.703 E.01215
G1 X84.643 Y100.289 E.0089
G1 X84.62 Y99.89 E.00847
G1 X84.645 Y99.49 E.00849
G1 X84.718 Y99.095 E.0085
G1 X84.837 Y98.712 E.00849
G1 X85.004 Y98.336 E.00869
G1 X85.312 Y97.853 E.01215
G1 X86.497 Y96.482 E.03835
G1 X81.536 Y96.482 E.10499
G1 X81.208 Y96.43 E.00703
G1 X80.982 Y96.312 E.00539
G1 X80.868 Y96.21 E.00324
G1 X80.73 Y96.025 E.00489
G1 X80.648 Y95.812 E.00482
G1 X80.619 Y95.565 E.00527
G1 X80.619 Y77.619 E.37984
G1 X80.66 Y77.34 E.00596
G1 X80.766 Y77.118 E.00521
G1 X80.928 Y76.933 E.0052
G1 X81.061 Y76.84 E.00343
G1 X81.2 Y76.775 E.00325
G1 X81.45 Y76.723 E.00541
G1 X94.471 Y76.72 E.27559
G1 X94.702 Y76.748 E.00492
G1 X94.902 Y76.821 E.00451
G1 X95.017 Y76.892 E.00286
G1 X95.172 Y77.038 E.00451
G1 X95.286 Y77.21 E.00437
G1 X95.342 Y77.35 E.00319
G1 X95.372 Y77.498 E.00321
G1 X95.397 Y78.42 E.01951
G1 X99.381 Y78.421 E.08431
G1 X99.38 Y85.182 E.14309
G1 X94.619 Y85.181 E.10076
G1 X94.62 Y78.417 E.14317
G1 X95.29 Y77.929 E.01754
G1 X94.619 Y77.286 E.01968
G1 X94.388 Y77.15 E.00568
G1 X94.064 Y77.082 E.00699
G1 X81.954 Y77.082 E.25632
G1 X81.694 Y77.121 E.00558
G1 X81.393 Y77.272 E.00711
G1 X81.169 Y77.497 E.00674
G1 X81.019 Y77.798 E.00711
G1 X80.981 Y78.056 E.00552
G1 X80.981 Y95.146 E.36172
G1 X81.016 Y95.387 E.00515
G1 X81.119 Y95.624 E.00547
G1 X81.297 Y95.847 E.00604
G1 X81.562 Y96.034 E.00687
G1 X81.928 Y96.12 E.00795
G1 X86.692 Y96.12 E.10085
; WIPE_START
M204 S6000
G1 X88.692 Y96.12 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X85.602 Y96.891 Z.96 F18000
G1 Z.56
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X81.512 Y96.891 E.08045
G1 X81.197 Y96.854 E.00625
G1 X81.062 Y96.814 E.00277
G1 X80.853 Y96.716 E.00454
G1 X80.732 Y96.637 E.00283
G1 X80.565 Y96.488 E.00442
G1 X80.38 Y96.24 E.00607
G1 X80.317 Y96.114 E.00277
G1 X80.247 Y95.901 E.00442
G1 X80.21 Y95.589 E.00619
G1 X80.21 Y77.607 E.35368
G1 X80.219 Y77.454 E.00301
G1 X80.266 Y77.228 E.00454
G1 X80.315 Y77.093 E.00283
G1 X80.423 Y76.892 E.00448
G1 X80.564 Y76.714 E.00448
M73 P40 R14
G1 X80.669 Y76.615 E.00283
G1 X80.855 Y76.484 E.00448
G1 X81.059 Y76.389 E.00443
G1 X81.272 Y76.332 E.00434
G1 X81.425 Y76.313 E.00303
G1 X94.495 Y76.311 E.25706
G1 X94.797 Y76.347 E.00598
G1 X95.081 Y76.45 E.00595
G1 X95.267 Y76.565 E.0043
G1 X95.487 Y76.773 E.00595
G1 X95.65 Y77.019 E.00581
G1 X95.735 Y77.232 E.0045
G1 X95.78 Y77.451 E.00441
G1 X95.796 Y78.011 E.01101
G1 X99.413 Y78.012 E.07116
G1 X99.536 Y78.037 E.00246
G1 X99.611 Y78.075 E.00165
G1 X99.699 Y78.154 E.00233
G1 X99.747 Y78.227 E.00172
G1 X99.79 Y78.413 E.00376
G1 X99.789 Y85.214 E.13377
G1 X99.764 Y85.337 E.00246
G1 X99.725 Y85.414 E.00171
G1 X99.669 Y85.481 E.00171
G1 X99.571 Y85.549 E.00233
G1 X99.388 Y85.591 E.00371
G1 X94.583 Y85.59 E.09449
G1 X94.406 Y85.537 E.00365
G1 X94.277 Y85.417 E.00346
G1 X94.229 Y85.312 E.00227
G1 X94.21 Y85.186 E.00252
G1 X94.211 Y78.386 E.13375
G1 X94.229 Y78.286 E.00199
G1 X94.276 Y78.187 E.00214
G1 X94.33 Y78.122 E.00167
G1 X94.654 Y77.886 E.00788
G1 X94.37 Y77.614 E.00773
G1 X94.238 Y77.536 E.00302
G1 X94.022 Y77.491 E.00434
G1 X81.985 Y77.491 E.23676
G1 X81.819 Y77.516 E.00329
G1 X81.637 Y77.607 E.00401
G1 X81.505 Y77.739 E.00366
G1 X81.414 Y77.922 E.00402
G1 X81.39 Y78.086 E.00325
G1 X81.39 Y95.116 E.33497
G1 X81.413 Y95.274 E.00313
G1 X81.473 Y95.411 E.00296
G1 X81.58 Y95.546 E.00339
G1 X81.733 Y95.653 E.00367
G1 X81.976 Y95.711 E.0049
G1 X94.022 Y95.711 E.23694
G1 X94.238 Y95.666 E.00434
G1 X94.37 Y95.587 E.00302
G1 X94.654 Y95.316 E.00772
G1 X94.33 Y95.08 E.00788
G1 X94.276 Y95.015 E.00166
G1 X94.228 Y94.911 E.00225
G1 X94.21 Y94.786 E.00249
G1 X94.21 Y88.019 E.13309
G1 X94.237 Y87.865 E.00307
G1 X94.29 Y87.767 E.00221
G1 X94.426 Y87.654 E.00347
G1 X94.58 Y87.612 E.00315
G1 X99.41 Y87.612 E.095
G1 X99.556 Y87.646 E.00295
G1 X99.647 Y87.703 E.0021
G1 X99.733 Y87.803 E.0026
G1 X99.779 Y87.915 E.00238
G1 X99.79 Y94.782 E.13507
G1 X99.763 Y94.933 E.00301
G1 X99.692 Y95.058 E.00282
G1 X99.572 Y95.15 E.00298
G1 X99.417 Y95.19 E.00315
G1 X95.792 Y95.191 E.07129
G1 X95.788 Y95.672 E.00946
G1 X95.754 Y95.898 E.0045
G1 X95.684 Y96.112 E.00442
G1 X95.577 Y96.309 E.00442
G1 X95.44 Y96.483 E.00436
G1 X95.206 Y96.679 E.00601
G1 X95.011 Y96.785 E.00436
G1 X94.8 Y96.854 E.00436
G1 X94.488 Y96.891 E.00619
G1 X90.377 Y96.891 E.08086
G1 X90.857 Y97.411 E.01393
G1 X91.122 Y97.754 E.00852
G1 X91.366 Y98.159 E.0093
G1 X91.461 Y98.356 E.0043
G1 X91.621 Y98.783 E.00897
G1 X91.68 Y98.994 E.0043
G1 X91.762 Y99.443 E.00897
G1 X91.782 Y99.661 E.00431
G1 X91.784 Y100.117 E.00897
G1 X91.765 Y100.335 E.00431
G1 X91.69 Y100.762 E.00853
G1 X91.555 Y101.215 E.00929
G1 X91.473 Y101.417 E.0043
G1 X91.267 Y101.821 E.00891
G1 X91.026 Y102.182 E.00853
G1 X90.726 Y102.534 E.0091
G1 X90.392 Y102.84 E.00891
G1 X90.027 Y103.103 E.00885
G1 X89.647 Y103.313 E.00853
G1 X89.429 Y103.411 E.00469
G1 X88.998 Y103.557 E.00896
G1 X88.785 Y103.609 E.00431
G1 X88.334 Y103.676 E.00897
G1 X88.116 Y103.689 E.00431
G1 X87.663 Y103.675 E.00892
G1 X87.215 Y103.608 E.00891
G1 X87.002 Y103.557 E.00431
G1 X86.573 Y103.412 E.00891
G1 X86.15 Y103.208 E.00923
G1 X85.784 Y102.975 E.00853
G1 X85.61 Y102.842 E.0043
G1 X85.277 Y102.536 E.00891
G1 X84.983 Y102.195 E.00885
G1 X84.733 Y101.821 E.00885
G1 X84.527 Y101.417 E.00891
G1 X84.445 Y101.214 E.00431
G1 X84.319 Y100.8 E.00853
G1 X84.236 Y100.337 E.00924
G1 X84.21 Y99.888 E.00885
G1 X84.239 Y99.44 E.00884
G1 X84.32 Y98.997 E.00885
G1 X84.453 Y98.567 E.00885
G1 X84.637 Y98.153 E.00891
G1 X84.744 Y97.962 E.0043
G1 X84.987 Y97.603 E.00853
G1 X85.563 Y96.936 E.01733
; WIPE_START
M204 S6000
G1 X83.563 Y96.914 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G17
G3 Z.96 I1.217 J0 P1  F18000
;===================== date: 20250206 =====================

; don't support timelapse gcode in spiral_mode and by object sequence for I3 structure printer
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
G92 E0
G1 Z0.96
G1 X0 Y90 ; move to safe pos
G1 X-13.0 F3000 ; move to safe pos
M400
M1004 S5 P1  ; external shutter
M400 P300
M971 S11 C11 O0
G92 E0
G1 X0 F18000
M623

; SKIPTYPE: head_wrap_detect
M622.1 S1
M1002 judge_flag g39_3rd_layer_detect_flag
M622 J1
    ; enable nozzle clog detect at 3rd layer
    


    M622.1 S1
    M1002 judge_flag g39_detection_flag
    M622 J1
      
        M622.1 S0
        M1002 judge_flag g39_mass_exceed_flag
        M622 J1
        
            G392 S0
            M400
            G90
            M83
            M204 S5000
            G0 Z0.96 F4000
            G39.3 S1
            G0 Z0.96 F4000
            G392 S0
          
        M623
    
    M623
M623
; SKIPPABLE_END




G1 X81.437 Y96.256
G1 Z.56
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.149408
G1 F1500
M204 S6000
G1 X81.099 Y96.043 E.00246
G1 X80.948 Y95.848 E.00152
G1 X80.899 Y95.757 E.00064
; LINE_WIDTH: 0.0956393
G1 X80.863 Y95.625 E.00048
; WIPE_START
G1 X80.899 Y95.757 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X86.528 Y97.178 Z.96 F18000
G1 Z.56
G1 E.4 F1800
; LINE_WIDTH: 0.473162
G1 F1500
M204 S6000
G1 X86.361 Y97.32 E.00489
; LINE_WIDTH: 0.439165
G1 X86.168 Y97.487 E.00526
; LINE_WIDTH: 0.402635
G1 X85.99 Y97.669 E.00479
; LINE_WIDTH: 0.359633
G1 X85.617 Y98.086 E.00933
G1 X85.421 Y98.373 E.00579
G1 X85.22 Y98.779 E.00755
G1 X85.089 Y99.186 E.00711
G1 X85.015 Y99.623 E.00739
G1 X85.005 Y100.018 E.00658
G1 X85.067 Y100.522 E.00846
G1 X85.19 Y100.946 E.00736
G1 X85.419 Y101.42 E.00878
G1 X85.613 Y101.716 E.00589
G1 X85.919 Y102.057 E.00763
G1 X86.336 Y102.395 E.00895
G1 X86.835 Y102.665 E.00945
G1 X87.307 Y102.817 E.00826
G1 X87.696 Y102.884 E.00659
G1 X88.072 Y102.9 E.00627
G1 X88.596 Y102.84 E.00878
G1 X89.081 Y102.697 E.00843
G1 X89.428 Y102.533 E.00638
G1 X89.728 Y102.35 E.00584
G1 X90.149 Y101.994 E.00919
G1 X90.387 Y101.711 E.00617
G1 X90.656 Y101.29 E.00832
G1 X90.805 Y100.951 E.00616
G1 X90.918 Y100.58 E.00646
G1 X90.991 Y100.081 E.0084
G1 X90.975 Y99.548 E.00888
G1 X90.869 Y99.025 E.00889
G1 X90.732 Y98.674 E.00628
G1 X90.567 Y98.355 E.00597
G1 X90.355 Y98.046 E.00626
G1 X90.001 Y97.655 E.00878
; LINE_WIDTH: 0.395951
G1 X89.811 Y97.484 E.00471
; LINE_WIDTH: 0.442293
G1 X89.622 Y97.314 E.0053
; LINE_WIDTH: 0.480805
G1 X89.379 Y97.129 E.00693
; WIPE_START
G1 X89.622 Y97.314 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X94.537 Y96.256 Z.96 F18000
G1 Z.56
G1 E.4 F1800
; LINE_WIDTH: 0.149099
G1 F1500
M204 S6000
G1 X94.82 Y96.107 E.00197
G1 X95.135 Y95.785 E.00277
; WIPE_START
G1 X94.82 Y96.107 E-.22196
G1 X94.537 Y96.256 E-.15804
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X95.122 Y88.646 Z.96 F18000
G1 X95.453 Y84.347 Z.96
G1 Z.56
G1 E.4 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.419992
G1 F1500
M204 S6000
G1 X98.546 Y84.348 E.06085
G1 X98.547 Y79.254 E.10018
G1 X95.454 Y79.253 E.06085
G1 X95.453 Y84.287 E.09901
M204 S10000
G1 X95.847 Y83.953 F18000
G1 F1500
M204 S6000
G1 X98.152 Y83.954 E.04534
G1 X98.153 Y79.648 E.08468
G1 X95.848 Y79.648 E.04534
G1 X95.847 Y83.893 E.0835
M204 S10000
G1 X96.241 Y83.559 F18000
G1 F1500
M204 S6000
G1 X97.758 Y83.559 E.02983
G1 X97.759 Y80.043 E.06917
G1 X96.242 Y80.042 E.02983
G1 X96.241 Y83.499 E.06799
M204 S10000
G1 X96.636 Y83.165 F18000
G1 F1500
M204 S6000
G1 X97.364 Y83.165 E.01432
G1 X97.364 Y80.437 E.05366
G1 X96.636 Y80.437 E.01432
G1 X96.636 Y83.105 E.05248
M204 S10000
G1 X97 Y82.801 F18000
; LINE_WIDTH: 0.359632
G1 F1500
M204 S6000
G1 X97 Y80.861 E.03232
; WIPE_START
G1 X97 Y82.801 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X95.143 Y77.444 Z.96 F18000
G1 Z.56
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.144844
G1 F1500
M204 S6000
G1 X94.845 Y77.115 E.00263
G1 X94.783 Y77.067 E.00047
G1 X94.535 Y76.95 E.00163
; WIPE_START
G1 X94.783 Y77.067 E-.13081
G1 X94.845 Y77.115 E-.03765
G1 X95.143 Y77.444 E-.21154
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X87.515 Y77.171 Z.96 F18000
G1 X81.504 Y76.955 Z.96
G1 Z.56
G1 E.4 F1800
; LINE_WIDTH: 0.0892265
G1 F1500
M204 S6000
G1 X81.398 Y76.991 E.00035
; LINE_WIDTH: 0.122659
G1 X81.23 Y77.061 E.00088
; LINE_WIDTH: 0.153908
G1 X81.109 Y77.154 E.00098
G1 X80.935 Y77.367 E.00175
; LINE_WIDTH: 0.120757
G1 X80.895 Y77.486 E.00059
; LINE_WIDTH: 0.0908772
G1 X80.854 Y77.604 E.00041
; CHANGE_LAYER
; Z_HEIGHT: 0.68
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F1500
G1 X80.895 Y77.486 E-.38
; WIPE_END
G1 E-.02 F1800
; layer num/total_layer_count: 5/49
; update layer progress
M73 L5
M991 S0 P4 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z.96 I-.907 J.812 P1  F18000
G1 X94.881 Y93.111 Z.96
G1 Z.68
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X94.881 Y89.282 E.08105
G1 X99.119 Y89.282 E.08971
G1 X99.119 Y93.52 E.08971
G1 X94.881 Y93.52 E.08971
G1 X94.881 Y93.171 E.00739
M204 S250
G1 X95.29 Y93.111 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X95.29 Y89.691 E.06727
G1 X98.71 Y89.691 E.06727
G1 X98.71 Y93.111 E.06727
G1 X95.35 Y93.111 E.06609
; WIPE_START
M204 S6000
G1 X95.315 Y91.111 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X95.29 Y88.857 Z1.08 F18000
G1 Z.68
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X95.043 Y88.857 E.00522
G1 X95.043 Y88.445 E.00872
G1 X98.957 Y88.445 E.08282
G1 X98.957 Y88.857 E.00872
G1 X95.35 Y88.857 E.07634
; WIPE_START
M204 S6000
G1 X95.043 Y88.857 E-.05824
G1 X95.043 Y88.445 E-.07829
G1 X96.325 Y88.445 E-.24348
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X98.957 Y93.944 Z1.08 F18000
G1 Z.68
G1 E.4 F1800
G1 F1500
M204 S500
G1 X98.957 Y94.357 E.00872
G1 X95.043 Y94.358 E.08282
G1 X95.043 Y93.944 E.00875
G1 X98.897 Y93.944 E.08155
; WIPE_START
M204 S6000
G1 X98.957 Y94.357 E-.07914
G1 X97.373 Y94.357 E-.30086
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X90.14 Y96.794 Z1.08 F18000
G1 X89.225 Y97.103 Z1.08
M73 P41 R14
G1 Z.68
G1 E.4 F1800
G1 F1500
M204 S500
G1 X88.766 Y96.953 E.01021
G1 X88.393 Y96.88 E.00804
G1 X87.879 Y96.857 E.0109
G1 X87.501 Y96.897 E.00804
G1 X87.131 Y96.981 E.00804
G1 X86.762 Y97.126 E.00839
G1 X86.647 Y96.963 E.00423
G1 X87.011 Y96.544 E.01174
G1 X88.986 Y96.544 E.0418
G1 X89.332 Y96.941 E.01114
G1 X89.258 Y97.053 E.00283
; WIPE_START
M204 S6000
G1 X88.766 Y96.953 E-.09535
G1 X88.393 Y96.88 E-.07222
G1 X87.879 Y96.857 E-.09782
G1 X87.501 Y96.897 E-.07217
G1 X87.283 Y96.946 E-.04244
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X90.617 Y99.844 Z1.08 F18000
G1 Z.68
G1 E.4 F1800
G1 F1500
M204 S500
G1 X90.622 Y99.902 E.00124
G1 X90.578 Y100.374 E.01002
G1 X90.504 Y100.674 E.00654
G1 X90.391 Y100.975 E.00683
G1 X90.166 Y101.378 E.00975
G1 X89.868 Y101.741 E.00995
G1 X89.516 Y102.039 E.00975
G1 X89.242 Y102.208 E.00682
G1 X88.962 Y102.338 E.00654
G1 X88.508 Y102.473 E.01002
G1 X88.048 Y102.521 E.00978
G1 X87.727 Y102.507 E.00682
G1 X87.422 Y102.457 E.00654
G1 X86.971 Y102.312 E.01002
G1 X86.556 Y102.089 E.00997
G1 X86.188 Y101.796 E.00995
G1 X85.879 Y101.442 E.00995
G1 X85.643 Y101.046 E.00975
G1 X85.52 Y100.748 E.00683
G1 X85.434 Y100.437 E.00683
G1 X85.381 Y99.989 E.00955
G1 X85.39 Y99.667 E.00682
G1 X85.436 Y99.361 E.00655
G1 X85.574 Y98.908 E.01002
G1 X85.791 Y98.489 E.00998
G1 X86.078 Y98.118 E.00995
G1 X86.427 Y97.803 E.00995
G1 X86.827 Y97.556 E.00995
G1 X87.256 Y97.388 E.00975
G1 X87.571 Y97.316 E.00683
G1 X87.892 Y97.282 E.00683
G1 X88.342 Y97.302 E.00955
G1 X88.659 Y97.365 E.00683
G1 X88.966 Y97.465 E.00683
G1 X89.378 Y97.671 E.00975
G1 X89.747 Y97.947 E.00975
G1 X89.973 Y98.177 E.00683
G1 X90.171 Y98.432 E.00683
G1 X90.39 Y98.826 E.00955
G1 X90.504 Y99.129 E.00684
G1 X90.58 Y99.442 E.00683
G1 X90.611 Y99.784 E.00727
M204 S250
G1 X90.209 Y99.881 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X90.211 Y99.901 E.00041
G1 X90.173 Y100.305 E.00798
G1 X90.112 Y100.552 E.00501
G1 X90.018 Y100.803 E.00526
G1 X89.827 Y101.146 E.00774
G1 X89.575 Y101.452 E.00779
G1 X89.275 Y101.707 E.00773
G1 X89.048 Y101.847 E.00526
G1 X88.817 Y101.955 E.00501
G1 X88.428 Y102.07 E.00798
G1 X88.036 Y102.111 E.00775
G1 X87.769 Y102.099 E.00525
G1 X87.518 Y102.058 E.00501
G1 X87.131 Y101.934 E.00798
G1 X86.782 Y101.746 E.0078
G1 X86.472 Y101.499 E.0078
G1 X86.211 Y101.2 E.0078
G1 X86.01 Y100.863 E.00773
G1 X85.908 Y100.615 E.00526
G1 X85.837 Y100.357 E.00526
G1 X85.791 Y99.97 E.00767
G1 X85.799 Y99.703 E.00526
G1 X85.836 Y99.451 E.00501
G1 X85.954 Y99.063 E.00798
G1 X86.137 Y98.711 E.0078
G1 X86.379 Y98.397 E.00779
G1 X86.674 Y98.132 E.0078
G1 X87.011 Y97.924 E.0078
G1 X87.377 Y97.78 E.00773
G1 X87.638 Y97.72 E.00526
G1 X87.904 Y97.692 E.00526
G1 X88.294 Y97.71 E.00767
G1 X88.556 Y97.762 E.00526
G1 X88.811 Y97.844 E.00526
G1 X89.162 Y98.02 E.00773
G1 X89.477 Y98.256 E.00773
G1 X89.665 Y98.447 E.00526
G1 X89.828 Y98.658 E.00526
G1 X90.018 Y98.999 E.00767
G1 X90.112 Y99.25 E.00527
G1 X90.176 Y99.509 E.00526
G1 X90.204 Y99.821 E.00615
; WIPE_START
M204 S6000
G1 X90.211 Y99.901 E-.01534
G1 X90.173 Y100.305 E-.07707
G1 X90.112 Y100.552 E-.04838
G1 X90.018 Y100.803 E-.05083
G1 X89.827 Y101.146 E-.07472
G1 X89.575 Y101.452 E-.07529
G1 X89.421 Y101.583 E-.03836
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X92.373 Y94.544 Z1.08 F18000
G1 X98.956 Y78.845 Z1.08
G1 Z.68
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X98.956 Y84.757 E.12513
G1 X95.044 Y84.756 E.0828
G1 X95.044 Y78.844 E.12514
G1 X98.896 Y78.845 E.08153
; WIPE_START
M204 S6000
G1 X98.916 Y80.845 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X94.164 Y86.817 Z1.08 F18000
G1 X86.761 Y96.12 Z1.08
G1 Z.68
G1 E.4 F1800
G1 F1500
M204 S500
G1 X94.064 Y96.12 E.15458
G1 X94.388 Y96.052 E.00699
G1 X94.618 Y95.916 E.00567
G1 X95.29 Y95.274 E.01968
G1 X94.619 Y94.784 E.01757
G1 X94.619 Y88.021 E.14315
G1 X99.381 Y88.021 E.10078
G1 X99.381 Y94.781 E.14307
G1 X95.386 Y94.782 E.08455
G1 X95.379 Y95.64 E.01817
G1 X95.355 Y95.803 E.00349
G1 X95.307 Y95.949 E.00324
G1 X95.234 Y96.084 E.00324
G1 X95.144 Y96.197 E.00307
G1 X94.981 Y96.335 E.00453
G1 X94.847 Y96.408 E.00322
G1 X94.711 Y96.453 E.00302
G1 X94.464 Y96.482 E.00527
G1 X89.494 Y96.482 E.10519
G1 X90.669 Y97.827 E.03781
G1 X90.791 Y97.994 E.00437
G1 X91 Y98.345 E.00865
G1 X91.167 Y98.72 E.00869
G1 X91.326 Y99.3 E.01273
G1 X91.355 Y99.49 E.00406
G1 X91.374 Y100.1 E.01292
G1 X91.287 Y100.686 E.01254
G1 X91.171 Y101.07 E.0085
G1 X90.918 Y101.607 E.01256
G1 X90.57 Y102.096 E.0127
G1 X90.285 Y102.391 E.0087
G1 X89.984 Y102.637 E.00821
G1 X89.643 Y102.855 E.00858
G1 X89.273 Y103.032 E.00869
G1 X88.884 Y103.163 E.00868
G1 X88.292 Y103.269 E.01273
G1 X87.699 Y103.267 E.01254
G1 X87.116 Y103.164 E.01254
G1 X86.72 Y103.029 E.00885
G1 X86.193 Y102.757 E.01256
G1 X85.867 Y102.522 E.00851
G1 X85.571 Y102.251 E.00849
G1 X85.31 Y101.947 E.0085
G1 X85.086 Y101.613 E.0085
G1 X84.9 Y101.248 E.00868
G1 X84.719 Y100.708 E.01206
G1 X84.643 Y100.289 E.009
G1 X84.62 Y99.89 E.00846
G1 X84.645 Y99.49 E.00849
G1 X84.718 Y99.095 E.0085
G1 X84.909 Y98.534 E.01254
G1 X85.086 Y98.189 E.0082
G1 X85.324 Y97.837 E.009
G1 X86.503 Y96.482 E.03802
G1 X81.536 Y96.482 E.10513
G1 X81.288 Y96.453 E.00528
G1 X81.15 Y96.407 E.00308
G1 X80.886 Y96.228 E.00676
G1 X80.739 Y96.042 E.00502
G1 X80.648 Y95.813 E.00522
G1 X80.619 Y95.565 E.00529
G1 X80.619 Y77.619 E.37984
G1 X80.659 Y77.348 E.00579
G1 X80.766 Y77.116 E.00541
G1 X80.935 Y76.928 E.00536
G1 X81.061 Y76.84 E.00325
G1 X81.201 Y76.774 E.00327
G1 X81.458 Y76.723 E.00554
G1 X94.472 Y76.72 E.27546
G1 X94.702 Y76.748 E.00489
G1 X94.901 Y76.82 E.00449
G1 X95.022 Y76.896 E.00303
G1 X95.171 Y77.037 E.00434
G1 X95.288 Y77.215 E.00452
G1 X95.341 Y77.349 E.00305
G1 X95.372 Y77.498 E.00323
G1 X95.397 Y78.42 E.01951
G1 X99.381 Y78.421 E.08431
G1 X99.38 Y85.182 E.14309
G1 X94.619 Y85.181 E.10076
G1 X94.62 Y78.416 E.14317
G1 X95.289 Y77.928 E.01753
G1 X94.619 Y77.286 E.01964
G1 X94.387 Y77.149 E.00569
G1 X94.064 Y77.082 E.00698
G1 X81.954 Y77.082 E.25633
G1 X81.693 Y77.121 E.00559
G1 X81.394 Y77.272 E.00709
G1 X81.171 Y77.495 E.00668
G1 X81.019 Y77.798 E.00717
G1 X80.981 Y78.056 E.00552
G1 X80.981 Y95.146 E.36173
G1 X81.017 Y95.395 E.00533
G1 X81.139 Y95.656 E.0061
G1 X81.304 Y95.852 E.00542
G1 X81.562 Y96.034 E.00668
G1 X81.928 Y96.12 E.00795
G1 X86.701 Y96.12 E.10103
; WIPE_START
M204 S6000
G1 X88.701 Y96.12 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X85.604 Y96.891 Z1.08 F18000
G1 Z.68
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X81.512 Y96.891 E.08049
G1 X81.199 Y96.854 E.00619
G1 X80.994 Y96.787 E.00425
G1 X80.861 Y96.72 E.00293
G1 X80.607 Y96.53 E.00623
G1 X80.464 Y96.369 E.00425
G1 X80.383 Y96.246 E.00288
G1 X80.314 Y96.107 E.00306
G1 X80.247 Y95.901 E.00425
G1 X80.21 Y95.589 E.0062
G1 X80.21 Y77.607 E.35368
G1 X80.219 Y77.454 E.00301
G1 X80.265 Y77.231 E.00448
G1 X80.346 Y77.027 E.00431
G1 X80.423 Y76.892 E.00306
G1 X80.51 Y76.774 E.00288
G1 X80.671 Y76.613 E.00448
G1 X80.856 Y76.484 E.00442
G1 X81.054 Y76.391 E.00431
G1 X81.2 Y76.347 E.003
G1 X81.428 Y76.313 E.00453
G1 X94.496 Y76.311 E.25704
G1 X94.797 Y76.347 E.00595
G1 X95.081 Y76.45 E.00594
G1 X95.274 Y76.57 E.00447
G1 X95.487 Y76.772 E.00578
G1 X95.653 Y77.025 E.00595
G1 X95.735 Y77.231 E.00436
G1 X95.78 Y77.451 E.00442
G1 X95.796 Y78.011 E.01101
G1 X99.414 Y78.012 E.07118
G1 X99.526 Y78.034 E.00224
G1 X99.612 Y78.076 E.00187
G1 X99.699 Y78.154 E.00231
G1 X99.747 Y78.227 E.00171
G1 X99.79 Y78.413 E.00377
G1 X99.789 Y85.214 E.13377
G1 X99.764 Y85.336 E.00245
G1 X99.725 Y85.414 E.00172
G1 X99.669 Y85.481 E.00172
G1 X99.572 Y85.549 E.00233
G1 X99.388 Y85.591 E.00371
G1 X94.584 Y85.59 E.0945
G1 X94.406 Y85.537 E.00365
G1 X94.277 Y85.417 E.00346
G1 X94.229 Y85.312 E.00227
G1 X94.21 Y85.186 E.00251
G1 X94.211 Y78.388 E.13371
G1 X94.236 Y78.266 E.00243
G1 X94.33 Y78.122 E.00339
G1 X94.653 Y77.885 E.00788
G1 X94.37 Y77.614 E.00771
G1 X94.237 Y77.536 E.00303
G1 X94.022 Y77.491 E.00433
G1 X81.984 Y77.491 E.23677
G1 X81.818 Y77.516 E.0033
G1 X81.637 Y77.608 E.00401
G1 X81.507 Y77.738 E.00362
G1 X81.414 Y77.922 E.00407
G1 X81.39 Y78.086 E.00325
G1 X81.39 Y95.116 E.33498
G1 X81.414 Y95.277 E.00319
G1 X81.487 Y95.434 E.00343
G1 X81.583 Y95.548 E.00292
G1 X81.733 Y95.653 E.00361
G1 X81.975 Y95.711 E.0049
G1 X94.022 Y95.711 E.23694
M73 P42 R14
G1 X94.238 Y95.666 E.00434
G1 X94.37 Y95.588 E.00301
G1 X94.654 Y95.316 E.00773
G1 X94.33 Y95.08 E.00789
G1 X94.276 Y95.015 E.00166
G1 X94.228 Y94.911 E.00225
G1 X94.21 Y94.786 E.00249
G1 X94.21 Y88.019 E.13309
G1 X94.237 Y87.866 E.00307
G1 X94.292 Y87.764 E.00227
G1 X94.406 Y87.664 E.00297
G1 X94.583 Y87.612 E.00364
G1 X99.411 Y87.612 E.09496
G1 X99.547 Y87.643 E.00274
G1 X99.647 Y87.703 E.0023
G1 X99.737 Y87.81 E.00274
G1 X99.778 Y87.914 E.00221
G1 X99.79 Y94.782 E.13509
G1 X99.763 Y94.933 E.00301
G1 X99.693 Y95.055 E.00277
G1 X99.575 Y95.149 E.00297
G1 X99.417 Y95.19 E.00322
G1 X95.792 Y95.191 E.07129
G1 X95.788 Y95.672 E.00946
G1 X95.754 Y95.898 E.0045
G1 X95.684 Y96.112 E.00442
G1 X95.577 Y96.309 E.00442
G1 X95.439 Y96.483 E.00437
G1 X95.213 Y96.675 E.00584
G1 X95.01 Y96.785 E.00453
G1 X94.8 Y96.854 E.00435
G1 X94.488 Y96.891 E.00619
G1 X90.395 Y96.891 E.08051
G1 X90.989 Y97.571 E.01777
G1 X91.132 Y97.768 E.00479
G1 X91.364 Y98.156 E.0089
G1 X91.549 Y98.57 E.00891
G1 X91.619 Y98.777 E.0043
G1 X91.728 Y99.22 E.00897
G1 X91.782 Y99.661 E.00873
G1 X91.784 Y100.117 E.00897
G1 X91.765 Y100.335 E.00431
G1 X91.686 Y100.781 E.00891
G1 X91.556 Y101.212 E.00885
G1 X91.384 Y101.605 E.00844
G1 X91.269 Y101.819 E.00478
G1 X91.015 Y102.197 E.00896
G1 X90.877 Y102.368 E.0043
G1 X90.562 Y102.693 E.00892
G1 X90.23 Y102.965 E.00844
G1 X90.026 Y103.104 E.00484
G1 X89.836 Y103.216 E.00436
G1 X89.427 Y103.412 E.00891
G1 X88.998 Y103.557 E.00891
M73 P42 R13
G1 X88.785 Y103.609 E.00431
G1 X88.334 Y103.676 E.00897
G1 X88.116 Y103.689 E.00431
G1 X87.663 Y103.675 E.00892
G1 X87.215 Y103.608 E.00891
G1 X87.002 Y103.557 E.00431
G1 X86.571 Y103.411 E.00896
G1 X86.349 Y103.311 E.00478
G1 X85.973 Y103.103 E.00844
G1 X85.608 Y102.84 E.00886
G1 X85.277 Y102.536 E.00885
G1 X84.983 Y102.195 E.00885
G1 X84.733 Y101.821 E.00885
G1 X84.527 Y101.418 E.00891
G1 X84.445 Y101.214 E.00431
G1 X84.32 Y100.804 E.00843
G1 X84.236 Y100.337 E.00933
G1 X84.21 Y99.889 E.00884
G1 X84.239 Y99.44 E.00885
G1 X84.32 Y98.997 E.00885
G1 X84.454 Y98.564 E.00891
G1 X84.537 Y98.362 E.0043
G1 X84.734 Y97.981 E.00844
G1 X84.999 Y97.587 E.00933
G1 X85.565 Y96.936 E.01697
; WIPE_START
M204 S6000
G1 X83.565 Y96.914 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G17
G3 Z1.08 I1.217 J0 P1  F18000
;===================== date: 20250206 =====================

; don't support timelapse gcode in spiral_mode and by object sequence for I3 structure printer
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
G92 E0
G1 Z1.08
G1 X0 Y90 ; move to safe pos
G1 X-13.0 F3000 ; move to safe pos
M400
M1004 S5 P1  ; external shutter
M400 P300
M971 S11 C11 O0
G92 E0
G1 X0 F18000
M623

; SKIPTYPE: head_wrap_detect
M622.1 S1
M1002 judge_flag g39_3rd_layer_detect_flag
M622 J1
    ; enable nozzle clog detect at 3rd layer
    


    M622.1 S1
    M1002 judge_flag g39_detection_flag
    M622 J1
      
        M622.1 S0
        M1002 judge_flag g39_mass_exceed_flag
        M622 J1
        
            G392 S0
            M400
            G90
            M83
            M204 S5000
            G0 Z1.08 F4000
            G39.3 S1
            G0 Z1.08 F4000
            G392 S0
          
        M623
    
    M623
M623
; SKIPPABLE_END




G1 X81.388 Y96.245
G1 Z.68
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.14969
G1 F1500
M204 S6000
G1 X81.077 Y96.019 E.00238
G1 X80.945 Y95.846 E.00135
G1 X80.901 Y95.757 E.00061
; LINE_WIDTH: 0.098559
G1 X80.862 Y95.617 E.00053
; WIPE_START
G1 X80.901 Y95.757 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X86.536 Y97.174 Z1.08 F18000
G1 Z.68
G1 E.4 F1800
; LINE_WIDTH: 0.473045
G1 F1500
M204 S6000
G1 X86.365 Y97.318 E.00499
; LINE_WIDTH: 0.438136
G1 X86.169 Y97.487 E.00533
; LINE_WIDTH: 0.401761
G1 X85.99 Y97.669 E.00478
; LINE_WIDTH: 0.359912
G1 X85.629 Y98.071 E.00901
G1 X85.416 Y98.382 E.00629
G1 X85.219 Y98.78 E.00739
G1 X85.07 Y99.266 E.00848
G1 X85.014 Y99.643 E.00635
G1 X85.004 Y99.993 E.00585
G1 X85.025 Y100.244 E.00419
G1 X85.089 Y100.616 E.00629
G1 X85.25 Y101.094 E.00841
G1 X85.418 Y101.418 E.00609
G1 X85.613 Y101.716 E.00593
G1 X85.939 Y102.078 E.00812
G1 X86.36 Y102.412 E.00897
G1 X86.809 Y102.655 E.0085
G1 X87.218 Y102.794 E.0072
G1 X87.697 Y102.884 E.00813
G1 X88.048 Y102.895 E.00584
G1 X88.255 Y102.886 E.00346
G1 X88.595 Y102.836 E.00573
G1 X89.084 Y102.696 E.00848
G1 X89.431 Y102.537 E.00636
G1 X89.749 Y102.338 E.00626
G1 X90.146 Y101.994 E.00875
G1 X90.466 Y101.6 E.00847
G1 X90.587 Y101.41 E.00375
G1 X90.813 Y100.936 E.00876
G1 X90.947 Y100.448 E.00843
G1 X90.995 Y99.918 E.00888
G1 X90.975 Y99.542 E.00628
G1 X90.869 Y99.027 E.00876
G1 X90.725 Y98.658 E.0066
G1 X90.489 Y98.237 E.00805
G1 X90.264 Y97.936 E.00626
G1 X89.993 Y97.645 E.00663
; LINE_WIDTH: 0.397339
G1 X89.871 Y97.532 E.00308
; LINE_WIDTH: 0.432144
G1 X89.749 Y97.419 E.00337
; LINE_WIDTH: 0.467571
G1 X89.623 Y97.302 E.00379
; LINE_WIDTH: 0.469891
G1 X89.461 Y97.339 E.00368
; LINE_WIDTH: 0.438349
G1 X89.3 Y97.375 E.00342
; WIPE_START
G1 X89.461 Y97.339 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X94.537 Y96.257 Z1.08 F18000
G1 Z.68
G1 E.4 F1800
; LINE_WIDTH: 0.148945
G1 F1500
M204 S6000
G1 X94.825 Y96.103 E.00201
G1 X95.135 Y95.785 E.00272
; WIPE_START
G1 X94.825 Y96.103 E-.21886
G1 X94.537 Y96.257 E-.16114
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X95.122 Y88.647 Z1.08 F18000
G1 X95.453 Y84.347 Z1.08
G1 Z.68
G1 E.4 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.419992
G1 F1500
M204 S6000
G1 X98.546 Y84.348 E.06085
G1 X98.547 Y79.254 E.10018
G1 X95.454 Y79.253 E.06085
G1 X95.453 Y84.287 E.09901
M204 S10000
G1 X95.847 Y83.953 F18000
G1 F1500
M204 S6000
G1 X98.152 Y83.954 E.04534
G1 X98.153 Y79.648 E.08468
G1 X95.848 Y79.648 E.04534
G1 X95.847 Y83.893 E.0835
M204 S10000
G1 X96.241 Y83.559 F18000
G1 F1500
M204 S6000
G1 X97.758 Y83.559 E.02983
G1 X97.759 Y80.043 E.06917
G1 X96.242 Y80.042 E.02983
G1 X96.241 Y83.499 E.06799
M204 S10000
G1 X96.636 Y83.165 F18000
G1 F1500
M204 S6000
G1 X97.364 Y83.165 E.01432
G1 X97.364 Y80.437 E.05366
G1 X96.636 Y80.437 E.01432
G1 X96.636 Y83.105 E.05248
M204 S10000
G1 X97 Y82.801 F18000
; LINE_WIDTH: 0.359632
G1 F1500
M204 S6000
G1 X97 Y80.861 E.03232
; WIPE_START
G1 X97 Y82.801 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X95.142 Y77.444 Z1.08 F18000
G1 Z.68
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.144597
G1 F1500
M204 S6000
G1 X94.85 Y77.119 E.00259
G1 X94.781 Y77.066 E.00052
G1 X94.535 Y76.95 E.00162
; WIPE_START
G1 X94.781 Y77.066 E-.13002
G1 X94.85 Y77.119 E-.0415
G1 X95.142 Y77.444 E-.20848
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X87.515 Y77.171 Z1.08 F18000
G1 X81.503 Y76.955 Z1.08
G1 Z.68
G1 E.4 F1800
; LINE_WIDTH: 0.0997576
G1 F1500
M204 S6000
G1 X81.349 Y77.002 E.0006
; LINE_WIDTH: 0.148242
G1 X81.229 Y77.059 E.00081
G1 X81.118 Y77.146 E.00086
G1 X80.959 Y77.324 E.00146
G1 X80.912 Y77.423 E.00067
; LINE_WIDTH: 0.115251
G1 X80.883 Y77.514 E.00043
; LINE_WIDTH: 0.0897984
G1 X80.854 Y77.604 E.0003
; CHANGE_LAYER
; Z_HEIGHT: 0.8
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F1500
G1 X80.883 Y77.514 E-.38
; WIPE_END
G1 E-.02 F1800
; layer num/total_layer_count: 6/49
; update layer progress
M73 L6
M991 S0 P5 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z1.08 I-.894 J.826 P1  F18000
G1 X95.29 Y93.111 Z1.08
G1 Z.8
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X95.29 Y89.691 E.06727
G1 X98.71 Y89.691 E.06727
G1 X98.71 Y93.111 E.06727
G1 X95.35 Y93.111 E.06609
; WIPE_START
M204 S6000
G1 X95.315 Y91.111 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X89.84 Y96.429 Z1.2 F18000
G1 X89.155 Y97.094 Z1.2
G1 Z.8
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X88.942 Y97.002 E.00492
G1 X88.409 Y96.881 E.01156
G1 X87.863 Y96.856 E.01156
G1 X87.322 Y96.93 E.01157
G1 X86.765 Y97.11 E.01238
G1 X86.659 Y96.949 E.0041
G1 X87.011 Y96.544 E.01135
G1 X88.922 Y96.544 E.04046
G1 X89.274 Y96.925 E.01098
G1 X89.19 Y97.045 E.00309
; WIPE_START
M204 S6000
G1 X88.942 Y97.002 E-.04788
G1 X88.409 Y96.881 E-.10381
G1 X87.863 Y96.856 E-.10378
G1 X87.322 Y96.93 E-.10383
G1 X87.218 Y96.963 E-.0207
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X90.617 Y99.845 Z1.2 F18000
G1 Z.8
G1 E.4 F1800
G1 F1500
M204 S500
G1 X90.622 Y99.901 E.0012
G1 X90.58 Y100.369 E.00995
G1 X90.457 Y100.813 E.00975
G1 X90.326 Y101.108 E.00683
G1 X90.16 Y101.385 E.00683
G1 X89.868 Y101.741 E.00975
G1 X89.516 Y102.039 E.00975
G1 X89.242 Y102.208 E.00682
G1 X88.964 Y102.337 E.00649
G1 X88.508 Y102.473 E.01007
G1 X88.048 Y102.521 E.00979
G1 X87.727 Y102.507 E.00681
G1 X87.424 Y102.457 E.00649
G1 X86.971 Y102.312 E.01007
G1 X86.556 Y102.089 E.00998
G1 X86.188 Y101.796 E.00995
G1 X85.879 Y101.442 E.00995
G1 X85.643 Y101.046 E.00975
G1 X85.52 Y100.748 E.00683
G1 X85.434 Y100.437 E.00683
G1 X85.379 Y99.979 E.00975
G1 X85.407 Y99.519 E.00975
G1 X85.474 Y99.204 E.00683
G1 X85.578 Y98.898 E.00683
G1 X85.791 Y98.49 E.00975
G1 X86.079 Y98.117 E.00998
G1 X86.434 Y97.8 E.01008
G1 X86.69 Y97.631 E.00649
G1 X86.978 Y97.487 E.00682
G1 X87.417 Y97.345 E.00975
G1 X87.882 Y97.282 E.00995
G1 X88.352 Y97.303 E.00995
G1 X88.81 Y97.407 E.00995
G1 X89.234 Y97.588 E.00975
G1 X89.508 Y97.758 E.00683
G1 X89.753 Y97.954 E.00663
G1 X89.973 Y98.177 E.00663
G1 X90.171 Y98.433 E.00686
G1 X90.397 Y98.842 E.00988
G1 X90.504 Y99.129 E.00649
G1 X90.58 Y99.442 E.00682
G1 X90.611 Y99.785 E.00728
M204 S250
G1 X90.209 Y99.881 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X90.211 Y99.901 E.00039
G1 X90.175 Y100.296 E.00779
G1 X90.071 Y100.675 E.00773
G1 X89.962 Y100.919 E.00526
G1 X89.825 Y101.149 E.00526
G1 X89.575 Y101.452 E.00773
G1 X89.275 Y101.707 E.00773
G1 X89.048 Y101.847 E.00526
G1 X88.819 Y101.954 E.00496
G1 X88.428 Y102.07 E.00802
G1 X88.036 Y102.111 E.00775
G1 X87.769 Y102.099 E.00525
G1 X87.52 Y102.058 E.00496
G1 X87.132 Y101.934 E.00802
G1 X86.782 Y101.746 E.00781
G1 X86.472 Y101.499 E.0078
G1 X86.211 Y101.2 E.00779
G1 X86.01 Y100.863 E.00773
G1 X85.908 Y100.615 E.00526
G1 X85.837 Y100.358 E.00526
G1 X85.79 Y99.967 E.00774
G1 X85.814 Y99.574 E.00774
G1 X85.869 Y99.313 E.00526
G1 X85.956 Y99.06 E.00526
G1 X86.137 Y98.711 E.00773
G1 X86.38 Y98.397 E.00781
G1 X86.684 Y98.125 E.00803
G1 X86.895 Y97.987 E.00496
G1 X87.134 Y97.867 E.00526
G1 X87.508 Y97.745 E.00773
G1 X87.901 Y97.692 E.0078
G1 X88.297 Y97.71 E.00779
G1 X88.683 Y97.798 E.0078
G1 X89.045 Y97.953 E.00773
G1 X89.272 Y98.093 E.00526
G1 X89.479 Y98.258 E.0052
G1 X89.665 Y98.447 E.0052
G1 X89.828 Y98.658 E.00527
G1 X90.024 Y99.013 E.00797
G1 X90.112 Y99.25 E.00496
G1 X90.176 Y99.509 E.00526
G1 X90.204 Y99.821 E.00616
; WIPE_START
M204 S6000
G1 X90.211 Y99.901 E-.01515
G1 X90.175 Y100.296 E-.07529
G1 X90.071 Y100.675 E-.07472
G1 X89.962 Y100.919 E-.05084
G1 X89.825 Y101.149 E-.05083
G1 X89.575 Y101.452 E-.07471
G1 X89.421 Y101.583 E-.03846
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X95.377 Y96.811 Z1.2 F18000
G1 X98.955 Y93.944 Z1.2
G1 Z.8
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X98.956 Y94.357 E.00872
G1 X95.043 Y94.358 E.08281
G1 X95.043 Y93.944 E.00875
G1 X98.895 Y93.944 E.08153
; WIPE_START
M204 S6000
G1 X98.956 Y94.357 E-.07915
G1 X97.373 Y94.357 E-.30085
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X95.29 Y88.857 Z1.2 F18000
G1 Z.8
G1 E.4 F1800
G1 F1500
M204 S500
G1 X95.043 Y88.857 E.00522
G1 X95.043 Y88.445 E.00872
G1 X98.948 Y88.445 E.08265
G1 X98.949 Y88.857 E.00872
G1 X95.35 Y88.857 E.07617
; WIPE_START
M204 S6000
G1 X95.043 Y88.857 E-.05824
G1 X95.043 Y88.445 E-.07829
G1 X96.325 Y88.445 E-.24348
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X98.343 Y81.084 Z1.2 F18000
G1 X98.956 Y78.845 Z1.2
G1 Z.8
G1 E.4 F1800
G1 F1500
M204 S500
G1 X98.956 Y84.757 E.12513
G1 X95.044 Y84.756 E.0828
G1 X95.044 Y78.844 E.12514
G1 X98.896 Y78.845 E.08153
; WIPE_START
M204 S6000
G1 X98.916 Y80.845 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X94.164 Y86.817 Z1.2 F18000
G1 X86.761 Y96.12 Z1.2
G1 Z.8
G1 E.4 F1800
G1 F1500
M204 S500
G1 X94.064 Y96.12 E.15459
G1 X94.388 Y96.052 E.007
G1 X94.618 Y95.916 E.00566
G1 X95.29 Y95.274 E.01967
G1 X94.619 Y94.784 E.01758
G1 X94.619 Y88.021 E.14315
G1 X99.372 Y88.021 E.10059
G1 X99.373 Y89.282 E.02668
G1 X94.881 Y89.282 E.09509
G1 X94.881 Y93.52 E.08971
G1 X99.119 Y93.52 E.08971
G1 X99.119 Y89.362 E.08802
G1 X99.374 Y89.361 E.00538
G1 X99.381 Y94.781 E.1147
G1 X95.386 Y94.782 E.08455
G1 X95.379 Y95.64 E.01817
G1 X95.355 Y95.804 E.00349
G1 X95.307 Y95.949 E.00324
G1 X95.234 Y96.084 E.00324
G1 X95.144 Y96.197 E.00306
G1 X94.982 Y96.334 E.0045
G1 X94.847 Y96.408 E.00326
G1 X94.711 Y96.453 E.00302
G1 X94.464 Y96.482 E.00527
M73 P43 R13
G1 X89.442 Y96.482 E.1063
G1 X90.544 Y97.675 E.03439
G1 X90.795 Y98.001 E.0087
G1 X91.085 Y98.519 E.01257
G1 X91.229 Y98.901 E.00864
G1 X91.355 Y99.49 E.01274
G1 X91.374 Y100.1 E.01292
G1 X91.293 Y100.659 E.01197
G1 X91.168 Y101.08 E.00929
G1 X90.914 Y101.614 E.01251
G1 X90.569 Y102.098 E.01257
G1 X90.285 Y102.391 E.00864
G1 X89.967 Y102.65 E.00869
G1 X89.643 Y102.855 E.0081
G1 X89.273 Y103.032 E.00869
G1 X88.884 Y103.163 E.00869
G1 X88.301 Y103.267 E.01254
G1 X87.708 Y103.269 E.01254
G1 X87.107 Y103.161 E.01293
G1 X86.544 Y102.951 E.01273
G1 X86.193 Y102.757 E.0085
G1 X85.867 Y102.522 E.00849
G1 X85.571 Y102.251 E.00849
G1 X85.31 Y101.947 E.0085
G1 X85.086 Y101.613 E.00851
G1 X84.831 Y101.077 E.01256
G1 X84.713 Y100.686 E.00864
G1 X84.643 Y100.291 E.0085
G1 X84.62 Y99.89 E.00849
G1 X84.645 Y99.491 E.00846
G1 X84.725 Y99.069 E.0091
G1 X84.908 Y98.534 E.01196
G1 X85.097 Y98.17 E.00869
G1 X85.323 Y97.838 E.00849
G1 X86.503 Y96.482 E.03805
G1 X81.536 Y96.482 E.10513
G1 X81.298 Y96.454 E.00508
G1 X81.018 Y96.336 E.00644
G1 X80.832 Y96.173 E.00522
G1 X80.734 Y96.033 E.00363
G1 X80.648 Y95.812 E.00501
G1 X80.619 Y95.565 E.00527
G1 X80.619 Y77.619 E.37984
G1 X80.66 Y77.34 E.00597
G1 X80.766 Y77.118 E.0052
G1 X80.861 Y76.998 E.00325
G1 X80.976 Y76.895 E.00324
G1 X81.2 Y76.775 E.00539
G1 X81.451 Y76.723 E.00541
G1 X94.474 Y76.72 E.27565
G1 X94.701 Y76.748 E.00485
G1 X94.901 Y76.82 E.00449
G1 X95.023 Y76.897 E.00306
G1 X95.171 Y77.037 E.0043
G1 X95.288 Y77.215 E.00452
G1 X95.341 Y77.349 E.00305
G1 X95.372 Y77.498 E.00323
G1 X95.397 Y78.42 E.01951
G1 X99.381 Y78.421 E.08431
G1 X99.38 Y85.182 E.14309
G1 X94.619 Y85.181 E.10076
G1 X94.62 Y78.417 E.14317
G1 X95.29 Y77.928 E.01755
G1 X94.618 Y77.285 E.01968
G1 X94.388 Y77.15 E.00566
G1 X94.064 Y77.082 E.007
G1 X81.954 Y77.082 E.25633
G1 X81.692 Y77.121 E.00561
G1 X81.393 Y77.272 E.00708
G1 X81.171 Y77.495 E.00667
G1 X81.019 Y77.798 E.00717
G1 X80.981 Y78.056 E.00552
G1 X80.981 Y95.146 E.36173
G1 X81.017 Y95.395 E.00533
G1 X81.139 Y95.656 E.0061
G1 X81.304 Y95.853 E.00542
G1 X81.562 Y96.034 E.00668
G1 X81.928 Y96.12 E.00794
G1 X86.701 Y96.12 E.10103
; WIPE_START
M204 S6000
G1 X88.701 Y96.12 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X85.604 Y96.891 Z1.2 F18000
G1 Z.8
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X81.512 Y96.891 E.08049
G1 X81.203 Y96.855 E.00613
G1 X80.916 Y96.75 E.006
G1 X80.786 Y96.674 E.00297
G1 X80.613 Y96.537 E.00434
G1 X80.514 Y96.432 E.00283
G1 X80.382 Y96.243 E.00454
G1 X80.317 Y96.114 E.00283
G1 X80.247 Y95.901 E.00442
G1 X80.21 Y95.589 E.00619
G1 X80.21 Y77.607 E.35368
G1 X80.219 Y77.454 E.00301
G1 X80.266 Y77.228 E.00454
G1 X80.315 Y77.093 E.00283
G1 X80.423 Y76.892 E.00448
G1 X80.562 Y76.716 E.00442
G1 X80.725 Y76.571 E.00428
G1 X80.853 Y76.485 E.00304
G1 X81.059 Y76.389 E.00447
G1 X81.269 Y76.332 E.00428
G1 X81.426 Y76.313 E.0031
G1 X94.498 Y76.311 E.25713
G1 X94.797 Y76.347 E.00592
G1 X95.081 Y76.45 E.00594
G1 X95.275 Y76.571 E.0045
G1 X95.487 Y76.772 E.00574
G1 X95.653 Y77.025 E.00595
G1 X95.735 Y77.231 E.00436
G1 X95.78 Y77.451 E.00442
G1 X95.796 Y78.011 E.01101
G1 X99.415 Y78.012 E.07118
G1 X99.524 Y78.033 E.0022
G1 X99.615 Y78.077 E.00197
G1 X99.68 Y78.132 E.00168
G1 X99.748 Y78.229 E.00234
G1 X99.79 Y78.413 E.00371
G1 X99.789 Y85.216 E.1338
G1 X99.769 Y85.321 E.00209
G1 X99.723 Y85.416 E.00208
G1 X99.669 Y85.481 E.00168
G1 X99.572 Y85.549 E.00233
G1 X99.388 Y85.591 E.00371
G1 X94.583 Y85.59 E.09449
G1 X94.406 Y85.537 E.00365
G1 X94.277 Y85.417 E.00347
G1 X94.229 Y85.312 E.00227
G1 X94.21 Y85.186 E.00252
G1 X94.211 Y78.385 E.13377
G1 X94.227 Y78.294 E.00182
G1 X94.276 Y78.187 E.00231
G1 X94.33 Y78.122 E.00166
G1 X94.654 Y77.886 E.00788
G1 X94.37 Y77.614 E.00773
G1 X94.238 Y77.536 E.00301
G1 X94.022 Y77.491 E.00435
G1 X81.984 Y77.491 E.23676
G1 X81.818 Y77.516 E.00332
G1 X81.636 Y77.608 E.004
G1 X81.507 Y77.738 E.00361
G1 X81.414 Y77.922 E.00406
G1 X81.39 Y78.086 E.00325
G1 X81.39 Y95.116 E.33498
G1 X81.413 Y95.276 E.00319
G1 X81.487 Y95.435 E.00343
G1 X81.583 Y95.548 E.00292
G1 X81.733 Y95.653 E.00361
G1 X81.975 Y95.711 E.0049
G1 X94.022 Y95.711 E.23694
G1 X94.238 Y95.665 E.00434
G1 X94.37 Y95.588 E.00301
G1 X94.654 Y95.316 E.00773
G1 X94.331 Y95.081 E.00785
G1 X94.267 Y95.001 E.00202
G1 X94.228 Y94.913 E.00189
G1 X94.21 Y94.786 E.00252
G1 X94.21 Y88.019 E.13309
G1 X94.237 Y87.866 E.00307
G1 X94.292 Y87.764 E.00227
G1 X94.406 Y87.664 E.00297
G1 X94.583 Y87.612 E.00365
G1 X99.412 Y87.612 E.09496
G1 X99.545 Y87.642 E.0027
G1 X99.648 Y87.703 E.00235
G1 X99.735 Y87.807 E.00267
G1 X99.781 Y87.934 E.00264
G1 X99.79 Y94.783 E.13471
G1 X99.763 Y94.933 E.00301
G1 X99.693 Y95.055 E.00277
G1 X99.575 Y95.149 E.00297
G1 X99.417 Y95.19 E.00321
G1 X95.792 Y95.191 E.07129
G1 X95.788 Y95.672 E.00946
G1 X95.754 Y95.898 E.0045
G1 X95.684 Y96.111 E.00442
G1 X95.577 Y96.309 E.00442
G1 X95.44 Y96.483 E.00436
G1 X95.214 Y96.674 E.00581
G1 X95.01 Y96.785 E.00456
G1 X94.8 Y96.854 E.00435
G1 X94.488 Y96.891 E.00619
G1 X90.377 Y96.891 E.08086
G1 X90.857 Y97.411 E.01393
G1 X91.134 Y97.77 E.00891
G1 X91.352 Y98.134 E.00835
G1 X91.461 Y98.357 E.00488
G1 X91.62 Y98.78 E.0089
G1 X91.728 Y99.22 E.00891
G1 X91.782 Y99.661 E.00873
G1 X91.784 Y100.117 E.00897
G1 X91.765 Y100.335 E.00431
G1 X91.692 Y100.753 E.00834
G1 X91.555 Y101.215 E.00948
G1 X91.473 Y101.418 E.00429
G1 X91.267 Y101.821 E.00891
G1 X91.031 Y102.174 E.00835
G1 X90.877 Y102.368 E.00488
G1 X90.562 Y102.693 E.0089
G1 X90.211 Y102.979 E.00891
G1 X89.836 Y103.216 E.00873
G1 X89.427 Y103.412 E.00891
G1 X88.998 Y103.557 E.00891
G1 X88.785 Y103.609 E.00431
G1 X88.337 Y103.676 E.00891
G1 X87.884 Y103.689 E.00891
M73 P44 R13
G1 X87.666 Y103.676 E.0043
G1 X87.215 Y103.608 E.00897
G1 X86.999 Y103.556 E.00437
G1 X86.787 Y103.491 E.00436
G1 X86.367 Y103.321 E.00891
G1 X85.973 Y103.103 E.00885
G1 X85.608 Y102.84 E.00885
G1 X85.277 Y102.536 E.00885
G1 X84.983 Y102.195 E.00885
G1 X84.733 Y101.821 E.00885
G1 X84.539 Y101.443 E.00835
G1 X84.445 Y101.214 E.00488
G1 X84.314 Y100.781 E.0089
G1 X84.236 Y100.338 E.00885
G1 X84.21 Y99.889 E.00885
G1 X84.238 Y99.44 E.00884
G1 X84.327 Y98.97 E.00942
G1 X84.454 Y98.564 E.00835
G1 X84.537 Y98.362 E.00431
G1 X84.745 Y97.96 E.00891
G1 X84.998 Y97.588 E.00885
G1 X85.565 Y96.936 E.01698
; WIPE_START
M204 S6000
G1 X83.565 Y96.914 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G17
G3 Z1.2 I1.217 J0 P1  F18000
;===================== date: 20250206 =====================

; don't support timelapse gcode in spiral_mode and by object sequence for I3 structure printer
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
G92 E0
G1 Z1.2
G1 X0 Y90 ; move to safe pos
G1 X-13.0 F3000 ; move to safe pos
M400
M1004 S5 P1  ; external shutter
M400 P300
M971 S11 C11 O0
G92 E0
G1 X0 F18000
M623

; SKIPTYPE: head_wrap_detect
M622.1 S1
M1002 judge_flag g39_3rd_layer_detect_flag
M622 J1
    ; enable nozzle clog detect at 3rd layer
    


    M622.1 S1
    M1002 judge_flag g39_detection_flag
    M622 J1
      
        M622.1 S0
        M1002 judge_flag g39_mass_exceed_flag
        M622 J1
        
            G392 S0
            M400
            G90
            M83
            M204 S5000
            G0 Z1.2 F4000
            G39.3 S1
            G0 Z1.2 F4000
            G392 S0
          
        M623
    
    M623
M623
; SKIPPABLE_END




G1 X81.444 Y96.248
G1 Z.8
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.141862
G1 F1500
M204 S6000
G1 X81.213 Y96.127 E.00151
G1 X81.109 Y96.052 E.00074
; LINE_WIDTH: 0.147251
G1 X80.946 Y95.849 E.00158
G1 X80.901 Y95.756 E.00063
; LINE_WIDTH: 0.0984226
G1 X80.862 Y95.617 E.00052
; WIPE_START
G1 X80.901 Y95.756 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X86.547 Y97.165 Z1.2 F18000
G1 Z.8
G1 E.4 F1800
; LINE_WIDTH: 0.477836
G1 F1500
M204 S6000
G1 X86.374 Y97.313 E.00514
; LINE_WIDTH: 0.441663
G1 X86.173 Y97.484 E.00547
; LINE_WIDTH: 0.403856
G1 X85.993 Y97.666 E.00483
; LINE_WIDTH: 0.3599
G1 X85.793 Y97.871 E.00477
G1 X85.465 Y98.299 E.009
G1 X85.228 Y98.762 E.00867
G1 X85.095 Y99.161 E.00701
G1 X85.024 Y99.539 E.00641
G1 X85.004 Y100.005 E.00779
G1 X85.067 Y100.522 E.00868
G1 X85.189 Y100.944 E.00733
G1 X85.419 Y101.42 E.0088
G1 X85.613 Y101.716 E.00591
G1 X85.939 Y102.078 E.00812
G1 X86.36 Y102.412 E.00897
G1 X86.811 Y102.651 E.00851
G1 X87.214 Y102.793 E.00712
G1 X87.364 Y102.833 E.0026
G1 X87.679 Y102.878 E.00529
G1 X88.047 Y102.898 E.00616
G1 X88.597 Y102.841 E.00921
G1 X89.087 Y102.695 E.00852
G1 X89.428 Y102.533 E.0063
G1 X89.727 Y102.349 E.00584
G1 X90.125 Y102.015 E.00867
G1 X90.391 Y101.707 E.00679
G1 X90.656 Y101.29 E.00822
G1 X90.805 Y100.951 E.00618
G1 X90.92 Y100.572 E.0066
G1 X90.991 Y100.081 E.00826
G1 X90.974 Y99.536 E.00909
G1 X90.869 Y99.027 E.00867
G1 X90.736 Y98.67 E.00636
G1 X90.481 Y98.215 E.00869
G1 X90.254 Y97.92 E.0062
G1 X90.004 Y97.66 E.00602
; LINE_WIDTH: 0.386713
G1 X89.88 Y97.544 E.00306
; LINE_WIDTH: 0.41443
G1 X89.737 Y97.412 E.00376
; LINE_WIDTH: 0.445102
G1 X89.564 Y97.27 E.00468
; LINE_WIDTH: 0.47428
G1 X89.391 Y97.127 E.00501
; WIPE_START
G1 X89.564 Y97.27 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X94.537 Y96.257 Z1.2 F18000
G1 Z.8
G1 E.4 F1800
; LINE_WIDTH: 0.148901
G1 F1500
M204 S6000
G1 X94.826 Y96.102 E.00201
G1 X95.135 Y95.786 E.00272
; WIPE_START
G1 X94.826 Y96.102 E-.21822
G1 X94.537 Y96.257 E-.16178
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X95.055 Y88.642 Z1.2 F18000
G1 X95.407 Y83.464 Z1.2
G1 Z.8
G1 E.4 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F1500
M204 S6000
G1 X95.406 Y84.394 E.01968
G1 X96.174 Y84.394 E.01624
G1 X95.907 Y83.627 E.01718
G1 X95.877 Y83.172 E.00966
G1 X96.157 Y82.717 E.01131
G1 X96.945 Y82.262 E.01926
G1 X97.628 Y81.807 E.01737
G1 X98.061 Y81.351 E.01331
G1 X98.342 Y80.896 E.01132
G1 X98.593 Y80.174 E.01618
G1 X98.594 Y79.208 E.02045
G1 X97.863 Y79.208 E.01547
; WIPE_START
G1 X98.594 Y79.208 E-.13884
G1 X98.593 Y80.174 E-.18359
G1 X98.494 Y80.46 E-.05757
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X95.142 Y77.444 Z1.2 F18000
G1 Z.8
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.144546
G1 F1500
M204 S6000
G1 X94.851 Y77.12 E.00258
G1 X94.781 Y77.066 E.00052
G1 X94.535 Y76.95 E.00161
; WIPE_START
G1 X94.781 Y77.066 E-.13004
G1 X94.851 Y77.12 E-.04211
G1 X95.142 Y77.444 E-.20785
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X87.515 Y77.171 Z1.2 F18000
G1 X81.503 Y76.955 Z1.2
G1 Z.8
G1 E.4 F1800
; LINE_WIDTH: 0.0894687
G1 F1500
M204 S6000
G1 X81.396 Y76.991 E.00036
; LINE_WIDTH: 0.128694
G1 X81.192 Y77.083 E.00115
; LINE_WIDTH: 0.153815
G1 X81.071 Y77.192 E.00104
G1 X80.935 Y77.369 E.00143
; LINE_WIDTH: 0.120607
G1 X80.894 Y77.487 E.00059
; LINE_WIDTH: 0.0908232
G1 X80.854 Y77.604 E.0004
; CHANGE_LAYER
; Z_HEIGHT: 0.92
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F1500
G1 X80.894 Y77.487 E-.38
; WIPE_END
G1 E-.02 F1800
; layer num/total_layer_count: 7/49
; update layer progress
M73 L7
M991 S0 P6 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z1.2 I-.907 J.812 P1  F18000
G1 X94.881 Y93.111 Z1.2
G1 Z.92
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X94.881 Y89.282 E.08105
G1 X99.119 Y89.282 E.08971
G1 X99.119 Y93.52 E.08971
G1 X94.881 Y93.52 E.08971
G1 X94.881 Y93.171 E.00739
M204 S250
G1 X95.29 Y93.111 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X95.29 Y89.691 E.06727
G1 X98.71 Y89.691 E.06727
G1 X98.71 Y93.111 E.06727
G1 X95.35 Y93.111 E.06609
; WIPE_START
M204 S6000
G1 X95.315 Y91.111 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X95.29 Y88.857 Z1.32 F18000
G1 Z.92
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X95.043 Y88.857 E.00522
G1 X95.043 Y88.445 E.00872
G1 X98.957 Y88.445 E.08282
G1 X98.957 Y88.857 E.00872
G1 X95.35 Y88.857 E.07634
; WIPE_START
M204 S6000
G1 X95.043 Y88.857 E-.05824
G1 X95.043 Y88.445 E-.07829
G1 X96.325 Y88.445 E-.24348
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X98.957 Y93.944 Z1.32 F18000
G1 Z.92
G1 E.4 F1800
G1 F1500
M204 S500
G1 X98.957 Y94.357 E.00872
G1 X95.043 Y94.358 E.08282
G1 X95.043 Y93.944 E.00875
G1 X98.897 Y93.944 E.08155
; WIPE_START
M204 S6000
G1 X98.957 Y94.357 E-.07914
G1 X97.373 Y94.357 E-.30086
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X90.129 Y96.759 Z1.32 F18000
G1 X89.159 Y97.081 Z1.32
G1 Z.92
G1 E.4 F1800
G1 F1500
M204 S500
G1 X88.766 Y96.954 E.00873
G1 X88.393 Y96.88 E.00805
G1 X87.879 Y96.857 E.0109
G1 X87.501 Y96.897 E.00804
G1 X87.131 Y96.981 E.00804
G1 X86.762 Y97.126 E.00839
G1 X86.647 Y96.963 E.00423
G1 X87.011 Y96.544 E.01174
G1 X88.922 Y96.544 E.04045
G1 X89.265 Y96.915 E.01069
G1 X89.191 Y97.031 E.00289
; WIPE_START
M204 S6000
G1 X88.766 Y96.954 E-.08201
G1 X88.393 Y96.88 E-.07224
G1 X87.879 Y96.857 E-.09782
G1 X87.501 Y96.897 E-.07219
G1 X87.215 Y96.962 E-.05574
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X90.617 Y99.845 Z1.32 F18000
G1 Z.92
G1 E.4 F1800
G1 F1500
M204 S500
G1 X90.622 Y99.901 E.00119
G1 X90.58 Y100.369 E.00995
G1 X90.457 Y100.813 E.00975
G1 X90.326 Y101.108 E.00683
G1 X90.16 Y101.385 E.00683
G1 X89.868 Y101.741 E.00975
G1 X89.516 Y102.039 E.00975
G1 X89.242 Y102.208 E.00681
G1 X88.967 Y102.336 E.00643
G1 X88.508 Y102.473 E.01013
G1 X88.039 Y102.522 E.00999
G1 X87.571 Y102.487 E.00994
G1 X87.114 Y102.369 E.00999
G1 X86.681 Y102.165 E.01013
G1 X86.428 Y101.997 E.00643
G1 X86.182 Y101.789 E.00681
G1 X85.879 Y101.442 E.00975
G1 X85.643 Y101.046 E.00975
G1 X85.52 Y100.748 E.00683
G1 X85.434 Y100.437 E.00683
G1 X85.379 Y99.979 E.00975
G1 X85.407 Y99.519 E.00975
G1 X85.474 Y99.204 E.00682
G1 X85.571 Y98.917 E.00643
G1 X85.79 Y98.491 E.01013
G1 X86.078 Y98.118 E.00998
G1 X86.427 Y97.803 E.00995
G1 X86.827 Y97.556 E.00995
G1 X87.256 Y97.388 E.00975
G1 X87.571 Y97.316 E.00683
G1 X87.892 Y97.282 E.00683
G1 X88.343 Y97.302 E.00955
G1 X88.659 Y97.365 E.00684
G1 X88.966 Y97.465 E.00683
G1 X89.378 Y97.671 E.00976
G1 X89.747 Y97.947 E.00975
G1 X89.973 Y98.177 E.00682
G1 X90.172 Y98.433 E.00687
G1 X90.398 Y98.844 E.00993
G1 X90.504 Y99.129 E.00644
G1 X90.58 Y99.442 E.00682
G1 X90.611 Y99.785 E.00728
M204 S250
G1 X90.209 Y99.881 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X90.211 Y99.901 E.00039
G1 X90.175 Y100.296 E.00779
G1 X90.071 Y100.675 E.00774
G1 X89.962 Y100.919 E.00526
G1 X89.825 Y101.149 E.00526
G1 X89.575 Y101.452 E.00773
G1 X89.275 Y101.707 E.00773
G1 X89.048 Y101.847 E.00526
G1 X88.821 Y101.953 E.00491
G1 X88.428 Y102.07 E.00807
G1 X88.033 Y102.111 E.00781
G1 X87.638 Y102.082 E.00779
G1 X87.254 Y101.982 E.00781
G1 X86.882 Y101.807 E.00807
G1 X86.674 Y101.669 E.00491
G1 X86.47 Y101.497 E.00525
G1 X86.211 Y101.2 E.00774
G1 X86.01 Y100.863 E.00773
G1 X85.908 Y100.615 E.00526
G1 X85.837 Y100.357 E.00526
G1 X85.79 Y99.967 E.00773
G1 X85.814 Y99.574 E.00774
G1 X85.869 Y99.313 E.00526
G1 X85.949 Y99.076 E.00491
G1 X86.137 Y98.711 E.00807
G1 X86.379 Y98.397 E.00781
G1 X86.674 Y98.132 E.0078
G1 X87.011 Y97.924 E.0078
G1 X87.377 Y97.78 E.00773
G1 X87.638 Y97.72 E.00526
G1 X87.904 Y97.692 E.00526
G1 X88.294 Y97.71 E.00767
G1 X88.556 Y97.762 E.00527
G1 X88.811 Y97.844 E.00526
G1 X89.162 Y98.02 E.00774
G1 X89.477 Y98.256 E.00773
G1 X89.664 Y98.447 E.00526
G1 X89.828 Y98.659 E.00527
G1 X90.025 Y99.015 E.00801
G1 X90.112 Y99.25 E.00491
G1 X90.176 Y99.509 E.00526
G1 X90.204 Y99.822 E.00617
; WIPE_START
M204 S6000
G1 X90.211 Y99.901 E-.01513
G1 X90.175 Y100.296 E-.07529
G1 X90.071 Y100.675 E-.07474
G1 X89.962 Y100.919 E-.05081
G1 X89.825 Y101.149 E-.05084
G1 X89.575 Y101.452 E-.07471
G1 X89.42 Y101.583 E-.03848
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X92.372 Y94.545 Z1.32 F18000
G1 X98.956 Y78.845 Z1.32
G1 Z.92
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X98.956 Y84.757 E.12513
G1 X95.044 Y84.756 E.0828
G1 X95.044 Y78.844 E.12514
G1 X98.896 Y78.845 E.08153
; WIPE_START
M204 S6000
G1 X98.916 Y80.845 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X94.164 Y86.817 Z1.32 F18000
G1 X86.761 Y96.12 Z1.32
G1 Z.92
G1 E.4 F1800
G1 F1500
M204 S500
G1 X94.064 Y96.12 E.15458
G1 X94.388 Y96.052 E.00699
G1 X94.618 Y95.916 E.00566
G1 X95.29 Y95.274 E.01968
G1 X94.619 Y94.784 E.01758
G1 X94.619 Y88.021 E.14315
G1 X99.381 Y88.021 E.10078
G1 X99.381 Y94.781 E.14307
G1 X95.386 Y94.782 E.08455
G1 X95.379 Y95.64 E.01817
G1 X95.355 Y95.803 E.00349
G1 X95.307 Y95.949 E.00324
G1 X95.234 Y96.084 E.00324
G1 X95.144 Y96.197 E.00307
G1 X94.983 Y96.334 E.00446
G1 X94.846 Y96.408 E.00329
G1 X94.711 Y96.453 E.00301
G1 X94.464 Y96.482 E.00527
G1 X89.441 Y96.482 E.1063
G1 X90.544 Y97.675 E.03439
G1 X90.8 Y98.008 E.00888
G1 X91.074 Y98.497 E.01187
G1 X91.229 Y98.903 E.0092
G1 X91.355 Y99.49 E.01269
G1 X91.374 Y100.1 E.01292
G1 X91.294 Y100.655 E.01187
G1 X91.168 Y101.08 E.00939
G1 X90.913 Y101.614 E.01251
G1 X90.569 Y102.098 E.01257
G1 X90.285 Y102.391 E.00864
G1 X89.967 Y102.65 E.00869
G1 X89.476 Y102.941 E.01207
G1 X89.278 Y103.03 E.00458
G1 X88.914 Y103.154 E.00816
G1 X88.704 Y103.207 E.00456
G1 X88.292 Y103.269 E.00883
G1 X87.692 Y103.267 E.01269
G1 X87.108 Y103.161 E.01257
G1 X86.719 Y103.029 E.0087
G1 X86.192 Y102.757 E.01254
G1 X85.867 Y102.522 E.00849
G1 X85.571 Y102.251 E.00849
G1 X85.31 Y101.946 E.0085
G1 X85.086 Y101.613 E.00849
G1 X84.831 Y101.078 E.01255
G1 X84.721 Y100.716 E.00801
G1 X84.643 Y100.289 E.00919
G1 X84.62 Y99.89 E.00845
G1 X84.645 Y99.49 E.00849
G1 X84.718 Y99.095 E.0085
G1 X84.909 Y98.533 E.01255
G1 X85.082 Y98.197 E.00801
G1 X85.324 Y97.836 E.00919
G1 X86.503 Y96.482 E.03801
G1 X81.536 Y96.482 E.10513
G1 X81.289 Y96.453 E.00527
G1 X81.143 Y96.405 E.00324
G1 X80.884 Y96.226 E.00667
G1 X80.739 Y96.042 E.00495
G1 X80.648 Y95.813 E.00522
G1 X80.619 Y95.565 E.00529
G1 X80.619 Y77.619 E.37984
G1 X80.659 Y77.349 E.00577
G1 X80.761 Y77.125 E.0052
G1 X80.862 Y76.997 E.00345
G1 X80.975 Y76.896 E.00321
G1 X81.2 Y76.775 E.0054
G1 X81.449 Y76.723 E.0054
G1 X94.475 Y76.72 E.27572
G1 X94.701 Y76.748 E.00481
G1 X94.9 Y76.82 E.00449
G1 X95.025 Y76.898 E.0031
G1 X95.178 Y77.043 E.00447
G1 X95.256 Y77.154 E.00288
G1 X95.343 Y77.358 E.00469
G1 X95.372 Y77.498 E.00304
G1 X95.397 Y78.42 E.01951
G1 X99.381 Y78.421 E.08431
G1 X99.38 Y85.182 E.14309
G1 X94.619 Y85.181 E.10076
G1 X94.62 Y78.417 E.14317
G1 X95.29 Y77.928 E.01755
G1 X94.618 Y77.285 E.01968
G1 X94.388 Y77.15 E.00567
G1 X94.064 Y77.082 E.00699
G1 X81.946 Y77.082 E.25649
G1 X81.657 Y77.132 E.0062
G1 X81.388 Y77.278 E.00649
G1 X81.171 Y77.495 E.00649
G1 X81.019 Y77.797 E.00717
G1 X80.981 Y78.056 E.00553
G1 X80.981 Y95.146 E.36172
G1 X81.017 Y95.395 E.00533
G1 X81.14 Y95.658 E.00613
G1 X81.308 Y95.856 E.00551
G1 X81.564 Y96.034 E.00659
G1 X81.928 Y96.12 E.00792
G1 X86.701 Y96.12 E.10103
; WIPE_START
M204 S6000
G1 X88.701 Y96.12 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X85.605 Y96.891 Z1.32 F18000
G1 Z.92
M73 P45 R13
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X81.512 Y96.891 E.08049
G1 X81.2 Y96.854 E.00619
G1 X80.986 Y96.784 E.00442
G1 X80.861 Y96.721 E.00276
G1 X80.605 Y96.528 E.0063
G1 X80.464 Y96.369 E.00418
G1 X80.384 Y96.246 E.00288
G1 X80.313 Y96.104 E.00313
G1 X80.247 Y95.901 E.00419
G1 X80.21 Y95.589 E.00619
G1 X80.21 Y77.607 E.35368
G1 X80.219 Y77.454 E.00301
G1 X80.265 Y77.231 E.00448
G1 X80.349 Y77.019 E.00448
G1 X80.421 Y76.895 E.00283
G1 X80.562 Y76.716 E.00448
G1 X80.723 Y76.572 E.00425
G1 X80.853 Y76.485 E.00307
G1 X81.059 Y76.389 E.00447
G1 X81.279 Y76.33 E.00448
G1 X81.425 Y76.313 E.00289
G1 X94.5 Y76.311 E.25717
G1 X94.797 Y76.347 E.00588
G1 X95.081 Y76.45 E.00594
G1 X95.276 Y76.572 E.00453
G1 X95.489 Y76.774 E.00577
G1 X95.615 Y76.954 E.0043
G1 X95.736 Y77.234 E.00601
G1 X95.78 Y77.451 E.00436
G1 X95.796 Y78.011 E.01101
G1 X99.417 Y78.012 E.07122
G1 X99.508 Y78.028 E.00183
G1 X99.613 Y78.077 E.00227
G1 X99.699 Y78.154 E.00227
G1 X99.747 Y78.226 E.00171
G1 X99.79 Y78.413 E.00377
G1 X99.789 Y85.216 E.1338
G1 X99.769 Y85.322 E.00213
G1 X99.724 Y85.416 E.00204
G1 X99.669 Y85.481 E.00168
G1 X99.572 Y85.549 E.00233
G1 X99.388 Y85.591 E.00371
G1 X94.583 Y85.59 E.09449
G1 X94.406 Y85.537 E.00364
G1 X94.277 Y85.417 E.00347
G1 X94.229 Y85.312 E.00227
G1 X94.21 Y85.186 E.00252
G1 X94.211 Y78.385 E.13377
G1 X94.227 Y78.293 E.00182
G1 X94.276 Y78.187 E.00231
G1 X94.33 Y78.122 E.00166
G1 X94.654 Y77.886 E.00789
G1 X94.37 Y77.614 E.00773
G1 X94.238 Y77.536 E.00301
G1 X94.022 Y77.491 E.00434
G1 X81.982 Y77.491 E.23682
G1 X81.793 Y77.524 E.00376
G1 X81.634 Y77.61 E.00355
G1 X81.507 Y77.737 E.00355
G1 X81.414 Y77.922 E.00407
G1 X81.39 Y78.086 E.00325
G1 X81.39 Y95.116 E.33497
G1 X81.413 Y95.277 E.00319
G1 X81.487 Y95.435 E.00344
G1 X81.586 Y95.551 E.00299
G1 X81.733 Y95.654 E.00354
G1 X81.976 Y95.711 E.00489
G1 X94.022 Y95.711 E.23694
G1 X94.238 Y95.666 E.00434
G1 X94.37 Y95.588 E.00301
G1 X94.654 Y95.316 E.00773
G1 X94.33 Y95.08 E.00789
G1 X94.276 Y95.015 E.00166
G1 X94.228 Y94.911 E.00225
G1 X94.21 Y94.786 E.00249
G1 X94.21 Y88.018 E.13312
G1 X94.232 Y87.88 E.00275
G1 X94.292 Y87.765 E.00254
G1 X94.426 Y87.654 E.00343
G1 X94.58 Y87.612 E.00315
G1 X99.41 Y87.612 E.095
G1 X99.556 Y87.646 E.00295
G1 X99.649 Y87.704 E.00215
G1 X99.722 Y87.785 E.00215
G1 X99.779 Y87.917 E.00283
G1 X99.79 Y94.782 E.13503
G1 X99.763 Y94.933 E.00301
G1 X99.693 Y95.055 E.00276
G1 X99.577 Y95.147 E.00291
G1 X99.42 Y95.19 E.00321
G1 X95.792 Y95.191 E.07135
G1 X95.788 Y95.672 E.00946
G1 X95.754 Y95.898 E.0045
G1 X95.684 Y96.112 E.00442
G1 X95.577 Y96.309 E.00442
G1 X95.439 Y96.484 E.00437
G1 X95.215 Y96.673 E.00577
G1 X95.01 Y96.785 E.0046
G1 X94.8 Y96.854 E.00435
G1 X94.488 Y96.891 E.00619
G1 X90.377 Y96.891 E.08086
G1 X90.857 Y97.411 E.01392
G1 X91.136 Y97.772 E.00897
G1 X91.253 Y97.957 E.00431
G1 X91.447 Y98.329 E.00825
G1 X91.62 Y98.781 E.00951
G1 X91.728 Y99.22 E.0089
G1 X91.782 Y99.661 E.00873
G1 X91.784 Y100.117 E.00897
G1 X91.765 Y100.335 E.00431
G1 X91.693 Y100.748 E.00825
G1 X91.555 Y101.215 E.00958
G1 X91.473 Y101.417 E.00429
G1 X91.267 Y101.821 E.00892
G1 X91.034 Y102.171 E.00826
G1 X90.877 Y102.368 E.00497
G1 X90.562 Y102.693 E.0089
G1 X90.211 Y102.979 E.00891
G1 X90.029 Y103.102 E.00431
G1 X89.66 Y103.307 E.00831
G1 X89.429 Y103.411 E.00498
G1 X89.03 Y103.547 E.0083
G1 X88.784 Y103.609 E.00497
G1 X88.334 Y103.676 E.00895
G1 X88.116 Y103.689 E.00431
G1 X87.66 Y103.675 E.00896
G1 X87.41 Y103.644 E.00497
G1 X86.999 Y103.556 E.00826
G1 X86.57 Y103.411 E.00891
G1 X86.37 Y103.322 E.00431
G1 X85.973 Y103.103 E.00891
G1 X85.608 Y102.84 E.00885
G1 X85.277 Y102.536 E.00885
G1 X84.983 Y102.195 E.00885
G1 X84.733 Y101.821 E.00885
G1 X84.527 Y101.418 E.00891
G1 X84.445 Y101.214 E.00431
G1 X84.323 Y100.813 E.00826
G1 X84.236 Y100.337 E.00951
G1 X84.21 Y99.889 E.00884
G1 X84.239 Y99.44 E.00885
G1 X84.32 Y98.997 E.00885
G1 X84.454 Y98.564 E.00891
G1 X84.537 Y98.362 E.00431
G1 X84.729 Y97.989 E.00825
G1 X84.999 Y97.587 E.00951
G1 X85.565 Y96.936 E.01697
; WIPE_START
M204 S6000
G1 X83.565 Y96.914 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G17
G3 Z1.32 I1.217 J0 P1  F18000
;===================== date: 20250206 =====================

; don't support timelapse gcode in spiral_mode and by object sequence for I3 structure printer
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
G92 E0
G1 Z1.32
G1 X0 Y90 ; move to safe pos
G1 X-13.0 F3000 ; move to safe pos
M400
M1004 S5 P1  ; external shutter
M400 P300
M971 S11 C11 O0
G92 E0
G1 X0 F18000
M623

; SKIPTYPE: head_wrap_detect
M622.1 S1
M1002 judge_flag g39_3rd_layer_detect_flag
M622 J1
    ; enable nozzle clog detect at 3rd layer
    


    M622.1 S1
    M1002 judge_flag g39_detection_flag
    M622 J1
      
        M622.1 S0
        M1002 judge_flag g39_mass_exceed_flag
        M622 J1
        
            G392 S0
            M400
            G90
            M83
            M204 S5000
            G0 Z1.32 F4000
            G39.3 S1
            G0 Z1.32 F4000
            G392 S0
          
        M623
    
    M623
M623
; SKIPPABLE_END




G1 X81.449 Y96.237
G1 Z.92
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.095108
G1 F1500
M204 S6000
G1 X81.35 Y96.194 E.00037
; LINE_WIDTH: 0.14228
G1 X81.251 Y96.15 E.00063
G1 X81.117 Y96.055 E.00096
; LINE_WIDTH: 0.150452
G1 X81.016 Y95.949 E.00091
G1 X80.901 Y95.757 E.00139
; LINE_WIDTH: 0.0986185
G1 X80.862 Y95.617 E.00053
; WIPE_START
G1 X80.901 Y95.757 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X86.536 Y97.174 Z1.32 F18000
G1 Z.92
G1 E.4 F1800
; LINE_WIDTH: 0.473057
G1 F1500
M204 S6000
G1 X86.365 Y97.318 E.00499
; LINE_WIDTH: 0.438118
G1 X86.169 Y97.487 E.00533
; LINE_WIDTH: 0.401727
G1 X85.99 Y97.669 E.00477
; LINE_WIDTH: 0.359733
G1 X85.792 Y97.872 E.00473
G1 X85.464 Y98.302 E.00901
G1 X85.219 Y98.781 E.00896
G1 X85.088 Y99.186 E.00709
G1 X85.024 Y99.536 E.00593
G1 X85.004 Y100.005 E.00783
G1 X85.068 Y100.521 E.00867
G1 X85.19 Y100.946 E.00736
G1 X85.419 Y101.42 E.00878
G1 X85.613 Y101.716 E.00589
G1 X85.927 Y102.066 E.00783
G1 X86.108 Y102.226 E.00403
G1 X86.397 Y102.434 E.00593
G1 X86.718 Y102.608 E.00609
G1 X87.21 Y102.79 E.00874
G1 X87.524 Y102.858 E.00535
G1 X88.03 Y102.896 E.00846
G1 X88.597 Y102.841 E.00949
G1 X89.09 Y102.694 E.00856
G1 X89.428 Y102.532 E.00625
G1 X89.727 Y102.349 E.00584
G1 X90.125 Y102.015 E.00866
G1 X90.394 Y101.703 E.00686
G1 X90.656 Y101.29 E.00815
G1 X90.805 Y100.951 E.00618
G1 X90.921 Y100.568 E.00667
G1 X90.991 Y100.081 E.00819
G1 X90.974 Y99.536 E.00908
G1 X90.869 Y99.027 E.00866
G1 X90.737 Y98.676 E.00626
G1 X90.569 Y98.359 E.00597
G1 X90.253 Y97.919 E.00903
G1 X89.992 Y97.647 E.00628
; LINE_WIDTH: 0.397587
G1 X89.807 Y97.48 E.00462
; LINE_WIDTH: 0.44273
G1 X89.622 Y97.314 E.00518
; LINE_WIDTH: 0.480574
G1 X89.38 Y97.129 E.00691
; WIPE_START
G1 X89.622 Y97.314 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X94.537 Y96.257 Z1.32 F18000
G1 Z.92
G1 E.4 F1800
; LINE_WIDTH: 0.148855
G1 F1500
M204 S6000
G1 X94.827 Y96.101 E.00202
G1 X95.135 Y95.786 E.00271
; WIPE_START
G1 X94.827 Y96.101 E-.21766
G1 X94.537 Y96.257 E-.16234
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X96.595 Y88.907 Z1.32 F18000
G1 X97.858 Y84.394 Z1.32
G1 Z.92
G1 E.4 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F1500
M204 S6000
G1 X96.161 Y84.394 E.03592
G1 X95.918 Y84.033 E.00922
G1 X95.462 Y82.927 E.0253
G1 X95.407 Y82.923 E.00118
G1 X95.407 Y82.371 E.01167
G1 X95.462 Y82.506 E.00309
G1 X95.918 Y82.543 E.00967
G1 X96.373 Y82.4 E.0101
G1 X97.283 Y81.999 E.02106
G1 X97.738 Y81.686 E.01169
G1 X98.194 Y81.203 E.01405
G1 X98.593 Y80.49 E.01731
G1 X98.594 Y79.208 E.02713
G1 X98.178 Y79.208 E.00879
; WIPE_START
G1 X98.594 Y79.208 E-.07888
G1 X98.593 Y80.49 E-.24355
G1 X98.445 Y80.754 E-.05757
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X95.145 Y77.438 Z1.32 F18000
G1 Z.92
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.148151
G1 F1500
M204 S6000
G1 X94.852 Y77.121 E.00264
G1 X94.781 Y77.066 E.00055
G1 X94.534 Y76.95 E.00166
; WIPE_START
G1 X94.781 Y77.066 E-.13032
G1 X94.852 Y77.121 E-.04293
G1 X95.145 Y77.438 E-.20675
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X87.517 Y77.168 Z1.32 F18000
G1 X81.496 Y76.955 Z1.32
G1 Z.92
G1 E.4 F1800
; LINE_WIDTH: 0.0897733
G1 F1500
M204 S6000
G1 X81.393 Y76.991 E.00035
; LINE_WIDTH: 0.130213
G1 X81.192 Y77.083 E.00115
; LINE_WIDTH: 0.152768
G1 X80.962 Y77.32 E.00209
G1 X80.912 Y77.424 E.00073
; LINE_WIDTH: 0.115101
G1 X80.883 Y77.514 E.00042
; LINE_WIDTH: 0.0897529
G1 X80.854 Y77.604 E.0003
; CHANGE_LAYER
; Z_HEIGHT: 1.04
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F1500
G1 X80.883 Y77.514 E-.38
; WIPE_END
G1 E-.02 F1800
; layer num/total_layer_count: 8/49
; update layer progress
M73 L8
M991 S0 P7 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z1.32 I-.906 J.813 P1  F18000
G1 X94.881 Y93.111 Z1.32
G1 Z1.04
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X94.881 Y89.282 E.08105
G1 X99.119 Y89.282 E.08971
G1 X99.119 Y93.52 E.08971
G1 X94.881 Y93.52 E.08971
G1 X94.881 Y93.171 E.00739
M204 S250
G1 X95.29 Y93.111 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X95.29 Y89.691 E.06727
G1 X98.71 Y89.691 E.06727
G1 X98.71 Y93.111 E.06727
G1 X95.35 Y93.111 E.06609
; WIPE_START
M204 S6000
G1 X95.315 Y91.111 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X95.29 Y88.857 Z1.44 F18000
G1 Z1.04
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X95.043 Y88.857 E.00522
G1 X95.043 Y88.445 E.00872
G1 X98.957 Y88.445 E.08282
G1 X98.957 Y88.857 E.00872
G1 X95.35 Y88.857 E.07634
; WIPE_START
M204 S6000
G1 X95.043 Y88.857 E-.05824
G1 X95.043 Y88.445 E-.07829
M73 P46 R13
G1 X96.325 Y88.445 E-.24348
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X98.957 Y93.944 Z1.44 F18000
G1 Z1.04
G1 E.4 F1800
G1 F1500
M204 S500
G1 X98.957 Y94.357 E.00872
G1 X95.043 Y94.358 E.08282
G1 X95.043 Y93.944 E.00875
G1 X98.897 Y93.944 E.08155
; WIPE_START
M204 S6000
G1 X98.957 Y94.357 E-.07914
G1 X97.373 Y94.357 E-.30086
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X90.129 Y96.76 Z1.44 F18000
G1 X89.159 Y97.081 Z1.44
G1 Z1.04
G1 E.4 F1800
G1 F1500
M204 S500
G1 X88.766 Y96.953 E.00874
G1 X88.393 Y96.88 E.00804
G1 X87.863 Y96.856 E.01123
G1 X87.322 Y96.93 E.01157
G1 X86.766 Y97.11 E.01237
G1 X86.659 Y96.949 E.0041
G1 X87.011 Y96.544 E.01135
G1 X88.922 Y96.544 E.04046
G1 X89.265 Y96.916 E.0107
G1 X89.191 Y97.031 E.00289
; WIPE_START
M204 S6000
G1 X88.766 Y96.953 E-.0821
G1 X88.393 Y96.88 E-.07221
G1 X87.863 Y96.856 E-.1008
G1 X87.322 Y96.93 E-.10386
G1 X87.216 Y96.964 E-.02103
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X90.617 Y99.844 Z1.44 F18000
G1 Z1.04
G1 E.4 F1800
G1 F1500
M204 S500
G1 X90.622 Y99.903 E.00124
G1 X90.576 Y100.382 E.01018
G1 X90.504 Y100.674 E.00637
G1 X90.391 Y100.975 E.00682
G1 X90.166 Y101.378 E.00975
G1 X89.868 Y101.741 E.00995
G1 X89.516 Y102.039 E.00975
G1 X89.242 Y102.208 E.00681
G1 X88.969 Y102.335 E.00638
G1 X88.509 Y102.473 E.01018
G1 X88.048 Y102.521 E.00979
G1 X87.726 Y102.507 E.00683
G1 X87.408 Y102.454 E.00683
G1 X86.97 Y102.312 E.00975
G1 X86.556 Y102.089 E.00995
G1 X86.195 Y101.802 E.00976
G1 X85.977 Y101.566 E.00681
G1 X85.799 Y101.322 E.00638
G1 X85.575 Y100.897 E.01018
G1 X85.436 Y100.446 E.00999
G1 X85.379 Y99.979 E.00995
G1 X85.407 Y99.519 E.00975
G1 X85.474 Y99.204 E.00681
G1 X85.571 Y98.919 E.00637
G1 X85.789 Y98.491 E.01018
G1 X86.079 Y98.116 E.01003
G1 X86.439 Y97.797 E.01018
G1 X86.69 Y97.631 E.00637
G1 X86.979 Y97.487 E.00682
G1 X87.416 Y97.345 E.00975
G1 X87.882 Y97.282 E.00995
G1 X88.343 Y97.302 E.00975
G1 X88.659 Y97.365 E.00683
G1 X88.957 Y97.462 E.00663
G1 X89.242 Y97.593 E.00664
G1 X89.516 Y97.763 E.00683
G1 X89.868 Y98.061 E.00975
G1 X90.167 Y98.426 E.00999
G1 X90.399 Y98.847 E.01018
G1 X90.504 Y99.129 E.00638
G1 X90.58 Y99.442 E.00681
G1 X90.611 Y99.785 E.00728
M204 S250
G1 X90.209 Y99.881 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X90.211 Y99.902 E.00041
G1 X90.171 Y100.313 E.00812
G1 X90.112 Y100.553 E.00486
G1 X90.018 Y100.803 E.00526
G1 X89.827 Y101.146 E.00773
G1 X89.575 Y101.452 E.0078
G1 X89.275 Y101.707 E.00773
G1 X89.048 Y101.847 E.00526
G1 X88.824 Y101.952 E.00486
G1 X88.428 Y102.07 E.00812
G1 X88.036 Y102.111 E.00775
G1 X87.769 Y102.099 E.00526
G1 X87.505 Y102.055 E.00527
G1 X87.131 Y101.934 E.00773
G1 X86.782 Y101.746 E.00779
G1 X86.475 Y101.501 E.00774
G1 X86.293 Y101.305 E.00526
G1 X86.147 Y101.105 E.00487
G1 X85.954 Y100.74 E.00812
G1 X85.837 Y100.361 E.00781
G1 X85.79 Y99.967 E.0078
G1 X85.814 Y99.574 E.00774
G1 X85.869 Y99.313 E.00526
G1 X85.949 Y99.079 E.00486
G1 X86.136 Y98.711 E.00812
G1 X86.38 Y98.397 E.00782
G1 X86.688 Y98.122 E.00812
G1 X86.895 Y97.987 E.00486
G1 X87.134 Y97.867 E.00526
G1 X87.508 Y97.746 E.00773
G1 X87.901 Y97.692 E.0078
G1 X88.294 Y97.71 E.00773
G1 X88.556 Y97.762 E.00526
G1 X88.808 Y97.843 E.0052
G1 X89.047 Y97.954 E.0052
G1 X89.275 Y98.095 E.00526
G1 X89.575 Y98.349 E.00773
G1 X89.827 Y98.656 E.00781
G1 X90.026 Y99.018 E.00812
G1 X90.112 Y99.25 E.00487
G1 X90.176 Y99.509 E.00526
G1 X90.204 Y99.821 E.00616
; WIPE_START
M204 S6000
G1 X90.211 Y99.902 E-.01532
G1 X90.171 Y100.313 E-.07845
G1 X90.112 Y100.553 E-.04697
G1 X90.018 Y100.803 E-.05079
G1 X89.827 Y101.146 E-.07471
G1 X89.575 Y101.452 E-.07531
G1 X89.421 Y101.583 E-.03843
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X92.372 Y94.545 Z1.44 F18000
G1 X98.956 Y78.845 Z1.44
G1 Z1.04
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X98.956 Y84.757 E.12513
G1 X95.044 Y84.756 E.0828
G1 X95.044 Y78.844 E.12514
G1 X98.896 Y78.845 E.08153
; WIPE_START
M204 S6000
G1 X98.916 Y80.845 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X94.164 Y86.817 Z1.44 F18000
G1 X86.761 Y96.12 Z1.44
G1 Z1.04
G1 E.4 F1800
G1 F1500
M204 S500
G1 X94.064 Y96.12 E.15458
G1 X94.387 Y96.052 E.00699
G1 X94.618 Y95.916 E.00567
G1 X95.29 Y95.274 E.01967
G1 X94.619 Y94.784 E.01757
G1 X94.619 Y88.021 E.14315
G1 X99.381 Y88.021 E.10078
G1 X99.381 Y94.781 E.14307
G1 X95.386 Y94.782 E.08455
G1 X95.379 Y95.64 E.01817
G1 X95.355 Y95.803 E.00349
G1 X95.307 Y95.949 E.00324
G1 X95.234 Y96.084 E.00324
G1 X95.139 Y96.204 E.00324
G1 X95.025 Y96.305 E.00324
G1 X94.902 Y96.381 E.00305
G1 X94.702 Y96.454 E.0045
G1 X94.464 Y96.482 E.00508
G1 X89.442 Y96.482 E.1063
G1 X90.544 Y97.675 E.03439
G1 X90.8 Y98.008 E.00888
G1 X91.072 Y98.493 E.01178
G1 X91.229 Y98.903 E.00929
G1 X91.355 Y99.49 E.01269
G1 X91.374 Y100.1 E.01292
G1 X91.295 Y100.651 E.01178
G1 X91.168 Y101.081 E.00949
G1 X90.913 Y101.614 E.01251
G1 X90.569 Y102.098 E.01258
G1 X90.285 Y102.391 E.00863
G1 X89.967 Y102.65 E.00869
G1 X89.48 Y102.939 E.01199
M73 P46 R12
G1 X89.278 Y103.03 E.00468
G1 X88.918 Y103.153 E.00806
G1 X88.704 Y103.207 E.00467
G1 X88.292 Y103.269 E.00882
G1 X87.699 Y103.267 E.01254
G1 X87.107 Y103.161 E.01273
G1 X86.576 Y102.965 E.01197
G1 X86.191 Y102.755 E.00929
G1 X85.867 Y102.522 E.00845
G1 X85.571 Y102.251 E.00849
G1 X85.31 Y101.946 E.0085
G1 X85.086 Y101.613 E.00849
G1 X84.831 Y101.078 E.01255
G1 X84.722 Y100.72 E.00791
G1 X84.643 Y100.288 E.00929
G1 X84.62 Y99.89 E.00845
G1 X84.645 Y99.49 E.00849
G1 X84.718 Y99.095 E.0085
G1 X84.909 Y98.533 E.01255
G1 X85.08 Y98.201 E.00791
G1 X85.324 Y97.836 E.0093
G1 X86.503 Y96.482 E.038
G1 X81.536 Y96.482 E.10513
G1 X81.28 Y96.452 E.00547
G1 X81.071 Y96.366 E.00478
G1 X80.883 Y96.225 E.00497
G1 X80.79 Y96.119 E.00298
G1 X80.649 Y95.821 E.00698
G1 X80.619 Y95.565 E.00546
G1 X80.619 Y77.619 E.37984
G1 X80.659 Y77.349 E.00577
G1 X80.715 Y77.206 E.00326
G1 X80.794 Y77.078 E.00317
G1 X80.982 Y76.89 E.00563
G1 X81.201 Y76.775 E.00522
G1 X81.451 Y76.723 E.00541
G1 X94.477 Y76.721 E.27571
G1 X94.701 Y76.748 E.00478
G1 X94.902 Y76.821 E.00452
G1 X95.017 Y76.892 E.00286
G1 X95.172 Y77.038 E.00452
G1 X95.283 Y77.205 E.00424
G1 X95.342 Y77.351 E.00332
G1 X95.372 Y77.498 E.00319
G1 X95.397 Y78.42 E.01952
G1 X99.381 Y78.421 E.08431
G1 X99.38 Y85.182 E.14309
G1 X94.619 Y85.181 E.10076
G1 X94.62 Y78.417 E.14317
G1 X95.29 Y77.929 E.01753
G1 X94.618 Y77.285 E.01967
G1 X94.387 Y77.149 E.00568
G1 X94.064 Y77.082 E.00699
G1 X81.946 Y77.082 E.2565
G1 X81.657 Y77.133 E.00621
G1 X81.386 Y77.279 E.00652
G1 X81.167 Y77.5 E.0066
G1 X81.018 Y77.799 E.00706
G1 X80.981 Y78.056 E.00549
G1 X80.981 Y95.146 E.36173
G1 X81.016 Y95.388 E.00517
G1 X81.121 Y95.627 E.00552
G1 X81.297 Y95.848 E.00599
G1 X81.563 Y96.034 E.00686
G1 X81.928 Y96.12 E.00794
G1 X86.701 Y96.12 E.10103
; WIPE_START
M204 S6000
G1 X88.701 Y96.12 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X85.604 Y96.891 Z1.44 F18000
G1 Z1.04
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X81.512 Y96.891 E.08049
G1 X81.197 Y96.854 E.00625
G1 X81.062 Y96.814 E.00277
G1 X80.859 Y96.719 E.00441
G1 X80.604 Y96.527 E.00628
G1 X80.464 Y96.369 E.00415
G1 X80.385 Y96.248 E.00284
G1 X80.287 Y96.039 E.00454
G1 X80.247 Y95.904 E.00277
G1 X80.21 Y95.589 E.00625
G1 X80.21 Y77.607 E.35368
G1 X80.219 Y77.454 E.00301
G1 X80.265 Y77.231 E.00448
G1 X80.348 Y77.022 E.00443
G1 X80.46 Y76.839 E.00421
G1 X80.56 Y76.718 E.0031
G1 X80.732 Y76.565 E.00453
G1 X80.853 Y76.486 E.00283
G1 X81.059 Y76.389 E.00449
G1 X81.266 Y76.333 E.00421
G1 X81.426 Y76.313 E.00316
G1 X94.502 Y76.311 E.25719
G1 X94.797 Y76.347 E.00585
G1 X95.081 Y76.45 E.00595
G1 X95.267 Y76.565 E.0043
G1 X95.487 Y76.773 E.00595
G1 X95.647 Y77.014 E.00568
G1 X95.735 Y77.232 E.00463
G1 X95.78 Y77.451 E.0044
G1 X95.796 Y78.011 E.01102
G1 X99.417 Y78.012 E.07122
G1 X99.508 Y78.028 E.00184
G1 X99.613 Y78.077 E.00227
G1 X99.699 Y78.154 E.00227
G1 X99.747 Y78.226 E.00171
G1 X99.79 Y78.413 E.00377
G1 X99.789 Y85.216 E.1338
G1 X99.768 Y85.324 E.00218
G1 X99.724 Y85.416 E.002
G1 X99.669 Y85.481 E.00168
G1 X99.572 Y85.549 E.00233
G1 X99.388 Y85.591 E.00371
G1 X94.584 Y85.59 E.09449
G1 X94.406 Y85.537 E.00365
G1 X94.277 Y85.417 E.00346
G1 X94.229 Y85.312 E.00227
G1 X94.21 Y85.186 E.00252
G1 X94.211 Y78.385 E.13377
G1 X94.227 Y78.293 E.00182
G1 X94.276 Y78.187 E.00231
G1 X94.33 Y78.122 E.00166
G1 X94.654 Y77.886 E.00788
G1 X94.37 Y77.614 E.00773
G1 X94.238 Y77.536 E.00302
G1 X94.022 Y77.491 E.00434
G1 X81.982 Y77.491 E.23682
G1 X81.793 Y77.524 E.00376
G1 X81.634 Y77.61 E.00356
G1 X81.504 Y77.741 E.00363
G1 X81.414 Y77.923 E.00398
G1 X81.39 Y78.086 E.00324
G1 X81.39 Y95.116 E.33498
G1 X81.413 Y95.274 E.00314
G1 X81.474 Y95.414 E.003
M73 P47 R12
G1 X81.58 Y95.547 E.00335
G1 X81.733 Y95.653 E.00367
G1 X81.975 Y95.711 E.0049
G1 X94.022 Y95.711 E.23694
G1 X94.238 Y95.666 E.00434
G1 X94.37 Y95.588 E.00302
G1 X94.654 Y95.316 E.00773
G1 X94.331 Y95.081 E.00785
G1 X94.269 Y95.004 E.00194
G1 X94.228 Y94.912 E.00197
G1 X94.21 Y94.786 E.00251
G1 X94.21 Y88.018 E.13312
G1 X94.233 Y87.878 E.00279
G1 X94.292 Y87.765 E.00249
G1 X94.428 Y87.652 E.00349
G1 X94.583 Y87.612 E.00316
G1 X99.41 Y87.612 E.09494
G1 X99.556 Y87.646 E.00295
G1 X99.647 Y87.702 E.00209
G1 X99.737 Y87.81 E.00276
G1 X99.778 Y87.914 E.00221
G1 X99.79 Y94.782 E.13509
G1 X99.763 Y94.933 E.00301
G1 X99.692 Y95.056 E.00279
G1 X99.573 Y95.149 E.00298
G1 X99.416 Y95.19 E.00318
G1 X95.792 Y95.191 E.07129
G1 X95.788 Y95.672 E.00946
G1 X95.754 Y95.898 E.0045
G1 X95.684 Y96.112 E.00442
G1 X95.577 Y96.309 E.00442
G1 X95.438 Y96.486 E.00442
G1 X95.27 Y96.635 E.00442
G1 X95.081 Y96.751 E.00436
G1 X94.797 Y96.855 E.00594
G1 X94.488 Y96.891 E.00613
G1 X90.377 Y96.891 E.08086
G1 X90.857 Y97.411 E.01393
G1 X91.136 Y97.772 E.00897
G1 X91.253 Y97.957 E.00431
G1 X91.445 Y98.325 E.00816
G1 X91.62 Y98.781 E.0096
G1 X91.728 Y99.22 E.00889
G1 X91.782 Y99.661 E.00873
G1 X91.784 Y100.117 E.00897
G1 X91.765 Y100.335 E.00431
G1 X91.694 Y100.744 E.00816
G1 X91.555 Y101.215 E.00967
G1 X91.473 Y101.417 E.00429
G1 X91.267 Y101.821 E.00892
G1 X91.037 Y102.167 E.00817
G1 X90.877 Y102.368 E.00506
G1 X90.562 Y102.693 E.0089
G1 X90.211 Y102.979 E.00891
G1 X90.029 Y103.102 E.00431
G1 X89.664 Y103.305 E.00823
G1 X89.429 Y103.411 E.00506
G1 X89.034 Y103.546 E.00821
G1 X88.784 Y103.609 E.00506
G1 X88.334 Y103.676 E.00895
G1 X88.116 Y103.689 E.00431
G1 X87.663 Y103.676 E.00891
G1 X87.215 Y103.608 E.00891
G1 X86.999 Y103.556 E.00437
G1 X86.787 Y103.491 E.00437
G1 X86.402 Y103.336 E.00816
G1 X85.973 Y103.103 E.0096
G1 X85.608 Y102.84 E.00884
G1 X85.277 Y102.536 E.00885
G1 X84.983 Y102.195 E.00885
G1 X84.733 Y101.821 E.00885
G1 X84.527 Y101.418 E.00891
G1 X84.445 Y101.214 E.00431
G1 X84.324 Y100.817 E.00816
G1 X84.236 Y100.337 E.0096
G1 X84.21 Y99.889 E.00884
G1 X84.239 Y99.44 E.00885
G1 X84.32 Y98.997 E.00885
G1 X84.454 Y98.564 E.00891
G1 X84.537 Y98.362 E.00431
G1 X84.727 Y97.993 E.00816
G1 X84.999 Y97.587 E.00961
G1 X85.565 Y96.936 E.01697
; WIPE_START
M204 S6000
G1 X83.565 Y96.914 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G17
G3 Z1.44 I1.217 J0 P1  F18000
;===================== date: 20250206 =====================

; don't support timelapse gcode in spiral_mode and by object sequence for I3 structure printer
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
G92 E0
G1 Z1.44
G1 X0 Y90 ; move to safe pos
G1 X-13.0 F3000 ; move to safe pos
M400
M1004 S5 P1  ; external shutter
M400 P300
M971 S11 C11 O0
G92 E0
G1 X0 F18000
M623

; SKIPTYPE: head_wrap_detect
M622.1 S1
M1002 judge_flag g39_3rd_layer_detect_flag
M622 J1
    ; enable nozzle clog detect at 3rd layer
    


    M622.1 S1
    M1002 judge_flag g39_detection_flag
    M622 J1
      
        M622.1 S0
        M1002 judge_flag g39_mass_exceed_flag
        M622 J1
        
            G392 S0
            M400
            G90
            M83
            M204 S5000
            G0 Z1.44 F4000
            G39.3 S1
            G0 Z1.44 F4000
            G392 S0
          
        M623
    
    M623
M623
; SKIPPABLE_END




G1 X81.437 Y96.256
G1 Z1.04
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.151542
G1 F1500
M204 S6000
G1 X81.101 Y96.044 E.0025
G1 X80.921 Y95.802 E.00189
; LINE_WIDTH: 0.118984
G1 X80.901 Y95.754 E.00024
; LINE_WIDTH: 0.0927444
G1 X80.863 Y95.624 E.00045
; WIPE_START
G1 X80.901 Y95.754 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X86.548 Y97.165 Z1.44 F18000
G1 Z1.04
G1 E.4 F1800
; LINE_WIDTH: 0.47806
G1 F1500
M204 S6000
G1 X86.376 Y97.31 E.00507
; LINE_WIDTH: 0.442693
G1 X86.178 Y97.48 E.00542
; LINE_WIDTH: 0.404864
G1 X85.996 Y97.664 E.00489
; LINE_WIDTH: 0.359698
G1 X85.794 Y97.87 E.00482
G1 X85.464 Y98.303 E.00906
G1 X85.218 Y98.783 E.009
G1 X85.088 Y99.186 E.00704
G1 X85.024 Y99.536 E.00593
G1 X85.004 Y100.005 E.00782
G1 X85.071 Y100.539 E.00895
G1 X85.19 Y100.945 E.00706
G1 X85.418 Y101.421 E.00879
G1 X85.614 Y101.715 E.00589
G1 X85.846 Y101.985 E.00593
G1 X86.11 Y102.224 E.00593
G1 X86.393 Y102.433 E.00587
G1 X86.809 Y102.651 E.00781
G1 X87.208 Y102.791 E.00705
G1 X87.733 Y102.888 E.0089
G1 X88.257 Y102.885 E.00873
G1 X88.629 Y102.834 E.00626
G1 X89.134 Y102.678 E.0088
G1 X89.612 Y102.428 E.00899
G1 X90.027 Y102.107 E.00875
G1 X90.28 Y101.844 E.00607
G1 X90.486 Y101.578 E.00562
G1 X90.739 Y101.123 E.00867
G1 X90.863 Y100.775 E.00615
G1 X90.948 Y100.433 E.00588
G1 X90.996 Y99.919 E.0086
G1 X90.952 Y99.393 E.0088
G1 X90.866 Y99.015 E.00646
G1 X90.725 Y98.65 E.00652
G1 X90.485 Y98.228 E.00808
G1 X90.128 Y97.784 E.00951
; LINE_WIDTH: 0.375784
G1 X89.948 Y97.612 E.00434
; LINE_WIDTH: 0.408452
G1 X89.742 Y97.416 E.00543
; LINE_WIDTH: 0.445758
G1 X89.561 Y97.272 E.00484
; LINE_WIDTH: 0.479635
G1 X89.381 Y97.128 E.00523
; WIPE_START
G1 X89.561 Y97.272 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X94.536 Y96.252 Z1.44 F18000
G1 Z1.04
G1 E.4 F1800
; LINE_WIDTH: 0.147983
G1 F1500
M204 S6000
G1 X94.789 Y96.13 E.00171
G1 X95.126 Y95.806 E.00285
; WIPE_START
G1 X94.789 Y96.13 E-.23741
G1 X94.536 Y96.252 E-.14259
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X96.546 Y88.889 Z1.44 F18000
G1 X97.773 Y84.394 Z1.44
G1 Z1.04
G1 E.4 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F1500
M204 S6000
G1 X96.076 Y84.394 E.03592
G1 X95.918 Y84.227 E.00488
G1 X95.462 Y83.467 E.01875
G1 X95.407 Y83.43 E.00141
G1 X95.407 Y81.875 E.03293
G1 X95.462 Y81.967 E.00229
G1 X95.918 Y82.263 E.01149
G1 X96.373 Y82.249 E.00964
G1 X97.283 Y81.948 E.0203
G1 X97.738 Y81.673 E.01126
G1 X98.194 Y81.248 E.01318
G1 X98.593 Y80.666 E.01495
G1 X98.594 Y79.208 E.03085
G1 X98.354 Y79.208 E.00507
; WIPE_START
G1 X98.594 Y79.208 E-.04548
G1 X98.593 Y80.666 E-.27695
G1 X98.422 Y80.915 E-.05757
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X95.143 Y77.444 Z1.44 F18000
G1 Z1.04
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.145141
G1 F1500
M204 S6000
G1 X94.845 Y77.115 E.00264
G1 X94.783 Y77.067 E.00047
G1 X94.534 Y76.949 E.00164
; WIPE_START
G1 X94.783 Y77.067 E-.13109
G1 X94.845 Y77.115 E-.03765
G1 X95.143 Y77.444 E-.21126
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X87.515 Y77.17 Z1.44 F18000
G1 X81.496 Y76.955 Z1.44
G1 Z1.04
G1 E.4 F1800
; LINE_WIDTH: 0.0897098
G1 F1500
M204 S6000
G1 X81.394 Y76.991 E.00035
; LINE_WIDTH: 0.126542
G1 X81.217 Y77.068 E.00097
; LINE_WIDTH: 0.15293
G1 X81.064 Y77.199 E.00128
G1 X80.957 Y77.328 E.00106
G1 X80.912 Y77.423 E.00067
; LINE_WIDTH: 0.102006
G1 X80.854 Y77.604 E.00072
; CHANGE_LAYER
; Z_HEIGHT: 1.16
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F1500
G1 X80.912 Y77.423 E-.38
; WIPE_END
G1 E-.02 F1800
; layer num/total_layer_count: 9/49
; update layer progress
M73 L9
M991 S0 P8 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z1.44 I-.897 J.822 P1  F18000
G1 X95.29 Y93.111 Z1.44
G1 Z1.16
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X95.29 Y89.691 E.06727
G1 X98.71 Y89.691 E.06727
G1 X98.71 Y93.111 E.06727
G1 X95.35 Y93.111 E.06609
; WIPE_START
M204 S6000
G1 X95.315 Y91.111 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X89.836 Y96.425 Z1.56 F18000
G1 X89.159 Y97.081 Z1.56
G1 Z1.16
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X88.766 Y96.953 E.00873
G1 X88.393 Y96.88 E.00804
G1 X87.863 Y96.856 E.01123
G1 X87.322 Y96.93 E.01157
G1 X86.766 Y97.11 E.01238
G1 X86.659 Y96.949 E.0041
G1 X87.011 Y96.544 E.01135
G1 X88.922 Y96.544 E.04045
G1 X89.265 Y96.915 E.01069
G1 X89.191 Y97.03 E.00289
; WIPE_START
M204 S6000
G1 X88.766 Y96.953 E-.08203
G1 X88.393 Y96.88 E-.07221
G1 X87.863 Y96.856 E-.1008
G1 X87.322 Y96.93 E-.10385
G1 X87.216 Y96.964 E-.02111
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X90.617 Y99.845 Z1.56 F18000
G1 Z1.16
G1 E.4 F1800
G1 F1500
M204 S500
G1 X90.622 Y99.901 E.00119
G1 X90.579 Y100.371 E.00999
G1 X90.448 Y100.836 E.01023
G1 X90.325 Y101.109 E.00632
G1 X90.16 Y101.385 E.00681
G1 X89.868 Y101.741 E.00975
G1 X89.516 Y102.039 E.00975
G1 X89.242 Y102.208 E.00681
G1 X88.972 Y102.334 E.00632
G1 X88.509 Y102.473 E.01023
G1 X88.048 Y102.521 E.0098
G1 X87.727 Y102.507 E.00681
G1 X87.432 Y102.459 E.00632
G1 X86.972 Y102.313 E.01023
G1 X86.556 Y102.089 E.00999
G1 X86.188 Y101.796 E.00995
G1 X85.879 Y101.442 E.00995
G1 X85.643 Y101.046 E.00975
G1 X85.52 Y100.748 E.00683
G1 X85.434 Y100.437 E.00683
G1 X85.379 Y99.979 E.00975
G1 X85.407 Y99.519 E.00975
G1 X85.474 Y99.205 E.00681
G1 X85.57 Y98.922 E.00632
G1 X85.789 Y98.491 E.01023
G1 X86.078 Y98.118 E.00999
G1 X86.421 Y97.809 E.00975
G1 X86.69 Y97.632 E.00683
G1 X86.979 Y97.487 E.00684
G1 X87.416 Y97.345 E.00975
G1 X87.882 Y97.282 E.00995
G1 X88.343 Y97.302 E.00975
G1 X88.659 Y97.365 E.00683
G1 X88.966 Y97.465 E.00683
G1 X89.378 Y97.671 E.00976
G1 X89.747 Y97.947 E.00975
G1 X89.973 Y98.177 E.00683
G1 X90.172 Y98.434 E.00688
G1 X90.4 Y98.849 E.01003
G1 X90.504 Y99.129 E.00632
G1 X90.58 Y99.442 E.00681
G1 X90.611 Y99.785 E.00729
M204 S250
G1 X90.209 Y99.882 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X90.211 Y99.901 E.00038
G1 X90.175 Y100.296 E.00781
G1 X90.062 Y100.696 E.00817
G1 X89.962 Y100.919 E.00482
G1 X89.825 Y101.149 E.00526
G1 X89.575 Y101.452 E.00773
G1 X89.275 Y101.707 E.00774
G1 X89.048 Y101.847 E.00526
G1 X88.826 Y101.951 E.00482
G1 X88.428 Y102.07 E.00817
G1 X88.036 Y102.111 E.00775
G1 X87.769 Y102.099 E.00525
G1 X87.528 Y102.06 E.00482
G1 X87.132 Y101.934 E.00817
G1 X86.782 Y101.746 E.00781
G1 X86.472 Y101.499 E.0078
G1 X86.211 Y101.2 E.0078
G1 X86.01 Y100.863 E.00773
G1 X85.908 Y100.615 E.00526
G1 X85.837 Y100.358 E.00526
G1 X85.79 Y99.967 E.00774
G1 X85.814 Y99.574 E.00774
G1 X85.869 Y99.313 E.00525
G1 X85.948 Y99.081 E.00482
G1 X86.136 Y98.711 E.00817
G1 X86.379 Y98.397 E.00781
G1 X86.672 Y98.134 E.00774
G1 X86.895 Y97.987 E.00526
G1 X87.134 Y97.867 E.00527
G1 X87.508 Y97.746 E.00773
G1 X87.901 Y97.692 E.0078
G1 X88.294 Y97.71 E.00773
G1 X88.556 Y97.762 E.00526
G1 X88.811 Y97.844 E.00526
G1 X89.162 Y98.02 E.00774
G1 X89.477 Y98.256 E.00773
G1 X89.665 Y98.447 E.00526
G1 X89.829 Y98.659 E.00528
G1 X90.027 Y99.02 E.00811
G1 X90.112 Y99.25 E.00482
G1 X90.176 Y99.509 E.00526
G1 X90.204 Y99.822 E.00617
; WIPE_START
M204 S6000
G1 X90.211 Y99.901 E-.01508
G1 X90.175 Y100.296 E-.07544
G1 X90.062 Y100.696 E-.07892
G1 X89.962 Y100.919 E-.04653
G1 X89.825 Y101.149 E-.05077
G1 X89.575 Y101.452 E-.07471
G1 X89.42 Y101.584 E-.03856
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X95.377 Y96.811 Z1.56 F18000
G1 X98.955 Y93.944 Z1.56
G1 Z1.16
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X98.956 Y94.357 E.00872
G1 X95.043 Y94.358 E.08281
G1 X95.043 Y93.944 E.00875
G1 X98.895 Y93.944 E.08153
; WIPE_START
M204 S6000
G1 X98.956 Y94.357 E-.07915
G1 X97.373 Y94.357 E-.30085
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X95.29 Y88.857 Z1.56 F18000
G1 Z1.16
G1 E.4 F1800
G1 F1500
M204 S500
G1 X95.043 Y88.857 E.00522
G1 X95.043 Y88.445 E.00872
G1 X98.948 Y88.445 E.08265
G1 X98.949 Y88.857 E.00872
G1 X95.35 Y88.857 E.07617
; WIPE_START
M204 S6000
G1 X95.043 Y88.857 E-.05824
G1 X95.043 Y88.445 E-.07829
G1 X96.325 Y88.445 E-.24348
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X98.343 Y81.084 Z1.56 F18000
G1 X98.956 Y78.845 Z1.56
G1 Z1.16
G1 E.4 F1800
G1 F1500
M204 S500
G1 X98.956 Y84.757 E.12513
G1 X95.044 Y84.756 E.0828
G1 X95.044 Y78.844 E.12514
G1 X98.896 Y78.845 E.08153
; WIPE_START
M204 S6000
G1 X98.916 Y80.845 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X94.164 Y86.817 Z1.56 F18000
G1 X86.761 Y96.12 Z1.56
G1 Z1.16
G1 E.4 F1800
G1 F1500
M204 S500
G1 X94.064 Y96.12 E.15458
G1 X94.387 Y96.052 E.00698
G1 X94.618 Y95.917 E.00567
G1 X95.29 Y95.274 E.01968
G1 X94.619 Y94.784 E.01757
G1 X94.619 Y88.021 E.14315
G1 X99.372 Y88.021 E.10059
G1 X99.373 Y89.282 E.02668
G1 X94.881 Y89.282 E.09509
G1 X94.881 Y93.52 E.08971
G1 X99.119 Y93.52 E.08971
G1 X99.119 Y89.368 E.08789
G1 X99.374 Y89.367 E.00538
G1 X99.381 Y94.781 E.11458
G1 X95.386 Y94.782 E.08455
G1 X95.379 Y95.64 E.01817
G1 X95.355 Y95.803 E.00349
G1 X95.307 Y95.949 E.00324
G1 X95.234 Y96.084 E.00324
G1 X95.144 Y96.198 E.00307
G1 X94.985 Y96.332 E.0044
G1 X94.846 Y96.408 E.00336
G1 X94.711 Y96.453 E.003
G1 X94.464 Y96.482 E.00527
G1 X89.441 Y96.482 E.1063
G1 X90.544 Y97.675 E.03439
G1 X90.8 Y98.008 E.00889
G1 X91.07 Y98.49 E.01169
G1 X91.229 Y98.904 E.00939
G1 X91.355 Y99.49 E.01269
G1 X91.374 Y100.1 E.01292
G1 X91.295 Y100.646 E.01169
G1 X91.17 Y101.073 E.00941
G1 X90.917 Y101.608 E.01253
G1 X90.57 Y102.096 E.01267
G1 X90.285 Y102.391 E.00869
G1 X89.967 Y102.65 E.00869
M73 P48 R12
G1 X89.643 Y102.855 E.00811
G1 X89.272 Y103.032 E.00871
G1 X88.922 Y103.152 E.00783
G1 X88.704 Y103.207 E.00476
G1 X88.291 Y103.269 E.00883
G1 X87.699 Y103.267 E.01253
G1 X87.116 Y103.163 E.01254
G1 X86.729 Y103.032 E.00864
G1 X86.331 Y102.838 E.00939
G1 X86.019 Y102.64 E.00781
G1 X85.571 Y102.251 E.01256
G1 X85.309 Y101.946 E.00852
G1 X84.992 Y101.443 E.01257
G1 X84.829 Y101.07 E.00863
G1 X84.71 Y100.677 E.00869
G1 X84.629 Y100.131 E.01169
G1 X84.627 Y99.687 E.00939
G1 X84.676 Y99.291 E.00844
G1 X84.771 Y98.901 E.00849
G1 X84.913 Y98.526 E.00849
G1 X85.097 Y98.17 E.00849
G1 X85.323 Y97.838 E.00849
G1 X86.503 Y96.482 E.03805
G1 X81.536 Y96.482 E.10513
G1 X81.289 Y96.453 E.00527
G1 X81.144 Y96.405 E.00324
G1 X80.928 Y96.269 E.0054
G1 X80.731 Y96.026 E.0066
G1 X80.648 Y95.813 E.00484
G1 X80.619 Y95.565 E.0053
G1 X80.619 Y77.619 E.37984
G1 X80.659 Y77.349 E.00578
G1 X80.76 Y77.125 E.0052
G1 X80.862 Y76.997 E.00346
G1 X80.972 Y76.898 E.00314
G1 X81.201 Y76.775 E.00549
G1 X81.451 Y76.723 E.00542
G1 X94.479 Y76.721 E.27574
G1 X94.701 Y76.748 E.00474
G1 X94.9 Y76.82 E.00448
G1 X95.027 Y76.899 E.00317
G1 X95.172 Y77.037 E.00424
G1 X95.282 Y77.204 E.00424
G1 X95.342 Y77.351 E.00336
G1 X95.372 Y77.498 E.00318
G1 X95.397 Y78.42 E.01952
G1 X99.381 Y78.421 E.08431
G1 X99.38 Y85.182 E.14309
G1 X94.619 Y85.181 E.10076
G1 X94.62 Y78.417 E.14317
G1 X95.29 Y77.928 E.01755
G1 X94.618 Y77.285 E.01969
G1 X94.387 Y77.149 E.00567
G1 X94.064 Y77.082 E.00698
G1 X81.955 Y77.082 E.2563
G1 X81.697 Y77.119 E.00553
G1 X81.394 Y77.272 E.00717
G1 X81.171 Y77.495 E.00668
G1 X81.019 Y77.798 E.00717
G1 X80.981 Y78.056 E.00552
G1 X80.981 Y95.137 E.36154
G1 X81.005 Y95.346 E.00445
G1 X81.108 Y95.605 E.0059
G1 X81.261 Y95.81 E.00542
G1 X81.487 Y95.989 E.0061
G1 X81.755 Y96.096 E.00609
G1 X81.964 Y96.12 E.00446
G1 X86.701 Y96.12 E.10026
; WIPE_START
M204 S6000
G1 X88.701 Y96.12 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X85.604 Y96.891 Z1.56 F18000
G1 Z1.16
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X81.512 Y96.891 E.08049
G1 X81.2 Y96.854 E.00619
G1 X80.987 Y96.784 E.00442
G1 X80.858 Y96.719 E.00283
G1 X80.669 Y96.587 E.00454
G1 X80.566 Y96.49 E.00277
G1 X80.381 Y96.241 E.00611
G1 X80.312 Y96.101 E.00307
G1 X80.247 Y95.902 E.00412
G1 X80.21 Y95.589 E.0062
G1 X80.21 Y77.607 E.35368
G1 X80.219 Y77.454 E.00301
G1 X80.265 Y77.231 E.00448
G1 X80.349 Y77.019 E.00448
G1 X80.421 Y76.895 E.00283
G1 X80.563 Y76.716 E.00449
G1 X80.721 Y76.574 E.00418
G1 X80.853 Y76.485 E.00314
G1 X81.059 Y76.389 E.00447
G1 X81.265 Y76.333 E.00418
G1 X81.426 Y76.313 E.00319
G1 X94.503 Y76.311 E.25722
G1 X94.797 Y76.347 E.00582
G1 X95.08 Y76.45 E.00594
G1 X95.279 Y76.574 E.0046
G1 X95.487 Y76.773 E.00565
G1 X95.646 Y77.012 E.00566
G1 X95.735 Y77.232 E.00466
G1 X95.78 Y77.451 E.0044
G1 X95.796 Y78.011 E.01102
G1 X99.413 Y78.012 E.07116
G1 X99.536 Y78.037 E.00245
G1 X99.611 Y78.075 E.00165
G1 X99.699 Y78.154 E.00233
G1 X99.747 Y78.227 E.00171
G1 X99.79 Y78.413 E.00377
G1 X99.789 Y85.214 E.13377
G1 X99.764 Y85.337 E.00245
G1 X99.725 Y85.414 E.00171
G1 X99.669 Y85.481 E.00171
G1 X99.572 Y85.549 E.00233
G1 X99.388 Y85.591 E.00371
G1 X94.584 Y85.59 E.0945
G1 X94.406 Y85.537 E.00365
G1 X94.277 Y85.417 E.00346
G1 X94.228 Y85.312 E.00228
G1 X94.21 Y85.186 E.00251
G1 X94.211 Y78.385 E.13377
G1 X94.227 Y78.294 E.00182
G1 X94.276 Y78.187 E.00231
G1 X94.33 Y78.122 E.00166
G1 X94.654 Y77.886 E.00788
G1 X94.369 Y77.614 E.00774
G1 X94.237 Y77.536 E.00301
G1 X94.022 Y77.491 E.00433
G1 X81.985 Y77.491 E.23675
G1 X81.821 Y77.515 E.00325
G1 X81.637 Y77.608 E.00407
G1 X81.507 Y77.738 E.00361
G1 X81.414 Y77.922 E.00407
G1 X81.39 Y78.086 E.00324
G1 X81.39 Y95.113 E.33492
G1 X81.405 Y95.245 E.00261
G1 X81.469 Y95.404 E.00337
G1 X81.557 Y95.523 E.00292
G1 X81.694 Y95.631 E.00343
G1 X81.856 Y95.695 E.00343
G1 X81.988 Y95.711 E.00261
G1 X94.022 Y95.711 E.2367
G1 X94.237 Y95.666 E.00433
G1 X94.369 Y95.588 E.00301
G1 X94.654 Y95.316 E.00774
G1 X94.331 Y95.081 E.00786
G1 X94.27 Y95.006 E.0019
G1 X94.228 Y94.912 E.00202
G1 X94.21 Y94.786 E.00251
G1 X94.21 Y88.018 E.13311
G1 X94.234 Y87.876 E.00283
G1 X94.291 Y87.766 E.00246
G1 X94.418 Y87.657 E.00328
G1 X94.583 Y87.612 E.00337
G1 X99.41 Y87.612 E.09494
G1 X99.554 Y87.646 E.00291
G1 X99.66 Y87.714 E.00247
G1 X99.734 Y87.806 E.00233
G1 X99.781 Y87.934 E.00268
G1 X99.79 Y94.783 E.13471
G1 X99.763 Y94.933 E.00301
G1 X99.692 Y95.058 E.00283
G1 X99.572 Y95.15 E.00298
G1 X99.417 Y95.19 E.00315
G1 X95.792 Y95.191 E.07129
G1 X95.788 Y95.672 E.00946
G1 X95.754 Y95.898 E.0045
G1 X95.684 Y96.112 E.00442
G1 X95.577 Y96.309 E.00442
G1 X95.439 Y96.484 E.00437
G1 X95.218 Y96.671 E.00571
G1 X95.01 Y96.785 E.00466
G1 X94.8 Y96.854 E.00434
G1 X94.488 Y96.891 E.00619
G1 X90.377 Y96.891 E.08086
G1 X90.857 Y97.411 E.01392
G1 X91.136 Y97.772 E.00898
G1 X91.253 Y97.957 E.00431
G1 X91.443 Y98.321 E.00807
G1 X91.62 Y98.781 E.0097
G1 X91.728 Y99.22 E.00889
G1 X91.782 Y99.661 E.00873
G1 X91.784 Y100.117 E.00897
G1 X91.765 Y100.335 E.00431
G1 X91.695 Y100.739 E.00807
G1 X91.555 Y101.213 E.0097
G1 X91.392 Y101.588 E.00806
G1 X91.268 Y101.819 E.00515
G1 X91.015 Y102.197 E.00896
G1 X90.877 Y102.368 E.0043
G1 X90.562 Y102.693 E.00891
G1 X90.211 Y102.979 E.00891
G1 X90.027 Y103.103 E.00437
G1 X89.836 Y103.216 E.00437
G1 X89.427 Y103.412 E.00892
G1 X89.038 Y103.545 E.00808
G1 X88.784 Y103.609 E.00515
G1 X88.334 Y103.676 E.00896
G1 X88.116 Y103.689 E.0043
G1 X87.663 Y103.676 E.00891
G1 X87.215 Y103.608 E.00891
G1 X87.002 Y103.557 E.00431
G1 X86.574 Y103.412 E.0089
G1 X86.13 Y103.196 E.0097
G1 X85.784 Y102.976 E.00807
G1 X85.61 Y102.842 E.00431
G1 X85.277 Y102.536 E.00891
G1 X84.983 Y102.194 E.00886
G1 X84.754 Y101.854 E.00807
G1 X84.625 Y101.626 E.00516
G1 X84.444 Y101.212 E.00889
G1 X84.313 Y100.778 E.00891
G1 X84.269 Y100.563 E.00431
G1 X84.22 Y100.156 E.00807
G1 X84.218 Y99.663 E.0097
G1 X84.273 Y99.217 E.00884
G1 X84.38 Y98.78 E.00885
G1 X84.538 Y98.359 E.00885
G1 X84.745 Y97.96 E.00885
G1 X84.998 Y97.588 E.00885
G1 X85.565 Y96.936 E.01698
; WIPE_START
M204 S6000
G1 X83.565 Y96.914 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G17
G3 Z1.56 I1.217 J0 P1  F18000
;===================== date: 20250206 =====================

; don't support timelapse gcode in spiral_mode and by object sequence for I3 structure printer
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
G92 E0
G1 Z1.56
G1 X0 Y90 ; move to safe pos
G1 X-13.0 F3000 ; move to safe pos
M400
M1004 S5 P1  ; external shutter
M400 P300
M971 S11 C11 O0
G92 E0
G1 X0 F18000
M623

; SKIPTYPE: head_wrap_detect
M622.1 S1
M1002 judge_flag g39_3rd_layer_detect_flag
M622 J1
    ; enable nozzle clog detect at 3rd layer
    


    M622.1 S1
    M1002 judge_flag g39_detection_flag
    M622 J1
      
        M622.1 S0
        M1002 judge_flag g39_mass_exceed_flag
        M622 J1
        
            G392 S0
            M400
            G90
            M83
            M204 S5000
            G0 Z1.56 F4000
            G39.3 S1
            G0 Z1.56 F4000
            G392 S0
          
        M623
    
    M623
M623
; SKIPPABLE_END




G1 X81.472 Y96.237
G1 Z1.16
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.0933302
G1 F1500
M204 S6000
G1 X81.344 Y96.202 E.00045
; LINE_WIDTH: 0.130513
G1 X81.253 Y96.153 E.00055
; LINE_WIDTH: 0.152201
G1 X81.067 Y96.011 E.00147
G1 X80.859 Y95.721 E.00225
M204 S10000
M73 P49 R12
G1 X80.864 Y95.628 F18000
; LINE_WIDTH: 0.0894322
G1 F1500
M204 S6000
G1 X81.013 Y96.047 E.00141
; WIPE_START
G1 X80.864 Y95.628 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X85.986 Y97.673 Z1.56 F18000
G1 Z1.16
G1 E.4 F1800
; LINE_WIDTH: 0.400635
G1 F1500
M204 S6000
G1 X86.16 Y97.496 E.00465
; LINE_WIDTH: 0.438429
G1 X86.367 Y97.319 E.00561
; LINE_WIDTH: 0.477123
G1 X86.548 Y97.165 E.00533
M204 S10000
G1 X85.986 Y97.673 F18000
; LINE_WIDTH: 0.360135
G1 F1500
M204 S6000
G1 X85.792 Y97.872 E.00464
G1 X85.463 Y98.302 E.00904
G1 X85.226 Y98.764 E.00865
G1 X85.108 Y99.114 E.00617
G1 X85.032 Y99.481 E.00625
G1 X85.004 Y100.005 E.00876
G1 X85.067 Y100.522 E.00868
G1 X85.187 Y100.938 E.00722
G1 X85.332 Y101.269 E.00603
G1 X85.614 Y101.717 E.00882
G1 X85.919 Y102.057 E.00762
G1 X86.336 Y102.395 E.00896
G1 X86.839 Y102.666 E.00953
G1 X87.333 Y102.824 E.00865
G1 X87.698 Y102.884 E.00617
G1 X88.048 Y102.895 E.00584
G1 X88.598 Y102.841 E.00923
G1 X89.095 Y102.692 E.00865
G1 X89.431 Y102.537 E.00617
G1 X89.742 Y102.344 E.00611
G1 X90.124 Y102.014 E.00842
G1 X90.379 Y101.722 E.00646
G1 X90.657 Y101.292 E.00854
G1 X90.808 Y100.955 E.00617
G1 X90.945 Y100.454 E.00866
G1 X90.991 Y100.081 E.00627
G1 X90.974 Y99.536 E.0091
G1 X90.869 Y99.028 E.00866
G1 X90.739 Y98.681 E.00617
G1 X90.569 Y98.359 E.00607
G1 X90.253 Y97.919 E.00904
G1 X89.992 Y97.647 E.0063
; LINE_WIDTH: 0.397595
G1 X89.807 Y97.48 E.00461
; LINE_WIDTH: 0.442722
G1 X89.622 Y97.314 E.00517
; LINE_WIDTH: 0.480579
G1 X89.38 Y97.129 E.00691
; WIPE_START
G1 X89.622 Y97.314 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X94.537 Y96.257 Z1.56 F18000
G1 Z1.16
G1 E.4 F1800
; LINE_WIDTH: 0.148844
G1 F1500
M204 S6000
G1 X94.829 Y96.1 E.00203
G1 X95.135 Y95.785 E.00269
; WIPE_START
G1 X94.829 Y96.1 E-.21647
G1 X94.537 Y96.257 E-.16353
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X96.567 Y88.899 Z1.56 F18000
G1 X98.199 Y82.985 Z1.56
G1 Z1.16
G1 E.4 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F1500
M204 S6000
G1 X98.199 Y81.288 E.03592
G1 X97.738 Y81.668 E.01264
G1 X97.283 Y81.906 E.01087
G1 X96.373 Y82.117 E.01978
G1 X95.918 Y82.051 E.00974
G1 X95.801 Y81.962 E.0031
G1 X95.801 Y80.265 E.03592
; WIPE_START
G1 X95.801 Y81.962 E-.32243
G1 X95.918 Y82.051 E-.02784
G1 X96.072 Y82.073 E-.02973
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X95.143 Y77.443 Z1.56 F18000
G1 Z1.16
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.145219
G1 F1500
M204 S6000
G1 X94.854 Y77.122 E.00258
G1 X94.78 Y77.065 E.00055
G1 X94.534 Y76.949 E.00162
; WIPE_START
G1 X94.78 Y77.065 E-.12979
G1 X94.854 Y77.122 E-.0443
G1 X95.143 Y77.443 E-.2059
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X98.578 Y79.39 Z1.56 F18000
G1 Z1.16
G1 E.4 F1800
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.378267
G1 F1200
M204 S6000
G1 X98.564 Y79.321 E.00124
; LINE_WIDTH: 0.394954
G1 X98.549 Y79.252 E.0013
G1 X98.411 Y79.224 E.00259
; LINE_WIDTH: 0.365752
G1 X95.589 Y79.223 E.04787
; LINE_WIDTH: 0.378277
G1 X95.52 Y79.237 E.00124
; LINE_WIDTH: 0.394976
G1 X95.452 Y79.251 E.0013
G1 X95.423 Y79.389 E.0026
; LINE_WIDTH: 0.365752
G1 X95.422 Y84.212 E.0818
; LINE_WIDTH: 0.378272
G1 X95.436 Y84.28 E.00124
; LINE_WIDTH: 0.394965
G1 X95.451 Y84.349 E.0013
G1 X95.589 Y84.378 E.00259
; LINE_WIDTH: 0.365752
G1 X98.411 Y84.379 E.04787
; LINE_WIDTH: 0.378272
G1 X98.48 Y84.364 E.00124
; LINE_WIDTH: 0.394965
G1 X98.548 Y84.35 E.0013
G1 X98.577 Y84.212 E.00259
; LINE_WIDTH: 0.365752
G1 X98.578 Y79.45 E.08078
; WIPE_START
G1 X98.577 Y81.45 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X91.197 Y79.507 Z1.56 F18000
G1 X81.504 Y76.955 Z1.56
G1 Z1.16
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.0894338
G1 F1500
M204 S6000
G1 X81.397 Y76.991 E.00036
; LINE_WIDTH: 0.12845
G1 X81.193 Y77.083 E.00115
; LINE_WIDTH: 0.152743
G1 X80.962 Y77.32 E.0021
G1 X80.912 Y77.424 E.00073
; LINE_WIDTH: 0.115056
G1 X80.883 Y77.514 E.00042
; LINE_WIDTH: 0.0897381
G1 X80.854 Y77.604 E.0003
; CHANGE_LAYER
; Z_HEIGHT: 1.28
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F1500
G1 X80.883 Y77.514 E-.38
; WIPE_END
G1 E-.02 F1800
; layer num/total_layer_count: 10/49
; update layer progress
M73 L10
M991 S0 P9 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z1.56 I-.894 J.826 P1  F18000
G1 X95.29 Y93.111 Z1.56
G1 Z1.28
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X95.29 Y89.691 E.06727
G1 X98.71 Y89.691 E.06727
G1 X98.71 Y93.111 E.06727
G1 X95.35 Y93.111 E.06609
; WIPE_START
M204 S6000
G1 X95.315 Y91.111 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X89.836 Y96.425 Z1.68 F18000
G1 X89.159 Y97.081 Z1.68
G1 Z1.28
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X88.766 Y96.954 E.00873
G1 X88.393 Y96.88 E.00805
G1 X87.879 Y96.857 E.0109
G1 X87.501 Y96.897 E.00804
G1 X87.131 Y96.981 E.00804
G1 X86.762 Y97.126 E.00839
G1 X86.647 Y96.963 E.00423
G1 X87.011 Y96.544 E.01174
G1 X88.922 Y96.544 E.04045
G1 X89.265 Y96.915 E.01069
G1 X89.191 Y97.031 E.00289
; WIPE_START
M204 S6000
G1 X88.766 Y96.954 E-.08202
G1 X88.393 Y96.88 E-.07222
G1 X87.879 Y96.857 E-.09782
G1 X87.501 Y96.897 E-.07217
G1 X87.215 Y96.962 E-.05576
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X90.617 Y99.845 Z1.68 F18000
G1 Z1.28
G1 E.4 F1800
G1 F1500
M204 S500
G1 X90.622 Y99.903 E.00125
G1 X90.575 Y100.387 E.01029
G1 X90.504 Y100.674 E.00626
G1 X90.391 Y100.975 E.00681
G1 X90.166 Y101.378 E.00975
G1 X89.868 Y101.741 E.00995
G1 X89.516 Y102.039 E.00975
G1 X89.243 Y102.208 E.00681
G1 X88.974 Y102.333 E.00627
G1 X88.509 Y102.473 E.01028
G1 X88.048 Y102.521 E.0098
G1 X87.727 Y102.507 E.0068
G1 X87.435 Y102.459 E.00627
G1 X86.972 Y102.313 E.01028
G1 X86.556 Y102.089 E.01
G1 X86.188 Y101.796 E.00995
G1 X85.879 Y101.442 E.00995
G1 X85.643 Y101.046 E.00975
G1 X85.52 Y100.748 E.00683
G1 X85.434 Y100.437 E.00683
G1 X85.379 Y99.979 E.00975
G1 X85.407 Y99.519 E.00975
G1 X85.474 Y99.205 E.00681
G1 X85.569 Y98.924 E.00627
G1 X85.789 Y98.491 E.01028
G1 X86.078 Y98.118 E.01
G1 X86.427 Y97.803 E.00995
G1 X86.827 Y97.556 E.00995
G1 X87.256 Y97.388 E.00975
G1 X87.571 Y97.316 E.00683
G1 X87.892 Y97.282 E.00683
G1 X88.343 Y97.302 E.00955
G1 X88.659 Y97.365 E.00683
G1 X88.966 Y97.465 E.00683
G1 X89.378 Y97.671 E.00975
G1 X89.747 Y97.947 E.00975
G1 X89.973 Y98.177 E.00683
G1 X90.172 Y98.434 E.00688
G1 X90.401 Y98.852 E.01009
G1 X90.504 Y99.13 E.00627
G1 X90.58 Y99.442 E.0068
G1 X90.611 Y99.785 E.00728
M204 S250
G1 X90.209 Y99.881 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X90.211 Y99.902 E.0004
G1 X90.17 Y100.317 E.00822
G1 X90.112 Y100.553 E.00477
G1 X90.018 Y100.803 E.00526
G1 X89.827 Y101.146 E.00773
G1 X89.575 Y101.452 E.0078
G1 X89.275 Y101.707 E.00773
G1 X89.048 Y101.847 E.00525
G1 X88.828 Y101.95 E.00477
G1 X88.428 Y102.07 E.00821
G1 X88.036 Y102.111 E.00775
G1 X87.769 Y102.099 E.00525
G1 X87.53 Y102.06 E.00477
G1 X87.132 Y101.934 E.00821
G1 X86.782 Y101.746 E.00781
G1 X86.472 Y101.499 E.0078
G1 X86.211 Y101.2 E.0078
G1 X86.01 Y100.863 E.00774
G1 X85.908 Y100.615 E.00526
G1 X85.837 Y100.357 E.00526
G1 X85.79 Y99.967 E.00773
G1 X85.814 Y99.574 E.00774
G1 X85.869 Y99.313 E.00526
G1 X85.947 Y99.084 E.00477
G1 X86.136 Y98.711 E.00822
G1 X86.379 Y98.397 E.00781
G1 X86.674 Y98.132 E.0078
G1 X87.011 Y97.924 E.0078
G1 X87.377 Y97.78 E.00773
G1 X87.638 Y97.72 E.00526
G1 X87.904 Y97.692 E.00526
G1 X88.294 Y97.71 E.00767
G1 X88.556 Y97.762 E.00526
G1 X88.811 Y97.844 E.00526
G1 X89.162 Y98.02 E.00774
G1 X89.477 Y98.256 E.00773
G1 X89.665 Y98.447 E.00526
G1 X89.829 Y98.659 E.00528
G1 X90.028 Y99.022 E.00815
G1 X90.112 Y99.25 E.00477
G1 X90.176 Y99.509 E.00525
G1 X90.204 Y99.821 E.00616
; WIPE_START
M204 S6000
G1 X90.211 Y99.902 E-.0153
G1 X90.17 Y100.317 E-.07937
G1 X90.112 Y100.553 E-.04604
G1 X90.018 Y100.803 E-.05078
G1 X89.827 Y101.146 E-.07471
G1 X89.575 Y101.452 E-.07531
G1 X89.42 Y101.583 E-.03849
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X95.377 Y96.811 Z1.68 F18000
G1 X98.955 Y93.944 Z1.68
G1 Z1.28
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X98.956 Y94.357 E.00872
G1 X95.043 Y94.358 E.08281
G1 X95.043 Y93.944 E.00875
G1 X98.895 Y93.944 E.08153
; WIPE_START
M204 S6000
G1 X98.956 Y94.357 E-.07915
G1 X97.373 Y94.357 E-.30085
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X95.29 Y88.857 Z1.68 F18000
G1 Z1.28
G1 E.4 F1800
G1 F1500
M204 S500
G1 X95.043 Y88.857 E.00522
G1 X95.043 Y88.445 E.00872
G1 X98.948 Y88.445 E.08265
G1 X98.949 Y88.857 E.00872
G1 X95.35 Y88.857 E.07617
; WIPE_START
M204 S6000
G1 X95.043 Y88.857 E-.05824
G1 X95.043 Y88.445 E-.07829
G1 X96.325 Y88.445 E-.24348
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X98.343 Y81.084 Z1.68 F18000
G1 X98.956 Y78.845 Z1.68
G1 Z1.28
G1 E.4 F1800
G1 F1500
M204 S500
G1 X98.956 Y84.757 E.12513
G1 X95.044 Y84.756 E.0828
G1 X95.044 Y78.844 E.12514
G1 X98.896 Y78.845 E.08153
; WIPE_START
M204 S6000
G1 X98.916 Y80.845 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X94.164 Y86.817 Z1.68 F18000
G1 X86.761 Y96.12 Z1.68
G1 Z1.28
G1 E.4 F1800
G1 F1500
M204 S500
G1 X94.064 Y96.12 E.15458
G1 X94.387 Y96.052 E.00698
G1 X94.618 Y95.917 E.00567
G1 X95.29 Y95.273 E.01968
G1 X94.619 Y94.784 E.01756
G1 X94.619 Y88.021 E.14315
G1 X99.372 Y88.021 E.10059
G1 X99.373 Y89.282 E.02668
G1 X94.881 Y89.282 E.09509
G1 X94.881 Y93.52 E.08971
G1 X99.119 Y93.52 E.08971
G1 X99.119 Y89.362 E.08802
G1 X99.374 Y89.361 E.00538
G1 X99.381 Y94.781 E.1147
G1 X95.386 Y94.782 E.08455
G1 X95.379 Y95.64 E.01817
G1 X95.355 Y95.803 E.00349
G1 X95.307 Y95.949 E.00324
G1 X95.234 Y96.084 E.00324
G1 X95.144 Y96.198 E.00308
G1 X94.986 Y96.331 E.00437
G1 X94.846 Y96.408 E.00339
G1 X94.711 Y96.453 E.003
G1 X94.464 Y96.482 E.00527
G1 X89.441 Y96.482 E.1063
G1 X90.544 Y97.675 E.03439
G1 X90.8 Y98.008 E.00889
G1 X91.068 Y98.486 E.01159
G1 X91.229 Y98.904 E.00949
G1 X91.355 Y99.49 E.01268
G1 X91.374 Y100.1 E.01292
G1 X91.296 Y100.642 E.01159
G1 X91.167 Y101.081 E.00968
G1 X90.913 Y101.614 E.0125
G1 X90.568 Y102.098 E.01258
G1 X90.285 Y102.391 E.00862
G1 X89.967 Y102.65 E.00868
G1 X89.487 Y102.935 E.0118
G1 X89.278 Y103.03 E.00486
G1 X88.884 Y103.163 E.00882
G1 X88.292 Y103.269 E.01273
G1 X87.699 Y103.267 E.01254
G1 X87.107 Y103.161 E.01274
G1 X86.585 Y102.969 E.01178
G1 X86.191 Y102.755 E.00949
G1 X85.867 Y102.522 E.00844
G1 X85.571 Y102.251 E.0085
G1 X85.31 Y101.947 E.00849
G1 X85.086 Y101.613 E.0085
G1 X84.831 Y101.078 E.01256
G1 X84.724 Y100.729 E.00772
G1 X84.643 Y100.288 E.00949
G1 X84.62 Y99.89 E.00844
G1 X84.645 Y99.49 E.00849
G1 X84.718 Y99.095 E.0085
G1 X84.909 Y98.533 E.01256
G1 X85.076 Y98.209 E.00772
G1 X85.325 Y97.836 E.00949
G1 X86.503 Y96.482 E.038
G1 X81.536 Y96.482 E.10513
G1 X81.289 Y96.453 E.00527
G1 X81.078 Y96.372 E.00477
G1 X80.881 Y96.223 E.00523
G1 X80.79 Y96.12 E.00291
G1 X80.743 Y96.048 E.00181
G1 X80.649 Y95.821 E.0052
G1 X80.619 Y95.565 E.00546
G1 X80.619 Y77.619 E.37984
G1 X80.658 Y77.349 E.00577
G1 X80.76 Y77.125 E.0052
G1 X80.862 Y76.997 E.00346
G1 X80.971 Y76.899 E.00311
G1 X81.2 Y76.775 E.00549
G1 X81.449 Y76.723 E.00539
G1 X94.48 Y76.721 E.27582
G1 X94.701 Y76.747 E.0047
G1 X94.893 Y76.818 E.00434
G1 X95.071 Y76.934 E.0045
G1 X95.166 Y77.03 E.00286
G1 X95.288 Y77.215 E.00469
G1 X95.342 Y77.349 E.00305
G1 X95.372 Y77.498 E.00323
G1 X95.397 Y78.42 E.01951
G1 X99.381 Y78.421 E.08431
G1 X99.38 Y85.182 E.14309
G1 X94.619 Y85.181 E.10076
G1 X94.62 Y78.417 E.14317
G1 X95.29 Y77.928 E.01755
G1 X94.618 Y77.285 E.01968
G1 X94.387 Y77.149 E.00567
G1 X94.064 Y77.082 E.00698
G1 X81.946 Y77.082 E.25649
G1 X81.657 Y77.132 E.0062
G1 X81.385 Y77.279 E.00654
G1 X81.166 Y77.502 E.00662
G1 X81.018 Y77.799 E.00703
G1 X80.981 Y78.056 E.00549
G1 X80.981 Y95.146 E.36173
G1 X81.016 Y95.388 E.00518
G1 X81.122 Y95.628 E.00555
G1 X81.297 Y95.848 E.00596
G1 X81.562 Y96.034 E.00685
G1 X81.928 Y96.12 E.00794
G1 X86.701 Y96.12 E.10103
; WIPE_START
M204 S6000
G1 X88.701 Y96.12 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X85.605 Y96.891 Z1.68 F18000
G1 Z1.28
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X81.512 Y96.891 E.08049
G1 X81.2 Y96.854 E.00619
G1 X80.986 Y96.784 E.00442
G1 X80.861 Y96.721 E.00275
M73 P50 R12
G1 X80.602 Y96.525 E.0064
G1 X80.464 Y96.369 E.00408
G1 X80.385 Y96.248 E.00284
G1 X80.287 Y96.039 E.00454
G1 X80.247 Y95.904 E.00277
G1 X80.21 Y95.589 E.00625
G1 X80.21 Y77.607 E.35368
G1 X80.219 Y77.454 E.00301
G1 X80.265 Y77.231 E.00448
G1 X80.349 Y77.019 E.00448
G1 X80.421 Y76.895 E.00283
G1 X80.563 Y76.716 E.00449
G1 X80.72 Y76.575 E.00415
G1 X80.853 Y76.485 E.00317
G1 X81.059 Y76.389 E.00447
G1 X81.279 Y76.33 E.00448
G1 X81.425 Y76.313 E.00289
G1 X94.505 Y76.311 E.25727
G1 X94.797 Y76.347 E.00578
G1 X95.078 Y76.449 E.00589
G1 X95.331 Y76.615 E.00595
G1 X95.485 Y76.77 E.0043
G1 X95.653 Y77.025 E.00601
G1 X95.735 Y77.231 E.00436
G1 X95.78 Y77.451 E.00442
G1 X95.796 Y78.011 E.01101
G1 X99.417 Y78.012 E.07122
G1 X99.508 Y78.028 E.00184
G1 X99.613 Y78.077 E.00227
G1 X99.699 Y78.154 E.00227
G1 X99.747 Y78.227 E.00171
G1 X99.79 Y78.413 E.00377
G1 X99.789 Y85.214 E.13377
G1 X99.764 Y85.337 E.00245
G1 X99.725 Y85.415 E.00172
G1 X99.669 Y85.481 E.00171
G1 X99.571 Y85.549 E.00233
G1 X99.388 Y85.591 E.00371
G1 X94.583 Y85.59 E.09449
G1 X94.406 Y85.537 E.00365
G1 X94.277 Y85.417 E.00346
G1 X94.229 Y85.312 E.00227
G1 X94.21 Y85.186 E.00252
G1 X94.211 Y78.387 E.13372
G1 X94.233 Y78.275 E.00224
G1 X94.33 Y78.122 E.00357
G1 X94.654 Y77.886 E.00789
G1 X94.37 Y77.614 E.00774
G1 X94.237 Y77.536 E.00301
G1 X94.022 Y77.491 E.00434
G1 X81.982 Y77.491 E.23682
G1 X81.793 Y77.524 E.00376
G1 X81.634 Y77.61 E.00357
G1 X81.503 Y77.742 E.00365
G1 X81.414 Y77.923 E.00396
G1 X81.39 Y78.086 E.00324
G1 X81.39 Y95.116 E.33497
G1 X81.413 Y95.274 E.00314
G1 X81.475 Y95.414 E.00302
G1 X81.58 Y95.547 E.00332
G1 X81.733 Y95.653 E.00367
G1 X81.976 Y95.711 E.0049
G1 X94.022 Y95.711 E.23694
G1 X94.237 Y95.666 E.00434
G1 X94.37 Y95.588 E.00301
G1 X94.654 Y95.316 E.00773
G1 X94.33 Y95.08 E.00788
G1 X94.276 Y95.015 E.00166
G1 X94.228 Y94.911 E.00225
G1 X94.21 Y94.786 E.00249
G1 X94.21 Y88.019 E.13309
G1 X94.237 Y87.865 E.00307
G1 X94.29 Y87.767 E.00221
G1 X94.42 Y87.656 E.00335
G1 X94.583 Y87.612 E.00333
G1 X99.41 Y87.612 E.09494
G1 X99.553 Y87.646 E.00289
G1 X99.668 Y87.721 E.0027
G1 X99.734 Y87.805 E.00209
G1 X99.781 Y87.934 E.00271
G1 X99.79 Y94.783 E.13471
G1 X99.763 Y94.933 E.00301
G1 X99.692 Y95.058 E.00283
G1 X99.572 Y95.15 E.00297
G1 X99.416 Y95.19 E.00315
G1 X95.792 Y95.191 E.07129
G1 X95.788 Y95.672 E.00946
G1 X95.754 Y95.898 E.0045
G1 X95.684 Y96.111 E.00442
G1 X95.577 Y96.309 E.00442
G1 X95.439 Y96.484 E.00437
G1 X95.219 Y96.67 E.00567
G1 X95.01 Y96.785 E.0047
G1 X94.8 Y96.854 E.00434
G1 X94.488 Y96.891 E.00619
G1 X90.377 Y96.891 E.08086
G1 X90.857 Y97.411 E.01392
M73 P50 R11
G1 X91.136 Y97.772 E.00898
G1 X91.253 Y97.957 E.00431
G1 X91.441 Y98.317 E.00798
G1 X91.62 Y98.781 E.00979
G1 X91.728 Y99.22 E.00889
G1 X91.782 Y99.661 E.00873
G1 X91.784 Y100.117 E.00897
G1 X91.765 Y100.335 E.00431
G1 X91.696 Y100.735 E.00798
G1 X91.555 Y101.215 E.00985
G1 X91.473 Y101.418 E.00429
G1 X91.267 Y101.821 E.00892
G1 X91.042 Y102.159 E.00798
G1 X90.876 Y102.368 E.00525
G1 X90.562 Y102.693 E.00889
G1 X90.211 Y102.979 E.00891
G1 X90.029 Y103.102 E.00432
G1 X89.672 Y103.301 E.00804
G1 X89.429 Y103.411 E.00525
G1 X88.998 Y103.557 E.00895
G1 X88.785 Y103.609 E.00431
G1 X88.334 Y103.676 E.00897
G1 X88.116 Y103.689 E.00431
G1 X87.663 Y103.676 E.00891
G1 X87.215 Y103.608 E.00891
G1 X86.999 Y103.556 E.00437
G1 X86.786 Y103.491 E.00437
G1 X86.41 Y103.34 E.00798
G1 X85.973 Y103.103 E.00979
G1 X85.608 Y102.84 E.00883
G1 X85.277 Y102.536 E.00885
G1 X84.984 Y102.195 E.00885
G1 X84.733 Y101.821 E.00885
G1 X84.527 Y101.418 E.00891
G1 X84.445 Y101.214 E.00431
G1 X84.326 Y100.826 E.00798
G1 X84.236 Y100.337 E.00979
G1 X84.21 Y99.889 E.00883
G1 X84.239 Y99.44 E.00885
G1 X84.32 Y98.997 E.00885
G1 X84.454 Y98.564 E.00891
G1 X84.537 Y98.361 E.00431
G1 X84.722 Y98.001 E.00798
G1 X84.999 Y97.587 E.00979
G1 X85.565 Y96.936 E.01697
; WIPE_START
M204 S6000
G1 X83.565 Y96.914 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G17
G3 Z1.68 I1.217 J0 P1  F18000
;===================== date: 20250206 =====================

; don't support timelapse gcode in spiral_mode and by object sequence for I3 structure printer
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
G92 E0
G1 Z1.68
G1 X0 Y90 ; move to safe pos
G1 X-13.0 F3000 ; move to safe pos
M400
M1004 S5 P1  ; external shutter
M400 P300
M971 S11 C11 O0
G92 E0
G1 X0 F18000
M623

; SKIPTYPE: head_wrap_detect
M622.1 S1
M1002 judge_flag g39_3rd_layer_detect_flag
M622 J1
    ; enable nozzle clog detect at 3rd layer
    


    M622.1 S1
    M1002 judge_flag g39_detection_flag
    M622 J1
      
        M622.1 S0
        M1002 judge_flag g39_mass_exceed_flag
        M622 J1
        
            G392 S0
            M400
            G90
            M83
            M204 S5000
            G0 Z1.68 F4000
            G39.3 S1
            G0 Z1.68 F4000
            G392 S0
          
        M623
    
    M623
M623
; SKIPPABLE_END




G1 X81.448 Y96.237
G1 Z1.28
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.0951599
G1 F1500
M204 S6000
G1 X81.349 Y96.194 E.00037
; LINE_WIDTH: 0.149125
G1 X81.251 Y96.15 E.00066
G1 X81.102 Y96.043 E.00113
G1 X80.921 Y95.802 E.00186
; LINE_WIDTH: 0.119268
G1 X80.901 Y95.755 E.00024
; LINE_WIDTH: 0.0931054
G1 X80.863 Y95.623 E.00046
; WIPE_START
G1 X80.901 Y95.755 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X86.536 Y97.174 Z1.68 F18000
G1 Z1.28
G1 E.4 F1800
; LINE_WIDTH: 0.473055
G1 F1500
M204 S6000
G1 X86.365 Y97.318 E.00499
; LINE_WIDTH: 0.438138
G1 X86.169 Y97.487 E.00533
; LINE_WIDTH: 0.40175
G1 X85.99 Y97.669 E.00478
; LINE_WIDTH: 0.359784
G1 X85.792 Y97.872 E.00473
G1 X85.464 Y98.303 E.00903
G1 X85.216 Y98.789 E.00909
G1 X85.088 Y99.186 E.00695
G1 X85.024 Y99.536 E.00594
G1 X85.004 Y100.005 E.00783
G1 X85.068 Y100.521 E.00867
G1 X85.189 Y100.945 E.00735
G1 X85.419 Y101.42 E.00879
G1 X85.613 Y101.716 E.00589
G1 X85.939 Y102.078 E.00811
G1 X86.36 Y102.412 E.00896
G1 X86.811 Y102.653 E.00852
G1 X87.208 Y102.79 E.007
G1 X87.698 Y102.884 E.00831
G1 X88.048 Y102.895 E.00583
G1 X88.255 Y102.886 E.00346
G1 X88.597 Y102.836 E.00577
G1 X89.098 Y102.691 E.00869
G1 X89.413 Y102.543 E.0058
G1 X89.744 Y102.342 E.00646
G1 X90.026 Y102.109 E.0061
G1 X90.279 Y101.845 E.00609
G1 X90.486 Y101.578 E.00563
G1 X90.751 Y101.095 E.00918
G1 X90.925 Y100.556 E.00945
G1 X90.99 Y100.081 E.00798
G1 X90.995 Y99.89 E.00319
G1 X90.948 Y99.369 E.00871
G1 X90.864 Y99.009 E.00615
G1 X90.74 Y98.684 E.0058
G1 X90.569 Y98.36 E.00611
G1 X90.253 Y97.919 E.00903
G1 X89.992 Y97.647 E.00629
; LINE_WIDTH: 0.397595
G1 X89.807 Y97.48 E.00462
; LINE_WIDTH: 0.442746
G1 X89.622 Y97.314 E.00518
; LINE_WIDTH: 0.480586
G1 X89.38 Y97.129 E.00691
; WIPE_START
G1 X89.622 Y97.314 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X94.537 Y96.257 Z1.68 F18000
G1 Z1.28
G1 E.4 F1800
; LINE_WIDTH: 0.148837
G1 F1500
M204 S6000
G1 X94.83 Y96.099 E.00204
G1 X95.135 Y95.785 E.00269
; WIPE_START
G1 X94.83 Y96.099 E-.21588
G1 X94.537 Y96.257 E-.16412
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X96.633 Y88.918 Z1.68 F18000
G1 X97.871 Y84.584 Z1.68
G1 Z1.28
G1 E.4 F1800
; FEATURE: Bridge
; LINE_WIDTH: 0.41273
; LAYER_HEIGHT: 0.4
G1 F896.932
M204 S6000
G1 X98.58 Y83.834 E.0574
G1 X98.58 Y83.16 E.03747
G1 X97.426 Y84.381 E.09346
G1 X96.789 Y84.381 E.03541
G1 X98.58 Y82.487 E.14501
G1 X98.58 Y81.813 E.03747
G1 X96.153 Y84.381 E.19657
G1 X95.516 Y84.381 E.03541
G1 X98.58 Y81.139 E.24813
G1 X98.581 Y80.466 E.03747
G1 X95.419 Y83.809 E.25594
G1 X95.42 Y83.136 E.03747
G1 X98.581 Y79.792 E.25594
G1 X98.581 Y79.221 E.03177
G1 X98.484 Y79.221 E.00539
G1 X95.42 Y82.462 E.24809
G1 X95.42 Y81.788 E.03747
G1 X97.847 Y79.221 E.19654
G1 X97.211 Y79.22 E.03541
G1 X95.42 Y81.115 E.14499
G1 X95.42 Y80.441 E.03747
G1 X96.574 Y79.22 E.09344
G1 X95.937 Y79.22 E.03541
G1 X95.217 Y79.982 E.05829
; WIPE_START
G1 X95.937 Y79.22 E-.1991
G1 X96.574 Y79.22 E-.12095
G1 X96.357 Y79.45 E-.05995
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X95.142 Y77.444 Z1.68 F18000
G1 Z1.28
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.151877
; LAYER_HEIGHT: 0.12
G1 F1500
M204 S6000
G1 X94.947 Y77.209 E.00192
G1 X94.771 Y77.061 E.00144
; LINE_WIDTH: 0.12977
G1 X94.534 Y76.949 E.00136
; WIPE_START
G1 X94.771 Y77.061 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X87.139 Y77 Z1.68 F18000
G1 X81.496 Y76.955 Z1.68
G1 Z1.28
G1 E.4 F1800
; LINE_WIDTH: 0.0812041
G1 F1500
M204 S6000
G1 X81.464 Y76.963 E.00009
; LINE_WIDTH: 0.0957245
G1 X81.377 Y76.995 E.00032
; LINE_WIDTH: 0.131757
G1 X81.193 Y77.082 E.00108
; LINE_WIDTH: 0.152959
G1 X80.963 Y77.32 E.0021
G1 X80.912 Y77.423 E.00073
; LINE_WIDTH: 0.101936
G1 X80.854 Y77.604 E.00072
; CHANGE_LAYER
; Z_HEIGHT: 1.4
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F1500
G1 X80.912 Y77.423 E-.38
; WIPE_END
G1 E-.02 F1800
; layer num/total_layer_count: 11/49
; update layer progress
M73 L11
M991 S0 P10 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z1.68 I-.897 J.822 P1  F18000
G1 X95.29 Y93.111 Z1.68
G1 Z1.4
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
M73 P51 R11
G1 F1500
M204 S500
G1 X95.29 Y89.691 E.06727
G1 X98.71 Y89.691 E.06727
G1 X98.71 Y93.111 E.06727
G1 X95.35 Y93.111 E.06609
; WIPE_START
M204 S6000
G1 X95.315 Y91.111 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X89.835 Y96.424 Z1.8 F18000
G1 X89.161 Y97.078 Z1.8
G1 Z1.4
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X88.604 Y96.915 E.01227
G1 X88.228 Y96.864 E.00804
G1 X87.848 Y96.858 E.00804
G1 X87.337 Y96.928 E.0109
G1 X86.973 Y97.034 E.00803
G1 X86.772 Y97.12 E.00462
G1 X86.653 Y96.956 E.00429
G1 X87.011 Y96.544 E.01155
G1 X88.922 Y96.544 E.04046
G1 X89.263 Y96.913 E.01063
G1 X89.192 Y97.027 E.00283
; WIPE_START
M204 S6000
G1 X88.604 Y96.915 E-.11376
G1 X88.228 Y96.864 E-.07221
G1 X87.848 Y96.858 E-.0722
G1 X87.337 Y96.928 E-.09788
G1 X87.216 Y96.963 E-.02395
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X90.617 Y99.845 Z1.8 F18000
G1 Z1.4
G1 E.4 F1800
G1 F1500
M204 S500
G1 X90.622 Y99.903 E.00125
G1 X90.574 Y100.39 E.01034
G1 X90.504 Y100.674 E.00621
G1 X90.391 Y100.975 E.00681
G1 X90.166 Y101.378 E.00975
G1 X89.868 Y101.741 E.00995
G1 X89.516 Y102.039 E.00975
G1 X89.243 Y102.208 E.0068
G1 X88.977 Y102.332 E.00621
G1 X88.509 Y102.473 E.01034
G1 X88.048 Y102.521 E.00981
G1 X87.727 Y102.507 E.0068
G1 X87.438 Y102.46 E.00621
G1 X86.972 Y102.313 E.01033
G1 X86.556 Y102.089 E.01
G1 X86.188 Y101.796 E.00995
G1 X85.885 Y101.449 E.00975
G1 X85.712 Y101.178 E.0068
G1 X85.584 Y100.914 E.00621
G1 X85.436 Y100.449 E.01034
G1 X85.379 Y99.979 E.01
G1 X85.407 Y99.519 E.00975
G1 X85.474 Y99.205 E.00681
G1 X85.568 Y98.927 E.00621
G1 X85.789 Y98.492 E.01034
G1 X86.078 Y98.118 E.01
G1 X86.427 Y97.803 E.00995
G1 X86.819 Y97.561 E.00975
G1 X87.116 Y97.434 E.00683
G1 X87.426 Y97.344 E.00682
G1 X87.873 Y97.283 E.00956
G1 X88.196 Y97.288 E.00683
G1 X88.516 Y97.331 E.00683
G1 X88.949 Y97.458 E.00955
G1 X89.242 Y97.593 E.00683
G1 X89.516 Y97.763 E.00683
G1 X89.868 Y98.061 E.00975
G1 X90.168 Y98.426 E.01
G1 X90.402 Y98.855 E.01034
G1 X90.504 Y99.13 E.00621
G1 X90.58 Y99.442 E.0068
G1 X90.611 Y99.785 E.00728
M204 S250
G1 X90.209 Y99.881 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X90.211 Y99.902 E.0004
G1 X90.17 Y100.32 E.00826
G1 X90.112 Y100.553 E.00472
G1 X90.018 Y100.803 E.00526
G1 X89.827 Y101.146 E.00774
G1 X89.575 Y101.452 E.0078
G1 X89.275 Y101.707 E.00774
G1 X89.048 Y101.847 E.00525
G1 X88.83 Y101.949 E.00472
G1 X88.428 Y102.07 E.00826
G1 X88.036 Y102.111 E.00775
G1 X87.769 Y102.099 E.00525
G1 X87.533 Y102.061 E.00472
G1 X87.132 Y101.934 E.00826
G1 X86.782 Y101.746 E.00781
G1 X86.472 Y101.499 E.0078
G1 X86.213 Y101.203 E.00774
G1 X86.07 Y100.978 E.00525
G1 X85.965 Y100.762 E.00472
G1 X85.838 Y100.361 E.00826
G1 X85.79 Y99.967 E.00781
G1 X85.814 Y99.574 E.00774
G1 X85.869 Y99.313 E.00526
G1 X85.946 Y99.086 E.00472
G1 X86.136 Y98.711 E.00826
G1 X86.379 Y98.397 E.00781
G1 X86.674 Y98.132 E.0078
G1 X87.008 Y97.925 E.00773
G1 X87.254 Y97.82 E.00526
G1 X87.511 Y97.745 E.00526
G1 X87.898 Y97.693 E.00767
G1 X88.165 Y97.697 E.00526
G1 X88.43 Y97.733 E.00526
G1 X88.805 Y97.842 E.00767
G1 X89.047 Y97.954 E.00526
G1 X89.275 Y98.095 E.00526
G1 X89.575 Y98.349 E.00773
G1 X89.827 Y98.656 E.00781
G1 X90.029 Y99.025 E.00826
G1 X90.112 Y99.25 E.00472
G1 X90.176 Y99.509 E.00525
G1 X90.204 Y99.822 E.00617
; WIPE_START
M204 S6000
G1 X90.211 Y99.902 E-.01529
G1 X90.17 Y100.32 E-.07983
G1 X90.112 Y100.553 E-.04557
G1 X90.018 Y100.803 E-.05077
G1 X89.827 Y101.146 E-.07473
G1 X89.575 Y101.452 E-.0753
G1 X89.42 Y101.584 E-.03852
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X95.377 Y96.811 Z1.8 F18000
G1 X98.955 Y93.944 Z1.8
G1 Z1.4
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X98.956 Y94.357 E.00872
G1 X95.043 Y94.358 E.08281
G1 X95.043 Y93.944 E.00875
G1 X98.895 Y93.944 E.08153
; WIPE_START
M204 S6000
G1 X98.956 Y94.357 E-.07915
G1 X97.373 Y94.357 E-.30085
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X95.29 Y88.857 Z1.8 F18000
G1 Z1.4
G1 E.4 F1800
G1 F1500
M204 S500
G1 X95.043 Y88.857 E.00522
G1 X95.043 Y88.445 E.00872
G1 X98.948 Y88.445 E.08265
G1 X98.949 Y88.857 E.00872
G1 X95.35 Y88.857 E.07617
; WIPE_START
M204 S6000
G1 X95.043 Y88.857 E-.05824
G1 X95.043 Y88.445 E-.07829
G1 X96.325 Y88.445 E-.24348
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X98.343 Y81.084 Z1.8 F18000
G1 X98.956 Y78.845 Z1.8
G1 Z1.4
G1 E.4 F1800
G1 F1500
M204 S500
G1 X98.956 Y84.757 E.12513
G1 X95.044 Y84.756 E.0828
G1 X95.044 Y78.844 E.12514
G1 X98.896 Y78.845 E.08153
; WIPE_START
M204 S6000
G1 X98.916 Y80.845 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X94.164 Y86.817 Z1.8 F18000
G1 X86.761 Y96.12 Z1.8
G1 Z1.4
G1 E.4 F1800
G1 F1500
M204 S500
G1 X94.064 Y96.12 E.15458
G1 X94.387 Y96.052 E.00698
G1 X94.618 Y95.917 E.00566
G1 X95.29 Y95.274 E.01969
G1 X94.619 Y94.784 E.01758
G1 X94.619 Y88.021 E.14315
G1 X99.372 Y88.021 E.10059
G1 X99.374 Y89.282 E.02668
G1 X94.881 Y89.282 E.09509
G1 X94.881 Y93.52 E.08971
G1 X99.119 Y93.52 E.08971
G1 X99.119 Y89.35 E.08827
G1 X99.374 Y89.349 E.00538
G1 X99.381 Y94.781 E.11496
G1 X95.386 Y94.782 E.08455
G1 X95.379 Y95.64 E.01817
G1 X95.355 Y95.804 E.00349
G1 X95.307 Y95.949 E.00324
G1 X95.234 Y96.084 E.00324
G1 X95.144 Y96.198 E.00308
G1 X94.987 Y96.33 E.00434
G1 X94.846 Y96.408 E.00342
G1 X94.711 Y96.453 E.00299
G1 X94.464 Y96.482 E.00527
G1 X89.442 Y96.482 E.1063
G1 X90.544 Y97.675 E.03439
G1 X90.8 Y98.008 E.00888
G1 X91.066 Y98.482 E.0115
G1 X91.229 Y98.904 E.00959
G1 X91.355 Y99.49 E.01268
G1 X91.374 Y100.1 E.01292
G1 X91.297 Y100.637 E.0115
G1 X91.17 Y101.073 E.00962
G1 X90.916 Y101.609 E.01255
G1 X90.568 Y102.099 E.01271
G1 X90.284 Y102.392 E.00864
G1 X90.005 Y102.621 E.00764
G1 X89.812 Y102.755 E.00498
G1 X89.491 Y102.933 E.00776
G1 X89.278 Y103.03 E.00495
G1 X88.884 Y103.164 E.00882
G1 X88.292 Y103.269 E.01273
G1 X87.699 Y103.267 E.01254
G1 X87.107 Y103.161 E.01273
G1 X86.589 Y102.971 E.01169
G1 X86.19 Y102.755 E.00959
G1 X85.867 Y102.522 E.00843
G1 X85.571 Y102.251 E.00849
G1 X85.31 Y101.946 E.0085
G1 X85.086 Y101.613 E.00849
G1 X84.831 Y101.078 E.01256
G1 X84.726 Y100.733 E.00763
G1 X84.643 Y100.288 E.00958
G1 X84.62 Y99.89 E.00843
G1 X84.645 Y99.49 E.00849
G1 X84.718 Y99.095 E.0085
G1 X84.909 Y98.533 E.01256
G1 X85.074 Y98.213 E.00763
G1 X85.325 Y97.836 E.00959
G1 X86.503 Y96.482 E.03799
G1 X81.536 Y96.482 E.10513
G1 X81.289 Y96.453 E.00527
G1 X81.144 Y96.405 E.00324
G1 X80.982 Y96.311 E.00394
G1 X80.87 Y96.211 E.00319
G1 X80.728 Y96.018 E.00507
G1 X80.649 Y95.821 E.00449
G1 X80.619 Y95.565 E.00546
G1 X80.619 Y77.627 E.37968
G1 X80.656 Y77.355 E.00581
G1 X80.716 Y77.205 E.0034
G1 X80.791 Y77.081 E.00308
G1 X80.975 Y76.896 E.00552
G1 X81.192 Y76.777 E.00523
G1 X81.452 Y76.723 E.00561
G1 X94.482 Y76.721 E.27579
G1 X94.701 Y76.747 E.00467
G1 X94.902 Y76.821 E.00453
G1 X95.017 Y76.892 E.00286
G1 X95.178 Y77.044 E.00469
G1 X95.256 Y77.154 E.00286
G1 X95.343 Y77.358 E.00469
G1 X95.372 Y77.498 E.00304
G1 X95.397 Y78.42 E.01951
G1 X99.381 Y78.421 E.08431
G1 X99.38 Y85.182 E.14309
G1 X94.619 Y85.181 E.10076
G1 X94.62 Y78.417 E.14317
G1 X95.29 Y77.928 E.01755
G1 X94.618 Y77.285 E.01969
G1 X94.387 Y77.149 E.00567
G1 X94.064 Y77.082 E.00698
G1 X81.953 Y77.082 E.25635
G1 X81.688 Y77.122 E.00567
G1 X81.391 Y77.274 E.00706
G1 X81.165 Y77.502 E.00679
G1 X81.018 Y77.799 E.00701
G1 X80.981 Y78.056 E.00549
G1 X80.981 Y95.146 E.36173
G1 X81.016 Y95.386 E.00514
G1 X81.114 Y95.612 E.00522
G1 X81.261 Y95.81 E.00522
G1 X81.48 Y95.984 E.00591
G1 X81.715 Y96.085 E.00542
G1 X81.955 Y96.12 E.00514
G1 X86.701 Y96.12 E.10045
; WIPE_START
M204 S6000
G1 X88.701 Y96.12 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X85.604 Y96.891 Z1.8 F18000
G1 Z1.4
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X81.512 Y96.891 E.08049
G1 X81.2 Y96.854 E.00619
G1 X80.986 Y96.784 E.00442
G1 X80.855 Y96.718 E.00289
G1 X80.732 Y96.637 E.00289
G1 X80.565 Y96.488 E.0044
G1 X80.374 Y96.227 E.00637
G1 X80.247 Y95.904 E.00682
G1 X80.21 Y95.589 E.00625
G1 X80.21 Y77.61 E.35363
G1 X80.228 Y77.392 E.0043
G1 X80.264 Y77.233 E.0032
G1 X80.348 Y77.022 E.00447
G1 X80.457 Y76.843 E.00412
G1 X80.561 Y76.718 E.0032
G1 X80.73 Y76.567 E.00446
G1 X80.924 Y76.447 E.00448
G1 X81.057 Y76.39 E.00284
G1 X81.261 Y76.334 E.00418
G1 X81.426 Y76.313 E.00326
G1 X94.507 Y76.311 E.25729
G1 X94.797 Y76.347 E.00575
G1 X95.081 Y76.45 E.00595
G1 X95.267 Y76.565 E.0043
G1 X95.489 Y76.775 E.006
G1 X95.615 Y76.954 E.0043
G1 X95.736 Y77.234 E.006
G1 X95.78 Y77.451 E.00436
G1 X95.796 Y78.011 E.01101
M73 P52 R11
G1 X99.416 Y78.012 E.0712
G1 X99.515 Y78.03 E.00199
G1 X99.613 Y78.076 E.00212
G1 X99.699 Y78.154 E.00228
G1 X99.747 Y78.227 E.00171
G1 X99.79 Y78.413 E.00377
G1 X99.789 Y85.215 E.13379
G1 X99.766 Y85.33 E.0023
G1 X99.724 Y85.415 E.00188
G1 X99.669 Y85.481 E.00169
G1 X99.572 Y85.549 E.00233
G1 X99.388 Y85.591 E.00371
G1 X94.584 Y85.59 E.09449
G1 X94.406 Y85.537 E.00365
G1 X94.277 Y85.417 E.00346
G1 X94.229 Y85.312 E.00227
G1 X94.21 Y85.185 E.00252
G1 X94.211 Y78.385 E.13377
G1 X94.227 Y78.293 E.00182
G1 X94.276 Y78.187 E.00231
G1 X94.33 Y78.122 E.00166
G1 X94.654 Y77.886 E.00789
G1 X94.369 Y77.614 E.00774
G1 X94.237 Y77.536 E.00301
G1 X94.022 Y77.491 E.00433
G1 X81.984 Y77.491 E.23677
G1 X81.815 Y77.517 E.00336
G1 X81.635 Y77.608 E.00397
G1 X81.503 Y77.743 E.00371
G1 X81.414 Y77.923 E.00395
G1 X81.39 Y78.086 E.00324
G1 X81.39 Y95.116 E.33498
G1 X81.413 Y95.273 E.00313
G1 X81.47 Y95.407 E.00285
G1 X81.557 Y95.523 E.00285
G1 X81.691 Y95.629 E.00337
G1 X81.827 Y95.688 E.00292
G1 X81.985 Y95.711 E.00313
G1 X94.022 Y95.711 E.23676
G1 X94.237 Y95.666 E.00433
G1 X94.369 Y95.588 E.00301
G1 X94.654 Y95.316 E.00774
G1 X94.331 Y95.08 E.00787
G1 X94.272 Y95.009 E.00182
G1 X94.228 Y94.912 E.0021
G1 X94.21 Y94.786 E.0025
G1 X94.21 Y88.016 E.13315
G1 X94.228 Y87.893 E.00245
G1 X94.293 Y87.764 E.00283
G1 X94.422 Y87.655 E.00332
G1 X94.583 Y87.612 E.00329
G1 X99.41 Y87.612 E.09494
G1 X99.554 Y87.646 E.0029
G1 X99.663 Y87.716 E.00255
G1 X99.734 Y87.805 E.00225
G1 X99.781 Y87.934 E.00269
G1 X99.79 Y94.783 E.13471
G1 X99.763 Y94.933 E.00301
G1 X99.693 Y95.055 E.00277
G1 X99.575 Y95.149 E.00297
G1 X99.416 Y95.19 E.00322
G1 X95.792 Y95.191 E.07129
G1 X95.788 Y95.672 E.00946
G1 X95.754 Y95.898 E.0045
G1 X95.684 Y96.111 E.00442
G1 X95.577 Y96.309 E.00442
G1 X95.439 Y96.484 E.00437
G1 X95.221 Y96.669 E.00564
G1 X95.01 Y96.785 E.00473
G1 X94.8 Y96.854 E.00434
G1 X94.488 Y96.891 E.00619
G1 X90.377 Y96.891 E.08086
G1 X90.857 Y97.411 E.01393
G1 X91.136 Y97.772 E.00897
G1 X91.253 Y97.957 E.00431
G1 X91.439 Y98.312 E.00789
G1 X91.62 Y98.781 E.00988
G1 X91.728 Y99.22 E.00889
G1 X91.782 Y99.661 E.00873
G1 X91.784 Y100.117 E.00897
G1 X91.765 Y100.335 E.00432
G1 X91.697 Y100.73 E.00788
G1 X91.555 Y101.213 E.00989
G1 X91.396 Y101.58 E.00787
G1 X91.268 Y101.82 E.00535
G1 X91.045 Y102.155 E.00793
G1 X90.876 Y102.368 E.00534
G1 X90.562 Y102.693 E.0089
G1 X90.252 Y102.948 E.00789
G1 X90.028 Y103.102 E.00535
G1 X89.676 Y103.299 E.00793
G1 X89.429 Y103.411 E.00534
G1 X88.998 Y103.557 E.00895
G1 X88.785 Y103.609 E.00431
G1 X88.334 Y103.676 E.00897
G1 X88.116 Y103.689 E.00431
G1 X87.663 Y103.676 E.00891
G1 X87.215 Y103.608 E.00891
G1 X86.999 Y103.556 E.00437
G1 X86.786 Y103.491 E.00437
G1 X86.414 Y103.342 E.00788
G1 X85.972 Y103.102 E.00988
G1 X85.608 Y102.84 E.00883
G1 X85.277 Y102.536 E.00885
G1 X84.983 Y102.195 E.00885
G1 X84.733 Y101.821 E.00885
G1 X84.527 Y101.417 E.00891
G1 X84.445 Y101.214 E.00431
G1 X84.327 Y100.831 E.00789
G1 X84.236 Y100.337 E.00988
G1 X84.21 Y99.889 E.00883
G1 X84.239 Y99.44 E.00885
G1 X84.32 Y98.997 E.00885
G1 X84.454 Y98.564 E.00891
G1 X84.537 Y98.361 E.00431
G1 X84.72 Y98.005 E.00789
G1 X84.999 Y97.587 E.00988
G1 X85.565 Y96.936 E.01696
; WIPE_START
M204 S6000
G1 X83.565 Y96.914 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G17
G3 Z1.8 I1.217 J0 P1  F18000
;===================== date: 20250206 =====================

; don't support timelapse gcode in spiral_mode and by object sequence for I3 structure printer
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
G92 E0
G1 Z1.8
G1 X0 Y90 ; move to safe pos
G1 X-13.0 F3000 ; move to safe pos
M400
M1004 S5 P1  ; external shutter
M400 P300
M971 S11 C11 O0
G92 E0
G1 X0 F18000
M623

; SKIPTYPE: head_wrap_detect
M622.1 S1
M1002 judge_flag g39_3rd_layer_detect_flag
M622 J1
    ; enable nozzle clog detect at 3rd layer
    


    M622.1 S1
    M1002 judge_flag g39_detection_flag
    M622 J1
      
        M622.1 S0
        M1002 judge_flag g39_mass_exceed_flag
        M622 J1
        
            G392 S0
            M400
            G90
            M83
            M204 S5000
            G0 Z1.8 F4000
            G39.3 S1
            G0 Z1.8 F4000
            G392 S0
          
        M623
    
    M623
M623
; SKIPPABLE_END




G1 X81.475 Y96.238
G1 Z1.4
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.0954297
G1 F1500
M204 S6000
G1 X81.343 Y96.201 E.00048
; LINE_WIDTH: 0.131168
G1 X81.25 Y96.151 E.00055
; LINE_WIDTH: 0.152708
G1 X81.067 Y96.011 E.00146
G1 X80.848 Y95.676 E.00253
M204 S10000
G1 X80.863 Y95.626 F18000
; LINE_WIDTH: 0.098658
G1 F1500
M204 S6000
G1 X80.999 Y96.028 E.00154
; WIPE_START
G1 X80.863 Y95.626 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X86.544 Y97.167 Z1.8 F18000
G1 Z1.4
G1 E.4 F1800
; LINE_WIDTH: 0.475194
G1 F1500
M204 S6000
G1 X86.369 Y97.315 E.00513
; LINE_WIDTH: 0.438822
G1 X86.169 Y97.487 E.00545
; LINE_WIDTH: 0.401772
G1 X85.99 Y97.669 E.00478
; LINE_WIDTH: 0.35998
G1 X85.792 Y97.872 E.00474
G1 X85.464 Y98.304 E.00904
G1 X85.215 Y98.792 E.00913
G1 X85.088 Y99.186 E.0069
G1 X85.024 Y99.536 E.00594
G1 X85.004 Y100.005 E.00783
G1 X85.066 Y100.513 E.00853
G1 X85.191 Y100.944 E.00749
G1 X85.388 Y101.371 E.00783
G1 X85.59 Y101.686 E.00624
G1 X85.846 Y101.985 E.00657
G1 X86.11 Y102.224 E.00593
G1 X86.392 Y102.432 E.00586
G1 X86.812 Y102.653 E.0079
G1 X87.208 Y102.79 E.007
G1 X87.733 Y102.888 E.0089
G1 X88.255 Y102.886 E.0087
G1 X88.598 Y102.836 E.00577
G1 X89.124 Y102.682 E.00914
G1 X89.431 Y102.535 E.00567
G1 X89.746 Y102.334 E.00623
G1 X90.146 Y101.994 E.00876
G1 X90.469 Y101.602 E.00847
G1 X90.728 Y101.145 E.00876
G1 X90.86 Y100.795 E.00624
G1 X90.946 Y100.442 E.00606
G1 X90.996 Y99.92 E.00873
G1 X90.952 Y99.393 E.00882
G1 X90.866 Y99.016 E.00644
G1 X90.718 Y98.639 E.00675
G1 X90.486 Y98.229 E.00785
G1 X90.128 Y97.784 E.00953
; LINE_WIDTH: 0.37579
G1 X89.948 Y97.612 E.00434
; LINE_WIDTH: 0.40846
G1 X89.742 Y97.416 E.00543
; LINE_WIDTH: 0.445785
G1 X89.561 Y97.272 E.00486
; LINE_WIDTH: 0.479746
G1 X89.38 Y97.127 E.00525
; WIPE_START
G1 X89.561 Y97.272 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X94.537 Y96.257 Z1.8 F18000
G1 Z1.4
G1 E.4 F1800
; LINE_WIDTH: 0.148765
G1 F1500
M204 S6000
G1 X94.831 Y96.098 E.00205
G1 X95.135 Y95.786 E.00268
; WIPE_START
G1 X94.831 Y96.098 E-.21523
G1 X94.537 Y96.257 E-.16477
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X95.122 Y88.647 Z1.8 F18000
G1 X95.453 Y84.347 Z1.8
G1 Z1.4
G1 E.4 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.419992
G1 F1500
M204 S6000
G1 X98.546 Y84.348 E.06085
G1 X98.547 Y79.254 E.10018
G1 X95.454 Y79.253 E.06085
G1 X95.453 Y84.287 E.09901
M204 S10000
G1 X95.847 Y83.953 F18000
G1 F1500
M204 S6000
G1 X98.152 Y83.954 E.04534
G1 X98.153 Y79.648 E.08468
G1 X95.848 Y79.648 E.04534
G1 X95.847 Y83.893 E.0835
M204 S10000
G1 X96.241 Y83.559 F18000
G1 F1500
M204 S6000
G1 X97.758 Y83.559 E.02983
G1 X97.759 Y80.043 E.06917
G1 X96.242 Y80.042 E.02983
G1 X96.241 Y83.499 E.06799
M204 S10000
G1 X96.636 Y83.165 F18000
G1 F1500
M204 S6000
G1 X97.364 Y83.165 E.01432
G1 X97.364 Y80.437 E.05366
G1 X96.636 Y80.437 E.01432
G1 X96.636 Y83.105 E.05248
M204 S10000
G1 X97 Y82.801 F18000
; LINE_WIDTH: 0.359632
G1 F1500
M204 S6000
G1 X97 Y80.861 E.03232
; WIPE_START
G1 X97 Y82.801 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X95.145 Y77.438 Z1.8 F18000
G1 Z1.4
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.148017
G1 F1500
M204 S6000
G1 X94.845 Y77.115 E.00269
G1 X94.783 Y77.067 E.00048
G1 X94.533 Y76.949 E.00168
; WIPE_START
G1 X94.783 Y77.067 E-.13171
G1 X94.845 Y77.115 E-.03774
G1 X95.145 Y77.438 E-.21055
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X87.517 Y77.168 Z1.8 F18000
G1 X81.503 Y76.955 Z1.8
G1 Z1.4
G1 E.4 F1800
; LINE_WIDTH: 0.0817722
G1 F1500
M204 S6000
G1 X81.468 Y76.964 E.0001
; LINE_WIDTH: 0.096651
G1 X81.375 Y76.997 E.00035
; LINE_WIDTH: 0.127137
G1 X81.225 Y77.062 E.00083
; LINE_WIDTH: 0.152023
G1 X81.065 Y77.199 E.00132
G1 X80.958 Y77.328 E.00106
G1 X80.908 Y77.431 E.00072
; LINE_WIDTH: 0.102129
G1 X80.856 Y77.599 E.00067
; CHANGE_LAYER
; Z_HEIGHT: 1.52
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F1500
G1 X80.908 Y77.431 E-.38
; WIPE_END
G1 E-.02 F1800
; layer num/total_layer_count: 12/49
; update layer progress
M73 L12
M991 S0 P11 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z1.8 I-.909 J.81 P1  F18000
G1 X94.881 Y93.111 Z1.8
G1 Z1.52
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X94.881 Y89.282 E.08105
G1 X99.119 Y89.282 E.08971
G1 X99.119 Y93.52 E.08971
G1 X94.881 Y93.52 E.08971
G1 X94.881 Y93.171 E.00739
M204 S250
G1 X95.29 Y93.111 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X95.29 Y89.691 E.06727
G1 X98.71 Y89.691 E.06727
G1 X98.71 Y93.111 E.06727
G1 X95.35 Y93.111 E.06609
; WIPE_START
M204 S6000
G1 X95.315 Y91.111 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X95.29 Y88.857 Z1.92 F18000
G1 Z1.52
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X95.043 Y88.857 E.00522
G1 X95.043 Y88.445 E.00872
G1 X98.957 Y88.445 E.08282
G1 X98.957 Y88.857 E.00872
G1 X95.35 Y88.857 E.07634
; WIPE_START
M204 S6000
G1 X95.043 Y88.857 E-.05824
G1 X95.043 Y88.445 E-.07829
G1 X96.325 Y88.445 E-.24348
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X98.957 Y93.944 Z1.92 F18000
G1 Z1.52
G1 E.4 F1800
G1 F1500
M204 S500
G1 X98.957 Y94.357 E.00872
G1 X95.043 Y94.358 E.08282
G1 X95.043 Y93.944 E.00875
G1 X98.897 Y93.944 E.08155
; WIPE_START
M204 S6000
G1 X98.957 Y94.357 E-.07914
G1 X97.373 Y94.357 E-.30086
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X90.129 Y96.759 Z1.92 F18000
G1 X89.159 Y97.081 Z1.92
G1 Z1.52
G1 E.4 F1800
G1 F1500
M204 S500
G1 X88.766 Y96.954 E.00873
G1 X88.393 Y96.88 E.00805
G1 X87.863 Y96.856 E.01123
G1 X87.322 Y96.93 E.01157
G1 X86.766 Y97.11 E.01238
G1 X86.659 Y96.949 E.0041
G1 X87.011 Y96.544 E.01135
G1 X88.922 Y96.544 E.04045
G1 X89.265 Y96.915 E.01069
G1 X89.191 Y97.031 E.00289
; WIPE_START
M204 S6000
G1 X88.766 Y96.954 E-.08202
M73 P53 R11
G1 X88.393 Y96.88 E-.07222
G1 X87.863 Y96.856 E-.1008
G1 X87.322 Y96.93 E-.10383
G1 X87.216 Y96.964 E-.02113
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X90.616 Y99.841 Z1.92 F18000
G1 Z1.52
G1 E.4 F1800
G1 F1500
M204 S500
G1 X90.622 Y99.898 E.00121
G1 X90.579 Y100.372 E.01007
G1 X90.445 Y100.844 E.01039
G1 X90.325 Y101.109 E.00616
G1 X90.16 Y101.385 E.00681
G1 X89.868 Y101.741 E.00975
G1 X89.516 Y102.039 E.00975
G1 X89.243 Y102.208 E.0068
G1 X88.979 Y102.331 E.00616
G1 X88.509 Y102.473 E.01039
G1 X88.048 Y102.521 E.00981
G1 X87.726 Y102.507 E.00683
G1 X87.408 Y102.454 E.00684
G1 X86.97 Y102.312 E.00975
G1 X86.556 Y102.089 E.00995
G1 X86.188 Y101.796 E.00995
G1 X85.885 Y101.449 E.00975
G1 X85.712 Y101.178 E.0068
G1 X85.585 Y100.917 E.00616
G1 X85.436 Y100.449 E.01039
G1 X85.379 Y99.979 E.01001
G1 X85.407 Y99.519 E.00975
G1 X85.474 Y99.205 E.0068
G1 X85.567 Y98.929 E.00616
G1 X85.789 Y98.492 E.01039
G1 X86.08 Y98.115 E.01007
G1 X86.448 Y97.79 E.01039
G1 X86.691 Y97.631 E.00616
G1 X86.979 Y97.487 E.00681
G1 X87.417 Y97.345 E.00975
G1 X87.882 Y97.282 E.00995
G1 X88.343 Y97.302 E.00975
G1 X88.659 Y97.365 E.00683
G1 X88.957 Y97.462 E.00664
G1 X89.242 Y97.593 E.00663
G1 X89.516 Y97.763 E.00684
G1 X89.868 Y98.061 E.00975
G1 X90.166 Y98.424 E.00995
G1 X90.391 Y98.826 E.00975
G1 X90.503 Y99.127 E.0068
G1 X90.574 Y99.41 E.00616
G1 X90.61 Y99.782 E.00791
M204 S250
G1 X90.209 Y99.882 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X90.211 Y99.9 E.00036
G1 X90.175 Y100.297 E.00783
G1 X90.059 Y100.703 E.00831
G1 X89.962 Y100.919 E.00467
G1 X89.825 Y101.149 E.00525
G1 X89.575 Y101.452 E.00773
G1 X89.275 Y101.707 E.00773
G1 X89.048 Y101.847 E.00525
G1 X88.833 Y101.948 E.00467
G1 X88.428 Y102.07 E.00831
G1 X88.036 Y102.111 E.00775
G1 X87.769 Y102.099 E.00526
G1 X87.505 Y102.055 E.00527
G1 X87.131 Y101.934 E.00773
G1 X86.782 Y101.746 E.0078
G1 X86.472 Y101.499 E.00779
G1 X86.213 Y101.203 E.00774
G1 X86.07 Y100.978 E.00525
G1 X85.966 Y100.764 E.00467
G1 X85.838 Y100.362 E.00831
G1 X85.79 Y99.967 E.00782
G1 X85.814 Y99.574 E.00774
G1 X85.869 Y99.313 E.00525
G1 X85.945 Y99.088 E.00467
G1 X86.136 Y98.712 E.00831
G1 X86.38 Y98.396 E.00784
G1 X86.696 Y98.116 E.00831
G1 X86.895 Y97.986 E.00467
G1 X87.134 Y97.867 E.00526
G1 X87.508 Y97.745 E.00773
G1 X87.901 Y97.692 E.0078
G1 X88.294 Y97.71 E.00773
G1 X88.556 Y97.762 E.00526
G1 X88.808 Y97.843 E.0052
G1 X89.047 Y97.954 E.0052
G1 X89.275 Y98.095 E.00527
G1 X89.575 Y98.349 E.00773
G1 X89.827 Y98.655 E.0078
G1 X90.018 Y98.999 E.00773
G1 X90.112 Y99.249 E.00525
G1 X90.169 Y99.479 E.00467
G1 X90.203 Y99.822 E.00677
; WIPE_START
M204 S6000
G1 X90.211 Y99.9 E-.01489
G1 X90.175 Y100.297 E-.07566
G1 X90.059 Y100.703 E-.08029
G1 X89.962 Y100.919 E-.04513
G1 X89.825 Y101.149 E-.05075
G1 X89.575 Y101.452 E-.0747
G1 X89.42 Y101.584 E-.03857
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X92.372 Y94.545 Z1.92 F18000
G1 X98.956 Y78.845 Z1.92
G1 Z1.52
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X98.956 Y84.757 E.12513
G1 X95.044 Y84.756 E.0828
G1 X95.044 Y78.844 E.12514
G1 X98.896 Y78.845 E.08153
; WIPE_START
M204 S6000
G1 X98.916 Y80.845 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X94.164 Y86.817 Z1.92 F18000
G1 X86.761 Y96.12 Z1.92
G1 Z1.52
G1 E.4 F1800
G1 F1500
M204 S500
G1 X94.064 Y96.12 E.15458
G1 X94.387 Y96.053 E.00697
G1 X94.617 Y95.917 E.00566
G1 X95.291 Y95.274 E.01971
G1 X94.619 Y94.784 E.01759
G1 X94.619 Y88.021 E.14315
G1 X99.381 Y88.021 E.10078
G1 X99.381 Y94.781 E.14307
G1 X95.386 Y94.782 E.08455
G1 X95.379 Y95.64 E.01817
G1 X95.355 Y95.804 E.00349
G1 X95.307 Y95.949 E.00324
G1 X95.234 Y96.084 E.00324
G1 X95.143 Y96.198 E.00308
G1 X94.988 Y96.33 E.0043
G1 X94.845 Y96.408 E.00346
G1 X94.711 Y96.453 E.00299
G1 X94.464 Y96.482 E.00527
G1 X89.441 Y96.482 E.1063
G1 X90.544 Y97.675 E.03439
G1 X90.8 Y98.008 E.00889
G1 X91.064 Y98.478 E.0114
G1 X91.229 Y98.904 E.00969
G1 X91.355 Y99.49 E.01267
G1 X91.374 Y100.1 E.01292
G1 X91.287 Y100.686 E.01254
G1 X91.168 Y101.079 E.00869
G1 X90.913 Y101.614 E.01256
G1 X90.568 Y102.099 E.01258
G1 X90.285 Y102.391 E.00862
G1 X89.967 Y102.65 E.00869
G1 X89.643 Y102.855 E.0081
G1 X89.273 Y103.032 E.00869
G1 X88.884 Y103.163 E.00869
G1 X88.292 Y103.269 E.01273
G1 X87.699 Y103.267 E.01254
G1 X87.107 Y103.161 E.01273
G1 X86.544 Y102.951 E.01273
G1 X86.193 Y102.757 E.00849
G1 X85.867 Y102.522 E.0085
G1 X85.571 Y102.251 E.00849
G1 X85.31 Y101.946 E.0085
G1 X85.086 Y101.613 E.00849
G1 X84.832 Y101.079 E.01253
G1 X84.71 Y100.677 E.00889
G1 X84.63 Y100.144 E.01141
G1 X84.627 Y99.686 E.00968
G1 X84.676 Y99.291 E.00843
G1 X84.771 Y98.901 E.00849
G1 X84.913 Y98.526 E.00849
G1 X85.097 Y98.17 E.00849
G1 X85.323 Y97.838 E.00849
G1 X86.503 Y96.482 E.03805
G1 X81.536 Y96.482 E.10513
G1 X81.298 Y96.454 E.00508
G1 X81.092 Y96.379 E.00463
G1 X81.011 Y96.331 E.002
G1 X80.832 Y96.173 E.00504
G1 X80.736 Y96.035 E.00356
G1 X80.648 Y95.814 E.00504
G1 X80.619 Y95.565 E.00531
G1 X80.619 Y77.628 E.37965
G1 X80.655 Y77.357 E.00578
G1 X80.716 Y77.205 E.00346
G1 X80.791 Y77.082 E.00305
G1 X80.975 Y76.896 E.00555
G1 X81.192 Y76.777 E.00524
G1 X81.452 Y76.723 E.00561
G1 X94.483 Y76.721 E.27582
G1 X94.701 Y76.747 E.00463
G1 X94.902 Y76.821 E.00453
G1 X95.017 Y76.892 E.00286
G1 X95.172 Y77.038 E.0045
G1 X95.288 Y77.215 E.0045
G1 X95.341 Y77.349 E.00305
G1 X95.372 Y77.498 E.00323
G1 X95.397 Y78.42 E.01951
G1 X99.381 Y78.421 E.08431
G1 X99.38 Y85.182 E.14309
G1 X94.619 Y85.181 E.10076
G1 X94.62 Y78.417 E.14317
G1 X95.29 Y77.928 E.01754
G1 X94.618 Y77.285 E.01969
G1 X94.387 Y77.149 E.00567
G1 X94.064 Y77.082 E.00698
G1 X81.952 Y77.082 E.25635
G1 X81.687 Y77.123 E.00568
G1 X81.393 Y77.273 E.007
G1 X81.17 Y77.495 E.00665
G1 X81.019 Y77.798 E.00717
G1 X80.981 Y78.056 E.00552
G1 X80.981 Y95.146 E.36173
G1 X81.017 Y95.395 E.00533
G1 X81.14 Y95.659 E.00616
G1 X81.311 Y95.859 E.00557
G1 X81.564 Y96.034 E.00651
G1 X81.928 Y96.12 E.0079
G1 X86.701 Y96.12 E.10103
; WIPE_START
M204 S6000
G1 X88.701 Y96.12 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X85.605 Y96.891 Z1.92 F18000
G1 Z1.52
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X81.512 Y96.891 E.08049
G1 X81.203 Y96.855 E.00613
G1 X80.917 Y96.751 E.00599
G1 X80.778 Y96.669 E.00318
G1 X80.613 Y96.537 E.00414
G1 X80.514 Y96.432 E.00284
G1 X80.382 Y96.244 E.00452
G1 X80.31 Y96.096 E.00324
G1 X80.247 Y95.902 E.00402
G1 X80.21 Y95.589 E.0062
G1 X80.21 Y77.61 E.35362
G1 X80.231 Y77.374 E.00466
G1 X80.264 Y77.234 E.00283
G1 X80.348 Y77.022 E.00449
G1 X80.456 Y76.845 E.00408
G1 X80.561 Y76.718 E.00323
G1 X80.73 Y76.567 E.00446
G1 X80.924 Y76.447 E.00448
G1 X81.057 Y76.39 E.00284
G1 X81.26 Y76.334 E.00415
G1 X81.426 Y76.313 E.00329
G1 X94.508 Y76.311 E.25732
G1 X94.797 Y76.347 E.00571
G1 X95.081 Y76.45 E.00595
G1 X95.267 Y76.565 E.0043
G1 X95.487 Y76.773 E.00595
G1 X95.653 Y77.025 E.00594
G1 X95.735 Y77.231 E.00436
G1 X95.78 Y77.451 E.00442
G1 X95.796 Y78.011 E.01101
G1 X99.416 Y78.012 E.07121
G1 X99.514 Y78.03 E.00195
G1 X99.615 Y78.078 E.0022
G1 X99.684 Y78.136 E.00178
G1 X99.748 Y78.229 E.00222
G1 X99.79 Y78.413 E.00371
G1 X99.789 Y85.215 E.13378
G1 X99.765 Y85.331 E.00234
G1 X99.724 Y85.415 E.00183
G1 X99.669 Y85.481 E.0017
G1 X99.572 Y85.549 E.00233
G1 X99.388 Y85.591 E.00371
G1 X94.584 Y85.59 E.09449
G1 X94.406 Y85.537 E.00365
G1 X94.277 Y85.417 E.00346
G1 X94.229 Y85.312 E.00227
G1 X94.21 Y85.186 E.00252
G1 X94.211 Y78.385 E.13377
G1 X94.227 Y78.293 E.00182
G1 X94.276 Y78.187 E.00231
G1 X94.33 Y78.122 E.00166
G1 X94.654 Y77.886 E.00788
G1 X94.369 Y77.614 E.00774
G1 X94.237 Y77.536 E.00301
G1 X94.022 Y77.491 E.00433
G1 X81.984 Y77.491 E.23677
G1 X81.814 Y77.517 E.00337
G1 X81.636 Y77.608 E.00394
G1 X81.507 Y77.738 E.0036
G1 X81.414 Y77.922 E.00407
G1 X81.39 Y78.086 E.00324
G1 X81.39 Y95.116 E.33498
G1 X81.413 Y95.276 E.00319
G1 X81.488 Y95.435 E.00345
G1 X81.588 Y95.553 E.00304
G1 X81.734 Y95.654 E.00349
G1 X81.975 Y95.711 E.00489
G1 X94.022 Y95.711 E.23694
G1 X94.237 Y95.666 E.00433
G1 X94.369 Y95.588 E.00301
G1 X94.654 Y95.316 E.00775
G1 X94.33 Y95.08 E.00789
G1 X94.276 Y95.015 E.00166
G1 X94.228 Y94.911 E.00225
G1 X94.21 Y94.786 E.00249
G1 X94.21 Y88.019 E.13309
G1 X94.237 Y87.866 E.00307
G1 X94.29 Y87.767 E.00221
G1 X94.423 Y87.655 E.00342
G1 X94.584 Y87.612 E.00326
G1 X99.413 Y87.612 E.09499
G1 X99.535 Y87.638 E.00245
G1 X99.651 Y87.706 E.00265
G1 X99.722 Y87.785 E.0021
G1 X99.779 Y87.917 E.00283
G1 X99.79 Y94.782 E.13503
G1 X99.763 Y94.933 E.00301
M73 P54 R11
G1 X99.693 Y95.055 E.00277
G1 X99.575 Y95.149 E.00297
G1 X99.416 Y95.19 E.00322
G1 X95.792 Y95.191 E.07129
G1 X95.788 Y95.672 E.00946
G1 X95.754 Y95.898 E.0045
G1 X95.684 Y96.111 E.00442
G1 X95.577 Y96.309 E.00442
G1 X95.439 Y96.484 E.00437
G1 X95.222 Y96.668 E.00561
G1 X95.01 Y96.785 E.00477
G1 X94.8 Y96.854 E.00434
G1 X94.488 Y96.891 E.00619
G1 X90.377 Y96.891 E.08086
G1 X90.857 Y97.411 E.01392
G1 X91.136 Y97.772 E.00898
G1 X91.253 Y97.957 E.00431
G1 X91.437 Y98.308 E.00779
G1 X91.62 Y98.781 E.00998
G1 X91.728 Y99.22 E.00889
G1 X91.782 Y99.661 E.00873
G1 X91.784 Y100.117 E.00897
G1 X91.765 Y100.335 E.00431
G1 X91.686 Y100.781 E.00891
G1 X91.555 Y101.214 E.00891
G1 X91.473 Y101.418 E.00431
G1 X91.267 Y101.821 E.00892
G1 X91.047 Y102.152 E.0078
G1 X90.876 Y102.368 E.00543
G1 X90.562 Y102.693 E.00889
G1 X90.211 Y102.979 E.00891
G1 X89.836 Y103.216 E.00873
G1 X89.427 Y103.412 E.00891
G1 X88.998 Y103.557 E.00891
G1 X88.785 Y103.609 E.00431
G1 X88.334 Y103.676 E.00897
G1 X88.116 Y103.689 E.00431
G1 X87.663 Y103.676 E.00891
G1 X87.215 Y103.608 E.00891
G1 X86.999 Y103.556 E.00437
G1 X86.787 Y103.491 E.00436
G1 X86.367 Y103.321 E.00891
G1 X85.973 Y103.103 E.00885
G1 X85.608 Y102.84 E.00885
G1 X85.277 Y102.536 E.00885
G1 X84.983 Y102.195 E.00885
G1 X84.733 Y101.821 E.00885
G1 X84.527 Y101.418 E.00891
G1 X84.445 Y101.215 E.0043
G1 X84.313 Y100.778 E.00897
G1 X84.221 Y100.17 E.0121
G1 X84.218 Y99.663 E.00997
G1 X84.273 Y99.217 E.00883
G1 X84.38 Y98.78 E.00885
G1 X84.538 Y98.359 E.00885
G1 X84.745 Y97.96 E.00885
G1 X84.998 Y97.588 E.00885
G1 X85.565 Y96.936 E.01698
; WIPE_START
M204 S6000
G1 X83.565 Y96.914 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G17
G3 Z1.92 I1.217 J0 P1  F18000
;===================== date: 20250206 =====================

; don't support timelapse gcode in spiral_mode and by object sequence for I3 structure printer
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
G92 E0
G1 Z1.92
G1 X0 Y90 ; move to safe pos
G1 X-13.0 F3000 ; move to safe pos
M400
M1004 S5 P1  ; external shutter
M400 P300
M971 S11 C11 O0
G92 E0
G1 X0 F18000
M623

; SKIPTYPE: head_wrap_detect
M622.1 S1
M1002 judge_flag g39_3rd_layer_detect_flag
M622 J1
    ; enable nozzle clog detect at 3rd layer
    


    M622.1 S1
    M1002 judge_flag g39_detection_flag
    M622 J1
      
        M622.1 S0
        M1002 judge_flag g39_mass_exceed_flag
        M622 J1
        
            G392 S0
            M400
            G90
            M83
            M204 S5000
            G0 Z1.92 F4000
            G39.3 S1
            G0 Z1.92 F4000
            G392 S0
          
        M623
    
    M623
M623
; SKIPPABLE_END




G1 X81.445 Y96.248
G1 Z1.52
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.140884
G1 F1500
M204 S6000
G1 X81.214 Y96.129 E.0015
G1 X81.119 Y96.06 E.00068
; LINE_WIDTH: 0.149638
G1 X80.919 Y95.793 E.00206
; LINE_WIDTH: 0.0966359
G1 X80.862 Y95.617 E.00066
; WIPE_START
G1 X80.919 Y95.793 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X86.548 Y97.165 Z1.92 F18000
G1 Z1.52
G1 E.4 F1800
; LINE_WIDTH: 0.478517
G1 F1500
M204 S6000
G1 X86.38 Y97.306 E.00495
; LINE_WIDTH: 0.444783
G1 X86.187 Y97.472 E.00533
; LINE_WIDTH: 0.406919
G1 X86.001 Y97.659 E.00501
; LINE_WIDTH: 0.359987
G1 X85.794 Y97.869 E.00491
G1 X85.462 Y98.303 E.00912
G1 X85.223 Y98.772 E.00877
G1 X85.107 Y99.115 E.00603
G1 X85.032 Y99.481 E.00624
G1 X85.005 Y100.005 E.00875
G1 X85.071 Y100.544 E.00906
G1 X85.192 Y100.946 E.007
G1 X85.388 Y101.371 E.0078
G1 X85.59 Y101.686 E.00624
G1 X85.846 Y101.985 E.00657
G1 X86.109 Y102.224 E.00593
G1 X86.396 Y102.435 E.00594
G1 X86.809 Y102.651 E.00776
G1 X87.208 Y102.792 E.00706
G1 X87.733 Y102.888 E.0089
G1 X88.255 Y102.886 E.0087
G1 X88.598 Y102.836 E.00578
G1 X89.126 Y102.681 E.00918
G1 X89.462 Y102.52 E.0062
G1 X89.742 Y102.344 E.00553
G1 X90.146 Y101.994 E.0089
G1 X90.476 Y101.592 E.00867
G1 X90.75 Y101.094 E.00948
G1 X90.914 Y100.597 E.00873
G1 X90.991 Y100.081 E.00869
G1 X90.995 Y99.881 E.00333
G1 X90.945 Y99.357 E.00878
G1 X90.866 Y99.016 E.00584
G1 X90.718 Y98.635 E.00683
G1 X90.483 Y98.225 E.00787
G1 X90.128 Y97.784 E.00945
; LINE_WIDTH: 0.375738
G1 X89.948 Y97.612 E.00433
; LINE_WIDTH: 0.408365
G1 X89.742 Y97.417 E.00543
; LINE_WIDTH: 0.445667
G1 X89.561 Y97.272 E.00484
; LINE_WIDTH: 0.479597
G1 X89.381 Y97.128 E.00524
; WIPE_START
G1 X89.561 Y97.272 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X94.537 Y96.257 Z1.92 F18000
G1 Z1.52
G1 E.4 F1800
; LINE_WIDTH: 0.14872
G1 F1500
M204 S6000
G1 X94.832 Y96.097 E.00206
G1 X95.135 Y95.786 E.00267
; WIPE_START
G1 X94.832 Y96.097 E-.21458
G1 X94.537 Y96.257 E-.16542
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X95.122 Y88.647 Z1.92 F18000
G1 X95.453 Y84.347 Z1.92
G1 Z1.52
G1 E.4 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.419992
G1 F1500
M204 S6000
G1 X98.546 Y84.348 E.06085
G1 X98.547 Y79.254 E.10018
G1 X95.454 Y79.253 E.06085
G1 X95.453 Y84.287 E.09901
M204 S10000
G1 X95.847 Y83.953 F18000
G1 F1500
M204 S6000
G1 X98.152 Y83.954 E.04534
G1 X98.153 Y79.648 E.08468
G1 X95.848 Y79.648 E.04534
G1 X95.847 Y83.893 E.0835
M204 S10000
G1 X96.241 Y83.559 F18000
G1 F1500
M204 S6000
G1 X97.758 Y83.559 E.02983
G1 X97.759 Y80.043 E.06917
G1 X96.242 Y80.042 E.02983
G1 X96.241 Y83.499 E.06799
M204 S10000
G1 X96.636 Y83.165 F18000
G1 F1500
M204 S6000
G1 X97.364 Y83.165 E.01432
G1 X97.364 Y80.437 E.05366
G1 X96.636 Y80.437 E.01432
G1 X96.636 Y83.105 E.05248
M204 S10000
G1 X97 Y82.801 F18000
; LINE_WIDTH: 0.359632
G1 F1500
M204 S6000
G1 X97 Y80.861 E.03232
; WIPE_START
G1 X97 Y82.801 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X95.142 Y77.444 Z1.92 F18000
G1 Z1.52
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.142572
G1 F1500
M204 S6000
G1 X94.957 Y77.221 E.00169
G1 X94.788 Y77.072 E.00131
G1 X94.533 Y76.949 E.00165
; WIPE_START
G1 X94.788 Y77.072 E-.13456
G1 X94.957 Y77.221 E-.10741
G1 X95.142 Y77.444 E-.13803
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X87.515 Y77.171 Z1.92 F18000
G1 X81.503 Y76.955 Z1.92
G1 Z1.52
G1 E.4 F1800
; LINE_WIDTH: 0.0816674
G1 F1500
M204 S6000
G1 X81.468 Y76.964 E.0001
; LINE_WIDTH: 0.0965039
G1 X81.375 Y76.997 E.00035
; LINE_WIDTH: 0.127032
G1 X81.227 Y77.06 E.00081
; LINE_WIDTH: 0.1516
G1 X81.065 Y77.198 E.00134
G1 X80.957 Y77.327 E.00106
G1 X80.907 Y77.434 E.00074
; LINE_WIDTH: 0.102589
G1 X80.857 Y77.598 E.00066
; CHANGE_LAYER
; Z_HEIGHT: 1.64
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F1500
G1 X80.907 Y77.434 E-.38
; WIPE_END
G1 E-.02 F1800
; layer num/total_layer_count: 13/49
; update layer progress
M73 L13
M991 S0 P12 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z1.92 I-.908 J.81 P1  F18000
G1 X94.881 Y93.111 Z1.92
G1 Z1.64
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X94.881 Y89.282 E.08105
G1 X99.119 Y89.282 E.08971
G1 X99.119 Y93.52 E.08971
G1 X94.881 Y93.52 E.08971
G1 X94.881 Y93.171 E.00739
M204 S250
M73 P54 R10
G1 X95.29 Y93.111 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X95.29 Y89.691 E.06727
G1 X98.71 Y89.691 E.06727
G1 X98.71 Y93.111 E.06727
G1 X95.35 Y93.111 E.06609
; WIPE_START
M204 S6000
G1 X95.315 Y91.111 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X95.29 Y88.857 Z2.04 F18000
G1 Z1.64
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X95.043 Y88.857 E.00522
G1 X95.043 Y88.445 E.00872
G1 X98.957 Y88.445 E.08282
G1 X98.957 Y88.857 E.00872
G1 X95.35 Y88.857 E.07634
; WIPE_START
M204 S6000
G1 X95.043 Y88.857 E-.05824
G1 X95.043 Y88.445 E-.07829
G1 X96.325 Y88.445 E-.24348
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X98.957 Y93.944 Z2.04 F18000
G1 Z1.64
G1 E.4 F1800
G1 F1500
M204 S500
G1 X98.957 Y94.357 E.00872
G1 X95.043 Y94.358 E.08282
G1 X95.043 Y93.944 E.00875
G1 X98.897 Y93.944 E.08155
; WIPE_START
M204 S6000
G1 X98.957 Y94.357 E-.07914
G1 X97.373 Y94.357 E-.30086
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X90.129 Y96.759 Z2.04 F18000
G1 X89.159 Y97.081 Z2.04
G1 Z1.64
G1 E.4 F1800
G1 F1500
M204 S500
G1 X88.766 Y96.953 E.00873
G1 X88.393 Y96.88 E.00804
G1 X87.863 Y96.856 E.01123
G1 X87.322 Y96.93 E.01157
G1 X86.766 Y97.11 E.01238
G1 X86.659 Y96.949 E.0041
G1 X87.011 Y96.544 E.01135
G1 X88.922 Y96.544 E.04045
G1 X89.265 Y96.915 E.01069
G1 X89.191 Y97.031 E.00289
; WIPE_START
M204 S6000
G1 X88.766 Y96.953 E-.08204
G1 X88.393 Y96.88 E-.07221
G1 X87.863 Y96.856 E-.1008
G1 X87.322 Y96.93 E-.10383
G1 X87.216 Y96.964 E-.02113
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X90.617 Y99.845 Z2.04 F18000
G1 Z1.64
G1 E.4 F1800
G1 F1500
M204 S500
G1 X90.622 Y99.901 E.00118
G1 X90.58 Y100.369 E.00995
G1 X90.455 Y100.822 E.00995
G1 X90.255 Y101.237 E.00975
G1 X90.073 Y101.504 E.00683
G1 X89.861 Y101.747 E.00683
G1 X89.516 Y102.039 E.00956
G1 X89.243 Y102.208 E.0068
G1 X88.982 Y102.33 E.0061
G1 X88.51 Y102.473 E.01044
G1 X88.048 Y102.521 E.00982
G1 X87.728 Y102.507 E.0068
G1 X87.443 Y102.461 E.0061
G1 X86.972 Y102.313 E.01044
G1 X86.556 Y102.089 E.01001
G1 X86.188 Y101.796 E.00995
G1 X85.879 Y101.442 E.00995
G1 X85.643 Y101.046 E.00975
G1 X85.52 Y100.748 E.00683
G1 X85.434 Y100.437 E.00683
G1 X85.379 Y99.979 E.00975
G1 X85.407 Y99.519 E.00975
G1 X85.474 Y99.205 E.0068
G1 X85.566 Y98.932 E.0061
G1 X85.789 Y98.492 E.01044
G1 X86.08 Y98.115 E.01007
G1 X86.45 Y97.789 E.01045
G1 X86.691 Y97.631 E.0061
G1 X86.979 Y97.487 E.0068
G1 X87.417 Y97.345 E.00975
G1 X87.882 Y97.282 E.00995
G1 X88.343 Y97.302 E.00975
G1 X88.659 Y97.365 E.00683
G1 X88.966 Y97.465 E.00683
G1 X89.378 Y97.671 E.00975
G1 X89.747 Y97.947 E.00975
G1 X89.973 Y98.177 E.00683
G1 X90.171 Y98.432 E.00683
G1 X90.391 Y98.826 E.00956
G1 X90.504 Y99.129 E.00683
G1 X90.58 Y99.442 E.00683
G1 X90.611 Y99.786 E.0073
M204 S250
G1 X90.209 Y99.882 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X90.211 Y99.901 E.00037
G1 X90.175 Y100.296 E.00779
G1 X90.07 Y100.678 E.0078
G1 X89.899 Y101.032 E.00774
G1 X89.749 Y101.253 E.00526
G1 X89.573 Y101.454 E.00526
G1 X89.275 Y101.707 E.00767
G1 X89.048 Y101.847 E.00525
G1 X88.835 Y101.947 E.00462
G1 X88.428 Y102.07 E.00836
G1 X88.036 Y102.111 E.00776
G1 X87.77 Y102.099 E.00525
G1 X87.537 Y102.062 E.00462
G1 X87.132 Y101.934 E.00836
G1 X86.782 Y101.746 E.00782
G1 X86.472 Y101.499 E.0078
G1 X86.211 Y101.2 E.0078
G1 X86.01 Y100.863 E.00773
G1 X85.908 Y100.615 E.00526
G1 X85.837 Y100.357 E.00526
G1 X85.79 Y99.967 E.00773
G1 X85.814 Y99.574 E.00774
G1 X85.869 Y99.313 E.00525
G1 X85.944 Y99.091 E.00462
G1 X86.136 Y98.711 E.00836
G1 X86.38 Y98.396 E.00783
G1 X86.699 Y98.115 E.00836
G1 X86.895 Y97.986 E.00462
G1 X87.134 Y97.867 E.00525
G1 X87.508 Y97.745 E.00773
G1 X87.901 Y97.692 E.0078
G1 X88.294 Y97.71 E.00773
G1 X88.556 Y97.762 E.00526
G1 X88.811 Y97.844 E.00526
G1 X89.162 Y98.02 E.00773
G1 X89.477 Y98.256 E.00773
G1 X89.665 Y98.447 E.00526
G1 X89.828 Y98.658 E.00526
G1 X90.018 Y98.999 E.00768
G1 X90.112 Y99.249 E.00526
G1 X90.176 Y99.509 E.00526
G1 X90.204 Y99.822 E.00618
; WIPE_START
M204 S6000
G1 X90.211 Y99.901 E-.01499
G1 X90.175 Y100.296 E-.07529
G1 X90.07 Y100.678 E-.07532
G1 X89.899 Y101.032 E-.07472
G1 X89.749 Y101.253 E-.05081
G1 X89.573 Y101.454 E-.05082
G1 X89.42 Y101.584 E-.03804
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X92.372 Y94.545 Z2.04 F18000
G1 X98.956 Y78.845 Z2.04
G1 Z1.64
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X98.956 Y84.757 E.12513
G1 X95.044 Y84.756 E.0828
G1 X95.044 Y78.844 E.12514
G1 X98.896 Y78.845 E.08153
; WIPE_START
M204 S6000
M73 P55 R10
G1 X98.916 Y80.845 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X94.164 Y86.817 Z2.04 F18000
G1 X86.761 Y96.12 Z2.04
G1 Z1.64
G1 E.4 F1800
G1 F1500
M204 S500
G1 X94.064 Y96.12 E.15458
G1 X94.387 Y96.053 E.00698
G1 X94.617 Y95.917 E.00566
G1 X95.291 Y95.274 E.01971
G1 X94.619 Y94.784 E.01758
G1 X94.619 Y88.021 E.14315
G1 X99.381 Y88.021 E.10078
G1 X99.381 Y94.781 E.14307
G1 X95.386 Y94.782 E.08455
G1 X95.379 Y95.64 E.01817
G1 X95.355 Y95.803 E.00349
G1 X95.307 Y95.949 E.00324
G1 X95.234 Y96.083 E.00324
G1 X95.139 Y96.204 E.00325
G1 X95.025 Y96.305 E.00324
G1 X94.902 Y96.381 E.00305
G1 X94.702 Y96.454 E.0045
G1 X94.464 Y96.482 E.00508
G1 X89.441 Y96.482 E.1063
G1 X90.544 Y97.675 E.03439
G1 X90.8 Y98.008 E.00888
G1 X91.062 Y98.474 E.01131
G1 X91.229 Y98.905 E.00978
G1 X91.355 Y99.49 E.01267
G1 X91.374 Y100.1 E.01292
G1 X91.299 Y100.629 E.01131
G1 X91.169 Y101.074 E.00982
G1 X90.916 Y101.61 E.01255
G1 X90.568 Y102.099 E.0127
G1 X90.285 Y102.391 E.00861
G1 X89.967 Y102.65 E.00868
G1 X89.643 Y102.855 E.00811
G1 X89.273 Y103.032 E.00869
G1 X88.884 Y103.164 E.00869
G1 X88.292 Y103.269 E.01273
G1 X87.699 Y103.267 E.01254
G1 X87.116 Y103.163 E.01254
G1 X86.727 Y103.032 E.00869
G1 X86.365 Y102.859 E.00849
G1 X86.026 Y102.644 E.00849
G1 X85.577 Y102.258 E.01254
G1 X85.31 Y101.947 E.00869
G1 X85.086 Y101.613 E.0085
G1 X84.9 Y101.248 E.00868
G1 X84.728 Y100.742 E.01131
G1 X84.643 Y100.287 E.00978
G1 X84.62 Y99.89 E.00842
G1 X84.645 Y99.49 E.00849
G1 X84.718 Y99.095 E.00849
G1 X84.909 Y98.533 E.01257
G1 X85.069 Y98.22 E.00743
G1 X85.325 Y97.835 E.00978
G1 X86.503 Y96.482 E.03798
G1 X81.536 Y96.482 E.10513
G1 X81.298 Y96.454 E.00508
G1 X81.098 Y96.381 E.0045
G1 X80.968 Y96.301 E.00324
G1 X80.789 Y96.119 E.00539
G1 X80.74 Y96.043 E.00191
G1 X80.648 Y95.814 E.00523
G1 X80.619 Y95.565 E.00531
G1 X80.619 Y77.619 E.37984
G1 X80.659 Y77.347 E.00581
G1 X80.762 Y77.123 E.00523
G1 X80.862 Y76.997 E.0034
G1 X80.968 Y76.901 E.00302
G1 X81.2 Y76.775 E.00558
G1 X81.449 Y76.723 E.00539
G1 X94.485 Y76.721 E.27592
G1 X94.7 Y76.747 E.00459
G1 X94.902 Y76.821 E.00454
G1 X95.017 Y76.891 E.00285
G1 X95.178 Y77.044 E.0047
G1 X95.256 Y77.154 E.00286
G1 X95.343 Y77.358 E.00469
G1 X95.372 Y77.498 E.00304
G1 X95.397 Y78.42 E.01951
G1 X99.381 Y78.421 E.08431
G1 X99.38 Y85.182 E.14309
G1 X94.619 Y85.181 E.10076
G1 X94.62 Y78.417 E.14316
G1 X95.291 Y77.928 E.01756
G1 X94.617 Y77.285 E.01971
G1 X94.387 Y77.149 E.00566
G1 X94.064 Y77.082 E.00698
G1 X81.952 Y77.082 E.25636
G1 X81.686 Y77.123 E.0057
G1 X81.392 Y77.273 E.00698
G1 X81.171 Y77.495 E.00663
G1 X81.019 Y77.798 E.00718
G1 X80.981 Y78.056 E.00553
G1 X80.981 Y95.146 E.36172
G1 X81.017 Y95.395 E.00533
G1 X81.143 Y95.665 E.0063
G1 X81.335 Y95.88 E.0061
G1 X81.572 Y96.036 E.006
G1 X81.928 Y96.12 E.00775
G1 X86.701 Y96.12 E.10103
; WIPE_START
M204 S6000
G1 X88.701 Y96.12 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X85.605 Y96.891 Z2.04 F18000
G1 Z1.64
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X81.512 Y96.891 E.08049
G1 X81.203 Y96.855 E.00613
G1 X80.919 Y96.751 E.00595
G1 X80.727 Y96.633 E.00442
G1 X80.617 Y96.541 E.00283
G1 X80.464 Y96.368 E.00454
G1 X80.384 Y96.247 E.00287
G1 X80.309 Y96.095 E.00333
G1 X80.247 Y95.902 E.00399
G1 X80.21 Y95.589 E.0062
G1 X80.21 Y77.607 E.35368
G1 X80.219 Y77.454 E.00301
G1 X80.265 Y77.231 E.00449
G1 X80.34 Y77.039 E.00405
G1 X80.422 Y76.894 E.00327
G1 X80.563 Y76.716 E.00447
G1 X80.716 Y76.578 E.00405
G1 X80.854 Y76.485 E.00327
G1 X81.059 Y76.389 E.00446
G1 X81.279 Y76.33 E.00448
G1 X81.425 Y76.313 E.00289
G1 X94.51 Y76.312 E.25737
G1 X94.797 Y76.347 E.00568
G1 X95.081 Y76.45 E.00596
G1 X95.267 Y76.565 E.0043
G1 X95.489 Y76.775 E.00601
G1 X95.615 Y76.954 E.0043
G1 X95.736 Y77.234 E.006
G1 X95.78 Y77.451 E.00436
G1 X95.796 Y78.011 E.01101
G1 X99.416 Y78.012 E.07121
G1 X99.512 Y78.029 E.00191
G1 X99.615 Y78.078 E.00225
G1 X99.683 Y78.135 E.00174
G1 X99.748 Y78.229 E.00226
G1 X99.79 Y78.413 E.00371
G1 X99.789 Y85.215 E.13378
G1 X99.765 Y85.333 E.00238
G1 X99.724 Y85.415 E.00179
G1 X99.669 Y85.481 E.0017
G1 X99.572 Y85.549 E.00233
G1 X99.388 Y85.591 E.00371
G1 X94.584 Y85.59 E.09449
G1 X94.406 Y85.537 E.00365
G1 X94.277 Y85.417 E.00347
G1 X94.229 Y85.312 E.00227
G1 X94.21 Y85.186 E.00252
G1 X94.211 Y78.388 E.13369
G1 X94.227 Y78.293 E.0019
G1 X94.276 Y78.187 E.0023
G1 X94.33 Y78.122 E.00166
G1 X94.654 Y77.886 E.00789
G1 X94.369 Y77.613 E.00775
G1 X94.237 Y77.536 E.00301
G1 X94.022 Y77.491 E.00433
G1 X81.984 Y77.491 E.23677
G1 X81.814 Y77.517 E.00338
G1 X81.636 Y77.608 E.00393
G1 X81.507 Y77.737 E.0036
G1 X81.414 Y77.922 E.00407
G1 X81.39 Y78.086 E.00325
G1 X81.39 Y95.116 E.33497
G1 X81.413 Y95.276 E.00318
G1 X81.488 Y95.437 E.00349
G1 X81.604 Y95.568 E.00343
G1 X81.736 Y95.654 E.0031
G1 X81.976 Y95.711 E.00484
G1 X94.022 Y95.711 E.23694
G1 X94.237 Y95.666 E.00433
G1 X94.369 Y95.588 E.00301
G1 X94.654 Y95.316 E.00775
G1 X94.33 Y95.08 E.00789
G1 X94.276 Y95.015 E.00166
G1 X94.228 Y94.911 E.00225
G1 X94.21 Y94.786 E.00249
G1 X94.21 Y88.019 E.13309
G1 X94.237 Y87.866 E.00307
G1 X94.291 Y87.766 E.00221
G1 X94.426 Y87.654 E.00346
G1 X94.58 Y87.612 E.00315
G1 X99.413 Y87.612 E.09505
G1 X99.533 Y87.637 E.00241
G1 X99.648 Y87.704 E.00263
G1 X99.737 Y87.81 E.00271
G1 X99.778 Y87.914 E.00221
G1 X99.79 Y94.782 E.13509
G1 X99.763 Y94.933 E.00301
G1 X99.693 Y95.055 E.00276
G1 X99.575 Y95.149 E.00297
G1 X99.416 Y95.19 E.00322
G1 X95.792 Y95.191 E.07129
G1 X95.788 Y95.672 E.00946
G1 X95.754 Y95.898 E.0045
G1 X95.684 Y96.112 E.00442
G1 X95.577 Y96.309 E.00442
G1 X95.438 Y96.486 E.00442
G1 X95.27 Y96.635 E.00442
G1 X95.081 Y96.751 E.00436
G1 X94.797 Y96.855 E.00594
G1 X94.488 Y96.891 E.00613
G1 X90.377 Y96.891 E.08086
G1 X90.857 Y97.411 E.01392
G1 X91.136 Y97.772 E.00897
G1 X91.254 Y97.957 E.00432
G1 X91.435 Y98.304 E.0077
G1 X91.62 Y98.781 E.01007
G1 X91.728 Y99.22 E.00889
G1 X91.782 Y99.661 E.00873
G1 X91.784 Y100.117 E.00897
G1 X91.765 Y100.335 E.00432
G1 X91.698 Y100.721 E.0077
G1 X91.555 Y101.213 E.01008
G1 X91.4 Y101.572 E.00768
G1 X91.268 Y101.82 E.00553
G1 X91.05 Y102.148 E.00774
G1 X90.876 Y102.368 E.00552
G1 X90.562 Y102.693 E.00889
G1 X90.211 Y102.979 E.00891
G1 X90.027 Y103.103 E.00437
G1 X89.836 Y103.216 E.00436
G1 X89.427 Y103.412 E.00891
G1 X88.998 Y103.557 E.00891
G1 X88.785 Y103.608 E.00431
G1 X88.334 Y103.676 E.00897
G1 X88.116 Y103.689 E.00431
G1 X87.663 Y103.676 E.00891
G1 X87.215 Y103.608 E.00891
G1 X87.002 Y103.557 E.00431
G1 X86.573 Y103.412 E.00891
G1 X86.167 Y103.218 E.00885
G1 X85.787 Y102.977 E.00885
G1 X85.435 Y102.691 E.00891
G1 X85.279 Y102.538 E.00431
G1 X84.983 Y102.195 E.00891
G1 X84.733 Y101.821 E.00885
G1 X84.527 Y101.418 E.00891
G1 X84.33 Y100.84 E.01201
G1 X84.236 Y100.337 E.01007
G1 X84.21 Y99.889 E.00883
G1 X84.239 Y99.44 E.00885
G1 X84.32 Y98.997 E.00885
G1 X84.454 Y98.564 E.00891
G1 X84.716 Y98.013 E.012
M73 P56 R10
G1 X84.999 Y97.587 E.01007
G1 X85.565 Y96.936 E.01696
; WIPE_START
M204 S6000
G1 X83.565 Y96.914 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G17
G3 Z2.04 I1.217 J0 P1  F18000
;===================== date: 20250206 =====================

; don't support timelapse gcode in spiral_mode and by object sequence for I3 structure printer
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
G92 E0
G1 Z2.04
G1 X0 Y90 ; move to safe pos
G1 X-13.0 F3000 ; move to safe pos
M400
M1004 S5 P1  ; external shutter
M400 P300
M971 S11 C11 O0
G92 E0
G1 X0 F18000
M623

; SKIPTYPE: head_wrap_detect
M622.1 S1
M1002 judge_flag g39_3rd_layer_detect_flag
M622 J1
    ; enable nozzle clog detect at 3rd layer
    


    M622.1 S1
    M1002 judge_flag g39_detection_flag
    M622 J1
      
        M622.1 S0
        M1002 judge_flag g39_mass_exceed_flag
        M622 J1
        
            G392 S0
            M400
            G90
            M83
            M204 S5000
            G0 Z2.04 F4000
            G39.3 S1
            G0 Z2.04 F4000
            G392 S0
          
        M623
    
    M623
M623
; SKIPPABLE_END




G1 X81.451 Y96.249
G1 Z1.64
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.137283
G1 F1500
M204 S6000
G1 X81.148 Y96.084 E.00192
; LINE_WIDTH: 0.156126
G1 X81.016 Y95.948 E.00123
G1 X80.922 Y95.802 E.00113
; LINE_WIDTH: 0.097775
G1 X80.862 Y95.617 E.0007
; WIPE_START
G1 X80.922 Y95.802 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X86.548 Y97.165 Z2.04 F18000
G1 Z1.64
G1 E.4 F1800
; LINE_WIDTH: 0.478633
G1 F1500
M204 S6000
G1 X86.381 Y97.305 E.00491
; LINE_WIDTH: 0.445305
G1 X86.189 Y97.47 E.0053
; LINE_WIDTH: 0.407448
G1 X86.002 Y97.658 E.00505
; LINE_WIDTH: 0.359775
G1 X85.795 Y97.869 E.00493
G1 X85.463 Y98.304 E.00911
G1 X85.212 Y98.797 E.00921
G1 X85.088 Y99.186 E.0068
G1 X85.024 Y99.536 E.00594
G1 X85.004 Y100.005 E.00783
G1 X85.068 Y100.521 E.00867
G1 X85.189 Y100.945 E.00734
G1 X85.419 Y101.42 E.0088
G1 X85.613 Y101.716 E.00589
G1 X85.918 Y102.057 E.00762
G1 X86.336 Y102.395 E.00896
G1 X86.84 Y102.667 E.00954
G1 X87.344 Y102.827 E.00882
G1 X87.698 Y102.884 E.00598
G1 X88.072 Y102.9 E.00623
G1 X88.6 Y102.84 E.00885
G1 X89.106 Y102.688 E.00881
G1 X89.429 Y102.532 E.00597
G1 X89.726 Y102.349 E.00582
G1 X90.116 Y102.024 E.00846
G1 X90.378 Y101.728 E.00659
G1 X90.59 Y101.416 E.00628
G1 X90.813 Y100.946 E.00867
G1 X90.946 Y100.45 E.00855
G1 X90.995 Y99.915 E.00895
G1 X90.974 Y99.536 E.00633
G1 X90.866 Y99.017 E.00884
G1 X90.728 Y98.656 E.00643
G1 X90.57 Y98.36 E.0056
G1 X90.253 Y97.919 E.00904
G1 X89.991 Y97.647 E.00629
; LINE_WIDTH: 0.397588
G1 X89.807 Y97.48 E.00461
; LINE_WIDTH: 0.442722
G1 X89.622 Y97.314 E.00517
; LINE_WIDTH: 0.480566
G1 X89.38 Y97.129 E.00691
; WIPE_START
G1 X89.622 Y97.314 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X94.535 Y96.252 Z2.04 F18000
G1 Z1.64
G1 E.4 F1800
; LINE_WIDTH: 0.147924
G1 F1500
M204 S6000
G1 X94.788 Y96.131 E.0017
G1 X95.126 Y95.806 E.00286
; WIPE_START
G1 X94.788 Y96.131 E-.23807
G1 X94.535 Y96.252 E-.14193
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X95.122 Y88.642 Z2.04 F18000
G1 X95.453 Y84.347 Z2.04
G1 Z1.64
G1 E.4 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.419992
G1 F1500
M204 S6000
G1 X98.546 Y84.348 E.06085
G1 X98.547 Y79.254 E.10018
G1 X95.453 Y79.253 E.06085
G1 X95.453 Y84.287 E.09901
M204 S10000
G1 X95.847 Y83.953 F18000
G1 F1500
M204 S6000
G1 X98.152 Y83.954 E.04534
G1 X98.153 Y79.648 E.08468
G1 X95.848 Y79.648 E.04534
G1 X95.847 Y83.893 E.0835
M204 S10000
G1 X96.241 Y83.559 F18000
G1 F1500
M204 S6000
G1 X97.758 Y83.559 E.02983
G1 X97.759 Y80.043 E.06917
G1 X96.242 Y80.042 E.02983
G1 X96.241 Y83.499 E.06799
M204 S10000
G1 X96.636 Y83.165 F18000
G1 F1500
M204 S6000
G1 X97.364 Y83.165 E.01432
G1 X97.364 Y80.437 E.05366
G1 X96.636 Y80.437 E.01432
G1 X96.636 Y83.105 E.05248
M204 S10000
G1 X97 Y82.801 F18000
; LINE_WIDTH: 0.359702
G1 F1500
M204 S6000
G1 X97 Y80.861 E.03232
; WIPE_START
G1 X97 Y82.801 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X95.145 Y77.438 Z2.04 F18000
G1 Z1.64
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.147962
G1 F1500
M204 S6000
G1 X94.845 Y77.115 E.00269
G1 X94.783 Y77.067 E.00048
G1 X94.533 Y76.949 E.00169
; WIPE_START
G1 X94.783 Y77.067 E-.13198
G1 X94.845 Y77.115 E-.03759
G1 X95.145 Y77.438 E-.21042
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X87.517 Y77.168 Z2.04 F18000
G1 X81.502 Y76.955 Z2.04
G1 Z1.64
G1 E.4 F1800
; LINE_WIDTH: 0.0895223
G1 F1500
M204 S6000
G1 X81.396 Y76.991 E.00036
; LINE_WIDTH: 0.128716
G1 X81.194 Y77.082 E.00114
; LINE_WIDTH: 0.152436
G1 X81.071 Y77.192 E.00104
G1 X80.956 Y77.329 E.00112
G1 X80.913 Y77.421 E.00065
; LINE_WIDTH: 0.115568
G1 X80.883 Y77.513 E.00043
; LINE_WIDTH: 0.0898933
G1 X80.854 Y77.604 E.00031
; CHANGE_LAYER
; Z_HEIGHT: 1.76
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F1500
G1 X80.883 Y77.513 E-.38
; WIPE_END
G1 E-.02 F1800
; layer num/total_layer_count: 14/49
; update layer progress
M73 L14
M991 S0 P13 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z2.04 I-.894 J.826 P1  F18000
G1 X95.29 Y93.111 Z2.04
G1 Z1.76
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X95.29 Y89.691 E.06727
G1 X98.71 Y89.691 E.06727
G1 X98.71 Y93.111 E.06727
G1 X95.35 Y93.111 E.06609
; WIPE_START
M204 S6000
G1 X95.315 Y91.111 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X89.836 Y96.425 Z2.16 F18000
G1 X89.159 Y97.081 Z2.16
G1 Z1.76
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X88.766 Y96.954 E.00874
G1 X88.393 Y96.88 E.00804
G1 X87.879 Y96.857 E.0109
G1 X87.501 Y96.897 E.00804
G1 X87.131 Y96.981 E.00804
G1 X86.837 Y97.097 E.00668
G1 X86.722 Y96.929 E.00429
G1 X87.078 Y96.544 E.01109
G1 X88.922 Y96.544 E.03904
G1 X89.265 Y96.916 E.0107
G1 X89.191 Y97.031 E.00289
; WIPE_START
M204 S6000
G1 X88.766 Y96.954 E-.08209
G1 X88.393 Y96.88 E-.07222
G1 X87.879 Y96.857 E-.09783
G1 X87.501 Y96.897 E-.07217
G1 X87.215 Y96.962 E-.05569
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X90.617 Y99.846 Z2.16 F18000
G1 Z1.76
G1 E.4 F1800
G1 F1500
M204 S500
G1 X90.622 Y99.901 E.00118
G1 X90.579 Y100.372 E.01001
G1 X90.442 Y100.849 E.0105
G1 X90.325 Y101.109 E.00604
G1 X90.16 Y101.385 E.0068
G1 X89.868 Y101.741 E.00975
G1 X89.516 Y102.039 E.00975
G1 X89.243 Y102.208 E.0068
G1 X88.984 Y102.329 E.00604
G1 X88.51 Y102.473 E.0105
G1 X88.048 Y102.521 E.00982
G1 X87.728 Y102.507 E.0068
G1 X87.446 Y102.462 E.00605
G1 X86.973 Y102.313 E.01049
G1 X86.556 Y102.089 E.01002
G1 X86.188 Y101.796 E.00995
G1 X85.879 Y101.442 E.00995
G1 X85.643 Y101.046 E.00975
G1 X85.52 Y100.748 E.00683
G1 X85.434 Y100.437 E.00683
G1 X85.379 Y99.979 E.00975
G1 X85.407 Y99.519 E.00975
G1 X85.474 Y99.205 E.0068
G1 X85.565 Y98.934 E.00604
G1 X85.789 Y98.492 E.0105
G1 X86.078 Y98.118 E.01002
G1 X86.427 Y97.803 E.00995
G1 X86.827 Y97.556 E.00995
G1 X87.256 Y97.388 E.00975
G1 X87.571 Y97.316 E.00683
G1 X87.892 Y97.282 E.00683
G1 X88.343 Y97.302 E.00955
G1 X88.659 Y97.365 E.00683
G1 X88.966 Y97.465 E.00683
G1 X89.378 Y97.671 E.00975
G1 X89.747 Y97.947 E.00975
G1 X89.973 Y98.177 E.00683
G1 X90.171 Y98.432 E.00683
G1 X90.391 Y98.826 E.00955
G1 X90.504 Y99.129 E.00683
G1 X90.58 Y99.442 E.00683
G1 X90.611 Y99.786 E.0073
M204 S250
G1 X90.209 Y99.882 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X90.211 Y99.901 E.00037
G1 X90.175 Y100.297 E.00782
G1 X90.057 Y100.708 E.00841
G1 X89.962 Y100.92 E.00457
G1 X89.825 Y101.149 E.00525
G1 X89.575 Y101.452 E.00773
G1 X89.275 Y101.707 E.00773
G1 X89.048 Y101.847 E.00525
G1 X88.837 Y101.946 E.00457
G1 X88.428 Y102.07 E.0084
G1 X88.036 Y102.111 E.00776
G1 X87.77 Y102.099 E.00525
G1 X87.54 Y102.062 E.00458
G1 X87.132 Y101.934 E.00841
G1 X86.782 Y101.746 E.00782
G1 X86.472 Y101.499 E.0078
G1 X86.211 Y101.2 E.0078
G1 X86.01 Y100.863 E.00773
G1 X85.908 Y100.615 E.00526
G1 X85.837 Y100.357 E.00526
G1 X85.79 Y99.967 E.00773
G1 X85.814 Y99.574 E.00774
G1 X85.869 Y99.313 E.00525
G1 X85.943 Y99.093 E.00457
G1 X86.136 Y98.712 E.00841
G1 X86.379 Y98.397 E.00782
G1 X86.674 Y98.132 E.0078
G1 X87.011 Y97.924 E.0078
G1 X87.377 Y97.78 E.00773
G1 X87.638 Y97.72 E.00526
G1 X87.904 Y97.692 E.00526
G1 X88.294 Y97.71 E.00767
G1 X88.556 Y97.762 E.00526
G1 X88.811 Y97.844 E.00526
G1 X89.162 Y98.02 E.00774
G1 X89.477 Y98.256 E.00773
G1 X89.665 Y98.447 E.00526
G1 X89.828 Y98.658 E.00526
G1 X90.018 Y98.999 E.00767
G1 X90.112 Y99.249 E.00526
G1 X90.176 Y99.509 E.00526
G1 X90.204 Y99.822 E.00618
; WIPE_START
M204 S6000
G1 X90.211 Y99.901 E-.01496
G1 X90.175 Y100.297 E-.0755
G1 X90.057 Y100.708 E-.08122
G1 X89.962 Y100.92 E-.04419
G1 X89.825 Y101.149 E-.05073
G1 X89.575 Y101.452 E-.07471
G1 X89.42 Y101.584 E-.03869
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X86.835 Y96.12 Z2.16 F18000
G1 Z1.76
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X94.064 Y96.12 E.15302
G1 X94.387 Y96.053 E.00697
G1 X94.649 Y95.899 E.00644
G1 X94.649 Y96.46 E.01188
G1 X94.464 Y96.482 E.00394
G1 X89.442 Y96.482 E.1063
G1 X90.545 Y97.676 E.03443
G1 X90.758 Y97.95 E.00733
G1 X91.002 Y98.348 E.00988
G1 X91.167 Y98.72 E.00861
G1 X91.326 Y99.3 E.01273
G1 X91.355 Y99.49 E.00406
G1 X91.374 Y100.092 E.01276
G1 X91.289 Y100.681 E.01259
G1 X91.168 Y101.079 E.0088
G1 X90.914 Y101.613 E.01254
G1 X90.57 Y102.096 E.01254
G1 X90.285 Y102.391 E.00869
G1 X89.967 Y102.65 E.00869
G1 X89.643 Y102.855 E.0081
G1 X89.273 Y103.032 E.00869
G1 X88.884 Y103.164 E.00869
G1 X88.292 Y103.269 E.01273
G1 X87.699 Y103.267 E.01254
G1 X87.116 Y103.163 E.01254
G1 X86.73 Y103.033 E.00862
G1 X86.312 Y102.827 E.00988
G1 X85.874 Y102.529 E.01122
G1 X85.571 Y102.251 E.00868
G1 X85.31 Y101.946 E.0085
G1 X85.086 Y101.613 E.00849
G1 X84.9 Y101.248 E.00869
G1 X84.729 Y100.746 E.01122
G1 X84.643 Y100.287 E.00988
G1 X84.62 Y99.89 E.00842
G1 X84.645 Y99.49 E.00849
G1 X84.718 Y99.095 E.0085
G1 X84.837 Y98.711 E.00849
G1 X85 Y98.345 E.00849
G1 X85.205 Y98 E.00849
G1 X85.456 Y97.675 E.00869
G1 X86.558 Y96.482 E.03439
G1 X81.536 Y96.482 E.1063
G1 X81.298 Y96.454 E.00508
G1 X81.098 Y96.381 E.0045
G1 X80.968 Y96.301 E.00324
G1 X80.832 Y96.173 E.00394
G1 X80.739 Y96.04 E.00343
G1 X80.649 Y95.821 E.00501
G1 X80.619 Y95.565 E.00546
G1 X80.619 Y77.619 E.37984
G1 X80.659 Y77.349 E.00578
G1 X80.765 Y77.118 E.00539
G1 X80.935 Y76.928 E.00539
G1 X81.062 Y76.839 E.00329
G1 X81.19 Y76.779 E.00298
G1 X81.458 Y76.723 E.0058
G1 X94.487 Y76.721 E.27576
G1 X94.645 Y76.74 E.00338
G1 X94.646 Y77.301 E.01187
G1 X94.386 Y77.149 E.00637
G1 X94.064 Y77.082 E.00697
G1 X81.952 Y77.082 E.25636
G1 X81.686 Y77.123 E.00571
G1 X81.389 Y77.275 E.00704
G1 X81.164 Y77.505 E.00682
G1 X81.018 Y77.8 E.00697
G1 X80.981 Y78.056 E.00547
G1 X80.981 Y95.144 E.36168
G1 X81.013 Y95.375 E.00493
G1 X81.115 Y95.619 E.0056
G1 X81.296 Y95.847 E.00617
G1 X81.562 Y96.034 E.00688
G1 X81.928 Y96.12 E.00795
G1 X86.775 Y96.12 E.10259
; WIPE_START
M204 S6000
G1 X88.775 Y96.12 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X85.623 Y96.891 Z2.16 F18000
G1 Z1.76
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X81.512 Y96.891 E.08086
G1 X81.203 Y96.855 E.00613
G1 X80.919 Y96.751 E.00594
G1 X80.728 Y96.633 E.00442
G1 X80.615 Y96.539 E.00289
G1 X80.514 Y96.432 E.00289
G1 X80.384 Y96.246 E.00448
G1 X80.287 Y96.039 E.00448
G1 X80.247 Y95.904 E.00277
G1 X80.21 Y95.589 E.00625
G1 X80.21 Y77.607 E.35368
G1 X80.219 Y77.454 E.00301
G1 X80.265 Y77.231 E.00448
G1 X80.349 Y77.019 E.00448
G1 X80.422 Y76.892 E.00289
G1 X80.51 Y76.774 E.00289
G1 X80.671 Y76.613 E.00447
G1 X80.856 Y76.484 E.00444
G1 X81.041 Y76.397 E.00402
G1 X81.201 Y76.347 E.0033
G1 X81.428 Y76.313 E.00452
G1 X94.512 Y76.312 E.25734
G1 X94.797 Y76.347 E.00565
G1 X95.08 Y76.45 E.00594
G1 X95.285 Y76.579 E.00477
G1 X95.487 Y76.772 E.00548
G1 X95.653 Y77.025 E.00596
G1 X95.735 Y77.231 E.00436
G1 X95.78 Y77.451 E.00441
G1 X95.796 Y78.011 E.01102
G1 X99.417 Y78.012 E.07122
G1 X99.508 Y78.028 E.00184
G1 X99.613 Y78.077 E.00227
G1 X99.699 Y78.154 E.00227
G1 X99.747 Y78.227 E.00171
G1 X99.79 Y78.413 E.00377
G1 X99.789 Y85.214 E.13377
G1 X99.764 Y85.335 E.00242
G1 X99.724 Y85.415 E.00175
G1 X99.669 Y85.481 E.00171
G1 X99.571 Y85.549 E.00234
G1 X99.388 Y85.591 E.0037
G1 X94.584 Y85.59 E.09449
G1 X94.406 Y85.537 E.00365
G1 X94.277 Y85.417 E.00347
G1 X94.229 Y85.312 E.00227
G1 X94.21 Y85.186 E.00252
G1 X94.211 Y78.386 E.13373
G1 X94.227 Y78.293 E.00186
G1 X94.276 Y78.187 E.0023
G1 X94.33 Y78.122 E.00166
G1 X94.654 Y77.886 E.00789
G1 X94.369 Y77.613 E.00775
G1 X94.237 Y77.536 E.00301
G1 X94.022 Y77.491 E.00433
M73 P57 R10
G1 X81.984 Y77.491 E.23678
G1 X81.813 Y77.517 E.00339
G1 X81.635 Y77.609 E.00394
G1 X81.502 Y77.744 E.00374
G1 X81.414 Y77.923 E.00392
G1 X81.39 Y78.086 E.00323
G1 X81.39 Y95.115 E.33496
G1 X81.411 Y95.265 E.00298
G1 X81.471 Y95.409 E.00306
G1 X81.58 Y95.546 E.00345
G1 X81.733 Y95.653 E.00367
G1 X81.975 Y95.711 E.0049
G1 X94.022 Y95.711 E.23694
G1 X94.237 Y95.666 E.00433
G1 X94.369 Y95.589 E.003
G1 X94.654 Y95.316 E.00775
G1 X94.332 Y95.082 E.00783
G1 X94.261 Y94.991 E.00226
G1 X94.228 Y94.913 E.00167
G1 X94.21 Y94.786 E.00252
G1 X94.21 Y88.019 E.13309
G1 X94.237 Y87.865 E.00307
G1 X94.29 Y87.767 E.00221
G1 X94.426 Y87.654 E.00347
G1 X94.58 Y87.612 E.00315
G1 X99.41 Y87.612 E.095
G1 X99.556 Y87.646 E.00295
G1 X99.647 Y87.702 E.00209
G1 X99.737 Y87.81 E.00276
G1 X99.779 Y87.915 E.00221
G1 X99.79 Y94.782 E.13509
G1 X99.763 Y94.933 E.00301
G1 X99.693 Y95.055 E.00276
G1 X99.575 Y95.149 E.00298
G1 X99.416 Y95.19 E.00321
G1 X95.792 Y95.191 E.07129
G1 X95.788 Y95.672 E.00946
G1 X95.754 Y95.898 E.0045
G1 X95.684 Y96.112 E.00442
G1 X95.577 Y96.309 E.00442
G1 X95.438 Y96.486 E.00442
G1 X95.272 Y96.633 E.00436
G1 X95.008 Y96.786 E.00601
G1 X94.8 Y96.854 E.0043
G1 X94.488 Y96.891 E.00619
G1 X90.377 Y96.891 E.08086
G1 X90.858 Y97.411 E.01394
G1 X91.095 Y97.717 E.00761
G1 X91.365 Y98.157 E.01016
G1 X91.548 Y98.57 E.00889
G1 X91.619 Y98.777 E.00431
G1 X91.728 Y99.22 E.00897
G1 X91.782 Y99.661 E.00873
G1 X91.784 Y100.114 E.00892
G1 X91.741 Y100.499 E.00762
G1 X91.687 Y100.779 E.00562
G1 X91.555 Y101.214 E.00894
G1 X91.473 Y101.418 E.0043
G1 X91.267 Y101.821 E.00891
G1 X91.015 Y102.197 E.00891
G1 X90.877 Y102.368 E.0043
G1 X90.562 Y102.693 E.00891
G1 X90.211 Y102.979 E.00891
G1 X89.836 Y103.216 E.00873
G1 X89.427 Y103.412 E.00891
G1 X88.998 Y103.557 E.00891
G1 X88.785 Y103.609 E.00431
G1 X88.334 Y103.676 E.00897
G1 X88.116 Y103.689 E.00431
G1 X87.663 Y103.676 E.00891
G1 X87.215 Y103.608 E.00891
G1 X87.002 Y103.557 E.00431
G1 X86.574 Y103.412 E.00889
G1 X86.111 Y103.184 E.01016
G1 X85.61 Y102.842 E.01192
G1 X85.277 Y102.536 E.00891
G1 X84.983 Y102.195 E.00885
G1 X84.733 Y101.821 E.00885
G1 X84.527 Y101.418 E.00891
G1 X84.331 Y100.844 E.01192
G1 X84.236 Y100.337 E.01016
G1 X84.21 Y99.889 E.00883
G1 X84.239 Y99.44 E.00885
G1 X84.32 Y98.997 E.00885
G1 X84.453 Y98.567 E.00885
G1 X84.636 Y98.156 E.00885
G1 X84.866 Y97.77 E.00885
G1 X85.143 Y97.411 E.00891
G1 X85.583 Y96.935 E.01275
; WIPE_START
M204 S6000
G1 X83.583 Y96.913 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G17
G3 Z2.16 I1.217 J0 P1  F18000
;===================== date: 20250206 =====================

; don't support timelapse gcode in spiral_mode and by object sequence for I3 structure printer
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
G92 E0
G1 Z2.16
G1 X0 Y90 ; move to safe pos
G1 X-13.0 F3000 ; move to safe pos
M400
M1004 S5 P1  ; external shutter
M400 P300
M971 S11 C11 O0
G92 E0
G1 X0 F18000
M623

; SKIPTYPE: head_wrap_detect
M622.1 S1
M1002 judge_flag g39_3rd_layer_detect_flag
M622 J1
    ; enable nozzle clog detect at 3rd layer
    


    M622.1 S1
    M1002 judge_flag g39_detection_flag
    M622 J1
      
        M622.1 S0
        M1002 judge_flag g39_mass_exceed_flag
        M622 J1
        
            G392 S0
            M400
            G90
            M83
            M204 S5000
            G0 Z2.16 F4000
            G39.3 S1
            G0 Z2.16 F4000
            G392 S0
          
        M623
    
    M623
M623
; SKIPPABLE_END




G1 X81.444 Y96.248
G1 Z1.76
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.147255
G1 F1500
M204 S6000
G1 X81.221 Y96.132 E.00152
G1 X81.089 Y96.037 E.00098
G1 X80.849 Y95.684 E.00259
M204 S10000
G1 X80.863 Y95.626 F18000
; LINE_WIDTH: 0.0997474
G1 F1500
M204 S6000
G1 X81 Y96.032 E.00158
; WIPE_START
G1 X80.863 Y95.626 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X85.521 Y98.215 Z2.16 F18000
G1 Z1.76
G1 E.4 F1800
; LINE_WIDTH: 0.359439
G1 F1500
M204 S6000
G1 X85.342 Y98.522 E.00592
G1 X85.221 Y98.778 E.0047
G1 X85.112 Y99.096 E.00561
G1 X85.031 Y99.481 E.00654
G1 X85.003 Y99.891 E.00684
G1 X85.024 Y100.241 E.00583
G1 X85.099 Y100.654 E.007
G1 X85.189 Y100.945 E.00506
G1 X85.419 Y101.42 E.0088
G1 X85.613 Y101.716 E.00588
G1 X85.919 Y102.057 E.00762
G1 X86.244 Y102.33 E.00707
G1 X86.5 Y102.493 E.00505
G1 X86.874 Y102.68 E.00696
G1 X87.372 Y102.834 E.00868
G1 X87.731 Y102.888 E.00605
G1 X88.257 Y102.885 E.00876
G1 X88.628 Y102.834 E.00624
G1 X89.129 Y102.68 E.00873
G1 X89.429 Y102.532 E.00556
G1 X89.746 Y102.334 E.00622
G1 X90.124 Y102.014 E.00825
G1 X90.379 Y101.722 E.00645
G1 X90.584 Y101.42 E.00609
G1 X90.799 Y100.967 E.00834
G1 X90.944 Y100.456 E.00885
G1 X90.991 Y100.071 E.00645
G1 X90.995 Y99.886 E.00307
G1 X90.954 Y99.376 E.00852
G1 X90.809 Y98.855 E.00901
G1 X90.662 Y98.527 E.00599
G1 X90.445 Y98.166 E.007
G1 X90.255 Y97.922 E.00514
G1 X89.991 Y97.647 E.00635
; LINE_WIDTH: 0.397659
G1 X89.807 Y97.48 E.00462
; LINE_WIDTH: 0.442825
G1 X89.622 Y97.314 E.00518
; LINE_WIDTH: 0.480637
G1 X89.38 Y97.129 E.0069
; WIPE_START
G1 X89.622 Y97.314 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X86.605 Y97.133 Z2.16 F18000
G1 Z1.76
G1 E.4 F1800
; LINE_WIDTH: 0.471298
G1 F1500
M204 S6000
G1 X86.402 Y97.301 E.00586
; LINE_WIDTH: 0.42892
G1 X86.173 Y97.492 E.00599
; LINE_WIDTH: 0.373095
G1 X85.79 Y97.871 E.00933
G1 X85.521 Y98.215 E.00757
; WIPE_START
G1 X85.79 Y97.871 E-.1702
G1 X86.173 Y97.492 E-.2098
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X93.627 Y95.855 Z2.16 F18000
G1 X94.658 Y95.628 Z2.16
G1 Z1.76
G1 E.4 F1800
; LINE_WIDTH: 0.0983109
G1 F1500
M204 S6000
G1 X94.853 Y95.481 E.00089
; WIPE_START
G1 X94.658 Y95.628 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X98.686 Y94.973 Z2.16 F18000
G1 Z1.76
G1 E.4 F1800
; FEATURE: Top surface
; LINE_WIDTH: 0.42
G1 F1500
M204 S2000
G1 X99.573 Y94.086 E.02467
G1 X99.573 Y93.529
G1 X98.129 Y94.973 E.04018
G1 X97.571 Y94.974
G1 X99.573 Y92.971 E.05569
G1 X98.927 Y93.06
G1 X99.573 Y92.414 E.01798
G1 X99.573 Y91.856
G1 X98.927 Y92.503 E.01798
G1 X98.927 Y91.945
G1 X99.573 Y91.299 E.01798
G1 X99.573 Y90.741
G1 X98.927 Y91.388 E.01798
G1 X98.927 Y90.83
G1 X99.573 Y90.184 E.01798
G1 X99.573 Y89.626
G1 X98.927 Y90.273 E.01798
G1 X98.927 Y89.715
G1 X99.573 Y89.069 E.01798
G1 X99.573 Y88.511
G1 X98.61 Y89.474 E.02679
G1 X98.053 Y89.474
G1 X99.565 Y87.962 E.04206
G1 X99.14 Y87.829
G1 X97.495 Y89.474 E.04577
G1 X96.938 Y89.474
G1 X98.583 Y87.829 E.04577
G1 X98.025 Y87.829
G1 X96.38 Y89.474 E.04577
G1 X95.823 Y89.474
G1 X97.468 Y87.829 E.04577
G1 X96.91 Y87.829
G1 X95.265 Y89.474 E.04577
; WIPE_START
M204 S6000
G1 X96.679 Y88.06 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X98.659 Y93.328 Z2.16 F18000
G1 Z1.76
G1 E.4 F1800
G1 F1500
M204 S2000
G1 X97.013 Y94.974 E.04579
G1 X96.456 Y94.974
G1 X98.102 Y93.328 E.04579
G1 X97.544 Y93.328
G1 X95.898 Y94.974 E.0458
G1 X95.574 Y95.298
G1 X94.881 Y95.991 E.01929
G1 X94.881 Y95.434
G1 X96.987 Y93.328 E.05858
G1 X96.429 Y93.328
G1 X94.686 Y95.071 E.0485
G1 X94.427 Y94.772
G1 X95.872 Y93.328 E.04018
G1 X95.314 Y93.328
G1 X94.427 Y94.215 E.02468
G1 X94.427 Y93.657
G1 X95.073 Y93.011 E.01798
G1 X95.073 Y92.454
G1 X94.427 Y93.1 E.01798
G1 X94.427 Y92.542
G1 X95.073 Y91.896 E.01798
G1 X95.073 Y91.338
G1 X94.427 Y91.985 E.01798
G1 X94.427 Y91.427
G1 X95.073 Y90.781 E.01798
G1 X95.073 Y90.223
G1 X94.427 Y90.87 E.01798
G1 X94.427 Y90.312
G1 X95.073 Y89.666 E.01798
G1 X94.427 Y89.755
G1 X96.353 Y87.829 E.05357
G1 X95.795 Y87.829
G1 X94.427 Y89.197 E.03806
G1 X94.427 Y88.64
G1 X95.238 Y87.829 E.02255
; WIPE_START
M204 S6000
G1 X94.427 Y88.64 E-.21787
G1 X94.427 Y89.197 E-.10593
G1 X94.636 Y88.988 E-.05619
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X95.586 Y95.691 Z2.16 F18000
G1 Z1.76
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.330914
G1 F1500
M204 S6000
G1 X95.274 Y96.11 E.00795
; LINE_WIDTH: 0.373336
G1 X95.142 Y96.253 E.00337
G1 X95.049 Y96.316 E.00196
; LINE_WIDTH: 0.377799
G1 X95.002 Y96.257 E.00133
; LINE_WIDTH: 0.330494
G1 X94.955 Y96.197 E.00115
; LINE_WIDTH: 0.283189
G1 X94.908 Y96.138 E.00097
; LINE_WIDTH: 0.235883
G1 X94.861 Y96.079 E.00079
; WIPE_START
G1 X94.908 Y96.138 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X97.508 Y88.962 Z2.16 F18000
G1 X98.808 Y85.374 Z2.16
G1 Z1.76
G1 E.4 F1800
; FEATURE: Top surface
; LINE_WIDTH: 0.42
G1 F1500
M204 S2000
G1 X99.572 Y84.609 E.02127
G1 X99.572 Y84.052
G1 X98.25 Y85.374 E.03678
G1 X97.693 Y85.374
G1 X99.572 Y83.494 E.05229
G1 X99.573 Y82.936
G1 X97.135 Y85.374 E.0678
G1 X96.578 Y85.373
G1 X99.573 Y82.379 E.0833
G1 X99.573 Y81.821
G1 X96.02 Y85.373 E.09881
G1 X95.463 Y85.373
G1 X99.573 Y81.263 E.11432
G1 X99.573 Y80.706
G1 X94.906 Y85.373 E.12983
G1 X94.443 Y85.278
G1 X99.573 Y80.148 E.1427
G1 X99.573 Y79.591
G1 X94.427 Y84.737 E.14315
G1 X94.427 Y84.179
G1 X96.819 Y81.787 E.06655
G1 X96.986 Y81.62
G1 X99.573 Y79.033 E.07196
G1 X99.573 Y78.475
G1 X94.427 Y83.622 E.14315
G1 X94.427 Y83.064
G1 X99.262 Y78.229 E.1345
G1 X98.705 Y78.229
G1 X94.427 Y82.506 E.11899
G1 X94.427 Y81.949
G1 X98.148 Y78.228 E.10349
G1 X97.59 Y78.228
G1 X94.427 Y81.391 E.08798
G1 X94.427 Y80.833
G1 X97.033 Y78.228 E.07247
G1 X96.475 Y78.228
G1 X94.427 Y80.276 E.05697
G1 X94.428 Y79.718
G1 X95.918 Y78.228 E.04146
G1 X95.579 Y78.01
G1 X94.428 Y79.161 E.03202
G1 X94.428 Y78.603
G1 X95.563 Y77.468 E.03157
G1 X95.415 Y77.058
G1 X94.878 Y77.595 E.01493
; WIPE_START
M204 S6000
G1 X95.415 Y77.058 E-.14427
G1 X95.563 Y77.468 E-.08281
G1 X94.993 Y78.037 E-.15292
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X99.587 Y78.373 Z2.16 F18000
G1 Z1.76
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.151561
G1 F1500
M204 S6000
G1 X99.475 Y78.295 E.00086
G1 X99.273 Y78.209 E.00137
; WIPE_START
G1 X99.475 Y78.295 E-.23409
G1 X99.587 Y78.373 E-.14591
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X95.352 Y76.965 Z2.16 F18000
G1 Z1.76
G1 E.4 F1800
; LINE_WIDTH: 0.0779935
G1 F1500
M204 S6000
G1 X95.295 Y76.899 E.00023
; LINE_WIDTH: 0.0933127
G1 X95.076 Y76.828 E.00078
; LINE_WIDTH: 0.119369
G1 X94.857 Y76.758 E.00107
M204 S10000
G1 X94.658 Y77.573 F18000
; LINE_WIDTH: 0.098111
M73 P58 R10
G1 F1500
M204 S6000
G1 X94.851 Y77.719 E.00087
; WIPE_START
G1 X94.658 Y77.573 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X87.034 Y77.215 Z2.16 F18000
G1 X81.502 Y76.955 Z2.16
G1 Z1.76
G1 E.4 F1800
; LINE_WIDTH: 0.0994002
G1 F1500
M204 S6000
G1 X81.351 Y77.002 E.00058
; LINE_WIDTH: 0.148298
G1 X81.222 Y77.062 E.00087
G1 X81.118 Y77.146 E.00082
G1 X80.964 Y77.319 E.00142
G1 X80.911 Y77.423 E.00071
; LINE_WIDTH: 0.101716
G1 X80.854 Y77.604 E.00072
; CHANGE_LAYER
; Z_HEIGHT: 1.88
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F1500
G1 X80.911 Y77.423 E-.38
; WIPE_END
G1 E-.02 F1800
; layer num/total_layer_count: 15/49
; update layer progress
M73 L15
M991 S0 P14 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z2.16 I-1.122 J.471 P1  F18000
G1 X89.159 Y97.081 Z2.16
G1 Z1.88
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X88.766 Y96.954 E.00873
G1 X88.393 Y96.88 E.00805
G1 X87.863 Y96.856 E.01123
G1 X87.322 Y96.93 E.01157
G1 X86.766 Y97.11 E.01237
G1 X86.659 Y96.949 E.0041
G1 X87.012 Y96.543 E.01138
G1 X88.92 Y96.543 E.0404
G1 X89.265 Y96.915 E.01074
G1 X89.191 Y97.031 E.00289
; WIPE_START
M204 S6000
G1 X88.766 Y96.954 E-.08203
G1 X88.393 Y96.88 E-.07222
G1 X87.863 Y96.856 E-.1008
G1 X87.322 Y96.93 E-.10385
G1 X87.216 Y96.964 E-.0211
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X90.617 Y99.846 Z2.28 F18000
G1 Z1.88
G1 E.4 F1800
G1 F1500
M204 S500
G1 X90.622 Y99.901 E.00117
G1 X90.58 Y100.369 E.00995
G1 X90.457 Y100.813 E.00975
G1 X90.326 Y101.108 E.00683
G1 X90.16 Y101.385 E.00683
G1 X89.868 Y101.741 E.00975
G1 X89.516 Y102.039 E.00975
G1 X89.243 Y102.208 E.0068
G1 X88.987 Y102.328 E.00599
G1 X88.51 Y102.473 E.01055
G1 X88.048 Y102.521 E.00983
G1 X87.728 Y102.507 E.00679
G1 X87.448 Y102.462 E.00599
G1 X86.973 Y102.313 E.01055
G1 X86.556 Y102.089 E.01002
G1 X86.195 Y101.802 E.00975
G1 X85.976 Y101.565 E.00683
G1 X85.786 Y101.304 E.00683
G1 X85.574 Y100.895 E.00975
G1 X85.436 Y100.446 E.00995
G1 X85.379 Y99.979 E.00995
G1 X85.407 Y99.519 E.00975
G1 X85.474 Y99.205 E.00679
G1 X85.564 Y98.937 E.00599
G1 X85.788 Y98.492 E.01055
G1 X86.078 Y98.118 E.01002
G1 X86.421 Y97.809 E.00975
G1 X86.69 Y97.632 E.00683
G1 X86.979 Y97.487 E.00683
G1 X87.416 Y97.345 E.00975
G1 X87.882 Y97.282 E.00995
G1 X88.343 Y97.302 E.00975
G1 X88.659 Y97.365 E.00683
G1 X88.966 Y97.465 E.00683
G1 X89.378 Y97.671 E.00975
G1 X89.747 Y97.947 E.00975
G1 X89.973 Y98.177 E.00683
G1 X90.173 Y98.435 E.00691
G1 X90.406 Y98.865 E.01035
G1 X90.504 Y99.13 E.00599
G1 X90.58 Y99.442 E.00679
G1 X90.611 Y99.786 E.00731
M204 S250
G1 X90.209 Y99.882 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X90.211 Y99.901 E.00037
G1 X90.175 Y100.296 E.00779
G1 X90.071 Y100.675 E.00773
G1 X89.962 Y100.919 E.00526
G1 X89.825 Y101.149 E.00526
G1 X89.575 Y101.452 E.00773
G1 X89.275 Y101.707 E.00773
G1 X89.048 Y101.847 E.00526
G1 X88.84 Y101.945 E.00452
G1 X88.428 Y102.07 E.00845
G1 X88.036 Y102.111 E.00776
G1 X87.77 Y102.099 E.00525
G1 X87.542 Y102.063 E.00453
G1 X87.132 Y101.934 E.00845
G1 X86.782 Y101.746 E.00782
G1 X86.475 Y101.501 E.00774
G1 X86.293 Y101.305 E.00526
G1 X86.135 Y101.088 E.00526
G1 X85.954 Y100.739 E.00773
G1 X85.837 Y100.361 E.0078
G1 X85.79 Y99.967 E.0078
G1 X85.814 Y99.574 E.00774
G1 X85.869 Y99.313 E.00525
G1 X85.942 Y99.095 E.00453
G1 X86.136 Y98.712 E.00845
G1 X86.379 Y98.397 E.00782
G1 X86.672 Y98.134 E.00774
G1 X86.895 Y97.987 E.00526
G1 X87.134 Y97.867 E.00526
G1 X87.508 Y97.746 E.00773
G1 X87.901 Y97.692 E.0078
G1 X88.294 Y97.71 E.00773
G1 X88.556 Y97.762 E.00526
G1 X88.811 Y97.844 E.00526
G1 X89.162 Y98.02 E.00773
G1 X89.477 Y98.256 E.00773
G1 X89.665 Y98.447 E.00526
G1 X89.829 Y98.659 E.00529
G1 X90.033 Y99.034 E.00839
G1 X90.112 Y99.25 E.00453
G1 X90.176 Y99.509 E.00525
G1 X90.204 Y99.823 E.00619
; WIPE_START
M204 S6000
G1 X90.211 Y99.901 E-.01494
G1 X90.175 Y100.296 E-.0753
G1 X90.071 Y100.675 E-.07471
G1 X89.962 Y100.919 E-.05084
G1 X89.825 Y101.149 E-.05083
G1 X89.575 Y101.452 E-.07471
G1 X89.42 Y101.584 E-.03867
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X86.761 Y96.119 Z2.28 F18000
G1 Z1.88
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X94.13 Y96.117 E.15597
G1 X94.414 Y96.04 E.00624
G1 X94.684 Y95.868 E.00677
G1 X94.892 Y95.609 E.00702
G1 X95.008 Y95.309 E.00682
G1 X95.013 Y94.72 E.01246
G1 X95.381 Y94.72 E.00777
G1 X95.381 Y95.565 E.01788
G1 X95.353 Y95.803 E.00508
G1 X95.28 Y96.003 E.0045
G1 X95.206 Y96.123 E.00298
G1 X95.093 Y96.247 E.00356
G1 X94.94 Y96.359 E.00401
G1 X94.751 Y96.441 E.00436
G1 X94.533 Y96.479 E.0047
G1 X89.442 Y96.483 E.10774
G1 X90.544 Y97.675 E.03436
G1 X90.795 Y98 E.00869
G1 X91 Y98.345 E.00849
G1 X91.167 Y98.72 E.00869
G1 X91.326 Y99.3 E.01273
G1 X91.38 Y99.892 E.01257
G1 X91.328 Y100.493 E.01279
G1 X91.171 Y101.071 E.01268
G1 X90.917 Y101.609 E.01259
G1 X90.69 Y101.947 E.0086
G1 X90.423 Y102.258 E.00869
G1 X90.027 Y102.604 E.01113
G1 X89.632 Y102.86 E.00997
G1 X89.273 Y103.032 E.00842
G1 X88.884 Y103.164 E.00869
G1 X88.301 Y103.267 E.01254
G1 X87.9 Y103.279 E.00849
G1 X87.5 Y103.243 E.00849
G1 X87.107 Y103.161 E.0085
G1 X86.727 Y103.032 E.00849
G1 X86.199 Y102.761 E.01257
G1 X85.92 Y102.563 E.00724
G1 X85.569 Y102.248 E.00998
G1 X85.31 Y101.946 E.00842
G1 X85.086 Y101.613 E.00849
G1 X84.902 Y101.252 E.00859
G1 X84.713 Y100.687 E.01259
G1 X84.641 Y100.282 E.00872
G1 X84.627 Y99.689 E.01254
G1 X84.676 Y99.291 E.00849
G1 X84.772 Y98.901 E.00849
G1 X84.913 Y98.526 E.00849
G1 X85.097 Y98.17 E.0085
G1 X85.323 Y97.838 E.00849
G1 X86.503 Y96.482 E.03805
G1 X81.536 Y96.482 E.10513
G1 X81.289 Y96.453 E.00527
G1 X81.079 Y96.372 E.00475
G1 X80.876 Y96.218 E.0054
G1 X80.791 Y96.12 E.00275
G1 X80.689 Y95.938 E.00442
G1 X80.648 Y95.814 E.00276
G1 X80.619 Y95.565 E.00532
G1 X80.619 Y77.628 E.37964
G1 X80.655 Y77.357 E.00578
G1 X80.76 Y77.125 E.00539
G1 X80.862 Y76.997 E.00348
G1 X80.966 Y76.903 E.00295
G1 X81.201 Y76.775 E.00568
G1 X81.452 Y76.723 E.00543
G1 X94.497 Y76.721 E.27611
G1 X94.659 Y76.736 E.00344
G1 X94.744 Y76.756 E.00183
G1 X94.976 Y76.861 E.00539
G1 X95.162 Y77.022 E.0052
G1 X95.283 Y77.208 E.00469
G1 X95.356 Y77.407 E.0045
G1 X95.378 Y77.559 E.00325
G1 X95.38 Y78.482 E.01952
G1 X95.019 Y78.482 E.00763
G1 X95.019 Y78.057 E.00899
G1 X94.983 Y77.806 E.00537
G1 X94.839 Y77.509 E.00697
G1 X94.631 Y77.292 E.00639
G1 X94.358 Y77.139 E.0066
G1 X94.088 Y77.082 E.00586
G1 X81.946 Y77.082 E.25699
G1 X81.657 Y77.133 E.0062
G1 X81.387 Y77.278 E.00649
G1 X81.171 Y77.495 E.00649
G1 X81.019 Y77.798 E.00717
G1 X80.981 Y78.056 E.00552
G1 X80.981 Y95.155 E.36192
G1 X81.035 Y95.462 E.00659
G1 X81.249 Y95.809 E.00864
G1 X81.591 Y96.049 E.00884
G1 X81.937 Y96.12 E.00747
G1 X86.701 Y96.119 E.10084
; WIPE_START
M204 S6000
G1 X88.701 Y96.119 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X85.605 Y96.891 Z2.28 F18000
G1 Z1.88
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X81.512 Y96.891 E.08049
G1 X81.2 Y96.854 E.00619
G1 X80.986 Y96.784 E.00442
G1 X80.862 Y96.721 E.00275
G1 X80.596 Y96.519 E.00657
G1 X80.384 Y96.247 E.00679
G1 X80.308 Y96.092 E.00339
G1 X80.247 Y95.902 E.00392
G1 X80.21 Y95.589 E.00621
G1 X80.21 Y77.61 E.35362
G1 X80.231 Y77.374 E.00466
G1 X80.264 Y77.234 E.00283
G1 X80.349 Y77.019 E.00454
G1 X80.421 Y76.895 E.00283
G1 X80.563 Y76.716 E.00449
G1 X80.713 Y76.58 E.00399
G1 X80.854 Y76.485 E.00333
G1 X81.06 Y76.389 E.00447
G1 X81.255 Y76.335 E.00398
G1 X81.426 Y76.313 E.00339
G1 X94.517 Y76.312 E.25748
G1 X94.726 Y76.331 E.00414
G1 X94.867 Y76.365 E.00284
G1 X95.081 Y76.45 E.00454
G1 X95.206 Y76.522 E.00283
G1 X95.387 Y76.665 E.00454
G1 X95.484 Y76.768 E.00277
G1 X95.652 Y77.023 E.006
G1 X95.755 Y77.307 E.00594
G1 X95.787 Y77.529 E.00442
G1 X95.79 Y78.891 E.02678
G1 X94.61 Y78.891 E.0232
G1 X94.61 Y78.086 E.01583
G1 X94.576 Y77.903 E.00366
G1 F1920
G1 X94.55 Y77.851 E.00113
G1 F1500
G1 X94.499 Y77.746 E.0023
G1 X94.377 Y77.619 E.00347
G1 X94.213 Y77.527 E.0037
G1 X94.045 Y77.492 E.00337
G1 X81.982 Y77.491 E.23728
G1 X81.793 Y77.524 E.00376
G1 X81.634 Y77.61 E.00355
G1 X81.507 Y77.738 E.00355
M73 P58 R9
G1 X81.414 Y77.922 E.00406
G1 X81.39 Y78.086 E.00325
G1 X81.39 Y95.119 E.33504
G1 X81.424 Y95.314 E.00388
G1 X81.553 Y95.522 E.00483
G1 X81.757 Y95.665 E.00489
G1 X81.979 Y95.711 E.00446
G1 X94.075 Y95.708 E.23793
G1 X94.247 Y95.662 E.00349
G1 X94.407 Y95.559 E.00375
G1 X94.533 Y95.402 E.00396
G1 X94.555 Y95.346 E.00117
G1 F1920
G1 X94.574 Y95.298 E.00103
G1 F1500
G1 X94.599 Y95.231 E.00141
G1 X94.608 Y94.311 E.01809
G1 X95.79 Y94.311 E.02325
G1 X95.79 Y95.589 E.02513
G1 X95.754 Y95.898 E.00613
G1 X95.65 Y96.182 E.00595
G1 X95.535 Y96.37 E.00434
G1 X95.368 Y96.553 E.00486
G1 X95.145 Y96.716 E.00545
G1 X94.87 Y96.835 E.0059
G1 X94.569 Y96.888 E.00601
G1 X90.377 Y96.891 E.08245
G1 X90.857 Y97.411 E.01392
G1 X91.134 Y97.77 E.00891
G1 X91.364 Y98.156 E.00885
G1 X91.548 Y98.57 E.00891
G1 X91.619 Y98.777 E.00431
G1 X91.728 Y99.22 E.00897
G1 X91.761 Y99.437 E.00431
G1 X91.79 Y99.889 E.00892
G1 X91.77 Y100.271 E.00752
G1 X91.687 Y100.778 E.0101
G1 X91.556 Y101.212 E.00892
G1 X91.404 Y101.563 E.00752
G1 X91.268 Y101.82 E.00571
G1 X91.017 Y102.195 E.00888
G1 X90.721 Y102.538 E.00891
G1 X90.269 Y102.934 E.01182
G1 X89.832 Y103.218 E.01025
G1 X89.427 Y103.412 E.00883
G1 X88.998 Y103.557 E.00891
G1 X88.785 Y103.608 E.0043
G1 X88.337 Y103.676 E.00891
G1 X87.887 Y103.689 E.00885
G1 X87.439 Y103.649 E.00885
G1 X86.999 Y103.556 E.00885
G1 X86.573 Y103.412 E.00885
G1 X86.164 Y103.216 E.00891
G1 X85.664 Y102.883 E.01182
G1 X85.276 Y102.535 E.01025
G1 X84.983 Y102.195 E.00883
G1 X84.733 Y101.821 E.00885
G1 X84.528 Y101.419 E.00888
G1 X84.423 Y101.148 E.00571
M73 P59 R9
G1 X84.314 Y100.782 E.00752
G1 X84.235 Y100.335 E.00892
G1 X84.216 Y100.117 E.00431
G1 X84.218 Y99.664 E.00891
G1 X84.273 Y99.217 E.00885
G1 X84.38 Y98.78 E.00885
G1 X84.538 Y98.359 E.00885
G1 X84.745 Y97.96 E.00885
G1 X84.998 Y97.588 E.00885
G1 X85.565 Y96.936 E.01698
; WIPE_START
M204 S6000
G1 X83.565 Y96.914 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G17
G3 Z2.28 I1.217 J0 P1  F18000
;===================== date: 20250206 =====================

; don't support timelapse gcode in spiral_mode and by object sequence for I3 structure printer
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
G92 E0
G1 Z2.28
G1 X0 Y90 ; move to safe pos
G1 X-13.0 F3000 ; move to safe pos
M400
M1004 S5 P1  ; external shutter
M400 P300
M971 S11 C11 O0
G92 E0
G1 X0 F18000
M623

; SKIPTYPE: head_wrap_detect
M622.1 S1
M1002 judge_flag g39_3rd_layer_detect_flag
M622 J1
    ; enable nozzle clog detect at 3rd layer
    


    M622.1 S1
    M1002 judge_flag g39_detection_flag
    M622 J1
      
        M622.1 S0
        M1002 judge_flag g39_mass_exceed_flag
        M622 J1
        
            G392 S0
            M400
            G90
            M83
            M204 S5000
            G0 Z2.28 F4000
            G39.3 S1
            G0 Z2.28 F4000
            G392 S0
          
        M623
    
    M623
M623
; SKIPPABLE_END




G1 X81.456 Y96.238
G1 Z1.88
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.09622
G1 F1500
M204 S6000
G1 X81.354 Y96.193 E.00039
; LINE_WIDTH: 0.148685
G1 X81.252 Y96.148 E.00069
G1 X81.064 Y96.015 E.00141
G1 X80.944 Y95.837 E.00132
; LINE_WIDTH: 0.131331
G1 X80.903 Y95.731 E.0006
; LINE_WIDTH: 0.0954832
G1 X80.861 Y95.625 E.0004
; WIPE_START
G1 X80.903 Y95.731 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X86.548 Y97.165 Z2.28 F18000
G1 Z1.88
G1 E.4 F1800
; LINE_WIDTH: 0.477112
G1 F1500
M204 S6000
G1 X86.367 Y97.319 E.00534
; LINE_WIDTH: 0.438387
G1 X86.16 Y97.496 E.00562
; LINE_WIDTH: 0.400599
G1 X85.986 Y97.673 E.00464
; LINE_WIDTH: 0.360732
G1 X85.628 Y98.073 E.00897
G1 X85.425 Y98.365 E.00594
G1 X85.211 Y98.803 E.00814
G1 X85.112 Y99.097 E.00519
G1 X85.051 Y99.36 E.00451
G1 X85.011 Y99.713 E.00595
G1 X85.007 Y100.079 E.0061
G1 X85.071 Y100.539 E.00776
G1 X85.219 Y101.025 E.00849
G1 X85.459 Y101.492 E.00877
G1 X85.678 Y101.797 E.00628
G1 X85.949 Y102.085 E.00661
G1 X86.36 Y102.412 E.00878
G1 X86.841 Y102.667 E.00909
G1 X87.209 Y102.79 E.00648
G1 X87.557 Y102.866 E.00595
G1 X88.047 Y102.898 E.00822
G1 X88.601 Y102.84 E.0093
G1 X89.112 Y102.686 E.00892
G1 X89.446 Y102.529 E.00617
G1 X89.748 Y102.336 E.00598
G1 X90.124 Y102.014 E.00828
G1 X90.386 Y101.713 E.00668
G1 X90.657 Y101.291 E.00837
G1 X90.814 Y100.941 E.00641
G1 X90.947 Y100.45 E.00849
G1 X91.001 Y99.894 E.00935
G1 X90.973 Y99.527 E.00615
G1 X90.869 Y99.029 E.0085
G1 X90.742 Y98.699 E.0059
G1 X90.483 Y98.217 E.00916
G1 X90.254 Y97.92 E.00626
G1 X89.991 Y97.647 E.00633
; LINE_WIDTH: 0.397646
G1 X89.807 Y97.48 E.00462
; LINE_WIDTH: 0.442809
G1 X89.622 Y97.314 E.00518
; LINE_WIDTH: 0.480632
G1 X89.38 Y97.129 E.0069
; WIPE_START
G1 X89.622 Y97.314 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X94.539 Y96.258 Z2.28 F18000
G1 Z1.88
G1 E.4 F1800
; LINE_WIDTH: 0.147788
G1 F1500
M204 S6000
G1 X94.876 Y96.067 E.00236
G1 X95.069 Y95.811 E.00195
; LINE_WIDTH: 0.117579
G1 X95.106 Y95.745 E.00035
; LINE_WIDTH: 0.0905085
G1 X95.135 Y95.633 E.00037
; WIPE_START
G1 X95.106 Y95.745 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X95.123 Y88.112 Z2.28 F18000
G1 X95.146 Y77.606 Z2.28
G1 Z1.88
G1 E.4 F1800
; LINE_WIDTH: 0.0957783
G1 F1500
M204 S6000
G1 X95.106 Y77.47 E.00049
; LINE_WIDTH: 0.124141
G1 X95.041 Y77.329 E.00076
; LINE_WIDTH: 0.155476
G1 X94.941 Y77.204 E.00104
G1 X94.781 Y77.064 E.00138
; LINE_WIDTH: 0.129774
G1 X94.515 Y76.944 E.00151
; WIPE_START
G1 X94.781 Y77.064 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X87.149 Y77.001 Z2.28 F18000
G1 X81.496 Y76.955 Z2.28
G1 Z1.88
G1 E.4 F1800
; LINE_WIDTH: 0.0898038
G1 F1500
M204 S6000
G1 X81.394 Y76.991 E.00035
; LINE_WIDTH: 0.130081
G1 X81.194 Y77.082 E.00114
; LINE_WIDTH: 0.152068
G1 X80.962 Y77.32 E.00209
G1 X80.907 Y77.434 E.0008
; LINE_WIDTH: 0.102619
G1 X80.857 Y77.598 E.00066
; WIPE_START
G1 X80.907 Y77.434 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X88.295 Y79.352 Z2.28 F18000
G1 X96.743 Y81.544 Z2.28
G1 Z1.88
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X97.257 Y81.544 E.01086
G1 X97.257 Y82.057 E.01086
G1 X96.743 Y82.057 E.01086
G1 X96.743 Y81.604 E.00959
M204 S10000
G1 X96.319 Y81.12 F18000
G1 F1500
M204 S500
G1 X97.681 Y81.12 E.02882
G1 X97.681 Y82.482 E.02882
G1 X96.319 Y82.482 E.02882
G1 X96.319 Y81.18 E.02755
M204 S250
G1 X95.91 Y80.711 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X98.09 Y80.711 E.04288
G1 X98.09 Y82.891 E.04288
G1 X95.91 Y82.891 E.04288
G1 X95.91 Y80.771 E.0417
; CHANGE_LAYER
; Z_HEIGHT: 2
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F1500
M204 S6000
G1 X97.909 Y80.716 E-.38
; WIPE_END
G1 E-.02 F1800
; layer num/total_layer_count: 16/49
; update layer progress
M73 L16
M991 S0 P15 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z2.28 I-1.075 J-.57 P1  F18000
G1 X89.219 Y97.116 Z2.28
G1 Z2
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X88.766 Y96.954 E.01019
G1 X88.393 Y96.88 E.00804
G1 X87.863 Y96.856 E.01123
G1 X87.322 Y96.93 E.01157
G1 X86.8 Y97.099 E.01161
G1 X86.693 Y96.936 E.00413
G1 X87.045 Y96.544 E.01114
G1 X88.989 Y96.544 E.04114
G1 X89.343 Y96.951 E.01143
G1 X89.255 Y97.068 E.00309
; WIPE_START
M204 S6000
G1 X88.766 Y96.954 E-.09545
G1 X88.393 Y96.88 E-.07222
G1 X87.863 Y96.856 E-.1008
G1 X87.322 Y96.93 E-.10386
G1 X87.283 Y96.942 E-.00768
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X90.617 Y99.846 Z2.4 F18000
G1 Z2
G1 E.4 F1800
G1 F1500
M204 S500
G1 X90.622 Y99.901 E.00116
G1 X90.579 Y100.372 E.01002
G1 X90.44 Y100.854 E.01061
G1 X90.325 Y101.109 E.00594
G1 X90.16 Y101.385 E.00679
G1 X89.868 Y101.741 E.00975
G1 X89.516 Y102.039 E.00975
G1 X89.243 Y102.207 E.00679
G1 X88.989 Y102.327 E.00593
G1 X88.51 Y102.473 E.0106
G1 X88.048 Y102.521 E.00983
G1 X87.726 Y102.507 E.00683
G1 X87.408 Y102.454 E.00683
G1 X86.97 Y102.312 E.00975
G1 X86.556 Y102.089 E.00995
G1 X86.188 Y101.796 E.00995
G1 X85.879 Y101.442 E.00995
G1 X85.643 Y101.046 E.00975
G1 X85.52 Y100.748 E.00683
G1 X85.434 Y100.437 E.00683
G1 X85.381 Y99.989 E.00955
G1 X85.39 Y99.666 E.00683
G1 X85.438 Y99.347 E.00683
G1 X85.574 Y98.906 E.00976
G1 X85.791 Y98.49 E.00994
G1 X86.08 Y98.115 E.01003
G1 X86.457 Y97.784 E.0106
G1 X86.691 Y97.631 E.00593
G1 X86.978 Y97.487 E.00679
G1 X87.416 Y97.345 E.00975
G1 X87.882 Y97.282 E.00995
G1 X88.343 Y97.302 E.00975
G1 X88.659 Y97.365 E.00683
G1 X88.957 Y97.462 E.00663
G1 X89.242 Y97.593 E.00664
G1 X89.516 Y97.763 E.00683
G1 X89.868 Y98.061 E.00975
G1 X90.16 Y98.417 E.00975
G1 X90.326 Y98.694 E.00683
G1 X90.457 Y98.989 E.00683
G1 X90.58 Y99.433 E.00975
G1 X90.611 Y99.786 E.00751
M204 S250
G1 X90.209 Y99.883 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X90.211 Y99.901 E.00036
G1 X90.175 Y100.297 E.00782
G1 X90.055 Y100.712 E.0085
G1 X89.962 Y100.92 E.00448
G1 X89.825 Y101.149 E.00525
G1 X89.575 Y101.452 E.00773
G1 X89.275 Y101.707 E.00773
G1 X89.048 Y101.847 E.00525
G1 X88.842 Y101.944 E.00447
G1 X88.429 Y102.07 E.0085
G1 X88.036 Y102.111 E.00776
G1 X87.769 Y102.099 E.00526
G1 X87.505 Y102.055 E.00527
G1 X87.131 Y101.934 E.00773
G1 X86.782 Y101.746 E.0078
G1 X86.472 Y101.499 E.00779
G1 X86.211 Y101.2 E.0078
G1 X86.01 Y100.863 E.00773
G1 X85.908 Y100.615 E.00526
G1 X85.837 Y100.357 E.00526
G1 X85.791 Y99.97 E.00767
G1 X85.799 Y99.703 E.00526
G1 X85.838 Y99.438 E.00526
G1 X85.954 Y99.062 E.00774
G1 X86.137 Y98.711 E.00779
G1 X86.38 Y98.396 E.00782
G1 X86.705 Y98.111 E.0085
G1 X86.895 Y97.986 E.00448
G1 X87.134 Y97.867 E.00525
G1 X87.508 Y97.746 E.00773
G1 X87.901 Y97.692 E.0078
G1 X88.294 Y97.71 E.00773
G1 X88.556 Y97.762 E.00526
G1 X88.808 Y97.843 E.0052
G1 X89.047 Y97.954 E.0052
G1 X89.275 Y98.095 E.00526
G1 X89.575 Y98.349 E.00773
G1 X89.825 Y98.653 E.00773
G1 X89.962 Y98.883 E.00526
G1 X90.071 Y99.127 E.00526
G1 X90.175 Y99.506 E.00774
G1 X90.204 Y99.823 E.00626
; WIPE_START
M204 S6000
G1 X90.211 Y99.901 E-.01486
G1 X90.175 Y100.297 E-.07552
G1 X90.055 Y100.712 E-.08215
G1 X89.962 Y100.92 E-.04326
G1 X89.825 Y101.149 E-.05071
G1 X89.575 Y101.452 E-.07471
G1 X89.419 Y101.584 E-.03879
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X86.798 Y96.12 Z2.4 F18000
G1 Z2
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X94.107 Y96.119 E.1547
G1 X94.406 Y96.044 E.00651
G1 X94.667 Y95.881 E.00652
G1 X94.865 Y95.653 E.00638
G1 X94.985 Y95.387 E.00618
G1 X95.019 Y95.145 E.00518
G1 X95.019 Y94.72 E.00899
G1 X95.381 Y94.72 E.00765
G1 X95.381 Y95.565 E.01788
G1 X95.353 Y95.803 E.00508
G1 X95.28 Y96.003 E.0045
G1 X95.207 Y96.122 E.00297
G1 X95.092 Y96.248 E.00359
G1 X94.94 Y96.359 E.00398
G1 X94.751 Y96.441 E.00436
G1 X94.533 Y96.479 E.0047
G1 X89.498 Y96.483 E.10657
G1 X90.678 Y97.839 E.03806
G1 X90.998 Y98.341 E.01259
G1 X91.167 Y98.72 E.00879
G1 X91.326 Y99.3 E.01273
G1 X91.38 Y99.89 E.01254
G1 X91.357 Y100.292 E.00853
G1 X91.237 Y100.875 E.0126
G1 X91.096 Y101.256 E.00859
G1 X90.909 Y101.622 E.00869
G1 X90.558 Y102.11 E.01273
G1 X90.292 Y102.385 E.00811
G1 X89.974 Y102.644 E.00869
G1 X89.635 Y102.859 E.00849
G1 X89.273 Y103.032 E.00849
G1 X88.884 Y103.164 E.00869
G1 X88.301 Y103.267 E.01254
G1 X87.9 Y103.279 E.00849
G1 X87.5 Y103.243 E.00849
G1 X87.106 Y103.16 E.00853
G1 X86.548 Y102.953 E.01259
G1 X86.192 Y102.757 E.00859
G1 X85.867 Y102.522 E.00849
G1 X85.571 Y102.251 E.0085
G1 X85.31 Y101.947 E.00849
G1 X85.086 Y101.613 E.0085
G1 X84.831 Y101.077 E.01257
G1 X84.731 Y100.754 E.00715
G1 X84.643 Y100.287 E.01007
G1 X84.62 Y99.89 E.00841
G1 X84.645 Y99.49 E.00849
G1 X84.718 Y99.095 E.00849
G1 X84.837 Y98.711 E.00849
G1 X85 Y98.345 E.00849
G1 X85.206 Y97.999 E.00853
G1 X85.411 Y97.73 E.00716
G1 X86.531 Y96.482 E.03549
G1 X81.536 Y96.482 E.10571
G1 X81.298 Y96.454 E.00508
G1 X81.024 Y96.34 E.00627
G1 X80.897 Y96.24 E.00343
G1 X80.789 Y96.119 E.00343
G1 X80.688 Y95.937 E.00441
G1 X80.648 Y95.814 E.00272
G1 X80.619 Y95.565 E.00532
G1 X80.619 Y77.619 E.37984
G1 X80.659 Y77.349 E.00577
G1 X80.76 Y77.125 E.0052
G1 X80.862 Y76.996 E.00348
G1 X80.965 Y76.904 E.00292
G1 X81.2 Y76.775 E.00567
G1 X81.449 Y76.723 E.00539
G1 X94.499 Y76.721 E.27622
G1 X94.659 Y76.736 E.00341
G1 X94.903 Y76.819 E.00544
G1 X94.983 Y76.866 E.00198
G1 X95.148 Y77.008 E.0046
G1 X95.28 Y77.195 E.00485
G1 X95.344 Y77.362 E.00378
G1 X95.378 Y77.566 E.00438
G1 X95.38 Y78.482 E.01938
G1 X95.019 Y78.482 E.00763
G1 X95.019 Y78.057 E.00899
G1 X94.985 Y77.815 E.00518
G1 X94.862 Y77.543 E.00632
G1 X94.638 Y77.296 E.00705
G1 X94.358 Y77.139 E.00679
G1 X94.088 Y77.082 E.00585
G1 X81.952 Y77.082 E.25687
G1 X81.684 Y77.124 E.00574
G1 X81.392 Y77.273 E.00694
G1 X81.171 Y77.495 E.00663
G1 X81.019 Y77.798 E.00717
G1 X80.981 Y78.056 E.00552
G1 X80.981 Y95.164 E.36211
G1 X81.05 Y95.501 E.00727
G1 X81.257 Y95.815 E.00796
G1 X81.591 Y96.049 E.00864
G1 X81.937 Y96.12 E.00747
G1 X86.738 Y96.12 E.10162
; WIPE_START
M204 S6000
G1 X88.738 Y96.119 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X85.614 Y96.891 Z2.4 F18000
G1 Z2
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X81.512 Y96.891 E.08067
G1 X81.203 Y96.855 E.00613
G1 X80.916 Y96.75 E.006
G1 X80.794 Y96.68 E.00277
G1 X80.615 Y96.539 E.00448
G1 X80.464 Y96.369 E.00448
G1 X80.384 Y96.247 E.00287
G1 X80.308 Y96.09 E.00343
G1 X80.247 Y95.902 E.00389
G1 X80.21 Y95.589 E.00621
G1 X80.21 Y77.607 E.35368
G1 X80.219 Y77.454 E.00301
G1 X80.265 Y77.231 E.00448
G1 X80.349 Y77.019 E.00448
G1 X80.421 Y76.895 E.00283
G1 X80.563 Y76.716 E.00449
G1 X80.712 Y76.581 E.00395
G1 X80.854 Y76.485 E.00337
G1 X81.059 Y76.389 E.00446
G1 X81.279 Y76.33 E.00448
G1 X81.425 Y76.313 E.00289
G1 X94.518 Y76.312 E.25753
G1 X94.726 Y76.331 E.00411
G1 X94.867 Y76.365 E.00284
G1 X95.081 Y76.45 E.00454
G1 X95.209 Y76.523 E.00289
G1 X95.453 Y76.733 E.00634
G1 X95.65 Y77.018 E.00682
G1 X95.741 Y77.254 E.00496
G1 X95.788 Y77.531 E.00554
G1 X95.79 Y78.891 E.02674
G1 X94.61 Y78.891 E.0232
G1 X94.61 Y78.086 E.01583
G1 X94.588 Y77.93 E.0031
G1 X94.515 Y77.77 E.00346
G1 X94.38 Y77.62 E.00397
G1 X94.213 Y77.527 E.00376
G1 X94.045 Y77.492 E.00337
G1 X81.984 Y77.491 E.23724
G1 X81.812 Y77.518 E.00341
G1 X81.636 Y77.608 E.0039
G1 X81.507 Y77.737 E.0036
G1 X81.414 Y77.922 E.00407
G1 X81.39 Y78.086 E.00325
G1 X81.39 Y95.122 E.3351
G1 X81.435 Y95.341 E.00439
G1 X81.556 Y95.524 E.00431
G1 X81.757 Y95.665 E.00483
G1 X81.979 Y95.711 E.00446
G1 X94.057 Y95.71 E.23757
G1 X94.243 Y95.663 E.00378
G1 X94.398 Y95.566 E.00358
G1 X94.516 Y95.43 E.00356
G1 X94.588 Y95.272 E.00341
G1 X94.61 Y95.116 E.0031
G1 X94.61 Y94.311 E.01583
G1 X95.79 Y94.311 E.02321
G1 X95.79 Y95.589 E.02513
G1 X95.754 Y95.898 E.00613
G1 X95.65 Y96.182 E.00594
G1 X95.535 Y96.37 E.00433
G1 X95.367 Y96.554 E.0049
G1 X95.145 Y96.717 E.00542
G1 X94.87 Y96.835 E.0059
G1 X94.569 Y96.888 E.00601
G1 X90.396 Y96.891 E.08208
G1 X91.002 Y97.588 E.01817
G1 X91.216 Y97.899 E.00743
G1 X91.363 Y98.155 E.0058
M73 P60 R9
G1 X91.548 Y98.57 E.00894
G1 X91.619 Y98.777 E.00431
G1 X91.728 Y99.22 E.00897
G1 X91.761 Y99.437 E.00431
G1 X91.79 Y99.889 E.00891
G1 X91.764 Y100.338 E.00886
G1 X91.701 Y100.711 E.00743
G1 X91.628 Y100.997 E.0058
G1 X91.472 Y101.42 E.00888
G1 X91.266 Y101.824 E.00891
G1 X91.149 Y102.009 E.0043
G1 X90.873 Y102.372 E.00897
G1 X90.565 Y102.691 E.00873
G1 X90.213 Y102.977 E.00891
G1 X89.833 Y103.218 E.00885
G1 X89.427 Y103.412 E.00885
G1 X88.998 Y103.557 E.00891
G1 X88.785 Y103.608 E.0043
G1 X88.337 Y103.676 E.00891
G1 X87.887 Y103.689 E.00885
G1 X87.439 Y103.649 E.00885
G1 X86.998 Y103.556 E.00886
G1 X86.64 Y103.437 E.00743
G1 X86.369 Y103.321 E.0058
G1 X85.973 Y103.103 E.00888
G1 X85.608 Y102.84 E.00885
G1 X85.277 Y102.536 E.00885
G1 X84.983 Y102.195 E.00885
G1 X84.733 Y101.821 E.00885
G1 X84.527 Y101.418 E.00891
G1 X84.334 Y100.853 E.01173
G1 X84.236 Y100.337 E.01034
G1 X84.21 Y99.889 E.00883
G1 X84.239 Y99.44 E.00885
G1 X84.32 Y98.997 E.00885
G1 X84.453 Y98.567 E.00885
G1 X84.636 Y98.156 E.00885
G1 X84.867 Y97.769 E.00886
G1 X85.096 Y97.469 E.00743
G1 X85.574 Y96.936 E.01409
; WIPE_START
M204 S6000
G1 X83.574 Y96.914 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G17
G3 Z2.4 I1.217 J0 P1  F18000
;===================== date: 20250206 =====================

; don't support timelapse gcode in spiral_mode and by object sequence for I3 structure printer
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
G92 E0
G1 Z2.4
G1 X0 Y90 ; move to safe pos
G1 X-13.0 F3000 ; move to safe pos
M400
M1004 S5 P1  ; external shutter
M400 P300
M971 S11 C11 O0
G92 E0
G1 X0 F18000
M623

; SKIPTYPE: head_wrap_detect
M622.1 S1
M1002 judge_flag g39_3rd_layer_detect_flag
M622 J1
    ; enable nozzle clog detect at 3rd layer
    


    M622.1 S1
    M1002 judge_flag g39_detection_flag
    M622 J1
      
        M622.1 S0
        M1002 judge_flag g39_mass_exceed_flag
        M622 J1
        
            G392 S0
            M400
            G90
            M83
            M204 S5000
            G0 Z2.4 F4000
            G39.3 S1
            G0 Z2.4 F4000
            G392 S0
          
        M623
    
    M623
M623
; SKIPPABLE_END




G1 X81.452 Y96.25
G1 Z2
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.149243
G1 F1500
M204 S6000
G1 X81.212 Y96.125 E.00167
G1 X81.088 Y96.036 E.00094
G1 X80.943 Y95.836 E.00152
; LINE_WIDTH: 0.13064
G1 X80.903 Y95.737 E.00056
; LINE_WIDTH: 0.095166
G1 X80.862 Y95.639 E.00037
; WIPE_START
G1 X80.903 Y95.737 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X86.579 Y97.15 Z2.4 F18000
G1 Z2
G1 E.4 F1800
; LINE_WIDTH: 0.478321
G1 F1500
M204 S6000
G1 X86.402 Y97.296 E.00519
; LINE_WIDTH: 0.442048
G1 X86.198 Y97.466 E.00553
; LINE_WIDTH: 0.404624
G1 X86.007 Y97.655 E.00508
; LINE_WIDTH: 0.360285
G1 X85.794 Y97.868 E.00501
G1 X85.465 Y98.299 E.00906
G1 X85.22 Y98.777 E.00897
G1 X85.089 Y99.186 E.00716
G1 X85.015 Y99.622 E.00739
G1 X85.005 Y100.018 E.0066
G1 X85.069 Y100.521 E.00847
G1 X85.189 Y100.944 E.00734
G1 X85.419 Y101.42 E.00882
G1 X85.613 Y101.716 E.0059
G1 X85.917 Y102.058 E.00764
G1 X86.336 Y102.395 E.00897
G1 X86.712 Y102.607 E.00721
G1 X87.208 Y102.791 E.00884
G1 X87.557 Y102.865 E.00594
G1 X87.911 Y102.897 E.00594
G1 X88.264 Y102.884 E.0059
G1 X88.782 Y102.792 E.00878
G1 X89.137 Y102.676 E.00623
G1 X89.451 Y102.526 E.00581
G1 X89.728 Y102.352 E.00547
G1 X90.035 Y102.101 E.00662
G1 X90.263 Y101.864 E.00549
G1 X90.579 Y101.428 E.00898
G1 X90.746 Y101.103 E.0061
G1 X90.867 Y100.764 E.00599
G1 X90.976 Y100.246 E.00884
G1 X91.001 Y99.891 E.00594
G1 X90.95 Y99.38 E.00856
G1 X90.859 Y99.004 E.00647
G1 X90.66 Y98.515 E.00881
G1 X90.373 Y98.072 E.00881
G1 X90.127 Y97.784 E.00631
; LINE_WIDTH: 0.378849
G1 X89.951 Y97.609 E.00438
; LINE_WIDTH: 0.41934
G1 X89.748 Y97.411 E.00557
; LINE_WIDTH: 0.468134
G1 X89.45 Y97.163 E.00857
; WIPE_START
G1 X89.748 Y97.411 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X94.531 Y96.242 Z2.4 F18000
G1 Z2
G1 E.4 F1800
; LINE_WIDTH: 0.104174
G1 F1500
M204 S6000
G1 X94.675 Y96.186 E.00061
; LINE_WIDTH: 0.14824
G1 X94.803 Y96.119 E.00088
G1 X94.901 Y96.04 E.00077
G1 X95.08 Y95.799 E.00183
; LINE_WIDTH: 0.101266
G1 X95.138 Y95.619 E.00071
; WIPE_START
G1 X95.08 Y95.799 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X95.107 Y88.166 Z2.4 F18000
G1 X95.144 Y77.596 Z2.4
G1 Z2
G1 E.4 F1800
; LINE_WIDTH: 0.102425
G1 F1500
M204 S6000
G1 X95.077 Y77.393 E.00082
; LINE_WIDTH: 0.153992
G1 X94.937 Y77.201 E.00152
G1 X94.781 Y77.064 E.00133
; LINE_WIDTH: 0.129729
G1 X94.515 Y76.944 E.00152
; WIPE_START
G1 X94.781 Y77.064 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X87.149 Y77.001 Z2.4 F18000
G1 X81.502 Y76.955 Z2.4
G1 Z2
G1 E.4 F1800
; LINE_WIDTH: 0.0895367
G1 F1500
M204 S6000
G1 X81.395 Y76.991 E.00036
; LINE_WIDTH: 0.128724
G1 X81.194 Y77.082 E.00113
; LINE_WIDTH: 0.15271
G1 X80.962 Y77.32 E.00211
G1 X80.912 Y77.424 E.00073
; LINE_WIDTH: 0.115093
G1 X80.883 Y77.514 E.00042
; LINE_WIDTH: 0.0897609
G1 X80.854 Y77.604 E.0003
; WIPE_START
G1 X80.883 Y77.514 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X88.28 Y79.394 Z2.4 F18000
G1 X96.743 Y81.544 Z2.4
G1 Z2
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X97.257 Y81.544 E.01086
G1 X97.257 Y82.057 E.01086
G1 X96.743 Y82.057 E.01086
G1 X96.743 Y81.604 E.00959
M204 S10000
G1 X96.319 Y81.12 F18000
G1 F1500
M204 S500
G1 X97.681 Y81.12 E.02882
G1 X97.681 Y82.482 E.02882
G1 X96.319 Y82.482 E.02882
G1 X96.319 Y81.18 E.02755
M204 S250
G1 X95.91 Y80.711 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X98.09 Y80.711 E.04288
G1 X98.09 Y82.891 E.04288
G1 X95.91 Y82.891 E.04288
G1 X95.91 Y80.771 E.0417
; CHANGE_LAYER
; Z_HEIGHT: 2.12
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F1500
M204 S6000
G1 X97.909 Y80.716 E-.38
; WIPE_END
G1 E-.02 F1800
; layer num/total_layer_count: 17/49
; update layer progress
M73 L17
M991 S0 P16 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z2.4 I-1.073 J-.574 P1  F18000
G1 X89.155 Y97.094 Z2.4
G1 Z2.12
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X88.942 Y97.002 E.00492
G1 X88.409 Y96.881 E.01157
G1 X87.879 Y96.857 E.01123
G1 X87.501 Y96.897 E.00804
G1 X87.131 Y96.981 E.00805
G1 X86.762 Y97.126 E.00839
G1 X86.647 Y96.963 E.00423
G1 X87.011 Y96.544 E.01176
G1 X88.921 Y96.544 E.04043
G1 X89.274 Y96.925 E.011
G1 X89.19 Y97.045 E.00309
; WIPE_START
M204 S6000
G1 X88.942 Y97.002 E-.04787
G1 X88.409 Y96.881 E-.10382
G1 X87.879 Y96.857 E-.10081
G1 X87.501 Y96.897 E-.07217
G1 X87.217 Y96.961 E-.05533
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X90.613 Y99.887 Z2.52 F18000
G1 Z2.12
G1 E.4 F1800
G1 F1500
M204 S500
G1 X90.607 Y100.167 E.00592
G1 X90.507 Y100.67 E.01086
G1 X90.331 Y101.1 E.00983
G1 X90.165 Y101.377 E.00683
G1 X89.971 Y101.628 E.00672
G1 X89.717 Y101.879 E.00754
G1 X89.499 Y102.05 E.00587
G1 X89.102 Y102.28 E.00971
G1 X88.66 Y102.438 E.00995
G1 X88.196 Y102.515 E.00995
G1 X87.726 Y102.508 E.00995
G1 X87.261 Y102.417 E.01003
G1 X86.795 Y102.227 E.01066
G1 X86.555 Y102.087 E.00588
G1 X86.306 Y101.9 E.0066
G1 X86.079 Y101.683 E.00663
G1 X85.874 Y101.434 E.00683
G1 X85.643 Y101.046 E.00955
G1 X85.52 Y100.748 E.00683
G1 X85.434 Y100.437 E.00683
G1 X85.379 Y99.979 E.00975
G1 X85.407 Y99.519 E.00975
G1 X85.474 Y99.206 E.00679
G1 X85.562 Y98.942 E.00588
G1 X85.788 Y98.493 E.01066
G1 X86.078 Y98.118 E.01003
G1 X86.427 Y97.803 E.00995
G1 X86.827 Y97.556 E.00995
G1 X87.256 Y97.388 E.00975
G1 X87.571 Y97.316 E.00683
G1 X87.892 Y97.282 E.00683
G1 X88.352 Y97.303 E.00975
G1 X88.81 Y97.407 E.00995
G1 X89.234 Y97.588 E.00975
G1 X89.507 Y97.757 E.00679
G1 X89.725 Y97.929 E.00589
G1 X90.072 Y98.294 E.01066
G1 X90.327 Y98.693 E.01003
G1 X90.501 Y99.118 E.00971
G1 X90.568 Y99.387 E.00588
G1 X90.617 Y99.747 E.00769
G1 X90.615 Y99.827 E.0017
M204 S250
G1 X90.204 Y99.878 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X90.199 Y100.122 E.0048
G1 X90.113 Y100.551 E.00862
G1 X89.963 Y100.916 E.00776
G1 X89.826 Y101.146 E.00526
G1 X89.664 Y101.356 E.00523
G1 X89.446 Y101.571 E.00602
G1 X89.269 Y101.711 E.00443
G1 X88.929 Y101.907 E.00772
G1 X88.556 Y102.041 E.0078
G1 X88.165 Y102.106 E.0078
G1 X87.769 Y102.1 E.00779
G1 X87.379 Y102.023 E.00782
G1 X86.976 Y101.859 E.00855
G1 X86.782 Y101.745 E.00443
G1 X86.571 Y101.587 E.00519
G1 X86.38 Y101.404 E.0052
G1 X86.21 Y101.198 E.00526
G1 X86.01 Y100.863 E.00767
G1 X85.908 Y100.615 E.00526
G1 X85.837 Y100.357 E.00526
G1 X85.79 Y99.967 E.00773
G1 X85.814 Y99.574 E.00774
G1 X85.869 Y99.314 E.00525
G1 X85.941 Y99.1 E.00443
G1 X86.136 Y98.712 E.00855
G1 X86.379 Y98.397 E.00782
G1 X86.674 Y98.132 E.0078
G1 X87.011 Y97.924 E.0078
G1 X87.377 Y97.78 E.00773
G1 X87.638 Y97.72 E.00526
G1 X87.904 Y97.692 E.00526
G1 X88.297 Y97.71 E.00773
G1 X88.683 Y97.798 E.00779
G1 X89.045 Y97.953 E.00774
G1 X89.272 Y98.093 E.00525
G1 X89.449 Y98.232 E.00443
G1 X89.748 Y98.547 E.00855
G1 X89.962 Y98.882 E.00782
G1 X90.111 Y99.246 E.00772
G1 X90.166 Y99.464 E.00443
G1 X90.207 Y99.77 E.00606
G1 X90.206 Y99.818 E.00095
; WIPE_START
M204 S6000
G1 X90.199 Y100.122 E-.05773
G1 X90.113 Y100.551 E-.08323
G1 X89.963 Y100.916 E-.07496
G1 X89.826 Y101.146 E-.05082
G1 X89.664 Y101.356 E-.05049
G1 X89.446 Y101.571 E-.05814
G1 X89.427 Y101.586 E-.00463
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X86.761 Y96.12 Z2.52 F18000
G1 Z2.12
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X94.108 Y96.119 E.1555
G1 X94.406 Y96.044 E.0065
G1 X94.667 Y95.881 E.00652
G1 X94.865 Y95.653 E.00639
G1 X94.985 Y95.387 E.00617
G1 X95.019 Y95.145 E.00519
G1 X95.019 Y94.72 E.00899
G1 X95.381 Y94.72 E.00765
G1 X95.381 Y95.565 E.01788
G1 X95.353 Y95.803 E.00508
G1 X95.28 Y96.003 E.0045
G1 X95.209 Y96.118 E.00286
G1 X95.057 Y96.279 E.00469
G1 X94.947 Y96.356 E.00286
G1 X94.751 Y96.441 E.0045
G1 X94.533 Y96.479 E.0047
G1 X89.443 Y96.483 E.10774
G1 X90.544 Y97.675 E.03436
G1 X90.795 Y98 E.00869
G1 X91.084 Y98.517 E.01254
G1 X91.229 Y98.901 E.00868
G1 X91.326 Y99.3 E.00869
G1 X91.38 Y99.89 E.01254
G1 X91.329 Y100.489 E.01273
G1 X91.171 Y101.072 E.01277
G1 X90.916 Y101.61 E.01259
G1 X90.69 Y101.947 E.00859
G1 X90.423 Y102.258 E.00869
G1 X89.974 Y102.644 E.01254
G1 X89.635 Y102.859 E.0085
G1 X89.273 Y103.032 E.00849
G1 X88.884 Y103.164 E.00869
G1 X88.301 Y103.267 E.01254
G1 X87.9 Y103.279 E.00849
G1 X87.5 Y103.243 E.00849
G1 X87.098 Y103.159 E.00869
G1 X86.544 Y102.951 E.01253
G1 X86.193 Y102.757 E.0085
G1 X85.867 Y102.522 E.00849
G1 X85.571 Y102.251 E.00849
G1 X85.31 Y101.947 E.00849
G1 X85.086 Y101.613 E.00849
G1 X84.902 Y101.252 E.00859
G1 X84.808 Y101.008 E.00554
G1 X84.71 Y100.679 E.00726
G1 X84.632 Y100.166 E.01098
G1 X84.627 Y99.685 E.01017
G1 X84.676 Y99.291 E.00841
G1 X84.772 Y98.901 E.00849
G1 X84.913 Y98.526 E.00849
G1 X85.097 Y98.17 E.0085
G1 X85.323 Y97.838 E.00849
G1 X86.503 Y96.482 E.03805
G1 X81.536 Y96.482 E.10513
G1 X81.208 Y96.43 E.00703
G1 X80.978 Y96.309 E.0055
G1 X80.791 Y96.121 E.00561
G1 X80.696 Y95.957 E.00399
G1 X80.648 Y95.812 E.00324
G1 X80.619 Y95.565 E.00527
G1 X80.619 Y77.628 E.37964
G1 X80.655 Y77.357 E.00578
G1 X80.716 Y77.204 E.00348
G1 X80.787 Y77.088 E.00288
G1 X80.982 Y76.89 E.00589
G1 X81.2 Y76.775 E.0052
G1 X81.449 Y76.723 E.0054
G1 X94.501 Y76.721 E.27625
G1 X94.659 Y76.736 E.00337
G1 X94.903 Y76.819 E.00545
G1 X95.058 Y76.922 E.00394
G1 X95.166 Y77.03 E.00323
G1 X95.286 Y77.212 E.00462
G1 X95.344 Y77.363 E.00343
G1 X95.378 Y77.566 E.00434
G1 X95.38 Y78.482 E.01939
G1 X95.019 Y78.482 E.00763
G1 X95.019 Y78.057 E.00899
G1 X94.985 Y77.814 E.0052
G1 X94.861 Y77.541 E.00633
G1 X94.638 Y77.296 E.00701
G1 X94.359 Y77.139 E.00679
G1 X94.088 Y77.082 E.00586
G1 X81.946 Y77.082 E.25699
G1 X81.657 Y77.133 E.00621
G1 X81.384 Y77.28 E.00656
G1 X81.162 Y77.507 E.00671
G1 X81.018 Y77.801 E.00693
G1 X80.981 Y78.056 E.00546
G1 X80.981 Y95.164 E.36211
G1 X81.05 Y95.5 E.00727
G1 X81.257 Y95.815 E.00796
G1 X81.591 Y96.049 E.00864
G1 X81.937 Y96.12 E.00747
G1 X86.701 Y96.12 E.10083
; WIPE_START
M204 S6000
G1 X88.701 Y96.119 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X85.604 Y96.891 Z2.52 F18000
G1 Z2.12
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X81.512 Y96.891 E.08049
G1 X81.197 Y96.854 E.00625
G1 X81.062 Y96.814 E.00277
G1 X80.853 Y96.716 E.00454
G1 X80.598 Y96.521 E.00631
G1 X80.383 Y96.246 E.00687
G1 X80.317 Y96.114 E.00289
G1 X80.247 Y95.901 E.00442
G1 X80.21 Y95.589 E.00619
G1 X80.21 Y77.61 E.35362
G1 X80.231 Y77.374 E.00466
G1 X80.264 Y77.234 E.00283
G1 X80.348 Y77.022 E.00449
G1 X80.452 Y76.851 E.00392
G1 X80.561 Y76.717 E.0034
G1 X80.732 Y76.565 E.00452
G1 X80.853 Y76.486 E.00283
G1 X81.059 Y76.389 E.00448
G1 X81.279 Y76.33 E.00448
G1 X81.425 Y76.313 E.00289
G1 X94.52 Y76.312 E.25757
G1 X94.726 Y76.331 E.00407
G1 X94.867 Y76.365 E.00285
G1 X95.081 Y76.45 E.00454
G1 X95.327 Y76.611 E.00577
G1 X95.485 Y76.77 E.00441
G1 X95.653 Y77.024 E.00598
G1 X95.741 Y77.255 E.00487
G1 X95.788 Y77.531 E.00551
G1 X95.79 Y78.891 E.02674
G1 X94.61 Y78.891 E.0232
G1 X94.61 Y78.086 E.01583
G1 X94.588 Y77.93 E.00311
G1 X94.515 Y77.769 E.00347
G1 X94.38 Y77.62 E.00395
G1 X94.213 Y77.527 E.00376
G1 X94.045 Y77.492 E.00337
G1 X81.982 Y77.491 E.23728
G1 X81.793 Y77.524 E.00376
M73 P61 R9
G1 X81.633 Y77.61 E.00358
G1 X81.501 Y77.746 E.00372
G1 X81.414 Y77.923 E.00389
G1 X81.39 Y78.086 E.00323
G1 X81.39 Y95.122 E.3351
G1 X81.435 Y95.341 E.00439
G1 X81.556 Y95.524 E.00432
G1 X81.757 Y95.665 E.00483
G1 X81.979 Y95.711 E.00446
G1 X94.057 Y95.709 E.23758
G1 X94.244 Y95.663 E.00378
G1 X94.398 Y95.566 E.00358
G1 X94.516 Y95.43 E.00356
G1 X94.588 Y95.272 E.00341
G1 X94.61 Y95.116 E.0031
G1 X94.61 Y94.311 E.01583
G1 X95.79 Y94.311 E.02321
G1 X95.79 Y95.589 E.02513
G1 X95.754 Y95.898 E.00613
G1 X95.65 Y96.182 E.00594
G1 X95.536 Y96.368 E.0043
G1 X95.326 Y96.59 E.00601
G1 X95.147 Y96.716 E.0043
G1 X94.87 Y96.835 E.00595
G1 X94.569 Y96.888 E.00601
G1 X90.377 Y96.891 E.08245
G1 X90.857 Y97.411 E.01392
G1 X91.134 Y97.77 E.00891
G1 X91.366 Y98.159 E.00891
G1 X91.461 Y98.356 E.00431
G1 X91.62 Y98.78 E.00891
G1 X91.728 Y99.22 E.00891
G1 X91.761 Y99.437 E.00431
G1 X91.79 Y99.889 E.00891
G1 X91.764 Y100.341 E.00891
G1 X91.687 Y100.778 E.00873
G1 X91.556 Y101.212 E.00892
G1 X91.408 Y101.555 E.00734
G1 X91.268 Y101.82 E.00589
G1 X91.017 Y102.195 E.00888
G1 X90.721 Y102.538 E.00891
G1 X90.565 Y102.691 E.00431
G1 X90.213 Y102.977 E.00891
G1 X89.833 Y103.218 E.00885
G1 X89.427 Y103.412 E.00885
G1 X88.998 Y103.557 E.00891
G1 X88.785 Y103.608 E.0043
G1 X88.337 Y103.676 E.00891
G1 X87.887 Y103.689 E.00885
G1 X87.439 Y103.649 E.00885
G1 X86.996 Y103.555 E.00891
G1 X86.787 Y103.491 E.0043
G1 X86.367 Y103.321 E.00891
G1 X85.973 Y103.103 E.00885
G1 X85.608 Y102.84 E.00885
G1 X85.277 Y102.536 E.00885
G1 X84.983 Y102.195 E.00885
G1 X84.733 Y101.821 E.00885
G1 X84.528 Y101.419 E.00888
G1 X84.42 Y101.139 E.00589
G1 X84.313 Y100.779 E.0074
G1 X84.223 Y100.193 E.01166
G1 X84.218 Y99.662 E.01043
G1 X84.273 Y99.217 E.00883
G1 X84.38 Y98.78 E.00885
G1 X84.538 Y98.359 E.00885
G1 X84.745 Y97.96 E.00885
G1 X84.998 Y97.588 E.00885
G1 X85.565 Y96.936 E.01698
; WIPE_START
M204 S6000
G1 X83.565 Y96.914 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G17
G3 Z2.52 I1.217 J0 P1  F18000
;===================== date: 20250206 =====================

; don't support timelapse gcode in spiral_mode and by object sequence for I3 structure printer
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
G92 E0
G1 Z2.52
G1 X0 Y90 ; move to safe pos
G1 X-13.0 F3000 ; move to safe pos
M400
M1004 S5 P1  ; external shutter
M400 P300
M971 S11 C11 O0
G92 E0
G1 X0 F18000
M623

; SKIPTYPE: head_wrap_detect
M622.1 S1
M1002 judge_flag g39_3rd_layer_detect_flag
M622 J1
    ; enable nozzle clog detect at 3rd layer
    


    M622.1 S1
    M1002 judge_flag g39_detection_flag
    M622 J1
      
        M622.1 S0
        M1002 judge_flag g39_mass_exceed_flag
        M622 J1
        
            G392 S0
            M400
            G90
            M83
            M204 S5000
            G0 Z2.52 F4000
            G39.3 S1
            G0 Z2.52 F4000
            G392 S0
          
        M623
    
    M623
M623
; SKIPPABLE_END




G1 X81.442 Y96.257
G1 Z2.12
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.150695
G1 F1500
M204 S6000
G1 X81.192 Y96.113 E.0018
G1 X81.066 Y96.017 E.00099
G1 X80.951 Y95.85 E.00126
G1 X80.85 Y95.643 E.00143
; WIPE_START
G1 X80.951 Y95.85 E-.0993
G1 X81.066 Y96.017 E-.08755
G1 X81.192 Y96.113 E-.06872
G1 X81.442 Y96.257 E-.12442
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X86.535 Y97.174 Z2.52 F18000
G1 Z2.12
G1 E.4 F1800
; LINE_WIDTH: 0.473052
G1 F1500
M204 S6000
G1 X86.365 Y97.318 E.00499
; LINE_WIDTH: 0.438151
G1 X86.169 Y97.487 E.00533
; LINE_WIDTH: 0.401772
G1 X85.99 Y97.669 E.00478
; LINE_WIDTH: 0.360982
G1 X85.628 Y98.073 E.00907
G1 X85.425 Y98.365 E.00595
G1 X85.209 Y98.808 E.00824
G1 X85.112 Y99.097 E.0051
G1 X85.051 Y99.36 E.00451
G1 X85.011 Y99.707 E.00584
G1 X85.014 Y100.138 E.00721
G1 X85.082 Y100.59 E.00764
G1 X85.165 Y100.88 E.00504
G1 X85.251 Y101.096 E.0039
G1 X85.418 Y101.418 E.00607
G1 X85.559 Y101.641 E.0044
G1 X85.796 Y101.933 E.00629
G1 X86.069 Y102.195 E.00633
G1 X86.396 Y102.435 E.00679
G1 X86.707 Y102.604 E.00592
G1 X87.199 Y102.792 E.0088
G1 X87.672 Y102.881 E.00806
G1 X88.209 Y102.893 E.00899
G1 X88.628 Y102.831 E.00707
G1 X89.13 Y102.676 E.0088
G1 X89.449 Y102.523 E.00591
G1 X89.752 Y102.335 E.00595
G1 X90.034 Y102.103 E.00611
G1 X90.258 Y101.868 E.00543
G1 X90.471 Y101.597 E.00576
G1 X90.674 Y101.258 E.00662
G1 X90.862 Y100.794 E.00837
G1 X90.977 Y100.259 E.00915
G1 X90.996 Y99.893 E.00612
G1 X90.951 Y99.369 E.0088
G1 X90.866 Y99.014 E.00612
G1 X90.666 Y98.534 E.0087
G1 X90.476 Y98.214 E.00621
G1 X90.25 Y97.923 E.00616
G1 X89.977 Y97.633 E.00666
; LINE_WIDTH: 0.402089
G1 X89.752 Y97.426 E.00575
; LINE_WIDTH: 0.428744
G1 X89.735 Y97.411 E.00046
; LINE_WIDTH: 0.44562
G1 X89.563 Y97.269 E.00466
; LINE_WIDTH: 0.474447
G1 X89.391 Y97.127 E.00498
; WIPE_START
G1 X89.563 Y97.269 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X94.531 Y96.242 Z2.52 F18000
G1 Z2.12
G1 E.4 F1800
; LINE_WIDTH: 0.103804
G1 F1500
M204 S6000
G1 X94.674 Y96.187 E.00059
; LINE_WIDTH: 0.147432
G1 X94.877 Y96.064 E.00144
G1 X94.984 Y95.945 E.00097
G1 X95.08 Y95.799 E.00106
; LINE_WIDTH: 0.101266
G1 X95.138 Y95.619 E.00071
; WIPE_START
G1 X95.08 Y95.799 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X95.107 Y88.166 Z2.52 F18000
G1 X95.144 Y77.596 Z2.52
G1 Z2.12
G1 E.4 F1800
; LINE_WIDTH: 0.102722
G1 F1500
M204 S6000
G1 X95.076 Y77.391 E.00083
; LINE_WIDTH: 0.154793
G1 X94.946 Y77.212 E.00143
G1 X94.8 Y77.078 E.00127
; LINE_WIDTH: 0.126655
G1 X94.515 Y76.941 E.00159
; WIPE_START
G1 X94.8 Y77.078 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X87.168 Y77.008 Z2.52 F18000
G1 X81.496 Y76.955 Z2.52
G1 Z2.12
G1 E.4 F1800
; LINE_WIDTH: 0.0812149
G1 F1500
M204 S6000
G1 X81.464 Y76.963 E.00009
; LINE_WIDTH: 0.0956631
G1 X81.378 Y76.995 E.00032
; LINE_WIDTH: 0.128381
G1 X81.215 Y77.069 E.00092
; LINE_WIDTH: 0.152476
G1 X81.066 Y77.198 E.00124
G1 X80.959 Y77.327 E.00106
G1 X80.906 Y77.434 E.00075
; LINE_WIDTH: 0.101829
G1 X80.857 Y77.597 E.00065
; WIPE_START
G1 X80.906 Y77.434 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X88.294 Y79.351 Z2.52 F18000
G1 X96.743 Y81.544 Z2.52
G1 Z2.12
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X97.257 Y81.544 E.01086
G1 X97.257 Y82.057 E.01086
G1 X96.743 Y82.057 E.01086
G1 X96.743 Y81.604 E.00959
M204 S10000
G1 X96.319 Y81.12 F18000
G1 F1500
M204 S500
G1 X97.681 Y81.12 E.02882
G1 X97.681 Y82.482 E.02882
G1 X96.319 Y82.482 E.02882
G1 X96.319 Y81.18 E.02755
M204 S250
G1 X95.91 Y80.711 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X98.09 Y80.711 E.04288
G1 X98.09 Y82.891 E.04288
G1 X95.91 Y82.891 E.04288
G1 X95.91 Y80.771 E.0417
; CHANGE_LAYER
; Z_HEIGHT: 2.24
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F1500
M204 S6000
G1 X97.909 Y80.716 E-.38
; WIPE_END
G1 E-.02 F1800
; layer num/total_layer_count: 18/49
; update layer progress
M73 L18
M991 S0 P17 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z2.52 I-1.073 J-.574 P1  F18000
G1 X89.159 Y97.081 Z2.52
G1 Z2.24
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X88.766 Y96.954 E.00873
G1 X88.393 Y96.88 E.00805
G1 X87.863 Y96.856 E.01123
G1 X87.322 Y96.93 E.01157
G1 X86.766 Y97.11 E.01237
G1 X86.659 Y96.949 E.0041
G1 X87.011 Y96.544 E.01137
G1 X88.921 Y96.544 E.04042
G1 X89.265 Y96.915 E.01072
G1 X89.191 Y97.031 E.00289
; WIPE_START
M204 S6000
G1 X88.766 Y96.954 E-.08203
G1 X88.393 Y96.88 E-.07222
G1 X87.863 Y96.856 E-.10081
G1 X87.322 Y96.93 E-.10385
G1 X87.216 Y96.964 E-.02109
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X90.617 Y99.846 Z2.64 F18000
G1 Z2.24
G1 E.4 F1800
G1 F1500
M204 S500
G1 X90.622 Y99.901 E.00116
G1 X90.579 Y100.373 E.01003
G1 X90.438 Y100.859 E.01071
G1 X90.325 Y101.11 E.00582
G1 X90.16 Y101.385 E.00679
G1 X89.868 Y101.741 E.00975
G1 X89.516 Y102.039 E.00975
G1 X89.243 Y102.207 E.00679
G1 X88.994 Y102.325 E.00582
G1 X88.511 Y102.473 E.01071
G1 X88.048 Y102.521 E.00984
G1 X87.728 Y102.507 E.00678
G1 X87.456 Y102.464 E.00583
G1 X86.973 Y102.314 E.01071
G1 X86.556 Y102.089 E.01003
G1 X86.188 Y101.796 E.00995
G1 X85.879 Y101.442 E.00995
G1 X85.638 Y101.039 E.00994
G1 X85.476 Y100.607 E.00975
G1 X85.409 Y100.291 E.00683
G1 X85.38 Y99.97 E.00683
G1 X85.407 Y99.519 E.00955
G1 X85.474 Y99.206 E.00679
G1 X85.561 Y98.945 E.00582
G1 X85.788 Y98.493 E.01071
G1 X86.078 Y98.118 E.01004
G1 X86.421 Y97.809 E.00975
G1 X86.69 Y97.632 E.00683
G1 X86.978 Y97.487 E.00683
G1 X87.416 Y97.345 E.00975
G1 X87.882 Y97.282 E.00995
G1 X88.343 Y97.302 E.00975
G1 X88.659 Y97.365 E.00683
G1 X88.957 Y97.462 E.00663
G1 X89.242 Y97.593 E.00663
G1 X89.516 Y97.763 E.00683
G1 X89.868 Y98.061 E.00975
G1 X90.169 Y98.427 E.01003
G1 X90.409 Y98.872 E.01071
G1 X90.504 Y99.131 E.00583
G1 X90.58 Y99.442 E.00679
G1 X90.611 Y99.786 E.00732
M204 S250
G1 X90.209 Y99.883 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X90.211 Y99.901 E.00036
G1 X90.175 Y100.297 E.00782
G1 X90.053 Y100.717 E.0086
G1 X89.962 Y100.92 E.00438
G1 X89.825 Y101.149 E.00525
G1 X89.575 Y101.453 E.00774
G1 X89.275 Y101.707 E.00773
G1 X89.048 Y101.847 E.00525
G1 X88.847 Y101.942 E.00438
G1 X88.429 Y102.07 E.0086
G1 X88.036 Y102.111 E.00776
G1 X87.77 Y102.099 E.00524
G1 X87.55 Y102.064 E.00438
G1 X87.132 Y101.935 E.0086
G1 X86.782 Y101.746 E.00782
G1 X86.472 Y101.499 E.00779
G1 X86.211 Y101.2 E.0078
G1 X86.008 Y100.86 E.00779
G1 X85.87 Y100.492 E.00773
G1 X85.814 Y100.23 E.00526
G1 X85.79 Y99.964 E.00526
G1 X85.814 Y99.574 E.00767
G1 X85.869 Y99.313 E.00525
G1 X85.94 Y99.102 E.00438
G1 X86.136 Y98.712 E.0086
G1 X86.379 Y98.397 E.00783
G1 X86.672 Y98.134 E.00773
G1 X86.895 Y97.987 E.00526
G1 X87.134 Y97.867 E.00526
G1 X87.508 Y97.746 E.00773
G1 X87.901 Y97.692 E.0078
G1 X88.294 Y97.71 E.00773
G1 X88.556 Y97.762 E.00526
G1 X88.808 Y97.843 E.0052
G1 X89.047 Y97.954 E.0052
G1 X89.275 Y98.095 E.00526
G1 X89.575 Y98.349 E.00774
G1 X89.828 Y98.657 E.00782
G1 X90.035 Y99.041 E.0086
G1 X90.112 Y99.25 E.00438
G1 X90.176 Y99.509 E.00525
G1 X90.204 Y99.823 E.00619
; WIPE_START
M204 S6000
G1 X90.211 Y99.901 E-.01485
G1 X90.175 Y100.297 E-.07556
G1 X90.053 Y100.717 E-.08306
G1 X89.962 Y100.92 E-.04232
G1 X89.825 Y101.149 E-.0507
G1 X89.575 Y101.453 E-.07473
G1 X89.419 Y101.585 E-.03878
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X86.761 Y96.12 Z2.64 F18000
G1 Z2.24
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X94.108 Y96.119 E.15551
G1 X94.406 Y96.044 E.00649
G1 X94.666 Y95.881 E.00651
G1 X94.865 Y95.653 E.0064
G1 X94.986 Y95.384 E.00624
G1 X95.019 Y95.144 E.00513
G1 X95.019 Y94.72 E.00898
G1 X95.381 Y94.72 E.00765
G1 X95.381 Y95.565 E.01788
G1 X95.353 Y95.806 E.00514
G1 X95.291 Y95.98 E.00391
G1 X95.207 Y96.121 E.00347
G1 X95.057 Y96.279 E.00461
G1 X94.947 Y96.356 E.00286
G1 X94.751 Y96.441 E.0045
G1 X94.533 Y96.479 E.0047
G1 X89.442 Y96.483 E.10774
G1 X90.544 Y97.675 E.03436
G1 X90.795 Y98 E.00869
G1 X91.084 Y98.517 E.01254
G1 X91.229 Y98.901 E.00868
G1 X91.324 Y99.291 E.00849
G1 X91.374 Y99.699 E.00869
G1 X91.357 Y100.293 E.01258
G1 X91.236 Y100.875 E.0126
G1 X91.096 Y101.256 E.00858
G1 X90.91 Y101.622 E.00869
G1 X90.696 Y101.94 E.0081
G1 X90.292 Y102.385 E.01273
G1 X89.974 Y102.644 E.00869
G1 X89.635 Y102.859 E.0085
G1 X89.273 Y103.032 E.00849
G1 X88.884 Y103.164 E.00869
G1 X88.301 Y103.267 E.01254
G1 X87.9 Y103.279 E.00849
G1 X87.5 Y103.243 E.00849
G1 X87.098 Y103.159 E.00869
G1 X86.617 Y102.983 E.01085
G1 X86.189 Y102.754 E.01027
G1 X85.867 Y102.522 E.00841
G1 X85.571 Y102.251 E.00849
G1 X85.31 Y101.947 E.00849
G1 X85.086 Y101.613 E.0085
G1 X84.832 Y101.079 E.01253
G1 X84.713 Y100.686 E.00869
G1 X84.641 Y100.282 E.00869
G1 X84.627 Y99.689 E.01254
G1 X84.676 Y99.291 E.00849
G1 X84.772 Y98.901 E.00849
G1 X84.913 Y98.526 E.00849
G1 X85.097 Y98.17 E.0085
G1 X85.323 Y97.838 E.00849
G1 X86.503 Y96.482 E.03805
G1 X81.536 Y96.482 E.10513
G1 X81.289 Y96.453 E.00527
G1 X81.143 Y96.405 E.00324
G1 X80.982 Y96.312 E.00394
G1 X80.868 Y96.21 E.00324
G1 X80.733 Y96.028 E.0048
G1 X80.648 Y95.815 E.00485
G1 X80.619 Y95.565 E.00532
G1 X80.619 Y77.619 E.37984
G1 X80.659 Y77.346 E.00583
G1 X80.763 Y77.122 E.00524
G1 X80.863 Y76.996 E.0034
G1 X80.963 Y76.906 E.00285
G1 X81.2 Y76.775 E.00573
G1 X81.449 Y76.723 E.00539
G1 X94.502 Y76.721 E.27628
G1 X94.659 Y76.736 E.00334
G1 X94.903 Y76.819 E.00545
G1 X94.983 Y76.866 E.00198
G1 X95.15 Y77.01 E.00466
G1 X95.277 Y77.19 E.00467
G1 X95.356 Y77.407 E.00489
G1 X95.378 Y77.559 E.00325
G1 X95.38 Y78.482 E.01952
G1 X95.019 Y78.482 E.00763
G1 X95.019 Y78.057 E.00899
G1 X94.985 Y77.814 E.00519
G1 X94.862 Y77.542 E.00631
G1 X94.639 Y77.296 E.00703
G1 X94.358 Y77.139 E.00681
G1 X94.088 Y77.082 E.00585
G1 X81.951 Y77.082 E.25688
G1 X81.682 Y77.124 E.00576
G1 X81.384 Y77.278 E.00711
G1 X81.147 Y77.529 E.0073
G1 X81.017 Y77.807 E.0065
M73 P62 R9
G1 X80.981 Y78.056 E.00533
G1 X80.981 Y95.155 E.36192
G1 X81.035 Y95.462 E.00659
G1 X81.249 Y95.809 E.00864
G1 X81.591 Y96.049 E.00883
G1 X81.937 Y96.12 E.00747
G1 X86.701 Y96.12 E.10084
; WIPE_START
M204 S6000
G1 X88.701 Y96.119 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X85.605 Y96.891 Z2.64 F18000
G1 Z2.24
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X81.512 Y96.891 E.08049
G1 X81.2 Y96.854 E.00619
G1 X80.986 Y96.784 E.00442
G1 X80.855 Y96.718 E.00289
G1 X80.733 Y96.637 E.00289
G1 X80.565 Y96.488 E.00442
G1 X80.381 Y96.241 E.00604
G1 X80.306 Y96.087 E.00338
G1 X80.247 Y95.902 E.00382
G1 X80.21 Y95.589 E.00621
G1 X80.21 Y77.607 E.35368
G1 X80.219 Y77.454 E.00301
G1 X80.265 Y77.23 E.0045
G1 X80.337 Y77.046 E.00389
G1 X80.422 Y76.894 E.00343
G1 X80.563 Y76.716 E.00447
G1 X80.709 Y76.583 E.00389
G1 X80.854 Y76.485 E.00343
G1 X81.059 Y76.389 E.00446
G1 X81.279 Y76.33 E.00448
G1 X81.425 Y76.313 E.00289
G1 X94.522 Y76.312 E.2576
G1 X94.726 Y76.331 E.00404
G1 X94.867 Y76.365 E.00285
G1 X95.081 Y76.45 E.00454
G1 X95.209 Y76.523 E.00289
G1 X95.455 Y76.736 E.0064
G1 X95.649 Y77.017 E.00671
G1 X95.755 Y77.307 E.00607
G1 X95.787 Y77.529 E.00442
G1 X95.79 Y78.891 E.02678
G1 X94.61 Y78.891 E.0232
G1 X94.61 Y78.086 E.01583
G1 X94.588 Y77.93 E.0031
G1 X94.515 Y77.77 E.00346
G1 X94.38 Y77.621 E.00395
G1 X94.213 Y77.527 E.00378
G1 X94.045 Y77.492 E.00336
G1 X81.984 Y77.491 E.23724
G1 X81.811 Y77.518 E.00343
G1 X81.633 Y77.61 E.00394
G1 X81.49 Y77.762 E.0041
G1 X81.413 Y77.925 E.00356
G1 X81.39 Y78.086 E.00318
G1 X81.39 Y95.119 E.33503
G1 X81.424 Y95.314 E.00388
G1 X81.553 Y95.523 E.00483
G1 X81.757 Y95.665 E.00489
G1 X81.979 Y95.711 E.00446
G1 X94.058 Y95.709 E.23759
G1 X94.243 Y95.663 E.00376
G1 X94.398 Y95.567 E.00358
G1 X94.516 Y95.43 E.00356
G1 X94.588 Y95.269 E.00346
G1 X94.61 Y95.116 E.00306
G1 X94.61 Y94.311 E.01583
G1 X95.79 Y94.311 E.02321
G1 X95.79 Y95.589 E.02513
G1 X95.754 Y95.899 E.00615
G1 X95.663 Y96.155 E.00535
G1 X95.535 Y96.369 E.0049
G1 X95.326 Y96.59 E.00598
G1 X95.147 Y96.716 E.0043
G1 X94.87 Y96.835 E.00594
G1 X94.569 Y96.888 E.00601
G1 X90.377 Y96.891 E.08245
G1 X90.857 Y97.411 E.01392
G1 X91.134 Y97.77 E.00891
G1 X91.366 Y98.159 E.00891
G1 X91.461 Y98.356 E.00431
G1 X91.62 Y98.78 E.00891
G1 X91.727 Y99.217 E.00885
G1 X91.783 Y99.667 E.00891
G1 X91.79 Y99.886 E.0043
G1 X91.764 Y100.339 E.00892
G1 X91.703 Y100.702 E.00725
G1 X91.628 Y100.997 E.00599
G1 X91.472 Y101.42 E.00888
G1 X91.266 Y101.824 E.00891
G1 X91.148 Y102.012 E.00437
G1 X91.019 Y102.192 E.00437
G1 X90.721 Y102.538 E.00897
G1 X90.565 Y102.691 E.0043
G1 X90.213 Y102.977 E.00891
G1 X89.833 Y103.218 E.00885
G1 X89.427 Y103.412 E.00885
G1 X88.998 Y103.557 E.00891
G1 X88.785 Y103.608 E.0043
G1 X88.337 Y103.676 E.00891
G1 X87.887 Y103.689 E.00885
G1 X87.439 Y103.649 E.00885
G1 X86.996 Y103.555 E.00891
G1 X86.444 Y103.355 E.01155
G1 X85.972 Y103.102 E.01053
G1 X85.608 Y102.84 E.00883
G1 X85.277 Y102.536 E.00885
G1 X84.983 Y102.195 E.00885
G1 X84.733 Y101.821 E.00885
G1 X84.527 Y101.418 E.00891
G1 X84.445 Y101.215 E.0043
G1 X84.314 Y100.781 E.00891
G1 X84.235 Y100.335 E.00891
G1 X84.216 Y100.117 E.00431
G1 X84.218 Y99.664 E.00891
G1 X84.273 Y99.217 E.00885
G1 X84.38 Y98.78 E.00885
G1 X84.538 Y98.359 E.00885
G1 X84.745 Y97.96 E.00885
G1 X84.998 Y97.588 E.00885
G1 X85.565 Y96.936 E.01699
; WIPE_START
M204 S6000
G1 X83.565 Y96.914 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G17
G3 Z2.64 I1.217 J0 P1  F18000
;===================== date: 20250206 =====================

; don't support timelapse gcode in spiral_mode and by object sequence for I3 structure printer
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
G92 E0
G1 Z2.64
G1 X0 Y90 ; move to safe pos
G1 X-13.0 F3000 ; move to safe pos
M400
M1004 S5 P1  ; external shutter
M400 P300
M971 S11 C11 O0
G92 E0
G1 X0 F18000
M623

; SKIPTYPE: head_wrap_detect
M622.1 S1
M1002 judge_flag g39_3rd_layer_detect_flag
M622 J1
    ; enable nozzle clog detect at 3rd layer
    


    M622.1 S1
    M1002 judge_flag g39_detection_flag
    M622 J1
      
        M622.1 S0
        M1002 judge_flag g39_mass_exceed_flag
        M622 J1
        
            G392 S0
            M400
            G90
            M83
            M204 S5000
            G0 Z2.64 F4000
            G39.3 S1
            G0 Z2.64 F4000
            G392 S0
          
        M623
    
    M623
M623
; SKIPPABLE_END




G1 X81.456 Y96.238
G1 Z2.24
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.0965316
G1 F1500
M204 S6000
G1 X81.352 Y96.193 E.0004
; LINE_WIDTH: 0.148684
G1 X81.249 Y96.147 E.0007
G1 X81.074 Y96.023 E.00131
G1 X80.942 Y95.831 E.00143
; LINE_WIDTH: 0.130179
G1 X80.901 Y95.728 E.00058
; LINE_WIDTH: 0.0951511
G1 X80.861 Y95.625 E.00038
; WIPE_START
G1 X80.901 Y95.728 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X86.548 Y97.165 Z2.64 F18000
G1 Z2.24
G1 E.4 F1800
; LINE_WIDTH: 0.477104
G1 F1500
M204 S6000
G1 X86.367 Y97.319 E.00533
; LINE_WIDTH: 0.438395
G1 X86.16 Y97.496 E.00561
; LINE_WIDTH: 0.400612
G1 X85.986 Y97.673 E.00464
; LINE_WIDTH: 0.360595
G1 X85.628 Y98.073 E.00896
G1 X85.425 Y98.365 E.00594
G1 X85.208 Y98.811 E.00828
G1 X85.112 Y99.097 E.00505
G1 X85.051 Y99.36 E.0045
G1 X85.011 Y99.713 E.00594
G1 X85.007 Y100.079 E.0061
G1 X85.084 Y100.597 E.00876
G1 X85.25 Y101.094 E.00875
G1 X85.418 Y101.418 E.0061
G1 X85.613 Y101.716 E.00595
G1 X85.939 Y102.078 E.00814
G1 X86.36 Y102.412 E.00898
G1 X86.813 Y102.655 E.00858
G1 X87.199 Y102.787 E.00682
G1 X87.556 Y102.866 E.00611
G1 X87.911 Y102.897 E.00594
G1 X88.267 Y102.884 E.00595
G1 X88.628 Y102.834 E.0061
G1 X89.132 Y102.679 E.0088
G1 X89.451 Y102.526 E.00591
G1 X89.728 Y102.352 E.00548
G1 X90.124 Y102.014 E.00869
G1 X90.396 Y101.701 E.00692
G1 X90.489 Y101.576 E.00261
G1 X90.747 Y101.101 E.00904
G1 X90.928 Y100.538 E.00987
G1 X90.975 Y100.25 E.00488
G1 X91.001 Y99.882 E.00616
G1 X90.95 Y99.357 E.0088
G1 X90.866 Y99.014 E.00591
G1 X90.735 Y98.673 E.0061
G1 X90.48 Y98.212 E.0088
G1 X90.128 Y97.784 E.00926
; LINE_WIDTH: 0.375784
G1 X89.948 Y97.612 E.00434
; LINE_WIDTH: 0.408444
G1 X89.742 Y97.416 E.00543
; LINE_WIDTH: 0.445754
G1 X89.561 Y97.272 E.00484
; LINE_WIDTH: 0.47963
G1 X89.381 Y97.128 E.00523
; WIPE_START
G1 X89.561 Y97.272 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X94.531 Y96.242 Z2.64 F18000
G1 Z2.24
G1 E.4 F1800
; LINE_WIDTH: 0.104174
G1 F1500
M204 S6000
G1 X94.675 Y96.186 E.00061
; LINE_WIDTH: 0.149975
G1 X94.874 Y96.067 E.00144
G1 X94.981 Y95.949 E.00098
G1 X95.081 Y95.799 E.00112
; LINE_WIDTH: 0.101546
G1 X95.138 Y95.618 E.00072
; WIPE_START
G1 X95.081 Y95.799 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X95.108 Y88.166 Z2.64 F18000
G1 X95.147 Y77.601 Z2.64
G1 Z2.24
G1 E.4 F1800
; LINE_WIDTH: 0.102127
G1 F1500
M204 S6000
G1 X95.076 Y77.393 E.00084
; LINE_WIDTH: 0.137413
G1 X95.026 Y77.311 E.00054
; LINE_WIDTH: 0.157947
G1 X94.939 Y77.203 E.00092
G1 X94.781 Y77.064 E.00139
; LINE_WIDTH: 0.129774
G1 X94.514 Y76.944 E.00152
; WIPE_START
G1 X94.781 Y77.064 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X87.149 Y77.001 Z2.64 F18000
G1 X81.502 Y76.955 Z2.64
G1 Z2.24
G1 E.4 F1800
; LINE_WIDTH: 0.0895446
G1 F1500
M204 S6000
G1 X81.395 Y76.991 E.00036
; LINE_WIDTH: 0.128085
G1 X81.194 Y77.08 E.00112
; LINE_WIDTH: 0.153236
G1 X81.072 Y77.192 E.00105
G1 X80.91 Y77.419 E.00177
; LINE_WIDTH: 0.0998986
G1 X80.855 Y77.602 E.0007
; WIPE_START
G1 X80.91 Y77.419 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X88.296 Y79.344 Z2.64 F18000
G1 X96.743 Y81.544 Z2.64
G1 Z2.24
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X97.257 Y81.544 E.01086
G1 X97.257 Y82.057 E.01086
G1 X96.743 Y82.057 E.01086
G1 X96.743 Y81.604 E.00959
M204 S10000
G1 X96.319 Y81.12 F18000
G1 F1500
M204 S500
G1 X97.681 Y81.12 E.02882
G1 X97.681 Y82.482 E.02882
G1 X96.319 Y82.482 E.02882
G1 X96.319 Y81.18 E.02755
M204 S250
G1 X95.91 Y80.711 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X98.09 Y80.711 E.04288
G1 X98.09 Y82.891 E.04288
G1 X95.91 Y82.891 E.04288
G1 X95.91 Y80.771 E.0417
; CHANGE_LAYER
; Z_HEIGHT: 2.36
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F1500
M204 S6000
G1 X97.909 Y80.716 E-.38
; WIPE_END
G1 E-.02 F1800
; layer num/total_layer_count: 19/49
; update layer progress
M73 L19
M991 S0 P18 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z2.64 I-1.075 J-.571 P1  F18000
G1 X89.213 Y97.099 Z2.64
G1 Z2.36
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X88.766 Y96.954 E.00995
G1 X88.393 Y96.88 E.00804
G1 X87.863 Y96.856 E.01123
G1 X87.322 Y96.93 E.01157
G1 X86.766 Y97.11 E.01238
G1 X86.659 Y96.949 E.0041
G1 X87.011 Y96.544 E.01137
G1 X88.973 Y96.544 E.04153
G1 X89.32 Y96.936 E.01109
G1 X89.246 Y97.049 E.00284
; WIPE_START
M204 S6000
G1 X88.766 Y96.954 E-.09294
G1 X88.393 Y96.88 E-.07221
G1 X87.863 Y96.856 E-.1008
G1 X87.322 Y96.93 E-.10386
G1 X87.271 Y96.946 E-.01019
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X90.617 Y99.846 Z2.76 F18000
G1 Z2.36
G1 E.4 F1800
G1 F1500
M204 S500
G1 X90.622 Y99.901 E.00116
G1 X90.58 Y100.369 E.00995
G1 X90.457 Y100.813 E.00976
G1 X90.326 Y101.108 E.00683
G1 X90.16 Y101.385 E.00683
G1 X89.868 Y101.741 E.00975
G1 X89.516 Y102.039 E.00975
G1 X89.244 Y102.207 E.00679
G1 X88.997 Y102.324 E.00577
G1 X88.511 Y102.473 E.01076
G1 X88.048 Y102.521 E.00984
G1 X87.728 Y102.507 E.00678
G1 X87.459 Y102.464 E.00578
G1 X86.973 Y102.314 E.01076
G1 X86.556 Y102.089 E.01004
G1 X86.188 Y101.796 E.00995
G1 X85.879 Y101.442 E.00995
G1 X85.638 Y101.038 E.00995
G1 X85.476 Y100.607 E.00975
G1 X85.409 Y100.291 E.00683
G1 X85.38 Y99.97 E.00683
G1 X85.407 Y99.519 E.00956
G1 X85.474 Y99.206 E.00678
G1 X85.56 Y98.947 E.00577
G1 X85.788 Y98.493 E.01076
G1 X86.078 Y98.118 E.01004
G1 X86.42 Y97.809 E.00975
G1 X86.69 Y97.632 E.00683
G1 X86.979 Y97.487 E.00683
G1 X87.416 Y97.345 E.00975
M73 P62 R8
G1 X87.882 Y97.282 E.00995
G1 X88.343 Y97.302 E.00975
G1 X88.659 Y97.365 E.00683
G1 X88.966 Y97.465 E.00683
G1 X89.378 Y97.671 E.00975
G1 X89.747 Y97.947 E.00975
G1 X89.973 Y98.177 E.00683
G1 X90.171 Y98.432 E.00683
G1 X90.391 Y98.826 E.00956
G1 X90.504 Y99.129 E.00683
G1 X90.58 Y99.442 E.00683
G1 X90.611 Y99.786 E.00732
M204 S250
G1 X90.209 Y99.883 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X90.211 Y99.901 E.00036
G1 X90.175 Y100.296 E.00779
G1 X90.071 Y100.675 E.00774
G1 X89.962 Y100.919 E.00526
G1 X89.825 Y101.149 E.00526
G1 X89.575 Y101.452 E.00773
G1 X89.275 Y101.707 E.00773
G1 X89.048 Y101.847 E.00525
G1 X88.849 Y101.941 E.00433
G1 X88.429 Y102.07 E.00864
G1 X88.036 Y102.111 E.00776
G1 X87.77 Y102.099 E.00524
G1 X87.552 Y102.065 E.00433
G1 X87.132 Y101.935 E.00864
G1 X86.782 Y101.746 E.00782
G1 X86.472 Y101.499 E.0078
G1 X86.211 Y101.2 E.0078
G1 X86.008 Y100.86 E.0078
G1 X85.87 Y100.492 E.00773
G1 X85.814 Y100.23 E.00526
G1 X85.79 Y99.964 E.00526
G1 X85.814 Y99.574 E.00767
G1 X85.869 Y99.314 E.00525
G1 X85.939 Y99.105 E.00433
G1 X86.136 Y98.712 E.00864
G1 X86.379 Y98.397 E.00783
G1 X86.672 Y98.134 E.00773
G1 X86.895 Y97.987 E.00526
G1 X87.134 Y97.867 E.00526
G1 X87.508 Y97.746 E.00773
G1 X87.901 Y97.692 E.0078
G1 X88.294 Y97.71 E.00773
G1 X88.556 Y97.762 E.00526
G1 X88.811 Y97.844 E.00526
G1 X89.162 Y98.02 E.00774
G1 X89.477 Y98.256 E.00773
G1 X89.665 Y98.447 E.00526
G1 X89.828 Y98.658 E.00526
G1 X90.018 Y98.999 E.00767
G1 X90.112 Y99.249 E.00526
G1 X90.176 Y99.509 E.00526
G1 X90.204 Y99.823 E.0062
; WIPE_START
M204 S6000
G1 X90.211 Y99.901 E-.01484
G1 X90.175 Y100.296 E-.07529
G1 X90.071 Y100.675 E-.07473
G1 X89.962 Y100.919 E-.05081
G1 X89.825 Y101.149 E-.05085
G1 X89.575 Y101.452 E-.07471
G1 X89.419 Y101.584 E-.03877
; WIPE_END
M73 P63 R8
G1 E-.02 F1800
M204 S10000
G1 X86.761 Y96.12 Z2.76 F18000
G1 Z2.36
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X94.109 Y96.119 E.15553
G1 X94.406 Y96.044 E.00648
G1 X94.666 Y95.881 E.00651
G1 X94.865 Y95.653 E.00639
G1 X94.986 Y95.383 E.00627
G1 X95.019 Y95.144 E.00511
G1 X95.019 Y94.72 E.00897
G1 X95.381 Y94.72 E.00765
G1 X95.381 Y95.565 E.01788
G1 X95.353 Y95.803 E.00508
G1 X95.28 Y96.003 E.0045
G1 X95.209 Y96.118 E.00286
G1 X95.057 Y96.279 E.00469
G1 X94.947 Y96.356 E.00286
G1 X94.751 Y96.441 E.0045
G1 X94.533 Y96.479 E.0047
G1 X89.485 Y96.483 E.10684
G1 X90.63 Y97.78 E.03662
G1 X90.793 Y97.997 E.00574
G1 X91 Y98.345 E.00858
G1 X91.167 Y98.72 E.00869
G1 X91.324 Y99.291 E.01254
G1 X91.38 Y99.881 E.01254
G1 X91.357 Y100.293 E.00873
G1 X91.236 Y100.876 E.0126
G1 X91.096 Y101.256 E.00858
G1 X90.91 Y101.621 E.00869
G1 X90.696 Y101.94 E.00811
G1 X90.291 Y102.387 E.01278
G1 X90.041 Y102.593 E.00685
G1 X89.631 Y102.861 E.01036
G1 X89.273 Y103.032 E.0084
G1 X88.884 Y103.164 E.00869
G1 X88.301 Y103.267 E.01254
G1 X87.9 Y103.279 E.00849
G1 X87.5 Y103.243 E.00849
G1 X87.107 Y103.161 E.00849
G1 X86.727 Y103.032 E.00849
G1 X86.198 Y102.761 E.01258
G1 X85.934 Y102.574 E.00686
G1 X85.568 Y102.248 E.01037
G1 X85.31 Y101.947 E.0084
G1 X85.086 Y101.613 E.0085
G1 X84.831 Y101.077 E.01258
G1 X84.735 Y100.767 E.00686
G1 X84.643 Y100.286 E.01037
G1 X84.62 Y99.89 E.0084
G1 X84.645 Y99.49 E.00849
G1 X84.718 Y99.095 E.00849
G1 X84.909 Y98.532 E.01258
G1 X85.056 Y98.243 E.00686
G1 X85.326 Y97.834 E.01037
G1 X86.503 Y96.482 E.03795
G1 X81.536 Y96.482 E.10512
G1 X81.289 Y96.453 E.00527
G1 X81.144 Y96.405 E.00324
G1 X80.982 Y96.312 E.00394
G1 X80.868 Y96.21 E.00324
G1 X80.735 Y96.032 E.00469
G1 X80.649 Y95.821 E.00482
G1 X80.619 Y95.565 E.00546
G1 X80.619 Y77.619 E.37984
G1 X80.659 Y77.349 E.00577
G1 X80.76 Y77.125 E.0052
G1 X80.861 Y76.998 E.00343
G1 X80.982 Y76.89 E.00343
G1 X81.202 Y76.774 E.00526
G1 X81.453 Y76.723 E.00543
G1 X94.504 Y76.721 E.27623
G1 X94.659 Y76.736 E.0033
G1 X94.744 Y76.756 E.00184
G1 X94.976 Y76.861 E.00539
G1 X95.161 Y77.022 E.0052
G1 X95.283 Y77.208 E.00469
G1 X95.356 Y77.407 E.0045
G1 X95.378 Y77.559 E.00325
G1 X95.38 Y78.482 E.01952
G1 X95.019 Y78.482 E.00763
G1 X95.019 Y78.057 E.00899
G1 X94.985 Y77.814 E.0052
G1 X94.861 Y77.542 E.00632
G1 X94.64 Y77.297 E.00699
G1 X94.359 Y77.139 E.00682
G1 X94.088 Y77.082 E.00586
G1 X81.951 Y77.082 E.25688
G1 X81.682 Y77.125 E.00578
G1 X81.388 Y77.276 E.00699
G1 X81.161 Y77.508 E.00687
G1 X81.018 Y77.801 E.0069
G1 X80.981 Y78.056 E.00545
G1 X80.981 Y95.164 E.36211
G1 X81.05 Y95.5 E.00727
G1 X81.257 Y95.815 E.00796
G1 X81.591 Y96.049 E.00864
G1 X81.937 Y96.12 E.00747
G1 X86.701 Y96.12 E.10083
; WIPE_START
M204 S6000
G1 X88.701 Y96.119 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X85.604 Y96.891 Z2.76 F18000
G1 Z2.36
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X81.512 Y96.891 E.08049
G1 X81.2 Y96.854 E.00619
G1 X80.986 Y96.784 E.00442
G1 X80.855 Y96.718 E.00289
G1 X80.733 Y96.637 E.00289
G1 X80.565 Y96.488 E.00442
G1 X80.382 Y96.243 E.00601
G1 X80.287 Y96.039 E.00442
G1 X80.247 Y95.904 E.00276
G1 X80.21 Y95.589 E.00625
G1 X80.21 Y77.607 E.35368
G1 X80.219 Y77.454 E.00301
G1 X80.265 Y77.231 E.00448
G1 X80.349 Y77.019 E.00448
G1 X80.421 Y76.895 E.00283
G1 X80.562 Y76.716 E.00448
G1 X80.732 Y76.565 E.00448
G1 X80.853 Y76.486 E.00283
G1 X81.06 Y76.389 E.0045
G1 X81.249 Y76.337 E.00385
G1 X81.426 Y76.313 E.00353
G1 X94.523 Y76.312 E.2576
G1 X94.726 Y76.331 E.004
G1 X94.867 Y76.365 E.00285
G1 X95.081 Y76.45 E.00454
G1 X95.206 Y76.522 E.00283
G1 X95.387 Y76.665 E.00454
G1 X95.484 Y76.767 E.00277
G1 X95.652 Y77.023 E.00601
G1 X95.755 Y77.307 E.00594
G1 X95.787 Y77.529 E.00442
G1 X95.79 Y78.891 E.02678
G1 X94.61 Y78.891 E.0232
G1 X94.61 Y78.086 E.01583
G1 X94.588 Y77.93 E.00311
G1 X94.515 Y77.769 E.00346
G1 X94.381 Y77.621 E.00393
G1 X94.213 Y77.527 E.00379
G1 X94.045 Y77.492 E.00337
G1 X81.983 Y77.491 E.23725
G1 X81.811 Y77.518 E.00344
G1 X81.635 Y77.609 E.00389
G1 X81.5 Y77.747 E.00379
G1 X81.414 Y77.923 E.00387
G1 X81.39 Y78.086 E.00322
G1 X81.39 Y95.122 E.3351
G1 X81.435 Y95.341 E.00439
G1 X81.556 Y95.524 E.00431
G1 X81.757 Y95.665 E.00483
G1 X81.979 Y95.711 E.00446
G1 X94.058 Y95.709 E.2376
G1 X94.243 Y95.663 E.00375
G1 X94.398 Y95.567 E.00357
G1 X94.516 Y95.43 E.00355
G1 X94.589 Y95.269 E.00349
G1 X94.61 Y95.116 E.00304
G1 X94.61 Y94.311 E.01583
G1 X95.79 Y94.311 E.02321
G1 X95.79 Y95.589 E.02513
G1 X95.754 Y95.898 E.00613
G1 X95.65 Y96.182 E.00594
G1 X95.536 Y96.368 E.0043
G1 X95.326 Y96.59 E.00601
G1 X95.147 Y96.716 E.0043
G1 X94.87 Y96.835 E.00594
G1 X94.569 Y96.888 E.00601
G1 X90.392 Y96.891 E.08216
G1 X90.948 Y97.521 E.01653
G1 X91.133 Y97.769 E.00608
G1 X91.364 Y98.156 E.00888
G1 X91.548 Y98.57 E.00891
G1 X91.619 Y98.777 E.00431
G1 X91.727 Y99.217 E.00891
G1 X91.783 Y99.667 E.00891
G1 X91.79 Y99.886 E.0043
G1 X91.764 Y100.339 E.00893
G1 X91.704 Y100.697 E.00715
G1 X91.628 Y100.997 E.00608
G1 X91.472 Y101.42 E.00888
G1 X91.266 Y101.824 E.00891
G1 X91.148 Y102.012 E.00437
G1 X91.019 Y102.192 E.00437
G1 X90.721 Y102.539 E.00897
G1 X90.284 Y102.923 E.01146
G1 X89.832 Y103.218 E.01062
G1 X89.427 Y103.412 E.00882
G1 X88.998 Y103.557 E.00892
G1 X88.785 Y103.608 E.0043
G1 X88.337 Y103.676 E.00891
G1 X87.887 Y103.689 E.00885
G1 X87.439 Y103.649 E.00885
G1 X86.999 Y103.556 E.00885
G1 X86.573 Y103.412 E.00885
G1 X86.164 Y103.216 E.00891
G1 X85.975 Y103.104 E.00432
G1 X85.679 Y102.894 E.00715
G1 X85.276 Y102.535 E.01062
G1 X84.983 Y102.195 E.00882
G1 X84.733 Y101.821 E.00885
G1 X84.527 Y101.417 E.00891
G1 X84.337 Y100.867 E.01146
G1 X84.236 Y100.336 E.01062
G1 X84.21 Y99.889 E.00882
G1 X84.239 Y99.44 E.00885
G1 X84.32 Y98.997 E.00885
G1 X84.454 Y98.564 E.00891
G1 X84.702 Y98.037 E.01146
G1 X84.999 Y97.586 E.01062
G1 X85.565 Y96.936 E.01695
; WIPE_START
M204 S6000
G1 X83.565 Y96.914 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G17
G3 Z2.76 I1.217 J0 P1  F18000
;===================== date: 20250206 =====================

; don't support timelapse gcode in spiral_mode and by object sequence for I3 structure printer
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
G92 E0
G1 Z2.76
G1 X0 Y90 ; move to safe pos
G1 X-13.0 F3000 ; move to safe pos
M400
M1004 S5 P1  ; external shutter
M400 P300
M971 S11 C11 O0
G92 E0
G1 X0 F18000
M623

; SKIPTYPE: head_wrap_detect
M622.1 S1
M1002 judge_flag g39_3rd_layer_detect_flag
M622 J1
    ; enable nozzle clog detect at 3rd layer
    


    M622.1 S1
    M1002 judge_flag g39_detection_flag
    M622 J1
      
        M622.1 S0
        M1002 judge_flag g39_mass_exceed_flag
        M622 J1
        
            G392 S0
            M400
            G90
            M83
            M204 S5000
            G0 Z2.76 F4000
            G39.3 S1
            G0 Z2.76 F4000
            G392 S0
          
        M623
    
    M623
M623
; SKIPPABLE_END




G1 X81.456 Y96.238
G1 Z2.36
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.0965384
G1 F1500
M204 S6000
G1 X81.353 Y96.193 E.0004
; LINE_WIDTH: 0.150154
G1 X81.249 Y96.147 E.0007
G1 X81.066 Y96.016 E.00139
G1 X80.844 Y95.655 E.00263
; WIPE_START
G1 X81.066 Y96.016 E-.21145
G1 X81.249 Y96.147 E-.11201
G1 X81.353 Y96.193 E-.05654
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X86.547 Y97.165 Z2.76 F18000
G1 Z2.36
G1 E.4 F1800
; LINE_WIDTH: 0.477124
G1 F1500
M204 S6000
G1 X86.367 Y97.319 E.00533
; LINE_WIDTH: 0.438428
G1 X86.16 Y97.496 E.00561
; LINE_WIDTH: 0.400636
G1 X85.986 Y97.673 E.00464
; LINE_WIDTH: 0.360378
G1 X85.792 Y97.872 E.00464
G1 X85.463 Y98.307 E.0091
G1 X85.261 Y98.688 E.0072
G1 X85.088 Y99.188 E.00884
G1 X85.024 Y99.536 E.00591
G1 X85.003 Y99.891 E.00594
G1 X85.022 Y100.239 E.00582
G1 X85.103 Y100.673 E.00736
G1 X85.25 Y101.093 E.00744
G1 X85.418 Y101.418 E.00611
G1 X85.613 Y101.716 E.00594
G1 X85.918 Y102.057 E.00764
G1 X86.362 Y102.409 E.00945
G1 X86.842 Y102.668 E.00911
G1 X87.209 Y102.789 E.00645
G1 X87.556 Y102.866 E.00594
G1 X88.047 Y102.898 E.00821
G1 X88.601 Y102.836 E.0093
G1 X89.123 Y102.682 E.00909
G1 X89.445 Y102.529 E.00594
G1 X89.747 Y102.336 E.006
G1 X90.148 Y101.996 E.00877
G1 X90.393 Y101.705 E.00635
G1 X90.656 Y101.29 E.0082
G1 X90.807 Y100.952 E.00619
G1 X90.95 Y100.421 E.00917
G1 X90.995 Y99.915 E.00848
G1 X90.956 Y99.392 E.00876
G1 X90.869 Y99.026 E.00628
G1 X90.725 Y98.658 E.0066
G1 X90.48 Y98.213 E.00848
G1 X90.264 Y97.936 E.00586
G1 X89.993 Y97.645 E.00664
; LINE_WIDTH: 0.396049
G1 X89.871 Y97.533 E.00307
; LINE_WIDTH: 0.429939
G1 X89.749 Y97.42 E.00335
; LINE_WIDTH: 0.46525
G1 X89.613 Y97.295 E.00405
G1 X89.286 Y97.374 E.00738
; WIPE_START
G1 X89.613 Y97.295 E-.24535
G1 X89.749 Y97.42 E-.13465
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X94.531 Y96.242 Z2.76 F18000
G1 Z2.36
G1 E.4 F1800
; LINE_WIDTH: 0.104175
G1 F1500
M204 S6000
G1 X94.675 Y96.186 E.00061
; LINE_WIDTH: 0.15003
G1 X94.874 Y96.067 E.00144
G1 X94.984 Y95.945 E.00102
G1 X95.08 Y95.799 E.00108
; LINE_WIDTH: 0.101178
G1 X95.138 Y95.618 E.00071
; WIPE_START
G1 X95.08 Y95.799 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X95.108 Y88.167 Z2.76 F18000
G1 X95.147 Y77.601 Z2.76
G1 Z2.36
G1 E.4 F1800
; LINE_WIDTH: 0.102221
G1 F1500
M204 S6000
G1 X95.075 Y77.393 E.00084
; LINE_WIDTH: 0.133036
G1 X95.038 Y77.331 E.00039
; LINE_WIDTH: 0.156252
G1 X94.94 Y77.204 E.00104
G1 X94.781 Y77.064 E.00138
; LINE_WIDTH: 0.129891
G1 X94.514 Y76.944 E.00152
; WIPE_START
G1 X94.781 Y77.064 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X87.149 Y77.002 Z2.76 F18000
G1 X81.501 Y76.955 Z2.76
G1 Z2.36
G1 E.4 F1800
; LINE_WIDTH: 0.0895989
G1 F1500
M204 S6000
G1 X81.397 Y76.991 E.00035
; LINE_WIDTH: 0.129135
G1 X81.19 Y77.084 E.00117
; LINE_WIDTH: 0.15322
G1 X80.963 Y77.32 E.00208
G1 X80.911 Y77.423 E.00074
; LINE_WIDTH: 0.101441
G1 X80.854 Y77.604 E.00071
; WIPE_START
G1 X80.911 Y77.423 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X88.297 Y79.346 Z2.76 F18000
G1 X96.743 Y81.544 Z2.76
G1 Z2.36
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X97.257 Y81.544 E.01086
G1 X97.257 Y82.057 E.01086
G1 X96.743 Y82.057 E.01086
G1 X96.743 Y81.604 E.00959
M204 S10000
G1 X96.319 Y81.12 F18000
G1 F1500
M204 S500
G1 X97.681 Y81.12 E.02882
G1 X97.681 Y82.482 E.02882
G1 X96.319 Y82.482 E.02882
G1 X96.319 Y81.18 E.02755
M204 S250
G1 X95.91 Y80.711 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X98.09 Y80.711 E.04288
G1 X98.09 Y82.891 E.04288
G1 X95.91 Y82.891 E.04288
G1 X95.91 Y80.771 E.0417
; CHANGE_LAYER
; Z_HEIGHT: 2.48
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F1500
M204 S6000
G1 X97.909 Y80.716 E-.38
; WIPE_END
G1 E-.02 F1800
; layer num/total_layer_count: 20/49
; update layer progress
M73 L20
M991 S0 P19 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z2.76 I-1.075 J-.571 P1  F18000
G1 X89.212 Y97.098 Z2.76
G1 Z2.48
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X88.766 Y96.954 E.00992
G1 X88.393 Y96.88 E.00804
G1 X87.863 Y96.856 E.01123
G1 X87.322 Y96.93 E.01157
G1 X86.766 Y97.11 E.01238
G1 X86.659 Y96.949 E.0041
G1 X87.012 Y96.543 E.01138
G1 X88.971 Y96.543 E.04148
G1 X89.319 Y96.936 E.0111
G1 X89.245 Y97.048 E.00284
; WIPE_START
M204 S6000
G1 X88.766 Y96.954 E-.0927
G1 X88.393 Y96.88 E-.07222
G1 X87.863 Y96.856 E-.1008
G1 X87.322 Y96.93 E-.10385
G1 X87.269 Y96.947 E-.01044
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X90.617 Y99.846 Z2.88 F18000
G1 Z2.48
G1 E.4 F1800
G1 F1500
M204 S500
G1 X90.622 Y99.901 E.00116
G1 X90.58 Y100.36 E.00975
G1 X90.504 Y100.673 E.00683
G1 X90.391 Y100.975 E.00683
G1 X90.166 Y101.378 E.00975
G1 X89.868 Y101.741 E.00995
G1 X89.504 Y102.049 E.01008
G1 X89.018 Y102.317 E.01175
G1 X88.511 Y102.473 E.01123
G1 X88.033 Y102.523 E.01017
G1 X87.48 Y102.471 E.01175
G1 X86.974 Y102.314 E.01123
G1 X86.556 Y102.089 E.01004
G1 X86.195 Y101.802 E.00975
M73 P64 R8
G1 X85.976 Y101.565 E.00683
G1 X85.786 Y101.304 E.00684
G1 X85.574 Y100.895 E.00975
G1 X85.436 Y100.446 E.00995
G1 X85.381 Y99.989 E.00975
G1 X85.39 Y99.666 E.00683
G1 X85.438 Y99.347 E.00683
G1 X85.574 Y98.907 E.00975
G1 X85.791 Y98.49 E.00994
G1 X86.081 Y98.114 E.01005
G1 X86.48 Y97.765 E.01123
G1 X86.964 Y97.492 E.01175
G1 X87.416 Y97.345 E.01008
G1 X87.882 Y97.282 E.00995
G1 X88.343 Y97.302 E.00975
G1 X88.659 Y97.365 E.00683
G1 X88.957 Y97.462 E.00663
G1 X89.242 Y97.593 E.00664
G1 X89.516 Y97.763 E.00683
G1 X89.861 Y98.055 E.00956
G1 X90.073 Y98.298 E.00683
G1 X90.255 Y98.565 E.00683
G1 X90.455 Y98.98 E.00975
G1 X90.58 Y99.433 E.00995
G1 X90.611 Y99.787 E.00752
M204 S250
G1 X90.209 Y99.883 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X90.211 Y99.901 E.00035
G1 X90.176 Y100.292 E.00773
G1 X90.112 Y100.552 E.00526
G1 X90.018 Y100.803 E.00526
G1 X89.827 Y101.146 E.00773
G1 X89.575 Y101.452 E.0078
G1 X89.271 Y101.71 E.00784
G1 X88.857 Y101.938 E.00928
G1 X88.429 Y102.07 E.00882
G1 X88.031 Y102.112 E.00787
G1 X87.561 Y102.067 E.00929
G1 X87.132 Y101.935 E.00882
G1 X86.782 Y101.746 E.00783
G1 X86.475 Y101.501 E.00774
G1 X86.293 Y101.305 E.00526
G1 X86.135 Y101.088 E.00526
G1 X85.954 Y100.739 E.00773
G1 X85.837 Y100.361 E.0078
G1 X85.791 Y99.97 E.00773
G1 X85.799 Y99.703 E.00526
G1 X85.838 Y99.438 E.00526
G1 X85.954 Y99.062 E.00774
G1 X86.137 Y98.711 E.00779
G1 X86.38 Y98.396 E.00783
G1 X86.718 Y98.101 E.00882
G1 X87.129 Y97.869 E.00929
G1 X87.508 Y97.746 E.00783
G1 X87.901 Y97.692 E.0078
G1 X88.294 Y97.71 E.00773
G1 X88.556 Y97.762 E.00526
G1 X88.807 Y97.843 E.0052
G1 X89.047 Y97.954 E.0052
G1 X89.275 Y98.095 E.00526
G1 X89.573 Y98.347 E.00768
G1 X89.749 Y98.549 E.00526
G1 X89.899 Y98.77 E.00526
G1 X90.07 Y99.124 E.00773
G1 X90.175 Y99.506 E.0078
G1 X90.204 Y99.823 E.00626
; WIPE_START
M204 S6000
G1 X90.211 Y99.901 E-.01482
G1 X90.176 Y100.292 E-.07469
G1 X90.112 Y100.552 E-.05086
G1 X90.018 Y100.803 E-.05081
G1 X89.827 Y101.146 E-.07472
G1 X89.575 Y101.452 E-.07531
G1 X89.419 Y101.584 E-.0388
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X86.761 Y96.119 Z2.88 F18000
G1 Z2.48
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X94.13 Y96.117 E.15597
G1 X94.414 Y96.04 E.00624
G1 X94.686 Y95.866 E.00683
G1 X94.892 Y95.61 E.00695
G1 X95.008 Y95.309 E.00681
G1 X95.013 Y94.72 E.01247
G1 X95.381 Y94.72 E.00777
G1 X95.381 Y95.565 E.01788
G1 X95.353 Y95.803 E.00508
G1 X95.28 Y96.003 E.0045
G1 X95.209 Y96.118 E.00286
G1 X95.057 Y96.279 E.00469
G1 X94.947 Y96.356 E.00286
G1 X94.751 Y96.441 E.0045
G1 X94.533 Y96.479 E.0047
G1 X89.484 Y96.483 E.10686
G1 X90.627 Y97.777 E.03654
G1 X90.793 Y97.997 E.00583
G1 X91 Y98.345 E.00858
G1 X91.167 Y98.72 E.00869
G1 X91.324 Y99.291 E.01254
G1 X91.38 Y99.881 E.01254
G1 X91.357 Y100.293 E.00874
G1 X91.236 Y100.876 E.0126
G1 X91.096 Y101.256 E.00858
G1 X90.91 Y101.621 E.00869
G1 X90.696 Y101.94 E.00811
G1 X90.433 Y102.246 E.00856
G1 X90.036 Y102.596 E.01119
G1 X89.631 Y102.861 E.01026
G1 X89.273 Y103.032 E.0084
G1 X88.884 Y103.164 E.00869
G1 X88.301 Y103.267 E.01254
G1 X87.9 Y103.279 E.00849
G1 X87.5 Y103.243 E.00849
G1 X87.107 Y103.161 E.00849
G1 X86.732 Y103.033 E.0084
G1 X86.298 Y102.818 E.01026
G1 X85.862 Y102.518 E.01119
G1 X85.571 Y102.251 E.00836
G1 X85.31 Y101.947 E.00849
G1 X85.086 Y101.613 E.0085
G1 X84.832 Y101.079 E.01253
G1 X84.715 Y100.692 E.00856
G1 X84.633 Y100.169 E.01119
G1 X84.628 Y99.685 E.01026
G1 X84.676 Y99.291 E.0084
G1 X84.771 Y98.901 E.00849
G1 X84.913 Y98.526 E.00849
G1 X85.097 Y98.17 E.00849
G1 X85.323 Y97.838 E.0085
G1 X86.503 Y96.482 E.03805
G1 X81.536 Y96.482 E.10513
G1 X81.289 Y96.453 E.00527
G1 X81.144 Y96.405 E.00324
G1 X80.978 Y96.309 E.00404
G1 X80.791 Y96.121 E.00562
G1 X80.686 Y95.932 E.00458
G1 X80.648 Y95.815 E.00259
G1 X80.619 Y95.565 E.00533
G1 X80.619 Y77.628 E.37965
G1 X80.655 Y77.357 E.00578
G1 X80.761 Y77.125 E.00539
G1 X80.863 Y76.996 E.00349
G1 X80.96 Y76.907 E.00279
G1 X81.2 Y76.775 E.00578
G1 X81.449 Y76.723 E.00539
G1 X94.505 Y76.721 E.27635
G1 X94.659 Y76.736 E.00326
G1 X94.744 Y76.756 E.00185
G1 X94.968 Y76.857 E.0052
G1 X95.148 Y77.008 E.00498
G1 X95.282 Y77.2 E.00496
G1 X95.345 Y77.367 E.00378
G1 X95.378 Y77.565 E.00424
G1 X95.38 Y78.482 E.0194
G1 X95.019 Y78.482 E.00763
G1 X95.019 Y78.057 E.00899
G1 X94.984 Y77.814 E.0052
G1 X94.861 Y77.542 E.00631
G1 X94.641 Y77.298 E.00697
G1 X94.359 Y77.139 E.00685
G1 X94.088 Y77.082 E.00586
G1 X81.946 Y77.082 E.25699
G1 X81.657 Y77.132 E.0062
G1 X81.388 Y77.278 E.00649
G1 X81.171 Y77.495 E.00649
G1 X81.019 Y77.798 E.00717
G1 X80.981 Y78.056 E.00552
G1 X80.981 Y95.161 E.36204
G1 X81.044 Y95.485 E.00699
G1 X81.254 Y95.812 E.00823
G1 X81.591 Y96.049 E.00873
G1 X81.937 Y96.12 E.00747
G1 X86.701 Y96.119 E.10083
; WIPE_START
M204 S6000
G1 X88.701 Y96.119 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X85.604 Y96.891 Z2.88 F18000
G1 Z2.48
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X81.512 Y96.891 E.08049
G1 X81.2 Y96.854 E.00619
G1 X80.986 Y96.784 E.00442
G1 X80.855 Y96.718 E.00289
G1 X80.594 Y96.518 E.00647
G1 X80.384 Y96.247 E.00674
G1 X80.305 Y96.084 E.00356
G1 X80.247 Y95.902 E.00376
G1 X80.21 Y95.589 E.00621
G1 X80.21 Y77.61 E.35362
G1 X80.231 Y77.374 E.00466
G1 X80.264 Y77.234 E.00283
G1 X80.349 Y77.019 E.00454
G1 X80.421 Y76.895 E.00283
G1 X80.563 Y76.715 E.0045
G1 X80.707 Y76.585 E.00382
G1 X80.854 Y76.485 E.0035
G1 X81.059 Y76.389 E.00445
G1 X81.279 Y76.33 E.00448
G1 X81.425 Y76.313 E.00289
G1 X94.525 Y76.312 E.25767
G1 X94.726 Y76.331 E.00397
G1 X94.867 Y76.365 E.00285
G1 X95.081 Y76.45 E.00454
G1 X95.203 Y76.52 E.00277
G1 X95.441 Y76.72 E.0061
G1 X95.551 Y76.855 E.00344
G1 X95.651 Y77.02 E.00379
G1 X95.742 Y77.26 E.00505
G1 X95.788 Y77.531 E.00541
G1 X95.79 Y78.891 E.02674
G1 X94.61 Y78.891 E.0232
G1 X94.61 Y78.086 E.01583
G1 X94.588 Y77.929 E.00311
G1 X94.515 Y77.769 E.00346
G1 X94.382 Y77.622 E.00391
G1 X94.213 Y77.527 E.00381
G1 X94.045 Y77.492 E.00337
G1 X81.982 Y77.491 E.23728
G1 X81.793 Y77.524 E.00376
G1 X81.635 Y77.61 E.00355
G1 X81.507 Y77.737 E.00356
G1 X81.414 Y77.922 E.00407
G1 X81.39 Y78.086 E.00325
G1 X81.39 Y95.121 E.33507
G1 X81.431 Y95.33 E.00419
G1 X81.555 Y95.524 E.00452
G1 X81.757 Y95.665 E.00485
G1 X81.979 Y95.711 E.00445
G1 X94.075 Y95.708 E.23793
G1 X94.246 Y95.662 E.00349
G1 X94.409 Y95.557 E.0038
G1 X94.533 Y95.403 E.0039
G1 X94.599 Y95.231 E.00362
G1 X94.608 Y94.311 E.0181
G1 X95.79 Y94.311 E.02325
G1 X95.79 Y95.589 E.02513
G1 X95.754 Y95.898 E.00613
G1 X95.65 Y96.182 E.00594
G1 X95.536 Y96.368 E.0043
G1 X95.326 Y96.59 E.006
G1 X95.147 Y96.716 E.0043
G1 X94.87 Y96.835 E.00594
G1 X94.569 Y96.888 E.00601
G1 X90.391 Y96.891 E.08217
G1 X90.945 Y97.518 E.01645
G1 X91.133 Y97.769 E.00617
G1 X91.364 Y98.156 E.00888
G1 X91.549 Y98.57 E.00891
G1 X91.619 Y98.777 E.0043
G1 X91.727 Y99.217 E.00891
G1 X91.783 Y99.667 E.00891
G1 X91.79 Y99.886 E.0043
G1 X91.764 Y100.339 E.00893
G1 X91.704 Y100.693 E.00706
G1 X91.628 Y100.997 E.00617
G1 X91.472 Y101.42 E.00888
G1 X91.266 Y101.824 E.00891
G1 X91.148 Y102.012 E.00437
G1 X91.019 Y102.192 E.00436
G1 X90.725 Y102.534 E.00887
G1 X90.285 Y102.922 E.01154
G1 X89.832 Y103.218 E.01065
G1 X89.427 Y103.412 E.00882
G1 X88.998 Y103.557 E.00891
G1 X88.785 Y103.609 E.00431
G1 X88.337 Y103.676 E.00891
G1 X87.887 Y103.689 E.00885
G1 X87.439 Y103.649 E.00885
G1 X86.999 Y103.556 E.00885
G1 X86.574 Y103.412 E.00882
G1 X86.089 Y103.172 E.01065
G1 X85.606 Y102.839 E.01154
G1 X85.277 Y102.536 E.00881
G1 X84.983 Y102.195 E.00885
G1 X84.733 Y101.821 E.00885
G1 X84.527 Y101.417 E.00891
G1 X84.445 Y101.215 E.0043
G1 X84.315 Y100.783 E.00887
G1 X84.224 Y100.203 E.01154
G1 X84.218 Y99.662 E.01065
G1 X84.273 Y99.217 E.00882
G1 X84.38 Y98.78 E.00885
G1 X84.538 Y98.359 E.00885
G1 X84.745 Y97.96 E.00885
G1 X84.998 Y97.588 E.00885
G1 X85.565 Y96.936 E.01698
; WIPE_START
M204 S6000
G1 X83.565 Y96.914 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G17
G3 Z2.88 I1.217 J0 P1  F18000
;===================== date: 20250206 =====================

; don't support timelapse gcode in spiral_mode and by object sequence for I3 structure printer
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
G92 E0
G1 Z2.88
G1 X0 Y90 ; move to safe pos
G1 X-13.0 F3000 ; move to safe pos
M400
M1004 S5 P1  ; external shutter
M400 P300
M971 S11 C11 O0
G92 E0
G1 X0 F18000
M623

; SKIPTYPE: head_wrap_detect
M622.1 S1
M1002 judge_flag g39_3rd_layer_detect_flag
M622 J1
    ; enable nozzle clog detect at 3rd layer
    


    M622.1 S1
    M1002 judge_flag g39_detection_flag
    M622 J1
      
        M622.1 S0
        M1002 judge_flag g39_mass_exceed_flag
        M622 J1
        
            G392 S0
            M400
            G90
            M83
            M204 S5000
            G0 Z2.88 F4000
            G39.3 S1
            G0 Z2.88 F4000
            G392 S0
          
        M623
    
    M623
M623
; SKIPPABLE_END




G1 X81.456 Y96.238
G1 Z2.48
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.0962734
G1 F1500
M204 S6000
G1 X81.354 Y96.193 E.00039
; LINE_WIDTH: 0.150039
G1 X81.251 Y96.148 E.0007
G1 X81.077 Y96.027 E.00131
G1 X80.941 Y95.831 E.00148
; LINE_WIDTH: 0.130304
G1 X80.902 Y95.732 E.00056
; LINE_WIDTH: 0.0951866
G1 X80.862 Y95.633 E.00037
; WIPE_START
G1 X80.902 Y95.732 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X86.549 Y97.168 Z2.88 F18000
G1 Z2.48
G1 E.4 F1800
; LINE_WIDTH: 0.468224
G1 F1500
M204 S6000
G1 X86.254 Y97.409 E.00841
; LINE_WIDTH: 0.43835
G1 X86.223 Y97.437 E.00088
; LINE_WIDTH: 0.413764
G1 X86.02 Y97.641 E.00556
; LINE_WIDTH: 0.360587
G1 X85.817 Y97.844 E.0048
G1 X85.628 Y98.073 E.00496
G1 X85.425 Y98.365 E.00594
G1 X85.231 Y98.75 E.0072
G1 X85.068 Y99.275 E.00918
G1 X85.008 Y99.706 E.00727
G1 X85.014 Y100.138 E.00722
G1 X85.086 Y100.605 E.0079
G1 X85.221 Y101.024 E.00736
G1 X85.459 Y101.492 E.00877
G1 X85.678 Y101.797 E.00628
G1 X85.948 Y102.086 E.0066
G1 X86.338 Y102.393 E.00828
G1 X86.843 Y102.668 E.0096
G1 X87.209 Y102.789 E.00645
G1 X87.557 Y102.863 E.00594
G1 X87.911 Y102.896 E.00594
G1 X88.264 Y102.884 E.0059
G1 X88.782 Y102.792 E.00878
G1 X89.181 Y102.658 E.00704
G1 X89.703 Y102.366 E.00999
G1 X90.147 Y101.995 E.00966
G1 X90.393 Y101.705 E.00635
G1 X90.577 Y101.429 E.00553
G1 X90.748 Y101.103 E.00615
G1 X90.872 Y100.767 E.00599
G1 X90.975 Y100.249 E.00882
G1 X90.996 Y99.886 E.00607
G1 X90.951 Y99.359 E.00883
G1 X90.81 Y98.862 E.00864
G1 X90.658 Y98.52 E.00625
G1 X90.378 Y98.074 E.00879
G1 X90.119 Y97.775 E.00661
; LINE_WIDTH: 0.379465
G1 X89.946 Y97.606 E.00428
; LINE_WIDTH: 0.417081
G1 X89.747 Y97.413 E.00541
; LINE_WIDTH: 0.453358
G1 X89.589 Y97.282 E.00437
; LINE_WIDTH: 0.48049
G1 X89.431 Y97.152 E.00465
; WIPE_START
G1 X89.589 Y97.282 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X94.54 Y96.258 Z2.88 F18000
G1 Z2.48
G1 E.4 F1800
; LINE_WIDTH: 0.149516
G1 F1500
M204 S6000
G1 X94.876 Y96.069 E.00238
G1 X94.984 Y95.945 E.00102
G1 X95.068 Y95.813 E.00096
; LINE_WIDTH: 0.117895
G1 X95.106 Y95.745 E.00036
; LINE_WIDTH: 0.0906526
G1 X95.135 Y95.633 E.00037
; WIPE_START
G1 X95.106 Y95.745 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
M73 P65 R8
G1 X95.122 Y88.112 Z2.88 F18000
G1 X95.145 Y77.596 Z2.88
G1 Z2.48
G1 E.4 F1800
; LINE_WIDTH: 0.102626
G1 F1500
M204 S6000
G1 X95.076 Y77.392 E.00083
; LINE_WIDTH: 0.152983
G1 X94.943 Y77.208 E.00145
G1 X94.781 Y77.064 E.00138
; LINE_WIDTH: 0.129938
G1 X94.514 Y76.944 E.00152
; WIPE_START
G1 X94.781 Y77.064 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X87.148 Y77.001 Z2.88 F18000
G1 X81.496 Y76.955 Z2.88
G1 Z2.48
G1 E.4 F1800
; LINE_WIDTH: 0.0897827
G1 F1500
M204 S6000
G1 X81.393 Y76.991 E.00035
; LINE_WIDTH: 0.129857
G1 X81.195 Y77.081 E.00113
; LINE_WIDTH: 0.152061
G1 X80.962 Y77.32 E.0021
G1 X80.907 Y77.434 E.0008
; LINE_WIDTH: 0.102622
G1 X80.857 Y77.598 E.00066
; WIPE_START
G1 X80.907 Y77.434 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X88.295 Y79.352 Z2.88 F18000
G1 X96.743 Y81.544 Z2.88
G1 Z2.48
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X97.257 Y81.544 E.01086
G1 X97.257 Y82.057 E.01086
G1 X96.743 Y82.057 E.01086
G1 X96.743 Y81.604 E.00959
M204 S10000
G1 X96.319 Y81.12 F18000
G1 F1500
M204 S500
G1 X97.681 Y81.12 E.02882
G1 X97.681 Y82.482 E.02882
G1 X96.319 Y82.482 E.02882
G1 X96.319 Y81.18 E.02755
M204 S250
G1 X95.91 Y80.711 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X98.09 Y80.711 E.04288
G1 X98.09 Y82.891 E.04288
G1 X95.91 Y82.891 E.04288
G1 X95.91 Y80.771 E.0417
; CHANGE_LAYER
; Z_HEIGHT: 2.6
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F1500
M204 S6000
G1 X97.909 Y80.716 E-.38
; WIPE_END
G1 E-.02 F1800
; layer num/total_layer_count: 21/49
; update layer progress
M73 L21
M991 S0 P20 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z2.88 I-1.073 J-.574 P1  F18000
G1 X89.159 Y97.081 Z2.88
G1 Z2.6
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X88.766 Y96.954 E.00874
G1 X88.393 Y96.88 E.00804
G1 X87.863 Y96.856 E.01123
G1 X87.322 Y96.93 E.01157
G1 X86.766 Y97.11 E.01237
G1 X86.659 Y96.949 E.0041
G1 X87.011 Y96.544 E.01137
G1 X88.921 Y96.543 E.04042
G1 X89.265 Y96.915 E.01072
G1 X89.191 Y97.031 E.00289
; WIPE_START
M204 S6000
G1 X88.766 Y96.954 E-.08204
G1 X88.393 Y96.88 E-.07222
G1 X87.863 Y96.856 E-.1008
G1 X87.322 Y96.93 E-.10386
G1 X87.216 Y96.964 E-.02109
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X90.616 Y99.84 Z3 F18000
G1 Z2.6
G1 E.4 F1800
G1 F1500
M204 S500
G1 X90.622 Y99.896 E.0012
G1 X90.58 Y100.369 E.01005
G1 X90.457 Y100.813 E.00975
G1 X90.326 Y101.108 E.00683
G1 X90.16 Y101.385 E.00683
G1 X89.868 Y101.741 E.00975
G1 X89.505 Y102.049 E.01007
G1 X89.021 Y102.316 E.0117
G1 X88.511 Y102.473 E.01128
G1 X88.033 Y102.523 E.01018
G1 X87.483 Y102.471 E.0117
G1 X86.974 Y102.314 E.01128
G1 X86.556 Y102.089 E.01005
G1 X86.188 Y101.796 E.00995
G1 X85.879 Y101.442 E.00995
G1 X85.638 Y101.039 E.00994
G1 X85.476 Y100.607 E.00975
G1 X85.409 Y100.292 E.00683
G1 X85.381 Y99.979 E.00664
G1 X85.39 Y99.666 E.00663
G1 X85.438 Y99.347 E.00683
G1 X85.574 Y98.907 E.00975
G1 X85.791 Y98.489 E.00995
G1 X86.078 Y98.118 E.00995
G1 X86.42 Y97.809 E.00975
G1 X86.69 Y97.632 E.00683
G1 X86.979 Y97.487 E.00683
G1 X87.416 Y97.345 E.00975
G1 X87.882 Y97.282 E.00995
G1 X88.343 Y97.302 E.00975
G1 X88.659 Y97.365 E.00683
G1 X88.966 Y97.465 E.00683
G1 X89.378 Y97.671 E.00975
G1 X89.747 Y97.947 E.00975
G1 X89.973 Y98.177 E.00683
G1 X90.171 Y98.432 E.00683
G1 X90.398 Y98.84 E.00988
G1 X90.567 Y99.366 E.0117
G1 X90.61 Y99.78 E.00882
M204 S250
G1 X90.209 Y99.883 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X90.211 Y99.899 E.00033
G1 X90.175 Y100.296 E.00783
G1 X90.071 Y100.675 E.00774
G1 X89.962 Y100.919 E.00526
G1 X89.825 Y101.149 E.00526
G1 X89.575 Y101.452 E.00773
G1 X89.271 Y101.71 E.00783
G1 X88.86 Y101.937 E.00924
G1 X88.429 Y102.07 E.00887
G1 X88.031 Y102.112 E.00787
G1 X87.563 Y102.068 E.00924
G1 X87.133 Y101.935 E.00887
G1 X86.782 Y101.746 E.00783
G1 X86.472 Y101.499 E.0078
G1 X86.211 Y101.2 E.0078
G1 X86.008 Y100.86 E.00779
G1 X85.87 Y100.492 E.00774
G1 X85.814 Y100.23 E.00526
G1 X85.791 Y99.967 E.0052
G1 X85.799 Y99.703 E.0052
G1 X85.838 Y99.438 E.00526
G1 X85.954 Y99.062 E.00774
G1 X86.137 Y98.711 E.0078
G1 X86.379 Y98.397 E.0078
G1 X86.672 Y98.134 E.00773
G1 X86.895 Y97.987 E.00526
G1 X87.134 Y97.867 E.00526
G1 X87.508 Y97.746 E.00773
G1 X87.901 Y97.692 E.0078
G1 X88.294 Y97.71 E.00773
G1 X88.556 Y97.762 E.00526
G1 X88.811 Y97.844 E.00526
G1 X89.162 Y98.02 E.00774
G1 X89.477 Y98.256 E.00773
G1 X89.665 Y98.447 E.00526
G1 X89.828 Y98.658 E.00526
G1 X90.021 Y99.003 E.00777
G1 X90.164 Y99.451 E.00924
G1 X90.203 Y99.823 E.00736
; WIPE_START
M204 S6000
G1 X90.211 Y99.899 E-.01455
G1 X90.175 Y100.296 E-.07559
G1 X90.071 Y100.675 E-.07473
G1 X89.962 Y100.919 E-.05083
G1 X89.825 Y101.149 E-.05083
G1 X89.575 Y101.452 E-.07471
G1 X89.419 Y101.584 E-.03876
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X86.761 Y96.12 Z3 F18000
G1 Z2.6
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X94.11 Y96.119 E.15555
G1 X94.406 Y96.044 E.00645
G1 X94.666 Y95.882 E.00649
G1 X94.864 Y95.654 E.0064
G1 X94.986 Y95.382 E.00631
G1 X95.019 Y95.144 E.00509
G1 X95.019 Y94.72 E.00896
G1 X95.381 Y94.72 E.00765
G1 X95.381 Y95.565 E.01788
G1 X95.353 Y95.803 E.00508
G1 X95.28 Y96.003 E.0045
G1 X95.207 Y96.122 E.00295
G1 X95.087 Y96.253 E.00376
G1 X94.941 Y96.359 E.00382
G1 X94.751 Y96.441 E.00438
G1 X94.533 Y96.479 E.0047
G1 X89.442 Y96.483 E.10774
G1 X90.544 Y97.675 E.03436
G1 X90.795 Y98 E.00869
G1 X91.005 Y98.353 E.00869
G1 X91.229 Y98.901 E.01254
G1 X91.354 Y99.48 E.01254
G1 X91.38 Y99.892 E.00874
G1 X91.328 Y100.495 E.0128
G1 X91.168 Y101.079 E.01281
G1 X90.914 Y101.613 E.01253
G1 X90.69 Y101.947 E.0085
G1 X90.429 Y102.251 E.00849
G1 X90.126 Y102.529 E.00869
G1 X89.635 Y102.859 E.01254
G1 X89.273 Y103.032 E.00849
G1 X88.884 Y103.164 E.00869
G1 X88.301 Y103.267 E.01254
G1 X87.9 Y103.279 E.00849
G1 X87.5 Y103.243 E.00849
G1 X87.113 Y103.162 E.00836
G1 X86.62 Y102.984 E.01109
G1 X86.189 Y102.754 E.01035
G1 X85.867 Y102.522 E.00839
G1 X85.571 Y102.251 E.0085
G1 X85.31 Y101.947 E.00849
G1 X85.086 Y101.613 E.0085
G1 X84.907 Y101.262 E.00836
G1 X84.735 Y100.766 E.0111
G1 X84.643 Y100.286 E.01036
G1 X84.62 Y99.89 E.00839
G1 X84.645 Y99.49 E.00849
G1 X84.718 Y99.095 E.0085
G1 X84.835 Y98.717 E.00836
G1 X85.058 Y98.243 E.0111
G1 X85.326 Y97.834 E.01035
G1 X86.503 Y96.482 E.03795
G1 X81.536 Y96.482 E.10513
G1 X81.289 Y96.453 E.00527
G1 X81.143 Y96.405 E.00324
G1 X80.888 Y96.23 E.00655
G1 X80.741 Y96.043 E.00505
G1 X80.649 Y95.821 E.00508
G1 X80.619 Y95.565 E.00546
G1 X80.619 Y77.619 E.37984
G1 X80.659 Y77.346 E.00584
G1 X80.763 Y77.122 E.00524
G1 X80.861 Y76.998 E.00333
G1 X80.975 Y76.896 E.00324
G1 X81.191 Y76.778 E.00521
G1 X81.449 Y76.723 E.00559
G1 X94.507 Y76.721 E.27638
G1 X94.659 Y76.736 E.00322
G1 X94.866 Y76.802 E.00462
G1 X94.988 Y76.869 E.00294
G1 X95.153 Y77.013 E.00462
G1 X95.277 Y77.19 E.00459
G1 X95.356 Y77.407 E.00488
G1 X95.378 Y77.559 E.00325
G1 X95.38 Y78.482 E.01952
G1 X95.019 Y78.482 E.00763
G1 X95.019 Y78.057 E.00899
G1 X94.984 Y77.813 E.0052
G1 X94.861 Y77.542 E.00632
G1 X94.64 Y77.298 E.00697
G1 X94.359 Y77.139 E.00684
G1 X94.088 Y77.082 E.00586
G1 X81.946 Y77.082 E.25699
G1 X81.657 Y77.132 E.0062
G1 X81.387 Y77.278 E.00649
G1 X81.171 Y77.495 E.00649
G1 X81.019 Y77.798 E.00717
G1 X80.981 Y78.056 E.00553
G1 X80.981 Y95.164 E.36211
G1 X81.05 Y95.501 E.00727
G1 X81.257 Y95.815 E.00796
G1 X81.591 Y96.049 E.00864
G1 X81.937 Y96.12 E.00747
G1 X86.701 Y96.12 E.10083
; WIPE_START
M204 S6000
G1 X88.701 Y96.119 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X85.605 Y96.891 Z3 F18000
G1 Z2.6
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X81.512 Y96.891 E.08049
G1 X81.2 Y96.854 E.00619
G1 X80.986 Y96.784 E.00442
G1 X80.861 Y96.72 E.00277
G1 X80.612 Y96.535 E.00609
G1 X80.493 Y96.405 E.00347
G1 X80.384 Y96.246 E.00379
G1 X80.287 Y96.039 E.0045
G1 X80.247 Y95.904 E.00277
G1 X80.21 Y95.589 E.00625
G1 X80.21 Y77.607 E.35368
G1 X80.219 Y77.454 E.00301
G1 X80.265 Y77.23 E.0045
G1 X80.335 Y77.051 E.00379
G1 X80.422 Y76.894 E.00353
G1 X80.562 Y76.716 E.00445
G1 X80.73 Y76.567 E.00442
G1 X80.924 Y76.447 E.00448
G1 X81.056 Y76.39 E.00283
G1 X81.279 Y76.33 E.00454
G1 X81.425 Y76.313 E.00289
G1 X94.527 Y76.312 E.2577
G1 X94.726 Y76.331 E.00393
G1 X95.039 Y76.43 E.00646
G1 X95.21 Y76.525 E.00384
G1 X95.459 Y76.739 E.00646
G1 X95.649 Y77.017 E.00662
G1 X95.755 Y77.307 E.00606
G1 X95.787 Y77.529 E.00442
G1 X95.79 Y78.891 E.02679
G1 X94.61 Y78.891 E.0232
G1 X94.61 Y78.086 E.01583
G1 X94.588 Y77.929 E.00311
G1 X94.515 Y77.769 E.00347
G1 X94.381 Y77.621 E.00391
G1 X94.213 Y77.527 E.0038
G1 X94.045 Y77.492 E.00337
G1 X81.982 Y77.491 E.23728
G1 X81.793 Y77.524 E.00376
G1 X81.634 Y77.61 E.00355
G1 X81.507 Y77.738 E.00356
G1 X81.414 Y77.922 E.00406
G1 X81.39 Y78.086 E.00325
G1 X81.39 Y95.122 E.3351
G1 X81.435 Y95.341 E.0044
G1 X81.556 Y95.524 E.00431
G1 X81.757 Y95.665 E.00483
G1 X81.979 Y95.711 E.00446
G1 X94.059 Y95.709 E.23762
G1 X94.243 Y95.663 E.00373
G1 X94.397 Y95.567 E.00357
G1 X94.516 Y95.431 E.00355
G1 X94.589 Y95.268 E.00351
G1 X94.61 Y95.115 E.00303
G1 X94.61 Y94.311 E.01582
G1 X95.79 Y94.311 E.02321
G1 X95.79 Y95.589 E.02513
G1 X95.754 Y95.898 E.00613
G1 X95.651 Y96.182 E.00594
G1 X95.535 Y96.369 E.00433
G1 X95.361 Y96.559 E.00506
G1 X95.145 Y96.716 E.00525
G1 X94.87 Y96.835 E.00591
G1 X94.569 Y96.888 E.00601
G1 X90.377 Y96.891 E.08245
G1 X90.857 Y97.411 E.01392
G1 X91.134 Y97.77 E.00891
G1 X91.366 Y98.159 E.00891
G1 X91.461 Y98.356 E.00431
G1 X91.62 Y98.78 E.00891
G1 X91.728 Y99.22 E.00891
G1 X91.761 Y99.437 E.00431
G1 X91.79 Y99.889 E.00893
G1 X91.773 Y100.243 E.00697
G1 X91.687 Y100.778 E.01065
G1 X91.555 Y101.215 E.00897
G1 X91.473 Y101.417 E.0043
G1 X91.267 Y101.821 E.00891
G1 X91.017 Y102.195 E.00885
G1 X90.723 Y102.536 E.00885
G1 X90.39 Y102.842 E.00891
G1 X90.216 Y102.975 E.0043
G1 X89.833 Y103.218 E.00891
G1 X89.427 Y103.412 E.00885
G1 X88.998 Y103.557 E.00891
G1 X88.785 Y103.608 E.0043
G1 X88.337 Y103.676 E.00891
G1 X87.887 Y103.689 E.00885
G1 X87.439 Y103.649 E.00885
G1 X87.001 Y103.556 E.00881
G1 X86.454 Y103.359 E.01144
G1 X85.972 Y103.102 E.01074
G1 X85.608 Y102.84 E.00882
G1 X85.277 Y102.536 E.00885
G1 X84.983 Y102.195 E.00885
G1 X84.733 Y101.821 E.00885
G1 X84.529 Y101.422 E.00881
G1 X84.339 Y100.872 E.01145
G1 X84.236 Y100.336 E.01074
G1 X84.21 Y99.889 E.00882
G1 X84.239 Y99.44 E.00885
G1 X84.32 Y98.997 E.00885
G1 X84.452 Y98.569 E.00881
G1 X84.699 Y98.043 E.01145
G1 X84.999 Y97.587 E.01073
G1 X85.565 Y96.936 E.01696
; WIPE_START
M204 S6000
G1 X83.565 Y96.914 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G17
G3 Z3 I1.217 J0 P1  F18000
;===================== date: 20250206 =====================

; don't support timelapse gcode in spiral_mode and by object sequence for I3 structure printer
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
G92 E0
G1 Z3
G1 X0 Y90 ; move to safe pos
G1 X-13.0 F3000 ; move to safe pos
M400
M1004 S5 P1  ; external shutter
M400 P300
M971 S11 C11 O0
G92 E0
G1 X0 F18000
M623

; SKIPTYPE: head_wrap_detect
M622.1 S1
M1002 judge_flag g39_3rd_layer_detect_flag
M622 J1
    ; enable nozzle clog detect at 3rd layer
    


    M622.1 S1
    M1002 judge_flag g39_detection_flag
    M622 J1
      
        M622.1 S0
        M1002 judge_flag g39_mass_exceed_flag
        M622 J1
        
            G392 S0
            M400
            G90
            M83
            M204 S5000
            G0 Z3 F4000
            G39.3 S1
            G0 Z3 F4000
            G392 S0
          
        M623
    
    M623
M623
; SKIPPABLE_END




G1 X81.456 Y96.238
G1 Z2.6
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.0962553
G1 F1500
M204 S6000
G1 X81.354 Y96.193 E.00039
; LINE_WIDTH: 0.149092
G1 X81.251 Y96.148 E.00069
G1 X81.066 Y96.016 E.0014
G1 X80.982 Y95.903 E.00087
G1 X80.844 Y95.655 E.00174
; WIPE_START
G1 X80.982 Y95.903 E-.14095
G1 X81.066 Y96.016 E-.07044
M73 P66 R8
G1 X81.251 Y96.148 E-.11291
G1 X81.354 Y96.193 E-.0557
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X86.548 Y97.165 Z3 F18000
G1 Z2.6
G1 E.4 F1800
; LINE_WIDTH: 0.477106
G1 F1500
M204 S6000
G1 X86.367 Y97.319 E.00534
; LINE_WIDTH: 0.438389
G1 X86.16 Y97.496 E.00562
; LINE_WIDTH: 0.400587
G1 X85.986 Y97.673 E.00464
; LINE_WIDTH: 0.360651
G1 X85.633 Y98.067 E.00884
G1 X85.391 Y98.43 E.00728
G1 X85.221 Y98.778 E.00647
G1 X85.073 Y99.251 E.00828
G1 X85.014 Y99.642 E.00661
G1 X85.003 Y99.981 E.00566
G1 X85.022 Y100.239 E.00432
G1 X85.102 Y100.668 E.00729
G1 X85.258 Y101.112 E.00786
G1 X85.418 Y101.418 E.00577
G1 X85.613 Y101.716 E.00595
G1 X85.939 Y102.078 E.00814
G1 X86.36 Y102.412 E.00898
G1 X86.814 Y102.654 E.0086
G1 X87.219 Y102.791 E.00714
G1 X87.557 Y102.863 E.00578
G1 X88.019 Y102.899 E.00774
G1 X88.603 Y102.84 E.00981
G1 X89.131 Y102.679 E.00923
G1 X89.448 Y102.521 E.00591
G1 X89.733 Y102.35 E.00555
G1 X90.147 Y101.996 E.00912
G1 X90.385 Y101.714 E.00615
G1 X90.656 Y101.29 E.00841
G1 X90.805 Y100.951 E.0062
G1 X90.953 Y100.435 E.00896
G1 X91 Y99.91 E.00882
G1 X90.932 Y99.272 E.01071
G1 X90.739 Y98.674 E.0105
G1 X90.493 Y98.234 E.00842
G1 X90.254 Y97.92 E.0066
G1 X89.991 Y97.647 E.00633
; LINE_WIDTH: 0.397622
G1 X89.807 Y97.48 E.00461
; LINE_WIDTH: 0.44277
G1 X89.622 Y97.314 E.00518
; LINE_WIDTH: 0.48059
G1 X89.38 Y97.129 E.00691
; WIPE_START
G1 X89.622 Y97.314 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X94.531 Y96.242 Z3 F18000
G1 Z2.6
G1 E.4 F1800
; LINE_WIDTH: 0.104155
G1 F1500
M204 S6000
G1 X94.675 Y96.186 E.00061
; LINE_WIDTH: 0.148071
G1 X94.804 Y96.119 E.00089
G1 X94.897 Y96.044 E.00073
G1 X95.08 Y95.8 E.00186
; LINE_WIDTH: 0.101227
G1 X95.138 Y95.618 E.00072
; WIPE_START
G1 X95.08 Y95.8 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X95.108 Y88.167 Z3 F18000
G1 X95.147 Y77.601 Z3
G1 Z2.6
G1 E.4 F1800
; LINE_WIDTH: 0.102314
G1 F1500
M204 S6000
G1 X95.075 Y77.393 E.00084
; LINE_WIDTH: 0.137532
G1 X95.026 Y77.311 E.00053
; LINE_WIDTH: 0.159082
G1 X94.836 Y77.101 E.00188
G1 X94.753 Y77.05 E.00065
; LINE_WIDTH: 0.129059
G1 X94.514 Y76.945 E.00135
; WIPE_START
G1 X94.753 Y77.05 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X87.121 Y76.995 Z3 F18000
G1 X81.496 Y76.955 Z3
G1 Z2.6
G1 E.4 F1800
; LINE_WIDTH: 0.0811903
G1 F1500
M204 S6000
G1 X81.464 Y76.963 E.00009
; LINE_WIDTH: 0.0962576
G1 X81.373 Y76.997 E.00034
; LINE_WIDTH: 0.129102
G1 X81.22 Y77.066 E.00086
; LINE_WIDTH: 0.152182
G1 X81.071 Y77.192 E.00123
G1 X80.948 Y77.341 E.00122
G1 X80.913 Y77.42 E.00054
; LINE_WIDTH: 0.115891
G1 X80.884 Y77.512 E.00044
; LINE_WIDTH: 0.0899971
G1 X80.854 Y77.604 E.00031
; WIPE_START
G1 X80.884 Y77.512 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X88.281 Y79.393 Z3 F18000
G1 X96.743 Y81.544 Z3
G1 Z2.6
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X97.257 Y81.544 E.01086
G1 X97.257 Y82.057 E.01086
G1 X96.743 Y82.057 E.01086
G1 X96.743 Y81.604 E.00959
M204 S10000
G1 X96.319 Y81.12 F18000
G1 F1500
M204 S500
G1 X97.681 Y81.12 E.02882
G1 X97.681 Y82.482 E.02882
G1 X96.319 Y82.482 E.02882
G1 X96.319 Y81.18 E.02755
M204 S250
G1 X95.91 Y80.711 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X98.09 Y80.711 E.04288
G1 X98.09 Y82.891 E.04288
G1 X95.91 Y82.891 E.04288
G1 X95.91 Y80.771 E.0417
; CHANGE_LAYER
; Z_HEIGHT: 2.72
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F1500
M204 S6000
G1 X97.909 Y80.716 E-.38
; WIPE_END
G1 E-.02 F1800
; layer num/total_layer_count: 22/49
; update layer progress
M73 L22
M991 S0 P21 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z3 I-1.075 J-.571 P1  F18000
G1 X89.21 Y97.098 Z3
G1 Z2.72
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X88.766 Y96.953 E.00987
G1 X88.393 Y96.88 E.00804
G1 X87.863 Y96.856 E.01123
G1 X87.322 Y96.93 E.01157
G1 X86.766 Y97.11 E.01238
G1 X86.659 Y96.949 E.0041
G1 X87.011 Y96.544 E.01137
G1 X88.97 Y96.543 E.04146
G1 X89.316 Y96.935 E.01107
G1 X89.243 Y97.047 E.00285
; WIPE_START
M204 S6000
G1 X88.766 Y96.953 E-.09228
G1 X88.393 Y96.88 E-.07221
G1 X87.863 Y96.856 E-.1008
G1 X87.322 Y96.93 E-.10383
G1 X87.267 Y96.947 E-.01088
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X90.616 Y99.84 Z3.12 F18000
G1 Z2.72
G1 E.4 F1800
G1 F1500
M204 S500
G1 X90.622 Y99.896 E.00119
G1 X90.58 Y100.369 E.01005
G1 X90.453 Y100.828 E.01007
G1 X90.205 Y101.319 E.01164
G1 X89.871 Y101.738 E.01134
G1 X89.505 Y102.049 E.01017
G1 X89.023 Y102.315 E.01164
G1 X88.511 Y102.473 E.01134
G1 X88.033 Y102.523 E.01018
G1 X87.486 Y102.472 E.01164
G1 X86.974 Y102.314 E.01133
G1 X86.556 Y102.089 E.01005
G1 X86.188 Y101.796 E.00995
G1 X85.879 Y101.442 E.00995
G1 X85.638 Y101.038 E.00995
G1 X85.476 Y100.607 E.00975
G1 X85.409 Y100.291 E.00683
G1 X85.381 Y99.979 E.00663
G1 X85.39 Y99.666 E.00663
G1 X85.438 Y99.347 E.00683
G1 X85.574 Y98.907 E.00975
G1 X85.791 Y98.489 E.00995
G1 X86.078 Y98.118 E.00995
G1 X86.42 Y97.809 E.00975
G1 X86.69 Y97.632 E.00683
G1 X86.979 Y97.487 E.00683
G1 X87.417 Y97.345 E.00975
G1 X87.882 Y97.282 E.00995
G1 X88.343 Y97.302 E.00975
G1 X88.659 Y97.365 E.00683
G1 X88.957 Y97.462 E.00663
G1 X89.242 Y97.593 E.00663
G1 X89.516 Y97.763 E.00683
G1 X89.868 Y98.061 E.00975
G1 X90.166 Y98.424 E.00995
G1 X90.398 Y98.84 E.01007
G1 X90.566 Y99.363 E.01164
G1 X90.61 Y99.78 E.00887
M204 S250
G1 X90.209 Y99.883 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X90.211 Y99.899 E.00032
G1 X90.175 Y100.296 E.00783
G1 X90.069 Y100.68 E.00784
G1 X89.859 Y101.097 E.00919
G1 X89.576 Y101.451 E.00892
G1 X89.271 Y101.71 E.00787
G1 X88.862 Y101.936 E.00919
G1 X88.429 Y102.07 E.00892
G1 X88.031 Y102.112 E.00787
G1 X87.566 Y102.068 E.00919
G1 X87.133 Y101.935 E.00892
G1 X86.782 Y101.746 E.00783
G1 X86.472 Y101.499 E.0078
G1 X86.211 Y101.2 E.0078
G1 X86.008 Y100.86 E.0078
G1 X85.87 Y100.492 E.00773
G1 X85.814 Y100.23 E.00526
G1 X85.791 Y99.967 E.0052
G1 X85.799 Y99.703 E.0052
G1 X85.838 Y99.438 E.00526
G1 X85.954 Y99.062 E.00774
G1 X86.137 Y98.711 E.00779
G1 X86.379 Y98.397 E.0078
G1 X86.672 Y98.134 E.00773
G1 X86.895 Y97.987 E.00526
G1 X87.134 Y97.867 E.00526
G1 X87.508 Y97.745 E.00773
G1 X87.901 Y97.692 E.0078
G1 X88.294 Y97.71 E.00773
G1 X88.556 Y97.762 E.00526
G1 X88.808 Y97.843 E.0052
G1 X89.047 Y97.954 E.0052
G1 X89.275 Y98.095 E.00526
G1 X89.575 Y98.349 E.00773
G1 X89.827 Y98.655 E.0078
G1 X90.021 Y99.003 E.00784
G1 X90.163 Y99.448 E.00919
G1 X90.203 Y99.823 E.00742
; WIPE_START
M204 S6000
G1 X90.211 Y99.899 E-.01451
G1 X90.175 Y100.296 E-.0756
G1 X90.069 Y100.68 E-.07571
G1 X89.859 Y101.097 E-.08878
G1 X89.576 Y101.451 E-.08615
G1 X89.419 Y101.585 E-.03925
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X86.761 Y96.119 Z3.12 F18000
G1 Z2.72
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X94.111 Y96.119 E.15557
G1 X94.406 Y96.044 E.00644
G1 X94.665 Y95.882 E.00648
G1 X94.864 Y95.654 E.00641
G1 X94.987 Y95.381 E.00634
G1 X95.019 Y95.143 E.00507
G1 X95.019 Y94.72 E.00896
G1 X95.381 Y94.72 E.00765
G1 X95.381 Y95.565 E.01788
G1 X95.353 Y95.803 E.00508
G1 X95.28 Y96.003 E.0045
G1 X95.207 Y96.122 E.00295
G1 X95.086 Y96.253 E.00379
G1 X94.941 Y96.359 E.00379
G1 X94.751 Y96.441 E.00438
G1 X94.533 Y96.479 E.0047
G1 X89.483 Y96.483 E.1069
G1 X90.622 Y97.77 E.03638
G1 X90.793 Y97.997 E.00603
G1 X91 Y98.345 E.00857
G1 X91.167 Y98.72 E.00869
G1 X91.326 Y99.3 E.01273
G1 X91.38 Y99.89 E.01254
G1 X91.357 Y100.293 E.00855
G1 X91.236 Y100.876 E.0126
G1 X91.096 Y101.256 E.00857
G1 X90.91 Y101.622 E.00869
G1 X90.696 Y101.94 E.0081
G1 X90.292 Y102.385 E.01273
G1 X89.974 Y102.644 E.00869
G1 X89.635 Y102.859 E.0085
G1 X89.273 Y103.032 E.00849
G1 X88.884 Y103.164 E.00869
G1 X88.301 Y103.267 E.01253
G1 X87.9 Y103.279 E.00849
G1 X87.5 Y103.243 E.00849
G1 X87.107 Y103.161 E.00849
G1 X86.727 Y103.032 E.00849
G1 X86.371 Y102.861 E.00837
G1 X85.937 Y102.575 E.011
G1 X85.568 Y102.247 E.01045
G1 X85.31 Y101.947 E.00839
G1 X85.086 Y101.613 E.00849
G1 X84.907 Y101.261 E.00836
G1 X84.736 Y100.77 E.011
G1 X84.643 Y100.286 E.01045
G1 X84.62 Y99.89 E.00839
G1 X84.645 Y99.49 E.00849
G1 X84.718 Y99.095 E.0085
G1 X84.835 Y98.717 E.00837
G1 X85.055 Y98.247 E.011
G1 X85.326 Y97.834 E.01045
G1 X86.503 Y96.482 E.03794
G1 X81.536 Y96.482 E.10512
G1 X81.286 Y96.452 E.00534
G1 X81.172 Y96.416 E.00253
G1 X80.979 Y96.309 E.00467
G1 X80.791 Y96.121 E.00562
G1 X80.685 Y95.929 E.00465
G1 X80.649 Y95.815 E.00253
G1 X80.619 Y95.565 E.00534
G1 X80.619 Y77.619 E.37984
G1 X80.659 Y77.349 E.00578
G1 X80.76 Y77.125 E.0052
G1 X80.861 Y76.998 E.00343
G1 X80.975 Y76.896 E.00324
G1 X81.194 Y76.777 E.00527
G1 X81.454 Y76.723 E.00562
G1 X94.509 Y76.721 E.27631
G1 X94.658 Y76.736 E.00319
G1 X94.744 Y76.756 E.00185
G1 X94.976 Y76.861 E.00539
G1 X95.161 Y77.022 E.0052
G1 X95.283 Y77.208 E.00469
G1 X95.356 Y77.407 E.0045
G1 X95.378 Y77.559 E.00325
G1 X95.38 Y78.482 E.01952
G1 X95.019 Y78.482 E.00763
G1 X95.019 Y78.057 E.00899
G1 X94.984 Y77.813 E.00522
G1 X94.861 Y77.542 E.00631
G1 X94.641 Y77.298 E.00693
G1 X94.359 Y77.139 E.00687
G1 X94.088 Y77.082 E.00586
G1 X81.951 Y77.082 E.25689
G1 X81.679 Y77.125 E.00581
G1 X81.383 Y77.278 E.00705
G1 X81.147 Y77.528 E.00729
G1 X81.017 Y77.806 E.00649
G1 X80.981 Y78.056 E.00533
G1 X80.981 Y95.155 E.36192
G1 X81.035 Y95.462 E.0066
G1 X81.249 Y95.809 E.00864
G1 X81.591 Y96.049 E.00884
G1 X81.937 Y96.12 E.00747
G1 X86.701 Y96.119 E.10083
; WIPE_START
M204 S6000
G1 X88.701 Y96.119 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X85.604 Y96.891 Z3.12 F18000
G1 Z2.72
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X81.512 Y96.891 E.08049
G1 X81.199 Y96.854 E.00621
G1 X81.02 Y96.797 E.00369
G1 X80.854 Y96.717 E.00363
G1 X80.592 Y96.515 E.0065
G1 X80.384 Y96.247 E.00668
G1 X80.304 Y96.081 E.00363
G1 X80.247 Y95.902 E.00369
G1 X80.21 Y95.589 E.00621
G1 X80.21 Y77.607 E.35368
G1 X80.219 Y77.454 E.00301
G1 X80.265 Y77.231 E.00448
G1 X80.349 Y77.019 E.00448
G1 X80.421 Y76.895 E.00283
G1 X80.562 Y76.716 E.00448
G1 X80.73 Y76.567 E.00442
G1 X80.924 Y76.447 E.00448
G1 X81.057 Y76.39 E.00285
G1 X81.244 Y76.338 E.00381
G1 X81.427 Y76.313 E.00363
G1 X94.528 Y76.312 E.2577
G1 X94.726 Y76.331 E.0039
G1 X94.867 Y76.365 E.00285
G1 X95.081 Y76.45 E.00454
G1 X95.206 Y76.522 E.00283
G1 X95.387 Y76.665 E.00454
G1 X95.484 Y76.767 E.00277
G1 X95.652 Y77.023 E.00601
G1 X95.755 Y77.307 E.00594
G1 X95.787 Y77.529 E.00442
G1 X95.79 Y78.891 E.02678
G1 X94.61 Y78.891 E.0232
G1 X94.61 Y78.086 E.01583
G1 X94.587 Y77.929 E.00312
G1 X94.515 Y77.769 E.00346
G1 X94.382 Y77.622 E.00388
G1 X94.213 Y77.527 E.00382
G1 X94.045 Y77.492 E.00337
G1 X81.983 Y77.491 E.23725
G1 X81.809 Y77.519 E.00347
G1 X81.633 Y77.61 E.00389
G1 X81.49 Y77.761 E.0041
G1 X81.414 Y77.925 E.00356
G1 X81.39 Y78.086 E.00319
G1 X81.39 Y95.119 E.33504
G1 X81.424 Y95.314 E.00389
G1 X81.553 Y95.523 E.00482
G1 X81.757 Y95.665 E.00489
G1 X81.979 Y95.711 E.00446
G1 X94.06 Y95.709 E.23763
G1 X94.243 Y95.663 E.00372
G1 X94.397 Y95.567 E.00356
G1 X94.516 Y95.431 E.00355
G1 X94.589 Y95.267 E.00354
G1 X94.61 Y95.115 E.00301
G1 X94.61 Y94.311 E.01582
G1 X95.79 Y94.311 E.02321
G1 X95.79 Y95.589 E.02513
G1 X95.754 Y95.898 E.00613
G1 X95.65 Y96.182 E.00594
G1 X95.535 Y96.369 E.00433
G1 X95.36 Y96.56 E.00509
G1 X95.145 Y96.716 E.00522
G1 X94.87 Y96.835 E.00591
G1 X94.569 Y96.888 E.00601
G1 X90.391 Y96.891 E.08218
G1 X90.939 Y97.511 E.01627
G1 X91.133 Y97.769 E.00635
G1 X91.364 Y98.156 E.00887
G1 X91.548 Y98.57 E.00891
G1 X91.619 Y98.777 E.00431
G1 X91.728 Y99.22 E.00897
G1 X91.761 Y99.437 E.00431
G1 X91.79 Y99.889 E.00891
G1 X91.764 Y100.339 E.00887
G1 X91.706 Y100.684 E.00688
G1 X91.628 Y100.997 E.00636
G1 X91.472 Y101.42 E.00887
G1 X91.266 Y101.824 E.00891
G1 X91.148 Y102.012 E.00437
G1 X91.019 Y102.192 E.00437
G1 X90.721 Y102.538 E.00897
G1 X90.565 Y102.691 E.0043
G1 X90.213 Y102.977 E.00891
G1 X89.833 Y103.218 E.00885
G1 X89.427 Y103.412 E.00885
G1 X88.998 Y103.557 E.00892
G1 X88.785 Y103.608 E.0043
G1 X88.337 Y103.676 E.00891
G1 X87.887 Y103.689 E.00885
G1 X87.439 Y103.649 E.00885
M73 P67 R7
G1 X86.999 Y103.556 E.00885
G1 X86.573 Y103.412 E.00885
G1 X86.169 Y103.219 E.00881
G1 X85.687 Y102.901 E.01135
G1 X85.275 Y102.535 E.01083
G1 X84.983 Y102.195 E.00882
G1 X84.733 Y101.821 E.00885
G1 X84.529 Y101.422 E.00881
G1 X84.34 Y100.877 E.01135
G1 X84.236 Y100.336 E.01083
G1 X84.21 Y99.889 E.00882
G1 X84.239 Y99.44 E.00885
G1 X84.32 Y98.997 E.00885
G1 X84.452 Y98.569 E.00881
G1 X84.697 Y98.047 E.01135
G1 X84.999 Y97.586 E.01083
G1 X85.565 Y96.936 E.01695
; WIPE_START
M204 S6000
G1 X83.565 Y96.914 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G17
G3 Z3.12 I1.217 J0 P1  F18000
;===================== date: 20250206 =====================

; don't support timelapse gcode in spiral_mode and by object sequence for I3 structure printer
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
G92 E0
G1 Z3.12
G1 X0 Y90 ; move to safe pos
G1 X-13.0 F3000 ; move to safe pos
M400
M1004 S5 P1  ; external shutter
M400 P300
M971 S11 C11 O0
G92 E0
G1 X0 F18000
M623

; SKIPTYPE: head_wrap_detect
M622.1 S1
M1002 judge_flag g39_3rd_layer_detect_flag
M622 J1
    ; enable nozzle clog detect at 3rd layer
    


    M622.1 S1
    M1002 judge_flag g39_detection_flag
    M622 J1
      
        M622.1 S0
        M1002 judge_flag g39_mass_exceed_flag
        M622 J1
        
            G392 S0
            M400
            G90
            M83
            M204 S5000
            G0 Z3.12 F4000
            G39.3 S1
            G0 Z3.12 F4000
            G392 S0
          
        M623
    
    M623
M623
; SKIPPABLE_END




G1 X81.434 Y96.255
G1 Z2.72
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.155537
G1 F1500
M204 S6000
G1 X81.077 Y96.027 E.00274
G1 X80.941 Y95.829 E.00155
; LINE_WIDTH: 0.130277
G1 X80.901 Y95.727 E.00057
; LINE_WIDTH: 0.0952581
G1 X80.861 Y95.625 E.00038
; WIPE_START
G1 X80.901 Y95.727 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X86.547 Y97.165 Z3.12 F18000
G1 Z2.72
G1 E.4 F1800
; LINE_WIDTH: 0.477126
G1 F1500
M204 S6000
G1 X86.367 Y97.319 E.00533
; LINE_WIDTH: 0.438443
G1 X86.16 Y97.496 E.00561
; LINE_WIDTH: 0.400652
G1 X85.986 Y97.673 E.00464
; LINE_WIDTH: 0.361021
G1 X85.633 Y98.066 E.00884
G1 X85.389 Y98.434 E.00737
G1 X85.221 Y98.778 E.00641
G1 X85.073 Y99.251 E.00829
G1 X85.014 Y99.642 E.00662
G1 X85.003 Y99.981 E.00567
G1 X85.022 Y100.238 E.00432
G1 X85.103 Y100.672 E.00738
G1 X85.258 Y101.112 E.0078
G1 X85.418 Y101.418 E.00579
G1 X85.613 Y101.716 E.00595
G1 X85.918 Y102.057 E.00766
G1 X86.362 Y102.409 E.00947
G1 X86.814 Y102.656 E.00861
G1 X87.209 Y102.789 E.00698
G1 X87.557 Y102.863 E.00595
G1 X88.019 Y102.899 E.00776
G1 X88.571 Y102.841 E.00928
G1 X88.782 Y102.792 E.00362
G1 X89.186 Y102.655 E.00715
G1 X89.733 Y102.35 E.01046
G1 X90.15 Y101.995 E.00917
G1 X90.391 Y101.704 E.00632
G1 X90.578 Y101.43 E.00554
G1 X90.798 Y100.978 E.00841
G1 X90.868 Y100.766 E.00374
G1 X90.976 Y100.247 E.00886
G1 X91.001 Y99.891 E.00597
G1 X90.935 Y99.303 E.00991
G1 X90.856 Y99.004 E.00516
G1 X90.658 Y98.52 E.00876
G1 X90.478 Y98.209 E.00601
G1 X90.128 Y97.784 E.00921
; LINE_WIDTH: 0.378056
G1 X89.95 Y97.61 E.00437
; LINE_WIDTH: 0.4163
G1 X89.746 Y97.413 E.00552
; LINE_WIDTH: 0.453054
G1 X89.588 Y97.282 E.00439
; LINE_WIDTH: 0.480468
G1 X89.429 Y97.151 E.00467
; WIPE_START
G1 X89.588 Y97.282 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X94.531 Y96.242 Z3.12 F18000
G1 Z2.72
G1 E.4 F1800
; LINE_WIDTH: 0.104165
G1 F1500
M204 S6000
G1 X94.675 Y96.186 E.00061
; LINE_WIDTH: 0.148042
G1 X94.805 Y96.119 E.00089
G1 X94.896 Y96.045 E.00072
G1 X95.08 Y95.8 E.00187
; LINE_WIDTH: 0.10121
G1 X95.138 Y95.618 E.00072
; WIPE_START
G1 X95.08 Y95.8 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X95.108 Y88.167 Z3.12 F18000
G1 X95.147 Y77.601 Z3.12
G1 Z2.72
G1 E.4 F1800
; LINE_WIDTH: 0.102397
G1 F1500
M204 S6000
G1 X95.075 Y77.392 E.00084
; LINE_WIDTH: 0.133171
G1 X95.038 Y77.331 E.00039
; LINE_WIDTH: 0.156099
G1 X94.94 Y77.204 E.00104
G1 X94.781 Y77.064 E.00138
; LINE_WIDTH: 0.13001
G1 X94.514 Y76.944 E.00152
; WIPE_START
G1 X94.781 Y77.064 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X87.149 Y77.002 Z3.12 F18000
G1 X81.501 Y76.955 Z3.12
G1 Z2.72
G1 E.4 F1800
; LINE_WIDTH: 0.0807758
G1 F1500
M204 S6000
G1 X81.471 Y76.963 E.00009
; LINE_WIDTH: 0.0952296
G1 X81.377 Y76.996 E.00034
; LINE_WIDTH: 0.127716
G1 X81.214 Y77.068 E.00091
; LINE_WIDTH: 0.156177
G1 X81.071 Y77.194 E.00124
G1 X80.925 Y77.387 E.00158
; LINE_WIDTH: 0.103612
G1 X80.855 Y77.602 E.00088
; WIPE_START
G1 X80.925 Y77.387 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X88.306 Y79.327 Z3.12 F18000
G1 X96.743 Y81.544 Z3.12
G1 Z2.72
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X97.257 Y81.544 E.01086
G1 X97.257 Y82.057 E.01086
G1 X96.743 Y82.057 E.01086
G1 X96.743 Y81.604 E.00959
M204 S10000
G1 X96.319 Y81.12 F18000
G1 F1500
M204 S500
G1 X97.681 Y81.12 E.02882
G1 X97.681 Y82.482 E.02882
G1 X96.319 Y82.482 E.02882
G1 X96.319 Y81.18 E.02755
M204 S250
G1 X95.91 Y80.711 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X98.09 Y80.711 E.04288
G1 X98.09 Y82.891 E.04288
G1 X95.91 Y82.891 E.04288
G1 X95.91 Y80.771 E.0417
; CHANGE_LAYER
; Z_HEIGHT: 2.84
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F1500
M204 S6000
G1 X97.909 Y80.716 E-.38
; WIPE_END
G1 E-.02 F1800
; layer num/total_layer_count: 23/49
; update layer progress
M73 L23
M991 S0 P22 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z3.12 I-1.073 J-.574 P1  F18000
G1 X89.159 Y97.081 Z3.12
G1 Z2.84
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X88.751 Y96.949 E.00907
G1 X88.228 Y96.862 E.01123
G1 X87.697 Y96.87 E.01123
G1 X87.322 Y96.932 E.00805
G1 X86.958 Y97.038 E.00804
G1 X86.774 Y97.124 E.0043
G1 X86.65 Y96.959 E.00436
G1 X87.011 Y96.544 E.01165
G1 X88.921 Y96.543 E.04043
G1 X89.265 Y96.916 E.01072
G1 X89.191 Y97.031 E.00289
; WIPE_START
M204 S6000
G1 X88.751 Y96.949 E-.08505
G1 X88.228 Y96.862 E-.10083
G1 X87.697 Y96.87 E-.10083
G1 X87.322 Y96.932 E-.07223
G1 X87.216 Y96.963 E-.02105
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X90.609 Y99.886 Z3.24 F18000
G1 Z2.84
G1 E.4 F1800
G1 F1500
M204 S500
G1 X90.604 Y100.209 E.00683
G1 X90.504 Y100.679 E.01016
G1 X90.296 Y101.164 E.01119
G1 X90.069 Y101.511 E.00878
G1 X89.706 Y101.891 E.01112
G1 X89.378 Y102.131 E.0086
G1 X89.034 Y102.307 E.00819
G1 X88.798 Y102.397 E.00535
G1 X88.352 Y102.499 E.00968
G1 X87.882 Y102.52 E.00995
G1 X87.416 Y102.457 E.00995
G1 X86.978 Y102.315 E.00975
G1 X86.69 Y102.17 E.00683
G1 X86.416 Y101.989 E.00695
G1 X86.022 Y101.622 E.01139
G1 X85.718 Y101.19 E.01119
G1 X85.575 Y100.895 E.00693
G1 X85.471 Y100.589 E.00684
G1 X85.389 Y100.136 E.00975
G1 X85.389 Y99.666 E.00994
G1 X85.473 Y99.203 E.00995
G1 X85.64 Y98.758 E.01007
G1 X85.929 Y98.293 E.01159
G1 X86.301 Y97.904 E.01139
G1 X86.689 Y97.63 E.01005
G1 X87.107 Y97.437 E.00975
G1 X87.417 Y97.346 E.00683
G1 X87.735 Y97.293 E.00684
G1 X88.196 Y97.286 E.00975
G1 X88.65 Y97.362 E.00975
G1 X88.957 Y97.462 E.00683
G1 X89.25 Y97.597 E.00683
G1 X89.635 Y97.851 E.00975
G1 X89.972 Y98.174 E.00988
G1 X90.205 Y98.487 E.00826
G1 X90.332 Y98.705 E.00535
G1 X90.507 Y99.133 E.0098
G1 X90.612 Y99.671 E.01159
G1 X90.609 Y99.826 E.00329
M204 S250
G1 X90.199 Y99.881 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X90.195 Y100.163 E.00556
G1 X90.112 Y100.554 E.00786
G1 X89.934 Y100.97 E.0089
G1 X89.747 Y101.256 E.00671
G1 X89.435 Y101.582 E.00888
G1 X89.162 Y101.781 E.00665
G1 X88.867 Y101.933 E.00652
G1 X88.679 Y102.004 E.00396
G1 X88.297 Y102.092 E.00771
G1 X87.901 Y102.11 E.00779
G1 X87.508 Y102.056 E.0078
G1 X87.134 Y101.935 E.00773
G1 X86.895 Y101.815 E.00527
G1 X86.67 Y101.667 E.0053
G1 X86.333 Y101.352 E.00908
G1 X86.072 Y100.982 E.0089
G1 X85.955 Y100.739 E.00529
G1 X85.868 Y100.486 E.00527
G1 X85.798 Y100.099 E.00773
G1 X85.798 Y99.703 E.00779
G1 X85.869 Y99.313 E.0078
G1 X86.009 Y98.94 E.00783
G1 X86.254 Y98.545 E.00914
G1 X86.569 Y98.215 E.00897
G1 X86.895 Y97.986 E.00783
G1 X87.251 Y97.821 E.00773
G1 X87.508 Y97.746 E.00526
G1 X87.772 Y97.702 E.00527
G1 X88.165 Y97.696 E.00773
G1 X88.553 Y97.761 E.00773
G1 X88.808 Y97.843 E.00526
G1 X89.05 Y97.956 E.00526
G1 X89.378 Y98.172 E.00773
G1 X89.664 Y98.445 E.00777
G1 X89.863 Y98.713 E.00654
G1 X89.964 Y98.886 E.00396
G1 X90.113 Y99.251 E.00775
G1 X90.202 Y99.707 E.00914
G1 X90.2 Y99.821 E.00223
; WIPE_START
M204 S6000
G1 X90.195 Y100.163 E-.0651
G1 X90.112 Y100.554 E-.07596
G1 X89.934 Y100.97 E-.08599
G1 X89.747 Y101.256 E-.06479
G1 X89.435 Y101.582 E-.08579
G1 X89.425 Y101.589 E-.00238
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X86.761 Y96.119 Z3.24 F18000
G1 Z2.84
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X94.111 Y96.118 E.15558
G1 X94.406 Y96.044 E.00643
G1 X94.665 Y95.882 E.00648
G1 X94.865 Y95.654 E.00642
G1 X94.987 Y95.379 E.00635
G1 X95.019 Y95.143 E.00505
G1 X95.019 Y94.72 E.00895
G1 X95.381 Y94.72 E.00765
G1 X95.381 Y95.565 E.01788
G1 X95.353 Y95.803 E.00508
G1 X95.28 Y96.003 E.0045
G1 X95.205 Y96.125 E.00305
G1 X95.109 Y96.233 E.00305
G1 X94.938 Y96.36 E.0045
G1 X94.751 Y96.441 E.00431
G1 X94.533 Y96.479 E.0047
G1 X89.443 Y96.483 E.10774
G1 X90.544 Y97.675 E.03436
G1 X90.795 Y98 E.00869
G1 X91.005 Y98.353 E.00869
G1 X91.229 Y98.901 E.01254
G1 X91.324 Y99.291 E.00849
G1 X91.38 Y99.881 E.01254
G1 X91.357 Y100.291 E.00869
G1 X91.287 Y100.686 E.00849
G1 X91.168 Y101.079 E.00869
G1 X90.91 Y101.621 E.01273
G1 X90.558 Y102.11 E.01274
G1 X90.126 Y102.529 E.01273
G1 X89.635 Y102.859 E.01253
G1 X89.273 Y103.032 E.00849
G1 X88.884 Y103.164 E.00869
G1 X88.301 Y103.267 E.01254
G1 X87.9 Y103.279 E.00849
G1 X87.5 Y103.243 E.00849
G1 X87.107 Y103.161 E.00849
G1 X86.732 Y103.033 E.00838
G1 X86.286 Y102.811 E.01055
G1 X85.863 Y102.518 E.0109
G1 X85.571 Y102.251 E.00837
G1 X85.31 Y101.947 E.00849
G1 X85.086 Y101.613 E.0085
G1 X84.902 Y101.253 E.00856
G1 X84.713 Y100.688 E.0126
G1 X84.643 Y100.291 E.00855
G1 X84.62 Y99.89 E.00849
G1 X84.645 Y99.495 E.00838
G1 X84.743 Y99.006 E.01055
G1 X84.915 Y98.521 E.0109
G1 X85.097 Y98.17 E.00837
G1 X85.323 Y97.838 E.0085
G1 X86.503 Y96.482 E.03805
G1 X81.536 Y96.482 E.10513
G1 X81.289 Y96.453 E.00527
G1 X81.143 Y96.405 E.00324
G1 X80.979 Y96.309 E.00402
G1 X80.791 Y96.121 E.00562
G1 X80.684 Y95.928 E.00468
G1 X80.649 Y95.815 E.00249
G1 X80.619 Y95.565 E.00534
G1 X80.619 Y77.628 E.37965
G1 X80.655 Y77.357 E.00578
G1 X80.782 Y77.095 E.00617
G1 X80.975 Y76.896 E.00587
G1 X81.191 Y76.778 E.00521
G1 X81.449 Y76.723 E.00558
G1 X94.51 Y76.721 E.27645
G1 X94.658 Y76.736 E.00315
G1 X94.744 Y76.756 E.00186
G1 X94.976 Y76.861 E.00539
G1 X95.161 Y77.022 E.0052
G1 X95.286 Y77.211 E.00478
G1 X95.346 Y77.371 E.00363
G1 X95.378 Y77.565 E.00415
G1 X95.38 Y78.482 E.01941
G1 X95.019 Y78.482 E.00763
G1 X95.019 Y78.058 E.00896
G1 X94.987 Y77.822 E.00506
G1 X94.862 Y77.543 E.00645
G1 X94.642 Y77.299 E.00697
G1 X94.359 Y77.139 E.00688
G1 X94.088 Y77.082 E.00586
G1 X81.946 Y77.082 E.25699
G1 X81.657 Y77.132 E.0062
G1 X81.379 Y77.282 E.00669
G1 X81.147 Y77.529 E.00717
G1 X81.017 Y77.807 E.00649
G1 X80.981 Y78.056 E.00533
G1 X80.981 Y95.155 E.36192
G1 X81.035 Y95.462 E.00659
G1 X81.249 Y95.809 E.00864
G1 X81.591 Y96.049 E.00884
G1 X81.937 Y96.12 E.00748
G1 X86.701 Y96.119 E.10083
; WIPE_START
M204 S6000
G1 X88.701 Y96.119 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X85.604 Y96.891 Z3.24 F18000
G1 Z2.84
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X81.512 Y96.891 E.08049
G1 X81.2 Y96.854 E.00619
G1 X80.986 Y96.784 E.00442
G1 X80.855 Y96.718 E.00289
G1 X80.591 Y96.514 E.00656
G1 X80.384 Y96.247 E.00664
G1 X80.303 Y96.08 E.00366
G1 X80.247 Y95.902 E.00366
G1 X80.21 Y95.589 E.00621
G1 X80.21 Y77.61 E.35362
G1 X80.231 Y77.374 E.00466
G1 X80.264 Y77.234 E.00283
G1 X80.348 Y77.021 E.0045
G1 X80.446 Y76.859 E.00372
G1 X80.561 Y76.717 E.0036
G1 X80.73 Y76.567 E.00445
G1 X80.924 Y76.447 E.00448
G1 X81.056 Y76.39 E.00283
G1 X81.279 Y76.33 E.00454
G1 X81.425 Y76.313 E.00289
G1 X94.53 Y76.312 E.25776
G1 X94.726 Y76.331 E.00387
G1 X94.867 Y76.365 E.00286
G1 X95.081 Y76.45 E.00454
G1 X95.206 Y76.522 E.00283
G1 X95.387 Y76.665 E.00454
G1 X95.484 Y76.767 E.00277
G1 X95.652 Y77.024 E.00604
G1 X95.744 Y77.265 E.00506
G1 X95.788 Y77.531 E.00531
G1 X95.79 Y78.891 E.02675
G1 X94.61 Y78.891 E.0232
G1 X94.61 Y78.086 E.01582
G1 X94.589 Y77.935 E.003
G1 X94.515 Y77.769 E.00358
G1 X94.383 Y77.622 E.00389
G1 X94.213 Y77.527 E.00384
G1 X94.045 Y77.492 E.00337
G1 X81.982 Y77.491 E.23728
G1 X81.793 Y77.524 E.00376
G1 X81.632 Y77.611 E.00362
G1 X81.49 Y77.762 E.00406
G1 X81.413 Y77.925 E.00355
G1 X81.39 Y78.086 E.00319
G1 X81.39 Y95.119 E.33504
G1 X81.424 Y95.314 E.00388
G1 X81.553 Y95.522 E.00483
G1 X81.756 Y95.665 E.00489
G1 X81.979 Y95.711 E.00446
G1 X94.06 Y95.709 E.23764
G1 X94.243 Y95.663 E.00371
G1 X94.397 Y95.567 E.00356
G1 X94.516 Y95.431 E.00356
G1 X94.589 Y95.266 E.00355
G1 X94.61 Y95.115 E.00299
G1 X94.61 Y94.311 E.01582
G1 X95.79 Y94.311 E.02321
G1 X95.79 Y95.589 E.02513
G1 X95.754 Y95.898 E.00613
G1 X95.65 Y96.182 E.00594
G1 X95.534 Y96.371 E.00436
M73 P68 R7
G1 X95.387 Y96.536 E.00436
G1 X95.144 Y96.717 E.00594
G1 X94.87 Y96.835 E.00589
G1 X94.569 Y96.888 E.00601
G1 X90.377 Y96.891 E.08245
G1 X90.857 Y97.411 E.01392
G1 X91.134 Y97.77 E.00891
G1 X91.366 Y98.159 E.00891
G1 X91.461 Y98.356 E.00431
G1 X91.62 Y98.78 E.00891
G1 X91.727 Y99.217 E.00885
G1 X91.783 Y99.667 E.00891
G1 X91.79 Y99.886 E.0043
G1 X91.764 Y100.338 E.00891
G1 X91.686 Y100.781 E.00885
G1 X91.555 Y101.215 E.00891
G1 X91.473 Y101.417 E.0043
G1 X91.266 Y101.824 E.00897
G1 X91.149 Y102.009 E.00431
G1 X90.873 Y102.372 E.00898
G1 X90.726 Y102.534 E.0043
G1 X90.39 Y102.842 E.00897
G1 X90.216 Y102.975 E.0043
G1 X89.833 Y103.218 E.00891
G1 X89.427 Y103.412 E.00885
G1 X88.998 Y103.557 E.00892
G1 X88.785 Y103.608 E.0043
G1 X88.337 Y103.676 E.00891
G1 X87.887 Y103.689 E.00885
G1 X87.439 Y103.649 E.00885
G1 X86.999 Y103.556 E.00885
G1 X86.575 Y103.412 E.00882
G1 X86.078 Y103.164 E.01092
G1 X85.607 Y102.839 E.01126
G1 X85.277 Y102.536 E.00881
G1 X84.983 Y102.195 E.00885
G1 X84.733 Y101.821 E.00885
G1 X84.528 Y101.419 E.00887
G1 X84.411 Y101.113 E.00644
G1 X84.314 Y100.782 E.00679
G1 X84.236 Y100.338 E.00887
G1 X84.21 Y99.889 E.00885
G1 X84.238 Y99.441 E.00881
G1 X84.348 Y98.897 E.01093
G1 X84.539 Y98.357 E.01126
G1 X84.745 Y97.96 E.00881
G1 X84.998 Y97.588 E.00885
G1 X85.565 Y96.936 E.01698
; WIPE_START
M204 S6000
G1 X83.565 Y96.914 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G17
G3 Z3.24 I1.217 J0 P1  F18000
;===================== date: 20250206 =====================

; don't support timelapse gcode in spiral_mode and by object sequence for I3 structure printer
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
G92 E0
G1 Z3.24
G1 X0 Y90 ; move to safe pos
G1 X-13.0 F3000 ; move to safe pos
M400
M1004 S5 P1  ; external shutter
M400 P300
M971 S11 C11 O0
G92 E0
G1 X0 F18000
M623

; SKIPTYPE: head_wrap_detect
M622.1 S1
M1002 judge_flag g39_3rd_layer_detect_flag
M622 J1
    ; enable nozzle clog detect at 3rd layer
    


    M622.1 S1
    M1002 judge_flag g39_detection_flag
    M622 J1
      
        M622.1 S0
        M1002 judge_flag g39_mass_exceed_flag
        M622 J1
        
            G392 S0
            M400
            G90
            M83
            M204 S5000
            G0 Z3.24 F4000
            G39.3 S1
            G0 Z3.24 F4000
            G392 S0
          
        M623
    
    M623
M623
; SKIPPABLE_END




G1 X81.456 Y96.238
G1 Z2.84
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.096265
G1 F1500
M204 S6000
G1 X81.354 Y96.193 E.00039
; LINE_WIDTH: 0.149404
G1 X81.251 Y96.148 E.00069
G1 X81.074 Y96.025 E.00133
G1 X80.94 Y95.828 E.00147
; LINE_WIDTH: 0.1301
G1 X80.9 Y95.726 E.00057
; LINE_WIDTH: 0.0952245
G1 X80.861 Y95.624 E.00038
; WIPE_START
G1 X80.9 Y95.726 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X86.536 Y97.161 Z3.24 F18000
G1 Z2.84
G1 E.4 F1800
; LINE_WIDTH: 0.463495
G1 F1500
M204 S6000
G1 X86.297 Y97.378 E.00705
; LINE_WIDTH: 0.413719
G1 X86.057 Y97.594 E.00625
; LINE_WIDTH: 0.361692
G1 X85.623 Y98.069 E.01079
G1 X85.429 Y98.368 E.00597
G1 X85.265 Y98.673 E.0058
G1 X85.108 Y99.107 E.00774
G1 X85.015 Y99.618 E.0087
G1 X85.012 Y100.155 E.00901
G1 X85.085 Y100.601 E.00758
G1 X85.161 Y100.861 E.00453
G1 X85.251 Y101.098 E.00425
G1 X85.385 Y101.369 E.00508
G1 X85.616 Y101.713 E.00695
G1 X85.847 Y101.984 E.00596
G1 X86.172 Y102.276 E.00733
G1 X86.492 Y102.492 E.00647
G1 X86.879 Y102.682 E.00721
G1 X87.347 Y102.827 E.00822
G1 X87.911 Y102.899 E.00953
G1 X88.417 Y102.87 E.00849
G1 X88.895 Y102.758 E.00823
G1 X89.179 Y102.657 E.00506
G1 X89.587 Y102.444 E.0077
G1 X89.962 Y102.162 E.00787
G1 X90.16 Y101.974 E.00457
G1 X90.352 Y101.755 E.00488
G1 X90.576 Y101.434 E.00656
G1 X90.807 Y100.946 E.00906
G1 X90.914 Y100.597 E.00612
G1 X90.978 Y100.267 E.00562
G1 X90.994 Y99.882 E.00647
G1 X90.982 Y99.621 E.00437
G1 X90.944 Y99.359 E.00445
G1 X90.867 Y99.013 E.00593
G1 X90.673 Y98.549 E.00843
G1 X90.477 Y98.214 E.00651
G1 X90.254 Y97.92 E.00618
G1 X89.869 Y97.53 E.00918
; LINE_WIDTH: 0.419993
G1 X89.628 Y97.325 E.00623
; LINE_WIDTH: 0.468032
G1 X89.386 Y97.12 E.00699
; WIPE_START
G1 X89.628 Y97.325 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X94.531 Y96.242 Z3.24 F18000
G1 Z2.84
G1 E.4 F1800
; LINE_WIDTH: 0.104154
G1 F1500
M204 S6000
G1 X94.675 Y96.186 E.00061
; LINE_WIDTH: 0.148502
G1 X94.8 Y96.121 E.00086
G1 X94.915 Y96.026 E.00091
G1 X95.08 Y95.799 E.00172
; LINE_WIDTH: 0.101076
G1 X95.138 Y95.618 E.00072
; WIPE_START
G1 X95.08 Y95.799 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X95.107 Y88.167 Z3.24 F18000
G1 X95.145 Y77.598 Z3.24
G1 Z2.84
G1 E.4 F1800
; LINE_WIDTH: 0.102074
G1 F1500
M204 S6000
G1 X95.078 Y77.394 E.00082
; LINE_WIDTH: 0.133344
G1 X95.042 Y77.336 E.00037
; LINE_WIDTH: 0.155926
G1 X94.94 Y77.204 E.00108
G1 X94.781 Y77.064 E.00138
; LINE_WIDTH: 0.130032
G1 X94.513 Y76.943 E.00153
; WIPE_START
G1 X94.781 Y77.064 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X87.149 Y77.002 Z3.24 F18000
G1 X81.496 Y76.955 Z3.24
G1 Z2.84
G1 E.4 F1800
; LINE_WIDTH: 0.0812106
G1 F1500
M204 S6000
G1 X81.464 Y76.963 E.00009
; LINE_WIDTH: 0.0963032
G1 X81.373 Y76.997 E.00034
; LINE_WIDTH: 0.129681
G1 X81.207 Y77.073 E.00094
; LINE_WIDTH: 0.156377
G1 X81.067 Y77.197 E.00122
G1 X80.925 Y77.387 E.00155
; LINE_WIDTH: 0.10517
G1 X80.857 Y77.595 E.00086
; WIPE_START
G1 X80.925 Y77.387 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X88.306 Y79.327 Z3.24 F18000
G1 X96.743 Y81.544 Z3.24
G1 Z2.84
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X97.257 Y81.544 E.01086
G1 X97.257 Y82.057 E.01086
G1 X96.743 Y82.057 E.01086
G1 X96.743 Y81.604 E.00959
M204 S10000
G1 X96.319 Y81.12 F18000
G1 F1500
M204 S500
G1 X97.681 Y81.12 E.02882
G1 X97.681 Y82.482 E.02882
G1 X96.319 Y82.482 E.02882
G1 X96.319 Y81.18 E.02755
M204 S250
G1 X95.91 Y80.711 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X98.09 Y80.711 E.04288
G1 X98.09 Y82.891 E.04288
G1 X95.91 Y82.891 E.04288
G1 X95.91 Y80.771 E.0417
; CHANGE_LAYER
; Z_HEIGHT: 2.96
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F1500
M204 S6000
G1 X97.909 Y80.716 E-.38
; WIPE_END
G1 E-.02 F1800
; layer num/total_layer_count: 24/49
; update layer progress
M73 L24
M991 S0 P23 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z3.24 I-1.073 J-.574 P1  F18000
G1 X89.155 Y97.093 Z3.24
G1 Z2.96
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X88.942 Y97.002 E.00491
G1 X88.415 Y96.882 E.01143
G1 X87.974 Y96.857 E.00937
G1 X87.677 Y96.873 E.00629
G1 X87.322 Y96.932 E.00761
G1 X86.958 Y97.038 E.00804
G1 X86.774 Y97.124 E.00429
G1 X86.65 Y96.959 E.00436
G1 X87.011 Y96.544 E.01165
G1 X88.921 Y96.543 E.04041
G1 X89.274 Y96.925 E.011
G1 X89.19 Y97.044 E.00309
; WIPE_START
M204 S6000
G1 X88.942 Y97.002 E-.04775
G1 X88.415 Y96.882 E-.10258
G1 X87.974 Y96.857 E-.08408
G1 X87.677 Y96.873 E-.05646
G1 X87.322 Y96.932 E-.06831
G1 X87.217 Y96.963 E-.02083
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X90.61 Y99.872 Z3.36 F18000
G1 Z2.96
G1 E.4 F1800
G1 F1500
M204 S500
G1 X90.61 Y100.142 E.00573
G1 X90.507 Y100.669 E.01136
G1 X90.327 Y101.109 E.01006
G1 X90.071 Y101.509 E.01006
G1 X89.704 Y101.892 E.01124
G1 X89.378 Y102.131 E.00854
G1 X89.036 Y102.306 E.00813
G1 X88.798 Y102.397 E.0054
G1 X88.361 Y102.497 E.00949
G1 X88.039 Y102.521 E.00683
G1 X87.717 Y102.506 E.00683
G1 X87.265 Y102.417 E.00975
G1 X86.827 Y102.246 E.00995
G1 X86.427 Y101.999 E.00995
G1 X86.085 Y101.69 E.00975
G1 X85.88 Y101.441 E.00683
G1 X85.703 Y101.165 E.00695
G1 X85.498 Y100.68 E.01113
G1 X85.406 Y100.282 E.00864
G1 X85.384 Y99.751 E.01125
G1 X85.436 Y99.356 E.00845
G1 X85.545 Y98.988 E.00812
G1 X85.644 Y98.753 E.0054
G1 X85.874 Y98.368 E.00949
G1 X86.079 Y98.119 E.00683
G1 X86.312 Y97.896 E.00683
G1 X86.689 Y97.63 E.00975
G1 X87.107 Y97.437 E.00975
G1 X87.417 Y97.346 E.00683
G1 X87.723 Y97.295 E.00658
G1 X87.973 Y97.282 E.00529
G1 X88.356 Y97.304 E.00811
G1 X88.81 Y97.407 E.00987
G1 X89.247 Y97.594 E.01006
G1 X89.697 Y97.903 E.01154
G1 X90.071 Y98.293 E.01145
G1 X90.33 Y98.698 E.01017
G1 X90.526 Y99.202 E.01145
G1 X90.611 Y99.669 E.01003
G1 X90.61 Y99.812 E.00303
M204 S250
G1 X90.201 Y99.871 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X90.201 Y100.102 E.00455
G1 X90.113 Y100.551 E.00899
G1 X89.962 Y100.919 E.00783
G1 X89.748 Y101.255 E.00783
G1 X89.433 Y101.583 E.00895
G1 X89.162 Y101.781 E.0066
G1 X88.87 Y101.932 E.00647
G1 X88.679 Y102.004 E.00401
G1 X88.3 Y102.091 E.00765
G1 X88.033 Y102.111 E.00526
G1 X87.766 Y102.099 E.00526
G1 X87.38 Y102.023 E.00774
G1 X87.011 Y101.878 E.0078
G1 X86.674 Y101.67 E.0078
G1 X86.382 Y101.407 E.00773
G1 X86.212 Y101.2 E.00526
G1 X86.067 Y100.973 E.0053
G1 X85.889 Y100.553 E.00897
G1 X85.813 Y100.227 E.00658
G1 X85.794 Y99.77 E.00901
G1 X85.838 Y99.441 E.00652
G1 X85.931 Y99.126 E.00647
G1 X86.01 Y98.938 E.00401
G1 X86.21 Y98.604 E.00765
G1 X86.38 Y98.398 E.00526
G1 X86.573 Y98.212 E.00527
G1 X86.895 Y97.986 E.00773
G1 X87.251 Y97.821 E.00773
G1 X87.508 Y97.746 E.00526
G1 X87.768 Y97.703 E.00518
G1 X87.972 Y97.692 E.00402
G1 X88.298 Y97.71 E.00641
G1 X88.683 Y97.798 E.00777
G1 X89.049 Y97.955 E.00783
G1 X89.431 Y98.216 E.0091
G1 X89.748 Y98.547 E.00902
G1 X89.963 Y98.884 E.00787
G1 X90.131 Y99.314 E.00907
G1 X90.201 Y99.705 E.00782
G1 X90.201 Y99.811 E.00209
; WIPE_START
M204 S6000
G1 X90.201 Y100.102 E-.05536
G1 X90.113 Y100.551 E-.0868
G1 X89.962 Y100.919 E-.07566
G1 X89.748 Y101.255 E-.07563
G1 X89.433 Y101.583 E-.08647
G1 X89.433 Y101.583 E-.00009
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X86.761 Y96.119 Z3.36 F18000
G1 Z2.96
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X94.112 Y96.118 E.15559
G1 X94.406 Y96.044 E.00641
G1 X94.665 Y95.882 E.00647
G1 X94.864 Y95.654 E.00642
G1 X94.987 Y95.379 E.00638
G1 X95.019 Y95.143 E.00503
G1 X95.019 Y94.72 E.00895
G1 X95.381 Y94.72 E.00765
G1 X95.381 Y95.583 E.01826
G1 X95.351 Y95.818 E.00502
G1 X95.282 Y96 E.00411
G1 X95.207 Y96.121 E.00303
G1 X95.084 Y96.255 E.00385
G1 X94.942 Y96.359 E.00372
G1 X94.751 Y96.441 E.00439
G1 X94.533 Y96.479 E.0047
G1 X89.442 Y96.483 E.10775
G1 X90.544 Y97.675 E.03437
G1 X90.796 Y98.003 E.00875
G1 X91.086 Y98.523 E.01261
G1 X91.229 Y98.901 E.00856
G1 X91.324 Y99.291 E.00849
G1 X91.374 Y99.699 E.00869
G1 X91.357 Y100.293 E.0126
G1 X91.236 Y100.876 E.0126
G1 X91.096 Y101.256 E.00856
G1 X90.91 Y101.621 E.00869
G1 X90.558 Y102.11 E.01274
G1 X90.439 Y102.241 E.00374
G1 X90.05 Y102.585 E.011
G1 X89.63 Y102.861 E.01064
G1 X89.273 Y103.032 E.00838
G1 X88.884 Y103.164 E.00869
G1 X88.301 Y103.267 E.01254
G1 X87.9 Y103.279 E.00849
G1 X87.5 Y103.243 E.00849
G1 X87.107 Y103.161 E.00849
G1 X86.727 Y103.032 E.0085
G1 X86.37 Y102.861 E.00837
G1 X85.944 Y102.58 E.01081
G1 X85.568 Y102.247 E.01065
G1 X85.31 Y101.947 E.00838
G1 X85.086 Y101.613 E.0085
G1 X84.906 Y101.261 E.00837
G1 X84.739 Y100.779 E.0108
G1 X84.643 Y100.285 E.01064
G1 X84.62 Y99.89 E.00838
G1 X84.645 Y99.49 E.00849
G1 X84.718 Y99.095 E.0085
G1 X84.835 Y98.717 E.00837
G1 X85.051 Y98.254 E.01081
G1 X85.327 Y97.834 E.01064
G1 X86.503 Y96.482 E.03793
G1 X81.536 Y96.482 E.10513
G1 X81.298 Y96.454 E.00508
G1 X81.098 Y96.381 E.0045
G1 X80.968 Y96.301 E.00324
G1 X80.832 Y96.173 E.00394
G1 X80.739 Y96.04 E.00343
G1 X80.649 Y95.821 E.00501
G1 X80.619 Y95.565 E.00546
G1 X80.619 Y77.619 E.37984
G1 X80.659 Y77.346 E.00585
G1 X80.764 Y77.121 E.00524
G1 X80.956 Y76.911 E.00603
G1 X81.208 Y76.772 E.00609
G1 X81.458 Y76.723 E.0054
G1 X94.512 Y76.721 E.27629
G1 X94.658 Y76.736 E.00311
G1 X94.87 Y76.804 E.00472
G1 X94.988 Y76.869 E.00284
G1 X95.156 Y77.016 E.00472
G1 X95.279 Y77.194 E.00458
G1 X95.347 Y77.373 E.00405
G1 X95.378 Y77.565 E.00411
G1 X95.38 Y78.482 E.01941
G1 X95.019 Y78.482 E.00763
G1 X95.019 Y78.057 E.009
G1 X94.984 Y77.812 E.00523
G1 X94.86 Y77.541 E.00631
G1 X94.641 Y77.298 E.00691
G1 X94.359 Y77.139 E.00687
G1 X94.088 Y77.082 E.00586
G1 X81.946 Y77.082 E.25699
G1 X81.657 Y77.132 E.0062
G1 X81.387 Y77.278 E.00649
G1 X81.171 Y77.495 E.00649
G1 X81.019 Y77.797 E.00717
G1 X80.981 Y78.056 E.00553
G1 X80.981 Y95.155 E.36192
G1 X81.035 Y95.462 E.0066
G1 X81.249 Y95.809 E.00864
G1 X81.591 Y96.049 E.00884
G1 X81.937 Y96.12 E.00747
G1 X86.701 Y96.119 E.10084
; WIPE_START
M204 S6000
G1 X88.701 Y96.119 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X85.605 Y96.891 Z3.36 F18000
G1 Z2.96
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X81.512 Y96.891 E.08049
G1 X81.203 Y96.855 E.00613
G1 X80.919 Y96.751 E.00594
G1 X80.728 Y96.633 E.00442
G1 X80.615 Y96.539 E.00289
G1 X80.514 Y96.432 E.00289
G1 X80.384 Y96.246 E.00448
G1 X80.287 Y96.039 E.00448
G1 X80.247 Y95.904 E.00277
G1 X80.21 Y95.589 E.00625
G1 X80.21 Y77.607 E.35368
G1 X80.219 Y77.454 E.00301
G1 X80.265 Y77.23 E.0045
G1 X80.332 Y77.055 E.00369
G1 X80.422 Y76.894 E.00363
G1 X80.563 Y76.715 E.00447
G1 X80.702 Y76.589 E.00369
G1 X80.854 Y76.485 E.00363
G1 X81.062 Y76.388 E.00451
G1 X81.2 Y76.347 E.00283
G1 X81.428 Y76.313 E.00454
G1 X94.532 Y76.312 E.25774
G1 X94.726 Y76.331 E.00383
G1 X95.043 Y76.432 E.00656
G1 X95.21 Y76.524 E.00375
G1 X95.462 Y76.743 E.00656
G1 X95.65 Y77.018 E.00655
G1 X95.744 Y77.266 E.00522
G1 X95.788 Y77.531 E.00528
G1 X95.79 Y78.891 E.02675
G1 X94.61 Y78.891 E.0232
G1 X94.61 Y78.086 E.01583
G1 X94.587 Y77.929 E.00312
G1 X94.514 Y77.768 E.00347
G1 X94.382 Y77.622 E.00387
M73 P69 R7
G1 X94.213 Y77.527 E.00383
G1 X94.045 Y77.492 E.00337
G1 X81.982 Y77.491 E.23728
G1 X81.793 Y77.524 E.00376
G1 X81.634 Y77.61 E.00356
G1 X81.507 Y77.737 E.00355
G1 X81.414 Y77.922 E.00407
G1 X81.39 Y78.086 E.00325
G1 X81.39 Y95.119 E.33504
G1 X81.424 Y95.314 E.00389
G1 X81.553 Y95.522 E.00482
G1 X81.757 Y95.665 E.00489
G1 X81.979 Y95.711 E.00446
G1 X94.061 Y95.709 E.23765
G1 X94.243 Y95.663 E.0037
G1 X94.397 Y95.567 E.00356
G1 X94.516 Y95.431 E.00356
G1 X94.59 Y95.265 E.00357
G1 X94.61 Y95.115 E.00298
G1 X94.61 Y94.311 E.01582
G1 X95.79 Y94.311 E.02321
G1 X95.79 Y95.595 E.02525
G1 X95.746 Y95.93 E.00665
G1 X95.651 Y96.181 E.00528
G1 X95.535 Y96.369 E.00435
G1 X95.357 Y96.562 E.00516
G1 X95.145 Y96.716 E.00515
G1 X94.87 Y96.835 E.00591
G1 X94.569 Y96.888 E.00601
G1 X90.377 Y96.891 E.08245
G1 X90.857 Y97.411 E.01392
G1 X91.134 Y97.771 E.00893
G1 X91.311 Y98.061 E.0067
G1 X91.461 Y98.358 E.00654
G1 X91.62 Y98.78 E.00887
G1 X91.727 Y99.217 E.00885
G1 X91.783 Y99.667 E.00891
G1 X91.79 Y99.886 E.0043
G1 X91.764 Y100.339 E.00893
G1 X91.708 Y100.675 E.00669
G1 X91.628 Y100.997 E.00654
G1 X91.472 Y101.42 E.00887
G1 X91.266 Y101.824 E.00891
G1 X91.149 Y102.009 E.00431
G1 X90.873 Y102.372 E.00897
G1 X90.727 Y102.533 E.00426
G1 X90.299 Y102.911 E.01123
G1 X89.831 Y103.218 E.01102
G1 X89.427 Y103.412 E.00882
G1 X88.998 Y103.557 E.00891
G1 X88.785 Y103.608 E.0043
G1 X88.337 Y103.676 E.00891
G1 X87.887 Y103.689 E.00885
G1 X87.439 Y103.649 E.00885
G1 X86.999 Y103.556 E.00885
G1 X86.573 Y103.412 E.00885
G1 X86.169 Y103.219 E.00881
G1 X85.695 Y102.906 E.01117
G1 X85.275 Y102.535 E.01102
G1 X84.983 Y102.195 E.00881
G1 X84.733 Y101.821 E.00885
G1 X84.529 Y101.422 E.00881
G1 X84.343 Y100.886 E.01117
G1 X84.236 Y100.336 E.01101
G1 X84.21 Y99.889 E.00882
G1 X84.239 Y99.44 E.00885
G1 X84.32 Y98.997 E.00885
G1 X84.452 Y98.569 E.00881
G1 X84.693 Y98.055 E.01117
G1 X85 Y97.586 E.01101
G1 X85.565 Y96.936 E.01695
; WIPE_START
M204 S6000
G1 X83.565 Y96.914 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G17
G3 Z3.36 I1.217 J0 P1  F18000
;===================== date: 20250206 =====================

; don't support timelapse gcode in spiral_mode and by object sequence for I3 structure printer
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
G92 E0
G1 Z3.36
G1 X0 Y90 ; move to safe pos
G1 X-13.0 F3000 ; move to safe pos
M400
M1004 S5 P1  ; external shutter
M400 P300
M971 S11 C11 O0
G92 E0
G1 X0 F18000
M623

; SKIPTYPE: head_wrap_detect
M622.1 S1
M1002 judge_flag g39_3rd_layer_detect_flag
M622 J1
    ; enable nozzle clog detect at 3rd layer
    


    M622.1 S1
    M1002 judge_flag g39_detection_flag
    M622 J1
      
        M622.1 S0
        M1002 judge_flag g39_mass_exceed_flag
        M622 J1
        
            G392 S0
            M400
            G90
            M83
            M204 S5000
            G0 Z3.36 F4000
            G39.3 S1
            G0 Z3.36 F4000
            G392 S0
          
        M623
    
    M623
M623
; SKIPPABLE_END




G1 X81.452 Y96.25
G1 Z2.96
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.147741
G1 F1500
M204 S6000
G1 X81.222 Y96.13 E.00158
G1 X81.057 Y96.007 E.00125
G1 X80.843 Y95.647 E.00255
; WIPE_START
G1 X81.057 Y96.007 E-.18018
G1 X81.222 Y96.13 E-.08826
G1 X81.452 Y96.25 E-.11156
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X86.537 Y97.161 Z3.36 F18000
G1 Z2.96
G1 E.4 F1800
; LINE_WIDTH: 0.464641
G1 F1500
M204 S6000
G1 X86.304 Y97.371 E.00686
; LINE_WIDTH: 0.417179
G1 X86.071 Y97.581 E.00612
; LINE_WIDTH: 0.360921
G1 X85.631 Y98.064 E.01093
G1 X85.386 Y98.441 E.00752
G1 X85.19 Y98.854 E.00764
G1 X85.089 Y99.186 E.0058
G1 X85.026 Y99.536 E.00595
G1 X85.005 Y99.891 E.00594
G1 X85.032 Y100.318 E.00715
G1 X85.146 Y100.81 E.00844
G1 X85.364 Y101.328 E.0094
G1 X85.58 Y101.671 E.00679
G1 X85.839 Y101.98 E.00673
G1 X86.19 Y102.291 E.00784
G1 X86.646 Y102.576 E.00899
G1 X87.145 Y102.775 E.00899
G1 X87.66 Y102.879 E.00878
G1 X88.035 Y102.898 E.00628
G1 X88.405 Y102.871 E.0062
G1 X88.628 Y102.83 E.00379
G1 X89.131 Y102.678 E.00879
G1 X89.442 Y102.528 E.00577
G1 X89.818 Y102.281 E.00752
G1 X90.164 Y101.969 E.0078
G1 X90.494 Y101.56 E.00879
G1 X90.665 Y101.268 E.00566
G1 X90.865 Y100.793 E.00862
G1 X90.977 Y100.251 E.00925
G1 X90.995 Y99.882 E.00619
G1 X90.981 Y99.621 E.00436
G1 X90.885 Y99.084 E.00912
G1 X90.735 Y98.681 E.0072
G1 X90.478 Y98.217 E.00887
G1 X90.25 Y97.924 E.00621
G1 X89.936 Y97.593 E.00763
; LINE_WIDTH: 0.400921
G1 X89.755 Y97.436 E.00447
; LINE_WIDTH: 0.436934
G1 X89.574 Y97.28 E.0049
; LINE_WIDTH: 0.472947
G1 X89.393 Y97.124 E.00533
; WIPE_START
G1 X89.574 Y97.28 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X94.53 Y96.242 Z3.36 F18000
G1 Z2.96
G1 E.4 F1800
; LINE_WIDTH: 0.104164
G1 F1500
M204 S6000
G1 X94.675 Y96.186 E.00061
; LINE_WIDTH: 0.148125
G1 X94.805 Y96.118 E.00089
G1 X94.894 Y96.046 E.0007
G1 X95.081 Y95.8 E.00188
; LINE_WIDTH: 0.101319
G1 X95.145 Y95.6 E.0008
; WIPE_START
G1 X95.081 Y95.8 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X95.108 Y88.168 Z3.36 F18000
G1 X95.145 Y77.597 Z3.36
G1 Z2.96
G1 E.4 F1800
; LINE_WIDTH: 0.102939
G1 F1500
M204 S6000
G1 X95.075 Y77.391 E.00084
; LINE_WIDTH: 0.155125
G1 X94.942 Y77.206 E.00147
G1 X94.835 Y77.101 E.00097
G1 X94.757 Y77.052 E.0006
; LINE_WIDTH: 0.129302
G1 X94.513 Y76.944 E.00138
; WIPE_START
G1 X94.757 Y77.052 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X87.124 Y76.996 Z3.36 F18000
G1 X81.494 Y76.954 Z3.36
G1 Z2.96
G1 E.4 F1800
; LINE_WIDTH: 0.0926155
G1 F1500
M204 S6000
G1 X81.397 Y76.988 E.00034
; LINE_WIDTH: 0.130577
G1 X81.196 Y77.081 E.00116
; LINE_WIDTH: 0.152144
G1 X81.072 Y77.191 E.00104
G1 X80.947 Y77.344 E.00125
G1 X80.914 Y77.419 E.00052
; LINE_WIDTH: 0.116071
G1 X80.884 Y77.512 E.00044
; LINE_WIDTH: 0.0900556
G1 X80.854 Y77.604 E.00031
; WIPE_START
G1 X80.884 Y77.512 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X88.281 Y79.392 Z3.36 F18000
G1 X96.743 Y81.544 Z3.36
G1 Z2.96
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X97.257 Y81.544 E.01086
G1 X97.257 Y82.057 E.01086
G1 X96.743 Y82.057 E.01086
G1 X96.743 Y81.604 E.00959
M204 S10000
G1 X96.319 Y81.12 F18000
G1 F1500
M204 S500
G1 X97.681 Y81.12 E.02882
G1 X97.681 Y82.482 E.02882
G1 X96.319 Y82.482 E.02882
G1 X96.319 Y81.18 E.02755
M204 S250
G1 X95.91 Y80.711 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X98.09 Y80.711 E.04288
G1 X98.09 Y82.891 E.04288
G1 X95.91 Y82.891 E.04288
G1 X95.91 Y80.771 E.0417
; CHANGE_LAYER
; Z_HEIGHT: 3.08
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F1500
M204 S6000
G1 X97.909 Y80.716 E-.38
; WIPE_END
G1 E-.02 F1800
; layer num/total_layer_count: 25/49
; update layer progress
M73 L25
M991 S0 P24 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z3.36 I-1.075 J-.57 P1  F18000
G1 X89.22 Y97.116 Z3.36
G1 Z3.08
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X88.751 Y96.949 E.01052
G1 X88.228 Y96.862 E.01123
G1 X87.697 Y96.87 E.01123
G1 X87.322 Y96.932 E.00805
G1 X86.958 Y97.038 E.00804
G1 X86.773 Y97.124 E.0043
G1 X86.65 Y96.959 E.00436
G1 X87.011 Y96.544 E.01166
G1 X88.989 Y96.543 E.04186
G1 X89.343 Y96.951 E.01144
G1 X89.256 Y97.068 E.00309
; WIPE_START
M204 S6000
G1 X88.751 Y96.949 E-.09847
G1 X88.228 Y96.862 E-.10081
G1 X87.697 Y96.87 E-.10083
G1 X87.322 Y96.932 E-.07223
G1 X87.283 Y96.943 E-.00766
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X90.608 Y99.886 Z3.48 F18000
G1 Z3.08
G1 E.4 F1800
G1 F1500
M204 S500
G1 X90.604 Y100.209 E.00683
G1 X90.504 Y100.679 E.01017
G1 X90.291 Y101.174 E.01142
G1 X90.025 Y101.565 E.01001
G1 X89.692 Y101.903 E.01005
G1 X89.247 Y102.207 E.01139
G1 X88.819 Y102.391 E.00987
G1 X88.506 Y102.472 E.00683
G1 X88.187 Y102.515 E.00683
G1 X87.726 Y102.508 E.00975
G1 X87.265 Y102.417 E.00995
G1 X86.836 Y102.249 E.00975
G1 X86.556 Y102.088 E.00683
G1 X86.301 Y101.896 E.00675
G1 X86.02 Y101.618 E.00837
G1 X85.712 Y101.182 E.0113
G1 X85.517 Y100.743 E.01017
G1 X85.398 Y100.218 E.01139
G1 X85.384 Y99.741 E.01011
G1 X85.471 Y99.208 E.01142
G1 X85.64 Y98.758 E.01017
G1 X85.926 Y98.298 E.01148
G1 X86.3 Y97.904 E.0115
G1 X86.689 Y97.63 E.01006
G1 X87.107 Y97.437 E.00975
G1 X87.417 Y97.346 E.00683
G1 X87.735 Y97.293 E.00684
G1 X88.196 Y97.286 E.00975
G1 X88.65 Y97.362 E.00975
G1 X88.957 Y97.462 E.00683
G1 X89.25 Y97.597 E.00683
G1 X89.635 Y97.851 E.00975
G1 X89.974 Y98.176 E.00995
G1 X90.243 Y98.546 E.00968
G1 X90.364 Y98.773 E.00544
G1 X90.508 Y99.137 E.00828
G1 X90.611 Y99.665 E.0114
G1 X90.609 Y99.826 E.0034
M204 S250
G1 X90.199 Y99.881 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X90.195 Y100.163 E.00555
G1 X90.112 Y100.554 E.00787
G1 X89.931 Y100.976 E.00904
G1 X89.707 Y101.304 E.0078
G1 X89.428 Y101.588 E.00784
G1 X89.049 Y101.847 E.00902
G1 X88.686 Y102.002 E.00777
G1 X88.427 Y102.07 E.00526
G1 X88.162 Y102.106 E.00526
G1 X87.769 Y102.1 E.00773
G1 X87.38 Y102.023 E.0078
G1 X87.014 Y101.879 E.00773
G1 X86.782 Y101.746 E.00526
G1 X86.569 Y101.586 E.00524
G1 X86.334 Y101.353 E.00652
G1 X86.07 Y100.979 E.009
G1 X85.907 Y100.614 E.00787
G1 X85.806 Y100.167 E.00902
G1 X85.794 Y99.768 E.00785
G1 X85.868 Y99.314 E.00904
G1 X86.009 Y98.94 E.00787
G1 X86.251 Y98.549 E.00905
G1 X86.569 Y98.215 E.00906
G1 X86.895 Y97.986 E.00783
G1 X87.251 Y97.821 E.00773
G1 X87.508 Y97.746 E.00526
G1 X87.772 Y97.702 E.00527
G1 X88.165 Y97.696 E.00773
G1 X88.553 Y97.761 E.00773
G1 X88.808 Y97.843 E.00526
G1 X89.05 Y97.956 E.00526
G1 X89.378 Y98.172 E.00773
G1 X89.665 Y98.446 E.0078
G1 X89.895 Y98.763 E.00771
G1 X89.992 Y98.945 E.00404
G1 X90.114 Y99.252 E.0065
G1 X90.201 Y99.702 E.00902
G1 X90.2 Y99.821 E.00233
; WIPE_START
M204 S6000
G1 X90.195 Y100.163 E-.06502
G1 X90.112 Y100.554 E-.07599
G1 X89.931 Y100.976 E-.0873
G1 X89.707 Y101.304 E-.07538
G1 X89.428 Y101.588 E-.07569
G1 X89.425 Y101.59 E-.00063
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X86.761 Y96.119 Z3.48 F18000
G1 Z3.08
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X94.112 Y96.118 E.15561
G1 X94.405 Y96.044 E.0064
G1 X94.665 Y95.882 E.00647
G1 X94.864 Y95.654 E.00642
G1 X94.987 Y95.378 E.00639
G1 X95.019 Y95.143 E.00503
G1 X95.019 Y94.72 E.00895
G1 X95.381 Y94.72 E.00765
G1 X95.381 Y95.565 E.01788
G1 X95.353 Y95.803 E.00508
G1 X95.28 Y96.003 E.0045
G1 X95.205 Y96.125 E.00305
G1 X95.109 Y96.233 E.00305
G1 X94.938 Y96.36 E.0045
G1 X94.751 Y96.441 E.00431
G1 X94.533 Y96.479 E.0047
G1 X89.498 Y96.483 E.10657
G1 X90.677 Y97.838 E.03802
G1 X90.996 Y98.336 E.01253
G1 X91.167 Y98.72 E.00889
G1 X91.326 Y99.3 E.01273
G1 X91.38 Y99.89 E.01254
G1 X91.357 Y100.294 E.00856
G1 X91.236 Y100.877 E.0126
G1 X91.096 Y101.256 E.00856
G1 X90.91 Y101.621 E.00869
G1 X90.558 Y102.11 E.01274
G1 X90.126 Y102.528 E.01273
G1 X89.635 Y102.859 E.01254
G1 X89.272 Y103.032 E.0085
G1 X88.884 Y103.164 E.00868
G1 X88.301 Y103.267 E.01254
G1 X87.9 Y103.279 E.00849
G1 X87.5 Y103.243 E.00849
G1 X87.107 Y103.161 E.00849
G1 X86.727 Y103.032 E.0085
G1 X86.365 Y102.859 E.00849
G1 X86.026 Y102.644 E.0085
G1 X85.708 Y102.385 E.00869
G1 X85.31 Y101.947 E.01254
G1 X85.086 Y101.613 E.00849
G1 X84.906 Y101.261 E.00838
G1 X84.74 Y100.783 E.0107
G1 X84.643 Y100.285 E.01074
G1 X84.62 Y99.89 E.00838
G1 X84.645 Y99.49 E.00849
G1 X84.718 Y99.095 E.0085
G1 X84.837 Y98.711 E.00849
G1 X85 Y98.345 E.00849
G1 X85.317 Y97.845 E.01254
M73 P70 R7
G1 X86.503 Y96.482 E.03824
G1 X81.536 Y96.482 E.10512
G1 X81.208 Y96.43 E.00704
G1 X80.979 Y96.31 E.00547
G1 X80.791 Y96.122 E.00562
G1 X80.683 Y95.925 E.00475
G1 X80.649 Y95.816 E.00243
G1 X80.619 Y95.565 E.00535
G1 X80.619 Y77.619 E.37984
G1 X80.659 Y77.349 E.00577
G1 X80.715 Y77.207 E.00324
G1 X80.797 Y77.073 E.00332
G1 X80.979 Y76.892 E.00543
G1 X81.203 Y76.774 E.00536
G1 X81.454 Y76.723 E.00543
G1 X94.513 Y76.721 E.2764
G1 X94.658 Y76.736 E.00308
G1 X94.744 Y76.756 E.00186
G1 X94.968 Y76.857 E.0052
G1 X95.145 Y77.005 E.00489
G1 X95.277 Y77.19 E.00482
G1 X95.356 Y77.407 E.00488
G1 X95.378 Y77.559 E.00325
G1 X95.38 Y78.482 E.01952
G1 X95.019 Y78.482 E.00763
G1 X95.019 Y78.057 E.009
G1 X94.984 Y77.812 E.00523
G1 X94.861 Y77.541 E.0063
G1 X94.643 Y77.3 E.00689
G1 X94.359 Y77.139 E.0069
G1 X94.087 Y77.082 E.00587
G1 X81.955 Y77.082 E.25679
G1 X81.697 Y77.119 E.00553
G1 X81.394 Y77.272 E.00717
G1 X81.171 Y77.495 E.00668
G1 X81.019 Y77.798 E.00717
G1 X80.981 Y78.056 E.00552
G1 X80.981 Y95.155 E.36192
G1 X81.035 Y95.462 E.0066
G1 X81.249 Y95.809 E.00864
G1 X81.591 Y96.049 E.00883
G1 X81.937 Y96.12 E.00747
G1 X86.701 Y96.119 E.10083
; WIPE_START
M204 S6000
G1 X88.701 Y96.119 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X85.604 Y96.891 Z3.48 F18000
G1 Z3.08
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X81.512 Y96.891 E.08049
G1 X81.197 Y96.854 E.00625
G1 X81.062 Y96.814 E.00277
G1 X80.853 Y96.716 E.00454
G1 X80.588 Y96.512 E.00656
G1 X80.384 Y96.247 E.00658
G1 X80.302 Y96.076 E.00373
G1 X80.247 Y95.902 E.00359
G1 X80.21 Y95.589 E.00621
G1 X80.21 Y77.607 E.35368
G1 X80.219 Y77.454 E.00301
G1 X80.265 Y77.231 E.00448
G1 X80.348 Y77.022 E.00442
G1 X80.467 Y76.83 E.00444
G1 X80.589 Y76.689 E.00367
G1 X80.731 Y76.565 E.00372
G1 X80.853 Y76.486 E.00285
G1 X81.06 Y76.389 E.0045
G1 X81.239 Y76.339 E.00366
G1 X81.427 Y76.313 E.00373
G1 X94.533 Y76.312 E.2578
G1 X94.726 Y76.331 E.0038
G1 X94.867 Y76.365 E.00286
G1 X95.081 Y76.45 E.00454
G1 X95.203 Y76.52 E.00277
G1 X95.44 Y76.719 E.00607
G1 X95.579 Y76.895 E.00442
G1 X95.649 Y77.017 E.00277
G1 X95.755 Y77.307 E.00606
G1 X95.787 Y77.529 E.00442
G1 X95.79 Y78.891 E.02679
G1 X94.61 Y78.891 E.0232
G1 X94.61 Y78.086 E.01583
G1 X94.587 Y77.929 E.00313
G1 X94.514 Y77.769 E.00346
G1 X94.383 Y77.623 E.00385
G1 X94.213 Y77.527 E.00385
G1 X94.045 Y77.492 E.00337
G1 X81.985 Y77.491 E.23722
G1 X81.821 Y77.515 E.00325
G1 X81.637 Y77.608 E.00407
G1 X81.507 Y77.737 E.00361
G1 X81.414 Y77.922 E.00407
G1 X81.39 Y78.086 E.00325
G1 X81.39 Y95.119 E.33504
G1 X81.424 Y95.314 E.00389
G1 X81.553 Y95.523 E.00482
G1 X81.757 Y95.665 E.00489
G1 X81.979 Y95.711 E.00446
G1 X94.061 Y95.709 E.23766
G1 X94.243 Y95.663 E.00369
G1 X94.397 Y95.567 E.00356
G1 X94.516 Y95.431 E.00356
G1 X94.59 Y95.265 E.00358
G1 X94.61 Y95.115 E.00298
G1 X94.61 Y94.311 E.01582
G1 X95.79 Y94.311 E.02321
G1 X95.79 Y95.589 E.02513
G1 X95.754 Y95.898 E.00613
G1 X95.65 Y96.182 E.00594
G1 X95.534 Y96.371 E.00436
G1 X95.387 Y96.536 E.00436
G1 X95.144 Y96.717 E.00595
G1 X94.87 Y96.835 E.00589
G1 X94.569 Y96.888 E.00601
G1 X90.396 Y96.891 E.08208
G1 X91.002 Y97.588 E.01815
G1 X91.256 Y97.962 E.00891
G1 X91.363 Y98.153 E.0043
G1 X91.548 Y98.57 E.00897
G1 X91.619 Y98.777 E.0043
G1 X91.728 Y99.22 E.00897
G1 X91.761 Y99.437 E.00431
G1 X91.79 Y99.889 E.00891
G1 X91.764 Y100.339 E.00887
G1 X91.709 Y100.67 E.0066
G1 X91.628 Y100.997 E.00663
G1 X91.472 Y101.42 E.00887
G1 X91.266 Y101.824 E.00891
G1 X91.149 Y102.009 E.00431
G1 X90.873 Y102.372 E.00897
G1 X90.726 Y102.534 E.0043
G1 X90.39 Y102.842 E.00897
G1 X90.216 Y102.975 E.00431
G1 X89.833 Y103.218 E.00891
G1 X89.427 Y103.412 E.00885
G1 X88.998 Y103.557 E.00891
G1 X88.785 Y103.608 E.0043
G1 X88.337 Y103.676 E.00891
G1 X87.887 Y103.689 E.00885
G1 X87.439 Y103.649 E.00885
G1 X86.999 Y103.556 E.00885
G1 X86.573 Y103.412 E.00885
G1 X86.167 Y103.218 E.00885
G1 X85.787 Y102.977 E.00885
G1 X85.435 Y102.691 E.00891
G1 X85.279 Y102.538 E.00431
G1 X84.984 Y102.195 E.00891
G1 X84.733 Y101.821 E.00885
G1 X84.529 Y101.422 E.00881
G1 X84.344 Y100.89 E.01107
G1 X84.236 Y100.336 E.01111
G1 X84.21 Y99.889 E.00881
G1 X84.239 Y99.44 E.00885
G1 X84.32 Y98.997 E.00885
G1 X84.453 Y98.567 E.00885
G1 X84.636 Y98.156 E.00885
G1 X84.868 Y97.767 E.00891
G1 X84.996 Y97.59 E.0043
G1 X85.565 Y96.936 E.01704
; WIPE_START
M204 S6000
G1 X83.565 Y96.914 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G17
G3 Z3.48 I1.217 J0 P1  F18000
;===================== date: 20250206 =====================

; don't support timelapse gcode in spiral_mode and by object sequence for I3 structure printer
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
G92 E0
G1 Z3.48
G1 X0 Y90 ; move to safe pos
G1 X-13.0 F3000 ; move to safe pos
M400
M1004 S5 P1  ; external shutter
M400 P300
M971 S11 C11 O0
G92 E0
G1 X0 F18000
M623

; SKIPTYPE: head_wrap_detect
M622.1 S1
M1002 judge_flag g39_3rd_layer_detect_flag
M622 J1
    ; enable nozzle clog detect at 3rd layer
    


    M622.1 S1
    M1002 judge_flag g39_detection_flag
    M622 J1
      
        M622.1 S0
        M1002 judge_flag g39_mass_exceed_flag
        M622 J1
        
            G392 S0
            M400
            G90
            M83
            M204 S5000
            G0 Z3.48 F4000
            G39.3 S1
            G0 Z3.48 F4000
            G392 S0
          
        M623
    
    M623
M623
; SKIPPABLE_END




G1 X81.442 Y96.257
G1 Z3.08
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.153763
G1 F1500
M204 S6000
G1 X81.075 Y96.026 E.00277
G1 X80.939 Y95.827 E.00153
; LINE_WIDTH: 0.130235
G1 X80.9 Y95.726 E.00057
; LINE_WIDTH: 0.0953102
G1 X80.861 Y95.625 E.00038
; WIPE_START
G1 X80.9 Y95.726 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X86.536 Y97.162 Z3.48 F18000
G1 Z3.08
G1 E.4 F1800
; LINE_WIDTH: 0.4635
G1 F1500
M204 S6000
G1 X86.296 Y97.378 E.00705
; LINE_WIDTH: 0.413674
G1 X86.057 Y97.594 E.00625
; LINE_WIDTH: 0.36115
G1 X85.637 Y98.053 E.0104
G1 X85.531 Y98.204 E.00309
G1 X85.295 Y98.607 E.00781
G1 X85.102 Y99.127 E.00928
G1 X85.028 Y99.537 E.00697
G1 X85.005 Y99.891 E.00595
G1 X85.021 Y100.25 E.00601
G1 X85.157 Y100.846 E.01023
G1 X85.26 Y101.11 E.00473
G1 X85.415 Y101.42 E.00581
G1 X85.726 Y101.849 E.00887
G1 X86.064 Y102.189 E.00802
G1 X86.34 Y102.397 E.00579
G1 X86.55 Y102.525 E.00411
G1 X86.872 Y102.676 E.00595
G1 X87.208 Y102.793 E.00596
G1 X87.701 Y102.884 E.00839
G1 X88.222 Y102.892 E.00871
G1 X88.588 Y102.837 E.0062
G1 X88.952 Y102.743 E.00628
G1 X89.444 Y102.531 E.00896
G1 X89.883 Y102.234 E.00888
G1 X90.267 Y101.863 E.00893
G1 X90.629 Y101.342 E.01062
G1 X90.87 Y100.778 E.01026
G1 X90.978 Y100.267 E.00874
G1 X90.985 Y99.615 E.01091
G1 X90.867 Y99.016 E.01022
G1 X90.709 Y98.624 E.00707
G1 X90.554 Y98.338 E.00543
G1 X90.248 Y97.917 E.00871
; LINE_WIDTH: 0.376712
G1 X89.897 Y97.549 E.00891
; LINE_WIDTH: 0.403693
G1 X89.869 Y97.523 E.00071
; LINE_WIDTH: 0.430223
G1 X89.659 Y97.343 E.00558
; LINE_WIDTH: 0.476065
G1 X89.45 Y97.163 E.00622
; WIPE_START
G1 X89.659 Y97.343 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X94.53 Y96.242 Z3.48 F18000
G1 Z3.08
G1 E.4 F1800
; LINE_WIDTH: 0.104168
G1 F1500
M204 S6000
G1 X94.675 Y96.186 E.00061
; LINE_WIDTH: 0.148514
G1 X94.8 Y96.121 E.00086
G1 X94.915 Y96.026 E.00091
G1 X95.08 Y95.8 E.00171
; LINE_WIDTH: 0.101122
G1 X95.138 Y95.618 E.00072
; WIPE_START
G1 X95.08 Y95.8 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X95.108 Y88.167 Z3.48 F18000
G1 X95.147 Y77.601 Z3.48
G1 Z3.08
G1 E.4 F1800
; LINE_WIDTH: 0.102486
G1 F1500
M204 S6000
G1 X95.075 Y77.392 E.00085
; LINE_WIDTH: 0.13761
G1 X95.026 Y77.311 E.00053
; LINE_WIDTH: 0.156824
G1 X94.939 Y77.204 E.0009
G1 X94.781 Y77.064 E.00138
; LINE_WIDTH: 0.130137
G1 X94.513 Y76.943 E.00153
; WIPE_START
G1 X94.781 Y77.064 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X87.148 Y77.002 Z3.48 F18000
G1 X81.504 Y76.955 Z3.48
G1 Z3.08
G1 E.4 F1800
; LINE_WIDTH: 0.0894706
G1 F1500
M204 S6000
G1 X81.399 Y76.99 E.00035
; LINE_WIDTH: 0.124555
G1 X81.229 Y77.058 E.0009
; LINE_WIDTH: 0.151624
G1 X81.082 Y77.181 E.0012
G1 X80.956 Y77.33 E.00123
G1 X80.912 Y77.424 E.00065
; LINE_WIDTH: 0.115067
G1 X80.883 Y77.514 E.00042
; LINE_WIDTH: 0.0897515
G1 X80.854 Y77.604 E.0003
; WIPE_START
G1 X80.883 Y77.514 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X88.28 Y79.394 Z3.48 F18000
G1 X96.743 Y81.544 Z3.48
G1 Z3.08
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X97.257 Y81.544 E.01086
G1 X97.257 Y82.057 E.01086
G1 X96.743 Y82.057 E.01086
G1 X96.743 Y81.604 E.00959
M204 S10000
G1 X96.319 Y81.12 F18000
G1 F1500
M204 S500
G1 X97.681 Y81.12 E.02882
G1 X97.681 Y82.482 E.02882
G1 X96.319 Y82.482 E.02882
G1 X96.319 Y81.18 E.02755
M204 S250
G1 X95.91 Y80.711 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X98.09 Y80.711 E.04288
G1 X98.09 Y82.891 E.04288
G1 X95.91 Y82.891 E.04288
G1 X95.91 Y80.771 E.0417
; CHANGE_LAYER
; Z_HEIGHT: 3.2
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F1500
M204 S6000
G1 X97.909 Y80.716 E-.38
; WIPE_END
G1 E-.02 F1800
; layer num/total_layer_count: 26/49
; update layer progress
M73 L26
M991 S0 P25 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z3.48 I-1.073 J-.574 P1  F18000
G1 X89.159 Y97.081 Z3.48
G1 Z3.2
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X88.751 Y96.949 E.00907
G1 X88.228 Y96.862 E.01123
G1 X87.682 Y96.87 E.01156
G1 X87.145 Y96.975 E.01157
G1 X86.837 Y97.096 E.00701
G1 X86.723 Y96.929 E.00429
G1 X87.079 Y96.544 E.01111
G1 X88.921 Y96.543 E.03899
G1 X89.265 Y96.915 E.01072
G1 X89.191 Y97.031 E.00289
; WIPE_START
M204 S6000
G1 X88.751 Y96.949 E-.08499
G1 X88.228 Y96.862 E-.10083
G1 X87.682 Y96.87 E-.10381
G1 X87.215 Y96.962 E-.09037
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X90.61 Y99.876 Z3.6 F18000
G1 Z3.2
G1 E.4 F1800
G1 F1500
M204 S500
G1 X90.611 Y100.132 E.00541
G1 X90.527 Y100.599 E.01004
G1 X90.33 Y101.104 E.01147
G1 X90.074 Y101.505 E.01006
G1 X89.754 Y101.849 E.00995
G1 X89.381 Y102.129 E.00987
G1 X89.042 Y102.304 E.0081
G1 X88.798 Y102.397 E.00551
G1 X88.361 Y102.497 E.00949
G1 X88.039 Y102.521 E.00683
G1 X87.717 Y102.506 E.00683
G1 X87.265 Y102.417 E.00975
G1 X86.822 Y102.244 E.01006
G1 X86.372 Y101.955 E.01134
G1 X86.026 Y101.625 E.01011
G1 X85.718 Y101.19 E.01128
G1 X85.575 Y100.895 E.00695
G1 X85.471 Y100.589 E.00683
G1 X85.389 Y100.136 E.00975
G1 X85.389 Y99.666 E.00995
G1 X85.47 Y99.216 E.00968
G1 X85.55 Y98.974 E.00538
G1 X85.712 Y98.621 E.00822
G1 X85.975 Y98.236 E.00987
G1 X86.296 Y97.91 E.00969
G1 X86.503 Y97.752 E.00551
G1 X86.831 Y97.555 E.0081
G1 X87.265 Y97.384 E.00987
G1 X87.726 Y97.294 E.00995
G1 X88.196 Y97.286 E.00995
G1 X88.65 Y97.362 E.00975
G1 X88.957 Y97.462 E.00683
G1 X89.25 Y97.597 E.00683
G1 X89.635 Y97.851 E.00975
G1 X89.974 Y98.176 E.00995
G1 X90.251 Y98.556 E.00994
G1 X90.455 Y98.98 E.00995
G1 X90.576 Y99.421 E.00968
G1 X90.61 Y99.678 E.0055
G1 X90.61 Y99.816 E.00293
M204 S250
G1 X90.201 Y99.877 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X90.201 Y100.096 E.00431
G1 X90.131 Y100.487 E.00782
G1 X89.963 Y100.918 E.00909
G1 X89.749 Y101.253 E.00783
G1 X89.479 Y101.544 E.0078
G1 X89.163 Y101.781 E.00777
G1 X88.874 Y101.93 E.0064
G1 X88.679 Y102.004 E.0041
M73 P71 R7
G1 X88.3 Y102.091 E.00765
G1 X88.033 Y102.111 E.00526
G1 X87.766 Y102.099 E.00526
G1 X87.38 Y102.023 E.00774
G1 X87.009 Y101.878 E.00783
G1 X86.625 Y101.632 E.00897
G1 X86.337 Y101.356 E.00785
G1 X86.072 Y100.982 E.00902
G1 X85.955 Y100.739 E.0053
G1 X85.868 Y100.486 E.00526
G1 X85.798 Y100.099 E.00773
G1 X85.798 Y99.703 E.00779
G1 X85.868 Y99.317 E.00771
G1 X85.932 Y99.124 E.00399
G1 X86.07 Y98.823 E.00651
G1 X86.292 Y98.497 E.00777
G1 X86.568 Y98.217 E.00772
G1 X86.733 Y98.091 E.0041
G1 X87.012 Y97.923 E.0064
G1 X87.38 Y97.779 E.00777
G1 X87.769 Y97.702 E.0078
G1 X88.165 Y97.696 E.00779
G1 X88.553 Y97.761 E.00773
G1 X88.808 Y97.843 E.00526
G1 X89.05 Y97.956 E.00526
G1 X89.378 Y98.172 E.00773
G1 X89.665 Y98.446 E.0078
G1 X89.898 Y98.767 E.00779
G1 X90.07 Y99.124 E.0078
G1 X90.174 Y99.502 E.00771
G1 X90.201 Y99.705 E.00403
G1 X90.201 Y99.817 E.0022
; WIPE_START
M204 S6000
G1 X90.201 Y100.096 E-.05301
G1 X90.131 Y100.487 E-.07555
G1 X89.963 Y100.918 E-.08778
G1 X89.749 Y101.253 E-.07564
G1 X89.479 Y101.544 E-.0753
G1 X89.426 Y101.584 E-.01272
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X86.835 Y96.119 Z3.6 F18000
G1 Z3.2
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X94.113 Y96.118 E.15405
G1 X94.406 Y96.044 E.00639
G1 X94.665 Y95.883 E.00646
G1 X94.864 Y95.654 E.00642
G1 X94.988 Y95.377 E.00642
G1 X95.019 Y95.143 E.005
G1 X95.019 Y94.72 E.00894
G1 X95.381 Y94.72 E.00765
G1 X95.381 Y95.565 E.01788
G1 X95.353 Y95.803 E.00508
G1 X95.28 Y96.003 E.0045
G1 X95.207 Y96.121 E.00294
G1 X95.082 Y96.257 E.00392
G1 X94.942 Y96.358 E.00365
G1 X94.751 Y96.441 E.00439
G1 X94.533 Y96.479 E.0047
G1 X89.442 Y96.483 E.10774
G1 X90.544 Y97.675 E.03436
G1 X90.797 Y98.003 E.00876
G1 X91.086 Y98.523 E.0126
G1 X91.229 Y98.901 E.00855
G1 X91.354 Y99.48 E.01254
G1 X91.38 Y99.89 E.00869
G1 X91.357 Y100.294 E.00856
G1 X91.236 Y100.877 E.0126
G1 X91.096 Y101.256 E.00856
G1 X90.91 Y101.621 E.00868
G1 X90.558 Y102.11 E.01274
G1 X90.292 Y102.385 E.0081
G1 X89.974 Y102.644 E.00868
G1 X89.635 Y102.859 E.0085
G1 X89.273 Y103.032 E.00849
G1 X88.884 Y103.164 E.00868
G1 X88.301 Y103.267 E.01254
G1 X87.9 Y103.279 E.00849
G1 X87.5 Y103.243 E.00849
G1 X87.107 Y103.161 E.00849
G1 X86.727 Y103.032 E.0085
G1 X86.37 Y102.861 E.00838
G1 X85.951 Y102.586 E.01061
G1 X85.567 Y102.247 E.01084
G1 X85.31 Y101.947 E.00837
G1 X85.086 Y101.613 E.00849
G1 X84.906 Y101.261 E.00838
G1 X84.741 Y100.787 E.01061
G1 X84.643 Y100.285 E.01084
G1 X84.62 Y99.89 E.00837
G1 X84.645 Y99.49 E.00849
G1 X84.718 Y99.095 E.0085
G1 X84.837 Y98.711 E.00849
G1 X85 Y98.345 E.00849
M73 P71 R6
G1 X85.205 Y98 E.00849
G1 X85.456 Y97.675 E.00869
G1 X86.558 Y96.482 E.03439
G1 X81.536 Y96.482 E.1063
G1 X81.298 Y96.454 E.00508
G1 X81.098 Y96.381 E.0045
G1 X80.968 Y96.301 E.00324
G1 X80.81 Y96.145 E.0047
G1 X80.739 Y96.041 E.00266
G1 X80.649 Y95.816 E.00513
G1 X80.619 Y95.565 E.00535
G1 X80.619 Y77.628 E.37965
G1 X80.655 Y77.357 E.00578
G1 X80.761 Y77.125 E.00539
G1 X80.954 Y76.913 E.00608
G1 X81.203 Y76.774 E.00604
G1 X81.455 Y76.723 E.00543
G1 X94.515 Y76.721 E.27643
G1 X94.658 Y76.736 E.00304
G1 X94.744 Y76.756 E.00187
G1 X94.968 Y76.857 E.0052
G1 X95.147 Y77.008 E.00496
G1 X95.281 Y77.198 E.00493
G1 X95.348 Y77.375 E.004
G1 X95.378 Y77.564 E.00405
G1 X95.38 Y78.482 E.01942
G1 X95.019 Y78.482 E.00763
G1 X95.019 Y78.057 E.00899
G1 X94.984 Y77.812 E.00523
G1 X94.86 Y77.541 E.00631
G1 X94.643 Y77.3 E.00687
G1 X94.359 Y77.139 E.00692
G1 X94.087 Y77.082 E.00587
G1 X81.955 Y77.082 E.25679
G1 X81.697 Y77.12 E.00553
G1 X81.394 Y77.272 E.00717
G1 X81.171 Y77.495 E.00669
G1 X81.019 Y77.798 E.00717
G1 X80.981 Y78.056 E.00552
G1 X80.981 Y95.164 E.36211
G1 X81.05 Y95.501 E.00727
G1 X81.257 Y95.815 E.00796
G1 X81.591 Y96.049 E.00864
G1 X81.937 Y96.12 E.00747
G1 X86.775 Y96.119 E.1024
; WIPE_START
M204 S6000
G1 X88.775 Y96.119 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X85.623 Y96.891 Z3.6 F18000
G1 Z3.2
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X81.512 Y96.891 E.08086
G1 X81.203 Y96.855 E.00613
G1 X80.919 Y96.751 E.00594
G1 X80.727 Y96.633 E.00442
G1 X80.617 Y96.54 E.00285
G1 X80.488 Y96.399 E.00376
G1 X80.383 Y96.246 E.00364
G1 X80.302 Y96.075 E.00373
G1 X80.247 Y95.902 E.00356
G1 X80.21 Y95.589 E.00622
G1 X80.21 Y77.61 E.35362
G1 X80.231 Y77.374 E.00466
G1 X80.264 Y77.234 E.00283
G1 X80.349 Y77.019 E.00454
G1 X80.421 Y76.895 E.00283
G1 X80.563 Y76.715 E.00451
G1 X80.699 Y76.591 E.00362
G1 X80.854 Y76.485 E.0037
G1 X81.06 Y76.389 E.00447
G1 X81.238 Y76.339 E.00362
G1 X81.427 Y76.313 E.00376
G1 X94.535 Y76.312 E.25783
G1 X94.726 Y76.331 E.00377
G1 X94.867 Y76.365 E.00286
G1 X95.081 Y76.45 E.00454
G1 X95.203 Y76.52 E.00277
G1 X95.441 Y76.719 E.00609
G1 X95.557 Y76.863 E.00364
G1 X95.651 Y77.02 E.00359
G1 X95.745 Y77.269 E.00525
G1 X95.788 Y77.531 E.00521
G1 X95.79 Y78.891 E.02675
G1 X94.61 Y78.891 E.0232
G1 X94.61 Y78.086 E.01583
G1 X94.587 Y77.929 E.00313
G1 X94.514 Y77.768 E.00347
G1 X94.384 Y77.623 E.00384
G1 X94.213 Y77.527 E.00386
G1 X94.045 Y77.492 E.00337
G1 X81.985 Y77.491 E.23722
G1 X81.821 Y77.515 E.00325
G1 X81.637 Y77.608 E.00406
G1 X81.507 Y77.738 E.00361
G1 X81.414 Y77.922 E.00406
G1 X81.39 Y78.086 E.00325
G1 X81.39 Y95.122 E.3351
G1 X81.435 Y95.341 E.0044
G1 X81.556 Y95.524 E.00431
G1 X81.757 Y95.665 E.00482
G1 X81.979 Y95.711 E.00446
G1 X94.062 Y95.709 E.23767
G1 X94.243 Y95.663 E.00368
G1 X94.396 Y95.567 E.00355
G1 X94.516 Y95.431 E.00356
G1 X94.59 Y95.264 E.0036
G1 X94.61 Y95.115 E.00296
G1 X94.61 Y94.311 E.01582
G1 X95.79 Y94.311 E.02321
G1 X95.79 Y95.589 E.02513
G1 X95.754 Y95.898 E.00613
G1 X95.65 Y96.182 E.00594
G1 X95.535 Y96.369 E.00432
G1 X95.355 Y96.565 E.00522
G1 X95.146 Y96.716 E.00509
G1 X94.87 Y96.835 E.00591
G1 X94.569 Y96.888 E.00601
G1 X90.377 Y96.891 E.08245
G1 X90.857 Y97.411 E.01392
G1 X91.134 Y97.771 E.00893
G1 X91.307 Y98.053 E.00651
G1 X91.461 Y98.358 E.00673
G1 X91.62 Y98.78 E.00887
G1 X91.728 Y99.22 E.00891
G1 X91.761 Y99.437 E.00431
G1 X91.79 Y99.889 E.00891
G1 X91.764 Y100.339 E.00887
G1 X91.71 Y100.665 E.00651
G1 X91.628 Y100.997 E.00672
G1 X91.472 Y101.42 E.00887
G1 X91.266 Y101.824 E.00891
G1 X91.149 Y102.009 E.00431
G1 X90.873 Y102.372 E.00897
G1 X90.565 Y102.691 E.00873
G1 X90.213 Y102.977 E.00891
G1 X89.833 Y103.218 E.00885
G1 X89.427 Y103.412 E.00885
G1 X88.998 Y103.557 E.00891
G1 X88.785 Y103.608 E.00431
G1 X88.337 Y103.676 E.00891
G1 X87.887 Y103.689 E.00885
G1 X87.439 Y103.649 E.00885
G1 X86.999 Y103.556 E.00885
G1 X86.573 Y103.412 E.00885
G1 X86.169 Y103.218 E.00881
G1 X85.702 Y102.912 E.01098
G1 X85.275 Y102.535 E.0112
G1 X84.983 Y102.195 E.00881
G1 X84.733 Y101.821 E.00885
G1 X84.529 Y101.422 E.00881
G1 X84.345 Y100.895 E.01098
G1 X84.236 Y100.336 E.0112
G1 X84.21 Y99.889 E.00881
G1 X84.239 Y99.44 E.00885
G1 X84.32 Y98.997 E.00885
G1 X84.453 Y98.567 E.00885
G1 X84.636 Y98.156 E.00885
G1 X84.866 Y97.77 E.00885
G1 X85.143 Y97.411 E.00891
G1 X85.583 Y96.935 E.01275
; WIPE_START
M204 S6000
G1 X83.583 Y96.913 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G17
G3 Z3.6 I1.217 J0 P1  F18000
;===================== date: 20250206 =====================

; don't support timelapse gcode in spiral_mode and by object sequence for I3 structure printer
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
G92 E0
G1 Z3.6
G1 X0 Y90 ; move to safe pos
G1 X-13.0 F3000 ; move to safe pos
M400
M1004 S5 P1  ; external shutter
M400 P300
M971 S11 C11 O0
G92 E0
G1 X0 F18000
M623

; SKIPTYPE: head_wrap_detect
M622.1 S1
M1002 judge_flag g39_3rd_layer_detect_flag
M622 J1
    ; enable nozzle clog detect at 3rd layer
    


    M622.1 S1
    M1002 judge_flag g39_detection_flag
    M622 J1
      
        M622.1 S0
        M1002 judge_flag g39_mass_exceed_flag
        M622 J1
        
            G392 S0
            M400
            G90
            M83
            M204 S5000
            G0 Z3.6 F4000
            G39.3 S1
            G0 Z3.6 F4000
            G392 S0
          
        M623
    
    M623
M623
; SKIPPABLE_END




G1 X81.452 Y96.25
G1 Z3.2
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.148395
G1 F1500
M204 S6000
G1 X81.222 Y96.13 E.00159
G1 X81.094 Y96.042 E.00095
G1 X80.938 Y95.826 E.00163
; LINE_WIDTH: 0.129278
G1 X80.9 Y95.733 E.00052
; LINE_WIDTH: 0.0949154
G1 X80.862 Y95.639 E.00035
; WIPE_START
G1 X80.9 Y95.733 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X86.605 Y97.134 Z3.6 F18000
G1 Z3.2
G1 E.4 F1800
; LINE_WIDTH: 0.47613
G1 F1500
M204 S6000
G1 X86.442 Y97.267 E.00474
; LINE_WIDTH: 0.447747
G1 X86.261 Y97.415 E.00493
; LINE_WIDTH: 0.405872
G1 X86.048 Y97.609 E.00546
; LINE_WIDTH: 0.36163
G1 X85.693 Y97.985 E.00866
G1 X85.391 Y98.424 E.00893
G1 X85.193 Y98.844 E.00778
G1 X85.089 Y99.186 E.00599
G1 X85.013 Y99.647 E.00783
G1 X85.014 Y100.184 E.00901
G1 X85.106 Y100.688 E.00859
G1 X85.224 Y101.028 E.00602
G1 X85.399 Y101.394 E.0068
G1 X85.617 Y101.713 E.00647
G1 X85.841 Y101.977 E.0058
G1 X86.182 Y102.284 E.00769
G1 X86.637 Y102.572 E.00903
G1 X87.145 Y102.775 E.00917
G1 X87.66 Y102.879 E.0088
G1 X88.035 Y102.898 E.0063
G1 X88.429 Y102.867 E.00663
G1 X88.917 Y102.751 E.00841
G1 X89.131 Y102.678 E.00378
G1 X89.449 Y102.524 E.00593
G1 X89.749 Y102.332 E.00596
G1 X90.037 Y102.103 E.00617
G1 X90.38 Y101.723 E.00858
G1 X90.67 Y101.259 E.00917
G1 X90.871 Y100.764 E.00894
G1 X90.977 Y100.252 E.00877
G1 X90.995 Y99.893 E.00601
G1 X90.952 Y99.369 E.00882
G1 X90.862 Y99.015 E.00613
G1 X90.736 Y98.681 E.00598
G1 X90.478 Y98.218 E.00888
G1 X90.254 Y97.92 E.00625
G1 X89.869 Y97.53 E.00918
; LINE_WIDTH: 0.419933
G1 X89.628 Y97.325 E.00624
; LINE_WIDTH: 0.467984
G1 X89.386 Y97.12 E.007
; WIPE_START
G1 X89.628 Y97.325 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X94.53 Y96.242 Z3.6 F18000
G1 Z3.2
G1 E.4 F1800
; LINE_WIDTH: 0.104168
G1 F1500
M204 S6000
G1 X94.675 Y96.186 E.00061
; LINE_WIDTH: 0.147918
G1 X94.805 Y96.118 E.0009
G1 X94.892 Y96.048 E.00068
G1 X95.08 Y95.8 E.0019
; LINE_WIDTH: 0.101089
G1 X95.138 Y95.617 E.00072
; WIPE_START
G1 X95.08 Y95.8 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X95.107 Y88.167 Z3.6 F18000
G1 X95.145 Y77.598 Z3.6
G1 Z3.2
G1 E.4 F1800
; LINE_WIDTH: 0.102926
G1 F1500
M204 S6000
G1 X95.076 Y77.391 E.00084
; LINE_WIDTH: 0.152809
G1 X94.942 Y77.207 E.00144
G1 X94.78 Y77.064 E.00137
; LINE_WIDTH: 0.130138
G1 X94.513 Y76.943 E.00153
; WIPE_START
G1 X94.78 Y77.064 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X87.148 Y77.002 Z3.6 F18000
G1 X81.504 Y76.955 Z3.6
G1 Z3.2
G1 E.4 F1800
; LINE_WIDTH: 0.0894849
M73 P72 R6
G1 F1500
M204 S6000
G1 X81.399 Y76.99 E.00035
; LINE_WIDTH: 0.128109
G1 X81.196 Y77.08 E.00113
; LINE_WIDTH: 0.152022
G1 X80.962 Y77.32 E.00211
G1 X80.907 Y77.434 E.0008
; LINE_WIDTH: 0.102611
G1 X80.857 Y77.598 E.00066
; WIPE_START
G1 X80.907 Y77.434 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X88.295 Y79.352 Z3.6 F18000
G1 X96.743 Y81.544 Z3.6
G1 Z3.2
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X97.257 Y81.544 E.01086
G1 X97.257 Y82.057 E.01086
G1 X96.743 Y82.057 E.01086
G1 X96.743 Y81.604 E.00959
M204 S10000
G1 X96.319 Y81.12 F18000
G1 F1500
M204 S500
G1 X97.681 Y81.12 E.02882
G1 X97.681 Y82.482 E.02882
G1 X96.319 Y82.482 E.02882
G1 X96.319 Y81.18 E.02755
M204 S250
G1 X95.91 Y80.711 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X98.09 Y80.711 E.04288
G1 X98.09 Y82.891 E.04288
G1 X95.91 Y82.891 E.04288
G1 X95.91 Y80.771 E.0417
; CHANGE_LAYER
; Z_HEIGHT: 3.32
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F1500
M204 S6000
G1 X97.909 Y80.716 E-.38
; WIPE_END
G1 E-.02 F1800
; layer num/total_layer_count: 27/49
; update layer progress
M73 L27
M991 S0 P26 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z3.6 I-1.073 J-.574 P1  F18000
G1 X89.161 Y97.078 Z3.6
G1 Z3.32
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X88.58 Y96.908 E.01281
G1 X87.948 Y96.853 E.01343
G1 X87.33 Y96.927 E.01318
G1 X86.766 Y97.11 E.01255
G1 X86.659 Y96.949 E.0041
G1 X87.011 Y96.544 E.01137
G1 X88.921 Y96.543 E.04042
G1 X89.262 Y96.913 E.01065
G1 X89.192 Y97.027 E.00283
; WIPE_START
M204 S6000
G1 X88.58 Y96.908 E-.11851
G1 X87.948 Y96.853 E-.12052
G1 X87.33 Y96.927 E-.11829
G1 X87.216 Y96.964 E-.02269
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X90.617 Y99.847 Z3.72 F18000
G1 Z3.32
G1 E.4 F1800
G1 F1500
M204 S500
G1 X90.622 Y99.901 E.00114
G1 X90.58 Y100.369 E.00995
G1 X90.457 Y100.813 E.00975
G1 X90.326 Y101.108 E.00683
G1 X90.16 Y101.385 E.00683
G1 X89.868 Y101.741 E.00975
G1 X89.516 Y102.039 E.00975
G1 X89.242 Y102.208 E.00684
G1 X88.949 Y102.344 E.00683
G1 X88.507 Y102.473 E.00975
G1 X88.039 Y102.522 E.00995
G1 X87.58 Y102.488 E.00975
G1 X87.265 Y102.416 E.00683
G1 X86.961 Y102.307 E.00683
G1 X86.556 Y102.089 E.00975
G1 X86.188 Y101.796 E.00995
G1 X85.879 Y101.442 E.00995
G1 X85.638 Y101.039 E.00995
G1 X85.476 Y100.607 E.00975
G1 X85.409 Y100.292 E.00683
G1 X85.38 Y99.97 E.00683
G1 X85.408 Y99.505 E.00986
G1 X85.543 Y98.985 E.01137
G1 X85.787 Y98.494 E.0116
G1 X86.078 Y98.118 E.01007
G1 X86.421 Y97.809 E.00975
G1 X86.69 Y97.632 E.00683
G1 X86.978 Y97.487 E.00683
G1 X87.421 Y97.343 E.00986
G1 X87.955 Y97.28 E.01137
G1 X88.501 Y97.327 E.01161
G1 X88.958 Y97.46 E.01006
G1 X89.37 Y97.667 E.00976
G1 X89.634 Y97.852 E.00683
G1 X89.877 Y98.071 E.00693
G1 X90.206 Y98.484 E.01117
G1 X90.453 Y98.974 E.01161
G1 X90.58 Y99.433 E.01007
G1 X90.612 Y99.788 E.00754
M204 S250
G1 X90.209 Y99.884 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X90.211 Y99.901 E.00033
G1 X90.175 Y100.296 E.00779
G1 X90.071 Y100.675 E.00773
G1 X89.962 Y100.919 E.00526
G1 X89.825 Y101.149 E.00526
G1 X89.575 Y101.452 E.00773
G1 X89.275 Y101.707 E.00773
G1 X89.047 Y101.847 E.00527
G1 X88.805 Y101.96 E.00526
G1 X88.427 Y102.07 E.00774
G1 X88.033 Y102.111 E.0078
G1 X87.641 Y102.082 E.00773
G1 X87.38 Y102.023 E.00526
G1 X87.128 Y101.932 E.00526
G1 X86.782 Y101.746 E.00773
G1 X86.472 Y101.499 E.0078
G1 X86.211 Y101.2 E.00779
G1 X86.008 Y100.86 E.00779
G1 X85.87 Y100.492 E.00774
G1 X85.814 Y100.23 E.00526
G1 X85.79 Y99.964 E.00526
G1 X85.814 Y99.57 E.00777
G1 X85.929 Y99.129 E.00895
G1 X86.136 Y98.712 E.00916
G1 X86.379 Y98.397 E.00784
G1 X86.672 Y98.134 E.00774
G1 X86.895 Y97.987 E.00526
G1 X87.134 Y97.867 E.00526
G1 X87.51 Y97.745 E.00777
G1 X87.961 Y97.691 E.00895
G1 X88.426 Y97.731 E.00916
G1 X88.808 Y97.843 E.00783
G1 X89.159 Y98.019 E.00774
G1 X89.378 Y98.173 E.00526
G1 X89.578 Y98.353 E.00529
G1 X89.86 Y98.706 E.00889
G1 X90.069 Y99.122 E.00916
G1 X90.175 Y99.506 E.00784
G1 X90.204 Y99.824 E.00628
; WIPE_START
M204 S6000
G1 X90.211 Y99.901 E-.01459
G1 X90.175 Y100.296 E-.07529
G1 X90.071 Y100.675 E-.07471
G1 X89.962 Y100.919 E-.05084
G1 X89.825 Y101.149 E-.05083
G1 X89.575 Y101.452 E-.07471
G1 X89.418 Y101.585 E-.03902
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X86.761 Y96.119 Z3.72 F18000
G1 Z3.32
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X94.114 Y96.118 E.15563
G1 X94.405 Y96.044 E.00637
G1 X94.664 Y95.883 E.00646
G1 X94.864 Y95.654 E.00643
G1 X94.988 Y95.376 E.00645
G1 X95.019 Y95.142 E.00499
G1 X95.019 Y94.72 E.00894
G1 X95.381 Y94.72 E.00765
G1 X95.381 Y95.583 E.01826
G1 X95.35 Y95.822 E.00511
G1 X95.282 Y95.999 E.00401
G1 X95.207 Y96.121 E.00302
G1 X95.081 Y96.258 E.00395
G1 X94.942 Y96.358 E.00362
G1 X94.751 Y96.441 E.0044
G1 X94.533 Y96.479 E.0047
G1 X89.442 Y96.483 E.10774
G1 X90.544 Y97.675 E.03436
G1 X90.795 Y98 E.00869
G1 X91.084 Y98.517 E.01254
G1 X91.229 Y98.901 E.00868
G1 X91.354 Y99.48 E.01254
G1 X91.38 Y99.89 E.00869
G1 X91.357 Y100.294 E.00857
G1 X91.236 Y100.877 E.0126
G1 X91.096 Y101.256 E.00855
G1 X90.909 Y101.622 E.00869
G1 X90.633 Y102.017 E.01021
G1 X90.429 Y102.252 E.00659
G1 X90.217 Y102.451 E.00615
G1 X89.976 Y102.643 E.00651
G1 X89.635 Y102.859 E.00855
G1 X89.273 Y103.032 E.00849
G1 X88.893 Y103.161 E.00849
G1 X88.5 Y103.243 E.0085
G1 X88.1 Y103.279 E.00849
G1 X87.699 Y103.267 E.00849
G1 X87.116 Y103.163 E.01254
G1 X86.727 Y103.032 E.00869
G1 X86.365 Y102.859 E.00849
G1 X86.026 Y102.644 E.0085
G1 X85.577 Y102.258 E.01253
G1 X85.31 Y101.947 E.00869
G1 X85.086 Y101.613 E.0085
G1 X84.906 Y101.26 E.00838
G1 X84.742 Y100.792 E.01051
G1 X84.643 Y100.285 E.01094
G1 X84.62 Y99.89 E.00837
G1 X84.645 Y99.49 E.00849
G1 X84.718 Y99.095 E.0085
G1 X84.837 Y98.711 E.00849
G1 X85 Y98.345 E.00849
G1 X85.317 Y97.845 E.01253
G1 X86.503 Y96.482 E.03825
G1 X81.536 Y96.482 E.10513
G1 X81.285 Y96.452 E.00536
G1 X81.178 Y96.419 E.00236
G1 X80.979 Y96.31 E.0048
G1 X80.792 Y96.122 E.00562
G1 X80.682 Y95.922 E.00482
G1 X80.649 Y95.816 E.00236
G1 X80.619 Y95.565 E.00536
G1 X80.619 Y77.628 E.37965
G1 X80.655 Y77.357 E.00578
G1 X80.76 Y77.125 E.00539
G1 X80.953 Y76.914 E.00605
G1 X81.2 Y76.775 E.00599
G1 X81.449 Y76.723 E.00539
G1 X94.516 Y76.721 E.27658
G1 X94.658 Y76.736 E.003
G1 X94.903 Y76.819 E.00548
G1 X94.983 Y76.866 E.00198
G1 X95.158 Y77.019 E.00492
G1 X95.277 Y77.19 E.00441
G1 X95.356 Y77.407 E.00488
G1 X95.378 Y77.559 E.00325
G1 X95.38 Y78.482 E.01952
G1 X95.019 Y78.482 E.00763
G1 X95.019 Y78.057 E.009
G1 X94.984 Y77.812 E.00523
G1 X94.86 Y77.541 E.00631
G1 X94.644 Y77.3 E.00685
G1 X94.359 Y77.139 E.00692
G1 X94.088 Y77.082 E.00587
G1 X81.95 Y77.082 E.25691
G1 X81.675 Y77.127 E.00588
G1 X81.391 Y77.275 E.00679
G1 X81.17 Y77.495 E.00659
G1 X81.019 Y77.798 E.00717
G1 X80.981 Y78.056 E.00552
G1 X80.981 Y95.155 E.36192
G1 X81.035 Y95.462 E.0066
G1 X81.249 Y95.809 E.00863
G1 X81.591 Y96.049 E.00884
G1 X81.937 Y96.12 E.00748
G1 X86.701 Y96.119 E.10084
; WIPE_START
M204 S6000
G1 X88.701 Y96.119 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X85.605 Y96.891 Z3.72 F18000
G1 Z3.32
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X81.512 Y96.891 E.08049
G1 X81.198 Y96.854 E.00622
G1 X81.027 Y96.8 E.00353
G1 X80.854 Y96.717 E.00379
G1 X80.586 Y96.51 E.00665
G1 X80.384 Y96.247 E.00651
G1 X80.301 Y96.073 E.00379
G1 X80.247 Y95.902 E.00353
G1 X80.21 Y95.589 E.00622
G1 X80.21 Y77.61 E.35362
G1 X80.231 Y77.374 E.00466
G1 X80.264 Y77.234 E.00283
G1 X80.349 Y77.019 E.00454
G1 X80.421 Y76.895 E.00283
G1 X80.563 Y76.715 E.00451
G1 X80.698 Y76.592 E.00359
G1 X80.854 Y76.485 E.00373
G1 X81.059 Y76.389 E.00444
G1 X81.279 Y76.33 E.00448
G1 X81.425 Y76.313 E.00289
G1 X94.537 Y76.312 E.2579
G1 X94.726 Y76.331 E.00373
G1 X94.867 Y76.365 E.00286
G1 X95.081 Y76.45 E.00454
G1 X95.209 Y76.523 E.00289
G1 X95.465 Y76.747 E.00669
G1 X95.649 Y77.017 E.00643
G1 X95.755 Y77.307 E.00606
G1 X95.787 Y77.529 E.00442
G1 X95.79 Y78.891 E.02678
G1 X94.61 Y78.891 E.0232
G1 X94.61 Y78.086 E.01583
G1 X94.587 Y77.928 E.00313
G1 X94.514 Y77.768 E.00347
G1 X94.384 Y77.624 E.00382
G1 X94.213 Y77.527 E.00387
G1 X94.045 Y77.492 E.00337
G1 X81.983 Y77.491 E.23726
G1 X81.806 Y77.52 E.00352
G1 X81.636 Y77.609 E.00378
G1 X81.507 Y77.738 E.00359
G1 X81.414 Y77.922 E.00406
G1 X81.39 Y78.086 E.00325
G1 X81.39 Y95.119 E.33504
G1 X81.424 Y95.314 E.00389
G1 X81.553 Y95.522 E.00482
G1 X81.757 Y95.665 E.00489
G1 X81.979 Y95.711 E.00446
G1 X94.062 Y95.709 E.23768
G1 X94.243 Y95.663 E.00367
G1 X94.396 Y95.568 E.00356
G1 X94.516 Y95.431 E.00356
G1 X94.59 Y95.263 E.00362
G1 X94.61 Y95.115 E.00295
G1 X94.61 Y94.311 E.01581
G1 X95.79 Y94.311 E.02321
G1 X95.79 Y95.595 E.02525
G1 X95.745 Y95.935 E.00675
G1 X95.651 Y96.181 E.00518
G1 X95.535 Y96.369 E.00435
G1 X95.354 Y96.566 E.00526
G1 X95.146 Y96.716 E.00506
G1 X94.87 Y96.835 E.00591
G1 X94.569 Y96.888 E.00601
G1 X90.377 Y96.891 E.08245
G1 X90.857 Y97.411 E.01392
G1 X91.134 Y97.77 E.00891
G1 X91.366 Y98.159 E.00891
G1 X91.461 Y98.356 E.00431
G1 X91.62 Y98.78 E.00891
G1 X91.728 Y99.22 E.00891
G1 X91.761 Y99.437 E.00431
G1 X91.79 Y99.889 E.00891
G1 X91.764 Y100.339 E.00887
G1 X91.711 Y100.661 E.00642
G1 X91.628 Y100.997 E.00682
G1 X91.472 Y101.42 E.00887
G1 X91.266 Y101.824 E.00891
G1 X91.149 Y102.01 E.00433
G1 X90.952 Y102.275 E.00648
G1 X90.723 Y102.536 E.00684
G1 X90.485 Y102.76 E.00644
G1 X90.214 Y102.977 E.00682
G1 X89.833 Y103.218 E.00887
G1 X89.427 Y103.412 E.00885
G1 X89.001 Y103.556 E.00885
G1 X88.56 Y103.649 E.00885
G1 X88.113 Y103.689 E.00884
G1 X87.663 Y103.676 E.00885
G1 X87.215 Y103.608 E.00891
G1 X87.002 Y103.557 E.00431
G1 X86.573 Y103.412 E.00891
G1 X86.167 Y103.218 E.00885
G1 X85.787 Y102.977 E.00885
G1 X85.435 Y102.691 E.00891
G1 X85.279 Y102.538 E.0043
G1 X84.983 Y102.195 E.00891
G1 X84.733 Y101.821 E.00885
G1 X84.529 Y101.422 E.00882
G1 X84.346 Y100.899 E.01089
G1 X84.236 Y100.336 E.01129
G1 X84.21 Y99.889 E.00881
G1 X84.239 Y99.44 E.00885
G1 X84.32 Y98.997 E.00885
G1 X84.453 Y98.567 E.00885
G1 X84.636 Y98.156 E.00885
G1 X84.868 Y97.767 E.00891
G1 X84.996 Y97.59 E.0043
G1 X85.565 Y96.936 E.01705
; WIPE_START
M204 S6000
G1 X83.565 Y96.914 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G17
G3 Z3.72 I1.217 J0 P1  F18000
;===================== date: 20250206 =====================

; don't support timelapse gcode in spiral_mode and by object sequence for I3 structure printer
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
G92 E0
G1 Z3.72
G1 X0 Y90 ; move to safe pos
G1 X-13.0 F3000 ; move to safe pos
M400
M1004 S5 P1  ; external shutter
M400 P300
M971 S11 C11 O0
G92 E0
G1 X0 F18000
M623

; SKIPTYPE: head_wrap_detect
M622.1 S1
M1002 judge_flag g39_3rd_layer_detect_flag
M622 J1
    ; enable nozzle clog detect at 3rd layer
    


    M622.1 S1
    M1002 judge_flag g39_detection_flag
    M622 J1
      
        M622.1 S0
        M1002 judge_flag g39_mass_exceed_flag
        M622 J1
        
            G392 S0
            M400
            G90
            M83
            M204 S5000
            G0 Z3.72 F4000
            G39.3 S1
            G0 Z3.72 F4000
            G392 S0
          
        M623
    
    M623
M623
; SKIPPABLE_END




G1 X81.424 Y96.253
G1 Z3.32
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.155208
G1 F1500
M204 S6000
G1 X81.074 Y96.025 E.00269
G1 X80.938 Y95.825 E.00156
; LINE_WIDTH: 0.129927
G1 X80.9 Y95.725 E.00056
; LINE_WIDTH: 0.0952522
G1 X80.861 Y95.625 E.00037
; WIPE_START
G1 X80.9 Y95.725 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X86.548 Y97.165 Z3.72 F18000
G1 Z3.32
G1 E.4 F1800
; LINE_WIDTH: 0.477087
G1 F1500
M204 S6000
G1 X86.367 Y97.319 E.00533
; LINE_WIDTH: 0.438373
G1 X86.16 Y97.496 E.00562
; LINE_WIDTH: 0.400589
G1 X85.986 Y97.673 E.00464
; LINE_WIDTH: 0.36125
G1 X85.622 Y98.08 E.00914
G1 X85.463 Y98.31 E.00468
G1 X85.342 Y98.525 E.00413
G1 X85.191 Y98.845 E.00592
G1 X85.039 Y99.43 E.01013
G1 X85.003 Y99.891 E.00774
G1 X85.021 Y100.237 E.0058
G1 X85.108 Y100.692 E.00776
G1 X85.258 Y101.11 E.00743
G1 X85.418 Y101.418 E.00581
G1 X85.613 Y101.716 E.00596
G1 X85.918 Y102.057 E.00766
G1 X86.361 Y102.411 E.00949
G1 X86.819 Y102.657 E.00871
G1 X87.169 Y102.782 E.00621
G1 X87.536 Y102.859 E.00628
G1 X88.06 Y102.9 E.00879
G1 X88.565 Y102.845 E.00851
G1 X89.07 Y102.702 E.00879
G1 X89.43 Y102.537 E.00662
G1 X89.749 Y102.338 E.0063
G1 X90.148 Y101.996 E.00879
G1 X90.46 Y101.611 E.0083
G1 X90.656 Y101.29 E.00629
G1 X90.816 Y100.929 E.00662
G1 X90.95 Y100.421 E.00878
G1 X91.001 Y99.891 E.00892
G1 X90.95 Y99.38 E.00859
G1 X90.862 Y99.015 E.00629
G1 X90.662 Y98.531 E.00876
G1 X90.515 Y98.267 E.00506
G1 X90.163 Y97.821 E.0095
G1 X89.873 Y97.535 E.00683
; LINE_WIDTH: 0.415156
G1 X89.74 Y97.418 E.00343
; LINE_WIDTH: 0.456261
G1 X89.581 Y97.28 E.00452
; LINE_WIDTH: 0.484557
G1 X89.379 Y97.129 E.00579
; WIPE_START
G1 X89.581 Y97.28 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X94.53 Y96.242 Z3.72 F18000
G1 Z3.32
G1 E.4 F1800
; LINE_WIDTH: 0.104173
G1 F1500
M204 S6000
M73 P73 R6
G1 X94.675 Y96.186 E.00061
; LINE_WIDTH: 0.14806
G1 X94.806 Y96.118 E.0009
G1 X94.891 Y96.049 E.00067
G1 X95.081 Y95.801 E.0019
; LINE_WIDTH: 0.101216
G1 X95.145 Y95.599 E.0008
; WIPE_START
G1 X95.081 Y95.801 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X95.108 Y88.168 Z3.72 F18000
G1 X95.147 Y77.602 Z3.72
G1 Z3.32
G1 E.4 F1800
; LINE_WIDTH: 0.102602
G1 F1500
M204 S6000
G1 X95.075 Y77.392 E.00085
; LINE_WIDTH: 0.137753
G1 X95.026 Y77.311 E.00053
; LINE_WIDTH: 0.157142
G1 X94.946 Y77.211 E.00084
G1 X94.78 Y77.064 E.00145
; LINE_WIDTH: 0.130165
G1 X94.513 Y76.943 E.00153
; WIPE_START
G1 X94.78 Y77.064 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X87.148 Y77.002 Z3.72 F18000
G1 X81.5 Y76.955 Z3.72
G1 Z3.32
G1 E.4 F1800
; LINE_WIDTH: 0.0896129
G1 F1500
M204 S6000
G1 X81.395 Y76.991 E.00036
; LINE_WIDTH: 0.128826
G1 X81.196 Y77.08 E.00112
; LINE_WIDTH: 0.152021
G1 X80.962 Y77.32 E.00211
G1 X80.907 Y77.434 E.0008
; LINE_WIDTH: 0.1026
G1 X80.857 Y77.598 E.00066
; WIPE_START
G1 X80.907 Y77.434 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X88.295 Y79.352 Z3.72 F18000
G1 X96.743 Y81.544 Z3.72
G1 Z3.32
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X97.257 Y81.544 E.01086
G1 X97.257 Y82.057 E.01086
G1 X96.743 Y82.057 E.01086
G1 X96.743 Y81.604 E.00959
M204 S10000
G1 X96.319 Y81.12 F18000
G1 F1500
M204 S500
G1 X97.681 Y81.12 E.02882
G1 X97.681 Y82.482 E.02882
G1 X96.319 Y82.482 E.02882
G1 X96.319 Y81.18 E.02755
M204 S250
G1 X95.91 Y80.711 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X98.09 Y80.711 E.04288
G1 X98.09 Y82.891 E.04288
G1 X95.91 Y82.891 E.04288
G1 X95.91 Y80.771 E.0417
; CHANGE_LAYER
; Z_HEIGHT: 3.44
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F1500
M204 S6000
G1 X97.909 Y80.716 E-.38
; WIPE_END
G1 E-.02 F1800
; layer num/total_layer_count: 28/49
; update layer progress
M73 L28
M991 S0 P27 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z3.72 I-1.075 J-.57 P1  F18000
G1 X89.213 Y97.114 Z3.72
G1 Z3.44
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X89.113 Y97.064 E.00235
G1 X88.58 Y96.908 E.01177
G1 X87.945 Y96.853 E.01348
G1 X87.329 Y96.927 E.01312
G1 X86.766 Y97.11 E.01255
G1 X86.659 Y96.949 E.0041
G1 X87.011 Y96.544 E.01137
G1 X88.989 Y96.543 E.04185
G1 X89.341 Y96.948 E.01136
G1 X89.25 Y97.066 E.00315
; WIPE_START
M204 S6000
G1 X89.113 Y97.064 E-.02589
G1 X88.58 Y96.908 E-.10565
G1 X87.945 Y96.853 E-.12104
G1 X87.329 Y96.927 E-.1178
G1 X87.281 Y96.943 E-.00962
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X90.617 Y99.848 Z3.84 F18000
G1 Z3.44
G1 E.4 F1800
G1 F1500
M204 S500
G1 X90.622 Y99.901 E.00113
G1 X90.579 Y100.375 E.01007
G1 X90.422 Y100.903 E.01166
G1 X90.169 Y101.374 E.01132
G1 X89.868 Y101.741 E.01005
G1 X89.505 Y102.048 E.01005
G1 X89.038 Y102.308 E.01132
G1 X88.513 Y102.473 E.01166
G1 X88.034 Y102.523 E.01018
G1 X87.502 Y102.475 E.01132
G1 X86.975 Y102.314 E.01166
G1 X86.556 Y102.089 E.01007
G1 X86.188 Y101.796 E.00995
G1 X85.879 Y101.442 E.00995
G1 X85.638 Y101.039 E.00994
G1 X85.476 Y100.607 E.00975
G1 X85.409 Y100.292 E.00683
G1 X85.38 Y99.97 E.00683
G1 X85.408 Y99.505 E.00985
G1 X85.542 Y98.988 E.01132
G1 X85.787 Y98.494 E.01166
G1 X86.082 Y98.113 E.0102
G1 X86.498 Y97.752 E.01166
G1 X86.965 Y97.492 E.01132
G1 X87.421 Y97.343 E.01015
G1 X87.952 Y97.28 E.01132
G1 X88.501 Y97.327 E.01166
G1 X88.958 Y97.46 E.01007
G1 X89.37 Y97.666 E.00975
G1 X89.634 Y97.852 E.00683
G1 X89.874 Y98.068 E.00683
G1 X90.16 Y98.417 E.00955
G1 X90.326 Y98.694 E.00683
G1 X90.457 Y98.989 E.00683
G1 X90.58 Y99.433 E.00975
G1 X90.612 Y99.788 E.00755
M204 S250
G1 X90.209 Y99.884 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X90.211 Y99.901 E.00032
G1 X90.175 Y100.298 E.00783
G1 X90.042 Y100.746 E.00921
G1 X89.828 Y101.145 E.0089
G1 X89.575 Y101.452 E.00783
G1 X89.271 Y101.71 E.00783
G1 X88.876 Y101.93 E.0089
G1 X88.429 Y102.07 E.00921
G1 X88.031 Y102.112 E.00787
G1 X87.581 Y102.071 E.0089
G1 X87.133 Y101.935 E.00921
G1 X86.782 Y101.746 E.00784
G1 X86.472 Y101.499 E.0078
G1 X86.211 Y101.2 E.0078
G1 X86.008 Y100.86 E.00779
G1 X85.87 Y100.492 E.00774
G1 X85.814 Y100.23 E.00526
G1 X85.79 Y99.964 E.00526
G1 X85.814 Y99.57 E.00777
G1 X85.928 Y99.132 E.0089
G1 X86.136 Y98.712 E.0092
G1 X86.381 Y98.396 E.00788
G1 X86.734 Y98.089 E.00921
G1 X87.13 Y97.868 E.0089
G1 X87.509 Y97.745 E.00786
G1 X87.959 Y97.691 E.00891
G1 X88.425 Y97.731 E.00921
G1 X88.808 Y97.843 E.00783
G1 X89.159 Y98.019 E.00773
G1 X89.378 Y98.173 E.00526
G1 X89.577 Y98.352 E.00526
G1 X89.825 Y98.653 E.00767
G1 X89.962 Y98.883 E.00526
G1 X90.071 Y99.127 E.00526
G1 X90.175 Y99.506 E.00774
G1 X90.204 Y99.825 E.00629
; WIPE_START
M204 S6000
G1 X90.211 Y99.901 E-.01454
G1 X90.175 Y100.298 E-.07567
G1 X90.042 Y100.746 E-.08895
G1 X89.828 Y101.145 E-.086
G1 X89.575 Y101.452 E-.07562
G1 X89.417 Y101.586 E-.03922
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X86.761 Y96.119 Z3.84 F18000
G1 Z3.44
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X94.114 Y96.118 E.15565
G1 X94.406 Y96.044 E.00637
G1 X94.667 Y95.881 E.00652
G1 X94.876 Y95.637 E.00679
G1 X95.008 Y95.317 E.00733
G1 X95.013 Y94.72 E.01263
G1 X95.381 Y94.72 E.00778
G1 X95.381 Y95.565 E.01788
G1 X95.353 Y95.803 E.00508
G1 X95.28 Y96.003 E.0045
G1 X95.209 Y96.118 E.00286
G1 X95.057 Y96.279 E.00469
G1 X94.947 Y96.356 E.00286
G1 X94.751 Y96.441 E.0045
G1 X94.533 Y96.479 E.0047
G1 X89.498 Y96.483 E.10657
G1 X90.683 Y97.845 E.03822
G1 X91 Y98.345 E.01253
G1 X91.167 Y98.72 E.00869
G1 X91.324 Y99.291 E.01253
G1 X91.38 Y99.881 E.01254
G1 X91.357 Y100.294 E.00876
G1 X91.236 Y100.877 E.0126
G1 X91.096 Y101.256 E.00855
G1 X90.91 Y101.621 E.00868
G1 X90.558 Y102.11 E.01273
G1 X90.292 Y102.385 E.00811
G1 X89.974 Y102.644 E.00869
G1 X89.635 Y102.859 E.00849
G1 X89.273 Y103.032 E.0085
G1 X88.884 Y103.164 E.00869
G1 X88.301 Y103.267 E.01254
G1 X87.9 Y103.279 E.00849
G1 X87.5 Y103.243 E.00849
G1 X87.098 Y103.159 E.00869
G1 X86.544 Y102.951 E.01253
G1 X86.193 Y102.757 E.00849
G1 X85.867 Y102.522 E.0085
G1 X85.571 Y102.251 E.00849
G1 X85.31 Y101.947 E.00849
G1 X85.086 Y101.613 E.0085
G1 X84.832 Y101.079 E.01253
G1 X84.714 Y100.69 E.00858
G1 X84.636 Y100.204 E.01042
G1 X84.628 Y99.683 E.01103
G1 X84.676 Y99.291 E.00837
G1 X84.771 Y98.902 E.00849
G1 X84.913 Y98.526 E.0085
G1 X85.097 Y98.17 E.00849
G1 X85.323 Y97.838 E.00849
G1 X86.503 Y96.482 E.03805
G1 X81.536 Y96.482 E.10512
G1 X81.289 Y96.453 E.00527
G1 X81.143 Y96.405 E.00324
G1 X80.98 Y96.31 E.00401
G1 X80.792 Y96.122 E.00562
G1 X80.743 Y96.048 E.00187
G1 X80.649 Y95.821 E.00521
G1 X80.619 Y95.565 E.00546
G1 X80.619 Y77.619 E.37984
G1 X80.658 Y77.349 E.00577
G1 X80.761 Y77.125 E.0052
G1 X80.952 Y76.914 E.00602
G1 X81.203 Y76.774 E.00611
G1 X81.455 Y76.723 E.00543
G1 X94.518 Y76.722 E.27649
G1 X94.657 Y76.736 E.00297
G1 X94.875 Y76.806 E.00485
G1 X94.983 Y76.866 E.00261
G1 X95.165 Y77.027 E.00513
G1 X95.283 Y77.208 E.00457
G1 X95.356 Y77.407 E.0045
G1 X95.378 Y77.559 E.00325
G1 X95.38 Y78.482 E.01952
G1 X95.019 Y78.482 E.00763
G1 X95.019 Y78.06 E.00893
G1 X94.988 Y77.826 E.00498
G1 X94.864 Y77.547 E.00646
G1 X94.661 Y77.315 E.00652
G1 X94.384 Y77.148 E.00684
G1 X94.093 Y77.082 E.00632
G1 X81.946 Y77.082 E.2571
G1 X81.657 Y77.132 E.0062
G1 X81.383 Y77.281 E.00661
G1 X81.157 Y77.514 E.00686
G1 X81.018 Y77.802 E.00678
G1 X80.981 Y78.056 E.00542
G1 X80.981 Y95.164 E.36211
G1 X81.05 Y95.501 E.00727
G1 X81.257 Y95.815 E.00796
G1 X81.591 Y96.049 E.00864
G1 X81.937 Y96.12 E.00747
G1 X86.701 Y96.119 E.10083
; WIPE_START
M204 S6000
G1 X88.701 Y96.119 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X85.604 Y96.891 Z3.84 F18000
G1 Z3.44
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X81.512 Y96.891 E.08049
G1 X81.2 Y96.854 E.00619
G1 X80.986 Y96.784 E.00442
G1 X80.855 Y96.718 E.00289
G1 X80.585 Y96.509 E.00672
G1 X80.385 Y96.248 E.00646
G1 X80.287 Y96.039 E.00454
G1 X80.247 Y95.904 E.00277
G1 X80.21 Y95.589 E.00625
G1 X80.21 Y77.607 E.35368
G1 X80.219 Y77.454 E.00301
G1 X80.265 Y77.231 E.00448
G1 X80.349 Y77.019 E.00448
G1 X80.421 Y76.895 E.00283
G1 X80.563 Y76.715 E.00451
G1 X80.697 Y76.593 E.00356
G1 X80.854 Y76.485 E.00377
G1 X81.06 Y76.389 E.00447
G1 X81.234 Y76.34 E.00355
G1 X81.427 Y76.313 E.00383
G1 X94.539 Y76.312 E.25789
G1 X94.725 Y76.331 E.0037
G1 X95.049 Y76.435 E.00669
G1 X95.209 Y76.524 E.00359
G1 X95.353 Y76.635 E.00358
G1 X95.485 Y76.769 E.0037
G1 X95.652 Y77.023 E.00597
G1 X95.755 Y77.307 E.00594
G1 X95.787 Y77.529 E.00442
G1 X95.79 Y78.891 E.02678
G1 X94.61 Y78.891 E.0232
G1 X94.61 Y78.087 E.01581
G1 X94.59 Y77.939 E.00294
G1 X94.515 Y77.77 E.00363
G1 X94.395 Y77.633 E.00358
G1 X94.229 Y77.533 E.00381
G1 X94.047 Y77.492 E.00368
G1 X81.982 Y77.491 E.23732
G1 X81.793 Y77.524 E.00376
G1 X81.633 Y77.611 E.00359
G1 X81.497 Y77.751 E.00384
G1 X81.414 Y77.924 E.00377
G1 X81.39 Y78.086 E.00322
G1 X81.39 Y95.122 E.3351
G1 X81.435 Y95.341 E.00439
G1 X81.556 Y95.524 E.00431
G1 X81.757 Y95.665 E.00483
G1 X81.979 Y95.711 E.00446
G1 X94.063 Y95.709 E.23769
G1 X94.243 Y95.663 E.00366
G1 X94.397 Y95.567 E.00357
G1 X94.522 Y95.421 E.00378
G1 X94.599 Y95.234 E.00397
G1 X94.608 Y94.311 E.01816
G1 X95.79 Y94.311 E.02325
G1 X95.79 Y95.589 E.02513
G1 X95.754 Y95.898 E.00613
G1 X95.65 Y96.182 E.00594
G1 X95.536 Y96.368 E.0043
G1 X95.326 Y96.59 E.006
G1 X95.147 Y96.716 E.0043
G1 X94.87 Y96.835 E.00595
G1 X94.569 Y96.888 E.00601
G1 X90.396 Y96.891 E.08208
G1 X91.004 Y97.59 E.01822
G1 X91.132 Y97.767 E.0043
G1 X91.364 Y98.156 E.00891
G1 X91.548 Y98.57 E.00891
G1 X91.619 Y98.777 E.00431
G1 X91.727 Y99.217 E.00891
G1 X91.783 Y99.667 E.00891
G1 X91.79 Y99.886 E.0043
G1 X91.764 Y100.339 E.00894
G1 X91.712 Y100.656 E.00632
G1 X91.628 Y100.997 E.00691
G1 X91.472 Y101.42 E.00887
G1 X91.266 Y101.824 E.00891
G1 X91.149 Y102.009 E.00431
G1 X90.873 Y102.372 E.00897
G1 X90.565 Y102.691 E.00873
G1 X90.213 Y102.977 E.00891
G1 X89.833 Y103.218 E.00885
G1 X89.427 Y103.412 E.00885
G1 X88.998 Y103.557 E.00891
G1 X88.785 Y103.608 E.0043
G1 X88.337 Y103.676 E.00891
G1 X87.887 Y103.689 E.00885
G1 X87.439 Y103.649 E.00885
G1 X86.996 Y103.555 E.00891
G1 X86.787 Y103.491 E.0043
G1 X86.367 Y103.321 E.00891
G1 X85.973 Y103.103 E.00885
G1 X85.608 Y102.84 E.00885
G1 X85.277 Y102.536 E.00885
G1 X84.983 Y102.195 E.00885
G1 X84.733 Y101.821 E.00885
G1 X84.527 Y101.417 E.00891
G1 X84.445 Y101.215 E.0043
G1 X84.314 Y100.783 E.00888
G1 X84.228 Y100.24 E.0108
G1 X84.218 Y99.662 E.01138
G1 X84.273 Y99.217 E.00881
G1 X84.38 Y98.78 E.00885
G1 X84.538 Y98.359 E.00885
G1 X84.745 Y97.96 E.00885
G1 X84.998 Y97.588 E.00885
G1 X85.565 Y96.936 E.01698
; WIPE_START
M204 S6000
G1 X83.565 Y96.914 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G17
G3 Z3.84 I1.217 J0 P1  F18000
;===================== date: 20250206 =====================

; don't support timelapse gcode in spiral_mode and by object sequence for I3 structure printer
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
G92 E0
G1 Z3.84
G1 X0 Y90 ; move to safe pos
G1 X-13.0 F3000 ; move to safe pos
M400
M1004 S5 P1  ; external shutter
M400 P300
M971 S11 C11 O0
G92 E0
G1 X0 F18000
M623

; SKIPTYPE: head_wrap_detect
M622.1 S1
M1002 judge_flag g39_3rd_layer_detect_flag
M622 J1
    ; enable nozzle clog detect at 3rd layer
    


    M622.1 S1
    M1002 judge_flag g39_detection_flag
    M622 J1
      
        M622.1 S0
        M1002 judge_flag g39_mass_exceed_flag
        M622 J1
        
            G392 S0
            M400
            G90
            M83
            M204 S5000
            G0 Z3.84 F4000
            G39.3 S1
            G0 Z3.84 F4000
            G392 S0
          
        M623
    
    M623
M623
; SKIPPABLE_END




G1 X81.456 Y96.238
G1 Z3.44
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.0962611
G1 F1500
M204 S6000
G1 X81.354 Y96.193 E.00039
; LINE_WIDTH: 0.149496
G1 X81.251 Y96.148 E.00069
M73 P74 R6
G1 X81.066 Y96.017 E.0014
G1 X80.844 Y95.655 E.00262
; WIPE_START
G1 X81.066 Y96.017 E-.21117
G1 X81.251 Y96.148 E-.11311
G1 X81.354 Y96.193 E-.05572
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X86.549 Y97.168 Z3.84 F18000
G1 Z3.44
G1 E.4 F1800
; LINE_WIDTH: 0.470538
G1 F1500
M204 S6000
G1 X86.272 Y97.392 E.00791
; LINE_WIDTH: 0.44425
G1 X86.24 Y97.421 E.0009
; LINE_WIDTH: 0.418058
G1 X86.03 Y97.632 E.00583
; LINE_WIDTH: 0.361741
G1 X85.797 Y97.866 E.00554
G1 X85.628 Y98.073 E.00448
G1 X85.425 Y98.365 E.00597
G1 X85.196 Y98.841 E.00885
G1 X85.052 Y99.36 E.00903
G1 X85.012 Y99.704 E.0058
G1 X85.016 Y100.171 E.00784
G1 X85.086 Y100.605 E.00737
G1 X85.193 Y100.946 E.00599
G1 X85.419 Y101.42 E.00881
G1 X85.613 Y101.716 E.00593
G1 X85.939 Y102.078 E.00816
G1 X86.36 Y102.412 E.00902
G1 X86.816 Y102.654 E.00865
G1 X87.413 Y102.841 E.01049
G1 X87.911 Y102.896 E.00839
G1 X88.264 Y102.884 E.00593
; LINE_WIDTH: 0.360535
G1 X88.604 Y102.835 E.00573
G1 X89.129 Y102.679 E.00915
G1 X89.448 Y102.521 E.00594
G1 X89.752 Y102.336 E.00594
G1 X90.035 Y102.101 E.00615
G1 X90.263 Y101.864 E.0055
G1 X90.578 Y101.426 E.00899
G1 X90.777 Y101.031 E.0074
G1 X90.865 Y100.767 E.00465
G1 X90.975 Y100.251 E.00881
G1 X90.996 Y99.886 E.0061
G1 X90.952 Y99.359 E.00883
G1 X90.814 Y98.874 E.00843
G1 X90.663 Y98.52 E.00642
G1 X90.379 Y98.08 E.00875
G1 X90.139 Y97.797 E.00619
; LINE_WIDTH: 0.382503
G1 X89.876 Y97.53 E.00667
; LINE_WIDTH: 0.426927
G1 X89.751 Y97.417 E.00337
; LINE_WIDTH: 0.468056
G1 X89.626 Y97.305 E.00372
G1 X89.603 Y97.308 E.00051
; LINE_WIDTH: 0.442473
G1 X89.444 Y97.338 E.00337
; LINE_WIDTH: 0.415741
G1 X89.284 Y97.368 E.00315
; WIPE_START
G1 X89.444 Y97.338 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X94.53 Y96.242 Z3.84 F18000
G1 Z3.44
G1 E.4 F1800
; LINE_WIDTH: 0.104168
G1 F1500
M204 S6000
G1 X94.675 Y96.186 E.00061
; LINE_WIDTH: 0.153066
G1 X94.855 Y96.085 E.00131
G1 X95.03 Y95.882 E.0017
; LINE_WIDTH: 0.132432
G1 X95.091 Y95.777 E.00065
; LINE_WIDTH: 0.0966823
G1 X95.137 Y95.621 E.00058
; WIPE_START
G1 X95.091 Y95.777 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X95.114 Y88.145 Z3.84 F18000
G1 X95.145 Y77.604 Z3.84
G1 Z3.44
G1 E.4 F1800
; LINE_WIDTH: 0.100152
G1 F1500
M204 S6000
G1 X95.079 Y77.401 E.00079
; LINE_WIDTH: 0.132441
G1 X95.038 Y77.331 E.00043
; LINE_WIDTH: 0.158442
G1 X94.831 Y77.097 E.00206
; LINE_WIDTH: 0.131314
G1 X94.521 Y76.942 E.00183
; WIPE_START
G1 X94.831 Y77.097 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X87.199 Y77.015 Z3.84 F18000
G1 X81.495 Y76.953 Z3.84
G1 Z3.44
G1 E.4 F1800
; LINE_WIDTH: 0.0923103
G1 F1500
M204 S6000
G1 X81.395 Y76.989 E.00035
; LINE_WIDTH: 0.129966
G1 X81.196 Y77.079 E.00113
; LINE_WIDTH: 0.153167
G1 X80.964 Y77.321 E.00213
G1 X80.911 Y77.423 E.00073
; LINE_WIDTH: 0.100944
G1 X80.854 Y77.603 E.00071
; WIPE_START
G1 X80.911 Y77.423 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X88.297 Y79.346 Z3.84 F18000
G1 X96.743 Y81.544 Z3.84
G1 Z3.44
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X97.257 Y81.544 E.01086
G1 X97.257 Y82.057 E.01086
G1 X96.743 Y82.057 E.01086
G1 X96.743 Y81.604 E.00959
M204 S10000
G1 X96.319 Y81.12 F18000
G1 F1500
M204 S500
G1 X97.681 Y81.12 E.02882
G1 X97.681 Y82.482 E.02882
G1 X96.319 Y82.482 E.02882
G1 X96.319 Y81.18 E.02755
M204 S250
G1 X95.91 Y80.711 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X98.09 Y80.711 E.04288
G1 X98.09 Y82.891 E.04288
G1 X95.91 Y82.891 E.04288
G1 X95.91 Y80.771 E.0417
; CHANGE_LAYER
; Z_HEIGHT: 3.56
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F1500
M204 S6000
G1 X97.909 Y80.716 E-.38
; WIPE_END
G1 E-.02 F1800
; layer num/total_layer_count: 29/49
; update layer progress
M73 L29
M991 S0 P28 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z3.84 I-1.073 J-.574 P1  F18000
G1 X89.161 Y97.078 Z3.84
G1 Z3.56
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X88.579 Y96.908 E.01282
G1 X87.942 Y96.853 E.01354
G1 X87.329 Y96.927 E.01306
G1 X86.766 Y97.11 E.01254
G1 X86.659 Y96.949 E.0041
G1 X87.011 Y96.544 E.01137
G1 X88.921 Y96.543 E.04042
G1 X89.263 Y96.913 E.01066
G1 X89.192 Y97.027 E.00283
; WIPE_START
M204 S6000
G1 X88.579 Y96.908 E-.11864
G1 X87.942 Y96.853 E-.12157
G1 X87.329 Y96.927 E-.11727
G1 X87.216 Y96.964 E-.02252
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X90.617 Y99.848 Z3.96 F18000
G1 Z3.56
G1 E.4 F1800
G1 F1500
M204 S500
G1 X90.622 Y99.901 E.00113
G1 X90.58 Y100.369 E.00995
G1 X90.453 Y100.826 E.01005
G1 X90.215 Y101.303 E.01126
G1 X89.872 Y101.737 E.01172
G1 X89.506 Y102.048 E.01017
G1 X89.041 Y102.307 E.01126
G1 X88.513 Y102.473 E.01172
G1 X88.035 Y102.523 E.01018
G1 X87.505 Y102.475 E.01126
G1 X86.975 Y102.315 E.01172
G1 X86.556 Y102.089 E.01008
G1 X86.188 Y101.796 E.00995
G1 X85.879 Y101.442 E.00995
G1 X85.638 Y101.038 E.00995
G1 X85.476 Y100.607 E.00975
G1 X85.409 Y100.291 E.00683
G1 X85.38 Y99.97 E.00683
G1 X85.408 Y99.506 E.00985
G1 X85.542 Y98.99 E.01126
G1 X85.787 Y98.494 E.01172
G1 X86.078 Y98.118 E.01008
G1 X86.42 Y97.809 E.00975
G1 X86.69 Y97.632 E.00683
G1 X86.978 Y97.487 E.00683
G1 X87.421 Y97.344 E.00984
G1 X87.949 Y97.28 E.01127
G1 X88.501 Y97.327 E.01172
G1 X88.958 Y97.46 E.01007
G1 X89.37 Y97.666 E.00975
G1 X89.634 Y97.852 E.00683
G1 X89.867 Y98.062 E.00663
G1 X90.073 Y98.298 E.00664
G1 X90.255 Y98.565 E.00683
G1 X90.455 Y98.98 E.00975
G1 X90.58 Y99.433 E.00995
G1 X90.612 Y99.788 E.00755
M204 S250
G1 X90.209 Y99.884 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X90.211 Y99.901 E.00033
G1 X90.175 Y100.296 E.00779
G1 X90.069 Y100.679 E.00783
G1 X89.868 Y101.082 E.00885
G1 X89.577 Y101.451 E.00926
G1 X89.271 Y101.71 E.00787
G1 X88.878 Y101.929 E.00885
G1 X88.429 Y102.07 E.00925
G1 X88.031 Y102.112 E.00787
G1 X87.583 Y102.071 E.00885
G1 X87.133 Y101.935 E.00925
G1 X86.782 Y101.746 E.00784
G1 X86.472 Y101.499 E.0078
G1 X86.211 Y101.2 E.0078
G1 X86.008 Y100.86 E.0078
G1 X85.87 Y100.492 E.00773
G1 X85.814 Y100.23 E.00526
G1 X85.79 Y99.964 E.00526
G1 X85.814 Y99.57 E.00777
G1 X85.927 Y99.134 E.00885
G1 X86.136 Y98.712 E.00925
G1 X86.379 Y98.397 E.00784
G1 X86.671 Y98.134 E.00773
G1 X86.895 Y97.987 E.00526
G1 X87.134 Y97.867 E.00526
G1 X87.509 Y97.745 E.00776
G1 X87.956 Y97.691 E.00886
G1 X88.425 Y97.731 E.00926
G1 X88.808 Y97.843 E.00783
G1 X89.159 Y98.019 E.00774
G1 X89.378 Y98.173 E.00526
G1 X89.575 Y98.35 E.0052
G1 X89.749 Y98.549 E.0052
G1 X89.899 Y98.77 E.00526
G1 X90.07 Y99.124 E.00774
G1 X90.175 Y99.506 E.0078
G1 X90.204 Y99.825 E.00629
; WIPE_START
M204 S6000
G1 X90.211 Y99.901 E-.01454
G1 X90.175 Y100.296 E-.07529
G1 X90.069 Y100.679 E-.07562
G1 X89.868 Y101.082 E-.08553
G1 X89.577 Y101.451 E-.0894
G1 X89.417 Y101.586 E-.03961
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X86.761 Y96.119 Z3.96 F18000
G1 Z3.56
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X94.115 Y96.118 E.15565
G1 X94.406 Y96.044 E.00635
G1 X94.667 Y95.881 E.00652
G1 X94.877 Y95.636 E.00682
G1 X95.008 Y95.316 E.00731
G1 X95.013 Y94.72 E.01262
G1 X95.381 Y94.72 E.00778
G1 X95.381 Y95.565 E.01788
G1 X95.353 Y95.803 E.00508
G1 X95.28 Y96.003 E.0045
G1 X95.208 Y96.12 E.00292
G1 X95.079 Y96.26 E.00402
G1 X94.943 Y96.358 E.00355
G1 X94.751 Y96.441 E.00441
G1 X94.533 Y96.479 E.0047
G1 X89.442 Y96.483 E.10774
G1 X90.544 Y97.675 E.03436
G1 X90.795 Y98 E.00869
G1 X91.084 Y98.517 E.01254
G1 X91.229 Y98.901 E.00868
G1 X91.324 Y99.291 E.00849
G1 X91.374 Y99.699 E.00869
G1 X91.357 Y100.294 E.01262
G1 X91.236 Y100.877 E.0126
G1 X91.096 Y101.256 E.00854
G1 X90.91 Y101.622 E.00869
G1 X90.558 Y102.11 E.01273
G1 X90.439 Y102.241 E.00376
G1 X90.068 Y102.572 E.01052
G1 X89.629 Y102.862 E.01113
G1 X89.273 Y103.032 E.00836
G1 X88.884 Y103.164 E.00869
G1 X88.301 Y103.267 E.01254
G1 X87.9 Y103.279 E.00849
G1 X87.5 Y103.243 E.00849
G1 X87.107 Y103.161 E.00849
G1 X86.727 Y103.032 E.00849
G1 X86.365 Y102.859 E.00849
G1 X86.026 Y102.644 E.0085
G1 X85.582 Y102.262 E.0124
G1 X85.241 Y101.85 E.01132
G1 X84.988 Y101.433 E.01032
G1 X84.829 Y101.07 E.00839
G1 X84.714 Y100.69 E.00839
G1 X84.637 Y100.209 E.01032
G1 X84.628 Y99.683 E.01113
G1 X84.676 Y99.291 E.00836
G1 X84.771 Y98.901 E.00849
G1 X84.913 Y98.526 E.00849
G1 X85.097 Y98.17 E.0085
G1 X85.323 Y97.838 E.00849
G1 X86.503 Y96.482 E.03805
G1 X81.536 Y96.482 E.10513
G1 X81.208 Y96.43 E.00704
G1 X80.982 Y96.312 E.00539
G1 X80.861 Y96.204 E.00343
G1 X80.761 Y96.076 E.00343
G1 X80.647 Y95.803 E.00627
G1 X80.619 Y95.565 E.00508
G1 X80.619 Y77.619 E.37984
G1 X80.659 Y77.349 E.00577
G1 X80.765 Y77.117 E.0054
G1 X80.935 Y76.928 E.00539
G1 X81.17 Y76.787 E.0058
G1 X81.294 Y76.747 E.00276
G1 X81.458 Y76.723 E.0035
G1 X94.519 Y76.722 E.27646
G1 X94.657 Y76.736 E.00293
G1 X94.903 Y76.819 E.00549
G1 X94.983 Y76.866 E.00197
G1 X95.16 Y77.021 E.00498
G1 X95.277 Y77.19 E.00435
G1 X95.356 Y77.407 E.00488
G1 X95.378 Y77.559 E.00325
G1 X95.38 Y78.482 E.01952
G1 X95.019 Y78.482 E.00763
G1 X95.019 Y78.056 E.009
G1 X94.984 Y77.811 E.00524
G1 X94.86 Y77.54 E.00631
G1 X94.644 Y77.3 E.00683
G1 X94.359 Y77.139 E.00693
G1 X94.087 Y77.082 E.00587
G1 X81.946 Y77.082 E.25699
G1 X81.657 Y77.133 E.0062
G1 X81.382 Y77.281 E.00661
G1 X81.157 Y77.515 E.00688
G1 X81.018 Y77.803 E.00676
G1 X80.981 Y78.056 E.00542
G1 X80.981 Y95.159 E.36201
G1 X81.041 Y95.478 E.00687
G1 X81.252 Y95.811 E.00835
G1 X81.591 Y96.049 E.00876
G1 X81.937 Y96.12 E.00747
G1 X86.701 Y96.119 E.10084
; WIPE_START
M204 S6000
G1 X88.701 Y96.119 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X85.605 Y96.891 Z3.96 F18000
G1 Z3.56
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X81.512 Y96.891 E.08049
G1 X81.197 Y96.854 E.00625
G1 X81.062 Y96.814 E.00277
G1 X80.853 Y96.716 E.00454
G1 X80.732 Y96.637 E.00283
G1 X80.562 Y96.486 E.00448
G1 X80.421 Y96.307 E.00448
G1 X80.351 Y96.185 E.00277
G1 X80.246 Y95.898 E.006
G1 X80.21 Y95.589 E.00613
G1 X80.21 Y77.607 E.35368
G1 X80.219 Y77.454 E.00301
G1 X80.265 Y77.231 E.00448
G1 X80.349 Y77.019 E.00448
G1 X80.423 Y76.892 E.00289
G1 X80.51 Y76.774 E.00289
G1 X80.671 Y76.613 E.00448
G1 X80.857 Y76.484 E.00445
G1 X81.018 Y76.406 E.00352
G1 X81.202 Y76.347 E.0038
G1 X81.428 Y76.313 E.0045
G1 X94.54 Y76.312 E.2579
G1 X94.725 Y76.331 E.00366
G1 X94.867 Y76.365 E.00286
G1 X95.081 Y76.45 E.00454
G1 X95.209 Y76.523 E.00289
G1 X95.467 Y76.749 E.00675
G1 X95.649 Y77.017 E.00637
G1 X95.755 Y77.307 E.00607
G1 X95.787 Y77.529 E.00442
G1 X95.79 Y78.891 E.02678
G1 X94.61 Y78.891 E.0232
G1 X94.61 Y78.086 E.01583
G1 X94.587 Y77.928 E.00313
G1 X94.514 Y77.768 E.00347
G1 X94.384 Y77.624 E.00381
G1 X94.213 Y77.527 E.00387
G1 X94.045 Y77.492 E.00337
G1 X81.982 Y77.491 E.23728
G1 X81.793 Y77.524 E.00376
G1 X81.633 Y77.611 E.00359
G1 X81.497 Y77.752 E.00385
G1 X81.414 Y77.924 E.00376
G1 X81.39 Y78.086 E.00321
G1 X81.39 Y95.121 E.33506
G1 X81.429 Y95.325 E.00409
G1 X81.554 Y95.523 E.00461
G1 X81.757 Y95.665 E.00486
G1 X81.979 Y95.711 E.00446
G1 X94.063 Y95.709 E.2377
G1 X94.243 Y95.663 E.00365
G1 X94.397 Y95.567 E.00357
G1 X94.523 Y95.42 E.0038
G1 X94.599 Y95.234 E.00396
G1 X94.608 Y94.311 E.01816
G1 X95.79 Y94.311 E.02325
G1 X95.79 Y95.589 E.02513
G1 X95.754 Y95.898 E.00613
G1 X95.65 Y96.182 E.00594
G1 X95.535 Y96.369 E.00432
G1 X95.351 Y96.568 E.00532
G1 X95.146 Y96.716 E.00499
G1 X94.87 Y96.835 E.00592
G1 X94.569 Y96.888 E.00601
G1 X90.377 Y96.891 E.08245
G1 X90.857 Y97.411 E.01392
G1 X91.134 Y97.77 E.00891
G1 X91.366 Y98.159 E.00891
G1 X91.461 Y98.356 E.00431
G1 X91.62 Y98.78 E.00891
G1 X91.727 Y99.217 E.00885
G1 X91.783 Y99.667 E.00891
G1 X91.79 Y99.886 E.0043
G1 X91.764 Y100.339 E.00894
G1 X91.713 Y100.652 E.00623
G1 X91.628 Y100.997 E.007
G1 X91.472 Y101.42 E.00886
G1 X91.266 Y101.824 E.00891
G1 X91.149 Y102.009 E.00431
G1 X90.873 Y102.372 E.00897
G1 X90.727 Y102.533 E.00427
G1 X90.318 Y102.897 E.01077
G1 X89.831 Y103.219 E.01148
G1 X89.427 Y103.412 E.00881
G1 X88.998 Y103.557 E.00891
M73 P75 R6
G1 X88.785 Y103.608 E.0043
G1 X88.337 Y103.676 E.00891
G1 X87.887 Y103.689 E.00885
G1 X87.439 Y103.649 E.00885
G1 X86.999 Y103.556 E.00885
G1 X86.573 Y103.412 E.00885
G1 X86.167 Y103.218 E.00885
G1 X85.787 Y102.977 E.00885
G1 X85.435 Y102.691 E.00891
G1 X85.28 Y102.54 E.00426
G1 X84.907 Y102.087 E.01154
G1 X84.624 Y101.622 E.01071
G1 X84.444 Y101.212 E.00882
G1 X84.314 Y100.783 E.00882
G1 X84.228 Y100.245 E.01071
G1 X84.218 Y99.662 E.01148
G1 X84.273 Y99.217 E.00881
G1 X84.38 Y98.78 E.00885
G1 X84.538 Y98.359 E.00885
G1 X84.745 Y97.96 E.00885
G1 X84.998 Y97.588 E.00885
G1 X85.565 Y96.936 E.01698
; WIPE_START
M204 S6000
G1 X83.565 Y96.914 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G17
G3 Z3.96 I1.217 J0 P1  F18000
;===================== date: 20250206 =====================

; don't support timelapse gcode in spiral_mode and by object sequence for I3 structure printer
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
G92 E0
G1 Z3.96
G1 X0 Y90 ; move to safe pos
G1 X-13.0 F3000 ; move to safe pos
M400
M1004 S5 P1  ; external shutter
M400 P300
M971 S11 C11 O0
G92 E0
G1 X0 F18000
M623

; SKIPTYPE: head_wrap_detect
M622.1 S1
M1002 judge_flag g39_3rd_layer_detect_flag
M622 J1
    ; enable nozzle clog detect at 3rd layer
    


    M622.1 S1
    M1002 judge_flag g39_detection_flag
    M622 J1
      
        M622.1 S0
        M1002 judge_flag g39_mass_exceed_flag
        M622 J1
        
            G392 S0
            M400
            G90
            M83
            M204 S5000
            G0 Z3.96 F4000
            G39.3 S1
            G0 Z3.96 F4000
            G392 S0
          
        M623
    
    M623
M623
; SKIPPABLE_END




G1 X81.442 Y96.257
G1 Z3.56
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.148826
G1 F1500
M204 S6000
G1 X81.193 Y96.113 E.00176
G1 X81.06 Y96.012 E.00103
G1 X80.974 Y95.89 E.00091
G1 X80.848 Y95.635 E.00175
; WIPE_START
G1 X80.974 Y95.89 E-.12184
G1 X81.06 Y96.012 E-.06361
G1 X81.193 Y96.113 E-.07173
G1 X81.442 Y96.257 E-.12283
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X86.548 Y97.165 Z3.96 F18000
G1 Z3.56
G1 E.4 F1800
; LINE_WIDTH: 0.477095
G1 F1500
M204 S6000
G1 X86.367 Y97.319 E.00534
; LINE_WIDTH: 0.438363
G1 X86.16 Y97.496 E.00562
; LINE_WIDTH: 0.400576
G1 X85.986 Y97.673 E.00464
; LINE_WIDTH: 0.361359
G1 X85.628 Y98.073 E.00898
G1 X85.425 Y98.365 E.00596
G1 X85.195 Y98.843 E.00889
G1 X85.052 Y99.36 E.00898
G1 X85.012 Y99.703 E.00579
G1 X85.017 Y100.175 E.0079
G1 X85.086 Y100.605 E.00728
G1 X85.19 Y100.937 E.00583
G1 X85.326 Y101.257 E.00583
G1 X85.584 Y101.675 E.00821
G1 X85.918 Y102.057 E.00851
G1 X86.336 Y102.395 E.009
G1 X86.815 Y102.656 E.00914
G1 X87.209 Y102.788 E.00696
M73 P75 R5
G1 X87.557 Y102.864 E.00595
G1 X88.053 Y102.899 E.00834
G1 X88.606 Y102.839 E.0093
G1 X89.131 Y102.678 E.00921
G1 X89.439 Y102.526 E.00575
G1 X89.731 Y102.346 E.00575
G1 X90.156 Y101.988 E.0093
G1 X90.497 Y101.561 E.00914
G1 X90.745 Y101.1 E.00878
G1 X90.81 Y100.946 E.00279
G1 X90.949 Y100.451 E.00861
G1 X91.001 Y99.886 E.0095
G1 X90.951 Y99.357 E.00889
G1 X90.862 Y99.015 E.00592
G1 X90.733 Y98.673 E.00611
G1 X90.477 Y98.214 E.00881
G1 X90.252 Y97.922 E.00617
G1 X89.873 Y97.534 E.00907
; LINE_WIDTH: 0.415179
G1 X89.74 Y97.418 E.00343
; LINE_WIDTH: 0.45628
G1 X89.581 Y97.28 E.00452
; LINE_WIDTH: 0.484549
G1 X89.379 Y97.129 E.00578
; WIPE_START
G1 X89.581 Y97.28 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X94.53 Y96.242 Z3.96 F18000
G1 Z3.56
G1 E.4 F1800
; LINE_WIDTH: 0.104143
G1 F1500
M204 S6000
G1 X94.675 Y96.186 E.00061
; LINE_WIDTH: 0.150497
G1 X94.854 Y96.084 E.00128
G1 X95.032 Y95.878 E.00169
; LINE_WIDTH: 0.131675
G1 X95.092 Y95.775 E.00063
; LINE_WIDTH: 0.096422
G1 X95.137 Y95.621 E.00057
; WIPE_START
G1 X95.092 Y95.775 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X95.115 Y88.143 Z3.96 F18000
G1 X95.147 Y77.602 Z3.96
G1 Z3.56
G1 E.4 F1800
; LINE_WIDTH: 0.102785
G1 F1500
M204 S6000
G1 X95.074 Y77.391 E.00086
; LINE_WIDTH: 0.137893
G1 X95.026 Y77.311 E.00052
; LINE_WIDTH: 0.157039
G1 X94.948 Y77.212 E.00082
G1 X94.78 Y77.064 E.00146
; LINE_WIDTH: 0.130122
G1 X94.512 Y76.943 E.00153
; WIPE_START
G1 X94.78 Y77.064 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X87.148 Y77.001 Z3.96 F18000
G1 X81.494 Y76.954 Z3.96
G1 Z3.56
G1 E.4 F1800
; LINE_WIDTH: 0.100457
G1 F1500
M204 S6000
G1 X81.355 Y77 E.00055
; LINE_WIDTH: 0.148582
G1 X81.21 Y77.069 E.00098
G1 X81.118 Y77.146 E.00074
G1 X80.965 Y77.32 E.00142
G1 X80.911 Y77.423 E.00072
; LINE_WIDTH: 0.100881
G1 X80.854 Y77.603 E.00071
; WIPE_START
G1 X80.911 Y77.423 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X88.297 Y79.346 Z3.96 F18000
G1 X96.743 Y81.544 Z3.96
G1 Z3.56
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X97.257 Y81.544 E.01086
G1 X97.257 Y82.057 E.01086
G1 X96.743 Y82.057 E.01086
G1 X96.743 Y81.604 E.00959
M204 S10000
G1 X96.319 Y81.12 F18000
G1 F1500
M204 S500
G1 X97.681 Y81.12 E.02882
G1 X97.681 Y82.482 E.02882
G1 X96.319 Y82.482 E.02882
G1 X96.319 Y81.18 E.02755
M204 S250
G1 X95.91 Y80.711 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X98.09 Y80.711 E.04288
G1 X98.09 Y82.891 E.04288
G1 X95.91 Y82.891 E.04288
G1 X95.91 Y80.771 E.0417
; CHANGE_LAYER
; Z_HEIGHT: 3.68
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F1500
M204 S6000
G1 X97.909 Y80.716 E-.38
; WIPE_END
G1 E-.02 F1800
; layer num/total_layer_count: 30/49
; update layer progress
M73 L30
M991 S0 P29 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z3.96 I-1.073 J-.574 P1  F18000
G1 X89.161 Y97.078 Z3.96
G1 Z3.68
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X88.579 Y96.908 E.01283
G1 X87.939 Y96.853 E.0136
G1 X87.329 Y96.927 E.01301
G1 X86.765 Y97.11 E.01254
G1 X86.659 Y96.949 E.0041
G1 X87.011 Y96.544 E.01137
G1 X88.921 Y96.543 E.04042
G1 X89.263 Y96.913 E.01066
G1 X89.192 Y97.027 E.00283
; WIPE_START
M204 S6000
G1 X88.579 Y96.908 E-.11872
G1 X87.939 Y96.853 E-.12206
G1 X87.329 Y96.927 E-.11675
G1 X87.216 Y96.964 E-.02247
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X90.617 Y99.848 Z4.08 F18000
G1 Z3.68
G1 E.4 F1800
G1 F1500
M204 S500
G1 X90.622 Y99.907 E.00127
G1 X90.561 Y100.46 E.01177
G1 X90.397 Y100.963 E.01121
G1 X90.166 Y101.378 E.01004
G1 X89.868 Y101.741 E.00995
G1 X89.506 Y102.048 E.01004
G1 X89.043 Y102.306 E.01121
G1 X88.513 Y102.473 E.01177
G1 X88.039 Y102.522 E.01008
G1 X87.571 Y102.487 E.00995
G1 X87.11 Y102.367 E.01008
G1 X86.61 Y102.124 E.01177
G1 X86.191 Y101.799 E.01121
G1 X85.879 Y101.442 E.01004
G1 X85.638 Y101.039 E.00995
G1 X85.476 Y100.607 E.00976
G1 X85.409 Y100.291 E.00683
G1 X85.38 Y99.97 E.00683
G1 X85.408 Y99.506 E.00984
G1 X85.541 Y98.993 E.01121
G1 X85.787 Y98.494 E.01177
G1 X86.078 Y98.118 E.01008
G1 X86.42 Y97.809 E.00975
G1 X86.69 Y97.632 E.00683
G1 X86.978 Y97.487 E.00683
G1 X87.421 Y97.344 E.00984
G1 X87.947 Y97.28 E.01121
G1 X88.501 Y97.327 E.01177
G1 X88.958 Y97.46 E.01008
G1 X89.37 Y97.666 E.00975
G1 X89.634 Y97.852 E.00683
G1 X89.874 Y98.068 E.00683
G1 X90.17 Y98.429 E.00988
G1 X90.431 Y98.92 E.01177
G1 X90.579 Y99.428 E.01121
G1 X90.612 Y99.788 E.00764
M204 S250
G1 X90.209 Y99.884 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X90.211 Y99.903 E.00037
G1 X90.159 Y100.373 E.0093
G1 X90.02 Y100.799 E.00881
G1 X89.827 Y101.146 E.00783
G1 X89.575 Y101.452 E.0078
G1 X89.271 Y101.71 E.00783
G1 X88.881 Y101.928 E.0088
G1 X88.429 Y102.07 E.0093
G1 X88.033 Y102.111 E.00784
G1 X87.638 Y102.082 E.00779
G1 X87.252 Y101.982 E.00784
G1 X86.827 Y101.774 E.0093
G1 X86.473 Y101.5 E.00881
G1 X86.211 Y101.2 E.00783
G1 X86.008 Y100.86 E.00779
G1 X85.87 Y100.492 E.00774
G1 X85.814 Y100.23 E.00526
G1 X85.79 Y99.964 E.00526
G1 X85.814 Y99.57 E.00777
G1 X85.926 Y99.136 E.00881
G1 X86.136 Y98.712 E.0093
G1 X86.379 Y98.397 E.00784
G1 X86.672 Y98.134 E.00773
G1 X86.895 Y97.987 E.00526
G1 X87.134 Y97.867 E.00526
G1 X87.509 Y97.745 E.00776
G1 X87.954 Y97.691 E.00881
G1 X88.425 Y97.731 E.0093
G1 X88.808 Y97.843 E.00784
G1 X89.159 Y98.019 E.00773
G1 X89.378 Y98.173 E.00526
G1 X89.577 Y98.352 E.00526
G1 X89.828 Y98.657 E.00777
G1 X90.05 Y99.075 E.0093
G1 X90.175 Y99.505 E.00881
G1 X90.204 Y99.824 E.00631
; WIPE_START
M204 S6000
G1 X90.211 Y99.903 E-.01498
G1 X90.159 Y100.373 E-.08987
G1 X90.02 Y100.799 E-.08506
G1 X89.827 Y101.146 E-.0756
G1 X89.575 Y101.452 E-.07531
G1 X89.418 Y101.586 E-.03919
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X86.761 Y96.119 Z4.08 F18000
G1 Z3.68
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X94.116 Y96.118 E.15567
G1 X94.406 Y96.044 E.00634
G1 X94.668 Y95.881 E.00653
G1 X94.877 Y95.636 E.00682
G1 X95.008 Y95.317 E.0073
G1 X95.013 Y94.72 E.01263
G1 X95.381 Y94.72 E.00778
G1 X95.381 Y95.565 E.01788
G1 X95.353 Y95.803 E.00508
G1 X95.28 Y96.003 E.0045
G1 X95.208 Y96.12 E.00292
G1 X95.078 Y96.261 E.00405
G1 X94.943 Y96.358 E.00352
G1 X94.751 Y96.441 E.00441
G1 X94.533 Y96.479 E.0047
G1 X89.443 Y96.483 E.10774
G1 X90.544 Y97.675 E.03436
G1 X90.795 Y98 E.00869
G1 X91.084 Y98.517 E.01254
G1 X91.229 Y98.901 E.00868
G1 X91.326 Y99.3 E.00869
G1 X91.38 Y99.894 E.01262
G1 X91.328 Y100.496 E.01279
G1 X91.17 Y101.074 E.01267
G1 X90.915 Y101.611 E.01259
G1 X90.69 Y101.947 E.00855
G1 X90.429 Y102.251 E.00849
G1 X90.137 Y102.519 E.0084
G1 X89.74 Y102.796 E.01023
G1 X89.267 Y103.034 E.01122
G1 X88.884 Y103.164 E.00855
G1 X88.301 Y103.267 E.01254
G1 X87.9 Y103.279 E.00849
G1 X87.5 Y103.243 E.00849
G1 X87.107 Y103.161 E.00849
G1 X86.727 Y103.032 E.00849
G1 X86.369 Y102.861 E.00839
G1 X85.965 Y102.596 E.01023
G1 X85.567 Y102.246 E.01122
G1 X85.31 Y101.947 E.00836
G1 X85.089 Y101.617 E.0084
G1 X84.876 Y101.184 E.01023
G1 X84.713 Y100.684 E.01112
G1 X84.637 Y100.213 E.01009
G1 X84.628 Y99.683 E.01122
G1 X84.676 Y99.291 E.00836
G1 X84.771 Y98.901 E.00849
G1 X84.913 Y98.526 E.00849
G1 X85.097 Y98.17 E.0085
G1 X85.323 Y97.838 E.00849
G1 X86.503 Y96.482 E.03805
G1 X81.536 Y96.482 E.10512
G1 X81.289 Y96.453 E.00527
G1 X81.144 Y96.405 E.00324
G1 X80.98 Y96.31 E.004
G1 X80.792 Y96.123 E.00562
G1 X80.681 Y95.918 E.00492
G1 X80.649 Y95.817 E.00226
G1 X80.619 Y95.565 E.00537
G1 X80.619 Y77.619 E.37984
G1 X80.659 Y77.344 E.00587
G1 X80.764 Y77.12 E.00524
G1 X80.928 Y76.933 E.00526
G1 X81.061 Y76.84 E.00343
G1 X81.2 Y76.775 E.00324
G1 X81.449 Y76.723 E.00539
G1 X94.521 Y76.722 E.27668
G1 X94.657 Y76.736 E.0029
G1 X94.744 Y76.756 E.00188
G1 X94.968 Y76.857 E.0052
G1 X95.147 Y77.007 E.00495
G1 X95.28 Y77.197 E.00492
G1 X95.349 Y77.381 E.00415
G1 X95.378 Y77.563 E.00391
G1 X95.38 Y78.482 E.01943
G1 X95.019 Y78.482 E.00763
G1 X95.019 Y78.056 E.009
G1 X94.984 Y77.811 E.00525
G1 X94.86 Y77.54 E.0063
G1 X94.645 Y77.301 E.0068
G1 X94.359 Y77.139 E.00696
G1 X94.087 Y77.082 E.00588
G1 X81.946 Y77.082 E.25698
G1 X81.657 Y77.132 E.0062
G1 X81.382 Y77.281 E.00662
G1 X81.156 Y77.515 E.00689
G1 X81.018 Y77.803 E.00675
G1 X80.981 Y78.056 E.00541
G1 X80.981 Y95.155 E.36192
G1 X81.035 Y95.462 E.00659
G1 X81.249 Y95.809 E.00864
G1 X81.591 Y96.049 E.00884
G1 X81.937 Y96.12 E.00747
G1 X86.701 Y96.119 E.10083
; WIPE_START
M204 S6000
G1 X88.701 Y96.119 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X85.604 Y96.891 Z4.08 F18000
G1 Z3.68
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X81.512 Y96.891 E.08049
G1 X81.2 Y96.854 E.00619
G1 X80.986 Y96.784 E.00442
G1 X80.855 Y96.718 E.00289
G1 X80.583 Y96.506 E.00678
G1 X80.384 Y96.247 E.00641
G1 X80.299 Y96.069 E.00389
G1 X80.247 Y95.903 E.00343
G1 X80.21 Y95.589 E.00622
G1 X80.21 Y77.607 E.35368
G1 X80.219 Y77.454 E.00301
G1 X80.265 Y77.23 E.00451
G1 X80.328 Y77.064 E.00349
G1 X80.422 Y76.893 E.00383
G1 X80.564 Y76.714 E.0045
G1 X80.669 Y76.615 E.00283
G1 X80.855 Y76.484 E.00448
G1 X81.059 Y76.389 E.00442
G1 X81.279 Y76.33 E.00448
G1 X81.425 Y76.313 E.00289
G1 X94.542 Y76.312 E.258
G1 X94.725 Y76.331 E.00363
G1 X94.867 Y76.365 E.00286
G1 X95.081 Y76.45 E.00454
G1 X95.203 Y76.52 E.00277
G1 X95.44 Y76.719 E.00609
G1 X95.561 Y76.868 E.00377
G1 X95.65 Y77.019 E.00345
G1 X95.747 Y77.276 E.00539
G1 X95.788 Y77.531 E.00508
G1 X95.79 Y78.891 E.02676
G1 X94.61 Y78.891 E.0232
G1 X94.61 Y78.086 E.01584
G1 X94.587 Y77.928 E.00314
G1 X94.514 Y77.768 E.00347
G1 X94.385 Y77.624 E.00379
G1 X94.213 Y77.526 E.0039
G1 X94.045 Y77.492 E.00337
G1 X81.982 Y77.491 E.23728
G1 X81.793 Y77.524 E.00376
G1 X81.633 Y77.611 E.0036
G1 X81.497 Y77.752 E.00386
G1 X81.414 Y77.924 E.00375
G1 X81.39 Y78.086 E.00321
G1 X81.39 Y95.119 E.33504
G1 X81.424 Y95.314 E.00388
G1 X81.553 Y95.522 E.00482
G1 X81.757 Y95.665 E.00489
G1 X81.979 Y95.711 E.00446
G1 X94.064 Y95.709 E.23771
G1 X94.243 Y95.663 E.00364
G1 X94.397 Y95.567 E.00358
G1 X94.523 Y95.42 E.0038
M73 P76 R5
G1 X94.599 Y95.234 E.00395
G1 X94.608 Y94.311 E.01816
G1 X95.79 Y94.311 E.02325
G1 X95.79 Y95.589 E.02513
G1 X95.754 Y95.898 E.00613
G1 X95.651 Y96.182 E.00594
G1 X95.535 Y96.369 E.00432
G1 X95.35 Y96.569 E.00536
G1 X95.146 Y96.716 E.00496
G1 X94.87 Y96.835 E.00592
G1 X94.569 Y96.888 E.00601
G1 X90.377 Y96.891 E.08245
G1 X90.857 Y97.411 E.01392
G1 X91.134 Y97.77 E.00891
G1 X91.366 Y98.159 E.00891
G1 X91.461 Y98.356 E.00431
G1 X91.62 Y98.78 E.00891
G1 X91.728 Y99.22 E.00891
G1 X91.761 Y99.437 E.00431
G1 X91.79 Y99.89 E.00893
G1 X91.776 Y100.202 E.00614
G1 X91.732 Y100.563 E.00715
G1 X91.687 Y100.778 E.00432
G1 X91.555 Y101.213 E.00894
G1 X91.434 Y101.5 E.00614
G1 X91.268 Y101.82 E.00709
G1 X91.017 Y102.195 E.00887
G1 X90.723 Y102.536 E.00885
G1 X90.393 Y102.839 E.00882
G1 X89.95 Y103.148 E.01062
G1 X89.425 Y103.412 E.01157
G1 X88.998 Y103.557 E.00887
G1 X88.785 Y103.608 E.0043
G1 X88.337 Y103.676 E.00891
G1 X87.887 Y103.689 E.00885
G1 X87.439 Y103.649 E.00885
G1 X86.999 Y103.556 E.00885
G1 X86.573 Y103.412 E.00885
G1 X86.168 Y103.218 E.00882
G1 X85.717 Y102.923 E.01062
G1 X85.275 Y102.534 E.01156
G1 X84.983 Y102.195 E.00881
G1 X84.734 Y101.822 E.00882
G1 X84.495 Y101.338 E.01062
G1 X84.314 Y100.78 E.01153
G1 X84.228 Y100.249 E.01058
G1 X84.218 Y99.662 E.01157
G1 X84.273 Y99.217 E.00881
G1 X84.38 Y98.78 E.00885
G1 X84.538 Y98.359 E.00885
G1 X84.745 Y97.96 E.00885
G1 X84.998 Y97.588 E.00885
G1 X85.565 Y96.936 E.01698
; WIPE_START
M204 S6000
G1 X83.565 Y96.914 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G17
G3 Z4.08 I1.217 J0 P1  F18000
;===================== date: 20250206 =====================

; don't support timelapse gcode in spiral_mode and by object sequence for I3 structure printer
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
G92 E0
G1 Z4.08
G1 X0 Y90 ; move to safe pos
G1 X-13.0 F3000 ; move to safe pos
M400
M1004 S5 P1  ; external shutter
M400 P300
M971 S11 C11 O0
G92 E0
G1 X0 F18000
M623

; SKIPTYPE: head_wrap_detect
M622.1 S1
M1002 judge_flag g39_3rd_layer_detect_flag
M622 J1
    ; enable nozzle clog detect at 3rd layer
    


    M622.1 S1
    M1002 judge_flag g39_detection_flag
    M622 J1
      
        M622.1 S0
        M1002 judge_flag g39_mass_exceed_flag
        M622 J1
        
            G392 S0
            M400
            G90
            M83
            M204 S5000
            G0 Z4.08 F4000
            G39.3 S1
            G0 Z4.08 F4000
            G392 S0
          
        M623
    
    M623
M623
; SKIPPABLE_END




G1 X81.456 Y96.238
G1 Z3.68
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.0962552
G1 F1500
M204 S6000
G1 X81.354 Y96.193 E.00039
; LINE_WIDTH: 0.149097
G1 X81.251 Y96.148 E.00069
G1 X81.069 Y96.02 E.00137
G1 X80.937 Y95.822 E.00147
; LINE_WIDTH: 0.129456
G1 X80.899 Y95.723 E.00055
; LINE_WIDTH: 0.0951565
G1 X80.861 Y95.624 E.00037
; WIPE_START
G1 X80.899 Y95.723 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X86.547 Y97.165 Z4.08 F18000
G1 Z3.68
G1 E.4 F1800
; LINE_WIDTH: 0.477112
G1 F1500
M204 S6000
G1 X86.367 Y97.319 E.00533
; LINE_WIDTH: 0.438425
G1 X86.16 Y97.496 E.00561
; LINE_WIDTH: 0.400637
G1 X85.986 Y97.673 E.00464
; LINE_WIDTH: 0.361302
G1 X85.628 Y98.073 E.00898
G1 X85.425 Y98.365 E.00596
G1 X85.194 Y98.846 E.00893
G1 X85.052 Y99.36 E.00893
G1 X85.012 Y99.703 E.00578
G1 X85.017 Y100.179 E.00797
G1 X85.084 Y100.594 E.00703
G1 X85.23 Y101.04 E.00785
G1 X85.422 Y101.425 E.0072
G1 X85.613 Y101.716 E.00583
G1 X85.923 Y102.061 E.00776
G1 X86.398 Y102.433 E.0101
G1 X86.872 Y102.677 E.00892
G1 X87.209 Y102.79 E.00596
G1 X87.556 Y102.867 E.00596
G1 X88.059 Y102.898 E.00844
G1 X88.606 Y102.839 E.0092
G1 X89.121 Y102.681 E.00903
G1 X89.544 Y102.465 E.00793
G1 X89.732 Y102.346 E.00373
G1 X90.148 Y101.996 E.0091
G1 X90.385 Y101.714 E.00616
G1 X90.583 Y101.418 E.00597
G1 X90.808 Y100.941 E.00883
G1 X90.95 Y100.431 E.00886
G1 X91.001 Y99.896 E.009
G1 X90.954 Y99.369 E.00886
G1 X90.86 Y99.015 E.00612
G1 X90.734 Y98.673 E.00611
G1 X90.48 Y98.211 E.00882
G1 X90.157 Y97.815 E.00857
G1 X89.873 Y97.535 E.00668
; LINE_WIDTH: 0.415191
G1 X89.74 Y97.418 E.00343
; LINE_WIDTH: 0.456341
G1 X89.581 Y97.28 E.00453
; LINE_WIDTH: 0.484587
G1 X89.379 Y97.129 E.00578
; WIPE_START
G1 X89.581 Y97.28 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X94.53 Y96.242 Z4.08 F18000
G1 Z3.68
G1 E.4 F1800
; LINE_WIDTH: 0.104168
G1 F1500
M204 S6000
G1 X94.675 Y96.186 E.00061
; LINE_WIDTH: 0.150458
G1 X94.855 Y96.084 E.00129
G1 X95.032 Y95.878 E.00169
; LINE_WIDTH: 0.131668
G1 X95.092 Y95.775 E.00063
; LINE_WIDTH: 0.0964023
G1 X95.137 Y95.621 E.00056
; WIPE_START
G1 X95.092 Y95.775 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X95.115 Y88.143 Z4.08 F18000
G1 X95.145 Y77.598 Z4.08
G1 Z3.68
G1 E.4 F1800
; LINE_WIDTH: 0.103105
G1 F1500
M204 S6000
G1 X95.075 Y77.391 E.00085
; LINE_WIDTH: 0.152701
G1 X94.942 Y77.206 E.00144
G1 X94.78 Y77.065 E.00136
; LINE_WIDTH: 0.130261
G1 X94.512 Y76.943 E.00153
; WIPE_START
G1 X94.78 Y77.065 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X87.148 Y77.002 Z4.08 F18000
G1 X81.496 Y76.955 Z4.08
G1 Z3.68
G1 E.4 F1800
; LINE_WIDTH: 0.0895943
G1 F1500
M204 S6000
G1 X81.394 Y76.991 E.00035
; LINE_WIDTH: 0.125512
G1 X81.213 Y77.073 E.00099
; LINE_WIDTH: 0.152812
G1 X81.109 Y77.154 E.00084
G1 X80.998 Y77.277 E.00105
G1 X80.913 Y77.417 E.00104
; LINE_WIDTH: 0.101618
G1 X80.854 Y77.603 E.00074
; WIPE_START
G1 X80.913 Y77.417 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X88.298 Y79.342 Z4.08 F18000
G1 X96.743 Y81.544 Z4.08
G1 Z3.68
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X97.257 Y81.544 E.01086
G1 X97.257 Y82.057 E.01086
G1 X96.743 Y82.057 E.01086
G1 X96.743 Y81.604 E.00959
M204 S10000
G1 X96.319 Y81.12 F18000
G1 F1500
M204 S500
G1 X97.681 Y81.12 E.02882
G1 X97.681 Y82.482 E.02882
G1 X96.319 Y82.482 E.02882
G1 X96.319 Y81.18 E.02755
M204 S250
G1 X95.91 Y80.711 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X98.09 Y80.711 E.04288
G1 X98.09 Y82.891 E.04288
G1 X95.91 Y82.891 E.04288
G1 X95.91 Y80.771 E.0417
; CHANGE_LAYER
; Z_HEIGHT: 3.8
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F1500
M204 S6000
G1 X97.909 Y80.716 E-.38
; WIPE_END
G1 E-.02 F1800
; layer num/total_layer_count: 31/49
; update layer progress
M73 L31
M991 S0 P30 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z4.08 I-1.075 J-.57 P1  F18000
G1 X89.213 Y97.114 Z4.08
G1 Z3.8
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X89.113 Y97.064 E.00235
G1 X88.604 Y96.915 E.01123
G1 X88.231 Y96.865 E.00797
G1 X87.903 Y96.857 E.00694
G1 X87.328 Y96.927 E.01226
G1 X86.766 Y97.11 E.01253
G1 X86.659 Y96.949 E.0041
G1 X87.011 Y96.544 E.01137
G1 X88.988 Y96.543 E.04185
G1 X89.341 Y96.948 E.01136
G1 X89.249 Y97.066 E.00315
; WIPE_START
M204 S6000
G1 X89.113 Y97.064 E-.02586
G1 X88.604 Y96.915 E-.10077
G1 X88.231 Y96.865 E-.07155
G1 X87.903 Y96.857 E-.06232
G1 X87.328 Y96.927 E-.11005
G1 X87.281 Y96.943 E-.00946
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X90.617 Y99.848 Z4.2 F18000
G1 Z3.8
G1 E.4 F1800
G1 F1500
M204 S500
G1 X90.622 Y99.901 E.00112
G1 X90.58 Y100.369 E.00995
G1 X90.455 Y100.822 E.00995
G1 X90.255 Y101.237 E.00975
G1 X90.073 Y101.504 E.00683
G1 X89.861 Y101.747 E.00683
G1 X89.509 Y102.045 E.00976
G1 X89.11 Y102.275 E.00975
G1 X88.81 Y102.393 E.00683
G1 X88.497 Y102.474 E.00683
G1 X88.048 Y102.521 E.00956
G1 X87.726 Y102.507 E.00683
G1 X87.408 Y102.454 E.00684
G1 X86.97 Y102.312 E.00975
G1 X86.556 Y102.089 E.00994
G1 X86.188 Y101.796 E.00995
G1 X85.879 Y101.442 E.00995
G1 X85.643 Y101.047 E.00975
G1 X85.52 Y100.748 E.00683
G1 X85.434 Y100.437 E.00683
G1 X85.379 Y99.979 E.00975
G1 X85.408 Y99.506 E.01004
G1 X85.535 Y99.014 E.01074
G1 X85.64 Y98.762 E.00579
G1 X85.796 Y98.482 E.00678
G1 X86.078 Y98.118 E.00975
G1 X86.421 Y97.809 E.00976
G1 X86.69 Y97.632 E.00683
G1 X86.979 Y97.487 E.00683
G1 X87.42 Y97.344 E.00983
G1 X87.924 Y97.282 E.01075
G1 X88.198 Y97.288 E.00579
G1 X88.516 Y97.331 E.00679
G1 X88.958 Y97.46 E.00975
G1 X89.37 Y97.666 E.00975
G1 X89.634 Y97.852 E.00683
G1 X89.873 Y98.068 E.00683
G1 X90.16 Y98.417 E.00955
G1 X90.326 Y98.694 E.00683
G1 X90.457 Y98.989 E.00683
G1 X90.58 Y99.433 E.00975
G1 X90.612 Y99.788 E.00755
M204 S250
G1 X90.209 Y99.885 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X90.211 Y99.901 E.00032
G1 X90.175 Y100.296 E.00779
G1 X90.07 Y100.678 E.0078
G1 X89.899 Y101.032 E.00773
G1 X89.749 Y101.253 E.00526
G1 X89.573 Y101.454 E.00526
G1 X89.273 Y101.709 E.00774
G1 X88.932 Y101.905 E.00773
G1 X88.683 Y102.003 E.00526
G1 X88.424 Y102.07 E.00526
G1 X88.036 Y102.111 E.00767
G1 X87.769 Y102.099 E.00526
G1 X87.505 Y102.055 E.00527
G1 X87.131 Y101.934 E.00773
G1 X86.782 Y101.746 E.00779
G1 X86.472 Y101.499 E.0078
G1 X86.211 Y101.2 E.0078
G1 X86.01 Y100.863 E.00773
G1 X85.908 Y100.615 E.00526
G1 X85.837 Y100.357 E.00526
G1 X85.79 Y99.967 E.00773
G1 X85.814 Y99.57 E.00783
G1 X85.924 Y99.145 E.00863
G1 X86.009 Y98.941 E.00435
G1 X86.139 Y98.708 E.00524
G1 X86.379 Y98.397 E.00773
G1 X86.672 Y98.134 E.00774
G1 X86.895 Y97.987 E.00526
G1 X87.134 Y97.867 E.00526
G1 X87.509 Y97.745 E.00776
G1 X87.945 Y97.692 E.00863
G1 X88.166 Y97.697 E.00435
G1 X88.43 Y97.733 E.00525
G1 X88.808 Y97.843 E.00773
G1 X89.159 Y98.019 E.00773
G1 X89.378 Y98.173 E.00526
G1 X89.577 Y98.352 E.00526
G1 X89.825 Y98.653 E.00767
G1 X89.962 Y98.883 E.00526
G1 X90.071 Y99.127 E.00526
G1 X90.175 Y99.506 E.00774
G1 X90.204 Y99.825 E.00629
; WIPE_START
M204 S6000
G1 X90.211 Y99.901 E-.01449
G1 X90.175 Y100.296 E-.07529
G1 X90.07 Y100.678 E-.07533
G1 X89.899 Y101.032 E-.07472
G1 X89.749 Y101.253 E-.05081
G1 X89.573 Y101.454 E-.05082
G1 X89.418 Y101.586 E-.03854
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X86.761 Y96.119 Z4.2 F18000
G1 Z3.8
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X94.116 Y96.118 E.15569
G1 X94.406 Y96.044 E.00633
G1 X94.667 Y95.881 E.00651
G1 X94.877 Y95.635 E.00684
G1 X95.008 Y95.316 E.0073
G1 X95.013 Y94.72 E.01262
G1 X95.381 Y94.72 E.00778
G1 X95.381 Y95.583 E.01826
G1 X95.348 Y95.827 E.00522
G1 X95.283 Y95.998 E.00388
G1 X95.209 Y96.118 E.00297
G1 X95.057 Y96.279 E.00469
G1 X94.947 Y96.356 E.00286
G1 X94.751 Y96.441 E.0045
G1 X94.533 Y96.479 E.0047
G1 X89.498 Y96.483 E.10657
G1 X90.683 Y97.845 E.03822
G1 X91 Y98.345 E.01253
G1 X91.167 Y98.72 E.00869
G1 X91.326 Y99.3 E.01274
G1 X91.38 Y99.89 E.01254
G1 X91.357 Y100.295 E.00858
G1 X91.236 Y100.877 E.0126
G1 X91.096 Y101.256 E.00854
G1 X90.91 Y101.621 E.00868
G1 X90.645 Y102.004 E.00984
G1 X90.43 Y102.25 E.0069
G1 X90.136 Y102.519 E.00844
G1 X89.736 Y102.799 E.01034
G1 X89.281 Y103.029 E.01078
G1 X88.893 Y103.16 E.00868
G1 X88.5 Y103.243 E.0085
G1 X88.1 Y103.279 E.00849
G1 X87.699 Y103.267 E.00849
G1 X87.116 Y103.164 E.01254
G1 X86.727 Y103.032 E.00869
G1 X86.365 Y102.859 E.00849
G1 X86.026 Y102.644 E.00849
G1 X85.708 Y102.385 E.00869
G1 X85.31 Y101.947 E.01254
G1 X85.086 Y101.613 E.00849
G1 X84.832 Y101.079 E.01253
G1 X84.714 Y100.69 E.0086
G1 X84.636 Y100.208 E.01033
G1 X84.626 Y99.699 E.01079
G1 X84.676 Y99.291 E.00869
G1 X84.772 Y98.901 E.00849
G1 X84.913 Y98.526 E.00849
G1 X85.097 Y98.17 E.00849
G1 X85.323 Y97.838 E.00849
G1 X86.503 Y96.482 E.03805
G1 X81.536 Y96.482 E.10512
G1 X81.289 Y96.453 E.00527
G1 X81.144 Y96.405 E.00324
G1 X80.928 Y96.269 E.00539
G1 X80.761 Y96.077 E.00539
G1 X80.647 Y95.803 E.00627
G1 X80.619 Y95.565 E.00508
G1 X80.619 Y77.619 E.37984
G1 X80.659 Y77.349 E.00577
G1 X80.775 Y77.104 E.00575
G1 X80.975 Y76.896 E.0061
G1 X81.195 Y76.776 E.0053
G1 X81.455 Y76.723 E.00562
G1 X94.523 Y76.722 E.27658
G1 X94.657 Y76.736 E.00286
G1 X94.879 Y76.808 E.00495
G1 X94.971 Y76.86 E.00223
G1 X95.145 Y77.005 E.0048
G1 X95.277 Y77.19 E.00482
G1 X95.356 Y77.407 E.00488
G1 X95.378 Y77.559 E.00325
G1 X95.38 Y78.482 E.01952
G1 X95.019 Y78.482 E.00763
G1 X95.019 Y78.056 E.009
G1 X94.984 Y77.811 E.00525
G1 X94.86 Y77.54 E.00631
G1 X94.645 Y77.301 E.0068
G1 X94.359 Y77.139 E.00695
G1 X94.087 Y77.082 E.00588
G1 X81.946 Y77.082 E.25698
G1 X81.657 Y77.133 E.0062
G1 X81.382 Y77.281 E.00662
G1 X81.156 Y77.516 E.0069
G1 X81.018 Y77.803 E.00674
G1 X80.981 Y78.056 E.00541
G1 X80.981 Y95.164 E.36211
G1 X81.05 Y95.501 E.00727
G1 X81.257 Y95.815 E.00795
G1 X81.591 Y96.049 E.00864
G1 X81.937 Y96.12 E.00747
G1 X86.701 Y96.119 E.10083
; WIPE_START
M204 S6000
G1 X88.701 Y96.119 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X85.604 Y96.891 Z4.2 F18000
G1 Z3.8
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X81.512 Y96.891 E.08049
G1 X81.2 Y96.854 E.00619
G1 X80.987 Y96.784 E.00442
M73 P77 R5
G1 X80.858 Y96.719 E.00283
G1 X80.669 Y96.587 E.00454
G1 X80.564 Y96.488 E.00283
G1 X80.421 Y96.307 E.00454
G1 X80.351 Y96.185 E.00277
G1 X80.246 Y95.898 E.00601
G1 X80.21 Y95.589 E.00613
G1 X80.21 Y77.607 E.35368
G1 X80.219 Y77.454 E.00301
G1 X80.265 Y77.231 E.00448
G1 X80.348 Y77.021 E.00445
G1 X80.438 Y76.87 E.00346
G1 X80.562 Y76.717 E.00386
G1 X80.73 Y76.567 E.00444
G1 X80.924 Y76.447 E.00448
G1 X81.058 Y76.39 E.00286
G1 X81.23 Y76.341 E.00352
G1 X81.427 Y76.313 E.00392
G1 X94.544 Y76.312 E.25799
G1 X94.725 Y76.331 E.00359
G1 X95.054 Y76.437 E.00679
G1 X95.204 Y76.521 E.00339
G1 X95.44 Y76.719 E.00604
G1 X95.579 Y76.895 E.00442
G1 X95.649 Y77.017 E.00277
G1 X95.755 Y77.307 E.00606
G1 X95.787 Y77.529 E.00442
G1 X95.79 Y78.891 E.02678
G1 X94.61 Y78.891 E.0232
G1 X94.61 Y78.086 E.01584
G1 X94.587 Y77.928 E.00314
G1 X94.514 Y77.767 E.00347
G1 X94.385 Y77.624 E.00379
G1 X94.213 Y77.527 E.00389
G1 X94.045 Y77.492 E.00337
G1 X81.982 Y77.491 E.23728
G1 X81.793 Y77.524 E.00376
G1 X81.633 Y77.611 E.00359
G1 X81.496 Y77.753 E.00387
G1 X81.414 Y77.924 E.00374
G1 X81.39 Y78.086 E.00321
G1 X81.39 Y95.122 E.3351
G1 X81.435 Y95.341 E.00439
G1 X81.556 Y95.524 E.00431
G1 X81.757 Y95.665 E.00482
G1 X81.979 Y95.711 E.00446
G1 X94.064 Y95.709 E.23772
G1 X94.243 Y95.663 E.00363
G1 X94.397 Y95.567 E.00357
G1 X94.523 Y95.42 E.00382
G1 X94.599 Y95.234 E.00394
G1 X94.608 Y94.311 E.01816
G1 X95.79 Y94.311 E.02325
G1 X95.79 Y95.595 E.02525
G1 X95.743 Y95.941 E.00687
G1 X95.651 Y96.181 E.00504
G1 X95.536 Y96.368 E.00433
G1 X95.326 Y96.59 E.00601
G1 X95.147 Y96.716 E.0043
G1 X94.87 Y96.835 E.00594
G1 X94.569 Y96.888 E.00601
G1 X90.396 Y96.891 E.08208
G1 X91.004 Y97.59 E.01822
G1 X91.132 Y97.767 E.0043
G1 X91.364 Y98.156 E.00891
G1 X91.548 Y98.57 E.00891
G1 X91.619 Y98.777 E.00431
G1 X91.728 Y99.22 E.00897
G1 X91.761 Y99.437 E.00431
G1 X91.79 Y99.889 E.00891
G1 X91.764 Y100.339 E.00888
G1 X91.715 Y100.643 E.00605
G1 X91.628 Y100.997 E.00719
G1 X91.472 Y101.42 E.00886
G1 X91.266 Y101.824 E.00891
G1 X91.148 Y102.01 E.00434
G1 X90.964 Y102.26 E.0061
G1 X90.724 Y102.536 E.00719
G1 X90.393 Y102.839 E.00883
G1 X89.952 Y103.148 E.01059
G1 X89.631 Y103.322 E.00718
G1 X89.43 Y103.411 E.00432
G1 X89.001 Y103.556 E.00891
G1 X88.561 Y103.649 E.00885
G1 X88.113 Y103.689 E.00885
G1 X87.663 Y103.676 E.00885
G1 X87.215 Y103.608 E.00891
G1 X87.002 Y103.557 E.0043
G1 X86.573 Y103.412 E.00892
G1 X86.167 Y103.218 E.00885
G1 X85.787 Y102.977 E.00885
G1 X85.435 Y102.691 E.00891
G1 X85.279 Y102.538 E.00431
G1 X84.983 Y102.195 E.00891
G1 X84.733 Y101.821 E.00885
G1 X84.527 Y101.417 E.00891
G1 X84.445 Y101.215 E.0043
G1 X84.314 Y100.782 E.00888
G1 X84.228 Y100.251 E.01059
G1 X84.21 Y99.886 E.00718
G1 X84.217 Y99.667 E.00432
G1 X84.273 Y99.217 E.00891
G1 X84.38 Y98.78 E.00885
G1 X84.538 Y98.359 E.00885
G1 X84.745 Y97.96 E.00885
G1 X84.998 Y97.588 E.00885
G1 X85.565 Y96.936 E.01698
; WIPE_START
M204 S6000
G1 X83.565 Y96.914 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G17
G3 Z4.2 I1.217 J0 P1  F18000
;===================== date: 20250206 =====================

; don't support timelapse gcode in spiral_mode and by object sequence for I3 structure printer
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
G92 E0
G1 Z4.2
G1 X0 Y90 ; move to safe pos
G1 X-13.0 F3000 ; move to safe pos
M400
M1004 S5 P1  ; external shutter
M400 P300
M971 S11 C11 O0
G92 E0
G1 X0 F18000
M623

; SKIPTYPE: head_wrap_detect
M622.1 S1
M1002 judge_flag g39_3rd_layer_detect_flag
M622 J1
    ; enable nozzle clog detect at 3rd layer
    


    M622.1 S1
    M1002 judge_flag g39_detection_flag
    M622 J1
      
        M622.1 S0
        M1002 judge_flag g39_mass_exceed_flag
        M622 J1
        
            G392 S0
            M400
            G90
            M83
            M204 S5000
            G0 Z4.2 F4000
            G39.3 S1
            G0 Z4.2 F4000
            G392 S0
          
        M623
    
    M623
M623
; SKIPPABLE_END




G1 X81.456 Y96.238
G1 Z3.8
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.0962599
G1 F1500
M204 S6000
G1 X81.354 Y96.193 E.00039
; LINE_WIDTH: 0.145183
G1 X81.251 Y96.148 E.00067
G1 X81.065 Y96.017 E.00136
G1 X80.974 Y95.89 E.00093
G1 X80.85 Y95.643 E.00165
; WIPE_START
G1 X80.974 Y95.89 E-.136
G1 X81.065 Y96.017 E-.07695
G1 X81.251 Y96.148 E-.11195
G1 X81.354 Y96.193 E-.05511
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X86.547 Y97.165 Z4.2 F18000
G1 Z3.8
G1 E.4 F1800
; LINE_WIDTH: 0.477116
G1 F1500
M204 S6000
G1 X86.367 Y97.319 E.00533
; LINE_WIDTH: 0.43844
G1 X86.16 Y97.496 E.00561
; LINE_WIDTH: 0.400656
G1 X85.986 Y97.673 E.00465
; LINE_WIDTH: 0.359886
G1 X85.628 Y98.073 E.00894
G1 X85.425 Y98.365 E.00593
G1 X85.297 Y98.605 E.00454
G1 X85.181 Y98.883 E.00502
G1 X85.052 Y99.358 E.0082
G1 X85.002 Y99.885 E.00883
G1 X85.017 Y100.168 E.00472
G1 X85.085 Y100.602 E.00732
G1 X85.25 Y101.094 E.00865
G1 X85.418 Y101.419 E.00609
G1 X85.613 Y101.716 E.00593
G1 X85.918 Y102.057 E.00763
G1 X86.361 Y102.411 E.00945
G1 X86.835 Y102.665 E.00896
G1 X87.306 Y102.817 E.00826
G1 X87.697 Y102.884 E.0066
G1 X88.047 Y102.9 E.00585
G1 X88.553 Y102.847 E.00847
G1 X88.916 Y102.753 E.00627
G1 X89.287 Y102.611 E.00662
G1 X89.712 Y102.359 E.00824
G1 X90.117 Y102.025 E.00875
G1 X90.347 Y101.768 E.00574
G1 X90.581 Y101.431 E.00685
G1 X90.802 Y100.968 E.00854
G1 X90.944 Y100.45 E.00896
G1 X90.975 Y100.249 E.00338
G1 X91.001 Y99.891 E.00599
G1 X90.945 Y99.352 E.00904
G1 X90.859 Y99.004 E.00598
G1 X90.663 Y98.52 E.0087
G1 X90.379 Y98.079 E.00873
G1 X90.139 Y97.797 E.00618
; LINE_WIDTH: 0.38249
G1 X89.876 Y97.53 E.00667
; LINE_WIDTH: 0.426919
G1 X89.751 Y97.417 E.00337
; LINE_WIDTH: 0.468065
G1 X89.626 Y97.304 E.00372
G1 X89.603 Y97.308 E.00051
; LINE_WIDTH: 0.442665
G1 X89.444 Y97.338 E.00337
; LINE_WIDTH: 0.415939
G1 X89.284 Y97.368 E.00315
; WIPE_START
G1 X89.444 Y97.338 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X94.53 Y96.242 Z4.2 F18000
G1 Z3.8
G1 E.4 F1800
; LINE_WIDTH: 0.104145
G1 F1500
M204 S6000
G1 X94.675 Y96.186 E.00061
; LINE_WIDTH: 0.153069
G1 X94.855 Y96.085 E.00131
G1 X95.035 Y95.876 E.00175
; LINE_WIDTH: 0.133434
G1 X95.094 Y95.776 E.00062
; LINE_WIDTH: 0.0961852
G1 X95.145 Y95.601 E.00064
; WIPE_START
G1 X95.094 Y95.776 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X95.116 Y88.143 Z4.2 F18000
G1 X95.147 Y77.602 Z4.2
G1 Z3.8
G1 E.4 F1800
; LINE_WIDTH: 0.102883
G1 F1500
M204 S6000
G1 X95.074 Y77.39 E.00086
; LINE_WIDTH: 0.15463
G1 X94.939 Y77.203 E.00148
G1 X94.808 Y77.082 E.00114
; LINE_WIDTH: 0.128527
G1 X94.513 Y76.941 E.00168
; WIPE_START
G1 X94.808 Y77.082 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X87.176 Y77.008 Z4.2 F18000
G1 X81.495 Y76.954 Z4.2
G1 Z3.8
G1 E.4 F1800
; LINE_WIDTH: 0.0927731
G1 F1500
M204 S6000
G1 X81.39 Y76.991 E.00037
; LINE_WIDTH: 0.128267
G1 X81.211 Y77.071 E.001
; LINE_WIDTH: 0.153175
G1 X81.068 Y77.196 E.00121
G1 X80.961 Y77.325 E.00107
G1 X80.91 Y77.423 E.0007
; LINE_WIDTH: 0.100752
G1 X80.854 Y77.603 E.00071
; WIPE_START
G1 X80.91 Y77.423 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X88.297 Y79.346 Z4.2 F18000
G1 X96.743 Y81.544 Z4.2
G1 Z3.8
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X97.257 Y81.544 E.01086
G1 X97.257 Y82.057 E.01086
G1 X96.743 Y82.057 E.01086
G1 X96.743 Y81.604 E.00959
M204 S10000
G1 X96.319 Y81.12 F18000
G1 F1500
M204 S500
G1 X97.681 Y81.12 E.02882
G1 X97.681 Y82.482 E.02882
G1 X96.319 Y82.482 E.02882
G1 X96.319 Y81.18 E.02755
M204 S250
G1 X95.91 Y80.711 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X98.09 Y80.711 E.04288
G1 X98.09 Y82.891 E.04288
G1 X95.91 Y82.891 E.04288
G1 X95.91 Y80.771 E.0417
; CHANGE_LAYER
; Z_HEIGHT: 3.92
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F1500
M204 S6000
G1 X97.909 Y80.716 E-.38
; WIPE_END
G1 E-.02 F1800
; layer num/total_layer_count: 32/49
; update layer progress
M73 L32
M991 S0 P31 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z4.2 I-1.073 J-.574 P1  F18000
G1 X89.161 Y97.078 Z4.2
G1 Z3.92
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X88.604 Y96.915 E.01227
G1 X88.231 Y96.864 E.00797
G1 X87.9 Y96.857 E.007
G1 X87.328 Y96.928 E.0122
G1 X86.766 Y97.11 E.01252
G1 X86.659 Y96.949 E.0041
G1 X87.012 Y96.543 E.01138
G1 X88.921 Y96.543 E.0404
G1 X89.263 Y96.913 E.01067
G1 X89.192 Y97.027 E.00283
; WIPE_START
M204 S6000
G1 X88.604 Y96.915 E-.11372
G1 X88.231 Y96.864 E-.07159
G1 X87.9 Y96.857 E-.06283
G1 X87.328 Y96.928 E-.10951
G1 X87.216 Y96.964 E-.02235
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X90.617 Y99.848 Z4.32 F18000
G1 Z3.92
G1 E.4 F1800
G1 F1500
M204 S500
G1 X90.621 Y99.892 E.00093
G1 X90.602 Y100.214 E.00683
G1 X90.544 Y100.531 E.00683
G1 X90.395 Y100.967 E.00975
G1 X90.166 Y101.378 E.00995
G1 X89.868 Y101.741 E.00995
G1 X89.506 Y102.047 E.01003
G1 X89.065 Y102.294 E.01069
G1 X88.808 Y102.394 E.00585
G1 X88.498 Y102.474 E.00679
G1 X88.035 Y102.523 E.00984
G1 X87.532 Y102.479 E.01069
G1 X87.263 Y102.415 E.00584
G1 X86.961 Y102.307 E.00679
G1 X86.556 Y102.089 E.00975
G1 X86.188 Y101.796 E.00995
G1 X85.879 Y101.442 E.00995
G1 X85.638 Y101.038 E.00995
G1 X85.476 Y100.607 E.00975
G1 X85.409 Y100.291 E.00683
G1 X85.38 Y99.97 E.00683
G1 X85.408 Y99.506 E.00984
G1 X85.534 Y99.017 E.01069
G1 X85.64 Y98.762 E.00584
G1 X85.796 Y98.482 E.00679
G1 X86.072 Y98.125 E.00955
G1 X86.304 Y97.903 E.00679
G1 X86.524 Y97.736 E.00584
G1 X86.966 Y97.491 E.01069
G1 X87.42 Y97.344 E.01012
G1 X87.922 Y97.282 E.01069
G1 X88.198 Y97.288 E.00585
G1 X88.516 Y97.331 E.00679
G1 X88.949 Y97.458 E.00955
G1 X89.242 Y97.593 E.00683
G1 X89.516 Y97.763 E.00683
G1 X89.868 Y98.061 E.00975
G1 X90.16 Y98.417 E.00975
G1 X90.326 Y98.694 E.00683
G1 X90.457 Y98.989 E.00683
G1 X90.58 Y99.433 E.00975
G1 X90.612 Y99.788 E.00755
M204 S250
G1 X90.209 Y99.884 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X90.211 Y99.898 E.00026
G1 X90.195 Y100.165 E.00526
G1 X90.147 Y100.428 E.00526
G1 X90.02 Y100.8 E.00773
G1 X89.827 Y101.146 E.0078
G1 X89.575 Y101.452 E.0078
G1 X89.272 Y101.71 E.00782
G1 X88.891 Y101.923 E.00858
G1 X88.682 Y102.003 E.0044
G1 X88.424 Y102.07 E.00525
G1 X88.032 Y102.112 E.00776
G1 X87.597 Y102.073 E.00858
G1 X87.38 Y102.022 E.0044
G1 X87.128 Y101.932 E.00525
G1 X86.782 Y101.746 E.00773
G1 X86.472 Y101.499 E.00779
G1 X86.211 Y101.2 E.0078
G1 X86.008 Y100.86 E.0078
G1 X85.87 Y100.492 E.00773
G1 X85.814 Y100.23 E.00526
G1 X85.79 Y99.964 E.00526
G1 X85.814 Y99.57 E.00776
G1 X85.923 Y99.148 E.00858
G1 X86.009 Y98.941 E.0044
G1 X86.139 Y98.708 E.00525
G1 X86.377 Y98.4 E.00767
G1 X86.57 Y98.215 E.00525
G1 X86.748 Y98.08 E.0044
G1 X87.13 Y97.868 E.00858
G1 X87.509 Y97.745 E.00785
G1 X87.942 Y97.692 E.00858
G1 X88.166 Y97.697 E.0044
G1 X88.43 Y97.733 E.00525
G1 X88.805 Y97.842 E.00767
G1 X89.047 Y97.954 E.00526
G1 X89.275 Y98.095 E.00526
G1 X89.575 Y98.349 E.00773
G1 X89.825 Y98.653 E.00773
G1 X89.962 Y98.883 E.00526
G1 X90.071 Y99.127 E.00526
G1 X90.175 Y99.506 E.00773
G1 X90.204 Y99.825 E.00629
; WIPE_START
M204 S6000
G1 X90.211 Y99.898 E-.01395
G1 X90.195 Y100.165 E-.05084
M73 P78 R5
G1 X90.147 Y100.428 E-.05082
G1 X90.02 Y100.8 E-.07471
G1 X89.827 Y101.146 E-.07532
G1 X89.575 Y101.452 E-.07531
G1 X89.418 Y101.585 E-.03906
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X86.761 Y96.119 Z4.32 F18000
G1 Z3.92
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X94.129 Y96.117 E.15596
G1 X94.415 Y96.04 E.00627
G1 X94.691 Y95.861 E.00696
G1 X94.89 Y95.612 E.00675
G1 X95.008 Y95.312 E.00682
G1 X95.013 Y94.72 E.01252
G1 X95.381 Y94.72 E.00778
G1 X95.381 Y95.565 E.01788
G1 X95.353 Y95.803 E.00508
G1 X95.28 Y96.003 E.0045
G1 X95.208 Y96.12 E.00292
G1 X95.076 Y96.263 E.00412
G1 X94.943 Y96.358 E.00346
G1 X94.751 Y96.441 E.00442
G1 X94.533 Y96.479 E.0047
G1 X89.442 Y96.483 E.10774
G1 X90.544 Y97.675 E.03436
G1 X90.795 Y98 E.00869
G1 X91.005 Y98.353 E.00869
G1 X91.229 Y98.901 E.01254
G1 X91.354 Y99.48 E.01254
G1 X91.38 Y99.89 E.00869
G1 X91.357 Y100.291 E.00849
G1 X91.287 Y100.686 E.0085
G1 X91.168 Y101.079 E.00869
G1 X90.91 Y101.621 E.01273
G1 X90.647 Y102 E.00975
G1 X90.43 Y102.25 E.00699
G1 X90.126 Y102.529 E.00873
G1 X89.635 Y102.859 E.01254
G1 X89.273 Y103.032 E.00849
G1 X88.893 Y103.161 E.0085
G1 X88.5 Y103.243 E.00849
G1 X88.1 Y103.279 E.00849
G1 X87.699 Y103.267 E.00849
G1 X87.116 Y103.163 E.01254
G1 X86.727 Y103.032 E.00868
G1 X86.369 Y102.861 E.0084
G1 X85.964 Y102.597 E.01024
G1 X85.577 Y102.258 E.01087
G1 X85.31 Y101.947 E.00869
G1 X85.086 Y101.613 E.00849
G1 X84.832 Y101.079 E.01253
G1 X84.714 Y100.69 E.0086
G1 X84.636 Y100.212 E.01024
G1 X84.626 Y99.699 E.01088
G1 X84.676 Y99.291 E.00869
G1 X84.771 Y98.901 E.00849
G1 X84.913 Y98.526 E.00849
G1 X85.097 Y98.17 E.00849
G1 X85.323 Y97.838 E.00849
G1 X86.503 Y96.482 E.03805
G1 X81.536 Y96.482 E.10513
G1 X81.289 Y96.453 E.00527
G1 X81.144 Y96.405 E.00324
G1 X80.982 Y96.312 E.00394
G1 X80.868 Y96.21 E.00324
G1 X80.734 Y96.03 E.00475
G1 X80.649 Y95.817 E.00485
G1 X80.619 Y95.565 E.00538
G1 X80.619 Y77.619 E.37984
G1 X80.659 Y77.349 E.00577
G1 X80.775 Y77.105 E.00571
G1 X80.859 Y77 E.00286
G1 X80.975 Y76.896 E.00329
G1 X81.195 Y76.776 E.00531
G1 X81.455 Y76.723 E.00562
G1 X94.524 Y76.722 E.27661
G1 X94.657 Y76.735 E.00282
G1 X94.903 Y76.819 E.0055
G1 X94.983 Y76.866 E.00197
G1 X95.163 Y77.024 E.00507
G1 X95.277 Y77.19 E.00426
G1 X95.356 Y77.407 E.00489
G1 X95.378 Y77.559 E.00325
G1 X95.38 Y78.482 E.01952
G1 X95.019 Y78.482 E.00763
G1 X95.019 Y78.056 E.009
G1 X94.984 Y77.811 E.00526
G1 X94.859 Y77.54 E.00631
G1 X94.646 Y77.302 E.00677
G1 X94.36 Y77.139 E.00696
G1 X94.087 Y77.082 E.00589
G1 X81.946 Y77.082 E.25698
G1 X81.657 Y77.132 E.0062
G1 X81.382 Y77.281 E.00662
G1 X81.155 Y77.517 E.00692
G1 X81.018 Y77.803 E.00673
G1 X80.981 Y78.056 E.00541
G1 X80.981 Y95.164 E.36211
G1 X81.05 Y95.501 E.00727
G1 X81.257 Y95.815 E.00796
G1 X81.591 Y96.049 E.00864
G1 X81.937 Y96.12 E.00747
G1 X86.701 Y96.119 E.10083
; WIPE_START
M204 S6000
G1 X88.701 Y96.119 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X85.605 Y96.891 Z4.32 F18000
G1 Z3.92
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X81.512 Y96.891 E.08049
G1 X81.2 Y96.854 E.00619
G1 X80.986 Y96.784 E.00442
G1 X80.855 Y96.718 E.00289
G1 X80.733 Y96.637 E.00289
G1 X80.565 Y96.488 E.00442
G1 X80.382 Y96.242 E.00602
G1 X80.298 Y96.066 E.00383
G1 X80.247 Y95.903 E.00336
G1 X80.21 Y95.589 E.00622
G1 X80.21 Y77.607 E.35368
G1 X80.219 Y77.454 E.00301
G1 X80.265 Y77.231 E.00448
G1 X80.349 Y77.021 E.00445
G1 X80.438 Y76.871 E.00342
G1 X80.562 Y76.717 E.0039
G1 X80.73 Y76.567 E.00444
G1 X80.924 Y76.447 E.00448
G1 X81.058 Y76.39 E.00286
G1 X81.228 Y76.341 E.00348
G1 X81.427 Y76.313 E.00396
G1 X94.545 Y76.313 E.25802
G1 X94.725 Y76.331 E.00356
G1 X94.867 Y76.365 E.00287
G1 X95.081 Y76.45 E.00454
G1 X95.209 Y76.523 E.00289
G1 X95.471 Y76.753 E.00685
G1 X95.649 Y77.017 E.00627
G1 X95.755 Y77.307 E.00607
G1 X95.787 Y77.529 E.00442
G1 X95.79 Y78.891 E.02678
G1 X94.61 Y78.891 E.0232
G1 X94.61 Y78.086 E.01584
G1 X94.587 Y77.928 E.00314
G1 X94.513 Y77.767 E.00348
G1 X94.385 Y77.625 E.00376
G1 X94.213 Y77.527 E.0039
G1 X94.045 Y77.492 E.00337
G1 X81.982 Y77.491 E.23728
G1 X81.793 Y77.524 E.00376
G1 X81.633 Y77.611 E.00359
G1 X81.496 Y77.753 E.00388
G1 X81.414 Y77.924 E.00373
G1 X81.39 Y78.086 E.00321
G1 X81.39 Y95.122 E.3351
G1 X81.435 Y95.341 E.00439
G1 X81.556 Y95.524 E.00432
G1 X81.757 Y95.665 E.00483
G1 X81.979 Y95.711 E.00446
G1 X94.075 Y95.708 E.23792
G1 X94.246 Y95.662 E.00349
G1 X94.413 Y95.554 E.0039
G1 X94.532 Y95.405 E.00375
G1 X94.599 Y95.232 E.00364
G1 X94.608 Y94.311 E.01813
G1 X95.79 Y94.311 E.02325
G1 X95.79 Y95.589 E.02513
G1 X95.754 Y95.898 E.00613
G1 X95.651 Y96.182 E.00594
G1 X95.535 Y96.369 E.00432
G1 X95.348 Y96.571 E.00542
G1 X95.146 Y96.716 E.00489
G1 X94.87 Y96.835 E.00592
G1 X94.569 Y96.888 E.00601
G1 X90.377 Y96.891 E.08245
G1 X90.857 Y97.411 E.01392
G1 X91.134 Y97.77 E.00891
G1 X91.366 Y98.159 E.00891
G1 X91.461 Y98.356 E.00431
G1 X91.62 Y98.78 E.00891
G1 X91.728 Y99.22 E.00891
G1 X91.761 Y99.437 E.00431
G1 X91.79 Y99.889 E.00891
G1 X91.764 Y100.338 E.00885
G1 X91.686 Y100.781 E.00885
G1 X91.555 Y101.215 E.00891
G1 X91.473 Y101.418 E.00431
G1 X91.266 Y101.824 E.00897
G1 X91.149 Y102.01 E.00434
G1 X90.967 Y102.256 E.00602
G1 X90.724 Y102.536 E.00728
G1 X90.39 Y102.842 E.00892
G1 X90.216 Y102.975 E.0043
G1 X89.833 Y103.218 E.00891
G1 X89.427 Y103.412 E.00885
G1 X89.001 Y103.556 E.00885
G1 X88.561 Y103.649 E.00885
G1 X88.113 Y103.689 E.00885
G1 X87.663 Y103.676 E.00885
G1 X87.215 Y103.608 E.00891
G1 X87.002 Y103.557 E.00431
G1 X86.573 Y103.412 E.00891
G1 X86.168 Y103.218 E.00882
G1 X85.721 Y102.927 E.0105
G1 X85.279 Y102.538 E.01158
G1 X84.983 Y102.195 E.00891
G1 X84.733 Y101.821 E.00885
G1 X84.527 Y101.418 E.00891
G1 X84.445 Y101.215 E.00431
G1 X84.314 Y100.782 E.00888
G1 X84.229 Y100.256 E.0105
G1 X84.21 Y99.886 E.00728
G1 X84.217 Y99.667 E.00432
G1 X84.273 Y99.217 E.00891
G1 X84.38 Y98.78 E.00885
G1 X84.538 Y98.359 E.00885
G1 X84.745 Y97.96 E.00885
G1 X84.998 Y97.588 E.00885
G1 X85.565 Y96.936 E.01698
; WIPE_START
M204 S6000
G1 X83.565 Y96.914 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G17
G3 Z4.32 I1.217 J0 P1  F18000
;===================== date: 20250206 =====================

; don't support timelapse gcode in spiral_mode and by object sequence for I3 structure printer
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
G92 E0
G1 Z4.32
G1 X0 Y90 ; move to safe pos
G1 X-13.0 F3000 ; move to safe pos
M400
M1004 S5 P1  ; external shutter
M400 P300
M971 S11 C11 O0
G92 E0
G1 X0 F18000
M623

; SKIPTYPE: head_wrap_detect
M622.1 S1
M1002 judge_flag g39_3rd_layer_detect_flag
M622 J1
    ; enable nozzle clog detect at 3rd layer
    


    M622.1 S1
    M1002 judge_flag g39_detection_flag
    M622 J1
      
        M622.1 S0
        M1002 judge_flag g39_mass_exceed_flag
        M622 J1
        
            G392 S0
            M400
            G90
            M83
            M204 S5000
            G0 Z4.32 F4000
            G39.3 S1
            G0 Z4.32 F4000
            G392 S0
          
        M623
    
    M623
M623
; SKIPPABLE_END




G1 X81.456 Y96.238
G1 Z3.92
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.0965355
G1 F1500
M204 S6000
G1 X81.353 Y96.193 E.0004
; LINE_WIDTH: 0.147665
G1 X81.249 Y96.147 E.00069
G1 X81.074 Y96.024 E.0013
G1 X80.85 Y95.688 E.00245
; WIPE_START
G1 X81.074 Y96.024 E-.20968
G1 X81.249 Y96.147 E-.1113
G1 X81.353 Y96.193 E-.05901
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X86.549 Y97.168 Z4.32 F18000
G1 Z3.92
G1 E.4 F1800
; LINE_WIDTH: 0.474495
G1 F1500
M204 S6000
G1 X86.279 Y97.388 E.00781
; LINE_WIDTH: 0.437366
G1 X86.167 Y97.492 E.00313
; LINE_WIDTH: 0.404127
G1 X86.041 Y97.611 E.00327
; LINE_WIDTH: 0.360328
G1 X85.784 Y97.882 E.00623
G1 X85.475 Y98.285 E.00848
G1 X85.261 Y98.681 E.00752
G1 X85.138 Y99.015 E.00594
G1 X85.034 Y99.463 E.00768
G1 X85.006 Y99.988 E.00877
G1 X85.037 Y100.338 E.00586
G1 X85.086 Y100.604 E.00451
G1 X85.193 Y100.946 E.00598
G1 X85.419 Y101.42 E.00878
G1 X85.613 Y101.716 E.0059
G1 X85.918 Y102.058 E.00764
G1 X86.337 Y102.393 E.00897
G1 X86.797 Y102.647 E.00876
G1 X87.166 Y102.777 E.00654
G1 X87.484 Y102.853 E.00546
G1 X88.023 Y102.9 E.00903
G1 X88.553 Y102.847 E.00889
G1 X88.914 Y102.755 E.00623
G1 X89.237 Y102.631 E.00577
G1 X89.708 Y102.366 E.00902
G1 X90.158 Y101.985 E.00984
G1 X90.498 Y101.562 E.00906
G1 X90.742 Y101.106 E.00864
G1 X90.913 Y100.614 E.00869
G1 X90.979 Y100.249 E.0062
G1 X91 Y99.893 E.00595
G1 X90.954 Y99.369 E.00879
G1 X90.816 Y98.873 E.00859
G1 X90.663 Y98.53 E.00627
G1 X90.477 Y98.209 E.00619
G1 X90.128 Y97.784 E.00918
; LINE_WIDTH: 0.375767
G1 X89.948 Y97.612 E.00434
; LINE_WIDTH: 0.408416
G1 X89.742 Y97.416 E.00543
; LINE_WIDTH: 0.445762
G1 X89.561 Y97.272 E.00486
; LINE_WIDTH: 0.479749
G1 X89.38 Y97.127 E.00525
; WIPE_START
G1 X89.561 Y97.272 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X94.54 Y96.258 Z4.32 F18000
G1 Z3.92
G1 E.4 F1800
; LINE_WIDTH: 0.144755
G1 F1500
M204 S6000
G1 X94.885 Y96.06 E.00236
G1 X95.031 Y95.878 E.00139
G1 X95.106 Y95.745 E.00091
; LINE_WIDTH: 0.0910895
G1 X95.136 Y95.631 E.00038
; WIPE_START
G1 X95.106 Y95.745 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X95.123 Y88.112 Z4.32 F18000
G1 X95.147 Y77.602 Z4.32
G1 Z3.92
G1 E.4 F1800
; LINE_WIDTH: 0.10293
G1 F1500
M204 S6000
G1 X95.074 Y77.39 E.00086
; LINE_WIDTH: 0.138001
G1 X95.026 Y77.311 E.00052
; LINE_WIDTH: 0.156731
G1 X94.95 Y77.215 E.0008
G1 X94.78 Y77.065 E.00148
; LINE_WIDTH: 0.13022
G1 X94.512 Y76.943 E.00153
; WIPE_START
G1 X94.78 Y77.065 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X87.148 Y77.001 Z4.32 F18000
G1 X81.495 Y76.954 Z4.32
G1 Z3.92
G1 E.4 F1800
; LINE_WIDTH: 0.0927806
G1 F1500
M204 S6000
G1 X81.391 Y76.991 E.00037
; LINE_WIDTH: 0.12826
G1 X81.211 Y77.071 E.001
; LINE_WIDTH: 0.153202
G1 X81.068 Y77.195 E.00121
G1 X80.961 Y77.325 E.00107
G1 X80.91 Y77.423 E.0007
; LINE_WIDTH: 0.100695
G1 X80.854 Y77.603 E.0007
; WIPE_START
G1 X80.91 Y77.423 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X88.297 Y79.346 Z4.32 F18000
G1 X96.743 Y81.544 Z4.32
G1 Z3.92
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X97.257 Y81.544 E.01086
G1 X97.257 Y82.057 E.01086
G1 X96.743 Y82.057 E.01086
G1 X96.743 Y81.604 E.00959
M204 S10000
G1 X96.319 Y81.12 F18000
G1 F1500
M204 S500
G1 X97.681 Y81.12 E.02882
G1 X97.681 Y82.482 E.02882
G1 X96.319 Y82.482 E.02882
G1 X96.319 Y81.18 E.02755
M204 S250
G1 X95.91 Y80.711 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X98.09 Y80.711 E.04288
G1 X98.09 Y82.891 E.04288
G1 X95.91 Y82.891 E.04288
G1 X95.91 Y80.771 E.0417
; CHANGE_LAYER
; Z_HEIGHT: 4.04
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F1500
M204 S6000
G1 X97.909 Y80.716 E-.38
; WIPE_END
G1 E-.02 F1800
; layer num/total_layer_count: 33/49
; update layer progress
M73 L33
M991 S0 P32 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z4.32 I-1.074 J-.572 P1  F18000
G1 X89.196 Y97.088 Z4.32
G1 Z4.04
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X88.604 Y96.915 E.01304
G1 X88.231 Y96.864 E.00798
G1 X87.897 Y96.857 E.00706
G1 X87.328 Y96.928 E.01215
G1 X86.779 Y97.106 E.01222
G1 X86.672 Y96.944 E.00411
G1 X87.025 Y96.544 E.01129
G1 X88.956 Y96.543 E.04087
G1 X89.298 Y96.925 E.01086
G1 X89.228 Y97.037 E.0028
; WIPE_START
M204 S6000
G1 X88.604 Y96.915 E-.1207
G1 X88.231 Y96.864 E-.07163
G1 X87.897 Y96.857 E-.06333
G1 X87.328 Y96.928 E-.10902
G1 X87.251 Y96.953 E-.01531
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X90.617 Y99.848 Z4.44 F18000
G1 Z4.04
G1 E.4 F1800
G1 F1500
M204 S500
G1 X90.622 Y99.901 E.00112
G1 X90.58 Y100.36 E.00975
G1 X90.504 Y100.671 E.00679
G1 X90.408 Y100.933 E.0059
G1 X90.169 Y101.375 E.01064
G1 X89.868 Y101.741 E.01003
G1 X89.506 Y102.047 E.01003
G1 X89.068 Y102.293 E.01064
G1 X88.808 Y102.393 E.0059
M73 P79 R5
G1 X88.498 Y102.474 E.00679
G1 X88.039 Y102.522 E.00976
G1 X87.567 Y102.487 E.01003
G1 X87.082 Y102.355 E.01064
G1 X86.826 Y102.244 E.0059
G1 X86.548 Y102.083 E.00679
G1 X86.188 Y101.796 E.00975
G1 X85.879 Y101.442 E.00995
G1 X85.638 Y101.039 E.00994
G1 X85.476 Y100.607 E.00976
G1 X85.409 Y100.291 E.00683
G1 X85.38 Y99.97 E.00683
G1 X85.408 Y99.506 E.00983
G1 X85.533 Y99.02 E.01064
G1 X85.64 Y98.762 E.0059
G1 X85.796 Y98.482 E.00679
G1 X86.078 Y98.118 E.00975
G1 X86.42 Y97.809 E.00975
G1 X86.69 Y97.632 E.00683
G1 X86.979 Y97.487 E.00683
G1 X87.42 Y97.344 E.00983
G1 X87.919 Y97.282 E.01064
G1 X88.198 Y97.288 E.0059
G1 X88.516 Y97.331 E.00679
G1 X88.961 Y97.461 E.00983
G1 X89.408 Y97.692 E.01064
G1 X89.635 Y97.854 E.0059
G1 X89.876 Y98.071 E.00687
G1 X90.185 Y98.455 E.01044
G1 X90.327 Y98.696 E.0059
G1 X90.457 Y98.989 E.00679
G1 X90.58 Y99.433 E.00975
G1 X90.612 Y99.788 E.00755
M204 S250
G1 X90.209 Y99.885 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X90.211 Y99.901 E.00032
G1 X90.176 Y100.292 E.00773
G1 X90.112 Y100.552 E.00525
G1 X90.034 Y100.764 E.00445
G1 X89.828 Y101.145 E.00853
G1 X89.575 Y101.452 E.00782
G1 X89.272 Y101.71 E.00782
G1 X88.893 Y101.922 E.00853
G1 X88.682 Y102.003 E.00444
G1 X88.424 Y102.07 E.00525
G1 X88.033 Y102.111 E.00774
G1 X87.637 Y102.082 E.00782
G1 X87.218 Y101.968 E.00853
G1 X87.011 Y101.878 E.00444
G1 X86.78 Y101.744 E.00525
G1 X86.472 Y101.499 E.00773
G1 X86.211 Y101.2 E.0078
G1 X86.008 Y100.86 E.00779
G1 X85.87 Y100.492 E.00774
G1 X85.814 Y100.23 E.00526
G1 X85.79 Y99.964 E.00526
G1 X85.814 Y99.57 E.00776
G1 X85.922 Y99.15 E.00853
G1 X86.009 Y98.941 E.00445
G1 X86.139 Y98.708 E.00525
G1 X86.379 Y98.397 E.00773
G1 X86.671 Y98.134 E.00773
G1 X86.895 Y97.987 E.00526
G1 X87.134 Y97.867 E.00526
G1 X87.509 Y97.745 E.00776
G1 X87.94 Y97.692 E.00853
G1 X88.166 Y97.697 E.00445
G1 X88.43 Y97.733 E.00525
G1 X88.809 Y97.843 E.00776
G1 X89.195 Y98.042 E.00853
G1 X89.379 Y98.173 E.00445
G1 X89.578 Y98.353 E.00527
G1 X89.847 Y98.689 E.00847
G1 X89.962 Y98.883 E.00444
G1 X90.071 Y99.127 E.00525
G1 X90.175 Y99.506 E.00773
G1 X90.204 Y99.825 E.0063
; WIPE_START
M204 S6000
G1 X90.211 Y99.901 E-.01448
G1 X90.176 Y100.292 E-.07469
G1 X90.112 Y100.552 E-.05071
G1 X90.034 Y100.764 E-.04295
G1 X89.828 Y101.145 E-.08244
G1 X89.575 Y101.452 E-.07555
G1 X89.418 Y101.586 E-.03918
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X86.775 Y96.119 Z4.44 F18000
G1 Z4.04
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X94.117 Y96.118 E.1554
G1 X94.406 Y96.044 E.00631
G1 X94.667 Y95.881 E.00652
G1 X94.878 Y95.634 E.00687
G1 X95.008 Y95.316 E.00726
G1 X95.013 Y94.72 E.01262
G1 X95.381 Y94.72 E.00778
G1 X95.381 Y95.565 E.01788
G1 X95.353 Y95.803 E.00508
G1 X95.28 Y96.003 E.0045
G1 X95.208 Y96.12 E.00291
G1 X95.075 Y96.264 E.00415
G1 X94.943 Y96.358 E.00342
G1 X94.751 Y96.441 E.00443
G1 X94.533 Y96.479 E.0047
G1 X89.471 Y96.483 E.10714
G1 X90.591 Y97.732 E.03551
G1 X90.794 Y97.999 E.00709
G1 X91.084 Y98.517 E.01258
G1 X91.229 Y98.901 E.00868
G1 X91.324 Y99.291 E.00849
G1 X91.374 Y99.699 E.00869
G1 X91.357 Y100.295 E.01263
G1 X91.236 Y100.878 E.0126
G1 X91.095 Y101.26 E.00863
G1 X90.98 Y101.494 E.00551
G1 X90.808 Y101.782 E.0071
G1 X90.558 Y102.11 E.00873
G1 X90.136 Y102.52 E.01245
G1 X89.744 Y102.794 E.01014
G1 X89.281 Y103.029 E.01097
G1 X88.893 Y103.161 E.00869
G1 X88.5 Y103.243 E.0085
G1 X88.1 Y103.279 E.00849
G1 X87.699 Y103.267 E.00849
G1 X87.116 Y103.164 E.01254
G1 X86.727 Y103.032 E.00869
G1 X86.365 Y102.859 E.00849
G1 X86.026 Y102.644 E.00849
G1 X85.577 Y102.258 E.01254
G1 X85.31 Y101.947 E.00869
G1 X85.086 Y101.613 E.00849
G1 X84.906 Y101.259 E.00841
G1 X84.746 Y100.808 E.01014
G1 X84.643 Y100.3 E.01097
G1 X84.62 Y99.89 E.00869
G1 X84.645 Y99.49 E.00849
G1 X84.718 Y99.095 E.0085
G1 X84.837 Y98.712 E.00849
G1 X85 Y98.345 E.00849
G1 X85.208 Y97.996 E.00859
G1 X85.364 Y97.788 E.00551
G1 X86.514 Y96.482 E.03684
G1 X81.536 Y96.482 E.10535
G1 X81.289 Y96.453 E.00527
G1 X81.143 Y96.405 E.00324
G1 X80.98 Y96.31 E.00399
G1 X80.792 Y96.123 E.00562
G1 X80.696 Y95.957 E.00405
G1 X80.648 Y95.812 E.00324
G1 X80.619 Y95.565 E.00527
G1 X80.619 Y77.628 E.37965
G1 X80.655 Y77.357 E.00578
G1 X80.774 Y77.106 E.00588
G1 X80.859 Y77 E.0029
G1 X80.982 Y76.89 E.00348
G1 X81.204 Y76.773 E.00532
G1 X81.456 Y76.723 E.00543
G1 X94.526 Y76.722 E.27664
G1 X94.657 Y76.735 E.00279
G1 X94.744 Y76.756 E.00189
G1 X94.968 Y76.857 E.0052
G1 X95.146 Y77.007 E.00494
G1 X95.278 Y77.194 E.00485
G1 X95.356 Y77.407 E.0048
G1 X95.378 Y77.559 E.00325
G1 X95.38 Y78.482 E.01952
G1 X95.019 Y78.482 E.00763
G1 X95.019 Y78.056 E.009
G1 X94.984 Y77.811 E.00526
G1 X94.859 Y77.54 E.00631
G1 X94.645 Y77.302 E.00677
G1 X94.359 Y77.139 E.00697
G1 X94.087 Y77.082 E.00588
G1 X81.946 Y77.082 E.25698
G1 X81.657 Y77.133 E.0062
G1 X81.382 Y77.281 E.00663
G1 X81.155 Y77.517 E.00693
G1 X81.018 Y77.803 E.00671
G1 X80.981 Y78.056 E.0054
G1 X80.981 Y95.155 E.36192
G1 X81.035 Y95.462 E.0066
G1 X81.249 Y95.809 E.00864
G1 X81.591 Y96.049 E.00884
G1 X81.937 Y96.12 E.00747
G1 X86.715 Y96.119 E.10114
; WIPE_START
M204 S6000
G1 X88.715 Y96.119 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X85.608 Y96.891 Z4.44 F18000
G1 Z4.04
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X81.512 Y96.891 E.08056
G1 X81.2 Y96.854 E.00619
G1 X80.986 Y96.784 E.00442
G1 X80.855 Y96.718 E.00289
G1 X80.579 Y96.503 E.00688
G1 X80.383 Y96.246 E.00636
G1 X80.317 Y96.114 E.00289
G1 X80.247 Y95.901 E.00442
G1 X80.21 Y95.589 E.00619
G1 X80.21 Y77.61 E.35362
G1 X80.231 Y77.374 E.00466
G1 X80.264 Y77.234 E.00283
G1 X80.349 Y77.021 E.00451
G1 X80.437 Y76.873 E.00339
G1 X80.562 Y76.717 E.00393
G1 X80.732 Y76.565 E.00449
G1 X80.853 Y76.486 E.00283
G1 X81.061 Y76.389 E.00452
G1 X81.226 Y76.341 E.00339
G1 X81.427 Y76.313 E.00399
G1 X94.547 Y76.313 E.25805
G1 X94.725 Y76.331 E.00353
G1 X94.867 Y76.365 E.00287
G1 X95.081 Y76.45 E.00454
G1 X95.203 Y76.52 E.00277
G1 X95.44 Y76.719 E.00608
G1 X95.563 Y76.873 E.00387
G1 X95.65 Y77.018 E.00333
G1 X95.755 Y77.307 E.00604
G1 X95.787 Y77.529 E.00442
G1 X95.79 Y78.891 E.02678
G1 X94.61 Y78.891 E.0232
G1 X94.61 Y78.086 E.01584
G1 X94.587 Y77.928 E.00314
G1 X94.513 Y77.767 E.00348
G1 X94.385 Y77.625 E.00376
G1 X94.213 Y77.526 E.00391
G1 X94.045 Y77.492 E.00337
G1 X81.982 Y77.491 E.23727
G1 X81.793 Y77.524 E.00376
G1 X81.633 Y77.611 E.00359
G1 X81.496 Y77.753 E.00389
G1 X81.414 Y77.924 E.00372
G1 X81.39 Y78.086 E.00321
M73 P79 R4
G1 X81.39 Y95.119 E.33504
G1 X81.424 Y95.314 E.00389
G1 X81.553 Y95.523 E.00482
G1 X81.757 Y95.665 E.00489
G1 X81.979 Y95.711 E.00446
G1 X94.065 Y95.709 E.23774
G1 X94.243 Y95.663 E.00361
G1 X94.397 Y95.567 E.00357
G1 X94.524 Y95.419 E.00384
G1 X94.599 Y95.234 E.00392
G1 X94.608 Y94.311 E.01816
G1 X95.79 Y94.311 E.02325
G1 X95.79 Y95.589 E.02513
G1 X95.754 Y95.898 E.00613
G1 X95.65 Y96.182 E.00594
G1 X95.535 Y96.369 E.00432
G1 X95.347 Y96.572 E.00545
G1 X95.146 Y96.716 E.00486
G1 X94.87 Y96.835 E.00592
G1 X94.569 Y96.888 E.00601
G1 X90.387 Y96.891 E.08226
G1 X90.906 Y97.471 E.01532
G1 X91.133 Y97.769 E.00737
G1 X91.366 Y98.159 E.00892
G1 X91.461 Y98.356 E.00431
G1 X91.62 Y98.78 E.00891
G1 X91.727 Y99.217 E.00885
G1 X91.783 Y99.667 E.00891
G1 X91.79 Y99.886 E.0043
G1 X91.764 Y100.339 E.00894
G1 X91.717 Y100.634 E.00586
G1 X91.628 Y100.998 E.00737
G1 X91.471 Y101.422 E.00889
G1 X91.34 Y101.689 E.00586
G1 X91.148 Y102.011 E.00737
G1 X90.873 Y102.372 E.00893
G1 X90.726 Y102.534 E.0043
G1 X90.393 Y102.839 E.00889
G1 X89.96 Y103.143 E.0104
G1 X89.43 Y103.411 E.01167
G1 X89.001 Y103.556 E.00891
G1 X88.56 Y103.649 E.00885
G1 X88.113 Y103.689 E.00884
G1 X87.663 Y103.676 E.00885
G1 X87.215 Y103.608 E.00891
G1 X87.002 Y103.557 E.00431
G1 X86.573 Y103.412 E.00891
G1 X86.167 Y103.218 E.00885
G1 X85.787 Y102.977 E.00885
G1 X85.435 Y102.691 E.00891
G1 X85.279 Y102.538 E.0043
G1 X84.983 Y102.195 E.00891
G1 X84.733 Y101.821 E.00885
G1 X84.529 Y101.422 E.00882
G1 X84.352 Y100.923 E.0104
G1 X84.268 Y100.558 E.00737
G1 X84.236 Y100.341 E.00431
G1 X84.21 Y99.889 E.00891
G1 X84.239 Y99.44 E.00885
G1 X84.32 Y98.997 E.00885
G1 X84.453 Y98.567 E.00885
G1 X84.636 Y98.156 E.00885
G1 X84.867 Y97.768 E.00888
G1 X85.046 Y97.53 E.00586
G1 X85.568 Y96.936 E.01556
; WIPE_START
M204 S6000
G1 X83.569 Y96.914 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G17
G3 Z4.44 I1.217 J0 P1  F18000
;===================== date: 20250206 =====================

; don't support timelapse gcode in spiral_mode and by object sequence for I3 structure printer
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
G92 E0
G1 Z4.44
G1 X0 Y90 ; move to safe pos
G1 X-13.0 F3000 ; move to safe pos
M400
M1004 S5 P1  ; external shutter
M400 P300
M971 S11 C11 O0
G92 E0
G1 X0 F18000
M623

; SKIPTYPE: head_wrap_detect
M622.1 S1
M1002 judge_flag g39_3rd_layer_detect_flag
M622 J1
    ; enable nozzle clog detect at 3rd layer
    


    M622.1 S1
    M1002 judge_flag g39_detection_flag
    M622 J1
      
        M622.1 S0
        M1002 judge_flag g39_mass_exceed_flag
        M622 J1
        
            G392 S0
            M400
            G90
            M83
            M204 S5000
            G0 Z4.44 F4000
            G39.3 S1
            G0 Z4.44 F4000
            G392 S0
          
        M623
    
    M623
M623
; SKIPPABLE_END




G1 X81.456 Y96.238
G1 Z4.04
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.0965335
G1 F1500
M204 S6000
G1 X81.352 Y96.193 E.0004
; LINE_WIDTH: 0.146976
G1 X81.249 Y96.147 E.00069
G1 X81.057 Y96.008 E.00143
G1 X80.95 Y95.848 E.00116
G1 X80.848 Y95.629 E.00146
; WIPE_START
G1 X80.95 Y95.848 E-.11684
G1 X81.057 Y96.008 E-.0933
G1 X81.249 Y96.147 E-.1149
G1 X81.352 Y96.193 E-.05497
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X86.56 Y97.159 Z4.44 F18000
G1 Z4.04
G1 E.4 F1800
; LINE_WIDTH: 0.476999
G1 F1500
M204 S6000
G1 X86.373 Y97.316 E.00548
; LINE_WIDTH: 0.436779
G1 X86.161 Y97.497 E.00573
; LINE_WIDTH: 0.399133
G1 X85.986 Y97.674 E.00462
; LINE_WIDTH: 0.360474
G1 X85.661 Y98.03 E.00804
G1 X85.488 Y98.264 E.00487
G1 X85.339 Y98.521 E.00496
G1 X85.178 Y98.888 E.0067
G1 X85.038 Y99.433 E.00939
G1 X85.003 Y99.889 E.00764
G1 X85.037 Y100.357 E.00785
G1 X85.109 Y100.702 E.00587
G1 X85.257 Y101.109 E.00723
G1 X85.418 Y101.418 E.00583
G1 X85.612 Y101.714 E.00591
G1 X85.965 Y102.104 E.00879
G1 X86.346 Y102.401 E.00807
G1 X86.55 Y102.524 E.00398
G1 X86.871 Y102.678 E.00594
G1 X87.218 Y102.791 E.0061
G1 X87.519 Y102.857 E.00513
G1 X88.03 Y102.9 E.00857
G1 X88.553 Y102.847 E.00877
G1 X88.914 Y102.753 E.00623
G1 X89.286 Y102.609 E.00666
G1 X89.707 Y102.363 E.00814
G1 X89.894 Y102.221 E.00392
G1 X90.267 Y101.86 E.00867
G1 X90.494 Y101.57 E.00615
G1 X90.749 Y101.1 E.00892
G1 X90.871 Y100.769 E.00589
G1 X90.975 Y100.252 E.00881
G1 X90.996 Y99.886 E.00612
G1 X90.952 Y99.359 E.00883
G1 X90.814 Y98.874 E.00843
G1 X90.668 Y98.528 E.00626
G1 X90.478 Y98.212 E.00616
G1 X90.143 Y97.8 E.00887
; LINE_WIDTH: 0.379939
G1 X89.877 Y97.535 E.00663
; LINE_WIDTH: 0.41813
G1 X89.762 Y97.432 E.00301
; LINE_WIDTH: 0.455816
G1 X89.623 Y97.309 E.004
; LINE_WIDTH: 0.484693
G1 X89.411 Y97.145 E.00614
; WIPE_START
G1 X89.623 Y97.309 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X94.53 Y96.242 Z4.44 F18000
G1 Z4.04
G1 E.4 F1800
; LINE_WIDTH: 0.104145
G1 F1500
M204 S6000
G1 X94.675 Y96.186 E.00061
; LINE_WIDTH: 0.150377
G1 X94.855 Y96.084 E.00128
G1 X95.032 Y95.878 E.00169
; LINE_WIDTH: 0.131505
G1 X95.093 Y95.773 E.00064
; LINE_WIDTH: 0.0960101
G1 X95.137 Y95.622 E.00055
; WIPE_START
G1 X95.093 Y95.773 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X95.116 Y88.141 Z4.44 F18000
G1 X95.147 Y77.602 Z4.44
G1 Z4.04
G1 E.4 F1800
; LINE_WIDTH: 0.102964
G1 F1500
M204 S6000
G1 X95.074 Y77.39 E.00086
; LINE_WIDTH: 0.15256
G1 X94.941 Y77.206 E.00144
G1 X94.78 Y77.065 E.00135
; LINE_WIDTH: 0.130246
G1 X94.512 Y76.943 E.00154
; WIPE_START
G1 X94.78 Y77.065 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X87.148 Y77.001 Z4.44 F18000
G1 X81.495 Y76.954 Z4.44
G1 Z4.04
G1 E.4 F1800
; LINE_WIDTH: 0.0923878
G1 F1500
M204 S6000
G1 X81.395 Y76.989 E.00035
; LINE_WIDTH: 0.130681
G1 X81.19 Y77.084 E.00118
; LINE_WIDTH: 0.152579
G1 X80.962 Y77.325 E.0021
M73 P80 R4
G1 X80.906 Y77.434 E.00077
; LINE_WIDTH: 0.100947
G1 X80.857 Y77.596 E.00064
; WIPE_START
G1 X80.906 Y77.434 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X88.293 Y79.351 Z4.44 F18000
G1 X96.743 Y81.544 Z4.44
G1 Z4.04
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X97.257 Y81.544 E.01086
G1 X97.257 Y82.057 E.01086
G1 X96.743 Y82.057 E.01086
G1 X96.743 Y81.604 E.00959
M204 S10000
G1 X96.319 Y81.12 F18000
G1 F1500
M204 S500
G1 X97.681 Y81.12 E.02882
G1 X97.681 Y82.482 E.02882
G1 X96.319 Y82.482 E.02882
G1 X96.319 Y81.18 E.02755
M204 S250
G1 X95.91 Y80.711 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X98.09 Y80.711 E.04288
G1 X98.09 Y82.891 E.04288
G1 X95.91 Y82.891 E.04288
G1 X95.91 Y80.771 E.0417
; CHANGE_LAYER
; Z_HEIGHT: 4.16
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F1500
M204 S6000
G1 X97.909 Y80.716 E-.38
; WIPE_END
G1 E-.02 F1800
; layer num/total_layer_count: 34/49
; update layer progress
M73 L34
M991 S0 P33 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z4.44 I-1.075 J-.57 P1  F18000
G1 X89.213 Y97.114 Z4.44
G1 Z4.16
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X89.113 Y97.064 E.00235
G1 X88.604 Y96.915 E.01123
G1 X88.23 Y96.864 E.00798
G1 X87.895 Y96.858 E.00711
G1 X87.327 Y96.928 E.0121
G1 X86.766 Y97.11 E.01251
G1 X86.659 Y96.949 E.0041
G1 X87.011 Y96.544 E.01137
G1 X88.988 Y96.543 E.04184
G1 X89.341 Y96.948 E.01136
G1 X89.249 Y97.066 E.00315
; WIPE_START
M204 S6000
G1 X89.113 Y97.064 E-.02586
G1 X88.604 Y96.915 E-.10078
G1 X88.23 Y96.864 E-.07168
G1 X87.895 Y96.858 E-.06382
G1 X87.327 Y96.928 E-.10857
G1 X87.281 Y96.943 E-.00929
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X90.617 Y99.848 Z4.56 F18000
G1 Z4.16
G1 E.4 F1800
G1 F1500
M204 S500
G1 X90.622 Y99.901 E.00112
G1 X90.58 Y100.369 E.00995
G1 X90.454 Y100.826 E.01002
G1 X90.232 Y101.274 E.01059
G1 X90.072 Y101.505 E.00595
G1 X89.861 Y101.747 E.00679
G1 X89.506 Y102.047 E.00983
G1 X89.07 Y102.292 E.01058
G1 X88.808 Y102.393 E.00595
G1 X88.497 Y102.474 E.00679
G1 X88.039 Y102.522 E.00975
G1 X87.58 Y102.488 E.00975
G1 X87.265 Y102.416 E.00683
G1 X86.961 Y102.307 E.00683
G1 X86.556 Y102.089 E.00975
G1 X86.188 Y101.796 E.00995
G1 X85.879 Y101.442 E.00995
G1 X85.638 Y101.038 E.00995
G1 X85.476 Y100.607 E.00975
G1 X85.409 Y100.292 E.00683
G1 X85.38 Y99.97 E.00683
G1 X85.408 Y99.506 E.00983
G1 X85.532 Y99.022 E.01058
G1 X85.64 Y98.762 E.00596
G1 X85.796 Y98.482 E.00679
G1 X86.078 Y98.118 E.00975
G1 X86.421 Y97.809 E.00975
G1 X86.69 Y97.632 E.00683
G1 X86.979 Y97.487 E.00683
G1 X87.42 Y97.344 E.00983
G1 X87.916 Y97.282 E.01059
G1 X88.198 Y97.288 E.00595
G1 X88.516 Y97.331 E.0068
G1 X88.958 Y97.46 E.00975
G1 X89.37 Y97.666 E.00975
G1 X89.634 Y97.852 E.00683
G1 X89.876 Y98.071 E.00691
G1 X90.184 Y98.453 E.01039
G1 X90.327 Y98.695 E.00596
G1 X90.457 Y98.989 E.00679
G1 X90.58 Y99.433 E.00975
G1 X90.612 Y99.789 E.00756
M204 S250
G1 X90.209 Y99.885 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X90.211 Y99.901 E.00031
G1 X90.175 Y100.296 E.00779
G1 X90.07 Y100.679 E.00782
G1 X89.878 Y101.065 E.00849
G1 X89.748 Y101.254 E.00449
G1 X89.573 Y101.454 E.00525
G1 X89.272 Y101.71 E.00776
G1 X88.896 Y101.921 E.00849
G1 X88.682 Y102.003 E.00449
G1 X88.424 Y102.07 E.00525
G1 X88.033 Y102.111 E.00774
G1 X87.641 Y102.082 E.00773
G1 X87.38 Y102.023 E.00526
G1 X87.128 Y101.932 E.00526
G1 X86.782 Y101.746 E.00773
G1 X86.472 Y101.499 E.00779
G1 X86.211 Y101.2 E.0078
G1 X86.008 Y100.86 E.00779
G1 X85.87 Y100.492 E.00774
G1 X85.814 Y100.23 E.00526
G1 X85.79 Y99.964 E.00526
G1 X85.814 Y99.57 E.00776
G1 X85.921 Y99.152 E.00848
G1 X86.009 Y98.941 E.00449
G1 X86.139 Y98.708 E.00525
G1 X86.379 Y98.397 E.00773
G1 X86.672 Y98.134 E.00773
G1 X86.895 Y97.987 E.00526
G1 X87.134 Y97.867 E.00526
G1 X87.509 Y97.745 E.00776
G1 X87.937 Y97.692 E.00849
G1 X88.166 Y97.697 E.00449
G1 X88.43 Y97.733 E.00525
G1 X88.808 Y97.843 E.00773
G1 X89.159 Y98.019 E.00774
G1 X89.378 Y98.173 E.00526
G1 X89.578 Y98.353 E.00528
G1 X89.846 Y98.686 E.00842
G1 X89.962 Y98.883 E.00449
G1 X90.071 Y99.127 E.00525
G1 X90.175 Y99.506 E.00774
G1 X90.204 Y99.825 E.0063
; WIPE_START
M204 S6000
G1 X90.211 Y99.901 E-.01441
G1 X90.175 Y100.296 E-.07529
G1 X90.07 Y100.679 E-.07556
G1 X89.878 Y101.065 E-.08197
G1 X89.748 Y101.254 E-.04342
G1 X89.573 Y101.454 E-.05069
G1 X89.417 Y101.586 E-.03866
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X86.761 Y96.119 Z4.56 F18000
G1 Z4.16
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X94.118 Y96.118 E.15572
G1 X94.406 Y96.044 E.00629
G1 X94.667 Y95.881 E.00652
G1 X94.878 Y95.633 E.00689
G1 X95.008 Y95.316 E.00724
G1 X95.013 Y94.72 E.01262
G1 X95.38 Y94.72 E.00776
G1 X95.378 Y95.636 E.01938
G1 X95.344 Y95.84 E.00439
G1 X95.283 Y95.998 E.00358
G1 X95.209 Y96.118 E.00298
G1 X95.057 Y96.279 E.00469
G1 X94.947 Y96.356 E.00286
G1 X94.751 Y96.441 E.0045
G1 X94.533 Y96.479 E.0047
G1 X89.498 Y96.483 E.10657
G1 X90.683 Y97.845 E.03822
G1 X91.003 Y98.349 E.01264
G1 X91.11 Y98.581 E.00541
G1 X91.228 Y98.9 E.00719
G1 X91.326 Y99.3 E.00872
G1 X91.38 Y99.89 E.01254
G1 X91.357 Y100.295 E.00859
G1 X91.235 Y100.878 E.01259
G1 X91.096 Y101.256 E.00853
G1 X90.91 Y101.622 E.00869
G1 X90.696 Y101.94 E.00811
G1 X90.429 Y102.251 E.00868
G1 X90.126 Y102.529 E.00869
G1 X89.635 Y102.859 E.01254
G1 X89.273 Y103.032 E.00849
G1 X88.893 Y103.161 E.00849
G1 X88.5 Y103.243 E.0085
G1 X88.1 Y103.279 E.00849
G1 X87.699 Y103.267 E.00849
G1 X87.116 Y103.164 E.01254
G1 X86.719 Y103.029 E.00889
G1 X86.193 Y102.757 E.01253
G1 X85.867 Y102.522 E.00849
G1 X85.571 Y102.251 E.00849
G1 X85.31 Y101.947 E.00849
G1 X85.086 Y101.613 E.00849
G1 X84.832 Y101.079 E.01253
G1 X84.714 Y100.689 E.00861
G1 X84.637 Y100.221 E.01005
G1 X84.626 Y99.699 E.01106
G1 X84.676 Y99.291 E.00869
G1 X84.771 Y98.901 E.00849
G1 X84.913 Y98.526 E.00849
G1 X85.097 Y98.17 E.00849
G1 X85.323 Y97.838 E.00849
G1 X86.503 Y96.482 E.03805
G1 X81.536 Y96.482 E.10513
G1 X81.283 Y96.452 E.00539
G1 X81.188 Y96.422 E.00213
G1 X80.945 Y96.282 E.00593
G1 X80.761 Y96.077 E.00585
G1 X80.647 Y95.803 E.00627
G1 X80.619 Y95.565 E.00508
G1 X80.619 Y77.619 E.37984
G1 X80.659 Y77.349 E.00578
G1 X80.761 Y77.125 E.0052
G1 X80.945 Y76.92 E.00585
G1 X81.059 Y76.841 E.00293
G1 X81.2 Y76.775 E.00329
G1 X81.449 Y76.723 E.00539
G1 X94.509 Y76.722 E.27642
G1 X94.764 Y76.764 E.00546
G1 X94.983 Y76.866 E.00513
G1 X95.166 Y77.03 E.0052
G1 X95.285 Y77.21 E.00456
G1 X95.35 Y77.386 E.00399
G1 X95.378 Y77.563 E.00378
G1 X95.38 Y78.482 E.01945
G1 X95.019 Y78.482 E.00763
G1 X95.019 Y78.056 E.009
G1 X94.984 Y77.81 E.00527
G1 X94.859 Y77.539 E.0063
G1 X94.647 Y77.303 E.00673
G1 X94.359 Y77.139 E.007
G1 X94.087 Y77.082 E.00588
G1 X81.946 Y77.082 E.25698
G1 X81.657 Y77.132 E.0062
G1 X81.388 Y77.278 E.00649
G1 X81.171 Y77.495 E.0065
G1 X81.019 Y77.798 E.00717
G1 X80.981 Y78.056 E.00552
G1 X80.981 Y95.158 E.36199
G1 X81.04 Y95.474 E.0068
G1 X81.251 Y95.811 E.00842
G1 X81.591 Y96.049 E.00878
G1 X81.937 Y96.12 E.00747
G1 X86.701 Y96.119 E.10083
; WIPE_START
M204 S6000
G1 X88.701 Y96.119 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X85.604 Y96.891 Z4.56 F18000
G1 Z4.16
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X81.512 Y96.891 E.08049
G1 X81.198 Y96.854 E.00623
G1 X81.038 Y96.804 E.00329
G1 X80.855 Y96.717 E.00398
G1 X80.689 Y96.603 E.00398
G1 X80.563 Y96.487 E.00336
G1 X80.421 Y96.307 E.00451
G1 X80.351 Y96.185 E.00277
G1 X80.246 Y95.898 E.00601
G1 X80.21 Y95.589 E.00613
G1 X80.21 Y77.607 E.35368
G1 X80.219 Y77.454 E.00301
G1 X80.265 Y77.231 E.00448
G1 X80.349 Y77.02 E.00448
G1 X80.421 Y76.895 E.00283
G1 X80.563 Y76.715 E.00451
G1 X80.689 Y76.599 E.00336
G1 X80.855 Y76.485 E.00396
G1 X81.059 Y76.389 E.00444
G1 X81.279 Y76.33 E.00448
G1 X81.425 Y76.313 E.00289
G1 X94.542 Y76.313 E.25801
G1 X94.874 Y76.367 E.00661
G1 X95.081 Y76.45 E.0044
G1 X95.209 Y76.523 E.00289
G1 X95.327 Y76.611 E.00289
G1 X95.485 Y76.77 E.00442
G1 X95.652 Y77.023 E.00597
G1 X95.748 Y77.282 E.00543
G1 X95.788 Y77.53 E.00495
G1 X95.79 Y78.891 E.02676
G1 X94.61 Y78.891 E.0232
G1 X94.61 Y78.086 E.01584
G1 X94.587 Y77.927 E.00315
G1 X94.513 Y77.767 E.00348
G1 X94.386 Y77.625 E.00373
G1 X94.213 Y77.526 E.00393
G1 X94.045 Y77.492 E.00337
G1 X81.982 Y77.491 E.23728
G1 X81.793 Y77.524 E.00376
G1 X81.635 Y77.61 E.00355
G1 X81.507 Y77.738 E.00356
G1 X81.414 Y77.922 E.00406
G1 X81.39 Y78.086 E.00325
G1 X81.39 Y95.12 E.33506
G1 X81.428 Y95.322 E.00404
G1 X81.554 Y95.523 E.00466
G1 X81.757 Y95.665 E.00487
G1 X81.979 Y95.711 E.00446
G1 X94.066 Y95.709 E.23775
G1 X94.243 Y95.663 E.00359
G1 X94.397 Y95.567 E.00357
G1 X94.524 Y95.418 E.00386
G1 X94.599 Y95.234 E.0039
G1 X94.608 Y94.311 E.01816
G1 X95.79 Y94.311 E.02324
G1 X95.788 Y95.67 E.02674
G1 X95.741 Y95.949 E.00555
G1 X95.651 Y96.18 E.00488
G1 X95.536 Y96.368 E.00434
G1 X95.326 Y96.59 E.006
G1 X95.147 Y96.716 E.0043
G1 X94.87 Y96.835 E.00594
G1 X94.569 Y96.888 E.00601
G1 X90.396 Y96.891 E.08208
G1 X91.004 Y97.59 E.01822
G1 X91.132 Y97.767 E.0043
G1 X91.365 Y98.158 E.00894
G1 X91.489 Y98.424 E.00577
G1 X91.62 Y98.78 E.00746
G1 X91.728 Y99.22 E.00892
G1 X91.761 Y99.437 E.00431
G1 X91.79 Y99.889 E.00891
G1 X91.764 Y100.339 E.00888
G1 X91.718 Y100.629 E.00577
G1 X91.627 Y100.998 E.00746
G1 X91.472 Y101.42 E.00886
G1 X91.266 Y101.824 E.00891
G1 X91.148 Y102.012 E.00436
G1 X91.019 Y102.192 E.00437
G1 X90.723 Y102.536 E.00891
G1 X90.39 Y102.842 E.00891
G1 X90.216 Y102.975 E.0043
G1 X89.833 Y103.218 E.00891
G1 X89.427 Y103.412 E.00885
G1 X89.001 Y103.556 E.00885
G1 X88.56 Y103.649 E.00885
G1 X88.113 Y103.689 E.00884
G1 X87.663 Y103.676 E.00885
G1 X87.215 Y103.608 E.00891
G1 X87.002 Y103.557 E.0043
G1 X86.57 Y103.411 E.00898
G1 X86.37 Y103.322 E.0043
G1 X85.973 Y103.103 E.00891
G1 X85.608 Y102.84 E.00885
G1 X85.277 Y102.536 E.00885
G1 X84.983 Y102.195 E.00885
G1 X84.733 Y101.821 E.00885
G1 X84.527 Y101.417 E.00891
G1 X84.445 Y101.215 E.0043
G1 X84.314 Y100.782 E.00889
G1 X84.229 Y100.265 E.01031
G1 X84.21 Y99.886 E.00746
G1 X84.217 Y99.667 E.00431
G1 X84.273 Y99.217 E.00891
G1 X84.38 Y98.78 E.00885
G1 X84.538 Y98.359 E.00885
G1 X84.745 Y97.96 E.00885
G1 X84.998 Y97.588 E.00885
G1 X85.565 Y96.936 E.01698
; WIPE_START
M204 S6000
G1 X83.565 Y96.914 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G17
G3 Z4.56 I1.217 J0 P1  F18000
;===================== date: 20250206 =====================

; don't support timelapse gcode in spiral_mode and by object sequence for I3 structure printer
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
G92 E0
G1 Z4.56
G1 X0 Y90 ; move to safe pos
G1 X-13.0 F3000 ; move to safe pos
M400
M1004 S5 P1  ; external shutter
M400 P300
M971 S11 C11 O0
G92 E0
G1 X0 F18000
M623

; SKIPTYPE: head_wrap_detect
M622.1 S1
M1002 judge_flag g39_3rd_layer_detect_flag
M622 J1
    ; enable nozzle clog detect at 3rd layer
    


    M622.1 S1
    M1002 judge_flag g39_detection_flag
    M622 J1
      
        M622.1 S0
        M1002 judge_flag g39_mass_exceed_flag
        M622 J1
        
            G392 S0
            M400
            G90
            M83
            M204 S5000
            G0 Z4.56 F4000
            G39.3 S1
            G0 Z4.56 F4000
            G392 S0
          
        M623
    
    M623
M623
; SKIPPABLE_END




G1 X81.438 Y96.256
G1 Z4.16
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.1493
G1 F1500
M204 S6000
G1 X81.203 Y96.119 E.00167
G1 X81.059 Y96.011 E.00111
G1 X80.974 Y95.89 E.00091
G1 X80.848 Y95.633 E.00176
; WIPE_START
G1 X80.974 Y95.89 E-.12278
G1 X81.059 Y96.011 E-.06328
G1 X81.203 Y96.119 E-.07739
G1 X81.438 Y96.256 E-.11655
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X86.548 Y97.165 Z4.56 F18000
G1 Z4.16
G1 E.4 F1800
; LINE_WIDTH: 0.477129
G1 F1500
M204 S6000
G1 X86.367 Y97.319 E.00533
; LINE_WIDTH: 0.438433
G1 X86.16 Y97.496 E.00561
; LINE_WIDTH: 0.400651
G1 X85.986 Y97.673 E.00464
; LINE_WIDTH: 0.360224
G1 X85.628 Y98.072 E.00895
G1 X85.425 Y98.365 E.00594
G1 X85.296 Y98.606 E.00456
G1 X85.178 Y98.891 E.00515
G1 X85.052 Y99.36 E.0081
G1 X85.01 Y99.724 E.00611
G1 X85.017 Y100.183 E.00766
M73 P81 R4
G1 X85.086 Y100.603 E.0071
G1 X85.193 Y100.946 E.00599
G1 X85.419 Y101.42 E.00877
G1 X85.613 Y101.716 E.0059
G1 X85.939 Y102.078 E.00813
G1 X86.36 Y102.412 E.00897
G1 X86.797 Y102.646 E.00827
G1 X87.219 Y102.796 E.00748
G1 X87.536 Y102.859 E.00539
G1 X88.03 Y102.9 E.00827
G1 X88.553 Y102.847 E.00877
G1 X88.915 Y102.755 E.00623
G1 X89.242 Y102.628 E.00586
G1 X89.732 Y102.345 E.00945
G1 X90.135 Y102.007 E.00877
G1 X90.377 Y101.73 E.00614
G1 X90.579 Y101.431 E.00603
G1 X90.799 Y100.974 E.00846
G1 X90.867 Y100.768 E.00362
G1 X90.975 Y100.25 E.00884
G1 X91.001 Y99.891 E.006
G1 X90.945 Y99.352 E.00905
G1 X90.861 Y99.013 E.00583
G1 X90.666 Y98.525 E.00877
G1 X90.378 Y98.08 E.00884
G1 X90.142 Y97.801 E.0061
; LINE_WIDTH: 0.382208
G1 X89.876 Y97.53 E.00675
; LINE_WIDTH: 0.426914
G1 X89.751 Y97.417 E.00338
; LINE_WIDTH: 0.468076
G1 X89.626 Y97.304 E.00372
G1 X89.603 Y97.308 E.0005
; LINE_WIDTH: 0.442956
G1 X89.444 Y97.338 E.00337
; LINE_WIDTH: 0.416214
G1 X89.284 Y97.368 E.00316
; WIPE_START
G1 X89.444 Y97.338 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X94.53 Y96.242 Z4.56 F18000
G1 Z4.16
G1 E.4 F1800
; LINE_WIDTH: 0.104156
G1 F1500
M204 S6000
G1 X94.675 Y96.186 E.00061
; LINE_WIDTH: 0.153103
G1 X94.855 Y96.085 E.00131
G1 X95.035 Y95.875 E.00175
; LINE_WIDTH: 0.133399
G1 X95.095 Y95.773 E.00064
; LINE_WIDTH: 0.0954349
G1 X95.143 Y95.609 E.0006
; WIPE_START
G1 X95.095 Y95.773 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X95.117 Y88.141 Z4.56 F18000
G1 X95.146 Y77.599 Z4.56
G1 Z4.16
G1 E.4 F1800
; LINE_WIDTH: 0.103338
G1 F1500
M204 S6000
G1 X95.074 Y77.39 E.00086
; LINE_WIDTH: 0.150707
G1 X94.946 Y77.212 E.00137
G1 X94.832 Y77.097 E.00101
G1 X94.69 Y77.022 E.001
; LINE_WIDTH: 0.120092
G1 X94.606 Y76.991 E.00042
; LINE_WIDTH: 0.0931918
G1 X94.521 Y76.961 E.0003
; WIPE_START
G1 X94.606 Y76.991 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X86.973 Y76.97 Z4.56 F18000
G1 X81.496 Y76.955 Z4.56
G1 Z4.16
G1 E.4 F1800
; LINE_WIDTH: 0.0897724
G1 F1500
M204 S6000
G1 X81.393 Y76.991 E.00035
; LINE_WIDTH: 0.129555
G1 X81.198 Y77.08 E.00111
; LINE_WIDTH: 0.152665
G1 X80.962 Y77.32 E.00213
G1 X80.912 Y77.423 E.00073
; LINE_WIDTH: 0.115065
G1 X80.883 Y77.514 E.00042
; LINE_WIDTH: 0.0897377
G1 X80.854 Y77.604 E.0003
; WIPE_START
G1 X80.883 Y77.514 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X88.28 Y79.394 Z4.56 F18000
G1 X96.743 Y81.544 Z4.56
G1 Z4.16
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X97.257 Y81.544 E.01086
G1 X97.257 Y82.057 E.01086
G1 X96.743 Y82.057 E.01086
G1 X96.743 Y81.604 E.00959
M204 S10000
G1 X96.319 Y81.12 F18000
G1 F1500
M204 S500
G1 X97.681 Y81.12 E.02882
G1 X97.681 Y82.482 E.02882
G1 X96.319 Y82.482 E.02882
G1 X96.319 Y81.18 E.02755
M204 S250
G1 X95.91 Y80.711 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X98.09 Y80.711 E.04288
G1 X98.09 Y82.891 E.04288
G1 X95.91 Y82.891 E.04288
G1 X95.91 Y80.771 E.0417
; CHANGE_LAYER
; Z_HEIGHT: 4.28
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F1500
M204 S6000
G1 X97.909 Y80.716 E-.38
; WIPE_END
G1 E-.02 F1800
; layer num/total_layer_count: 35/49
; update layer progress
M73 L35
M991 S0 P34 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z4.56 I-1.074 J-.572 P1  F18000
G1 X89.192 Y97.087 Z4.56
G1 Z4.28
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X88.604 Y96.915 E.01297
G1 X88.23 Y96.864 E.00799
G1 X87.892 Y96.858 E.00717
G1 X87.327 Y96.928 E.01204
G1 X86.766 Y97.11 E.01249
G1 X86.659 Y96.949 E.0041
G1 X87.012 Y96.543 E.01137
G1 X88.952 Y96.543 E.04107
G1 X89.295 Y96.924 E.01085
G1 X89.224 Y97.036 E.0028
; WIPE_START
M204 S6000
G1 X88.604 Y96.915 E-.12003
G1 X88.23 Y96.864 E-.07173
G1 X87.892 Y96.858 E-.06436
G1 X87.327 Y96.928 E-.10807
G1 X87.248 Y96.954 E-.01581
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X90.617 Y99.848 Z4.68 F18000
G1 Z4.28
G1 E.4 F1800
G1 F1500
M204 S500
G1 X90.621 Y99.892 E.00093
G1 X90.602 Y100.212 E.0068
G1 X90.552 Y100.492 E.00601
G1 X90.397 Y100.964 E.01053
G1 X90.166 Y101.378 E.01002
G1 X89.874 Y101.734 E.00975
G1 X89.634 Y101.95 E.00683
G1 X89.37 Y102.135 E.00683
G1 X88.958 Y102.341 E.00976
G1 X88.507 Y102.473 E.00994
G1 X88.039 Y102.522 E.00995
G1 X87.58 Y102.488 E.00975
G1 X87.265 Y102.416 E.00683
G1 X86.962 Y102.307 E.00683
G1 X86.556 Y102.089 E.00976
G1 X86.188 Y101.796 E.00995
G1 X85.877 Y101.439 E.01002
G1 X85.626 Y101.01 E.01053
G1 X85.52 Y100.746 E.00601
G1 X85.434 Y100.437 E.00679
G1 X85.379 Y99.979 E.00975
G1 X85.408 Y99.507 E.01002
G1 X85.531 Y99.025 E.01053
G1 X85.64 Y98.763 E.00601
G1 X85.796 Y98.482 E.0068
G1 X86.078 Y98.118 E.00975
G1 X86.421 Y97.809 E.00975
G1 X86.69 Y97.632 E.00683
G1 X86.978 Y97.487 E.00683
G1 X87.42 Y97.344 E.00982
G1 X87.914 Y97.282 E.01053
G1 X88.197 Y97.288 E.00601
G1 X88.516 Y97.331 E.0068
G1 X88.958 Y97.46 E.00974
G1 X89.37 Y97.666 E.00975
G1 X89.634 Y97.852 E.00683
G1 X89.874 Y98.068 E.00683
G1 X90.16 Y98.417 E.00955
G1 X90.325 Y98.692 E.0068
G1 X90.442 Y98.951 E.00601
G1 X90.579 Y99.429 E.01053
G1 X90.612 Y99.788 E.00763
M204 S250
G1 X90.209 Y99.885 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X90.211 Y99.898 E.00026
G1 X90.195 Y100.164 E.00525
G1 X90.155 Y100.392 E.00454
G1 X90.02 Y100.799 E.00844
G1 X89.827 Y101.146 E.00782
G1 X89.577 Y101.45 E.00773
G1 X89.378 Y101.629 E.00526
G1 X89.159 Y101.783 E.00526
G1 X88.808 Y101.959 E.00774
G1 X88.427 Y102.07 E.00779
G1 X88.033 Y102.111 E.0078
G1 X87.641 Y102.082 E.00773
G1 X87.38 Y102.023 E.00526
G1 X87.128 Y101.932 E.00526
G1 X86.782 Y101.746 E.00774
G1 X86.472 Y101.499 E.0078
G1 X86.211 Y101.199 E.00782
G1 X85.995 Y100.829 E.00844
G1 X85.908 Y100.615 E.00454
G1 X85.837 Y100.357 E.00525
G1 X85.79 Y99.967 E.00773
G1 X85.814 Y99.57 E.00782
G1 X85.92 Y99.155 E.00844
G1 X86.009 Y98.941 E.00454
G1 X86.139 Y98.708 E.00525
G1 X86.379 Y98.397 E.00774
G1 X86.672 Y98.134 E.00773
G1 X86.895 Y97.987 E.00526
G1 X87.134 Y97.867 E.00526
G1 X87.509 Y97.745 E.00775
G1 X87.935 Y97.692 E.00844
G1 X88.166 Y97.697 E.00454
G1 X88.43 Y97.733 E.00525
G1 X88.808 Y97.843 E.00773
G1 X89.159 Y98.019 E.00773
G1 X89.378 Y98.173 E.00526
G1 X89.577 Y98.352 E.00526
G1 X89.825 Y98.653 E.00767
G1 X89.962 Y98.882 E.00525
G1 X90.057 Y99.093 E.00454
G1 X90.175 Y99.505 E.00844
G1 X90.204 Y99.825 E.00632
; WIPE_START
M204 S6000
G1 X90.211 Y99.898 E-.01387
G1 X90.195 Y100.164 E-.05073
G1 X90.155 Y100.392 E-.04387
G1 X90.02 Y100.799 E-.08151
G1 X89.827 Y101.146 E-.07556
G1 X89.577 Y101.45 E-.07468
G1 X89.421 Y101.59 E-.03978
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X86.761 Y96.119 Z4.68 F18000
G1 Z4.28
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X94.119 Y96.118 E.15573
G1 X94.406 Y96.044 E.00628
G1 X94.667 Y95.881 E.00651
G1 X94.879 Y95.632 E.00692
G1 X95.008 Y95.316 E.00722
G1 X95.013 Y94.72 E.01261
G1 X95.381 Y94.72 E.00778
G1 X95.381 Y95.565 E.01788
G1 X95.353 Y95.803 E.00508
G1 X95.28 Y96.003 E.0045
G1 X95.208 Y96.12 E.0029
G1 X95.073 Y96.265 E.00422
G1 X94.944 Y96.358 E.00336
G1 X94.751 Y96.441 E.00443
G1 X94.533 Y96.479 E.0047
G1 X89.468 Y96.483 E.1072
G1 X90.585 Y97.725 E.03537
G1 X90.794 Y97.999 E.00728
G1 X91.084 Y98.517 E.01258
G1 X91.229 Y98.901 E.00868
G1 X91.324 Y99.291 E.00849
G1 X91.374 Y99.699 E.00869
G1 X91.357 Y100.296 E.01264
G1 X91.235 Y100.878 E.01259
G1 X91.096 Y101.256 E.00853
G1 X90.91 Y101.622 E.00869
G1 X90.558 Y102.11 E.01274
G1 X90.438 Y102.242 E.00378
G1 X90.081 Y102.562 E.01014
G1 X89.643 Y102.855 E.01116
G1 X89.273 Y103.032 E.00869
G1 X88.893 Y103.161 E.00849
G1 X88.5 Y103.243 E.0085
G1 X88.1 Y103.279 E.00849
G1 X87.699 Y103.267 E.00849
G1 X87.116 Y103.164 E.01254
G1 X86.719 Y103.029 E.00889
G1 X86.193 Y102.757 E.01253
G1 X85.867 Y102.522 E.0085
G1 X85.441 Y102.109 E.01257
G1 X85.231 Y101.836 E.00727
G1 X84.988 Y101.434 E.00995
G1 X84.829 Y101.07 E.00841
G1 X84.714 Y100.689 E.00842
G1 X84.637 Y100.225 E.00995
G1 X84.626 Y99.699 E.01116
G1 X84.676 Y99.291 E.00869
G1 X84.772 Y98.901 E.00849
G1 X84.913 Y98.526 E.00849
G1 X85.097 Y98.17 E.00849
G1 X85.323 Y97.838 E.00849
G1 X86.503 Y96.482 E.03805
G1 X81.536 Y96.482 E.10513
G1 X81.289 Y96.453 E.00527
G1 X81.143 Y96.405 E.00324
G1 X80.981 Y96.31 E.00398
G1 X80.883 Y96.224 E.00276
G1 X80.733 Y96.027 E.00524
G1 X80.649 Y95.818 E.00478
G1 X80.619 Y95.565 E.00539
G1 X80.619 Y77.619 E.37984
G1 X80.659 Y77.349 E.00577
G1 X80.761 Y77.125 E.0052
G1 X80.944 Y76.921 E.00582
G1 X81.059 Y76.841 E.00296
G1 X81.2 Y76.775 E.00328
G1 X81.449 Y76.723 E.00539
G1 X94.51 Y76.722 E.27645
G1 X94.763 Y76.764 E.00543
G1 X94.98 Y76.864 E.00506
G1 X95.165 Y77.028 E.00523
G1 X95.283 Y77.208 E.00454
G1 X95.356 Y77.407 E.0045
G1 X95.378 Y77.559 E.00325
G1 X95.38 Y78.482 E.01952
G1 X95.019 Y78.482 E.00763
G1 X95.019 Y78.056 E.009
G1 X94.984 Y77.81 E.00527
G1 X94.859 Y77.539 E.0063
G1 X94.647 Y77.303 E.00672
G1 X94.359 Y77.139 E.00702
G1 X94.087 Y77.082 E.00589
G1 X81.946 Y77.082 E.25697
G1 X81.657 Y77.132 E.0062
G1 X81.387 Y77.278 E.00649
G1 X81.171 Y77.495 E.00649
G1 X81.019 Y77.797 E.00717
G1 X80.981 Y78.056 E.00553
G1 X80.981 Y95.164 E.36211
G1 X81.05 Y95.501 E.00727
G1 X81.257 Y95.815 E.00796
G1 X81.591 Y96.049 E.00864
G1 X81.937 Y96.12 E.00747
G1 X86.701 Y96.119 E.10084
; WIPE_START
M204 S6000
G1 X88.701 Y96.119 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X85.605 Y96.891 Z4.68 F18000
G1 Z4.28
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X81.512 Y96.891 E.08049
G1 X81.2 Y96.854 E.00619
G1 X80.986 Y96.784 E.00442
G1 X80.855 Y96.718 E.00289
G1 X80.582 Y96.505 E.00682
G1 X80.381 Y96.241 E.00651
G1 X80.296 Y96.061 E.00391
G1 X80.247 Y95.903 E.00326
G1 X80.21 Y95.589 E.00623
G1 X80.21 Y77.607 E.35368
G1 X80.219 Y77.454 E.00301
G1 X80.265 Y77.231 E.00448
G1 X80.349 Y77.019 E.00448
G1 X80.421 Y76.895 E.00283
G1 X80.564 Y76.715 E.00452
G1 X80.688 Y76.6 E.00332
G1 X80.855 Y76.485 E.004
G1 X81.059 Y76.389 E.00443
G1 X81.279 Y76.33 E.00448
G1 X81.425 Y76.313 E.00289
G1 X94.544 Y76.313 E.25804
G1 X94.874 Y76.367 E.00657
G1 X95.081 Y76.45 E.0044
G1 X95.208 Y76.523 E.00287
G1 X95.344 Y76.627 E.00338
G1 X95.485 Y76.769 E.00394
G1 X95.652 Y77.023 E.00596
G1 X95.755 Y77.307 E.00594
G1 X95.787 Y77.529 E.00442
G1 X95.79 Y78.891 E.02678
G1 X94.61 Y78.891 E.0232
G1 X94.61 Y78.086 E.01584
G1 X94.587 Y77.927 E.00315
G1 X94.513 Y77.767 E.00348
G1 X94.387 Y77.626 E.00372
G1 X94.213 Y77.526 E.00394
G1 X94.045 Y77.492 E.00337
G1 X81.982 Y77.491 E.23727
G1 X81.793 Y77.524 E.00376
G1 X81.634 Y77.61 E.00355
G1 X81.507 Y77.738 E.00355
G1 X81.414 Y77.922 E.00406
G1 X81.39 Y78.086 E.00325
G1 X81.39 Y95.122 E.3351
G1 X81.435 Y95.341 E.00439
G1 X81.556 Y95.524 E.00431
G1 X81.757 Y95.665 E.00482
G1 X81.979 Y95.711 E.00446
G1 X94.066 Y95.709 E.23776
G1 X94.243 Y95.663 E.00359
G1 X94.397 Y95.567 E.00357
G1 X94.525 Y95.417 E.00388
G1 X94.599 Y95.234 E.00388
G1 X94.608 Y94.311 E.01816
G1 X95.79 Y94.311 E.02325
G1 X95.79 Y95.589 E.02513
G1 X95.754 Y95.898 E.00613
G1 X95.65 Y96.182 E.00594
G1 X95.535 Y96.369 E.00431
G1 X95.344 Y96.574 E.00552
G1 X95.146 Y96.716 E.00479
G1 X94.87 Y96.835 E.00592
G1 X94.569 Y96.888 E.00601
G1 X90.386 Y96.891 E.08228
G1 X90.901 Y97.464 E.01515
G1 X91.133 Y97.769 E.00755
G1 X91.366 Y98.159 E.00892
G1 X91.461 Y98.356 E.00431
G1 X91.62 Y98.78 E.00891
G1 X91.727 Y99.217 E.00885
G1 X91.783 Y99.667 E.00891
G1 X91.79 Y99.886 E.0043
G1 X91.764 Y100.34 E.00895
G1 X91.719 Y100.625 E.00568
G1 X91.627 Y100.998 E.00755
G1 X91.472 Y101.42 E.00886
G1 X91.266 Y101.824 E.00891
G1 X91.149 Y102.009 E.00431
G1 X90.873 Y102.372 E.00897
G1 X90.727 Y102.533 E.00428
G1 X90.337 Y102.882 E.01028
G1 X89.836 Y103.216 E.01186
G1 X89.427 Y103.412 E.00891
G1 X89.001 Y103.556 E.00885
G1 X88.561 Y103.649 E.00885
G1 X88.113 Y103.689 E.00885
G1 X87.663 Y103.676 E.00885
G1 X87.215 Y103.608 E.00891
G1 X87.002 Y103.557 E.0043
G1 X86.57 Y103.411 E.00898
G1 X86.37 Y103.322 E.0043
G1 X85.973 Y103.103 E.00891
G1 X85.608 Y102.84 E.00885
G1 X85.274 Y102.534 E.00891
G1 X84.893 Y102.068 E.01185
G1 X84.624 Y101.623 E.01022
G1 X84.444 Y101.212 E.00882
G1 X84.314 Y100.782 E.00883
G1 X84.23 Y100.269 E.01022
G1 X84.21 Y99.886 E.00755
G1 X84.217 Y99.667 E.00431
G1 X84.273 Y99.217 E.00891
G1 X84.38 Y98.78 E.00885
G1 X84.538 Y98.359 E.00885
G1 X84.745 Y97.96 E.00885
G1 X84.998 Y97.588 E.00885
G1 X85.565 Y96.936 E.01698
; WIPE_START
M204 S6000
G1 X83.565 Y96.914 E-.38
; WIPE_END
M73 P82 R4
G1 E-.02 F1800
M204 S10000
G17
G3 Z4.68 I1.217 J0 P1  F18000
;===================== date: 20250206 =====================

; don't support timelapse gcode in spiral_mode and by object sequence for I3 structure printer
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
G92 E0
G1 Z4.68
G1 X0 Y90 ; move to safe pos
G1 X-13.0 F3000 ; move to safe pos
M400
M1004 S5 P1  ; external shutter
M400 P300
M971 S11 C11 O0
G92 E0
G1 X0 F18000
M623

; SKIPTYPE: head_wrap_detect
M622.1 S1
M1002 judge_flag g39_3rd_layer_detect_flag
M622 J1
    ; enable nozzle clog detect at 3rd layer
    


    M622.1 S1
    M1002 judge_flag g39_detection_flag
    M622 J1
      
        M622.1 S0
        M1002 judge_flag g39_mass_exceed_flag
        M622 J1
        
            G392 S0
            M400
            G90
            M83
            M204 S5000
            G0 Z4.68 F4000
            G39.3 S1
            G0 Z4.68 F4000
            G392 S0
          
        M623
    
    M623
M623
; SKIPPABLE_END




G1 X81.456 Y96.238
G1 Z4.28
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.096275
G1 F1500
M204 S6000
G1 X81.354 Y96.193 E.00039
; LINE_WIDTH: 0.148856
G1 X81.251 Y96.148 E.00069
G1 X81.067 Y96.015 E.0014
G1 X80.845 Y95.659 E.00258
; WIPE_START
G1 X81.067 Y96.015 E-.21015
G1 X81.251 Y96.148 E-.11375
G1 X81.354 Y96.193 E-.0561
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X86.548 Y97.165 Z4.68 F18000
G1 Z4.28
G1 E.4 F1800
; LINE_WIDTH: 0.477102
G1 F1500
M204 S6000
G1 X86.367 Y97.319 E.00534
; LINE_WIDTH: 0.438377
G1 X86.16 Y97.496 E.00562
; LINE_WIDTH: 0.400589
G1 X85.986 Y97.673 E.00464
; LINE_WIDTH: 0.359917
G1 X85.628 Y98.073 E.00894
G1 X85.425 Y98.365 E.00593
G1 X85.296 Y98.606 E.00456
G1 X85.177 Y98.894 E.00519
G1 X85.052 Y99.358 E.00801
G1 X85.003 Y100.005 E.01083
G1 X85.067 Y100.521 E.00867
G1 X85.187 Y100.938 E.00722
G1 X85.328 Y101.258 E.00583
G1 X85.58 Y101.672 E.00808
G1 X85.941 Y102.075 E.00903
G1 X86.336 Y102.395 E.00847
G1 X86.717 Y102.61 E.00729
G1 X87.169 Y102.781 E.00806
G1 X87.536 Y102.859 E.00626
G1 X88.03 Y102.9 E.00826
G1 X88.443 Y102.864 E.00691
G1 X88.791 Y102.79 E.00593
G1 X89.13 Y102.68 E.00593
G1 X89.573 Y102.451 E.00832
G1 X89.861 Y102.251 E.00585
G1 X90.266 Y101.861 E.00937
G1 X90.483 Y101.576 E.00596
G1 X90.749 Y101.104 E.00904
G1 X90.866 Y100.768 E.00593
G1 X90.979 Y100.253 E.00879
G1 X90.991 Y99.723 E.00884
G1 X90.952 Y99.359 E.00609
G1 X90.861 Y99.017 E.0059
G1 X90.667 Y98.528 E.00877
G1 X90.477 Y98.209 E.0062
G1 X90.139 Y97.797 E.00888
; LINE_WIDTH: 0.380155
G1 X89.874 Y97.533 E.00662
; LINE_WIDTH: 0.421077
G1 X89.742 Y97.415 E.00349
; LINE_WIDTH: 0.47167
G1 X89.592 Y97.283 E.00445
G1 X89.265 Y97.37 E.00753
; WIPE_START
G1 X89.592 Y97.283 E-.23893
G1 X89.742 Y97.415 E-.14107
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X94.53 Y96.242 Z4.68 F18000
G1 Z4.28
G1 E.4 F1800
; LINE_WIDTH: 0.104132
G1 F1500
M204 S6000
G1 X94.675 Y96.186 E.00061
; LINE_WIDTH: 0.150312
G1 X94.855 Y96.084 E.00128
G1 X95.032 Y95.878 E.00169
; LINE_WIDTH: 0.131306
G1 X95.095 Y95.77 E.00066
; LINE_WIDTH: 0.0955275
G1 X95.137 Y95.623 E.00053
; WIPE_START
G1 X95.095 Y95.77 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X95.117 Y88.138 Z4.68 F18000
G1 X95.147 Y77.602 Z4.68
G1 Z4.28
G1 E.4 F1800
; LINE_WIDTH: 0.103061
G1 F1500
M204 S6000
G1 X95.074 Y77.39 E.00086
; LINE_WIDTH: 0.150603
G1 X94.945 Y77.21 E.00138
G1 X94.828 Y77.094 E.00102
G1 X94.69 Y77.021 E.00097
; LINE_WIDTH: 0.120143
G1 X94.606 Y76.991 E.00042
; LINE_WIDTH: 0.0932107
G1 X94.521 Y76.961 E.0003
; WIPE_START
G1 X94.606 Y76.991 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X86.973 Y76.97 Z4.68 F18000
G1 X81.496 Y76.955 Z4.68
G1 Z4.28
G1 E.4 F1800
; LINE_WIDTH: 0.089773
G1 F1500
M204 S6000
G1 X81.393 Y76.991 E.00035
; LINE_WIDTH: 0.129549
G1 X81.198 Y77.079 E.00111
; LINE_WIDTH: 0.152669
G1 X80.962 Y77.32 E.00213
G1 X80.912 Y77.424 E.00073
; LINE_WIDTH: 0.115073
G1 X80.883 Y77.514 E.00042
; LINE_WIDTH: 0.0897417
G1 X80.854 Y77.604 E.0003
; WIPE_START
G1 X80.883 Y77.514 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X88.29 Y79.354 Z4.68 F18000
G1 X96.623 Y81.424 Z4.68
G1 Z4.28
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X97.377 Y81.424 E.01594
G1 X97.377 Y82.177 E.01594
G1 X96.623 Y82.177 E.01594
G1 X96.623 Y81.484 E.01467
M204 S10000
G1 X96.199 Y81 F18000
G1 F1500
M204 S500
G1 X97.801 Y81 E.0339
G1 X97.801 Y82.602 E.0339
G1 X96.199 Y82.602 E.0339
G1 X96.199 Y81.06 E.03263
M204 S250
G1 X95.79 Y80.591 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F2340
M204 S500
G1 X98.21 Y80.591 E.0476
G1 X98.21 Y83.011 E.0476
G1 X95.79 Y83.011 E.0476
G1 X95.79 Y80.651 E.04642
; CHANGE_LAYER
; Z_HEIGHT: 4.4
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F2340
M204 S6000
G1 X97.789 Y80.601 E-.38
; WIPE_END
G1 E-.02 F1800
; layer num/total_layer_count: 36/49
; update layer progress
M73 L36
M991 S0 P35 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z4.68 I-1.079 J-.563 P1  F18000
G1 X89.191 Y97.087 Z4.68
G1 Z4.4
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X88.604 Y96.915 E.01294
G1 X88.23 Y96.864 E.00799
G1 X87.888 Y96.858 E.00723
G1 X87.327 Y96.928 E.01198
G1 X86.835 Y97.088 E.01095
G1 X86.729 Y96.922 E.00416
G1 X87.079 Y96.543 E.01092
G1 X88.95 Y96.543 E.03962
G1 X89.293 Y96.924 E.01085
G1 X89.223 Y97.036 E.0028
; WIPE_START
M204 S6000
G1 X88.604 Y96.915 E-.11973
G1 X88.23 Y96.864 E-.07175
G1 X87.888 Y96.858 E-.06493
G1 X87.327 Y96.928 E-.10755
G1 X87.247 Y96.954 E-.01602
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X90.618 Y99.86 Z4.8 F18000
G1 Z4.4
G1 E.4 F1800
G1 F1500
M204 S500
G1 X90.621 Y99.91 E.00105
G1 X90.58 Y100.36 E.00955
G1 X90.504 Y100.673 E.00683
G1 X90.391 Y100.975 E.00683
G1 X90.166 Y101.378 E.00975
G1 X89.868 Y101.741 E.00995
G1 X89.507 Y102.047 E.01002
G1 X89.075 Y102.29 E.01048
G1 X88.808 Y102.393 E.00607
G1 X88.497 Y102.474 E.0068
G1 X88.036 Y102.523 E.00982
G1 X87.543 Y102.481 E.01048
G1 X87.264 Y102.416 E.00606
G1 X86.961 Y102.307 E.0068
G1 X86.556 Y102.089 E.00975
G1 X86.186 Y101.794 E.01001
G1 X85.864 Y101.418 E.01048
G1 X85.711 Y101.176 E.00606
G1 X85.571 Y100.886 E.0068
G1 X85.436 Y100.446 E.00975
G1 X85.379 Y99.979 E.00995
G1 X85.407 Y99.519 E.00975
G1 X85.474 Y99.204 E.00683
G1 X85.578 Y98.898 E.00683
G1 X85.791 Y98.489 E.00975
G1 X86.072 Y98.125 E.00975
G1 X86.305 Y97.903 E.0068
G1 X86.533 Y97.73 E.00606
G1 X86.967 Y97.491 E.01048
G1 X87.419 Y97.344 E.01008
G1 X87.911 Y97.282 E.01048
G1 X88.197 Y97.288 E.00607
G1 X88.516 Y97.331 E.0068
G1 X88.958 Y97.46 E.00975
G1 X89.37 Y97.667 E.00975
G1 X89.634 Y97.852 E.00683
G1 X89.874 Y98.068 E.00683
G1 X90.166 Y98.424 E.00975
G1 X90.397 Y98.837 E.01002
G1 X90.552 Y99.307 E.01048
G1 X90.602 Y99.59 E.00606
G1 X90.614 Y99.801 E.00447
M204 S250
G1 X90.209 Y99.885 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X90.211 Y99.904 E.00038
G1 X90.176 Y100.292 E.00767
G1 X90.112 Y100.552 E.00526
G1 X90.018 Y100.803 E.00526
G1 X89.827 Y101.146 E.00773
G1 X89.575 Y101.452 E.0078
G1 X89.272 Y101.71 E.00782
G1 X88.9 Y101.919 E.00839
G1 X88.682 Y102.003 E.00459
G1 X88.424 Y102.07 E.00525
G1 X88.032 Y102.112 E.00776
G1 X87.607 Y102.075 E.00839
G1 X87.38 Y102.022 E.00459
G1 X87.128 Y101.932 E.00525
G1 X86.782 Y101.746 E.00773
G1 X86.471 Y101.498 E.00782
G1 X86.194 Y101.174 E.00839
G1 X86.069 Y100.977 E.00459
G1 X85.953 Y100.736 E.00525
G1 X85.837 Y100.361 E.00774
G1 X85.79 Y99.967 E.0078
G1 X85.814 Y99.574 E.00774
G1 X85.869 Y99.313 E.00526
G1 X85.956 Y99.06 E.00526
G1 X86.137 Y98.711 E.00773
G1 X86.377 Y98.4 E.00773
G1 X86.57 Y98.215 E.00525
G1 X86.756 Y98.074 E.00459
G1 X87.13 Y97.868 E.00839
G1 X87.509 Y97.745 E.00783
G1 X87.932 Y97.692 E.00839
G1 X88.166 Y97.697 E.00459
G1 X88.43 Y97.733 E.00525
G1 X88.808 Y97.843 E.00773
G1 X89.159 Y98.019 E.00774
G1 X89.378 Y98.173 E.00526
G1 X89.577 Y98.352 E.00526
G1 X89.827 Y98.655 E.00773
G1 X90.02 Y99.003 E.00782
G1 X90.154 Y99.408 E.00839
G1 X90.195 Y99.637 E.00459
G1 X90.206 Y99.825 E.00369
; WIPE_START
M204 S6000
G1 X90.211 Y99.904 E-.01504
G1 X90.176 Y100.292 E-.07409
G1 X90.112 Y100.552 E-.05083
G1 X90.018 Y100.803 E-.05084
G1 X89.827 Y101.146 E-.07471
G1 X89.575 Y101.452 E-.07531
G1 X89.418 Y101.586 E-.03917
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X86.834 Y96.119 Z4.8 F18000
G1 Z4.4
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X94.129 Y96.117 E.15439
G1 X94.415 Y96.04 E.00627
G1 X94.692 Y95.86 E.007
G1 X94.89 Y95.612 E.00671
G1 X95.008 Y95.312 E.00682
G1 X95.013 Y94.72 E.01253
G1 X95.381 Y94.72 E.00778
G1 X95.381 Y95.565 E.01788
G1 X95.353 Y95.803 E.00508
G1 X95.28 Y96.003 E.0045
G1 X95.209 Y96.118 E.00286
G1 X95.057 Y96.279 E.00469
G1 X94.947 Y96.356 E.00286
G1 X94.751 Y96.441 E.0045
G1 X94.533 Y96.479 E.0047
G1 X89.467 Y96.483 E.10722
G1 X90.582 Y97.722 E.03529
G1 X90.794 Y97.999 E.00738
G1 X91.084 Y98.517 E.01257
G1 X91.229 Y98.901 E.00868
G1 X91.354 Y99.48 E.01254
G1 X91.38 Y99.89 E.00869
G1 X91.357 Y100.296 E.0086
G1 X91.235 Y100.878 E.01259
G1 X91.096 Y101.256 E.00852
G1 X90.91 Y101.622 E.00869
G1 X90.558 Y102.11 E.01274
G1 X90.292 Y102.385 E.0081
G1 X89.974 Y102.644 E.00868
G1 X89.635 Y102.859 E.0085
G1 X89.273 Y103.032 E.00849
G1 X88.893 Y103.161 E.00849
G1 X88.5 Y103.243 E.0085
G1 X88.1 Y103.279 E.00849
G1 X87.699 Y103.267 E.00849
G1 X87.116 Y103.164 E.01253
G1 X86.727 Y103.032 E.00869
G1 X86.368 Y102.86 E.00842
G1 X85.978 Y102.607 E.00985
G1 X85.577 Y102.258 E.01125
G1 X85.31 Y101.947 E.00869
G1 X85.086 Y101.613 E.00849
G1 X84.905 Y101.259 E.00842
G1 X84.749 Y100.821 E.00985
G1 X84.643 Y100.3 E.01125
G1 X84.62 Y99.89 E.00869
G1 X84.645 Y99.49 E.00849
G1 X84.718 Y99.095 E.00849
G1 X84.837 Y98.712 E.00849
G1 X84.998 Y98.348 E.00842
G1 X85.241 Y97.951 E.00984
G1 X85.455 Y97.676 E.00737
G1 X86.558 Y96.482 E.03442
G1 X81.536 Y96.482 E.10629
G1 X81.298 Y96.454 E.00508
G1 X81.098 Y96.381 E.0045
G1 X80.968 Y96.301 E.00324
G1 X80.801 Y96.134 E.00499
G1 X80.742 Y96.045 E.00225
G1 X80.649 Y95.821 E.00513
G1 X80.619 Y95.565 E.00546
G1 X80.619 Y77.619 E.37984
G1 X80.659 Y77.349 E.00577
G1 X80.765 Y77.118 E.00539
G1 X80.935 Y76.928 E.00539
G1 X81.061 Y76.84 E.00324
G1 X81.205 Y76.773 E.00337
G1 X81.456 Y76.723 E.00542
G1 X94.512 Y76.722 E.27634
G1 X94.763 Y76.764 E.00539
G1 X94.976 Y76.861 E.00495
G1 X95.162 Y77.022 E.0052
G1 X95.283 Y77.207 E.00469
G1 X95.356 Y77.407 E.0045
G1 X95.378 Y77.559 E.00325
G1 X95.38 Y78.482 E.01952
G1 X95.019 Y78.482 E.00763
G1 X95.019 Y78.056 E.009
G1 X94.984 Y77.81 E.00527
G1 X94.859 Y77.539 E.0063
G1 X94.647 Y77.303 E.00672
G1 X94.359 Y77.139 E.00701
G1 X94.087 Y77.082 E.00589
G1 X81.946 Y77.082 E.25698
G1 X81.657 Y77.133 E.0062
G1 X81.379 Y77.283 E.00669
G1 X81.147 Y77.529 E.00716
G1 X81.017 Y77.807 E.00649
G1 X80.981 Y78.056 E.00533
G1 X80.981 Y95.158 E.36198
G1 X81.039 Y95.473 E.00678
G1 X81.251 Y95.811 E.00844
G1 X81.591 Y96.049 E.00879
G1 X81.937 Y96.12 E.00747
G1 X86.774 Y96.119 E.10239
; WIPE_START
M204 S6000
G1 X88.774 Y96.119 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X85.623 Y96.891 Z4.8 F18000
G1 Z4.4
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X81.512 Y96.891 E.08086
G1 X81.203 Y96.855 E.00613
G1 X80.919 Y96.751 E.00594
G1 X80.727 Y96.633 E.00442
G1 X80.617 Y96.541 E.00284
G1 X80.478 Y96.386 E.00409
G1 X80.384 Y96.247 E.00329
G1 X80.287 Y96.039 E.00452
G1 X80.247 Y95.904 E.00277
G1 X80.21 Y95.589 E.00625
G1 X80.21 Y77.607 E.35368
G1 X80.219 Y77.454 E.00301
G1 X80.265 Y77.231 E.00448
G1 X80.349 Y77.02 E.00448
G1 X80.422 Y76.892 E.00289
G1 X80.51 Y76.774 E.00289
G1 X80.671 Y76.613 E.00448
G1 X80.855 Y76.484 E.00442
G1 X81.061 Y76.389 E.00446
G1 X81.222 Y76.342 E.00329
G1 X81.427 Y76.313 E.00409
G1 X94.546 Y76.313 E.25802
G1 X94.874 Y76.367 E.00654
G1 X95.081 Y76.45 E.0044
G1 X95.206 Y76.522 E.00283
G1 X95.387 Y76.665 E.00454
G1 X95.484 Y76.767 E.00277
G1 X95.651 Y77.023 E.006
G1 X95.755 Y77.307 E.00595
G1 X95.787 Y77.529 E.00442
G1 X95.79 Y78.891 E.02678
G1 X94.61 Y78.891 E.0232
G1 X94.61 Y78.086 E.01584
G1 X94.587 Y77.927 E.00315
G1 X94.513 Y77.767 E.00348
G1 X94.387 Y77.626 E.00373
G1 X94.213 Y77.526 E.00393
G1 X94.045 Y77.492 E.00337
G1 X81.982 Y77.491 E.23728
G1 X81.793 Y77.524 E.00376
G1 X81.632 Y77.611 E.00362
G1 X81.49 Y77.761 E.00406
G1 X81.413 Y77.925 E.00356
G1 X81.39 Y78.086 E.00319
G1 X81.39 Y95.12 E.33505
G1 X81.427 Y95.321 E.00402
G1 X81.554 Y95.523 E.00468
G1 X81.757 Y95.665 E.00488
G1 X81.979 Y95.711 E.00446
G1 X94.075 Y95.708 E.23792
G1 X94.246 Y95.662 E.00349
G1 X94.414 Y95.553 E.00393
G1 X94.531 Y95.405 E.00372
G1 X94.599 Y95.233 E.00364
G1 X94.608 Y94.311 E.01814
G1 X95.79 Y94.311 E.02325
G1 X95.79 Y95.589 E.02513
G1 X95.754 Y95.898 E.00613
G1 X95.65 Y96.182 E.00594
G1 X95.536 Y96.368 E.0043
G1 X95.326 Y96.59 E.00601
G1 X95.147 Y96.716 E.0043
G1 X94.87 Y96.835 E.00594
G1 X94.569 Y96.888 E.00601
G1 X90.385 Y96.891 E.08229
G1 X90.898 Y97.46 E.01506
G1 X91.133 Y97.769 E.00764
G1 X91.366 Y98.159 E.00892
G1 X91.461 Y98.356 E.00431
G1 X91.62 Y98.78 E.00891
G1 X91.728 Y99.22 E.00891
G1 X91.761 Y99.437 E.00431
G1 X91.79 Y99.889 E.00891
G1 X91.764 Y100.34 E.00889
G1 X91.72 Y100.62 E.00558
G1 X91.627 Y100.998 E.00765
G1 X91.472 Y101.42 E.00886
G1 X91.266 Y101.824 E.00891
G1 X91.149 Y102.009 E.0043
G1 X90.873 Y102.372 E.00898
G1 X90.565 Y102.691 E.00872
M73 P83 R4
G1 X90.213 Y102.977 E.00891
G1 X89.833 Y103.218 E.00885
G1 X89.427 Y103.412 E.00885
G1 X89.001 Y103.556 E.00885
G1 X88.56 Y103.649 E.00885
G1 X88.113 Y103.689 E.00884
G1 X87.663 Y103.676 E.00885
G1 X87.215 Y103.608 E.00891
G1 X87.002 Y103.557 E.0043
G1 X86.573 Y103.412 E.00891
G1 X86.168 Y103.218 E.00883
G1 X85.736 Y102.938 E.01013
G1 X85.279 Y102.538 E.01194
G1 X84.983 Y102.195 E.00891
G1 X84.733 Y101.821 E.00885
G1 X84.529 Y101.421 E.00883
G1 X84.356 Y100.936 E.01013
G1 X84.268 Y100.558 E.00765
G1 X84.236 Y100.341 E.00431
G1 X84.21 Y99.889 E.00891
G1 X84.239 Y99.44 E.00885
G1 X84.32 Y98.997 E.00885
G1 X84.453 Y98.567 E.00885
G1 X84.635 Y98.157 E.00883
G1 X84.904 Y97.718 E.01013
G1 X85.142 Y97.411 E.00764
G1 X85.582 Y96.935 E.01276
; WIPE_START
M204 S6000
G1 X83.583 Y96.913 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G17
G3 Z4.8 I1.217 J0 P1  F18000
;===================== date: 20250206 =====================

; don't support timelapse gcode in spiral_mode and by object sequence for I3 structure printer
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
G92 E0
G1 Z4.8
G1 X0 Y90 ; move to safe pos
G1 X-13.0 F3000 ; move to safe pos
M400
M1004 S5 P1  ; external shutter
M400 P300
M971 S11 C11 O0
G92 E0
G1 X0 F18000
M623

; SKIPTYPE: head_wrap_detect
M622.1 S1
M1002 judge_flag g39_3rd_layer_detect_flag
M622 J1
    ; enable nozzle clog detect at 3rd layer
    


    M622.1 S1
    M1002 judge_flag g39_detection_flag
    M622 J1
      
        M622.1 S0
        M1002 judge_flag g39_mass_exceed_flag
        M622 J1
        
            G392 S0
            M400
            G90
            M83
            M204 S5000
            G0 Z4.8 F4000
            G39.3 S1
            G0 Z4.8 F4000
            G392 S0
          
        M623
    
    M623
M623
; SKIPPABLE_END




G1 X81.452 Y96.25
G1 Z4.4
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.148035
G1 F1500
M204 S6000
G1 X81.221 Y96.13 E.00159
G1 X81.06 Y96.009 E.00123
G1 X80.983 Y95.906 E.00078
G1 X80.843 Y95.649 E.00179
; WIPE_START
G1 X80.983 Y95.906 E-.12595
G1 X81.06 Y96.009 E-.05533
G1 X81.221 Y96.13 E-.08688
G1 X81.452 Y96.25 E-.11183
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X86.613 Y97.135 Z4.8 F18000
G1 Z4.4
G1 E.4 F1800
; LINE_WIDTH: 0.469702
G1 F1500
M204 S6000
G1 X86.316 Y97.367 E.00835
; LINE_WIDTH: 0.443101
G1 X86.292 Y97.387 E.00063
; LINE_WIDTH: 0.425379
G1 X86.176 Y97.493 E.00314
; LINE_WIDTH: 0.395725
G1 X86.044 Y97.613 E.00329
; LINE_WIDTH: 0.361028
G1 X85.746 Y97.924 E.0072
G1 X85.467 Y98.3 E.00784
G1 X85.227 Y98.761 E.0087
G1 X85.088 Y99.186 E.00747
G1 X85.024 Y99.536 E.00596
G1 X85.004 Y100.005 E.00786
G1 X85.073 Y100.538 E.00899
G1 X85.225 Y101.035 E.0087
G1 X85.415 Y101.42 E.00718
G1 X85.615 Y101.715 E.00595
G1 X85.914 Y102.054 E.00756
G1 X86.337 Y102.394 E.00909
G1 X86.797 Y102.647 E.00878
G1 X87.166 Y102.781 E.00657
G1 X87.496 Y102.852 E.00564
G1 X88.055 Y102.9 E.0094
G1 X88.553 Y102.847 E.00836
G1 X88.933 Y102.749 E.00657
G1 X89.247 Y102.626 E.00565
G1 X89.752 Y102.336 E.00974
G1 X90.146 Y101.995 E.00872
G1 X90.466 Y101.6 E.0085
G1 X90.728 Y101.145 E.00877
G1 X90.863 Y100.794 E.00629
G1 X90.952 Y100.409 E.00661
G1 X91 Y99.903 E.0085
G1 X90.976 Y99.526 E.00632
G1 X90.86 Y99.015 E.00876
G1 X90.733 Y98.673 E.00611
G1 X90.48 Y98.211 E.0088
G1 X90.156 Y97.815 E.00856
G1 X89.891 Y97.548 E.0063
; LINE_WIDTH: 0.399164
G1 X89.874 Y97.533 E.00042
; LINE_WIDTH: 0.420804
G1 X89.742 Y97.415 E.00348
; LINE_WIDTH: 0.472533
G1 X89.591 Y97.282 E.00449
G1 X89.263 Y97.37 E.00756
; WIPE_START
G1 X89.591 Y97.282 E-.23846
G1 X89.742 Y97.415 E-.14154
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X94.54 Y96.258 Z4.8 F18000
G1 Z4.4
G1 E.4 F1800
; LINE_WIDTH: 0.149657
G1 F1500
M204 S6000
G1 X94.876 Y96.069 E.00238
G1 X94.985 Y95.945 E.00102
G1 X95.068 Y95.813 E.00097
; LINE_WIDTH: 0.117808
G1 X95.106 Y95.745 E.00036
; LINE_WIDTH: 0.0912106
G1 X95.136 Y95.63 E.00039
; WIPE_START
G1 X95.106 Y95.745 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X95.123 Y88.112 Z4.8 F18000
G1 X95.147 Y77.602 Z4.8
G1 Z4.4
G1 E.4 F1800
; LINE_WIDTH: 0.10306
G1 F1500
M204 S6000
G1 X95.074 Y77.39 E.00086
; LINE_WIDTH: 0.133649
G1 X95.038 Y77.331 E.00037
; LINE_WIDTH: 0.153365
G1 X94.823 Y77.09 E.00206
G1 X94.69 Y77.021 E.00095
; LINE_WIDTH: 0.120086
G1 X94.605 Y76.991 E.00042
; LINE_WIDTH: 0.0931975
G1 X94.521 Y76.961 E.0003
; WIPE_START
G1 X94.605 Y76.991 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X86.973 Y76.969 Z4.8 F18000
G1 X81.495 Y76.954 Z4.8
G1 Z4.4
G1 E.4 F1800
; LINE_WIDTH: 0.0994059
G1 F1500
M204 S6000
G1 X81.363 Y76.997 E.00051
; LINE_WIDTH: 0.140221
G1 X81.206 Y77.072 E.001
G1 X81.118 Y77.146 E.00065
; LINE_WIDTH: 0.154511
G1 X80.966 Y77.32 E.00149
G1 X80.909 Y77.423 E.00075
; LINE_WIDTH: 0.0995217
G1 X80.855 Y77.602 E.00069
; WIPE_START
G1 X80.909 Y77.423 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X88.316 Y79.266 Z4.8 F18000
G1 X96.503 Y81.304 Z4.8
G1 Z4.4
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
M73 P83 R3
G1 F1500
M204 S500
G1 X97.497 Y81.304 E.02102
G1 X97.497 Y82.297 E.02102
G1 X96.503 Y82.297 E.02102
G1 X96.503 Y81.364 E.01975
M204 S10000
G1 X96.079 Y80.88 F18000
G1 F1500
M204 S500
G1 X97.921 Y80.88 E.03898
G1 X97.921 Y82.722 E.03898
G1 X96.079 Y82.722 E.03898
G1 X96.079 Y80.94 E.03771
M204 S250
G1 X95.67 Y80.471 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F2340
M204 S500
G1 X98.33 Y80.471 E.05232
G1 X98.33 Y83.131 E.05232
G1 X95.67 Y83.131 E.05232
G1 X95.67 Y80.531 E.05114
; CHANGE_LAYER
; Z_HEIGHT: 4.52
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F2340
M204 S6000
G1 X97.669 Y80.486 E-.38
; WIPE_END
G1 E-.02 F1800
; layer num/total_layer_count: 37/49
; update layer progress
M73 L37
M991 S0 P36 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z4.8 I-1.085 J-.552 P1  F18000
G1 X89.213 Y97.114 Z4.8
G1 Z4.52
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X89.113 Y97.064 E.00235
G1 X88.604 Y96.915 E.01122
G1 X88.23 Y96.864 E.008
G1 X87.886 Y96.858 E.00729
G1 X87.327 Y96.928 E.01192
G1 X86.766 Y97.11 E.01249
G1 X86.659 Y96.949 E.0041
G1 X87.012 Y96.543 E.01137
G1 X88.988 Y96.543 E.04184
G1 X89.341 Y96.948 E.01137
G1 X89.25 Y97.066 E.00315
; WIPE_START
M204 S6000
G1 X89.113 Y97.064 E-.02587
G1 X88.604 Y96.915 E-.10076
G1 X88.23 Y96.864 E-.07178
G1 X87.886 Y96.858 E-.06545
G1 X87.327 Y96.928 E-.10701
G1 X87.281 Y96.943 E-.00913
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X90.617 Y99.849 Z4.92 F18000
G1 Z4.52
G1 E.4 F1800
G1 F1500
M204 S500
G1 X90.622 Y99.901 E.00111
G1 X90.58 Y100.36 E.00975
G1 X90.504 Y100.672 E.0068
G1 X90.404 Y100.943 E.00612
G1 X90.168 Y101.375 E.01042
G1 X89.868 Y101.741 E.01001
G1 X89.507 Y102.047 E.01001
G1 X89.078 Y102.289 E.01042
G1 X88.808 Y102.393 E.00612
G1 X88.497 Y102.474 E.0068
G1 X88.036 Y102.523 E.00981
G1 X87.545 Y102.481 E.01043
G1 X87.264 Y102.416 E.00612
G1 X86.961 Y102.307 E.0068
G1 X86.556 Y102.089 E.00975
G1 X86.188 Y101.796 E.00995
G1 X85.879 Y101.442 E.00995
G1 X85.643 Y101.047 E.00975
G1 X85.52 Y100.748 E.00684
G1 X85.434 Y100.437 E.00683
G1 X85.381 Y99.989 E.00955
G1 X85.39 Y99.666 E.00683
G1 X85.438 Y99.347 E.00683
G1 X85.574 Y98.907 E.00975
G1 X85.791 Y98.49 E.00995
G1 X86.078 Y98.118 E.00995
G1 X86.42 Y97.809 E.00975
G1 X86.69 Y97.632 E.00683
G1 X86.978 Y97.487 E.00683
G1 X87.42 Y97.344 E.00982
G1 X87.908 Y97.282 E.01042
G1 X88.197 Y97.288 E.00612
G1 X88.516 Y97.331 E.0068
G1 X88.958 Y97.46 E.00974
G1 X89.37 Y97.666 E.00975
G1 X89.634 Y97.852 E.00683
G1 X89.874 Y98.068 E.00683
G1 X90.16 Y98.417 E.00955
G1 X90.326 Y98.694 E.00683
G1 X90.457 Y98.989 E.00683
G1 X90.58 Y99.433 E.00975
G1 X90.612 Y99.789 E.00757
M204 S250
G1 X90.209 Y99.885 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X90.211 Y99.901 E.00031
G1 X90.176 Y100.292 E.00773
G1 X90.112 Y100.552 E.00525
G1 X90.03 Y100.773 E.00464
G1 X89.827 Y101.145 E.00834
G1 X89.575 Y101.452 E.00782
G1 X89.272 Y101.709 E.00782
G1 X88.903 Y101.918 E.00834
G1 X88.682 Y102.003 E.00464
G1 X88.424 Y102.07 E.00525
G1 X88.032 Y102.112 E.00776
G1 X87.609 Y102.076 E.00834
G1 X87.38 Y102.022 E.00464
G1 X87.128 Y101.932 E.00525
G1 X86.782 Y101.746 E.00773
G1 X86.472 Y101.499 E.00779
G1 X86.212 Y101.201 E.00779
G1 X86.01 Y100.863 E.00773
G1 X85.908 Y100.615 E.00527
G1 X85.837 Y100.357 E.00526
G1 X85.791 Y99.97 E.00767
G1 X85.799 Y99.703 E.00526
G1 X85.838 Y99.438 E.00526
G1 X85.954 Y99.062 E.00774
G1 X86.137 Y98.711 E.00779
G1 X86.379 Y98.397 E.0078
G1 X86.671 Y98.134 E.00773
G1 X86.895 Y97.987 E.00526
G1 X87.134 Y97.867 E.00526
G1 X87.509 Y97.745 E.00776
G1 X87.93 Y97.692 E.00834
G1 X88.166 Y97.697 E.00464
G1 X88.43 Y97.733 E.00525
G1 X88.808 Y97.843 E.00773
G1 X89.159 Y98.019 E.00773
G1 X89.378 Y98.173 E.00526
G1 X89.577 Y98.352 E.00526
G1 X89.825 Y98.653 E.00767
G1 X89.962 Y98.883 E.00526
G1 X90.071 Y99.127 E.00526
G1 X90.175 Y99.506 E.00774
G1 X90.204 Y99.826 E.00631
; WIPE_START
M204 S6000
G1 X90.211 Y99.901 E-.01438
G1 X90.176 Y100.292 E-.07469
G1 X90.112 Y100.552 E-.05074
G1 X90.03 Y100.773 E-.04483
G1 X89.827 Y101.145 E-.08057
G1 X89.575 Y101.452 E-.07552
G1 X89.417 Y101.586 E-.03927
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X86.761 Y96.119 Z4.92 F18000
G1 Z4.52
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X94.12 Y96.118 E.15576
G1 X94.406 Y96.044 E.00625
G1 X94.668 Y95.881 E.00652
G1 X94.88 Y95.631 E.00695
G1 X95.007 Y95.316 E.00719
G1 X95.013 Y94.72 E.01261
G1 X95.381 Y94.72 E.00778
G1 X95.381 Y95.565 E.01788
G1 X95.353 Y95.803 E.00508
G1 X95.28 Y96.003 E.0045
G1 X95.209 Y96.118 E.00286
G1 X95.057 Y96.279 E.00469
G1 X94.947 Y96.356 E.00286
G1 X94.751 Y96.441 E.0045
G1 X94.533 Y96.479 E.0047
G1 X89.498 Y96.483 E.10657
G1 X90.68 Y97.842 E.03813
G1 X91 Y98.344 E.01259
G1 X91.167 Y98.72 E.00872
G1 X91.324 Y99.291 E.01253
G1 X91.38 Y99.881 E.01254
G1 X91.357 Y100.291 E.00869
G1 X91.287 Y100.686 E.00849
G1 X91.168 Y101.079 E.00869
G1 X90.91 Y101.622 E.01273
G1 X90.558 Y102.11 E.01274
G1 X90.126 Y102.528 E.01273
G1 X89.635 Y102.859 E.01254
G1 X89.273 Y103.032 E.00849
G1 X88.893 Y103.161 E.00849
G1 X88.5 Y103.243 E.00849
G1 X88.1 Y103.279 E.00849
G1 X87.699 Y103.267 E.00849
G1 X87.116 Y103.164 E.01254
G1 X86.718 Y103.029 E.00889
G1 X86.241 Y102.785 E.01134
G1 X85.865 Y102.52 E.00975
G1 X85.571 Y102.251 E.00843
G1 X85.31 Y101.947 E.00849
G1 X85.086 Y101.613 E.00849
G1 X84.9 Y101.248 E.00869
G1 X84.713 Y100.686 E.01254
G1 X84.643 Y100.291 E.00849
G1 X84.62 Y99.89 E.00849
G1 X84.645 Y99.49 E.00849
G1 X84.718 Y99.095 E.00849
G1 X84.836 Y98.715 E.00843
G1 X85.027 Y98.296 E.00975
G1 X85.317 Y97.845 E.01134
G1 X86.503 Y96.482 E.03824
G1 X81.536 Y96.482 E.10513
G1 X81.289 Y96.453 E.00527
G1 X81.143 Y96.405 E.00324
G1 X80.928 Y96.269 E.00539
G1 X80.771 Y96.091 E.00502
G1 X80.722 Y96.008 E.00203
G1 X80.647 Y95.803 E.00463
G1 X80.619 Y95.565 E.00508
G1 X80.619 Y77.619 E.37984
G1 X80.66 Y77.343 E.0059
G1 X80.765 Y77.12 E.00523
G1 X80.942 Y76.922 E.00561
G1 X81.059 Y76.841 E.00303
G1 X81.208 Y76.772 E.00347
G1 X81.458 Y76.723 E.0054
G1 X94.513 Y76.722 E.27633
G1 X94.772 Y76.765 E.00555
G1 X94.988 Y76.87 E.00508
G1 X95.166 Y77.028 E.00504
G1 X95.283 Y77.208 E.00454
G1 X95.356 Y77.407 E.0045
G1 X95.378 Y77.559 E.00325
G1 X95.38 Y78.482 E.01952
G1 X95.019 Y78.482 E.00763
G1 X95.019 Y78.056 E.00901
G1 X94.983 Y77.809 E.00528
G1 X94.859 Y77.539 E.00631
G1 X94.648 Y77.304 E.00669
G1 X94.36 Y77.139 E.00702
G1 X94.087 Y77.082 E.00589
G1 X81.955 Y77.082 E.25679
G1 X81.697 Y77.119 E.00552
G1 X81.394 Y77.271 E.00717
G1 X81.171 Y77.495 E.00669
G1 X81.019 Y77.798 E.00717
G1 X80.981 Y78.056 E.00552
G1 X80.981 Y95.155 E.36192
G1 X81.035 Y95.462 E.0066
G1 X81.249 Y95.809 E.00864
G1 X81.591 Y96.049 E.00884
G1 X81.937 Y96.12 E.00747
G1 X86.701 Y96.119 E.10083
; WIPE_START
M204 S6000
G1 X88.701 Y96.119 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X85.604 Y96.891 Z4.92 F18000
G1 Z4.52
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X81.512 Y96.891 E.08049
G1 X81.2 Y96.854 E.00619
G1 X80.986 Y96.784 E.00442
G1 X80.858 Y96.719 E.00283
G1 X80.669 Y96.587 E.00454
G1 X80.564 Y96.488 E.00284
G1 X80.433 Y96.324 E.00412
G1 X80.35 Y96.184 E.0032
G1 X80.246 Y95.898 E.00599
G1 X80.21 Y95.589 E.00613
G1 X80.21 Y77.607 E.35368
G1 X80.219 Y77.454 E.00301
G1 X80.265 Y77.229 E.00452
G1 X80.324 Y77.074 E.00326
G1 X80.422 Y76.893 E.00406
G1 X80.563 Y76.715 E.00447
G1 X80.685 Y76.602 E.00326
G1 X80.855 Y76.485 E.00406
G1 X81.062 Y76.388 E.00449
G1 X81.2 Y76.347 E.00283
G1 X81.428 Y76.313 E.00454
G1 X94.547 Y76.313 E.25804
G1 X94.877 Y76.368 E.00657
G1 X95.008 Y76.416 E.00275
G1 X95.21 Y76.525 E.00452
G1 X95.342 Y76.625 E.00326
G1 X95.485 Y76.77 E.004
G1 X95.652 Y77.023 E.00596
G1 X95.755 Y77.307 E.00594
G1 X95.787 Y77.529 E.00442
G1 X95.79 Y78.891 E.02678
G1 X94.61 Y78.891 E.0232
G1 X94.61 Y78.086 E.01584
G1 X94.587 Y77.927 E.00316
G1 X94.513 Y77.766 E.00348
G1 X94.387 Y77.626 E.0037
M73 P84 R3
G1 X94.213 Y77.526 E.00395
G1 X94.045 Y77.492 E.00337
G1 X81.985 Y77.491 E.23722
G1 X81.821 Y77.515 E.00325
G1 X81.637 Y77.608 E.00406
G1 X81.507 Y77.737 E.00362
G1 X81.414 Y77.922 E.00407
G1 X81.39 Y78.086 E.00325
G1 X81.39 Y95.119 E.33504
G1 X81.424 Y95.314 E.00388
G1 X81.553 Y95.522 E.00482
G1 X81.757 Y95.665 E.00489
G1 X81.979 Y95.711 E.00446
G1 X94.067 Y95.709 E.23778
G1 X94.243 Y95.663 E.00356
G1 X94.397 Y95.567 E.00357
G1 X94.525 Y95.416 E.0039
G1 X94.599 Y95.234 E.00386
G1 X94.608 Y94.311 E.01816
G1 X95.79 Y94.311 E.02325
G1 X95.79 Y95.589 E.02513
G1 X95.754 Y95.898 E.00613
G1 X95.651 Y96.182 E.00594
G1 X95.536 Y96.368 E.0043
G1 X95.326 Y96.59 E.006
G1 X95.147 Y96.716 E.0043
G1 X94.87 Y96.835 E.00594
G1 X94.569 Y96.888 E.00601
G1 X90.396 Y96.891 E.08208
G1 X91.003 Y97.589 E.01819
G1 X91.164 Y97.817 E.0055
G1 X91.364 Y98.156 E.00774
G1 X91.548 Y98.57 E.00892
G1 X91.619 Y98.777 E.00431
G1 X91.727 Y99.217 E.00891
G1 X91.783 Y99.667 E.00891
G1 X91.79 Y99.886 E.0043
G1 X91.764 Y100.338 E.00891
G1 X91.686 Y100.781 E.00885
G1 X91.555 Y101.215 E.00891
G1 X91.473 Y101.417 E.0043
G1 X91.266 Y101.824 E.00897
G1 X91.149 Y102.009 E.0043
G1 X90.873 Y102.372 E.00898
G1 X90.726 Y102.534 E.0043
G1 X90.39 Y102.842 E.00897
G1 X90.216 Y102.975 E.00431
G1 X89.833 Y103.218 E.00891
G1 X89.427 Y103.412 E.00885
G1 X89.001 Y103.556 E.00885
G1 X88.561 Y103.649 E.00885
G1 X88.113 Y103.689 E.00885
G1 X87.663 Y103.676 E.00885
G1 X87.215 Y103.608 E.00891
G1 X87.002 Y103.557 E.0043
G1 X86.57 Y103.411 E.00898
G1 X86.024 Y103.133 E.01204
G1 X85.607 Y102.84 E.01003
G1 X85.277 Y102.536 E.00883
G1 X84.983 Y102.195 E.00885
G1 X84.733 Y101.821 E.00885
G1 X84.527 Y101.418 E.00891
G1 X84.445 Y101.215 E.00431
G1 X84.314 Y100.781 E.00891
G1 X84.236 Y100.338 E.00885
G1 X84.21 Y99.889 E.00885
G1 X84.239 Y99.44 E.00885
G1 X84.32 Y98.997 E.00885
G1 X84.452 Y98.568 E.00883
G1 X84.665 Y98.104 E.01003
G1 X84.868 Y97.767 E.00774
G1 X84.996 Y97.59 E.00431
G1 X85.565 Y96.936 E.01704
; WIPE_START
M204 S6000
G1 X83.565 Y96.914 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G17
G3 Z4.92 I1.217 J0 P1  F18000
;===================== date: 20250206 =====================

; don't support timelapse gcode in spiral_mode and by object sequence for I3 structure printer
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
G92 E0
G1 Z4.92
G1 X0 Y90 ; move to safe pos
G1 X-13.0 F3000 ; move to safe pos
M400
M1004 S5 P1  ; external shutter
M400 P300
M971 S11 C11 O0
G92 E0
G1 X0 F18000
M623

; SKIPTYPE: head_wrap_detect
M622.1 S1
M1002 judge_flag g39_3rd_layer_detect_flag
M622 J1
    ; enable nozzle clog detect at 3rd layer
    


    M622.1 S1
    M1002 judge_flag g39_detection_flag
    M622 J1
      
        M622.1 S0
        M1002 judge_flag g39_mass_exceed_flag
        M622 J1
        
            G392 S0
            M400
            G90
            M83
            M204 S5000
            G0 Z4.92 F4000
            G39.3 S1
            G0 Z4.92 F4000
            G392 S0
          
        M623
    
    M623
M623
; SKIPPABLE_END




G1 X81.456 Y96.238
G1 Z4.52
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.0962503
G1 F1500
M204 S6000
G1 X81.354 Y96.193 E.00039
; LINE_WIDTH: 0.144798
G1 X81.251 Y96.148 E.00067
G1 X81.056 Y96.008 E.00143
G1 X80.972 Y95.887 E.00088
G1 X80.847 Y95.629 E.0017
; WIPE_START
G1 X80.972 Y95.887 E-.13837
G1 X81.056 Y96.008 E-.07143
G1 X81.251 Y96.148 E-.11606
G1 X81.354 Y96.193 E-.05415
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X86.548 Y97.165 Z4.92 F18000
G1 Z4.52
G1 E.4 F1800
; LINE_WIDTH: 0.477124
G1 F1500
M204 S6000
G1 X86.367 Y97.319 E.00533
; LINE_WIDTH: 0.438418
G1 X86.16 Y97.496 E.00562
; LINE_WIDTH: 0.400616
G1 X85.986 Y97.673 E.00464
; LINE_WIDTH: 0.359762
G1 X85.792 Y97.872 E.00463
G1 X85.468 Y98.301 E.00895
G1 X85.22 Y98.778 E.00895
G1 X85.073 Y99.251 E.00826
G1 X85.015 Y99.622 E.00626
G1 X85.005 Y100.018 E.00659
G1 X85.067 Y100.522 E.00846
G1 X85.19 Y100.947 E.00738
G1 X85.419 Y101.42 E.00877
G1 X85.613 Y101.716 E.00589
G1 X85.917 Y102.058 E.00763
G1 X86.337 Y102.394 E.00896
G1 X86.715 Y102.609 E.00725
G1 X87.166 Y102.78 E.00804
G1 X87.499 Y102.852 E.00566
G1 X88.025 Y102.9 E.0088
G1 X88.553 Y102.847 E.00884
G1 X88.915 Y102.755 E.00623
G1 X89.25 Y102.625 E.00599
G1 X89.708 Y102.361 E.0088
G1 X89.882 Y102.232 E.00362
G1 X90.265 Y101.862 E.00888
G1 X90.486 Y101.572 E.00608
G1 X90.752 Y101.095 E.0091
G1 X90.916 Y100.595 E.00877
G1 X90.976 Y100.246 E.00589
G1 X91.001 Y99.882 E.00609
G1 X90.951 Y99.359 E.00874
G1 X90.812 Y98.854 E.00874
G1 X90.663 Y98.52 E.00609
G1 X90.376 Y98.076 E.00882
G1 X90.139 Y97.797 E.00609
; LINE_WIDTH: 0.382512
G1 X89.876 Y97.53 E.00667
; LINE_WIDTH: 0.426934
G1 X89.751 Y97.417 E.00337
; LINE_WIDTH: 0.468069
G1 X89.626 Y97.304 E.00372
G1 X89.603 Y97.308 E.00051
; LINE_WIDTH: 0.442474
G1 X89.444 Y97.338 E.00337
; LINE_WIDTH: 0.415757
G1 X89.284 Y97.368 E.00315
; WIPE_START
G1 X89.444 Y97.338 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X94.53 Y96.242 Z4.92 F18000
G1 Z4.52
G1 E.4 F1800
; LINE_WIDTH: 0.104157
G1 F1500
M204 S6000
G1 X94.675 Y96.186 E.00061
; LINE_WIDTH: 0.153058
G1 X94.856 Y96.084 E.00132
G1 X95.03 Y95.881 E.0017
; LINE_WIDTH: 0.131913
G1 X95.095 Y95.769 E.00069
; LINE_WIDTH: 0.0952855
G1 X95.137 Y95.624 E.00052
; WIPE_START
G1 X95.095 Y95.769 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X95.117 Y88.136 Z4.92 F18000
G1 X95.147 Y77.602 Z4.92
G1 Z4.52
G1 E.4 F1800
; LINE_WIDTH: 0.103208
G1 F1500
M204 S6000
G1 X95.073 Y77.389 E.00087
; LINE_WIDTH: 0.151169
G1 X94.945 Y77.21 E.00138
G1 X94.837 Y77.102 E.00096
G1 X94.7 Y77.025 E.00098
; LINE_WIDTH: 0.12305
G1 X94.61 Y76.993 E.00046
; LINE_WIDTH: 0.0941851
G1 X94.52 Y76.961 E.00033
; WIPE_START
G1 X94.61 Y76.993 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X86.978 Y76.971 Z4.92 F18000
G1 X81.504 Y76.955 Z4.92
G1 Z4.52
G1 E.4 F1800
; LINE_WIDTH: 0.100005
G1 F1500
M204 S6000
G1 X81.347 Y77.003 E.00061
; LINE_WIDTH: 0.149668
G1 X81.23 Y77.058 E.0008
G1 X81.123 Y77.142 E.00084
G1 X80.942 Y77.353 E.00172
; LINE_WIDTH: 0.12139
G1 X80.898 Y77.479 E.00064
; LINE_WIDTH: 0.0908429
G1 X80.854 Y77.604 E.00043
; WIPE_START
G1 X80.898 Y77.479 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X88.321 Y79.255 Z4.92 F18000
G1 X96.383 Y81.184 Z4.92
G1 Z4.52
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X97.617 Y81.184 E.0261
G1 X97.617 Y82.417 E.0261
G1 X96.383 Y82.417 E.0261
G1 X96.383 Y81.244 E.02483
M204 S10000
G1 X95.959 Y80.76 F18000
G1 F1500
M204 S500
G1 X98.041 Y80.76 E.04406
G1 X98.041 Y82.842 E.04406
G1 X95.959 Y82.842 E.04406
G1 X95.959 Y80.82 E.04279
M204 S250
G1 X95.55 Y80.351 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F2340
M204 S500
G1 X98.45 Y80.351 E.05704
G1 X98.45 Y83.251 E.05704
G1 X95.55 Y83.251 E.05704
G1 X95.55 Y80.411 E.05586
; WIPE_START
M204 S6000
G1 X97.55 Y80.37 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X96.798 Y82.003 Z4.92 F18000
G1 Z4.52
G1 E.4 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.430152
G1 F1500
M204 S6000
G1 X97.202 Y82.003 E.00816
G1 X97.202 Y81.599 E.00816
G1 X96.798 Y81.599 E.00816
G1 X96.798 Y81.943 E.00695
; CHANGE_LAYER
; Z_HEIGHT: 4.64
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F1500
G1 X96.798 Y81.599 E-.08402
G1 X97.202 Y81.599 E-.09866
G1 X97.202 Y82.003 E-.09866
G1 X96.798 Y82.003 E-.09866
; WIPE_END
G1 E-.02 F1800
; layer num/total_layer_count: 38/49
; update layer progress
M73 L38
M991 S0 P37 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z4.92 I-1.086 J-.55 P1  F18000
G1 X89.161 Y97.078 Z4.92
G1 Z4.64
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X88.604 Y96.915 E.01227
G1 X88.23 Y96.864 E.008
G1 X87.883 Y96.858 E.00735
G1 X87.326 Y96.928 E.01187
G1 X86.766 Y97.11 E.01247
G1 X86.659 Y96.949 E.0041
G1 X87.012 Y96.543 E.01137
G1 X88.921 Y96.543 E.04041
G1 X89.263 Y96.913 E.01066
G1 X89.192 Y97.027 E.00283
; WIPE_START
M204 S6000
G1 X88.604 Y96.915 E-.11374
G1 X88.23 Y96.864 E-.0718
G1 X87.883 Y96.858 E-.06596
G1 X87.326 Y96.928 E-.10656
G1 X87.216 Y96.964 E-.02194
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X90.617 Y99.848 Z5.04 F18000
G1 Z4.64
G1 E.4 F1800
G1 F1500
M204 S500
G1 X90.621 Y99.892 E.00092
G1 X90.602 Y100.212 E.0068
G1 X90.551 Y100.5 E.00618
G1 X90.396 Y100.965 E.01037
G1 X90.166 Y101.378 E.01
G1 X89.868 Y101.741 E.00995
G1 X89.507 Y102.047 E.01001
G1 X89.08 Y102.288 E.01037
G1 X88.809 Y102.393 E.00617
G1 X88.497 Y102.474 E.0068
G1 X88.036 Y102.523 E.00981
G1 X87.548 Y102.482 E.01037
G1 X87.264 Y102.416 E.00617
G1 X86.961 Y102.307 E.00681
G1 X86.556 Y102.089 E.00975
G1 X86.188 Y101.796 E.00995
G1 X85.877 Y101.44 E.01
G1 X85.629 Y101.017 E.01038
G1 X85.52 Y100.747 E.00617
G1 X85.434 Y100.437 E.0068
G1 X85.379 Y99.979 E.00975
G1 X85.408 Y99.51 E.00995
G1 X85.519 Y99.054 E.00995
G1 X85.706 Y98.633 E.00975
G1 X85.88 Y98.361 E.00683
G1 X86.085 Y98.112 E.00683
G1 X86.421 Y97.809 E.00956
G1 X86.69 Y97.632 E.00683
G1 X86.978 Y97.487 E.00683
G1 X87.419 Y97.344 E.00981
G1 X87.905 Y97.282 E.01037
G1 X88.197 Y97.288 E.00618
G1 X88.516 Y97.331 E.00681
G1 X88.958 Y97.46 E.00975
G1 X89.37 Y97.666 E.00975
G1 X89.634 Y97.852 E.00683
G1 X89.867 Y98.062 E.00663
G1 X90.073 Y98.298 E.00663
G1 X90.255 Y98.565 E.00683
G1 X90.455 Y98.98 E.00975
G1 X90.58 Y99.433 E.00995
G1 X90.612 Y99.789 E.00756
M204 S250
G1 X90.209 Y99.885 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X90.211 Y99.898 E.00025
G1 X90.195 Y100.164 E.00525
G1 X90.153 Y100.399 E.00469
G1 X90.02 Y100.799 E.0083
G1 X89.827 Y101.146 E.00781
G1 X89.575 Y101.452 E.0078
G1 X89.272 Y101.709 E.00781
G1 X88.905 Y101.917 E.0083
G1 X88.683 Y102.003 E.00469
G1 X88.424 Y102.07 E.00525
G1 X88.032 Y102.112 E.00775
G1 X87.612 Y102.076 E.00829
G1 X87.38 Y102.022 E.00469
G1 X87.128 Y101.932 E.00525
G1 X86.782 Y101.746 E.00773
G1 X86.472 Y101.499 E.00779
G1 X86.211 Y101.2 E.00781
G1 X85.998 Y100.836 E.0083
G1 X85.908 Y100.615 E.00469
G1 X85.837 Y100.357 E.00525
G1 X85.79 Y99.967 E.00773
G1 X85.814 Y99.571 E.0078
G1 X85.908 Y99.186 E.00779
G1 X86.068 Y98.827 E.00773
G1 X86.212 Y98.602 E.00526
G1 X86.382 Y98.395 E.00526
G1 X86.672 Y98.134 E.00767
G1 X86.895 Y97.987 E.00526
G1 X87.134 Y97.867 E.00526
G1 X87.509 Y97.745 E.00775
G1 X87.927 Y97.692 E.0083
G1 X88.166 Y97.697 E.00469
G1 X88.43 Y97.733 E.00525
G1 X88.808 Y97.843 E.00773
G1 X89.159 Y98.019 E.00773
G1 X89.378 Y98.173 E.00526
G1 X89.575 Y98.35 E.0052
G1 X89.749 Y98.549 E.0052
G1 X89.899 Y98.77 E.00526
G1 X90.07 Y99.124 E.00774
G1 X90.175 Y99.506 E.0078
G1 X90.204 Y99.825 E.0063
; WIPE_START
M204 S6000
G1 X90.211 Y99.898 E-.01381
G1 X90.195 Y100.164 E-.05075
G1 X90.153 Y100.399 E-.04528
G1 X90.02 Y100.799 E-.08014
G1 X89.827 Y101.146 E-.07546
G1 X89.575 Y101.452 E-.07533
G1 X89.417 Y101.586 E-.03924
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X86.761 Y96.119 Z5.04 F18000
G1 Z4.64
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X94.12 Y96.118 E.15577
G1 X94.406 Y96.044 E.00624
G1 X94.667 Y95.881 E.00651
G1 X94.88 Y95.631 E.00696
G1 X95.008 Y95.316 E.0072
G1 X95.013 Y94.72 E.01261
G1 X95.381 Y94.72 E.00778
G1 X95.381 Y95.565 E.01788
G1 X95.353 Y95.803 E.00508
G1 X95.28 Y96.003 E.0045
G1 X95.209 Y96.118 E.00286
G1 X95.057 Y96.279 E.00469
G1 X94.947 Y96.356 E.00286
G1 X94.751 Y96.441 E.0045
M73 P85 R3
G1 X94.533 Y96.479 E.00469
G1 X89.443 Y96.483 E.10774
G1 X90.544 Y97.675 E.03436
G1 X90.798 Y98.005 E.00881
G1 X91.087 Y98.525 E.01259
G1 X91.229 Y98.901 E.00852
G1 X91.354 Y99.48 E.01254
G1 X91.38 Y99.89 E.00869
G1 X91.357 Y100.296 E.00861
G1 X91.235 Y100.878 E.01258
G1 X91.094 Y101.261 E.00864
G1 X90.99 Y101.475 E.00502
G1 X90.808 Y101.782 E.00757
G1 X90.558 Y102.11 E.00872
G1 X90.127 Y102.528 E.01273
G1 X89.635 Y102.859 E.01254
G1 X89.273 Y103.032 E.00849
G1 X88.893 Y103.161 E.00849
G1 X88.5 Y103.243 E.00849
G1 X88.1 Y103.279 E.00849
G1 X87.699 Y103.267 E.00849
G1 X87.116 Y103.164 E.01253
G1 X86.727 Y103.032 E.00869
G1 X86.368 Y102.86 E.00843
G1 X85.985 Y102.613 E.00965
G1 X85.577 Y102.258 E.01144
G1 X85.31 Y101.947 E.00869
G1 X85.086 Y101.613 E.00849
G1 X84.9 Y101.248 E.00869
G1 X84.713 Y100.686 E.01254
G1 X84.642 Y100.285 E.00862
G1 X84.627 Y99.691 E.01258
G1 X84.676 Y99.291 E.00852
G1 X84.772 Y98.901 E.00849
G1 X84.913 Y98.526 E.00849
G1 X85.097 Y98.17 E.00849
G1 X85.323 Y97.838 E.00849
G1 X86.503 Y96.482 E.03805
G1 X81.536 Y96.482 E.10513
G1 X81.289 Y96.453 E.00527
G1 X81.143 Y96.405 E.00324
G1 X80.928 Y96.269 E.00539
G1 X80.77 Y96.09 E.00505
G1 X80.722 Y96.009 E.00199
G1 X80.647 Y95.803 E.00463
G1 X80.619 Y95.565 E.00508
G1 X80.619 Y77.619 E.37984
G1 X80.66 Y77.343 E.00591
G1 X80.769 Y77.112 E.00542
G1 X80.935 Y76.928 E.00524
G1 X81.159 Y76.791 E.00554
G1 X81.296 Y76.746 E.00306
G1 X81.458 Y76.723 E.00347
G1 X94.515 Y76.722 E.27636
G1 X94.772 Y76.765 E.00551
G1 X94.975 Y76.863 E.00476
G1 X95.152 Y77.011 E.00489
G1 X95.28 Y77.199 E.00482
G1 X95.356 Y77.407 E.00469
G1 X95.378 Y77.559 E.00325
G1 X95.38 Y78.482 E.01952
G1 X95.019 Y78.482 E.00763
G1 X95.019 Y78.056 E.009
G1 X94.983 Y77.809 E.00528
G1 X94.859 Y77.539 E.0063
G1 X94.649 Y77.304 E.00667
G1 X94.36 Y77.139 E.00704
G1 X94.087 Y77.082 E.0059
G1 X81.948 Y77.082 E.25694
G1 X81.667 Y77.13 E.00604
G1 X81.381 Y77.281 E.00684
G1 X81.147 Y77.529 E.00722
G1 X81.017 Y77.807 E.00649
G1 X80.981 Y78.056 E.00533
G1 X80.981 Y95.164 E.36211
G1 X81.05 Y95.5 E.00727
G1 X81.257 Y95.815 E.00796
G1 X81.591 Y96.049 E.00864
G1 X81.937 Y96.12 E.00747
G1 X86.701 Y96.119 E.10084
; WIPE_START
M204 S6000
G1 X88.701 Y96.119 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X85.605 Y96.891 Z5.04 F18000
G1 Z4.64
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X81.512 Y96.891 E.08049
G1 X81.2 Y96.854 E.00619
G1 X80.986 Y96.784 E.00442
G1 X80.858 Y96.719 E.00283
G1 X80.669 Y96.587 E.00454
G1 X80.564 Y96.488 E.00284
G1 X80.432 Y96.323 E.00415
G1 X80.35 Y96.184 E.00316
G1 X80.246 Y95.898 E.00599
G1 X80.21 Y95.589 E.00613
G1 X80.21 Y77.607 E.35368
G1 X80.219 Y77.454 E.00301
G1 X80.265 Y77.229 E.00452
G1 X80.323 Y77.076 E.00322
G1 X80.424 Y76.89 E.00415
G1 X80.51 Y76.774 E.00284
G1 X80.671 Y76.613 E.00448
G1 X80.857 Y76.483 E.00446
G1 X81.004 Y76.411 E.00323
G1 X81.202 Y76.347 E.00409
G1 X81.428 Y76.313 E.00449
G1 X94.549 Y76.313 E.25808
G1 X94.876 Y76.368 E.00653
G1 X95.008 Y76.416 E.00275
G1 X95.206 Y76.522 E.00442
G1 X95.442 Y76.721 E.00607
G1 X95.532 Y76.828 E.00276
G1 X95.65 Y77.02 E.00442
G1 X95.755 Y77.307 E.00601
G1 X95.787 Y77.529 E.00442
G1 X95.79 Y78.891 E.02678
G1 X94.61 Y78.891 E.0232
G1 X94.61 Y78.086 E.01584
G1 X94.587 Y77.927 E.00316
G1 X94.513 Y77.766 E.00348
G1 X94.388 Y77.627 E.00369
G1 X94.213 Y77.526 E.00396
G1 X94.045 Y77.492 E.00337
G1 X81.982 Y77.491 E.23726
G1 X81.8 Y77.522 E.00364
G1 X81.632 Y77.611 E.00373
G1 X81.49 Y77.762 E.00408
G1 X81.414 Y77.925 E.00355
G1 X81.39 Y78.086 E.00319
G1 X81.39 Y95.122 E.3351
G1 X81.435 Y95.341 E.00439
G1 X81.556 Y95.524 E.00431
G1 X81.757 Y95.665 E.00483
G1 X81.979 Y95.711 E.00446
G1 X94.068 Y95.709 E.23779
G1 X94.243 Y95.663 E.00355
G1 X94.397 Y95.568 E.00357
G1 X94.525 Y95.416 E.0039
G1 X94.599 Y95.234 E.00387
G1 X94.608 Y94.311 E.01816
G1 X95.79 Y94.311 E.02325
G1 X95.79 Y95.589 E.02513
G1 X95.754 Y95.898 E.00613
G1 X95.65 Y96.182 E.00594
G1 X95.536 Y96.368 E.0043
G1 X95.326 Y96.59 E.00601
G1 X95.147 Y96.716 E.0043
G1 X94.87 Y96.835 E.00595
G1 X94.569 Y96.888 E.00601
G1 X90.377 Y96.891 E.08245
G1 X90.857 Y97.411 E.01391
G1 X91.135 Y97.771 E.00895
G1 X91.28 Y98.005 E.0054
G1 X91.462 Y98.359 E.00783
G1 X91.62 Y98.78 E.00886
G1 X91.728 Y99.22 E.00891
G1 X91.761 Y99.437 E.00431
G1 X91.79 Y99.889 E.00891
G1 X91.764 Y100.34 E.00889
G1 X91.721 Y100.611 E.0054
G1 X91.627 Y100.998 E.00783
G1 X91.471 Y101.422 E.0089
G1 X91.351 Y101.669 E.0054
G1 X91.148 Y102.011 E.00783
G1 X90.873 Y102.372 E.00892
G1 X90.726 Y102.534 E.0043
G1 X90.39 Y102.842 E.00897
G1 X90.216 Y102.975 E.00431
G1 X89.833 Y103.218 E.00891
G1 X89.427 Y103.412 E.00885
G1 X89.001 Y103.556 E.00885
G1 X88.561 Y103.649 E.00885
G1 X88.113 Y103.689 E.00885
G1 X87.663 Y103.676 E.00885
G1 X87.215 Y103.608 E.00891
G1 X87.002 Y103.557 E.0043
G1 X86.573 Y103.412 E.00891
G1 X86.168 Y103.218 E.00883
G1 X85.743 Y102.944 E.00994
G1 X85.436 Y102.691 E.00782
G1 X85.279 Y102.538 E.00431
G1 X84.983 Y102.195 E.00891
G1 X84.733 Y101.821 E.00885
G1 X84.527 Y101.417 E.00891
G1 X84.445 Y101.215 E.0043
G1 X84.314 Y100.781 E.00891
G1 X84.235 Y100.336 E.00889
G1 X84.215 Y100.062 E.0054
G1 X84.218 Y99.664 E.00783
G1 X84.273 Y99.217 E.00886
G1 X84.38 Y98.78 E.00885
G1 X84.538 Y98.359 E.00885
G1 X84.745 Y97.96 E.00885
G1 X84.998 Y97.588 E.00885
G1 X85.565 Y96.936 E.01698
; WIPE_START
M204 S6000
G1 X83.565 Y96.914 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G17
G3 Z5.04 I1.217 J0 P1  F18000
;===================== date: 20250206 =====================

; don't support timelapse gcode in spiral_mode and by object sequence for I3 structure printer
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
G92 E0
G1 Z5.04
G1 X0 Y90 ; move to safe pos
G1 X-13.0 F3000 ; move to safe pos
M400
M1004 S5 P1  ; external shutter
M400 P300
M971 S11 C11 O0
G92 E0
G1 X0 F18000
M623

; SKIPTYPE: head_wrap_detect
M622.1 S1
M1002 judge_flag g39_3rd_layer_detect_flag
M622 J1
    ; enable nozzle clog detect at 3rd layer
    


    M622.1 S1
    M1002 judge_flag g39_detection_flag
    M622 J1
      
        M622.1 S0
        M1002 judge_flag g39_mass_exceed_flag
        M622 J1
        
            G392 S0
            M400
            G90
            M83
            M204 S5000
            G0 Z5.04 F4000
            G39.3 S1
            G0 Z5.04 F4000
            G392 S0
          
        M623
    
    M623
M623
; SKIPPABLE_END




G1 X81.456 Y96.238
G1 Z4.64
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.0962645
G1 F1500
M204 S6000
G1 X81.354 Y96.193 E.00039
; LINE_WIDTH: 0.145002
G1 X81.251 Y96.148 E.00067
G1 X81.065 Y96.017 E.00135
G1 X80.973 Y95.887 E.00095
G1 X80.85 Y95.643 E.00162
; WIPE_START
G1 X80.973 Y95.887 E-.13422
G1 X81.065 Y96.017 E-.07872
G1 X81.251 Y96.148 E-.11193
G1 X81.354 Y96.193 E-.05514
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X86.548 Y97.165 Z5.04 F18000
G1 Z4.64
G1 E.4 F1800
; LINE_WIDTH: 0.4771
G1 F1500
M204 S6000
G1 X86.367 Y97.319 E.00534
; LINE_WIDTH: 0.438377
G1 X86.16 Y97.496 E.00562
; LINE_WIDTH: 0.400966
G1 X85.99 Y97.669 E.00453
; LINE_WIDTH: 0.360696
G1 X85.625 Y98.071 E.00907
G1 X85.38 Y98.443 E.00745
G1 X85.157 Y98.946 E.00919
G1 X85.052 Y99.36 E.00714
G1 X85.011 Y99.713 E.00593
G1 X85.024 Y100.241 E.00884
G1 X85.084 Y100.597 E.00603
G1 X85.19 Y100.947 E.00611
G1 X85.42 Y101.42 E.00879
G1 X85.613 Y101.716 E.00591
G1 X85.918 Y102.057 E.00765
G1 X86.337 Y102.394 E.00898
G1 X86.797 Y102.647 E.00877
G1 X87.167 Y102.777 E.00657
G1 X87.501 Y102.856 E.00573
G1 X88.056 Y102.9 E.0093
G1 X88.553 Y102.847 E.00834
G1 X88.933 Y102.749 E.00657
G1 X89.253 Y102.624 E.00573
G1 X89.76 Y102.33 E.00978
G1 X90.164 Y101.978 E.00896
G1 X90.487 Y101.578 E.00859
G1 X90.747 Y101.109 E.00897
G1 X90.867 Y100.766 E.00607
G1 X90.977 Y100.267 E.00855
G1 X91 Y99.893 E.00625
G1 X90.954 Y99.369 E.0088
G1 X90.862 Y99.015 E.00611
G1 X90.737 Y98.683 E.00593
G1 X90.481 Y98.219 E.00884
G1 X90.252 Y97.922 E.00628
G1 X89.873 Y97.534 E.00905
; LINE_WIDTH: 0.415219
G1 X89.74 Y97.418 E.00343
; LINE_WIDTH: 0.456342
G1 X89.581 Y97.28 E.00453
; LINE_WIDTH: 0.484584
G1 X89.379 Y97.129 E.00578
; WIPE_START
G1 X89.581 Y97.28 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X94.53 Y96.242 Z5.04 F18000
G1 Z4.64
G1 E.4 F1800
; LINE_WIDTH: 0.103784
G1 F1500
M204 S6000
G1 X94.674 Y96.187 E.0006
; LINE_WIDTH: 0.149901
G1 X94.877 Y96.064 E.00147
G1 X95.03 Y95.882 E.00147
; LINE_WIDTH: 0.131927
G1 X95.095 Y95.769 E.00069
; LINE_WIDTH: 0.0953196
G1 X95.137 Y95.624 E.00052
; WIPE_START
G1 X95.095 Y95.769 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X95.117 Y88.137 Z5.04 F18000
G1 X95.147 Y77.602 Z5.04
G1 Z4.64
G1 E.4 F1800
; LINE_WIDTH: 0.103149
G1 F1500
M204 S6000
G1 X95.073 Y77.39 E.00087
; LINE_WIDTH: 0.150752
G1 X94.972 Y77.24 E.00113
G1 X94.829 Y77.097 E.00126
G1 X94.7 Y77.025 E.00092
; LINE_WIDTH: 0.123136
G1 X94.61 Y76.993 E.00047
; LINE_WIDTH: 0.0942111
G1 X94.52 Y76.961 E.00033
; WIPE_START
G1 X94.61 Y76.993 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X86.978 Y76.97 Z5.04 F18000
G1 X81.497 Y76.954 Z5.04
G1 Z4.64
G1 E.4 F1800
; LINE_WIDTH: 0.100214
G1 F1500
M204 S6000
G1 X81.357 Y77 E.00055
; LINE_WIDTH: 0.141279
G1 X81.208 Y77.069 E.00094
G1 X81.118 Y77.146 E.00068
; LINE_WIDTH: 0.15896
G1 X80.932 Y77.374 E.00195
; LINE_WIDTH: 0.123365
G1 X80.926 Y77.388 E.00008
; LINE_WIDTH: 0.0979394
G1 X80.854 Y77.601 E.00081
; WIPE_START
G1 X80.926 Y77.388 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X88.336 Y79.218 Z5.04 F18000
G1 X96.412 Y81.213 Z5.04
G1 Z4.64
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X97.588 Y81.213 E.02489
G1 X97.588 Y82.389 E.02489
G1 X96.412 Y82.389 E.02489
G1 X96.412 Y81.273 E.02362
M204 S10000
G1 X95.988 Y80.789 F18000
G1 F1500
M204 S500
G1 X98.012 Y80.789 E.04285
G1 X98.012 Y82.813 E.04285
G1 X95.988 Y82.813 E.04285
G1 X95.988 Y80.849 E.04158
M204 S250
G1 X95.579 Y80.379 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X98.421 Y80.379 E.05592
G1 X98.421 Y83.222 E.05592
G1 X95.579 Y83.222 E.05592
G1 X95.579 Y80.439 E.05474
; WIPE_START
M204 S6000
G1 X97.578 Y80.397 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X96.812 Y81.989 Z5.04 F18000
G1 Z4.64
G1 E.4 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.401582
G1 F1500
M204 S6000
G1 X97.188 Y81.989 E.00705
G1 X97.188 Y81.613 E.00705
G1 X96.812 Y81.613 E.00705
G1 X96.812 Y81.929 E.00592
; CHANGE_LAYER
; Z_HEIGHT: 4.76
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F1500
G1 X96.812 Y81.613 E-.08315
G1 X97.188 Y81.613 E-.09895
G1 X97.188 Y81.989 E-.09895
G1 X96.812 Y81.989 E-.09895
; WIPE_END
G1 E-.02 F1800
; layer num/total_layer_count: 39/49
; update layer progress
M73 L39
M991 S0 P38 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z5.04 I-1.085 J-.55 P1  F18000
G1 X89.161 Y97.078 Z5.04
G1 Z4.76
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X88.604 Y96.915 E.01228
G1 X88.229 Y96.864 E.008
G1 X87.88 Y96.858 E.00741
G1 X87.326 Y96.928 E.01182
G1 X86.835 Y97.088 E.01093
G1 X86.729 Y96.922 E.00416
G1 X87.079 Y96.543 E.01092
G1 X88.921 Y96.543 E.039
G1 X89.263 Y96.913 E.01066
G1 X89.193 Y97.027 E.00283
; WIPE_START
M204 S6000
G1 X88.604 Y96.915 E-.11379
G1 X88.229 Y96.864 E-.07183
G1 X87.88 Y96.858 E-.06648
G1 X87.326 Y96.928 E-.1061
G1 X87.217 Y96.964 E-.0218
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X90.617 Y99.849 Z5.16 F18000
G1 Z4.76
G1 E.4 F1800
G1 F1500
M204 S500
G1 X90.622 Y99.901 E.0011
G1 X90.58 Y100.369 E.00995
G1 X90.457 Y100.813 E.00975
G1 X90.326 Y101.108 E.00683
G1 X90.16 Y101.385 E.00683
G1 X89.868 Y101.741 E.00975
G1 X89.507 Y102.046 E.01
G1 X89.083 Y102.287 E.01032
G1 X88.809 Y102.393 E.00623
G1 X88.497 Y102.474 E.00681
G1 X88.039 Y102.522 E.00975
G1 X87.58 Y102.488 E.00975
G1 X87.265 Y102.416 E.00683
G1 X86.961 Y102.307 E.00683
G1 X86.556 Y102.089 E.00975
G1 X86.186 Y101.794 E.01
G1 X85.868 Y101.424 E.01032
G1 X85.711 Y101.176 E.00623
M73 P86 R3
G1 X85.571 Y100.886 E.0068
G1 X85.436 Y100.446 E.00975
G1 X85.379 Y99.979 E.00995
G1 X85.407 Y99.519 E.00975
G1 X85.474 Y99.204 E.00683
G1 X85.578 Y98.898 E.00683
G1 X85.791 Y98.489 E.00975
G1 X86.078 Y98.118 E.00995
G1 X86.42 Y97.809 E.00975
G1 X86.69 Y97.632 E.00683
G1 X86.978 Y97.487 E.00683
G1 X87.419 Y97.344 E.0098
G1 X87.903 Y97.283 E.01032
G1 X88.197 Y97.288 E.00623
G1 X88.516 Y97.331 E.00681
G1 X88.96 Y97.461 E.0098
G1 X89.395 Y97.683 E.01032
G1 X89.635 Y97.853 E.00623
G1 X89.874 Y98.068 E.00681
G1 X90.16 Y98.417 E.00955
G1 X90.325 Y98.693 E.00681
G1 X90.446 Y98.961 E.00623
G1 X90.579 Y99.43 E.01032
G1 X90.612 Y99.789 E.00763
M204 S250
G1 X90.209 Y99.886 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X90.211 Y99.901 E.0003
G1 X90.175 Y100.296 E.00779
G1 X90.071 Y100.675 E.00773
G1 X89.962 Y100.919 E.00526
G1 X89.825 Y101.149 E.00526
G1 X89.575 Y101.453 E.00774
G1 X89.272 Y101.709 E.00781
G1 X88.907 Y101.916 E.00825
G1 X88.683 Y102.003 E.00474
G1 X88.424 Y102.07 E.00525
G1 X88.033 Y102.111 E.00774
G1 X87.641 Y102.082 E.00773
G1 X87.38 Y102.023 E.00526
G1 X87.128 Y101.932 E.00526
G1 X86.782 Y101.746 E.00773
G1 X86.472 Y101.498 E.00781
G1 X86.198 Y101.18 E.00825
G1 X86.069 Y100.977 E.00474
G1 X85.953 Y100.736 E.00525
G1 X85.837 Y100.361 E.00774
G1 X85.79 Y99.967 E.00779
G1 X85.814 Y99.574 E.00774
G1 X85.869 Y99.313 E.00526
G1 X85.956 Y99.06 E.00526
G1 X86.137 Y98.711 E.00773
G1 X86.379 Y98.397 E.0078
G1 X86.672 Y98.134 E.00773
G1 X86.895 Y97.987 E.00526
G1 X87.134 Y97.867 E.00526
G1 X87.509 Y97.745 E.00775
G1 X87.925 Y97.692 E.00825
G1 X88.166 Y97.697 E.00474
G1 X88.43 Y97.733 E.00525
G1 X88.809 Y97.843 E.00775
G1 X89.182 Y98.034 E.00825
G1 X89.378 Y98.173 E.00473
G1 X89.577 Y98.352 E.00526
G1 X89.825 Y98.653 E.00767
G1 X89.962 Y98.882 E.00525
G1 X90.06 Y99.102 E.00474
G1 X90.175 Y99.505 E.00825
G1 X90.204 Y99.826 E.00633
; WIPE_START
M204 S6000
G1 X90.211 Y99.901 E-.01428
G1 X90.175 Y100.296 E-.07529
G1 X90.071 Y100.675 E-.07472
G1 X89.962 Y100.919 E-.05084
G1 X89.825 Y101.149 E-.05083
G1 X89.575 Y101.453 E-.07474
G1 X89.417 Y101.586 E-.0393
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X86.834 Y96.119 Z5.16 F18000
G1 Z4.76
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X94.121 Y96.118 E.15423
G1 X94.406 Y96.043 E.00623
G1 X94.667 Y95.881 E.00651
G1 X94.881 Y95.629 E.00699
G1 X95.007 Y95.315 E.00716
G1 X95.013 Y94.72 E.0126
G1 X95.381 Y94.72 E.00778
G1 X95.381 Y95.565 E.01788
G1 X95.353 Y95.803 E.00508
G1 X95.28 Y96.003 E.0045
G1 X95.205 Y96.125 E.00305
G1 X95.109 Y96.233 E.00305
G1 X94.938 Y96.36 E.0045
G1 X94.751 Y96.441 E.00431
G1 X94.533 Y96.479 E.0047
G1 X89.443 Y96.483 E.10774
G1 X90.544 Y97.675 E.03436
G1 X90.795 Y98 E.00869
G1 X91 Y98.345 E.00849
G1 X91.167 Y98.72 E.00869
G1 X91.326 Y99.3 E.01273
G1 X91.38 Y99.896 E.01266
G1 X91.327 Y100.497 E.01277
G1 X91.168 Y101.079 E.01276
G1 X90.914 Y101.613 E.01253
G1 X90.69 Y101.947 E.00849
G1 X90.431 Y102.249 E.00844
G1 X90.095 Y102.551 E.00955
G1 X89.643 Y102.855 E.01153
G1 X89.273 Y103.032 E.00869
G1 X88.893 Y103.161 E.00849
G1 X88.5 Y103.243 E.00849
G1 X88.1 Y103.279 E.00849
G1 X87.699 Y103.267 E.00849
G1 X87.116 Y103.164 E.01253
G1 X86.718 Y103.029 E.00889
G1 X86.193 Y102.757 E.01253
G1 X85.867 Y102.522 E.00849
G1 X85.571 Y102.251 E.00849
G1 X85.31 Y101.947 E.00849
G1 X85.086 Y101.613 E.00849
G1 X84.905 Y101.258 E.00844
G1 X84.753 Y100.833 E.00956
G1 X84.643 Y100.3 E.01153
G1 X84.62 Y99.89 E.00869
G1 X84.645 Y99.49 E.00849
G1 X84.718 Y99.095 E.0085
G1 X84.837 Y98.711 E.00849
G1 X84.999 Y98.347 E.00843
G1 X85.233 Y97.962 E.00956
G1 X85.455 Y97.676 E.00766
G1 X86.558 Y96.482 E.03441
G1 X81.536 Y96.482 E.10629
G1 X81.208 Y96.43 E.00703
G1 X80.982 Y96.311 E.0054
G1 X80.861 Y96.204 E.00343
G1 X80.761 Y96.077 E.00343
G1 X80.647 Y95.803 E.00627
G1 X80.619 Y95.565 E.00508
G1 X80.619 Y77.628 E.37965
G1 X80.655 Y77.357 E.00578
G1 X80.76 Y77.125 E.00539
G1 X80.861 Y76.998 E.00343
G1 X80.976 Y76.896 E.00324
G1 X81.197 Y76.775 E.00533
G1 X81.456 Y76.723 E.00561
G1 X94.516 Y76.722 E.27643
G1 X94.763 Y76.764 E.00528
G1 X94.976 Y76.861 E.00496
G1 X95.162 Y77.022 E.0052
G1 X95.283 Y77.207 E.00469
G1 X95.356 Y77.407 E.0045
G1 X95.378 Y77.559 E.00325
G1 X95.38 Y78.482 E.01952
G1 X95.019 Y78.482 E.00763
G1 X95.019 Y78.056 E.00901
G1 X94.983 Y77.809 E.00528
G1 X94.858 Y77.539 E.00631
G1 X94.649 Y77.304 E.00666
G1 X94.36 Y77.139 E.00705
G1 X94.087 Y77.082 E.00589
G1 X81.955 Y77.082 E.25679
G1 X81.696 Y77.12 E.00553
G1 X81.386 Y77.276 E.00736
G1 X81.147 Y77.529 E.00736
G1 X81.017 Y77.807 E.00649
G1 X80.981 Y78.056 E.00533
G1 X80.981 Y95.164 E.36211
G1 X81.05 Y95.5 E.00727
G1 X81.257 Y95.815 E.00796
G1 X81.591 Y96.049 E.00863
G1 X81.937 Y96.12 E.00748
G1 X86.774 Y96.119 E.10239
; WIPE_START
M204 S6000
G1 X88.774 Y96.119 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X85.623 Y96.891 Z5.16 F18000
G1 Z4.76
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X81.512 Y96.891 E.08086
G1 X81.197 Y96.854 E.00625
G1 X81.062 Y96.814 E.00277
G1 X80.853 Y96.716 E.00454
G1 X80.732 Y96.637 E.00283
G1 X80.562 Y96.486 E.00448
G1 X80.421 Y96.307 E.00448
G1 X80.351 Y96.185 E.00277
G1 X80.246 Y95.898 E.00601
G1 X80.21 Y95.589 E.00613
G1 X80.21 Y77.61 E.35362
G1 X80.231 Y77.374 E.00466
G1 X80.264 Y77.234 E.00283
G1 X80.349 Y77.019 E.00454
G1 X80.421 Y76.895 E.00283
G1 X80.562 Y76.716 E.00448
G1 X80.73 Y76.567 E.00442
G1 X80.924 Y76.447 E.00448
G1 X81.058 Y76.389 E.00287
G1 X81.217 Y76.343 E.00325
G1 X81.428 Y76.313 E.00418
G1 X94.551 Y76.313 E.25812
G1 X94.873 Y76.367 E.00644
G1 X95.081 Y76.45 E.0044
G1 X95.206 Y76.522 E.00283
G1 X95.387 Y76.665 E.00454
G1 X95.484 Y76.767 E.00277
G1 X95.652 Y77.023 E.00601
G1 X95.755 Y77.307 E.00594
G1 X95.787 Y77.529 E.00442
G1 X95.79 Y78.891 E.02678
G1 X94.61 Y78.891 E.0232
G1 X94.61 Y78.086 E.01584
G1 X94.587 Y77.927 E.00316
G1 X94.513 Y77.766 E.00348
G1 X94.388 Y77.627 E.00368
G1 X94.213 Y77.526 E.00397
G1 X94.045 Y77.492 E.00337
G1 X81.985 Y77.491 E.23721
G1 X81.821 Y77.515 E.00325
G1 X81.634 Y77.609 E.00413
G1 X81.49 Y77.762 E.00413
G1 X81.413 Y77.925 E.00355
G1 X81.39 Y78.086 E.00319
G1 X81.39 Y95.122 E.3351
G1 X81.435 Y95.341 E.00439
G1 X81.556 Y95.524 E.00431
G1 X81.756 Y95.665 E.00482
G1 X81.979 Y95.711 E.00446
G1 X94.068 Y95.709 E.2378
G1 X94.243 Y95.663 E.00354
G1 X94.397 Y95.568 E.00356
G1 X94.526 Y95.415 E.00393
G1 X94.599 Y95.234 E.00384
G1 X94.608 Y94.311 E.01816
G1 X95.79 Y94.311 E.02325
G1 X95.79 Y95.589 E.02513
G1 X95.754 Y95.898 E.00613
G1 X95.651 Y96.182 E.00594
G1 X95.534 Y96.371 E.00436
G1 X95.387 Y96.536 E.00436
G1 X95.144 Y96.717 E.00594
G1 X94.87 Y96.835 E.00589
G1 X94.569 Y96.888 E.00601
G1 X90.377 Y96.891 E.08245
G1 X90.857 Y97.411 E.01392
G1 X91.134 Y97.77 E.00891
G1 X91.364 Y98.156 E.00885
G1 X91.548 Y98.57 E.00891
G1 X91.619 Y98.777 E.00431
G1 X91.728 Y99.22 E.00897
G1 X91.761 Y99.437 E.00431
G1 X91.79 Y99.891 E.00895
G1 X91.78 Y100.16 E.00531
G1 X91.732 Y100.563 E.00798
G1 X91.687 Y100.778 E.00432
G1 X91.555 Y101.215 E.00897
G1 X91.473 Y101.418 E.0043
G1 X91.267 Y101.821 E.00891
G1 X91.017 Y102.195 E.00885
G1 X90.724 Y102.535 E.00883
G1 X90.352 Y102.871 E.00985
G1 X90.024 Y103.105 E.00792
G1 X89.836 Y103.216 E.00431
G1 X89.427 Y103.412 E.00891
G1 X89.001 Y103.556 E.00885
G1 X88.561 Y103.649 E.00885
G1 X88.113 Y103.689 E.00885
G1 X87.663 Y103.676 E.00885
G1 X87.215 Y103.608 E.00891
G1 X87.002 Y103.557 E.0043
G1 X86.57 Y103.411 E.00898
G1 X86.37 Y103.322 E.0043
G1 X85.973 Y103.103 E.00891
G1 X85.608 Y102.84 E.00885
G1 X85.277 Y102.536 E.00885
G1 X84.983 Y102.195 E.00885
G1 X84.733 Y101.821 E.00885
G1 X84.529 Y101.421 E.00883
G1 X84.36 Y100.95 E.00985
G1 X84.268 Y100.558 E.00792
G1 X84.236 Y100.341 E.00431
G1 X84.21 Y99.889 E.00891
G1 X84.239 Y99.44 E.00885
G1 X84.32 Y98.997 E.00885
G1 X84.453 Y98.567 E.00885
G1 X84.635 Y98.157 E.00883
G1 X84.896 Y97.729 E.00985
G1 X85.143 Y97.411 E.00792
G1 X85.582 Y96.935 E.01275
; WIPE_START
M204 S6000
G1 X83.583 Y96.913 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G17
G3 Z5.16 I1.217 J0 P1  F18000
;===================== date: 20250206 =====================

; don't support timelapse gcode in spiral_mode and by object sequence for I3 structure printer
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
G92 E0
G1 Z5.16
G1 X0 Y90 ; move to safe pos
G1 X-13.0 F3000 ; move to safe pos
M400
M1004 S5 P1  ; external shutter
M400 P300
M971 S11 C11 O0
G92 E0
G1 X0 F18000
M623

; SKIPTYPE: head_wrap_detect
M622.1 S1
M1002 judge_flag g39_3rd_layer_detect_flag
M622 J1
    ; enable nozzle clog detect at 3rd layer
    


    M622.1 S1
    M1002 judge_flag g39_detection_flag
    M622 J1
      
        M622.1 S0
        M1002 judge_flag g39_mass_exceed_flag
        M622 J1
        
            G392 S0
            M400
            G90
            M83
            M204 S5000
            G0 Z5.16 F4000
            G39.3 S1
            G0 Z5.16 F4000
            G392 S0
          
        M623
    
    M623
M623
; SKIPPABLE_END




G1 X81.442 Y96.257
G1 Z4.76
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.148941
G1 F1500
M204 S6000
G1 X81.193 Y96.113 E.00176
G1 X81.062 Y96.014 E.00101
G1 X80.974 Y95.89 E.00093
G1 X80.85 Y95.643 E.0017
; WIPE_START
G1 X80.974 Y95.89 E-.11941
G1 X81.062 Y96.014 E-.06549
G1 X81.193 Y96.113 E-.0711
G1 X81.442 Y96.257 E-.12399
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X86.751 Y97.351 Z5.16 F18000
G1 Z4.76
G1 E.4 F1800
; LINE_WIDTH: 0.396268
G1 F1500
M204 S6000
G1 X86.476 Y97.284 E.00524
; LINE_WIDTH: 0.434613
G1 X86.452 Y97.279 E.00049
; LINE_WIDTH: 0.44914
G1 X86.428 Y97.274 E.00051
G1 X86.185 Y97.481 E.00675
; LINE_WIDTH: 0.406704
G1 X86.164 Y97.5 E.00054
; LINE_WIDTH: 0.373376
G1 X85.79 Y97.871 E.00912
G1 X85.548 Y98.179 E.00679
; LINE_WIDTH: 0.360447
G1 X85.339 Y98.526 E.00677
G1 X85.237 Y98.739 E.00395
G1 X85.113 Y99.094 E.00628
G1 X85.031 Y99.481 E.00661
G1 X85.003 Y99.891 E.00687
G1 X85.026 Y100.256 E.00611
G1 X85.121 Y100.727 E.00802
G1 X85.255 Y101.107 E.00673
G1 X85.415 Y101.42 E.00587
G1 X85.614 Y101.715 E.00594
G1 X85.936 Y102.076 E.00808
G1 X86.36 Y102.412 E.00903
G1 X86.819 Y102.657 E.00869
G1 X87.17 Y102.778 E.00619
G1 X87.536 Y102.862 E.00627
G1 X88.06 Y102.9 E.00877
G1 X88.443 Y102.864 E.00643
G1 X88.915 Y102.755 E.00809
G1 X89.254 Y102.621 E.00609
G1 X89.71 Y102.364 E.00873
G1 X90.126 Y102.016 E.00905
G1 X90.461 Y101.612 E.00877
G1 X90.656 Y101.29 E.00628
G1 X90.805 Y100.951 E.00619
G1 X90.919 Y100.58 E.00647
G1 X90.953 Y100.438 E.00244
G1 X91.001 Y99.899 E.00905
G1 X90.954 Y99.371 E.00885
G1 X90.811 Y98.854 E.00895
G1 X90.663 Y98.52 E.0061
G1 X90.477 Y98.209 E.00605
G1 X90.157 Y97.815 E.00848
G1 X89.875 Y97.536 E.00662
; LINE_WIDTH: 0.413126
G1 X89.753 Y97.429 E.00313
; LINE_WIDTH: 0.450313
G1 X89.606 Y97.302 E.00411
; LINE_WIDTH: 0.481782
G1 X89.379 Y97.129 E.0065
; WIPE_START
G1 X89.606 Y97.302 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X94.53 Y96.242 Z5.16 F18000
G1 Z4.76
G1 E.4 F1800
; LINE_WIDTH: 0.104124
G1 F1500
M204 S6000
G1 X94.675 Y96.186 E.00061
; LINE_WIDTH: 0.151284
G1 X94.854 Y96.083 E.00129
G1 X95.031 Y95.879 E.00169
; LINE_WIDTH: 0.13127
G1 X95.096 Y95.767 E.00068
; LINE_WIDTH: 0.0949286
G1 X95.137 Y95.625 E.00051
; WIPE_START
G1 X95.096 Y95.767 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X95.118 Y88.134 Z5.16 F18000
G1 X95.147 Y77.602 Z5.16
G1 Z4.76
G1 E.4 F1800
; LINE_WIDTH: 0.10328
G1 F1500
M204 S6000
G1 X95.073 Y77.389 E.00087
; LINE_WIDTH: 0.150823
G1 X94.94 Y77.203 E.00143
G1 X94.83 Y77.096 E.00096
G1 X94.689 Y77.021 E.00099
; LINE_WIDTH: 0.120177
G1 X94.604 Y76.991 E.00043
; LINE_WIDTH: 0.0932226
G1 X94.519 Y76.96 E.0003
; WIPE_START
G1 X94.604 Y76.991 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X86.972 Y76.97 Z5.16 F18000
G1 X81.504 Y76.955 Z5.16
G1 Z4.76
G1 E.4 F1800
; LINE_WIDTH: 0.089837
G1 F1500
M204 S6000
G1 X81.395 Y76.991 E.00037
; LINE_WIDTH: 0.125086
G1 X81.217 Y77.066 E.00096
; LINE_WIDTH: 0.1559
G1 X81.071 Y77.194 E.00126
G1 X80.924 Y77.387 E.00158
; LINE_WIDTH: 0.105134
G1 X80.857 Y77.595 E.00086
; WIPE_START
G1 X80.924 Y77.387 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X88.326 Y79.252 Z5.16 F18000
G1 X96.515 Y81.316 Z5.16
G1 Z4.76
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
M73 P87 R3
G1 F1500
M204 S500
G1 X97.485 Y81.316 E.02053
G1 X97.485 Y82.286 E.02053
G1 X96.515 Y82.286 E.02053
G1 X96.515 Y81.376 E.01926
M204 S10000
G1 X96.091 Y80.892 F18000
G1 F1500
M204 S500
G1 X97.909 Y80.892 E.03849
G1 X97.909 Y82.71 E.03849
G1 X96.091 Y82.71 E.03849
G1 X96.091 Y80.952 E.03722
M204 S250
G1 X95.681 Y80.482 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X98.319 Y80.482 E.05187
G1 X98.319 Y83.119 E.05187
G1 X95.681 Y83.119 E.05187
G1 X95.681 Y80.542 E.05069
; CHANGE_LAYER
; Z_HEIGHT: 4.88
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F1500
M204 S6000
G1 X97.681 Y80.497 E-.38
; WIPE_END
G1 E-.02 F1800
; layer num/total_layer_count: 40/49
; update layer progress
M73 L40
M991 S0 P39 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z5.16 I-1.084 J-.552 P1  F18000
G1 X89.219 Y97.115 Z5.16
G1 Z4.88
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X89.098 Y97.059 E.00282
G1 X88.604 Y96.915 E.0109
G1 X88.229 Y96.864 E.00801
G1 X87.877 Y96.858 E.00746
G1 X87.325 Y96.928 E.01177
G1 X86.766 Y97.11 E.01246
G1 X86.659 Y96.949 E.0041
G1 X87.012 Y96.543 E.01138
G1 X88.988 Y96.543 E.04184
G1 X89.343 Y96.951 E.01144
G1 X89.255 Y97.068 E.00309
; WIPE_START
M204 S6000
G1 X89.098 Y97.059 E-.02987
G1 X88.604 Y96.915 E-.09784
G1 X88.229 Y96.864 E-.07188
G1 X87.877 Y96.858 E-.067
G1 X87.325 Y96.928 E-.10562
G1 X87.286 Y96.941 E-.00781
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X90.617 Y99.849 Z5.28 F18000
G1 Z4.88
G1 E.4 F1800
G1 F1500
M204 S500
G1 X90.622 Y99.901 E.0011
G1 X90.58 Y100.36 E.00975
G1 X90.504 Y100.672 E.00681
G1 X90.401 Y100.951 E.00628
G1 X90.168 Y101.376 E.01026
G1 X89.868 Y101.741 E.01
G1 X89.507 Y102.046 E.01
G1 X89.085 Y102.286 E.01027
G1 X88.809 Y102.393 E.00628
G1 X88.497 Y102.474 E.00681
G1 X88.039 Y102.522 E.00975
G1 X87.568 Y102.487 E.01
G1 X87.1 Y102.362 E.01027
G1 X86.827 Y102.244 E.00628
G1 X86.548 Y102.083 E.00681
G1 X86.188 Y101.796 E.00975
G1 X85.879 Y101.442 E.00995
G1 X85.638 Y101.039 E.00995
G1 X85.476 Y100.607 E.00975
G1 X85.409 Y100.291 E.00683
G1 X85.38 Y99.97 E.00683
G1 X85.408 Y99.508 E.0098
G1 X85.526 Y99.037 E.01027
G1 X85.64 Y98.763 E.00629
G1 X85.796 Y98.482 E.0068
G1 X86.078 Y98.118 E.00975
G1 X86.42 Y97.809 E.00975
G1 X86.69 Y97.632 E.00683
G1 X86.978 Y97.487 E.00683
G1 X87.419 Y97.344 E.0098
G1 X87.9 Y97.283 E.01027
G1 X88.197 Y97.288 E.00629
G1 X88.516 Y97.331 E.00681
G1 X88.949 Y97.458 E.00955
G1 X89.242 Y97.593 E.00683
G1 X89.516 Y97.763 E.00683
G1 X89.869 Y98.062 E.0098
G1 X90.175 Y98.439 E.01027
G1 X90.326 Y98.695 E.00628
G1 X90.457 Y98.989 E.00681
G1 X90.58 Y99.433 E.00975
G1 X90.612 Y99.789 E.00758
M204 S250
G1 X90.209 Y99.886 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X90.211 Y99.901 E.0003
G1 X90.176 Y100.292 E.00773
G1 X90.112 Y100.552 E.00526
G1 X90.028 Y100.78 E.00478
G1 X89.827 Y101.146 E.0082
G1 X89.575 Y101.452 E.00781
G1 X89.272 Y101.709 E.00781
G1 X88.909 Y101.915 E.0082
G1 X88.683 Y102.003 E.00478
G1 X88.424 Y102.07 E.00525
G1 X88.033 Y102.111 E.00774
G1 X87.637 Y102.082 E.00781
G1 X87.234 Y101.974 E.0082
G1 X87.011 Y101.878 E.00478
G1 X86.78 Y101.744 E.00526
G1 X86.472 Y101.499 E.00773
G1 X86.211 Y101.2 E.0078
G1 X86.008 Y100.86 E.00779
G1 X85.87 Y100.492 E.00774
G1 X85.814 Y100.23 E.00526
G1 X85.79 Y99.964 E.00526
G1 X85.814 Y99.571 E.00775
G1 X85.916 Y99.166 E.0082
G1 X86.009 Y98.941 E.00479
G1 X86.139 Y98.708 E.00525
G1 X86.379 Y98.397 E.00773
G1 X86.671 Y98.134 E.00773
G1 X86.895 Y97.987 E.00526
G1 X87.134 Y97.867 E.00526
G1 X87.509 Y97.745 E.00775
G1 X87.922 Y97.692 E.0082
G1 X88.166 Y97.697 E.00478
G1 X88.43 Y97.733 E.00525
G1 X88.805 Y97.842 E.00767
G1 X89.047 Y97.954 E.00526
G1 X89.275 Y98.095 E.00526
G1 X89.576 Y98.35 E.00775
G1 X89.838 Y98.674 E.0082
G1 X89.962 Y98.883 E.00478
G1 X90.071 Y99.127 E.00526
G1 X90.175 Y99.506 E.00773
G1 X90.204 Y99.826 E.00631
; WIPE_START
M204 S6000
G1 X90.211 Y99.901 E-.01431
G1 X90.176 Y100.292 E-.0747
G1 X90.112 Y100.552 E-.05079
G1 X90.028 Y100.78 E-.04621
G1 X89.827 Y101.146 E-.0792
G1 X89.575 Y101.452 E-.07548
G1 X89.417 Y101.586 E-.03933
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X86.761 Y96.119 Z5.28 F18000
G1 Z4.88
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X94.122 Y96.118 E.1558
G1 X94.406 Y96.043 E.00622
G1 X94.667 Y95.881 E.00651
G1 X94.881 Y95.629 E.00701
G1 X95.007 Y95.316 E.00714
G1 X95.013 Y94.72 E.0126
G1 X95.381 Y94.72 E.00778
G1 X95.381 Y95.565 E.01788
G1 X95.353 Y95.803 E.00508
G1 X95.28 Y96.003 E.0045
G1 X95.209 Y96.119 E.00289
G1 X95.067 Y96.27 E.00438
G1 X94.945 Y96.357 E.00319
G1 X94.751 Y96.441 E.00445
G1 X94.533 Y96.479 E.00469
G1 X89.498 Y96.483 E.10657
G1 X90.683 Y97.845 E.03822
G1 X91 Y98.345 E.01254
G1 X91.167 Y98.72 E.00869
G1 X91.326 Y99.3 E.01273
G1 X91.38 Y99.896 E.01267
G1 X91.327 Y100.497 E.01277
G1 X91.168 Y101.079 E.01276
G1 X90.914 Y101.613 E.01254
G1 X90.69 Y101.947 E.00849
G1 X90.423 Y102.258 E.00869
G1 X89.974 Y102.644 E.01253
G1 X89.635 Y102.859 E.0085
G1 X89.273 Y103.032 E.00849
G1 X88.893 Y103.161 E.00849
G1 X88.5 Y103.243 E.0085
G1 X88.1 Y103.279 E.00849
G1 X87.699 Y103.267 E.00849
G1 X87.116 Y103.164 E.01254
G1 X86.727 Y103.032 E.00869
G1 X86.364 Y102.858 E.00851
G1 X85.872 Y102.527 E.01258
G1 X85.571 Y102.251 E.00863
G1 X85.31 Y101.947 E.00849
G1 X85.086 Y101.613 E.00849
G1 X84.905 Y101.258 E.00844
G1 X84.754 Y100.838 E.00946
G1 X84.643 Y100.3 E.01162
G1 X84.62 Y99.89 E.00869
G1 X84.645 Y99.49 E.00849
G1 X84.718 Y99.095 E.0085
G1 X84.836 Y98.714 E.00844
G1 X85.021 Y98.307 E.00946
G1 X85.317 Y97.845 E.01162
G1 X86.503 Y96.482 E.03825
G1 X81.536 Y96.482 E.10513
G1 X81.208 Y96.43 E.00703
G1 X80.981 Y96.311 E.00542
G1 X80.878 Y96.219 E.00292
G1 X80.735 Y96.03 E.00502
G1 X80.649 Y95.821 E.00478
G1 X80.619 Y95.565 E.00546
G1 X80.619 Y77.628 E.37965
G1 X80.655 Y77.357 E.00578
G1 X80.768 Y77.114 E.00567
G1 X80.86 Y76.999 E.00312
G1 X80.975 Y76.896 E.00327
G1 X81.191 Y76.778 E.0052
G1 X81.449 Y76.723 E.00558
G1 X94.518 Y76.722 E.27662
G1 X94.762 Y76.764 E.00525
G1 X94.976 Y76.861 E.00496
G1 X95.162 Y77.022 E.0052
G1 X95.283 Y77.208 E.00469
G1 X95.356 Y77.407 E.0045
G1 X95.378 Y77.559 E.00325
G1 X95.38 Y78.482 E.01952
G1 X95.019 Y78.482 E.00763
G1 X95.019 Y78.056 E.00901
G1 X94.983 Y77.809 E.00529
G1 X94.858 Y77.539 E.0063
G1 X94.649 Y77.305 E.00664
G1 X94.359 Y77.139 E.00706
G1 X94.087 Y77.082 E.00589
G1 X81.946 Y77.082 E.25698
G1 X81.657 Y77.133 E.0062
G1 X81.381 Y77.282 E.00665
G1 X81.152 Y77.522 E.00703
G1 X81.018 Y77.805 E.00662
G1 X80.981 Y78.056 E.00537
G1 X80.981 Y95.164 E.36211
G1 X81.05 Y95.501 E.00727
G1 X81.257 Y95.815 E.00796
G1 X81.591 Y96.049 E.00864
G1 X81.937 Y96.12 E.00747
G1 X86.701 Y96.119 E.10083
; WIPE_START
M204 S6000
G1 X88.701 Y96.119 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X85.605 Y96.891 Z5.28 F18000
G1 Z4.88
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X81.512 Y96.891 E.08049
G1 X81.197 Y96.854 E.00625
G1 X81.062 Y96.814 E.00277
G1 X80.853 Y96.716 E.00454
G1 X80.732 Y96.637 E.00284
G1 X80.576 Y96.499 E.0041
G1 X80.382 Y96.242 E.00633
G1 X80.287 Y96.039 E.00441
G1 X80.247 Y95.904 E.00277
G1 X80.21 Y95.589 E.00625
G1 X80.21 Y77.61 E.35362
G1 X80.231 Y77.374 E.00466
G1 X80.264 Y77.234 E.00283
G1 X80.349 Y77.02 E.00452
G1 X80.43 Y76.882 E.00316
G1 X80.562 Y76.716 E.00416
G1 X80.73 Y76.567 E.00443
G1 X80.924 Y76.447 E.00448
G1 X81.056 Y76.39 E.00283
G1 X81.279 Y76.33 E.00454
G1 X81.425 Y76.313 E.00289
G1 X94.552 Y76.313 E.2582
G1 X94.873 Y76.367 E.0064
G1 X95.081 Y76.45 E.0044
G1 X95.206 Y76.522 E.00283
G1 X95.387 Y76.665 E.00454
G1 X95.484 Y76.768 E.00277
G1 X95.652 Y77.023 E.00601
G1 X95.755 Y77.307 E.00594
G1 X95.787 Y77.529 E.00442
G1 X95.79 Y78.891 E.02678
G1 X94.61 Y78.891 E.0232
G1 X94.61 Y78.086 E.01584
G1 X94.587 Y77.927 E.00316
G1 X94.513 Y77.766 E.00348
G1 X94.388 Y77.627 E.00367
G1 X94.213 Y77.526 E.00398
G1 X94.045 Y77.492 E.00337
G1 X81.982 Y77.491 E.23727
G1 X81.793 Y77.524 E.00376
G1 X81.632 Y77.611 E.0036
G1 X81.493 Y77.757 E.00396
G1 X81.414 Y77.925 E.00365
G1 X81.39 Y78.086 E.0032
G1 X81.39 Y95.122 E.3351
G1 X81.435 Y95.341 E.00439
G1 X81.556 Y95.524 E.00431
G1 X81.757 Y95.665 E.00483
G1 X81.979 Y95.711 E.00446
G1 X94.069 Y95.709 E.23781
G1 X94.243 Y95.663 E.00353
G1 X94.397 Y95.568 E.00356
G1 X94.526 Y95.414 E.00394
G1 X94.599 Y95.234 E.00382
G1 X94.608 Y94.311 E.01816
G1 X95.79 Y94.311 E.02325
G1 X95.79 Y95.589 E.02513
G1 X95.754 Y95.898 E.00613
G1 X95.651 Y96.182 E.00594
G1 X95.535 Y96.368 E.00431
G1 X95.338 Y96.58 E.00569
G1 X95.146 Y96.716 E.00462
G1 X94.87 Y96.835 E.00593
G1 X94.569 Y96.888 E.006
G1 X90.396 Y96.891 E.08208
G1 X91.004 Y97.59 E.01822
G1 X91.132 Y97.767 E.0043
G1 X91.364 Y98.156 E.00891
G1 X91.548 Y98.57 E.00891
G1 X91.619 Y98.777 E.00431
M73 P87 R2
G1 X91.728 Y99.22 E.00897
G1 X91.761 Y99.437 E.00431
G1 X91.79 Y99.891 E.00895
G1 X91.78 Y100.156 E.00522
G1 X91.732 Y100.563 E.00807
G1 X91.687 Y100.778 E.00431
G1 X91.555 Y101.215 E.00897
G1 X91.473 Y101.418 E.0043
G1 X91.267 Y101.821 E.00891
G1 X91.017 Y102.195 E.00885
G1 X90.721 Y102.538 E.00891
G1 X90.565 Y102.691 E.0043
G1 X90.213 Y102.977 E.00891
G1 X89.833 Y103.218 E.00885
G1 X89.427 Y103.412 E.00885
G1 X89.001 Y103.556 E.00885
G1 X88.56 Y103.649 E.00885
G1 X88.113 Y103.689 E.00884
G1 X87.663 Y103.676 E.00885
G1 X87.215 Y103.608 E.00891
G1 X87.002 Y103.557 E.0043
G1 X86.573 Y103.412 E.00891
G1 X86.167 Y103.218 E.00886
G1 X85.822 Y103.001 E.00801
G1 X85.61 Y102.842 E.00521
G1 X85.277 Y102.536 E.00889
G1 X84.983 Y102.195 E.00885
G1 X84.733 Y101.821 E.00885
G1 X84.529 Y101.421 E.00883
G1 X84.361 Y100.954 E.00976
G1 X84.268 Y100.558 E.00801
G1 X84.236 Y100.341 E.00431
G1 X84.21 Y99.889 E.00891
G1 X84.239 Y99.44 E.00885
G1 X84.32 Y98.997 E.00885
G1 X84.453 Y98.568 E.00884
G1 X84.658 Y98.116 E.00976
G1 X84.868 Y97.767 E.00801
G1 X84.996 Y97.59 E.00431
G1 X85.565 Y96.936 E.01705
; WIPE_START
M204 S6000
G1 X83.565 Y96.914 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G17
G3 Z5.28 I1.217 J0 P1  F18000
;===================== date: 20250206 =====================

; don't support timelapse gcode in spiral_mode and by object sequence for I3 structure printer
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
G92 E0
G1 Z5.28
G1 X0 Y90 ; move to safe pos
G1 X-13.0 F3000 ; move to safe pos
M400
M1004 S5 P1  ; external shutter
M400 P300
M971 S11 C11 O0
G92 E0
G1 X0 F18000
M623

; SKIPTYPE: head_wrap_detect
M622.1 S1
M1002 judge_flag g39_3rd_layer_detect_flag
M622 J1
    ; enable nozzle clog detect at 3rd layer
    


    M622.1 S1
    M1002 judge_flag g39_detection_flag
    M622 J1
      
        M622.1 S0
        M1002 judge_flag g39_mass_exceed_flag
        M622 J1
        
            G392 S0
            M400
            G90
            M83
            M204 S5000
            G0 Z5.28 F4000
            G39.3 S1
            G0 Z5.28 F4000
            G392 S0
          
        M623
    
    M623
M623
; SKIPPABLE_END




G1 X81.442 Y96.257
G1 Z4.88
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.151751
G1 F1500
M204 S6000
G1 X81.193 Y96.113 E.00181
G1 X81.067 Y96.016 E.001
G1 X80.844 Y95.655 E.00266
; WIPE_START
G1 X81.067 Y96.016 E-.18495
G1 X81.193 Y96.113 E-.06959
G1 X81.442 Y96.257 E-.12546
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X86.548 Y97.165 Z5.28 F18000
G1 Z4.88
G1 E.4 F1800
; LINE_WIDTH: 0.477108
G1 F1500
M204 S6000
G1 X86.367 Y97.319 E.00534
; LINE_WIDTH: 0.438382
G1 X86.16 Y97.496 E.00562
; LINE_WIDTH: 0.400591
G1 X85.986 Y97.673 E.00464
; LINE_WIDTH: 0.359832
G1 X85.621 Y98.08 E.00911
G1 X85.358 Y98.487 E.00808
G1 X85.171 Y98.907 E.00767
G1 X85.038 Y99.435 E.00907
G1 X85.003 Y99.891 E.00762
G1 X85.023 Y100.257 E.0061
G1 X85.116 Y100.725 E.00796
G1 X85.256 Y101.106 E.00677
G1 X85.418 Y101.419 E.00586
G1 X85.613 Y101.716 E.00593
G1 X85.939 Y102.078 E.00812
G1 X86.348 Y102.398 E.00866
G1 X86.551 Y102.525 E.00399
G1 X86.871 Y102.678 E.00591
G1 X87.218 Y102.792 E.00609
G1 X87.52 Y102.857 E.00515
M73 P88 R2
G1 X88.03 Y102.9 E.00852
G1 X88.553 Y102.847 E.00875
G1 X88.916 Y102.755 E.00624
G1 X89.258 Y102.621 E.00613
G1 X89.736 Y102.347 E.00919
G1 X90.148 Y101.996 E.00902
G1 X90.385 Y101.714 E.00613
G1 X90.581 Y101.42 E.00589
G1 X90.809 Y100.949 E.00873
G1 X90.956 Y100.409 E.00932
G1 X91.001 Y99.899 E.00854
G1 X90.954 Y99.369 E.00887
G1 X90.859 Y99.006 E.00625
G1 X90.663 Y98.52 E.00873
G1 X90.378 Y98.08 E.00873
G1 X90.13 Y97.786 E.00642
; LINE_WIDTH: 0.378485
G1 X89.952 Y97.61 E.0044
; LINE_WIDTH: 0.419241
G1 X89.748 Y97.411 E.0056
; LINE_WIDTH: 0.468149
G1 X89.45 Y97.162 E.00857
; WIPE_START
G1 X89.748 Y97.411 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X94.53 Y96.242 Z5.28 F18000
G1 Z4.88
G1 E.4 F1800
; LINE_WIDTH: 0.104112
G1 F1500
M204 S6000
G1 X94.675 Y96.186 E.00061
; LINE_WIDTH: 0.150126
G1 X94.855 Y96.084 E.00129
G1 X95.032 Y95.878 E.00168
; LINE_WIDTH: 0.131012
G1 X95.097 Y95.766 E.00068
; LINE_WIDTH: 0.0948017
G1 X95.137 Y95.625 E.00051
; WIPE_START
G1 X95.097 Y95.766 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X95.118 Y88.134 Z5.28 F18000
G1 X95.147 Y77.602 Z5.28
G1 Z4.88
G1 E.4 F1800
; LINE_WIDTH: 0.103327
G1 F1500
M204 S6000
G1 X95.073 Y77.389 E.00087
; LINE_WIDTH: 0.150804
G1 X94.94 Y77.203 E.00143
G1 X94.83 Y77.096 E.00095
G1 X94.689 Y77.021 E.001
; LINE_WIDTH: 0.120174
G1 X94.604 Y76.991 E.00043
; LINE_WIDTH: 0.093228
G1 X94.519 Y76.96 E.0003
; WIPE_START
G1 X94.604 Y76.991 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X86.972 Y76.97 Z5.28 F18000
G1 X81.496 Y76.955 Z5.28
G1 Z4.88
G1 E.4 F1800
; LINE_WIDTH: 0.0812005
G1 F1500
M204 S6000
G1 X81.464 Y76.963 E.00009
; LINE_WIDTH: 0.0962736
G1 X81.372 Y76.997 E.00034
; LINE_WIDTH: 0.129578
G1 X81.21 Y77.072 E.00093
; LINE_WIDTH: 0.152701
G1 X81.069 Y77.195 E.00118
G1 X80.963 Y77.324 E.00106
G1 X80.905 Y77.433 E.00079
; LINE_WIDTH: 0.10053
G1 X80.857 Y77.596 E.00063
; WIPE_START
G1 X80.905 Y77.433 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X88.303 Y79.31 Z5.28 F18000
G1 X96.618 Y81.419 Z5.28
G1 Z4.88
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X97.382 Y81.419 E.01618
G1 X97.382 Y82.183 E.01618
G1 X96.618 Y82.183 E.01618
G1 X96.618 Y81.479 E.01491
M204 S10000
G1 X96.194 Y80.994 F18000
G1 F1500
M204 S500
G1 X97.806 Y80.994 E.03414
G1 X97.806 Y82.607 E.03414
G1 X96.194 Y82.607 E.03414
G1 X96.194 Y81.054 E.03287
M204 S250
G1 X95.784 Y80.585 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X98.216 Y80.585 E.04782
G1 X98.216 Y83.017 E.04782
G1 X95.784 Y83.017 E.04782
G1 X95.784 Y80.645 E.04664
; CHANGE_LAYER
; Z_HEIGHT: 5
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F1500
M204 S6000
G1 X97.784 Y80.596 E-.38
; WIPE_END
G1 E-.02 F1800
; layer num/total_layer_count: 41/49
; update layer progress
M73 L41
M991 S0 P40 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z5.28 I-1.08 J-.56 P1  F18000
G1 X89.219 Y97.115 Z5.28
G1 Z5
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X89.098 Y97.059 E.00282
G1 X88.604 Y96.915 E.01089
G1 X88.229 Y96.864 E.00801
G1 X87.874 Y96.858 E.00752
G1 X87.325 Y96.929 E.01171
G1 X86.766 Y97.11 E.01245
G1 X86.659 Y96.949 E.0041
G1 X87.012 Y96.543 E.01138
G1 X88.988 Y96.543 E.04183
G1 X89.343 Y96.951 E.01144
G1 X89.255 Y97.068 E.00309
; WIPE_START
M204 S6000
G1 X89.098 Y97.059 E-.02989
G1 X88.604 Y96.915 E-.09778
G1 X88.229 Y96.864 E-.07192
G1 X87.874 Y96.858 E-.06751
G1 X87.325 Y96.929 E-.1051
G1 X87.286 Y96.941 E-.00779
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X90.617 Y99.849 Z5.4 F18000
G1 Z5
G1 E.4 F1800
G1 F1500
M204 S500
G1 X90.621 Y99.892 E.00091
G1 X90.602 Y100.214 E.00683
G1 X90.544 Y100.531 E.00683
G1 X90.395 Y100.967 E.00975
G1 X90.166 Y101.378 E.00995
G1 X89.868 Y101.741 E.00995
G1 X89.507 Y102.046 E.00999
G1 X89.088 Y102.285 E.01021
G1 X88.809 Y102.393 E.00634
G1 X88.497 Y102.474 E.00681
G1 X88.037 Y102.523 E.00979
G1 X87.556 Y102.483 E.01021
G1 X87.264 Y102.416 E.00634
G1 X86.961 Y102.307 E.00681
G1 X86.556 Y102.089 E.00975
G1 X86.188 Y101.796 E.00995
G1 X85.878 Y101.44 E.00999
G1 X85.633 Y101.024 E.01022
G1 X85.52 Y100.747 E.00634
G1 X85.434 Y100.437 E.00681
G1 X85.379 Y99.979 E.00975
G1 X85.408 Y99.508 E.00999
G1 X85.525 Y99.04 E.01021
G1 X85.64 Y98.763 E.00634
G1 X85.796 Y98.482 E.00681
G1 X86.072 Y98.125 E.00956
G1 X86.305 Y97.903 E.00681
G1 X86.544 Y97.722 E.00634
G1 X86.968 Y97.491 E.01021
G1 X87.419 Y97.344 E.01004
G1 X87.897 Y97.283 E.01021
G1 X88.197 Y97.288 E.00634
G1 X88.516 Y97.331 E.00681
G1 X88.949 Y97.458 E.00955
G1 X89.242 Y97.593 E.00683
G1 X89.516 Y97.763 E.00683
G1 X89.868 Y98.061 E.00975
G1 X90.16 Y98.417 E.00975
G1 X90.326 Y98.694 E.00683
G1 X90.457 Y98.989 E.00683
G1 X90.58 Y99.433 E.00975
G1 X90.612 Y99.789 E.00757
M204 S250
G1 X90.209 Y99.886 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X90.211 Y99.898 E.00024
G1 X90.195 Y100.165 E.00526
G1 X90.147 Y100.428 E.00526
G1 X90.02 Y100.8 E.00773
G1 X89.827 Y101.146 E.0078
G1 X89.575 Y101.452 E.00779
G1 X89.272 Y101.709 E.00781
G1 X88.912 Y101.914 E.00815
G1 X88.683 Y102.003 E.00483
G1 X88.424 Y102.07 E.00526
G1 X88.032 Y102.112 E.00775
G1 X87.619 Y102.078 E.00815
G1 X87.38 Y102.022 E.00483
G1 X87.128 Y101.932 E.00525
G1 X86.782 Y101.746 E.00773
G1 X86.472 Y101.499 E.0078
G1 X86.211 Y101.2 E.00781
G1 X86.001 Y100.843 E.00815
G1 X85.908 Y100.615 E.00483
G1 X85.837 Y100.357 E.00526
G1 X85.79 Y99.967 E.00773
G1 X85.814 Y99.571 E.00781
G1 X85.915 Y99.169 E.00815
G1 X86.009 Y98.942 E.00483
G1 X86.139 Y98.708 E.00525
G1 X86.377 Y98.4 E.00767
G1 X86.571 Y98.215 E.00525
G1 X86.767 Y98.067 E.00483
G1 X87.13 Y97.868 E.00815
G1 X87.509 Y97.745 E.00783
G1 X87.92 Y97.692 E.00815
G1 X88.166 Y97.697 E.00483
G1 X88.43 Y97.733 E.00526
G1 X88.805 Y97.842 E.00767
G1 X89.047 Y97.954 E.00526
G1 X89.275 Y98.095 E.00526
G1 X89.575 Y98.349 E.00774
G1 X89.825 Y98.653 E.00773
G1 X89.962 Y98.883 E.00526
G1 X90.071 Y99.127 E.00526
G1 X90.175 Y99.506 E.00773
G1 X90.204 Y99.826 E.00631
; WIPE_START
M204 S6000
G1 X90.211 Y99.898 E-.01373
G1 X90.195 Y100.165 E-.05083
G1 X90.147 Y100.428 E-.05082
G1 X90.02 Y100.8 E-.07471
G1 X89.827 Y101.146 E-.07533
G1 X89.575 Y101.452 E-.0753
G1 X89.417 Y101.586 E-.03928
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X86.761 Y96.119 Z5.4 F18000
G1 Z5
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X94.122 Y96.118 E.15581
G1 X94.406 Y96.043 E.0062
G1 X94.667 Y95.882 E.0065
G1 X94.881 Y95.629 E.00702
G1 X95.007 Y95.316 E.00714
G1 X95.013 Y94.72 E.01261
G1 X95.381 Y94.72 E.00778
G1 X95.381 Y95.565 E.01788
G1 X95.353 Y95.803 E.00508
G1 X95.28 Y96.003 E.0045
G1 X95.205 Y96.125 E.00305
G1 X95.109 Y96.233 E.00305
G1 X94.938 Y96.36 E.0045
G1 X94.751 Y96.441 E.00431
G1 X94.533 Y96.479 E.0047
G1 X89.498 Y96.483 E.10657
G1 X90.681 Y97.843 E.03816
G1 X91 Y98.344 E.01257
G1 X91.167 Y98.72 E.00871
G1 X91.326 Y99.3 E.01273
G1 X91.38 Y99.896 E.01267
G1 X91.327 Y100.497 E.01277
G1 X91.171 Y101.07 E.01256
G1 X91.01 Y101.437 E.00849
G1 X90.696 Y101.94 E.01254
G1 X90.43 Y102.249 E.00864
G1 X90.102 Y102.546 E.00936
G1 X89.643 Y102.855 E.01172
G1 X89.273 Y103.032 E.00869
G1 X88.893 Y103.161 E.00849
G1 X88.5 Y103.243 E.0085
G1 X88.1 Y103.279 E.00849
G1 X87.699 Y103.267 E.00849
G1 X87.118 Y103.164 E.01249
G1 X86.692 Y103.016 E.00955
G1 X86.358 Y102.855 E.00785
G1 X85.867 Y102.522 E.01255
G1 X85.571 Y102.251 E.0085
G1 X85.31 Y101.947 E.00849
G1 X85.086 Y101.613 E.00849
G1 X84.905 Y101.258 E.00845
G1 X84.755 Y100.842 E.00936
G1 X84.643 Y100.3 E.01172
G1 X84.62 Y99.89 E.00869
G1 X84.645 Y99.49 E.00849
G1 X84.718 Y99.095 E.00849
G1 X84.836 Y98.713 E.00845
G1 X85.019 Y98.311 E.00935
G1 X85.317 Y97.845 E.01171
G1 X86.503 Y96.482 E.03825
G1 X81.536 Y96.482 E.10513
G1 X81.298 Y96.454 E.00508
G1 X81.098 Y96.381 E.0045
G1 X80.968 Y96.301 E.00324
G1 X80.797 Y96.128 E.00514
G1 X80.742 Y96.045 E.00211
G1 X80.649 Y95.819 E.00518
G1 X80.619 Y95.565 E.00542
G1 X80.619 Y77.628 E.37965
G1 X80.655 Y77.357 E.00578
G1 X80.761 Y77.125 E.0054
G1 X80.937 Y76.926 E.00564
G1 X81.06 Y76.841 E.00316
G1 X81.206 Y76.772 E.00341
G1 X81.457 Y76.723 E.00541
G1 X94.52 Y76.722 E.27648
G1 X94.762 Y76.763 E.00521
G1 X94.981 Y76.865 E.00511
G1 X95.166 Y77.029 E.00522
G1 X95.283 Y77.208 E.00453
G1 X95.356 Y77.407 E.0045
G1 X95.378 Y77.559 E.00325
G1 X95.38 Y78.482 E.01952
G1 X95.019 Y78.482 E.00763
G1 X95.019 Y78.056 E.00901
G1 X94.983 Y77.809 E.00529
G1 X94.858 Y77.539 E.0063
G1 X94.649 Y77.305 E.00663
G1 X94.36 Y77.139 E.00707
G1 X94.087 Y77.082 E.00589
G1 X81.946 Y77.082 E.25698
G1 X81.657 Y77.133 E.00621
G1 X81.387 Y77.278 E.00649
G1 X81.171 Y77.495 E.00649
G1 X81.019 Y77.798 E.00717
G1 X80.981 Y78.056 E.00552
G1 X80.981 Y95.157 E.36195
G1 X81.038 Y95.469 E.00671
G1 X81.25 Y95.81 E.00851
G1 X81.591 Y96.049 E.0088
G1 X81.937 Y96.12 E.00748
G1 X86.701 Y96.119 E.10084
; WIPE_START
M204 S6000
G1 X88.701 Y96.119 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X85.605 Y96.891 Z5.4 F18000
G1 Z5
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X81.512 Y96.891 E.08049
G1 X81.203 Y96.855 E.00613
G1 X80.919 Y96.751 E.00595
G1 X80.728 Y96.633 E.00442
G1 X80.617 Y96.541 E.00284
G1 X80.473 Y96.38 E.00425
G1 X80.384 Y96.247 E.00313
G1 X80.292 Y96.052 E.00424
G1 X80.247 Y95.904 E.00306
G1 X80.21 Y95.589 E.00624
G1 X80.21 Y77.61 E.35362
G1 X80.231 Y77.374 E.00466
G1 X80.264 Y77.234 E.00283
G1 X80.349 Y77.02 E.00454
G1 X80.421 Y76.895 E.00283
G1 X80.564 Y76.714 E.00452
G1 X80.68 Y76.606 E.00312
G1 X80.855 Y76.485 E.00419
G1 X81.061 Y76.388 E.00447
G1 X81.214 Y76.344 E.00312
G1 X81.428 Y76.313 E.00425
G1 X94.554 Y76.313 E.25818
G1 X94.873 Y76.367 E.00637
G1 X95.081 Y76.45 E.00441
G1 X95.208 Y76.523 E.00287
G1 X95.337 Y76.621 E.00318
G1 X95.485 Y76.77 E.00413
G1 X95.652 Y77.023 E.00596
G1 X95.755 Y77.307 E.00594
G1 X95.787 Y77.529 E.00442
G1 X95.79 Y78.891 E.02678
G1 X94.61 Y78.891 E.0232
G1 X94.61 Y78.086 E.01584
G1 X94.587 Y77.927 E.00316
G1 X94.512 Y77.766 E.00348
G1 X94.389 Y77.627 E.00366
G1 X94.213 Y77.526 E.00399
G1 X94.045 Y77.492 E.00337
G1 X81.982 Y77.491 E.23727
G1 X81.793 Y77.524 E.00376
G1 X81.634 Y77.61 E.00355
G1 X81.507 Y77.737 E.00355
G1 X81.414 Y77.922 E.00407
G1 X81.39 Y78.086 E.00325
G1 X81.39 Y95.12 E.33505
G1 X81.426 Y95.318 E.00397
G1 X81.553 Y95.523 E.00473
G1 X81.756 Y95.665 E.00487
G1 X81.979 Y95.711 E.00446
G1 X94.07 Y95.709 E.23782
G1 X94.243 Y95.663 E.00352
G1 X94.396 Y95.568 E.00356
G1 X94.526 Y95.415 E.00395
G1 X94.599 Y95.234 E.00382
G1 X94.608 Y94.311 E.01816
G1 X95.79 Y94.311 E.02325
G1 X95.79 Y95.589 E.02513
G1 X95.754 Y95.898 E.00613
G1 X95.651 Y96.182 E.00594
G1 X95.534 Y96.371 E.00436
G1 X95.387 Y96.536 E.00436
G1 X95.144 Y96.717 E.00595
G1 X94.87 Y96.835 E.00588
G1 X94.569 Y96.888 E.00601
G1 X90.396 Y96.891 E.08208
G1 X91.003 Y97.589 E.0182
G1 X91.154 Y97.801 E.00512
G1 X91.364 Y98.156 E.0081
G1 X91.548 Y98.57 E.00892
G1 X91.619 Y98.777 E.00431
G1 X91.728 Y99.22 E.00897
G1 X91.761 Y99.437 E.00431
G1 X91.79 Y99.891 E.00895
G1 X91.781 Y100.151 E.00512
G1 X91.731 Y100.563 E.00816
G1 X91.687 Y100.778 E.00431
G1 X91.556 Y101.212 E.00891
G1 X91.375 Y101.624 E.00885
G1 X91.146 Y102.014 E.00891
G1 X91.019 Y102.192 E.00431
G1 X90.724 Y102.536 E.0089
G1 X90.359 Y102.865 E.00967
G1 X90.024 Y103.105 E.0081
G1 X89.836 Y103.216 E.00431
G1 X89.427 Y103.412 E.00891
G1 X89.001 Y103.556 E.00885
G1 X88.56 Y103.649 E.00885
G1 X88.113 Y103.689 E.00884
G1 X87.663 Y103.676 E.00885
G1 X87.215 Y103.608 E.00891
G1 X87.003 Y103.557 E.00429
G1 X86.536 Y103.395 E.00973
G1 X86.164 Y103.217 E.0081
G1 X85.976 Y103.105 E.00431
G1 X85.608 Y102.84 E.00891
G1 X85.276 Y102.536 E.00885
G1 X84.983 Y102.195 E.00885
G1 X84.733 Y101.821 E.00885
G1 X84.529 Y101.421 E.00884
G1 X84.362 Y100.959 E.00967
G1 X84.268 Y100.558 E.0081
G1 X84.236 Y100.341 E.00431
G1 X84.21 Y99.889 E.00891
G1 X84.239 Y99.44 E.00885
G1 X84.32 Y98.997 E.00885
G1 X84.453 Y98.568 E.00884
G1 X84.656 Y98.121 E.00966
G1 X84.868 Y97.767 E.0081
G1 X84.996 Y97.59 E.00431
G1 X85.565 Y96.936 E.01705
; WIPE_START
M204 S6000
G1 X83.565 Y96.914 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G17
G3 Z5.4 I1.217 J0 P1  F18000
;===================== date: 20250206 =====================

; don't support timelapse gcode in spiral_mode and by object sequence for I3 structure printer
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
G92 E0
G1 Z5.4
G1 X0 Y90 ; move to safe pos
G1 X-13.0 F3000 ; move to safe pos
M400
M1004 S5 P1  ; external shutter
M400 P300
M971 S11 C11 O0
G92 E0
G1 X0 F18000
M623

; SKIPTYPE: head_wrap_detect
M622.1 S1
M1002 judge_flag g39_3rd_layer_detect_flag
M622 J1
    ; enable nozzle clog detect at 3rd layer
    


    M622.1 S1
    M1002 judge_flag g39_detection_flag
    M622 J1
      
        M622.1 S0
        M1002 judge_flag g39_mass_exceed_flag
        M622 J1
        
            G392 S0
            M400
            G90
            M83
            M204 S5000
            G0 Z5.4 F4000
            G39.3 S1
            G0 Z5.4 F4000
            G392 S0
          
        M623
    
    M623
M623
; SKIPPABLE_END




G1 X81.452 Y96.25
M73 P89 R2
G1 Z5
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.147797
G1 F1500
M204 S6000
G1 X81.221 Y96.13 E.00158
G1 X81.096 Y96.043 E.00093
G1 X80.983 Y95.906 E.00109
G1 X80.93 Y95.81 E.00066
; LINE_WIDTH: 0.127646
G1 X80.896 Y95.718 E.0005
; LINE_WIDTH: 0.0947939
G1 X80.861 Y95.627 E.00034
; WIPE_START
G1 X80.896 Y95.718 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X86.549 Y97.167 Z5.4 F18000
G1 Z5
G1 E.4 F1800
; LINE_WIDTH: 0.477186
G1 F1500
M204 S6000
G1 X86.298 Y97.37 E.00727
; LINE_WIDTH: 0.442256
G1 X86.178 Y97.483 E.00342
; LINE_WIDTH: 0.40581
G1 X86.042 Y97.61 E.00353
; LINE_WIDTH: 0.360086
G1 X85.784 Y97.882 E.00625
G1 X85.477 Y98.286 E.00847
G1 X85.355 Y98.491 E.00397
G1 X85.192 Y98.849 E.00657
G1 X85.092 Y99.187 E.00588
G1 X85.024 Y99.536 E.00594
G1 X85.004 Y100.005 E.00783
G1 X85.065 Y100.497 E.00827
G1 X85.167 Y100.877 E.00656
G1 X85.3 Y101.202 E.00586
G1 X85.613 Y101.716 E.01003
G1 X85.939 Y102.078 E.00812
G1 X86.338 Y102.392 E.00848
G1 X86.796 Y102.647 E.00875
G1 X87.167 Y102.781 E.00657
G1 X87.51 Y102.855 E.00585
G1 X88.026 Y102.9 E.00864
G1 X88.553 Y102.847 E.00882
G1 X88.916 Y102.755 E.00625
G1 X89.261 Y102.62 E.00618
G1 X89.709 Y102.361 E.00864
G1 X90.147 Y101.996 E.00952
G1 X90.391 Y101.707 E.00629
G1 X90.67 Y101.261 E.00878
G1 X90.745 Y101.107 E.00286
G1 X90.913 Y100.614 E.00868
G1 X90.975 Y100.249 E.00618
G1 X91 Y99.898 E.00586
G1 X90.95 Y99.38 E.00868
G1 X90.859 Y99.004 E.00647
G1 X90.662 Y98.519 E.00872
G1 X90.377 Y98.077 E.00878
G1 X90.127 Y97.784 E.00641
; LINE_WIDTH: 0.378841
G1 X89.951 Y97.609 E.00438
; LINE_WIDTH: 0.419338
G1 X89.748 Y97.411 E.00557
; LINE_WIDTH: 0.468132
G1 X89.449 Y97.162 E.00857
; WIPE_START
G1 X89.748 Y97.411 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X94.529 Y96.242 Z5.4 F18000
G1 Z5
G1 E.4 F1800
; LINE_WIDTH: 0.104125
G1 F1500
M204 S6000
G1 X94.675 Y96.186 E.00061
; LINE_WIDTH: 0.151289
G1 X94.853 Y96.083 E.00129
G1 X95.031 Y95.879 E.0017
; LINE_WIDTH: 0.131257
G1 X95.097 Y95.766 E.00069
; LINE_WIDTH: 0.0948404
G1 X95.137 Y95.625 E.00051
; WIPE_START
G1 X95.097 Y95.766 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X95.118 Y88.134 Z5.4 F18000
G1 X95.147 Y77.602 Z5.4
G1 Z5
G1 E.4 F1800
; LINE_WIDTH: 0.10332
G1 F1500
M204 S6000
G1 X95.073 Y77.389 E.00087
; LINE_WIDTH: 0.150489
G1 X94.946 Y77.21 E.00137
G1 X94.829 Y77.095 E.00102
G1 X94.689 Y77.021 E.00099
; LINE_WIDTH: 0.12014
G1 X94.604 Y76.99 E.00043
; LINE_WIDTH: 0.0932145
G1 X94.519 Y76.96 E.0003
; WIPE_START
G1 X94.604 Y76.99 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X86.971 Y76.969 Z5.4 F18000
G1 X81.494 Y76.954 Z5.4
G1 Z5
G1 E.4 F1800
; LINE_WIDTH: 0.100308
G1 F1500
M204 S6000
G1 X81.358 Y76.999 E.00054
; LINE_WIDTH: 0.14538
G1 X81.219 Y77.066 E.00092
G1 X81.12 Y77.144 E.00075
G1 X80.961 Y77.321 E.00142
G1 X80.907 Y77.434 E.00075
; LINE_WIDTH: 0.102624
G1 X80.857 Y77.598 E.00066
; WIPE_START
G1 X80.907 Y77.434 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X88.297 Y79.344 Z5.4 F18000
G1 X96.721 Y81.521 Z5.4
G1 Z5
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X97.279 Y81.521 E.01183
G1 X97.279 Y82.08 E.01183
G1 X96.721 Y82.08 E.01183
G1 X96.721 Y81.581 E.01056
M204 S10000
G1 X96.296 Y81.097 F18000
G1 F1500
M204 S500
G1 X97.704 Y81.097 E.02979
G1 X97.704 Y82.505 E.02979
G1 X96.296 Y82.505 E.02979
G1 X96.296 Y81.157 E.02852
M204 S250
G1 X95.887 Y80.688 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X98.113 Y80.688 E.04378
G1 X98.113 Y82.914 E.04378
G1 X95.887 Y82.914 E.04378
G1 X95.887 Y80.748 E.0426
; CHANGE_LAYER
; Z_HEIGHT: 5.12
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F1500
M204 S6000
G1 X97.886 Y80.694 E-.38
; WIPE_END
G1 E-.02 F1800
; layer num/total_layer_count: 42/49
; update layer progress
M73 L42
M991 S0 P41 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z5.4 I-1.076 J-.568 P1  F18000
G1 X89.219 Y97.116 Z5.4
G1 Z5.12
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X89.098 Y97.059 E.00282
G1 X88.604 Y96.915 E.01089
G1 X88.229 Y96.864 E.00802
G1 X87.871 Y96.858 E.00758
G1 X87.325 Y96.929 E.01165
G1 X86.765 Y97.11 E.01245
G1 X86.659 Y96.949 E.0041
G1 X87.011 Y96.543 E.01138
G1 X88.988 Y96.543 E.04184
G1 X89.343 Y96.951 E.01144
G1 X89.255 Y97.068 E.00309
; WIPE_START
M204 S6000
G1 X89.098 Y97.059 E-.02988
G1 X88.604 Y96.915 E-.0978
G1 X88.229 Y96.864 E-.07197
G1 X87.871 Y96.858 E-.06802
G1 X87.325 Y96.929 E-.10462
G1 X87.286 Y96.941 E-.00771
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X90.617 Y99.849 Z5.52 F18000
G1 Z5.12
G1 E.4 F1800
G1 F1500
M204 S500
G1 X90.622 Y99.901 E.0011
G1 X90.58 Y100.36 E.00975
G1 X90.504 Y100.672 E.00682
G1 X90.399 Y100.956 E.0064
G1 X90.167 Y101.376 E.01016
G1 X89.868 Y101.741 E.00999
G1 X89.508 Y102.046 E.00999
G1 X89.09 Y102.284 E.01016
G1 X88.809 Y102.393 E.00639
G1 X88.497 Y102.474 E.00681
G1 X88.037 Y102.523 E.00979
G1 X87.559 Y102.484 E.01016
G1 X87.264 Y102.416 E.0064
G1 X86.961 Y102.307 E.00681
G1 X86.556 Y102.089 E.00975
G1 X86.188 Y101.796 E.00995
G1 X85.885 Y101.449 E.00975
G1 X85.711 Y101.177 E.00683
G1 X85.571 Y100.886 E.00683
G1 X85.436 Y100.446 E.00975
G1 X85.379 Y99.979 E.00995
G1 X85.408 Y99.508 E.00999
G1 X85.524 Y99.043 E.01016
G1 X85.639 Y98.763 E.00639
G1 X85.796 Y98.482 E.00681
G1 X86.078 Y98.118 E.00975
G1 X86.421 Y97.809 E.00975
G1 X86.69 Y97.632 E.00683
G1 X86.979 Y97.487 E.00684
G1 X87.418 Y97.344 E.00979
G1 X87.895 Y97.283 E.01016
G1 X88.197 Y97.288 E.00639
G1 X88.516 Y97.331 E.00682
G1 X88.949 Y97.458 E.00955
G1 X89.242 Y97.593 E.00683
G1 X89.516 Y97.763 E.00683
G1 X89.868 Y98.061 E.00975
G1 X90.16 Y98.417 E.00975
G1 X90.326 Y98.694 E.00683
G1 X90.457 Y98.989 E.00683
G1 X90.58 Y99.433 E.00976
G1 X90.612 Y99.789 E.00758
M204 S250
G1 X90.209 Y99.886 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X90.211 Y99.901 E.0003
G1 X90.176 Y100.292 E.00773
G1 X90.112 Y100.552 E.00526
G1 X90.026 Y100.785 E.00488
G1 X89.827 Y101.146 E.00811
G1 X89.575 Y101.452 E.00781
G1 X89.272 Y101.709 E.00781
G1 X88.914 Y101.913 E.0081
G1 X88.683 Y102.003 E.00488
G1 X88.424 Y102.07 E.00526
G1 X88.032 Y102.112 E.00775
G1 X87.622 Y102.078 E.0081
G1 X87.38 Y102.022 E.00488
G1 X87.128 Y101.932 E.00526
G1 X86.782 Y101.746 E.00773
G1 X86.472 Y101.499 E.0078
G1 X86.213 Y101.203 E.00773
G1 X86.069 Y100.977 E.00526
G1 X85.953 Y100.736 E.00526
G1 X85.837 Y100.36 E.00774
G1 X85.79 Y99.967 E.00779
G1 X85.814 Y99.571 E.00781
G1 X85.914 Y99.171 E.0081
G1 X86.009 Y98.942 E.00488
G1 X86.139 Y98.708 E.00526
G1 X86.379 Y98.397 E.00774
G1 X86.672 Y98.134 E.00773
G1 X86.895 Y97.987 E.00526
G1 X87.134 Y97.867 E.00526
G1 X87.509 Y97.745 E.00775
G1 X87.917 Y97.692 E.0081
G1 X88.165 Y97.697 E.00488
G1 X88.43 Y97.733 E.00526
G1 X88.805 Y97.842 E.00767
G1 X89.047 Y97.954 E.00526
G1 X89.275 Y98.095 E.00526
G1 X89.575 Y98.349 E.00774
G1 X89.825 Y98.653 E.00773
G1 X89.962 Y98.883 E.00526
G1 X90.071 Y99.127 E.00526
G1 X90.175 Y99.506 E.00774
G1 X90.204 Y99.826 E.00632
; WIPE_START
M204 S6000
G1 X90.211 Y99.901 E-.01426
G1 X90.176 Y100.292 E-.07469
G1 X90.112 Y100.552 E-.05081
G1 X90.026 Y100.785 E-.04714
G1 X89.827 Y101.146 E-.07831
G1 X89.575 Y101.452 E-.07542
G1 X89.417 Y101.586 E-.03937
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X86.761 Y96.119 Z5.52 F18000
G1 Z5.12
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X94.123 Y96.118 E.15583
G1 X94.406 Y96.043 E.00619
G1 X94.667 Y95.882 E.0065
G1 X94.882 Y95.628 E.00704
G1 X95.007 Y95.315 E.00713
G1 X95.013 Y94.72 E.0126
G1 X95.381 Y94.72 E.00778
G1 X95.381 Y95.565 E.01788
G1 X95.352 Y95.812 E.00527
G1 X95.309 Y95.94 E.00286
G1 X95.199 Y96.132 E.00469
G1 X95.109 Y96.233 E.00286
G1 X94.938 Y96.36 E.0045
G1 X94.751 Y96.441 E.00431
G1 X94.533 Y96.479 E.0047
G1 X89.498 Y96.483 E.10657
G1 X90.683 Y97.845 E.03822
G1 X91 Y98.345 E.01253
G1 X91.167 Y98.72 E.00869
G1 X91.326 Y99.3 E.01273
G1 X91.38 Y99.897 E.01268
G1 X91.327 Y100.497 E.01277
G1 X91.171 Y101.07 E.01256
G1 X91.01 Y101.437 E.0085
G1 X90.807 Y101.783 E.00849
G1 X90.558 Y102.11 E.00869
G1 X90.128 Y102.527 E.01268
G1 X89.635 Y102.859 E.01257
G1 X89.273 Y103.032 E.00851
G1 X88.893 Y103.161 E.00849
G1 X88.5 Y103.243 E.0085
G1 X88.1 Y103.279 E.00849
G1 X87.699 Y103.267 E.00849
G1 X87.116 Y103.164 E.01254
G1 X86.727 Y103.032 E.00869
G1 X86.364 Y102.858 E.00851
G1 X85.872 Y102.527 E.01257
G1 X85.571 Y102.251 E.00864
G1 X85.31 Y101.947 E.00849
G1 X85.086 Y101.613 E.00849
G1 X84.905 Y101.258 E.00845
G1 X84.756 Y100.846 E.00926
G1 X84.643 Y100.3 E.01181
G1 X84.62 Y99.89 E.00869
G1 X84.645 Y99.49 E.00849
G1 X84.718 Y99.095 E.00849
G1 X84.837 Y98.711 E.00849
G1 X85.003 Y98.339 E.00864
G1 X85.323 Y97.838 E.01257
G1 X86.503 Y96.482 E.03806
G1 X81.536 Y96.482 E.10513
G1 X81.208 Y96.43 E.00703
G1 X81.06 Y96.361 E.00345
G1 X80.936 Y96.275 E.00318
G1 X80.767 Y96.085 E.00539
G1 X80.647 Y95.803 E.00649
G1 X80.619 Y95.565 E.00508
G1 X80.619 Y77.619 E.37984
G1 X80.659 Y77.349 E.00577
G1 X80.76 Y77.125 E.0052
G1 X80.936 Y76.927 E.00562
G1 X81.06 Y76.841 E.00319
G1 X81.206 Y76.772 E.00341
G1 X81.457 Y76.723 E.00541
G1 X94.521 Y76.722 E.27652
G1 X94.762 Y76.763 E.00517
G1 X94.968 Y76.857 E.00478
G1 X95.145 Y77.006 E.00491
G1 X95.278 Y77.192 E.00484
G1 X95.356 Y77.407 E.00484
G1 X95.378 Y77.559 E.00325
G1 X95.38 Y78.482 E.01952
G1 X95.019 Y78.482 E.00763
G1 X95.019 Y78.056 E.00901
G1 X94.983 Y77.809 E.00529
G1 X94.858 Y77.539 E.0063
G1 X94.65 Y77.305 E.00663
G1 X94.36 Y77.139 E.00707
G1 X94.087 Y77.082 E.0059
G1 X81.947 Y77.082 E.25695
G1 X81.663 Y77.131 E.00609
G1 X81.381 Y77.281 E.00676
G1 X81.151 Y77.524 E.00709
G1 X81.018 Y77.805 E.00659
G1 X80.981 Y78.056 E.00537
G1 X80.981 Y95.155 E.36192
G1 X81.035 Y95.462 E.0066
G1 X81.249 Y95.809 E.00863
G1 X81.591 Y96.049 E.00883
G1 X81.937 Y96.12 E.00747
G1 X86.701 Y96.119 E.10083
; WIPE_START
M204 S6000
G1 X88.701 Y96.119 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X85.604 Y96.891 Z5.52 F18000
G1 Z5.12
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X81.512 Y96.891 E.08049
G1 X81.197 Y96.854 E.00625
G1 X81.062 Y96.814 E.00277
G1 X80.855 Y96.717 E.00449
G1 X80.679 Y96.595 E.00422
G1 X80.564 Y96.487 E.0031
G1 X80.428 Y96.317 E.00427
G1 X80.35 Y96.184 E.00303
G1 X80.246 Y95.898 E.00599
G1 X80.21 Y95.589 E.00613
G1 X80.21 Y77.607 E.35368
G1 X80.219 Y77.454 E.00301
G1 X80.265 Y77.231 E.00448
G1 X80.349 Y77.019 E.00448
G1 X80.421 Y76.895 E.00283
G1 X80.564 Y76.714 E.00453
G1 X80.679 Y76.607 E.00309
G1 X80.855 Y76.485 E.00423
G1 X81.061 Y76.388 E.00447
G1 X81.212 Y76.344 E.00309
G1 X81.428 Y76.313 E.00428
G1 X94.556 Y76.313 E.25822
G1 X94.873 Y76.367 E.00633
G1 X95.081 Y76.45 E.00441
G1 X95.203 Y76.52 E.00277
G1 X95.44 Y76.719 E.00607
G1 X95.572 Y76.884 E.00416
G1 X95.65 Y77.017 E.00303
G1 X95.755 Y77.307 E.00605
G1 X95.787 Y77.529 E.00442
G1 X95.79 Y78.891 E.02678
G1 X94.61 Y78.891 E.0232
G1 X94.61 Y78.086 E.01584
G1 X94.587 Y77.926 E.00316
G1 X94.512 Y77.766 E.00348
G1 X94.389 Y77.627 E.00366
G1 X94.213 Y77.526 E.00399
G1 X94.045 Y77.492 E.00337
G1 X81.982 Y77.491 E.23727
G1 X81.798 Y77.523 E.00368
G1 X81.632 Y77.611 E.00368
G1 X81.492 Y77.758 E.00399
G1 X81.414 Y77.925 E.00363
G1 X81.39 Y78.086 E.0032
G1 X81.39 Y95.119 E.33504
G1 X81.424 Y95.314 E.00389
G1 X81.553 Y95.523 E.00482
G1 X81.757 Y95.665 E.00489
G1 X81.979 Y95.711 E.00446
G1 X94.07 Y95.708 E.23783
G1 X94.243 Y95.663 E.00351
G1 X94.397 Y95.568 E.00356
G1 X94.527 Y95.414 E.00396
G1 X94.599 Y95.234 E.00381
G1 X94.608 Y94.311 E.01816
G1 X95.79 Y94.311 E.02325
G1 X95.79 Y95.589 E.02513
G1 X95.753 Y95.901 E.00619
G1 X95.685 Y96.109 E.0043
G1 X95.532 Y96.373 E.00601
G1 X95.387 Y96.536 E.0043
G1 X95.144 Y96.717 E.00595
G1 X94.87 Y96.835 E.00588
G1 X94.569 Y96.888 E.00601
G1 X90.396 Y96.891 E.08208
G1 X91.004 Y97.59 E.01822
G1 X91.132 Y97.767 E.0043
G1 X91.364 Y98.156 E.00891
G1 X91.548 Y98.57 E.00891
G1 X91.619 Y98.777 E.00431
G1 X91.728 Y99.22 E.00897
G1 X91.761 Y99.437 E.00431
G1 X91.79 Y99.891 E.00895
G1 X91.781 Y100.147 E.00503
G1 X91.731 Y100.563 E.00826
G1 X91.687 Y100.778 E.00431
G1 X91.556 Y101.212 E.00891
G1 X91.375 Y101.624 E.00885
M73 P90 R2
G1 X91.147 Y102.012 E.00885
G1 X90.873 Y102.372 E.00891
G1 X90.726 Y102.534 E.0043
G1 X90.39 Y102.842 E.00895
G1 X90.186 Y102.996 E.00503
G1 X89.833 Y103.218 E.0082
G1 X89.427 Y103.412 E.00885
G1 X89.001 Y103.556 E.00885
G1 X88.56 Y103.649 E.00885
G1 X88.113 Y103.689 E.00884
G1 X87.663 Y103.676 E.00885
G1 X87.215 Y103.608 E.00891
G1 X87.002 Y103.557 E.0043
G1 X86.573 Y103.412 E.00891
G1 X86.167 Y103.218 E.00885
G1 X85.814 Y102.996 E.0082
G1 X85.61 Y102.842 E.00503
G1 X85.277 Y102.536 E.0089
G1 X84.984 Y102.195 E.00885
G1 X84.733 Y101.821 E.00885
G1 X84.529 Y101.421 E.00884
G1 X84.363 Y100.963 E.00957
G1 X84.268 Y100.558 E.0082
G1 X84.236 Y100.341 E.00431
G1 X84.21 Y99.889 E.00891
G1 X84.239 Y99.44 E.00885
G1 X84.32 Y98.997 E.00885
G1 X84.453 Y98.567 E.00885
G1 X84.637 Y98.154 E.00889
G1 X84.763 Y97.932 E.00503
G1 X84.998 Y97.588 E.0082
G1 X85.565 Y96.936 E.01699
; WIPE_START
M204 S6000
G1 X83.565 Y96.914 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G17
G3 Z5.52 I1.217 J0 P1  F18000
;===================== date: 20250206 =====================

; don't support timelapse gcode in spiral_mode and by object sequence for I3 structure printer
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
G92 E0
G1 Z5.52
G1 X0 Y90 ; move to safe pos
G1 X-13.0 F3000 ; move to safe pos
M400
M1004 S5 P1  ; external shutter
M400 P300
M971 S11 C11 O0
G92 E0
G1 X0 F18000
M623

; SKIPTYPE: head_wrap_detect
M622.1 S1
M1002 judge_flag g39_3rd_layer_detect_flag
M622 J1
    ; enable nozzle clog detect at 3rd layer
    


    M622.1 S1
    M1002 judge_flag g39_detection_flag
    M622 J1
      
        M622.1 S0
        M1002 judge_flag g39_mass_exceed_flag
        M622 J1
        
            G392 S0
            M400
            G90
            M83
            M204 S5000
            G0 Z5.52 F4000
            G39.3 S1
            G0 Z5.52 F4000
            G392 S0
          
        M623
    
    M623
M623
; SKIPPABLE_END




G1 X81.442 Y96.257
G1 Z5.12
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.148416
G1 F1500
M204 S6000
G1 X81.202 Y96.118 E.0017
G1 X81.056 Y96.008 E.00112
G1 X80.973 Y95.888 E.0009
G1 X80.847 Y95.629 E.00176
; WIPE_START
G1 X80.973 Y95.888 E-.12233
G1 X81.056 Y96.008 E-.06225
G1 X81.202 Y96.118 E-.0775
G1 X81.442 Y96.257 E-.11792
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X86.547 Y97.165 Z5.52 F18000
G1 Z5.12
G1 E.4 F1800
; LINE_WIDTH: 0.477126
G1 F1500
M204 S6000
G1 X86.367 Y97.319 E.00533
; LINE_WIDTH: 0.438433
G1 X86.16 Y97.496 E.00561
; LINE_WIDTH: 0.40064
G1 X85.986 Y97.673 E.00464
; LINE_WIDTH: 0.359996
G1 X85.629 Y98.071 E.00892
G1 X85.341 Y98.515 E.00881
G1 X85.194 Y98.846 E.00604
G1 X85.092 Y99.187 E.00593
G1 X85.024 Y99.536 E.00594
G1 X85.004 Y100.005 E.00783
G1 X85.073 Y100.538 E.00896
G1 X85.225 Y101.035 E.00868
G1 X85.386 Y101.37 E.00619
G1 X85.613 Y101.716 E.0069
G1 X85.939 Y102.078 E.00812
G1 X86.362 Y102.408 E.00895
G1 X86.797 Y102.647 E.00827
G1 X87.167 Y102.781 E.00657
G1 X87.513 Y102.855 E.0059
G1 X88.027 Y102.9 E.00859
G1 X88.553 Y102.847 E.00882
G1 X88.916 Y102.755 E.00625
G1 X89.263 Y102.619 E.00623
G1 X89.709 Y102.36 E.00859
G1 X89.886 Y102.228 E.00368
G1 X90.163 Y101.98 E.0062
G1 X90.493 Y101.57 E.00878
G1 X90.746 Y101.102 E.00888
G1 X90.867 Y100.774 E.00583
G1 X90.952 Y100.409 E.00625
G1 X91.001 Y99.902 E.00849
G1 X90.95 Y99.38 E.00874
G1 X90.859 Y99.004 E.00647
G1 X90.663 Y98.52 E.0087
G1 X90.379 Y98.079 E.00874
G1 X90.127 Y97.784 E.00647
; LINE_WIDTH: 0.378818
G1 X89.95 Y97.609 E.00438
; LINE_WIDTH: 0.419328
G1 X89.748 Y97.411 E.00557
; LINE_WIDTH: 0.468128
G1 X89.449 Y97.162 E.00857
; WIPE_START
G1 X89.748 Y97.411 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X94.529 Y96.242 Z5.52 F18000
G1 Z5.12
G1 E.4 F1800
; LINE_WIDTH: 0.10414
G1 F1500
M204 S6000
G1 X94.675 Y96.186 E.00061
; LINE_WIDTH: 0.15203
G1 X94.8 Y96.121 E.00089
G1 X94.917 Y96.024 E.00096
G1 X95.142 Y95.717 E.0024
M204 S10000
G1 X95.137 Y95.625 F18000
; LINE_WIDTH: 0.0956961
G1 F1500
M204 S6000
G1 X94.979 Y96.06 E.00161
; WIPE_START
G1 X95.137 Y95.625 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X95.141 Y87.993 Z5.52 F18000
G1 X95.147 Y77.602 Z5.52
G1 Z5.12
G1 E.4 F1800
; LINE_WIDTH: 0.10252
G1 F1500
M204 S6000
G1 X95.072 Y77.39 E.00086
; LINE_WIDTH: 0.140769
G1 X94.998 Y77.272 E.0008
; LINE_WIDTH: 0.153614
G1 X94.815 Y77.085 E.00167
G1 X94.689 Y77.021 E.00091
; LINE_WIDTH: 0.120213
G1 X94.603 Y76.99 E.00043
; LINE_WIDTH: 0.0932358
G1 X94.518 Y76.96 E.00031
; WIPE_START
G1 X94.603 Y76.99 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X86.971 Y76.969 Z5.52 F18000
G1 X81.496 Y76.954 Z5.52
G1 Z5.12
G1 E.4 F1800
; LINE_WIDTH: 0.100501
G1 F1500
M204 S6000
G1 X81.356 Y77 E.00055
; LINE_WIDTH: 0.146153
G1 X81.21 Y77.07 E.00098
G1 X81.119 Y77.145 E.00071
G1 X80.964 Y77.322 E.00142
G1 X80.91 Y77.423 E.00069
; LINE_WIDTH: 0.100042
G1 X80.854 Y77.602 E.0007
; WIPE_START
G1 X80.91 Y77.423 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X88.289 Y79.371 Z5.52 F18000
G1 X96.823 Y81.624 Z5.52
G1 Z5.12
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X97.177 Y81.624 E.00747
G1 X97.177 Y81.977 E.00747
G1 X96.823 Y81.977 E.00747
G1 X96.823 Y81.684 E.0062
M204 S10000
G1 X96.399 Y81.2 F18000
G1 F1500
M204 S500
G1 X97.601 Y81.2 E.02543
G1 X97.601 Y82.402 E.02543
G1 X96.399 Y82.402 E.02543
G1 X96.399 Y81.26 E.02416
M204 S250
G1 X95.99 Y80.791 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X98.01 Y80.791 E.03973
G1 X98.01 Y82.811 E.03973
G1 X95.99 Y82.811 E.03973
G1 X95.99 Y80.851 E.03855
; CHANGE_LAYER
; Z_HEIGHT: 5.24
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F1500
M204 S6000
G1 X97.989 Y80.792 E-.38
; WIPE_END
G1 E-.02 F1800
; layer num/total_layer_count: 43/49
; update layer progress
M73 L43
M991 S0 P42 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z5.52 I-1.07 J-.58 P1  F18000
G1 X89.161 Y97.078 Z5.52
G1 Z5.24
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X88.604 Y96.915 E.01228
G1 X88.229 Y96.864 E.00802
G1 X87.868 Y96.858 E.00764
G1 X87.324 Y96.929 E.0116
G1 X86.766 Y97.11 E.01243
G1 X86.659 Y96.949 E.0041
G1 X87.012 Y96.543 E.01138
G1 X88.921 Y96.543 E.04041
G1 X89.263 Y96.913 E.01067
G1 X89.193 Y97.027 E.00283
; WIPE_START
M204 S6000
G1 X88.604 Y96.915 E-.11378
G1 X88.229 Y96.864 E-.07201
G1 X87.868 Y96.858 E-.06857
G1 X87.324 Y96.929 E-.10413
G1 X87.217 Y96.964 E-.02152
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X90.617 Y99.85 Z5.64 F18000
G1 Z5.24
G1 E.4 F1800
G1 F1500
M204 S500
G1 X90.622 Y99.901 E.00109
G1 X90.58 Y100.369 E.00995
G1 X90.457 Y100.813 E.00975
G1 X90.326 Y101.108 E.00683
G1 X90.16 Y101.385 E.00683
G1 X89.868 Y101.741 E.00975
G1 X89.508 Y102.046 E.00998
G1 X89.093 Y102.282 E.01011
G1 X88.809 Y102.393 E.00645
G1 X88.497 Y102.474 E.00682
G1 X88.048 Y102.521 E.00955
G1 X87.726 Y102.507 E.00683
G1 X87.408 Y102.454 E.00683
G1 X86.969 Y102.312 E.00975
G1 X86.556 Y102.089 E.00994
G1 X86.188 Y101.796 E.00995
G1 X85.879 Y101.442 E.00995
G1 X85.638 Y101.039 E.00995
G1 X85.476 Y100.607 E.00975
G1 X85.409 Y100.291 E.00683
G1 X85.38 Y99.97 E.00683
G1 X85.408 Y99.51 E.00975
G1 X85.519 Y99.054 E.00995
G1 X85.706 Y98.633 E.00975
G1 X85.88 Y98.361 E.00683
G1 X86.085 Y98.112 E.00683
G1 X86.421 Y97.809 E.00956
G1 X86.69 Y97.632 E.00683
G1 X86.978 Y97.487 E.00683
G1 X87.418 Y97.344 E.00979
G1 X87.892 Y97.283 E.01011
G1 X88.197 Y97.288 E.00645
G1 X88.516 Y97.331 E.00682
G1 X88.949 Y97.458 E.00955
G1 X89.242 Y97.593 E.00683
G1 X89.516 Y97.763 E.00683
G1 X89.868 Y98.061 E.00976
G1 X90.16 Y98.417 E.00975
G1 X90.326 Y98.694 E.00683
G1 X90.457 Y98.989 E.00683
G1 X90.58 Y99.433 E.00975
G1 X90.612 Y99.79 E.00759
M204 S250
G1 X90.21 Y99.886 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X90.211 Y99.901 E.00029
G1 X90.175 Y100.296 E.00779
G1 X90.071 Y100.675 E.00774
G1 X89.962 Y100.919 E.00526
G1 X89.825 Y101.149 E.00526
G1 X89.575 Y101.452 E.00773
G1 X89.272 Y101.709 E.00781
G1 X88.916 Y101.912 E.00806
G1 X88.683 Y102.003 E.00493
G1 X88.424 Y102.07 E.00526
G1 X88.036 Y102.111 E.00767
G1 X87.769 Y102.099 E.00526
G1 X87.505 Y102.055 E.00526
G1 X87.131 Y101.934 E.00773
G1 X86.782 Y101.746 E.00779
G1 X86.472 Y101.499 E.00779
G1 X86.211 Y101.2 E.0078
G1 X86.008 Y100.86 E.00779
G1 X85.87 Y100.492 E.00774
G1 X85.814 Y100.23 E.00526
G1 X85.79 Y99.964 E.00526
G1 X85.814 Y99.571 E.00773
G1 X85.908 Y99.186 E.00779
G1 X86.068 Y98.827 E.00773
G1 X86.212 Y98.602 E.00526
G1 X86.382 Y98.395 E.00526
G1 X86.672 Y98.134 E.00767
G1 X86.895 Y97.987 E.00526
G1 X87.134 Y97.867 E.00526
G1 X87.509 Y97.745 E.00775
G1 X87.915 Y97.692 E.00806
G1 X88.165 Y97.697 E.00493
G1 X88.43 Y97.733 E.00526
G1 X88.805 Y97.842 E.00767
G1 X89.047 Y97.954 E.00526
G1 X89.275 Y98.095 E.00526
G1 X89.575 Y98.349 E.00774
G1 X89.825 Y98.653 E.00773
G1 X89.962 Y98.883 E.00526
G1 X90.071 Y99.127 E.00526
G1 X90.175 Y99.506 E.00774
G1 X90.204 Y99.826 E.00632
; WIPE_START
M204 S6000
G1 X90.211 Y99.901 E-.0142
G1 X90.175 Y100.296 E-.07529
G1 X90.071 Y100.675 E-.07474
G1 X89.962 Y100.919 E-.05082
G1 X89.825 Y101.149 E-.05082
G1 X89.575 Y101.452 E-.07472
G1 X89.417 Y101.587 E-.03941
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X86.761 Y96.119 Z5.64 F18000
G1 Z5.24
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X94.124 Y96.118 E.15584
G1 X94.406 Y96.043 E.00618
G1 X94.667 Y95.882 E.00651
G1 X94.883 Y95.626 E.00706
G1 X95.007 Y95.315 E.00709
G1 X95.013 Y94.72 E.0126
G1 X95.381 Y94.72 E.00778
G1 X95.381 Y95.565 E.01788
G1 X95.353 Y95.803 E.00508
G1 X95.28 Y96.003 E.0045
G1 X95.205 Y96.125 E.00305
G1 X95.109 Y96.233 E.00305
G1 X94.938 Y96.36 E.0045
G1 X94.751 Y96.441 E.00431
G1 X94.533 Y96.479 E.0047
G1 X89.443 Y96.483 E.10774
G1 X90.544 Y97.675 E.03436
G1 X90.795 Y98 E.00868
G1 X91.004 Y98.351 E.00865
G1 X91.095 Y98.545 E.00453
G1 X91.228 Y98.901 E.00805
G1 X91.326 Y99.3 E.0087
G1 X91.38 Y99.89 E.01254
G1 X91.357 Y100.298 E.00864
G1 X91.235 Y100.879 E.01257
G1 X91.094 Y101.263 E.00866
G1 X91.001 Y101.455 E.00453
G1 X90.807 Y101.783 E.00805
G1 X90.558 Y102.11 E.0087
G1 X90.135 Y102.521 E.0125
G1 X89.782 Y102.772 E.00917
G1 X89.281 Y103.029 E.0119
G1 X88.893 Y103.161 E.00869
G1 X88.5 Y103.243 E.0085
G1 X88.1 Y103.279 E.00849
G1 X87.699 Y103.267 E.00849
G1 X87.116 Y103.164 E.01254
G1 X86.727 Y103.032 E.00869
G1 X86.367 Y102.86 E.00845
G1 X86.002 Y102.626 E.00917
G1 X85.577 Y102.258 E.0119
G1 X85.31 Y101.947 E.00869
G1 X85.086 Y101.613 E.0085
G1 X84.905 Y101.258 E.00845
G1 X84.757 Y100.85 E.00916
G1 X84.643 Y100.3 E.0119
G1 X84.62 Y99.89 E.00869
G1 X84.645 Y99.49 E.00849
G1 X84.718 Y99.095 E.0085
G1 X84.836 Y98.713 E.00845
G1 X85.014 Y98.319 E.00917
G1 X85.317 Y97.845 E.0119
G1 X86.503 Y96.482 E.03824
G1 X81.536 Y96.482 E.10513
G1 X81.208 Y96.43 E.00703
G1 X80.981 Y96.311 E.00541
G1 X80.875 Y96.217 E.00302
G1 X80.734 Y96.03 E.00494
G1 X80.649 Y95.819 E.00481
G1 X80.619 Y95.565 E.00543
G1 X80.619 Y77.628 E.37964
G1 X80.655 Y77.357 E.00578
G1 X80.761 Y77.125 E.00539
G1 X80.935 Y76.927 E.00559
G1 X81.06 Y76.841 E.00321
G1 X81.208 Y76.772 E.00346
G1 X81.458 Y76.723 E.00539
G1 X94.523 Y76.722 E.27653
G1 X94.762 Y76.763 E.00514
G1 X94.983 Y76.866 E.00517
G1 X95.16 Y77.023 E.005
G1 X95.284 Y77.209 E.00473
G1 X95.356 Y77.407 E.00447
G1 X95.378 Y77.559 E.00325
G1 X95.38 Y78.482 E.01952
G1 X95.019 Y78.482 E.00763
G1 X95.019 Y78.056 E.00901
G1 X94.983 Y77.808 E.0053
G1 X94.858 Y77.538 E.0063
G1 X94.651 Y77.306 E.00659
G1 X94.36 Y77.139 E.0071
G1 X94.087 Y77.082 E.0059
G1 X81.947 Y77.082 E.25695
G1 X81.663 Y77.131 E.00611
G1 X81.38 Y77.281 E.00677
G1 X81.147 Y77.528 E.00719
G1 X81.017 Y77.806 E.0065
G1 X80.981 Y78.056 E.00533
G1 X80.981 Y95.156 E.36195
G1 X81.037 Y95.467 E.00668
G1 X81.25 Y95.81 E.00854
G1 X81.591 Y96.049 E.00882
G1 X81.937 Y96.12 E.00747
G1 X86.701 Y96.119 E.10084
; WIPE_START
M204 S6000
G1 X88.701 Y96.119 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X85.605 Y96.891 Z5.64 F18000
G1 Z5.24
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X81.512 Y96.891 E.08049
G1 X81.197 Y96.854 E.00625
G1 X81.062 Y96.814 E.00277
G1 X80.853 Y96.716 E.00454
G1 X80.732 Y96.637 E.00283
G1 X80.572 Y96.496 E.0042
G1 X80.382 Y96.242 E.00624
G1 X80.291 Y96.049 E.00419
G1 X80.247 Y95.904 E.00299
G1 X80.21 Y95.589 E.00624
G1 X80.21 Y77.61 E.35362
G1 X80.231 Y77.374 E.00466
G1 X80.264 Y77.234 E.00283
G1 X80.349 Y77.02 E.00454
G1 X80.421 Y76.895 E.00283
G1 X80.564 Y76.714 E.00453
G1 X80.677 Y76.608 E.00306
G1 X80.855 Y76.485 E.00426
G1 X81.062 Y76.388 E.00449
G1 X81.2 Y76.347 E.00283
G1 X81.428 Y76.313 E.00454
G1 X94.557 Y76.313 E.25824
G1 X94.873 Y76.367 E.0063
G1 X95.081 Y76.45 E.00441
G1 X95.209 Y76.523 E.00289
G1 X95.327 Y76.611 E.00289
G1 X95.478 Y76.762 E.0042
G1 X95.652 Y77.023 E.00617
M73 P91 R2
G1 X95.755 Y77.307 E.00593
G1 X95.787 Y77.529 E.00442
G1 X95.79 Y78.891 E.02678
G1 X94.61 Y78.891 E.0232
G1 X94.61 Y78.086 E.01584
G1 X94.587 Y77.926 E.00317
G1 X94.512 Y77.765 E.00348
G1 X94.389 Y77.628 E.00363
G1 X94.213 Y77.526 E.00401
G1 X94.045 Y77.492 E.00337
G1 X81.982 Y77.491 E.23727
G1 X81.797 Y77.523 E.00369
G1 X81.632 Y77.611 E.00368
G1 X81.49 Y77.761 E.00407
G1 X81.414 Y77.925 E.00356
G1 X81.39 Y78.086 E.00319
G1 X81.39 Y95.12 E.33505
G1 X81.426 Y95.317 E.00395
G1 X81.553 Y95.523 E.00475
G1 X81.757 Y95.665 E.00488
G1 X81.979 Y95.711 E.00446
G1 X94.071 Y95.708 E.23784
G1 X94.243 Y95.663 E.0035
G1 X94.397 Y95.568 E.00356
G1 X94.527 Y95.413 E.00399
G1 X94.599 Y95.234 E.00378
G1 X94.608 Y94.311 E.01817
G1 X95.79 Y94.311 E.02325
G1 X95.79 Y95.589 E.02513
G1 X95.754 Y95.898 E.00613
G1 X95.65 Y96.182 E.00594
G1 X95.534 Y96.371 E.00436
G1 X95.387 Y96.536 E.00436
G1 X95.144 Y96.717 E.00594
G1 X94.869 Y96.835 E.00589
G1 X94.569 Y96.888 E.00601
G1 X90.377 Y96.891 E.08245
G1 X90.857 Y97.411 E.01392
G1 X91.134 Y97.77 E.00891
G1 X91.365 Y98.158 E.0089
G1 X91.473 Y98.385 E.00493
G1 X91.62 Y98.78 E.00829
G1 X91.728 Y99.22 E.00891
G1 X91.761 Y99.437 E.00431
G1 X91.79 Y99.889 E.00891
G1 X91.764 Y100.34 E.0089
G1 X91.726 Y100.588 E.00494
G1 X91.627 Y100.998 E.00829
G1 X91.471 Y101.423 E.0089
G1 X91.362 Y101.649 E.00494
G1 X91.148 Y102.011 E.00829
G1 X90.873 Y102.372 E.00892
G1 X90.726 Y102.534 E.0043
G1 X90.392 Y102.84 E.0089
G1 X89.999 Y103.119 E.00948
G1 X89.63 Y103.322 E.00828
G1 X89.43 Y103.411 E.00431
G1 X89.001 Y103.556 E.00891
G1 X88.561 Y103.649 E.00885
G1 X88.113 Y103.689 E.00885
G1 X87.663 Y103.676 E.00885
G1 X87.215 Y103.608 E.00891
G1 X87.002 Y103.557 E.00431
G1 X86.573 Y103.412 E.00891
G1 X86.168 Y103.218 E.00884
G1 X85.762 Y102.958 E.00948
G1 X85.436 Y102.691 E.00828
G1 X85.279 Y102.538 E.00431
G1 X84.984 Y102.195 E.00891
G1 X84.733 Y101.821 E.00885
G1 X84.529 Y101.421 E.00884
G1 X84.364 Y100.968 E.00948
G1 X84.268 Y100.558 E.00829
G1 X84.236 Y100.341 E.00431
G1 X84.21 Y99.889 E.00891
G1 X84.239 Y99.44 E.00885
G1 X84.32 Y98.997 E.00885
G1 X84.453 Y98.568 E.00884
G1 X84.651 Y98.129 E.00948
G1 X84.868 Y97.767 E.00828
G1 X84.996 Y97.59 E.00431
G1 X85.565 Y96.936 E.01704
; WIPE_START
M204 S6000
G1 X83.565 Y96.914 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G17
G3 Z5.64 I1.217 J0 P1  F18000
;===================== date: 20250206 =====================

; don't support timelapse gcode in spiral_mode and by object sequence for I3 structure printer
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
G92 E0
G1 Z5.64
G1 X0 Y90 ; move to safe pos
G1 X-13.0 F3000 ; move to safe pos
M400
M1004 S5 P1  ; external shutter
M400 P300
M971 S11 C11 O0
G92 E0
G1 X0 F18000
M623

; SKIPTYPE: head_wrap_detect
M622.1 S1
M1002 judge_flag g39_3rd_layer_detect_flag
M622 J1
    ; enable nozzle clog detect at 3rd layer
    


    M622.1 S1
    M1002 judge_flag g39_detection_flag
    M622 J1
      
        M622.1 S0
        M1002 judge_flag g39_mass_exceed_flag
        M622 J1
        
            G392 S0
            M400
            G90
            M83
            M204 S5000
            G0 Z5.64 F4000
            G39.3 S1
            G0 Z5.64 F4000
            G392 S0
          
        M623
    
    M623
M623
; SKIPPABLE_END




G1 X81.442 Y96.257
G1 Z5.24
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.15246
G1 F1500
M204 S6000
G1 X81.078 Y96.027 E.00272
G1 X80.929 Y95.808 E.00167
; LINE_WIDTH: 0.127341
G1 X80.895 Y95.717 E.00049
; LINE_WIDTH: 0.0947428
G1 X80.861 Y95.626 E.00033
; WIPE_START
G1 X80.895 Y95.717 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X86.548 Y97.165 Z5.64 F18000
G1 Z5.24
G1 E.4 F1800
; LINE_WIDTH: 0.477093
G1 F1500
M204 S6000
G1 X86.367 Y97.319 E.00533
; LINE_WIDTH: 0.438387
G1 X86.16 Y97.496 E.00562
; LINE_WIDTH: 0.400973
G1 X85.99 Y97.669 E.00453
; LINE_WIDTH: 0.360266
G1 X85.619 Y98.078 E.00922
G1 X85.381 Y98.443 E.00728
G1 X85.193 Y98.849 E.00746
G1 X85.091 Y99.186 E.00588
G1 X85.024 Y99.536 E.00594
G1 X85.003 Y99.891 E.00594
G1 X85.023 Y100.257 E.00611
G1 X85.117 Y100.725 E.00797
G1 X85.255 Y101.105 E.00675
G1 X85.418 Y101.418 E.00589
G1 X85.613 Y101.716 E.00594
G1 X85.918 Y102.057 E.00764
G1 X86.361 Y102.41 E.00945
G1 X86.835 Y102.665 E.00897
G1 X87.306 Y102.817 E.00827
G1 X87.696 Y102.884 E.0066
G1 X88.047 Y102.9 E.00586
G1 X88.553 Y102.847 E.00848
G1 X88.915 Y102.753 E.00626
G1 X89.285 Y102.611 E.0066
G1 X89.711 Y102.362 E.00823
G1 X90.163 Y101.98 E.00987
G1 X90.491 Y101.571 E.00876
G1 X90.743 Y101.109 E.00878
G1 X90.868 Y100.767 E.00607
G1 X90.953 Y100.436 E.00571
G1 X90.975 Y100.258 E.003
G1 X91.001 Y99.893 E.0061
G1 X90.954 Y99.369 E.00879
G1 X90.816 Y98.873 E.00859
G1 X90.667 Y98.528 E.00627
G1 X90.477 Y98.209 E.0062
G1 X90.128 Y97.784 E.00918
; LINE_WIDTH: 0.375805
G1 X89.948 Y97.612 E.00434
; LINE_WIDTH: 0.408501
G1 X89.742 Y97.416 E.00543
; LINE_WIDTH: 0.445822
G1 X89.561 Y97.272 E.00485
; LINE_WIDTH: 0.479752
G1 X89.38 Y97.127 E.00525
; WIPE_START
G1 X89.561 Y97.272 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X94.529 Y96.242 Z5.64 F18000
G1 Z5.24
G1 E.4 F1800
; LINE_WIDTH: 0.104123
G1 F1500
M204 S6000
G1 X94.675 Y96.186 E.00061
; LINE_WIDTH: 0.151272
G1 X94.854 Y96.083 E.00129
G1 X95.031 Y95.879 E.00169
; LINE_WIDTH: 0.131062
G1 X95.098 Y95.764 E.0007
; LINE_WIDTH: 0.0943166
G1 X95.136 Y95.626 E.00049
; WIPE_START
G1 X95.098 Y95.764 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X95.118 Y88.131 Z5.64 F18000
G1 X95.147 Y77.602 Z5.64
G1 Z5.24
G1 E.4 F1800
; LINE_WIDTH: 0.103449
G1 F1500
M204 S6000
G1 X95.073 Y77.389 E.00088
; LINE_WIDTH: 0.150351
G1 X94.941 Y77.205 E.0014
G1 X94.832 Y77.096 E.00096
G1 X94.688 Y77.021 E.00101
; LINE_WIDTH: 0.120163
G1 X94.603 Y76.99 E.00043
; LINE_WIDTH: 0.0932175
G1 X94.518 Y76.959 E.0003
; WIPE_START
G1 X94.603 Y76.99 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X86.97 Y76.969 Z5.64 F18000
G1 X81.496 Y76.954 Z5.64
G1 Z5.24
G1 E.4 F1800
; LINE_WIDTH: 0.101815
G1 F1500
M204 S6000
G1 X81.348 Y77.003 E.00059
; LINE_WIDTH: 0.146423
G1 X81.208 Y77.071 E.00094
G1 X81.118 Y77.146 E.0007
G1 X80.964 Y77.323 E.00141
G1 X80.905 Y77.433 E.00076
; LINE_WIDTH: 0.0999181
G1 X80.857 Y77.595 E.00062
; WIPE_START
G1 X80.905 Y77.433 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X88.346 Y79.129 Z5.64 F18000
G1 X96.093 Y80.894 Z5.64
G1 Z5.24
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X97.907 Y80.894 E.03569
G1 X97.907 Y82.708 E.03569
G1 X96.093 Y82.708 E.03569
G1 X96.093 Y80.954 E.03451
; WIPE_START
M204 S6000
G1 X97.907 Y80.894 E-.3449
G1 X97.907 Y81.078 E-.0351
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X97.69 Y81.801 Z5.64 F18000
G1 Z5.24
G1 E.4 F1800
; FEATURE: Top surface
G1 F1500
M204 S2000
G1 X97 Y81.111 E.01919
G1 X96.443 Y81.111
G1 X97.69 Y82.358 E.0347
G1 X97.266 Y82.491
G1 X96.31 Y81.535 E.0266
G1 X96.31 Y82.093
G1 X96.708 Y82.491 E.01109
; CHANGE_LAYER
; Z_HEIGHT: 5.36
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F1500
M204 S6000
G1 X96.31 Y82.093 E-.10713
G1 X96.31 Y81.535 E-.10593
G1 X96.931 Y82.156 E-.16695
; WIPE_END
G1 E-.02 F1800
; layer num/total_layer_count: 44/49
; update layer progress
M73 L44
M991 S0 P43 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z5.64 I-1.08 J-.561 P1  F18000
G1 X89.175 Y97.082 Z5.64
G1 Z5.36
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
M73 P91 R1
G1 X88.604 Y96.915 E.0126
G1 X88.228 Y96.864 E.00802
G1 X87.865 Y96.858 E.0077
G1 X87.324 Y96.929 E.01155
G1 X86.766 Y97.11 E.01242
G1 X86.659 Y96.949 E.0041
G1 X87.012 Y96.543 E.01138
G1 X88.935 Y96.543 E.04071
G1 X89.278 Y96.918 E.01075
G1 X89.207 Y97.031 E.00281
; WIPE_START
M204 S6000
G1 X88.604 Y96.915 E-.1167
G1 X88.228 Y96.864 E-.07202
G1 X87.865 Y96.858 E-.06909
G1 X87.324 Y96.929 E-.10366
G1 X87.231 Y96.959 E-.01853
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X90.617 Y99.849 Z5.76 F18000
G1 Z5.36
G1 E.4 F1800
G1 F1500
M204 S500
G1 X90.622 Y99.901 E.00109
G1 X90.58 Y100.36 E.00975
G1 X90.504 Y100.673 E.00682
G1 X90.397 Y100.961 E.00651
G1 X90.167 Y101.377 E.01006
G1 X89.868 Y101.741 E.00997
G1 X89.508 Y102.046 E.00998
G1 X89.095 Y102.281 E.01005
G1 X88.809 Y102.393 E.0065
G1 X88.497 Y102.474 E.00682
G1 X88.039 Y102.522 E.00975
G1 X87.57 Y102.487 E.00995
G1 X87.116 Y102.369 E.00994
G1 X86.698 Y102.175 E.00976
G1 X86.428 Y101.997 E.00683
G1 X86.182 Y101.789 E.00683
G1 X85.879 Y101.442 E.00975
G1 X85.643 Y101.046 E.00975
G1 X85.52 Y100.748 E.00683
G1 X85.434 Y100.437 E.00683
G1 X85.379 Y99.979 E.00975
G1 X85.408 Y99.51 E.00995
G1 X85.519 Y99.054 E.00995
G1 X85.706 Y98.633 E.00975
G1 X85.88 Y98.361 E.00683
G1 X86.079 Y98.119 E.00663
G1 X86.305 Y97.902 E.00662
G1 X86.551 Y97.718 E.00651
G1 X86.968 Y97.491 E.01005
G1 X87.418 Y97.344 E.01001
G1 X87.889 Y97.283 E.01006
G1 X88.196 Y97.288 E.00651
G1 X88.516 Y97.331 E.00682
G1 X88.959 Y97.461 E.00978
G1 X89.383 Y97.675 E.01006
G1 X89.634 Y97.853 E.00651
G1 X89.874 Y98.068 E.00681
G1 X90.16 Y98.417 E.00955
G1 X90.325 Y98.693 E.00682
G1 X90.451 Y98.974 E.00651
G1 X90.579 Y99.431 E.01006
G1 X90.612 Y99.79 E.00761
M204 S250
G1 X90.21 Y99.886 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X90.211 Y99.901 E.00029
G1 X90.176 Y100.292 E.00773
G1 X90.112 Y100.552 E.00526
G1 X90.024 Y100.789 E.00498
G1 X89.827 Y101.146 E.00801
G1 X89.575 Y101.452 E.0078
G1 X89.272 Y101.709 E.00781
G1 X88.919 Y101.911 E.00801
G1 X88.683 Y102.003 E.00498
G1 X88.424 Y102.07 E.00526
G1 X88.033 Y102.111 E.00774
G1 X87.638 Y102.082 E.0078
G1 X87.254 Y101.982 E.00779
G1 X86.897 Y101.817 E.00774
G1 X86.674 Y101.669 E.00526
G1 X86.47 Y101.497 E.00526
G1 X86.211 Y101.2 E.00774
G1 X86.01 Y100.863 E.00773
G1 X85.908 Y100.615 E.00526
G1 X85.837 Y100.357 E.00526
G1 X85.79 Y99.967 E.00773
G1 X85.814 Y99.571 E.0078
G1 X85.908 Y99.186 E.00779
G1 X86.068 Y98.827 E.00773
G1 X86.212 Y98.602 E.00526
G1 X86.38 Y98.398 E.0052
G1 X86.571 Y98.215 E.0052
G1 X86.773 Y98.063 E.00498
G1 X87.131 Y97.868 E.00801
G1 X87.508 Y97.745 E.00781
G1 X87.912 Y97.692 E.00801
G1 X88.165 Y97.697 E.00498
G1 X88.43 Y97.733 E.00526
G1 X88.808 Y97.843 E.00774
G1 X89.172 Y98.027 E.00801
G1 X89.378 Y98.173 E.00498
G1 X89.577 Y98.352 E.00526
G1 X89.825 Y98.653 E.00767
G1 X89.962 Y98.883 E.00526
G1 X90.065 Y99.114 E.00498
G1 X90.175 Y99.506 E.00801
G1 X90.204 Y99.826 E.00633
; WIPE_START
M204 S6000
G1 X90.211 Y99.901 E-.01422
G1 X90.176 Y100.292 E-.07469
G1 X90.112 Y100.552 E-.05081
G1 X90.024 Y100.789 E-.04809
G1 X89.827 Y101.146 E-.07738
G1 X89.575 Y101.452 E-.07538
G1 X89.417 Y101.587 E-.03943
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X86.761 Y96.119 Z5.76 F18000
G1 Z5.36
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X94.124 Y96.118 E.15585
G1 X94.406 Y96.043 E.00617
G1 X94.667 Y95.882 E.0065
G1 X94.882 Y95.627 E.00706
G1 X95.007 Y95.315 E.0071
G1 X95.013 Y94.72 E.0126
G1 X95.381 Y94.72 E.00778
G1 X95.381 Y95.565 E.01788
G1 X95.353 Y95.803 E.00508
G1 X95.28 Y96.003 E.0045
G1 X95.209 Y96.118 E.00287
G1 X95.063 Y96.274 E.00451
G1 X94.945 Y96.357 E.00305
G1 X94.751 Y96.441 E.00447
G1 X94.533 Y96.479 E.0047
G1 X89.454 Y96.483 E.10749
G1 X90.56 Y97.695 E.03473
G1 X90.794 Y98 E.00814
G1 X91 Y98.345 E.00851
G1 X91.167 Y98.72 E.00868
G1 X91.326 Y99.3 E.01273
G1 X91.38 Y99.897 E.01269
G1 X91.328 Y100.489 E.01256
G1 X91.233 Y100.887 E.00866
G1 X91.165 Y101.085 E.00443
G1 X91.011 Y101.437 E.00814
G1 X90.807 Y101.783 E.00851
G1 X90.559 Y102.11 E.00869
G1 X90.437 Y102.244 E.00383
G1 X90.113 Y102.538 E.00926
G1 X89.643 Y102.855 E.01199
G1 X89.273 Y103.032 E.00869
G1 X88.884 Y103.164 E.00869
G1 X88.301 Y103.267 E.01254
G1 X87.9 Y103.279 E.00849
G1 X87.5 Y103.243 E.00849
G1 X87.107 Y103.161 E.00849
M73 P92 R1
G1 X86.727 Y103.032 E.0085
G1 X86.365 Y102.859 E.00849
G1 X86.02 Y102.64 E.00865
G1 X85.572 Y102.251 E.01256
G1 X85.31 Y101.947 E.00851
G1 X85.086 Y101.613 E.00849
G1 X84.905 Y101.257 E.00846
G1 X84.758 Y100.855 E.00906
G1 X84.643 Y100.3 E.012
G1 X84.62 Y99.89 E.00869
G1 X84.645 Y99.49 E.00849
G1 X84.718 Y99.095 E.0085
G1 X84.836 Y98.713 E.00846
G1 X85.012 Y98.323 E.00907
G1 X85.317 Y97.845 E.01199
G1 X86.503 Y96.482 E.03825
G1 X81.536 Y96.482 E.10513
G1 X81.207 Y96.43 E.00705
G1 X81.076 Y96.369 E.00305
G1 X80.883 Y96.227 E.00508
G1 X80.739 Y96.04 E.005
G1 X80.649 Y95.82 E.00503
G1 X80.619 Y95.565 E.00543
G1 X80.619 Y77.628 E.37964
G1 X80.655 Y77.357 E.00578
G1 X80.761 Y77.125 E.0054
G1 X80.934 Y76.928 E.00556
G1 X81.06 Y76.84 E.00325
G1 X81.206 Y76.772 E.00342
G1 X81.457 Y76.723 E.00541
G1 X94.524 Y76.722 E.27657
G1 X94.762 Y76.763 E.00512
G1 X94.969 Y76.858 E.00481
G1 X95.145 Y77.005 E.00485
G1 X95.277 Y77.19 E.00482
G1 X95.356 Y77.407 E.00489
G1 X95.378 Y77.559 E.00325
G1 X95.38 Y78.482 E.01952
G1 X95.019 Y78.482 E.00763
G1 X95.019 Y78.056 E.00901
G1 X94.983 Y77.808 E.0053
G1 X94.858 Y77.538 E.00631
G1 X94.65 Y77.306 E.00659
G1 X94.36 Y77.139 E.00709
G1 X94.087 Y77.082 E.00589
G1 X81.946 Y77.082 E.25697
G1 X81.658 Y77.132 E.0062
G1 X81.388 Y77.278 E.00649
G1 X81.171 Y77.494 E.00649
G1 X81.019 Y77.798 E.00718
G1 X80.981 Y78.056 E.00553
G1 X80.981 Y95.164 E.36211
G1 X81.05 Y95.5 E.00727
G1 X81.257 Y95.815 E.00796
G1 X81.591 Y96.049 E.00864
G1 X81.937 Y96.12 E.00747
G1 X86.701 Y96.119 E.10084
; WIPE_START
M204 S6000
G1 X88.701 Y96.119 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X85.605 Y96.891 Z5.76 F18000
G1 Z5.36
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X81.512 Y96.891 E.08049
G1 X81.197 Y96.854 E.00625
G1 X81.062 Y96.814 E.00277
G1 X80.867 Y96.723 E.00423
G1 X80.61 Y96.534 E.00626
G1 X80.514 Y96.432 E.00276
G1 X80.383 Y96.245 E.00448
G1 X80.291 Y96.048 E.00429
G1 X80.247 Y95.904 E.00296
G1 X80.21 Y95.589 E.00624
G1 X80.21 Y77.61 E.35362
G1 X80.231 Y77.374 E.00466
G1 X80.264 Y77.234 E.00283
G1 X80.349 Y77.019 E.00454
G1 X80.421 Y76.895 E.00283
G1 X80.564 Y76.714 E.00453
G1 X80.676 Y76.609 E.00302
G1 X80.855 Y76.485 E.00429
G1 X81.061 Y76.388 E.00448
G1 X81.209 Y76.345 E.00302
G1 X81.428 Y76.313 E.00435
G1 X94.559 Y76.313 E.25828
G1 X94.873 Y76.367 E.00627
G1 X95.073 Y76.446 E.00422
G1 X95.204 Y76.521 E.00296
G1 X95.44 Y76.719 E.00606
G1 X95.579 Y76.895 E.00442
G1 X95.649 Y77.017 E.00277
G1 X95.755 Y77.307 E.00607
G1 X95.787 Y77.529 E.00442
G1 X95.79 Y78.891 E.02678
G1 X94.61 Y78.891 E.0232
G1 X94.61 Y78.086 E.01584
G1 X94.587 Y77.926 E.00317
G1 X94.512 Y77.765 E.00349
G1 X94.389 Y77.628 E.00363
G1 X94.213 Y77.526 E.004
G1 X94.045 Y77.492 E.00337
G1 X81.982 Y77.491 E.23727
G1 X81.794 Y77.524 E.00376
G1 X81.635 Y77.61 E.00355
G1 X81.507 Y77.737 E.00355
G1 X81.414 Y77.922 E.00407
G1 X81.39 Y78.086 E.00325
G1 X81.39 Y95.122 E.3351
G1 X81.435 Y95.341 E.00439
G1 X81.556 Y95.524 E.00432
G1 X81.757 Y95.665 E.00482
G1 X81.979 Y95.711 E.00446
G1 X94.071 Y95.708 E.23785
G1 X94.243 Y95.663 E.00349
G1 X94.397 Y95.568 E.00356
G1 X94.527 Y95.413 E.00398
G1 X94.599 Y95.234 E.00379
G1 X94.608 Y94.311 E.01816
G1 X95.79 Y94.311 E.02325
G1 X95.79 Y95.589 E.02513
G1 X95.754 Y95.898 E.00613
G1 X95.651 Y96.182 E.00594
G1 X95.536 Y96.368 E.0043
G1 X95.333 Y96.584 E.00582
G1 X95.147 Y96.716 E.00449
G1 X94.87 Y96.835 E.00594
G1 X94.569 Y96.888 E.00601
G1 X90.381 Y96.891 E.08237
G1 X90.874 Y97.432 E.01439
G1 X91.134 Y97.77 E.00838
G1 X91.364 Y98.156 E.00886
G1 X91.548 Y98.57 E.00891
G1 X91.619 Y98.777 E.00431
G1 X91.728 Y99.22 E.00897
G1 X91.761 Y99.437 E.00431
G1 X91.79 Y99.891 E.00896
G1 X91.782 Y100.137 E.00484
G1 X91.732 Y100.56 E.00838
G1 X91.627 Y101.001 E.0089
G1 X91.547 Y101.234 E.00484
G1 X91.376 Y101.624 E.00838
G1 X91.147 Y102.012 E.00886
G1 X90.873 Y102.372 E.00891
G1 X90.726 Y102.534 E.0043
G1 X90.37 Y102.857 E.00945
G1 X90.024 Y103.105 E.00838
G1 X89.836 Y103.216 E.0043
G1 X89.427 Y103.412 E.00892
G1 X88.998 Y103.557 E.00891
G1 X88.785 Y103.609 E.00431
G1 X88.337 Y103.676 E.00891
G1 X87.887 Y103.689 E.00885
G1 X87.439 Y103.649 E.00885
G1 X86.999 Y103.556 E.00885
G1 X86.573 Y103.412 E.00885
G1 X86.167 Y103.218 E.00885
G1 X85.785 Y102.976 E.0089
G1 X85.59 Y102.825 E.00485
G1 X85.277 Y102.536 E.00838
G1 X84.983 Y102.195 E.00885
G1 X84.733 Y101.821 E.00885
G1 X84.529 Y101.421 E.00884
G1 X84.366 Y100.972 E.00939
G1 X84.268 Y100.558 E.00838
G1 X84.236 Y100.341 E.0043
G1 X84.21 Y99.889 E.00891
G1 X84.239 Y99.44 E.00885
G1 X84.32 Y98.997 E.00885
G1 X84.453 Y98.568 E.00884
G1 X84.649 Y98.133 E.00939
G1 X84.868 Y97.767 E.00838
G1 X84.996 Y97.59 E.0043
G1 X85.565 Y96.936 E.01705
; WIPE_START
M204 S6000
G1 X83.565 Y96.914 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G17
G3 Z5.76 I1.217 J0 P1  F18000
;===================== date: 20250206 =====================

; don't support timelapse gcode in spiral_mode and by object sequence for I3 structure printer
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
G92 E0
G1 Z5.76
G1 X0 Y90 ; move to safe pos
G1 X-13.0 F3000 ; move to safe pos
M400
M1004 S5 P1  ; external shutter
M400 P300
M971 S11 C11 O0
G92 E0
G1 X0 F18000
M623

; SKIPTYPE: head_wrap_detect
M622.1 S1
M1002 judge_flag g39_3rd_layer_detect_flag
M622 J1
    ; enable nozzle clog detect at 3rd layer
    


    M622.1 S1
    M1002 judge_flag g39_detection_flag
    M622 J1
      
        M622.1 S0
        M1002 judge_flag g39_mass_exceed_flag
        M622 J1
        
            G392 S0
            M400
            G90
            M83
            M204 S5000
            G0 Z5.76 F4000
            G39.3 S1
            G0 Z5.76 F4000
            G392 S0
          
        M623
    
    M623
M623
; SKIPPABLE_END




G1 X81.442 Y96.257
G1 Z5.36
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.151871
G1 F1500
M204 S6000
G1 X81.066 Y96.017 E.00281
G1 X80.844 Y95.656 E.00266
; WIPE_START
G1 X81.066 Y96.017 E-.18489
G1 X81.442 Y96.257 E-.19511
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X86.549 Y97.167 Z5.76 F18000
G1 Z5.36
G1 E.4 F1800
; LINE_WIDTH: 0.478029
G1 F1500
M204 S6000
G1 X86.305 Y97.365 E.00709
; LINE_WIDTH: 0.443817
G1 X86.181 Y97.48 E.00352
; LINE_WIDTH: 0.406357
G1 X86.043 Y97.61 E.00361
; LINE_WIDTH: 0.360689
G1 X85.619 Y98.078 E.01056
G1 X85.381 Y98.444 E.00729
G1 X85.193 Y98.848 E.00746
G1 X85.091 Y99.186 E.0059
G1 X85.024 Y99.536 E.00595
G1 X85.004 Y100.005 E.00785
G1 X85.065 Y100.497 E.00828
G1 X85.167 Y100.879 E.0066
G1 X85.311 Y101.226 E.00628
G1 X85.582 Y101.676 E.00877
G1 X85.91 Y102.048 E.00828
G1 X86.243 Y102.331 E.00731
G1 X86.549 Y102.526 E.00607
G1 X87.003 Y102.728 E.0083
G1 X87.523 Y102.862 E.00898
G1 X88.03 Y102.899 E.00849
G1 X88.577 Y102.844 E.00919
G1 X88.933 Y102.746 E.00618
G1 X89.268 Y102.614 E.006
G1 X89.736 Y102.345 E.00902
G1 X90.148 Y101.996 E.00902
G1 X90.489 Y101.576 E.00903
G1 X90.734 Y101.129 E.00853
G1 X90.864 Y100.794 E.00601
G1 X90.954 Y100.425 E.00635
G1 X91.001 Y99.9 E.00879
G1 X90.954 Y99.371 E.00888
G1 X90.811 Y98.854 E.00896
G1 X90.663 Y98.52 E.00611
G1 X90.477 Y98.209 E.00606
G1 X90.156 Y97.815 E.00849
G1 X89.875 Y97.535 E.00664
; LINE_WIDTH: 0.416725
G1 X89.748 Y97.423 E.00329
; LINE_WIDTH: 0.456928
G1 X89.596 Y97.29 E.00435
; LINE_WIDTH: 0.485052
G1 X89.392 Y97.135 E.00585
; WIPE_START
G1 X89.596 Y97.29 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X94.529 Y96.242 Z5.76 F18000
G1 Z5.36
G1 E.4 F1800
; LINE_WIDTH: 0.10411
G1 F1500
M204 S6000
G1 X94.675 Y96.186 E.00061
; LINE_WIDTH: 0.153077
G1 X94.855 Y96.085 E.00131
G1 X95.03 Y95.881 E.0017
; LINE_WIDTH: 0.131558
G1 X95.098 Y95.764 E.00072
; LINE_WIDTH: 0.0943806
G1 X95.136 Y95.626 E.00049
; WIPE_START
G1 X95.098 Y95.764 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X95.118 Y88.131 Z5.76 F18000
G1 X95.147 Y77.602 Z5.76
G1 Z5.36
G1 E.4 F1800
; LINE_WIDTH: 0.102862
G1 F1500
M204 S6000
G1 X95.071 Y77.389 E.00087
; LINE_WIDTH: 0.140722
G1 X95.003 Y77.28 E.00074
; LINE_WIDTH: 0.153705
G1 X94.816 Y77.086 E.00172
G1 X94.689 Y77.021 E.00091
; LINE_WIDTH: 0.120466
G1 X94.603 Y76.99 E.00043
; LINE_WIDTH: 0.0933265
G1 X94.517 Y76.959 E.00031
; WIPE_START
G1 X94.603 Y76.99 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X86.971 Y76.969 Z5.76 F18000
G1 X81.494 Y76.954 Z5.76
G1 Z5.36
G1 E.4 F1800
; LINE_WIDTH: 0.100798
G1 F1500
M204 S6000
G1 X81.354 Y77 E.00055
; LINE_WIDTH: 0.145726
G1 X81.219 Y77.065 E.0009
G1 X81.117 Y77.146 E.00078
G1 X80.961 Y77.321 E.0014
G1 X80.907 Y77.434 E.00075
; LINE_WIDTH: 0.102636
G1 X80.857 Y77.598 E.00066
; CHANGE_LAYER
; Z_HEIGHT: 5.48
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F1500
G1 X80.907 Y77.434 E-.38
; WIPE_END
G1 E-.02 F1800
; layer num/total_layer_count: 45/49
; update layer progress
M73 L45
M991 S0 P44 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z5.76 I-1.122 J.471 P1  F18000
G1 X89.161 Y97.078 Z5.76
G1 Z5.48
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X88.604 Y96.915 E.01228
G1 X88.228 Y96.864 E.00802
G1 X87.862 Y96.858 E.00775
G1 X87.324 Y96.929 E.01149
G1 X86.766 Y97.11 E.01242
G1 X86.659 Y96.949 E.0041
G1 X87.012 Y96.543 E.01138
G1 X88.921 Y96.543 E.0404
G1 X89.263 Y96.913 E.01067
G1 X89.192 Y97.027 E.00283
; WIPE_START
M204 S6000
G1 X88.604 Y96.915 E-.1138
G1 X88.228 Y96.864 E-.07203
G1 X87.862 Y96.858 E-.0696
G1 X87.324 Y96.929 E-.10317
G1 X87.217 Y96.964 E-.0214
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X90.617 Y99.85 Z5.88 F18000
G1 Z5.48
G1 E.4 F1800
G1 F1500
M204 S500
G1 X90.622 Y99.901 E.00109
G1 X90.58 Y100.36 E.00975
G1 X90.504 Y100.673 E.00682
G1 X90.396 Y100.963 E.00656
G1 X90.167 Y101.377 E.01001
G1 X89.868 Y101.741 E.00997
G1 X89.508 Y102.046 E.00998
G1 X89.098 Y102.28 E.01
G1 X88.809 Y102.393 E.00656
G1 X88.497 Y102.474 E.00682
G1 X88.039 Y102.522 E.00975
G1 X87.569 Y102.487 E.00997
G1 X87.112 Y102.366 E.01
G1 X86.828 Y102.244 E.00656
G1 X86.549 Y102.083 E.00682
G1 X86.188 Y101.796 E.00975
G1 X85.879 Y101.442 E.00995
G1 X85.643 Y101.046 E.00975
G1 X85.52 Y100.748 E.00683
G1 X85.434 Y100.437 E.00683
G1 X85.381 Y99.989 E.00955
G1 X85.39 Y99.666 E.00683
G1 X85.438 Y99.347 E.00683
G1 X85.574 Y98.907 E.00975
G1 X85.791 Y98.49 E.00994
G1 X86.072 Y98.125 E.00976
G1 X86.305 Y97.902 E.00682
G1 X86.553 Y97.716 E.00656
G1 X86.968 Y97.491 E.01
G1 X87.418 Y97.345 E.01
G1 X87.886 Y97.283 E.01
G1 X88.196 Y97.288 E.00656
G1 X88.516 Y97.331 E.00682
G1 X88.959 Y97.461 E.00978
G1 X89.381 Y97.674 E.01001
G1 X89.634 Y97.853 E.00656
G1 X89.874 Y98.068 E.00682
G1 X90.16 Y98.417 E.00955
G1 X90.326 Y98.694 E.00683
G1 X90.457 Y98.989 E.00683
G1 X90.58 Y99.433 E.00975
G1 X90.612 Y99.79 E.00759
M204 S250
G1 X90.21 Y99.886 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X90.211 Y99.901 E.00029
G1 X90.176 Y100.293 E.00774
G1 X90.112 Y100.552 E.00526
G1 X90.023 Y100.792 E.00503
G1 X89.827 Y101.146 E.00796
G1 X89.575 Y101.452 E.0078
G1 X89.272 Y101.709 E.00781
G1 X88.921 Y101.91 E.00796
G1 X88.683 Y102.003 E.00503
G1 X88.424 Y102.07 E.00526
G1 X88.033 Y102.111 E.00773
G1 X87.637 Y102.082 E.0078
G1 X87.246 Y101.979 E.00796
G1 X87.011 Y101.878 E.00503
G1 X86.78 Y101.744 E.00526
G1 X86.472 Y101.499 E.00773
G1 X86.211 Y101.2 E.0078
G1 X86.01 Y100.863 E.00774
G1 X85.908 Y100.615 E.00526
G1 X85.837 Y100.357 E.00526
G1 X85.791 Y99.97 E.00767
G1 X85.799 Y99.703 E.00526
G1 X85.838 Y99.438 E.00526
G1 X85.954 Y99.062 E.00774
G1 X86.137 Y98.711 E.00779
G1 X86.377 Y98.4 E.00774
G1 X86.571 Y98.215 E.00526
G1 X86.775 Y98.061 E.00503
G1 X87.131 Y97.868 E.00796
G1 X87.508 Y97.745 E.00781
G1 X87.91 Y97.693 E.00796
G1 X88.165 Y97.697 E.00503
G1 X88.43 Y97.733 E.00526
G1 X88.808 Y97.843 E.00774
G1 X89.169 Y98.025 E.00796
M73 P93 R1
G1 X89.378 Y98.173 E.00503
G1 X89.577 Y98.352 E.00526
G1 X89.825 Y98.653 E.00767
G1 X89.962 Y98.883 E.00526
G1 X90.071 Y99.127 E.00526
G1 X90.175 Y99.506 E.00773
G1 X90.204 Y99.826 E.00633
; WIPE_START
M204 S6000
G1 X90.211 Y99.901 E-.0142
G1 X90.176 Y100.293 E-.07472
G1 X90.112 Y100.552 E-.0508
G1 X90.023 Y100.792 E-.04855
G1 X89.827 Y101.146 E-.07692
G1 X89.575 Y101.452 E-.07538
G1 X89.417 Y101.587 E-.03943
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X86.761 Y96.119 Z5.88 F18000
G1 Z5.48
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X94.128 Y96.117 E.15594
G1 X94.416 Y96.04 E.0063
G1 X94.697 Y95.855 E.00713
G1 X94.889 Y95.613 E.00654
G1 X95.007 Y95.314 E.00681
G1 X95.013 Y94.72 E.01257
G1 X95.38 Y94.72 E.00776
G1 X95.378 Y95.634 E.01935
G1 X95.34 Y95.855 E.00474
G1 X95.284 Y95.996 E.00321
G1 X95.209 Y96.118 E.00302
G1 X95.057 Y96.279 E.00469
G1 X94.947 Y96.356 E.00286
G1 X94.751 Y96.441 E.0045
G1 X94.533 Y96.479 E.0047
G1 X89.443 Y96.483 E.10774
G1 X90.544 Y97.675 E.03436
G1 X90.795 Y98 E.00869
G1 X91 Y98.345 E.00849
G1 X91.167 Y98.72 E.00869
G1 X91.326 Y99.3 E.01273
G1 X91.38 Y99.89 E.01254
G1 X91.357 Y100.298 E.00865
G1 X91.235 Y100.879 E.01256
G1 X91.094 Y101.263 E.00867
G1 X91.005 Y101.448 E.00433
G1 X90.807 Y101.783 E.00824
G1 X90.558 Y102.11 E.0087
G1 X90.126 Y102.529 E.01274
G1 X89.635 Y102.859 E.01253
G1 X89.273 Y103.032 E.0085
G1 X88.893 Y103.161 E.00849
G1 X88.5 Y103.243 E.00849
G1 X88.1 Y103.279 E.00849
G1 X87.699 Y103.267 E.0085
G1 X87.115 Y103.163 E.01256
G1 X86.727 Y103.032 E.00866
G1 X86.357 Y102.855 E.00869
G1 X85.867 Y102.522 E.01253
G1 X85.571 Y102.251 E.00849
G1 X85.31 Y101.947 E.00849
G1 X85.086 Y101.613 E.0085
G1 X84.904 Y101.257 E.00847
G1 X84.76 Y100.859 E.00897
G1 X84.643 Y100.3 E.01209
G1 X84.62 Y99.89 E.00869
G1 X84.645 Y99.489 E.00849
G1 X84.718 Y99.095 E.00849
G1 X84.836 Y98.713 E.00847
G1 X85.01 Y98.326 E.00897
G1 X85.317 Y97.845 E.01209
G1 X86.503 Y96.482 E.03824
G1 X81.536 Y96.482 E.10513
G1 X81.289 Y96.453 E.00527
G1 X81.143 Y96.405 E.00324
G1 X80.982 Y96.311 E.00395
G1 X80.873 Y96.214 E.00309
G1 X80.735 Y96.031 E.00486
G1 X80.649 Y95.821 E.0048
G1 X80.619 Y95.565 E.00546
G1 X80.619 Y77.619 E.37984
G1 X80.659 Y77.349 E.00578
G1 X80.76 Y77.125 E.0052
G1 X80.933 Y76.929 E.00554
G1 X81.06 Y76.84 E.00328
G1 X81.208 Y76.772 E.00344
G1 X81.458 Y76.723 E.0054
G1 X94.526 Y76.722 E.27659
G1 X94.761 Y76.763 E.00506
G1 X94.976 Y76.861 E.00499
G1 X95.161 Y77.022 E.0052
G1 X95.283 Y77.208 E.0047
G1 X95.356 Y77.407 E.0045
G1 X95.378 Y77.559 E.00325
G1 X95.38 Y78.482 E.01952
G1 X95.019 Y78.482 E.00763
G1 X95.019 Y78.056 E.00901
G1 X94.983 Y77.808 E.00531
G1 X94.858 Y77.538 E.0063
G1 X94.651 Y77.306 E.00657
G1 X94.359 Y77.139 E.00711
G1 X94.087 Y77.082 E.00589
G1 X81.946 Y77.082 E.25697
G1 X81.657 Y77.132 E.0062
G1 X81.379 Y77.282 E.00669
G1 X81.147 Y77.529 E.00717
G1 X81.017 Y77.807 E.00649
G1 X80.981 Y78.056 E.00533
G1 X80.981 Y95.164 E.36212
G1 X81.05 Y95.501 E.00727
G1 X81.257 Y95.815 E.00795
G1 X81.591 Y96.049 E.00864
G1 X81.937 Y96.12 E.00747
G1 X86.701 Y96.119 E.10083
; WIPE_START
M204 S6000
G1 X88.701 Y96.119 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X85.604 Y96.891 Z5.88 F18000
G1 Z5.48
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X81.512 Y96.891 E.08049
G1 X81.2 Y96.854 E.00619
G1 X80.986 Y96.784 E.00442
G1 X80.855 Y96.718 E.00289
G1 X80.732 Y96.637 E.00289
G1 X80.57 Y96.493 E.00426
G1 X80.382 Y96.242 E.00617
G1 X80.287 Y96.039 E.00441
G1 X80.247 Y95.904 E.00277
G1 X80.21 Y95.589 E.00625
G1 X80.21 Y77.607 E.35368
G1 X80.219 Y77.454 E.00301
G1 X80.265 Y77.231 E.00448
G1 X80.349 Y77.02 E.00448
G1 X80.421 Y76.895 E.00283
G1 X80.564 Y76.714 E.00453
G1 X80.675 Y76.61 E.00299
G1 X80.855 Y76.484 E.00432
G1 X81.062 Y76.388 E.00448
G1 X81.2 Y76.347 E.00283
G1 X81.428 Y76.313 E.00454
G1 X94.561 Y76.313 E.25831
G1 X94.873 Y76.367 E.00623
G1 X95.081 Y76.45 E.00441
G1 X95.206 Y76.522 E.00283
G1 X95.387 Y76.665 E.00454
G1 X95.484 Y76.767 E.00277
G1 X95.652 Y77.023 E.00601
G1 X95.755 Y77.307 E.00594
G1 X95.787 Y77.529 E.00442
G1 X95.79 Y78.891 E.02678
G1 X94.61 Y78.891 E.0232
G1 X94.61 Y78.086 E.01584
G1 X94.587 Y77.926 E.00318
G1 X94.512 Y77.765 E.00349
G1 X94.39 Y77.628 E.00362
G1 X94.212 Y77.526 E.00402
G1 X94.045 Y77.492 E.00336
G1 X81.982 Y77.491 E.23727
G1 X81.794 Y77.524 E.00376
G1 X81.632 Y77.611 E.00362
G1 X81.49 Y77.761 E.00406
G1 X81.413 Y77.925 E.00356
G1 X81.39 Y78.086 E.00319
G1 X81.39 Y95.123 E.3351
G1 X81.435 Y95.341 E.00439
G1 X81.556 Y95.524 E.00431
G1 X81.757 Y95.665 E.00482
G1 X81.979 Y95.711 E.00446
G1 X94.074 Y95.708 E.23791
G1 X94.246 Y95.662 E.0035
G1 X94.417 Y95.55 E.00403
G1 X94.531 Y95.406 E.00359
G1 X94.599 Y95.234 E.00364
G1 X94.608 Y94.311 E.01816
G1 X95.79 Y94.311 E.02324
G1 X95.788 Y95.67 E.02673
G1 X95.736 Y95.966 E.00591
G1 X95.652 Y96.18 E.00452
G1 X95.536 Y96.368 E.00435
G1 X95.326 Y96.59 E.00601
G1 X95.147 Y96.716 E.0043
G1 X94.87 Y96.835 E.00595
G1 X94.569 Y96.888 E.00601
G1 X90.377 Y96.891 E.08245
G1 X90.857 Y97.411 E.01392
G1 X91.134 Y97.77 E.00891
G1 X91.364 Y98.156 E.00885
G1 X91.548 Y98.57 E.00891
G1 X91.619 Y98.777 E.00431
G1 X91.728 Y99.22 E.00897
G1 X91.761 Y99.437 E.00431
G1 X91.79 Y99.889 E.00891
G1 X91.764 Y100.34 E.0089
G1 X91.728 Y100.579 E.00475
G1 X91.627 Y100.998 E.00847
G1 X91.471 Y101.423 E.0089
G1 X91.366 Y101.641 E.00475
G1 X91.148 Y102.011 E.00847
G1 X90.873 Y102.372 E.00892
G1 X90.726 Y102.534 E.00431
G1 X90.39 Y102.842 E.00897
G1 X90.216 Y102.975 E.0043
G1 X89.833 Y103.218 E.00891
G1 X89.427 Y103.412 E.00885
G1 X89.001 Y103.556 E.00885
G1 X88.561 Y103.649 E.00885
G1 X88.113 Y103.689 E.00885
G1 X87.663 Y103.676 E.00885
G1 X87.237 Y103.612 E.00847
G1 X87.002 Y103.557 E.00475
G1 X86.573 Y103.412 E.00891
G1 X86.164 Y103.216 E.00891
G1 X85.976 Y103.105 E.0043
G1 X85.608 Y102.84 E.00891
G1 X85.277 Y102.536 E.00885
G1 X84.984 Y102.195 E.00885
G1 X84.733 Y101.821 E.00885
G1 X84.528 Y101.421 E.00884
G1 X84.367 Y100.977 E.00929
G1 X84.268 Y100.558 E.00847
G1 X84.236 Y100.341 E.0043
G1 X84.21 Y99.889 E.00891
G1 X84.239 Y99.44 E.00885
G1 X84.32 Y98.997 E.00885
G1 X84.453 Y98.568 E.00884
G1 X84.647 Y98.137 E.0093
G1 X84.868 Y97.767 E.00847
G1 X84.996 Y97.59 E.00431
G1 X85.565 Y96.936 E.01705
; WIPE_START
M204 S6000
G1 X83.565 Y96.914 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G17
G3 Z5.88 I1.217 J0 P1  F18000
;===================== date: 20250206 =====================

; don't support timelapse gcode in spiral_mode and by object sequence for I3 structure printer
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
G92 E0
G1 Z5.88
G1 X0 Y90 ; move to safe pos
G1 X-13.0 F3000 ; move to safe pos
M400
M1004 S5 P1  ; external shutter
M400 P300
M971 S11 C11 O0
G92 E0
G1 X0 F18000
M623

; SKIPTYPE: head_wrap_detect
M622.1 S1
M1002 judge_flag g39_3rd_layer_detect_flag
M622 J1
    ; enable nozzle clog detect at 3rd layer
    


    M622.1 S1
    M1002 judge_flag g39_detection_flag
    M622 J1
      
        M622.1 S0
        M1002 judge_flag g39_mass_exceed_flag
        M622 J1
        
            G392 S0
            M400
            G90
            M83
            M204 S5000
            G0 Z5.88 F4000
            G39.3 S1
            G0 Z5.88 F4000
            G392 S0
          
        M623
    
    M623
M623
; SKIPPABLE_END




G1 X81.456 Y96.238
G1 Z5.48
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.0962423
G1 F1500
M204 S6000
G1 X81.354 Y96.193 E.00039
; LINE_WIDTH: 0.148185
G1 X81.251 Y96.148 E.00068
G1 X81.066 Y96.016 E.00139
G1 X80.844 Y95.655 E.00259
; WIPE_START
G1 X81.066 Y96.016 E-.21101
G1 X81.251 Y96.148 E-.1133
G1 X81.354 Y96.193 E-.05569
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X86.549 Y97.167 Z5.88 F18000
G1 Z5.48
G1 E.4 F1800
; LINE_WIDTH: 0.478384
G1 F1500
M204 S6000
G1 X86.307 Y97.363 E.00702
; LINE_WIDTH: 0.444437
G1 X86.183 Y97.479 E.00355
; LINE_WIDTH: 0.406604
G1 X86.043 Y97.61 E.00364
; LINE_WIDTH: 0.360424
G1 X85.784 Y97.882 E.00627
G1 X85.468 Y98.301 E.00876
G1 X85.22 Y98.777 E.00897
G1 X85.089 Y99.186 E.00717
G1 X85.015 Y99.622 E.00739
G1 X85.004 Y99.993 E.00619
G1 X85.065 Y100.497 E.00848
G1 X85.167 Y100.879 E.0066
G1 X85.311 Y101.226 E.00627
G1 X85.613 Y101.716 E.00961
G1 X85.939 Y102.078 E.00813
G1 X86.346 Y102.402 E.00869
G1 X86.669 Y102.583 E.00617
G1 X87.002 Y102.725 E.00604
G1 X87.492 Y102.856 E.00848
G1 X88.06 Y102.9 E.0095
G1 X88.552 Y102.847 E.00828
G1 X88.935 Y102.749 E.00659
G1 X89.272 Y102.615 E.00605
G1 X89.76 Y102.33 E.00943
G1 X90.164 Y101.978 E.00895
G1 X90.488 Y101.577 E.00862
G1 X90.745 Y101.111 E.00889
G1 X90.869 Y100.775 E.00597
G1 X90.953 Y100.433 E.00588
G1 X91 Y99.891 E.00909
G1 X90.954 Y99.371 E.00871
G1 X90.812 Y98.854 E.00895
G1 X90.663 Y98.52 E.00611
G1 X90.477 Y98.209 E.00605
G1 X90.157 Y97.815 E.00848
G1 X89.874 Y97.535 E.00664
; LINE_WIDTH: 0.41426
G1 X89.746 Y97.423 E.0033
; LINE_WIDTH: 0.453638
G1 X89.592 Y97.29 E.00434
; LINE_WIDTH: 0.483348
G1 X89.379 Y97.129 E.0061
; WIPE_START
G1 X89.592 Y97.29 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X94.541 Y96.258 Z5.88 F18000
G1 Z5.48
G1 E.4 F1800
; LINE_WIDTH: 0.149113
G1 F1500
M204 S6000
G1 X94.877 Y96.067 E.00238
G1 X94.985 Y95.945 E.001
G1 X95.087 Y95.784 E.00118
; LINE_WIDTH: 0.0960276
G1 X95.141 Y95.618 E.00061
; WIPE_START
G1 X95.087 Y95.784 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X95.112 Y88.151 Z5.88 F18000
G1 X95.147 Y77.602 Z5.88
G1 Z5.48
G1 E.4 F1800
; LINE_WIDTH: 0.103553
G1 F1500
M204 S6000
G1 X95.072 Y77.388 E.00088
; LINE_WIDTH: 0.150755
G1 X94.94 Y77.203 E.00142
G1 X94.832 Y77.098 E.00094
G1 X94.688 Y77.02 E.00102
; LINE_WIDTH: 0.120194
G1 X94.602 Y76.99 E.00043
; LINE_WIDTH: 0.0932327
G1 X94.517 Y76.959 E.00031
; WIPE_START
G1 X94.602 Y76.99 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X86.97 Y76.969 Z5.88 F18000
G1 X81.494 Y76.954 Z5.88
G1 Z5.48
G1 E.4 F1800
; LINE_WIDTH: 0.101792
G1 F1500
M204 S6000
G1 X81.348 Y77.003 E.00058
; LINE_WIDTH: 0.147026
G1 X81.206 Y77.072 E.00095
G1 X81.117 Y77.147 E.00071
G1 X80.964 Y77.323 E.00141
G1 X80.909 Y77.423 E.00069
; LINE_WIDTH: 0.0994953
G1 X80.855 Y77.602 E.00069
; CHANGE_LAYER
; Z_HEIGHT: 5.6
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F1500
G1 X80.909 Y77.423 E-.38
; WIPE_END
G1 E-.02 F1800
; layer num/total_layer_count: 46/49
; update layer progress
M73 L46
M991 S0 P45 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z5.88 I-1.121 J.473 P1  F18000
G1 X89.213 Y97.113 Z5.88
G1 Z5.6
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X89.113 Y97.064 E.00235
G1 X88.604 Y96.915 E.01123
G1 X88.228 Y96.864 E.00803
G1 X87.859 Y96.858 E.00781
G1 X87.323 Y96.929 E.01144
G1 X86.766 Y97.11 E.01241
G1 X86.659 Y96.949 E.0041
G1 X87.012 Y96.543 E.01138
G1 X88.988 Y96.543 E.04183
G1 X89.341 Y96.948 E.01137
G1 X89.249 Y97.066 E.00315
; WIPE_START
M204 S6000
G1 X89.113 Y97.064 E-.02583
G1 X88.604 Y96.915 E-.10078
G1 X88.228 Y96.864 E-.07213
G1 X87.859 Y96.858 E-.07013
G1 X87.323 Y96.929 E-.10271
G1 X87.281 Y96.943 E-.00842
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X90.617 Y99.85 Z6 F18000
G1 Z5.6
G1 E.4 F1800
G1 F1500
M204 S500
G1 X90.622 Y99.901 E.00109
G1 X90.58 Y100.36 E.00975
G1 X90.504 Y100.673 E.00682
G1 X90.395 Y100.966 E.00662
G1 X90.167 Y101.377 E.00995
G1 X89.868 Y101.741 E.00997
G1 X89.509 Y102.045 E.00995
G1 X89.11 Y102.275 E.00975
G1 X88.81 Y102.393 E.00683
G1 X88.498 Y102.474 E.00683
G1 X88.048 Y102.521 E.00956
M73 P94 R1
G1 X87.726 Y102.507 E.00683
G1 X87.408 Y102.454 E.00683
G1 X86.97 Y102.312 E.00975
G1 X86.556 Y102.089 E.00994
G1 X86.188 Y101.796 E.00995
G1 X85.879 Y101.442 E.00995
G1 X85.638 Y101.039 E.00994
G1 X85.476 Y100.607 E.00976
G1 X85.409 Y100.291 E.00683
G1 X85.38 Y99.97 E.00683
G1 X85.408 Y99.51 E.00975
G1 X85.517 Y99.063 E.00975
G1 X85.639 Y98.764 E.00683
G1 X85.796 Y98.482 E.00683
G1 X86.072 Y98.125 E.00956
G1 X86.306 Y97.902 E.00683
G1 X86.564 Y97.708 E.00683
G1 X86.97 Y97.49 E.00975
G1 X87.417 Y97.345 E.00997
G1 X87.884 Y97.283 E.00995
G1 X88.196 Y97.288 E.00662
G1 X88.516 Y97.331 E.00683
G1 X88.958 Y97.46 E.00975
G1 X89.37 Y97.666 E.00975
G1 X89.634 Y97.852 E.00683
G1 X89.874 Y98.068 E.00683
G1 X90.166 Y98.424 E.00975
G1 X90.391 Y98.826 E.00975
G1 X90.504 Y99.129 E.00683
G1 X90.58 Y99.442 E.00683
G1 X90.612 Y99.79 E.00739
M204 S250
G1 X90.21 Y99.886 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X90.211 Y99.901 E.00029
G1 X90.176 Y100.292 E.00773
G1 X90.112 Y100.552 E.00526
G1 X90.022 Y100.794 E.00508
G1 X89.827 Y101.146 E.00792
G1 X89.575 Y101.452 E.0078
G1 X89.272 Y101.709 E.0078
G1 X88.932 Y101.905 E.00773
G1 X88.683 Y102.003 E.00526
G1 X88.424 Y102.07 E.00526
G1 X88.036 Y102.111 E.00767
G1 X87.769 Y102.099 E.00526
G1 X87.505 Y102.055 E.00526
G1 X87.131 Y101.934 E.00773
G1 X86.782 Y101.746 E.00779
G1 X86.472 Y101.499 E.0078
G1 X86.211 Y101.2 E.0078
G1 X86.008 Y100.86 E.00779
G1 X85.87 Y100.492 E.00774
G1 X85.814 Y100.23 E.00526
G1 X85.79 Y99.964 E.00526
G1 X85.814 Y99.571 E.00773
G1 X85.907 Y99.189 E.00773
G1 X86.009 Y98.942 E.00526
G1 X86.139 Y98.708 E.00526
G1 X86.377 Y98.4 E.00767
G1 X86.571 Y98.215 E.00526
G1 X86.785 Y98.054 E.00526
G1 X87.131 Y97.868 E.00773
G1 X87.508 Y97.745 E.0078
G1 X87.907 Y97.693 E.00792
G1 X88.165 Y97.697 E.00508
G1 X88.43 Y97.733 E.00526
G1 X88.808 Y97.843 E.00773
G1 X89.159 Y98.019 E.00774
G1 X89.378 Y98.173 E.00526
G1 X89.577 Y98.352 E.00526
G1 X89.827 Y98.655 E.00773
G1 X90.018 Y98.999 E.00774
G1 X90.112 Y99.249 E.00526
G1 X90.176 Y99.509 E.00526
G1 X90.204 Y99.826 E.00626
; WIPE_START
M204 S6000
G1 X90.211 Y99.901 E-.0142
G1 X90.176 Y100.292 E-.0747
G1 X90.112 Y100.552 E-.05081
G1 X90.022 Y100.794 E-.04905
G1 X89.827 Y101.146 E-.07647
G1 X89.575 Y101.452 E-.07536
G1 X89.417 Y101.587 E-.03941
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X86.761 Y96.119 Z6 F18000
G1 Z5.6
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X94.137 Y96.117 E.15611
G1 X94.45 Y96.024 E.00692
G1 X94.704 Y95.848 E.00655
G1 X94.889 Y95.613 E.00634
G1 X95.007 Y95.314 E.00679
G1 X95.013 Y94.72 E.01258
G1 X95.381 Y94.72 E.00778
G1 X95.381 Y95.565 E.01788
G1 X95.353 Y95.803 E.00508
G1 X95.28 Y96.003 E.0045
G1 X95.209 Y96.118 E.00286
G1 X95.057 Y96.279 E.00469
G1 X94.947 Y96.356 E.00286
G1 X94.751 Y96.441 E.0045
G1 X94.533 Y96.479 E.0047
G1 X89.498 Y96.483 E.10657
G1 X90.683 Y97.845 E.03821
G1 X91.004 Y98.352 E.01271
G1 X91.09 Y98.533 E.00424
G1 X91.228 Y98.901 E.00833
G1 X91.326 Y99.3 E.0087
G1 X91.38 Y99.89 E.01254
G1 X91.357 Y100.298 E.00866
G1 X91.235 Y100.879 E.01256
G1 X91.096 Y101.256 E.0085
G1 X90.91 Y101.622 E.00869
G1 X90.696 Y101.94 E.0081
G1 X90.429 Y102.251 E.00869
G1 X90.126 Y102.529 E.00868
G1 X89.635 Y102.859 E.01254
G1 X89.273 Y103.032 E.00849
G1 X88.892 Y103.161 E.0085
G1 X88.31 Y103.267 E.01254
G1 X87.9 Y103.279 E.00869
G1 X87.5 Y103.243 E.00849
G1 X87.107 Y103.161 E.00849
G1 X86.727 Y103.032 E.00849
G1 X86.366 Y102.859 E.00847
G1 X86.013 Y102.634 E.00887
G1 X85.577 Y102.258 E.01218
G1 X85.31 Y101.947 E.00869
G1 X85.086 Y101.613 E.00849
G1 X84.904 Y101.257 E.00848
G1 X84.761 Y100.863 E.00887
G1 X84.643 Y100.3 E.01218
G1 X84.62 Y99.89 E.00869
G1 X84.645 Y99.49 E.00849
G1 X84.718 Y99.095 E.0085
G1 X84.836 Y98.713 E.00847
G1 X85.008 Y98.33 E.00887
G1 X85.317 Y97.845 E.01218
G1 X86.503 Y96.482 E.03825
G1 X81.536 Y96.482 E.10513
G1 X81.208 Y96.43 E.00704
G1 X80.982 Y96.311 E.0054
G1 X80.8 Y96.133 E.00539
G1 X80.72 Y96.003 E.00324
G1 X80.647 Y95.803 E.0045
G1 X80.619 Y95.565 E.00508
G1 X80.619 Y77.628 E.37965
G1 X80.655 Y77.357 E.00578
G1 X80.76 Y77.125 E.00539
G1 X80.861 Y76.998 E.00343
G1 X80.982 Y76.89 E.00343
G1 X81.2 Y76.775 E.0052
G1 X81.449 Y76.723 E.00539
G1 X94.527 Y76.722 E.27681
G1 X94.761 Y76.763 E.00503
G1 X94.976 Y76.861 E.00499
G1 X95.161 Y77.022 E.0052
G1 X95.283 Y77.208 E.00469
G1 X95.356 Y77.407 E.0045
G1 X95.378 Y77.559 E.00325
G1 X95.38 Y78.482 E.01952
G1 X95.019 Y78.482 E.00763
G1 X95.019 Y78.056 E.00901
G1 X94.983 Y77.807 E.00532
G1 X94.858 Y77.538 E.00628
G1 X94.654 Y77.308 E.00651
G1 X94.36 Y77.139 E.00717
G1 X94.087 Y77.082 E.00592
G1 X81.946 Y77.082 E.25697
G1 X81.657 Y77.132 E.0062
G1 X81.388 Y77.278 E.00649
G1 X81.171 Y77.495 E.00649
G1 X81.019 Y77.798 E.00717
G1 X80.981 Y78.056 E.00553
G1 X80.981 Y95.155 E.36192
G1 X81.035 Y95.463 E.00661
G1 X81.25 Y95.81 E.00863
G1 X81.593 Y96.049 E.00886
G1 X81.937 Y96.12 E.00744
G1 X86.701 Y96.119 E.10083
; WIPE_START
M204 S6000
G1 X88.701 Y96.119 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X85.605 Y96.891 Z6 F18000
G1 Z5.6
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X81.512 Y96.891 E.08049
G1 X81.197 Y96.854 E.00625
G1 X81.062 Y96.814 E.00277
G1 X80.853 Y96.716 E.00454
G1 X80.732 Y96.637 E.00283
G1 X80.56 Y96.484 E.00454
G1 X80.467 Y96.373 E.00283
G1 X80.35 Y96.182 E.00442
G1 X80.246 Y95.898 E.00595
G1 X80.21 Y95.589 E.00613
G1 X80.21 Y77.61 E.35362
G1 X80.231 Y77.374 E.00466
G1 X80.264 Y77.234 E.00283
G1 X80.349 Y77.019 E.00454
G1 X80.421 Y76.895 E.00283
G1 X80.562 Y76.716 E.00448
G1 X80.732 Y76.565 E.00448
G1 X80.853 Y76.486 E.00283
G1 X81.059 Y76.389 E.00448
G1 X81.279 Y76.33 E.00448
G1 X81.425 Y76.313 E.00289
G1 X94.562 Y76.313 E.2584
G1 X94.873 Y76.367 E.0062
G1 X95.081 Y76.45 E.00441
G1 X95.206 Y76.522 E.00283
G1 X95.387 Y76.665 E.00454
G1 X95.484 Y76.767 E.00277
G1 X95.652 Y77.023 E.00601
G1 X95.755 Y77.307 E.00594
G1 X95.787 Y77.529 E.00443
G1 X95.79 Y78.891 E.02678
G1 X94.61 Y78.891 E.0232
G1 X94.61 Y78.086 E.01584
G1 X94.587 Y77.926 E.00318
G1 X94.512 Y77.765 E.00348
G1 X94.392 Y77.63 E.00357
G1 X94.213 Y77.526 E.00406
G1 X94.045 Y77.492 E.00337
G1 X81.982 Y77.491 E.23727
G1 X81.793 Y77.524 E.00376
G1 X81.635 Y77.61 E.00355
G1 X81.507 Y77.737 E.00355
G1 X81.414 Y77.922 E.00407
G1 X81.39 Y78.086 E.00325
G1 X81.39 Y95.119 E.33504
G1 X81.425 Y95.314 E.0039
G1 X81.553 Y95.523 E.00482
G1 X81.758 Y95.666 E.00491
G1 X81.979 Y95.711 E.00443
G1 X94.077 Y95.708 E.23796
G1 X94.27 Y95.651 E.00396
G1 X94.42 Y95.546 E.00359
G1 X94.531 Y95.406 E.00352
G1 X94.599 Y95.234 E.00364
G1 X94.608 Y94.311 E.01816
G1 X95.79 Y94.311 E.02325
G1 X95.79 Y95.589 E.02513
G1 X95.754 Y95.898 E.00613
G1 X95.65 Y96.182 E.00594
G1 X95.536 Y96.368 E.0043
G1 X95.326 Y96.59 E.006
G1 X95.147 Y96.716 E.0043
G1 X94.87 Y96.835 E.00595
G1 X94.569 Y96.888 E.00601
G1 X90.396 Y96.891 E.08208
G1 X91.004 Y97.59 E.01821
G1 X91.132 Y97.767 E.00431
G1 X91.366 Y98.159 E.00897
G1 X91.467 Y98.372 E.00466
G1 X91.62 Y98.78 E.00856
G1 X91.728 Y99.22 E.00891
G1 X91.761 Y99.437 E.00431
G1 X91.79 Y99.889 E.00891
G1 X91.764 Y100.341 E.0089
G1 X91.729 Y100.575 E.00466
G1 X91.627 Y100.998 E.00856
G1 X91.472 Y101.42 E.00885
G1 X91.266 Y101.824 E.00891
G1 X91.148 Y102.012 E.00437
G1 X91.019 Y102.192 E.00437
G1 X90.723 Y102.536 E.00891
G1 X90.39 Y102.842 E.00891
G1 X90.216 Y102.975 E.00431
G1 X89.833 Y103.218 E.00891
G1 X89.427 Y103.412 E.00885
G1 X89.001 Y103.556 E.00886
G1 X88.558 Y103.649 E.00891
G1 X88.34 Y103.675 E.00431
G1 X87.887 Y103.689 E.00891
G1 X87.439 Y103.649 E.00885
G1 X86.999 Y103.556 E.00885
G1 X86.573 Y103.412 E.00885
G1 X86.167 Y103.218 E.00884
G1 X85.773 Y102.966 E.0092
G1 X85.435 Y102.691 E.00856
G1 X85.279 Y102.538 E.00431
G1 X84.983 Y102.195 E.00891
G1 X84.733 Y101.821 E.00885
G1 X84.528 Y101.421 E.00885
G1 X84.368 Y100.981 E.0092
G1 X84.268 Y100.558 E.00856
G1 X84.236 Y100.341 E.0043
G1 X84.21 Y99.889 E.00891
G1 X84.239 Y99.44 E.00885
G1 X84.32 Y98.997 E.00885
G1 X84.453 Y98.568 E.00884
G1 X84.644 Y98.141 E.00921
G1 X84.868 Y97.767 E.00856
G1 X84.996 Y97.59 E.0043
G1 X85.565 Y96.936 E.01705
; WIPE_START
M204 S6000
G1 X83.565 Y96.914 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G17
G3 Z6 I1.217 J0 P1  F18000
;===================== date: 20250206 =====================

; don't support timelapse gcode in spiral_mode and by object sequence for I3 structure printer
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
G92 E0
G1 Z6
G1 X0 Y90 ; move to safe pos
G1 X-13.0 F3000 ; move to safe pos
M400
M1004 S5 P1  ; external shutter
M400 P300
M971 S11 C11 O0
G92 E0
G1 X0 F18000
M623

; SKIPTYPE: head_wrap_detect
M622.1 S1
M1002 judge_flag g39_3rd_layer_detect_flag
M622 J1
    ; enable nozzle clog detect at 3rd layer
    


    M622.1 S1
    M1002 judge_flag g39_detection_flag
    M622 J1
      
        M622.1 S0
        M1002 judge_flag g39_mass_exceed_flag
        M622 J1
        
            G392 S0
            M400
            G90
            M83
            M204 S5000
            G0 Z6 F4000
            G39.3 S1
            G0 Z6 F4000
            G392 S0
          
        M623
    
    M623
M623
; SKIPPABLE_END




G1 X81.45 Y96.256
G1 Z5.6
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.146435
G1 F1500
M204 S6000
G1 X81.192 Y96.113 E.00178
G1 X81.053 Y96.007 E.00105
G1 X80.969 Y95.881 E.00091
G1 X80.847 Y95.63 E.00168
; WIPE_START
G1 X80.969 Y95.881 E-.11766
G1 X81.053 Y96.007 E-.0641
G1 X81.192 Y96.113 E-.07371
G1 X81.45 Y96.256 E-.12453
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X86.549 Y97.167 Z6 F18000
G1 Z5.6
G1 E.4 F1800
; LINE_WIDTH: 0.479779
G1 F1500
M204 S6000
G1 X86.317 Y97.353 E.00673
; LINE_WIDTH: 0.446999
G1 X86.188 Y97.473 E.00371
; LINE_WIDTH: 0.407494
G1 X86.043 Y97.609 E.00378
; LINE_WIDTH: 0.360126
G1 X85.784 Y97.882 E.00628
G1 X85.491 Y98.266 E.00806
G1 X85.304 Y98.591 E.00626
G1 X85.155 Y98.958 E.0066
G1 X85.032 Y99.469 E.00876
G1 X85.003 Y99.891 E.00707
G1 X85.023 Y100.256 E.0061
G1 X85.126 Y100.756 E.00851
G1 X85.305 Y101.215 E.00822
G1 X85.582 Y101.676 E.00897
G1 X85.918 Y102.057 E.00848
G1 X86.239 Y102.325 E.00697
G1 X86.553 Y102.523 E.00619
G1 X86.871 Y102.679 E.00591
G1 X87.33 Y102.823 E.00803
G1 X87.556 Y102.865 E.00384
G1 X87.911 Y102.897 E.00594
G1 X88.276 Y102.884 E.00609
G1 X88.576 Y102.84 E.00506
G1 X88.917 Y102.754 E.00586
G1 X89.284 Y102.609 E.00659
G1 X89.712 Y102.358 E.00827
G1 X90.126 Y102.016 E.00896
G1 X90.393 Y101.705 E.00684
G1 X90.577 Y101.43 E.00552
G1 X90.748 Y101.103 E.00615
G1 X90.871 Y100.771 E.00591
G1 X90.975 Y100.254 E.0088
G1 X91.001 Y99.891 E.00607
G1 X90.952 Y99.393 E.00835
G1 X90.865 Y99.013 E.00649
G1 X90.664 Y98.53 E.00873
G1 X90.467 Y98.201 E.0064
G1 X90.139 Y97.797 E.00868
; LINE_WIDTH: 0.382503
G1 X89.876 Y97.53 E.00667
; LINE_WIDTH: 0.426912
G1 X89.751 Y97.417 E.00337
; LINE_WIDTH: 0.468076
G1 X89.625 Y97.304 E.00372
G1 X89.603 Y97.308 E.0005
; LINE_WIDTH: 0.443136
G1 X89.444 Y97.338 E.00338
; LINE_WIDTH: 0.416354
G1 X89.284 Y97.368 E.00316
; WIPE_START
G1 X89.444 Y97.338 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X94.555 Y96.254 Z6 F18000
G1 Z5.6
G1 E.4 F1800
; LINE_WIDTH: 0.1507
G1 F1500
M204 S6000
G1 X94.874 Y96.067 E.0023
G1 X95.03 Y95.882 E.00151
; LINE_WIDTH: 0.130492
G1 X95.106 Y95.745 E.00082
; LINE_WIDTH: 0.0915161
G1 X95.136 Y95.629 E.00039
; WIPE_START
G1 X95.106 Y95.745 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X95.123 Y88.112 Z6 F18000
G1 X95.147 Y77.602 Z6
G1 Z5.6
G1 E.4 F1800
; LINE_WIDTH: 0.103479
G1 F1500
M204 S6000
G1 X95.073 Y77.389 E.00087
; LINE_WIDTH: 0.150651
G1 X94.94 Y77.203 E.00143
G1 X94.836 Y77.101 E.00091
G1 X94.687 Y77.02 E.00105
; LINE_WIDTH: 0.120351
G1 X94.602 Y76.989 E.00043
; LINE_WIDTH: 0.0932844
G1 X94.517 Y76.959 E.00031
; WIPE_START
G1 X94.602 Y76.989 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X86.969 Y76.969 Z6 F18000
G1 X81.496 Y76.955 Z6
G1 Z5.6
G1 E.4 F1800
; LINE_WIDTH: 0.0897826
G1 F1500
M204 S6000
G1 X81.393 Y76.991 E.00035
; LINE_WIDTH: 0.130439
G1 X81.191 Y77.084 E.00116
; LINE_WIDTH: 0.152185
G1 X80.962 Y77.32 E.00207
G1 X80.907 Y77.434 E.0008
; LINE_WIDTH: 0.102635
G1 X80.857 Y77.598 E.00066
; CHANGE_LAYER
; Z_HEIGHT: 5.72
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F1500
G1 X80.907 Y77.434 E-.38
; WIPE_END
G1 E-.02 F1800
; layer num/total_layer_count: 47/49
; update layer progress
M73 L47
M991 S0 P46 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z6 I-1.122 J.472 P1  F18000
G1 X89.168 Y97.08 Z6
G1 Z5.72
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X88.604 Y96.915 E.01245
G1 X88.228 Y96.864 E.00803
G1 X87.856 Y96.858 E.00787
G1 X87.323 Y96.929 E.01139
G1 X86.835 Y97.088 E.01086
G1 X86.729 Y96.922 E.00416
G1 X87.079 Y96.543 E.01092
G1 X88.928 Y96.543 E.03914
G1 X89.27 Y96.916 E.01072
G1 X89.2 Y97.029 E.00282
; WIPE_START
M204 S6000
G1 X88.604 Y96.915 E-.1153
G1 X88.228 Y96.864 E-.07209
G1 X87.856 Y96.858 E-.07065
G1 X87.323 Y96.929 E-.10226
G1 X87.224 Y96.961 E-.0197
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X90.617 Y99.85 Z6.12 F18000
G1 Z5.72
M73 P95 R1
G1 E.4 F1800
G1 F1500
M204 S500
G1 X90.622 Y99.901 E.00109
G1 X90.58 Y100.36 E.00975
G1 X90.504 Y100.673 E.00683
G1 X90.393 Y100.968 E.00667
G1 X90.167 Y101.377 E.0099
G1 X89.868 Y101.741 E.00997
G1 X89.509 Y102.045 E.00995
G1 X89.102 Y102.28 E.00995
G1 X88.668 Y102.435 E.00975
G1 X88.352 Y102.498 E.00683
G1 X88.03 Y102.522 E.00683
G1 X87.58 Y102.488 E.00955
G1 X87.265 Y102.416 E.00683
G1 X86.961 Y102.307 E.00683
G1 X86.556 Y102.089 E.00975
G1 X86.188 Y101.796 E.00995
G1 X85.879 Y101.441 E.00996
G1 X85.64 Y101.039 E.0099
G1 X85.52 Y100.747 E.00667
G1 X85.434 Y100.437 E.00683
G1 X85.379 Y99.979 E.00975
G1 X85.408 Y99.51 E.00995
G1 X85.517 Y99.063 E.00975
G1 X85.639 Y98.764 E.00683
G1 X85.796 Y98.482 E.00683
G1 X86.072 Y98.125 E.00956
G1 X86.306 Y97.902 E.00683
G1 X86.558 Y97.713 E.00667
G1 X86.969 Y97.49 E.0099
G1 X87.417 Y97.345 E.00997
G1 X87.881 Y97.283 E.0099
G1 X88.196 Y97.288 E.00667
G1 X88.516 Y97.331 E.00682
G1 X88.949 Y97.458 E.00955
G1 X89.242 Y97.593 E.00683
G1 X89.516 Y97.763 E.00682
G1 X89.861 Y98.055 E.00956
G1 X90.073 Y98.298 E.00683
G1 X90.255 Y98.564 E.00683
G1 X90.455 Y98.98 E.00975
G1 X90.58 Y99.433 E.00995
G1 X90.612 Y99.79 E.00759
M204 S250
G1 X90.21 Y99.886 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X90.211 Y99.901 E.00029
G1 X90.176 Y100.292 E.00773
G1 X90.112 Y100.552 E.00526
G1 X90.021 Y100.796 E.00512
G1 X89.827 Y101.146 E.00787
G1 X89.575 Y101.452 E.0078
G1 X89.273 Y101.709 E.0078
G1 X88.929 Y101.907 E.0078
G1 X88.559 Y102.04 E.00773
G1 X88.297 Y102.091 E.00526
G1 X88.03 Y102.111 E.00526
G1 X87.641 Y102.082 E.00767
G1 X87.38 Y102.023 E.00526
G1 X87.128 Y101.932 E.00526
G1 X86.782 Y101.746 E.00773
G1 X86.472 Y101.499 E.0078
G1 X86.211 Y101.2 E.0078
G1 X86.007 Y100.856 E.00787
G1 X85.908 Y100.615 E.00512
G1 X85.837 Y100.357 E.00526
G1 X85.79 Y99.967 E.00773
G1 X85.814 Y99.571 E.0078
G1 X85.907 Y99.189 E.00773
G1 X86.009 Y98.942 E.00526
G1 X86.139 Y98.708 E.00526
G1 X86.377 Y98.4 E.00768
G1 X86.571 Y98.215 E.00526
G1 X86.779 Y98.058 E.00512
G1 X87.131 Y97.868 E.00787
G1 X87.508 Y97.745 E.0078
G1 X87.905 Y97.693 E.00787
G1 X88.165 Y97.697 E.00512
G1 X88.43 Y97.733 E.00526
G1 X88.805 Y97.842 E.00767
G1 X89.048 Y97.954 E.00526
G1 X89.275 Y98.095 E.00526
G1 X89.573 Y98.347 E.00768
G1 X89.749 Y98.549 E.00526
G1 X89.899 Y98.77 E.00526
G1 X90.07 Y99.124 E.00773
G1 X90.175 Y99.506 E.0078
G1 X90.204 Y99.827 E.00633
; WIPE_START
M204 S6000
G1 X90.211 Y99.901 E-.01416
G1 X90.176 Y100.292 E-.07469
G1 X90.112 Y100.552 E-.05084
G1 X90.021 Y100.796 E-.0495
G1 X89.827 Y101.146 E-.07598
G1 X89.575 Y101.452 E-.07538
G1 X89.417 Y101.587 E-.03946
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X86.835 Y96.119 Z6.12 F18000
G1 Z5.72
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X94.128 Y96.117 E.15437
G1 X94.415 Y96.04 E.00629
G1 X94.698 Y95.854 E.00716
G1 X94.888 Y95.614 E.0065
G1 X95.007 Y95.314 E.00682
G1 X95.013 Y94.72 E.01257
G1 X95.381 Y94.72 E.00778
G1 X95.381 Y95.565 E.01788
G1 X95.353 Y95.803 E.00508
G1 X95.28 Y96.003 E.0045
G1 X95.209 Y96.118 E.00286
G1 X95.057 Y96.279 E.0047
G1 X94.947 Y96.356 E.00285
G1 X94.751 Y96.441 E.0045
G1 X94.533 Y96.479 E.0047
G1 X89.449 Y96.483 E.10761
G1 X90.552 Y97.685 E.03454
G1 X90.795 Y98 E.00842
G1 X91.004 Y98.352 E.00867
G1 X91.089 Y98.529 E.00414
G1 X91.228 Y98.901 E.00842
G1 X91.326 Y99.3 E.00869
G1 X91.38 Y99.898 E.01271
G1 X91.328 Y100.489 E.01256
G1 X91.233 Y100.887 E.00867
G1 X91.17 Y101.073 E.00414
G1 X91.01 Y101.437 E.00842
G1 X90.807 Y101.783 E.0085
G1 X90.436 Y102.245 E.01253
G1 X90.133 Y102.522 E.00869
G1 X89.808 Y102.757 E.00849
G1 X89.448 Y102.955 E.00869
G1 X88.893 Y103.161 E.01253
G1 X88.5 Y103.243 E.00849
G1 X88.1 Y103.279 E.00849
G1 X87.699 Y103.267 E.00849
G1 X87.116 Y103.164 E.01254
G1 X86.727 Y103.032 E.00869
G1 X86.365 Y102.859 E.00849
G1 X86.026 Y102.644 E.00849
G1 X85.577 Y102.258 E.01253
G1 X85.31 Y101.947 E.00869
G1 X85.086 Y101.613 E.00849
G1 X84.904 Y101.257 E.00848
G1 X84.762 Y100.867 E.00877
G1 X84.643 Y100.3 E.01227
G1 X84.62 Y99.89 E.00869
G1 X84.645 Y99.49 E.00849
G1 X84.718 Y99.095 E.00849
G1 X84.837 Y98.711 E.00849
G1 X84.999 Y98.346 E.00847
G1 X85.213 Y97.99 E.00877
G1 X85.456 Y97.675 E.00842
G1 X86.558 Y96.482 E.0344
G1 X81.536 Y96.482 E.1063
G1 X81.204 Y96.429 E.00711
G1 X80.982 Y96.312 E.00531
G1 X80.868 Y96.21 E.00324
G1 X80.735 Y96.032 E.0047
G1 X80.649 Y95.82 E.00483
G1 X80.619 Y95.565 E.00545
G1 X80.619 Y77.628 E.37965
G1 X80.655 Y77.357 E.00578
G1 X80.761 Y77.125 E.0054
G1 X80.861 Y76.998 E.00343
G1 X80.975 Y76.896 E.00324
G1 X81.199 Y76.774 E.0054
G1 X81.458 Y76.723 E.00558
G1 X94.529 Y76.723 E.27665
G1 X94.761 Y76.763 E.00499
G1 X94.976 Y76.861 E.005
G1 X95.161 Y77.022 E.0052
G1 X95.284 Y77.208 E.0047
G1 X95.355 Y77.404 E.00441
G1 X95.378 Y77.56 E.00335
G1 X95.38 Y78.482 E.01951
G1 X95.019 Y78.482 E.00763
G1 X95.019 Y78.056 E.00901
G1 X94.983 Y77.807 E.00532
G1 X94.857 Y77.537 E.00631
G1 X94.652 Y77.307 E.00653
G1 X94.36 Y77.139 E.00713
G1 X94.087 Y77.082 E.0059
G1 X81.946 Y77.082 E.25697
G1 X81.657 Y77.133 E.00621
G1 X81.387 Y77.278 E.00648
G1 X81.171 Y77.495 E.00648
G1 X81.019 Y77.798 E.00718
G1 X80.981 Y78.056 E.00552
G1 X80.981 Y95.164 E.36211
G1 X81.05 Y95.501 E.00727
G1 X81.257 Y95.815 E.00795
G1 X81.591 Y96.049 E.00863
G1 X81.937 Y96.12 E.00748
G1 X86.775 Y96.119 E.1024
; WIPE_START
M204 S6000
G1 X88.775 Y96.119 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X85.623 Y96.891 Z6.12 F18000
G1 Z5.72
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X81.512 Y96.891 E.08086
G1 X81.197 Y96.854 E.00625
G1 X81.058 Y96.812 E.00286
G1 X80.853 Y96.716 E.00445
G1 X80.732 Y96.637 E.00283
G1 X80.565 Y96.488 E.00442
G1 X80.382 Y96.243 E.00601
G1 X80.289 Y96.043 E.00433
G1 X80.247 Y95.904 E.00287
G1 X80.21 Y95.589 E.00624
G1 X80.21 Y77.61 E.35362
G1 X80.231 Y77.374 E.00466
G1 X80.264 Y77.234 E.00283
G1 X80.349 Y77.019 E.00454
G1 X80.421 Y76.895 E.00283
G1 X80.562 Y76.716 E.00448
G1 X80.73 Y76.567 E.00442
G1 X80.924 Y76.447 E.00448
G1 X81.059 Y76.389 E.00289
G1 X81.2 Y76.347 E.00289
G1 X81.428 Y76.313 E.00454
G1 X94.564 Y76.313 E.25837
G1 X94.873 Y76.367 E.00617
G1 X95.082 Y76.45 E.00442
G1 X95.206 Y76.522 E.00283
G1 X95.387 Y76.665 E.00454
G1 X95.484 Y76.767 E.00277
G1 X95.652 Y77.023 E.00601
G1 X95.754 Y77.302 E.00585
G1 X95.787 Y77.529 E.00452
G1 X95.79 Y78.891 E.02678
G1 X94.61 Y78.891 E.0232
G1 X94.61 Y78.086 E.01584
G1 X94.587 Y77.926 E.00318
G1 X94.511 Y77.764 E.0035
G1 X94.39 Y77.629 E.00358
G1 X94.212 Y77.526 E.00404
G1 X94.045 Y77.492 E.00337
G1 X81.982 Y77.491 E.23727
G1 X81.793 Y77.524 E.00377
G1 X81.634 Y77.61 E.00355
G1 X81.507 Y77.737 E.00355
G1 X81.414 Y77.922 E.00407
G1 X81.39 Y78.086 E.00325
G1 X81.39 Y95.122 E.33509
G1 X81.435 Y95.341 E.0044
G1 X81.556 Y95.524 E.00431
G1 X81.756 Y95.665 E.00482
G1 X81.979 Y95.711 E.00446
G1 X94.074 Y95.708 E.23791
G1 X94.246 Y95.662 E.00349
G1 X94.418 Y95.549 E.00406
G1 X94.53 Y95.407 E.00356
G1 X94.599 Y95.234 E.00366
G1 X94.608 Y94.311 E.01816
G1 X95.79 Y94.311 E.02325
G1 X95.79 Y95.589 E.02513
G1 X95.754 Y95.898 E.00613
G1 X95.65 Y96.182 E.00594
G1 X95.536 Y96.368 E.0043
G1 X95.326 Y96.59 E.00601
G1 X95.147 Y96.716 E.0043
G1 X94.87 Y96.835 E.00595
G1 X94.569 Y96.888 E.00601
G1 X90.379 Y96.891 E.08241
G1 X90.865 Y97.421 E.01415
G1 X91.134 Y97.77 E.00865
G1 X91.366 Y98.159 E.00891
G1 X91.466 Y98.368 E.00457
G1 X91.62 Y98.78 E.00865
G1 X91.728 Y99.22 E.00891
G1 X91.761 Y99.437 E.00431
G1 X91.79 Y99.891 E.00896
G1 X91.783 Y100.123 E.00457
G1 X91.732 Y100.56 E.00865
G1 X91.627 Y101.001 E.0089
G1 X91.552 Y101.221 E.00457
G1 X91.375 Y101.624 E.00865
G1 X91.147 Y102.012 E.00885
G1 X90.873 Y102.372 E.00891
G1 X90.726 Y102.534 E.0043
G1 X90.392 Y102.84 E.00891
G1 X90.027 Y103.103 E.00885
G1 X89.63 Y103.322 E.00891
G1 X89.43 Y103.411 E.0043
G1 X89.001 Y103.556 E.00891
G1 X88.561 Y103.649 E.00885
G1 X88.113 Y103.689 E.00885
G1 X87.663 Y103.676 E.00885
G1 X87.215 Y103.608 E.00891
G1 X87.002 Y103.557 E.00431
G1 X86.573 Y103.412 E.00891
G1 X86.167 Y103.218 E.00885
G1 X85.787 Y102.977 E.00885
G1 X85.435 Y102.691 E.00891
G1 X85.279 Y102.539 E.0043
G1 X84.983 Y102.195 E.00891
G1 X84.733 Y101.821 E.00885
G1 X84.528 Y101.421 E.00884
G1 X84.369 Y100.986 E.00911
G1 X84.267 Y100.557 E.00865
G1 X84.236 Y100.341 E.0043
G1 X84.21 Y99.889 E.00891
G1 X84.239 Y99.44 E.00885
G1 X84.32 Y98.997 E.00885
G1 X84.453 Y98.567 E.00885
G1 X84.636 Y98.157 E.00884
G1 X84.874 Y97.759 E.00911
G1 X85.143 Y97.411 E.00865
G1 X85.583 Y96.935 E.01275
; WIPE_START
M204 S6000
G1 X83.583 Y96.913 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G17
G3 Z6.12 I1.217 J0 P1  F18000
;===================== date: 20250206 =====================

; don't support timelapse gcode in spiral_mode and by object sequence for I3 structure printer
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
G92 E0
G1 Z6.12
G1 X0 Y90 ; move to safe pos
G1 X-13.0 F3000 ; move to safe pos
M400
M1004 S5 P1  ; external shutter
M400 P300
M971 S11 C11 O0
G92 E0
G1 X0 F18000
M623

; SKIPTYPE: head_wrap_detect
M622.1 S1
M1002 judge_flag g39_3rd_layer_detect_flag
M622 J1
    ; enable nozzle clog detect at 3rd layer
    


    M622.1 S1
    M1002 judge_flag g39_detection_flag
    M622 J1
      
        M622.1 S0
        M1002 judge_flag g39_mass_exceed_flag
        M622 J1
        
            G392 S0
            M400
            G90
            M83
            M204 S5000
            G0 Z6.12 F4000
            G39.3 S1
            G0 Z6.12 F4000
            G392 S0
          
        M623
    
    M623
M623
; SKIPPABLE_END




G1 X81.441 Y96.257
G1 Z5.72
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.152184
G1 F1500
M204 S6000
G1 X81.193 Y96.113 E.0018
G1 X81.066 Y96.016 E.00101
G1 X80.844 Y95.656 E.00267
; WIPE_START
G1 X81.066 Y96.016 E-.185
G1 X81.193 Y96.113 E-.07005
G1 X81.441 Y96.257 E-.12495
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X86.613 Y97.134 Z6.12 F18000
G1 Z5.72
G1 E.4 F1800
; LINE_WIDTH: 0.470452
G1 F1500
M204 S6000
G1 X86.317 Y97.366 E.00834
; LINE_WIDTH: 0.430502
G1 X86.189 Y97.481 E.00348
; LINE_WIDTH: 0.39748
G1 X86.045 Y97.612 E.00359
; LINE_WIDTH: 0.360131
G1 X85.782 Y97.88 E.00627
G1 X85.475 Y98.285 E.00847
G1 X85.338 Y98.522 E.00457
G1 X85.194 Y98.846 E.00591
G1 X85.091 Y99.187 E.00594
G1 X85.024 Y99.536 E.00594
G1 X85.004 Y100.005 E.00783
G1 X85.065 Y100.497 E.00827
G1 X85.167 Y100.878 E.00658
G1 X85.308 Y101.218 E.00614
G1 X85.613 Y101.716 E.00974
G1 X85.918 Y102.057 E.00764
G1 X86.336 Y102.395 E.00897
G1 X86.819 Y102.657 E.00917
G1 X87.17 Y102.778 E.00618
G1 X87.536 Y102.862 E.00627
G1 X88.017 Y102.899 E.00806
G1 X88.412 Y102.871 E.0066
G1 X88.79 Y102.794 E.00643
G1 X89.284 Y102.613 E.00878
G1 X89.714 Y102.361 E.0083
G1 X90.163 Y101.98 E.00982
G1 X90.493 Y101.57 E.00878
G1 X90.741 Y101.115 E.00864
G1 X90.859 Y100.792 E.00573
G1 X90.954 Y100.423 E.00637
G1 X91.001 Y99.899 E.00876
G1 X90.95 Y99.38 E.0087
G1 X90.862 Y99.015 E.00628
G1 X90.663 Y98.529 E.00875
G1 X90.478 Y98.215 E.00608
G1 X90.119 Y97.775 E.00947
; LINE_WIDTH: 0.377324
G1 X89.944 Y97.607 E.00425
; LINE_WIDTH: 0.410071
G1 X89.743 Y97.416 E.00533
; LINE_WIDTH: 0.446968
G1 X89.565 Y97.273 E.00479
; LINE_WIDTH: 0.480017
M73 P95 R0
G1 X89.387 Y97.13 E.00517
; WIPE_START
G1 X89.565 Y97.273 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X94.541 Y96.258 Z6.12 F18000
G1 Z5.72
G1 E.4 F1800
; LINE_WIDTH: 0.150648
G1 F1500
M204 S6000
G1 X94.875 Y96.069 E.00239
G1 X95.03 Y95.882 E.00151
; LINE_WIDTH: 0.130512
G1 X95.106 Y95.746 E.00081
; LINE_WIDTH: 0.0917749
G1 X95.136 Y95.628 E.0004
; WIPE_START
G1 X95.106 Y95.746 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X95.123 Y88.113 Z6.12 F18000
G1 X95.147 Y77.602 Z6.12
G1 Z5.72
G1 E.4 F1800
; LINE_WIDTH: 0.10382
G1 F1500
M204 S6000
G1 X95.072 Y77.387 E.00089
; LINE_WIDTH: 0.150767
G1 X94.94 Y77.203 E.00141
G1 X94.833 Y77.099 E.00093
G1 X94.687 Y77.02 E.00104
; LINE_WIDTH: 0.120222
G1 X94.601 Y76.989 E.00043
; LINE_WIDTH: 0.0932455
G1 X94.516 Y76.958 E.00031
; WIPE_START
G1 X94.601 Y76.989 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X86.969 Y76.969 Z6.12 F18000
G1 X81.494 Y76.954 Z6.12
G1 Z5.72
G1 E.4 F1800
; LINE_WIDTH: 0.0929715
G1 F1500
M204 S6000
G1 X81.392 Y76.99 E.00036
; LINE_WIDTH: 0.12792
G1 X81.22 Y77.067 E.00096
; LINE_WIDTH: 0.151931
G1 X81.07 Y77.193 E.00123
G1 X80.962 Y77.32 E.00105
G1 X80.907 Y77.434 E.0008
; LINE_WIDTH: 0.102652
G1 X80.857 Y77.598 E.00066
; CHANGE_LAYER
; Z_HEIGHT: 5.84
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F1500
G1 X80.907 Y77.434 E-.38
; WIPE_END
G1 E-.02 F1800
; layer num/total_layer_count: 48/49
; update layer progress
M73 L48
M991 S0 P47 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z6.12 I-1.121 J.473 P1  F18000
G1 X89.213 Y97.113 Z6.12
G1 Z5.84
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X89.113 Y97.064 E.00235
G1 X88.604 Y96.915 E.01123
G1 X88.228 Y96.864 E.00804
G1 X87.853 Y96.858 E.00793
G1 X87.323 Y96.929 E.01133
G1 X86.835 Y97.088 E.01085
G1 X86.729 Y96.922 E.00416
G1 X87.079 Y96.543 E.01092
G1 X88.988 Y96.543 E.0404
M73 P96 R0
G1 X89.341 Y96.948 E.01137
G1 X89.249 Y97.066 E.00315
; WIPE_START
M204 S6000
G1 X89.113 Y97.064 E-.02585
G1 X88.604 Y96.915 E-.10078
G1 X88.228 Y96.864 E-.07218
G1 X87.853 Y96.858 E-.07119
G1 X87.323 Y96.929 E-.10169
G1 X87.281 Y96.943 E-.00831
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X90.617 Y99.85 Z6.24 F18000
G1 Z5.84
G1 E.4 F1800
G1 F1500
M204 S500
G1 X90.622 Y99.901 E.00108
G1 X90.58 Y100.369 E.00995
G1 X90.454 Y100.823 E.00996
G1 X90.252 Y101.241 E.00985
G1 X90.073 Y101.504 E.00673
G1 X89.861 Y101.747 E.00682
G1 X89.509 Y102.045 E.00977
G1 X89.106 Y102.277 E.00984
G1 X88.809 Y102.393 E.00673
G1 X88.497 Y102.474 E.00682
G1 X88.039 Y102.522 E.00975
G1 X87.57 Y102.487 E.00996
G1 X87.12 Y102.37 E.00984
G1 X86.828 Y102.244 E.00673
G1 X86.548 Y102.083 E.00683
G1 X86.188 Y101.796 E.00975
G1 X85.879 Y101.442 E.00995
G1 X85.643 Y101.046 E.00975
G1 X85.52 Y100.748 E.00683
G1 X85.434 Y100.437 E.00683
G1 X85.379 Y99.979 E.00975
G1 X85.408 Y99.51 E.00995
G1 X85.517 Y99.062 E.00975
G1 X85.639 Y98.764 E.00683
G1 X85.796 Y98.482 E.00683
G1 X86.078 Y98.118 E.00975
G1 X86.42 Y97.809 E.00975
G1 X86.69 Y97.632 E.00683
G1 X86.978 Y97.487 E.00683
G1 X87.417 Y97.345 E.00976
G1 X87.878 Y97.283 E.00984
G1 X88.196 Y97.288 E.00673
G1 X88.516 Y97.331 E.00683
G1 X88.958 Y97.46 E.00975
G1 X89.37 Y97.666 E.00975
G1 X89.633 Y97.852 E.00683
G1 X89.87 Y98.065 E.00673
G1 X90.166 Y98.424 E.00985
G1 X90.391 Y98.826 E.00976
G1 X90.504 Y99.128 E.00683
G1 X90.58 Y99.442 E.00683
G1 X90.612 Y99.79 E.0074
M204 S250
G1 X90.21 Y99.887 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X90.211 Y99.901 E.00028
G1 X90.175 Y100.296 E.0078
G1 X90.07 Y100.678 E.0078
G1 X89.897 Y101.036 E.00782
G1 X89.749 Y101.253 E.00517
G1 X89.573 Y101.454 E.00526
G1 X89.272 Y101.709 E.00774
G1 X88.928 Y101.907 E.00782
G1 X88.683 Y102.003 E.00517
G1 X88.424 Y102.07 E.00526
G1 X88.033 Y102.111 E.00774
G1 X87.638 Y102.082 E.0078
G1 X87.253 Y101.981 E.00782
G1 X87.011 Y101.878 E.00517
G1 X86.78 Y101.744 E.00526
G1 X86.472 Y101.499 E.00774
G1 X86.211 Y101.2 E.0078
G1 X86.01 Y100.863 E.00773
G1 X85.908 Y100.615 E.00526
G1 X85.837 Y100.357 E.00526
G1 X85.79 Y99.967 E.00773
G1 X85.814 Y99.571 E.0078
G1 X85.907 Y99.189 E.00774
G1 X86.008 Y98.942 E.00526
G1 X86.139 Y98.708 E.00526
G1 X86.379 Y98.397 E.00773
G1 X86.671 Y98.134 E.00774
G1 X86.895 Y97.987 E.00526
G1 X87.134 Y97.867 E.00526
G1 X87.508 Y97.745 E.00774
G1 X87.902 Y97.693 E.00782
G1 X88.165 Y97.697 E.00517
G1 X88.43 Y97.733 E.00526
G1 X88.808 Y97.843 E.00773
G1 X89.159 Y98.019 E.00773
G1 X89.378 Y98.173 E.00526
G1 X89.574 Y98.349 E.00518
G1 X89.827 Y98.655 E.00782
G1 X90.018 Y98.999 E.00773
G1 X90.112 Y99.249 E.00526
G1 X90.176 Y99.509 E.00526
G1 X90.204 Y99.827 E.00627
; WIPE_START
M204 S6000
G1 X90.211 Y99.901 E-.01414
G1 X90.175 Y100.296 E-.0753
G1 X90.07 Y100.678 E-.07535
G1 X89.897 Y101.036 E-.07553
G1 X89.749 Y101.253 E-.04999
G1 X89.573 Y101.454 E-.05081
G1 X89.416 Y101.587 E-.03888
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X86.835 Y96.119 Z6.24 F18000
G1 Z5.84
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X94.128 Y96.117 E.15437
G1 X94.406 Y96.043 E.00609
G1 X94.667 Y95.882 E.00649
G1 X94.885 Y95.623 E.00717
G1 X95.007 Y95.315 E.00702
G1 X95.013 Y94.72 E.01258
G1 X95.38 Y94.72 E.00776
G1 X95.378 Y95.633 E.01933
G1 X95.338 Y95.861 E.0049
G1 X95.288 Y95.987 E.00286
G1 X95.168 Y96.17 E.00464
G1 X95.064 Y96.274 E.00311
G1 X94.947 Y96.356 E.00304
G1 X94.751 Y96.441 E.0045
G1 X94.533 Y96.479 E.0047
G1 X89.498 Y96.483 E.10657
G1 X90.683 Y97.844 E.0382
G1 X91 Y98.345 E.01255
G1 X91.167 Y98.72 E.00869
G1 X91.326 Y99.3 E.01273
G1 X91.38 Y99.898 E.01272
G1 X91.328 Y100.489 E.01255
G1 X91.172 Y101.069 E.0127
G1 X91.01 Y101.437 E.00852
G1 X90.807 Y101.783 E.0085
G1 X90.436 Y102.245 E.01254
G1 X90.134 Y102.522 E.00867
G1 X89.801 Y102.761 E.00868
G1 X89.448 Y102.955 E.00851
G1 X88.893 Y103.161 E.01254
G1 X88.5 Y103.243 E.0085
G1 X88.1 Y103.279 E.00849
G1 X87.699 Y103.267 E.00849
G1 X87.116 Y103.164 E.01254
G1 X86.727 Y103.032 E.00869
G1 X86.365 Y102.859 E.00849
G1 X86.026 Y102.644 E.00849
G1 X85.577 Y102.258 E.01254
G1 X85.31 Y101.947 E.00869
G1 X85.086 Y101.613 E.00849
G1 X84.904 Y101.256 E.00848
G1 X84.763 Y100.872 E.00868
G1 X84.643 Y100.3 E.01236
G1 X84.62 Y99.89 E.00869
G1 X84.645 Y99.49 E.00849
G1 X84.718 Y99.095 E.00849
G1 X84.837 Y98.711 E.00849
G1 X85 Y98.346 E.00848
G1 X85.21 Y97.994 E.00868
G1 X85.456 Y97.675 E.00851
G1 X86.558 Y96.482 E.0344
G1 X81.536 Y96.482 E.1063
G1 X81.205 Y96.429 E.00709
G1 X80.982 Y96.311 E.00534
G1 X80.8 Y96.133 E.00539
G1 X80.72 Y96.003 E.00324
G1 X80.647 Y95.803 E.0045
G1 X80.619 Y95.565 E.00508
G1 X80.619 Y77.628 E.37965
G1 X80.657 Y77.349 E.00596
G1 X80.766 Y77.118 E.0054
G1 X80.93 Y76.932 E.00526
G1 X81.061 Y76.84 E.00338
G1 X81.207 Y76.772 E.00343
G1 X81.458 Y76.723 E.0054
G1 X94.53 Y76.723 E.27669
G1 X94.761 Y76.763 E.00495
G1 X94.983 Y76.866 E.00518
G1 X95.166 Y77.03 E.00521
G1 X95.283 Y77.208 E.00451
G1 X95.356 Y77.407 E.0045
G1 X95.378 Y77.559 E.00325
G1 X95.38 Y78.482 E.01952
G1 X95.019 Y78.482 E.00763
G1 X95.019 Y78.055 E.00902
G1 X94.983 Y77.806 E.00533
G1 X94.857 Y77.537 E.0063
G1 X94.659 Y77.315 E.00629
G1 X94.398 Y77.154 E.00649
G1 X94.096 Y77.082 E.00658
G1 X81.955 Y77.082 E.25697
G1 X81.696 Y77.12 E.00553
G1 X81.394 Y77.271 E.00716
G1 X81.171 Y77.495 E.00669
G1 X81.019 Y77.798 E.00717
G1 X80.981 Y78.056 E.00552
G1 X80.981 Y95.164 E.36211
G1 X81.05 Y95.501 E.00727
G1 X81.257 Y95.815 E.00795
G1 X81.591 Y96.049 E.00864
G1 X81.937 Y96.12 E.00747
G1 X86.775 Y96.119 E.1024
; WIPE_START
M204 S6000
G1 X88.775 Y96.119 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X85.623 Y96.891 Z6.24 F18000
G1 Z5.84
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X81.512 Y96.891 E.08086
G1 X81.197 Y96.854 E.00625
G1 X81.059 Y96.813 E.00283
G1 X80.853 Y96.716 E.00448
G1 X80.732 Y96.637 E.00283
G1 X80.56 Y96.484 E.00454
G1 X80.468 Y96.373 E.00283
G1 X80.35 Y96.182 E.00442
G1 X80.246 Y95.898 E.00594
G1 X80.21 Y95.589 E.00613
G1 X80.21 Y77.61 E.35362
G1 X80.231 Y77.374 E.00466
G1 X80.265 Y77.231 E.00289
G1 X80.316 Y77.09 E.00295
G1 X80.423 Y76.893 E.00442
G1 X80.564 Y76.714 E.00448
G1 X80.671 Y76.613 E.00289
G1 X80.855 Y76.484 E.00442
G1 X81.062 Y76.388 E.00448
G1 X81.202 Y76.346 E.00289
G1 X81.428 Y76.313 E.00448
G1 X94.566 Y76.313 E.25841
G1 X94.873 Y76.367 E.00613
G1 X95.082 Y76.45 E.00442
G1 X95.209 Y76.523 E.00288
G1 X95.329 Y76.613 E.00295
G1 X95.485 Y76.77 E.00436
G1 X95.652 Y77.023 E.00595
G1 X95.755 Y77.307 E.00594
G1 X95.787 Y77.529 E.00443
G1 X95.79 Y78.891 E.02678
G1 X94.61 Y78.891 E.0232
G1 X94.61 Y78.085 E.01584
G1 X94.586 Y77.925 E.00319
G1 X94.511 Y77.764 E.00349
G1 X94.393 Y77.632 E.00348
G1 X94.24 Y77.537 E.00355
G1 X94.048 Y77.492 E.00388
G1 X81.985 Y77.491 E.23727
G1 X81.821 Y77.515 E.00325
G1 X81.637 Y77.608 E.00406
G1 X81.507 Y77.738 E.00362
G1 X81.414 Y77.922 E.00407
G1 X81.39 Y78.086 E.00325
G1 X81.39 Y95.122 E.3351
G1 X81.435 Y95.341 E.00439
G1 X81.556 Y95.524 E.00431
G1 X81.757 Y95.665 E.00482
G1 X81.979 Y95.711 E.00446
G1 X94.074 Y95.708 E.23791
G1 X94.242 Y95.663 E.00343
G1 X94.396 Y95.568 E.00355
G1 X94.529 Y95.41 E.00407
G1 X94.599 Y95.234 E.00372
G1 X94.608 Y94.311 E.01816
G1 X95.79 Y94.311 E.02324
G1 X95.788 Y95.67 E.02672
G1 X95.734 Y95.974 E.00607
G1 X95.653 Y96.177 E.0043
G1 X95.487 Y96.429 E.00595
G1 X95.329 Y96.589 E.00442
G1 X95.147 Y96.716 E.00436
G1 X94.87 Y96.835 E.00594
G1 X94.569 Y96.888 E.00601
G1 X90.396 Y96.891 E.08208
G1 X91.004 Y97.59 E.01821
G1 X91.137 Y97.774 E.00448
G1 X91.364 Y98.156 E.00874
G1 X91.549 Y98.57 E.00891
G1 X91.619 Y98.777 E.0043
G1 X91.728 Y99.22 E.00897
G1 X91.761 Y99.437 E.00431
G1 X91.79 Y99.891 E.00896
G1 X91.783 Y100.119 E.00447
G1 X91.732 Y100.561 E.00875
G1 X91.627 Y101.001 E.0089
G1 X91.554 Y101.216 E.00448
G1 X91.375 Y101.624 E.00875
G1 X91.147 Y102.012 E.00885
G1 X90.873 Y102.372 E.00891
G1 X90.726 Y102.534 E.0043
G1 X90.392 Y102.84 E.00891
G1 X90.019 Y103.107 E.00902
G1 X89.63 Y103.322 E.00874
G1 X89.43 Y103.411 E.00431
G1 X89.001 Y103.556 E.00891
G1 X88.561 Y103.649 E.00885
G1 X88.113 Y103.689 E.00885
G1 X87.663 Y103.676 E.00885
G1 X87.215 Y103.608 E.00891
G1 X87.002 Y103.557 E.0043
G1 X86.573 Y103.412 E.00891
G1 X86.167 Y103.218 E.00885
G1 X85.787 Y102.977 E.00885
G1 X85.435 Y102.691 E.00891
G1 X85.279 Y102.538 E.00431
G1 X84.984 Y102.195 E.00891
G1 X84.733 Y101.821 E.00885
G1 X84.528 Y101.421 E.00884
G1 X84.37 Y100.99 E.00902
G1 X84.268 Y100.558 E.00874
G1 X84.236 Y100.341 E.0043
G1 X84.21 Y99.889 E.00891
G1 X84.239 Y99.44 E.00885
G1 X84.32 Y98.997 E.00885
G1 X84.453 Y98.567 E.00885
G1 X84.636 Y98.156 E.00884
G1 X84.871 Y97.763 E.00902
G1 X85.143 Y97.411 E.00874
G1 X85.583 Y96.935 E.01275
; WIPE_START
M204 S6000
G1 X83.583 Y96.913 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G17
G3 Z6.24 I1.217 J0 P1  F18000
;===================== date: 20250206 =====================

; don't support timelapse gcode in spiral_mode and by object sequence for I3 structure printer
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
G92 E0
G1 Z6.24
G1 X0 Y90 ; move to safe pos
G1 X-13.0 F3000 ; move to safe pos
M400
M1004 S5 P1  ; external shutter
M400 P300
M971 S11 C11 O0
G92 E0
G1 X0 F18000
M623

; SKIPTYPE: head_wrap_detect
M622.1 S1
M1002 judge_flag g39_3rd_layer_detect_flag
M622 J1
    ; enable nozzle clog detect at 3rd layer
    


    M622.1 S1
    M1002 judge_flag g39_detection_flag
    M622 J1
      
        M622.1 S0
        M1002 judge_flag g39_mass_exceed_flag
        M622 J1
        
            G392 S0
            M400
            G90
            M83
            M204 S5000
            G0 Z6.24 F4000
            G39.3 S1
            G0 Z6.24 F4000
            G392 S0
          
        M623
    
    M623
M623
; SKIPPABLE_END




G1 X81.45 Y96.255
G1 Z5.84
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.146549
G1 F1500
M204 S6000
G1 X81.193 Y96.113 E.00177
G1 X81.054 Y96.006 E.00105
G1 X80.969 Y95.88 E.00092
G1 X80.85 Y95.643 E.0016
; WIPE_START
G1 X80.969 Y95.88 E-.11378
G1 X81.054 Y96.006 E-.06518
G1 X81.193 Y96.113 E-.07486
G1 X81.45 Y96.255 E-.12618
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X86.751 Y97.351 Z6.24 F18000
G1 Z5.84
G1 E.4 F1800
; LINE_WIDTH: 0.397059
G1 F1500
M204 S6000
G1 X86.475 Y97.284 E.00526
; LINE_WIDTH: 0.435241
G1 X86.452 Y97.279 E.00049
; LINE_WIDTH: 0.449086
G1 X86.429 Y97.274 E.0005
G1 X86.185 Y97.481 E.00676
; LINE_WIDTH: 0.406615
G1 X86.164 Y97.501 E.00054
; LINE_WIDTH: 0.365017
G1 X85.747 Y97.922 E.01002
G1 X85.488 Y98.264 E.00727
G1 X85.303 Y98.591 E.00636
G1 X85.162 Y98.934 E.00628
G1 X85.091 Y99.187 E.00443
G1 X85.032 Y99.469 E.00488
G1 X85.003 Y99.889 E.00713
; LINE_WIDTH: 0.359349
G1 X85.067 Y100.522 E.01058
G1 X85.16 Y100.861 E.00585
G1 X85.311 Y101.226 E.00658
G1 X85.612 Y101.714 E.00954
G1 X85.965 Y102.104 E.00876
G1 X86.346 Y102.401 E.00804
G1 X86.65 Y102.577 E.00584
G1 X86.987 Y102.72 E.00609
G1 X87.372 Y102.831 E.00667
G1 X87.733 Y102.884 E.00607
G1 X88.089 Y102.899 E.00593
G1 X88.553 Y102.847 E.00776
G1 X88.916 Y102.753 E.00625
G1 X89.258 Y102.623 E.00609
G1 X89.596 Y102.437 E.00642
G1 X89.889 Y102.225 E.00602
G1 X90.132 Y102.005 E.00545
G1 X90.365 Y101.742 E.00584
G1 X90.572 Y101.441 E.00609
G1 X90.667 Y101.264 E.00333
G1 X90.809 Y100.94 E.00589
G1 X90.955 Y100.423 E.00894
G1 X90.996 Y99.915 E.00848
G1 X90.973 Y99.525 E.00652
G1 X90.862 Y99.002 E.00888
G1 X90.659 Y98.522 E.00868
M73 P97 R0
G1 X90.483 Y98.225 E.00574
G1 X90.135 Y97.793 E.00923
; LINE_WIDTH: 0.382794
G1 X89.876 Y97.53 E.00658
; LINE_WIDTH: 0.426997
G1 X89.751 Y97.417 E.00337
; LINE_WIDTH: 0.468092
G1 X89.625 Y97.304 E.00372
G1 X89.603 Y97.308 E.00051
; LINE_WIDTH: 0.442833
G1 X89.444 Y97.338 E.00337
; LINE_WIDTH: 0.416078
G1 X89.284 Y97.367 E.00316
; WIPE_START
G1 X89.444 Y97.338 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X94.529 Y96.242 Z6.24 F18000
G1 Z5.84
G1 E.4 F1800
; LINE_WIDTH: 0.104112
G1 F1500
M204 S6000
G1 X94.675 Y96.186 E.00061
; LINE_WIDTH: 0.149222
G1 X94.853 Y96.083 E.00127
G1 X94.949 Y95.988 E.00083
G1 X95.086 Y95.79 E.00148
; LINE_WIDTH: 0.0961272
G1 X95.141 Y95.618 E.00063
; WIPE_START
G1 X95.086 Y95.79 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X95.111 Y88.157 Z6.24 F18000
G1 X95.147 Y77.602 Z6.24
G1 Z5.84
G1 E.4 F1800
; LINE_WIDTH: 0.103852
G1 F1500
M204 S6000
G1 X95.072 Y77.387 E.00089
; LINE_WIDTH: 0.150899
G1 X94.946 Y77.211 E.00135
G1 X94.844 Y77.109 E.0009
G1 X94.687 Y77.02 E.00113
; LINE_WIDTH: 0.119614
G1 X94.608 Y76.99 E.00039
; LINE_WIDTH: 0.0930378
G1 X94.53 Y76.96 E.00028
; WIPE_START
G1 X94.608 Y76.99 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X86.976 Y76.97 Z6.24 F18000
G1 X81.504 Y76.955 Z6.24
G1 Z5.84
G1 E.4 F1800
; LINE_WIDTH: 0.0997708
G1 F1500
M204 S6000
G1 X81.349 Y77.002 E.0006
; LINE_WIDTH: 0.149338
G1 X81.229 Y77.058 E.00082
G1 X81.113 Y77.151 E.00092
G1 X80.935 Y77.367 E.00173
; LINE_WIDTH: 0.125722
G1 X80.89 Y77.482 E.00061
; LINE_WIDTH: 0.0974392
G1 X80.857 Y77.598 E.00043
; CHANGE_LAYER
; Z_HEIGHT: 5.96
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F1500
G1 X80.89 Y77.482 E-.38
; WIPE_END
G1 E-.02 F1800
; layer num/total_layer_count: 49/49
; update layer progress
M73 L49
M991 S0 P48 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z6.24 I-1.124 J.467 P1  F18000
G1 X90.21 Y99.886 Z6.24
G1 Z5.96
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X90.211 Y99.904 E.00035
G1 X90.176 Y100.293 E.00767
G1 X90.112 Y100.552 E.00525
G1 X90.019 Y100.801 E.00523
G1 X89.827 Y101.146 E.00777
G1 X89.575 Y101.453 E.00781
G1 X89.275 Y101.707 E.00773
G1 X89.047 Y101.847 E.00526
G1 X88.805 Y101.96 E.00525
G1 X88.427 Y102.07 E.00774
G1 X88.033 Y102.111 E.0078
G1 X87.638 Y102.082 E.0078
G1 X87.255 Y101.982 E.00777
G1 X87.011 Y101.878 E.00522
G1 X86.781 Y101.745 E.00523
G1 X86.472 Y101.499 E.00777
G1 X86.211 Y101.2 E.0078
G1 X86.009 Y100.861 E.00777
G1 X85.908 Y100.616 E.00522
G1 X85.838 Y100.359 E.00523
G1 X85.79 Y99.967 E.00777
G1 X85.814 Y99.571 E.0078
G1 X85.908 Y99.186 E.0078
G1 X86.068 Y98.827 E.00774
G1 X86.212 Y98.601 E.00526
G1 X86.38 Y98.397 E.00519
G1 X86.571 Y98.215 E.0052
G1 X86.783 Y98.055 E.00522
G1 X87.131 Y97.868 E.00777
G1 X87.508 Y97.745 E.0078
G1 X87.9 Y97.693 E.00777
G1 X88.165 Y97.697 E.00522
G1 X88.43 Y97.733 E.00526
G1 X88.808 Y97.843 E.00774
G1 X89.161 Y98.02 E.00777
G1 X89.378 Y98.173 E.00522
G1 X89.575 Y98.35 E.00522
G1 X89.827 Y98.655 E.00777
G1 X90.02 Y99.002 E.0078
G1 X90.147 Y99.374 E.00773
G1 X90.195 Y99.637 E.00526
G1 X90.206 Y99.827 E.00374
; WIPE_START
M204 S6000
G1 X90.211 Y99.904 E-.01479
G1 X90.176 Y100.293 E-.0741
G1 X90.112 Y100.552 E-.05074
G1 X90.019 Y100.801 E-.05052
G1 X89.827 Y101.146 E-.07503
G1 X89.575 Y101.453 E-.07541
G1 X89.417 Y101.587 E-.03942
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X85.604 Y96.891 Z6.36 F18000
G1 Z5.96
G1 E.4 F1800
G1 F1500
M204 S500
G1 X81.512 Y96.891 E.08049
G1 X81.197 Y96.854 E.00625
G1 X81.061 Y96.813 E.0028
G1 X80.853 Y96.716 E.00451
G1 X80.732 Y96.637 E.00283
G1 X80.562 Y96.486 E.00448
G1 X80.421 Y96.307 E.00448
G1 X80.351 Y96.185 E.00277
G1 X80.246 Y95.898 E.00601
G1 X80.21 Y95.589 E.00613
G1 X80.21 Y77.61 E.35362
G1 X80.231 Y77.374 E.00466
G1 X80.264 Y77.234 E.00283
G1 X80.349 Y77.019 E.00454
G1 X80.422 Y76.892 E.00289
G1 X80.51 Y76.774 E.00289
G1 X80.671 Y76.613 E.00448
G1 X80.855 Y76.484 E.00442
G1 X81.062 Y76.388 E.00448
G1 X81.201 Y76.347 E.00285
G1 X81.428 Y76.313 E.00452
G1 X94.567 Y76.313 E.25844
G1 X94.873 Y76.367 E.0061
G1 X95.081 Y76.45 E.00442
G1 X95.209 Y76.523 E.00289
G1 X95.327 Y76.612 E.00291
G1 X95.485 Y76.77 E.00439
G1 X95.652 Y77.023 E.00595
G1 X95.755 Y77.307 E.00594
G1 X95.787 Y77.529 E.00443
G1 X95.79 Y78.891 E.02678
G1 X94.61 Y78.891 E.0232
G1 X94.61 Y78.086 E.01584
G1 X94.587 Y77.925 E.00318
G1 X94.51 Y77.762 E.00355
G1 X94.368 Y77.611 E.00407
G1 X94.209 Y77.526 E.00355
G1 X94.045 Y77.492 E.00331
G1 X81.982 Y77.491 E.23727
G1 X81.793 Y77.524 E.00376
G1 X81.634 Y77.61 E.00355
G1 X81.507 Y77.737 E.00355
G1 X81.414 Y77.922 E.00407
G1 X81.39 Y78.086 E.00325
G1 X81.39 Y95.122 E.3351
G1 X81.435 Y95.341 E.00439
G1 X81.556 Y95.524 E.00432
G1 X81.757 Y95.665 E.00483
G1 X81.979 Y95.711 E.00446
G1 X94.077 Y95.708 E.23797
G1 X94.272 Y95.65 E.004
G1 X94.42 Y95.546 E.00355
G1 X94.53 Y95.407 E.00349
G1 X94.599 Y95.235 E.00365
G1 X94.608 Y94.311 E.01817
G1 X95.79 Y94.311 E.02325
G1 X95.79 Y95.589 E.02513
G1 X95.754 Y95.898 E.00613
G1 X95.651 Y96.182 E.00594
G1 X95.536 Y96.368 E.0043
G1 X95.326 Y96.59 E.00601
G1 X95.147 Y96.716 E.0043
G1 X94.87 Y96.835 E.00595
G1 X94.569 Y96.888 E.00601
G1 X90.396 Y96.891 E.08208
G1 X91.004 Y97.59 E.01821
G1 X91.132 Y97.767 E.00431
G1 X91.366 Y98.159 E.00897
G1 X91.462 Y98.36 E.00438
G1 X91.62 Y98.78 E.00884
G1 X91.727 Y99.217 E.00885
G1 X91.783 Y99.667 E.00891
G1 X91.79 Y99.888 E.00436
G1 X91.784 Y100.111 E.00437
G1 X91.732 Y100.56 E.00891
G1 X91.627 Y100.998 E.00885
G1 X91.471 Y101.423 E.00891
G1 X91.375 Y101.624 E.00438
G1 X91.147 Y102.012 E.00883
G1 X90.873 Y102.372 E.00891
G1 X90.726 Y102.534 E.00431
G1 X90.392 Y102.84 E.00891
G1 X90.024 Y103.105 E.00891
G1 X89.832 Y103.218 E.00438
G1 X89.427 Y103.412 E.00883
G1 X89.001 Y103.556 E.00885
G1 X88.561 Y103.649 E.00885
G1 X88.113 Y103.689 E.00885
G1 X87.663 Y103.676 E.00885
G1 X87.215 Y103.608 E.00891
G1 X87.002 Y103.557 E.00431
G1 X86.573 Y103.412 E.00891
G1 X86.168 Y103.218 E.00884
G1 X85.976 Y103.105 E.00438
G1 X85.608 Y102.84 E.00891
G1 X85.277 Y102.536 E.00885
G1 X84.984 Y102.195 E.00885
G1 X84.733 Y101.821 E.00885
G1 X84.527 Y101.417 E.00893
G1 X84.373 Y100.999 E.00876
G1 X84.314 Y100.784 E.00438
G1 X84.236 Y100.338 E.00891
G1 X84.21 Y99.889 E.00885
G1 X84.239 Y99.44 E.00884
G1 X84.32 Y98.997 E.00885
G1 X84.453 Y98.567 E.00885
G1 X84.637 Y98.153 E.00891
G1 X84.746 Y97.959 E.00438
G1 X84.998 Y97.588 E.00884
G1 X85.565 Y96.936 E.01698
; WIPE_START
M204 S6000
G1 X83.565 Y96.914 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G17
G3 Z6.36 I1.217 J0 P1  F18000
;===================== date: 20250206 =====================

; don't support timelapse gcode in spiral_mode and by object sequence for I3 structure printer
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
G92 E0
G1 Z6.36
G1 X0 Y90 ; move to safe pos
G1 X-13.0 F3000 ; move to safe pos
M400
M1004 S5 P1  ; external shutter
M400 P300
M971 S11 C11 O0
G92 E0
G1 X0 F18000
M623

; SKIPTYPE: head_wrap_detect
M622.1 S1
M1002 judge_flag g39_3rd_layer_detect_flag
M622 J1
    ; enable nozzle clog detect at 3rd layer
    


    M622.1 S1
    M1002 judge_flag g39_detection_flag
    M622 J1
      
        M622.1 S0
        M1002 judge_flag g39_mass_exceed_flag
        M622 J1
        
            G392 S0
            M400
            G90
            M83
            M204 S5000
            G0 Z6.36 F4000
            G39.3 S1
            G0 Z6.36 F4000
            G392 S0
          
        M623
    
    M623
M623
; SKIPPABLE_END




G1 X95.554 Y77.435
G1 Z5.96
G1 E.4 F1800
; FEATURE: Top surface
G1 F1500
M204 S2000
G1 X94.672 Y76.552 E.02455
G1 X94.093 Y76.53
G1 X95.571 Y78.009 E.04113
G1 X94.735 Y77.73
G1 X95.572 Y78.567 E.0233
; WIPE_START
M204 S6000
G1 X94.735 Y77.73 E-.2251
G1 X95.508 Y77.988 E-.1549
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X94.372 Y77.367 Z6.36 F18000
G1 Z5.96
G1 E.4 F1800
G1 F1500
M204 S2000
G1 X93.535 Y76.53 E.02327
G1 X92.978 Y76.53
G1 X93.722 Y77.275 E.02071
G1 X93.165 Y77.275
G1 X92.42 Y76.53 E.02071
G1 X91.862 Y76.53
G1 X92.607 Y77.275 E.02071
G1 X92.049 Y77.275
G1 X91.305 Y76.53 E.02071
G1 X90.747 Y76.53
G1 X91.492 Y77.275 E.02071
G1 X90.934 Y77.275
G1 X90.19 Y76.53 E.02071
G1 X89.632 Y76.53
G1 X90.377 Y77.275 E.0207
G1 X89.819 Y77.275
G1 X89.075 Y76.53 E.0207
G1 X88.517 Y76.53
G1 X89.262 Y77.274 E.0207
G1 X88.704 Y77.274
G1 X87.96 Y76.53 E.0207
G1 X87.402 Y76.53
G1 X88.146 Y77.274 E.0207
G1 X87.589 Y77.274
G1 X86.845 Y76.53 E.0207
G1 X86.287 Y76.53
G1 X87.031 Y77.274 E.0207
G1 X86.474 Y77.274
G1 X85.73 Y76.53 E.0207
G1 X85.172 Y76.53
G1 X85.916 Y77.274 E.0207
G1 X85.358 Y77.274
G1 X84.614 Y76.53 E.0207
G1 X84.057 Y76.53
G1 X84.801 Y77.274 E.02069
G1 X84.243 Y77.274
G1 X83.499 Y76.53 E.02069
G1 X82.942 Y76.53
G1 X83.686 Y77.274 E.02069
G1 X83.128 Y77.274
G1 X82.384 Y76.53 E.02069
G1 X81.827 Y76.53
G1 X82.571 Y77.274 E.02069
G1 X82.013 Y77.274
G1 X81.292 Y76.553 E.02007
G1 X80.9 Y76.718
G1 X81.576 Y77.395 E.01882
G1 X81.297 Y77.673
G1 X80.617 Y76.993 E.01889
G1 X80.451 Y77.385
G1 X81.173 Y78.107 E.02009
G1 X81.173 Y78.664
G1 X80.427 Y77.918 E.02076
G1 X80.427 Y78.476
G1 X81.173 Y79.222 E.02076
G1 X81.173 Y79.779
G1 X80.427 Y79.033 E.02076
G1 X80.427 Y79.591
G1 X81.173 Y80.337 E.02076
G1 X81.173 Y80.894
G1 X80.427 Y80.148 E.02076
G1 X80.427 Y80.706
G1 X81.173 Y81.452 E.02076
G1 X81.173 Y82.01
G1 X80.427 Y81.263 E.02076
G1 X80.427 Y81.821
G1 X81.173 Y82.567 E.02076
G1 X81.173 Y83.125
G1 X80.427 Y82.378 E.02076
G1 X80.427 Y82.936
G1 X81.173 Y83.682 E.02076
G1 X81.173 Y84.24
G1 X80.427 Y83.493 E.02076
G1 X80.427 Y84.051
G1 X81.173 Y84.797 E.02076
G1 X81.173 Y85.355
G1 X80.427 Y84.608 E.02076
G1 X80.427 Y85.166
G1 X81.173 Y85.912 E.02076
G1 X81.173 Y86.47
G1 X80.427 Y85.724 E.02076
G1 X80.427 Y86.281
G1 X81.173 Y87.027 E.02076
G1 X81.173 Y87.585
G1 X80.427 Y86.839 E.02076
G1 X80.427 Y87.396
G1 X81.173 Y88.142 E.02076
G1 X81.173 Y88.7
G1 X80.427 Y87.954 E.02076
G1 X80.427 Y88.511
G1 X81.173 Y89.258 E.02076
G1 X81.173 Y89.815
G1 X80.427 Y89.069 E.02076
G1 X80.427 Y89.626
G1 X81.173 Y90.373 E.02076
G1 X81.173 Y90.93
G1 X80.427 Y90.184 E.02076
G1 X80.427 Y90.741
G1 X81.173 Y91.488 E.02076
G1 X81.173 Y92.045
G1 X80.427 Y91.299 E.02076
G1 X80.427 Y91.856
G1 X81.173 Y92.603 E.02076
G1 X81.173 Y93.16
G1 X80.427 Y92.414 E.02076
G1 X80.427 Y92.972
G1 X81.173 Y93.718 E.02076
G1 X81.173 Y94.275
G1 X80.427 Y93.529 E.02076
G1 X80.427 Y94.087
G1 X81.173 Y94.833 E.02076
G1 X81.275 Y95.493
G1 X80.427 Y94.644 E.0236
; WIPE_START
M204 S6000
G1 X81.275 Y95.493 E-.228
G1 X81.173 Y94.833 E-.12684
G1 X81.08 Y94.739 E-.02516
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X88.711 Y94.631 Z6.36 F18000
G1 X94.822 Y94.544 Z6.36
G1 Z5.96
G1 E.4 F1800
G1 F1500
M204 S2000
G1 X95.573 Y95.294 E.02088
G1 X95.544 Y95.823
G1 X94.817 Y95.096 E.02023
G1 X94.702 Y95.539
G1 X95.377 Y96.213 E.01875
G1 X95.094 Y96.488
G1 X94.418 Y95.812 E.0188
G1 X93.974 Y95.925
G1 X94.695 Y96.646 E.02006
G1 X94.163 Y96.672
G1 X93.416 Y95.925 E.02077
G1 X92.859 Y95.925
G1 X93.606 Y96.672 E.02078
G1 X93.048 Y96.673
G1 X92.301 Y95.925 E.02078
G1 X91.744 Y95.926
G1 X92.491 Y96.673 E.02079
G1 X91.934 Y96.673
G1 X91.186 Y95.926 E.0208
G1 X90.629 Y95.926
G1 X91.377 Y96.674 E.0208
G1 X90.82 Y96.674
G1 X90.072 Y95.926 E.02081
G1 X89.514 Y95.926
G1 X90.263 Y96.674 E.02082
; WIPE_START
M204 S6000
G1 X89.514 Y95.926 E-.20111
G1 X90.072 Y95.926 E-.10591
G1 X90.343 Y96.198 E-.07298
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X91 Y97.97 Z6.36 F18000
G1 Z5.96
G1 E.4 F1800
G1 F1500
M204 S2000
M73 P98 R0
G1 X88.957 Y95.926 E.05685
G1 X88.399 Y95.926
G1 X91.444 Y98.97 E.08468
G1 X91.562 Y99.646
G1 X87.842 Y95.926 E.10347
G1 X87.285 Y95.927
G1 X89.11 Y97.752 E.05077
G1 X88.296 Y97.496
G1 X86.727 Y95.927 E.04364
G1 X86.17 Y95.927
G1 X87.739 Y97.496 E.04364
G1 X87.278 Y97.592
G1 X85.612 Y95.927 E.04633
G1 X85.802 Y96.674
G1 X85.055 Y95.927 E.02078
G1 X84.498 Y95.927
G1 X85.244 Y96.674 E.02078
G1 X84.687 Y96.674
G1 X83.94 Y95.927 E.02077
G1 X83.383 Y95.927
G1 X84.129 Y96.674 E.02077
G1 X83.572 Y96.674
G1 X82.825 Y95.928 E.02077
G1 X82.268 Y95.928
G1 X83.014 Y96.674 E.02076
G1 X82.457 Y96.674
G1 X81.609 Y95.827 E.02358
G1 X81.899 Y96.674
G1 X80.427 Y95.202 E.04096
G1 X80.451 Y95.783
G1 X81.317 Y96.65 E.0241
; WIPE_START
M204 S6000
G1 X80.451 Y95.783 E-.23278
G1 X80.427 Y95.202 E-.11063
G1 X80.563 Y95.338 E-.03659
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X85.951 Y96.823 Z6.36 F18000
G1 Z5.96
G1 E.4 F1800
G1 F1500
M204 S2000
G1 X86.883 Y97.755 E.02593
G1 X86.538 Y97.968
G1 X85.692 Y97.121 E.02356
G1 X85.432 Y97.419
G1 X86.242 Y98.229 E.02253
G1 X85.994 Y98.539
G1 X85.173 Y97.717 E.02286
G1 X84.947 Y98.049
G1 X85.798 Y98.9 E.02368
G1 X85.654 Y99.313
G1 X84.757 Y98.417 E.02494
G1 X84.602 Y98.819
G1 X85.583 Y99.8 E.02729
G1 X85.624 Y100.399
G1 X84.491 Y99.266 E.03152
G1 X84.435 Y99.768
G1 X86.307 Y101.64 E.05207
; WIPE_START
M204 S6000
G1 X84.893 Y100.225 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X90.152 Y98.794 Z6.36 F18000
G1 Z5.96
G1 E.4 F1800
G1 F1500
M204 S2000
G1 X91.556 Y100.198 E.03904
G1 X91.48 Y100.68
G1 X90.41 Y99.609 E.02978
G1 X90.405 Y100.162
G1 X91.354 Y101.111 E.02641
G1 X91.191 Y101.506
G1 X90.315 Y100.629 E.02438
G1 X90.146 Y101.018
G1 X90.986 Y101.858 E.02336
G1 X90.748 Y102.178
G1 X89.931 Y101.361 E.02274
G1 X89.669 Y101.657
G1 X90.479 Y102.466 E.02252
G1 X90.181 Y102.725
G1 X89.363 Y101.907 E.02275
G1 X89.004 Y102.106
G1 X89.852 Y102.955 E.02359
G1 X89.484 Y103.144
G1 X88.589 Y102.249 E.02491
G1 X88.105 Y102.322
G1 X89.082 Y103.299 E.02719
G1 X88.636 Y103.411
G1 X87.493 Y102.268 E.03179
; WIPE_START
M204 S6000
G1 X88.636 Y103.411 E-.30711
G1 X89.008 Y103.318 E-.07289
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X86.332 Y101.665 Z6.36 F18000
G1 Z5.96
G1 E.4 F1800
G1 F1500
M204 S2000
G1 X88.137 Y103.469 E.05019
G1 X87.549 Y103.439
G1 X84.458 Y100.348 E.086
G1 X84.635 Y101.082
G1 X86.818 Y103.266 E.06074
; WIPE_START
M204 S6000
G1 X85.404 Y101.852 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X88.119 Y102.308 Z6.36 F18000
G1 Z5.96
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.0928826
G1 F1500
M204 S6000
G1 X87.903 Y102.399 E.00078
M204 S10000
G1 X87.418 Y102.343 F18000
; LINE_WIDTH: 0.0814951
G1 F1500
M204 S6000
G1 X87.143 Y102.169 E.00091
; WIPE_START
G1 X87.418 Y102.343 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X86.27 Y103.026 Z6.36 F18000
G1 Z5.96
G1 E.4 F1800
; LINE_WIDTH: 0.0956786
G1 F1500
M204 S6000
G1 X86.109 Y102.901 E.00071
; LINE_WIDTH: 0.135533
G1 X85.946 Y102.763 E.00117
; LINE_WIDTH: 0.170005
G1 X85.784 Y102.624 E.00154
; LINE_WIDTH: 0.192745
G1 X85.483 Y102.336 E.00347
G1 X85.2 Y102.031 E.00347
; LINE_WIDTH: 0.152992
G1 X85.066 Y101.868 E.00134
; LINE_WIDTH: 0.111978
G1 X84.932 Y101.704 E.00091
; LINE_WIDTH: 0.0822688
G1 X84.883 Y101.638 E.00023
; WIPE_START
G1 X84.932 Y101.704 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X85.732 Y100.762 Z6.36 F18000
G1 Z5.96
G1 E.4 F1800
; LINE_WIDTH: 0.0970543
G1 F1500
M204 S6000
G1 X85.551 Y100.471 E.00122
; WIPE_START
G1 X85.732 Y100.762 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X84.829 Y98.214 Z6.36 F18000
G1 Z5.96
G1 E.4 F1800
; LINE_WIDTH: 0.0893648
G1 F1500
M204 S6000
G1 X84.841 Y98.278 E.0002
G1 X84.778 Y98.368 E.00035
; WIPE_START
G1 X84.841 Y98.278 E-.23972
G1 X84.829 Y98.214 E-.14028
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X91.288 Y98.509 Z6.36 F18000
G1 Z5.96
G1 E.4 F1800
; LINE_WIDTH: 0.0829475
G1 F1500
M204 S6000
G1 X91.25 Y98.45 E.0002
; LINE_WIDTH: 0.109929
G1 X91.191 Y98.367 E.00043
; LINE_WIDTH: 0.144101
G1 X91.132 Y98.284 E.0006
; LINE_WIDTH: 0.18189
G1 X91.029 Y98.152 E.00131
; LINE_WIDTH: 0.209323
G1 X90.937 Y98.033 E.00138
; WIPE_START
G1 X91.029 Y98.152 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X90.216 Y98.73 Z6.36 F18000
G1 Z5.96
G1 E.4 F1800
; LINE_WIDTH: 0.20046
G1 F1500
M204 S6000
G1 X90.133 Y98.62 E.0012
; LINE_WIDTH: 0.174333
G1 X90.042 Y98.501 E.00111
; LINE_WIDTH: 0.134536
G1 X89.754 Y98.184 E.00232
G1 X89.533 Y97.974 E.00166
; LINE_WIDTH: 0.147871
G1 X89.421 Y97.879 E.00089
; LINE_WIDTH: 0.186085
G1 X89.174 Y97.687 E.0025
; WIPE_START
G1 X89.421 Y97.879 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X90.486 Y99.534 Z6.36 F18000
G1 Z5.96
G1 E.4 F1800
; LINE_WIDTH: 0.0750304
G1 F1500
M204 S6000
G1 X90.347 Y99.294 E.00068
; WIPE_START
G1 X90.486 Y99.534 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X85.524 Y95.928 Z6.36 F18000
G1 Z5.96
G1 E.4 F1800
; LINE_WIDTH: 0.0854791
G1 F1500
M204 S6000
G1 X85.356 Y95.949 E.00051
M204 S10000
G1 X86.059 Y96.652 F18000
; LINE_WIDTH: 0.0854972
G1 F1500
M204 S6000
G1 X85.89 Y96.673 E.00051
; WIPE_START
G1 X86.059 Y96.652 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X82.147 Y96.643 Z6.36 F18000
G1 Z5.96
G1 E.4 F1800
; LINE_WIDTH: 0.0916562
G1 F1500
M204 S6000
G1 X81.96 Y96.674 E.00062
M204 S10000
G1 X81.511 Y95.86 F18000
; LINE_WIDTH: 0.207738
G1 F1500
M204 S6000
G1 X81.339 Y95.712 E.00206
G1 X81.212 Y95.556 E.00183
; WIPE_START
G1 X81.339 Y95.712 E-.17851
G1 X81.511 Y95.86 E-.20149
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X81.622 Y88.229 Z6.36 F18000
G1 X81.781 Y77.321 Z6.36
G1 Z5.96
G1 E.4 F1800
; LINE_WIDTH: 0.086106
G1 F1500
M204 S6000
G1 X81.716 Y77.304 E.0002
G1 X81.64 Y77.36 E.00028
; WIPE_START
G1 X81.716 Y77.304 E-.2221
G1 X81.781 Y77.321 E-.1579
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X89.411 Y77.495 Z6.36 F18000
G1 X94.772 Y77.618 Z6.36
G1 Z5.96
G1 E.4 F1800
; LINE_WIDTH: 0.204222
G1 F1500
M204 S6000
G1 X94.553 Y77.393 E.00279
G1 X94.436 Y77.303 E.00132
; WIPE_START
G1 X94.553 Y77.393 E-.12206
G1 X94.772 Y77.618 E-.25794
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X95.541 Y78.258 Z6.36 F18000
G1 Z5.96
G1 E.4 F1800
; LINE_WIDTH: 0.0912659
G1 F1500
M204 S6000
G1 X95.571 Y78.072 E.00062
; close powerlost recovery
M1003 S0
; WIPE_START
G1 F1500
G1 X95.541 Y78.258 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G17
G3 Z6.36 I1.217 J0 P1  F18000
M106 S0
M981 S0 P20000 ; close spaghetti detector
; FEATURE: Custom
; MACHINE_END_GCODE_START
; filament end gcode 

;===== date: 20260513 =====================
;turn off nozzle clog detect
G392 S0

M400 ; wait for buffer to clear
G92 E0 ; zero the extruder
G90
G1 Z6.36 F900 ; lower z a little
G1 X0 Y90 F18000 ; move to safe pos
G1 X-13.0 F3000 ; move to safe pos

M1002 judge_flag timelapse_record_flag
M622 J1
M400 P100
M971 S11 C11 O0
M400 P100
M971 S11 C11 O0
M400 P100
M971 S11 C11 O0
M400 P100
M971 S11 C11 O0
M400 P100
M971 S11 C11 O0
M400 P100
M971 S11 C11 O0
M400 P100
M971 S11 C11 O0
M400 P100
M971 S11 C11 O0
M400 P100
M971 S11 C11 O0
M400 P100
M971 S11 C11 O0
M400 P100
M971 S11 C11 O0
M400 P100
M971 S11 C11 O0
M400 P100
M971 S11 C11 O0
M400 P100
M971 S11 C11 O0
M400 P100
M971 S11 C11 O0
M400 P100
M971 S11 C11 O0
M400 P100
M971 S11 C11 O0
M400 P100
M971 S11 C11 O0
M400 P100
M971 S11 C11 O0
M400 P100
M971 S11 C11 O0
M400 P100
M971 S11 C11 O0
M400 P100
M971 S11 C11 O0
M400 P100
M971 S11 C11 O0
M400 P100
M971 S11 C11 O0
M400 P100
M971 S11 C11 O0
M400 P100
M971 S11 C11 O0
M400 P100
M971 S11 C11 O0
M400 P100
M971 S11 C11 O0
M400 P100
M971 S11 C11 O0
M400 P100
M971 S11 C11 O0
M991 S0 P-1 ;end timelapse at safe pos
M623


M140 S0 ; turn off bed
M106 S0 ; turn off fan
M106 P2 S0 ; turn off remote part cooling fan
M106 P3 S0 ; turn off chamber cooling fan

;G1 X27 F15000 ; wipe

; pull back filament to AMS
M620 S255
G1 X181 F12000
T255
G1 X0 F18000
G1 X-13.0 F3000
G1 X0 F18000 ; wipe
M621 S255

M104 S0 ; turn off hotend

M400 ; wait all motion done
M17 S
M17 Z0.4 ; lower z motor current to reduce impact if there is something in the bottom

    G1 Z105.96 F600
    G1 Z103.96

M400 P100
M17 R ; restore z current

G90
G1 X-13 Y180 F3600

G91
G1 Z-1 F600
G90
M83

M220 S100  ; Reset feedrate magnitude
M201.2 K1.0 ; Reset acc magnitude
M73.2   R1.0 ;Reset left time magnitude
M1002 set_gcode_claim_speed_level : 0

;=====printer finish  sound=========
M17
M400 S1
M1006 S1
M1006 A0 B20 L100 C37 D20 M100 E42 F20 N100
M1006 A0 B10 L100 C44 D10 M100 E44 F10 N100
M1006 A0 B10 L100 C46 D10 M100 E46 F10 N100
M1006 A44 B20 L100 C39 D20 M100 E48 F20 N100
M1006 A0 B10 L100 C44 D10 M100 E44 F10 N100
M1006 A0 B10 L100 C0 D10 M100 E0 F10 N100
M1006 A0 B10 L100 C39 D10 M100 E39 F10 N100
M1006 A0 B10 L100 C0 D10 M100 E0 F10 N100
M1006 A0 B10 L100 C44 D10 M100 E44 F10 N100
M1006 A0 B10 L100 C0 D10 M100 E0 F10 N100
M1006 A0 B10 L100 C39 D10 M100 E39 F10 N100
M1006 A0 B10 L100 C0 D10 M100 E0 F10 N100
M1006 A44 B10 L100 C0 D10 M100 E48 F10 N100
M1006 A0 B10 L100 C0 D10 M100 E0 F10 N100
M1006 A44 B20 L100 C41 D20 M100 E49 F20 N100
M1006 A0 B20 L100 C0 D20 M100 E0 F20 N100
M1006 A0 B20 L100 C37 D20 M100 E37 F20 N100
M1006 W
;=====printer finish  sound=========
M400 S1
M18 X Y Z
M73 P100 R0
; EXECUTABLE_BLOCK_END

