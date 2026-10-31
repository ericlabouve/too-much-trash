; HEADER_BLOCK_START
; BambuStudio 02.07.01.62
; model printing time: 12m 37s; total estimated time: 19m 46s
; total layer number: 74
; total filament length [mm] : 356.93
; total filament volume [cm^3] : 858.52
; total filament weight [g] : 1.07
; filament_density: 1.25
; filament_diameter: 1.75
; max_z_height: 8.96
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
M73 P0 R19
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
M73 P2 R19
    G1 E50 F200
    M400
    M1002 set_filament_type:PETG

    M104 S270

    G92 E0
    G1 E50 F149.669
    M400
    M106 P1 S178
    G92 E0
M73 P3 R19
    G1 E5 F149.669
    M109 S230 ; drop nozzle temp, make filament shink a bit
    M104 S210
    G92 E0
M73 P5 R18
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
M73 P27 R14
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
M73 P28 R14
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
    G29 A1 X56.2475 Y79 I17.505 J12
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
        G1 X0 F18000
        G1 X-13.5 F3000
        G1 X0 F18000 ;wipe and shake
        G1 X-13.5 F3000
        G1 X0 F12000 ;wipe and shake
        M400
        M106 P1 S0
    M623
    
M73 P29 R13
    G1 X-13.5 F3000
    M400
    M984 A0.1 E1 S1 F0.591372 H0.4
    M106 P1 S178
    M400 S7
    G1 X0 F18000
M73 P30 R13
    G1 X-13.5 F3000
    G1 X0 F18000 ;wipe and shake
    G1 X-13.5 F3000
    G1 X0 F12000 ;wipe and shake
M73 P31 R13
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
; layer num/total_layer_count: 1/74
; update layer progress
M73 L1
M991 S0 P0 ;notify layer change
M106 S0
; OBJECT_ID: 8
G1 X63.05 Y87.864 F18000
M204 S6000
G1 Z.4
M73 P32 R13
G1 Z.2
M73 P33 R13
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.5
M204 S500
G1 X62.136 Y87.864 E.03301
G1 X62.136 Y82.136 E.20683
G1 X67.864 Y82.136 E.20683
G1 X67.864 Y87.864 E.20683
G1 X63.11 Y87.864 E.17165
M204 S6000
G1 X63.05 Y87.407 F18000
M73 P34 R13
G1 F1800
M204 S500
G1 X62.593 Y87.407 E.0165
G1 X62.593 Y82.593 E.17382
G1 X67.407 Y82.593 E.17382
G1 X67.407 Y87.407 E.17382
G1 X63.11 Y87.407 E.15515
M204 S6000
G1 X63.05 Y86.95 F18000
; FEATURE: Outer wall
G1 F1800
M204 S500
G1 X63.05 Y83.05 E.14081
G1 X66.95 Y83.05 E.14081
G1 X66.95 Y86.95 E.14081
G1 X63.11 Y86.95 E.13865
; WIPE_START
G1 X63.079 Y84.95 E-.285
; WIPE_END
M73 P35 R12
G1 E-.015
M204 S6000
G1 X60.852 Y89.836 Z.6 F18000
G1 Z.2
G1 E.3 F1800
; FEATURE: Inner wall
M204 S500
G1 X60.852 Y80.164 E.34921
M73 P36 R12
G1 X69.148 Y80.164 E.29954
G1 X69.148 Y89.836 E.34921
G1 X60.912 Y89.836 E.29737
M204 S6000
G1 X60.395 Y90.293 F18000
G1 F1800
M204 S500
G1 X60.395 Y79.707 E.38221
G1 X69.605 Y79.707 E.33254
G1 X69.605 Y90.293 E.38221
G1 X60.455 Y90.293 E.33038
M204 S6000
G1 X59.937 Y90.75 F18000
; FEATURE: Outer wall
G1 F1800
M204 S500
G1 X59.937 Y79.25 E.41522
G1 X70.062 Y79.25 E.36555
G1 X70.062 Y90.75 E.41522
G1 X59.997 Y90.75 E.36339
; WIPE_START
G1 X59.987 Y88.75 E-.285
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
G1 Z0.6
G1 X0 Y85 ; move to safe pos
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




G1 X68.011 Y80.347
G1 Z.2
G1 E.3 F1800
; FEATURE: Bottom surface
; LINE_WIDTH: 0.51417
G1 F3000
M204 S500
G1 X68.759 Y81.095 E.0394
G1 X68.759 Y81.762 E.02481
G1 X67.55 Y80.553 E.06365
G1 X66.884 Y80.553 E.02481
G1 X68.965 Y82.634 E.10957
M204 S6000
G1 X68.047 Y82.382 F18000
G1 F3000
M204 S500
G1 X68.759 Y83.095 E.03749
G1 X68.759 Y83.761 E.02481
G1 X68.253 Y83.255 E.02667
G1 X68.253 Y83.921 E.02481
G1 X68.759 Y84.428 E.02667
G1 X68.759 Y85.094 E.02481
G1 X68.253 Y84.587 E.02667
G1 X68.253 Y85.254 E.02481
G1 X68.759 Y85.76 E.02667
G1 X68.759 Y86.427 E.02481
G1 X68.253 Y85.92 E.02667
G1 X68.253 Y86.587 E.02481
G1 X68.759 Y87.093 E.02667
G1 X68.759 Y87.76 E.02481
G1 X68.253 Y87.253 E.02667
G1 X68.253 Y87.92 E.02481
G1 X68.759 Y88.426 E.02667
G1 X68.759 Y89.093 E.02481
G1 X67.919 Y88.253 E.04423
G1 X67.253 Y88.253 E.02481
G1 X68.447 Y89.447 E.06289
G1 X67.781 Y89.447 E.02481
G1 X66.586 Y88.253 E.06289
G1 X65.92 Y88.253 E.02481
G1 X67.114 Y89.447 E.0629
G1 X66.448 Y89.447 E.02481
G1 X65.253 Y88.253 E.0629
G1 X64.587 Y88.253 E.02481
G1 X65.782 Y89.447 E.0629
G1 X65.115 Y89.447 E.02481
G1 X63.92 Y88.253 E.06289
G1 X63.254 Y88.253 E.02481
G1 X64.449 Y89.447 E.06289
G1 X63.782 Y89.447 E.02481
G1 X62.382 Y88.047 E.07372
; WIPE_START
G1 X63.782 Y89.447 E-.28221
G1 X63.802 Y89.447 E-.00279
; WIPE_END
G1 E-.015 F1800
M204 S6000
G1 X67.265 Y82.646 Z.6 F18000
G1 X67.618 Y81.953 Z.6
G1 Z.2
G1 E.3 F1800
G1 F3000
M204 S500
G1 X66.217 Y80.553 E.07372
G1 X65.551 Y80.553 E.02481
G1 X66.745 Y81.747 E.06289
G1 X66.079 Y81.747 E.02481
G1 X64.884 Y80.553 E.06289
G1 X64.218 Y80.553 E.02481
G1 X65.413 Y81.747 E.0629
G1 X64.746 Y81.747 E.02481
G1 X63.551 Y80.553 E.0629
G1 X62.885 Y80.553 E.02481
G1 X64.08 Y81.747 E.0629
G1 X63.413 Y81.747 E.02481
G1 X62.218 Y80.553 E.06289
G1 X61.552 Y80.553 E.02481
G1 X62.747 Y81.747 E.06289
G1 X62.08 Y81.747 E.02481
G1 X61.24 Y80.907 E.04423
G1 X61.24 Y81.574 E.02481
G1 X61.747 Y82.081 E.0267
G1 X61.747 Y82.747 E.02481
G1 X61.24 Y82.24 E.0267
G1 X61.24 Y82.907 E.02481
G1 X61.747 Y83.414 E.0267
M73 P37 R12
G1 X61.747 Y84.08 E.02481
G1 X61.24 Y83.573 E.0267
G1 X61.24 Y84.239 E.02481
G1 X61.747 Y84.747 E.0267
G1 X61.747 Y85.413 E.02481
G1 X61.24 Y84.906 E.0267
G1 X61.24 Y85.572 E.02481
G1 X61.747 Y86.08 E.0267
G1 X61.747 Y86.746 E.02481
G1 X61.24 Y86.239 E.0267
G1 X61.24 Y86.905 E.02481
G1 X61.953 Y87.618 E.03753
M204 S6000
G1 X61.034 Y87.366 F18000
G1 F3000
M204 S500
G1 X63.116 Y89.447 E.10957
G1 X62.449 Y89.447 E.02481
G1 X61.24 Y88.238 E.06366
G1 X61.24 Y88.905 E.02481
G1 X61.989 Y89.653 E.0394
; CHANGE_LAYER
; Z_HEIGHT: 0.32
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F3000
G1 X61.24 Y88.905 E-.15083
G1 X61.24 Y88.238 E-.09497
G1 X61.435 Y88.433 E-.0392
; WIPE_END
G1 E-.015 F1800
; layer num/total_layer_count: 2/74
; update layer progress
M73 L2
M991 S0 P1 ;notify layer change
; open powerlost recovery
M1003 S1
M104 S245 ; set nozzle temperature
; OBJECT_ID: 8
M204 S10000
G17
G3 Z.6 I.468 J1.123 P1  F18000
G1 X63.09 Y87.743 Z.6
G1 Z.32
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F3600
M204 S6000
G1 X62.257 Y87.743 E.01676
G1 X62.257 Y82.257 E.11033
G1 X67.743 Y82.257 E.11033
G1 X67.743 Y87.743 E.11033
G1 X63.15 Y87.743 E.09236
M204 S10000
G1 X63.09 Y87.319 F18000
G1 F3600
M204 S6000
G1 X62.681 Y87.319 E.00823
G1 X62.681 Y82.681 E.09327
G1 X67.319 Y82.681 E.09327
G1 X67.319 Y87.319 E.09327
G1 X63.15 Y87.319 E.08383
M204 S250
G1 X63.09 Y86.91 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1800
M204 S5000
G1 X63.09 Y83.09 E.07138
G1 X66.91 Y83.09 E.07138
G1 X66.91 Y86.91 E.07138
G1 X63.15 Y86.91 E.07026
; WIPE_START
M204 S6000
G1 X63.119 Y84.91 E-.285
; WIPE_END
G1 E-.015
M204 S10000
G1 X60.236 Y89.957 Z.72 F18000
G1 Z.32
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F3600
M204 S6000
G1 X60.236 Y80.043 E.19933
G1 X69.764 Y80.043 E.19159
G1 X69.764 Y89.957 E.19933
G1 X60.296 Y89.957 E.19038
M204 S10000
G1 X59.812 Y90.381 F18000
G1 F3060
M204 S6000
G1 X59.812 Y79.619 E.21639
G1 F3600
G1 X59.87 Y79.619 E.00117
G1 X70.129 Y79.619 E.20629
G1 X70.188 Y79.619 E.00119
G1 F3060
G1 X70.188 Y90.381 E.21639
G1 F3600
G1 X70.129 Y90.381 E.00118
G1 X59.872 Y90.381 E.20626
M204 S250
G1 X59.487 Y90.79 F18000
; FEATURE: Overhang wall
G1 F600
M204 S5000
G1 X59.402 Y90.79 E.00171
G1 X59.402 Y79.21 E.23285
G1 X59.487 Y79.21 E.00171
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 X59.856 Y79.21 E.0069
G1 F1800
G1 X60.256 Y79.21 E.00747
G1 X69.743 Y79.21 E.17726
G1 X70.143 Y79.21 E.00747
G1 F720
G1 X70.512 Y79.21 E.0069
; FEATURE: Overhang wall
; LINE_WIDTH: 0.45
G1 F600
G1 X70.598 Y79.21 E.00173
G1 X70.597 Y90.79 E.23285
G1 F3000
G1 X70.512 Y90.79 E.00172
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F600
G1 X70.143 Y90.79 E.0069
G1 F1800
G1 X69.743 Y90.79 E.00747
G1 X60.256 Y90.79 E.17726
G1 X59.856 Y90.79 E.00747
G1 F600
G1 X59.547 Y90.79 E.00577
; WIPE_START
M204 S6000
G1 X59.402 Y90.79 E-.02066
G1 X59.402 Y88.935 E-.26434
; WIPE_END
G1 E-.015 F1800
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
G1 X0 Y85 ; move to safe pos
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




G1 X61.469 Y81.206
G1 Z.32
G1 E.3 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.439492
G1 F4800
M204 S6000
G1 X61.418 Y81.206 E.00101
G1 X61.392 Y81.251 E.00101
G1 X61.418 Y81.296 E.00101
G1 X61.461 Y81.296 E.00085
; WIPE_START
G1 X61.418 Y81.296 E-.06234
G1 X61.392 Y81.251 E-.07422
G1 X61.418 Y81.206 E-.07423
G1 X61.469 Y81.206 E-.07421
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X61.847 Y87.956 Z.72 F18000
G1 Z.32
G1 E.3 F1800
; LINE_WIDTH: 0.419992
G1 F4800
M204 S6000
G1 X61.847 Y82.044 E.11045
G1 X61.925 Y81.887 E.00328
G1 X62.044 Y81.847 E.00235
G1 X67.956 Y81.847 E.11045
G1 X68.075 Y81.887 E.00235
G1 X68.153 Y82.044 E.00328
G1 X68.153 Y87.956 E.11045
G1 X68.075 Y88.113 E.00328
G1 X67.956 Y88.153 E.00235
G1 X62.044 Y88.153 E.11045
G1 X61.925 Y88.113 E.00235
G1 X61.874 Y88.009 E.00216
M204 S10000
G1 X61.448 Y87.956 F18000
; LINE_WIDTH: 0.429275
G1 F4800
M204 S6000
G1 X61.448 Y82.044 E.11305
G1 X61.687 Y81.573 E.01011
; LINE_WIDTH: 0.438777
G1 X61.769 Y81.517 E.00193
; LINE_WIDTH: 0.476347
G1 X61.851 Y81.462 E.00211
; LINE_WIDTH: 0.525791
G1 X61.932 Y81.406 E.00234
G1 X62.044 Y81.4 E.00266
G1 X67.956 Y81.4 E.14009
; LINE_WIDTH: 0.508267
G1 X68.075 Y81.458 E.00302
; LINE_WIDTH: 0.472957
G1 X68.194 Y81.515 E.0028
; LINE_WIDTH: 0.429398
G1 X68.313 Y81.573 E.00253
G1 X68.552 Y82.044 E.01011
G1 X68.552 Y87.956 E.11309
G1 X68.546 Y88.059 E.00198
G1 X68.313 Y88.427 E.00833
; LINE_WIDTH: 0.438777
G1 X68.231 Y88.483 E.00193
; LINE_WIDTH: 0.476347
G1 X68.149 Y88.538 E.00211
; LINE_WIDTH: 0.525791
G1 X68.068 Y88.594 E.00234
G1 X67.956 Y88.6 E.00266
G1 X62.044 Y88.6 E.14009
; LINE_WIDTH: 0.508267
G1 X61.925 Y88.542 E.00302
; LINE_WIDTH: 0.472957
G1 X61.806 Y88.485 E.0028
; LINE_WIDTH: 0.43032
G1 X61.687 Y88.427 E.00254
G1 X61.454 Y88.059 E.00835
G1 X61.452 Y88.016 E.00084
M204 S10000
G1 X61.469 Y88.704 F18000
; LINE_WIDTH: 0.439492
G1 F4800
M204 S6000
G1 X61.418 Y88.704 E.00101
G1 X61.392 Y88.749 E.00101
G1 X61.418 Y88.794 E.00101
G1 X61.461 Y88.794 E.00085
; WIPE_START
G1 X61.418 Y88.794 E-.06234
G1 X61.392 Y88.749 E-.07422
G1 X61.418 Y88.704 E-.07423
G1 X61.469 Y88.704 E-.07421
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X68.582 Y88.704 Z.72 F18000
G1 Z.32
G1 E.3 F1800
; LINE_WIDTH: 0.439452
G1 F4800
M204 S6000
G1 X68.531 Y88.704 E.00101
G1 X68.505 Y88.749 E.00101
G1 X68.531 Y88.794 E.00101
G1 X68.574 Y88.794 E.00085
M204 S10000
G1 X68.956 Y87.956 F18000
; LINE_WIDTH: 0.428589
G1 F4800
M204 S6000
G1 X68.961 Y80.847 E.13572
; LINE_WIDTH: 0.437647
G1 X68.626 Y80.865 E.00655
; LINE_WIDTH: 0.472957
G1 X68.291 Y80.882 E.00711
; LINE_WIDTH: 0.524974
G1 X67.956 Y80.9 E.00794
G1 X62.044 Y80.9 E.13986
; LINE_WIDTH: 0.508267
G1 X61.844 Y80.882 E.0046
; LINE_WIDTH: 0.472957
G1 X61.644 Y80.865 E.00426
; LINE_WIDTH: 0.427893
G1 X61.039 Y80.847 E.01152
G1 X61.039 Y89.153 E.15831
; LINE_WIDTH: 0.437647
G1 X61.374 Y89.135 E.00655
; LINE_WIDTH: 0.472957
G1 X61.709 Y89.118 E.00711
; LINE_WIDTH: 0.524974
G1 X62.044 Y89.1 E.00794
G1 X67.956 Y89.1 E.13986
; LINE_WIDTH: 0.508267
G1 X68.156 Y89.118 E.0046
; LINE_WIDTH: 0.472957
G1 X68.356 Y89.135 E.00426
; LINE_WIDTH: 0.427366
G1 X68.96 Y89.153 E.01151
G1 X68.954 Y88.016 E.02165
; WIPE_START
G1 X68.96 Y89.153 E-.1861
G1 X68.356 Y89.135 E-.0989
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X69.315 Y81.563 Z.72 F18000
G1 X69.355 Y81.251 Z.72
G1 Z.32
G1 E.3 F1800
; LINE_WIDTH: 0.419992
G1 F4800
M204 S6000
G1 X69.355 Y80.453 E.01492
G1 X60.645 Y80.453 E.16274
G1 X60.645 Y89.547 E.16993
G1 X69.355 Y89.547 E.16274
G1 X69.355 Y81.311 E.1539
M204 S10000
G1 X68.583 Y81.206 F18000
; LINE_WIDTH: 0.439552
G1 F4800
M204 S6000
G1 X68.531 Y81.206 E.00101
G1 X68.505 Y81.251 E.00101
G1 X68.531 Y81.296 E.00101
G1 X68.574 Y81.296 E.00085
; CHANGE_LAYER
; Z_HEIGHT: 0.44
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F4800
G1 X68.531 Y81.296 E-.06233
G1 X68.505 Y81.251 E-.07422
G1 X68.531 Y81.206 E-.07422
G1 X68.583 Y81.206 E-.07422
; WIPE_END
G1 E-.015 F1800
; layer num/total_layer_count: 3/74
; update layer progress
M73 L3
M991 S0 P2 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z.72 I-.932 J-.783 P1  F18000
G1 X63.09 Y87.743 Z.72
G1 Z.44
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F3600
M204 S6000
G1 X62.257 Y87.743 E.01676
G1 X62.257 Y82.257 E.11033
G1 X67.743 Y82.257 E.11033
G1 X67.743 Y87.743 E.11033
G1 X63.15 Y87.743 E.09236
M204 S10000
M73 P38 R12
G1 X63.09 Y87.319 F18000
G1 F3600
M204 S6000
G1 X62.681 Y87.319 E.00823
G1 X62.681 Y82.681 E.09327
G1 X67.319 Y82.681 E.09327
G1 X67.319 Y87.319 E.09327
G1 X63.15 Y87.319 E.08383
M204 S250
G1 X63.09 Y86.91 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1800
M204 S5000
G1 X63.09 Y83.09 E.07138
G1 X66.91 Y83.09 E.07138
G1 X66.91 Y86.91 E.07138
G1 X63.15 Y86.91 E.07026
; WIPE_START
M204 S6000
G1 X63.119 Y84.91 E-.285
; WIPE_END
G1 E-.015
M204 S10000
G1 X59.977 Y89.957 Z.84 F18000
G1 Z.44
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F3600
M204 S6000
G1 X59.977 Y80.043 E.19933
G1 X70.023 Y80.043 E.20201
G1 X70.023 Y89.957 E.19933
G1 X60.037 Y89.957 E.2008
M204 S10000
G1 X59.553 Y90.381 F18000
G1 F3600
M204 S6000
G1 X59.553 Y79.619 E.21639
G1 X70.447 Y79.619 E.21907
G1 X70.447 Y90.381 E.21639
G1 X59.613 Y90.381 E.21786
M204 S250
G1 X59.361 Y90.79 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1569.074
M204 S5000
G1 X59.143 Y90.79 E.00408
G1 F600
G1 X59.143 Y79.21 E.21638
G1 F1569.074
G1 X59.361 Y79.21 E.00408
G1 F1800
G1 X70.639 Y79.21 E.21072
G1 F1567.319
G1 X70.857 Y79.21 E.00407
G1 F600
G1 X70.856 Y90.79 E.21638
G1 F1568.361
G1 X70.638 Y90.79 E.00407
G1 F1800
G1 X59.421 Y90.79 E.20959
; WIPE_START
M204 S6000
G1 X59.143 Y90.79 E-.03964
G1 X59.143 Y89.068 E-.24536
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
G1 X0 Y85 ; move to safe pos
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
G1 X61.292 Y81.263
G1 Z.44
G1 E.3 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.584432
G1 F4800
M204 S6000
G1 X61.222 Y81.263 E.00185
G1 X61.187 Y81.323 E.00185
G1 X61.222 Y81.384 E.00185
G1 X61.297 Y81.375 E.00199
; WIPE_START
G1 X61.222 Y81.384 E-.07531
G1 X61.187 Y81.323 E-.0699
G1 X61.222 Y81.263 E-.0699
G1 X61.292 Y81.263 E-.06989
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X61.292 Y88.616 Z.84 F18000
G1 Z.44
G1 E.3 F1800
G1 F4800
M204 S6000
G1 X61.222 Y88.616 E.00185
G1 X61.187 Y88.677 E.00185
G1 X61.222 Y88.737 E.00185
G1 X61.297 Y88.729 E.00199
M204 S10000
G1 X62.044 Y88.6 F18000
; LINE_WIDTH: 0.508267
G1 F4800
M204 S6000
G1 X61.899 Y88.518 E.00381
; LINE_WIDTH: 0.472957
G1 X61.754 Y88.437 E.00354
; LINE_WIDTH: 0.437647
G1 X61.608 Y88.355 E.00326
; LINE_WIDTH: 0.444376
G1 X61.535 Y88.26 E.00237
; LINE_WIDTH: 0.493142
G1 X61.463 Y88.165 E.00265
; LINE_WIDTH: 0.558991
G1 X61.39 Y88.07 E.00302
G1 X61.383 Y87.956 E.00291
G1 X61.383 Y82.044 E.14939
; LINE_WIDTH: 0.536051
G1 X61.458 Y81.911 E.00369
; LINE_WIDTH: 0.489627
G1 X61.533 Y81.778 E.00336
; LINE_WIDTH: 0.443204
G1 X61.608 Y81.645 E.00302
; LINE_WIDTH: 0.438777
G1 X61.716 Y81.566 E.00263
; LINE_WIDTH: 0.476347
G1 X61.824 Y81.486 E.00287
; LINE_WIDTH: 0.525722
G1 X61.932 Y81.406 E.00318
G1 X62.044 Y81.4 E.00266
G1 X67.956 Y81.4 E.14007
; LINE_WIDTH: 0.508267
G1 X68.101 Y81.482 E.00381
; LINE_WIDTH: 0.472957
G1 X68.246 Y81.563 E.00353
; LINE_WIDTH: 0.437647
G1 X68.392 Y81.645 E.00326
; LINE_WIDTH: 0.443191
G1 X68.467 Y81.778 E.00302
; LINE_WIDTH: 0.489587
G1 X68.542 Y81.911 E.00336
; LINE_WIDTH: 0.558573
G1 X68.617 Y82.044 E.00386
G1 X68.617 Y87.956 E.14928
; LINE_WIDTH: 0.562637
G1 X68.61 Y88.07 E.00293
; LINE_WIDTH: 0.541784
G1 X68.537 Y88.165 E.00292
; LINE_WIDTH: 0.493067
G1 X68.465 Y88.26 E.00265
; LINE_WIDTH: 0.444351
G1 X68.392 Y88.355 E.00237
; LINE_WIDTH: 0.438777
G1 X68.284 Y88.435 E.00263
; LINE_WIDTH: 0.476347
G1 X68.176 Y88.514 E.00287
; LINE_WIDTH: 0.52572
G1 X68.068 Y88.594 E.00318
G1 X67.956 Y88.6 E.00266
G1 X62.104 Y88.6 E.13865
M204 S10000
G1 X61.847 Y87.956 F18000
; LINE_WIDTH: 0.419992
G1 F4800
M204 S6000
G1 X61.847 Y82.044 E.11045
G1 X61.899 Y81.911 E.00267
G1 X62.044 Y81.847 E.00297
G1 X67.956 Y81.847 E.11045
G1 X68.101 Y81.911 E.00297
G1 X68.153 Y82.044 E.00267
G1 X68.153 Y87.956 E.11045
G1 X68.101 Y88.089 E.00267
G1 X67.956 Y88.153 E.00297
G1 X62.044 Y88.153 E.11045
G1 X61.899 Y88.089 E.00297
G1 X61.869 Y88.012 E.00155
; WIPE_START
G1 X61.899 Y88.089 E-.0118
G1 X62.044 Y88.153 E-.02264
G1 X63.803 Y88.153 E-.25056
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X67.956 Y89.1 Z.84 F18000
G1 Z.44
G1 E.3 F1800
; LINE_WIDTH: 0.508267
G1 F4800
M204 S6000
G1 X68.218 Y89.118 E.00602
; LINE_WIDTH: 0.472957
G1 X68.481 Y89.135 E.00558
; LINE_WIDTH: 0.423813
G1 X69.219 Y89.153 E.01394
G1 X69.219 Y88.677 E.00899
; LINE_WIDTH: 0.444351
G1 X69.195 Y88.49 E.00373
; LINE_WIDTH: 0.493067
G1 X69.171 Y88.304 E.00417
; LINE_WIDTH: 0.558725
G1 X69.146 Y88.117 E.00475
G1 X69.15 Y82.044 E.1534
; LINE_WIDTH: 0.535984
G1 X69.173 Y81.804 E.00584
; LINE_WIDTH: 0.489587
G1 X69.196 Y81.564 E.00531
; LINE_WIDTH: 0.427795
G1 X69.22 Y81.323 E.0046
G1 X69.22 Y80.847 E.00908
; LINE_WIDTH: 0.437647
G1 X68.798 Y80.865 E.00823
; LINE_WIDTH: 0.472957
G1 X68.377 Y80.882 E.00894
; LINE_WIDTH: 0.524747
G1 X67.956 Y80.9 E.00997
G1 X62.044 Y80.9 E.1398
; LINE_WIDTH: 0.508267
G1 X61.782 Y80.882 E.00602
; LINE_WIDTH: 0.472957
G1 X61.519 Y80.865 E.00558
; LINE_WIDTH: 0.423813
G1 X60.78 Y80.847 E.01395
G1 X60.78 Y81.323 E.00899
; LINE_WIDTH: 0.443204
G1 X60.803 Y81.564 E.00478
; LINE_WIDTH: 0.489627
M73 P39 R12
G1 X60.827 Y81.804 E.00531
; LINE_WIDTH: 0.558351
G1 X60.85 Y82.044 E.00609
G1 X60.85 Y87.956 E.14922
; LINE_WIDTH: 0.536051
G1 X60.827 Y88.196 E.00584
; LINE_WIDTH: 0.489627
G1 X60.803 Y88.436 E.00531
; LINE_WIDTH: 0.427799
G1 X60.78 Y88.677 E.0046
G1 X60.78 Y89.153 E.00908
; LINE_WIDTH: 0.437647
G1 X61.202 Y89.135 E.00823
; LINE_WIDTH: 0.472957
G1 X61.623 Y89.118 E.00894
; LINE_WIDTH: 0.524735
G1 X62.044 Y89.1 E.00997
G1 X67.896 Y89.1 E.13838
; WIPE_START
G1 X65.896 Y89.1 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X68.778 Y88.616 Z.84 F18000
G1 Z.44
G1 E.3 F1800
; LINE_WIDTH: 0.584272
G1 F4800
M204 S6000
G1 X68.708 Y88.616 E.00185
G1 X68.673 Y88.677 E.00185
G1 X68.708 Y88.737 E.00185
G1 X68.783 Y88.729 E.00199
; WIPE_START
G1 X68.708 Y88.737 E-.07529
G1 X68.673 Y88.677 E-.0699
G1 X68.708 Y88.616 E-.06991
G1 X68.778 Y88.616 E-.06989
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X69.614 Y81.323 Z.84 F18000
G1 Z.44
G1 E.3 F1800
; LINE_WIDTH: 0.419992
G1 F4800
M204 S6000
G1 X69.614 Y80.453 E.01627
G1 X60.386 Y80.453 E.17242
G1 X60.386 Y89.547 E.16993
G1 X69.614 Y89.547 E.17242
G1 X69.614 Y81.383 E.15254
M204 S10000
G1 X68.778 Y81.263 F18000
; LINE_WIDTH: 0.584352
G1 F4800
M204 S6000
G1 X68.708 Y81.263 E.00185
G1 X68.673 Y81.323 E.00185
G1 X68.708 Y81.384 E.00185
G1 X68.783 Y81.375 E.00199
; CHANGE_LAYER
; Z_HEIGHT: 0.56
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F4800
G1 X68.708 Y81.384 E-.0753
G1 X68.673 Y81.323 E-.0699
G1 X68.708 Y81.263 E-.0699
G1 X68.778 Y81.263 E-.0699
; WIPE_END
G1 E-.015 F1800
; layer num/total_layer_count: 4/74
; update layer progress
M73 L4
M991 S0 P3 ;notify layer change
M106 S73.95
; OBJECT_ID: 8
M204 S10000
G17
G3 Z.84 I-.915 J-.803 P1  F18000
G1 X63.09 Y87.743 Z.84
G1 Z.56
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F3600
M204 S6000
G1 X62.257 Y87.743 E.01676
G1 X62.257 Y82.257 E.11033
G1 X67.743 Y82.257 E.11033
G1 X67.743 Y87.743 E.11033
G1 X63.15 Y87.743 E.09236
M204 S10000
G1 X63.09 Y87.319 F18000
G1 F3600
M204 S6000
G1 X62.681 Y87.319 E.00823
G1 X62.681 Y82.681 E.09327
G1 X67.319 Y82.681 E.09327
G1 X67.319 Y87.319 E.09327
G1 X63.15 Y87.319 E.08383
M204 S250
G1 X63.09 Y86.91 F18000
M106 S229.5
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1800
M204 S5000
G1 X63.09 Y83.09 E.07138
G1 X66.91 Y83.09 E.07138
G1 X66.91 Y86.91 E.07138
G1 X63.15 Y86.91 E.07026
; WIPE_START
M204 S6000
G1 X63.119 Y84.91 E-.285
; WIPE_END
G1 E-.015
M204 S10000
G1 X59.764 Y89.957 Z.96 F18000
G1 Z.56
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F3600
M204 S6000
G1 X59.764 Y80.043 E.19933
G1 X70.236 Y80.043 E.21056
G1 X70.236 Y89.957 E.19933
G1 X59.824 Y89.957 E.20935
M204 S10000
G1 X59.34 Y90.381 F18000
G1 F3600
M204 S6000
G1 X59.34 Y79.619 E.21639
G1 X70.66 Y79.619 E.22762
G1 X70.66 Y90.381 E.21639
G1 X59.4 Y90.381 E.22641
M204 S250
G1 X59.102 Y90.79 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1670.427
M204 S5000
G1 X58.931 Y90.79 E.00321
M106 S73.95
M106 S229.5
G1 F840
G1 X58.931 Y79.21 E.21638
M106 S73.95
M106 S229.5
G1 F1670.427
G1 X59.102 Y79.21 E.00321
M106 S73.95
M106 S229.5
G1 F1800
G1 X70.898 Y79.21 E.2204
G1 F1672.013
G1 X71.069 Y79.21 E.00321
M106 S73.95
M106 S229.5
G1 F840
G1 X71.069 Y90.79 E.21638
M106 S73.95
M106 S229.5
G1 F1672.126
G1 X70.897 Y90.79 E.00321
M106 S73.95
G1 F1800
G1 X59.162 Y90.79 E.21928
; WIPE_START
M204 S6000
G1 X58.931 Y90.79 E-.033
G1 X58.931 Y89.022 E-.252
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
G1 X0 Y85 ; move to safe pos
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




G1 X69.827 Y81.392
G1 Z.56
G1 E.3 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.419992
G1 F4800
M204 S6000
G1 X69.827 Y80.453 E.01756
G1 X60.173 Y80.453 E.18037
G1 X60.173 Y89.547 E.16993
G1 X69.827 Y89.547 E.18037
M73 P39 R11
G1 X69.827 Y81.452 E.15125
; WIPE_START
G1 X69.827 Y83.452 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X68.99 Y82.044 Z.96 F18000
G1 Z.56
G1 E.3 F1800
; LINE_WIDTH: 0.517107
G1 F4800
M204 S6000
G1 X68.984 Y88.076 E.14046
; WIPE_START
G1 X68.986 Y86.076 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X68.99 Y82.044 Z.96 F18000
G1 Z.56
G1 E.3 F1800
; LINE_WIDTH: 0.493182
G1 F4800
M204 S6000
G1 X69.014 Y81.827 E.00484
; LINE_WIDTH: 0.445562
G1 X69.037 Y81.61 E.00435
; LINE_WIDTH: 0.376977
G1 X69.061 Y81.218 E.00653
G1 X68.218 Y81.218 E.01404
G1 X68.744 Y81.492 E.00988
; LINE_WIDTH: 0.397942
G1 X68.818 Y81.658 E.0032
; LINE_WIDTH: 0.445562
G1 X68.892 Y81.824 E.00361
; LINE_WIDTH: 0.493182
G1 X68.965 Y81.99 E.00402
; WIPE_START
G1 X68.892 Y81.824 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X68.314 Y88.782 Z.96 F18000
G1 Z.56
G1 E.3 F1800
; LINE_WIDTH: 0.374092
G1 F4800
M204 S6000
G1 X69.061 Y88.782 E.01234
; LINE_WIDTH: 0.393902
G1 X69.041 Y88.62 E.00284
; LINE_WIDTH: 0.433522
G1 X69.021 Y88.459 E.00315
; LINE_WIDTH: 0.473142
G1 X69.002 Y88.297 E.00345
; LINE_WIDTH: 0.512762
G1 X68.982 Y88.136 E.00376
G1 X68.922 Y88.229 E.00255
; LINE_WIDTH: 0.473142
G1 X68.863 Y88.322 E.00234
; LINE_WIDTH: 0.433522
G1 X68.804 Y88.415 E.00213
; LINE_WIDTH: 0.377991
G1 X68.744 Y88.508 E.00184
G1 X68.364 Y88.75 E.00752
M204 S10000
G1 X67.956 Y89.1 F18000
; LINE_WIDTH: 0.508267
G1 F4800
M204 S6000
G1 X68.266 Y89.118 E.00711
; LINE_WIDTH: 0.472957
G1 X68.576 Y89.135 E.00659
; LINE_WIDTH: 0.420558
G1 X69.432 Y89.153 E.01602
G1 X69.432 Y80.847 E.15542
G1 X68.887 Y80.847 E.01021
; LINE_WIDTH: 0.437647
G1 X68.576 Y80.865 E.00607
; LINE_WIDTH: 0.472957
G1 X68.266 Y80.882 E.00659
; LINE_WIDTH: 0.52504
G1 X67.956 Y80.9 E.00736
G1 X62.044 Y80.9 E.13988
; LINE_WIDTH: 0.508267
G1 X61.734 Y80.882 E.00711
; LINE_WIDTH: 0.472957
G1 X61.424 Y80.865 E.00659
; LINE_WIDTH: 0.420558
G1 X60.568 Y80.847 E.01602
G1 X60.568 Y89.153 E.15542
G1 X61.113 Y89.153 E.01021
; LINE_WIDTH: 0.437647
G1 X61.424 Y89.135 E.00607
; LINE_WIDTH: 0.472957
G1 X61.734 Y89.118 E.00659
; LINE_WIDTH: 0.525031
G1 X62.044 Y89.1 E.00736
G1 X67.896 Y89.1 E.13846
; WIPE_START
G1 X65.896 Y89.1 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X61.782 Y88.782 Z.96 F18000
G1 Z.56
G1 E.3 F1800
; LINE_WIDTH: 0.374082
G1 F4800
M204 S6000
G1 X61.256 Y88.508 E.0098
; LINE_WIDTH: 0.393888
G1 X61.196 Y88.415 E.00193
; LINE_WIDTH: 0.433501
G1 X61.137 Y88.322 E.00213
; LINE_WIDTH: 0.473113
G1 X61.078 Y88.229 E.00234
; LINE_WIDTH: 0.512726
G1 X61.018 Y88.136 E.00255
G1 X60.998 Y88.297 E.00376
; LINE_WIDTH: 0.473113
G1 X60.979 Y88.459 E.00345
; LINE_WIDTH: 0.433501
G1 X60.959 Y88.62 E.00315
; LINE_WIDTH: 0.37749
G1 X60.939 Y88.782 E.00271
G1 X61.722 Y88.782 E.01306
M204 S10000
G1 X61.847 Y87.956 F18000
; LINE_WIDTH: 0.419992
G1 F4800
M204 S6000
G1 X61.847 Y82.044 E.11045
G1 X61.883 Y81.931 E.00222
G1 X62.044 Y81.847 E.0034
G1 X67.956 Y81.847 E.11045
G1 X68.117 Y81.931 E.0034
G1 X68.153 Y82.044 E.00221
G1 X68.153 Y87.956 E.11045
G1 X68.117 Y88.069 E.00221
G1 X67.956 Y88.153 E.0034
G1 X62.044 Y88.153 E.11045
G1 X61.883 Y88.069 E.0034
G1 X61.865 Y88.013 E.00109
M204 S10000
G1 X61.453 Y87.956 F18000
G1 F4800
M204 S6000
G1 X61.453 Y82.044 E.11045
G1 X61.56 Y81.705 E.00664
; LINE_WIDTH: 0.438777
G1 X61.684 Y81.606 E.00312
; LINE_WIDTH: 0.476347
G1 X61.808 Y81.506 E.0034
; LINE_WIDTH: 0.525675
G1 X61.932 Y81.406 E.00377
G1 X62.044 Y81.4 E.00266
G1 X67.956 Y81.4 E.14006
; LINE_WIDTH: 0.508267
G1 X68.117 Y81.502 E.00436
; LINE_WIDTH: 0.472957
G1 X68.279 Y81.604 E.00405
; LINE_WIDTH: 0.420487
G1 X68.44 Y81.705 E.00357
G1 X68.547 Y82.044 E.00665
G1 X68.547 Y87.956 E.11059
G1 X68.44 Y88.295 E.00665
; LINE_WIDTH: 0.438777
G1 X68.316 Y88.394 E.00312
; LINE_WIDTH: 0.476347
G1 X68.192 Y88.494 E.0034
; LINE_WIDTH: 0.525675
G1 X68.068 Y88.594 E.00377
G1 X67.956 Y88.6 E.00266
G1 X62.044 Y88.6 E.14006
; LINE_WIDTH: 0.508267
G1 X61.883 Y88.498 E.00436
; LINE_WIDTH: 0.472957
G1 X61.721 Y88.396 E.00405
; LINE_WIDTH: 0.426918
G1 X61.56 Y88.295 E.00363
G1 X61.471 Y88.013 E.00562
M204 S10000
G1 X61.018 Y88.136 F18000
; LINE_WIDTH: 0.517106
G1 F4800
M204 S6000
G1 X61.01 Y82.104 E.14046
M204 S10000
G1 X61.01 Y82.044 F18000
; LINE_WIDTH: 0.493074
G1 F4800
M204 S6000
G1 X61.092 Y81.86 E.00446
; LINE_WIDTH: 0.445477
G1 X61.174 Y81.676 E.00401
; LINE_WIDTH: 0.377367
G1 X61.256 Y81.492 E.00336
G1 X61.686 Y81.218 E.00851
G1 X60.939 Y81.218 E.01246
; LINE_WIDTH: 0.397881
G1 X60.961 Y81.474 E.00452
; LINE_WIDTH: 0.445477
G1 X60.983 Y81.729 E.0051
; LINE_WIDTH: 0.493074
G1 X61.005 Y81.985 E.00568
; CHANGE_LAYER
; Z_HEIGHT: 0.68
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F4800
G1 X60.983 Y81.729 E-.285
; WIPE_END
G1 E-.015 F1800
; layer num/total_layer_count: 5/74
; update layer progress
M73 L5
M991 S0 P4 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z.96 I-1.149 J.402 P1  F18000
G1 X63.09 Y87.743 Z.96
G1 Z.68
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F3600
M204 S6000
G1 X62.257 Y87.743 E.01676
G1 X62.257 Y82.257 E.11033
G1 X67.743 Y82.257 E.11033
G1 X67.743 Y87.743 E.11033
G1 X63.15 Y87.743 E.09236
M204 S10000
G1 X63.09 Y87.319 F18000
G1 F3600
M204 S6000
G1 X62.681 Y87.319 E.00823
G1 X62.681 Y82.681 E.09327
G1 X67.319 Y82.681 E.09327
G1 X67.319 Y87.319 E.09327
G1 X63.15 Y87.319 E.08383
M204 S250
G1 X63.09 Y86.91 F18000
M106 S229.5
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1800
M204 S5000
G1 X63.09 Y83.09 E.07138
G1 X66.91 Y83.09 E.07138
G1 X66.91 Y86.91 E.07138
G1 X63.15 Y86.91 E.07026
; WIPE_START
M204 S6000
G1 X63.119 Y84.91 E-.285
; WIPE_END
G1 E-.015
M204 S10000
G1 X59.582 Y89.957 Z1.08 F18000
G1 Z.68
M73 P40 R11
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F3600
M204 S6000
G1 X59.582 Y80.044 E.19932
G1 X70.419 Y80.05 E.21791
G1 X70.419 Y89.957 E.1992
G1 X59.642 Y89.957 E.2167
M204 S10000
G1 X59.157 Y90.381 F18000
G1 F3600
M204 S6000
G1 X59.157 Y79.62 E.21638
G1 X70.843 Y79.626 E.23497
G1 X70.843 Y90.381 E.21626
G1 X59.217 Y90.381 E.23376
M204 S250
G1 X58.89 Y90.79 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1976.169
M204 S5000
G1 X58.748 Y90.79 E.00265
M106 S73.95
M106 S229.5
G1 F1200
G1 X58.748 Y79.21 E.21638
M106 S73.95
M106 S229.5
G1 F1564.01
G1 X58.89 Y79.21 E.00265
M106 S73.95
M106 S229.5
G1 F1800
G1 X71.11 Y79.217 E.22835
G1 F2240.344
G1 X71.252 Y79.217 E.00265
M106 S73.95
M106 S229.5
G1 F1200
G1 X71.252 Y90.79 E.21625
M106 S73.95
M106 S229.5
G1 F1564.366
G1 X71.11 Y90.79 E.00265
M106 S73.95
G1 F1800
G1 X58.95 Y90.79 E.22723
; WIPE_START
M204 S6000
G1 X58.748 Y90.79 E-.02873
G1 X58.748 Y88.992 E-.25627
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
G1 X0 Y85 ; move to safe pos
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




G1 X68.913 Y87.956
G1 Z.68
G1 E.3 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.38182
G1 F4534
M204 S6000
G1 X68.868 Y88.199 E.00417
; LINE_WIDTH: 0.436249
G1 X68.824 Y88.442 E.0048
G1 X68.391 Y88.749 E.01034
G1 X69.211 Y88.749 E.01597
; LINE_WIDTH: 0.422205
G1 X69.228 Y88.45 E.00562
; LINE_WIDTH: 0.364015
G1 X69.249 Y87.956 E.00794
G1 X69.249 Y82.044 E.09477
; LINE_WIDTH: 0.381532
G1 X69.231 Y81.753 E.00492
; LINE_WIDTH: 0.435315
G1 X69.212 Y81.256 E.00966
G1 X68.305 Y81.255 E.0176
G1 X68.825 Y81.562 E.01172
; LINE_WIDTH: 0.419212
G1 X68.869 Y81.803 E.00457
; LINE_WIDTH: 0.36345
G1 X68.913 Y82.044 E.00392
G1 X68.913 Y87.896 E.09365
; WIPE_START
G1 F4800
G1 X68.913 Y85.896 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X70.009 Y81.462 Z1.08 F18000
G1 Z.68
G1 E.3 F1800
; LINE_WIDTH: 0.419992
G1 F4534
M204 S6000
G1 X70.009 Y80.459 E.01874
G1 X59.991 Y80.453 E.1872
G1 X59.991 Y89.547 E.16992
G1 X70.009 Y89.547 E.1872
G1 X70.009 Y81.522 E.14996
; WIPE_START
G1 F4800
G1 X70.009 Y83.522 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X67.956 Y80.904 Z1.08 F18000
G1 Z.68
G1 E.3 F1800
; LINE_WIDTH: 0.524192
G1 F4534
M204 S6000
G1 X62.045 Y80.901 E.13966
; LINE_WIDTH: 0.507484
G1 X61.695 Y80.884 E.00799
; LINE_WIDTH: 0.472487
G1 X61.345 Y80.866 E.00741
; LINE_WIDTH: 0.420612
G1 X60.385 Y80.848 E.01797
G1 X60.385 Y89.153 E.15543
G1 X60.996 Y89.153 E.01143
; LINE_WIDTH: 0.437647
G1 X61.345 Y89.135 E.00683
; LINE_WIDTH: 0.472957
G1 X61.695 Y89.118 E.00742
; LINE_WIDTH: 0.524935
G1 X62.044 Y89.1 E.00828
G1 X67.956 Y89.1 E.13985
; LINE_WIDTH: 0.508267
G1 X68.305 Y89.118 E.00801
; LINE_WIDTH: 0.472957
G1 X68.655 Y89.135 E.00742
; LINE_WIDTH: 0.420618
G1 X69.615 Y89.153 E.01797
G1 X69.615 Y80.853 E.15534
G1 X69.006 Y80.853 E.0114
; LINE_WIDTH: 0.437227
G1 X68.676 Y80.869 E.00644
; LINE_WIDTH: 0.471697
G1 X68.346 Y80.885 E.00698
; LINE_WIDTH: 0.506167
G1 X68.016 Y80.901 E.00752
; WIPE_START
G1 F4800
G1 X68.346 Y80.885 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X61.087 Y82.044 Z1.08 F18000
G1 Z.68
G1 E.3 F1800
; LINE_WIDTH: 0.381685
G1 F4534
M204 S6000
G1 X61.132 Y81.802 E.00416
; LINE_WIDTH: 0.435928
G1 X61.176 Y81.559 E.00479
G1 X61.608 Y81.252 E.01031
G1 X60.789 Y81.252 E.01593
; LINE_WIDTH: 0.41981
G1 X60.77 Y81.648 E.00741
; LINE_WIDTH: 0.363821
G1 X60.751 Y82.044 E.00636
G1 X60.751 Y87.956 E.09472
; LINE_WIDTH: 0.381752
G1 X60.77 Y88.249 E.00496
; LINE_WIDTH: 0.436358
G1 X60.789 Y88.749 E.00974
G1 X61.701 Y88.749 E.01774
G1 X61.176 Y88.442 E.01184
; LINE_WIDTH: 0.420012
G1 X61.132 Y88.199 E.00462
; LINE_WIDTH: 0.363397
G1 X61.087 Y87.956 E.00395
G1 X61.087 Y82.104 E.09364
; WIPE_START
G1 F4800
G1 X61.087 Y84.104 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X61.453 Y87.956 Z1.08 F18000
G1 Z.68
G1 E.3 F1800
; LINE_WIDTH: 0.419992
G1 F4534
M204 S6000
G1 X61.453 Y82.044 E.11045
G1 X61.528 Y81.756 E.00557
; LINE_WIDTH: 0.438619
G1 X61.663 Y81.64 E.00349
; LINE_WIDTH: 0.475872
G1 X61.798 Y81.523 E.0038
; LINE_WIDTH: 0.523949
G1 X61.933 Y81.407 E.00421
G1 X62.044 Y81.401 E.00264
G1 X67.956 Y81.401 E.13958
; LINE_WIDTH: 0.506167
G1 X68.128 Y81.52 E.00477
; LINE_WIDTH: 0.471697
G1 X68.3 Y81.639 E.00442
; LINE_WIDTH: 0.420529
G1 X68.473 Y81.758 E.00392
G1 X68.547 Y82.044 E.00554
G1 X68.547 Y87.956 E.1106
G1 X68.472 Y88.244 E.00558
; LINE_WIDTH: 0.438777
G1 X68.337 Y88.361 E.00349
; LINE_WIDTH: 0.476347
G1 X68.202 Y88.477 E.0038
; LINE_WIDTH: 0.525639
G1 X68.068 Y88.594 E.00422
G1 X67.956 Y88.6 E.00266
G1 X62.044 Y88.6 E.14005
; LINE_WIDTH: 0.508267
G1 X61.872 Y88.481 E.00478
; LINE_WIDTH: 0.472957
G1 X61.7 Y88.363 E.00443
; LINE_WIDTH: 0.428236
G1 X61.528 Y88.244 E.00398
G1 X61.468 Y88.014 E.00455
M204 S10000
G1 X61.847 Y87.956 F18000
; LINE_WIDTH: 0.419992
G1 F4534
M204 S6000
G1 X61.847 Y82.044 E.11045
G1 X61.872 Y81.948 E.00186
G1 X62.044 Y81.847 E.00373
G1 X67.956 Y81.847 E.11045
G1 X68.128 Y81.949 E.00374
G1 X68.153 Y82.044 E.00185
G1 X68.153 Y87.956 E.11045
G1 X68.128 Y88.052 E.00186
G1 X67.956 Y88.153 E.00373
G1 X62.044 Y88.153 E.11045
G1 X61.872 Y88.052 E.00373
G1 X61.862 Y88.014 E.00074
; CHANGE_LAYER
; Z_HEIGHT: 0.8
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F4800
G1 X61.872 Y88.052 E-.00563
G1 X62.044 Y88.153 E-.02841
G1 X63.806 Y88.153 E-.25096
; WIPE_END
G1 E-.015 F1800
; layer num/total_layer_count: 6/74
; update layer progress
M73 L6
M991 S0 P5 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z1.08 I.604 J-1.056 P1  F18000
G1 X63.09 Y87.743 Z1.08
G1 Z.8
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F2702
M204 S6000
G1 X62.257 Y87.743 E.01676
G1 X62.257 Y82.257 E.11033
G1 X67.743 Y82.257 E.11033
G1 X67.743 Y87.743 E.11033
G1 X63.15 Y87.743 E.09236
M204 S10000
G1 X63.09 Y87.319 F18000
G1 F2702
M204 S6000
G1 X62.681 Y87.319 E.00823
G1 X62.681 Y82.681 E.09327
G1 X67.319 Y82.681 E.09327
G1 X67.319 Y87.319 E.09327
G1 X63.15 Y87.319 E.08383
M204 S250
G1 X63.09 Y86.91 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1800
M204 S5000
G1 X63.09 Y83.09 E.07138
G1 X66.91 Y83.09 E.07138
G1 X66.91 Y86.91 E.07138
G1 X63.15 Y86.91 E.07026
; WIPE_START
M106 S229.5
M204 S6000
G1 X63.119 Y84.91 E-.285
; WIPE_END
G1 E-.015
M204 S10000
G1 X59.421 Y89.957 Z1.2 F18000
G1 Z.8
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F2702
M204 S6000
G1 X59.421 Y80.043 E.19933
G1 X70.579 Y80.043 E.22437
G1 X70.579 Y89.957 E.19933
G1 X59.481 Y89.957 E.22316
M204 S10000
G1 X58.996 Y90.381 F18000
G1 F2702
M204 S6000
G1 X58.996 Y79.619 E.21639
G1 X71.003 Y79.619 E.24143
G1 X71.003 Y90.381 E.21639
G1 X59.056 Y90.381 E.24022
M204 S250
G1 X58.707 Y90.79 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F2139.648
M204 S5000
G1 X58.587 Y90.79 E.00224
M106 S73.95
M106 S229.5
G1 F1440
G1 X58.587 Y79.21 E.21638
M106 S73.95
M106 S229.5
G1 F1772.564
G1 X58.707 Y79.21 E.00224
M106 S73.95
M106 S229.5
G1 F1800
G1 X71.293 Y79.21 E.23518
G1 F2167.941
G1 X71.412 Y79.21 E.00223
M106 S73.95
M106 S229.5
G1 F1560
G1 X71.413 Y90.79 E.21638
M106 S73.95
M106 S229.5
G1 F1904.32
G1 X71.293 Y90.79 E.00223
M106 S73.95
G1 F1800
G1 X58.767 Y90.79 E.23405
; WIPE_START
M204 S6000
G1 X58.587 Y90.79 E-.02564
G1 X58.587 Y88.97 E-.25936
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
M73 P41 R11
G1 X0 Y85 ; move to safe pos
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




G1 X60.26 Y80.674
G1 Z.8
G1 E.3 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.444222
G1 F2702
M204 S6000
G1 X60.26 Y80.465 E.00415
G1 X59.842 Y80.465 E.0083
G1 X59.842 Y89.535 E.1799
G1 X60.26 Y89.535 E.0083
G1 X60.26 Y80.734 E.17456
M204 S10000
G1 X61.167 Y80.406 F18000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F2702
M204 S6000
G1 X60.682 Y80.406 E.00976
G1 X60.682 Y81.618 E.02436
G1 X61.02 Y81.814 E.00787
G1 X61.703 Y82.269 E.0165
G1 X61.894 Y82.469 E.00556
G1 X61.894 Y85.341 E.05776
G1 X61.014 Y85.91 E.02107
G1 X60.682 Y86.259 E.00968
G1 X60.682 Y88.901 E.05312
G1 X61.02 Y89.097 E.00787
G1 X61.743 Y89.594 E.01763
G1 X66.361 Y89.594 E.09287
G1 X66.406 Y89.097 E.01003
G1 X66.126 Y88.642 E.01075
G1 X65.218 Y88.106 E.02119
G1 X67.241 Y88.106 E.04068
G1 X67.236 Y88.186 E.00161
G1 X67.516 Y88.642 E.01075
G1 X68.304 Y89.097 E.0183
G1 X69.026 Y89.594 E.01763
G1 X69.318 Y89.594 E.00588
G1 X69.318 Y88.189 E.02825
; WIPE_START
G1 F6000
G1 X69.318 Y89.594 E-.20018
G1 X69.026 Y89.594 E-.04164
G1 X68.776 Y89.422 E-.04318
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X69.739 Y89.326 Z1.2 F18000
G1 Z.8
G1 E.3 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.444032
G1 F2702
M204 S6000
G1 X69.739 Y89.535 E.00415
G1 X70.158 Y89.535 E.00829
G1 X70.158 Y80.465 E.17982
G1 X69.74 Y80.465 E.00829
G1 X69.739 Y89.266 E.17448
; WIPE_START
G1 F4800
G1 X69.739 Y87.266 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X68.106 Y84.414 Z1.2 F18000
G1 Z.8
G1 E.3 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F2702
M204 S6000
G1 X68.106 Y86.111 E.03412
G1 X68.297 Y85.91 E.00556
G1 X68.98 Y85.455 E.0165
G1 X69.318 Y85.26 E.00787
G1 X69.318 Y82.618 E.05312
G1 X68.986 Y82.269 E.00968
G1 X68.304 Y81.814 E.0165
G1 X67.516 Y81.358 E.0183
G1 X67.236 Y80.903 E.01075
G1 X67.28 Y80.406 E.01003
G1 X64.616 Y80.406 E.05358
G1 X65.338 Y80.903 E.01763
G1 X66.126 Y81.358 E.0183
G1 X66.406 Y81.814 E.01075
G1 X66.401 Y81.894 E.00161
G1 X64.704 Y81.894 E.03412
; CHANGE_LAYER
; Z_HEIGHT: 0.92
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F6000
G1 X66.401 Y81.894 E-.24182
G1 X66.406 Y81.814 E-.01142
G1 X66.289 Y81.624 E-.03176
; WIPE_END
G1 E-.015 F1800
; layer num/total_layer_count: 7/74
; update layer progress
M73 L7
M991 S0 P6 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z1.2 I-1.078 J-.564 P1  F18000
G1 X63.09 Y87.743 Z1.2
G1 Z.92
G1 E.3 F1800
; FEATURE: Inner wall
G1 F2817
M204 S6000
G1 X62.257 Y87.743 E.01676
G1 X62.257 Y82.257 E.11033
G1 X67.743 Y82.257 E.11033
G1 X67.743 Y87.743 E.11033
G1 X63.15 Y87.743 E.09236
M204 S10000
G1 X63.09 Y87.319 F18000
G1 F2817
M204 S6000
G1 X62.681 Y87.319 E.00823
G1 X62.681 Y82.681 E.09327
G1 X67.319 Y82.681 E.09327
G1 X67.319 Y87.319 E.09327
G1 X63.15 Y87.319 E.08383
M204 S250
G1 X63.09 Y86.91 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1800
M204 S5000
G1 X63.09 Y83.09 E.07138
G1 X66.91 Y83.09 E.07138
G1 X66.91 Y86.91 E.07138
G1 X63.15 Y86.91 E.07026
; WIPE_START
M106 S229.5
M204 S6000
G1 X63.119 Y84.91 E-.285
; WIPE_END
G1 E-.015
M204 S10000
G1 X59.277 Y89.957 Z1.32 F18000
G1 Z.92
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F2817
M204 S6000
G1 X59.277 Y80.043 E.19933
G1 X70.723 Y80.043 E.23015
G1 X70.723 Y89.957 E.19933
G1 X59.337 Y89.957 E.22895
M204 S10000
G1 X58.853 Y90.381 F18000
G1 F2817
M204 S6000
G1 X58.853 Y79.619 E.21639
G1 X71.147 Y79.619 E.24722
G1 X71.147 Y90.381 E.21639
G1 X58.913 Y90.381 E.24601
M204 S250
G1 X58.546 Y90.79 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F2314.438
M204 S5000
G1 X58.443 Y90.79 E.00192
M106 S73.95
M106 S229.5
G1 F1680
G1 X58.443 Y79.21 E.21638
M106 S73.95
M106 S229.5
G1 F1984.543
G1 X58.546 Y79.21 E.00192
M106 S73.95
M106 S229.5
G1 F1800
G1 X71.453 Y79.21 E.24118
G1 F2115.966
G1 X71.557 Y79.21 E.00193
M106 S73.95
M106 S229.5
G1 F1680
G1 X71.556 Y90.79 E.21638
M106 S73.95
M106 S229.5
G1 F1984.944
G1 X71.454 Y90.79 E.00192
M106 S73.95
G1 F1800
G1 X58.606 Y90.79 E.24006
; WIPE_START
M204 S6000
G1 X58.443 Y90.79 E-.0232
G1 X58.443 Y88.953 E-.2618
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
G1 X0 Y85 ; move to safe pos
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




G1 X63.717 Y88.106
G1 Z.92
G1 E.3 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F2817
M204 S6000
G1 X65.414 Y88.106 E.03412
G1 X65.91 Y88.325 E.0109
G1 X66.366 Y88.468 E.00959
G1 X66.821 Y88.431 E.00918
G1 X66.955 Y88.106 E.00706
G1 X68.106 Y88.106 E.02316
G1 X68.106 Y86.116 E.04003
G1 X68.186 Y86.031 E.00235
G1 X68.642 Y85.718 E.01111
G1 X69.577 Y85.309 E.02054
G1 X69.577 Y82.917 E.04808
G1 X69.097 Y82.389 E.01436
M73 P42 R11
G1 X68.642 Y82.076 E.01111
G1 X67.731 Y81.675 E.02001
G1 X67.276 Y81.532 E.00959
G1 X66.821 Y81.569 E.00918
G1 X66.687 Y81.894 E.00706
G1 X64.99 Y81.894 E.03412
; WIPE_START
G1 F6000
G1 X66.687 Y81.894 E-.24182
G1 X66.802 Y81.613 E-.04318
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X68.823 Y80.406 Z1.32 F18000
G1 Z.92
G1 E.3 F1800
G1 F2817
M204 S6000
G1 X67.126 Y80.406 E.03412
G1 X66.821 Y81.148 E.01613
G1 X66.366 Y81.185 E.00918
G1 X65.91 Y81.042 E.00959
G1 X65 Y80.641 E.02001
G1 X64.659 Y80.406 E.00831
G1 X60.423 Y80.406 E.08519
G1 X60.423 Y81.667 E.02535
G1 X61.358 Y82.076 E.02054
G1 X61.814 Y82.389 E.01111
G1 X61.894 Y82.474 E.00235
G1 X61.894 Y85.482 E.06048
G1 X61.358 Y85.718 E.01176
G1 X60.903 Y86.031 E.01111
G1 X60.423 Y86.559 E.01437
G1 X60.423 Y88.95 E.04807
G1 X61.358 Y89.36 E.02054
G1 X61.699 Y89.594 E.00831
G1 X66.515 Y89.594 E.09684
G1 X66.821 Y88.852 E.01613
G1 X67.276 Y88.815 E.00918
G1 X67.731 Y88.958 E.00959
G1 X68.642 Y89.36 E.02001
G1 X68.982 Y89.594 E.00831
G1 X69.577 Y89.594 E.01196
G1 X69.577 Y88.492 E.02216
; WIPE_START
G1 F6000
G1 X69.577 Y89.594 E-.15705
G1 X68.982 Y89.594 E-.08478
G1 X68.733 Y89.422 E-.04318
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X69.794 Y81.864 Z1.32 F18000
G1 X69.97 Y80.616 Z1.32
G1 Z.92
G1 E.3 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.386562
G1 F2817
M204 S6000
G1 X69.97 Y89.564 E.15301
G1 X70.33 Y89.564 E.00617
G1 X70.331 Y80.436 E.1561
G1 X69.97 Y80.436 E.00617
G1 X69.97 Y80.556 E.00206
; WIPE_START
G1 F4800
G1 X69.97 Y80.436 E-.01716
G1 X70.331 Y80.436 E-.05141
G1 X70.331 Y81.955 E-.21643
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X62.762 Y80.971 Z1.32 F18000
G1 X60.03 Y80.616 Z1.32
G1 Z.92
G1 E.3 F1800
; LINE_WIDTH: 0.386512
G1 F2817
M204 S6000
G1 X60.03 Y80.436 E.00308
G1 X59.669 Y80.436 E.00617
G1 X59.669 Y89.564 E.15608
G1 X60.03 Y89.564 E.00617
G1 X60.03 Y80.676 E.15197
; CHANGE_LAYER
; Z_HEIGHT: 1.04
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F4800
G1 X60.03 Y82.676 E-.285
; WIPE_END
G1 E-.015 F1800
; layer num/total_layer_count: 8/74
; update layer progress
M73 L8
M991 S0 P7 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z1.32 I-1.042 J.629 P1  F18000
G1 X63.09 Y87.743 Z1.32
G1 Z1.04
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F2755
M204 S6000
G1 X62.257 Y87.743 E.01676
G1 X62.257 Y82.257 E.11033
G1 X67.743 Y82.257 E.11033
G1 X67.743 Y87.743 E.11033
G1 X63.15 Y87.743 E.09236
M204 S10000
G1 X63.09 Y87.319 F18000
G1 F2755
M204 S6000
G1 X62.681 Y87.319 E.00823
G1 X62.681 Y82.681 E.09327
G1 X67.319 Y82.681 E.09327
G1 X67.319 Y87.319 E.09327
G1 X63.15 Y87.319 E.08383
M204 S250
G1 X63.09 Y86.91 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1800
M204 S5000
G1 X63.09 Y83.09 E.07138
G1 X66.91 Y83.09 E.07138
G1 X66.91 Y86.91 E.07138
G1 X63.15 Y86.91 E.07026
; WIPE_START
M204 S6000
G1 X63.119 Y84.91 E-.285
; WIPE_END
G1 E-.015
M106 S229.5
M204 S10000
G1 X59.146 Y89.957 Z1.44 F18000
G1 Z1.04
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F2755
M204 S6000
G1 X59.146 Y80.043 E.19933
G1 X70.854 Y80.043 E.2354
G1 X70.854 Y89.957 E.19933
G1 X59.206 Y89.957 E.2342
M204 S10000
G1 X58.722 Y90.381 F18000
G1 F2755
M204 S6000
G1 X58.722 Y79.619 E.21639
G1 X71.278 Y79.619 E.25246
G1 X71.278 Y90.381 E.21639
G1 X58.782 Y90.381 E.25126
M204 S250
G1 X58.402 Y90.79 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F2570.632
M204 S5000
G1 X58.313 Y90.79 E.00167
M106 S73.95
M106 S229.5
G1 F1980
G1 X58.313 Y79.21 E.21638
M106 S73.95
M106 S229.5
G1 F2265.693
G1 X58.402 Y79.21 E.00167
M106 S73.95
M106 S229.5
G1 F1800
G1 X71.598 Y79.21 E.24656
G1 F2072.593
G1 X71.687 Y79.21 E.00167
M106 S73.95
M106 S229.5
G1 F1980
G1 X71.687 Y90.79 E.21638
M106 S73.95
M106 S229.5
G1 F2265.792
G1 X71.597 Y90.79 E.00167
M106 S73.95
G1 F1800
G1 X58.462 Y90.79 E.24544
; WIPE_START
M204 S6000
G1 X58.313 Y90.79 E-.02131
G1 X58.313 Y88.94 E-.26369
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
G1 X0 Y85 ; move to safe pos
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




G1 X64.01 Y88.106
G1 Z1.04
G1 E.3 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F2755
M204 S6000
G1 X65.707 Y88.106 E.03412
G1 X65.91 Y88.174 E.00432
G1 X66.366 Y88.188 E.00916
G1 X66.491 Y88.106 E.003
G1 X68.106 Y88.106 E.03249
G1 X68.106 Y86.119 E.03996
G1 X68.186 Y86.044 E.0022
G1 X68.642 Y85.769 E.01069
G1 X69.552 Y85.468 E.01928
G1 X69.79 Y85.461 E.00479
G1 X69.79 Y83.174 E.04598
G1 X69.552 Y82.827 E.00846
G1 X69.097 Y82.403 E.01252
G1 X68.642 Y82.127 E.01069
G1 X68.106 Y81.95 E.01134
G1 X68.106 Y81.894 E.00114
G1 X67.935 Y81.894 E.00345
G1 X67.731 Y81.826 E.00431
G1 X67.276 Y81.813 E.00916
G1 X67.151 Y81.894 E.003
G1 X65.454 Y81.894 E.03412
; WIPE_START
G1 F6000
G1 X67.151 Y81.894 E-.24182
G1 X67.276 Y81.813 E-.02124
G1 X67.43 Y81.817 E-.02194
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X68.639 Y80.406 Z1.44 F18000
G1 Z1.04
G1 E.3 F1800
G1 F2755
M204 S6000
G1 X66.942 Y80.406 E.03412
G1 X66.821 Y80.609 E.00475
G1 X66.366 Y80.904 E.01091
G1 X65.91 Y80.891 E.00916
G1 X65 Y80.589 E.01928
G1 X64.697 Y80.406 E.00712
M73 P43 R11
G1 X60.21 Y80.406 E.09022
G1 X60.21 Y81.819 E.02841
G1 X60.448 Y81.826 E.00479
G1 X61.358 Y82.127 E.01928
G1 X61.814 Y82.403 E.01069
G1 X61.894 Y82.477 E.0022
G1 X61.894 Y85.592 E.06263
G1 X61.358 Y85.769 E.01133
G1 X60.903 Y86.044 E.01069
G1 X60.448 Y86.469 E.01252
G1 X60.21 Y86.816 E.00846
G1 X60.21 Y89.102 E.04598
G1 X60.448 Y89.109 E.00479
G1 X61.358 Y89.411 E.01928
G1 X61.661 Y89.594 E.00712
G1 X66.7 Y89.594 E.1013
G1 X66.821 Y89.391 E.00475
G1 X67.276 Y89.096 E.01091
G1 X67.731 Y89.109 E.00916
G1 X68.642 Y89.411 E.01928
G1 X68.945 Y89.594 E.00712
G1 X69.79 Y89.594 E.017
G1 X69.79 Y88.742 E.01712
; WIPE_START
G1 F6000
G1 X69.79 Y89.594 E-.12135
G1 X68.945 Y89.594 E-.12047
G1 X68.685 Y89.437 E-.04318
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X69.94 Y81.908 Z1.44 F18000
G1 X70.162 Y80.575 Z1.44
G1 Z1.04
G1 E.3 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.345437
G1 F2755
M204 S6000
G1 X70.162 Y89.585 E.13651
G1 X70.482 Y89.585 E.00484
G1 X70.482 Y80.415 E.13893
G1 X70.162 Y80.415 E.00484
G1 X70.162 Y80.515 E.00151
; WIPE_START
G1 F4800
G1 X70.162 Y80.415 E-.01422
G1 X70.482 Y80.415 E-.04555
G1 X70.482 Y81.996 E-.22523
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X62.916 Y80.986 Z1.44 F18000
G1 X59.838 Y80.575 Z1.44
G1 Z1.04
G1 E.3 F1800
; LINE_WIDTH: 0.345542
G1 F2755
M204 S6000
G1 X59.838 Y80.415 E.00242
G1 X59.518 Y80.415 E.00485
G1 X59.518 Y89.585 E.13897
G1 X59.838 Y89.585 E.00485
G1 X59.838 Y80.635 E.13564
; CHANGE_LAYER
; Z_HEIGHT: 1.16
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F4800
G1 X59.838 Y82.635 E-.285
; WIPE_END
G1 E-.015 F1800
; layer num/total_layer_count: 9/74
; update layer progress
M73 L9
M991 S0 P8 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z1.44 I-1.027 J.654 P1  F18000
G1 X63.09 Y87.743 Z1.44
G1 Z1.16
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F3600
M204 S6000
G1 X62.257 Y87.743 E.01676
G1 X62.257 Y82.257 E.11033
G1 X67.743 Y82.257 E.11033
G1 X67.743 Y87.743 E.11033
G1 X63.15 Y87.743 E.09236
M204 S10000
G1 X63.09 Y87.319 F18000
G1 F3600
M204 S6000
G1 X62.681 Y87.319 E.00823
G1 X62.681 Y82.681 E.09327
G1 X67.319 Y82.681 E.09327
G1 X67.319 Y87.319 E.09327
G1 X63.15 Y87.319 E.08383
M204 S250
G1 X63.09 Y86.91 F18000
M106 S229.5
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1800
M204 S5000
G1 X63.09 Y83.09 E.07138
G1 X66.91 Y83.09 E.07138
G1 X66.91 Y86.91 E.07138
G1 X63.15 Y86.91 E.07026
; WIPE_START
M204 S6000
G1 X63.119 Y84.91 E-.285
; WIPE_END
G1 E-.015
M204 S10000
G1 X59.027 Y89.957 Z1.56 F18000
G1 Z1.16
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F3600
M204 S6000
G1 X59.027 Y80.043 E.19933
G1 X70.973 Y80.043 E.24022
G1 X70.973 Y89.957 E.19933
G1 X59.087 Y89.957 E.239
M204 S10000
G1 X58.603 Y90.381 F18000
G1 F3600
M204 S6000
G1 X58.603 Y79.619 E.21639
G1 X71.398 Y79.619 E.25728
G1 X71.397 Y90.381 E.21639
G1 X58.663 Y90.381 E.25607
M204 S250
G1 X58.272 Y90.79 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F2896.199
M204 S5000
G1 X58.193 Y90.79 E.00147
M106 S73.95
M106 S229.5
G1 F2340
G1 X58.193 Y79.21 E.21638
M106 S73.95
M106 S229.5
G1 F2610.693
G1 X58.272 Y79.21 E.00147
M106 S73.95
M106 S229.5
G1 F1800
G1 X71.728 Y79.21 E.25144
G1 F2039.263
G1 X71.807 Y79.21 E.00147
M106 S73.95
M106 S229.5
G1 F2340
G1 X71.807 Y90.79 E.21638
M106 S73.95
M106 S229.5
G1 F2610.658
G1 X71.728 Y90.79 E.00147
M106 S73.95
G1 F1800
G1 X58.332 Y90.79 E.25032
; WIPE_START
M204 S6000
G1 X58.193 Y90.79 E-.01974
G1 X58.193 Y88.929 E-.26526
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
G1 X0 Y85 ; move to safe pos
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




G1 X70.564 Y81.682
G1 Z1.16
G1 E.3 F1800
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.419992
G1 F3840
M204 S6000
G1 X70.564 Y80.453 E.02297
G1 X59.436 Y80.453 E.20793
G1 X59.436 Y89.547 E.16993
G1 X70.564 Y89.547 E.20793
G1 X70.564 Y81.742 E.14585
; WIPE_START
G1 X70.564 Y83.742 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X70.17 Y89.153 Z1.56 F18000
G1 Z1.16
G1 E.3 F1800
G1 F3840
M204 S6000
G1 X70.17 Y80.847 E.1552
G1 X68.645 Y80.847 E.02849
; LINE_WIDTH: 0.437647
G1 X68.415 Y80.865 E.0045
; LINE_WIDTH: 0.472957
G1 X68.185 Y80.882 E.00489
; LINE_WIDTH: 0.525259
G1 X67.956 Y80.9 E.00546
G1 X62.044 Y80.9 E.13994
; LINE_WIDTH: 0.508267
G1 X61.815 Y80.882 E.00527
; LINE_WIDTH: 0.472957
G1 X61.585 Y80.865 E.00489
; LINE_WIDTH: 0.420344
G1 X61.355 Y80.847 E.00431
G1 X59.83 Y80.847 E.02851
G1 X59.83 Y89.153 E.15534
G1 X61.355 Y89.153 E.02851
; LINE_WIDTH: 0.437647
G1 X61.585 Y89.135 E.0045
; LINE_WIDTH: 0.472957
G1 X61.815 Y89.118 E.00489
; LINE_WIDTH: 0.525259
G1 X62.044 Y89.1 E.00546
G1 X67.956 Y89.1 E.13994
; LINE_WIDTH: 0.508267
G1 X68.185 Y89.118 E.00527
; LINE_WIDTH: 0.472957
G1 X68.415 Y89.135 E.00489
; LINE_WIDTH: 0.422394
G1 X68.645 Y89.153 E.00433
G1 X70.11 Y89.153 E.02753
; WIPE_START
G1 X68.645 Y89.153 E-.24623
G1 X68.415 Y89.135 E-.03877
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X67.956 Y81.847 Z1.56 F18000
G1 Z1.16
G1 E.3 F1800
; LINE_WIDTH: 0.419992
G1 F3840
M204 S6000
G1 X68.088 Y81.898 E.00265
G1 X68.153 Y82.044 E.00299
G1 X68.153 Y87.956 E.11045
G1 X68.088 Y88.102 E.00299
G1 X67.956 Y88.153 E.00265
G1 X62.044 Y88.153 E.11045
G1 X61.912 Y88.102 E.00265
G1 X61.847 Y87.956 E.00299
G1 X61.847 Y82.044 E.11045
G1 X61.912 Y81.898 E.00299
G1 X62.044 Y81.847 E.00265
G1 X67.896 Y81.847 E.10933
M204 S10000
G1 X68.528 Y81.894 F18000
G1 F3840
M204 S6000
G1 X68.547 Y82.044 E.00283
G1 X68.547 Y87.956 E.11045
G1 X68.528 Y88.106 E.00283
G1 X68.353 Y88.394 E.0063
; LINE_WIDTH: 0.438777
G1 X68.258 Y88.46 E.00227
; LINE_WIDTH: 0.476347
G1 X68.163 Y88.527 E.00248
; LINE_WIDTH: 0.525757
M73 P44 R11
G1 X68.068 Y88.594 E.00275
G1 X67.956 Y88.6 E.00266
G1 X62.044 Y88.6 E.14008
; LINE_WIDTH: 0.508267
G1 X61.912 Y88.531 E.00341
; LINE_WIDTH: 0.472957
G1 X61.78 Y88.463 E.00316
; LINE_WIDTH: 0.420366
G1 X61.647 Y88.394 E.00279
G1 X61.462 Y88.058 E.00718
G1 X61.453 Y87.956 E.00192
G1 X61.453 Y82.044 E.11056
G1 X61.472 Y81.894 E.00284
G1 X61.647 Y81.606 E.0063
; LINE_WIDTH: 0.438777
G1 X61.742 Y81.54 E.00227
; LINE_WIDTH: 0.476347
G1 X61.837 Y81.473 E.00248
; LINE_WIDTH: 0.525757
G1 X61.932 Y81.406 E.00275
G1 X62.044 Y81.4 E.00266
G1 X67.956 Y81.4 E.14008
; LINE_WIDTH: 0.508267
G1 X68.088 Y81.469 E.00341
; LINE_WIDTH: 0.472957
G1 X68.22 Y81.537 E.00316
; LINE_WIDTH: 0.42617
G1 X68.353 Y81.606 E.00283
G1 X68.496 Y81.843 E.00526
; WIPE_START
G1 X68.353 Y81.606 E-.18527
G1 X68.22 Y81.537 E-.09973
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X60.593 Y81.255 Z1.56 F18000
G1 X60.225 Y81.241 Z1.56
G1 Z1.16
G1 E.3 F1800
; LINE_WIDTH: 0.419992
G1 F3840
M204 S6000
G1 X60.225 Y88.759 E.14047
G1 X61.571 Y88.759 E.02517
G1 X61.383 Y88.686 E.00378
G1 X61.091 Y88.206 E.01049
G1 X61.059 Y87.956 E.00472
G1 X61.059 Y82.044 E.11045
G1 X61.091 Y81.794 E.00472
G1 X61.383 Y81.314 E.01049
G1 X61.531 Y81.241 E.00309
G1 X60.285 Y81.241 E.0233
; WIPE_START
G1 X61.531 Y81.241 E-.17768
G1 X61.383 Y81.314 E-.02358
G1 X61.091 Y81.794 E-.08002
G1 X61.088 Y81.82 E-.00371
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X60.665 Y88.318 Z1.56 F18000
G1 Z1.16
G1 E.3 F1800
; Slow Down Start
; LINE_WIDTH: 0.468381
G1 F3000;_EXTRUDE_SET_SPEED
M204 S6000
G1 X60.642 Y87.956 E.00762
G1 X60.642 Y82.044 E.12401
G1 X60.661 Y81.742 E.00636
; Slow Down End
; WIPE_START
G1 X60.642 Y82.044 E-.04323
G1 X60.642 Y83.741 E-.24177
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X68.087 Y82.062 Z1.56 F18000
G1 X69.776 Y81.682 Z1.56
G1 Z1.16
G1 E.3 F1800
; LINE_WIDTH: 0.419992
G1 F3840
M204 S6000
G1 X69.776 Y81.241 E.00823
G1 X68.429 Y81.241 E.02517
G1 X68.617 Y81.314 E.00378
G1 X68.909 Y81.794 E.01049
G1 X68.941 Y82.044 E.00472
G1 X68.941 Y87.956 E.11045
G1 X68.909 Y88.206 E.00472
G1 X68.617 Y88.686 E.01049
G1 X68.469 Y88.759 E.00309
G1 X69.775 Y88.759 E.02442
G1 X69.776 Y81.742 E.13111
M204 S10000
G1 X69.335 Y81.682 F18000
; Slow Down Start
; LINE_WIDTH: 0.468494
G1 F3000;_EXTRUDE_SET_SPEED
M204 S6000
G1 X69.358 Y82.044 E.00762
G1 X69.358 Y87.956 E.12404
G1 X69.339 Y88.258 E.00637
; Slow Down End
; CHANGE_LAYER
; Z_HEIGHT: 1.28
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F3000
G1 X69.358 Y87.956 E-.04323
G1 X69.358 Y86.259 E-.24177
; WIPE_END
G1 E-.015 F1800
; layer num/total_layer_count: 10/74
; update layer progress
M73 L10
M991 S0 P9 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z1.56 I-.28 J-1.184 P1  F18000
G1 X63.09 Y87.743 Z1.56
G1 Z1.28
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F3279
M204 S6000
G1 X62.257 Y87.743 E.01676
G1 X62.257 Y82.257 E.11033
G1 X67.743 Y82.257 E.11033
G1 X67.743 Y87.743 E.11033
G1 X63.15 Y87.743 E.09236
M204 S10000
G1 X63.09 Y87.319 F18000
G1 F3279
M204 S6000
G1 X62.681 Y87.319 E.00823
G1 X62.681 Y82.681 E.09327
G1 X67.319 Y82.681 E.09327
G1 X67.319 Y87.319 E.09327
G1 X63.15 Y87.319 E.08383
M204 S250
G1 X63.09 Y86.91 F18000
M106 S229.5
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1800
M204 S5000
G1 X63.09 Y83.09 E.07138
G1 X66.91 Y83.09 E.07138
G1 X66.91 Y86.91 E.07138
G1 X63.15 Y86.91 E.07026
; WIPE_START
M204 S6000
G1 X63.119 Y84.91 E-.285
; WIPE_END
G1 E-.015
M204 S10000
G1 X58.917 Y89.957 Z1.68 F18000
G1 Z1.28
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F3279
M204 S6000
G1 X58.917 Y80.043 E.19933
G1 X71.083 Y80.043 E.24464
G1 X71.083 Y89.957 E.19933
G1 X58.977 Y89.957 E.24344
M204 S10000
G1 X58.492 Y90.381 F18000
G1 F3279
M204 S6000
G1 X58.492 Y79.619 E.21639
G1 X71.507 Y79.619 E.2617
G1 X71.508 Y90.381 E.21639
G1 X58.552 Y90.381 E.2605
M204 S250
G1 X58.152 Y90.79 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3221.147
M204 S5000
G1 X58.083 Y90.79 E.00129
G1 F2700
G1 X58.083 Y79.21 E.21638
M106 S73.95
M106 S229.5
G1 F2954.829
G1 X58.152 Y79.21 E.00129
G1 F1800
G1 X71.848 Y79.21 E.25591
G1 F2008.003
G1 X71.917 Y79.21 E.00129
G1 F2700
G1 X71.917 Y79.61 E.00747
M106 S73.95
M106 S229.5
G1 X71.917 Y90.79 E.20891
M106 S73.95
G1 F2955.356
G1 X71.848 Y90.79 E.0013
G1 F1800
G1 X58.212 Y90.79 E.25478
; WIPE_START
M204 S6000
G1 X58.083 Y90.79 E-.01841
G1 X58.083 Y88.919 E-.26659
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
G1 X0 Y85 ; move to safe pos
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




G1 X59.392 Y89.482
G1 Z1.28
G1 E.3 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.551412
G1 F3279
M204 S6000
G1 X59.392 Y80.578 E.22181
M204 S10000
G1 X59.866 Y80.594 F18000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F3279
M204 S6000
G1 X59.866 Y82.291 E.03412
G1 X59.952 Y82.219 E.00224
G1 X60.366 Y82.084 E.00876
G1 X61.079 Y82.144 E.01438
G1 X61.079 Y85.966 E.07684
M73 P44 R10
G1 X60.78 Y86.12 E.00676
G1 X60.366 Y86.448 E.01062
G1 X59.866 Y87.042 E.0156
G1 X59.866 Y89.574 E.05092
G1 X59.952 Y89.503 E.00224
G1 X60.366 Y89.367 E.00876
G1 X61.079 Y89.427 E.01438
G1 X61.079 Y87.73 E.03412
; WIPE_START
G1 F6000
G1 X61.079 Y89.427 E-.24182
G1 X60.777 Y89.402 E-.04318
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X68.204 Y87.644 Z1.68 F18000
G1 X68.921 Y87.474 Z1.68
G1 Z1.28
G1 E.3 F1800
G1 F3279
M204 S6000
G1 X68.921 Y85.778 E.03412
G1 X69.097 Y85.735 E.00363
G1 X69.552 Y85.717 E.00916
G1 X70.007 Y85.839 E.00948
G1 X70.133 Y85.942 E.00327
G1 X70.133 Y83.408 E.05095
G1 X69.552 Y82.731 E.01794
G1 X69.097 Y82.405 E.01126
G1 X68.921 Y82.327 E.00386
G1 X68.921 Y80.63 E.03412
; WIPE_START
G1 F6000
G1 X68.921 Y82.327 E-.24182
G1 X69.097 Y82.405 E-.02736
G1 X69.187 Y82.47 E-.01582
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X68.521 Y82.044 Z1.68 F18000
G1 Z1.28
G1 E.3 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.41281
G1 F3279
M204 S6000
G1 X68.512 Y80.453 E.0292
G1 X61.488 Y80.453 E.12886
G1 X61.488 Y89.547 E.16684
G1 X68.512 Y89.547 E.12886
G1 X68.521 Y82.104 E.13654
; WIPE_START
G1 F4800
G1 X68.518 Y84.104 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X61.935 Y81.509 Z1.68 F18000
G1 Z1.28
G1 E.3 F1800
; LINE_WIDTH: 0.525917
G1 F3279
M204 S6000
G1 X62.044 Y81.4 E.00366
G1 X67.956 Y81.4 E.14013
G1 X68.065 Y81.509 E.00366
G1 X68.065 Y80.9 E.01445
G1 X61.935 Y80.9 E.14531
G1 X61.935 Y81.449 E.01302
; WIPE_START
G1 F4800
G1 X61.935 Y80.9 E-.07829
G1 X63.386 Y80.9 E-.20671
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X61.856 Y87.956 Z1.68 F18000
G1 Z1.28
G1 E.3 F1800
; LINE_WIDTH: 0.411265
G1 F3279
M204 S6000
G1 X61.856 Y82.044 E.10801
G1 X62.044 Y81.847 E.00498
G1 X67.956 Y81.847 E.10801
G1 X68.144 Y82.044 E.00498
G1 X68.144 Y87.956 E.10801
G1 X67.956 Y88.153 E.00498
G1 X62.044 Y88.153 E.10801
G1 X61.897 Y87.999 E.00389
M204 S10000
G1 X62.044 Y88.6 F18000
; LINE_WIDTH: 0.525917
G1 F3279
M204 S6000
G1 X61.935 Y88.508 E.00338
G1 X61.935 Y89.1 E.01403
G1 X68.065 Y89.1 E.14531
G1 X68.065 Y88.508 E.01403
G1 X67.956 Y88.6 E.00338
G1 X62.104 Y88.6 E.13871
; WIPE_START
G1 F4800
G1 X64.104 Y88.6 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X70.608 Y89.481 Z1.68 F18000
G1 Z1.28
G1 E.3 F1800
; LINE_WIDTH: 0.551662
G1 F3279
M204 S6000
G1 X70.608 Y80.579 E.22191
; CHANGE_LAYER
; Z_HEIGHT: 1.4
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F4800
G1 X70.608 Y82.579 E-.285
; WIPE_END
G1 E-.015 F1800
; layer num/total_layer_count: 11/74
; update layer progress
M73 L11
M991 S0 P10 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z1.68 I-.689 J-1.003 P1  F18000
G1 X63.09 Y87.743 Z1.68
G1 Z1.4
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F3328
M204 S6000
G1 X62.257 Y87.743 E.01676
G1 X62.257 Y82.257 E.11033
G1 X67.743 Y82.257 E.11033
G1 X67.743 Y87.743 E.11033
G1 X63.15 Y87.743 E.09236
M204 S10000
G1 X63.09 Y87.319 F18000
G1 F3328
M204 S6000
G1 X62.681 Y87.319 E.00823
G1 X62.681 Y82.681 E.09327
G1 X67.319 Y82.681 E.09327
G1 X67.319 Y87.319 E.09327
M73 P45 R10
G1 X63.15 Y87.319 E.08383
M204 S250
G1 X63.09 Y86.91 F18000
M106 S229.5
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1800
M204 S5000
G1 X63.09 Y83.09 E.07138
G1 X66.91 Y83.09 E.07138
G1 X66.91 Y86.91 E.07138
G1 X63.15 Y86.91 E.07026
; WIPE_START
M204 S6000
G1 X63.119 Y84.91 E-.285
; WIPE_END
G1 E-.015
M204 S10000
G1 X58.814 Y89.957 Z1.8 F18000
G1 Z1.4
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F3328
M204 S6000
G1 X58.814 Y80.043 E.19933
G1 X71.186 Y80.043 E.24875
G1 X71.186 Y89.957 E.19933
G1 X58.874 Y89.957 E.24755
M204 S10000
G1 X58.39 Y90.381 F18000
G1 F3328
M204 S6000
G1 X58.39 Y79.619 E.21639
G1 X71.61 Y79.619 E.26581
G1 X71.61 Y90.381 E.21639
G1 X58.45 Y90.381 E.26461
M204 S250
G1 X58.042 Y90.79 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3240
M204 S5000
G1 X57.981 Y90.79 E.00114
G1 F2880
G1 X57.981 Y79.21 E.21638
M106 S73.95
M106 S229.5
G1 F2177.63
G1 X58.042 Y79.21 E.00114
G1 F1800
G1 X71.958 Y79.21 E.26002
G1 F2178.471
G1 X72.019 Y79.21 E.00115
G1 F2880
G1 X72.019 Y79.61 E.00747
M106 S73.95
M106 S229.5
G1 X72.019 Y90.79 E.20891
M106 S73.95
G1 F2178.082
G1 X71.958 Y90.79 E.00114
G1 F1800
G1 X58.102 Y90.79 E.2589
; WIPE_START
M204 S6000
G1 X57.981 Y90.79 E-.01727
G1 X57.981 Y88.911 E-.26773
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
G1 X0 Y85 ; move to safe pos
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




G1 X59.269 Y89.502
G1 Z1.4
G1 E.3 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.509812
G1 F3328
M204 S6000
G1 X59.269 Y80.558 E.20521
M204 S10000
G1 X59.723 Y80.871 F18000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F3328
M204 S6000
G1 X59.723 Y82.568 E.03412
G1 X59.952 Y82.37 E.00609
G1 X60.366 Y82.196 E.00904
G1 X61.079 Y82.193 E.01433
G1 X61.079 Y85.97 E.07595
G1 X60.78 Y86.101 E.00655
G1 X60.366 Y86.387 E.01012
G1 X59.723 Y87.075 E.01894
G1 X59.723 Y89.594 E.05065
G1 X60.094 Y89.594 E.00746
G1 X60.366 Y89.479 E.00594
G1 X61.079 Y89.476 E.01433
G1 X61.079 Y87.779 E.03412
; WIPE_START
G1 F6000
G1 X61.079 Y89.476 E-.24182
G1 X60.776 Y89.477 E-.04318
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X68.198 Y87.696 Z1.8 F18000
G1 X68.921 Y87.523 Z1.8
G1 Z1.4
G1 E.3 F1800
G1 F3328
M204 S6000
G1 X68.921 Y85.826 E.03412
G1 X69.097 Y85.797 E.00358
G1 X69.552 Y85.82 E.00916
G1 X70.007 Y85.987 E.00975
G1 X70.277 Y86.214 E.00709
G1 X70.277 Y83.437 E.05583
G1 X69.552 Y82.679 E.0211
G1 X69.097 Y82.396 E.01078
G1 X68.921 Y82.332 E.00376
G1 X68.921 Y80.635 E.03412
M204 S10000
G1 X68.512 Y81.15 F18000
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.412777
G1 F3328
M204 S6000
G1 X68.512 Y80.453 E.01279
G1 X61.488 Y80.453 E.12885
G1 X61.488 Y89.547 E.16682
G1 X68.512 Y89.547 E.12885
G1 X68.512 Y81.21 E.15293
; WIPE_START
G1 F3840
G1 X68.512 Y83.21 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X61.856 Y82.044 Z1.8 F18000
G1 Z1.4
G1 E.3 F1800
; LINE_WIDTH: 0.411286
G1 F3328
M204 S6000
G1 X62.044 Y81.847 E.00498
G1 X67.956 Y81.847 E.10801
G1 X68.144 Y82.044 E.00498
G1 X68.144 Y87.956 E.10801
G1 X67.956 Y88.153 E.00498
G1 X62.044 Y88.153 E.10801
G1 X61.856 Y87.956 E.00498
G1 X61.856 Y82.104 E.10692
; WIPE_START
G1 F3840
G1 X61.856 Y84.104 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X68.065 Y81.15 Z1.8 F18000
G1 Z1.4
G1 E.3 F1800
; LINE_WIDTH: 0.525917
G1 F3328
M204 S6000
G1 X68.065 Y80.9 E.00593
G1 X61.935 Y80.9 E.14531
G1 X61.935 Y81.509 E.01445
G1 X62.044 Y81.4 E.00366
G1 X67.956 Y81.4 E.14013
G1 X68.065 Y81.509 E.00366
G1 X68.065 Y81.21 E.0071
; WIPE_START
G1 F3840
G1 X68.065 Y81.509 E-.04265
G1 X67.956 Y81.4 E-.02202
G1 X66.409 Y81.4 E-.22033
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X62.344 Y87.859 Z1.8 F18000
G1 X61.935 Y88.508 Z1.8
G1 Z1.4
G1 E.3 F1800
; LINE_WIDTH: 0.525917
G1 F3328
M204 S6000
G1 X61.935 Y89.1 E.01403
G1 X68.065 Y89.1 E.14531
G1 X68.065 Y88.508 E.01403
G1 X67.956 Y88.6 E.00338
G1 X62.044 Y88.6 E.14013
G1 X61.981 Y88.547 E.00196
; WIPE_START
G1 F3840
G1 X62.044 Y88.6 E-.01178
G1 X63.962 Y88.6 E-.27322
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X70.731 Y89.502 Z1.8 F18000
G1 Z1.4
G1 E.3 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.509922
G1 F3328
M204 S6000
G1 X70.731 Y80.558 E.20526
; CHANGE_LAYER
; Z_HEIGHT: 1.52
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F4800
G1 X70.731 Y82.558 E-.285
; WIPE_END
G1 E-.015 F1800
; layer num/total_layer_count: 12/74
; update layer progress
M73 L12
M991 S0 P11 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z1.8 I-.683 J-1.007 P1  F18000
G1 X63.09 Y87.743 Z1.8
G1 Z1.52
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F3338
M204 S6000
G1 X62.257 Y87.743 E.01676
G1 X62.257 Y82.257 E.11033
G1 X67.743 Y82.257 E.11033
G1 X67.743 Y87.743 E.11033
G1 X63.15 Y87.743 E.09236
M204 S10000
G1 X63.09 Y87.319 F18000
G1 F3338
M204 S6000
G1 X62.681 Y87.319 E.00823
G1 X62.681 Y82.681 E.09327
G1 X67.319 Y82.681 E.09327
G1 X67.319 Y87.319 E.09327
G1 X63.15 Y87.319 E.08383
M204 S250
G1 X63.09 Y86.91 F18000
M106 S229.5
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1800
M204 S5000
G1 X63.09 Y83.09 E.07138
G1 X66.91 Y83.09 E.07138
G1 X66.91 Y86.91 E.07138
G1 X63.15 Y86.91 E.07026
; WIPE_START
M204 S6000
G1 X63.119 Y84.91 E-.285
; WIPE_END
G1 E-.015
M204 S10000
G1 X58.719 Y89.957 Z1.92 F18000
G1 Z1.52
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F3338
M204 S6000
G1 X58.719 Y80.043 E.19933
G1 X71.281 Y80.043 E.25258
G1 X71.281 Y89.957 E.19933
G1 X58.779 Y89.957 E.25137
M204 S10000
G1 X58.295 Y90.381 F18000
G1 F3338
M204 S6000
G1 X58.295 Y79.619 E.21639
G1 X71.705 Y79.619 E.26964
G1 X71.705 Y90.381 E.21639
G1 X58.355 Y90.381 E.26843
M204 S250
G1 X57.94 Y90.79 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3060
M204 S5000
G1 X57.886 Y90.79 E.00101
G1 X57.886 Y79.61 E.20891
M106 S73.95
M106 S229.5
G1 X57.886 Y79.21 E.00747
M106 S73.95
M106 S229.5
G1 F2133.114
G1 X57.94 Y79.21 E.00101
G1 F1800
G1 X72.06 Y79.21 E.26384
G1 F2131.962
G1 X72.114 Y79.21 E.00101
G1 F3060
G1 X72.114 Y79.61 E.00747
M106 S73.95
M106 S229.5
G1 X72.114 Y90.39 E.20143
M106 S73.95
M106 S229.5
G1 X72.114 Y90.79 E.00747
M106 S73.95
G1 F2131.579
G1 X72.06 Y90.79 E.00101
G1 F1800
G1 X58 Y90.79 E.26272
; WIPE_START
M204 S6000
G1 X57.886 Y90.79 E-.01628
G1 X57.886 Y88.904 E-.26872
; WIPE_END
M73 P46 R10
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
G1 X0 Y85 ; move to safe pos
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




G1 X59.156 Y89.52
G1 Z1.52
G1 E.3 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.474532
G1 F3338
M204 S6000
G1 X59.156 Y80.54 E.19101
M204 S10000
G1 X59.592 Y81.123 F18000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F3338
M204 S6000
G1 X59.592 Y82.82 E.03412
G1 X59.952 Y82.503 E.00964
G1 X60.366 Y82.295 E.00932
G1 X61.079 Y82.234 E.01438
G1 X61.079 Y85.968 E.07508
G1 X60.78 Y86.075 E.00638
G1 X60.366 Y86.323 E.00971
G1 X59.592 Y87.079 E.02175
G1 X59.592 Y89.594 E.05056
G1 X60.336 Y89.594 E.01495
G1 X60.366 Y89.578 E.00068
G1 X61.079 Y89.518 E.01438
G1 X61.079 Y87.821 E.03412
; WIPE_START
G1 F6000
G1 X61.079 Y89.518 E-.24182
G1 X60.777 Y89.543 E-.04318
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X68.193 Y87.74 Z1.92 F18000
G1 X68.921 Y87.564 Z1.92
G1 Z1.52
G1 E.3 F1800
G1 F3338
M204 S6000
G1 X68.921 Y85.867 E.03412
G1 X69.097 Y85.851 E.00354
G1 X69.552 Y85.912 E.00923
G1 X70.007 Y86.117 E.01004
G1 X70.408 Y86.462 E.01063
G1 X70.408 Y83.433 E.06091
G1 X70.007 Y83.009 E.01173
G1 X69.552 Y82.623 E.01199
G1 X69.097 Y82.38 E.01038
G1 X68.921 Y82.33 E.00367
G1 X68.921 Y80.633 E.03412
M204 S10000
G1 X68.512 Y81.15 F18000
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.412777
G1 F3338
M204 S6000
G1 X68.512 Y80.453 E.01279
G1 X61.488 Y80.453 E.12885
G1 X61.488 Y89.547 E.16682
G1 X68.512 Y89.547 E.12885
G1 X68.512 Y81.21 E.15293
; WIPE_START
G1 F3840
G1 X68.512 Y83.21 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X61.856 Y82.044 Z1.92 F18000
G1 Z1.52
G1 E.3 F1800
; LINE_WIDTH: 0.411286
G1 F3338
M204 S6000
G1 X62.044 Y81.847 E.00498
G1 X67.956 Y81.847 E.10801
G1 X68.144 Y82.044 E.00498
G1 X68.144 Y87.956 E.10801
G1 X67.956 Y88.153 E.00498
G1 X62.044 Y88.153 E.10801
G1 X61.856 Y87.956 E.00498
G1 X61.856 Y82.104 E.10692
; WIPE_START
G1 F3840
G1 X61.856 Y84.104 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X68.065 Y81.15 Z1.92 F18000
G1 Z1.52
G1 E.3 F1800
; LINE_WIDTH: 0.525917
G1 F3338
M204 S6000
G1 X68.065 Y80.9 E.00593
G1 X61.935 Y80.9 E.14531
G1 X61.935 Y81.509 E.01445
G1 X62.044 Y81.4 E.00366
G1 X67.956 Y81.4 E.14013
G1 X68.065 Y81.509 E.00366
G1 X68.065 Y81.21 E.0071
; WIPE_START
G1 F3840
G1 X68.065 Y81.509 E-.04265
G1 X67.956 Y81.4 E-.02202
G1 X66.409 Y81.4 E-.22033
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X62.344 Y87.859 Z1.92 F18000
G1 X61.935 Y88.508 Z1.92
G1 Z1.52
G1 E.3 F1800
; LINE_WIDTH: 0.525917
G1 F3338
M204 S6000
G1 X61.935 Y89.1 E.01403
G1 X68.065 Y89.1 E.14531
G1 X68.065 Y88.508 E.01403
G1 X67.956 Y88.6 E.00338
G1 X62.044 Y88.6 E.14013
G1 X61.981 Y88.547 E.00196
; WIPE_START
G1 F3840
G1 X62.044 Y88.6 E-.01178
G1 X63.962 Y88.6 E-.27322
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X70.844 Y89.52 Z1.92 F18000
G1 Z1.52
G1 E.3 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.474442
G1 F3338
M204 S6000
G1 X70.844 Y80.54 E.19097
; CHANGE_LAYER
; Z_HEIGHT: 1.64
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F4800
G1 X70.844 Y82.54 E-.285
; WIPE_END
G1 E-.015 F1800
; layer num/total_layer_count: 13/74
; update layer progress
M73 L13
M991 S0 P12 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z1.92 I-.785 J-.93 P1  F18000
G1 X61.949 Y90.051 Z1.92
G1 Z1.64
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F3600
M204 S6000
G1 X61.949 Y79.949 E.20313
G1 X68.051 Y79.949 E.1227
G1 X68.051 Y90.051 E.20313
G1 X62.009 Y90.051 E.1215
; WIPE_START
G1 X61.997 Y88.051 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X63.09 Y86.91 Z2.04 F18000
G1 Z1.64
G1 E.3 F1800
M106 S229.5
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
M204 S5000
G1 X63.09 Y83.09 E.07138
G1 X66.91 Y83.09 E.07138
G1 X66.91 Y86.91 E.07138
G1 X63.15 Y86.91 E.07026
; WIPE_START
M204 S6000
G1 X63.119 Y84.91 E-.285
; WIPE_END
G1 E-.015
M204 S10000
G1 X61.525 Y86.91 Z2.04 F18000
G1 Z1.64
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F3600
M204 S6000
G1 X61.525 Y89.957 E.06126
G1 X58.63 Y89.957 E.0582
G1 X58.63 Y80.044 E.19931
G1 X61.525 Y80.047 E.0582
G1 X61.525 Y86.85 E.1368
; WIPE_START
G1 X61.525 Y88.85 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X68.475 Y89.957 Z2.04 F18000
G1 Z1.64
G1 E.3 F1800
G1 F3600
M204 S6000
G1 X68.475 Y80.052 E.19916
G1 X71.37 Y80.054 E.0582
G1 X71.37 Y89.957 E.19911
G1 X68.535 Y89.957 E.057
; WIPE_START
G1 X68.523 Y87.957 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X61.093 Y89.702 Z2.04 F18000
G1 X58.206 Y90.381 Z2.04
G1 Z1.64
G1 E.3 F1800
G1 F3600
M204 S6000
G1 X58.206 Y79.62 E.21638
G1 X71.794 Y79.63 E.27323
G1 X71.794 Y90.381 E.21617
G1 X58.266 Y90.381 E.27202
M204 S250
G1 X57.845 Y90.79 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F2880
M204 S5000
G1 X57.797 Y90.79 E.0009
G1 F3240
G1 X57.797 Y79.21 E.21638
M106 S73.95
M106 S229.5
G1 F2094.509
G1 X57.845 Y79.21 E.0009
G1 F1800
G1 X72.155 Y79.221 E.2674
G1 F2095.777
G1 X72.203 Y79.221 E.0009
G1 F3240
G1 X72.203 Y79.621 E.00747
M106 S73.95
M106 S229.5
G1 X72.203 Y90.79 E.2087
M106 S73.95
G1 F2095.206
G1 X72.155 Y90.79 E.0009
G1 F1800
G1 X57.905 Y90.79 E.26628
; WIPE_START
M204 S6000
G1 X57.797 Y90.79 E-.01542
G1 X57.797 Y88.898 E-.26958
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
G1 X0 Y85 ; move to safe pos
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




G1 X59.051 Y89.535
G1 Z1.64
G1 E.3 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.444172
G1 F4800
M204 S6000
G1 X59.051 Y80.526 E.17867
; WIPE_START
G1 X59.051 Y82.526 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X61.162 Y80.558 Z2.04 F18000
G1 Z1.64
G1 E.3 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F6000
M204 S6000
G1 X61.162 Y82.255 E.03412
G1 X60.366 Y82.385 E.01621
G1 X59.952 Y82.623 E.0096
M73 P47 R10
G1 X59.473 Y83.061 E.01305
G1 X59.473 Y87.061 E.08044
G1 X60.366 Y86.257 E.02418
G1 X60.78 Y86.044 E.00937
G1 X61.162 Y85.937 E.00797
G1 X61.162 Y89.538 E.07242
G1 X60.822 Y89.594 E.00692
G1 X59.473 Y89.594 E.02714
G1 X59.473 Y89.246 E.00698
; WIPE_START
G1 X59.473 Y89.594 E-.0495
G1 X60.822 Y89.594 E-.19232
G1 X61.121 Y89.545 E-.04318
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X62.27 Y85.43 Z2.04 F18000
G1 Z1.64
G1 E.3 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.365752
G1 F4800
M204 S6000
G1 X62.772 Y85.387 E.00811
M204 S10000
G1 X62.268 Y84.572 F18000
G1 F4800
M204 S6000
G1 X62.603 Y84.629 E.00547
G1 X62.78 Y84.627 E.00286
; WIPE_START
G1 X62.603 Y84.629 E-.09772
G1 X62.268 Y84.572 E-.18728
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X67.169 Y84.618 Z2.04 F18000
G1 Z1.64
G1 E.3 F1800
G1 F4800
M204 S6000
G1 X67.67 Y84.575 E.00811
M204 S10000
G1 X67.16 Y85.374 F18000
G1 F4800
M204 S6000
G1 X67.415 Y85.373 E.00412
G1 X67.667 Y85.415 E.00411
; WIPE_START
G1 X67.415 Y85.373 E-.14234
G1 X67.16 Y85.374 E-.14266
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X67.819 Y86.425 Z2.04 F18000
G1 Z1.64
G1 E.3 F1800
; FEATURE: Top surface
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X67.127 Y85.733 E.0183
G1 X67.127 Y86.291
G1 X67.819 Y86.983 E.0183
G1 X67.819 Y87.541
G1 X67.127 Y86.848 E.0183
G1 X66.848 Y87.127
G1 X67.819 Y88.098 E.02567
G1 X67.819 Y88.656
G1 X66.29 Y87.127 E.0404
G1 X65.733 Y87.127
G1 X67.819 Y89.213 E.05513
G1 X67.819 Y89.771
G1 X65.175 Y87.127 E.06987
G1 X64.618 Y87.127
G1 X67.31 Y89.819 E.07115
G1 X66.753 Y89.819
G1 X64.06 Y87.127 E.07115
G1 X63.503 Y87.127
G1 X66.195 Y89.819 E.07115
G1 X65.638 Y89.819
G1 X62.945 Y87.127 E.07115
G1 X62.873 Y85.94
G1 X62.436 Y85.503 E.01154
G1 X62.181 Y85.805
G1 X62.873 Y86.497 E.0183
G1 X62.873 Y87.055
G1 X62.181 Y86.362 E.0183
G1 X62.181 Y86.92
G1 X65.08 Y89.819 E.07662
G1 X64.523 Y89.819
G1 X62.181 Y87.477 E.06188
G1 X62.181 Y88.035
G1 X63.965 Y89.819 E.04715
G1 X63.407 Y89.819
G1 X62.181 Y88.593 E.03242
G1 X62.181 Y89.15
G1 X62.85 Y89.819 E.01768
; WIPE_START
M204 S6000
G1 X62.181 Y89.15 E-.13486
G1 X62.181 Y88.593 E-.07945
G1 X62.532 Y88.943 E-.07069
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X67.839 Y85.747 Z2.04 F18000
G1 Z1.64
G1 E.3 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.236641
G1 F2400
M204 S6000
G1 X67.339 Y85.521 E.00548
G1 X67.218 Y85.508 E.00122
G1 X67.107 Y85.729 E.00247
M204 S10000
G1 X67.839 Y85.832 F18000
; LINE_WIDTH: 0.400368
G1 F2400
M204 S6000
G1 X67.194 Y85.413 E.01366
; WIPE_START
G1 X67.839 Y85.832 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X68.838 Y87.598 Z2.04 F18000
G1 Z1.64
G1 E.3 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F6000
M204 S6000
G1 X68.838 Y85.901 E.03412
G1 X69.097 Y85.898 E.0052
G1 X69.552 Y85.996 E.00936
G1 X70.007 Y86.235 E.01034
G1 X70.527 Y86.704 E.01409
G1 X70.528 Y83.423 E.06597
G1 X70.007 Y82.908 E.01471
G1 X69.552 Y82.564 E.01148
G1 X69.097 Y82.359 E.01004
G1 X68.838 Y82.304 E.00531
G1 X68.838 Y80.607 E.03412
; WIPE_START
G1 X68.838 Y82.304 E-.24182
G1 X69.097 Y82.359 E-.03766
G1 X69.132 Y82.375 E-.00552
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X67.15 Y80.181 Z2.04 F18000
G1 Z1.64
G1 E.3 F1800
; FEATURE: Top surface
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X67.819 Y80.85 E.01769
G1 X67.819 Y81.408
G1 X66.592 Y80.181 E.03242
G1 X66.035 Y80.181
G1 X67.819 Y81.965 E.04715
G1 X67.819 Y82.523
G1 X65.477 Y80.181 E.06189
G1 X64.92 Y80.181
G1 X67.819 Y83.08 E.07662
G1 X67.127 Y82.945
G1 X67.819 Y83.638 E.0183
G1 X67.819 Y84.195
G1 X67.127 Y83.503 E.0183
G1 X67.127 Y84.06
G1 X67.564 Y84.497 E.01154
; WIPE_START
M204 S6000
G1 X67.127 Y84.06 E-.08801
G1 X67.127 Y83.503 E-.07945
G1 X67.71 Y84.086 E-.11754
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X67.055 Y82.873 Z2.04 F18000
G1 Z1.64
G1 E.3 F1800
G1 F3600
M204 S2000
G1 X64.362 Y80.181 E.07115
G1 X63.805 Y80.181
G1 X66.497 Y82.873 E.07115
G1 X65.94 Y82.873
G1 X63.247 Y80.181 E.07115
G1 X62.69 Y80.181
G1 X65.382 Y82.873 E.07115
G1 X64.824 Y82.873
G1 X62.181 Y80.229 E.06986
G1 X62.181 Y80.787
G1 X64.267 Y82.873 E.05513
G1 X63.709 Y82.873
G1 X62.181 Y81.345 E.0404
G1 X62.181 Y81.902
G1 X63.152 Y82.873 E.02566
G1 X62.873 Y83.152
G1 X62.181 Y82.46 E.0183
G1 X62.181 Y83.017
G1 X62.873 Y83.71 E.0183
G1 X62.873 Y84.267
G1 X62.181 Y83.575 E.0183
; WIPE_START
M204 S6000
G1 X62.873 Y84.267 E-.13954
G1 X62.873 Y83.71 E-.07945
G1 X62.546 Y83.382 E-.06601
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X67.687 Y84.328 Z2.04 F18000
G1 Z1.64
G1 E.3 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.109096
G1 F2400
M204 S6000
G1 X67.728 Y84.335 E.00017
; LINE_WIDTH: 0.151069
G1 X67.77 Y84.342 E.00025
G1 X67.771 Y84.368 E.00016
G1 X67.742 Y84.397 E.00024
; LINE_WIDTH: 0.125302
G1 X67.601 Y84.492 E.0008
; WIPE_START
G1 X67.742 Y84.397 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X62.806 Y84.587 Z2.04 F18000
G1 Z1.64
G1 E.3 F1800
; LINE_WIDTH: 0.400263
G1 F2400
M204 S6000
G1 X62.161 Y84.168 E.01365
M204 S10000
G1 X62.893 Y84.271 F18000
; LINE_WIDTH: 0.236529
G1 F2400
M204 S6000
G1 X62.782 Y84.492 E.00247
G1 X62.661 Y84.479 E.00121
G1 X62.161 Y84.253 E.00548
; WIPE_START
G1 X62.661 Y84.479 E-.17038
G1 X62.782 Y84.492 E-.03776
G1 X62.893 Y84.271 E-.07686
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X67.797 Y83.336 Z2.04 F18000
G1 Z1.64
G1 E.3 F1800
; LINE_WIDTH: 0.0827731
G1 F2400
M204 S6000
G1 X67.818 Y83.201 E.00037
; WIPE_START
G1 X67.797 Y83.336 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X70.949 Y89.535 Z2.04 F18000
G1 Z1.64
G1 E.3 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.444092
G1 F4800
M204 S6000
G1 X70.949 Y80.535 E.17845
; CHANGE_LAYER
; Z_HEIGHT: 1.76
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F4800
G1 X70.949 Y82.535 E-.285
; WIPE_END
G1 E-.015 F1800
; layer num/total_layer_count: 14/74
; update layer progress
M73 L14
M991 S0 P13 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z2.04 I.279 J-1.184 P1  F18000
G1 X63.09 Y80.681 Z2.04
G1 Z1.76
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F3043
M204 S6000
G1 X67.319 Y80.681 E.08504
G1 X67.319 Y89.319 E.1737
G1 X62.681 Y89.319 E.09327
G1 X62.681 Y80.681 E.1737
G1 X63.03 Y80.681 E.00702
M204 S250
G1 X63.09 Y81.09 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1800
M204 S5000
G1 X66.91 Y81.09 E.07138
G1 X66.91 Y88.91 E.14612
G1 X63.09 Y88.91 E.07138
G1 X63.09 Y81.15 E.145
M204 S10000
G1 X62.257 Y81.09 F18000
M106 S229.5
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F3043
M204 S6000
G1 X62.257 Y89.957 E.17828
G1 X58.547 Y89.957 E.07459
G1 X58.547 Y80.043 E.19933
G1 X62.257 Y80.043 E.07459
G1 X62.257 Y81.03 E.01984
; WIPE_START
G1 F3600
G1 X62.257 Y83.03 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X66.996 Y89.013 Z2.16 F18000
G1 X67.743 Y89.957 Z2.16
G1 Z1.76
G1 E.3 F1800
G1 F3043
M204 S6000
G1 X67.743 Y80.043 E.19933
G1 X71.453 Y80.043 E.07459
G1 X71.453 Y89.957 E.19933
G1 X67.803 Y89.957 E.07339
; WIPE_START
G1 F3600
G1 X67.791 Y87.957 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X60.388 Y89.813 Z2.16 F18000
G1 X58.122 Y90.381 Z2.16
G1 Z1.76
G1 E.3 F1800
G1 F3043
M204 S6000
G1 X58.122 Y79.619 E.21639
G1 X71.877 Y79.619 E.27658
G1 X71.877 Y90.381 E.21639
G1 X58.182 Y90.381 E.27537
M204 S250
G1 X57.756 Y90.79 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F2700
M204 S5000
G1 X57.713 Y90.79 E.00079
G1 F3043
G1 X57.713 Y90.39 E.00747
M106 S73.95
M106 S229.5
G1 X57.713 Y79.61 E.20143
M106 S73.95
M106 S229.5
G1 X57.713 Y79.21 E.00747
M106 S73.95
M106 S229.5
G1 F2057.261
G1 X57.756 Y79.21 E.00079
G1 F1800
G1 X72.244 Y79.21 E.27074
G1 F2056.758
G1 X72.287 Y79.21 E.00079
G1 F3043
G1 X72.287 Y79.61 E.00747
M106 S73.95
M106 S229.5
G1 X72.287 Y90.39 E.20143
M106 S73.95
M106 S229.5
G1 X72.287 Y90.79 E.00747
M106 S73.95
G1 F2056.884
G1 X72.244 Y90.79 E.00079
G1 F1800
G1 X57.816 Y90.79 E.26961
; WIPE_START
M204 S6000
G1 X57.713 Y90.79 E-.01458
G1 X57.713 Y90.39 E-.057
G1 X57.713 Y88.892 E-.21342
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
G1 X0 Y85 ; move to safe pos
M73 P48 R10
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




G1 X58.955 Y89.549
G1 Z1.76
G1 E.3 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.417272
G1 F3043
M204 S6000
G1 X58.955 Y80.511 E.1677
; WIPE_START
G1 F4800
G1 X58.955 Y82.511 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X59.362 Y81.588 Z2.16 F18000
G1 Z1.76
G1 E.3 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F3043
M204 S6000
G1 X59.362 Y83.285 E.03412
G1 X59.952 Y82.735 E.01621
G1 X60.366 Y82.468 E.00991
G1 X61.079 Y82.296 E.01474
G1 X61.079 Y85.958 E.07365
G1 X60.366 Y86.186 E.01505
G1 X59.952 Y86.484 E.01026
G1 X59.362 Y87.042 E.01632
G1 X59.362 Y88.739 E.03412
; WIPE_START
G1 F6000
G1 X59.362 Y87.042 E-.24182
G1 X59.582 Y86.834 E-.04318
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X62.469 Y89.85 Z2.16 F18000
G1 Z1.76
G1 E.3 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.663042
G1 F2400
M204 S6000
G1 X67.531 Y89.85 E.15291
; WIPE_START
G1 X65.531 Y89.85 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X68.921 Y87.624 Z2.16 F18000
G1 Z1.76
G1 E.3 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F3043
M204 S6000
G1 X68.921 Y85.927 E.03412
G1 X69.097 Y85.938 E.00354
G1 X69.552 Y86.072 E.00954
G1 X70.007 Y86.344 E.01067
G1 X70.638 Y86.931 E.01732
G1 X70.638 Y83.406 E.07088
G1 X70.007 Y82.808 E.01748
G1 X69.552 Y82.5 E.01104
G1 X69.097 Y82.331 E.00976
G1 X68.921 Y82.307 E.00356
G1 X68.921 Y80.61 E.03412
M204 S10000
G1 X68.521 Y80.632 F18000
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.402532
G1 F3043
M204 S6000
G1 X68.521 Y80.444 E.00336
G1 X68.144 Y80.444 E.00673
G1 X68.144 Y89.556 E.16272
G1 X68.521 Y89.556 E.00673
G1 X68.521 Y80.692 E.15828
; WIPE_START
G1 F3840
G1 X68.521 Y82.692 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X67.531 Y80.15 Z2.16 F18000
G1 Z1.76
G1 E.3 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.663042
G1 F2400
M204 S6000
G1 X62.469 Y80.15 E.15291
M204 S10000
G1 X61.856 Y80.632 F18000
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.402542
G1 F3043
M204 S6000
G1 X61.856 Y80.444 E.00336
G1 X61.479 Y80.444 E.00673
G1 X61.479 Y89.556 E.16272
G1 X61.856 Y89.556 E.00673
G1 X61.856 Y80.692 E.15829
; WIPE_START
G1 F3840
G1 X61.856 Y82.692 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X67.973 Y87.257 Z2.16 F18000
G1 X71.045 Y89.549 Z2.16
G1 Z1.76
G1 E.3 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.417262
G1 F3043
M204 S6000
G1 X71.045 Y80.511 E.1677
; CHANGE_LAYER
; Z_HEIGHT: 1.88
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F4800
G1 X71.045 Y82.511 E-.285
; WIPE_END
G1 E-.015 F1800
; layer num/total_layer_count: 15/74
; update layer progress
M73 L15
M991 S0 P14 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z2.16 I.273 J-1.186 P1  F18000
G1 X63.09 Y80.681 Z2.16
G1 Z1.88
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F3105
M204 S6000
G1 X67.319 Y80.681 E.08504
G1 X67.319 Y89.319 E.1737
G1 X62.681 Y89.319 E.09327
G1 X62.681 Y80.681 E.1737
G1 X63.03 Y80.681 E.00702
M204 S250
G1 X63.09 Y81.09 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1800
M204 S5000
G1 X66.91 Y81.09 E.07138
G1 X66.91 Y88.91 E.14612
G1 X63.09 Y88.91 E.07138
G1 X63.09 Y81.15 E.145
M204 S10000
G1 X62.257 Y81.09 F18000
M106 S229.5
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F3105
M204 S6000
G1 X62.257 Y89.957 E.17828
G1 X58.468 Y89.957 E.07618
G1 X58.468 Y80.043 E.19933
G1 X62.257 Y80.043 E.07618
G1 X62.257 Y81.03 E.01984
; WIPE_START
G1 F3600
G1 X62.257 Y83.03 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X66.996 Y89.013 Z2.28 F18000
G1 X67.743 Y89.957 Z2.28
G1 Z1.88
G1 E.3 F1800
G1 F3105
M204 S6000
G1 X67.743 Y80.043 E.19933
G1 X71.532 Y80.043 E.07618
G1 X71.532 Y89.957 E.19933
G1 X67.803 Y89.957 E.07497
; WIPE_START
G1 F3600
G1 X67.791 Y87.957 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X60.385 Y89.799 Z2.28 F18000
G1 X58.044 Y90.381 Z2.28
G1 Z1.88
G1 E.3 F1800
G1 F3105
M204 S6000
G1 X58.044 Y79.619 E.21639
G1 X71.956 Y79.619 E.27974
G1 X71.956 Y90.381 E.21639
G1 X58.104 Y90.381 E.27854
M204 S250
G1 X57.672 Y90.79 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F2700
M204 S5000
G1 X57.635 Y90.79 E.0007
G1 F3105
G1 X57.635 Y90.39 E.00747
M106 S73.95
M106 S229.5
G1 X57.635 Y79.61 E.20143
M106 S73.95
M106 S229.5
G1 X57.635 Y79.21 E.00747
M106 S73.95
M106 S229.5
G1 F2028.202
G1 X57.672 Y79.21 E.0007
G1 F1800
G1 X72.328 Y79.21 E.27385
G1 F2028.702
G1 X72.365 Y79.21 E.00071
G1 F3105
G1 X72.365 Y79.61 E.00747
M106 S73.95
M106 S229.5
G1 X72.365 Y90.39 E.20143
M106 S73.95
M106 S229.5
G1 X72.365 Y90.79 E.00747
M106 S73.95
G1 F2028.702
G1 X72.328 Y90.79 E.00071
G1 F1800
G1 X57.732 Y90.79 E.27273
; WIPE_START
M204 S6000
G1 X57.635 Y90.79 E-.01392
G1 X57.635 Y90.39 E-.057
G1 X57.635 Y88.888 E-.21408
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
G1 X0 Y85 ; move to safe pos
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




G1 X58.864 Y89.56
G1 Z1.88
G1 E.3 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.393752
G1 F3105
M204 S6000
G1 X58.864 Y80.5 E.15804
; WIPE_START
G1 F4800
G1 X58.864 Y82.5 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X61.079 Y80.62 Z2.28 F18000
G1 Z1.88
G1 E.3 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F3105
M204 S6000
G1 X61.079 Y82.317 E.03412
G1 X60.366 Y82.544 E.01504
G1 X59.952 Y82.841 E.01026
G1 X59.26 Y83.492 E.0191
G1 X59.26 Y87.025 E.07104
G1 X59.952 Y86.378 E.01905
G1 X60.366 Y86.11 E.00992
G1 X61.079 Y85.938 E.01475
G1 X61.079 Y87.635 E.03412
; WIPE_START
G1 F6000
G1 X61.079 Y85.938 E-.24182
G1 X60.784 Y86.009 E-.04318
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X62.469 Y89.85 Z2.28 F18000
M73 P49 R10
G1 Z1.88
G1 E.3 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.663042
G1 F2400
M204 S6000
G1 X67.531 Y89.85 E.15291
; WIPE_START
G1 X65.531 Y89.85 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X70.74 Y88.84 Z2.28 F18000
G1 Z1.88
G1 E.3 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F3105
M204 S6000
G1 X70.74 Y87.143 E.03412
G1 X70.007 Y86.448 E.02031
G1 X69.552 Y86.141 E.01104
G1 X69.097 Y85.972 E.00976
G1 X68.921 Y85.948 E.00356
G1 X68.921 Y82.286 E.07363
G1 X69.097 Y82.297 E.00354
G1 X69.552 Y82.431 E.00954
G1 X70.007 Y82.704 E.01067
G1 X70.74 Y83.391 E.02019
G1 X70.74 Y81.694 E.03412
; WIPE_START
G1 F6000
G1 X70.74 Y83.391 E-.24182
G1 X70.519 Y83.184 E-.04318
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X68.521 Y80.632 Z2.28 F18000
G1 Z1.88
G1 E.3 F1800
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.402532
G1 F3105
M204 S6000
G1 X68.521 Y80.444 E.00336
G1 X68.144 Y80.444 E.00673
G1 X68.144 Y89.556 E.16272
G1 X68.521 Y89.556 E.00673
G1 X68.521 Y80.692 E.15828
; WIPE_START
G1 F3840
G1 X68.521 Y82.692 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X67.531 Y80.15 Z2.28 F18000
G1 Z1.88
G1 E.3 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.663042
G1 F2400
M204 S6000
G1 X62.469 Y80.15 E.15291
M204 S10000
G1 X61.856 Y80.632 F18000
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.402542
G1 F3105
M204 S6000
G1 X61.856 Y80.444 E.00336
G1 X61.479 Y80.444 E.00673
G1 X61.479 Y89.556 E.16272
G1 X61.856 Y89.556 E.00673
G1 X61.856 Y80.692 E.15829
; WIPE_START
G1 F3840
G1 X61.856 Y82.692 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X67.991 Y87.233 Z2.28 F18000
G1 X71.136 Y89.56 Z2.28
G1 Z1.88
G1 E.3 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.393712
G1 F3105
M204 S6000
G1 X71.136 Y80.5 E.15802
; CHANGE_LAYER
; Z_HEIGHT: 2
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F4800
G1 X71.136 Y82.5 E-.285
; WIPE_END
G1 E-.015 F1800
; layer num/total_layer_count: 16/74
; update layer progress
M73 L16
M991 S0 P15 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z2.28 I.268 J-1.187 P1  F18000
G1 X63.09 Y80.681 Z2.28
G1 Z2
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F3150
M204 S6000
G1 X67.319 Y80.681 E.08504
G1 X67.319 Y89.319 E.1737
G1 X62.681 Y89.319 E.09327
G1 X62.681 Y80.681 E.1737
G1 X63.03 Y80.681 E.00702
M204 S250
G1 X63.09 Y81.09 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1800
M204 S5000
G1 X66.91 Y81.09 E.07138
G1 X66.91 Y88.91 E.14612
G1 X63.09 Y88.91 E.07138
G1 X63.09 Y81.15 E.145
M204 S10000
G1 X62.257 Y81.09 F18000
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F3150
M204 S6000
G1 X62.257 Y89.957 E.17828
G1 X58.394 Y89.957 E.07766
G1 X58.394 Y80.043 E.19933
G1 X62.257 Y80.043 E.07766
G1 X62.257 Y81.03 E.01984
; WIPE_START
G1 F3600
G1 X62.257 Y83.03 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X66.996 Y89.013 Z2.4 F18000
G1 X67.743 Y89.957 Z2.4
G1 Z2
G1 E.3 F1800
G1 F3150
M204 S6000
G1 X67.743 Y80.043 E.19933
G1 X71.606 Y80.043 E.07766
G1 X71.606 Y89.957 E.19933
G1 X67.803 Y89.957 E.07646
; WIPE_START
G1 F3600
G1 X67.791 Y87.957 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X60.381 Y89.786 Z2.4 F18000
G1 X57.97 Y90.381 Z2.4
G1 Z2
G1 E.3 F1800
G1 F3150
M204 S6000
G1 X57.97 Y79.619 E.21639
M73 P49 R9
G1 X72.03 Y79.619 E.28272
G1 X72.03 Y90.381 E.21639
G1 X58.03 Y90.381 E.28151
M204 S250
G1 X57.594 Y90.79 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F2520
M204 S5000
G1 X57.561 Y90.79 E.00062
G1 F3150
G1 X57.561 Y90.39 E.00747
G1 X57.561 Y79.61 E.20143
G1 X57.561 Y79.21 E.00747
G1 F1998.793
G1 X57.594 Y79.21 E.00062
G1 F1800
G1 X72.406 Y79.21 E.27679
G1 F1998.855
G1 X72.439 Y79.21 E.00062
G1 F3150
G1 X72.439 Y79.61 E.00747
G1 X72.439 Y90.39 E.20143
G1 X72.439 Y90.79 E.00747
G1 F1998.669
G1 X72.406 Y90.79 E.00061
G1 F1800
G1 X57.654 Y90.79 E.27567
; WIPE_START
M204 S6000
G1 X57.561 Y90.79 E-.01324
G1 X57.561 Y90.39 E-.057
G1 X57.561 Y88.883 E-.21476
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
G1 X0 Y85 ; move to safe pos
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




G1 X58.78 Y89.571
G1 Z2
G1 E.3 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.372432
G1 F3150
M204 S6000
G1 X58.78 Y80.489 E.14923
; WIPE_START
G1 F4800
G1 X58.78 Y82.489 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X61.079 Y80.621 Z2.4 F18000
G1 Z2
G1 E.3 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F3150
M204 S6000
G1 X61.079 Y82.318 E.03412
G1 X60.78 Y82.402 E.00624
G1 X60.366 Y82.614 E.00936
G1 X59.165 Y83.691 E.03243
G1 X59.165 Y87.011 E.06676
G1 X59.538 Y86.639 E.01058
G1 X59.952 Y86.266 E.01121
G1 X60.366 Y86.028 E.00961
G1 X61.079 Y85.91 E.01453
G1 X61.079 Y87.607 E.03412
; WIPE_START
G1 F6000
G1 X61.079 Y85.91 E-.24182
G1 X60.78 Y85.96 E-.04318
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X62.469 Y89.85 Z2.4 F18000
G1 Z2
G1 E.3 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.663042
G1 F2400
M204 S6000
G1 X67.531 Y89.85 E.15291
; WIPE_START
G1 X65.531 Y89.85 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X70.835 Y89.387 Z2.4 F18000
G1 Z2
G1 E.3 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F3150
M204 S6000
G1 X70.835 Y89.594 E.00415
G1 X69.344 Y89.594 E.02997
G1 X69.097 Y89.54 E.00509
G1 X68.921 Y89.542 E.00353
G1 X68.921 Y85.963 E.07197
G1 X69.097 Y86 E.00361
G1 X69.552 Y86.205 E.01004
G1 X70.007 Y86.549 E.01147
G1 X70.835 Y87.343 E.02307
G1 X70.835 Y83.343 E.08044
G1 X70.007 Y82.595 E.02243
G1 X69.552 Y82.355 E.01034
G1 X69.097 Y82.257 E.00936
G1 X68.921 Y82.259 E.00353
G1 X68.921 Y80.562 E.03412
M204 S10000
G1 X68.521 Y80.632 F18000
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.402532
G1 F3150
M204 S6000
G1 X68.521 Y80.444 E.00336
G1 X68.144 Y80.444 E.00673
M73 P50 R9
G1 X68.144 Y89.556 E.16272
G1 X68.521 Y89.556 E.00673
G1 X68.521 Y80.692 E.15828
; WIPE_START
G1 F3840
G1 X68.521 Y82.692 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X67.531 Y80.15 Z2.4 F18000
G1 Z2
G1 E.3 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.663042
G1 F2400
M204 S6000
G1 X62.469 Y80.15 E.15291
M204 S10000
G1 X61.856 Y80.632 F18000
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.402542
G1 F3150
M204 S6000
G1 X61.856 Y80.444 E.00336
G1 X61.479 Y80.444 E.00673
G1 X61.479 Y89.556 E.16272
G1 X61.856 Y89.556 E.00673
G1 X61.856 Y80.692 E.15829
; WIPE_START
G1 F3840
G1 X61.856 Y82.692 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X68.007 Y87.211 Z2.4 F18000
G1 X71.22 Y89.571 Z2.4
G1 Z2
G1 E.3 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.372572
G1 F3150
M204 S6000
G1 X71.22 Y80.489 E.14929
; CHANGE_LAYER
; Z_HEIGHT: 2.12
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F4800
G1 X71.22 Y82.489 E-.285
; WIPE_END
G1 E-.015 F1800
; layer num/total_layer_count: 17/74
; update layer progress
M73 L17
M991 S0 P16 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z2.4 I.264 J-1.188 P1  F18000
G1 X63.09 Y80.681 Z2.4
G1 Z2.12
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F3212
M204 S6000
G1 X67.319 Y80.681 E.08504
G1 X67.319 Y89.319 E.1737
G1 X62.681 Y89.319 E.09327
G1 X62.681 Y80.681 E.1737
G1 X63.03 Y80.681 E.00702
M204 S250
G1 X63.09 Y81.09 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1800
M204 S5000
G1 X66.91 Y81.09 E.07138
G1 X66.91 Y88.91 E.14612
G1 X63.09 Y88.91 E.07138
G1 X63.09 Y81.15 E.145
M204 S10000
G1 X62.257 Y81.09 F18000
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F3212
M204 S6000
G1 X62.257 Y89.957 E.17828
G1 X58.324 Y89.957 E.07907
G1 X58.324 Y80.043 E.19933
G1 X62.257 Y80.043 E.07907
G1 X62.257 Y81.03 E.01984
; WIPE_START
G1 F3600
G1 X62.257 Y83.03 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X66.996 Y89.013 Z2.52 F18000
G1 X67.743 Y89.957 Z2.52
G1 Z2.12
G1 E.3 F1800
G1 F3212
M204 S6000
G1 X67.743 Y80.043 E.19933
G1 X71.676 Y80.043 E.07907
G1 X71.676 Y89.957 E.19933
G1 X67.803 Y89.957 E.07786
; WIPE_START
G1 F3600
G1 X67.791 Y87.957 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X60.378 Y89.773 Z2.52 F18000
G1 X57.9 Y90.381 Z2.52
G1 Z2.12
G1 E.3 F1800
G1 F3212
M204 S6000
G1 X57.9 Y79.619 E.21639
G1 X72.1 Y79.619 E.28553
G1 X72.1 Y90.381 E.21639
G1 X57.96 Y90.381 E.28432
M204 S250
G1 X57.52 Y90.79 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F2340
M204 S5000
G1 X57.491 Y90.79 E.00054
G1 F3060
G1 X57.491 Y90.39 E.00747
G1 X57.491 Y79.61 E.20143
G1 X57.491 Y79.21 E.00747
G1 F1974.891
G1 X57.52 Y79.21 E.00054
G1 F1800
G1 X72.48 Y79.21 E.27955
G1 F2340
G1 X72.509 Y79.21 E.00054
G1 F3060
G1 X72.509 Y79.61 E.00747
G1 X72.509 Y90.39 E.20143
G1 X72.509 Y90.79 E.00747
G1 F1973.659
G1 X72.48 Y90.79 E.00054
G1 F1800
G1 X57.58 Y90.79 E.27843
; WIPE_START
M204 S6000
G1 X57.491 Y90.79 E-.01269
G1 X57.491 Y90.39 E-.057
G1 X57.491 Y88.879 E-.21531
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
G1 X0 Y85 ; move to safe pos
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




G1 X58.7 Y89.581
G1 Z2.12
G1 E.3 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.365752
G1 F3212
M204 S6000
G1 X58.7 Y80.479 E.14666
; WIPE_START
G1 F4800
G1 X58.7 Y82.479 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X61.079 Y80.63 Z2.52 F18000
G1 Z2.12
G1 E.3 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F3212
M204 S6000
G1 X61.079 Y82.327 E.03412
G1 X60.78 Y82.433 E.00638
G1 X60.366 Y82.681 E.00971
G1 X59.538 Y83.489 E.02327
G1 X59.076 Y83.884 E.01223
G1 X59.076 Y86.998 E.06261
G1 X59.538 Y86.511 E.0135
G1 X59.952 Y86.146 E.0111
G1 X60.366 Y85.938 E.00932
G1 X61.079 Y85.877 E.01439
G1 X61.079 Y87.574 E.03412
; WIPE_START
G1 F6000
G1 X61.079 Y85.877 E-.24182
G1 X60.777 Y85.903 E-.04318
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X62.469 Y89.85 Z2.52 F18000
G1 Z2.12
G1 E.3 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.663042
G1 F2400
M204 S6000
G1 X67.531 Y89.85 E.15291
; WIPE_START
G1 X65.531 Y89.85 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X68.921 Y87.812 Z2.52 F18000
G1 Z2.12
G1 E.3 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F3212
M204 S6000
G1 X68.921 Y89.509 E.03412
G1 X69.097 Y89.494 E.00354
G1 X69.552 Y89.555 E.00924
G1 X69.637 Y89.594 E.00189
G1 X70.924 Y89.594 E.02587
G1 X70.924 Y87.515 E.04179
G1 X70.835 Y87.466 E.00204
G1 X70.462 Y87.131 E.01009
G1 X70.007 Y86.649 E.01332
G1 X69.552 Y86.264 E.01199
G1 X69.097 Y86.022 E.01037
G1 X68.921 Y85.971 E.00367
G1 X68.921 Y82.225 E.07532
G1 X69.097 Y82.21 E.00354
G1 X69.552 Y82.272 E.00924
G1 X70.007 Y82.477 E.01004
G1 X70.462 Y82.87 E.01208
G1 X70.924 Y83.33 E.01312
G1 X70.924 Y81.633 E.03412
; WIPE_START
G1 F6000
G1 X70.924 Y83.33 E-.24182
G1 X70.71 Y83.116 E-.04318
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X68.521 Y80.632 Z2.52 F18000
G1 Z2.12
G1 E.3 F1800
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.402532
G1 F3212
M204 S6000
G1 X68.521 Y80.444 E.00336
G1 X68.144 Y80.444 E.00673
G1 X68.144 Y89.556 E.16272
G1 X68.521 Y89.556 E.00673
G1 X68.521 Y80.692 E.15828
; WIPE_START
G1 F3840
M73 P51 R9
G1 X68.521 Y82.692 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X67.531 Y80.15 Z2.52 F18000
G1 Z2.12
G1 E.3 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.663042
G1 F2400
M204 S6000
G1 X62.469 Y80.15 E.15291
M204 S10000
G1 X61.856 Y80.632 F18000
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.402542
G1 F3212
M204 S6000
G1 X61.856 Y80.444 E.00336
G1 X61.479 Y80.444 E.00673
G1 X61.479 Y89.556 E.16272
G1 X61.856 Y89.556 E.00673
G1 X61.856 Y80.692 E.15829
; WIPE_START
G1 F3840
G1 X61.856 Y82.692 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X68.022 Y87.19 Z2.52 F18000
G1 X71.3 Y89.581 Z2.52
G1 Z2.12
G1 E.3 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.365752
G1 F3212
M204 S6000
G1 X71.3 Y80.479 E.14667
; CHANGE_LAYER
; Z_HEIGHT: 2.24
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F4800
G1 X71.3 Y82.479 E-.285
; WIPE_END
G1 E-.015 F1800
; layer num/total_layer_count: 18/74
; update layer progress
M73 L18
M991 S0 P17 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z2.52 I.26 J-1.189 P1  F18000
G1 X63.09 Y80.681 Z2.52
G1 Z2.24
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F2782
M204 S6000
G1 X67.319 Y80.681 E.08504
G1 X67.319 Y89.319 E.1737
G1 X62.681 Y89.319 E.09327
G1 X62.681 Y80.681 E.1737
G1 X63.03 Y80.681 E.00702
M204 S250
G1 X63.09 Y81.09 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1800
M204 S5000
G1 X66.91 Y81.09 E.07138
G1 X66.91 Y88.91 E.14612
G1 X63.09 Y88.91 E.07138
G1 X63.09 Y81.15 E.145
M204 S10000
G1 X62.257 Y81.09 F18000
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F2782
M204 S6000
G1 X62.257 Y89.957 E.17828
G1 X58.258 Y89.957 E.0804
G1 X58.258 Y80.043 E.19933
G1 X62.257 Y80.043 E.0804
G1 X62.257 Y81.03 E.01984
; WIPE_START
G1 F3600
G1 X62.257 Y83.03 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X66.996 Y89.013 Z2.64 F18000
G1 X67.743 Y89.957 Z2.64
G1 Z2.24
G1 E.3 F1800
G1 F2782
M204 S6000
G1 X67.743 Y80.043 E.19933
G1 X71.742 Y80.043 E.0804
G1 X71.742 Y89.957 E.19933
G1 X67.803 Y89.957 E.07919
; WIPE_START
G1 F3600
G1 X67.791 Y87.957 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X60.376 Y89.762 Z2.64 F18000
G1 X57.834 Y90.381 Z2.64
G1 Z2.24
G1 E.3 F1800
G1 F2782
M204 S6000
G1 X57.834 Y79.619 E.21639
G1 X72.166 Y79.619 E.28819
G1 X72.166 Y90.381 E.21639
G1 X57.894 Y90.381 E.28698
M204 S250
G1 X57.45 Y90.79 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F2340
M204 S5000
G1 X57.425 Y90.79 E.00047
G1 F2782
G1 X57.425 Y79.21 E.21638
G1 F2340
G1 X57.45 Y79.21 E.00047
G1 F1800
G1 X72.55 Y79.21 E.28216
G1 F2340
G1 X72.576 Y79.21 E.00047
G1 F2782
G1 X72.575 Y90.79 E.21638
G1 F2340
G1 X72.55 Y90.79 E.00047
G1 F1800
G1 X57.51 Y90.79 E.28104
; WIPE_START
M204 S6000
G1 X57.425 Y90.79 E-.01211
G1 X57.425 Y88.875 E-.27289
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
G1 X0 Y85 ; move to safe pos
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




G1 X58.625 Y89.589
G1 Z2.24
G1 E.3 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.365752
G1 F2782
M204 S6000
G1 X58.625 Y80.471 E.14694
; WIPE_START
G1 F4800
G1 X58.625 Y82.471 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X61.894 Y80.46 Z2.64 F18000
G1 Z2.24
G1 E.3 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F2782
M204 S6000
G1 X61.894 Y82.157 E.03412
G1 X61.358 Y82.23 E.01086
G1 X60.903 Y82.396 E.00974
G1 X60.448 Y82.678 E.01077
G1 X59.538 Y83.629 E.02647
G1 X59.082 Y84.011 E.01195
G1 X58.992 Y84.044 E.00193
G1 X58.992 Y86.941 E.05823
G1 X59.538 Y86.371 E.01585
G1 X59.993 Y85.989 E.01195
G1 X60.448 Y85.821 E.00975
G1 X60.903 Y85.798 E.00916
G1 X61.358 Y85.872 E.00927
G1 X61.894 Y86.083 E.01157
G1 X61.894 Y89.441 E.06751
G1 X61.358 Y89.513 E.01086
G1 X61.137 Y89.594 E.00473
G1 X59.44 Y89.594 E.03412
; WIPE_START
G1 F6000
G1 X61.137 Y89.594 E-.24182
G1 X61.358 Y89.513 E-.03354
G1 X61.426 Y89.504 E-.00964
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X62.469 Y89.85 Z2.64 F18000
G1 Z2.24
G1 E.3 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.663042
G1 F2400
M204 S6000
G1 X67.531 Y89.85 E.15291
; WIPE_START
G1 X65.531 Y89.85 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X68.106 Y88.211 Z2.64 F18000
G1 Z2.24
G1 E.3 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F2782
M204 S6000
G1 X68.106 Y89.594 E.02781
G1 X68.42 Y89.594 E.00631
G1 X68.642 Y89.513 E.00473
G1 X69.097 Y89.44 E.00927
G1 X69.552 Y89.463 E.00916
G1 X69.907 Y89.594 E.00762
G1 X71.007 Y89.594 E.02212
G1 X71.007 Y87.684 E.0384
G1 X70.835 Y87.601 E.00384
G1 X70.462 Y87.271 E.01002
G1 X69.552 Y86.32 E.02647
G1 X69.097 Y86.037 E.01077
G1 X68.642 Y85.872 E.00974
G1 X68.186 Y85.798 E.00927
G1 X68.106 Y85.802 E.00161
G1 X68.106 Y82.445 E.0675
G1 X68.186 Y82.396 E.00189
G1 X68.642 Y82.23 E.00974
G1 X69.097 Y82.156 E.00927
G1 X69.552 Y82.18 E.00916
G1 X70.007 Y82.347 E.00975
G1 X70.462 Y82.73 E.01195
G1 X71.007 Y83.323 E.0162
G1 X71.007 Y81.626 E.03412
; WIPE_START
G1 F6000
G1 X71.007 Y83.323 E-.24182
G1 X70.802 Y83.1 E-.04318
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X67.531 Y80.15 Z2.64 F18000
G1 Z2.24
G1 E.3 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.663042
G1 F2400
M204 S6000
G1 X62.469 Y80.15 E.15291
; WIPE_START
G1 X64.469 Y80.15 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X68.975 Y86.31 Z2.64 F18000
G1 X71.375 Y89.589 Z2.64
G1 Z2.24
G1 E.3 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.365752
G1 F2782
M204 S6000
G1 X71.375 Y80.471 E.14694
; CHANGE_LAYER
; Z_HEIGHT: 2.36
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F4800
G1 X71.375 Y82.471 E-.285
; WIPE_END
G1 E-.015 F1800
; layer num/total_layer_count: 19/74
; update layer progress
M73 L19
M991 S0 P18 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z2.64 I.257 J-1.19 P1  F18000
G1 X63.09 Y80.681 Z2.64
G1 Z2.36
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F2822
M204 S6000
G1 X67.319 Y80.681 E.08504
G1 X67.319 Y89.319 E.1737
G1 X62.681 Y89.319 E.09327
G1 X62.681 Y80.681 E.1737
G1 X63.03 Y80.681 E.00702
M204 S250
G1 X63.09 Y81.09 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1800
M204 S5000
G1 X66.91 Y81.09 E.07138
G1 X66.91 Y88.91 E.14612
G1 X63.09 Y88.91 E.07138
G1 X63.09 Y81.15 E.145
M204 S10000
G1 X62.257 Y81.09 F18000
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F2822
M204 S6000
G1 X62.257 Y89.957 E.17828
G1 X58.195 Y89.957 E.08166
G1 X58.195 Y80.043 E.19933
G1 X62.257 Y80.043 E.08166
G1 X62.257 Y81.03 E.01984
; WIPE_START
G1 F3600
G1 X62.257 Y83.03 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X66.996 Y89.013 Z2.76 F18000
G1 X67.743 Y89.957 Z2.76
G1 Z2.36
G1 E.3 F1800
G1 F2822
M204 S6000
G1 X67.743 Y80.043 E.19933
G1 X71.805 Y80.043 E.08166
G1 X71.805 Y89.957 E.19933
G1 X67.803 Y89.957 E.08045
; WIPE_START
G1 F3600
G1 X67.791 Y87.957 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X60.373 Y89.751 Z2.76 F18000
G1 X57.771 Y90.381 Z2.76
G1 Z2.36
G1 E.3 F1800
G1 F2822
M204 S6000
G1 X57.771 Y79.619 E.21639
G1 X72.229 Y79.619 E.29071
G1 X72.229 Y90.381 E.21639
G1 X57.831 Y90.381 E.2895
M204 S250
G1 X57.384 Y90.79 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F2160
M204 S5000
M73 P52 R9
G1 X57.362 Y90.79 E.00041
G1 F2700
G1 X57.362 Y79.21 E.21638
G1 F2160
G1 X57.384 Y79.21 E.00041
G1 F1800
G1 X72.617 Y79.21 E.28464
G1 F2160
G1 X72.638 Y79.21 E.0004
G1 F2700
G1 X72.638 Y90.79 E.21638
G1 F2160
G1 X72.616 Y90.79 E.0004
G1 F1800
G1 X57.444 Y90.79 E.28351
; WIPE_START
M204 S6000
G1 X57.362 Y90.79 E-.01164
G1 X57.362 Y88.872 E-.27336
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
G1 X0 Y85 ; move to safe pos
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




G1 X58.555 Y89.597
G1 Z2.36
G1 E.3 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.365752
G1 F2822
M204 S6000
G1 X58.555 Y80.463 E.1472
; WIPE_START
G1 F4800
G1 X58.555 Y82.463 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X59.42 Y89.594 Z2.76 F18000
G1 Z2.36
G1 E.3 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F2822
M204 S6000
G1 X61.117 Y89.594 E.03412
G1 X61.358 Y89.487 E.00531
G1 X61.894 Y89.371 E.01101
G1 X61.894 Y86.099 E.06579
G1 X61.358 Y85.845 E.01191
G1 X60.903 Y85.736 E.00941
G1 X60.448 Y85.718 E.00916
G1 X59.993 Y85.841 E.00948
G1 X59.538 Y86.211 E.01179
G1 X58.914 Y86.937 E.01924
G1 X58.914 Y84.204 E.05494
G1 X59.082 Y84.159 E.00351
G1 X59.538 Y83.789 E.01179
G1 X60.448 Y82.73 E.02807
G1 X60.903 Y82.405 E.01125
G1 X61.358 Y82.204 E.01001
G1 X61.894 Y82.088 E.01101
G1 X61.894 Y80.406 E.03382
G1 X61.879 Y80.406 E.0003
M204 S10000
G1 X62.469 Y80.15 F18000
; FEATURE: Gap infill
; LINE_WIDTH: 0.663042
G1 F2400
M204 S6000
G1 X67.531 Y80.15 E.15291
; WIPE_START
G1 X65.531 Y80.15 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X69.063 Y80.406 Z2.76 F18000
G1 Z2.36
G1 E.3 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F2822
M204 S6000
G1 X70.76 Y80.406 E.03412
G1 X70.835 Y80.472 E.002
G1 X71.086 Y80.569 E.00541
G1 X71.086 Y83.323 E.05537
G1 X70.462 Y82.57 E.01967
G1 X70.007 Y82.2 E.01179
G1 X69.552 Y82.076 E.00948
G1 X69.097 Y82.094 E.00916
G1 X68.642 Y82.204 E.00941
G1 X68.186 Y82.405 E.01001
G1 X68.106 Y82.462 E.00198
G1 X68.106 Y85.733 E.06577
G1 X68.186 Y85.736 E.00161
G1 X68.642 Y85.845 E.00941
G1 X69.097 Y86.046 E.01001
G1 X69.552 Y86.372 E.01125
G1 X70.462 Y87.43 E.02807
G1 X70.835 Y87.755 E.00994
G1 X71.086 Y87.852 E.00541
G1 X71.086 Y89.594 E.03501
G1 X70.143 Y89.594 E.01896
G1 X70.007 Y89.483 E.00353
G1 X69.552 Y89.36 E.00948
G1 X69.097 Y89.378 E.00916
G1 X68.642 Y89.487 E.00941
G1 X68.4 Y89.594 E.00531
G1 X68.106 Y89.594 E.00591
G1 X68.106 Y88.19 E.02822
; WIPE_START
G1 F6000
G1 X68.106 Y89.594 E-.19997
G1 X68.4 Y89.594 E-.04186
G1 X68.642 Y89.487 E-.03762
G1 X68.679 Y89.478 E-.00556
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X67.531 Y89.85 Z2.76 F18000
G1 Z2.36
G1 E.3 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.663042
G1 F2400
M204 S6000
G1 X62.469 Y89.85 E.15291
; WIPE_START
G1 X64.469 Y89.85 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X71.445 Y89.597 Z2.76 F18000
G1 Z2.36
G1 E.3 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.365752
G1 F2822
M204 S6000
G1 X71.445 Y80.463 E.1472
; CHANGE_LAYER
; Z_HEIGHT: 2.48
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F4800
G1 X71.445 Y82.463 E-.285
; WIPE_END
G1 E-.015 F1800
; layer num/total_layer_count: 20/74
; update layer progress
M73 L20
M991 S0 P19 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z2.76 I.254 J-1.19 P1  F18000
G1 X63.09 Y80.681 Z2.76
G1 Z2.48
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F2546
M204 S6000
G1 X67.319 Y80.681 E.08504
G1 X67.319 Y89.319 E.1737
G1 X62.681 Y89.319 E.09327
G1 X62.681 Y80.681 E.1737
G1 X63.03 Y80.681 E.00702
M204 S250
G1 X63.09 Y81.09 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1800
M204 S5000
G1 X66.91 Y81.09 E.07138
G1 X66.91 Y88.91 E.14612
G1 X63.09 Y88.91 E.07138
G1 X63.09 Y81.15 E.145
M204 S10000
G1 X62.257 Y81.09 F18000
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F2546
M204 S6000
G1 X62.257 Y89.957 E.17828
G1 X58.136 Y89.957 E.08285
G1 X58.136 Y80.043 E.19933
G1 X62.257 Y80.043 E.08285
G1 X62.257 Y81.03 E.01984
; WIPE_START
G1 F3600
G1 X62.257 Y83.03 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X66.996 Y89.013 Z2.88 F18000
G1 X67.743 Y89.957 Z2.88
G1 Z2.48
G1 E.3 F1800
G1 F2546
M204 S6000
G1 X67.743 Y80.043 E.19933
G1 X71.864 Y80.043 E.08285
G1 X71.864 Y89.957 E.19933
G1 X67.803 Y89.957 E.08164
; WIPE_START
G1 F3600
G1 X67.791 Y87.957 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X60.371 Y89.741 Z2.88 F18000
G1 X57.712 Y90.381 Z2.88
G1 Z2.48
G1 E.3 F1800
G1 F2546
M204 S6000
G1 X57.712 Y79.619 E.21639
G1 X72.288 Y79.619 E.29309
G1 X72.288 Y90.381 E.21639
G1 X57.772 Y90.381 E.29188
M204 S250
G1 X57.321 Y90.79 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F2160
M204 S5000
G1 X57.303 Y90.79 E.00034
G1 F2520
G1 X57.303 Y79.21 E.21638
G1 F2160
G1 X57.321 Y79.21 E.00034
G1 F1800
G1 X72.679 Y79.21 E.28698
G1 F2160
G1 X72.697 Y79.21 E.00034
G1 F2520
G1 X72.697 Y90.79 E.21638
G1 F2160
G1 X72.679 Y90.79 E.00034
G1 F1800
G1 X57.381 Y90.79 E.28585
; WIPE_START
M204 S6000
G1 X57.303 Y90.79 E-.01117
G1 X57.303 Y88.868 E-.27383
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
G1 X0 Y85 ; move to safe pos
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




G1 X59.392 Y89.594
G1 Z2.48
G1 E.3 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F2546
M204 S6000
G1 X61.089 Y89.594 E.03412
G1 X61.358 Y89.453 E.00611
G1 X61.894 Y89.293 E.01123
G1 X61.894 Y86.11 E.064
G1 X61.856 Y86.077 E.00101
G1 X61.358 Y85.812 E.01134
M73 P53 R9
G1 X60.448 Y85.602 E.01879
G1 X59.993 Y85.669 E.00925
G1 X59.538 Y86.017 E.01153
G1 X58.627 Y87.22 E.03034
G1 X58.499 Y87.325 E.00334
G1 X58.499 Y84.369 E.05945
G1 X58.627 Y84.398 E.00265
G1 X59.082 Y84.331 E.00925
G1 X59.538 Y83.983 E.01153
G1 X60.448 Y82.78 E.03034
G1 X60.903 Y82.407 E.01182
G1 X61.358 Y82.17 E.01032
G1 X61.894 Y82.01 E.01123
G1 X61.894 Y80.406 E.03225
G1 X61.8 Y80.406 E.00188
M204 S10000
G1 X62.469 Y80.15 F18000
; FEATURE: Gap infill
; LINE_WIDTH: 0.663042
G1 F2400
M204 S6000
G1 X67.531 Y80.15 E.15291
; WIPE_START
G1 X65.531 Y80.15 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X68.843 Y80.406 Z2.88 F18000
G1 Z2.48
G1 E.3 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F2546
M204 S6000
G1 X70.54 Y80.406 E.03412
G1 X70.835 Y80.654 E.00775
G1 X71.209 Y80.753 E.00776
G1 X71.501 Y80.717 E.00593
G1 X71.501 Y83.69 E.05979
G1 X71.209 Y83.399 E.0083
G1 X70.462 Y82.376 E.02547
G1 X70.007 Y82.027 E.01153
G1 X69.552 Y81.96 E.00925
G1 X68.642 Y82.17 E.01879
G1 X68.186 Y82.407 E.01032
G1 X68.106 Y82.473 E.00208
G1 X68.106 Y85.688 E.06465
G1 X68.642 Y85.812 E.01105
G1 X69.097 Y86.049 E.01032
G1 X69.552 Y86.421 E.01182
G1 X70.462 Y87.625 E.03034
G1 X70.835 Y87.937 E.00978
G1 X71.209 Y88.036 E.00776
G1 X71.501 Y88 E.00593
G1 X71.501 Y89.594 E.03205
G1 X70.378 Y89.594 E.02259
G1 X70.007 Y89.31 E.00938
G1 X69.552 Y89.243 E.00925
G1 X68.642 Y89.453 E.01879
G1 X68.372 Y89.594 E.00611
G1 X68.106 Y89.594 E.00535
G1 X68.106 Y88.163 E.02878
; WIPE_START
G1 F6000
G1 X68.106 Y89.594 E-.20394
G1 X68.372 Y89.594 E-.03788
G1 X68.641 Y89.454 E-.04318
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X67.531 Y89.85 Z2.88 F18000
G1 Z2.48
G1 E.3 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.663042
G1 F2400
M204 S6000
G1 X62.469 Y89.85 E.15291
; CHANGE_LAYER
; Z_HEIGHT: 2.6
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F2400
G1 X64.469 Y89.85 E-.285
; WIPE_END
G1 E-.015 F1800
; layer num/total_layer_count: 21/74
; update layer progress
M73 L21
M991 S0 P20 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z2.88 I1.203 J-.181 P1  F18000
G1 X63.09 Y80.681 Z2.88
G1 Z2.6
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F3124
M204 S6000
G1 X67.319 Y80.681 E.08504
G1 X67.319 Y89.319 E.1737
G1 X62.681 Y89.319 E.09327
G1 X62.681 Y80.681 E.1737
G1 X63.03 Y80.681 E.00702
M204 S250
G1 X63.09 Y81.09 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1800
M204 S5000
G1 X66.91 Y81.09 E.07138
G1 X66.91 Y88.91 E.14612
G1 X63.09 Y88.91 E.07138
G1 X63.09 Y81.15 E.145
M204 S10000
G1 X62.257 Y81.09 F18000
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F3124
M204 S6000
G1 X62.257 Y89.957 E.17828
G1 X58.08 Y89.957 E.08398
G1 X58.08 Y80.043 E.19933
G1 X62.257 Y80.043 E.08398
G1 X62.257 Y81.03 E.01984
; WIPE_START
G1 F3600
G1 X62.257 Y83.03 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X66.996 Y89.013 Z3 F18000
G1 X67.743 Y89.957 Z3
G1 Z2.6
G1 E.3 F1800
G1 F3124
M204 S6000
G1 X67.743 Y80.043 E.19933
G1 X71.92 Y80.043 E.08398
G1 X71.92 Y89.957 E.19933
G1 X67.803 Y89.957 E.08277
; WIPE_START
G1 F3600
G1 X67.791 Y87.957 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X60.368 Y89.732 Z3 F18000
G1 X57.656 Y90.381 Z3
G1 Z2.6
G1 E.3 F1800
G1 F3124
M204 S6000
G1 X57.656 Y79.619 E.21639
G1 X72.345 Y79.619 E.29536
G1 X72.344 Y90.381 E.21639
G1 X57.716 Y90.381 E.29415
M204 S250
G1 X57.262 Y90.79 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F2160
M204 S5000
G1 X57.246 Y90.79 E.00028
G1 F2520
G1 X57.246 Y79.21 E.21638
G1 F2160
G1 X57.262 Y79.21 E.00028
G1 F1800
G1 X72.738 Y79.21 E.28919
G1 F2160
G1 X72.754 Y79.21 E.00029
G1 F2520
G1 X72.754 Y90.79 E.21638
G1 F2160
G1 X72.738 Y90.79 E.00029
G1 F1800
G1 X57.322 Y90.79 E.28807
; WIPE_START
M204 S6000
G1 X57.246 Y90.79 E-.01072
G1 X57.246 Y88.865 E-.27428
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
G1 X0 Y85 ; move to safe pos
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




G1 X61.499 Y87.553
G1 Z2.6
G1 E.3 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F3124
M204 S6000
G1 X61.499 Y85.856 E.03412
G1 X61.358 Y85.77 E.00333
G1 X60.448 Y85.47 E.01927
G1 X59.993 Y85.457 E.00916
G1 X59.538 Y85.754 E.01093
G1 X59.082 Y86.512 E.01778
G1 X58.627 Y87.173 E.01615
G1 X58.443 Y87.345 E.00507
G1 X58.443 Y84.47 E.05782
G1 X58.627 Y84.53 E.00391
G1 X59.082 Y84.543 E.00916
G1 X59.538 Y84.246 E.01093
G1 X59.993 Y83.488 E.01778
G1 X60.448 Y82.827 E.01615
G1 X60.903 Y82.403 E.01251
G1 X61.358 Y82.128 E.01069
G1 X61.499 Y82.072 E.00305
G1 X61.499 Y80.801 E.02556
G1 X61.074 Y80.801 E.00856
; WIPE_START
G1 F6000
G1 X61.499 Y80.801 E-.06067
G1 X61.499 Y82.072 E-.18115
G1 X61.358 Y82.128 E-.02161
G1 X61.229 Y82.206 E-.02157
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X62.469 Y80.15 Z3 F18000
G1 Z2.6
G1 E.3 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.663042
G1 F2400
M204 S6000
G1 X67.531 Y80.15 E.15291
; WIPE_START
G1 X65.531 Y80.15 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X69.22 Y80.801 Z3 F18000
G1 Z2.6
G1 E.3 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F3124
M204 S6000
G1 X70.11 Y80.801 E.01789
G1 X69.958 Y80.406 E.00849
M73 P54 R9
G1 X70.343 Y80.406 E.00774
G1 X70.462 Y80.605 E.00465
G1 X70.835 Y80.882 E.00935
G1 X71.209 Y80.91 E.00752
G1 X71.557 Y80.826 E.00722
G1 X71.557 Y83.723 E.05826
G1 X71.209 Y83.324 E.01065
G1 X70.462 Y82.112 E.02862
G1 X70.007 Y81.816 E.01093
G1 X69.552 Y81.828 E.00916
G1 X68.642 Y82.128 E.01927
G1 X68.501 Y82.213 E.00331
G1 X68.501 Y85.723 E.07058
G1 X68.642 Y85.77 E.00298
G1 X69.097 Y86.044 E.01069
G1 X69.552 Y86.468 E.01251
G1 X70.007 Y87.13 E.01615
G1 X70.462 Y87.888 E.01778
G1 X70.835 Y88.165 E.00935
G1 X71.163 Y88.19 E.0066
G1 X71.163 Y88.853 E.01335
G1 X71.557 Y89.261 E.01141
G1 X71.557 Y89.594 E.00668
G1 X70.419 Y89.594 E.02288
G1 X70.555 Y89.522 E.00309
G1 X70.476 Y89.2 E.00668
G1 X70.162 Y89.2 E.00631
G1 X70.007 Y89.099 E.00371
G1 X69.552 Y89.111 E.00916
G1 X69.284 Y89.199 E.00567
G1 X68.501 Y89.199 E.01576
G1 X68.501 Y88.286 E.01837
; WIPE_START
G1 F6000
G1 X68.501 Y89.199 E-.13016
G1 X69.284 Y89.199 E-.11166
G1 X69.552 Y89.111 E-.04016
G1 X69.573 Y89.111 E-.00301
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X67.531 Y89.85 Z3 F18000
G1 Z2.6
G1 E.3 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.663042
G1 F2400
M204 S6000
G1 X62.469 Y89.85 E.15291
; WIPE_START
G1 X64.469 Y89.85 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X71.496 Y86.871 Z3 F18000
G1 X71.541 Y86.852 Z3
G1 Z2.6
G1 E.3 F1800
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.365752
G1 F3124
M204 S6000
G1 X71.568 Y87.192 E.0055
G1 X71.568 Y88.255 E.01713
G1 X71.545 Y88.64 E.00622
; WIPE_START
G1 F3840
G1 X71.568 Y88.255 E-.06149
G1 X71.568 Y87.192 E-.16918
G1 X71.541 Y86.852 E-.05433
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X69.559 Y80.422 Z3 F18000
G1 Z2.6
G1 E.3 F1800
G1 F3124
M204 S6000
G1 X68.289 Y80.422 E.02047
; LINE_WIDTH: 0.378302
G1 X68.22 Y80.436 E.00118
; LINE_WIDTH: 0.395035
G1 X68.151 Y80.451 E.00123
G1 X68.122 Y80.589 E.00247
; LINE_WIDTH: 0.365752
G1 X68.122 Y89.411 E.14217
; LINE_WIDTH: 0.378302
G1 X68.136 Y89.48 E.00118
; LINE_WIDTH: 0.395036
G1 X68.151 Y89.549 E.00123
G1 X68.289 Y89.578 E.00247
; LINE_WIDTH: 0.365752
G1 X69.85 Y89.578 E.02516
; WIPE_START
G1 F3840
G1 X68.289 Y89.578 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X62.959 Y84.115 Z3 F18000
G1 X59.357 Y80.422 Z3
G1 Z2.6
G1 E.3 F1800
G1 F3124
M204 S6000
G1 X61.711 Y80.422 E.03795
; LINE_WIDTH: 0.378302
G1 X61.78 Y80.436 E.00118
; LINE_WIDTH: 0.395035
G1 X61.849 Y80.451 E.00123
G1 X61.878 Y80.589 E.00247
; LINE_WIDTH: 0.365752
G1 X61.878 Y89.411 E.14217
; LINE_WIDTH: 0.378302
G1 X61.864 Y89.48 E.00118
; LINE_WIDTH: 0.395036
G1 X61.849 Y89.549 E.00123
G1 X61.711 Y89.578 E.00247
; LINE_WIDTH: 0.365752
G1 X60.627 Y89.578 E.01747
; CHANGE_LAYER
; Z_HEIGHT: 2.72
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F3840
G1 X61.711 Y89.578 E-.285
; WIPE_END
G1 E-.015 F1800
; layer num/total_layer_count: 22/74
; update layer progress
M73 L22
M991 S0 P21 ;notify layer change
M106 S71.4
; OBJECT_ID: 8
M204 S10000
G17
G3 Z3 I1.203 J.186 P1  F18000
G1 X63.09 Y80.681 Z3
G1 Z2.72
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F3600
M204 S6000
G1 X67.319 Y80.681 E.08504
G1 X67.319 Y89.319 E.1737
G1 X62.681 Y89.319 E.09327
G1 X62.681 Y80.681 E.1737
G1 X63.03 Y80.681 E.00702
M204 S250
G1 X63.09 Y81.09 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1800
M204 S5000
G1 X66.91 Y81.09 E.07138
G1 X66.91 Y88.91 E.14612
G1 X63.09 Y88.91 E.07138
G1 X63.09 Y81.15 E.145
M204 S10000
G1 X62.257 Y81.09 F18000
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F3600
M204 S6000
G1 X62.257 Y89.957 E.17828
G1 X58.026 Y89.957 E.08506
G1 X58.026 Y80.043 E.19933
G1 X62.257 Y80.043 E.08506
G1 X62.257 Y81.03 E.01984
; WIPE_START
G1 X62.257 Y83.03 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X66.996 Y89.013 Z3.12 F18000
G1 X67.743 Y89.957 Z3.12
G1 Z2.72
G1 E.3 F1800
G1 F3600
M204 S6000
G1 X67.743 Y80.043 E.19933
G1 X71.974 Y80.043 E.08506
G1 X71.973 Y89.957 E.19933
G1 X67.803 Y89.957 E.08385
; WIPE_START
G1 X67.791 Y87.957 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X60.366 Y89.723 Z3.12 F18000
G1 X57.602 Y90.381 Z3.12
G1 Z2.72
G1 E.3 F1800
G1 F3600
M204 S6000
G1 X57.602 Y79.619 E.21639
G1 X72.398 Y79.619 E.2975
G1 X72.398 Y90.381 E.21639
G1 X57.662 Y90.381 E.2963
M204 S250
G1 X57.205 Y90.79 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1980
M204 S5000
G1 X57.193 Y90.79 E.00023
G1 F2340
G1 X57.193 Y79.21 E.21638
G1 F1980
G1 X57.205 Y79.21 E.00023
M106 S229.5
G1 F1800
G1 X72.795 Y79.21 E.2913
G1 F1980
G1 X72.807 Y79.21 E.00023
G1 F2340
G1 X72.807 Y90.79 E.21638
G1 F1980
M73 P54 R8
G1 X72.795 Y90.79 E.00023
G1 F1800
G1 X57.265 Y90.79 E.29017
; WIPE_START
M204 S6000
G1 X57.193 Y90.79 E-.01033
G1 X57.193 Y88.862 E-.27467
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
G1 X0 Y85 ; move to safe pos
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




G1 X58.389 Y89.077
G1 Z2.72
G1 E.3 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F6000
M204 S6000
G1 X58.389 Y87.381 E.03412
G1 X58.627 Y87.128 E.00697
G1 X58.903 Y86.638 E.01132
G1 X58.687 Y86.129 E.01111
G1 X59.037 Y85.545 E.01369
G1 X59.403 Y85.113 E.0114
G1 X59.71 Y84.967 E.00683
G1 X59.645 Y84.514 E.0092
G1 X59.538 Y84.773 E.00563
G1 X59.082 Y84.822 E.00921
G1 X58.627 Y84.681 E.00958
G1 X58.389 Y84.577 E.00523
G1 X58.389 Y82.88 E.03412
; WIPE_START
G1 X58.389 Y84.577 E-.24182
G1 X58.627 Y84.681 E-.03704
G1 X58.668 Y84.694 E-.00613
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X59.087 Y85.918 Z3.12 F18000
G1 Z2.72
G1 E.3 F1800
; FEATURE: Bridge
; LINE_WIDTH: 0.42815
; LAYER_HEIGHT: 0.4
G1 F2500.465
M204 S6000
G1 X60.648 Y89.581 E.22638
G1 X61.167 Y89.581 E.02955
G1 X59.502 Y85.673 E.24156
G1 X59.676 Y85.467 E.0153
G1 X59.891 Y85.365 E.01353
G1 X61.687 Y89.581 E.26055
G1 X61.881 Y89.581 E.01101
G1 X61.881 Y88.815 E.04352
G1 X60.107 Y84.651 E.25738
G1 X59.928 Y83.409 E.07136
G1 X60.03 Y83.251 E.01071
G1 X61.881 Y87.596 E.26855
G1 X61.881 Y86.376 E.06937
G1 X60.342 Y82.764 E.22322
G1 X60.388 Y82.693 E.00482
G1 X59.419 Y80.419 E.14054
G1 X59.863 Y80.419 E.02522
G1 X61.881 Y85.156 E.29277
G1 X61.881 Y83.936 E.06937
G1 X60.382 Y80.419 E.21737
G1 X60.902 Y80.419 E.02955
G1 X61.881 Y82.716 E.14196
G1 X61.881 Y81.496 E.06937
G1 X61.336 Y80.217 E.07908
M106 S71.4
M106 S229.5
; WIPE_START
G1 X61.881 Y81.496 E-.19817
G1 X61.881 Y82.105 E-.08683
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X62.469 Y80.15 Z3.12 F18000
G1 Z2.72
G1 E.3 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.663042
; LAYER_HEIGHT: 0.12
G1 F2400
M204 S6000
G1 X67.531 Y80.15 E.15291
; WIPE_START
G1 X65.531 Y80.15 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X69.411 Y80.217 Z3.12 F18000
G1 Z2.72
G1 E.3 F1800
; FEATURE: Bridge
; LINE_WIDTH: 0.41181
; LAYER_HEIGHT: 0.4
M73 P55 R8
G1 F2702.831
M204 S6000
G1 X70.095 Y82.001 E.10054
G1 X69.681 Y82.16 E.02336
G1 X71.598 Y87.161 E.28173
G1 X71.598 Y87.21 E.00261
G1 X68.994 Y80.419 E.38262
G1 X68.499 Y80.419 E.02602
G1 X71.598 Y88.5 E.4553
G1 X71.598 Y88.674 E.00914
G1 X71.272 Y88.338 E.02461
G1 X71.078 Y88.434 E.01143
G1 X68.119 Y80.718 E.43474
G1 X68.119 Y82.008 E.06786
G1 X70.662 Y88.639 E.37363
G1 X70.389 Y88.774 E.016
G1 X70.437 Y89.091 E.01685
G1 X70.356 Y89.133 E.00476
G1 X68.119 Y83.298 E.32876
G1 X68.119 Y84.588 E.06786
G1 X69.945 Y89.349 E.26826
G1 X69.849 Y89.399 E.00567
G1 X69.851 Y89.581 E.00956
G1 X69.539 Y89.581 E.01642
G1 X68.119 Y85.878 E.20864
G1 X68.119 Y87.168 E.06786
G1 X69.044 Y89.581 E.13597
G1 X68.55 Y89.581 E.02602
G1 X67.917 Y87.929 E.09304
M106 S71.4
; WIPE_START
G1 X68.55 Y89.581 E-.25203
G1 X68.781 Y89.581 E-.03297
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X67.531 Y89.85 Z3.12 F18000
G1 Z2.72
G1 E.3 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.663042
; LAYER_HEIGHT: 0.12
G1 F2400
M204 S6000
G1 X62.469 Y89.85 E.15291
; WIPE_START
G1 X64.469 Y89.85 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X69.105 Y83.787 Z3.12 F18000
G1 X70.536 Y81.914 Z3.12
G1 Z2.72
G1 E.3 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F6000
M204 S6000
G1 X70.408 Y81.58 E.00721
G1 X70.462 Y81.585 E.0011
G1 X70.835 Y82.484 E.01956
G1 X71.209 Y83.243 E.01701
G1 X71.611 Y83.763 E.01322
G1 X71.611 Y80.94 E.05676
G1 X71.209 Y81.095 E.00866
G1 X70.835 Y81.201 E.0078
G1 X70.462 Y81.132 E.00763
G1 X70.16 Y80.406 E.0158
G1 X71.611 Y80.406 E.02917
G1 X71.611 Y80.653 E.00495
; CHANGE_LAYER
; Z_HEIGHT: 2.84
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F6000
G1 X71.611 Y80.406 E-.0351
G1 X70.16 Y80.406 E-.20672
G1 X70.277 Y80.686 E-.04318
; WIPE_END
G1 E-.015 F1800
; layer num/total_layer_count: 23/74
; update layer progress
M73 L23
M991 S0 P22 ;notify layer change
M106 S73.95
; OBJECT_ID: 8
M204 S10000
G17
G3 Z3.12 I.001 J-1.217 P1  F18000
G1 X63.09 Y80.681 Z3.12
G1 Z2.84
G1 E.3 F1800
; FEATURE: Inner wall
G1 F3600
M204 S6000
G1 X67.319 Y80.681 E.08504
G1 X67.319 Y89.319 E.1737
G1 X62.681 Y89.319 E.09327
G1 X62.681 Y80.681 E.1737
G1 X63.03 Y80.681 E.00702
M204 S250
G1 X63.09 Y81.09 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1800
M204 S5000
G1 X66.91 Y81.09 E.07138
G1 X66.91 Y88.91 E.14612
G1 X63.09 Y88.91 E.07138
G1 X63.09 Y81.15 E.145
M204 S10000
G1 X62.257 Y81.09 F18000
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F3600
M204 S6000
G1 X62.257 Y89.957 E.17828
G1 X57.976 Y89.957 E.08608
G1 X57.976 Y80.043 E.19933
G1 X62.257 Y80.043 E.08608
G1 X62.257 Y81.03 E.01984
; WIPE_START
G1 X62.257 Y83.03 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X66.996 Y89.013 Z3.24 F18000
G1 X67.743 Y89.957 Z3.24
G1 Z2.84
G1 E.3 F1800
G1 F3600
M204 S6000
G1 X67.743 Y80.043 E.19933
G1 X72.024 Y80.043 E.08608
G1 X72.024 Y89.957 E.19933
G1 X67.803 Y89.957 E.08487
; WIPE_START
G1 X67.791 Y87.957 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X60.364 Y89.715 Z3.24 F18000
G1 X57.551 Y90.381 Z3.24
G1 Z2.84
G1 E.3 F1800
G1 F3600
M204 S6000
G1 X57.551 Y79.619 E.21639
G1 X72.449 Y79.619 E.29955
G1 X72.449 Y90.381 E.21639
G1 X57.611 Y90.381 E.29834
M204 S250
G1 X57.152 Y90.79 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1980
M204 S5000
G1 X57.142 Y90.79 E.00018
G1 F2160
G1 X57.142 Y79.21 E.21638
G1 F1980
G1 X57.152 Y79.21 E.00018
G1 F1800
G1 X72.848 Y79.21 E.29329
G1 F1980
G1 X72.858 Y79.21 E.00019
G1 F2160
G1 X72.858 Y90.79 E.21638
G1 F1980
G1 X72.848 Y90.79 E.00018
G1 F1800
G1 X57.212 Y90.79 E.29217
; WIPE_START
M204 S6000
G1 X57.142 Y90.79 E-.00996
G1 X57.142 Y88.86 E-.27504
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
G1 X0 Y85 ; move to safe pos
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




G1 X58.338 Y89.137
G1 Z2.84
G1 E.3 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F6000
M204 S6000
G1 X58.338 Y87.44 E.03412
G1 X58.495 Y87.276 E.00457
G1 X58.777 Y86.821 E.01076
G1 X59.095 Y85.91 E.01939
G1 X59.126 Y85.455 E.00917
G1 X58.847 Y85 E.01073
G1 X58.338 Y84.707 E.01181
G1 X58.338 Y83.01 E.03412
; WIPE_START
G1 X58.338 Y84.707 E-.24182
G1 X58.601 Y84.858 E-.04318
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X62.469 Y80.15 Z3.24 F18000
G1 Z2.84
G1 E.3 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.663042
G1 F2400
M204 S6000
G1 X67.531 Y80.15 E.15291
; WIPE_START
G1 X65.531 Y80.15 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X70.114 Y81.434 Z3.24 F18000
G1 Z2.84
G1 E.3 F1800
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.419992
G1 F3840
M204 S6000
G1 X70.114 Y80.453 E.01833
G1 X68.153 Y80.453 E.03665
G1 X68.153 Y89.547 E.16993
G1 X70.114 Y89.547 E.03665
G1 X70.114 Y81.494 E.15049
M204 S10000
G1 X69.72 Y81.434 F18000
G1 F3840
M204 S6000
G1 X69.72 Y80.847 E.01096
G1 X68.547 Y80.847 E.02192
G1 X68.547 Y89.153 E.1552
G1 X69.72 Y89.153 E.02192
G1 X69.72 Y81.494 E.14312
M204 S10000
G1 X69.328 Y81.434 F18000
; LINE_WIDTH: 0.415242
G1 F3840
M204 S6000
G1 X69.328 Y81.239 E.0036
G1 X68.939 Y81.239 E.00719
G1 X68.939 Y88.761 E.13886
G1 X69.328 Y88.761 E.00719
G1 X69.328 Y81.494 E.13416
; WIPE_START
G1 X69.328 Y83.494 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X70.624 Y80.406 Z3.24 F18000
G1 Z2.84
G1 E.3 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F6000
M204 S6000
G1 X71.662 Y80.406 E.02087
G1 X71.662 Y81.065 E.01325
G1 X71.153 Y81.358 E.01181
G1 X70.874 Y81.814 E.01073
G1 X70.905 Y82.269 E.00917
G1 X71.223 Y83.179 E.01939
G1 X71.505 Y83.634 E.01076
G1 X71.662 Y83.799 E.00457
G1 X71.661 Y88.349 E.09148
G1 X71.153 Y88.642 E.01181
G1 X70.874 Y89.097 E.01073
G1 X70.92 Y89.594 E.01003
G1 X70.524 Y89.594 E.00797
G1 X70.524 Y88.293 E.02615
; WIPE_START
G1 X70.524 Y89.594 E-.18533
G1 X70.92 Y89.594 E-.05649
G1 X70.892 Y89.292 E-.04318
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X67.531 Y89.85 Z3.24 F18000
M73 P56 R8
G1 Z2.84
G1 E.3 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.663042
G1 F2400
M204 S6000
G1 X62.469 Y89.85 E.15291
M204 S10000
G1 X61.847 Y89.547 F18000
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.419992
G1 F3840
M204 S6000
G1 X61.847 Y80.453 E.16993
G1 X59.885 Y80.453 E.03667
G1 X59.885 Y89.547 E.16993
G1 X61.787 Y89.547 E.03554
; WIPE_START
G1 X59.885 Y89.547 E-.27103
G1 X59.885 Y89.449 E-.01397
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X61.35 Y81.959 Z3.24 F18000
G1 X61.453 Y81.434 Z3.24
G1 Z2.84
G1 E.3 F1800
G1 F3840
M204 S6000
G1 X61.453 Y80.847 E.01097
G1 X60.279 Y80.847 E.02194
G1 X60.28 Y89.153 E.1552
G1 X61.453 Y89.153 E.02193
G1 X61.453 Y81.494 E.14311
M204 S10000
G1 X61.061 Y81.434 F18000
; LINE_WIDTH: 0.415562
G1 F3840
M204 S6000
G1 X61.061 Y81.239 E.0036
G1 X60.671 Y81.239 E.0072
G1 X60.671 Y88.761 E.13897
G1 X61.061 Y88.761 E.0072
G1 X61.061 Y81.494 E.13426
; CHANGE_LAYER
; Z_HEIGHT: 2.96
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F3840
G1 X61.061 Y83.494 E-.285
; WIPE_END
G1 E-.015 F1800
; layer num/total_layer_count: 24/74
; update layer progress
M73 L24
M991 S0 P23 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z3.24 I.987 J.712 P1  F18000
G1 X63.09 Y80.681 Z3.24
G1 Z2.96
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F3600
M204 S6000
G1 X67.319 Y80.681 E.08504
G1 X67.319 Y89.319 E.1737
G1 X62.681 Y89.319 E.09327
G1 X62.681 Y80.681 E.1737
G1 X63.03 Y80.681 E.00702
M204 S250
G1 X63.09 Y81.09 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1800
M204 S5000
G1 X66.91 Y81.09 E.07138
G1 X66.91 Y88.91 E.14612
G1 X63.09 Y88.91 E.07138
G1 X63.09 Y81.15 E.145
M204 S10000
G1 X62.257 Y81.09 F18000
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F3600
M204 S6000
G1 X62.257 Y89.957 E.17828
G1 X57.927 Y89.957 E.08705
G1 X57.927 Y80.043 E.19933
G1 X62.257 Y80.043 E.08705
G1 X62.257 Y81.03 E.01984
; WIPE_START
G1 X62.257 Y83.03 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X66.996 Y89.013 Z3.36 F18000
G1 X67.743 Y89.957 Z3.36
G1 Z2.96
G1 E.3 F1800
G1 F3600
M204 S6000
G1 X67.743 Y80.043 E.19933
G1 X72.073 Y80.043 E.08705
G1 X72.073 Y89.957 E.19933
G1 X67.803 Y89.957 E.08584
; WIPE_START
G1 X67.791 Y87.957 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X60.362 Y89.707 Z3.36 F18000
G1 X57.503 Y90.381 Z3.36
G1 Z2.96
G1 E.3 F1800
G1 F3600
M204 S6000
G1 X57.503 Y79.619 E.21639
G1 X72.497 Y79.619 E.30149
G1 X72.497 Y90.381 E.21639
G1 X57.563 Y90.381 E.30028
M204 S250
G1 X57.101 Y90.79 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1800
M204 S5000
G1 X57.094 Y90.79 E.00014
G1 F1980
G1 X57.094 Y79.21 E.21638
G1 F1800
G1 X57.101 Y79.21 E.00014
G1 X72.899 Y79.21 E.29519
G1 X72.906 Y79.21 E.00013
G1 F1980
G1 X72.906 Y90.79 E.21638
G1 F1800
G1 X72.899 Y90.79 E.00014
G1 X57.161 Y90.79 E.29407
; WIPE_START
M204 S6000
G1 X57.094 Y90.79 E-.00959
G1 X57.094 Y88.857 E-.27541
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
G1 X0 Y85 ; move to safe pos
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




G1 X58.29 Y89.21
G1 Z2.96
G1 E.3 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F6000
M204 S6000
G1 X58.29 Y87.513 E.03412
G1 X58.489 Y87.276 E.00622
G1 X58.733 Y86.821 E.01039
G1 X58.959 Y85.91 E.01886
G1 X58.905 Y85.455 E.00922
G1 X58.563 Y85 E.01145
G1 X58.29 Y84.707 E.00805
G1 X58.29 Y83.01 E.03412
; WIPE_START
G1 X58.29 Y84.707 E-.24182
G1 X58.496 Y84.929 E-.04318
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X61.847 Y81.434 Z3.36 F18000
G1 Z2.96
G1 E.3 F1800
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.419992
G1 F3840
M204 S6000
G1 X61.847 Y80.453 E.01834
G1 X59.885 Y80.453 E.03667
G1 X59.885 Y89.547 E.16993
G1 X61.847 Y89.547 E.03666
G1 X61.847 Y81.494 E.15048
M204 S10000
G1 X61.453 Y81.434 F18000
G1 F3840
M204 S6000
G1 X61.453 Y80.847 E.01097
G1 X60.279 Y80.847 E.02194
G1 X60.28 Y89.153 E.1552
G1 X61.453 Y89.153 E.02193
G1 X61.453 Y81.494 E.14311
M204 S10000
G1 X61.061 Y81.434 F18000
; LINE_WIDTH: 0.415562
G1 F3840
M204 S6000
G1 X61.061 Y81.239 E.0036
G1 X60.671 Y81.239 E.0072
G1 X60.671 Y88.761 E.13897
G1 X61.061 Y88.761 E.0072
G1 X61.061 Y81.494 E.13426
; WIPE_START
G1 X61.061 Y83.494 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X62.469 Y80.15 Z3.36 F18000
G1 Z2.96
G1 E.3 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.663042
G1 F2400
M204 S6000
G1 X67.531 Y80.15 E.15291
; WIPE_START
G1 X65.531 Y80.15 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X70.114 Y81.434 Z3.36 F18000
G1 Z2.96
G1 E.3 F1800
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.419992
G1 F3840
M204 S6000
G1 X70.114 Y80.453 E.01833
G1 X68.153 Y80.453 E.03665
G1 X68.153 Y89.547 E.16993
G1 X70.114 Y89.547 E.03665
G1 X70.114 Y81.494 E.15049
M204 S10000
G1 X69.72 Y81.434 F18000
G1 F3840
M204 S6000
G1 X69.72 Y80.847 E.01096
G1 X68.547 Y80.847 E.02192
G1 X68.547 Y89.153 E.1552
G1 X69.72 Y89.153 E.02192
G1 X69.72 Y81.494 E.14312
M204 S10000
G1 X69.328 Y81.434 F18000
; LINE_WIDTH: 0.415242
G1 F3840
M204 S6000
G1 X69.328 Y81.239 E.0036
G1 X68.939 Y81.239 E.00719
G1 X68.939 Y88.761 E.13886
G1 X69.328 Y88.761 E.00719
G1 X69.328 Y81.494 E.13416
; WIPE_START
G1 X69.328 Y83.494 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X70.524 Y80.444 Z3.36 F18000
G1 Z2.96
G1 E.3 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F6000
M204 S6000
G1 X70.524 Y80.406 E.00076
M73 P57 R8
G1 X71.71 Y80.406 E.02385
G1 X71.71 Y80.879 E.00951
G1 X71.437 Y81.358 E.01108
G1 X71.095 Y81.814 E.01145
G1 X71.041 Y82.269 E.00922
G1 X71.267 Y83.179 E.01886
G1 X71.511 Y83.634 E.01039
G1 X71.71 Y83.872 E.00622
G1 X71.71 Y88.162 E.08628
G1 X71.437 Y88.642 E.01108
G1 X71.095 Y89.097 E.01145
G1 X71.041 Y89.552 E.00922
G1 X71.051 Y89.594 E.00086
G1 X70.524 Y89.594 E.01061
G1 X70.524 Y88.424 E.02351
; WIPE_START
G1 X70.524 Y89.594 E-.16665
G1 X71.051 Y89.594 E-.07517
G1 X71.041 Y89.552 E-.00612
G1 X71.072 Y89.294 E-.03706
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X67.531 Y89.85 Z3.36 F18000
G1 Z2.96
G1 E.3 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.663042
G1 F2400
M204 S6000
G1 X62.469 Y89.85 E.15291
; CHANGE_LAYER
; Z_HEIGHT: 3.08
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F2400
G1 X64.469 Y89.85 E-.285
; WIPE_END
G1 E-.015 F1800
; layer num/total_layer_count: 25/74
; update layer progress
M73 L25
M991 S0 P24 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z3.36 I1.202 J-.189 P1  F18000
G1 X63.09 Y81.09 Z3.36
G1 Z3.08
G1 E.3 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
M204 S5000
G1 X66.91 Y81.09 E.07138
G1 X66.91 Y88.91 E.14612
G1 X63.09 Y88.91 E.07138
G1 X63.09 Y81.15 E.145
M204 S10000
G1 X62.257 Y81.09 F18000
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F3600
M204 S6000
G1 X62.257 Y89.957 E.17828
G1 X57.882 Y89.957 E.08797
G1 X57.882 Y80.043 E.19933
G1 X62.257 Y80.043 E.08797
G1 X62.257 Y81.03 E.01984
M204 S10000
G1 X63.09 Y80.681 F18000
G1 F3600
M204 S6000
G1 X62.681 Y80.681 E.00823
G1 X62.681 Y89.319 E.1737
G1 X63.172 Y89.319 E.00987
G1 X63.172 Y90.381 E.02134
G1 X57.457 Y90.381 E.1149
G1 X57.457 Y79.619 E.21639
G1 X63.172 Y79.619 E.1149
G1 X63.169 Y80.035 E.00836
G1 X63.172 Y80.681 E.01298
G1 X63.15 Y80.681 E.00044
; WIPE_START
G1 X62.681 Y80.681 E-.06687
G1 X62.681 Y82.212 E-.21813
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X66.857 Y88.6 Z3.48 F18000
G1 X67.743 Y89.957 Z3.48
G1 Z3.08
G1 E.3 F1800
G1 F3600
M204 S6000
G1 X67.743 Y80.043 E.19933
G1 X72.118 Y80.043 E.08797
G1 X72.118 Y89.957 E.19933
G1 X67.803 Y89.957 E.08676
; WIPE_START
G1 X67.791 Y87.957 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X66.825 Y90.381 Z3.48 F18000
G1 Z3.08
G1 E.3 F1800
G1 F3600
M204 S6000
G1 X66.824 Y89.319 E.02134
G1 X67.319 Y89.319 E.00996
G1 X67.319 Y80.681 E.1737
G1 X66.824 Y80.681 E.00996
G1 X66.825 Y79.619 E.02134
G1 X72.543 Y79.619 E.11496
G1 X72.543 Y90.381 E.21639
G1 X66.885 Y90.381 E.11375
; WIPE_START
G1 X66.824 Y89.319 E-.15152
G1 X67.319 Y89.319 E-.07056
G1 X67.319 Y88.878 E-.06292
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X59.816 Y90.275 Z3.48 F18000
G1 X57.053 Y90.79 Z3.48
G1 Z3.08
G1 E.3 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
M204 S5000
G1 X57.048 Y90.79 E.00009
G1 F1980
G1 X57.048 Y79.21 E.21638
G1 F1800
G1 X57.053 Y79.21 E.00009
G1 X72.947 Y79.21 E.29699
G1 X72.952 Y79.21 E.00009
G1 F1980
G1 X72.952 Y90.79 E.21638
G1 F1800
G1 X72.947 Y90.79 E.00009
G1 X57.113 Y90.79 E.29587
; WIPE_START
M204 S6000
G1 X57.048 Y90.79 E-.00923
G1 X57.048 Y88.855 E-.27578
; WIPE_END
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
G1 X0 Y85 ; move to safe pos
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




G1 X58.244 Y89.308
G1 Z3.08
G1 E.3 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F6000
M204 S6000
G1 X58.244 Y87.611 E.03412
G1 X58.49 Y87.276 E.00836
G1 X58.698 Y86.821 E.01006
G1 X58.814 Y86.366 E.00945
G1 X58.84 Y85.91 E.00917
G1 X58.726 Y85.455 E.00944
G1 X58.244 Y84.837 E.01576
G1 X58.244 Y83.14 E.03412
; WIPE_START
G1 X58.244 Y84.837 E-.24182
G1 X58.431 Y85.076 E-.04318
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X61.847 Y81.434 Z3.48 F18000
G1 Z3.08
G1 E.3 F1800
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.419992
G1 F3840
M204 S6000
G1 X61.847 Y80.453 E.01834
G1 X59.885 Y80.453 E.03667
G1 X59.885 Y89.547 E.16993
G1 X61.847 Y89.547 E.03666
G1 X61.847 Y81.494 E.15048
M204 S10000
G1 X61.453 Y81.434 F18000
G1 F3840
M204 S6000
G1 X61.453 Y80.847 E.01097
G1 X60.279 Y80.847 E.02194
G1 X60.28 Y89.153 E.1552
G1 X61.453 Y89.153 E.02193
G1 X61.453 Y81.494 E.14311
M204 S10000
G1 X61.061 Y81.434 F18000
; LINE_WIDTH: 0.415562
G1 F3840
M204 S6000
G1 X61.061 Y81.239 E.0036
G1 X60.671 Y81.239 E.0072
G1 X60.671 Y88.761 E.13897
G1 X61.061 Y88.761 E.0072
G1 X61.061 Y81.494 E.13426
; WIPE_START
G1 X61.061 Y83.494 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X66.588 Y80.177 Z3.48 F18000
G1 Z3.08
G1 E.3 F1800
; FEATURE: Top surface
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X65.838 Y79.427 E.01982
G1 X65.281 Y79.427
G1 X66.593 Y80.738 E.03466
G1 X66.17 Y80.873
G1 X64.723 Y79.427 E.03822
G1 X64.166 Y79.427
G1 X65.612 Y80.873 E.03822
G1 X65.055 Y80.873
G1 X63.608 Y79.427 E.03822
G1 X63.402 Y79.779
G1 X64.497 Y80.873 E.02893
G1 X63.94 Y80.873
G1 X63.402 Y80.336 E.0142
; WIPE_START
M204 S6000
G1 X63.94 Y80.873 E-.10829
G1 X64.497 Y80.873 E-.07945
G1 X64.014 Y80.391 E-.09726
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X70.114 Y81.434 Z3.48 F18000
G1 Z3.08
G1 E.3 F1800
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.419992
G1 F3840
M204 S6000
G1 X70.114 Y80.453 E.01833
G1 X68.153 Y80.453 E.03665
G1 X68.153 Y89.547 E.16993
G1 X70.114 Y89.547 E.03665
G1 X70.114 Y81.494 E.15049
M204 S10000
G1 X69.72 Y81.434 F18000
G1 F3840
M204 S6000
G1 X69.72 Y80.847 E.01096
G1 X68.547 Y80.847 E.02192
G1 X68.547 Y89.153 E.1552
G1 X69.72 Y89.153 E.02192
G1 X69.72 Y81.494 E.14312
M204 S10000
G1 X69.328 Y81.434 F18000
; LINE_WIDTH: 0.415242
G1 F3840
M204 S6000
G1 X69.328 Y81.239 E.0036
G1 X68.939 Y81.239 E.00719
G1 X68.939 Y88.761 E.13886
G1 X69.328 Y88.761 E.00719
G1 X69.328 Y81.494 E.13416
; WIPE_START
G1 X69.328 Y83.494 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X70.678 Y80.406 Z3.48 F18000
G1 Z3.08
G1 E.3 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F6000
M204 S6000
G1 X71.756 Y80.406 E.02167
G1 X71.756 Y81.026 E.01245
G1 X71.641 Y81.358 E.00708
G1 X71.274 Y81.814 E.01176
G1 X71.16 Y82.269 E.00944
G1 X71.186 Y82.724 E.00917
G1 X71.302 Y83.179 E.00945
G1 X71.51 Y83.634 E.01006
G1 X71.756 Y83.97 E.00836
G1 X71.756 Y88.309 E.08725
G1 X71.641 Y88.642 E.00708
G1 X71.274 Y89.097 E.01176
G1 X71.162 Y89.594 E.01024
G1 X70.524 Y89.594 E.01284
G1 X70.524 Y88.535 E.02128
; WIPE_START
G1 X70.524 Y89.594 E-.15083
G1 X71.162 Y89.594 E-.09099
M73 P58 R8
G1 X71.229 Y89.298 E-.04318
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X66.59 Y89.656 Z3.48 F18000
G1 Z3.08
G1 E.3 F1800
; FEATURE: Top surface
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X66.06 Y89.127 E.01399
G1 X65.503 Y89.127
G1 X66.591 Y90.215 E.02876
G1 X66.392 Y90.573
G1 X64.945 Y89.127 E.03822
G1 X64.388 Y89.127
G1 X65.834 Y90.573 E.03822
G1 X65.276 Y90.573
G1 X63.83 Y89.127 E.03822
G1 X63.404 Y89.258
G1 X64.719 Y90.573 E.03475
G1 X64.161 Y90.573
G1 X63.402 Y89.813 E.02008
; CHANGE_LAYER
; Z_HEIGHT: 3.2
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F3600
M204 S6000
G1 X64.161 Y90.573 E-.15313
G1 X64.719 Y90.573 E-.07945
G1 X64.459 Y90.313 E-.05242
; WIPE_END
G1 E-.015 F1800
; layer num/total_layer_count: 26/74
; update layer progress
M73 L26
M991 S0 P25 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z3.48 I1.107 J.506 P1  F18000
G1 X69.153 Y80.043 Z3.48
G1 Z3.2
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F3600
M204 S6000
G1 X72.162 Y80.043 E.06051
G1 X72.162 Y89.957 E.19933
G1 X69.153 Y89.957 E.06051
G1 X69.153 Y80.103 E.19812
M204 S10000
G1 X68.728 Y79.619 F18000
G1 F3600
M204 S6000
G1 X72.586 Y79.619 E.07757
G1 X72.586 Y90.381 E.21639
G1 X68.728 Y90.381 E.07757
G1 X68.728 Y79.679 E.21518
; WIPE_START
G1 X70.728 Y79.648 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X66.91 Y81.09 Z3.6 F18000
G1 Z3.2
G1 E.3 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
M204 S5000
G1 X65.68 Y81.09 E.02298
G1 X65.678 Y79.21 E.03513
G1 X72.993 Y79.21 E.13668
G1 X72.995 Y90.79 E.21638
G1 X72.993 Y90.79 E.00005
G1 X65.678 Y90.79 E.13668
G1 X65.68 Y88.91 E.03513
G1 X66.91 Y88.91 E.02298
G1 X66.91 Y81.15 E.145
; WIPE_START
M204 S6000
G1 X65.68 Y81.09 E-.17549
G1 X65.679 Y80.322 E-.10951
; WIPE_END
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
G1 X0 Y85 ; move to safe pos
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




G1 X71.062 Y80.406
G1 Z3.2
G1 E.3 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F6000
M204 S6000
G1 X71.799 Y80.406 E.01483
G1 X71.799 Y81.366 E.0193
G1 X71.425 Y81.814 E.01173
G1 X71.265 Y82.269 E.0097
G1 X71.249 Y82.724 E.00916
G1 X71.33 Y83.179 E.00929
G1 X71.502 Y83.634 E.00978
G1 X71.792 Y84.09 E.01086
G1 X71.799 Y84.13 E.00082
G1 X71.799 Y88.649 E.09087
G1 X71.425 Y89.097 E.01173
G1 X71.264 Y89.594 E.01051
G1 X70.641 Y89.594 E.01252
G1 X70.65 Y89.57 E.0005
G1 X70.524 Y89.444 E.00361
G1 X70.524 Y88.574 E.01748
; WIPE_START
G1 X70.524 Y89.444 E-.12391
G1 X70.65 Y89.57 E-.02557
G1 X70.641 Y89.594 E-.00358
G1 X71.264 Y89.594 E-.08876
G1 X71.357 Y89.305 E-.04318
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X70.079 Y89.508 Z3.6 F18000
G1 Z3.2
G1 E.3 F1800
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.499172
G1 F3840
M204 S6000
G1 X70.075 Y80.504 E.20202
G1 X69.601 Y80.492 E.01063
G1 X69.601 Y89.508 E.20229
G1 X70.019 Y89.508 E.00936
; WIPE_START
G1 X69.601 Y89.508 E-.05945
G1 X69.601 Y87.925 E-.22555
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X68.496 Y90.145 Z3.6 F18000
G1 Z3.2
G1 E.3 F1800
; FEATURE: Top surface
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X68.069 Y90.573 E.0113
G1 X67.511 Y90.573
G1 X68.496 Y89.588 E.02604
G1 X68.496 Y89.03
G1 X66.954 Y90.573 E.04077
G1 X66.396 Y90.573
G1 X68.496 Y88.473 E.0555
G1 X68.496 Y87.915
G1 X65.895 Y90.517 E.06874
G1 X65.896 Y89.958
G1 X66.727 Y89.127 E.02198
G1 X67.127 Y88.727
G1 X68.496 Y87.358 E.03619
G1 X68.496 Y86.8
G1 X67.127 Y88.17 E.03619
G1 X67.127 Y87.612
G1 X68.496 Y86.243 E.03619
G1 X68.496 Y85.685
G1 X67.127 Y87.055 E.03619
G1 X67.127 Y86.497
G1 X68.496 Y85.128 E.03619
G1 X68.496 Y84.57
G1 X67.127 Y85.94 E.03619
G1 X67.127 Y85.382
G1 X68.496 Y84.012 E.03619
G1 X68.496 Y83.455
G1 X67.127 Y84.824 E.03619
G1 X67.127 Y84.267
G1 X68.496 Y82.897 E.03619
G1 X68.496 Y82.34
G1 X67.127 Y83.709 E.03619
G1 X67.127 Y83.152
G1 X68.496 Y81.782 E.03619
G1 X68.496 Y81.225
G1 X67.127 Y82.594 E.03619
G1 X67.127 Y82.037
G1 X68.496 Y80.667 E.03619
G1 X68.496 Y80.11
G1 X67.127 Y81.479 E.03619
G1 X67.127 Y80.922
G1 X68.496 Y79.552 E.03619
G1 X68.064 Y79.427
G1 X66.618 Y80.873 E.03822
G1 X66.06 Y80.873
G1 X67.507 Y79.427 E.03822
G1 X66.949 Y79.427
G1 X65.896 Y80.48 E.02783
G1 X65.896 Y79.923
G1 X66.392 Y79.427 E.01311
; WIPE_START
M204 S6000
G1 X65.896 Y79.923 E-.09996
G1 X65.896 Y80.48 E-.07937
G1 X66.42 Y79.955 E-.10567
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X65.902 Y80.486 Z3.6 F18000
G1 Z3.2
G1 E.3 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.0774921
G1 F2400
M204 S6000
G1 X65.903 Y80.893 E.001
; WIPE_START
G1 X65.902 Y80.486 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X60.845 Y80.043 Z3.6 F18000
G1 Z3.2
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F3600
M204 S6000
G1 X60.849 Y81.639 E.03209
G1 X60.845 Y89.957 E.16724
G1 X57.838 Y89.957 E.06047
G1 X57.838 Y80.043 E.19933
G1 X60.785 Y80.043 E.05926
M204 S10000
G1 X61.27 Y79.619 F18000
G1 F3600
M204 S6000
G1 X61.273 Y79.864 E.00492
G1 X61.27 Y90.381 E.21147
G1 X57.414 Y90.381 E.07755
G1 X57.414 Y79.619 E.21639
G1 X61.21 Y79.619 E.07634
; WIPE_START
G1 X61.273 Y79.864 E-.036
G1 X61.273 Y81.611 E-.249
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X63.09 Y81.09 Z3.6 F18000
G1 Z3.2
G1 E.3 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
M204 S5000
G1 X63.09 Y88.91 E.14612
G1 X64.318 Y88.91 E.02294
G1 X64.314 Y90.79 E.03513
G1 X57.007 Y90.79 E.13654
G1 X57.007 Y79.21 E.21638
G1 X64.313 Y79.21 E.13651
G1 X64.317 Y81.09 E.03513
G1 X63.15 Y81.09 E.02181
; WIPE_START
M204 S6000
G1 X63.135 Y83.09 E-.285
; WIPE_END
G1 E-.015
M204 S10000
G1 X60.397 Y80.729 Z3.6 F18000
G1 Z3.2
G1 E.3 F1800
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.498527
G1 F3840
M204 S6000
G1 X60.397 Y80.492 E.0053
G1 X59.924 Y80.504 E.0106
G1 X59.924 Y89.272 E.19646
G1 X59.937 Y89.508 E.0053
G1 X60.397 Y89.508 E.01031
G1 X60.397 Y80.789 E.19538
; WIPE_START
G1 X60.397 Y82.789 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X58.201 Y83.311 Z3.6 F18000
G1 Z3.2
G1 E.3 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F6000
M204 S6000
G1 X58.201 Y85.008 E.03412
G1 X58.575 Y85.455 E.01173
G1 X58.735 Y85.91 E.0097
G1 X58.751 Y86.366 E.00916
G1 X58.67 Y86.821 E.00929
G1 X58.498 Y87.276 E.00978
G1 X58.201 Y87.744 E.01116
G1 X58.201 Y89.441 E.03412
; WIPE_START
G1 X58.201 Y87.744 E-.24182
G1 X58.363 Y87.489 E-.04318
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X63.608 Y90.573 Z3.6 F18000
G1 Z3.2
G1 E.3 F1800
; FEATURE: Top surface
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X64.099 Y90.083 E.01296
G1 X64.1 Y89.524
G1 X63.051 Y90.573 E.02772
G1 X62.493 Y90.573
G1 X63.94 Y89.127 E.03822
G1 X63.382 Y89.127
G1 X61.936 Y90.573 E.03822
G1 X61.502 Y90.45
G1 X62.873 Y89.078 E.03625
G1 X62.873 Y88.521
G1 X61.501 Y89.892 E.03625
G1 X61.502 Y89.335
G1 X62.873 Y87.963 E.03624
G1 X62.873 Y87.406
G1 X61.503 Y88.776 E.0362
G1 X61.504 Y88.217
G1 X62.873 Y86.848 E.03618
G1 X62.873 Y86.29
G1 X61.502 Y87.662 E.03625
G1 X61.502 Y87.104
G1 X62.873 Y85.733 E.03624
G1 X62.873 Y85.175
G1 X61.502 Y86.546 E.03623
G1 X61.502 Y85.989
G1 X62.873 Y84.618 E.03622
G1 X62.873 Y84.06
G1 X61.503 Y85.431 E.03621
G1 X61.503 Y84.873
G1 X62.873 Y83.503 E.0362
G1 X62.873 Y82.945
G1 X61.503 Y84.315 E.0362
G1 X61.504 Y83.757
M73 P59 R8
G1 X62.873 Y82.388 E.03619
G1 X62.873 Y81.83
G1 X61.503 Y83.2 E.0362
G1 X61.502 Y82.644
G1 X62.873 Y81.273 E.03623
G1 X63.273 Y80.873
G1 X64.098 Y80.048 E.02181
G1 X64.096 Y79.492
G1 X61.503 Y82.086 E.06854
G1 X61.505 Y81.526
G1 X63.604 Y79.427 E.05546
G1 X63.046 Y79.427
G1 X61.504 Y80.969 E.04077
G1 X61.502 Y80.413
G1 X62.489 Y79.427 E.02607
G1 X61.931 Y79.427
G1 X61.505 Y79.853 E.01126
; WIPE_START
M204 S6000
G1 X61.931 Y79.427 E-.08588
G1 X62.489 Y79.427 E-.07945
G1 X61.895 Y80.021 E-.11967
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X63.692 Y87.439 Z3.6 F18000
G1 X64.096 Y89.107 Z3.6
G1 Z3.2
G1 E.3 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.0747288
G1 F2400
M204 S6000
G1 X64.086 Y89.307 E.00046
; CHANGE_LAYER
; Z_HEIGHT: 3.32
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F2400
G1 X64.096 Y89.107 E-.285
; WIPE_END
G1 E-.015 F1800
; layer num/total_layer_count: 27/74
; update layer progress
M73 L27
M991 S0 P26 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z3.6 I-.171 J1.205 P1  F18000
G1 X70.078 Y89.957 Z3.6
G1 Z3.32
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F3265
M204 S6000
G1 X70.078 Y80.043 E.19933
G1 X72.203 Y80.043 E.04274
G1 X72.203 Y89.957 E.19933
G1 X70.138 Y89.957 E.04153
M204 S10000
G1 X69.654 Y90.381 F18000
G1 F3265
M204 S6000
G1 X69.654 Y79.619 E.21639
G1 X72.628 Y79.619 E.0598
G1 X72.628 Y90.381 E.21639
G1 X69.714 Y90.381 E.05859
; WIPE_START
G1 F3600
G1 X69.702 Y88.381 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X67.587 Y90.79 Z3.72 F18000
G1 Z3.32
G1 E.3 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
M204 S5000
G1 X67.587 Y79.21 E.21638
G1 X73.037 Y79.21 E.10182
G1 X73.037 Y90.79 E.21638
G1 X73.036 Y90.79 E.00001
G1 X67.647 Y90.79 E.1007
; WIPE_START
M204 S6000
G1 X67.637 Y88.79 E-.285
; WIPE_END
G1 E-.015
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
G1 X0 Y85 ; move to safe pos
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




G1 X70.441 Y88.811
G1 Z3.32
G1 E.3 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F3265
M204 S6000
G1 X70.441 Y89.594 E.01575
G1 X71.354 Y89.594 E.01837
G1 X71.558 Y89.097 E.0108
G1 X71.841 Y88.767 E.00873
G1 X71.841 Y84.306 E.0897
G1 X71.487 Y83.634 E.01526
G1 X71.35 Y83.179 E.00956
G1 X71.305 Y82.724 E.0092
G1 X71.359 Y82.269 E.00922
G1 X71.558 Y81.814 E.00999
G1 X71.841 Y81.484 E.00873
G1 X71.841 Y80.406 E.02167
G1 X71.222 Y80.406 E.01245
; WIPE_START
G1 F6000
G1 X71.841 Y80.406 E-.08824
G1 X71.841 Y81.484 E-.15359
G1 X71.643 Y81.714 E-.04318
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X68.626 Y79.427 Z3.72 F18000
G1 Z3.32
G1 E.3 F1800
; FEATURE: Top surface
; LINE_WIDTH: 0.42
G1 F3265
M204 S2000
G1 X69.422 Y80.222 E.02102
G1 X69.422 Y80.78
G1 X68.069 Y79.427 E.03575
G1 X67.804 Y79.72
G1 X69.422 Y81.337 E.04275
G1 X69.422 Y81.895
G1 X67.804 Y80.277 E.04275
G1 X67.804 Y80.835
G1 X69.422 Y82.452 E.04275
G1 X69.422 Y83.01
G1 X67.804 Y81.392 E.04275
G1 X67.804 Y81.95
G1 X69.422 Y83.568 E.04275
G1 X69.422 Y84.125
G1 X67.804 Y82.507 E.04275
G1 X67.804 Y83.065
G1 X69.422 Y84.683 E.04275
G1 X69.422 Y85.24
G1 X67.804 Y83.623 E.04275
G1 X67.804 Y84.18
G1 X69.422 Y85.798 E.04275
G1 X69.422 Y86.355
G1 X67.804 Y84.738 E.04275
G1 X67.804 Y85.295
G1 X69.422 Y86.913 E.04275
G1 X69.422 Y87.47
G1 X67.804 Y85.853 E.04275
G1 X67.804 Y86.41
G1 X69.422 Y88.028 E.04275
G1 X69.422 Y88.585
G1 X67.804 Y86.968 E.04275
G1 X67.804 Y87.525
G1 X69.422 Y89.143 E.04275
G1 X69.422 Y89.7
G1 X67.804 Y88.083 E.04275
G1 X67.804 Y88.64
G1 X69.422 Y90.258 E.04275
G1 X69.179 Y90.573
G1 X67.804 Y89.198 E.03634
G1 X67.804 Y89.755
G1 X68.622 Y90.573 E.02161
; WIPE_START
G1 F3600
M204 S6000
G1 X67.804 Y89.755 E-.16479
G1 X67.804 Y89.198 E-.07945
G1 X68.006 Y89.4 E-.04076
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X60.392 Y89.924 Z3.72 F18000
G1 X59.922 Y89.957 Z3.72
G1 Z3.32
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
M73 P59 R7
G1 F3265
M204 S6000
G1 X57.797 Y89.957 E.04273
G1 X57.797 Y80.043 E.19933
G1 X59.921 Y80.043 E.04272
G1 X59.922 Y89.897 E.19812
M204 S10000
G1 X60.346 Y90.381 F18000
G1 F3265
M204 S6000
G1 X57.372 Y90.381 E.0598
G1 X57.372 Y79.619 E.21639
G1 X60.345 Y79.619 E.05978
G1 X60.346 Y90.321 E.21518
; WIPE_START
G1 F3600
G1 X58.347 Y90.361 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X62.411 Y90.79 Z3.72 F18000
G1 Z3.32
G1 E.3 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
M204 S5000
G1 X56.964 Y90.79 E.1018
G1 X56.964 Y79.21 E.21638
G1 X62.411 Y79.21 E.10179
G1 X62.411 Y90.73 E.21526
; WIPE_START
M204 S6000
G1 X60.412 Y90.752 E-.285
; WIPE_END
G1 E-.015
M204 S10000
G1 X58.159 Y89.548 Z3.72 F18000
G1 Z3.32
G1 E.3 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F3265
M204 S6000
G1 X58.159 Y87.851 E.03412
G1 X58.263 Y87.731 E.00318
G1 X58.513 Y87.276 E.01044
G1 X58.65 Y86.821 E.00956
G1 X58.695 Y86.366 E.0092
G1 X58.641 Y85.91 E.00922
G1 X58.442 Y85.455 E.00999
G1 X58.159 Y85.126 E.00873
G1 X58.159 Y83.429 E.03412
; WIPE_START
G1 F6000
G1 X58.159 Y85.126 E-.24182
G1 X58.357 Y85.356 E-.04318
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X61.378 Y79.427 Z3.72 F18000
G1 Z3.32
G1 E.3 F1800
; FEATURE: Top surface
; LINE_WIDTH: 0.42
G1 F3265
M204 S2000
G1 X62.194 Y80.243 E.02157
G1 X62.194 Y80.801
G1 X60.821 Y79.427 E.0363
G1 X60.577 Y79.741
G1 X62.194 Y81.358 E.04273
G1 X62.194 Y81.916
G1 X60.577 Y80.299 E.04273
G1 X60.577 Y80.856
G1 X62.194 Y82.473 E.04273
G1 X62.194 Y83.031
G1 X60.577 Y81.414 E.04273
G1 X60.577 Y81.971
G1 X62.194 Y83.588 E.04273
G1 X62.194 Y84.146
G1 X60.578 Y82.529 E.04273
G1 X60.578 Y83.087
G1 X62.195 Y84.704 E.04273
G1 X62.195 Y85.261
G1 X60.578 Y83.644 E.04273
G1 X60.578 Y84.202
G1 X62.195 Y85.819 E.04273
G1 X62.195 Y86.376
G1 X60.578 Y84.759 E.04273
G1 X60.578 Y85.317
G1 X62.195 Y86.934 E.04273
G1 X62.195 Y87.491
G1 X60.578 Y85.875 E.04272
G1 X60.578 Y86.432
G1 X62.195 Y88.049 E.04272
G1 X62.195 Y88.606
G1 X60.578 Y86.99 E.04272
G1 X60.578 Y87.547
G1 X62.195 Y89.164 E.04272
G1 X62.195 Y89.721
G1 X60.578 Y88.105 E.04272
G1 X60.578 Y88.662
G1 X62.195 Y90.279 E.04272
G1 X61.931 Y90.573
G1 X60.578 Y89.22 E.03576
G1 X60.578 Y89.778
G1 X61.374 Y90.573 E.02102
; CHANGE_LAYER
; Z_HEIGHT: 3.44
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F3600
M204 S6000
G1 X60.578 Y89.778 E-.16033
G1 X60.578 Y89.22 E-.07946
G1 X60.802 Y89.444 E-.04522
; WIPE_END
G1 E-.015 F1800
; layer num/total_layer_count: 28/74
; update layer progress
M73 L28
M991 S0 P27 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z3.72 I-.073 J1.215 P1  F18000
M73 P60 R7
G1 X69.346 Y89.957 Z3.72
G1 Z3.44
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F2194
M204 S6000
G1 X69.346 Y80.043 E.19933
G1 X72.243 Y80.043 E.05825
G1 X72.243 Y89.957 E.19933
G1 X69.406 Y89.957 E.05704
M204 S10000
G1 X68.922 Y90.381 F18000
G1 F2194
M204 S6000
G1 X68.922 Y79.619 E.21639
G1 X72.667 Y79.619 E.07531
G1 X72.667 Y90.381 E.21639
G1 X68.982 Y90.381 E.0741
M204 S250
G1 X68.512 Y90.79 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1800
M204 S5000
G1 X68.512 Y79.21 E.21638
G1 X73.076 Y79.21 E.08528
G1 X73.076 Y90.79 E.21638
G1 X68.572 Y90.79 E.08416
; WIPE_START
M204 S6000
G1 X68.562 Y88.79 E-.285
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
G1 X0 Y85 ; move to safe pos
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




G1 X70.142 Y89.556
G1 Z3.44
G1 E.3 F1800
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.402542
G1 F2194
M204 S6000
G1 X70.123 Y89.368 E.00338
G1 X70.123 Y80.504 E.15829
G1 X70.142 Y80.444 E.00113
G1 X69.746 Y80.444 E.00707
G1 X69.746 Y89.556 E.16272
G1 X70.082 Y89.556 E.006
M204 S10000
G1 X70.524 Y88.746 F18000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F2194
M204 S6000
G1 X70.524 Y89.444 E.01402
G1 X70.65 Y89.57 E.00361
G1 X70.641 Y89.594 E.0005
G1 X71.436 Y89.594 E.01599
G1 X71.678 Y89.097 E.01111
G1 X71.88 Y88.765 E.00782
G1 X71.88 Y84.421 E.08734
G1 X71.679 Y84.09 E.0078
G1 X71.467 Y83.634 E.0101
G1 X71.364 Y83.179 E.00938
G1 X71.353 Y82.724 E.00916
G1 X71.444 Y82.269 E.00934
G1 X71.678 Y81.814 E.01029
G1 X71.88 Y81.482 E.00782
G1 X71.88 Y80.406 E.02162
G1 X71.258 Y80.406 E.0125
; WIPE_START
G1 F6000
G1 X71.88 Y80.406 E-.08859
G1 X71.88 Y81.482 E-.15323
G1 X71.722 Y81.74 E-.04318
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X65.594 Y86.29 Z3.84 F18000
G1 X60.654 Y89.957 Z3.84
G1 Z3.44
G1 E.3 F1800
; FEATURE: Inner wall
G1 F2194
M204 S6000
G1 X57.757 Y89.957 E.05824
G1 X57.757 Y80.043 E.19933
G1 X60.653 Y80.043 E.05822
G1 X60.654 Y89.897 E.19812
M204 S10000
G1 X61.078 Y90.381 F18000
G1 F2194
M204 S6000
G1 X57.333 Y90.381 E.0753
G1 X57.333 Y79.619 E.21639
G1 X61.077 Y79.619 E.07528
G1 X61.078 Y90.321 E.21518
M204 S250
G1 X61.487 Y90.79 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1800
M204 S5000
G1 X56.924 Y90.79 E.08527
G1 X56.924 Y79.21 E.21638
G1 X61.487 Y79.21 E.08526
G1 X61.486 Y79.223 E.00024
G1 X61.487 Y90.73 E.21502
; WIPE_START
M204 S6000
G1 X59.488 Y90.756 E-.285
; WIPE_END
G1 E-.015
M204 S10000
G1 X58.216 Y89.594 Z3.84 F18000
G1 Z3.44
G1 E.3 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F2194
M204 S6000
G1 X58.12 Y89.594 E.00192
G1 X58.12 Y87.992 E.0322
G1 X58.321 Y87.731 E.00663
G1 X58.533 Y87.276 E.0101
G1 X58.636 Y86.821 E.00938
G1 X58.647 Y86.366 E.00916
G1 X58.556 Y85.91 E.00934
G1 X58.322 Y85.455 E.01029
G1 X58.12 Y85.226 E.00615
G1 X58.12 Y80.709 E.09082
G1 X58.341 Y80.406 E.00753
G1 X59.358 Y80.406 E.02045
G1 X59.349 Y80.43 E.00051
G1 X59.475 Y80.556 E.00361
G1 X59.475 Y81.032 E.00955
M204 S10000
G1 X60.253 Y80.632 F18000
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.402547
G1 F2194
M204 S6000
G1 X60.253 Y80.444 E.00336
G1 X59.857 Y80.444 E.00707
G1 X59.876 Y80.632 E.00338
G1 X59.877 Y89.496 E.15829
G1 X59.857 Y89.556 E.00113
G1 X60.253 Y89.556 E.00707
G1 X60.253 Y80.692 E.15829
; CHANGE_LAYER
; Z_HEIGHT: 3.56
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F3840
G1 X60.253 Y82.692 E-.285
; WIPE_END
G1 E-.015 F1800
; layer num/total_layer_count: 29/74
; update layer progress
M73 L29
M991 S0 P28 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z3.84 I-.742 J.965 P1  F18000
G1 X69.386 Y89.717 Z3.84
G1 Z3.56
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F2196
M204 S6000
G1 X69.386 Y80.283 E.18968
G1 X70.044 Y80.283 E.01322
G1 X70.044 Y80.043 E.00483
G1 X72.28 Y80.043 E.04497
G1 X72.28 Y89.957 E.19933
G1 X70.044 Y89.957 E.04497
G1 X70.044 Y89.717 E.00483
G1 X69.446 Y89.717 E.01202
M204 S10000
G1 X68.962 Y90.141 F18000
G1 F2196
M204 S6000
G1 X68.962 Y79.859 E.20674
G1 X69.619 Y79.859 E.01321
G1 X69.618 Y79.619 E.00483
G1 X72.704 Y79.619 E.06205
G1 X72.704 Y90.381 E.21639
G1 X69.618 Y90.381 E.06205
G1 X69.619 Y90.141 E.00483
G1 X69.022 Y90.141 E.012
M204 S250
G1 X68.553 Y90.55 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1800
M204 S5000
G1 X68.553 Y79.45 E.20741
G1 X69.209 Y79.45 E.01226
G1 X69.208 Y79.21 E.00448
G1 X73.113 Y79.21 E.07297
G1 X73.113 Y90.79 E.21638
G1 X69.208 Y90.79 E.07297
G1 X69.209 Y90.55 E.00448
G1 X68.613 Y90.55 E.01114
; WIPE_START
M204 S6000
G1 X68.602 Y88.55 E-.285
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
G1 X0 Y85 ; move to safe pos
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




G1 X70.524 Y88.883
G1 Z3.56
G1 E.3 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F2196
M204 S6000
G1 X70.524 Y89.594 E.0143
G1 X71.51 Y89.594 E.01983
G1 X71.788 Y89.097 E.01145
G1 X71.917 Y88.745 E.00754
M73 P61 R7
G1 X71.917 Y84.527 E.0848
G1 X71.615 Y84.09 E.01069
G1 X71.44 Y83.634 E.00981
G1 X71.371 Y83.179 E.00926
G1 X71.394 Y82.724 E.00916
G1 X71.521 Y82.269 E.0095
G1 X71.788 Y81.814 E.01061
G1 X71.917 Y81.462 E.00754
G1 X71.917 Y80.406 E.02122
G1 X71.275 Y80.406 E.0129
; WIPE_START
G1 F6000
G1 X71.917 Y80.406 E-.09144
G1 X71.917 Y81.462 E-.15038
G1 X71.813 Y81.746 E-.04318
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X70.133 Y80.674 Z3.96 F18000
G1 Z3.56
G1 E.3 F1800
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.382282
G1 F2196
M204 S6000
G1 X69.777 Y80.674 E.00602
G1 X69.777 Y89.326 E.14621
G1 X70.133 Y89.326 E.00602
G1 X70.133 Y80.734 E.14519
; WIPE_START
G1 F3840
G1 X70.133 Y82.734 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X63.979 Y87.248 Z3.96 F18000
G1 X60.614 Y89.717 Z3.96
G1 Z3.56
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F2196
M204 S6000
G1 X59.958 Y89.717 E.01318
G1 X59.958 Y89.957 E.00483
G1 X57.72 Y89.957 E.045
G1 X57.72 Y80.043 E.19933
G1 X59.963 Y80.043 E.04509
G1 X59.964 Y80.283 E.00483
G1 X60.614 Y80.283 E.01306
G1 X60.614 Y89.657 E.18847
M204 S10000
G1 X61.038 Y90.141 F18000
G1 F2196
M204 S6000
G1 X60.382 Y90.141 E.01318
G1 X60.383 Y90.381 E.00483
G1 X57.296 Y90.381 E.06207
G1 X57.296 Y79.619 E.21639
G1 X60.385 Y79.619 E.06211
G1 X60.386 Y79.859 E.00483
G1 X61.038 Y79.859 E.01311
G1 X61.038 Y90.081 E.20553
M204 S250
G1 X61.447 Y90.55 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1800
M204 S5000
G1 X60.792 Y90.55 E.01224
G1 X60.792 Y90.79 E.00448
G1 X56.887 Y90.79 E.07298
G1 X56.887 Y79.21 E.21638
G1 X60.792 Y79.21 E.07297
G1 X60.793 Y79.45 E.00448
G1 X61.447 Y79.45 E.01222
G1 X61.447 Y90.49 E.20629
; WIPE_START
M204 S6000
G1 X60.792 Y90.55 E-.09376
G1 X60.792 Y90.79 E-.0342
G1 X59.69 Y90.79 E-.15704
; WIPE_END
G1 E-.015
M204 S10000
G1 X58.355 Y89.594 Z3.96 F18000
G1 Z3.56
G1 E.3 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F2196
M204 S6000
G1 X58.083 Y89.594 E.00548
G1 X58.083 Y88.169 E.02865
G1 X58.385 Y87.731 E.01069
G1 X58.56 Y87.276 E.00981
G1 X58.629 Y86.821 E.00926
G1 X58.606 Y86.366 E.00916
G1 X58.479 Y85.91 E.0095
G1 X58.212 Y85.455 E.01061
G1 X58.083 Y85.313 E.00386
G1 X58.083 Y80.886 E.08902
G1 X58.401 Y80.406 E.01157
G1 X59.475 Y80.406 E.02161
G1 X59.475 Y81.029 E.01251
M204 S10000
G1 X60.223 Y80.853 F18000
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.382597
G1 F2196
M204 S6000
G1 X60.223 Y80.674 E.00302
G1 X59.866 Y80.674 E.00604
G1 X59.867 Y89.326 E.14633
G1 X60.223 Y89.326 E.00603
G1 X60.223 Y80.913 E.1423
; CHANGE_LAYER
; Z_HEIGHT: 3.68
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F3840
G1 X60.223 Y82.913 E-.285
; WIPE_END
G1 E-.015 F1800
; layer num/total_layer_count: 30/74
; update layer progress
M73 L30
M991 S0 P29 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z3.96 I-.724 J.979 P1  F18000
G1 X69.425 Y89.717 Z3.96
G1 Z3.68
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F2199
M204 S6000
G1 X69.425 Y80.283 E.18968
G1 X70.595 Y80.283 E.02352
G1 X70.594 Y80.043 E.00483
G1 X72.315 Y80.043 E.0346
G1 X72.315 Y89.957 E.19933
G1 X70.594 Y89.957 E.0346
G1 X70.595 Y89.717 E.00483
G1 X69.485 Y89.717 E.02231
M204 S10000
G1 X69.001 Y90.141 F18000
G1 F2199
M204 S6000
G1 X69.001 Y79.859 E.20674
G1 X70.17 Y79.859 E.0235
G1 X70.169 Y79.619 E.00483
G1 X72.74 Y79.619 E.05168
G1 X72.74 Y90.381 E.21639
G1 X70.169 Y90.381 E.05168
G1 X70.17 Y90.141 E.00483
G1 X69.061 Y90.141 E.0223
M204 S250
G1 X68.592 Y90.55 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1800
M204 S5000
G1 X68.592 Y79.45 E.20741
G1 X69.76 Y79.45 E.02183
G1 X69.76 Y79.21 E.00448
G1 X73.149 Y79.21 E.06333
G1 X73.149 Y90.79 E.21638
G1 X69.76 Y90.79 E.06333
G1 X69.76 Y90.55 E.00448
G1 X68.652 Y90.55 E.02071
; WIPE_START
M204 S6000
G1 X68.641 Y88.55 E-.285
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
G1 X0 Y85 ; move to safe pos
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




G1 X70.524 Y88.95
G1 Z3.68
G1 E.3 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F2199
M204 S6000
G1 X70.524 Y89.354 E.00811
G1 X70.958 Y89.354 E.00874
G1 X70.958 Y89.594 E.00483
G1 X71.577 Y89.594 E.01244
G1 X71.892 Y89.097 E.01184
G1 X71.952 Y88.659 E.00888
G1 X71.952 Y84.991 E.07375
G1 X71.826 Y84.545 E.00933
G1 X71.547 Y84.09 E.01073
G1 X71.407 Y83.634 E.00957
G1 X71.372 Y83.179 E.00918
G1 X71.429 Y82.724 E.00922
G1 X71.592 Y82.269 E.00972
G1 X71.892 Y81.814 E.01097
G1 X71.952 Y81.376 E.00888
G1 X71.952 Y80.406 E.0195
G1 X71.225 Y80.406 E.01462
; WIPE_START
G1 F6000
G1 X71.952 Y80.406 E-.10361
G1 X71.952 Y81.376 E-.13821
G1 X71.911 Y81.676 E-.04318
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X70.143 Y80.833 Z4.08 F18000
G1 Z3.68
G1 E.3 F1800
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.362832
G1 F2199
M204 S6000
G1 X70.143 Y80.664 E.00269
G1 X69.806 Y80.664 E.00539
G1 X69.806 Y89.336 E.13854
G1 X70.143 Y89.336 E.00539
G1 X70.143 Y80.893 E.13489
; WIPE_START
G1 F3840
G1 X70.143 Y82.893 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X63.929 Y87.324 Z4.08 F18000
G1 X60.575 Y89.717 Z4.08
G1 Z3.68
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F2199
M204 S6000
G1 X59.411 Y89.717 E.0234
G1 X59.41 Y89.957 E.00483
G1 X57.685 Y89.957 E.0347
G1 X57.685 Y80.046 E.19928
G1 X59.41 Y80.049 E.0347
G1 X59.411 Y80.283 E.00471
G1 X60.575 Y80.283 E.02339
G1 X60.575 Y89.657 E.18847
M204 S10000
G1 X60.999 Y90.141 F18000
M73 P62 R7
G1 F2199
M204 S6000
G1 X59.834 Y90.141 E.02343
G1 X59.833 Y90.381 E.00483
G1 X57.26 Y90.381 E.05173
G1 X57.26 Y79.621 E.21636
G1 X59.833 Y79.626 E.05173
G1 X59.834 Y79.859 E.00469
G1 X60.999 Y79.859 E.02342
G1 X60.999 Y90.081 E.20553
M204 S250
G1 X61.408 Y90.55 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1800
M204 S5000
G1 X60.242 Y90.55 E.0218
G1 X60.241 Y90.79 E.00448
G1 X56.851 Y90.79 E.06334
G1 X56.851 Y79.21 E.21637
G1 X60.241 Y79.218 E.06334
G1 X60.242 Y79.45 E.00434
G1 X61.408 Y79.45 E.0218
G1 X61.408 Y90.49 E.20629
; WIPE_START
M204 S6000
G1 X60.242 Y90.55 E-.16644
G1 X60.241 Y90.79 E-.0342
G1 X59.649 Y90.79 E-.08436
; WIPE_END
G1 E-.015
M204 S10000
G1 X58.475 Y89.594 Z4.08 F18000
G1 Z3.68
G1 E.3 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F2199
M204 S6000
G1 X58.048 Y89.594 E.00859
G1 X58.048 Y88.324 E.02553
G1 X58.174 Y88.186 E.00376
G1 X58.453 Y87.731 E.01073
G1 X58.593 Y87.276 E.00957
G1 X58.628 Y86.821 E.00918
G1 X58.571 Y86.366 E.00922
G1 X58.408 Y85.91 E.00972
G1 X58.048 Y85.385 E.01281
G1 X58.048 Y81.041 E.08736
G1 X58.174 Y80.903 E.00376
G1 X58.464 Y80.41 E.01151
G1 X59.049 Y80.411 E.01175
G1 X59.05 Y80.646 E.00472
G1 X59.475 Y80.646 E.00856
G1 X59.475 Y81.098 E.00909
M204 S10000
G1 X60.194 Y80.833 F18000
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.363152
G1 F2199
M204 S6000
G1 X60.194 Y80.664 E.0027
G1 X59.856 Y80.664 E.0054
G1 X59.857 Y89.336 E.13867
G1 X60.194 Y89.336 E.00539
G1 X60.194 Y80.893 E.13501
; CHANGE_LAYER
; Z_HEIGHT: 3.8
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F3840
G1 X60.194 Y82.893 E-.285
; WIPE_END
G1 E-.015 F1800
; layer num/total_layer_count: 31/74
; update layer progress
M73 L31
M991 S0 P30 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z4.08 I-.721 J.98 P1  F18000
G1 X69.467 Y89.717 Z4.08
G1 Z3.8
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1951
M204 S6000
G1 X69.467 Y80.283 E.18968
G1 X70.918 Y80.283 E.02916
G1 X70.918 Y80.043 E.00483
G1 X72.349 Y80.043 E.02878
G1 X72.349 Y89.957 E.19933
G1 X70.918 Y89.957 E.02878
G1 X70.918 Y89.717 E.00483
G1 X69.527 Y89.717 E.02796
M204 S10000
G1 X69.043 Y90.141 F18000
G1 F1951
M204 S6000
G1 X69.043 Y79.859 E.20674
G1 X70.494 Y79.859 E.02916
G1 X70.494 Y79.619 E.00483
G1 X72.773 Y79.619 E.04584
G1 X72.773 Y90.381 E.21639
G1 X70.494 Y90.381 E.04584
G1 X70.494 Y90.141 E.00483
G1 X69.103 Y90.141 E.02796
M204 S250
G1 X68.634 Y90.55 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1800
M204 S5000
G1 X68.634 Y79.45 E.20741
G1 X70.084 Y79.45 E.0271
G1 X70.084 Y79.21 E.00448
G1 X73.182 Y79.21 E.05789
G1 X73.182 Y90.79 E.21638
G1 X70.084 Y90.79 E.05789
G1 X70.084 Y90.55 E.00448
G1 X68.694 Y90.55 E.02598
; WIPE_START
M204 S6000
G1 X68.683 Y88.55 E-.285
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
G1 X0 Y85 ; move to safe pos
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




G1 X69.996 Y89.188
G1 Z3.8
G1 E.3 F1800
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.657812
G1 F1951
M204 S6000
G1 X69.996 Y80.872 E.24914
; WIPE_START
G1 F3840
G1 X69.996 Y82.872 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X71.707 Y80.406 Z4.2 F18000
G1 Z3.8
G1 E.3 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F1951
M204 S6000
G1 X71.986 Y80.406 E.00562
G1 X71.986 Y81.824 E.0285
G1 X71.656 Y82.269 E.01114
G1 X71.458 Y82.724 E.00999
G1 X71.367 Y83.179 E.00933
G1 X71.369 Y83.634 E.00915
G1 X71.473 Y84.09 E.00939
G1 X71.718 Y84.545 E.0104
G1 X71.986 Y84.846 E.0081
G1 X71.986 Y89.107 E.08568
G1 X71.638 Y89.594 E.01203
G1 X71.28 Y89.594 E.00719
G1 X71.28 Y89.354 E.00483
G1 X70.524 Y89.354 E.01522
G1 X70.524 Y89.011 E.00688
; WIPE_START
G1 F6000
G1 X70.524 Y89.354 E-.04879
G1 X71.28 Y89.354 E-.10786
G1 X71.28 Y89.594 E-.0342
G1 X71.638 Y89.594 E-.05098
G1 X71.814 Y89.347 E-.04318
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X64.186 Y89.597 Z4.2 F18000
G1 X60.533 Y89.717 Z4.2
G1 Z3.8
G1 E.3 F1800
; FEATURE: Inner wall
G1 F1951
M204 S6000
G1 X59.083 Y89.717 E.02916
G1 X59.082 Y89.957 E.00483
G1 X57.651 Y89.957 E.02878
G1 X57.651 Y80.043 E.19933
G1 X59.084 Y80.043 E.02881
G1 X59.085 Y80.283 E.00483
G1 X60.533 Y80.283 E.02912
G1 X60.533 Y89.657 E.18847
M204 S10000
G1 X60.957 Y90.141 F18000
G1 F1951
M204 S6000
G1 X59.507 Y90.141 E.02916
G1 X59.506 Y90.381 E.00483
G1 X57.227 Y90.381 E.04584
G1 X57.227 Y79.619 E.21639
G1 X59.507 Y79.619 E.04585
G1 X59.508 Y79.859 E.00483
G1 X60.957 Y79.859 E.02914
G1 X60.957 Y90.081 E.20553
M204 S250
G1 X61.366 Y90.55 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1800
M204 S5000
G1 X59.916 Y90.55 E.0271
G1 X59.916 Y90.79 E.00448
G1 X56.818 Y90.79 E.05789
G1 X56.818 Y79.21 E.21638
G1 X59.915 Y79.21 E.05789
G1 X59.916 Y79.45 E.00448
G1 X61.366 Y79.45 E.0271
G1 X61.366 Y90.49 E.20629
; WIPE_START
M204 S6000
G1 X59.916 Y90.55 E-.20687
G1 X59.916 Y90.79 E-.0342
G1 X59.607 Y90.79 E-.04393
; WIPE_END
G1 E-.015
M204 S10000
G1 X60.004 Y89.188 Z4.2 F18000
G1 Z3.8
G1 E.3 F1800
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.658472
G1 F1951
M204 S6000
M73 P63 R7
G1 X60.004 Y80.872 E.24938
M204 S10000
G1 X59.475 Y81.165 F18000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F1951
M204 S6000
G1 X59.475 Y80.646 E.01044
G1 X58.723 Y80.646 E.01514
G1 X58.722 Y80.406 E.00483
G1 X58.537 Y80.406 E.00372
G1 X58.282 Y80.903 E.01123
G1 X58.014 Y81.204 E.00811
G1 X58.014 Y85.465 E.08568
G1 X58.344 Y85.91 E.01114
G1 X58.542 Y86.366 E.00999
G1 X58.633 Y86.821 E.00933
G1 X58.631 Y87.276 E.00915
G1 X58.527 Y87.731 E.00939
G1 X58.282 Y88.186 E.0104
G1 X58.014 Y88.488 E.00811
G1 X58.014 Y89.594 E.02224
G1 X58.605 Y89.594 E.01188
; CHANGE_LAYER
; Z_HEIGHT: 3.92
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F6000
G1 X58.014 Y89.594 E-.0842
G1 X58.014 Y88.488 E-.15762
G1 X58.215 Y88.261 E-.04318
; WIPE_END
G1 E-.015 F1800
; layer num/total_layer_count: 32/74
; update layer progress
M73 L32
M991 S0 P31 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z4.2 I-.155 J1.207 P1  F18000
G1 X69.513 Y89.717 Z4.2
G1 Z3.92
G1 E.3 F1800
; FEATURE: Inner wall
G1 F1734
M204 S6000
G1 X69.513 Y80.283 E.18968
G1 X71.15 Y80.283 E.03292
G1 X71.15 Y80.043 E.00483
G1 X72.381 Y80.043 E.02474
G1 X72.381 Y89.957 E.19933
G1 X71.15 Y89.957 E.02474
G1 X71.15 Y89.717 E.00483
G1 X69.573 Y89.717 E.03171
M204 S10000
G1 X69.089 Y90.141 F18000
G1 F1734
M204 S6000
G1 X69.089 Y79.859 E.20674
G1 X70.726 Y79.859 E.03292
G1 X70.726 Y79.619 E.00483
G1 X72.805 Y79.619 E.0418
G1 X72.805 Y90.381 E.21639
G1 X70.726 Y90.381 E.0418
G1 X70.726 Y90.141 E.00483
G1 X69.149 Y90.141 E.03172
M204 S250
G1 X68.68 Y90.55 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1734
M204 S5000
G1 X68.68 Y79.45 E.20741
G1 X70.317 Y79.45 E.0306
G1 X70.317 Y79.21 E.00448
G1 X73.214 Y79.21 E.05413
G1 X73.214 Y90.79 E.21638
G1 X70.317 Y90.79 E.05413
G1 X70.317 Y90.55 E.00448
G1 X68.74 Y90.55 E.02948
; WIPE_START
G1 F1800
M204 S6000
G1 X68.729 Y88.55 E-.285
; WIPE_END
G1 E-.015
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
G1 X0 Y85 ; move to safe pos
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




G1 X70.238 Y89.354
G1 Z3.92
G1 E.3 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F1734
M204 S6000
G1 X71.513 Y89.354 E.02563
G1 X71.513 Y89.594 E.00483
G1 X71.695 Y89.594 E.00366
G1 X72.018 Y89.189 E.01042
G1 X72.018 Y85.021 E.0838
G1 X71.602 Y84.545 E.01271
G1 X71.391 Y84.09 E.01009
G1 X71.323 Y83.634 E.00925
G1 X71.356 Y83.179 E.00918
G1 X71.481 Y82.724 E.00949
G1 X71.717 Y82.269 E.01031
G1 X72.018 Y81.905 E.0095
G1 X72.018 Y80.406 E.03014
G1 X71.82 Y80.406 E.00398
; WIPE_START
G1 F6000
G1 X72.018 Y80.406 E-.02821
G1 X72.018 Y81.905 E-.21361
G1 X71.825 Y82.139 E-.04318
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X65.479 Y86.38 Z4.32 F18000
G1 X60.487 Y89.717 Z4.32
G1 Z3.92
G1 E.3 F1800
; FEATURE: Inner wall
G1 F1734
M204 S6000
G1 X58.847 Y89.717 E.03298
G1 X58.847 Y89.957 E.00483
G1 X57.619 Y89.957 E.02469
G1 X57.619 Y80.043 E.19933
G1 X58.847 Y80.043 E.02469
G1 X58.847 Y80.283 E.00483
G1 X60.487 Y80.283 E.03298
G1 X60.487 Y89.657 E.18847
M204 S10000
G1 X60.911 Y90.141 F18000
G1 F1734
M204 S6000
G1 X59.272 Y90.141 E.03296
G1 X59.272 Y90.381 E.00483
G1 X57.195 Y90.381 E.04177
G1 X57.195 Y79.619 E.21639
G1 X59.272 Y79.619 E.04177
G1 X59.272 Y79.859 E.00483
G1 X60.911 Y79.859 E.03296
G1 X60.911 Y90.081 E.20553
M204 S250
G1 X61.32 Y90.55 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1734
M204 S5000
G1 X59.682 Y90.55 E.03062
G1 X59.682 Y90.79 E.00448
G1 X56.786 Y90.79 E.05412
G1 X56.786 Y79.21 E.21638
G1 X59.682 Y79.21 E.05412
G1 X59.682 Y79.45 E.00448
G1 X61.32 Y79.45 E.03062
G1 X61.32 Y90.49 E.20629
; WIPE_START
G1 F1800
M204 S6000
G1 X59.682 Y90.55 E-.23365
G1 X59.682 Y90.79 E-.0342
G1 X59.562 Y90.79 E-.01715
; WIPE_END
G1 E-.015
M204 S10000
G1 X58.521 Y89.354 Z4.32 F18000
G1 Z3.92
G1 E.3 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F1734
M204 S6000
G1 X58.483 Y89.354 E.00076
G1 X58.484 Y89.594 E.00483
G1 X57.982 Y89.594 E.01009
G1 X57.982 Y88.676 E.01845
G1 X58.398 Y88.186 E.01292
G1 X58.609 Y87.731 E.01009
G1 X58.677 Y87.276 E.00925
G1 X58.644 Y86.821 E.00918
G1 X58.52 Y86.366 E.00949
G1 X58.283 Y85.91 E.01031
G1 X57.982 Y85.547 E.0095
G1 X57.982 Y81.393 E.08353
G1 X58.398 Y80.903 E.01292
G1 X58.517 Y80.646 E.0057
G1 X60.124 Y80.646 E.03231
G1 X60.124 Y80.736 E.00181
; CHANGE_LAYER
; Z_HEIGHT: 4.04
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F6000
G1 X60.124 Y80.646 E-.01282
G1 X58.517 Y80.646 E-.229
G1 X58.398 Y80.903 E-.04038
G1 X58.385 Y80.918 E-.00279
; WIPE_END
G1 E-.015 F1800
; layer num/total_layer_count: 33/74
; update layer progress
M73 L33
M991 S0 P32 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z4.32 I-.753 J.956 P1  F18000
G1 X69.562 Y89.717 Z4.32
G1 Z4.04
G1 E.3 F1800
; FEATURE: Inner wall
G1 F1762
M204 S6000
G1 X69.562 Y80.283 E.18968
M73 P64 R7
G1 X71.335 Y80.283 E.03565
G1 X71.335 Y80.043 E.00483
G1 X72.411 Y80.043 E.02163
G1 X72.411 Y89.957 E.19933
G1 X71.335 Y89.957 E.02163
G1 X71.335 Y89.717 E.00483
G1 X69.622 Y89.717 E.03445
M204 S10000
G1 X69.138 Y90.141 F18000
G1 F1762
M204 S6000
G1 X69.138 Y79.859 E.20674
G1 X70.911 Y79.859 E.03565
G1 X70.911 Y79.619 E.00483
G1 X72.835 Y79.619 E.0387
G1 X72.835 Y90.381 E.21639
G1 X70.911 Y90.381 E.03869
G1 X70.911 Y90.141 E.00483
G1 X69.198 Y90.141 E.03445
M204 S250
G1 X68.728 Y90.55 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1762
M204 S5000
G1 X68.728 Y79.45 E.20741
G1 X70.501 Y79.45 E.03313
G1 X70.501 Y79.21 E.00448
G1 X73.244 Y79.21 E.05126
G1 X73.244 Y90.79 E.21638
G1 X70.501 Y90.79 E.05125
G1 X70.501 Y90.55 E.00448
G1 X68.788 Y90.55 E.03201
; WIPE_START
G1 F1800
M204 S6000
G1 X68.778 Y88.55 E-.285
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
G1 X0 Y85 ; move to safe pos
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




G1 X71.547 Y89.624
G1 Z4.04
G1 E.3 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.265652
G1 F1762
M204 S6000
G1 X72.199 Y89.624 E.00741
; WIPE_START
G1 F2400
G1 X71.547 Y89.624 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X72.048 Y86.881 Z4.44 F18000
G1 Z4.04
G1 E.3 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F1762
M204 S6000
G1 X72.048 Y85.184 E.03412
G1 X71.859 Y85 E.00531
G1 X71.475 Y84.545 E.01198
G1 X71.3 Y84.09 E.0098
G1 X71.27 Y83.634 E.00917
G1 X71.338 Y83.179 E.00925
G1 X71.497 Y82.724 E.0097
G1 X71.773 Y82.269 E.0107
G1 X72.048 Y82.001 E.00773
G1 X72.048 Y80.871 E.02271
G1 X71.48 Y80.871 E.01141
M204 S10000
G1 X71.547 Y80.376 F18000
; FEATURE: Gap infill
; LINE_WIDTH: 0.265652
G1 F1762
M204 S6000
G1 X72.199 Y80.376 E.00741
; WIPE_START
G1 F2400
G1 X71.547 Y80.376 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X65.705 Y85.288 Z4.44 F18000
G1 X60.438 Y89.717 Z4.44
G1 Z4.04
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1762
M204 S6000
G1 X58.666 Y89.717 E.03564
G1 X58.665 Y89.957 E.00483
G1 X57.589 Y89.957 E.02164
G1 X57.589 Y80.043 E.19933
G1 X58.666 Y80.043 E.02166
G1 X58.667 Y80.283 E.00483
G1 X60.438 Y80.283 E.03562
G1 X60.438 Y89.657 E.18847
M204 S10000
G1 X60.862 Y90.141 F18000
G1 F1762
M204 S6000
G1 X59.09 Y90.141 E.03564
G1 X59.09 Y90.381 E.00483
G1 X57.165 Y90.381 E.0387
G1 X57.165 Y79.619 E.21639
G1 X59.09 Y79.619 E.03871
G1 X59.09 Y79.859 E.00483
G1 X60.862 Y79.859 E.03563
G1 X60.862 Y90.081 E.20553
M204 S250
G1 X61.272 Y90.55 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1762
M204 S5000
G1 X59.499 Y90.55 E.03313
G1 X59.499 Y90.79 E.00448
G1 X56.756 Y90.79 E.05125
G1 X56.756 Y79.21 E.21638
G1 X59.499 Y79.21 E.05125
G1 X59.499 Y79.45 E.00448
G1 X61.272 Y79.45 E.03312
G1 X61.272 Y90.49 E.20629
; WIPE_START
G1 F1800
M204 S6000
G1 X59.499 Y90.55 E-.25277
G1 X59.499 Y90.776 E-.03223
; WIPE_END
G1 E-.015
M204 S10000
G1 X59.343 Y89.354 Z4.44 F18000
G1 Z4.04
G1 E.3 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F1762
M204 S6000
G1 X58.816 Y89.354 E.01059
G1 X58.816 Y89.129 E.00452
G1 X57.952 Y89.129 E.01738
G1 X57.952 Y89.048 E.00163
G1 X58.141 Y88.642 E.00901
G1 X58.525 Y88.186 E.01198
G1 X58.7 Y87.731 E.0098
M73 P64 R6
G1 X58.73 Y87.276 E.00917
G1 X58.662 Y86.821 E.00925
G1 X58.503 Y86.366 E.0097
G1 X57.952 Y85.419 E.02202
G1 X57.952 Y81.765 E.07349
G1 X58.141 Y81.358 E.00901
G1 X58.538 Y80.871 E.01263
G1 X58.817 Y80.871 E.00562
G1 X58.817 Y80.646 E.00452
G1 X60.01 Y80.646 E.02397
; WIPE_START
G1 F6000
G1 X58.817 Y80.646 E-.1699
G1 X58.817 Y80.871 E-.03206
G1 X58.538 Y80.871 E-.03986
G1 X58.346 Y81.106 E-.04318
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X58.455 Y80.376 Z4.44 F18000
G1 Z4.04
G1 E.3 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.265652
G1 F1762
M204 S6000
G1 X57.801 Y80.376 E.00743
; WIPE_START
G1 F2400
G1 X58.455 Y80.376 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X57.917 Y87.989 Z4.44 F18000
G1 X57.801 Y89.624 Z4.44
G1 Z4.04
G1 E.3 F1800
G1 F1762
M204 S6000
G1 X58.453 Y89.624 E.00741
; CHANGE_LAYER
; Z_HEIGHT: 4.16
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F2400
G1 X57.801 Y89.624 E-.285
; WIPE_END
G1 E-.015 F1800
; layer num/total_layer_count: 34/74
; update layer progress
M73 L34
M991 S0 P33 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z4.44 I-.009 J1.217 P1  F18000
G1 X69.614 Y89.717 Z4.44
G1 Z4.16
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1755
M204 S6000
G1 X69.614 Y80.283 E.18968
G1 X71.489 Y80.283 E.03769
G1 X71.489 Y80.043 E.00483
G1 X72.439 Y80.043 E.01911
G1 X72.439 Y89.957 E.19933
G1 X71.489 Y89.957 E.01911
G1 X71.489 Y89.717 E.00483
G1 X69.674 Y89.717 E.03649
M204 S10000
G1 X69.19 Y90.141 F18000
G1 F1755
M204 S6000
G1 X69.19 Y79.859 E.20674
G1 X71.064 Y79.859 E.03768
G1 X71.064 Y79.619 E.00483
G1 X72.863 Y79.619 E.03618
G1 X72.863 Y90.381 E.21639
G1 X71.064 Y90.381 E.03618
G1 X71.064 Y90.141 E.00483
G1 X69.25 Y90.141 E.03648
M204 S250
G1 X68.781 Y90.55 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1755
M204 S5000
G1 X68.781 Y79.45 E.20741
M73 P65 R6
G1 X70.655 Y79.45 E.03501
G1 X70.654 Y79.21 E.00448
G1 X73.273 Y79.21 E.04893
G1 X73.273 Y90.79 E.21638
G1 X70.654 Y90.79 E.04893
G1 X70.655 Y90.55 E.00448
G1 X68.841 Y90.55 E.03389
; WIPE_START
G1 F1800
M204 S6000
G1 X68.83 Y88.55 E-.285
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
G1 X0 Y85 ; move to safe pos
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




G1 X71.701 Y89.624
G1 Z4.16
G1 E.3 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.265652
G1 F1755
M204 S6000
G1 X72.227 Y89.624 E.00598
; WIPE_START
G1 F2400
G1 X71.701 Y89.624 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X72.076 Y87.024 Z4.56 F18000
G1 Z4.16
G1 E.3 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F1755
M204 S6000
G1 X72.076 Y85.327 E.03412
G1 X71.703 Y85 E.00998
G1 X71.331 Y84.545 E.01183
G1 X71.199 Y84.09 E.00953
G1 X71.21 Y83.634 E.00916
G1 X71.313 Y83.179 E.00939
G1 X71.508 Y82.724 E.00996
G1 X71.825 Y82.269 E.01116
G1 X72.076 Y82.049 E.00671
G1 X72.076 Y80.871 E.02367
G1 X71.557 Y80.871 E.01045
M204 S10000
G1 X71.701 Y80.376 F18000
; FEATURE: Gap infill
; LINE_WIDTH: 0.265652
G1 F1755
M204 S6000
G1 X72.227 Y80.376 E.00598
; WIPE_START
G1 F2400
G1 X71.701 Y80.376 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X65.815 Y85.234 Z4.56 F18000
G1 X60.386 Y89.717 Z4.56
G1 Z4.16
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1755
M204 S6000
G1 X58.512 Y89.717 E.03766
G1 X58.512 Y89.957 E.00483
G1 X57.561 Y89.957 E.01914
G1 X57.561 Y80.043 E.19933
G1 X58.513 Y80.043 E.01914
G1 X58.513 Y80.283 E.00483
G1 X60.386 Y80.283 E.03765
G1 X60.386 Y89.657 E.18847
M204 S10000
G1 X60.81 Y90.141 F18000
G1 F1755
M204 S6000
G1 X58.937 Y90.141 E.03766
G1 X58.937 Y90.381 E.00483
G1 X57.137 Y90.381 E.0362
G1 X57.137 Y79.619 E.21639
G1 X58.937 Y79.619 E.0362
G1 X58.937 Y79.859 E.00483
G1 X60.81 Y79.859 E.03766
G1 X60.81 Y90.081 E.20553
M204 S250
G1 X61.219 Y90.55 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1755
M204 S5000
G1 X59.346 Y90.55 E.035
G1 X59.346 Y90.79 E.00448
G1 X56.727 Y90.79 E.04893
G1 X56.727 Y79.21 E.21638
G1 X59.346 Y79.21 E.04893
G1 X59.346 Y79.45 E.00448
G1 X61.219 Y79.45 E.035
G1 X61.219 Y90.49 E.20629
; WIPE_START
G1 F1800
M204 S6000
G1 X59.346 Y90.55 E-.26703
G1 X59.346 Y90.676 E-.01797
; WIPE_END
G1 E-.015
M204 S10000
G1 X59.458 Y89.354 Z4.56 F18000
G1 Z4.16
G1 E.3 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F1755
M204 S6000
G1 X58.663 Y89.354 E.01599
G1 X58.663 Y89.129 E.00452
G1 X57.986 Y89.129 E.0136
G1 X58.297 Y88.642 E.01161
G1 X58.669 Y88.186 E.01183
G1 X58.801 Y87.731 E.00953
G1 X58.79 Y87.276 E.00916
G1 X58.687 Y86.821 E.00939
G1 X58.492 Y86.366 E.00996
G1 X58.175 Y85.91 E.01116
G1 X57.924 Y85.411 E.01124
G1 X57.924 Y81.945 E.0697
G1 X58.297 Y81.358 E.01397
G1 X58.669 Y80.903 E.01183
G1 X58.744 Y80.646 E.00538
G1 X60.023 Y80.646 E.02572
G1 X60.023 Y81.064 E.0084
; WIPE_START
G1 F6000
G1 X60.023 Y80.646 E-.05955
G1 X58.744 Y80.646 E-.18228
G1 X58.669 Y80.903 E-.03813
G1 X58.647 Y80.931 E-.00504
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X58.301 Y80.376 Z4.56 F18000
G1 Z4.16
G1 E.3 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.265652
G1 F1755
M204 S6000
G1 X57.773 Y80.376 E.006
; WIPE_START
G1 F2400
G1 X58.301 Y80.376 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X57.866 Y87.996 Z4.56 F18000
G1 X57.773 Y89.624 Z4.56
G1 Z4.16
G1 E.3 F1800
G1 F1755
M204 S6000
G1 X58.3 Y89.624 E.006
; CHANGE_LAYER
; Z_HEIGHT: 4.28
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F2400
G1 X57.773 Y89.624 E-.285
; WIPE_END
G1 E-.015 F1800
; layer num/total_layer_count: 35/74
; update layer progress
M73 L35
M991 S0 P34 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z4.56 I-.009 J1.217 P1  F18000
G1 X69.671 Y89.717 Z4.56
G1 Z4.28
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1700
M204 S6000
G1 X69.671 Y80.283 E.18968
G1 X71.617 Y80.283 E.03914
G1 X71.617 Y80.043 E.00483
G1 X72.466 Y80.043 E.01707
G1 X72.466 Y89.957 E.19933
G1 X71.617 Y89.957 E.01706
G1 X71.617 Y89.717 E.00483
G1 X69.731 Y89.717 E.03793
M204 S10000
G1 X69.247 Y90.141 F18000
G1 F1700
M204 S6000
G1 X69.247 Y79.859 E.20674
G1 X71.193 Y79.859 E.03914
G1 X71.193 Y79.619 E.00483
G1 X72.89 Y79.619 E.03412
G1 X72.89 Y90.381 E.21639
G1 X71.193 Y90.381 E.03412
G1 X71.193 Y90.141 E.00483
G1 X69.307 Y90.141 E.03793
M204 S250
G1 X68.837 Y90.55 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1700
M204 S5000
G1 X68.837 Y79.45 E.20741
G1 X70.784 Y79.45 E.03637
G1 X70.784 Y79.21 E.00448
G1 X73.3 Y79.21 E.047
G1 X73.3 Y90.79 E.21638
G1 X70.784 Y90.79 E.047
G1 X70.784 Y90.55 E.00448
G1 X68.897 Y90.55 E.03525
; WIPE_START
G1 F1800
M204 S6000
G1 X68.887 Y88.55 E-.285
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
G1 X0 Y85 ; move to safe pos
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




G1 X72.103 Y87.152
G1 Z4.28
G1 E.3 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F1700
M204 S6000
M73 P66 R6
G1 X72.103 Y85.455 E.03412
G1 X71.517 Y85 E.01493
G1 X71.163 Y84.545 E.01159
G1 X71.085 Y84.09 E.00929
G1 X71.28 Y83.179 E.01872
G1 X71.511 Y82.724 E.01026
G1 X71.875 Y82.269 E.01172
G1 X72.103 Y82.092 E.0058
G1 X72.092 Y80.406 E.0339
; WIPE_START
G1 F6000
G1 X72.103 Y82.092 E-.24024
G1 X71.875 Y82.269 E-.04112
G1 X71.859 Y82.289 E-.00364
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X65.443 Y86.422 Z4.68 F18000
G1 X60.329 Y89.717 Z4.68
G1 Z4.28
G1 E.3 F1800
; FEATURE: Inner wall
G1 F1700
M204 S6000
G1 X58.382 Y89.717 E.03914
G1 X58.382 Y89.957 E.00483
G1 X57.534 Y89.957 E.01706
G1 X57.534 Y80.043 E.19933
G1 X58.383 Y80.043 E.01707
G1 X58.383 Y80.283 E.00483
G1 X60.329 Y80.283 E.03913
G1 X60.329 Y89.657 E.18847
M204 S10000
G1 X60.753 Y90.141 F18000
G1 F1700
M204 S6000
G1 X58.807 Y90.141 E.03914
G1 X58.807 Y90.381 E.00483
G1 X57.11 Y90.381 E.03412
G1 X57.11 Y79.619 E.21639
G1 X58.807 Y79.619 E.03412
G1 X58.807 Y79.859 E.00483
G1 X60.753 Y79.859 E.03914
G1 X60.753 Y90.081 E.20553
M204 S250
G1 X61.163 Y90.55 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1700
M204 S5000
G1 X59.216 Y90.55 E.03638
G1 X59.216 Y90.79 E.00448
G1 X56.7 Y90.79 E.047
G1 X56.7 Y79.21 E.21638
G1 X59.216 Y79.21 E.047
G1 X59.216 Y79.45 E.00448
G1 X61.163 Y79.45 E.03637
G1 X61.163 Y90.49 E.20629
; WIPE_START
G1 F1800
M204 S6000
G1 X59.216 Y90.55 E-.27755
G1 X59.216 Y90.602 E-.00745
; WIPE_END
G1 E-.015
M204 S10000
G1 X59.098 Y89.354 Z4.68 F18000
G1 Z4.28
G1 E.3 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F1700
M204 S6000
G1 X58.02 Y89.354 E.02169
G1 X58.02 Y89.594 E.00483
G1 X57.897 Y89.594 E.00247
G1 X57.897 Y89.338 E.00513
G1 X58.483 Y88.642 E.01832
G1 X58.837 Y88.186 E.01159
G1 X58.915 Y87.731 E.00929
G1 X58.72 Y86.821 E.01872
G1 X58.489 Y86.366 E.01026
G1 X58.125 Y85.91 E.01172
G1 X57.897 Y85.401 E.01122
G1 X57.897 Y82.055 E.06728
G1 X58.483 Y81.358 E.01832
G1 X58.837 Y80.903 E.01159
G1 X58.881 Y80.646 E.00524
G1 X59.966 Y80.646 E.02183
G1 X59.966 Y81.258 E.0123
; CHANGE_LAYER
; Z_HEIGHT: 4.4
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F6000
G1 X59.966 Y80.646 E-.08714
G1 X58.881 Y80.646 E-.15468
G1 X58.837 Y80.903 E-.03716
G1 X58.811 Y80.937 E-.00602
; WIPE_END
G1 E-.015 F1800
; layer num/total_layer_count: 36/74
; update layer progress
M73 L36
M991 S0 P35 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z4.68 I-.763 J.948 P1  F18000
G1 X69.731 Y89.717 Z4.68
G1 Z4.4
G1 E.3 F1800
; FEATURE: Inner wall
G1 F1848
M204 S6000
G1 X69.731 Y80.283 E.18968
G1 X71.731 Y80.283 E.04022
G1 X71.731 Y80.043 E.00483
G1 X72.491 Y80.043 E.01529
G1 X72.491 Y89.957 E.19933
G1 X71.731 Y89.957 E.01529
G1 X71.731 Y89.717 E.00483
G1 X69.791 Y89.717 E.03901
M204 S10000
G1 X69.307 Y90.141 F18000
G1 F1848
M204 S6000
G1 X69.307 Y79.859 E.20674
G1 X71.307 Y79.859 E.04022
G1 X71.307 Y79.619 E.00483
G1 X72.916 Y79.619 E.03235
G1 X72.916 Y90.381 E.21639
G1 X71.307 Y90.381 E.03235
G1 X71.307 Y90.141 E.00483
G1 X69.367 Y90.141 E.03901
M204 S250
G1 X68.897 Y90.55 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1800
M204 S5000
G1 X68.897 Y79.45 E.20741
G1 X70.898 Y79.45 E.03738
G1 X70.898 Y79.21 E.00448
G1 X73.325 Y79.21 E.04536
G1 X73.325 Y90.79 E.21638
G1 X70.898 Y90.79 E.04535
G1 X70.898 Y90.55 E.00448
G1 X68.957 Y90.55 E.03626
; WIPE_START
M204 S6000
G1 X68.947 Y88.55 E-.285
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
G1 X0 Y85 ; move to safe pos
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




G1 X70.094 Y89.353
G1 Z4.4
G1 E.3 F1800
; Slow Down Start
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.365752
G1 F3000;_EXTRUDE_SET_SPEED
M204 S6000
G1 X70.094 Y80.707 E.13934
; Slow Down End
; WIPE_START
G1 X70.094 Y82.707 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X72.129 Y80.426 Z4.8 F18000
G1 Z4.4
G1 E.3 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F1848
M204 S6000
G1 X72.129 Y82.123 E.03412
G1 X71.923 Y82.269 E.00508
G1 X71.508 Y82.724 E.01238
G1 X71.24 Y83.179 E.01062
G1 X70.956 Y84.09 E.01917
G1 X70.96 Y84.545 E.00915
G1 X71.27 Y85 E.01107
G1 X72.129 Y85.545 E.02045
G1 X72.129 Y87.242 E.03412
; WIPE_START
G1 F6000
G1 X72.129 Y85.545 E-.24182
G1 X71.873 Y85.383 E-.04318
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X64.723 Y88.053 Z4.8 F18000
G1 X60.269 Y89.717 Z4.8
G1 Z4.4
G1 E.3 F1800
; FEATURE: Inner wall
G1 F1848
M204 S6000
G1 X58.267 Y89.717 E.04025
G1 X58.268 Y89.957 E.00483
G1 X57.509 Y89.957 E.01526
G1 X57.509 Y80.043 E.19933
G1 X58.268 Y80.043 E.01526
G1 X58.267 Y80.283 E.00483
G1 X60.269 Y80.283 E.04025
G1 X60.269 Y89.657 E.18847
M204 S10000
G1 X60.693 Y90.141 F18000
G1 F1848
M204 S6000
G1 X58.692 Y90.141 E.04024
G1 X58.693 Y90.381 E.00483
G1 X57.084 Y90.381 E.03234
G1 X57.084 Y79.619 E.21639
G1 X58.693 Y79.619 E.03234
G1 X58.692 Y79.859 E.00483
G1 X60.693 Y79.859 E.04024
G1 X60.693 Y90.081 E.20553
M204 S250
G1 X61.103 Y90.55 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1800
M204 S5000
G1 X59.102 Y90.55 E.03738
G1 X59.102 Y90.79 E.00448
G1 X56.675 Y90.79 E.04535
G1 X56.675 Y79.21 E.21638
G1 X59.102 Y79.21 E.04535
G1 X59.102 Y79.45 E.00448
G1 X61.103 Y79.45 E.03738
G1 X61.103 Y90.49 E.20629
; WIPE_START
M204 S6000
G1 X59.104 Y90.55 E-.285
; WIPE_END
G1 E-.015
M204 S10000
G1 X59.906 Y89.353 Z4.8 F18000
G1 Z4.4
G1 E.3 F1800
; Slow Down Start
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.365752
G1 F3000;_EXTRUDE_SET_SPEED
M204 S6000
G1 X59.906 Y80.707 E.13934
; Slow Down End
; WIPE_START
G1 X59.906 Y82.707 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X59.543 Y81.843 Z4.8 F18000
G1 Z4.4
M73 P67 R6
G1 E.3 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F1848
M204 S6000
G1 X59.543 Y80.646 E.02406
G1 X59.042 Y80.646 E.01006
G1 X59.04 Y80.903 E.00517
G1 X58.73 Y81.358 E.01107
G1 X57.998 Y81.814 E.01733
G1 X57.872 Y82.019 E.00485
G1 X57.872 Y85.65 E.07302
G1 X58.077 Y85.91 E.00667
G1 X58.492 Y86.366 E.01238
G1 X58.76 Y86.821 E.01062
G1 X59.044 Y87.731 E.01917
G1 X59.04 Y88.186 E.00915
G1 X58.73 Y88.642 E.01107
G1 X57.998 Y89.097 E.01733
G1 X57.872 Y89.302 E.00485
G1 X57.872 Y89.594 E.00587
G1 X57.904 Y89.594 E.00066
G1 X57.904 Y89.354 E.00483
G1 X59.037 Y89.354 E.02277
; CHANGE_LAYER
; Z_HEIGHT: 4.52
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F6000
G1 X57.904 Y89.354 E-.16137
G1 X57.904 Y89.594 E-.0342
G1 X57.872 Y89.594 E-.00469
G1 X57.872 Y89.302 E-.04157
G1 X57.998 Y89.097 E-.03438
G1 X58.051 Y89.064 E-.0088
; WIPE_END
G1 E-.015 F1800
; layer num/total_layer_count: 37/74
; update layer progress
M73 L37
M991 S0 P36 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z4.8 I-.067 J1.215 P1  F18000
G1 X69.795 Y89.717 Z4.8
G1 Z4.52
G1 E.3 F1800
; FEATURE: Inner wall
G1 F1936
M204 S6000
G1 X69.795 Y80.283 E.18968
G1 X71.832 Y80.283 E.04096
G1 X71.831 Y80.043 E.00483
G1 X72.515 Y80.043 E.01375
G1 X72.515 Y89.957 E.19933
G1 X71.831 Y89.957 E.01375
G1 X71.832 Y89.717 E.00483
G1 X69.855 Y89.717 E.03975
M204 S10000
G1 X69.37 Y90.141 F18000
G1 F1936
M204 S6000
G1 X69.37 Y79.859 E.20674
G1 X71.407 Y79.859 E.04095
G1 X71.407 Y79.619 E.00483
G1 X72.939 Y79.619 E.03081
G1 X72.939 Y90.381 E.21639
G1 X71.407 Y90.381 E.03082
G1 X71.407 Y90.141 E.00483
G1 X69.43 Y90.141 E.03975
M204 S250
G1 X68.961 Y90.55 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1800
M204 S5000
G1 X68.961 Y79.45 E.20741
G1 X70.998 Y79.45 E.03805
G1 X70.997 Y79.21 E.00448
G1 X73.349 Y79.21 E.04393
G1 X73.349 Y90.79 E.21638
G1 X70.997 Y90.79 E.04394
G1 X70.998 Y90.55 E.00448
G1 X69.021 Y90.55 E.03693
; WIPE_START
M204 S6000
G1 X69.01 Y88.55 E-.285
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
G1 X0 Y85 ; move to safe pos
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




G1 X70.167 Y89.345
G1 Z4.52
G1 E.3 F1800
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.365752
G1 F1936
M204 S6000
G1 X70.167 Y80.715 E.13906
; WIPE_START
G1 F3840
G1 X70.167 Y82.715 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X71.97 Y80.646 Z4.92 F18000
G1 Z4.52
G1 E.3 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F1936
M204 S6000
G1 X72.152 Y80.646 E.00367
G1 X72.152 Y82.161 E.03046
G1 X71.968 Y82.269 E.0043
G1 X71.496 Y82.724 E.01318
G1 X71.19 Y83.179 E.01103
G1 X70.809 Y84.09 E.01985
G1 X70.696 Y84.545 E.00943
G1 X70.844 Y85 E.00962
G1 X71.82 Y85.455 E.02166
G1 X72.152 Y85.65 E.00774
G1 X72.152 Y87.347 E.03412
; WIPE_START
G1 F6000
G1 X72.152 Y85.65 E-.24182
G1 X71.891 Y85.497 E-.04318
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X64.712 Y88.089 Z4.92 F18000
G1 X60.205 Y89.717 Z4.92
G1 Z4.52
G1 E.3 F1800
; FEATURE: Inner wall
G1 F1936
M204 S6000
G1 X58.169 Y89.717 E.04094
G1 X58.169 Y89.957 E.00483
G1 X57.485 Y89.957 E.01376
G1 X57.485 Y80.043 E.19933
G1 X58.17 Y80.043 E.01378
G1 X58.17 Y80.283 E.00483
G1 X60.205 Y80.283 E.04092
G1 X60.205 Y89.657 E.18847
M204 S10000
G1 X60.63 Y90.141 F18000
G1 F1936
M204 S6000
G1 X58.594 Y90.141 E.04094
G1 X58.594 Y90.381 E.00483
G1 X57.061 Y90.381 E.03082
G1 X57.061 Y79.619 E.21639
G1 X58.594 Y79.619 E.03083
G1 X58.594 Y79.859 E.00483
G1 X60.63 Y79.859 E.04093
G1 X60.63 Y90.081 E.20553
M204 S250
G1 X61.039 Y90.55 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1800
M204 S5000
G1 X59.003 Y90.55 E.03804
G1 X59.003 Y90.79 E.00448
G1 X56.651 Y90.79 E.04394
G1 X56.651 Y79.21 E.21638
G1 X59.003 Y79.21 E.04393
G1 X59.003 Y79.45 E.00448
G1 X61.039 Y79.45 E.03804
G1 X61.039 Y90.49 E.20629
; WIPE_START
M204 S6000
G1 X59.04 Y90.549 E-.285
; WIPE_END
G1 E-.015
M204 S10000
G1 X59.833 Y89.345 Z4.92 F18000
G1 Z4.52
G1 E.3 F1800
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.365752
G1 F1936
M204 S6000
G1 X59.833 Y80.715 E.13906
; WIPE_START
G1 F3840
G1 X59.833 Y82.715 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X57.848 Y80.951 Z4.92 F18000
G1 Z4.52
G1 E.3 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F1936
M204 S6000
G1 X57.848 Y80.646 E.00612
G1 X59.24 Y80.646 E.028
G1 X59.304 Y80.903 E.00532
G1 X59.156 Y81.358 E.00962
G1 X58.18 Y81.814 E.02166
G1 X57.848 Y82.14 E.00936
G1 X57.848 Y85.644 E.07046
G1 X58.032 Y85.91 E.00651
G1 X58.504 Y86.366 E.01318
G1 X58.81 Y86.821 E.01103
G1 X59.191 Y87.731 E.01985
G1 X59.304 Y88.186 E.00943
G1 X59.156 Y88.642 E.00962
G1 X58.18 Y89.097 E.02166
G1 X57.919 Y89.354 E.00737
G1 X57.848 Y89.354 E.00142
M73 P68 R6
G1 X57.848 Y87.728 E.0327
; CHANGE_LAYER
; Z_HEIGHT: 4.64
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F6000
G1 X57.848 Y89.354 E-.23173
G1 X57.919 Y89.354 E-.01009
G1 X58.135 Y89.141 E-.04318
; WIPE_END
G1 E-.015 F1800
; layer num/total_layer_count: 38/74
; update layer progress
M73 L38
M991 S0 P37 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z4.92 I-.06 J1.216 P1  F18000
G1 X69.863 Y89.717 Z4.92
G1 Z4.64
G1 E.3 F1800
; FEATURE: Inner wall
G1 F1940
M204 S6000
G1 X69.863 Y80.283 E.18968
G1 X71.92 Y80.283 E.04136
G1 X71.92 Y80.043 E.00483
G1 X72.537 Y80.043 E.01242
G1 X72.537 Y89.957 E.19933
G1 X71.92 Y89.957 E.01242
G1 X71.92 Y89.717 E.00483
G1 X69.923 Y89.717 E.04016
M204 S10000
G1 X69.439 Y90.141 F18000
G1 F1940
M204 S6000
G1 X69.439 Y79.859 E.20674
G1 X71.496 Y79.859 E.04136
G1 X71.496 Y79.619 E.00483
G1 X72.962 Y79.619 E.02948
G1 X72.962 Y90.381 E.21639
G1 X71.496 Y90.381 E.02948
G1 X71.496 Y90.141 E.00483
G1 X69.499 Y90.141 E.04015
M204 S250
G1 X69.029 Y90.55 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1800
M204 S5000
G1 X69.029 Y79.45 E.20741
G1 X71.086 Y79.45 E.03843
G1 X71.086 Y79.21 E.00448
G1 X73.371 Y79.21 E.04269
G1 X73.371 Y90.79 E.21638
G1 X71.086 Y90.79 E.04269
G1 X71.086 Y90.55 E.00448
G1 X69.089 Y90.55 E.03731
; WIPE_START
M204 S6000
G1 X69.079 Y88.55 E-.285
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
G1 X0 Y85 ; move to safe pos
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




G1 X70.243 Y89.336
G1 Z4.64
G1 E.3 F1800
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.365752
G1 F1940
M204 S6000
G1 X70.243 Y80.724 E.13878
; WIPE_START
G1 F3840
G1 X70.243 Y82.724 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X72.011 Y80.646 Z5.04 F18000
G1 Z4.64
G1 E.3 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F1940
M204 S6000
G1 X72.175 Y80.646 E.00329
G1 X72.175 Y82.18 E.03083
G1 X71.828 Y82.399 E.00825
G1 X71.373 Y82.843 E.01279
G1 X70.918 Y83.55 E.01691
G1 X70.624 Y84.083 E.01223
G1 X70.624 Y85.533 E.02916
G1 X70.918 Y85.367 E.00678
G1 X71.373 Y85.418 E.00921
G1 X72.175 Y85.712 E.01718
G1 X72.175 Y87.409 E.03412
; WIPE_START
G1 F6000
G1 X72.175 Y85.712 E-.24182
G1 X71.89 Y85.608 E-.04318
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X64.685 Y88.127 Z5.04 F18000
G1 X60.137 Y89.717 Z5.04
G1 Z4.64
G1 E.3 F1800
; FEATURE: Inner wall
G1 F1940
M204 S6000
G1 X58.081 Y89.717 E.04135
G1 X58.081 Y89.957 E.00483
G1 X57.463 Y89.957 E.01242
G1 X57.463 Y80.043 E.19933
G1 X58.081 Y80.043 E.01243
G1 X58.081 Y80.283 E.00483
G1 X60.137 Y80.283 E.04134
G1 X60.137 Y89.657 E.18847
M204 S10000
G1 X60.561 Y90.141 F18000
G1 F1940
M204 S6000
G1 X58.505 Y90.141 E.04135
G1 X58.505 Y90.381 E.00483
G1 X57.038 Y90.381 E.02948
G1 X57.038 Y79.619 E.21639
G1 X58.505 Y79.619 E.02949
G1 X58.505 Y79.859 E.00483
G1 X60.561 Y79.859 E.04135
G1 X60.561 Y90.081 E.20553
M204 S250
G1 X60.971 Y90.55 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1800
M204 S5000
G1 X58.914 Y90.55 E.03843
G1 X58.914 Y90.79 E.00448
G1 X56.629 Y90.79 E.04269
G1 X56.629 Y79.21 E.21638
G1 X58.914 Y79.21 E.04269
G1 X58.914 Y79.45 E.00448
G1 X60.971 Y79.45 E.03843
G1 X60.971 Y90.49 E.20629
; WIPE_START
M204 S6000
G1 X58.971 Y90.548 E-.285
; WIPE_END
G1 E-.015
M204 S10000
G1 X59.757 Y89.336 Z5.04 F18000
G1 Z4.64
G1 E.3 F1800
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.365752
G1 F1940
M204 S6000
G1 X59.757 Y80.724 E.13878
; WIPE_START
G1 F3840
G1 X59.757 Y82.724 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X59.376 Y83.588 Z5.04 F18000
G1 Z4.64
G1 E.3 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F1940
M204 S6000
G1 X59.376 Y81.891 E.03412
G1 X59.082 Y81.726 E.00678
G1 X58.627 Y81.776 E.00921
G1 X57.826 Y82.071 E.01718
G1 X57.826 Y85.821 E.07541
G1 X58.172 Y86.041 E.00825
G1 X58.627 Y86.485 E.01279
G1 X59.082 Y87.192 E.01691
G1 X59.376 Y87.724 E.01223
G1 X59.376 Y89.174 E.02916
G1 X59.082 Y89.009 E.00678
G1 X58.627 Y89.059 E.00921
G1 X57.826 Y89.354 E.01717
G1 X57.826 Y87.658 E.0341
; CHANGE_LAYER
; Z_HEIGHT: 4.76
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F6000
G1 X57.826 Y89.354 E-.24168
G1 X58.111 Y89.249 E-.04332
; WIPE_END
G1 E-.015 F1800
; layer num/total_layer_count: 39/74
; update layer progress
M73 L39
M991 S0 P38 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z5.04 I-.048 J1.216 P1  F18000
G1 X69.935 Y89.717 Z5.04
G1 Z4.76
G1 E.3 F1800
; FEATURE: Inner wall
G1 F1931
M204 S6000
G1 X69.935 Y80.283 E.18968
G1 X72 Y80.283 E.04153
G1 X72 Y80.043 E.00483
G1 X72.558 Y80.043 E.01122
G1 X72.558 Y89.957 E.19933
G1 X72 Y89.957 E.01122
G1 X72 Y89.717 E.00483
G1 X69.995 Y89.717 E.04032
M204 S10000
M73 P69 R6
G1 X69.511 Y90.141 F18000
G1 F1931
M204 S6000
G1 X69.511 Y79.859 E.20674
G1 X71.576 Y79.859 E.04152
G1 X71.575 Y79.619 E.00483
G1 X72.982 Y79.619 E.02829
G1 X72.982 Y90.381 E.21639
G1 X71.575 Y90.381 E.02829
G1 X71.576 Y90.141 E.00483
G1 X69.571 Y90.141 E.04031
M204 S250
G1 X69.102 Y90.55 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1800
M204 S5000
G1 X69.102 Y79.45 E.20741
G1 X71.166 Y79.45 E.03858
G1 X71.166 Y79.21 E.00448
G1 X73.392 Y79.21 E.04159
G1 X73.392 Y90.79 E.21638
G1 X71.166 Y90.79 E.04159
G1 X71.166 Y90.55 E.00448
G1 X69.162 Y90.55 E.03745
; WIPE_START
M204 S6000
G1 X69.151 Y88.55 E-.285
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
G1 X0 Y85 ; move to safe pos
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




G1 X70.325 Y89.327
G1 Z4.76
G1 E.3 F1800
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.381212
G1 F1931
M204 S6000
G1 X70.325 Y80.733 E.14477
; WIPE_START
G1 F3840
G1 X70.325 Y82.733 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X72.056 Y80.646 Z5.16 F18000
G1 Z4.76
G1 E.3 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F1931
M204 S6000
G1 X72.195 Y80.646 E.0028
G1 X72.195 Y82.204 E.03133
G1 X71.828 Y82.407 E.00843
G1 X71.373 Y82.797 E.01206
G1 X70.715 Y83.715 E.02271
G1 X70.715 Y85.748 E.04088
G1 X70.918 Y85.598 E.00507
G1 X71.373 Y85.556 E.00919
G1 X72.195 Y85.774 E.01711
G1 X72.195 Y87.471 E.03412
; WIPE_START
G1 F6000
G1 X72.195 Y85.774 E-.24182
G1 X71.902 Y85.697 E-.04318
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X64.675 Y88.151 Z5.16 F18000
G1 X60.065 Y89.717 Z5.16
G1 Z4.76
G1 E.3 F1800
; FEATURE: Inner wall
G1 F1931
M204 S6000
G1 X58.001 Y89.717 E.0415
G1 X58.001 Y89.957 E.00483
G1 X57.442 Y89.957 E.01124
G1 X57.442 Y80.043 E.19933
G1 X58.001 Y80.043 E.01124
G1 X58.001 Y80.283 E.00483
G1 X60.065 Y80.283 E.04151
G1 X60.065 Y89.657 E.18847
M204 S10000
G1 X60.489 Y90.141 F18000
G1 F1931
M204 S6000
G1 X58.425 Y90.141 E.0415
G1 X58.425 Y90.381 E.00483
G1 X57.018 Y90.381 E.0283
G1 X57.018 Y79.619 E.21639
G1 X58.425 Y79.619 E.0283
G1 X58.425 Y79.859 E.00483
G1 X60.489 Y79.859 E.0415
G1 X60.489 Y90.081 E.20553
M204 S250
G1 X60.898 Y90.55 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1800
M204 S5000
G1 X58.834 Y90.55 E.03857
G1 X58.834 Y90.79 E.00448
G1 X56.608 Y90.79 E.04159
G1 X56.608 Y79.21 E.21638
G1 X58.834 Y79.21 E.04159
G1 X58.834 Y79.45 E.00448
G1 X60.898 Y79.45 E.03857
G1 X60.898 Y90.49 E.20629
; WIPE_START
M204 S6000
G1 X58.899 Y90.548 E-.285
; WIPE_END
G1 E-.015
M204 S10000
G1 X59.675 Y89.327 Z5.16 F18000
G1 Z4.76
G1 E.3 F1800
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.381212
G1 F1931
M204 S6000
G1 X59.675 Y80.733 E.14477
; WIPE_START
G1 F3840
G1 X59.675 Y82.733 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X59.285 Y83.803 Z5.16 F18000
G1 Z4.76
G1 E.3 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F1931
M204 S6000
G1 X59.285 Y82.106 E.03412
G1 X59.082 Y81.957 E.00507
G1 X58.627 Y81.915 E.00919
G1 X57.805 Y82.133 E.01711
G1 X57.805 Y85.846 E.07466
G1 X58.172 Y86.048 E.00843
G1 X58.627 Y86.438 E.01206
G1 X59.285 Y87.356 E.02271
G1 X59.285 Y89.354 E.04016
G1 X59.237 Y89.354 E.00097
G1 X59.082 Y89.24 E.00386
G1 X58.627 Y89.198 E.00919
G1 X58.039 Y89.354 E.01223
G1 X57.805 Y89.354 E.00472
G1 X57.805 Y87.891 E.02941
; CHANGE_LAYER
; Z_HEIGHT: 4.88
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F6000
G1 X57.805 Y89.354 E-.2084
G1 X58.039 Y89.354 E-.03342
G1 X58.332 Y89.276 E-.04318
; WIPE_END
G1 E-.015 F1800
; layer num/total_layer_count: 40/74
; update layer progress
M73 L40
M991 S0 P39 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z5.16 I-.046 J1.216 P1  F18000
G1 X70.011 Y89.717 Z5.16
G1 Z4.88
G1 E.3 F1800
; FEATURE: Inner wall
G1 F1986
M204 S6000
G1 X70.011 Y80.283 E.18968
G1 X72.071 Y80.283 E.04141
G1 X72.071 Y80.043 E.00483
G1 X72.578 Y80.043 E.01019
M73 P69 R5
G1 X72.577 Y89.957 E.19933
G1 X72.071 Y89.957 E.01018
G1 X72.071 Y89.717 E.00483
G1 X70.071 Y89.717 E.04021
M204 S10000
G1 X69.587 Y90.141 F18000
G1 F1986
M204 S6000
G1 X69.587 Y79.859 E.20674
G1 X71.647 Y79.859 E.04141
G1 X71.647 Y79.619 E.00483
G1 X73.002 Y79.619 E.02725
G1 X73.002 Y90.381 E.21639
G1 X71.647 Y90.381 E.02725
G1 X71.647 Y90.141 E.00483
G1 X69.647 Y90.141 E.0402
M204 S250
G1 X69.178 Y90.55 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1800
M204 S5000
G1 X69.178 Y79.45 E.20741
G1 X71.237 Y79.45 E.03848
G1 X71.237 Y79.21 E.00448
G1 X73.411 Y79.21 E.04062
G1 X73.411 Y90.79 E.21638
G1 X71.237 Y90.79 E.04062
G1 X71.237 Y90.55 E.00448
G1 X69.238 Y90.55 E.03736
; WIPE_START
M204 S6000
G1 X69.227 Y88.55 E-.285
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
G1 X0 Y85 ; move to safe pos
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




G1 X70.411 Y89.317
G1 Z4.88
G1 E.3 F1800
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.400272
G1 F1986
M204 S6000
G1 X70.411 Y80.743 E.1522
; WIPE_START
G1 F3840
G1 X70.411 Y82.743 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X72.324 Y80.256 Z5.28 F18000
G1 Z4.88
G1 E.3 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.108052
G1 F1986
M204 S6000
G1 X72.324 Y80.495 E.00094
M204 S10000
G1 X71.907 Y80.835 F18000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F1986
M204 S6000
M73 P70 R5
G1 X71.907 Y80.858 E.00047
G1 X72.215 Y80.858 E.00618
G1 X72.215 Y82.225 E.02748
G1 X71.828 Y82.407 E.00859
G1 X71.373 Y82.748 E.01145
G1 X70.81 Y83.431 E.01779
G1 X70.81 Y85.869 E.04901
G1 X70.918 Y85.783 E.00276
G1 X71.373 Y85.678 E.00939
G1 X71.828 Y85.712 E.00918
G1 X72.215 Y85.816 E.00805
G1 X72.215 Y87.513 E.03412
; WIPE_START
G1 F6000
G1 X72.215 Y85.816 E-.24182
G1 X71.922 Y85.737 E-.04318
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X72.324 Y89.505 Z5.28 F18000
G1 Z4.88
G1 E.3 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.107947
G1 F1986
M204 S6000
G1 X72.324 Y89.744 E.00093
; WIPE_START
G1 F2400
G1 X72.324 Y89.505 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X64.693 Y89.636 Z5.28 F18000
G1 X59.988 Y89.717 Z5.28
G1 Z4.88
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1986
M204 S6000
G1 X57.929 Y89.717 E.04141
G1 X57.929 Y89.957 E.00483
G1 X57.422 Y89.957 E.01019
G1 X57.422 Y80.043 E.19933
G1 X57.93 Y80.043 E.0102
G1 X57.93 Y80.283 E.00483
G1 X59.988 Y80.283 E.0414
G1 X59.988 Y89.657 E.18847
M204 S10000
G1 X60.413 Y90.141 F18000
G1 F1986
M204 S6000
G1 X58.353 Y90.141 E.04141
G1 X58.353 Y90.381 E.00483
G1 X56.998 Y90.381 E.02725
G1 X56.998 Y79.619 E.21639
G1 X58.354 Y79.619 E.02725
G1 X58.354 Y79.859 E.00483
G1 X60.413 Y79.859 E.0414
G1 X60.413 Y90.081 E.20553
M204 S250
G1 X60.822 Y90.55 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1800
M204 S5000
G1 X58.763 Y90.55 E.03848
G1 X58.763 Y90.79 E.00448
G1 X56.589 Y90.79 E.04062
G1 X56.589 Y79.21 E.21638
G1 X58.763 Y79.21 E.04062
G1 X58.763 Y79.45 E.00448
G1 X60.822 Y79.45 E.03848
G1 X60.822 Y90.49 E.20629
; WIPE_START
M204 S6000
G1 X58.823 Y90.548 E-.285
; WIPE_END
G1 E-.015
M204 S10000
G1 X59.589 Y89.317 Z5.28 F18000
G1 Z4.88
G1 E.3 F1800
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.400292
G1 F1986
M204 S6000
G1 X59.589 Y80.743 E.15221
; WIPE_START
G1 F3840
G1 X59.589 Y82.743 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X57.676 Y80.495 Z5.28 F18000
G1 Z4.88
G1 E.3 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.108688
G1 F1986
M204 S6000
G1 X57.676 Y80.256 E.00094
; WIPE_START
G1 F2400
G1 X57.676 Y80.495 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X59.19 Y83.924 Z5.28 F18000
G1 Z4.88
G1 E.3 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F1986
M204 S6000
G1 X59.19 Y82.227 E.03412
G1 X59.082 Y82.141 E.00276
G1 X58.627 Y82.036 E.00939
G1 X58.172 Y82.07 E.00918
G1 X57.785 Y82.174 E.00805
G1 X57.785 Y85.866 E.07424
G1 X58.172 Y86.048 E.00859
G1 X58.627 Y86.39 E.01145
G1 X59.19 Y87.073 E.01779
G1 X59.19 Y89.354 E.04586
G1 X58.776 Y89.354 E.00832
G1 X58.627 Y89.319 E.00307
G1 X58.093 Y89.354 E.01077
G1 X58.093 Y89.142 E.00426
G1 X57.785 Y89.142 E.00618
G1 X57.785 Y88.041 E.02212
; WIPE_START
G1 F6000
G1 X57.785 Y89.142 E-.15678
G1 X58.093 Y89.142 E-.0438
G1 X58.093 Y89.354 E-.03021
G1 X58.472 Y89.329 E-.05421
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X57.676 Y89.505 Z5.28 F18000
G1 Z4.88
G1 E.3 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.108047
G1 F1986
M204 S6000
G1 X57.676 Y89.744 E.00094
; CHANGE_LAYER
; Z_HEIGHT: 5
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F2400
G1 X57.676 Y89.505 E-.285
; WIPE_END
G1 E-.015 F1800
; layer num/total_layer_count: 41/74
; update layer progress
M73 L41
M991 S0 P40 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z5.28 I-.021 J1.217 P1  F18000
G1 X70.093 Y89.717 Z5.28
G1 Z5
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1834
M204 S6000
G1 X70.093 Y80.283 E.18968
G1 X72.135 Y80.283 E.04107
G1 X72.135 Y80.043 E.00483
G1 X72.596 Y80.043 E.00925
G1 X72.595 Y89.957 E.19933
G1 X72.135 Y89.957 E.00925
G1 X72.135 Y89.717 E.00483
G1 X70.153 Y89.717 E.03987
M204 S10000
G1 X69.668 Y90.141 F18000
G1 F1834
M204 S6000
G1 X69.668 Y79.859 E.20674
G1 X71.711 Y79.859 E.04108
G1 X71.711 Y79.619 E.00483
G1 X73.02 Y79.619 E.02631
G1 X73.02 Y90.381 E.21639
G1 X71.711 Y90.381 E.02631
G1 X71.711 Y90.141 E.00483
G1 X69.728 Y90.141 E.03987
M204 S250
G1 X69.259 Y90.55 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1800
M204 S5000
G1 X69.259 Y79.45 E.20741
G1 X71.302 Y79.45 E.03817
G1 X71.302 Y79.21 E.00448
G1 X73.429 Y79.21 E.03974
G1 X73.429 Y90.79 E.21638
G1 X71.302 Y90.79 E.03974
G1 X71.302 Y90.55 E.00448
G1 X69.319 Y90.55 E.03705
; WIPE_START
M204 S6000
G1 X69.308 Y88.55 E-.285
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
G1 X0 Y85 ; move to safe pos
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




G1 X70.502 Y89.307
G1 Z5
G1 E.3 F1800
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.419732
G1 F1834
M204 S6000
G1 X70.502 Y80.753 E.15974
; WIPE_START
G1 F3840
G1 X70.502 Y82.753 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X72.131 Y80.646 Z5.4 F18000
G1 Z5
G1 E.3 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F1834
M204 S6000
G1 X72.233 Y80.646 E.00205
G1 X72.233 Y82.241 E.03207
G1 X71.828 Y82.4 E.00874
G1 X71.373 Y82.697 E.01094
M73 P71 R5
G1 X70.911 Y83.198 E.01369
G1 X70.911 Y85.944 E.05522
G1 X71.373 Y85.785 E.00982
G1 X71.828 Y85.777 E.00915
G1 X72.233 Y85.854 E.00828
G1 X72.233 Y87.551 E.03412
; WIPE_START
G1 F6000
G1 X72.233 Y85.854 E-.24182
G1 X71.935 Y85.797 E-.04318
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X64.678 Y88.162 Z5.4 F18000
G1 X59.907 Y89.717 Z5.4
G1 Z5
G1 E.3 F1800
; FEATURE: Inner wall
G1 F1834
M204 S6000
G1 X57.865 Y89.717 E.04107
G1 X57.865 Y89.957 E.00483
G1 X57.404 Y89.957 E.00925
G1 X57.404 Y80.043 E.19933
G1 X57.865 Y80.043 E.00926
G1 X57.865 Y80.283 E.00483
G1 X59.907 Y80.283 E.04106
G1 X59.907 Y89.657 E.18847
M204 S10000
G1 X60.332 Y90.141 F18000
G1 F1834
M204 S6000
G1 X58.289 Y90.141 E.04107
G1 X58.289 Y90.381 E.00483
G1 X56.98 Y90.381 E.02631
G1 X56.98 Y79.619 E.21639
G1 X58.289 Y79.619 E.02631
G1 X58.289 Y79.859 E.00483
G1 X60.332 Y79.859 E.04107
G1 X60.332 Y90.081 E.20553
M204 S250
G1 X60.741 Y90.55 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1800
M204 S5000
G1 X58.698 Y90.55 E.03817
G1 X58.698 Y90.79 E.00448
G1 X56.571 Y90.79 E.03974
G1 X56.571 Y79.21 E.21638
G1 X58.698 Y79.21 E.03974
G1 X58.698 Y79.45 E.00448
G1 X60.741 Y79.45 E.03817
G1 X60.741 Y90.49 E.20629
; WIPE_START
M204 S6000
G1 X58.742 Y90.549 E-.285
; WIPE_END
G1 E-.015
M204 S10000
G1 X59.498 Y89.307 Z5.4 F18000
G1 Z5
G1 E.3 F1800
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.419732
G1 F1834
M204 S6000
G1 X59.498 Y80.753 E.15974
M204 S10000
G1 X59.048 Y80.646 F18000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F1834
M204 S6000
G1 X59.089 Y80.646 E.00083
G1 X59.089 Y82.302 E.03329
G1 X58.627 Y82.144 E.00982
G1 X58.172 Y82.135 E.00915
G1 X57.767 Y82.212 E.00828
G1 X57.767 Y85.883 E.07381
G1 X58.172 Y86.041 E.00874
G1 X58.627 Y86.339 E.01094
G1 X59.089 Y86.839 E.01369
G1 X59.089 Y88.536 E.03412
; CHANGE_LAYER
; Z_HEIGHT: 5.12
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F6000
G1 X59.089 Y86.839 E-.24182
G1 X58.884 Y86.617 E-.04318
; WIPE_END
G1 E-.015 F1800
; layer num/total_layer_count: 42/74
; update layer progress
M73 L42
M991 S0 P41 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z5.4 I-.322 J1.174 P1  F18000
G1 X70.178 Y89.717 Z5.4
G1 Z5.12
G1 E.3 F1800
; FEATURE: Inner wall
G1 F1824
M204 S6000
G1 X70.178 Y80.283 E.18968
G1 X72.195 Y80.283 E.04055
G1 X72.195 Y80.043 E.00483
G1 X72.612 Y80.043 E.00839
G1 X72.612 Y89.957 E.19933
G1 X72.195 Y89.957 E.00839
G1 X72.195 Y89.717 E.00483
G1 X70.238 Y89.717 E.03935
M204 S10000
G1 X69.754 Y90.141 F18000
G1 F1824
M204 S6000
G1 X69.754 Y79.859 E.20674
G1 X71.771 Y79.859 E.04055
G1 X71.771 Y79.619 E.00483
G1 X73.036 Y79.619 E.02545
G1 X73.036 Y90.381 E.21639
G1 X71.771 Y90.381 E.02545
G1 X71.771 Y90.141 E.00483
G1 X69.814 Y90.141 E.03934
M204 S250
G1 X69.345 Y90.55 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1800
M204 S5000
G1 X69.345 Y79.45 E.20741
G1 X71.361 Y79.45 E.03768
G1 X71.361 Y79.21 E.00448
G1 X73.446 Y79.21 E.03895
G1 X73.446 Y90.79 E.21638
G1 X71.361 Y90.79 E.03895
G1 X71.361 Y90.55 E.00448
G1 X69.405 Y90.55 E.03656
; WIPE_START
M204 S6000
G1 X69.394 Y88.55 E-.285
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
G1 X0 Y85 ; move to safe pos
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




G1 X70.598 Y89.297
G1 Z5.12
G1 E.3 F1800
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.440572
G1 F1824
M204 S6000
G1 X70.598 Y80.763 E.16778
; WIPE_START
G1 F3840
G1 X70.598 Y82.763 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X72.16 Y80.646 Z5.52 F18000
G1 Z5.12
G1 E.3 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F1824
M204 S6000
G1 X72.249 Y80.646 E.0018
G1 X72.249 Y82.254 E.03232
G1 X71.828 Y82.386 E.00888
G1 X71.373 Y82.643 E.01051
G1 X71.017 Y82.956 E.00953
G1 X71.017 Y86.032 E.06183
G1 X71.373 Y85.881 E.00776
G1 X71.828 Y85.833 E.0092
G1 X72.249 Y85.881 E.00853
G1 X72.249 Y87.578 E.03412
; WIPE_START
G1 F6000
G1 X72.249 Y85.881 E-.24182
G1 X71.948 Y85.847 E-.04318
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X64.677 Y88.167 Z5.52 F18000
G1 X59.822 Y89.717 Z5.52
G1 Z5.12
G1 E.3 F1800
; FEATURE: Inner wall
G1 F1824
M204 S6000
G1 X57.805 Y89.717 E.04056
G1 X57.805 Y89.957 E.00483
G1 X57.388 Y89.957 E.00839
G1 X57.388 Y80.043 E.19933
G1 X57.806 Y80.043 E.00841
G1 X57.806 Y80.283 E.00483
G1 X59.822 Y80.283 E.04053
G1 X59.822 Y89.657 E.18847
M204 S10000
G1 X60.246 Y90.141 F18000
G1 F1824
M204 S6000
G1 X58.229 Y90.141 E.04055
G1 X58.229 Y90.381 E.00483
G1 X56.964 Y90.381 E.02545
G1 X56.964 Y79.619 E.21639
G1 X58.23 Y79.619 E.02546
G1 X58.23 Y79.859 E.00483
G1 X60.246 Y79.859 E.04054
G1 X60.246 Y90.081 E.20553
M204 S250
G1 X60.655 Y90.55 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1800
M204 S5000
G1 X58.639 Y90.55 E.03768
G1 X58.639 Y90.79 E.00448
G1 X56.554 Y90.79 E.03895
G1 X56.554 Y79.21 E.21638
G1 X58.639 Y79.21 E.03895
G1 X58.639 Y79.45 E.00448
G1 X60.655 Y79.45 E.03768
G1 X60.655 Y90.49 E.20629
; WIPE_START
M204 S6000
G1 X58.656 Y90.549 E-.285
; WIPE_END
G1 E-.015
M204 S10000
G1 X59.402 Y89.297 Z5.52 F18000
G1 Z5.12
G1 E.3 F1800
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.440592
G1 F1824
M204 S6000
G1 X59.402 Y80.763 E.16779
M204 S10000
G1 X58.983 Y80.693 F18000
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F1824
M204 S6000
G1 X58.983 Y82.39 E.03412
G1 X58.627 Y82.24 E.00776
G1 X58.172 Y82.192 E.0092
G1 X57.751 Y82.239 E.00853
G1 X57.751 Y85.895 E.07351
G1 X58.172 Y86.028 E.00888
G1 X58.627 Y86.285 E.01051
G1 X58.983 Y86.598 E.00953
G1 X58.983 Y88.295 E.03412
; CHANGE_LAYER
; Z_HEIGHT: 5.24
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F6000
G1 X58.983 Y86.598 E-.24182
G1 X58.756 Y86.398 E-.04318
; WIPE_END
M73 P72 R5
G1 E-.015 F1800
; layer num/total_layer_count: 43/74
; update layer progress
M73 L43
M991 S0 P42 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z5.52 I-.337 J1.169 P1  F18000
G1 X70.269 Y89.717 Z5.52
G1 Z5.24
G1 E.3 F1800
; FEATURE: Inner wall
G1 F2553
M204 S6000
G1 X70.269 Y80.283 E.18968
G1 X72.248 Y80.283 E.03979
G1 X72.248 Y80.043 E.00483
G1 X72.628 Y80.043 E.00763
G1 X72.628 Y89.957 E.19933
G1 X72.248 Y89.957 E.00763
G1 X72.248 Y89.717 E.00483
G1 X70.329 Y89.717 E.03858
M204 S10000
G1 X69.845 Y90.141 F18000
G1 F2553
M204 S6000
G1 X69.845 Y79.859 E.20674
G1 X71.824 Y79.859 E.03979
G1 X71.824 Y79.619 E.00483
G1 X73.052 Y79.619 E.02469
G1 X73.052 Y90.381 E.21639
G1 X71.824 Y90.381 E.02469
G1 X71.824 Y90.141 E.00483
G1 X69.905 Y90.141 E.03859
M204 S250
G1 X69.435 Y90.55 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1800
M204 S5000
G1 X69.435 Y79.45 E.20741
G1 X71.415 Y79.45 E.03698
G1 X71.415 Y79.21 E.00448
G1 X73.461 Y79.21 E.03823
G1 X73.461 Y90.79 E.21638
G1 X71.415 Y90.79 E.03823
G1 X71.415 Y90.55 E.00448
G1 X69.495 Y90.55 E.03586
; WIPE_START
M204 S6000
G1 X69.485 Y88.55 E-.285
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
G1 X0 Y85 ; move to safe pos
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




G1 X72.218 Y81.463
G1 Z5.24
G1 E.3 F1800
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.419992
G1 F2553
M204 S6000
G1 X72.218 Y80.693 E.01439
G1 X70.678 Y80.693 E.02878
G1 X70.678 Y89.307 E.16097
G1 X72.218 Y89.307 E.02878
G1 X72.218 Y81.523 E.14546
M204 S10000
G1 X71.824 Y81.463 F18000
G1 F2553
M204 S6000
G1 X71.824 Y81.087 E.00702
G1 X71.072 Y81.087 E.01405
G1 X71.072 Y88.913 E.14623
G1 X71.824 Y88.913 E.01405
G1 X71.824 Y81.523 E.13809
; WIPE_START
G1 F3840
G1 X71.824 Y83.523 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X71.448 Y88.537 Z5.64 F18000
G1 Z5.24
G1 E.3 F1800
; Slow Down Start
; LINE_WIDTH: 0.383192
G1 F3000;_EXTRUDE_SET_SPEED
M204 S6000
G1 X71.448 Y81.523 E.11883
; Slow Down End
; WIPE_START
G1 X71.448 Y83.523 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X64.7 Y87.09 Z5.64 F18000
G1 X59.731 Y89.717 Z5.64
G1 Z5.24
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F2553
M204 S6000
G1 X57.751 Y89.717 E.03981
G1 X57.751 Y89.957 E.00483
G1 X57.372 Y89.957 E.00762
G1 X57.372 Y80.043 E.19933
G1 X57.752 Y80.043 E.00764
G1 X57.752 Y80.283 E.00483
G1 X59.731 Y80.283 E.03979
G1 X59.731 Y89.657 E.18847
M204 S10000
G1 X60.155 Y90.141 F18000
G1 F2553
M204 S6000
G1 X58.176 Y90.141 E.03981
G1 X58.176 Y90.381 E.00483
G1 X56.948 Y90.381 E.02468
G1 X56.948 Y79.619 E.21639
G1 X58.176 Y79.619 E.02469
G1 X58.176 Y79.859 E.00483
G1 X60.155 Y79.859 E.03979
G1 X60.155 Y90.081 E.20553
M204 S250
G1 X60.565 Y90.55 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1800
M204 S5000
G1 X58.585 Y90.55 E.03699
G1 X58.585 Y90.79 E.00448
G1 X56.539 Y90.79 E.03823
G1 X56.539 Y79.21 E.21638
G1 X58.585 Y79.21 E.03823
G1 X58.585 Y79.45 E.00448
G1 X60.565 Y79.45 E.03699
G1 X60.565 Y90.49 E.20629
; WIPE_START
M204 S6000
G1 X58.585 Y90.55 E-.28223
G1 X58.585 Y90.569 E-.00277
; WIPE_END
G1 E-.015
M204 S10000
G1 X59.322 Y89.307 Z5.64 F18000
G1 Z5.24
G1 E.3 F1800
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.419992
G1 F2553
M204 S6000
G1 X59.322 Y80.693 E.16097
G1 X57.782 Y80.693 E.02878
G1 X57.782 Y89.307 E.16097
G1 X59.262 Y89.307 E.02766
; WIPE_START
G1 F3840
G1 X57.782 Y89.307 E-.21092
G1 X57.782 Y88.787 E-.07408
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X58.928 Y81.463 Z5.64 F18000
G1 Z5.24
G1 E.3 F1800
G1 F2553
M204 S6000
G1 X58.928 Y81.087 E.00702
G1 X58.176 Y81.087 E.01405
G1 X58.176 Y88.913 E.14623
G1 X58.928 Y88.913 E.01405
G1 X58.928 Y81.523 E.13809
; WIPE_START
G1 F3840
G1 X58.928 Y83.523 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X58.552 Y88.537 Z5.64 F18000
G1 Z5.24
G1 E.3 F1800
; Slow Down Start
; LINE_WIDTH: 0.383192
G1 F3000;_EXTRUDE_SET_SPEED
M204 S6000
G1 X58.552 Y81.523 E.11883
; Slow Down End
; CHANGE_LAYER
; Z_HEIGHT: 5.36
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F3000
G1 X58.552 Y83.523 E-.285
; WIPE_END
G1 E-.015 F1800
; layer num/total_layer_count: 44/74
; update layer progress
M73 L44
M991 S0 P43 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z5.64 I-.565 J1.078 P1  F18000
G1 X70.364 Y89.717 Z5.64
G1 Z5.36
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F2269
M204 S6000
G1 X70.364 Y80.283 E.18968
G1 X72.298 Y80.283 E.03889
G1 X72.298 Y80.043 E.00483
G1 X72.641 Y80.043 E.0069
G1 X72.641 Y89.957 E.19933
G1 X72.298 Y89.957 E.0069
G1 X72.298 Y89.717 E.00483
G1 X70.424 Y89.717 E.03768
M204 S10000
G1 X69.94 Y90.141 F18000
G1 F2269
M204 S6000
G1 X69.94 Y79.859 E.20674
M73 P73 R5
G1 X71.874 Y79.859 E.03888
G1 X71.874 Y79.619 E.00483
G1 X73.066 Y79.619 E.02397
G1 X73.066 Y90.381 E.21639
G1 X71.874 Y90.381 E.02397
G1 X71.874 Y90.141 E.00483
G1 X70 Y90.141 E.03767
M204 S250
G1 X69.531 Y90.55 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1800
M204 S5000
G1 X69.531 Y79.45 E.20741
G1 X71.464 Y79.45 E.03613
G1 X71.464 Y79.21 E.00448
G1 X73.475 Y79.21 E.03757
G1 X73.475 Y90.79 E.21638
G1 X71.464 Y90.79 E.03757
G1 X71.464 Y90.55 E.00448
G1 X69.591 Y90.55 E.035
; WIPE_START
M204 S6000
G1 X69.58 Y88.55 E-.285
; WIPE_END
G1 E-.015
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
G1 X0 Y85 ; move to safe pos
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




G1 X70.774 Y89.307
G1 Z5.36
G1 E.3 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.419992
G1 F2269
M204 S6000
G1 X72.232 Y89.307 E.02725
G1 X72.232 Y80.693 E.16097
G1 X70.774 Y80.693 E.02725
G1 X70.774 Y89.247 E.15984
M204 S10000
G1 X71.237 Y88.844 F18000
; LINE_WIDTH: 0.557872
G1 F2269
M204 S6000
G1 X71.769 Y88.844 E.01342
G1 X71.769 Y81.156 E.1939
G1 X71.237 Y81.156 E.01342
G1 X71.237 Y88.784 E.19239
; WIPE_START
G1 F4800
G1 X71.237 Y86.784 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X63.837 Y88.655 Z5.76 F18000
G1 X59.636 Y89.717 Z5.76
G1 Z5.36
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F2269
M204 S6000
G1 X57.703 Y89.717 E.03887
G1 X57.703 Y89.957 E.00483
G1 X57.359 Y89.957 E.00692
G1 X57.359 Y80.043 E.19933
G1 X57.703 Y80.043 E.00693
G1 X57.703 Y80.283 E.00483
G1 X59.636 Y80.283 E.03885
G1 X59.636 Y89.657 E.18847
M204 S10000
G1 X60.06 Y90.141 F18000
G1 F2269
M204 S6000
G1 X58.127 Y90.141 E.03887
G1 X58.127 Y90.381 E.00483
G1 X56.934 Y90.381 E.02398
G1 X56.934 Y79.619 E.21639
G1 X58.127 Y79.619 E.02399
G1 X58.127 Y79.859 E.00483
G1 X60.06 Y79.859 E.03886
G1 X60.06 Y90.081 E.20553
M204 S250
G1 X60.469 Y90.55 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1800
M204 S5000
G1 X58.536 Y90.55 E.03612
G1 X58.536 Y90.79 E.00448
G1 X56.525 Y90.79 E.03758
G1 X56.525 Y79.21 E.21638
G1 X58.536 Y79.21 E.03758
G1 X58.536 Y79.45 E.00448
G1 X60.469 Y79.45 E.03611
G1 X60.469 Y90.49 E.20629
; WIPE_START
M204 S6000
G1 X58.536 Y90.55 E-.27558
G1 X58.536 Y90.616 E-.00942
; WIPE_END
G1 E-.015
M204 S10000
G1 X59.107 Y83.005 Z5.76 F18000
G1 X59.226 Y81.422 Z5.76
G1 Z5.36
G1 E.3 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.419992
G1 F2269
M204 S6000
G1 X59.226 Y80.693 E.01363
G1 X57.768 Y80.693 E.02725
G1 X57.768 Y89.307 E.16097
G1 X59.226 Y89.307 E.02725
G1 X59.226 Y81.482 E.14622
M204 S10000
G1 X58.763 Y81.422 F18000
; LINE_WIDTH: 0.557922
G1 F2269
M204 S6000
G1 X58.763 Y81.156 E.00671
G1 X58.231 Y81.156 E.01342
G1 X58.231 Y88.844 E.19392
G1 X58.763 Y88.844 E.01342
G1 X58.763 Y81.482 E.18569
; CHANGE_LAYER
; Z_HEIGHT: 5.48
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F4800
G1 X58.763 Y83.482 E-.285
; WIPE_END
G1 E-.015 F1800
; layer num/total_layer_count: 45/74
; update layer progress
M73 L45
M991 S0 P44 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z5.76 I-.572 J1.074 P1  F18000
G1 X70.465 Y89.717 Z5.76
G1 Z5.48
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F2243
M204 S6000
G1 X70.465 Y80.283 E.18968
G1 X72.341 Y80.283 E.03772
G1 X72.341 Y80.043 E.00483
G1 X72.654 Y80.043 E.00628
G1 X72.654 Y89.957 E.19933
G1 X72.341 Y89.957 E.00628
G1 X72.341 Y89.717 E.00483
G1 X70.525 Y89.717 E.03652
M204 S10000
G1 X70.041 Y90.141 F18000
G1 F2243
M204 S6000
G1 X70.041 Y79.859 E.20674
G1 X71.917 Y79.859 E.03773
G1 X71.918 Y79.619 E.00483
G1 X73.078 Y79.619 E.02334
G1 X73.078 Y90.381 E.21639
G1 X71.918 Y90.381 E.02334
G1 X71.917 Y90.141 E.00483
G1 X70.101 Y90.141 E.03653
M204 S250
G1 X69.632 Y90.55 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1800
M204 S5000
G1 X69.632 Y79.45 E.20741
G1 X71.508 Y79.45 E.03507
G1 X71.509 Y79.21 E.00448
G1 X73.487 Y79.21 E.03697
G1 X73.487 Y90.79 E.21638
G1 X71.509 Y90.79 E.03697
G1 X71.508 Y90.55 E.00448
G1 X69.692 Y90.55 E.03395
; WIPE_START
M204 S6000
G1 X69.681 Y88.55 E-.285
; WIPE_END
G1 E-.015
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
G1 X0 Y85 ; move to safe pos
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




G1 X70.874 Y89.307
G1 Z5.48
G1 E.3 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.419992
G1 F2243
M204 S6000
M73 P74 R5
G1 X72.245 Y89.307 E.0256
G1 X72.245 Y80.693 E.16097
G1 X70.874 Y80.693 E.0256
G1 X70.874 Y89.247 E.15984
M204 S10000
G1 X71.315 Y88.866 F18000
; LINE_WIDTH: 0.513777
G1 F2243
M204 S6000
G1 X71.803 Y88.866 E.01129
G1 X71.803 Y81.134 E.17885
G1 X71.315 Y81.134 E.01129
G1 X71.315 Y88.806 E.17746
; WIPE_START
G1 F4800
G1 X71.315 Y86.806 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X63.906 Y88.637 Z5.88 F18000
G1 X59.535 Y89.717 Z5.88
G1 Z5.48
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F2243
M204 S6000
G1 X57.658 Y89.717 E.03775
G1 X57.658 Y89.957 E.00483
G1 X57.346 Y89.957 E.00627
G1 X57.346 Y80.043 E.19933
G1 X57.658 Y80.043 E.00628
G1 X57.658 Y80.283 E.00483
G1 X59.535 Y80.283 E.03774
G1 X59.535 Y89.657 E.18847
M204 S10000
G1 X59.959 Y90.141 F18000
G1 F2243
M204 S6000
G1 X58.082 Y90.141 E.03775
G1 X58.082 Y90.381 E.00483
G1 X56.922 Y90.381 E.02333
G1 X56.922 Y79.619 E.21639
G1 X58.082 Y79.619 E.02333
G1 X58.082 Y79.859 E.00483
G1 X59.959 Y79.859 E.03774
G1 X59.959 Y90.081 E.20553
M204 S250
G1 X60.368 Y90.55 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1800
M204 S5000
G1 X58.491 Y90.55 E.03508
G1 X58.491 Y90.79 E.00448
G1 X56.513 Y90.79 E.03697
G1 X56.513 Y79.21 E.21638
G1 X58.491 Y79.21 E.03697
G1 X58.491 Y79.45 E.00448
G1 X60.368 Y79.45 E.03508
G1 X60.368 Y90.49 E.20629
; WIPE_START
M204 S6000
G1 X58.491 Y90.55 E-.26764
G1 X58.491 Y90.672 E-.01736
; WIPE_END
G1 E-.015
M204 S10000
G1 X59.011 Y83.057 Z5.88 F18000
G1 X59.126 Y81.378 Z5.88
G1 Z5.48
G1 E.3 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.419992
G1 F2243
M204 S6000
G1 X59.126 Y80.693 E.0128
G1 X57.755 Y80.693 E.02561
G1 X57.755 Y89.307 E.16097
G1 X59.126 Y89.307 E.02561
G1 X59.126 Y81.438 E.14704
M204 S10000
G1 X58.685 Y81.378 F18000
; LINE_WIDTH: 0.513852
G1 F2243
M204 S6000
G1 X58.685 Y81.134 E.00565
G1 X58.196 Y81.134 E.01129
G1 X58.196 Y88.866 E.17888
G1 X58.685 Y88.866 E.01129
G1 X58.685 Y81.438 E.17184
; CHANGE_LAYER
; Z_HEIGHT: 5.6
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F4800
G1 X58.685 Y83.438 E-.285
; WIPE_END
G1 E-.015 F1800
; layer num/total_layer_count: 46/74
; update layer progress
M73 L46
M991 S0 P45 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z5.88 I-.568 J1.076 P1  F18000
G1 X70.571 Y89.717 Z5.88
G1 Z5.6
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F2224
M204 S6000
G1 X70.571 Y80.283 E.18968
G1 X72.383 Y80.283 E.03643
G1 X72.383 Y80.043 E.00483
G1 X72.665 Y80.043 E.00567
G1 X72.665 Y89.957 E.19933
G1 X72.383 Y89.957 E.00567
G1 X72.383 Y89.717 E.00483
G1 X70.631 Y89.717 E.03523
M204 S10000
G1 X70.147 Y90.141 F18000
G1 F2224
M204 S6000
G1 X70.147 Y79.859 E.20674
G1 X71.959 Y79.859 E.03643
G1 X71.959 Y79.619 E.00483
G1 X73.089 Y79.619 E.02273
G1 X73.089 Y90.381 E.21639
G1 X71.959 Y90.381 E.02273
G1 X71.959 Y90.141 E.00483
G1 X70.207 Y90.141 E.03522
M204 S250
G1 X69.738 Y90.55 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1800
M204 S5000
G1 X69.738 Y79.45 E.20741
G1 X71.55 Y79.45 E.03385
G1 X71.55 Y79.21 E.00448
G1 X73.499 Y79.21 E.03642
G1 X73.499 Y90.79 E.21638
G1 X71.55 Y90.79 E.03642
G1 X71.55 Y90.55 E.00448
G1 X69.798 Y90.55 E.03273
; WIPE_START
M204 S6000
G1 X69.787 Y88.55 E-.285
; WIPE_END
G1 E-.015
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
G1 X0 Y85 ; move to safe pos
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




G1 X70.981 Y89.307
G1 Z5.6
G1 E.3 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.419992
G1 F2224
M204 S6000
G1 X72.256 Y89.307 E.02383
G1 X72.256 Y80.693 E.16097
M73 P74 R4
G1 X70.981 Y80.693 E.02383
G1 X70.981 Y89.247 E.15984
M204 S10000
G1 X71.398 Y88.89 F18000
; LINE_WIDTH: 0.466242
G1 F2224
M204 S6000
G1 X71.839 Y88.89 E.0092
G1 X71.839 Y81.11 E.16242
G1 X71.398 Y81.11 E.0092
G1 X71.398 Y88.83 E.16117
; WIPE_START
G1 F4800
G1 X71.398 Y86.83 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X63.978 Y88.619 Z6 F18000
G1 X59.429 Y89.717 Z6
G1 Z5.6
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F2224
M204 S6000
G1 X57.617 Y89.717 E.03643
G1 X57.617 Y89.957 E.00483
G1 X57.335 Y89.957 E.00567
G1 X57.335 Y80.043 E.19933
G1 X57.617 Y80.043 E.00567
G1 X57.617 Y80.283 E.00483
G1 X59.429 Y80.283 E.03643
G1 X59.429 Y89.657 E.18847
M204 S10000
G1 X59.853 Y90.141 F18000
G1 F2224
M204 S6000
G1 X58.041 Y90.141 E.03643
G1 X58.041 Y90.381 E.00483
G1 X56.911 Y90.381 E.02273
G1 X56.911 Y79.619 E.21639
G1 X58.041 Y79.619 E.02273
G1 X58.041 Y79.859 E.00483
G1 X59.853 Y79.859 E.03643
G1 X59.853 Y90.081 E.20553
M204 S250
G1 X60.262 Y90.55 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
M73 P75 R4
G1 F1800
M204 S5000
G1 X58.45 Y90.55 E.03385
G1 X58.45 Y90.79 E.00448
G1 X56.501 Y90.79 E.03642
G1 X56.501 Y79.21 E.21638
G1 X58.45 Y79.21 E.03642
G1 X58.45 Y79.45 E.00448
G1 X60.262 Y79.45 E.03385
G1 X60.262 Y90.49 E.20629
; WIPE_START
M204 S6000
G1 X58.45 Y90.55 E-.25831
G1 X58.45 Y90.737 E-.02669
; WIPE_END
G1 E-.015
M204 S10000
G1 X58.911 Y83.119 Z6 F18000
G1 X59.019 Y81.33 Z6
G1 Z5.6
G1 E.3 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.419992
G1 F2224
M204 S6000
G1 X59.019 Y80.693 E.01191
G1 X57.744 Y80.693 E.02383
G1 X57.744 Y89.307 E.16097
G1 X59.019 Y89.307 E.02383
G1 X59.019 Y81.39 E.14793
M204 S10000
G1 X58.602 Y81.33 F18000
; LINE_WIDTH: 0.466302
G1 F2224
M204 S6000
G1 X58.602 Y81.11 E.0046
G1 X58.161 Y81.11 E.0092
G1 X58.161 Y88.89 E.16244
G1 X58.602 Y88.89 E.0092
G1 X58.602 Y81.39 E.15659
; CHANGE_LAYER
; Z_HEIGHT: 5.72
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F4800
G1 X58.602 Y83.39 E-.285
; WIPE_END
G1 E-.015 F1800
; layer num/total_layer_count: 47/74
; update layer progress
M73 L47
M991 S0 P46 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z6 I-.565 J1.078 P1  F18000
G1 X70.683 Y89.717 Z6
G1 Z5.72
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F2289
M204 S6000
G1 X70.683 Y80.283 E.18968
G1 X72.675 Y80.283 E.04006
G1 X72.675 Y89.717 E.18968
G1 X70.743 Y89.717 E.03885
M204 S10000
G1 X70.259 Y90.141 F18000
G1 F2289
M204 S6000
G1 X70.259 Y79.859 E.20674
G1 X71.997 Y79.859 E.03495
G1 X71.997 Y79.619 E.00483
G1 X73.099 Y79.619 E.02217
G1 X73.099 Y90.381 E.21639
G1 X71.997 Y90.381 E.02217
G1 X71.997 Y90.141 E.00483
G1 X70.319 Y90.141 E.03374
M204 S250
G1 X69.85 Y90.55 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1800
M204 S5000
G1 X69.85 Y79.45 E.20741
G1 X71.587 Y79.45 E.03247
G1 X71.587 Y79.21 E.00448
G1 X73.509 Y79.21 E.0359
G1 X73.509 Y90.79 E.21638
G1 X71.587 Y90.79 E.0359
G1 X71.587 Y90.55 E.00448
G1 X69.91 Y90.55 E.03135
; WIPE_START
M204 S6000
G1 X69.899 Y88.55 E-.285
; WIPE_END
G1 E-.015
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
G1 X0 Y85 ; move to safe pos
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




G1 X72.209 Y90.049
G1 Z5.72
G1 E.3 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.265652
G1 F2289
M204 S6000
G1 X72.887 Y90.049 E.00771
; WIPE_START
G1 F2400
G1 X72.209 Y90.049 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X71.304 Y82.47 Z6.12 F18000
G1 X71.092 Y80.693 Z6.12
G1 Z5.72
G1 E.3 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.419992
G1 F2289
M204 S6000
G1 X71.092 Y89.307 E.16097
G1 X72.266 Y89.307 E.02193
G1 X72.266 Y80.693 E.16097
G1 X71.152 Y80.693 E.02081
M204 S10000
G1 X71.484 Y81.28 F18000
; LINE_WIDTH: 0.415452
G1 F2289
M204 S6000
G1 X71.484 Y88.915 E.14103
G1 X71.874 Y88.915 E.0072
G1 X71.874 Y81.085 E.14463
G1 X71.484 Y81.085 E.0072
G1 X71.484 Y81.22 E.00249
; WIPE_START
G1 F4800
G1 X71.484 Y81.085 E-.01922
G1 X71.874 Y81.085 E-.05553
G1 X71.874 Y82.56 E-.21025
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X72.209 Y79.951 Z6.12 F18000
G1 Z5.72
G1 E.3 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.265652
G1 F2289
M204 S6000
G1 X72.887 Y79.951 E.00771
; WIPE_START
G1 F2400
G1 X72.209 Y79.951 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X66.125 Y84.56 Z6.12 F18000
G1 X59.317 Y89.717 Z6.12
G1 Z5.72
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F2289
M204 S6000
G1 X57.325 Y89.717 E.04006
G1 X57.325 Y80.043 E.1945
G1 X57.579 Y80.043 E.00512
G1 X57.579 Y80.283 E.00483
G1 X59.317 Y80.283 E.03494
G1 X59.317 Y89.657 E.18847
M204 S10000
G1 X59.741 Y90.141 F18000
G1 F2289
M204 S6000
G1 X58.003 Y90.141 E.03494
G1 X58.004 Y90.381 E.00483
G1 X56.901 Y90.381 E.02218
G1 X56.901 Y79.619 E.21639
G1 X58.004 Y79.619 E.02218
G1 X58.004 Y79.859 E.00483
G1 X59.741 Y79.859 E.03494
G1 X59.741 Y90.081 E.20553
M204 S250
G1 X60.15 Y90.55 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1800
M204 S5000
G1 X58.413 Y90.55 E.03247
G1 X58.413 Y90.79 E.00448
G1 X56.491 Y90.79 E.03591
G1 X56.491 Y79.21 E.21638
G1 X58.413 Y79.21 E.0359
G1 X58.413 Y79.45 E.00448
G1 X60.15 Y79.45 E.03247
G1 X60.15 Y90.49 E.20629
; WIPE_START
M204 S6000
G1 X58.413 Y90.55 E-.24777
G1 X58.413 Y90.79 E-.0342
G1 X58.392 Y90.79 E-.00303
; WIPE_END
G1 E-.015
M204 S10000
M73 P76 R4
G1 X57.791 Y90.049 Z6.12 F18000
G1 Z5.72
G1 E.3 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.265652
G1 F2289
M204 S6000
G1 X57.113 Y90.049 E.00772
; WIPE_START
G1 F2400
G1 X57.791 Y90.049 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X58.755 Y82.477 Z6.12 F18000
G1 X58.908 Y81.28 Z6.12
G1 Z5.72
G1 E.3 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.419992
G1 F2289
M204 S6000
G1 X58.908 Y80.693 E.01097
G1 X57.734 Y80.693 E.02193
G1 X57.734 Y89.307 E.16097
G1 X58.908 Y89.307 E.02193
G1 X58.908 Y81.34 E.14888
M204 S10000
G1 X58.516 Y81.28 F18000
; LINE_WIDTH: 0.415492
G1 F2289
M204 S6000
G1 X58.516 Y81.085 E.0036
G1 X58.126 Y81.085 E.0072
G1 X58.126 Y88.915 E.14465
G1 X58.516 Y88.915 E.0072
G1 X58.516 Y81.34 E.13994
; CHANGE_LAYER
; Z_HEIGHT: 5.84
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F4800
G1 X58.516 Y83.34 E-.285
; WIPE_END
G1 E-.015 F1800
; layer num/total_layer_count: 48/74
; update layer progress
M73 L48
M991 S0 P47 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z6.12 I-.561 J1.08 P1  F18000
G1 X70.801 Y89.717 Z6.12
G1 Z5.84
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F2298
M204 S6000
G1 X70.801 Y80.283 E.18968
G1 X72.684 Y80.283 E.03786
G1 X72.684 Y89.717 E.18968
G1 X70.861 Y89.717 E.03666
M204 S10000
G1 X70.377 Y90.141 F18000
G1 F2298
M204 S6000
G1 X70.377 Y79.859 E.20674
G1 X72.03 Y79.859 E.03325
G1 X72.03 Y79.619 E.00483
G1 X73.108 Y79.619 E.02167
G1 X73.108 Y90.381 E.21639
G1 X72.03 Y90.381 E.02167
G1 X72.03 Y90.141 E.00483
G1 X70.437 Y90.141 E.03204
M204 S250
G1 X69.967 Y90.55 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1800
M204 S5000
G1 X69.967 Y79.45 E.20741
G1 X71.621 Y79.45 E.0309
G1 X71.621 Y79.21 E.00448
G1 X73.517 Y79.21 E.03543
G1 X73.517 Y90.79 E.21638
G1 X71.621 Y90.79 E.03543
G1 X71.621 Y90.55 E.00448
G1 X70.027 Y90.55 E.02978
; WIPE_START
M204 S6000
G1 X70.017 Y88.55 E-.285
; WIPE_END
G1 E-.015
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
G1 X0 Y85 ; move to safe pos
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




G1 X71.21 Y89.307
G1 Z5.84
G1 E.3 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.419992
G1 F2298
M204 S6000
G1 X72.275 Y89.307 E.01989
G1 X72.275 Y80.693 E.16097
G1 X71.21 Y80.693 E.01989
G1 X71.21 Y89.247 E.15984
M204 S10000
G1 X71.575 Y88.943 F18000
; LINE_WIDTH: 0.360912
G1 F2298
M204 S6000
G1 X71.91 Y88.943 E.00532
G1 X71.91 Y81.057 E.12526
G1 X71.575 Y81.057 E.00532
G1 X71.575 Y88.883 E.1243
; WIPE_START
G1 F4800
G1 X71.575 Y86.883 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X72.242 Y90.049 Z6.24 F18000
G1 Z5.84
G1 E.3 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.265652
G1 F2298
M204 S6000
G1 X72.896 Y90.049 E.00743
; WIPE_START
G1 F2400
G1 X72.242 Y90.049 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X72.735 Y82.432 Z6.24 F18000
G1 X72.896 Y79.951 Z6.24
G1 Z5.84
G1 E.3 F1800
G1 F2298
M204 S6000
G1 X72.242 Y79.951 E.00743
; WIPE_START
G1 F2400
G1 X72.896 Y79.951 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X66.681 Y84.382 Z6.24 F18000
G1 X59.199 Y89.717 Z6.24
G1 Z5.84
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F2298
M204 S6000
G1 X57.316 Y89.717 E.03786
G1 X57.316 Y80.283 E.18968
G1 X59.199 Y80.283 E.03786
G1 X59.199 Y89.657 E.18847
M204 S10000
G1 X59.623 Y90.141 F18000
G1 F2298
M204 S6000
G1 X57.969 Y90.141 E.03326
G1 X57.969 Y90.381 E.00483
G1 X56.892 Y90.381 E.02166
G1 X56.892 Y79.619 E.21639
G1 X57.969 Y79.619 E.02166
G1 X57.969 Y79.859 E.00483
G1 X59.623 Y79.859 E.03326
G1 X59.623 Y90.081 E.20553
M204 S250
G1 X60.033 Y90.55 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1800
M204 S5000
G1 X58.378 Y90.55 E.03091
G1 X58.378 Y90.79 E.00448
G1 X56.483 Y90.79 E.03542
G1 X56.483 Y79.21 E.21638
G1 X58.378 Y79.21 E.03542
G1 X58.379 Y79.45 E.00448
G1 X60.033 Y79.45 E.03091
G1 X60.033 Y90.49 E.20629
; WIPE_START
M204 S6000
G1 X58.378 Y90.55 E-.23588
G1 X58.378 Y90.79 E-.0342
G1 X58.274 Y90.79 E-.01492
; WIPE_END
G1 E-.015
M204 S10000
G1 X57.757 Y90.049 Z6.24 F18000
G1 Z5.84
G1 E.3 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.265652
G1 F2298
M204 S6000
G1 X57.104 Y90.049 E.00742
; WIPE_START
G1 F2400
G1 X57.757 Y90.049 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X58.644 Y82.468 Z6.24 F18000
G1 X58.79 Y81.225 Z6.24
G1 Z5.84
G1 E.3 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.419992
G1 F2298
M204 S6000
G1 X58.79 Y80.693 E.00994
G1 X57.725 Y80.693 E.01989
G1 X57.725 Y89.307 E.16097
G1 X58.79 Y89.307 E.01989
G1 X58.79 Y81.285 E.1499
M204 S10000
G1 X58.425 Y81.225 F18000
; LINE_WIDTH: 0.360852
G1 F2298
M204 S6000
G1 X58.425 Y81.057 E.00266
G1 X58.09 Y81.057 E.00532
G1 X58.09 Y88.943 E.12524
G1 X58.425 Y88.943 E.00532
G1 X58.425 Y81.285 E.12162
; WIPE_START
G1 F4800
G1 X58.425 Y83.285 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X57.757 Y79.951 Z6.24 F18000
G1 Z5.84
G1 E.3 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.265652
M73 P77 R4
G1 F2298
M204 S6000
G1 X57.104 Y79.951 E.00743
; CHANGE_LAYER
; Z_HEIGHT: 5.96
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F2400
G1 X57.757 Y79.951 E-.285
; WIPE_END
G1 E-.015 F1800
; layer num/total_layer_count: 49/74
; update layer progress
M73 L49
M991 S0 P48 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z6.24 I-.725 J.977 P1  F18000
G1 X70.923 Y89.717 Z6.24
G1 Z5.96
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F2098
M204 S6000
G1 X70.923 Y80.283 E.18968
G1 X72.691 Y80.283 E.03555
G1 X72.691 Y89.717 E.18968
G1 X70.983 Y89.717 E.03434
M204 S10000
G1 X70.499 Y90.141 F18000
G1 F2098
M204 S6000
G1 X70.499 Y79.859 E.20674
G1 X72.062 Y79.859 E.03142
G1 X72.062 Y79.619 E.00483
G1 X73.116 Y79.619 E.02119
G1 X73.116 Y90.381 E.21639
G1 X72.062 Y90.381 E.02119
G1 X72.062 Y90.141 E.00483
G1 X70.559 Y90.141 E.03022
M204 S250
G1 X70.09 Y90.55 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1800
M204 S5000
G1 X70.09 Y79.45 E.20741
G1 X71.653 Y79.45 E.0292
G1 X71.653 Y79.21 E.00448
G1 X73.525 Y79.21 E.03498
G1 X73.525 Y90.79 E.21638
G1 X71.653 Y90.79 E.03498
G1 X71.653 Y90.55 E.00448
G1 X70.15 Y90.55 E.02808
; WIPE_START
M204 S6000
G1 X70.139 Y88.55 E-.285
; WIPE_END
G1 E-.015
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
G1 X0 Y85 ; move to safe pos
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




G1 X72.274 Y90.049
G1 Z5.96
G1 E.3 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.265652
G1 F2098
M204 S6000
G1 X72.903 Y90.049 E.00716
; WIPE_START
G1 F2400
G1 X72.274 Y90.049 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X71.51 Y82.455 Z6.36 F18000
G1 X71.333 Y80.693 Z6.36
G1 Z5.96
G1 E.3 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.419992
G1 F2098
M204 S6000
G1 X71.333 Y89.307 E.16097
G1 X72.282 Y89.307 E.01774
G1 X72.282 Y80.693 E.16097
G1 X71.393 Y80.693 E.01662
; WIPE_START
G1 F4800
G1 X72.282 Y80.693 E-.12675
G1 X72.282 Y81.803 E-.15825
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X71.807 Y88.833 Z6.36 F18000
G1 Z5.96
G1 E.3 F1800
; LINE_WIDTH: 0.580942
G1 F2098
M204 S6000
G1 X71.807 Y81.227 E.20012
; WIPE_START
G1 F4800
G1 X71.807 Y83.227 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X72.274 Y79.951 Z6.36 F18000
G1 Z5.96
G1 E.3 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.265652
G1 F2098
M204 S6000
G1 X72.904 Y79.951 E.00716
; WIPE_START
G1 F2400
G1 X72.274 Y79.951 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X66.139 Y84.491 Z6.36 F18000
G1 X59.077 Y89.717 Z6.36
G1 Z5.96
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F2098
M204 S6000
G1 X57.309 Y89.717 E.03555
G1 X57.309 Y80.283 E.18968
G1 X59.077 Y80.283 E.03555
G1 X59.077 Y89.657 E.18847
M204 S10000
G1 X59.501 Y90.141 F18000
G1 F2098
M204 S6000
G1 X57.938 Y90.141 E.03142
G1 X57.938 Y90.381 E.00483
G1 X56.884 Y90.381 E.02119
G1 X56.884 Y79.619 E.21639
G1 X57.938 Y79.619 E.02119
G1 X57.938 Y79.859 E.00483
G1 X59.501 Y79.859 E.03142
G1 X59.501 Y90.081 E.20553
M204 S250
G1 X59.91 Y90.55 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1800
M204 S5000
G1 X58.347 Y90.55 E.0292
G1 X58.347 Y90.79 E.00448
G1 X56.475 Y90.79 E.03498
G1 X56.475 Y79.21 E.21638
G1 X58.347 Y79.21 E.03498
G1 X58.347 Y79.45 E.00448
G1 X59.91 Y79.45 E.0292
G1 X59.91 Y90.49 E.20629
; WIPE_START
M204 S6000
G1 X58.347 Y90.55 E-.22285
G1 X58.347 Y90.79 E-.0342
G1 X58.151 Y90.79 E-.02795
; WIPE_END
G1 E-.015
M204 S10000
G1 X57.726 Y90.049 Z6.36 F18000
G1 Z5.96
G1 E.3 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.265652
G1 F2098
M204 S6000
G1 X57.097 Y90.049 E.00716
; WIPE_START
G1 F2400
G1 X57.726 Y90.049 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X58.53 Y82.459 Z6.36 F18000
G1 X58.667 Y81.167 Z6.36
G1 Z5.96
G1 E.3 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.419992
G1 F2098
M204 S6000
G1 X58.667 Y80.693 E.00887
G1 X57.718 Y80.693 E.01774
G1 X57.718 Y89.307 E.16097
G1 X58.667 Y89.307 E.01774
G1 X58.667 Y81.227 E.15098
; WIPE_START
G1 F4800
G1 X58.667 Y83.227 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X58.193 Y88.833 Z6.36 F18000
G1 Z5.96
G1 E.3 F1800
; LINE_WIDTH: 0.580812
G1 F2098
M204 S6000
G1 X58.193 Y81.227 E.20008
; WIPE_START
G1 F4800
G1 X58.193 Y83.227 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X57.726 Y79.951 Z6.36 F18000
G1 Z5.96
G1 E.3 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.265652
G1 F2098
M204 S6000
G1 X57.097 Y79.951 E.00716
; CHANGE_LAYER
; Z_HEIGHT: 6.08
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F2400
G1 X57.726 Y79.951 E-.285
; WIPE_END
G1 E-.015 F1800
; layer num/total_layer_count: 50/74
; update layer progress
M73 L50
M991 S0 P49 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z6.36 I-.72 J.981 P1  F18000
G1 X71.043 Y89.717 Z6.36
G1 Z6.08
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F2041
M204 S6000
G1 X71.043 Y80.283 E.18968
G1 X72.697 Y80.283 E.03326
G1 X72.697 Y89.717 E.18968
G1 X71.103 Y89.717 E.03205
M204 S10000
G1 X70.619 Y90.141 F18000
G1 F2041
M204 S6000
G1 X70.619 Y79.859 E.20674
G1 X72.091 Y79.859 E.02959
M73 P78 R4
G1 X72.091 Y79.619 E.00483
G1 X73.122 Y79.619 E.02073
G1 X73.122 Y90.381 E.21639
G1 X72.091 Y90.381 E.02073
G1 X72.091 Y90.141 E.00483
G1 X70.679 Y90.141 E.02838
M204 S250
G1 X70.21 Y90.55 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1800
M204 S5000
G1 X70.21 Y79.45 E.20741
G1 X71.681 Y79.45 E.0275
G1 X71.682 Y79.21 E.00448
G1 X73.531 Y79.21 E.03456
G1 X73.531 Y90.79 E.21638
G1 X71.682 Y90.79 E.03456
G1 X71.681 Y90.55 E.00448
G1 X70.27 Y90.55 E.02637
; WIPE_START
M204 S6000
G1 X70.259 Y88.55 E-.285
; WIPE_END
G1 E-.015
M204 S10000
G17
G3 Z6.48 I1.217 J0 P1  F18000
;===================== date: 20250206 =====================

; don't support timelapse gcode in spiral_mode and by object sequence for I3 structure printer
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
G92 E0
G1 Z6.48
G1 X0 Y85 ; move to safe pos
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
            G0 Z6.48 F4000
            G39.3 S1
            G0 Z6.48 F4000
            G392 S0
          
        M623
    
    M623
M623
; SKIPPABLE_END




G1 X71.453 Y89.307
G1 Z6.08
G1 E.3 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.419992
G1 F2041
M204 S6000
G1 X72.288 Y89.307 E.01561
G1 X72.288 Y80.693 E.16097
G1 X71.453 Y80.693 E.01561
G1 X71.453 Y89.247 E.15984
M204 S10000
G1 X71.87 Y88.89 F18000
; LINE_WIDTH: 0.466912
G1 F2041
M204 S6000
G1 X71.87 Y81.17 E.1614
; WIPE_START
G1 F4800
G1 X71.87 Y83.17 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X72.303 Y79.951 Z6.48 F18000
G1 Z6.08
G1 E.3 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.265652
G1 F2041
M204 S6000
G1 X72.909 Y79.951 E.0069
; WIPE_START
G1 F2400
G1 X72.303 Y79.951 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X72.761 Y87.57 Z6.48 F18000
G1 X72.909 Y90.049 Z6.48
G1 Z6.08
G1 E.3 F1800
G1 F2041
M204 S6000
G1 X72.303 Y90.049 E.0069
; WIPE_START
G1 F2400
G1 X72.909 Y90.049 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X65.279 Y89.867 Z6.48 F18000
G1 X58.957 Y89.717 Z6.48
G1 Z6.08
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F2041
M204 S6000
G1 X57.303 Y89.717 E.03326
G1 X57.303 Y80.283 E.18968
G1 X58.957 Y80.283 E.03326
G1 X58.957 Y89.657 E.18847
M204 S10000
G1 X59.381 Y90.141 F18000
G1 F2041
M204 S6000
G1 X57.909 Y90.141 E.02959
G1 X57.909 Y90.381 E.00483
G1 X56.878 Y90.381 E.02073
G1 X56.878 Y79.619 E.21639
G1 X57.91 Y79.619 E.02073
G1 X57.91 Y79.859 E.00483
G1 X59.381 Y79.859 E.02958
G1 X59.381 Y90.081 E.20553
M204 S250
G1 X59.79 Y90.55 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1800
M204 S5000
G1 X58.319 Y90.55 E.0275
G1 X58.318 Y90.79 E.00448
G1 X56.469 Y90.79 E.03456
G1 X56.469 Y79.21 E.21638
G1 X58.318 Y79.21 E.03456
G1 X58.319 Y79.45 E.00448
G1 X59.79 Y79.45 E.02749
G1 X59.79 Y90.49 E.20629
; WIPE_START
M204 S6000
G1 X58.319 Y90.55 E-.20986
G1 X58.318 Y90.79 E-.0342
G1 X58.031 Y90.79 E-.04094
; WIPE_END
G1 E-.015
M204 S10000
G1 X57.697 Y90.049 Z6.48 F18000
G1 Z6.08
G1 E.3 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.265652
G1 F2041
M204 S6000
G1 X57.09 Y90.049 E.0069
; WIPE_START
G1 F2400
G1 X57.697 Y90.049 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X58.42 Y82.451 Z6.48 F18000
G1 X58.547 Y81.11 Z6.48
G1 Z6.08
G1 E.3 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.419992
G1 F2041
M204 S6000
G1 X58.547 Y80.693 E.00781
G1 X57.712 Y80.693 E.01561
G1 X57.712 Y89.307 E.16097
G1 X58.547 Y89.307 E.01561
G1 X58.547 Y81.17 E.15204
; WIPE_START
G1 F4800
G1 X58.547 Y83.17 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X58.13 Y88.89 Z6.48 F18000
G1 Z6.08
G1 E.3 F1800
; LINE_WIDTH: 0.466952
G1 F2041
M204 S6000
G1 X58.13 Y81.17 E.16142
; WIPE_START
G1 F4800
G1 X58.13 Y83.17 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X57.698 Y79.951 Z6.48 F18000
G1 Z6.08
G1 E.3 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.265652
G1 F2041
M204 S6000
G1 X57.09 Y79.951 E.0069
; CHANGE_LAYER
; Z_HEIGHT: 6.2
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F2400
G1 X57.698 Y79.951 E-.285
; WIPE_END
G1 E-.015 F1800
; layer num/total_layer_count: 51/74
; update layer progress
M73 L51
M991 S0 P50 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z6.48 I-.714 J.985 P1  F18000
G1 X71.163 Y89.717 Z6.48
G1 Z6.2
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F2017
M204 S6000
G1 X71.163 Y80.283 E.18968
G1 X72.702 Y80.283 E.03094
G1 X72.702 Y89.717 E.18968
G1 X71.223 Y89.717 E.02973
M204 S10000
G1 X70.739 Y90.141 F18000
G1 F2017
M204 S6000
G1 X70.739 Y79.859 E.20674
G1 X72.117 Y79.859 E.0277
G1 X72.117 Y79.619 E.00483
G1 X73.126 Y79.619 E.0203
G1 X73.126 Y90.381 E.21639
G1 X72.117 Y90.381 E.0203
G1 X72.117 Y90.141 E.00483
G1 X70.799 Y90.141 E.0265
M204 S250
G1 X70.33 Y90.55 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1800
M204 S5000
G1 X70.33 Y79.45 E.20741
G1 X71.708 Y79.45 E.02574
G1 X71.708 Y79.21 E.00448
G1 X73.536 Y79.21 E.03415
G1 X73.536 Y90.79 E.21638
G1 X71.708 Y90.79 E.03415
G1 X71.708 Y90.55 E.00448
M73 P79 R4
G1 X70.39 Y90.55 E.02462
; WIPE_START
M204 S6000
G1 X70.379 Y88.55 E-.285
; WIPE_END
G1 E-.015
M204 S10000
G17
G3 Z6.6 I1.217 J0 P1  F18000
;===================== date: 20250206 =====================

; don't support timelapse gcode in spiral_mode and by object sequence for I3 structure printer
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
G92 E0
G1 Z6.6
G1 X0 Y85 ; move to safe pos
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
            G0 Z6.6 F4000
            G39.3 S1
            G0 Z6.6 F4000
            G392 S0
          
        M623
    
    M623
M623
; SKIPPABLE_END




G1 X71.573 Y89.307
G1 Z6.2
G1 E.3 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.419992
G1 F2017
M204 S6000
G1 X72.293 Y89.307 E.01346
G1 X72.293 Y80.693 E.16097
G1 X71.573 Y80.693 E.01346
G1 X71.573 Y89.247 E.15984
M204 S10000
G1 X71.933 Y88.947 F18000
; LINE_WIDTH: 0.351672
G1 F2017
M204 S6000
G1 X71.933 Y81.113 E.12102
; WIPE_START
G1 F4800
G1 X71.933 Y83.113 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X72.329 Y79.951 Z6.6 F18000
G1 Z6.2
G1 E.3 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.265652
G1 F2017
M204 S6000
G1 X72.914 Y79.951 E.00665
; WIPE_START
G1 F2400
G1 X72.329 Y79.951 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X72.771 Y87.571 Z6.6 F18000
G1 X72.914 Y90.049 Z6.6
G1 Z6.2
G1 E.3 F1800
G1 F2017
M204 S6000
G1 X72.329 Y90.049 E.00665
; WIPE_START
G1 F2400
G1 X72.914 Y90.049 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X65.284 Y89.869 Z6.6 F18000
G1 X58.837 Y89.717 Z6.6
G1 Z6.2
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F2017
M204 S6000
G1 X57.298 Y89.717 E.03094
G1 X57.298 Y80.283 E.18968
G1 X58.837 Y80.283 E.03094
G1 X58.837 Y89.657 E.18847
M204 S10000
G1 X59.261 Y90.141 F18000
G1 F2017
M204 S6000
G1 X57.883 Y90.141 E.02771
G1 X57.883 Y90.381 E.00483
G1 X56.874 Y90.381 E.02029
G1 X56.874 Y79.619 E.21639
G1 X57.883 Y79.619 E.0203
G1 X57.883 Y79.859 E.00483
G1 X59.261 Y79.859 E.0277
G1 X59.261 Y90.081 E.20553
M204 S250
G1 X59.67 Y90.55 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1800
M204 S5000
G1 X58.292 Y90.55 E.02575
G1 X58.292 Y90.79 E.00448
G1 X56.464 Y90.79 E.03415
G1 X56.464 Y79.21 E.21638
G1 X58.292 Y79.21 E.03415
G1 X58.292 Y79.45 E.00448
G1 X59.67 Y79.45 E.02574
G1 X59.67 Y90.49 E.20629
; WIPE_START
M204 S6000
G1 X58.292 Y90.55 E-.19654
G1 X58.292 Y90.79 E-.0342
G1 X57.911 Y90.79 E-.05426
; WIPE_END
G1 E-.015
M204 S10000
G1 X57.671 Y90.049 Z6.6 F18000
G1 Z6.2
G1 E.3 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.265652
G1 F2017
M204 S6000
G1 X57.086 Y90.049 E.00665
; WIPE_START
G1 F2400
G1 X57.671 Y90.049 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X58.31 Y82.443 Z6.6 F18000
G1 X58.427 Y81.053 Z6.6
G1 Z6.2
G1 E.3 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.419992
G1 F2017
M204 S6000
G1 X58.427 Y80.693 E.00673
G1 X57.707 Y80.693 E.01346
G1 X57.707 Y89.307 E.16097
G1 X58.427 Y89.307 E.01346
G1 X58.427 Y81.113 E.15312
; WIPE_START
G1 F4800
G1 X58.427 Y83.113 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X58.067 Y88.947 Z6.6 F18000
G1 Z6.2
G1 E.3 F1800
; LINE_WIDTH: 0.351792
G1 F2017
M204 S6000
G1 X58.067 Y81.113 E.12106
; WIPE_START
G1 F4800
G1 X58.067 Y83.113 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X57.671 Y79.951 Z6.6 F18000
G1 Z6.2
G1 E.3 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.265652
G1 F2017
M204 S6000
G1 X57.086 Y79.951 E.00666
; CHANGE_LAYER
; Z_HEIGHT: 6.32
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F2400
G1 X57.671 Y79.951 E-.285
; WIPE_END
G1 E-.015 F1800
; layer num/total_layer_count: 52/74
; update layer progress
M73 L52
M991 S0 P51 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z6.6 I-.709 J.989 P1  F18000
G1 X71.283 Y89.717 Z6.6
G1 Z6.32
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1766
M204 S6000
G1 X71.283 Y80.283 E.18968
G1 X72.706 Y80.283 E.0286
G1 X72.706 Y89.717 E.18968
G1 X71.343 Y89.717 E.02739
M204 S10000
G1 X70.859 Y90.141 F18000
G1 F1766
M204 S6000
G1 X70.859 Y79.859 E.20674
G1 X72.141 Y79.859 E.02577
G1 X72.141 Y79.619 E.00483
G1 X73.13 Y79.619 E.01989
G1 X73.13 Y90.381 E.21639
G1 X72.141 Y90.381 E.01989
G1 X72.141 Y90.141 E.00483
G1 X70.919 Y90.141 E.02456
M204 S250
G1 X70.45 Y90.55 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1766
M204 S5000
G1 X70.45 Y79.45 E.20741
G1 X71.732 Y79.45 E.02395
G1 X71.732 Y79.21 E.00448
G1 X73.539 Y79.21 E.03377
G1 X73.539 Y90.79 E.21638
G1 X71.732 Y90.79 E.03377
G1 X71.732 Y90.55 E.00448
G1 X70.51 Y90.55 E.02283
; WIPE_START
G1 F1800
M204 S6000
M73 P79 R3
G1 X70.499 Y88.55 E-.285
; WIPE_END
G1 E-.015
M204 S10000
G17
G3 Z6.72 I1.217 J0 P1  F18000
;===================== date: 20250206 =====================

; don't support timelapse gcode in spiral_mode and by object sequence for I3 structure printer
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
G92 E0
G1 Z6.72
G1 X0 Y85 ; move to safe pos
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
            G0 Z6.72 F4000
            G39.3 S1
            G0 Z6.72 F4000
            G392 S0
          
        M623
    
    M623
M623
; SKIPPABLE_END




G1 X71.745 Y89.005
G1 Z6.32
G1 E.3 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.524742
G1 F1766
M204 S6000
G1 X71.745 Y89.255 E.0059
G1 X72.244 Y89.255 E.0118
G1 X72.244 Y80.745 E.20126
G1 X71.745 Y80.745 E.0118
G1 X71.745 Y88.945 E.19394
; WIPE_START
G1 F4800
G1 X71.745 Y86.945 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X72.353 Y90.049 Z6.72 F18000
G1 Z6.32
G1 E.3 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.265652
G1 F1766
M204 S6000
G1 X72.918 Y90.049 E.00642
; WIPE_START
G1 F2400
G1 X72.353 Y90.049 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X72.779 Y82.428 Z6.72 F18000
G1 X72.918 Y79.951 Z6.72
G1 Z6.32
G1 E.3 F1800
G1 F1766
M204 S6000
G1 X72.353 Y79.951 E.00642
; WIPE_START
G1 F2400
G1 X72.918 Y79.951 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X66.629 Y84.276 Z6.72 F18000
M73 P80 R3
G1 X58.717 Y89.717 Z6.72
G1 Z6.32
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1766
M204 S6000
G1 X57.294 Y89.717 E.0286
G1 X57.294 Y80.283 E.18968
G1 X58.717 Y80.283 E.0286
G1 X58.717 Y89.657 E.18847
M204 S10000
G1 X59.141 Y90.141 F18000
G1 F1766
M204 S6000
G1 X57.858 Y90.141 E.02578
G1 X57.859 Y90.381 E.00483
G1 X56.87 Y90.381 E.01988
G1 X56.87 Y79.619 E.21639
G1 X57.859 Y79.619 E.01989
G1 X57.859 Y79.859 E.00483
G1 X59.141 Y79.859 E.02577
G1 X59.141 Y90.081 E.20553
M204 S250
G1 X59.55 Y90.55 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1766
M204 S5000
G1 X58.268 Y90.55 E.02396
G1 X58.268 Y90.79 E.00448
G1 X56.461 Y90.79 E.03377
G1 X56.461 Y79.21 E.21638
G1 X58.268 Y79.21 E.03377
G1 X58.268 Y79.45 E.00448
G1 X59.55 Y79.45 E.02395
G1 X59.55 Y90.49 E.20629
; WIPE_START
G1 F1800
M204 S6000
G1 X58.268 Y90.55 E-.18289
G1 X58.268 Y90.79 E-.0342
G1 X57.792 Y90.79 E-.06791
; WIPE_END
G1 E-.015
M204 S10000
G1 X57.646 Y90.049 Z6.72 F18000
G1 Z6.32
G1 E.3 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.265652
G1 F1766
M204 S6000
G1 X57.082 Y90.049 E.00642
; WIPE_START
G1 F2400
G1 X57.646 Y90.049 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X58.158 Y82.433 Z6.72 F18000
G1 X58.255 Y80.995 Z6.72
G1 Z6.32
G1 E.3 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.524802
G1 F1766
M204 S6000
G1 X58.255 Y80.745 E.0059
G1 X57.756 Y80.745 E.0118
G1 X57.756 Y89.255 E.20128
G1 X58.255 Y89.255 E.0118
G1 X58.255 Y81.055 E.19396
; WIPE_START
G1 F4800
G1 X58.255 Y83.055 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X57.647 Y79.951 Z6.72 F18000
G1 Z6.32
G1 E.3 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.265652
G1 F1766
M204 S6000
G1 X57.082 Y79.951 E.00643
; CHANGE_LAYER
; Z_HEIGHT: 6.44
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F2400
G1 X57.647 Y79.951 E-.285
; WIPE_END
G1 E-.015 F1800
; layer num/total_layer_count: 53/74
; update layer progress
M73 L53
M991 S0 P52 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z6.72 I-.704 J.992 P1  F18000
G1 X71.403 Y89.717 Z6.72
G1 Z6.44
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1739
M204 S6000
G1 X71.403 Y80.283 E.18968
G1 X72.708 Y80.283 E.02623
G1 X72.708 Y89.717 E.18968
G1 X71.463 Y89.717 E.02502
M204 S10000
G1 X70.979 Y90.141 F18000
G1 F1739
M204 S6000
G1 X70.979 Y79.859 E.20674
G1 X72.162 Y79.859 E.02379
G1 X72.163 Y79.619 E.00483
G1 X73.132 Y79.619 E.0195
G1 X73.132 Y90.381 E.21639
G1 X72.163 Y90.381 E.0195
G1 X72.162 Y90.141 E.00483
G1 X71.039 Y90.141 E.02259
M204 S250
G1 X70.57 Y90.55 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1739
M204 S5000
G1 X70.57 Y79.45 E.20741
G1 X71.754 Y79.45 E.02212
G1 X71.754 Y79.21 E.00448
G1 X73.541 Y79.21 E.03341
G1 X73.541 Y90.79 E.21638
G1 X71.754 Y90.79 E.03341
G1 X71.754 Y90.55 E.00448
G1 X70.63 Y90.55 E.02099
; WIPE_START
G1 F1800
M204 S6000
G1 X70.619 Y88.55 E-.285
; WIPE_END
G1 E-.015
M204 S10000
G17
G3 Z6.84 I1.217 J0 P1  F18000
;===================== date: 20250206 =====================

; don't support timelapse gcode in spiral_mode and by object sequence for I3 structure printer
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
G92 E0
G1 Z6.84
G1 X0 Y85 ; move to safe pos
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
            G0 Z6.84 F4000
            G39.3 S1
            G0 Z6.84 F4000
            G392 S0
          
        M623
    
    M623
M623
; SKIPPABLE_END




G1 X71.836 Y89.284
G1 Z6.44
G1 E.3 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.465892
G1 F1739
M204 S6000
G1 X72.276 Y89.284 E.00918
G1 X72.276 Y80.716 E.17875
G1 X71.836 Y80.716 E.00918
G1 X71.836 Y89.224 E.1775
M204 S10000
G1 X72.375 Y90.049 F18000
; FEATURE: Gap infill
; LINE_WIDTH: 0.265652
G1 F1739
M204 S6000
G1 X72.92 Y90.049 E.0062
; WIPE_START
G1 F2400
G1 X72.375 Y90.049 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X72.786 Y82.427 Z6.84 F18000
G1 X72.92 Y79.951 Z6.84
G1 Z6.44
G1 E.3 F1800
G1 F1739
M204 S6000
G1 X72.375 Y79.951 E.0062
; WIPE_START
G1 F2400
G1 X72.92 Y79.951 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X66.614 Y84.251 Z6.84 F18000
G1 X58.597 Y89.717 Z6.84
G1 Z6.44
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1739
M204 S6000
G1 X57.292 Y89.717 E.02623
G1 X57.292 Y80.283 E.18968
G1 X58.597 Y80.283 E.02623
G1 X58.597 Y89.657 E.18847
M204 S10000
G1 X59.021 Y90.141 F18000
G1 F1739
M204 S6000
G1 X57.836 Y90.141 E.02382
G1 X57.836 Y90.381 E.00483
G1 X56.868 Y90.381 E.01948
G1 X56.868 Y79.619 E.21639
G1 X57.836 Y79.619 E.01948
G1 X57.836 Y79.859 E.00483
G1 X59.021 Y79.859 E.02382
G1 X59.021 Y90.081 E.20553
M204 S250
G1 X59.43 Y90.55 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1739
M204 S5000
G1 X58.246 Y90.55 E.02213
G1 X58.246 Y90.79 E.00448
G1 X56.458 Y90.79 E.0334
G1 X56.458 Y79.21 E.21638
G1 X58.246 Y79.21 E.0334
G1 X58.246 Y79.45 E.00448
G1 X59.43 Y79.45 E.02213
G1 X59.43 Y90.49 E.20629
; WIPE_START
G1 F1800
M204 S6000
G1 X58.246 Y90.55 E-.16895
G1 X58.246 Y90.79 E-.0342
G1 X57.672 Y90.79 E-.08185
; WIPE_END
G1 E-.015
M204 S10000
M73 P81 R3
G1 X57.624 Y90.049 Z6.84 F18000
G1 Z6.44
G1 E.3 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.265652
G1 F1739
M204 S6000
G1 X57.08 Y90.049 E.00619
; WIPE_START
G1 F2400
G1 X57.624 Y90.049 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X58.076 Y82.43 Z6.84 F18000
G1 X58.164 Y80.936 Z6.84
G1 Z6.44
G1 E.3 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.465942
G1 F1739
M204 S6000
G1 X58.164 Y80.716 E.00459
G1 X57.724 Y80.716 E.00918
G1 X57.724 Y89.284 E.17877
G1 X58.164 Y89.284 E.00918
G1 X58.164 Y80.996 E.17292
; WIPE_START
G1 F4800
G1 X58.164 Y82.996 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X57.624 Y79.951 Z6.84 F18000
G1 Z6.44
G1 E.3 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.265652
G1 F1739
M204 S6000
G1 X57.08 Y79.951 E.00619
; CHANGE_LAYER
; Z_HEIGHT: 6.56
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F2400
G1 X57.624 Y79.951 E-.285
; WIPE_END
G1 E-.015 F1800
; layer num/total_layer_count: 54/74
; update layer progress
M73 L54
M991 S0 P53 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z6.84 I-.7 J.996 P1  F18000
G1 X71.523 Y89.717 Z6.84
G1 Z6.56
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1738
M204 S6000
G1 X71.523 Y80.283 E.18968
G1 X72.709 Y80.283 E.02384
G1 X72.709 Y89.717 E.18968
G1 X71.583 Y89.717 E.02263
M204 S10000
G1 X71.099 Y90.141 F18000
G1 F1738
M204 S6000
G1 X71.099 Y79.859 E.20674
G1 X72.182 Y79.859 E.02178
G1 X72.183 Y79.619 E.00483
G1 X73.133 Y79.619 E.01911
G1 X73.133 Y90.381 E.21639
G1 X72.183 Y90.381 E.01911
G1 X72.182 Y90.141 E.00483
G1 X71.159 Y90.141 E.02058
M204 S250
G1 X70.69 Y90.55 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1738
M204 S5000
G1 X70.69 Y79.45 E.20741
G1 X71.773 Y79.45 E.02025
G1 X71.774 Y79.21 E.00448
G1 X73.542 Y79.21 E.03305
G1 X73.542 Y90.79 E.21638
G1 X71.774 Y90.79 E.03305
G1 X71.773 Y90.55 E.00448
G1 X70.75 Y90.55 E.01912
; WIPE_START
G1 F1800
M204 S6000
G1 X70.739 Y88.55 E-.285
; WIPE_END
G1 E-.015
M204 S10000
G17
G3 Z6.96 I1.217 J0 P1  F18000
;===================== date: 20250206 =====================

; don't support timelapse gcode in spiral_mode and by object sequence for I3 structure printer
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
G92 E0
G1 Z6.96
G1 X0 Y85 ; move to safe pos
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
            G0 Z6.96 F4000
            G39.3 S1
            G0 Z6.96 F4000
            G392 S0
          
        M623
    
    M623
M623
; SKIPPABLE_END




G1 X71.926 Y89.124
G1 Z6.56
G1 E.3 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.406372
G1 F1738
M204 S6000
G1 X71.926 Y89.314 E.00343
G1 X72.307 Y89.314 E.00687
G1 X72.307 Y80.686 E.15565
G1 X71.926 Y80.686 E.00687
G1 X71.926 Y89.064 E.15113
; WIPE_START
G1 F4800
G1 X71.926 Y87.064 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X72.395 Y90.049 Z6.96 F18000
G1 Z6.56
G1 E.3 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.265652
G1 F1738
M204 S6000
G1 X72.921 Y90.049 E.00599
; WIPE_START
G1 F2400
G1 X72.395 Y90.049 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X72.792 Y82.427 Z6.96 F18000
G1 X72.921 Y79.951 Z6.96
G1 Z6.56
G1 E.3 F1800
G1 F1738
M204 S6000
G1 X72.395 Y79.951 E.00599
; WIPE_START
G1 F2400
G1 X72.921 Y79.951 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X66.598 Y84.226 Z6.96 F18000
G1 X58.477 Y89.717 Z6.96
G1 Z6.56
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1738
M204 S6000
G1 X57.291 Y89.717 E.02384
G1 X57.291 Y80.283 E.18968
G1 X58.477 Y80.283 E.02384
G1 X58.477 Y89.657 E.18847
M204 S10000
G1 X58.901 Y90.141 F18000
G1 F1738
M204 S6000
G1 X57.816 Y90.141 E.0218
G1 X57.817 Y90.381 E.00483
G1 X56.867 Y90.381 E.0191
G1 X56.867 Y79.619 E.21639
G1 X57.817 Y79.619 E.0191
G1 X57.816 Y79.859 E.00483
G1 X58.901 Y79.859 E.0218
G1 X58.901 Y90.081 E.20553
M204 S250
G1 X59.31 Y90.55 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1738
M204 S5000
G1 X58.226 Y90.55 E.02025
G1 X58.226 Y90.79 E.00448
G1 X56.458 Y90.79 E.03305
G1 X56.458 Y79.21 E.21638
G1 X58.226 Y79.21 E.03305
G1 X58.226 Y79.45 E.00448
G1 X59.31 Y79.45 E.02025
G1 X59.31 Y90.49 E.20629
; WIPE_START
G1 F1800
M204 S6000
G1 X58.226 Y90.55 E-.1547
G1 X58.226 Y90.79 E-.0342
G1 X57.552 Y90.79 E-.0961
; WIPE_END
G1 E-.015
M204 S10000
G1 X57.604 Y90.049 Z6.96 F18000
G1 Z6.56
G1 E.3 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.265652
G1 F1738
M204 S6000
G1 X57.079 Y90.049 E.00597
; WIPE_START
G1 F2400
G1 X57.604 Y90.049 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X57.995 Y82.426 Z6.96 F18000
G1 X58.074 Y80.876 Z6.96
G1 Z6.56
G1 E.3 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.406352
G1 F1738
M204 S6000
G1 X58.074 Y80.686 E.00343
G1 X57.693 Y80.686 E.00687
G1 X57.693 Y89.314 E.15564
G1 X58.074 Y89.314 E.00687
G1 X58.074 Y80.936 E.15113
; WIPE_START
G1 F4800
G1 X58.074 Y82.936 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X57.604 Y79.951 Z6.96 F18000
G1 Z6.56
G1 E.3 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.265652
G1 F1738
M204 S6000
G1 X57.079 Y79.951 E.00597
; CHANGE_LAYER
; Z_HEIGHT: 6.68
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F2400
G1 X57.604 Y79.951 E-.285
; WIPE_END
G1 E-.015 F1800
; layer num/total_layer_count: 55/74
; update layer progress
M73 L55
M991 S0 P54 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z6.96 I-.695 J.999 P1  F18000
G1 X71.643 Y89.717 Z6.96
G1 Z6.68
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1523
M204 S6000
G1 X71.643 Y80.283 E.18968
G1 X72.708 Y80.283 E.02141
G1 X72.708 Y89.717 E.18968
G1 X71.703 Y89.717 E.02021
M204 S10000
G1 X71.219 Y90.141 F18000
G1 F1523
M204 S6000
M73 P82 R3
G1 X71.219 Y79.859 E.20674
G1 X72.201 Y79.859 E.01974
G1 X72.201 Y79.619 E.00483
G1 X73.133 Y79.619 E.01873
G1 X73.133 Y90.381 E.21639
G1 X72.201 Y90.381 E.01873
G1 X72.201 Y90.141 E.00483
G1 X71.279 Y90.141 E.01853
M204 S250
G1 X70.81 Y90.55 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1523
M204 S5000
G1 X70.81 Y79.45 E.20741
G1 X71.792 Y79.45 E.01834
G1 X71.792 Y79.21 E.00448
G1 X73.542 Y79.21 E.0327
G1 X73.542 Y90.79 E.21638
G1 X71.792 Y90.79 E.0327
G1 X71.792 Y90.55 E.00448
G1 X70.87 Y90.55 E.01722
; WIPE_START
G1 F1800
M204 S6000
G1 X70.859 Y88.55 E-.285
; WIPE_END
G1 E-.015
M204 S10000
G17
G3 Z7.08 I1.217 J0 P1  F18000
;===================== date: 20250206 =====================

; don't support timelapse gcode in spiral_mode and by object sequence for I3 structure printer
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
G92 E0
G1 Z7.08
G1 X0 Y85 ; move to safe pos
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
            G0 Z7.08 F4000
            G39.3 S1
            G0 Z7.08 F4000
            G392 S0
          
        M623
    
    M623
M623
; SKIPPABLE_END




G1 X72.176 Y89.504
G1 Z6.68
G1 E.3 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.666374
G1 F1523
M204 S6000
G1 X72.176 Y80.496 E.27353
M204 S10000
G1 X72.413 Y79.951 F18000
; LINE_WIDTH: 0.265652
G1 F1523
M204 S6000
G1 X72.92 Y79.951 E.00577
; WIPE_START
G1 F2400
G1 X72.413 Y79.951 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X72.796 Y87.574 Z7.08 F18000
G1 X72.92 Y90.049 Z7.08
G1 Z6.68
G1 E.3 F1800
G1 F1523
M204 S6000
G1 X72.413 Y90.049 E.00577
; WIPE_START
G1 F2400
G1 X72.92 Y90.049 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X65.29 Y89.875 Z7.08 F18000
G1 X58.357 Y89.717 Z7.08
G1 Z6.68
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1523
M204 S6000
G1 X57.292 Y89.717 E.02141
G1 X57.292 Y80.283 E.18968
G1 X58.357 Y80.283 E.02141
G1 X58.357 Y89.657 E.18847
M204 S10000
G1 X58.781 Y90.141 F18000
G1 F1523
M204 S6000
G1 X57.798 Y90.141 E.01975
G1 X57.799 Y90.381 E.00483
G1 X56.867 Y90.381 E.01873
G1 X56.867 Y79.619 E.21639
G1 X57.799 Y79.619 E.01873
G1 X57.798 Y79.859 E.00483
G1 X58.781 Y79.859 E.01975
G1 X58.781 Y90.081 E.20553
M204 S250
G1 X59.19 Y90.55 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1523
M204 S5000
G1 X58.208 Y90.55 E.01835
G1 X58.208 Y90.79 E.00448
G1 X56.458 Y90.79 E.0327
G1 X56.458 Y79.21 E.21638
G1 X58.208 Y79.21 E.0327
G1 X58.208 Y79.45 E.00448
G1 X59.19 Y79.45 E.01835
G1 X59.19 Y90.49 E.20629
; WIPE_START
G1 F1800
M204 S6000
G1 X58.208 Y90.55 E-.1402
G1 X58.208 Y90.79 E-.0342
G1 X57.432 Y90.79 E-.1106
; WIPE_END
G1 E-.015
M204 S10000
G1 X57.586 Y90.049 Z7.08 F18000
G1 Z6.68
G1 E.3 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.265652
G1 F1523
M204 S6000
G1 X57.079 Y90.049 E.00576
M204 S10000
G1 X57.824 Y89.504 F18000
; LINE_WIDTH: 0.666472
G1 F1523
M204 S6000
G1 X57.824 Y80.496 E.27357
M204 S10000
G1 X57.586 Y79.951 F18000
; LINE_WIDTH: 0.265652
G1 F1523
M204 S6000
G1 X57.079 Y79.951 E.00576
; CHANGE_LAYER
; Z_HEIGHT: 6.8
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F2400
G1 X57.586 Y79.951 E-.285
; WIPE_END
G1 E-.015 F1800
; layer num/total_layer_count: 56/74
; update layer progress
M73 L56
M991 S0 P55 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z7.08 I-.69 J1.002 P1  F18000
G1 X71.763 Y89.717 Z7.08
G1 Z6.8
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1509
M204 S6000
G1 X71.763 Y80.283 E.18968
G1 X72.707 Y80.283 E.01896
G1 X72.707 Y89.717 E.18968
G1 X71.823 Y89.717 E.01776
M204 S10000
G1 X71.339 Y90.141 F18000
G1 F1509
M204 S6000
G1 X71.339 Y79.859 E.20674
G1 X72.218 Y79.859 E.01766
G1 X72.218 Y79.619 E.00483
G1 X73.131 Y79.619 E.01836
G1 X73.131 Y90.381 E.21639
G1 X72.218 Y90.381 E.01836
G1 X72.218 Y90.141 E.00483
G1 X71.399 Y90.141 E.01646
M204 S250
G1 X70.93 Y90.55 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1509
M204 S5000
G1 X70.93 Y79.45 E.20741
G1 X71.808 Y79.45 E.01641
G1 X71.808 Y79.21 E.00448
G1 X73.54 Y79.21 E.03236
G1 X73.54 Y90.79 E.21638
G1 X71.808 Y90.79 E.03236
G1 X71.808 Y90.55 E.00448
G1 X70.99 Y90.55 E.01529
; WIPE_START
G1 F1800
M204 S6000
G1 X70.979 Y88.55 E-.285
; WIPE_END
G1 E-.015
M204 S10000
G17
G3 Z7.2 I1.217 J0 P1  F18000
;===================== date: 20250206 =====================

; don't support timelapse gcode in spiral_mode and by object sequence for I3 structure printer
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
G92 E0
G1 Z7.2
G1 X0 Y85 ; move to safe pos
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
            G0 Z7.2 F4000
            G39.3 S1
            G0 Z7.2 F4000
            G392 S0
          
        M623
    
    M623
M623
; SKIPPABLE_END




G1 X72.235 Y89.504
G1 Z6.8
G1 E.3 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.544561
G1 F1509
M204 S6000
G1 X72.235 Y80.496 E.22152
M204 S10000
G1 X72.43 Y79.951 F18000
; LINE_WIDTH: 0.265652
G1 F1509
M204 S6000
G1 X72.919 Y79.951 E.00556
; WIPE_START
G1 F2400
G1 X72.43 Y79.951 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X72.799 Y87.575 Z7.2 F18000
G1 X72.919 Y90.049 Z7.2
G1 Z6.8
G1 E.3 F1800
G1 F1509
M204 S6000
M73 P83 R3
G1 X72.43 Y90.049 E.00556
; WIPE_START
G1 F2400
G1 X72.919 Y90.049 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X65.288 Y89.876 Z7.2 F18000
G1 X58.237 Y89.717 Z7.2
G1 Z6.8
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1509
M204 S6000
G1 X57.293 Y89.717 E.01896
G1 X57.293 Y80.283 E.18968
G1 X58.237 Y80.283 E.01896
G1 X58.237 Y89.657 E.18847
M204 S10000
G1 X58.661 Y90.141 F18000
G1 F1509
M204 S6000
G1 X57.782 Y90.141 E.01767
G1 X57.782 Y90.381 E.00483
G1 X56.869 Y90.381 E.01836
G1 X56.869 Y79.619 E.21639
G1 X57.782 Y79.619 E.01836
G1 X57.782 Y79.859 E.00483
G1 X58.661 Y79.859 E.01767
G1 X58.661 Y90.081 E.20553
M204 S250
G1 X59.07 Y90.55 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1509
M204 S5000
G1 X58.192 Y90.55 E.01641
G1 X58.192 Y90.79 E.00448
G1 X56.46 Y90.79 E.03236
G1 X56.46 Y79.21 E.21638
G1 X58.192 Y79.21 E.03236
G1 X58.192 Y79.45 E.00448
G1 X59.07 Y79.45 E.01641
G1 X59.07 Y90.49 E.20629
; WIPE_START
G1 F1800
M204 S6000
G1 X58.192 Y90.55 E-.12547
G1 X58.192 Y90.79 E-.0342
G1 X57.312 Y90.79 E-.12533
; WIPE_END
G1 E-.015
M204 S10000
G1 X57.57 Y90.049 Z7.2 F18000
G1 Z6.8
G1 E.3 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.265652
G1 F1509
M204 S6000
G1 X57.081 Y90.049 E.00556
M204 S10000
G1 X57.765 Y89.504 F18000
; LINE_WIDTH: 0.544632
G1 F1509
M204 S6000
G1 X57.765 Y80.496 E.22155
M204 S10000
G1 X57.57 Y79.951 F18000
; LINE_WIDTH: 0.265652
G1 F1509
M204 S6000
G1 X57.081 Y79.951 E.00555
; CHANGE_LAYER
; Z_HEIGHT: 6.92
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F2400
G1 X57.57 Y79.951 E-.285
; WIPE_END
G1 E-.015 F1800
; layer num/total_layer_count: 57/74
; update layer progress
M73 L57
M991 S0 P56 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z7.2 I-.686 J1.005 P1  F18000
G1 X71.883 Y89.717 Z7.2
G1 Z6.92
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1468
M204 S6000
G1 X71.883 Y80.283 E.18968
G1 X72.703 Y80.283 E.01649
G1 X72.703 Y89.717 E.18968
G1 X71.943 Y89.717 E.01528
M204 S10000
G1 X71.459 Y90.141 F18000
G1 F1468
M204 S6000
G1 X71.459 Y79.859 E.20674
G1 X72.232 Y79.859 E.01555
G1 X72.232 Y79.619 E.00483
G1 X73.128 Y79.619 E.018
G1 X73.128 Y90.381 E.21639
G1 X72.232 Y90.381 E.018
G1 X72.232 Y90.141 E.00483
G1 X71.519 Y90.141 E.01434
M204 S250
G1 X71.05 Y90.55 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1468
M204 S5000
G1 X71.05 Y79.45 E.20741
G1 X71.823 Y79.45 E.01445
G1 X71.823 Y79.21 E.00448
G1 X73.537 Y79.21 E.03202
G1 X73.537 Y90.79 E.21638
G1 X71.823 Y90.79 E.03202
G1 X71.823 Y90.55 E.00448
G1 X71.11 Y90.55 E.01332
; WIPE_START
G1 F1800
M204 S6000
G1 X71.099 Y88.55 E-.285
; WIPE_END
G1 E-.015
M204 S10000
G17
G3 Z7.32 I1.217 J0 P1  F18000
;===================== date: 20250206 =====================

; don't support timelapse gcode in spiral_mode and by object sequence for I3 structure printer
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
G92 E0
G1 Z7.32
G1 X0 Y85 ; move to safe pos
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
            G0 Z7.32 F4000
            G39.3 S1
            G0 Z7.32 F4000
            G392 S0
          
        M623
    
    M623
M623
; SKIPPABLE_END




G1 X72.293 Y89.504
G1 Z6.92
G1 E.3 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.421401
G1 F1468
M204 S6000
G1 X72.293 Y80.496 E.16893
; WIPE_START
G1 F2400
G1 X72.293 Y82.496 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X65.492 Y85.96 Z7.32 F18000
G1 X58.117 Y89.717 Z7.32
G1 Z6.92
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1468
M204 S6000
G1 X57.297 Y89.717 E.01649
G1 X57.297 Y80.283 E.18968
G1 X58.117 Y80.283 E.01649
G1 X58.117 Y89.657 E.18847
M204 S10000
G1 X58.541 Y90.141 F18000
G1 F1468
M204 S6000
G1 X57.767 Y90.141 E.01555
G1 X57.767 Y90.381 E.00483
G1 X56.872 Y90.381 E.018
G1 X56.872 Y79.622 E.21634
G1 X57.767 Y79.626 E.018
G1 X57.767 Y79.859 E.0047
G1 X58.541 Y79.859 E.01555
G1 X58.541 Y90.081 E.20553
M204 S250
G1 X58.95 Y90.55 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1468
M204 S5000
G1 X58.177 Y90.55 E.01445
G1 X58.177 Y90.79 E.00448
G1 X56.463 Y90.79 E.03202
G1 X56.463 Y79.211 E.21636
G1 X58.177 Y79.218 E.03202
G1 X58.177 Y79.45 E.00434
G1 X58.95 Y79.45 E.01445
M73 P84 R3
G1 X58.95 Y90.49 E.20629
; WIPE_START
G1 F1800
M204 S6000
G1 X58.177 Y90.55 E-.11052
G1 X58.177 Y90.79 E-.0342
G1 X57.192 Y90.79 E-.14028
; WIPE_END
G1 E-.015
M204 S10000
G1 X57.707 Y89.504 Z7.32 F18000
G1 Z6.92
G1 E.3 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.421362
G1 F1468
M204 S6000
G1 X57.707 Y80.496 E.16892
; CHANGE_LAYER
; Z_HEIGHT: 7.04
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F2400
G1 X57.707 Y82.496 E-.285
; WIPE_END
G1 E-.015 F1800
; layer num/total_layer_count: 58/74
; update layer progress
M73 L58
M991 S0 P57 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z7.32 I.236 J1.194 P1  F18000
G1 X72.246 Y79.619 Z7.32
G1 Z7.04
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1529
M204 S6000
G1 X73.123 Y79.619 E.01764
G1 X73.123 Y90.381 E.21639
G1 X72.246 Y90.381 E.01764
G1 X72.246 Y79.679 E.21518
M204 S250
G1 X71.836 Y79.21 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1529
M204 S5000
G1 X73.532 Y79.21 E.03169
G1 X73.532 Y90.79 E.21638
G1 X71.836 Y90.79 E.03169
G1 X71.836 Y79.27 E.21526
; WIPE_START
G1 F1800
M204 S6000
G1 X73.532 Y79.21 E-.24182
G1 X73.532 Y79.513 E-.04318
; WIPE_END
G1 E-.015
M204 S10000
G17
G3 Z7.44 I1.217 J0 P1  F18000
;===================== date: 20250206 =====================

; don't support timelapse gcode in spiral_mode and by object sequence for I3 structure printer
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
G92 E0
G1 Z7.44
G1 X0 Y85 ; move to safe pos
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
            G0 Z7.44 F4000
            G39.3 S1
            G0 Z7.44 F4000
            G392 S0
          
        M623
    
    M623
M623
; SKIPPABLE_END




G1 X72.684 Y79.831
G1 Z7.04
G1 E.3 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.478923
G1 F1529
M204 S6000
G1 X72.684 Y90.169 E.22203
; WIPE_START
G1 F2400
G1 X72.684 Y88.169 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X71.297 Y90.572 Z7.44 F18000
G1 Z7.04
G1 E.3 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.376624
G1 F1529
M204 S5000
G1 X71.148 Y90.572 E.00248
G1 X71.148 Y79.431 E.18526
G1 X71.298 Y79.434 E.00248
G1 X71.297 Y90.512 E.18422
; WIPE_START
G1 F1800
M204 S6000
G1 X71.148 Y90.572 E-.02291
G1 X71.148 Y88.732 E-.26209
; WIPE_END
G1 E-.015
M204 S10000
G1 X63.573 Y89.665 Z7.44 F18000
G1 X57.754 Y90.381 Z7.44
G1 Z7.04
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1529
M204 S6000
G1 X56.877 Y90.381 E.01764
G1 X56.877 Y79.619 E.21639
G1 X57.754 Y79.619 E.01764
G1 X57.754 Y90.321 E.21518
M204 S250
G1 X58.164 Y90.79 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1529
M204 S5000
G1 X56.468 Y90.79 E.03169
G1 X56.468 Y79.21 E.21638
G1 X58.164 Y79.21 E.03169
G1 X58.164 Y90.73 E.21526
; WIPE_START
G1 F1800
M204 S6000
G1 X56.468 Y90.79 E-.24181
G1 X56.468 Y90.487 E-.04319
; WIPE_END
G1 E-.015
M204 S10000
G1 X57.316 Y90.169 Z7.44 F18000
G1 Z7.04
G1 E.3 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.478824
G1 F1529
M204 S6000
G1 X57.316 Y79.831 E.22198
; WIPE_START
G1 F2400
G1 X57.316 Y81.831 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X58.512 Y89.37 Z7.44 F18000
G1 X58.703 Y90.572 Z7.44
G1 Z7.04
G1 E.3 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.376624
G1 F1529
M204 S5000
G1 X58.703 Y79.428 E.18531
G1 X58.852 Y79.428 E.00248
G1 X58.852 Y90.572 E.18531
G1 X58.763 Y90.572 E.00148
; CHANGE_LAYER
; Z_HEIGHT: 7.16
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F1800
M204 S6000
G1 X58.752 Y88.572 E-.285
; WIPE_END
G1 E-.015
; layer num/total_layer_count: 59/74
; update layer progress
M73 L59
M991 S0 P58 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z7.44 I-1.063 J-.593 P1  F18000
G1 X57.742 Y90.381 Z7.44
G1 Z7.16
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1043
M204 S6000
G1 X56.883 Y90.381 E.01728
G1 X56.883 Y79.619 E.21639
G1 X57.742 Y79.619 E.01728
G1 X57.742 Y90.321 E.21518
M204 S250
G1 X58.152 Y90.79 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
M73 P84 R2
G1 F1043
M204 S5000
G1 X56.474 Y90.79 E.03135
G1 X56.474 Y79.21 E.21638
G1 X58.152 Y79.21 E.03135
G1 X58.152 Y90.73 E.21526
; WIPE_START
G1 F1800
M204 S6000
G1 X56.474 Y90.79 E-.23926
G1 X56.474 Y90.469 E-.04574
; WIPE_END
G1 E-.015
M204 S10000
G17
G3 Z7.56 I1.217 J0 P1  F18000
;===================== date: 20250206 =====================

; don't support timelapse gcode in spiral_mode and by object sequence for I3 structure printer
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
G92 E0
G1 Z7.56
G1 X0 Y85 ; move to safe pos
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
            G0 Z7.56 F4000
            G39.3 S1
            G0 Z7.56 F4000
            G392 S0
          
        M623
    
    M623
M623
; SKIPPABLE_END




G1 X57.313 Y90.169
G1 Z7.16
M73 P85 R2
G1 E.3 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.460904
G1 F1043
M204 S6000
G1 X57.313 Y79.831 E.2132
; WIPE_START
G1 F2400
G1 X57.313 Y81.831 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X63.938 Y85.621 Z7.56 F18000
G1 X72.258 Y90.381 Z7.56
G1 Z7.16
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1043
M204 S6000
G1 X72.258 Y79.619 E.21639
G1 X73.117 Y79.619 E.01728
G1 X73.117 Y90.381 E.21639
G1 X72.318 Y90.381 E.01608
M204 S250
G1 X71.848 Y90.79 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1043
M204 S5000
G1 X71.848 Y79.21 E.21638
G1 X73.526 Y79.21 E.03135
G1 X73.526 Y90.79 E.21638
G1 X71.908 Y90.79 E.03023
M204 S10000
G1 X72.687 Y90.169 F18000
; FEATURE: Gap infill
; LINE_WIDTH: 0.461002
G1 F1043
M204 S6000
G1 X72.687 Y79.831 E.21325
; CHANGE_LAYER
; Z_HEIGHT: 7.28
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F2400
G1 X72.687 Y81.831 E-.285
; WIPE_END
G1 E-.015 F1800
; layer num/total_layer_count: 60/74
; update layer progress
M73 L60
M991 S0 P59 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z7.56 I-1.216 J-.06 P1  F18000
G1 X72.268 Y90.381 Z7.56
G1 Z7.28
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1073
M204 S6000
G1 X72.268 Y79.619 E.21639
G1 X73.11 Y79.619 E.01692
G1 X73.11 Y90.381 E.21639
G1 X72.328 Y90.381 E.01571
M204 S250
G1 X71.859 Y90.79 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1073
M204 S5000
G1 X71.859 Y79.21 E.21638
G1 X73.519 Y79.21 E.03102
G1 X73.519 Y90.79 E.21638
G1 X71.919 Y90.79 E.02989
; WIPE_START
G1 F1800
M204 S6000
G1 X71.909 Y88.79 E-.285
; WIPE_END
G1 E-.015
M204 S10000
G17
G3 Z7.68 I1.217 J0 P1  F18000
;===================== date: 20250206 =====================

; don't support timelapse gcode in spiral_mode and by object sequence for I3 structure printer
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
G92 E0
G1 Z7.68
G1 X0 Y85 ; move to safe pos
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
            G0 Z7.68 F4000
            G39.3 S1
            G0 Z7.68 F4000
            G392 S0
          
        M623
    
    M623
M623
; SKIPPABLE_END




G1 X72.689 Y90.169
G1 Z7.28
G1 E.3 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.44284
G1 F1073
M204 S6000
G1 X72.689 Y79.831 E.20435
; WIPE_START
G1 F2400
G1 X72.689 Y81.831 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X66.063 Y85.619 Z7.68 F18000
G1 X57.732 Y90.381 Z7.68
G1 Z7.28
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1073
M204 S6000
G1 X56.89 Y90.381 E.01692
G1 X56.89 Y79.619 E.21639
G1 X57.732 Y79.619 E.01692
G1 X57.732 Y90.321 E.21518
M204 S250
G1 X58.141 Y90.79 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1073
M204 S5000
G1 X56.481 Y90.79 E.03101
G1 X56.481 Y79.21 E.21638
G1 X58.141 Y79.21 E.03101
G1 X58.141 Y90.73 E.21526
; WIPE_START
G1 F1800
M204 S6000
G1 X56.481 Y90.79 E-.23667
G1 X56.481 Y90.451 E-.04833
; WIPE_END
G1 E-.015
M204 S10000
G1 X57.311 Y90.169 Z7.68 F18000
G1 Z7.28
G1 E.3 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.442774
G1 F1073
M204 S6000
G1 X57.311 Y79.831 E.20432
; CHANGE_LAYER
; Z_HEIGHT: 7.4
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F2400
G1 X57.311 Y81.831 E-.285
; WIPE_END
G1 E-.015 F1800
; layer num/total_layer_count: 61/74
; update layer progress
M73 L61
M991 S0 P60 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z7.68 I-.604 J1.057 P1  F18000
G1 X72.278 Y90.381 Z7.68
G1 Z7.4
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1062
M204 S6000
G1 X72.278 Y79.619 E.21639
G1 X73.1 Y79.619 E.01654
G1 X73.1 Y90.381 E.21639
G1 X72.338 Y90.381 E.01533
M204 S250
G1 X71.869 Y90.79 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1062
M204 S5000
G1 X71.869 Y79.21 E.21638
G1 X73.51 Y79.21 E.03067
G1 X73.51 Y90.79 E.21638
G1 X71.929 Y90.79 E.02954
; WIPE_START
G1 F1800
M204 S6000
G1 X71.918 Y88.79 E-.285
; WIPE_END
G1 E-.015
M204 S10000
G17
G3 Z7.8 I1.217 J0 P1  F18000
;===================== date: 20250206 =====================

; don't support timelapse gcode in spiral_mode and by object sequence for I3 structure printer
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
G92 E0
G1 Z7.8
G1 X0 Y85 ; move to safe pos
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
            G0 Z7.8 F4000
            G39.3 S1
            G0 Z7.8 F4000
            G392 S0
          
        M623
    
    M623
M623
; SKIPPABLE_END




G1 X72.689 Y90.169
G1 Z7.4
G1 E.3 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.424162
G1 F1062
M204 S6000
M73 P86 R2
G1 X72.689 Y79.831 E.1952
; WIPE_START
G1 F2400
G1 X72.689 Y81.831 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X66.062 Y85.617 Z7.8 F18000
G1 X57.722 Y90.381 Z7.8
G1 Z7.4
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1062
M204 S6000
G1 X56.899 Y90.381 E.01654
G1 X56.899 Y79.619 E.21639
G1 X57.722 Y79.619 E.01654
G1 X57.722 Y90.321 E.21518
M204 S250
G1 X58.131 Y90.79 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1062
M204 S5000
G1 X56.49 Y90.79 E.03067
G1 X56.49 Y79.21 E.21638
G1 X58.131 Y79.21 E.03066
G1 X58.131 Y90.73 E.21526
M204 S10000
G1 X57.311 Y90.169 F18000
; FEATURE: Gap infill
; LINE_WIDTH: 0.424174
G1 F1062
M204 S6000
G1 X57.311 Y79.831 E.1952
; CHANGE_LAYER
; Z_HEIGHT: 7.52
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F2400
G1 X57.311 Y81.831 E-.285
; WIPE_END
G1 E-.015 F1800
; layer num/total_layer_count: 62/74
; update layer progress
M73 L62
M991 S0 P61 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z7.8 I-.603 J1.057 P1  F18000
G1 X72.286 Y90.381 Z7.8
G1 Z7.52
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1060
M204 S6000
G1 X72.286 Y79.619 E.21639
G1 X73.09 Y79.619 E.01615
G1 X73.09 Y90.381 E.21639
G1 X72.346 Y90.381 E.01495
M204 S250
G1 X71.877 Y90.79 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1060
M204 S5000
G1 X71.877 Y79.21 E.21638
G1 X73.499 Y79.21 E.0303
G1 X73.499 Y90.79 E.21638
G1 X71.937 Y90.79 E.02918
; WIPE_START
G1 F1800
M204 S6000
G1 X71.927 Y88.79 E-.285
; WIPE_END
G1 E-.015
M204 S10000
G17
G3 Z7.92 I1.217 J0 P1  F18000
;===================== date: 20250206 =====================

; don't support timelapse gcode in spiral_mode and by object sequence for I3 structure printer
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
G92 E0
G1 Z7.92
G1 X0 Y85 ; move to safe pos
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
            G0 Z7.92 F4000
            G39.3 S1
            G0 Z7.92 F4000
            G392 S0
          
        M623
    
    M623
M623
; SKIPPABLE_END




G1 X72.688 Y90.169
G1 Z7.52
G1 E.3 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.404814
G1 F1060
M204 S6000
G1 X72.688 Y79.831 E.18572
; WIPE_START
G1 F2400
G1 X72.688 Y81.831 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X66.06 Y85.616 Z7.92 F18000
G1 X57.713 Y90.381 Z7.92
G1 Z7.52
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1060
M204 S6000
G1 X56.91 Y90.381 E.01615
G1 X56.91 Y79.623 E.21632
G1 X57.713 Y79.627 E.01615
G1 X57.713 Y90.321 E.21502
M204 S250
G1 X58.123 Y90.79 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1060
M204 S5000
G1 X56.501 Y90.79 E.03031
G1 X56.501 Y79.211 E.21636
G1 X58.123 Y79.22 E.03031
G1 X58.123 Y90.73 E.21507
M204 S10000
G1 X57.312 Y90.169 F18000
; FEATURE: Gap infill
; LINE_WIDTH: 0.404873
G1 F1060
M204 S6000
M73 P87 R2
G1 X57.312 Y79.837 E.18565
; CHANGE_LAYER
; Z_HEIGHT: 7.64
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F2400
G1 X57.312 Y81.837 E-.285
; WIPE_END
G1 E-.015 F1800
; layer num/total_layer_count: 63/74
; update layer progress
M73 L63
M991 S0 P62 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z7.92 I-.603 J1.057 P1  F18000
G1 X72.294 Y90.381 Z7.92
G1 Z7.64
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1059
M204 S6000
G1 X72.294 Y79.619 E.21639
G1 X73.078 Y79.619 E.01575
G1 X73.077 Y90.381 E.21639
G1 X72.354 Y90.381 E.01455
M204 S250
G1 X71.885 Y90.79 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1059
M204 S5000
G1 X71.885 Y79.21 E.21638
G1 X73.487 Y79.21 E.02993
G1 X73.487 Y90.79 E.21638
G1 X71.945 Y90.79 E.02881
; WIPE_START
G1 F1800
M204 S6000
G1 X71.934 Y88.79 E-.285
; WIPE_END
G1 E-.015
M204 S10000
G17
G3 Z8.04 I1.217 J0 P1  F18000
;===================== date: 20250206 =====================

; don't support timelapse gcode in spiral_mode and by object sequence for I3 structure printer
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
G92 E0
G1 Z8.04
G1 X0 Y85 ; move to safe pos
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
            G0 Z8.04 F4000
            G39.3 S1
            G0 Z8.04 F4000
            G392 S0
          
        M623
    
    M623
M623
; SKIPPABLE_END




G1 X72.686 Y90.169
G1 Z7.64
G1 E.3 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.384991
G1 F1059
M204 S6000
G1 X72.686 Y79.831 E.17601
; WIPE_START
G1 F2400
G1 X72.686 Y81.831 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X66.057 Y85.615 Z8.04 F18000
G1 X57.706 Y90.381 Z8.04
G1 Z7.64
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1059
M204 S6000
G1 X56.922 Y90.381 E.01575
G1 X56.922 Y79.619 E.21639
G1 X57.706 Y79.619 E.01575
G1 X57.706 Y90.321 E.21518
M204 S250
G1 X58.115 Y90.79 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1059
M204 S5000
G1 X56.513 Y90.79 E.02993
G1 X56.513 Y79.21 E.21638
G1 X58.115 Y79.21 E.02993
G1 X58.115 Y90.73 E.21526
M204 S10000
G1 X57.314 Y90.169 F18000
; FEATURE: Gap infill
; LINE_WIDTH: 0.384994
G1 F1059
M204 S6000
G1 X57.314 Y79.831 E.17601
; CHANGE_LAYER
; Z_HEIGHT: 7.76
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F2400
G1 X57.314 Y81.831 E-.285
; WIPE_END
G1 E-.015 F1800
; layer num/total_layer_count: 64/74
; update layer progress
M73 L64
M991 S0 P63 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z8.04 I-.603 J1.057 P1  F18000
G1 X72.301 Y90.381 Z8.04
G1 Z7.76
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1058
M204 S6000
G1 X72.301 Y79.619 E.21639
G1 X73.063 Y79.619 E.01534
G1 X73.063 Y90.381 E.21639
G1 X72.361 Y90.381 E.01413
M204 S250
G1 X71.891 Y90.79 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1058
M204 S5000
G1 X71.891 Y79.21 E.21638
G1 X73.473 Y79.21 E.02955
G1 X73.473 Y90.79 E.21638
G1 X71.951 Y90.79 E.02843
; WIPE_START
G1 F1800
M204 S6000
G1 X71.941 Y88.79 E-.285
; WIPE_END
G1 E-.015
M204 S10000
G17
M73 P88 R2
G3 Z8.16 I1.217 J0 P1  F18000
;===================== date: 20250206 =====================

; don't support timelapse gcode in spiral_mode and by object sequence for I3 structure printer
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
G92 E0
G1 Z8.16
G1 X0 Y85 ; move to safe pos
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
            G0 Z8.16 F4000
            G39.3 S1
            G0 Z8.16 F4000
            G392 S0
          
        M623
    
    M623
M623
; SKIPPABLE_END




G1 X72.682 Y90.169
G1 Z7.76
G1 E.3 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.364321
G1 F1058
M204 S6000
G1 X72.682 Y79.831 E.16588
; WIPE_START
G1 F2400
G1 X72.682 Y81.831 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X66.053 Y85.614 Z8.16 F18000
G1 X57.699 Y90.381 Z8.16
G1 Z7.76
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1058
M204 S6000
G1 X56.937 Y90.381 E.01534
G1 X56.937 Y79.619 E.21639
G1 X57.699 Y79.619 E.01534
G1 X57.699 Y90.321 E.21518
M204 S250
G1 X58.109 Y90.79 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1058
M204 S5000
G1 X56.527 Y90.79 E.02955
G1 X56.527 Y79.21 E.21638
G1 X58.108 Y79.21 E.02954
G1 X58.109 Y90.73 E.21526
M204 S10000
G1 X57.318 Y90.169 F18000
; FEATURE: Gap infill
; LINE_WIDTH: 0.364234
G1 F1058
M204 S6000
G1 X57.318 Y79.831 E.16584
; CHANGE_LAYER
; Z_HEIGHT: 7.88
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F2400
G1 X57.318 Y81.831 E-.285
; WIPE_END
G1 E-.015 F1800
; layer num/total_layer_count: 65/74
; update layer progress
M73 L65
M991 S0 P64 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z8.16 I-.603 J1.057 P1  F18000
G1 X72.307 Y90.381 Z8.16
G1 Z7.88
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1056
M204 S6000
G1 X72.307 Y79.619 E.21638
G1 X73.048 Y79.62 E.0149
G1 X73.047 Y90.381 E.21638
G1 X72.367 Y90.381 E.01369
M204 S250
G1 X71.897 Y90.79 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1056
M204 S5000
G1 X71.897 Y79.21 E.21638
G1 X73.457 Y79.211 E.02914
G1 X73.457 Y90.79 E.21637
G1 X71.957 Y90.79 E.02802
; WIPE_START
G1 F1800
M204 S6000
G1 X71.947 Y88.79 E-.285
; WIPE_END
G1 E-.015
M204 S10000
G17
G3 Z8.28 I1.217 J0 P1  F18000
;===================== date: 20250206 =====================

; don't support timelapse gcode in spiral_mode and by object sequence for I3 structure printer
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
G92 E0
G1 Z8.28
G1 X0 Y85 ; move to safe pos
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
            G0 Z8.28 F4000
            G39.3 S1
            G0 Z8.28 F4000
            G392 S0
          
        M623
    
    M623
M623
; SKIPPABLE_END




G1 X72.677 Y90.169
G1 Z7.88
G1 E.3 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.34246
G1 F1056
M204 S6000
G1 X72.677 Y79.832 E.15516
; WIPE_START
G1 F2400
G1 X72.677 Y81.832 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X66.048 Y85.614 Z8.28 F18000
G1 X57.693 Y90.381 Z8.28
G1 Z7.88
M73 P89 R2
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1056
M204 S6000
G1 X56.952 Y90.381 E.0149
G1 X56.952 Y79.619 E.21639
G1 X57.693 Y79.619 E.01489
G1 X57.693 Y90.321 E.21518
M204 S250
G1 X58.103 Y90.79 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1056
M204 S5000
G1 X56.543 Y90.79 E.02914
G1 X56.543 Y79.21 E.21638
G1 X58.102 Y79.21 E.02914
G1 X58.103 Y90.73 E.21526
M204 S10000
G1 X57.323 Y90.169 F18000
; FEATURE: Gap infill
; LINE_WIDTH: 0.342293
G1 F1056
M204 S6000
G1 X57.323 Y79.831 E.15509
; CHANGE_LAYER
; Z_HEIGHT: 8
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F2400
G1 X57.323 Y81.831 E-.285
; WIPE_END
G1 E-.015 F1800
; layer num/total_layer_count: 66/74
; update layer progress
M73 L66
M991 S0 P65 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z8.28 I-.603 J1.057 P1  F18000
G1 X72.312 Y90.381 Z8.28
G1 Z8
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1054
M204 S6000
G1 X72.312 Y79.619 E.21639
G1 X73.03 Y79.619 E.01443
G1 X73.03 Y90.381 E.21639
G1 X72.372 Y90.381 E.01323
M204 S250
G1 X71.903 Y90.79 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1054
M204 S5000
G1 X71.903 Y79.21 E.21638
G1 X73.439 Y79.21 E.02871
G1 X73.439 Y90.79 E.21638
G1 X71.963 Y90.79 E.02758
; WIPE_START
G1 F1800
M204 S6000
G1 X71.952 Y88.79 E-.285
; WIPE_END
G1 E-.015
M204 S10000
G17
G3 Z8.4 I1.217 J0 P1  F18000
;===================== date: 20250206 =====================

; don't support timelapse gcode in spiral_mode and by object sequence for I3 structure printer
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
G92 E0
G1 Z8.4
G1 X0 Y85 ; move to safe pos
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
            G0 Z8.4 F4000
            G39.3 S1
            G0 Z8.4 F4000
            G392 S0
          
        M623
    
    M623
M623
; SKIPPABLE_END




G1 X72.671 Y90.169
G1 Z8
G1 E.3 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.319361
G1 F1054
M204 S6000
G1 X72.671 Y79.831 E.14385
; WIPE_START
G1 F2400
G1 X72.671 Y81.831 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X66.042 Y85.614 Z8.4 F18000
G1 X57.688 Y90.381 Z8.4
G1 Z8
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1054
M204 S6000
G1 X56.97 Y90.381 E.01443
G1 X56.97 Y79.619 E.21639
G1 X57.688 Y79.619 E.01443
G1 X57.688 Y90.321 E.21518
M204 S250
G1 X58.097 Y90.79 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1054
M204 S5000
M73 P89 R1
G1 X56.561 Y90.79 E.02871
G1 X56.561 Y79.21 E.21638
G1 X58.097 Y79.21 E.0287
M73 P90 R1
G1 X58.097 Y90.73 E.21526
M204 S10000
G1 X57.329 Y90.169 F18000
; FEATURE: Gap infill
; LINE_WIDTH: 0.319274
G1 F1054
M204 S6000
G1 X57.329 Y79.831 E.14381
; CHANGE_LAYER
; Z_HEIGHT: 8.12
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F2400
G1 X57.329 Y81.831 E-.285
; WIPE_END
G1 E-.015 F1800
; layer num/total_layer_count: 67/74
; update layer progress
M73 L67
M991 S0 P66 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z8.4 I-.603 J1.057 P1  F18000
G1 X72.317 Y90.381 Z8.4
G1 Z8.12
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1053
M204 S6000
G1 X72.317 Y79.619 E.21639
G1 X73.01 Y79.619 E.01394
G1 X73.01 Y90.381 E.21639
G1 X72.377 Y90.381 E.01273
M204 S250
G1 X71.907 Y90.79 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1053
M204 S5000
G1 X71.907 Y79.21 E.21638
G1 X73.419 Y79.21 E.02825
G1 X73.419 Y90.79 E.21638
G1 X71.967 Y90.79 E.02712
; WIPE_START
G1 F1800
M204 S6000
G1 X71.957 Y88.79 E-.285
; WIPE_END
G1 E-.015
M204 S10000
G17
G3 Z8.52 I1.217 J0 P1  F18000
;===================== date: 20250206 =====================

; don't support timelapse gcode in spiral_mode and by object sequence for I3 structure printer
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
G92 E0
G1 Z8.52
G1 X0 Y85 ; move to safe pos
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
            G0 Z8.52 F4000
            G39.3 S1
            G0 Z8.52 F4000
            G392 S0
          
        M623
    
    M623
M623
; SKIPPABLE_END




G1 X72.663 Y90.169
G1 Z8.12
G1 E.3 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.294681
G1 F1053
M204 S6000
G1 X72.663 Y79.831 E.13176
; WIPE_START
G1 F2400
G1 X72.663 Y81.831 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X66.034 Y85.615 Z8.52 F18000
G1 X57.683 Y90.381 Z8.52
G1 Z8.12
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1053
M204 S6000
G1 X56.99 Y90.381 E.01394
G1 X56.99 Y79.619 E.21639
G1 X57.683 Y79.619 E.01394
G1 X57.683 Y90.321 E.21518
M204 S250
G1 X58.093 Y90.79 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1053
M204 S5000
G1 X56.581 Y90.79 E.02825
G1 X56.581 Y79.21 E.21638
G1 X58.093 Y79.21 E.02825
G1 X58.093 Y90.73 E.21526
M204 S10000
G1 X57.337 Y90.169 F18000
; FEATURE: Gap infill
; LINE_WIDTH: 0.294653
G1 F1053
M204 S6000
G1 X57.337 Y79.831 E.13175
; CHANGE_LAYER
; Z_HEIGHT: 8.24
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F2400
G1 X57.337 Y81.831 E-.285
; WIPE_END
G1 E-.015 F1800
; layer num/total_layer_count: 68/74
; update layer progress
M73 L68
M991 S0 P67 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z8.52 I-.603 J1.057 P1  F18000
G1 X72.321 Y90.381 Z8.52
G1 Z8.24
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1051
M204 S6000
G1 X72.321 Y79.619 E.21639
G1 X72.987 Y79.619 E.0134
G1 X72.988 Y90.381 E.21639
G1 X72.381 Y90.381 E.0122
M204 S250
G1 X71.912 Y90.79 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1051
M204 S5000
G1 X71.912 Y79.21 E.21638
M73 P91 R1
G1 X73.397 Y79.21 E.02775
G1 X73.397 Y90.79 E.21638
G1 X71.972 Y90.79 E.02663
; WIPE_START
G1 F1800
M204 S6000
G1 X71.961 Y88.79 E-.285
; WIPE_END
G1 E-.015
M204 S10000
G17
G3 Z8.64 I1.217 J0 P1  F18000
;===================== date: 20250206 =====================

; don't support timelapse gcode in spiral_mode and by object sequence for I3 structure printer
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
G92 E0
G1 Z8.64
G1 X0 Y85 ; move to safe pos
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
            G0 Z8.64 F4000
            G39.3 S1
            G0 Z8.64 F4000
            G392 S0
          
        M623
    
    M623
M623
; SKIPPABLE_END




G1 X72.654 Y90.169
G1 Z8.24
G1 E.3 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.268104
G1 F1051
M204 S6000
G1 X72.654 Y79.831 E.11874
; WIPE_START
G1 F2400
G1 X72.654 Y81.831 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X66.026 Y85.616 Z8.64 F18000
G1 X57.679 Y90.381 Z8.64
G1 Z8.24
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1051
M204 S6000
G1 X57.012 Y90.381 E.01341
G1 X57.012 Y79.619 E.21638
G1 X57.679 Y79.62 E.01341
G1 X57.679 Y90.321 E.21517
M204 S250
G1 X58.088 Y90.79 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1051
M204 S5000
G1 X56.603 Y90.79 E.02775
G1 X56.603 Y79.21 E.21638
G1 X58.088 Y79.211 E.02775
G1 X58.088 Y90.73 E.21525
M204 S10000
G1 X57.346 Y90.169 F18000
; FEATURE: Gap infill
; LINE_WIDTH: 0.268222
G1 F1051
M204 S6000
G1 X57.346 Y79.832 E.11879
; CHANGE_LAYER
; Z_HEIGHT: 8.36
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F2400
G1 X57.346 Y81.832 E-.285
; WIPE_END
G1 E-.015 F1800
; layer num/total_layer_count: 69/74
; update layer progress
M73 L69
M991 S0 P68 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z8.64 I-.603 J1.057 P1  F18000
G1 X72.325 Y90.381 Z8.64
G1 Z8.36
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1048
M204 S6000
G1 X72.325 Y79.619 E.21638
G1 X72.963 Y79.62 E.01284
G1 X72.963 Y90.381 E.21638
G1 X72.385 Y90.381 E.01163
M204 S250
G1 X71.915 Y90.79 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1048
M204 S5000
G1 X71.915 Y79.21 E.21638
G1 X73.372 Y79.211 E.02722
G1 X73.372 Y90.79 E.21637
G1 X71.975 Y90.79 E.0261
; WIPE_START
G1 F1800
M204 S6000
G1 X71.965 Y88.79 E-.285
; WIPE_END
G1 E-.015
M204 S10000
G17
G3 Z8.76 I1.217 J0 P1  F18000
;===================== date: 20250206 =====================

; don't support timelapse gcode in spiral_mode and by object sequence for I3 structure printer
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
G92 E0
G1 Z8.76
G1 X0 Y85 ; move to safe pos
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
            G0 Z8.76 F4000
            G39.3 S1
            G0 Z8.76 F4000
            G392 S0
          
        M623
    
    M623
M623
; SKIPPABLE_END




G1 X72.644 Y90.169
G1 Z8.36
G1 E.3 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.239932
G1 F1048
M204 S6000
G1 X72.644 Y79.832 E.10493
; WIPE_START
M73 P92 R1
G1 F2400
G1 X72.644 Y81.832 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X66.016 Y85.617 Z8.76 F18000
G1 X57.675 Y90.381 Z8.76
G1 Z8.36
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1048
M204 S6000
G1 X57.037 Y90.381 E.01284
G1 X57.037 Y79.619 E.21639
G1 X57.675 Y79.619 E.01283
G1 X57.675 Y90.321 E.21518
M204 S250
G1 X58.085 Y90.79 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1048
M204 S5000
G1 X56.628 Y90.79 E.02722
G1 X56.628 Y79.21 E.21638
G1 X58.084 Y79.21 E.02722
G1 X58.085 Y90.73 E.21526
M204 S10000
G1 X57.356 Y90.169 F18000
; FEATURE: Gap infill
; LINE_WIDTH: 0.239833
G1 F1048
M204 S6000
G1 X57.356 Y79.831 E.10489
; CHANGE_LAYER
; Z_HEIGHT: 8.48
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F2400
G1 X57.356 Y81.831 E-.285
; WIPE_END
G1 E-.015 F1800
; layer num/total_layer_count: 70/74
; update layer progress
M73 L70
M991 S0 P69 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z8.76 I-.603 J1.057 P1  F18000
G1 X72.328 Y90.381 Z8.76
G1 Z8.48
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1046
M204 S6000
G1 X72.328 Y79.619 E.21639
G1 X72.936 Y79.619 E.01221
G1 X72.936 Y90.381 E.21639
G1 X72.388 Y90.381 E.011
M204 S250
G1 X71.919 Y90.79 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1046
M204 S5000
G1 X71.919 Y79.21 E.21638
G1 X73.345 Y79.21 E.02664
G1 X73.345 Y90.79 E.21638
G1 X71.979 Y90.79 E.02552
; WIPE_START
G1 F1800
M204 S6000
G1 X71.969 Y88.79 E-.285
; WIPE_END
G1 E-.015
M204 S10000
G17
G3 Z8.88 I1.217 J0 P1  F18000
;===================== date: 20250206 =====================

; don't support timelapse gcode in spiral_mode and by object sequence for I3 structure printer
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
G92 E0
G1 Z8.88
G1 X0 Y85 ; move to safe pos
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
            G0 Z8.88 F4000
            G39.3 S1
            G0 Z8.88 F4000
            G392 S0
          
        M623
    
    M623
M623
; SKIPPABLE_END




G1 X72.632 Y90.169
G1 Z8.48
G1 E.3 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.208821
G1 F1046
M204 S6000
G1 X72.632 Y79.831 E.08969
; WIPE_START
G1 F2400
G1 X72.632 Y81.831 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X66.005 Y85.618 Z8.88 F18000
G1 X57.672 Y90.381 Z8.88
G1 Z8.48
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1046
M204 S6000
G1 X57.064 Y90.381 E.01221
G1 X57.064 Y79.619 E.21639
G1 X57.672 Y79.619 E.01221
G1 X57.672 Y90.321 E.21518
M204 S250
G1 X58.081 Y90.79 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1046
M204 S5000
G1 X56.655 Y90.79 E.02664
G1 X56.655 Y79.21 E.21638
M73 P93 R1
G1 X58.081 Y79.21 E.02664
G1 X58.081 Y90.73 E.21526
M204 S10000
G1 X57.368 Y90.169 F18000
; FEATURE: Gap infill
; LINE_WIDTH: 0.208672
G1 F1046
M204 S6000
G1 X57.368 Y79.831 E.08962
; CHANGE_LAYER
; Z_HEIGHT: 8.6
; LAYER_HEIGHT: 0.120001
; WIPE_START
G1 F2400
G1 X57.368 Y81.831 E-.285
; WIPE_END
G1 E-.015 F1800
; layer num/total_layer_count: 71/74
; update layer progress
M73 L71
M991 S0 P70 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z8.88 I-.604 J1.057 P1  F18000
G1 X72.332 Y90.381 Z8.88
G1 Z8.6
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1044
M204 S6000
G1 X72.332 Y79.619 E.21639
G1 X72.905 Y79.619 E.01153
G1 X72.905 Y90.381 E.21639
G1 X72.392 Y90.381 E.01032
M204 S250
G1 X71.923 Y90.79 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1044
M204 S5000
G1 X71.923 Y79.21 E.21638
G1 X73.315 Y79.21 E.026
G1 X73.315 Y90.79 E.21638
G1 X71.983 Y90.79 E.02488
; WIPE_START
G1 F1800
M204 S6000
G1 X71.972 Y88.79 E-.285
; WIPE_END
G1 E-.015
M204 S10000
G17
G3 Z9 I1.217 J0 P1  F18000
;===================== date: 20250206 =====================

; don't support timelapse gcode in spiral_mode and by object sequence for I3 structure printer
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
G92 E0
G1 Z9
G1 X0 Y85 ; move to safe pos
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
            G0 Z9 F4000
            G39.3 S1
            G0 Z9 F4000
            G392 S0
          
        M623
    
    M623
M623
; SKIPPABLE_END




G1 X72.619 Y90.169
G1 Z8.6
G1 E.3 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.174702
G1 F1044
M204 S6000
G1 X72.619 Y79.831 E.07298
; WIPE_START
G1 F2400
G1 X72.619 Y81.831 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X65.993 Y85.62 Z9 F18000
G1 X57.668 Y90.381 Z9
G1 Z8.6
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1044
M204 S6000
G1 X57.095 Y90.381 E.01152
G1 X57.095 Y79.619 E.21639
G1 X57.668 Y79.619 E.01152
G1 X57.668 Y90.321 E.21518
M204 S250
G1 X58.077 Y90.79 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1044
M204 S5000
G1 X56.686 Y90.79 E.026
G1 X56.686 Y79.21 E.21638
G1 X58.077 Y79.21 E.026
G1 X58.077 Y90.73 E.21526
M204 S10000
G1 X57.381 Y90.169 F18000
; FEATURE: Gap infill
; LINE_WIDTH: 0.174652
G1 F1044
M204 S6000
G1 X57.381 Y79.831 E.07295
; CHANGE_LAYER
; Z_HEIGHT: 8.72
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F2400
G1 X57.381 Y81.831 E-.285
; WIPE_END
G1 E-.015 F1800
; layer num/total_layer_count: 72/74
; update layer progress
M73 L72
M991 S0 P71 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z9 I-1.216 J.04 P1  F18000
G1 X57.664 Y90.381 Z9
G1 Z8.72
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1021
M204 S6000
M73 P94 R1
G1 X57.128 Y90.381 E.01077
G1 X57.128 Y79.619 E.21639
G1 X57.664 Y79.619 E.01077
G1 X57.664 Y90.321 E.21518
M204 S250
G1 X58.073 Y90.79 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1021
M204 S5000
G1 X56.719 Y90.79 E.0253
G1 X56.719 Y79.21 E.21638
G1 X58.073 Y79.21 E.02531
G1 X58.073 Y90.73 E.21526
; WIPE_START
G1 F1800
M204 S6000
G1 X56.719 Y90.79 E-.19317
G1 X56.719 Y90.146 E-.09183
; WIPE_END
G1 E-.015
M204 S10000
G17
G3 Z9.12 I1.217 J0 P1  F18000
;===================== date: 20250206 =====================

; don't support timelapse gcode in spiral_mode and by object sequence for I3 structure printer
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
G92 E0
G1 Z9.12
G1 X0 Y85 ; move to safe pos
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
            G0 Z9.12 F4000
            G39.3 S1
            G0 Z9.12 F4000
            G392 S0
          
        M623
    
    M623
M623
; SKIPPABLE_END




G1 X57.396 Y90.169
G1 Z8.72
G1 E.3 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.137302
G1 F1021
M204 S6000
G1 X57.396 Y79.831 E.05465
; WIPE_START
G1 F2400
G1 X57.396 Y81.831 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X64.021 Y85.622 Z9.12 F18000
G1 X72.336 Y90.381 Z9.12
G1 Z8.72
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1021
M204 S6000
G1 X72.336 Y79.619 E.21639
G1 X72.872 Y79.619 E.01077
G1 X72.872 Y90.381 E.21639
G1 X72.396 Y90.381 E.00957
M204 S250
G1 X71.927 Y90.79 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1021
M204 S5000
G1 X71.927 Y79.21 E.21638
G1 X73.281 Y79.21 E.0253
G1 X73.281 Y90.79 E.21638
G1 X71.987 Y90.79 E.02418
M204 S10000
G1 X72.604 Y90.169 F18000
; FEATURE: Gap infill
; LINE_WIDTH: 0.137262
G1 F1021
M204 S6000
G1 X72.604 Y79.831 E.05463
; CHANGE_LAYER
; Z_HEIGHT: 8.84
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F2400
G1 X72.604 Y81.831 E-.285
; WIPE_END
G1 E-.015 F1800
; layer num/total_layer_count: 73/74
; update layer progress
M73 L73
M991 S0 P72 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z9.12 I-.603 J-1.057 P1  F18000
G1 X57.622 Y90.381 Z9.12
G1 Z8.84
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F817
M204 S6000
G1 X57.221 Y90.381 E.00807
G1 X57.221 Y79.619 E.21639
G1 X57.622 Y79.619 E.00807
G1 X57.622 Y90.321 E.21518
M204 S250
G1 X58.032 Y90.79 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F817
M204 S5000
G1 X56.812 Y90.79 E.02279
G1 X56.812 Y79.21 E.21638
G1 X58.032 Y79.21 E.02279
G1 X58.032 Y90.73 E.21526
; WIPE_START
G1 F1800
M204 S6000
G1 X56.812 Y90.79 E-.17403
G1 X56.812 Y90.011 E-.11097
; WIPE_END
G1 E-.015
M204 S10000
G1 X64.442 Y90.192 Z9.24 F18000
G1 X72.377 Y90.381 Z9.24
M73 P95 R0
G1 Z8.84
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F817
M204 S6000
G1 X72.377 Y79.619 E.21639
G1 X72.779 Y79.619 E.00807
G1 X72.779 Y90.381 E.21639
G1 X72.437 Y90.381 E.00687
M204 S250
G1 X71.968 Y90.79 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F817
M204 S5000
G1 X71.968 Y79.21 E.21638
G1 X73.188 Y79.21 E.0228
G1 X73.188 Y90.79 E.21638
G1 X72.028 Y90.79 E.02167
; WIPE_START
G1 F1800
M204 S6000
G1 X72.018 Y88.79 E-.285
; WIPE_END
G1 E-.015
M204 S10000
G17
G3 Z9.24 I1.217 J0 P1  F18000
;===================== date: 20250206 =====================

; don't support timelapse gcode in spiral_mode and by object sequence for I3 structure printer
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
G92 E0
G1 Z9.24
G1 X0 Y85 ; move to safe pos
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
            G0 Z9.24 F4000
            G39.3 S1
            G0 Z9.24 F4000
            G392 S0
          
        M623
    
    M623
M623
; SKIPPABLE_END




; CHANGE_LAYER
; Z_HEIGHT: 8.96
; LAYER_HEIGHT: 0.12
; layer num/total_layer_count: 74/74
; update layer progress
M73 L74
M991 S0 P73 ;notify layer change
M106 S76.5
; OBJECT_ID: 8
G1 X57.691 Y90.79 F18000
G1 Z8.96
G1 E.3 F1800
G1 F600
M204 S5000
G1 X57.293 Y90.79 E.00744
G1 X57.293 Y79.21 E.21638
G1 X57.691 Y79.21 E.00745
G1 X57.691 Y90.73 E.21526
; WIPE_START
G1 F1800
M204 S6000
G1 X57.293 Y90.79 E-.05737
G1 X57.293 Y89.193 E-.22763
; WIPE_END
G1 E-.015
M204 S10000
G1 X64.882 Y90 Z9.36 F18000
G1 X72.308 Y90.79 Z9.36
G1 Z8.96
G1 E.3 F1800
G1 F600
M204 S5000
G1 X72.308 Y79.21 E.21638
G1 X72.708 Y79.21 E.00747
G1 X72.708 Y90.79 E.21638
G1 X72.368 Y90.79 E.00634
; WIPE_START
G1 F1800
M204 S6000
G1 X72.358 Y88.79 E-.285
; WIPE_END
G1 E-.015
M204 S10000
G17
G3 Z9.36 I1.217 J0 P1  F18000
;===================== date: 20250206 =====================

; don't support timelapse gcode in spiral_mode and by object sequence for I3 structure printer
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
G92 E0
G1 Z9.36
G1 X0 Y85 ; move to safe pos
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
            G0 Z9.36 F4000
            G39.3 S1
            G0 Z9.36 F4000
            G392 S0
          
        M623
    
    M623
M623
; SKIPPABLE_END




; close powerlost recovery
M1003 S0
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
G1 Z9.36 F900 ; lower z a little
G1 X0 Y85 F18000 ; move to safe pos
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

    G1 Z108.96 F600
    G1 Z106.96

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

