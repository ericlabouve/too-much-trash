; HEADER_BLOCK_START
; BambuStudio 02.07.01.62
; model printing time: 8m 4s; total estimated time: 15m 12s
; total layer number: 43
; total filament length [mm] : 254.71
; total filament volume [cm^3] : 612.66
; total filament weight [g] : 0.77
; filament_density: 1.25
; filament_diameter: 1.75
; max_z_height: 5.24
; filament: 1
; HEADER_BLOCK_END

; CONFIG_BLOCK_START
; accel_to_decel_enable = 0
; accel_to_decel_factor = 50%
; activate_air_filtration = 0
; additional_cooling_fan_speed = 0
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
; close_additional_fan_first_x_layers = 3
; close_fan_the_first_x_layers = 3
; compatible_printers_condition = 
; complete_print_exhaust_fan_speed = 70
; cool_plate_temp = 0
; cool_plate_temp_initial_layer = 0
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
; eng_plate_temp = 70
; eng_plate_temp_initial_layer = 70
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
; fan_cooling_layer_time = 30
; fan_direction = undefine
; fan_max_speed = 30
; fan_min_speed = 10
; filament_adaptive_volumetric_speed = 0
; filament_adhesiveness_category = 300
; filament_bridge_speed = 25
; filament_change_length = 10
; filament_change_length_nc = 10
; filament_colour = #0085D5
; filament_cooling_before_tower = 0
; filament_cost = 24.99
; filament_density = 1.25
; filament_dev_ams_drying_ams_limitations = 1
; filament_dev_ams_drying_heat_distortion_temperature = 75
; filament_dev_ams_drying_temperature = 65
; filament_dev_ams_drying_time = 12
; filament_dev_chamber_drying_bed_temperature = 80
; filament_dev_chamber_drying_time = 12
; filament_dev_drying_cooling_temperature = 55
; filament_dev_drying_softening_temperature = 60
; filament_diameter = 1.75
; filament_enable_overhang_speed = 1
; filament_end_gcode = "; filament end gcode \n\n"
; filament_extruder_compatibility = 0
; filament_extruder_variant = "Direct Drive Standard"
; filament_flow_ratio = 0.95
; filament_flush_temp = 0
; filament_flush_temp_fast = 0
; filament_flush_volumetric_speed = 0
; filament_ids = GFG01
; filament_is_mixed = 0
; filament_is_support = 0
; filament_long_retractions_when_cut = 1
; filament_map = 1
; filament_map_2 = 0
; filament_map_mode = Auto For Flush
; filament_max_volumetric_speed = 6
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
; filament_retraction_distances_when_cut = 18
; filament_retraction_length = 0.3
; filament_scarf_gap = 0%
; filament_scarf_height = 10%
; filament_scarf_length = 10
; filament_scarf_seam_type = none
; filament_self_index = 1
; filament_settings_id = "Bambu PETG Translucent @BBL A1M"
; filament_shrink = 100%
; filament_soluble = 0
; filament_start_gcode = "; filament start gcode\n{if (bed_temperature[current_extruder] >80)||(bed_temperature_initial_layer[current_extruder] >80)}M106 P3 S255\n{elsif (bed_temperature[current_extruder] >60)||(bed_temperature_initial_layer[current_extruder] >60)}M106 P3 S180\n{endif}\n\n{if activate_air_filtration[current_extruder] && support_air_filtration}\nM106 P3 S{during_print_exhaust_fan_speed_num[current_extruder]} \n{endif}"
; filament_tower_interface_pre_extrusion_dist = 10
; filament_tower_interface_pre_extrusion_length = 0
; filament_tower_interface_print_temp = -1
; filament_tower_interface_purge_volume = 20
; filament_tower_ironing_area = 4
; filament_type = PETG
; filament_velocity_adaptation_factor = 1
; filament_vendor = "Bambu Lab"
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
; gap_infill_speed = 40
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
; hot_plate_temp = 70
; hot_plate_temp_initial_layer = 70
; hotend_cooling_rate = 2
; hotend_heating_rate = 2
; impact_strength_z = 7.2
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
; initial_layer_infill_speed = 50
; initial_layer_jerk = 9
; initial_layer_line_width = 0.5
; initial_layer_print_height = 0.2
; initial_layer_speed = 30
; initial_layer_travel_acceleration = 6000
; inner_wall_acceleration = 0
; inner_wall_jerk = 9
; inner_wall_line_width = 0.45
; inner_wall_speed = 60
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
; internal_solid_infill_speed = 80
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
; nozzle_temperature = 245
; nozzle_temperature_initial_layer = 250
; nozzle_temperature_range_high = 270
; nozzle_temperature_range_low = 230
; nozzle_type = stainless_steel
; nozzle_volume = 92
; nozzle_volume_type = Standard
; only_one_wall_first_layer = 0
; ooze_prevention = 0
; other_layers_print_sequence = 0
; other_layers_print_sequence_nums = 0
; outer_wall_acceleration = 5000
; outer_wall_jerk = 9
; outer_wall_line_width = 0.42
; outer_wall_speed = 30
; overhang_1_4_speed = 60
; overhang_2_4_speed = 30
; overhang_3_4_speed = 10
; overhang_4_4_speed = 10
; overhang_fan_speed = 90
; overhang_fan_threshold = 10%
; overhang_threshold_participating_cooling = 95%
; overhang_totally_speed = 10
; override_filament_scarf_seam_setting = 0
; override_process_overhang_speed = 0
; physical_extruder_map = 0
; post_process = 
; pre_start_fan_time = 2,2,2,2,2
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
; sparse_infill_speed = 100
; spiral_mode = 0
; spiral_mode_max_xy_smoothing = 200%
; spiral_mode_smooth = 0
; standby_temperature_delta = -5
; start_end_points = 30x-3,54x245
; supertack_plate_temp = 70
; supertack_plate_temp_initial_layer = 70
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
; support_interface_speed = 80
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
; support_speed = 150
; support_style = snug
; support_threshold_angle = 30
; support_top_z_distance = 0.24
; support_type = normal(auto)
; symmetric_infill_y_axis = 0
; temperature_vitrification = 70
; template_custom_gcode = 
; textured_plate_temp = 70
; textured_plate_temp_initial_layer = 70
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
; top_surface_speed = 60
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
M73 P0 R15
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
M1002 set_filament_type:PETG
M104 S170
M140 S70
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
    M109 S250

    M104 S250

    M400
    T0
    G1 X-13.5 F3000
    M400

    M620.1 E F149.669 T270
    M109 S250 ;set nozzle to common flush temp

    M106 P1 S0
    G92 E0
M73 P3 R14
    G1 E50 F200
    M400
    M1002 set_filament_type:PETG

    M104 S270

    G92 E0
    G1 E50 F149.669
    M400
    M106 P1 S178
    G92 E0
M73 P4 R14
    G1 E5 F149.669
    M109 S230 ; drop nozzle temp, make filament shink a bit
    M104 S210
    G92 E0
M73 P7 R14
    G1 E-0.5 F300

    G1 X0 F30000
    G1 X-13.5 F3000
    G1 X0 F30000 ;wipe and shake
    G1 X-13.5 F3000
    G1 X0 F12000 ;wipe and shake
    G1 X0 F30000
    G1 X-13.5 F3000
    M109 S210
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
M73 P36 R9
G1 Z2 F1200
G1 X91 F10000
G380 S3 Z-5 F1200
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
M190 S70;set bed temp
M109 S140

G1 Z5 F3000
G29.2 S1
G1 X10 Y10 F20000

;===== bed leveling ==================================
;M1002 set_flag g29_before_print_flag=1
M1002 judge_flag g29_before_print_flag
M622 J1
    M1002 gcode_claim_action : 1
    G29 A1 X84.2 Y79.2 I11.6 J21.6
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
M109 S245
M400

M412 S1 ;    ===turn on  filament runout detection===
M400 P10

G392 S0 ;turn on clog detect

M620.3 W1; === turn on filament tangle detection===
M400 S2

M1002 set_filament_type:PETG
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
    G0 X88 E10  F85.1575
    G0 X93 E.3742  F141.929
    G0 X98 E.3742  F567.717
    G0 X103 E.3742  F141.929
    G0 X108 E.3742  F567.717
    G0 X113 E.3742  F141.929
    G0 Y0 Z0 F20000
    M400
    
    G1 X-13.5 Y0 Z10 F10000
    M400
    
    G1 E10 F35.4823
    M983 F0.591372 A0.3 H0.4; cali dynamic extrusion compensation
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
        M983 F0.591372 A0.3 H0.4; cali dynamic extrusion compensation
        M106 P1 S178
        M400 S7
M73 P37 R9
        G1 X0 F18000
        G1 X-13.5 F3000
        G1 X0 F18000 ;wipe and shake
        G1 X-13.5 F3000
        G1 X0 F12000 ;wipe and shake
        M400
        M106 P1 S0
    M623
    
M73 P38 R9
    G1 X-13.5 F3000
    M400
    M984 A0.1 E1 S1 F0.591372 H0.4
    M106 P1 S178
    M400 S7
    G1 X0 F18000
M73 P39 R9
    G1 X-13.5 F3000
    G1 X0 F18000 ;wipe and shake
M73 P40 R9
    G1 X-13.5 F3000
    G1 X0 F12000 ;wipe and shake
    G1 X-13.5 F3000
    M400
    M106 P1 S0

M623 ; end of "draw extrinsic para cali paint"

;===== extrude cali test ===============================
M104 S250
G90
M83
G0 X68 Y-2.5 F30000
G0 Z0.3 F18000 ;Move to start position
G0 X88 E10  F85.1575
G0 X93 E.3742  F141.929
G0 X98 E.3742  F567.717
G0 X103 E.3742  F141.929
G0 X108 E.3742  F567.717
G0 X113 E.3742  F141.929
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
G1 E-.3 F1800
; layer num/total_layer_count: 1/43
; update layer progress
M73 L1
M991 S0 P0 ;notify layer change
M106 S0
; OBJECT_ID: 8
G1 X94.636 Y99.636 F18000
M204 S6000
G1 Z.4
M73 P42 R8
G1 Z.2
M73 P43 R8
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.5
M204 S500
G1 X85.364 Y99.636 E.33477
G1 X85.364 Y80.364 E.69583
G1 X94.636 Y80.364 E.33477
G1 X94.636 Y99.576 E.69366
M204 S6000
G1 X95.093 Y100.093 F18000
M73 P44 R8
G1 F1800
M204 S500
G1 X84.907 Y100.093 E.36777
G1 X84.907 Y79.907 E.72883
G1 X95.093 Y79.907 E.36777
G1 X95.093 Y100.033 E.72667
M204 S6000
G1 X95.55 Y100.55 F18000
; FEATURE: Outer wall
G1 F1800
M204 S500
G1 X84.45 Y100.55 E.40078
G1 X84.45 Y79.45 E.76184
G1 X95.55 Y79.45 E.40078
G1 X95.55 Y100.49 E.75967
; WIPE_START
G1 X93.55 Y100.501 E-.285
; WIPE_END
G1 E-.015
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
M73 P46 R8
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




G1 X93.525 Y80.547
G1 Z.2
G1 E.3 F1800
; FEATURE: Bottom surface
; LINE_WIDTH: 0.50177
G1 F3000
M204 S500
G1 X94.247 Y81.269 E.03701
G1 X94.247 Y81.918 E.02352
G1 X93.082 Y80.753 E.05973
G1 X92.433 Y80.753 E.02352
G1 X94.247 Y82.567 E.09299
G1 X94.247 Y83.216 E.02352
M73 P47 R8
G1 X91.784 Y80.753 E.12626
G1 X91.135 Y80.753 E.02352
G1 X94.247 Y83.865 E.15952
G1 X94.247 Y84.514 E.02352
G1 X90.486 Y80.753 E.19278
G1 X89.838 Y80.753 E.02352
G1 X94.247 Y85.162 E.22605
G1 X94.247 Y85.811 E.02352
G1 X89.189 Y80.753 E.25931
G1 X88.54 Y80.753 E.02352
G1 X94.247 Y86.46 E.29257
G1 X94.247 Y87.109 E.02352
M73 P47 R7
G1 X87.891 Y80.753 E.32583
G1 X87.242 Y80.753 E.02352
G1 X94.247 Y87.758 E.3591
G1 X94.247 Y88.407 E.02352
G1 X86.593 Y80.753 E.39236
G1 X85.944 Y80.753 E.02352
G1 X94.247 Y89.056 E.42562
G1 X94.247 Y89.705 E.02352
G1 X85.753 Y81.21 E.43543
G1 X85.753 Y81.859 E.02352
G1 X94.247 Y90.354 E.43543
G1 X94.247 Y91.003 E.02352
G1 X85.753 Y82.508 E.43543
G1 X85.753 Y83.157 E.02352
G1 X94.247 Y91.652 E.43543
G1 X94.247 Y92.301 E.02352
G1 X85.753 Y83.806 E.43543
G1 X85.753 Y84.455 E.02352
G1 X94.247 Y92.949 E.43543
G1 X94.247 Y93.598 E.02352
G1 X85.753 Y85.104 E.43543
G1 X85.753 Y85.753 E.02352
G1 X94.247 Y94.247 E.43543
G1 X94.247 Y94.896 E.02352
G1 X85.753 Y86.401 E.43543
G1 X85.753 Y87.05 E.02352
G1 X94.247 Y95.545 E.43543
G1 X94.247 Y96.194 E.02352
G1 X85.753 Y87.699 E.43543
G1 X85.753 Y88.348 E.02352
M73 P48 R7
G1 X94.247 Y96.843 E.43543
G1 X94.247 Y97.492 E.02352
G1 X85.753 Y88.997 E.43543
G1 X85.753 Y89.646 E.02352
G1 X94.247 Y98.141 E.43543
G1 X94.247 Y98.79 E.02352
G1 X85.753 Y90.295 E.43543
G1 X85.753 Y90.944 E.02352
G1 X94.056 Y99.247 E.42563
G1 X93.407 Y99.247 E.02352
G1 X85.753 Y91.593 E.39237
G1 X85.753 Y92.242 E.02352
G1 X92.758 Y99.247 E.35911
G1 X92.109 Y99.247 E.02352
G1 X85.753 Y92.891 E.32585
G1 X85.753 Y93.539 E.02352
G1 X91.461 Y99.247 E.29258
G1 X90.812 Y99.247 E.02352
G1 X85.753 Y94.188 E.25932
G1 X85.753 Y94.837 E.02352
G1 X90.163 Y99.247 E.22606
G1 X89.514 Y99.247 E.02352
G1 X85.753 Y95.486 E.19279
G1 X85.753 Y96.135 E.02352
G1 X88.865 Y99.247 E.15953
G1 X88.216 Y99.247 E.02352
G1 X85.753 Y96.784 E.12627
G1 X85.753 Y97.433 E.02352
G1 X87.567 Y99.247 E.09301
G1 X86.918 Y99.247 E.02352
G1 X85.753 Y98.082 E.05974
G1 X85.753 Y98.731 E.02352
G1 X86.475 Y99.453 E.03702
; CHANGE_LAYER
; Z_HEIGHT: 0.32
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F3000
G1 X85.753 Y98.731 E-.14555
G1 X85.753 Y98.082 E-.09247
G1 X85.986 Y98.315 E-.04698
; WIPE_END
G1 E-.015 F1800
; layer num/total_layer_count: 2/43
; update layer progress
M73 L2
M991 S0 P1 ;notify layer change
; open powerlost recovery
M1003 S1
M104 S245 ; set nozzle temperature
; OBJECT_ID: 8
M204 S10000
G17
G3 Z.6 I-.197 J1.201 P1  F18000
G1 X94.757 Y99.757 Z.6
G1 Z.32
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F3600
M204 S6000
G1 X85.243 Y99.757 E.19128
G1 X85.243 Y80.243 E.39236
G1 X94.757 Y80.243 E.19128
G1 X94.757 Y99.697 E.39115
M204 S10000
G1 X95.181 Y100.181 F18000
G1 F3600
M204 S6000
G1 X84.819 Y100.181 E.20834
G1 X84.819 Y79.819 E.40942
G1 X95.181 Y79.819 E.20834
G1 X95.181 Y100.121 E.40821
M204 S250
G1 X95.59 Y100.59 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1800
M204 S5000
G1 X84.41 Y100.59 E.20891
G1 X84.41 Y79.41 E.39576
G1 X95.59 Y79.41 E.20891
G1 X95.59 Y100.53 E.39464
; WIPE_START
M204 S6000
G1 X93.59 Y100.541 E-.285
; WIPE_END
G1 E-.015
M204 S10000
G17
M73 P49 R7
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




G1 X93.773 Y99.586
G1 Z.32
G1 E.3 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.427712
G1 F4800
M204 S6000
G1 X94.409 Y98.95 E.01713
G1 X94.409 Y98.382 E.01083
G1 X93.382 Y99.409 E.02767
G1 X92.813 Y99.409 E.01083
G1 X94.409 Y97.813 E.04298
G1 X94.409 Y97.245 E.01083
G1 X92.245 Y99.409 E.0583
G1 X91.676 Y99.409 E.01083
G1 X94.409 Y96.676 E.07362
G1 X94.409 Y96.108 E.01083
G1 X91.108 Y99.409 E.08893
G1 X90.539 Y99.409 E.01083
G1 X94.409 Y95.539 E.10425
G1 X94.409 Y94.971 E.01083
G1 X89.971 Y99.409 E.11956
G1 X89.403 Y99.409 E.01083
G1 X94.409 Y94.403 E.13488
G1 X94.409 Y93.834 E.01083
G1 X88.834 Y99.409 E.15019
G1 X88.266 Y99.409 E.01083
G1 X94.409 Y93.266 E.16551
G1 X94.409 Y92.697 E.01083
G1 X87.697 Y99.409 E.18082
G1 X87.129 Y99.409 E.01083
G1 X94.409 Y92.129 E.19614
G1 X94.409 Y91.56 E.01083
G1 X86.56 Y99.409 E.21146
G1 X85.992 Y99.409 E.01083
G1 X94.409 Y90.992 E.22677
G1 X94.409 Y90.423 E.01083
G1 X85.591 Y99.241 E.23756
G1 X85.591 Y98.672 E.01083
G1 X94.409 Y89.855 E.23756
G1 X94.409 Y89.286 E.01083
G1 X85.591 Y98.104 E.23756
G1 X85.591 Y97.535 E.01083
G1 X94.409 Y88.718 E.23756
G1 X94.409 Y88.149 E.01083
G1 X85.591 Y96.967 E.23756
G1 X85.591 Y96.398 E.01083
G1 X94.409 Y87.581 E.23756
G1 X94.409 Y87.013 E.01083
G1 X85.591 Y95.83 E.23756
G1 X85.591 Y95.261 E.01083
G1 X94.409 Y86.444 E.23756
G1 X94.409 Y85.876 E.01083
G1 X85.591 Y94.693 E.23756
G1 X85.591 Y94.125 E.01083
G1 X94.409 Y85.307 E.23756
G1 X94.409 Y84.739 E.01083
G1 X85.591 Y93.556 E.23756
G1 X85.591 Y92.988 E.01083
G1 X94.409 Y84.17 E.23756
G1 X94.409 Y83.602 E.01083
G1 X85.591 Y92.419 E.23756
G1 X85.591 Y91.851 E.01083
G1 X94.409 Y83.033 E.23756
G1 X94.409 Y82.465 E.01083
G1 X85.591 Y91.282 E.23756
G1 X85.591 Y90.714 E.01083
G1 X94.409 Y81.896 E.23756
G1 X94.409 Y81.328 E.01083
G1 X85.591 Y90.145 E.23756
G1 X85.591 Y89.577 E.01083
G1 X94.409 Y80.76 E.23756
G1 X94.409 Y80.591 E.0032
G1 X94.008 Y80.591 E.00763
G1 X85.591 Y89.008 E.22678
G1 X85.591 Y88.44 E.01083
G1 X93.44 Y80.591 E.21146
G1 X92.871 Y80.591 E.01083
G1 X85.591 Y87.871 E.19614
G1 X85.591 Y87.303 E.01083
G1 X92.303 Y80.591 E.18083
G1 X91.735 Y80.591 E.01083
G1 X85.591 Y86.735 E.16551
M73 P50 R7
G1 X85.591 Y86.166 E.01083
G1 X91.166 Y80.591 E.1502
G1 X90.598 Y80.591 E.01083
G1 X85.591 Y85.598 E.13488
G1 X85.591 Y85.029 E.01083
G1 X90.029 Y80.591 E.11957
G1 X89.461 Y80.591 E.01083
G1 X85.591 Y84.461 E.10425
G1 X85.591 Y83.892 E.01083
G1 X88.892 Y80.591 E.08894
G1 X88.324 Y80.591 E.01083
G1 X85.591 Y83.324 E.07362
G1 X85.591 Y82.755 E.01083
G1 X87.755 Y80.591 E.0583
G1 X87.187 Y80.591 E.01083
G1 X85.591 Y82.187 E.04299
G1 X85.591 Y81.618 E.01083
G1 X86.618 Y80.591 E.02767
G1 X86.05 Y80.591 E.01083
G1 X85.414 Y81.227 E.01714
; CHANGE_LAYER
; Z_HEIGHT: 0.44
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F4800
G1 X86.05 Y80.591 E-.12819
G1 X86.618 Y80.591 E-.08101
G1 X86.242 Y80.968 E-.07581
; WIPE_END
G1 E-.015 F1800
; layer num/total_layer_count: 3/43
; update layer progress
M73 L3
M991 S0 P2 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z.72 I-1.108 J.502 P1  F18000
G1 X94.757 Y99.757 Z.72
G1 Z.44
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F3600
M204 S6000
G1 X85.243 Y99.757 E.19128
G1 X85.243 Y80.243 E.39236
G1 X94.757 Y80.243 E.19128
G1 X94.757 Y99.697 E.39115
M204 S10000
G1 X95.181 Y100.181 F18000
G1 F3600
M204 S6000
G1 X84.819 Y100.181 E.20834
G1 X84.819 Y79.819 E.40942
G1 X95.181 Y79.819 E.20834
G1 X95.181 Y100.121 E.40821
M204 S250
G1 X95.59 Y100.59 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1800
M204 S5000
G1 X84.41 Y100.59 E.20891
G1 X84.41 Y79.41 E.39576
G1 X95.59 Y79.41 E.20891
G1 X95.59 Y100.53 E.39464
; WIPE_START
M204 S6000
G1 X93.59 Y100.541 E-.285
; WIPE_END
G1 E-.015
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
G1 X86.227 Y99.586
G1 Z.44
G1 E.3 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.427712
G1 F4800
M204 S6000
G1 X85.591 Y98.95 E.01714
G1 X85.591 Y98.382 E.01083
G1 X86.618 Y99.409 E.02767
G1 X87.187 Y99.409 E.01083
G1 X85.591 Y97.813 E.04299
G1 X85.591 Y97.245 E.01083
G1 X87.755 Y99.409 E.0583
G1 X88.324 Y99.409 E.01083
G1 X85.591 Y96.676 E.07362
G1 X85.591 Y96.108 E.01083
G1 X88.892 Y99.409 E.08894
G1 X89.461 Y99.409 E.01083
G1 X85.591 Y95.539 E.10425
G1 X85.591 Y94.971 E.01083
G1 X90.029 Y99.409 E.11957
G1 X90.598 Y99.409 E.01083
G1 X85.591 Y94.402 E.13488
G1 X85.591 Y93.834 E.01083
G1 X91.166 Y99.409 E.1502
G1 X91.735 Y99.409 E.01083
G1 X85.591 Y93.265 E.16551
G1 X85.591 Y92.697 E.01083
G1 X92.303 Y99.409 E.18083
G1 X92.871 Y99.409 E.01083
G1 X85.591 Y92.129 E.19614
G1 X85.591 Y91.56 E.01083
M73 P51 R7
G1 X93.44 Y99.409 E.21146
G1 X94.008 Y99.409 E.01083
G1 X85.591 Y90.992 E.22678
G1 X85.591 Y90.423 E.01083
G1 X94.409 Y99.24 E.23756
G1 X94.409 Y98.672 E.01083
G1 X85.591 Y89.855 E.23756
G1 X85.591 Y89.286 E.01083
G1 X94.409 Y98.104 E.23756
G1 X94.409 Y97.535 E.01083
G1 X85.591 Y88.718 E.23756
G1 X85.591 Y88.149 E.01083
G1 X94.409 Y96.967 E.23756
G1 X94.409 Y96.398 E.01083
G1 X85.591 Y87.581 E.23756
G1 X85.591 Y87.012 E.01083
G1 X94.409 Y95.83 E.23756
G1 X94.409 Y95.261 E.01083
G1 X85.591 Y86.444 E.23756
G1 X85.591 Y85.876 E.01083
G1 X94.409 Y94.693 E.23756
G1 X94.409 Y94.124 E.01083
G1 X85.591 Y85.307 E.23756
G1 X85.591 Y84.739 E.01083
G1 X94.409 Y93.556 E.23756
G1 X94.409 Y92.987 E.01083
G1 X85.591 Y84.17 E.23756
G1 X85.591 Y83.602 E.01083
G1 X94.409 Y92.419 E.23756
G1 X94.409 Y91.851 E.01083
G1 X85.591 Y83.033 E.23756
G1 X85.591 Y82.465 E.01083
G1 X94.409 Y91.282 E.23756
G1 X94.409 Y90.714 E.01083
G1 X85.591 Y81.896 E.23756
G1 X85.591 Y81.328 E.01083
G1 X94.409 Y90.145 E.23756
G1 X94.409 Y89.577 E.01083
G1 X85.591 Y80.759 E.23756
G1 X85.591 Y80.591 E.0032
G1 X85.992 Y80.591 E.00763
G1 X94.409 Y89.008 E.22677
G1 X94.409 Y88.44 E.01083
G1 X86.56 Y80.591 E.21146
G1 X87.129 Y80.591 E.01083
G1 X94.409 Y87.871 E.19614
G1 X94.409 Y87.303 E.01083
G1 X87.697 Y80.591 E.18083
G1 X88.266 Y80.591 E.01083
G1 X94.409 Y86.734 E.16551
G1 X94.409 Y86.166 E.01083
G1 X88.834 Y80.591 E.15019
G1 X89.403 Y80.591 E.01083
G1 X94.409 Y85.598 E.13488
G1 X94.409 Y85.029 E.01083
G1 X89.971 Y80.591 E.11956
G1 X90.539 Y80.591 E.01083
G1 X94.409 Y84.461 E.10425
G1 X94.409 Y83.892 E.01083
G1 X91.108 Y80.591 E.08893
G1 X91.676 Y80.591 E.01083
G1 X94.409 Y83.324 E.07362
G1 X94.409 Y82.755 E.01083
G1 X92.245 Y80.591 E.0583
G1 X92.813 Y80.591 E.01083
G1 X94.409 Y82.187 E.04298
G1 X94.409 Y81.618 E.01083
G1 X93.382 Y80.591 E.02767
G1 X93.95 Y80.591 E.01083
G1 X94.586 Y81.227 E.01713
; CHANGE_LAYER
; Z_HEIGHT: 0.56
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F4800
G1 X93.95 Y80.591 E-.12815
G1 X93.382 Y80.591 E-.08101
G1 X93.758 Y80.968 E-.07584
; WIPE_END
G1 E-.015 F1800
; layer num/total_layer_count: 4/43
; update layer progress
M73 L4
M991 S0 P3 ;notify layer change
M106 S68.85
; OBJECT_ID: 8
M204 S10000
G17
G3 Z.84 I-1.215 J.065 P1  F18000
G1 X94.757 Y99.757 Z.84
G1 Z.56
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F3600
M204 S6000
G1 X85.243 Y99.757 E.19128
G1 X85.243 Y80.243 E.39236
G1 X94.757 Y80.243 E.19128
G1 X94.757 Y99.697 E.39115
M204 S10000
G1 X95.181 Y100.181 F18000
G1 F3600
M204 S6000
G1 X84.819 Y100.181 E.20834
G1 X84.819 Y79.819 E.40942
G1 X95.181 Y79.819 E.20834
G1 X95.181 Y100.121 E.40821
M204 S250
G1 X95.59 Y100.59 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1800
M204 S5000
G1 X84.41 Y100.59 E.20891
G1 X84.41 Y79.41 E.39576
G1 X95.59 Y79.41 E.20891
G1 X95.59 Y100.53 E.39464
; WIPE_START
M204 S6000
G1 X93.59 Y100.541 E-.285
; WIPE_END
G1 E-.015
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
M73 P52 R7
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




G1 X93.773 Y99.586
G1 Z.56
G1 E.3 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.427712
G1 F4800
M204 S6000
G1 X94.409 Y98.95 E.01713
G1 X94.409 Y98.382 E.01083
G1 X93.382 Y99.409 E.02767
G1 X92.813 Y99.409 E.01083
G1 X94.409 Y97.813 E.04298
G1 X94.409 Y97.245 E.01083
G1 X92.245 Y99.409 E.0583
G1 X91.676 Y99.409 E.01083
G1 X94.409 Y96.676 E.07362
G1 X94.409 Y96.108 E.01083
G1 X91.108 Y99.409 E.08893
G1 X90.539 Y99.409 E.01083
G1 X94.409 Y95.539 E.10425
G1 X94.409 Y94.971 E.01083
G1 X89.971 Y99.409 E.11956
G1 X89.403 Y99.409 E.01083
G1 X94.409 Y94.403 E.13488
G1 X94.409 Y93.834 E.01083
G1 X88.834 Y99.409 E.15019
G1 X88.266 Y99.409 E.01083
G1 X94.409 Y93.266 E.16551
G1 X94.409 Y92.697 E.01083
G1 X87.697 Y99.409 E.18082
G1 X87.129 Y99.409 E.01083
G1 X94.409 Y92.129 E.19614
G1 X94.409 Y91.56 E.01083
G1 X86.56 Y99.409 E.21146
G1 X85.992 Y99.409 E.01083
G1 X94.409 Y90.992 E.22677
G1 X94.409 Y90.423 E.01083
G1 X85.591 Y99.241 E.23756
G1 X85.591 Y98.672 E.01083
G1 X94.409 Y89.855 E.23756
G1 X94.409 Y89.286 E.01083
G1 X85.591 Y98.104 E.23756
G1 X85.591 Y97.535 E.01083
G1 X94.409 Y88.718 E.23756
G1 X94.409 Y88.149 E.01083
G1 X85.591 Y96.967 E.23756
G1 X85.591 Y96.398 E.01083
G1 X94.409 Y87.581 E.23756
G1 X94.409 Y87.013 E.01083
G1 X85.591 Y95.83 E.23756
G1 X85.591 Y95.261 E.01083
G1 X94.409 Y86.444 E.23756
G1 X94.409 Y85.876 E.01083
G1 X85.591 Y94.693 E.23756
G1 X85.591 Y94.125 E.01083
G1 X94.409 Y85.307 E.23756
G1 X94.409 Y84.739 E.01083
G1 X85.591 Y93.556 E.23756
G1 X85.591 Y92.988 E.01083
G1 X94.409 Y84.17 E.23756
G1 X94.409 Y83.602 E.01083
G1 X85.591 Y92.419 E.23756
G1 X85.591 Y91.851 E.01083
G1 X94.409 Y83.033 E.23756
G1 X94.409 Y82.465 E.01083
G1 X85.591 Y91.282 E.23756
G1 X85.591 Y90.714 E.01083
G1 X94.409 Y81.896 E.23756
G1 X94.409 Y81.328 E.01083
G1 X85.591 Y90.145 E.23756
G1 X85.591 Y89.577 E.01083
G1 X94.409 Y80.76 E.23756
G1 X94.409 Y80.591 E.0032
G1 X94.008 Y80.591 E.00763
G1 X85.591 Y89.008 E.22678
G1 X85.591 Y88.44 E.01083
G1 X93.44 Y80.591 E.21146
G1 X92.871 Y80.591 E.01083
M73 P53 R7
G1 X85.591 Y87.871 E.19614
G1 X85.591 Y87.303 E.01083
G1 X92.303 Y80.591 E.18083
G1 X91.735 Y80.591 E.01083
G1 X85.591 Y86.735 E.16551
G1 X85.591 Y86.166 E.01083
G1 X91.166 Y80.591 E.1502
G1 X90.598 Y80.591 E.01083
G1 X85.591 Y85.598 E.13488
G1 X85.591 Y85.029 E.01083
G1 X90.029 Y80.591 E.11957
G1 X89.461 Y80.591 E.01083
G1 X85.591 Y84.461 E.10425
G1 X85.591 Y83.892 E.01083
G1 X88.892 Y80.591 E.08894
G1 X88.324 Y80.591 E.01083
G1 X85.591 Y83.324 E.07362
G1 X85.591 Y82.755 E.01083
G1 X87.755 Y80.591 E.0583
G1 X87.187 Y80.591 E.01083
G1 X85.591 Y82.187 E.04299
G1 X85.591 Y81.618 E.01083
G1 X86.618 Y80.591 E.02767
G1 X86.05 Y80.591 E.01083
G1 X85.414 Y81.227 E.01714
; CHANGE_LAYER
; Z_HEIGHT: 0.68
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F4800
G1 X86.05 Y80.591 E-.12819
G1 X86.618 Y80.591 E-.08101
G1 X86.242 Y80.968 E-.07581
; WIPE_END
G1 E-.015 F1800
; layer num/total_layer_count: 5/43
; update layer progress
M73 L5
M991 S0 P4 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z.96 I-1.108 J.502 P1  F18000
G1 X94.757 Y99.757 Z.96
G1 Z.68
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F3600
M204 S6000
G1 X85.243 Y99.757 E.19128
G1 X85.243 Y80.243 E.39236
G1 X94.757 Y80.243 E.19128
G1 X94.757 Y99.697 E.39115
M204 S10000
G1 X95.181 Y100.181 F18000
G1 F3600
M204 S6000
G1 X84.819 Y100.181 E.20834
G1 X84.819 Y79.819 E.40942
G1 X95.181 Y79.819 E.20834
G1 X95.181 Y100.121 E.40821
M204 S250
G1 X95.59 Y100.59 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1800
M204 S5000
G1 X84.41 Y100.59 E.20891
G1 X84.41 Y79.41 E.39576
G1 X95.59 Y79.41 E.20891
G1 X95.59 Y100.53 E.39464
; WIPE_START
M204 S6000
G1 X93.59 Y100.541 E-.285
; WIPE_END
G1 E-.015
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




G1 X86.227 Y99.586
G1 Z.68
G1 E.3 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.427712
G1 F4800
M204 S6000
G1 X85.591 Y98.95 E.01714
G1 X85.591 Y98.382 E.01083
G1 X86.618 Y99.409 E.02767
G1 X87.187 Y99.409 E.01083
G1 X85.591 Y97.813 E.04299
G1 X85.591 Y97.245 E.01083
G1 X87.755 Y99.409 E.0583
G1 X88.324 Y99.409 E.01083
G1 X85.591 Y96.676 E.07362
G1 X85.591 Y96.108 E.01083
G1 X88.892 Y99.409 E.08894
G1 X89.461 Y99.409 E.01083
G1 X85.591 Y95.539 E.10425
G1 X85.591 Y94.971 E.01083
G1 X90.029 Y99.409 E.11957
G1 X90.598 Y99.409 E.01083
G1 X85.591 Y94.402 E.13488
G1 X85.591 Y93.834 E.01083
G1 X91.166 Y99.409 E.1502
G1 X91.735 Y99.409 E.01083
G1 X85.591 Y93.265 E.16551
G1 X85.591 Y92.697 E.01083
G1 X92.303 Y99.409 E.18083
G1 X92.871 Y99.409 E.01083
G1 X85.591 Y92.129 E.19614
G1 X85.591 Y91.56 E.01083
G1 X93.44 Y99.409 E.21146
G1 X94.008 Y99.409 E.01083
G1 X85.591 Y90.992 E.22678
G1 X85.591 Y90.423 E.01083
M73 P54 R7
G1 X94.409 Y99.24 E.23756
M73 P54 R6
G1 X94.409 Y98.672 E.01083
G1 X85.591 Y89.855 E.23756
G1 X85.591 Y89.286 E.01083
G1 X94.409 Y98.104 E.23756
G1 X94.409 Y97.535 E.01083
G1 X85.591 Y88.718 E.23756
G1 X85.591 Y88.149 E.01083
G1 X94.409 Y96.967 E.23756
G1 X94.409 Y96.398 E.01083
G1 X85.591 Y87.581 E.23756
G1 X85.591 Y87.012 E.01083
G1 X94.409 Y95.83 E.23756
G1 X94.409 Y95.261 E.01083
G1 X85.591 Y86.444 E.23756
G1 X85.591 Y85.876 E.01083
G1 X94.409 Y94.693 E.23756
G1 X94.409 Y94.124 E.01083
G1 X85.591 Y85.307 E.23756
G1 X85.591 Y84.739 E.01083
G1 X94.409 Y93.556 E.23756
G1 X94.409 Y92.987 E.01083
G1 X85.591 Y84.17 E.23756
G1 X85.591 Y83.602 E.01083
G1 X94.409 Y92.419 E.23756
G1 X94.409 Y91.851 E.01083
G1 X85.591 Y83.033 E.23756
G1 X85.591 Y82.465 E.01083
G1 X94.409 Y91.282 E.23756
G1 X94.409 Y90.714 E.01083
G1 X85.591 Y81.896 E.23756
G1 X85.591 Y81.328 E.01083
G1 X94.409 Y90.145 E.23756
G1 X94.409 Y89.577 E.01083
G1 X85.591 Y80.759 E.23756
G1 X85.591 Y80.591 E.0032
G1 X85.992 Y80.591 E.00763
G1 X94.409 Y89.008 E.22677
G1 X94.409 Y88.44 E.01083
G1 X86.56 Y80.591 E.21146
G1 X87.129 Y80.591 E.01083
G1 X94.409 Y87.871 E.19614
G1 X94.409 Y87.303 E.01083
G1 X87.697 Y80.591 E.18083
G1 X88.266 Y80.591 E.01083
G1 X94.409 Y86.734 E.16551
G1 X94.409 Y86.166 E.01083
G1 X88.834 Y80.591 E.15019
G1 X89.403 Y80.591 E.01083
G1 X94.409 Y85.598 E.13488
G1 X94.409 Y85.029 E.01083
G1 X89.971 Y80.591 E.11956
G1 X90.539 Y80.591 E.01083
G1 X94.409 Y84.461 E.10425
G1 X94.409 Y83.892 E.01083
G1 X91.108 Y80.591 E.08893
G1 X91.676 Y80.591 E.01083
G1 X94.409 Y83.324 E.07362
G1 X94.409 Y82.755 E.01083
G1 X92.245 Y80.591 E.0583
G1 X92.813 Y80.591 E.01083
G1 X94.409 Y82.187 E.04298
G1 X94.409 Y81.618 E.01083
G1 X93.382 Y80.591 E.02767
G1 X93.95 Y80.591 E.01083
G1 X94.586 Y81.227 E.01713
; CHANGE_LAYER
; Z_HEIGHT: 0.8
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F4800
G1 X93.95 Y80.591 E-.12815
G1 X93.382 Y80.591 E-.08101
G1 X93.758 Y80.968 E-.07584
; WIPE_END
G1 E-.015 F1800
; layer num/total_layer_count: 6/43
; update layer progress
M73 L6
M991 S0 P5 ;notify layer change
M106 S73.95
; OBJECT_ID: 8
M204 S10000
G17
G3 Z1.08 I-1.215 J.065 P1  F18000
G1 X94.757 Y99.757 Z1.08
G1 Z.8
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F2564
M204 S6000
G1 X85.243 Y99.757 E.19128
G1 X85.243 Y80.243 E.39236
G1 X94.757 Y80.243 E.19128
G1 X94.757 Y99.697 E.39115
M204 S10000
G1 X95.181 Y100.181 F18000
G1 F2564
M204 S6000
G1 X84.819 Y100.181 E.20834
G1 X84.819 Y79.819 E.40942
G1 X95.181 Y79.819 E.20834
G1 X95.181 Y100.121 E.40821
M204 S250
G1 X95.59 Y100.59 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1800
M204 S5000
G1 X84.41 Y100.59 E.20891
G1 X84.41 Y79.41 E.39576
G1 X95.59 Y79.41 E.20891
G1 X95.59 Y100.53 E.39464
; WIPE_START
M204 S6000
G1 X93.59 Y100.541 E-.285
; WIPE_END
G1 E-.015
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




G1 X85.606 Y96.924
G1 Z.8
G1 E.3 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F2564
M204 S6000
G1 X85.606 Y98.621 E.03412
G1 X86.014 Y98.194 E.01188
G1 X86.696 Y97.738 E.0165
G1 X87.484 Y97.283 E.0183
G1 X87.764 Y96.828 E.01075
G1 X87.734 Y96.373 E.00917
G1 X87.418 Y95.462 E.01938
G1 X87.137 Y95.007 E.01076
G1 X86.703 Y94.552 E.01264
G1 X86.021 Y94.097 E.0165
G1 X85.606 Y93.858 E.00962
G1 X85.606 Y91.338 E.05066
M73 P55 R6
G1 X86.014 Y90.91 E.01188
G1 X86.696 Y90.455 E.0165
G1 X87.484 Y90 E.0183
G1 X87.764 Y89.545 E.01075
G1 X87.734 Y89.09 E.00917
G1 X87.418 Y88.179 E.01938
G1 X87.137 Y87.724 E.01076
G1 X86.703 Y87.269 E.01264
G1 X86.021 Y86.814 E.0165
G1 X85.606 Y86.574 E.00962
G1 X85.606 Y84.055 E.05066
G1 X86.014 Y83.627 E.01188
G1 X86.696 Y83.172 E.0165
G1 X87.484 Y82.717 E.0183
G1 X87.764 Y82.262 E.01075
G1 X87.734 Y81.807 E.00917
G1 X87.418 Y80.896 E.01938
G1 X87.239 Y80.606 E.00685
G1 X91.16 Y80.606 E.07885
G1 X91.059 Y80.896 E.00617
G1 X90.778 Y81.351 E.01076
G1 X90.345 Y81.807 E.01264
G1 X89.662 Y82.262 E.0165
G1 X88.874 Y82.717 E.0183
G1 X88.594 Y83.172 E.01075
G1 X88.624 Y83.627 E.00917
G1 X88.941 Y84.538 E.01938
G1 X89.222 Y84.993 E.01076
G1 X89.655 Y85.448 E.01264
G1 X90.338 Y85.903 E.0165
G1 X91.126 Y86.359 E.0183
G1 X91.406 Y86.814 E.01075
G1 X91.376 Y87.269 E.00917
G1 X91.059 Y88.179 E.01938
G1 X90.778 Y88.635 E.01076
G1 X90.345 Y89.09 E.01264
G1 X89.662 Y89.545 E.0165
G1 X88.874 Y90 E.0183
G1 X88.594 Y90.455 E.01075
G1 X88.624 Y90.91 E.00917
G1 X88.941 Y91.821 E.01938
G1 X89.222 Y92.276 E.01076
G1 X89.655 Y92.731 E.01264
G1 X90.338 Y93.186 E.0165
G1 X91.126 Y93.642 E.0183
G1 X91.406 Y94.097 E.01075
G1 X91.376 Y94.552 E.00917
G1 X91.059 Y95.462 E.01938
G1 X90.778 Y95.918 E.01076
G1 X90.345 Y96.373 E.01264
G1 X89.662 Y96.828 E.0165
G1 X88.874 Y97.283 E.0183
G1 X88.594 Y97.738 E.01075
G1 X88.624 Y98.194 E.00917
G1 X88.941 Y99.104 E.01938
G1 X89.12 Y99.394 E.00685
G1 X92.482 Y99.394 E.0676
G1 X92.582 Y99.104 E.00617
G1 X92.863 Y98.649 E.01076
G1 X93.297 Y98.194 E.01264
G1 X93.98 Y97.738 E.0165
G1 X94.394 Y97.499 E.00962
G1 X94.394 Y94.98 E.05066
G1 X93.986 Y94.552 E.01188
G1 X93.304 Y94.097 E.0165
G1 X92.516 Y93.642 E.0183
G1 X92.236 Y93.186 E.01075
G1 X92.266 Y92.731 E.00917
G1 X92.582 Y91.821 E.01938
G1 X92.863 Y91.366 E.01076
G1 X93.297 Y90.91 E.01264
G1 X93.98 Y90.455 E.0165
G1 X94.394 Y90.216 E.00962
G1 X94.394 Y87.697 E.05066
G1 X93.986 Y87.269 E.01188
G1 X93.304 Y86.814 E.0165
G1 X92.516 Y86.359 E.0183
G1 X92.236 Y85.903 E.01075
G1 X92.266 Y85.448 E.00917
G1 X92.582 Y84.538 E.01938
G1 X92.863 Y84.083 E.01076
G1 X93.297 Y83.627 E.01264
G1 X93.98 Y83.172 E.0165
G1 X94.394 Y82.933 E.00962
G1 X94.394 Y81.236 E.03412
; CHANGE_LAYER
; Z_HEIGHT: 0.92
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F6000
G1 X94.394 Y82.933 E-.24182
G1 X94.131 Y83.085 E-.04318
; WIPE_END
G1 E-.015 F1800
; layer num/total_layer_count: 7/43
; update layer progress
M73 L7
M991 S0 P6 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z1.2 I-1.216 J.046 P1  F18000
G1 X94.757 Y99.757 Z1.2
G1 Z.92
G1 E.3 F1800
; FEATURE: Inner wall
G1 F2636
M204 S6000
G1 X85.243 Y99.757 E.19128
G1 X85.243 Y80.243 E.39236
G1 X94.757 Y80.243 E.19128
G1 X94.757 Y99.697 E.39115
M204 S10000
G1 X95.181 Y100.181 F18000
G1 F2636
M204 S6000
G1 X84.819 Y100.181 E.20834
G1 X84.819 Y79.819 E.40942
G1 X95.181 Y79.819 E.20834
G1 X95.181 Y100.121 E.40821
M204 S250
G1 X95.59 Y100.59 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1800
M204 S5000
G1 X84.41 Y100.59 E.20891
G1 X84.41 Y79.41 E.39576
G1 X95.59 Y79.41 E.20891
G1 X95.59 Y100.53 E.39464
; WIPE_START
M204 S6000
G1 X93.59 Y100.541 E-.285
; WIPE_END
G1 E-.015
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




G1 X85.606 Y96.932
M73 P56 R6
G1 Z.92
G1 E.3 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F2636
M204 S6000
G1 X85.606 Y98.629 E.03412
G1 X85.903 Y98.314 E.00871
G1 X86.358 Y98.001 E.01111
G1 X87.269 Y97.6 E.02001
G1 X87.724 Y97.457 E.00959
G1 X88.179 Y97.494 E.00918
G1 X88.634 Y98.599 E.02403
G1 X89.08 Y99.394 E.01832
G1 X92.397 Y99.394 E.06669
G1 X92.731 Y98.797 E.01375
G1 X93.186 Y98.314 E.01335
G1 X93.642 Y98.001 E.01111
G1 X94.394 Y97.67 E.01653
G1 X94.394 Y94.987 E.05393
G1 X94.097 Y94.672 E.0087
G1 X93.642 Y94.36 E.01111
G1 X92.731 Y93.958 E.02001
G1 X92.276 Y93.815 E.00959
G1 X91.821 Y93.852 E.00918
G1 X91.366 Y94.957 E.02403
G1 X90.91 Y95.769 E.01872
G1 X90.455 Y96.252 E.01335
G1 X90 Y96.565 E.01111
G1 X89.09 Y96.967 E.02001
G1 X88.634 Y97.11 E.00959
G1 X88.179 Y97.073 E.00918
G1 X87.724 Y95.968 E.02403
G1 X87.269 Y95.155 E.01872
G1 X86.814 Y94.672 E.01335
G1 X86.358 Y94.36 E.01111
G1 X85.606 Y94.028 E.01653
G1 X85.606 Y91.346 E.05393
G1 X85.903 Y91.031 E.00871
G1 X86.358 Y90.718 E.01111
G1 X87.269 Y90.317 E.02001
G1 X87.724 Y90.174 E.00959
G1 X88.179 Y90.211 E.00918
G1 X88.634 Y91.316 E.02403
G1 X89.09 Y92.128 E.01872
G1 X89.545 Y92.611 E.01335
G1 X90 Y92.924 E.01111
G1 X90.91 Y93.325 E.02001
G1 X91.366 Y93.468 E.00959
G1 X91.821 Y93.431 E.00918
G1 X92.276 Y92.326 E.02403
G1 X92.731 Y91.514 E.01872
G1 X93.186 Y91.031 E.01335
G1 X93.642 Y90.718 E.01111
G1 X94.394 Y90.386 E.01653
G1 X94.394 Y87.704 E.05393
G1 X94.097 Y87.389 E.0087
G1 X93.642 Y87.076 E.01111
G1 X92.731 Y86.675 E.02001
G1 X92.276 Y86.532 E.00959
G1 X91.821 Y86.569 E.00918
G1 X91.366 Y87.674 E.02403
G1 X90.91 Y88.486 E.01872
G1 X90.455 Y88.969 E.01335
G1 X90 Y89.282 E.01111
G1 X89.09 Y89.684 E.02001
G1 X88.634 Y89.826 E.00959
G1 X88.179 Y89.79 E.00918
G1 X87.724 Y88.684 E.02403
G1 X87.269 Y87.872 E.01872
G1 X86.814 Y87.389 E.01335
G1 X86.358 Y87.076 E.01111
G1 X85.606 Y86.745 E.01653
G1 X85.606 Y84.063 E.05393
G1 X85.903 Y83.748 E.00871
G1 X86.358 Y83.435 E.01111
G1 X87.269 Y83.033 E.02001
G1 X87.724 Y82.891 E.00959
G1 X88.179 Y82.927 E.00918
G1 X88.634 Y84.033 E.02403
G1 X89.09 Y84.845 E.01872
G1 X89.545 Y85.328 E.01335
G1 X90 Y85.641 E.01111
G1 X90.91 Y86.042 E.02001
G1 X91.366 Y86.185 E.00959
G1 X91.821 Y86.148 E.00918
G1 X92.276 Y85.043 E.02403
G1 X92.731 Y84.231 E.01872
G1 X93.186 Y83.748 E.01335
G1 X93.642 Y83.435 E.01111
G1 X94.394 Y83.103 E.01653
G1 X94.394 Y80.606 E.05021
G1 X91.245 Y80.606 E.06331
G1 X90.91 Y81.203 E.01376
G1 X90.455 Y81.686 E.01335
G1 X90 Y81.999 E.01111
G1 X89.09 Y82.4 E.02001
G1 X88.634 Y82.543 E.00959
G1 X88.179 Y82.506 E.00918
G1 X87.724 Y81.401 E.02403
G1 X87.278 Y80.606 E.01832
G1 X85.606 Y80.606 E.03362
G1 X85.606 Y80.631 E.0005
; CHANGE_LAYER
; Z_HEIGHT: 1.04
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F6000
G1 X85.606 Y80.606 E-.00354
G1 X87.278 Y80.606 E-.23828
G1 X87.427 Y80.871 E-.04318
; WIPE_END
G1 E-.015 F1800
; layer num/total_layer_count: 8/43
; update layer progress
M73 L8
M991 S0 P7 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z1.32 I-1.135 J.44 P1  F18000
G1 X94.757 Y99.757 Z1.32
G1 Z1.04
G1 E.3 F1800
; FEATURE: Inner wall
M73 P57 R6
G1 F2586
M204 S6000
G1 X85.243 Y99.757 E.19128
G1 X85.243 Y80.243 E.39236
G1 X94.757 Y80.243 E.19128
G1 X94.757 Y99.697 E.39115
M204 S10000
G1 X95.181 Y100.181 F18000
G1 F2586
M204 S6000
G1 X84.819 Y100.181 E.20834
G1 X84.819 Y79.819 E.40942
G1 X95.181 Y79.819 E.20834
G1 X95.181 Y100.121 E.40821
M204 S250
G1 X95.59 Y100.59 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1800
M204 S5000
G1 X84.41 Y100.59 E.20891
G1 X84.41 Y79.41 E.39576
G1 X95.59 Y79.41 E.20891
G1 X95.59 Y100.53 E.39464
; WIPE_START
M204 S6000
G1 X93.59 Y100.541 E-.285
; WIPE_END
G1 E-.015
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




G1 X85.606 Y96.907
G1 Z1.04
G1 E.3 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F2586
M204 S6000
G1 X85.606 Y98.604 E.03412
G1 X85.903 Y98.327 E.00817
G1 X86.358 Y98.052 E.01069
G1 X87.269 Y97.751 E.01928
G1 X87.724 Y97.737 E.00916
G1 X88.179 Y98.033 E.01091
G1 X88.634 Y98.793 E.01781
G1 X89.047 Y99.394 E.01465
G1 X92.291 Y99.394 E.06523
G1 X92.731 Y98.752 E.01565
G1 X93.186 Y98.327 E.01252
G1 X93.642 Y98.052 E.01069
G1 X94.394 Y97.803 E.01593
G1 X94.394 Y94.963 E.05712
G1 X94.097 Y94.686 E.00816
G1 X93.642 Y94.411 E.01069
G1 X92.731 Y94.109 E.01928
G1 X92.276 Y94.096 E.00916
G1 X91.821 Y94.391 E.01091
G1 X91.366 Y95.151 E.01781
G1 X90.91 Y95.814 E.01617
G1 X90.455 Y96.239 E.01252
G1 X90 Y96.514 E.01069
G1 X89.09 Y96.815 E.01928
G1 X88.634 Y96.829 E.00916
G1 X88.179 Y96.534 E.01091
G1 X87.724 Y95.774 E.01781
G1 X87.269 Y95.111 E.01617
G1 X86.814 Y94.686 E.01252
G1 X86.358 Y94.411 E.01069
G1 X85.606 Y94.162 E.01593
G1 X85.606 Y91.321 E.05712
G1 X85.903 Y91.044 E.00817
G1 X86.358 Y90.769 E.01069
G1 X87.269 Y90.468 E.01928
G1 X87.724 Y90.454 E.00916
G1 X88.179 Y90.75 E.01091
G1 X88.634 Y91.51 E.01781
G1 X89.09 Y92.173 E.01617
G1 X89.545 Y92.598 E.01252
G1 X90 Y92.873 E.01069
G1 X90.91 Y93.174 E.01928
G1 X91.366 Y93.188 E.00916
G1 X91.821 Y92.892 E.01091
G1 X92.276 Y92.132 E.01781
G1 X92.731 Y91.469 E.01617
G1 X93.186 Y91.044 E.01252
G1 X93.642 Y90.769 E.01069
G1 X94.394 Y90.52 E.01593
G1 X94.394 Y87.68 E.05712
G1 X94.097 Y87.403 E.00816
G1 X93.642 Y87.128 E.01069
G1 X92.731 Y86.826 E.01928
G1 X92.276 Y86.813 E.00916
G1 X91.821 Y87.108 E.01091
G1 X91.366 Y87.868 E.01781
G1 X90.91 Y88.531 E.01617
G1 X90.455 Y88.956 E.01252
G1 X90 Y89.231 E.01069
G1 X89.09 Y89.532 E.01928
G1 X88.634 Y89.546 E.00916
G1 X88.179 Y89.251 E.01091
G1 X87.724 Y88.491 E.01781
G1 X87.269 Y87.827 E.01617
G1 X86.814 Y87.403 E.01252
G1 X86.358 Y87.128 E.01069
G1 X85.606 Y86.879 E.01593
G1 X85.606 Y84.038 E.05712
G1 X85.903 Y83.761 E.00817
G1 X86.358 Y83.486 E.01069
G1 X87.269 Y83.185 E.01928
G1 X87.724 Y83.171 E.00916
G1 X88.179 Y83.467 E.01091
G1 X88.634 Y84.227 E.01781
G1 X89.09 Y84.89 E.01617
G1 X89.545 Y85.314 E.01252
M73 P58 R6
G1 X90 Y85.59 E.01069
G1 X90.91 Y85.891 E.01928
G1 X91.366 Y85.904 E.00916
G1 X91.821 Y85.609 E.01091
G1 X92.276 Y84.849 E.01781
G1 X92.731 Y84.186 E.01617
G1 X93.186 Y83.761 E.01252
G1 X93.642 Y83.486 E.01069
G1 X94.394 Y83.237 E.01593
G1 X94.394 Y80.606 E.0529
G1 X91.351 Y80.606 E.06118
G1 X90.91 Y81.248 E.01565
G1 X90.455 Y81.673 E.01252
G1 X90 Y81.948 E.01069
G1 X89.09 Y82.249 E.01928
G1 X88.634 Y82.263 E.00916
G1 X88.179 Y81.967 E.01091
G1 X87.724 Y81.207 E.01781
G1 X87.311 Y80.606 E.01466
G1 X85.615 Y80.606 E.03412
; CHANGE_LAYER
; Z_HEIGHT: 1.16
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F6000
G1 X87.311 Y80.606 E-.24182
G1 X87.483 Y80.856 E-.04318
; WIPE_END
G1 E-.015 F1800
; layer num/total_layer_count: 9/43
; update layer progress
M73 L9
M991 S0 P8 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z1.44 I-1.136 J.437 P1  F18000
G1 X94.757 Y99.757 Z1.44
G1 Z1.16
G1 E.3 F1800
; FEATURE: Inner wall
G1 F2562
M204 S6000
G1 X85.243 Y99.757 E.19128
G1 X85.243 Y80.243 E.39236
G1 X94.757 Y80.243 E.19128
G1 X94.757 Y99.697 E.39115
M204 S10000
G1 X95.181 Y100.181 F18000
G1 F2562
M204 S6000
G1 X84.819 Y100.181 E.20834
G1 X84.819 Y79.819 E.40942
G1 X95.181 Y79.819 E.20834
G1 X95.181 Y100.121 E.40821
M204 S250
G1 X95.59 Y100.59 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1800
M204 S5000
G1 X84.41 Y100.59 E.20891
G1 X84.41 Y79.41 E.39576
G1 X95.59 Y79.41 E.20891
G1 X95.59 Y100.53 E.39464
; WIPE_START
M204 S6000
G1 X93.59 Y100.541 E-.285
; WIPE_END
G1 E-.015
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




G1 X85.606 Y96.878
G1 Z1.16
G1 E.3 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F2562
M204 S6000
G1 X85.606 Y98.575 E.03412
G1 X85.903 Y98.332 E.00772
G1 X86.358 Y98.094 E.01033
G1 X87.269 Y97.883 E.01879
G1 X87.724 Y97.949 E.00925
G1 X88.179 Y98.297 E.01152
G1 X89.007 Y99.394 E.02762
G1 X92.146 Y99.394 E.06311
G1 X92.731 Y98.705 E.01817
G1 X93.186 Y98.332 E.01183
G1 X93.642 Y98.094 E.01033
G1 X94.394 Y97.92 E.01552
G1 X94.394 Y94.934 E.06004
G1 X94.097 Y94.691 E.00772
G1 X93.642 Y94.453 E.01033
G1 X92.731 Y94.242 E.01879
G1 X92.276 Y94.308 E.00925
G1 X91.821 Y94.656 E.01152
G1 X90.91 Y95.861 E.03038
G1 X90.455 Y96.234 E.01183
G1 X90 Y96.472 E.01033
G1 X89.09 Y96.683 E.01879
G1 X88.634 Y96.617 E.00925
G1 X88.179 Y96.269 E.01152
G1 X87.269 Y95.064 E.03038
G1 X86.814 Y94.691 E.01183
G1 X86.358 Y94.453 E.01033
G1 X85.606 Y94.278 E.01552
G1 X85.606 Y91.292 E.06004
G1 X85.903 Y91.049 E.00772
G1 X86.358 Y90.811 E.01033
G1 X87.269 Y90.6 E.01879
G1 X87.724 Y90.666 E.00925
G1 X88.179 Y91.014 E.01152
G1 X89.09 Y92.22 E.03038
G1 X89.545 Y92.593 E.01183
G1 X90 Y92.831 E.01033
G1 X90.91 Y93.042 E.01879
G1 X91.366 Y92.975 E.00925
G1 X91.821 Y92.627 E.01152
G1 X92.731 Y91.422 E.03038
G1 X93.186 Y91.049 E.01183
G1 X93.642 Y90.811 E.01033
G1 X94.394 Y90.637 E.01552
G1 X94.394 Y87.651 E.06004
G1 X94.097 Y87.408 E.00772
G1 X93.642 Y87.17 E.01033
G1 X92.731 Y86.959 E.01879
G1 X92.276 Y87.025 E.00925
M73 P59 R6
G1 X91.821 Y87.373 E.01152
G1 X90.91 Y88.578 E.03038
G1 X90.455 Y88.951 E.01183
G1 X90 Y89.189 E.01033
G1 X89.09 Y89.4 E.01879
G1 X88.634 Y89.334 E.00925
G1 X88.179 Y88.986 E.01152
G1 X87.269 Y87.78 E.03038
G1 X86.814 Y87.408 E.01183
G1 X86.358 Y87.17 E.01033
G1 X85.606 Y86.995 E.01552
G1 X85.606 Y84.009 E.06004
G1 X85.903 Y83.766 E.00772
G1 X86.358 Y83.528 E.01033
G1 X87.269 Y83.317 E.01879
G1 X87.724 Y83.383 E.00925
G1 X88.179 Y83.731 E.01152
G1 X89.09 Y84.937 E.03038
G1 X89.545 Y85.31 E.01183
G1 X90 Y85.547 E.01033
G1 X90.91 Y85.758 E.01879
G1 X91.366 Y85.692 E.00925
G1 X91.821 Y85.344 E.01152
G1 X92.731 Y84.139 E.03038
G1 X93.186 Y83.766 E.01183
G1 X93.642 Y83.528 E.01033
G1 X94.394 Y83.354 E.01552
G1 X94.394 Y80.606 E.05524
G1 X91.431 Y80.606 E.05958
G1 X90.91 Y81.295 E.01735
G1 X90.455 Y81.668 E.01183
G1 X90 Y81.906 E.01033
G1 X89.09 Y82.117 E.01879
G1 X88.634 Y82.051 E.00925
G1 X88.179 Y81.703 E.01152
G1 X87.351 Y80.606 E.02763
G1 X85.654 Y80.606 E.03412
; CHANGE_LAYER
; Z_HEIGHT: 1.28
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F6000
G1 X87.351 Y80.606 E-.24182
G1 X87.534 Y80.848 E-.04318
; WIPE_END
G1 E-.015 F1800
; layer num/total_layer_count: 10/43
; update layer progress
M73 L10
M991 S0 P9 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z1.56 I-1.137 J.434 P1  F18000
G1 X94.757 Y99.757 Z1.56
G1 Z1.28
G1 E.3 F1800
; FEATURE: Inner wall
G1 F2549
M204 S6000
G1 X85.243 Y99.757 E.19128
G1 X85.243 Y80.243 E.39236
G1 X94.757 Y80.243 E.19128
G1 X94.757 Y99.697 E.39115
M204 S10000
G1 X95.181 Y100.181 F18000
G1 F2549
M204 S6000
G1 X84.819 Y100.181 E.20834
G1 X84.819 Y79.819 E.40942
G1 X95.181 Y79.819 E.20834
G1 X95.181 Y100.121 E.40821
M204 S250
G1 X95.59 Y100.59 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1800
M204 S5000
G1 X84.41 Y100.59 E.20891
G1 X84.41 Y79.41 E.39576
G1 X95.59 Y79.41 E.20891
G1 X95.59 Y100.53 E.39464
; WIPE_START
M204 S6000
G1 X93.59 Y100.541 E-.285
; WIPE_END
G1 E-.015
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




G1 X86.452 Y99.394
G1 Z1.28
G1 E.3 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F2549
M204 S6000
G1 X85.606 Y99.394 E.01701
G1 X85.606 Y98.542 E.01712
G1 X85.903 Y98.33 E.00734
G1 X86.358 Y98.128 E.01001
G1 X86.814 Y98.018 E.00942
G1 X87.269 Y98 E.00916
G1 X87.724 Y98.123 E.00948
G1 X88.179 Y98.492 E.01179
G1 X88.953 Y99.394 E.02389
G1 X92.097 Y99.394 E.06322
G1 X92.731 Y98.656 E.01956
G1 X93.186 Y98.33 E.01126
G1 X93.642 Y98.128 E.01001
G1 X94.097 Y98.018 E.00942
G1 X94.394 Y98.006 E.00597
G1 X94.394 Y94.901 E.06244
G1 X94.097 Y94.688 E.00734
G1 X93.642 Y94.487 E.01001
G1 X93.186 Y94.377 E.00942
G1 X92.731 Y94.358 E.00916
G1 X92.276 Y94.481 E.00948
G1 X91.821 Y94.851 E.01179
G1 X90.91 Y95.911 E.0281
G1 X90.455 Y96.237 E.01126
G1 X90 Y96.438 E.01001
G1 X89.545 Y96.548 E.00942
G1 X89.09 Y96.567 E.00916
G1 X88.634 Y96.444 E.00948
G1 X88.179 Y96.074 E.01179
G1 X87.269 Y95.014 E.0281
G1 X86.814 Y94.688 E.01126
G1 X86.358 Y94.487 E.01001
G1 X85.903 Y94.377 E.00942
G1 X85.606 Y94.365 E.00598
G1 X85.606 Y91.259 E.06244
G1 X85.903 Y91.047 E.00734
G1 X86.358 Y90.845 E.01001
G1 X86.814 Y90.735 E.00942
G1 X87.269 Y90.717 E.00916
G1 X87.724 Y90.839 E.00948
G1 X88.179 Y91.209 E.01179
G1 X89.09 Y92.269 E.0281
G1 X89.545 Y92.595 E.01126
G1 X90 Y92.797 E.01001
G1 X90.455 Y92.907 E.00942
M73 P60 R6
G1 X90.91 Y92.925 E.00916
G1 X91.366 Y92.802 E.00948
G1 X91.821 Y92.433 E.01179
G1 X92.731 Y91.373 E.0281
G1 X93.186 Y91.047 E.01126
G1 X93.642 Y90.845 E.01001
G1 X94.097 Y90.735 E.00942
G1 X94.394 Y90.723 E.00597
G1 X94.394 Y87.618 E.06244
G1 X94.097 Y87.405 E.00734
G1 X93.642 Y87.204 E.01001
G1 X93.186 Y87.094 E.00942
G1 X92.731 Y87.075 E.00916
G1 X92.276 Y87.198 E.00948
G1 X91.821 Y87.568 E.01179
G1 X90.91 Y88.628 E.0281
G1 X90.455 Y88.954 E.01126
G1 X90 Y89.155 E.01001
G1 X89.545 Y89.265 E.00942
G1 X89.09 Y89.284 E.00916
G1 X88.634 Y89.161 E.00948
G1 X88.179 Y88.791 E.01179
G1 X87.269 Y87.731 E.0281
G1 X86.814 Y87.405 E.01126
G1 X86.358 Y87.204 E.01001
G1 X85.903 Y87.094 E.00942
G1 X85.606 Y87.081 E.00598
G1 X85.606 Y83.976 E.06244
G1 X85.903 Y83.763 E.00734
G1 X86.358 Y83.562 E.01001
G1 X86.814 Y83.452 E.00942
G1 X87.269 Y83.434 E.00916
G1 X87.724 Y83.556 E.00948
G1 X88.179 Y83.926 E.01179
G1 X89.09 Y84.986 E.0281
G1 X89.545 Y85.312 E.01126
G1 X90 Y85.513 E.01001
G1 X90.455 Y85.623 E.00942
G1 X90.91 Y85.642 E.00916
G1 X91.366 Y85.519 E.00948
G1 X91.821 Y85.15 E.01179
G1 X92.731 Y84.089 E.0281
G1 X93.186 Y83.763 E.01126
G1 X93.642 Y83.562 E.01001
G1 X94.097 Y83.452 E.00942
G1 X94.394 Y83.44 E.00597
G1 X94.394 Y80.606 E.05698
G1 X91.544 Y80.606 E.05729
G1 X90.91 Y81.344 E.01956
G1 X90.455 Y81.67 E.01126
G1 X90 Y81.872 E.01001
G1 X89.545 Y81.982 E.00942
G1 X89.09 Y82 E.00916
G1 X88.634 Y81.878 E.00948
G1 X88.179 Y81.508 E.01179
G1 X87.405 Y80.606 E.0239
G1 X85.708 Y80.606 E.03412
; CHANGE_LAYER
; Z_HEIGHT: 1.4
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F6000
G1 X87.405 Y80.606 E-.24182
G1 X87.602 Y80.836 E-.04318
; WIPE_END
G1 E-.015 F1800
; layer num/total_layer_count: 11/43
; update layer progress
M73 L11
M991 S0 P10 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z1.68 I-1.138 J.43 P1  F18000
G1 X94.757 Y99.757 Z1.68
G1 Z1.4
G1 E.3 F1800
; FEATURE: Inner wall
G1 F2540
M204 S6000
G1 X85.243 Y99.757 E.19128
G1 X85.243 Y80.243 E.39236
G1 X94.757 Y80.243 E.19128
G1 X94.757 Y99.697 E.39115
M204 S10000
G1 X95.181 Y100.181 F18000
G1 F2540
M204 S6000
G1 X84.819 Y100.181 E.20834
G1 X84.819 Y79.819 E.40942
G1 X95.181 Y79.819 E.20834
G1 X95.181 Y100.121 E.40821
M204 S250
G1 X95.59 Y100.59 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1800
M204 S5000
G1 X84.41 Y100.59 E.20891
G1 X84.41 Y79.41 E.39576
G1 X95.59 Y79.41 E.20891
G1 X95.59 Y100.53 E.39464
; WIPE_START
M204 S6000
G1 X93.59 Y100.541 E-.285
; WIPE_END
G1 E-.015
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




G1 X86.415 Y99.394
G1 Z1.4
G1 E.3 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F2540
M204 S6000
G1 X85.606 Y99.394 E.01626
G1 X85.606 Y98.505 E.01787
G1 X85.903 Y98.321 E.00703
G1 X86.358 Y98.155 E.00974
G1 X86.814 Y98.08 E.00927
G1 X87.269 Y98.103 E.00916
G1 X87.724 Y98.27 E.00975
G1 X88.179 Y98.652 E.01195
G1 X88.888 Y99.394 E.02062
G1 X91.976 Y99.394 E.06208
G1 X92.731 Y98.604 E.02198
G1 X93.186 Y98.321 E.01078
G1 X93.642 Y98.155 E.00974
G1 X94.097 Y98.08 E.00927
G1 X94.394 Y98.095 E.00598
G1 X94.394 Y94.864 E.06498
G1 X94.097 Y94.679 E.00703
G1 X93.642 Y94.513 E.00974
G1 X93.186 Y94.439 E.00927
G1 X92.731 Y94.462 E.00916
G1 X92.276 Y94.629 E.00975
G1 X91.821 Y95.011 E.01195
G1 X90.91 Y95.963 E.02649
G1 X90.455 Y96.246 E.01078
G1 X90 Y96.412 E.00974
G1 X89.545 Y96.486 E.00927
G1 X89.09 Y96.463 E.00916
G1 X88.634 Y96.296 E.00975
G1 X88.179 Y95.914 E.01195
G1 X87.269 Y94.962 E.02649
G1 X86.814 Y94.679 E.01078
G1 X86.358 Y94.513 E.00974
G1 X85.903 Y94.439 E.00927
G1 X85.606 Y94.454 E.00598
M73 P60 R5
G1 X85.606 Y91.222 E.06498
G1 X85.903 Y91.037 E.00703
G1 X86.358 Y90.871 E.00974
G1 X86.814 Y90.797 E.00927
G1 X87.269 Y90.82 E.00916
G1 X87.724 Y90.987 E.00975
G1 X88.179 Y91.369 E.01195
G1 X89.09 Y92.321 E.02649
G1 X89.545 Y92.604 E.01078
G1 X90 Y92.77 E.00974
G1 X90.455 Y92.844 E.00927
G1 X90.91 Y92.822 E.00916
G1 X91.366 Y92.655 E.00975
M73 P61 R5
G1 X91.821 Y92.273 E.01195
G1 X92.731 Y91.32 E.02649
G1 X93.186 Y91.037 E.01078
G1 X93.642 Y90.871 E.00974
G1 X94.097 Y90.797 E.00927
G1 X94.394 Y90.812 E.00598
G1 X94.394 Y87.58 E.06498
G1 X94.097 Y87.396 E.00703
G1 X93.642 Y87.23 E.00974
G1 X93.186 Y87.156 E.00927
G1 X92.731 Y87.178 E.00916
G1 X92.276 Y87.346 E.00975
G1 X91.821 Y87.728 E.01195
G1 X90.91 Y88.68 E.02649
G1 X90.455 Y88.963 E.01078
G1 X90 Y89.129 E.00974
G1 X89.545 Y89.203 E.00927
G1 X89.09 Y89.18 E.00916
G1 X88.634 Y89.013 E.00975
G1 X88.179 Y88.631 E.01195
G1 X87.269 Y87.679 E.02649
G1 X86.814 Y87.396 E.01078
G1 X86.358 Y87.23 E.00974
G1 X85.903 Y87.156 E.00927
G1 X85.606 Y87.171 E.00598
G1 X85.606 Y83.939 E.06498
G1 X85.903 Y83.754 E.00703
G1 X86.358 Y83.588 E.00974
G1 X86.814 Y83.514 E.00927
G1 X87.269 Y83.537 E.00916
G1 X87.724 Y83.704 E.00975
G1 X88.179 Y84.086 E.01195
G1 X89.09 Y85.038 E.02649
G1 X89.545 Y85.321 E.01078
G1 X90 Y85.487 E.00974
G1 X90.455 Y85.561 E.00927
G1 X90.91 Y85.539 E.00916
G1 X91.366 Y85.372 E.00975
G1 X91.821 Y84.989 E.01195
G1 X92.731 Y84.037 E.02649
G1 X93.186 Y83.754 E.01078
G1 X93.642 Y83.588 E.00974
G1 X94.097 Y83.514 E.00927
G1 X94.394 Y83.529 E.00598
G1 X94.394 Y80.606 E.05877
G1 X91.666 Y80.606 E.05484
G1 X90.91 Y81.397 E.02199
G1 X90.455 Y81.68 E.01078
G1 X90 Y81.846 E.00974
G1 X89.545 Y81.92 E.00927
G1 X89.09 Y81.897 E.00916
G1 X88.634 Y81.73 E.00975
G1 X88.179 Y81.348 E.01195
G1 X87.47 Y80.606 E.02063
G1 X85.773 Y80.606 E.03412
; CHANGE_LAYER
; Z_HEIGHT: 1.52
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F6000
G1 X87.47 Y80.606 E-.24182
G1 X87.68 Y80.825 E-.04318
; WIPE_END
G1 E-.015 F1800
; layer num/total_layer_count: 12/43
; update layer progress
M73 L12
M991 S0 P11 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z1.8 I-1.14 J.426 P1  F18000
G1 X94.757 Y99.757 Z1.8
G1 Z1.52
G1 E.3 F1800
; FEATURE: Inner wall
G1 F2535
M204 S6000
G1 X85.243 Y99.757 E.19128
G1 X85.243 Y80.243 E.39236
G1 X94.757 Y80.243 E.19128
G1 X94.757 Y99.697 E.39115
M204 S10000
G1 X95.181 Y100.181 F18000
G1 F2535
M204 S6000
G1 X84.819 Y100.181 E.20834
G1 X84.819 Y79.819 E.40942
G1 X95.181 Y79.819 E.20834
G1 X95.181 Y100.121 E.40821
M204 S250
G1 X95.59 Y100.59 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1800
M204 S5000
G1 X84.41 Y100.59 E.20891
G1 X84.41 Y79.41 E.39576
G1 X95.59 Y79.41 E.20891
G1 X95.59 Y100.53 E.39464
; WIPE_START
M204 S6000
G1 X93.59 Y100.541 E-.285
; WIPE_END
G1 E-.015
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




G1 X86.373 Y99.394
G1 Z1.52
G1 E.3 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F2535
M204 S6000
G1 X85.606 Y99.394 E.01542
G1 X85.606 Y98.464 E.0187
G1 X85.903 Y98.305 E.00677
G1 X86.358 Y98.174 E.00952
G1 X86.814 Y98.135 E.00919
G1 X87.269 Y98.196 E.00923
G1 X87.724 Y98.4 E.01004
G1 X88.179 Y98.793 E.01208
G1 X88.634 Y99.274 E.01333
G1 X88.775 Y99.394 E.00371
G1 X91.841 Y99.394 E.06165
G1 X92.276 Y98.934 E.01272
G1 X92.731 Y98.548 E.01199
G1 X93.186 Y98.305 E.01038
G1 X93.642 Y98.174 E.00952
G1 X94.097 Y98.135 E.00919
G1 X94.394 Y98.174 E.00602
G1 X94.394 Y94.822 E.06741
G1 X94.097 Y94.663 E.00677
G1 X93.642 Y94.532 E.00952
G1 X93.186 Y94.493 E.00919
G1 X92.731 Y94.554 E.00923
G1 X92.276 Y94.759 E.01004
G1 X91.821 Y95.151 E.01208
G1 X91.366 Y95.633 E.01333
G1 X90.91 Y96.018 E.01199
G1 X90.455 Y96.261 E.01038
G1 X90 Y96.393 E.00952
G1 X89.545 Y96.432 E.00919
G1 X89.09 Y96.371 E.00923
G1 X88.634 Y96.166 E.01004
G1 X88.179 Y95.774 E.01208
G1 X87.724 Y95.292 E.01333
G1 X87.269 Y94.907 E.01199
G1 X86.814 Y94.663 E.01038
G1 X86.358 Y94.532 E.00952
G1 X85.903 Y94.493 E.00919
G1 X85.606 Y94.533 E.00602
G1 X85.606 Y91.18 E.06741
G1 X85.903 Y91.022 E.00677
G1 X86.358 Y90.891 E.00952
G1 X86.814 Y90.851 E.00919
G1 X87.269 Y90.912 E.00923
G1 X87.724 Y91.117 E.01004
G1 X88.179 Y91.509 E.01208
G1 X88.634 Y91.991 E.01333
M73 P62 R5
G1 X89.09 Y92.377 E.01199
G1 X89.545 Y92.62 E.01038
G1 X90 Y92.751 E.00952
G1 X90.455 Y92.79 E.00919
G1 X90.91 Y92.729 E.00923
G1 X91.366 Y92.525 E.01004
G1 X91.821 Y92.132 E.01208
G1 X92.276 Y91.651 E.01333
G1 X92.731 Y91.265 E.01199
G1 X93.186 Y91.022 E.01038
G1 X93.642 Y90.891 E.00952
G1 X94.097 Y90.851 E.00919
G1 X94.394 Y90.891 E.00602
G1 X94.394 Y87.539 E.06741
G1 X94.097 Y87.38 E.00677
G1 X93.642 Y87.249 E.00952
G1 X93.186 Y87.21 E.00919
G1 X92.731 Y87.271 E.00923
G1 X92.276 Y87.476 E.01004
G1 X91.821 Y87.868 E.01208
G1 X91.366 Y88.35 E.01333
G1 X90.91 Y88.735 E.01199
G1 X90.455 Y88.978 E.01038
G1 X90 Y89.109 E.00952
G1 X89.545 Y89.149 E.00919
G1 X89.09 Y89.088 E.00923
G1 X88.634 Y88.883 E.01004
G1 X88.179 Y88.491 E.01208
G1 X87.724 Y88.009 E.01333
G1 X87.269 Y87.623 E.01199
G1 X86.814 Y87.38 E.01038
G1 X86.358 Y87.249 E.00952
G1 X85.903 Y87.21 E.00919
G1 X85.606 Y87.25 E.00602
G1 X85.606 Y83.897 E.06741
G1 X85.903 Y83.739 E.00677
G1 X86.358 Y83.608 E.00952
G1 X86.814 Y83.568 E.00919
G1 X87.269 Y83.629 E.00923
G1 X87.724 Y83.834 E.01004
G1 X88.179 Y84.226 E.01208
G1 X88.634 Y84.708 E.01333
G1 X89.09 Y85.094 E.01199
G1 X89.545 Y85.337 E.01038
G1 X90 Y85.468 E.00952
G1 X90.455 Y85.507 E.00919
G1 X90.91 Y85.446 E.00923
G1 X91.366 Y85.241 E.01004
G1 X91.821 Y84.849 E.01208
G1 X92.276 Y84.367 E.01333
G1 X92.731 Y83.982 E.01199
G1 X93.186 Y83.739 E.01038
G1 X93.642 Y83.608 E.00952
G1 X94.097 Y83.568 E.00919
G1 X94.394 Y83.608 E.00602
G1 X94.394 Y80.606 E.06036
G1 X91.8 Y80.606 E.05214
G1 X91.366 Y81.066 E.01273
G1 X90.91 Y81.452 E.01199
G1 X90.455 Y81.695 E.01038
G1 X90 Y81.826 E.00952
G1 X89.545 Y81.866 E.00919
G1 X89.09 Y81.805 E.00923
G1 X88.634 Y81.6 E.01004
G1 X88.179 Y81.208 E.01208
G1 X87.724 Y80.726 E.01333
G1 X87.583 Y80.606 E.00372
G1 X85.886 Y80.606 E.03412
; CHANGE_LAYER
; Z_HEIGHT: 1.64
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F6000
G1 X87.583 Y80.606 E-.24182
G1 X87.724 Y80.726 E-.02635
G1 X87.805 Y80.812 E-.01683
; WIPE_END
G1 E-.015 F1800
; layer num/total_layer_count: 13/43
; update layer progress
M73 L13
M991 S0 P12 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z1.92 I-1.142 J.419 P1  F18000
G1 X94.757 Y99.757 Z1.92
G1 Z1.64
G1 E.3 F1800
; FEATURE: Inner wall
G1 F3207
M204 S6000
G1 X85.243 Y99.757 E.19128
G1 X85.243 Y80.243 E.39236
G1 X94.757 Y80.243 E.19128
G1 X94.757 Y99.697 E.39115
M204 S10000
G1 X95.181 Y100.181 F18000
G1 F3207
M204 S6000
G1 X84.819 Y100.181 E.20834
G1 X84.819 Y79.819 E.40942
G1 X95.181 Y79.819 E.20834
G1 X95.181 Y100.121 E.40821
M204 S250
G1 X95.59 Y100.59 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1800
M204 S5000
G1 X84.41 Y100.59 E.20891
G1 X84.41 Y79.41 E.39576
G1 X95.59 Y79.41 E.20891
G1 X95.59 Y100.53 E.39464
; WIPE_START
M204 S6000
G1 X93.59 Y100.541 E-.285
; WIPE_END
G1 E-.015
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




G1 X86.001 Y96.566
G1 Z1.64
G1 E.3 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F3207
M204 S6000
G1 X86.001 Y98.263 E.03412
G1 X86.358 Y98.187 E.00736
G1 X86.814 Y98.181 E.00915
G1 X87.269 Y98.279 E.00936
G1 X87.724 Y98.518 E.01034
G1 X88.258 Y98.999 E.01445
G1 X92.109 Y98.999 E.07744
G1 X92.276 Y98.833 E.00473
G1 X92.731 Y98.489 E.01148
G1 X93.186 Y98.283 E.01004
G1 X93.642 Y98.187 E.00936
G1 X93.999 Y98.183 E.00719
G1 X93.999 Y94.621 E.07161
G1 X93.642 Y94.545 E.00735
G1 X93.186 Y94.54 E.00915
G1 X92.731 Y94.637 E.00936
G1 X92.276 Y94.877 E.01034
G1 X91.821 Y95.279 E.01222
G1 X91.366 Y95.733 E.01293
G1 X90.91 Y96.078 E.01148
G1 X90.455 Y96.283 E.01004
G1 X90 Y96.38 E.00936
G1 X89.545 Y96.385 E.00915
G1 X89.09 Y96.288 E.00936
G1 X88.634 Y96.048 E.01034
G1 X88.179 Y95.645 E.01222
G1 X87.724 Y95.192 E.01293
G1 X87.269 Y94.847 E.01148
G1 X86.814 Y94.642 E.01004
G1 X86.358 Y94.545 E.00936
G1 X86.001 Y94.541 E.00719
G1 X86.001 Y90.98 E.07161
G1 X86.358 Y90.903 E.00736
G1 X86.814 Y90.898 E.00915
G1 X87.269 Y90.996 E.00936
G1 X87.724 Y91.235 E.01034
G1 X88.179 Y91.638 E.01222
G1 X88.634 Y92.092 E.01293
G1 X89.09 Y92.436 E.01148
G1 X89.545 Y92.642 E.01004
G1 X90 Y92.738 E.00936
G1 X90.455 Y92.743 E.00915
G1 X90.91 Y92.646 E.00936
G1 X91.366 Y92.407 E.01034
G1 X91.821 Y92.004 E.01222
G1 X92.276 Y91.55 E.01293
G1 X92.731 Y91.206 E.01148
G1 X93.186 Y91 E.01004
M73 P63 R5
G1 X93.642 Y90.903 E.00936
G1 X93.999 Y90.899 E.00719
G1 X93.999 Y87.338 E.07161
G1 X93.642 Y87.262 E.00735
G1 X93.186 Y87.257 E.00915
G1 X92.731 Y87.354 E.00936
G1 X92.276 Y87.593 E.01034
G1 X91.821 Y87.996 E.01222
G1 X91.366 Y88.45 E.01293
G1 X90.91 Y88.794 E.01148
G1 X90.455 Y89 E.01004
G1 X90 Y89.097 E.00936
G1 X89.545 Y89.102 E.00915
G1 X89.09 Y89.004 E.00936
G1 X88.634 Y88.765 E.01034
G1 X88.179 Y88.362 E.01222
G1 X87.724 Y87.908 E.01293
G1 X87.269 Y87.564 E.01148
G1 X86.814 Y87.359 E.01004
G1 X86.358 Y87.262 E.00936
G1 X86.001 Y87.258 E.00719
G1 X86.001 Y83.696 E.07161
G1 X86.358 Y83.62 E.00736
G1 X86.814 Y83.615 E.00915
G1 X87.269 Y83.713 E.00936
G1 X87.724 Y83.952 E.01034
G1 X88.179 Y84.355 E.01222
G1 X88.634 Y84.809 E.01293
G1 X89.09 Y85.153 E.01148
G1 X89.545 Y85.358 E.01004
G1 X90 Y85.455 E.00936
G1 X90.455 Y85.46 E.00915
G1 X90.91 Y85.363 E.00936
G1 X91.366 Y85.124 E.01034
G1 X91.821 Y84.721 E.01222
G1 X92.276 Y84.267 E.01293
G1 X92.731 Y83.923 E.01148
G1 X93.186 Y83.717 E.01004
G1 X93.642 Y83.62 E.00936
G1 X93.999 Y83.616 E.00719
G1 X93.999 Y81.001 E.05259
G1 X91.532 Y81.001 E.0496
G1 X91.366 Y81.167 E.00474
G1 X90.91 Y81.511 E.01148
G1 X90.455 Y81.717 E.01004
G1 X90 Y81.814 E.00936
G1 X89.545 Y81.819 E.00915
G1 X89.09 Y81.721 E.00936
G1 X88.634 Y81.482 E.01034
G1 X88.101 Y81.001 E.01446
G1 X86.404 Y81.001 E.03412
; WIPE_START
G1 F6000
G1 X88.101 Y81.001 E-.24182
G1 X88.326 Y81.204 E-.04318
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X94.378 Y80.789 Z2.04 F18000
G1 Z1.64
G1 E.3 F1800
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.378272
G1 F3207
M204 S6000
G1 X94.364 Y80.72 E.00118
; LINE_WIDTH: 0.394966
G1 X94.349 Y80.651 E.00123
G1 X94.211 Y80.622 E.00246
; LINE_WIDTH: 0.365752
G1 X85.789 Y80.622 E.13573
; LINE_WIDTH: 0.378272
G1 X85.72 Y80.636 E.00118
; LINE_WIDTH: 0.394966
G1 X85.651 Y80.651 E.00123
G1 X85.622 Y80.789 E.00246
; LINE_WIDTH: 0.365752
G1 X85.622 Y99.211 E.29688
; LINE_WIDTH: 0.378272
G1 X85.636 Y99.28 E.00118
; LINE_WIDTH: 0.394966
G1 X85.651 Y99.349 E.00123
G1 X85.789 Y99.378 E.00246
; LINE_WIDTH: 0.365752
G1 X94.211 Y99.378 E.13573
; LINE_WIDTH: 0.378272
G1 X94.28 Y99.364 E.00118
; LINE_WIDTH: 0.394966
G1 X94.349 Y99.349 E.00123
G1 X94.378 Y99.211 E.00246
; LINE_WIDTH: 0.365752
G1 X94.378 Y80.849 E.29591
; CHANGE_LAYER
; Z_HEIGHT: 1.76
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F3840
G1 X94.378 Y82.849 E-.285
; WIPE_END
G1 E-.015 F1800
; layer num/total_layer_count: 14/43
; update layer progress
M73 L14
M991 S0 P13 ;notify layer change
M106 S61.2
; OBJECT_ID: 8
M204 S10000
G17
G3 Z2.04 I-1.217 J.027 P1  F18000
G1 X94.757 Y99.757 Z2.04
G1 Z1.76
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F3600
M204 S6000
G1 X85.243 Y99.757 E.19128
G1 X85.243 Y80.243 E.39236
G1 X94.757 Y80.243 E.19128
G1 X94.757 Y99.697 E.39115
M204 S10000
G1 X95.181 Y100.181 F18000
G1 F3600
M204 S6000
G1 X84.819 Y100.181 E.20834
G1 X84.819 Y79.819 E.40942
G1 X95.181 Y79.819 E.20834
G1 X95.181 Y100.121 E.40821
M204 S250
G1 X95.59 Y100.59 F18000
M106 S229.5
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1800
M204 S5000
G1 X84.41 Y100.59 E.20891
G1 X84.41 Y79.41 E.39576
G1 X95.59 Y79.41 E.20891
G1 X95.59 Y100.53 E.39464
; WIPE_START
M204 S6000
G1 X93.59 Y100.541 E-.285
; WIPE_END
G1 E-.015
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




G1 X85.417 Y98.218
G1 Z1.76
G1 E.3 F1800
; FEATURE: Bridge
; LINE_WIDTH: 0.40408
; LAYER_HEIGHT: 0.4
G1 F2807.23
M204 S6000
G1 X86.047 Y99.381 E.06699
G1 X86.564 Y99.381 E.02616
G1 X85.619 Y97.639 E.10036
G1 X85.619 Y96.686 E.04825
G1 X87.08 Y99.381 E.15525
G1 X87.597 Y99.381 E.02616
G1 X85.619 Y95.734 E.21014
G1 X85.619 Y94.781 E.04825
G1 X88.113 Y99.381 E.26503
G1 X88.63 Y99.381 E.02616
G1 X85.619 Y93.828 E.31991
G1 X85.619 Y92.876 E.04825
G1 X89.146 Y99.381 E.3748
G1 X89.663 Y99.381 E.02616
G1 X85.619 Y91.923 E.42969
G1 X85.619 Y90.97 E.04825
G1 X90.179 Y99.381 E.48458
G1 X90.696 Y99.381 E.02616
G1 X85.619 Y90.018 E.53947
G1 X85.619 Y89.065 E.04825
G1 X91.212 Y99.381 E.59436
G1 X91.729 Y99.381 E.02616
G1 X85.619 Y88.112 E.64925
G1 X85.619 Y87.16 E.04825
G1 X92.245 Y99.381 E.70414
G1 X92.762 Y99.381 E.02616
G1 X85.619 Y86.207 E.75903
G1 X85.619 Y85.254 E.04825
G1 X93.278 Y99.381 E.81392
G1 X93.795 Y99.381 E.02616
G1 X85.619 Y84.302 E.86881
G1 X85.619 Y83.349 E.04825
G1 X94.311 Y99.381 E.9237
G1 X94.381 Y99.381 E.00352
G1 X94.381 Y98.556 E.04176
G1 X85.619 Y82.396 E.93108
G1 X85.619 Y81.444 E.04825
G1 X94.381 Y97.604 E.93108
G1 X94.381 Y96.651 E.04825
G1 X85.689 Y80.619 E.92369
G1 X86.205 Y80.619 E.02616
G1 X94.381 Y95.698 E.86881
G1 X94.381 Y94.746 E.04825
G1 X86.722 Y80.619 E.81392
G1 X87.238 Y80.619 E.02616
G1 X94.381 Y93.793 E.75903
G1 X94.381 Y92.84 E.04825
G1 X87.755 Y80.619 E.70414
M73 P64 R5
G1 X88.271 Y80.619 E.02616
G1 X94.381 Y91.888 E.64925
G1 X94.381 Y90.935 E.04825
G1 X88.788 Y80.619 E.59436
G1 X89.304 Y80.619 E.02616
G1 X94.381 Y89.982 E.53947
G1 X94.381 Y89.03 E.04825
G1 X89.821 Y80.619 E.48458
G1 X90.337 Y80.619 E.02616
G1 X94.381 Y88.077 E.42969
G1 X94.381 Y87.124 E.04825
G1 X90.854 Y80.619 E.3748
G1 X91.37 Y80.619 E.02616
G1 X94.381 Y86.172 E.31991
G1 X94.381 Y85.219 E.04825
G1 X91.887 Y80.619 E.26502
G1 X92.403 Y80.619 E.02616
G1 X94.381 Y84.266 E.21013
G1 X94.381 Y83.314 E.04825
G1 X92.92 Y80.619 E.15524
G1 X93.437 Y80.619 E.02616
G1 X94.381 Y82.361 E.10035
G1 X94.381 Y81.408 E.04825
G1 X93.843 Y80.417 E.05713
M106 S61.2
; CHANGE_LAYER
; Z_HEIGHT: 1.88
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F2807.23
G1 X94.381 Y81.408 E-.16073
G1 X94.381 Y82.28 E-.12427
; WIPE_END
G1 E-.015 F1800
; layer num/total_layer_count: 15/43
; update layer progress
M73 L15
M991 S0 P14 ;notify layer change
M106 S68.85
; OBJECT_ID: 8
M204 S10000
G17
G3 Z2.16 I-1.217 J.026 P1  F18000
G1 X94.757 Y99.757 Z2.16
G1 Z1.88
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F3600
M204 S6000
G1 X85.243 Y99.757 E.19128
G1 X85.243 Y80.243 E.39236
G1 X94.757 Y80.243 E.19128
G1 X94.757 Y99.697 E.39115
M204 S10000
G1 X95.181 Y100.181 F18000
G1 F3600
M204 S6000
G1 X84.819 Y100.181 E.20834
G1 X84.819 Y79.819 E.40942
G1 X95.181 Y79.819 E.20834
G1 X95.181 Y100.121 E.40821
M204 S250
G1 X95.59 Y100.59 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1800
M204 S5000
G1 X84.41 Y100.59 E.20891
G1 X84.41 Y79.41 E.39576
G1 X95.59 Y79.41 E.20891
G1 X95.59 Y100.53 E.39464
; WIPE_START
M204 S6000
G1 X93.59 Y100.541 E-.285
; WIPE_END
G1 E-.015
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




G1 X86.227 Y99.586
G1 Z1.88
G1 E.3 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.427712
G1 F4800
M204 S6000
M73 P65 R5
G1 X85.591 Y98.95 E.01714
G1 X85.591 Y98.382 E.01083
G1 X86.618 Y99.409 E.02767
G1 X87.187 Y99.409 E.01083
G1 X85.591 Y97.813 E.04299
G1 X85.591 Y97.245 E.01083
G1 X87.755 Y99.409 E.0583
G1 X88.324 Y99.409 E.01083
G1 X85.591 Y96.676 E.07362
G1 X85.591 Y96.108 E.01083
G1 X88.892 Y99.409 E.08894
G1 X89.461 Y99.409 E.01083
G1 X85.591 Y95.539 E.10425
G1 X85.591 Y94.971 E.01083
G1 X90.029 Y99.409 E.11957
G1 X90.598 Y99.409 E.01083
G1 X85.591 Y94.402 E.13488
G1 X85.591 Y93.834 E.01083
G1 X91.166 Y99.409 E.1502
G1 X91.735 Y99.409 E.01083
G1 X85.591 Y93.265 E.16551
G1 X85.591 Y92.697 E.01083
G1 X92.303 Y99.409 E.18083
G1 X92.871 Y99.409 E.01083
G1 X85.591 Y92.129 E.19614
G1 X85.591 Y91.56 E.01083
G1 X93.44 Y99.409 E.21146
G1 X94.008 Y99.409 E.01083
G1 X85.591 Y90.992 E.22678
G1 X85.591 Y90.423 E.01083
G1 X94.409 Y99.24 E.23756
G1 X94.409 Y98.672 E.01083
G1 X85.591 Y89.855 E.23756
G1 X85.591 Y89.286 E.01083
G1 X94.409 Y98.104 E.23756
G1 X94.409 Y97.535 E.01083
G1 X85.591 Y88.718 E.23756
G1 X85.591 Y88.149 E.01083
G1 X94.409 Y96.967 E.23756
G1 X94.409 Y96.398 E.01083
G1 X85.591 Y87.581 E.23756
G1 X85.591 Y87.012 E.01083
G1 X94.409 Y95.83 E.23756
G1 X94.409 Y95.261 E.01083
G1 X85.591 Y86.444 E.23756
G1 X85.591 Y85.876 E.01083
G1 X94.409 Y94.693 E.23756
G1 X94.409 Y94.124 E.01083
G1 X85.591 Y85.307 E.23756
G1 X85.591 Y84.739 E.01083
G1 X94.409 Y93.556 E.23756
G1 X94.409 Y92.987 E.01083
G1 X85.591 Y84.17 E.23756
G1 X85.591 Y83.602 E.01083
G1 X94.409 Y92.419 E.23756
G1 X94.409 Y91.851 E.01083
G1 X85.591 Y83.033 E.23756
G1 X85.591 Y82.465 E.01083
G1 X94.409 Y91.282 E.23756
G1 X94.409 Y90.714 E.01083
G1 X85.591 Y81.896 E.23756
G1 X85.591 Y81.328 E.01083
G1 X94.409 Y90.145 E.23756
G1 X94.409 Y89.577 E.01083
G1 X85.591 Y80.759 E.23756
G1 X85.591 Y80.591 E.0032
G1 X85.992 Y80.591 E.00763
G1 X94.409 Y89.008 E.22677
G1 X94.409 Y88.44 E.01083
G1 X86.56 Y80.591 E.21146
G1 X87.129 Y80.591 E.01083
G1 X94.409 Y87.871 E.19614
G1 X94.409 Y87.303 E.01083
M73 P66 R5
G1 X87.697 Y80.591 E.18083
G1 X88.266 Y80.591 E.01083
G1 X94.409 Y86.734 E.16551
G1 X94.409 Y86.166 E.01083
G1 X88.834 Y80.591 E.15019
G1 X89.403 Y80.591 E.01083
G1 X94.409 Y85.598 E.13488
G1 X94.409 Y85.029 E.01083
G1 X89.971 Y80.591 E.11956
G1 X90.539 Y80.591 E.01083
G1 X94.409 Y84.461 E.10425
G1 X94.409 Y83.892 E.01083
G1 X91.108 Y80.591 E.08893
G1 X91.676 Y80.591 E.01083
G1 X94.409 Y83.324 E.07362
G1 X94.409 Y82.755 E.01083
G1 X92.245 Y80.591 E.0583
G1 X92.813 Y80.591 E.01083
G1 X94.409 Y82.187 E.04298
G1 X94.409 Y81.618 E.01083
G1 X93.382 Y80.591 E.02767
G1 X93.95 Y80.591 E.01083
G1 X94.586 Y81.227 E.01713
; CHANGE_LAYER
; Z_HEIGHT: 2
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F4800
G1 X93.95 Y80.591 E-.12815
G1 X93.382 Y80.591 E-.08101
G1 X93.758 Y80.968 E-.07584
; WIPE_END
G1 E-.015 F1800
; layer num/total_layer_count: 16/43
; update layer progress
M73 L16
M991 S0 P15 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z2.28 I-1.215 J.065 P1  F18000
G1 X94.757 Y99.757 Z2.28
G1 Z2
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F3600
M204 S6000
G1 X85.243 Y99.757 E.19128
G1 X85.243 Y80.243 E.39236
G1 X94.757 Y80.243 E.19128
G1 X94.757 Y99.697 E.39115
M204 S10000
G1 X95.181 Y100.181 F18000
G1 F3600
M204 S6000
G1 X84.819 Y100.181 E.20834
G1 X84.819 Y79.819 E.40942
G1 X95.181 Y79.819 E.20834
G1 X95.181 Y100.121 E.40821
M204 S250
G1 X95.59 Y100.59 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1800
M204 S5000
G1 X84.41 Y100.59 E.20891
G1 X84.41 Y79.41 E.39576
G1 X95.59 Y79.41 E.20891
G1 X95.59 Y100.53 E.39464
; WIPE_START
M204 S6000
G1 X93.59 Y100.541 E-.285
; WIPE_END
G1 E-.015
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




G1 X93.773 Y99.586
G1 Z2
G1 E.3 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.427712
G1 F4800
M204 S6000
G1 X94.409 Y98.95 E.01713
G1 X94.409 Y98.382 E.01083
G1 X93.382 Y99.409 E.02767
G1 X92.813 Y99.409 E.01083
G1 X94.409 Y97.813 E.04298
G1 X94.409 Y97.245 E.01083
G1 X92.245 Y99.409 E.0583
G1 X91.676 Y99.409 E.01083
G1 X94.409 Y96.676 E.07362
G1 X94.409 Y96.108 E.01083
G1 X91.108 Y99.409 E.08893
G1 X90.539 Y99.409 E.01083
G1 X94.409 Y95.539 E.10425
G1 X94.409 Y94.971 E.01083
G1 X89.971 Y99.409 E.11956
G1 X89.403 Y99.409 E.01083
G1 X94.409 Y94.403 E.13488
G1 X94.409 Y93.834 E.01083
G1 X88.834 Y99.409 E.15019
G1 X88.266 Y99.409 E.01083
G1 X94.409 Y93.266 E.16551
G1 X94.409 Y92.697 E.01083
G1 X87.697 Y99.409 E.18082
G1 X87.129 Y99.409 E.01083
G1 X94.409 Y92.129 E.19614
G1 X94.409 Y91.56 E.01083
G1 X86.56 Y99.409 E.21146
G1 X85.992 Y99.409 E.01083
G1 X94.409 Y90.992 E.22677
G1 X94.409 Y90.423 E.01083
G1 X85.591 Y99.241 E.23756
G1 X85.591 Y98.672 E.01083
G1 X94.409 Y89.855 E.23756
G1 X94.409 Y89.286 E.01083
G1 X85.591 Y98.104 E.23756
G1 X85.591 Y97.535 E.01083
G1 X94.409 Y88.718 E.23756
G1 X94.409 Y88.149 E.01083
G1 X85.591 Y96.967 E.23756
G1 X85.591 Y96.398 E.01083
G1 X94.409 Y87.581 E.23756
G1 X94.409 Y87.013 E.01083
G1 X85.591 Y95.83 E.23756
G1 X85.591 Y95.261 E.01083
G1 X94.409 Y86.444 E.23756
M73 P67 R5
G1 X94.409 Y85.876 E.01083
G1 X85.591 Y94.693 E.23756
G1 X85.591 Y94.125 E.01083
G1 X94.409 Y85.307 E.23756
G1 X94.409 Y84.739 E.01083
G1 X85.591 Y93.556 E.23756
G1 X85.591 Y92.988 E.01083
G1 X94.409 Y84.17 E.23756
M73 P67 R4
G1 X94.409 Y83.602 E.01083
G1 X85.591 Y92.419 E.23756
G1 X85.591 Y91.851 E.01083
G1 X94.409 Y83.033 E.23756
G1 X94.409 Y82.465 E.01083
G1 X85.591 Y91.282 E.23756
G1 X85.591 Y90.714 E.01083
G1 X94.409 Y81.896 E.23756
G1 X94.409 Y81.328 E.01083
G1 X85.591 Y90.145 E.23756
G1 X85.591 Y89.577 E.01083
G1 X94.409 Y80.76 E.23756
G1 X94.409 Y80.591 E.0032
G1 X94.008 Y80.591 E.00763
G1 X85.591 Y89.008 E.22678
G1 X85.591 Y88.44 E.01083
G1 X93.44 Y80.591 E.21146
G1 X92.871 Y80.591 E.01083
G1 X85.591 Y87.871 E.19614
G1 X85.591 Y87.303 E.01083
G1 X92.303 Y80.591 E.18083
G1 X91.735 Y80.591 E.01083
G1 X85.591 Y86.735 E.16551
G1 X85.591 Y86.166 E.01083
G1 X91.166 Y80.591 E.1502
G1 X90.598 Y80.591 E.01083
G1 X85.591 Y85.598 E.13488
G1 X85.591 Y85.029 E.01083
G1 X90.029 Y80.591 E.11957
G1 X89.461 Y80.591 E.01083
G1 X85.591 Y84.461 E.10425
G1 X85.591 Y83.892 E.01083
G1 X88.892 Y80.591 E.08894
G1 X88.324 Y80.591 E.01083
G1 X85.591 Y83.324 E.07362
G1 X85.591 Y82.755 E.01083
G1 X87.755 Y80.591 E.0583
G1 X87.187 Y80.591 E.01083
G1 X85.591 Y82.187 E.04299
G1 X85.591 Y81.618 E.01083
G1 X86.618 Y80.591 E.02767
G1 X86.05 Y80.591 E.01083
G1 X85.414 Y81.227 E.01714
; CHANGE_LAYER
; Z_HEIGHT: 2.12
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F4800
G1 X86.05 Y80.591 E-.12819
G1 X86.618 Y80.591 E-.08101
G1 X86.242 Y80.968 E-.07581
; WIPE_END
G1 E-.015 F1800
; layer num/total_layer_count: 17/43
; update layer progress
M73 L17
M991 S0 P16 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z2.4 I-1.108 J.502 P1  F18000
G1 X94.757 Y99.757 Z2.4
G1 Z2.12
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F3600
M204 S6000
G1 X85.243 Y99.757 E.19128
G1 X85.243 Y80.243 E.39236
G1 X94.757 Y80.243 E.19128
G1 X94.757 Y99.697 E.39115
M204 S10000
G1 X95.181 Y100.181 F18000
G1 F3600
M204 S6000
G1 X84.819 Y100.181 E.20834
G1 X84.819 Y79.819 E.40942
G1 X95.181 Y79.819 E.20834
G1 X95.181 Y100.121 E.40821
M204 S250
G1 X95.59 Y100.59 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1800
M204 S5000
G1 X84.41 Y100.59 E.20891
G1 X84.41 Y79.41 E.39576
G1 X95.59 Y79.41 E.20891
G1 X95.59 Y100.53 E.39464
; WIPE_START
M204 S6000
G1 X93.59 Y100.541 E-.285
; WIPE_END
G1 E-.015
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




G1 X86.227 Y99.586
G1 Z2.12
G1 E.3 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.427712
M73 P68 R4
G1 F4800
M204 S6000
G1 X85.591 Y98.95 E.01714
G1 X85.591 Y98.382 E.01083
G1 X86.618 Y99.409 E.02767
G1 X87.187 Y99.409 E.01083
G1 X85.591 Y97.813 E.04299
G1 X85.591 Y97.245 E.01083
G1 X87.755 Y99.409 E.0583
G1 X88.324 Y99.409 E.01083
G1 X85.591 Y96.676 E.07362
G1 X85.591 Y96.108 E.01083
G1 X88.892 Y99.409 E.08894
G1 X89.461 Y99.409 E.01083
G1 X85.591 Y95.539 E.10425
G1 X85.591 Y94.971 E.01083
G1 X90.029 Y99.409 E.11957
G1 X90.598 Y99.409 E.01083
G1 X85.591 Y94.402 E.13488
G1 X85.591 Y93.834 E.01083
G1 X91.166 Y99.409 E.1502
G1 X91.735 Y99.409 E.01083
G1 X85.591 Y93.265 E.16551
G1 X85.591 Y92.697 E.01083
G1 X92.303 Y99.409 E.18083
G1 X92.871 Y99.409 E.01083
G1 X85.591 Y92.129 E.19614
G1 X85.591 Y91.56 E.01083
G1 X93.44 Y99.409 E.21146
G1 X94.008 Y99.409 E.01083
G1 X85.591 Y90.992 E.22678
G1 X85.591 Y90.423 E.01083
G1 X94.409 Y99.24 E.23756
G1 X94.409 Y98.672 E.01083
G1 X85.591 Y89.855 E.23756
G1 X85.591 Y89.286 E.01083
G1 X94.409 Y98.104 E.23756
G1 X94.409 Y97.535 E.01083
G1 X85.591 Y88.718 E.23756
G1 X85.591 Y88.149 E.01083
G1 X94.409 Y96.967 E.23756
G1 X94.409 Y96.398 E.01083
G1 X85.591 Y87.581 E.23756
G1 X85.591 Y87.012 E.01083
G1 X94.409 Y95.83 E.23756
G1 X94.409 Y95.261 E.01083
G1 X85.591 Y86.444 E.23756
G1 X85.591 Y85.876 E.01083
G1 X94.409 Y94.693 E.23756
G1 X94.409 Y94.124 E.01083
G1 X85.591 Y85.307 E.23756
G1 X85.591 Y84.739 E.01083
G1 X94.409 Y93.556 E.23756
G1 X94.409 Y92.987 E.01083
G1 X85.591 Y84.17 E.23756
G1 X85.591 Y83.602 E.01083
G1 X94.409 Y92.419 E.23756
G1 X94.409 Y91.851 E.01083
G1 X85.591 Y83.033 E.23756
G1 X85.591 Y82.465 E.01083
G1 X94.409 Y91.282 E.23756
G1 X94.409 Y90.714 E.01083
G1 X85.591 Y81.896 E.23756
G1 X85.591 Y81.328 E.01083
G1 X94.409 Y90.145 E.23756
G1 X94.409 Y89.577 E.01083
G1 X85.591 Y80.759 E.23756
G1 X85.591 Y80.591 E.0032
G1 X85.992 Y80.591 E.00763
G1 X94.409 Y89.008 E.22677
G1 X94.409 Y88.44 E.01083
G1 X86.56 Y80.591 E.21146
G1 X87.129 Y80.591 E.01083
G1 X94.409 Y87.871 E.19614
G1 X94.409 Y87.303 E.01083
G1 X87.697 Y80.591 E.18083
G1 X88.266 Y80.591 E.01083
G1 X94.409 Y86.734 E.16551
G1 X94.409 Y86.166 E.01083
G1 X88.834 Y80.591 E.15019
G1 X89.403 Y80.591 E.01083
G1 X94.409 Y85.598 E.13488
G1 X94.409 Y85.029 E.01083
G1 X89.971 Y80.591 E.11956
G1 X90.539 Y80.591 E.01083
G1 X94.409 Y84.461 E.10425
G1 X94.409 Y83.892 E.01083
M73 P69 R4
G1 X91.108 Y80.591 E.08893
G1 X91.676 Y80.591 E.01083
G1 X94.409 Y83.324 E.07362
G1 X94.409 Y82.755 E.01083
G1 X92.245 Y80.591 E.0583
G1 X92.813 Y80.591 E.01083
G1 X94.409 Y82.187 E.04298
G1 X94.409 Y81.618 E.01083
G1 X93.382 Y80.591 E.02767
G1 X93.95 Y80.591 E.01083
G1 X94.586 Y81.227 E.01713
; CHANGE_LAYER
; Z_HEIGHT: 2.24
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F4800
G1 X93.95 Y80.591 E-.12815
G1 X93.382 Y80.591 E-.08101
G1 X93.758 Y80.968 E-.07584
; WIPE_END
G1 E-.015 F1800
; layer num/total_layer_count: 18/43
; update layer progress
M73 L18
M991 S0 P17 ;notify layer change
M106 S61.2
; OBJECT_ID: 8
M204 S10000
G17
G3 Z2.52 I-1.188 J-.265 P1  F18000
G1 X91.424 Y91.425 Z2.52
G1 Z2.24
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F3600
M204 S6000
G1 X88.575 Y91.425 E.05729
G1 X88.575 Y88.576 E.05729
G1 X91.424 Y88.576 E.05728
G1 X91.424 Y91.365 E.05608
M204 S10000
G1 X91.849 Y91.849 F18000
G1 F3600
M204 S6000
G1 X88.151 Y91.849 E.07435
G1 X88.151 Y88.151 E.07435
G1 X91.849 Y88.151 E.07435
G1 X91.849 Y91.789 E.07314
; WIPE_START
G1 X89.849 Y91.821 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X94.03 Y98.207 Z2.64 F18000
G1 X95.59 Y100.59 Z2.64
G1 Z2.24
G1 E.3 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
M204 S5000
G1 X84.41 Y100.59 E.20891
G1 X84.41 Y79.41 E.39576
G1 X95.59 Y79.41 E.20891
G1 X95.59 Y100.53 E.39464
; WIPE_START
M204 S6000
G1 X93.59 Y100.541 E-.285
; WIPE_END
G1 E-.015
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




G1 X95.373 Y99.959
G1 Z2.24
G1 E.3 F1800
; FEATURE: Top surface
G1 F3600
M204 S2000
G1 X94.959 Y100.373 E.01094
G1 X94.402 Y100.373
G1 X95.373 Y99.402 E.02568
G1 X95.373 Y98.844
G1 X93.844 Y100.373 E.04041
G1 X93.286 Y100.373
G1 X95.373 Y98.286 E.05514
G1 X95.373 Y97.729
G1 X92.729 Y100.373 E.06988
G1 X92.171 Y100.373
G1 X95.373 Y97.171 E.08461
G1 X95.373 Y96.614
G1 X91.614 Y100.373 E.09934
G1 X91.056 Y100.373
G1 X95.373 Y96.056 E.11408
G1 X95.373 Y95.499
G1 X90.499 Y100.373 E.12881
G1 X89.941 Y100.373
G1 X95.373 Y94.941 E.14354
G1 X95.373 Y94.384
G1 X89.384 Y100.373 E.15828
G1 X88.826 Y100.373
G1 X95.373 Y93.826 E.17301
G1 X95.373 Y93.269
G1 X88.269 Y100.373 E.18774
G1 X87.711 Y100.373
G1 X95.373 Y92.711 E.20247
G1 X95.373 Y92.154
G1 X87.154 Y100.373 E.21721
G1 X86.596 Y100.373
G1 X95.373 Y91.596 E.23194
G1 X95.373 Y91.038
G1 X86.038 Y100.373 E.24667
G1 X85.481 Y100.373
G1 X95.373 Y90.481 E.26141
G1 X95.373 Y89.923
G1 X84.923 Y100.373 E.27614
G1 X84.627 Y100.112
G1 X95.373 Y89.366 E.28398
G1 X95.373 Y88.808
G1 X84.627 Y99.555 E.28398
G1 X84.627 Y98.997
G1 X91.543 Y92.081 E.18277
G1 X90.986 Y92.081
G1 X84.627 Y98.44 E.16804
G1 X84.627 Y97.882
G1 X90.428 Y92.081 E.1533
G1 X89.871 Y92.081
G1 X84.627 Y97.324 E.13857
G1 X84.627 Y96.767
G1 X89.313 Y92.081 E.12384
G1 X88.756 Y92.081
G1 X84.627 Y96.209 E.1091
G1 X84.627 Y95.652
G1 X88.198 Y92.081 E.09437
G1 X87.919 Y91.802
G1 X84.627 Y95.094 E.087
M73 P70 R4
G1 X84.627 Y94.537
G1 X87.919 Y91.244 E.087
G1 X87.919 Y90.687
G1 X84.627 Y93.979 E.087
G1 X84.627 Y93.422
G1 X87.919 Y90.129 E.087
G1 X87.919 Y89.572
G1 X84.627 Y92.864 E.087
G1 X84.627 Y92.307
G1 X87.919 Y89.014 E.087
G1 X87.919 Y88.457
G1 X84.627 Y91.749 E.087
; WIPE_START
M204 S6000
G1 X86.041 Y90.335 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X93.49 Y88.671 Z2.64 F18000
G1 X95.373 Y88.251 Z2.64
G1 Z2.24
G1 E.3 F1800
G1 F3600
M204 S2000
G1 X92.081 Y91.543 E.08701
G1 X92.081 Y90.986
G1 X95.373 Y87.693 E.08701
G1 X95.373 Y87.136
G1 X92.081 Y90.428 E.08701
G1 X92.081 Y89.871
G1 X95.373 Y86.578 E.08701
G1 X95.373 Y86.021
G1 X92.081 Y89.313 E.08701
G1 X92.081 Y88.756
G1 X95.373 Y85.463 E.08701
G1 X95.373 Y84.906
G1 X92.081 Y88.198 E.08701
G1 X91.802 Y87.92
G1 X95.373 Y84.348 E.09438
G1 X95.373 Y83.79
G1 X91.244 Y87.919 E.10911
G1 X90.687 Y87.919
G1 X95.373 Y83.233 E.12384
G1 X95.373 Y82.675
G1 X90.129 Y87.919 E.13858
G1 X89.572 Y87.919
G1 X95.373 Y82.118 E.15331
G1 X95.373 Y81.56
G1 X89.014 Y87.919 E.16804
G1 X88.457 Y87.919
G1 X95.373 Y81.003 E.18277
G1 X95.373 Y80.445
G1 X84.627 Y91.192 E.28398
G1 X84.627 Y90.634
G1 X95.373 Y79.888 E.28398
G1 X95.076 Y79.627
G1 X84.627 Y90.076 E.27614
G1 X84.627 Y89.519
G1 X94.519 Y79.627 E.2614
G1 X93.961 Y79.627
G1 X84.627 Y88.961 E.24667
G1 X84.627 Y88.404
G1 X93.404 Y79.627 E.23194
G1 X92.846 Y79.627
G1 X84.627 Y87.846 E.2172
G1 X84.627 Y87.289
G1 X92.289 Y79.627 E.20247
G1 X91.731 Y79.627
G1 X84.627 Y86.731 E.18774
G1 X84.627 Y86.174
G1 X91.174 Y79.627 E.173
G1 X90.616 Y79.627
G1 X84.627 Y85.616 E.15827
G1 X84.627 Y85.059
G1 X90.059 Y79.627 E.14354
G1 X89.501 Y79.627
G1 X84.627 Y84.501 E.1288
G1 X84.627 Y83.944
G1 X88.944 Y79.627 E.11407
G1 X88.386 Y79.627
G1 X84.627 Y83.386 E.09934
G1 X84.627 Y82.828
G1 X87.828 Y79.627 E.0846
G1 X87.271 Y79.627
G1 X84.627 Y82.271 E.06987
G1 X84.627 Y81.713
G1 X86.713 Y79.627 E.05514
G1 X86.156 Y79.627
G1 X84.627 Y81.156 E.04041
G1 X84.627 Y80.598
G1 X85.598 Y79.627 E.02567
G1 X85.041 Y79.627
G1 X84.627 Y80.041 E.01094
; WIPE_START
M204 S6000
G1 X85.041 Y79.627 E-.08342
G1 X85.598 Y79.627 E-.07945
G1 X84.992 Y80.233 E-.12213
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X88.59 Y86.964 Z2.64 F18000
G1 X90.212 Y90 Z2.64
G1 Z2.24
G1 E.3 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.449642
G1 F4800
M204 S6000
G1 X90.212 Y89.788 E.00426
G1 X89.788 Y89.788 E.00852
G1 X89.788 Y90.212 E.00852
G1 X90.212 Y90.212 E.00852
G1 X90.212 Y90.06 E.00305
M204 S10000
M73 P71 R4
G1 X90.621 Y90 F18000
; LINE_WIDTH: 0.419992
G1 F4800
M204 S6000
G1 X90.621 Y89.379 E.0116
G1 X89.379 Y89.379 E.02321
G1 X89.379 Y90.621 E.02321
G1 X90.621 Y90.621 E.02321
G1 X90.621 Y90.06 E.01048
M204 S10000
G1 X91.015 Y90 F18000
G1 F4800
M204 S6000
G1 X91.015 Y88.985 E.01897
G1 X88.985 Y88.985 E.03794
G1 X88.985 Y91.015 E.03794
G1 X91.015 Y91.015 E.03794
G1 X91.015 Y90.06 E.01785
; CHANGE_LAYER
; Z_HEIGHT: 2.36
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F4800
G1 X91.015 Y91.015 E-.13613
G1 X89.971 Y91.015 E-.14887
; WIPE_END
G1 E-.015 F1800
; layer num/total_layer_count: 19/43
; update layer progress
M73 L19
M991 S0 P18 ;notify layer change
M106 S73.95
; OBJECT_ID: 8
M204 S10000
G17
G3 Z2.64 I1.011 J-.678 P1  F18000
G1 X87.843 Y87.844 Z2.64
G1 Z2.36
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F872
M204 S6000
G1 X92.156 Y87.844 E.08672
G1 X92.157 Y92.157 E.08672
G1 X87.843 Y92.157 E.08672
G1 X87.843 Y87.904 E.08552
M204 S10000
G1 X87.419 Y87.419 F18000
G1 F872
M204 S6000
G1 X92.58 Y87.42 E.10378
G1 X92.581 Y92.581 E.10378
G1 X87.419 Y92.581 E.10379
G1 X87.419 Y87.479 E.10258
M204 S250
G1 X87.071 Y87.01 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F872
M204 S5000
G1 X92.936 Y87.01 E.1096
G1 X92.976 Y87.024 E.00078
G1 X92.99 Y87.064 E.00078
G1 X92.99 Y92.929 E.1096
G1 X92.975 Y92.975 E.00091
G1 X92.929 Y92.99 E.00091
G1 X87.071 Y92.99 E.10947
G1 X87.025 Y92.975 E.00091
G1 X87.01 Y92.929 E.00091
G1 X87.01 Y87.071 E.10947
G1 X87.021 Y87.036 E.00069
; WIPE_START
G1 F1800
M204 S6000
G1 X89.021 Y87.027 E-.285
; WIPE_END
G1 E-.015
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




G1 X90.184 Y90
G1 Z2.36
G1 E.3 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.393122
G1 F872
M204 S6000
G1 X90.184 Y89.816 E.0032
G1 X89.816 Y89.816 E.0064
G1 X89.816 Y90.184 E.0064
G1 X90.184 Y90.184 E.0064
G1 X90.184 Y90.06 E.00215
M204 S10000
G1 X90.564 Y90 F18000
; LINE_WIDTH: 0.419992
G1 F872
M204 S6000
G1 X90.564 Y89.436 E.01055
G1 X89.435 Y89.436 E.02109
G1 X89.435 Y90.565 E.0211
G1 X90.564 Y90.565 E.0211
G1 X90.564 Y90.06 E.00943
M204 S10000
G1 X90.959 Y90 F18000
G1 F872
M204 S6000
G1 X90.959 Y89.041 E.01791
G1 X89.041 Y89.041 E.03583
G1 X89.041 Y90.959 E.03583
G1 X90.959 Y90.959 E.03583
G1 X90.959 Y90.06 E.01679
M204 S10000
G1 X91.353 Y90 F18000
G1 F872
M204 S6000
G1 X91.353 Y88.647 E.02528
G1 X88.647 Y88.647 E.05056
G1 X88.647 Y91.353 E.05056
G1 X91.353 Y91.353 E.05056
G1 X91.353 Y90.06 E.02416
M204 S10000
G1 X91.747 Y90 F18000
G1 F872
M204 S6000
G1 X91.747 Y88.253 E.03264
G1 X88.253 Y88.253 E.06529
G1 X88.253 Y91.747 E.0653
G1 X91.747 Y91.747 E.0653
G1 X91.747 Y90.06 E.03153
; CHANGE_LAYER
; Z_HEIGHT: 2.48
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F4800
G1 X91.747 Y91.747 E-.24044
G1 X91.435 Y91.747 E-.04456
; WIPE_END
G1 E-.015 F1800
; layer num/total_layer_count: 20/43
; update layer progress
M73 L20
M991 S0 P19 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z2.76 I.896 J-.824 P1  F18000
G1 X87.843 Y87.843 Z2.76
G1 Z2.48
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F873
M204 S6000
G1 X92.156 Y87.843 E.08672
G1 X92.157 Y92.157 E.08672
G1 X87.843 Y92.157 E.08672
G1 X87.843 Y87.903 E.08552
M204 S10000
G1 X87.419 Y87.419 F18000
G1 F873
M204 S6000
M73 P72 R4
G1 X92.58 Y87.419 E.10378
G1 X92.581 Y92.581 E.10379
G1 X87.419 Y92.581 E.10379
G1 X87.419 Y87.479 E.10258
M204 S250
G1 X87.071 Y87.01 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F873
M204 S5000
G1 X92.93 Y87.01 E.10949
G1 X92.977 Y87.026 E.00093
G1 X92.99 Y87.064 E.00074
G1 X92.99 Y92.929 E.10961
G1 X92.975 Y92.975 E.0009
G1 X92.929 Y92.99 E.0009
G1 X87.071 Y92.99 E.10947
G1 X87.025 Y92.975 E.0009
G1 X87.01 Y92.929 E.0009
G1 X87.01 Y87.071 E.10948
G1 X87.021 Y87.036 E.00068
; WIPE_START
G1 F1800
M204 S6000
G1 X89.021 Y87.027 E-.285
; WIPE_END
G1 E-.015
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




G1 X90.184 Y90
G1 Z2.48
G1 E.3 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.393118
G1 F873
M204 S6000
G1 X90.184 Y89.816 E.0032
G1 X89.816 Y89.816 E.0064
G1 X89.816 Y90.184 E.0064
G1 X90.184 Y90.184 E.0064
G1 X90.184 Y90.06 E.00216
M204 S10000
G1 X90.564 Y90 F18000
; LINE_WIDTH: 0.419992
G1 F873
M204 S6000
G1 X90.564 Y89.435 E.01055
G1 X89.435 Y89.435 E.02109
G1 X89.435 Y90.565 E.0211
G1 X90.564 Y90.565 E.0211
G1 X90.564 Y90.06 E.00943
M204 S10000
G1 X90.959 Y90 F18000
G1 F873
M204 S6000
G1 X90.959 Y89.041 E.01791
G1 X89.041 Y89.041 E.03583
G1 X89.041 Y90.959 E.03583
G1 X90.959 Y90.959 E.03583
G1 X90.959 Y90.06 E.0168
M204 S10000
G1 X91.353 Y90 F18000
G1 F873
M204 S6000
G1 X91.353 Y88.647 E.02528
G1 X88.647 Y88.647 E.05056
G1 X88.647 Y91.353 E.05056
G1 X91.353 Y91.353 E.05056
G1 X91.353 Y90.06 E.02416
M204 S10000
G1 X91.747 Y90 F18000
G1 F873
M204 S6000
G1 X91.747 Y88.253 E.03265
G1 X88.253 Y88.253 E.06529
G1 X88.253 Y91.747 E.0653
G1 X91.747 Y91.747 E.0653
G1 X91.747 Y90.06 E.03153
; CHANGE_LAYER
; Z_HEIGHT: 2.6
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F4800
G1 X91.747 Y91.747 E-.24046
G1 X91.435 Y91.747 E-.04454
; WIPE_END
G1 E-.015 F1800
; layer num/total_layer_count: 21/43
; update layer progress
M73 L21
M991 S0 P20 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z2.88 I-.953 J.757 P1  F18000
G1 X93.6 Y94.471 Z2.88
G1 Z2.6
G1 E.3 F1800
; FEATURE: Support interface
; LINE_WIDTH: 0.42
G1 F1020
M204 S6000
G1 X86.4 Y94.471 E.13455
; WIPE_START
G1 F4800
G1 X88.4 Y94.471 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X86.734 Y87.023 Z3 F18000
M73 P73 R4
G1 X86.4 Y85.529 Z3
G1 Z2.6
G1 E.3 F1800
G1 F1020
M204 S6000
G1 X93.6 Y85.529 E.13455
; WIPE_START
G1 F4800
G1 X91.6 Y85.529 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X87.843 Y87.843 Z3 F18000
G1 Z2.6
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1020
M204 S6000
G1 X92.156 Y87.844 E.08672
G1 X92.157 Y92.157 E.08672
G1 X87.843 Y92.157 E.08672
G1 X87.843 Y87.903 E.08552
M204 S10000
G1 X87.419 Y87.419 F18000
G1 F1020
M204 S6000
G1 X92.58 Y87.419 E.10378
G1 X92.581 Y92.581 E.10378
G1 X87.419 Y92.581 E.10379
G1 X87.419 Y87.479 E.10258
M204 S250
G1 X87.071 Y87.01 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1020
M204 S5000
G1 X92.931 Y87.01 E.1095
G1 X92.978 Y87.026 E.00092
G1 X92.99 Y87.064 E.00074
G1 X92.99 Y92.929 E.1096
G1 X92.975 Y92.975 E.00091
G1 X92.929 Y92.99 E.00091
G1 X87.071 Y92.99 E.10947
G1 X87.025 Y92.975 E.0009
G1 X87.01 Y92.929 E.00091
G1 X87.01 Y87.071 E.10947
G1 X87.021 Y87.036 E.00069
; WIPE_START
G1 F1800
M204 S6000
G1 X89.021 Y87.027 E-.285
; WIPE_END
G1 E-.015
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




G1 X90.184 Y90
G1 Z2.6
G1 E.3 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.393118
G1 F1020
M204 S6000
G1 X90.184 Y89.816 E.0032
G1 X89.816 Y89.816 E.0064
G1 X89.816 Y90.184 E.0064
G1 X90.184 Y90.184 E.0064
G1 X90.184 Y90.06 E.00216
M204 S10000
G1 X90.564 Y90 F18000
; LINE_WIDTH: 0.419992
G1 F1020
M204 S6000
G1 X90.564 Y89.435 E.01055
G1 X89.435 Y89.435 E.02109
G1 X89.435 Y90.565 E.0211
G1 X90.564 Y90.565 E.0211
G1 X90.564 Y90.06 E.00943
M204 S10000
G1 X90.959 Y90 F18000
G1 F1020
M204 S6000
G1 X90.959 Y89.041 E.01791
G1 X89.041 Y89.041 E.03583
G1 X89.041 Y90.959 E.03583
G1 X90.959 Y90.959 E.03583
G1 X90.959 Y90.06 E.0168
M204 S10000
G1 X91.353 Y90 F18000
G1 F1020
M204 S6000
G1 X91.353 Y88.647 E.02528
G1 X88.647 Y88.647 E.05056
G1 X88.647 Y91.353 E.05056
G1 X91.353 Y91.353 E.05056
G1 X91.353 Y90.06 E.02416
M204 S10000
M73 P73 R3
G1 X91.747 Y90 F18000
G1 F1020
M204 S6000
G1 X91.747 Y88.253 E.03265
G1 X88.253 Y88.253 E.06529
G1 X88.253 Y91.747 E.0653
G1 X91.747 Y91.747 E.0653
G1 X91.747 Y90.06 E.03153
; CHANGE_LAYER
; Z_HEIGHT: 2.72
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F4800
G1 X91.747 Y91.747 E-.24046
G1 X91.435 Y91.747 E-.04454
; WIPE_END
G1 E-.015 F1800
; layer num/total_layer_count: 22/43
; update layer progress
M73 L22
M991 S0 P21 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z3 I.896 J-.824 P1  F18000
G1 X87.843 Y87.843 Z3
G1 Z2.72
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F873
M204 S6000
M73 P74 R3
G1 X92.156 Y87.844 E.08672
G1 X92.157 Y92.157 E.08672
G1 X87.843 Y92.157 E.08672
G1 X87.843 Y87.903 E.08552
M204 S10000
G1 X87.419 Y87.419 F18000
G1 F873
M204 S6000
G1 X92.58 Y87.419 E.10378
G1 X92.581 Y92.581 E.10378
G1 X87.419 Y92.581 E.10379
G1 X87.419 Y87.479 E.10258
M204 S250
G1 X87.071 Y87.01 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F873
M204 S5000
G1 X92.932 Y87.01 E.10951
G1 X92.977 Y87.026 E.0009
G1 X92.99 Y87.063 E.00074
G1 X92.99 Y92.929 E.10962
G1 X92.975 Y92.975 E.0009
G1 X92.929 Y92.99 E.0009
G1 X87.071 Y92.99 E.10947
G1 X87.025 Y92.975 E.0009
G1 X87.01 Y92.929 E.00091
G1 X87.01 Y87.071 E.10947
G1 X87.021 Y87.036 E.00069
; WIPE_START
G1 F1800
M204 S6000
G1 X89.021 Y87.027 E-.285
; WIPE_END
G1 E-.015
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




G1 X90.184 Y90
G1 Z2.72
G1 E.3 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.393122
G1 F873
M204 S6000
G1 X90.184 Y89.816 E.0032
G1 X89.816 Y89.816 E.0064
G1 X89.816 Y90.184 E.0064
G1 X90.184 Y90.184 E.0064
G1 X90.184 Y90.06 E.00216
M204 S10000
G1 X90.564 Y90 F18000
; LINE_WIDTH: 0.419992
G1 F873
M204 S6000
G1 X90.564 Y89.435 E.01055
G1 X89.435 Y89.435 E.02109
G1 X89.435 Y90.565 E.0211
G1 X90.564 Y90.565 E.0211
G1 X90.564 Y90.06 E.00943
M204 S10000
G1 X90.959 Y90 F18000
G1 F873
M204 S6000
G1 X90.959 Y89.041 E.01791
G1 X89.041 Y89.041 E.03583
G1 X89.041 Y90.959 E.03583
G1 X90.959 Y90.959 E.03583
G1 X90.959 Y90.06 E.0168
M204 S10000
G1 X91.353 Y90 F18000
G1 F873
M204 S6000
G1 X91.353 Y88.647 E.02528
G1 X88.647 Y88.647 E.05056
G1 X88.647 Y91.353 E.05056
G1 X91.353 Y91.353 E.05056
G1 X91.353 Y90.06 E.02416
M204 S10000
G1 X91.747 Y90 F18000
G1 F873
M204 S6000
G1 X91.747 Y88.253 E.03265
G1 X88.253 Y88.253 E.06529
G1 X88.253 Y91.747 E.0653
G1 X91.747 Y91.747 E.0653
G1 X91.747 Y90.06 E.03153
; CHANGE_LAYER
; Z_HEIGHT: 2.84
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F4800
G1 X91.747 Y91.747 E-.24046
G1 X91.435 Y91.747 E-.04454
; WIPE_END
G1 E-.015 F1800
; layer num/total_layer_count: 23/43
; update layer progress
M73 L23
M991 S0 P22 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z3.12 I-1.114 J.491 P1  F18000
G1 X92.683 Y94.58 Z3.12
G1 Z2.84
G1 E.3 F1800
; FEATURE: Support interface
; LINE_WIDTH: 0.42
; LAYER_HEIGHT: 0.24
G1 F804
M204 S6000
G1 X92.683 Y93.797 E.02737
G1 X91.788 Y93.797 E.03124
M73 P75 R3
G1 X91.788 Y94.403 E.02117
G1 X90.894 Y94.403 E.03124
G1 X90.894 Y93.797 E.02117
G1 X90 Y93.797 E.03124
G1 X90 Y94.403 E.02117
G1 X89.106 Y94.403 E.03124
G1 X89.106 Y93.797 E.02117
G1 X88.212 Y93.797 E.03124
G1 X88.212 Y94.403 E.02117
G1 X87.317 Y94.403 E.03124
G1 X87.317 Y93.62 E.02737
; WIPE_START
G1 F4070.606
G1 X87.317 Y94.403 E-.11164
G1 X88.212 Y94.403 E-.12743
G1 X88.212 Y94.081 E-.04593
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X87.428 Y86.489 Z3.24 F18000
G1 X87.317 Y85.42 Z3.24
G1 Z2.84
G1 E.3 F1800
G1 F804
M204 S6000
G1 X87.317 Y86.203 E.02737
G1 X88.212 Y86.203 E.03124
G1 X88.212 Y85.597 E.02117
G1 X89.106 Y85.597 E.03124
G1 X89.106 Y86.203 E.02117
G1 X90 Y86.203 E.03124
G1 X90 Y85.597 E.02117
G1 X90.894 Y85.597 E.03124
G1 X90.894 Y86.203 E.02117
G1 X91.788 Y86.203 E.03124
G1 X91.788 Y85.597 E.02117
G1 X92.683 Y85.597 E.03124
G1 X92.683 Y86.38 E.02737
; WIPE_START
G1 F4070.606
G1 X92.683 Y85.597 E-.11165
G1 X91.788 Y85.597 E-.12743
G1 X91.788 Y85.919 E-.04592
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X87.843 Y87.843 Z3.24 F18000
G1 Z2.84
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
; LAYER_HEIGHT: 0.12
G1 F804
M204 S6000
G1 X92.156 Y87.844 E.08672
G1 X92.157 Y92.157 E.08672
G1 X87.843 Y92.157 E.08672
G1 X87.843 Y87.903 E.08552
M204 S10000
G1 X87.419 Y87.419 F18000
G1 F804
M204 S6000
G1 X92.58 Y87.419 E.10378
G1 X92.581 Y92.581 E.10378
G1 X87.419 Y92.581 E.10379
G1 X87.419 Y87.479 E.10258
M204 S250
G1 X87.071 Y87.01 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F804
M204 S5000
G1 X92.932 Y87.01 E.10953
G1 X92.975 Y87.025 E.00085
G1 X92.99 Y87.061 E.00073
G1 X92.99 Y92.929 E.10965
G1 X92.975 Y92.975 E.00091
G1 X92.929 Y92.99 E.0009
G1 X87.071 Y92.99 E.10947
G1 X87.025 Y92.975 E.0009
G1 X87.01 Y92.929 E.00091
G1 X87.01 Y87.071 E.10947
G1 X87.021 Y87.036 E.00069
; WIPE_START
G1 F1800
M204 S6000
G1 X89.021 Y87.027 E-.285
; WIPE_END
G1 E-.015
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




G1 X90.654 Y88.206
G1 Z2.84
G1 E.3 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F804
M204 S6000
G1 X88.957 Y88.206 E.03412
G1 X89.222 Y88.634 E.01012
G1 X89.656 Y89.09 E.01265
G1 X90.34 Y89.545 E.01652
G1 X91.131 Y90 E.01834
G1 X91.409 Y90.455 E.01073
G1 X91.378 Y90.91 E.00917
G1 X91.069 Y91.794 E.01881
G1 X89.373 Y91.794 E.03412
; CHANGE_LAYER
; Z_HEIGHT: 2.96
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F6000
G1 X91.069 Y91.794 E-.24182
G1 X91.169 Y91.508 E-.04318
; WIPE_END
G1 E-.015 F1800
; layer num/total_layer_count: 24/43
; update layer progress
M73 L24
M991 S0 P23 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z3.24 I.901 J-.818 P1  F18000
G1 X87.843 Y87.843 Z3.24
G1 Z2.96
G1 E.3 F1800
; FEATURE: Inner wall
G1 F609
M204 S6000
G1 X92.156 Y87.844 E.08672
G1 X92.157 Y92.157 E.08672
G1 X87.843 Y92.157 E.08672
G1 X87.843 Y87.903 E.08552
M204 S10000
G1 X87.419 Y87.419 F18000
G1 F609
M204 S6000
G1 X92.58 Y87.419 E.10378
G1 X92.581 Y92.581 E.10378
G1 X87.419 Y92.581 E.10379
G1 X87.419 Y87.479 E.10258
M204 S250
M73 P76 R3
G1 X87.071 Y87.01 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F609
M204 S5000
G1 X92.933 Y87.01 E.10954
G1 X92.975 Y87.025 E.00083
G1 X92.99 Y87.061 E.00073
G1 X92.99 Y92.929 E.10965
G1 X92.975 Y92.975 E.00091
G1 X92.929 Y92.99 E.00091
G1 X87.071 Y92.99 E.10947
G1 X87.025 Y92.975 E.00091
G1 X87.01 Y92.929 E.00091
G1 X87.01 Y87.071 E.10947
G1 X87.021 Y87.036 E.00069
; WIPE_START
G1 F1800
M204 S6000
G1 X89.021 Y87.027 E-.285
; WIPE_END
G1 E-.015
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




G1 X90.695 Y88.206
G1 Z2.96
G1 E.3 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F609
M204 S6000
G1 X88.998 Y88.206 E.03412
G1 X89.228 Y88.634 E.00977
G1 X89.609 Y89.09 E.01194
G1 X90.846 Y90 E.03087
G1 X91.188 Y90.455 E.01145
G1 X91.242 Y90.91 E.00922
G1 X91.023 Y91.794 E.0183
G1 X89.326 Y91.794 E.03412
; CHANGE_LAYER
; Z_HEIGHT: 3.08
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F6000
G1 X91.023 Y91.794 E-.24182
G1 X91.096 Y91.5 E-.04318
; WIPE_END
G1 E-.015 F1800
; layer num/total_layer_count: 25/43
; update layer progress
M73 L25
M991 S0 P24 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z3.36 I.909 J-.809 P1  F18000
G1 X87.843 Y87.843 Z3.36
G1 Z3.08
G1 E.3 F1800
; FEATURE: Inner wall
G1 F608
M204 S6000
G1 X92.156 Y87.844 E.08672
G1 X92.157 Y92.157 E.08672
G1 X87.843 Y92.157 E.08672
G1 X87.843 Y87.903 E.08552
M204 S10000
G1 X87.419 Y87.419 F18000
G1 F608
M204 S6000
G1 X92.581 Y87.419 E.10378
G1 X92.581 Y92.581 E.10378
G1 X87.419 Y92.581 E.10379
G1 X87.419 Y87.479 E.10258
M204 S250
G1 X87.071 Y87.01 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F608
M204 S5000
G1 X92.934 Y87.01 E.10956
G1 X92.975 Y87.025 E.00082
G1 X92.99 Y87.066 E.00081
G1 X92.99 Y92.929 E.10957
G1 X92.975 Y92.975 E.0009
G1 X92.929 Y92.99 E.00091
G1 X87.071 Y92.99 E.10947
G1 X87.025 Y92.975 E.0009
G1 X87.01 Y92.929 E.0009
G1 X87.01 Y87.071 E.10947
G1 X87.021 Y87.036 E.00069
; WIPE_START
G1 F1800
M204 S6000
G1 X89.021 Y87.027 E-.285
; WIPE_END
M73 P77 R3
G1 E-.015
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




G1 X90.728 Y88.206
G1 Z3.08
G1 E.3 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F608
M204 S6000
G1 X89.031 Y88.206 E.03412
G1 X89.227 Y88.634 E.00946
G1 X89.561 Y89.09 E.01135
G1 X90.642 Y90 E.02843
G1 X91.009 Y90.455 E.01176
G1 X91.123 Y90.91 E.00944
G1 X91.097 Y91.366 E.00917
G1 X90.988 Y91.794 E.00888
G1 X89.291 Y91.794 E.03412
; CHANGE_LAYER
; Z_HEIGHT: 3.2
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F6000
G1 X90.988 Y91.794 E-.24182
G1 X91.063 Y91.5 E-.04318
; WIPE_END
G1 E-.015 F1800
; layer num/total_layer_count: 26/43
; update layer progress
M73 L26
M991 S0 P25 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z3.48 I.913 J-.804 P1  F18000
G1 X87.843 Y87.844 Z3.48
G1 Z3.2
G1 E.3 F1800
; FEATURE: Inner wall
G1 F607
M204 S6000
G1 X92.156 Y87.844 E.08672
G1 X92.157 Y92.157 E.08672
G1 X87.843 Y92.157 E.08672
G1 X87.843 Y87.904 E.08552
M204 S10000
G1 X87.419 Y87.419 F18000
G1 F607
M204 S6000
G1 X92.58 Y87.419 E.10378
G1 X92.581 Y92.581 E.10378
G1 X87.419 Y92.581 E.10379
G1 X87.419 Y87.479 E.10258
M204 S250
G1 X87.071 Y87.01 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F607
M204 S5000
G1 X92.935 Y87.01 E.10957
G1 X92.976 Y87.025 E.00082
G1 X92.99 Y87.062 E.00074
G1 X92.99 Y92.929 E.10963
G1 X92.975 Y92.975 E.00091
G1 X92.929 Y92.99 E.00091
G1 X87.071 Y92.99 E.10947
G1 X87.025 Y92.975 E.00091
G1 X87.01 Y92.929 E.00091
G1 X87.01 Y87.071 E.10947
G1 X87.021 Y87.036 E.00069
; WIPE_START
G1 F1800
M204 S6000
G1 X89.021 Y87.027 E-.285
; WIPE_END
M73 P78 R3
G1 E-.015
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




G1 X90.754 Y88.206
G1 Z3.2
G1 E.3 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F607
M204 S6000
G1 X89.057 Y88.206 E.03412
G1 X89.219 Y88.634 E.0092
G1 X89.509 Y89.09 E.01086
G1 X90.478 Y90 E.02673
G1 X90.858 Y90.455 E.01193
G1 X91.018 Y90.91 E.0097
G1 X91.034 Y91.366 E.00916
G1 X90.958 Y91.794 E.00874
G1 X89.261 Y91.794 E.03412
; CHANGE_LAYER
; Z_HEIGHT: 3.32
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F6000
G1 X90.958 Y91.794 E-.24182
G1 X91.011 Y91.495 E-.04318
; WIPE_END
G1 E-.015 F1800
; layer num/total_layer_count: 27/43
; update layer progress
M73 L27
M991 S0 P26 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z3.6 I-1.07 J.58 P1  F18000
G1 X92.683 Y94.58 Z3.6
G1 Z3.32
G1 E.3 F1800
; FEATURE: Support interface
; LINE_WIDTH: 0.42
; LAYER_HEIGHT: 0.24
G1 F798
M204 S6000
G1 X92.683 Y93.797 E.02737
G1 X91.788 Y93.797 E.03124
G1 X91.788 Y94.403 E.02117
G1 X90.894 Y94.403 E.03124
G1 X90.894 Y93.797 E.02117
G1 X90 Y93.797 E.03124
G1 X90 Y94.403 E.02117
G1 X89.106 Y94.403 E.03124
G1 X89.106 Y93.797 E.02117
G1 X88.212 Y93.797 E.03124
G1 X88.212 Y94.403 E.02117
G1 X87.317 Y94.403 E.03124
G1 X87.317 Y93.62 E.02737
; WIPE_START
G1 F4070.606
G1 X87.317 Y94.403 E-.11164
G1 X88.212 Y94.403 E-.12743
G1 X88.212 Y94.081 E-.04593
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X87.428 Y86.489 Z3.72 F18000
G1 X87.317 Y85.42 Z3.72
G1 Z3.32
G1 E.3 F1800
G1 F798
M204 S6000
G1 X87.317 Y86.203 E.02737
G1 X88.212 Y86.203 E.03124
G1 X88.212 Y85.597 E.02117
M73 P79 R3
G1 X89.106 Y85.597 E.03124
G1 X89.106 Y86.203 E.02117
G1 X90 Y86.203 E.03124
G1 X90 Y85.597 E.02117
G1 X90.894 Y85.597 E.03124
G1 X90.894 Y86.203 E.02117
G1 X91.788 Y86.203 E.03124
G1 X91.788 Y85.597 E.02117
G1 X92.683 Y85.597 E.03124
G1 X92.683 Y86.381 E.02737
; WIPE_START
G1 F4070.606
G1 X92.683 Y85.597 E-.11167
G1 X91.788 Y85.597 E-.12743
G1 X91.788 Y85.919 E-.0459
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X87.843 Y87.844 Z3.72 F18000
G1 Z3.32
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
; LAYER_HEIGHT: 0.12
G1 F798
M204 S6000
G1 X92.156 Y87.844 E.08672
G1 X92.157 Y92.157 E.08672
G1 X87.843 Y92.157 E.08672
G1 X87.843 Y87.904 E.08552
M204 S10000
G1 X87.419 Y87.419 F18000
G1 F798
M204 S6000
G1 X92.58 Y87.419 E.10378
G1 X92.581 Y92.581 E.10378
G1 X87.419 Y92.581 E.10379
G1 X87.419 Y87.479 E.10258
M204 S250
G1 X87.071 Y87.01 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F798
M204 S5000
G1 X92.936 Y87.01 E.10959
G1 X92.978 Y87.026 E.00084
G1 X92.99 Y87.064 E.00074
G1 X92.99 Y92.929 E.1096
G1 X92.975 Y92.975 E.0009
G1 X92.929 Y92.99 E.0009
G1 X87.071 Y92.99 E.10948
G1 X87.025 Y92.975 E.0009
G1 X87.01 Y92.929 E.00091
G1 X87.01 Y87.071 E.10947
G1 X87.021 Y87.036 E.00068
; WIPE_START
G1 F1800
M204 S6000
G1 X89.021 Y87.027 E-.285
; WIPE_END
G1 E-.015
M204 S10000
G17
M73 P80 R3
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




G1 X90.772 Y88.206
G1 Z3.32
G1 E.3 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F798
M204 S6000
G1 X89.075 Y88.206 E.03412
G1 X89.204 Y88.634 E.00899
G1 X89.454 Y89.09 E.01044
G1 X89.847 Y89.545 E.0121
G1 X90.335 Y90 E.01341
G1 X90.725 Y90.455 E.01206
G1 X90.924 Y90.91 E.00999
G1 X90.978 Y91.366 E.00922
G1 X90.936 Y91.794 E.00865
G1 X89.239 Y91.794 E.03412
; CHANGE_LAYER
; Z_HEIGHT: 3.44
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F6000
G1 X90.936 Y91.794 E-.24182
G1 X90.966 Y91.492 E-.04318
; WIPE_END
G1 E-.015 F1800
; layer num/total_layer_count: 28/43
; update layer progress
M73 L28
M991 S0 P27 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z3.72 I.925 J-.791 P1  F18000
G1 X87.843 Y87.844 Z3.72
G1 Z3.44
G1 E.3 F1800
; FEATURE: Inner wall
G1 F606
M204 S6000
G1 X92.156 Y87.844 E.08672
G1 X92.157 Y92.157 E.08672
G1 X87.843 Y92.157 E.08672
G1 X87.843 Y87.904 E.08552
M204 S10000
G1 X87.419 Y87.419 F18000
G1 F606
M204 S6000
G1 X92.58 Y87.419 E.10378
G1 X92.581 Y92.581 E.10378
G1 X87.419 Y92.581 E.10379
G1 X87.419 Y87.479 E.10258
M204 S250
G1 X87.071 Y87.01 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F606
M204 S5000
G1 X92.936 Y87.01 E.1096
G1 X92.978 Y87.026 E.00082
G1 X92.99 Y87.064 E.00074
G1 X92.99 Y92.929 E.1096
G1 X92.975 Y92.975 E.0009
G1 X92.929 Y92.99 E.00091
G1 X87.071 Y92.99 E.10947
G1 X87.025 Y92.975 E.00091
G1 X87.01 Y92.929 E.0009
G1 X87.01 Y87.071 E.10947
G1 X87.021 Y87.036 E.00069
; WIPE_START
G1 F1800
M204 S6000
G1 X89.021 Y87.027 E-.285
; WIPE_END
G1 E-.015
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
M73 P80 R2
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




G1 X90.784 Y88.206
G1 Z3.44
G1 E.3 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F606
M204 S6000
G1 X89.087 Y88.206 E.03412
G1 X89.184 Y88.634 E.00882
G1 X89.395 Y89.09 E.0101
G1 X89.747 Y89.545 E.01156
G1 X90.205 Y90 E.01299
G1 X90.606 Y90.455 E.0122
G1 X90.839 Y90.91 E.01029
G1 X90.93 Y91.366 E.00934
G1 X90.92 Y91.794 E.00861
G1 X89.223 Y91.794 E.03412
; CHANGE_LAYER
; Z_HEIGHT: 3.56
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F6000
G1 X90.92 Y91.794 E-.24182
G1 X90.927 Y91.491 E-.04318
; WIPE_END
G1 E-.015 F1800
; layer num/total_layer_count: 29/43
; update layer progress
M73 L29
M991 S0 P28 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z3.84 I.929 J-.786 P1  F18000
G1 X87.843 Y87.843 Z3.84
G1 Z3.56
G1 E.3 F1800
; FEATURE: Inner wall
G1 F606
M204 S6000
G1 X92.156 Y87.844 E.08672
G1 X92.157 Y92.157 E.08672
G1 X87.843 Y92.157 E.08672
G1 X87.843 Y87.903 E.08552
M204 S10000
G1 X87.419 Y87.419 F18000
G1 F606
M204 S6000
M73 P81 R2
G1 X92.58 Y87.419 E.10378
G1 X92.581 Y92.581 E.10378
G1 X87.419 Y92.581 E.10379
G1 X87.419 Y87.479 E.10258
M204 S250
G1 X87.071 Y87.01 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F606
M204 S5000
G1 X92.937 Y87.01 E.10962
G1 X92.978 Y87.026 E.00081
G1 X92.99 Y87.064 E.00074
G1 X92.99 Y92.929 E.1096
G1 X92.975 Y92.975 E.00091
G1 X92.929 Y92.99 E.0009
G1 X87.071 Y92.99 E.10947
G1 X87.025 Y92.975 E.00091
G1 X87.01 Y92.929 E.0009
G1 X87.01 Y87.071 E.10947
G1 X87.021 Y87.036 E.00069
; WIPE_START
G1 F1800
M204 S6000
G1 X89.021 Y87.027 E-.285
; WIPE_END
G1 E-.015
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




G1 X90.789 Y88.207
G1 Z3.56
G1 E.3 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F606
M204 S6000
G1 X89.092 Y88.206 E.03412
G1 X89.157 Y88.634 E.0087
G1 X89.332 Y89.09 E.00981
G1 X89.646 Y89.545 E.01111
G1 X90.495 Y90.455 E.02503
G1 X90.762 Y90.91 E.01061
G1 X90.889 Y91.366 E.0095
G1 X90.911 Y91.794 E.00862
G1 X89.214 Y91.794 E.03412
; CHANGE_LAYER
; Z_HEIGHT: 3.68
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F6000
G1 X90.911 Y91.794 E-.24182
G1 X90.895 Y91.491 E-.04318
; WIPE_END
G1 E-.015 F1800
; layer num/total_layer_count: 30/43
; update layer progress
M73 L30
M991 S0 P29 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z3.96 I.933 J-.781 P1  F18000
G1 X87.843 Y87.844 Z3.96
G1 Z3.68
G1 E.3 F1800
; FEATURE: Inner wall
G1 F605
M204 S6000
G1 X92.156 Y87.844 E.08672
G1 X92.157 Y92.157 E.08672
G1 X87.843 Y92.157 E.08672
G1 X87.843 Y87.904 E.08552
M204 S10000
G1 X87.419 Y87.419 F18000
G1 F605
M204 S6000
G1 X92.58 Y87.419 E.10378
G1 X92.581 Y92.581 E.10378
G1 X87.419 Y92.581 E.10379
M73 P82 R2
G1 X87.419 Y87.479 E.10258
M204 S250
G1 X87.071 Y87.01 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F605
M204 S5000
G1 X92.938 Y87.01 E.10963
G1 X92.978 Y87.026 E.0008
G1 X92.99 Y87.064 E.00074
G1 X92.99 Y92.929 E.1096
G1 X92.975 Y92.975 E.0009
G1 X92.929 Y92.99 E.00091
G1 X87.071 Y92.99 E.10947
G1 X87.025 Y92.975 E.00091
G1 X87.01 Y92.929 E.0009
G1 X87.01 Y87.071 E.10947
G1 X87.021 Y87.036 E.00069
; WIPE_START
G1 F1800
M204 S6000
G1 X89.021 Y87.027 E-.285
; WIPE_END
G1 E-.015
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




G1 X88.206 Y89.018
G1 Z3.68
G1 E.3 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F605
M204 S6000
G1 X88.206 Y88.206 E.01633
G1 X89.091 Y88.206 E.0178
G1 X89.124 Y88.634 E.00863
G1 X89.264 Y89.09 E.00957
G1 X89.543 Y89.545 E.01073
G1 X90.391 Y90.455 E.02501
G1 X90.692 Y90.91 E.01097
G1 X90.854 Y91.366 E.00972
G1 X90.907 Y91.794 E.00867
G1 X91.794 Y91.794 E.01782
G1 X91.794 Y90.983 E.0163
; CHANGE_LAYER
; Z_HEIGHT: 3.8
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F6000
G1 X91.794 Y91.794 E-.11553
G1 X90.907 Y91.794 E-.12629
G1 X90.87 Y91.493 E-.04318
; WIPE_END
G1 E-.015 F1800
; layer num/total_layer_count: 31/43
; update layer progress
M73 L31
M991 S0 P30 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z4.08 I.937 J-.777 P1  F18000
G1 X87.843 Y87.844 Z4.08
G1 Z3.8
G1 E.3 F1800
; FEATURE: Inner wall
G1 F606
M204 S6000
G1 X92.156 Y87.844 E.08672
G1 X92.157 Y92.157 E.08672
G1 X87.843 Y92.157 E.08672
G1 X87.843 Y87.904 E.08552
M204 S10000
G1 X87.419 Y87.419 F18000
G1 F606
M204 S6000
G1 X92.58 Y87.42 E.10378
G1 X92.581 Y92.581 E.10378
G1 X87.419 Y92.581 E.10379
M73 P83 R2
G1 X87.419 Y87.479 E.10258
M204 S250
G1 X87.071 Y87.01 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F606
M204 S5000
G1 X92.936 Y87.01 E.1096
G1 X92.976 Y87.024 E.00079
G1 X92.99 Y87.064 E.00078
G1 X92.99 Y92.929 E.10961
G1 X92.975 Y92.975 E.0009
G1 X92.929 Y92.99 E.00091
G1 X87.071 Y92.99 E.10947
G1 X87.025 Y92.975 E.00091
G1 X87.01 Y92.93 E.0009
G1 X87.01 Y87.071 E.10948
G1 X87.021 Y87.036 E.00069
; WIPE_START
G1 F1800
M204 S6000
G1 X89.021 Y87.027 E-.285
; WIPE_END
G1 E-.015
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




G1 X90.781 Y88.207
G1 Z3.8
G1 E.3 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F606
M204 S6000
G1 X89.084 Y88.206 E.03412
G1 X89.085 Y88.634 E.00861
G1 X89.19 Y89.09 E.00939
G1 X89.435 Y89.545 E.0104
G1 X89.84 Y90 E.01225
G1 X90.29 Y90.455 E.01286
G1 X90.627 Y90.91 E.01139
G1 X90.825 Y91.366 E.00999
G1 X90.91 Y91.794 E.00878
G1 X89.213 Y91.794 E.03412
M106 S229.5
; CHANGE_LAYER
; Z_HEIGHT: 3.92
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F6000
G1 X90.91 Y91.794 E-.24182
G1 X90.851 Y91.496 E-.04318
; WIPE_END
G1 E-.015 F1800
; layer num/total_layer_count: 32/43
; update layer progress
M73 L32
M991 S0 P31 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z4.2 I1.037 J-.637 P1  F18000
G1 X87.843 Y86.6 Z4.2
G1 Z3.92
G1 E.3 F1800
; FEATURE: Overhang wall
G1 F600
M204 S5000
G1 X87.843 Y86.443 E.00315
G1 X92.157 Y86.443 E.08672
G1 X92.157 Y86.6 E.00315
M106 S73.95
M106 S229.5
; FEATURE: Inner wall
G1 F720
M204 S6000
G1 X92.157 Y86.983 E.00769
M106 S73.95
M106 S229.5
G1 F1245
G1 X92.157 Y87.383 E.00804
G1 X92.157 Y87.783 E.00804
G1 X92.157 Y92.218 E.08917
G1 X92.157 Y92.618 E.00804
M73 P84 R2
G1 X92.157 Y93.018 E.00804
G1 F600
G1 X92.157 Y93.4 E.00769
M106 S73.95
M106 S229.5
; FEATURE: Overhang wall
G1 F3000
M204 S5000
G1 X92.157 Y93.557 E.00315
M106 S73.95
M106 S229.5
G1 F600
G1 X87.843 Y93.557 E.08672
G1 X87.843 Y93.4 E.00315
M106 S73.95
M106 S229.5
; FEATURE: Inner wall
M204 S6000
G1 X87.843 Y93.018 E.00769
M106 S73.95
M106 S229.5
G1 F1245
G1 X87.843 Y92.618 E.00804
G1 X87.843 Y92.218 E.00804
G1 X87.843 Y87.783 E.08918
G1 X87.843 Y87.383 E.00804
G1 X87.843 Y86.983 E.00804
G1 F720
G1 X87.843 Y86.66 E.00648
M106 S73.95
M106 S229.5
M204 S250
G1 X87.419 Y86.6 F18000
; FEATURE: Overhang wall
G1 F600
M204 S5000
G1 X87.419 Y86.019 E.01168
G1 X92.581 Y86.019 E.10379
G1 X92.581 Y86.6 E.01168
M106 S73.95
M106 S229.5
; FEATURE: Inner wall
G1 F720
M204 S6000
G1 X92.581 Y86.983 E.00769
M106 S73.95
M106 S229.5
G1 F1245
G1 X92.581 Y87.383 E.00804
G1 X92.581 Y87.783 E.00804
G1 X92.581 Y92.218 E.08917
G1 X92.581 Y92.618 E.00804
G1 X92.581 Y93.018 E.00804
G1 F600
G1 X92.581 Y93.4 E.00769
M106 S73.95
M106 S229.5
; FEATURE: Overhang wall
G1 F3000
M204 S5000
G1 X92.581 Y93.981 E.01168
M106 S73.95
M106 S229.5
G1 F600
G1 X87.419 Y93.981 E.10379
G1 X87.419 Y93.4 E.01168
M106 S73.95
M106 S229.5
; FEATURE: Inner wall
M204 S6000
G1 X87.419 Y93.018 E.00769
M106 S73.95
M106 S229.5
G1 F1245
G1 X87.419 Y92.618 E.00804
G1 X87.419 Y92.218 E.00804
G1 X87.419 Y87.783 E.08918
G1 X87.419 Y87.383 E.00804
G1 X87.419 Y86.983 E.00804
G1 F720
G1 X87.419 Y86.66 E.00648
M106 S73.95
M106 S229.5
M204 S250
G1 X87.01 Y86.603 F18000
; FEATURE: Overhang wall
G1 F600
M204 S5000
G1 X87.01 Y85.61 E.01997
G1 X92.99 Y85.61 E.12024
G1 X92.99 Y86.602 E.01995
M106 S73.95
M106 S229.5
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F720
G1 X92.99 Y86.98 E.00706
M106 S73.95
M106 S229.5
G1 F1245
G1 X92.99 Y87.38 E.00747
M73 P85 R2
G1 X92.99 Y92.619 E.09789
G1 X92.99 Y93.019 E.00747
G1 F720
G1 X92.99 Y93.397 E.00706
M106 S73.95
M106 S229.5
; FEATURE: Overhang wall
; LINE_WIDTH: 0.45
G1 F3000
G1 X92.99 Y94.39 E.01997
M106 S73.95
M106 S229.5
G1 F600
G1 X87.01 Y94.39 E.12024
G1 X87.01 Y93.397 E.01997
M106 S73.95
M106 S229.5
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F720
G1 X87.01 Y93.019 E.00706
M106 S73.95
M106 S229.5
G1 F1245
G1 X87.01 Y92.619 E.00747
G1 X87.01 Y87.381 E.09788
G1 X87.01 Y86.981 E.00747
G1 F720
G1 X87.01 Y86.663 E.00594
M106 S73.95
M106 S229.5
; WIPE_START
M204 S6000
G1 X87.01 Y85.61 E-.15005
G1 X87.957 Y85.61 E-.13495
; WIPE_END
G1 E-.015 F1800
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




G1 X88.014 Y87.777
G1 Z3.92
G1 E.3 F1800
; FEATURE: Bridge
; LINE_WIDTH: 0.498842
G1 F3000
M204 S6000
G1 X91.809 Y87.777 E.08509
G1 X91.809 Y87.304 E.01061
G1 X88.191 Y87.304 E.08111
G1 X88.191 Y86.831 E.01061
G1 X91.986 Y86.831 E.08509
M106 S73.95
M106 S229.5
; WIPE_START
G1 X89.986 Y86.831 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X90.762 Y88.289 Z4.32 F18000
G1 Z3.92
G1 E.3 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F1245
M204 S6000
G1 X89.065 Y88.289 E.03412
G1 X89.04 Y88.634 E.00696
G1 X89.108 Y89.09 E.00925
G1 X89.319 Y89.545 E.01009
G1 X89.713 Y90 E.01211
G1 X90.189 Y90.455 E.01324
G1 X90.567 Y90.91 E.01189
G1 X90.803 Y91.366 E.01031
G1 X90.897 Y91.711 E.0072
G1 X89.2 Y91.711 E.03412
; WIPE_START
G1 F6000
G1 X90.897 Y91.711 E-.24182
G1 X90.817 Y91.419 E-.04318
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X88.014 Y93.169 Z4.32 F18000
G1 Z3.92
G1 E.3 F1800
; FEATURE: Bridge
; LINE_WIDTH: 0.498842
G1 F3000
M204 S6000
G1 X91.809 Y93.169 E.08509
G1 X91.809 Y92.696 E.01061
G1 X88.191 Y92.696 E.08111
G1 X88.191 Y92.223 E.01061
G1 X91.986 Y92.223 E.08509
M106 S73.95
; CHANGE_LAYER
; Z_HEIGHT: 4.04
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F3000
G1 X89.986 Y92.223 E-.285
; WIPE_END
G1 E-.015 F1800
; layer num/total_layer_count: 33/43
; update layer progress
M73 L33
M991 S0 P32 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z4.32 I1.141 J-.423 P1  F18000
G1 X87.843 Y86.443 Z4.32
G1 Z4.04
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F993
M204 S6000
G1 X92.157 Y86.443 E.08672
G1 X92.157 Y93.557 E.14303
G1 X87.843 Y93.557 E.08672
G1 X87.843 Y86.503 E.14182
M204 S10000
G1 X87.419 Y86.019 F18000
G1 F993
M204 S6000
G1 X92.581 Y86.019 E.10379
G1 X92.581 Y93.981 E.16009
G1 X87.419 Y93.981 E.10379
G1 X87.419 Y86.079 E.15888
M204 S250
G1 X87.01 Y85.61 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F993
M204 S5000
G1 X92.99 Y85.61 E.11174
G1 X92.99 Y94.39 E.16406
G1 X87.01 Y94.39 E.11174
G1 X87.01 Y85.67 E.16294
; WIPE_START
G1 F1800
M204 S6000
G1 X89.01 Y85.65 E-.285
; WIPE_END
G1 E-.015
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




G1 X90.735 Y88.289
G1 Z4.04
G1 E.3 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F993
M204 S6000
G1 X89.038 Y88.289 E.03412
G1 X88.987 Y88.634 E.00702
G1 X89.017 Y89.09 E.00917
G1 X89.192 Y89.545 E.0098
G1 X89.576 Y90 E.01198
G1 X90.511 Y90.91 E.02624
G1 X90.786 Y91.366 E.0107
G1 X90.907 Y91.711 E.00735
G1 X89.21 Y91.711 E.03412
; WIPE_START
G1 F6000
G1 X90.907 Y91.711 E-.24182
G1 X90.807 Y91.425 E-.04318
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X91.747 Y92.634 Z4.44 F18000
G1 Z4.04
M73 P86 R2
G1 E.3 F1800
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.419992
G1 F993
M204 S6000
G1 X91.747 Y92.12 E.0096
G1 X88.253 Y92.12 E.0653
G1 X88.253 Y93.147 E.0192
G1 X91.747 Y93.147 E.0653
G1 X91.747 Y92.694 E.00848
; WIPE_START
G1 F3840
G1 X91.747 Y93.147 E-.06465
G1 X90.201 Y93.147 E-.22035
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X88.766 Y92.634 Z4.44 F18000
G1 Z4.04
G1 E.3 F1800
; LINE_WIDTH: 0.658892
G1 F993
M204 S6000
G1 X91.174 Y92.634 E.07224
; WIPE_START
G1 F3840
G1 X89.174 Y92.634 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X91.747 Y87.367 Z4.44 F18000
G1 Z4.04
G1 E.3 F1800
; LINE_WIDTH: 0.419992
G1 F993
M204 S6000
G1 X91.747 Y86.853 E.0096
G1 X88.253 Y86.853 E.0653
G1 X88.253 Y87.88 E.0192
G1 X91.747 Y87.88 E.0653
G1 X91.747 Y87.427 E.00848
; WIPE_START
G1 F3840
G1 X91.747 Y87.88 E-.06467
G1 X90.201 Y87.88 E-.22033
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X88.766 Y87.366 Z4.44 F18000
G1 Z4.04
G1 E.3 F1800
; LINE_WIDTH: 0.659042
G1 F993
M204 S6000
G1 X91.173 Y87.367 E.07225
; CHANGE_LAYER
; Z_HEIGHT: 4.16
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F3840
G1 X89.174 Y87.366 E-.285
; WIPE_END
G1 E-.015 F1800
; layer num/total_layer_count: 34/43
; update layer progress
M73 L34
M991 S0 P33 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z4.44 I.694 J-1 P1  F18000
G1 X87.843 Y86.443 Z4.44
G1 Z4.16
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F990
M204 S6000
G1 X92.157 Y86.443 E.08672
G1 X92.157 Y93.557 E.14303
G1 X87.843 Y93.557 E.08672
G1 X87.843 Y86.503 E.14182
M204 S10000
G1 X87.419 Y86.019 F18000
G1 F990
M204 S6000
G1 X92.581 Y86.019 E.10379
G1 X92.581 Y93.981 E.16009
G1 X87.419 Y93.981 E.10379
G1 X87.419 Y86.079 E.15888
M204 S250
G1 X87.01 Y85.61 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F990
M204 S5000
G1 X92.99 Y85.61 E.11174
G1 X92.99 Y94.39 E.16406
G1 X87.01 Y94.39 E.11174
G1 X87.01 Y85.67 E.16294
; WIPE_START
G1 F1800
M204 S6000
G1 X89.01 Y85.65 E-.285
; WIPE_END
G1 E-.015
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




G1 X90.702 Y88.289
G1 Z4.16
M73 P86 R1
G1 E.3 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F990
M204 S6000
M73 P87 R1
G1 X89.005 Y88.289 E.03412
G1 X88.927 Y88.634 E.00712
G1 X88.916 Y89.09 E.00916
G1 X89.048 Y89.545 E.00953
G1 X89.42 Y90 E.01183
G1 X90.458 Y90.91 E.02776
G1 X90.776 Y91.366 E.01116
G1 X90.923 Y91.711 E.00755
G1 X89.226 Y91.711 E.03412
; WIPE_START
G1 F6000
G1 X90.923 Y91.711 E-.24182
G1 X90.804 Y91.432 E-.04318
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X91.747 Y92.634 Z4.56 F18000
G1 Z4.16
G1 E.3 F1800
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.419992
G1 F990
M204 S6000
G1 X91.747 Y92.12 E.0096
G1 X88.253 Y92.12 E.0653
G1 X88.253 Y93.147 E.0192
G1 X91.747 Y93.147 E.0653
G1 X91.747 Y92.694 E.00848
; WIPE_START
G1 F3840
G1 X91.747 Y93.147 E-.06465
G1 X90.201 Y93.147 E-.22035
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X88.766 Y92.634 Z4.56 F18000
G1 Z4.16
G1 E.3 F1800
; LINE_WIDTH: 0.658892
G1 F990
M204 S6000
G1 X91.174 Y92.634 E.07224
; WIPE_START
G1 F3840
G1 X89.174 Y92.634 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X91.747 Y87.367 Z4.56 F18000
G1 Z4.16
G1 E.3 F1800
; LINE_WIDTH: 0.419992
G1 F990
M204 S6000
G1 X91.747 Y86.853 E.0096
G1 X88.253 Y86.853 E.0653
G1 X88.253 Y87.88 E.0192
G1 X91.747 Y87.88 E.0653
G1 X91.747 Y87.427 E.00848
; WIPE_START
G1 F3840
G1 X91.747 Y87.88 E-.06467
G1 X90.201 Y87.88 E-.22033
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X88.766 Y87.366 Z4.56 F18000
G1 Z4.16
G1 E.3 F1800
; LINE_WIDTH: 0.659042
G1 F990
M204 S6000
G1 X91.173 Y87.367 E.07225
; CHANGE_LAYER
; Z_HEIGHT: 4.28
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F3840
G1 X89.174 Y87.366 E-.285
; WIPE_END
G1 E-.015 F1800
; layer num/total_layer_count: 35/43
; update layer progress
M73 L35
M991 S0 P34 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z4.56 I.694 J-1 P1  F18000
G1 X87.843 Y86.443 Z4.56
G1 Z4.28
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F992
M204 S6000
G1 X92.157 Y86.443 E.08672
G1 X92.157 Y93.557 E.14303
G1 X87.843 Y93.557 E.08672
G1 X87.843 Y86.503 E.14182
M204 S10000
G1 X87.419 Y86.019 F18000
G1 F992
M204 S6000
G1 X92.581 Y86.019 E.10379
G1 X92.581 Y93.981 E.16009
G1 X87.419 Y93.981 E.10379
G1 X87.419 Y86.079 E.15888
M204 S250
G1 X87.01 Y85.61 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F992
M204 S5000
G1 X92.99 Y85.61 E.11174
G1 X92.99 Y94.39 E.16406
G1 X87.01 Y94.39 E.11174
G1 X87.01 Y85.67 E.16294
; WIPE_START
G1 F1800
M204 S6000
G1 X89.01 Y85.65 E-.285
; WIPE_END
G1 E-.015
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




G1 X90.671 Y88.289
G1 Z4.28
G1 E.3 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F992
M204 S6000
M73 P88 R1
G1 X88.974 Y88.289 E.03412
G1 X88.802 Y89.09 E.01646
G1 X88.88 Y89.545 E.00929
G1 X89.233 Y90 E.01159
G1 X90.408 Y90.91 E.02988
G1 X90.772 Y91.366 E.01172
G1 X90.947 Y91.711 E.00778
G1 X89.25 Y91.711 E.03412
; WIPE_START
G1 F6000
G1 X90.947 Y91.711 E-.24182
G1 X90.81 Y91.441 E-.04318
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X91.747 Y92.634 Z4.68 F18000
G1 Z4.28
G1 E.3 F1800
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.419992
G1 F992
M204 S6000
G1 X91.747 Y92.12 E.0096
G1 X88.253 Y92.12 E.0653
G1 X88.253 Y93.147 E.0192
G1 X91.747 Y93.147 E.0653
G1 X91.747 Y92.694 E.00848
; WIPE_START
G1 F3840
G1 X91.747 Y93.147 E-.06465
G1 X90.201 Y93.147 E-.22035
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X88.766 Y92.634 Z4.68 F18000
G1 Z4.28
G1 E.3 F1800
; LINE_WIDTH: 0.658892
G1 F992
M204 S6000
G1 X91.174 Y92.634 E.07224
; WIPE_START
G1 F3840
G1 X89.174 Y92.634 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X91.747 Y87.367 Z4.68 F18000
G1 Z4.28
G1 E.3 F1800
; LINE_WIDTH: 0.419992
G1 F992
M204 S6000
G1 X91.747 Y86.853 E.0096
G1 X88.253 Y86.853 E.0653
G1 X88.253 Y87.88 E.0192
G1 X91.747 Y87.88 E.0653
G1 X91.747 Y87.427 E.00848
; WIPE_START
G1 F3840
G1 X91.747 Y87.88 E-.06467
G1 X90.201 Y87.88 E-.22033
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X88.766 Y87.366 Z4.68 F18000
G1 Z4.28
G1 E.3 F1800
; LINE_WIDTH: 0.659042
G1 F992
M204 S6000
G1 X91.173 Y87.367 E.07225
; CHANGE_LAYER
; Z_HEIGHT: 4.4
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F3840
G1 X89.174 Y87.366 E-.285
; WIPE_END
G1 E-.015 F1800
; layer num/total_layer_count: 36/43
; update layer progress
M73 L36
M991 S0 P35 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z4.68 I.694 J-1 P1  F18000
G1 X87.843 Y86.443 Z4.68
G1 Z4.4
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F787
M204 S6000
G1 X92.157 Y86.443 E.08672
G1 X92.157 Y93.557 E.14303
G1 X87.843 Y93.557 E.08672
G1 X87.843 Y86.503 E.14182
M204 S10000
G1 X87.419 Y86.019 F18000
G1 F787
M204 S6000
G1 X92.581 Y86.019 E.10379
G1 X92.581 Y93.981 E.16009
G1 X87.419 Y93.981 E.10379
G1 X87.419 Y86.079 E.15888
M204 S250
G1 X87.01 Y85.61 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F787
M204 S5000
G1 X92.99 Y85.61 E.11174
G1 X92.99 Y94.39 E.16406
G1 X87.01 Y94.39 E.11174
G1 X87.01 Y85.67 E.16294
; WIPE_START
G1 F1800
M204 S6000
G1 X89.01 Y85.65 E-.285
; WIPE_END
G1 E-.015
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




G1 X88.596 Y86.806
M73 P89 R1
G1 Z4.4
G1 E.3 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F787
M204 S6000
G1 X90.293 Y86.806 E.03412
G1 X89.64 Y87.269 E.0161
G1 X89.225 Y87.724 E.01238
G1 X88.957 Y88.179 E.01062
G1 X88.673 Y89.09 E.01917
G1 X88.677 Y89.545 E.00915
G1 X88.987 Y90 E.01107
G1 X89.719 Y90.455 E.01733
G1 X90.361 Y90.91 E.01583
G1 X90.775 Y91.366 E.01238
G1 X91.043 Y91.821 E.01062
G1 X91.327 Y92.731 E.01917
G1 X91.318 Y93.194 E.0093
G1 X89.621 Y93.194 E.03412
; CHANGE_LAYER
; Z_HEIGHT: 4.52
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F6000
G1 X91.318 Y93.194 E-.24182
G1 X91.324 Y92.891 E-.04318
; WIPE_END
G1 E-.015 F1800
; layer num/total_layer_count: 37/43
; update layer progress
M73 L37
M991 S0 P36 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z4.8 I1.071 J-.578 P1  F18000
G1 X87.843 Y86.443 Z4.8
G1 Z4.52
G1 E.3 F1800
; FEATURE: Inner wall
G1 F927
M204 S6000
G1 X92.157 Y86.443 E.08672
G1 X92.157 Y93.557 E.14303
G1 X87.843 Y93.557 E.08672
G1 X87.843 Y86.503 E.14182
M204 S10000
G1 X87.419 Y86.019 F18000
G1 F927
M204 S6000
G1 X92.581 Y86.019 E.10379
G1 X92.581 Y93.981 E.16009
G1 X87.419 Y93.981 E.10379
G1 X87.419 Y86.079 E.15888
M204 S250
G1 X87.01 Y85.61 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F927
M204 S5000
G1 X92.99 Y85.61 E.11174
G1 X92.99 Y94.39 E.16406
G1 X87.01 Y94.39 E.11174
G1 X87.01 Y85.67 E.16294
; WIPE_START
G1 F1800
M204 S6000
G1 X89.01 Y85.65 E-.285
; WIPE_END
G1 E-.015
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




G1 X91.021 Y87.617
G1 Z4.52
G1 E.3 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F927
M204 S6000
G1 X89.324 Y87.617 E.03412
G1 X89.213 Y87.724 E.00309
G1 X88.907 Y88.179 E.01103
G1 X88.526 Y89.09 E.01985
G1 X88.413 Y89.545 E.00943
G1 X88.561 Y90 E.00962
G1 X89.537 Y90.455 E.02166
G1 X90.315 Y90.91 E.01813
G1 X90.787 Y91.366 E.01318
G1 X91.093 Y91.821 E.01103
G1 X91.328 Y92.383 E.01225
G1 X91.794 Y92.383 E.00936
G1 X91.794 Y91.151 E.02477
; WIPE_START
G1 F6000
G1 X91.794 Y92.383 E-.17552
G1 X91.328 Y92.383 E-.06631
G1 X91.211 Y92.103 E-.04318
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X91.757 Y92.782 Z4.92 F18000
G1 Z4.52
G1 E.3 F1800
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.400562
G1 F927
M204 S6000
G1 X88.243 Y92.782 E.06242
G1 X88.243 Y93.157 E.00666
G1 X91.757 Y93.157 E.06242
G1 X91.757 Y92.842 E.00559
; WIPE_START
G1 F3840
G1 X91.757 Y93.157 E-.04486
G1 X90.072 Y93.157 E-.24014
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X91.757 Y86.843 Z4.92 F18000
G1 Z4.52
M73 P90 R1
G1 E.3 F1800
G1 F927
M204 S6000
G1 X88.243 Y86.843 E.06242
G1 X88.243 Y87.218 E.00666
G1 X91.757 Y87.218 E.06242
G1 X91.757 Y86.903 E.00559
; CHANGE_LAYER
; Z_HEIGHT: 4.64
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F3840
G1 X91.757 Y87.218 E-.04486
G1 X90.072 Y87.218 E-.24014
; WIPE_END
G1 E-.015 F1800
; layer num/total_layer_count: 38/43
; update layer progress
M73 L38
M991 S0 P37 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z4.92 I.373 J-1.158 P1  F18000
G1 X87.843 Y86.499 Z4.92
G1 Z4.64
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F964
M204 S6000
G1 X92.157 Y86.499 E.08672
G1 X92.157 Y93.501 E.14077
G1 X87.843 Y93.501 E.08672
G1 X87.843 Y86.559 E.13957
M204 S10000
G1 X87.419 Y86.075 F18000
G1 F964
M204 S6000
G1 X92.581 Y86.075 E.10379
G1 X92.581 Y93.925 E.15783
G1 X87.419 Y93.925 E.10379
G1 X87.419 Y86.135 E.15663
M204 S250
G1 X87.01 Y85.666 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F964
M204 S5000
G1 X92.99 Y85.666 E.11174
G1 X92.99 Y94.334 E.16197
G1 X87.01 Y94.334 E.11174
G1 X87.01 Y85.726 E.16085
; WIPE_START
G1 F1800
M204 S6000
G1 X89.01 Y85.706 E-.285
; WIPE_END
G1 E-.015
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




G1 X90.788 Y87.841
G1 Z4.64
G1 E.3 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F964
M204 S6000
G1 X89.09 Y87.843 E.03416
G1 X88.601 Y88.611 E.01831
G1 X88.601 Y90.386 E.03569
G1 X88.634 Y90.367 E.00078
G1 X89.09 Y90.418 E.00921
G1 X90 Y90.752 E.0195
G1 X90.455 Y91.041 E.01083
G1 X90.91 Y91.485 E.01279
G1 X91.344 Y92.159 E.01612
G1 X91.399 Y92.159 E.0011
M73 P91 R1
G1 X91.399 Y90.517 E.03302
; WIPE_START
G1 F6000
G1 X91.399 Y92.159 E-.234
G1 X91.344 Y92.159 E-.00782
G1 X91.18 Y91.904 E-.04318
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X88.223 Y92.4 Z5.04 F18000
G1 Z4.64
G1 E.3 F1800
; Slow Down Start
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.365752
G1 F3000;_EXTRUDE_SET_SPEED
M204 S6000
G1 X88.222 Y87.689 E.07591
; Slow Down End
M204 S10000
G1 X88.389 Y87.404 F18000
; LINE_WIDTH: 0.48424
G1 F964
M204 S6000
G1 X91.611 Y87.404 E.07003
; LINE_WIDTH: 0.457894
G1 X91.667 Y87.479 E.00191
; LINE_WIDTH: 0.421037
G1 X91.722 Y87.554 E.00175
; LINE_WIDTH: 0.384181
G1 X91.778 Y87.629 E.00159
; LINE_WIDTH: 0.385554
G1 X91.757 Y87.476 E.00263
; LINE_WIDTH: 0.425157
G1 X91.736 Y87.323 E.00292
; LINE_WIDTH: 0.483478
G1 X91.715 Y87.17 E.00335
G1 X91.715 Y86.941 E.00498
G1 X88.285 Y86.941 E.07441
G1 X88.281 Y87.296 E.00771
; LINE_WIDTH: 0.457894
G1 X88.261 Y87.407 E.00231
; LINE_WIDTH: 0.421037
G1 X88.242 Y87.518 E.00211
; LINE_WIDTH: 0.384181
G1 X88.222 Y87.629 E.00191
G1 X88.266 Y87.57 E.00125
; LINE_WIDTH: 0.421037
G1 X88.309 Y87.511 E.00137
; LINE_WIDTH: 0.457894
G1 X88.353 Y87.452 E.0015
; WIPE_START
G1 F3840
G1 X88.309 Y87.511 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X91.778 Y87.629 Z5.04 F18000
G1 Z4.64
G1 E.3 F1800
; Slow Down Start
; LINE_WIDTH: 0.365752
G1 F3000;_EXTRUDE_SET_SPEED
M204 S6000
G1 X91.778 Y92.34 E.07591
; Slow Down End
; WIPE_START
G1 X91.778 Y90.34 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X88.285 Y92.83 Z5.04 F18000
G1 Z4.64
G1 E.3 F1800
; LINE_WIDTH: 0.483852
G1 F964
M204 S6000
G1 X88.285 Y93.059 E.00498
G1 X91.715 Y93.059 E.07447
G1 X91.723 Y92.704 E.00772
; LINE_WIDTH: 0.451386
G1 X91.741 Y92.602 E.00208
; LINE_WIDTH: 0.417132
G1 X91.759 Y92.501 E.00191
; LINE_WIDTH: 0.382879
G1 X91.777 Y92.4 E.00174
G1 X91.722 Y92.464 E.00143
; LINE_WIDTH: 0.417132
G1 X91.667 Y92.528 E.00157
; LINE_WIDTH: 0.451386
G1 X91.611 Y92.592 E.0017
; LINE_WIDTH: 0.483934
G1 X88.389 Y92.592 E.06999
; LINE_WIDTH: 0.451386
G1 X88.333 Y92.528 E.0017
; LINE_WIDTH: 0.417132
G1 X88.278 Y92.464 E.00157
; LINE_WIDTH: 0.382879
G1 X88.223 Y92.4 E.00143
; LINE_WIDTH: 0.385554
G1 X88.241 Y92.523 E.00213
; LINE_WIDTH: 0.425157
G1 X88.259 Y92.647 E.00236
; LINE_WIDTH: 0.464761
G1 X88.276 Y92.77 E.0026
; CHANGE_LAYER
; Z_HEIGHT: 4.76
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F3840
G1 X88.259 Y92.647 E-.285
; WIPE_END
G1 E-.015 F1800
; layer num/total_layer_count: 39/43
; update layer progress
M73 L39
M991 S0 P38 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z5.04 I1.214 J-.085 P1  F18000
G1 X87.843 Y86.723 Z5.04
G1 Z4.76
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F786
M204 S6000
G1 X92.157 Y86.723 E.08672
G1 X92.157 Y93.277 E.13177
G1 X87.843 Y93.277 E.08672
G1 X87.843 Y86.783 E.13056
M204 S10000
G1 X87.419 Y86.299 F18000
G1 F786
M204 S6000
G1 X92.581 Y86.299 E.10379
M73 P92 R1
G1 X92.581 Y93.701 E.14883
G1 X87.419 Y93.701 E.10379
G1 X87.419 Y86.359 E.14762
M204 S250
G1 X87.01 Y85.89 F18000
M106 S229.5
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F786
M204 S5000
G1 X92.99 Y85.89 E.11174
G1 X92.99 Y94.11 E.1536
G1 X87.01 Y94.11 E.11174
G1 X87.01 Y85.95 E.15248
; WIPE_START
G1 F1800
M204 S6000
G1 X89.01 Y85.93 E-.285
; WIPE_END
G1 E-.015
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




G1 X88.017 Y87.672
G1 Z4.76
G1 E.3 F1800
; FEATURE: Bridge
; LINE_WIDTH: 0.41
; LAYER_HEIGHT: 0.4
G1 F2726.747
M204 S6000
G1 X89.535 Y87.179 E.08323
G1 X91.023 Y87.179 E.07762
G1 X88.219 Y88.09 E.15374
G1 X88.219 Y88.574 E.02522
G1 X91.781 Y87.417 E.19528
G1 X91.781 Y87.9 E.02522
G1 X88.219 Y89.057 E.19528
G1 X88.219 Y89.541 E.02522
G1 X91.781 Y88.384 E.19528
G1 X91.781 Y88.868 E.02522
G1 X88.219 Y90.025 E.19528
G1 X88.219 Y90.508 E.02522
G1 X91.781 Y89.351 E.19528
G1 X91.781 Y89.835 E.02522
G1 X88.219 Y90.992 E.19528
G1 X88.219 Y91.476 E.02522
G1 X91.781 Y90.319 E.19528
G1 X91.781 Y90.802 E.02522
G1 X88.219 Y91.959 E.19528
G1 X88.219 Y92.443 E.02522
G1 X91.781 Y91.286 E.19528
G1 X91.781 Y91.77 E.02522
G1 X88.545 Y92.821 E.17742
G1 X90.034 Y92.821 E.07762
G1 X91.781 Y92.253 E.0958
G1 X91.781 Y92.737 E.02522
G1 X90.899 Y93.023 E.04835
M106 S73.95
; CHANGE_LAYER
; Z_HEIGHT: 4.88
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F2726.747
G1 X91.781 Y92.737 E-.13213
G1 X91.781 Y92.253 E-.06892
G1 X91.221 Y92.435 E-.08395
; WIPE_END
G1 E-.015 F1800
; layer num/total_layer_count: 40/43
; update layer progress
M73 L40
M991 S0 P39 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z5.16 I1.036 J-.638 P1  F18000
G1 X87.843 Y86.947 Z5.16
G1 Z4.88
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1129
M204 S6000
G1 X92.157 Y86.947 E.08672
G1 X92.157 Y93.053 E.12276
G1 X87.843 Y93.053 E.08672
G1 X87.843 Y87.007 E.12155
M204 S10000
G1 X87.419 Y86.523 F18000
G1 F1129
M204 S6000
G1 X92.581 Y86.523 E.10379
G1 X92.581 Y93.477 E.13982
G1 X87.419 Y93.477 E.10379
G1 X87.419 Y86.583 E.13861
M204 S250
G1 X87.01 Y86.114 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1129
M204 S5000
G1 X92.99 Y86.114 E.11174
G1 X92.99 Y93.886 E.14523
G1 X87.01 Y93.886 E.11174
G1 X87.01 Y86.174 E.1441
; WIPE_START
G1 F1800
M204 S6000
G1 X89.01 Y86.154 E-.285
; WIPE_END
G1 E-.015
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




G1 X90.184 Y89.104
G1 Z4.88
G1 E.3 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.393202
G1 F1129
M204 S6000
G1 X90.184 Y88.92 E.0032
G1 X89.816 Y88.92 E.0064
G1 X89.816 Y91.08 E.03761
G1 X90.184 Y91.08 E.0064
G1 X90.184 Y89.164 E.03336
M204 S10000
G1 X90.565 Y89.104 F18000
; LINE_WIDTH: 0.419992
G1 F1129
M204 S6000
G1 X90.565 Y88.539 E.01055
G1 X89.435 Y88.539 E.0211
G1 X89.435 Y91.461 E.05458
G1 X90.565 Y91.461 E.0211
G1 X90.565 Y89.164 E.04291
M204 S10000
G1 X90.959 Y89.104 F18000
G1 F1129
M204 S6000
G1 X90.959 Y88.145 E.01792
G1 X89.041 Y88.145 E.03583
G1 X89.041 Y91.855 E.06932
G1 X90.959 Y91.855 E.03583
G1 X90.959 Y89.164 E.05028
M204 S10000
M73 P93 R1
G1 X91.353 Y89.104 F18000
G1 F1129
M204 S6000
G1 X91.353 Y87.751 E.02528
G1 X88.647 Y87.751 E.05056
G1 X88.647 Y92.249 E.08405
G1 X91.353 Y92.249 E.05056
G1 X91.353 Y89.164 E.05765
M204 S10000
G1 X91.747 Y89.104 F18000
G1 F1129
M204 S6000
G1 X91.747 Y87.357 E.03265
G1 X88.253 Y87.357 E.0653
G1 X88.253 Y92.643 E.09878
G1 X91.747 Y92.643 E.0653
G1 X91.747 Y89.164 E.06501
; CHANGE_LAYER
; Z_HEIGHT: 5
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F4800
G1 X91.747 Y91.164 E-.285
; WIPE_END
M73 P93 R0
G1 E-.015 F1800
; layer num/total_layer_count: 41/43
; update layer progress
M73 L41
M991 S0 P40 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z5.28 I.87 J-.851 P1  F18000
G1 X87.843 Y87.171 Z5.28
G1 Z5
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1062
M204 S6000
G1 X92.157 Y87.171 E.08672
G1 X92.157 Y92.829 E.11375
G1 X87.843 Y92.829 E.08672
G1 X87.843 Y87.231 E.11254
M204 S10000
G1 X87.419 Y86.747 F18000
G1 F1062
M204 S6000
G1 X92.581 Y86.747 E.10379
G1 X92.581 Y93.253 E.13081
G1 X87.419 Y93.253 E.10379
G1 X87.419 Y86.807 E.1296
M204 S250
G1 X87.01 Y86.338 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1062
M204 S5000
G1 X92.99 Y86.338 E.11174
G1 X92.99 Y93.662 E.13685
G1 X87.01 Y93.662 E.11174
G1 X87.01 Y86.398 E.13573
; WIPE_START
G1 F1800
M204 S6000
G1 X89.01 Y86.378 E-.285
; WIPE_END
G1 E-.015
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




G1 X90.184 Y89.328
G1 Z5
G1 E.3 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.393202
G1 F1062
M204 S6000
G1 X90.184 Y89.144 E.0032
G1 X89.816 Y89.144 E.0064
G1 X89.816 Y90.856 E.02981
G1 X90.184 Y90.856 E.0064
G1 X90.184 Y89.388 E.02556
M204 S10000
G1 X90.565 Y89.328 F18000
; LINE_WIDTH: 0.419992
G1 F1062
M204 S6000
G1 X90.565 Y88.763 E.01055
G1 X89.435 Y88.763 E.0211
G1 X89.435 Y91.237 E.04621
G1 X90.565 Y91.237 E.0211
G1 X90.565 Y89.388 E.03454
M204 S10000
G1 X90.959 Y89.328 F18000
G1 F1062
M204 S6000
G1 X90.959 Y88.369 E.01792
G1 X89.041 Y88.369 E.03583
G1 X89.041 Y91.631 E.06094
M73 P94 R0
G1 X90.959 Y91.631 E.03583
G1 X90.959 Y89.388 E.04191
M204 S10000
G1 X91.353 Y89.328 F18000
G1 F1062
M204 S6000
G1 X91.353 Y87.975 E.02528
G1 X88.647 Y87.975 E.05056
G1 X88.647 Y92.025 E.07568
G1 X91.353 Y92.025 E.05056
G1 X91.353 Y89.388 E.04927
M204 S10000
G1 X91.747 Y89.328 F18000
G1 F1062
M204 S6000
G1 X91.747 Y87.581 E.03265
G1 X88.253 Y87.581 E.0653
G1 X88.253 Y92.419 E.09041
G1 X91.747 Y92.419 E.0653
G1 X91.747 Y89.388 E.05664
; CHANGE_LAYER
; Z_HEIGHT: 5.12
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F4800
G1 X91.747 Y91.388 E-.285
; WIPE_END
G1 E-.015 F1800
; layer num/total_layer_count: 42/43
; update layer progress
M73 L42
M991 S0 P41 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z5.4 I.87 J-.851 P1  F18000
G1 X87.843 Y87.395 Z5.4
G1 Z5.12
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1000
M204 S6000
G1 X92.157 Y87.395 E.08672
G1 X92.157 Y92.605 E.10474
G1 X87.843 Y92.605 E.08672
G1 X87.843 Y87.455 E.10353
M204 S10000
G1 X87.419 Y86.971 F18000
G1 F1000
M204 S6000
G1 X92.581 Y86.971 E.10379
G1 X92.581 Y93.029 E.1218
G1 X87.419 Y93.029 E.10379
G1 X87.419 Y87.031 E.1206
M204 S250
G1 X87.01 Y86.562 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1000
M204 S5000
G1 X92.99 Y86.562 E.11174
G1 X92.99 Y93.438 E.12848
G1 X87.01 Y93.438 E.11174
G1 X87.01 Y86.622 E.12736
; WIPE_START
G1 F1800
M204 S6000
G1 X89.01 Y86.602 E-.285
; WIPE_END
G1 E-.015
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




G1 X90.184 Y89.552
G1 Z5.12
G1 E.3 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.393202
G1 F1000
M204 S6000
G1 X90.184 Y89.368 E.0032
G1 X89.816 Y89.368 E.0064
G1 X89.816 Y90.632 E.022
G1 X90.184 Y90.632 E.0064
G1 X90.184 Y89.612 E.01776
M204 S10000
G1 X90.565 Y89.552 F18000
; LINE_WIDTH: 0.419992
G1 F1000
M204 S6000
G1 X90.565 Y88.987 E.01055
G1 X89.435 Y88.987 E.0211
G1 X89.435 Y91.013 E.03784
G1 X90.565 Y91.013 E.0211
G1 X90.565 Y89.612 E.02617
M204 S10000
G1 X90.959 Y89.552 F18000
G1 F1000
M204 S6000
G1 X90.959 Y88.593 E.01792
G1 X89.041 Y88.593 E.03583
G1 X89.041 Y91.407 E.05257
G1 X90.959 Y91.407 E.03583
M73 P95 R0
G1 X90.959 Y89.612 E.03354
M204 S10000
G1 X91.353 Y89.552 F18000
G1 F1000
M204 S6000
G1 X91.353 Y88.199 E.02528
G1 X88.647 Y88.199 E.05056
G1 X88.647 Y91.801 E.06731
G1 X91.353 Y91.801 E.05056
G1 X91.353 Y89.612 E.0409
M204 S10000
G1 X91.747 Y89.552 F18000
G1 F1000
M204 S6000
G1 X91.747 Y87.805 E.03265
G1 X88.253 Y87.805 E.0653
G1 X88.253 Y92.195 E.08204
G1 X91.747 Y92.195 E.0653
G1 X91.747 Y89.612 E.04827
; CHANGE_LAYER
; Z_HEIGHT: 5.24
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F4800
G1 X91.747 Y91.612 E-.285
; WIPE_END
G1 E-.015 F1800
; layer num/total_layer_count: 43/43
; update layer progress
M73 L43
M991 S0 P42 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z5.52 I.868 J-.853 P1  F18000
G1 X87.01 Y86.786 Z5.52
G1 Z5.24
G1 E.3 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1072
M204 S5000
G1 X92.99 Y86.786 E.11174
G1 X92.99 Y93.214 E.12011
G1 X87.01 Y93.214 E.11174
G1 X87.01 Y86.846 E.11899
; WIPE_START
G1 F1800
M204 S6000
G1 X89.01 Y86.826 E-.285
; WIPE_END
G1 E-.015
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




G1 X92.773 Y87.477
G1 Z5.24
G1 E.3 F1800
; FEATURE: Top surface
G1 F1072
M204 S2000
G1 X92.299 Y87.003 E.01252
G1 X91.742 Y87.003
G1 X92.773 Y88.034 E.02725
G1 X92.773 Y88.592
G1 X91.184 Y87.003 E.04199
G1 X90.627 Y87.003
G1 X92.773 Y89.149 E.05672
G1 X92.773 Y89.707
G1 X90.069 Y87.003 E.07145
G1 X89.512 Y87.003
G1 X92.773 Y90.264 E.08619
G1 X92.773 Y90.822
G1 X88.954 Y87.003 E.10092
G1 X88.397 Y87.003
G1 X92.773 Y91.379 E.11565
G1 X92.773 Y91.937
G1 X87.839 Y87.003 E.13039
G1 X87.282 Y87.003
G1 X92.773 Y92.494 E.14512
G1 X92.718 Y92.997
G1 X87.227 Y87.506 E.14512
G1 X87.227 Y88.063
G1 X92.161 Y92.997 E.13038
G1 X91.603 Y92.997
G1 X87.227 Y88.621 E.11565
G1 X87.227 Y89.178
G1 X91.046 Y92.997 E.10092
G1 X90.488 Y92.997
M73 P96 R0
G1 X87.227 Y89.736 E.08618
G1 X87.227 Y90.293
G1 X89.931 Y92.997 E.07145
G1 X89.373 Y92.997
G1 X87.227 Y90.851 E.05672
G1 X87.227 Y91.408
G1 X88.816 Y92.997 E.04198
G1 X88.258 Y92.997
G1 X87.227 Y91.966 E.02725
G1 X87.227 Y92.524
G1 X87.7 Y92.997 E.01252
; close powerlost recovery
M1003 S0
; WIPE_START
G1 F3600
M204 S6000
G1 X87.227 Y92.524 E-.09545
G1 X87.227 Y91.966 E-.07945
G1 X87.773 Y92.512 E-.1101
; WIPE_END
G1 E-.015 F1800
M204 S10000
G17
G3 Z5.64 I1.217 J0 P1  F18000
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
G1 Z5.64 F900 ; lower z a little
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

    G1 Z105.24 F600
    G1 Z103.24

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

