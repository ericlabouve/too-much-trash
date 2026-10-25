; HEADER_BLOCK_START
; BambuStudio 02.07.01.62
; model printing time: 15m 57s; total estimated time: 23m 6s
; total layer number: 102
; total filament length [mm] : 313.28
; total filament volume [cm^3] : 753.52
; total filament weight [g] : 0.94
; filament_density: 1.25
; filament_diameter: 1.75
; max_z_height: 11.60
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
M73 P0 R23
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
M73 P2 R22
    G1 E50 F200
    M400
    M1002 set_filament_type:PETG

    M104 S270

    G92 E0
    G1 E50 F149.669
    M400
    M106 P1 S178
    G92 E0
M73 P3 R22
    G1 E5 F149.669
    M109 S230 ; drop nozzle temp, make filament shink a bit
    M104 S210
    G92 E0
M73 P4 R22
    G1 E-0.5 F300

    G1 X0 F30000
    G1 X-13.5 F3000
M73 P4 R21
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
M73 P5 R21
G1 E-1 F500
G90
M83

M109 S170
M104 S140
G0 X90 Y-4 F30000
G380 S3 Z-5 F1200
M73 P23 R17
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
M73 P24 R17
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
    G29 A1 X87.35 Y79.2 I7.3 J21.6
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
    
M73 P25 R17
    G1 X-13.5 F3000
    M400
    M984 A0.1 E1 S1 F0.591372 H0.4
    M106 P1 S178
    M400 S7
    G1 X0 F18000
M73 P26 R17
    G1 X-13.5 F3000
    G1 X0 F18000 ;wipe and shake
    G1 X-13.5 F3000
M73 P26 R16
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
; layer num/total_layer_count: 1/102
; update layer progress
M73 L1
M991 S0 P0 ;notify layer change
M106 S0
; OBJECT_ID: 8
G1 X92.879 Y83.65 F18000
M204 S6000
G1 Z.4
M73 P27 R16
G1 Z.2
M73 P28 R16
G1 E.3 F1800
; FEATURE: Support
; LINE_WIDTH: 0.5
M204 S500
G1 X90.1 Y83.65 E.10035
G1 X90.1 Y96.35 E.45855
G1 X92.948 Y96.35 E.10282
G1 X94.4 Y93.639 E.11104
G1 X94.4 Y86.361 E.2628
M73 P29 R16
G1 X92.948 Y83.65 E.11103
M204 S6000
G1 X93.555 Y94.781 F18000
G1 F1800
M204 S500
G1 X93.555 Y85.655 E.32952
G1 X93.047 Y84.706 E.03883
G1 X93.047 Y95.293 E.38225
G1 X92.701 Y95.939 E.02643
G1 X92.539 Y95.939 E.00586
G1 X92.539 Y84.061 E.42884
G1 X92.031 Y84.061 E.01834
G1 X92.031 Y95.939 E.42884
G1 X91.524 Y95.939 E.01834
G1 X91.524 Y84.061 E.42884
G1 X91.016 Y84.061 E.01834
M73 P30 R16
G1 X91.016 Y96.144 E.43627
; WIPE_START
G1 X91.016 Y94.144 E-.285
; WIPE_END
G1 E-.015
M204 S6000
G1 X89.916 Y86.591 Z.6 F18000
G1 X88.943 Y79.907 Z.6
M73 P30 R15
G1 Z.2
G1 E.3 F1800
; FEATURE: Inner wall
M204 S500
G1 X88.943 Y100.093 E.72883
G1 X88.057 Y100.093 E.03199
G1 X88.057 Y79.907 E.72883
G1 X88.883 Y79.907 E.02982
M204 S6000
G1 X89.4 Y79.45 F18000
; FEATURE: Outer wall
G1 F1800
M204 S500
G1 X89.4 Y100.55 E.76184
G1 X87.6 Y100.55 E.06499
G1 X87.6 Y79.45 E.76184
G1 X89.34 Y79.45 E.06282
; WIPE_START
G1 X89.346 Y81.45 E-.285
; WIPE_END
G1 E-.015
M204 S6000
G17
M73 P31 R15
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




G1 X88.5 Y80.136
G1 Z.2
G1 E.3 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.47172
M204 S500
G1 X88.5 Y99.864 E.66826
; CHANGE_LAYER
; Z_HEIGHT: 0.32
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F1800
G1 X88.5 Y97.864 E-.285
; WIPE_END
G1 E-.015
; layer num/total_layer_count: 2/102
; update layer progress
M73 L2
M991 S0 P1 ;notify layer change
; open powerlost recovery
M1003 S1
M104 S245 ; set nozzle temperature
; OBJECT_ID: 8
M204 S10000
G17
G3 Z.6 I1.216 J.036 P1  F18000
G1 X89.031 Y79.819 Z.6
G1 Z.32
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F963
M204 S6000
G1 X89.031 Y100.181 E.40942
G1 X87.969 Y100.181 E.02134
G1 X87.969 Y79.819 E.40942
G1 X88.971 Y79.819 E.02014
M204 S250
G1 X89.44 Y79.41 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F963
M204 S5000
G1 X89.44 Y100.59 E.39576
G1 X87.56 Y100.59 E.03513
G1 X87.56 Y79.41 E.39576
G1 X89.38 Y79.41 E.03401
; WIPE_START
G1 F1800
M204 S6000
G1 X89.386 Y81.41 E-.285
; WIPE_END
G1 E-.015
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




G1 X88.5 Y80.031
G1 Z.32
G1 E.3 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.663042
G1 F963
M204 S6000
G1 X88.5 Y99.969 E.6022
; CHANGE_LAYER
; Z_HEIGHT: 0.44
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F2400
G1 X88.5 Y97.969 E-.285
; WIPE_END
G1 E-.015 F1800
; layer num/total_layer_count: 3/102
; update layer progress
M73 L3
M991 S0 P2 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z.72 I1.216 J.036 P1  F18000
G1 X89.031 Y79.819 Z.72
G1 Z.44
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F960
M204 S6000
G1 X89.031 Y100.181 E.40942
G1 X87.969 Y100.181 E.02134
G1 X87.969 Y79.819 E.40942
G1 X88.971 Y79.819 E.02014
M204 S250
G1 X89.44 Y79.41 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F960
M204 S5000
G1 X89.44 Y100.59 E.39576
G1 X87.56 Y100.59 E.03513
G1 X87.56 Y79.41 E.39576
M73 P32 R15
G1 X89.38 Y79.41 E.03401
; WIPE_START
G1 F1800
M204 S6000
G1 X89.386 Y81.41 E-.285
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
G1 X88.5 Y80.031
G1 Z.44
G1 E.3 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.663042
G1 F960
M204 S6000
G1 X88.5 Y99.969 E.6022
; CHANGE_LAYER
; Z_HEIGHT: 0.47
; LAYER_HEIGHT: 0.03
; WIPE_START
G1 F2400
G1 X88.5 Y97.969 E-.285
; WIPE_END
G1 E-.015 F1800
; layer num/total_layer_count: 4/102
; update layer progress
M73 L4
M991 S0 P3 ;notify layer change
M106 S73.95
; OBJECT_ID: 8
M204 S10000
G17
G3 Z.84 I1.146 J.41 P1  F18000
G1 X90.247 Y93.091 Z.84
G1 Z.47
G1 E.3 F1800
; FEATURE: Support
; LINE_WIDTH: 0.42
; LAYER_HEIGHT: 0.27
G1 F1320
M204 S6000
G1 X90.247 Y93.123 E.0012
G1 X91.327 Y94.202 E.05897
G1 X91.327 Y94.403 E.00774
G1 X91.782 Y94.403 E.01757
G1 X92.453 Y93.151 E.05486
G1 X92.453 Y92.894 E.0099
G1 X90.247 Y92.894 E.08517
G1 X90.247 Y90 E.11175
G1 X92.453 Y90 E.08517
G1 X92.453 Y87.106 E.11175
G1 X90.247 Y87.106 E.08517
G1 X90.247 Y86.878 E.00881
G1 X91.327 Y85.798 E.05897
G1 X91.327 Y85.597 E.00774
G1 X91.782 Y85.597 E.01757
G1 X92.453 Y86.849 E.05486
G1 X92.453 Y86.909 E.00229
; WIPE_START
G1 F3682.656
G1 X92.453 Y86.849 E-.00844
G1 X91.782 Y85.597 E-.20246
G1 X91.327 Y85.597 E-.06484
G1 X91.327 Y85.662 E-.00926
; WIPE_END
G1 E-.015 F1800
M204 S10000
G17
G3 Z.87 I1.217 J0 P1  F18000
;===================== date: 20250206 =====================

; don't support timelapse gcode in spiral_mode and by object sequence for I3 structure printer
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
G92 E0
G1 Z0.87
G1 X0 Y90 ; move to safe pos
M73 P33 R15
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
            G0 Z0.87 F4000
            G39.3 S1
            G0 Z0.87 F4000
            G392 S0
          
        M623
    
    M623
M623
; SKIPPABLE_END




; CHANGE_LAYER
; Z_HEIGHT: 0.56
; LAYER_HEIGHT: 0.09
; layer num/total_layer_count: 5/102
; update layer progress
M73 L5
M991 S0 P4 ;notify layer change
; OBJECT_ID: 8
G1 X89.031 Y79.819
G1 Z.56
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
; LAYER_HEIGHT: 0.12
G1 F1320
M204 S6000
G1 X89.031 Y100.181 E.40942
G1 X87.969 Y100.181 E.02134
G1 X87.969 Y79.819 E.40942
G1 X88.971 Y79.819 E.02014
M204 S250
G1 X89.44 Y79.41 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1320
M204 S5000
G1 X89.44 Y100.59 E.39576
G1 X87.56 Y100.59 E.03513
G1 X87.56 Y79.41 E.39576
G1 X89.38 Y79.41 E.03401
; WIPE_START
G1 F1800
M204 S6000
G1 X89.386 Y81.41 E-.285
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




G1 X88.5 Y80.031
G1 Z.56
G1 E.3 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.663042
G1 F1320
M204 S6000
G1 X88.5 Y99.969 E.6022
; CHANGE_LAYER
; Z_HEIGHT: 0.68
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F2400
G1 X88.5 Y97.969 E-.285
; WIPE_END
G1 E-.015 F1800
; layer num/total_layer_count: 6/102
; update layer progress
M73 L6
M991 S0 P5 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z.96 I1.216 J.036 P1  F18000
G1 X89.031 Y79.819 Z.96
G1 Z.68
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F960
M204 S6000
G1 X89.031 Y100.181 E.40942
G1 X87.969 Y100.181 E.02134
G1 X87.969 Y79.819 E.40942
G1 X88.971 Y79.819 E.02014
M204 S250
G1 X89.44 Y79.41 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F960
M204 S5000
G1 X89.44 Y100.59 E.39576
G1 X87.56 Y100.59 E.03513
G1 X87.56 Y79.41 E.39576
G1 X89.38 Y79.41 E.03401
; WIPE_START
G1 F1800
M204 S6000
G1 X89.386 Y81.41 E-.285
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




G1 X88.5 Y80.031
G1 Z.68
G1 E.3 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.663042
G1 F960
M204 S6000
G1 X88.5 Y99.969 E.6022
; CHANGE_LAYER
; Z_HEIGHT: 0.74
; LAYER_HEIGHT: 0.06
; WIPE_START
G1 F2400
G1 X88.5 Y97.969 E-.285
; WIPE_END
G1 E-.015 F1800
; layer num/total_layer_count: 7/102
; update layer progress
M73 L7
M991 S0 P6 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z1.08 I1.146 J.41 P1  F18000
G1 X90.247 Y93.091 Z1.08
G1 Z.74
G1 E.3 F1800
; FEATURE: Support
; LINE_WIDTH: 0.42
; LAYER_HEIGHT: 0.27
G1 F1320
M204 S6000
G1 X90.247 Y93.123 E.0012
G1 X91.327 Y94.202 E.05897
G1 X91.327 Y94.403 E.00774
G1 X91.782 Y94.403 E.01757
G1 X92.453 Y93.151 E.05486
G1 X92.453 Y92.894 E.0099
G1 X90.247 Y92.894 E.08517
G1 X90.247 Y90 E.11175
G1 X92.453 Y90 E.08517
G1 X92.453 Y87.106 E.11175
M73 P34 R15
G1 X90.247 Y87.106 E.08517
G1 X90.247 Y86.878 E.00881
G1 X91.327 Y85.798 E.05897
G1 X91.327 Y85.597 E.00774
G1 X91.782 Y85.597 E.01757
G1 X92.453 Y86.849 E.05486
G1 X92.453 Y86.909 E.00229
; WIPE_START
G1 F3682.656
G1 X92.453 Y86.849 E-.00844
G1 X91.782 Y85.597 E-.20246
G1 X91.327 Y85.597 E-.06484
G1 X91.327 Y85.662 E-.00926
; WIPE_END
G1 E-.015 F1800
M204 S10000
G17
G3 Z1.14 I1.217 J0 P1  F18000
;===================== date: 20250206 =====================

; don't support timelapse gcode in spiral_mode and by object sequence for I3 structure printer
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
G92 E0
G1 Z1.14
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
            G0 Z1.14 F4000
            G39.3 S1
            G0 Z1.14 F4000
            G392 S0
          
        M623
    
    M623
M623
; SKIPPABLE_END




; CHANGE_LAYER
; Z_HEIGHT: 0.8
; LAYER_HEIGHT: 0.06
; layer num/total_layer_count: 8/102
; update layer progress
M73 L8
M991 S0 P7 ;notify layer change
; OBJECT_ID: 8
G1 X89.031 Y79.819
G1 Z.8
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
; LAYER_HEIGHT: 0.12
G1 F1320
M204 S6000
G1 X89.031 Y100.181 E.40942
G1 X87.969 Y100.181 E.02134
G1 X87.969 Y79.819 E.40942
G1 X88.971 Y79.819 E.02014
M204 S250
G1 X89.44 Y79.41 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1320
M204 S5000
G1 X89.44 Y100.59 E.39576
G1 X87.56 Y100.59 E.03513
G1 X87.56 Y79.41 E.39576
G1 X89.38 Y79.41 E.03401
; WIPE_START
G1 F1800
M204 S6000
G1 X89.386 Y81.41 E-.285
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




G1 X88.5 Y80.031
G1 Z.8
G1 E.3 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.663042
G1 F1320
M204 S6000
G1 X88.5 Y99.969 E.6022
; CHANGE_LAYER
; Z_HEIGHT: 0.92
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F2400
G1 X88.5 Y97.969 E-.285
; WIPE_END
G1 E-.015 F1800
; layer num/total_layer_count: 9/102
; update layer progress
M73 L9
M991 S0 P8 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z1.2 I1.216 J.036 P1  F18000
G1 X89.031 Y79.819 Z1.2
G1 Z.92
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F960
M204 S6000
G1 X89.031 Y100.181 E.40942
G1 X87.969 Y100.181 E.02134
G1 X87.969 Y79.819 E.40942
G1 X88.971 Y79.819 E.02014
M204 S250
G1 X89.44 Y79.41 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F960
M204 S5000
G1 X89.44 Y100.59 E.39576
G1 X87.56 Y100.59 E.03513
G1 X87.56 Y79.41 E.39576
G1 X89.38 Y79.41 E.03401
; WIPE_START
G1 F1800
M204 S6000
G1 X89.386 Y81.41 E-.285
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




G1 X88.5 Y80.031
G1 Z.92
M73 P35 R15
G1 E.3 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.663042
G1 F960
M204 S6000
G1 X88.5 Y99.969 E.6022
; CHANGE_LAYER
; Z_HEIGHT: 1.01
; LAYER_HEIGHT: 0.09
; WIPE_START
G1 F2400
G1 X88.5 Y97.969 E-.285
; WIPE_END
G1 E-.015 F1800
; layer num/total_layer_count: 10/102
; update layer progress
M73 L10
M991 S0 P9 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z1.32 I1.146 J.41 P1  F18000
G1 X90.247 Y93.091 Z1.32
G1 Z1.01
M73 P35 R14
G1 E.3 F1800
; FEATURE: Support
; LINE_WIDTH: 0.42
; LAYER_HEIGHT: 0.27
G1 F1320
M204 S6000
G1 X90.247 Y93.123 E.0012
G1 X91.327 Y94.202 E.05897
G1 X91.327 Y94.403 E.00774
G1 X91.782 Y94.403 E.01757
G1 X92.453 Y93.151 E.05486
G1 X92.453 Y92.894 E.0099
G1 X90.247 Y92.894 E.08517
G1 X90.247 Y90 E.11175
G1 X92.453 Y90 E.08517
G1 X92.453 Y87.106 E.11175
G1 X90.247 Y87.106 E.08517
G1 X90.247 Y86.878 E.00881
G1 X91.327 Y85.798 E.05897
G1 X91.327 Y85.597 E.00774
G1 X91.782 Y85.597 E.01757
G1 X92.453 Y86.849 E.05486
G1 X92.453 Y86.909 E.00229
; WIPE_START
G1 F3682.656
G1 X92.453 Y86.849 E-.00844
G1 X91.782 Y85.597 E-.20246
G1 X91.327 Y85.597 E-.06484
G1 X91.327 Y85.662 E-.00926
; WIPE_END
G1 E-.015 F1800
M204 S10000
G17
G3 Z1.41 I1.217 J0 P1  F18000
;===================== date: 20250206 =====================

; don't support timelapse gcode in spiral_mode and by object sequence for I3 structure printer
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
G92 E0
G1 Z1.41
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
            G0 Z1.41 F4000
            G39.3 S1
            G0 Z1.41 F4000
            G392 S0
          
        M623
    
    M623
M623
; SKIPPABLE_END




; CHANGE_LAYER
; Z_HEIGHT: 1.04
; LAYER_HEIGHT: 0.03
; layer num/total_layer_count: 11/102
; update layer progress
M73 L11
M991 S0 P10 ;notify layer change
; OBJECT_ID: 8
G1 X89.031 Y79.819
G1 Z1.04
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
; LAYER_HEIGHT: 0.12
G1 F1320
M204 S6000
G1 X89.031 Y100.181 E.40942
G1 X87.969 Y100.181 E.02134
G1 X87.969 Y79.819 E.40942
G1 X88.971 Y79.819 E.02014
M204 S250
G1 X89.44 Y79.41 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1320
M204 S5000
G1 X89.44 Y100.59 E.39576
G1 X87.56 Y100.59 E.03513
M73 P36 R14
G1 X87.56 Y79.41 E.39576
G1 X89.38 Y79.41 E.03401
; WIPE_START
G1 F1800
M204 S6000
G1 X89.386 Y81.41 E-.285
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




G1 X88.5 Y80.031
G1 Z1.04
G1 E.3 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.663042
G1 F1320
M204 S6000
G1 X88.5 Y99.969 E.6022
; CHANGE_LAYER
; Z_HEIGHT: 1.16
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F2400
G1 X88.5 Y97.969 E-.285
; WIPE_END
G1 E-.015 F1800
; layer num/total_layer_count: 12/102
; update layer progress
M73 L12
M991 S0 P11 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z1.44 I1.216 J.036 P1  F18000
G1 X89.031 Y79.819 Z1.44
G1 Z1.16
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F960
M204 S6000
G1 X89.031 Y100.181 E.40942
G1 X87.969 Y100.181 E.02134
G1 X87.969 Y79.819 E.40942
G1 X88.971 Y79.819 E.02014
M204 S250
G1 X89.44 Y79.41 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F960
M204 S5000
G1 X89.44 Y100.59 E.39576
G1 X87.56 Y100.59 E.03513
G1 X87.56 Y79.41 E.39576
G1 X89.38 Y79.41 E.03401
; WIPE_START
G1 F1800
M204 S6000
G1 X89.386 Y81.41 E-.285
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




G1 X88.5 Y80.031
G1 Z1.16
G1 E.3 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.663042
G1 F960
M204 S6000
G1 X88.5 Y99.969 E.6022
; CHANGE_LAYER
; Z_HEIGHT: 1.28
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F2400
G1 X88.5 Y97.969 E-.285
; WIPE_END
G1 E-.015 F1800
; layer num/total_layer_count: 13/102
; update layer progress
M73 L13
M991 S0 P12 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z1.56 I1.146 J.41 P1  F18000
G1 X90.247 Y93.091 Z1.56
G1 Z1.28
G1 E.3 F1800
; FEATURE: Support
; LINE_WIDTH: 0.42
; LAYER_HEIGHT: 0.27
G1 F1148
M204 S6000
G1 X90.247 Y93.123 E.0012
G1 X91.327 Y94.202 E.05897
G1 X91.327 Y94.403 E.00774
G1 X91.782 Y94.403 E.01757
G1 X92.453 Y93.151 E.05486
G1 X92.453 Y92.894 E.0099
G1 X90.247 Y92.894 E.08517
G1 X90.247 Y90 E.11175
G1 X92.453 Y90 E.08517
G1 X92.453 Y87.106 E.11175
G1 X90.247 Y87.106 E.08517
G1 X90.247 Y86.878 E.00881
G1 X91.327 Y85.798 E.05897
G1 X91.327 Y85.597 E.00774
G1 X91.782 Y85.597 E.01757
G1 X92.453 Y86.849 E.05486
G1 X92.453 Y86.909 E.00229
; WIPE_START
G1 F3682.656
G1 X92.453 Y86.849 E-.00844
G1 X91.782 Y85.597 E-.20246
G1 X91.327 Y85.597 E-.06484
G1 X91.327 Y85.662 E-.00926
; WIPE_END
M73 P37 R14
G1 E-.015 F1800
M204 S10000
G17
G3 Z1.68 I1.133 J-.445 P1  F18000
G1 X89.031 Y79.819 Z1.68
G1 Z1.28
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
; LAYER_HEIGHT: 0.12
G1 F1148
M204 S6000
G1 X89.031 Y100.181 E.40942
G1 X87.969 Y100.181 E.02134
G1 X87.969 Y79.819 E.40942
G1 X88.971 Y79.819 E.02014
M204 S250
G1 X89.44 Y79.41 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1148
M204 S5000
G1 X89.44 Y100.59 E.39576
G1 X87.56 Y100.59 E.03513
G1 X87.56 Y79.41 E.39576
G1 X89.38 Y79.41 E.03401
; WIPE_START
G1 F1800
M204 S6000
G1 X89.386 Y81.41 E-.285
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




G1 X88.5 Y80.031
G1 Z1.28
G1 E.3 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.663042
G1 F1148
M204 S6000
G1 X88.5 Y99.969 E.6022
; CHANGE_LAYER
; Z_HEIGHT: 1.4
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F2400
G1 X88.5 Y97.969 E-.285
; WIPE_END
G1 E-.015 F1800
; layer num/total_layer_count: 14/102
; update layer progress
M73 L14
M991 S0 P13 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z1.68 I1.216 J.036 P1  F18000
G1 X89.031 Y79.819 Z1.68
G1 Z1.4
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F960
M204 S6000
G1 X89.031 Y100.181 E.40942
G1 X87.969 Y100.181 E.02134
G1 X87.969 Y79.819 E.40942
G1 X88.971 Y79.819 E.02014
M204 S250
G1 X89.44 Y79.41 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F960
M204 S5000
G1 X89.44 Y100.59 E.39576
G1 X87.56 Y100.59 E.03513
G1 X87.56 Y79.41 E.39576
G1 X89.38 Y79.41 E.03401
; WIPE_START
G1 F1800
M204 S6000
G1 X89.386 Y81.41 E-.285
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




G1 X88.5 Y80.031
G1 Z1.4
G1 E.3 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.663042
G1 F960
M204 S6000
G1 X88.5 Y99.969 E.6022
; CHANGE_LAYER
; Z_HEIGHT: 1.52
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F2400
G1 X88.5 Y97.969 E-.285
; WIPE_END
G1 E-.015 F1800
; layer num/total_layer_count: 15/102
; update layer progress
M73 L15
M991 S0 P14 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z1.8 I1.216 J.036 P1  F18000
G1 X89.031 Y79.819 Z1.8
G1 Z1.52
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F960
M204 S6000
G1 X89.031 Y100.181 E.40942
G1 X87.969 Y100.181 E.02134
G1 X87.969 Y79.819 E.40942
G1 X88.971 Y79.819 E.02014
M204 S250
G1 X89.44 Y79.41 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F960
M204 S5000
G1 X89.44 Y100.59 E.39576
G1 X87.56 Y100.59 E.03513
M73 P38 R14
G1 X87.56 Y79.41 E.39576
G1 X89.38 Y79.41 E.03401
; WIPE_START
G1 F1800
M204 S6000
G1 X89.386 Y81.41 E-.285
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




G1 X88.5 Y80.031
G1 Z1.52
G1 E.3 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.663042
G1 F960
M204 S6000
G1 X88.5 Y99.969 E.6022
; CHANGE_LAYER
; Z_HEIGHT: 1.55
; LAYER_HEIGHT: 0.03
; WIPE_START
G1 F2400
G1 X88.5 Y97.969 E-.285
; WIPE_END
G1 E-.015 F1800
; layer num/total_layer_count: 16/102
; update layer progress
M73 L16
M991 S0 P15 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z1.92 I1.146 J.41 P1  F18000
G1 X90.247 Y93.091 Z1.92
G1 Z1.55
G1 E.3 F1800
; FEATURE: Support
; LINE_WIDTH: 0.42
; LAYER_HEIGHT: 0.27
G1 F1320
M204 S6000
G1 X90.247 Y93.123 E.0012
G1 X91.327 Y94.202 E.05897
G1 X91.327 Y94.403 E.00774
G1 X91.782 Y94.403 E.01757
G1 X92.453 Y93.151 E.05486
G1 X92.453 Y92.894 E.0099
G1 X90.247 Y92.894 E.08517
G1 X90.247 Y90 E.11175
G1 X92.453 Y90 E.08517
G1 X92.453 Y87.106 E.11175
G1 X90.247 Y87.106 E.08517
G1 X90.247 Y86.878 E.00881
G1 X91.327 Y85.798 E.05897
G1 X91.327 Y85.597 E.00774
G1 X91.782 Y85.597 E.01757
G1 X92.453 Y86.849 E.05486
G1 X92.453 Y86.909 E.00229
; WIPE_START
G1 F3682.656
G1 X92.453 Y86.849 E-.00844
G1 X91.782 Y85.597 E-.20246
G1 X91.327 Y85.597 E-.06484
G1 X91.327 Y85.662 E-.00926
; WIPE_END
G1 E-.015 F1800
M204 S10000
G17
G3 Z1.95 I1.217 J0 P1  F18000
;===================== date: 20250206 =====================

; don't support timelapse gcode in spiral_mode and by object sequence for I3 structure printer
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
G92 E0
G1 Z1.95
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
            G0 Z1.95 F4000
            G39.3 S1
            G0 Z1.95 F4000
            G392 S0
          
        M623
    
    M623
M623
; SKIPPABLE_END




; CHANGE_LAYER
; Z_HEIGHT: 1.64
; LAYER_HEIGHT: 0.09
; layer num/total_layer_count: 17/102
; update layer progress
M73 L17
M991 S0 P16 ;notify layer change
; OBJECT_ID: 8
M73 P39 R14
G1 X89.031 Y79.819
G1 Z1.64
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
; LAYER_HEIGHT: 0.12
G1 F1320
M204 S6000
G1 X89.031 Y100.181 E.40942
G1 X87.969 Y100.181 E.02134
G1 X87.969 Y79.819 E.40942
G1 X88.971 Y79.819 E.02014
M204 S250
G1 X89.44 Y79.41 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1320
M204 S5000
G1 X89.44 Y100.59 E.39576
G1 X87.56 Y100.59 E.03513
G1 X87.56 Y79.41 E.39576
G1 X89.38 Y79.41 E.03401
; WIPE_START
G1 F1800
M204 S6000
G1 X89.386 Y81.41 E-.285
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
M73 P39 R13
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




G1 X88.5 Y80.031
G1 Z1.64
G1 E.3 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.663042
G1 F1320
M204 S6000
G1 X88.5 Y99.969 E.6022
; CHANGE_LAYER
; Z_HEIGHT: 1.76
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F2400
G1 X88.5 Y97.969 E-.285
; WIPE_END
G1 E-.015 F1800
; layer num/total_layer_count: 18/102
; update layer progress
M73 L18
M991 S0 P17 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z2.04 I1.216 J.036 P1  F18000
G1 X89.031 Y79.819 Z2.04
G1 Z1.76
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F960
M204 S6000
G1 X89.031 Y100.181 E.40942
G1 X87.969 Y100.181 E.02134
G1 X87.969 Y79.819 E.40942
G1 X88.971 Y79.819 E.02014
M204 S250
G1 X89.44 Y79.41 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F960
M204 S5000
G1 X89.44 Y100.59 E.39576
G1 X87.56 Y100.59 E.03513
G1 X87.56 Y79.41 E.39576
G1 X89.38 Y79.41 E.03401
; WIPE_START
G1 F1800
M204 S6000
G1 X89.386 Y81.41 E-.285
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




G1 X88.5 Y80.031
G1 Z1.76
G1 E.3 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.663042
G1 F960
M204 S6000
G1 X88.5 Y99.969 E.6022
; CHANGE_LAYER
; Z_HEIGHT: 1.82
; LAYER_HEIGHT: 0.0600001
; WIPE_START
G1 F2400
G1 X88.5 Y97.969 E-.285
; WIPE_END
G1 E-.015 F1800
; layer num/total_layer_count: 19/102
; update layer progress
M73 L19
M991 S0 P18 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z2.16 I1.08 J.561 P1  F18000
G1 X90.755 Y93.63 Z2.16
G1 Z1.82
G1 E.3 F1800
; FEATURE: Support transition
; LINE_WIDTH: 0.42
; LAYER_HEIGHT: 0.27
G1 F1467
M204 S6000
G1 X90.247 Y93.123 E.02773
G1 X90.247 Y86.877 E.24112
G1 X90.894 Y86.23 E.03534
G1 X90.894 Y93.77 E.2911
G1 X91.327 Y94.202 E.02363
M73 P40 R13
G1 X91.327 Y94.403 E.00775
G1 X91.782 Y94.403 E.01757
G1 X91.788 Y85.609 E.33955
G1 X92.453 Y86.849 E.05434
G1 X92.453 Y93.151 E.24329
G1 X91.882 Y94.217 E.04673
; WIPE_START
G1 F3000
G1 X92.453 Y93.151 E-.17246
G1 X92.453 Y92.361 E-.11254
; WIPE_END
G1 E-.015 F1800
M204 S10000
G17
G3 Z2.22 I1.217 J0 P1  F18000
;===================== date: 20250206 =====================

; don't support timelapse gcode in spiral_mode and by object sequence for I3 structure printer
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
G92 E0
G1 Z2.22
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
            G0 Z2.22 F4000
            G39.3 S1
            G0 Z2.22 F4000
            G392 S0
          
        M623
    
    M623
M623
; SKIPPABLE_END




; CHANGE_LAYER
; Z_HEIGHT: 1.88
; LAYER_HEIGHT: 0.0599999
; layer num/total_layer_count: 20/102
; update layer progress
M73 L20
M991 S0 P19 ;notify layer change
; OBJECT_ID: 8
G1 X89.031 Y79.819
G1 Z1.88
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
; LAYER_HEIGHT: 0.12
G1 F1467
M204 S6000
G1 X89.031 Y100.181 E.40942
G1 X87.969 Y100.181 E.02134
G1 X87.969 Y79.819 E.40942
G1 X88.971 Y79.819 E.02014
M204 S250
G1 X89.44 Y79.41 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1467
M204 S5000
G1 X89.44 Y100.59 E.39576
G1 X87.56 Y100.59 E.03513
G1 X87.56 Y79.41 E.39576
G1 X89.38 Y79.41 E.03401
; WIPE_START
G1 F1800
M204 S6000
G1 X89.386 Y81.41 E-.285
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




G1 X88.5 Y80.031
G1 Z1.88
G1 E.3 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.663042
G1 F1467
M204 S6000
G1 X88.5 Y99.969 E.6022
; CHANGE_LAYER
; Z_HEIGHT: 2
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F2400
G1 X88.5 Y97.969 E-.285
; WIPE_END
G1 E-.015 F1800
; layer num/total_layer_count: 21/102
; update layer progress
M73 L21
M991 S0 P20 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z2.28 I1.216 J.036 P1  F18000
G1 X89.031 Y79.819 Z2.28
G1 Z2
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F960
M204 S6000
G1 X89.031 Y100.181 E.40942
M73 P41 R13
G1 X87.969 Y100.181 E.02134
G1 X87.969 Y79.819 E.40942
G1 X88.971 Y79.819 E.02014
M204 S250
G1 X89.44 Y79.41 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F960
M204 S5000
G1 X89.44 Y100.59 E.39576
G1 X87.56 Y100.59 E.03513
G1 X87.56 Y79.41 E.39576
G1 X89.38 Y79.41 E.03401
; WIPE_START
G1 F1800
M204 S6000
G1 X89.386 Y81.41 E-.285
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




G1 X88.5 Y80.031
G1 Z2
G1 E.3 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.663042
G1 F960
M204 S6000
G1 X88.5 Y99.969 E.6022
; CHANGE_LAYER
; Z_HEIGHT: 2.09
; LAYER_HEIGHT: 0.0899999
; WIPE_START
G1 F2400
G1 X88.5 Y97.969 E-.285
; WIPE_END
G1 E-.015 F1800
; layer num/total_layer_count: 22/102
; update layer progress
M73 L22
M991 S0 P21 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z2.4 I1.041 J.631 P1  F18000
G1 X90.894 Y94.021 Z2.4
G1 Z2.09
G1 E.3 F1800
; FEATURE: Support interface
; LINE_WIDTH: 0.42
; LAYER_HEIGHT: 0.27
G1 F1299
M204 S6000
G1 X90.894 Y86.23 E.30079
G1 X91.327 Y85.798 E.02363
G1 X91.327 Y85.597 E.00775
G1 X91.782 Y85.597 E.01758
G1 X91.788 Y94.58 E.34685
; WIPE_START
G1 F3682.656
G1 X91.787 Y92.58 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G17
G3 Z2.49 I1.217 J0 P1  F18000
;===================== date: 20250206 =====================

; don't support timelapse gcode in spiral_mode and by object sequence for I3 structure printer
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
G92 E0
G1 Z2.49
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
            G0 Z2.49 F4000
            G39.3 S1
            G0 Z2.49 F4000
            G392 S0
          
        M623
    
    M623
M623
; SKIPPABLE_END




; CHANGE_LAYER
; Z_HEIGHT: 2.12
; LAYER_HEIGHT: 0.03
; layer num/total_layer_count: 23/102
; update layer progress
M73 L23
M991 S0 P22 ;notify layer change
; OBJECT_ID: 8
G1 X89.031 Y79.819
G1 Z2.12
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
; LAYER_HEIGHT: 0.12
G1 F1299
M204 S6000
G1 X89.031 Y100.181 E.40942
G1 X87.969 Y100.181 E.02134
G1 X87.969 Y79.819 E.40942
G1 X88.971 Y79.819 E.02014
M204 S250
G1 X89.44 Y79.41 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1299
M204 S5000
G1 X89.44 Y100.59 E.39576
G1 X87.56 Y100.59 E.03513
G1 X87.56 Y79.41 E.39576
G1 X89.38 Y79.41 E.03401
; WIPE_START
G1 F1800
M204 S6000
G1 X89.386 Y81.41 E-.285
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




G1 X88.5 Y80.031
G1 Z2.12
G1 E.3 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.663042
G1 F1299
M204 S6000
G1 X88.5 Y99.969 E.6022
; CHANGE_LAYER
; Z_HEIGHT: 2.24
; LAYER_HEIGHT: 0.12
; WIPE_START
M73 P42 R13
G1 F2400
G1 X88.5 Y97.969 E-.285
; WIPE_END
G1 E-.015 F1800
; layer num/total_layer_count: 24/102
; update layer progress
M73 L24
M991 S0 P23 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z2.52 I1.216 J.036 P1  F18000
G1 X89.031 Y79.819 Z2.52
G1 Z2.24
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F960
M204 S6000
G1 X89.031 Y100.181 E.40942
G1 X87.969 Y100.181 E.02134
G1 X87.969 Y79.819 E.40942
G1 X88.971 Y79.819 E.02014
M204 S250
G1 X89.44 Y79.41 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F960
M204 S5000
G1 X89.44 Y100.59 E.39576
G1 X87.56 Y100.59 E.03513
G1 X87.56 Y79.41 E.39576
G1 X89.38 Y79.41 E.03401
; WIPE_START
G1 F1800
M204 S6000
G1 X89.386 Y81.41 E-.285
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




G1 X88.5 Y80.031
G1 Z2.24
G1 E.3 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.663042
G1 F960
M204 S6000
G1 X88.5 Y99.969 E.6022
; CHANGE_LAYER
; Z_HEIGHT: 2.36
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F2400
G1 X88.5 Y97.969 E-.285
; WIPE_END
G1 E-.015 F1800
; layer num/total_layer_count: 25/102
; update layer progress
M73 L25
M991 S0 P24 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z2.64 I1.112 J.494 P1  F18000
G1 X90.451 Y93.577 Z2.64
G1 Z2.36
G1 E.3 F1800
; FEATURE: Support interface
; LINE_WIDTH: 0.42
; LAYER_HEIGHT: 0.27
G1 F1198
M204 S6000
G1 X92.225 Y93.577 E.06849
G1 X92.453 Y93.151 E.01868
G1 X92.453 Y92.683 E.01806
G1 X90.247 Y92.683 E.08517
G1 X90.247 Y91.788 E.03453
G1 X92.453 Y91.788 E.08517
G1 X92.453 Y90.894 E.03453
G1 X90.247 Y90.894 E.08517
G1 X90.247 Y90 E.03453
G1 X92.453 Y90 E.08517
G1 X92.453 Y89.106 E.03453
G1 X90.247 Y89.106 E.08517
G1 X90.247 Y88.212 E.03453
G1 X92.453 Y88.212 E.08517
G1 X92.453 Y87.317 E.03453
G1 X90.247 Y87.317 E.08517
G1 X90.247 Y86.878 E.01697
M73 P43 R13
G1 X90.702 Y86.423 E.02482
G1 X92.426 Y86.423 E.06657
; WIPE_START
G1 F3682.656
G1 X90.702 Y86.423 E-.24569
G1 X90.507 Y86.618 E-.03931
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X89.031 Y79.819 Z2.76 F18000
G1 Z2.36
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
; LAYER_HEIGHT: 0.12
G1 F1198
M204 S6000
G1 X89.031 Y100.181 E.40942
G1 X87.969 Y100.181 E.02134
G1 X87.969 Y79.819 E.40942
G1 X88.971 Y79.819 E.02014
M204 S250
G1 X89.44 Y79.41 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1198
M204 S5000
G1 X89.44 Y100.59 E.39576
G1 X87.56 Y100.59 E.03513
G1 X87.56 Y79.41 E.39576
G1 X89.38 Y79.41 E.03401
; WIPE_START
G1 F1800
M204 S6000
G1 X89.386 Y81.41 E-.285
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




G1 X88.5 Y80.031
G1 Z2.36
G1 E.3 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.663042
G1 F1198
M204 S6000
G1 X88.5 Y99.969 E.6022
; CHANGE_LAYER
; Z_HEIGHT: 2.48
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F2400
G1 X88.5 Y97.969 E-.285
; WIPE_END
G1 E-.015 F1800
; layer num/total_layer_count: 26/102
; update layer progress
M73 L26
M991 S0 P25 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z2.76 I1.216 J.036 P1  F18000
G1 X89.031 Y79.819 Z2.76
G1 Z2.48
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F960
M204 S6000
G1 X89.031 Y100.181 E.40942
M73 P43 R12
G1 X87.969 Y100.181 E.02134
G1 X87.969 Y79.819 E.40942
G1 X88.971 Y79.819 E.02014
M204 S250
G1 X89.44 Y79.41 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F960
M204 S5000
G1 X89.44 Y100.59 E.39576
G1 X87.56 Y100.59 E.03513
G1 X87.56 Y79.41 E.39576
G1 X89.38 Y79.41 E.03401
; WIPE_START
M73 P44 R12
G1 F1800
M204 S6000
G1 X89.386 Y81.41 E-.285
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




G1 X88.5 Y80.031
G1 Z2.48
G1 E.3 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.663042
G1 F960
M204 S6000
G1 X88.5 Y99.969 E.6022
; CHANGE_LAYER
; Z_HEIGHT: 2.6
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F2400
G1 X88.5 Y97.969 E-.285
; WIPE_END
G1 E-.015 F1800
; layer num/total_layer_count: 27/102
; update layer progress
M73 L27
M991 S0 P26 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z2.88 I1.216 J.036 P1  F18000
G1 X89.031 Y79.819 Z2.88
G1 Z2.6
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F960
M204 S6000
G1 X89.031 Y100.181 E.40942
G1 X87.969 Y100.181 E.02134
G1 X87.969 Y79.819 E.40942
G1 X88.971 Y79.819 E.02014
M204 S250
G1 X89.44 Y79.41 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F960
M204 S5000
G1 X89.44 Y100.59 E.39576
G1 X87.56 Y100.59 E.03513
G1 X87.56 Y79.41 E.39576
G1 X89.38 Y79.41 E.03401
; WIPE_START
G1 F1800
M204 S6000
G1 X89.386 Y81.41 E-.285
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




G1 X88.5 Y80.031
G1 Z2.6
G1 E.3 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.663042
G1 F960
M204 S6000
G1 X88.5 Y99.969 E.6022
M106 S229.5
; CHANGE_LAYER
; Z_HEIGHT: 2.72
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F2400
G1 X88.5 Y97.969 E-.285
; WIPE_END
G1 E-.015 F1800
; layer num/total_layer_count: 28/102
; update layer progress
M73 L28
M991 S0 P27 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z3 I1.206 J.162 P1  F18000
G1 X89.85 Y87.931 Z3
G1 Z2.72
G1 E.3 F1800
; FEATURE: Overhang wall
; LINE_WIDTH: 0.45
G1 F600
M204 S5000
G1 X91.607 Y87.931 E.03532
G1 X91.607 Y92.069 E.0832
M106 S73.95
M106 S229.5
G1 F3000
G1 X89.85 Y92.069 E.03532
M106 S73.95
M106 S229.5
; FEATURE: Inner wall
G1 F600
M204 S6000
G1 X89.468 Y92.069 E.00769
M106 S73.95
M106 S229.5
G1 F2725.645
G1 X89.068 Y92.069 E.00804
G1 F3600
G1 X88.668 Y92.069 E.00804
G1 X88.393 Y92.069 E.00551
G1 X88.393 Y87.931 E.0832
G1 X88.668 Y87.931 E.00551
G1 X89.068 Y87.931 E.00804
G1 F2725.645
G1 X89.468 Y87.931 E.00804
G1 F600
G1 X89.79 Y87.931 E.00648
M106 S73.95
M106 S229.5
M204 S250
G1 X89.85 Y87.507 F18000
; FEATURE: Overhang wall
G1 F600
M204 S5000
G1 X91.749 Y87.507 E.03819
G1 X91.749 Y86.838 E.01346
G1 X91.942 Y86.789 E.00399
M73 P45 R12
G1 X92.031 Y86.955 E.00379
G1 X92.031 Y93.045 E.12244
G1 X91.942 Y93.211 E.00379
G1 X91.749 Y93.162 E.00399
G1 X91.749 Y92.493 E.01346
G1 X89.85 Y92.493 E.03819
M106 S73.95
M106 S229.5
; FEATURE: Inner wall
M204 S6000
G1 X89.468 Y92.493 E.00769
M106 S73.95
M106 S229.5
G1 F2997.905
G1 X89.031 Y92.493 E.00878
G1 F3600
G1 X89.031 Y92.893 E.00804
G1 X89.031 Y100.181 E.14654
G1 X87.969 Y100.181 E.02134
G1 X87.969 Y79.819 E.40942
G1 X89.031 Y79.819 E.02134
G1 X89.031 Y87.107 E.14654
G1 X89.031 Y87.507 E.00804
G1 F2997.905
G1 X89.468 Y87.507 E.00878
G1 F600
G1 X89.79 Y87.507 E.00648
M106 S73.95
M106 S229.5
M204 S250
G1 X89.481 Y87.098 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F600
M204 S5000
G1 X89.85 Y87.098 E.0069
M106 S73.95
M106 S229.5
; FEATURE: Overhang wall
; LINE_WIDTH: 0.45

G1 X91.34 Y87.098 E.02996
G1 X91.34 Y85.61 E.02991
G1 X91.774 Y85.61 E.00873
G1 X92.44 Y86.853 E.02835
G1 X92.44 Y93.147 E.12657
G1 X91.774 Y94.39 E.02835
G1 X91.34 Y94.39 E.00873
G1 X91.34 Y92.902 E.02991
G1 X89.85 Y92.902 E.02996
M106 S73.95
M106 S229.5
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 X89.481 Y92.902 E.0069
M106 S73.95
G1 F747.227
G1 X89.44 Y92.902 E.00077
G1 F1800
G1 X89.44 Y93.302 E.00747
M106 S229.5
G1 X89.44 Y100.59 E.13617
G1 X87.56 Y100.59 E.03513
G1 X87.56 Y79.41 E.39576
G1 X89.44 Y79.41 E.03513
G1 X89.44 Y87.079 E.14329
; WIPE_START
M204 S6000
G1 X89.85 Y87.098 E-.05849
G1 X91.34 Y87.098 E-.21233
G1 X91.34 Y86.998 E-.01419
; WIPE_END
G1 E-.015
M204 S10000
G17
M73 P46 R12
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




G1 X88.752 Y88.102
G1 Z2.72
G1 E.3 F1800
; FEATURE: Bridge
; LINE_WIDTH: 0.441682
G1 F3000
M204 S6000
G1 X88.752 Y91.721 E.07135
G1 X89.168 Y91.721 E.0082
G1 X89.168 Y88.279 E.06785
G1 X89.584 Y88.279 E.0082
G1 X89.584 Y91.721 E.06785
G1 X90 Y91.721 E.0082
G1 X90 Y88.279 E.06785
G1 X90.416 Y88.279 E.0082
G1 X90.416 Y91.721 E.06785
G1 X90.832 Y91.721 E.0082
G1 X90.832 Y88.279 E.06785
G1 X91.248 Y88.279 E.0082
G1 X91.248 Y91.898 E.07135
M106 S73.95
; WIPE_START
G1 X91.248 Y89.898 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G17
G3 Z3.12 I-.797 J-.919 P1  F18000
G1 X88.5 Y92.281 Z3.12
G1 Z2.72
G1 E.3 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.663042
G1 F2400
M204 S6000
G1 X88.5 Y99.969 E.2322
; WIPE_START
G1 X88.5 Y97.969 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X88.5 Y90.336 Z3.12 F18000
G1 X88.5 Y87.719 Z3.12
G1 Z2.72
G1 E.3 F1800
G1 F2400
M204 S6000
G1 X88.5 Y80.031 E.2322
; CHANGE_LAYER
; Z_HEIGHT: 2.84
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F2400
G1 X88.5 Y82.031 E-.285
; WIPE_END
G1 E-.015 F1800
; layer num/total_layer_count: 29/102
; update layer progress
M73 L29
M991 S0 P28 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z3.12 I-1.217 J.031 P1  F18000
G1 X88.65 Y87.854 Z3.12
G1 Z2.84
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1486
M204 S6000
G1 X91.607 Y87.854 E.05945
G1 X91.607 Y92.146 E.08632
G1 X88.393 Y92.146 E.06461
G1 X88.393 Y87.854 E.08632
G1 X88.59 Y87.854 E.00395
M204 S10000
G1 X89.031 Y87.02 F18000
G1 F1486
M204 S6000
G1 X89.031 Y87.429 E.00823
G1 X91.749 Y87.429 E.05466
G1 X91.749 Y86.838 E.0119
G1 X91.942 Y86.789 E.00399
G1 X92.031 Y86.955 E.00379
G1 X92.031 Y93.045 E.12244
G1 X91.942 Y93.211 E.00379
G1 X91.749 Y93.162 E.00399
G1 X91.749 Y92.571 E.0119
G1 X89.031 Y92.571 E.05466
G1 X89.031 Y100.181 E.15302
G1 X87.969 Y100.181 E.02134
G1 X87.969 Y79.819 E.40942
G1 X89.031 Y79.819 E.02134
G1 X89.031 Y86.96 E.14358
M204 S250
G1 X89.481 Y87.02 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1486
M204 S5000
G1 X90.899 Y87.02 E.0265
G1 X91.299 Y87.02 E.00747
G1 X91.34 Y87.02 E.00077
G1 X91.34 Y85.61 E.02635
G1 X91.774 Y85.61 E.00811
G1 X92.44 Y86.853 E.02634
G1 X92.44 Y93.147 E.11762
G1 X91.774 Y94.39 E.02634
G1 X91.34 Y94.39 E.00811
G1 X91.34 Y92.98 E.02635
G1 X91.299 Y92.98 E.00077
G1 X90.899 Y92.98 E.00747
G1 X89.881 Y92.98 E.01902
G1 X89.481 Y92.98 E.00747
G1 X89.44 Y92.98 E.00077
G1 X89.44 Y100.59 E.1422
G1 X87.56 Y100.59 E.03513
G1 X87.56 Y79.41 E.39576
G1 X89.44 Y79.41 E.03513
G1 X89.44 Y87.001 E.14184
; WIPE_START
G1 F1800
M204 S6000
G1 X90.899 Y87.02 E-.20793
G1 X91.299 Y87.02 E-.057
G1 X91.34 Y87.02 E-.00584
G1 X91.34 Y86.92 E-.01423
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




G1 X88.5 Y87.641
G1 Z2.84
G1 E.3 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.663042
G1 F1486
M204 S6000
G1 X88.5 Y80.031 E.22986
; WIPE_START
G1 F2400
G1 X88.5 Y82.031 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X89.825 Y89.548 Z3.24 F18000
G1 X90 Y90.54 Z3.24
G1 Z2.84
G1 E.3 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.449132
G1 F1486
M204 S6000
G1 X90 Y89.52 E.02047
M204 S10000
G1 X90.409 Y89.46 F18000
; LINE_WIDTH: 0.419992
G1 F1486
M204 S6000
G1 X90.409 Y89.051 E.00764
G1 X89.591 Y89.051 E.01528
G1 X89.591 Y90.949 E.03546
G1 X90.409 Y90.949 E.01528
G1 X90.409 Y89.52 E.0267
M204 S10000
G1 X90.803 Y89.46 F18000
G1 F1486
M204 S6000
G1 X90.803 Y88.657 E.01501
G1 X89.197 Y88.657 E.03001
G1 X89.197 Y91.343 E.05019
G1 X90.803 Y91.343 E.03001
G1 X90.803 Y89.52 E.03406
M204 S10000
G1 X91.197 Y89.46 F18000
G1 F1486
M204 S6000
G1 X91.197 Y88.263 E.02237
G1 X88.803 Y88.263 E.04474
G1 X88.803 Y91.737 E.06492
G1 X91.197 Y91.737 E.04474
G1 X91.197 Y89.52 E.04143
; WIPE_START
G1 F4800
G1 X91.197 Y91.52 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G17
G3 Z3.24 I-.361 J-1.162 P1  F18000
G1 X88.5 Y92.359 Z3.24
G1 Z2.84
G1 E.3 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.663042
G1 F1486
M204 S6000
G1 X88.5 Y99.969 E.22986
; CHANGE_LAYER
; Z_HEIGHT: 2.96
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F2400
G1 X88.5 Y97.969 E-.285
; WIPE_END
G1 E-.015 F1800
; layer num/total_layer_count: 30/102
; update layer progress
M73 L30
M991 S0 P29 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z3.24 I1.217 J.013 P1  F18000
G1 X88.607 Y87.843 Z3.24
M73 P47 R12
G1 Z2.96
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1489
M204 S6000
G1 X91.607 Y87.843 E.06032
G1 X91.607 Y92.157 E.08672
G1 X88.393 Y92.157 E.06461
G1 X88.393 Y87.843 E.08672
G1 X88.547 Y87.843 E.00308
M204 S10000
G1 X89.031 Y87.01 F18000
G1 F1489
M204 S6000
G1 X89.031 Y87.419 E.00823
G1 X91.749 Y87.419 E.05466
G1 X91.749 Y86.838 E.01169
G1 X91.942 Y86.789 E.00399
G1 X92.031 Y86.955 E.00379
G1 X92.031 Y93.045 E.12244
G1 X91.942 Y93.211 E.00379
G1 X91.749 Y93.162 E.00399
G1 X91.749 Y92.581 E.01169
G1 X89.031 Y92.581 E.05466
G1 X89.031 Y100.181 E.15282
G1 X87.969 Y100.181 E.02134
G1 X87.969 Y79.819 E.40942
G1 X89.031 Y79.819 E.02134
G1 X89.031 Y86.95 E.14338
M204 S250
G1 X89.44 Y87.01 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1489
M204 S5000
G1 X91.34 Y87.01 E.0355
G1 X91.34 Y85.61 E.02616
G1 X91.774 Y85.61 E.00811
G1 X92.44 Y86.853 E.02634
G1 X92.44 Y93.147 E.11762
G1 X91.774 Y94.39 E.02634
G1 X91.34 Y94.39 E.00811
G1 X91.34 Y92.99 E.02616
G1 X89.44 Y92.99 E.0355
G1 X89.44 Y100.59 E.14201
G1 X87.56 Y100.59 E.03513
G1 X87.56 Y79.41 E.39576
G1 X89.44 Y79.41 E.03513
G1 X89.44 Y86.95 E.14089
; WIPE_START
G1 F1800
M204 S6000
G1 X91.34 Y87.01 E-.27089
G1 X91.34 Y86.911 E-.01411
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




G1 X88.5 Y87.631
G1 Z2.96
G1 E.3 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.663042
G1 F1489
M204 S6000
G1 X88.5 Y80.031 E.22955
; WIPE_START
G1 F2400
G1 X88.5 Y82.031 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X89.824 Y89.548 Z3.36 F18000
G1 X90 Y90.55 Z3.36
G1 Z2.96
G1 E.3 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.449132
G1 F1489
M204 S6000
G1 X90 Y89.51 E.02087
M204 S10000
G1 X90.409 Y89.45 F18000
; LINE_WIDTH: 0.419992
G1 F1489
M204 S6000
G1 X90.409 Y89.041 E.00764
G1 X89.591 Y89.041 E.01528
G1 X89.591 Y90.959 E.03583
G1 X90.409 Y90.959 E.01528
G1 X90.409 Y89.51 E.02707
M204 S10000
G1 X90.803 Y89.45 F18000
G1 F1489
M204 S6000
G1 X90.803 Y88.647 E.01501
G1 X89.197 Y88.647 E.03001
G1 X89.197 Y91.353 E.05056
G1 X90.803 Y91.353 E.03001
G1 X90.803 Y89.51 E.03444
M204 S10000
G1 X91.197 Y89.45 F18000
G1 F1489
M204 S6000
G1 X91.197 Y88.253 E.02237
G1 X88.803 Y88.253 E.04474
G1 X88.803 Y91.747 E.0653
G1 X91.197 Y91.747 E.04474
G1 X91.197 Y89.51 E.0418
; WIPE_START
G1 F4800
G1 X91.197 Y91.51 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G17
G3 Z3.36 I-.369 J-1.16 P1  F18000
G1 X88.5 Y92.369 Z3.36
G1 Z2.96
G1 E.3 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.663042
G1 F1489
M204 S6000
G1 X88.5 Y99.969 E.22955
; CHANGE_LAYER
; Z_HEIGHT: 3.08
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F2400
G1 X88.5 Y97.969 E-.285
; WIPE_END
G1 E-.015 F1800
; layer num/total_layer_count: 31/102
; update layer progress
M73 L31
M991 S0 P30 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z3.36 I1.217 J.013 P1  F18000
G1 X88.607 Y87.843 Z3.36
G1 Z3.08
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1489
M204 S6000
G1 X91.607 Y87.843 E.06032
G1 X91.607 Y92.157 E.08672
G1 X88.393 Y92.157 E.06461
G1 X88.393 Y87.843 E.08672
G1 X88.547 Y87.843 E.00308
M204 S10000
G1 X89.031 Y87.01 F18000
G1 F1489
M204 S6000
G1 X89.031 Y87.419 E.00823
G1 X91.749 Y87.419 E.05466
G1 X91.749 Y86.838 E.01169
G1 X91.942 Y86.789 E.00399
G1 X92.031 Y86.955 E.00379
G1 X92.031 Y93.045 E.12244
G1 X91.942 Y93.211 E.00379
G1 X91.749 Y93.162 E.00399
G1 X91.749 Y92.581 E.01169
G1 X89.031 Y92.581 E.05466
G1 X89.031 Y100.181 E.15282
G1 X87.969 Y100.181 E.02134
G1 X87.969 Y79.819 E.40942
G1 X89.031 Y79.819 E.02134
G1 X89.031 Y86.95 E.14338
M204 S250
G1 X89.44 Y87.01 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1489
M204 S5000
G1 X91.34 Y87.01 E.0355
G1 X91.34 Y85.61 E.02616
G1 X91.774 Y85.61 E.00811
G1 X92.44 Y86.853 E.02634
G1 X92.44 Y93.147 E.11762
G1 X91.774 Y94.39 E.02634
G1 X91.34 Y94.39 E.00811
G1 X91.34 Y92.99 E.02616
G1 X89.44 Y92.99 E.0355
G1 X89.44 Y100.59 E.14201
G1 X87.56 Y100.59 E.03513
G1 X87.56 Y79.41 E.39576
G1 X89.44 Y79.41 E.03513
M73 P48 R12
G1 X89.44 Y86.95 E.14089
; WIPE_START
G1 F1800
M204 S6000
G1 X91.34 Y87.01 E-.27089
G1 X91.34 Y86.911 E-.01411
; WIPE_END
M73 P48 R11
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




G1 X88.5 Y87.631
G1 Z3.08
G1 E.3 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.663042
G1 F1489
M204 S6000
G1 X88.5 Y80.031 E.22955
; WIPE_START
G1 F2400
G1 X88.5 Y82.031 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X89.824 Y89.548 Z3.48 F18000
G1 X90 Y90.55 Z3.48
G1 Z3.08
G1 E.3 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.449132
G1 F1489
M204 S6000
G1 X90 Y89.51 E.02087
M204 S10000
G1 X90.409 Y89.45 F18000
; LINE_WIDTH: 0.419992
G1 F1489
M204 S6000
G1 X90.409 Y89.041 E.00764
G1 X89.591 Y89.041 E.01528
G1 X89.591 Y90.959 E.03583
G1 X90.409 Y90.959 E.01528
G1 X90.409 Y89.51 E.02707
M204 S10000
G1 X90.803 Y89.45 F18000
G1 F1489
M204 S6000
G1 X90.803 Y88.647 E.01501
G1 X89.197 Y88.647 E.03001
G1 X89.197 Y91.353 E.05056
G1 X90.803 Y91.353 E.03001
G1 X90.803 Y89.51 E.03444
M204 S10000
G1 X91.197 Y89.45 F18000
G1 F1489
M204 S6000
G1 X91.197 Y88.253 E.02237
G1 X88.803 Y88.253 E.04474
G1 X88.803 Y91.747 E.0653
G1 X91.197 Y91.747 E.04474
G1 X91.197 Y89.51 E.0418
; WIPE_START
G1 F4800
G1 X91.197 Y91.51 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G17
G3 Z3.48 I-.369 J-1.16 P1  F18000
G1 X88.5 Y92.369 Z3.48
G1 Z3.08
G1 E.3 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.663042
G1 F1489
M204 S6000
G1 X88.5 Y99.969 E.22955
; CHANGE_LAYER
; Z_HEIGHT: 3.2
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F2400
G1 X88.5 Y97.969 E-.285
; WIPE_END
G1 E-.015 F1800
; layer num/total_layer_count: 32/102
; update layer progress
M73 L32
M991 S0 P31 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z3.48 I1.217 J.013 P1  F18000
G1 X88.607 Y87.843 Z3.48
G1 Z3.2
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1484
M204 S6000
G1 X91.607 Y87.843 E.06032
G1 X91.607 Y92.157 E.08672
G1 X88.393 Y92.157 E.06461
G1 X88.393 Y87.843 E.08672
G1 X88.547 Y87.843 E.00308
M204 S10000
G1 X89.031 Y87.01 F18000
G1 F1484
M204 S6000
G1 X89.031 Y87.419 E.00823
G1 X91.749 Y87.419 E.05466
G1 X91.749 Y86.838 E.01169
G1 X91.942 Y86.789 E.00399
G1 X92.031 Y86.955 E.00379
G1 X92.031 Y93.045 E.12244
G1 X91.942 Y93.211 E.00379
G1 X91.749 Y93.162 E.00399
G1 X91.749 Y92.581 E.01169
G1 X89.031 Y92.581 E.05466
G1 X89.031 Y100.181 E.15282
G1 X87.969 Y100.181 E.02134
G1 X87.969 Y79.819 E.40942
G1 X89.031 Y79.819 E.02134
G1 X89.031 Y86.95 E.14338
M204 S250
G1 X89.44 Y87.01 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1484
M204 S5000
G1 X91.34 Y87.01 E.0355
G1 X91.34 Y85.61 E.02616
G1 X91.774 Y85.61 E.00811
G1 X92.44 Y86.853 E.02634
G1 X92.44 Y93.147 E.11762
G1 X91.774 Y94.39 E.02634
G1 X91.34 Y94.39 E.00811
G1 X91.34 Y92.99 E.02616
G1 X89.44 Y92.99 E.0355
G1 X89.44 Y100.59 E.14201
G1 X87.56 Y100.59 E.03513
G1 X87.56 Y79.41 E.39576
G1 X89.44 Y79.41 E.03513
G1 X89.44 Y86.95 E.14089
; WIPE_START
G1 F1800
M204 S6000
G1 X91.34 Y87.01 E-.27089
G1 X91.34 Y86.911 E-.01411
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




G1 X88.5 Y87.631
G1 Z3.2
G1 E.3 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.663042
G1 F1484
M204 S6000
G1 X88.5 Y80.031 E.22955
; WIPE_START
G1 F2400
G1 X88.5 Y82.031 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X89.824 Y89.548 Z3.6 F18000
G1 X90 Y90.55 Z3.6
G1 Z3.2
G1 E.3 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.449132
G1 F1484
M204 S6000
G1 X90 Y89.51 E.02087
M204 S10000
G1 X90.409 Y89.45 F18000
; LINE_WIDTH: 0.419992
G1 F1484
M204 S6000
G1 X90.409 Y89.041 E.00764
G1 X89.591 Y89.041 E.01528
G1 X89.591 Y90.959 E.03583
G1 X90.409 Y90.959 E.01528
G1 X90.409 Y89.51 E.02707
M204 S10000
G1 X90.803 Y89.45 F18000
G1 F1484
M204 S6000
G1 X90.803 Y88.647 E.01501
G1 X89.197 Y88.647 E.03001
G1 X89.197 Y91.353 E.05056
G1 X90.803 Y91.353 E.03001
G1 X90.803 Y89.51 E.03444
M204 S10000
G1 X91.197 Y89.45 F18000
G1 F1484
M204 S6000
G1 X91.197 Y88.253 E.02237
G1 X88.803 Y88.253 E.04474
G1 X88.803 Y91.747 E.0653
G1 X91.197 Y91.747 E.04474
G1 X91.197 Y89.51 E.0418
; WIPE_START
G1 F4800
G1 X91.197 Y91.51 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X88.5 Y92.369 Z3.6 F18000
G1 Z3.2
G1 E.3 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.663042
G1 F1484
M204 S6000
G1 X88.5 Y99.969 E.22955
; CHANGE_LAYER
; Z_HEIGHT: 3.32
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F2400
G1 X88.5 Y97.969 E-.285
; WIPE_END
G1 E-.015 F1800
; layer num/total_layer_count: 33/102
; update layer progress
M73 L33
M991 S0 P32 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z3.6 I1.217 J.013 P1  F18000
M73 P49 R11
G1 X88.607 Y87.843 Z3.6
G1 Z3.32
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1484
M204 S6000
G1 X91.607 Y87.843 E.06032
G1 X91.607 Y92.157 E.08672
G1 X88.393 Y92.157 E.06461
G1 X88.393 Y87.843 E.08672
G1 X88.547 Y87.843 E.00308
M204 S10000
G1 X89.031 Y87.01 F18000
G1 F1484
M204 S6000
G1 X89.031 Y87.419 E.00823
G1 X91.749 Y87.419 E.05466
G1 X91.749 Y86.838 E.01169
G1 X91.942 Y86.789 E.00399
G1 X92.031 Y86.955 E.00379
G1 X92.031 Y93.045 E.12244
G1 X91.942 Y93.211 E.00379
G1 X91.749 Y93.162 E.00399
G1 X91.749 Y92.581 E.01169
G1 X89.031 Y92.581 E.05466
G1 X89.031 Y100.181 E.15282
G1 X87.969 Y100.181 E.02134
G1 X87.969 Y79.819 E.40942
G1 X89.031 Y79.819 E.02134
G1 X89.031 Y86.95 E.14338
M204 S250
G1 X89.44 Y87.01 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1484
M204 S5000
G1 X91.34 Y87.01 E.0355
G1 X91.34 Y85.61 E.02616
G1 X91.774 Y85.61 E.00811
G1 X92.44 Y86.853 E.02634
G1 X92.44 Y93.147 E.11762
G1 X91.774 Y94.39 E.02634
G1 X91.34 Y94.39 E.00811
G1 X91.34 Y92.99 E.02616
G1 X89.44 Y92.99 E.0355
G1 X89.44 Y100.59 E.14201
G1 X87.56 Y100.59 E.03513
G1 X87.56 Y79.41 E.39576
G1 X89.44 Y79.41 E.03513
G1 X89.44 Y86.95 E.14089
; WIPE_START
G1 F1800
M204 S6000
G1 X91.34 Y87.01 E-.27089
G1 X91.34 Y86.911 E-.01411
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




G1 X88.5 Y87.631
G1 Z3.32
G1 E.3 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.663042
G1 F1484
M204 S6000
G1 X88.5 Y80.031 E.22955
; WIPE_START
G1 F2400
G1 X88.5 Y82.031 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X89.824 Y89.548 Z3.72 F18000
G1 X90 Y90.55 Z3.72
G1 Z3.32
G1 E.3 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.449132
G1 F1484
M204 S6000
G1 X90 Y89.51 E.02087
M204 S10000
G1 X90.409 Y89.45 F18000
; LINE_WIDTH: 0.419992
G1 F1484
M204 S6000
G1 X90.409 Y89.041 E.00764
G1 X89.591 Y89.041 E.01528
G1 X89.591 Y90.959 E.03583
G1 X90.409 Y90.959 E.01528
G1 X90.409 Y89.51 E.02707
M204 S10000
G1 X90.803 Y89.45 F18000
G1 F1484
M204 S6000
G1 X90.803 Y88.647 E.01501
G1 X89.197 Y88.647 E.03001
G1 X89.197 Y91.353 E.05056
G1 X90.803 Y91.353 E.03001
G1 X90.803 Y89.51 E.03444
M204 S10000
G1 X91.197 Y89.45 F18000
G1 F1484
M204 S6000
G1 X91.197 Y88.253 E.02237
G1 X88.803 Y88.253 E.04474
G1 X88.803 Y91.747 E.0653
G1 X91.197 Y91.747 E.04474
G1 X91.197 Y89.51 E.0418
; WIPE_START
G1 F4800
G1 X91.197 Y91.51 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X88.5 Y92.369 Z3.72 F18000
G1 Z3.32
G1 E.3 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.663042
G1 F1484
M204 S6000
G1 X88.5 Y99.969 E.22955
; CHANGE_LAYER
; Z_HEIGHT: 3.44
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F2400
G1 X88.5 Y97.969 E-.285
; WIPE_END
G1 E-.015 F1800
; layer num/total_layer_count: 34/102
; update layer progress
M73 L34
M991 S0 P33 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z3.72 I1.217 J.013 P1  F18000
G1 X88.607 Y87.843 Z3.72
G1 Z3.44
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1484
M204 S6000
G1 X91.607 Y87.843 E.06032
G1 X91.607 Y92.157 E.08672
G1 X88.393 Y92.157 E.06461
G1 X88.393 Y87.843 E.08672
G1 X88.547 Y87.843 E.00308
M204 S10000
G1 X89.031 Y87.01 F18000
G1 F1484
M204 S6000
G1 X89.031 Y87.419 E.00823
G1 X91.749 Y87.419 E.05466
G1 X91.749 Y86.838 E.01169
G1 X91.942 Y86.789 E.00399
G1 X92.031 Y86.955 E.00379
G1 X92.031 Y93.045 E.12244
G1 X91.942 Y93.211 E.00379
G1 X91.749 Y93.162 E.00399
G1 X91.749 Y92.581 E.01169
G1 X89.031 Y92.581 E.05466
G1 X89.031 Y100.181 E.15282
G1 X87.969 Y100.181 E.02134
G1 X87.969 Y79.819 E.40942
G1 X89.031 Y79.819 E.02134
G1 X89.031 Y86.95 E.14338
M204 S250
G1 X89.44 Y87.01 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1484
M204 S5000
G1 X91.34 Y87.01 E.0355
G1 X91.34 Y85.61 E.02616
G1 X91.774 Y85.61 E.00811
G1 X92.44 Y86.853 E.02634
G1 X92.44 Y93.147 E.11762
G1 X91.774 Y94.39 E.02634
M73 P50 R11
G1 X91.34 Y94.39 E.00811
G1 X91.34 Y92.99 E.02616
G1 X89.44 Y92.99 E.0355
G1 X89.44 Y100.59 E.14201
G1 X87.56 Y100.59 E.03513
G1 X87.56 Y79.41 E.39576
G1 X89.44 Y79.41 E.03513
G1 X89.44 Y86.95 E.14089
; WIPE_START
G1 F1800
M204 S6000
G1 X91.34 Y87.01 E-.27089
G1 X91.34 Y86.911 E-.01411
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




G1 X88.5 Y87.631
G1 Z3.44
G1 E.3 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.663042
G1 F1484
M204 S6000
G1 X88.5 Y80.031 E.22955
; WIPE_START
G1 F2400
G1 X88.5 Y82.031 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X89.824 Y89.548 Z3.84 F18000
G1 X90 Y90.55 Z3.84
G1 Z3.44
G1 E.3 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.449132
G1 F1484
M204 S6000
G1 X90 Y89.51 E.02087
M204 S10000
G1 X90.409 Y89.45 F18000
; LINE_WIDTH: 0.419992
G1 F1484
M204 S6000
G1 X90.409 Y89.041 E.00764
G1 X89.591 Y89.041 E.01528
G1 X89.591 Y90.959 E.03583
G1 X90.409 Y90.959 E.01528
G1 X90.409 Y89.51 E.02707
M204 S10000
G1 X90.803 Y89.45 F18000
G1 F1484
M204 S6000
G1 X90.803 Y88.647 E.01501
G1 X89.197 Y88.647 E.03001
G1 X89.197 Y91.353 E.05056
G1 X90.803 Y91.353 E.03001
G1 X90.803 Y89.51 E.03444
M204 S10000
G1 X91.197 Y89.45 F18000
G1 F1484
M204 S6000
G1 X91.197 Y88.253 E.02237
G1 X88.803 Y88.253 E.04474
G1 X88.803 Y91.747 E.0653
G1 X91.197 Y91.747 E.04474
G1 X91.197 Y89.51 E.0418
; WIPE_START
G1 F4800
G1 X91.197 Y91.51 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X88.5 Y92.369 Z3.84 F18000
G1 Z3.44
G1 E.3 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.663042
G1 F1484
M204 S6000
G1 X88.5 Y99.969 E.22955
; CHANGE_LAYER
; Z_HEIGHT: 3.56
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F2400
G1 X88.5 Y97.969 E-.285
; WIPE_END
G1 E-.015 F1800
; layer num/total_layer_count: 35/102
; update layer progress
M73 L35
M991 S0 P34 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z3.84 I1.217 J.013 P1  F18000
G1 X88.607 Y87.843 Z3.84
G1 Z3.56
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1484
M204 S6000
G1 X91.607 Y87.843 E.06032
G1 X91.607 Y92.157 E.08672
G1 X88.393 Y92.157 E.06461
G1 X88.393 Y87.843 E.08672
G1 X88.547 Y87.843 E.00308
M204 S10000
G1 X89.031 Y87.01 F18000
G1 F1484
M204 S6000
G1 X89.031 Y87.419 E.00823
G1 X91.749 Y87.419 E.05466
G1 X91.749 Y86.838 E.01169
G1 X91.942 Y86.789 E.00399
G1 X92.031 Y86.955 E.00379
G1 X92.031 Y93.045 E.12244
G1 X91.942 Y93.211 E.00379
G1 X91.749 Y93.162 E.00399
G1 X91.749 Y92.581 E.01169
G1 X89.031 Y92.581 E.05466
G1 X89.031 Y100.181 E.15282
G1 X87.969 Y100.181 E.02134
G1 X87.969 Y79.819 E.40942
G1 X89.031 Y79.819 E.02134
G1 X89.031 Y86.95 E.14338
M204 S250
G1 X89.44 Y87.01 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1484
M204 S5000
G1 X91.34 Y87.01 E.0355
G1 X91.34 Y85.61 E.02616
G1 X91.774 Y85.61 E.00811
G1 X92.44 Y86.853 E.02634
G1 X92.44 Y93.147 E.11762
G1 X91.774 Y94.39 E.02634
G1 X91.34 Y94.39 E.00811
G1 X91.34 Y92.99 E.02616
G1 X89.44 Y92.99 E.0355
G1 X89.44 Y100.59 E.14201
G1 X87.56 Y100.59 E.03513
G1 X87.56 Y79.41 E.39576
G1 X89.44 Y79.41 E.03513
G1 X89.44 Y86.95 E.14089
; WIPE_START
G1 F1800
M204 S6000
G1 X91.34 Y87.01 E-.27089
G1 X91.34 Y86.911 E-.01411
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




G1 X88.5 Y87.631
G1 Z3.56
G1 E.3 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.663042
G1 F1484
M204 S6000
G1 X88.5 Y80.031 E.22955
; WIPE_START
G1 F2400
G1 X88.5 Y82.031 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X89.824 Y89.548 Z3.96 F18000
G1 X90 Y90.55 Z3.96
G1 Z3.56
G1 E.3 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.449132
G1 F1484
M204 S6000
G1 X90 Y89.51 E.02087
M204 S10000
G1 X90.409 Y89.45 F18000
; LINE_WIDTH: 0.419992
G1 F1484
M204 S6000
G1 X90.409 Y89.041 E.00764
G1 X89.591 Y89.041 E.01528
G1 X89.591 Y90.959 E.03583
G1 X90.409 Y90.959 E.01528
G1 X90.409 Y89.51 E.02707
M204 S10000
G1 X90.803 Y89.45 F18000
G1 F1484
M204 S6000
G1 X90.803 Y88.647 E.01501
G1 X89.197 Y88.647 E.03001
G1 X89.197 Y91.353 E.05056
G1 X90.803 Y91.353 E.03001
G1 X90.803 Y89.51 E.03444
M204 S10000
G1 X91.197 Y89.45 F18000
M73 P51 R11
G1 F1484
M204 S6000
G1 X91.197 Y88.253 E.02237
G1 X88.803 Y88.253 E.04474
G1 X88.803 Y91.747 E.0653
G1 X91.197 Y91.747 E.04474
G1 X91.197 Y89.51 E.0418
; WIPE_START
G1 F4800
G1 X91.197 Y91.51 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X88.5 Y92.369 Z3.96 F18000
G1 Z3.56
G1 E.3 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.663042
G1 F1484
M204 S6000
G1 X88.5 Y99.969 E.22955
; CHANGE_LAYER
; Z_HEIGHT: 3.68
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F2400
G1 X88.5 Y97.969 E-.285
; WIPE_END
G1 E-.015 F1800
; layer num/total_layer_count: 36/102
; update layer progress
M73 L36
M991 S0 P35 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z3.96 I1.217 J.013 P1  F18000
G1 X88.607 Y87.843 Z3.96
G1 Z3.68
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1484
M204 S6000
G1 X91.607 Y87.843 E.06032
G1 X91.607 Y92.157 E.08672
G1 X88.393 Y92.157 E.06461
G1 X88.393 Y87.843 E.08672
G1 X88.547 Y87.843 E.00308
M204 S10000
G1 X89.031 Y87.01 F18000
G1 F1484
M204 S6000
G1 X89.031 Y87.419 E.00823
G1 X91.749 Y87.419 E.05466
G1 X91.749 Y86.838 E.01169
G1 X91.942 Y86.789 E.00399
G1 X92.031 Y86.955 E.00379
G1 X92.031 Y93.045 E.12244
G1 X91.942 Y93.211 E.00379
G1 X91.749 Y93.162 E.00399
G1 X91.749 Y92.581 E.01169
G1 X89.031 Y92.581 E.05466
G1 X89.031 Y100.181 E.15282
G1 X87.969 Y100.181 E.02134
G1 X87.969 Y79.819 E.40942
G1 X89.031 Y79.819 E.02134
G1 X89.031 Y86.95 E.14338
M204 S250
G1 X89.44 Y87.01 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1484
M204 S5000
G1 X91.34 Y87.01 E.0355
G1 X91.34 Y85.61 E.02616
G1 X91.774 Y85.61 E.00811
G1 X92.44 Y86.853 E.02634
G1 X92.44 Y93.147 E.11762
G1 X91.774 Y94.39 E.02634
G1 X91.34 Y94.39 E.00811
G1 X91.34 Y92.99 E.02616
G1 X89.44 Y92.99 E.0355
G1 X89.44 Y100.59 E.14201
G1 X87.56 Y100.59 E.03513
G1 X87.56 Y79.41 E.39576
G1 X89.44 Y79.41 E.03513
G1 X89.44 Y86.95 E.14089
; WIPE_START
G1 F1800
M204 S6000
G1 X91.34 Y87.01 E-.27089
G1 X91.34 Y86.911 E-.01411
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




G1 X88.5 Y87.631
G1 Z3.68
G1 E.3 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.663042
G1 F1484
M204 S6000
G1 X88.5 Y80.031 E.22955
; WIPE_START
G1 F2400
G1 X88.5 Y82.031 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X89.824 Y89.548 Z4.08 F18000
G1 X90 Y90.55 Z4.08
G1 Z3.68
G1 E.3 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.449132
G1 F1484
M204 S6000
G1 X90 Y89.51 E.02087
M204 S10000
G1 X90.409 Y89.45 F18000
; LINE_WIDTH: 0.419992
G1 F1484
M204 S6000
G1 X90.409 Y89.041 E.00764
G1 X89.591 Y89.041 E.01528
G1 X89.591 Y90.959 E.03583
G1 X90.409 Y90.959 E.01528
G1 X90.409 Y89.51 E.02707
M204 S10000
G1 X90.803 Y89.45 F18000
G1 F1484
M204 S6000
G1 X90.803 Y88.647 E.01501
G1 X89.197 Y88.647 E.03001
G1 X89.197 Y91.353 E.05056
G1 X90.803 Y91.353 E.03001
G1 X90.803 Y89.51 E.03444
M204 S10000
G1 X91.197 Y89.45 F18000
G1 F1484
M204 S6000
G1 X91.197 Y88.253 E.02237
G1 X88.803 Y88.253 E.04474
G1 X88.803 Y91.747 E.0653
G1 X91.197 Y91.747 E.04474
G1 X91.197 Y89.51 E.0418
; WIPE_START
G1 F4800
G1 X91.197 Y91.51 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X88.5 Y92.369 Z4.08 F18000
G1 Z3.68
G1 E.3 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.663042
G1 F1484
M204 S6000
G1 X88.5 Y99.969 E.22955
; CHANGE_LAYER
; Z_HEIGHT: 3.8
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F2400
G1 X88.5 Y97.969 E-.285
; WIPE_END
G1 E-.015 F1800
; layer num/total_layer_count: 37/102
; update layer progress
M73 L37
M991 S0 P36 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z4.08 I1.217 J.013 P1  F18000
G1 X88.607 Y87.843 Z4.08
G1 Z3.8
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1484
M204 S6000
G1 X91.607 Y87.843 E.06032
G1 X91.607 Y92.157 E.08672
G1 X88.393 Y92.157 E.06461
G1 X88.393 Y87.843 E.08672
G1 X88.547 Y87.843 E.00308
M204 S10000
G1 X89.031 Y87.01 F18000
G1 F1484
M204 S6000
G1 X89.031 Y87.419 E.00823
G1 X91.749 Y87.419 E.05466
G1 X91.749 Y86.838 E.01169
G1 X91.942 Y86.789 E.00399
G1 X92.031 Y86.955 E.00379
G1 X92.031 Y93.045 E.12244
G1 X91.942 Y93.211 E.00379
G1 X91.749 Y93.162 E.00399
G1 X91.749 Y92.581 E.01169
G1 X89.031 Y92.581 E.05466
G1 X89.031 Y100.181 E.15282
G1 X87.969 Y100.181 E.02134
G1 X87.969 Y79.819 E.40942
G1 X89.031 Y79.819 E.02134
G1 X89.031 Y86.95 E.14338
M204 S250
G1 X89.44 Y87.01 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1484
M204 S5000
G1 X91.34 Y87.01 E.0355
G1 X91.34 Y85.61 E.02616
G1 X91.774 Y85.61 E.00811
G1 X92.44 Y86.853 E.02634
G1 X92.44 Y93.147 E.11762
M73 P52 R11
G1 X91.774 Y94.39 E.02634
G1 X91.34 Y94.39 E.00811
G1 X91.34 Y92.99 E.02616
G1 X89.44 Y92.99 E.0355
G1 X89.44 Y100.59 E.14201
G1 X87.56 Y100.59 E.03513
G1 X87.56 Y79.41 E.39576
G1 X89.44 Y79.41 E.03513
G1 X89.44 Y86.95 E.14089
; WIPE_START
G1 F1800
M204 S6000
G1 X91.34 Y87.01 E-.27089
G1 X91.34 Y86.911 E-.01411
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




G1 X88.5 Y87.631
G1 Z3.8
G1 E.3 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.663042
G1 F1484
M204 S6000
G1 X88.5 Y80.031 E.22955
; WIPE_START
G1 F2400
G1 X88.5 Y82.031 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X89.824 Y89.548 Z4.2 F18000
G1 X90 Y90.55 Z4.2
G1 Z3.8
G1 E.3 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.449132
G1 F1484
M204 S6000
G1 X90 Y89.51 E.02087
M204 S10000
G1 X90.409 Y89.45 F18000
; LINE_WIDTH: 0.419992
G1 F1484
M204 S6000
G1 X90.409 Y89.041 E.00764
G1 X89.591 Y89.041 E.01528
G1 X89.591 Y90.959 E.03583
G1 X90.409 Y90.959 E.01528
G1 X90.409 Y89.51 E.02707
M204 S10000
G1 X90.803 Y89.45 F18000
G1 F1484
M204 S6000
G1 X90.803 Y88.647 E.01501
G1 X89.197 Y88.647 E.03001
G1 X89.197 Y91.353 E.05056
G1 X90.803 Y91.353 E.03001
G1 X90.803 Y89.51 E.03444
M204 S10000
G1 X91.197 Y89.45 F18000
G1 F1484
M204 S6000
G1 X91.197 Y88.253 E.02237
G1 X88.803 Y88.253 E.04474
G1 X88.803 Y91.747 E.0653
G1 X91.197 Y91.747 E.04474
G1 X91.197 Y89.51 E.0418
; WIPE_START
G1 F4800
M73 P52 R10
G1 X91.197 Y91.51 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X88.5 Y92.369 Z4.2 F18000
G1 Z3.8
G1 E.3 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.663042
G1 F1484
M204 S6000
G1 X88.5 Y99.969 E.22955
; CHANGE_LAYER
; Z_HEIGHT: 3.92
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F2400
G1 X88.5 Y97.969 E-.285
; WIPE_END
G1 E-.015 F1800
; layer num/total_layer_count: 38/102
; update layer progress
M73 L38
M991 S0 P37 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z4.2 I1.217 J.013 P1  F18000
G1 X88.607 Y87.843 Z4.2
G1 Z3.92
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1484
M204 S6000
G1 X91.607 Y87.843 E.06032
G1 X91.607 Y92.157 E.08672
G1 X88.393 Y92.157 E.06461
G1 X88.393 Y87.843 E.08672
G1 X88.547 Y87.843 E.00308
M204 S10000
G1 X89.031 Y87.01 F18000
G1 F1484
M204 S6000
G1 X89.031 Y87.419 E.00823
G1 X91.749 Y87.419 E.05466
G1 X91.749 Y86.838 E.01169
G1 X91.942 Y86.789 E.00399
G1 X92.031 Y86.955 E.00379
G1 X92.031 Y93.045 E.12244
G1 X91.942 Y93.211 E.00379
G1 X91.749 Y93.162 E.00399
G1 X91.749 Y92.581 E.01169
G1 X89.031 Y92.581 E.05466
G1 X89.031 Y100.181 E.15282
G1 X87.969 Y100.181 E.02134
G1 X87.969 Y79.819 E.40942
G1 X89.031 Y79.819 E.02134
G1 X89.031 Y86.95 E.14338
M204 S250
G1 X89.44 Y87.01 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1484
M204 S5000
G1 X91.34 Y87.01 E.0355
G1 X91.34 Y85.61 E.02616
G1 X91.774 Y85.61 E.00811
G1 X92.44 Y86.853 E.02634
G1 X92.44 Y93.147 E.11762
G1 X91.774 Y94.39 E.02634
G1 X91.34 Y94.39 E.00811
G1 X91.34 Y92.99 E.02616
G1 X89.44 Y92.99 E.0355
G1 X89.44 Y100.59 E.14201
G1 X87.56 Y100.59 E.03513
G1 X87.56 Y79.41 E.39576
G1 X89.44 Y79.41 E.03513
G1 X89.44 Y86.95 E.14089
; WIPE_START
G1 F1800
M204 S6000
G1 X91.34 Y87.01 E-.27089
G1 X91.34 Y86.911 E-.01411
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




G1 X88.5 Y87.631
G1 Z3.92
G1 E.3 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.663042
G1 F1484
M204 S6000
G1 X88.5 Y80.031 E.22955
; WIPE_START
M73 P53 R10
G1 F2400
G1 X88.5 Y82.031 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X89.824 Y89.548 Z4.32 F18000
G1 X90 Y90.55 Z4.32
G1 Z3.92
G1 E.3 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.449132
G1 F1484
M204 S6000
G1 X90 Y89.51 E.02087
M204 S10000
G1 X90.409 Y89.45 F18000
; LINE_WIDTH: 0.419992
G1 F1484
M204 S6000
G1 X90.409 Y89.041 E.00764
G1 X89.591 Y89.041 E.01528
G1 X89.591 Y90.959 E.03583
G1 X90.409 Y90.959 E.01528
G1 X90.409 Y89.51 E.02707
M204 S10000
G1 X90.803 Y89.45 F18000
G1 F1484
M204 S6000
G1 X90.803 Y88.647 E.01501
G1 X89.197 Y88.647 E.03001
G1 X89.197 Y91.353 E.05056
G1 X90.803 Y91.353 E.03001
G1 X90.803 Y89.51 E.03444
M204 S10000
G1 X91.197 Y89.45 F18000
G1 F1484
M204 S6000
G1 X91.197 Y88.253 E.02237
G1 X88.803 Y88.253 E.04474
G1 X88.803 Y91.747 E.0653
G1 X91.197 Y91.747 E.04474
G1 X91.197 Y89.51 E.0418
; WIPE_START
G1 F4800
G1 X91.197 Y91.51 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X88.5 Y92.369 Z4.32 F18000
G1 Z3.92
G1 E.3 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.663042
G1 F1484
M204 S6000
G1 X88.5 Y99.969 E.22955
; CHANGE_LAYER
; Z_HEIGHT: 4.04
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F2400
G1 X88.5 Y97.969 E-.285
; WIPE_END
G1 E-.015 F1800
; layer num/total_layer_count: 39/102
; update layer progress
M73 L39
M991 S0 P38 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z4.32 I1.217 J.013 P1  F18000
G1 X88.607 Y87.843 Z4.32
G1 Z4.04
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1484
M204 S6000
G1 X91.607 Y87.843 E.06032
G1 X91.607 Y92.157 E.08672
G1 X88.393 Y92.157 E.06461
G1 X88.393 Y87.843 E.08672
G1 X88.547 Y87.843 E.00308
M204 S10000
G1 X89.031 Y87.01 F18000
G1 F1484
M204 S6000
G1 X89.031 Y87.419 E.00823
G1 X91.749 Y87.419 E.05466
G1 X91.749 Y86.838 E.01169
G1 X91.942 Y86.789 E.00399
G1 X92.031 Y86.955 E.00379
G1 X92.031 Y93.045 E.12244
G1 X91.942 Y93.211 E.00379
G1 X91.749 Y93.162 E.00399
G1 X91.749 Y92.581 E.01169
G1 X89.031 Y92.581 E.05466
G1 X89.031 Y100.181 E.15282
G1 X87.969 Y100.181 E.02134
G1 X87.969 Y79.819 E.40942
G1 X89.031 Y79.819 E.02134
G1 X89.031 Y86.95 E.14338
M204 S250
G1 X89.44 Y87.01 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1484
M204 S5000
G1 X91.34 Y87.01 E.0355
G1 X91.34 Y85.61 E.02616
G1 X91.774 Y85.61 E.00811
G1 X92.44 Y86.853 E.02634
G1 X92.44 Y93.147 E.11762
G1 X91.774 Y94.39 E.02634
G1 X91.34 Y94.39 E.00811
G1 X91.34 Y92.99 E.02616
G1 X89.44 Y92.99 E.0355
G1 X89.44 Y100.59 E.14201
G1 X87.56 Y100.59 E.03513
G1 X87.56 Y79.41 E.39576
G1 X89.44 Y79.41 E.03513
G1 X89.44 Y86.95 E.14089
; WIPE_START
G1 F1800
M204 S6000
G1 X91.34 Y87.01 E-.27089
G1 X91.34 Y86.911 E-.01411
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




G1 X88.5 Y87.631
G1 Z4.04
G1 E.3 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.663042
G1 F1484
M204 S6000
G1 X88.5 Y80.031 E.22955
; WIPE_START
G1 F2400
G1 X88.5 Y82.031 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X89.824 Y89.548 Z4.44 F18000
G1 X90 Y90.55 Z4.44
G1 Z4.04
G1 E.3 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.449132
G1 F1484
M204 S6000
G1 X90 Y89.51 E.02087
M204 S10000
G1 X90.409 Y89.45 F18000
; LINE_WIDTH: 0.419992
G1 F1484
M204 S6000
G1 X90.409 Y89.041 E.00764
G1 X89.591 Y89.041 E.01528
G1 X89.591 Y90.959 E.03583
G1 X90.409 Y90.959 E.01528
G1 X90.409 Y89.51 E.02707
M204 S10000
G1 X90.803 Y89.45 F18000
G1 F1484
M204 S6000
G1 X90.803 Y88.647 E.01501
G1 X89.197 Y88.647 E.03001
G1 X89.197 Y91.353 E.05056
G1 X90.803 Y91.353 E.03001
G1 X90.803 Y89.51 E.03444
M204 S10000
G1 X91.197 Y89.45 F18000
G1 F1484
M204 S6000
G1 X91.197 Y88.253 E.02237
G1 X88.803 Y88.253 E.04474
G1 X88.803 Y91.747 E.0653
G1 X91.197 Y91.747 E.04474
G1 X91.197 Y89.51 E.0418
; WIPE_START
G1 F4800
G1 X91.197 Y91.51 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X88.5 Y92.369 Z4.44 F18000
G1 Z4.04
G1 E.3 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.663042
G1 F1484
M204 S6000
G1 X88.5 Y99.969 E.22955
; CHANGE_LAYER
; Z_HEIGHT: 4.16
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F2400
G1 X88.5 Y97.969 E-.285
; WIPE_END
G1 E-.015 F1800
; layer num/total_layer_count: 40/102
; update layer progress
M73 L40
M991 S0 P39 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z4.44 I1.217 J.013 P1  F18000
G1 X88.607 Y87.843 Z4.44
G1 Z4.16
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1484
M204 S6000
G1 X91.607 Y87.843 E.06032
G1 X91.607 Y92.157 E.08672
G1 X88.393 Y92.157 E.06461
G1 X88.393 Y87.843 E.08672
G1 X88.547 Y87.843 E.00308
M204 S10000
G1 X89.031 Y87.01 F18000
G1 F1484
M204 S6000
G1 X89.031 Y87.419 E.00823
G1 X91.749 Y87.419 E.05466
G1 X91.749 Y86.838 E.01169
G1 X91.942 Y86.789 E.00399
G1 X92.031 Y86.955 E.00379
G1 X92.031 Y93.045 E.12244
G1 X91.942 Y93.211 E.00379
G1 X91.749 Y93.162 E.00399
G1 X91.749 Y92.581 E.01169
G1 X89.031 Y92.581 E.05466
G1 X89.031 Y100.181 E.15282
G1 X87.969 Y100.181 E.02134
G1 X87.969 Y79.819 E.40942
G1 X89.031 Y79.819 E.02134
G1 X89.031 Y86.95 E.14338
M204 S250
G1 X89.44 Y87.01 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1484
M204 S5000
M73 P54 R10
G1 X91.34 Y87.01 E.0355
G1 X91.34 Y85.61 E.02616
G1 X91.774 Y85.61 E.00811
G1 X92.44 Y86.853 E.02634
G1 X92.44 Y93.147 E.11762
G1 X91.774 Y94.39 E.02634
G1 X91.34 Y94.39 E.00811
G1 X91.34 Y92.99 E.02616
G1 X89.44 Y92.99 E.0355
G1 X89.44 Y100.59 E.14201
G1 X87.56 Y100.59 E.03513
G1 X87.56 Y79.41 E.39576
G1 X89.44 Y79.41 E.03513
G1 X89.44 Y86.95 E.14089
; WIPE_START
G1 F1800
M204 S6000
G1 X91.34 Y87.01 E-.27089
G1 X91.34 Y86.911 E-.01411
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




G1 X88.5 Y87.631
G1 Z4.16
G1 E.3 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.663042
G1 F1484
M204 S6000
G1 X88.5 Y80.031 E.22955
; WIPE_START
G1 F2400
G1 X88.5 Y82.031 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X89.824 Y89.548 Z4.56 F18000
G1 X90 Y90.55 Z4.56
G1 Z4.16
G1 E.3 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.449132
G1 F1484
M204 S6000
G1 X90 Y89.51 E.02087
M204 S10000
G1 X90.409 Y89.45 F18000
; LINE_WIDTH: 0.419992
G1 F1484
M204 S6000
G1 X90.409 Y89.041 E.00764
G1 X89.591 Y89.041 E.01528
G1 X89.591 Y90.959 E.03583
G1 X90.409 Y90.959 E.01528
G1 X90.409 Y89.51 E.02707
M204 S10000
G1 X90.803 Y89.45 F18000
G1 F1484
M204 S6000
G1 X90.803 Y88.647 E.01501
G1 X89.197 Y88.647 E.03001
G1 X89.197 Y91.353 E.05056
G1 X90.803 Y91.353 E.03001
G1 X90.803 Y89.51 E.03444
M204 S10000
G1 X91.197 Y89.45 F18000
G1 F1484
M204 S6000
G1 X91.197 Y88.253 E.02237
G1 X88.803 Y88.253 E.04474
G1 X88.803 Y91.747 E.0653
G1 X91.197 Y91.747 E.04474
G1 X91.197 Y89.51 E.0418
; WIPE_START
G1 F4800
G1 X91.197 Y91.51 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X88.5 Y92.369 Z4.56 F18000
G1 Z4.16
G1 E.3 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.663042
G1 F1484
M204 S6000
G1 X88.5 Y99.969 E.22955
; CHANGE_LAYER
; Z_HEIGHT: 4.28
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F2400
G1 X88.5 Y97.969 E-.285
; WIPE_END
G1 E-.015 F1800
; layer num/total_layer_count: 41/102
; update layer progress
M73 L41
M991 S0 P40 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z4.56 I1.217 J.013 P1  F18000
G1 X88.607 Y87.843 Z4.56
G1 Z4.28
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1484
M204 S6000
G1 X91.607 Y87.843 E.06032
G1 X91.607 Y92.157 E.08672
G1 X88.393 Y92.157 E.06461
G1 X88.393 Y87.843 E.08672
G1 X88.547 Y87.843 E.00308
M204 S10000
G1 X89.031 Y87.01 F18000
G1 F1484
M204 S6000
G1 X89.031 Y87.419 E.00823
G1 X91.749 Y87.419 E.05466
G1 X91.749 Y86.838 E.01169
G1 X91.942 Y86.789 E.00399
G1 X92.031 Y86.955 E.00379
G1 X92.031 Y93.045 E.12244
G1 X91.942 Y93.211 E.00379
G1 X91.749 Y93.162 E.00399
G1 X91.749 Y92.581 E.01169
G1 X89.031 Y92.581 E.05466
G1 X89.031 Y100.181 E.15282
G1 X87.969 Y100.181 E.02134
G1 X87.969 Y79.819 E.40942
G1 X89.031 Y79.819 E.02134
G1 X89.031 Y86.95 E.14338
M204 S250
G1 X89.44 Y87.01 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1484
M204 S5000
G1 X91.34 Y87.01 E.0355
G1 X91.34 Y85.61 E.02616
G1 X91.774 Y85.61 E.00811
G1 X92.44 Y86.853 E.02634
G1 X92.44 Y93.147 E.11762
G1 X91.774 Y94.39 E.02634
G1 X91.34 Y94.39 E.00811
G1 X91.34 Y92.99 E.02616
G1 X89.44 Y92.99 E.0355
G1 X89.44 Y100.59 E.14201
G1 X87.56 Y100.59 E.03513
G1 X87.56 Y79.41 E.39576
G1 X89.44 Y79.41 E.03513
G1 X89.44 Y86.95 E.14089
; WIPE_START
G1 F1800
M204 S6000
G1 X91.34 Y87.01 E-.27089
G1 X91.34 Y86.911 E-.01411
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




G1 X88.5 Y87.631
G1 Z4.28
G1 E.3 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.663042
G1 F1484
M204 S6000
G1 X88.5 Y80.031 E.22955
; WIPE_START
G1 F2400
M73 P55 R10
G1 X88.5 Y82.031 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X89.824 Y89.548 Z4.68 F18000
G1 X90 Y90.55 Z4.68
G1 Z4.28
G1 E.3 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.449132
G1 F1484
M204 S6000
G1 X90 Y89.51 E.02087
M204 S10000
G1 X90.409 Y89.45 F18000
; LINE_WIDTH: 0.419992
G1 F1484
M204 S6000
G1 X90.409 Y89.041 E.00764
G1 X89.591 Y89.041 E.01528
G1 X89.591 Y90.959 E.03583
G1 X90.409 Y90.959 E.01528
G1 X90.409 Y89.51 E.02707
M204 S10000
G1 X90.803 Y89.45 F18000
G1 F1484
M204 S6000
G1 X90.803 Y88.647 E.01501
G1 X89.197 Y88.647 E.03001
G1 X89.197 Y91.353 E.05056
G1 X90.803 Y91.353 E.03001
G1 X90.803 Y89.51 E.03444
M204 S10000
G1 X91.197 Y89.45 F18000
G1 F1484
M204 S6000
G1 X91.197 Y88.253 E.02237
G1 X88.803 Y88.253 E.04474
G1 X88.803 Y91.747 E.0653
G1 X91.197 Y91.747 E.04474
G1 X91.197 Y89.51 E.0418
; WIPE_START
G1 F4800
G1 X91.197 Y91.51 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X88.5 Y92.369 Z4.68 F18000
G1 Z4.28
G1 E.3 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.663042
G1 F1484
M204 S6000
G1 X88.5 Y99.969 E.22955
; CHANGE_LAYER
; Z_HEIGHT: 4.4
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F2400
G1 X88.5 Y97.969 E-.285
; WIPE_END
G1 E-.015 F1800
; layer num/total_layer_count: 42/102
; update layer progress
M73 L42
M991 S0 P41 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z4.68 I1.217 J.013 P1  F18000
G1 X88.607 Y87.843 Z4.68
G1 Z4.4
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1484
M204 S6000
G1 X91.607 Y87.843 E.06032
G1 X91.607 Y92.157 E.08672
G1 X88.393 Y92.157 E.06461
G1 X88.393 Y87.843 E.08672
G1 X88.547 Y87.843 E.00308
M204 S10000
G1 X89.031 Y87.01 F18000
G1 F1484
M204 S6000
G1 X89.031 Y87.419 E.00823
G1 X91.749 Y87.419 E.05466
G1 X91.749 Y86.838 E.01169
G1 X91.942 Y86.789 E.00399
G1 X92.031 Y86.955 E.00379
G1 X92.031 Y93.045 E.12244
G1 X91.942 Y93.211 E.00379
G1 X91.749 Y93.162 E.00399
G1 X91.749 Y92.581 E.01169
G1 X89.031 Y92.581 E.05466
G1 X89.031 Y100.181 E.15282
G1 X87.969 Y100.181 E.02134
G1 X87.969 Y79.819 E.40942
G1 X89.031 Y79.819 E.02134
G1 X89.031 Y86.95 E.14338
M204 S250
G1 X89.44 Y87.01 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1484
M204 S5000
G1 X91.34 Y87.01 E.0355
G1 X91.34 Y85.61 E.02616
G1 X91.774 Y85.61 E.00811
G1 X92.44 Y86.853 E.02634
G1 X92.44 Y93.147 E.11762
G1 X91.774 Y94.39 E.02634
G1 X91.34 Y94.39 E.00811
G1 X91.34 Y92.99 E.02616
G1 X89.44 Y92.99 E.0355
G1 X89.44 Y100.59 E.14201
G1 X87.56 Y100.59 E.03513
G1 X87.56 Y79.41 E.39576
G1 X89.44 Y79.41 E.03513
G1 X89.44 Y86.95 E.14089
; WIPE_START
G1 F1800
M204 S6000
G1 X91.34 Y87.01 E-.27089
G1 X91.34 Y86.911 E-.01411
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




G1 X88.5 Y87.631
G1 Z4.4
G1 E.3 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.663042
G1 F1484
M204 S6000
G1 X88.5 Y80.031 E.22955
; WIPE_START
G1 F2400
G1 X88.5 Y82.031 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X89.824 Y89.548 Z4.8 F18000
G1 X90 Y90.55 Z4.8
G1 Z4.4
G1 E.3 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.449132
G1 F1484
M204 S6000
G1 X90 Y89.51 E.02087
M204 S10000
G1 X90.409 Y89.45 F18000
; LINE_WIDTH: 0.419992
G1 F1484
M204 S6000
G1 X90.409 Y89.041 E.00764
G1 X89.591 Y89.041 E.01528
G1 X89.591 Y90.959 E.03583
G1 X90.409 Y90.959 E.01528
G1 X90.409 Y89.51 E.02707
M204 S10000
G1 X90.803 Y89.45 F18000
G1 F1484
M204 S6000
G1 X90.803 Y88.647 E.01501
G1 X89.197 Y88.647 E.03001
G1 X89.197 Y91.353 E.05056
G1 X90.803 Y91.353 E.03001
G1 X90.803 Y89.51 E.03444
M204 S10000
G1 X91.197 Y89.45 F18000
G1 F1484
M204 S6000
G1 X91.197 Y88.253 E.02237
G1 X88.803 Y88.253 E.04474
G1 X88.803 Y91.747 E.0653
G1 X91.197 Y91.747 E.04474
G1 X91.197 Y89.51 E.0418
; WIPE_START
G1 F4800
G1 X91.197 Y91.51 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X88.5 Y92.369 Z4.8 F18000
G1 Z4.4
G1 E.3 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.663042
G1 F1484
M204 S6000
G1 X88.5 Y99.969 E.22955
; CHANGE_LAYER
; Z_HEIGHT: 4.52
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F2400
G1 X88.5 Y97.969 E-.285
; WIPE_END
G1 E-.015 F1800
; layer num/total_layer_count: 43/102
; update layer progress
M73 L43
M991 S0 P42 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z4.8 I1.217 J.013 P1  F18000
G1 X88.607 Y87.843 Z4.8
G1 Z4.52
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1484
M204 S6000
G1 X91.607 Y87.843 E.06032
G1 X91.607 Y92.157 E.08672
G1 X88.393 Y92.157 E.06461
G1 X88.393 Y87.843 E.08672
G1 X88.547 Y87.843 E.00308
M204 S10000
G1 X89.031 Y87.01 F18000
M73 P56 R10
G1 F1484
M204 S6000
G1 X89.031 Y87.419 E.00823
G1 X91.749 Y87.419 E.05466
G1 X91.749 Y86.838 E.01169
G1 X91.942 Y86.789 E.00399
G1 X92.031 Y86.955 E.00379
G1 X92.031 Y93.045 E.12244
G1 X91.942 Y93.211 E.00379
G1 X91.749 Y93.162 E.00399
G1 X91.749 Y92.581 E.01169
G1 X89.031 Y92.581 E.05466
G1 X89.031 Y100.181 E.15282
G1 X87.969 Y100.181 E.02134
G1 X87.969 Y79.819 E.40942
G1 X89.031 Y79.819 E.02134
G1 X89.031 Y86.95 E.14338
M204 S250
G1 X89.44 Y87.01 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1484
M204 S5000
G1 X91.34 Y87.01 E.0355
G1 X91.34 Y85.61 E.02616
G1 X91.774 Y85.61 E.00811
G1 X92.44 Y86.853 E.02634
G1 X92.44 Y93.147 E.11762
G1 X91.774 Y94.39 E.02634
G1 X91.34 Y94.39 E.00811
G1 X91.34 Y92.99 E.02616
G1 X89.44 Y92.99 E.0355
G1 X89.44 Y100.59 E.14201
G1 X87.56 Y100.59 E.03513
G1 X87.56 Y79.41 E.39576
G1 X89.44 Y79.41 E.03513
G1 X89.44 Y86.95 E.14089
; WIPE_START
G1 F1800
M204 S6000
G1 X91.34 Y87.01 E-.27089
G1 X91.34 Y86.911 E-.01411
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




G1 X88.5 Y87.631
G1 Z4.52
G1 E.3 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.663042
G1 F1484
M204 S6000
G1 X88.5 Y80.031 E.22955
; WIPE_START
G1 F2400
G1 X88.5 Y82.031 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X89.824 Y89.548 Z4.92 F18000
G1 X90 Y90.55 Z4.92
G1 Z4.52
G1 E.3 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.449132
G1 F1484
M204 S6000
G1 X90 Y89.51 E.02087
M204 S10000
G1 X90.409 Y89.45 F18000
; LINE_WIDTH: 0.419992
G1 F1484
M204 S6000
G1 X90.409 Y89.041 E.00764
G1 X89.591 Y89.041 E.01528
G1 X89.591 Y90.959 E.03583
G1 X90.409 Y90.959 E.01528
G1 X90.409 Y89.51 E.02707
M204 S10000
G1 X90.803 Y89.45 F18000
G1 F1484
M204 S6000
G1 X90.803 Y88.647 E.01501
G1 X89.197 Y88.647 E.03001
G1 X89.197 Y91.353 E.05056
G1 X90.803 Y91.353 E.03001
G1 X90.803 Y89.51 E.03444
M204 S10000
G1 X91.197 Y89.45 F18000
G1 F1484
M204 S6000
G1 X91.197 Y88.253 E.02237
G1 X88.803 Y88.253 E.04474
G1 X88.803 Y91.747 E.0653
G1 X91.197 Y91.747 E.04474
G1 X91.197 Y89.51 E.0418
; WIPE_START
G1 F4800
G1 X91.197 Y91.51 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X88.5 Y92.369 Z4.92 F18000
G1 Z4.52
G1 E.3 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.663042
G1 F1484
M204 S6000
G1 X88.5 Y99.969 E.22955
; CHANGE_LAYER
; Z_HEIGHT: 4.64
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F2400
G1 X88.5 Y97.969 E-.285
; WIPE_END
G1 E-.015 F1800
; layer num/total_layer_count: 44/102
; update layer progress
M73 L44
M991 S0 P43 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z4.92 I1.217 J.013 P1  F18000
G1 X88.607 Y87.843 Z4.92
G1 Z4.64
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1484
M204 S6000
G1 X91.607 Y87.843 E.06032
G1 X91.607 Y92.157 E.08672
G1 X88.393 Y92.157 E.06461
G1 X88.393 Y87.843 E.08672
G1 X88.547 Y87.843 E.00308
M204 S10000
G1 X89.031 Y87.01 F18000
G1 F1484
M204 S6000
G1 X89.031 Y87.419 E.00823
G1 X91.749 Y87.419 E.05466
G1 X91.749 Y86.838 E.01169
G1 X91.942 Y86.789 E.00399
G1 X92.031 Y86.955 E.00379
G1 X92.031 Y93.045 E.12244
G1 X91.942 Y93.211 E.00379
G1 X91.749 Y93.162 E.00399
G1 X91.749 Y92.581 E.01169
G1 X89.031 Y92.581 E.05466
G1 X89.031 Y100.181 E.15282
G1 X87.969 Y100.181 E.02134
M73 P56 R9
G1 X87.969 Y79.819 E.40942
G1 X89.031 Y79.819 E.02134
G1 X89.031 Y86.95 E.14338
M204 S250
G1 X89.44 Y87.01 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1484
M204 S5000
G1 X91.34 Y87.01 E.0355
G1 X91.34 Y85.61 E.02616
G1 X91.774 Y85.61 E.00811
G1 X92.44 Y86.853 E.02634
G1 X92.44 Y93.147 E.11762
G1 X91.774 Y94.39 E.02634
G1 X91.34 Y94.39 E.00811
G1 X91.34 Y92.99 E.02616
G1 X89.44 Y92.99 E.0355
G1 X89.44 Y100.59 E.14201
G1 X87.56 Y100.59 E.03513
G1 X87.56 Y79.41 E.39576
G1 X89.44 Y79.41 E.03513
G1 X89.44 Y86.95 E.14089
; WIPE_START
G1 F1800
M204 S6000
G1 X91.34 Y87.01 E-.27089
G1 X91.34 Y86.911 E-.01411
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




G1 X88.5 Y87.631
G1 Z4.64
G1 E.3 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.663042
M73 P57 R9
G1 F1484
M204 S6000
G1 X88.5 Y80.031 E.22955
; WIPE_START
G1 F2400
G1 X88.5 Y82.031 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X89.824 Y89.548 Z5.04 F18000
G1 X90 Y90.55 Z5.04
G1 Z4.64
G1 E.3 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.449132
G1 F1484
M204 S6000
G1 X90 Y89.51 E.02087
M204 S10000
G1 X90.409 Y89.45 F18000
; LINE_WIDTH: 0.419992
G1 F1484
M204 S6000
G1 X90.409 Y89.041 E.00764
G1 X89.591 Y89.041 E.01528
G1 X89.591 Y90.959 E.03583
G1 X90.409 Y90.959 E.01528
G1 X90.409 Y89.51 E.02707
M204 S10000
G1 X90.803 Y89.45 F18000
G1 F1484
M204 S6000
G1 X90.803 Y88.647 E.01501
G1 X89.197 Y88.647 E.03001
G1 X89.197 Y91.353 E.05056
G1 X90.803 Y91.353 E.03001
G1 X90.803 Y89.51 E.03444
M204 S10000
G1 X91.197 Y89.45 F18000
G1 F1484
M204 S6000
G1 X91.197 Y88.253 E.02237
G1 X88.803 Y88.253 E.04474
G1 X88.803 Y91.747 E.0653
G1 X91.197 Y91.747 E.04474
G1 X91.197 Y89.51 E.0418
; WIPE_START
G1 F4800
G1 X91.197 Y91.51 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X88.5 Y92.369 Z5.04 F18000
G1 Z4.64
G1 E.3 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.663042
G1 F1484
M204 S6000
G1 X88.5 Y99.969 E.22955
; CHANGE_LAYER
; Z_HEIGHT: 4.76
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F2400
G1 X88.5 Y97.969 E-.285
; WIPE_END
G1 E-.015 F1800
; layer num/total_layer_count: 45/102
; update layer progress
M73 L45
M991 S0 P44 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z5.04 I1.217 J.013 P1  F18000
G1 X88.607 Y87.843 Z5.04
G1 Z4.76
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1484
M204 S6000
G1 X91.607 Y87.843 E.06032
G1 X91.607 Y92.157 E.08672
G1 X88.393 Y92.157 E.06461
G1 X88.393 Y87.843 E.08672
G1 X88.547 Y87.843 E.00308
M204 S10000
G1 X89.031 Y87.01 F18000
G1 F1484
M204 S6000
G1 X89.031 Y87.419 E.00823
G1 X91.749 Y87.419 E.05466
G1 X91.749 Y86.838 E.01169
G1 X91.942 Y86.789 E.00399
G1 X92.031 Y86.955 E.00379
G1 X92.031 Y93.045 E.12244
G1 X91.942 Y93.211 E.00379
G1 X91.749 Y93.162 E.00399
G1 X91.749 Y92.581 E.01169
G1 X89.031 Y92.581 E.05466
G1 X89.031 Y100.181 E.15282
G1 X87.969 Y100.181 E.02134
G1 X87.969 Y79.819 E.40942
G1 X89.031 Y79.819 E.02134
G1 X89.031 Y86.95 E.14338
M204 S250
G1 X89.44 Y87.01 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1484
M204 S5000
G1 X91.34 Y87.01 E.0355
G1 X91.34 Y85.61 E.02616
G1 X91.774 Y85.61 E.00811
G1 X92.44 Y86.853 E.02634
G1 X92.44 Y93.147 E.11762
G1 X91.774 Y94.39 E.02634
G1 X91.34 Y94.39 E.00811
G1 X91.34 Y92.99 E.02616
G1 X89.44 Y92.99 E.0355
G1 X89.44 Y100.59 E.14201
G1 X87.56 Y100.59 E.03513
G1 X87.56 Y79.41 E.39576
G1 X89.44 Y79.41 E.03513
G1 X89.44 Y86.95 E.14089
; WIPE_START
G1 F1800
M204 S6000
G1 X91.34 Y87.01 E-.27089
G1 X91.34 Y86.911 E-.01411
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




G1 X88.5 Y87.631
G1 Z4.76
G1 E.3 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.663042
G1 F1484
M204 S6000
G1 X88.5 Y80.031 E.22955
; WIPE_START
G1 F2400
G1 X88.5 Y82.031 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X89.824 Y89.548 Z5.16 F18000
G1 X90 Y90.55 Z5.16
G1 Z4.76
G1 E.3 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.449132
G1 F1484
M204 S6000
G1 X90 Y89.51 E.02087
M204 S10000
G1 X90.409 Y89.45 F18000
; LINE_WIDTH: 0.419992
G1 F1484
M204 S6000
G1 X90.409 Y89.041 E.00764
G1 X89.591 Y89.041 E.01528
G1 X89.591 Y90.959 E.03583
G1 X90.409 Y90.959 E.01528
G1 X90.409 Y89.51 E.02707
M204 S10000
G1 X90.803 Y89.45 F18000
G1 F1484
M204 S6000
G1 X90.803 Y88.647 E.01501
G1 X89.197 Y88.647 E.03001
G1 X89.197 Y91.353 E.05056
G1 X90.803 Y91.353 E.03001
G1 X90.803 Y89.51 E.03444
M204 S10000
G1 X91.197 Y89.45 F18000
G1 F1484
M204 S6000
G1 X91.197 Y88.253 E.02237
G1 X88.803 Y88.253 E.04474
M73 P58 R9
G1 X88.803 Y91.747 E.0653
G1 X91.197 Y91.747 E.04474
G1 X91.197 Y89.51 E.0418
; WIPE_START
G1 F4800
G1 X91.197 Y91.51 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X88.5 Y92.369 Z5.16 F18000
G1 Z4.76
G1 E.3 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.663042
G1 F1484
M204 S6000
G1 X88.5 Y99.969 E.22955
; CHANGE_LAYER
; Z_HEIGHT: 4.88
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F2400
G1 X88.5 Y97.969 E-.285
; WIPE_END
G1 E-.015 F1800
; layer num/total_layer_count: 46/102
; update layer progress
M73 L46
M991 S0 P45 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z5.16 I1.217 J.013 P1  F18000
G1 X88.607 Y87.843 Z5.16
G1 Z4.88
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1484
M204 S6000
G1 X91.607 Y87.843 E.06032
G1 X91.607 Y92.157 E.08672
G1 X88.393 Y92.157 E.06461
G1 X88.393 Y87.843 E.08672
G1 X88.547 Y87.843 E.00308
M204 S10000
G1 X89.031 Y87.01 F18000
G1 F1484
M204 S6000
G1 X89.031 Y87.419 E.00823
G1 X91.749 Y87.419 E.05466
G1 X91.749 Y86.838 E.01169
G1 X91.942 Y86.789 E.00399
G1 X92.031 Y86.955 E.00379
G1 X92.031 Y93.045 E.12244
G1 X91.942 Y93.211 E.00379
G1 X91.749 Y93.162 E.00399
G1 X91.749 Y92.581 E.01169
G1 X89.031 Y92.581 E.05466
G1 X89.031 Y100.181 E.15282
G1 X87.969 Y100.181 E.02134
G1 X87.969 Y79.819 E.40942
G1 X89.031 Y79.819 E.02134
G1 X89.031 Y86.95 E.14338
M204 S250
G1 X89.44 Y87.01 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1484
M204 S5000
G1 X91.34 Y87.01 E.0355
G1 X91.34 Y85.61 E.02616
G1 X91.774 Y85.61 E.00811
G1 X92.44 Y86.853 E.02634
G1 X92.44 Y93.147 E.11762
G1 X91.774 Y94.39 E.02634
G1 X91.34 Y94.39 E.00811
G1 X91.34 Y92.99 E.02616
G1 X89.44 Y92.99 E.0355
G1 X89.44 Y100.59 E.14201
G1 X87.56 Y100.59 E.03513
G1 X87.56 Y79.41 E.39576
G1 X89.44 Y79.41 E.03513
G1 X89.44 Y86.95 E.14089
; WIPE_START
G1 F1800
M204 S6000
G1 X91.34 Y87.01 E-.27089
G1 X91.34 Y86.911 E-.01411
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




G1 X88.5 Y87.631
G1 Z4.88
G1 E.3 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.663042
G1 F1484
M204 S6000
G1 X88.5 Y80.031 E.22955
; WIPE_START
G1 F2400
G1 X88.5 Y82.031 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X89.824 Y89.548 Z5.28 F18000
G1 X90 Y90.55 Z5.28
G1 Z4.88
G1 E.3 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.449132
G1 F1484
M204 S6000
G1 X90 Y89.51 E.02087
M204 S10000
G1 X90.409 Y89.45 F18000
; LINE_WIDTH: 0.419992
G1 F1484
M204 S6000
G1 X90.409 Y89.041 E.00764
G1 X89.591 Y89.041 E.01528
G1 X89.591 Y90.959 E.03583
G1 X90.409 Y90.959 E.01528
G1 X90.409 Y89.51 E.02707
M204 S10000
G1 X90.803 Y89.45 F18000
G1 F1484
M204 S6000
G1 X90.803 Y88.647 E.01501
G1 X89.197 Y88.647 E.03001
G1 X89.197 Y91.353 E.05056
G1 X90.803 Y91.353 E.03001
G1 X90.803 Y89.51 E.03444
M204 S10000
G1 X91.197 Y89.45 F18000
G1 F1484
M204 S6000
G1 X91.197 Y88.253 E.02237
G1 X88.803 Y88.253 E.04474
G1 X88.803 Y91.747 E.0653
G1 X91.197 Y91.747 E.04474
G1 X91.197 Y89.51 E.0418
; WIPE_START
G1 F4800
G1 X91.197 Y91.51 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X88.5 Y92.369 Z5.28 F18000
G1 Z4.88
G1 E.3 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.663042
G1 F1484
M204 S6000
G1 X88.5 Y99.969 E.22955
; CHANGE_LAYER
; Z_HEIGHT: 5
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F2400
G1 X88.5 Y97.969 E-.285
; WIPE_END
G1 E-.015 F1800
; layer num/total_layer_count: 47/102
; update layer progress
M73 L47
M991 S0 P46 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z5.28 I1.217 J.013 P1  F18000
G1 X88.607 Y87.843 Z5.28
G1 Z5
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1484
M204 S6000
G1 X91.607 Y87.843 E.06032
G1 X91.607 Y92.157 E.08672
G1 X88.393 Y92.157 E.06461
G1 X88.393 Y87.843 E.08672
G1 X88.547 Y87.843 E.00308
M204 S10000
G1 X89.031 Y87.01 F18000
G1 F1484
M204 S6000
G1 X89.031 Y87.419 E.00823
G1 X91.749 Y87.419 E.05466
G1 X91.749 Y86.838 E.01169
G1 X91.942 Y86.789 E.00399
G1 X92.031 Y86.955 E.00379
G1 X92.031 Y93.045 E.12244
G1 X91.942 Y93.211 E.00379
G1 X91.749 Y93.162 E.00399
G1 X91.749 Y92.581 E.01169
G1 X89.031 Y92.581 E.05466
G1 X89.031 Y100.181 E.15282
G1 X87.969 Y100.181 E.02134
G1 X87.969 Y79.819 E.40942
G1 X89.031 Y79.819 E.02134
G1 X89.031 Y86.95 E.14338
M204 S250
G1 X89.44 Y87.01 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1484
M204 S5000
G1 X91.34 Y87.01 E.0355
G1 X91.34 Y85.61 E.02616
G1 X91.774 Y85.61 E.00811
G1 X92.44 Y86.853 E.02634
G1 X92.44 Y93.147 E.11762
G1 X91.774 Y94.39 E.02634
G1 X91.34 Y94.39 E.00811
G1 X91.34 Y92.99 E.02616
G1 X89.44 Y92.99 E.0355
G1 X89.44 Y100.59 E.14201
G1 X87.56 Y100.59 E.03513
G1 X87.56 Y79.41 E.39576
G1 X89.44 Y79.41 E.03513
G1 X89.44 Y86.95 E.14089
; WIPE_START
G1 F1800
M204 S6000
G1 X91.34 Y87.01 E-.27089
M73 P59 R9
G1 X91.34 Y86.911 E-.01411
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




G1 X88.5 Y87.631
G1 Z5
G1 E.3 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.663042
G1 F1484
M204 S6000
G1 X88.5 Y80.031 E.22955
; WIPE_START
G1 F2400
G1 X88.5 Y82.031 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X89.824 Y89.548 Z5.4 F18000
G1 X90 Y90.55 Z5.4
G1 Z5
G1 E.3 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.449132
G1 F1484
M204 S6000
G1 X90 Y89.51 E.02087
M204 S10000
G1 X90.409 Y89.45 F18000
; LINE_WIDTH: 0.419992
G1 F1484
M204 S6000
G1 X90.409 Y89.041 E.00764
G1 X89.591 Y89.041 E.01528
G1 X89.591 Y90.959 E.03583
G1 X90.409 Y90.959 E.01528
G1 X90.409 Y89.51 E.02707
M204 S10000
G1 X90.803 Y89.45 F18000
G1 F1484
M204 S6000
G1 X90.803 Y88.647 E.01501
G1 X89.197 Y88.647 E.03001
G1 X89.197 Y91.353 E.05056
G1 X90.803 Y91.353 E.03001
G1 X90.803 Y89.51 E.03444
M204 S10000
G1 X91.197 Y89.45 F18000
G1 F1484
M204 S6000
G1 X91.197 Y88.253 E.02237
G1 X88.803 Y88.253 E.04474
G1 X88.803 Y91.747 E.0653
G1 X91.197 Y91.747 E.04474
G1 X91.197 Y89.51 E.0418
; WIPE_START
G1 F4800
G1 X91.197 Y91.51 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X88.5 Y92.369 Z5.4 F18000
G1 Z5
G1 E.3 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.663042
G1 F1484
M204 S6000
G1 X88.5 Y99.969 E.22955
; CHANGE_LAYER
; Z_HEIGHT: 5.12
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F2400
G1 X88.5 Y97.969 E-.285
; WIPE_END
G1 E-.015 F1800
; layer num/total_layer_count: 48/102
; update layer progress
M73 L48
M991 S0 P47 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z5.4 I1.217 J.013 P1  F18000
G1 X88.607 Y87.843 Z5.4
G1 Z5.12
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1484
M204 S6000
G1 X91.607 Y87.843 E.06032
G1 X91.607 Y92.157 E.08672
G1 X88.393 Y92.157 E.06461
G1 X88.393 Y87.843 E.08672
G1 X88.547 Y87.843 E.00308
M204 S10000
G1 X89.031 Y87.01 F18000
G1 F1484
M204 S6000
G1 X89.031 Y87.419 E.00823
G1 X91.749 Y87.419 E.05466
G1 X91.749 Y86.838 E.01169
G1 X91.942 Y86.789 E.00399
G1 X92.031 Y86.955 E.00379
G1 X92.031 Y93.045 E.12244
G1 X91.942 Y93.211 E.00379
G1 X91.749 Y93.162 E.00399
G1 X91.749 Y92.581 E.01169
G1 X89.031 Y92.581 E.05466
G1 X89.031 Y100.181 E.15282
G1 X87.969 Y100.181 E.02134
G1 X87.969 Y79.819 E.40942
G1 X89.031 Y79.819 E.02134
G1 X89.031 Y86.95 E.14338
M204 S250
G1 X89.44 Y87.01 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1484
M204 S5000
G1 X91.34 Y87.01 E.0355
G1 X91.34 Y85.61 E.02616
G1 X91.774 Y85.61 E.00811
G1 X92.44 Y86.853 E.02634
G1 X92.44 Y93.147 E.11762
G1 X91.774 Y94.39 E.02634
G1 X91.34 Y94.39 E.00811
G1 X91.34 Y92.99 E.02616
G1 X89.44 Y92.99 E.0355
G1 X89.44 Y100.59 E.14201
G1 X87.56 Y100.59 E.03513
G1 X87.56 Y79.41 E.39576
G1 X89.44 Y79.41 E.03513
G1 X89.44 Y86.95 E.14089
; WIPE_START
G1 F1800
M204 S6000
G1 X91.34 Y87.01 E-.27089
G1 X91.34 Y86.911 E-.01411
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




G1 X88.5 Y87.631
G1 Z5.12
G1 E.3 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.663042
G1 F1484
M204 S6000
G1 X88.5 Y80.031 E.22955
; WIPE_START
G1 F2400
G1 X88.5 Y82.031 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X89.824 Y89.548 Z5.52 F18000
G1 X90 Y90.55 Z5.52
G1 Z5.12
G1 E.3 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.449132
G1 F1484
M204 S6000
G1 X90 Y89.51 E.02087
M204 S10000
G1 X90.409 Y89.45 F18000
; LINE_WIDTH: 0.419992
G1 F1484
M204 S6000
G1 X90.409 Y89.041 E.00764
G1 X89.591 Y89.041 E.01528
G1 X89.591 Y90.959 E.03583
G1 X90.409 Y90.959 E.01528
G1 X90.409 Y89.51 E.02707
M204 S10000
G1 X90.803 Y89.45 F18000
G1 F1484
M204 S6000
G1 X90.803 Y88.647 E.01501
G1 X89.197 Y88.647 E.03001
M73 P60 R9
G1 X89.197 Y91.353 E.05056
G1 X90.803 Y91.353 E.03001
G1 X90.803 Y89.51 E.03444
M204 S10000
G1 X91.197 Y89.45 F18000
G1 F1484
M204 S6000
G1 X91.197 Y88.253 E.02237
G1 X88.803 Y88.253 E.04474
G1 X88.803 Y91.747 E.0653
G1 X91.197 Y91.747 E.04474
G1 X91.197 Y89.51 E.0418
; WIPE_START
G1 F4800
G1 X91.197 Y91.51 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X88.5 Y92.369 Z5.52 F18000
G1 Z5.12
G1 E.3 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.663042
G1 F1484
M204 S6000
G1 X88.5 Y99.969 E.22955
; CHANGE_LAYER
; Z_HEIGHT: 5.24
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F2400
G1 X88.5 Y97.969 E-.285
; WIPE_END
G1 E-.015 F1800
; layer num/total_layer_count: 49/102
; update layer progress
M73 L49
M991 S0 P48 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z5.52 I1.217 J.013 P1  F18000
G1 X88.607 Y87.843 Z5.52
G1 Z5.24
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1484
M204 S6000
G1 X91.607 Y87.843 E.06032
G1 X91.607 Y92.157 E.08672
G1 X88.393 Y92.157 E.06461
G1 X88.393 Y87.843 E.08672
G1 X88.547 Y87.843 E.00308
M204 S10000
G1 X89.031 Y87.01 F18000
G1 F1484
M204 S6000
G1 X89.031 Y87.419 E.00823
G1 X91.749 Y87.419 E.05466
G1 X91.749 Y86.838 E.01169
G1 X91.942 Y86.789 E.00399
G1 X92.031 Y86.955 E.00379
G1 X92.031 Y93.045 E.12244
G1 X91.942 Y93.211 E.00379
G1 X91.749 Y93.162 E.00399
G1 X91.749 Y92.581 E.01169
G1 X89.031 Y92.581 E.05466
G1 X89.031 Y100.181 E.15282
G1 X87.969 Y100.181 E.02134
G1 X87.969 Y79.819 E.40942
G1 X89.031 Y79.819 E.02134
G1 X89.031 Y86.95 E.14338
M204 S250
G1 X89.44 Y87.01 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1484
M204 S5000
G1 X91.34 Y87.01 E.0355
G1 X91.34 Y85.61 E.02616
G1 X91.774 Y85.61 E.00811
G1 X92.44 Y86.853 E.02634
G1 X92.44 Y93.147 E.11762
G1 X91.774 Y94.39 E.02634
G1 X91.34 Y94.39 E.00811
G1 X91.34 Y92.99 E.02616
G1 X89.44 Y92.99 E.0355
G1 X89.44 Y100.59 E.14201
G1 X87.56 Y100.59 E.03513
G1 X87.56 Y79.41 E.39576
G1 X89.44 Y79.41 E.03513
G1 X89.44 Y86.95 E.14089
; WIPE_START
G1 F1800
M204 S6000
G1 X91.34 Y87.01 E-.27089
G1 X91.34 Y86.911 E-.01411
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




G1 X88.5 Y87.631
G1 Z5.24
G1 E.3 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.663042
G1 F1484
M204 S6000
G1 X88.5 Y80.031 E.22955
; WIPE_START
G1 F2400
G1 X88.5 Y82.031 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X89.824 Y89.548 Z5.64 F18000
G1 X90 Y90.55 Z5.64
G1 Z5.24
G1 E.3 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.449132
G1 F1484
M204 S6000
G1 X90 Y89.51 E.02087
M204 S10000
G1 X90.409 Y89.45 F18000
; LINE_WIDTH: 0.419992
G1 F1484
M204 S6000
G1 X90.409 Y89.041 E.00764
G1 X89.591 Y89.041 E.01528
G1 X89.591 Y90.959 E.03583
G1 X90.409 Y90.959 E.01528
G1 X90.409 Y89.51 E.02707
M204 S10000
G1 X90.803 Y89.45 F18000
G1 F1484
M204 S6000
G1 X90.803 Y88.647 E.01501
G1 X89.197 Y88.647 E.03001
G1 X89.197 Y91.353 E.05056
G1 X90.803 Y91.353 E.03001
G1 X90.803 Y89.51 E.03444
M204 S10000
G1 X91.197 Y89.45 F18000
G1 F1484
M204 S6000
G1 X91.197 Y88.253 E.02237
G1 X88.803 Y88.253 E.04474
G1 X88.803 Y91.747 E.0653
G1 X91.197 Y91.747 E.04474
G1 X91.197 Y89.51 E.0418
; WIPE_START
G1 F4800
G1 X91.197 Y91.51 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X88.5 Y92.369 Z5.64 F18000
G1 Z5.24
G1 E.3 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.663042
G1 F1484
M204 S6000
G1 X88.5 Y99.969 E.22955
; CHANGE_LAYER
; Z_HEIGHT: 5.36
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F2400
G1 X88.5 Y97.969 E-.285
; WIPE_END
G1 E-.015 F1800
; layer num/total_layer_count: 50/102
; update layer progress
M73 L50
M991 S0 P49 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z5.64 I1.217 J.013 P1  F18000
G1 X88.607 Y87.843 Z5.64
G1 Z5.36
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1484
M204 S6000
G1 X91.607 Y87.843 E.06032
G1 X91.607 Y92.157 E.08672
G1 X88.393 Y92.157 E.06461
G1 X88.393 Y87.843 E.08672
G1 X88.547 Y87.843 E.00308
M204 S10000
G1 X89.031 Y87.01 F18000
G1 F1484
M204 S6000
G1 X89.031 Y87.419 E.00823
G1 X91.749 Y87.419 E.05466
G1 X91.749 Y86.838 E.01169
G1 X91.942 Y86.789 E.00399
G1 X92.031 Y86.955 E.00379
G1 X92.031 Y93.045 E.12244
G1 X91.942 Y93.211 E.00379
G1 X91.749 Y93.162 E.00399
G1 X91.749 Y92.581 E.01169
G1 X89.031 Y92.581 E.05466
G1 X89.031 Y100.181 E.15282
G1 X87.969 Y100.181 E.02134
G1 X87.969 Y79.819 E.40942
G1 X89.031 Y79.819 E.02134
G1 X89.031 Y86.95 E.14338
M204 S250
G1 X89.44 Y87.01 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1484
M204 S5000
G1 X91.34 Y87.01 E.0355
G1 X91.34 Y85.61 E.02616
G1 X91.774 Y85.61 E.00811
G1 X92.44 Y86.853 E.02634
G1 X92.44 Y93.147 E.11762
G1 X91.774 Y94.39 E.02634
G1 X91.34 Y94.39 E.00811
G1 X91.34 Y92.99 E.02616
G1 X89.44 Y92.99 E.0355
G1 X89.44 Y100.59 E.14201
G1 X87.56 Y100.59 E.03513
G1 X87.56 Y79.41 E.39576
M73 P61 R9
G1 X89.44 Y79.41 E.03513
G1 X89.44 Y86.95 E.14089
; WIPE_START
G1 F1800
M204 S6000
G1 X91.34 Y87.01 E-.27089
G1 X91.34 Y86.911 E-.01411
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
G1 X0 Y90 ; move to safe pos
G1 X-13.0 F3000 ; move to safe pos
M400
M1004 S5 P1  ; external shutter
M400 P300
M971 S11 C11 O0
G92 E0
M73 P61 R8
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




G1 X88.5 Y87.631
G1 Z5.36
G1 E.3 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.663042
G1 F1484
M204 S6000
G1 X88.5 Y80.031 E.22955
; WIPE_START
G1 F2400
G1 X88.5 Y82.031 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X89.824 Y89.548 Z5.76 F18000
G1 X90 Y90.55 Z5.76
G1 Z5.36
G1 E.3 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.449132
G1 F1484
M204 S6000
G1 X90 Y89.51 E.02087
M204 S10000
G1 X90.409 Y89.45 F18000
; LINE_WIDTH: 0.419992
G1 F1484
M204 S6000
G1 X90.409 Y89.041 E.00764
G1 X89.591 Y89.041 E.01528
G1 X89.591 Y90.959 E.03583
G1 X90.409 Y90.959 E.01528
G1 X90.409 Y89.51 E.02707
M204 S10000
G1 X90.803 Y89.45 F18000
G1 F1484
M204 S6000
G1 X90.803 Y88.647 E.01501
G1 X89.197 Y88.647 E.03001
G1 X89.197 Y91.353 E.05056
G1 X90.803 Y91.353 E.03001
G1 X90.803 Y89.51 E.03444
M204 S10000
G1 X91.197 Y89.45 F18000
G1 F1484
M204 S6000
G1 X91.197 Y88.253 E.02237
G1 X88.803 Y88.253 E.04474
G1 X88.803 Y91.747 E.0653
G1 X91.197 Y91.747 E.04474
G1 X91.197 Y89.51 E.0418
; WIPE_START
G1 F4800
G1 X91.197 Y91.51 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X88.5 Y92.369 Z5.76 F18000
G1 Z5.36
G1 E.3 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.663042
G1 F1484
M204 S6000
G1 X88.5 Y99.969 E.22955
; CHANGE_LAYER
; Z_HEIGHT: 5.48
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F2400
G1 X88.5 Y97.969 E-.285
; WIPE_END
G1 E-.015 F1800
; layer num/total_layer_count: 51/102
; update layer progress
M73 L51
M991 S0 P50 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z5.76 I1.217 J.013 P1  F18000
G1 X88.607 Y87.843 Z5.76
G1 Z5.48
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1484
M204 S6000
G1 X91.607 Y87.843 E.06032
G1 X91.607 Y92.157 E.08672
G1 X88.393 Y92.157 E.06461
G1 X88.393 Y87.843 E.08672
G1 X88.547 Y87.843 E.00308
M204 S10000
G1 X89.031 Y87.01 F18000
G1 F1484
M204 S6000
G1 X89.031 Y87.419 E.00823
G1 X91.749 Y87.419 E.05466
G1 X91.749 Y86.838 E.01169
G1 X91.942 Y86.789 E.00399
G1 X92.031 Y86.955 E.00379
G1 X92.031 Y93.045 E.12244
G1 X91.942 Y93.211 E.00379
G1 X91.749 Y93.162 E.00399
G1 X91.749 Y92.581 E.01169
G1 X89.031 Y92.581 E.05466
G1 X89.031 Y100.181 E.15282
G1 X87.969 Y100.181 E.02134
G1 X87.969 Y79.819 E.40942
G1 X89.031 Y79.819 E.02134
G1 X89.031 Y86.95 E.14338
M204 S250
G1 X89.44 Y87.01 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1484
M204 S5000
G1 X91.34 Y87.01 E.0355
G1 X91.34 Y85.61 E.02616
G1 X91.774 Y85.61 E.00811
G1 X92.44 Y86.853 E.02634
G1 X92.44 Y93.147 E.11762
G1 X91.774 Y94.39 E.02634
G1 X91.34 Y94.39 E.00811
G1 X91.34 Y92.99 E.02616
G1 X89.44 Y92.99 E.0355
G1 X89.44 Y100.59 E.14201
G1 X87.56 Y100.59 E.03513
G1 X87.56 Y79.41 E.39576
G1 X89.44 Y79.41 E.03513
G1 X89.44 Y86.95 E.14089
; WIPE_START
G1 F1800
M204 S6000
G1 X91.34 Y87.01 E-.27089
G1 X91.34 Y86.911 E-.01411
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




G1 X88.5 Y87.631
G1 Z5.48
G1 E.3 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.663042
G1 F1484
M204 S6000
G1 X88.5 Y80.031 E.22955
; WIPE_START
G1 F2400
G1 X88.5 Y82.031 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X89.824 Y89.548 Z5.88 F18000
G1 X90 Y90.55 Z5.88
G1 Z5.48
G1 E.3 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.449132
G1 F1484
M204 S6000
G1 X90 Y89.51 E.02087
M204 S10000
G1 X90.409 Y89.45 F18000
; LINE_WIDTH: 0.419992
G1 F1484
M204 S6000
G1 X90.409 Y89.041 E.00764
G1 X89.591 Y89.041 E.01528
G1 X89.591 Y90.959 E.03583
M73 P62 R8
G1 X90.409 Y90.959 E.01528
G1 X90.409 Y89.51 E.02707
M204 S10000
G1 X90.803 Y89.45 F18000
G1 F1484
M204 S6000
G1 X90.803 Y88.647 E.01501
G1 X89.197 Y88.647 E.03001
G1 X89.197 Y91.353 E.05056
G1 X90.803 Y91.353 E.03001
G1 X90.803 Y89.51 E.03444
M204 S10000
G1 X91.197 Y89.45 F18000
G1 F1484
M204 S6000
G1 X91.197 Y88.253 E.02237
G1 X88.803 Y88.253 E.04474
G1 X88.803 Y91.747 E.0653
G1 X91.197 Y91.747 E.04474
G1 X91.197 Y89.51 E.0418
; WIPE_START
G1 F4800
G1 X91.197 Y91.51 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X88.5 Y92.369 Z5.88 F18000
G1 Z5.48
G1 E.3 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.663042
G1 F1484
M204 S6000
G1 X88.5 Y99.969 E.22955
; CHANGE_LAYER
; Z_HEIGHT: 5.6
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F2400
G1 X88.5 Y97.969 E-.285
; WIPE_END
G1 E-.015 F1800
; layer num/total_layer_count: 52/102
; update layer progress
M73 L52
M991 S0 P51 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z5.88 I1.217 J.013 P1  F18000
G1 X88.607 Y87.843 Z5.88
G1 Z5.6
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1484
M204 S6000
G1 X91.607 Y87.843 E.06032
G1 X91.607 Y92.157 E.08672
G1 X88.393 Y92.157 E.06461
G1 X88.393 Y87.843 E.08672
G1 X88.547 Y87.843 E.00308
M204 S10000
G1 X89.031 Y87.01 F18000
G1 F1484
M204 S6000
G1 X89.031 Y87.419 E.00823
G1 X91.749 Y87.419 E.05466
G1 X91.749 Y86.838 E.01169
G1 X91.942 Y86.789 E.00399
G1 X92.031 Y86.955 E.00379
G1 X92.031 Y93.045 E.12244
G1 X91.942 Y93.211 E.00379
G1 X91.749 Y93.162 E.00399
G1 X91.749 Y92.581 E.01169
G1 X89.031 Y92.581 E.05466
G1 X89.031 Y100.181 E.15282
G1 X87.969 Y100.181 E.02134
G1 X87.969 Y79.819 E.40942
G1 X89.031 Y79.819 E.02134
G1 X89.031 Y86.95 E.14338
M204 S250
G1 X89.44 Y87.01 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1484
M204 S5000
G1 X91.34 Y87.01 E.0355
G1 X91.34 Y85.61 E.02616
G1 X91.774 Y85.61 E.00811
G1 X92.44 Y86.853 E.02634
G1 X92.44 Y93.147 E.11762
G1 X91.774 Y94.39 E.02634
G1 X91.34 Y94.39 E.00811
G1 X91.34 Y92.99 E.02616
G1 X89.44 Y92.99 E.0355
G1 X89.44 Y100.59 E.14201
G1 X87.56 Y100.59 E.03513
G1 X87.56 Y79.41 E.39576
G1 X89.44 Y79.41 E.03513
G1 X89.44 Y86.95 E.14089
; WIPE_START
G1 F1800
M204 S6000
G1 X91.34 Y87.01 E-.27089
G1 X91.34 Y86.911 E-.01411
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




G1 X88.5 Y87.631
G1 Z5.6
G1 E.3 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.663042
G1 F1484
M204 S6000
G1 X88.5 Y80.031 E.22955
; WIPE_START
G1 F2400
G1 X88.5 Y82.031 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X89.824 Y89.548 Z6 F18000
G1 X90 Y90.55 Z6
G1 Z5.6
G1 E.3 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.449132
G1 F1484
M204 S6000
G1 X90 Y89.51 E.02087
M204 S10000
G1 X90.409 Y89.45 F18000
; LINE_WIDTH: 0.419992
G1 F1484
M204 S6000
G1 X90.409 Y89.041 E.00764
G1 X89.591 Y89.041 E.01528
G1 X89.591 Y90.959 E.03583
G1 X90.409 Y90.959 E.01528
G1 X90.409 Y89.51 E.02707
M204 S10000
G1 X90.803 Y89.45 F18000
G1 F1484
M204 S6000
G1 X90.803 Y88.647 E.01501
G1 X89.197 Y88.647 E.03001
G1 X89.197 Y91.353 E.05056
G1 X90.803 Y91.353 E.03001
G1 X90.803 Y89.51 E.03444
M204 S10000
G1 X91.197 Y89.45 F18000
G1 F1484
M204 S6000
G1 X91.197 Y88.253 E.02237
G1 X88.803 Y88.253 E.04474
G1 X88.803 Y91.747 E.0653
G1 X91.197 Y91.747 E.04474
G1 X91.197 Y89.51 E.0418
; WIPE_START
G1 F4800
G1 X91.197 Y91.51 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X88.5 Y92.369 Z6 F18000
G1 Z5.6
G1 E.3 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.663042
G1 F1484
M204 S6000
G1 X88.5 Y99.969 E.22955
; CHANGE_LAYER
; Z_HEIGHT: 5.72
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F2400
G1 X88.5 Y97.969 E-.285
; WIPE_END
G1 E-.015 F1800
; layer num/total_layer_count: 53/102
; update layer progress
M73 L53
M991 S0 P52 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z6 I1.217 J.013 P1  F18000
G1 X88.607 Y87.843 Z6
G1 Z5.72
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1484
M204 S6000
G1 X91.607 Y87.843 E.06032
G1 X91.607 Y92.157 E.08672
G1 X88.393 Y92.157 E.06461
G1 X88.393 Y87.843 E.08672
G1 X88.547 Y87.843 E.00308
M204 S10000
G1 X89.031 Y87.01 F18000
G1 F1484
M204 S6000
G1 X89.031 Y87.419 E.00823
G1 X91.749 Y87.419 E.05466
G1 X91.749 Y86.838 E.01169
G1 X91.942 Y86.789 E.00399
G1 X92.031 Y86.955 E.00379
G1 X92.031 Y93.045 E.12244
G1 X91.942 Y93.211 E.00379
G1 X91.749 Y93.162 E.00399
M73 P63 R8
G1 X91.749 Y92.581 E.01169
G1 X89.031 Y92.581 E.05466
G1 X89.031 Y100.181 E.15282
G1 X87.969 Y100.181 E.02134
G1 X87.969 Y79.819 E.40942
G1 X89.031 Y79.819 E.02134
G1 X89.031 Y86.95 E.14338
M204 S250
G1 X89.44 Y87.01 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1484
M204 S5000
G1 X91.34 Y87.01 E.0355
G1 X91.34 Y85.61 E.02616
G1 X91.774 Y85.61 E.00811
G1 X92.44 Y86.853 E.02634
G1 X92.44 Y93.147 E.11762
G1 X91.774 Y94.39 E.02634
G1 X91.34 Y94.39 E.00811
G1 X91.34 Y92.99 E.02616
G1 X89.44 Y92.99 E.0355
G1 X89.44 Y100.59 E.14201
G1 X87.56 Y100.59 E.03513
G1 X87.56 Y79.41 E.39576
G1 X89.44 Y79.41 E.03513
G1 X89.44 Y86.95 E.14089
; WIPE_START
G1 F1800
M204 S6000
G1 X91.34 Y87.01 E-.27089
G1 X91.34 Y86.911 E-.01411
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




G1 X88.5 Y87.631
G1 Z5.72
G1 E.3 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.663042
G1 F1484
M204 S6000
G1 X88.5 Y80.031 E.22955
; WIPE_START
G1 F2400
G1 X88.5 Y82.031 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X89.824 Y89.548 Z6.12 F18000
G1 X90 Y90.55 Z6.12
G1 Z5.72
G1 E.3 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.449132
G1 F1484
M204 S6000
G1 X90 Y89.51 E.02087
M204 S10000
G1 X90.409 Y89.45 F18000
; LINE_WIDTH: 0.419992
G1 F1484
M204 S6000
G1 X90.409 Y89.041 E.00764
G1 X89.591 Y89.041 E.01528
G1 X89.591 Y90.959 E.03583
G1 X90.409 Y90.959 E.01528
G1 X90.409 Y89.51 E.02707
M204 S10000
G1 X90.803 Y89.45 F18000
G1 F1484
M204 S6000
G1 X90.803 Y88.647 E.01501
G1 X89.197 Y88.647 E.03001
G1 X89.197 Y91.353 E.05056
G1 X90.803 Y91.353 E.03001
G1 X90.803 Y89.51 E.03444
M204 S10000
G1 X91.197 Y89.45 F18000
G1 F1484
M204 S6000
G1 X91.197 Y88.253 E.02237
G1 X88.803 Y88.253 E.04474
G1 X88.803 Y91.747 E.0653
G1 X91.197 Y91.747 E.04474
G1 X91.197 Y89.51 E.0418
; WIPE_START
G1 F4800
G1 X91.197 Y91.51 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X88.5 Y92.369 Z6.12 F18000
G1 Z5.72
G1 E.3 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.663042
G1 F1484
M204 S6000
G1 X88.5 Y99.969 E.22955
; CHANGE_LAYER
; Z_HEIGHT: 5.84
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F2400
G1 X88.5 Y97.969 E-.285
; WIPE_END
G1 E-.015 F1800
; layer num/total_layer_count: 54/102
; update layer progress
M73 L54
M991 S0 P53 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z6.12 I1.217 J.013 P1  F18000
G1 X88.607 Y87.843 Z6.12
G1 Z5.84
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1484
M204 S6000
G1 X91.607 Y87.843 E.06032
G1 X91.607 Y92.157 E.08672
G1 X88.393 Y92.157 E.06461
G1 X88.393 Y87.843 E.08672
G1 X88.547 Y87.843 E.00308
M204 S10000
G1 X89.031 Y87.01 F18000
G1 F1484
M204 S6000
G1 X89.031 Y87.419 E.00823
G1 X91.749 Y87.419 E.05466
G1 X91.749 Y86.838 E.01169
G1 X91.942 Y86.789 E.00399
G1 X92.031 Y86.955 E.00379
G1 X92.031 Y93.045 E.12244
G1 X91.942 Y93.211 E.00379
G1 X91.749 Y93.162 E.00399
G1 X91.749 Y92.581 E.01169
G1 X89.031 Y92.581 E.05466
G1 X89.031 Y100.181 E.15282
G1 X87.969 Y100.181 E.02134
G1 X87.969 Y79.819 E.40942
G1 X89.031 Y79.819 E.02134
G1 X89.031 Y86.95 E.14338
M204 S250
G1 X89.44 Y87.01 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1484
M204 S5000
G1 X91.34 Y87.01 E.0355
G1 X91.34 Y85.61 E.02616
G1 X91.774 Y85.61 E.00811
G1 X92.44 Y86.853 E.02634
G1 X92.44 Y93.147 E.11762
G1 X91.774 Y94.39 E.02634
G1 X91.34 Y94.39 E.00811
G1 X91.34 Y92.99 E.02616
G1 X89.44 Y92.99 E.0355
G1 X89.44 Y100.59 E.14201
G1 X87.56 Y100.59 E.03513
G1 X87.56 Y79.41 E.39576
G1 X89.44 Y79.41 E.03513
G1 X89.44 Y86.95 E.14089
; WIPE_START
G1 F1800
M204 S6000
G1 X91.34 Y87.01 E-.27089
G1 X91.34 Y86.911 E-.01411
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




G1 X88.5 Y87.631
G1 Z5.84
G1 E.3 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.663042
G1 F1484
M204 S6000
G1 X88.5 Y80.031 E.22955
; WIPE_START
G1 F2400
G1 X88.5 Y82.031 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X89.824 Y89.548 Z6.24 F18000
G1 X90 Y90.55 Z6.24
G1 Z5.84
G1 E.3 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.449132
G1 F1484
M204 S6000
G1 X90 Y89.51 E.02087
M204 S10000
G1 X90.409 Y89.45 F18000
; LINE_WIDTH: 0.419992
G1 F1484
M204 S6000
G1 X90.409 Y89.041 E.00764
G1 X89.591 Y89.041 E.01528
M73 P64 R8
G1 X89.591 Y90.959 E.03583
G1 X90.409 Y90.959 E.01528
G1 X90.409 Y89.51 E.02707
M204 S10000
G1 X90.803 Y89.45 F18000
G1 F1484
M204 S6000
G1 X90.803 Y88.647 E.01501
G1 X89.197 Y88.647 E.03001
G1 X89.197 Y91.353 E.05056
G1 X90.803 Y91.353 E.03001
G1 X90.803 Y89.51 E.03444
M204 S10000
G1 X91.197 Y89.45 F18000
G1 F1484
M204 S6000
G1 X91.197 Y88.253 E.02237
G1 X88.803 Y88.253 E.04474
G1 X88.803 Y91.747 E.0653
G1 X91.197 Y91.747 E.04474
G1 X91.197 Y89.51 E.0418
; WIPE_START
G1 F4800
G1 X91.197 Y91.51 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X88.5 Y92.369 Z6.24 F18000
G1 Z5.84
G1 E.3 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.663042
G1 F1484
M204 S6000
G1 X88.5 Y99.969 E.22955
; CHANGE_LAYER
; Z_HEIGHT: 5.96
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F2400
G1 X88.5 Y97.969 E-.285
; WIPE_END
G1 E-.015 F1800
; layer num/total_layer_count: 55/102
; update layer progress
M73 L55
M991 S0 P54 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z6.24 I1.217 J.013 P1  F18000
G1 X88.607 Y87.843 Z6.24
G1 Z5.96
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1484
M204 S6000
G1 X91.607 Y87.843 E.06032
G1 X91.607 Y92.157 E.08672
G1 X88.393 Y92.157 E.06461
G1 X88.393 Y87.843 E.08672
G1 X88.547 Y87.843 E.00308
M204 S10000
G1 X89.031 Y87.01 F18000
G1 F1484
M204 S6000
G1 X89.031 Y87.419 E.00823
G1 X91.749 Y87.419 E.05466
G1 X91.749 Y86.838 E.01169
G1 X91.942 Y86.789 E.00399
G1 X92.031 Y86.955 E.00379
G1 X92.031 Y93.045 E.12244
G1 X91.942 Y93.211 E.00379
G1 X91.749 Y93.162 E.00399
G1 X91.749 Y92.581 E.01169
G1 X89.031 Y92.581 E.05466
G1 X89.031 Y100.181 E.15282
G1 X87.969 Y100.181 E.02134
G1 X87.969 Y79.819 E.40942
G1 X89.031 Y79.819 E.02134
G1 X89.031 Y86.95 E.14338
M204 S250
G1 X89.44 Y87.01 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1484
M204 S5000
G1 X91.34 Y87.01 E.0355
G1 X91.34 Y85.61 E.02616
G1 X91.774 Y85.61 E.00811
G1 X92.44 Y86.853 E.02634
G1 X92.44 Y93.147 E.11762
G1 X91.774 Y94.39 E.02634
G1 X91.34 Y94.39 E.00811
G1 X91.34 Y92.99 E.02616
G1 X89.44 Y92.99 E.0355
G1 X89.44 Y100.59 E.14201
G1 X87.56 Y100.59 E.03513
G1 X87.56 Y79.41 E.39576
G1 X89.44 Y79.41 E.03513
G1 X89.44 Y86.95 E.14089
; WIPE_START
G1 F1800
M204 S6000
G1 X91.34 Y87.01 E-.27089
G1 X91.34 Y86.911 E-.01411
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




G1 X88.5 Y87.631
G1 Z5.96
G1 E.3 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.663042
G1 F1484
M204 S6000
G1 X88.5 Y80.031 E.22955
; WIPE_START
G1 F2400
G1 X88.5 Y82.031 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X89.824 Y89.548 Z6.36 F18000
G1 X90 Y90.55 Z6.36
G1 Z5.96
G1 E.3 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.449132
G1 F1484
M204 S6000
G1 X90 Y89.51 E.02087
M204 S10000
G1 X90.409 Y89.45 F18000
; LINE_WIDTH: 0.419992
G1 F1484
M204 S6000
G1 X90.409 Y89.041 E.00764
G1 X89.591 Y89.041 E.01528
G1 X89.591 Y90.959 E.03583
G1 X90.409 Y90.959 E.01528
G1 X90.409 Y89.51 E.02707
M204 S10000
G1 X90.803 Y89.45 F18000
G1 F1484
M204 S6000
G1 X90.803 Y88.647 E.01501
G1 X89.197 Y88.647 E.03001
G1 X89.197 Y91.353 E.05056
G1 X90.803 Y91.353 E.03001
G1 X90.803 Y89.51 E.03444
M204 S10000
G1 X91.197 Y89.45 F18000
G1 F1484
M204 S6000
G1 X91.197 Y88.253 E.02237
G1 X88.803 Y88.253 E.04474
G1 X88.803 Y91.747 E.0653
G1 X91.197 Y91.747 E.04474
G1 X91.197 Y89.51 E.0418
; WIPE_START
G1 F4800
G1 X91.197 Y91.51 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X88.5 Y92.369 Z6.36 F18000
M73 P65 R8
G1 Z5.96
G1 E.3 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.663042
G1 F1484
M204 S6000
G1 X88.5 Y99.969 E.22955
; CHANGE_LAYER
; Z_HEIGHT: 6.08
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F2400
G1 X88.5 Y97.969 E-.285
; WIPE_END
G1 E-.015 F1800
; layer num/total_layer_count: 56/102
; update layer progress
M73 L56
M991 S0 P55 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z6.36 I1.217 J.013 P1  F18000
G1 X88.607 Y87.843 Z6.36
G1 Z6.08
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1484
M204 S6000
G1 X91.607 Y87.843 E.06032
G1 X91.607 Y92.157 E.08672
G1 X88.393 Y92.157 E.06461
G1 X88.393 Y87.843 E.08672
G1 X88.547 Y87.843 E.00308
M204 S10000
G1 X89.031 Y87.01 F18000
G1 F1484
M204 S6000
G1 X89.031 Y87.419 E.00823
G1 X91.749 Y87.419 E.05466
G1 X91.749 Y86.838 E.01169
G1 X91.942 Y86.789 E.00399
G1 X92.031 Y86.955 E.00379
G1 X92.031 Y93.045 E.12244
G1 X91.942 Y93.211 E.00379
G1 X91.749 Y93.162 E.00399
G1 X91.749 Y92.581 E.01169
G1 X89.031 Y92.581 E.05466
G1 X89.031 Y100.181 E.15282
G1 X87.969 Y100.181 E.02134
G1 X87.969 Y79.819 E.40942
G1 X89.031 Y79.819 E.02134
G1 X89.031 Y86.95 E.14338
M204 S250
G1 X89.44 Y87.01 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1484
M204 S5000
G1 X91.34 Y87.01 E.0355
G1 X91.34 Y85.61 E.02616
G1 X91.774 Y85.61 E.00811
G1 X92.44 Y86.853 E.02634
G1 X92.44 Y93.147 E.11762
G1 X91.774 Y94.39 E.02634
G1 X91.34 Y94.39 E.00811
G1 X91.34 Y92.99 E.02616
G1 X89.44 Y92.99 E.0355
G1 X89.44 Y100.59 E.14201
G1 X87.56 Y100.59 E.03513
G1 X87.56 Y79.41 E.39576
G1 X89.44 Y79.41 E.03513
G1 X89.44 Y86.95 E.14089
; WIPE_START
G1 F1800
M204 S6000
G1 X91.34 Y87.01 E-.27089
G1 X91.34 Y86.911 E-.01411
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
            G0 Z6.48 F4000
            G39.3 S1
            G0 Z6.48 F4000
            G392 S0
          
        M623
    
    M623
M623
; SKIPPABLE_END




G1 X88.5 Y87.631
G1 Z6.08
G1 E.3 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.663042
G1 F1484
M204 S6000
G1 X88.5 Y80.031 E.22955
; WIPE_START
G1 F2400
G1 X88.5 Y82.031 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X89.824 Y89.548 Z6.48 F18000
G1 X90 Y90.55 Z6.48
G1 Z6.08
G1 E.3 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.449132
G1 F1484
M204 S6000
G1 X90 Y89.51 E.02087
M204 S10000
G1 X90.409 Y89.45 F18000
; LINE_WIDTH: 0.419992
G1 F1484
M204 S6000
G1 X90.409 Y89.041 E.00764
G1 X89.591 Y89.041 E.01528
G1 X89.591 Y90.959 E.03583
G1 X90.409 Y90.959 E.01528
G1 X90.409 Y89.51 E.02707
M204 S10000
G1 X90.803 Y89.45 F18000
G1 F1484
M204 S6000
G1 X90.803 Y88.647 E.01501
M73 P65 R7
G1 X89.197 Y88.647 E.03001
G1 X89.197 Y91.353 E.05056
G1 X90.803 Y91.353 E.03001
G1 X90.803 Y89.51 E.03444
M204 S10000
G1 X91.197 Y89.45 F18000
G1 F1484
M204 S6000
G1 X91.197 Y88.253 E.02237
G1 X88.803 Y88.253 E.04474
G1 X88.803 Y91.747 E.0653
G1 X91.197 Y91.747 E.04474
G1 X91.197 Y89.51 E.0418
; WIPE_START
G1 F4800
G1 X91.197 Y91.51 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X88.5 Y92.369 Z6.48 F18000
G1 Z6.08
G1 E.3 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.663042
G1 F1484
M204 S6000
G1 X88.5 Y99.969 E.22955
; CHANGE_LAYER
; Z_HEIGHT: 6.2
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F2400
G1 X88.5 Y97.969 E-.285
; WIPE_END
G1 E-.015 F1800
; layer num/total_layer_count: 57/102
; update layer progress
M73 L57
M991 S0 P56 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z6.48 I1.217 J.013 P1  F18000
G1 X88.607 Y87.843 Z6.48
G1 Z6.2
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1484
M204 S6000
G1 X91.607 Y87.843 E.06032
G1 X91.607 Y92.157 E.08672
G1 X88.393 Y92.157 E.06461
G1 X88.393 Y87.843 E.08672
G1 X88.547 Y87.843 E.00308
M204 S10000
G1 X89.031 Y87.01 F18000
G1 F1484
M204 S6000
G1 X89.031 Y87.419 E.00823
G1 X91.749 Y87.419 E.05466
G1 X91.749 Y86.838 E.01169
G1 X91.942 Y86.789 E.00399
G1 X92.031 Y86.955 E.00379
G1 X92.031 Y93.045 E.12244
G1 X91.942 Y93.211 E.00379
G1 X91.749 Y93.162 E.00399
G1 X91.749 Y92.581 E.01169
G1 X89.031 Y92.581 E.05466
G1 X89.031 Y100.181 E.15282
G1 X87.969 Y100.181 E.02134
G1 X87.969 Y79.819 E.40942
G1 X89.031 Y79.819 E.02134
G1 X89.031 Y86.95 E.14338
M204 S250
G1 X89.44 Y87.01 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1484
M204 S5000
G1 X91.34 Y87.01 E.0355
G1 X91.34 Y85.61 E.02616
G1 X91.774 Y85.61 E.00811
G1 X92.44 Y86.853 E.02634
G1 X92.44 Y93.147 E.11762
G1 X91.774 Y94.39 E.02634
G1 X91.34 Y94.39 E.00811
G1 X91.34 Y92.99 E.02616
G1 X89.44 Y92.99 E.0355
G1 X89.44 Y100.59 E.14201
G1 X87.56 Y100.59 E.03513
G1 X87.56 Y79.41 E.39576
G1 X89.44 Y79.41 E.03513
G1 X89.44 Y86.95 E.14089
; WIPE_START
G1 F1800
M204 S6000
G1 X91.34 Y87.01 E-.27089
G1 X91.34 Y86.911 E-.01411
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
            G0 Z6.6 F4000
            G39.3 S1
            G0 Z6.6 F4000
            G392 S0
          
        M623
    
    M623
M623
; SKIPPABLE_END




G1 X88.5 Y87.631
G1 Z6.2
G1 E.3 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.663042
G1 F1484
M204 S6000
G1 X88.5 Y80.031 E.22955
; WIPE_START
G1 F2400
G1 X88.5 Y82.031 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X89.824 Y89.548 Z6.6 F18000
G1 X90 Y90.55 Z6.6
G1 Z6.2
G1 E.3 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.449132
G1 F1484
M204 S6000
M73 P66 R7
G1 X90 Y89.51 E.02087
M204 S10000
G1 X90.409 Y89.45 F18000
; LINE_WIDTH: 0.419992
G1 F1484
M204 S6000
G1 X90.409 Y89.041 E.00764
G1 X89.591 Y89.041 E.01528
G1 X89.591 Y90.959 E.03583
G1 X90.409 Y90.959 E.01528
G1 X90.409 Y89.51 E.02707
M204 S10000
G1 X90.803 Y89.45 F18000
G1 F1484
M204 S6000
G1 X90.803 Y88.647 E.01501
G1 X89.197 Y88.647 E.03001
G1 X89.197 Y91.353 E.05056
G1 X90.803 Y91.353 E.03001
G1 X90.803 Y89.51 E.03444
M204 S10000
G1 X91.197 Y89.45 F18000
G1 F1484
M204 S6000
G1 X91.197 Y88.253 E.02237
G1 X88.803 Y88.253 E.04474
G1 X88.803 Y91.747 E.0653
G1 X91.197 Y91.747 E.04474
G1 X91.197 Y89.51 E.0418
; WIPE_START
G1 F4800
G1 X91.197 Y91.51 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X88.5 Y92.369 Z6.6 F18000
G1 Z6.2
G1 E.3 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.663042
G1 F1484
M204 S6000
G1 X88.5 Y99.969 E.22955
; CHANGE_LAYER
; Z_HEIGHT: 6.32
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F2400
G1 X88.5 Y97.969 E-.285
; WIPE_END
G1 E-.015 F1800
; layer num/total_layer_count: 58/102
; update layer progress
M73 L58
M991 S0 P57 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z6.6 I1.217 J.013 P1  F18000
G1 X88.607 Y87.843 Z6.6
G1 Z6.32
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1484
M204 S6000
G1 X91.607 Y87.843 E.06032
G1 X91.607 Y92.157 E.08672
G1 X88.393 Y92.157 E.06461
G1 X88.393 Y87.843 E.08672
G1 X88.547 Y87.843 E.00308
M204 S10000
G1 X89.031 Y87.01 F18000
G1 F1484
M204 S6000
G1 X89.031 Y87.419 E.00823
G1 X91.749 Y87.419 E.05466
G1 X91.749 Y86.838 E.01169
G1 X91.942 Y86.789 E.00399
G1 X92.031 Y86.955 E.00379
G1 X92.031 Y93.045 E.12244
G1 X91.942 Y93.211 E.00379
G1 X91.749 Y93.162 E.00399
G1 X91.749 Y92.581 E.01169
G1 X89.031 Y92.581 E.05466
G1 X89.031 Y100.181 E.15282
G1 X87.969 Y100.181 E.02134
G1 X87.969 Y79.819 E.40942
G1 X89.031 Y79.819 E.02134
G1 X89.031 Y86.95 E.14338
M204 S250
G1 X89.44 Y87.01 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1484
M204 S5000
G1 X91.34 Y87.01 E.0355
G1 X91.34 Y85.61 E.02616
G1 X91.774 Y85.61 E.00811
G1 X92.44 Y86.853 E.02634
G1 X92.44 Y93.147 E.11762
G1 X91.774 Y94.39 E.02634
G1 X91.34 Y94.39 E.00811
G1 X91.34 Y92.99 E.02616
G1 X89.44 Y92.99 E.0355
G1 X89.44 Y100.59 E.14201
G1 X87.56 Y100.59 E.03513
G1 X87.56 Y79.41 E.39576
G1 X89.44 Y79.41 E.03513
G1 X89.44 Y86.95 E.14089
; WIPE_START
G1 F1800
M204 S6000
G1 X91.34 Y87.01 E-.27089
G1 X91.34 Y86.911 E-.01411
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
            G0 Z6.72 F4000
            G39.3 S1
            G0 Z6.72 F4000
            G392 S0
          
        M623
    
    M623
M623
; SKIPPABLE_END




G1 X88.5 Y87.631
G1 Z6.32
G1 E.3 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.663042
G1 F1484
M204 S6000
G1 X88.5 Y80.031 E.22955
; WIPE_START
G1 F2400
G1 X88.5 Y82.031 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X89.824 Y89.548 Z6.72 F18000
G1 X90 Y90.55 Z6.72
G1 Z6.32
G1 E.3 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.449132
G1 F1484
M204 S6000
G1 X90 Y89.51 E.02087
M204 S10000
G1 X90.409 Y89.45 F18000
; LINE_WIDTH: 0.419992
G1 F1484
M204 S6000
G1 X90.409 Y89.041 E.00764
G1 X89.591 Y89.041 E.01528
G1 X89.591 Y90.959 E.03583
G1 X90.409 Y90.959 E.01528
G1 X90.409 Y89.51 E.02707
M204 S10000
G1 X90.803 Y89.45 F18000
G1 F1484
M204 S6000
G1 X90.803 Y88.647 E.01501
G1 X89.197 Y88.647 E.03001
G1 X89.197 Y91.353 E.05056
G1 X90.803 Y91.353 E.03001
G1 X90.803 Y89.51 E.03444
M204 S10000
G1 X91.197 Y89.45 F18000
G1 F1484
M204 S6000
G1 X91.197 Y88.253 E.02237
G1 X88.803 Y88.253 E.04474
G1 X88.803 Y91.747 E.0653
G1 X91.197 Y91.747 E.04474
G1 X91.197 Y89.51 E.0418
; WIPE_START
G1 F4800
G1 X91.197 Y91.51 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X88.5 Y92.369 Z6.72 F18000
G1 Z6.32
G1 E.3 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.663042
G1 F1484
M204 S6000
M73 P67 R7
G1 X88.5 Y99.969 E.22955
; CHANGE_LAYER
; Z_HEIGHT: 6.44
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F2400
G1 X88.5 Y97.969 E-.285
; WIPE_END
G1 E-.015 F1800
; layer num/total_layer_count: 59/102
; update layer progress
M73 L59
M991 S0 P58 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z6.72 I1.217 J.013 P1  F18000
G1 X88.607 Y87.843 Z6.72
G1 Z6.44
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1484
M204 S6000
G1 X91.607 Y87.843 E.06032
G1 X91.607 Y92.157 E.08672
G1 X88.393 Y92.157 E.06461
G1 X88.393 Y87.843 E.08672
G1 X88.547 Y87.843 E.00308
M204 S10000
G1 X89.031 Y87.01 F18000
G1 F1484
M204 S6000
G1 X89.031 Y87.419 E.00823
G1 X91.749 Y87.419 E.05466
G1 X91.749 Y86.838 E.01169
G1 X91.942 Y86.789 E.00399
G1 X92.031 Y86.955 E.00379
G1 X92.031 Y93.045 E.12244
G1 X91.942 Y93.211 E.00379
G1 X91.749 Y93.162 E.00399
G1 X91.749 Y92.581 E.01169
G1 X89.031 Y92.581 E.05466
G1 X89.031 Y100.181 E.15282
G1 X87.969 Y100.181 E.02134
G1 X87.969 Y79.819 E.40942
G1 X89.031 Y79.819 E.02134
G1 X89.031 Y86.95 E.14338
M204 S250
G1 X89.44 Y87.01 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1484
M204 S5000
G1 X91.34 Y87.01 E.0355
G1 X91.34 Y85.61 E.02616
G1 X91.774 Y85.61 E.00811
G1 X92.44 Y86.853 E.02634
G1 X92.44 Y93.147 E.11762
G1 X91.774 Y94.39 E.02634
G1 X91.34 Y94.39 E.00811
G1 X91.34 Y92.99 E.02616
G1 X89.44 Y92.99 E.0355
G1 X89.44 Y100.59 E.14201
G1 X87.56 Y100.59 E.03513
G1 X87.56 Y79.41 E.39576
G1 X89.44 Y79.41 E.03513
G1 X89.44 Y86.95 E.14089
; WIPE_START
G1 F1800
M204 S6000
G1 X91.34 Y87.01 E-.27089
G1 X91.34 Y86.911 E-.01411
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
            G0 Z6.84 F4000
            G39.3 S1
            G0 Z6.84 F4000
            G392 S0
          
        M623
    
    M623
M623
; SKIPPABLE_END




G1 X88.5 Y87.631
G1 Z6.44
G1 E.3 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.663042
G1 F1484
M204 S6000
G1 X88.5 Y80.031 E.22955
; WIPE_START
G1 F2400
G1 X88.5 Y82.031 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X89.824 Y89.548 Z6.84 F18000
G1 X90 Y90.55 Z6.84
G1 Z6.44
G1 E.3 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.449132
G1 F1484
M204 S6000
G1 X90 Y89.51 E.02087
M204 S10000
G1 X90.409 Y89.45 F18000
; LINE_WIDTH: 0.419992
G1 F1484
M204 S6000
G1 X90.409 Y89.041 E.00764
G1 X89.591 Y89.041 E.01528
G1 X89.591 Y90.959 E.03583
G1 X90.409 Y90.959 E.01528
G1 X90.409 Y89.51 E.02707
M204 S10000
G1 X90.803 Y89.45 F18000
G1 F1484
M204 S6000
G1 X90.803 Y88.647 E.01501
G1 X89.197 Y88.647 E.03001
G1 X89.197 Y91.353 E.05056
G1 X90.803 Y91.353 E.03001
G1 X90.803 Y89.51 E.03444
M204 S10000
G1 X91.197 Y89.45 F18000
G1 F1484
M204 S6000
G1 X91.197 Y88.253 E.02237
G1 X88.803 Y88.253 E.04474
G1 X88.803 Y91.747 E.0653
G1 X91.197 Y91.747 E.04474
G1 X91.197 Y89.51 E.0418
; WIPE_START
G1 F4800
G1 X91.197 Y91.51 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X88.5 Y92.369 Z6.84 F18000
G1 Z6.44
G1 E.3 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.663042
G1 F1484
M204 S6000
G1 X88.5 Y99.969 E.22955
; CHANGE_LAYER
; Z_HEIGHT: 6.56
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F2400
G1 X88.5 Y97.969 E-.285
; WIPE_END
G1 E-.015 F1800
; layer num/total_layer_count: 60/102
; update layer progress
M73 L60
M991 S0 P59 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z6.84 I1.217 J.013 P1  F18000
G1 X88.607 Y87.843 Z6.84
G1 Z6.56
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1484
M204 S6000
G1 X91.607 Y87.843 E.06032
G1 X91.607 Y92.157 E.08672
G1 X88.393 Y92.157 E.06461
G1 X88.393 Y87.843 E.08672
G1 X88.547 Y87.843 E.00308
M204 S10000
G1 X89.031 Y87.01 F18000
G1 F1484
M204 S6000
G1 X89.031 Y87.419 E.00823
G1 X91.749 Y87.419 E.05466
G1 X91.749 Y86.838 E.01169
G1 X91.942 Y86.789 E.00399
G1 X92.031 Y86.955 E.00379
G1 X92.031 Y93.045 E.12244
G1 X91.942 Y93.211 E.00379
G1 X91.749 Y93.162 E.00399
G1 X91.749 Y92.581 E.01169
G1 X89.031 Y92.581 E.05466
G1 X89.031 Y100.181 E.15282
G1 X87.969 Y100.181 E.02134
G1 X87.969 Y79.819 E.40942
G1 X89.031 Y79.819 E.02134
G1 X89.031 Y86.95 E.14338
M204 S250
G1 X89.44 Y87.01 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1484
M204 S5000
G1 X91.34 Y87.01 E.0355
G1 X91.34 Y85.61 E.02616
G1 X91.774 Y85.61 E.00811
G1 X92.44 Y86.853 E.02634
G1 X92.44 Y93.147 E.11762
G1 X91.774 Y94.39 E.02634
G1 X91.34 Y94.39 E.00811
G1 X91.34 Y92.99 E.02616
G1 X89.44 Y92.99 E.0355
G1 X89.44 Y100.59 E.14201
G1 X87.56 Y100.59 E.03513
G1 X87.56 Y79.41 E.39576
G1 X89.44 Y79.41 E.03513
G1 X89.44 Y86.95 E.14089
; WIPE_START
G1 F1800
M204 S6000
G1 X91.34 Y87.01 E-.27089
G1 X91.34 Y86.911 E-.01411
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
            G0 Z6.96 F4000
            G39.3 S1
            G0 Z6.96 F4000
            G392 S0
          
        M623
    
    M623
M623
; SKIPPABLE_END




G1 X88.5 Y87.631
M73 P68 R7
G1 Z6.56
G1 E.3 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.663042
G1 F1484
M204 S6000
G1 X88.5 Y80.031 E.22955
; WIPE_START
G1 F2400
G1 X88.5 Y82.031 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X89.824 Y89.548 Z6.96 F18000
G1 X90 Y90.55 Z6.96
G1 Z6.56
G1 E.3 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.449132
G1 F1484
M204 S6000
G1 X90 Y89.51 E.02087
M204 S10000
G1 X90.409 Y89.45 F18000
; LINE_WIDTH: 0.419992
G1 F1484
M204 S6000
G1 X90.409 Y89.041 E.00764
G1 X89.591 Y89.041 E.01528
G1 X89.591 Y90.959 E.03583
G1 X90.409 Y90.959 E.01528
G1 X90.409 Y89.51 E.02707
M204 S10000
G1 X90.803 Y89.45 F18000
G1 F1484
M204 S6000
G1 X90.803 Y88.647 E.01501
G1 X89.197 Y88.647 E.03001
G1 X89.197 Y91.353 E.05056
G1 X90.803 Y91.353 E.03001
G1 X90.803 Y89.51 E.03444
M204 S10000
G1 X91.197 Y89.45 F18000
G1 F1484
M204 S6000
G1 X91.197 Y88.253 E.02237
G1 X88.803 Y88.253 E.04474
G1 X88.803 Y91.747 E.0653
G1 X91.197 Y91.747 E.04474
G1 X91.197 Y89.51 E.0418
; WIPE_START
G1 F4800
G1 X91.197 Y91.51 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X88.5 Y92.369 Z6.96 F18000
G1 Z6.56
G1 E.3 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.663042
G1 F1484
M204 S6000
G1 X88.5 Y99.969 E.22955
; CHANGE_LAYER
; Z_HEIGHT: 6.68
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F2400
G1 X88.5 Y97.969 E-.285
; WIPE_END
G1 E-.015 F1800
; layer num/total_layer_count: 61/102
; update layer progress
M73 L61
M991 S0 P60 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z6.96 I1.217 J.013 P1  F18000
G1 X88.607 Y87.843 Z6.96
G1 Z6.68
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1484
M204 S6000
G1 X91.607 Y87.843 E.06032
G1 X91.607 Y92.157 E.08672
G1 X88.393 Y92.157 E.06461
G1 X88.393 Y87.843 E.08672
G1 X88.547 Y87.843 E.00308
M204 S10000
G1 X89.031 Y87.01 F18000
G1 F1484
M204 S6000
G1 X89.031 Y87.419 E.00823
G1 X91.749 Y87.419 E.05466
G1 X91.749 Y86.838 E.01169
G1 X91.942 Y86.789 E.00399
G1 X92.031 Y86.955 E.00379
G1 X92.031 Y93.045 E.12244
G1 X91.942 Y93.211 E.00379
G1 X91.749 Y93.162 E.00399
G1 X91.749 Y92.581 E.01169
G1 X89.031 Y92.581 E.05466
G1 X89.031 Y100.181 E.15282
G1 X87.969 Y100.181 E.02134
G1 X87.969 Y79.819 E.40942
G1 X89.031 Y79.819 E.02134
G1 X89.031 Y86.95 E.14338
M204 S250
G1 X89.44 Y87.01 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1484
M204 S5000
G1 X91.34 Y87.01 E.0355
G1 X91.34 Y85.61 E.02616
G1 X91.774 Y85.61 E.00811
G1 X92.44 Y86.853 E.02634
G1 X92.44 Y93.147 E.11762
G1 X91.774 Y94.39 E.02634
G1 X91.34 Y94.39 E.00811
G1 X91.34 Y92.99 E.02616
G1 X89.44 Y92.99 E.0355
G1 X89.44 Y100.59 E.14201
G1 X87.56 Y100.59 E.03513
G1 X87.56 Y79.41 E.39576
G1 X89.44 Y79.41 E.03513
G1 X89.44 Y86.95 E.14089
; WIPE_START
G1 F1800
M204 S6000
G1 X91.34 Y87.01 E-.27089
G1 X91.34 Y86.911 E-.01411
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
            G0 Z7.08 F4000
            G39.3 S1
            G0 Z7.08 F4000
            G392 S0
          
        M623
    
    M623
M623
; SKIPPABLE_END




G1 X88.5 Y87.631
G1 Z6.68
G1 E.3 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.663042
G1 F1484
M204 S6000
G1 X88.5 Y80.031 E.22955
; WIPE_START
G1 F2400
G1 X88.5 Y82.031 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X89.824 Y89.548 Z7.08 F18000
G1 X90 Y90.55 Z7.08
G1 Z6.68
G1 E.3 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.449132
G1 F1484
M204 S6000
G1 X90 Y89.51 E.02087
M204 S10000
G1 X90.409 Y89.45 F18000
; LINE_WIDTH: 0.419992
G1 F1484
M204 S6000
G1 X90.409 Y89.041 E.00764
G1 X89.591 Y89.041 E.01528
G1 X89.591 Y90.959 E.03583
G1 X90.409 Y90.959 E.01528
G1 X90.409 Y89.51 E.02707
M204 S10000
G1 X90.803 Y89.45 F18000
G1 F1484
M204 S6000
G1 X90.803 Y88.647 E.01501
G1 X89.197 Y88.647 E.03001
G1 X89.197 Y91.353 E.05056
G1 X90.803 Y91.353 E.03001
G1 X90.803 Y89.51 E.03444
M204 S10000
G1 X91.197 Y89.45 F18000
G1 F1484
M204 S6000
G1 X91.197 Y88.253 E.02237
G1 X88.803 Y88.253 E.04474
G1 X88.803 Y91.747 E.0653
G1 X91.197 Y91.747 E.04474
G1 X91.197 Y89.51 E.0418
; WIPE_START
G1 F4800
G1 X91.197 Y91.51 E-.285
; WIPE_END
M73 P69 R7
G1 E-.015 F1800
M204 S10000
G1 X88.5 Y92.369 Z7.08 F18000
G1 Z6.68
G1 E.3 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.663042
G1 F1484
M204 S6000
G1 X88.5 Y99.969 E.22955
; CHANGE_LAYER
; Z_HEIGHT: 6.8
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F2400
G1 X88.5 Y97.969 E-.285
; WIPE_END
G1 E-.015 F1800
; layer num/total_layer_count: 62/102
; update layer progress
M73 L62
M991 S0 P61 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z7.08 I1.217 J.013 P1  F18000
G1 X88.607 Y87.843 Z7.08
G1 Z6.8
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1484
M204 S6000
G1 X91.607 Y87.843 E.06032
G1 X91.607 Y92.157 E.08672
G1 X88.393 Y92.157 E.06461
G1 X88.393 Y87.843 E.08672
G1 X88.547 Y87.843 E.00308
M204 S10000
G1 X89.031 Y87.01 F18000
G1 F1484
M204 S6000
G1 X89.031 Y87.419 E.00823
G1 X91.749 Y87.419 E.05466
G1 X91.749 Y86.838 E.01169
G1 X91.942 Y86.789 E.00399
G1 X92.031 Y86.955 E.00379
G1 X92.031 Y93.045 E.12244
G1 X91.942 Y93.211 E.00379
G1 X91.749 Y93.162 E.00399
G1 X91.749 Y92.581 E.01169
G1 X89.031 Y92.581 E.05466
G1 X89.031 Y100.181 E.15282
G1 X87.969 Y100.181 E.02134
G1 X87.969 Y79.819 E.40942
G1 X89.031 Y79.819 E.02134
G1 X89.031 Y86.95 E.14338
M204 S250
G1 X89.44 Y87.01 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1484
M204 S5000
G1 X91.34 Y87.01 E.0355
G1 X91.34 Y85.61 E.02616
G1 X91.774 Y85.61 E.00811
G1 X92.44 Y86.853 E.02634
G1 X92.44 Y93.147 E.11762
G1 X91.774 Y94.39 E.02634
G1 X91.34 Y94.39 E.00811
G1 X91.34 Y92.99 E.02616
G1 X89.44 Y92.99 E.0355
G1 X89.44 Y100.59 E.14201
G1 X87.56 Y100.59 E.03513
G1 X87.56 Y79.41 E.39576
G1 X89.44 Y79.41 E.03513
G1 X89.44 Y86.95 E.14089
; WIPE_START
G1 F1800
M204 S6000
G1 X91.34 Y87.01 E-.27089
G1 X91.34 Y86.911 E-.01411
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
            G0 Z7.2 F4000
            G39.3 S1
            G0 Z7.2 F4000
            G392 S0
          
        M623
    
    M623
M623
; SKIPPABLE_END




G1 X88.5 Y87.631
G1 Z6.8
G1 E.3 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.663042
G1 F1484
M204 S6000
G1 X88.5 Y80.031 E.22955
; WIPE_START
G1 F2400
G1 X88.5 Y82.031 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X89.824 Y89.548 Z7.2 F18000
G1 X90 Y90.55 Z7.2
G1 Z6.8
G1 E.3 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.449132
G1 F1484
M204 S6000
G1 X90 Y89.51 E.02087
M204 S10000
G1 X90.409 Y89.45 F18000
; LINE_WIDTH: 0.419992
G1 F1484
M204 S6000
G1 X90.409 Y89.041 E.00764
G1 X89.591 Y89.041 E.01528
G1 X89.591 Y90.959 E.03583
G1 X90.409 Y90.959 E.01528
G1 X90.409 Y89.51 E.02707
M204 S10000
G1 X90.803 Y89.45 F18000
G1 F1484
M204 S6000
G1 X90.803 Y88.647 E.01501
G1 X89.197 Y88.647 E.03001
G1 X89.197 Y91.353 E.05056
G1 X90.803 Y91.353 E.03001
G1 X90.803 Y89.51 E.03444
M204 S10000
G1 X91.197 Y89.45 F18000
G1 F1484
M204 S6000
G1 X91.197 Y88.253 E.02237
G1 X88.803 Y88.253 E.04474
G1 X88.803 Y91.747 E.0653
G1 X91.197 Y91.747 E.04474
G1 X91.197 Y89.51 E.0418
; WIPE_START
G1 F4800
G1 X91.197 Y91.51 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X88.5 Y92.369 Z7.2 F18000
G1 Z6.8
G1 E.3 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.663042
M73 P69 R6
G1 F1484
M204 S6000
G1 X88.5 Y99.969 E.22955
; CHANGE_LAYER
; Z_HEIGHT: 6.92
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F2400
G1 X88.5 Y97.969 E-.285
; WIPE_END
G1 E-.015 F1800
; layer num/total_layer_count: 63/102
; update layer progress
M73 L63
M991 S0 P62 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z7.2 I1.217 J.013 P1  F18000
G1 X88.607 Y87.843 Z7.2
G1 Z6.92
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1484
M204 S6000
G1 X91.607 Y87.843 E.06032
G1 X91.607 Y92.157 E.08672
G1 X88.393 Y92.157 E.06461
G1 X88.393 Y87.843 E.08672
G1 X88.547 Y87.843 E.00308
M204 S10000
G1 X89.031 Y87.01 F18000
G1 F1484
M204 S6000
G1 X89.031 Y87.419 E.00823
G1 X91.749 Y87.419 E.05466
G1 X91.749 Y86.838 E.01169
G1 X91.942 Y86.789 E.00399
G1 X92.031 Y86.955 E.00379
G1 X92.031 Y93.045 E.12244
G1 X91.942 Y93.211 E.00379
G1 X91.749 Y93.162 E.00399
G1 X91.749 Y92.581 E.01169
G1 X89.031 Y92.581 E.05466
G1 X89.031 Y100.181 E.15282
G1 X87.969 Y100.181 E.02134
G1 X87.969 Y79.819 E.40942
G1 X89.031 Y79.819 E.02134
G1 X89.031 Y86.95 E.14338
M204 S250
G1 X89.44 Y87.01 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1484
M204 S5000
G1 X91.34 Y87.01 E.0355
M73 P70 R6
G1 X91.34 Y85.61 E.02616
G1 X91.774 Y85.61 E.00811
G1 X92.44 Y86.853 E.02634
G1 X92.44 Y93.147 E.11762
G1 X91.774 Y94.39 E.02634
G1 X91.34 Y94.39 E.00811
G1 X91.34 Y92.99 E.02616
G1 X89.44 Y92.99 E.0355
G1 X89.44 Y100.59 E.14201
G1 X87.56 Y100.59 E.03513
G1 X87.56 Y79.41 E.39576
G1 X89.44 Y79.41 E.03513
G1 X89.44 Y86.95 E.14089
; WIPE_START
G1 F1800
M204 S6000
G1 X91.34 Y87.01 E-.27089
G1 X91.34 Y86.911 E-.01411
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
            G0 Z7.32 F4000
            G39.3 S1
            G0 Z7.32 F4000
            G392 S0
          
        M623
    
    M623
M623
; SKIPPABLE_END




G1 X88.5 Y87.631
G1 Z6.92
G1 E.3 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.663042
G1 F1484
M204 S6000
G1 X88.5 Y80.031 E.22955
; WIPE_START
G1 F2400
G1 X88.5 Y82.031 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X89.824 Y89.548 Z7.32 F18000
G1 X90 Y90.55 Z7.32
G1 Z6.92
G1 E.3 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.449132
G1 F1484
M204 S6000
G1 X90 Y89.51 E.02087
M204 S10000
G1 X90.409 Y89.45 F18000
; LINE_WIDTH: 0.419992
G1 F1484
M204 S6000
G1 X90.409 Y89.041 E.00764
G1 X89.591 Y89.041 E.01528
G1 X89.591 Y90.959 E.03583
G1 X90.409 Y90.959 E.01528
G1 X90.409 Y89.51 E.02707
M204 S10000
G1 X90.803 Y89.45 F18000
G1 F1484
M204 S6000
G1 X90.803 Y88.647 E.01501
G1 X89.197 Y88.647 E.03001
G1 X89.197 Y91.353 E.05056
G1 X90.803 Y91.353 E.03001
G1 X90.803 Y89.51 E.03444
M204 S10000
G1 X91.197 Y89.45 F18000
G1 F1484
M204 S6000
G1 X91.197 Y88.253 E.02237
G1 X88.803 Y88.253 E.04474
G1 X88.803 Y91.747 E.0653
G1 X91.197 Y91.747 E.04474
G1 X91.197 Y89.51 E.0418
; WIPE_START
G1 F4800
G1 X91.197 Y91.51 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X88.5 Y92.369 Z7.32 F18000
G1 Z6.92
G1 E.3 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.663042
G1 F1484
M204 S6000
G1 X88.5 Y99.969 E.22955
; CHANGE_LAYER
; Z_HEIGHT: 7.04
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F2400
G1 X88.5 Y97.969 E-.285
; WIPE_END
G1 E-.015 F1800
; layer num/total_layer_count: 64/102
; update layer progress
M73 L64
M991 S0 P63 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z7.32 I1.217 J.013 P1  F18000
G1 X88.607 Y87.843 Z7.32
G1 Z7.04
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1484
M204 S6000
G1 X91.607 Y87.843 E.06032
G1 X91.607 Y92.157 E.08672
G1 X88.393 Y92.157 E.06461
G1 X88.393 Y87.843 E.08672
G1 X88.547 Y87.843 E.00308
M204 S10000
G1 X89.031 Y87.01 F18000
G1 F1484
M204 S6000
G1 X89.031 Y87.419 E.00823
G1 X91.749 Y87.419 E.05466
G1 X91.749 Y86.838 E.01169
G1 X91.942 Y86.789 E.00399
G1 X92.031 Y86.955 E.00379
G1 X92.031 Y93.045 E.12244
G1 X91.942 Y93.211 E.00379
G1 X91.749 Y93.162 E.00399
G1 X91.749 Y92.581 E.01169
G1 X89.031 Y92.581 E.05466
G1 X89.031 Y100.181 E.15282
G1 X87.969 Y100.181 E.02134
G1 X87.969 Y79.819 E.40942
G1 X89.031 Y79.819 E.02134
G1 X89.031 Y86.95 E.14338
M204 S250
G1 X89.44 Y87.01 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1484
M204 S5000
G1 X91.34 Y87.01 E.0355
G1 X91.34 Y85.61 E.02616
G1 X91.774 Y85.61 E.00811
G1 X92.44 Y86.853 E.02634
G1 X92.44 Y93.147 E.11762
G1 X91.774 Y94.39 E.02634
G1 X91.34 Y94.39 E.00811
G1 X91.34 Y92.99 E.02616
G1 X89.44 Y92.99 E.0355
G1 X89.44 Y100.59 E.14201
G1 X87.56 Y100.59 E.03513
G1 X87.56 Y79.41 E.39576
G1 X89.44 Y79.41 E.03513
G1 X89.44 Y86.95 E.14089
; WIPE_START
G1 F1800
M204 S6000
G1 X91.34 Y87.01 E-.27089
G1 X91.34 Y86.911 E-.01411
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
            G0 Z7.44 F4000
            G39.3 S1
            G0 Z7.44 F4000
            G392 S0
          
        M623
    
    M623
M623
; SKIPPABLE_END




G1 X88.5 Y87.631
G1 Z7.04
G1 E.3 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.663042
G1 F1484
M204 S6000
G1 X88.5 Y80.031 E.22955
; WIPE_START
G1 F2400
G1 X88.5 Y82.031 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X89.824 Y89.548 Z7.44 F18000
G1 X90 Y90.55 Z7.44
G1 Z7.04
G1 E.3 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.449132
G1 F1484
M204 S6000
G1 X90 Y89.51 E.02087
M204 S10000
G1 X90.409 Y89.45 F18000
; LINE_WIDTH: 0.419992
G1 F1484
M204 S6000
G1 X90.409 Y89.041 E.00764
G1 X89.591 Y89.041 E.01528
G1 X89.591 Y90.959 E.03583
G1 X90.409 Y90.959 E.01528
G1 X90.409 Y89.51 E.02707
M204 S10000
G1 X90.803 Y89.45 F18000
G1 F1484
M204 S6000
G1 X90.803 Y88.647 E.01501
G1 X89.197 Y88.647 E.03001
G1 X89.197 Y91.353 E.05056
G1 X90.803 Y91.353 E.03001
G1 X90.803 Y89.51 E.03444
M204 S10000
G1 X91.197 Y89.45 F18000
M73 P71 R6
G1 F1484
M204 S6000
G1 X91.197 Y88.253 E.02237
G1 X88.803 Y88.253 E.04474
G1 X88.803 Y91.747 E.0653
G1 X91.197 Y91.747 E.04474
G1 X91.197 Y89.51 E.0418
; WIPE_START
G1 F4800
G1 X91.197 Y91.51 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X88.5 Y92.369 Z7.44 F18000
G1 Z7.04
G1 E.3 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.663042
G1 F1484
M204 S6000
G1 X88.5 Y99.969 E.22955
; CHANGE_LAYER
; Z_HEIGHT: 7.16
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F2400
G1 X88.5 Y97.969 E-.285
; WIPE_END
G1 E-.015 F1800
; layer num/total_layer_count: 65/102
; update layer progress
M73 L65
M991 S0 P64 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z7.44 I1.217 J.013 P1  F18000
G1 X88.607 Y87.843 Z7.44
G1 Z7.16
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1484
M204 S6000
G1 X91.607 Y87.843 E.06032
G1 X91.607 Y92.157 E.08672
G1 X88.393 Y92.157 E.06461
G1 X88.393 Y87.843 E.08672
G1 X88.547 Y87.843 E.00308
M204 S10000
G1 X89.031 Y87.01 F18000
G1 F1484
M204 S6000
G1 X89.031 Y87.419 E.00823
G1 X91.749 Y87.419 E.05466
G1 X91.749 Y86.838 E.01169
G1 X91.942 Y86.789 E.00399
G1 X92.031 Y86.955 E.00379
G1 X92.031 Y93.045 E.12244
G1 X91.942 Y93.211 E.00379
G1 X91.749 Y93.162 E.00399
G1 X91.749 Y92.581 E.01169
G1 X89.031 Y92.581 E.05466
G1 X89.031 Y100.181 E.15282
G1 X87.969 Y100.181 E.02134
G1 X87.969 Y79.819 E.40942
G1 X89.031 Y79.819 E.02134
G1 X89.031 Y86.95 E.14338
M204 S250
G1 X89.44 Y87.01 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1484
M204 S5000
G1 X91.34 Y87.01 E.0355
G1 X91.34 Y85.61 E.02616
G1 X91.774 Y85.61 E.00811
G1 X92.44 Y86.853 E.02634
G1 X92.44 Y93.147 E.11762
G1 X91.774 Y94.39 E.02634
G1 X91.34 Y94.39 E.00811
G1 X91.34 Y92.99 E.02616
G1 X89.44 Y92.99 E.0355
G1 X89.44 Y100.59 E.14201
G1 X87.56 Y100.59 E.03513
G1 X87.56 Y79.41 E.39576
G1 X89.44 Y79.41 E.03513
G1 X89.44 Y86.95 E.14089
; WIPE_START
G1 F1800
M204 S6000
G1 X91.34 Y87.01 E-.27089
G1 X91.34 Y86.911 E-.01411
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
            G0 Z7.56 F4000
            G39.3 S1
            G0 Z7.56 F4000
            G392 S0
          
        M623
    
    M623
M623
; SKIPPABLE_END




G1 X88.5 Y87.631
G1 Z7.16
G1 E.3 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.663042
G1 F1484
M204 S6000
G1 X88.5 Y80.031 E.22955
; WIPE_START
G1 F2400
G1 X88.5 Y82.031 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X89.824 Y89.548 Z7.56 F18000
G1 X90 Y90.55 Z7.56
G1 Z7.16
G1 E.3 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.449132
G1 F1484
M204 S6000
G1 X90 Y89.51 E.02087
M204 S10000
G1 X90.409 Y89.45 F18000
; LINE_WIDTH: 0.419992
G1 F1484
M204 S6000
G1 X90.409 Y89.041 E.00764
G1 X89.591 Y89.041 E.01528
G1 X89.591 Y90.959 E.03583
G1 X90.409 Y90.959 E.01528
G1 X90.409 Y89.51 E.02707
M204 S10000
G1 X90.803 Y89.45 F18000
G1 F1484
M204 S6000
G1 X90.803 Y88.647 E.01501
G1 X89.197 Y88.647 E.03001
G1 X89.197 Y91.353 E.05056
G1 X90.803 Y91.353 E.03001
G1 X90.803 Y89.51 E.03444
M204 S10000
G1 X91.197 Y89.45 F18000
G1 F1484
M204 S6000
G1 X91.197 Y88.253 E.02237
G1 X88.803 Y88.253 E.04474
G1 X88.803 Y91.747 E.0653
G1 X91.197 Y91.747 E.04474
G1 X91.197 Y89.51 E.0418
; WIPE_START
G1 F4800
G1 X91.197 Y91.51 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X88.5 Y92.369 Z7.56 F18000
G1 Z7.16
G1 E.3 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.663042
G1 F1484
M204 S6000
G1 X88.5 Y99.969 E.22955
; CHANGE_LAYER
; Z_HEIGHT: 7.28
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F2400
G1 X88.5 Y97.969 E-.285
; WIPE_END
G1 E-.015 F1800
; layer num/total_layer_count: 66/102
; update layer progress
M73 L66
M991 S0 P65 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z7.56 I1.217 J.013 P1  F18000
G1 X88.607 Y87.843 Z7.56
G1 Z7.28
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1484
M204 S6000
G1 X91.607 Y87.843 E.06032
G1 X91.607 Y92.157 E.08672
G1 X88.393 Y92.157 E.06461
G1 X88.393 Y87.843 E.08672
G1 X88.547 Y87.843 E.00308
M204 S10000
G1 X89.031 Y87.01 F18000
G1 F1484
M204 S6000
G1 X89.031 Y87.419 E.00823
M73 P72 R6
G1 X91.749 Y87.419 E.05466
G1 X91.749 Y86.838 E.01169
G1 X91.942 Y86.789 E.00399
G1 X92.031 Y86.955 E.00379
G1 X92.031 Y93.045 E.12244
G1 X91.942 Y93.211 E.00379
G1 X91.749 Y93.162 E.00399
G1 X91.749 Y92.581 E.01169
G1 X89.031 Y92.581 E.05466
G1 X89.031 Y100.181 E.15282
G1 X87.969 Y100.181 E.02134
G1 X87.969 Y79.819 E.40942
G1 X89.031 Y79.819 E.02134
G1 X89.031 Y86.95 E.14338
M204 S250
G1 X89.44 Y87.01 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1484
M204 S5000
G1 X91.34 Y87.01 E.0355
G1 X91.34 Y85.61 E.02616
G1 X91.774 Y85.61 E.00811
G1 X92.44 Y86.853 E.02634
G1 X92.44 Y93.147 E.11762
G1 X91.774 Y94.39 E.02634
G1 X91.34 Y94.39 E.00811
G1 X91.34 Y92.99 E.02616
G1 X89.44 Y92.99 E.0355
G1 X89.44 Y100.59 E.14201
G1 X87.56 Y100.59 E.03513
G1 X87.56 Y79.41 E.39576
G1 X89.44 Y79.41 E.03513
G1 X89.44 Y86.95 E.14089
; WIPE_START
G1 F1800
M204 S6000
G1 X91.34 Y87.01 E-.27089
G1 X91.34 Y86.911 E-.01411
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
            G0 Z7.68 F4000
            G39.3 S1
            G0 Z7.68 F4000
            G392 S0
          
        M623
    
    M623
M623
; SKIPPABLE_END




G1 X88.5 Y87.631
G1 Z7.28
G1 E.3 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.663042
G1 F1484
M204 S6000
G1 X88.5 Y80.031 E.22955
; WIPE_START
G1 F2400
G1 X88.5 Y82.031 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X89.824 Y89.548 Z7.68 F18000
G1 X90 Y90.55 Z7.68
G1 Z7.28
G1 E.3 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.449132
G1 F1484
M204 S6000
G1 X90 Y89.51 E.02087
M204 S10000
G1 X90.409 Y89.45 F18000
; LINE_WIDTH: 0.419992
G1 F1484
M204 S6000
G1 X90.409 Y89.041 E.00764
G1 X89.591 Y89.041 E.01528
G1 X89.591 Y90.959 E.03583
G1 X90.409 Y90.959 E.01528
G1 X90.409 Y89.51 E.02707
M204 S10000
G1 X90.803 Y89.45 F18000
G1 F1484
M204 S6000
G1 X90.803 Y88.647 E.01501
G1 X89.197 Y88.647 E.03001
G1 X89.197 Y91.353 E.05056
G1 X90.803 Y91.353 E.03001
G1 X90.803 Y89.51 E.03444
M204 S10000
G1 X91.197 Y89.45 F18000
G1 F1484
M204 S6000
G1 X91.197 Y88.253 E.02237
G1 X88.803 Y88.253 E.04474
G1 X88.803 Y91.747 E.0653
G1 X91.197 Y91.747 E.04474
G1 X91.197 Y89.51 E.0418
; WIPE_START
G1 F4800
G1 X91.197 Y91.51 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X88.5 Y92.369 Z7.68 F18000
G1 Z7.28
G1 E.3 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.663042
G1 F1484
M204 S6000
G1 X88.5 Y99.969 E.22955
; CHANGE_LAYER
; Z_HEIGHT: 7.4
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F2400
G1 X88.5 Y97.969 E-.285
; WIPE_END
G1 E-.015 F1800
; layer num/total_layer_count: 67/102
; update layer progress
M73 L67
M991 S0 P66 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z7.68 I1.217 J.013 P1  F18000
G1 X88.607 Y87.843 Z7.68
G1 Z7.4
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1484
M204 S6000
G1 X91.607 Y87.843 E.06032
G1 X91.607 Y92.157 E.08672
G1 X88.393 Y92.157 E.06461
G1 X88.393 Y87.843 E.08672
G1 X88.547 Y87.843 E.00308
M204 S10000
G1 X89.031 Y87.01 F18000
G1 F1484
M204 S6000
G1 X89.031 Y87.419 E.00823
G1 X91.749 Y87.419 E.05466
G1 X91.749 Y86.838 E.01169
G1 X91.942 Y86.789 E.00399
G1 X92.031 Y86.955 E.00379
G1 X92.031 Y93.045 E.12244
G1 X91.942 Y93.211 E.00379
G1 X91.749 Y93.162 E.00399
G1 X91.749 Y92.581 E.01169
G1 X89.031 Y92.581 E.05466
G1 X89.031 Y100.181 E.15282
G1 X87.969 Y100.181 E.02134
G1 X87.969 Y79.819 E.40942
G1 X89.031 Y79.819 E.02134
G1 X89.031 Y86.95 E.14338
M204 S250
G1 X89.44 Y87.01 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1484
M204 S5000
G1 X91.34 Y87.01 E.0355
G1 X91.34 Y85.61 E.02616
G1 X91.774 Y85.61 E.00811
G1 X92.44 Y86.853 E.02634
G1 X92.44 Y93.147 E.11762
G1 X91.774 Y94.39 E.02634
G1 X91.34 Y94.39 E.00811
G1 X91.34 Y92.99 E.02616
G1 X89.44 Y92.99 E.0355
G1 X89.44 Y100.59 E.14201
G1 X87.56 Y100.59 E.03513
G1 X87.56 Y79.41 E.39576
G1 X89.44 Y79.41 E.03513
G1 X89.44 Y86.95 E.14089
; WIPE_START
G1 F1800
M204 S6000
G1 X91.34 Y87.01 E-.27089
G1 X91.34 Y86.911 E-.01411
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
            G0 Z7.8 F4000
            G39.3 S1
            G0 Z7.8 F4000
            G392 S0
          
        M623
    
    M623
M623
; SKIPPABLE_END




G1 X88.5 Y87.631
G1 Z7.4
G1 E.3 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.663042
G1 F1484
M204 S6000
G1 X88.5 Y80.031 E.22955
; WIPE_START
G1 F2400
G1 X88.5 Y82.031 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X89.824 Y89.548 Z7.8 F18000
G1 X90 Y90.55 Z7.8
G1 Z7.4
G1 E.3 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.449132
G1 F1484
M204 S6000
G1 X90 Y89.51 E.02087
M204 S10000
G1 X90.409 Y89.45 F18000
; LINE_WIDTH: 0.419992
G1 F1484
M204 S6000
G1 X90.409 Y89.041 E.00764
G1 X89.591 Y89.041 E.01528
G1 X89.591 Y90.959 E.03583
G1 X90.409 Y90.959 E.01528
G1 X90.409 Y89.51 E.02707
M204 S10000
G1 X90.803 Y89.45 F18000
G1 F1484
M204 S6000
G1 X90.803 Y88.647 E.01501
G1 X89.197 Y88.647 E.03001
G1 X89.197 Y91.353 E.05056
G1 X90.803 Y91.353 E.03001
G1 X90.803 Y89.51 E.03444
M204 S10000
M73 P73 R6
G1 X91.197 Y89.45 F18000
G1 F1484
M204 S6000
G1 X91.197 Y88.253 E.02237
G1 X88.803 Y88.253 E.04474
G1 X88.803 Y91.747 E.0653
G1 X91.197 Y91.747 E.04474
G1 X91.197 Y89.51 E.0418
; WIPE_START
G1 F4800
G1 X91.197 Y91.51 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X88.5 Y92.369 Z7.8 F18000
G1 Z7.4
G1 E.3 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.663042
G1 F1484
M204 S6000
G1 X88.5 Y99.969 E.22955
; CHANGE_LAYER
; Z_HEIGHT: 7.52
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F2400
G1 X88.5 Y97.969 E-.285
; WIPE_END
G1 E-.015 F1800
; layer num/total_layer_count: 68/102
; update layer progress
M73 L68
M991 S0 P67 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z7.8 I1.217 J.013 P1  F18000
G1 X88.607 Y87.843 Z7.8
G1 Z7.52
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1484
M204 S6000
G1 X91.607 Y87.843 E.06032
G1 X91.607 Y92.157 E.08672
G1 X88.393 Y92.157 E.06461
G1 X88.393 Y87.843 E.08672
G1 X88.547 Y87.843 E.00308
M204 S10000
G1 X89.031 Y87.01 F18000
G1 F1484
M204 S6000
G1 X89.031 Y87.419 E.00823
G1 X91.749 Y87.419 E.05466
G1 X91.749 Y86.838 E.01169
G1 X91.942 Y86.789 E.00399
G1 X92.031 Y86.955 E.00379
G1 X92.031 Y93.045 E.12244
G1 X91.942 Y93.211 E.00379
G1 X91.749 Y93.162 E.00399
G1 X91.749 Y92.581 E.01169
G1 X89.031 Y92.581 E.05466
G1 X89.031 Y100.181 E.15282
G1 X87.969 Y100.181 E.02134
G1 X87.969 Y79.819 E.40942
G1 X89.031 Y79.819 E.02134
G1 X89.031 Y86.95 E.14338
M204 S250
G1 X89.44 Y87.01 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1484
M204 S5000
G1 X91.34 Y87.01 E.0355
G1 X91.34 Y85.61 E.02616
G1 X91.774 Y85.61 E.00811
G1 X92.44 Y86.853 E.02634
G1 X92.44 Y93.147 E.11762
G1 X91.774 Y94.39 E.02634
G1 X91.34 Y94.39 E.00811
G1 X91.34 Y92.99 E.02616
G1 X89.44 Y92.99 E.0355
G1 X89.44 Y100.59 E.14201
G1 X87.56 Y100.59 E.03513
G1 X87.56 Y79.41 E.39576
G1 X89.44 Y79.41 E.03513
G1 X89.44 Y86.95 E.14089
; WIPE_START
G1 F1800
M204 S6000
G1 X91.34 Y87.01 E-.27089
G1 X91.34 Y86.911 E-.01411
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
            G0 Z7.92 F4000
            G39.3 S1
            G0 Z7.92 F4000
            G392 S0
          
        M623
    
    M623
M623
; SKIPPABLE_END




G1 X88.5 Y87.631
G1 Z7.52
G1 E.3 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.663042
G1 F1484
M204 S6000
G1 X88.5 Y80.031 E.22955
; WIPE_START
G1 F2400
G1 X88.5 Y82.031 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X89.824 Y89.548 Z7.92 F18000
G1 X90 Y90.55 Z7.92
G1 Z7.52
G1 E.3 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.449132
G1 F1484
M204 S6000
G1 X90 Y89.51 E.02087
M204 S10000
G1 X90.409 Y89.45 F18000
; LINE_WIDTH: 0.419992
G1 F1484
M204 S6000
G1 X90.409 Y89.041 E.00764
G1 X89.591 Y89.041 E.01528
G1 X89.591 Y90.959 E.03583
G1 X90.409 Y90.959 E.01528
G1 X90.409 Y89.51 E.02707
M204 S10000
G1 X90.803 Y89.45 F18000
G1 F1484
M204 S6000
G1 X90.803 Y88.647 E.01501
G1 X89.197 Y88.647 E.03001
G1 X89.197 Y91.353 E.05056
G1 X90.803 Y91.353 E.03001
G1 X90.803 Y89.51 E.03444
M204 S10000
G1 X91.197 Y89.45 F18000
G1 F1484
M204 S6000
G1 X91.197 Y88.253 E.02237
G1 X88.803 Y88.253 E.04474
G1 X88.803 Y91.747 E.0653
G1 X91.197 Y91.747 E.04474
G1 X91.197 Y89.51 E.0418
; WIPE_START
G1 F4800
G1 X91.197 Y91.51 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X88.5 Y92.369 Z7.92 F18000
G1 Z7.52
G1 E.3 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.663042
G1 F1484
M204 S6000
G1 X88.5 Y99.969 E.22955
; CHANGE_LAYER
; Z_HEIGHT: 7.64
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F2400
G1 X88.5 Y97.969 E-.285
; WIPE_END
G1 E-.015 F1800
; layer num/total_layer_count: 69/102
; update layer progress
M73 L69
M991 S0 P68 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z7.92 I1.217 J.013 P1  F18000
G1 X88.607 Y87.843 Z7.92
G1 Z7.64
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1484
M204 S6000
G1 X91.607 Y87.843 E.06032
G1 X91.607 Y92.157 E.08672
G1 X88.393 Y92.157 E.06461
G1 X88.393 Y87.843 E.08672
G1 X88.547 Y87.843 E.00308
M204 S10000
G1 X89.031 Y87.01 F18000
G1 F1484
M204 S6000
M73 P74 R6
G1 X89.031 Y87.419 E.00823
G1 X91.749 Y87.419 E.05466
G1 X91.749 Y86.838 E.01169
G1 X91.942 Y86.789 E.00399
M73 P74 R5
G1 X92.031 Y86.955 E.00379
G1 X92.031 Y93.045 E.12244
G1 X91.942 Y93.211 E.00379
G1 X91.749 Y93.162 E.00399
G1 X91.749 Y92.581 E.01169
G1 X89.031 Y92.581 E.05466
G1 X89.031 Y100.181 E.15282
G1 X87.969 Y100.181 E.02134
G1 X87.969 Y79.819 E.40942
G1 X89.031 Y79.819 E.02134
G1 X89.031 Y86.95 E.14338
M204 S250
G1 X89.44 Y87.01 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1484
M204 S5000
G1 X91.34 Y87.01 E.0355
G1 X91.34 Y85.61 E.02616
G1 X91.774 Y85.61 E.00811
G1 X92.44 Y86.853 E.02634
G1 X92.44 Y93.147 E.11762
G1 X91.774 Y94.39 E.02634
G1 X91.34 Y94.39 E.00811
G1 X91.34 Y92.99 E.02616
G1 X89.44 Y92.99 E.0355
G1 X89.44 Y100.59 E.14201
G1 X87.56 Y100.59 E.03513
G1 X87.56 Y79.41 E.39576
G1 X89.44 Y79.41 E.03513
G1 X89.44 Y86.95 E.14089
; WIPE_START
G1 F1800
M204 S6000
G1 X91.34 Y87.01 E-.27089
G1 X91.34 Y86.911 E-.01411
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
            G0 Z8.04 F4000
            G39.3 S1
            G0 Z8.04 F4000
            G392 S0
          
        M623
    
    M623
M623
; SKIPPABLE_END




G1 X88.5 Y87.631
G1 Z7.64
G1 E.3 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.663042
G1 F1484
M204 S6000
G1 X88.5 Y80.031 E.22955
; WIPE_START
G1 F2400
G1 X88.5 Y82.031 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X89.824 Y89.548 Z8.04 F18000
G1 X90 Y90.55 Z8.04
G1 Z7.64
G1 E.3 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.449132
G1 F1484
M204 S6000
G1 X90 Y89.51 E.02087
M204 S10000
G1 X90.409 Y89.45 F18000
; LINE_WIDTH: 0.419992
G1 F1484
M204 S6000
G1 X90.409 Y89.041 E.00764
G1 X89.591 Y89.041 E.01528
G1 X89.591 Y90.959 E.03583
G1 X90.409 Y90.959 E.01528
G1 X90.409 Y89.51 E.02707
M204 S10000
G1 X90.803 Y89.45 F18000
G1 F1484
M204 S6000
G1 X90.803 Y88.647 E.01501
G1 X89.197 Y88.647 E.03001
G1 X89.197 Y91.353 E.05056
G1 X90.803 Y91.353 E.03001
G1 X90.803 Y89.51 E.03444
M204 S10000
G1 X91.197 Y89.45 F18000
G1 F1484
M204 S6000
G1 X91.197 Y88.253 E.02237
G1 X88.803 Y88.253 E.04474
G1 X88.803 Y91.747 E.0653
G1 X91.197 Y91.747 E.04474
G1 X91.197 Y89.51 E.0418
; WIPE_START
G1 F4800
G1 X91.197 Y91.51 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X88.5 Y92.369 Z8.04 F18000
G1 Z7.64
G1 E.3 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.663042
G1 F1484
M204 S6000
G1 X88.5 Y99.969 E.22955
; CHANGE_LAYER
; Z_HEIGHT: 7.76
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F2400
G1 X88.5 Y97.969 E-.285
; WIPE_END
G1 E-.015 F1800
; layer num/total_layer_count: 70/102
; update layer progress
M73 L70
M991 S0 P69 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z8.04 I1.217 J.013 P1  F18000
G1 X88.607 Y87.843 Z8.04
G1 Z7.76
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1484
M204 S6000
G1 X91.607 Y87.843 E.06032
G1 X91.607 Y92.157 E.08672
G1 X88.393 Y92.157 E.06461
G1 X88.393 Y87.843 E.08672
G1 X88.547 Y87.843 E.00308
M204 S10000
G1 X89.031 Y87.01 F18000
G1 F1484
M204 S6000
G1 X89.031 Y87.419 E.00823
G1 X91.749 Y87.419 E.05466
G1 X91.749 Y86.838 E.01169
G1 X91.942 Y86.789 E.00399
G1 X92.031 Y86.955 E.00379
G1 X92.031 Y93.045 E.12244
G1 X91.942 Y93.211 E.00379
G1 X91.749 Y93.162 E.00399
G1 X91.749 Y92.581 E.01169
G1 X89.031 Y92.581 E.05466
G1 X89.031 Y100.181 E.15282
G1 X87.969 Y100.181 E.02134
G1 X87.969 Y79.819 E.40942
G1 X89.031 Y79.819 E.02134
G1 X89.031 Y86.95 E.14338
M204 S250
G1 X89.44 Y87.01 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1484
M204 S5000
G1 X91.34 Y87.01 E.0355
G1 X91.34 Y85.61 E.02616
G1 X91.774 Y85.61 E.00811
G1 X92.44 Y86.853 E.02634
G1 X92.44 Y93.147 E.11762
G1 X91.774 Y94.39 E.02634
G1 X91.34 Y94.39 E.00811
G1 X91.34 Y92.99 E.02616
G1 X89.44 Y92.99 E.0355
G1 X89.44 Y100.59 E.14201
G1 X87.56 Y100.59 E.03513
G1 X87.56 Y79.41 E.39576
G1 X89.44 Y79.41 E.03513
G1 X89.44 Y86.95 E.14089
; WIPE_START
G1 F1800
M204 S6000
G1 X91.34 Y87.01 E-.27089
G1 X91.34 Y86.911 E-.01411
; WIPE_END
G1 E-.015
M204 S10000
G17
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
            G0 Z8.16 F4000
            G39.3 S1
            G0 Z8.16 F4000
            G392 S0
          
        M623
    
    M623
M623
; SKIPPABLE_END




G1 X88.5 Y87.631
G1 Z7.76
G1 E.3 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.663042
G1 F1484
M204 S6000
G1 X88.5 Y80.031 E.22955
; WIPE_START
G1 F2400
G1 X88.5 Y82.031 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X89.824 Y89.548 Z8.16 F18000
G1 X90 Y90.55 Z8.16
G1 Z7.76
M73 P75 R5
G1 E.3 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.449132
G1 F1484
M204 S6000
G1 X90 Y89.51 E.02087
M204 S10000
G1 X90.409 Y89.45 F18000
; LINE_WIDTH: 0.419992
G1 F1484
M204 S6000
G1 X90.409 Y89.041 E.00764
G1 X89.591 Y89.041 E.01528
G1 X89.591 Y90.959 E.03583
G1 X90.409 Y90.959 E.01528
G1 X90.409 Y89.51 E.02707
M204 S10000
G1 X90.803 Y89.45 F18000
G1 F1484
M204 S6000
G1 X90.803 Y88.647 E.01501
G1 X89.197 Y88.647 E.03001
G1 X89.197 Y91.353 E.05056
G1 X90.803 Y91.353 E.03001
G1 X90.803 Y89.51 E.03444
M204 S10000
G1 X91.197 Y89.45 F18000
G1 F1484
M204 S6000
G1 X91.197 Y88.253 E.02237
G1 X88.803 Y88.253 E.04474
G1 X88.803 Y91.747 E.0653
G1 X91.197 Y91.747 E.04474
G1 X91.197 Y89.51 E.0418
; WIPE_START
G1 F4800
G1 X91.197 Y91.51 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X88.5 Y92.369 Z8.16 F18000
G1 Z7.76
G1 E.3 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.663042
G1 F1484
M204 S6000
G1 X88.5 Y99.969 E.22955
; CHANGE_LAYER
; Z_HEIGHT: 7.88
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F2400
G1 X88.5 Y97.969 E-.285
; WIPE_END
G1 E-.015 F1800
; layer num/total_layer_count: 71/102
; update layer progress
M73 L71
M991 S0 P70 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z8.16 I1.217 J.013 P1  F18000
G1 X88.607 Y87.843 Z8.16
G1 Z7.88
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1484
M204 S6000
G1 X91.607 Y87.843 E.06032
G1 X91.607 Y92.157 E.08672
G1 X88.393 Y92.157 E.06461
G1 X88.393 Y87.843 E.08672
G1 X88.547 Y87.843 E.00308
M204 S10000
G1 X89.031 Y87.01 F18000
G1 F1484
M204 S6000
G1 X89.031 Y87.419 E.00823
G1 X91.749 Y87.419 E.05466
G1 X91.749 Y86.838 E.01169
G1 X91.942 Y86.789 E.00399
G1 X92.031 Y86.955 E.00379
G1 X92.031 Y93.045 E.12244
G1 X91.942 Y93.211 E.00379
G1 X91.749 Y93.162 E.00399
G1 X91.749 Y92.581 E.01169
G1 X89.031 Y92.581 E.05466
G1 X89.031 Y100.181 E.15282
G1 X87.969 Y100.181 E.02134
G1 X87.969 Y79.819 E.40942
G1 X89.031 Y79.819 E.02134
G1 X89.031 Y86.95 E.14338
M204 S250
G1 X89.44 Y87.01 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1484
M204 S5000
G1 X91.34 Y87.01 E.0355
G1 X91.34 Y85.61 E.02616
G1 X91.774 Y85.61 E.00811
G1 X92.44 Y86.853 E.02634
G1 X92.44 Y93.147 E.11762
G1 X91.774 Y94.39 E.02634
G1 X91.34 Y94.39 E.00811
G1 X91.34 Y92.99 E.02616
G1 X89.44 Y92.99 E.0355
G1 X89.44 Y100.59 E.14201
G1 X87.56 Y100.59 E.03513
G1 X87.56 Y79.41 E.39576
G1 X89.44 Y79.41 E.03513
G1 X89.44 Y86.95 E.14089
; WIPE_START
G1 F1800
M204 S6000
G1 X91.34 Y87.01 E-.27089
G1 X91.34 Y86.911 E-.01411
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
            G0 Z8.28 F4000
            G39.3 S1
            G0 Z8.28 F4000
            G392 S0
          
        M623
    
    M623
M623
; SKIPPABLE_END




G1 X88.5 Y87.631
G1 Z7.88
G1 E.3 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.663042
G1 F1484
M204 S6000
G1 X88.5 Y80.031 E.22955
; WIPE_START
G1 F2400
G1 X88.5 Y82.031 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X89.824 Y89.548 Z8.28 F18000
G1 X90 Y90.55 Z8.28
G1 Z7.88
G1 E.3 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.449132
G1 F1484
M204 S6000
G1 X90 Y89.51 E.02087
M204 S10000
G1 X90.409 Y89.45 F18000
; LINE_WIDTH: 0.419992
G1 F1484
M204 S6000
G1 X90.409 Y89.041 E.00764
G1 X89.591 Y89.041 E.01528
G1 X89.591 Y90.959 E.03583
G1 X90.409 Y90.959 E.01528
G1 X90.409 Y89.51 E.02707
M204 S10000
G1 X90.803 Y89.45 F18000
G1 F1484
M204 S6000
G1 X90.803 Y88.647 E.01501
G1 X89.197 Y88.647 E.03001
G1 X89.197 Y91.353 E.05056
G1 X90.803 Y91.353 E.03001
G1 X90.803 Y89.51 E.03444
M204 S10000
G1 X91.197 Y89.45 F18000
G1 F1484
M204 S6000
G1 X91.197 Y88.253 E.02237
G1 X88.803 Y88.253 E.04474
G1 X88.803 Y91.747 E.0653
G1 X91.197 Y91.747 E.04474
G1 X91.197 Y89.51 E.0418
; WIPE_START
G1 F4800
G1 X91.197 Y91.51 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X88.5 Y92.369 Z8.28 F18000
G1 Z7.88
G1 E.3 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.663042
G1 F1484
M204 S6000
G1 X88.5 Y99.969 E.22955
; CHANGE_LAYER
; Z_HEIGHT: 8
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F2400
G1 X88.5 Y97.969 E-.285
; WIPE_END
G1 E-.015 F1800
; layer num/total_layer_count: 72/102
; update layer progress
M73 L72
M991 S0 P71 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z8.28 I1.217 J.013 P1  F18000
G1 X88.607 Y87.843 Z8.28
G1 Z8
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1484
M204 S6000
G1 X91.607 Y87.843 E.06032
G1 X91.607 Y92.157 E.08672
G1 X88.393 Y92.157 E.06461
G1 X88.393 Y87.843 E.08672
M73 P76 R5
G1 X88.547 Y87.843 E.00308
M204 S10000
G1 X89.031 Y87.01 F18000
G1 F1484
M204 S6000
G1 X89.031 Y87.419 E.00823
G1 X91.749 Y87.419 E.05466
G1 X91.749 Y86.838 E.01169
G1 X91.942 Y86.789 E.00399
G1 X92.031 Y86.955 E.00379
G1 X92.031 Y93.045 E.12244
G1 X91.942 Y93.211 E.00379
G1 X91.749 Y93.162 E.00399
G1 X91.749 Y92.581 E.01169
G1 X89.031 Y92.581 E.05466
G1 X89.031 Y100.181 E.15282
G1 X87.969 Y100.181 E.02134
G1 X87.969 Y79.819 E.40942
G1 X89.031 Y79.819 E.02134
G1 X89.031 Y86.95 E.14338
M204 S250
G1 X89.44 Y87.01 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1484
M204 S5000
G1 X91.34 Y87.01 E.0355
G1 X91.34 Y85.61 E.02616
G1 X91.774 Y85.61 E.00811
G1 X92.44 Y86.853 E.02634
G1 X92.44 Y93.147 E.11762
G1 X91.774 Y94.39 E.02634
G1 X91.34 Y94.39 E.00811
G1 X91.34 Y92.99 E.02616
G1 X89.44 Y92.99 E.0355
G1 X89.44 Y100.59 E.14201
G1 X87.56 Y100.59 E.03513
G1 X87.56 Y79.41 E.39576
G1 X89.44 Y79.41 E.03513
G1 X89.44 Y86.95 E.14089
; WIPE_START
G1 F1800
M204 S6000
G1 X91.34 Y87.01 E-.27089
G1 X91.34 Y86.911 E-.01411
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
            G0 Z8.4 F4000
            G39.3 S1
            G0 Z8.4 F4000
            G392 S0
          
        M623
    
    M623
M623
; SKIPPABLE_END




G1 X88.5 Y87.631
G1 Z8
G1 E.3 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.663042
G1 F1484
M204 S6000
G1 X88.5 Y80.031 E.22955
; WIPE_START
G1 F2400
G1 X88.5 Y82.031 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X89.824 Y89.548 Z8.4 F18000
G1 X90 Y90.55 Z8.4
G1 Z8
G1 E.3 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.449132
G1 F1484
M204 S6000
G1 X90 Y89.51 E.02087
M204 S10000
G1 X90.409 Y89.45 F18000
; LINE_WIDTH: 0.419992
G1 F1484
M204 S6000
G1 X90.409 Y89.041 E.00764
G1 X89.591 Y89.041 E.01528
G1 X89.591 Y90.959 E.03583
G1 X90.409 Y90.959 E.01528
G1 X90.409 Y89.51 E.02707
M204 S10000
G1 X90.803 Y89.45 F18000
G1 F1484
M204 S6000
G1 X90.803 Y88.647 E.01501
G1 X89.197 Y88.647 E.03001
G1 X89.197 Y91.353 E.05056
G1 X90.803 Y91.353 E.03001
G1 X90.803 Y89.51 E.03444
M204 S10000
G1 X91.197 Y89.45 F18000
G1 F1484
M204 S6000
G1 X91.197 Y88.253 E.02237
G1 X88.803 Y88.253 E.04474
G1 X88.803 Y91.747 E.0653
G1 X91.197 Y91.747 E.04474
G1 X91.197 Y89.51 E.0418
; WIPE_START
G1 F4800
G1 X91.197 Y91.51 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X88.5 Y92.369 Z8.4 F18000
G1 Z8
G1 E.3 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.663042
G1 F1484
M204 S6000
G1 X88.5 Y99.969 E.22955
; CHANGE_LAYER
; Z_HEIGHT: 8.12
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F2400
G1 X88.5 Y97.969 E-.285
; WIPE_END
G1 E-.015 F1800
; layer num/total_layer_count: 73/102
; update layer progress
M73 L73
M991 S0 P72 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z8.4 I1.217 J.013 P1  F18000
G1 X88.607 Y87.843 Z8.4
G1 Z8.12
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1484
M204 S6000
G1 X91.607 Y87.843 E.06032
G1 X91.607 Y92.157 E.08672
G1 X88.393 Y92.157 E.06461
G1 X88.393 Y87.843 E.08672
G1 X88.547 Y87.843 E.00308
M204 S10000
G1 X89.031 Y87.01 F18000
G1 F1484
M204 S6000
G1 X89.031 Y87.419 E.00823
G1 X91.749 Y87.419 E.05466
G1 X91.749 Y86.838 E.01169
G1 X91.942 Y86.789 E.00399
G1 X92.031 Y86.955 E.00379
G1 X92.031 Y93.045 E.12244
G1 X91.942 Y93.211 E.00379
G1 X91.749 Y93.162 E.00399
G1 X91.749 Y92.581 E.01169
G1 X89.031 Y92.581 E.05466
G1 X89.031 Y100.181 E.15282
G1 X87.969 Y100.181 E.02134
G1 X87.969 Y79.819 E.40942
G1 X89.031 Y79.819 E.02134
G1 X89.031 Y86.95 E.14338
M204 S250
G1 X89.44 Y87.01 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1484
M204 S5000
G1 X91.34 Y87.01 E.0355
G1 X91.34 Y85.61 E.02616
M73 P77 R5
G1 X91.774 Y85.61 E.00811
G1 X92.44 Y86.853 E.02634
G1 X92.44 Y93.147 E.11762
G1 X91.774 Y94.39 E.02634
G1 X91.34 Y94.39 E.00811
G1 X91.34 Y92.99 E.02616
G1 X89.44 Y92.99 E.0355
G1 X89.44 Y100.59 E.14201
G1 X87.56 Y100.59 E.03513
G1 X87.56 Y79.41 E.39576
G1 X89.44 Y79.41 E.03513
G1 X89.44 Y86.95 E.14089
; WIPE_START
G1 F1800
M204 S6000
G1 X91.34 Y87.01 E-.27089
G1 X91.34 Y86.911 E-.01411
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
            G0 Z8.52 F4000
            G39.3 S1
            G0 Z8.52 F4000
            G392 S0
          
        M623
    
    M623
M623
; SKIPPABLE_END




G1 X88.5 Y87.631
G1 Z8.12
G1 E.3 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.663042
G1 F1484
M204 S6000
G1 X88.5 Y80.031 E.22955
; WIPE_START
G1 F2400
G1 X88.5 Y82.031 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X89.824 Y89.548 Z8.52 F18000
G1 X90 Y90.55 Z8.52
G1 Z8.12
G1 E.3 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.449132
G1 F1484
M204 S6000
G1 X90 Y89.51 E.02087
M204 S10000
G1 X90.409 Y89.45 F18000
; LINE_WIDTH: 0.419992
G1 F1484
M204 S6000
G1 X90.409 Y89.041 E.00764
G1 X89.591 Y89.041 E.01528
G1 X89.591 Y90.959 E.03583
G1 X90.409 Y90.959 E.01528
G1 X90.409 Y89.51 E.02707
M204 S10000
G1 X90.803 Y89.45 F18000
G1 F1484
M204 S6000
G1 X90.803 Y88.647 E.01501
G1 X89.197 Y88.647 E.03001
G1 X89.197 Y91.353 E.05056
G1 X90.803 Y91.353 E.03001
G1 X90.803 Y89.51 E.03444
M204 S10000
G1 X91.197 Y89.45 F18000
G1 F1484
M204 S6000
G1 X91.197 Y88.253 E.02237
G1 X88.803 Y88.253 E.04474
G1 X88.803 Y91.747 E.0653
G1 X91.197 Y91.747 E.04474
G1 X91.197 Y89.51 E.0418
; WIPE_START
G1 F4800
G1 X91.197 Y91.51 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X88.5 Y92.369 Z8.52 F18000
G1 Z8.12
G1 E.3 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.663042
G1 F1484
M204 S6000
G1 X88.5 Y99.969 E.22955
; CHANGE_LAYER
; Z_HEIGHT: 8.24
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F2400
G1 X88.5 Y97.969 E-.285
; WIPE_END
G1 E-.015 F1800
; layer num/total_layer_count: 74/102
; update layer progress
M73 L74
M991 S0 P73 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z8.52 I1.217 J.013 P1  F18000
G1 X88.607 Y87.843 Z8.52
G1 Z8.24
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1484
M204 S6000
G1 X91.607 Y87.843 E.06032
G1 X91.607 Y92.157 E.08672
G1 X88.393 Y92.157 E.06461
G1 X88.393 Y87.843 E.08672
G1 X88.547 Y87.843 E.00308
M204 S10000
G1 X89.031 Y87.01 F18000
G1 F1484
M204 S6000
G1 X89.031 Y87.419 E.00823
G1 X91.749 Y87.419 E.05466
G1 X91.749 Y86.838 E.01169
G1 X91.942 Y86.789 E.00399
G1 X92.031 Y86.955 E.00379
G1 X92.031 Y93.045 E.12244
G1 X91.942 Y93.211 E.00379
G1 X91.749 Y93.162 E.00399
G1 X91.749 Y92.581 E.01169
G1 X89.031 Y92.581 E.05466
G1 X89.031 Y100.181 E.15282
G1 X87.969 Y100.181 E.02134
G1 X87.969 Y79.819 E.40942
G1 X89.031 Y79.819 E.02134
G1 X89.031 Y86.95 E.14338
M204 S250
G1 X89.44 Y87.01 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1484
M204 S5000
G1 X91.34 Y87.01 E.0355
G1 X91.34 Y85.61 E.02616
G1 X91.774 Y85.61 E.00811
G1 X92.44 Y86.853 E.02634
G1 X92.44 Y93.147 E.11762
G1 X91.774 Y94.39 E.02634
G1 X91.34 Y94.39 E.00811
G1 X91.34 Y92.99 E.02616
G1 X89.44 Y92.99 E.0355
G1 X89.44 Y100.59 E.14201
G1 X87.56 Y100.59 E.03513
G1 X87.56 Y79.41 E.39576
G1 X89.44 Y79.41 E.03513
G1 X89.44 Y86.95 E.14089
; WIPE_START
G1 F1800
M204 S6000
G1 X91.34 Y87.01 E-.27089
G1 X91.34 Y86.911 E-.01411
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
            G0 Z8.64 F4000
            G39.3 S1
            G0 Z8.64 F4000
            G392 S0
          
        M623
    
    M623
M623
; SKIPPABLE_END




G1 X88.5 Y87.631
G1 Z8.24
G1 E.3 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.663042
G1 F1484
M204 S6000
G1 X88.5 Y80.031 E.22955
; WIPE_START
G1 F2400
G1 X88.5 Y82.031 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X89.824 Y89.548 Z8.64 F18000
G1 X90 Y90.55 Z8.64
G1 Z8.24
G1 E.3 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.449132
G1 F1484
M204 S6000
G1 X90 Y89.51 E.02087
M204 S10000
G1 X90.409 Y89.45 F18000
; LINE_WIDTH: 0.419992
G1 F1484
M204 S6000
G1 X90.409 Y89.041 E.00764
G1 X89.591 Y89.041 E.01528
G1 X89.591 Y90.959 E.03583
G1 X90.409 Y90.959 E.01528
G1 X90.409 Y89.51 E.02707
M204 S10000
G1 X90.803 Y89.45 F18000
G1 F1484
M204 S6000
G1 X90.803 Y88.647 E.01501
G1 X89.197 Y88.647 E.03001
G1 X89.197 Y91.353 E.05056
G1 X90.803 Y91.353 E.03001
G1 X90.803 Y89.51 E.03444
M204 S10000
G1 X91.197 Y89.45 F18000
G1 F1484
M204 S6000
G1 X91.197 Y88.253 E.02237
G1 X88.803 Y88.253 E.04474
G1 X88.803 Y91.747 E.0653
G1 X91.197 Y91.747 E.04474
G1 X91.197 Y89.51 E.0418
; WIPE_START
G1 F4800
G1 X91.197 Y91.51 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X88.5 Y92.369 Z8.64 F18000
G1 Z8.24
G1 E.3 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.663042
G1 F1484
M204 S6000
G1 X88.5 Y99.969 E.22955
; CHANGE_LAYER
; Z_HEIGHT: 8.36
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F2400
G1 X88.5 Y97.969 E-.285
; WIPE_END
G1 E-.015 F1800
; layer num/total_layer_count: 75/102
; update layer progress
M73 L75
M991 S0 P74 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z8.64 I1.217 J.013 P1  F18000
M73 P78 R5
G1 X88.607 Y87.843 Z8.64
G1 Z8.36
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1484
M204 S6000
G1 X91.607 Y87.843 E.06032
G1 X91.607 Y92.157 E.08672
G1 X88.393 Y92.157 E.06461
G1 X88.393 Y87.843 E.08672
G1 X88.547 Y87.843 E.00308
M204 S10000
G1 X89.031 Y87.01 F18000
G1 F1484
M204 S6000
G1 X89.031 Y87.419 E.00823
G1 X91.749 Y87.419 E.05466
G1 X91.749 Y86.838 E.01169
G1 X91.942 Y86.789 E.00399
G1 X92.031 Y86.955 E.00379
G1 X92.031 Y93.045 E.12244
G1 X91.942 Y93.211 E.00379
G1 X91.749 Y93.162 E.00399
G1 X91.749 Y92.581 E.01169
G1 X89.031 Y92.581 E.05466
G1 X89.031 Y100.181 E.15282
G1 X87.969 Y100.181 E.02134
G1 X87.969 Y79.819 E.40942
G1 X89.031 Y79.819 E.02134
G1 X89.031 Y86.95 E.14338
M204 S250
G1 X89.44 Y87.01 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1484
M204 S5000
G1 X91.34 Y87.01 E.0355
G1 X91.34 Y85.61 E.02616
G1 X91.774 Y85.61 E.00811
G1 X92.44 Y86.853 E.02634
M73 P78 R4
G1 X92.44 Y93.147 E.11762
G1 X91.774 Y94.39 E.02634
G1 X91.34 Y94.39 E.00811
G1 X91.34 Y92.99 E.02616
G1 X89.44 Y92.99 E.0355
G1 X89.44 Y100.59 E.14201
G1 X87.56 Y100.59 E.03513
G1 X87.56 Y79.41 E.39576
G1 X89.44 Y79.41 E.03513
G1 X89.44 Y86.95 E.14089
; WIPE_START
G1 F1800
M204 S6000
G1 X91.34 Y87.01 E-.27089
G1 X91.34 Y86.911 E-.01411
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
            G0 Z8.76 F4000
            G39.3 S1
            G0 Z8.76 F4000
            G392 S0
          
        M623
    
    M623
M623
; SKIPPABLE_END




G1 X88.5 Y87.631
G1 Z8.36
G1 E.3 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.663042
G1 F1484
M204 S6000
G1 X88.5 Y80.031 E.22955
; WIPE_START
G1 F2400
G1 X88.5 Y82.031 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X89.824 Y89.548 Z8.76 F18000
G1 X90 Y90.55 Z8.76
G1 Z8.36
G1 E.3 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.449132
G1 F1484
M204 S6000
G1 X90 Y89.51 E.02087
M204 S10000
G1 X90.409 Y89.45 F18000
; LINE_WIDTH: 0.419992
G1 F1484
M204 S6000
G1 X90.409 Y89.041 E.00764
G1 X89.591 Y89.041 E.01528
G1 X89.591 Y90.959 E.03583
G1 X90.409 Y90.959 E.01528
G1 X90.409 Y89.51 E.02707
M204 S10000
G1 X90.803 Y89.45 F18000
G1 F1484
M204 S6000
G1 X90.803 Y88.647 E.01501
G1 X89.197 Y88.647 E.03001
G1 X89.197 Y91.353 E.05056
G1 X90.803 Y91.353 E.03001
G1 X90.803 Y89.51 E.03444
M204 S10000
G1 X91.197 Y89.45 F18000
G1 F1484
M204 S6000
G1 X91.197 Y88.253 E.02237
G1 X88.803 Y88.253 E.04474
G1 X88.803 Y91.747 E.0653
G1 X91.197 Y91.747 E.04474
G1 X91.197 Y89.51 E.0418
; WIPE_START
G1 F4800
G1 X91.197 Y91.51 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X88.5 Y92.369 Z8.76 F18000
G1 Z8.36
G1 E.3 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.663042
G1 F1484
M204 S6000
G1 X88.5 Y99.969 E.22955
; CHANGE_LAYER
; Z_HEIGHT: 8.48
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F2400
G1 X88.5 Y97.969 E-.285
; WIPE_END
G1 E-.015 F1800
; layer num/total_layer_count: 76/102
; update layer progress
M73 L76
M991 S0 P75 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z8.76 I1.217 J.013 P1  F18000
G1 X88.607 Y87.843 Z8.76
G1 Z8.48
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1484
M204 S6000
G1 X91.607 Y87.843 E.06032
G1 X91.607 Y92.157 E.08672
G1 X88.393 Y92.157 E.06461
G1 X88.393 Y87.843 E.08672
G1 X88.547 Y87.843 E.00308
M204 S10000
G1 X89.031 Y87.01 F18000
G1 F1484
M204 S6000
G1 X89.031 Y87.419 E.00823
G1 X91.749 Y87.419 E.05466
G1 X91.749 Y86.838 E.01169
G1 X91.942 Y86.789 E.00399
G1 X92.031 Y86.955 E.00379
G1 X92.031 Y93.045 E.12244
G1 X91.942 Y93.211 E.00379
G1 X91.749 Y93.162 E.00399
G1 X91.749 Y92.581 E.01169
G1 X89.031 Y92.581 E.05466
G1 X89.031 Y100.181 E.15282
G1 X87.969 Y100.181 E.02134
G1 X87.969 Y79.819 E.40942
G1 X89.031 Y79.819 E.02134
G1 X89.031 Y86.95 E.14338
M204 S250
G1 X89.44 Y87.01 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1484
M204 S5000
G1 X91.34 Y87.01 E.0355
M73 P79 R4
G1 X91.34 Y85.61 E.02616
G1 X91.774 Y85.61 E.00811
G1 X92.44 Y86.853 E.02634
G1 X92.44 Y93.147 E.11762
G1 X91.774 Y94.39 E.02634
G1 X91.34 Y94.39 E.00811
G1 X91.34 Y92.99 E.02616
G1 X89.44 Y92.99 E.0355
G1 X89.44 Y100.59 E.14201
G1 X87.56 Y100.59 E.03513
G1 X87.56 Y79.41 E.39576
G1 X89.44 Y79.41 E.03513
G1 X89.44 Y86.95 E.14089
; WIPE_START
G1 F1800
M204 S6000
G1 X91.34 Y87.01 E-.27089
G1 X91.34 Y86.911 E-.01411
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
            G0 Z8.88 F4000
            G39.3 S1
            G0 Z8.88 F4000
            G392 S0
          
        M623
    
    M623
M623
; SKIPPABLE_END




G1 X88.5 Y87.631
G1 Z8.48
G1 E.3 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.663042
G1 F1484
M204 S6000
G1 X88.5 Y80.031 E.22955
; WIPE_START
G1 F2400
G1 X88.5 Y82.031 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X89.824 Y89.548 Z8.88 F18000
G1 X90 Y90.55 Z8.88
G1 Z8.48
G1 E.3 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.449132
G1 F1484
M204 S6000
G1 X90 Y89.51 E.02087
M204 S10000
G1 X90.409 Y89.45 F18000
; LINE_WIDTH: 0.419992
G1 F1484
M204 S6000
G1 X90.409 Y89.041 E.00764
G1 X89.591 Y89.041 E.01528
G1 X89.591 Y90.959 E.03583
G1 X90.409 Y90.959 E.01528
G1 X90.409 Y89.51 E.02707
M204 S10000
G1 X90.803 Y89.45 F18000
G1 F1484
M204 S6000
G1 X90.803 Y88.647 E.01501
G1 X89.197 Y88.647 E.03001
G1 X89.197 Y91.353 E.05056
G1 X90.803 Y91.353 E.03001
G1 X90.803 Y89.51 E.03444
M204 S10000
G1 X91.197 Y89.45 F18000
G1 F1484
M204 S6000
G1 X91.197 Y88.253 E.02237
G1 X88.803 Y88.253 E.04474
G1 X88.803 Y91.747 E.0653
G1 X91.197 Y91.747 E.04474
G1 X91.197 Y89.51 E.0418
; WIPE_START
G1 F4800
G1 X91.197 Y91.51 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X88.5 Y92.369 Z8.88 F18000
G1 Z8.48
G1 E.3 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.663042
G1 F1484
M204 S6000
G1 X88.5 Y99.969 E.22955
; CHANGE_LAYER
; Z_HEIGHT: 8.6
; LAYER_HEIGHT: 0.120001
; WIPE_START
G1 F2400
G1 X88.5 Y97.969 E-.285
; WIPE_END
G1 E-.015 F1800
; layer num/total_layer_count: 77/102
; update layer progress
M73 L77
M991 S0 P76 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z8.88 I1.217 J.013 P1  F18000
G1 X88.607 Y87.843 Z8.88
G1 Z8.6
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1484
M204 S6000
G1 X91.607 Y87.843 E.06032
G1 X91.607 Y92.157 E.08672
G1 X88.393 Y92.157 E.06461
G1 X88.393 Y87.843 E.08672
G1 X88.547 Y87.843 E.00308
M204 S10000
G1 X89.031 Y87.01 F18000
G1 F1484
M204 S6000
G1 X89.031 Y87.419 E.00823
G1 X91.749 Y87.419 E.05466
G1 X91.749 Y86.838 E.01169
G1 X91.942 Y86.789 E.00399
G1 X92.031 Y86.955 E.00379
G1 X92.031 Y93.045 E.12244
G1 X91.942 Y93.211 E.00379
G1 X91.749 Y93.162 E.00399
G1 X91.749 Y92.581 E.01169
G1 X89.031 Y92.581 E.05466
G1 X89.031 Y100.181 E.15282
G1 X87.969 Y100.181 E.02134
G1 X87.969 Y79.819 E.40942
G1 X89.031 Y79.819 E.02134
G1 X89.031 Y86.95 E.14338
M204 S250
G1 X89.44 Y87.01 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1484
M204 S5000
G1 X91.34 Y87.01 E.0355
G1 X91.34 Y85.61 E.02616
G1 X91.774 Y85.61 E.00811
G1 X92.44 Y86.853 E.02634
G1 X92.44 Y93.147 E.11762
G1 X91.774 Y94.39 E.02634
G1 X91.34 Y94.39 E.00811
G1 X91.34 Y92.99 E.02616
G1 X89.44 Y92.99 E.0355
G1 X89.44 Y100.59 E.14201
G1 X87.56 Y100.59 E.03513
G1 X87.56 Y79.41 E.39576
G1 X89.44 Y79.41 E.03513
G1 X89.44 Y86.95 E.14089
; WIPE_START
G1 F1800
M204 S6000
G1 X91.34 Y87.01 E-.27089
G1 X91.34 Y86.911 E-.01411
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
            G0 Z9 F4000
            G39.3 S1
            G0 Z9 F4000
            G392 S0
          
        M623
    
    M623
M623
; SKIPPABLE_END




G1 X88.5 Y87.631
G1 Z8.6
G1 E.3 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.663042
G1 F1484
M204 S6000
G1 X88.5 Y80.031 E.22955
; WIPE_START
G1 F2400
G1 X88.5 Y82.031 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X89.824 Y89.548 Z9 F18000
G1 X90 Y90.55 Z9
G1 Z8.6
G1 E.3 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.449132
G1 F1484
M204 S6000
G1 X90 Y89.51 E.02087
M204 S10000
G1 X90.409 Y89.45 F18000
; LINE_WIDTH: 0.419992
G1 F1484
M204 S6000
G1 X90.409 Y89.041 E.00764
G1 X89.591 Y89.041 E.01528
G1 X89.591 Y90.959 E.03583
G1 X90.409 Y90.959 E.01528
G1 X90.409 Y89.51 E.02707
M204 S10000
G1 X90.803 Y89.45 F18000
G1 F1484
M204 S6000
G1 X90.803 Y88.647 E.01501
G1 X89.197 Y88.647 E.03001
G1 X89.197 Y91.353 E.05056
G1 X90.803 Y91.353 E.03001
G1 X90.803 Y89.51 E.03444
M204 S10000
G1 X91.197 Y89.45 F18000
G1 F1484
M204 S6000
G1 X91.197 Y88.253 E.02237
G1 X88.803 Y88.253 E.04474
G1 X88.803 Y91.747 E.0653
G1 X91.197 Y91.747 E.04474
G1 X91.197 Y89.51 E.0418
; WIPE_START
G1 F4800
M73 P80 R4
G1 X91.197 Y91.51 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X88.5 Y92.369 Z9 F18000
G1 Z8.6
G1 E.3 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.663042
G1 F1484
M204 S6000
G1 X88.5 Y99.969 E.22955
; CHANGE_LAYER
; Z_HEIGHT: 8.72
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F2400
G1 X88.5 Y97.969 E-.285
; WIPE_END
G1 E-.015 F1800
; layer num/total_layer_count: 78/102
; update layer progress
M73 L78
M991 S0 P77 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z9 I1.217 J.013 P1  F18000
G1 X88.607 Y87.843 Z9
G1 Z8.72
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1484
M204 S6000
G1 X91.607 Y87.843 E.06032
G1 X91.607 Y92.157 E.08672
G1 X88.393 Y92.157 E.06461
G1 X88.393 Y87.843 E.08672
G1 X88.547 Y87.843 E.00308
M204 S10000
G1 X89.031 Y87.01 F18000
G1 F1484
M204 S6000
G1 X89.031 Y87.419 E.00823
G1 X91.749 Y87.419 E.05466
G1 X91.749 Y86.838 E.01169
G1 X91.942 Y86.789 E.00399
G1 X92.031 Y86.955 E.00379
G1 X92.031 Y93.045 E.12244
G1 X91.942 Y93.211 E.00379
G1 X91.749 Y93.162 E.00399
G1 X91.749 Y92.581 E.01169
G1 X89.031 Y92.581 E.05466
G1 X89.031 Y100.181 E.15282
G1 X87.969 Y100.181 E.02134
G1 X87.969 Y79.819 E.40942
G1 X89.031 Y79.819 E.02134
G1 X89.031 Y86.95 E.14338
M204 S250
G1 X89.44 Y87.01 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1484
M204 S5000
G1 X91.34 Y87.01 E.0355
G1 X91.34 Y85.61 E.02616
G1 X91.774 Y85.61 E.00811
G1 X92.44 Y86.853 E.02634
G1 X92.44 Y93.147 E.11762
G1 X91.774 Y94.39 E.02634
G1 X91.34 Y94.39 E.00811
G1 X91.34 Y92.99 E.02616
G1 X89.44 Y92.99 E.0355
G1 X89.44 Y100.59 E.14201
G1 X87.56 Y100.59 E.03513
G1 X87.56 Y79.41 E.39576
G1 X89.44 Y79.41 E.03513
G1 X89.44 Y86.95 E.14089
; WIPE_START
G1 F1800
M204 S6000
G1 X91.34 Y87.01 E-.27089
G1 X91.34 Y86.911 E-.01411
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
            G0 Z9.12 F4000
            G39.3 S1
            G0 Z9.12 F4000
            G392 S0
          
        M623
    
    M623
M623
; SKIPPABLE_END




G1 X88.5 Y87.631
G1 Z8.72
G1 E.3 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.663042
G1 F1484
M204 S6000
G1 X88.5 Y80.031 E.22955
; WIPE_START
G1 F2400
G1 X88.5 Y82.031 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X89.824 Y89.548 Z9.12 F18000
G1 X90 Y90.55 Z9.12
G1 Z8.72
G1 E.3 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.449132
G1 F1484
M204 S6000
G1 X90 Y89.51 E.02087
M204 S10000
G1 X90.409 Y89.45 F18000
; LINE_WIDTH: 0.419992
G1 F1484
M204 S6000
G1 X90.409 Y89.041 E.00764
G1 X89.591 Y89.041 E.01528
G1 X89.591 Y90.959 E.03583
G1 X90.409 Y90.959 E.01528
G1 X90.409 Y89.51 E.02707
M204 S10000
G1 X90.803 Y89.45 F18000
G1 F1484
M204 S6000
G1 X90.803 Y88.647 E.01501
G1 X89.197 Y88.647 E.03001
G1 X89.197 Y91.353 E.05056
G1 X90.803 Y91.353 E.03001
G1 X90.803 Y89.51 E.03444
M204 S10000
G1 X91.197 Y89.45 F18000
G1 F1484
M204 S6000
G1 X91.197 Y88.253 E.02237
G1 X88.803 Y88.253 E.04474
G1 X88.803 Y91.747 E.0653
G1 X91.197 Y91.747 E.04474
G1 X91.197 Y89.51 E.0418
; WIPE_START
G1 F4800
G1 X91.197 Y91.51 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X88.5 Y92.369 Z9.12 F18000
G1 Z8.72
G1 E.3 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.663042
G1 F1484
M204 S6000
G1 X88.5 Y99.969 E.22955
; CHANGE_LAYER
; Z_HEIGHT: 8.84
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F2400
G1 X88.5 Y97.969 E-.285
; WIPE_END
G1 E-.015 F1800
; layer num/total_layer_count: 79/102
; update layer progress
M73 L79
M991 S0 P78 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z9.12 I1.217 J.013 P1  F18000
G1 X88.607 Y87.845 Z9.12
G1 Z8.84
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1483
M204 S6000
G1 X91.607 Y87.845 E.06032
G1 X91.607 Y92.155 E.08665
G1 X88.393 Y92.155 E.06461
G1 X88.393 Y87.845 E.08665
G1 X88.547 Y87.845 E.00308
M204 S10000
G1 X89.031 Y87.012 F18000
G1 F1483
M204 S6000
G1 X89.031 Y87.421 E.00823
G1 X91.749 Y87.421 E.05466
G1 X91.749 Y86.838 E.01173
G1 X91.942 Y86.789 E.00399
G1 X92.031 Y86.955 E.00379
G1 X92.031 Y93.045 E.12244
G1 X91.942 Y93.211 E.00379
G1 X91.749 Y93.162 E.00399
G1 X91.749 Y92.579 E.01173
G1 X89.031 Y92.579 E.05466
G1 X89.031 Y100.181 E.15285
G1 X87.969 Y100.181 E.02134
G1 X87.969 Y79.819 E.40942
M73 P81 R4
G1 X89.031 Y79.819 E.02134
G1 X89.031 Y86.952 E.14342
M204 S250
G1 X89.44 Y87.012 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1483
M204 S5000
G1 X91.34 Y87.012 E.0355
G1 X91.34 Y85.61 E.0262
G1 X91.774 Y85.61 E.00811
G1 X92.44 Y86.853 E.02634
G1 X92.44 Y93.147 E.11762
G1 X91.774 Y94.39 E.02634
G1 X91.34 Y94.39 E.00811
G1 X91.34 Y92.988 E.0262
G1 X89.44 Y92.988 E.0355
G1 X89.44 Y100.59 E.14205
G1 X87.56 Y100.59 E.03513
G1 X87.56 Y79.41 E.39576
G1 X89.44 Y79.41 E.03513
G1 X89.44 Y86.952 E.14092
; WIPE_START
G1 F1800
M204 S6000
G1 X91.34 Y87.012 E-.27089
G1 X91.34 Y86.913 E-.01411
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
            G0 Z9.24 F4000
            G39.3 S1
            G0 Z9.24 F4000
            G392 S0
          
        M623
    
    M623
M623
; SKIPPABLE_END




G1 X88.5 Y87.633
G1 Z8.84
G1 E.3 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.663042
G1 F1483
M204 S6000
G1 X88.5 Y80.031 E.22961
; WIPE_START
G1 F2400
G1 X88.5 Y82.031 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X89.824 Y89.548 Z9.24 F18000
G1 X90 Y90.548 Z9.24
G1 Z8.84
G1 E.3 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.449132
G1 F1483
M204 S6000
G1 X90 Y89.512 E.02079
M204 S10000
G1 X90.409 Y89.452 F18000
; LINE_WIDTH: 0.419992
G1 F1483
M204 S6000
G1 X90.409 Y89.043 E.00764
G1 X89.591 Y89.043 E.01528
G1 X89.591 Y90.957 E.03576
G1 X90.409 Y90.957 E.01528
G1 X90.409 Y89.512 E.027
M204 S10000
G1 X90.803 Y89.452 F18000
G1 F1483
M204 S6000
G1 X90.803 Y88.649 E.01501
G1 X89.197 Y88.649 E.03001
G1 X89.197 Y91.351 E.05049
G1 X90.803 Y91.351 E.03001
G1 X90.803 Y89.512 E.03437
M204 S10000
G1 X91.197 Y89.452 F18000
G1 F1483
M204 S6000
G1 X91.197 Y88.255 E.02237
G1 X88.803 Y88.255 E.04474
G1 X88.803 Y91.745 E.06523
G1 X91.197 Y91.745 E.04474
G1 X91.197 Y89.512 E.04173
; WIPE_START
G1 F4800
G1 X91.197 Y91.512 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X88.5 Y92.367 Z9.24 F18000
G1 Z8.84
G1 E.3 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.663042
G1 F1483
M204 S6000
G1 X88.5 Y99.969 E.22961
; CHANGE_LAYER
; Z_HEIGHT: 8.96
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F2400
G1 X88.5 Y97.969 E-.285
; WIPE_END
G1 E-.015 F1800
; layer num/total_layer_count: 80/102
; update layer progress
M73 L80
M991 S0 P79 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z9.24 I1.217 J-.022 P1  F18000
G1 X88.299 Y87.06 Z9.24
G1 Z8.96
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1718
M204 S6000
G1 X88.299 Y94.741 E.15445
G1 X89.031 Y94.741 E.01472
G1 X89.031 Y100.181 E.10938
G1 X87.969 Y100.181 E.02134
G1 X87.969 Y79.819 E.40942
G1 X89.031 Y79.819 E.02134
G1 X89.031 Y85.259 E.10938
G1 X88.299 Y85.259 E.01472
G1 X88.299 Y87 E.03501
; WIPE_START
G1 F3600
G1 X88.299 Y89 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X89.44 Y87.06 Z9.36 F18000
G1 Z8.96
G1 E.3 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1718
M204 S5000
G1 X91.34 Y87.06 E.0355
G1 X91.34 Y85.61 E.02709
G1 X91.774 Y85.61 E.00811
G1 X92.44 Y86.853 E.02634
G1 X92.44 Y93.147 E.11762
G1 X91.774 Y94.39 E.02634
G1 X91.34 Y94.39 E.00811
G1 X91.34 Y92.94 E.02709
G1 X89.44 Y92.94 E.0355
G1 X89.44 Y100.59 E.14295
G1 X87.56 Y100.59 E.03513
G1 X87.56 Y79.41 E.39576
G1 X89.44 Y79.41 E.03513
G1 X89.44 Y87 E.14182
; WIPE_START
G1 F1800
M204 S6000
G1 X91.34 Y87.06 E-.27089
G1 X91.34 Y86.961 E-.01411
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
            G0 Z9.36 F4000
            G39.3 S1
            G0 Z9.36 F4000
            G392 S0
          
        M623
    
    M623
M623
; SKIPPABLE_END




G1 X88.62 Y85.58
G1 Z8.96
G1 E.3 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.365752
G1 F1718
M204 S6000
G1 X89.122 Y85.538 E.00811
M204 S10000
G1 X88.5 Y85.047 F18000
; FEATURE: Gap infill
; LINE_WIDTH: 0.663042
G1 F1718
M204 S6000
G1 X88.5 Y80.031 E.15149
; WIPE_START
G1 F2400
G1 X88.5 Y82.031 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X90.939 Y89.264 Z9.36 F18000
G1 X92.223 Y93.073 Z9.36
G1 Z8.96
G1 E.3 F1800
; FEATURE: Top surface
; LINE_WIDTH: 0.42
G1 F1718
M204 S2000
G1 X91.557 Y93.74 E.01761
G1 X91.557 Y93.182
G1 X92.223 Y92.516 E.01761
G1 X92.223 Y91.958
G1 X91.458 Y92.723 E.02021
G1 X90.901 Y92.723
G1 X92.223 Y91.401 E.03494
G1 X92.223 Y90.843
M73 P82 R4
G1 X90.343 Y92.723 E.04968
G1 X89.786 Y92.723
G1 X92.223 Y90.286 E.06441
G1 X92.223 Y89.728
G1 X89.228 Y92.723 E.07914
G1 X89.223 Y93.843
G1 X88.727 Y94.339 E.01311
G1 X88.531 Y93.978
G1 X89.223 Y93.286 E.0183
G1 X89.223 Y92.728
G1 X88.531 Y93.421 E.0183
G1 X88.531 Y92.863
G1 X92.223 Y89.171 E.09757
G1 X92.223 Y88.613
G1 X88.531 Y92.305 E.09757
G1 X88.531 Y91.748
G1 X92.223 Y88.056 E.09757
G1 X92.223 Y87.498
G1 X88.531 Y91.19 E.09757
G1 X88.531 Y90.633
G1 X92.223 Y86.94 E.09757
G1 X91.557 Y87.049
G1 X92.04 Y86.566 E.01278
G1 X91.329 Y87.277
G1 X88.531 Y90.075 E.07395
G1 X88.531 Y89.518
G1 X90.772 Y87.277 E.05922
G1 X90.214 Y87.277
G1 X88.531 Y88.96 E.04448
G1 X88.531 Y88.403
G1 X89.657 Y87.277 E.02975
G1 X89.223 Y87.153
G1 X88.531 Y87.845 E.0183
G1 X88.531 Y87.288
G1 X89.223 Y86.595 E.0183
G1 X89.223 Y86.038
G1 X88.531 Y86.73 E.0183
G1 X88.531 Y86.173
G1 X89.096 Y85.607 E.01495
M204 S10000
G1 X88.728 Y85.666 F18000
; FEATURE: Gap infill
; LINE_WIDTH: 0.1237
G1 F1718
M204 S6000
G1 X88.511 Y85.817 E.00123
; WIPE_START
G1 F2400
G1 X88.728 Y85.666 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X91.519 Y92.77 Z9.36 F18000
G1 X91.89 Y93.714 Z9.36
G1 Z8.96
G1 E.3 F1800
; LINE_WIDTH: 0.0877515
G1 F1718
M204 S6000
G1 X91.791 Y93.847 E.00049
; WIPE_START
G1 F2400
G1 X91.89 Y93.714 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X88.618 Y94.422 Z9.36 F18000
G1 Z8.96
G1 E.3 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.365752
G1 F1718
M204 S6000
G1 X88.953 Y94.479 E.00547
G1 X89.13 Y94.477 E.00286
M204 S10000
G1 X88.5 Y94.953 F18000
; FEATURE: Gap infill
; LINE_WIDTH: 0.663042
G1 F1718
M204 S6000
G1 X88.5 Y99.969 E.15149
; CHANGE_LAYER
; Z_HEIGHT: 9.08
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F2400
G1 X88.5 Y97.969 E-.285
; WIPE_END
G1 E-.015 F1800
; layer num/total_layer_count: 81/102
; update layer progress
M73 L81
M991 S0 P80 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z9.36 I1.216 J.036 P1  F18000
G1 X89.031 Y79.819 Z9.36
G1 Z9.08
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F958
M204 S6000
G1 X89.031 Y100.181 E.40942
G1 X87.969 Y100.181 E.02134
G1 X87.969 Y79.819 E.40942
G1 X88.971 Y79.819 E.02014
M204 S250
G1 X89.44 Y79.41 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F958
M204 S5000
G1 X89.44 Y100.59 E.39576
G1 X87.56 Y100.59 E.03513
G1 X87.56 Y79.41 E.39576
G1 X89.38 Y79.41 E.03401
; WIPE_START
G1 F1800
M204 S6000
G1 X89.386 Y81.41 E-.285
; WIPE_END
G1 E-.015
M204 S10000
G17
G3 Z9.48 I1.217 J0 P1  F18000
;===================== date: 20250206 =====================

; don't support timelapse gcode in spiral_mode and by object sequence for I3 structure printer
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
G92 E0
G1 Z9.48
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
            G0 Z9.48 F4000
            G39.3 S1
            G0 Z9.48 F4000
            G392 S0
          
        M623
    
    M623
M623
; SKIPPABLE_END




G1 X88.5 Y80.031
G1 Z9.08
G1 E.3 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.663042
G1 F958
M204 S6000
G1 X88.5 Y99.969 E.6022
; CHANGE_LAYER
; Z_HEIGHT: 9.2
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F2400
G1 X88.5 Y97.969 E-.285
; WIPE_END
G1 E-.015 F1800
; layer num/total_layer_count: 82/102
; update layer progress
M73 L82
M991 S0 P81 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z9.48 I1.216 J.036 P1  F18000
G1 X89.031 Y79.819 Z9.48
G1 Z9.2
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F960
M204 S6000
G1 X89.031 Y100.181 E.40942
G1 X87.969 Y100.181 E.02134
G1 X87.969 Y79.819 E.40942
M73 P82 R3
G1 X88.971 Y79.819 E.02014
M204 S250
G1 X89.44 Y79.41 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F960
M204 S5000
G1 X89.44 Y100.59 E.39576
G1 X87.56 Y100.59 E.03513
G1 X87.56 Y79.41 E.39576
G1 X89.38 Y79.41 E.03401
; WIPE_START
G1 F1800
M204 S6000
G1 X89.386 Y81.41 E-.285
; WIPE_END
G1 E-.015
M204 S10000
G17
G3 Z9.6 I1.217 J0 P1  F18000
;===================== date: 20250206 =====================

; don't support timelapse gcode in spiral_mode and by object sequence for I3 structure printer
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
G92 E0
G1 Z9.6
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
            G0 Z9.6 F4000
            G39.3 S1
            G0 Z9.6 F4000
            G392 S0
          
        M623
    
    M623
M623
; SKIPPABLE_END




G1 X88.5 Y80.031
G1 Z9.2
G1 E.3 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.663042
G1 F960
M204 S6000
G1 X88.5 Y99.969 E.6022
; CHANGE_LAYER
; Z_HEIGHT: 9.32
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F2400
G1 X88.5 Y97.969 E-.285
; WIPE_END
G1 E-.015 F1800
; layer num/total_layer_count: 83/102
; update layer progress
M73 L83
M991 S0 P82 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z9.6 I1.216 J.036 P1  F18000
G1 X89.031 Y79.819 Z9.6
G1 Z9.32
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F960
M204 S6000
G1 X89.031 Y100.181 E.40942
G1 X87.969 Y100.181 E.02134
G1 X87.969 Y79.819 E.40942
G1 X88.971 Y79.819 E.02014
M204 S250
G1 X89.44 Y79.41 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F960
M204 S5000
G1 X89.44 Y100.59 E.39576
G1 X87.56 Y100.59 E.03513
G1 X87.56 Y79.41 E.39576
G1 X89.38 Y79.41 E.03401
; WIPE_START
G1 F1800
M204 S6000
G1 X89.386 Y81.41 E-.285
; WIPE_END
G1 E-.015
M204 S10000
G17
G3 Z9.72 I1.217 J0 P1  F18000
;===================== date: 20250206 =====================

; don't support timelapse gcode in spiral_mode and by object sequence for I3 structure printer
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
G92 E0
G1 Z9.72
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
            G0 Z9.72 F4000
            G39.3 S1
            G0 Z9.72 F4000
            G392 S0
          
        M623
    
    M623
M623
; SKIPPABLE_END




M73 P83 R3
G1 X88.5 Y80.031
G1 Z9.32
G1 E.3 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.663042
G1 F960
M204 S6000
G1 X88.5 Y99.969 E.6022
; CHANGE_LAYER
; Z_HEIGHT: 9.44
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F2400
G1 X88.5 Y97.969 E-.285
; WIPE_END
G1 E-.015 F1800
; layer num/total_layer_count: 84/102
; update layer progress
M73 L84
M991 S0 P83 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z9.72 I1.216 J.036 P1  F18000
G1 X89.031 Y79.819 Z9.72
G1 Z9.44
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F960
M204 S6000
G1 X89.031 Y100.181 E.40942
G1 X87.969 Y100.181 E.02134
G1 X87.969 Y79.819 E.40942
G1 X88.971 Y79.819 E.02014
M204 S250
G1 X89.44 Y79.41 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F960
M204 S5000
G1 X89.44 Y100.59 E.39576
G1 X87.56 Y100.59 E.03513
G1 X87.56 Y79.41 E.39576
G1 X89.38 Y79.41 E.03401
; WIPE_START
G1 F1800
M204 S6000
G1 X89.386 Y81.41 E-.285
; WIPE_END
G1 E-.015
M204 S10000
G17
G3 Z9.84 I1.217 J0 P1  F18000
;===================== date: 20250206 =====================

; don't support timelapse gcode in spiral_mode and by object sequence for I3 structure printer
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
G92 E0
G1 Z9.84
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
            G0 Z9.84 F4000
            G39.3 S1
            G0 Z9.84 F4000
            G392 S0
          
        M623
    
    M623
M623
; SKIPPABLE_END




G1 X88.5 Y80.031
G1 Z9.44
G1 E.3 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.663042
G1 F960
M204 S6000
G1 X88.5 Y99.969 E.6022
; CHANGE_LAYER
; Z_HEIGHT: 9.56
; LAYER_HEIGHT: 0.120001
; WIPE_START
G1 F2400
G1 X88.5 Y97.969 E-.285
; WIPE_END
G1 E-.015 F1800
; layer num/total_layer_count: 85/102
; update layer progress
M73 L85
M991 S0 P84 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z9.84 I1.216 J.036 P1  F18000
G1 X89.031 Y79.819 Z9.84
G1 Z9.56
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F960
M204 S6000
G1 X89.031 Y100.181 E.40942
G1 X87.969 Y100.181 E.02134
G1 X87.969 Y79.819 E.40942
G1 X88.971 Y79.819 E.02014
M204 S250
G1 X89.44 Y79.41 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F960
M204 S5000
G1 X89.44 Y100.59 E.39576
G1 X87.56 Y100.59 E.03513
G1 X87.56 Y79.41 E.39576
G1 X89.38 Y79.41 E.03401
; WIPE_START
G1 F1800
M204 S6000
G1 X89.386 Y81.41 E-.285
; WIPE_END
G1 E-.015
M204 S10000
G17
G3 Z9.96 I1.217 J0 P1  F18000
;===================== date: 20250206 =====================

; don't support timelapse gcode in spiral_mode and by object sequence for I3 structure printer
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
G92 E0
G1 Z9.96
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
            G0 Z9.96 F4000
            G39.3 S1
            G0 Z9.96 F4000
            G392 S0
          
        M623
    
    M623
M623
; SKIPPABLE_END




G1 X88.5 Y80.031
G1 Z9.56
G1 E.3 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.663042
G1 F960
M204 S6000
G1 X88.5 Y99.969 E.6022
; CHANGE_LAYER
; Z_HEIGHT: 9.68
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F2400
G1 X88.5 Y97.969 E-.285
; WIPE_END
G1 E-.015 F1800
; layer num/total_layer_count: 86/102
; update layer progress
M73 L86
M991 S0 P85 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z9.96 I1.216 J.036 P1  F18000
G1 X89.031 Y79.819 Z9.96
G1 Z9.68
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F960
M204 S6000
G1 X89.031 Y100.181 E.40942
G1 X87.969 Y100.181 E.02134
G1 X87.969 Y79.819 E.40942
G1 X88.971 Y79.819 E.02014
M204 S250
G1 X89.44 Y79.41 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F960
M204 S5000
G1 X89.44 Y100.59 E.39576
G1 X87.56 Y100.59 E.03513
G1 X87.56 Y79.41 E.39576
G1 X89.38 Y79.41 E.03401
; WIPE_START
G1 F1800
M204 S6000
G1 X89.386 Y81.41 E-.285
; WIPE_END
G1 E-.015
M204 S10000
G17
G3 Z10.08 I1.217 J0 P1  F18000
;===================== date: 20250206 =====================

; don't support timelapse gcode in spiral_mode and by object sequence for I3 structure printer
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
G92 E0
G1 Z10.08
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
            G0 Z10.08 F4000
            G39.3 S1
            G0 Z10.08 F4000
            G392 S0
          
        M623
    
    M623
M623
; SKIPPABLE_END




G1 X88.5 Y80.031
G1 Z9.68
G1 E.3 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.663042
G1 F960
M204 S6000
G1 X88.5 Y99.969 E.6022
; CHANGE_LAYER
; Z_HEIGHT: 9.8
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F2400
G1 X88.5 Y97.969 E-.285
; WIPE_END
G1 E-.015 F1800
; layer num/total_layer_count: 87/102
; update layer progress
M73 L87
M991 S0 P86 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z10.08 I1.216 J.036 P1  F18000
G1 X89.031 Y79.819 Z10.08
G1 Z9.8
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F960
M204 S6000
G1 X89.031 Y100.181 E.40942
G1 X87.969 Y100.181 E.02134
G1 X87.969 Y79.819 E.40942
G1 X88.971 Y79.819 E.02014
M204 S250
G1 X89.44 Y79.41 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F960
M204 S5000
G1 X89.44 Y100.59 E.39576
G1 X87.56 Y100.59 E.03513
G1 X87.56 Y79.41 E.39576
G1 X89.38 Y79.41 E.03401
; WIPE_START
G1 F1800
M204 S6000
G1 X89.386 Y81.41 E-.285
; WIPE_END
G1 E-.015
M204 S10000
G17
G3 Z10.2 I1.217 J0 P1  F18000
;===================== date: 20250206 =====================

; don't support timelapse gcode in spiral_mode and by object sequence for I3 structure printer
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
G92 E0
G1 Z10.2
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
            G0 Z10.2 F4000
            G39.3 S1
            G0 Z10.2 F4000
            G392 S0
          
        M623
    
    M623
M623
; SKIPPABLE_END




G1 X88.5 Y80.031
G1 Z9.8
G1 E.3 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.663042
G1 F960
M204 S6000
G1 X88.5 Y99.969 E.6022
; CHANGE_LAYER
; Z_HEIGHT: 9.92
; LAYER_HEIGHT: 0.12
; WIPE_START
M73 P84 R3
G1 F2400
G1 X88.5 Y97.969 E-.285
; WIPE_END
G1 E-.015 F1800
; layer num/total_layer_count: 88/102
; update layer progress
M73 L88
M991 S0 P87 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z10.2 I1.216 J.036 P1  F18000
G1 X89.031 Y79.819 Z10.2
G1 Z9.92
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F960
M204 S6000
G1 X89.031 Y100.181 E.40942
G1 X87.969 Y100.181 E.02134
G1 X87.969 Y79.819 E.40942
G1 X88.971 Y79.819 E.02014
M204 S250
G1 X89.44 Y79.41 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F960
M204 S5000
G1 X89.44 Y100.59 E.39576
G1 X87.56 Y100.59 E.03513
G1 X87.56 Y79.41 E.39576
G1 X89.38 Y79.41 E.03401
; WIPE_START
G1 F1800
M204 S6000
G1 X89.386 Y81.41 E-.285
; WIPE_END
G1 E-.015
M204 S10000
G17
G3 Z10.32 I1.217 J0 P1  F18000
;===================== date: 20250206 =====================

; don't support timelapse gcode in spiral_mode and by object sequence for I3 structure printer
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
G92 E0
G1 Z10.32
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
            G0 Z10.32 F4000
            G39.3 S1
            G0 Z10.32 F4000
            G392 S0
          
        M623
    
    M623
M623
; SKIPPABLE_END




G1 X88.5 Y80.031
G1 Z9.92
G1 E.3 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.663042
G1 F960
M204 S6000
G1 X88.5 Y99.969 E.6022
; CHANGE_LAYER
; Z_HEIGHT: 10.04
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F2400
G1 X88.5 Y97.969 E-.285
; WIPE_END
G1 E-.015 F1800
; layer num/total_layer_count: 89/102
; update layer progress
M73 L89
M991 S0 P88 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z10.32 I1.216 J.036 P1  F18000
G1 X89.031 Y79.819 Z10.32
G1 Z10.04
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F960
M204 S6000
G1 X89.031 Y100.181 E.40942
G1 X87.969 Y100.181 E.02134
G1 X87.969 Y79.819 E.40942
G1 X88.971 Y79.819 E.02014
M204 S250
G1 X89.44 Y79.41 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F960
M204 S5000
G1 X89.44 Y100.59 E.39576
G1 X87.56 Y100.59 E.03513
G1 X87.56 Y79.41 E.39576
M73 P85 R3
G1 X89.38 Y79.41 E.03401
; WIPE_START
G1 F1800
M204 S6000
G1 X89.386 Y81.41 E-.285
; WIPE_END
G1 E-.015
M204 S10000
G17
G3 Z10.44 I1.217 J0 P1  F18000
;===================== date: 20250206 =====================

; don't support timelapse gcode in spiral_mode and by object sequence for I3 structure printer
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
G92 E0
G1 Z10.44
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
            G0 Z10.44 F4000
            G39.3 S1
            G0 Z10.44 F4000
            G392 S0
          
        M623
    
    M623
M623
; SKIPPABLE_END




G1 X88.5 Y80.031
G1 Z10.04
G1 E.3 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.663042
G1 F960
M204 S6000
G1 X88.5 Y99.969 E.6022
; CHANGE_LAYER
; Z_HEIGHT: 10.16
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F2400
G1 X88.5 Y97.969 E-.285
; WIPE_END
G1 E-.015 F1800
; layer num/total_layer_count: 90/102
; update layer progress
M73 L90
M991 S0 P89 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z10.44 I1.216 J.036 P1  F18000
G1 X89.031 Y79.819 Z10.44
G1 Z10.16
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F960
M204 S6000
G1 X89.031 Y100.181 E.40942
G1 X87.969 Y100.181 E.02134
G1 X87.969 Y79.819 E.40942
G1 X88.971 Y79.819 E.02014
M204 S250
G1 X89.44 Y79.41 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F960
M204 S5000
G1 X89.44 Y100.59 E.39576
G1 X87.56 Y100.59 E.03513
G1 X87.56 Y79.41 E.39576
G1 X89.38 Y79.41 E.03401
; WIPE_START
G1 F1800
M204 S6000
G1 X89.386 Y81.41 E-.285
; WIPE_END
G1 E-.015
M204 S10000
G17
G3 Z10.56 I1.217 J0 P1  F18000
;===================== date: 20250206 =====================

; don't support timelapse gcode in spiral_mode and by object sequence for I3 structure printer
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
G92 E0
G1 Z10.56
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
            G0 Z10.56 F4000
            G39.3 S1
            G0 Z10.56 F4000
            G392 S0
          
        M623
    
    M623
M623
; SKIPPABLE_END




G1 X88.5 Y80.031
G1 Z10.16
G1 E.3 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.663042
G1 F960
M204 S6000
G1 X88.5 Y99.969 E.6022
; CHANGE_LAYER
; Z_HEIGHT: 10.28
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F2400
M73 P86 R3
G1 X88.5 Y97.969 E-.285
; WIPE_END
G1 E-.015 F1800
; layer num/total_layer_count: 91/102
; update layer progress
M73 L91
M991 S0 P90 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z10.56 I1.216 J.036 P1  F18000
G1 X89.031 Y79.819 Z10.56
G1 Z10.28
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F960
M204 S6000
G1 X89.031 Y100.181 E.40942
G1 X87.969 Y100.181 E.02134
G1 X87.969 Y79.819 E.40942
G1 X88.971 Y79.819 E.02014
M204 S250
G1 X89.44 Y79.41 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F960
M204 S5000
G1 X89.44 Y100.59 E.39576
G1 X87.56 Y100.59 E.03513
G1 X87.56 Y79.41 E.39576
G1 X89.38 Y79.41 E.03401
; WIPE_START
G1 F1800
M204 S6000
G1 X89.386 Y81.41 E-.285
; WIPE_END
G1 E-.015
M204 S10000
G17
G3 Z10.68 I1.217 J0 P1  F18000
;===================== date: 20250206 =====================

; don't support timelapse gcode in spiral_mode and by object sequence for I3 structure printer
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
G92 E0
G1 Z10.68
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
            G0 Z10.68 F4000
            G39.3 S1
            G0 Z10.68 F4000
            G392 S0
          
        M623
    
    M623
M623
; SKIPPABLE_END




G1 X88.5 Y80.031
G1 Z10.28
G1 E.3 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.663042
G1 F960
M204 S6000
G1 X88.5 Y99.969 E.6022
; CHANGE_LAYER
; Z_HEIGHT: 10.4
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F2400
G1 X88.5 Y97.969 E-.285
; WIPE_END
G1 E-.015 F1800
; layer num/total_layer_count: 92/102
; update layer progress
M73 L92
M991 S0 P91 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z10.68 I1.216 J.036 P1  F18000
G1 X89.031 Y79.819 Z10.68
G1 Z10.4
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F960
M204 S6000
G1 X89.031 Y100.181 E.40942
G1 X87.969 Y100.181 E.02134
G1 X87.969 Y79.819 E.40942
G1 X88.971 Y79.819 E.02014
M204 S250
G1 X89.44 Y79.41 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F960
M204 S5000
G1 X89.44 Y100.59 E.39576
G1 X87.56 Y100.59 E.03513
G1 X87.56 Y79.41 E.39576
G1 X89.38 Y79.41 E.03401
; WIPE_START
G1 F1800
M204 S6000
G1 X89.386 Y81.41 E-.285
; WIPE_END
G1 E-.015
M204 S10000
G17
M73 P87 R2
G3 Z10.8 I1.217 J0 P1  F18000
;===================== date: 20250206 =====================

; don't support timelapse gcode in spiral_mode and by object sequence for I3 structure printer
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
G92 E0
G1 Z10.8
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
            G0 Z10.8 F4000
            G39.3 S1
            G0 Z10.8 F4000
            G392 S0
          
        M623
    
    M623
M623
; SKIPPABLE_END




G1 X88.5 Y80.031
G1 Z10.4
G1 E.3 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.663042
G1 F960
M204 S6000
G1 X88.5 Y99.969 E.6022
; CHANGE_LAYER
; Z_HEIGHT: 10.52
; LAYER_HEIGHT: 0.120001
; WIPE_START
G1 F2400
G1 X88.5 Y97.969 E-.285
; WIPE_END
G1 E-.015 F1800
; layer num/total_layer_count: 93/102
; update layer progress
M73 L93
M991 S0 P92 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z10.8 I1.216 J.036 P1  F18000
G1 X89.031 Y79.819 Z10.8
G1 Z10.52
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F960
M204 S6000
G1 X89.031 Y100.181 E.40942
G1 X87.969 Y100.181 E.02134
G1 X87.969 Y79.819 E.40942
G1 X88.971 Y79.819 E.02014
M204 S250
G1 X89.44 Y79.41 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F960
M204 S5000
G1 X89.44 Y100.59 E.39576
G1 X87.56 Y100.59 E.03513
G1 X87.56 Y79.41 E.39576
G1 X89.38 Y79.41 E.03401
; WIPE_START
G1 F1800
M204 S6000
G1 X89.386 Y81.41 E-.285
; WIPE_END
G1 E-.015
M204 S10000
G17
G3 Z10.92 I1.217 J0 P1  F18000
;===================== date: 20250206 =====================

; don't support timelapse gcode in spiral_mode and by object sequence for I3 structure printer
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
G92 E0
G1 Z10.92
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
            G0 Z10.92 F4000
            G39.3 S1
            G0 Z10.92 F4000
            G392 S0
          
        M623
    
    M623
M623
; SKIPPABLE_END




G1 X88.5 Y80.031
G1 Z10.52
G1 E.3 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.663042
G1 F960
M204 S6000
G1 X88.5 Y99.969 E.6022
; CHANGE_LAYER
; Z_HEIGHT: 10.64
; LAYER_HEIGHT: 0.12
; WIPE_START
M73 P88 R2
G1 F2400
G1 X88.5 Y97.969 E-.285
; WIPE_END
G1 E-.015 F1800
; layer num/total_layer_count: 94/102
; update layer progress
M73 L94
M991 S0 P93 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z10.92 I1.216 J.036 P1  F18000
G1 X89.031 Y79.819 Z10.92
G1 Z10.64
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F960
M204 S6000
G1 X89.031 Y100.181 E.40942
G1 X87.969 Y100.181 E.02134
G1 X87.969 Y79.819 E.40942
G1 X88.971 Y79.819 E.02014
M204 S250
G1 X89.44 Y79.41 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F960
M204 S5000
G1 X89.44 Y100.59 E.39576
G1 X87.56 Y100.59 E.03513
G1 X87.56 Y79.41 E.39576
G1 X89.38 Y79.41 E.03401
; WIPE_START
G1 F1800
M204 S6000
G1 X89.386 Y81.41 E-.285
; WIPE_END
G1 E-.015
M204 S10000
G17
G3 Z11.04 I1.217 J0 P1  F18000
;===================== date: 20250206 =====================

; don't support timelapse gcode in spiral_mode and by object sequence for I3 structure printer
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
G92 E0
G1 Z11.04
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
            G0 Z11.04 F4000
            G39.3 S1
            G0 Z11.04 F4000
            G392 S0
          
        M623
    
    M623
M623
; SKIPPABLE_END




G1 X88.5 Y80.031
G1 Z10.64
G1 E.3 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.663042
G1 F960
M204 S6000
G1 X88.5 Y99.969 E.6022
; CHANGE_LAYER
; Z_HEIGHT: 10.76
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F2400
G1 X88.5 Y97.969 E-.285
; WIPE_END
G1 E-.015 F1800
; layer num/total_layer_count: 95/102
; update layer progress
M73 L95
M991 S0 P94 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z11.04 I1.216 J.036 P1  F18000
G1 X89.031 Y79.819 Z11.04
G1 Z10.76
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F960
M204 S6000
G1 X89.031 Y100.181 E.40942
G1 X87.969 Y100.181 E.02134
G1 X87.969 Y79.819 E.40942
G1 X88.971 Y79.819 E.02014
M204 S250
G1 X89.44 Y79.41 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F960
M204 S5000
G1 X89.44 Y100.59 E.39576
G1 X87.56 Y100.59 E.03513
G1 X87.56 Y79.41 E.39576
G1 X89.38 Y79.41 E.03401
; WIPE_START
M73 P89 R2
G1 F1800
M204 S6000
G1 X89.386 Y81.41 E-.285
; WIPE_END
G1 E-.015
M204 S10000
G17
G3 Z11.16 I1.217 J0 P1  F18000
;===================== date: 20250206 =====================

; don't support timelapse gcode in spiral_mode and by object sequence for I3 structure printer
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
G92 E0
G1 Z11.16
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
            G0 Z11.16 F4000
            G39.3 S1
            G0 Z11.16 F4000
            G392 S0
          
        M623
    
    M623
M623
; SKIPPABLE_END




G1 X88.5 Y80.031
G1 Z10.76
G1 E.3 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.663042
G1 F960
M204 S6000
G1 X88.5 Y99.969 E.6022
; CHANGE_LAYER
; Z_HEIGHT: 10.88
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F2400
G1 X88.5 Y97.969 E-.285
; WIPE_END
G1 E-.015 F1800
; layer num/total_layer_count: 96/102
; update layer progress
M73 L96
M991 S0 P95 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z11.16 I1.216 J.036 P1  F18000
G1 X89.031 Y79.819 Z11.16
G1 Z10.88
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F960
M204 S6000
G1 X89.031 Y100.181 E.40942
G1 X87.969 Y100.181 E.02134
G1 X87.969 Y79.819 E.40942
G1 X88.971 Y79.819 E.02014
M204 S250
G1 X89.44 Y79.41 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F960
M204 S5000
G1 X89.44 Y100.59 E.39576
G1 X87.56 Y100.59 E.03513
G1 X87.56 Y79.41 E.39576
G1 X89.38 Y79.41 E.03401
; WIPE_START
G1 F1800
M204 S6000
G1 X89.386 Y81.41 E-.285
; WIPE_END
G1 E-.015
M204 S10000
G17
G3 Z11.28 I1.217 J0 P1  F18000
;===================== date: 20250206 =====================

; don't support timelapse gcode in spiral_mode and by object sequence for I3 structure printer
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
G92 E0
G1 Z11.28
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
            G0 Z11.28 F4000
            G39.3 S1
            G0 Z11.28 F4000
            G392 S0
          
        M623
    
    M623
M623
; SKIPPABLE_END




G1 X88.5 Y80.031
G1 Z10.88
G1 E.3 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.663042
G1 F960
M204 S6000
G1 X88.5 Y99.969 E.6022
; CHANGE_LAYER
; Z_HEIGHT: 11
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F2400
G1 X88.5 Y97.969 E-.285
; WIPE_END
G1 E-.015 F1800
; layer num/total_layer_count: 97/102
; update layer progress
M73 L97
M991 S0 P96 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z11.28 I1.216 J.036 P1  F18000
M73 P90 R2
G1 X89.031 Y79.819 Z11.28
G1 Z11
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F960
M204 S6000
G1 X89.031 Y100.181 E.40942
G1 X87.969 Y100.181 E.02134
G1 X87.969 Y79.819 E.40942
G1 X88.971 Y79.819 E.02014
M204 S250
G1 X89.44 Y79.41 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F960
M204 S5000
G1 X89.44 Y100.59 E.39576
G1 X87.56 Y100.59 E.03513
G1 X87.56 Y79.41 E.39576
G1 X89.38 Y79.41 E.03401
; WIPE_START
G1 F1800
M204 S6000
G1 X89.386 Y81.41 E-.285
; WIPE_END
G1 E-.015
M204 S10000
G17
G3 Z11.4 I1.217 J0 P1  F18000
;===================== date: 20250206 =====================

; don't support timelapse gcode in spiral_mode and by object sequence for I3 structure printer
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
G92 E0
G1 Z11.4
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
            G0 Z11.4 F4000
            G39.3 S1
            G0 Z11.4 F4000
            G392 S0
          
        M623
    
    M623
M623
; SKIPPABLE_END




G1 X88.5 Y80.031
G1 Z11
G1 E.3 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.663042
G1 F960
M204 S6000
G1 X88.5 Y99.969 E.6022
; CHANGE_LAYER
; Z_HEIGHT: 11.12
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F2400
G1 X88.5 Y97.969 E-.285
; WIPE_END
G1 E-.015 F1800
; layer num/total_layer_count: 98/102
; update layer progress
M73 L98
M991 S0 P97 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z11.4 I1.216 J.036 P1  F18000
G1 X89.031 Y79.819 Z11.4
G1 Z11.12
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F960
M204 S6000
G1 X89.031 Y100.181 E.40942
G1 X87.969 Y100.181 E.02134
G1 X87.969 Y79.819 E.40942
G1 X88.971 Y79.819 E.02014
M204 S250
G1 X89.44 Y79.41 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F960
M204 S5000
G1 X89.44 Y100.59 E.39576
G1 X87.56 Y100.59 E.03513
G1 X87.56 Y79.41 E.39576
G1 X89.38 Y79.41 E.03401
; WIPE_START
G1 F1800
M204 S6000
G1 X89.386 Y81.41 E-.285
; WIPE_END
G1 E-.015
M204 S10000
G17
G3 Z11.52 I1.217 J0 P1  F18000
;===================== date: 20250206 =====================

; don't support timelapse gcode in spiral_mode and by object sequence for I3 structure printer
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
G92 E0
G1 Z11.52
G1 X0 Y90 ; move to safe pos
M73 P91 R2
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
            G0 Z11.52 F4000
            G39.3 S1
            G0 Z11.52 F4000
            G392 S0
          
        M623
    
    M623
M623
; SKIPPABLE_END




G1 X88.5 Y80.031
G1 Z11.12
G1 E.3 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.663042
G1 F960
M204 S6000
G1 X88.5 Y99.969 E.6022
; CHANGE_LAYER
; Z_HEIGHT: 11.24
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F2400
G1 X88.5 Y97.969 E-.285
; WIPE_END
G1 E-.015 F1800
; layer num/total_layer_count: 99/102
; update layer progress
M73 L99
M991 S0 P98 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z11.52 I1.216 J.036 P1  F18000
G1 X89.031 Y79.819 Z11.52
G1 Z11.24
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F960
M204 S6000
M73 P91 R1
G1 X89.031 Y100.181 E.40942
G1 X87.969 Y100.181 E.02134
G1 X87.969 Y79.819 E.40942
G1 X88.971 Y79.819 E.02014
M204 S250
G1 X89.44 Y79.41 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F960
M204 S5000
G1 X89.44 Y100.59 E.39576
G1 X87.56 Y100.59 E.03513
G1 X87.56 Y79.41 E.39576
G1 X89.38 Y79.41 E.03401
; WIPE_START
G1 F1800
M204 S6000
G1 X89.386 Y81.41 E-.285
; WIPE_END
G1 E-.015
M204 S10000
G17
G3 Z11.64 I1.217 J0 P1  F18000
;===================== date: 20250206 =====================

; don't support timelapse gcode in spiral_mode and by object sequence for I3 structure printer
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
G92 E0
G1 Z11.64
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
            G0 Z11.64 F4000
            G39.3 S1
            G0 Z11.64 F4000
            G392 S0
          
        M623
    
    M623
M623
; SKIPPABLE_END




G1 X88.5 Y80.031
G1 Z11.24
G1 E.3 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.663042
G1 F960
M204 S6000
G1 X88.5 Y99.969 E.6022
; CHANGE_LAYER
; Z_HEIGHT: 11.36
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F2400
G1 X88.5 Y97.969 E-.285
; WIPE_END
G1 E-.015 F1800
; layer num/total_layer_count: 100/102
; update layer progress
M73 L100
M991 S0 P99 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z11.64 I1.216 J.036 P1  F18000
G1 X89.031 Y79.819 Z11.64
G1 Z11.36
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F960
M204 S6000
G1 X89.031 Y100.181 E.40942
G1 X87.969 Y100.181 E.02134
M73 P92 R1
G1 X87.969 Y79.819 E.40942
G1 X88.971 Y79.819 E.02014
M204 S250
G1 X89.44 Y79.41 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F960
M204 S5000
G1 X89.44 Y100.59 E.39576
G1 X87.56 Y100.59 E.03513
G1 X87.56 Y79.41 E.39576
G1 X89.38 Y79.41 E.03401
; WIPE_START
G1 F1800
M204 S6000
G1 X89.386 Y81.41 E-.285
; WIPE_END
G1 E-.015
M204 S10000
G17
G3 Z11.76 I1.217 J0 P1  F18000
;===================== date: 20250206 =====================

; don't support timelapse gcode in spiral_mode and by object sequence for I3 structure printer
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
G92 E0
G1 Z11.76
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
            G0 Z11.76 F4000
            G39.3 S1
            G0 Z11.76 F4000
            G392 S0
          
        M623
    
    M623
M623
; SKIPPABLE_END




G1 X88.5 Y80.031
G1 Z11.36
G1 E.3 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.663042
G1 F960
M204 S6000
G1 X88.5 Y99.969 E.6022
; CHANGE_LAYER
; Z_HEIGHT: 11.48
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F2400
G1 X88.5 Y97.969 E-.285
; WIPE_END
G1 E-.015 F1800
; layer num/total_layer_count: 101/102
; update layer progress
M73 L101
M991 S0 P100 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z11.76 I1.216 J.036 P1  F18000
G1 X89.031 Y79.819 Z11.76
G1 Z11.48
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F960
M204 S6000
G1 X89.031 Y100.181 E.40942
G1 X87.969 Y100.181 E.02134
G1 X87.969 Y79.819 E.40942
G1 X88.971 Y79.819 E.02014
M204 S250
G1 X89.44 Y79.41 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F960
M204 S5000
G1 X89.44 Y100.59 E.39576
G1 X87.56 Y100.59 E.03513
G1 X87.56 Y79.41 E.39576
G1 X89.38 Y79.41 E.03401
; WIPE_START
G1 F1800
M204 S6000
G1 X89.386 Y81.41 E-.285
; WIPE_END
G1 E-.015
M204 S10000
G17
G3 Z11.88 I1.217 J0 P1  F18000
;===================== date: 20250206 =====================

; don't support timelapse gcode in spiral_mode and by object sequence for I3 structure printer
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
G92 E0
G1 Z11.88
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
            G0 Z11.88 F4000
            G39.3 S1
            G0 Z11.88 F4000
            G392 S0
          
        M623
    
    M623
M623
; SKIPPABLE_END




M73 P93 R1
G1 X88.5 Y80.031
G1 Z11.48
G1 E.3 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.663042
G1 F960
M204 S6000
G1 X88.5 Y99.969 E.6022
; CHANGE_LAYER
; Z_HEIGHT: 11.6
; LAYER_HEIGHT: 0.120001
; WIPE_START
G1 F2400
G1 X88.5 Y97.969 E-.285
; WIPE_END
G1 E-.015 F1800
; layer num/total_layer_count: 102/102
; update layer progress
M73 L102
M991 S0 P101 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z11.88 I1.215 J.062 P1  F18000
G1 X89.44 Y79.41 Z11.88
G1 Z11.6
G1 E.3 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1285
M204 S5000
G1 X89.44 Y100.59 E.39576
G1 X87.56 Y100.59 E.03513
G1 X87.56 Y79.41 E.39576
G1 X89.38 Y79.41 E.03401
; WIPE_START
G1 F1800
M204 S6000
G1 X89.386 Y81.41 E-.285
; WIPE_END
G1 E-.015
M204 S10000
G17
G3 Z12 I1.217 J0 P1  F18000
;===================== date: 20250206 =====================

; don't support timelapse gcode in spiral_mode and by object sequence for I3 structure printer
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
G92 E0
G1 Z12
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
            G0 Z12 F4000
            G39.3 S1
            G0 Z12 F4000
            G392 S0
          
        M623
    
    M623
M623
; SKIPPABLE_END




G1 X88.826 Y100.373
G1 Z11.6
G1 E.3 F1800
; FEATURE: Top surface
G1 F1285
M204 S2000
G1 X89.223 Y99.976 E.01049
G1 X89.223 Y99.419
G1 X88.269 Y100.373 E.02522
G1 X87.777 Y100.307
G1 X89.223 Y98.861 E.03822
G1 X89.223 Y98.304
G1 X87.777 Y99.75 E.03822
G1 X87.777 Y99.192
G1 X89.223 Y97.746 E.03822
G1 X89.223 Y97.188
G1 X87.777 Y98.635 E.03822
G1 X87.777 Y98.077
G1 X89.223 Y96.631 E.03822
G1 X89.223 Y96.073
G1 X87.777 Y97.52 E.03822
G1 X87.777 Y96.962
G1 X89.223 Y95.516 E.03822
G1 X89.223 Y94.958
G1 X87.777 Y96.405 E.03822
M73 P94 R1
G1 X87.777 Y95.847
G1 X89.223 Y94.401 E.03822
G1 X89.223 Y93.843
G1 X87.777 Y95.29 E.03822
G1 X87.777 Y94.732
G1 X89.223 Y93.286 E.03822
G1 X89.223 Y92.728
G1 X87.777 Y94.174 E.03822
G1 X87.777 Y93.617
G1 X89.223 Y92.171 E.03822
G1 X89.223 Y91.613
G1 X87.777 Y93.059 E.03822
G1 X87.777 Y92.502
G1 X89.223 Y91.056 E.03822
G1 X89.223 Y90.498
G1 X87.777 Y91.944 E.03822
G1 X87.777 Y91.387
G1 X89.223 Y89.94 E.03822
G1 X89.223 Y89.383
G1 X87.777 Y90.829 E.03822
G1 X87.777 Y90.272
G1 X89.223 Y88.825 E.03822
G1 X89.223 Y88.268
G1 X87.777 Y89.714 E.03822
G1 X87.777 Y89.157
G1 X89.223 Y87.71 E.03822
G1 X89.223 Y87.153
G1 X87.777 Y88.599 E.03822
G1 X87.777 Y88.042
G1 X89.223 Y86.595 E.03822
G1 X89.223 Y86.038
G1 X87.777 Y87.484 E.03822
G1 X87.777 Y86.926
G1 X89.223 Y85.48 E.03822
G1 X89.223 Y84.923
G1 X87.777 Y86.369 E.03822
G1 X87.777 Y85.811
G1 X89.223 Y84.365 E.03822
G1 X89.223 Y83.808
G1 X87.777 Y85.254 E.03822
G1 X87.777 Y84.696
G1 X89.223 Y83.25 E.03822
G1 X89.223 Y82.692
G1 X87.777 Y84.139 E.03822
G1 X87.777 Y83.581
G1 X89.223 Y82.135 E.03822
G1 X89.223 Y81.577
M73 P95 R1
G1 X87.777 Y83.024 E.03822
G1 X87.777 Y82.466
G1 X89.223 Y81.02 E.03822
G1 X89.223 Y80.462
G1 X87.777 Y81.909 E.03822
G1 X87.777 Y81.351
G1 X89.223 Y79.905 E.03822
G1 X88.944 Y79.627
G1 X87.777 Y80.794 E.03083
G1 X87.777 Y80.236
G1 X88.386 Y79.627 E.0161
; close powerlost recovery
M1003 S0
; WIPE_START
G1 F3600
M204 S6000
G1 X87.777 Y80.236 E-.12277
G1 X87.777 Y80.794 E-.07945
G1 X88.188 Y80.383 E-.08278
; WIPE_END
G1 E-.015 F1800
M204 S10000
G17
G3 Z12 I1.217 J0 P1  F18000
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
G1 Z12 F900 ; lower z a little
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

    G1 Z111.6 F600
    G1 Z109.6

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

