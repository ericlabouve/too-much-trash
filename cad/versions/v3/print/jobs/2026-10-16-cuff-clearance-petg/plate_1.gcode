; HEADER_BLOCK_START
; BambuStudio 02.07.01.62
; model printing time: 12m 53s; total estimated time: 20m 1s
; total layer number: 57
; total filament length [mm] : 370.01
; total filament volume [cm^3] : 889.97
; total filament weight [g] : 1.11
; model label id: 8,12,16
; object max height: 6.92,4.04,2.96
; filament_density: 1.25
; filament_diameter: 1.75
; max_z_height: 6.92
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
M73 P0 R20
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
    G29 A1 X57.7063 Y79.6 I63.3937 J10.8
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
    
M73 P28 R14
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
    
M73 P29 R14
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
; layer num/total_layer_count: 1/57
; update layer progress
M73 L1
M991 S0 P0 ;notify layer change
M106 S0
; OBJECT_ID: 16
; start printing object, unique label id: 16
M624 BAAAAAAAAAA=
G1 X112.064 Y85.309 F18000
M204 S6000
G1 Z.4
M73 P32 R13
G1 Z.2
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.5
M204 S500
G1 X112.064 Y84.691 E.02232
G1 X119.909 Y84.691 E.28325
G1 X119.909 Y85.309 E.02232
G1 X112.124 Y85.309 E.28108
; WIPE_START
G1 X112.064 Y84.691 E-.08849
M73 P33 R13
G1 X113.443 Y84.691 E-.19651
; WIPE_END
G1 E-.015
M204 S6000
G1 X109.65 Y85.193 Z.6 F18000
G1 Z.2
G1 E.3 F1800
M204 S500
G1 X109.634 Y85.193 E.00058
G1 X109.634 Y84.807 E.01393
G1 X111.607 Y84.807 E.07124
G1 X111.607 Y84.234 E.02069
G1 X120.366 Y84.234 E.31625
G1 X120.366 Y85.766 E.05532
G1 X111.607 Y85.766 E.31625
G1 X111.607 Y85.193 E.02069
G1 X109.71 Y85.193 E.06849
; WIPE_START
M73 P34 R13
G1 X109.634 Y85.193 E-.01085
M73 P35 R12
G1 X109.634 Y84.807 E-.05499
G1 X111.172 Y84.807 E-.21917
; WIPE_END
G1 E-.015
M204 S6000
G1 X109.65 Y86.223 Z.6 F18000
G1 Z.2
G1 E.3 F1800
; FEATURE: Outer wall
M204 S500
G1 X109.177 Y86.222 E.01708
G1 X109.177 Y83.777 E.08828
G1 X109.65 Y83.777 E.01708
G1 X109.65 Y84.35 E.02069
G1 X111.15 Y84.35 E.05416
G1 X111.15 Y83.777 E.02069
G1 X120.177 Y83.777 E.32592
G1 X120.177 Y81.778 E.07217
G1 X120.823 Y81.78 E.02334
G1 X120.823 Y88.223 E.23264
G1 X120.177 Y88.223 E.02334
G1 X120.177 Y86.223 E.0722
G1 X111.15 Y86.223 E.32592
G1 X111.15 Y85.65 E.02069
G1 X109.65 Y85.65 E.05416
G1 X109.65 Y86.163 E.01851
; WIPE_START
G1 X109.177 Y86.222 E-.06795
G1 X109.177 Y84.699 E-.21705
; WIPE_END
G1 E-.015
M204 S6000
G17
G3 Z.6 I1.217 J0 P1  F18000
; stop printing object, unique label id: 16
M625
; object ids of layer 1 start: 8,12,16
M624 BwAAAAAAAAA=
;===================== date: 20250206 =====================

; don't support timelapse gcode in spiral_mode and by object sequence for I3 structure printer
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
G92 E0
G1 Z0.6
G1 X0 Y85.0002 ; move to safe pos
G1 X-13.0 F3000 ; move to safe pos
M400
M1004 S5 P1  ; external shutter
M400 P300
M971 S11 C11 O0
G92 E0
G1 X0 F18000
M623

; SKIPTYPE: head_wrap_detect
M622.1 S1
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




; object ids of this layer1 end: 8,12,16
M625
; start printing object, unique label id: 16
M624 BAAAAAAAAAA=
G1 X112.293 Y85
G1 Z.2
G1 E.3 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.203961
M204 S500
G1 X119.68 Y85 E.09398
; WIPE_START
G1 X117.68 Y85 E-.285
; WIPE_END
G1 E-.015
M204 S6000
G1 X120.5 Y85.995 Z.6 F18000
G1 Z.2
G1 E.3 F1800
; LINE_WIDTH: 0.232192
M204 S500
G1 X120.5 Y87.994 E.0299
; WIPE_START
G1 X120.5 Y85.995 E-.285
; WIPE_END
G1 E-.015
M204 S6000
G1 X120.5 Y84.005 Z.6 F18000
G1 Z.2
G1 E.3 F1800
; LINE_WIDTH: 0.232218
M204 S500
G1 X120.5 Y82.007 E.02987
; OBJECT_ID: 12
; WIPE_START
G1 X120.5 Y84.005 E-.285
; WIPE_END
G1 E-.015
; stop printing object, unique label id: 16
M625
; start printing object, unique label id: 12
M624 AgAAAAAAAAA=
M204 S6000
G1 X112.909 Y84.801 Z.6 F18000
G1 X88.05 Y87.407 Z.6
G1 Z.2
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.5
M204 S500
G1 X87.593 Y87.407 E.0165
G1 X87.593 Y82.593 E.17382
G1 X92.407 Y82.593 E.17382
G1 X92.407 Y87.407 E.17382
G1 X88.11 Y87.407 E.15515
M204 S6000
G1 X88.05 Y86.95 F18000
; FEATURE: Outer wall
G1 F1800
M204 S500
M73 P36 R12
G1 X88.05 Y83.05 E.14081
G1 X91.95 Y83.05 E.14081
G1 X91.95 Y86.95 E.14081
G1 X88.11 Y86.95 E.13865
; WIPE_START
G1 X88.079 Y84.95 E-.285
; WIPE_END
G1 E-.015
M204 S6000
G1 X87.064 Y80.765 Z.6 F18000
G1 Z.2
G1 E.3 F1800
; FEATURE: Inner wall
M204 S500
G1 X92.935 Y80.773 E.21199
G1 X92.936 Y82.136 E.04922
G1 X87.064 Y82.136 E.21199
G1 X87.064 Y80.825 E.04732
; WIPE_START
G1 X89.064 Y80.807 E-.285
; WIPE_END
G1 E-.015
M204 S6000
G1 X87.064 Y87.864 Z.6 F18000
G1 Z.2
G1 E.3 F1800
M204 S500
G1 X92.936 Y87.864 E.212
G1 X92.936 Y89.236 E.04953
G1 X87.064 Y89.236 E.212
G1 X87.064 Y87.924 E.04736
; WIPE_START
G1 X89.064 Y87.904 E-.285
; WIPE_END
G1 E-.015
M204 S6000
G1 X86.715 Y80.642 Z.6 F18000
G1 X86.607 Y80.308 Z.6
G1 Z.2
G1 E.3 F1800
M204 S500
G1 X93.393 Y80.316 E.245
G1 X93.393 Y89.693 E.33855
G1 X86.607 Y89.693 E.24501
G1 X86.607 Y80.368 E.3367
M204 S6000
G1 X86.277 Y79.886 F18000
; FEATURE: Outer wall
G1 F1800
M204 S500
G1 X86.412 Y79.85 E.00506
G1 X93.66 Y79.86 E.26169
G1 X93.773 Y79.927 E.00475
G1 X93.828 Y80.008 E.00354
G1 X93.85 Y80.108 E.00367
G1 X93.85 Y89.88 E.35285
G1 X93.835 Y89.976 E.00351
G1 X93.797 Y90.05 E.00297
G1 X93.712 Y90.121 E.00402
G1 X93.585 Y90.15 E.00471
G1 X86.42 Y90.15 E.25872
G1 X86.324 Y90.135 E.00351
G1 X86.25 Y90.097 E.00297
G1 X86.179 Y90.013 E.00401
G1 X86.15 Y89.885 E.00472
G1 X86.15 Y80.12 E.35259
G1 X86.165 Y80.024 E.00351
G1 X86.203 Y79.95 E.00298
G1 X86.232 Y79.925 E.00138
; WIPE_START
G1 X86.412 Y79.85 E-.02789
G1 X88.217 Y79.853 E-.25711
; WIPE_END
G1 E-.015
M204 S6000
G1 X87.1 Y82.364 Z.6 F18000
G1 Z.2
G1 E.3 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.57172
M204 S500
G1 X87.1 Y87.636 E.22018
; WIPE_START
G1 X87.1 Y85.636 E-.285
; WIPE_END
G1 E-.015
M204 S6000
G1 X92.9 Y87.636 Z.6 F18000
G1 Z.2
G1 E.3 F1800
; LINE_WIDTH: 0.571521
M204 S500
G1 X92.9 Y82.364 E.22009
; WIPE_START
G1 X92.9 Y84.364 E-.285
; WIPE_END
G1 E-.015
M204 S6000
G1 X91.808 Y80.954 Z.6 F18000
G1 Z.2
G1 E.3 F1800
; FEATURE: Bottom surface
; LINE_WIDTH: 0.50926
G1 F3000
M204 S500
G1 X92.547 Y81.693 E.03851
G1 X92.547 Y81.747 E.002
G1 X91.942 Y81.747 E.0223
G1 X91.354 Y81.159 E.03065
G1 X90.693 Y81.158 E.02432
G1 X91.282 Y81.747 E.03069
G1 X90.623 Y81.747 E.02429
G1 X90.033 Y81.158 E.03073
G1 X89.373 Y81.157 E.02432
G1 X89.963 Y81.747 E.03078
G1 X89.304 Y81.747 E.02429
G1 X88.712 Y81.156 E.03082
G1 X88.052 Y81.155 E.02433
G1 X88.644 Y81.747 E.03086
G1 X87.985 Y81.747 E.02429
G1 X87.247 Y81.01 E.03844
; WIPE_START
G1 X87.985 Y81.747 E-.14871
G1 X88.644 Y81.747 E-.09398
G1 X88.434 Y81.537 E-.04231
; WIPE_END
G1 E-.015 F1800
M204 S6000
G1 X92.261 Y88.142 Z.6 F18000
G1 X92.753 Y88.992 Z.6
G1 Z.2
G1 E.3 F1800
; LINE_WIDTH: 0.50988
G1 F3000
M204 S500
G1 X92.014 Y88.253 E.03857
G1 X91.353 Y88.253 E.02436
G1 X91.948 Y88.847 E.03103
G1 X91.288 Y88.847 E.02436
G1 X90.693 Y88.253 E.03103
G1 X90.033 Y88.253 E.02436
G1 X90.628 Y88.847 E.03103
G1 X89.967 Y88.847 E.02436
G1 X89.372 Y88.253 E.03103
G1 X88.712 Y88.253 E.02436
G1 X89.307 Y88.847 E.03103
G1 X88.646 Y88.847 E.02436
G1 X88.052 Y88.253 E.03103
G1 X87.453 Y88.253 E.02209
G1 X87.453 Y88.314 E.00226
G1 X88.192 Y89.053 E.03856
; OBJECT_ID: 8
; WIPE_START
G1 X87.453 Y88.314 E-.14897
G1 X87.453 Y88.253 E-.00875
G1 X88.052 Y88.253 E-.08536
G1 X88.26 Y88.461 E-.04193
; WIPE_END
G1 E-.015 F1800
; stop printing object, unique label id: 12
M625
; start printing object, unique label id: 8
M624 AQAAAAAAAAA=
M204 S6000
G1 X80.646 Y87.921 Z.6 F18000
G1 X66.95 Y86.95 Z.6
G1 Z.2
G1 E.3 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.5
M204 S500
G1 X63.05 Y86.95 E.14081
G1 X63.05 Y83.05 E.14081
G1 X66.95 Y83.05 E.14081
G1 X66.95 Y86.89 E.13865
; WIPE_START
G1 X64.95 Y86.921 E-.285
; WIPE_END
G1 E-.015
M204 S6000
G1 X66.404 Y82.136 Z.6 F18000
G1 Z.2
G1 E.3 F1800
; FEATURE: Inner wall
M204 S500
G1 X63.597 Y82.136 E.10134
G1 X63.597 Y81.164 E.03509
G1 X66.404 Y81.164 E.10135
G1 X66.404 Y82.076 E.03292
M204 S6000
G1 X66.861 Y82.593 F18000
G1 F1800
M204 S500
G1 X63.14 Y82.593 E.13435
G1 X63.14 Y80.707 E.06809
G1 X66.861 Y80.707 E.13436
G1 X66.861 Y82.533 E.06593
; WIPE_START
G1 X64.861 Y82.565 E-.285
; WIPE_END
G1 E-.015
M204 S6000
G1 X66.403 Y87.864 Z.6 F18000
G1 Z.2
G1 E.3 F1800
M204 S500
G1 X66.402 Y88.836 E.03509
G1 X63.597 Y88.836 E.10129
G1 X63.597 Y87.864 E.03509
G1 X66.343 Y87.864 E.09913
M204 S6000
G1 X66.86 Y87.407 F18000
G1 F1800
M204 S500
G1 X66.859 Y89.293 E.06809
G1 X63.14 Y89.293 E.13429
G1 X63.14 Y87.407 E.06809
G1 X66.8 Y87.407 E.13214
; WIPE_START
G1 X66.859 Y89.293 E-.26887
G1 X66.746 Y89.293 E-.01613
; WIPE_END
G1 E-.015
M204 S6000
G1 X67.228 Y81.676 Z.6 F18000
G1 X67.318 Y80.25 Z.6
G1 Z.2
G1 E.3 F1800
; FEATURE: Outer wall
M204 S500
G1 X67.316 Y89.75 E.34301
G1 X62.683 Y89.75 E.16729
M73 P37 R12
G1 X62.683 Y80.25 E.34301
G1 X67.258 Y80.25 E.16521
; WIPE_START
G1 X67.271 Y82.25 E-.285
; WIPE_END
G1 E-.015
M204 S6000
G1 X66.175 Y81.65 Z.6 F18000
G1 Z.2
G1 E.3 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.55758
M204 S500
G1 X63.826 Y81.65 E.09553
; WIPE_START
G1 X65.826 Y81.65 E-.285
; WIPE_END
G1 E-.015
M204 S6000
G1 X63.826 Y88.35 Z.6 F18000
G1 Z.2
G1 E.3 F1800
M204 S500
G1 X66.174 Y88.35 E.09547
; CHANGE_LAYER
; Z_HEIGHT: 0.32
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F1800
G1 X64.174 Y88.35 E-.285
; WIPE_END
G1 E-.015
; stop printing object, unique label id: 8
M625
; layer num/total_layer_count: 2/57
; update layer progress
M73 L2
M991 S0 P1 ;notify layer change
; open powerlost recovery
M1003 S1
M104 S245 ; set nozzle temperature
; OBJECT_ID: 16
; start printing object, unique label id: 16
M624 BAAAAAAAAAA=
M204 S10000
G17
G3 Z.6 I.074 J1.215 P1  F18000
G1 X111.943 Y85.457 Z.6
G1 Z.32
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F3600
M204 S6000
G1 X111.943 Y84.543 E.01836
G1 X120.057 Y84.543 E.16313
G1 X120.057 Y85.457 E.01836
G1 X112.003 Y85.457 E.16193
; WIPE_START
G1 X111.943 Y84.543 E-.13039
G1 X113.028 Y84.543 E-.15461
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X109.69 Y85.281 Z.72 F18000
G1 Z.32
G1 E.3 F1800
G1 F3600
M204 S6000
G1 X109.519 Y85.281 E.00343
G1 X109.519 Y84.719 E.01129
G1 X111.519 Y84.719 E.04021
G1 X111.519 Y84.119 E.01206
G1 X120.481 Y84.119 E.18019
G1 X120.481 Y85.881 E.03542
G1 X111.519 Y85.881 E.18019
G1 X111.519 Y85.281 E.01206
G1 X109.75 Y85.281 E.03557
; WIPE_START
G1 X109.519 Y85.281 E-.03288
G1 X109.519 Y84.719 E-.08002
G1 X110.727 Y84.719 E-.1721
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X109.69 Y86.29 Z.72 F18000
G1 Z.32
G1 E.3 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
M204 S5000
G1 X109.111 Y86.286 E.01081
G1 X109.116 Y83.711 E.04812
G1 X109.69 Y83.71 E.01073
G1 X109.69 Y84.31 E.01121
G1 X111.11 Y84.31 E.02653
G1 X111.11 Y83.71 E.01121
G1 X120.11 Y83.71 E.16817
G1 X120.113 Y81.713 E.03732
G1 X120.889 Y81.715 E.0145
G1 X120.884 Y88.289 E.12284
G1 X120.114 Y88.287 E.01439
G1 X120.11 Y86.29 E.03732
G1 X111.11 Y86.29 E.16817
G1 X111.11 Y85.69 E.01121
G1 X109.69 Y85.69 E.02653
G1 X109.69 Y86.23 E.01008
; WIPE_START
M204 S6000
G1 X109.111 Y86.286 E-.08285
G1 X109.114 Y84.868 E-.20215
; WIPE_END
G1 E-.015
M204 S10000
G17
G3 Z.72 I1.217 J0 P1  F18000
; stop printing object, unique label id: 16
M625
; object ids of layer 2 start: 8,12,16
M624 BwAAAAAAAAA=
;===================== date: 20250206 =====================

; don't support timelapse gcode in spiral_mode and by object sequence for I3 structure printer
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
G92 E0
G1 Z0.72
G1 X0 Y85.0002 ; move to safe pos
G1 X-13.0 F3000 ; move to safe pos
M400
M1004 S5 P1  ; external shutter
M400 P300
M971 S11 C11 O0
G92 E0
G1 X0 F18000
M623

; SKIPTYPE: head_wrap_detect
M622.1 S1
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




; object ids of this layer2 end: 8,12,16
M625
; start printing object, unique label id: 16
M624 BAAAAAAAAAA=
G1 X109.4 Y84.515
G1 Z.32
G1 E.3 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.196407
G1 F2400
M204 S6000
G1 X109.4 Y83.915 E.00485
; WIPE_START
G1 X109.4 Y84.515 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X109.4 Y86.085 Z.72 F18000
G1 Z.32
G1 E.3 F1800
; LINE_WIDTH: 0.196487
G1 F2400
M204 S6000
G1 X109.4 Y85.485 E.00485
M204 S10000
G1 X109.731 Y85 F18000
; LINE_WIDTH: 0.163052
G1 F2400
M204 S6000
G1 X111.731 Y85 E.01301
M204 S10000
G1 X112.156 Y85 F18000
; LINE_WIDTH: 0.514572
G1 F2400
M204 S6000
G1 X119.844 Y85 E.17813
; WIPE_START
G1 X117.844 Y85 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X120.5 Y86.085 Z.72 F18000
G1 Z.32
G1 E.3 F1800
; LINE_WIDTH: 0.396522
G1 F2400
M204 S6000
G1 X120.5 Y88.085 E.03514
; WIPE_START
G1 X120.5 Y86.085 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X120.5 Y83.915 Z.72 F18000
G1 Z.32
G1 E.3 F1800
G1 F2400
M204 S6000
G1 X120.5 Y81.918 E.03508
; OBJECT_ID: 12
; WIPE_START
G1 X120.5 Y83.915 E-.285
; WIPE_END
G1 E-.015 F1800
; stop printing object, unique label id: 16
M625
; start printing object, unique label id: 12
M624 AgAAAAAAAAA=
M204 S10000
G1 X112.92 Y84.81 Z.72 F18000
G1 X88.09 Y87.743 Z.72
G1 Z.32
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F3600
M204 S6000
G1 X87.257 Y87.743 E.01676
G1 X87.257 Y82.257 E.11033
G1 X92.743 Y82.257 E.11033
G1 X92.743 Y87.743 E.11033
G1 X88.15 Y87.743 E.09236
M204 S10000
G1 X88.09 Y87.319 F18000
G1 F3600
M204 S6000
G1 X87.681 Y87.319 E.00823
G1 X87.681 Y82.681 E.09327
G1 X92.319 Y82.681 E.09327
G1 X92.319 Y87.319 E.09327
G1 X88.15 Y87.319 E.08383
M204 S250
G1 X88.09 Y86.91 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1800
M204 S5000
G1 X88.09 Y83.09 E.07138
G1 X91.91 Y83.09 E.07138
G1 X91.91 Y86.91 E.07138
G1 X88.15 Y86.91 E.07026
; WIPE_START
M204 S6000
G1 X88.119 Y84.91 E-.285
; WIPE_END
G1 E-.015
M204 S10000
G1 X86.943 Y80.645 Z.72 F18000
G1 Z.32
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F3600
M204 S6000
G1 X93.056 Y80.652 E.12291
G1 X93.057 Y89.357 E.17502
G1 X86.943 Y89.357 E.12292
G1 X86.943 Y80.705 E.17397
M204 S10000
G1 X86.519 Y80.22 F18000
G1 F3600
M204 S6000
G1 X93.48 Y80.229 E.13997
G1 X93.481 Y89.781 E.19207
G1 X86.519 Y89.781 E.13998
G1 X86.519 Y80.28 E.19104
M204 S250
G1 X86.269 Y79.844 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1800
M204 S5000
G1 X86.397 Y79.81 E.00248
G1 X93.656 Y79.82 E.13564
G1 X93.761 Y79.863 E.00212
G1 X93.83 Y79.93 E.00181
G1 X93.89 Y80.095 E.00327
G1 X93.89 Y89.883 E.18291
G1 X93.873 Y89.989 E.00199
G1 X93.831 Y90.073 E.00176
G1 X93.731 Y90.157 E.00244
G1 X93.588 Y90.19 E.00275
G1 X86.417 Y90.19 E.134
G1 X86.311 Y90.173 E.00199
G1 X86.227 Y90.131 E.00176
G1 X86.143 Y90.031 E.00244
G1 X86.11 Y89.887 E.00275
G1 X86.11 Y80.117 E.18257
G1 X86.127 Y80.011 E.00199
G1 X86.165 Y79.937 E.00156
G1 X86.224 Y79.884 E.00148
; WIPE_START
M204 S6000
G1 X86.397 Y79.81 E-.0268
G1 X88.209 Y79.813 E-.2582
; WIPE_END
G1 E-.015
M204 S10000
G1 X92.647 Y81.847 Z.72 F18000
G1 Z.32
G1 E.3 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.419992
G1 F4800
M204 S6000
G1 X92.647 Y81.061 E.01469
G1 X87.353 Y81.054 E.09892
G1 X87.353 Y81.847 E.01482
G1 X92.587 Y81.847 E.0978
; WIPE_START
G1 X90.587 Y81.847 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X87.749 Y81.451 Z.72 F18000
G1 Z.32
G1 E.3 F1800
; LINE_WIDTH: 0.421102
G1 F4800
M204 S6000
G1 X92.194 Y81.454 E.08328
; WIPE_START
M73 P38 R12
G1 X90.194 Y81.453 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X92.647 Y88.153 Z.72 F18000
G1 Z.32
G1 E.3 F1800
; LINE_WIDTH: 0.419992
G1 F4800
M204 S6000
G1 X87.353 Y88.153 E.09893
G1 X87.353 Y88.947 E.01485
G1 X92.647 Y88.947 E.09893
G1 X92.647 Y88.213 E.01373
; WIPE_START
G1 X92.647 Y88.947 E-.10468
G1 X91.382 Y88.947 E-.18032
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X87.75 Y88.55 Z.72 F18000
G1 Z.32
G1 E.3 F1800
; LINE_WIDTH: 0.426072
G1 F4800
M204 S6000
G1 X92.19 Y88.55 E.08424
; OBJECT_ID: 8
; WIPE_START
G1 X90.19 Y88.55 E-.285
; WIPE_END
G1 E-.015 F1800
; stop printing object, unique label id: 12
M625
; start printing object, unique label id: 8
M624 AQAAAAAAAAA=
M204 S10000
G1 X82.571 Y88.103 Z.72 F18000
G1 X62.257 Y86.91 Z.72
G1 Z.32
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F600
M204 S6000
G1 X62.257 Y82.257 E.09357
G1 F840
G1 X62.616 Y82.257 E.00723
G1 F3214.387
G1 X63.016 Y82.257 E.00804
G1 F3600
G1 X63.416 Y82.257 E.00804
G1 X66.584 Y82.257 E.0637
G1 X66.984 Y82.257 E.00804
G1 F3214.387
G1 X67.384 Y82.257 E.00804
G1 F840
G1 X67.743 Y82.257 E.00723
G1 F600
G1 X67.743 Y87.743 E.11033
G1 F840
G1 X67.384 Y87.743 E.00723
G1 F3214.387
G1 X66.984 Y87.743 E.00804
G1 F3600
G1 X66.584 Y87.743 E.00804
G1 X63.415 Y87.743 E.06371
G1 X63.015 Y87.743 E.00804
G1 F3214.387
G1 X62.615 Y87.743 E.00804
G1 F840
G1 X62.257 Y87.743 E.00722
G1 F600
G1 X62.257 Y86.97 E.01555
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
G17
G3 Z.72 I.778 J.935 P1  F18000
G1 X67.766 Y81.043 Z.72
G1 Z.32
G1 E.3 F1800
; FEATURE: Overhang wall
; LINE_WIDTH: 0.45
G1 F600
M204 S5000
G1 X68.173 Y81.043 E.0082
G1 X68.173 Y88.957 E.15911
G1 F3000
G1 X67.766 Y88.957 E.00819
; FEATURE: Inner wall
G1 F720
M204 S6000
G1 X67.383 Y88.957 E.00769
G1 F2975.226
G1 X66.983 Y88.957 E.00804
G1 F3600
G1 X66.583 Y88.957 E.00804
G1 X63.415 Y88.957 E.0637
G1 X63.015 Y88.957 E.00804
G1 F2975.226
G1 X62.615 Y88.957 E.00804
G1 F720
G1 X62.232 Y88.957 E.00769
; FEATURE: Overhang wall
G1 F600
M204 S5000
G1 X61.827 Y88.957 E.00816
G1 X61.827 Y81.043 E.15911
G1 X62.232 Y81.043 E.00816
; FEATURE: Inner wall
M204 S6000
G1 X62.615 Y81.043 E.00769
G1 F2725.645
G1 X63.015 Y81.043 E.00804
G1 F3600
G1 X63.415 Y81.043 E.00804
G1 X66.583 Y81.043 E.06371
G1 X66.983 Y81.043 E.00804
G1 F2975.226
G1 X67.383 Y81.043 E.00804
G1 F720
G1 X67.706 Y81.043 E.00648
M204 S250
G1 X67.766 Y80.619 F18000
; FEATURE: Overhang wall
G1 F600
M204 S5000
G1 X68.598 Y80.619 E.01672
G1 X68.597 Y89.381 E.17617
G1 F3000
G1 X67.767 Y89.381 E.0167
; FEATURE: Inner wall
G1 F720
M204 S6000
G1 X67.384 Y89.381 E.00769
G1 F2975.226
G1 X66.984 Y89.381 E.00804
G1 F3600
G1 X66.584 Y89.381 E.00804
G1 X63.415 Y89.381 E.06372
G1 X63.015 Y89.381 E.00804
G1 F2975.226
G1 X62.615 Y89.381 E.00804
G1 F720
G1 X62.233 Y89.381 E.00769
; FEATURE: Overhang wall
G1 F600
M204 S5000
G1 X61.402 Y89.381 E.01669
G1 X61.402 Y80.619 E.17617
G1 X62.233 Y80.619 E.01669
; FEATURE: Inner wall
M204 S6000
G1 X62.615 Y80.619 E.00769
G1 F2725.645
G1 X63.015 Y80.619 E.00804
G1 F3600
G1 X63.415 Y80.619 E.00804
G1 X66.583 Y80.619 E.06371
G1 X66.983 Y80.619 E.00804
G1 F2975.226
G1 X67.383 Y80.619 E.00804
G1 F720
G1 X67.706 Y80.619 E.00648
M204 S250
G1 X67.768 Y80.21 F18000
; FEATURE: Overhang wall
G1 F600
M204 S5000
G1 X69.007 Y80.21 E.0249
G1 X69.007 Y89.79 E.19263
G1 F3000
G1 X67.767 Y89.79 E.02492
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F720
G1 X67.398 Y89.79 E.0069
G1 F1800
G1 X66.998 Y89.79 E.00747
G1 X63.002 Y89.79 E.07467
G1 X62.602 Y89.79 E.00747
G1 F720
G1 X62.233 Y89.79 E.00689
; FEATURE: Overhang wall
; LINE_WIDTH: 0.45
G1 F600
G1 X60.993 Y89.79 E.02492
G1 X60.993 Y80.21 E.19263
G1 X62.233 Y80.21 E.02492
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F720
G1 X62.602 Y80.21 E.0069
G1 F1800
G1 X63.002 Y80.21 E.00747
G1 X66.999 Y80.21 E.0747
G1 X67.399 Y80.21 E.00747
G1 F600
G1 X67.708 Y80.21 E.00577
; WIPE_START
M204 S6000
G1 X69.007 Y80.21 E-.18502
G1 X69.007 Y80.912 E-.09998
; WIPE_END
G1 E-.015 F1800
M204 S10000
G17
G3 Z.72 I-.854 J-.867 P1  F18000
G1 X67.813 Y82.086 Z.72
G1 Z.32
G1 E.3 F1800
; FEATURE: Bridge
; LINE_WIDTH: 0.444172
G1 F3000
M204 S6000
G1 X67.813 Y81.391 E.01378
G1 X67.395 Y81.391 E.0083
G1 X67.395 Y81.909 E.01026
G1 X66.976 Y81.909 E.0083
G1 X66.976 Y81.391 E.01026
G1 X66.558 Y81.391 E.0083
G1 X66.558 Y81.909 E.01026
G1 X66.14 Y81.909 E.0083
G1 X66.14 Y81.391 E.01026
G1 X65.721 Y81.391 E.0083
G1 X65.721 Y82.086 E.01378
; WIPE_START
G1 X65.721 Y81.391 E-.099
G1 X66.14 Y81.391 E-.05963
G1 X66.14 Y81.909 E-.07372
G1 X66.509 Y81.909 E-.05265
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X64.686 Y81.847 Z.72 F18000
G1 Z.32
G1 E.3 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.420152
G1 F4800
M204 S6000
G1 X65.315 Y81.847 E.01177
G1 X65.315 Y81.453 E.00737
G1 X64.687 Y81.453 E.01173
G1 X64.686 Y81.787 E.00625
M204 S10000
M73 P39 R12
G1 X64.467 Y81.878 F18000
; FEATURE: Bridge
; LINE_WIDTH: 0.481532
G1 F3000
M204 S6000
G1 X62.175 Y81.878 E.04953
G1 X62.175 Y81.422 E.00985
G1 X64.474 Y81.422 E.04967
; WIPE_START
G1 X62.474 Y81.422 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X64.278 Y87.914 Z.72 F18000
G1 Z.32
G1 E.3 F1800
; LINE_WIDTH: 0.443962
G1 F3000
M204 S6000
G1 X64.278 Y88.609 E.01377
G1 X63.859 Y88.609 E.00829
G1 X63.859 Y88.091 E.01025
G1 X63.441 Y88.091 E.00829
G1 X63.441 Y88.609 E.01025
G1 X63.023 Y88.609 E.00829
G1 X63.023 Y88.091 E.01025
G1 X62.605 Y88.091 E.00829
G1 X62.605 Y88.609 E.01025
G1 X62.187 Y88.609 E.00829
G1 X62.187 Y87.914 E.01377
; WIPE_START
G1 X62.187 Y88.609 E-.099
G1 X62.605 Y88.609 E-.05959
G1 X62.605 Y88.091 E-.07372
G1 X62.975 Y88.091 E-.05269
; WIPE_END
G1 E-.015 F1800
M204 S10000
G17
G3 Z.72 I-.032 J1.217 P1  F18000
G1 X65.315 Y88.153 Z.72
G1 Z.32
G1 E.3 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.420157
G1 F4800
M204 S6000
G1 X64.684 Y88.153 E.01181
G1 X64.684 Y88.547 E.00737
G1 X65.315 Y88.547 E.0118
G1 X65.315 Y88.213 E.00625
M204 S10000
G1 X65.721 Y88.786 F18000
; FEATURE: Bridge
; LINE_WIDTH: 0.444142
G1 F3000
M204 S6000
G1 X65.721 Y88.091 E.01378
G1 X66.14 Y88.091 E.0083
G1 X66.14 Y88.609 E.01026
G1 X66.558 Y88.609 E.0083
G1 X66.558 Y88.091 E.01026
G1 X66.976 Y88.091 E.0083
G1 X66.976 Y88.609 E.01026
G1 X67.395 Y88.609 E.0083
G1 X67.395 Y88.091 E.01026
G1 X67.813 Y88.091 E.0083
G1 X67.813 Y88.786 E.01378
; CHANGE_LAYER
; Z_HEIGHT: 0.44
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F3000
G1 X67.813 Y88.091 E-.099
G1 X67.395 Y88.091 E-.05962
G1 X67.395 Y88.609 E-.07372
G1 X67.025 Y88.609 E-.05266
; WIPE_END
G1 E-.015 F1800
; stop printing object, unique label id: 8
M625
; layer num/total_layer_count: 3/57
; update layer progress
M73 L3
M991 S0 P2 ;notify layer change
; OBJECT_ID: 16
; start printing object, unique label id: 16
M624 BAAAAAAAAAA=
M204 S10000
G17
G3 Z.72 I.085 J1.214 P1  F18000
G1 X111.943 Y85.457 Z.72
G1 Z.44
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F3600
M204 S6000
G1 X111.943 Y84.543 E.01836
G1 X120.056 Y84.543 E.16313
G1 X120.056 Y85.457 E.01836
G1 X112.003 Y85.457 E.16193
; WIPE_START
G1 X111.943 Y84.543 E-.13039
G1 X113.028 Y84.543 E-.15461
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X109.69 Y85.281 Z.84 F18000
G1 Z.44
G1 E.3 F1800
G1 F3600
M204 S6000
G1 X109.519 Y85.281 E.00343
G1 X109.519 Y84.719 E.01129
G1 X111.519 Y84.719 E.04021
G1 X111.519 Y84.119 E.01206
G1 X120.481 Y84.119 E.18019
G1 X120.481 Y85.881 E.03542
G1 X111.519 Y85.881 E.18019
G1 X111.519 Y85.281 E.01206
G1 X109.75 Y85.281 E.03557
; WIPE_START
G1 X109.519 Y85.281 E-.03288
G1 X109.519 Y84.719 E-.08002
G1 X110.727 Y84.719 E-.1721
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X109.69 Y86.29 Z.84 F18000
G1 Z.44
G1 E.3 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
M204 S5000
G1 X109.111 Y86.286 E.01081
G1 X109.116 Y83.711 E.04811
G1 X109.69 Y83.71 E.01073
G1 X109.69 Y84.31 E.01121
G1 X111.11 Y84.31 E.02653
G1 X111.11 Y83.71 E.01121
G1 X120.11 Y83.71 E.16817
G1 X120.113 Y81.713 E.03732
G1 X120.886 Y81.714 E.01445
G1 X120.884 Y88.289 E.12286
G1 X120.114 Y88.287 E.01439
G1 X120.11 Y86.29 E.03732
G1 X111.11 Y86.29 E.16817
G1 X111.11 Y85.69 E.01121
G1 X109.69 Y85.69 E.02653
G1 X109.69 Y86.23 E.01008
; WIPE_START
M204 S6000
G1 X109.111 Y86.286 E-.08286
G1 X109.114 Y84.867 E-.20214
; WIPE_END
G1 E-.015
M204 S10000
G17
G3 Z.84 I1.217 J0 P1  F18000
; stop printing object, unique label id: 16
M625
; object ids of layer 3 start: 8,12,16
M624 BwAAAAAAAAA=
;===================== date: 20250206 =====================

; don't support timelapse gcode in spiral_mode and by object sequence for I3 structure printer
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
G92 E0
G1 Z0.84
G1 X0 Y85.0002 ; move to safe pos
G1 X-13.0 F3000 ; move to safe pos
M400
M1004 S5 P1  ; external shutter
M400 P300
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
; object ids of this layer3 end: 8,12,16
M625
; start printing object, unique label id: 16
M624 BAAAAAAAAAA=
G1 X109.4 Y84.515
G1 Z.44
G1 E.3 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.196408
G1 F2400
M204 S6000
G1 X109.4 Y83.915 E.00485
; WIPE_START
G1 X109.4 Y84.515 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X109.4 Y86.085 Z.84 F18000
G1 Z.44
G1 E.3 F1800
; LINE_WIDTH: 0.196498
G1 F2400
M204 S6000
G1 X109.4 Y85.485 E.00485
M204 S10000
G1 X109.731 Y85 F18000
; LINE_WIDTH: 0.163052
G1 F2400
M204 S6000
G1 X111.731 Y85 E.01301
M204 S10000
G1 X112.156 Y85 F18000
; LINE_WIDTH: 0.514572
G1 F2400
M204 S6000
G1 X119.844 Y85 E.17813
; WIPE_START
G1 X117.844 Y85 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X120.5 Y86.085 Z.84 F18000
G1 Z.44
G1 E.3 F1800
; LINE_WIDTH: 0.396408
G1 F2400
M204 S6000
G1 X120.5 Y88.085 E.03513
; WIPE_START
G1 X120.5 Y86.085 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X120.5 Y83.915 Z.84 F18000
G1 Z.44
G1 E.3 F1800
; LINE_WIDTH: 0.396498
G1 F2400
M204 S6000
G1 X120.5 Y81.917 E.0351
; OBJECT_ID: 12
; WIPE_START
G1 X120.5 Y83.915 E-.285
; WIPE_END
G1 E-.015 F1800
; stop printing object, unique label id: 16
M625
; start printing object, unique label id: 12
M624 AgAAAAAAAAA=
M204 S10000
G1 X112.92 Y84.81 Z.84 F18000
G1 X88.09 Y87.743 Z.84
G1 Z.44
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F3600
M204 S6000
G1 X87.257 Y87.743 E.01676
G1 X87.257 Y82.257 E.11033
G1 X92.743 Y82.257 E.11033
G1 X92.743 Y87.743 E.11033
G1 X88.15 Y87.743 E.09236
M204 S10000
G1 X88.09 Y87.319 F18000
G1 F3600
M204 S6000
G1 X87.681 Y87.319 E.00823
G1 X87.681 Y82.681 E.09327
G1 X92.319 Y82.681 E.09327
G1 X92.319 Y87.319 E.09327
G1 X88.15 Y87.319 E.08383
M204 S250
G1 X88.09 Y86.91 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1800
M204 S5000
G1 X88.09 Y83.09 E.07138
G1 X91.91 Y83.09 E.07138
G1 X91.91 Y86.91 E.07138
G1 X88.15 Y86.91 E.07026
; WIPE_START
M204 S6000
G1 X88.119 Y84.91 E-.285
; WIPE_END
G1 E-.015
M204 S10000
G1 X86.943 Y80.645 Z.84 F18000
G1 Z.44
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F3600
M204 S6000
G1 X93.056 Y80.652 E.12291
G1 X93.057 Y89.357 E.17502
G1 X86.943 Y89.357 E.12292
G1 X86.943 Y80.705 E.17397
M204 S10000
G1 X86.519 Y80.22 F18000
G1 F3600
M204 S6000
G1 X93.48 Y80.229 E.13997
G1 X93.481 Y89.781 E.19207
G1 X86.519 Y89.781 E.13998
G1 X86.519 Y80.28 E.19104
M204 S250
G1 X86.27 Y79.844 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1800
M204 S5000
G1 X86.397 Y79.81 E.00245
G1 X93.666 Y79.82 E.13583
G1 X93.802 Y79.898 E.00293
G1 X93.865 Y79.992 E.00213
G1 X93.89 Y80.103 E.00212
G1 X93.89 Y89.883 E.18275
G1 X93.873 Y89.989 E.00199
G1 X93.831 Y90.073 E.00176
G1 X93.731 Y90.157 E.00244
G1 X93.588 Y90.19 E.00275
G1 X86.417 Y90.19 E.13399
G1 X86.311 Y90.173 E.00199
G1 X86.227 Y90.131 E.00176
G1 X86.143 Y90.031 E.00244
G1 X86.11 Y89.888 E.00275
G1 X86.11 Y80.117 E.18258
G1 X86.127 Y80.011 E.002
G1 X86.164 Y79.937 E.00155
G1 X86.225 Y79.883 E.00151
; WIPE_START
M204 S6000
G1 X86.397 Y79.81 E-.02659
G1 X88.21 Y79.813 E-.25841
; WIPE_END
G1 E-.015
M204 S10000
G1 X92.647 Y81.847 Z.84 F18000
G1 Z.44
G1 E.3 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.419992
G1 F4800
M204 S6000
G1 X92.647 Y81.061 E.01469
G1 X87.353 Y81.054 E.09892
G1 X87.353 Y81.847 E.01482
G1 X92.587 Y81.847 E.0978
; WIPE_START
G1 X90.587 Y81.847 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X87.749 Y81.451 Z.84 F18000
G1 Z.44
G1 E.3 F1800
; LINE_WIDTH: 0.421122
G1 F4800
M204 S6000
G1 X92.194 Y81.454 E.08329
; WIPE_START
G1 X90.194 Y81.453 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X92.647 Y88.153 Z.84 F18000
G1 Z.44
M73 P40 R12
G1 E.3 F1800
; LINE_WIDTH: 0.419992
G1 F4800
M204 S6000
G1 X87.353 Y88.153 E.09893
G1 X87.353 Y88.947 E.01485
G1 X92.647 Y88.947 E.09893
G1 X92.647 Y88.213 E.01373
; WIPE_START
G1 X92.647 Y88.947 E-.10468
G1 X91.382 Y88.947 E-.18032
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X87.75 Y88.55 Z.84 F18000
G1 Z.44
G1 E.3 F1800
; LINE_WIDTH: 0.426072
G1 F4800
M204 S6000
G1 X92.19 Y88.55 E.08424
; OBJECT_ID: 8
; WIPE_START
G1 X90.19 Y88.55 E-.285
; WIPE_END
G1 E-.015 F1800
; stop printing object, unique label id: 12
M625
; start printing object, unique label id: 8
M624 AQAAAAAAAAA=
M204 S10000
G1 X82.561 Y88.323 Z.84 F18000
G1 X63.09 Y87.743 Z.84
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
M73 P40 R11
G1 E-.015
M204 S10000
G17
G3 Z.84 I.692 J1.001 P1  F18000
G1 X68.708 Y81.043 Z.84
G1 Z.44
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F3600
M204 S6000
G1 X68.708 Y88.957 E.15911
G1 X61.292 Y88.957 E.14911
G1 X61.292 Y81.043 E.15911
G1 X68.648 Y81.043 E.14791
M204 S10000
G1 X68.964 Y80.619 F18000
G1 F3600
M204 S6000
G1 X69.034 Y80.619 E.00141
G1 F2420.855
G1 X69.132 Y80.619 E.00197
G1 F1800
G1 X69.132 Y89.381 E.17617
G1 F2421.265
G1 X69.034 Y89.381 E.00197
G1 F3600
G1 X68.634 Y89.381 E.00804
G1 X60.966 Y89.381 E.15419
G1 F2422.901
G1 X60.868 Y89.381 E.00197
G1 F1800
G1 X60.868 Y80.619 E.17617
G1 F2422.901
G1 X60.966 Y80.619 E.00197
G1 F3600
G1 X61.366 Y80.619 E.00804
G1 X68.904 Y80.619 E.15157
M204 S250
G1 X68.964 Y80.21 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F918.302
M204 S5000
G1 X69.048 Y80.21 E.00157
G1 F600
G1 X69.417 Y80.21 E.0069
; FEATURE: Overhang wall
; LINE_WIDTH: 0.45

G1 X69.541 Y80.21 E.0025
G1 X69.541 Y89.79 E.19263
G1 F3000
G1 X69.417 Y89.79 E.00251
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F720
G1 X69.048 Y89.79 E.0069
G1 F1800
G1 X68.648 Y89.79 E.00747
G1 X61.352 Y89.79 E.13632
G1 X60.952 Y89.79 E.00747
G1 F600
G1 X60.583 Y89.79 E.0069
; FEATURE: Overhang wall
; LINE_WIDTH: 0.45

G1 X60.458 Y89.79 E.00251
G1 X60.458 Y80.21 E.19263
G1 X60.583 Y80.21 E.00251
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 X60.952 Y80.21 E.0069
G1 F1800
G1 X61.352 Y80.21 E.00747
G1 X68.904 Y80.21 E.14111
; WIPE_START
M204 S6000
G1 X69.048 Y80.21 E-.0205
G1 X69.417 Y80.21 E-.05258
G1 X69.541 Y80.21 E-.01775
G1 X69.541 Y81.573 E-.19417
; WIPE_END
G1 E-.015
M204 S10000
G17
G3 Z.84 I-.411 J-1.146 P1  F18000
G1 X68.226 Y82.045 Z.84
G1 Z.44
G1 E.3 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.565766
G1 F2400
M204 S6000
G1 X68.226 Y87.956 E.15129
M204 S10000
G1 X67.777 Y88.456 F18000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.602542
G1 F4800
M204 S6000
G1 X68.147 Y88.456 E.01012
; WIPE_START
G1 X67.777 Y88.456 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G17
G3 Z.84 I.072 J-1.215 P1  F18000
G1 X62.637 Y88.153 Z.84
G1 Z.44
G1 E.3 F1800
; LINE_WIDTH: 0.432285
G1 F4800
M204 S6000
G1 X62.475 Y88.168 E.00313
G1 X62.452 Y88.263 E.00189
; LINE_WIDTH: 0.45837
G1 X62.406 Y88.311 E.00136
; LINE_WIDTH: 0.499565
G1 X62.361 Y88.359 E.00149
; LINE_WIDTH: 0.54076
G1 X62.315 Y88.408 E.00162
; LINE_WIDTH: 0.581955
G1 X62.269 Y88.456 E.00175
; LINE_WIDTH: 0.579753
G1 X62.361 Y88.479 E.00249
; LINE_WIDTH: 0.534156
G1 X62.453 Y88.502 E.00228
; LINE_WIDTH: 0.488558
G1 X62.545 Y88.524 E.00208
; LINE_WIDTH: 0.420603
G1 X62.637 Y88.547 E.00177
G1 X67.381 Y88.547 E.08877
; LINE_WIDTH: 0.442952
G1 X67.48 Y88.524 E.00201
; LINE_WIDTH: 0.488552
G1 X67.579 Y88.502 E.00223
; LINE_WIDTH: 0.534152
G1 X67.678 Y88.479 E.00245
; LINE_WIDTH: 0.579752
G1 X67.777 Y88.456 E.00267
G1 X67.722 Y88.407 E.00195
; LINE_WIDTH: 0.534152
G1 X67.666 Y88.357 E.00179
; LINE_WIDTH: 0.488552
G1 X67.611 Y88.308 E.00163
; LINE_WIDTH: 0.420494
G1 X67.556 Y88.259 E.00139
G1 X67.518 Y88.153 E.0021
G1 X62.697 Y88.153 E.0902
M204 S10000
G1 X61.792 Y88.456 F18000
; LINE_WIDTH: 0.602542
G1 F4800
M204 S6000
G1 X62.209 Y88.456 E.0114
M204 S10000
G1 X61.774 Y87.956 F18000
; FEATURE: Gap infill
; LINE_WIDTH: 0.566152
G1 F2400
M204 S6000
G1 X61.774 Y82.045 E.1514
M204 S10000
G1 X61.792 Y81.544 F18000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.602552
G1 F4800
M204 S6000
G1 X62.163 Y81.544 E.01013
; WIPE_START
G1 X61.792 Y81.544 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G17
G3 Z.84 I-.066 J1.215 P1  F18000
G1 X67.363 Y81.847 Z.84
G1 Z.44
G1 E.3 F1800
; LINE_WIDTH: 0.432278
G1 F4800
M204 S6000
G1 X67.525 Y81.832 E.00313
G1 X67.548 Y81.737 E.00189
; LINE_WIDTH: 0.458361
G1 X67.594 Y81.689 E.00136
; LINE_WIDTH: 0.499558
G1 X67.639 Y81.641 E.00149
; LINE_WIDTH: 0.540756
G1 X67.685 Y81.592 E.00162
; LINE_WIDTH: 0.581953
G1 X67.731 Y81.544 E.00175
; LINE_WIDTH: 0.579753
G1 X67.639 Y81.521 E.00249
; LINE_WIDTH: 0.534156
G1 X67.547 Y81.498 E.00228
; LINE_WIDTH: 0.488558
G1 X67.455 Y81.476 E.00208
; LINE_WIDTH: 0.420608
G1 X67.363 Y81.453 E.00177
G1 X62.619 Y81.453 E.08878
; LINE_WIDTH: 0.442961
G1 X62.52 Y81.476 E.00201
; LINE_WIDTH: 0.488558
G1 X62.421 Y81.498 E.00223
; LINE_WIDTH: 0.534156
G1 X62.322 Y81.521 E.00245
; LINE_WIDTH: 0.579753
G1 X62.223 Y81.544 E.00267
G1 X62.278 Y81.593 E.00195
; LINE_WIDTH: 0.534156
G1 X62.334 Y81.643 E.00179
; LINE_WIDTH: 0.488558
G1 X62.389 Y81.692 E.00163
; LINE_WIDTH: 0.420499
G1 X62.444 Y81.741 E.00139
G1 X62.482 Y81.847 E.0021
G1 X67.303 Y81.847 E.09021
M204 S10000
G1 X67.731 Y81.544 F18000
; LINE_WIDTH: 0.602542
G1 F4800
M204 S6000
G1 X68.147 Y81.544 E.01139
; CHANGE_LAYER
; Z_HEIGHT: 0.56
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F4800
G1 X67.731 Y81.544 E-.285
; WIPE_END
G1 E-.015 F1800
; stop printing object, unique label id: 8
M625
; layer num/total_layer_count: 4/57
; update layer progress
M73 L4
M991 S0 P3 ;notify layer change
M106 S56.1
; OBJECT_ID: 16
; start printing object, unique label id: 16
M624 BAAAAAAAAAA=
M204 S10000
G17
G3 Z.84 I-.107 J1.212 P1  F18000
G1 X111.943 Y85.457 Z.84
G1 Z.56
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F3600
M204 S6000
G1 X111.943 Y84.543 E.01836
G1 X120.057 Y84.543 E.16313
G1 X120.057 Y85.457 E.01836
G1 X112.003 Y85.457 E.16193
; WIPE_START
G1 X111.943 Y84.543 E-.13039
G1 X113.028 Y84.543 E-.15461
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X109.69 Y85.281 Z.96 F18000
G1 Z.56
G1 E.3 F1800
G1 F3600
M204 S6000
G1 X109.519 Y85.281 E.00343
G1 X109.519 Y84.719 E.01129
G1 X111.519 Y84.719 E.04021
G1 X111.519 Y84.119 E.01206
G1 X120.481 Y84.119 E.18019
G1 X120.481 Y85.881 E.03542
G1 X111.519 Y85.881 E.18019
G1 X111.519 Y85.281 E.01206
G1 X109.75 Y85.281 E.03557
; WIPE_START
G1 X109.519 Y85.281 E-.03288
G1 X109.519 Y84.719 E-.08002
G1 X110.727 Y84.719 E-.1721
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X109.69 Y86.29 Z.96 F18000
G1 Z.56
G1 E.3 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
M204 S5000
G1 X109.111 Y86.286 E.01081
G1 X109.116 Y83.711 E.04812
G1 X109.69 Y83.71 E.01073
G1 X109.69 Y84.31 E.01121
G1 X111.11 Y84.31 E.02653
G1 X111.11 Y83.71 E.01121
G1 X120.11 Y83.71 E.16817
G1 X120.113 Y81.713 E.03732
G1 X120.885 Y81.714 E.01442
G1 X120.884 Y88.289 E.12287
G1 X120.114 Y88.287 E.01439
G1 X120.11 Y86.29 E.03732
G1 X111.11 Y86.29 E.16817
G1 X111.11 Y85.69 E.01121
G1 X109.69 Y85.69 E.02653
G1 X109.69 Y86.23 E.01008
; WIPE_START
M204 S6000
G1 X109.111 Y86.286 E-.08285
G1 X109.114 Y84.868 E-.20215
; WIPE_END
G1 E-.015
M204 S10000
G17
G3 Z.96 I1.217 J0 P1  F18000
; stop printing object, unique label id: 16
M625
; object ids of layer 4 start: 8,12,16
M624 BwAAAAAAAAA=
;===================== date: 20250206 =====================

; don't support timelapse gcode in spiral_mode and by object sequence for I3 structure printer
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
G92 E0
G1 Z0.96
G1 X0 Y85.0002 ; move to safe pos
G1 X-13.0 F3000 ; move to safe pos
M400
M1004 S5 P1  ; external shutter
M400 P300
M971 S11 C11 O0
G92 E0
G1 X0 F18000
M623

; SKIPTYPE: head_wrap_detect
M622.1 S1
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




; object ids of this layer4 end: 8,12,16
M625
; start printing object, unique label id: 16
M624 BAAAAAAAAAA=
G1 X109.4 Y84.515
G1 Z.56
G1 E.3 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.196407
G1 F2400
M204 S6000
G1 X109.4 Y83.915 E.00485
; WIPE_START
G1 X109.4 Y84.515 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X109.4 Y86.085 Z.96 F18000
G1 Z.56
G1 E.3 F1800
; LINE_WIDTH: 0.196487
G1 F2400
M204 S6000
G1 X109.4 Y85.485 E.00485
M204 S10000
G1 X109.731 Y85 F18000
; LINE_WIDTH: 0.163052
G1 F2400
M204 S6000
G1 X111.731 Y85 E.01301
M204 S10000
G1 X112.156 Y85 F18000
; LINE_WIDTH: 0.514572
G1 F2400
M204 S6000
G1 X119.844 Y85 E.17813
; WIPE_START
G1 X117.844 Y85 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X120.5 Y86.085 Z.96 F18000
G1 Z.56
G1 E.3 F1800
; LINE_WIDTH: 0.396522
G1 F2400
M204 S6000
G1 X120.5 Y88.085 E.03514
; WIPE_START
G1 X120.5 Y86.085 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X120.5 Y83.915 Z.96 F18000
G1 Z.56
G1 E.3 F1800
G1 F2400
M204 S6000
G1 X120.5 Y81.917 E.0351
; OBJECT_ID: 12
; WIPE_START
M73 P41 R11
G1 X120.5 Y83.915 E-.285
; WIPE_END
G1 E-.015 F1800
; stop printing object, unique label id: 16
M625
; start printing object, unique label id: 12
M624 AgAAAAAAAAA=
M204 S10000
G1 X112.92 Y84.81 Z.96 F18000
G1 X88.09 Y87.743 Z.96
G1 Z.56
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F3600
M204 S6000
G1 X87.257 Y87.743 E.01676
G1 X87.257 Y82.257 E.11033
G1 X92.743 Y82.257 E.11033
G1 X92.743 Y87.743 E.11033
G1 X88.15 Y87.743 E.09236
M204 S10000
G1 X88.09 Y87.319 F18000
G1 F3600
M204 S6000
G1 X87.681 Y87.319 E.00823
G1 X87.681 Y82.681 E.09327
G1 X92.319 Y82.681 E.09327
G1 X92.319 Y87.319 E.09327
G1 X88.15 Y87.319 E.08383
M204 S250
G1 X88.09 Y86.91 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1800
M204 S5000
G1 X88.09 Y83.09 E.07138
G1 X91.91 Y83.09 E.07138
G1 X91.91 Y86.91 E.07138
G1 X88.15 Y86.91 E.07026
; WIPE_START
M204 S6000
G1 X88.119 Y84.91 E-.285
; WIPE_END
G1 E-.015
M204 S10000
G1 X86.943 Y80.644 Z.96 F18000
G1 Z.56
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F3600
M204 S6000
G1 X93.056 Y80.644 E.12291
G1 X93.057 Y89.357 E.17519
G1 X86.943 Y89.357 E.12292
G1 X86.943 Y80.704 E.17398
M204 S10000
G1 X86.519 Y80.22 F18000
G1 F3600
M204 S6000
G1 X93.48 Y80.22 E.13997
G1 X93.481 Y89.781 E.19225
G1 X86.519 Y89.781 E.13998
G1 X86.519 Y80.28 E.19104
M204 S250
G1 X86.26 Y79.849 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1800
M204 S5000
G1 X86.407 Y79.81 E.00284
G1 X93.657 Y79.818 E.13547
G1 X93.797 Y79.889 E.00292
G1 X93.864 Y79.99 E.00228
G1 X93.89 Y80.104 E.00216
G1 X93.89 Y89.883 E.18274
G1 X93.873 Y89.989 E.00199
G1 X93.83 Y90.073 E.00177
G1 X93.731 Y90.157 E.00244
G1 X93.588 Y90.19 E.00275
G1 X86.417 Y90.19 E.134
G1 X86.311 Y90.173 E.00199
G1 X86.227 Y90.131 E.00176
G1 X86.143 Y90.031 E.00244
G1 X86.11 Y89.888 E.00275
G1 X86.11 Y80.117 E.18258
G1 X86.127 Y80.011 E.00199
G1 X86.169 Y79.927 E.00176
G1 X86.215 Y79.888 E.00112
; WIPE_START
M204 S6000
G1 X86.407 Y79.81 E-.02957
G1 X88.2 Y79.812 E-.25543
; WIPE_END
G1 E-.015
M204 S10000
G1 X92.647 Y81.847 Z.96 F18000
G1 Z.56
G1 E.3 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.419992
G1 F4800
M204 S6000
G1 X92.647 Y81.053 E.01484
G1 X87.353 Y81.053 E.09892
G1 X87.353 Y81.847 E.01484
G1 X92.587 Y81.847 E.0978
; WIPE_START
G1 X90.587 Y81.847 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X87.75 Y81.45 Z.96 F18000
G1 Z.56
G1 E.3 F1800
; LINE_WIDTH: 0.425712
G1 F4800
M204 S6000
G1 X92.19 Y81.45 E.08417
; WIPE_START
G1 X90.19 Y81.45 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X92.647 Y88.153 Z.96 F18000
G1 Z.56
G1 E.3 F1800
; LINE_WIDTH: 0.419992
G1 F4800
M204 S6000
G1 X87.353 Y88.153 E.09893
G1 X87.353 Y88.947 E.01485
G1 X92.647 Y88.947 E.09893
G1 X92.647 Y88.213 E.01373
; WIPE_START
G1 X92.647 Y88.947 E-.10468
G1 X91.382 Y88.947 E-.18032
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X87.75 Y88.55 Z.96 F18000
G1 Z.56
G1 E.3 F1800
; LINE_WIDTH: 0.426072
G1 F4800
M204 S6000
G1 X92.19 Y88.55 E.08424
; OBJECT_ID: 8
; WIPE_START
G1 X90.19 Y88.55 E-.285
; WIPE_END
G1 E-.015 F1800
; stop printing object, unique label id: 12
M625
; start printing object, unique label id: 8
M624 AQAAAAAAAAA=
M204 S10000
G1 X82.571 Y88.089 Z.96 F18000
M106 S229.5
G1 X63.09 Y86.91 Z.96
G1 Z.56
G1 E.3 F1800
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
G17
G3 Z.96 I1.125 J-.464 P1  F18000
G1 X61.525 Y81.043 Z.96
G1 Z.56
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F3600
M204 S6000
G1 X61.525 Y88.957 E.15911
G1 X60.976 Y88.957 E.01102
G1 X60.976 Y81.043 E.15911
G1 X61.465 Y81.043 E.00982
M204 S10000
G1 X61.949 Y80.619 F18000
G1 F3600
M204 S6000
G1 X61.949 Y89.381 E.17617
G1 X60.552 Y89.381 E.02808
G1 X60.552 Y80.619 E.17617
G1 X61.889 Y80.619 E.02688
; WIPE_START
G1 X61.903 Y82.619 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G17
G3 Z.96 I.263 J1.188 P1  F18000
G1 X69.023 Y81.043 Z.96
G1 Z.56
G1 E.3 F1800
G1 F3600
M204 S6000
G1 X69.023 Y88.957 E.15911
G1 X68.475 Y88.957 E.01102
G1 X68.475 Y81.043 E.15911
G1 X68.963 Y81.043 E.00981
M204 S10000
G1 X69.447 Y80.619 F18000
G1 F3600
M204 S6000
G1 X69.447 Y89.381 E.17617
G1 X68.051 Y89.381 E.02808
G1 X68.051 Y80.619 E.17617
G1 X69.387 Y80.619 E.02687
M204 S250
G1 X69.582 Y80.21 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1320
M204 S5000
G1 X69.857 Y80.21 E.00513
M106 S56.1
M106 S229.5
G1 F600
G1 X69.857 Y89.79 E.17901
M106 S56.1
M106 S229.5
G1 F1320
G1 X69.582 Y89.79 E.00513
M106 S56.1
M106 S229.5
G1 F1800
G1 X60.417 Y89.79 E.17125
G1 F1320
G1 X60.143 Y89.79 E.00513
M106 S56.1
M106 S229.5
G1 F600
G1 X60.143 Y80.21 E.17901
M106 S56.1
M106 S229.5
G1 F1320
G1 X60.417 Y80.21 E.00513
M106 S56.1
G1 F1800
G1 X69.522 Y80.21 E.17013
; WIPE_START
M204 S6000
G1 X69.857 Y80.21 E-.04766
G1 X69.857 Y81.876 E-.23734
; WIPE_END
G1 E-.015
M204 S10000
G17
G3 Z.96 I.594 J-1.062 P1  F18000
G1 X68.749 Y81.256 Z.96
G1 Z.56
G1 E.3 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.149342
G1 F2400
M204 S6000
G1 X68.749 Y88.744 E.04387
; WIPE_START
G1 X68.749 Y86.744 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G17
G3 Z.96 I-1.098 J-.525 P1  F18000
G1 X67.396 Y89.573 Z.96
G1 Z.56
G1 E.3 F1800
; FEATURE: Top surface
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X67.819 Y89.15 E.01118
G1 X67.819 Y88.592
G1 X66.838 Y89.573 E.02592
G1 X66.281 Y89.573
G1 X67.819 Y88.035 E.04065
G1 X67.819 Y87.477
G1 X65.723 Y89.573 E.05538
G1 X65.166 Y89.573
G1 X67.819 Y86.92 E.07012
G1 X67.819 Y86.362
G1 X67.127 Y87.055 E.0183
G1 X67.127 Y86.497
M73 P42 R11
G1 X67.819 Y85.805 E.0183
G1 X67.571 Y85.495
G1 X67.127 Y85.94 E.01175
G1 X67.055 Y87.127
G1 X64.608 Y89.573 E.06465
G1 X64.051 Y89.573
G1 X66.497 Y87.127 E.06465
G1 X65.94 Y87.127
G1 X63.493 Y89.573 E.06465
G1 X62.936 Y89.573
G1 X65.382 Y87.127 E.06465
G1 X64.824 Y87.127
G1 X62.378 Y89.573 E.06465
G1 X62.181 Y89.213
G1 X64.267 Y87.127 E.05513
G1 X63.709 Y87.127
G1 X62.181 Y88.655 E.0404
G1 X62.181 Y88.098
G1 X63.152 Y87.127 E.02566
G1 X62.873 Y86.848
G1 X62.181 Y87.54 E.0183
G1 X62.181 Y86.983
G1 X62.873 Y86.29 E.0183
G1 X62.873 Y85.733
G1 X62.181 Y86.425 E.0183
M204 S10000
G1 X62.27 Y85.43 F18000
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
G17
G3 Z.96 I1.163 J-.357 P1  F18000
G1 X61.25 Y81.256 Z.96
G1 Z.56
G1 E.3 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.149672
G1 F2400
M204 S6000
G1 X61.25 Y88.744 E.04398
; WIPE_START
G1 X61.25 Y86.744 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G17
G3 Z.96 I.275 J1.185 P1  F18000
G1 X67.16 Y85.374 Z.96
G1 Z.56
G1 E.3 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.365752
G1 F4800
M204 S6000
G1 X67.415 Y85.373 E.00412
G1 X67.667 Y85.415 E.00411
M204 S10000
G1 X67.169 Y84.618 F18000
G1 F4800
M204 S6000
G1 X67.67 Y84.575 E.00811
; WIPE_START
G1 X67.169 Y84.618 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G17
G3 Z.96 I1.033 J.644 P1  F18000
G1 X67.819 Y83.575 Z.96
G1 Z.56
G1 E.3 F1800
; FEATURE: Top surface
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X67.127 Y84.267 E.0183
G1 X67.127 Y83.709
G1 X67.819 Y83.017 E.0183
G1 X67.819 Y82.459
G1 X67.127 Y83.152 E.0183
G1 X66.848 Y82.873
G1 X67.819 Y81.902 E.02567
G1 X67.819 Y81.344
G1 X66.29 Y82.873 E.0404
G1 X65.733 Y82.873
G1 X67.819 Y80.787 E.05513
G1 X67.622 Y80.427
G1 X65.175 Y82.873 E.06465
G1 X64.618 Y82.873
G1 X67.064 Y80.427 E.06465
G1 X66.507 Y80.427
G1 X64.06 Y82.873 E.06465
G1 X63.503 Y82.873
G1 X65.949 Y80.427 E.06465
G1 X65.392 Y80.427
G1 X62.945 Y82.873 E.06465
G1 X62.873 Y84.06
G1 X62.428 Y84.505 E.01175
G1 X62.181 Y84.195
G1 X62.873 Y83.503 E.0183
G1 X62.873 Y82.945
G1 X62.181 Y83.638 E.0183
G1 X62.181 Y83.08
G1 X64.834 Y80.427 E.07011
G1 X64.276 Y80.427
G1 X62.181 Y82.523 E.05538
G1 X62.181 Y81.965
G1 X63.719 Y80.427 E.04065
G1 X63.161 Y80.427
G1 X62.181 Y81.407 E.02591
G1 X62.181 Y80.85
G1 X62.604 Y80.427 E.01118
; WIPE_START
M204 S6000
G1 X62.181 Y80.85 E-.08527
G1 X62.181 Y81.407 E-.07945
G1 X62.778 Y80.811 E-.12028
; WIPE_END
G1 E-.015 F1800
M204 S10000
G17
G3 Z.96 I-.714 J.985 P1  F18000
G1 X67.782 Y84.44 Z.96
G1 Z.56
G1 E.3 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.207934
G1 F2400
M204 S6000
G1 X67.201 Y84.475 E.00503
G1 X67.107 Y84.252 E.00209
; CHANGE_LAYER
; Z_HEIGHT: 0.68
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F2400
G1 X67.201 Y84.475 E-.08366
G1 X67.782 Y84.44 E-.20134
; WIPE_END
G1 E-.015 F1800
; stop printing object, unique label id: 8
M625
; layer num/total_layer_count: 5/57
; update layer progress
M73 L5
M991 S0 P4 ;notify layer change
M106 S61.2
; OBJECT_ID: 16
; start printing object, unique label id: 16
M624 BAAAAAAAAAA=
M204 S10000
G17
G3 Z.96 I-.028 J1.217 P1  F18000
G1 X111.943 Y85.457 Z.96
G1 Z.68
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F3600
M204 S6000
G1 X111.943 Y84.543 E.01836
G1 X120.057 Y84.543 E.16313
G1 X120.057 Y85.457 E.01836
G1 X112.003 Y85.457 E.16193
; WIPE_START
G1 X111.943 Y84.543 E-.13039
G1 X113.028 Y84.543 E-.15461
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X109.69 Y85.281 Z1.08 F18000
G1 Z.68
G1 E.3 F1800
G1 F3600
M204 S6000
G1 X109.519 Y85.281 E.00343
G1 X109.519 Y84.719 E.01129
G1 X111.519 Y84.719 E.04021
G1 X111.519 Y84.119 E.01206
G1 X120.481 Y84.119 E.18019
G1 X120.481 Y85.881 E.03542
G1 X111.519 Y85.881 E.18019
G1 X111.519 Y85.281 E.01206
G1 X109.75 Y85.281 E.03557
; WIPE_START
G1 X109.519 Y85.281 E-.03288
G1 X109.519 Y84.719 E-.08002
G1 X110.727 Y84.719 E-.1721
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X109.69 Y86.29 Z1.08 F18000
G1 Z.68
G1 E.3 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
M204 S5000
G1 X109.111 Y86.286 E.01081
G1 X109.116 Y83.711 E.04812
G1 X109.69 Y83.71 E.01073
G1 X109.69 Y84.31 E.01121
G1 X111.11 Y84.31 E.02653
G1 X111.11 Y83.71 E.01121
G1 X120.11 Y83.71 E.16817
G1 X120.113 Y81.713 E.03732
G1 X120.886 Y81.714 E.01445
G1 X120.884 Y88.289 E.12287
G1 X120.114 Y88.287 E.01439
G1 X120.11 Y86.29 E.03732
G1 X111.11 Y86.29 E.16817
G1 X111.11 Y85.69 E.01121
G1 X109.69 Y85.69 E.02653
G1 X109.69 Y86.23 E.01008
; WIPE_START
M204 S6000
G1 X109.111 Y86.286 E-.08286
G1 X109.114 Y84.867 E-.20214
; WIPE_END
G1 E-.015
M204 S10000
G17
G3 Z1.08 I1.217 J0 P1  F18000
; stop printing object, unique label id: 16
M625
; object ids of layer 5 start: 8,12,16
M624 BwAAAAAAAAA=
;===================== date: 20250206 =====================

; don't support timelapse gcode in spiral_mode and by object sequence for I3 structure printer
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
G92 E0
G1 Z1.08
G1 X0 Y85.0002 ; move to safe pos
G1 X-13.0 F3000 ; move to safe pos
M400
M1004 S5 P1  ; external shutter
M400 P300
M971 S11 C11 O0
G92 E0
G1 X0 F18000
M623

; SKIPTYPE: head_wrap_detect
M622.1 S1
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




; object ids of this layer5 end: 8,12,16
M625
; start printing object, unique label id: 16
M624 BAAAAAAAAAA=
G1 X109.4 Y84.515
G1 Z.68
G1 E.3 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.196407
G1 F2400
M204 S6000
G1 X109.4 Y83.915 E.00485
; WIPE_START
G1 X109.4 Y84.515 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X109.4 Y86.085 Z1.08 F18000
G1 Z.68
G1 E.3 F1800
; LINE_WIDTH: 0.196487
G1 F2400
M204 S6000
G1 X109.4 Y85.485 E.00485
M204 S10000
G1 X109.731 Y85 F18000
; LINE_WIDTH: 0.163052
G1 F2400
M204 S6000
G1 X111.731 Y85 E.01301
M204 S10000
G1 X112.156 Y85 F18000
; LINE_WIDTH: 0.514572
G1 F2400
M204 S6000
G1 X119.844 Y85 E.17813
; WIPE_START
G1 X117.844 Y85 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X120.5 Y86.085 Z1.08 F18000
G1 Z.68
G1 E.3 F1800
; LINE_WIDTH: 0.396522
G1 F2400
M204 S6000
G1 X120.5 Y88.085 E.03514
; WIPE_START
G1 X120.5 Y86.085 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X120.5 Y83.915 Z1.08 F18000
G1 Z.68
G1 E.3 F1800
G1 F2400
M204 S6000
G1 X120.5 Y81.917 E.0351
; OBJECT_ID: 12
; WIPE_START
G1 X120.5 Y83.915 E-.285
; WIPE_END
G1 E-.015 F1800
; stop printing object, unique label id: 16
M625
; start printing object, unique label id: 12
M624 AgAAAAAAAAA=
M204 S10000
G1 X112.92 Y84.81 Z1.08 F18000
G1 X88.09 Y87.743 Z1.08
G1 Z.68
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F3600
M204 S6000
G1 X87.257 Y87.743 E.01676
G1 X87.257 Y82.257 E.11033
G1 X92.743 Y82.257 E.11033
G1 X92.743 Y87.743 E.11033
G1 X88.15 Y87.743 E.09236
M204 S10000
G1 X88.09 Y87.319 F18000
G1 F3600
M204 S6000
G1 X87.681 Y87.319 E.00823
G1 X87.681 Y82.681 E.09327
G1 X92.319 Y82.681 E.09327
G1 X92.319 Y87.319 E.09327
G1 X88.15 Y87.319 E.08383
M204 S250
G1 X88.09 Y86.91 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1800
M204 S5000
G1 X88.09 Y83.09 E.07138
G1 X91.91 Y83.09 E.07138
G1 X91.91 Y86.91 E.07138
M73 P43 R11
G1 X88.15 Y86.91 E.07026
; WIPE_START
M204 S6000
G1 X88.119 Y84.91 E-.285
; WIPE_END
G1 E-.015
M204 S10000
G1 X86.943 Y80.645 Z1.08 F18000
G1 Z.68
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F3600
M204 S6000
G1 X93.056 Y80.652 E.12291
G1 X93.057 Y89.357 E.17502
G1 X86.943 Y89.357 E.12292
G1 X86.943 Y80.705 E.17397
M204 S10000
G1 X86.519 Y80.22 F18000
G1 F3600
M204 S6000
G1 X93.48 Y80.229 E.13997
G1 X93.481 Y89.781 E.19207
G1 X86.519 Y89.781 E.13998
G1 X86.519 Y80.28 E.19104
M204 S250
G1 X86.271 Y79.843 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1800
M204 S5000
G1 X86.397 Y79.81 E.00243
G1 X93.666 Y79.82 E.13583
G1 X93.804 Y79.899 E.00297
G1 X93.859 Y79.978 E.0018
G1 X93.89 Y80.105 E.00244
G1 X93.89 Y89.883 E.18271
G1 X93.873 Y89.989 E.00199
G1 X93.831 Y90.073 E.00176
G1 X93.731 Y90.157 E.00244
G1 X93.588 Y90.19 E.00275
G1 X86.417 Y90.19 E.134
G1 X86.311 Y90.173 E.00199
G1 X86.227 Y90.131 E.00176
G1 X86.143 Y90.031 E.00244
G1 X86.11 Y89.888 E.00275
G1 X86.11 Y80.117 E.18258
G1 X86.127 Y80.011 E.00199
G1 X86.164 Y79.937 E.00155
G1 X86.226 Y79.883 E.00154
; WIPE_START
M204 S6000
G1 X86.397 Y79.81 E-.02644
G1 X88.211 Y79.813 E-.25856
; WIPE_END
G1 E-.015
M204 S10000
G1 X92.647 Y81.847 Z1.08 F18000
G1 Z.68
G1 E.3 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.419992
G1 F4800
M204 S6000
G1 X92.647 Y81.061 E.01469
G1 X87.353 Y81.054 E.09892
G1 X87.353 Y81.847 E.01482
G1 X92.587 Y81.847 E.0978
; WIPE_START
G1 X90.587 Y81.847 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X87.749 Y81.451 Z1.08 F18000
G1 Z.68
G1 E.3 F1800
; LINE_WIDTH: 0.421122
G1 F4800
M204 S6000
G1 X92.194 Y81.454 E.08329
; WIPE_START
G1 X90.194 Y81.453 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X92.647 Y88.153 Z1.08 F18000
G1 Z.68
G1 E.3 F1800
; LINE_WIDTH: 0.419992
G1 F4800
M204 S6000
G1 X87.353 Y88.153 E.09893
G1 X87.353 Y88.947 E.01485
G1 X92.647 Y88.947 E.09893
G1 X92.647 Y88.213 E.01373
; WIPE_START
G1 X92.647 Y88.947 E-.10468
G1 X91.382 Y88.947 E-.18032
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X87.75 Y88.55 Z1.08 F18000
G1 Z.68
G1 E.3 F1800
; LINE_WIDTH: 0.426072
G1 F4800
M204 S6000
G1 X92.19 Y88.55 E.08424
; OBJECT_ID: 8
; WIPE_START
G1 X90.19 Y88.55 E-.285
; WIPE_END
G1 E-.015 F1800
; stop printing object, unique label id: 12
M625
; start printing object, unique label id: 8
M624 AQAAAAAAAAA=
M204 S10000
G1 X82.831 Y86.524 Z1.08 F18000
G1 X63.09 Y81.09 Z1.08
G1 Z.68
G1 E.3 F1800
M106 S229.5
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
G1 X62.257 Y88.957 E.15818
G1 X60.737 Y88.957 E.03055
G1 X60.737 Y81.045 E.15909
G1 X62.24 Y81.046 E.03022
M204 S10000
G1 X62.681 Y80.622 F18000
G1 F3600
M204 S6000
G1 X62.681 Y89.381 E.17611
G1 X60.313 Y89.381 E.04761
G1 X60.313 Y80.62 E.17616
G1 X60.607 Y80.62 E.00592
G1 X62.621 Y80.622 E.04048
; WIPE_START
G1 X62.634 Y82.622 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G17
G3 Z1.08 I.28 J1.184 P1  F18000
G1 X69.263 Y81.054 Z1.08
G1 Z.68
G1 E.3 F1800
G1 F3600
M204 S6000
G1 X69.263 Y88.957 E.15891
G1 X67.743 Y88.957 E.03055
G1 X67.743 Y81.052 E.15894
G1 X69.203 Y81.053 E.02934
M204 S10000
G1 X69.687 Y80.63 F18000
G1 F3600
M204 S6000
G1 X69.687 Y89.381 E.17596
G1 X67.319 Y89.381 E.04761
G1 X67.319 Y80.627 E.17601
G1 X69.391 Y80.629 E.04167
G1 X69.627 Y80.63 E.00474
M204 S250
G1 X69.898 Y80.221 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1463.446
M204 S5000
G1 X70.096 Y80.221 E.00371
M106 S61.2
M106 S229.5
G1 F600
G1 X70.096 Y89.79 E.1788
M106 S61.2
M106 S229.5
G1 F1463.127
G1 X69.898 Y89.79 E.00371
M106 S61.2
M106 S229.5
G1 F1800
G1 X69.498 Y89.79 E.00747
G1 X60.502 Y89.79 E.16809
G1 X60.102 Y89.79 E.00747
G1 F1460.161
G1 X59.904 Y89.79 E.0037
M106 S61.2
M106 S229.5
G1 F600
G1 X59.904 Y80.21 E.179
M106 S61.2
M106 S229.5
G1 F1460.161
G1 X60.102 Y80.21 E.0037
M106 S61.2
G1 F1800
G1 X60.502 Y80.211 E.00747
G1 X69.838 Y80.221 E.17445
; WIPE_START
M204 S6000
G1 X70.096 Y80.221 E-.03685
G1 X70.096 Y81.962 E-.24815
; WIPE_END
G1 E-.015
M204 S10000
G17
G3 Z1.08 I.489 J-1.114 P1  F18000
G1 X67.115 Y80.654 Z1.08
G1 Z.68
G1 E.3 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.490946
G1 F2400
M204 S6000
G1 X62.885 Y80.652 E.09324
; WIPE_START
G1 X64.885 Y80.653 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G17
G3 Z1.08 I-.422 J-1.141 P1  F18000
G1 X61.771 Y81.805 Z1.08
G1 Z.68
G1 E.3 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.573182
G1 F4800
M204 S6000
G1 X61.771 Y81.532 E.00709
G1 X61.223 Y81.531 E.0142
G1 X61.223 Y88.471 E.18006
G1 X61.771 Y88.471 E.0142
G1 X61.771 Y81.865 E.17139
; WIPE_START
G1 X61.771 Y83.865 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G17
G3 Z1.08 I-1.193 J.242 P1  F18000
G1 X62.885 Y89.35 Z1.08
G1 Z.68
G1 E.3 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.496522
G1 F2400
M204 S6000
G1 X67.115 Y89.35 E.09436
; WIPE_START
G1 X65.115 Y89.35 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G17
G3 Z1.08 I.423 J1.141 P1  F18000
G1 X68.229 Y88.197 Z1.08
G1 Z.68
G1 E.3 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.573297
G1 F4800
M204 S6000
G1 X68.229 Y88.471 E.0071
G1 X68.777 Y88.471 E.01421
G1 X68.777 Y81.539 E.17989
G1 X68.229 Y81.538 E.01421
G1 X68.229 Y88.137 E.17124
; CHANGE_LAYER
; Z_HEIGHT: 0.8
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F4800
G1 X68.229 Y86.137 E-.285
; WIPE_END
G1 E-.015 F1800
; stop printing object, unique label id: 8
M625
; layer num/total_layer_count: 6/57
; update layer progress
M73 L6
M991 S0 P5 ;notify layer change
; OBJECT_ID: 16
; start printing object, unique label id: 16
M624 BAAAAAAAAAA=
M204 S10000
G17
G3 Z1.08 I.019 J1.217 P1  F18000
G1 X111.943 Y85.457 Z1.08
G1 Z.8
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F3600
M204 S6000
G1 X111.943 Y84.543 E.01836
G1 X120.057 Y84.543 E.16313
G1 X120.057 Y85.457 E.01836
G1 X112.003 Y85.457 E.16193
; WIPE_START
G1 X111.943 Y84.543 E-.13039
G1 X113.028 Y84.543 E-.15461
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X109.69 Y85.281 Z1.2 F18000
G1 Z.8
G1 E.3 F1800
G1 F3600
M204 S6000
G1 X109.519 Y85.281 E.00343
G1 X109.519 Y84.719 E.01129
G1 X111.519 Y84.719 E.04021
G1 X111.519 Y84.119 E.01206
G1 X120.481 Y84.119 E.18019
G1 X120.481 Y85.881 E.03542
G1 X111.519 Y85.881 E.18019
G1 X111.519 Y85.281 E.01206
M73 P44 R11
G1 X109.75 Y85.281 E.03557
; WIPE_START
G1 X109.519 Y85.281 E-.03288
G1 X109.519 Y84.719 E-.08002
G1 X110.727 Y84.719 E-.1721
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X109.69 Y86.29 Z1.2 F18000
G1 Z.8
G1 E.3 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
M204 S5000
G1 X109.111 Y86.286 E.01081
G1 X109.116 Y83.711 E.04812
G1 X109.69 Y83.71 E.01073
G1 X109.69 Y84.31 E.01121
G1 X111.11 Y84.31 E.02653
G1 X111.11 Y83.71 E.01121
G1 X120.11 Y83.71 E.16817
G1 X120.113 Y81.712 E.03733
G1 X120.886 Y81.714 E.01445
G1 X120.884 Y88.289 E.12287
G1 X120.114 Y88.288 E.01439
G1 X120.11 Y86.29 E.03734
G1 X111.11 Y86.29 E.16817
G1 X111.11 Y85.69 E.01121
G1 X109.69 Y85.69 E.02653
G1 X109.69 Y86.23 E.01008
; WIPE_START
M204 S6000
G1 X109.111 Y86.286 E-.08285
G1 X109.114 Y84.867 E-.20215
; WIPE_END
G1 E-.015
M204 S10000
G17
G3 Z1.2 I1.217 J0 P1  F18000
; stop printing object, unique label id: 16
M625
; object ids of layer 6 start: 8,12,16
M624 BwAAAAAAAAA=
;===================== date: 20250206 =====================

; don't support timelapse gcode in spiral_mode and by object sequence for I3 structure printer
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
G92 E0
G1 Z1.2
G1 X0 Y85.0002 ; move to safe pos
G1 X-13.0 F3000 ; move to safe pos
M400
M1004 S5 P1  ; external shutter
M400 P300
M971 S11 C11 O0
G92 E0
G1 X0 F18000
M623

; SKIPTYPE: head_wrap_detect
M622.1 S1
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




; object ids of this layer6 end: 8,12,16
M625
; start printing object, unique label id: 16
M624 BAAAAAAAAAA=
G1 X109.4 Y84.515
G1 Z.8
G1 E.3 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.196407
G1 F2400
M204 S6000
G1 X109.4 Y83.915 E.00485
; WIPE_START
G1 X109.4 Y84.515 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X109.4 Y86.085 Z1.2 F18000
G1 Z.8
G1 E.3 F1800
; LINE_WIDTH: 0.196487
G1 F2400
M204 S6000
G1 X109.4 Y85.485 E.00485
M204 S10000
G1 X109.731 Y85 F18000
; LINE_WIDTH: 0.163052
G1 F2400
M204 S6000
G1 X111.731 Y85 E.01301
M204 S10000
G1 X112.156 Y85 F18000
; LINE_WIDTH: 0.514572
G1 F2400
M204 S6000
G1 X119.844 Y85 E.17813
; WIPE_START
G1 X117.844 Y85 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X120.5 Y86.085 Z1.2 F18000
G1 Z.8
G1 E.3 F1800
; LINE_WIDTH: 0.396522
G1 F2400
M204 S6000
G1 X120.5 Y88.085 E.03514
; WIPE_START
G1 X120.5 Y86.085 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X120.5 Y83.915 Z1.2 F18000
G1 Z.8
G1 E.3 F1800
G1 F2400
M204 S6000
G1 X120.5 Y81.917 E.0351
; OBJECT_ID: 12
; WIPE_START
G1 X120.5 Y83.915 E-.285
; WIPE_END
G1 E-.015 F1800
; stop printing object, unique label id: 16
M625
; start printing object, unique label id: 12
M624 AgAAAAAAAAA=
M204 S10000
G1 X112.92 Y84.81 Z1.2 F18000
G1 X88.09 Y87.743 Z1.2
G1 Z.8
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F3600
M204 S6000
G1 X87.257 Y87.743 E.01676
G1 X87.257 Y82.257 E.11033
G1 X92.743 Y82.257 E.11033
G1 X92.743 Y87.743 E.11033
G1 X88.15 Y87.743 E.09236
M204 S10000
G1 X88.09 Y87.319 F18000
G1 F3600
M204 S6000
G1 X87.681 Y87.319 E.00823
G1 X87.681 Y82.681 E.09327
G1 X92.319 Y82.681 E.09327
G1 X92.319 Y87.319 E.09327
G1 X88.15 Y87.319 E.08383
M204 S250
G1 X88.09 Y86.91 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1800
M204 S5000
G1 X88.09 Y83.09 E.07138
G1 X91.91 Y83.09 E.07138
G1 X91.91 Y86.91 E.07138
G1 X88.15 Y86.91 E.07026
; WIPE_START
M204 S6000
G1 X88.119 Y84.91 E-.285
; WIPE_END
G1 E-.015
M204 S10000
G1 X86.943 Y80.645 Z1.2 F18000
G1 Z.8
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F3600
M204 S6000
G1 X93.056 Y80.652 E.12291
G1 X93.057 Y89.357 E.17502
G1 X86.943 Y89.357 E.12292
G1 X86.943 Y80.705 E.17397
M204 S10000
G1 X86.519 Y80.22 F18000
G1 F3600
M204 S6000
G1 X93.48 Y80.229 E.13997
G1 X93.481 Y89.781 E.19207
G1 X86.519 Y89.781 E.13998
G1 X86.519 Y80.28 E.19104
M204 S250
G1 X86.271 Y79.843 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1800
M204 S5000
G1 X86.397 Y79.81 E.00242
G1 X93.666 Y79.82 E.13583
G1 X93.802 Y79.898 E.00293
G1 X93.865 Y79.992 E.00213
G1 X93.89 Y80.103 E.00212
G1 X93.89 Y89.884 E.18275
G1 X93.873 Y89.989 E.00199
G1 X93.831 Y90.073 E.00176
G1 X93.731 Y90.157 E.00244
G1 X93.588 Y90.19 E.00275
G1 X86.417 Y90.19 E.134
G1 X86.311 Y90.173 E.00199
G1 X86.227 Y90.131 E.00176
G1 X86.143 Y90.031 E.00244
G1 X86.11 Y89.888 E.00275
G1 X86.11 Y80.117 E.18258
G1 X86.127 Y80.011 E.00199
G1 X86.164 Y79.937 E.00155
G1 X86.226 Y79.883 E.00154
; WIPE_START
M204 S6000
G1 X86.397 Y79.81 E-.02639
G1 X88.212 Y79.813 E-.25861
; WIPE_END
G1 E-.015
M204 S10000
G1 X92.647 Y81.847 Z1.2 F18000
G1 Z.8
G1 E.3 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.419992
G1 F4800
M204 S6000
G1 X92.647 Y81.061 E.01469
G1 X87.353 Y81.054 E.09892
G1 X87.353 Y81.847 E.01482
G1 X92.587 Y81.847 E.0978
; WIPE_START
G1 X90.587 Y81.847 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X87.749 Y81.451 Z1.2 F18000
G1 Z.8
G1 E.3 F1800
; LINE_WIDTH: 0.421122
G1 F4800
M204 S6000
G1 X92.194 Y81.454 E.08329
; WIPE_START
G1 X90.194 Y81.453 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X92.647 Y88.153 Z1.2 F18000
G1 Z.8
G1 E.3 F1800
; LINE_WIDTH: 0.419992
G1 F4800
M204 S6000
G1 X87.353 Y88.153 E.09893
G1 X87.353 Y88.947 E.01485
G1 X92.647 Y88.947 E.09893
G1 X92.647 Y88.213 E.01373
; WIPE_START
G1 X92.647 Y88.947 E-.10468
G1 X91.382 Y88.947 E-.18032
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X87.75 Y88.55 Z1.2 F18000
G1 Z.8
G1 E.3 F1800
; LINE_WIDTH: 0.426072
G1 F4800
M204 S6000
G1 X92.19 Y88.55 E.08424
; OBJECT_ID: 8
; WIPE_START
G1 X90.19 Y88.55 E-.285
; WIPE_END
G1 E-.015 F1800
; stop printing object, unique label id: 12
M625
; start printing object, unique label id: 8
M624 AQAAAAAAAAA=
M204 S10000
G1 X82.831 Y86.524 Z1.2 F18000
G1 X63.09 Y81.09 Z1.2
G1 Z.8
G1 E.3 F1800
M106 S229.5
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
G1 X62.257 Y88.957 E.15818
G1 X60.541 Y88.957 E.03449
G1 X60.541 Y81.044 E.15911
G1 X62.242 Y81.044 E.0342
M204 S10000
G1 X62.681 Y81.09 F18000
G1 F3600
M204 S6000
G1 X62.681 Y89.381 E.16671
G1 X60.117 Y89.381 E.05155
G1 X60.117 Y80.619 E.17617
G1 X62.681 Y80.62 E.05155
G1 X62.681 Y81.03 E.00824
; WIPE_START
G1 X62.681 Y83.03 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G17
G3 Z1.2 I.342 J1.168 P1  F18000
G1 X69.459 Y81.046 Z1.2
G1 Z.8
G1 E.3 F1800
G1 F3600
M204 S6000
G1 X69.459 Y88.957 E.15906
G1 X67.743 Y88.957 E.03449
G1 X67.743 Y81.046 E.15907
G1 X69.399 Y81.046 E.03328
M204 S10000
G1 X69.883 Y80.622 F18000
G1 F3600
M204 S6000
G1 X69.883 Y89.381 E.17612
G1 X67.319 Y89.381 E.05155
G1 X67.319 Y80.621 E.17613
G1 X69.823 Y80.622 E.05034
M204 S250
G1 X70.137 Y80.213 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1899.872
M204 S5000
G1 X70.292 Y80.213 E.00289
M106 S61.2
M106 S229.5
G1 F1080
G1 X70.292 Y89.79 E.17896
M106 S61.2
M106 S229.5
G1 F1900.295
G1 X70.137 Y89.79 E.00289
M106 S61.2
M106 S229.5
G1 F1800
M73 P45 R11
G1 X59.863 Y89.79 E.19198
G1 F1901.986
G1 X59.708 Y89.79 E.0029
M106 S61.2
M106 S229.5
G1 F1080
G1 X59.708 Y80.21 E.17901
M106 S61.2
M106 S229.5
G1 F1901.986
G1 X59.863 Y80.21 E.0029
M106 S61.2
G1 F1800
G1 X70.077 Y80.213 E.19086
; WIPE_START
M204 S6000
G1 X70.292 Y80.213 E-.03061
G1 X70.292 Y81.998 E-.25439
; WIPE_END
G1 E-.015
M204 S10000
G17
G3 Z1.2 I.299 J-1.18 P1  F18000
G1 X68.153 Y81.455 Z1.2
G1 Z.8
G1 E.3 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.419992
G1 F4800
M204 S6000
G1 X68.153 Y88.547 E.13252
G1 X69.049 Y88.547 E.01675
M73 P45 R10
G1 X69.049 Y81.455 E.13252
G1 X68.213 Y81.455 E.01563
; WIPE_START
G1 X69.049 Y81.455 E-.11923
G1 X69.049 Y82.618 E-.16577
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X68.601 Y88.099 Z1.2 F18000
G1 Z.8
G1 E.3 F1800
; LINE_WIDTH: 0.528172
G1 F4800
M204 S6000
G1 X68.601 Y81.963 E.1461
; WIPE_START
G1 X68.601 Y83.963 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X67.115 Y80.651 Z1.2 F18000
G1 Z.8
G1 E.3 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.495123
G1 F2400
M204 S6000
G1 X62.885 Y80.65 E.09408
; WIPE_START
G1 X64.885 Y80.651 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X61.847 Y81.902 Z1.2 F18000
G1 Z.8
G1 E.3 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.419992
G1 F4800
M204 S6000
G1 X61.847 Y81.453 E.00838
G1 X60.951 Y81.453 E.01676
G1 X60.951 Y88.547 E.13256
G1 X61.847 Y88.547 E.01676
G1 X61.847 Y81.962 E.12306
; WIPE_START
G1 X61.847 Y83.962 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X61.399 Y88.099 Z1.2 F18000
G1 Z.8
G1 E.3 F1800
; LINE_WIDTH: 0.528252
G1 F4800
M204 S6000
G1 X61.399 Y81.962 E.14617
; WIPE_START
G1 X61.399 Y83.962 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X62.885 Y89.35 Z1.2 F18000
G1 Z.8
G1 E.3 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.496522
G1 F2400
M204 S6000
G1 X67.115 Y89.35 E.09436
; CHANGE_LAYER
; Z_HEIGHT: 0.92
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F2400
G1 X65.115 Y89.35 E-.285
; WIPE_END
G1 E-.015 F1800
; stop printing object, unique label id: 8
M625
; layer num/total_layer_count: 7/57
; update layer progress
M73 L7
M991 S0 P6 ;notify layer change
; OBJECT_ID: 16
; start printing object, unique label id: 16
M624 BAAAAAAAAAA=
M204 S10000
G17
G3 Z1.2 I.101 J1.213 P1  F18000
G1 X111.943 Y85.457 Z1.2
G1 Z.92
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F3600
M204 S6000
G1 X111.943 Y84.543 E.01836
G1 X120.057 Y84.543 E.16313
G1 X120.057 Y85.457 E.01836
G1 X112.003 Y85.457 E.16193
; WIPE_START
G1 X111.943 Y84.543 E-.13039
G1 X113.028 Y84.543 E-.15461
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X109.69 Y85.281 Z1.32 F18000
G1 Z.92
G1 E.3 F1800
G1 F3600
M204 S6000
G1 X109.519 Y85.281 E.00343
G1 X109.519 Y84.719 E.01129
G1 X111.519 Y84.719 E.04021
G1 X111.519 Y84.119 E.01206
G1 X120.481 Y84.119 E.18019
G1 X120.481 Y85.881 E.03542
G1 X111.519 Y85.881 E.18019
G1 X111.519 Y85.281 E.01206
G1 X109.75 Y85.281 E.03557
; WIPE_START
G1 X109.519 Y85.281 E-.03288
G1 X109.519 Y84.719 E-.08002
G1 X110.727 Y84.719 E-.1721
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X109.69 Y86.29 Z1.32 F18000
G1 Z.92
G1 E.3 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
M204 S5000
G1 X109.111 Y86.286 E.01081
G1 X109.116 Y83.711 E.04812
G1 X109.69 Y83.71 E.01073
G1 X109.69 Y84.31 E.01121
G1 X111.11 Y84.31 E.02653
G1 X111.11 Y83.71 E.01121
G1 X120.11 Y83.71 E.16817
G1 X120.113 Y81.712 E.03733
G1 X120.885 Y81.714 E.01442
G1 X120.884 Y88.289 E.12287
G1 X120.114 Y88.288 E.01439
G1 X120.11 Y86.29 E.03734
G1 X111.11 Y86.29 E.16817
G1 X111.11 Y85.69 E.01121
G1 X109.69 Y85.69 E.02653
G1 X109.69 Y86.23 E.01008
; WIPE_START
M204 S6000
G1 X109.111 Y86.286 E-.08285
G1 X109.114 Y84.868 E-.20215
; WIPE_END
G1 E-.015
M204 S10000
G17
G3 Z1.32 I1.217 J0 P1  F18000
; stop printing object, unique label id: 16
M625
; object ids of layer 7 start: 8,12,16
M624 BwAAAAAAAAA=
;===================== date: 20250206 =====================

; don't support timelapse gcode in spiral_mode and by object sequence for I3 structure printer
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
G92 E0
G1 Z1.32
G1 X0 Y85.0002 ; move to safe pos
G1 X-13.0 F3000 ; move to safe pos
M400
M1004 S5 P1  ; external shutter
M400 P300
M971 S11 C11 O0
G92 E0
G1 X0 F18000
M623

; SKIPTYPE: head_wrap_detect
M622.1 S1
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




; object ids of this layer7 end: 8,12,16
M625
; start printing object, unique label id: 16
M624 BAAAAAAAAAA=
G1 X109.4 Y84.515
G1 Z.92
G1 E.3 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.196407
G1 F2400
M204 S6000
G1 X109.4 Y83.915 E.00485
; WIPE_START
G1 X109.4 Y84.515 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X109.4 Y86.085 Z1.32 F18000
G1 Z.92
G1 E.3 F1800
; LINE_WIDTH: 0.196487
G1 F2400
M204 S6000
G1 X109.4 Y85.485 E.00485
M204 S10000
G1 X109.731 Y85 F18000
; LINE_WIDTH: 0.163052
G1 F2400
M204 S6000
G1 X111.731 Y85 E.01301
M204 S10000
G1 X112.156 Y85 F18000
; LINE_WIDTH: 0.514572
G1 F2400
M204 S6000
G1 X119.844 Y85 E.17813
; WIPE_START
G1 X117.844 Y85 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X120.5 Y86.085 Z1.32 F18000
G1 Z.92
G1 E.3 F1800
; LINE_WIDTH: 0.396522
G1 F2400
M204 S6000
G1 X120.5 Y88.085 E.03514
; WIPE_START
G1 X120.5 Y86.085 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X120.5 Y83.915 Z1.32 F18000
G1 Z.92
G1 E.3 F1800
G1 F2400
M204 S6000
G1 X120.5 Y81.917 E.0351
; OBJECT_ID: 12
; WIPE_START
G1 X120.5 Y83.915 E-.285
; WIPE_END
G1 E-.015 F1800
; stop printing object, unique label id: 16
M625
; start printing object, unique label id: 12
M624 AgAAAAAAAAA=
M204 S10000
G1 X112.92 Y84.81 Z1.32 F18000
G1 X88.09 Y87.743 Z1.32
G1 Z.92
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F3600
M204 S6000
G1 X87.257 Y87.743 E.01676
G1 X87.257 Y82.257 E.11033
G1 X92.743 Y82.257 E.11033
G1 X92.743 Y87.743 E.11033
G1 X88.15 Y87.743 E.09236
M204 S10000
G1 X88.09 Y87.319 F18000
G1 F3600
M204 S6000
G1 X87.681 Y87.319 E.00823
G1 X87.681 Y82.681 E.09327
G1 X92.319 Y82.681 E.09327
G1 X92.319 Y87.319 E.09327
G1 X88.15 Y87.319 E.08383
M204 S250
G1 X88.09 Y86.91 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1800
M204 S5000
G1 X88.09 Y83.09 E.07138
G1 X91.91 Y83.09 E.07138
G1 X91.91 Y86.91 E.07138
G1 X88.15 Y86.91 E.07026
; WIPE_START
M204 S6000
G1 X88.119 Y84.91 E-.285
; WIPE_END
G1 E-.015
M204 S10000
G1 X86.943 Y80.645 Z1.32 F18000
G1 Z.92
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F3600
M204 S6000
G1 X93.056 Y80.652 E.12291
G1 X93.057 Y89.357 E.17502
G1 X86.943 Y89.357 E.12292
G1 X86.943 Y80.705 E.17397
M204 S10000
G1 X86.519 Y80.22 F18000
G1 F3600
M204 S6000
G1 X93.48 Y80.229 E.13997
G1 X93.481 Y89.781 E.19207
G1 X86.519 Y89.781 E.13998
M73 P46 R10
G1 X86.519 Y80.28 E.19104
M204 S250
G1 X86.26 Y79.847 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1800
M204 S5000
G1 X86.397 Y79.81 E.00265
G1 X93.666 Y79.82 E.13583
G1 X93.802 Y79.898 E.00294
G1 X93.864 Y79.989 E.00206
G1 X93.89 Y80.104 E.00219
G1 X93.89 Y89.883 E.18274
G1 X93.873 Y89.989 E.00199
G1 X93.831 Y90.073 E.00176
G1 X93.731 Y90.157 E.00244
G1 X93.588 Y90.19 E.00275
G1 X86.417 Y90.19 E.134
G1 X86.311 Y90.173 E.00199
G1 X86.227 Y90.131 E.00176
G1 X86.143 Y90.031 E.00244
G1 X86.11 Y89.888 E.00275
G1 X86.11 Y80.117 E.18258
G1 X86.127 Y80.011 E.00199
G1 X86.169 Y79.927 E.00176
G1 X86.215 Y79.887 E.00114
; WIPE_START
M204 S6000
G1 X86.397 Y79.81 E-.02813
G1 X88.199 Y79.813 E-.25687
; WIPE_END
G1 E-.015
M204 S10000
G1 X92.647 Y81.847 Z1.32 F18000
G1 Z.92
G1 E.3 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.419992
G1 F4800
M204 S6000
G1 X92.647 Y81.061 E.01469
G1 X87.353 Y81.054 E.09892
G1 X87.353 Y81.847 E.01482
G1 X92.587 Y81.847 E.0978
; WIPE_START
G1 X90.587 Y81.847 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X87.749 Y81.451 Z1.32 F18000
G1 Z.92
G1 E.3 F1800
; LINE_WIDTH: 0.421122
G1 F4800
M204 S6000
G1 X92.194 Y81.454 E.08329
; WIPE_START
G1 X90.194 Y81.453 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X92.647 Y88.153 Z1.32 F18000
G1 Z.92
G1 E.3 F1800
; LINE_WIDTH: 0.419992
G1 F4800
M204 S6000
G1 X87.353 Y88.153 E.09893
G1 X87.353 Y88.947 E.01485
G1 X92.647 Y88.947 E.09893
G1 X92.647 Y88.213 E.01373
; WIPE_START
G1 X92.647 Y88.947 E-.10468
G1 X91.382 Y88.947 E-.18032
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X87.75 Y88.55 Z1.32 F18000
G1 Z.92
G1 E.3 F1800
; LINE_WIDTH: 0.426072
G1 F4800
M204 S6000
G1 X92.19 Y88.55 E.08424
; OBJECT_ID: 8
; WIPE_START
G1 X90.19 Y88.55 E-.285
; WIPE_END
G1 E-.015 F1800
; stop printing object, unique label id: 12
M625
; start printing object, unique label id: 8
M624 AQAAAAAAAAA=
M204 S10000
G1 X82.831 Y86.524 Z1.32 F18000
G1 X63.09 Y81.09 Z1.32
G1 Z.92
G1 E.3 F1800
M106 S229.5
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
G1 X62.257 Y88.957 E.15818
G1 X60.374 Y88.957 E.03785
G1 X60.374 Y81.043 E.15911
G1 X62.243 Y81.043 E.03758
M204 S10000
G1 X62.681 Y81.09 F18000
G1 F3600
M204 S6000
G1 X62.681 Y89.381 E.16671
G1 X59.95 Y89.381 E.05491
G1 X59.95 Y80.619 E.17617
G1 X62.681 Y80.619 E.05491
G1 X62.681 Y81.03 E.00826
; WIPE_START
G1 X62.681 Y83.03 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X69.626 Y81.043 Z1.32 F18000
G1 Z.92
G1 E.3 F1800
G1 F3600
M204 S6000
G1 X69.625 Y88.957 E.15911
G1 X67.743 Y88.957 E.03784
G1 X67.743 Y81.043 E.15911
G1 X69.566 Y81.043 E.03664
M204 S10000
G1 X70.05 Y80.619 F18000
G1 F3600
M204 S6000
G1 X70.05 Y89.381 E.17617
G1 X67.319 Y89.381 E.0549
G1 X67.319 Y80.619 E.17617
G1 X69.99 Y80.619 E.0537
M204 S250
G1 X70.333 Y80.21 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F2179.118
M204 S5000
G1 X70.459 Y80.21 E.00236
M106 S61.2
M106 S229.5
G1 F1440
G1 X70.459 Y89.79 E.17901
M106 S61.2
M106 S229.5
G1 F1789.757
G1 X70.333 Y89.79 E.00235
M106 S61.2
M106 S229.5
G1 F1800
G1 X59.667 Y89.79 E.19931
G1 F2189.544
G1 X59.541 Y89.79 E.00236
M106 S61.2
M106 S229.5
G1 F1440
G1 X59.541 Y80.21 E.17901
M106 S61.2
M106 S229.5
G1 F1790.431
G1 X59.667 Y80.21 E.00236
M106 S61.2
G1 F1800
G1 X70.273 Y80.21 E.19818
; WIPE_START
M204 S6000
G1 X70.459 Y80.21 E-.02651
G1 X70.459 Y82.024 E-.25849
; WIPE_END
G1 E-.015
M204 S10000
G17
G3 Z1.32 I.462 J-1.126 P1  F18000
G1 X67.115 Y80.65 Z1.32
G1 Z.92
G1 E.3 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.496522
G1 F2400
M204 S6000
G1 X62.885 Y80.65 E.09436
; WIPE_START
G1 X64.885 Y80.65 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X61.847 Y81.985 Z1.32 F18000
G1 Z.92
G1 E.3 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.419992
G1 F4800
M204 S6000
G1 X61.847 Y81.453 E.00994
G1 X60.784 Y81.453 E.01988
G1 X60.784 Y88.547 E.13256
G1 X61.847 Y88.547 E.01988
G1 X61.847 Y82.045 E.1215
M204 S10000
G1 X61.483 Y81.985 F18000
; LINE_WIDTH: 0.360522
G1 F4800
M204 S6000
G1 X61.483 Y81.817 E.00266
G1 X61.148 Y81.817 E.00531
G1 X61.148 Y88.183 E.101
G1 X61.483 Y88.183 E.00531
G1 X61.483 Y82.045 E.09739
; WIPE_START
G1 X61.483 Y84.045 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X62.885 Y89.35 Z1.32 F18000
G1 Z.92
G1 E.3 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.496522
G1 F2400
M204 S6000
G1 X67.115 Y89.35 E.09436
; WIPE_START
G1 X65.115 Y89.35 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X68.153 Y88.547 Z1.32 F18000
G1 Z.92
G1 E.3 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.419992
G1 F4800
M204 S6000
G1 X69.216 Y88.547 E.01987
G1 X69.216 Y81.453 E.13256
G1 X68.153 Y81.453 E.01987
G1 X68.153 Y88.487 E.13144
M204 S10000
G1 X68.517 Y88.016 F18000
; LINE_WIDTH: 0.360427
G1 F4800
M204 S6000
G1 X68.517 Y88.183 E.00265
G1 X68.852 Y88.183 E.00531
G1 X68.852 Y81.817 E.10097
G1 X68.517 Y81.817 E.00531
G1 X68.517 Y87.956 E.09737
; CHANGE_LAYER
; Z_HEIGHT: 1.04
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F4800
G1 X68.517 Y85.956 E-.285
; WIPE_END
G1 E-.015 F1800
; stop printing object, unique label id: 8
M625
; layer num/total_layer_count: 8/57
; update layer progress
M73 L8
M991 S0 P7 ;notify layer change
; OBJECT_ID: 16
; start printing object, unique label id: 16
M624 BAAAAAAAAAA=
M204 S10000
G17
G3 Z1.32 I.014 J1.217 P1  F18000
G1 X111.943 Y85.457 Z1.32
G1 Z1.04
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F3600
M204 S6000
G1 X111.943 Y84.543 E.01836
G1 X120.057 Y84.543 E.16313
G1 X120.057 Y85.457 E.01836
G1 X112.003 Y85.457 E.16193
; WIPE_START
G1 X111.943 Y84.543 E-.13039
G1 X113.028 Y84.543 E-.15461
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X109.69 Y85.281 Z1.44 F18000
G1 Z1.04
G1 E.3 F1800
G1 F3600
M204 S6000
G1 X109.519 Y85.281 E.00343
G1 X109.519 Y84.719 E.01129
G1 X111.519 Y84.719 E.04021
G1 X111.519 Y84.119 E.01206
G1 X120.481 Y84.119 E.18019
G1 X120.481 Y85.881 E.03542
G1 X111.519 Y85.881 E.18019
G1 X111.519 Y85.281 E.01206
G1 X109.75 Y85.281 E.03557
; WIPE_START
G1 X109.519 Y85.281 E-.03288
G1 X109.519 Y84.719 E-.08002
G1 X110.727 Y84.719 E-.1721
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X109.69 Y86.29 Z1.44 F18000
G1 Z1.04
G1 E.3 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
M204 S5000
G1 X109.111 Y86.286 E.01081
G1 X109.116 Y83.711 E.04812
G1 X109.69 Y83.71 E.01073
G1 X109.69 Y84.31 E.01121
G1 X111.11 Y84.31 E.02653
G1 X111.11 Y83.71 E.01121
G1 X120.11 Y83.71 E.16817
G1 X120.113 Y81.713 E.03732
G1 X120.886 Y81.714 E.01445
G1 X120.884 Y88.289 E.12287
G1 X120.114 Y88.288 E.01439
G1 X120.11 Y86.29 E.03734
G1 X111.11 Y86.29 E.16817
G1 X111.11 Y85.69 E.01121
G1 X109.69 Y85.69 E.02653
G1 X109.69 Y86.23 E.01008
; WIPE_START
M204 S6000
G1 X109.111 Y86.286 E-.08285
G1 X109.114 Y84.867 E-.20215
; WIPE_END
G1 E-.015
M204 S10000
G17
M73 P47 R10
G3 Z1.44 I1.217 J0 P1  F18000
; stop printing object, unique label id: 16
M625
; object ids of layer 8 start: 8,12,16
M624 BwAAAAAAAAA=
;===================== date: 20250206 =====================

; don't support timelapse gcode in spiral_mode and by object sequence for I3 structure printer
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
G92 E0
G1 Z1.44
G1 X0 Y85.0002 ; move to safe pos
G1 X-13.0 F3000 ; move to safe pos
M400
M1004 S5 P1  ; external shutter
M400 P300
M971 S11 C11 O0
G92 E0
G1 X0 F18000
M623

; SKIPTYPE: head_wrap_detect
M622.1 S1
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




; object ids of this layer8 end: 8,12,16
M625
; start printing object, unique label id: 16
M624 BAAAAAAAAAA=
G1 X109.4 Y84.515
G1 Z1.04
G1 E.3 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.196407
G1 F2400
M204 S6000
G1 X109.4 Y83.915 E.00485
; WIPE_START
G1 X109.4 Y84.515 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X109.4 Y86.085 Z1.44 F18000
G1 Z1.04
G1 E.3 F1800
; LINE_WIDTH: 0.196487
G1 F2400
M204 S6000
G1 X109.4 Y85.485 E.00485
M204 S10000
G1 X109.731 Y85 F18000
; LINE_WIDTH: 0.163052
G1 F2400
M204 S6000
G1 X111.731 Y85 E.01301
M204 S10000
G1 X112.156 Y85 F18000
; LINE_WIDTH: 0.514572
G1 F2400
M204 S6000
G1 X119.844 Y85 E.17813
; WIPE_START
G1 X117.844 Y85 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X120.5 Y86.085 Z1.44 F18000
G1 Z1.04
G1 E.3 F1800
; LINE_WIDTH: 0.396522
G1 F2400
M204 S6000
G1 X120.5 Y88.085 E.03514
; WIPE_START
G1 X120.5 Y86.085 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X120.5 Y83.915 Z1.44 F18000
G1 Z1.04
G1 E.3 F1800
G1 F2400
M204 S6000
G1 X120.5 Y81.917 E.0351
; OBJECT_ID: 12
; WIPE_START
G1 X120.5 Y83.915 E-.285
; WIPE_END
G1 E-.015 F1800
; stop printing object, unique label id: 16
M625
; start printing object, unique label id: 12
M624 AgAAAAAAAAA=
M204 S10000
G1 X112.92 Y84.81 Z1.44 F18000
G1 X88.09 Y87.743 Z1.44
G1 Z1.04
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F3600
M204 S6000
G1 X87.257 Y87.743 E.01676
G1 X87.257 Y82.257 E.11033
G1 X92.743 Y82.257 E.11033
G1 X92.743 Y87.743 E.11033
G1 X88.15 Y87.743 E.09236
M204 S10000
G1 X88.09 Y87.319 F18000
G1 F3600
M204 S6000
G1 X87.681 Y87.319 E.00823
G1 X87.681 Y82.681 E.09327
G1 X92.319 Y82.681 E.09327
G1 X92.319 Y87.319 E.09327
G1 X88.15 Y87.319 E.08383
M204 S250
G1 X88.09 Y86.91 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1800
M204 S5000
G1 X88.09 Y83.09 E.07138
G1 X91.91 Y83.09 E.07138
G1 X91.91 Y86.91 E.07138
G1 X88.15 Y86.91 E.07026
; WIPE_START
M204 S6000
G1 X88.119 Y84.91 E-.285
; WIPE_END
G1 E-.015
M204 S10000
G1 X86.943 Y80.645 Z1.44 F18000
G1 Z1.04
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F3600
M204 S6000
G1 X93.056 Y80.652 E.12291
G1 X93.057 Y89.357 E.17502
G1 X86.943 Y89.357 E.12292
G1 X86.943 Y80.705 E.17397
M204 S10000
G1 X86.519 Y80.22 F18000
G1 F3600
M204 S6000
G1 X93.48 Y80.229 E.13997
G1 X93.481 Y89.781 E.19207
G1 X86.519 Y89.781 E.13998
G1 X86.519 Y80.28 E.19104
M204 S250
G1 X86.269 Y79.844 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1800
M204 S5000
G1 X86.397 Y79.81 E.00248
G1 X93.666 Y79.82 E.13583
G1 X93.802 Y79.898 E.00293
G1 X93.865 Y79.992 E.00212
G1 X93.89 Y80.103 E.00212
G1 X93.89 Y89.884 E.18275
G1 X93.873 Y89.989 E.00199
G1 X93.831 Y90.073 E.00176
G1 X93.731 Y90.157 E.00244
G1 X93.588 Y90.19 E.00275
G1 X86.417 Y90.19 E.134
G1 X86.311 Y90.173 E.00199
G1 X86.227 Y90.131 E.00176
G1 X86.143 Y90.031 E.00244
G1 X86.11 Y89.888 E.00274
G1 X86.11 Y80.116 E.18258
G1 X86.127 Y80.011 E.00199
G1 X86.165 Y79.937 E.00156
G1 X86.224 Y79.884 E.00148
; WIPE_START
M204 S6000
G1 X86.397 Y79.81 E-.02681
G1 X88.209 Y79.813 E-.25819
; WIPE_END
G1 E-.015
M204 S10000
G1 X92.647 Y81.847 Z1.44 F18000
G1 Z1.04
G1 E.3 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.419992
G1 F4800
M204 S6000
G1 X92.647 Y81.061 E.01469
G1 X87.353 Y81.054 E.09892
G1 X87.353 Y81.847 E.01482
G1 X92.587 Y81.847 E.0978
; WIPE_START
G1 X90.587 Y81.847 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X87.749 Y81.451 Z1.44 F18000
G1 Z1.04
G1 E.3 F1800
; LINE_WIDTH: 0.421122
G1 F4800
M204 S6000
G1 X92.194 Y81.454 E.08329
; WIPE_START
G1 X90.194 Y81.453 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X92.647 Y88.153 Z1.44 F18000
G1 Z1.04
G1 E.3 F1800
; LINE_WIDTH: 0.419992
G1 F4800
M204 S6000
G1 X87.353 Y88.153 E.09893
G1 X87.353 Y88.947 E.01485
G1 X92.647 Y88.947 E.09893
G1 X92.647 Y88.213 E.01373
; WIPE_START
G1 X92.647 Y88.947 E-.10468
G1 X91.382 Y88.947 E-.18032
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X87.75 Y88.55 Z1.44 F18000
G1 Z1.04
G1 E.3 F1800
; LINE_WIDTH: 0.426072
G1 F4800
M204 S6000
G1 X92.19 Y88.55 E.08424
; OBJECT_ID: 8
; WIPE_START
G1 X90.19 Y88.55 E-.285
; WIPE_END
G1 E-.015 F1800
; stop printing object, unique label id: 12
M625
; start printing object, unique label id: 8
M624 AQAAAAAAAAA=
M204 S10000
G1 X82.831 Y86.524 Z1.44 F18000
G1 X63.09 Y81.09 Z1.44
G1 Z1.04
G1 E.3 F1800
M106 S229.5
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
G1 X62.257 Y88.957 E.15818
G1 X60.229 Y88.957 E.04078
G1 X60.229 Y81.043 E.15911
G1 X62.243 Y81.043 E.04051
M204 S10000
G1 X62.681 Y81.09 F18000
G1 F3600
M204 S6000
G1 X62.681 Y89.381 E.16671
G1 X59.804 Y89.381 E.05784
G1 X59.804 Y80.619 E.17617
G1 X62.681 Y80.619 E.05784
G1 X62.681 Y81.03 E.00826
; WIPE_START
G1 X62.681 Y83.03 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X69.772 Y81.043 Z1.44 F18000
G1 Z1.04
G1 E.3 F1800
G1 F3600
M204 S6000
G1 X69.772 Y88.957 E.15911
G1 X67.743 Y88.957 E.04078
G1 X67.743 Y81.043 E.15911
G1 X69.712 Y81.043 E.03958
M204 S10000
G1 X70.196 Y80.619 F18000
G1 F3600
M204 S6000
G1 X70.196 Y89.381 E.17617
G1 X67.319 Y89.381 E.05784
G1 X67.319 Y80.619 E.17617
G1 X70.136 Y80.619 E.05664
M204 S250
G1 X70.5 Y80.21 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F2329.863
M204 S5000
G1 X70.605 Y80.21 E.00196
M106 S61.2
M106 S229.5
G1 F1680
G1 X70.605 Y89.79 E.17901
M106 S61.2
M106 S229.5
G1 F1991.864
G1 X70.5 Y89.79 E.00196
M106 S61.2
M106 S229.5
G1 F1800
G1 X59.5 Y89.79 E.20554
G1 F2121.1
G1 X59.395 Y89.79 E.00196
M106 S61.2
M106 S229.5
G1 F1680
G1 X59.395 Y80.21 E.17901
M106 S61.2
M106 S229.5
G1 F1990.658
G1 X59.5 Y80.21 E.00196
M106 S61.2
G1 F1800
G1 X70.44 Y80.21 E.20443
; WIPE_START
M204 S6000
G1 X70.605 Y80.21 E-.02353
G1 X70.605 Y82.045 E-.26147
; WIPE_END
G1 E-.015
M204 S10000
G17
G3 Z1.44 I.452 J-1.13 P1  F18000
G1 X67.115 Y80.65 Z1.44
G1 Z1.04
G1 E.3 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.496522
M73 P48 R10
G1 F2400
M204 S6000
G1 X62.885 Y80.65 E.09436
; WIPE_START
G1 X64.885 Y80.65 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X61.847 Y82.057 Z1.44 F18000
G1 Z1.04
G1 E.3 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.419992
G1 F4800
M204 S6000
G1 X61.847 Y81.453 E.0113
G1 X60.638 Y81.453 E.0226
G1 X60.638 Y88.547 E.13256
G1 X61.847 Y88.547 E.0226
G1 X61.847 Y82.117 E.12014
M204 S10000
G1 X61.446 Y82.057 F18000
; LINE_WIDTH: 0.433392
G1 F4800
M204 S6000
G1 X61.446 Y81.854 E.00394
G1 X61.039 Y81.854 E.00788
G1 X61.039 Y88.146 E.12158
G1 X61.446 Y88.146 E.00788
G1 X61.446 Y82.117 E.11648
; WIPE_START
G1 X61.446 Y84.117 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X62.885 Y89.35 Z1.44 F18000
G1 Z1.04
G1 E.3 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.496522
G1 F2400
M204 S6000
G1 X67.115 Y89.35 E.09436
; WIPE_START
G1 X65.115 Y89.35 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X68.153 Y88.547 Z1.44 F18000
G1 Z1.04
G1 E.3 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.419992
G1 F4800
M204 S6000
G1 X69.362 Y88.547 E.0226
G1 X69.362 Y81.453 E.13256
G1 X68.153 Y81.453 E.0226
G1 X68.153 Y88.487 E.13144
M204 S10000
G1 X68.554 Y87.942 F18000
; LINE_WIDTH: 0.433477
G1 F4800
M204 S6000
G1 X68.554 Y88.146 E.00394
G1 X68.961 Y88.146 E.00788
G1 X68.961 Y81.854 E.1216
G1 X68.554 Y81.854 E.00788
G1 X68.554 Y87.882 E.1165
; CHANGE_LAYER
; Z_HEIGHT: 1.16
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F4800
G1 X68.554 Y85.882 E-.285
; WIPE_END
G1 E-.015 F1800
; stop printing object, unique label id: 8
M625
; layer num/total_layer_count: 9/57
; update layer progress
M73 L9
M991 S0 P8 ;notify layer change
; OBJECT_ID: 16
; start printing object, unique label id: 16
M624 BAAAAAAAAAA=
M204 S10000
G17
G3 Z1.44 I.012 J1.217 P1  F18000
G1 X111.943 Y85.457 Z1.44
G1 Z1.16
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F3600
M204 S6000
G1 X111.943 Y84.543 E.01836
G1 X120.057 Y84.543 E.16313
G1 X120.057 Y85.457 E.01836
G1 X112.003 Y85.457 E.16193
; WIPE_START
G1 X111.943 Y84.543 E-.13039
G1 X113.028 Y84.543 E-.15461
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X109.69 Y85.281 Z1.56 F18000
G1 Z1.16
G1 E.3 F1800
G1 F3600
M204 S6000
G1 X109.519 Y85.281 E.00343
G1 X109.519 Y84.719 E.01129
G1 X111.519 Y84.719 E.04021
G1 X111.519 Y84.119 E.01206
G1 X120.481 Y84.119 E.18019
G1 X120.481 Y85.881 E.03542
G1 X111.519 Y85.881 E.18019
G1 X111.519 Y85.281 E.01206
G1 X109.75 Y85.281 E.03557
; WIPE_START
G1 X109.519 Y85.281 E-.03288
G1 X109.519 Y84.719 E-.08002
G1 X110.727 Y84.719 E-.1721
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X109.69 Y86.29 Z1.56 F18000
G1 Z1.16
G1 E.3 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
M204 S5000
G1 X109.111 Y86.286 E.01081
G1 X109.116 Y83.711 E.04812
G1 X109.69 Y83.71 E.01073
G1 X109.69 Y84.31 E.01121
G1 X111.11 Y84.31 E.02653
G1 X111.11 Y83.71 E.01121
G1 X120.11 Y83.71 E.16817
G1 X120.113 Y81.712 E.03733
G1 X120.885 Y81.715 E.01443
G1 X120.884 Y88.289 E.12284
G1 X120.114 Y88.288 E.01439
G1 X120.11 Y86.29 E.03734
G1 X111.11 Y86.29 E.16817
G1 X111.11 Y85.69 E.01121
G1 X109.69 Y85.69 E.02653
G1 X109.69 Y86.23 E.01008
; WIPE_START
M204 S6000
G1 X109.111 Y86.286 E-.08285
G1 X109.114 Y84.868 E-.20215
; WIPE_END
G1 E-.015
M204 S10000
G17
G3 Z1.56 I1.217 J0 P1  F18000
; stop printing object, unique label id: 16
M625
; object ids of layer 9 start: 8,12,16
M624 BwAAAAAAAAA=
;===================== date: 20250206 =====================

; don't support timelapse gcode in spiral_mode and by object sequence for I3 structure printer
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
G92 E0
G1 Z1.56
G1 X0 Y85.0002 ; move to safe pos
G1 X-13.0 F3000 ; move to safe pos
M400
M1004 S5 P1  ; external shutter
M400 P300
M971 S11 C11 O0
G92 E0
G1 X0 F18000
M623

; SKIPTYPE: head_wrap_detect
M622.1 S1
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




; object ids of this layer9 end: 8,12,16
M625
; start printing object, unique label id: 16
M624 BAAAAAAAAAA=
G1 X109.4 Y84.515
G1 Z1.16
G1 E.3 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.196407
G1 F2400
M204 S6000
G1 X109.4 Y83.915 E.00485
; WIPE_START
G1 X109.4 Y84.515 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X109.4 Y86.085 Z1.56 F18000
G1 Z1.16
G1 E.3 F1800
; LINE_WIDTH: 0.196487
G1 F2400
M204 S6000
G1 X109.4 Y85.485 E.00485
M204 S10000
G1 X109.731 Y85 F18000
; LINE_WIDTH: 0.163052
G1 F2400
M204 S6000
G1 X111.731 Y85 E.01301
M204 S10000
G1 X112.156 Y85 F18000
; LINE_WIDTH: 0.514572
G1 F2400
M204 S6000
G1 X119.844 Y85 E.17813
; WIPE_START
G1 X117.844 Y85 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X120.5 Y86.085 Z1.56 F18000
G1 Z1.16
G1 E.3 F1800
; LINE_WIDTH: 0.396522
G1 F2400
M204 S6000
G1 X120.5 Y88.085 E.03514
; WIPE_START
G1 X120.5 Y86.085 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X120.5 Y83.915 Z1.56 F18000
G1 Z1.16
G1 E.3 F1800
G1 F2400
M204 S6000
G1 X120.5 Y81.918 E.03508
; OBJECT_ID: 12
; WIPE_START
G1 X120.5 Y83.915 E-.285
; WIPE_END
G1 E-.015 F1800
; stop printing object, unique label id: 16
M625
; start printing object, unique label id: 12
M624 AgAAAAAAAAA=
M204 S10000
G1 X112.92 Y84.81 Z1.56 F18000
G1 X88.09 Y87.743 Z1.56
G1 Z1.16
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F3600
M204 S6000
G1 X87.257 Y87.743 E.01676
G1 X87.257 Y82.257 E.11033
G1 X92.743 Y82.257 E.11033
G1 X92.743 Y87.743 E.11033
G1 X88.15 Y87.743 E.09236
M204 S10000
G1 X88.09 Y87.319 F18000
G1 F3600
M204 S6000
G1 X87.681 Y87.319 E.00823
G1 X87.681 Y82.681 E.09327
G1 X92.319 Y82.681 E.09327
G1 X92.319 Y87.319 E.09327
G1 X88.15 Y87.319 E.08383
M204 S250
G1 X88.09 Y86.91 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1800
M204 S5000
G1 X88.09 Y83.09 E.07138
G1 X91.91 Y83.09 E.07138
G1 X91.91 Y86.91 E.07138
G1 X88.15 Y86.91 E.07026
; WIPE_START
M204 S6000
G1 X88.119 Y84.91 E-.285
; WIPE_END
G1 E-.015
M204 S10000
G1 X86.943 Y80.645 Z1.56 F18000
G1 Z1.16
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F3600
M204 S6000
G1 X93.056 Y80.652 E.12291
G1 X93.057 Y89.357 E.17502
G1 X86.943 Y89.357 E.12292
G1 X86.943 Y80.705 E.17397
M204 S10000
G1 X86.519 Y80.22 F18000
G1 F3600
M204 S6000
G1 X93.48 Y80.229 E.13997
G1 X93.481 Y89.781 E.19207
G1 X86.519 Y89.781 E.13998
G1 X86.519 Y80.28 E.19104
M204 S250
G1 X86.269 Y79.844 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1800
M204 S5000
G1 X86.397 Y79.81 E.00248
G1 X93.666 Y79.82 E.13584
G1 X93.803 Y79.898 E.00294
G1 X93.864 Y79.988 E.00203
G1 X93.89 Y80.104 E.00221
G1 X93.89 Y89.883 E.18274
G1 X93.873 Y89.989 E.00199
G1 X93.831 Y90.073 E.00176
G1 X93.731 Y90.157 E.00244
G1 X93.588 Y90.19 E.00275
G1 X86.416 Y90.19 E.134
G1 X86.311 Y90.173 E.00199
G1 X86.227 Y90.131 E.00176
G1 X86.143 Y90.031 E.00244
G1 X86.11 Y89.888 E.00275
G1 X86.11 Y80.117 E.18258
G1 X86.127 Y80.011 E.00199
G1 X86.165 Y79.937 E.00156
G1 X86.224 Y79.884 E.00148
; WIPE_START
M204 S6000
G1 X86.397 Y79.81 E-.0268
G1 X88.209 Y79.813 E-.2582
; WIPE_END
G1 E-.015
M204 S10000
G1 X92.647 Y81.847 Z1.56 F18000
G1 Z1.16
G1 E.3 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.419992
G1 F4800
M204 S6000
M73 P49 R10
G1 X92.647 Y81.061 E.01469
G1 X87.353 Y81.054 E.09892
G1 X87.353 Y81.847 E.01482
G1 X92.587 Y81.847 E.0978
; WIPE_START
G1 X90.587 Y81.847 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X87.749 Y81.451 Z1.56 F18000
G1 Z1.16
G1 E.3 F1800
; LINE_WIDTH: 0.421112
G1 F4800
M204 S6000
G1 X92.194 Y81.454 E.08329
; WIPE_START
G1 X90.194 Y81.453 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X92.647 Y88.153 Z1.56 F18000
G1 Z1.16
G1 E.3 F1800
; LINE_WIDTH: 0.419992
G1 F4800
M204 S6000
G1 X87.353 Y88.153 E.09893
G1 X87.353 Y88.947 E.01485
G1 X92.647 Y88.947 E.09893
G1 X92.647 Y88.213 E.01373
; WIPE_START
G1 X92.647 Y88.947 E-.10468
G1 X91.382 Y88.947 E-.18032
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X87.75 Y88.55 Z1.56 F18000
G1 Z1.16
G1 E.3 F1800
; LINE_WIDTH: 0.426072
G1 F4800
M204 S6000
G1 X92.19 Y88.55 E.08424
; OBJECT_ID: 8
; WIPE_START
G1 X90.19 Y88.55 E-.285
; WIPE_END
G1 E-.015 F1800
; stop printing object, unique label id: 12
M625
; start printing object, unique label id: 8
M624 AQAAAAAAAAA=
M204 S10000
G1 X82.831 Y86.524 Z1.56 F18000
G1 X63.09 Y81.09 Z1.56
G1 Z1.16
G1 E.3 F1800
M106 S229.5
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
G1 X62.257 Y88.957 E.15818
G1 X60.099 Y88.957 E.04339
G1 X60.099 Y81.044 E.15909
G1 X62.24 Y81.046 E.04306
M204 S10000
G1 X62.681 Y81.09 F18000
G1 F3600
M204 S6000
G1 X62.681 Y89.381 E.16671
G1 X59.674 Y89.381 E.06045
G1 X59.674 Y80.62 E.17616
G1 X62.681 Y80.623 E.06045
G1 X62.681 Y81.03 E.00819
; WIPE_START
G1 X62.681 Y83.03 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X69.901 Y81.054 Z1.56 F18000
G1 Z1.16
G1 E.3 F1800
G1 F3600
M204 S6000
G1 X69.901 Y88.957 E.15891
G1 X67.743 Y88.957 E.04339
G1 X67.743 Y81.052 E.15895
G1 X69.841 Y81.054 E.04218
M204 S10000
G1 X70.325 Y80.63 F18000
G1 F3600
M204 S6000
G1 X70.325 Y89.381 E.17596
G1 X67.319 Y89.381 E.06045
G1 X67.319 Y80.627 E.17602
G1 X70.265 Y80.63 E.05924
M204 S250
G1 X70.646 Y80.221 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F2562.419
M204 S5000
G1 X70.735 Y80.221 E.00165
M106 S61.2
M106 S229.5
G1 F1980
G1 X70.735 Y89.79 E.1788
M106 S61.2
M106 S229.5
G1 F2262.594
G1 X70.646 Y89.79 E.00166
M106 S61.2
M106 S229.5
G1 F1800
G1 X59.354 Y89.79 E.211
G1 F2070.953
G1 X59.265 Y89.79 E.00166
M106 S61.2
M106 S229.5
G1 F1980
G1 X59.265 Y80.21 E.17901
M106 S61.2
M106 S229.5
G1 F2263.715
G1 X59.354 Y80.21 E.00166
M106 S61.2
G1 F1800
G1 X70.586 Y80.221 E.20988
; WIPE_START
M204 S6000
G1 X70.735 Y80.221 E-.02114
G1 X70.735 Y82.073 E-.26386
; WIPE_END
G1 E-.015
M204 S10000
G1 X68.153 Y81.461 Z1.56 F18000
G1 Z1.16
G1 E.3 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.419992
G1 F4800
M204 S6000
G1 X68.153 Y88.547 E.1324
G1 X69.492 Y88.547 E.02502
G1 X69.492 Y81.463 E.13238
G1 X68.213 Y81.461 E.0239
M204 S10000
G1 X68.586 Y82.131 F18000
; LINE_WIDTH: 0.498217
G1 F4800
M204 S6000
G1 X68.586 Y88.114 E.13396
G1 X69.059 Y88.114 E.01058
G1 X69.059 Y81.895 E.13925
G1 X68.586 Y81.895 E.01058
G1 X68.586 Y82.071 E.00395
; WIPE_START
G1 X68.586 Y81.895 E-.02514
G1 X69.059 Y81.895 E-.06733
G1 X69.059 Y83.247 E-.19253
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X67.115 Y80.654 Z1.56 F18000
G1 Z1.16
G1 E.3 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.490923
G1 F2400
M204 S6000
G1 X62.885 Y80.652 E.09324
; WIPE_START
G1 X64.885 Y80.653 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X61.847 Y82.124 Z1.56 F18000
G1 Z1.16
G1 E.3 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.419992
G1 F4800
M204 S6000
G1 X61.847 Y81.455 E.0125
G1 X60.508 Y81.454 E.02503
G1 X60.508 Y88.547 E.13254
G1 X61.847 Y88.547 E.02503
G1 X61.847 Y82.184 E.11889
M204 S10000
G1 X61.414 Y82.124 F18000
; LINE_WIDTH: 0.498362
G1 F4800
M204 S6000
G1 X61.414 Y81.888 E.00529
G1 X60.941 Y81.888 E.01059
G1 X60.941 Y88.114 E.13946
G1 X61.414 Y88.114 E.01059
G1 X61.414 Y82.184 E.13282
; WIPE_START
G1 X61.414 Y84.184 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X62.885 Y89.35 Z1.56 F18000
G1 Z1.16
G1 E.3 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.496522
G1 F2400
M204 S6000
G1 X67.115 Y89.35 E.09436
; CHANGE_LAYER
; Z_HEIGHT: 1.28
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F2400
G1 X65.115 Y89.35 E-.285
; WIPE_END
G1 E-.015 F1800
; stop printing object, unique label id: 8
M625
; layer num/total_layer_count: 10/57
; update layer progress
M73 L10
M991 S0 P9 ;notify layer change
; OBJECT_ID: 16
; start printing object, unique label id: 16
M624 BAAAAAAAAAA=
M204 S10000
G17
G3 Z1.56 I.101 J1.213 P1  F18000
G1 X111.943 Y85.457 Z1.56
G1 Z1.28
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F3600
M204 S6000
G1 X111.943 Y84.543 E.01836
G1 X120.057 Y84.543 E.16313
G1 X120.057 Y85.457 E.01836
G1 X112.003 Y85.457 E.16193
; WIPE_START
G1 X111.943 Y84.543 E-.13039
G1 X113.028 Y84.543 E-.15461
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X109.69 Y85.281 Z1.68 F18000
G1 Z1.28
G1 E.3 F1800
G1 F3600
M204 S6000
G1 X109.519 Y85.281 E.00343
G1 X109.519 Y84.719 E.01129
G1 X111.519 Y84.719 E.04021
G1 X111.519 Y84.119 E.01206
G1 X120.481 Y84.119 E.18019
G1 X120.481 Y85.881 E.03542
G1 X111.519 Y85.881 E.18019
G1 X111.519 Y85.281 E.01206
G1 X109.75 Y85.281 E.03557
; WIPE_START
G1 X109.519 Y85.281 E-.03288
G1 X109.519 Y84.719 E-.08002
G1 X110.727 Y84.719 E-.1721
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X109.69 Y86.29 Z1.68 F18000
G1 Z1.28
G1 E.3 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
M204 S5000
G1 X109.111 Y86.286 E.01081
G1 X109.116 Y83.711 E.04812
G1 X109.69 Y83.71 E.01073
G1 X109.69 Y84.31 E.01121
G1 X111.11 Y84.31 E.02653
G1 X111.11 Y83.71 E.01121
G1 X120.11 Y83.71 E.16817
G1 X120.113 Y81.713 E.03732
G1 X120.886 Y81.714 E.01445
G1 X120.884 Y88.289 E.12287
G1 X120.114 Y88.288 E.01439
G1 X120.11 Y86.29 E.03734
G1 X111.11 Y86.29 E.16817
G1 X111.11 Y85.69 E.01121
G1 X109.69 Y85.69 E.02653
G1 X109.69 Y86.23 E.01008
; WIPE_START
M204 S6000
G1 X109.111 Y86.286 E-.08285
G1 X109.114 Y84.868 E-.20215
; WIPE_END
G1 E-.015
M204 S10000
G17
G3 Z1.68 I1.217 J0 P1  F18000
; stop printing object, unique label id: 16
M625
; object ids of layer 10 start: 8,12,16
M624 BwAAAAAAAAA=
;===================== date: 20250206 =====================

; don't support timelapse gcode in spiral_mode and by object sequence for I3 structure printer
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
G92 E0
G1 Z1.68
G1 X0 Y85.0002 ; move to safe pos
G1 X-13.0 F3000 ; move to safe pos
M400
M1004 S5 P1  ; external shutter
M400 P300
M971 S11 C11 O0
G92 E0
G1 X0 F18000
M623

; SKIPTYPE: head_wrap_detect
M622.1 S1
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




; object ids of this layer10 end: 8,12,16
M625
; start printing object, unique label id: 16
M624 BAAAAAAAAAA=
G1 X109.4 Y84.515
G1 Z1.28
G1 E.3 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.196407
G1 F2400
M204 S6000
G1 X109.4 Y83.915 E.00485
; WIPE_START
G1 X109.4 Y84.515 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X109.4 Y86.085 Z1.68 F18000
G1 Z1.28
G1 E.3 F1800
; LINE_WIDTH: 0.196487
G1 F2400
M204 S6000
G1 X109.4 Y85.485 E.00485
M204 S10000
G1 X109.731 Y85 F18000
; LINE_WIDTH: 0.163052
G1 F2400
M204 S6000
G1 X111.731 Y85 E.01301
M204 S10000
G1 X112.156 Y85 F18000
; LINE_WIDTH: 0.514572
G1 F2400
M204 S6000
G1 X119.844 Y85 E.17813
; WIPE_START
G1 X117.844 Y85 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X120.5 Y86.085 Z1.68 F18000
G1 Z1.28
G1 E.3 F1800
; LINE_WIDTH: 0.396522
G1 F2400
M204 S6000
G1 X120.5 Y88.085 E.03514
; WIPE_START
G1 X120.5 Y86.085 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X120.5 Y83.915 Z1.68 F18000
G1 Z1.28
G1 E.3 F1800
M73 P50 R10
G1 F2400
M204 S6000
G1 X120.5 Y81.917 E.0351
; OBJECT_ID: 12
; WIPE_START
G1 X120.5 Y83.915 E-.285
; WIPE_END
G1 E-.015 F1800
; stop printing object, unique label id: 16
M625
; start printing object, unique label id: 12
M624 AgAAAAAAAAA=
M204 S10000
G1 X112.92 Y84.81 Z1.68 F18000
G1 X88.09 Y87.743 Z1.68
G1 Z1.28
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F3600
M204 S6000
G1 X87.257 Y87.743 E.01676
G1 X87.257 Y82.257 E.11033
G1 X92.743 Y82.257 E.11033
G1 X92.743 Y87.743 E.11033
G1 X88.15 Y87.743 E.09236
M204 S10000
M73 P50 R9
G1 X88.09 Y87.319 F18000
G1 F3600
M204 S6000
G1 X87.681 Y87.319 E.00823
G1 X87.681 Y82.681 E.09327
G1 X92.319 Y82.681 E.09327
G1 X92.319 Y87.319 E.09327
G1 X88.15 Y87.319 E.08383
M204 S250
G1 X88.09 Y86.91 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1800
M204 S5000
G1 X88.09 Y83.09 E.07138
G1 X91.91 Y83.09 E.07138
G1 X91.91 Y86.91 E.07138
G1 X88.15 Y86.91 E.07026
; WIPE_START
M204 S6000
G1 X88.119 Y84.91 E-.285
; WIPE_END
G1 E-.015
M204 S10000
G1 X86.943 Y80.645 Z1.68 F18000
G1 Z1.28
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F3600
M204 S6000
G1 X93.056 Y80.652 E.12291
G1 X93.057 Y89.357 E.17502
G1 X86.943 Y89.357 E.12292
G1 X86.943 Y80.705 E.17397
M204 S10000
G1 X86.519 Y80.22 F18000
G1 F3600
M204 S6000
G1 X93.48 Y80.229 E.13997
G1 X93.481 Y89.781 E.19207
G1 X86.519 Y89.781 E.13998
G1 X86.519 Y80.28 E.19104
M204 S250
G1 X86.269 Y79.844 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1800
M204 S5000
G1 X86.397 Y79.81 E.00248
G1 X93.656 Y79.82 E.13563
G1 X93.761 Y79.863 E.00213
G1 X93.83 Y79.93 E.0018
G1 X93.89 Y80.095 E.00328
G1 X93.89 Y89.883 E.1829
G1 X93.873 Y89.989 E.00199
G1 X93.831 Y90.073 E.00176
G1 X93.731 Y90.157 E.00244
G1 X93.588 Y90.19 E.00275
G1 X86.417 Y90.19 E.134
G1 X86.311 Y90.173 E.00199
G1 X86.227 Y90.131 E.00176
G1 X86.143 Y90.031 E.00244
G1 X86.11 Y89.888 E.00275
G1 X86.11 Y80.117 E.18258
G1 X86.127 Y80.011 E.00199
G1 X86.165 Y79.937 E.00156
G1 X86.224 Y79.884 E.00148
; WIPE_START
M204 S6000
G1 X86.397 Y79.81 E-.02681
G1 X88.209 Y79.813 E-.25819
; WIPE_END
G1 E-.015
M204 S10000
G1 X92.647 Y81.847 Z1.68 F18000
G1 Z1.28
G1 E.3 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.419992
G1 F4800
M204 S6000
G1 X92.647 Y81.061 E.01469
G1 X87.353 Y81.054 E.09892
G1 X87.353 Y81.847 E.01482
G1 X92.587 Y81.847 E.0978
; WIPE_START
G1 X90.587 Y81.847 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X87.749 Y81.451 Z1.68 F18000
G1 Z1.28
G1 E.3 F1800
; LINE_WIDTH: 0.421122
G1 F4800
M204 S6000
G1 X92.194 Y81.454 E.08329
; WIPE_START
G1 X90.194 Y81.453 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X92.647 Y88.153 Z1.68 F18000
G1 Z1.28
G1 E.3 F1800
; LINE_WIDTH: 0.419992
G1 F4800
M204 S6000
G1 X87.353 Y88.153 E.09893
G1 X87.353 Y88.947 E.01485
G1 X92.647 Y88.947 E.09893
G1 X92.647 Y88.213 E.01373
; WIPE_START
G1 X92.647 Y88.947 E-.10468
G1 X91.382 Y88.947 E-.18032
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X87.75 Y88.55 Z1.68 F18000
G1 Z1.28
G1 E.3 F1800
; LINE_WIDTH: 0.426072
G1 F4800
M204 S6000
G1 X92.19 Y88.55 E.08424
; OBJECT_ID: 8
; WIPE_START
G1 X90.19 Y88.55 E-.285
; WIPE_END
G1 E-.015 F1800
; stop printing object, unique label id: 12
M625
; start printing object, unique label id: 8
M624 AQAAAAAAAAA=
M204 S10000
G1 X82.831 Y86.524 Z1.68 F18000
G1 X63.09 Y81.09 Z1.68
G1 Z1.28
G1 E.3 F1800
M106 S229.5
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
G1 X62.257 Y88.957 E.15818
G1 X59.982 Y88.957 E.04573
G1 X59.982 Y81.043 E.15911
G1 X62.243 Y81.043 E.04546
M204 S10000
G1 X62.681 Y81.09 F18000
G1 F3600
M204 S6000
G1 X62.681 Y89.381 E.16671
G1 X59.558 Y89.381 E.06279
G1 X59.558 Y80.619 E.17617
G1 X62.681 Y80.619 E.06279
G1 X62.681 Y81.03 E.00826
; WIPE_START
G1 X62.681 Y83.03 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X70.018 Y81.043 Z1.68 F18000
G1 Z1.28
G1 E.3 F1800
G1 F3600
M204 S6000
G1 X70.018 Y88.957 E.15911
G1 X67.743 Y88.957 E.04573
G1 X67.743 Y81.043 E.15911
G1 X69.958 Y81.043 E.04452
M204 S10000
G1 X70.442 Y80.619 F18000
G1 F3600
M204 S6000
G1 X70.442 Y89.381 E.17617
G1 X67.319 Y89.381 E.06279
G1 X67.319 Y80.619 E.17617
G1 X70.382 Y80.619 E.06158
M204 S250
G1 X70.776 Y80.21 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F2874.54
M204 S5000
G1 X70.851 Y80.21 E.00141
M106 S61.2
M106 S229.5
G1 F2340
G1 X70.851 Y89.79 E.17901
M106 S61.2
M106 S229.5
G1 F2600.508
G1 X70.776 Y89.79 E.00141
M106 S61.2
M106 S229.5
G1 F1800
G1 X59.224 Y89.79 E.21585
G1 F2028.795
G1 X59.149 Y89.79 E.00141
M106 S61.2
M106 S229.5
G1 F2520
G1 X59.149 Y80.21 E.17901
M106 S61.2
M106 S229.5
G1 F2789.461
G1 X59.224 Y80.21 E.00141
M106 S61.2
G1 F1800
G1 X70.716 Y80.21 E.21473
; WIPE_START
M204 S6000
G1 X70.851 Y80.21 E-.01933
G1 X70.851 Y82.074 E-.26567
; WIPE_END
G1 E-.015
M204 S10000
G1 X68.153 Y81.453 Z1.68 F18000
G1 Z1.28
G1 E.3 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.419992
G1 F4800
M204 S6000
G1 X68.153 Y88.547 E.13256
G1 X69.609 Y88.547 E.0272
G1 X69.609 Y81.453 E.13256
G1 X68.213 Y81.453 E.02608
M204 S10000
G1 X68.615 Y82.181 F18000
; LINE_WIDTH: 0.556547
G1 F4800
M204 S6000
G1 X68.615 Y88.085 E.14853
G1 X69.146 Y88.085 E.01335
G1 X69.146 Y81.915 E.15521
G1 X68.615 Y81.915 E.01335
G1 X68.615 Y82.121 E.00517
; WIPE_START
G1 X68.615 Y81.915 E-.02927
G1 X69.146 Y81.915 E-.07564
G1 X69.146 Y83.179 E-.1801
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X67.115 Y80.65 Z1.68 F18000
G1 Z1.28
G1 E.3 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.496522
G1 F2400
M204 S6000
G1 X62.885 Y80.65 E.09436
; WIPE_START
G1 X64.885 Y80.65 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X61.847 Y82.181 Z1.68 F18000
G1 Z1.28
G1 E.3 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.419992
G1 F4800
M204 S6000
G1 X61.847 Y81.453 E.0136
G1 X60.391 Y81.453 E.02721
G1 X60.391 Y88.547 E.13256
M73 P51 R9
G1 X61.847 Y88.547 E.02721
G1 X61.847 Y82.241 E.11784
M204 S10000
G1 X61.385 Y82.181 F18000
; LINE_WIDTH: 0.556612
G1 F4800
M204 S6000
G1 X61.385 Y81.915 E.00668
G1 X60.854 Y81.915 E.01336
G1 X60.854 Y88.085 E.15523
G1 X61.385 Y88.085 E.01336
G1 X61.385 Y82.241 E.14704
; WIPE_START
G1 X61.385 Y84.241 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X62.885 Y89.35 Z1.68 F18000
G1 Z1.28
G1 E.3 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.496522
G1 F2400
M204 S6000
G1 X67.115 Y89.35 E.09436
; CHANGE_LAYER
; Z_HEIGHT: 1.4
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F2400
G1 X65.115 Y89.35 E-.285
; WIPE_END
G1 E-.015 F1800
; stop printing object, unique label id: 8
M625
; layer num/total_layer_count: 11/57
; update layer progress
M73 L11
M991 S0 P10 ;notify layer change
; OBJECT_ID: 16
; start printing object, unique label id: 16
M624 BAAAAAAAAAA=
M204 S10000
G17
G3 Z1.68 I.101 J1.213 P1  F18000
G1 X111.943 Y85.457 Z1.68
G1 Z1.4
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F3600
M204 S6000
G1 X111.943 Y84.543 E.01836
G1 X120.057 Y84.543 E.16313
G1 X120.057 Y85.457 E.01836
G1 X112.003 Y85.457 E.16193
; WIPE_START
G1 X111.943 Y84.543 E-.13039
G1 X113.028 Y84.543 E-.15461
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X109.69 Y85.281 Z1.8 F18000
G1 Z1.4
G1 E.3 F1800
G1 F3600
M204 S6000
G1 X109.519 Y85.281 E.00343
G1 X109.519 Y84.719 E.01129
G1 X111.519 Y84.719 E.04021
G1 X111.519 Y84.119 E.01206
G1 X120.481 Y84.119 E.18019
G1 X120.481 Y85.881 E.03542
G1 X111.519 Y85.881 E.18019
G1 X111.519 Y85.281 E.01206
G1 X109.75 Y85.281 E.03557
; WIPE_START
G1 X109.519 Y85.281 E-.03288
G1 X109.519 Y84.719 E-.08002
G1 X110.727 Y84.719 E-.1721
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X109.69 Y86.29 Z1.8 F18000
G1 Z1.4
G1 E.3 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
M204 S5000
G1 X109.111 Y86.286 E.01081
G1 X109.115 Y83.711 E.04811
G1 X109.69 Y83.71 E.01074
G1 X109.69 Y84.31 E.01121
G1 X111.11 Y84.31 E.02653
G1 X111.11 Y83.71 E.01121
G1 X120.11 Y83.71 E.16817
G1 X120.113 Y81.713 E.03732
G1 X120.886 Y81.714 E.01445
G1 X120.884 Y88.289 E.12287
G1 X120.114 Y88.288 E.01439
G1 X120.11 Y86.29 E.03734
G1 X111.11 Y86.29 E.16817
G1 X111.11 Y85.69 E.01121
G1 X109.69 Y85.69 E.02653
G1 X109.69 Y86.23 E.01008
; WIPE_START
M204 S6000
G1 X109.111 Y86.286 E-.08286
G1 X109.113 Y84.867 E-.20214
; WIPE_END
G1 E-.015
M204 S10000
G17
G3 Z1.8 I1.217 J0 P1  F18000
; stop printing object, unique label id: 16
M625
; object ids of layer 11 start: 8,12,16
M624 BwAAAAAAAAA=
;===================== date: 20250206 =====================

; don't support timelapse gcode in spiral_mode and by object sequence for I3 structure printer
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
G92 E0
G1 Z1.8
G1 X0 Y85.0002 ; move to safe pos
G1 X-13.0 F3000 ; move to safe pos
M400
M1004 S5 P1  ; external shutter
M400 P300
M971 S11 C11 O0
G92 E0
G1 X0 F18000
M623

; SKIPTYPE: head_wrap_detect
M622.1 S1
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




; object ids of this layer11 end: 8,12,16
M625
; start printing object, unique label id: 16
M624 BAAAAAAAAAA=
G1 X109.4 Y84.515
G1 Z1.4
G1 E.3 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.196407
G1 F2400
M204 S6000
G1 X109.4 Y83.915 E.00485
; WIPE_START
G1 X109.4 Y84.515 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X109.4 Y86.085 Z1.8 F18000
G1 Z1.4
G1 E.3 F1800
; LINE_WIDTH: 0.196487
G1 F2400
M204 S6000
G1 X109.4 Y85.485 E.00485
M204 S10000
G1 X109.731 Y85 F18000
; LINE_WIDTH: 0.163052
G1 F2400
M204 S6000
G1 X111.731 Y85 E.01301
M204 S10000
G1 X112.156 Y85 F18000
; LINE_WIDTH: 0.514572
G1 F2400
M204 S6000
G1 X119.844 Y85 E.17813
; WIPE_START
G1 X117.844 Y85 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X120.5 Y86.085 Z1.8 F18000
G1 Z1.4
G1 E.3 F1800
; LINE_WIDTH: 0.396522
G1 F2400
M204 S6000
G1 X120.5 Y88.085 E.03514
; WIPE_START
G1 X120.5 Y86.085 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X120.5 Y83.915 Z1.8 F18000
G1 Z1.4
G1 E.3 F1800
G1 F2400
M204 S6000
G1 X120.5 Y81.917 E.0351
; OBJECT_ID: 12
; WIPE_START
G1 X120.5 Y83.915 E-.285
; WIPE_END
G1 E-.015 F1800
; stop printing object, unique label id: 16
M625
; start printing object, unique label id: 12
M624 AgAAAAAAAAA=
M204 S10000
G1 X112.92 Y84.81 Z1.8 F18000
G1 X88.09 Y87.743 Z1.8
G1 Z1.4
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F3600
M204 S6000
G1 X87.257 Y87.743 E.01676
G1 X87.257 Y82.257 E.11033
G1 X92.743 Y82.257 E.11033
G1 X92.743 Y87.743 E.11033
G1 X88.15 Y87.743 E.09236
M204 S10000
G1 X88.09 Y87.319 F18000
G1 F3600
M204 S6000
G1 X87.681 Y87.319 E.00823
G1 X87.681 Y82.681 E.09327
G1 X92.319 Y82.681 E.09327
G1 X92.319 Y87.319 E.09327
G1 X88.15 Y87.319 E.08383
M204 S250
G1 X88.09 Y86.91 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1800
M204 S5000
G1 X88.09 Y83.09 E.07138
G1 X91.91 Y83.09 E.07138
G1 X91.91 Y86.91 E.07138
G1 X88.15 Y86.91 E.07026
; WIPE_START
M204 S6000
G1 X88.119 Y84.91 E-.285
; WIPE_END
G1 E-.015
M204 S10000
G1 X86.943 Y80.645 Z1.8 F18000
G1 Z1.4
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F3600
M204 S6000
G1 X93.056 Y80.652 E.12291
G1 X93.057 Y89.357 E.17502
G1 X86.943 Y89.357 E.12292
G1 X86.943 Y80.705 E.17397
M204 S10000
G1 X86.519 Y80.22 F18000
G1 F3600
M204 S6000
G1 X93.48 Y80.229 E.13997
G1 X93.481 Y89.781 E.19207
G1 X86.519 Y89.781 E.13998
G1 X86.519 Y80.28 E.19104
M204 S250
G1 X86.262 Y79.847 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1800
M204 S5000
G1 X86.397 Y79.81 E.00262
G1 X93.656 Y79.82 E.13563
G1 X93.761 Y79.863 E.00213
G1 X93.83 Y79.93 E.0018
G1 X93.89 Y80.095 E.00327
G1 X93.89 Y89.883 E.18291
G1 X93.873 Y89.989 E.00199
G1 X93.831 Y90.073 E.00176
G1 X93.731 Y90.157 E.00244
G1 X93.588 Y90.19 E.00275
G1 X86.417 Y90.19 E.134
G1 X86.311 Y90.173 E.00199
G1 X86.227 Y90.131 E.00176
G1 X86.143 Y90.031 E.00244
G1 X86.11 Y89.888 E.00275
G1 X86.11 Y80.117 E.18258
G1 X86.127 Y80.011 E.00199
G1 X86.169 Y79.927 E.00176
G1 X86.216 Y79.886 E.00117
; WIPE_START
M204 S6000
G1 X86.397 Y79.81 E-.02788
G1 X88.201 Y79.813 E-.25713
; WIPE_END
G1 E-.015
M204 S10000
G1 X92.647 Y81.847 Z1.8 F18000
G1 Z1.4
G1 E.3 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.419992
G1 F4800
M204 S6000
G1 X92.647 Y81.061 E.01469
G1 X87.353 Y81.054 E.09892
G1 X87.353 Y81.847 E.01482
G1 X92.587 Y81.847 E.0978
; WIPE_START
G1 X90.587 Y81.847 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X87.749 Y81.451 Z1.8 F18000
G1 Z1.4
G1 E.3 F1800
; LINE_WIDTH: 0.421122
G1 F4800
M204 S6000
G1 X92.194 Y81.454 E.08329
; WIPE_START
G1 X90.194 Y81.453 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X92.647 Y88.153 Z1.8 F18000
G1 Z1.4
G1 E.3 F1800
; LINE_WIDTH: 0.419992
G1 F4800
M204 S6000
G1 X87.353 Y88.153 E.09893
G1 X87.353 Y88.947 E.01485
G1 X92.647 Y88.947 E.09893
G1 X92.647 Y88.213 E.01373
; WIPE_START
G1 X92.647 Y88.947 E-.10468
M73 P52 R9
G1 X91.382 Y88.947 E-.18032
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X87.75 Y88.55 Z1.8 F18000
G1 Z1.4
G1 E.3 F1800
; LINE_WIDTH: 0.426072
G1 F4800
M204 S6000
G1 X92.19 Y88.55 E.08424
; OBJECT_ID: 8
; WIPE_START
G1 X90.19 Y88.55 E-.285
; WIPE_END
G1 E-.015 F1800
; stop printing object, unique label id: 12
M625
; start printing object, unique label id: 8
M624 AQAAAAAAAAA=
M204 S10000
G1 X82.831 Y86.524 Z1.8 F18000
G1 X63.09 Y81.09 Z1.8
G1 Z1.4
G1 E.3 F1800
M106 S229.5
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
G1 X62.257 Y88.957 E.15818
G1 X59.876 Y88.957 E.04786
G1 X59.876 Y81.043 E.15911
G1 X62.243 Y81.043 E.04759
M204 S10000
G1 X62.681 Y81.09 F18000
G1 F3600
M204 S6000
G1 X62.681 Y89.381 E.16671
G1 X59.452 Y89.381 E.06492
G1 X59.452 Y80.619 E.17617
G1 X62.681 Y80.619 E.06492
G1 X62.681 Y81.03 E.00826
; WIPE_START
G1 X62.681 Y83.03 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X70.055 Y81.062 Z1.8 F18000
G1 X70.124 Y81.043 Z1.8
G1 Z1.4
G1 E.3 F1800
G1 F3600
M204 S6000
G1 X70.124 Y88.957 E.15911
G1 X67.743 Y88.957 E.04786
G1 X67.743 Y81.043 E.15911
G1 X70.064 Y81.043 E.04666
M204 S10000
G1 X70.548 Y80.619 F18000
G1 F3600
M204 S6000
G1 X70.548 Y89.381 E.17617
G1 X67.319 Y89.381 E.06492
G1 X67.319 Y80.619 E.17617
G1 X70.488 Y80.619 E.06372
M204 S250
G1 X70.892 Y80.21 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3240
M204 S5000
G1 X70.957 Y80.21 E.00122
G1 F2700
G1 X70.957 Y89.79 E.17901
M106 S61.2
M106 S229.5
G1 F2201.49
G1 X70.892 Y89.79 E.00121
G1 F1800
G1 X59.108 Y89.79 E.2202
G1 F2201.295
G1 X59.043 Y89.79 E.00121
G1 F2700
G1 X59.043 Y80.21 E.17901
M106 S61.2
G1 F2201.295
G1 X59.108 Y80.21 E.00121
G1 F1800
G1 X70.832 Y80.21 E.21908
; WIPE_START
M204 S6000
G1 X70.957 Y80.21 E-.01784
G1 X70.957 Y82.085 E-.26716
; WIPE_END
G1 E-.015
M204 S10000
G1 X67.115 Y80.65 Z1.8 F18000
G1 Z1.4
G1 E.3 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.496522
G1 F2400
M204 S6000
G1 X62.885 Y80.65 E.09436
; WIPE_START
G1 X64.885 Y80.65 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X61.276 Y87.375 Z1.8 F18000
G1 X61.066 Y87.766 Z1.8
G1 Z1.4
G1 E.3 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.404812
G1 F4800
M204 S6000
G1 X61.066 Y82.294 E.09832
M204 S10000
G1 X61.453 Y82.234 F18000
; LINE_WIDTH: 0.419992
G1 F4800
M204 S6000
G1 X61.453 Y81.847 E.00722
G1 X60.68 Y81.847 E.01445
G1 X60.68 Y88.153 E.11783
G1 X61.453 Y88.153 E.01445
G1 X61.453 Y82.294 E.10949
M204 S10000
G1 X61.847 Y82.234 F18000
G1 F4800
M204 S6000
G1 X61.847 Y81.453 E.01459
G1 X60.285 Y81.453 E.02918
G1 X60.285 Y88.547 E.13256
G1 X61.847 Y88.547 E.02918
G1 X61.847 Y82.294 E.11685
; WIPE_START
G1 X61.847 Y84.294 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X62.885 Y89.35 Z1.8 F18000
G1 Z1.4
G1 E.3 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.496522
G1 F2400
M204 S6000
G1 X67.115 Y89.35 E.09436
; WIPE_START
G1 X65.115 Y89.35 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X68.153 Y88.547 Z1.8 F18000
G1 Z1.4
G1 E.3 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.419992
G1 F4800
M204 S6000
G1 X69.714 Y88.547 E.02918
G1 X69.715 Y81.453 E.13256
G1 X68.153 Y81.453 E.02918
G1 X68.153 Y88.487 E.13144
M204 S10000
G1 X68.547 Y88.153 F18000
G1 F4800
M204 S6000
G1 X69.32 Y88.153 E.01445
G1 X69.32 Y81.847 E.11783
G1 X68.547 Y81.847 E.01445
G1 X68.547 Y88.093 E.11671
M204 S10000
G1 X68.934 Y87.766 F18000
; LINE_WIDTH: 0.404872
G1 F4800
M204 S6000
G1 X68.934 Y82.294 E.09834
; CHANGE_LAYER
; Z_HEIGHT: 1.52
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F4800
G1 X68.934 Y84.294 E-.285
; WIPE_END
G1 E-.015 F1800
; stop printing object, unique label id: 8
M625
; layer num/total_layer_count: 12/57
; update layer progress
M73 L12
M991 S0 P11 ;notify layer change
; OBJECT_ID: 16
; start printing object, unique label id: 16
M624 BAAAAAAAAAA=
M204 S10000
G17
G3 Z1.8 I-.033 J1.217 P1  F18000
G1 X111.943 Y85.457 Z1.8
G1 Z1.52
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F3600
M204 S6000
G1 X111.943 Y84.543 E.01836
G1 X120.057 Y84.543 E.16313
G1 X120.057 Y85.457 E.01836
G1 X112.003 Y85.457 E.16193
; WIPE_START
G1 X111.943 Y84.543 E-.13039
G1 X113.028 Y84.543 E-.15461
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X109.69 Y85.281 Z1.92 F18000
G1 Z1.52
G1 E.3 F1800
G1 F3600
M204 S6000
G1 X109.519 Y85.281 E.00343
G1 X109.519 Y84.719 E.01129
G1 X111.519 Y84.719 E.04021
G1 X111.519 Y84.119 E.01206
G1 X120.481 Y84.119 E.18019
G1 X120.481 Y85.881 E.03542
G1 X111.519 Y85.881 E.18019
G1 X111.519 Y85.281 E.01206
G1 X109.75 Y85.281 E.03557
; WIPE_START
G1 X109.519 Y85.281 E-.03288
G1 X109.519 Y84.719 E-.08002
G1 X110.727 Y84.719 E-.1721
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X109.69 Y86.29 Z1.92 F18000
G1 Z1.52
G1 E.3 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
M204 S5000
G1 X109.111 Y86.286 E.01081
G1 X109.115 Y83.711 E.04812
G1 X109.69 Y83.71 E.01074
G1 X109.69 Y84.31 E.01121
G1 X111.11 Y84.31 E.02653
G1 X111.11 Y83.71 E.01121
G1 X120.11 Y83.71 E.16817
G1 X120.113 Y81.713 E.03732
G1 X120.886 Y81.714 E.01444
G1 X120.884 Y88.289 E.12287
G1 X120.114 Y88.288 E.01439
G1 X120.11 Y86.29 E.03733
G1 X111.11 Y86.29 E.16817
G1 X111.11 Y85.69 E.01121
G1 X109.69 Y85.69 E.02653
G1 X109.69 Y86.23 E.01008
; WIPE_START
M204 S6000
G1 X109.111 Y86.286 E-.08285
G1 X109.114 Y84.868 E-.20215
; WIPE_END
G1 E-.015
M204 S10000
G17
G3 Z1.92 I1.217 J0 P1  F18000
; stop printing object, unique label id: 16
M625
; object ids of layer 12 start: 8,12,16
M624 BwAAAAAAAAA=
;===================== date: 20250206 =====================

; don't support timelapse gcode in spiral_mode and by object sequence for I3 structure printer
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
G92 E0
G1 Z1.92
G1 X0 Y85.0002 ; move to safe pos
G1 X-13.0 F3000 ; move to safe pos
M400
M1004 S5 P1  ; external shutter
M400 P300
M971 S11 C11 O0
G92 E0
G1 X0 F18000
M623

; SKIPTYPE: head_wrap_detect
M622.1 S1
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




; object ids of this layer12 end: 8,12,16
M625
; start printing object, unique label id: 16
M624 BAAAAAAAAAA=
G1 X109.4 Y84.515
G1 Z1.52
G1 E.3 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.196407
G1 F2400
M204 S6000
G1 X109.4 Y83.915 E.00485
; WIPE_START
G1 X109.4 Y84.515 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X109.4 Y86.085 Z1.92 F18000
G1 Z1.52
G1 E.3 F1800
; LINE_WIDTH: 0.196487
G1 F2400
M204 S6000
G1 X109.4 Y85.485 E.00485
M204 S10000
G1 X109.731 Y85 F18000
; LINE_WIDTH: 0.163052
G1 F2400
M204 S6000
G1 X111.731 Y85 E.01301
M204 S10000
G1 X112.156 Y85 F18000
; LINE_WIDTH: 0.514572
G1 F2400
M204 S6000
G1 X119.844 Y85 E.17813
; WIPE_START
G1 X117.844 Y85 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X120.5 Y86.085 Z1.92 F18000
G1 Z1.52
G1 E.3 F1800
; LINE_WIDTH: 0.396522
G1 F2400
M204 S6000
G1 X120.5 Y88.085 E.03514
; WIPE_START
G1 X120.5 Y86.085 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X120.5 Y83.915 Z1.92 F18000
G1 Z1.52
G1 E.3 F1800
G1 F2400
M204 S6000
G1 X120.5 Y81.917 E.0351
; OBJECT_ID: 12
; WIPE_START
G1 X120.5 Y83.915 E-.285
; WIPE_END
G1 E-.015 F1800
; stop printing object, unique label id: 16
M625
; start printing object, unique label id: 12
M624 AgAAAAAAAAA=
M204 S10000
G1 X112.92 Y84.81 Z1.92 F18000
G1 X88.09 Y87.743 Z1.92
G1 Z1.52
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F3600
M204 S6000
G1 X87.257 Y87.743 E.01676
G1 X87.257 Y82.257 E.11033
G1 X92.743 Y82.257 E.11033
G1 X92.743 Y87.743 E.11033
G1 X88.15 Y87.743 E.09236
M204 S10000
G1 X88.09 Y87.319 F18000
G1 F3600
M204 S6000
G1 X87.681 Y87.319 E.00823
G1 X87.681 Y82.681 E.09327
G1 X92.319 Y82.681 E.09327
M73 P53 R9
G1 X92.319 Y87.319 E.09327
G1 X88.15 Y87.319 E.08383
M204 S250
G1 X88.09 Y86.91 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1800
M204 S5000
G1 X88.09 Y83.09 E.07138
G1 X91.91 Y83.09 E.07138
G1 X91.91 Y86.91 E.07138
G1 X88.15 Y86.91 E.07026
; WIPE_START
M204 S6000
G1 X88.119 Y84.91 E-.285
; WIPE_END
G1 E-.015
M204 S10000
G1 X86.943 Y80.645 Z1.92 F18000
G1 Z1.52
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F3600
M204 S6000
G1 X93.056 Y80.652 E.12291
G1 X93.057 Y89.357 E.17502
G1 X86.943 Y89.357 E.12292
G1 X86.943 Y80.705 E.17397
M204 S10000
G1 X86.519 Y80.22 F18000
G1 F3600
M204 S6000
G1 X93.48 Y80.229 E.13997
G1 X93.481 Y89.781 E.19207
G1 X86.519 Y89.781 E.13998
G1 X86.519 Y80.28 E.19104
M204 S250
G1 X86.262 Y79.846 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1800
M204 S5000
G1 X86.397 Y79.81 E.00261
G1 X93.656 Y79.82 E.13564
G1 X93.796 Y79.889 E.00293
G1 X93.865 Y79.992 E.00232
G1 X93.89 Y80.103 E.00212
G1 X93.89 Y89.883 E.18275
G1 X93.873 Y89.989 E.00199
G1 X93.831 Y90.073 E.00176
G1 X93.731 Y90.157 E.00244
G1 X93.588 Y90.19 E.00275
G1 X86.417 Y90.19 E.134
G1 X86.311 Y90.173 E.00199
G1 X86.227 Y90.131 E.00176
G1 X86.143 Y90.031 E.00244
G1 X86.11 Y89.888 E.00275
G1 X86.11 Y80.117 E.18258
G1 X86.127 Y80.011 E.00199
G1 X86.169 Y79.927 E.00176
G1 X86.217 Y79.886 E.00118
; WIPE_START
M204 S6000
G1 X86.397 Y79.81 E-.02781
G1 X88.202 Y79.813 E-.25719
; WIPE_END
G1 E-.015
M204 S10000
G1 X92.647 Y81.847 Z1.92 F18000
G1 Z1.52
G1 E.3 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.419992
G1 F4800
M204 S6000
G1 X92.647 Y81.061 E.01469
G1 X87.353 Y81.054 E.09892
G1 X87.353 Y81.847 E.01482
G1 X92.587 Y81.847 E.0978
; WIPE_START
G1 X90.587 Y81.847 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X87.749 Y81.451 Z1.92 F18000
G1 Z1.52
G1 E.3 F1800
; LINE_WIDTH: 0.421112
G1 F4800
M204 S6000
G1 X92.194 Y81.454 E.08329
; WIPE_START
G1 X90.194 Y81.453 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X92.647 Y88.153 Z1.92 F18000
G1 Z1.52
G1 E.3 F1800
; LINE_WIDTH: 0.419992
G1 F4800
M204 S6000
G1 X87.353 Y88.153 E.09893
G1 X87.353 Y88.947 E.01485
G1 X92.647 Y88.947 E.09893
G1 X92.647 Y88.213 E.01373
; WIPE_START
G1 X92.647 Y88.947 E-.10468
G1 X91.382 Y88.947 E-.18032
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X87.75 Y88.55 Z1.92 F18000
G1 Z1.52
G1 E.3 F1800
; LINE_WIDTH: 0.426072
G1 F4800
M204 S6000
G1 X92.19 Y88.55 E.08424
; OBJECT_ID: 8
; WIPE_START
G1 X90.19 Y88.55 E-.285
; WIPE_END
G1 E-.015 F1800
; stop printing object, unique label id: 12
M625
; start printing object, unique label id: 8
M624 AQAAAAAAAAA=
M204 S10000
G1 X82.831 Y86.524 Z1.92 F18000
G1 X63.09 Y81.09 Z1.92
G1 Z1.52
G1 E.3 F1800
M106 S229.5
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
G1 X62.257 Y88.957 E.15818
G1 X59.78 Y88.957 E.0498
G1 X59.78 Y81.043 E.15911
G1 X62.243 Y81.043 E.04953
M204 S10000
G1 X62.681 Y81.09 F18000
G1 F3600
M204 S6000
G1 X62.681 Y89.381 E.16671
G1 X59.355 Y89.381 E.06687
G1 X59.355 Y80.619 E.17617
G1 X62.681 Y80.619 E.06687
G1 X62.681 Y81.03 E.00826
; WIPE_START
G1 X62.681 Y83.03 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X70.061 Y81.085 Z1.92 F18000
G1 X70.22 Y81.043 Z1.92
G1 Z1.52
G1 E.3 F1800
G1 F3600
M204 S6000
G1 X70.22 Y88.957 E.15911
G1 X67.743 Y88.957 E.04981
G1 X67.743 Y81.043 E.15911
G1 X70.16 Y81.043 E.0486
M204 S10000
G1 X70.645 Y80.619 F18000
G1 F3600
M204 S6000
G1 X70.645 Y89.381 E.17617
G1 X67.319 Y89.381 E.06687
G1 X67.319 Y80.619 E.17617
G1 X70.585 Y80.619 E.06566
M204 S250
G1 X70.998 Y80.21 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3060
M204 S5000
G1 X71.054 Y80.21 E.00104
G1 X71.054 Y89.39 E.17153
M106 S61.2
M106 S229.5
G1 X71.054 Y89.79 E.00747
M106 S61.2
M106 S229.5
G1 F2142.596
G1 X70.998 Y89.79 E.00104
G1 F1800
G1 X59.002 Y89.79 E.22416
G1 F2142.019
G1 X58.946 Y89.79 E.00104
G1 F3060
G1 X58.946 Y89.39 E.00747
M106 S61.2
M106 S229.5
G1 X58.946 Y80.61 E.16406
M106 S61.2
M106 S229.5
G1 X58.946 Y80.21 E.00747
M106 S61.2
G1 F2142.019
G1 X59.002 Y80.21 E.00104
G1 F1800
G1 X70.938 Y80.21 E.22304
; WIPE_START
M204 S6000
G1 X71.054 Y80.21 E-.01646
G1 X71.054 Y82.094 E-.26854
; WIPE_END
G1 E-.015
M204 S10000
G1 X67.115 Y80.65 Z1.92 F18000
G1 Z1.52
G1 E.3 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.496522
G1 F2400
M204 S6000
G1 X62.885 Y80.65 E.09436
; WIPE_START
G1 X64.885 Y80.65 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X61.222 Y87.346 Z1.92 F18000
G1 X61.018 Y87.718 Z1.92
G1 Z1.52
G1 E.3 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.501452
G1 F4800
M204 S6000
G1 X61.018 Y82.342 E.12121
M204 S10000
G1 X61.453 Y82.282 F18000
; LINE_WIDTH: 0.419992
G1 F4800
M204 S6000
G1 X61.453 Y81.847 E.00813
G1 X60.583 Y81.847 E.01626
G1 X60.583 Y88.153 E.11783
G1 X61.453 Y88.153 E.01626
G1 X61.453 Y82.342 E.10858
M204 S10000
G1 X61.847 Y82.282 F18000
G1 F4800
M204 S6000
G1 X61.847 Y81.453 E.01549
G1 X60.189 Y81.453 E.03099
G1 X60.189 Y88.547 E.13256
G1 X61.847 Y88.547 E.03099
G1 X61.847 Y82.342 E.11595
; WIPE_START
G1 X61.847 Y84.342 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X62.885 Y89.35 Z1.92 F18000
G1 Z1.52
G1 E.3 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.496522
G1 F2400
M204 S6000
G1 X67.115 Y89.35 E.09436
; WIPE_START
G1 X65.115 Y89.35 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X68.982 Y87.718 Z1.92 F18000
G1 Z1.52
G1 E.3 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.501492
G1 F4800
M204 S6000
G1 X68.982 Y82.342 E.12122
; WIPE_START
G1 X68.982 Y84.342 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X68.547 Y88.153 Z1.92 F18000
G1 Z1.52
G1 E.3 F1800
; LINE_WIDTH: 0.419992
G1 F4800
M204 S6000
G1 X69.417 Y88.153 E.01626
G1 X69.417 Y81.847 E.11783
G1 X68.547 Y81.847 E.01626
G1 X68.547 Y88.093 E.11671
M204 S10000
G1 X68.153 Y88.547 F18000
G1 F4800
M204 S6000
G1 X69.811 Y88.547 E.03099
G1 X69.811 Y81.453 E.13256
G1 X68.153 Y81.453 E.03099
G1 X68.153 Y88.487 E.13144
; CHANGE_LAYER
; Z_HEIGHT: 1.64
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F4800
M73 P54 R9
G1 X68.153 Y86.487 E-.285
; WIPE_END
G1 E-.015 F1800
; stop printing object, unique label id: 8
M625
; layer num/total_layer_count: 13/57
; update layer progress
M73 L13
M991 S0 P12 ;notify layer change
; OBJECT_ID: 16
; start printing object, unique label id: 16
M624 BAAAAAAAAAA=
M204 S10000
G17
G3 Z1.92 I.029 J1.217 P1  F18000
G1 X111.943 Y85.457 Z1.92
G1 Z1.64
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F3600
M204 S6000
G1 X111.943 Y84.543 E.01836
G1 X120.057 Y84.543 E.16313
G1 X120.057 Y85.457 E.01836
G1 X112.003 Y85.457 E.16193
; WIPE_START
G1 X111.943 Y84.543 E-.13039
G1 X113.028 Y84.543 E-.15461
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X109.69 Y85.281 Z2.04 F18000
G1 Z1.64
G1 E.3 F1800
G1 F3600
M204 S6000
G1 X109.519 Y85.281 E.00343
G1 X109.519 Y84.719 E.01129
G1 X111.519 Y84.719 E.04021
G1 X111.519 Y84.119 E.01206
G1 X120.481 Y84.119 E.18019
G1 X120.481 Y85.881 E.03542
G1 X111.519 Y85.881 E.18019
G1 X111.519 Y85.281 E.01206
G1 X109.75 Y85.281 E.03557
; WIPE_START
G1 X109.519 Y85.281 E-.03288
G1 X109.519 Y84.719 E-.08002
G1 X110.727 Y84.719 E-.1721
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X109.69 Y86.29 Z2.04 F18000
G1 Z1.64
G1 E.3 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
M204 S5000
G1 X109.111 Y86.286 E.01081
G1 X109.115 Y83.711 E.04812
G1 X109.69 Y83.71 E.01074
G1 X109.69 Y84.31 E.01121
G1 X111.11 Y84.31 E.02653
G1 X111.11 Y83.71 E.01121
G1 X120.11 Y83.71 E.16817
G1 X120.113 Y81.712 E.03733
G1 X120.886 Y81.714 E.01445
G1 X120.884 Y88.289 E.12287
G1 X120.114 Y88.288 E.01439
G1 X120.11 Y86.29 E.03734
G1 X111.11 Y86.29 E.16817
G1 X111.11 Y85.69 E.01121
G1 X109.69 Y85.69 E.02653
G1 X109.69 Y86.23 E.01008
; WIPE_START
M204 S6000
G1 X109.111 Y86.286 E-.08285
G1 X109.114 Y84.868 E-.20215
; WIPE_END
G1 E-.015
M204 S10000
G17
G3 Z2.04 I1.217 J0 P1  F18000
; stop printing object, unique label id: 16
M625
; object ids of layer 13 start: 8,12,16
M624 BwAAAAAAAAA=
;===================== date: 20250206 =====================

; don't support timelapse gcode in spiral_mode and by object sequence for I3 structure printer
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
G92 E0
G1 Z2.04
G1 X0 Y85.0002 ; move to safe pos
G1 X-13.0 F3000 ; move to safe pos
M400
M1004 S5 P1  ; external shutter
M400 P300
M971 S11 C11 O0
G92 E0
G1 X0 F18000
M623

; SKIPTYPE: head_wrap_detect
M622.1 S1
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




; object ids of this layer13 end: 8,12,16
M625
; start printing object, unique label id: 16
M624 BAAAAAAAAAA=
G1 X109.4 Y84.515
G1 Z1.64
G1 E.3 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.196407
G1 F2400
M204 S6000
G1 X109.4 Y83.915 E.00485
; WIPE_START
G1 X109.4 Y84.515 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X109.4 Y86.085 Z2.04 F18000
G1 Z1.64
G1 E.3 F1800
; LINE_WIDTH: 0.196487
G1 F2400
M204 S6000
G1 X109.4 Y85.485 E.00485
M204 S10000
G1 X109.731 Y85 F18000
; LINE_WIDTH: 0.163052
G1 F2400
M204 S6000
G1 X111.731 Y85 E.01301
M204 S10000
G1 X112.156 Y85 F18000
; LINE_WIDTH: 0.514572
G1 F2400
M204 S6000
G1 X119.844 Y85 E.17813
; WIPE_START
G1 X117.844 Y85 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X120.5 Y86.085 Z2.04 F18000
G1 Z1.64
G1 E.3 F1800
; LINE_WIDTH: 0.396522
G1 F2400
M204 S6000
G1 X120.5 Y88.085 E.03514
; WIPE_START
G1 X120.5 Y86.085 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X120.5 Y83.915 Z2.04 F18000
G1 Z1.64
G1 E.3 F1800
G1 F2400
M204 S6000
G1 X120.5 Y81.917 E.0351
; OBJECT_ID: 12
; WIPE_START
G1 X120.5 Y83.915 E-.285
; WIPE_END
G1 E-.015 F1800
; stop printing object, unique label id: 16
M625
; start printing object, unique label id: 12
M624 AgAAAAAAAAA=
M204 S10000
G1 X112.92 Y84.81 Z2.04 F18000
G1 X88.09 Y87.743 Z2.04
G1 Z1.64
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F3600
M204 S6000
G1 X87.257 Y87.743 E.01676
G1 X87.257 Y82.257 E.11033
G1 X92.743 Y82.257 E.11033
G1 X92.743 Y87.743 E.11033
G1 X88.15 Y87.743 E.09236
M204 S10000
G1 X88.09 Y87.319 F18000
G1 F3600
M204 S6000
G1 X87.681 Y87.319 E.00823
G1 X87.681 Y82.681 E.09327
G1 X92.319 Y82.681 E.09327
G1 X92.319 Y87.319 E.09327
G1 X88.15 Y87.319 E.08383
M204 S250
G1 X88.09 Y86.91 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1800
M204 S5000
G1 X88.09 Y83.09 E.07138
G1 X91.91 Y83.09 E.07138
G1 X91.91 Y86.91 E.07138
G1 X88.15 Y86.91 E.07026
; WIPE_START
M204 S6000
G1 X88.119 Y84.91 E-.285
; WIPE_END
G1 E-.015
M204 S10000
G1 X86.943 Y80.645 Z2.04 F18000
G1 Z1.64
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F3600
M204 S6000
G1 X93.056 Y80.652 E.12291
G1 X93.057 Y89.357 E.17502
G1 X86.943 Y89.357 E.12292
G1 X86.943 Y80.705 E.17397
M204 S10000
G1 X86.519 Y80.22 F18000
G1 F3600
M204 S6000
G1 X93.48 Y80.229 E.13997
G1 X93.481 Y89.781 E.19207
G1 X86.519 Y89.781 E.13998
G1 X86.519 Y80.28 E.19104
M204 S250
G1 X86.269 Y79.844 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1800
M204 S5000
G1 X86.397 Y79.81 E.00248
G1 X93.656 Y79.82 E.13564
G1 X93.797 Y79.89 E.00295
G1 X93.863 Y79.987 E.00219
G1 X93.89 Y80.104 E.00225
G1 X93.89 Y89.883 E.18273
G1 X93.873 Y89.989 E.00199
G1 X93.831 Y90.073 E.00176
G1 X93.731 Y90.157 E.00244
G1 X93.588 Y90.19 E.00275
G1 X86.417 Y90.19 E.134
G1 X86.311 Y90.173 E.00199
G1 X86.227 Y90.131 E.00176
G1 X86.143 Y90.031 E.00244
G1 X86.11 Y89.888 E.00275
G1 X86.11 Y80.117 E.18258
G1 X86.127 Y80.011 E.002
G1 X86.165 Y79.937 E.00156
G1 X86.224 Y79.884 E.00148
; WIPE_START
M204 S6000
G1 X86.397 Y79.81 E-.0268
G1 X88.209 Y79.813 E-.2582
; WIPE_END
G1 E-.015
M204 S10000
G1 X92.647 Y81.847 Z2.04 F18000
G1 Z1.64
G1 E.3 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.419992
G1 F4800
M204 S6000
G1 X92.647 Y81.061 E.01469
G1 X87.353 Y81.054 E.09892
G1 X87.353 Y81.847 E.01482
G1 X92.587 Y81.847 E.0978
; WIPE_START
G1 X90.587 Y81.847 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X87.749 Y81.451 Z2.04 F18000
G1 Z1.64
G1 E.3 F1800
; LINE_WIDTH: 0.421112
G1 F4800
M204 S6000
G1 X92.194 Y81.454 E.08329
; WIPE_START
G1 X90.194 Y81.453 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X92.647 Y88.153 Z2.04 F18000
G1 Z1.64
G1 E.3 F1800
; LINE_WIDTH: 0.419992
G1 F4800
M204 S6000
G1 X87.353 Y88.153 E.09893
G1 X87.353 Y88.947 E.01485
G1 X92.647 Y88.947 E.09893
G1 X92.647 Y88.213 E.01373
; WIPE_START
G1 X92.647 Y88.947 E-.10468
G1 X91.382 Y88.947 E-.18032
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X87.75 Y88.55 Z2.04 F18000
G1 Z1.64
G1 E.3 F1800
; LINE_WIDTH: 0.426072
G1 F4800
M204 S6000
G1 X92.19 Y88.55 E.08424
; OBJECT_ID: 8
; WIPE_START
G1 X90.19 Y88.55 E-.285
; WIPE_END
G1 E-.015 F1800
; stop printing object, unique label id: 12
M625
; start printing object, unique label id: 8
M624 AQAAAAAAAAA=
M204 S10000
G1 X82.831 Y86.524 Z2.04 F18000
G1 X63.09 Y81.09 Z2.04
G1 Z1.64
G1 E.3 F1800
M106 S229.5
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
G1 X62.257 Y88.957 E.15818
G1 X59.691 Y88.957 E.05159
G1 X59.691 Y81.043 E.15911
M73 P55 R9
G1 X62.243 Y81.043 E.05132
M204 S10000
G1 X62.681 Y81.09 F18000
G1 F3600
M204 S6000
G1 X62.681 Y89.381 E.16671
G1 X59.267 Y89.381 E.06865
G1 X59.267 Y80.619 E.17617
G1 X62.681 Y80.619 E.06865
G1 X62.681 Y81.03 E.00826
; WIPE_START
G1 X62.681 Y83.03 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X70.067 Y81.107 Z2.04 F18000
G1 X70.309 Y81.043 Z2.04
G1 Z1.64
G1 E.3 F1800
G1 F3600
M204 S6000
G1 X70.309 Y88.957 E.15911
G1 X67.743 Y88.957 E.05159
G1 X67.743 Y81.043 E.15911
G1 X70.249 Y81.043 E.05039
M204 S10000
G1 X70.734 Y80.619 F18000
G1 F3600
M204 S6000
G1 X70.733 Y89.381 E.17617
G1 X67.319 Y89.381 E.06865
G1 X67.319 Y80.619 E.17617
G1 X70.674 Y80.619 E.06745
M204 S250
G1 X71.095 Y80.21 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F2880
M204 S5000
G1 X71.143 Y80.21 E.00089
G1 F3420
G1 X71.143 Y89.79 E.17901
M106 S61.2
M106 S229.5
G1 F2092.163
G1 X71.095 Y89.79 E.00089
G1 F1800
G1 X58.905 Y89.79 E.22777
G1 F2091.402
G1 X58.857 Y89.79 E.00089
G1 F3420
G1 X58.857 Y89.39 E.00747
M106 S61.2
M106 S229.5
G1 X58.857 Y80.21 E.17153
M106 S61.2
G1 F2091.402
M73 P55 R8
G1 X58.905 Y80.21 E.00089
G1 F1800
G1 X71.035 Y80.21 E.22665
; WIPE_START
M204 S6000
G1 X71.143 Y80.21 E-.01537
G1 X71.143 Y82.102 E-.26963
; WIPE_END
G1 E-.015
M204 S10000
G1 X67.115 Y80.65 Z2.04 F18000
G1 Z1.64
G1 E.3 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.496522
G1 F2400
M204 S6000
G1 X62.885 Y80.65 E.09436
; WIPE_START
G1 X64.885 Y80.65 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X61.172 Y87.318 Z2.04 F18000
G1 X60.974 Y87.674 Z2.04
G1 Z1.64
G1 E.3 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.590152
G1 F4800
M204 S6000
G1 X60.974 Y82.386 E.14144
M204 S10000
G1 X61.453 Y82.326 F18000
; LINE_WIDTH: 0.419992
G1 F4800
M204 S6000
G1 X61.453 Y81.847 E.00896
G1 X60.494 Y81.847 E.01791
G1 X60.494 Y88.153 E.11783
G1 X61.453 Y88.153 E.01791
G1 X61.453 Y82.386 E.10775
M204 S10000
G1 X61.847 Y82.326 F18000
G1 F4800
M204 S6000
G1 X61.847 Y81.453 E.01632
G1 X60.1 Y81.453 E.03265
G1 X60.1 Y88.547 E.13256
G1 X61.847 Y88.547 E.03265
G1 X61.847 Y82.386 E.11512
; WIPE_START
G1 X61.847 Y84.386 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X62.885 Y89.35 Z2.04 F18000
G1 Z1.64
G1 E.3 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.496522
G1 F2400
M204 S6000
G1 X67.115 Y89.35 E.09436
; WIPE_START
G1 X65.115 Y89.35 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X69.026 Y87.674 Z2.04 F18000
G1 Z1.64
G1 E.3 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.590322
G1 F4800
M204 S6000
G1 X69.026 Y82.386 E.14148
; WIPE_START
G1 X69.026 Y84.386 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X68.547 Y88.153 Z2.04 F18000
G1 Z1.64
G1 E.3 F1800
; LINE_WIDTH: 0.419992
G1 F4800
M204 S6000
G1 X69.506 Y88.153 E.01792
G1 X69.506 Y81.847 E.11783
G1 X68.547 Y81.847 E.01792
G1 X68.547 Y88.093 E.11671
M204 S10000
G1 X68.153 Y88.547 F18000
G1 F4800
M204 S6000
G1 X69.9 Y88.547 E.03265
G1 X69.9 Y81.453 E.13256
G1 X68.153 Y81.453 E.03265
G1 X68.153 Y88.487 E.13144
; CHANGE_LAYER
; Z_HEIGHT: 1.76
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F4800
G1 X68.153 Y86.487 E-.285
; WIPE_END
G1 E-.015 F1800
; stop printing object, unique label id: 8
M625
; layer num/total_layer_count: 14/57
; update layer progress
M73 L14
M991 S0 P13 ;notify layer change
; OBJECT_ID: 16
; start printing object, unique label id: 16
M624 BAAAAAAAAAA=
M204 S10000
G17
G3 Z2.04 I.029 J1.217 P1  F18000
G1 X111.943 Y85.457 Z2.04
G1 Z1.76
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F3600
M204 S6000
G1 X111.943 Y84.543 E.01836
G1 X120.057 Y84.543 E.16313
G1 X120.057 Y85.457 E.01836
G1 X112.003 Y85.457 E.16193
; WIPE_START
G1 X111.943 Y84.543 E-.13039
G1 X113.028 Y84.543 E-.15461
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X109.69 Y85.281 Z2.16 F18000
G1 Z1.76
G1 E.3 F1800
G1 F3600
M204 S6000
G1 X109.519 Y85.281 E.00343
G1 X109.519 Y84.719 E.01129
G1 X111.519 Y84.719 E.04021
G1 X111.519 Y84.119 E.01206
G1 X120.481 Y84.119 E.18019
G1 X120.481 Y85.881 E.03542
G1 X111.519 Y85.881 E.18019
G1 X111.519 Y85.281 E.01206
G1 X109.75 Y85.281 E.03557
; WIPE_START
G1 X109.519 Y85.281 E-.03288
G1 X109.519 Y84.719 E-.08002
G1 X110.727 Y84.719 E-.1721
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X109.69 Y86.29 Z2.16 F18000
G1 Z1.76
G1 E.3 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
M204 S5000
G1 X109.111 Y86.286 E.01081
G1 X109.116 Y83.711 E.04812
G1 X109.69 Y83.71 E.01073
G1 X109.69 Y84.31 E.01121
G1 X111.11 Y84.31 E.02653
G1 X111.11 Y83.71 E.01121
G1 X120.11 Y83.71 E.16817
G1 X120.113 Y81.713 E.03732
G1 X120.885 Y81.714 E.01442
G1 X120.884 Y88.289 E.12287
G1 X120.114 Y88.288 E.01439
G1 X120.11 Y86.29 E.03733
G1 X111.11 Y86.29 E.16817
G1 X111.11 Y85.69 E.01121
G1 X109.69 Y85.69 E.02653
G1 X109.69 Y86.23 E.01008
; WIPE_START
M204 S6000
G1 X109.111 Y86.286 E-.08285
G1 X109.114 Y84.868 E-.20215
; WIPE_END
G1 E-.015
M204 S10000
G17
G3 Z2.16 I1.217 J0 P1  F18000
; stop printing object, unique label id: 16
M625
; object ids of layer 14 start: 8,12,16
M624 BwAAAAAAAAA=
;===================== date: 20250206 =====================

; don't support timelapse gcode in spiral_mode and by object sequence for I3 structure printer
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
G92 E0
G1 Z2.16
G1 X0 Y85.0002 ; move to safe pos
G1 X-13.0 F3000 ; move to safe pos
M400
M1004 S5 P1  ; external shutter
M400 P300
M971 S11 C11 O0
G92 E0
G1 X0 F18000
M623

; SKIPTYPE: head_wrap_detect
M622.1 S1
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




; object ids of this layer14 end: 8,12,16
M625
; start printing object, unique label id: 16
M624 BAAAAAAAAAA=
G1 X109.4 Y84.515
G1 Z1.76
G1 E.3 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.196407
G1 F2400
M204 S6000
G1 X109.4 Y83.915 E.00485
; WIPE_START
G1 X109.4 Y84.515 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X109.4 Y86.085 Z2.16 F18000
G1 Z1.76
G1 E.3 F1800
; LINE_WIDTH: 0.196487
G1 F2400
M204 S6000
G1 X109.4 Y85.485 E.00485
M204 S10000
G1 X109.731 Y85 F18000
; LINE_WIDTH: 0.163052
G1 F2400
M204 S6000
G1 X111.731 Y85 E.01301
M204 S10000
G1 X112.156 Y85 F18000
; LINE_WIDTH: 0.514572
G1 F2400
M204 S6000
G1 X119.844 Y85 E.17813
; WIPE_START
G1 X117.844 Y85 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X120.5 Y86.085 Z2.16 F18000
G1 Z1.76
G1 E.3 F1800
; LINE_WIDTH: 0.396522
G1 F2400
M204 S6000
G1 X120.5 Y88.085 E.03514
; WIPE_START
G1 X120.5 Y86.085 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X120.5 Y83.915 Z2.16 F18000
G1 Z1.76
G1 E.3 F1800
G1 F2400
M204 S6000
G1 X120.5 Y81.917 E.0351
; OBJECT_ID: 12
; WIPE_START
G1 X120.5 Y83.915 E-.285
; WIPE_END
G1 E-.015 F1800
; stop printing object, unique label id: 16
M625
; start printing object, unique label id: 12
M624 AgAAAAAAAAA=
M204 S10000
G1 X112.92 Y84.81 Z2.16 F18000
G1 X88.09 Y87.743 Z2.16
G1 Z1.76
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F3600
M204 S6000
G1 X87.257 Y87.743 E.01676
G1 X87.257 Y82.257 E.11033
G1 X92.743 Y82.257 E.11033
G1 X92.743 Y87.743 E.11033
G1 X88.15 Y87.743 E.09236
M204 S10000
G1 X88.09 Y87.319 F18000
G1 F3600
M204 S6000
G1 X87.681 Y87.319 E.00823
G1 X87.681 Y82.681 E.09327
G1 X92.319 Y82.681 E.09327
G1 X92.319 Y87.319 E.09327
G1 X88.15 Y87.319 E.08383
M204 S250
G1 X88.09 Y86.91 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1800
M204 S5000
G1 X88.09 Y83.09 E.07138
G1 X91.91 Y83.09 E.07138
G1 X91.91 Y86.91 E.07138
G1 X88.15 Y86.91 E.07026
; WIPE_START
M204 S6000
M73 P56 R8
G1 X88.119 Y84.91 E-.285
; WIPE_END
G1 E-.015
M204 S10000
G1 X86.943 Y80.645 Z2.16 F18000
G1 Z1.76
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F3600
M204 S6000
G1 X93.056 Y80.652 E.12291
G1 X93.057 Y89.357 E.17502
G1 X86.943 Y89.357 E.12292
G1 X86.943 Y80.705 E.17397
M204 S10000
G1 X86.519 Y80.22 F18000
G1 F3600
M204 S6000
G1 X93.48 Y80.229 E.13997
G1 X93.481 Y89.781 E.19207
G1 X86.519 Y89.781 E.13998
G1 X86.519 Y80.28 E.19104
M204 S250
G1 X86.269 Y79.844 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1800
M204 S5000
G1 X86.397 Y79.81 E.00248
G1 X93.666 Y79.82 E.13583
G1 X93.802 Y79.898 E.00293
G1 X93.865 Y79.992 E.00213
G1 X93.89 Y80.103 E.00212
G1 X93.89 Y89.883 E.18275
G1 X93.873 Y89.989 E.00199
G1 X93.831 Y90.073 E.00176
G1 X93.731 Y90.157 E.00244
G1 X93.588 Y90.19 E.00275
G1 X86.417 Y90.19 E.134
G1 X86.311 Y90.173 E.00199
G1 X86.227 Y90.131 E.00176
G1 X86.143 Y90.031 E.00244
G1 X86.11 Y89.888 E.00275
G1 X86.11 Y80.117 E.18258
G1 X86.127 Y80.011 E.00199
G1 X86.165 Y79.937 E.00156
G1 X86.224 Y79.884 E.00148
; WIPE_START
M204 S6000
G1 X86.397 Y79.81 E-.02679
G1 X88.209 Y79.813 E-.25821
; WIPE_END
G1 E-.015
M204 S10000
G1 X92.647 Y81.847 Z2.16 F18000
G1 Z1.76
G1 E.3 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.419992
G1 F4800
M204 S6000
G1 X92.647 Y81.061 E.01469
G1 X87.353 Y81.054 E.09892
G1 X87.353 Y81.847 E.01482
G1 X92.587 Y81.847 E.0978
; WIPE_START
G1 X90.587 Y81.847 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X87.749 Y81.451 Z2.16 F18000
G1 Z1.76
G1 E.3 F1800
; LINE_WIDTH: 0.421112
G1 F4800
M204 S6000
G1 X92.194 Y81.454 E.08329
; WIPE_START
G1 X90.194 Y81.453 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X92.647 Y88.153 Z2.16 F18000
G1 Z1.76
G1 E.3 F1800
; LINE_WIDTH: 0.419992
G1 F4800
M204 S6000
G1 X87.353 Y88.153 E.09893
G1 X87.353 Y88.947 E.01485
G1 X92.647 Y88.947 E.09893
G1 X92.647 Y88.213 E.01373
; WIPE_START
G1 X92.647 Y88.947 E-.10468
G1 X91.382 Y88.947 E-.18032
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X87.75 Y88.55 Z2.16 F18000
G1 Z1.76
G1 E.3 F1800
; LINE_WIDTH: 0.426072
G1 F4800
M204 S6000
G1 X92.19 Y88.55 E.08424
; OBJECT_ID: 8
; WIPE_START
G1 X90.19 Y88.55 E-.285
; WIPE_END
G1 E-.015 F1800
; stop printing object, unique label id: 12
M625
; start printing object, unique label id: 8
M624 AQAAAAAAAAA=
M204 S10000
G1 X82.831 Y86.524 Z2.16 F18000
G1 X63.09 Y81.09 Z2.16
G1 Z1.76
G1 E.3 F1800
M106 S229.5
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
G1 X62.257 Y88.957 E.15818
G1 X59.609 Y88.957 E.05323
G1 X59.609 Y81.043 E.15911
G1 X62.243 Y81.043 E.05296
M204 S10000
G1 X62.681 Y81.09 F18000
G1 F3600
M204 S6000
G1 X62.681 Y89.381 E.16671
G1 X59.185 Y89.381 E.07029
G1 X59.185 Y80.619 E.17617
G1 X62.681 Y80.619 E.07029
G1 X62.681 Y81.03 E.00826
; WIPE_START
G1 X62.681 Y83.03 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X70.072 Y81.126 Z2.16 F18000
G1 X70.391 Y81.043 Z2.16
G1 Z1.76
G1 E.3 F1800
G1 F3600
M204 S6000
G1 X70.391 Y88.957 E.15911
G1 X67.743 Y88.957 E.05323
G1 X67.743 Y81.043 E.15911
G1 X70.331 Y81.043 E.05203
M204 S10000
G1 X70.815 Y80.619 F18000
G1 F3600
M204 S6000
G1 X70.815 Y89.381 E.17617
G1 X67.319 Y89.381 E.07029
G1 X67.319 Y80.619 E.17617
G1 X70.755 Y80.619 E.06909
M204 S250
G1 X71.184 Y80.21 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F2700
M204 S5000
G1 X71.224 Y80.21 E.00076
G1 F3600
G1 X71.224 Y80.61 E.00747
M106 S61.2
M106 S229.5
G1 X71.224 Y89.39 E.16406
M106 S61.2
M106 S229.5
G1 X71.224 Y89.79 E.00747
M106 S61.2
M106 S229.5
G1 F2046.152
G1 X71.184 Y89.79 E.00076
G1 F1800
G1 X58.816 Y89.79 E.23109
G1 F2047.907
G1 X58.776 Y89.79 E.00076
G1 F3600
G1 X58.776 Y89.39 E.00747
M106 S61.2
M106 S229.5
G1 X58.776 Y80.61 E.16406
M106 S61.2
M106 S229.5
G1 X58.776 Y80.21 E.00747
M106 S61.2
G1 F2047.907
G1 X58.816 Y80.21 E.00076
G1 F1800
G1 X71.124 Y80.21 E.22997
; WIPE_START
M204 S6000
G1 X71.224 Y80.21 E-.01434
G1 X71.224 Y80.61 E-.057
G1 X71.224 Y82.109 E-.21366
; WIPE_END
G1 E-.015
M204 S10000
G1 X67.115 Y80.65 Z2.16 F18000
G1 Z1.76
G1 E.3 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.496522
G1 F2400
M204 S6000
G1 X62.885 Y80.65 E.09436
; WIPE_START
G1 X64.885 Y80.65 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X61.847 Y82.367 Z2.16 F18000
G1 Z1.76
G1 E.3 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.419992
G1 F4800
M204 S6000
G1 X61.847 Y81.453 E.01709
G1 X60.018 Y81.453 E.03417
G1 X60.018 Y88.547 E.13256
G1 X61.847 Y88.547 E.03417
G1 X61.847 Y82.427 E.11436
M204 S10000
G1 X61.453 Y82.367 F18000
G1 F4800
M204 S6000
G1 X61.453 Y81.847 E.00972
G1 X60.413 Y81.847 E.01944
G1 X60.413 Y88.153 E.11783
G1 X61.453 Y88.153 E.01944
G1 X61.453 Y82.427 E.10699
M204 S10000
G1 X61.094 Y82.367 F18000
; LINE_WIDTH: 0.348852
G1 F4800
M204 S6000
G1 X61.094 Y82.206 E.00247
G1 X60.771 Y82.206 E.00495
G1 X60.771 Y87.794 E.08558
G1 X61.094 Y87.794 E.00495
G1 X61.094 Y82.427 E.08219
; WIPE_START
G1 X61.094 Y84.427 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X62.885 Y89.35 Z2.16 F18000
G1 Z1.76
G1 E.3 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.496522
G1 F2400
M204 S6000
G1 X67.115 Y89.35 E.09436
; WIPE_START
G1 X65.115 Y89.35 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X68.906 Y87.633 Z2.16 F18000
G1 Z1.76
G1 E.3 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.348822
G1 F4800
M204 S6000
G1 X68.906 Y87.794 E.00247
G1 X69.229 Y87.794 E.00495
G1 X69.229 Y82.206 E.08558
G1 X68.906 Y82.206 E.00495
G1 X68.906 Y87.573 E.08218
M204 S10000
G1 X68.547 Y88.153 F18000
; LINE_WIDTH: 0.419992
G1 F4800
M204 S6000
G1 X69.587 Y88.153 E.01944
G1 X69.587 Y81.847 E.11783
G1 X68.547 Y81.847 E.01944
G1 X68.547 Y88.093 E.11671
M204 S10000
G1 X68.153 Y88.547 F18000
G1 F4800
M204 S6000
G1 X69.982 Y88.547 E.03417
G1 X69.982 Y81.453 E.13256
G1 X68.153 Y81.453 E.03417
G1 X68.153 Y88.487 E.13144
; CHANGE_LAYER
; Z_HEIGHT: 1.88
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F4800
G1 X68.153 Y86.487 E-.285
; WIPE_END
G1 E-.015 F1800
; stop printing object, unique label id: 8
M625
; layer num/total_layer_count: 15/57
; update layer progress
M73 L15
M991 S0 P14 ;notify layer change
; OBJECT_ID: 16
; start printing object, unique label id: 16
M624 BAAAAAAAAAA=
M204 S10000
G17
G3 Z2.16 I.029 J1.217 P1  F18000
G1 X111.943 Y85.457 Z2.16
G1 Z1.88
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F3600
M204 S6000
G1 X111.943 Y84.543 E.01836
G1 X120.056 Y84.543 E.16313
G1 X120.056 Y85.457 E.01836
G1 X112.003 Y85.457 E.16193
; WIPE_START
G1 X111.943 Y84.543 E-.13039
G1 X113.028 Y84.543 E-.15461
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X109.69 Y85.281 Z2.28 F18000
G1 Z1.88
G1 E.3 F1800
G1 F3600
M204 S6000
G1 X109.519 Y85.281 E.00343
G1 X109.519 Y84.719 E.01129
G1 X111.519 Y84.719 E.04021
G1 X111.519 Y84.119 E.01206
G1 X120.481 Y84.119 E.18019
G1 X120.481 Y85.881 E.03542
G1 X111.519 Y85.881 E.18019
M73 P57 R8
G1 X111.519 Y85.281 E.01206
G1 X109.75 Y85.281 E.03557
; WIPE_START
G1 X109.519 Y85.281 E-.03288
G1 X109.519 Y84.719 E-.08002
G1 X110.727 Y84.719 E-.1721
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X109.69 Y86.29 Z2.28 F18000
G1 Z1.88
G1 E.3 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
M204 S5000
G1 X109.111 Y86.286 E.01081
G1 X109.116 Y83.711 E.04812
G1 X109.69 Y83.71 E.01073
G1 X109.69 Y84.31 E.01121
G1 X111.11 Y84.31 E.02653
G1 X111.11 Y83.71 E.01121
G1 X120.11 Y83.71 E.16817
G1 X120.113 Y81.712 E.03734
G1 X120.886 Y81.714 E.01444
G1 X120.884 Y88.289 E.12287
G1 X120.114 Y88.287 E.01439
G1 X120.11 Y86.29 E.03732
G1 X111.11 Y86.29 E.16817
G1 X111.11 Y85.69 E.01121
G1 X109.69 Y85.69 E.02653
G1 X109.69 Y86.23 E.01008
; WIPE_START
M204 S6000
G1 X109.111 Y86.286 E-.08284
G1 X109.114 Y84.868 E-.20216
; WIPE_END
G1 E-.015
M204 S10000
G17
G3 Z2.28 I1.217 J0 P1  F18000
; stop printing object, unique label id: 16
M625
; object ids of layer 15 start: 8,12,16
M624 BwAAAAAAAAA=
;===================== date: 20250206 =====================

; don't support timelapse gcode in spiral_mode and by object sequence for I3 structure printer
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
G92 E0
G1 Z2.28
G1 X0 Y85.0002 ; move to safe pos
G1 X-13.0 F3000 ; move to safe pos
M400
M1004 S5 P1  ; external shutter
M400 P300
M971 S11 C11 O0
G92 E0
G1 X0 F18000
M623

; SKIPTYPE: head_wrap_detect
M622.1 S1
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




; object ids of this layer15 end: 8,12,16
M625
; start printing object, unique label id: 16
M624 BAAAAAAAAAA=
G1 X109.4 Y84.515
G1 Z1.88
G1 E.3 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.196408
G1 F2400
M204 S6000
G1 X109.4 Y83.915 E.00485
; WIPE_START
G1 X109.4 Y84.515 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X109.4 Y86.085 Z2.28 F18000
G1 Z1.88
G1 E.3 F1800
; LINE_WIDTH: 0.196498
G1 F2400
M204 S6000
G1 X109.4 Y85.485 E.00485
M204 S10000
G1 X109.731 Y85 F18000
; LINE_WIDTH: 0.163052
G1 F2400
M204 S6000
G1 X111.731 Y85 E.01301
M204 S10000
G1 X112.156 Y85 F18000
; LINE_WIDTH: 0.514572
G1 F2400
M204 S6000
G1 X119.844 Y85 E.17813
; WIPE_START
G1 X117.844 Y85 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X120.5 Y86.085 Z2.28 F18000
G1 Z1.88
G1 E.3 F1800
; LINE_WIDTH: 0.396408
G1 F2400
M204 S6000
G1 X120.5 Y88.085 E.03513
; WIPE_START
G1 X120.5 Y86.085 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X120.5 Y83.915 Z2.28 F18000
G1 Z1.88
G1 E.3 F1800
; LINE_WIDTH: 0.396498
G1 F2400
M204 S6000
G1 X120.5 Y81.917 E.03509
; OBJECT_ID: 12
; WIPE_START
G1 X120.5 Y83.915 E-.285
; WIPE_END
G1 E-.015 F1800
; stop printing object, unique label id: 16
M625
; start printing object, unique label id: 12
M624 AgAAAAAAAAA=
M204 S10000
G1 X112.92 Y84.81 Z2.28 F18000
G1 X88.09 Y87.743 Z2.28
G1 Z1.88
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F3600
M204 S6000
G1 X87.257 Y87.743 E.01676
G1 X87.257 Y82.257 E.11033
G1 X92.743 Y82.257 E.11033
G1 X92.743 Y87.743 E.11033
G1 X88.15 Y87.743 E.09236
M204 S10000
G1 X88.09 Y87.319 F18000
G1 F3600
M204 S6000
G1 X87.681 Y87.319 E.00823
G1 X87.681 Y82.681 E.09327
G1 X92.319 Y82.681 E.09327
G1 X92.319 Y87.319 E.09327
G1 X88.15 Y87.319 E.08383
M204 S250
G1 X88.09 Y86.91 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1800
M204 S5000
G1 X88.09 Y83.09 E.07138
G1 X91.91 Y83.09 E.07138
G1 X91.91 Y86.91 E.07138
G1 X88.15 Y86.91 E.07026
; WIPE_START
M204 S6000
G1 X88.119 Y84.91 E-.285
; WIPE_END
G1 E-.015
M204 S10000
G1 X86.943 Y80.645 Z2.28 F18000
G1 Z1.88
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F3600
M204 S6000
G1 X93.056 Y80.652 E.12291
G1 X93.057 Y89.357 E.17502
G1 X86.943 Y89.357 E.12292
G1 X86.943 Y80.705 E.17397
M204 S10000
G1 X86.519 Y80.22 F18000
G1 F3600
M204 S6000
G1 X93.48 Y80.229 E.13997
G1 X93.481 Y89.781 E.19207
G1 X86.519 Y89.781 E.13998
G1 X86.519 Y80.28 E.19104
M204 S250
G1 X86.26 Y79.849 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1800
M204 S5000
G1 X86.407 Y79.81 E.00284
G1 X93.656 Y79.82 E.13544
G1 X93.797 Y79.89 E.00295
G1 X93.863 Y79.986 E.00217
G1 X93.89 Y80.104 E.00227
G1 X93.89 Y89.883 E.18273
G1 X93.873 Y89.989 E.00199
G1 X93.831 Y90.073 E.00176
G1 X93.731 Y90.157 E.00244
G1 X93.588 Y90.19 E.00275
G1 X86.417 Y90.19 E.13399
G1 X86.311 Y90.173 E.00199
G1 X86.227 Y90.131 E.00176
G1 X86.143 Y90.031 E.00244
G1 X86.11 Y89.888 E.00275
G1 X86.11 Y80.117 E.18258
G1 X86.127 Y80.011 E.00199
G1 X86.169 Y79.927 E.00176
G1 X86.215 Y79.888 E.00112
; WIPE_START
M204 S6000
G1 X86.407 Y79.81 E-.02956
G1 X88.2 Y79.813 E-.25544
; WIPE_END
G1 E-.015
M204 S10000
G1 X92.647 Y81.847 Z2.28 F18000
G1 Z1.88
G1 E.3 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.419992
G1 F4800
M204 S6000
G1 X92.647 Y81.061 E.01469
G1 X87.353 Y81.054 E.09892
G1 X87.353 Y81.847 E.01482
G1 X92.587 Y81.847 E.0978
; WIPE_START
G1 X90.587 Y81.847 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X87.749 Y81.451 Z2.28 F18000
G1 Z1.88
G1 E.3 F1800
; LINE_WIDTH: 0.421102
G1 F4800
M204 S6000
G1 X92.194 Y81.454 E.08328
; WIPE_START
G1 X90.194 Y81.453 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X92.647 Y88.153 Z2.28 F18000
G1 Z1.88
G1 E.3 F1800
; LINE_WIDTH: 0.419992
G1 F4800
M204 S6000
G1 X87.353 Y88.153 E.09893
G1 X87.353 Y88.947 E.01485
G1 X92.647 Y88.947 E.09893
G1 X92.647 Y88.213 E.01373
; WIPE_START
G1 X92.647 Y88.947 E-.10468
G1 X91.382 Y88.947 E-.18032
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X87.75 Y88.55 Z2.28 F18000
G1 Z1.88
G1 E.3 F1800
; LINE_WIDTH: 0.426072
G1 F4800
M204 S6000
G1 X92.19 Y88.55 E.08424
; OBJECT_ID: 8
; WIPE_START
G1 X90.19 Y88.55 E-.285
; WIPE_END
G1 E-.015 F1800
; stop printing object, unique label id: 12
M625
; start printing object, unique label id: 8
M624 AQAAAAAAAAA=
M204 S10000
G1 X82.831 Y86.524 Z2.28 F18000
G1 X63.09 Y81.09 Z2.28
G1 Z1.88
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
G1 X62.257 Y88.957 E.15818
G1 X59.533 Y88.957 E.05475
G1 X59.533 Y81.043 E.15911
G1 X62.243 Y81.043 E.05448
M204 S10000
G1 X62.681 Y81.09 F18000
G1 F3600
M204 S6000
G1 X62.681 Y89.381 E.16671
G1 X59.109 Y89.381 E.07182
G1 X59.109 Y80.619 E.17617
G1 X62.681 Y80.619 E.07182
G1 X62.681 Y81.03 E.00826
; WIPE_START
G1 X62.681 Y83.03 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X70.076 Y81.143 Z2.28 F18000
G1 X70.466 Y81.043 Z2.28
G1 Z1.88
G1 E.3 F1800
G1 F3600
M204 S6000
G1 X70.466 Y88.957 E.15911
G1 X67.743 Y88.957 E.05475
G1 X67.743 Y81.043 E.15911
G1 X70.406 Y81.043 E.05354
M204 S10000
G1 X70.89 Y80.619 F18000
G1 F3600
M204 S6000
G1 X70.891 Y89.381 E.17617
G1 X67.319 Y89.381 E.07181
G1 X67.319 Y80.619 E.17617
G1 X70.83 Y80.619 E.0706
M204 S250
G1 X71.265 Y80.21 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F2520
M204 S5000
G1 X71.3 Y80.21 E.00064
G1 F3420
G1 X71.3 Y80.61 E.00747
G1 X71.3 Y89.39 E.16406
G1 X71.3 Y89.79 E.00747
G1 F2009.587
G1 X71.265 Y89.79 E.00065
G1 F1800
M73 P58 R8
G1 X58.735 Y89.79 E.23414
G1 F2009.897
G1 X58.7 Y89.79 E.00065
G1 F3420
G1 X58.7 Y89.39 E.00747
G1 X58.7 Y80.61 E.16406
G1 X58.7 Y80.21 E.00747
G1 F2009.897
G1 X58.735 Y80.21 E.00065
G1 F1800
G1 X71.205 Y80.21 E.23302
; WIPE_START
M204 S6000
G1 X71.3 Y80.21 E-.01343
G1 X71.3 Y80.61 E-.057
G1 X71.3 Y82.116 E-.21457
; WIPE_END
G1 E-.015
M204 S10000
G1 X68.924 Y82.405 Z2.28 F18000
G1 Z1.88
G1 E.3 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.386541
G1 F4800
M204 S6000
G1 X68.924 Y87.776 E.09184
G1 X69.285 Y87.776 E.00617
G1 X69.285 Y82.224 E.09492
G1 X68.924 Y82.224 E.00617
G1 X68.924 Y82.345 E.00206
; WIPE_START
G1 X68.924 Y82.224 E-.01715
G1 X69.285 Y82.224 E-.05141
G1 X69.285 Y83.743 E-.21644
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X68.547 Y88.153 Z2.28 F18000
G1 Z1.88
G1 E.3 F1800
; LINE_WIDTH: 0.419992
G1 F4800
M204 S6000
G1 X69.663 Y88.153 E.02085
G1 X69.663 Y81.847 E.11783
G1 X68.547 Y81.847 E.02085
G1 X68.547 Y88.093 E.11671
M204 S10000
G1 X68.153 Y88.547 F18000
G1 F4800
M204 S6000
G1 X70.057 Y88.547 E.03558
G1 X70.057 Y81.453 E.13256
G1 X68.153 Y81.453 E.03558
G1 X68.153 Y88.487 E.13144
; WIPE_START
G1 X68.153 Y86.487 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X67.115 Y89.35 Z2.28 F18000
G1 Z1.88
G1 E.3 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.496522
G1 F2400
M204 S6000
G1 X62.885 Y89.35 E.09436
; WIPE_START
G1 X64.885 Y89.35 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X61.847 Y82.405 Z2.28 F18000
G1 Z1.88
G1 E.3 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.419992
G1 F4800
M204 S6000
G1 X61.847 Y81.453 E.01779
G1 X59.943 Y81.453 E.03559
G1 X59.943 Y88.547 E.13256
G1 X61.847 Y88.547 E.03559
G1 X61.847 Y82.465 E.11365
M204 S10000
G1 X61.453 Y82.405 F18000
G1 F4800
M204 S6000
G1 X61.453 Y81.847 E.01043
G1 X60.337 Y81.847 E.02086
G1 X60.337 Y88.153 E.11783
G1 X61.453 Y88.153 E.02086
G1 X61.453 Y82.465 E.10628
M204 S10000
G1 X61.075 Y82.405 F18000
; LINE_WIDTH: 0.386712
G1 F4800
M204 S6000
G1 X61.075 Y82.225 E.00309
G1 X60.714 Y82.225 E.00618
G1 X60.714 Y87.775 E.09496
G1 X61.075 Y87.775 E.00618
G1 X61.075 Y82.465 E.09085
; WIPE_START
G1 X61.075 Y84.465 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X62.885 Y80.65 Z2.28 F18000
G1 Z1.88
G1 E.3 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.496522
G1 F2400
M204 S6000
G1 X67.115 Y80.65 E.09436
; CHANGE_LAYER
; Z_HEIGHT: 2
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F2400
G1 X65.115 Y80.65 E-.285
; WIPE_END
G1 E-.015 F1800
; stop printing object, unique label id: 8
M625
; layer num/total_layer_count: 16/57
; update layer progress
M73 L16
M991 S0 P15 ;notify layer change
; OBJECT_ID: 16
; start printing object, unique label id: 16
M624 BAAAAAAAAAA=
M204 S10000
G17
G3 Z2.28 I-.124 J1.211 P1  F18000
G1 X111.943 Y85.457 Z2.28
G1 Z2
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F3600
M204 S6000
G1 X111.943 Y84.543 E.01836
G1 X120.057 Y84.543 E.16313
G1 X120.057 Y85.457 E.01836
G1 X112.003 Y85.457 E.16193
; WIPE_START
G1 X111.943 Y84.543 E-.13039
G1 X113.028 Y84.543 E-.15461
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X109.69 Y85.281 Z2.4 F18000
G1 Z2
G1 E.3 F1800
G1 F3600
M204 S6000
G1 X109.519 Y85.281 E.00343
G1 X109.519 Y84.719 E.01129
G1 X111.519 Y84.719 E.04021
G1 X111.519 Y84.119 E.01206
G1 X120.481 Y84.119 E.18019
G1 X120.481 Y85.881 E.03542
G1 X111.519 Y85.881 E.18019
G1 X111.519 Y85.281 E.01206
G1 X109.75 Y85.281 E.03557
; WIPE_START
G1 X109.519 Y85.281 E-.03288
G1 X109.519 Y84.719 E-.08002
G1 X110.727 Y84.719 E-.1721
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X109.69 Y86.29 Z2.4 F18000
G1 Z2
G1 E.3 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
M204 S5000
G1 X109.111 Y86.286 E.01081
G1 X109.116 Y83.711 E.04812
G1 X109.69 Y83.71 E.01073
G1 X109.69 Y84.31 E.01121
G1 X111.11 Y84.31 E.02653
G1 X111.11 Y83.71 E.01121
G1 X120.11 Y83.71 E.16817
G1 X120.113 Y81.712 E.03733
G1 X120.886 Y81.714 E.01444
G1 X120.884 Y88.289 E.12287
G1 X120.114 Y88.288 E.01439
G1 X120.11 Y86.29 E.03733
G1 X111.11 Y86.29 E.16817
G1 X111.11 Y85.69 E.01121
G1 X109.69 Y85.69 E.02653
G1 X109.69 Y86.23 E.01008
; WIPE_START
M204 S6000
G1 X109.111 Y86.286 E-.08285
G1 X109.114 Y84.868 E-.20215
; WIPE_END
G1 E-.015
M204 S10000
G17
G3 Z2.4 I1.217 J0 P1  F18000
; stop printing object, unique label id: 16
M625
; object ids of layer 16 start: 8,12,16
M624 BwAAAAAAAAA=
;===================== date: 20250206 =====================

; don't support timelapse gcode in spiral_mode and by object sequence for I3 structure printer
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
G92 E0
G1 Z2.4
G1 X0 Y85.0002 ; move to safe pos
G1 X-13.0 F3000 ; move to safe pos
M400
M1004 S5 P1  ; external shutter
M400 P300
M971 S11 C11 O0
G92 E0
G1 X0 F18000
M623

; SKIPTYPE: head_wrap_detect
M622.1 S1
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




; object ids of this layer16 end: 8,12,16
M625
; start printing object, unique label id: 16
M624 BAAAAAAAAAA=
G1 X109.4 Y84.515
G1 Z2
G1 E.3 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.196407
G1 F2400
M204 S6000
G1 X109.4 Y83.915 E.00485
; WIPE_START
G1 X109.4 Y84.515 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X109.4 Y86.085 Z2.4 F18000
G1 Z2
G1 E.3 F1800
; LINE_WIDTH: 0.196487
G1 F2400
M204 S6000
G1 X109.4 Y85.485 E.00485
M204 S10000
G1 X109.731 Y85 F18000
; LINE_WIDTH: 0.163052
G1 F2400
M204 S6000
G1 X111.731 Y85 E.01301
M204 S10000
G1 X112.156 Y85 F18000
; LINE_WIDTH: 0.514572
G1 F2400
M204 S6000
G1 X119.844 Y85 E.17813
; WIPE_START
G1 X117.844 Y85 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X120.5 Y86.085 Z2.4 F18000
G1 Z2
G1 E.3 F1800
; LINE_WIDTH: 0.396522
G1 F2400
M204 S6000
G1 X120.5 Y88.085 E.03514
; WIPE_START
G1 X120.5 Y86.085 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X120.5 Y83.915 Z2.4 F18000
G1 Z2
G1 E.3 F1800
G1 F2400
M204 S6000
G1 X120.5 Y81.917 E.0351
; OBJECT_ID: 12
; WIPE_START
G1 X120.5 Y83.915 E-.285
; WIPE_END
G1 E-.015 F1800
; stop printing object, unique label id: 16
M625
; start printing object, unique label id: 12
M624 AgAAAAAAAAA=
M204 S10000
G1 X112.92 Y84.81 Z2.4 F18000
G1 X88.09 Y87.743 Z2.4
G1 Z2
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F3600
M204 S6000
G1 X87.257 Y87.743 E.01676
G1 X87.257 Y82.257 E.11033
G1 X92.743 Y82.257 E.11033
G1 X92.743 Y87.743 E.11033
G1 X88.15 Y87.743 E.09236
M204 S10000
G1 X88.09 Y87.319 F18000
G1 F3600
M204 S6000
G1 X87.681 Y87.319 E.00823
G1 X87.681 Y82.681 E.09327
G1 X92.319 Y82.681 E.09327
G1 X92.319 Y87.319 E.09327
G1 X88.15 Y87.319 E.08383
M204 S250
G1 X88.09 Y86.91 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1800
M204 S5000
G1 X88.09 Y83.09 E.07138
G1 X91.91 Y83.09 E.07138
G1 X91.91 Y86.91 E.07138
G1 X88.15 Y86.91 E.07026
; WIPE_START
M204 S6000
G1 X88.119 Y84.91 E-.285
; WIPE_END
G1 E-.015
M204 S10000
G1 X86.943 Y80.645 Z2.4 F18000
G1 Z2
M73 P59 R8
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F3600
M204 S6000
G1 X93.056 Y80.652 E.12291
G1 X93.057 Y89.357 E.17502
G1 X86.943 Y89.357 E.12292
G1 X86.943 Y80.705 E.17397
M204 S10000
G1 X86.519 Y80.22 F18000
G1 F3600
M204 S6000
G1 X93.48 Y80.229 E.13997
G1 X93.481 Y89.781 E.19207
G1 X86.519 Y89.781 E.13998
G1 X86.519 Y80.28 E.19104
M204 S250
G1 X86.269 Y79.844 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1800
M204 S5000
G1 X86.397 Y79.81 E.00247
G1 X93.656 Y79.82 E.13563
G1 X93.798 Y79.89 E.00297
G1 X93.859 Y79.978 E.002
G1 X93.89 Y80.105 E.00244
G1 X93.89 Y89.883 E.18271
G1 X93.873 Y89.989 E.00199
G1 X93.831 Y90.073 E.00176
G1 X93.731 Y90.157 E.00244
G1 X93.588 Y90.19 E.00275
G1 X86.417 Y90.19 E.134
G1 X86.311 Y90.173 E.00199
G1 X86.227 Y90.131 E.00176
G1 X86.143 Y90.031 E.00244
G1 X86.11 Y89.888 E.00275
G1 X86.11 Y80.117 E.18258
G1 X86.127 Y80.011 E.00199
G1 X86.165 Y79.937 E.00156
G1 X86.224 Y79.884 E.00149
; WIPE_START
M204 S6000
G1 X86.397 Y79.81 E-.02677
G1 X88.209 Y79.813 E-.25823
; WIPE_END
G1 E-.015
M204 S10000
G1 X92.647 Y81.847 Z2.4 F18000
G1 Z2
G1 E.3 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.419992
G1 F4800
M204 S6000
G1 X92.647 Y81.061 E.01469
G1 X87.353 Y81.054 E.09892
G1 X87.353 Y81.847 E.01482
G1 X92.587 Y81.847 E.0978
; WIPE_START
G1 X90.587 Y81.847 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X87.749 Y81.451 Z2.4 F18000
G1 Z2
G1 E.3 F1800
; LINE_WIDTH: 0.421142
G1 F4800
M204 S6000
G1 X92.194 Y81.454 E.08329
; WIPE_START
G1 X90.194 Y81.453 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X92.647 Y88.153 Z2.4 F18000
G1 Z2
G1 E.3 F1800
; LINE_WIDTH: 0.419992
G1 F4800
M204 S6000
G1 X87.353 Y88.153 E.09893
G1 X87.353 Y88.947 E.01485
G1 X92.647 Y88.947 E.09893
G1 X92.647 Y88.213 E.01373
; WIPE_START
G1 X92.647 Y88.947 E-.10468
G1 X91.382 Y88.947 E-.18032
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X87.75 Y88.55 Z2.4 F18000
G1 Z2
G1 E.3 F1800
; LINE_WIDTH: 0.426072
G1 F4800
M204 S6000
G1 X92.19 Y88.55 E.08424
; OBJECT_ID: 8
; WIPE_START
G1 X90.19 Y88.55 E-.285
; WIPE_END
G1 E-.015 F1800
; stop printing object, unique label id: 12
M625
; start printing object, unique label id: 8
M624 AQAAAAAAAAA=
M204 S10000
G1 X82.831 Y86.524 Z2.4 F18000
G1 X63.09 Y81.09 Z2.4
G1 Z2
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
G1 X62.257 Y88.957 E.15818
G1 X59.464 Y88.957 E.05616
G1 X59.464 Y81.043 E.15911
G1 X62.243 Y81.043 E.05589
M204 S10000
G1 X62.681 Y81.09 F18000
G1 F3600
M204 S6000
G1 X62.681 Y89.381 E.16671
G1 X59.039 Y89.381 E.07322
G1 X59.039 Y80.619 E.17617
G1 X62.681 Y80.619 E.07322
G1 X62.681 Y81.03 E.00826
; WIPE_START
G1 X62.681 Y83.03 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X70.08 Y81.159 Z2.4 F18000
G1 X70.536 Y81.043 Z2.4
G1 Z2
G1 E.3 F1800
G1 F3600
M204 S6000
G1 X70.536 Y88.957 E.15911
G1 X67.743 Y88.957 E.05616
G1 X67.743 Y81.043 E.15911
G1 X70.476 Y81.043 E.05495
M204 S10000
G1 X70.96 Y80.619 F18000
G1 F3600
M204 S6000
G1 X70.961 Y89.381 E.17617
G1 X67.319 Y89.381 E.07322
G1 X67.319 Y80.619 E.17617
G1 X70.9 Y80.619 E.07201
M204 S250
G1 X71.341 Y80.21 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F2340
M204 S5000
G1 X71.37 Y80.21 E.00054
G1 F3060
G1 X71.37 Y80.61 E.00747
G1 X71.37 Y89.39 E.16406
G1 X71.37 Y89.79 E.00747
G1 F1974.152
G1 X71.341 Y89.79 E.00054
G1 F1800
G1 X58.659 Y89.79 E.23697
G1 F2340
G1 X58.63 Y89.79 E.00054
G1 F3060
G1 X58.63 Y89.39 E.00747
G1 X58.63 Y80.61 E.16406
G1 X58.63 Y80.21 E.00747
G1 F1973.413
G1 X58.659 Y80.21 E.00054
G1 F1800
G1 X71.281 Y80.21 E.23584
; WIPE_START
M204 S6000
G1 X71.37 Y80.21 E-.01268
G1 X71.37 Y80.61 E-.057
G1 X71.37 Y82.121 E-.21532
; WIPE_END
G1 E-.015
M204 S10000
G1 X66.618 Y80.873 Z2.4 F18000
G1 Z2
G1 E.3 F1800
; FEATURE: Top surface
G1 F3600
M204 S2000
G1 X67.045 Y80.446 E.0113
G1 X66.507 Y80.427
G1 X66.06 Y80.873 E.01179
G1 X65.503 Y80.873
G1 X65.949 Y80.427 E.01179
G1 X65.392 Y80.427
G1 X64.945 Y80.873 E.0118
G1 X64.388 Y80.873
G1 X64.834 Y80.427 E.0118
G1 X64.276 Y80.427
G1 X63.83 Y80.873 E.0118
G1 X63.273 Y80.873
G1 X63.719 Y80.427 E.01179
M204 S10000
G1 X63.069 Y80.407 F18000
; FEATURE: Gap infill
; LINE_WIDTH: 0.240177
G1 F2400
M204 S6000
G1 X63.04 Y80.786 E.00386
G1 X63.254 Y80.893 E.00243
; WIPE_START
G1 X63.04 Y80.786 E-.10996
G1 X63.069 Y80.407 E-.17504
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X61.058 Y82.44 Z2.4 F18000
G1 Z2
G1 E.3 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.421612
G1 F4800
M204 S6000
G1 X61.058 Y82.242 E.00371
G1 X60.662 Y82.242 E.00743
G1 X60.662 Y87.758 E.10349
G1 X61.058 Y87.758 E.00743
G1 X61.058 Y82.5 E.09865
M204 S10000
G1 X61.453 Y82.44 F18000
; LINE_WIDTH: 0.419992
G1 F4800
M204 S6000
G1 X61.453 Y81.847 E.01108
G1 X60.267 Y81.847 E.02216
G1 X60.267 Y88.153 E.11783
G1 X61.453 Y88.153 E.02216
G1 X61.453 Y82.5 E.10563
M204 S10000
G1 X61.847 Y82.44 F18000
G1 F4800
M204 S6000
G1 X61.847 Y81.453 E.01845
G1 X59.873 Y81.453 E.03689
G1 X59.873 Y88.547 E.13256
G1 X61.847 Y88.547 E.03689
G1 X61.847 Y82.5 E.113
; WIPE_START
G1 X61.847 Y84.5 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X66.281 Y89.573 Z2.4 F18000
G1 Z2
G1 E.3 F1800
; FEATURE: Top surface
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X66.727 Y89.127 E.01179
G1 X66.17 Y89.127
G1 X65.723 Y89.573 E.01179
G1 X65.166 Y89.573
G1 X65.612 Y89.127 E.01179
G1 X65.055 Y89.127
G1 X64.608 Y89.573 E.01179
G1 X64.051 Y89.573
G1 X64.497 Y89.127 E.01179
G1 X63.94 Y89.127
G1 X63.493 Y89.573 E.0118
G1 X62.953 Y89.556
G1 X63.382 Y89.127 E.01134
; WIPE_START
M204 S6000
G1 X62.953 Y89.556 E-.08645
G1 X63.493 Y89.573 E-.07701
G1 X63.94 Y89.127 E-.08995
G1 X64.161 Y89.127 E-.03159
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X66.866 Y89.593 Z2.4 F18000
G1 Z2
G1 E.3 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.235713
G1 F2400
M204 S6000
G1 X66.958 Y89.316 E.0029
G1 X66.957 Y89.213 E.00103
G1 X66.743 Y89.107 E.00238
; WIPE_START
G1 X66.957 Y89.213 E-.10732
G1 X66.958 Y89.316 E-.04652
G1 X66.866 Y89.593 E-.13116
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X68.153 Y88.547 Z2.4 F18000
G1 Z2
G1 E.3 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.419992
G1 F4800
M204 S6000
G1 X70.127 Y88.547 E.03689
G1 X70.127 Y81.453 E.13256
G1 X68.153 Y81.453 E.03689
G1 X68.153 Y88.487 E.13144
; WIPE_START
G1 X68.153 Y86.487 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X68.942 Y82.44 Z2.4 F18000
G1 Z2
G1 E.3 F1800
; LINE_WIDTH: 0.421521
G1 F4800
M204 S6000
G1 X68.942 Y87.758 E.09976
G1 X69.338 Y87.758 E.00742
G1 X69.338 Y82.242 E.10347
G1 X68.942 Y82.242 E.00742
G1 X68.942 Y82.38 E.00259
M204 S10000
G1 X68.547 Y81.847 F18000
; LINE_WIDTH: 0.419992
G1 F4800
M204 S6000
G1 X68.547 Y88.153 E.11783
G1 X69.733 Y88.153 E.02216
G1 X69.733 Y81.847 E.11783
G1 X68.607 Y81.847 E.02103
; CHANGE_LAYER
; Z_HEIGHT: 2.12
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F4800
G1 X69.733 Y81.847 E-.16041
G1 X69.733 Y82.721 E-.12459
; WIPE_END
G1 E-.015 F1800
; stop printing object, unique label id: 8
M625
; layer num/total_layer_count: 17/57
; update layer progress
M73 L17
M991 S0 P16 ;notify layer change
; OBJECT_ID: 16
; start printing object, unique label id: 16
M624 BAAAAAAAAAA=
M204 S10000
G17
G3 Z2.4 I-.079 J1.214 P1  F18000
G1 X111.943 Y85.457 Z2.4
G1 Z2.12
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F3600
M204 S6000
G1 X111.943 Y84.543 E.01836
G1 X120.057 Y84.543 E.16313
G1 X120.057 Y85.457 E.01836
G1 X112.003 Y85.457 E.16193
; WIPE_START
M73 P60 R8
G1 X111.943 Y84.543 E-.13039
G1 X113.028 Y84.543 E-.15461
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X109.69 Y85.281 Z2.52 F18000
G1 Z2.12
G1 E.3 F1800
G1 F3600
M204 S6000
G1 X109.519 Y85.281 E.00343
G1 X109.519 Y84.719 E.01129
G1 X111.519 Y84.719 E.04021
G1 X111.519 Y84.119 E.01206
G1 X120.481 Y84.119 E.18019
G1 X120.481 Y85.881 E.03542
G1 X111.519 Y85.881 E.18019
G1 X111.519 Y85.281 E.01206
G1 X109.75 Y85.281 E.03557
; WIPE_START
G1 X109.519 Y85.281 E-.03288
G1 X109.519 Y84.719 E-.08002
G1 X110.727 Y84.719 E-.1721
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X109.69 Y86.29 Z2.52 F18000
G1 Z2.12
G1 E.3 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
M204 S5000
G1 X109.111 Y86.286 E.01081
G1 X109.116 Y83.711 E.04812
G1 X109.69 Y83.71 E.01073
G1 X109.69 Y84.31 E.01121
G1 X111.11 Y84.31 E.02653
G1 X111.11 Y83.71 E.01121
G1 X120.11 Y83.71 E.16817
G1 X120.113 Y81.712 E.03733
G1 X120.886 Y81.714 E.01444
G1 X120.884 Y88.289 E.12287
G1 X120.114 Y88.288 E.01439
G1 X120.11 Y86.29 E.03734
G1 X111.11 Y86.29 E.16817
G1 X111.11 Y85.69 E.01121
G1 X109.69 Y85.69 E.02653
G1 X109.69 Y86.23 E.01008
; WIPE_START
M204 S6000
G1 X109.111 Y86.286 E-.08285
G1 X109.114 Y84.868 E-.20215
; WIPE_END
G1 E-.015
M204 S10000
G17
G3 Z2.52 I1.217 J0 P1  F18000
; stop printing object, unique label id: 16
M625
; object ids of layer 17 start: 8,12,16
M624 BwAAAAAAAAA=
;===================== date: 20250206 =====================

; don't support timelapse gcode in spiral_mode and by object sequence for I3 structure printer
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
G92 E0
G1 Z2.52
G1 X0 Y85.0002 ; move to safe pos
G1 X-13.0 F3000 ; move to safe pos
M400
M1004 S5 P1  ; external shutter
M400 P300
M971 S11 C11 O0
G92 E0
M73 P60 R7
G1 X0 F18000
M623

; SKIPTYPE: head_wrap_detect
M622.1 S1
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




; object ids of this layer17 end: 8,12,16
M625
; start printing object, unique label id: 16
M624 BAAAAAAAAAA=
G1 X109.4 Y84.515
G1 Z2.12
G1 E.3 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.196407
G1 F2400
M204 S6000
G1 X109.4 Y83.915 E.00485
; WIPE_START
G1 X109.4 Y84.515 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X109.4 Y86.085 Z2.52 F18000
G1 Z2.12
G1 E.3 F1800
; LINE_WIDTH: 0.196487
G1 F2400
M204 S6000
G1 X109.4 Y85.485 E.00485
M204 S10000
G1 X109.731 Y85 F18000
; LINE_WIDTH: 0.163052
G1 F2400
M204 S6000
G1 X111.731 Y85 E.01301
M204 S10000
G1 X112.156 Y85 F18000
; LINE_WIDTH: 0.514572
G1 F2400
M204 S6000
G1 X119.844 Y85 E.17813
; WIPE_START
G1 X117.844 Y85 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X120.5 Y86.085 Z2.52 F18000
G1 Z2.12
G1 E.3 F1800
; LINE_WIDTH: 0.396522
G1 F2400
M204 S6000
G1 X120.5 Y88.085 E.03514
; WIPE_START
G1 X120.5 Y86.085 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X120.5 Y83.915 Z2.52 F18000
G1 Z2.12
G1 E.3 F1800
G1 F2400
M204 S6000
G1 X120.5 Y81.917 E.0351
; OBJECT_ID: 12
; WIPE_START
G1 X120.5 Y83.915 E-.285
; WIPE_END
G1 E-.015 F1800
; stop printing object, unique label id: 16
M625
; start printing object, unique label id: 12
M624 AgAAAAAAAAA=
M204 S10000
G1 X112.92 Y84.81 Z2.52 F18000
G1 X88.09 Y87.743 Z2.52
G1 Z2.12
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F3600
M204 S6000
G1 X87.257 Y87.743 E.01676
G1 X87.257 Y82.257 E.11033
G1 X92.743 Y82.257 E.11033
G1 X92.743 Y87.743 E.11033
G1 X88.15 Y87.743 E.09236
M204 S10000
G1 X88.09 Y87.319 F18000
G1 F3600
M204 S6000
G1 X87.681 Y87.319 E.00823
G1 X87.681 Y82.681 E.09327
G1 X92.319 Y82.681 E.09327
G1 X92.319 Y87.319 E.09327
G1 X88.15 Y87.319 E.08383
M204 S250
G1 X88.09 Y86.91 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1800
M204 S5000
G1 X88.09 Y83.09 E.07138
G1 X91.91 Y83.09 E.07138
G1 X91.91 Y86.91 E.07138
G1 X88.15 Y86.91 E.07026
; WIPE_START
M204 S6000
G1 X88.119 Y84.91 E-.285
; WIPE_END
G1 E-.015
M204 S10000
G1 X86.943 Y80.645 Z2.52 F18000
G1 Z2.12
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F3600
M204 S6000
G1 X93.056 Y80.652 E.12291
G1 X93.057 Y89.357 E.17502
G1 X86.943 Y89.357 E.12292
G1 X86.943 Y80.705 E.17397
M204 S10000
G1 X86.519 Y80.22 F18000
G1 F3600
M204 S6000
G1 X93.48 Y80.229 E.13997
G1 X93.481 Y89.781 E.19207
G1 X86.519 Y89.781 E.13998
G1 X86.519 Y80.28 E.19104
M204 S250
G1 X86.269 Y79.844 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1800
M204 S5000
G1 X86.397 Y79.81 E.00248
G1 X93.666 Y79.82 E.13583
G1 X93.802 Y79.898 E.00293
G1 X93.865 Y79.992 E.00212
G1 X93.89 Y80.103 E.00212
G1 X93.89 Y89.883 E.18275
G1 X93.873 Y89.989 E.00199
G1 X93.831 Y90.073 E.00176
G1 X93.731 Y90.157 E.00244
G1 X93.588 Y90.19 E.00275
G1 X86.417 Y90.19 E.134
G1 X86.311 Y90.173 E.00199
G1 X86.227 Y90.131 E.00176
G1 X86.143 Y90.031 E.00244
G1 X86.11 Y89.888 E.00275
G1 X86.11 Y80.117 E.18258
G1 X86.127 Y80.011 E.00199
G1 X86.165 Y79.937 E.00156
G1 X86.224 Y79.884 E.00148
; WIPE_START
M204 S6000
G1 X86.397 Y79.81 E-.0268
G1 X88.209 Y79.813 E-.2582
; WIPE_END
G1 E-.015
M204 S10000
G1 X92.647 Y81.847 Z2.52 F18000
G1 Z2.12
G1 E.3 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.419992
G1 F4800
M204 S6000
G1 X92.647 Y81.061 E.01469
G1 X87.353 Y81.054 E.09892
G1 X87.353 Y81.847 E.01482
G1 X92.587 Y81.847 E.0978
; WIPE_START
G1 X90.587 Y81.847 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X87.749 Y81.451 Z2.52 F18000
G1 Z2.12
G1 E.3 F1800
; LINE_WIDTH: 0.421112
G1 F4800
M204 S6000
G1 X92.194 Y81.454 E.08329
; WIPE_START
G1 X90.194 Y81.453 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X92.647 Y88.153 Z2.52 F18000
G1 Z2.12
G1 E.3 F1800
; LINE_WIDTH: 0.419992
G1 F4800
M204 S6000
G1 X87.353 Y88.153 E.09893
G1 X87.353 Y88.947 E.01485
G1 X92.647 Y88.947 E.09893
G1 X92.647 Y88.213 E.01373
; WIPE_START
G1 X92.647 Y88.947 E-.10468
G1 X91.382 Y88.947 E-.18032
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X87.75 Y88.55 Z2.52 F18000
G1 Z2.12
G1 E.3 F1800
; LINE_WIDTH: 0.426072
G1 F4800
M204 S6000
G1 X92.19 Y88.55 E.08424
; OBJECT_ID: 8
; WIPE_START
G1 X90.19 Y88.55 E-.285
; WIPE_END
G1 E-.015 F1800
; stop printing object, unique label id: 12
M625
; start printing object, unique label id: 8
M624 AQAAAAAAAAA=
M204 S10000
G1 X82.797 Y86.654 Z2.52 F18000
G1 X60.915 Y81.043 Z2.52
G1 Z2.12
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F3600
M204 S6000
G1 X60.915 Y83.316 E.04569
G1 X62.257 Y83.316 E.02698
G1 X62.257 Y86.684 E.06774
G1 X60.914 Y86.684 E.02699
G1 X60.914 Y88.957 E.04569
G1 X59.399 Y88.957 E.03047
G1 X59.399 Y81.043 E.15911
G1 X60.855 Y81.043 E.02928
M204 S10000
G1 X61.339 Y80.619 F18000
G1 F3600
M204 S6000
G1 X61.339 Y82.891 E.04569
G1 X62.681 Y82.891 E.02698
G1 X62.681 Y87.109 E.0848
G1 X61.338 Y87.109 E.02699
G1 X61.338 Y89.381 E.04569
G1 X58.974 Y89.381 E.04753
G1 X58.974 Y80.619 E.17617
G1 X61.279 Y80.619 E.04634
; WIPE_START
G1 X61.339 Y80.619 E-.00855
G1 X61.339 Y82.559 E-.27645
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X63.09 Y81.09 Z2.52 F18000
G1 Z2.12
G1 E.3 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
M204 S5000
G1 X63.09 Y88.91 E.14612
G1 X63.863 Y88.91 E.01445
G1 X63.864 Y89.79 E.01644
G1 X58.589 Y89.79 E.09856
G1 F2340
G1 X58.565 Y89.79 E.00045
G1 F2880
G1 X58.565 Y80.21 E.17901
G1 F2340
G1 X58.589 Y80.21 E.00045
G1 F1800
G1 X63.862 Y80.21 E.09853
G1 X63.863 Y81.09 E.01644
G1 X63.15 Y81.09 E.01332
M204 S10000
G1 X63.382 Y80.873 F18000
; FEATURE: Top surface
G1 F3600
M204 S2000
G1 X62.936 Y80.427 E.0118
G1 X62.378 Y80.427
G1 X62.873 Y80.922 E.01308
G1 X62.873 Y81.479
M73 P61 R7
G1 X61.821 Y80.427 E.02781
G1 X61.571 Y80.735
G1 X62.873 Y82.037 E.03441
G1 X62.873 Y82.594
G1 X61.571 Y81.292 E.03441
G1 X61.571 Y81.85
G1 X62.381 Y82.659 E.0214
; WIPE_START
M204 S6000
G1 X61.571 Y81.85 E-.16317
G1 X61.571 Y81.292 E-.07944
G1 X61.781 Y81.503 E-.04239
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X63.54 Y80.893 Z2.52 F18000
G1 Z2.12
G1 E.3 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.195624
G1 F2400
M204 S6000
G1 X63.581 Y80.793 E.00087
G1 X63.581 Y80.407 E.00311
; WIPE_START
G1 X63.581 Y80.793 E-.2229
G1 X63.54 Y80.893 E-.0621
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X61.042 Y84.745 Z2.52 F18000
G1 Z2.12
G1 E.3 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.454132
G1 F4800
M204 S6000
G1 X61.042 Y84.53 E.00435
G1 X60.702 Y84.53 E.00689
G1 X60.613 Y84.456 E.00236
G1 X60.613 Y85.558 E.02239
G1 X60.702 Y85.47 E.00255
G1 X61.042 Y85.47 E.00689
G1 X61.042 Y84.805 E.01351
M204 S10000
G1 X61.453 Y84.745 F18000
; LINE_WIDTH: 0.419992
G1 F4800
M204 S6000
G1 X61.453 Y84.119 E.01169
G1 X60.702 Y84.119 E.01403
G1 X60.202 Y83.699 E.01221
G1 X60.202 Y86.381 E.05012
G1 X60.702 Y85.881 E.01321
G1 X61.453 Y85.881 E.01403
G1 X61.453 Y84.805 E.02011
M204 S10000
G1 X61.847 Y84.745 F18000
G1 F4800
M204 S6000
G1 X61.847 Y83.725 E.01905
G1 X60.702 Y83.725 E.02139
; LINE_WIDTH: 0.439463
G1 X60.635 Y83.687 E.00152
; LINE_WIDTH: 0.478406
G1 X60.567 Y83.65 E.00166
; LINE_WIDTH: 0.517348
G1 X60.499 Y83.613 E.0018
; LINE_WIDTH: 0.571427
G1 X60.432 Y83.575 E.002
G1 X60.429 Y83.528 E.00123
G1 X60.43 Y81.529 E.0517
G1 X59.884 Y81.529 E.01412
G1 X59.884 Y83.528 E.0517
; LINE_WIDTH: 0.552669
G1 X59.865 Y83.801 E.00683
; LINE_WIDTH: 0.514761
G1 X59.846 Y84.074 E.00634
; LINE_WIDTH: 0.476853
G1 X59.827 Y84.346 E.00585
; LINE_WIDTH: 0.425002
G1 X59.808 Y84.619 E.00518
G1 X59.808 Y85.381 E.01441
; LINE_WIDTH: 0.438928
G1 X59.827 Y85.654 E.00536
; LINE_WIDTH: 0.476801
G1 X59.846 Y85.927 E.00585
; LINE_WIDTH: 0.514673
G1 X59.865 Y86.199 E.00634
; LINE_WIDTH: 0.570372
G1 X59.884 Y86.472 E.00706
G1 X59.884 Y88.472 E.05161
G1 X60.429 Y88.472 E.01408
G1 X60.429 Y86.472 E.05161
; LINE_WIDTH: 0.552546
G1 X60.497 Y86.423 E.0021
; LINE_WIDTH: 0.514673
G1 X60.566 Y86.374 E.00195
; LINE_WIDTH: 0.476801
G1 X60.634 Y86.325 E.0018
; LINE_WIDTH: 0.420582
G1 X60.702 Y86.275 E.00157
G1 X61.847 Y86.275 E.02143
G1 X61.847 Y84.805 E.02752
; WIPE_START
G1 X61.847 Y86.275 E-.20958
G1 X61.318 Y86.275 E-.07542
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X62.873 Y88.17 Z2.52 F18000
G1 Z2.12
G1 E.3 F1800
; FEATURE: Top surface
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X62.044 Y87.341 E.02191
G1 X61.57 Y87.425
G1 X62.873 Y88.727 E.03443
G1 X63.273 Y89.127
G1 X63.647 Y89.501 E.00989
G1 X63.161 Y89.573
G1 X61.57 Y87.982 E.04205
G1 X61.57 Y88.54
G1 X62.604 Y89.573 E.02731
G1 X62.046 Y89.573
G1 X61.57 Y89.097 E.01258
; WIPE_START
M204 S6000
G1 X62.046 Y89.573 E-.09595
G1 X62.604 Y89.573 E-.07945
G1 X62.06 Y89.029 E-.10961
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X69.086 Y88.957 Z2.52 F18000
G1 Z2.12
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F3600
M204 S6000
G1 X69.086 Y86.684 E.04569
G1 X67.743 Y86.684 E.02699
G1 X67.743 Y83.316 E.06774
G1 X69.086 Y83.316 E.02699
G1 X69.086 Y81.043 E.04569
G1 X70.601 Y81.043 E.03047
G1 X70.601 Y88.957 E.15911
G1 X69.146 Y88.957 E.02927
M204 S10000
G1 X68.662 Y89.381 F18000
G1 F3600
M204 S6000
G1 X68.662 Y87.109 E.04569
G1 X67.319 Y87.109 E.02699
G1 X67.319 Y82.891 E.0848
G1 X68.662 Y82.891 E.02699
G1 X68.662 Y80.619 E.04569
G1 X71.026 Y80.619 E.04753
G1 X71.026 Y89.381 E.17617
G1 X68.722 Y89.381 E.04633
; WIPE_START
G1 X68.669 Y87.381 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X66.91 Y88.91 Z2.52 F18000
G1 Z2.12
G1 E.3 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
M204 S5000
G1 X66.91 Y81.09 E.14612
G1 X66.137 Y81.09 E.01445
G1 X66.136 Y80.21 E.01644
G1 X71.411 Y80.21 E.09857
G1 F2340
G1 X71.435 Y80.21 E.00046
G1 F2880
G1 X71.435 Y89.79 E.17901
G1 F2340
G1 X71.411 Y89.79 E.00045
G1 F1800
G1 X66.136 Y89.79 E.09857
G1 X66.137 Y88.91 E.01644
G1 X66.85 Y88.91 E.01333
; WIPE_START
M204 S6000
G1 X66.865 Y86.91 E-.285
; WIPE_END
G1 E-.015
M204 S10000
G1 X67.619 Y87.341 Z2.52 F18000
G1 Z2.12
G1 E.3 F1800
; FEATURE: Top surface
G1 F3600
M204 S2000
G1 X68.43 Y88.151 E.02142
G1 X68.43 Y88.709
G1 X67.127 Y87.406 E.03443
G1 X67.127 Y87.963
G1 X68.43 Y89.266 E.03443
G1 X68.179 Y89.573
G1 X67.127 Y88.521 E.02781
G1 X67.127 Y89.078
G1 X67.622 Y89.573 E.01308
G1 X67.064 Y89.573
G1 X66.618 Y89.127 E.0118
M204 S10000
G1 X66.46 Y89.107 F18000
; FEATURE: Gap infill
; LINE_WIDTH: 0.196501
G1 F2400
M204 S6000
G1 X66.418 Y89.206 E.00087
G1 X66.418 Y89.593 E.00313
; WIPE_START
G1 X66.418 Y89.206 E-.22306
G1 X66.46 Y89.107 E-.06194
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X68.958 Y85.47 Z2.52 F18000
G1 Z2.12
G1 E.3 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.454142
G1 F4800
M204 S6000
G1 X69.298 Y85.47 E.0069
G1 X69.387 Y85.558 E.00254
G1 X69.387 Y84.456 E.02238
G1 X69.298 Y84.53 E.00235
G1 X68.958 Y84.53 E.0069
G1 X68.958 Y85.41 E.01785
M204 S10000
G1 X68.547 Y85.881 F18000
; LINE_WIDTH: 0.419992
G1 F4800
M204 S6000
G1 X69.298 Y85.881 E.01404
G1 X69.798 Y86.381 E.01321
G1 X69.798 Y83.699 E.05011
G1 X69.298 Y84.119 E.0122
G1 X68.547 Y84.119 E.01404
G1 X68.547 Y85.821 E.0318
M204 S10000
G1 X68.153 Y86.275 F18000
G1 F4800
M204 S6000
G1 X69.298 Y86.275 E.0214
; LINE_WIDTH: 0.438915
G1 X69.366 Y86.325 E.00165
; LINE_WIDTH: 0.47676
G1 X69.435 Y86.374 E.0018
; LINE_WIDTH: 0.514605
G1 X69.503 Y86.423 E.00195
; LINE_WIDTH: 0.571028
G1 X69.571 Y86.472 E.00217
G1 X69.571 Y88.472 E.05167
G1 X70.117 Y88.472 E.0141
G1 X70.117 Y86.472 E.05167
; LINE_WIDTH: 0.55245
G1 X70.135 Y86.2 E.00683
; LINE_WIDTH: 0.514605
G1 X70.154 Y85.927 E.00634
; LINE_WIDTH: 0.47676
G1 X70.173 Y85.654 E.00585
; LINE_WIDTH: 0.424989
G1 X70.192 Y85.381 E.00517
G1 X70.192 Y84.619 E.01442
; LINE_WIDTH: 0.439431
G1 X70.173 Y84.37 E.0049
; LINE_WIDTH: 0.478308
G1 X70.153 Y84.121 E.00536
; LINE_WIDTH: 0.517186
G1 X70.134 Y83.872 E.00582
; LINE_WIDTH: 0.570657
G1 X70.114 Y83.623 E.00645
G1 X70.117 Y81.528 E.05409
G1 X69.571 Y81.528 E.01409
G1 X69.569 Y83.575 E.05286
; LINE_WIDTH: 0.556063
G1 X69.501 Y83.613 E.00194
; LINE_WIDTH: 0.517186
G1 X69.433 Y83.65 E.0018
; LINE_WIDTH: 0.478308
G1 X69.366 Y83.687 E.00166
; LINE_WIDTH: 0.420397
G1 X69.298 Y83.725 E.00145
G1 X68.153 Y83.725 E.02142
G1 X68.153 Y86.215 E.04658
; WIPE_START
G1 X68.153 Y84.215 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X68.43 Y80.903 Z2.52 F18000
G1 Z2.12
G1 E.3 F1800
; FEATURE: Top surface
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X67.954 Y80.427 E.01259
G1 X67.396 Y80.427
G1 X68.43 Y81.461 E.02732
G1 X68.43 Y82.018
G1 X66.838 Y80.427 E.04205
G1 X66.353 Y80.499
G1 X66.727 Y80.873 E.00989
G1 X67.127 Y81.273
G1 X68.43 Y82.576 E.03443
G1 X67.956 Y82.659
G1 X67.127 Y81.83 E.02191
; CHANGE_LAYER
; Z_HEIGHT: 2.24
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F3600
M204 S6000
G1 X67.956 Y82.659 E-.16708
G1 X68.43 Y82.576 E-.06858
G1 X68.185 Y82.331 E-.04935
; WIPE_END
G1 E-.015 F1800
; stop printing object, unique label id: 8
M625
; layer num/total_layer_count: 18/57
; update layer progress
M73 L18
M991 S0 P17 ;notify layer change
M106 S63.75
; OBJECT_ID: 16
; start printing object, unique label id: 16
M624 BAAAAAAAAAA=
M204 S10000
G17
G3 Z2.52 I-.087 J1.214 P1  F18000
G1 X111.943 Y85.457 Z2.52
G1 Z2.24
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F3600
M204 S6000
G1 X111.943 Y84.543 E.01836
G1 X120.056 Y84.543 E.16313
G1 X120.056 Y85.457 E.01836
G1 X112.003 Y85.457 E.16193
; WIPE_START
G1 X111.943 Y84.543 E-.13039
G1 X113.028 Y84.543 E-.15461
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X109.69 Y85.281 Z2.64 F18000
G1 Z2.24
G1 E.3 F1800
G1 F3600
M204 S6000
G1 X109.519 Y85.281 E.00343
G1 X109.519 Y84.719 E.01129
G1 X111.519 Y84.719 E.04021
G1 X111.519 Y84.119 E.01206
G1 X120.481 Y84.119 E.18019
G1 X120.481 Y85.881 E.03542
G1 X111.519 Y85.881 E.18019
G1 X111.519 Y85.281 E.01206
G1 X109.75 Y85.281 E.03557
; WIPE_START
G1 X109.519 Y85.281 E-.03288
G1 X109.519 Y84.719 E-.08002
G1 X110.727 Y84.719 E-.1721
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X109.69 Y86.29 Z2.64 F18000
G1 Z2.24
G1 E.3 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
M204 S5000
G1 X109.111 Y86.286 E.01081
G1 X109.116 Y83.711 E.04811
G1 X109.69 Y83.71 E.01073
G1 X109.69 Y84.31 E.01121
G1 X111.11 Y84.31 E.02653
G1 X111.11 Y83.71 E.01121
G1 X120.11 Y83.71 E.16817
G1 X120.113 Y81.713 E.03732
G1 X120.885 Y81.714 E.01442
G1 X120.884 Y88.289 E.12286
G1 X120.114 Y88.288 E.0144
G1 X120.11 Y86.29 E.03733
G1 X111.11 Y86.29 E.16817
G1 X111.11 Y85.69 E.01121
G1 X109.69 Y85.69 E.02653
G1 X109.69 Y86.23 E.01008
; WIPE_START
M204 S6000
G1 X109.111 Y86.286 E-.08285
G1 X109.114 Y84.867 E-.20215
; WIPE_END
G1 E-.015
M204 S10000
G17
G3 Z2.64 I1.217 J0 P1  F18000
; stop printing object, unique label id: 16
M625
; object ids of layer 18 start: 8,12,16
M624 BwAAAAAAAAA=
;===================== date: 20250206 =====================

; don't support timelapse gcode in spiral_mode and by object sequence for I3 structure printer
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
G92 E0
G1 Z2.64
G1 X0 Y85.0002 ; move to safe pos
G1 X-13.0 F3000 ; move to safe pos
M400
M1004 S5 P1  ; external shutter
M400 P300
M971 S11 C11 O0
G92 E0
G1 X0 F18000
M623

; SKIPTYPE: head_wrap_detect
M622.1 S1
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




; object ids of this layer18 end: 8,12,16
M625
; start printing object, unique label id: 16
M624 BAAAAAAAAAA=
G1 X109.4 Y84.515
G1 Z2.24
G1 E.3 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.196408
G1 F2400
M204 S6000
G1 X109.4 Y83.915 E.00485
; WIPE_START
G1 X109.4 Y84.515 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X109.4 Y86.085 Z2.64 F18000
G1 Z2.24
G1 E.3 F1800
; LINE_WIDTH: 0.196498
G1 F2400
M204 S6000
G1 X109.4 Y85.485 E.00485
M204 S10000
G1 X109.731 Y85 F18000
; LINE_WIDTH: 0.163052
G1 F2400
M204 S6000
G1 X111.731 Y85 E.01301
M204 S10000
G1 X112.156 Y85 F18000
; LINE_WIDTH: 0.514572
G1 F2400
M204 S6000
G1 X119.844 Y85 E.17813
; WIPE_START
G1 X117.844 Y85 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X120.5 Y86.085 Z2.64 F18000
G1 Z2.24
G1 E.3 F1800
; LINE_WIDTH: 0.396408
G1 F2400
M204 S6000
G1 X120.5 Y88.085 E.03513
; WIPE_START
G1 X120.5 Y86.085 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X120.5 Y83.915 Z2.64 F18000
G1 Z2.24
G1 E.3 F1800
; LINE_WIDTH: 0.396498
G1 F2400
M204 S6000
G1 X120.5 Y81.917 E.0351
; OBJECT_ID: 12
; WIPE_START
G1 X120.5 Y83.915 E-.285
; WIPE_END
G1 E-.015 F1800
; stop printing object, unique label id: 16
M625
; start printing object, unique label id: 12
M624 AgAAAAAAAAA=
M204 S10000
G1 X112.92 Y84.81 Z2.64 F18000
G1 X88.09 Y87.743 Z2.64
G1 Z2.24
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F3600
M204 S6000
G1 X87.257 Y87.743 E.01676
G1 X87.257 Y82.257 E.11033
G1 X92.743 Y82.257 E.11033
G1 X92.743 Y87.743 E.11033
G1 X88.15 Y87.743 E.09236
M204 S10000
G1 X88.09 Y87.319 F18000
G1 F3600
M204 S6000
G1 X87.681 Y87.319 E.00823
G1 X87.681 Y82.681 E.09327
G1 X92.319 Y82.681 E.09327
G1 X92.319 Y87.319 E.09327
G1 X88.15 Y87.319 E.08383
M204 S250
G1 X88.09 Y86.91 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1800
M204 S5000
G1 X88.09 Y83.09 E.07138
G1 X91.91 Y83.09 E.07138
G1 X91.91 Y86.91 E.07138
G1 X88.15 Y86.91 E.07026
; WIPE_START
M204 S6000
G1 X88.119 Y84.91 E-.285
; WIPE_END
G1 E-.015
M204 S10000
G1 X86.943 Y80.645 Z2.64 F18000
G1 Z2.24
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
M73 P62 R7
G1 F3600
M204 S6000
G1 X93.056 Y80.652 E.12291
G1 X93.057 Y89.357 E.17502
G1 X86.943 Y89.357 E.12292
G1 X86.943 Y80.705 E.17397
M204 S10000
G1 X86.519 Y80.22 F18000
G1 F3600
M204 S6000
G1 X93.48 Y80.229 E.13997
G1 X93.481 Y89.781 E.19207
G1 X86.519 Y89.781 E.13998
G1 X86.519 Y80.28 E.19104
M204 S250
G1 X86.269 Y79.844 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1800
M204 S5000
G1 X86.397 Y79.81 E.00247
G1 X93.666 Y79.82 E.13583
G1 X93.802 Y79.898 E.00293
G1 X93.865 Y79.993 E.00213
G1 X93.89 Y80.103 E.00212
G1 X93.89 Y89.883 E.18275
G1 X93.873 Y89.989 E.002
G1 X93.831 Y90.073 E.00176
G1 X93.731 Y90.157 E.00244
G1 X93.588 Y90.19 E.00275
G1 X86.417 Y90.19 E.134
G1 X86.311 Y90.173 E.00199
G1 X86.227 Y90.131 E.00176
G1 X86.143 Y90.031 E.00244
G1 X86.11 Y89.888 E.00275
G1 X86.11 Y80.117 E.18258
G1 X86.127 Y80.011 E.00199
G1 X86.165 Y79.937 E.00156
G1 X86.224 Y79.884 E.00148
; WIPE_START
M204 S6000
G1 X86.397 Y79.81 E-.02678
G1 X88.209 Y79.813 E-.25822
; WIPE_END
G1 E-.015
M204 S10000
G1 X92.647 Y81.847 Z2.64 F18000
G1 Z2.24
G1 E.3 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.419992
G1 F4800
M204 S6000
G1 X92.647 Y81.061 E.01469
G1 X87.353 Y81.054 E.09892
G1 X87.353 Y81.847 E.01482
G1 X92.587 Y81.847 E.0978
; WIPE_START
G1 X90.587 Y81.847 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X87.749 Y81.451 Z2.64 F18000
G1 Z2.24
G1 E.3 F1800
; LINE_WIDTH: 0.421122
G1 F4800
M204 S6000
G1 X92.194 Y81.454 E.08329
; WIPE_START
G1 X90.194 Y81.453 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X92.647 Y88.153 Z2.64 F18000
G1 Z2.24
G1 E.3 F1800
; LINE_WIDTH: 0.419992
G1 F4800
M204 S6000
G1 X87.353 Y88.153 E.09893
G1 X87.353 Y88.947 E.01485
G1 X92.647 Y88.947 E.09893
G1 X92.647 Y88.213 E.01373
; WIPE_START
G1 X92.647 Y88.947 E-.10468
G1 X91.382 Y88.947 E-.18032
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X87.75 Y88.55 Z2.64 F18000
G1 Z2.24
G1 E.3 F1800
; LINE_WIDTH: 0.426072
G1 F4800
M204 S6000
G1 X92.19 Y88.55 E.08424
; OBJECT_ID: 8
; WIPE_START
G1 X90.19 Y88.55 E-.285
; WIPE_END
G1 E-.015 F1800
; stop printing object, unique label id: 12
M625
; start printing object, unique label id: 8
M624 AQAAAAAAAAA=
M204 S10000
G1 X82.808 Y86.609 Z2.64 F18000
G1 X61.647 Y81.043 Z2.64
G1 Z2.24
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F3600
M204 S6000
G1 X61.646 Y88.957 E.15911
G1 X59.338 Y88.957 E.04641
G1 X59.338 Y81.043 E.15911
G1 X61.587 Y81.043 E.04521
M204 S10000
G1 X62.071 Y80.619 F18000
G1 F3600
M204 S6000
G1 X62.07 Y89.381 E.17617
G1 X58.914 Y89.381 E.06347
G1 X58.914 Y80.619 E.17617
G1 X62.011 Y80.619 E.06227
M204 S250
G1 X62.48 Y80.21 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1800
M204 S5000
G1 X62.479 Y89.79 E.17901
G1 X58.524 Y89.79 E.07391
G1 F2160
G1 X58.505 Y89.79 E.00036
G1 F2700
G1 X58.505 Y80.21 E.17901
G1 F2160
G1 X58.524 Y80.21 E.00036
G1 F1800
G1 X62.42 Y80.21 E.0728
; WIPE_START
M204 S6000
G1 X62.433 Y82.21 E-.285
; WIPE_END
G1 E-.015
M204 S10000
G1 X61.237 Y82.198 Z2.64 F18000
G1 Z2.24
G1 E.3 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.419992
G1 F4800
M204 S6000
G1 X61.237 Y81.453 E.01392
G1 X59.747 Y81.453 E.02784
G1 X59.747 Y88.547 E.13256
G1 X61.237 Y88.547 E.02783
G1 X61.237 Y82.258 E.11752
M204 S10000
G1 X60.766 Y82.198 F18000
; LINE_WIDTH: 0.573517
G1 F4800
M204 S6000
G1 X60.766 Y81.924 E.00711
G1 X60.218 Y81.924 E.01422
G1 X60.218 Y88.076 E.15973
G1 X60.766 Y88.076 E.01422
G1 X60.766 Y82.258 E.15106
; WIPE_START
G1 X60.766 Y84.258 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X67.255 Y88.276 Z2.64 F18000
G1 X68.354 Y88.957 Z2.64
G1 Z2.24
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F3600
M204 S6000
G1 X68.354 Y81.043 E.15911
G1 X70.662 Y81.043 E.0464
G1 X70.662 Y88.957 E.15911
G1 X68.414 Y88.957 E.0452
M204 S10000
G1 X67.93 Y89.381 F18000
G1 F3600
M204 S6000
G1 X67.93 Y80.619 E.17617
G1 X71.086 Y80.619 E.06346
G1 X71.086 Y89.381 E.17617
G1 X67.99 Y89.381 E.06226
M204 S250
G1 X67.521 Y89.79 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1800
M204 S5000
G1 X67.521 Y80.21 E.17901
G1 X71.476 Y80.21 E.07391
G1 F2160
G1 X71.495 Y80.21 E.00036
G1 F2700
G1 X71.495 Y89.79 E.17901
G1 F2160
G1 X71.476 Y89.79 E.00036
G1 F1800
G1 X67.581 Y89.79 E.07279
; WIPE_START
M204 S6000
G1 X67.568 Y87.79 E-.285
; WIPE_END
G1 E-.015
M204 S10000
G1 X68.763 Y88.547 Z2.64 F18000
G1 Z2.24
G1 E.3 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.419992
G1 F4800
M204 S6000
G1 X70.253 Y88.547 E.02783
G1 X70.252 Y81.453 E.13256
G1 X68.763 Y81.453 E.02783
G1 X68.763 Y88.487 E.13144
M204 S10000
G1 X69.234 Y88.076 F18000
; LINE_WIDTH: 0.573247
G1 F4800
M204 S6000
G1 X69.782 Y88.076 E.01421
G1 X69.782 Y81.924 E.15966
G1 X69.234 Y81.924 E.01421
G1 X69.234 Y88.016 E.1581
; CHANGE_LAYER
; Z_HEIGHT: 2.36
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F4800
G1 X69.234 Y86.016 E-.285
; WIPE_END
G1 E-.015 F1800
; stop printing object, unique label id: 8
M625
; layer num/total_layer_count: 19/57
; update layer progress
M73 L19
M991 S0 P18 ;notify layer change
; OBJECT_ID: 16
; start printing object, unique label id: 16
M624 BAAAAAAAAAA=
M204 S10000
G17
G3 Z2.64 I.016 J1.217 P1  F18000
G1 X111.943 Y85.457 Z2.64
G1 Z2.36
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F3600
M204 S6000
G1 X111.943 Y84.543 E.01836
G1 X120.057 Y84.543 E.16313
G1 X120.057 Y85.457 E.01836
G1 X112.003 Y85.457 E.16193
; WIPE_START
G1 X111.943 Y84.543 E-.13039
G1 X113.028 Y84.543 E-.15461
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X109.69 Y85.281 Z2.76 F18000
G1 Z2.36
G1 E.3 F1800
G1 F3600
M204 S6000
G1 X109.519 Y85.281 E.00343
G1 X109.519 Y84.719 E.01129
G1 X111.519 Y84.719 E.04021
G1 X111.519 Y84.119 E.01206
G1 X120.481 Y84.119 E.18019
G1 X120.481 Y85.881 E.03542
G1 X111.519 Y85.881 E.18019
G1 X111.519 Y85.281 E.01206
G1 X109.75 Y85.281 E.03557
; WIPE_START
G1 X109.519 Y85.281 E-.03288
G1 X109.519 Y84.719 E-.08002
G1 X110.727 Y84.719 E-.1721
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X109.69 Y86.29 Z2.76 F18000
G1 Z2.36
G1 E.3 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
M204 S5000
G1 X109.111 Y86.286 E.01081
G1 X109.116 Y83.711 E.04811
G1 X109.69 Y83.71 E.01073
G1 X109.69 Y84.31 E.01121
G1 X111.11 Y84.31 E.02653
G1 X111.11 Y83.71 E.01121
G1 X120.11 Y83.71 E.16817
G1 X120.113 Y81.713 E.03732
G1 X120.886 Y81.714 E.01445
G1 X120.884 Y88.289 E.12287
G1 X120.114 Y88.287 E.01439
G1 X120.11 Y86.29 E.03732
G1 X111.11 Y86.29 E.16817
G1 X111.11 Y85.69 E.01121
G1 X109.69 Y85.69 E.02653
G1 X109.69 Y86.23 E.01008
; WIPE_START
M204 S6000
M73 P63 R7
G1 X109.111 Y86.286 E-.08286
G1 X109.114 Y84.867 E-.20214
; WIPE_END
G1 E-.015
M204 S10000
G17
G3 Z2.76 I1.217 J0 P1  F18000
; stop printing object, unique label id: 16
M625
; object ids of layer 19 start: 8,12,16
M624 BwAAAAAAAAA=
;===================== date: 20250206 =====================

; don't support timelapse gcode in spiral_mode and by object sequence for I3 structure printer
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
G92 E0
G1 Z2.76
G1 X0 Y85.0002 ; move to safe pos
G1 X-13.0 F3000 ; move to safe pos
M400
M1004 S5 P1  ; external shutter
M400 P300
M971 S11 C11 O0
G92 E0
G1 X0 F18000
M623

; SKIPTYPE: head_wrap_detect
M622.1 S1
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




; object ids of this layer19 end: 8,12,16
M625
; start printing object, unique label id: 16
M624 BAAAAAAAAAA=
G1 X109.4 Y84.515
G1 Z2.36
G1 E.3 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.196407
G1 F2400
M204 S6000
G1 X109.4 Y83.915 E.00485
; WIPE_START
G1 X109.4 Y84.515 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X109.4 Y86.085 Z2.76 F18000
G1 Z2.36
G1 E.3 F1800
; LINE_WIDTH: 0.196487
G1 F2400
M204 S6000
G1 X109.4 Y85.485 E.00485
M204 S10000
G1 X109.731 Y85 F18000
; LINE_WIDTH: 0.163052
G1 F2400
M204 S6000
G1 X111.731 Y85 E.01301
M204 S10000
G1 X112.156 Y85 F18000
; LINE_WIDTH: 0.514572
G1 F2400
M204 S6000
G1 X119.844 Y85 E.17813
; WIPE_START
G1 X117.844 Y85 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X120.5 Y86.085 Z2.76 F18000
G1 Z2.36
G1 E.3 F1800
; LINE_WIDTH: 0.396522
G1 F2400
M204 S6000
G1 X120.5 Y88.085 E.03514
; WIPE_START
G1 X120.5 Y86.085 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X120.5 Y83.915 Z2.76 F18000
G1 Z2.36
G1 E.3 F1800
G1 F2400
M204 S6000
G1 X120.5 Y81.917 E.0351
; OBJECT_ID: 12
; WIPE_START
G1 X120.5 Y83.915 E-.285
; WIPE_END
G1 E-.015 F1800
; stop printing object, unique label id: 16
M625
; start printing object, unique label id: 12
M624 AgAAAAAAAAA=
M204 S10000
G1 X112.92 Y84.81 Z2.76 F18000
G1 X88.09 Y87.743 Z2.76
G1 Z2.36
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F3600
M204 S6000
G1 X87.257 Y87.743 E.01676
G1 X87.257 Y82.257 E.11033
G1 X92.743 Y82.257 E.11033
G1 X92.743 Y87.743 E.11033
G1 X88.15 Y87.743 E.09236
M204 S10000
G1 X88.09 Y87.319 F18000
G1 F3600
M204 S6000
G1 X87.681 Y87.319 E.00823
G1 X87.681 Y82.681 E.09327
G1 X92.319 Y82.681 E.09327
G1 X92.319 Y87.319 E.09327
G1 X88.15 Y87.319 E.08383
M204 S250
G1 X88.09 Y86.91 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1800
M204 S5000
G1 X88.09 Y83.09 E.07138
G1 X91.91 Y83.09 E.07138
G1 X91.91 Y86.91 E.07138
G1 X88.15 Y86.91 E.07026
; WIPE_START
M204 S6000
G1 X88.119 Y84.91 E-.285
; WIPE_END
G1 E-.015
M204 S10000
G1 X86.943 Y80.645 Z2.76 F18000
G1 Z2.36
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F3600
M204 S6000
G1 X93.056 Y80.652 E.12291
G1 X93.057 Y89.357 E.17502
G1 X86.943 Y89.357 E.12292
G1 X86.943 Y80.705 E.17397
M204 S10000
G1 X86.519 Y80.22 F18000
G1 F3600
M204 S6000
G1 X93.48 Y80.229 E.13997
G1 X93.481 Y89.781 E.19207
G1 X86.519 Y89.781 E.13998
G1 X86.519 Y80.28 E.19104
M204 S250
G1 X86.265 Y79.845 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1800
M204 S5000
G1 X86.397 Y79.81 E.00255
G1 X93.666 Y79.82 E.13584
G1 X93.803 Y79.898 E.00295
G1 X93.862 Y79.984 E.00194
G1 X93.89 Y80.104 E.00231
G1 X93.89 Y89.883 E.18273
G1 X93.873 Y89.989 E.00199
G1 X93.831 Y90.073 E.00176
G1 X93.731 Y90.157 E.00244
G1 X93.588 Y90.19 E.00275
G1 X86.417 Y90.19 E.134
G1 X86.311 Y90.173 E.00199
G1 X86.227 Y90.131 E.00176
G1 X86.143 Y90.031 E.00244
G1 X86.11 Y89.888 E.00275
G1 X86.11 Y80.117 E.18258
G1 X86.127 Y80.011 E.00199
G1 X86.169 Y79.927 E.00176
G1 X86.22 Y79.884 E.00124
; WIPE_START
M204 S6000
G1 X86.397 Y79.81 E-.02736
G1 X88.205 Y79.813 E-.25764
; WIPE_END
G1 E-.015
M204 S10000
G1 X92.647 Y81.847 Z2.76 F18000
G1 Z2.36
G1 E.3 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.419992
G1 F4800
M204 S6000
G1 X92.647 Y81.061 E.01469
G1 X87.353 Y81.054 E.09892
G1 X87.353 Y81.847 E.01482
G1 X92.587 Y81.847 E.0978
; WIPE_START
G1 X90.587 Y81.847 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X87.749 Y81.451 Z2.76 F18000
G1 Z2.36
G1 E.3 F1800
; LINE_WIDTH: 0.421112
G1 F4800
M204 S6000
G1 X92.194 Y81.454 E.08329
; WIPE_START
G1 X90.194 Y81.453 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X92.647 Y88.153 Z2.76 F18000
G1 Z2.36
G1 E.3 F1800
; LINE_WIDTH: 0.419992
G1 F4800
M204 S6000
G1 X87.353 Y88.153 E.09893
G1 X87.353 Y88.947 E.01485
G1 X92.647 Y88.947 E.09893
G1 X92.647 Y88.213 E.01373
; WIPE_START
G1 X92.647 Y88.947 E-.10468
G1 X91.382 Y88.947 E-.18032
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X87.75 Y88.55 Z2.76 F18000
G1 Z2.36
G1 E.3 F1800
; LINE_WIDTH: 0.426072
G1 F4800
M204 S6000
G1 X92.19 Y88.55 E.08424
; OBJECT_ID: 8
; WIPE_START
G1 X90.19 Y88.55 E-.285
; WIPE_END
G1 E-.015 F1800
; stop printing object, unique label id: 12
M625
; start printing object, unique label id: 8
M624 AQAAAAAAAAA=
M204 S10000
G1 X82.789 Y86.686 Z2.76 F18000
G1 X61.183 Y81.243 Z2.76
G1 Z2.36
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F3600
M204 S6000
G1 X61.183 Y88.757 E.15107
G1 X60.855 Y88.757 E.00661
G1 X60.854 Y88.957 E.00402
G1 X59.282 Y88.957 E.03161
G1 X59.282 Y81.043 E.15911
G1 X60.858 Y81.043 E.03168
G1 X60.859 Y81.243 E.00402
G1 X61.123 Y81.243 E.00532
M204 S10000
G1 X61.608 Y80.819 F18000
G1 F3600
M204 S6000
G1 X61.608 Y89.181 E.16813
G1 X61.278 Y89.181 E.00664
G1 X61.277 Y89.381 E.00402
G1 X58.858 Y89.381 E.04865
G1 X58.858 Y80.619 E.17617
G1 X61.279 Y80.619 E.04868
G1 X61.28 Y80.819 E.00402
G1 X61.548 Y80.819 E.00538
M204 S250
G1 X62.017 Y80.41 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1800
M204 S5000
G1 X62.017 Y89.59 E.17153
G1 X61.686 Y89.59 E.00619
G1 X61.685 Y89.79 E.00374
G1 X58.464 Y89.79 E.06019
G1 F2160
G1 X58.448 Y89.79 E.00028
G1 F2520
G1 X58.448 Y80.21 E.17901
G1 F2160
G1 X58.464 Y80.21 E.00028
G1 F1800
G1 X61.685 Y80.21 E.06019
G1 X61.686 Y80.41 E.00374
G1 X61.957 Y80.41 E.00505
; WIPE_START
M204 S6000
G1 X61.97 Y82.41 E-.285
; WIPE_END
G1 E-.015
M204 S10000
G1 X60.774 Y81.779 Z2.76 F18000
G1 Z2.36
G1 E.3 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.419992
G1 F4800
M204 S6000
G1 X60.774 Y81.653 E.00235
G1 X60.537 Y81.619 E.00447
G1 X60.447 Y81.457 E.00346
G1 X59.691 Y81.453 E.01412
G1 X59.691 Y88.547 E.13256
G1 X60.443 Y88.544 E.01404
G1 X60.534 Y88.381 E.00349
G1 X60.774 Y88.347 E.00454
G1 X60.774 Y81.839 E.12162
; WIPE_START
G1 X60.774 Y83.839 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X60.405 Y88.05 Z2.76 F18000
G1 Z2.36
G1 E.3 F1800
; LINE_WIDTH: 0.370162
G1 F4800
M204 S6000
G1 X60.405 Y81.947 E.09963
G1 X60.169 Y81.822 E.00436
G1 X60.061 Y81.822 E.00177
G1 X60.061 Y88.178 E.10375
G1 X60.227 Y88.178 E.00271
G1 X60.348 Y88.068 E.00267
; WIPE_START
G1 X60.227 Y88.178 E-.0233
G1 X60.061 Y88.178 E-.0237
G1 X60.061 Y86.508 E-.238
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X67.453 Y88.406 Z2.76 F18000
G1 X68.817 Y88.757 Z2.76
G1 Z2.36
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F3600
M204 S6000
M73 P64 R7
G1 X68.817 Y81.243 E.15107
G1 X69.152 Y81.243 E.00674
G1 X69.151 Y81.043 E.00402
G1 X70.718 Y81.043 E.0315
G1 X70.718 Y88.957 E.15911
G1 X69.151 Y88.957 E.03151
G1 X69.152 Y88.757 E.00402
G1 X68.877 Y88.757 E.00554
M204 S10000
G1 X68.392 Y89.181 F18000
G1 F3600
M204 S6000
G1 X68.392 Y80.819 E.16813
G1 X68.726 Y80.819 E.00672
G1 X68.726 Y80.619 E.00402
G1 X71.142 Y80.619 E.04859
G1 X71.142 Y89.381 E.17617
G1 X68.726 Y89.381 E.04859
G1 X68.726 Y89.181 E.00402
G1 X68.452 Y89.181 E.00551
M204 S250
G1 X67.983 Y89.59 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1800
M204 S5000
G1 X67.983 Y80.41 E.17153
G1 X68.316 Y80.41 E.00622
G1 X68.316 Y80.21 E.00374
G1 X71.536 Y80.21 E.06018
G1 F2160
G1 X71.552 Y80.21 E.00029
G1 F2520
G1 X71.552 Y89.79 E.17901
G1 F2160
G1 X71.536 Y89.79 E.00029
G1 F1800
G1 X68.316 Y89.79 E.06018
G1 X68.316 Y89.59 E.00374
G1 X68.043 Y89.59 E.0051
; WIPE_START
M204 S6000
G1 X68.03 Y87.59 E-.285
; WIPE_END
G1 E-.015
M204 S10000
G1 X69.226 Y88.347 Z2.76 F18000
G1 Z2.36
G1 E.3 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.419992
G1 F4800
M204 S6000
G1 X69.472 Y88.379 E.00464
G1 X69.564 Y88.545 E.00354
G1 X70.309 Y88.547 E.01392
G1 X70.309 Y81.453 E.13256
G1 X69.564 Y81.455 E.01392
G1 X69.472 Y81.621 E.00354
G1 X69.226 Y81.653 E.00464
G1 X69.226 Y88.287 E.12397
; WIPE_START
G1 X69.226 Y86.287 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X69.595 Y81.954 Z2.76 F18000
G1 Z2.36
G1 E.3 F1800
; LINE_WIDTH: 0.370212
G1 F4800
M204 S6000
G1 X69.595 Y88.046 E.09947
G1 X69.84 Y88.178 E.00454
G1 X69.94 Y88.178 E.00162
G1 X69.94 Y81.822 E.10377
G1 X69.781 Y81.822 E.00258
G1 X69.653 Y81.937 E.00281
; CHANGE_LAYER
; Z_HEIGHT: 2.48
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F4800
G1 X69.781 Y81.822 E-.02457
G1 X69.94 Y81.822 E-.02253
G1 X69.94 Y83.492 E-.2379
; WIPE_END
G1 E-.015 F1800
; stop printing object, unique label id: 8
M625
; layer num/total_layer_count: 20/57
; update layer progress
M73 L20
M991 S0 P19 ;notify layer change
; OBJECT_ID: 16
; start printing object, unique label id: 16
M624 BAAAAAAAAAA=
M204 S10000
G17
G3 Z2.76 I-.057 J1.216 P1  F18000
G1 X111.943 Y85.457 Z2.76
G1 Z2.48
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F3600
M204 S6000
G1 X111.943 Y84.543 E.01836
G1 X120.057 Y84.543 E.16313
G1 X120.057 Y85.457 E.01836
G1 X112.003 Y85.457 E.16193
; WIPE_START
G1 X111.943 Y84.543 E-.13039
G1 X113.028 Y84.543 E-.15461
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X109.69 Y85.281 Z2.88 F18000
G1 Z2.48
G1 E.3 F1800
G1 F3600
M204 S6000
G1 X109.519 Y85.281 E.00343
G1 X109.519 Y84.719 E.01129
G1 X111.519 Y84.719 E.04021
G1 X111.519 Y84.119 E.01206
G1 X120.481 Y84.119 E.18019
G1 X120.481 Y85.881 E.03542
G1 X111.519 Y85.881 E.18019
G1 X111.519 Y85.281 E.01206
G1 X109.75 Y85.281 E.03557
; WIPE_START
G1 X109.519 Y85.281 E-.03288
G1 X109.519 Y84.719 E-.08002
G1 X110.727 Y84.719 E-.1721
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X109.69 Y86.29 Z2.88 F18000
G1 Z2.48
G1 E.3 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
M204 S5000
G1 X109.111 Y86.286 E.01081
G1 X109.116 Y83.711 E.04812
G1 X109.69 Y83.71 E.01073
G1 X109.69 Y84.31 E.01121
G1 X111.11 Y84.31 E.02653
G1 X111.11 Y83.71 E.01121
G1 X120.11 Y83.71 E.16817
G1 X120.113 Y81.712 E.03734
G1 X120.886 Y81.714 E.01445
G1 X120.884 Y88.289 E.12287
G1 X120.114 Y88.288 E.01439
G1 X120.11 Y86.29 E.03733
G1 X111.11 Y86.29 E.16817
G1 X111.11 Y85.69 E.01121
G1 X109.69 Y85.69 E.02653
G1 X109.69 Y86.23 E.01008
; WIPE_START
M204 S6000
G1 X109.111 Y86.286 E-.08285
G1 X109.114 Y84.867 E-.20215
; WIPE_END
G1 E-.015
M204 S10000
G17
G3 Z2.88 I1.217 J0 P1  F18000
; stop printing object, unique label id: 16
M625
; object ids of layer 20 start: 8,12,16
M624 BwAAAAAAAAA=
;===================== date: 20250206 =====================

; don't support timelapse gcode in spiral_mode and by object sequence for I3 structure printer
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
G92 E0
G1 Z2.88
G1 X0 Y85.0002 ; move to safe pos
G1 X-13.0 F3000 ; move to safe pos
M400
M1004 S5 P1  ; external shutter
M400 P300
M971 S11 C11 O0
G92 E0
G1 X0 F18000
M623

; SKIPTYPE: head_wrap_detect
M622.1 S1
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




; object ids of this layer20 end: 8,12,16
M625
; start printing object, unique label id: 16
M624 BAAAAAAAAAA=
G1 X109.4 Y84.515
G1 Z2.48
G1 E.3 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.196407
G1 F2400
M204 S6000
G1 X109.4 Y83.915 E.00485
; WIPE_START
G1 X109.4 Y84.515 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X109.4 Y86.085 Z2.88 F18000
G1 Z2.48
G1 E.3 F1800
; LINE_WIDTH: 0.196487
G1 F2400
M204 S6000
G1 X109.4 Y85.485 E.00485
M204 S10000
G1 X109.731 Y85 F18000
; LINE_WIDTH: 0.163052
G1 F2400
M204 S6000
G1 X111.731 Y85 E.01301
M204 S10000
G1 X112.156 Y85 F18000
; LINE_WIDTH: 0.514572
G1 F2400
M204 S6000
G1 X119.844 Y85 E.17813
; WIPE_START
G1 X117.844 Y85 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X120.5 Y86.085 Z2.88 F18000
G1 Z2.48
G1 E.3 F1800
; LINE_WIDTH: 0.396522
G1 F2400
M204 S6000
G1 X120.5 Y88.085 E.03514
; WIPE_START
G1 X120.5 Y86.085 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X120.5 Y83.915 Z2.88 F18000
G1 Z2.48
G1 E.3 F1800
G1 F2400
M204 S6000
G1 X120.5 Y81.917 E.0351
; OBJECT_ID: 12
; WIPE_START
G1 X120.5 Y83.915 E-.285
; WIPE_END
G1 E-.015 F1800
; stop printing object, unique label id: 16
M625
; start printing object, unique label id: 12
M624 AgAAAAAAAAA=
M204 S10000
G1 X112.92 Y84.81 Z2.88 F18000
G1 X88.09 Y87.743 Z2.88
G1 Z2.48
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F3600
M204 S6000
G1 X87.257 Y87.743 E.01676
G1 X87.257 Y82.257 E.11033
G1 X92.743 Y82.257 E.11033
G1 X92.743 Y87.743 E.11033
G1 X88.15 Y87.743 E.09236
M204 S10000
G1 X88.09 Y87.319 F18000
G1 F3600
M204 S6000
G1 X87.681 Y87.319 E.00823
G1 X87.681 Y82.681 E.09327
G1 X92.319 Y82.681 E.09327
G1 X92.319 Y87.319 E.09327
G1 X88.15 Y87.319 E.08383
M204 S250
G1 X88.09 Y86.91 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1800
M204 S5000
G1 X88.09 Y83.09 E.07138
G1 X91.91 Y83.09 E.07138
G1 X91.91 Y86.91 E.07138
G1 X88.15 Y86.91 E.07026
; WIPE_START
M204 S6000
G1 X88.119 Y84.91 E-.285
; WIPE_END
G1 E-.015
M204 S10000
G1 X86.943 Y80.645 Z2.88 F18000
G1 Z2.48
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F3600
M204 S6000
G1 X93.056 Y80.652 E.12291
G1 X93.057 Y89.357 E.17502
G1 X86.943 Y89.357 E.12292
G1 X86.943 Y80.705 E.17397
M204 S10000
G1 X86.519 Y80.22 F18000
G1 F3600
M204 S6000
G1 X93.48 Y80.229 E.13997
G1 X93.481 Y89.781 E.19207
G1 X86.519 Y89.781 E.13998
G1 X86.519 Y80.28 E.19104
M204 S250
G1 X86.269 Y79.844 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1800
M204 S5000
G1 X86.397 Y79.81 E.00247
G1 X93.656 Y79.82 E.13564
G1 X93.796 Y79.889 E.00293
G1 X93.865 Y79.992 E.00233
G1 X93.89 Y80.103 E.00212
G1 X93.89 Y89.883 E.18275
G1 X93.873 Y89.989 E.00199
G1 X93.831 Y90.073 E.00176
G1 X93.731 Y90.157 E.00244
G1 X93.588 Y90.19 E.00275
G1 X86.417 Y90.19 E.134
G1 X86.311 Y90.173 E.00199
G1 X86.227 Y90.131 E.00176
G1 X86.143 Y90.031 E.00244
G1 X86.11 Y89.888 E.00275
G1 X86.11 Y80.117 E.18258
G1 X86.127 Y80.011 E.00199
G1 X86.165 Y79.937 E.00156
G1 X86.224 Y79.884 E.00148
; WIPE_START
M204 S6000
G1 X86.397 Y79.81 E-.02678
G1 X88.209 Y79.813 E-.25822
; WIPE_END
G1 E-.015
M204 S10000
G1 X92.647 Y81.847 Z2.88 F18000
G1 Z2.48
G1 E.3 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.419992
G1 F4800
M204 S6000
G1 X92.647 Y81.061 E.01469
G1 X87.353 Y81.054 E.09892
G1 X87.353 Y81.847 E.01482
G1 X92.587 Y81.847 E.0978
; WIPE_START
G1 X90.587 Y81.847 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X87.749 Y81.451 Z2.88 F18000
G1 Z2.48
G1 E.3 F1800
; LINE_WIDTH: 0.421112
G1 F4800
M204 S6000
G1 X92.194 Y81.454 E.08329
; WIPE_START
G1 X90.194 Y81.453 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X92.647 Y88.153 Z2.88 F18000
G1 Z2.48
G1 E.3 F1800
; LINE_WIDTH: 0.419992
G1 F4800
M204 S6000
M73 P65 R7
G1 X87.353 Y88.153 E.09893
G1 X87.353 Y88.947 E.01485
G1 X92.647 Y88.947 E.09893
G1 X92.647 Y88.213 E.01373
; WIPE_START
G1 X92.647 Y88.947 E-.10468
G1 X91.382 Y88.947 E-.18032
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X87.75 Y88.55 Z2.88 F18000
G1 Z2.48
G1 E.3 F1800
; LINE_WIDTH: 0.426072
G1 F4800
M204 S6000
G1 X92.19 Y88.55 E.08424
; OBJECT_ID: 8
; WIPE_START
G1 X90.19 Y88.55 E-.285
; WIPE_END
G1 E-.015 F1800
; stop printing object, unique label id: 12
M625
; start printing object, unique label id: 8
M624 AQAAAAAAAAA=
M204 S10000
G1 X82.558 Y88.624 Z2.88 F18000
M73 P65 R6
G1 X68.854 Y88.757 Z2.88
G1 Z2.48
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F3600
M204 S6000
G1 X68.854 Y81.243 E.15107
G1 X69.756 Y81.243 E.01812
G1 X69.756 Y81.043 E.00402
G1 X70.771 Y81.043 E.0204
G1 X70.77 Y88.957 E.15911
G1 X69.756 Y88.957 E.0204
G1 X69.756 Y88.757 E.00402
G1 X68.914 Y88.757 E.01692
M204 S10000
G1 X68.43 Y89.181 F18000
G1 F3600
M204 S6000
G1 X68.43 Y80.819 E.16813
G1 X69.332 Y80.819 E.01813
G1 X69.332 Y80.619 E.00402
G1 X71.195 Y80.619 E.03746
G1 X71.195 Y89.381 E.17617
G1 X69.332 Y89.381 E.03746
G1 X69.332 Y89.181 E.00402
G1 X68.49 Y89.181 E.01692
M204 S250
G1 X68.021 Y89.59 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1800
M204 S5000
G1 X68.021 Y80.41 E.17153
G1 X68.922 Y80.41 E.01684
G1 X68.922 Y80.21 E.00374
G1 X71.593 Y80.21 E.04989
G1 F1980
G1 X71.604 Y80.21 E.00021
G1 F2340
G1 X71.604 Y89.79 E.17901
G1 F1980
G1 X71.593 Y89.79 E.00021
G1 F1800
G1 X68.922 Y89.79 E.04989
G1 X68.922 Y89.59 E.00374
G1 X68.081 Y89.59 E.01572
; WIPE_START
M204 S6000
G1 X68.068 Y87.59 E-.285
; WIPE_END
G1 E-.015
M204 S10000
G1 X69.264 Y88.347 Z2.88 F18000
G1 Z2.48
G1 E.3 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.419992
G1 F4800
M204 S6000
G1 X69.559 Y88.347 E.00551
G1 X69.573 Y88.246 E.0019
G1 X69.756 Y88.122 E.00413
G1 X70.361 Y88.122 E.01131
G1 X70.361 Y81.878 E.11668
G1 X69.756 Y81.878 E.01131
G1 X69.573 Y81.754 E.00413
G1 X69.531 Y81.653 E.00204
G1 X69.264 Y81.653 E.00499
G1 X69.264 Y88.287 E.12397
M204 S10000
G1 X69.637 Y87.574 F18000
; LINE_WIDTH: 0.377422
G1 F4800
M204 S6000
G1 X69.637 Y87.83 E.00428
G1 X69.812 Y87.749 E.00323
G1 X69.988 Y87.749 E.00293
G1 X69.988 Y82.251 E.09165
G1 X69.756 Y82.251 E.00388
G1 X69.637 Y82.17 E.0024
G1 X69.637 Y87.514 E.08907
; WIPE_START
G1 X69.637 Y85.514 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X69.968 Y88.644 Z2.88 F18000
G1 Z2.48
G1 E.3 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.225652
G1 F2400
M204 S6000
G1 X70.558 Y88.644 E.00559
; WIPE_START
G1 X69.968 Y88.644 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X70.558 Y81.356 Z2.88 F18000
G1 Z2.48
G1 E.3 F1800
G1 F2400
M204 S6000
G1 X69.968 Y81.356 E.00559
; WIPE_START
G1 X70.558 Y81.356 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X62.926 Y81.265 Z2.88 F18000
G1 X61.146 Y81.243 Z2.88
G1 Z2.48
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F3600
M204 S6000
G1 X61.146 Y88.757 E.15107
G1 X60.243 Y88.757 E.01814
G1 X60.244 Y88.957 E.00402
G1 X59.23 Y88.957 E.02039
G1 X59.23 Y81.043 E.15911
G1 X60.248 Y81.043 E.02047
G1 X60.249 Y81.243 E.00402
G1 X61.086 Y81.243 E.01683
M204 S10000
G1 X61.57 Y80.819 F18000
G1 F3600
M204 S6000
G1 X61.57 Y89.181 E.16813
G1 X60.668 Y89.181 E.01813
G1 X60.668 Y89.381 E.00402
G1 X58.805 Y89.381 E.03745
G1 X58.805 Y80.619 E.17617
G1 X60.67 Y80.619 E.0375
G1 X60.671 Y80.819 E.00402
G1 X61.51 Y80.819 E.01687
M204 S250
G1 X61.979 Y80.41 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1800
M204 S5000
G1 X61.979 Y89.59 E.17153
G1 X61.077 Y89.59 E.01685
G1 X61.078 Y89.79 E.00374
G1 X58.407 Y89.79 E.04989
G1 F1980
G1 X58.396 Y89.79 E.00021
G1 F2340
G1 X58.396 Y80.21 E.17901
G1 F1980
G1 X58.407 Y80.21 E.00021
G1 F1800
G1 X61.078 Y80.21 E.04989
G1 X61.079 Y80.41 E.00374
G1 X61.919 Y80.41 E.01571
; WIPE_START
M204 S6000
G1 X61.932 Y82.41 E-.285
; WIPE_END
G1 E-.015
M204 S10000
G1 X60.736 Y81.81 Z2.88 F18000
G1 Z2.48
G1 E.3 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.419992
G1 F4800
M204 S6000
G1 X60.736 Y81.653 E.00294
G1 X60.446 Y81.653 E.00542
G1 X60.433 Y81.753 E.00188
G1 X60.249 Y81.878 E.00415
G1 X59.639 Y81.878 E.0114
G1 X59.639 Y88.122 E.11668
G1 X60.243 Y88.122 E.0113
G1 X60.426 Y88.246 E.00413
G1 X60.468 Y88.347 E.00204
G1 X60.736 Y88.347 E.00501
G1 X60.736 Y81.87 E.12103
M204 S10000
G1 X60.363 Y82.173 F18000
; LINE_WIDTH: 0.377402
G1 F4800
M204 S6000
G1 X60.188 Y82.251 E.00321
G1 X60.012 Y82.251 E.00293
G1 X60.012 Y87.749 E.09165
G1 X60.243 Y87.749 E.00386
G1 X60.363 Y87.831 E.00242
G1 X60.363 Y82.233 E.0933
M204 S10000
G1 X60.037 Y81.356 F18000
; FEATURE: Gap infill
; LINE_WIDTH: 0.225652
G1 F2400
M204 S6000
G1 X59.442 Y81.356 E.00564
; WIPE_START
G1 X60.037 Y81.356 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X59.442 Y88.644 Z2.88 F18000
G1 Z2.48
G1 E.3 F1800
G1 F2400
M204 S6000
G1 X60.031 Y88.644 E.00559
; CHANGE_LAYER
; Z_HEIGHT: 2.6
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F2400
G1 X59.442 Y88.644 E-.285
; WIPE_END
G1 E-.015 F1800
; stop printing object, unique label id: 8
M625
; layer num/total_layer_count: 21/57
; update layer progress
M73 L21
M991 S0 P20 ;notify layer change
; OBJECT_ID: 16
; start printing object, unique label id: 16
M624 BAAAAAAAAAA=
M204 S10000
G17
G3 Z2.88 I.074 J1.215 P1  F18000
G1 X111.943 Y85.457 Z2.88
G1 Z2.6
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F3600
M204 S6000
G1 X111.943 Y84.543 E.01836
G1 X120.057 Y84.543 E.16313
G1 X120.057 Y85.457 E.01836
G1 X112.003 Y85.457 E.16193
; WIPE_START
G1 X111.943 Y84.543 E-.13039
G1 X113.028 Y84.543 E-.15461
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X109.69 Y85.281 Z3 F18000
G1 Z2.6
G1 E.3 F1800
G1 F3600
M204 S6000
G1 X109.519 Y85.281 E.00343
G1 X109.519 Y84.719 E.01129
G1 X111.519 Y84.719 E.04021
G1 X111.519 Y84.119 E.01206
G1 X120.481 Y84.119 E.18019
G1 X120.481 Y85.881 E.03542
G1 X111.519 Y85.881 E.18019
G1 X111.519 Y85.281 E.01206
G1 X109.75 Y85.281 E.03557
; WIPE_START
G1 X109.519 Y85.281 E-.03288
G1 X109.519 Y84.719 E-.08002
G1 X110.727 Y84.719 E-.1721
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X109.69 Y86.29 Z3 F18000
G1 Z2.6
G1 E.3 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
M204 S5000
G1 X109.111 Y86.286 E.01081
G1 X109.116 Y83.711 E.04812
G1 X109.69 Y83.71 E.01073
G1 X109.69 Y84.31 E.01121
G1 X111.11 Y84.31 E.02653
G1 X111.11 Y83.71 E.01121
G1 X120.11 Y83.71 E.16817
G1 X120.113 Y81.712 E.03734
G1 X120.889 Y81.715 E.0145
G1 X120.884 Y88.289 E.12284
G1 X120.114 Y88.287 E.01439
G1 X120.11 Y86.29 E.03732
G1 X111.11 Y86.29 E.16817
G1 X111.11 Y85.69 E.01121
G1 X109.69 Y85.69 E.02653
G1 X109.69 Y86.23 E.01008
; WIPE_START
M204 S6000
G1 X109.111 Y86.286 E-.08285
G1 X109.114 Y84.868 E-.20215
; WIPE_END
G1 E-.015
M204 S10000
G17
G3 Z3 I1.217 J0 P1  F18000
; stop printing object, unique label id: 16
M625
; object ids of layer 21 start: 8,12,16
M624 BwAAAAAAAAA=
;===================== date: 20250206 =====================

; don't support timelapse gcode in spiral_mode and by object sequence for I3 structure printer
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
G92 E0
G1 Z3
G1 X0 Y85.0002 ; move to safe pos
G1 X-13.0 F3000 ; move to safe pos
M400
M1004 S5 P1  ; external shutter
M400 P300
M971 S11 C11 O0
G92 E0
G1 X0 F18000
M623

; SKIPTYPE: head_wrap_detect
M622.1 S1
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




; object ids of this layer21 end: 8,12,16
M625
; start printing object, unique label id: 16
M624 BAAAAAAAAAA=
G1 X109.4 Y84.515
G1 Z2.6
G1 E.3 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.196407
G1 F2400
M204 S6000
G1 X109.4 Y83.915 E.00485
; WIPE_START
G1 X109.4 Y84.515 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X109.4 Y86.085 Z3 F18000
G1 Z2.6
G1 E.3 F1800
; LINE_WIDTH: 0.196487
G1 F2400
M204 S6000
G1 X109.4 Y85.485 E.00485
M204 S10000
G1 X109.731 Y85 F18000
; LINE_WIDTH: 0.163052
G1 F2400
M204 S6000
G1 X111.731 Y85 E.01301
M204 S10000
G1 X112.156 Y85 F18000
; LINE_WIDTH: 0.514572
G1 F2400
M204 S6000
G1 X119.844 Y85 E.17813
; WIPE_START
G1 X117.844 Y85 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X120.5 Y86.085 Z3 F18000
G1 Z2.6
G1 E.3 F1800
; LINE_WIDTH: 0.396522
G1 F2400
M204 S6000
G1 X120.5 Y88.085 E.03514
; WIPE_START
G1 X120.5 Y86.085 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X120.5 Y83.915 Z3 F18000
G1 Z2.6
G1 E.3 F1800
G1 F2400
M204 S6000
G1 X120.5 Y81.918 E.03508
; OBJECT_ID: 12
; WIPE_START
G1 X120.5 Y83.915 E-.285
; WIPE_END
G1 E-.015 F1800
; stop printing object, unique label id: 16
M625
; start printing object, unique label id: 12
M624 AgAAAAAAAAA=
M204 S10000
G1 X112.92 Y84.81 Z3 F18000
G1 X88.09 Y87.743 Z3
G1 Z2.6
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F3600
M204 S6000
G1 X87.257 Y87.743 E.01676
G1 X87.257 Y82.257 E.11033
G1 X92.743 Y82.257 E.11033
G1 X92.743 Y87.743 E.11033
G1 X88.15 Y87.743 E.09236
M204 S10000
G1 X88.09 Y87.319 F18000
G1 F3600
M204 S6000
G1 X87.681 Y87.319 E.00823
G1 X87.681 Y82.681 E.09327
G1 X92.319 Y82.681 E.09327
G1 X92.319 Y87.319 E.09327
G1 X88.15 Y87.319 E.08383
M204 S250
G1 X88.09 Y86.91 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1800
M204 S5000
G1 X88.09 Y83.09 E.07138
M73 P66 R6
G1 X91.91 Y83.09 E.07138
G1 X91.91 Y86.91 E.07138
G1 X88.15 Y86.91 E.07026
; WIPE_START
M204 S6000
G1 X88.119 Y84.91 E-.285
; WIPE_END
G1 E-.015
M204 S10000
G1 X86.943 Y80.645 Z3 F18000
G1 Z2.6
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F3600
M204 S6000
G1 X93.056 Y80.652 E.12291
G1 X93.057 Y89.357 E.17502
G1 X86.943 Y89.357 E.12292
G1 X86.943 Y80.705 E.17397
M204 S10000
G1 X86.519 Y80.22 F18000
G1 F3600
M204 S6000
G1 X93.48 Y80.229 E.13997
G1 X93.481 Y89.781 E.19207
G1 X86.519 Y89.781 E.13998
G1 X86.519 Y80.28 E.19104
M204 S250
G1 X86.266 Y79.844 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1800
M204 S5000
G1 X86.397 Y79.81 E.00253
G1 X93.666 Y79.82 E.13583
G1 X93.802 Y79.898 E.00293
G1 X93.865 Y79.992 E.00213
G1 X93.89 Y80.103 E.00212
G1 X93.89 Y89.883 E.18275
G1 X93.873 Y89.989 E.00199
G1 X93.831 Y90.073 E.00176
G1 X93.731 Y90.157 E.00244
G1 X93.588 Y90.19 E.00275
G1 X86.417 Y90.19 E.134
G1 X86.311 Y90.173 E.00199
G1 X86.227 Y90.131 E.00176
G1 X86.143 Y90.031 E.00244
G1 X86.11 Y89.888 E.00275
G1 X86.11 Y80.117 E.18258
G1 X86.127 Y80.011 E.00199
G1 X86.169 Y79.927 E.00176
G1 X86.22 Y79.884 E.00125
; WIPE_START
M204 S6000
G1 X86.397 Y79.81 E-.02724
G1 X88.206 Y79.813 E-.25776
; WIPE_END
G1 E-.015
M204 S10000
G1 X92.647 Y81.847 Z3 F18000
G1 Z2.6
G1 E.3 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.419992
G1 F4800
M204 S6000
G1 X92.647 Y81.061 E.01469
G1 X87.353 Y81.054 E.09892
G1 X87.353 Y81.847 E.01482
G1 X92.587 Y81.847 E.0978
; WIPE_START
G1 X90.587 Y81.847 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X87.749 Y81.451 Z3 F18000
G1 Z2.6
G1 E.3 F1800
; LINE_WIDTH: 0.421122
G1 F4800
M204 S6000
G1 X92.194 Y81.454 E.08329
; WIPE_START
G1 X90.194 Y81.453 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X92.647 Y88.153 Z3 F18000
G1 Z2.6
G1 E.3 F1800
; LINE_WIDTH: 0.419992
G1 F4800
M204 S6000
G1 X87.353 Y88.153 E.09893
G1 X87.353 Y88.947 E.01485
G1 X92.647 Y88.947 E.09893
G1 X92.647 Y88.213 E.01373
; WIPE_START
G1 X92.647 Y88.947 E-.10468
G1 X91.382 Y88.947 E-.18032
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X87.75 Y88.55 Z3 F18000
G1 Z2.6
G1 E.3 F1800
; LINE_WIDTH: 0.426072
G1 F4800
M204 S6000
G1 X92.19 Y88.55 E.08424
; OBJECT_ID: 8
; WIPE_START
G1 X90.19 Y88.55 E-.285
; WIPE_END
G1 E-.015 F1800
; stop printing object, unique label id: 12
M625
; start printing object, unique label id: 8
M624 AQAAAAAAAAA=
M204 S10000
G1 X82.558 Y88.624 Z3 F18000
G1 X68.896 Y88.757 Z3
G1 Z2.6
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F3600
M204 S6000
G1 X68.896 Y81.243 E.15107
G1 X70.101 Y81.243 E.02422
G1 X70.101 Y81.043 E.00402
G1 X70.819 Y81.043 E.01444
G1 X70.819 Y88.957 E.15911
G1 X70.101 Y88.957 E.01444
G1 X70.101 Y88.757 E.00402
G1 X68.956 Y88.757 E.02301
M204 S10000
G1 X68.472 Y89.181 F18000
G1 F3600
M204 S6000
G1 X68.472 Y80.819 E.16813
G1 X69.677 Y80.819 E.02423
G1 X69.677 Y80.619 E.00402
G1 X71.243 Y80.619 E.03149
G1 X71.243 Y89.381 E.17617
G1 X69.677 Y89.381 E.03149
G1 X69.677 Y89.181 E.00402
G1 X68.532 Y89.181 E.02302
M204 S250
G1 X68.063 Y89.59 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1800
M204 S5000
G1 X68.063 Y80.41 E.17153
G1 X69.268 Y80.41 E.02252
G1 X69.268 Y80.21 E.00374
G1 X71.645 Y80.21 E.04441
G1 F1980
G1 X71.652 Y80.21 E.00014
G1 F2160
G1 X71.652 Y89.79 E.17901
G1 F1980
G1 X71.645 Y89.79 E.00014
G1 F1800
G1 X69.268 Y89.79 E.04441
G1 X69.268 Y89.59 E.00374
G1 X68.123 Y89.59 E.0214
; WIPE_START
M204 S6000
G1 X68.11 Y87.59 E-.285
; WIPE_END
G1 E-.015
M204 S10000
G1 X69.305 Y88.347 Z3 F18000
G1 Z2.6
G1 E.3 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.417812
G1 F4800
M204 S6000
G1 X70.313 Y88.356 E.01872
; LINE_WIDTH: 0.391708
G1 X70.46 Y88.544 E.00414
G1 X70.41 Y87.795 E.01302
; LINE_WIDTH: 0.419992
G1 X70.41 Y82.205 E.10446
; LINE_WIDTH: 0.406432
G1 X70.434 Y81.843 E.00654
; LINE_WIDTH: 0.381993
G1 X70.459 Y81.481 E.00612
G1 X70.313 Y81.641 E.00366
; LINE_WIDTH: 0.41915
G1 X69.305 Y81.653 E.01878
G1 X69.305 Y88.287 E.1237
M204 S10000
G1 X69.68 Y87.973 F18000
; LINE_WIDTH: 0.380792
G1 F4800
M204 S6000
G1 X70.035 Y87.973 E.00597
G1 X70.035 Y82.027 E.10004
G1 X69.68 Y82.027 E.00597
G1 X69.68 Y87.913 E.09903
; WIPE_START
G1 X69.68 Y85.913 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X62.977 Y82.263 Z3 F18000
G1 X61.104 Y81.243 Z3
G1 Z2.6
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F3600
M204 S6000
G1 X61.104 Y88.757 E.15107
G1 X59.9 Y88.757 E.02421
G1 X59.9 Y88.957 E.00402
G1 X59.181 Y88.957 E.01445
G1 X59.181 Y81.043 E.15911
G1 X59.901 Y81.043 E.01447
G1 X59.901 Y81.243 E.00402
G1 X61.044 Y81.243 E.02298
M204 S10000
G1 X61.528 Y80.819 F18000
G1 F3600
M204 S6000
G1 X61.528 Y89.181 E.16813
G1 X60.324 Y89.181 E.02422
G1 X60.323 Y89.381 E.00402
G1 X58.757 Y89.381 E.0315
G1 X58.757 Y80.619 E.17617
G1 X60.324 Y80.619 E.03151
G1 X60.324 Y80.819 E.00402
G1 X61.468 Y80.819 E.023
M204 S250
G1 X61.937 Y80.41 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1800
M204 S5000
G1 X61.937 Y89.59 E.17153
G1 X60.732 Y89.59 E.02252
G1 X60.732 Y89.79 E.00374
G1 X58.355 Y89.79 E.04441
G1 F1980
G1 X58.347 Y89.79 E.00015
G1 F2160
G1 X58.347 Y80.21 E.17901
G1 F1980
G1 X58.355 Y80.21 E.00015
G1 F1800
G1 X60.732 Y80.21 E.04441
G1 X60.732 Y80.41 E.00374
G1 X61.877 Y80.41 E.02139
; WIPE_START
M204 S6000
G1 X61.89 Y82.41 E-.285
; WIPE_END
G1 E-.015
M204 S10000
G1 X60.695 Y82.205 Z3 F18000
G1 Z2.6
G1 E.3 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.418184
G1 F4800
M204 S6000
G1 X60.695 Y81.653 E.01027
G1 X59.69 Y81.642 E.01869
; LINE_WIDTH: 0.391436
G1 X59.542 Y81.481 E.00377
G1 X59.59 Y82.205 E.01257
; LINE_WIDTH: 0.419992
G1 X59.59 Y87.795 E.10445
; LINE_WIDTH: 0.406432
G1 X59.565 Y88.17 E.00677
; LINE_WIDTH: 0.382737
G1 X59.541 Y88.544 E.00635
G1 X59.688 Y88.356 E.00405
; LINE_WIDTH: 0.419316
G1 X60.695 Y88.347 E.01877
G1 X60.695 Y82.265 E.11346
M204 S10000
G1 X60.32 Y82.205 F18000
; LINE_WIDTH: 0.380872
G1 F4800
M204 S6000
G1 X60.32 Y82.027 E.00299
G1 X59.965 Y82.027 E.00598
G1 X59.965 Y87.973 E.10006
G1 X60.32 Y87.973 E.00598
G1 X60.32 Y82.265 E.09607
; CHANGE_LAYER
; Z_HEIGHT: 2.72
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F4800
G1 X60.32 Y84.265 E-.285
; WIPE_END
G1 E-.015 F1800
; stop printing object, unique label id: 8
M625
; layer num/total_layer_count: 22/57
; update layer progress
M73 L22
M991 S0 P21 ;notify layer change
; OBJECT_ID: 16
; start printing object, unique label id: 16
M624 BAAAAAAAAAA=
M204 S10000
G17
G3 Z3 I-.028 J1.217 P1  F18000
G1 X111.943 Y85.457 Z3
G1 Z2.72
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F3600
M204 S6000
G1 X111.943 Y84.543 E.01836
G1 X120.057 Y84.543 E.16313
G1 X120.057 Y85.457 E.01836
G1 X112.003 Y85.457 E.16193
; WIPE_START
G1 X111.943 Y84.543 E-.13039
G1 X113.028 Y84.543 E-.15461
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X109.69 Y85.281 Z3.12 F18000
G1 Z2.72
G1 E.3 F1800
G1 F3600
M204 S6000
G1 X109.519 Y85.281 E.00343
G1 X109.519 Y84.719 E.01129
M73 P67 R6
G1 X111.519 Y84.719 E.04021
G1 X111.519 Y84.119 E.01206
G1 X120.481 Y84.119 E.18019
G1 X120.481 Y85.881 E.03542
G1 X111.519 Y85.881 E.18019
G1 X111.519 Y85.281 E.01206
G1 X109.75 Y85.281 E.03557
; WIPE_START
G1 X109.519 Y85.281 E-.03288
G1 X109.519 Y84.719 E-.08002
G1 X110.727 Y84.719 E-.1721
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X109.69 Y86.29 Z3.12 F18000
G1 Z2.72
G1 E.3 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
M204 S5000
G1 X109.111 Y86.286 E.01081
G1 X109.116 Y83.711 E.04812
G1 X109.69 Y83.71 E.01073
G1 X109.69 Y84.31 E.01121
G1 X111.11 Y84.31 E.02653
G1 X111.11 Y83.71 E.01121
G1 X120.11 Y83.71 E.16817
G1 X120.113 Y81.713 E.03732
G1 X120.886 Y81.714 E.01445
G1 X120.884 Y88.289 E.12287
G1 X120.114 Y88.288 E.01439
G1 X120.11 Y86.29 E.03734
G1 X111.11 Y86.29 E.16817
G1 X111.11 Y85.69 E.01121
G1 X109.69 Y85.69 E.02653
G1 X109.69 Y86.23 E.01008
; WIPE_START
M204 S6000
G1 X109.111 Y86.286 E-.08285
G1 X109.114 Y84.868 E-.20215
; WIPE_END
G1 E-.015
M204 S10000
G17
G3 Z3.12 I1.217 J0 P1  F18000
; stop printing object, unique label id: 16
M625
; object ids of layer 22 start: 8,12,16
M624 BwAAAAAAAAA=
;===================== date: 20250206 =====================

; don't support timelapse gcode in spiral_mode and by object sequence for I3 structure printer
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
G92 E0
G1 Z3.12
G1 X0 Y85.0002 ; move to safe pos
G1 X-13.0 F3000 ; move to safe pos
M400
M1004 S5 P1  ; external shutter
M400 P300
M971 S11 C11 O0
G92 E0
G1 X0 F18000
M623

; SKIPTYPE: head_wrap_detect
M622.1 S1
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




; object ids of this layer22 end: 8,12,16
M625
; start printing object, unique label id: 16
M624 BAAAAAAAAAA=
G1 X109.4 Y84.515
G1 Z2.72
G1 E.3 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.196407
G1 F2400
M204 S6000
G1 X109.4 Y83.915 E.00485
; WIPE_START
G1 X109.4 Y84.515 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X109.4 Y86.085 Z3.12 F18000
G1 Z2.72
G1 E.3 F1800
; LINE_WIDTH: 0.196487
G1 F2400
M204 S6000
G1 X109.4 Y85.485 E.00485
M204 S10000
G1 X109.731 Y85 F18000
; LINE_WIDTH: 0.163052
G1 F2400
M204 S6000
G1 X111.731 Y85 E.01301
M204 S10000
G1 X112.156 Y85 F18000
; LINE_WIDTH: 0.514572
G1 F2400
M204 S6000
G1 X119.844 Y85 E.17813
; WIPE_START
G1 X117.844 Y85 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X120.5 Y86.085 Z3.12 F18000
G1 Z2.72
G1 E.3 F1800
; LINE_WIDTH: 0.396522
G1 F2400
M204 S6000
G1 X120.5 Y88.085 E.03514
; WIPE_START
G1 X120.5 Y86.085 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X120.5 Y83.915 Z3.12 F18000
G1 Z2.72
G1 E.3 F1800
G1 F2400
M204 S6000
G1 X120.5 Y81.917 E.0351
; OBJECT_ID: 12
; WIPE_START
G1 X120.5 Y83.915 E-.285
; WIPE_END
G1 E-.015 F1800
; stop printing object, unique label id: 16
M625
; start printing object, unique label id: 12
M624 AgAAAAAAAAA=
M204 S10000
G1 X112.92 Y84.81 Z3.12 F18000
G1 X88.09 Y87.743 Z3.12
G1 Z2.72
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F3600
M204 S6000
G1 X87.257 Y87.743 E.01676
G1 X87.257 Y82.257 E.11033
G1 X92.743 Y82.257 E.11033
G1 X92.743 Y87.743 E.11033
G1 X88.15 Y87.743 E.09236
M204 S10000
G1 X88.09 Y87.319 F18000
G1 F3600
M204 S6000
G1 X87.681 Y87.319 E.00823
G1 X87.681 Y82.681 E.09327
G1 X92.319 Y82.681 E.09327
G1 X92.319 Y87.319 E.09327
G1 X88.15 Y87.319 E.08383
M204 S250
G1 X88.09 Y86.91 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1800
M204 S5000
G1 X88.09 Y83.09 E.07138
G1 X91.91 Y83.09 E.07138
G1 X91.91 Y86.91 E.07138
G1 X88.15 Y86.91 E.07026
; WIPE_START
M204 S6000
G1 X88.119 Y84.91 E-.285
; WIPE_END
G1 E-.015
M204 S10000
G1 X86.943 Y80.645 Z3.12 F18000
G1 Z2.72
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F3600
M204 S6000
G1 X93.056 Y80.652 E.12291
G1 X93.057 Y89.357 E.17502
G1 X86.943 Y89.357 E.12292
G1 X86.943 Y80.705 E.17397
M204 S10000
G1 X86.519 Y80.22 F18000
G1 F3600
M204 S6000
G1 X93.48 Y80.229 E.13997
G1 X93.481 Y89.781 E.19207
G1 X86.519 Y89.781 E.13998
G1 X86.519 Y80.28 E.19104
M204 S250
G1 X86.269 Y79.844 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1800
M204 S5000
G1 X86.397 Y79.81 E.00247
G1 X93.656 Y79.82 E.13564
G1 X93.796 Y79.889 E.00293
G1 X93.865 Y79.992 E.00232
G1 X93.89 Y80.103 E.00212
G1 X93.89 Y89.883 E.18275
G1 X93.873 Y89.989 E.00199
G1 X93.831 Y90.073 E.00175
G1 X93.731 Y90.157 E.00244
G1 X93.588 Y90.19 E.00275
G1 X86.417 Y90.19 E.134
G1 X86.311 Y90.173 E.00199
G1 X86.227 Y90.131 E.00176
G1 X86.143 Y90.031 E.00244
G1 X86.11 Y89.888 E.00275
G1 X86.11 Y80.117 E.18258
G1 X86.127 Y80.011 E.00199
G1 X86.165 Y79.937 E.00156
G1 X86.224 Y79.884 E.00149
; WIPE_START
M204 S6000
G1 X86.397 Y79.81 E-.02676
G1 X88.209 Y79.813 E-.25824
; WIPE_END
G1 E-.015
M204 S10000
G1 X92.647 Y81.847 Z3.12 F18000
G1 Z2.72
G1 E.3 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.419992
G1 F4800
M204 S6000
G1 X92.647 Y81.061 E.01469
G1 X87.353 Y81.054 E.09892
G1 X87.353 Y81.847 E.01482
G1 X92.587 Y81.847 E.0978
; WIPE_START
G1 X90.587 Y81.847 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X87.749 Y81.451 Z3.12 F18000
G1 Z2.72
G1 E.3 F1800
; LINE_WIDTH: 0.421112
G1 F4800
M204 S6000
G1 X92.194 Y81.454 E.08329
; WIPE_START
G1 X90.194 Y81.453 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X92.647 Y88.153 Z3.12 F18000
G1 Z2.72
G1 E.3 F1800
; LINE_WIDTH: 0.419992
G1 F4800
M204 S6000
G1 X87.353 Y88.153 E.09893
G1 X87.353 Y88.947 E.01485
G1 X92.647 Y88.947 E.09893
G1 X92.647 Y88.213 E.01373
; WIPE_START
G1 X92.647 Y88.947 E-.10468
G1 X91.382 Y88.947 E-.18032
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X87.75 Y88.55 Z3.12 F18000
G1 Z2.72
G1 E.3 F1800
; LINE_WIDTH: 0.426072
G1 F4800
M204 S6000
G1 X92.19 Y88.55 E.08424
; OBJECT_ID: 8
; WIPE_START
G1 X90.19 Y88.55 E-.285
; WIPE_END
G1 E-.015 F1800
; stop printing object, unique label id: 12
M625
; start printing object, unique label id: 8
M624 AQAAAAAAAAA=
M204 S10000
G1 X82.558 Y88.624 Z3.12 F18000
G1 X68.942 Y88.757 Z3.12
G1 Z2.72
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F3600
M204 S6000
G1 X68.942 Y81.243 E.15107
G1 X70.332 Y81.243 E.02795
G1 X70.332 Y81.043 E.00402
G1 X70.864 Y81.043 E.01071
G1 X70.864 Y88.957 E.15911
G1 X70.332 Y88.957 E.01071
G1 X70.332 Y88.757 E.00402
G1 X69.002 Y88.757 E.02675
M204 S10000
G1 X68.518 Y89.181 F18000
G1 F3600
M204 S6000
G1 X68.518 Y80.819 E.16813
G1 X69.907 Y80.819 E.02794
G1 X69.907 Y80.619 E.00402
G1 X71.289 Y80.619 E.02778
G1 X71.289 Y89.381 E.17617
G1 X69.907 Y89.381 E.02778
G1 X69.907 Y89.181 E.00402
G1 X68.578 Y89.181 E.02673
M204 S250
G1 X68.109 Y89.59 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1800
M204 S5000
G1 X68.109 Y80.41 E.17153
G1 X69.497 Y80.41 E.02595
G1 X69.497 Y80.21 E.00374
G1 X71.693 Y80.21 E.04104
G1 X71.698 Y80.21 E.00008
M73 P68 R6
G1 F1980
G1 X71.698 Y89.79 E.17901
G1 F1800
G1 X71.693 Y89.79 E.00008
G1 X69.497 Y89.79 E.04104
G1 X69.497 Y89.59 E.00374
G1 X68.169 Y89.59 E.02483
; WIPE_START
M204 S6000
G1 X68.155 Y87.59 E-.285
; WIPE_END
G1 E-.015
M204 S10000
G1 X69.351 Y88.347 Z3.12 F18000
G1 Z2.72
G1 E.3 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.419992
G1 F4800
M204 S6000
G1 X70.455 Y88.347 E.02063
G1 X70.455 Y81.653 E.12509
G1 X69.351 Y81.653 E.02063
G1 X69.351 Y88.287 E.12397
M204 S10000
G1 X69.726 Y87.973 F18000
; LINE_WIDTH: 0.380572
G1 F4800
M204 S6000
G1 X70.081 Y87.973 E.00597
G1 X70.081 Y82.027 E.09999
G1 X69.726 Y82.027 E.00597
G1 X69.726 Y87.913 E.09898
; WIPE_START
G1 X69.726 Y85.913 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X63.006 Y82.293 Z3.12 F18000
G1 X61.058 Y81.243 Z3.12
G1 Z2.72
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F3600
M204 S6000
G1 X61.058 Y88.757 E.15107
G1 X59.672 Y88.757 E.02787
G1 X59.672 Y88.957 E.00402
G1 X59.136 Y88.957 E.01078
G1 X59.136 Y81.046 E.15907
G1 X59.672 Y81.047 E.01078
G1 X59.672 Y81.243 E.00395
G1 X60.998 Y81.243 E.02666
M204 S10000
G1 X61.482 Y80.819 F18000
G1 F3600
M204 S6000
G1 X61.482 Y89.181 E.16813
G1 X60.095 Y89.181 E.02788
G1 X60.095 Y89.381 E.00402
G1 X58.711 Y89.381 E.02782
G1 X58.711 Y80.621 E.17615
G1 X60.095 Y80.623 E.02782
G1 X60.096 Y80.819 E.00394
G1 X61.422 Y80.819 E.02668
M204 S250
G1 X61.891 Y80.41 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1800
M204 S5000
G1 X61.891 Y89.59 E.17153
G1 X60.504 Y89.59 E.02593
G1 X60.503 Y89.79 E.00374
G1 X58.306 Y89.79 E.04105
G1 X58.302 Y89.79 E.00008
G1 F1980
G1 X58.302 Y80.21 E.179
G1 F1800
G1 X58.306 Y80.21 E.00008
G1 X60.504 Y80.215 E.04106
G1 X60.504 Y80.41 E.00364
G1 X61.831 Y80.41 E.02481
; WIPE_START
M204 S6000
G1 X61.845 Y82.41 E-.285
; WIPE_END
G1 E-.015
M204 S10000
G1 X60.649 Y82.205 Z3.12 F18000
G1 Z2.72
G1 E.3 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.419992
G1 F4800
M204 S6000
G1 X60.649 Y81.653 E.01031
G1 X59.545 Y81.653 E.02063
G1 X59.545 Y88.347 E.12509
G1 X60.649 Y88.347 E.02063
G1 X60.649 Y82.265 E.11366
M204 S10000
G1 X60.274 Y82.205 F18000
; LINE_WIDTH: 0.380562
G1 F4800
M204 S6000
G1 X60.274 Y82.027 E.00298
G1 X59.919 Y82.027 E.00597
G1 X59.919 Y87.973 E.09998
G1 X60.274 Y87.973 E.00597
G1 X60.274 Y82.265 E.09599
; CHANGE_LAYER
; Z_HEIGHT: 2.84
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F4800
G1 X60.274 Y84.265 E-.285
; WIPE_END
G1 E-.015 F1800
; stop printing object, unique label id: 8
M625
; layer num/total_layer_count: 23/57
; update layer progress
M73 L23
M991 S0 P22 ;notify layer change
; OBJECT_ID: 16
; start printing object, unique label id: 16
M624 BAAAAAAAAAA=
M204 S10000
G17
G3 Z3.12 I-.028 J1.217 P1  F18000
G1 X111.943 Y85.457 Z3.12
G1 Z2.84
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F3600
M204 S6000
G1 X111.943 Y84.543 E.01836
G1 X120.057 Y84.543 E.16313
G1 X120.057 Y85.457 E.01836
G1 X112.003 Y85.457 E.16193
; WIPE_START
G1 X111.943 Y84.543 E-.13039
G1 X113.028 Y84.543 E-.15461
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X109.69 Y85.281 Z3.24 F18000
G1 Z2.84
G1 E.3 F1800
G1 F3600
M204 S6000
G1 X109.519 Y85.281 E.00343
G1 X109.519 Y84.719 E.01129
G1 X111.519 Y84.719 E.04021
G1 X111.519 Y84.119 E.01206
G1 X120.481 Y84.119 E.18019
G1 X120.481 Y85.881 E.03542
G1 X111.519 Y85.881 E.18019
G1 X111.519 Y85.281 E.01206
G1 X109.75 Y85.281 E.03557
; WIPE_START
G1 X109.519 Y85.281 E-.03288
G1 X109.519 Y84.719 E-.08002
G1 X110.727 Y84.719 E-.1721
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X109.69 Y86.29 Z3.24 F18000
G1 Z2.84
G1 E.3 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
M204 S5000
G1 X109.111 Y86.286 E.01081
G1 X109.116 Y83.711 E.04812
G1 X109.69 Y83.71 E.01073
G1 X109.69 Y84.31 E.01121
G1 X111.11 Y84.31 E.02653
G1 X111.11 Y83.71 E.01121
G1 X120.11 Y83.71 E.16817
G1 X120.113 Y81.712 E.03734
G1 X120.885 Y81.714 E.01442
G1 X120.884 Y88.289 E.12287
G1 X120.114 Y88.288 E.01439
G1 X120.11 Y86.29 E.03734
G1 X111.11 Y86.29 E.16817
G1 X111.11 Y85.69 E.01121
G1 X109.69 Y85.69 E.02653
G1 X109.69 Y86.23 E.01008
; WIPE_START
M204 S6000
G1 X109.111 Y86.286 E-.08285
G1 X109.114 Y84.868 E-.20215
; WIPE_END
G1 E-.015
M204 S10000
G17
G3 Z3.24 I1.217 J0 P1  F18000
; stop printing object, unique label id: 16
M625
; object ids of layer 23 start: 8,12,16
M624 BwAAAAAAAAA=
;===================== date: 20250206 =====================

; don't support timelapse gcode in spiral_mode and by object sequence for I3 structure printer
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
G92 E0
G1 Z3.24
G1 X0 Y85.0002 ; move to safe pos
G1 X-13.0 F3000 ; move to safe pos
M400
M1004 S5 P1  ; external shutter
M400 P300
M971 S11 C11 O0
G92 E0
G1 X0 F18000
M623

; SKIPTYPE: head_wrap_detect
M622.1 S1
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




; object ids of this layer23 end: 8,12,16
M625
; start printing object, unique label id: 16
M624 BAAAAAAAAAA=
G1 X109.4 Y84.515
G1 Z2.84
G1 E.3 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.196407
G1 F2400
M204 S6000
G1 X109.4 Y83.915 E.00485
; WIPE_START
G1 X109.4 Y84.515 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X109.4 Y86.085 Z3.24 F18000
G1 Z2.84
G1 E.3 F1800
; LINE_WIDTH: 0.196487
G1 F2400
M204 S6000
G1 X109.4 Y85.485 E.00485
M204 S10000
G1 X109.731 Y85 F18000
; LINE_WIDTH: 0.163052
G1 F2400
M204 S6000
G1 X111.731 Y85 E.01301
M204 S10000
G1 X112.156 Y85 F18000
; LINE_WIDTH: 0.514572
G1 F2400
M204 S6000
G1 X119.844 Y85 E.17813
; WIPE_START
G1 X117.844 Y85 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X120.5 Y86.085 Z3.24 F18000
G1 Z2.84
G1 E.3 F1800
; LINE_WIDTH: 0.396522
G1 F2400
M204 S6000
G1 X120.5 Y88.085 E.03514
; WIPE_START
G1 X120.5 Y86.085 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X120.5 Y83.915 Z3.24 F18000
G1 Z2.84
G1 E.3 F1800
G1 F2400
M204 S6000
G1 X120.5 Y81.917 E.0351
; OBJECT_ID: 12
; WIPE_START
G1 X120.5 Y83.915 E-.285
; WIPE_END
G1 E-.015 F1800
; stop printing object, unique label id: 16
M625
; start printing object, unique label id: 12
M624 AgAAAAAAAAA=
M204 S10000
G1 X112.92 Y84.81 Z3.24 F18000
G1 X88.09 Y87.743 Z3.24
G1 Z2.84
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F3600
M204 S6000
G1 X87.257 Y87.743 E.01676
G1 X87.257 Y82.257 E.11033
G1 X92.743 Y82.257 E.11033
G1 X92.743 Y87.743 E.11033
G1 X88.15 Y87.743 E.09236
M204 S10000
G1 X88.09 Y87.319 F18000
G1 F3600
M204 S6000
G1 X87.681 Y87.319 E.00823
G1 X87.681 Y82.681 E.09327
G1 X92.319 Y82.681 E.09327
G1 X92.319 Y87.319 E.09327
G1 X88.15 Y87.319 E.08383
M204 S250
G1 X88.09 Y86.91 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1800
M204 S5000
G1 X88.09 Y83.09 E.07138
G1 X91.91 Y83.09 E.07138
G1 X91.91 Y86.91 E.07138
G1 X88.15 Y86.91 E.07026
; WIPE_START
M204 S6000
G1 X88.119 Y84.91 E-.285
; WIPE_END
G1 E-.015
M204 S10000
G1 X86.943 Y80.645 Z3.24 F18000
G1 Z2.84
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F3600
M204 S6000
G1 X93.056 Y80.652 E.12291
G1 X93.057 Y89.357 E.17502
G1 X86.943 Y89.357 E.12292
G1 X86.943 Y80.705 E.17397
M204 S10000
G1 X86.519 Y80.22 F18000
G1 F3600
M204 S6000
G1 X93.48 Y80.229 E.13997
G1 X93.481 Y89.781 E.19207
G1 X86.519 Y89.781 E.13998
G1 X86.519 Y80.28 E.19104
M204 S250
G1 X86.267 Y79.844 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1800
M204 S5000
M73 P69 R6
G1 X86.397 Y79.81 E.00251
G1 X93.656 Y79.82 E.13564
G1 X93.797 Y79.89 E.00295
G1 X93.861 Y79.983 E.0021
G1 X93.89 Y80.105 E.00234
G1 X93.89 Y89.883 E.18272
G1 X93.873 Y89.989 E.00199
G1 X93.831 Y90.073 E.00176
G1 X93.731 Y90.157 E.00244
G1 X93.588 Y90.19 E.00275
G1 X86.417 Y90.19 E.13399
G1 X86.311 Y90.173 E.00199
G1 X86.227 Y90.131 E.00176
G1 X86.143 Y90.031 E.00244
G1 X86.11 Y89.888 E.00275
G1 X86.11 Y80.117 E.18258
G1 X86.127 Y80.011 E.00199
G1 X86.169 Y79.927 E.00176
G1 X86.221 Y79.883 E.00127
; WIPE_START
M204 S6000
G1 X86.397 Y79.81 E-.0271
G1 X88.207 Y79.813 E-.2579
; WIPE_END
G1 E-.015
M204 S10000
G1 X92.647 Y81.847 Z3.24 F18000
G1 Z2.84
G1 E.3 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.419992
G1 F4800
M204 S6000
G1 X92.647 Y81.061 E.01469
G1 X87.353 Y81.054 E.09892
G1 X87.353 Y81.847 E.01482
G1 X92.587 Y81.847 E.0978
; WIPE_START
G1 X90.587 Y81.847 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X87.749 Y81.451 Z3.24 F18000
G1 Z2.84
G1 E.3 F1800
; LINE_WIDTH: 0.421112
G1 F4800
M204 S6000
G1 X92.194 Y81.454 E.08329
; WIPE_START
G1 X90.194 Y81.453 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X92.647 Y88.153 Z3.24 F18000
G1 Z2.84
G1 E.3 F1800
; LINE_WIDTH: 0.419992
G1 F4800
M204 S6000
G1 X87.353 Y88.153 E.09893
G1 X87.353 Y88.947 E.01485
G1 X92.647 Y88.947 E.09893
G1 X92.647 Y88.213 E.01373
; WIPE_START
G1 X92.647 Y88.947 E-.10468
G1 X91.382 Y88.947 E-.18032
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X87.75 Y88.55 Z3.24 F18000
G1 Z2.84
G1 E.3 F1800
; LINE_WIDTH: 0.426072
G1 F4800
M204 S6000
G1 X92.19 Y88.55 E.08424
; OBJECT_ID: 8
; WIPE_START
G1 X90.19 Y88.55 E-.285
; WIPE_END
G1 E-.015 F1800
; stop printing object, unique label id: 12
M625
; start printing object, unique label id: 8
M624 AQAAAAAAAAA=
M204 S10000
G1 X82.558 Y88.624 Z3.24 F18000
G1 X68.992 Y88.757 Z3.24
G1 Z2.84
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F3600
M204 S6000
G1 X68.992 Y81.243 E.15107
G1 X70.503 Y81.243 E.03038
G1 X70.503 Y81.043 E.00402
G1 X70.907 Y81.043 E.00812
G1 X70.907 Y88.957 E.15911
G1 X70.503 Y88.957 E.00812
G1 X70.503 Y88.757 E.00402
G1 X69.052 Y88.757 E.02917
M204 S10000
G1 X68.568 Y89.181 F18000
G1 F3600
M204 S6000
G1 X68.568 Y80.819 E.16813
G1 X70.079 Y80.819 E.03039
G1 X70.079 Y80.619 E.00402
G1 X71.331 Y80.619 E.02517
G1 X71.331 Y89.381 E.17617
G1 X70.079 Y89.381 E.02517
G1 X70.079 Y89.181 E.00402
G1 X68.628 Y89.181 E.02918
M204 S250
G1 X68.159 Y89.59 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1800
M204 S5000
G1 X68.159 Y80.41 E.17153
G1 X69.67 Y80.41 E.02825
G1 X69.671 Y80.21 E.00374
G1 X71.739 Y80.21 E.03865
G1 X71.74 Y89.79 E.17901
G1 X71.739 Y89.79 E.00002
G1 X69.671 Y89.79 E.03865
G1 X69.67 Y89.59 E.00374
G1 X68.219 Y89.59 E.02713
; WIPE_START
M204 S6000
G1 X68.205 Y87.59 E-.285
; WIPE_END
G1 E-.015
M204 S10000
G1 X69.401 Y88.347 Z3.24 F18000
G1 Z2.84
G1 E.3 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.419992
G1 F4800
M204 S6000
G1 X70.497 Y88.347 E.02048
G1 X70.497 Y81.653 E.12509
G1 X69.401 Y81.653 E.02048
G1 X69.401 Y88.287 E.12397
M204 S10000
G1 X69.774 Y87.975 F18000
; LINE_WIDTH: 0.376697
G1 F4800
M204 S6000
G1 X70.125 Y87.975 E.00584
G1 X70.125 Y82.025 E.09896
G1 X69.774 Y82.025 E.00584
G1 X69.774 Y87.915 E.09796
; WIPE_START
G1 X69.774 Y85.915 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X63.038 Y82.325 Z3.24 F18000
G1 X61.008 Y81.243 Z3.24
G1 Z2.84
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F3600
M204 S6000
G1 X61.008 Y88.757 E.15107
G1 X59.493 Y88.757 E.03046
G1 X59.494 Y88.957 E.00402
G1 X59.093 Y88.957 E.00805
G1 X59.093 Y81.043 E.15911
G1 X59.494 Y81.043 E.00805
G1 X59.493 Y81.243 E.00402
G1 X60.948 Y81.243 E.02925
M204 S10000
G1 X61.432 Y80.819 F18000
G1 F3600
M204 S6000
G1 X61.432 Y89.181 E.16813
G1 X59.918 Y89.181 E.03044
G1 X59.919 Y89.381 E.00402
G1 X58.669 Y89.381 E.02513
G1 X58.669 Y80.619 E.17617
G1 X59.919 Y80.619 E.02513
G1 X59.918 Y80.819 E.00402
G1 X61.372 Y80.819 E.02923
M204 S250
G1 X61.841 Y80.41 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1800
M204 S5000
G1 X61.841 Y89.59 E.17153
G1 X60.329 Y89.59 E.02827
G1 X60.329 Y89.79 E.00374
G1 X58.261 Y89.79 E.03864
G1 X58.261 Y80.21 E.17901
G1 X60.329 Y80.21 E.03864
G1 X60.329 Y80.41 E.00374
G1 X61.781 Y80.41 E.02715
; WIPE_START
M204 S6000
G1 X61.795 Y82.41 E-.285
; WIPE_END
G1 E-.015
M204 S10000
G1 X60.599 Y82.201 Z3.24 F18000
G1 Z2.84
G1 E.3 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.419992
G1 F4800
M204 S6000
G1 X60.599 Y81.653 E.01024
G1 X59.503 Y81.653 E.02048
G1 X59.503 Y88.347 E.12509
G1 X60.599 Y88.347 E.02048
G1 X60.599 Y82.261 E.11373
M204 S10000
G1 X60.226 Y82.201 F18000
; LINE_WIDTH: 0.376672
G1 F4800
M204 S6000
G1 X60.226 Y82.025 E.00292
G1 X59.875 Y82.025 E.00584
G1 X59.875 Y87.975 E.09895
G1 X60.226 Y87.975 E.00584
G1 X60.226 Y82.261 E.09504
; CHANGE_LAYER
; Z_HEIGHT: 2.96
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F4800
G1 X60.226 Y84.261 E-.285
; WIPE_END
G1 E-.015 F1800
; stop printing object, unique label id: 8
M625
; layer num/total_layer_count: 24/57
; update layer progress
M73 L24
M991 S0 P23 ;notify layer change
; OBJECT_ID: 16
; start printing object, unique label id: 16
M624 BAAAAAAAAAA=
M204 S10000
G17
G3 Z3.24 I-.049 J1.216 P1  F18000
G1 X109.69 Y86.263 Z3.24
G1 Z2.96
G1 E.3 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
M204 S5000
G1 X109.149 Y86.262 E.01012
G1 X109.137 Y83.737 E.04718
G1 X109.69 Y83.737 E.01033
G1 X109.69 Y84.31 E.01071
G1 X111.11 Y84.31 E.02653
G1 X111.11 Y83.737 E.01071
G1 X120.137 Y83.737 E.16867
G1 X120.137 Y81.738 E.03735
G1 X120.863 Y81.74 E.01357
G1 X120.863 Y88.263 E.12189
G1 X120.137 Y88.262 E.01357
G1 X120.137 Y86.263 E.03736
G1 X111.11 Y86.263 E.16867
G1 X111.11 Y85.69 E.01071
G1 X109.69 Y85.69 E.02653
G1 X109.69 Y86.203 E.00958
; WIPE_START
M204 S6000
G1 X109.149 Y86.262 E-.07761
G1 X109.142 Y84.807 E-.20739
; WIPE_END
G1 E-.015
M204 S10000
G17
G3 Z3.36 I1.217 J0 P1  F18000
; stop printing object, unique label id: 16
M625
; object ids of layer 24 start: 8,12,16
M624 BwAAAAAAAAA=
;===================== date: 20250206 =====================

; don't support timelapse gcode in spiral_mode and by object sequence for I3 structure printer
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
G92 E0
G1 Z3.36
G1 X0 Y85.0002 ; move to safe pos
G1 X-13.0 F3000 ; move to safe pos
M400
M1004 S5 P1  ; external shutter
M400 P300
M971 S11 C11 O0
G92 E0
G1 X0 F18000
M623

; SKIPTYPE: head_wrap_detect
M622.1 S1
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




; object ids of this layer24 end: 8,12,16
M625
; start printing object, unique label id: 16
M624 BAAAAAAAAAA=
G1 X109.415 Y84.515
G1 Z2.96
G1 E.3 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.167243
G1 F2400
M204 S6000
G1 X109.414 Y83.941 E.00384
; WIPE_START
G1 X109.415 Y84.515 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X109.418 Y85.485 Z3.36 F18000
G1 Z2.96
G1 E.3 F1800
; LINE_WIDTH: 0.160176
G1 F2400
M204 S6000
G1 X109.419 Y86.058 E.00365
; WIPE_START
G1 X109.418 Y85.485 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X117.04 Y85.88 Z3.36 F18000
G1 X120.5 Y86.059 Z3.36
G1 Z2.96
G1 E.3 F1800
; LINE_WIDTH: 0.342885
G1 F2400
M204 S6000
G1 X120.5 Y88.058 E.03005
; WIPE_START
G1 X120.5 Y86.059 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X120.646 Y85.208 Z3.36 F18000
G1 Z2.96
G1 E.3 F1800
; FEATURE: Top surface
; LINE_WIDTH: 0.42
G1 F3600
M204 S2000
G1 X119.808 Y86.046 E.02216
G1 X119.25 Y86.046
G1 X120.646 Y84.65 E.03689
G1 X120.581 Y84.158
G1 X118.693 Y86.046 E.0499
G1 X118.135 Y86.046
G1 X120.112 Y84.07 E.05223
G1 X119.67 Y83.954
G1 X117.578 Y86.046 E.0553
G1 X117.02 Y86.046
G1 X119.113 Y83.954 E.0553
G1 X118.555 Y83.954
G1 X116.462 Y86.046 E.0553
G1 X115.905 Y86.046
G1 X117.998 Y83.954 E.0553
G1 X117.44 Y83.954
G1 X115.347 Y86.046 E.0553
G1 X114.79 Y86.046
G1 X116.883 Y83.954 E.0553
G1 X116.325 Y83.954
G1 X114.232 Y86.046 E.0553
G1 X113.675 Y86.046
G1 X115.768 Y83.954 E.0553
G1 X115.21 Y83.954
G1 X113.117 Y86.046 E.0553
G1 X112.56 Y86.046
G1 X114.652 Y83.954 E.0553
G1 X114.095 Y83.954
G1 X112.002 Y86.046 E.0553
G1 X111.445 Y86.046
G1 X113.537 Y83.954 E.0553
M73 P70 R6
G1 X112.98 Y83.954
G1 X111.327 Y85.607 E.04368
G1 X110.903 Y85.473
G1 X112.422 Y83.954 E.04015
G1 X111.865 Y83.954
G1 X111.327 Y84.492 E.01421
G1 X111.292 Y84.527
G1 X110.345 Y85.473 E.02501
G1 X109.788 Y85.473
G1 X110.734 Y84.527 E.02501
G1 X110.176 Y84.527
G1 X109.435 Y85.269 E.0196
; WIPE_START
M204 S6000
G1 X110.176 Y84.527 E-.14949
G1 X110.734 Y84.527 E-.07945
G1 X110.456 Y84.805 E-.05606
; WIPE_END
M73 P70 R5
G1 E-.015 F1800
M204 S10000
G1 X118.06 Y84.151 Z3.36 F18000
G1 X120.5 Y83.941 Z3.36
G1 Z2.96
G1 E.3 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.342851
G1 F2400
M204 S6000
G1 X120.5 Y81.944 E.03003
; OBJECT_ID: 12
; WIPE_START
G1 X120.5 Y83.941 E-.285
; WIPE_END
G1 E-.015 F1800
; stop printing object, unique label id: 16
M625
; start printing object, unique label id: 12
M624 AgAAAAAAAAA=
M204 S10000
G1 X112.92 Y84.831 Z3.36 F18000
G1 X88.09 Y87.743 Z3.36
G1 Z2.96
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F3600
M204 S6000
G1 X87.257 Y87.743 E.01676
G1 X87.257 Y82.257 E.11033
G1 X92.743 Y82.257 E.11033
G1 X92.743 Y87.743 E.11033
G1 X88.15 Y87.743 E.09236
M204 S10000
G1 X88.09 Y87.319 F18000
G1 F3600
M204 S6000
G1 X87.681 Y87.319 E.00823
G1 X87.681 Y82.681 E.09327
G1 X92.319 Y82.681 E.09327
G1 X92.319 Y87.319 E.09327
G1 X88.15 Y87.319 E.08383
M204 S250
G1 X88.09 Y86.91 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1800
M204 S5000
G1 X88.09 Y83.09 E.07138
G1 X91.91 Y83.09 E.07138
G1 X91.91 Y86.91 E.07138
G1 X88.15 Y86.91 E.07026
; WIPE_START
M204 S6000
G1 X88.119 Y84.91 E-.285
; WIPE_END
G1 E-.015
M204 S10000
G1 X86.943 Y80.645 Z3.36 F18000
G1 Z2.96
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F3600
M204 S6000
G1 X93.056 Y80.652 E.12291
G1 X93.057 Y89.357 E.17502
G1 X86.943 Y89.357 E.12292
G1 X86.943 Y80.705 E.17397
M204 S10000
G1 X86.519 Y80.22 F18000
G1 F3600
M204 S6000
G1 X93.48 Y80.229 E.13997
G1 X93.481 Y89.781 E.19207
G1 X86.519 Y89.781 E.13998
G1 X86.519 Y80.28 E.19104
M204 S250
G1 X86.269 Y79.844 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1800
M204 S5000
G1 X86.397 Y79.81 E.00247
G1 X93.666 Y79.82 E.13583
G1 X93.803 Y79.899 E.00296
G1 X93.861 Y79.982 E.0019
G1 X93.89 Y80.105 E.00235
G1 X93.89 Y89.883 E.18272
G1 X93.873 Y89.989 E.00199
G1 X93.831 Y90.073 E.00176
G1 X93.731 Y90.157 E.00244
G1 X93.588 Y90.19 E.00275
G1 X86.417 Y90.19 E.13399
G1 X86.311 Y90.173 E.00199
G1 X86.227 Y90.131 E.00176
G1 X86.143 Y90.031 E.00244
G1 X86.11 Y89.888 E.00275
G1 X86.11 Y80.117 E.18258
G1 X86.127 Y80.011 E.00199
G1 X86.165 Y79.937 E.00157
G1 X86.224 Y79.884 E.00148
; WIPE_START
M204 S6000
G1 X86.397 Y79.81 E-.02677
G1 X88.209 Y79.813 E-.25823
; WIPE_END
G1 E-.015
M204 S10000
G1 X92.647 Y81.847 Z3.36 F18000
G1 Z2.96
G1 E.3 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.419992
G1 F4800
M204 S6000
G1 X92.647 Y81.061 E.01469
G1 X87.353 Y81.054 E.09892
G1 X87.353 Y81.847 E.01482
G1 X92.587 Y81.847 E.0978
; WIPE_START
G1 X90.587 Y81.847 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X87.749 Y81.451 Z3.36 F18000
G1 Z2.96
G1 E.3 F1800
; LINE_WIDTH: 0.421142
G1 F4800
M204 S6000
G1 X92.194 Y81.454 E.08329
; WIPE_START
G1 X90.194 Y81.453 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X92.647 Y88.153 Z3.36 F18000
G1 Z2.96
G1 E.3 F1800
; LINE_WIDTH: 0.419992
G1 F4800
M204 S6000
G1 X87.353 Y88.153 E.09893
G1 X87.353 Y88.947 E.01485
G1 X92.647 Y88.947 E.09893
G1 X92.647 Y88.213 E.01373
; WIPE_START
G1 X92.647 Y88.947 E-.10468
G1 X91.382 Y88.947 E-.18032
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X87.75 Y88.55 Z3.36 F18000
G1 Z2.96
G1 E.3 F1800
; LINE_WIDTH: 0.426072
G1 F4800
M204 S6000
G1 X92.19 Y88.55 E.08424
; OBJECT_ID: 8
; WIPE_START
G1 X90.19 Y88.55 E-.285
; WIPE_END
G1 E-.015 F1800
; stop printing object, unique label id: 12
M625
; start printing object, unique label id: 8
M624 AQAAAAAAAAA=
M204 S10000
G1 X82.558 Y88.625 Z3.36 F18000
G1 X69.046 Y88.757 Z3.36
G1 Z2.96
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F3600
M204 S6000
G1 X69.046 Y81.243 E.15107
G1 X70.645 Y81.243 E.03214
G1 X70.645 Y81.043 E.00402
G1 X70.946 Y81.043 E.00605
G1 X70.946 Y88.957 E.15911
G1 X70.645 Y88.957 E.00605
G1 X70.645 Y88.757 E.00402
G1 X69.106 Y88.757 E.03093
M204 S10000
G1 X68.622 Y89.181 F18000
G1 F3600
M204 S6000
G1 X68.622 Y80.819 E.16813
G1 X70.221 Y80.819 E.03214
G1 X70.221 Y80.619 E.00402
G1 X71.37 Y80.619 E.02311
G1 X71.37 Y89.381 E.17617
G1 X70.221 Y89.381 E.02311
G1 X70.221 Y89.181 E.00402
G1 X68.682 Y89.181 E.03094
M204 S250
G1 X68.213 Y89.59 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1800
M204 S5000
G1 X68.213 Y80.41 E.17153
G1 X69.812 Y80.41 E.02987
G1 X69.812 Y80.21 E.00374
G1 X71.779 Y80.21 E.03676
G1 X71.779 Y89.79 E.17901
G1 X69.812 Y89.79 E.03676
G1 X69.812 Y89.59 E.00374
G1 X68.273 Y89.59 E.02875
; WIPE_START
M204 S6000
G1 X68.26 Y87.59 E-.285
; WIPE_END
G1 E-.015
M204 S10000
G1 X69.456 Y88.347 Z3.36 F18000
G1 Z2.96
G1 E.3 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.419992
G1 F4800
M204 S6000
G1 X70.536 Y88.347 E.0202
G1 X70.537 Y81.653 E.12509
G1 X69.456 Y81.653 E.0202
G1 X69.456 Y88.287 E.12397
M204 S10000
G1 X69.824 Y87.807 F18000
; LINE_WIDTH: 0.369092
G1 F4800
M204 S6000
G1 X69.824 Y87.979 E.00279
G1 X70.168 Y87.979 E.00559
G1 X70.168 Y82.022 E.09694
G1 X69.824 Y82.022 E.00559
G1 X69.824 Y87.747 E.09317
; WIPE_START
G1 X69.824 Y85.747 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X63.019 Y82.292 Z3.36 F18000
G1 X60.954 Y81.243 Z3.36
G1 Z2.96
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F3600
M204 S6000
G1 X60.954 Y88.757 E.15107
G1 X59.354 Y88.757 E.03217
G1 X59.354 Y88.957 E.00402
G1 X59.054 Y88.957 E.00603
G1 X59.054 Y81.043 E.15911
G1 X59.355 Y81.043 E.00604
G1 X59.355 Y81.243 E.00402
G1 X60.894 Y81.243 E.03095
M204 S10000
G1 X61.378 Y80.819 F18000
G1 F3600
M204 S6000
G1 X61.378 Y89.181 E.16813
G1 X59.778 Y89.181 E.03216
G1 X59.779 Y89.381 E.00402
G1 X58.63 Y89.381 E.02309
G1 X58.63 Y80.619 E.17617
G1 X59.779 Y80.619 E.0231
G1 X59.779 Y80.819 E.00402
G1 X61.318 Y80.819 E.03095
M204 S250
G1 X61.787 Y80.41 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1800
M204 S5000
G1 X61.787 Y89.59 E.17153
G1 X60.188 Y89.59 E.02988
G1 X60.188 Y89.79 E.00374
G1 X58.221 Y89.79 E.03676
G1 X58.221 Y80.21 E.17901
G1 X60.188 Y80.21 E.03676
G1 X60.188 Y80.41 E.00374
G1 X61.727 Y80.41 E.02876
; WIPE_START
M204 S6000
G1 X61.74 Y82.41 E-.285
; WIPE_END
G1 E-.015
M204 S10000
G1 X60.544 Y82.193 Z3.36 F18000
G1 Z2.96
G1 E.3 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.419992
G1 F4800
M204 S6000
G1 X60.544 Y81.653 E.0101
G1 X59.463 Y81.653 E.0202
G1 X59.463 Y88.347 E.12509
G1 X60.544 Y88.347 E.0202
G1 X60.544 Y82.253 E.11387
M204 S10000
G1 X60.176 Y82.193 F18000
; LINE_WIDTH: 0.369102
G1 F4800
M204 S6000
G1 X60.176 Y82.022 E.00279
G1 X59.832 Y82.022 E.00559
G1 X59.832 Y87.979 E.09694
G1 X60.176 Y87.979 E.00559
M73 P71 R5
G1 X60.176 Y82.253 E.09317
; CHANGE_LAYER
; Z_HEIGHT: 3.08
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F4800
G1 X60.176 Y84.253 E-.285
; WIPE_END
G1 E-.015 F1800
; stop printing object, unique label id: 8
M625
; layer num/total_layer_count: 25/57
; update layer progress
M73 L25
M991 S0 P24 ;notify layer change
M106 S71.4
; OBJECT_ID: 12
; start printing object, unique label id: 12
M624 AgAAAAAAAAA=
M204 S10000
G17
G3 Z3.36 I-.151 J1.208 P1  F18000
G1 X88.09 Y87.743 Z3.36
G1 Z3.08
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F3600
M204 S6000
G1 X87.257 Y87.743 E.01676
G1 X87.257 Y82.257 E.11033
G1 X92.743 Y82.257 E.11033
G1 X92.743 Y87.743 E.11033
G1 X88.15 Y87.743 E.09236
M204 S10000
G1 X88.09 Y87.319 F18000
G1 F3600
M204 S6000
G1 X87.681 Y87.319 E.00823
G1 X87.681 Y82.681 E.09327
G1 X92.319 Y82.681 E.09327
G1 X92.319 Y87.319 E.09327
G1 X88.15 Y87.319 E.08383
M204 S250
G1 X88.09 Y86.91 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1800
M204 S5000
G1 X88.09 Y83.09 E.07138
G1 X91.91 Y83.09 E.07138
G1 X91.91 Y86.91 E.07138
G1 X88.15 Y86.91 E.07026
; WIPE_START
M204 S6000
G1 X88.119 Y84.91 E-.285
; WIPE_END
G1 E-.015
M204 S10000
G1 X86.943 Y80.645 Z3.48 F18000
G1 Z3.08
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F3600
M204 S6000
G1 X93.056 Y80.652 E.12291
G1 X93.057 Y89.357 E.17502
G1 X86.943 Y89.357 E.12292
G1 X86.943 Y80.705 E.17397
M204 S10000
G1 X86.519 Y80.22 F18000
G1 F3600
M204 S6000
G1 X93.48 Y80.229 E.13997
G1 X93.481 Y89.781 E.19207
G1 X86.519 Y89.781 E.13998
G1 X86.519 Y80.28 E.19104
M204 S250
G1 X86.269 Y79.844 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1800
M204 S5000
G1 X86.397 Y79.81 E.00248
G1 X93.666 Y79.82 E.13584
G1 X93.804 Y79.899 E.00297
G1 X93.859 Y79.978 E.0018
G1 X93.89 Y80.105 E.00244
G1 X93.89 Y89.884 E.18271
G1 X93.873 Y89.989 E.00199
G1 X93.831 Y90.073 E.00176
G1 X93.731 Y90.157 E.00244
G1 X93.588 Y90.19 E.00275
G1 X86.416 Y90.19 E.134
G1 X86.311 Y90.173 E.00199
G1 X86.227 Y90.131 E.00176
G1 X86.143 Y90.031 E.00244
G1 X86.11 Y89.888 E.00275
G1 X86.11 Y80.117 E.18258
G1 X86.127 Y80.011 E.00199
G1 X86.164 Y79.937 E.00156
G1 X86.224 Y79.884 E.00149
; WIPE_START
M204 S6000
G1 X86.397 Y79.81 E-.02678
G1 X88.209 Y79.813 E-.25822
; WIPE_END
G1 E-.015
M204 S10000
G17
G3 Z3.48 I1.217 J0 P1  F18000
; stop printing object, unique label id: 12
M625
; object ids of layer 25 start: 8,12
M624 AwAAAAAAAAA=
;===================== date: 20250206 =====================

; don't support timelapse gcode in spiral_mode and by object sequence for I3 structure printer
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
G92 E0
G1 Z3.48
G1 X0 Y85.0002 ; move to safe pos
G1 X-13.0 F3000 ; move to safe pos
M400
M1004 S5 P1  ; external shutter
M400 P300
M971 S11 C11 O0
G92 E0
G1 X0 F18000
M623

; SKIPTYPE: head_wrap_detect
M622.1 S1
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




; object ids of this layer25 end: 8,12
M625
; start printing object, unique label id: 12
M624 AgAAAAAAAAA=
G1 X92.647 Y81.847
G1 Z3.08
G1 E.3 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.419992
G1 F4800
M204 S6000
G1 X92.647 Y81.061 E.01469
G1 X87.353 Y81.054 E.09892
G1 X87.353 Y81.847 E.01482
G1 X92.587 Y81.847 E.0978
; WIPE_START
G1 X90.587 Y81.847 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X87.749 Y81.451 Z3.48 F18000
G1 Z3.08
G1 E.3 F1800
; LINE_WIDTH: 0.421112
G1 F4800
M204 S6000
G1 X92.194 Y81.454 E.08329
; WIPE_START
G1 X90.194 Y81.453 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X92.647 Y88.153 Z3.48 F18000
G1 Z3.08
G1 E.3 F1800
; LINE_WIDTH: 0.419992
G1 F4800
M204 S6000
G1 X87.353 Y88.153 E.09893
G1 X87.353 Y88.947 E.01485
G1 X92.647 Y88.947 E.09893
G1 X92.647 Y88.213 E.01373
; WIPE_START
G1 X92.647 Y88.947 E-.10468
G1 X91.382 Y88.947 E-.18032
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X87.75 Y88.55 Z3.48 F18000
G1 Z3.08
G1 E.3 F1800
; LINE_WIDTH: 0.426072
G1 F4800
M204 S6000
G1 X92.19 Y88.55 E.08424
; OBJECT_ID: 8
; WIPE_START
G1 X90.19 Y88.55 E-.285
; WIPE_END
G1 E-.015 F1800
; stop printing object, unique label id: 12
M625
; start printing object, unique label id: 8
M624 AQAAAAAAAAA=
M204 S10000
G1 X82.558 Y88.625 Z3.48 F18000
G1 X69.105 Y88.757 Z3.48
G1 Z3.08
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F3600
M204 S6000
G1 X69.105 Y81.243 E.15107
G1 X70.982 Y81.243 E.03774
G1 X70.982 Y88.757 E.15107
G1 X69.165 Y88.757 E.03653
M204 S10000
G1 X68.681 Y89.181 F18000
G1 F3600
M204 S6000
G1 X68.681 Y80.819 E.16813
G1 X70.34 Y80.819 E.03335
G1 X70.339 Y80.619 E.00402
G1 X71.406 Y80.619 E.02145
G1 X71.406 Y89.381 E.17617
G1 X70.339 Y89.381 E.02145
G1 X70.34 Y89.181 E.00402
G1 X68.741 Y89.181 E.03214
M204 S250
G1 X68.272 Y89.59 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1800
M204 S5000
G1 X68.272 Y80.41 E.17153
G1 X69.93 Y80.41 E.03099
G1 X69.93 Y80.21 E.00374
G1 X71.816 Y80.21 E.03523
G1 X71.815 Y89.79 E.17901
G1 X69.93 Y89.79 E.03523
G1 X69.93 Y89.59 E.00374
G1 X68.332 Y89.59 E.02987
; WIPE_START
M204 S6000
G1 X68.319 Y87.59 E-.285
; WIPE_END
G1 E-.015
M204 S10000
G1 X69.515 Y88.347 Z3.48 F18000
G1 Z3.08
G1 E.3 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.419992
G1 F4800
M204 S6000
G1 X70.573 Y88.347 E.01977
G1 X70.573 Y81.653 E.12509
G1 X69.515 Y81.653 E.01977
G1 X69.515 Y88.287 E.12397
M204 S10000
G1 X69.878 Y87.818 F18000
; LINE_WIDTH: 0.357757
G1 F4800
M204 S6000
G1 X69.878 Y87.984 E.00261
G1 X70.21 Y87.984 E.00522
G1 X70.21 Y82.016 E.09392
G1 X69.878 Y82.016 E.00522
G1 X69.878 Y87.758 E.09036
; WIPE_START
G1 X69.878 Y85.758 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X70.552 Y89.069 Z3.48 F18000
G1 Z3.08
G1 E.3 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.225652
G1 F2400
M204 S6000
G1 X71.194 Y89.069 E.00609
; WIPE_START
G1 X70.552 Y89.069 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X71.152 Y81.46 Z3.48 F18000
G1 X71.194 Y80.931 Z3.48
G1 Z3.08
G1 E.3 F1800
G1 F2400
M204 S6000
G1 X70.552 Y80.931 E.00609
; WIPE_START
G1 X71.194 Y80.931 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X63.565 Y81.163 Z3.48 F18000
G1 X60.895 Y81.243 Z3.48
G1 Z3.08
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F3600
M204 S6000
G1 X60.895 Y88.757 E.15107
G1 X59.018 Y88.757 E.03773
G1 X59.018 Y81.243 E.15107
G1 X60.835 Y81.243 E.03653
M204 S10000
G1 X61.319 Y80.819 F18000
G1 F3600
M204 S6000
G1 X61.319 Y89.181 E.16813
G1 X59.661 Y89.181 E.03334
G1 X59.661 Y89.381 E.00402
G1 X58.594 Y89.381 E.02145
G1 X58.594 Y80.62 E.17615
G1 X59.661 Y80.622 E.02145
G1 X59.661 Y80.819 E.00396
G1 X61.259 Y80.819 E.03213
M204 S250
G1 X61.728 Y80.41 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1800
M204 S5000
M73 P72 R5
G1 X61.728 Y89.59 E.17153
G1 X60.07 Y89.59 E.03099
G1 X60.07 Y89.79 E.00374
G1 X58.185 Y89.79 E.03523
G1 X58.185 Y80.21 E.179
G1 X60.07 Y80.214 E.03523
G1 X60.07 Y80.41 E.00367
G1 X61.668 Y80.41 E.02987
; WIPE_START
M204 S6000
G1 X61.681 Y82.41 E-.285
; WIPE_END
G1 E-.015
M204 S10000
G1 X60.485 Y82.182 Z3.48 F18000
G1 Z3.08
G1 E.3 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.419992
G1 F4800
M204 S6000
G1 X60.485 Y81.653 E.00989
G1 X59.427 Y81.653 E.01977
G1 X59.427 Y88.347 E.12509
G1 X60.485 Y88.347 E.01977
G1 X60.485 Y82.242 E.11408
M204 S10000
G1 X60.122 Y82.182 F18000
; LINE_WIDTH: 0.357722
G1 F4800
M204 S6000
G1 X60.122 Y82.016 E.00261
G1 X59.79 Y82.016 E.00522
G1 X59.79 Y87.984 E.09391
G1 X60.122 Y87.984 E.00522
G1 X60.122 Y82.242 E.09035
; WIPE_START
G1 X60.122 Y84.242 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X59.449 Y80.933 Z3.48 F18000
G1 Z3.08
G1 E.3 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.223522
G1 F2400
M204 S6000
G1 X58.806 Y80.932 E.00603
; WIPE_START
G1 X59.449 Y80.933 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X58.848 Y88.541 Z3.48 F18000
G1 X58.806 Y89.069 Z3.48
G1 Z3.08
G1 E.3 F1800
; LINE_WIDTH: 0.225652
G1 F2400
M204 S6000
G1 X59.449 Y89.069 E.00609
; CHANGE_LAYER
; Z_HEIGHT: 3.2
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F2400
G1 X58.806 Y89.069 E-.285
; WIPE_END
G1 E-.015 F1800
; stop printing object, unique label id: 8
M625
; layer num/total_layer_count: 26/57
; update layer progress
M73 L26
M991 S0 P25 ;notify layer change
; OBJECT_ID: 12
; start printing object, unique label id: 12
M624 AgAAAAAAAAA=
M204 S10000
G17
G3 Z3.48 I.055 J1.216 P1  F18000
G1 X88.09 Y87.743 Z3.48
G1 Z3.2
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F3600
M204 S6000
G1 X87.257 Y87.743 E.01676
G1 X87.257 Y82.257 E.11033
G1 X92.743 Y82.257 E.11033
G1 X92.743 Y87.743 E.11033
G1 X88.15 Y87.743 E.09236
M204 S10000
G1 X88.09 Y87.319 F18000
G1 F3600
M204 S6000
G1 X87.681 Y87.319 E.00823
G1 X87.681 Y82.681 E.09327
G1 X92.319 Y82.681 E.09327
G1 X92.319 Y87.319 E.09327
G1 X88.15 Y87.319 E.08383
M204 S250
G1 X88.09 Y86.91 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1800
M204 S5000
G1 X88.09 Y83.09 E.07138
G1 X91.91 Y83.09 E.07138
G1 X91.91 Y86.91 E.07138
G1 X88.15 Y86.91 E.07026
; WIPE_START
M204 S6000
G1 X88.119 Y84.91 E-.285
; WIPE_END
G1 E-.015
M204 S10000
G1 X86.943 Y80.645 Z3.6 F18000
G1 Z3.2
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F3600
M204 S6000
G1 X93.056 Y80.652 E.12291
G1 X93.057 Y89.357 E.17502
G1 X86.943 Y89.357 E.12292
G1 X86.943 Y80.705 E.17397
M204 S10000
G1 X86.519 Y80.22 F18000
G1 F3600
M204 S6000
G1 X93.48 Y80.229 E.13997
G1 X93.481 Y89.781 E.19207
G1 X86.519 Y89.781 E.13998
G1 X86.519 Y80.28 E.19104
M204 S250
G1 X86.268 Y79.843 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1800
M204 S5000
G1 X86.397 Y79.81 E.00249
G1 X93.656 Y79.82 E.13564
G1 X93.796 Y79.889 E.00293
G1 X93.865 Y79.992 E.00232
G1 X93.89 Y80.103 E.00212
G1 X93.89 Y89.884 E.18275
G1 X93.873 Y89.989 E.00199
G1 X93.831 Y90.073 E.00176
G1 X93.731 Y90.157 E.00244
G1 X93.588 Y90.19 E.00275
G1 X86.417 Y90.19 E.134
G1 X86.311 Y90.173 E.00199
G1 X86.227 Y90.131 E.00176
G1 X86.143 Y90.031 E.00244
G1 X86.11 Y89.888 E.00275
G1 X86.11 Y80.117 E.18258
G1 X86.127 Y80.011 E.00199
G1 X86.169 Y79.927 E.00176
G1 X86.222 Y79.882 E.00129
; WIPE_START
M204 S6000
G1 X86.397 Y79.81 E-.02689
G1 X88.208 Y79.813 E-.25811
; WIPE_END
G1 E-.015
M204 S10000
G17
G3 Z3.6 I1.217 J0 P1  F18000
; stop printing object, unique label id: 12
M625
; object ids of layer 26 start: 8,12
M624 AwAAAAAAAAA=
;===================== date: 20250206 =====================

; don't support timelapse gcode in spiral_mode and by object sequence for I3 structure printer
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
G92 E0
G1 Z3.6
G1 X0 Y85.0002 ; move to safe pos
G1 X-13.0 F3000 ; move to safe pos
M400
M1004 S5 P1  ; external shutter
M400 P300
M971 S11 C11 O0
G92 E0
G1 X0 F18000
M623

; SKIPTYPE: head_wrap_detect
M622.1 S1
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




; object ids of this layer26 end: 8,12
M625
; start printing object, unique label id: 12
M624 AgAAAAAAAAA=
G1 X92.647 Y81.847
G1 Z3.2
G1 E.3 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.419992
G1 F4800
M204 S6000
G1 X92.647 Y81.061 E.01469
G1 X87.353 Y81.054 E.09892
G1 X87.353 Y81.847 E.01482
G1 X92.587 Y81.847 E.0978
; WIPE_START
G1 X90.587 Y81.847 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X87.749 Y81.451 Z3.6 F18000
G1 Z3.2
G1 E.3 F1800
; LINE_WIDTH: 0.421122
G1 F4800
M204 S6000
G1 X92.194 Y81.454 E.08329
; WIPE_START
G1 X90.194 Y81.453 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X92.647 Y88.153 Z3.6 F18000
G1 Z3.2
G1 E.3 F1800
; LINE_WIDTH: 0.419992
G1 F4800
M204 S6000
G1 X87.353 Y88.153 E.09893
G1 X87.353 Y88.947 E.01485
G1 X92.647 Y88.947 E.09893
G1 X92.647 Y88.213 E.01373
; WIPE_START
G1 X92.647 Y88.947 E-.10468
G1 X91.382 Y88.947 E-.18032
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X87.75 Y88.55 Z3.6 F18000
G1 Z3.2
G1 E.3 F1800
; LINE_WIDTH: 0.426072
G1 F4800
M204 S6000
G1 X92.19 Y88.55 E.08424
; OBJECT_ID: 8
; WIPE_START
G1 X90.19 Y88.55 E-.285
; WIPE_END
G1 E-.015 F1800
; stop printing object, unique label id: 12
M625
; start printing object, unique label id: 8
M624 AQAAAAAAAAA=
M204 S10000
G1 X82.558 Y88.625 Z3.6 F18000
G1 X69.169 Y88.757 Z3.6
G1 Z3.2
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F3600
M204 S6000
G1 X69.169 Y81.243 E.15107
G1 X71.015 Y81.243 E.03714
G1 X71.015 Y88.757 E.15107
G1 X69.229 Y88.757 E.03593
M204 S10000
G1 X68.744 Y89.181 F18000
G1 F3600
M204 S6000
G1 X68.744 Y80.819 E.16813
G1 X70.44 Y80.819 E.0341
G1 X70.44 Y80.619 E.00402
G1 X71.44 Y80.619 E.0201
G1 X71.44 Y89.381 E.17617
G1 X70.44 Y89.381 E.0201
G1 X70.44 Y89.181 E.00402
G1 X68.804 Y89.181 E.03289
M204 S250
G1 X68.335 Y89.59 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1800
M204 S5000
G1 X68.335 Y80.41 E.17153
G1 X70.031 Y80.41 E.03169
G1 X70.031 Y80.21 E.00374
G1 X71.849 Y80.21 E.03396
G1 X71.849 Y89.79 E.17901
G1 X70.031 Y89.79 E.03396
G1 X70.031 Y89.59 E.00374
G1 X68.395 Y89.59 E.03057
; WIPE_START
M204 S6000
G1 X68.382 Y87.59 E-.285
; WIPE_END
G1 E-.015
M204 S10000
G1 X69.578 Y88.347 Z3.6 F18000
G1 Z3.2
G1 E.3 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.419992
G1 F4800
M204 S6000
G1 X70.606 Y88.347 E.01922
G1 X70.606 Y81.653 E.12509
G1 X69.578 Y81.653 E.01922
G1 X69.578 Y88.287 E.12397
M204 S10000
G1 X70.092 Y87.833 F18000
; LINE_WIDTH: 0.659932
G1 F4730.518
M204 S6000
G1 X70.092 Y82.227 E.16851
; WIPE_START
G1 X70.092 Y84.227 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X70.652 Y80.931 Z3.6 F18000
G1 Z3.2
G1 E.3 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.225652
G1 F2400
M204 S6000
G1 X71.228 Y80.931 E.00545
; WIPE_START
G1 X70.652 Y80.931 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X71.191 Y88.545 Z3.6 F18000
G1 X71.228 Y89.069 Z3.6
G1 Z3.2
G1 E.3 F1800
G1 F2400
M204 S6000
M73 P73 R5
G1 X70.652 Y89.069 E.00545
; WIPE_START
G1 X71.228 Y89.069 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X65.13 Y84.479 Z3.6 F18000
G1 X60.831 Y81.243 Z3.6
G1 Z3.2
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F3600
M204 S6000
G1 X60.831 Y88.757 E.15107
G1 X58.984 Y88.757 E.03714
G1 X58.984 Y81.243 E.15107
G1 X60.771 Y81.243 E.03593
M204 S10000
G1 X61.256 Y80.819 F18000
G1 F3600
M204 S6000
G1 X61.256 Y89.181 E.16813
G1 X59.559 Y89.181 E.03412
G1 X59.559 Y89.381 E.00402
G1 X58.56 Y89.381 E.02008
G1 X58.56 Y80.619 E.17617
G1 X59.56 Y80.619 E.0201
G1 X59.56 Y80.819 E.00402
G1 X61.196 Y80.819 E.03289
M204 S250
G1 X61.665 Y80.41 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1800
M204 S5000
G1 X61.665 Y89.59 E.17153
G1 X59.968 Y89.59 E.0317
G1 X59.969 Y89.79 E.00374
G1 X58.151 Y89.79 E.03396
G1 X58.151 Y80.21 E.17901
G1 X59.969 Y80.21 E.03396
G1 X59.969 Y80.41 E.00374
G1 X61.605 Y80.41 E.03057
; WIPE_START
M204 S6000
G1 X61.618 Y82.41 E-.285
; WIPE_END
G1 E-.015
M204 S10000
G1 X60.422 Y82.167 Z3.6 F18000
G1 Z3.2
G1 E.3 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.419992
G1 F4800
M204 S6000
G1 X60.422 Y81.653 E.00961
G1 X59.394 Y81.653 E.01922
G1 X59.394 Y88.347 E.12509
G1 X60.422 Y88.347 E.01922
G1 X60.422 Y82.227 E.11436
; WIPE_START
G1 X60.422 Y84.227 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X59.908 Y87.833 Z3.6 F18000
G1 Z3.2
G1 E.3 F1800
; LINE_WIDTH: 0.660012
G1 F4729.921
M204 S6000
G1 X59.908 Y82.227 E.16853
; WIPE_START
G1 X59.908 Y84.227 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X59.348 Y80.931 Z3.6 F18000
G1 Z3.2
G1 E.3 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.225652
G1 F2400
M204 S6000
G1 X58.772 Y80.931 E.00545
; WIPE_START
G1 X59.348 Y80.931 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X58.809 Y88.545 Z3.6 F18000
G1 X58.772 Y89.069 Z3.6
G1 Z3.2
G1 E.3 F1800
G1 F2400
M204 S6000
G1 X59.347 Y89.069 E.00544
; CHANGE_LAYER
; Z_HEIGHT: 3.32
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F2400
G1 X58.772 Y89.069 E-.285
; WIPE_END
G1 E-.015 F1800
; stop printing object, unique label id: 8
M625
; layer num/total_layer_count: 27/57
; update layer progress
M73 L27
M991 S0 P26 ;notify layer change
; OBJECT_ID: 12
; start printing object, unique label id: 12
M624 AgAAAAAAAAA=
M204 S10000
G17
G3 Z3.6 I.055 J1.216 P1  F18000
G1 X88.09 Y87.743 Z3.6
G1 Z3.32
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F3600
M204 S6000
G1 X87.257 Y87.743 E.01676
G1 X87.257 Y82.257 E.11033
G1 X92.743 Y82.257 E.11033
G1 X92.743 Y87.743 E.11033
G1 X88.15 Y87.743 E.09236
M204 S10000
G1 X88.09 Y87.319 F18000
G1 F3600
M204 S6000
G1 X87.681 Y87.319 E.00823
G1 X87.681 Y82.681 E.09327
G1 X92.319 Y82.681 E.09327
G1 X92.319 Y87.319 E.09327
G1 X88.15 Y87.319 E.08383
M204 S250
G1 X88.09 Y86.91 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1800
M204 S5000
G1 X88.09 Y83.09 E.07138
G1 X91.91 Y83.09 E.07138
G1 X91.91 Y86.91 E.07138
G1 X88.15 Y86.91 E.07026
; WIPE_START
M204 S6000
G1 X88.119 Y84.91 E-.285
; WIPE_END
G1 E-.015
M204 S10000
G1 X86.943 Y80.645 Z3.72 F18000
G1 Z3.32
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F3600
M204 S6000
G1 X93.056 Y80.652 E.12291
G1 X93.057 Y89.357 E.17502
G1 X86.943 Y89.357 E.12292
G1 X86.943 Y80.705 E.17397
M204 S10000
G1 X86.519 Y80.22 F18000
G1 F3600
M204 S6000
G1 X93.48 Y80.229 E.13997
G1 X93.481 Y89.781 E.19207
G1 X86.519 Y89.781 E.13998
G1 X86.519 Y80.28 E.19104
M204 S250
G1 X86.269 Y79.844 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1800
M204 S5000
G1 X86.397 Y79.81 E.00248
G1 X93.666 Y79.82 E.13584
G1 X93.804 Y79.899 E.00296
G1 X93.86 Y79.981 E.00187
G1 X93.89 Y80.105 E.00238
G1 X93.89 Y89.883 E.18272
G1 X93.873 Y89.989 E.002
G1 X93.832 Y90.07 E.0017
G1 X93.731 Y90.157 E.00249
G1 X93.588 Y90.19 E.00275
G1 X86.417 Y90.19 E.134
G1 X86.311 Y90.173 E.00199
G1 X86.227 Y90.131 E.00176
G1 X86.143 Y90.031 E.00244
G1 X86.11 Y89.888 E.00275
G1 X86.11 Y80.117 E.18258
G1 X86.127 Y80.011 E.00199
G1 X86.165 Y79.937 E.00156
G1 X86.224 Y79.884 E.00148
; WIPE_START
M204 S6000
G1 X86.397 Y79.81 E-.0268
G1 X88.209 Y79.813 E-.2582
; WIPE_END
G1 E-.015
M204 S10000
G17
G3 Z3.72 I1.217 J0 P1  F18000
; stop printing object, unique label id: 12
M625
; object ids of layer 27 start: 8,12
M624 AwAAAAAAAAA=
;===================== date: 20250206 =====================

; don't support timelapse gcode in spiral_mode and by object sequence for I3 structure printer
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
G92 E0
G1 Z3.72
G1 X0 Y85.0002 ; move to safe pos
G1 X-13.0 F3000 ; move to safe pos
M400
M1004 S5 P1  ; external shutter
M400 P300
M971 S11 C11 O0
G92 E0
G1 X0 F18000
M623

; SKIPTYPE: head_wrap_detect
M622.1 S1
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




; object ids of this layer27 end: 8,12
M625
; start printing object, unique label id: 12
M624 AgAAAAAAAAA=
G1 X92.647 Y81.847
G1 Z3.32
G1 E.3 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.419992
G1 F4800
M204 S6000
G1 X92.647 Y81.061 E.01469
G1 X87.353 Y81.054 E.09892
G1 X87.353 Y81.847 E.01482
G1 X92.587 Y81.847 E.0978
; WIPE_START
G1 X90.587 Y81.847 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X87.749 Y81.451 Z3.72 F18000
G1 Z3.32
G1 E.3 F1800
; LINE_WIDTH: 0.421112
G1 F4800
M204 S6000
G1 X92.194 Y81.454 E.08329
; WIPE_START
G1 X90.194 Y81.453 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X92.647 Y88.153 Z3.72 F18000
G1 Z3.32
G1 E.3 F1800
; LINE_WIDTH: 0.419992
G1 F4800
M204 S6000
G1 X87.353 Y88.153 E.09893
G1 X87.353 Y88.947 E.01485
G1 X92.647 Y88.947 E.09893
G1 X92.647 Y88.213 E.01373
; WIPE_START
G1 X92.647 Y88.947 E-.10468
G1 X91.382 Y88.947 E-.18032
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X87.75 Y88.55 Z3.72 F18000
G1 Z3.32
G1 E.3 F1800
; LINE_WIDTH: 0.426072
G1 F4800
M204 S6000
G1 X92.19 Y88.55 E.08424
; OBJECT_ID: 8
; WIPE_START
G1 X90.19 Y88.55 E-.285
; WIPE_END
G1 E-.015 F1800
; stop printing object, unique label id: 12
M625
; start printing object, unique label id: 8
M624 AQAAAAAAAAA=
M204 S10000
G1 X82.558 Y88.625 Z3.72 F18000
G1 X69.237 Y88.757 Z3.72
G1 Z3.32
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F3600
M204 S6000
G1 X69.237 Y81.243 E.15107
G1 X71.046 Y81.243 E.03638
G1 X71.046 Y88.757 E.15107
G1 X69.297 Y88.757 E.03517
M204 S10000
G1 X68.813 Y89.181 F18000
G1 F3600
M204 S6000
G1 X68.813 Y80.819 E.16813
G1 X70.529 Y80.819 E.0345
G1 X70.529 Y80.619 E.00402
G1 X71.471 Y80.619 E.01894
G1 X71.471 Y89.381 E.17617
G1 X70.529 Y89.381 E.01894
G1 X70.529 Y89.181 E.00402
G1 X68.873 Y89.181 E.03329
M204 S250
G1 X68.404 Y89.59 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1800
M204 S5000
G1 X68.404 Y80.41 E.17153
G1 X70.119 Y80.41 E.03206
G1 X70.119 Y80.21 E.00374
G1 X71.88 Y80.21 E.0329
G1 X71.88 Y89.79 E.17901
G1 X70.119 Y89.79 E.0329
G1 X70.119 Y89.59 E.00374
G1 X68.464 Y89.59 E.03094
; WIPE_START
M204 S6000
G1 X68.451 Y87.59 E-.285
; WIPE_END
G1 E-.015
M204 S10000
G1 X69.646 Y88.347 Z3.72 F18000
G1 Z3.32
G1 E.3 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.419992
G1 F4800
M204 S6000
G1 X70.637 Y88.347 E.01851
G1 X70.637 Y81.653 E.12509
G1 X69.646 Y81.653 E.01851
G1 X69.646 Y88.287 E.12397
M204 S10000
G1 X70.142 Y87.852 F18000
; LINE_WIDTH: 0.622332
G1 F4800
M204 S6000
G1 X70.142 Y82.208 E.15958
; WIPE_START
G1 X70.142 Y84.208 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X70.741 Y80.931 Z3.72 F18000
G1 Z3.32
G1 E.3 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.225652
G1 F2400
M204 S6000
M73 P74 R5
G1 X71.259 Y80.931 E.00491
; WIPE_START
G1 X70.741 Y80.931 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X71.225 Y88.548 Z3.72 F18000
G1 X71.259 Y89.069 Z3.72
G1 Z3.32
G1 E.3 F1800
G1 F2400
M204 S6000
G1 X70.741 Y89.069 E.00491
; WIPE_START
G1 X71.259 Y89.069 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X65.14 Y84.507 Z3.72 F18000
G1 X60.763 Y81.243 Z3.72
G1 Z3.32
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F3600
M204 S6000
G1 X60.763 Y88.757 E.15107
G1 X58.953 Y88.757 E.03638
G1 X58.953 Y81.243 E.15107
G1 X60.703 Y81.243 E.03518
M204 S10000
G1 X61.187 Y80.819 F18000
G1 F3600
M204 S6000
G1 X61.187 Y89.181 E.16813
G1 X59.471 Y89.181 E.03451
G1 X59.471 Y89.381 E.00402
G1 X58.529 Y89.381 E.01894
G1 X58.529 Y80.619 E.17617
G1 X59.472 Y80.619 E.01895
G1 X59.472 Y80.819 E.00402
G1 X61.127 Y80.819 E.03328
M204 S250
G1 X61.596 Y80.41 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1800
M204 S5000
G1 X61.596 Y89.59 E.17153
G1 X59.88 Y89.59 E.03206
G1 X59.881 Y89.79 E.00374
G1 X58.12 Y89.79 E.0329
G1 X58.12 Y80.21 E.17901
G1 X59.881 Y80.21 E.0329
G1 X59.881 Y80.41 E.00374
G1 X61.536 Y80.41 E.03093
; WIPE_START
M204 S6000
G1 X61.549 Y82.41 E-.285
; WIPE_END
G1 E-.015
M204 S10000
G1 X60.354 Y82.148 Z3.72 F18000
G1 Z3.32
G1 E.3 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.419992
G1 F4800
M204 S6000
G1 X60.354 Y81.653 E.00926
G1 X59.363 Y81.653 E.01852
G1 X59.363 Y88.347 E.12509
G1 X60.354 Y88.347 E.01852
G1 X60.354 Y82.208 E.11471
; WIPE_START
G1 X60.354 Y84.208 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X59.858 Y87.852 Z3.72 F18000
G1 Z3.32
G1 E.3 F1800
; LINE_WIDTH: 0.622512
G1 F4800
M204 S6000
G1 X59.858 Y82.208 E.15962
; WIPE_START
G1 X59.858 Y84.208 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X59.26 Y80.931 Z3.72 F18000
G1 Z3.32
G1 E.3 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.225652
G1 F2400
M204 S6000
G1 X58.741 Y80.931 E.00491
; WIPE_START
G1 X59.26 Y80.931 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X58.774 Y88.548 Z3.72 F18000
G1 X58.741 Y89.069 Z3.72
G1 Z3.32
G1 E.3 F1800
G1 F2400
M204 S6000
G1 X59.259 Y89.069 E.0049
; CHANGE_LAYER
; Z_HEIGHT: 3.44
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F2400
G1 X58.741 Y89.069 E-.285
; WIPE_END
G1 E-.015 F1800
; stop printing object, unique label id: 8
M625
; layer num/total_layer_count: 28/57
; update layer progress
M73 L28
M991 S0 P27 ;notify layer change
; OBJECT_ID: 12
; start printing object, unique label id: 12
M624 AgAAAAAAAAA=
M204 S10000
G17
G3 Z3.72 I.055 J1.216 P1  F18000
G1 X88.09 Y87.743 Z3.72
G1 Z3.44
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F3600
M204 S6000
G1 X87.257 Y87.743 E.01676
G1 X87.257 Y82.257 E.11033
G1 X92.743 Y82.257 E.11033
G1 X92.743 Y87.743 E.11033
G1 X88.15 Y87.743 E.09236
M204 S10000
G1 X88.09 Y87.319 F18000
G1 F3600
M204 S6000
G1 X87.681 Y87.319 E.00823
G1 X87.681 Y82.681 E.09327
G1 X92.319 Y82.681 E.09327
G1 X92.319 Y87.319 E.09327
G1 X88.15 Y87.319 E.08383
M204 S250
G1 X88.09 Y86.91 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1800
M204 S5000
G1 X88.09 Y83.09 E.07138
G1 X91.91 Y83.09 E.07138
G1 X91.91 Y86.91 E.07138
G1 X88.15 Y86.91 E.07026
; WIPE_START
M204 S6000
G1 X88.119 Y84.91 E-.285
; WIPE_END
G1 E-.015
M204 S10000
G1 X86.943 Y80.645 Z3.84 F18000
G1 Z3.44
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F3600
M204 S6000
G1 X93.056 Y80.652 E.12291
G1 X93.057 Y89.357 E.17502
G1 X86.943 Y89.357 E.12292
G1 X86.943 Y80.705 E.17397
M204 S10000
G1 X86.519 Y80.22 F18000
G1 F3600
M204 S6000
G1 X93.48 Y80.229 E.13997
G1 X93.481 Y89.781 E.19207
G1 X86.519 Y89.781 E.13998
G1 X86.519 Y80.28 E.19104
M204 S250
G1 X86.258 Y79.85 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1800
M204 S5000
G1 X86.408 Y79.81 E.00289
G1 X93.666 Y79.82 E.13563
G1 X93.802 Y79.898 E.00293
G1 X93.865 Y79.992 E.00213
G1 X93.89 Y80.103 E.00212
G1 X93.89 Y89.883 E.18275
G1 X93.873 Y89.989 E.00199
G1 X93.831 Y90.073 E.00176
G1 X93.731 Y90.157 E.00244
G1 X93.588 Y90.19 E.00275
G1 X86.417 Y90.19 E.134
G1 X86.311 Y90.173 E.002
G1 X86.229 Y90.132 E.00171
G1 X86.143 Y90.031 E.00248
G1 X86.11 Y89.888 E.00275
G1 X86.11 Y80.117 E.18258
G1 X86.127 Y80.011 E.00199
G1 X86.169 Y79.927 E.00176
G1 X86.213 Y79.889 E.00108
; WIPE_START
M204 S6000
G1 X86.408 Y79.81 E-.02994
G1 X88.198 Y79.813 E-.25507
; WIPE_END
G1 E-.015
M204 S10000
G17
G3 Z3.84 I1.217 J0 P1  F18000
; stop printing object, unique label id: 12
M625
; object ids of layer 28 start: 8,12
M624 AwAAAAAAAAA=
;===================== date: 20250206 =====================

; don't support timelapse gcode in spiral_mode and by object sequence for I3 structure printer
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
G92 E0
G1 Z3.84
G1 X0 Y85.0002 ; move to safe pos
G1 X-13.0 F3000 ; move to safe pos
M400
M1004 S5 P1  ; external shutter
M400 P300
M971 S11 C11 O0
G92 E0
G1 X0 F18000
M623

; SKIPTYPE: head_wrap_detect
M622.1 S1
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




; object ids of this layer28 end: 8,12
M625
; start printing object, unique label id: 12
M624 AgAAAAAAAAA=
G1 X92.647 Y81.847
G1 Z3.44
G1 E.3 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.419992
G1 F4800
M204 S6000
G1 X92.647 Y81.061 E.01469
G1 X87.353 Y81.054 E.09892
G1 X87.353 Y81.847 E.01482
G1 X92.587 Y81.847 E.0978
; WIPE_START
G1 X90.587 Y81.847 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X87.749 Y81.451 Z3.84 F18000
G1 Z3.44
G1 E.3 F1800
; LINE_WIDTH: 0.421112
G1 F4800
M204 S6000
G1 X92.194 Y81.454 E.08329
; WIPE_START
G1 X90.194 Y81.453 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X92.647 Y88.153 Z3.84 F18000
G1 Z3.44
G1 E.3 F1800
; LINE_WIDTH: 0.419992
G1 F4800
M204 S6000
G1 X87.353 Y88.153 E.09893
G1 X87.353 Y88.947 E.01485
G1 X92.647 Y88.947 E.09893
G1 X92.647 Y88.213 E.01373
; WIPE_START
G1 X92.647 Y88.947 E-.10468
G1 X91.382 Y88.947 E-.18032
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X87.75 Y88.55 Z3.84 F18000
G1 Z3.44
G1 E.3 F1800
; LINE_WIDTH: 0.426072
G1 F4800
M204 S6000
G1 X92.19 Y88.55 E.08424
; OBJECT_ID: 8
; WIPE_START
G1 X90.19 Y88.55 E-.285
; WIPE_END
G1 E-.015 F1800
; stop printing object, unique label id: 12
M625
; start printing object, unique label id: 8
M624 AQAAAAAAAAA=
M204 S10000
G1 X82.558 Y88.625 Z3.84 F18000
G1 X69.31 Y88.757 Z3.84
G1 Z3.44
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F3600
M204 S6000
G1 X69.31 Y81.243 E.15107
G1 X71.075 Y81.243 E.03548
G1 X71.075 Y88.757 E.15107
G1 X69.37 Y88.757 E.03428
M204 S10000
G1 X68.886 Y89.181 F18000
G1 F3600
M204 S6000
G1 X68.886 Y80.819 E.16813
G1 X70.607 Y80.819 E.0346
G1 X70.606 Y80.619 E.00402
G1 X71.499 Y80.619 E.01795
G1 X71.499 Y89.381 E.17617
G1 X70.606 Y89.381 E.01795
G1 X70.607 Y89.181 E.00402
G1 X68.946 Y89.181 E.03339
M204 S250
G1 X68.477 Y89.59 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1800
M204 S5000
G1 X68.477 Y80.41 E.17153
G1 X70.197 Y80.41 E.03214
G1 X70.197 Y80.21 E.00374
G1 X71.908 Y80.21 E.03198
G1 X71.908 Y89.79 E.17901
G1 X70.197 Y89.79 E.03198
G1 X70.197 Y89.59 E.00374
G1 X68.537 Y89.59 E.03102
; WIPE_START
M204 S6000
G1 X68.524 Y87.59 E-.285
; WIPE_END
G1 E-.015
M204 S10000
G1 X69.72 Y88.347 Z3.84 F18000
G1 Z3.44
G1 E.3 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.419992
G1 F4800
M204 S6000
G1 X70.666 Y88.347 E.01768
G1 X70.666 Y81.653 E.12509
G1 X69.72 Y81.653 E.01768
G1 X69.72 Y88.287 E.12397
M204 S10000
G1 X70.193 Y87.874 F18000
; LINE_WIDTH: 0.577732
G1 F4800
M204 S6000
G1 X70.193 Y82.186 E.14882
; WIPE_START
G1 X70.193 Y84.186 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X70.819 Y80.931 Z3.84 F18000
G1 Z3.44
G1 E.3 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.225652
G1 F2400
M204 S6000
G1 X71.287 Y80.931 E.00444
; WIPE_START
G1 X70.819 Y80.931 E-.285
; WIPE_END
M73 P75 R4
G1 E-.015 F1800
M204 S10000
G1 X71.257 Y88.551 Z3.84 F18000
G1 X71.287 Y89.069 Z3.84
G1 Z3.44
G1 E.3 F1800
G1 F2400
M204 S6000
G1 X70.819 Y89.069 E.00444
; WIPE_START
G1 X71.287 Y89.069 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X65.147 Y84.535 Z3.84 F18000
G1 X60.69 Y81.243 Z3.84
G1 Z3.44
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F3600
M204 S6000
G1 X60.69 Y88.757 E.15107
G1 X58.925 Y88.757 E.03549
G1 X58.925 Y81.243 E.15107
G1 X60.63 Y81.243 E.03428
M204 S10000
G1 X61.114 Y80.819 F18000
G1 F3600
M204 S6000
G1 X61.114 Y89.181 E.16813
G1 X59.394 Y89.181 E.03458
G1 X59.394 Y89.381 E.00402
G1 X58.501 Y89.381 E.01797
G1 X58.501 Y80.619 E.17617
G1 X59.395 Y80.619 E.01797
G1 X59.395 Y80.819 E.00402
G1 X61.054 Y80.819 E.03336
M204 S250
G1 X61.523 Y80.41 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1800
M204 S5000
G1 X61.523 Y89.59 E.17153
G1 X59.803 Y89.59 E.03214
G1 X59.803 Y89.79 E.00374
G1 X58.091 Y89.79 E.03199
G1 X58.091 Y80.21 E.17901
G1 X59.803 Y80.21 E.03199
G1 X59.804 Y80.41 E.00374
G1 X61.463 Y80.41 E.03101
; WIPE_START
M204 S6000
G1 X61.476 Y82.41 E-.285
; WIPE_END
G1 E-.015
M204 S10000
G1 X60.28 Y82.126 Z3.84 F18000
G1 Z3.44
G1 E.3 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.419992
G1 F4800
M204 S6000
G1 X60.28 Y81.653 E.00884
G1 X59.334 Y81.653 E.01768
G1 X59.334 Y88.347 E.12509
G1 X60.28 Y88.347 E.01768
G1 X60.28 Y82.186 E.11513
; WIPE_START
G1 X60.28 Y84.186 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X59.807 Y87.874 Z3.84 F18000
G1 Z3.44
G1 E.3 F1800
; LINE_WIDTH: 0.577912
G1 F4800
M204 S6000
G1 X59.807 Y82.186 E.14886
; WIPE_START
G1 X59.807 Y84.186 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X59.183 Y80.931 Z3.84 F18000
G1 Z3.44
G1 E.3 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.225652
G1 F2400
M204 S6000
G1 X58.713 Y80.931 E.00445
; WIPE_START
G1 X59.183 Y80.931 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X58.743 Y88.551 Z3.84 F18000
G1 X58.713 Y89.069 Z3.84
G1 Z3.44
G1 E.3 F1800
G1 F2400
M204 S6000
G1 X59.182 Y89.069 E.00445
; CHANGE_LAYER
; Z_HEIGHT: 3.56
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F2400
G1 X58.713 Y89.069 E-.285
; WIPE_END
G1 E-.015 F1800
; stop printing object, unique label id: 8
M625
; layer num/total_layer_count: 29/57
; update layer progress
M73 L29
M991 S0 P28 ;notify layer change
; OBJECT_ID: 12
; start printing object, unique label id: 12
M624 AgAAAAAAAAA=
M204 S10000
G17
G3 Z3.84 I.055 J1.216 P1  F18000
G1 X88.09 Y87.743 Z3.84
G1 Z3.56
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F3600
M204 S6000
G1 X87.257 Y87.743 E.01676
G1 X87.257 Y82.257 E.11033
G1 X92.743 Y82.257 E.11033
G1 X92.743 Y87.743 E.11033
G1 X88.15 Y87.743 E.09236
M204 S10000
G1 X88.09 Y87.319 F18000
G1 F3600
M204 S6000
G1 X87.681 Y87.319 E.00823
G1 X87.681 Y82.681 E.09327
G1 X92.319 Y82.681 E.09327
G1 X92.319 Y87.319 E.09327
G1 X88.15 Y87.319 E.08383
M204 S250
G1 X88.09 Y86.91 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1800
M204 S5000
G1 X88.09 Y83.09 E.07138
G1 X91.91 Y83.09 E.07138
G1 X91.91 Y86.91 E.07138
G1 X88.15 Y86.91 E.07026
; WIPE_START
M204 S6000
G1 X88.119 Y84.91 E-.285
; WIPE_END
G1 E-.015
M204 S10000
G1 X86.943 Y80.645 Z3.96 F18000
G1 Z3.56
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F3600
M204 S6000
G1 X93.056 Y80.652 E.12291
G1 X93.057 Y89.357 E.17502
G1 X86.943 Y89.357 E.12292
G1 X86.943 Y80.705 E.17397
M204 S10000
G1 X86.519 Y80.22 F18000
G1 F3600
M204 S6000
G1 X93.48 Y80.229 E.13997
G1 X93.481 Y89.781 E.19207
G1 X86.519 Y89.781 E.13998
G1 X86.519 Y80.28 E.19104
M204 S250
G1 X86.269 Y79.844 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1800
M204 S5000
G1 X86.397 Y79.81 E.00247
G1 X93.666 Y79.82 E.13584
G1 X93.804 Y79.899 E.00296
G1 X93.86 Y79.98 E.00185
G1 X93.89 Y80.105 E.0024
G1 X93.89 Y89.883 E.18272
G1 X93.873 Y89.989 E.00199
G1 X93.831 Y90.073 E.00176
G1 X93.731 Y90.157 E.00244
G1 X93.588 Y90.19 E.00275
G1 X86.417 Y90.19 E.13399
G1 X86.311 Y90.173 E.00199
G1 X86.227 Y90.13 E.00176
G1 X86.143 Y90.031 E.00244
G1 X86.11 Y89.888 E.00275
G1 X86.11 Y80.117 E.18258
G1 X86.127 Y80.011 E.00199
G1 X86.165 Y79.937 E.00156
G1 X86.224 Y79.884 E.00148
; WIPE_START
M204 S6000
G1 X86.397 Y79.81 E-.02678
G1 X88.209 Y79.813 E-.25822
; WIPE_END
G1 E-.015
M204 S10000
G17
G3 Z3.96 I1.217 J0 P1  F18000
; stop printing object, unique label id: 12
M625
; object ids of layer 29 start: 8,12
M624 AwAAAAAAAAA=
;===================== date: 20250206 =====================

; don't support timelapse gcode in spiral_mode and by object sequence for I3 structure printer
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
G92 E0
G1 Z3.96
G1 X0 Y85.0002 ; move to safe pos
G1 X-13.0 F3000 ; move to safe pos
M400
M1004 S5 P1  ; external shutter
M400 P300
M971 S11 C11 O0
G92 E0
G1 X0 F18000
M623

; SKIPTYPE: head_wrap_detect
M622.1 S1
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




; object ids of this layer29 end: 8,12
M625
; start printing object, unique label id: 12
M624 AgAAAAAAAAA=
G1 X92.647 Y81.847
G1 Z3.56
G1 E.3 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.419992
G1 F4800
M204 S6000
G1 X92.647 Y81.061 E.01469
G1 X87.353 Y81.054 E.09892
G1 X87.353 Y81.847 E.01482
G1 X92.587 Y81.847 E.0978
; WIPE_START
G1 X90.587 Y81.847 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X87.749 Y81.451 Z3.96 F18000
G1 Z3.56
G1 E.3 F1800
; LINE_WIDTH: 0.421122
G1 F4800
M204 S6000
G1 X92.194 Y81.454 E.08329
; WIPE_START
G1 X90.194 Y81.453 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X92.647 Y88.153 Z3.96 F18000
G1 Z3.56
G1 E.3 F1800
; LINE_WIDTH: 0.419992
G1 F4800
M204 S6000
G1 X87.353 Y88.153 E.09893
G1 X87.353 Y88.947 E.01485
G1 X92.647 Y88.947 E.09893
G1 X92.647 Y88.213 E.01373
; WIPE_START
G1 X92.647 Y88.947 E-.10468
G1 X91.382 Y88.947 E-.18032
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X87.75 Y88.55 Z3.96 F18000
G1 Z3.56
G1 E.3 F1800
; LINE_WIDTH: 0.426072
G1 F4800
M204 S6000
G1 X92.19 Y88.55 E.08424
; OBJECT_ID: 8
; WIPE_START
G1 X90.19 Y88.55 E-.285
; WIPE_END
G1 E-.015 F1800
; stop printing object, unique label id: 12
M625
; start printing object, unique label id: 8
M624 AQAAAAAAAAA=
M204 S10000
G1 X82.78 Y86.72 Z3.96 F18000
G1 X60.611 Y81.243 Z3.96
G1 Z3.56
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F3600
M204 S6000
G1 X60.611 Y88.757 E.15107
G1 X58.899 Y88.757 E.03442
G1 X58.899 Y81.243 E.15107
G1 X60.551 Y81.243 E.03322
M204 S10000
G1 X61.035 Y80.819 F18000
G1 F3600
M204 S6000
G1 X61.035 Y89.181 E.16813
G1 X59.326 Y89.181 E.03437
G1 X59.326 Y89.381 E.00402
G1 X58.475 Y89.381 E.01712
G1 X58.475 Y80.619 E.17617
G1 X59.326 Y80.619 E.01712
G1 X59.326 Y80.819 E.00402
G1 X60.975 Y80.819 E.03316
M204 S250
G1 X61.444 Y80.41 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1800
M204 S5000
G1 X61.444 Y89.59 E.17153
G1 X59.735 Y89.59 E.03194
G1 X59.735 Y89.79 E.00374
G1 X58.065 Y89.79 E.0312
G1 X58.065 Y80.21 E.17901
G1 X59.735 Y80.21 E.0312
G1 X59.735 Y80.41 E.00374
G1 X61.384 Y80.41 E.03081
; WIPE_START
M204 S6000
G1 X61.397 Y82.41 E-.285
; WIPE_END
G1 E-.015
M204 S10000
G1 X60.201 Y82.099 Z3.96 F18000
G1 Z3.56
G1 E.3 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.419992
G1 F4800
M204 S6000
G1 X60.201 Y81.653 E.00835
G1 X59.308 Y81.653 E.01669
G1 X59.308 Y88.347 E.12509
G1 X60.201 Y88.347 E.01669
G1 X60.201 Y82.159 E.11562
; WIPE_START
G1 X60.201 Y84.159 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X59.755 Y87.901 Z3.96 F18000
G1 Z3.56
G1 E.3 F1800
; LINE_WIDTH: 0.524952
G1 F4800
M204 S6000
G1 X59.755 Y82.159 E.13583
; WIPE_START
M73 P76 R4
G1 X59.755 Y84.159 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X59.114 Y80.931 Z3.96 F18000
G1 Z3.56
G1 E.3 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.225652
G1 F2400
M204 S6000
G1 X58.687 Y80.931 E.00405
; WIPE_START
G1 X59.114 Y80.931 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X58.714 Y88.553 Z3.96 F18000
G1 X58.687 Y89.069 Z3.96
G1 Z3.56
G1 E.3 F1800
G1 F2400
M204 S6000
G1 X59.114 Y89.069 E.00404
; WIPE_START
G1 X58.687 Y89.069 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X66.316 Y88.846 Z3.96 F18000
G1 X69.389 Y88.757 Z3.96
G1 Z3.56
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F3600
M204 S6000
G1 X69.389 Y81.243 E.15107
G1 X71.101 Y81.243 E.03443
G1 X71.101 Y88.757 E.15107
G1 X69.449 Y88.757 E.03322
M204 S10000
G1 X68.965 Y89.181 F18000
G1 F3600
M204 S6000
G1 X68.965 Y80.819 E.16813
G1 X70.674 Y80.819 E.03437
G1 X70.674 Y80.619 E.00402
G1 X71.526 Y80.619 E.01712
G1 X71.525 Y89.381 E.17617
G1 X70.674 Y89.381 E.01712
G1 X70.674 Y89.181 E.00402
G1 X69.025 Y89.181 E.03316
M204 S250
G1 X68.556 Y89.59 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1800
M204 S5000
G1 X68.556 Y80.41 E.17153
G1 X70.265 Y80.41 E.03194
G1 X70.265 Y80.21 E.00374
G1 X71.935 Y80.21 E.0312
G1 X71.935 Y89.79 E.17901
G1 X70.265 Y89.79 E.0312
G1 X70.265 Y89.59 E.00374
G1 X68.616 Y89.59 E.03082
; WIPE_START
M204 S6000
G1 X68.603 Y87.59 E-.285
; WIPE_END
G1 E-.015
M204 S10000
G1 X69.799 Y88.347 Z3.96 F18000
G1 Z3.56
G1 E.3 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.419992
G1 F4800
M204 S6000
G1 X70.692 Y88.347 E.01669
G1 X70.692 Y81.653 E.12509
G1 X69.799 Y81.653 E.0167
G1 X69.799 Y88.287 E.12397
M204 S10000
G1 X70.245 Y87.901 F18000
; LINE_WIDTH: 0.525002
G1 F4800
M204 S6000
G1 X70.245 Y82.159 E.13585
; WIPE_START
G1 X70.245 Y84.159 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X70.886 Y80.931 Z3.96 F18000
G1 Z3.56
G1 E.3 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.225652
G1 F2400
M204 S6000
G1 X71.313 Y80.931 E.00405
; WIPE_START
G1 X70.886 Y80.931 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X71.286 Y88.553 Z3.96 F18000
G1 X71.313 Y89.069 Z3.96
G1 Z3.56
G1 E.3 F1800
G1 F2400
M204 S6000
G1 X70.886 Y89.069 E.00404
; CHANGE_LAYER
; Z_HEIGHT: 3.68
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F2400
G1 X71.313 Y89.069 E-.285
; WIPE_END
G1 E-.015 F1800
; stop printing object, unique label id: 8
M625
; layer num/total_layer_count: 30/57
; update layer progress
M73 L30
M991 S0 P29 ;notify layer change
; OBJECT_ID: 12
; start printing object, unique label id: 12
M624 AgAAAAAAAAA=
M204 S10000
G17
G3 Z3.96 I.096 J1.213 P1  F18000
G1 X88.09 Y87.743 Z3.96
G1 Z3.68
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F3600
M204 S6000
G1 X87.257 Y87.743 E.01676
G1 X87.257 Y82.257 E.11033
G1 X92.743 Y82.257 E.11033
G1 X92.743 Y87.743 E.11033
G1 X88.15 Y87.743 E.09236
M204 S10000
G1 X88.09 Y87.319 F18000
G1 F3600
M204 S6000
G1 X87.681 Y87.319 E.00823
G1 X87.681 Y82.681 E.09327
G1 X92.319 Y82.681 E.09327
G1 X92.319 Y87.319 E.09327
G1 X88.15 Y87.319 E.08383
M204 S250
G1 X88.09 Y86.91 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1800
M204 S5000
G1 X88.09 Y83.09 E.07138
G1 X91.91 Y83.09 E.07138
G1 X91.91 Y86.91 E.07138
G1 X88.15 Y86.91 E.07026
; WIPE_START
M204 S6000
G1 X88.119 Y84.91 E-.285
; WIPE_END
G1 E-.015
M204 S10000
G1 X86.943 Y80.645 Z4.08 F18000
G1 Z3.68
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F3600
M204 S6000
G1 X93.056 Y80.652 E.12291
G1 X93.057 Y89.357 E.17502
G1 X86.943 Y89.357 E.12292
G1 X86.943 Y80.705 E.17397
M204 S10000
G1 X86.519 Y80.22 F18000
G1 F3600
M204 S6000
G1 X93.48 Y80.229 E.13997
G1 X93.481 Y89.781 E.19207
G1 X86.519 Y89.781 E.13998
G1 X86.519 Y80.28 E.19104
M204 S250
G1 X86.26 Y79.849 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1800
M204 S5000
G1 X86.407 Y79.81 E.00284
G1 X93.666 Y79.82 E.13564
G1 X93.804 Y79.899 E.00297
G1 X93.86 Y79.98 E.00183
G1 X93.89 Y80.105 E.00241
G1 X93.89 Y89.883 E.18272
G1 X93.873 Y89.989 E.002
G1 X93.831 Y90.073 E.00176
G1 X93.731 Y90.157 E.00244
G1 X93.588 Y90.19 E.00275
G1 X86.417 Y90.19 E.13399
G1 X86.311 Y90.173 E.002
G1 X86.227 Y90.13 E.00176
G1 X86.143 Y90.031 E.00243
G1 X86.11 Y89.888 E.00275
G1 X86.11 Y80.117 E.18258
G1 X86.127 Y80.011 E.00199
G1 X86.169 Y79.927 E.00176
G1 X86.215 Y79.888 E.00112
; WIPE_START
M204 S6000
G1 X86.407 Y79.81 E-.02955
G1 X88.2 Y79.813 E-.25545
; WIPE_END
G1 E-.015
M204 S10000
G17
G3 Z4.08 I1.217 J0 P1  F18000
; stop printing object, unique label id: 12
M625
; object ids of layer 30 start: 8,12
M624 AwAAAAAAAAA=
;===================== date: 20250206 =====================

; don't support timelapse gcode in spiral_mode and by object sequence for I3 structure printer
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
G92 E0
G1 Z4.08
G1 X0 Y85.0002 ; move to safe pos
G1 X-13.0 F3000 ; move to safe pos
M400
M1004 S5 P1  ; external shutter
M400 P300
M971 S11 C11 O0
G92 E0
G1 X0 F18000
M623

; SKIPTYPE: head_wrap_detect
M622.1 S1
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




; object ids of this layer30 end: 8,12
M625
; start printing object, unique label id: 12
M624 AgAAAAAAAAA=
G1 X92.647 Y81.847
G1 Z3.68
G1 E.3 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.419992
G1 F4800
M204 S6000
G1 X92.647 Y81.061 E.01469
G1 X87.353 Y81.054 E.09892
G1 X87.353 Y81.847 E.01482
G1 X92.587 Y81.847 E.0978
; WIPE_START
G1 X90.587 Y81.847 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X87.749 Y81.451 Z4.08 F18000
G1 Z3.68
G1 E.3 F1800
; LINE_WIDTH: 0.421122
G1 F4800
M204 S6000
G1 X92.194 Y81.454 E.08329
; WIPE_START
G1 X90.194 Y81.453 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X92.647 Y88.153 Z4.08 F18000
G1 Z3.68
G1 E.3 F1800
; LINE_WIDTH: 0.419992
G1 F4800
M204 S6000
G1 X87.353 Y88.153 E.09893
G1 X87.353 Y88.947 E.01485
G1 X92.647 Y88.947 E.09893
G1 X92.647 Y88.213 E.01373
; WIPE_START
G1 X92.647 Y88.947 E-.10468
G1 X91.382 Y88.947 E-.18032
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X87.75 Y88.55 Z4.08 F18000
G1 Z3.68
G1 E.3 F1800
; LINE_WIDTH: 0.426072
G1 F4800
M204 S6000
G1 X92.19 Y88.55 E.08424
; OBJECT_ID: 8
; WIPE_START
G1 X90.19 Y88.55 E-.285
; WIPE_END
G1 E-.015 F1800
; stop printing object, unique label id: 12
M625
; start printing object, unique label id: 8
M624 AQAAAAAAAAA=
M204 S10000
G1 X82.558 Y88.626 Z4.08 F18000
G1 X69.473 Y88.757 Z4.08
G1 Z3.68
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F3600
M204 S6000
G1 X69.473 Y81.243 E.15107
G1 X71.125 Y81.243 E.03321
G1 X71.125 Y88.757 E.15107
G1 X69.533 Y88.757 E.03201
M204 S10000
G1 X69.049 Y89.181 F18000
G1 F3600
M204 S6000
G1 X69.049 Y80.819 E.16813
G1 X70.735 Y80.819 E.0339
G1 X70.735 Y80.619 E.00402
G1 X71.549 Y80.619 E.01638
G1 X71.549 Y89.381 E.17617
G1 X70.735 Y89.381 E.01638
G1 X70.735 Y89.181 E.00402
G1 X69.109 Y89.181 E.03269
M204 S250
G1 X68.64 Y89.59 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1800
M204 S5000
G1 X68.64 Y80.41 E.17153
G1 X70.326 Y80.41 E.0315
G1 X70.326 Y80.21 E.00374
G1 X71.959 Y80.21 E.03051
G1 X71.959 Y89.79 E.17901
G1 X70.326 Y89.79 E.03051
G1 X70.326 Y89.59 E.00374
G1 X68.7 Y89.59 E.03038
; WIPE_START
M204 S6000
G1 X68.687 Y87.59 E-.285
; WIPE_END
G1 E-.015
M204 S10000
G1 X69.882 Y88.347 Z4.08 F18000
G1 Z3.68
G1 E.3 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.419992
G1 F4800
M204 S6000
G1 X70.716 Y88.347 E.01557
G1 X70.716 Y81.653 E.12509
G1 X69.882 Y81.653 E.01557
G1 X69.882 Y88.287 E.12397
M204 S10000
G1 X70.299 Y87.931 F18000
; LINE_WIDTH: 0.464852
M73 P77 R4
G1 F4800
M204 S6000
G1 X70.299 Y82.129 E.12073
; WIPE_START
G1 X70.299 Y84.129 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X62.979 Y81.968 Z4.08 F18000
G1 X60.527 Y81.243 Z4.08
G1 Z3.68
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F3600
M204 S6000
G1 X60.527 Y88.757 E.15107
G1 X58.875 Y88.757 E.03321
G1 X58.875 Y81.243 E.15107
G1 X60.467 Y81.243 E.03201
M204 S10000
G1 X60.951 Y80.819 F18000
G1 F3600
M204 S6000
G1 X60.951 Y89.181 E.16813
G1 X59.265 Y89.181 E.0339
G1 X59.265 Y89.381 E.00402
G1 X58.451 Y89.381 E.01637
G1 X58.451 Y80.619 E.17617
G1 X59.265 Y80.619 E.01638
G1 X59.265 Y80.819 E.00402
G1 X60.891 Y80.819 E.03269
M204 S250
G1 X61.36 Y80.41 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1800
M204 S5000
G1 X61.36 Y89.59 E.17153
G1 X59.674 Y89.59 E.0315
G1 X59.674 Y89.79 E.00374
G1 X58.042 Y89.79 E.03051
G1 X58.042 Y80.21 E.17901
G1 X59.674 Y80.21 E.03051
G1 X59.674 Y80.41 E.00374
G1 X61.3 Y80.41 E.03038
; WIPE_START
M204 S6000
G1 X61.313 Y82.41 E-.285
; WIPE_END
G1 E-.015
M204 S10000
G1 X60.118 Y82.069 Z4.08 F18000
G1 Z3.68
G1 E.3 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.419992
G1 F4800
M204 S6000
G1 X60.118 Y81.653 E.00779
G1 X59.284 Y81.653 E.01557
G1 X59.284 Y88.347 E.12509
G1 X60.118 Y88.347 E.01557
G1 X60.118 Y82.129 E.11618
; WIPE_START
G1 X60.118 Y84.129 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X59.701 Y87.931 Z4.08 F18000
G1 Z3.68
G1 E.3 F1800
; LINE_WIDTH: 0.464812
G1 F4800
M204 S6000
G1 X59.701 Y82.129 E.12072
; CHANGE_LAYER
; Z_HEIGHT: 3.8
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F4800
G1 X59.701 Y84.129 E-.285
; WIPE_END
G1 E-.015 F1800
; stop printing object, unique label id: 8
M625
; layer num/total_layer_count: 31/57
; update layer progress
M73 L31
M991 S0 P30 ;notify layer change
; OBJECT_ID: 12
; start printing object, unique label id: 12
M624 AgAAAAAAAAA=
M204 S10000
G17
G3 Z4.08 I-.154 J1.207 P1  F18000
G1 X88.09 Y87.743 Z4.08
G1 Z3.8
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F3600
M204 S6000
G1 X87.257 Y87.743 E.01676
G1 X87.257 Y82.257 E.11033
G1 X92.743 Y82.257 E.11033
G1 X92.743 Y87.743 E.11033
G1 X88.15 Y87.743 E.09236
M204 S10000
G1 X88.09 Y87.319 F18000
G1 F3600
M204 S6000
G1 X87.681 Y87.319 E.00823
G1 X87.681 Y82.681 E.09327
G1 X92.319 Y82.681 E.09327
G1 X92.319 Y87.319 E.09327
G1 X88.15 Y87.319 E.08383
M204 S250
G1 X88.09 Y86.91 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1800
M204 S5000
G1 X88.09 Y83.09 E.07138
G1 X91.91 Y83.09 E.07138
G1 X91.91 Y86.91 E.07138
G1 X88.15 Y86.91 E.07026
; WIPE_START
M204 S6000
G1 X88.119 Y84.91 E-.285
; WIPE_END
G1 E-.015
M204 S10000
G1 X86.943 Y80.645 Z4.2 F18000
G1 Z3.8
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F3600
M204 S6000
G1 X93.056 Y80.652 E.12291
G1 X93.057 Y89.357 E.17502
G1 X86.943 Y89.357 E.12292
G1 X86.943 Y80.705 E.17397
M204 S10000
G1 X86.519 Y80.22 F18000
G1 F3600
M204 S6000
G1 X93.48 Y80.229 E.13997
G1 X93.481 Y89.781 E.19207
G1 X86.519 Y89.781 E.13998
G1 X86.519 Y80.28 E.19104
M204 S250
G1 X86.259 Y79.849 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1800
M204 S5000
G1 X86.407 Y79.81 E.00286
G1 X93.656 Y79.82 E.13544
G1 X93.798 Y79.89 E.00297
G1 X93.859 Y79.978 E.002
G1 X93.89 Y80.105 E.00244
G1 X93.89 Y89.883 E.18271
G1 X93.873 Y89.989 E.002
G1 X93.831 Y90.072 E.00173
G1 X93.731 Y90.157 E.00246
G1 X93.588 Y90.19 E.00275
G1 X86.417 Y90.19 E.13399
G1 X86.311 Y90.173 E.00199
G1 X86.227 Y90.131 E.00176
G1 X86.143 Y90.031 E.00244
G1 X86.11 Y89.888 E.00275
G1 X86.11 Y80.117 E.18258
G1 X86.127 Y80.011 E.00199
G1 X86.169 Y79.927 E.00176
G1 X86.214 Y79.889 E.0011
; WIPE_START
M204 S6000
G1 X86.407 Y79.81 E-.02972
G1 X88.199 Y79.813 E-.25528
; WIPE_END
G1 E-.015
M204 S10000
G17
G3 Z4.2 I1.217 J0 P1  F18000
; stop printing object, unique label id: 12
M625
; object ids of layer 31 start: 8,12
M624 AwAAAAAAAAA=
;===================== date: 20250206 =====================

; don't support timelapse gcode in spiral_mode and by object sequence for I3 structure printer
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
G92 E0
G1 Z4.2
G1 X0 Y85.0002 ; move to safe pos
G1 X-13.0 F3000 ; move to safe pos
M400
M1004 S5 P1  ; external shutter
M400 P300
M971 S11 C11 O0
G92 E0
G1 X0 F18000
M623

; SKIPTYPE: head_wrap_detect
M622.1 S1
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




; object ids of this layer31 end: 8,12
M625
; start printing object, unique label id: 12
M624 AgAAAAAAAAA=
G1 X92.647 Y81.847
G1 Z3.8
G1 E.3 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.419992
G1 F4800
M204 S6000
G1 X92.647 Y81.061 E.01469
G1 X87.353 Y81.054 E.09892
G1 X87.353 Y81.847 E.01482
G1 X92.587 Y81.847 E.0978
; WIPE_START
G1 X90.587 Y81.847 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X87.749 Y81.451 Z4.2 F18000
G1 Z3.8
G1 E.3 F1800
; LINE_WIDTH: 0.421122
G1 F4800
M204 S6000
G1 X92.194 Y81.454 E.08329
; WIPE_START
G1 X90.194 Y81.453 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X92.647 Y88.153 Z4.2 F18000
G1 Z3.8
G1 E.3 F1800
; LINE_WIDTH: 0.419992
G1 F4800
M204 S6000
G1 X87.353 Y88.153 E.09893
G1 X87.353 Y88.947 E.01485
G1 X92.647 Y88.947 E.09893
G1 X92.647 Y88.213 E.01373
; WIPE_START
G1 X92.647 Y88.947 E-.10468
G1 X91.382 Y88.947 E-.18032
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X87.75 Y88.55 Z4.2 F18000
G1 Z3.8
G1 E.3 F1800
; LINE_WIDTH: 0.426072
G1 F4800
M204 S6000
G1 X92.19 Y88.55 E.08424
; OBJECT_ID: 8
; WIPE_START
G1 X90.19 Y88.55 E-.285
; WIPE_END
G1 E-.015 F1800
; stop printing object, unique label id: 12
M625
; start printing object, unique label id: 8
M624 AQAAAAAAAAA=
M204 S10000
G1 X82.778 Y86.73 Z4.2 F18000
G1 X60.437 Y81.243 Z4.2
G1 Z3.8
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F3600
M204 S6000
G1 X60.437 Y88.757 E.15107
G1 X58.853 Y88.757 E.03183
G1 X58.853 Y81.243 E.15107
G1 X60.377 Y81.243 E.03063
M204 S10000
G1 X60.861 Y80.819 F18000
G1 F3600
M204 S6000
G1 X60.861 Y89.181 E.16813
G1 X59.211 Y89.181 E.03317
G1 X59.211 Y89.381 E.00402
G1 X58.429 Y89.381 E.01572
G1 X58.429 Y80.62 E.17616
G1 X59.211 Y80.62 E.01572
G1 X59.211 Y80.819 E.004
G1 X60.801 Y80.819 E.03196
M204 S250
G1 X61.27 Y80.41 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1800
M204 S5000
G1 X61.27 Y89.59 E.17153
G1 X59.62 Y89.59 E.03083
G1 X59.62 Y89.79 E.00374
G1 X58.02 Y89.79 E.0299
G1 X58.02 Y80.21 E.17901
G1 X59.62 Y80.211 E.0299
G1 X59.62 Y80.41 E.00371
G1 X61.21 Y80.41 E.02971
; WIPE_START
M204 S6000
G1 X61.223 Y82.41 E-.285
; WIPE_END
G1 E-.015
M204 S10000
G1 X60.027 Y82.035 Z4.2 F18000
G1 Z3.8
G1 E.3 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.419992
G1 F4800
M204 S6000
G1 X60.027 Y81.653 E.00714
G1 X59.263 Y81.653 E.01429
M73 P78 R4
G1 X59.263 Y88.347 E.12509
G1 X60.027 Y88.347 E.01429
G1 X60.027 Y82.095 E.11682
; WIPE_START
G1 X60.027 Y84.095 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X59.645 Y87.965 Z4.2 F18000
G1 Z3.8
G1 E.3 F1800
; LINE_WIDTH: 0.396192
G1 F4800
M204 S6000
G1 X59.645 Y82.095 E.10306
; WIPE_START
G1 X59.645 Y84.095 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X66.553 Y87.341 Z4.2 F18000
G1 X69.563 Y88.757 Z4.2
G1 Z3.8
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F3600
M204 S6000
G1 X69.563 Y81.243 E.15107
G1 X71.147 Y81.243 E.03183
G1 X71.147 Y88.757 E.15107
G1 X69.623 Y88.757 E.03063
M204 S10000
G1 X69.139 Y89.181 F18000
G1 F3600
M204 S6000
G1 X69.139 Y80.819 E.16813
G1 X70.79 Y80.819 E.03319
G1 X70.789 Y80.623 E.00396
G1 X71.571 Y80.627 E.01571
G1 X71.571 Y89.381 E.17602
G1 X70.789 Y89.381 E.01571
G1 X70.79 Y89.181 E.00402
G1 X69.199 Y89.181 E.03198
M204 S250
G1 X68.73 Y89.59 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1800
M204 S5000
G1 X68.73 Y80.41 E.17153
G1 X70.38 Y80.41 E.03084
G1 X70.38 Y80.211 E.00372
G1 X71.98 Y80.22 E.0299
G1 X71.98 Y89.79 E.17883
G1 X70.38 Y89.79 E.0299
G1 X70.38 Y89.59 E.00374
G1 X68.79 Y89.59 E.02971
; WIPE_START
M204 S6000
G1 X68.777 Y87.59 E-.285
; WIPE_END
G1 E-.015
M204 S10000
G1 X69.973 Y88.347 Z4.2 F18000
G1 Z3.8
G1 E.3 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.419992
G1 F4800
M204 S6000
G1 X70.737 Y88.347 E.01429
G1 X70.737 Y81.653 E.12509
G1 X69.973 Y81.653 E.01429
G1 X69.973 Y88.287 E.12397
M204 S10000
G1 X70.355 Y87.965 F18000
; LINE_WIDTH: 0.396232
G1 F4800
M204 S6000
G1 X70.355 Y82.095 E.10307
; CHANGE_LAYER
; Z_HEIGHT: 3.92
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F4800
G1 X70.355 Y84.095 E-.285
; WIPE_END
G1 E-.015 F1800
; stop printing object, unique label id: 8
M625
; layer num/total_layer_count: 32/57
; update layer progress
M73 L32
M991 S0 P31 ;notify layer change
M106 S73.95
; OBJECT_ID: 12
; start printing object, unique label id: 12
M624 AgAAAAAAAAA=
M204 S10000
G17
G3 Z4.2 I-.245 J1.192 P1  F18000
G1 X88.09 Y87.743 Z4.2
G1 Z3.92
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F3600
M204 S6000
G1 X87.257 Y87.743 E.01676
G1 X87.257 Y82.257 E.11033
G1 X92.743 Y82.257 E.11033
G1 X92.743 Y87.743 E.11033
G1 X88.15 Y87.743 E.09236
M204 S10000
G1 X88.09 Y87.319 F18000
G1 F3600
M204 S6000
G1 X87.681 Y87.319 E.00823
G1 X87.681 Y82.681 E.09327
G1 X92.319 Y82.681 E.09327
G1 X92.319 Y87.319 E.09327
G1 X88.15 Y87.319 E.08383
M204 S250
G1 X88.09 Y86.91 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1800
M204 S5000
G1 X88.09 Y83.09 E.07138
G1 X91.91 Y83.09 E.07138
G1 X91.91 Y86.91 E.07138
G1 X88.15 Y86.91 E.07026
; WIPE_START
M204 S6000
G1 X88.119 Y84.91 E-.285
; WIPE_END
G1 E-.015
M204 S10000
G1 X86.943 Y80.645 Z4.32 F18000
G1 Z3.92
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F3600
M204 S6000
G1 X93.056 Y80.652 E.12291
G1 X93.057 Y89.357 E.17502
G1 X86.943 Y89.357 E.12292
G1 X86.943 Y80.705 E.17397
M204 S10000
G1 X86.519 Y80.22 F18000
G1 F3600
M204 S6000
G1 X93.48 Y80.229 E.13997
G1 X93.481 Y89.781 E.19207
G1 X86.519 Y89.781 E.13998
G1 X86.519 Y80.28 E.19104
M204 S250
G1 X86.26 Y79.849 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1800
M204 S5000
G1 X86.407 Y79.81 E.00285
G1 X93.656 Y79.82 E.13544
G1 X93.798 Y79.89 E.00297
G1 X93.859 Y79.979 E.00201
G1 X93.89 Y80.105 E.00243
G1 X93.89 Y89.884 E.18272
G1 X93.873 Y89.989 E.00199
G1 X93.831 Y90.072 E.00175
G1 X93.731 Y90.157 E.00245
G1 X93.588 Y90.19 E.00275
G1 X86.416 Y90.19 E.134
G1 X86.311 Y90.173 E.00199
G1 X86.227 Y90.131 E.00176
G1 X86.143 Y90.031 E.00244
G1 X86.11 Y89.888 E.00275
G1 X86.11 Y80.117 E.18258
G1 X86.127 Y80.011 E.00199
G1 X86.169 Y79.927 E.00176
G1 X86.215 Y79.888 E.00112
; WIPE_START
M204 S6000
G1 X86.407 Y79.81 E-.02963
G1 X88.199 Y79.813 E-.25537
; WIPE_END
G1 E-.015
M204 S10000
G17
G3 Z4.32 I1.217 J0 P1  F18000
; stop printing object, unique label id: 12
M625
; object ids of layer 32 start: 8,12
M624 AwAAAAAAAAA=
;===================== date: 20250206 =====================

; don't support timelapse gcode in spiral_mode and by object sequence for I3 structure printer
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
G92 E0
G1 Z4.32
G1 X0 Y85.0002 ; move to safe pos
G1 X-13.0 F3000 ; move to safe pos
M400
M1004 S5 P1  ; external shutter
M400 P300
M971 S11 C11 O0
G92 E0
G1 X0 F18000
M623

; SKIPTYPE: head_wrap_detect
M622.1 S1
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




; object ids of this layer32 end: 8,12
M625
; start printing object, unique label id: 12
M624 AgAAAAAAAAA=
G1 X92.647 Y81.847
G1 Z3.92
G1 E.3 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.419992
G1 F4800
M204 S6000
G1 X92.647 Y81.061 E.01469
G1 X87.353 Y81.054 E.09892
G1 X87.353 Y81.847 E.01482
G1 X92.587 Y81.847 E.0978
; WIPE_START
G1 X90.587 Y81.847 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X87.749 Y81.451 Z4.32 F18000
G1 Z3.92
G1 E.3 F1800
; LINE_WIDTH: 0.421122
G1 F4800
M204 S6000
G1 X92.194 Y81.454 E.08329
; WIPE_START
G1 X90.194 Y81.453 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X92.647 Y88.153 Z4.32 F18000
G1 Z3.92
G1 E.3 F1800
; LINE_WIDTH: 0.419992
G1 F4800
M204 S6000
G1 X87.353 Y88.153 E.09893
G1 X87.353 Y88.947 E.01485
G1 X92.647 Y88.947 E.09893
G1 X92.647 Y88.213 E.01373
; WIPE_START
G1 X92.647 Y88.947 E-.10468
G1 X91.382 Y88.947 E-.18032
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X87.75 Y88.55 Z4.32 F18000
G1 Z3.92
G1 E.3 F1800
; LINE_WIDTH: 0.426072
G1 F4800
M204 S6000
G1 X92.19 Y88.55 E.08424
; OBJECT_ID: 8
; WIPE_START
G1 X90.19 Y88.55 E-.285
; WIPE_END
G1 E-.015 F1800
; stop printing object, unique label id: 12
M625
; start printing object, unique label id: 8
M624 AQAAAAAAAAA=
M204 S10000
G1 X82.558 Y88.627 Z4.32 F18000
G1 X69.659 Y88.757 Z4.32
G1 Z3.92
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F3600
M204 S6000
G1 X69.659 Y81.243 E.15107
G1 X71.166 Y81.243 E.0303
G1 X71.166 Y88.757 E.15107
G1 X69.719 Y88.757 E.02909
M204 S10000
G1 X69.235 Y89.181 F18000
G1 F3600
M204 S6000
G1 X69.235 Y80.819 E.16813
G1 X70.838 Y80.819 E.03222
G1 X70.838 Y80.619 E.00402
G1 X71.59 Y80.619 E.01513
G1 X71.59 Y89.381 E.17617
G1 X70.838 Y89.381 E.01513
G1 X70.838 Y89.181 E.00402
G1 X69.295 Y89.181 E.03102
M204 S250
G1 X68.826 Y89.59 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1800
M204 S5000
G1 X68.826 Y80.41 E.17153
G1 X70.429 Y80.41 E.02995
G1 X70.429 Y80.21 E.00374
G1 X72 Y80.21 E.02935
G1 X72 Y89.79 E.17901
G1 X70.429 Y89.79 E.02935
G1 X70.429 Y89.59 E.00374
G1 X68.886 Y89.59 E.02883
; WIPE_START
M204 S6000
G1 X68.873 Y87.59 E-.285
; WIPE_END
G1 E-.015
M204 S10000
G1 X70.142 Y88.003 Z4.32 F18000
G1 Z3.92
G1 E.3 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.567072
M73 P79 R4
G1 F4800
M204 S6000
G1 X70.142 Y88.274 E.00694
G1 X70.683 Y88.274 E.01389
G1 X70.683 Y81.726 E.16798
G1 X70.142 Y81.726 E.01389
G1 X70.142 Y87.943 E.1595
; WIPE_START
G1 X70.142 Y85.943 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X63.26 Y82.643 Z4.32 F18000
G1 X60.341 Y81.243 Z4.32
G1 Z3.92
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F3600
M204 S6000
G1 X60.341 Y88.757 E.15107
G1 X58.834 Y88.757 E.0303
G1 X58.834 Y81.243 E.15107
G1 X60.281 Y81.243 E.02909
M204 S10000
G1 X60.765 Y80.819 F18000
G1 F3600
M204 S6000
G1 X60.765 Y89.181 E.16813
G1 X59.161 Y89.181 E.03225
G1 X59.161 Y89.381 E.00402
G1 X58.41 Y89.381 E.01512
G1 X58.41 Y80.619 E.17617
G1 X59.161 Y80.619 E.01512
G1 X59.161 Y80.819 E.00402
G1 X60.705 Y80.819 E.03104
M204 S250
G1 X61.174 Y80.41 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1800
M204 S5000
G1 X61.174 Y89.59 E.17153
G1 X59.571 Y89.59 E.02996
G1 X59.571 Y89.79 E.00374
G1 X58 Y89.79 E.02935
G1 X58 Y80.21 E.17901
G1 X59.571 Y80.21 E.02935
G1 X59.571 Y80.41 E.00374
G1 X61.114 Y80.41 E.02884
; WIPE_START
M204 S6000
G1 X61.127 Y82.41 E-.285
; WIPE_END
G1 E-.015
M204 S10000
G1 X59.858 Y81.997 Z4.32 F18000
G1 Z3.92
G1 E.3 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.567052
G1 F4800
M204 S6000
G1 X59.858 Y81.726 E.00694
G1 X59.317 Y81.726 E.01389
G1 X59.317 Y88.274 E.16798
G1 X59.858 Y88.274 E.01389
G1 X59.858 Y82.057 E.1595
; CHANGE_LAYER
; Z_HEIGHT: 4.04
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F4800
G1 X59.858 Y84.057 E-.285
; WIPE_END
G1 E-.015 F1800
; stop printing object, unique label id: 8
M625
; layer num/total_layer_count: 33/57
; update layer progress
M73 L33
M991 S0 P32 ;notify layer change
M106 S71.4
; OBJECT_ID: 12
; start printing object, unique label id: 12
M624 AgAAAAAAAAA=
M204 S10000
G17
G3 Z4.32 I-.122 J1.211 P1  F18000
G1 X88.09 Y86.91 Z4.32
G1 Z4.04
G1 E.3 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
M204 S5000
G1 X88.09 Y83.09 E.07138
G1 X91.91 Y83.09 E.07138
G1 X91.91 Y86.91 E.07138
G1 X88.15 Y86.91 E.07026
; WIPE_START
M204 S6000
G1 X88.119 Y84.91 E-.285
; WIPE_END
G1 E-.015
M204 S10000
G1 X86.269 Y79.844 Z4.44 F18000
G1 Z4.04
G1 E.3 F1800
M204 S5000
G1 X86.397 Y79.81 E.00247
G1 X93.656 Y79.82 E.13564
G1 X93.798 Y79.89 E.00297
G1 X93.859 Y79.978 E.002
G1 X93.89 Y80.105 E.00244
G1 X93.89 Y89.884 E.18272
G1 X93.873 Y89.989 E.00199
G1 X93.831 Y90.073 E.00176
G1 X93.731 Y90.157 E.00244
G1 X93.588 Y90.19 E.00275
G1 X86.416 Y90.19 E.134
G1 X86.311 Y90.173 E.00199
G1 X86.227 Y90.131 E.00176
G1 X86.143 Y90.031 E.00244
G1 X86.11 Y89.888 E.00275
G1 X86.11 Y80.117 E.18258
G1 X86.127 Y80.011 E.00199
G1 X86.165 Y79.937 E.00156
G1 X86.224 Y79.884 E.00149
; WIPE_START
M204 S6000
G1 X86.397 Y79.81 E-.02674
G1 X88.209 Y79.813 E-.25826
; WIPE_END
G1 E-.015
M204 S10000
G17
G3 Z4.44 I1.217 J0 P1  F18000
; stop printing object, unique label id: 12
M625
; object ids of layer 33 start: 8,12
M624 AwAAAAAAAAA=
;===================== date: 20250206 =====================

; don't support timelapse gcode in spiral_mode and by object sequence for I3 structure printer
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
G92 E0
G1 Z4.44
G1 X0 Y85.0002 ; move to safe pos
G1 X-13.0 F3000 ; move to safe pos
M400
M1004 S5 P1  ; external shutter
M400 P300
M971 S11 C11 O0
G92 E0
G1 X0 F18000
M623

; SKIPTYPE: head_wrap_detect
M622.1 S1
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




; object ids of this layer33 end: 8,12
M625
; start printing object, unique label id: 12
M624 AgAAAAAAAAA=
G1 X93.673 Y80.589
G1 Z4.04
G1 E.3 F1800
; FEATURE: Top surface
G1 F3600
M204 S2000
G1 X93.12 Y80.036 E.01461
G1 X92.562 Y80.035
G1 X93.673 Y81.146 E.02936
G1 X93.673 Y81.704
G1 X92.003 Y80.034 E.04411
G1 X91.445 Y80.034
G1 X93.673 Y82.261 E.05887
G1 X93.673 Y82.819
G1 X90.887 Y80.033 E.07362
G1 X90.329 Y80.032
G1 X93.673 Y83.376 E.08837
G1 X93.673 Y83.934
G1 X89.771 Y80.031 E.10312
G1 X89.212 Y80.031
G1 X92.055 Y82.873 E.07511
G1 X91.497 Y82.873
G1 X88.654 Y80.03 E.07513
G1 X88.096 Y80.029
G1 X90.94 Y82.873 E.07515
G1 X90.382 Y82.873
G1 X87.538 Y80.029 E.07517
G1 X86.979 Y80.028
G1 X89.824 Y82.873 E.07519
G1 X89.267 Y82.873
G1 X86.422 Y80.028 E.07518
G1 X86.327 Y80.491
G1 X88.709 Y82.873 E.06296
G1 X88.152 Y82.873
G1 X86.327 Y81.048 E.04823
G1 X86.327 Y81.606
G1 X87.873 Y83.152 E.04086
G1 X87.873 Y83.71
G1 X86.327 Y82.163 E.04086
G1 X86.327 Y82.721
G1 X87.873 Y84.267 E.04086
G1 X87.873 Y84.825
G1 X86.327 Y83.278 E.04086
G1 X86.327 Y83.836
G1 X87.873 Y85.382 E.04086
G1 X87.873 Y85.94
G1 X86.327 Y84.393 E.04086
G1 X86.327 Y84.951
G1 X87.873 Y86.497 E.04086
G1 X87.873 Y87.055
G1 X86.327 Y85.508 E.04086
; WIPE_START
M204 S6000
G1 X87.741 Y86.923 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X92.127 Y82.945 Z4.44 F18000
G1 Z4.04
G1 E.3 F1800
G1 F3600
M204 S2000
G1 X93.673 Y84.491 E.04086
G1 X93.673 Y85.049
G1 X92.127 Y83.503 E.04086
G1 X92.127 Y84.06
G1 X93.673 Y85.607 E.04086
G1 X93.673 Y86.164
G1 X92.127 Y84.618 E.04086
G1 X92.127 Y85.176
G1 X93.673 Y86.722 E.04086
G1 X93.673 Y87.279
G1 X92.127 Y85.733 E.04086
G1 X92.127 Y86.291
G1 X93.673 Y87.837 E.04086
G1 X93.673 Y88.394
G1 X92.127 Y86.848 E.04086
G1 X91.848 Y87.127
G1 X93.673 Y88.952 E.04823
G1 X93.673 Y89.51
G1 X91.29 Y87.127 E.06296
G1 X90.733 Y87.127
G1 X93.576 Y89.97 E.07514
G1 X93.022 Y89.973
G1 X90.175 Y87.127 E.07522
G1 X89.618 Y87.127
G1 X92.464 Y89.973 E.07522
G1 X91.907 Y89.973
G1 X89.06 Y87.127 E.07522
G1 X88.503 Y87.127
G1 X91.349 Y89.973 E.07522
G1 X90.792 Y89.973
G1 X87.945 Y87.127 E.07522
; WIPE_START
M204 S6000
G1 X89.359 Y88.541 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X86.327 Y86.066 Z4.44 F18000
G1 Z4.04
G1 E.3 F1800
G1 F3600
M204 S2000
G1 X90.234 Y89.973 E.10325
G1 X89.676 Y89.973
G1 X86.327 Y86.624 E.08852
M73 P80 R3
G1 X86.327 Y87.181
G1 X89.119 Y89.973 E.07378
G1 X88.561 Y89.973
G1 X86.327 Y87.739 E.05905
G1 X86.327 Y88.296
G1 X88.004 Y89.973 E.04432
G1 X87.446 Y89.973
G1 X86.327 Y88.854 E.02958
G1 X86.327 Y89.411
G1 X86.889 Y89.973 E.01485
M204 S10000
G1 X86.594 Y89.993 F18000
; FEATURE: Gap infill
; LINE_WIDTH: 0.194019
G1 F2400
M204 S6000
G1 X86.407 Y89.898 E.00167
G1 X86.307 Y89.717 E.00165
; WIPE_START
G1 X86.407 Y89.898 E-.14137
G1 X86.594 Y89.993 E-.14363
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X91.097 Y83.831 Z4.44 F18000
G1 X93.693 Y80.28 Z4.44
G1 Z4.04
G1 E.3 F1800
; LINE_WIDTH: 0.19655
G1 F2400
M204 S6000
G1 X93.597 Y80.109 E.00158
G1 X93.468 Y80.016 E.00129
; WIPE_START
G1 X93.597 Y80.109 E-.12782
G1 X93.693 Y80.28 E-.15718
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X92.23 Y82.77 Z4.44 F18000
G1 Z4.04
G1 E.3 F1800
; LINE_WIDTH: 0.118975
G1 F2400
M204 S6000
G1 X92.143 Y82.857 E.00054
G1 X92.128 Y82.944 E.00039
; OBJECT_ID: 8
; WIPE_START
G1 X92.143 Y82.857 E-.11929
G1 X92.23 Y82.77 E-.16571
; WIPE_END
G1 E-.015 F1800
; stop printing object, unique label id: 12
M625
; start printing object, unique label id: 8
M624 AQAAAAAAAAA=
M204 S10000
G1 X84.855 Y84.735 Z4.44 F18000
G1 X69.762 Y88.757 Z4.44
G1 Z4.04
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F3600
M204 S6000
G1 X69.762 Y81.243 E.15107
G1 X71.183 Y81.243 E.02859
G1 X71.183 Y88.757 E.15107
G1 X69.822 Y88.757 E.02738
M204 S10000
G1 X69.337 Y89.181 F18000
G1 F3600
M204 S6000
G1 X69.337 Y80.819 E.16813
G1 X70.881 Y80.819 E.03104
G1 X70.881 Y80.619 E.00402
G1 X71.608 Y80.619 E.0146
G1 X71.608 Y89.381 E.17617
G1 X70.881 Y89.381 E.0146
G1 X70.881 Y89.181 E.00402
G1 X69.397 Y89.181 E.02984
M204 S250
G1 X68.928 Y89.59 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1800
M204 S5000
G1 X68.928 Y80.41 E.17153
G1 X70.472 Y80.41 E.02885
G1 X70.472 Y80.21 E.00374
G1 X72.017 Y80.21 E.02886
G1 X72.017 Y89.79 E.17901
G1 X70.472 Y89.79 E.02886
G1 X70.472 Y89.59 E.00374
G1 X68.988 Y89.59 E.02773
; WIPE_START
M204 S6000
G1 X68.975 Y87.59 E-.285
; WIPE_END
G1 E-.015
M204 S10000
G1 X70.223 Y81.954 Z4.44 F18000
G1 Z4.04
G1 E.3 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.524497
G1 F4800
M204 S6000
G1 X70.223 Y88.295 E.14988
G1 X70.722 Y88.295 E.01179
G1 X70.722 Y81.705 E.15578
G1 X70.223 Y81.705 E.01179
G1 X70.223 Y81.894 E.00448
; WIPE_START
G1 X70.223 Y81.705 E-.02699
G1 X70.722 Y81.705 E-.07107
G1 X70.722 Y83.017 E-.18694
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X63.196 Y81.744 Z4.44 F18000
G1 X60.238 Y81.243 Z4.44
G1 Z4.04
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F3600
M204 S6000
G1 X60.238 Y88.757 E.15107
G1 X58.817 Y88.757 E.02859
G1 X58.817 Y81.243 E.15107
G1 X60.178 Y81.243 E.02738
M204 S10000
G1 X60.663 Y80.819 F18000
G1 F3600
M204 S6000
G1 X60.663 Y89.181 E.16813
G1 X59.119 Y89.181 E.03104
G1 X59.119 Y89.381 E.00402
G1 X58.392 Y89.381 E.01461
G1 X58.392 Y80.619 E.17617
G1 X59.119 Y80.619 E.01461
G1 X59.119 Y80.819 E.00402
G1 X60.603 Y80.819 E.02983
M204 S250
G1 X61.072 Y80.41 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1800
M204 S5000
G1 X61.072 Y89.59 E.17153
G1 X59.528 Y89.59 E.02885
G1 X59.528 Y89.79 E.00374
G1 X57.983 Y89.79 E.02886
G1 X57.983 Y80.21 E.17901
G1 X59.528 Y80.21 E.02886
G1 X59.528 Y80.41 E.00374
G1 X61.012 Y80.41 E.02773
; WIPE_START
M204 S6000
G1 X61.025 Y82.41 E-.285
; WIPE_END
G1 E-.015
M204 S10000
G1 X59.777 Y81.954 Z4.44 F18000
G1 Z4.04
G1 E.3 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.524532
G1 F4800
M204 S6000
G1 X59.777 Y81.705 E.0059
G1 X59.278 Y81.705 E.01179
G1 X59.278 Y88.295 E.15579
G1 X59.777 Y88.295 E.01179
G1 X59.777 Y82.014 E.14847
; CHANGE_LAYER
; Z_HEIGHT: 4.16
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F4800
G1 X59.777 Y84.014 E-.285
; WIPE_END
G1 E-.015 F1800
; stop printing object, unique label id: 8
M625
; layer num/total_layer_count: 34/57
; update layer progress
M73 L34
M991 S0 P33 ;notify layer change
M106 S73.95
; OBJECT_ID: 8
; start printing object, unique label id: 8
M624 AQAAAAAAAAA=
M204 S10000
G17
G3 Z4.44 I-.517 J1.101 P1  F18000
G1 X69.871 Y88.757 Z4.44
G1 Z4.16
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1386
M204 S6000
G1 X69.871 Y81.243 E.15107
G1 X71.199 Y81.243 E.02671
G1 X71.199 Y88.757 E.15107
G1 X69.931 Y88.757 E.0255
M204 S10000
G1 X69.446 Y89.181 F18000
G1 F1386
M204 S6000
G1 X69.446 Y80.819 E.16813
G1 X70.921 Y80.819 E.02965
G1 X70.921 Y80.619 E.00402
G1 X71.623 Y80.619 E.01412
G1 X71.623 Y89.381 E.17617
G1 X70.921 Y89.381 E.01412
G1 X70.921 Y89.181 E.00402
G1 X69.506 Y89.181 E.02844
M204 S250
G1 X69.037 Y89.59 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1386
M204 S5000
G1 X69.037 Y80.41 E.17153
G1 X70.511 Y80.41 E.02755
G1 X70.512 Y80.21 E.00374
G1 X72.032 Y80.21 E.02842
G1 X72.032 Y89.79 E.17901
G1 X70.512 Y89.79 E.02841
G1 X70.511 Y89.59 E.00374
G1 X69.097 Y89.59 E.02643
; WIPE_START
G1 F1800
M204 S6000
G1 X69.084 Y87.59 E-.285
; WIPE_END
G1 E-.015
M204 S10000
G17
G3 Z4.56 I1.217 J0 P1  F18000
; stop printing object, unique label id: 8
M625
; object ids of layer 34 start: 8
M624 AQAAAAAAAAA=
;===================== date: 20250206 =====================

; don't support timelapse gcode in spiral_mode and by object sequence for I3 structure printer
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
G92 E0
G1 Z4.56
G1 X0 Y85.0002 ; move to safe pos
G1 X-13.0 F3000 ; move to safe pos
M400
M1004 S5 P1  ; external shutter
M400 P300
M971 S11 C11 O0
G92 E0
G1 X0 F18000
M623

; SKIPTYPE: head_wrap_detect
M622.1 S1
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




; object ids of this layer34 end: 8
M625
; start printing object, unique label id: 8
M624 AQAAAAAAAAA=
G1 X70.309 Y88.318
G1 Z4.16
G1 E.3 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.477722
G1 F1386
M204 S6000
G1 X70.761 Y88.318 E.00968
G1 X70.761 Y81.682 E.14217
G1 X70.309 Y81.682 E.00968
G1 X70.309 Y88.258 E.14089
; WIPE_START
G1 F4800
G1 X70.309 Y86.258 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X63.462 Y82.885 Z4.56 F18000
G1 X60.129 Y81.243 Z4.56
G1 Z4.16
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1386
M204 S6000
G1 X60.129 Y88.757 E.15107
G1 X58.801 Y88.757 E.02671
G1 X58.801 Y81.243 E.15107
G1 X60.069 Y81.243 E.0255
M204 S10000
G1 X60.554 Y80.819 F18000
G1 F1386
M204 S6000
G1 X60.554 Y89.181 E.16813
G1 X59.078 Y89.181 E.02967
G1 X59.079 Y89.381 E.00402
G1 X58.377 Y89.381 E.01411
G1 X58.377 Y80.619 E.17617
G1 X59.079 Y80.619 E.01411
G1 X59.078 Y80.819 E.00402
G1 X60.494 Y80.819 E.02846
M204 S250
G1 X60.963 Y80.41 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1386
M204 S5000
G1 X60.963 Y89.59 E.17153
G1 X59.488 Y89.59 E.02756
G1 X59.488 Y89.79 E.00374
G1 X57.968 Y89.79 E.02841
G1 X57.968 Y80.21 E.17901
G1 X59.488 Y80.21 E.02841
G1 X59.488 Y80.41 E.00374
G1 X60.903 Y80.41 E.02644
; WIPE_START
G1 F1800
M204 S6000
G1 X60.916 Y82.41 E-.285
; WIPE_END
G1 E-.015
M204 S10000
G1 X59.691 Y81.908 Z4.56 F18000
G1 Z4.16
G1 E.3 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.477762
G1 F1386
M204 S6000
G1 X59.691 Y81.682 E.00484
G1 X59.239 Y81.682 E.00968
G1 X59.239 Y88.318 E.14218
G1 X59.691 Y88.318 E.00968
G1 X59.691 Y81.968 E.13606
; CHANGE_LAYER
; Z_HEIGHT: 4.28
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F4800
G1 X59.691 Y83.968 E-.285
; WIPE_END
G1 E-.015 F1800
; stop printing object, unique label id: 8
M625
; layer num/total_layer_count: 35/57
; update layer progress
M73 L35
M991 S0 P34 ;notify layer change
; OBJECT_ID: 8
; start printing object, unique label id: 8
M624 AQAAAAAAAAA=
M204 S10000
G17
G3 Z4.56 I-.513 J1.103 P1  F18000
G1 X69.986 Y88.757 Z4.56
G1 Z4.28
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1376
M204 S6000
G1 X69.986 Y81.243 E.15107
G1 X71.212 Y81.243 E.02465
G1 X71.212 Y88.757 E.15107
G1 X70.046 Y88.757 E.02344
M204 S10000
G1 X69.562 Y89.181 F18000
G1 F1376
M204 S6000
G1 X69.562 Y80.819 E.16813
G1 X70.957 Y80.819 E.02804
G1 X70.957 Y80.619 E.00402
G1 X71.636 Y80.619 E.01367
G1 X71.636 Y89.381 E.17617
G1 X70.957 Y89.381 E.01367
G1 X70.957 Y89.181 E.00402
M73 P81 R3
G1 X69.622 Y89.181 E.02684
M204 S250
G1 X69.153 Y89.59 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1376
M204 S5000
G1 X69.153 Y80.41 E.17153
G1 X70.547 Y80.41 E.02605
G1 X70.547 Y80.21 E.00374
G1 X72.045 Y80.21 E.028
G1 X72.045 Y89.79 E.17901
G1 X70.547 Y89.79 E.028
G1 X70.547 Y89.59 E.00374
G1 X69.213 Y89.59 E.02493
; WIPE_START
G1 F1800
M204 S6000
G1 X69.2 Y87.59 E-.285
; WIPE_END
G1 E-.015
M204 S10000
G17
G3 Z4.68 I1.217 J0 P1  F18000
; stop printing object, unique label id: 8
M625
; object ids of layer 35 start: 8
M624 AQAAAAAAAAA=
;===================== date: 20250206 =====================

; don't support timelapse gcode in spiral_mode and by object sequence for I3 structure printer
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
G92 E0
G1 Z4.68
G1 X0 Y85.0002 ; move to safe pos
G1 X-13.0 F3000 ; move to safe pos
M400
M1004 S5 P1  ; external shutter
M400 P300
M971 S11 C11 O0
G92 E0
G1 X0 F18000
M623

; SKIPTYPE: head_wrap_detect
M622.1 S1
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




; object ids of this layer35 end: 8
M625
; start printing object, unique label id: 8
M624 AQAAAAAAAAA=
G1 X70.399 Y88.344
G1 Z4.28
G1 E.3 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.426472
G1 F1376
M204 S6000
G1 X70.799 Y88.344 E.00761
G1 X70.799 Y81.656 E.12702
G1 X70.399 Y81.656 E.00761
G1 X70.399 Y88.284 E.12588
; WIPE_START
G1 F4800
G1 X70.399 Y86.284 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X63.532 Y82.951 Z4.68 F18000
G1 X60.014 Y81.243 Z4.68
G1 Z4.28
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1376
M204 S6000
G1 X60.014 Y88.757 E.15107
G1 X58.788 Y88.757 E.02465
G1 X58.788 Y81.243 E.15107
G1 X59.954 Y81.243 E.02344
M204 S10000
G1 X60.438 Y80.819 F18000
G1 F1376
M204 S6000
G1 X60.438 Y89.181 E.16813
G1 X59.044 Y89.181 E.02803
G1 X59.044 Y89.381 E.00402
G1 X58.364 Y89.381 E.01368
G1 X58.364 Y80.619 E.17617
G1 X59.044 Y80.619 E.01368
G1 X59.044 Y80.819 E.00402
G1 X60.378 Y80.819 E.02681
M204 S250
G1 X60.847 Y80.41 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1376
M204 S5000
G1 X60.847 Y89.59 E.17153
G1 X59.453 Y89.59 E.02605
G1 X59.453 Y89.79 E.00374
G1 X57.955 Y89.79 E.028
G1 X57.955 Y80.21 E.17901
G1 X59.453 Y80.21 E.028
G1 X59.453 Y80.41 E.00374
G1 X60.787 Y80.41 E.02492
; WIPE_START
G1 F1800
M204 S6000
G1 X60.8 Y82.41 E-.285
; WIPE_END
G1 E-.015
M204 S10000
G1 X59.601 Y81.856 Z4.68 F18000
G1 Z4.28
G1 E.3 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.426502
G1 F1376
M204 S6000
G1 X59.601 Y81.656 E.00381
G1 X59.2 Y81.656 E.00761
G1 X59.2 Y88.344 E.12703
G1 X59.601 Y88.344 E.00761
G1 X59.601 Y81.916 E.12209
; CHANGE_LAYER
; Z_HEIGHT: 4.4
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F4800
G1 X59.601 Y83.916 E-.285
; WIPE_END
G1 E-.015 F1800
; stop printing object, unique label id: 8
M625
; layer num/total_layer_count: 36/57
; update layer progress
M73 L36
M991 S0 P35 ;notify layer change
; OBJECT_ID: 8
; start printing object, unique label id: 8
M624 AQAAAAAAAAA=
M204 S10000
G17
G3 Z4.68 I1.21 J.131 P1  F18000
G1 X59.892 Y81.243 Z4.68
G1 Z4.4
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1346
M204 S6000
G1 X59.892 Y88.757 E.15107
G1 X58.777 Y88.757 E.02241
G1 X58.777 Y81.243 E.15107
G1 X59.832 Y81.243 E.02121
M204 S10000
G1 X60.316 Y80.819 F18000
G1 F1346
M204 S6000
G1 X60.316 Y89.181 E.16813
G1 X59.012 Y89.181 E.02622
G1 X59.012 Y89.381 E.00402
G1 X58.353 Y89.381 E.01325
G1 X58.353 Y80.619 E.17617
G1 X59.012 Y80.619 E.01325
G1 X59.012 Y80.819 E.00402
G1 X60.256 Y80.819 E.02502
M204 S250
G1 X60.725 Y80.41 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1346
M204 S5000
G1 X60.725 Y89.59 E.17153
G1 X59.421 Y89.59 E.02436
G1 X59.421 Y89.79 E.00374
G1 X57.943 Y89.79 E.02762
G1 X57.943 Y80.21 E.17901
G1 X59.421 Y80.21 E.02762
G1 X59.421 Y80.41 E.00374
G1 X60.665 Y80.41 E.02324
; WIPE_START
G1 F1800
M204 S6000
G1 X60.678 Y82.41 E-.285
; WIPE_END
G1 E-.015
M204 S10000
G17
G3 Z4.8 I1.217 J0 P1  F18000
; stop printing object, unique label id: 8
M625
; object ids of layer 36 start: 8
M624 AQAAAAAAAAA=
;===================== date: 20250206 =====================

; don't support timelapse gcode in spiral_mode and by object sequence for I3 structure printer
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
G92 E0
G1 Z4.8
G1 X0 Y85.0002 ; move to safe pos
G1 X-13.0 F3000 ; move to safe pos
M400
M1004 S5 P1  ; external shutter
M400 P300
M971 S11 C11 O0
G92 E0
G1 X0 F18000
M623

; SKIPTYPE: head_wrap_detect
M622.1 S1
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




; object ids of this layer36 end: 8
M625
; start printing object, unique label id: 8
M624 AQAAAAAAAAA=
G1 X59.507 Y81.801
G1 Z4.4
G1 E.3 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.370982
G1 F1346
M204 S6000
M73 P82 R3
G1 X59.507 Y81.628 E.00282
G1 X59.162 Y81.628 E.00565
G1 X59.162 Y88.372 E.11034
G1 X59.507 Y88.372 E.00565
G1 X59.507 Y81.861 E.10654
; WIPE_START
G1 F4800
G1 X59.507 Y83.861 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X66.436 Y87.061 Z4.8 F18000
G1 X70.108 Y88.757 Z4.8
G1 Z4.4
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1346
M204 S6000
G1 X70.108 Y81.243 E.15107
G1 X71.223 Y81.243 E.02241
G1 X71.223 Y88.757 E.15107
G1 X70.168 Y88.757 E.02121
M204 S10000
G1 X69.684 Y89.181 F18000
G1 F1346
M204 S6000
G1 X69.684 Y80.819 E.16813
G1 X70.987 Y80.819 E.0262
G1 X70.987 Y80.619 E.00402
G1 X71.647 Y80.619 E.01327
G1 X71.647 Y89.381 E.17617
G1 X70.987 Y89.381 E.01327
G1 X70.987 Y89.181 E.00402
G1 X69.744 Y89.181 E.025
M204 S250
G1 X69.275 Y89.59 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1346
M204 S5000
G1 X69.275 Y80.41 E.17153
G1 X70.578 Y80.41 E.02435
G1 X70.579 Y80.21 E.00374
G1 X72.057 Y80.21 E.02762
G1 X72.057 Y89.79 E.17901
G1 X70.579 Y89.79 E.02762
G1 X70.578 Y89.59 E.00374
G1 X69.335 Y89.59 E.02323
; WIPE_START
G1 F1800
M204 S6000
G1 X69.322 Y87.59 E-.285
; WIPE_END
G1 E-.015
M204 S10000
G1 X70.493 Y88.372 Z4.8 F18000
G1 Z4.4
G1 E.3 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.370992
G1 F1346
M204 S6000
G1 X70.838 Y88.372 E.00565
G1 X70.838 Y81.628 E.11034
G1 X70.493 Y81.628 E.00565
G1 X70.493 Y88.312 E.10936
; CHANGE_LAYER
; Z_HEIGHT: 4.52
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F4800
G1 X70.493 Y86.312 E-.285
; WIPE_END
G1 E-.015 F1800
; stop printing object, unique label id: 8
M625
; layer num/total_layer_count: 37/57
; update layer progress
M73 L37
M991 S0 P36 ;notify layer change
; OBJECT_ID: 8
; start printing object, unique label id: 8
M624 AQAAAAAAAAA=
M204 S10000
G17
G3 Z4.8 I.52 J-1.1 P1  F18000
G1 X59.772 Y81.243 Z4.8
G1 Z4.52
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1223
M204 S6000
G1 X59.772 Y88.757 E.15107
G1 X58.768 Y88.757 E.02019
G1 X58.768 Y81.243 E.15107
G1 X59.712 Y81.243 E.01898
M204 S10000
G1 X60.196 Y80.819 F18000
G1 F1223
M204 S6000
G1 X60.196 Y89.181 E.16813
G1 X58.983 Y89.181 E.02438
G1 X58.984 Y89.381 E.00402
G1 X58.343 Y89.381 E.01287
G1 X58.343 Y80.619 E.17617
G1 X58.984 Y80.619 E.01287
G1 X58.984 Y80.819 E.00402
G1 X60.136 Y80.819 E.02317
M204 S250
G1 X60.605 Y80.41 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1223
M204 S5000
G1 X60.605 Y89.59 E.17153
G1 X59.393 Y89.59 E.02265
G1 X59.393 Y89.79 E.00374
G1 X57.934 Y89.79 E.02726
G1 X57.934 Y80.21 E.17901
G1 X59.393 Y80.21 E.02726
G1 X59.393 Y80.41 E.00374
G1 X60.545 Y80.41 E.02153
; WIPE_START
G1 F1800
M204 S6000
G1 X60.558 Y82.41 E-.285
; WIPE_END
G1 E-.015
M204 S10000
G17
G3 Z4.92 I1.217 J0 P1  F18000
; stop printing object, unique label id: 8
M625
; object ids of layer 37 start: 8
M624 AQAAAAAAAAA=
;===================== date: 20250206 =====================

; don't support timelapse gcode in spiral_mode and by object sequence for I3 structure printer
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
G92 E0
G1 Z4.92
G1 X0 Y85.0002 ; move to safe pos
G1 X-13.0 F3000 ; move to safe pos
M400
M1004 S5 P1  ; external shutter
M400 P300
M971 S11 C11 O0
G92 E0
G1 X0 F18000
M623

; SKIPTYPE: head_wrap_detect
M622.1 S1
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




; object ids of this layer37 end: 8
M625
; start printing object, unique label id: 8
M624 AQAAAAAAAAA=
G1 X59.27 Y81.456
G1 Z4.52
G1 E.3 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.605432
G1 F1223
M204 S6000
G1 X59.27 Y88.544 E.19476
; WIPE_START
G1 F2400
G1 X59.27 Y86.544 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X66.751 Y88.055 Z4.92 F18000
G1 X70.228 Y88.757 Z4.92
G1 Z4.52
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1223
M204 S6000
G1 X70.228 Y81.243 E.15107
G1 X71.232 Y81.243 E.02019
G1 X71.232 Y88.757 E.15107
G1 X70.288 Y88.757 E.01898
M204 S10000
G1 X69.804 Y89.181 F18000
G1 F1223
M204 S6000
G1 X69.804 Y80.819 E.16813
G1 X71.016 Y80.819 E.02437
G1 X71.016 Y80.619 E.00402
G1 X71.657 Y80.619 E.01288
G1 X71.657 Y89.381 E.17617
G1 X71.016 Y89.381 E.01288
G1 X71.016 Y89.181 E.00402
G1 X69.864 Y89.181 E.02316
M204 S250
G1 X69.395 Y89.59 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
M73 P83 R3
G1 F1223
M204 S5000
G1 X69.395 Y80.41 E.17153
G1 X70.607 Y80.41 E.02265
G1 X70.607 Y80.21 E.00374
G1 X72.066 Y80.21 E.02726
G1 X72.066 Y89.79 E.17901
G1 X70.607 Y89.79 E.02726
G1 X70.607 Y89.59 E.00374
G1 X69.455 Y89.59 E.02153
; WIPE_START
G1 F1800
M204 S6000
G1 X69.442 Y87.59 E-.285
; WIPE_END
G1 E-.015
M204 S10000
G1 X70.73 Y88.544 Z4.92 F18000
G1 Z4.52
G1 E.3 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.605492
G1 F1223
M204 S6000
G1 X70.73 Y81.456 E.19478
; CHANGE_LAYER
; Z_HEIGHT: 4.64
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F2400
G1 X70.73 Y83.456 E-.285
; WIPE_END
G1 E-.015 F1800
; stop printing object, unique label id: 8
M625
; layer num/total_layer_count: 38/57
; update layer progress
M73 L38
M991 S0 P37 ;notify layer change
; OBJECT_ID: 8
; start printing object, unique label id: 8
M624 AQAAAAAAAAA=
M204 S10000
G17
G3 Z4.92 I.238 J-1.193 P1  F18000
G1 X59.652 Y81.243 Z4.92
G1 Z4.64
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1216
M204 S6000
G1 X59.652 Y88.757 E.15107
G1 X58.76 Y88.757 E.01792
G1 X58.76 Y81.243 E.15107
G1 X59.592 Y81.243 E.01671
M204 S10000
G1 X60.076 Y80.819 F18000
G1 F1216
M204 S6000
G1 X60.076 Y89.181 E.16813
G1 X58.958 Y89.181 E.02248
G1 X58.958 Y89.381 E.00402
G1 X58.336 Y89.381 E.01251
G1 X58.336 Y80.619 E.17617
G1 X58.958 Y80.619 E.01251
G1 X58.958 Y80.819 E.00402
G1 X60.016 Y80.819 E.02127
M204 S250
G1 X60.485 Y80.41 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1216
M204 S5000
G1 X60.485 Y89.59 E.17153
G1 X59.367 Y89.59 E.02089
G1 X59.367 Y89.79 E.00374
G1 X57.927 Y89.79 E.02692
G1 X57.927 Y80.21 E.17901
G1 X59.367 Y80.21 E.02692
G1 X59.367 Y80.41 E.00374
G1 X60.425 Y80.41 E.01976
; WIPE_START
G1 F1800
M204 S6000
G1 X60.438 Y82.41 E-.285
; WIPE_END
G1 E-.015
M204 S10000
G17
G3 Z5.04 I1.217 J0 P1  F18000
; stop printing object, unique label id: 8
M625
; object ids of layer 38 start: 8
M624 AQAAAAAAAAA=
;===================== date: 20250206 =====================

; don't support timelapse gcode in spiral_mode and by object sequence for I3 structure printer
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
G92 E0
G1 Z5.04
G1 X0 Y85.0002 ; move to safe pos
G1 X-13.0 F3000 ; move to safe pos
M400
M1004 S5 P1  ; external shutter
M400 P300
M971 S11 C11 O0
G92 E0
G1 X0 F18000
M623

; SKIPTYPE: head_wrap_detect
M622.1 S1
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




; object ids of this layer38 end: 8
M625
; start printing object, unique label id: 8
M624 AQAAAAAAAAA=
G1 X59.206 Y81.456
G1 Z4.64
G1 E.3 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.492722
G1 F1216
M204 S6000
G1 X59.206 Y88.544 E.15689
; WIPE_START
G1 F2400
G1 X59.206 Y86.544 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X66.692 Y88.031 Z5.04 F18000
G1 X70.348 Y88.757 Z5.04
G1 Z4.64
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1216
M204 S6000
G1 X70.348 Y81.243 E.15107
G1 X71.24 Y81.243 E.01792
G1 X71.24 Y88.757 E.15107
G1 X70.408 Y88.757 E.01672
M204 S10000
G1 X69.924 Y89.181 F18000
G1 F1216
M204 S6000
G1 X69.924 Y80.819 E.16813
G1 X71.042 Y80.819 E.02248
G1 X71.042 Y80.619 E.00402
G1 X71.664 Y80.619 E.01251
G1 X71.664 Y89.381 E.17617
G1 X71.042 Y89.381 E.01251
G1 X71.042 Y89.181 E.00402
G1 X69.984 Y89.181 E.02127
M204 S250
G1 X69.515 Y89.59 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1216
M204 S5000
G1 X69.515 Y80.41 E.17153
G1 X70.633 Y80.41 E.02089
G1 X70.633 Y80.21 E.00374
G1 X72.073 Y80.21 E.02692
G1 X72.073 Y89.79 E.17901
G1 X70.633 Y89.79 E.02692
G1 X70.633 Y89.59 E.00374
G1 X69.575 Y89.59 E.01977
; WIPE_START
G1 F1800
M204 S6000
G1 X69.562 Y87.59 E-.285
; WIPE_END
G1 E-.015
M204 S10000
G1 X70.794 Y88.544 Z5.04 F18000
G1 Z4.64
G1 E.3 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.49286
G1 F1216
M204 S6000
G1 X70.794 Y81.456 E.15694
; CHANGE_LAYER
; Z_HEIGHT: 4.76
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F2400
G1 X70.794 Y83.456 E-.285
; WIPE_END
G1 E-.015 F1800
; stop printing object, unique label id: 8
M625
; layer num/total_layer_count: 39/57
; update layer progress
M73 L39
M991 S0 P38 ;notify layer change
; OBJECT_ID: 8
; start printing object, unique label id: 8
M624 AQAAAAAAAAA=
M204 S10000
G17
G3 Z5.04 I.235 J-1.194 P1  F18000
G1 X59.532 Y81.243 Z5.04
G1 Z4.76
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1203
M204 S6000
M73 P84 R3
G1 X59.532 Y88.757 E.15107
G1 X58.755 Y88.757 E.01562
G1 X58.755 Y81.243 E.15107
G1 X59.472 Y81.243 E.01441
M204 S10000
G1 X59.956 Y80.819 F18000
G1 F1203
M204 S6000
G1 X59.956 Y89.181 E.16813
G1 X58.935 Y89.181 E.02053
G1 X58.935 Y89.381 E.00402
G1 X58.331 Y89.381 E.01215
G1 X58.331 Y80.619 E.17617
G1 X58.935 Y80.619 E.01215
G1 X58.935 Y80.819 E.00402
G1 X59.896 Y80.819 E.01933
M204 S250
G1 X60.365 Y80.41 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1203
M204 S5000
G1 X60.365 Y89.59 E.17153
G1 X59.344 Y89.59 E.01908
G1 X59.344 Y89.79 E.00374
G1 X57.921 Y89.79 E.02659
G1 X57.921 Y80.21 E.17901
G1 X59.344 Y80.21 E.02659
G1 X59.344 Y80.41 E.00374
G1 X60.305 Y80.41 E.01795
; WIPE_START
G1 F1800
M204 S6000
G1 X60.318 Y82.41 E-.285
; WIPE_END
G1 E-.015
M204 S10000
G17
G3 Z5.16 I1.217 J0 P1  F18000
; stop printing object, unique label id: 8
M625
; object ids of layer 39 start: 8
M624 AQAAAAAAAAA=
;===================== date: 20250206 =====================

; don't support timelapse gcode in spiral_mode and by object sequence for I3 structure printer
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
G92 E0
G1 Z5.16
G1 X0 Y85.0002 ; move to safe pos
G1 X-13.0 F3000 ; move to safe pos
M400
M1004 S5 P1  ; external shutter
M400 P300
M971 S11 C11 O0
G92 E0
G1 X0 F18000
M623

; SKIPTYPE: head_wrap_detect
M622.1 S1
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




; object ids of this layer39 end: 8
M625
; start printing object, unique label id: 8
M624 AQAAAAAAAAA=
G1 X59.143 Y81.456
G1 Z4.76
G1 E.3 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.378092
G1 F1203
M204 S6000
G1 X59.143 Y88.544 E.11838
; WIPE_START
G1 F2400
G1 X59.143 Y86.544 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X66.634 Y88.008 Z5.16 F18000
G1 X70.468 Y88.757 Z5.16
G1 Z4.76
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1203
M204 S6000
G1 X70.468 Y81.243 E.15107
G1 X71.245 Y81.243 E.01562
G1 X71.245 Y88.757 E.15107
G1 X70.528 Y88.757 E.01441
M204 S10000
G1 X70.044 Y89.181 F18000
G1 F1203
M204 S6000
G1 X70.044 Y80.819 E.16813
G1 X71.065 Y80.819 E.02052
G1 X71.065 Y80.619 E.00402
G1 X71.669 Y80.619 E.01215
G1 X71.669 Y89.381 E.17617
G1 X71.065 Y89.381 E.01215
G1 X71.065 Y89.181 E.00402
G1 X70.104 Y89.181 E.01932
M204 S250
G1 X69.635 Y89.59 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1203
M204 S5000
G1 X69.635 Y80.41 E.17153
G1 X70.656 Y80.41 E.01907
G1 X70.656 Y80.21 E.00374
G1 X72.079 Y80.21 E.02659
G1 X72.079 Y89.79 E.17901
G1 X70.656 Y89.79 E.02659
G1 X70.656 Y89.59 E.00374
G1 X69.695 Y89.59 E.01795
; WIPE_START
G1 F1800
M204 S6000
G1 X69.682 Y87.59 E-.285
; WIPE_END
G1 E-.015
M204 S10000
G1 X70.857 Y88.544 Z5.16 F18000
G1 Z4.76
G1 E.3 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.378182
G1 F1203
M204 S6000
G1 X70.857 Y81.456 E.11841
; CHANGE_LAYER
; Z_HEIGHT: 4.88
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F2400
G1 X70.857 Y83.456 E-.285
; WIPE_END
G1 E-.015 F1800
; stop printing object, unique label id: 8
M625
; layer num/total_layer_count: 40/57
; update layer progress
M73 L40
M991 S0 P39 ;notify layer change
; OBJECT_ID: 8
; start printing object, unique label id: 8
M624 AQAAAAAAAAA=
M204 S10000
G17
G3 Z5.16 I.231 J-1.195 P1  F18000
G1 X59.412 Y81.243 Z5.16
G1 Z4.88
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1191
M204 S6000
G1 X59.412 Y88.757 E.15107
G1 X58.751 Y88.757 E.01327
G1 X58.751 Y81.243 E.15107
G1 X59.352 Y81.243 E.01206
M204 S10000
G1 X59.836 Y80.819 F18000
G1 F1191
M204 S6000
G1 X59.836 Y89.181 E.16813
G1 X58.914 Y89.181 E.01854
G1 X58.914 Y89.381 E.00402
G1 X58.327 Y89.381 E.0118
G1 X58.327 Y80.619 E.17617
G1 X58.914 Y80.619 E.0118
G1 X58.914 Y80.819 E.00402
G1 X59.776 Y80.819 E.01733
M204 S250
G1 X60.245 Y80.41 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1191
M204 S5000
G1 X60.245 Y89.59 E.17153
G1 X59.323 Y89.59 E.01722
G1 X59.324 Y89.79 E.00374
G1 X57.918 Y89.79 E.02626
G1 X57.918 Y80.21 E.17901
G1 X59.324 Y80.21 E.02626
G1 X59.323 Y80.41 E.00374
G1 X60.185 Y80.41 E.0161
; WIPE_START
G1 F1800
M204 S6000
G1 X60.198 Y82.41 E-.285
; WIPE_END
G1 E-.015
M204 S10000
G17
G3 Z5.28 I1.217 J0 P1  F18000
; stop printing object, unique label id: 8
M625
; object ids of layer 40 start: 8
M624 AQAAAAAAAAA=
;===================== date: 20250206 =====================

; don't support timelapse gcode in spiral_mode and by object sequence for I3 structure printer
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
G92 E0
G1 Z5.28
G1 X0 Y85.0002 ; move to safe pos
G1 X-13.0 F3000 ; move to safe pos
M400
M1004 S5 P1  ; external shutter
M400 P300
M971 S11 C11 O0
G92 E0
M73 P85 R3
G1 X0 F18000
M623

; SKIPTYPE: head_wrap_detect
M622.1 S1
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




; object ids of this layer40 end: 8
M625
; start printing object, unique label id: 8
M624 AQAAAAAAAAA=
G1 X59.082 Y81.456
G1 Z4.88
G1 E.3 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.261532
G1 F1191
M204 S6000
G1 X59.082 Y88.544 E.07922
; WIPE_START
G1 F2400
G1 X59.082 Y86.544 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
M73 P85 R2
G1 X66.577 Y87.985 Z5.28 F18000
G1 X70.588 Y88.757 Z5.28
G1 Z4.88
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1191
M204 S6000
G1 X70.588 Y81.243 E.15107
G1 X71.249 Y81.243 E.01327
G1 X71.249 Y88.757 E.15107
G1 X70.648 Y88.757 E.01207
M204 S10000
G1 X70.164 Y89.181 F18000
G1 F1191
M204 S6000
G1 X70.164 Y80.819 E.16813
G1 X71.086 Y80.819 E.01853
G1 X71.086 Y80.619 E.00402
G1 X71.673 Y80.619 E.0118
G1 X71.673 Y89.381 E.17617
G1 X71.086 Y89.381 E.0118
G1 X71.086 Y89.181 E.00402
G1 X70.224 Y89.181 E.01733
M204 S250
G1 X69.755 Y89.59 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1191
M204 S5000
G1 X69.755 Y80.41 E.17153
G1 X70.676 Y80.41 E.01722
G1 X70.676 Y80.21 E.00374
G1 X72.082 Y80.21 E.02627
G1 X72.082 Y89.79 E.17901
G1 X70.676 Y89.79 E.02627
G1 X70.676 Y89.59 E.00374
G1 X69.815 Y89.59 E.0161
; WIPE_START
G1 F1800
M204 S6000
G1 X69.802 Y87.59 E-.285
; WIPE_END
G1 E-.015
M204 S10000
G1 X70.919 Y88.544 Z5.28 F18000
G1 Z4.88
G1 E.3 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.261602
G1 F1191
M204 S6000
G1 X70.919 Y81.456 E.07924
; CHANGE_LAYER
; Z_HEIGHT: 5
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F2400
G1 X70.919 Y83.456 E-.285
; WIPE_END
G1 E-.015 F1800
; stop printing object, unique label id: 8
M625
; layer num/total_layer_count: 41/57
; update layer progress
M73 L41
M991 S0 P40 ;notify layer change
; OBJECT_ID: 8
; start printing object, unique label id: 8
M624 AQAAAAAAAAA=
M204 S10000
G17
G3 Z5.28 I.227 J-1.196 P1  F18000
G1 X59.292 Y81.243 Z5.28
G1 Z5
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1178
M204 S6000
G1 X59.292 Y88.757 E.15107
G1 X58.75 Y88.757 E.01089
G1 X58.75 Y81.243 E.15107
G1 X59.232 Y81.243 E.00968
M204 S10000
G1 X59.716 Y80.819 F18000
G1 F1178
M204 S6000
G1 X59.716 Y89.181 E.16813
G1 X58.896 Y89.181 E.01648
G1 X58.896 Y89.381 E.00402
G1 X58.326 Y89.381 E.01147
G1 X58.326 Y80.619 E.17617
G1 X58.896 Y80.619 E.01147
G1 X58.897 Y80.819 E.00402
G1 X59.656 Y80.819 E.01527
M204 S250
G1 X60.125 Y80.41 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1178
M204 S5000
G1 X60.125 Y89.59 E.17153
G1 X59.305 Y89.59 E.01532
G1 X59.305 Y89.79 E.00374
G1 X57.917 Y89.79 E.02595
G1 X57.917 Y80.21 E.17901
G1 X59.305 Y80.21 E.02595
G1 X59.306 Y80.41 E.00374
G1 X60.065 Y80.41 E.01419
; WIPE_START
G1 F1800
M204 S6000
G1 X60.078 Y82.41 E-.285
; WIPE_END
G1 E-.015
M204 S10000
G17
G3 Z5.4 I1.217 J0 P1  F18000
; stop printing object, unique label id: 8
M625
; object ids of layer 41 start: 8
M624 AQAAAAAAAAA=
;===================== date: 20250206 =====================

; don't support timelapse gcode in spiral_mode and by object sequence for I3 structure printer
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
G92 E0
G1 Z5.4
G1 X0 Y85.0002 ; move to safe pos
G1 X-13.0 F3000 ; move to safe pos
M400
M1004 S5 P1  ; external shutter
M400 P300
M971 S11 C11 O0
G92 E0
G1 X0 F18000
M623

; SKIPTYPE: head_wrap_detect
M622.1 S1
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




; object ids of this layer41 end: 8
M625
; start printing object, unique label id: 8
M624 AQAAAAAAAAA=
G1 X59.021 Y81.456
G1 Z5
G1 E.3 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.143042
G1 F1178
M204 S6000
G1 X59.021 Y88.544 E.03941
; WIPE_START
G1 F2400
G1 X59.021 Y86.544 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X66.52 Y87.964 Z5.4 F18000
G1 X70.708 Y88.757 Z5.4
G1 Z5
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1178
M204 S6000
G1 X70.708 Y81.243 E.15107
G1 X71.25 Y81.243 E.01089
G1 X71.25 Y88.757 E.15107
G1 X70.768 Y88.757 E.00968
M204 S10000
G1 X70.284 Y89.181 F18000
G1 F1178
M204 S6000
G1 X70.284 Y80.819 E.16813
G1 X71.104 Y80.819 E.01649
G1 X71.104 Y80.619 E.00402
G1 X71.674 Y80.619 E.01147
G1 X71.674 Y89.381 E.17617
M73 P86 R2
G1 X71.104 Y89.381 E.01147
G1 X71.104 Y89.181 E.00402
G1 X70.344 Y89.181 E.01528
M204 S250
G1 X69.875 Y89.59 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1178
M204 S5000
G1 X69.875 Y80.41 E.17153
G1 X70.695 Y80.41 E.01532
G1 X70.695 Y80.21 E.00374
G1 X72.084 Y80.21 E.02595
G1 X72.084 Y89.79 E.17901
G1 X70.695 Y89.79 E.02595
G1 X70.695 Y89.59 E.00374
G1 X69.935 Y89.59 E.0142
; WIPE_START
G1 F1800
M204 S6000
G1 X69.922 Y87.59 E-.285
; WIPE_END
G1 E-.015
M204 S10000
G1 X70.979 Y88.544 Z5.4 F18000
G1 Z5
G1 E.3 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.143122
G1 F1178
M204 S6000
G1 X70.979 Y81.456 E.03943
; CHANGE_LAYER
; Z_HEIGHT: 5.12
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F2400
G1 X70.979 Y83.456 E-.285
; WIPE_END
G1 E-.015 F1800
; stop printing object, unique label id: 8
M625
; layer num/total_layer_count: 42/57
; update layer progress
M73 L42
M991 S0 P41 ;notify layer change
; OBJECT_ID: 8
; start printing object, unique label id: 8
M624 AQAAAAAAAAA=
M204 S10000
G17
G3 Z5.4 I.224 J-1.196 P1  F18000
G1 X59.172 Y81.243 Z5.4
G1 Z5.12
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1001
M204 S6000
G1 X59.172 Y88.757 E.15107
G1 X58.75 Y88.757 E.00847
G1 X58.75 Y81.243 E.15107
G1 X59.112 Y81.243 E.00726
M204 S10000
G1 X59.596 Y80.819 F18000
G1 F1001
M204 S6000
G1 X59.596 Y89.181 E.16813
G1 X58.88 Y89.181 E.01439
G1 X58.88 Y89.381 E.00402
G1 X58.326 Y89.381 E.01113
G1 X58.326 Y80.619 E.17617
G1 X58.88 Y80.619 E.01114
G1 X58.88 Y80.819 E.00402
G1 X59.536 Y80.819 E.01318
M204 S250
G1 X60.005 Y80.41 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1001
M204 S5000
G1 X60.005 Y89.59 E.17153
G1 X59.289 Y89.59 E.01338
G1 X59.289 Y89.79 E.00374
G1 X57.917 Y89.79 E.02564
G1 X57.917 Y80.21 E.17901
G1 X59.289 Y80.21 E.02564
G1 X59.289 Y80.41 E.00374
G1 X59.945 Y80.41 E.01225
; WIPE_START
G1 F1800
M204 S6000
G1 X59.958 Y82.41 E-.285
; WIPE_END
G1 E-.015
M204 S10000
G1 X66.549 Y86.258 Z5.52 F18000
G1 X70.828 Y88.757 Z5.52
G1 Z5.12
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1001
M204 S6000
G1 X70.828 Y81.243 E.15107
G1 X71.249 Y81.243 E.00847
G1 X71.25 Y88.757 E.15107
G1 X70.888 Y88.757 E.00726
M204 S10000
G1 X70.404 Y89.181 F18000
G1 F1001
M204 S6000
G1 X70.404 Y80.819 E.16813
G1 X71.12 Y80.819 E.0144
G1 X71.12 Y80.619 E.00402
G1 X71.674 Y80.619 E.01113
G1 X71.674 Y89.381 E.17617
G1 X71.12 Y89.381 E.01113
G1 X71.12 Y89.181 E.00402
G1 X70.464 Y89.181 E.01319
M204 S250
G1 X69.995 Y89.59 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1001
M204 S5000
G1 X69.995 Y80.41 E.17153
G1 X70.711 Y80.41 E.01338
G1 X70.711 Y80.21 E.00374
G1 X72.083 Y80.21 E.02564
G1 X72.083 Y89.79 E.17901
G1 X70.711 Y89.79 E.02564
G1 X70.711 Y89.59 E.00374
G1 X70.055 Y89.59 E.01226
; WIPE_START
G1 F1800
M204 S6000
G1 X70.042 Y87.59 E-.285
; WIPE_END
G1 E-.015
M204 S10000
G17
G3 Z5.52 I1.217 J0 P1  F18000
; stop printing object, unique label id: 8
M625
; object ids of layer 42 start: 8
M624 AQAAAAAAAAA=
;===================== date: 20250206 =====================

; don't support timelapse gcode in spiral_mode and by object sequence for I3 structure printer
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
G92 E0
G1 Z5.52
G1 X0 Y85.0002 ; move to safe pos
G1 X-13.0 F3000 ; move to safe pos
M400
M1004 S5 P1  ; external shutter
M400 P300
M971 S11 C11 O0
G92 E0
G1 X0 F18000
M623

; SKIPTYPE: head_wrap_detect
M622.1 S1
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




; object ids of this layer42 end: 8
M625
; CHANGE_LAYER
; Z_HEIGHT: 5.24
; LAYER_HEIGHT: 0.12
; layer num/total_layer_count: 43/57
; update layer progress
M73 L43
M991 S0 P42 ;notify layer change
; OBJECT_ID: 8
; start printing object, unique label id: 8
M624 AQAAAAAAAAA=
G1 X59.052 Y81.243 F18000
G1 Z5.24
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1000
M204 S6000
G1 X59.052 Y88.757 E.15107
G1 X58.753 Y88.757 E.00601
G1 X58.753 Y81.243 E.15107
G1 X58.992 Y81.243 E.0048
M204 S10000
G1 X59.476 Y80.819 F18000
G1 F1000
M204 S6000
G1 X59.476 Y89.181 E.16813
G1 X58.865 Y89.181 E.01228
G1 X58.865 Y89.381 E.00402
G1 X58.329 Y89.381 E.01079
G1 X58.329 Y80.619 E.17617
G1 X58.865 Y80.619 E.01079
G1 X58.865 Y80.819 E.00402
M73 P87 R2
G1 X59.416 Y80.819 E.01107
M204 S250
G1 X59.885 Y80.41 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1000
M204 S5000
G1 X59.885 Y89.59 E.17153
G1 X59.275 Y89.59 E.01141
G1 X59.275 Y89.79 E.00374
G1 X57.919 Y89.79 E.02533
G1 X57.919 Y80.21 E.17901
G1 X59.275 Y80.21 E.02533
G1 X59.275 Y80.41 E.00374
G1 X59.825 Y80.41 E.01028
; WIPE_START
G1 F1800
M204 S6000
G1 X59.838 Y82.41 E-.285
; WIPE_END
G1 E-.015
M204 S10000
G1 X66.465 Y86.196 Z5.64 F18000
G1 X70.948 Y88.757 Z5.64
G1 Z5.24
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1000
M204 S6000
G1 X70.948 Y81.243 E.15107
G1 X71.247 Y81.243 E.00601
G1 X71.247 Y88.757 E.15107
G1 X71.008 Y88.757 E.0048
M204 S10000
G1 X70.524 Y89.181 F18000
G1 F1000
M204 S6000
G1 X70.524 Y80.819 E.16813
G1 X71.135 Y80.819 E.01228
G1 X71.135 Y80.619 E.00402
G1 X71.671 Y80.619 E.01079
G1 X71.671 Y89.381 E.17617
G1 X71.135 Y89.381 E.01079
G1 X71.135 Y89.181 E.00402
G1 X70.584 Y89.181 E.01108
M204 S250
G1 X70.115 Y89.59 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1000
M204 S5000
G1 X70.115 Y80.41 E.17153
G1 X70.725 Y80.41 E.01141
G1 X70.725 Y80.21 E.00374
G1 X72.081 Y80.21 E.02533
G1 X72.081 Y89.79 E.17901
G1 X70.725 Y89.79 E.02533
G1 X70.725 Y89.59 E.00374
G1 X70.175 Y89.59 E.01029
; WIPE_START
G1 F1800
M204 S6000
G1 X70.162 Y87.59 E-.285
; WIPE_END
G1 E-.015
M204 S10000
G17
G3 Z5.64 I1.217 J0 P1  F18000
; stop printing object, unique label id: 8
M625
; object ids of layer 43 start: 8
M624 AQAAAAAAAAA=
;===================== date: 20250206 =====================

; don't support timelapse gcode in spiral_mode and by object sequence for I3 structure printer
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
G92 E0
G1 Z5.64
G1 X0 Y85.0002 ; move to safe pos
G1 X-13.0 F3000 ; move to safe pos
M400
M1004 S5 P1  ; external shutter
M400 P300
M971 S11 C11 O0
G92 E0
G1 X0 F18000
M623

; SKIPTYPE: head_wrap_detect
M622.1 S1
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




; object ids of this layer43 end: 8
M625
; CHANGE_LAYER
; Z_HEIGHT: 5.36
; LAYER_HEIGHT: 0.12
; layer num/total_layer_count: 44/57
; update layer progress
M73 L44
M991 S0 P43 ;notify layer change
; OBJECT_ID: 8
; start printing object, unique label id: 8
M624 AQAAAAAAAAA=
G1 X58.853 Y80.619 F18000
G1 Z5.36
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F855
M204 S6000
G1 X58.853 Y89.381 E.17617
G1 X58.333 Y89.381 E.01046
G1 X58.333 Y80.619 E.17617
G1 X58.793 Y80.619 E.00925
M204 S250
G1 X59.262 Y80.21 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F855
M204 S5000
G1 X59.262 Y89.79 E.17901
G1 X57.924 Y89.79 E.02501
G1 X57.924 Y80.21 E.17901
G1 X59.202 Y80.21 E.02389
; WIPE_START
G1 F1800
M204 S6000
G1 X59.215 Y82.21 E-.285
; WIPE_END
G1 E-.015
M204 S10000
G17
G3 Z5.76 I1.217 J0 P1  F18000
; stop printing object, unique label id: 8
M625
; object ids of layer 44 start: 8
M624 AQAAAAAAAAA=
;===================== date: 20250206 =====================

; don't support timelapse gcode in spiral_mode and by object sequence for I3 structure printer
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
G92 E0
G1 Z5.76
G1 X0 Y85.0002 ; move to safe pos
G1 X-13.0 F3000 ; move to safe pos
M400
M1004 S5 P1  ; external shutter
M400 P300
M971 S11 C11 O0
G92 E0
G1 X0 F18000
M623

; SKIPTYPE: head_wrap_detect
M622.1 S1
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




; object ids of this layer44 end: 8
M625
; start printing object, unique label id: 8
M624 AQAAAAAAAAA=
G1 X58.593 Y80.831
G1 Z5.36
G1 E.3 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.121463
G1 F855
M204 S6000
G1 X58.593 Y89.169 E.03782
; WIPE_START
G1 F2400
G1 X58.593 Y87.169 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X66.11 Y88.493 Z5.76 F18000
G1 X71.147 Y89.381 Z5.76
G1 Z5.36
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F855
M204 S6000
G1 X71.147 Y80.619 E.17617
G1 X71.667 Y80.619 E.01046
G1 X71.667 Y89.381 E.17617
G1 X71.207 Y89.381 E.00925
M204 S250
G1 X70.738 Y89.79 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F855
M204 S5000
G1 X70.738 Y80.21 E.17901
G1 X72.076 Y80.21 E.02501
G1 X72.076 Y89.79 E.17901
G1 X70.798 Y89.79 E.02389
M204 S10000
G1 X71.407 Y89.169 F18000
; FEATURE: Gap infill
; LINE_WIDTH: 0.121462
G1 F855
M204 S6000
G1 X71.407 Y80.831 E.03782
; CHANGE_LAYER
; Z_HEIGHT: 5.48
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F2400
G1 X71.407 Y82.831 E-.285
; WIPE_END
G1 E-.015 F1800
; stop printing object, unique label id: 8
M625
; layer num/total_layer_count: 45/57
; update layer progress
M73 L45
M991 S0 P44 ;notify layer change
; OBJECT_ID: 8
; start printing object, unique label id: 8
M624 AQAAAAAAAAA=
M204 S10000
G17
M73 P88 R2
G3 Z5.76 I.211 J-1.199 P1  F18000
G1 X58.842 Y80.619 Z5.76
G1 Z5.48
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F845
M204 S6000
G1 X58.842 Y89.381 E.17617
G1 X58.339 Y89.381 E.0101
G1 X58.339 Y80.619 E.17617
G1 X58.782 Y80.619 E.00889
M204 S250
G1 X59.251 Y80.21 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F845
M204 S5000
G1 X59.251 Y89.79 E.17901
G1 X57.93 Y89.79 E.02468
G1 X57.93 Y80.21 E.17901
G1 X59.191 Y80.21 E.02356
; WIPE_START
G1 F1800
M204 S6000
G1 X59.204 Y82.21 E-.285
; WIPE_END
G1 E-.015
M204 S10000
G17
G3 Z5.88 I1.217 J0 P1  F18000
; stop printing object, unique label id: 8
M625
; object ids of layer 45 start: 8
M624 AQAAAAAAAAA=
;===================== date: 20250206 =====================

; don't support timelapse gcode in spiral_mode and by object sequence for I3 structure printer
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
G92 E0
G1 Z5.88
G1 X0 Y85.0002 ; move to safe pos
G1 X-13.0 F3000 ; move to safe pos
M400
M1004 S5 P1  ; external shutter
M400 P300
M971 S11 C11 O0
G92 E0
G1 X0 F18000
M623

; SKIPTYPE: head_wrap_detect
M622.1 S1
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




; object ids of this layer45 end: 8
M625
; start printing object, unique label id: 8
M624 AQAAAAAAAAA=
G1 X58.591 Y80.831
G1 Z5.48
G1 E.3 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.103883
G1 F845
M204 S6000
G1 X58.591 Y89.169 E.03087
; WIPE_START
G1 F2400
G1 X58.591 Y87.169 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X66.107 Y88.492 Z5.88 F18000
G1 X71.158 Y89.381 Z5.88
G1 Z5.48
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F845
M204 S6000
G1 X71.158 Y80.619 E.17617
G1 X71.661 Y80.619 E.0101
G1 X71.661 Y89.381 E.17617
G1 X71.218 Y89.381 E.00889
M204 S250
G1 X70.749 Y89.79 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F845
M204 S5000
G1 X70.749 Y80.21 E.17901
G1 X72.07 Y80.21 E.02468
G1 X72.07 Y89.79 E.17901
G1 X70.809 Y89.79 E.02356
M204 S10000
G1 X71.409 Y89.169 F18000
; FEATURE: Gap infill
; LINE_WIDTH: 0.103832
G1 F845
M204 S6000
G1 X71.409 Y80.831 E.03085
; CHANGE_LAYER
; Z_HEIGHT: 5.6
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F2400
G1 X71.409 Y82.831 E-.285
; WIPE_END
G1 E-.015 F1800
; stop printing object, unique label id: 8
M625
; layer num/total_layer_count: 46/57
; update layer progress
M73 L46
M991 S0 P45 ;notify layer change
; OBJECT_ID: 8
; start printing object, unique label id: 8
M624 AQAAAAAAAAA=
M204 S10000
G17
G3 Z5.88 I.211 J-1.199 P1  F18000
G1 X58.832 Y80.619 Z5.88
G1 Z5.6
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F843
M204 S6000
G1 X58.832 Y89.381 E.17617
G1 X58.348 Y89.381 E.00973
G1 X58.348 Y80.619 E.17617
G1 X58.772 Y80.619 E.00853
M204 S250
G1 X59.241 Y80.21 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F843
M204 S5000
G1 X59.241 Y89.79 E.17901
G1 X57.939 Y89.79 E.02434
G1 X57.939 Y80.21 E.17901
G1 X59.181 Y80.21 E.02322
; WIPE_START
G1 F1800
M204 S6000
G1 X59.194 Y82.21 E-.285
; WIPE_END
G1 E-.015
M204 S10000
G17
G3 Z6 I1.217 J0 P1  F18000
; stop printing object, unique label id: 8
M625
; object ids of layer 46 start: 8
M624 AQAAAAAAAAA=
;===================== date: 20250206 =====================

; don't support timelapse gcode in spiral_mode and by object sequence for I3 structure printer
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
G92 E0
G1 Z6
G1 X0 Y85.0002 ; move to safe pos
G1 X-13.0 F3000 ; move to safe pos
M400
M1004 S5 P1  ; external shutter
M400 P300
M971 S11 C11 O0
G92 E0
G1 X0 F18000
M623

; SKIPTYPE: head_wrap_detect
M622.1 S1
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




; object ids of this layer46 end: 8
M625
; start printing object, unique label id: 8
M624 AQAAAAAAAAA=
G1 X58.59 Y80.831
G1 Z5.6
G1 E.3 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.0856025
G1 F843
M204 S6000
G1 X58.59 Y89.169 E.02365
; WIPE_START
G1 F2400
G1 X58.59 Y87.169 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X66.107 Y88.491 Z6 F18000
G1 X71.168 Y89.381 Z6
G1 Z5.6
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F843
M204 S6000
M73 P89 R2
G1 X71.168 Y80.619 E.17617
G1 X71.652 Y80.619 E.00973
G1 X71.652 Y89.381 E.17617
G1 X71.228 Y89.381 E.00853
M204 S250
G1 X70.759 Y89.79 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F843
M204 S5000
G1 X70.759 Y80.21 E.17901
G1 X72.061 Y80.21 E.02434
G1 X72.061 Y89.79 E.17901
G1 X70.819 Y89.79 E.02322
M204 S10000
G1 X71.41 Y89.169 F18000
; FEATURE: Gap infill
; LINE_WIDTH: 0.0855221
G1 F843
M204 S6000
G1 X71.41 Y80.831 E.02362
; CHANGE_LAYER
; Z_HEIGHT: 5.72
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F2400
G1 X71.41 Y82.831 E-.285
; WIPE_END
G1 E-.015 F1800
; stop printing object, unique label id: 8
M625
; layer num/total_layer_count: 47/57
; update layer progress
M73 L47
M991 S0 P46 ;notify layer change
; OBJECT_ID: 8
; start printing object, unique label id: 8
M624 AQAAAAAAAAA=
M204 S10000
G17
G3 Z6 I-1.216 J-.043 P1  F18000
G1 X71.177 Y89.381 Z6
G1 Z5.72
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F675
M204 S6000
G1 X71.177 Y80.619 E.17617
G1 X71.641 Y80.619 E.00935
G1 X71.641 Y89.381 E.17617
G1 X71.237 Y89.381 E.00814
M204 S250
G1 X70.767 Y89.79 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F675
M204 S5000
G1 X70.767 Y80.21 E.17901
G1 X72.051 Y80.21 E.02398
G1 X72.051 Y89.79 E.17901
G1 X70.827 Y89.79 E.02286
; WIPE_START
G1 F1800
M204 S6000
G1 X70.815 Y87.79 E-.285
; WIPE_END
G1 E-.015
M204 S10000
G1 X64.264 Y83.873 Z6.12 F18000
G1 X58.824 Y80.619 Z6.12
G1 Z5.72
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F675
M204 S6000
G1 X58.824 Y89.381 E.17617
G1 X58.359 Y89.381 E.00935
G1 X58.359 Y80.619 E.17617
G1 X58.764 Y80.619 E.00814
M204 S250
G1 X59.233 Y80.21 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F675
M204 S5000
G1 X59.233 Y89.79 E.17901
G1 X57.949 Y89.79 E.02398
G1 X57.949 Y80.21 E.17901
G1 X59.173 Y80.21 E.02286
; WIPE_START
G1 F1800
M204 S6000
G1 X59.185 Y82.21 E-.285
; WIPE_END
G1 E-.015
M204 S10000
G17
G3 Z6.12 I1.217 J0 P1  F18000
; stop printing object, unique label id: 8
M625
; object ids of layer 47 start: 8
M624 AQAAAAAAAAA=
;===================== date: 20250206 =====================

; don't support timelapse gcode in spiral_mode and by object sequence for I3 structure printer
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
G92 E0
G1 Z6.12
G1 X0 Y85.0002 ; move to safe pos
G1 X-13.0 F3000 ; move to safe pos
M400
M1004 S5 P1  ; external shutter
M400 P300
M971 S11 C11 O0
G92 E0
G1 X0 F18000
M623

; SKIPTYPE: head_wrap_detect
M622.1 S1
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




; object ids of this layer47 end: 8
M625
; CHANGE_LAYER
; Z_HEIGHT: 5.84
; LAYER_HEIGHT: 0.12
; layer num/total_layer_count: 48/57
; update layer progress
M73 L48
M991 S0 P47 ;notify layer change
; OBJECT_ID: 8
; start printing object, unique label id: 8
M624 AQAAAAAAAAA=
G1 X58.816 Y80.624 F18000
G1 Z5.84
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F687
M204 S6000
G1 X58.816 Y89.381 E.17609
G1 X58.372 Y89.381 E.00894
G1 X58.372 Y80.622 E.17612
G1 X58.756 Y80.623 E.00773
M204 S250
G1 X59.225 Y80.216 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F687
M204 S5000
G1 X59.225 Y89.79 E.1789
G1 X57.962 Y89.79 E.0236
G1 X57.962 Y80.211 E.17899
G1 X59.165 Y80.216 E.02248
; WIPE_START
G1 F1800
M204 S6000
G1 X59.178 Y82.216 E-.285
; WIPE_END
M73 P90 R2
G1 E-.015
M204 S10000
M73 P90 R1
G1 X65.732 Y86.127 Z6.24 F18000
G1 X71.184 Y89.381 Z6.24
G1 Z5.84
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F687
M204 S6000
G1 X71.184 Y80.619 E.17617
G1 X71.628 Y80.619 E.00894
G1 X71.628 Y89.381 E.17617
G1 X71.244 Y89.381 E.00773
M204 S250
G1 X70.774 Y89.79 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F687
M204 S5000
G1 X70.774 Y80.21 E.17901
G1 X72.037 Y80.21 E.0236
G1 X72.038 Y89.79 E.17901
G1 X70.834 Y89.79 E.02248
; WIPE_START
G1 F1800
M204 S6000
G1 X70.822 Y87.79 E-.285
; WIPE_END
G1 E-.015
M204 S10000
G17
G3 Z6.24 I1.217 J0 P1  F18000
; stop printing object, unique label id: 8
M625
; object ids of layer 48 start: 8
M624 AQAAAAAAAAA=
;===================== date: 20250206 =====================

; don't support timelapse gcode in spiral_mode and by object sequence for I3 structure printer
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
G92 E0
G1 Z6.24
G1 X0 Y85.0002 ; move to safe pos
G1 X-13.0 F3000 ; move to safe pos
M400
M1004 S5 P1  ; external shutter
M400 P300
M971 S11 C11 O0
G92 E0
G1 X0 F18000
M623

; SKIPTYPE: head_wrap_detect
M622.1 S1
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




; object ids of this layer48 end: 8
M625
; CHANGE_LAYER
; Z_HEIGHT: 5.96
; LAYER_HEIGHT: 0.12
; layer num/total_layer_count: 49/57
; update layer progress
M73 L49
M991 S0 P48 ;notify layer change
; OBJECT_ID: 8
; start printing object, unique label id: 8
M624 AQAAAAAAAAA=
G1 X58.81 Y80.619 F18000
G1 Z5.96
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F685
M204 S6000
G1 X58.81 Y89.381 E.17617
G1 X58.387 Y89.381 E.0085
G1 X58.387 Y80.619 E.17617
G1 X58.75 Y80.619 E.00729
M204 S250
G1 X59.219 Y80.21 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F685
M204 S5000
G1 X59.219 Y89.79 E.17901
G1 X57.978 Y89.79 E.0232
G1 X57.978 Y80.21 E.17901
G1 X59.159 Y80.21 E.02207
; WIPE_START
G1 F1800
M204 S6000
G1 X59.172 Y82.21 E-.285
; WIPE_END
G1 E-.015
M204 S10000
G1 X65.726 Y86.121 Z6.36 F18000
G1 X71.19 Y89.381 Z6.36
G1 Z5.96
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F685
M204 S6000
G1 X71.19 Y80.619 E.17617
G1 X71.613 Y80.619 E.00851
G1 X71.613 Y89.381 E.17617
G1 X71.25 Y89.381 E.0073
M204 S250
G1 X70.781 Y89.79 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F685
M204 S5000
G1 X70.781 Y80.21 E.17901
G1 X72.022 Y80.21 E.0232
G1 X72.022 Y89.79 E.17901
G1 X70.841 Y89.79 E.02208
; WIPE_START
G1 F1800
M204 S6000
G1 X70.828 Y87.79 E-.285
; WIPE_END
G1 E-.015
M204 S10000
G17
G3 Z6.36 I1.217 J0 P1  F18000
; stop printing object, unique label id: 8
M625
; object ids of layer 49 start: 8
M624 AQAAAAAAAAA=
;===================== date: 20250206 =====================

; don't support timelapse gcode in spiral_mode and by object sequence for I3 structure printer
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
G92 E0
G1 Z6.36
G1 X0 Y85.0002 ; move to safe pos
G1 X-13.0 F3000 ; move to safe pos
M400
M1004 S5 P1  ; external shutter
M400 P300
M971 S11 C11 O0
G92 E0
G1 X0 F18000
M623

; SKIPTYPE: head_wrap_detect
M622.1 S1
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




; object ids of this layer49 end: 8
M625
; CHANGE_LAYER
; Z_HEIGHT: 6.08
; LAYER_HEIGHT: 0.12
; layer num/total_layer_count: 50/57
; update layer progress
M73 L50
M991 S0 P49 ;notify layer change
; OBJECT_ID: 8
; start printing object, unique label id: 8
M624 AQAAAAAAAAA=
G1 X58.804 Y80.619 F18000
G1 Z6.08
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F684
M204 S6000
G1 X58.805 Y89.381 E.17617
M73 P91 R1
G1 X58.405 Y89.381 E.00804
G1 X58.405 Y80.619 E.17617
G1 X58.744 Y80.619 E.00683
M204 S250
G1 X59.214 Y80.21 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F684
M204 S5000
G1 X59.214 Y89.79 E.17901
G1 X57.996 Y89.79 E.02276
G1 X57.996 Y80.21 E.17901
G1 X59.154 Y80.21 E.02164
; WIPE_START
G1 F1800
M204 S6000
G1 X59.166 Y82.21 E-.285
; WIPE_END
G1 E-.015
M204 S10000
G1 X65.722 Y86.118 Z6.48 F18000
G1 X71.196 Y89.381 Z6.48
G1 Z6.08
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F684
M204 S6000
G1 X71.196 Y80.619 E.17617
G1 X71.595 Y80.619 E.00804
G1 X71.595 Y89.381 E.17617
G1 X71.256 Y89.381 E.00683
M204 S250
G1 X70.786 Y89.79 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F684
M204 S5000
G1 X70.786 Y80.21 E.17901
G1 X72.005 Y80.21 E.02276
G1 X72.004 Y89.79 E.17901
G1 X70.846 Y89.79 E.02164
; WIPE_START
G1 F1800
M204 S6000
G1 X70.834 Y87.79 E-.285
; WIPE_END
G1 E-.015
M204 S10000
G17
G3 Z6.48 I1.217 J0 P1  F18000
; stop printing object, unique label id: 8
M625
; object ids of layer 50 start: 8
M624 AQAAAAAAAAA=
;===================== date: 20250206 =====================

; don't support timelapse gcode in spiral_mode and by object sequence for I3 structure printer
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
G92 E0
G1 Z6.48
G1 X0 Y85.0002 ; move to safe pos
G1 X-13.0 F3000 ; move to safe pos
M400
M1004 S5 P1  ; external shutter
M400 P300
M971 S11 C11 O0
G92 E0
G1 X0 F18000
M623

; SKIPTYPE: head_wrap_detect
M622.1 S1
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




; object ids of this layer50 end: 8
M625
; CHANGE_LAYER
; Z_HEIGHT: 6.2
; LAYER_HEIGHT: 0.12
; layer num/total_layer_count: 51/57
; update layer progress
M73 L51
M991 S0 P50 ;notify layer change
; OBJECT_ID: 8
; start printing object, unique label id: 8
M624 AQAAAAAAAAA=
G1 X58.8 Y80.619 F18000
G1 Z6.2
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F682
M204 S6000
G1 X58.8 Y89.381 E.17617
G1 X58.425 Y89.381 E.00753
G1 X58.425 Y80.619 E.17617
G1 X58.74 Y80.619 E.00632
M204 S250
G1 X59.209 Y80.21 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F682
M204 S5000
G1 X59.209 Y89.79 E.17901
G1 X58.016 Y89.79 E.02229
G1 X58.016 Y80.21 E.17901
G1 X59.149 Y80.21 E.02117
; WIPE_START
G1 F1800
M204 S6000
G1 X59.161 Y82.21 E-.285
; WIPE_END
G1 E-.015
M204 S10000
G1 X65.719 Y86.116 Z6.6 F18000
G1 X71.2 Y89.381 Z6.6
G1 Z6.2
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F682
M204 S6000
M73 P92 R1
G1 X71.2 Y80.619 E.17617
G1 X71.575 Y80.619 E.00754
G1 X71.575 Y89.381 E.17617
G1 X71.26 Y89.381 E.00633
M204 S250
G1 X70.791 Y89.79 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F682
M204 S5000
G1 X70.791 Y80.21 E.17901
G1 X71.984 Y80.21 E.0223
G1 X71.984 Y89.79 E.17901
G1 X70.851 Y89.79 E.02118
; WIPE_START
G1 F1800
M204 S6000
G1 X70.838 Y87.79 E-.285
; WIPE_END
G1 E-.015
M204 S10000
G17
G3 Z6.6 I1.217 J0 P1  F18000
; stop printing object, unique label id: 8
M625
; object ids of layer 51 start: 8
M624 AQAAAAAAAAA=
;===================== date: 20250206 =====================

; don't support timelapse gcode in spiral_mode and by object sequence for I3 structure printer
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
G92 E0
G1 Z6.6
G1 X0 Y85.0002 ; move to safe pos
G1 X-13.0 F3000 ; move to safe pos
M400
M1004 S5 P1  ; external shutter
M400 P300
M971 S11 C11 O0
G92 E0
G1 X0 F18000
M623

; SKIPTYPE: head_wrap_detect
M622.1 S1
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




; object ids of this layer51 end: 8
M625
; CHANGE_LAYER
; Z_HEIGHT: 6.32
; LAYER_HEIGHT: 0.12
; layer num/total_layer_count: 52/57
; update layer progress
M73 L52
M991 S0 P51 ;notify layer change
; OBJECT_ID: 8
; start printing object, unique label id: 8
M624 AQAAAAAAAAA=
G1 X58.795 Y80.619 F18000
G1 Z6.32
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F680
M204 S6000
G1 X58.795 Y89.381 E.17617
G1 X58.448 Y89.381 E.00698
G1 X58.448 Y80.619 E.17617
G1 X58.735 Y80.619 E.00577
M204 S250
G1 X59.205 Y80.21 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F680
M204 S5000
G1 X59.205 Y89.79 E.17901
G1 X58.039 Y89.79 E.02178
G1 X58.039 Y80.21 E.17901
G1 X59.145 Y80.21 E.02066
; WIPE_START
G1 F1800
M204 S6000
G1 X59.157 Y82.21 E-.285
; WIPE_END
G1 E-.015
M204 S10000
G1 X65.716 Y86.114 Z6.72 F18000
G1 X71.204 Y89.381 Z6.72
G1 Z6.32
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F680
M204 S6000
G1 X71.204 Y80.619 E.17617
G1 X71.552 Y80.619 E.00699
G1 X71.552 Y89.381 E.17617
G1 X71.264 Y89.381 E.00578
M204 S250
G1 X70.795 Y89.79 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F680
M204 S5000
G1 X70.795 Y80.21 E.17901
G1 X71.961 Y80.21 E.02179
G1 X71.961 Y89.79 E.17901
G1 X70.855 Y89.79 E.02066
; WIPE_START
G1 F1800
M204 S6000
G1 X70.843 Y87.79 E-.285
; WIPE_END
G1 E-.015
M204 S10000
G17
M73 P93 R1
G3 Z6.72 I1.217 J0 P1  F18000
; stop printing object, unique label id: 8
M625
; object ids of layer 52 start: 8
M624 AQAAAAAAAAA=
;===================== date: 20250206 =====================

; don't support timelapse gcode in spiral_mode and by object sequence for I3 structure printer
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
G92 E0
G1 Z6.72
G1 X0 Y85.0002 ; move to safe pos
G1 X-13.0 F3000 ; move to safe pos
M400
M1004 S5 P1  ; external shutter
M400 P300
M971 S11 C11 O0
G92 E0
G1 X0 F18000
M623

; SKIPTYPE: head_wrap_detect
M622.1 S1
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




; object ids of this layer52 end: 8
M625
; CHANGE_LAYER
; Z_HEIGHT: 6.44
; LAYER_HEIGHT: 0.12
; layer num/total_layer_count: 53/57
; update layer progress
M73 L53
M991 S0 P52 ;notify layer change
; OBJECT_ID: 8
; start printing object, unique label id: 8
M624 AQAAAAAAAAA=
G1 X58.792 Y80.619 F18000
G1 Z6.44
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F678
M204 S6000
G1 X58.792 Y89.381 E.17617
G1 X58.474 Y89.381 E.00638
G1 X58.474 Y80.619 E.17617
G1 X58.732 Y80.619 E.00518
M204 S250
G1 X59.201 Y80.21 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F678
M204 S5000
G1 X59.201 Y89.79 E.17901
G1 X58.065 Y89.79 E.02122
G1 X58.065 Y80.21 E.17901
G1 X59.141 Y80.21 E.0201
; WIPE_START
G1 F1800
M204 S6000
G1 X59.153 Y82.21 E-.285
; WIPE_END
G1 E-.015
M204 S10000
G1 X65.713 Y86.112 Z6.84 F18000
G1 X71.208 Y89.381 Z6.84
G1 Z6.44
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F678
M204 S6000
G1 X71.208 Y80.619 E.17617
G1 X71.526 Y80.619 E.00638
G1 X71.526 Y89.381 E.17617
G1 X71.268 Y89.381 E.00517
M204 S250
G1 X70.799 Y89.79 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F678
M204 S5000
G1 X70.799 Y80.21 E.17901
G1 X71.935 Y80.21 E.02122
G1 X71.935 Y89.79 E.17901
G1 X70.859 Y89.79 E.0201
; WIPE_START
G1 F1800
M204 S6000
G1 X70.846 Y87.79 E-.285
; WIPE_END
G1 E-.015
M204 S10000
G17
G3 Z6.84 I1.217 J0 P1  F18000
; stop printing object, unique label id: 8
M625
; object ids of layer 53 start: 8
M624 AQAAAAAAAAA=
;===================== date: 20250206 =====================

; don't support timelapse gcode in spiral_mode and by object sequence for I3 structure printer
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
G92 E0
G1 Z6.84
G1 X0 Y85.0002 ; move to safe pos
G1 X-13.0 F3000 ; move to safe pos
M400
M1004 S5 P1  ; external shutter
M400 P300
M971 S11 C11 O0
G92 E0
G1 X0 F18000
M623

; SKIPTYPE: head_wrap_detect
M622.1 S1
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




; object ids of this layer53 end: 8
M625
; CHANGE_LAYER
; Z_HEIGHT: 6.56
; LAYER_HEIGHT: 0.12
; layer num/total_layer_count: 54/57
; update layer progress
M73 L54
M991 S0 P53 ;notify layer change
; OBJECT_ID: 8
; start printing object, unique label id: 8
M624 AQAAAAAAAAA=
G1 X58.788 Y80.626 F18000
G1 Z6.56
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F676
M204 S6000
G1 X58.788 Y89.381 E.17603
G1 X58.504 Y89.381 E.00571
G1 X58.504 Y80.624 E.17608
G1 X58.728 Y80.626 E.00451
M204 S250
G1 X59.197 Y80.22 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F676
M204 S5000
G1 X59.197 Y89.79 E.17882
G1 X58.095 Y89.79 E.0206
G1 X58.095 Y80.212 E.17898
G1 X59.137 Y80.22 E.01948
; WIPE_START
G1 F1800
M204 S6000
G1 X59.15 Y82.22 E-.285
; WIPE_END
G1 E-.015
M204 S10000
G1 X65.713 Y86.116 Z6.96 F18000
G1 X71.212 Y89.381 Z6.96
M73 P94 R1
G1 Z6.56
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F676
M204 S6000
G1 X71.212 Y80.619 E.17617
G1 X71.496 Y80.619 E.00571
G1 X71.496 Y89.381 E.17617
G1 X71.272 Y89.381 E.00451
M204 S250
G1 X70.803 Y89.79 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F676
M204 S5000
G1 X70.803 Y80.21 E.17901
G1 X71.905 Y80.21 E.0206
G1 X71.905 Y89.79 E.17901
G1 X70.863 Y89.79 E.01948
; WIPE_START
G1 F1800
M204 S6000
G1 X70.85 Y87.79 E-.285
; WIPE_END
G1 E-.015
M204 S10000
G17
G3 Z6.96 I1.217 J0 P1  F18000
; stop printing object, unique label id: 8
M625
; object ids of layer 54 start: 8
M624 AQAAAAAAAAA=
;===================== date: 20250206 =====================

; don't support timelapse gcode in spiral_mode and by object sequence for I3 structure printer
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
G92 E0
G1 Z6.96
G1 X0 Y85.0002 ; move to safe pos
G1 X-13.0 F3000 ; move to safe pos
M400
M1004 S5 P1  ; external shutter
M400 P300
M971 S11 C11 O0
G92 E0
G1 X0 F18000
M623

; SKIPTYPE: head_wrap_detect
M622.1 S1
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




; object ids of this layer54 end: 8
M625
; CHANGE_LAYER
; Z_HEIGHT: 6.68
; LAYER_HEIGHT: 0.12
; layer num/total_layer_count: 55/57
; update layer progress
M73 L55
M991 S0 P54 ;notify layer change
M106 S76.5
; OBJECT_ID: 8
; start printing object, unique label id: 8
M624 AQAAAAAAAAA=
G1 X59.194 Y80.21 F18000
G1 Z6.68
G1 E.3 F1800
G1 F600
M204 S5000
G1 X59.193 Y89.79 E.17901
G1 X58.128 Y89.79 E.01991
G1 X58.128 Y80.21 E.17901
G1 X59.134 Y80.21 E.01879
; WIPE_START
G1 F1800
M204 S6000
G1 X59.146 Y82.21 E-.285
; WIPE_END
G1 E-.015
M204 S10000
G17
G3 Z7.08 I1.217 J0 P1  F18000
; stop printing object, unique label id: 8
M625
; object ids of layer 55 start: 8
M624 AQAAAAAAAAA=
;===================== date: 20250206 =====================

; don't support timelapse gcode in spiral_mode and by object sequence for I3 structure printer
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
G92 E0
G1 Z7.08
G1 X0 Y85.0002 ; move to safe pos
G1 X-13.0 F3000 ; move to safe pos
M400
M1004 S5 P1  ; external shutter
M400 P300
M971 S11 C11 O0
G92 E0
G1 X0 F18000
M623

; SKIPTYPE: head_wrap_detect
M622.1 S1
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




; object ids of this layer55 end: 8
M625
; start printing object, unique label id: 8
M624 AQAAAAAAAAA=
G1 X58.661 Y80.415
G1 Z6.68
G1 E.3 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.682156
G1 F600
M204 S6000
G1 X58.661 Y89.585 E.28531
; WIPE_START
G1 F2400
G1 X58.661 Y87.585 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X66.17 Y88.948 Z7.08 F18000
G1 X70.807 Y89.79 Z7.08
G1 Z6.68
G1 E.3 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F600
M204 S5000
G1 X70.807 Y80.21 E.17901
G1 X71.872 Y80.21 E.01991
G1 X71.872 Y89.79 E.17901
G1 X70.867 Y89.79 E.01879
M204 S10000
G1 X71.339 Y89.585 F18000
; FEATURE: Gap infill
; LINE_WIDTH: 0.682131
G1 F600
M204 S6000
G1 X71.339 Y80.415 E.2853
; CHANGE_LAYER
; Z_HEIGHT: 6.8
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F2400
G1 X71.339 Y82.415 E-.285
; WIPE_END
G1 E-.015 F1800
; stop printing object, unique label id: 8
M625
; layer num/total_layer_count: 56/57
; update layer progress
M73 L56
M991 S0 P55 ;notify layer change
; OBJECT_ID: 8
; start printing object, unique label id: 8
M624 AQAAAAAAAAA=
M204 S10000
G17
M73 P95 R0
G3 Z7.08 I.217 J-1.198 P1  F18000
G1 X59.161 Y80.21 Z7.08
G1 Z6.8
G1 E.3 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F600
M204 S5000
G1 X59.161 Y89.79 E.17901
G1 X58.206 Y89.79 E.01785
G1 X58.206 Y80.21 E.17901
G1 X59.101 Y80.21 E.01672
; WIPE_START
G1 F1800
M204 S6000
G1 X59.114 Y82.21 E-.285
; WIPE_END
G1 E-.015
M204 S10000
G17
G3 Z7.2 I1.217 J0 P1  F18000
; stop printing object, unique label id: 8
M625
; object ids of layer 56 start: 8
M624 AQAAAAAAAAA=
;===================== date: 20250206 =====================

; don't support timelapse gcode in spiral_mode and by object sequence for I3 structure printer
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
G92 E0
G1 Z7.2
G1 X0 Y85.0002 ; move to safe pos
G1 X-13.0 F3000 ; move to safe pos
M400
M1004 S5 P1  ; external shutter
M400 P300
M971 S11 C11 O0
G92 E0
G1 X0 F18000
M623

; SKIPTYPE: head_wrap_detect
M622.1 S1
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




; object ids of this layer56 end: 8
M625
; start printing object, unique label id: 8
M624 AQAAAAAAAAA=
G1 X58.684 Y80.415
G1 Z6.8
G1 E.3 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.571513
G1 F600
M204 S6000
G1 X58.684 Y89.585 E.23722
; WIPE_START
G1 F2400
G1 X58.684 Y87.585 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X66.194 Y88.948 Z7.2 F18000
G1 X70.839 Y89.79 Z7.2
G1 Z6.8
G1 E.3 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F600
M204 S5000
G1 X70.839 Y80.21 E.17901
G1 X71.794 Y80.21 E.01785
G1 X71.793 Y89.79 E.17901
G1 X70.899 Y89.79 E.01672
M204 S10000
G1 X71.316 Y89.585 F18000
; FEATURE: Gap infill
; LINE_WIDTH: 0.571507
G1 F600
M204 S6000
G1 X71.316 Y80.415 E.23722
; CHANGE_LAYER
; Z_HEIGHT: 6.92
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F2400
G1 X71.316 Y82.415 E-.285
; WIPE_END
G1 E-.015 F1800
; stop printing object, unique label id: 8
M625
; layer num/total_layer_count: 57/57
; update layer progress
M73 L57
M991 S0 P56 ;notify layer change
; OBJECT_ID: 8
; start printing object, unique label id: 8
M624 AQAAAAAAAAA=
M204 S10000
G17
G3 Z7.2 I.213 J-1.198 P1  F18000
G1 X58.795 Y80.188 Z7.2
G1 Z6.92
G1 E.3 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.376624
G1 F600
M204 S5000
G1 X58.795 Y89.812 E.16003
G1 X58.715 Y89.812 E.00133
G1 X58.715 Y80.188 E.16003
G1 X58.735 Y80.188 E.00033
; WIPE_START
G1 F1800
M204 S6000
G1 X58.747 Y82.188 E-.285
; WIPE_END
G1 E-.015
M204 S10000
G1 X65.258 Y86.172 Z7.32 F18000
G1 X71.206 Y89.812 Z7.32
G1 Z6.92
G1 E.3 F1800
G1 F600
M204 S5000
G1 X71.206 Y80.188 E.16003
G1 X71.286 Y80.188 E.00133
G1 X71.286 Y89.812 E.16003
M73 P96 R0
G1 X71.266 Y89.812 E.00033
; WIPE_START
G1 F1800
M204 S6000
G1 X71.253 Y87.812 E-.285
; WIPE_END
G1 E-.015
M204 S10000
G17
G3 Z7.32 I1.217 J0 P1  F18000
; stop printing object, unique label id: 8
M625
; object ids of layer 57 start: 8
M624 AQAAAAAAAAA=
;===================== date: 20250206 =====================

; don't support timelapse gcode in spiral_mode and by object sequence for I3 structure printer
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
G92 E0
G1 Z7.32
G1 X0 Y85.0002 ; move to safe pos
G1 X-13.0 F3000 ; move to safe pos
M400
M1004 S5 P1  ; external shutter
M400 P300
M971 S11 C11 O0
G92 E0
G1 X0 F18000
M623

; SKIPTYPE: head_wrap_detect
M622.1 S1
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




; object ids of this layer57 end: 8
M625
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
G1 Z7.32 F900 ; lower z a little
G1 X0 Y85.0002 F18000 ; move to safe pos
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

    G1 Z106.92 F600
    G1 Z104.92

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

