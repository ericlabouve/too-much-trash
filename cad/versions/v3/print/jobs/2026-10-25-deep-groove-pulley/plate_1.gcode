; HEADER_BLOCK_START
; BambuStudio 02.07.01.62
; model printing time: 6m 6s; total estimated time: 13m 14s
; total layer number: 33
; total filament length [mm] : 243.31
; total filament volume [cm^3] : 585.24
; total filament weight [g] : 0.73
; filament_density: 1.25
; filament_diameter: 1.75
; max_z_height: 4.04
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
M73 P0 R13
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
M73 P3 R12
    G1 E50 F200
    M400
    M1002 set_filament_type:PETG

    M104 S270

    G92 E0
    G1 E50 F149.669
    M400
    M106 P1 S178
    G92 E0
M73 P5 R12
    G1 E5 F149.669
    M109 S230 ; drop nozzle temp, make filament shink a bit
    M104 S210
    G92 E0
M73 P8 R12
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
M73 P41 R7
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
M73 P42 R7
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
    G29 A1 X81.0005 Y81 I17.999 J18
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
    
M73 P43 R7
    G1 X-13.5 F3000
    M400
    M984 A0.1 E1 S1 F0.591372 H0.4
    M106 P1 S178
    M400 S7
    G1 X0 F18000
M73 P45 R7
    G1 X-13.5 F3000
    G1 X0 F18000 ;wipe and shake
    G1 X-13.5 F3000
M73 P46 R7
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
; layer num/total_layer_count: 1/33
; update layer progress
M73 L1
M991 S0 P0 ;notify layer change
M106 S0
; OBJECT_ID: 8
G1 X94.89 Y92.434 F18000
M204 S6000
G1 Z.4
M73 P48 R6
G1 Z.2
M73 P49 R6
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.5
M204 S500
G1 X94.863 Y92.494 E.00236
G1 X94.591 Y92.966 E.01968
G1 X94.273 Y93.408 E.01966
G1 X93.913 Y93.816 E.01967
G1 X93.513 Y94.187 E.01968
M73 P50 R6
G1 X93.079 Y94.516 E.01967
G1 X92.614 Y94.8 E.01968
G1 X92.123 Y95.036 E.01966
G1 X91.611 Y95.223 E.01968
G1 X91.069 Y95.361 E.02018
G1 X90.286 Y95.459 E.02848
G1 X89.727 Y95.459 E.02018
G1 X89.185 Y95.405 E.01967
G1 X88.651 Y95.297 E.01967
G1 X88.13 Y95.136 E.01968
G1 X87.628 Y94.924 E.01967
M73 P51 R6
G1 X87.15 Y94.664 E.01968
G1 X86.7 Y94.357 E.01968
G1 X86.282 Y94.007 E.01967
M73 P52 R6
G1 X85.902 Y93.617 E.01967
M73 P53 R6
G1 X85.562 Y93.191 E.01967
G1 X85.267 Y92.733 E.01967
G1 X85.018 Y92.248 E.01968
G1 X84.819 Y91.741 E.01967
G1 X84.671 Y91.217 E.01966
G1 X84.577 Y90.68 E.01968
G1 X84.536 Y90.136 E.01968
G1 X84.55 Y89.592 E.01967
G1 X84.617 Y89.051 E.01969
G1 X84.738 Y88.52 E.01966
G1 X84.912 Y88.003 E.01968
G1 X85.136 Y87.506 E.01968
G1 X85.409 Y87.035 E.01966
G1 X85.727 Y86.592 E.01968
G1 X86.087 Y86.184 E.01967
G1 X86.487 Y85.813 E.01968
G1 X86.921 Y85.484 E.01967
G1 X87.386 Y85.2 E.01968
G1 X87.89 Y84.957 E.02019
G1 X88.637 Y84.706 E.02846
G1 X89.185 Y84.595 E.02019
G1 X89.728 Y84.541 E.01968
G1 X90.272 Y84.541 E.01966
G1 X90.814 Y84.595 E.01968
G1 X91.348 Y84.703 E.01967
G1 X91.869 Y84.864 E.01968
G1 X92.371 Y85.076 E.01968
G1 X92.85 Y85.336 E.01967
G1 X93.3 Y85.643 E.01967
G1 X93.717 Y85.993 E.01967
G1 X94.098 Y86.384 E.01968
G1 X94.437 Y86.809 E.01967
G1 X94.733 Y87.267 E.01967
G1 X94.982 Y87.752 E.01968
G1 X95.181 Y88.259 E.01967
G1 X95.328 Y88.784 E.01966
G1 X95.423 Y89.32 E.01968
G1 X95.464 Y89.864 E.01968
G1 X95.45 Y90.408 E.01967
G1 X95.382 Y90.949 E.01968
G1 X95.261 Y91.48 E.01966
G1 X95.087 Y91.997 E.01968
G1 X94.915 Y92.379 E.01514
M204 S6000
G1 X94.474 Y92.246 F18000
G1 F1800
M204 S500
G1 X94.456 Y92.285 E.00154
G1 X94.206 Y92.717 E.01803
G1 X93.915 Y93.122 E.01801
G1 X93.585 Y93.497 E.01803
G1 X93.219 Y93.836 E.01802
G1 X92.821 Y94.138 E.01803
G1 X92.395 Y94.398 E.01803
G1 X91.945 Y94.615 E.01801
G1 X91.476 Y94.786 E.01804
G1 X90.984 Y94.911 E.01833
G1 X90.258 Y95.002 E.02642
G1 X89.75 Y95.002 E.01833
G1 X89.253 Y94.952 E.01803
G1 X88.764 Y94.853 E.01802
G1 X88.287 Y94.706 E.01803
G1 X87.827 Y94.512 E.01802
G1 X87.388 Y94.273 E.01803
G1 X86.976 Y93.992 E.01802
G1 X86.594 Y93.671 E.01802
G1 X86.245 Y93.314 E.01802
M73 P54 R6
G1 X85.934 Y92.923 E.01803
G1 X85.663 Y92.504 E.01802
G1 X85.435 Y92.06 E.01803
G1 X85.253 Y91.595 E.01802
G1 X85.118 Y91.115 E.01801
G1 X85.031 Y90.623 E.01803
G1 X84.993 Y90.125 E.01803
G1 X85.006 Y89.626 E.01802
G1 X85.068 Y89.13 E.01803
G1 X85.179 Y88.644 E.01802
G1 X85.338 Y88.17 E.01803
G1 X85.543 Y87.715 E.01803
G1 X85.793 Y87.283 E.01802
G1 X86.084 Y86.878 E.01803
G1 X86.415 Y86.503 E.01803
G1 X86.781 Y86.164 E.01803
G1 X87.179 Y85.862 E.01803
G1 X87.605 Y85.602 E.01803
G1 X88.063 Y85.381 E.01834
G1 X88.756 Y85.149 E.0264
G1 X89.253 Y85.048 E.01834
G1 X89.75 Y84.998 E.01803
G1 X90.249 Y84.998 E.01801
G1 X90.746 Y85.048 E.01803
G1 X91.235 Y85.147 E.01802
G1 X91.713 Y85.294 E.01804
G1 X92.173 Y85.488 E.01803
G1 X92.611 Y85.727 E.01802
G1 X93.024 Y86.008 E.01803
G1 X93.406 Y86.329 E.01802
G1 X93.755 Y86.686 E.01803
G1 X94.066 Y87.077 E.01802
G1 X94.337 Y87.496 E.01803
G1 X94.565 Y87.94 E.01803
G1 X94.747 Y88.405 E.01802
G1 X94.882 Y88.885 E.01802
G1 X94.969 Y89.377 E.01803
G1 X95.006 Y89.875 E.01803
G1 X94.994 Y90.374 E.01802
G1 X94.932 Y90.87 E.01803
G1 X94.821 Y91.356 E.01802
G1 X94.662 Y91.83 E.01803
G1 X94.498 Y92.191 E.01432
M204 S6000
G1 X94.057 Y92.058 F18000
; FEATURE: Outer wall
G1 F1800
M204 S500
G1 X94.049 Y92.076 E.00072
G1 X93.822 Y92.469 E.01638
G1 X93.557 Y92.837 E.01637
G1 X93.257 Y93.177 E.01638
G1 X92.925 Y93.486 E.01638
G1 X92.563 Y93.76 E.01638
G1 X92.176 Y93.996 E.01638
G1 X91.767 Y94.193 E.01637
G1 X91.341 Y94.348 E.01639
G1 X90.899 Y94.461 E.01648
G1 X90.229 Y94.545 E.02435
G1 X89.773 Y94.545 E.01648
G1 X89.322 Y94.499 E.01638
G1 X88.877 Y94.41 E.01638
G1 X88.444 Y94.276 E.01638
G1 X88.026 Y94.1 E.01638
G1 X87.627 Y93.883 E.01639
G1 X87.252 Y93.627 E.01637
G1 X86.905 Y93.336 E.01638
G1 X86.588 Y93.011 E.01637
G1 X86.305 Y92.656 E.01638
G1 X86.059 Y92.275 E.01638
G1 X85.852 Y91.871 E.01638
G1 X85.686 Y91.449 E.01638
G1 X85.564 Y91.013 E.01637
G1 X85.485 Y90.566 E.01638
G1 X85.451 Y90.114 E.01638
G1 X85.462 Y89.66 E.01638
G1 X85.519 Y89.21 E.01638
G1 X85.62 Y88.768 E.01638
G1 X85.764 Y88.338 E.01638
G1 X85.951 Y87.924 E.01638
G1 X86.177 Y87.531 E.01637
G1 X86.442 Y87.163 E.01638
G1 X86.742 Y86.823 E.01638
G1 X87.075 Y86.514 E.01637
G1 X87.437 Y86.24 E.01638
G1 X87.824 Y86.004 E.01638
G1 X88.235 Y85.806 E.01649
G1 X88.874 Y85.591 E.02434
G1 X89.322 Y85.501 E.01649
G1 X89.773 Y85.455 E.01638
G1 X90.226 Y85.455 E.01637
G1 X90.678 Y85.501 E.01638
G1 X91.122 Y85.59 E.01638
G1 X91.556 Y85.724 E.01639
G1 X91.974 Y85.9 E.01638
G1 X92.373 Y86.117 E.01638
G1 X92.747 Y86.373 E.01637
G1 X93.095 Y86.664 E.01638
G1 X93.411 Y86.989 E.01638
G1 X93.694 Y87.344 E.01638
G1 X93.94 Y87.725 E.01638
G1 X94.148 Y88.129 E.01639
G1 X94.313 Y88.551 E.01638
G1 X94.436 Y88.987 E.01637
G1 X94.515 Y89.434 E.01638
G1 X94.549 Y89.887 E.01639
G1 X94.537 Y90.34 E.01637
G1 X94.481 Y90.79 E.01638
G1 X94.38 Y91.232 E.01638
G1 X94.235 Y91.663 E.01639
G1 X94.082 Y92.003 E.01349
; WIPE_START
G1 X94.049 Y92.076 E-.01137
G1 X93.822 Y92.469 E-.06466
G1 X93.557 Y92.837 E-.0646
G1 X93.257 Y93.177 E-.06466
G1 X92.925 Y93.486 E-.06463
G1 X92.84 Y93.55 E-.01507
; WIPE_END
G1 E-.015
M204 S6000
G1 X88.569 Y87.224 Z.6 F18000
G1 X85.926 Y83.309 Z.6
G1 Z.2
G1 E.3 F1800
; FEATURE: Inner wall
M204 S500
G1 X86.589 Y82.947 E.02728
G1 X87.303 Y82.645 E.02798
G1 X88.042 Y82.414 E.02798
G1 X88.814 Y82.256 E.02845
G1 X89.246 Y82.201 E.01571
G1 X89.618 Y82.174 E.01347
G1 X90.358 Y82.174 E.02671
G1 X90.795 Y82.205 E.01581
G1 X91.163 Y82.252 E.01342
G1 X91.886 Y82.397 E.02662
G1 X92.354 Y82.528 E.01754
G1 X93.093 Y82.803 E.02846
G1 X93.734 Y83.113 E.02571
G1 X94.398 Y83.517 E.02805
G1 X95.028 Y83.991 E.02849
G1 X95.619 Y84.54 E.02911
G1 X96.138 Y85.132 E.02843
G1 X96.589 Y85.762 E.02799
G1 X96.976 Y86.434 E.02797
G1 X97.294 Y87.141 E.02799
G1 X97.541 Y87.875 E.02798
G1 X97.714 Y88.631 E.02799
G1 X97.813 Y89.414 E.02851
G1 X97.831 Y90.22 E.02911
G1 X97.769 Y91.006 E.02845
G1 X97.632 Y91.769 E.02798
G1 X97.42 Y92.514 E.028
G1 X97.135 Y93.235 E.02798
G1 X96.78 Y93.925 E.02799
G1 X96.359 Y94.576 E.02799
G1 X95.876 Y95.182 E.028
G1 X95.335 Y95.737 E.02798
G1 X94.742 Y96.236 E.02799
G1 X94.103 Y96.674 E.02798
G1 X93.412 Y97.053 E.02842
G1 X92.67 Y97.366 E.02909
G1 X91.915 Y97.597 E.0285
G1 X91.156 Y97.749 E.02794
G1 X90.386 Y97.825 E.02795
G1 X89.612 Y97.825 E.02794
G1 X89.19 Y97.793 E.01527
G1 X88.822 Y97.746 E.0134
G1 X88.05 Y97.588 E.02847
G1 X87.31 Y97.358 E.02797
G1 X86.596 Y97.056 E.02796
G1 X85.916 Y96.686 E.02798
G1 X85.275 Y96.25 E.02798
G1 X84.681 Y95.752 E.02799
G1 X84.138 Y95.198 E.02799
G1 X83.654 Y94.593 E.02799
G1 X83.224 Y93.933 E.02844
G1 X83.015 Y93.551 E.01572
G1 X82.854 Y93.214 E.01349
G1 X82.583 Y92.525 E.02672
G1 X82.453 Y92.107 E.01583
G1 X82.362 Y91.746 E.01344
G1 X82.232 Y91.017 E.02674
G1 X82.186 Y90.581 E.01584
G1 X82.17 Y89.758 E.0297
G1 X82.225 Y89.037 E.0261
G1 X82.358 Y88.272 E.02804
G1 X82.57 Y87.512 E.0285
G1 X82.866 Y86.762 E.02911
G1 X83.227 Y86.062 E.02845
G1 X83.649 Y85.412 E.02797
G1 X84.133 Y84.807 E.02797
G1 X84.675 Y84.253 E.02799
G1 X85.269 Y83.755 E.02798
G1 X85.875 Y83.341 E.0265
M204 S6000
G1 X85.707 Y82.908 F18000
G1 F1800
M204 S500
G1 X86.39 Y82.535 E.02809
G1 X87.145 Y82.215 E.02962
G1 X87.928 Y81.971 E.02961
G1 X88.74 Y81.804 E.02991
G1 X89.201 Y81.746 E.01679
G1 X89.601 Y81.717 E.01449
G1 X90.374 Y81.717 E.0279
G1 X90.84 Y81.75 E.01686
G1 X91.237 Y81.8 E.01446
G1 X91.993 Y81.952 E.02785
G1 X92.496 Y82.094 E.01885
G1 X93.272 Y82.382 E.0299
G1 X93.953 Y82.711 E.02729
G1 X94.655 Y83.138 E.02966
G1 X95.317 Y83.637 E.02992
G1 X95.951 Y84.225 E.03124
G1 X96.497 Y84.848 E.02989
G1 X96.974 Y85.515 E.02962
G1 X97.383 Y86.226 E.02961
G1 X97.72 Y86.974 E.02962
G1 X97.981 Y87.751 E.02962
G1 X98.164 Y88.551 E.02962
G1 X98.269 Y89.374 E.02994
G1 X98.288 Y90.239 E.03125
G1 X98.223 Y91.064 E.0299
G1 X98.078 Y91.872 E.02962
G1 X97.853 Y92.661 E.02963
G1 X97.552 Y93.424 E.02962
G1 X97.176 Y94.154 E.02963
G1 X96.731 Y94.843 E.02963
G1 X96.219 Y95.485 E.02964
G1 X95.647 Y96.072 E.02962
G1 X95.019 Y96.6 E.02962
G1 X94.342 Y97.064 E.02962
G1 X93.617 Y97.462 E.02988
G1 X92.82 Y97.798 E.03122
G1 X92.027 Y98.04 E.02992
G1 X91.224 Y98.201 E.02958
G1 X90.409 Y98.282 E.02958
G1 X89.595 Y98.282 E.02938
G1 X89.144 Y98.248 E.01633
G1 X88.747 Y98.197 E.01445
G1 X87.936 Y98.031 E.0299
G1 X87.153 Y97.788 E.02961
G1 X86.397 Y97.469 E.0296
G1 X85.677 Y97.076 E.02961
G1 X84.999 Y96.615 E.02962
G1 X84.37 Y96.088 E.02963
G1 X83.796 Y95.502 E.02963
G1 X83.283 Y94.862 E.02963
G1 X82.831 Y94.167 E.0299
G1 X82.608 Y93.759 E.0168
G1 X82.435 Y93.396 E.01451
G1 X82.152 Y92.677 E.02791
G1 X82.013 Y92.231 E.01687
G1 X81.915 Y91.842 E.01447
G1 X81.779 Y91.081 E.02792
G1 X81.73 Y90.616 E.01688
G1 X81.713 Y89.741 E.0316
G1 X81.771 Y88.98 E.02754
G1 X81.912 Y88.172 E.02965
G1 X82.135 Y87.373 E.02993
G1 X82.451 Y86.568 E.03124
G1 X82.832 Y85.832 E.02991
G1 X83.278 Y85.144 E.02961
G1 X83.791 Y84.504 E.02961
G1 X84.364 Y83.917 E.02963
G1 X84.993 Y83.39 E.02962
G1 X85.655 Y82.938 E.02895
M204 S6000
G1 X85.488 Y82.507 F18000
; FEATURE: Outer wall
G1 F1800
M204 S500
G1 X86.191 Y82.123 E.02891
G1 X86.988 Y81.785 E.03126
G1 X87.814 Y81.528 E.03124
G1 X88.665 Y81.353 E.03136
G1 X89.156 Y81.291 E.01787
G1 X89.585 Y81.26 E.01552
G1 X90.39 Y81.26 E.02908
G1 X90.885 Y81.295 E.01791
G1 X91.311 Y81.349 E.01551
G1 X92.1 Y81.507 E.02907
G1 X92.638 Y81.659 E.02016
G1 X93.452 Y81.961 E.03135
G1 X94.172 Y82.309 E.02887
G1 X94.912 Y82.759 E.03128
G1 X95.605 Y83.282 E.03135
G1 X95.928 Y83.565 E.0155
G1 X96.283 Y83.91 E.01789
G1 X96.855 Y84.563 E.03136
G1 X97.359 Y85.267 E.03125
G1 X97.79 Y86.017 E.03125
G1 X98.146 Y86.807 E.03126
G1 X98.422 Y87.627 E.03125
G1 X98.615 Y88.471 E.03126
G1 X98.724 Y89.333 E.03137
G1 X98.746 Y89.762 E.0155
G1 X98.745 Y90.257 E.01789
G1 X98.677 Y91.123 E.03136
G1 X98.523 Y91.975 E.03126
G1 X98.287 Y92.808 E.03126
M73 P54 R5
G1 X97.969 Y93.613 E.03125
G1 X97.572 Y94.383 E.03127
G1 X97.102 Y95.11 E.03126
G1 X96.562 Y95.787 E.03128
G1 X95.958 Y96.407 E.03125
G1 X95.296 Y96.965 E.03126
G1 X94.582 Y97.454 E.03125
G1 X93.821 Y97.871 E.03134
G1 X93.369 Y98.075 E.0179
G1 X92.969 Y98.23 E.01547
G1 X92.139 Y98.484 E.03135
G1 X91.292 Y98.654 E.03121
G1 X90.431 Y98.739 E.03121
G1 X89.578 Y98.74 E.03083
G1 X89.097 Y98.703 E.01739
G1 X88.672 Y98.648 E.01549
G1 X87.822 Y98.474 E.03133
G1 X86.996 Y98.218 E.03124
G1 X86.199 Y97.881 E.03124
G1 X85.439 Y97.467 E.03124
G1 X84.723 Y96.98 E.03125
G1 X84.059 Y96.424 E.03126
G1 X83.454 Y95.805 E.03126
G1 X82.912 Y95.13 E.03126
G1 X82.438 Y94.402 E.03136
G1 X82.201 Y93.967 E.01789
G1 X82.016 Y93.579 E.01553
G1 X81.721 Y92.829 E.02909
G1 X81.573 Y92.355 E.01792
G1 X81.467 Y91.939 E.01552
G1 X81.326 Y91.145 E.0291
G1 X81.274 Y90.651 E.01792
G1 X81.256 Y89.724 E.0335
G1 X81.317 Y88.924 E.02898
G1 X81.466 Y88.071 E.03127
G1 X81.699 Y87.234 E.03136
G1 X81.845 Y86.83 E.0155
G1 X82.037 Y86.374 E.01789
G1 X82.436 Y85.602 E.03136
G1 X82.907 Y84.876 E.03124
G1 X83.448 Y84.201 E.03125
G1 X84.053 Y83.582 E.03126
G1 X84.716 Y83.026 E.03125
G1 X85.431 Y82.538 E.03124
G1 X85.435 Y82.536 E.00017
; WIPE_START
G1 X86.191 Y82.123 E-.12265
G1 X86.988 Y81.785 E-.12338
G1 X87.249 Y81.704 E-.03898
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
G1 X0 Y90.0001 ; move to safe pos
G1 X-13.0 F3000 ; move to safe pos
M400
M1004 S5 P1  ; external shutter
M400 P300
M971 S11 C11 O0
G92 E0
G1 X0 F18000
M623

; SKIPTYPE: head_wrap_detect
M622.1 S1
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




G1 X96.504 Y85.98
G1 Z.2
G1 E.3 F1800
; FEATURE: Bottom surface
; LINE_WIDTH: 0.50783
G1 F3000
M204 S500
G1 X95.266 Y84.743 E.06425
G1 X94.778 Y84.29 E.02446
G1 X94.179 Y83.839 E.02754
G1 X93.548 Y83.454 E.02714
G1 X93.107 Y83.241 E.01798
G1 X96.754 Y86.888 E.18939
G1 X96.932 Y87.283 E.0159
G1 X97.155 Y87.946 E.0257
G1 X92.057 Y82.848 E.26476
G1 X91.795 Y82.775 E.00997
G1 X91.208 Y82.657 E.02201
G1 X97.342 Y88.791 E.31861
G1 X97.427 Y89.534 E.02743
G1 X95.179 Y87.286 E.11674
M73 P55 R5
G1 X95.07 Y87.073 E.0088
G1 X94.753 Y86.582 E.02143
G1 X94.389 Y86.126 E.02143
G1 X93.982 Y85.708 E.02144
G1 X93.535 Y85.333 E.02143
G1 X93.053 Y85.004 E.02144
G1 X92.713 Y84.819 E.01421
G1 X90.464 Y82.571 E.11677
G1 X89.799 Y82.563 E.02445
G1 X91.615 Y84.379 E.09434
G1 X91.444 Y84.326 E.00657
G1 X90.78 Y84.202 E.02482
G1 X89.18 Y82.601 E.08312
G1 X88.614 Y82.693 E.02103
G1 X90.074 Y84.153 E.0758
G1 X89.708 Y84.153 E.01342
G1 X89.443 Y84.179 E.0098
G1 X88.075 Y82.811 E.07105
G1 X87.573 Y82.967 E.01928
G1 X88.869 Y84.263 E.0673
G1 X88.536 Y84.33 E.01246
G1 X88.344 Y84.395 E.00747
G1 X87.101 Y83.152 E.06455
G1 X86.758 Y83.297 E.01365
G1 X86.648 Y83.357 E.0046
G1 X87.851 Y84.56 E.06248
G1 X87.397 Y84.763 E.01828
G1 X86.223 Y83.59 E.06097
G1 X85.823 Y83.847 E.01747
G1 X86.973 Y84.997 E.05971
G1 X86.576 Y85.258 E.01743
G1 X85.439 Y84.12 E.05909
G1 X85.081 Y84.42 E.01714
G1 X86.205 Y85.544 E.05839
G1 X85.864 Y85.861 E.01709
G1 X84.743 Y84.739 E.05823
G1 X84.419 Y85.073 E.01708
G1 X85.551 Y86.205 E.05879
G1 X85.262 Y86.573 E.0172
G1 X84.126 Y85.438 E.05897
G1 X83.849 Y85.818 E.01728
G1 X84.999 Y86.968 E.05971
G1 X84.763 Y87.389 E.01774
G1 X83.59 Y86.217 E.0609
G1 X83.363 Y86.646 E.01786
G1 X84.558 Y87.842 E.06211
G1 X84.391 Y88.333 E.01903
G1 X83.153 Y87.094 E.06435
G1 X82.967 Y87.566 E.01862
G1 X84.262 Y88.861 E.06727
G1 X84.178 Y89.434 E.02127
G1 X82.817 Y88.073 E.07066
G1 X82.738 Y88.358 E.01086
G1 X82.694 Y88.608 E.00931
G1 X84.149 Y90.063 E.07557
G1 X84.198 Y90.769 E.026
G1 X82.604 Y89.175 E.08279
G1 X82.559 Y89.787 E.02255
G1 X84.694 Y91.922 E.11088
; WIPE_START
G1 X83.279 Y90.508 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S6000
G1 X90.759 Y88.988 Z.6 F18000
G1 X95.301 Y88.065 Z.6
G1 Z.2
G1 E.3 F1800
G1 F3000
M204 S500
G1 X97.442 Y90.206 E.11122
G1 X97.394 Y90.816 E.02245
G1 X95.8 Y89.222 E.0828
G1 X95.851 Y89.93 E.02607
G1 X97.306 Y91.385 E.07559
G1 X97.253 Y91.681 E.01103
G1 X97.184 Y91.921 E.00918
G1 X95.823 Y90.559 E.07072
G1 X95.739 Y91.133 E.02129
G1 X97.035 Y92.429 E.06734
G1 X96.849 Y92.901 E.01861
G1 X95.61 Y91.662 E.06436
G1 X95.444 Y92.153 E.01904
G1 X96.64 Y93.349 E.06212
G1 X96.412 Y93.779 E.01786
G1 X95.239 Y92.606 E.06092
G1 X95.004 Y93.028 E.01775
G1 X96.154 Y94.178 E.05974
G1 X95.876 Y94.558 E.01728
G1 X94.741 Y93.422 E.05897
G1 X94.453 Y93.791 E.0172
G1 X95.585 Y94.924 E.0588
G1 X95.26 Y95.257 E.01708
G1 X94.139 Y94.136 E.05822
G1 X93.798 Y94.452 E.01709
G1 X94.923 Y95.576 E.05839
G1 X94.566 Y95.877 E.01714
G1 X93.428 Y94.739 E.0591
G1 X93.031 Y95 E.01743
G1 X94.181 Y96.15 E.0597
G1 X93.781 Y96.407 E.01747
G1 X92.608 Y95.234 E.06093
G1 X92.155 Y95.438 E.01826
G1 X93.356 Y96.64 E.06242
G1 X93.243 Y96.702 E.00475
G1 X92.904 Y96.845 E.0135
G1 X91.668 Y95.609 E.0642
G1 X91.144 Y95.743 E.01986
G1 X92.433 Y97.032 E.06697
G1 X91.93 Y97.186 E.01934
G1 X90.56 Y95.816 E.07114
G1 X90.311 Y95.847 E.00923
G1 X89.934 Y95.847 E.01384
G1 X91.392 Y97.305 E.07572
G1 X91.099 Y97.364 E.01096
G1 X90.82 Y97.391 E.01028
G1 X89.228 Y95.799 E.08269
G1 X88.555 Y95.674 E.02513
G1 X88.396 Y95.624 E.00614
G1 X90.208 Y97.437 E.09412
G1 X89.544 Y97.431 E.02436
G1 X87.304 Y95.19 E.11637
G1 X86.947 Y94.996 E.01492
G1 X86.465 Y94.667 E.02144
G1 X86.018 Y94.292 E.02143
G1 X85.61 Y93.874 E.02143
G1 X85.246 Y93.418 E.02144
G1 X84.93 Y92.928 E.02143
G1 X84.812 Y92.698 E.00946
G1 X82.572 Y90.458 E.11634
G1 X82.617 Y90.962 E.01859
G1 X82.66 Y91.203 E.00899
G1 X88.802 Y97.345 E.31898
G1 X88.146 Y97.211 E.02456
G1 X87.948 Y97.149 E.00761
G1 X82.839 Y92.04 E.26535
G1 X82.95 Y92.396 E.01369
G1 X83.22 Y93.079 E.02697
G1 X86.908 Y96.766 E.19151
G1 X86.765 Y96.706 E.00568
M73 P56 R5
G1 X86.119 Y96.354 E.02705
G1 X85.51 Y95.939 E.02704
G1 X84.978 Y95.494 E.02546
G1 X83.489 Y94.005 E.07738
; CHANGE_LAYER
; Z_HEIGHT: 0.32
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F3000
G1 X84.903 Y95.419 E-.285
; WIPE_END
G1 E-.015 F1800
; layer num/total_layer_count: 2/33
; update layer progress
M73 L2
M991 S0 P1 ;notify layer change
; open powerlost recovery
M1003 S1
M104 S245 ; set nozzle temperature
; OBJECT_ID: 8
M204 S10000
G17
G3 Z.6 I.357 J1.163 P1  F18000
G1 X94.779 Y92.386 Z.6
G1 Z.32
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F3600
M204 S6000
G1 X94.756 Y92.439 E.00115
G1 X94.483 Y92.912 E.01099
G1 X94.009 Y93.535 E.01574
G1 X93.635 Y93.918 E.01077
G1 X93.227 Y94.261 E.01071
G1 X92.787 Y94.561 E.01071
G1 X92.319 Y94.815 E.01071
G1 X91.828 Y95.022 E.01071
G1 X91.319 Y95.18 E.01072
G1 X90.796 Y95.285 E.01071
G1 X90.266 Y95.338 E.01072
G1 X89.733 Y95.338 E.01071
G1 X89.203 Y95.285 E.01071
G1 X88.681 Y95.18 E.01071
G1 X88.172 Y95.022 E.01072
G1 X87.681 Y94.815 E.01072
G1 X87.213 Y94.561 E.01071
G1 X86.773 Y94.26 E.01072
G1 X86.364 Y93.918 E.01071
G1 X85.992 Y93.536 E.01072
G1 X85.66 Y93.12 E.01071
G1 X85.371 Y92.672 E.01071
G1 X85.128 Y92.198 E.01072
G1 X84.933 Y91.702 E.01071
G1 X84.789 Y91.19 E.01071
G1 X84.697 Y90.665 E.01072
G1 X84.657 Y90.133 E.01071
G1 X84.67 Y89.601 E.01071
G1 X84.736 Y89.072 E.01071
G1 X84.855 Y88.552 E.01072
G1 X85.024 Y88.047 E.01071
G1 X85.244 Y87.562 E.01072
G1 X85.51 Y87.1 E.01071
G1 X85.821 Y86.668 E.01072
G1 X86.174 Y86.268 E.01072
G1 X86.564 Y85.906 E.01071
G1 X86.989 Y85.584 E.01071
G1 X87.444 Y85.306 E.01072
G1 X87.924 Y85.075 E.01071
G1 X88.425 Y84.893 E.01072
G1 X88.954 Y84.758 E.01099
G1 X89.731 Y84.662 E.01574
G1 X90.266 Y84.662 E.01077
G1 X90.796 Y84.715 E.01071
G1 X91.319 Y84.82 E.01071
G1 X91.828 Y84.978 E.01072
G1 X92.319 Y85.185 E.01072
G1 X92.787 Y85.439 E.01071
G1 X93.227 Y85.74 E.01071
G1 X93.635 Y86.082 E.01072
G1 X94.007 Y86.463 E.01071
G1 X94.339 Y86.88 E.01071
G1 X94.628 Y87.328 E.01071
G1 X94.872 Y87.802 E.01072
G1 X95.066 Y88.298 E.01071
G1 X95.211 Y88.81 E.01071
G1 X95.303 Y89.335 E.01072
G1 X95.343 Y89.867 E.01071
G1 X95.33 Y90.399 E.01072
G1 X95.263 Y90.928 E.01071
G1 X95.145 Y91.448 E.01072
G1 X94.975 Y91.953 E.01071
G1 X94.804 Y92.332 E.00836
M204 S10000
G1 X94.393 Y92.212 F18000
G1 F3600
M204 S6000
G1 X94.378 Y92.245 E.00072
G1 X94.129 Y92.676 E.01002
G1 X93.687 Y93.257 E.01467
G1 X93.346 Y93.607 E.00982
G1 X92.97 Y93.922 E.00986
G1 X92.565 Y94.198 E.00986
G1 X92.135 Y94.433 E.00986
G1 X91.683 Y94.623 E.00986
G1 X91.214 Y94.768 E.00987
G1 X90.733 Y94.865 E.00986
G1 X90.245 Y94.914 E.00986
G1 X89.755 Y94.914 E.00986
G1 X89.267 Y94.865 E.00986
G1 X88.786 Y94.768 E.00986
G1 X88.317 Y94.623 E.00986
G1 X87.865 Y94.433 E.00986
G1 X87.434 Y94.198 E.00986
G1 X87.029 Y93.922 E.00986
G1 X86.653 Y93.607 E.00986
G1 X86.311 Y93.255 E.00986
G1 X86.005 Y92.872 E.00986
G1 X85.739 Y92.46 E.00986
G1 X85.515 Y92.023 E.00987
G1 X85.336 Y91.567 E.00986
G1 X85.203 Y91.095 E.00986
G1 X85.118 Y90.612 E.00986
G1 X85.081 Y90.123 E.00986
G1 X85.094 Y89.632 E.00986
G1 X85.155 Y89.146 E.00986
G1 X85.264 Y88.667 E.00987
G1 X85.42 Y88.203 E.00986
G1 X85.622 Y87.755 E.00987
G1 X85.867 Y87.331 E.00986
G1 X86.153 Y86.933 E.00986
G1 X86.478 Y86.565 E.00987
G1 X86.837 Y86.231 E.00986
G1 X87.228 Y85.935 E.00986
G1 X87.647 Y85.679 E.00987
G1 X88.089 Y85.466 E.00986
G1 X88.55 Y85.299 E.00987
G1 X89.033 Y85.176 E.01002
G1 X89.757 Y85.086 E.01467
G1 X90.245 Y85.086 E.00982
G1 X90.733 Y85.135 E.00986
G1 X91.214 Y85.232 E.00986
G1 X91.683 Y85.377 E.00986
G1 X92.135 Y85.567 E.00986
G1 X92.565 Y85.802 E.00986
G1 X92.971 Y86.078 E.00986
G1 X93.346 Y86.393 E.00986
G1 X93.689 Y86.744 E.00986
G1 X93.995 Y87.128 E.00986
G1 X94.261 Y87.54 E.00986
G1 X94.485 Y87.977 E.00987
G1 X94.664 Y88.433 E.00986
G1 X94.796 Y88.905 E.00986
G1 X94.882 Y89.388 E.00987
G1 X94.918 Y89.877 E.00986
G1 X94.906 Y90.368 E.00986
G1 X94.845 Y90.854 E.00986
G1 X94.736 Y91.333 E.00987
G1 X94.58 Y91.797 E.00986
G1 X94.417 Y92.157 E.00794
M204 S250
G1 X94.02 Y92.044 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1800
M204 S5000
G1 X94.013 Y92.058 E.00029
G1 X93.787 Y92.449 E.00845
G1 X93.377 Y92.99 E.01268
G1 X93.068 Y93.306 E.00827
G1 X92.723 Y93.595 E.0084
G1 X92.352 Y93.849 E.0084
G1 X91.957 Y94.064 E.0084
G1 X91.543 Y94.238 E.0084
G1 X91.113 Y94.371 E.0084
G1 X90.672 Y94.46 E.0084
G1 X90.225 Y94.505 E.0084
G1 X89.775 Y94.505 E.0084
G1 X89.328 Y94.46 E.0084
G1 X88.887 Y94.371 E.0084
G1 X88.457 Y94.238 E.0084
G1 X88.043 Y94.064 E.0084
G1 X87.648 Y93.849 E.0084
G1 X87.277 Y93.595 E.0084
G1 X86.932 Y93.306 E.0084
G1 X86.618 Y92.984 E.0084
G1 X86.338 Y92.633 E.0084
G1 X86.094 Y92.255 E.0084
G1 X85.889 Y91.855 E.00841
G1 X85.724 Y91.436 E.0084
G1 X85.603 Y91.004 E.0084
G1 X85.525 Y90.561 E.0084
G1 X85.491 Y90.112 E.00841
G1 X85.502 Y89.663 E.0084
G1 X85.558 Y89.217 E.0084
G1 X85.658 Y88.778 E.0084
G1 X85.801 Y88.352 E.0084
G1 X85.986 Y87.942 E.0084
G1 X86.211 Y87.553 E.0084
G1 X86.473 Y87.188 E.0084
G1 X86.771 Y86.851 E.00841
G1 X87.101 Y86.545 E.0084
G1 X87.459 Y86.273 E.0084
G1 X87.843 Y86.039 E.00841
G1 X88.248 Y85.844 E.0084
G1 X88.67 Y85.69 E.0084
G1 X89.109 Y85.578 E.00845
G1 X89.782 Y85.495 E.01268
G1 X90.225 Y85.495 E.00827
G1 X90.672 Y85.54 E.0084
G1 X91.113 Y85.629 E.0084
G1 X91.542 Y85.762 E.0084
G1 X91.957 Y85.936 E.0084
G1 X92.352 Y86.151 E.0084
G1 X92.723 Y86.405 E.0084
G1 X93.068 Y86.694 E.0084
G1 X93.382 Y87.016 E.0084
G1 X93.662 Y87.367 E.0084
G1 X93.906 Y87.745 E.0084
G1 X94.111 Y88.145 E.00841
G1 X94.275 Y88.564 E.0084
G1 X94.397 Y88.996 E.0084
G1 X94.475 Y89.439 E.0084
G1 X94.509 Y89.888 E.0084
G1 X94.497 Y90.337 E.0084
G1 X94.442 Y90.783 E.0084
G1 X94.342 Y91.222 E.0084
G1 X94.198 Y91.648 E.0084
G1 X94.044 Y91.989 E.00699
; WIPE_START
M204 S6000
G1 X94.013 Y92.058 E-.01075
G1 X93.787 Y92.449 E-.06446
G1 X93.377 Y92.99 E-.09667
G1 X93.068 Y93.306 E-.06307
G1 X92.798 Y93.532 E-.05005
; WIPE_END
G1 E-.015
M204 S10000
G1 X88.54 Y87.198 Z.72 F18000
G1 X85.906 Y83.281 Z.72
G1 Z.32
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F3600
M204 S6000
G1 X86.466 Y82.965 E.01293
G1 X87.152 Y82.66 E.01509
G1 X87.828 Y82.433 E.01434
G1 X88.192 Y82.337 E.00758
G1 X88.939 Y82.199 E.01528
G1 X89.686 Y82.133 E.01507
G1 X90.435 Y82.139 E.01506
G1 X91.181 Y82.216 E.01508
G1 X91.916 Y82.364 E.01507
G1 X92.633 Y82.581 E.01507
G1 X93.327 Y82.865 E.01507
G1 X93.99 Y83.213 E.01507
G1 X94.618 Y83.624 E.01509
G1 X95.176 Y84.068 E.01434
G1 X95.455 Y84.323 E.00759
G1 X95.976 Y84.875 E.01528
G1 X96.436 Y85.467 E.01507
G1 X96.839 Y86.1 E.01508
G1 X97.179 Y86.768 E.01508
G1 X97.454 Y87.466 E.01508
G1 X97.661 Y88.187 E.01509
G1 X97.799 Y88.924 E.01508
G1 X97.866 Y89.672 E.01509
G1 X97.861 Y90.436 E.01536
G1 X97.836 Y90.761 E.00656
G1 X97.725 Y91.517 E.01537
G1 X97.545 Y92.247 E.0151
G1 X97.297 Y92.956 E.01511
G1 X96.982 Y93.638 E.01511
G1 X96.603 Y94.288 E.01512
G1 X96.164 Y94.898 E.01511
G1 X95.669 Y95.463 E.01511
G1 X95.123 Y95.978 E.0151
G1 X94.53 Y96.439 E.0151
G1 X93.897 Y96.841 E.01508
G1 X93.229 Y97.18 E.01506
G1 X92.534 Y97.454 E.01503
G1 X91.817 Y97.66 E.01501
G1 X91.085 Y97.797 E.01496
G1 X90.333 Y97.866 E.0152
G1 X89.493 Y97.857 E.01689
G1 X88.784 Y97.778 E.01433
G1 X88.416 Y97.712 E.00753
G1 X87.683 Y97.524 E.0152
G1 X86.981 Y97.271 E.01502
G1 X86.304 Y96.951 E.01505
G1 X85.659 Y96.568 E.01508
G1 X85.054 Y96.125 E.01508
G1 X84.492 Y95.626 E.01512
G1 X84.005 Y95.103 E.01437
G1 X83.532 Y94.489 E.01559
G1 X83.128 Y93.841 E.01535
G1 X82.792 Y93.167 E.01514
G1 X82.539 Y92.512 E.01412
G1 X82.333 Y91.788 E.01515
G1 X82.198 Y91.049 E.0151
G1 X82.133 Y90.301 E.0151
G1 X82.14 Y89.55 E.0151
G1 X82.219 Y88.804 E.01509
G1 X82.368 Y88.068 E.01509
G1 X82.586 Y87.351 E.01508
G1 X82.872 Y86.657 E.01509
G1 X83.222 Y85.994 E.01507
G1 X83.634 Y85.367 E.01508
G1 X84.104 Y84.783 E.01507
G1 X84.627 Y84.246 E.01507
G1 X85.198 Y83.761 E.01507
G1 X85.813 Y83.333 E.01507
G1 X85.853 Y83.31 E.00093
M204 S10000
G1 X85.697 Y82.911 F18000
G1 F3600
M204 S6000
G1 X86.275 Y82.585 E.01334
G1 X86.998 Y82.265 E.01589
G1 X87.706 Y82.027 E.01502
G1 X88.1 Y81.923 E.00819
G1 X88.882 Y81.778 E.016
G1 X89.669 Y81.709 E.01589
G1 X90.459 Y81.715 E.01588
G1 X91.245 Y81.796 E.01589
G1 X92.019 Y81.952 E.01588
G1 X92.775 Y82.18 E.01588
G1 X93.506 Y82.48 E.01588
G1 X94.205 Y82.847 E.01588
G1 X94.867 Y83.28 E.0159
G1 X95.451 Y83.745 E.01502
G1 X95.752 Y84.02 E.00819
G1 X96.299 Y84.599 E.01601
G1 X96.784 Y85.222 E.01588
G1 X97.207 Y85.889 E.01589
G1 X97.566 Y86.594 E.01589
G1 X97.856 Y87.329 E.01589
G1 X98.074 Y88.089 E.01591
G1 X98.22 Y88.866 E.0159
G1 X98.29 Y89.654 E.01591
G1 X98.285 Y90.453 E.01607
G1 X98.258 Y90.808 E.00715
G1 X98.142 Y91.599 E.01608
G1 X97.952 Y92.368 E.01592
G1 X97.69 Y93.116 E.01593
G1 X97.358 Y93.835 E.01592
G1 X96.959 Y94.519 E.01593
G1 X96.496 Y95.162 E.01593
G1 X95.975 Y95.758 E.01592
G1 X95.399 Y96.301 E.01591
G1 X94.774 Y96.786 E.01591
G1 X94.107 Y97.21 E.01589
G1 X93.403 Y97.567 E.01587
G1 X92.671 Y97.856 E.01584
G1 X91.915 Y98.073 E.01582
G1 X91.144 Y98.218 E.01577
G1 X90.357 Y98.29 E.01589
G1 X90.003 Y98.298 E.00713
G1 X89.463 Y98.28 E.01087
G1 X88.724 Y98.198 E.01495
G1 X88.326 Y98.127 E.00813
G1 X87.558 Y97.93 E.01592
G1 X86.818 Y97.663 E.01583
G1 X86.105 Y97.326 E.01586
G1 X85.425 Y96.923 E.01589
G1 X84.787 Y96.456 E.0159
G1 X84.195 Y95.929 E.01593
G1 X83.685 Y95.382 E.01505
G1 X83.18 Y94.726 E.01664
G1 X82.757 Y94.048 E.01607
G1 X82.404 Y93.338 E.01594
G1 X82.136 Y92.647 E.0149
G1 X81.92 Y91.884 E.01595
G1 X81.777 Y91.106 E.01591
G1 X81.709 Y90.317 E.01592
G1 X81.716 Y89.526 E.01591
G1 X81.799 Y88.739 E.0159
G1 X81.956 Y87.964 E.01591
G1 X82.186 Y87.208 E.01589
G1 X82.488 Y86.477 E.0159
G1 X82.857 Y85.778 E.01589
G1 X83.291 Y85.118 E.01589
G1 X83.786 Y84.502 E.01589
G1 X84.337 Y83.936 E.01588
G1 X84.939 Y83.424 E.01589
G1 X85.587 Y82.973 E.01588
G1 X85.645 Y82.94 E.00133
M204 S250
G1 X85.497 Y82.554 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1800
M204 S5000
G1 X86.092 Y82.219 E.01276
G1 X86.849 Y81.883 E.01549
G1 X87.588 Y81.635 E.01456
G1 X88.01 Y81.523 E.00815
G1 X88.827 Y81.372 E.01553
G1 X89.653 Y81.3 E.01549
G1 X90.481 Y81.306 E.01549
G1 X91.306 Y81.391 E.01549
G1 X92.119 Y81.555 E.01549
G1 X92.912 Y81.794 E.01549
G1 X93.679 Y82.108 E.01549
G1 X94.413 Y82.494 E.01549
G1 X95.107 Y82.948 E.01549
G1 X95.717 Y83.434 E.01456
G1 X96.039 Y83.728 E.00815
G1 X96.61 Y84.332 E.01553
G1 X97.119 Y84.986 E.01549
G1 X97.563 Y85.686 E.0155
G1 X97.939 Y86.425 E.0155
G1 X98.244 Y87.197 E.0155
G1 X98.473 Y87.995 E.01551
G1 X98.625 Y88.81 E.0155
G1 X98.699 Y89.637 E.01551
G1 X98.694 Y90.47 E.01556
G1 X98.665 Y90.854 E.00719
G1 X98.544 Y91.678 E.01557
G1 X98.345 Y92.485 E.01552
G1 X98.07 Y93.269 E.01553
G1 X97.722 Y94.024 E.01553
G1 X97.303 Y94.742 E.01554
G1 X96.817 Y95.417 E.01553
G1 X96.27 Y96.042 E.01553
G1 X95.666 Y96.612 E.01552
G1 X95.01 Y97.121 E.01552
G1 X94.31 Y97.566 E.01549
G1 X93.571 Y97.941 E.01548
G1 X92.802 Y98.244 E.01544
G1 X92.009 Y98.472 E.01542
G1 X91.201 Y98.624 E.01537
G1 X90.381 Y98.699 E.01538
G1 X90.001 Y98.707 E.0071
G1 X89.433 Y98.689 E.01061
G1 X88.665 Y98.604 E.01444
G1 X88.239 Y98.527 E.0081
G1 X87.438 Y98.322 E.01545
G1 X86.661 Y98.042 E.01544
G1 X85.912 Y97.688 E.01547
G1 X85.199 Y97.264 E.01549
G1 X84.53 Y96.775 E.0155
G1 X83.909 Y96.222 E.01552
G1 X83.377 Y95.651 E.0146
G1 X82.84 Y94.955 E.0164
G1 X82.399 Y94.248 E.01558
G1 X82.029 Y93.504 E.01554
G1 X81.748 Y92.777 E.01456
G1 X81.521 Y91.977 E.01554
G1 X81.371 Y91.16 E.01552
G1 X81.299 Y90.333 E.01552
G1 X81.307 Y89.502 E.01552
G1 X81.394 Y88.677 E.0155
G1 X81.559 Y87.863 E.01551
G1 X81.8 Y87.07 E.0155
G1 X82.117 Y86.303 E.01551
G1 X82.504 Y85.57 E.0155
G1 X82.959 Y84.877 E.01549
G1 X83.479 Y84.23 E.01549
G1 X84.057 Y83.636 E.01549
G1 X84.689 Y83.1 E.01549
G1 X85.369 Y82.626 E.01549
G1 X85.444 Y82.584 E.0016
; WIPE_START
M204 S6000
G1 X86.092 Y82.219 E-.10588
G1 X86.849 Y81.883 E-.11814
G1 X87.255 Y81.747 E-.06097
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
G1 X0 Y90.0001 ; move to safe pos
G1 X-13.0 F3000 ; move to safe pos
M400
M1004 S5 P1  ; external shutter
M400 P300
M971 S11 C11 O0
G92 E0
G1 X0 F18000
M623

; SKIPTYPE: head_wrap_detect
M622.1 S1
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




G1 X94.798 Y93.825
G1 Z.32
G1 E.3 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.419992
G1 F4800
M204 S6000
G1 X94.425 Y94.26 E.0107
G1 X94 Y94.661 E.01091
G1 X93.54 Y95.02 E.01091
G1 X93.048 Y95.333 E.0109
G1 X92.53 Y95.598 E.01088
G1 X91.99 Y95.813 E.01086
G1 X91.488 Y95.965 E.0098
G1 X90.937 Y96.076 E.0105
G1 X90.335 Y96.139 E.0113
G1 X89.723 Y96.142 E.01145
M73 P57 R5
G1 X89.113 Y96.084 E.01146
G1 X88.512 Y95.965 E.01145
G1 X87.925 Y95.787 E.01146
G1 X87.359 Y95.552 E.01145
G1 X86.819 Y95.261 E.01145
G1 X86.311 Y94.918 E.01145
G1 X85.84 Y94.527 E.01146
G1 X85.4 Y94.08 E.01171
G1 X85.025 Y93.613 E.0112
G1 X84.691 Y93.1 E.01145
G1 X84.408 Y92.555 E.01146
G1 X84.182 Y91.986 E.01145
G1 X84.013 Y91.397 E.01145
G1 X83.905 Y90.8 E.01133
G1 X83.857 Y90.218 E.01092
G1 X83.865 Y89.633 E.01092
G1 X83.929 Y89.053 E.0109
G1 X84.047 Y88.482 E.01091
G1 X84.218 Y87.924 E.0109
G1 X84.442 Y87.386 E.0109
G1 X84.715 Y86.871 E.01089
G1 X85.035 Y86.384 E.0109
G1 X85.401 Y85.93 E.01089
G1 X85.807 Y85.512 E.01089
G1 X86.251 Y85.135 E.01088
G1 X86.729 Y84.801 E.01089
G1 X87.236 Y84.514 E.01088
G1 X87.769 Y84.276 E.01092
G1 X88.279 Y84.101 E.01007
G1 X88.769 Y83.976 E.00944
G1 X89.645 Y83.863 E.01652
G1 X90.277 Y83.858 E.01181
G1 X90.887 Y83.916 E.01144
G1 X91.488 Y84.035 E.01145
G1 X92.074 Y84.213 E.01145
G1 X92.613 Y84.436 E.01089
G1 X93.128 Y84.71 E.0109
G1 X93.616 Y85.032 E.01093
G1 X94.036 Y85.37 E.01007
G1 X94.59 Y85.91 E.01445
G1 X94.974 Y86.387 E.01145
G1 X95.309 Y86.9 E.01145
G1 X95.592 Y87.445 E.01146
G1 X95.818 Y88.014 E.01144
G1 X95.987 Y88.603 E.01145
G1 X96.091 Y89.177 E.01091
G1 X96.141 Y89.759 E.01091
G1 X96.135 Y90.347 E.01098
G1 X96.059 Y91.038 E.01301
G1 X95.926 Y91.637 E.01145
G1 X95.733 Y92.219 E.01145
G1 X95.484 Y92.779 E.01145
G1 X95.172 Y93.325 E.01176
G1 X94.834 Y93.777 E.01055
M204 S10000
G1 X94.484 Y93.587 F18000
G1 F4800
M204 S6000
G1 X94.143 Y93.984 E.00979
G1 X93.747 Y94.359 E.01018
G1 X93.318 Y94.694 E.01017
G1 X92.86 Y94.987 E.01016
G1 X92.377 Y95.235 E.01014
G1 X91.874 Y95.436 E.01012
G1 X91.355 Y95.59 E.01011
G1 X90.865 Y95.689 E.00935
G1 X90.296 Y95.746 E.01067
G1 X89.723 Y95.747 E.01071
G1 X89.152 Y95.691 E.01072
G1 X88.59 Y95.579 E.01071
G1 X88.041 Y95.41 E.01072
G1 X87.512 Y95.188 E.01072
G1 X87.008 Y94.915 E.01072
G1 X86.533 Y94.593 E.01072
G1 X86.093 Y94.225 E.01072
G1 X85.689 Y93.811 E.0108
G1 X85.334 Y93.367 E.01063
G1 X85.022 Y92.886 E.01072
G1 X84.759 Y92.375 E.01073
G1 X84.549 Y91.842 E.01071
G1 X84.392 Y91.29 E.01071
G1 X84.293 Y90.732 E.0106
G1 X84.25 Y90.188 E.01018
G1 X84.26 Y89.643 E.01019
G1 X84.32 Y89.102 E.01017
G1 X84.431 Y88.57 E.01017
G1 X84.592 Y88.05 E.01016
G1 X84.801 Y87.548 E.01017
G1 X85.056 Y87.068 E.01015
G1 X85.356 Y86.614 E.01016
G1 X85.696 Y86.191 E.01015
G1 X86.075 Y85.801 E.01015
G1 X86.489 Y85.449 E.01015
G1 X86.934 Y85.138 E.01016
G1 X87.407 Y84.87 E.01015
G1 X87.904 Y84.646 E.01019
G1 X88.866 Y84.358 E.01876
G1 X89.694 Y84.254 E.01559
G1 X90.277 Y84.253 E.0109
G1 X90.848 Y84.309 E.01071
G1 X91.41 Y84.421 E.01071
G1 X91.958 Y84.59 E.01071
G1 X92.46 Y84.8 E.01016
G1 X92.939 Y85.056 E.01016
G1 X93.394 Y85.358 E.01019
G1 X93.906 Y85.775 E.01236
G1 X94.308 Y86.185 E.01071
G1 X94.666 Y86.633 E.01072
G1 X94.978 Y87.114 E.01071
G1 X95.241 Y87.625 E.01073
G1 X95.451 Y88.158 E.01071
G1 X95.607 Y88.71 E.01071
G1 X95.703 Y89.246 E.01018
G1 X95.747 Y89.789 E.01018
G1 X95.741 Y90.337 E.01024
G1 X95.668 Y90.989 E.01227
G1 X95.541 Y91.549 E.01072
G1 X95.36 Y92.093 E.01072
G1 X95.125 Y92.616 E.01072
G1 X94.83 Y93.128 E.01103
G1 X94.52 Y93.539 E.00962
; WIPE_START
G1 X94.83 Y93.128 E-.07335
G1 X95.125 Y92.616 E-.0841
G1 X95.36 Y92.093 E-.08176
G1 X95.461 Y91.788 E-.04579
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X94.527 Y85.198 Z.72 F18000
G1 Z.32
G1 E.3 F1800
; LINE_WIDTH: 0.552585
G1 F4800
M204 S6000
G1 X94.029 Y84.767 E.01644
G1 X93.488 Y84.392 E.01644
G1 X92.913 Y84.072 E.01644
G1 X92.308 Y83.811 E.01645
G1 X91.68 Y83.611 E.01645
G1 X91.036 Y83.475 E.01644
G1 X90.382 Y83.404 E.01644
G1 X89.737 Y83.398 E.01611
G1 X89.124 Y83.457 E.01537
G1 X88.165 Y83.654 E.02443
G1 X87.611 Y83.841 E.01461
G1 X87.035 Y84.098 E.01575
G1 X86.487 Y84.406 E.01569
G1 X85.971 Y84.766 E.01571
G1 X85.492 Y85.173 E.01569
G1 X85.053 Y85.623 E.0157
G1 X84.659 Y86.114 E.0157
G1 X84.314 Y86.639 E.01571
G1 X84.02 Y87.195 E.0157
G1 X83.78 Y87.777 E.01572
G1 X83.627 Y88.262 E.01268
G1 X83.505 Y88.802 E.01383
G1 X83.418 Y89.454 E.01644
G1 X83.396 Y90.112 E.01644
G1 X83.44 Y90.769 E.01644
G1 X83.548 Y91.419 E.01645
G1 X83.721 Y92.054 E.01643
G1 X83.95 Y92.656 E.01608
G1 X84.233 Y93.224 E.01583
G1 X84.572 Y93.766 E.01598
G1 X84.971 Y94.284 E.01631
G1 X85.378 Y94.719 E.01489
G1 X85.85 Y95.139 E.01578
G1 X86.358 Y95.511 E.01571
G1 X86.899 Y95.832 E.01571
G1 X87.467 Y96.1 E.01567
G1 X88.044 Y96.308 E.01533
G1 X88.963 Y96.525 E.02357
G1 X89.569 Y96.593 E.01523
G1 X90.277 Y96.602 E.01766
G1 X90.911 Y96.544 E.01591
G1 X91.525 Y96.428 E.01559
G1 X92.126 Y96.254 E.01563
G1 X92.71 Y96.024 E.01566
G1 X93.269 Y95.739 E.01569
G1 X93.801 Y95.402 E.01571
G1 X94.298 Y95.015 E.01573
G1 X94.756 Y94.583 E.01573
G1 X95.169 Y94.107 E.01574
G1 X95.496 Y93.665 E.01373
G1 X95.855 Y93.061 E.01755
G1 X96.124 Y92.481 E.01596
G1 X96.332 Y91.885 E.01575
G1 X96.48 Y91.284 E.01547
G1 X96.58 Y90.545 E.01861
G1 X96.601 Y89.725 E.0205
G1 X96.559 Y89.216 E.01276
G1 X96.451 Y88.581 E.01607
G1 X96.278 Y87.946 E.01644
G1 X96.043 Y87.331 E.01643
G1 X95.748 Y86.742 E.01646
G1 X95.402 Y86.195 E.01615
G1 X95.023 Y85.71 E.01538
G1 X94.569 Y85.241 E.0163
; WIPE_START
G1 X95.023 Y85.71 E-.09304
G1 X95.402 Y86.195 E-.08776
G1 X95.748 Y86.742 E-.09216
G1 X95.786 Y86.817 E-.01204
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X89 Y83.323 Z.72 F18000
G1 X88.565 Y83.099 Z.72
G1 Z.32
G1 E.3 F1800
; LINE_WIDTH: 0.419992
G1 F4800
M204 S6000
G1 X88.044 Y83.208 E.00994
G1 X87.443 Y83.41 E.01184
G1 X86.827 Y83.684 E.0126
G1 X86.241 Y84.014 E.01257
G1 X85.689 Y84.399 E.01258
G1 X85.176 Y84.834 E.01257
G1 X84.706 Y85.316 E.01258
G1 X84.285 Y85.841 E.01258
G1 X83.915 Y86.404 E.01258
G1 X83.6 Y86.998 E.01257
G1 X83.344 Y87.621 E.01259
G1 X83.148 Y88.265 E.01258
G1 X83.014 Y88.926 E.01259
G1 X82.943 Y89.596 E.01258
G1 X82.937 Y90.27 E.0126
G1 X82.995 Y90.942 E.0126
G1 X83.117 Y91.605 E.01259
G1 X83.302 Y92.257 E.01267
G1 X83.528 Y92.842 E.01173
G1 X83.83 Y93.449 E.01265
G1 X84.192 Y94.03 E.0128
G1 X84.619 Y94.582 E.01304
G1 X85.055 Y95.05 E.01195
G1 X85.56 Y95.5 E.01263
G1 X86.103 Y95.897 E.01258
G1 X86.682 Y96.241 E.01258
G1 X87.289 Y96.528 E.01255
G1 X87.913 Y96.753 E.0124
G1 X88.914 Y96.984 E.01919
G1 X89.542 Y97.054 E.01179
G1 X90.301 Y97.062 E.01418
G1 X90.975 Y97.001 E.01265
G1 X91.631 Y96.877 E.01248
G1 X92.275 Y96.692 E.01252
G1 X92.899 Y96.446 E.01254
G1 X93.499 Y96.142 E.01256
G1 X94.067 Y95.781 E.01258
G1 X94.599 Y95.367 E.01259
G1 X95.09 Y94.905 E.01259
G1 X95.534 Y94.397 E.01261
G1 X95.928 Y93.85 E.01261
G1 X96.268 Y93.267 E.01261
G1 X96.551 Y92.654 E.01261
G1 X96.774 Y92.017 E.01261
G1 X96.934 Y91.368 E.01249
G1 X97.058 Y90.388 E.01846
G1 X97.062 Y89.727 E.01235
G1 X97.016 Y89.19 E.01008
G1 X96.902 Y88.497 E.01313
G1 X96.719 Y87.819 E.01312
G1 X96.471 Y87.163 E.01311
G1 X96.158 Y86.533 E.01313
G1 X95.791 Y85.948 E.0129
G1 X95.387 Y85.426 E.01233
G1 X94.849 Y84.879 E.01435
G1 X94.314 Y84.409 E.01329
G1 X93.739 Y84.009 E.0131
G1 X93.126 Y83.667 E.01312
G1 X92.482 Y83.387 E.01312
G1 X91.813 Y83.172 E.01312
G1 X91.127 Y83.025 E.01312
G1 X90.429 Y82.946 E.01312
G1 X89.74 Y82.937 E.01287
G1 X89.083 Y82.993 E.01232
G1 X88.624 Y83.087 E.00876
M204 S10000
G1 X88.526 Y82.704 F18000
G1 F4800
M204 S6000
G1 X87.94 Y82.827 E.01119
G1 X87.3 Y83.042 E.01261
G1 X86.65 Y83.331 E.0133
G1 X86.031 Y83.68 E.01327
G1 X85.448 Y84.086 E.01328
G1 X84.906 Y84.545 E.01327
G1 X84.411 Y85.055 E.01328
G1 X83.966 Y85.609 E.01328
G1 X83.575 Y86.203 E.01329
G1 X83.243 Y86.831 E.01328
G1 X82.972 Y87.489 E.01329
G1 X82.765 Y88.169 E.01328
G1 X82.624 Y88.866 E.01329
G1 X82.549 Y89.573 E.01329
G1 X82.543 Y90.285 E.01331
G1 X82.604 Y90.994 E.0133
G1 X82.732 Y91.694 E.0133
G1 X82.928 Y92.382 E.01336
G1 X83.167 Y93.002 E.01241
G1 X83.486 Y93.641 E.01335
G1 X83.868 Y94.255 E.01352
G1 X84.318 Y94.838 E.01375
G1 X84.779 Y95.333 E.01264
G1 X85.312 Y95.807 E.01333
G1 X85.885 Y96.226 E.01328
G1 X86.496 Y96.59 E.01329
G1 X87.138 Y96.892 E.01325
G1 X87.802 Y97.132 E.01319
G1 X88.848 Y97.374 E.02006
G1 X89.518 Y97.448 E.01259
G1 X90.316 Y97.456 E.01493
G1 X91.029 Y97.391 E.01337
G1 X91.722 Y97.261 E.01318
G1 X92.402 Y97.066 E.01322
G1 X93.061 Y96.806 E.01324
G1 X93.694 Y96.485 E.01326
G1 X94.294 Y96.104 E.01328
G1 X94.856 Y95.667 E.0133
G1 X95.374 Y95.179 E.0133
G1 X95.843 Y94.643 E.01331
G1 X96.259 Y94.064 E.01331
G1 X96.618 Y93.449 E.01331
G1 X96.917 Y92.802 E.01331
G1 X97.153 Y92.13 E.01331
G1 X97.322 Y91.44 E.01327
G1 X97.452 Y90.414 E.01932
G1 X97.456 Y89.73 E.01279
G1 X97.409 Y89.155 E.01078
G1 X97.289 Y88.424 E.01383
G1 X97.098 Y87.71 E.01382
G1 X96.837 Y87.018 E.01381
G1 X96.509 Y86.354 E.01383
G1 X96.123 Y85.737 E.0136
G1 X95.698 Y85.184 E.01303
G1 X95.128 Y84.601 E.01523
G1 X94.56 Y84.101 E.01415
G1 X93.954 Y83.679 E.01379
G1 X93.309 Y83.318 E.01382
G1 X92.631 Y83.022 E.01382
G1 X91.927 Y82.795 E.01382
G1 X91.204 Y82.638 E.01382
G1 X90.469 Y82.554 E.01382
G1 X89.743 Y82.543 E.01357
G1 X89.049 Y82.6 E.01302
G1 X88.585 Y82.692 E.00883
; CHANGE_LAYER
; Z_HEIGHT: 0.44
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F4800
G1 X89.049 Y82.6 E-.06735
G1 X89.743 Y82.543 E-.09932
G1 X90.469 Y82.554 E-.10349
G1 X90.573 Y82.566 E-.01483
; WIPE_END
G1 E-.015 F1800
; layer num/total_layer_count: 3/33
; update layer progress
M73 L3
M991 S0 P2 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z.72 I-1.119 J.479 P1  F18000
G1 X94.779 Y92.388 Z.72
G1 Z.44
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F3600
M204 S6000
G1 X94.756 Y92.438 E.00111
G1 X94.49 Y92.9 E.01071
G1 X94.179 Y93.332 E.01071
G1 X93.826 Y93.732 E.01072
G1 X93.435 Y94.094 E.01072
G1 X93 Y94.424 E.01098
G1 X92.331 Y94.81 E.01554
G1 X91.828 Y95.022 E.01097
G1 X91.319 Y95.18 E.01072
G1 X90.796 Y95.285 E.01071
G1 X90.266 Y95.338 E.01072
G1 X89.733 Y95.338 E.01071
G1 X89.203 Y95.285 E.01071
G1 X88.681 Y95.18 E.01071
G1 X88.172 Y95.022 E.01072
G1 X87.681 Y94.815 E.01071
G1 X87.213 Y94.561 E.01071
G1 X86.773 Y94.261 E.01071
G1 X86.364 Y93.918 E.01072
G1 X85.992 Y93.537 E.01071
G1 X85.66 Y93.12 E.01072
G1 X85.371 Y92.672 E.01071
G1 X85.128 Y92.198 E.01072
G1 X84.933 Y91.702 E.01071
G1 X84.789 Y91.189 E.01071
G1 X84.697 Y90.664 E.01072
G1 X84.657 Y90.133 E.01071
G1 X84.67 Y89.601 E.01071
G1 X84.736 Y89.072 E.01071
G1 X84.855 Y88.552 E.01072
G1 X85.024 Y88.047 E.01071
G1 X85.244 Y87.562 E.01071
G1 X85.51 Y87.1 E.01071
G1 X85.821 Y86.668 E.01072
G1 X86.174 Y86.268 E.01072
G1 X86.564 Y85.906 E.01071
G1 X86.989 Y85.584 E.01072
G1 X87.444 Y85.306 E.01071
G1 X87.924 Y85.075 E.01071
G1 X88.425 Y84.893 E.01072
G1 X88.955 Y84.758 E.011
G1 X89.738 Y84.661 E.01588
G1 X90.267 Y84.662 E.01062
G1 X90.796 Y84.715 E.0107
G1 X91.319 Y84.82 E.01071
G1 X91.828 Y84.978 E.01072
G1 X92.319 Y85.185 E.01072
G1 X92.787 Y85.439 E.01071
G1 X93.227 Y85.739 E.01071
G1 X93.635 Y86.082 E.01072
G1 X94.007 Y86.463 E.01071
G1 X94.339 Y86.88 E.01071
G1 X94.628 Y87.328 E.01071
G1 X94.872 Y87.802 E.01072
G1 X95.066 Y88.298 E.01071
G1 X95.211 Y88.81 E.01071
G1 X95.303 Y89.336 E.01072
G1 X95.343 Y89.867 E.01071
G1 X95.33 Y90.399 E.01071
G1 X95.263 Y90.928 E.01071
G1 X95.145 Y91.448 E.01072
G1 X94.975 Y91.953 E.01071
G1 X94.803 Y92.334 E.0084
M204 S10000
G1 X94.392 Y92.214 F18000
G1 F3600
M204 S6000
G1 X94.378 Y92.245 E.00068
G1 X94.133 Y92.669 E.00986
G1 X93.846 Y93.068 E.00986
G1 X93.522 Y93.435 E.00986
G1 X93.162 Y93.769 E.00986
G1 X92.765 Y94.07 E.01002
G1 X92.142 Y94.43 E.01448
G1 X91.683 Y94.623 E.01001
G1 X91.214 Y94.768 E.00987
G1 X90.733 Y94.865 E.00986
G1 X90.245 Y94.914 E.00986
G1 X89.755 Y94.914 E.00986
G1 X89.267 Y94.865 E.00986
G1 X88.786 Y94.768 E.00986
G1 X88.317 Y94.623 E.00986
G1 X87.865 Y94.433 E.00986
G1 X87.434 Y94.198 E.00986
G1 X87.029 Y93.922 E.00986
G1 X86.653 Y93.607 E.00986
G1 X86.311 Y93.255 E.00986
G1 X86.005 Y92.872 E.00986
G1 X85.739 Y92.46 E.00986
G1 X85.515 Y92.023 E.00987
G1 X85.336 Y91.567 E.00986
G1 X85.203 Y91.095 E.00986
G1 X85.118 Y90.612 E.00987
G1 X85.081 Y90.123 E.00986
G1 X85.094 Y89.632 E.00986
G1 X85.155 Y89.146 E.00986
G1 X85.264 Y88.667 E.00986
G1 X85.42 Y88.203 E.00986
G1 X85.622 Y87.756 E.00986
G1 X85.867 Y87.331 E.00986
G1 X86.153 Y86.932 E.00986
G1 X86.478 Y86.565 E.00987
G1 X86.837 Y86.231 E.00986
G1 X87.228 Y85.935 E.00987
G1 X87.647 Y85.679 E.00986
G1 X88.089 Y85.466 E.00986
G1 X88.55 Y85.299 E.00986
G1 X89.033 Y85.175 E.01003
G1 X89.764 Y85.086 E.01481
G1 X90.245 Y85.086 E.00967
G1 X90.733 Y85.135 E.00986
G1 X91.214 Y85.232 E.00986
G1 X91.683 Y85.377 E.00986
G1 X92.135 Y85.567 E.00986
G1 X92.565 Y85.802 E.00986
G1 X92.97 Y86.078 E.00986
G1 X93.346 Y86.393 E.00987
G1 X93.689 Y86.744 E.00986
G1 X93.995 Y87.128 E.00986
G1 X94.261 Y87.54 E.00986
G1 X94.484 Y87.977 E.00987
G1 X94.664 Y88.433 E.00986
G1 X94.796 Y88.905 E.00986
G1 X94.882 Y89.388 E.00987
G1 X94.918 Y89.877 E.00986
G1 X94.906 Y90.368 E.00986
G1 X94.845 Y90.854 E.00986
G1 X94.736 Y91.333 E.00986
G1 X94.58 Y91.798 E.00986
G1 X94.417 Y92.159 E.00797
M204 S250
G1 X94.019 Y92.045 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1800
M204 S5000
G1 X94.013 Y92.058 E.00025
G1 X93.789 Y92.447 E.0084
G1 X93.526 Y92.812 E.0084
G1 X93.229 Y93.149 E.0084
G1 X92.899 Y93.455 E.0084
G1 X92.538 Y93.728 E.00845
G1 X91.959 Y94.063 E.0125
G1 X91.542 Y94.238 E.00845
G1 X91.113 Y94.371 E.0084
G1 X90.672 Y94.46 E.0084
G1 X90.225 Y94.505 E.0084
G1 X89.775 Y94.505 E.0084
G1 X89.328 Y94.46 E.0084
G1 X88.887 Y94.371 E.0084
G1 X88.457 Y94.238 E.0084
G1 X88.043 Y94.064 E.0084
G1 X87.648 Y93.849 E.0084
G1 X87.277 Y93.595 E.0084
G1 X86.932 Y93.306 E.0084
G1 X86.618 Y92.984 E.0084
G1 X86.338 Y92.633 E.0084
G1 X86.094 Y92.255 E.0084
G1 X85.889 Y91.855 E.0084
G1 X85.724 Y91.436 E.0084
G1 X85.603 Y91.004 E.0084
G1 X85.525 Y90.561 E.0084
G1 X85.491 Y90.112 E.0084
G1 X85.502 Y89.663 E.0084
G1 X85.558 Y89.217 E.0084
G1 X85.658 Y88.778 E.0084
G1 X85.801 Y88.352 E.0084
G1 X85.986 Y87.943 E.0084
G1 X86.211 Y87.553 E.0084
G1 X86.474 Y87.188 E.0084
G1 X86.771 Y86.851 E.0084
G1 X87.101 Y86.545 E.0084
G1 X87.459 Y86.273 E.0084
G1 X87.843 Y86.039 E.0084
G1 X88.248 Y85.844 E.0084
G1 X88.67 Y85.69 E.0084
G1 X89.109 Y85.578 E.00846
G1 X89.789 Y85.495 E.0128
G1 X90.225 Y85.495 E.00814
G1 X90.672 Y85.54 E.0084
G1 X91.113 Y85.629 E.0084
G1 X91.542 Y85.762 E.0084
G1 X91.957 Y85.936 E.0084
G1 X92.352 Y86.152 E.0084
G1 X92.723 Y86.405 E.0084
G1 X93.068 Y86.694 E.0084
G1 X93.381 Y87.016 E.0084
G1 X93.662 Y87.367 E.0084
G1 X93.906 Y87.745 E.0084
G1 X94.111 Y88.145 E.0084
G1 X94.275 Y88.563 E.0084
G1 X94.397 Y88.996 E.0084
G1 X94.475 Y89.439 E.0084
G1 X94.509 Y89.888 E.0084
G1 X94.497 Y90.337 E.0084
G1 X94.442 Y90.783 E.0084
G1 X94.342 Y91.222 E.0084
G1 X94.198 Y91.648 E.00841
G1 X94.044 Y91.991 E.00703
; WIPE_START
M204 S6000
G1 X94.013 Y92.058 E-.01046
G1 X93.789 Y92.447 E-.06405
G1 X93.526 Y92.812 E-.06408
G1 X93.229 Y93.149 E-.06409
G1 X92.899 Y93.455 E-.06407
G1 X92.797 Y93.532 E-.01825
; WIPE_END
G1 E-.015
M204 S10000
G1 X88.532 Y87.203 Z.84 F18000
G1 X85.986 Y83.424 Z.84
G1 Z.44
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F3600
M204 S6000
G1 X86.567 Y83.099 E.01338
G1 X87.25 Y82.8 E.01498
G1 X87.748 Y82.632 E.01057
G1 X88.202 Y82.505 E.00948
G1 X88.936 Y82.366 E.01501
G1 X89.675 Y82.299 E.01492
G1 X90.416 Y82.303 E.01491
G1 X91.154 Y82.379 E.01492
G1 X91.882 Y82.525 E.01492
G1 X92.592 Y82.741 E.01492
G1 X93.277 Y83.024 E.01492
G1 X93.933 Y83.371 E.01491
G1 X94.555 Y83.783 E.015
G1 X94.965 Y84.11 E.01055
G1 X95.319 Y84.422 E.00949
G1 X95.834 Y84.963 E.01502
G1 X96.291 Y85.547 E.01492
G1 X96.69 Y86.173 E.01492
G1 X97.027 Y86.834 E.01492
G1 X97.299 Y87.525 E.01493
G1 X97.504 Y88.239 E.01493
G1 X97.638 Y88.969 E.01493
G1 X97.702 Y89.709 E.01493
G1 X97.694 Y90.455 E.01501
G1 X97.641 Y90.98 E.01059
G1 X97.571 Y91.446 E.00949
G1 X97.395 Y92.174 E.01505
G1 X97.151 Y92.876 E.01495
G1 X96.841 Y93.551 E.01495
G1 X96.467 Y94.194 E.01495
G1 X96.033 Y94.797 E.01495
G1 X95.542 Y95.356 E.01495
G1 X95.001 Y95.865 E.01494
G1 X94.413 Y96.319 E.01494
G1 X93.785 Y96.714 E.01492
G1 X93.122 Y97.046 E.01491
G1 X92.432 Y97.313 E.01488
G1 X91.72 Y97.512 E.01487
G1 X90.994 Y97.642 E.01483
G1 X90.249 Y97.702 E.01503
G1 X89.447 Y97.687 E.01612
G1 X88.704 Y97.597 E.01505
G1 X87.984 Y97.438 E.01483
G1 X87.281 Y97.21 E.01487
G1 X86.581 Y96.906 E.01533
G1 X85.944 Y96.552 E.01467
G1 X85.332 Y96.13 E.01494
G1 X84.773 Y95.66 E.01468
G1 X84.39 Y95.286 E.01077
G1 X84.225 Y95.1 E.005
G1 X83.76 Y94.52 E.01495
G1 X83.353 Y93.899 E.01493
G1 X83.013 Y93.25 E.01473
G1 X82.726 Y92.541 E.01537
G1 X82.514 Y91.829 E.01495
G1 X82.373 Y91.1 E.01493
G1 X82.302 Y90.36 E.01494
G1 X82.303 Y89.617 E.01493
G1 X82.375 Y88.879 E.01493
G1 X82.518 Y88.15 E.01493
G1 X82.73 Y87.439 E.01492
G1 X83.01 Y86.751 E.01493
G1 X83.355 Y86.094 E.01492
G1 X83.762 Y85.473 E.01492
G1 X84.226 Y84.894 E.01492
G1 X84.743 Y84.363 E.01491
G1 X85.31 Y83.883 E.01492
G1 X85.919 Y83.461 E.01491
G1 X85.934 Y83.453 E.00033
M204 S10000
G1 X85.779 Y83.053 F18000
G1 F3600
M204 S6000
G1 X86.378 Y82.719 E.01379
G1 X87.097 Y82.404 E.01578
G1 X87.623 Y82.227 E.01116
G1 X88.105 Y82.091 E.01007
G1 X88.877 Y81.946 E.0158
G1 X89.657 Y81.875 E.01574
G1 X90.439 Y81.879 E.01573
G1 X91.218 Y81.959 E.01574
G1 X91.985 Y82.114 E.01574
G1 X92.734 Y82.341 E.01574
G1 X93.458 Y82.64 E.01574
G1 X94.149 Y83.006 E.01573
G1 X94.805 Y83.439 E.01579
G1 X95.238 Y83.785 E.01115
G1 X95.614 Y84.116 E.01007
G1 X96.156 Y84.686 E.0158
G1 X96.638 Y85.302 E.01574
G1 X97.059 Y85.962 E.01574
G1 X97.415 Y86.66 E.01574
G1 X97.702 Y87.389 E.01575
G1 X97.917 Y88.142 E.01575
G1 X98.059 Y88.912 E.01575
G1 X98.126 Y89.693 E.01576
G1 X98.118 Y90.479 E.0158
G1 X98.062 Y91.033 E.01119
G1 X97.987 Y91.528 E.01008
G1 X97.802 Y92.293 E.01583
G1 X97.545 Y93.034 E.01577
G1 X97.218 Y93.747 E.01577
G1 X96.823 Y94.425 E.01577
G1 X96.365 Y95.062 E.01577
G1 X95.848 Y95.651 E.01577
G1 X95.277 Y96.188 E.01576
G1 X94.656 Y96.667 E.01576
G1 X93.994 Y97.084 E.01574
G1 X93.294 Y97.435 E.01573
G1 X92.566 Y97.716 E.0157
G1 X91.815 Y97.926 E.01569
G1 X91.048 Y98.063 E.01565
M73 P58 R5
G1 X90.267 Y98.127 E.01575
G1 X89.814 Y98.13 E.00911
G1 X89.411 Y98.11 E.00811
G1 X88.633 Y98.015 E.01577
G1 X87.873 Y97.847 E.01565
G1 X87.131 Y97.607 E.01569
G1 X86.402 Y97.291 E.01597
G1 X85.724 Y96.915 E.01558
G1 X85.079 Y96.47 E.01576
G1 X84.865 Y96.307 E.00541
G1 X84.485 Y95.971 E.0102
G1 X84.083 Y95.579 E.01129
G1 X83.904 Y95.378 E.00542
G1 X83.413 Y94.765 E.01577
G1 X82.985 Y94.109 E.01576
G1 X82.624 Y93.42 E.01564
G1 X82.325 Y92.682 E.01602
G1 X82.102 Y91.93 E.01577
G1 X81.952 Y91.161 E.01576
G1 X81.878 Y90.38 E.01577
G1 X81.878 Y89.596 E.01576
G1 X81.955 Y88.817 E.01575
G1 X82.106 Y88.048 E.01576
G1 X82.33 Y87.298 E.01574
G1 X82.625 Y86.572 E.01575
G1 X82.989 Y85.879 E.01574
G1 X83.418 Y85.224 E.01574
G1 X83.908 Y84.613 E.01575
G1 X84.454 Y84.052 E.01574
G1 X85.051 Y83.546 E.01574
G1 X85.695 Y83.101 E.01574
G1 X85.727 Y83.083 E.00074
M204 S250
G1 X85.58 Y82.696 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1800
M204 S5000
G1 X86.196 Y82.352 E.01319
G1 X86.949 Y82.021 E.01537
G1 X87.502 Y81.836 E.0109
G1 X88.012 Y81.693 E.00988
G1 X88.82 Y81.54 E.01538
G1 X89.639 Y81.465 E.01536
G1 X90.461 Y81.47 E.01536
G1 X91.279 Y81.554 E.01537
G1 X92.086 Y81.716 E.01536
G1 X92.872 Y81.955 E.01536
G1 X93.632 Y82.269 E.01536
G1 X94.359 Y82.654 E.01536
G1 X95.045 Y83.108 E.01538
G1 X95.502 Y83.471 E.0109
G1 X95.898 Y83.821 E.00989
G1 X96.466 Y84.418 E.01538
G1 X96.973 Y85.065 E.01536
G1 X97.415 Y85.759 E.01537
G1 X97.788 Y86.492 E.01537
G1 X98.09 Y87.257 E.01537
G1 X98.316 Y88.048 E.01538
G1 X98.465 Y88.858 E.01537
G1 X98.536 Y89.678 E.01538
G1 X98.527 Y90.502 E.0154
G1 X98.469 Y91.084 E.01093
G1 X98.389 Y91.607 E.00989
G1 X98.195 Y92.409 E.01541
G1 X97.925 Y93.187 E.01539
G1 X97.581 Y93.936 E.01539
G1 X97.167 Y94.648 E.0154
G1 X96.686 Y95.317 E.0154
G1 X96.143 Y95.936 E.01539
G1 X95.542 Y96.5 E.01539
G1 X94.891 Y97.003 E.01538
G1 X94.195 Y97.441 E.01537
G1 X93.46 Y97.809 E.01535
G1 X92.695 Y98.105 E.01533
G1 X91.906 Y98.326 E.01531
G1 X91.101 Y98.47 E.01528
G1 X90.286 Y98.536 E.01529
G1 X89.806 Y98.539 E.00897
G1 X89.376 Y98.518 E.00804
G1 X88.564 Y98.419 E.01529
G1 X87.765 Y98.243 E.01528
G1 X86.986 Y97.99 E.01531
G1 X86.229 Y97.662 E.01542
G1 X85.513 Y97.265 E.01529
G1 X85.267 Y97.111 E.00542
G1 X84.835 Y96.799 E.00996
G1 X84.605 Y96.623 E.00541
G1 X84.206 Y96.271 E.00993
G1 X83.787 Y95.862 E.01096
G1 X83.594 Y95.645 E.00541
G1 X83.251 Y95.236 E.00998
G1 X83.08 Y95.002 E.00542
G1 X82.777 Y94.561 E.00998
G1 X82.63 Y94.313 E.0054
G1 X82.249 Y93.584 E.01536
G1 X81.938 Y92.817 E.01547
G1 X81.704 Y92.027 E.01539
G1 X81.547 Y91.219 E.01538
G1 X81.468 Y90.399 E.01539
G1 X81.469 Y89.576 E.01538
G1 X81.549 Y88.757 E.01538
G1 X81.708 Y87.95 E.01538
G1 X81.943 Y87.162 E.01537
G1 X82.254 Y86.399 E.01538
G1 X82.636 Y85.671 E.01537
G1 X83.086 Y84.983 E.01537
G1 X83.601 Y84.341 E.01537
G1 X84.174 Y83.752 E.01536
G1 X84.802 Y83.221 E.01537
G1 X85.478 Y82.753 E.01536
G1 X85.527 Y82.725 E.00106
; WIPE_START
M204 S6000
G1 X86.196 Y82.352 E-.10912
G1 X86.949 Y82.021 E-.11723
G1 X87.339 Y81.89 E-.05865
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
G1 X0 Y90.0001 ; move to safe pos
G1 X-13.0 F3000 ; move to safe pos
M400
M1004 S5 P1  ; external shutter
M400 P300
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
G1 X94.999 Y84.715
G1 Z.44
G1 E.3 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.419992
G1 F4800
M204 S6000
G1 X94.456 Y84.227 E.01363
G1 X93.866 Y83.818 E.01343
G1 X93.234 Y83.464 E.01353
G1 X92.57 Y83.175 E.01354
G1 X91.88 Y82.953 E.01354
G1 X91.172 Y82.8 E.01353
G1 X90.452 Y82.719 E.01353
G1 X89.731 Y82.709 E.01348
G1 X89.046 Y82.767 E.01285
G1 X87.863 Y83.025 E.02262
G1 X87.366 Y83.196 E.00982
G1 X86.75 Y83.466 E.01258
G1 X86.136 Y83.809 E.01312
G1 X85.559 Y84.208 E.01312
G1 X85.023 Y84.662 E.01313
G1 X84.533 Y85.165 E.01312
G1 X84.093 Y85.714 E.01313
G1 X83.708 Y86.302 E.01313
G1 X83.382 Y86.924 E.01313
G1 X83.117 Y87.575 E.01314
G1 X82.916 Y88.248 E.01313
G1 X82.78 Y88.938 E.01314
G1 X82.712 Y89.638 E.01313
G1 X82.711 Y90.341 E.01314
G1 X82.778 Y91.041 E.01314
G1 X82.912 Y91.731 E.01314
G1 X83.112 Y92.406 E.01315
G1 X83.384 Y93.077 E.01354
G1 X83.706 Y93.691 E.01295
G1 X84.091 Y94.279 E.01312
G1 X84.689 Y95.006 E.0176
G1 X85.048 Y95.357 E.00938
G1 X85.58 Y95.804 E.01299
G1 X86.16 Y96.203 E.01316
G1 X86.763 Y96.539 E.01289
G1 X87.426 Y96.826 E.0135
G1 X88.092 Y97.042 E.01308
G1 X88.774 Y97.193 E.01305
G1 X89.476 Y97.279 E.01322
G1 X90.236 Y97.293 E.0142
G1 X90.941 Y97.236 E.01322
G1 X91.629 Y97.113 E.01305
G1 X92.303 Y96.924 E.01308
G1 X92.956 Y96.672 E.01309
G1 X93.584 Y96.357 E.01312
G1 X94.179 Y95.983 E.01313
G1 X94.735 Y95.553 E.01314
G1 X95.248 Y95.072 E.01314
G1 X95.712 Y94.542 E.01316
G1 X96.123 Y93.971 E.01315
G1 X96.477 Y93.363 E.01316
G1 X96.771 Y92.723 E.01315
G1 X97 Y92.061 E.01309
G1 X97.236 Y90.923 E.02171
G1 X97.285 Y90.398 E.00986
G1 X97.292 Y89.762 E.01189
G1 X97.245 Y89.171 E.01107
G1 X97.127 Y88.456 E.01355
G1 X96.94 Y87.756 E.01354
G1 X96.684 Y87.078 E.01353
G1 X96.362 Y86.429 E.01354
G1 X95.977 Y85.816 E.01353
G1 X95.557 Y85.273 E.01282
G1 X95.041 Y84.758 E.01363
; WIPE_START
G1 X95.557 Y85.273 E-.10394
G1 X95.977 Y85.816 E-.09777
G1 X96.287 Y86.311 E-.08329
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X96.765 Y91.252 Z.84 F18000
G1 Z.44
G1 E.3 F1800
G1 F4800
M204 S6000
G1 X96.875 Y90.573 E.01286
G1 X96.898 Y89.757 E.01524
G1 X96.852 Y89.205 E.01036
G1 X96.74 Y88.527 E.01284
G1 X96.561 Y87.864 E.01283
G1 X96.317 Y87.223 E.01282
G1 X96.01 Y86.608 E.01284
G1 X95.645 Y86.028 E.01282
G1 X95.247 Y85.516 E.01211
G1 X94.722 Y84.996 E.0138
G1 X94.211 Y84.536 E.01286
G1 X93.649 Y84.147 E.01277
G1 X93.049 Y83.813 E.01282
G1 X92.419 Y83.539 E.01283
G1 X91.765 Y83.33 E.01283
G1 X91.094 Y83.187 E.01282
G1 X90.412 Y83.111 E.01282
G1 X89.729 Y83.103 E.01277
G1 X89.082 Y83.16 E.01214
G1 X88.042 Y83.389 E.0199
G1 X87.556 Y83.545 E.00953
G1 X86.942 Y83.812 E.01251
G1 X86.361 Y84.134 E.01241
G1 X85.814 Y84.511 E.01241
G1 X85.306 Y84.939 E.01242
G1 X84.841 Y85.414 E.01241
G1 X84.424 Y85.931 E.01241
G1 X84.059 Y86.486 E.01242
G1 X83.749 Y87.074 E.01241
G1 X83.496 Y87.689 E.01243
G1 X83.35 Y88.173 E.00944
G1 X83.219 Y88.748 E.01102
G1 X83.128 Y89.428 E.01283
G1 X83.106 Y90.114 E.01282
G1 X83.151 Y90.799 E.01282
G1 X83.264 Y91.476 E.01283
G1 X83.444 Y92.138 E.01282
G1 X83.689 Y92.779 E.01283
G1 X83.996 Y93.394 E.01284
G1 X84.362 Y93.973 E.01282
G1 X84.794 Y94.513 E.01291
G1 X85.265 Y95.017 E.0129
G1 X85.781 Y95.458 E.01268
G1 X86.344 Y95.851 E.01282
G1 X86.921 Y96.176 E.01238
G1 X87.549 Y96.45 E.01279
G1 X88.178 Y96.656 E.01237
G1 X88.822 Y96.8 E.01234
G1 X89.484 Y96.882 E.01247
G1 X90.205 Y96.898 E.01346
G1 X90.872 Y96.846 E.01251
G1 X91.523 Y96.731 E.01235
G1 X92.161 Y96.555 E.01237
G1 X92.78 Y96.317 E.01238
G1 X93.374 Y96.021 E.0124
G1 X93.8 Y95.755 E.0094
G1 X94.385 Y95.325 E.01357
G1 X94.893 Y94.864 E.01283
G1 X95.353 Y94.353 E.01284
G1 X95.76 Y93.8 E.01283
G1 X96.11 Y93.21 E.01283
G1 X96.397 Y92.592 E.01272
G1 X96.611 Y91.98 E.01213
G1 X96.753 Y91.311 E.01277
M204 S10000
G1 X96.406 Y91.178 F18000
; LINE_WIDTH: 0.383153
G1 F4800
M204 S6000
G1 X96.501 Y90.535 E.01101
G1 X96.52 Y89.753 E.01325
G1 X96.478 Y89.237 E.00878
G1 X96.37 Y88.595 E.01102
G1 X96.199 Y87.968 E.01102
G1 X95.966 Y87.361 E.01101
G1 X95.674 Y86.779 E.01102
G1 X95.326 Y86.231 E.01101
G1 X94.949 Y85.749 E.01036
G1 X94.465 Y85.258 E.01168
G1 X93.977 Y84.829 E.01101
G1 X93.442 Y84.46 E.01101
G1 X92.874 Y84.144 E.01101
G1 X92.276 Y83.887 E.01102
G1 X91.656 Y83.69 E.01102
G1 X91.02 Y83.556 E.01101
G1 X90.374 Y83.486 E.01101
G1 X89.727 Y83.48 E.01096
G1 X89.116 Y83.542 E.01039
G1 X88.124 Y83.754 E.0172
G1 X87.511 Y83.972 E.01101
G1 X86.923 Y84.249 E.01102
G1 X86.366 Y84.584 E.01101
G1 X85.845 Y84.973 E.01102
G1 X85.365 Y85.412 E.01101
G1 X84.931 Y85.897 E.01102
G1 X84.548 Y86.422 E.01101
G1 X84.219 Y86.982 E.01101
G1 X83.947 Y87.573 E.01101
G1 X83.735 Y88.188 E.01101
G1 X83.586 Y88.82 E.01101
G1 X83.5 Y89.465 E.01102
G1 X83.479 Y90.115 E.01101
G1 X83.523 Y90.763 E.01101
G1 X83.631 Y91.404 E.01102
G1 X83.803 Y92.031 E.01101
G1 X84.036 Y92.638 E.01101
G1 X84.327 Y93.219 E.01102
G1 X84.676 Y93.768 E.01101
G1 X85.081 Y94.277 E.01102
G1 X85.528 Y94.749 E.011
G1 X86.023 Y95.171 E.01102
G1 X86.557 Y95.541 E.01102
G1 X87.105 Y95.846 E.01061
G1 X87.699 Y96.104 E.01097
G1 X88.294 Y96.296 E.0106
G1 X88.904 Y96.43 E.01057
G1 X89.53 Y96.506 E.01069
G1 X90.212 Y96.52 E.01155
G1 X90.842 Y96.468 E.0107
G1 X91.456 Y96.358 E.01058
G1 X92.059 Y96.189 E.0106
G1 X92.643 Y95.963 E.01061
G1 X93.202 Y95.679 E.01062
G1 X93.632 Y95.419 E.00851
G1 X94.156 Y95.028 E.01107
G1 X94.636 Y94.589 E.01101
G1 X95.07 Y94.105 E.01102
G1 X95.454 Y93.58 E.01102
G1 X95.784 Y93.02 E.01101
G1 X96.054 Y92.435 E.01091
G1 X96.254 Y91.856 E.01038
G1 X96.393 Y91.237 E.01074
; WIPE_START
G1 X96.254 Y91.856 E-.09038
G1 X96.054 Y92.435 E-.08734
G1 X95.784 Y93.02 E-.0918
G1 X95.729 Y93.113 E-.01547
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X92.813 Y95.005 Z.84 F18000
G1 Z.44
G1 E.3 F1800
; LINE_WIDTH: 0.419992
G1 F4800
M204 S6000
G1 X92.342 Y95.25 E.00991
G1 X91.831 Y95.45 E.01026
G1 X91.303 Y95.6 E.01025
G1 X90.765 Y95.7 E.01023
G1 X90.212 Y95.747 E.01037
G1 X89.703 Y95.746 E.0095
G1 X89.148 Y95.691 E.01044
G1 X88.59 Y95.579 E.01063
G1 X88.041 Y95.41 E.01072
G1 X87.512 Y95.189 E.01072
G1 X87.008 Y94.915 E.01072
G1 X86.533 Y94.593 E.01072
G1 X86.093 Y94.225 E.01072
G1 X85.692 Y93.815 E.01071
G1 X85.334 Y93.367 E.01072
G1 X85.022 Y92.886 E.01071
G1 X84.772 Y92.401 E.0102
G1 X84.559 Y91.869 E.0107
G1 X84.392 Y91.29 E.01126
G1 X84.304 Y90.796 E.00938
G1 X84.255 Y90.247 E.01031
G1 X84.258 Y89.695 E.01031
M73 P59 R5
G1 X84.314 Y89.147 E.01029
G1 X84.423 Y88.606 E.01031
G1 X84.582 Y88.079 E.01029
G1 X84.791 Y87.569 E.0103
G1 X85.048 Y87.082 E.01029
G1 X85.35 Y86.621 E.01029
G1 X85.695 Y86.192 E.01029
G1 X86.079 Y85.798 E.01028
G1 X86.499 Y85.442 E.01029
G1 X86.951 Y85.128 E.01029
G1 X87.431 Y84.858 E.01028
G1 X87.942 Y84.633 E.01043
G1 X88.867 Y84.358 E.01803
G1 X89.702 Y84.254 E.01572
G1 X90.277 Y84.253 E.01076
G1 X90.848 Y84.309 E.01071
G1 X91.41 Y84.421 E.01071
G1 X91.959 Y84.59 E.01072
G1 X92.474 Y84.806 E.01045
G1 X92.959 Y85.067 E.01029
G1 X93.424 Y85.379 E.01046
G1 X93.906 Y85.775 E.01167
G1 X94.308 Y86.185 E.01071
G1 X94.666 Y86.633 E.01072
G1 X94.978 Y87.114 E.01072
G1 X95.241 Y87.625 E.01072
G1 X95.451 Y88.158 E.01071
G1 X95.607 Y88.71 E.01072
G1 X95.706 Y89.261 E.01047
G1 X95.749 Y89.811 E.01031
G1 X95.74 Y90.371 E.01046
G1 X95.668 Y90.99 E.01164
G1 X95.541 Y91.549 E.01072
G1 X95.36 Y92.093 E.01072
G1 X95.125 Y92.616 E.01072
G1 X94.839 Y93.114 E.01071
G1 X94.505 Y93.58 E.01072
G1 X94.126 Y94.011 E.01073
G1 X93.709 Y94.399 E.01065
G1 X93.27 Y94.733 E.01031
G1 X92.864 Y94.974 E.00881
M204 S10000
G1 X93.01 Y95.346 F18000
G1 F4800
M204 S6000
G1 X92.495 Y95.613 E.01083
G1 X91.947 Y95.827 E.01099
G1 X91.381 Y95.987 E.01098
G1 X90.887 Y96.084 E.00941
G1 X90.324 Y96.14 E.01056
G1 X89.723 Y96.142 E.01124
G1 X89.113 Y96.084 E.01146
G1 X88.512 Y95.965 E.01145
G1 X87.925 Y95.787 E.01145
G1 X87.359 Y95.552 E.01145
G1 X86.819 Y95.261 E.01145
G1 X86.311 Y94.918 E.01145
G1 X85.84 Y94.527 E.01146
G1 X85.41 Y94.09 E.01145
G1 X85.025 Y93.613 E.01146
G1 X84.69 Y93.1 E.01145
G1 X84.421 Y92.58 E.01093
G1 X84.192 Y92.013 E.01143
G1 X84.013 Y91.397 E.01199
G1 X83.916 Y90.865 E.01011
G1 X83.862 Y90.276 E.01105
G1 X83.864 Y89.685 E.01104
G1 X83.923 Y89.098 E.01103
G1 X84.038 Y88.518 E.01104
G1 X84.208 Y87.953 E.01102
G1 X84.432 Y87.407 E.01103
G1 X84.707 Y86.885 E.01102
G1 X85.03 Y86.391 E.01103
G1 X85.399 Y85.931 E.01102
G1 X85.811 Y85.509 E.01102
G1 X86.261 Y85.128 E.01103
G1 X86.745 Y84.791 E.01102
G1 X87.26 Y84.503 E.01102
G1 X87.807 Y84.262 E.01117
G1 X88.77 Y83.976 E.01877
G1 X89.653 Y83.862 E.01665
G1 X90.278 Y83.858 E.01167
G1 X90.887 Y83.916 E.01143
G1 X91.488 Y84.035 E.01145
G1 X92.075 Y84.213 E.01145
G1 X92.628 Y84.443 E.01119
G1 X93.148 Y84.721 E.01102
G1 X93.646 Y85.053 E.01119
G1 X94.16 Y85.473 E.01241
G1 X94.59 Y85.91 E.01145
G1 X94.974 Y86.387 E.01145
G1 X95.309 Y86.9 E.01145
G1 X95.591 Y87.445 E.01146
G1 X95.818 Y88.014 E.01145
G1 X95.987 Y88.603 E.01145
G1 X96.094 Y89.193 E.0112
G1 X96.142 Y89.782 E.01104
G1 X96.134 Y90.38 E.01119
G1 X96.059 Y91.039 E.01238
G1 X95.926 Y91.637 E.01145
G1 X95.733 Y92.219 E.01146
G1 X95.484 Y92.779 E.01145
G1 X95.18 Y93.311 E.01145
G1 X94.825 Y93.81 E.01145
G1 X94.421 Y94.272 E.01146
G1 X93.977 Y94.688 E.01138
G1 X93.508 Y95.048 E.01105
G1 X93.061 Y95.315 E.00973
; CHANGE_LAYER
; Z_HEIGHT: 0.56
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F4800
G1 X93.508 Y95.048 E-.07418
G1 X93.977 Y94.688 E-.08425
G1 X94.421 Y94.272 E-.08679
G1 X94.605 Y94.061 E-.03979
; WIPE_END
G1 E-.015 F1800
; layer num/total_layer_count: 4/33
; update layer progress
M73 L4
M991 S0 P3 ;notify layer change
M106 S73.95
; OBJECT_ID: 8
M204 S10000
G17
G3 Z.84 I1.211 J.125 P1  F18000
G1 X94.778 Y92.39 Z.84
G1 Z.56
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F3600
M204 S6000
G1 X94.756 Y92.439 E.00107
G1 X94.49 Y92.9 E.01071
G1 X94.185 Y93.324 E.0105
G1 X93.98 Y93.565 E.00636
G1 X93.635 Y93.918 E.00994
G1 X93.227 Y94.261 E.0107
G1 X92.787 Y94.561 E.01071
G1 X92.319 Y94.816 E.01071
G1 X91.828 Y95.022 E.01071
G1 X91.319 Y95.18 E.01072
G1 X90.796 Y95.285 E.01071
G1 X90.266 Y95.338 E.01071
G1 X89.733 Y95.338 E.01071
G1 X89.203 Y95.285 E.01071
G1 X88.681 Y95.18 E.01071
G1 X88.172 Y95.022 E.01072
G1 X87.681 Y94.815 E.01071
G1 X87.213 Y94.561 E.01071
G1 X86.773 Y94.261 E.01072
G1 X86.364 Y93.918 E.01072
G1 X85.993 Y93.537 E.01071
G1 X85.66 Y93.12 E.01072
G1 X85.371 Y92.672 E.01071
G1 X85.128 Y92.198 E.01072
G1 X84.933 Y91.702 E.01071
G1 X84.789 Y91.19 E.01071
G1 X84.697 Y90.664 E.01072
G1 X84.657 Y90.133 E.01071
G1 X84.67 Y89.601 E.01071
G1 X84.736 Y89.072 E.01071
G1 X84.855 Y88.552 E.01072
G1 X85.025 Y88.047 E.01071
G1 X85.244 Y87.562 E.01072
G1 X85.51 Y87.1 E.01071
G1 X85.821 Y86.668 E.01071
G1 X86.174 Y86.268 E.01071
G1 X86.564 Y85.906 E.01071
G1 X86.989 Y85.584 E.01072
G1 X87.444 Y85.306 E.01072
G1 X87.924 Y85.075 E.01071
G1 X88.425 Y84.893 E.01072
G1 X88.941 Y84.761 E.01071
G1 X89.457 Y84.683 E.0105
G1 X89.773 Y84.661 E.00636
G1 X90.267 Y84.662 E.00994
G1 X90.796 Y84.715 E.0107
G1 X91.319 Y84.82 E.01071
G1 X91.828 Y84.978 E.01072
G1 X92.319 Y85.185 E.01071
G1 X92.787 Y85.439 E.01071
G1 X93.227 Y85.739 E.01071
G1 X93.635 Y86.082 E.01072
G1 X94.007 Y86.463 E.01071
G1 X94.339 Y86.88 E.01071
G1 X94.629 Y87.328 E.01072
G1 X94.872 Y87.802 E.01071
G1 X95.066 Y88.298 E.01071
G1 X95.211 Y88.81 E.01071
G1 X95.303 Y89.335 E.01072
G1 X95.343 Y89.867 E.01071
G1 X95.33 Y90.399 E.01071
G1 X95.263 Y90.928 E.01071
G1 X95.145 Y91.448 E.01072
G1 X94.975 Y91.953 E.01071
G1 X94.802 Y92.335 E.00845
M204 S10000
G1 X94.391 Y92.216 F18000
G1 F3600
M204 S6000
G1 X94.378 Y92.245 E.00064
G1 X94.133 Y92.669 E.00986
G1 X93.85 Y93.063 E.00974
G1 X93.666 Y93.279 E.00571
G1 X93.346 Y93.607 E.00921
G1 X92.97 Y93.922 E.00986
G1 X92.565 Y94.198 E.00986
G1 X92.135 Y94.433 E.00986
G1 X91.683 Y94.623 E.00986
G1 X91.214 Y94.768 E.00987
G1 X90.733 Y94.865 E.00986
G1 X90.245 Y94.914 E.00986
G1 X89.755 Y94.914 E.00986
G1 X89.267 Y94.865 E.00986
G1 X88.786 Y94.768 E.00986
G1 X88.317 Y94.623 E.00987
G1 X87.865 Y94.433 E.00986
G1 X87.434 Y94.198 E.00986
G1 X87.029 Y93.922 E.00986
G1 X86.653 Y93.607 E.00986
G1 X86.311 Y93.256 E.00986
G1 X86.005 Y92.872 E.00987
G1 X85.739 Y92.46 E.00986
G1 X85.515 Y92.024 E.00986
G1 X85.336 Y91.567 E.00986
G1 X85.203 Y91.095 E.00986
G1 X85.118 Y90.612 E.00987
G1 X85.081 Y90.123 E.00986
G1 X85.094 Y89.632 E.00986
G1 X85.155 Y89.146 E.00986
G1 X85.264 Y88.667 E.00987
G1 X85.42 Y88.202 E.00986
G1 X85.622 Y87.755 E.00986
G1 X85.867 Y87.331 E.00986
G1 X86.153 Y86.932 E.00986
G1 X86.478 Y86.565 E.00986
G1 X86.837 Y86.231 E.00986
G1 X87.228 Y85.935 E.00986
G1 X87.647 Y85.679 E.00987
G1 X88.089 Y85.466 E.00986
G1 X88.55 Y85.299 E.00986
G1 X89.025 Y85.178 E.00986
G1 X89.504 Y85.105 E.00974
G1 X89.787 Y85.086 E.00571
G1 X90.245 Y85.086 E.00921
G1 X90.733 Y85.135 E.00985
G1 X91.214 Y85.232 E.00986
G1 X91.683 Y85.377 E.00987
G1 X92.135 Y85.567 E.00986
G1 X92.565 Y85.802 E.00986
G1 X92.97 Y86.078 E.00986
G1 X93.346 Y86.393 E.00986
G1 X93.689 Y86.744 E.00986
G1 X93.995 Y87.128 E.00986
G1 X94.261 Y87.54 E.00986
G1 X94.484 Y87.976 E.00986
G1 X94.664 Y88.433 E.00986
G1 X94.796 Y88.905 E.00986
G1 X94.882 Y89.388 E.00987
G1 X94.918 Y89.877 E.00986
G1 X94.906 Y90.368 E.00986
G1 X94.845 Y90.854 E.00986
G1 X94.736 Y91.333 E.00987
G1 X94.58 Y91.797 E.00986
G1 X94.416 Y92.161 E.00802
M204 S250
G1 X94.018 Y92.047 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1800
M204 S5000
G1 X94.013 Y92.058 E.00021
G1 X93.789 Y92.447 E.0084
G1 X93.527 Y92.81 E.00836
G1 X93.067 Y93.306 E.01264
G1 X92.723 Y93.595 E.0084
G1 X92.352 Y93.849 E.0084
G1 X91.957 Y94.064 E.0084
G1 X91.542 Y94.238 E.0084
G1 X91.113 Y94.371 E.0084
G1 X90.672 Y94.46 E.0084
G1 X90.225 Y94.505 E.0084
G1 X89.775 Y94.505 E.0084
G1 X89.328 Y94.46 E.0084
G1 X88.887 Y94.371 E.0084
G1 X88.457 Y94.238 E.0084
G1 X88.043 Y94.064 E.0084
G1 X87.648 Y93.849 E.0084
G1 X87.277 Y93.595 E.0084
G1 X86.932 Y93.306 E.0084
G1 X86.618 Y92.984 E.0084
G1 X86.338 Y92.633 E.0084
G1 X86.094 Y92.255 E.0084
G1 X85.889 Y91.855 E.0084
G1 X85.724 Y91.436 E.0084
G1 X85.603 Y91.004 E.0084
G1 X85.525 Y90.561 E.0084
G1 X85.491 Y90.112 E.0084
G1 X85.502 Y89.663 E.0084
G1 X85.558 Y89.217 E.0084
G1 X85.658 Y88.778 E.0084
G1 X85.801 Y88.352 E.0084
G1 X85.986 Y87.942 E.0084
G1 X86.211 Y87.553 E.0084
G1 X86.474 Y87.188 E.0084
G1 X86.771 Y86.851 E.0084
G1 X87.101 Y86.545 E.0084
G1 X87.459 Y86.274 E.0084
G1 X87.843 Y86.039 E.00841
G1 X88.248 Y85.844 E.0084
G1 X88.67 Y85.69 E.0084
G1 X89.106 Y85.579 E.0084
G1 X89.549 Y85.512 E.00836
G1 X90.225 Y85.495 E.01264
G1 X90.672 Y85.54 E.0084
G1 X91.113 Y85.629 E.0084
G1 X91.542 Y85.762 E.0084
G1 X91.957 Y85.936 E.0084
G1 X92.352 Y86.151 E.0084
G1 X92.723 Y86.405 E.0084
G1 X93.068 Y86.694 E.0084
G1 X93.381 Y87.016 E.0084
G1 X93.662 Y87.367 E.0084
G1 X93.906 Y87.745 E.0084
G1 X94.111 Y88.145 E.0084
G1 X94.275 Y88.563 E.0084
G1 X94.397 Y88.996 E.0084
G1 X94.475 Y89.439 E.0084
G1 X94.509 Y89.888 E.0084
G1 X94.497 Y90.337 E.0084
G1 X94.442 Y90.783 E.0084
G1 X94.342 Y91.222 E.0084
G1 X94.198 Y91.648 E.0084
G1 X94.043 Y91.993 E.00707
; WIPE_START
M204 S6000
G1 X94.013 Y92.058 E-.01018
G1 X93.789 Y92.447 E-.06406
G1 X93.527 Y92.81 E-.06376
G1 X93.067 Y93.306 E-.09639
G1 X92.795 Y93.535 E-.05061
; WIPE_END
G1 E-.015
M204 S10000
G1 X88.525 Y87.209 Z.96 F18000
G1 X86.066 Y83.567 Z.96
G1 Z.56
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F3600
M204 S6000
G1 X86.668 Y83.233 E.01384
G1 X87.336 Y82.944 E.01464
G1 X88.217 Y82.672 E.01854
G1 X88.932 Y82.533 E.01465
G1 X89.663 Y82.465 E.01476
G1 X90.397 Y82.468 E.01476
G1 X91.128 Y82.542 E.01477
G1 X91.848 Y82.687 E.01476
G1 X92.55 Y82.901 E.01476
G1 X93.228 Y83.183 E.01476
G1 X93.875 Y83.529 E.01476
G1 X94.481 Y83.934 E.01465
G1 X95.188 Y84.526 E.01854
G1 X95.692 Y85.051 E.01464
G1 X96.146 Y85.628 E.01477
G1 X96.542 Y86.247 E.01476
G1 X96.876 Y86.901 E.01477
G1 X97.145 Y87.584 E.01476
G1 X97.346 Y88.291 E.01478
G1 X97.478 Y89.014 E.01476
G1 X97.538 Y89.746 E.01478
G1 X97.527 Y90.475 E.01466
G1 X97.412 Y91.391 E.01857
G1 X97.244 Y92.1 E.01466
G1 X97.005 Y92.796 E.01478
G1 X96.7 Y93.464 E.01478
G1 X96.331 Y94.1 E.01478
G1 X95.901 Y94.697 E.01478
G1 X95.416 Y95.25 E.01478
G1 X94.879 Y95.752 E.01478
G1 X94.297 Y96.199 E.01477
G1 X93.673 Y96.587 E.01477
G1 X93.016 Y96.913 E.01475
G1 X92.335 Y97.171 E.01463
G1 X91.446 Y97.402 E.01848
G1 X90.729 Y97.507 E.01457
G1 X89.997 Y97.543 E.01473
G1 X89.378 Y97.516 E.01245
G1 X88.491 Y97.391 E.01802
G1 X87.779 Y97.208 E.01479
G1 X87.086 Y96.958 E.0148
G1 X86.577 Y96.719 E.01131
G1 X86.276 Y96.559 E.00685
G1 X85.8 Y96.266 E.01124
G1 X85.341 Y95.927 E.01147
G1 X85.075 Y95.713 E.00687
G1 X84.801 Y95.459 E.00752
G1 X84.422 Y95.071 E.01089
G1 X84.062 Y94.651 E.01114
G1 X83.636 Y94.049 E.01483
G1 X83.272 Y93.41 E.01478
G1 X82.972 Y92.739 E.01478
G1 X82.739 Y92.041 E.01478
G1 X82.574 Y91.325 E.01478
G1 X82.482 Y90.602 E.01464
G1 X82.465 Y89.679 E.01857
G1 X82.531 Y88.953 E.01466
G1 X82.668 Y88.231 E.01478
G1 X82.875 Y87.527 E.01477
G1 X83.149 Y86.845 E.01477
G1 X83.488 Y86.194 E.01477
G1 X83.889 Y85.579 E.01477
G1 X84.348 Y85.005 E.01477
G1 X84.86 Y84.479 E.01477
G1 X85.421 Y84.006 E.01476
G1 X86.014 Y83.597 E.01448
M204 S10000
G1 X85.86 Y83.196 F18000
G1 F3600
M204 S6000
G1 X86.481 Y82.852 E.01426
G1 X87.189 Y82.546 E.01552
G1 X88.114 Y82.26 E.01947
G1 X88.872 Y82.113 E.01553
G1 X89.644 Y82.041 E.0156
G1 X90.42 Y82.044 E.01559
G1 X91.191 Y82.122 E.0156
G1 X91.952 Y82.275 E.0156
G1 X92.694 Y82.502 E.0156
G1 X93.41 Y82.799 E.01559
G1 X94.093 Y83.165 E.01559
G1 X94.736 Y83.594 E.01554
G1 X95.478 Y84.216 E.01947
G1 X96.012 Y84.773 E.01552
G1 X96.492 Y85.382 E.0156
G1 X96.911 Y86.035 E.0156
G1 X97.264 Y86.726 E.0156
G1 X97.548 Y87.448 E.0156
G1 X97.76 Y88.195 E.01561
G1 X97.899 Y88.958 E.0156
G1 X97.962 Y89.732 E.01561
G1 X97.951 Y90.504 E.01554
G1 X97.831 Y91.466 E.01949
G1 X97.652 Y92.219 E.01554
G1 X97.4 Y92.953 E.01562
G1 X97.077 Y93.66 E.01561
G1 X96.687 Y94.331 E.01562
G1 X96.234 Y94.962 E.01562
G1 X95.721 Y95.545 E.01562
G1 X95.154 Y96.076 E.01561
G1 X94.538 Y96.548 E.01561
G1 X93.88 Y96.958 E.0156
G1 X93.185 Y97.302 E.01558
G1 X92.464 Y97.576 E.0155
G1 X91.53 Y97.819 E.01941
G1 X90.77 Y97.93 E.01545
G1 X89.998 Y97.968 E.01554
G1 X89.346 Y97.94 E.01312
G1 X88.405 Y97.806 E.01911
G1 X87.654 Y97.614 E.01559
G1 X86.924 Y97.35 E.01561
G1 X86.387 Y97.098 E.01191
G1 X86.066 Y96.927 E.00733
G1 X85.563 Y96.618 E.01187
G1 X85.082 Y96.263 E.01201
G1 X84.797 Y96.034 E.00735
G1 X84.505 Y95.763 E.00803
G1 X84.109 Y95.358 E.01138
G1 X83.727 Y94.912 E.01181
G1 X83.277 Y94.276 E.01565
G1 X82.893 Y93.602 E.01561
G1 X82.576 Y92.893 E.01562
G1 X82.33 Y92.156 E.01561
G1 X82.156 Y91.399 E.01562
G1 X82.058 Y90.633 E.01553
G1 X82.041 Y89.664 E.01949
G1 X82.11 Y88.895 E.01553
G1 X82.255 Y88.132 E.01561
G1 X82.473 Y87.387 E.0156
G1 X82.763 Y86.668 E.0156
G1 X83.121 Y85.979 E.0156
G1 X83.545 Y85.33 E.0156
G1 X84.029 Y84.724 E.0156
G1 X84.571 Y84.168 E.0156
G1 X85.164 Y83.668 E.01559
G1 X85.802 Y83.228 E.0156
G1 X85.808 Y83.225 E.00012
M204 S250
G1 X85.662 Y82.838 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1800
M204 S5000
G1 X86.3 Y82.485 E.01362
G1 X87.047 Y82.161 E.01522
G1 X88.014 Y81.862 E.01892
G1 X88.814 Y81.707 E.01522
G1 X89.626 Y81.631 E.01524
G1 X90.441 Y81.634 E.01523
G1 X91.253 Y81.717 E.01524
G1 X92.052 Y81.878 E.01524
G1 X92.832 Y82.116 E.01524
G1 X93.585 Y82.429 E.01524
G1 X94.304 Y82.813 E.01523
G1 X94.982 Y83.266 E.01522
G1 X95.758 Y83.916 E.01893
G1 X96.322 Y84.504 E.01521
G1 X96.826 Y85.145 E.01524
G1 X97.266 Y85.831 E.01524
G1 X97.637 Y86.558 E.01524
G1 X97.936 Y87.317 E.01524
G1 X98.159 Y88.102 E.01525
G1 X98.305 Y88.905 E.01524
G1 X98.372 Y89.718 E.01525
G1 X98.36 Y90.533 E.01523
G1 X98.234 Y91.539 E.01895
G1 X98.045 Y92.333 E.01524
G1 X97.78 Y93.105 E.01526
G1 X97.441 Y93.848 E.01526
G1 X97.031 Y94.554 E.01526
G1 X96.554 Y95.217 E.01526
G1 X96.015 Y95.83 E.01526
G1 X95.419 Y96.388 E.01525
G1 X94.772 Y96.885 E.01525
G1 X94.079 Y97.316 E.01524
G1 X93.349 Y97.678 E.01523
G1 X92.589 Y97.966 E.01519
G1 X91.612 Y98.221 E.01887
G1 X90.81 Y98.338 E.01515
G1 X89.999 Y98.377 E.01516
G1 X89.315 Y98.348 E.0128
G1 X88.321 Y98.207 E.01875
G1 X87.533 Y98.006 E.01521
G1 X86.767 Y97.728 E.01523
G1 X86.204 Y97.464 E.01161
G1 X85.862 Y97.283 E.00724
G1 X85.334 Y96.957 E.0116
G1 X84.832 Y96.588 E.01164
G1 X84.53 Y96.344 E.00727
G1 X84.219 Y96.056 E.00791
G1 X83.807 Y95.634 E.01101
G1 X83.404 Y95.164 E.01158
G1 X82.932 Y94.497 E.01527
G1 X82.528 Y93.787 E.01526
G1 X82.194 Y93.042 E.01526
G1 X81.935 Y92.267 E.01526
G1 X81.753 Y91.471 E.01526
G1 X81.649 Y90.663 E.01523
G1 X81.631 Y89.649 E.01895
G1 X81.705 Y88.838 E.01522
G1 X81.857 Y88.036 E.01525
G1 X82.086 Y87.253 E.01524
G1 X82.391 Y86.496 E.01525
G1 X82.767 Y85.773 E.01524
G1 X83.213 Y85.089 E.01524
G1 X83.722 Y84.453 E.01524
G1 X84.292 Y83.869 E.01524
G1 X84.915 Y83.343 E.01524
G1 X85.587 Y82.88 E.01524
G1 X85.609 Y82.867 E.00049
; WIPE_START
M204 S6000
G1 X86.3 Y82.485 E-.11245
G1 X87.047 Y82.161 E-.11603
G1 X87.426 Y82.044 E-.05651
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
G1 X0 Y90.0001 ; move to safe pos
G1 X-13.0 F3000 ; move to safe pos
M400
M1004 S5 P1  ; external shutter
M400 P300
M971 S11 C11 O0
G92 E0
G1 X0 F18000
M623

; SKIPTYPE: head_wrap_detect
M622.1 S1
M1002 judge_flag g39_3rd_layer_detect_flag
M622 J1
    ; enable nozzle clog detect at 3rd layer
    


    M622.1 S1
    M1002 judge_flag g39_detection_flag
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




G1 X94.836 Y93.855
G1 Z.56
G1 E.3 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.516329
G1 F4800
M204 S6000
G1 X94.447 Y94.309 E.01389
G1 X94.007 Y94.721 E.01402
G1 X93.529 Y95.088 E.01401
G1 X93.018 Y95.407 E.01401
G1 X92.479 Y95.674 E.01399
G1 X91.928 Y95.885 E.01372
G1 X91.177 Y96.079 E.01802
G1 X90.597 Y96.163 E.01363
G1 X89.994 Y96.192 E.01405
G1 X89.108 Y96.129 E.02064
G1 X88.502 Y96.011 E.01435
G1 X87.911 Y95.832 E.01436
G1 X87.34 Y95.596 E.01436
G1 X86.797 Y95.302 E.01436
G1 X86.285 Y94.958 E.01436
G1 X85.81 Y94.562 E.01437
G1 X85.408 Y94.158 E.01325
G1 X84.988 Y93.642 E.01546
G1 X84.651 Y93.125 E.01435
G1 X84.366 Y92.577 E.01437
G1 X84.138 Y92.003 E.01436
G1 X83.967 Y91.41 E.01435
G1 X83.857 Y90.802 E.01437
G1 X83.809 Y90.186 E.01435
G1 X83.82 Y89.569 E.01435
G1 X83.893 Y88.956 E.01436
G1 X84.028 Y88.353 E.01436
G1 X84.221 Y87.766 E.01436
G1 X84.473 Y87.202 E.01436
M73 P60 R5
G1 X84.779 Y86.666 E.01435
G1 X85.136 Y86.163 E.01436
G1 X85.543 Y85.697 E.01436
G1 X85.993 Y85.275 E.01436
G1 X86.484 Y84.9 E.01436
G1 X87.009 Y84.575 E.01436
G1 X87.564 Y84.304 E.01436
G1 X88.144 Y84.091 E.01436
G1 X88.741 Y83.934 E.01435
G1 X89.689 Y83.813 E.02223
G1 X90.279 Y83.81 E.0137
G1 X90.892 Y83.868 E.01432
G1 X91.498 Y83.987 E.01436
G1 X92.089 Y84.166 E.01437
G1 X92.66 Y84.403 E.01436
G1 X93.192 Y84.689 E.01405
G1 X93.683 Y85.018 E.01374
G1 X94.19 Y85.437 E.0153
G1 X94.624 Y85.876 E.01436
G1 X95.012 Y86.357 E.01436
G1 X95.35 Y86.874 E.01436
G1 X95.635 Y87.422 E.01436
G1 X95.863 Y87.996 E.01436
G1 X96.034 Y88.59 E.01436
G1 X96.144 Y89.198 E.01437
G1 X96.193 Y89.801 E.01407
G1 X96.183 Y90.392 E.01374
G1 X96.106 Y91.044 E.01527
G1 X95.973 Y91.647 E.01436
G1 X95.779 Y92.234 E.01436
G1 X95.528 Y92.798 E.01437
G1 X95.222 Y93.335 E.01436
G1 X94.872 Y93.807 E.01367
M204 S10000
G1 X94.481 Y93.583 F18000
; LINE_WIDTH: 0.419992
G1 F4800
M204 S6000
G1 X94.129 Y93.998 E.01016
G1 X93.721 Y94.38 E.01045
G1 X93.279 Y94.721 E.01043
G1 X92.805 Y95.017 E.01043
G1 X92.307 Y95.265 E.01041
G1 X91.797 Y95.46 E.0102
G1 X91.089 Y95.643 E.01366
G1 X90.553 Y95.721 E.01012
G1 X89.994 Y95.747 E.01046
G1 X89.152 Y95.691 E.01576
G1 X88.59 Y95.579 E.01072
G1 X88.041 Y95.41 E.01072
G1 X87.512 Y95.188 E.01072
G1 X87.008 Y94.915 E.01071
G1 X86.533 Y94.593 E.01072
G1 X86.093 Y94.225 E.01072
G1 X85.725 Y93.849 E.00983
G1 X85.334 Y93.367 E.0116
G1 X85.022 Y92.886 E.01071
G1 X84.759 Y92.375 E.01072
G1 X84.549 Y91.842 E.01072
G1 X84.392 Y91.29 E.01071
G1 X84.292 Y90.725 E.01073
G1 X84.248 Y90.153 E.01071
G1 X84.261 Y89.58 E.01072
G1 X84.331 Y89.011 E.01072
G1 X84.458 Y88.451 E.01072
G1 X84.64 Y87.907 E.01072
G1 X84.875 Y87.384 E.01072
G1 X85.161 Y86.887 E.01071
G1 X85.495 Y86.42 E.01072
G1 X85.874 Y85.989 E.01072
G1 X86.294 Y85.599 E.01072
G1 X86.75 Y85.251 E.01072
G1 X87.239 Y84.951 E.01072
G1 X87.756 Y84.702 E.01072
G1 X88.295 Y84.504 E.01072
G1 X88.85 Y84.362 E.01071
G1 X89.742 Y84.253 E.01679
G1 X90.278 Y84.253 E.01001
G1 X90.848 Y84.309 E.0107
G1 X91.41 Y84.421 E.01072
G1 X91.959 Y84.59 E.01072
G1 X92.488 Y84.812 E.01072
G1 X92.98 Y85.078 E.01046
G1 X93.433 Y85.385 E.01022
G1 X93.906 Y85.775 E.01147
G1 X94.308 Y86.185 E.01071
G1 X94.666 Y86.633 E.01072
G1 X94.978 Y87.114 E.01072
G1 X95.241 Y87.624 E.01072
G1 X95.451 Y88.158 E.01072
G1 X95.607 Y88.71 E.01072
G1 X95.708 Y89.275 E.01073
G1 X95.751 Y89.834 E.01048
G1 X95.739 Y90.381 E.01022
G1 X95.668 Y90.989 E.01145
G1 X95.541 Y91.549 E.01072
G1 X95.36 Y92.093 E.01072
G1 X95.125 Y92.616 E.01072
G1 X94.839 Y93.114 E.01072
G1 X94.517 Y93.536 E.00991
; WIPE_START
G1 X94.839 Y93.114 E-.07557
G1 X95.125 Y92.616 E-.08173
G1 X95.36 Y92.093 E-.08177
G1 X95.462 Y91.787 E-.04593
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X87.893 Y90.803 Z.96 F18000
G1 X83.324 Y90.209 Z.96
G1 Z.56
G1 E.3 F1800
; LINE_WIDTH: 0.518548
G1 F4800
M204 S6000
G1 X83.363 Y90.788 E.01356
G1 X83.474 Y91.445 E.01556
G1 X83.651 Y92.086 E.01554
G1 X83.89 Y92.708 E.01555
G1 X84.19 Y93.302 E.01556
G1 X84.547 Y93.864 E.01554
G1 X84.957 Y94.387 E.01554
G1 X85.381 Y94.833 E.01437
G1 X85.864 Y95.253 E.01494
G1 X86.272 Y95.552 E.01182
G1 X86.96 Y95.955 E.01863
G1 X87.414 Y96.168 E.0117
G1 X88.019 Y96.387 E.01503
G1 X88.644 Y96.548 E.01507
G1 X89.445 Y96.664 E.01889
G1 X89.983 Y96.687 E.01259
G1 X90.634 Y96.657 E.01522
G1 X91.262 Y96.566 E.01483
G1 X92.063 Y96.36 E.01931
G1 X92.663 Y96.134 E.01498
G1 X93.246 Y95.846 E.01519
G1 X93.799 Y95.503 E.01521
G1 X94.317 Y95.107 E.01522
G1 X94.793 Y94.663 E.01521
G1 X95.222 Y94.172 E.01522
G1 X95.571 Y93.697 E.01376
G1 X95.925 Y93.102 E.01618
G1 X96.205 Y92.497 E.01556
G1 X96.42 Y91.874 E.01539
G1 X96.569 Y91.252 E.01494
G1 X96.66 Y90.555 E.01642
G1 X96.685 Y89.787 E.01796
G1 X96.64 Y89.223 E.01321
G1 X96.531 Y88.566 E.01556
G1 X96.356 Y87.923 E.01555
G1 X96.118 Y87.301 E.01556
G1 X95.82 Y86.705 E.01555
G1 X95.463 Y86.142 E.01556
G1 X95.055 Y85.621 E.01547
G1 X94.614 Y85.159 E.01491
G1 X94.079 Y84.707 E.01636
G1 X93.532 Y84.324 E.01561
G1 X92.95 Y84 E.01555
G1 X92.338 Y83.736 E.01556
G1 X91.704 Y83.534 E.01556
G1 X91.052 Y83.396 E.01555
G1 X90.391 Y83.324 E.01554
G1 X89.768 Y83.317 E.01455
G1 X89.066 Y83.381 E.01646
G1 X88.438 Y83.498 E.01492
G1 X87.646 Y83.742 E.01936
G1 X87.056 Y83.996 E.01499
G1 X86.487 Y84.31 E.01519
G1 X85.95 Y84.679 E.01521
G1 X85.452 Y85.097 E.0152
G1 X84.997 Y85.563 E.01521
G1 X84.589 Y86.07 E.0152
G1 X84.233 Y86.615 E.0152
G1 X83.931 Y87.192 E.01521
G1 X83.687 Y87.796 E.01521
G1 X83.502 Y88.42 E.01521
G1 X83.38 Y89.06 E.01521
G1 X83.321 Y89.697 E.01495
G1 X83.324 Y90.149 E.01055
M204 S10000
G1 X82.883 Y90.129 F18000
; LINE_WIDTH: 0.419992
G1 F4800
M204 S6000
G1 X82.925 Y90.844 E.01339
G1 X83.044 Y91.543 E.01325
G1 X83.232 Y92.226 E.01324
G1 X83.487 Y92.888 E.01324
G1 X83.806 Y93.521 E.01325
G1 X84.187 Y94.118 E.01324
G1 X84.622 Y94.675 E.0132
G1 X85.064 Y95.143 E.01203
G1 X85.574 Y95.587 E.01263
G1 X85.997 Y95.903 E.00987
G1 X86.737 Y96.338 E.01604
G1 X87.215 Y96.566 E.00989
G1 X87.868 Y96.805 E.01299
G1 X88.534 Y96.979 E.01287
G1 X89.382 Y97.104 E.01602
G1 X89.964 Y97.132 E.01088
G1 X90.656 Y97.101 E.01293
G1 X91.327 Y97.006 E.01267
G1 X92.175 Y96.79 E.01635
G1 X92.82 Y96.549 E.01287
G1 X93.443 Y96.244 E.01296
G1 X94.034 Y95.88 E.01297
G1 X94.588 Y95.46 E.01298
G1 X95.097 Y94.987 E.01298
G1 X95.558 Y94.468 E.01299
G1 X95.931 Y93.956 E.01182
G1 X96.308 Y93.324 E.01375
G1 X96.608 Y92.681 E.01326
G1 X96.84 Y92.018 E.01312
G1 X97 Y91.355 E.01276
G1 X97.098 Y90.61 E.01404
G1 X97.128 Y89.793 E.01527
G1 X97.081 Y89.186 E.01137
G1 X96.966 Y88.486 E.01326
G1 X96.782 Y87.802 E.01325
G1 X96.53 Y87.139 E.01325
G1 X96.214 Y86.504 E.01325
G1 X95.837 Y85.903 E.01326
G1 X95.404 Y85.347 E.01318
G1 X94.934 Y84.852 E.01274
G1 X94.363 Y84.368 E.01399
G1 X93.777 Y83.956 E.01338
G1 X93.158 Y83.61 E.01325
G1 X92.508 Y83.327 E.01325
G1 X91.833 Y83.11 E.01325
G1 X91.14 Y82.962 E.01325
G1 X90.435 Y82.883 E.01324
G1 X89.769 Y82.875 E.01244
G1 X89.024 Y82.936 E.01397
G1 X88.354 Y83.062 E.01274
G1 X87.859 Y83.211 E.00965
G1 X87.267 Y83.42 E.01174
G1 X86.626 Y83.724 E.01325
G1 X86.02 Y84.091 E.01324
G1 X85.452 Y84.515 E.01324
G1 X84.93 Y84.994 E.01324
G1 X84.458 Y85.523 E.01324
G1 X84.04 Y86.096 E.01324
G1 X83.682 Y86.707 E.01324
G1 X83.386 Y87.351 E.01324
G1 X83.156 Y88.021 E.01325
G1 X82.994 Y88.711 E.01324
G1 X82.9 Y89.414 E.01324
G1 X82.884 Y90.069 E.01224
; CHANGE_LAYER
; Z_HEIGHT: 0.68
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F4800
G1 X82.9 Y89.414 E-.09337
G1 X82.994 Y88.711 E-.101
G1 X83.139 Y88.092 E-.09062
; WIPE_END
G1 E-.015 F1800
; layer num/total_layer_count: 5/33
; update layer progress
M73 L5
M991 S0 P4 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z.96 I-.422 J1.142 P1  F18000
G1 X94.777 Y92.392 Z.96
G1 Z.68
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F3600
M204 S6000
G1 X94.756 Y92.439 E.00103
G1 X94.49 Y92.9 E.01071
G1 X94.184 Y93.325 E.01052
G1 X93.975 Y93.571 E.00649
G1 X93.634 Y93.919 E.00979
G1 X93.227 Y94.261 E.01069
G1 X92.787 Y94.561 E.01071
G1 X92.319 Y94.816 E.01072
G1 X91.828 Y95.022 E.01071
G1 X91.319 Y95.18 E.01072
G1 X90.796 Y95.285 E.01071
G1 X90.266 Y95.338 E.01071
G1 X89.733 Y95.338 E.01071
G1 X89.203 Y95.285 E.01071
G1 X88.681 Y95.18 E.01071
G1 X88.172 Y95.022 E.01072
G1 X87.681 Y94.815 E.01071
G1 X87.213 Y94.561 E.01071
G1 X86.773 Y94.261 E.01072
G1 X86.364 Y93.918 E.01072
G1 X85.992 Y93.537 E.01071
G1 X85.66 Y93.12 E.01072
G1 X85.371 Y92.672 E.01071
G1 X85.128 Y92.198 E.01072
G1 X84.933 Y91.702 E.01071
G1 X84.789 Y91.189 E.01071
G1 X84.697 Y90.665 E.01072
G1 X84.657 Y90.133 E.01071
G1 X84.67 Y89.601 E.01071
G1 X84.736 Y89.072 E.01071
G1 X84.855 Y88.552 E.01072
G1 X85.024 Y88.047 E.01071
G1 X85.244 Y87.562 E.01072
G1 X85.51 Y87.1 E.01072
G1 X85.821 Y86.668 E.01071
G1 X86.174 Y86.268 E.01072
G1 X86.564 Y85.906 E.01071
G1 X86.989 Y85.584 E.01072
G1 X87.444 Y85.306 E.01071
G1 X87.924 Y85.075 E.01071
G1 X88.425 Y84.893 E.01072
G1 X88.941 Y84.761 E.01071
G1 X89.458 Y84.683 E.01052
G1 X89.78 Y84.661 E.0065
G1 X90.267 Y84.662 E.00979
G1 X90.796 Y84.715 E.01069
G1 X91.319 Y84.82 E.01071
G1 X91.828 Y84.978 E.01072
G1 X92.319 Y85.185 E.01071
G1 X92.787 Y85.439 E.01071
G1 X93.227 Y85.739 E.01071
G1 X93.635 Y86.082 E.01072
G1 X94.007 Y86.463 E.01071
G1 X94.339 Y86.88 E.01072
G1 X94.628 Y87.327 E.01071
G1 X94.872 Y87.802 E.01072
G1 X95.066 Y88.298 E.01071
G1 X95.211 Y88.81 E.01071
G1 X95.303 Y89.335 E.01072
G1 X95.343 Y89.867 E.01071
G1 X95.33 Y90.399 E.01071
G1 X95.263 Y90.928 E.01071
G1 X95.145 Y91.448 E.01072
G1 X94.975 Y91.953 E.01071
G1 X94.802 Y92.337 E.00849
M204 S10000
G1 X94.39 Y92.218 F18000
G1 F3600
M204 S6000
G1 X94.378 Y92.245 E.0006
G1 X94.133 Y92.669 E.00986
G1 X93.85 Y93.063 E.00975
G1 X93.661 Y93.285 E.00585
G1 X93.346 Y93.607 E.00907
G1 X92.971 Y93.922 E.00985
G1 X92.565 Y94.198 E.00986
G1 X92.134 Y94.433 E.00986
G1 X91.683 Y94.623 E.00986
G1 X91.214 Y94.768 E.00987
G1 X90.733 Y94.865 E.00986
G1 X90.245 Y94.914 E.00986
G1 X89.755 Y94.914 E.00986
G1 X89.267 Y94.865 E.00986
G1 X88.786 Y94.768 E.00986
G1 X88.317 Y94.623 E.00987
G1 X87.865 Y94.433 E.00986
G1 X87.434 Y94.198 E.00986
G1 X87.029 Y93.922 E.00986
G1 X86.653 Y93.607 E.00986
G1 X86.311 Y93.256 E.00986
G1 X86.005 Y92.872 E.00987
G1 X85.739 Y92.46 E.00986
G1 X85.515 Y92.023 E.00987
G1 X85.336 Y91.567 E.00986
G1 X85.203 Y91.095 E.00986
G1 X85.118 Y90.612 E.00986
G1 X85.081 Y90.123 E.00986
G1 X85.094 Y89.632 E.00986
G1 X85.155 Y89.146 E.00986
G1 X85.264 Y88.667 E.00987
G1 X85.42 Y88.203 E.00986
G1 X85.622 Y87.755 E.00986
G1 X85.867 Y87.331 E.00987
G1 X86.153 Y86.932 E.00986
G1 X86.478 Y86.565 E.00986
G1 X86.837 Y86.231 E.00986
G1 X87.228 Y85.935 E.00986
G1 X87.647 Y85.679 E.00986
G1 X88.089 Y85.466 E.00986
G1 X88.55 Y85.299 E.00986
G1 X89.025 Y85.178 E.00986
G1 X89.504 Y85.105 E.00975
G1 X89.795 Y85.085 E.00585
G1 X90.246 Y85.086 E.00907
G1 X90.733 Y85.135 E.00985
G1 X91.214 Y85.232 E.00986
G1 X91.683 Y85.377 E.00987
G1 X92.135 Y85.567 E.00986
G1 X92.565 Y85.802 E.00986
G1 X92.97 Y86.078 E.00986
G1 X93.346 Y86.393 E.00986
G1 X93.689 Y86.744 E.00986
G1 X93.995 Y87.128 E.00986
G1 X94.261 Y87.54 E.00986
G1 X94.485 Y87.977 E.00987
G1 X94.664 Y88.433 E.00986
G1 X94.796 Y88.905 E.00986
G1 X94.882 Y89.388 E.00986
G1 X94.918 Y89.877 E.00986
G1 X94.906 Y90.368 E.00986
G1 X94.845 Y90.854 E.00986
G1 X94.736 Y91.333 E.00987
G1 X94.58 Y91.798 E.00986
G1 X94.415 Y92.163 E.00806
M204 S250
G1 X94.017 Y92.049 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1800
M204 S5000
G1 X94.013 Y92.058 E.00017
G1 X93.789 Y92.447 E.0084
G1 X93.527 Y92.811 E.00837
G1 X93.067 Y93.306 E.01263
G1 X92.723 Y93.595 E.0084
G1 X92.352 Y93.849 E.0084
G1 X91.957 Y94.064 E.0084
G1 X91.543 Y94.238 E.0084
G1 X91.113 Y94.371 E.00841
G1 X90.672 Y94.46 E.0084
G1 X90.225 Y94.505 E.0084
G1 X89.775 Y94.505 E.0084
G1 X89.328 Y94.46 E.0084
G1 X88.887 Y94.371 E.0084
G1 X88.457 Y94.238 E.00841
G1 X88.043 Y94.064 E.0084
G1 X87.648 Y93.849 E.0084
G1 X87.277 Y93.595 E.0084
G1 X86.932 Y93.306 E.0084
G1 X86.618 Y92.984 E.0084
G1 X86.338 Y92.633 E.00841
G1 X86.094 Y92.255 E.0084
G1 X85.889 Y91.855 E.0084
G1 X85.724 Y91.436 E.0084
G1 X85.603 Y91.004 E.0084
G1 X85.525 Y90.561 E.0084
G1 X85.491 Y90.112 E.00841
G1 X85.502 Y89.663 E.0084
G1 X85.558 Y89.217 E.0084
G1 X85.658 Y88.778 E.00841
G1 X85.801 Y88.352 E.0084
G1 X85.986 Y87.942 E.0084
G1 X86.211 Y87.553 E.0084
G1 X86.474 Y87.188 E.0084
G1 X86.771 Y86.851 E.0084
G1 X87.101 Y86.545 E.0084
G1 X87.459 Y86.273 E.0084
G1 X87.843 Y86.039 E.0084
G1 X88.248 Y85.844 E.0084
G1 X88.67 Y85.69 E.0084
G1 X89.106 Y85.579 E.0084
G1 X89.549 Y85.512 E.00836
G1 X90.225 Y85.495 E.01264
G1 X90.672 Y85.54 E.0084
G1 X91.113 Y85.629 E.0084
G1 X91.543 Y85.762 E.00841
G1 X91.957 Y85.936 E.0084
G1 X92.352 Y86.151 E.0084
G1 X92.723 Y86.405 E.0084
G1 X93.068 Y86.694 E.0084
G1 X93.381 Y87.016 E.0084
G1 X93.662 Y87.367 E.0084
G1 X93.906 Y87.745 E.0084
G1 X94.111 Y88.145 E.0084
G1 X94.275 Y88.564 E.0084
G1 X94.397 Y88.996 E.0084
G1 X94.475 Y89.439 E.0084
G1 X94.509 Y89.888 E.0084
G1 X94.497 Y90.337 E.0084
G1 X94.442 Y90.783 E.0084
G1 X94.341 Y91.222 E.00841
G1 X94.198 Y91.648 E.0084
G1 X94.042 Y91.995 E.00711
; WIPE_START
M204 S6000
G1 X94.013 Y92.058 E-.00988
G1 X93.789 Y92.447 E-.06404
G1 X93.527 Y92.811 E-.06382
G1 X93.067 Y93.306 E-.09635
G1 X92.794 Y93.536 E-.05091
; WIPE_END
G1 E-.015
M204 S10000
G1 X88.516 Y87.215 Z1.08 F18000
G1 X86.144 Y83.711 Z1.08
G1 Z.68
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F3600
M204 S6000
G1 X86.769 Y83.368 E.01434
G1 X87.434 Y83.083 E.01455
G1 X88.219 Y82.841 E.01652
G1 X88.929 Y82.701 E.01455
G1 X89.652 Y82.631 E.01461
G1 X90.378 Y82.632 E.0146
G1 X91.101 Y82.705 E.01461
G1 X91.814 Y82.849 E.01461
G1 X92.508 Y83.062 E.01461
G1 X93.179 Y83.342 E.01461
G1 X93.818 Y83.687 E.0146
G1 X94.418 Y84.092 E.01456
G1 X95.047 Y84.62 E.01651
G1 X95.55 Y85.14 E.01454
G1 X96.001 Y85.709 E.01461
G1 X96.394 Y86.32 E.01461
G1 X96.725 Y86.967 E.01461
G1 X96.991 Y87.643 E.01461
G1 X97.189 Y88.343 E.01462
G1 X97.317 Y89.058 E.01461
G1 X97.374 Y89.783 E.01462
G1 X97.36 Y90.506 E.01455
G1 X97.258 Y91.322 E.01653
G1 X97.093 Y92.027 E.01456
G1 X96.86 Y92.716 E.01462
G1 X96.559 Y93.378 E.01462
G1 X96.195 Y94.007 E.01461
G1 X95.77 Y94.597 E.01462
G1 X95.29 Y95.143 E.01462
G1 X94.758 Y95.638 E.01462
G1 X94.18 Y96.079 E.01462
G1 X93.564 Y96.459 E.01455
G1 X92.825 Y96.815 E.0165
G1 X92.144 Y97.059 E.01454
G1 X91.44 Y97.236 E.01459
G1 X90.723 Y97.342 E.01458
G1 X89.999 Y97.378 E.01459
G1 X89.338 Y97.347 E.01329
G1 X88.526 Y97.229 E.01651
G1 X87.826 Y97.05 E.01452
G1 X87.143 Y96.802 E.01462
G1 X86.574 Y96.531 E.01268
G1 X85.863 Y96.109 E.01661
G1 X85.361 Y95.733 E.01261
G1 X84.637 Y95.062 E.01986
G1 X84.211 Y94.573 E.01303
G1 X83.789 Y93.981 E.01462
G1 X83.427 Y93.35 E.01463
G1 X83.129 Y92.687 E.01462
G1 X82.898 Y91.998 E.01461
G1 X82.735 Y91.288 E.01463
G1 X82.644 Y90.571 E.01454
G1 X82.627 Y89.749 E.01653
G1 X82.687 Y89.028 E.01456
G1 X82.818 Y88.313 E.01462
G1 X83.019 Y87.614 E.01461
G1 X83.287 Y86.939 E.01461
G1 X83.621 Y86.293 E.01462
G1 X84.016 Y85.684 E.01461
G1 X84.47 Y85.116 E.01461
G1 X84.977 Y84.596 E.01461
G1 X85.533 Y84.128 E.01462
G1 X86.094 Y83.744 E.01367
M204 S10000
G1 X85.94 Y83.339 F18000
G1 F3600
M204 S6000
G1 X86.583 Y82.986 E.01476
G1 X87.288 Y82.684 E.01541
G1 X88.115 Y82.429 E.0174
G1 X88.867 Y82.28 E.01541
G1 X89.632 Y82.206 E.01545
G1 X90.4 Y82.208 E.01544
G1 X91.165 Y82.285 E.01545
G1 X91.918 Y82.437 E.01545
G1 X92.653 Y82.662 E.01545
G1 X93.362 Y82.959 E.01545
G1 X94.037 Y83.324 E.01544
G1 X94.673 Y83.753 E.01542
G1 X95.337 Y84.309 E.0174
G1 X95.87 Y84.86 E.01541
G1 X96.347 Y85.462 E.01545
G1 X96.763 Y86.108 E.01545
G1 X97.113 Y86.792 E.01545
G1 X97.394 Y87.508 E.01545
G1 X97.603 Y88.248 E.01546
G1 X97.738 Y89.004 E.01545
G1 X97.799 Y89.77 E.01546
G1 X97.783 Y90.537 E.01542
G1 X97.676 Y91.397 E.01742
G1 X97.502 Y92.144 E.01543
G1 X97.254 Y92.872 E.01546
G1 X96.937 Y93.572 E.01546
G1 X96.551 Y94.237 E.01546
G1 X96.103 Y94.862 E.01546
G1 X95.594 Y95.439 E.01546
G1 X95.032 Y95.963 E.01546
G1 X94.42 Y96.429 E.01546
G1 X93.768 Y96.832 E.01542
G1 X92.989 Y97.207 E.01739
G1 X92.268 Y97.465 E.0154
G1 X91.523 Y97.652 E.01543
G1 X90.765 Y97.765 E.01542
G1 X89.999 Y97.803 E.01542
G1 X89.298 Y97.77 E.01411
G1 X88.442 Y97.645 E.01738
G1 X87.701 Y97.456 E.01538
G1 X86.979 Y97.194 E.01546
G1 X86.373 Y96.906 E.01348
G1 X85.627 Y96.462 E.01746
G1 X85.092 Y96.061 E.01344
G1 X84.51 Y95.54 E.01571
G1 X84.325 Y95.35 E.00534
G1 X83.877 Y94.836 E.01369
G1 X83.431 Y94.21 E.01546
G1 X83.048 Y93.543 E.01547
G1 X82.733 Y92.841 E.01546
G1 X82.489 Y92.113 E.01546
G1 X82.317 Y91.363 E.01547
G1 X82.221 Y90.602 E.01541
G1 X82.203 Y89.736 E.01742
G1 X82.266 Y88.972 E.01542
G1 X82.405 Y88.216 E.01546
G1 X82.617 Y87.477 E.01545
G1 X82.901 Y86.763 E.01545
G1 X83.254 Y86.08 E.01546
G1 X83.672 Y85.436 E.01545
G1 X84.151 Y84.835 E.01545
G1 X84.688 Y84.285 E.01545
G1 X85.276 Y83.79 E.01546
G1 X85.889 Y83.37 E.01494
M204 S250
G1 X85.743 Y82.98 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1800
M204 S5000
G1 X86.404 Y82.617 E.01409
G1 X87.147 Y82.3 E.0151
G1 X88.015 Y82.032 E.01697
G1 X88.807 Y81.875 E.0151
G1 X89.613 Y81.797 E.01512
G1 X90.421 Y81.799 E.01511
G1 X91.226 Y81.88 E.01512
G1 X92.019 Y82.04 E.01511
G1 X92.792 Y82.277 E.01511
G1 X93.538 Y82.589 E.01511
G1 X94.25 Y82.973 E.01511
G1 X94.92 Y83.425 E.01511
G1 X95.616 Y84.009 E.01698
G1 X96.178 Y84.59 E.0151
G1 X96.68 Y85.224 E.01511
M73 P61 R5
G1 X97.118 Y85.904 E.01511
G1 X97.486 Y86.624 E.01511
G1 X97.782 Y87.377 E.01512
G1 X98.002 Y88.156 E.01512
G1 X98.145 Y88.952 E.01511
G1 X98.208 Y89.758 E.01512
G1 X98.192 Y90.567 E.01511
G1 X98.079 Y91.469 E.01699
G1 X97.896 Y92.256 E.01511
G1 X97.635 Y93.023 E.01512
G1 X97.301 Y93.76 E.01512
G1 X96.895 Y94.46 E.01512
G1 X96.423 Y95.117 E.01512
G1 X95.888 Y95.724 E.01512
G1 X95.296 Y96.276 E.01512
G1 X94.653 Y96.767 E.01512
G1 X93.965 Y97.191 E.0151
G1 X93.147 Y97.585 E.01696
G1 X92.387 Y97.858 E.01509
G1 X91.603 Y98.054 E.01509
G1 X90.805 Y98.173 E.01508
G1 X89.999 Y98.212 E.01507
G1 X89.259 Y98.178 E.01385
G1 X88.362 Y98.047 E.01693
G1 X87.58 Y97.848 E.01508
G1 X86.82 Y97.572 E.01511
G1 X86.18 Y97.267 E.01325
G1 X85.399 Y96.802 E.01699
G1 X84.832 Y96.378 E.01323
G1 X84.227 Y95.835 E.01519
G1 X84.024 Y95.627 E.00543
G1 X83.556 Y95.09 E.01331
G1 X83.086 Y94.431 E.01512
G1 X82.683 Y93.729 E.01513
G1 X82.352 Y92.991 E.01512
G1 X82.094 Y92.224 E.01512
G1 X81.914 Y91.434 E.01513
G1 X81.812 Y90.632 E.01511
G1 X81.793 Y89.724 E.01698
G1 X81.86 Y88.918 E.0151
G1 X82.006 Y88.122 E.01512
G1 X82.229 Y87.345 E.01511
G1 X82.528 Y86.593 E.01511
G1 X82.899 Y85.874 E.01512
G1 X83.339 Y85.196 E.01511
G1 X83.844 Y84.564 E.01511
G1 X84.409 Y83.985 E.01511
G1 X85.028 Y83.464 E.01512
G1 X85.691 Y83.01 E.01501
; WIPE_START
M204 S6000
G1 X86.404 Y82.617 E-.116
G1 X87.147 Y82.3 E-.11515
G1 X87.508 Y82.188 E-.05384
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
G1 X0 Y90.0001 ; move to safe pos
G1 X-13.0 F3000 ; move to safe pos
M400
M1004 S5 P1  ; external shutter
M400 P300
M971 S11 C11 O0
G92 E0
G1 X0 F18000
M623

; SKIPTYPE: head_wrap_detect
M622.1 S1
M1002 judge_flag g39_3rd_layer_detect_flag
M622 J1
    ; enable nozzle clog detect at 3rd layer
    


    M622.1 S1
    M1002 judge_flag g39_detection_flag
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




G1 X85.274 Y95.095
G1 Z.68
G1 E.3 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.419992
G1 F4800
M204 S6000
G1 X85.649 Y95.437 E.00948
G1 X86.091 Y95.768 E.01032
G1 X86.766 Y96.17 E.01468
G1 X87.301 Y96.424 E.01106
G1 X87.947 Y96.659 E.01284
G1 X88.606 Y96.827 E.01271
G1 X89.377 Y96.939 E.01457
G1 X89.998 Y96.968 E.01161
G1 X90.683 Y96.934 E.01281
G1 X91.36 Y96.834 E.01279
G1 X92.025 Y96.667 E.0128
G1 X92.667 Y96.437 E.01274
G1 X93.367 Y96.1 E.01453
G1 X93.948 Y95.741 E.01275
G1 X94.494 Y95.325 E.01282
G1 X94.996 Y94.857 E.01283
G1 X95.45 Y94.342 E.01283
G1 X95.851 Y93.784 E.01284
G1 X96.195 Y93.19 E.01283
G1 X96.478 Y92.565 E.01283
G1 X96.699 Y91.915 E.01283
G1 X96.854 Y91.25 E.01275
G1 X96.951 Y90.477 E.01456
G1 X96.964 Y89.825 E.01219
G1 X96.918 Y89.202 E.01168
G1 X96.804 Y88.517 E.01297
G1 X96.624 Y87.848 E.01295
G1 X96.377 Y87.2 E.01296
G1 X96.067 Y86.579 E.01297
G1 X95.697 Y85.992 E.01296
G1 X95.27 Y85.445 E.01297
G1 X94.791 Y84.944 E.01296
G1 X94.259 Y84.493 E.01303
G1 X93.688 Y84.093 E.01302
G1 X93.082 Y83.755 E.01296
G1 X92.446 Y83.48 E.01296
G1 X91.785 Y83.268 E.01296
G1 X91.107 Y83.124 E.01296
G1 X90.419 Y83.047 E.01294
G1 X89.776 Y83.04 E.01201
G1 X89.018 Y83.103 E.0142
G1 X88.351 Y83.232 E.01271
G1 X87.606 Y83.459 E.01455
G1 X86.976 Y83.724 E.01277
G1 X86.373 Y84.052 E.01283
G1 X85.806 Y84.437 E.01281
G1 X85.279 Y84.877 E.01283
G1 X84.798 Y85.366 E.01282
G1 X84.367 Y85.9 E.01282
G1 X83.992 Y86.474 E.01282
G1 X83.674 Y87.082 E.01283
G1 X83.418 Y87.719 E.01282
G1 X83.225 Y88.377 E.01281
G1 X83.099 Y89.052 E.01283
G1 X83.04 Y89.731 E.01272
G1 X83.052 Y90.509 E.01454
G1 X83.135 Y91.187 E.01276
G1 X83.285 Y91.858 E.01284
G1 X83.501 Y92.509 E.01282
G1 X83.779 Y93.136 E.01283
G1 X84.118 Y93.734 E.01283
G1 X84.515 Y94.295 E.01284
G1 X84.909 Y94.752 E.01128
G1 X85.231 Y95.054 E.00824
; WIPE_START
G1 X84.909 Y94.752 E-.06283
G1 X84.515 Y94.295 E-.086
G1 X84.118 Y93.734 E-.09793
G1 X83.986 Y93.5 E-.03824
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X91.618 Y93.561 Z1.08 F18000
G1 X94.48 Y93.584 Z1.08
G1 Z.68
G1 E.3 F1800
G1 F4800
M204 S6000
G1 X94.123 Y94.005 E.01032
G1 X93.708 Y94.391 E.01059
G1 X93.259 Y94.734 E.01056
G1 X92.783 Y95.029 E.01046
G1 X92.194 Y95.312 E.0122
G1 X91.667 Y95.5 E.01045
G1 X91.12 Y95.637 E.01054
G1 X90.562 Y95.72 E.01054
G1 X89.997 Y95.747 E.01057
G1 X89.496 Y95.726 E.00937
G1 X88.846 Y95.63 E.01227
G1 X88.307 Y95.492 E.01041
G1 X87.774 Y95.299 E.0106
G1 X87.008 Y94.915 E.016
G1 X86.533 Y94.593 E.01072
G1 X86.093 Y94.225 E.01072
G1 X85.692 Y93.815 E.01072
G1 X85.333 Y93.367 E.01073
G1 X85.022 Y92.886 E.01071
G1 X84.759 Y92.375 E.01072
G1 X84.549 Y91.842 E.01072
G1 X84.392 Y91.29 E.01071
G1 X84.292 Y90.725 E.01072
G1 X84.248 Y90.153 E.01072
G1 X84.261 Y89.58 E.01072
G1 X84.331 Y89.011 E.01072
G1 X84.458 Y88.451 E.01072
G1 X84.64 Y87.907 E.01071
G1 X84.875 Y87.384 E.01072
G1 X85.161 Y86.886 E.01072
G1 X85.495 Y86.42 E.01071
G1 X85.874 Y85.989 E.01072
G1 X86.294 Y85.598 E.01072
G1 X86.75 Y85.251 E.01072
G1 X87.239 Y84.951 E.01072
G1 X87.756 Y84.702 E.01072
G1 X88.294 Y84.504 E.01072
G1 X88.85 Y84.362 E.01072
G1 X89.75 Y84.253 E.01694
G1 X90.278 Y84.253 E.00987
G1 X90.848 Y84.309 E.01069
G1 X91.41 Y84.421 E.01072
G1 X91.959 Y84.59 E.01072
G1 X92.488 Y84.812 E.01072
G1 X92.992 Y85.085 E.01072
G1 X93.464 Y85.406 E.01067
G1 X93.906 Y85.775 E.01077
G1 X94.308 Y86.185 E.01072
G1 X94.666 Y86.633 E.01072
G1 X94.978 Y87.114 E.01071
G1 X95.241 Y87.625 E.01072
G1 X95.451 Y88.158 E.01072
G1 X95.607 Y88.71 E.01071
G1 X95.708 Y89.275 E.01072
G1 X95.752 Y89.847 E.01072
G1 X95.739 Y90.418 E.01068
G1 X95.668 Y90.989 E.01076
G1 X95.541 Y91.549 E.01072
G1 X95.36 Y92.093 E.01072
G1 X95.125 Y92.616 E.01072
G1 X94.839 Y93.114 E.01071
G1 X94.516 Y93.536 E.00993
M204 S10000
G1 X94.802 Y93.831 F18000
; LINE_WIDTH: 0.434436
G1 F4800
M204 S6000
G1 X94.411 Y94.287 E.01164
G1 X93.967 Y94.7 E.01175
G1 X93.486 Y95.068 E.01173
G1 X92.976 Y95.383 E.01162
G1 X92.351 Y95.684 E.01343
G1 X91.786 Y95.886 E.01161
G1 X91.2 Y96.033 E.01171
G1 X90.603 Y96.121 E.0117
G1 X89.997 Y96.151 E.01174
G1 X89.456 Y96.127 E.01049
G1 X88.766 Y96.026 E.0135
G1 X88.188 Y95.878 E.01157
G1 X87.617 Y95.671 E.01177
G1 X87.152 Y95.452 E.00996
G1 X86.547 Y95.09 E.01365
G1 X85.838 Y94.529 E.01751
G1 X85.406 Y94.094 E.01188
G1 X85.021 Y93.616 E.01189
G1 X84.686 Y93.103 E.01187
G1 X84.403 Y92.558 E.01189
G1 X84.176 Y91.988 E.01188
G1 X84.007 Y91.398 E.01188
G1 X83.898 Y90.795 E.01189
G1 X83.85 Y90.183 E.01188
G1 X83.861 Y89.57 E.01188
G1 X83.934 Y88.961 E.01188
G1 X84.068 Y88.362 E.01189
G1 X84.261 Y87.78 E.01188
G1 X84.51 Y87.219 E.01189
G1 X84.815 Y86.686 E.01189
G1 X85.17 Y86.186 E.01188
G1 X85.574 Y85.724 E.01189
G1 X86.022 Y85.305 E.01188
G1 X86.509 Y84.932 E.01189
G1 X87.031 Y84.61 E.01188
G1 X87.582 Y84.341 E.01188
G1 X88.158 Y84.129 E.01188
G1 X88.751 Y83.974 E.01188
G1 X89.702 Y83.854 E.01857
G1 X90.279 Y83.851 E.01117
G1 X90.888 Y83.909 E.01184
G1 X91.49 Y84.028 E.01188
G1 X92.077 Y84.206 E.01189
G1 X92.644 Y84.441 E.01188
G1 X93.184 Y84.732 E.01189
G1 X93.69 Y85.074 E.01183
G1 X94.164 Y85.468 E.01194
G1 X94.595 Y85.905 E.01188
G1 X94.98 Y86.383 E.01189
G1 X95.315 Y86.897 E.01188
G1 X95.598 Y87.441 E.01189
G1 X95.825 Y88.011 E.01188
G1 X95.994 Y88.601 E.01188
G1 X96.104 Y89.205 E.01189
G1 X96.153 Y89.817 E.01188
G1 X96.14 Y90.428 E.01185
G1 X96.066 Y91.039 E.01193
G1 X95.933 Y91.638 E.01189
G1 X95.74 Y92.221 E.01189
G1 X95.491 Y92.782 E.01188
G1 X95.186 Y93.314 E.01188
G1 X94.838 Y93.783 E.01131
M204 S10000
G1 X95.125 Y94.096 F18000
; LINE_WIDTH: 0.437056
G1 F4800
M204 S6000
G1 X95.472 Y93.623 E.01143
G1 X95.818 Y93.04 E.01323
G1 X96.091 Y92.445 E.01275
G1 X96.305 Y91.827 E.01275
G1 X96.456 Y91.19 E.01276
G1 X96.539 Y90.54 E.01278
G1 X96.562 Y89.817 E.01411
G1 X96.518 Y89.233 E.01141
G1 X96.409 Y88.588 E.01276
G1 X96.237 Y87.957 E.01274
G1 X96.003 Y87.346 E.01275
G1 X95.709 Y86.762 E.01276
G1 X95.359 Y86.21 E.01274
G1 X94.955 Y85.695 E.01276
G1 X94.502 Y85.223 E.01275
G1 X94.001 Y84.8 E.01278
G1 X93.464 Y84.426 E.01277
G1 X92.892 Y84.109 E.01275
G1 X92.291 Y83.85 E.01275
G1 X91.668 Y83.652 E.01275
G1 X91.028 Y83.517 E.01275
G1 X90.378 Y83.447 E.01273
G1 X89.775 Y83.442 E.01176
G1 X89.058 Y83.507 E.01405
G1 X88.429 Y83.628 E.01248
G1 X87.725 Y83.844 E.01435
G1 X87.135 Y84.095 E.01251
G1 X86.567 Y84.406 E.01261
G1 X86.034 Y84.77 E.01259
G1 X85.539 Y85.186 E.01261
G1 X85.087 Y85.648 E.0126
G1 X84.683 Y86.152 E.0126
G1 X84.33 Y86.694 E.0126
G1 X84.032 Y87.268 E.01261
G1 X83.792 Y87.868 E.0126
G1 X83.613 Y88.489 E.01259
G1 X83.495 Y89.125 E.01262
G1 X83.441 Y89.764 E.0125
G1 X83.456 Y90.5 E.01436
G1 X83.535 Y91.136 E.01249
G1 X83.679 Y91.768 E.01262
G1 X83.883 Y92.381 E.0126
G1 X84.147 Y92.971 E.01261
G1 X84.468 Y93.533 E.01261
G1 X84.843 Y94.061 E.01262
G1 X85.213 Y94.487 E.011
G1 X85.874 Y95.101 E.01758
G1 X86.307 Y95.426 E.01055
G1 X86.948 Y95.809 E.01456
G1 X87.448 Y96.047 E.01079
G1 X88.057 Y96.269 E.01263
G1 X88.675 Y96.428 E.01244
G1 X89.406 Y96.536 E.01441
G1 X89.988 Y96.564 E.01135
G1 X90.633 Y96.533 E.0126
G1 X91.271 Y96.439 E.01257
G1 X91.897 Y96.283 E.01258
G1 X92.5 Y96.068 E.01248
G1 X93.164 Y95.75 E.01434
G1 X93.71 Y95.414 E.01251
G1 X94.225 Y95.023 E.0126
G1 X94.699 Y94.582 E.01261
G1 X95.085 Y94.141 E.01143
; CHANGE_LAYER
; Z_HEIGHT: 0.8
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F4800
G1 X94.699 Y94.582 E-.08354
G1 X94.225 Y95.023 E-.09219
G1 X93.71 Y95.414 E-.09211
G1 X93.608 Y95.477 E-.01717
; WIPE_END
G1 E-.015 F1800
; layer num/total_layer_count: 6/33
; update layer progress
M73 L6
M991 S0 P5 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z1.08 I1.138 J.431 P1  F18000
G1 X94.776 Y92.394 Z1.08
G1 Z.8
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F3600
M204 S6000
G1 X94.756 Y92.439 E.00098
G1 X94.49 Y92.9 E.01071
G1 X94.178 Y93.333 E.01072
G1 X93.826 Y93.732 E.01071
G1 X93.435 Y94.094 E.01072
G1 X93.011 Y94.416 E.01072
G1 X92.556 Y94.694 E.01071
G1 X92.064 Y94.931 E.01098
G1 X91.331 Y95.177 E.01554
G1 X90.796 Y95.285 E.01098
G1 X90.266 Y95.338 E.01071
G1 X89.733 Y95.338 E.01071
G1 X89.203 Y95.285 E.01071
G1 X88.681 Y95.18 E.01071
G1 X88.172 Y95.022 E.01072
G1 X87.681 Y94.815 E.01071
G1 X87.213 Y94.561 E.01071
G1 X86.773 Y94.261 E.01071
G1 X86.364 Y93.918 E.01072
G1 X85.992 Y93.537 E.01071
G1 X85.66 Y93.12 E.01072
G1 X85.371 Y92.673 E.01071
G1 X85.128 Y92.198 E.01072
G1 X84.933 Y91.702 E.01072
G1 X84.789 Y91.189 E.0107
G1 X84.697 Y90.665 E.01071
G1 X84.657 Y90.133 E.01071
G1 X84.67 Y89.601 E.01071
G1 X84.736 Y89.072 E.01071
G1 X84.855 Y88.552 E.01072
G1 X85.024 Y88.047 E.01071
G1 X85.244 Y87.562 E.01072
G1 X85.51 Y87.1 E.01071
G1 X85.821 Y86.668 E.01072
G1 X86.174 Y86.268 E.01071
G1 X86.564 Y85.906 E.01071
G1 X86.989 Y85.584 E.01072
G1 X87.444 Y85.306 E.01071
G1 X87.924 Y85.075 E.01071
G1 X88.424 Y84.893 E.01071
G1 X88.941 Y84.761 E.01072
G1 X89.459 Y84.683 E.01052
G1 X89.788 Y84.661 E.00664
G1 X90.267 Y84.662 E.00964
G1 X90.796 Y84.715 E.01069
G1 X91.319 Y84.82 E.01071
G1 X91.828 Y84.978 E.01072
G1 X92.319 Y85.185 E.01071
G1 X92.787 Y85.439 E.01071
G1 X93.227 Y85.739 E.01071
G1 X93.635 Y86.082 E.01071
G1 X94.007 Y86.463 E.01072
G1 X94.339 Y86.88 E.01071
G1 X94.628 Y87.328 E.01071
G1 X94.872 Y87.802 E.01072
G1 X95.066 Y88.298 E.01071
G1 X95.211 Y88.811 E.01071
G1 X95.303 Y89.335 E.01072
G1 X95.343 Y89.867 E.01071
G1 X95.33 Y90.399 E.01071
G1 X95.263 Y90.928 E.01071
G1 X95.145 Y91.448 E.01072
G1 X94.975 Y91.953 E.01071
G1 X94.801 Y92.339 E.00853
M204 S10000
G1 X94.389 Y92.22 F18000
G1 F3600
M204 S6000
G1 X94.378 Y92.245 E.00056
G1 X94.133 Y92.669 E.00986
G1 X93.846 Y93.068 E.00986
G1 X93.522 Y93.435 E.00986
G1 X93.162 Y93.769 E.00986
G1 X92.771 Y94.065 E.00986
G1 X92.353 Y94.321 E.00986
G1 X91.904 Y94.537 E.01002
G1 X91.221 Y94.766 E.01448
G1 X90.733 Y94.865 E.01002
G1 X90.245 Y94.914 E.00986
G1 X89.755 Y94.914 E.00986
G1 X89.267 Y94.865 E.00986
G1 X88.786 Y94.768 E.00986
G1 X88.317 Y94.623 E.00987
G1 X87.865 Y94.433 E.00986
G1 X87.434 Y94.198 E.00986
G1 X87.029 Y93.922 E.00986
G1 X86.653 Y93.607 E.00986
G1 X86.311 Y93.256 E.00986
G1 X86.005 Y92.872 E.00986
G1 X85.739 Y92.46 E.00986
G1 X85.515 Y92.023 E.00987
G1 X85.336 Y91.567 E.00986
G1 X85.203 Y91.095 E.00986
G1 X85.118 Y90.612 E.00986
G1 X85.081 Y90.123 E.00986
G1 X85.094 Y89.632 E.00986
G1 X85.155 Y89.146 E.00986
G1 X85.264 Y88.667 E.00987
G1 X85.42 Y88.203 E.00986
G1 X85.622 Y87.755 E.00986
G1 X85.867 Y87.331 E.00986
G1 X86.153 Y86.932 E.00987
G1 X86.478 Y86.565 E.00986
G1 X86.837 Y86.231 E.00986
G1 X87.228 Y85.935 E.00987
G1 X87.647 Y85.679 E.00986
G1 X88.089 Y85.466 E.00986
G1 X88.55 Y85.299 E.00986
G1 X89.025 Y85.178 E.00986
G1 X89.505 Y85.105 E.00975
G1 X89.802 Y85.085 E.00599
G1 X90.246 Y85.086 E.00893
G1 X90.733 Y85.135 E.00985
G1 X91.214 Y85.232 E.00986
G1 X91.683 Y85.377 E.00987
G1 X92.135 Y85.567 E.00986
G1 X92.565 Y85.802 E.00986
G1 X92.97 Y86.078 E.00986
G1 X93.346 Y86.393 E.00986
G1 X93.689 Y86.744 E.00986
G1 X93.995 Y87.128 E.00986
G1 X94.261 Y87.54 E.00986
G1 X94.484 Y87.977 E.00987
G1 X94.664 Y88.433 E.00986
G1 X94.796 Y88.905 E.00986
G1 X94.882 Y89.388 E.00986
G1 X94.918 Y89.877 E.00986
G1 X94.906 Y90.368 E.00986
G1 X94.845 Y90.854 E.00986
G1 X94.736 Y91.333 E.00987
G1 X94.58 Y91.798 E.00986
G1 X94.414 Y92.165 E.0081
M204 S250
G1 X94.016 Y92.051 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1800
M204 S5000
G1 X94.013 Y92.058 E.00013
G1 X93.788 Y92.447 E.0084
G1 X93.526 Y92.812 E.0084
G1 X93.229 Y93.149 E.0084
G1 X92.899 Y93.455 E.0084
G1 X92.54 Y93.727 E.0084
G1 X92.157 Y93.961 E.0084
G1 X91.749 Y94.157 E.00845
G1 X91.115 Y94.37 E.0125
G1 X90.672 Y94.46 E.00845
G1 X90.225 Y94.505 E.0084
G1 X89.775 Y94.505 E.0084
G1 X89.328 Y94.46 E.0084
G1 X88.887 Y94.371 E.0084
G1 X88.457 Y94.238 E.0084
G1 X88.043 Y94.064 E.0084
G1 X87.648 Y93.849 E.0084
G1 X87.277 Y93.595 E.0084
G1 X86.932 Y93.306 E.0084
G1 X86.618 Y92.984 E.0084
G1 X86.338 Y92.633 E.0084
G1 X86.094 Y92.255 E.0084
G1 X85.889 Y91.855 E.0084
G1 X85.724 Y91.436 E.0084
G1 X85.603 Y91.004 E.0084
G1 X85.525 Y90.561 E.0084
G1 X85.491 Y90.112 E.00841
G1 X85.502 Y89.663 E.0084
G1 X85.558 Y89.217 E.0084
G1 X85.658 Y88.778 E.00841
G1 X85.801 Y88.352 E.0084
G1 X85.986 Y87.942 E.0084
G1 X86.211 Y87.553 E.0084
G1 X86.474 Y87.188 E.00841
G1 X86.771 Y86.851 E.0084
G1 X87.101 Y86.545 E.0084
G1 X87.459 Y86.273 E.00841
G1 X87.843 Y86.039 E.0084
G1 X88.248 Y85.844 E.0084
G1 X88.67 Y85.69 E.0084
G1 X89.106 Y85.579 E.0084
G1 X89.549 Y85.512 E.00837
G1 X90.225 Y85.495 E.01263
G1 X90.672 Y85.54 E.0084
G1 X91.113 Y85.629 E.0084
G1 X91.542 Y85.762 E.0084
G1 X91.957 Y85.936 E.0084
G1 X92.352 Y86.151 E.0084
G1 X92.723 Y86.405 E.0084
G1 X93.067 Y86.694 E.0084
G1 X93.381 Y87.016 E.0084
G1 X93.662 Y87.367 E.0084
G1 X93.906 Y87.745 E.0084
G1 X94.111 Y88.145 E.0084
G1 X94.275 Y88.563 E.0084
G1 X94.397 Y88.996 E.0084
G1 X94.475 Y89.439 E.0084
G1 X94.509 Y89.888 E.0084
G1 X94.497 Y90.337 E.0084
G1 X94.442 Y90.783 E.0084
M73 P62 R5
G1 X94.341 Y91.222 E.00841
G1 X94.198 Y91.648 E.0084
G1 X94.041 Y91.997 E.00715
; WIPE_START
M204 S6000
G1 X94.013 Y92.058 E-.00957
G1 X93.788 Y92.447 E-.06407
G1 X93.526 Y92.812 E-.06407
G1 X93.229 Y93.149 E-.06406
G1 X92.899 Y93.455 E-.06406
G1 X92.792 Y93.536 E-.01917
; WIPE_END
G1 E-.015
M204 S10000
G1 X88.516 Y87.214 Z1.2 F18000
G1 X86.238 Y83.846 Z1.2
G1 Z.8
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F3600
M204 S6000
G1 X86.87 Y83.502 E.01446
G1 X87.532 Y83.223 E.01446
G1 X88.221 Y83.01 E.01449
G1 X88.925 Y82.868 E.01445
G1 X89.641 Y82.796 E.01445
G1 X90.36 Y82.796 E.01446
G1 X91.075 Y82.868 E.01446
G1 X91.779 Y83.01 E.01445
G1 X92.466 Y83.222 E.01445
G1 X93.129 Y83.501 E.01445
G1 X93.76 Y83.845 E.01446
G1 X94.354 Y84.25 E.01445
G1 X94.906 Y84.713 E.01449
G1 X95.408 Y85.228 E.01445
G1 X95.856 Y85.79 E.01446
G1 X96.246 Y86.394 E.01445
G1 X96.574 Y87.034 E.01445
G1 X96.837 Y87.703 E.01445
G1 X97.032 Y88.395 E.01446
G1 X97.156 Y89.102 E.01445
G1 X97.21 Y89.82 E.01446
G1 X97.192 Y90.54 E.01449
G1 X97.103 Y91.253 E.01445
G1 X96.943 Y91.954 E.01445
G1 X96.714 Y92.635 E.01446
G1 X96.418 Y93.291 E.01445
G1 X96.059 Y93.913 E.01446
G1 X95.639 Y94.497 E.01445
G1 X95.163 Y95.036 E.01445
G1 X94.636 Y95.525 E.01446
G1 X94.063 Y95.959 E.01446
G1 X93.45 Y96.334 E.01445
G1 X92.801 Y96.647 E.01449
G1 X92.125 Y96.892 E.01445
G1 X91.429 Y97.07 E.01446
G1 X90.718 Y97.177 E.01446
G1 X90 Y97.213 E.01445
G1 X89.283 Y97.177 E.01443
G1 X88.57 Y97.07 E.01449
G1 X87.874 Y96.892 E.01445
G1 X87.198 Y96.646 E.01446
G1 X86.551 Y96.335 E.01445
G1 X85.937 Y95.96 E.01445
G1 X85.364 Y95.526 E.01445
G1 X84.836 Y95.036 E.01449
G1 X84.361 Y94.498 E.01442
G1 X83.941 Y93.913 E.01449
G1 X83.581 Y93.29 E.01446
G1 X83.286 Y92.635 E.01446
G1 X83.057 Y91.955 E.01442
G1 X82.896 Y91.251 E.01453
G1 X82.807 Y90.539 E.01441
G1 X82.789 Y89.819 E.01449
G1 X82.843 Y89.104 E.01442
G1 X82.968 Y88.394 E.01449
G1 X83.163 Y87.702 E.01445
G1 X83.426 Y87.033 E.01445
G1 X83.754 Y86.393 E.01445
G1 X84.144 Y85.789 E.01446
G1 X84.592 Y85.227 E.01446
G1 X85.094 Y84.713 E.01445
G1 X85.645 Y84.251 E.01446
G1 X86.189 Y83.88 E.01324
M204 S10000
G1 X86.018 Y83.482 F18000
G1 F3600
M204 S6000
G1 X86.685 Y83.119 E.01527
G1 X87.387 Y82.823 E.01531
G1 X88.116 Y82.598 E.01534
G1 X88.862 Y82.448 E.01531
G1 X89.62 Y82.372 E.01531
G1 X90.381 Y82.372 E.01531
G1 X91.138 Y82.448 E.01531
G1 X91.884 Y82.599 E.0153
G1 X92.612 Y82.823 E.01531
G1 X93.313 Y83.119 E.01531
G1 X93.982 Y83.483 E.01531
G1 X94.611 Y83.911 E.0153
G1 X95.195 Y84.402 E.01535
G1 X95.727 Y84.947 E.0153
G1 X96.201 Y85.542 E.01531
G1 X96.614 Y86.181 E.0153
G1 X96.961 Y86.859 E.01531
G1 X97.239 Y87.567 E.0153
G1 X97.446 Y88.3 E.01532
G1 X97.578 Y89.05 E.0153
G1 X97.635 Y89.809 E.01531
G1 X97.616 Y90.572 E.01534
G1 X97.521 Y91.327 E.0153
G1 X97.352 Y92.069 E.01531
G1 X97.109 Y92.791 E.01531
G1 X96.796 Y93.484 E.01531
G1 X96.415 Y94.144 E.01531
G1 X95.971 Y94.762 E.01531
G1 X95.467 Y95.333 E.01531
G1 X94.909 Y95.85 E.0153
G1 X94.303 Y96.31 E.01531
G1 X93.653 Y96.707 E.0153
G1 X92.966 Y97.038 E.01535
G1 X92.25 Y97.298 E.0153
G1 X91.513 Y97.486 E.01531
G1 X90.76 Y97.6 E.01531
G1 X90 Y97.638 E.0153
G1 X89.241 Y97.6 E.01528
G1 X88.486 Y97.486 E.01534
G1 X87.749 Y97.298 E.0153
G1 X87.033 Y97.038 E.01531
G1 X86.347 Y96.708 E.01531
G1 X85.698 Y96.311 E.0153
G1 X85.091 Y95.851 E.01531
G1 X84.532 Y95.332 E.01534
G1 X84.029 Y94.763 E.01527
G1 X83.584 Y94.143 E.01534
G1 X83.203 Y93.484 E.01531
G1 X82.89 Y92.79 E.0153
G1 X82.648 Y92.07 E.01527
G1 X82.478 Y91.324 E.01538
G1 X82.384 Y90.571 E.01527
G1 X82.365 Y89.808 E.01534
G1 X82.422 Y89.051 E.01527
G1 X82.554 Y88.3 E.01534
G1 X82.76 Y87.567 E.0153
G1 X83.038 Y86.858 E.0153
G1 X83.386 Y86.181 E.01531
G1 X83.799 Y85.541 E.01531
G1 X84.273 Y84.946 E.01531
G1 X84.805 Y84.401 E.0153
G1 X85.388 Y83.912 E.01531
G1 X85.969 Y83.516 E.01413
M204 S250
G1 X85.823 Y83.123 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1800
M204 S5000
G1 X86.508 Y82.75 E.01457
G1 X87.247 Y82.438 E.01499
G1 X88.015 Y82.201 E.01502
G1 X88.801 Y82.043 E.01499
G1 X89.599 Y81.963 E.01499
G1 X90.401 Y81.963 E.01499
G1 X91.199 Y82.043 E.01499
G1 X91.985 Y82.202 E.01498
G1 X92.752 Y82.438 E.01499
G1 X93.491 Y82.749 E.01499
G1 X94.195 Y83.133 E.01499
G1 X94.858 Y83.585 E.01498
G1 X95.474 Y84.102 E.01503
G1 X96.034 Y84.676 E.01498
G1 X96.534 Y85.303 E.01499
G1 X96.969 Y85.977 E.01498
G1 X97.335 Y86.69 E.01499
G1 X97.628 Y87.437 E.01499
G1 X97.845 Y88.209 E.01499
G1 X97.985 Y88.999 E.01498
G1 X98.045 Y89.799 E.01499
G1 X98.024 Y90.602 E.01502
G1 X97.925 Y91.398 E.01498
G1 X97.746 Y92.18 E.01499
G1 X97.491 Y92.94 E.01499
G1 X97.161 Y93.671 E.01499
G1 X96.76 Y94.366 E.01499
G1 X96.291 Y95.017 E.01499
M73 P62 R4
G1 X95.761 Y95.619 E.01499
G1 X95.173 Y96.164 E.01499
G1 X94.533 Y96.649 E.01499
G1 X93.849 Y97.067 E.01499
G1 X93.125 Y97.416 E.01502
G1 X92.371 Y97.69 E.01499
G1 X91.594 Y97.888 E.01499
G1 X90.801 Y98.007 E.01499
G1 X90 Y98.047 E.01498
G1 X89.2 Y98.007 E.01497
G1 X88.405 Y97.888 E.01502
G1 X87.628 Y97.69 E.01498
G1 X86.874 Y97.415 E.01499
G1 X86.151 Y97.067 E.01499
G1 X85.467 Y96.649 E.01498
G1 X84.828 Y96.165 E.01499
G1 X84.239 Y95.618 E.01502
G1 X83.709 Y95.018 E.01495
G1 X83.24 Y94.366 E.01502
G1 X82.839 Y93.671 E.01499
G1 X82.509 Y92.94 E.01499
G1 X82.254 Y92.181 E.01495
G1 X82.075 Y91.396 E.01506
G1 X81.975 Y90.602 E.01495
G1 X81.955 Y89.798 E.01502
G1 X82.015 Y89 E.01495
G1 X82.155 Y88.208 E.01502
G1 X82.372 Y87.436 E.01499
G1 X82.665 Y86.69 E.01498
G1 X83.031 Y85.976 E.01499
G1 X83.466 Y85.302 E.01499
G1 X83.966 Y84.675 E.01499
G1 X84.526 Y84.101 E.01499
G1 X85.141 Y83.585 E.01499
G1 X85.772 Y83.155 E.01428
; WIPE_START
M204 S6000
G1 X86.508 Y82.75 E-.11965
G1 X87.247 Y82.438 E-.11431
G1 X87.589 Y82.333 E-.05103
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
G1 X0 Y90.0001 ; move to safe pos
G1 X-13.0 F3000 ; move to safe pos
M400
M1004 S5 P1  ; external shutter
M400 P300
M971 S11 C11 O0
G92 E0
G1 X0 F18000
M623

; SKIPTYPE: head_wrap_detect
M622.1 S1
M1002 judge_flag g39_3rd_layer_detect_flag
M622 J1
    ; enable nozzle clog detect at 3rd layer
    


    M622.1 S1
    M1002 judge_flag g39_detection_flag
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




G1 X90.417 Y83.186
G1 Z.8
G1 E.3 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.366293
G1 F4800
M204 S6000
G1 X89.687 Y83.179 E.01179
G1 X89.003 Y83.244 E.01109
G1 X88.335 Y83.377 E.01099
G1 X87.684 Y83.576 E.01099
G1 X87.056 Y83.838 E.01099
G1 X86.457 Y84.162 E.01098
G1 X85.893 Y84.544 E.01099
G1 X85.37 Y84.98 E.01099
G1 X84.894 Y85.466 E.01098
G1 X84.467 Y85.997 E.01099
G1 X84.096 Y86.567 E.01099
G1 X83.784 Y87.172 E.01098
G1 X83.533 Y87.805 E.01099
G1 X83.347 Y88.46 E.01099
G1 X83.227 Y89.13 E.01098
G1 X83.174 Y89.809 E.01099
G1 X83.189 Y90.489 E.01099
G1 X83.271 Y91.165 E.01099
G1 X83.421 Y91.829 E.01099
G1 X83.635 Y92.475 E.01098
G1 X83.913 Y93.097 E.01099
G1 X84.252 Y93.687 E.01099
G1 X84.648 Y94.241 E.01099
G1 X85.097 Y94.753 E.01099
G1 X85.594 Y95.218 E.01099
G1 X86.136 Y95.63 E.01099
G1 X86.715 Y95.987 E.01099
G1 X87.328 Y96.284 E.01099
G1 X87.967 Y96.519 E.01099
G1 X88.626 Y96.689 E.01099
G1 X89.299 Y96.793 E.01099
G1 X89.979 Y96.829 E.01099
G1 X90.659 Y96.797 E.01099
G1 X91.332 Y96.698 E.01099
G1 X91.993 Y96.532 E.01099
G1 X92.633 Y96.301 E.01098
G1 X93.247 Y96.007 E.01099
G1 X93.829 Y95.654 E.01099
G1 X94.373 Y95.245 E.01099
G1 X94.873 Y94.783 E.01098
G1 X95.326 Y94.274 E.01099
G1 X95.725 Y93.723 E.01099
G1 X96.067 Y93.134 E.01099
G1 X96.349 Y92.514 E.01099
G1 X96.568 Y91.87 E.01098
G1 X96.721 Y91.207 E.01099
G1 X96.808 Y90.531 E.01099
G1 X96.827 Y89.838 E.0112
G1 X96.778 Y89.172 E.01078
G1 X96.662 Y88.501 E.01098
G1 X96.48 Y87.845 E.011
G1 X96.233 Y87.211 E.01098
G1 X95.924 Y86.604 E.01099
G1 X95.557 Y86.031 E.011
G1 X95.134 Y85.497 E.01098
G1 X94.66 Y85.009 E.01099
G1 X94.14 Y84.569 E.01099
G1 X93.578 Y84.184 E.01099
G1 X92.982 Y83.857 E.01099
G1 X92.355 Y83.59 E.01099
G1 X91.705 Y83.388 E.01099
G1 X91.038 Y83.251 E.01098
G1 X90.477 Y83.192 E.00911
M204 S10000
G1 X90.331 Y83.523 F18000
; LINE_WIDTH: 0.366129
G1 F4800
M204 S6000
G1 X90.954 Y83.582 E.01011
G1 X91.588 Y83.709 E.01043
G1 X92.207 Y83.898 E.01044
G1 X92.804 Y84.149 E.01044
G1 X93.372 Y84.457 E.01043
G1 X93.907 Y84.82 E.01044
G1 X94.404 Y85.235 E.01044
G1 X94.856 Y85.697 E.01043
G1 X95.261 Y86.202 E.01043
G1 X95.613 Y86.745 E.01044
G1 X95.909 Y87.32 E.01043
G1 X96.146 Y87.921 E.01043
G1 X96.323 Y88.544 E.01045
G1 X96.436 Y89.181 E.01043
G1 X96.486 Y89.826 E.01044
G1 X96.471 Y90.472 E.01043
G1 X96.392 Y91.114 E.01044
G1 X96.249 Y91.745 E.01043
G1 X96.045 Y92.359 E.01043
G1 X95.78 Y92.949 E.01044
G1 X95.457 Y93.51 E.01044
G1 X95.081 Y94.036 E.01043
G1 X94.654 Y94.522 E.01044
G1 X94.18 Y94.962 E.01043
G1 X93.665 Y95.354 E.01044
G1 X93.114 Y95.692 E.01043
G1 X92.532 Y95.974 E.01044
G1 X91.925 Y96.197 E.01043
G1 X91.298 Y96.357 E.01043
G1 X90.659 Y96.455 E.01044
G1 X90.013 Y96.489 E.01044
G1 X89.367 Y96.458 E.01043
G1 X88.727 Y96.362 E.01043
G1 X88.1 Y96.204 E.01044
G1 X87.491 Y95.984 E.01044
G1 X86.908 Y95.704 E.01043
G1 X86.355 Y95.368 E.01044
G1 X85.839 Y94.979 E.01043
G1 X85.364 Y94.54 E.01043
G1 X84.935 Y94.055 E.01044
G1 X84.556 Y93.531 E.01044
G1 X84.232 Y92.971 E.01043
G1 X83.964 Y92.382 E.01044
G1 X83.757 Y91.77 E.01043
G1 X83.612 Y91.139 E.01044
G1 X83.53 Y90.498 E.01044
G1 X83.513 Y89.851 E.01044
G1 X83.56 Y89.206 E.01044
G1 X83.671 Y88.569 E.01043
G1 X83.845 Y87.945 E.01044
G1 X84.08 Y87.343 E.01044
G1 X84.374 Y86.767 E.01043
G1 X84.734 Y86.209 E.01071
G1 X85.126 Y85.716 E.01017
G1 X85.577 Y85.252 E.01043
G1 X86.072 Y84.835 E.01044
G1 X86.606 Y84.47 E.01044
G1 X87.173 Y84.16 E.01043
G1 X87.769 Y83.907 E.01044
G1 X88.386 Y83.715 E.01044
G1 X89.02 Y83.586 E.01043
G1 X89.667 Y83.52 E.0105
G1 X90.271 Y83.523 E.00973
; WIPE_START
G1 X89.667 Y83.52 E-.08595
G1 X89.02 Y83.586 E-.09273
G1 X88.386 Y83.715 E-.09216
G1 X88.292 Y83.745 E-.01415
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X94.026 Y85.417 Z1.2 F18000
G1 Z.8
G1 E.3 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F4880
M204 S6000
G1 X93.687 Y85.132 E.0089
G1 X93.184 Y84.789 E.01224
G1 X92.615 Y84.484 E.01298
G1 X92.472 Y84.855 E.008
G1 X91.952 Y84.636 E.01134
G1 X91.408 Y84.468 E.01145
G1 X90.85 Y84.356 E.01144
G1 X90.286 Y84.299 E.01141
G1 X89.776 Y84.298 E.01025
G1 X89.419 Y84.322 E.00719
G1 X88.893 Y84.401 E.01069
G1 X88.763 Y84.028 E.00795
G1 X88.493 Y84.082 E.00555
G1 X87.911 Y84.262 E.01224
G1 X87.35 Y84.498 E.01224
G1 X86.816 Y84.789 E.01224
G1 X86.313 Y85.132 E.01224
G1 X85.846 Y85.524 E.01224
G1 X85.422 Y85.959 E.01223
G1 X85.176 Y86.267 E.00791
G1 X85.233 Y86.358 E.00216
G1 X85.49 Y86.507 E.00597
G1 X85.205 Y86.903 E.00981
G1 X84.92 Y87.396 E.01144
G1 X84.686 Y87.915 E.01144
G1 X84.505 Y88.454 E.01144
G1 X84.378 Y89.009 E.01145
G1 X84.308 Y89.573 E.01144
G1 X84.294 Y90.142 E.01144
G1 X84.336 Y90.71 E.01144
G1 X84.435 Y91.27 E.01144
G1 X84.589 Y91.818 E.01143
G1 X84.797 Y92.348 E.01145
G1 X84.987 Y92.719 E.00839
G1 X84.953 Y93.186 E.00943
G1 X85.233 Y93.642 E.01075
G1 X86.053 Y94.119 E.01909
G1 X86.553 Y94.55 E.01328
G1 X86.976 Y94.838 E.01028
G1 X87.137 Y95.007 E.0047
G1 X87.418 Y95.462 E.01076
G1 X87.444 Y95.539 E.00162
G1 X87.628 Y95.627 E.00409
G1 X88.2 Y95.835 E.01225
G1 X88.79 Y95.985 E.01224
G1 X89.392 Y96.076 E.01224
G1 X90 Y96.106 E.01224
G1 X90.631 Y96.073 E.0127
G1 X90.778 Y95.918 E.00431
G1 X90.961 Y95.622 E.00698
G1 X91.426 Y95.528 E.00953
G1 X92.201 Y95.268 E.01645
G1 X92.73 Y95.013 E.0118
G1 X93.215 Y94.716 E.01144
G1 X93.689 Y94.354 E.012
G1 X94.021 Y94.589 E.00817
G1 X94.371 Y94.264 E.0096
M73 P63 R4
G1 X94.774 Y93.807 E.01224
G1 X95.129 Y93.313 E.01223
G1 X95.434 Y92.786 E.01224
G1 X95.684 Y92.231 E.01224
G1 X95.878 Y91.654 E.01224
G1 X95.992 Y91.154 E.01031
G1 X95.907 Y90.91 E.00519
G1 X95.877 Y90.455 E.00917
G1 X96.098 Y90.096 E.00848
G1 X96.104 Y89.848 E.005
G1 X96.059 Y89.241 E.01224
G1 X95.953 Y88.641 E.01223
G1 X95.891 Y88.419 E.00465
; CHANGE_LAYER
; Z_HEIGHT: 0.92
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F6000
G1 X95.953 Y88.641 E-.03294
G1 X96.059 Y89.241 E-.08671
G1 X96.104 Y89.848 E-.08674
G1 X96.098 Y90.096 E-.03543
G1 X95.939 Y90.354 E-.04318
; WIPE_END
G1 E-.015 F1800
; layer num/total_layer_count: 7/33
; update layer progress
M73 L7
M991 S0 P6 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z1.2 I-1.057 J-.603 P1  F18000
G1 X94.775 Y92.396 Z1.2
G1 Z.92
G1 E.3 F1800
; FEATURE: Inner wall
G1 F3600
M204 S6000
G1 X94.756 Y92.439 E.00093
G1 X94.49 Y92.9 E.01071
G1 X94.183 Y93.326 E.01054
G1 X93.965 Y93.582 E.00677
G1 X93.634 Y93.919 E.00949
G1 X93.227 Y94.261 E.01069
G1 X92.787 Y94.561 E.0107
G1 X92.319 Y94.815 E.01072
G1 X91.828 Y95.022 E.01071
G1 X91.319 Y95.18 E.01072
G1 X90.796 Y95.285 E.01071
G1 X90.266 Y95.338 E.01071
G1 X89.733 Y95.338 E.01071
G1 X89.203 Y95.285 E.01071
G1 X88.681 Y95.18 E.01071
G1 X88.172 Y95.022 E.01072
G1 X87.681 Y94.815 E.01071
G1 X87.213 Y94.561 E.01071
G1 X86.773 Y94.261 E.01071
G1 X86.364 Y93.918 E.01072
G1 X85.992 Y93.537 E.01071
G1 X85.66 Y93.12 E.01071
G1 X85.371 Y92.672 E.01071
G1 X85.128 Y92.198 E.01071
G1 X84.933 Y91.702 E.01072
G1 X84.789 Y91.19 E.0107
G1 X84.697 Y90.665 E.01072
G1 X84.657 Y90.133 E.01071
G1 X84.67 Y89.601 E.01071
G1 X84.736 Y89.072 E.01071
G1 X84.855 Y88.552 E.01072
G1 X85.025 Y88.047 E.01071
G1 X85.244 Y87.562 E.01071
G1 X85.51 Y87.1 E.01071
G1 X85.821 Y86.667 E.01072
G1 X86.174 Y86.268 E.01071
G1 X86.564 Y85.906 E.01072
G1 X86.989 Y85.584 E.01071
G1 X87.444 Y85.306 E.01072
G1 X87.924 Y85.075 E.01071
G1 X88.424 Y84.893 E.01071
G1 X88.941 Y84.761 E.01072
G1 X89.459 Y84.683 E.01054
G1 X89.795 Y84.661 E.00678
G1 X90.268 Y84.662 E.00949
G1 X90.796 Y84.715 E.01068
G1 X91.319 Y84.82 E.01071
G1 X91.828 Y84.978 E.01072
G1 X92.319 Y85.185 E.01071
G1 X92.787 Y85.439 E.01071
G1 X93.227 Y85.739 E.01071
G1 X93.635 Y86.082 E.01072
G1 X94.007 Y86.463 E.01071
G1 X94.339 Y86.88 E.01072
G1 X94.629 Y87.328 E.01071
G1 X94.872 Y87.802 E.01072
G1 X95.066 Y88.298 E.01072
G1 X95.211 Y88.811 E.01071
G1 X95.303 Y89.335 E.01072
G1 X95.343 Y89.867 E.01071
G1 X95.33 Y90.399 E.01071
G1 X95.263 Y90.928 E.01071
G1 X95.145 Y91.448 E.01072
G1 X94.975 Y91.953 E.01071
G1 X94.8 Y92.341 E.00857
M204 S10000
G1 X94.388 Y92.222 F18000
G1 F3600
M204 S6000
G1 X94.378 Y92.245 E.00051
G1 X94.133 Y92.669 E.00986
G1 X93.849 Y93.064 E.00976
G1 X93.652 Y93.295 E.00613
G1 X93.346 Y93.607 E.00878
G1 X92.97 Y93.922 E.00985
G1 X92.565 Y94.198 E.00986
G1 X92.135 Y94.433 E.00986
G1 X91.683 Y94.623 E.00986
G1 X91.214 Y94.768 E.00987
G1 X90.733 Y94.865 E.00986
G1 X90.245 Y94.914 E.00986
G1 X89.755 Y94.914 E.00986
G1 X89.267 Y94.865 E.00986
G1 X88.786 Y94.768 E.00986
G1 X88.317 Y94.623 E.00987
G1 X87.865 Y94.433 E.00986
G1 X87.434 Y94.198 E.00986
G1 X87.029 Y93.922 E.00986
G1 X86.653 Y93.607 E.00986
G1 X86.311 Y93.256 E.00986
G1 X86.005 Y92.872 E.00986
G1 X85.739 Y92.46 E.00986
G1 X85.515 Y92.023 E.00986
G1 X85.336 Y91.567 E.00987
G1 X85.203 Y91.095 E.00985
G1 X85.118 Y90.612 E.00986
G1 X85.081 Y90.123 E.00986
G1 X85.094 Y89.632 E.00986
G1 X85.155 Y89.146 E.00986
G1 X85.264 Y88.667 E.00987
G1 X85.42 Y88.202 E.00986
G1 X85.622 Y87.755 E.00986
G1 X85.867 Y87.331 E.00986
G1 X86.153 Y86.932 E.00987
G1 X86.478 Y86.565 E.00986
G1 X86.837 Y86.231 E.00986
G1 X87.228 Y85.935 E.00986
G1 X87.647 Y85.679 E.00987
G1 X88.089 Y85.466 E.00986
G1 X88.55 Y85.299 E.00986
G1 X89.025 Y85.178 E.00987
G1 X89.505 Y85.105 E.00976
G1 X89.809 Y85.085 E.00613
G1 X90.246 Y85.086 E.00878
G1 X90.733 Y85.135 E.00984
G1 X91.214 Y85.232 E.00986
G1 X91.683 Y85.377 E.00987
G1 X92.135 Y85.567 E.00986
G1 X92.565 Y85.802 E.00986
G1 X92.97 Y86.078 E.00986
G1 X93.346 Y86.393 E.00986
G1 X93.689 Y86.744 E.00986
G1 X93.995 Y87.128 E.00986
G1 X94.261 Y87.54 E.00986
G1 X94.484 Y87.976 E.00986
G1 X94.664 Y88.433 E.00987
G1 X94.796 Y88.905 E.00986
G1 X94.882 Y89.388 E.00986
G1 X94.918 Y89.877 E.00986
G1 X94.906 Y90.368 E.00986
G1 X94.845 Y90.854 E.00986
G1 X94.736 Y91.333 E.00987
G1 X94.58 Y91.798 E.00986
G1 X94.413 Y92.167 E.00815
M204 S250
G1 X94.015 Y92.053 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1800
M204 S5000
G1 X94.013 Y92.058 E.00009
G1 X93.788 Y92.447 E.0084
G1 X93.527 Y92.811 E.00837
G1 X93.067 Y93.306 E.01263
G1 X92.723 Y93.595 E.0084
G1 X92.352 Y93.848 E.0084
G1 X91.957 Y94.064 E.0084
G1 X91.543 Y94.238 E.0084
G1 X91.113 Y94.371 E.00841
G1 X90.672 Y94.46 E.0084
G1 X90.225 Y94.505 E.0084
G1 X89.775 Y94.505 E.0084
G1 X89.328 Y94.46 E.0084
G1 X88.887 Y94.371 E.0084
G1 X88.457 Y94.238 E.00841
G1 X88.043 Y94.064 E.0084
G1 X87.648 Y93.849 E.0084
G1 X87.277 Y93.595 E.0084
G1 X86.932 Y93.306 E.0084
G1 X86.618 Y92.984 E.0084
G1 X86.338 Y92.633 E.0084
G1 X86.094 Y92.255 E.0084
G1 X85.889 Y91.855 E.0084
G1 X85.724 Y91.436 E.0084
G1 X85.603 Y91.004 E.0084
G1 X85.525 Y90.561 E.0084
G1 X85.491 Y90.112 E.00841
G1 X85.502 Y89.663 E.0084
G1 X85.558 Y89.217 E.0084
G1 X85.658 Y88.778 E.00841
G1 X85.801 Y88.352 E.0084
G1 X85.986 Y87.942 E.0084
G1 X86.211 Y87.553 E.0084
G1 X86.474 Y87.188 E.00841
G1 X86.771 Y86.851 E.0084
G1 X87.101 Y86.545 E.0084
G1 X87.459 Y86.273 E.0084
G1 X87.843 Y86.039 E.00841
G1 X88.248 Y85.844 E.0084
G1 X88.67 Y85.69 E.0084
G1 X89.106 Y85.579 E.0084
G1 X89.549 Y85.512 E.00837
G1 X90.225 Y85.495 E.01263
G1 X90.672 Y85.54 E.0084
G1 X91.113 Y85.629 E.0084
G1 X91.543 Y85.762 E.00841
G1 X91.957 Y85.936 E.0084
G1 X92.352 Y86.151 E.0084
G1 X92.723 Y86.405 E.0084
G1 X93.068 Y86.694 E.0084
G1 X93.381 Y87.016 E.0084
G1 X93.662 Y87.367 E.0084
G1 X93.906 Y87.745 E.0084
G1 X94.111 Y88.145 E.0084
G1 X94.275 Y88.564 E.0084
G1 X94.397 Y88.996 E.0084
G1 X94.475 Y89.439 E.0084
G1 X94.509 Y89.888 E.0084
G1 X94.497 Y90.337 E.0084
G1 X94.442 Y90.783 E.0084
G1 X94.341 Y91.222 E.0084
G1 X94.198 Y91.648 E.0084
G1 X94.04 Y91.999 E.00719
; WIPE_START
M204 S6000
G1 X94.013 Y92.058 E-.00924
G1 X93.788 Y92.447 E-.06407
G1 X93.527 Y92.811 E-.06383
G1 X93.067 Y93.306 E-.09633
G1 X92.79 Y93.539 E-.05153
; WIPE_END
G1 E-.015
M204 S10000
G1 X88.512 Y87.218 Z1.32 F18000
G1 X86.325 Y83.986 Z1.32
G1 Z.92
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F3600
M204 S6000
G1 X86.942 Y83.65 E.01413
G1 X87.589 Y83.377 E.01413
G1 X88.261 Y83.17 E.01413
G1 X88.949 Y83.031 E.01413
G1 X89.649 Y82.961 E.01413
G1 X90.351 Y82.961 E.01413
G1 X90.931 Y83.019 E.01172
G1 X91.739 Y83.17 E.01653
G1 X92.41 Y83.377 E.01413
G1 X93.058 Y83.65 E.01413
G1 X93.675 Y83.986 E.01412
G1 X94.255 Y84.382 E.01413
G1 X94.794 Y84.834 E.01413
G1 X95.284 Y85.337 E.01413
G1 X95.722 Y85.886 E.01413
G1 X96.103 Y86.476 E.01413
G1 X96.424 Y87.101 E.01413
G1 X96.681 Y87.755 E.01412
G1 X96.871 Y88.432 E.01413
G1 X96.993 Y89.124 E.01413
G1 X97.045 Y89.824 E.01413
G1 X97.028 Y90.527 E.01412
G1 X96.94 Y91.224 E.01413
G1 X96.784 Y91.909 E.01412
G1 X96.56 Y92.575 E.01413
G1 X96.271 Y93.215 E.01413
G1 X95.92 Y93.824 E.01413
G1 X95.51 Y94.394 E.01413
G1 X95.045 Y94.921 E.01413
G1 X94.53 Y95.399 E.01413
G1 X93.97 Y95.823 E.01413
G1 X93.37 Y96.189 E.01413
G1 X92.737 Y96.494 E.01413
G1 X92.077 Y96.735 E.01413
G1 X91.396 Y96.908 E.01412
G1 X90.701 Y97.013 E.01413
G1 X90 Y97.048 E.01413
G1 X89.298 Y97.013 E.01413
G1 X88.603 Y96.908 E.01413
G1 X87.923 Y96.735 E.01412
G1 X87.262 Y96.494 E.01413
G1 X86.629 Y96.189 E.01413
G1 X86.03 Y95.823 E.01413
G1 X85.47 Y95.399 E.01413
G1 X84.955 Y94.921 E.01413
G1 X84.49 Y94.394 E.01413
G1 X84.08 Y93.824 E.01412
G1 X83.728 Y93.215 E.01413
G1 X83.439 Y92.575 E.01412
G1 X83.215 Y91.909 E.01413
G1 X83.059 Y91.224 E.01412
G1 X82.972 Y90.527 E.01413
G1 X82.954 Y89.824 E.01412
G1 X83.007 Y89.124 E.01413
G1 X83.129 Y88.432 E.01413
G1 X83.319 Y87.755 E.01413
G1 X83.576 Y87.101 E.01413
G1 X83.896 Y86.476 E.01413
G1 X84.277 Y85.886 E.01412
G1 X84.716 Y85.337 E.01413
G1 X85.206 Y84.834 E.01412
G1 X85.744 Y84.382 E.01413
G1 X86.275 Y84.02 E.01292
M204 S10000
G1 X86.103 Y83.624 F18000
G1 F3600
M204 S6000
G1 X86.758 Y83.268 E.01498
G1 X87.444 Y82.978 E.01498
G1 X88.156 Y82.759 E.01498
G1 X88.886 Y82.611 E.01498
G1 X89.627 Y82.537 E.01498
G1 X90.372 Y82.537 E.01498
G1 X90.973 Y82.597 E.01215
G1 X91.844 Y82.759 E.0178
G1 X92.556 Y82.978 E.01498
G1 X93.242 Y83.268 E.01498
G1 X93.896 Y83.624 E.01498
G1 X94.512 Y84.043 E.01498
G1 X95.082 Y84.522 E.01498
G1 X95.603 Y85.056 E.01498
G1 X96.067 Y85.638 E.01498
G1 X96.471 Y86.264 E.01498
G1 X96.811 Y86.927 E.01498
G1 X97.083 Y87.62 E.01498
G1 X97.285 Y88.337 E.01498
G1 X97.414 Y89.071 E.01498
G1 X97.47 Y89.814 E.01498
G1 X97.451 Y90.558 E.01497
G1 X97.359 Y91.298 E.01498
G1 X97.193 Y92.024 E.01498
G1 X96.956 Y92.73 E.01498
G1 X96.649 Y93.409 E.01498
G1 X96.277 Y94.054 E.01498
G1 X95.842 Y94.659 E.01498
G1 X95.349 Y95.218 E.01498
G1 X94.803 Y95.724 E.01498
G1 X94.209 Y96.174 E.01498
G1 X93.574 Y96.563 E.01498
G1 X92.902 Y96.886 E.01498
G1 X92.202 Y97.141 E.01498
G1 X91.481 Y97.324 E.01498
G1 X90.744 Y97.435 E.01498
G1 X90 Y97.473 E.01498
G1 X89.256 Y97.435 E.01498
G1 X88.519 Y97.324 E.01498
G1 X87.797 Y97.141 E.01498
G1 X87.097 Y96.886 E.01498
G1 X86.426 Y96.563 E.01498
G1 X85.79 Y96.174 E.01498
G1 X85.197 Y95.724 E.01498
G1 X84.651 Y95.218 E.01498
G1 X84.158 Y94.659 E.01498
G1 X83.723 Y94.054 E.01498
G1 X83.35 Y93.409 E.01498
G1 X83.044 Y92.73 E.01498
G1 X82.807 Y92.024 E.01498
G1 X82.641 Y91.298 E.01498
G1 X82.548 Y90.558 E.01498
G1 X82.53 Y89.814 E.01497
G1 X82.585 Y89.071 E.01498
G1 X82.715 Y88.337 E.01498
G1 X82.916 Y87.62 E.01498
G1 X83.189 Y86.927 E.01498
G1 X83.528 Y86.264 E.01498
G1 X83.933 Y85.638 E.01498
G1 X84.397 Y85.056 E.01498
G1 X84.917 Y84.522 E.01498
G1 X85.488 Y84.043 E.01498
G1 X86.054 Y83.658 E.01378
M204 S250
G1 X85.878 Y83.282 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1800
M204 S5000
G1 X85.89 Y83.274 E.00026
G1 X86.58 Y82.898 E.01468
G1 X87.304 Y82.593 E.01468
G1 X88.055 Y82.362 E.01468
G1 X88.825 Y82.206 E.01468
G1 X89.607 Y82.128 E.01468
G1 X90.393 Y82.128 E.01468
G1 X91.014 Y82.19 E.01167
G1 X91.175 Y82.206 E.00301
G1 X91.945 Y82.362 E.01468
G1 X92.696 Y82.593 E.01468
G1 X93.42 Y82.898 E.01468
G1 X94.11 Y83.274 E.01468
G1 X94.759 Y83.717 E.01468
G1 X95.361 Y84.222 E.01469
G1 X95.91 Y84.784 E.01468
G1 X96.4 Y85.399 E.01468
G1 X96.826 Y86.059 E.01468
G1 X97.185 Y86.758 E.01468
G1 X97.472 Y87.49 E.01468
G1 X97.684 Y88.246 E.01468
G1 X97.821 Y89.02 E.01468
G1 X97.88 Y89.804 E.01468
G1 X97.86 Y90.589 E.01468
G1 X97.762 Y91.369 E.01469
G1 X97.587 Y92.135 E.01468
G1 X97.337 Y92.88 E.01469
G1 X97.014 Y93.596 E.01468
G1 X96.621 Y94.277 E.01469
G1 X96.162 Y94.914 E.01468
G1 X95.642 Y95.504 E.01468
G1 X95.066 Y96.038 E.01468
G1 X94.44 Y96.513 E.01468
G1 X93.77 Y96.922 E.01468
G1 X93.062 Y97.263 E.01468
G1 X92.323 Y97.532 E.01469
G1 X91.562 Y97.726 E.01468
G1 X90.785 Y97.843 E.01468
G1 X90 Y97.882 E.01468
G1 X89.215 Y97.843 E.01468
G1 X88.438 Y97.726 E.01468
G1 X87.677 Y97.532 E.01468
G1 X86.938 Y97.263 E.01469
G1 X86.23 Y96.922 E.01468
G1 X85.56 Y96.513 E.01468
G1 X84.933 Y96.038 E.01468
G1 X84.357 Y95.504 E.01468
G1 X83.837 Y94.915 E.01468
G1 X83.379 Y94.277 E.01468
G1 X82.986 Y93.596 E.01469
G1 X82.662 Y92.88 E.01468
G1 X82.412 Y92.135 E.01469
G1 X82.237 Y91.369 E.01468
G1 X82.14 Y90.589 E.01469
G1 X82.12 Y89.804 E.01468
G1 X82.179 Y89.02 E.01468
G1 X82.315 Y88.246 E.01468
G1 X82.528 Y87.49 E.01468
G1 X82.815 Y86.758 E.01468
G1 X83.174 Y86.059 E.01468
G1 X83.6 Y85.399 E.01468
G1 X84.09 Y84.784 E.01468
G1 X84.639 Y84.222 E.01468
G1 X85.24 Y83.717 E.01468
G1 X85.829 Y83.316 E.01331
; WIPE_START
M204 S6000
G1 X85.89 Y83.274 E-.01052
G1 X86.58 Y82.898 E-.11195
G1 X87.304 Y82.593 E-.11199
G1 X87.643 Y82.489 E-.05054
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
G1 X0 Y90.0001 ; move to safe pos
G1 X-13.0 F3000 ; move to safe pos
M400
M1004 S5 P1  ; external shutter
M400 P300
M971 S11 C11 O0
G92 E0
G1 X0 F18000
M623

; SKIPTYPE: head_wrap_detect
M622.1 S1
M1002 judge_flag g39_3rd_layer_detect_flag
M622 J1
    ; enable nozzle clog detect at 3rd layer
    


    M622.1 S1
    M1002 judge_flag g39_detection_flag
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




G1 X96.635 Y89.857
G1 Z.92
G1 E.3 F1800
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.419992
G1 F3840
M204 S6000
G1 X96.59 Y89.228 E.01177
G1 X96.481 Y88.576 E.01236
G1 X96.307 Y87.938 E.01236
G1 X96.07 Y87.32 E.01236
G1 X95.773 Y86.729 E.01236
G1 X95.419 Y86.17 E.01236
G1 X95.01 Y85.65 E.01236
G1 X94.552 Y85.173 E.01235
G1 X94.049 Y84.743 E.01237
G1 X93.505 Y84.366 E.01236
G1 X92.927 Y84.045 E.01236
G1 X92.32 Y83.783 E.01236
G1 X91.689 Y83.583 E.01237
G1 X91.034 Y83.455 E.01248
G1 X90.386 Y83.376 E.0122
G1 X89.79 Y83.37 E.01113
G1 X89.033 Y83.434 E.01421
G1 X88.384 Y83.563 E.01236
G1 X87.751 Y83.756 E.01237
G1 X87.14 Y84.011 E.01236
G1 X86.558 Y84.325 E.01236
G1 X86.01 Y84.696 E.01237
G1 X85.502 Y85.12 E.01236
G1 X85.038 Y85.592 E.01236
G1 X84.624 Y86.108 E.01236
G1 X84.263 Y86.662 E.01237
G1 X83.959 Y87.25 E.01236
G1 X83.716 Y87.865 E.01237
G1 X83.534 Y88.502 E.01236
G1 X83.417 Y89.153 E.01236
G1 X83.366 Y89.812 E.01237
G1 X83.38 Y90.474 E.01236
G1 X83.46 Y91.131 E.01236
G1 X83.605 Y91.776 E.01236
G1 X83.814 Y92.404 E.01237
G1 X84.084 Y93.008 E.01236
G1 X84.413 Y93.582 E.01237
G1 X84.797 Y94.121 E.01236
G1 X85.233 Y94.618 E.01236
M73 P64 R4
G1 X85.717 Y95.07 E.01237
G1 X86.243 Y95.471 E.01236
G1 X86.806 Y95.818 E.01236
G1 X87.401 Y96.107 E.01236
G1 X88.023 Y96.336 E.01237
G1 X88.663 Y96.501 E.01235
G1 X89.317 Y96.602 E.01237
G1 X89.978 Y96.637 E.01236
G1 X90.638 Y96.606 E.01236
G1 X91.293 Y96.51 E.01237
G1 X91.935 Y96.349 E.01235
G1 X92.557 Y96.124 E.01237
G1 X93.154 Y95.839 E.01236
G1 X93.72 Y95.496 E.01237
G1 X94.249 Y95.098 E.01236
G1 X94.735 Y94.65 E.01237
G1 X95.151 Y94.183 E.01168
G1 X95.544 Y93.645 E.01245
G1 X95.88 Y93.075 E.01236
G1 X96.157 Y92.474 E.01236
G1 X96.373 Y91.849 E.01236
G1 X96.525 Y91.205 E.01236
G1 X96.613 Y90.549 E.01236
G1 X96.633 Y89.917 E.01183
; WIPE_START
G1 X96.613 Y90.549 E-.09021
G1 X96.525 Y91.205 E-.09428
G1 X96.373 Y91.849 E-.09428
G1 X96.358 Y91.89 E-.00623
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X93.694 Y94.403 Z1.32 F18000
G1 Z.92
G1 E.3 F1800
G1 F3840
M204 S6000
G1 X93.238 Y94.749 E.0107
G1 X92.748 Y95.048 E.01071
G1 X92.232 Y95.296 E.0107
G1 X91.694 Y95.492 E.01071
G1 X91.139 Y95.633 E.0107
G1 X90.572 Y95.719 E.01071
G1 X90 Y95.747 E.0107
G1 X89.428 Y95.719 E.0107
G1 X88.861 Y95.633 E.01071
G1 X88.306 Y95.492 E.0107
G1 X87.767 Y95.296 E.01071
G1 X87.251 Y95.047 E.0107
G1 X86.762 Y94.749 E.01071
G1 X86.306 Y94.403 E.0107
G1 X85.885 Y94.013 E.01071
G1 X85.506 Y93.583 E.0107
G1 X85.172 Y93.118 E.0107
G1 X84.885 Y92.622 E.01071
G1 X84.65 Y92.1 E.0107
G1 X84.467 Y91.557 E.01071
G1 X84.34 Y90.998 E.01071
G1 X84.269 Y90.43 E.0107
G1 X84.254 Y89.857 E.01071
G1 X84.297 Y89.285 E.01071
G1 X84.397 Y88.721 E.0107
G1 X84.552 Y88.17 E.01071
G1 X84.761 Y87.636 E.01071
G1 X85.022 Y87.126 E.0107
G1 X85.333 Y86.645 E.01071
G1 X85.691 Y86.197 E.0107
G1 X86.091 Y85.787 E.0107
G1 X86.529 Y85.419 E.01071
G1 X87.003 Y85.096 E.01071
G1 X87.506 Y84.822 E.0107
G1 X88.034 Y84.599 E.01071
G1 X88.582 Y84.43 E.01071
G1 X89.13 Y84.327 E.01042
G1 X89.766 Y84.253 E.01196
G1 X90.279 Y84.253 E.00959
G1 X90.848 Y84.309 E.01068
G1 X91.41 Y84.421 E.01072
G1 X91.959 Y84.59 E.01072
G1 X92.488 Y84.812 E.01072
G1 X92.992 Y85.085 E.01072
G1 X93.466 Y85.407 E.01072
G1 X93.907 Y85.775 E.01072
G1 X94.307 Y86.185 E.01071
G1 X94.666 Y86.633 E.01072
G1 X94.978 Y87.114 E.01072
G1 X95.241 Y87.625 E.01072
G1 X95.451 Y88.158 E.01072
G1 X95.607 Y88.71 E.01071
G1 X95.708 Y89.275 E.01072
G1 X95.752 Y89.847 E.01072
G1 X95.739 Y90.42 E.01072
G1 X95.668 Y90.989 E.01072
G1 X95.541 Y91.549 E.01072
G1 X95.36 Y92.093 E.01072
G1 X95.125 Y92.617 E.01072
G1 X94.839 Y93.114 E.01072
G1 X94.511 Y93.572 E.01053
G1 X94.101 Y94.016 E.0113
G1 X93.738 Y94.361 E.00937
M204 S10000
G1 X93.98 Y94.744 F18000
; LINE_WIDTH: 0.518742
G1 F3840
M204 S6000
G1 X94.43 Y94.321 E.01443
G1 X94.819 Y93.891 E.01356
G1 X95.186 Y93.388 E.01454
G1 X95.498 Y92.855 E.01443
G1 X95.755 Y92.293 E.01443
G1 X95.954 Y91.708 E.01443
G1 X96.095 Y91.107 E.01443
G1 X96.175 Y90.494 E.01443
G1 X96.194 Y89.846 E.01517
G1 X96.15 Y89.261 E.01369
G1 X96.046 Y88.652 E.01443
G1 X95.882 Y88.057 E.01442
G1 X95.659 Y87.481 E.01443
G1 X95.38 Y86.93 E.01444
G1 X95.048 Y86.41 E.01443
G1 X94.665 Y85.925 E.01443
G1 X94.237 Y85.481 E.01442
G1 X93.765 Y85.081 E.01444
G1 X93.257 Y84.731 E.01443
G1 X92.716 Y84.433 E.01443
G1 X92.149 Y84.19 E.01443
G1 X91.559 Y84.005 E.01444
G1 X90.954 Y83.884 E.01443
G1 X90.342 Y83.815 E.01438
G1 X89.79 Y83.811 E.01289
G1 X89.077 Y83.881 E.01674
G1 X88.472 Y83.999 E.01442
G1 X87.882 Y84.181 E.01443
G1 X87.313 Y84.421 E.01442
G1 X86.771 Y84.716 E.01442
G1 X86.261 Y85.064 E.01443
G1 X85.788 Y85.461 E.01443
G1 X85.357 Y85.903 E.01442
G1 X84.972 Y86.385 E.01442
G1 X84.637 Y86.904 E.01443
G1 X84.355 Y87.453 E.01442
G1 X84.13 Y88.028 E.01443
G1 X83.963 Y88.622 E.01442
G1 X83.856 Y89.23 E.01442
G1 X83.809 Y89.846 E.01443
G1 X83.825 Y90.463 E.01442
G1 X83.901 Y91.075 E.01442
G1 X84.039 Y91.677 E.01443
G1 X84.236 Y92.262 E.01443
G1 X84.489 Y92.825 E.01442
G1 X84.798 Y93.36 E.01443
G1 X85.158 Y93.861 E.01442
G1 X85.567 Y94.324 E.01442
G1 X86.02 Y94.744 E.01443
G1 X86.511 Y95.116 E.01442
G1 X87.038 Y95.438 E.01442
G1 X87.594 Y95.706 E.01442
G1 X88.175 Y95.917 E.01443
G1 X88.773 Y96.07 E.01441
G1 X89.383 Y96.162 E.01443
G1 X90 Y96.192 E.01442
G1 X90.616 Y96.162 E.01442
G1 X91.227 Y96.07 E.01443
G1 X91.825 Y95.917 E.01441
G1 X92.405 Y95.706 E.01443
G1 X92.961 Y95.438 E.01442
G1 X93.488 Y95.116 E.01443
G1 X93.932 Y94.78 E.01302
; CHANGE_LAYER
; Z_HEIGHT: 1.04
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F3840
G1 X93.488 Y95.116 E-.07938
G1 X92.961 Y95.438 E-.088
G1 X92.405 Y95.706 E-.08794
G1 X92.21 Y95.777 E-.02968
; WIPE_END
G1 E-.015 F1800
; layer num/total_layer_count: 8/33
; update layer progress
M73 L8
M991 S0 P7 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z1.32 I.969 J.736 P1  F18000
G1 X94.774 Y92.398 Z1.32
G1 Z1.04
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F3323
M204 S6000
G1 X94.756 Y92.438 E.00089
G1 X94.489 Y92.9 E.01072
G1 X94.183 Y93.326 E.01055
G1 X93.96 Y93.587 E.00692
G1 X93.634 Y93.919 E.00935
G1 X93.227 Y94.26 E.01067
G1 X92.787 Y94.561 E.01072
G1 X92.319 Y94.815 E.01071
G1 X91.828 Y95.022 E.01071
G1 X91.319 Y95.18 E.01072
G1 X90.796 Y95.285 E.01071
G1 X90.266 Y95.338 E.01071
G1 X89.733 Y95.338 E.01071
G1 X89.203 Y95.285 E.01071
G1 X88.681 Y95.18 E.01071
G1 X88.172 Y95.022 E.01072
G1 X87.681 Y94.816 E.01071
G1 X87.213 Y94.561 E.01072
G1 X86.773 Y94.26 E.01071
G1 X86.364 Y93.918 E.01071
G1 X85.992 Y93.537 E.01071
G1 X85.66 Y93.12 E.01072
G1 X85.371 Y92.673 E.01071
G1 X85.128 Y92.198 E.01072
G1 X84.933 Y91.702 E.01071
G1 X84.789 Y91.19 E.01071
G1 X84.697 Y90.665 E.01072
G1 X84.657 Y90.133 E.01071
G1 X84.67 Y89.601 E.01071
G1 X84.736 Y89.072 E.01071
G1 X84.855 Y88.552 E.01072
G1 X85.025 Y88.047 E.01071
G1 X85.244 Y87.561 E.01072
G1 X85.51 Y87.1 E.01071
G1 X85.821 Y86.668 E.01071
G1 X86.174 Y86.268 E.01071
G1 X86.564 Y85.906 E.01071
G1 X86.989 Y85.584 E.01071
G1 X87.444 Y85.306 E.01071
G1 X87.924 Y85.075 E.01072
G1 X88.424 Y84.893 E.01071
G1 X88.941 Y84.761 E.01072
G1 X89.46 Y84.683 E.01055
G1 X89.803 Y84.661 E.00692
G1 X90.268 Y84.662 E.00935
G1 X90.796 Y84.715 E.01068
G1 X91.319 Y84.82 E.01071
G1 X91.828 Y84.978 E.01072
G1 X92.319 Y85.185 E.01071
G1 X92.787 Y85.439 E.01072
G1 X93.227 Y85.739 E.01071
G1 X93.635 Y86.082 E.01072
G1 X94.007 Y86.463 E.01071
G1 X94.339 Y86.88 E.01071
G1 X94.628 Y87.328 E.01071
G1 X94.872 Y87.802 E.01072
G1 X95.066 Y88.298 E.01071
G1 X95.211 Y88.81 E.01071
G1 X95.303 Y89.335 E.01072
G1 X95.343 Y89.867 E.01071
G1 X95.33 Y90.399 E.01071
G1 X95.263 Y90.928 E.01071
G1 X95.145 Y91.448 E.01072
G1 X94.975 Y91.953 E.01072
G1 X94.799 Y92.344 E.00862
M204 S10000
G1 X94.387 Y92.224 F18000
G1 F3323
M204 S6000
G1 X94.378 Y92.245 E.00046
G1 X94.133 Y92.669 E.00986
G1 X93.849 Y93.064 E.00977
G1 X93.647 Y93.301 E.00626
G1 X93.345 Y93.607 E.00865
G1 X92.971 Y93.922 E.00984
G1 X92.565 Y94.198 E.00987
G1 X92.134 Y94.433 E.00986
G1 X91.683 Y94.623 E.00986
G1 X91.214 Y94.768 E.00986
G1 X90.733 Y94.865 E.00986
G1 X90.245 Y94.914 E.00986
G1 X89.755 Y94.914 E.00986
G1 X89.267 Y94.865 E.00986
G1 X88.786 Y94.768 E.00986
G1 X88.317 Y94.623 E.00987
G1 X87.865 Y94.433 E.00986
G1 X87.434 Y94.198 E.00987
G1 X87.029 Y93.922 E.00986
G1 X86.653 Y93.607 E.00986
G1 X86.311 Y93.256 E.00986
G1 X86.005 Y92.872 E.00986
G1 X85.739 Y92.46 E.00986
G1 X85.515 Y92.023 E.00987
G1 X85.336 Y91.567 E.00986
G1 X85.203 Y91.095 E.00986
G1 X85.118 Y90.612 E.00987
G1 X85.081 Y90.123 E.00986
G1 X85.094 Y89.632 E.00986
G1 X85.155 Y89.146 E.00986
G1 X85.264 Y88.667 E.00987
G1 X85.42 Y88.202 E.00986
G1 X85.622 Y87.755 E.00986
G1 X85.867 Y87.331 E.00986
G1 X86.153 Y86.932 E.00986
G1 X86.478 Y86.565 E.00986
G1 X86.837 Y86.231 E.00986
G1 X87.228 Y85.935 E.00987
G1 X87.647 Y85.679 E.00986
G1 X88.089 Y85.466 E.00987
G1 X88.55 Y85.299 E.00986
G1 X89.025 Y85.178 E.00986
G1 X89.505 Y85.105 E.00976
G1 X89.816 Y85.085 E.00627
G1 X90.246 Y85.086 E.00864
G1 X90.733 Y85.135 E.00984
G1 X91.214 Y85.232 E.00986
G1 X91.683 Y85.377 E.00987
G1 X92.135 Y85.567 E.00986
G1 X92.565 Y85.802 E.00987
G1 X92.971 Y86.078 E.00986
G1 X93.346 Y86.393 E.00986
G1 X93.689 Y86.744 E.00986
G1 X93.995 Y87.128 E.00986
G1 X94.261 Y87.54 E.00986
G1 X94.485 Y87.977 E.00987
G1 X94.664 Y88.433 E.00986
G1 X94.796 Y88.905 E.00986
G1 X94.882 Y89.388 E.00986
G1 X94.918 Y89.877 E.00986
G1 X94.906 Y90.368 E.00986
G1 X94.845 Y90.854 E.00986
G1 X94.736 Y91.333 E.00987
G1 X94.58 Y91.798 E.00986
G1 X94.412 Y92.169 E.0082
M204 S250
G1 X94.014 Y92.055 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1800
M204 S5000
G1 X94.013 Y92.058 E.00004
G1 X93.789 Y92.447 E.0084
G1 X93.527 Y92.811 E.00837
G1 X93.067 Y93.306 E.01263
G1 X92.723 Y93.595 E.00839
G1 X92.352 Y93.849 E.0084
G1 X91.957 Y94.064 E.0084
G1 X91.542 Y94.238 E.0084
G1 X91.113 Y94.371 E.0084
G1 X90.672 Y94.46 E.0084
G1 X90.225 Y94.505 E.0084
G1 X89.775 Y94.505 E.0084
G1 X89.328 Y94.46 E.0084
G1 X88.887 Y94.371 E.0084
G1 X88.457 Y94.238 E.0084
G1 X88.043 Y94.064 E.0084
G1 X87.648 Y93.848 E.00841
G1 X87.276 Y93.595 E.0084
G1 X86.932 Y93.306 E.0084
G1 X86.618 Y92.984 E.0084
G1 X86.338 Y92.633 E.0084
G1 X86.094 Y92.255 E.0084
G1 X85.889 Y91.855 E.0084
G1 X85.724 Y91.437 E.0084
G1 X85.603 Y91.004 E.0084
G1 X85.525 Y90.561 E.0084
G1 X85.491 Y90.112 E.0084
G1 X85.502 Y89.663 E.0084
G1 X85.558 Y89.217 E.0084
G1 X85.658 Y88.778 E.00841
G1 X85.801 Y88.352 E.0084
G1 X85.986 Y87.942 E.0084
G1 X86.211 Y87.553 E.0084
G1 X86.474 Y87.188 E.0084
G1 X86.771 Y86.851 E.0084
G1 X87.101 Y86.545 E.0084
G1 X87.459 Y86.273 E.00841
G1 X87.843 Y86.039 E.0084
G1 X88.248 Y85.844 E.00841
G1 X88.67 Y85.69 E.0084
G1 X89.106 Y85.579 E.0084
G1 X89.549 Y85.512 E.00837
G1 X90.225 Y85.495 E.01263
G1 X90.672 Y85.54 E.00839
G1 X91.113 Y85.629 E.0084
G1 X91.542 Y85.762 E.0084
G1 X91.957 Y85.936 E.0084
G1 X92.352 Y86.152 E.00841
G1 X92.723 Y86.405 E.0084
G1 X93.068 Y86.694 E.0084
G1 X93.381 Y87.016 E.0084
G1 X93.662 Y87.367 E.0084
G1 X93.906 Y87.745 E.0084
G1 X94.111 Y88.145 E.0084
G1 X94.275 Y88.563 E.0084
G1 X94.397 Y88.996 E.0084
G1 X94.475 Y89.439 E.0084
G1 X94.509 Y89.888 E.0084
G1 X94.497 Y90.337 E.0084
G1 X94.442 Y90.783 E.0084
G1 X94.342 Y91.222 E.0084
G1 X94.198 Y91.648 E.00841
G1 X94.039 Y92.001 E.00723
; WIPE_START
M204 S6000
G1 X94.013 Y92.058 E-.00889
G1 X93.789 Y92.447 E-.06408
G1 X93.527 Y92.811 E-.06384
G1 X93.067 Y93.306 E-.09633
G1 X92.789 Y93.54 E-.05186
; WIPE_END
G1 E-.015
M204 S10000
G1 X88.508 Y87.222 Z1.44 F18000
G1 X86.411 Y84.127 Z1.44
G1 Z1.04
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F3323
M204 S6000
G1 X87.013 Y83.799 E.01379
G1 X87.646 Y83.532 E.0138
G1 X88.302 Y83.33 E.0138
G1 X88.974 Y83.194 E.01379
G1 X89.657 Y83.126 E.0138
G1 X90.343 Y83.126 E.0138
G1 X90.732 Y83.165 E.00787
G1 X91.026 Y83.194 E.00593
G1 X91.698 Y83.33 E.01379
G1 X92.354 Y83.532 E.0138
G1 X92.986 Y83.799 E.0138
G1 X93.589 Y84.127 E.01379
G1 X94.156 Y84.514 E.0138
G1 X94.681 Y84.955 E.01379
G1 X95.16 Y85.446 E.0138
G1 X95.588 Y85.982 E.01379
G1 X95.96 Y86.559 E.0138
G1 X96.273 Y87.169 E.01379
G1 X96.524 Y87.808 E.0138
G1 X96.71 Y88.469 E.0138
G1 X96.829 Y89.144 E.01379
G1 X96.88 Y89.828 E.0138
G1 X96.863 Y90.514 E.01379
G1 X96.778 Y91.195 E.0138
G1 X96.625 Y91.864 E.01379
G1 X96.407 Y92.515 E.0138
G1 X96.125 Y93.14 E.01379
G1 X95.781 Y93.734 E.0138
G1 X95.381 Y94.291 E.0138
G1 X94.927 Y94.806 E.0138
G1 X94.424 Y95.272 E.01379
G1 X93.877 Y95.687 E.0138
G1 X93.292 Y96.045 E.0138
G1 X92.673 Y96.342 E.0138
G1 X92.028 Y96.577 E.0138
G1 X91.364 Y96.746 E.0138
G1 X90.685 Y96.849 E.0138
G1 X90 Y96.883 E.01379
G1 X89.315 Y96.849 E.01379
G1 X88.636 Y96.746 E.0138
G1 X87.971 Y96.577 E.0138
G1 X87.326 Y96.342 E.0138
G1 X86.708 Y96.045 E.0138
G1 X86.123 Y95.687 E.0138
G1 X85.576 Y95.272 E.0138
G1 X85.073 Y94.806 E.01379
G1 X84.619 Y94.291 E.0138
G1 X84.218 Y93.734 E.0138
G1 X83.875 Y93.14 E.01379
G1 X83.593 Y92.515 E.0138
G1 X83.374 Y91.864 E.0138
G1 X83.222 Y91.195 E.01379
G1 X83.136 Y90.514 E.0138
G1 X83.119 Y89.828 E.01379
G1 X83.171 Y89.144 E.0138
G1 X83.29 Y88.469 E.01379
G1 X83.476 Y87.808 E.0138
G1 X83.726 Y87.169 E.0138
G1 X84.039 Y86.559 E.01379
G1 X84.411 Y85.982 E.0138
G1 X84.839 Y85.446 E.0138
G1 X85.318 Y84.955 E.0138
G1 X85.844 Y84.514 E.01379
G1 X86.361 Y84.161 E.01259
M204 S10000
G1 X86.19 Y83.765 F18000
G1 F3323
M204 S6000
G1 X86.829 Y83.416 E.01464
G1 X87.501 Y83.133 E.01465
G1 X88.197 Y82.918 E.01465
G1 X88.911 Y82.774 E.01465
G1 X89.636 Y82.702 E.01465
G1 X90.364 Y82.702 E.01465
G1 X90.774 Y82.743 E.00829
G1 X91.089 Y82.774 E.00635
G1 X91.803 Y82.918 E.01465
G1 X92.499 Y83.133 E.01465
G1 X93.171 Y83.416 E.01465
G1 X93.81 Y83.765 E.01464
G1 X94.412 Y84.175 E.01465
G1 X94.97 Y84.643 E.01465
G1 X95.479 Y85.165 E.01465
G1 X95.933 Y85.734 E.01465
G1 X96.328 Y86.346 E.01465
G1 X96.661 Y86.994 E.01464
G1 X96.927 Y87.673 E.01465
G1 X97.124 Y88.374 E.01465
G1 X97.251 Y89.091 E.01465
G1 X97.305 Y89.818 E.01465
G1 X97.287 Y90.546 E.01464
G1 X97.196 Y91.269 E.01465
G1 X97.034 Y91.979 E.01465
G1 X96.802 Y92.67 E.01465
G1 X96.503 Y93.334 E.01465
G1 X96.138 Y93.965 E.01465
G1 X95.713 Y94.556 E.01465
G1 X95.231 Y95.102 E.01465
G1 X94.697 Y95.598 E.01465
G1 X94.116 Y96.038 E.01465
G1 X93.495 Y96.418 E.01465
G1 X92.838 Y96.734 E.01465
G1 X92.154 Y96.983 E.01465
G1 X91.448 Y97.163 E.01465
G1 X90.727 Y97.271 E.01465
G1 X90 Y97.308 E.01465
G1 X89.272 Y97.271 E.01465
G1 X88.552 Y97.163 E.01465
G1 X87.846 Y96.983 E.01465
G1 X87.161 Y96.734 E.01465
G1 X86.505 Y96.418 E.01465
G1 X85.883 Y96.038 E.01465
G1 X85.303 Y95.598 E.01465
G1 X84.769 Y95.102 E.01465
G1 X84.287 Y94.556 E.01465
G1 X83.861 Y93.965 E.01465
G1 X83.497 Y93.334 E.01465
G1 X83.197 Y92.67 E.01465
G1 X82.965 Y91.979 E.01465
G1 X82.803 Y91.269 E.01465
G1 X82.713 Y90.546 E.01465
G1 X82.695 Y89.818 E.01464
G1 X82.749 Y89.091 E.01465
G1 X82.876 Y88.374 E.01465
G1 X83.073 Y87.673 E.01465
G1 X83.339 Y86.995 E.01465
G1 X83.671 Y86.346 E.01465
G1 X84.067 Y85.734 E.01465
G1 X84.521 Y85.165 E.01465
G1 X85.03 Y84.643 E.01465
G1 X85.587 Y84.175 E.01465
G1 X86.14 Y83.798 E.01345
M204 S250
G1 X85.971 Y83.418 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1800
M204 S5000
G1 X85.976 Y83.415 E.0001
G1 X86.651 Y83.047 E.01437
G1 X87.36 Y82.748 E.01438
G1 X88.096 Y82.521 E.01438
G1 X88.85 Y82.369 E.01438
G1 X89.615 Y82.292 E.01438
G1 X90.384 Y82.292 E.01437
G1 X90.815 Y82.335 E.00809
G1 X91.15 Y82.369 E.00629
G1 X91.904 Y82.521 E.01438
G1 X92.639 Y82.748 E.01438
G1 X93.348 Y83.047 E.01438
G1 X94.024 Y83.415 E.01437
G1 X94.66 Y83.848 E.01438
G1 X95.249 Y84.343 E.01437
G1 X95.786 Y84.894 E.01438
G1 X96.266 Y85.495 E.01437
G1 X96.683 Y86.141 E.01438
G1 X97.034 Y86.826 E.01437
G1 X97.315 Y87.542 E.01437
G1 X97.524 Y88.283 E.01438
G1 X97.657 Y89.04 E.01437
G1 X97.715 Y89.808 E.01438
G1 X97.695 Y90.577 E.01437
G1 X97.6 Y91.34 E.01438
G1 X97.429 Y92.09 E.01437
G1 X97.184 Y92.82 E.01438
G1 X96.867 Y93.521 E.01437
G1 X96.482 Y94.187 E.01438
G1 X96.033 Y94.812 E.01437
G1 X95.524 Y95.388 E.01438
G1 X94.96 Y95.912 E.01438
G1 X94.347 Y96.376 E.01438
G1 X93.691 Y96.777 E.01438
G1 X92.997 Y97.111 E.01438
G1 X92.274 Y97.374 E.01438
G1 X91.529 Y97.564 E.01437
G1 X90.768 Y97.679 E.01438
G1 X90 Y97.717 E.01438
G1 X89.231 Y97.679 E.01438
G1 X88.471 Y97.564 E.01438
G1 X87.725 Y97.374 E.01437
G1 X87.002 Y97.111 E.01438
G1 X86.309 Y96.777 E.01438
G1 X85.653 Y96.376 E.01438
G1 X85.039 Y95.912 E.01438
G1 X84.475 Y95.388 E.01438
G1 X83.966 Y94.812 E.01438
G1 X83.517 Y94.187 E.01438
G1 X83.132 Y93.521 E.01438
G1 X82.816 Y92.82 E.01437
G1 X82.571 Y92.09 E.01438
G1 X82.4 Y91.34 E.01437
G1 X82.304 Y90.577 E.01438
G1 X82.285 Y89.808 E.01437
G1 X82.342 Y89.04 E.01438
G1 X82.476 Y88.283 E.01437
G1 X82.684 Y87.542 E.01438
G1 X82.965 Y86.826 E.01437
G1 X83.317 Y86.141 E.01438
G1 X83.734 Y85.495 E.01437
G1 X84.214 Y84.894 E.01438
G1 X84.751 Y84.343 E.01438
G1 X85.34 Y83.848 E.01437
G1 X85.922 Y83.452 E.01315
; WIPE_START
M204 S6000
G1 X85.976 Y83.415 E-.00933
G1 X86.651 Y83.047 E-.10961
G1 X87.36 Y82.748 E-.10964
G1 X87.739 Y82.631 E-.05642
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
G1 X0 Y90.0001 ; move to safe pos
M73 P65 R4
G1 X-13.0 F3000 ; move to safe pos
M400
M1004 S5 P1  ; external shutter
M400 P300
M971 S11 C11 O0
G92 E0
G1 X0 F18000
M623

; SKIPTYPE: head_wrap_detect
M622.1 S1
M1002 judge_flag g39_3rd_layer_detect_flag
M622 J1
    ; enable nozzle clog detect at 3rd layer
    


    M622.1 S1
    M1002 judge_flag g39_detection_flag
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




G1 X89.062 Y83.682
G1 Z1.04
G1 E.3 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.584132
G1 F3323
M204 S6000
G1 X88.437 Y83.805 E.01685
G1 X87.828 Y83.991 E.01687
G1 X87.24 Y84.237 E.01686
G1 X86.68 Y84.541 E.01685
G1 X86.153 Y84.898 E.01686
G1 X85.664 Y85.307 E.01686
G1 X85.218 Y85.762 E.01685
G1 X84.82 Y86.259 E.01687
G1 X84.473 Y86.793 E.01686
G1 X84.182 Y87.359 E.01685
G1 X83.948 Y87.952 E.01686
G1 X83.774 Y88.565 E.01686
G1 X83.662 Y89.192 E.01685
G1 X83.613 Y89.827 E.01686
G1 X83.627 Y90.464 E.01686
G1 X83.705 Y91.096 E.01685
G1 X83.845 Y91.717 E.01686
G1 X84.047 Y92.321 E.01686
G1 X84.308 Y92.902 E.01685
G1 X84.625 Y93.455 E.01686
G1 X84.996 Y93.973 E.01686
G1 X85.416 Y94.451 E.01685
G1 X85.882 Y94.886 E.01686
G1 X86.389 Y95.271 E.01686
G1 X86.932 Y95.605 E.01686
G1 X87.505 Y95.882 E.01685
G1 X88.103 Y96.102 E.01687
G1 X88.72 Y96.26 E.01685
G1 X89.35 Y96.356 E.01686
G1 X89.986 Y96.389 E.01685
G1 X90.622 Y96.359 E.01685
G1 X91.252 Y96.266 E.01686
G1 X91.87 Y96.11 E.01685
G1 X92.469 Y95.893 E.01687
G1 X93.043 Y95.618 E.01685
G1 X93.587 Y95.287 E.01686
G1 X94.096 Y94.904 E.01686
G1 X94.563 Y94.47 E.01685
G1 X94.967 Y94.019 E.01603
G1 X95.345 Y93.502 E.01694
G1 X95.667 Y92.952 E.01686
G1 X95.933 Y92.373 E.01686
G1 X96.14 Y91.771 E.01687
G1 X96.286 Y91.15 E.01686
G1 X96.369 Y90.519 E.01686
G1 X96.389 Y89.855 E.01759
G1 X96.345 Y89.247 E.01613
G1 X96.239 Y88.618 E.01687
G1 X96.07 Y88.004 E.01685
G1 X95.842 Y87.41 E.01685
G1 X95.554 Y86.841 E.01687
G1 X95.212 Y86.304 E.01685
G1 X94.818 Y85.803 E.01686
G1 X94.377 Y85.344 E.01685
G1 X93.891 Y84.931 E.01687
G1 X93.367 Y84.569 E.01685
G1 X92.81 Y84.261 E.01686
G1 X92.224 Y84.01 E.01686
G1 X91.617 Y83.818 E.01686
G1 X90.993 Y83.688 E.01686
G1 X90.362 Y83.62 E.01681
G1 X89.798 Y83.616 E.01491
G1 X89.121 Y83.677 E.01799
; WIPE_START
G1 F4800
G1 X89.798 Y83.616 E-.09685
G1 X90.362 Y83.62 E-.08028
G1 X90.993 Y83.688 E-.09051
G1 X91.113 Y83.713 E-.01736
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X93.269 Y91.034 Z1.44 F18000
G1 X94.164 Y94.072 Z1.44
G1 Z1.04
G1 E.3 F1800
; LINE_WIDTH: 0.581688
G1 F3323
M204 S6000
G1 X93.747 Y94.466 E.01512
G1 X93.284 Y94.817 E.01532
G1 X92.788 Y95.12 E.01531
G1 X92.265 Y95.372 E.01531
G1 X91.718 Y95.571 E.01533
G1 X91.155 Y95.715 E.01531
G1 X90.58 Y95.801 E.01532
G1 X90 Y95.83 E.01531
G1 X89.419 Y95.801 E.01531
G1 X88.845 Y95.714 E.01532
G1 X88.282 Y95.571 E.01531
G1 X87.735 Y95.372 E.01533
G1 X87.212 Y95.12 E.01531
G1 X86.716 Y94.817 E.01531
G1 X86.252 Y94.466 E.01532
G1 X85.826 Y94.071 E.01532
G1 X85.635 Y93.87 E.00729
G1 X85.272 Y93.416 E.01533
G1 X84.955 Y92.929 E.01531
G1 X84.688 Y92.411 E.01534
G1 X84.475 Y91.871 E.01531
G1 X84.316 Y91.312 E.01532
G1 X84.214 Y90.739 E.01533
G1 X84.169 Y90.159 E.01532
G1 X84.182 Y89.578 E.01532
G1 X84.253 Y89.001 E.01533
G1 X84.381 Y88.433 E.01533
G1 X84.565 Y87.882 E.01532
G1 X84.803 Y87.351 E.01533
G1 X85.092 Y86.847 E.01532
G1 X85.431 Y86.374 E.01531
G1 X85.814 Y85.937 E.01533
G1 X86.24 Y85.54 E.01532
G1 X86.702 Y85.188 E.01533
G1 X87.198 Y84.884 E.01532
G1 X87.722 Y84.63 E.01533
G1 X88.267 Y84.43 E.01532
G1 X88.831 Y84.285 E.01533
G1 X89.728 Y84.175 E.02381
G1 X90.28 Y84.172 E.01455
G1 X90.856 Y84.228 E.01525
G1 X91.426 Y84.342 E.01532
G1 X91.982 Y84.512 E.01533
G1 X92.519 Y84.737 E.01533
G1 X93.031 Y85.014 E.01533
G1 X93.512 Y85.34 E.01532
G1 X93.958 Y85.713 E.01533
G1 X94.365 Y86.129 E.01532
G1 X94.729 Y86.583 E.01533
G1 X95.046 Y87.07 E.01532
G1 X95.313 Y87.588 E.01534
G1 X95.526 Y88.128 E.01532
G1 X95.685 Y88.688 E.01532
G1 X95.788 Y89.261 E.01533
G1 X95.832 Y89.841 E.01532
G1 X95.819 Y90.422 E.01532
G1 X95.748 Y90.999 E.01533
G1 X95.62 Y91.567 E.01533
G1 X95.436 Y92.119 E.01534
G1 X95.198 Y92.65 E.01532
G1 X94.909 Y93.154 E.01533
G1 X94.576 Y93.619 E.01506
G1 X94.205 Y94.028 E.01455
; CHANGE_LAYER
; Z_HEIGHT: 1.16
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F4800
G1 X94.576 Y93.619 E-.07867
G1 X94.909 Y93.154 E-.08147
G1 X95.198 Y92.65 E-.0829
G1 X95.319 Y92.381 E-.04196
; WIPE_END
G1 E-.015 F1800
; layer num/total_layer_count: 9/33
; update layer progress
M73 L9
M991 S0 P8 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z1.44 I-.044 J-1.216 P1  F18000
G1 X94.773 Y92.4 Z1.44
G1 Z1.16
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F3237
M204 S6000
G1 X94.756 Y92.439 E.00084
G1 X94.49 Y92.9 E.01071
G1 X94.183 Y93.326 E.01056
G1 X93.954 Y93.593 E.00706
G1 X93.634 Y93.919 E.00919
G1 X93.227 Y94.26 E.01067
G1 X92.787 Y94.561 E.01072
G1 X92.319 Y94.815 E.01071
G1 X91.828 Y95.022 E.01071
G1 X91.319 Y95.18 E.01072
G1 X90.796 Y95.285 E.01071
G1 X90.266 Y95.338 E.01071
G1 X89.733 Y95.338 E.01071
G1 X89.203 Y95.285 E.01071
G1 X88.681 Y95.18 E.01071
G1 X88.172 Y95.022 E.01072
G1 X87.681 Y94.816 E.01071
G1 X87.213 Y94.561 E.01071
G1 X86.773 Y94.261 E.01071
G1 X86.364 Y93.918 E.01072
G1 X85.992 Y93.537 E.01071
G1 X85.66 Y93.12 E.01071
G1 X85.371 Y92.672 E.01072
G1 X85.128 Y92.198 E.01072
G1 X84.933 Y91.702 E.01071
G1 X84.789 Y91.19 E.01071
G1 X84.697 Y90.665 E.01072
G1 X84.657 Y90.133 E.01071
G1 X84.67 Y89.601 E.01071
G1 X84.736 Y89.072 E.01071
G1 X84.855 Y88.552 E.01072
G1 X85.024 Y88.047 E.01071
G1 X85.244 Y87.562 E.01072
G1 X85.51 Y87.1 E.01071
G1 X85.821 Y86.667 E.01072
G1 X86.174 Y86.268 E.01071
G1 X86.564 Y85.906 E.01072
G1 X86.989 Y85.584 E.01071
G1 X87.444 Y85.306 E.01072
G1 X87.924 Y85.075 E.01071
G1 X88.424 Y84.893 E.01071
G1 X88.941 Y84.761 E.01072
G1 X89.46 Y84.683 E.01056
G1 X89.811 Y84.66 E.00706
G1 X90.268 Y84.662 E.0092
G1 X90.796 Y84.715 E.01067
G1 X91.319 Y84.82 E.01071
G1 X91.828 Y84.978 E.01072
G1 X92.319 Y85.185 E.01071
G1 X92.787 Y85.439 E.01071
G1 X93.227 Y85.739 E.01071
G1 X93.635 Y86.082 E.01072
G1 X94.007 Y86.463 E.01071
G1 X94.339 Y86.88 E.01072
G1 X94.628 Y87.328 E.01071
G1 X94.872 Y87.802 E.01072
G1 X95.066 Y88.298 E.01071
G1 X95.211 Y88.81 E.0107
G1 X95.303 Y89.335 E.01072
G1 X95.343 Y89.867 E.01071
G1 X95.33 Y90.399 E.01071
G1 X95.263 Y90.928 E.01071
G1 X95.145 Y91.448 E.01072
G1 X94.975 Y91.953 E.01071
G1 X94.798 Y92.346 E.00867
M204 S10000
G1 X94.386 Y92.226 F18000
G1 F3237
M204 S6000
G1 X94.378 Y92.245 E.00041
G1 X94.133 Y92.669 E.00986
G1 X93.849 Y93.064 E.00977
G1 X93.642 Y93.306 E.00641
G1 X93.345 Y93.607 E.0085
G1 X92.971 Y93.922 E.00984
G1 X92.565 Y94.198 E.00986
G1 X92.135 Y94.433 E.00986
G1 X91.683 Y94.623 E.00986
G1 X91.214 Y94.768 E.00987
G1 X90.733 Y94.865 E.00986
G1 X90.245 Y94.914 E.00986
G1 X89.755 Y94.914 E.00986
G1 X89.267 Y94.865 E.00986
G1 X88.786 Y94.768 E.00986
G1 X88.317 Y94.623 E.00987
G1 X87.865 Y94.433 E.00986
G1 X87.434 Y94.198 E.00986
G1 X87.029 Y93.922 E.00986
G1 X86.653 Y93.607 E.00987
G1 X86.311 Y93.256 E.00986
G1 X86.005 Y92.872 E.00986
G1 X85.739 Y92.46 E.00986
G1 X85.515 Y92.023 E.00986
G1 X85.336 Y91.567 E.00986
G1 X85.203 Y91.095 E.00986
G1 X85.118 Y90.612 E.00987
G1 X85.081 Y90.123 E.00986
G1 X85.094 Y89.632 E.00986
G1 X85.155 Y89.146 E.00986
G1 X85.264 Y88.667 E.00987
G1 X85.42 Y88.203 E.00986
G1 X85.622 Y87.755 E.00986
G1 X85.867 Y87.331 E.00986
G1 X86.153 Y86.932 E.00987
G1 X86.478 Y86.565 E.00986
G1 X86.837 Y86.231 E.00986
G1 X87.228 Y85.935 E.00986
G1 X87.647 Y85.679 E.00987
G1 X88.089 Y85.466 E.00986
G1 X88.55 Y85.299 E.00986
G1 X89.025 Y85.178 E.00987
G1 X89.506 Y85.105 E.00977
G1 X89.823 Y85.085 E.00641
G1 X90.246 Y85.086 E.0085
G1 X90.733 Y85.135 E.00984
G1 X91.214 Y85.232 E.00986
G1 X91.683 Y85.377 E.00987
G1 X92.135 Y85.567 E.00986
G1 X92.565 Y85.802 E.00986
G1 X92.97 Y86.078 E.00986
G1 X93.346 Y86.393 E.00987
G1 X93.689 Y86.744 E.00986
G1 X93.995 Y87.128 E.00986
G1 X94.261 Y87.54 E.00986
G1 X94.484 Y87.977 E.00986
G1 X94.664 Y88.433 E.00986
G1 X94.796 Y88.905 E.00985
G1 X94.882 Y89.388 E.00987
G1 X94.918 Y89.877 E.00986
G1 X94.906 Y90.368 E.00986
G1 X94.845 Y90.854 E.00986
G1 X94.736 Y91.333 E.00987
G1 X94.58 Y91.798 E.00986
G1 X94.411 Y92.171 E.00824
M204 S250
G1 X94.013 Y92.058 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1800
M204 S5000
G1 X93.788 Y92.447 E.0084
G1 X93.527 Y92.811 E.00837
G1 X93.067 Y93.307 E.01263
G1 X92.723 Y93.595 E.00839
G1 X92.352 Y93.849 E.0084
G1 X91.957 Y94.064 E.0084
G1 X91.543 Y94.238 E.0084
G1 X91.113 Y94.371 E.00841
G1 X90.672 Y94.46 E.0084
G1 X90.225 Y94.505 E.0084
G1 X89.775 Y94.505 E.0084
G1 X89.328 Y94.46 E.0084
G1 X88.887 Y94.371 E.0084
G1 X88.457 Y94.238 E.00841
G1 X88.043 Y94.064 E.0084
G1 X87.648 Y93.849 E.0084
G1 X87.277 Y93.595 E.0084
G1 X86.932 Y93.306 E.0084
G1 X86.618 Y92.984 E.0084
G1 X86.338 Y92.633 E.0084
G1 X86.094 Y92.255 E.0084
G1 X85.889 Y91.855 E.0084
G1 X85.724 Y91.436 E.0084
G1 X85.603 Y91.004 E.0084
G1 X85.525 Y90.561 E.0084
G1 X85.491 Y90.112 E.0084
G1 X85.502 Y89.663 E.0084
G1 X85.558 Y89.217 E.0084
G1 X85.658 Y88.778 E.00841
G1 X85.801 Y88.352 E.0084
G1 X85.986 Y87.942 E.0084
G1 X86.211 Y87.553 E.0084
G1 X86.474 Y87.188 E.0084
G1 X86.771 Y86.851 E.0084
G1 X87.101 Y86.545 E.0084
G1 X87.459 Y86.273 E.0084
G1 X87.843 Y86.039 E.00841
G1 X88.248 Y85.844 E.0084
G1 X88.67 Y85.69 E.0084
G1 X89.106 Y85.579 E.0084
G1 X89.549 Y85.512 E.00837
G1 X90.225 Y85.495 E.01263
G1 X90.672 Y85.54 E.00839
G1 X91.113 Y85.629 E.0084
G1 X91.543 Y85.762 E.00841
G1 X91.957 Y85.936 E.0084
G1 X92.352 Y86.151 E.0084
G1 X92.723 Y86.405 E.0084
G1 X93.068 Y86.694 E.0084
G1 X93.381 Y87.016 E.0084
G1 X93.662 Y87.367 E.0084
G1 X93.906 Y87.745 E.0084
G1 X94.111 Y88.145 E.0084
G1 X94.275 Y88.564 E.0084
G1 X94.397 Y88.996 E.0084
G1 X94.475 Y89.439 E.0084
G1 X94.509 Y89.888 E.0084
G1 X94.497 Y90.337 E.0084
G1 X94.442 Y90.783 E.0084
G1 X94.342 Y91.222 E.0084
G1 X94.198 Y91.648 E.00841
G1 X94.038 Y92.003 E.00728
; WIPE_START
M204 S6000
G1 X93.788 Y92.447 E-.07258
G1 X93.527 Y92.811 E-.06386
G1 X93.067 Y93.307 E-.09632
G1 X92.786 Y93.542 E-.05225
; WIPE_END
G1 E-.015
M204 S10000
G1 X88.503 Y87.225 Z1.56 F18000
G1 X86.497 Y84.268 Z1.56
G1 Z1.16
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F3237
M204 S6000
G1 X87.085 Y83.948 E.01346
G1 X87.702 Y83.687 E.01346
G1 X88.342 Y83.49 E.01347
G1 X88.999 Y83.357 E.01346
G1 X89.665 Y83.291 E.01347
G1 X90.335 Y83.291 E.01346
G1 X90.533 Y83.311 E.00402
G1 X91.001 Y83.357 E.00945
G1 X91.657 Y83.49 E.01346
G1 X92.297 Y83.687 E.01347
G1 X92.915 Y83.948 E.01347
G1 X93.503 Y84.268 E.01346
G1 X94.056 Y84.645 E.01347
G1 X94.569 Y85.076 E.01346
G1 X95.037 Y85.555 E.01347
G1 X95.454 Y86.079 E.01346
G1 X95.818 Y86.641 E.01347
G1 X96.123 Y87.237 E.01346
G1 X96.368 Y87.86 E.01346
G1 X96.549 Y88.505 E.01347
G1 X96.665 Y89.165 E.01347
G1 X96.715 Y89.833 E.01347
G1 X96.699 Y90.502 E.01346
G1 X96.615 Y91.167 E.01347
G1 X96.467 Y91.819 E.01346
G1 X96.253 Y92.454 E.01347
G1 X95.978 Y93.065 E.01346
G1 X95.643 Y93.645 E.01347
G1 X95.252 Y94.188 E.01346
G1 X94.809 Y94.691 E.01347
G1 X94.318 Y95.146 E.01347
G1 X93.784 Y95.55 E.01347
G1 X93.213 Y95.9 E.01346
G1 X92.609 Y96.19 E.01347
G1 X91.98 Y96.419 E.01346
G1 X91.331 Y96.585 E.01346
G1 X90.669 Y96.684 E.01347
G1 X90 Y96.718 E.01346
G1 X89.331 Y96.684 E.01346
G1 X88.669 Y96.585 E.01347
G1 X88.02 Y96.419 E.01346
G1 X87.39 Y96.19 E.01347
G1 X86.787 Y95.9 E.01347
G1 X86.216 Y95.55 E.01347
G1 X85.682 Y95.146 E.01346
G1 X85.191 Y94.691 E.01347
G1 X84.748 Y94.188 E.01346
G1 X84.357 Y93.645 E.01347
G1 X84.022 Y93.065 E.01347
G1 X83.746 Y92.454 E.01346
G1 X83.533 Y91.819 E.01347
G1 X83.384 Y91.167 E.01346
G1 X83.301 Y90.502 E.01347
G1 X83.284 Y89.833 E.01346
G1 X83.334 Y89.165 E.01347
G1 X83.451 Y88.505 E.01347
G1 X83.632 Y87.86 E.01347
G1 X83.877 Y87.237 E.01347
G1 X84.182 Y86.641 E.01346
G1 X84.545 Y86.079 E.01347
G1 X84.963 Y85.555 E.01347
G1 X85.431 Y85.076 E.01346
G1 X85.944 Y84.645 E.01347
G1 X86.447 Y84.302 E.01226
M204 S10000
G1 X86.276 Y83.905 F18000
G1 F3237
M204 S6000
G1 X86.901 Y83.565 E.01432
G1 X87.557 Y83.288 E.01432
G1 X88.237 Y83.078 E.01432
G1 X88.935 Y82.937 E.01432
G1 X89.644 Y82.866 E.01432
G1 X90.356 Y82.866 E.01432
G1 X90.576 Y82.888 E.00444
G1 X91.064 Y82.937 E.00988
G1 X91.762 Y83.078 E.01432
G1 X92.443 Y83.288 E.01432
G1 X93.099 Y83.565 E.01432
G1 X93.724 Y83.905 E.01432
G1 X94.313 Y84.307 E.01432
G1 X94.858 Y84.764 E.01432
G1 X95.355 Y85.274 E.01432
G1 X95.799 Y85.831 E.01432
G1 X96.185 Y86.429 E.01432
G1 X96.51 Y87.062 E.01432
G1 X96.77 Y87.725 E.01432
G1 X96.963 Y88.411 E.01432
G1 X97.087 Y89.112 E.01432
M73 P66 R4
G1 X97.14 Y89.822 E.01432
G1 X97.122 Y90.534 E.01431
G1 X97.034 Y91.24 E.01432
G1 X96.875 Y91.934 E.01431
G1 X96.649 Y92.61 E.01432
G1 X96.356 Y93.258 E.01431
G1 X96 Y93.875 E.01432
G1 X95.584 Y94.453 E.01431
G1 X95.113 Y94.987 E.01432
G1 X94.591 Y95.471 E.01432
G1 X94.023 Y95.901 E.01432
G1 X93.416 Y96.273 E.01432
G1 X92.774 Y96.582 E.01432
G1 X92.105 Y96.825 E.01432
G1 X91.415 Y97.001 E.01432
G1 X90.711 Y97.107 E.01432
G1 X90 Y97.143 E.01432
G1 X89.289 Y97.107 E.01432
G1 X88.585 Y97.001 E.01432
G1 X87.895 Y96.825 E.01432
G1 X87.225 Y96.582 E.01432
G1 X86.584 Y96.273 E.01432
G1 X85.976 Y95.901 E.01432
G1 X85.409 Y95.472 E.01432
G1 X84.887 Y94.987 E.01432
G1 X84.416 Y94.453 E.01432
G1 X84 Y93.875 E.01432
G1 X83.644 Y93.258 E.01432
G1 X83.351 Y92.61 E.01432
G1 X83.124 Y91.934 E.01432
G1 X82.966 Y91.24 E.01432
G1 X82.877 Y90.534 E.01432
G1 X82.86 Y89.822 E.01431
G1 X82.913 Y89.112 E.01432
G1 X83.036 Y88.411 E.01432
G1 X83.229 Y87.725 E.01432
G1 X83.489 Y87.062 E.01432
G1 X83.814 Y86.429 E.01432
G1 X84.201 Y85.831 E.01432
G1 X84.645 Y85.274 E.01432
G1 X85.142 Y84.764 E.01432
G1 X85.687 Y84.307 E.01432
G1 X86.226 Y83.939 E.01311
M204 S250
G1 X86.062 Y83.556 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1800
M204 S5000
G1 X86.723 Y83.196 E.01406
G1 X87.417 Y82.903 E.01407
G1 X88.136 Y82.681 E.01407
G1 X88.874 Y82.532 E.01407
G1 X89.623 Y82.457 E.01407
G1 X90.376 Y82.457 E.01407
G1 X90.616 Y82.481 E.00451
G1 X91.125 Y82.532 E.00956
G1 X91.863 Y82.681 E.01407
G1 X92.583 Y82.903 E.01407
G1 X93.277 Y83.196 E.01407
G1 X93.938 Y83.556 E.01407
G1 X94.56 Y83.98 E.01407
G1 X95.137 Y84.464 E.01407
G1 X95.662 Y85.003 E.01407
G1 X96.132 Y85.591 E.01407
G1 X96.54 Y86.224 E.01407
G1 X96.884 Y86.894 E.01407
G1 X97.159 Y87.595 E.01407
G1 X97.363 Y88.319 E.01407
G1 X97.493 Y89.061 E.01407
G1 X97.55 Y89.812 E.01407
G1 X97.531 Y90.564 E.01407
G1 X97.437 Y91.312 E.01407
G1 X97.27 Y92.045 E.01407
G1 X97.03 Y92.759 E.01407
G1 X96.72 Y93.445 E.01407
G1 X96.344 Y94.098 E.01407
G1 X95.904 Y94.709 E.01406
G1 X95.406 Y95.273 E.01407
G1 X94.854 Y95.785 E.01407
G1 X94.254 Y96.24 E.01407
G1 X93.612 Y96.633 E.01407
G1 X92.933 Y96.959 E.01407
G1 X92.226 Y97.217 E.01407
G1 X91.496 Y97.403 E.01407
G1 X90.752 Y97.515 E.01407
G1 X90 Y97.552 E.01407
G1 X89.248 Y97.515 E.01407
G1 X88.503 Y97.403 E.01407
G1 X87.774 Y97.217 E.01407
G1 X87.066 Y96.959 E.01407
G1 X86.388 Y96.633 E.01407
G1 X85.745 Y96.24 E.01407
G1 X85.145 Y95.785 E.01407
G1 X84.593 Y95.273 E.01407
G1 X84.095 Y94.709 E.01407
G1 X83.656 Y94.097 E.01407
G1 X83.279 Y93.445 E.01407
G1 X82.97 Y92.759 E.01407
G1 X82.73 Y92.045 E.01407
G1 X82.562 Y91.311 E.01407
G1 X82.469 Y90.564 E.01407
G1 X82.45 Y89.812 E.01407
G1 X82.506 Y89.061 E.01407
G1 X82.637 Y88.319 E.01407
G1 X82.841 Y87.595 E.01407
G1 X83.116 Y86.894 E.01407
G1 X83.459 Y86.224 E.01407
G1 X83.868 Y85.591 E.01407
G1 X84.337 Y85.003 E.01407
G1 X84.863 Y84.464 E.01407
G1 X85.44 Y83.98 E.01407
G1 X86.012 Y83.589 E.01295
; WIPE_START
M204 S6000
G1 X86.723 Y83.196 E-.11577
G1 X87.417 Y82.903 E-.1073
G1 X87.832 Y82.775 E-.06193
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
G1 X0 Y90.0001 ; move to safe pos
G1 X-13.0 F3000 ; move to safe pos
M400
M1004 S5 P1  ; external shutter
M400 P300
M971 S11 C11 O0
G92 E0
G1 X0 F18000
M623

; SKIPTYPE: head_wrap_detect
M622.1 S1
M1002 judge_flag g39_3rd_layer_detect_flag
M622 J1
    ; enable nozzle clog detect at 3rd layer
    


    M622.1 S1
    M1002 judge_flag g39_detection_flag
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




G1 X89.078 Y83.805
G1 Z1.16
G1 E.3 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.501703
G1 F3237
M204 S6000
G1 X88.465 Y83.925 E.01408
G1 X87.868 Y84.108 E.0141
G1 X87.292 Y84.35 E.01409
G1 X86.743 Y84.647 E.01409
G1 X86.226 Y84.998 E.0141
G1 X85.747 Y85.399 E.01409
G1 X85.31 Y85.845 E.01408
G1 X84.919 Y86.333 E.0141
G1 X84.579 Y86.857 E.01409
G1 X84.293 Y87.412 E.01408
G1 X84.064 Y87.993 E.01409
G1 X83.894 Y88.594 E.01409
G1 X83.784 Y89.209 E.01409
G1 X83.736 Y89.832 E.0141
G1 X83.751 Y90.456 E.01409
G1 X83.827 Y91.076 E.01409
G1 X83.965 Y91.686 E.01409
G1 X84.163 Y92.278 E.01409
G1 X84.419 Y92.848 E.01409
G1 X84.73 Y93.39 E.0141
G1 X85.094 Y93.897 E.01409
G1 X85.506 Y94.366 E.01408
G1 X85.963 Y94.792 E.0141
G1 X86.46 Y95.17 E.01408
G1 X86.993 Y95.497 E.0141
G1 X87.555 Y95.769 E.01409
G1 X88.142 Y95.984 E.0141
G1 X88.746 Y96.139 E.01408
G1 X89.364 Y96.234 E.0141
G1 X89.988 Y96.266 E.01409
G1 X90.612 Y96.236 E.01409
G1 X91.23 Y96.144 E.0141
G1 X91.835 Y95.991 E.01409
G1 X92.423 Y95.778 E.01409
G1 X92.986 Y95.508 E.01409
G1 X93.52 Y95.184 E.01409
G1 X94.018 Y94.808 E.01408
G1 X94.476 Y94.382 E.0141
G1 X94.875 Y93.936 E.0135
G1 X95.245 Y93.43 E.01414
G1 X95.56 Y92.891 E.01409
G1 X95.82 Y92.322 E.0141
G1 X96.023 Y91.731 E.0141
G1 X96.165 Y91.123 E.01409
G1 X96.246 Y90.503 E.01409
G1 X96.266 Y89.856 E.01462
G1 X96.222 Y89.256 E.01356
G1 X96.117 Y88.64 E.0141
G1 X95.951 Y88.038 E.01408
G1 X95.726 Y87.455 E.01409
G1 X95.444 Y86.897 E.0141
G1 X95.109 Y86.371 E.01409
G1 X94.722 Y85.88 E.0141
G1 X94.288 Y85.43 E.01409
G1 X93.812 Y85.026 E.0141
G1 X93.297 Y84.671 E.01409
G1 X92.751 Y84.369 E.01409
G1 X92.176 Y84.124 E.01409
G1 X91.58 Y83.936 E.0141
G1 X90.969 Y83.809 E.01409
G1 X90.35 Y83.743 E.01404
G1 X89.806 Y83.739 E.01227
G1 X89.138 Y83.799 E.01513
; WIPE_START
G1 F4800
G1 X89.806 Y83.739 E-.09559
G1 X90.35 Y83.743 E-.0775
G1 X90.969 Y83.809 E-.0887
G1 X91.128 Y83.842 E-.02321
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X93.287 Y91.163 Z1.56 F18000
G1 X94.136 Y94.042 Z1.56
G1 Z1.16
G1 E.3 F1800
; LINE_WIDTH: 0.500368
G1 F3237
M204 S6000
G1 X93.721 Y94.435 E.01285
G1 X93.261 Y94.783 E.01298
G1 X92.768 Y95.084 E.01298
G1 X92.248 Y95.334 E.01298
G1 X91.706 Y95.532 E.01298
G1 X91.147 Y95.674 E.01298
G1 X90.576 Y95.76 E.01299
G1 X90 Y95.789 E.01298
G1 X89.424 Y95.76 E.01298
G1 X88.853 Y95.674 E.01299
G1 X88.294 Y95.532 E.01297
G1 X87.751 Y95.334 E.01299
G1 X87.231 Y95.084 E.01298
G1 X86.739 Y94.783 E.01299
G1 X86.279 Y94.435 E.01297
G1 X85.856 Y94.042 E.01299
G1 X85.474 Y93.609 E.01297
G1 X85.137 Y93.141 E.01298
G1 X84.848 Y92.641 E.01299
G1 X84.611 Y92.115 E.01298
G1 X84.427 Y91.568 E.01298
G1 X84.299 Y91.005 E.01299
G1 X84.227 Y90.433 E.01298
G1 X84.213 Y89.856 E.01298
G1 X84.256 Y89.28 E.01299
G1 X84.356 Y88.712 E.01298
G1 X84.427 Y88.42 E.00676
G1 X84.604 Y87.895 E.01246
G1 X84.84 Y87.368 E.01299
G1 X85.128 Y86.867 E.01299
G1 X85.464 Y86.398 E.01299
G1 X85.845 Y85.964 E.01299
G1 X86.268 Y85.571 E.01299
G1 X86.727 Y85.221 E.01299
G1 X87.22 Y84.919 E.01299
G1 X87.739 Y84.667 E.01299
G1 X88.281 Y84.469 E.01298
G1 X88.841 Y84.325 E.013
G1 X89.727 Y84.217 E.02008
G1 X90.28 Y84.213 E.01244
G1 X90.852 Y84.269 E.01292
G1 X91.418 Y84.383 E.01299
G1 X91.97 Y84.552 E.013
G1 X92.503 Y84.775 E.01299
G1 X93.011 Y85.05 E.01299
G1 X93.488 Y85.374 E.01299
G1 X93.932 Y85.745 E.013
G1 X94.336 Y86.158 E.01299
G1 X94.697 Y86.609 E.013
G1 X95.011 Y87.093 E.01298
G1 X95.276 Y87.607 E.013
G1 X95.488 Y88.144 E.01299
G1 X95.645 Y88.699 E.01298
G1 X95.747 Y89.268 E.013
G1 X95.791 Y89.844 E.01299
G1 X95.778 Y90.421 E.01299
G1 X95.707 Y90.994 E.01299
G1 X95.58 Y91.558 E.01299
G1 X95.397 Y92.106 E.013
G1 X95.161 Y92.633 E.013
G1 X94.873 Y93.134 E.01299
G1 X94.542 Y93.596 E.01278
G1 X94.176 Y93.998 E.01224
; CHANGE_LAYER
; Z_HEIGHT: 1.28
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F4800
G1 X94.542 Y93.596 E-.07751
G1 X94.873 Y93.134 E-.08098
G1 X95.161 Y92.633 E-.08228
G1 X95.288 Y92.35 E-.04423
; WIPE_END
G1 E-.015 F1800
; layer num/total_layer_count: 10/33
; update layer progress
M73 L10
M991 S0 P9 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z1.56 I-.271 J-1.186 P1  F18000
G1 X94.734 Y92.476 Z1.56
G1 Z1.28
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F3167
M204 S6000
G1 X94.49 Y92.9 E.00983
G1 X94.183 Y93.327 E.01058
G1 X93.949 Y93.598 E.00719
G1 X93.633 Y93.919 E.00906
G1 X93.227 Y94.261 E.01067
G1 X92.787 Y94.561 E.01071
G1 X92.319 Y94.815 E.01071
G1 X91.828 Y95.022 E.01072
G1 X91.319 Y95.18 E.01072
G1 X90.796 Y95.285 E.01071
G1 X90.266 Y95.338 E.01071
G1 X89.733 Y95.338 E.01071
G1 X89.203 Y95.285 E.01071
G1 X88.681 Y95.18 E.01071
G1 X88.172 Y95.022 E.01072
G1 X87.681 Y94.815 E.01071
G1 X87.213 Y94.561 E.01071
G1 X86.773 Y94.261 E.01071
G1 X86.364 Y93.918 E.01072
G1 X85.992 Y93.537 E.01071
G1 X85.66 Y93.12 E.01071
G1 X85.371 Y92.672 E.01072
G1 X85.128 Y92.198 E.01072
G1 X84.933 Y91.702 E.01072
G1 X84.789 Y91.189 E.01071
G1 X84.697 Y90.665 E.01072
G1 X84.657 Y90.133 E.01071
G1 X84.67 Y89.601 E.01071
G1 X84.736 Y89.072 E.01071
G1 X84.855 Y88.552 E.01072
G1 X85.025 Y88.047 E.01072
G1 X85.244 Y87.561 E.01071
G1 X85.51 Y87.1 E.01071
G1 X85.821 Y86.668 E.01071
G1 X86.174 Y86.268 E.01071
G1 X86.564 Y85.906 E.01071
G1 X86.989 Y85.584 E.01071
G1 X87.444 Y85.306 E.01072
G1 X87.924 Y85.075 E.01071
G1 X88.425 Y84.893 E.01071
G1 X88.941 Y84.761 E.01071
G1 X89.461 Y84.683 E.01058
G1 X89.818 Y84.66 E.00719
G1 X90.268 Y84.662 E.00906
G1 X90.796 Y84.715 E.01067
G1 X91.319 Y84.82 E.01071
G1 X91.828 Y84.978 E.01072
G1 X92.319 Y85.185 E.01071
G1 X92.787 Y85.439 E.01071
G1 X93.227 Y85.739 E.01071
G1 X93.635 Y86.082 E.01072
G1 X94.007 Y86.463 E.01071
G1 X94.339 Y86.88 E.01071
G1 X94.628 Y87.328 E.01071
G1 X94.872 Y87.802 E.01072
G1 X95.066 Y88.298 E.01071
G1 X95.211 Y88.81 E.01071
G1 X95.303 Y89.335 E.01072
G1 X95.343 Y89.867 E.01071
G1 X95.33 Y90.399 E.01071
G1 X95.263 Y90.928 E.01071
G1 X95.145 Y91.448 E.01072
G1 X94.975 Y91.953 E.01071
G1 X94.763 Y92.424 E.01039
M204 S10000
G1 X94.367 Y92.264 F18000
G1 F3167
M204 S6000
G1 X94.133 Y92.669 E.0094
G1 X93.849 Y93.064 E.00978
G1 X93.637 Y93.311 E.00654
G1 X93.345 Y93.607 E.00836
G1 X92.97 Y93.922 E.00984
G1 X92.565 Y94.198 E.00986
G1 X92.135 Y94.433 E.00986
G1 X91.683 Y94.623 E.00987
G1 X91.214 Y94.768 E.00986
G1 X90.733 Y94.865 E.00986
G1 X90.245 Y94.914 E.00986
G1 X89.755 Y94.914 E.00986
G1 X89.267 Y94.865 E.00986
G1 X88.786 Y94.768 E.00986
G1 X88.317 Y94.623 E.00987
G1 X87.865 Y94.433 E.00986
G1 X87.434 Y94.198 E.00986
G1 X87.029 Y93.922 E.00986
G1 X86.653 Y93.607 E.00986
G1 X86.311 Y93.256 E.00986
G1 X86.005 Y92.872 E.00986
G1 X85.739 Y92.46 E.00986
G1 X85.515 Y92.023 E.00987
G1 X85.336 Y91.567 E.00986
G1 X85.203 Y91.095 E.00986
G1 X85.118 Y90.612 E.00986
G1 X85.081 Y90.123 E.00986
G1 X85.094 Y89.632 E.00986
G1 X85.155 Y89.146 E.00986
G1 X85.264 Y88.667 E.00986
G1 X85.42 Y88.202 E.00987
G1 X85.622 Y87.755 E.00986
G1 X85.867 Y87.331 E.00986
G1 X86.153 Y86.932 E.00986
G1 X86.478 Y86.565 E.00986
G1 X86.837 Y86.231 E.00986
G1 X87.228 Y85.935 E.00986
G1 X87.647 Y85.679 E.00987
G1 X88.089 Y85.466 E.00986
G1 X88.55 Y85.299 E.00986
G1 X89.025 Y85.178 E.00986
G1 X89.506 Y85.105 E.00978
G1 X89.831 Y85.084 E.00654
G1 X90.246 Y85.086 E.00836
G1 X90.733 Y85.135 E.00983
G1 X91.214 Y85.232 E.00986
G1 X91.683 Y85.377 E.00987
G1 X92.135 Y85.567 E.00986
G1 X92.565 Y85.802 E.00986
G1 X92.97 Y86.078 E.00986
G1 X93.346 Y86.393 E.00986
G1 X93.689 Y86.744 E.00986
G1 X93.995 Y87.128 E.00986
G1 X94.261 Y87.54 E.00986
G1 X94.484 Y87.977 E.00987
G1 X94.664 Y88.433 E.00986
G1 X94.796 Y88.905 E.00986
G1 X94.882 Y89.388 E.00987
G1 X94.918 Y89.877 E.00986
G1 X94.906 Y90.368 E.00986
G1 X94.845 Y90.854 E.00986
G1 X94.736 Y91.333 E.00987
G1 X94.58 Y91.797 E.00986
G1 X94.393 Y92.211 E.00911
M204 S250
G1 X94.012 Y92.06 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1800
M204 S5000
G1 X93.789 Y92.447 E.00836
G1 X93.527 Y92.811 E.00838
G1 X93.067 Y93.307 E.01263
G1 X92.723 Y93.595 E.0084
G1 X92.352 Y93.848 E.0084
G1 X91.957 Y94.064 E.0084
G1 X91.542 Y94.238 E.0084
G1 X91.113 Y94.371 E.0084
G1 X90.672 Y94.46 E.0084
G1 X90.225 Y94.505 E.0084
G1 X89.775 Y94.505 E.0084
G1 X89.328 Y94.46 E.0084
G1 X88.887 Y94.371 E.0084
G1 X88.457 Y94.238 E.0084
G1 X88.043 Y94.064 E.0084
G1 X87.648 Y93.849 E.0084
G1 X87.277 Y93.595 E.0084
G1 X86.932 Y93.306 E.0084
G1 X86.618 Y92.984 E.0084
G1 X86.338 Y92.633 E.0084
G1 X86.094 Y92.255 E.0084
G1 X85.889 Y91.855 E.0084
G1 X85.724 Y91.436 E.0084
G1 X85.603 Y91.004 E.0084
G1 X85.525 Y90.561 E.0084
G1 X85.491 Y90.112 E.0084
G1 X85.502 Y89.663 E.0084
G1 X85.558 Y89.217 E.0084
G1 X85.658 Y88.778 E.0084
G1 X85.801 Y88.352 E.00841
G1 X85.986 Y87.942 E.0084
G1 X86.211 Y87.553 E.0084
G1 X86.474 Y87.188 E.0084
G1 X86.771 Y86.851 E.0084
G1 X87.101 Y86.545 E.0084
G1 X87.459 Y86.273 E.0084
G1 X87.843 Y86.039 E.00841
G1 X88.248 Y85.844 E.0084
G1 X88.67 Y85.69 E.0084
G1 X89.106 Y85.579 E.0084
G1 X89.549 Y85.512 E.00838
G1 X90.225 Y85.495 E.01263
G1 X90.672 Y85.54 E.00839
G1 X91.113 Y85.629 E.0084
G1 X91.542 Y85.762 E.0084
G1 X91.957 Y85.936 E.0084
G1 X92.352 Y86.152 E.00841
G1 X92.723 Y86.405 E.0084
G1 X93.068 Y86.694 E.0084
M73 P67 R4
G1 X93.381 Y87.016 E.0084
G1 X93.662 Y87.367 E.0084
G1 X93.906 Y87.745 E.0084
G1 X94.111 Y88.145 E.0084
G1 X94.275 Y88.563 E.0084
G1 X94.397 Y88.996 E.0084
G1 X94.475 Y89.439 E.0084
G1 X94.509 Y89.888 E.0084
G1 X94.497 Y90.337 E.0084
G1 X94.442 Y90.783 E.0084
G1 X94.342 Y91.222 E.0084
G1 X94.198 Y91.648 E.0084
G1 X94.037 Y92.005 E.00732
; WIPE_START
M204 S6000
G1 X93.789 Y92.447 E-.07225
G1 X93.527 Y92.811 E-.06389
G1 X93.067 Y93.307 E-.09631
G1 X92.785 Y93.544 E-.05254
; WIPE_END
G1 E-.015
M204 S10000
G1 X88.498 Y87.229 Z1.68 F18000
G1 X86.583 Y84.409 Z1.68
G1 Z1.28
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F3167
M204 S6000
G1 X87.157 Y84.096 E.01313
G1 X87.759 Y83.843 E.01313
G1 X88.383 Y83.65 E.01314
G1 X89.023 Y83.52 E.01313
G1 X89.669 Y83.456 E.01306
G1 X90.383 Y83.461 E.01435
G1 X90.977 Y83.52 E.012
G1 X91.617 Y83.65 E.01313
G1 X92.241 Y83.842 E.01314
G1 X92.843 Y84.096 E.01314
G1 X93.417 Y84.409 E.01313
G1 X93.956 Y84.777 E.01314
G1 X94.457 Y85.197 E.01314
G1 X94.913 Y85.664 E.01314
G1 X95.32 Y86.175 E.01313
G1 X95.675 Y86.724 E.01314
G1 X95.973 Y87.305 E.01313
G1 X96.211 Y87.913 E.01313
G1 X96.388 Y88.542 E.01314
G1 X96.502 Y89.185 E.01313
G1 X96.551 Y89.837 E.01314
G1 X96.534 Y90.49 E.01313
G1 X96.453 Y91.138 E.01314
G1 X96.308 Y91.775 E.01313
G1 X96.1 Y92.394 E.01314
G1 X95.831 Y92.989 E.01313
G1 X95.504 Y93.555 E.01314
G1 X95.123 Y94.086 E.01313
G1 X94.691 Y94.575 E.01314
G1 X94.212 Y95.02 E.01313
G1 X93.691 Y95.414 E.01314
G1 X93.134 Y95.755 E.01313
G1 X92.545 Y96.038 E.01314
G1 X91.931 Y96.262 E.01313
G1 X91.298 Y96.423 E.01313
G1 X90.652 Y96.52 E.01314
G1 X90 Y96.553 E.01313
G1 X89.348 Y96.52 E.01313
G1 X88.701 Y96.423 E.01314
G1 X88.068 Y96.262 E.01313
G1 X87.454 Y96.038 E.01314
G1 X86.866 Y95.755 E.01313
G1 X86.309 Y95.414 E.01313
G1 X85.788 Y95.02 E.01314
G1 X85.309 Y94.575 E.01313
G1 X84.877 Y94.086 E.01314
G1 X84.495 Y93.555 E.01314
G1 X84.169 Y92.989 E.01313
G1 X83.9 Y92.394 E.01313
G1 X83.692 Y91.775 E.01314
G1 X83.547 Y91.138 E.01313
G1 X83.465 Y90.49 E.01314
G1 X83.449 Y89.837 E.01313
G1 X83.498 Y89.185 E.01314
G1 X83.611 Y88.542 E.01313
G1 X83.788 Y87.913 E.01314
G1 X84.027 Y87.305 E.01314
G1 X84.325 Y86.724 E.01313
G1 X84.679 Y86.175 E.01313
G1 X85.087 Y85.664 E.01314
G1 X85.543 Y85.197 E.01313
G1 X86.043 Y84.777 E.01314
G1 X86.534 Y84.442 E.01193
M204 S10000
G1 X86.362 Y84.046 F18000
G1 F3167
M204 S6000
G1 X86.972 Y83.714 E.01398
G1 X87.613 Y83.443 E.01399
G1 X88.278 Y83.238 E.01399
G1 X88.96 Y83.1 E.01399
G1 X89.65 Y83.031 E.01394
G1 X90.405 Y83.037 E.01519
G1 X91.04 Y83.1 E.01282
G1 X91.722 Y83.238 E.01399
G1 X92.386 Y83.443 E.01399
G1 X93.027 Y83.714 E.01399
G1 X93.638 Y84.046 E.01398
G1 X94.213 Y84.438 E.01399
G1 X94.746 Y84.885 E.01399
G1 X95.231 Y85.383 E.01399
G1 X95.665 Y85.927 E.01399
G1 X96.043 Y86.511 E.01399
G1 X96.36 Y87.13 E.01398
G1 X96.614 Y87.778 E.01398
G1 X96.802 Y88.448 E.01399
G1 X96.923 Y89.132 E.01398
G1 X96.975 Y89.826 E.01399
G1 X96.958 Y90.521 E.01398
G1 X96.871 Y91.212 E.01399
G1 X96.717 Y91.89 E.01398
G1 X96.495 Y92.549 E.01399
G1 X96.209 Y93.183 E.01398
G1 X95.861 Y93.786 E.01399
G1 X95.455 Y94.35 E.01399
G1 X94.995 Y94.872 E.01399
G1 X94.485 Y95.345 E.01399
G1 X93.93 Y95.765 E.01399
G1 X93.337 Y96.128 E.01398
G1 X92.71 Y96.43 E.01399
G1 X92.056 Y96.667 E.01398
G1 X91.382 Y96.839 E.01399
G1 X90.694 Y96.943 E.01399
G1 X90 Y96.978 E.01399
G1 X89.305 Y96.943 E.01399
G1 X88.617 Y96.839 E.01399
G1 X87.943 Y96.668 E.01398
G1 X87.289 Y96.43 E.01399
G1 X86.663 Y96.128 E.01398
G1 X86.069 Y95.765 E.01399
G1 X85.515 Y95.345 E.01399
G1 X85.005 Y94.872 E.01398
G1 X84.545 Y94.35 E.01399
G1 X84.139 Y93.786 E.01399
G1 X83.791 Y93.183 E.01398
G1 X83.505 Y92.549 E.01399
G1 X83.283 Y91.89 E.01399
G1 X83.128 Y91.212 E.01398
G1 X83.042 Y90.521 E.01399
G1 X83.024 Y89.826 E.01398
G1 X83.076 Y89.132 E.01399
G1 X83.197 Y88.447 E.01399
G1 X83.386 Y87.778 E.01399
G1 X83.64 Y87.13 E.01399
G1 X83.957 Y86.511 E.01398
G1 X84.334 Y85.927 E.01399
G1 X84.768 Y85.383 E.01399
G1 X85.254 Y84.885 E.01398
G1 X85.787 Y84.438 E.01399
G1 X86.312 Y84.08 E.01278
M204 S250
G1 X86.148 Y83.696 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1800
M204 S5000
G1 X86.795 Y83.344 E.01376
G1 X87.473 Y83.058 E.01376
G1 X88.177 Y82.841 E.01376
G1 X88.899 Y82.695 E.01376
G1 X89.631 Y82.622 E.01375
G1 X90.427 Y82.628 E.01488
G1 X91.101 Y82.695 E.01265
G1 X91.823 Y82.841 E.01376
G1 X92.526 Y83.058 E.01376
G1 X93.205 Y83.344 E.01376
G1 X93.852 Y83.696 E.01376
G1 X94.46 Y84.111 E.01376
G1 X95.024 Y84.585 E.01376
G1 X95.539 Y85.112 E.01376
G1 X95.998 Y85.688 E.01376
G1 X96.397 Y86.306 E.01376
G1 X96.733 Y86.962 E.01376
G1 X97.002 Y87.647 E.01376
G1 X97.202 Y88.356 E.01377
G1 X97.33 Y89.081 E.01376
G1 X97.385 Y89.816 E.01376
G1 X97.366 Y90.552 E.01376
G1 X97.275 Y91.283 E.01376
G1 X97.111 Y92.001 E.01376
G1 X96.876 Y92.699 E.01376
G1 X96.574 Y93.37 E.01376
G1 X96.205 Y94.008 E.01376
G1 X95.775 Y94.606 E.01376
G1 X95.288 Y95.158 E.01376
G1 X94.748 Y95.659 E.01376
G1 X94.161 Y96.104 E.01376
G1 X93.533 Y96.488 E.01376
G1 X92.869 Y96.807 E.01376
G1 X92.177 Y97.059 E.01376
G1 X91.464 Y97.241 E.01376
G1 X90.735 Y97.351 E.01376
G1 X90 Y97.387 E.01376
G1 X89.264 Y97.351 E.01376
G1 X88.536 Y97.241 E.01376
G1 X87.822 Y97.059 E.01376
G1 X87.13 Y96.807 E.01376
G1 X86.467 Y96.488 E.01376
G1 X85.838 Y96.104 E.01376
G1 X85.251 Y95.659 E.01376
G1 X84.712 Y95.158 E.01376
G1 X84.224 Y94.606 E.01376
G1 X83.794 Y94.008 E.01376
G1 X83.426 Y93.37 E.01376
G1 X83.123 Y92.699 E.01376
G1 X82.889 Y92.001 E.01376
G1 X82.725 Y91.283 E.01376
G1 X82.633 Y90.552 E.01376
G1 X82.615 Y89.816 E.01376
G1 X82.67 Y89.081 E.01376
G1 X82.798 Y88.356 E.01376
G1 X82.997 Y87.647 E.01376
G1 X83.266 Y86.962 E.01376
G1 X83.602 Y86.306 E.01376
G1 X84.002 Y85.688 E.01376
G1 X84.461 Y85.112 E.01376
G1 X84.975 Y84.585 E.01376
G1 X85.539 Y84.111 E.01376
G1 X86.098 Y83.73 E.01264
; WIPE_START
M204 S6000
G1 X86.795 Y83.344 E-.11343
G1 X87.473 Y83.058 E-.10495
G1 X87.92 Y82.92 E-.06662
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
G1 X0 Y90.0001 ; move to safe pos
G1 X-13.0 F3000 ; move to safe pos
M400
M1004 S5 P1  ; external shutter
M400 P300
M971 S11 C11 O0
G92 E0
G1 X0 F18000
M623

; SKIPTYPE: head_wrap_detect
M622.1 S1
M1002 judge_flag g39_3rd_layer_detect_flag
M622 J1
    ; enable nozzle clog detect at 3rd layer
    


    M622.1 S1
    M1002 judge_flag g39_detection_flag
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




G1 X89.815 Y83.864
G1 Z1.28
G1 E.3 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.41927
G1 F3167
M204 S6000
G1 X89.094 Y83.927 E.01349
G1 X88.494 Y84.045 E.01142
G1 X87.908 Y84.225 E.01142
G1 X87.344 Y84.462 E.01142
G1 X86.806 Y84.754 E.01141
G1 X86.299 Y85.098 E.01143
G1 X85.829 Y85.491 E.01142
G1 X85.401 Y85.928 E.01141
G1 X85.018 Y86.407 E.01143
G1 X84.685 Y86.92 E.01142
G1 X84.405 Y87.465 E.01141
G1 X84.181 Y88.034 E.01143
G1 X84.014 Y88.624 E.01142
G1 X83.907 Y89.226 E.01141
G1 X83.86 Y89.837 E.01142
G1 X83.874 Y90.449 E.01142
G1 X83.949 Y91.057 E.01142
G1 X84.085 Y91.654 E.01142
G1 X84.279 Y92.235 E.01142
G1 X84.529 Y92.793 E.01141
G1 X84.835 Y93.324 E.01143
G1 X85.192 Y93.822 E.01142
G1 X85.596 Y94.282 E.01141
G1 X86.044 Y94.699 E.01142
G1 X86.532 Y95.069 E.01142
G1 X87.054 Y95.39 E.01142
G1 X87.605 Y95.656 E.01141
G1 X88.18 Y95.866 E.01143
G1 X88.773 Y96.018 E.01142
G1 X89.379 Y96.111 E.01142
G1 X89.99 Y96.142 E.01142
G1 X90.601 Y96.113 E.01142
G1 X91.207 Y96.022 E.01143
G1 X91.801 Y95.872 E.01141
G1 X92.377 Y95.664 E.01142
G1 X92.929 Y95.399 E.01142
G1 X93.452 Y95.081 E.01142
G1 X93.94 Y94.712 E.01142
G1 X94.389 Y94.294 E.01142
G1 X94.784 Y93.854 E.01104
G1 X95.144 Y93.357 E.01144
G1 X95.453 Y92.829 E.01142
G1 X95.708 Y92.272 E.01143
G1 X95.905 Y91.692 E.01142
G1 X96.045 Y91.095 E.01142
G1 X96.124 Y90.488 E.01142
G1 X96.142 Y89.857 E.01178
G1 X96.099 Y89.265 E.01106
G1 X95.995 Y88.661 E.01143
G1 X95.832 Y88.071 E.01142
G1 X95.611 Y87.5 E.01142
G1 X95.334 Y86.954 E.01143
G1 X95.005 Y86.438 E.01142
G1 X94.625 Y85.957 E.01142
G1 X94.2 Y85.517 E.01142
G1 X93.732 Y85.121 E.01143
G1 X93.228 Y84.773 E.01142
G1 X92.692 Y84.478 E.01142
G1 X92.128 Y84.237 E.01142
G1 X91.544 Y84.054 E.01143
G1 X90.944 Y83.93 E.01142
G1 X90.37 Y83.869 E.01077
G1 X89.875 Y83.864 E.00923
; WIPE_START
G1 F4800
G1 X90.37 Y83.869 E-.07055
G1 X90.944 Y83.93 E-.08232
G1 X91.544 Y84.054 E-.08725
G1 X91.844 Y84.148 E-.04488
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X93.551 Y91.588 Z1.68 F18000
G1 X94.107 Y94.013 Z1.68
G1 Z1.28
G1 E.3 F1800
; LINE_WIDTH: 0.417139
G1 F3167
M204 S6000
G1 X93.694 Y94.403 E.01053
G1 X93.238 Y94.749 E.01063
G1 X92.749 Y95.048 E.01063
G1 X92.232 Y95.296 E.01063
G1 X91.694 Y95.492 E.01063
G1 X91.139 Y95.634 E.01062
G1 X90.572 Y95.719 E.01063
G1 X90 Y95.748 E.01063
G1 X89.428 Y95.719 E.01063
G1 X88.861 Y95.634 E.01063
G1 X88.306 Y95.492 E.01062
G1 X87.767 Y95.296 E.01064
G1 X87.251 Y95.048 E.01062
G1 X86.762 Y94.749 E.01063
G1 X86.305 Y94.403 E.01063
G1 X85.885 Y94.013 E.01063
G1 X85.506 Y93.584 E.01062
G1 X85.172 Y93.118 E.01063
G1 X84.885 Y92.622 E.01063
G1 X84.754 Y92.356 E.0055
G1 X84.551 Y91.84 E.01028
G1 X84.395 Y91.289 E.01063
G1 X84.295 Y90.725 E.01064
G1 X84.251 Y90.153 E.01063
G1 X84.264 Y89.58 E.01063
G1 X84.335 Y89.011 E.01064
G1 X84.461 Y88.452 E.01063
G1 X84.643 Y87.908 E.01064
G1 X84.878 Y87.385 E.01064
G1 X85.164 Y86.888 E.01064
G1 X85.498 Y86.422 E.01063
G1 X85.876 Y85.991 E.01064
G1 X86.296 Y85.601 E.01063
G1 X86.752 Y85.254 E.01063
G1 X87.241 Y84.954 E.01064
G1 X87.757 Y84.704 E.01064
G1 X88.296 Y84.507 E.01063
G1 X88.851 Y84.365 E.01063
G1 X89.72 Y84.26 E.01624
G1 X90.28 Y84.256 E.01039
G1 X90.848 Y84.31 E.01057
G1 X91.41 Y84.423 E.01064
G1 X91.958 Y84.591 E.01064
G1 X92.487 Y84.813 E.01064
G1 X92.991 Y85.086 E.01064
G1 X93.465 Y85.409 E.01064
G1 X93.905 Y85.777 E.01064
G1 X94.306 Y86.186 E.01063
G1 X94.665 Y86.634 E.01064
G1 X94.977 Y87.115 E.01063
G1 X95.239 Y87.625 E.01064
G1 X95.45 Y88.159 E.01063
G1 X95.606 Y88.71 E.01063
G1 X95.706 Y89.275 E.01064
G1 X95.75 Y89.847 E.01064
G1 X95.737 Y90.42 E.01064
G1 X95.667 Y90.989 E.01064
G1 X95.54 Y91.549 E.01064
G1 X95.358 Y92.093 E.01064
G1 X95.123 Y92.616 E.01064
G1 X94.837 Y93.113 E.01064
G1 X94.508 Y93.572 E.01048
G1 X94.147 Y93.969 E.00994
; CHANGE_LAYER
; Z_HEIGHT: 1.4
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F4800
G1 X94.508 Y93.572 E-.07638
G1 X94.837 Y93.113 E-.08053
G1 X95.123 Y92.616 E-.0817
G1 X95.257 Y92.319 E-.04639
; WIPE_END
G1 E-.015 F1800
; layer num/total_layer_count: 11/33
; update layer progress
M73 L11
M991 S0 P10 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z1.68 I-.355 J-1.164 P1  F18000
G1 X94.733 Y92.479 Z1.68
G1 Z1.4
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F2572
M204 S6000
G1 X94.49 Y92.9 E.00978
M73 P68 R4
G1 X94.178 Y93.333 E.01072
G1 X93.826 Y93.732 E.01071
G1 X93.435 Y94.094 E.01072
G1 X93.011 Y94.416 E.01072
G1 X92.556 Y94.694 E.01071
G1 X92.076 Y94.925 E.01072
G1 X91.578 Y95.106 E.01066
G1 X91.149 Y95.218 E.00891
G1 X90.79 Y95.286 E.00735
G1 X90.266 Y95.338 E.01058
G1 X89.733 Y95.338 E.01071
G1 X89.203 Y95.285 E.01071
G1 X88.681 Y95.18 E.01071
G1 X88.172 Y95.022 E.01072
G1 X87.681 Y94.815 E.01071
G1 X87.213 Y94.561 E.01072
G1 X86.773 Y94.261 E.01071
G1 X86.364 Y93.918 E.01072
G1 X85.992 Y93.537 E.01071
G1 X85.66 Y93.12 E.01072
G1 X85.371 Y92.673 E.01071
G1 X85.128 Y92.198 E.01072
G1 X84.933 Y91.702 E.01071
G1 X84.789 Y91.19 E.01071
G1 X84.697 Y90.665 E.01072
G1 X84.657 Y90.133 E.01071
G1 X84.67 Y89.601 E.01071
G1 X84.736 Y89.072 E.01071
G1 X84.855 Y88.552 E.01072
G1 X85.025 Y88.047 E.01071
G1 X85.244 Y87.561 E.01072
G1 X85.51 Y87.1 E.01071
G1 X85.821 Y86.667 E.01072
G1 X86.174 Y86.268 E.01071
G1 X86.564 Y85.906 E.01071
G1 X86.989 Y85.584 E.01072
G1 X87.444 Y85.306 E.01071
G1 X87.924 Y85.075 E.01072
G1 X88.425 Y84.893 E.01071
G1 X88.941 Y84.761 E.01071
G1 X89.461 Y84.683 E.01059
G1 X89.825 Y84.66 E.00734
G1 X90.269 Y84.662 E.00891
G1 X90.796 Y84.715 E.01066
G1 X91.319 Y84.82 E.01071
G1 X91.828 Y84.978 E.01072
G1 X92.319 Y85.184 E.01071
G1 X92.787 Y85.439 E.01072
G1 X93.227 Y85.739 E.01071
G1 X93.635 Y86.082 E.01072
G1 X94.007 Y86.463 E.01071
G1 X94.339 Y86.88 E.01072
G1 X94.628 Y87.328 E.01071
G1 X94.872 Y87.802 E.01072
G1 X95.066 Y88.298 E.01071
G1 X95.211 Y88.81 E.01071
G1 X95.303 Y89.335 E.01072
G1 X95.343 Y89.867 E.01071
G1 X95.33 Y90.399 E.01071
G1 X95.263 Y90.928 E.01071
G1 X95.145 Y91.448 E.01072
G1 X94.975 Y91.953 E.01071
G1 X94.762 Y92.426 E.01044
M204 S10000
G1 X94.365 Y92.266 F18000
G1 F2572
M204 S6000
G1 X94.133 Y92.669 E.00936
G1 X93.846 Y93.068 E.00986
G1 X93.522 Y93.435 E.00986
G1 X93.162 Y93.769 E.00986
G1 X92.771 Y94.065 E.00987
G1 X92.353 Y94.321 E.00986
G1 X91.911 Y94.534 E.00987
G1 X91.451 Y94.701 E.00983
G1 X91.056 Y94.804 E.00822
G1 X90.729 Y94.865 E.00669
G1 X90.245 Y94.914 E.00978
G1 X89.755 Y94.914 E.00986
G1 X89.267 Y94.865 E.00986
G1 X88.786 Y94.768 E.00986
G1 X88.317 Y94.623 E.00987
G1 X87.865 Y94.433 E.00986
G1 X87.434 Y94.198 E.00986
G1 X87.029 Y93.922 E.00986
G1 X86.653 Y93.607 E.00986
G1 X86.311 Y93.256 E.00986
G1 X86.005 Y92.872 E.00986
G1 X85.739 Y92.46 E.00986
G1 X85.515 Y92.023 E.00987
G1 X85.336 Y91.567 E.00986
G1 X85.203 Y91.095 E.00986
G1 X85.118 Y90.612 E.00986
G1 X85.081 Y90.123 E.00986
G1 X85.094 Y89.632 E.00986
G1 X85.155 Y89.146 E.00986
G1 X85.264 Y88.667 E.00987
G1 X85.42 Y88.202 E.00986
G1 X85.622 Y87.755 E.00986
G1 X85.867 Y87.331 E.00986
G1 X86.153 Y86.932 E.00987
G1 X86.478 Y86.565 E.00986
G1 X86.837 Y86.231 E.00986
G1 X87.228 Y85.935 E.00987
G1 X87.647 Y85.679 E.00986
G1 X88.089 Y85.466 E.00986
G1 X88.55 Y85.299 E.00986
G1 X89.025 Y85.178 E.00986
G1 X89.506 Y85.105 E.00979
G1 X89.838 Y85.084 E.00668
G1 X90.247 Y85.086 E.00822
G1 X90.733 Y85.135 E.00983
G1 X91.214 Y85.232 E.00986
G1 X91.683 Y85.377 E.00987
G1 X92.134 Y85.567 E.00986
G1 X92.565 Y85.802 E.00987
G1 X92.97 Y86.078 E.00986
G1 X93.346 Y86.393 E.00986
G1 X93.689 Y86.744 E.00986
G1 X93.995 Y87.128 E.00986
G1 X94.261 Y87.54 E.00986
G1 X94.485 Y87.977 E.00987
G1 X94.664 Y88.433 E.00986
G1 X94.796 Y88.905 E.00986
G1 X94.882 Y89.388 E.00987
G1 X94.918 Y89.877 E.00986
G1 X94.906 Y90.368 E.00986
G1 X94.845 Y90.854 E.00986
G1 X94.736 Y91.333 E.00987
G1 X94.58 Y91.798 E.00986
G1 X94.392 Y92.213 E.00916
M204 S250
G1 X94.011 Y92.062 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1800
M204 S5000
G1 X93.788 Y92.447 E.00831
G1 X93.526 Y92.812 E.0084
G1 X93.229 Y93.149 E.0084
G1 X92.899 Y93.455 E.0084
G1 X92.54 Y93.727 E.0084
G1 X92.157 Y93.961 E.0084
G1 X91.752 Y94.156 E.0084
G1 X91.33 Y94.31 E.00839
G1 X90.671 Y94.46 E.01263
G1 X90.225 Y94.505 E.00838
G1 X89.775 Y94.505 E.0084
G1 X89.328 Y94.46 E.0084
G1 X88.887 Y94.371 E.0084
G1 X88.457 Y94.238 E.00841
G1 X88.043 Y94.064 E.0084
G1 X87.648 Y93.848 E.0084
G1 X87.277 Y93.595 E.0084
G1 X86.932 Y93.306 E.0084
G1 X86.618 Y92.984 E.0084
G1 X86.338 Y92.633 E.0084
G1 X86.094 Y92.255 E.0084
G1 X85.889 Y91.855 E.0084
G1 X85.724 Y91.436 E.0084
G1 X85.603 Y91.004 E.0084
G1 X85.525 Y90.561 E.0084
G1 X85.491 Y90.112 E.0084
G1 X85.502 Y89.663 E.0084
G1 X85.558 Y89.217 E.0084
G1 X85.658 Y88.778 E.00841
G1 X85.801 Y88.352 E.0084
G1 X85.986 Y87.942 E.0084
G1 X86.211 Y87.553 E.0084
G1 X86.474 Y87.188 E.00841
G1 X86.771 Y86.851 E.0084
G1 X87.101 Y86.545 E.0084
G1 X87.459 Y86.273 E.0084
G1 X87.843 Y86.039 E.0084
G1 X88.248 Y85.844 E.0084
G1 X88.67 Y85.69 E.0084
G1 X89.106 Y85.579 E.0084
G1 X89.549 Y85.512 E.00838
G1 X90.225 Y85.495 E.01263
G1 X90.672 Y85.54 E.00839
G1 X91.113 Y85.629 E.0084
G1 X91.543 Y85.762 E.00841
G1 X91.957 Y85.936 E.0084
G1 X92.352 Y86.152 E.00841
G1 X92.723 Y86.405 E.0084
G1 X93.068 Y86.694 E.0084
G1 X93.381 Y87.016 E.0084
G1 X93.662 Y87.367 E.0084
G1 X93.906 Y87.745 E.0084
G1 X94.111 Y88.145 E.0084
G1 X94.275 Y88.564 E.0084
G1 X94.397 Y88.996 E.0084
G1 X94.475 Y89.439 E.0084
G1 X94.509 Y89.888 E.0084
G1 X94.497 Y90.337 E.0084
G1 X94.442 Y90.783 E.0084
G1 X94.341 Y91.222 E.0084
G1 X94.198 Y91.648 E.0084
G1 X94.036 Y92.007 E.00737
; WIPE_START
M204 S6000
G1 X93.788 Y92.447 E-.07192
G1 X93.526 Y92.812 E-.06408
G1 X93.229 Y93.149 E-.06406
G1 X92.899 Y93.455 E-.06406
G1 X92.782 Y93.544 E-.02088
; WIPE_END
G1 E-.015
M204 S10000
G1 X88.494 Y87.23 Z1.8 F18000
G1 X86.672 Y84.548 Z1.8
G1 Z1.4
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F2572
M204 S6000
G1 X87.216 Y84.251 E.01245
G1 X87.826 Y83.994 E.01333
G1 X88.417 Y83.812 E.01242
G1 X89.067 Y83.681 E.01334
G1 X89.683 Y83.62 E.01245
G1 X90.303 Y83.62 E.01246
G1 X90.962 Y83.685 E.01333
G1 X91.568 Y83.808 E.01243
G1 X92.201 Y84.004 E.01332
G1 X92.772 Y84.245 E.01246
G1 X93.316 Y84.541 E.01245
G1 X93.864 Y84.914 E.01333
G1 X94.337 Y85.311 E.01242
G1 X94.8 Y85.785 E.01333
G1 X95.186 Y86.27 E.01246
G1 X95.522 Y86.79 E.01246
G1 X95.825 Y87.38 E.01332
G1 X96.051 Y87.955 E.01243
G1 X96.231 Y88.593 E.01333
G1 X96.338 Y89.204 E.01246
G1 X96.385 Y89.822 E.01248
G1 X96.372 Y90.442 E.01247
G1 X96.292 Y91.099 E.01331
G1 X96.145 Y91.744 E.0133
G1 X95.947 Y92.331 E.01246
G1 X95.71 Y92.859 E.01162
G1 X95.383 Y93.438 E.01338
G1 X94.999 Y93.976 E.01328
G1 X94.592 Y94.44 E.01243
G1 X94.108 Y94.891 E.0133
G1 X93.58 Y95.29 E.0133
G1 X93.051 Y95.612 E.01246
G1 X92.493 Y95.881 E.01245
G1 X91.87 Y96.108 E.01332
G1 X91.272 Y96.26 E.01241
G1 X90.619 Y96.357 E.01328
G1 X89.966 Y96.387 E.01315
G1 X89.355 Y96.355 E.01231
G1 X88.743 Y96.263 E.01244
G1 X88.101 Y96.099 E.01332
G1 X87.52 Y95.887 E.01244
G1 X86.961 Y95.618 E.01246
G1 X86.395 Y95.274 E.01332
G1 X85.902 Y94.9 E.01243
G1 X85.416 Y94.449 E.01333
G1 X85.007 Y93.984 E.01246
G1 X84.645 Y93.482 E.01246
G1 X84.312 Y92.907 E.01334
G1 X84.058 Y92.344 E.01242
G1 X83.847 Y91.716 E.01333
G1 X83.709 Y91.111 E.01246
G1 X83.632 Y90.497 E.01246
G1 X83.614 Y89.833 E.01334
G1 X83.66 Y89.218 E.01242
G1 X83.776 Y88.564 E.01334
G1 X83.944 Y87.968 E.01245
G1 X84.169 Y87.391 E.01245
G1 X84.471 Y86.801 E.01333
G1 X84.806 Y86.282 E.01242
G1 X85.219 Y85.763 E.01333
G1 X85.651 Y85.321 E.01242
G1 X86.159 Y84.896 E.01333
G1 X86.622 Y84.581 E.01125
M204 S10000
G1 X86.451 Y84.185 F18000
G1 F2572
M204 S6000
G1 X87.031 Y83.868 E.0133
G1 X87.681 Y83.594 E.01418
G1 X88.312 Y83.4 E.01328
G1 X89.004 Y83.261 E.01419
G1 X89.662 Y83.196 E.0133
G1 X90.323 Y83.195 E.0133
G1 X91.025 Y83.265 E.01418
G1 X91.673 Y83.396 E.01328
G1 X92.347 Y83.605 E.01418
G1 X92.956 Y83.862 E.0133
G1 X93.537 Y84.178 E.0133
G1 X94.12 Y84.575 E.01419
G1 X94.626 Y84.999 E.01328
G1 X95.118 Y85.505 E.01419
G1 X95.53 Y86.022 E.0133
G1 X95.89 Y86.577 E.0133
G1 X96.212 Y87.205 E.01418
G1 X96.454 Y87.82 E.01328
G1 X96.645 Y88.499 E.01419
G1 X96.759 Y89.151 E.0133
G1 X96.81 Y89.811 E.01331
G1 X96.795 Y90.472 E.01331
G1 X96.711 Y91.172 E.01417
G1 X96.554 Y91.859 E.01418
G1 X96.342 Y92.486 E.0133
G1 X96.089 Y93.05 E.01243
G1 X95.741 Y93.666 E.01422
G1 X95.332 Y94.239 E.01416
G1 X94.896 Y94.736 E.01328
G1 X94.381 Y95.217 E.01417
G1 X93.819 Y95.641 E.01417
G1 X93.254 Y95.985 E.0133
G1 X92.658 Y96.272 E.0133
G1 X91.996 Y96.514 E.01418
G1 X91.356 Y96.676 E.01327
G1 X90.66 Y96.78 E.01414
G1 X89.965 Y96.812 E.01401
G1 X89.312 Y96.778 E.01315
G1 X88.658 Y96.679 E.01329
G1 X87.975 Y96.505 E.01418
G1 X87.355 Y96.278 E.01329
G1 X86.758 Y95.992 E.0133
G1 X86.156 Y95.625 E.01418
G1 X85.629 Y95.226 E.01329
G1 X85.112 Y94.746 E.01419
G1 X84.675 Y94.249 E.0133
G1 X84.288 Y93.713 E.0133
G1 X83.934 Y93.101 E.0142
G1 X83.662 Y92.499 E.01328
G1 X83.438 Y91.83 E.01419
G1 X83.291 Y91.185 E.01331
G1 X83.208 Y90.529 E.0133
G1 X83.19 Y89.823 E.0142
G1 X83.239 Y89.165 E.01327
G1 X83.362 Y88.47 E.0142
G1 X83.541 Y87.833 E.0133
G1 X83.782 Y87.217 E.01329
G1 X84.103 Y86.589 E.01419
G1 X84.461 Y86.034 E.01328
G1 X84.901 Y85.482 E.01419
G1 X85.362 Y85.01 E.01328
G1 X85.903 Y84.557 E.01419
G1 X86.401 Y84.219 E.0121
M204 S250
G1 X86.237 Y83.835 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1800
M204 S5000
G1 X86.853 Y83.499 E.01311
G1 X87.541 Y83.209 E.01395
G1 X88.211 Y83.003 E.01311
G1 X88.943 Y82.856 E.01395
G1 X89.642 Y82.787 E.01311
G1 X90.344 Y82.786 E.01312
G1 X91.086 Y82.86 E.01395
G1 X91.774 Y82.999 E.01311
G1 X92.487 Y83.22 E.01394
G1 X93.134 Y83.493 E.01312
G1 X93.75 Y83.828 E.01311
G1 X94.368 Y84.248 E.01395
G1 X94.905 Y84.699 E.01311
G1 X95.426 Y85.234 E.01395
G1 X95.863 Y85.783 E.01311
G1 X96.245 Y86.372 E.01311
G1 X96.586 Y87.036 E.01395
G1 X96.842 Y87.689 E.01311
G1 X97.044 Y88.408 E.01395
G1 X97.166 Y89.1 E.01312
G1 X97.219 Y89.8 E.01312
G1 X97.204 Y90.501 E.01312
G1 X97.114 Y91.242 E.01395
G1 X96.948 Y91.971 E.01395
G1 X96.724 Y92.636 E.01311
G1 X96.455 Y93.235 E.01228
G1 X96.087 Y93.886 E.01397
G1 X95.654 Y94.494 E.01395
G1 X95.19 Y95.021 E.01311
G1 X94.645 Y95.53 E.01395
G1 X94.049 Y95.98 E.01395
G1 X93.449 Y96.345 E.01312
G1 X92.817 Y96.65 E.01311
G1 X92.116 Y96.905 E.01394
G1 X91.437 Y97.078 E.0131
G1 X90.7 Y97.188 E.01392
G1 X89.963 Y97.222 E.01378
G1 X89.27 Y97.185 E.01297
G1 X88.577 Y97.081 E.0131
G1 X87.854 Y96.896 E.01394
G1 X87.195 Y96.656 E.0131
G1 X86.563 Y96.352 E.01311
G1 X85.926 Y95.963 E.01395
G1 X85.366 Y95.54 E.01312
G1 X84.819 Y95.031 E.01395
G1 X84.355 Y94.505 E.01312
G1 X83.944 Y93.935 E.01312
G1 X83.57 Y93.289 E.01396
G1 X83.281 Y92.649 E.01311
G1 X83.043 Y91.941 E.01395
G1 X82.888 Y91.256 E.01312
G1 X82.799 Y90.56 E.01312
G1 X82.78 Y89.813 E.01396
G1 X82.832 Y89.114 E.01311
G1 X82.962 Y88.378 E.01396
G1 X83.153 Y87.703 E.01311
G1 X83.408 Y87.049 E.01311
G1 X83.748 Y86.384 E.01395
G1 X84.128 Y85.795 E.01311
G1 X84.594 Y85.211 E.01395
G1 X85.084 Y84.709 E.01311
G1 X85.656 Y84.23 E.01395
G1 X86.187 Y83.869 E.012
; WIPE_START
M204 S6000
G1 X86.853 Y83.499 E-.1085
G1 X87.541 Y83.209 E-.10639
G1 X88.011 Y83.064 E-.07011
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
G1 X0 Y90.0001 ; move to safe pos
G1 X-13.0 F3000 ; move to safe pos
M400
M1004 S5 P1  ; external shutter
M400 P300
M971 S11 C11 O0
G92 E0
G1 X0 F18000
M623

; SKIPTYPE: head_wrap_detect
M622.1 S1
M1002 judge_flag g39_3rd_layer_detect_flag
M622 J1
    ; enable nozzle clog detect at 3rd layer
    


    M622.1 S1
    M1002 judge_flag g39_detection_flag
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




G1 X88.348 Y84.379
G1 Z1.4
G1 E.3 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.643006
G1 F2400
M204 S6000
G1 X88.823 Y84.257 E.01434
G1 X89.393 Y84.169 E.01688
G1 X89.8 Y84.14 E.01194
G1 X90.281 Y84.141 E.01408
G1 X90.885 Y84.201 E.01774
G1 X91.439 Y84.313 E.01655
G1 X92.022 Y84.494 E.01785
G1 X92.545 Y84.715 E.01661
G1 X93.044 Y84.986 E.01662
G1 X93.549 Y85.33 E.01787
G1 X93.982 Y85.693 E.01654
G1 X94.408 Y86.13 E.01785
G1 X94.762 Y86.575 E.01662
G1 X95.072 Y87.054 E.01669
G1 X95.35 Y87.594 E.01779
G1 X95.557 Y88.121 E.01656
G1 X95.722 Y88.709 E.01787
G1 X95.82 Y89.268 E.01662
G1 X95.863 Y89.837 E.01667
G1 X95.851 Y90.405 E.01664
G1 X95.778 Y91.01 E.01781
G1 X95.643 Y91.603 E.0178
G1 X95.461 Y92.141 E.01663
G1 X95.225 Y92.662 E.01673
G1 X94.943 Y93.157 E.01669
G1 X94.59 Y93.652 E.01776
G1 X94.217 Y94.077 E.01655
G1 X93.772 Y94.492 E.0178
G1 X93.291 Y94.855 E.01764
G1 X92.802 Y95.154 E.01677
G1 X92.29 Y95.4 E.01661
G1 X91.717 Y95.609 E.01786
G1 X91.252 Y95.728 E.01402
G1 X90.85 Y95.8 E.01194
G1 X90.277 Y95.855 E.01686
G1 X89.693 Y95.854 E.01709
G1 X89.111 Y95.795 E.0171
G1 X88.539 Y95.677 E.01709
G1 X87.98 Y95.504 E.01711
G1 X87.442 Y95.275 E.0171
G1 X86.93 Y94.994 E.0171
G1 X86.448 Y94.664 E.01709
G1 X86.002 Y94.287 E.0171
G1 X85.594 Y93.868 E.0171
G1 X85.231 Y93.41 E.0171
G1 X84.916 Y92.918 E.01709
G1 X84.65 Y92.397 E.01711
M73 P69 R4
G1 X84.438 Y91.853 E.01709
G1 X84.281 Y91.29 E.01709
G1 X84.181 Y90.714 E.01711
G1 X84.139 Y90.131 E.01709
G1 X84.155 Y89.547 E.0171
G1 X84.23 Y88.967 E.01709
G1 X84.361 Y88.397 E.01711
G1 X84.548 Y87.844 E.01709
G1 X84.791 Y87.312 E.0171
G1 X85.083 Y86.807 E.01709
G1 X85.426 Y86.333 E.01711
G1 X85.792 Y85.918 E.0162
G1 X86.22 Y85.519 E.01709
G1 X86.685 Y85.165 E.01711
G1 X87.183 Y84.859 E.01709
G1 X87.709 Y84.604 E.0171
G1 X88.257 Y84.402 E.01709
G1 X88.29 Y84.394 E.00099
; CHANGE_LAYER
; Z_HEIGHT: 1.52
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F2400
G1 X88.823 Y84.257 E-.07841
G1 X89.393 Y84.169 E-.0822
G1 X89.8 Y84.14 E-.05814
G1 X90.265 Y84.141 E-.06625
; WIPE_END
G1 E-.015 F1800
; layer num/total_layer_count: 12/33
; update layer progress
M73 L12
M991 S0 P11 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z1.8 I-1.073 J.575 P1  F18000
G1 X94.731 Y92.481 Z1.8
G1 Z1.52
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F2541
M204 S6000
G1 X94.49 Y92.9 E.00973
G1 X94.182 Y93.327 E.01059
G1 X93.939 Y93.609 E.00749
G1 X93.633 Y93.92 E.00876
G1 X93.227 Y94.26 E.01066
G1 X92.787 Y94.561 E.01071
G1 X92.319 Y94.815 E.01071
G1 X91.828 Y95.022 E.01072
G1 X91.319 Y95.18 E.01072
G1 X90.796 Y95.285 E.01071
G1 X90.266 Y95.338 E.01071
G1 X89.733 Y95.338 E.01071
G1 X89.203 Y95.285 E.01071
G1 X88.681 Y95.18 E.01071
G1 X88.172 Y95.022 E.01072
G1 X87.681 Y94.815 E.01071
G1 X87.213 Y94.561 E.01072
G1 X86.773 Y94.261 E.01071
G1 X86.364 Y93.918 E.01072
G1 X85.992 Y93.537 E.01071
G1 X85.66 Y93.12 E.01072
G1 X85.371 Y92.673 E.01071
G1 X85.128 Y92.198 E.01072
G1 X84.933 Y91.702 E.01072
G1 X84.789 Y91.19 E.0107
G1 X84.697 Y90.665 E.01072
G1 X84.657 Y90.133 E.01071
G1 X84.67 Y89.601 E.01071
G1 X84.736 Y89.072 E.01071
G1 X84.855 Y88.552 E.01072
G1 X85.025 Y88.047 E.01071
G1 X85.244 Y87.561 E.01072
G1 X85.51 Y87.1 E.01071
G1 X85.821 Y86.668 E.01071
G1 X86.174 Y86.268 E.01072
G1 X86.564 Y85.906 E.01071
G1 X86.989 Y85.584 E.01071
G1 X87.444 Y85.306 E.01071
G1 X87.924 Y85.075 E.01072
G1 X88.425 Y84.893 E.01071
G1 X88.941 Y84.761 E.01071
G1 X89.462 Y84.683 E.0106
G1 X89.833 Y84.66 E.00748
G1 X90.269 Y84.662 E.00877
G1 X90.796 Y84.715 E.01066
G1 X91.319 Y84.82 E.01071
G1 X91.828 Y84.978 E.01072
G1 X92.319 Y85.184 E.01071
G1 X92.787 Y85.44 E.01072
G1 X93.227 Y85.739 E.01071
G1 X93.635 Y86.082 E.01071
G1 X94.007 Y86.463 E.01072
G1 X94.339 Y86.88 E.01072
G1 X94.628 Y87.328 E.01071
G1 X94.872 Y87.802 E.01072
G1 X95.066 Y88.298 E.01072
G1 X95.211 Y88.811 E.01071
G1 X95.303 Y89.335 E.01072
G1 X95.343 Y89.867 E.01071
G1 X95.33 Y90.399 E.01071
G1 X95.263 Y90.928 E.01071
G1 X95.145 Y91.448 E.01072
G1 X94.975 Y91.953 E.01071
G1 X94.76 Y92.428 E.01049
M204 S10000
G1 X94.364 Y92.269 F18000
G1 F2541
M204 S6000
G1 X94.133 Y92.669 E.0093
G1 X93.849 Y93.065 E.00979
G1 X93.627 Y93.322 E.00682
G1 X93.345 Y93.608 E.00808
G1 X92.971 Y93.922 E.00983
G1 X92.565 Y94.198 E.00986
G1 X92.135 Y94.433 E.00986
G1 X91.683 Y94.623 E.00987
G1 X91.214 Y94.768 E.00986
G1 X90.733 Y94.865 E.00986
G1 X90.245 Y94.914 E.00986
G1 X89.755 Y94.914 E.00986
G1 X89.267 Y94.865 E.00986
G1 X88.786 Y94.768 E.00986
G1 X88.317 Y94.623 E.00987
G1 X87.865 Y94.433 E.00986
G1 X87.434 Y94.198 E.00986
G1 X87.029 Y93.922 E.00986
G1 X86.653 Y93.607 E.00986
G1 X86.311 Y93.256 E.00986
G1 X86.005 Y92.872 E.00986
G1 X85.739 Y92.46 E.00986
G1 X85.515 Y92.023 E.00987
G1 X85.336 Y91.567 E.00987
G1 X85.203 Y91.095 E.00985
G1 X85.118 Y90.612 E.00987
G1 X85.081 Y90.123 E.00986
G1 X85.094 Y89.632 E.00986
G1 X85.155 Y89.146 E.00986
G1 X85.264 Y88.667 E.00987
G1 X85.42 Y88.202 E.00986
G1 X85.622 Y87.755 E.00986
G1 X85.867 Y87.331 E.00986
G1 X86.153 Y86.932 E.00986
G1 X86.478 Y86.565 E.00986
G1 X86.837 Y86.231 E.00986
G1 X87.228 Y85.935 E.00986
G1 X87.647 Y85.679 E.00986
G1 X88.089 Y85.466 E.00987
G1 X88.55 Y85.299 E.00986
G1 X89.025 Y85.178 E.00986
G1 X89.506 Y85.105 E.00979
G1 X89.845 Y85.084 E.00682
G1 X90.247 Y85.086 E.00808
G1 X90.733 Y85.135 E.00983
G1 X91.214 Y85.232 E.00986
G1 X91.683 Y85.377 E.00987
G1 X92.134 Y85.567 E.00986
G1 X92.565 Y85.802 E.00987
G1 X92.971 Y86.078 E.00986
G1 X93.346 Y86.393 E.00986
G1 X93.689 Y86.744 E.00986
G1 X93.995 Y87.128 E.00986
G1 X94.261 Y87.54 E.00986
G1 X94.484 Y87.977 E.00987
G1 X94.664 Y88.433 E.00987
G1 X94.796 Y88.905 E.00986
G1 X94.882 Y89.388 E.00986
G1 X94.918 Y89.877 E.00986
G1 X94.906 Y90.368 E.00986
G1 X94.845 Y90.854 E.00986
G1 X94.736 Y91.333 E.00987
G1 X94.58 Y91.798 E.00986
G1 X94.391 Y92.215 E.00921
M204 S250
G1 X94.01 Y92.064 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1800
M204 S5000
G1 X93.788 Y92.447 E.00827
G1 X93.527 Y92.811 E.00838
G1 X93.067 Y93.307 E.01263
G1 X92.723 Y93.595 E.00839
G1 X92.352 Y93.848 E.0084
G1 X91.957 Y94.064 E.0084
G1 X91.542 Y94.238 E.0084
G1 X91.113 Y94.371 E.0084
G1 X90.672 Y94.46 E.0084
G1 X90.225 Y94.505 E.0084
G1 X89.775 Y94.505 E.0084
G1 X89.328 Y94.46 E.0084
G1 X88.887 Y94.371 E.0084
G1 X88.457 Y94.238 E.0084
G1 X88.043 Y94.064 E.0084
G1 X87.648 Y93.849 E.0084
G1 X87.276 Y93.595 E.0084
G1 X86.932 Y93.306 E.0084
G1 X86.618 Y92.984 E.0084
G1 X86.338 Y92.633 E.0084
G1 X86.094 Y92.255 E.0084
G1 X85.889 Y91.855 E.0084
G1 X85.724 Y91.436 E.0084
G1 X85.603 Y91.004 E.0084
G1 X85.525 Y90.561 E.0084
G1 X85.491 Y90.112 E.0084
G1 X85.502 Y89.663 E.0084
G1 X85.558 Y89.217 E.0084
G1 X85.658 Y88.778 E.00841
G1 X85.801 Y88.352 E.0084
G1 X85.986 Y87.942 E.0084
G1 X86.211 Y87.553 E.0084
G1 X86.474 Y87.188 E.0084
G1 X86.771 Y86.851 E.0084
G1 X87.101 Y86.545 E.0084
G1 X87.459 Y86.273 E.0084
G1 X87.843 Y86.039 E.0084
G1 X88.248 Y85.844 E.00841
G1 X88.67 Y85.69 E.0084
G1 X89.106 Y85.579 E.0084
G1 X89.55 Y85.512 E.00838
G1 X90.225 Y85.495 E.01263
G1 X90.672 Y85.54 E.00839
G1 X91.113 Y85.629 E.0084
G1 X91.542 Y85.762 E.0084
G1 X91.957 Y85.936 E.0084
G1 X92.352 Y86.152 E.00841
G1 X92.723 Y86.405 E.0084
G1 X93.067 Y86.694 E.0084
G1 X93.381 Y87.016 E.0084
G1 X93.662 Y87.367 E.0084
G1 X93.906 Y87.745 E.0084
G1 X94.111 Y88.145 E.0084
G1 X94.275 Y88.564 E.0084
G1 X94.397 Y88.996 E.0084
G1 X94.475 Y89.439 E.0084
G1 X94.509 Y89.888 E.0084
G1 X94.497 Y90.337 E.0084
G1 X94.442 Y90.783 E.0084
G1 X94.342 Y91.222 E.0084
G1 X94.198 Y91.648 E.00841
G1 X94.035 Y92.01 E.00741
; WIPE_START
M204 S6000
G1 X93.788 Y92.447 E-.07156
G1 X93.527 Y92.811 E-.06388
G1 X93.067 Y93.307 E-.09632
G1 X92.781 Y93.547 E-.05324
; WIPE_END
G1 E-.015
M204 S10000
G1 X88.492 Y87.233 Z1.92 F18000
G1 X86.762 Y84.686 Z1.92
G1 Z1.52
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F2541
M204 S6000
G1 X87.268 Y84.409 E.01161
G1 X87.899 Y84.143 E.01378
G1 X88.447 Y83.974 E.01153
G1 X89.119 Y83.84 E.01377
G1 X89.694 Y83.785 E.01161
G1 X90.271 Y83.783 E.01161
G1 X90.953 Y83.851 E.01377
G1 X91.515 Y83.965 E.01153
G1 X92.169 Y84.168 E.01377
G1 X92.7 Y84.394 E.01161
G1 X93.208 Y84.668 E.01162
G1 X93.775 Y85.053 E.01377
G1 X94.217 Y85.424 E.01161
G1 X94.623 Y85.836 E.01162
G1 X95.053 Y86.369 E.01377
G1 X95.366 Y86.849 E.01153
G1 X95.68 Y87.458 E.01377
G1 X95.889 Y87.992 E.01153
G1 X96.074 Y88.651 E.01378
G1 X96.174 Y89.221 E.01162
G1 X96.219 Y89.8 E.01168
G1 X96.21 Y90.379 E.01164
G1 X96.131 Y91.06 E.01378
G1 X96.007 Y91.62 E.01154
G1 X95.793 Y92.272 E.01381
G1 X95.472 Y92.956 E.01519
G1 X95.165 Y93.467 E.01198
G1 X94.823 Y93.93 E.01158
G1 X94.357 Y94.44 E.01389
G1 X94.01 Y94.759 E.00948
G1 X93.46 Y95.171 E.01381
G1 X92.97 Y95.468 E.01153
G1 X92.351 Y95.761 E.01376
G1 X91.807 Y95.954 E.0116
G1 X91.249 Y96.096 E.01158
G1 X90.578 Y96.195 E.01363
G1 X89.917 Y96.221 E.01331
G1 X89.357 Y96.19 E.01127
G1 X88.788 Y96.104 E.01157
G1 X88.127 Y95.934 E.01374
G1 X87.585 Y95.735 E.0116
G1 X87.064 Y95.486 E.01161
G1 X86.479 Y95.131 E.01377
G1 X86.021 Y94.785 E.01153
G1 X85.519 Y94.318 E.01378
G1 X85.138 Y93.884 E.01162
G1 X84.798 Y93.415 E.01163
G1 X84.454 Y92.823 E.01378
G1 X84.218 Y92.3 E.01154
G1 X84 Y91.65 E.01378
G1 X83.872 Y91.086 E.01163
G1 X83.799 Y90.512 E.01162
G1 X83.78 Y89.827 E.01378
G1 X83.822 Y89.255 E.01153
G1 X83.941 Y88.581 E.01377
G1 X84.099 Y88.025 E.01162
G1 X84.308 Y87.486 E.01162
G1 X84.618 Y86.876 E.01377
G1 X84.929 Y86.393 E.01153
G1 X85.356 Y85.858 E.01377
G1 X85.757 Y85.448 E.01154
G1 X86.283 Y85.01 E.01377
G1 X86.712 Y84.72 E.01041
M204 S10000
G1 X86.541 Y84.323 F18000
G1 F2541
M204 S6000
G1 X87.083 Y84.027 E.01244
G1 X87.754 Y83.743 E.01464
G1 X88.343 Y83.562 E.01239
G1 X89.057 Y83.42 E.01463
G1 X89.673 Y83.36 E.01244
G1 X90.292 Y83.359 E.01245
G1 X91.016 Y83.431 E.01463
G1 X91.62 Y83.553 E.01239
G1 X92.315 Y83.769 E.01463
G1 X92.884 Y84.011 E.01244
G1 X93.429 Y84.305 E.01245
G1 X94.031 Y84.714 E.01463
G1 X94.505 Y85.112 E.01244
G1 X94.94 Y85.553 E.01245
G1 X95.397 Y86.119 E.01463
G1 X95.733 Y86.636 E.0124
G1 X96.067 Y87.283 E.01464
G1 X96.292 Y87.856 E.01239
G1 X96.489 Y88.558 E.01464
G1 X96.595 Y89.168 E.01245
G1 X96.644 Y89.787 E.01249
G1 X96.634 Y90.406 E.01246
G1 X96.55 Y91.13 E.01464
G1 X96.417 Y91.732 E.0124
G1 X96.189 Y92.425 E.01467
G1 X95.843 Y93.163 E.01639
G1 X95.519 Y93.703 E.01266
G1 X95.151 Y94.2 E.01243
G1 X94.658 Y94.74 E.01471
G1 X94.281 Y95.085 E.01027
G1 X93.698 Y95.523 E.01466
G1 X93.171 Y95.842 E.0124
G1 X92.513 Y96.153 E.01462
G1 X91.931 Y96.361 E.01243
G1 X91.332 Y96.512 E.01242
G1 X90.618 Y96.618 E.01452
G1 X89.913 Y96.646 E.01418
G1 X89.314 Y96.612 E.01207
G1 X88.704 Y96.52 E.01241
G1 X88 Y96.339 E.0146
G1 X87.42 Y96.127 E.01243
G1 X86.862 Y95.86 E.01244
G1 X86.24 Y95.482 E.01463
G1 X85.748 Y95.11 E.0124
G1 X85.215 Y94.614 E.01465
G1 X84.806 Y94.149 E.01245
G1 X84.442 Y93.647 E.01246
G1 X84.076 Y93.017 E.01465
G1 X83.822 Y92.455 E.01241
G1 X83.591 Y91.764 E.01465
G1 X83.454 Y91.16 E.01246
G1 X83.375 Y90.545 E.01245
G1 X83.355 Y89.817 E.01465
G1 X83.4 Y89.202 E.0124
G1 X83.527 Y88.486 E.01464
G1 X83.696 Y87.89 E.01245
G1 X83.92 Y87.313 E.01245
G1 X84.25 Y86.664 E.01464
G1 X84.584 Y86.146 E.0124
G1 X85.038 Y85.577 E.01463
G1 X85.469 Y85.136 E.0124
G1 X86.028 Y84.67 E.01463
G1 X86.491 Y84.357 E.01124
M204 S250
G1 X86.327 Y83.974 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1800
M204 S5000
G1 X86.905 Y83.658 E.01231
G1 X87.614 Y83.358 E.01437
G1 X88.243 Y83.165 E.01229
G1 X88.997 Y83.015 E.01437
G1 X89.653 Y82.951 E.01231
G1 X90.312 Y82.95 E.01231
G1 X91.077 Y83.025 E.01437
G1 X91.722 Y83.156 E.0123
G1 X92.456 Y83.384 E.01437
G1 X93.062 Y83.642 E.01231
G1 X93.642 Y83.955 E.01231
G1 X94.278 Y84.387 E.01437
G1 X94.783 Y84.811 E.01231
G1 X95.245 Y85.28 E.01231
G1 X95.728 Y85.878 E.01437
G1 X96.087 Y86.43 E.01229
G1 X96.44 Y87.114 E.01438
G1 X96.681 Y87.726 E.01229
G1 X96.888 Y88.467 E.01438
G1 X97.002 Y89.116 E.01232
G1 X97.053 Y89.774 E.01232
G1 X97.043 Y90.433 E.01232
G1 X96.955 Y91.198 E.01438
G1 X96.812 Y91.841 E.0123
G1 X96.572 Y92.572 E.01439
G1 X96.201 Y93.362 E.01631
G1 X95.859 Y93.93 E.01238
G1 X95.468 Y94.46 E.01231
G1 X94.947 Y95.029 E.0144
M73 P69 R3
G1 X94.543 Y95.4 E.01025
G1 X93.928 Y95.863 E.01439
G1 X93.365 Y96.203 E.0123
G1 X92.67 Y96.532 E.01436
G1 X92.05 Y96.753 E.01229
G1 X91.413 Y96.914 E.01228
G1 X90.656 Y97.026 E.0143
G1 X89.91 Y97.056 E.01395
G1 X89.272 Y97.02 E.01194
G1 X88.622 Y96.921 E.01227
G1 X87.879 Y96.731 E.01434
G1 X87.261 Y96.504 E.01229
G1 X86.667 Y96.22 E.01231
G1 X86.01 Y95.821 E.01437
G1 X85.485 Y95.424 E.0123
G1 X84.921 Y94.9 E.01438
G1 X84.486 Y94.404 E.01232
G1 X84.099 Y93.87 E.01232
G1 X83.712 Y93.205 E.01439
G1 X83.441 Y92.605 E.0123
G1 X83.196 Y91.875 E.01439
G1 X83.051 Y91.231 E.01233
G1 X82.967 Y90.577 E.01232
G1 X82.945 Y89.808 E.01438
G1 X82.994 Y89.152 E.0123
G1 X83.128 Y88.394 E.01438
G1 X83.308 Y87.76 E.01232
G1 X83.546 Y87.146 E.01231
G1 X83.895 Y86.46 E.01438
G1 X84.251 Y85.907 E.0123
G1 X84.731 Y85.305 E.01437
G1 X85.191 Y84.835 E.0123
G1 X85.782 Y84.343 E.01437
G1 X86.278 Y84.007 E.01119
; WIPE_START
M204 S6000
G1 X86.905 Y83.658 E-.10237
G1 X87.614 Y83.358 E-.10961
G1 X88.104 Y83.208 E-.07302
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
G1 X0 Y90.0001 ; move to safe pos
G1 X-13.0 F3000 ; move to safe pos
M400
M1004 S5 P1  ; external shutter
M400 P300
M971 S11 C11 O0
G92 E0
G1 X0 F18000
M623

; SKIPTYPE: head_wrap_detect
M622.1 S1
M1002 judge_flag g39_3rd_layer_detect_flag
M622 J1
    ; enable nozzle clog detect at 3rd layer
    


    M622.1 S1
    M1002 judge_flag g39_detection_flag
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




G1 X88.418 Y84.446
G1 Z1.52
G1 E.3 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.477937
G1 F2400
M204 S6000
M73 P70 R3
G1 X88.844 Y84.338 E.0094
G1 X89.406 Y84.25 E.0122
G1 X89.813 Y84.222 E.00875
G1 X90.281 Y84.224 E.01003
G1 X90.887 Y84.285 E.01305
G1 X91.416 Y84.393 E.01155
G1 X92.017 Y84.581 E.0135
G1 X92.51 Y84.789 E.01146
G1 X93.006 Y85.06 E.01211
G1 X93.501 Y85.397 E.01283
G1 X93.925 Y85.753 E.01187
G1 X94.328 Y86.166 E.01236
G1 X94.698 Y86.626 E.01266
G1 X95.002 Y87.099 E.01204
G1 X95.276 Y87.632 E.01284
G1 X95.478 Y88.148 E.01188
G1 X95.64 Y88.724 E.01283
G1 X95.738 Y89.276 E.01201
G1 X95.78 Y89.845 E.01222
G1 X95.766 Y90.421 E.01236
G1 X95.697 Y90.993 E.01235
G1 X95.569 Y91.555 E.01236
G1 X95.384 Y92.112 E.01258
G1 X95.138 Y92.647 E.01261
G1 X94.85 Y93.146 E.01235
G1 X94.519 Y93.606 E.01214
G1 X94.253 Y93.909 E.00865
G1 X93.921 Y94.247 E.01016
G1 X93.48 Y94.613 E.01228
G1 X93.004 Y94.938 E.01235
G1 X92.497 Y95.211 E.01234
G1 X91.987 Y95.428 E.01188
G1 X91.415 Y95.604 E.01283
G1 X90.85 Y95.716 E.01234
G1 X90.277 Y95.772 E.01235
G1 X89.723 Y95.774 E.01187
G1 X89.127 Y95.714 E.01283
G1 X88.563 Y95.598 E.01234
G1 X88.012 Y95.428 E.01235
G1 X87.482 Y95.203 E.01235
G1 X86.977 Y94.925 E.01235
G1 X86.501 Y94.601 E.01235
G1 X86.061 Y94.229 E.01235
G1 X85.673 Y93.833 E.01187
G1 X85.3 Y93.365 E.01283
G1 X84.99 Y92.88 E.01234
G1 X84.726 Y92.367 E.01236
G1 X84.518 Y91.83 E.01235
G1 X84.362 Y91.276 E.01234
G1 X84.263 Y90.708 E.01236
G1 X84.222 Y90.133 E.01234
G1 X84.236 Y89.557 E.01235
G1 X84.311 Y88.986 E.01234
G1 X84.439 Y88.423 E.01236
G1 X84.623 Y87.878 E.01235
G1 X84.862 Y87.353 E.01235
G1 X85.15 Y86.855 E.01234
G1 X85.489 Y86.388 E.01235
G1 X85.854 Y85.972 E.01188
G1 X86.277 Y85.58 E.01235
G1 X86.734 Y85.23 E.01234
G1 X87.245 Y84.918 E.01283
G1 X87.745 Y84.679 E.01188
G1 X88.286 Y84.48 E.01235
G1 X88.36 Y84.461 E.00165
; CHANGE_LAYER
; Z_HEIGHT: 1.64
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F2400
G1 X88.844 Y84.338 E-.07108
G1 X89.406 Y84.25 E-.0811
G1 X89.813 Y84.222 E-.05817
G1 X90.281 Y84.224 E-.06672
G1 X90.337 Y84.23 E-.00793
; WIPE_END
G1 E-.015 F1800
; layer num/total_layer_count: 13/33
; update layer progress
M73 L13
M991 S0 P12 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z1.92 I-1.074 J.572 P1  F18000
G1 X94.73 Y92.483 Z1.92
G1 Z1.64
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F2470
M204 S6000
G1 X94.49 Y92.9 E.00968
G1 X94.179 Y93.332 E.01071
G1 X93.826 Y93.732 E.01071
G1 X93.435 Y94.094 E.01072
G1 X93 Y94.424 E.01097
G1 X92.331 Y94.81 E.01554
G1 X91.828 Y95.022 E.01097
G1 X91.319 Y95.18 E.01072
G1 X90.796 Y95.285 E.01071
G1 X90.266 Y95.338 E.01071
G1 X89.733 Y95.338 E.01071
G1 X89.203 Y95.285 E.01071
G1 X88.681 Y95.18 E.01071
G1 X88.172 Y95.022 E.01072
G1 X87.681 Y94.815 E.01071
G1 X87.213 Y94.561 E.01071
G1 X86.773 Y94.261 E.01072
G1 X86.364 Y93.918 E.01072
G1 X85.992 Y93.537 E.01071
G1 X85.66 Y93.12 E.01071
G1 X85.371 Y92.672 E.01072
G1 X85.128 Y92.198 E.01072
G1 X84.933 Y91.702 E.01072
G1 X84.789 Y91.19 E.0107
G1 X84.697 Y90.665 E.01072
G1 X84.657 Y90.133 E.01071
G1 X84.67 Y89.601 E.01071
G1 X84.736 Y89.072 E.01071
G1 X84.855 Y88.552 E.01072
G1 X85.025 Y88.047 E.01071
G1 X85.244 Y87.561 E.01072
G1 X85.51 Y87.1 E.01071
G1 X85.821 Y86.668 E.01071
G1 X86.174 Y86.268 E.01071
G1 X86.564 Y85.906 E.01072
G1 X86.989 Y85.584 E.01071
G1 X87.444 Y85.306 E.01072
G1 X87.924 Y85.075 E.01071
G1 X88.425 Y84.893 E.01071
G1 X88.941 Y84.761 E.01071
G1 X89.462 Y84.683 E.01061
G1 X89.84 Y84.66 E.00762
G1 X90.269 Y84.662 E.00862
G1 X90.796 Y84.715 E.01065
G1 X91.319 Y84.82 E.01071
G1 X91.828 Y84.978 E.01072
G1 X92.319 Y85.185 E.01071
G1 X92.787 Y85.439 E.01071
G1 X93.227 Y85.739 E.01071
G1 X93.635 Y86.082 E.01072
G1 X94.007 Y86.463 E.01071
G1 X94.339 Y86.88 E.01071
G1 X94.629 Y87.328 E.01072
G1 X94.872 Y87.802 E.01072
G1 X95.066 Y88.298 E.01071
G1 X95.211 Y88.81 E.01071
G1 X95.303 Y89.335 E.01072
G1 X95.343 Y89.867 E.01071
G1 X95.33 Y90.399 E.01071
G1 X95.263 Y90.928 E.01071
G1 X95.145 Y91.448 E.01072
G1 X94.975 Y91.953 E.01071
G1 X94.759 Y92.431 E.01055
M204 S10000
G1 X94.363 Y92.271 F18000
G1 F2470
M204 S6000
G1 X94.133 Y92.669 E.00925
G1 X93.846 Y93.068 E.00986
G1 X93.522 Y93.435 E.00986
G1 X93.162 Y93.769 E.00986
G1 X92.765 Y94.07 E.01001
G1 X92.142 Y94.43 E.01448
G1 X91.683 Y94.623 E.01002
G1 X91.214 Y94.768 E.00987
G1 X90.733 Y94.865 E.00986
G1 X90.245 Y94.914 E.00986
G1 X89.755 Y94.914 E.00986
G1 X89.267 Y94.865 E.00986
G1 X88.786 Y94.768 E.00986
G1 X88.317 Y94.623 E.00987
G1 X87.865 Y94.433 E.00986
G1 X87.434 Y94.198 E.00986
G1 X87.029 Y93.922 E.00986
G1 X86.653 Y93.607 E.00986
G1 X86.311 Y93.256 E.00986
G1 X86.005 Y92.872 E.00986
G1 X85.739 Y92.46 E.00986
G1 X85.515 Y92.023 E.00987
G1 X85.336 Y91.567 E.00987
G1 X85.203 Y91.095 E.00985
G1 X85.118 Y90.612 E.00987
G1 X85.081 Y90.123 E.00986
G1 X85.094 Y89.632 E.00986
G1 X85.155 Y89.146 E.00986
G1 X85.264 Y88.667 E.00987
G1 X85.42 Y88.202 E.00986
G1 X85.622 Y87.755 E.00986
G1 X85.867 Y87.331 E.00986
G1 X86.153 Y86.932 E.00986
G1 X86.478 Y86.565 E.00986
G1 X86.837 Y86.231 E.00986
G1 X87.228 Y85.935 E.00986
G1 X87.647 Y85.679 E.00987
G1 X88.089 Y85.466 E.00986
G1 X88.55 Y85.299 E.00986
G1 X89.025 Y85.178 E.00986
G1 X89.507 Y85.105 E.0098
G1 X89.852 Y85.084 E.00696
G1 X90.247 Y85.086 E.00794
G1 X90.733 Y85.135 E.00982
G1 X91.214 Y85.232 E.00986
G1 X91.683 Y85.377 E.00987
G1 X92.135 Y85.567 E.00986
G1 X92.565 Y85.802 E.00986
G1 X92.97 Y86.078 E.00986
G1 X93.346 Y86.393 E.00986
G1 X93.689 Y86.744 E.00986
G1 X93.994 Y87.128 E.00986
G1 X94.261 Y87.54 E.00986
G1 X94.485 Y87.977 E.00987
G1 X94.664 Y88.433 E.00986
G1 X94.796 Y88.905 E.00986
G1 X94.882 Y89.388 E.00987
G1 X94.918 Y89.877 E.00986
G1 X94.906 Y90.368 E.00986
G1 X94.845 Y90.854 E.00986
G1 X94.736 Y91.333 E.00987
G1 X94.58 Y91.797 E.00986
G1 X94.39 Y92.218 E.00927
M204 S250
G1 X94.008 Y92.066 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1800
M204 S5000
G1 X93.789 Y92.447 E.00821
G1 X93.526 Y92.812 E.0084
G1 X93.229 Y93.149 E.0084
G1 X92.899 Y93.455 E.0084
G1 X92.539 Y93.728 E.00845
G1 X91.959 Y94.063 E.0125
G1 X91.543 Y94.238 E.00845
G1 X91.113 Y94.371 E.00841
G1 X90.672 Y94.46 E.0084
G1 X90.225 Y94.505 E.0084
G1 X89.775 Y94.505 E.0084
G1 X89.328 Y94.46 E.0084
G1 X88.887 Y94.371 E.0084
G1 X88.457 Y94.238 E.00841
G1 X88.043 Y94.064 E.0084
G1 X87.648 Y93.849 E.0084
G1 X87.277 Y93.595 E.0084
G1 X86.932 Y93.306 E.0084
G1 X86.618 Y92.984 E.0084
G1 X86.338 Y92.633 E.0084
G1 X86.094 Y92.255 E.0084
G1 X85.889 Y91.855 E.0084
G1 X85.724 Y91.436 E.0084
G1 X85.603 Y91.004 E.0084
G1 X85.525 Y90.561 E.0084
G1 X85.491 Y90.112 E.0084
G1 X85.502 Y89.663 E.0084
G1 X85.558 Y89.217 E.0084
G1 X85.658 Y88.778 E.00841
G1 X85.801 Y88.352 E.0084
G1 X85.986 Y87.942 E.0084
G1 X86.211 Y87.553 E.0084
G1 X86.474 Y87.188 E.0084
G1 X86.771 Y86.851 E.0084
G1 X87.101 Y86.545 E.0084
G1 X87.459 Y86.274 E.0084
G1 X87.843 Y86.039 E.00841
G1 X88.248 Y85.844 E.0084
G1 X88.67 Y85.69 E.0084
G1 X89.106 Y85.579 E.0084
G1 X89.55 Y85.512 E.00838
G1 X90.225 Y85.495 E.01263
G1 X90.672 Y85.54 E.00839
G1 X91.113 Y85.629 E.0084
G1 X91.543 Y85.762 E.00841
G1 X91.957 Y85.936 E.0084
G1 X92.352 Y86.151 E.0084
G1 X92.723 Y86.405 E.0084
G1 X93.068 Y86.694 E.0084
G1 X93.381 Y87.016 E.0084
G1 X93.662 Y87.367 E.0084
G1 X93.906 Y87.745 E.0084
G1 X94.111 Y88.145 E.0084
G1 X94.275 Y88.564 E.0084
G1 X94.397 Y88.996 E.0084
G1 X94.475 Y89.439 E.0084
G1 X94.509 Y89.888 E.0084
G1 X94.497 Y90.337 E.0084
G1 X94.442 Y90.783 E.0084
G1 X94.342 Y91.222 E.0084
G1 X94.198 Y91.648 E.0084
G1 X94.034 Y92.012 E.00747
; WIPE_START
M204 S6000
G1 X93.789 Y92.447 E-.07116
G1 X93.526 Y92.812 E-.06408
G1 X93.229 Y93.149 E-.06409
G1 X92.899 Y93.455 E-.06406
G1 X92.778 Y93.547 E-.02161
; WIPE_END
G1 E-.015
M204 S10000
G1 X88.489 Y87.234 Z2.04 F18000
G1 X86.852 Y84.824 Z2.04
G1 Z1.64
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F2470
M204 S6000
G1 X87.321 Y84.567 E.01077
G1 X87.972 Y84.292 E.01421
G1 X88.478 Y84.137 E.01064
G1 X89.171 Y84 E.01421
G1 X89.704 Y83.949 E.01077
G1 X90.24 Y83.947 E.01078
G1 X90.943 Y84.016 E.0142
G1 X91.462 Y84.121 E.01064
G1 X92.136 Y84.332 E.0142
G1 X92.629 Y84.542 E.01077
G1 X93.101 Y84.796 E.01077
G1 X93.686 Y85.193 E.01421
G1 X94.096 Y85.537 E.01076
G1 X94.474 Y85.917 E.01079
G1 X94.919 Y86.466 E.0142
G1 X95.209 Y86.908 E.01064
G1 X95.534 Y87.536 E.01421
G1 X95.728 Y88.029 E.01065
G1 X95.918 Y88.71 E.01422
G1 X96.01 Y89.238 E.01078
G1 X96.053 Y89.778 E.01089
G1 X96.048 Y90.315 E.01081
G1 X95.971 Y91.019 E.01422
G1 X95.858 Y91.542 E.01076
G1 X95.695 Y92.059 E.01091
G1 X95.485 Y92.564 E.011
G1 X95.28 Y92.964 E.00903
G1 X94.991 Y93.43 E.01102
G1 X94.661 Y93.869 E.01103
G1 X94.201 Y94.362 E.01355
G1 X93.783 Y94.73 E.0112
G1 X93.346 Y95.05 E.0109
G1 X92.887 Y95.325 E.01075
G1 X92.248 Y95.624 E.01419
G1 X91.75 Y95.799 E.01062
G1 X91.066 Y95.962 E.01415
G1 X90.543 Y96.033 E.0106
G1 X89.868 Y96.055 E.01358
G1 X89.361 Y96.024 E.01022
G1 X88.834 Y95.944 E.01072
G1 X88.152 Y95.769 E.01416
G1 X87.65 Y95.584 E.01075
G1 X87.167 Y95.354 E.01077
G1 X86.562 Y94.988 E.0142
G1 X86.14 Y94.669 E.01065
G1 X85.622 Y94.187 E.01422
G1 X85.268 Y93.783 E.01079
G1 X84.952 Y93.349 E.0108
G1 X84.596 Y92.738 E.01423
G1 X84.377 Y92.255 E.01066
G1 X84.153 Y91.584 E.01423
G1 X84.035 Y91.06 E.01079
G1 X83.965 Y90.528 E.01079
G1 X83.945 Y89.821 E.01423
G1 X83.984 Y89.293 E.01065
G1 X84.107 Y88.597 E.01422
G1 X84.254 Y88.081 E.01078
G1 X84.446 Y87.581 E.01078
G1 X84.766 Y86.95 E.01421
G1 X85.052 Y86.505 E.01064
G1 X85.493 Y85.953 E.01421
G1 X85.863 Y85.575 E.01064
G1 X86.407 Y85.123 E.01421
G1 X86.802 Y84.858 E.00957
M204 S10000
G1 X86.631 Y84.462 F18000
G1 F2470
M204 S6000
G1 X87.136 Y84.184 E.01159
G1 X87.827 Y83.893 E.01508
G1 X88.374 Y83.725 E.01151
G1 X89.11 Y83.579 E.01507
G1 X89.684 Y83.525 E.01159
G1 X90.26 Y83.523 E.0116
G1 X91.006 Y83.596 E.01507
G1 X91.568 Y83.71 E.01152
G1 X92.283 Y83.933 E.01507
G1 X92.813 Y84.16 E.01159
G1 X93.321 Y84.433 E.01159
G1 X93.942 Y84.854 E.01508
G1 X94.383 Y85.224 E.01158
G1 X94.79 Y85.633 E.01161
G1 X95.263 Y86.215 E.01508
G1 X95.576 Y86.694 E.01151
G1 X95.92 Y87.36 E.01508
G1 X96.13 Y87.893 E.01152
G1 X96.333 Y88.616 E.01509
G1 X96.431 Y89.185 E.0116
G1 X96.478 Y89.763 E.01166
G1 X96.472 Y90.341 E.01162
G1 X96.39 Y91.087 E.01509
G1 X96.268 Y91.65 E.01159
G1 X96.094 Y92.205 E.01168
G1 X95.87 Y92.743 E.01173
G1 X95.649 Y93.173 E.00971
G1 X95.342 Y93.67 E.01175
G1 X94.99 Y94.137 E.01175
G1 X94.492 Y94.671 E.0147
G1 X94.049 Y95.061 E.01185
G1 X93.581 Y95.403 E.01167
G1 X93.087 Y95.7 E.01158
G1 X92.409 Y96.017 E.01506
G1 X91.87 Y96.207 E.01149
G1 X91.144 Y96.38 E.01501
G1 X90.579 Y96.456 E.01146
G1 X89.862 Y96.48 E.01441
G1 X89.316 Y96.446 E.011
G1 X88.749 Y96.361 E.01154
G1 X88.025 Y96.174 E.01502
G1 X87.486 Y95.975 E.01157
G1 X86.965 Y95.728 E.01158
G1 X86.324 Y95.34 E.01507
G1 X85.867 Y94.994 E.01153
G1 X85.317 Y94.483 E.01509
G1 X84.937 Y94.048 E.01161
G1 X84.597 Y93.581 E.01162
G1 X84.219 Y92.932 E.0151
G1 X83.982 Y92.41 E.01154
G1 X83.744 Y91.698 E.0151
G1 X83.617 Y91.134 E.01161
G1 X83.542 Y90.562 E.01161
G1 X83.52 Y89.812 E.0151
G1 X83.562 Y89.24 E.01152
G1 X83.693 Y88.501 E.01509
G1 X83.851 Y87.946 E.0116
G1 X84.058 Y87.408 E.0116
G1 X84.397 Y86.739 E.01508
G1 X84.707 Y86.258 E.01151
M73 P71 R3
G1 X85.175 Y85.671 E.01508
G1 X85.575 Y85.262 E.01151
G1 X86.152 Y84.783 E.01508
G1 X86.581 Y84.495 E.01039
M204 S250
G1 X86.418 Y84.112 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1800
M204 S5000
G1 X86.958 Y83.816 E.0115
G1 X87.687 Y83.508 E.01479
G1 X88.274 Y83.327 E.01148
G1 X89.051 Y83.174 E.01479
G1 X89.664 Y83.116 E.01151
G1 X90.28 Y83.114 E.01151
G1 X91.067 Y83.191 E.01478
G1 X91.669 Y83.313 E.01148
G1 X92.425 Y83.549 E.01479
G1 X92.991 Y83.791 E.0115
G1 X93.533 Y84.083 E.01151
G1 X94.188 Y84.527 E.01479
G1 X94.66 Y84.922 E.0115
G1 X95.095 Y85.359 E.01151
G1 X95.594 Y85.973 E.01479
G1 X95.93 Y86.488 E.01148
G1 X96.294 Y87.191 E.01479
G1 X96.519 Y87.763 E.01149
G1 X96.732 Y88.526 E.0148
G1 X96.837 Y89.133 E.01152
G1 X96.887 Y89.748 E.01153
G1 X96.881 Y90.365 E.01152
G1 X96.795 Y91.153 E.01481
G1 X96.664 Y91.755 E.01152
G1 X96.479 Y92.345 E.01155
G1 X96.242 Y92.916 E.01156
G1 X96.006 Y93.374 E.00964
G1 X95.68 Y93.901 E.01157
G1 X95.308 Y94.396 E.01157
G1 X95.013 Y94.729 E.0083
G1 X94.772 Y94.97 E.00638
G1 X94.306 Y95.38 E.0116
G1 X93.807 Y95.745 E.01153
G1 X93.28 Y96.062 E.0115
G1 X92.564 Y96.397 E.01477
G1 X91.985 Y96.6 E.01146
G1 X91.219 Y96.783 E.01473
G1 X90.613 Y96.865 E.01142
G1 X89.856 Y96.89 E.01415
G1 X89.273 Y96.854 E.01092
G1 X88.667 Y96.762 E.01145
G1 X87.903 Y96.565 E.01474
G1 X87.327 Y96.353 E.01148
G1 X86.771 Y96.089 E.0115
G1 X86.094 Y95.679 E.01479
G1 X85.603 Y95.308 E.01149
G1 X85.023 Y94.768 E.01481
G1 X84.617 Y94.304 E.01153
G1 X84.254 Y93.805 E.01153
G1 X83.854 Y93.12 E.01481
G1 X83.601 Y92.56 E.0115
G1 X83.349 Y91.808 E.01481
G1 X83.214 Y91.206 E.01152
G1 X83.134 Y90.595 E.01152
G1 X83.11 Y89.802 E.01481
G1 X83.156 Y89.189 E.01149
G1 X83.294 Y88.409 E.0148
G1 X83.463 Y87.817 E.01151
G1 X83.684 Y87.242 E.01151
G1 X84.042 Y86.536 E.0148
G1 X84.374 Y86.019 E.01148
G1 X84.868 Y85.4 E.01479
G1 X85.298 Y84.961 E.01148
G1 X85.907 Y84.455 E.01479
G1 X86.368 Y84.145 E.01039
; WIPE_START
M204 S6000
G1 X86.958 Y83.816 E-.09625
G1 X87.687 Y83.508 E-.1128
G1 X88.196 Y83.351 E-.07594
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
G1 X0 Y90.0001 ; move to safe pos
G1 X-13.0 F3000 ; move to safe pos
M400
M1004 S5 P1  ; external shutter
M400 P300
M971 S11 C11 O0
G92 E0
G1 X0 F18000
M623

; SKIPTYPE: head_wrap_detect
M622.1 S1
M1002 judge_flag g39_3rd_layer_detect_flag
M622 J1
    ; enable nozzle clog detect at 3rd layer
    


    M622.1 S1
    M1002 judge_flag g39_detection_flag
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




G1 X88.489 Y84.513
G1 Z1.64
G1 E.3 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.313194
G1 F2400
M204 S6000
G1 X88.864 Y84.418 E.00527
G1 X89.419 Y84.331 E.00765
G1 X89.826 Y84.304 E.00556
G1 X90.281 Y84.308 E.00621
G1 X90.89 Y84.37 E.00834
G1 X91.399 Y84.474 E.00708
G1 X92.012 Y84.668 E.00876
G1 X92.474 Y84.864 E.00684
G1 X92.966 Y85.133 E.00763
G1 X93.447 Y85.46 E.00793
G1 X93.872 Y85.816 E.00755
G1 X94.268 Y86.224 E.00774
G1 X94.631 Y86.676 E.0079
G1 X94.932 Y87.144 E.00758
G1 X95.209 Y87.684 E.00826
G1 X95.401 Y88.178 E.00722
G1 X95.569 Y88.788 E.00863
G1 X95.656 Y89.284 E.00685
G1 X95.698 Y89.851 E.00774
G1 X95.682 Y90.419 E.00774
G1 X95.615 Y90.983 E.00774
G1 X95.488 Y91.537 E.00774
G1 X95.306 Y92.075 E.00774
G1 X95.073 Y92.593 E.00774
G1 X94.782 Y93.097 E.00793
G1 X94.451 Y93.559 E.00774
G1 X94.083 Y93.973 E.00755
G1 X93.657 Y94.37 E.00793
G1 X93.204 Y94.714 E.00776
G1 X92.48 Y95.129 E.01137
G1 X91.956 Y95.352 E.00776
G1 X91.412 Y95.518 E.00775
G1 X90.856 Y95.634 E.00773
G1 X90.277 Y95.69 E.00793
G1 X89.723 Y95.692 E.00754
G1 X89.158 Y95.636 E.00774
G1 X88.601 Y95.522 E.00774
G1 X88.057 Y95.357 E.00774
G1 X87.521 Y95.131 E.00793
G1 X87.024 Y94.857 E.00773
G1 X86.554 Y94.538 E.00774
G1 X86.12 Y94.171 E.00774
G1 X85.732 Y93.776 E.00755
G1 X85.369 Y93.321 E.00793
G1 X85.063 Y92.842 E.00774
G1 X84.803 Y92.337 E.00774
G1 X84.598 Y91.807 E.00774
G1 X84.443 Y91.261 E.00773
G1 X84.345 Y90.702 E.00774
G1 X84.305 Y90.135 E.00773
G1 X84.318 Y89.567 E.00774
G1 X84.391 Y89.004 E.00774
G1 X84.513 Y88.463 E.00755
G1 X84.698 Y87.912 E.00793
G1 X84.934 Y87.395 E.00774
G1 X85.217 Y86.902 E.00774
G1 X85.551 Y86.443 E.00774
G1 X85.916 Y86.026 E.00755
G1 X86.333 Y85.641 E.00774
G1 X86.784 Y85.296 E.00773
G1 X87.281 Y84.992 E.00794
G1 X87.781 Y84.754 E.00755
G1 X88.314 Y84.557 E.00774
G1 X88.431 Y84.527 E.00164
; CHANGE_LAYER
; Z_HEIGHT: 1.76
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F2400
G1 X88.864 Y84.418 E-.0637
G1 X89.419 Y84.331 E-.08
G1 X89.826 Y84.304 E-.05815
G1 X90.281 Y84.308 E-.0649
G1 X90.409 Y84.321 E-.01824
; WIPE_END
G1 E-.015 F1800
; layer num/total_layer_count: 14/33
; update layer progress
M73 L14
M991 S0 P13 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z2.04 I-1.076 J.569 P1  F18000
G1 X94.729 Y92.485 Z2.04
G1 Z1.76
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F2402
M204 S6000
G1 X94.49 Y92.9 E.00962
G1 X94.182 Y93.328 E.01061
G1 X93.929 Y93.62 E.00777
G1 X93.633 Y93.92 E.00848
G1 X93.227 Y94.261 E.01065
G1 X92.787 Y94.561 E.01071
G1 X92.319 Y94.815 E.01071
G1 X91.828 Y95.022 E.01072
G1 X91.319 Y95.18 E.01072
G1 X90.796 Y95.285 E.01071
G1 X90.266 Y95.338 E.01071
G1 X89.733 Y95.338 E.01071
G1 X89.203 Y95.285 E.01071
G1 X88.681 Y95.18 E.01071
G1 X88.172 Y95.022 E.01072
G1 X87.681 Y94.815 E.01071
G1 X87.213 Y94.561 E.01071
G1 X86.773 Y94.261 E.01071
G1 X86.364 Y93.918 E.01072
G1 X85.992 Y93.537 E.01071
G1 X85.66 Y93.12 E.01072
G1 X85.371 Y92.672 E.01071
G1 X85.128 Y92.198 E.01072
G1 X84.933 Y91.702 E.01071
G1 X84.789 Y91.19 E.01071
G1 X84.697 Y90.665 E.01072
G1 X84.657 Y90.133 E.01071
G1 X84.67 Y89.601 E.01071
G1 X84.736 Y89.072 E.01071
G1 X84.855 Y88.552 E.01072
G1 X85.025 Y88.047 E.01071
G1 X85.244 Y87.561 E.01072
G1 X85.51 Y87.1 E.01071
G1 X85.821 Y86.668 E.01071
G1 X86.174 Y86.268 E.01072
G1 X86.564 Y85.906 E.01071
G1 X86.989 Y85.584 E.01071
G1 X87.444 Y85.306 E.01072
G1 X87.924 Y85.075 E.01071
G1 X88.425 Y84.893 E.01071
G1 X88.941 Y84.761 E.01071
G1 X89.462 Y84.683 E.01061
G1 X89.848 Y84.659 E.00776
G1 X90.27 Y84.662 E.00848
G1 X90.796 Y84.715 E.01064
G1 X91.319 Y84.82 E.01071
G1 X91.828 Y84.978 E.01072
G1 X92.319 Y85.185 E.01071
G1 X92.787 Y85.439 E.01071
G1 X93.227 Y85.739 E.01071
G1 X93.635 Y86.082 E.01072
G1 X94.007 Y86.463 E.01071
G1 X94.339 Y86.88 E.01072
G1 X94.628 Y87.327 E.01071
G1 X94.872 Y87.802 E.01072
G1 X95.066 Y88.298 E.01071
G1 X95.211 Y88.81 E.01071
G1 X95.303 Y89.335 E.01072
G1 X95.343 Y89.867 E.01071
G1 X95.33 Y90.399 E.01071
G1 X95.263 Y90.928 E.01071
G1 X95.145 Y91.448 E.01072
G1 X94.975 Y91.953 E.01071
G1 X94.758 Y92.433 E.0106
M204 S10000
G1 X94.361 Y92.273 F18000
G1 F2402
M204 S6000
G1 X94.133 Y92.669 E.0092
G1 X93.848 Y93.065 E.0098
G1 X93.617 Y93.332 E.0071
G1 X93.345 Y93.608 E.0078
G1 X92.97 Y93.922 E.00982
G1 X92.565 Y94.198 E.00986
G1 X92.135 Y94.433 E.00986
G1 X91.683 Y94.623 E.00987
G1 X91.214 Y94.768 E.00987
G1 X90.733 Y94.865 E.00986
G1 X90.245 Y94.914 E.00986
G1 X89.755 Y94.914 E.00986
G1 X89.267 Y94.865 E.00986
G1 X88.786 Y94.768 E.00986
G1 X88.317 Y94.623 E.00987
G1 X87.865 Y94.433 E.00986
G1 X87.434 Y94.198 E.00986
G1 X87.029 Y93.922 E.00986
G1 X86.653 Y93.607 E.00986
G1 X86.311 Y93.255 E.00986
G1 X86.005 Y92.872 E.00986
G1 X85.739 Y92.46 E.00986
G1 X85.515 Y92.023 E.00987
G1 X85.336 Y91.567 E.00986
G1 X85.203 Y91.095 E.00986
G1 X85.118 Y90.612 E.00987
G1 X85.081 Y90.123 E.00986
G1 X85.094 Y89.632 E.00986
G1 X85.155 Y89.146 E.00986
G1 X85.264 Y88.667 E.00987
G1 X85.42 Y88.202 E.00986
G1 X85.622 Y87.755 E.00986
G1 X85.867 Y87.331 E.00986
G1 X86.153 Y86.933 E.00986
G1 X86.478 Y86.565 E.00987
G1 X86.837 Y86.231 E.00986
G1 X87.228 Y85.935 E.00986
G1 X87.647 Y85.679 E.00987
G1 X88.089 Y85.466 E.00986
G1 X88.55 Y85.299 E.00986
G1 X89.025 Y85.178 E.00986
G1 X89.507 Y85.105 E.0098
G1 X89.859 Y85.084 E.0071
G1 X90.247 Y85.086 E.0078
G1 X90.733 Y85.135 E.00982
G1 X91.214 Y85.232 E.00986
G1 X91.683 Y85.377 E.00987
G1 X92.135 Y85.567 E.00986
G1 X92.565 Y85.802 E.00986
G1 X92.97 Y86.078 E.00986
G1 X93.346 Y86.393 E.00987
G1 X93.689 Y86.744 E.00986
G1 X93.995 Y87.128 E.00986
G1 X94.261 Y87.54 E.00986
G1 X94.485 Y87.977 E.00987
G1 X94.664 Y88.433 E.00986
G1 X94.796 Y88.905 E.00986
G1 X94.882 Y89.388 E.00987
G1 X94.918 Y89.877 E.00986
G1 X94.906 Y90.368 E.00986
G1 X94.845 Y90.854 E.00986
G1 X94.736 Y91.333 E.00987
G1 X94.58 Y91.798 E.00986
G1 X94.389 Y92.22 E.00932
M204 S250
G1 X94.007 Y92.069 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1800
M204 S5000
G1 X93.789 Y92.447 E.00817
G1 X93.527 Y92.811 E.00838
G1 X93.067 Y93.307 E.01263
G1 X92.723 Y93.595 E.00839
G1 X92.352 Y93.848 E.0084
G1 X91.957 Y94.064 E.0084
G1 X91.542 Y94.238 E.0084
G1 X91.113 Y94.371 E.0084
G1 X90.672 Y94.46 E.0084
G1 X90.225 Y94.505 E.0084
G1 X89.775 Y94.505 E.0084
G1 X89.328 Y94.46 E.0084
G1 X88.887 Y94.371 E.0084
G1 X88.457 Y94.238 E.0084
G1 X88.043 Y94.064 E.0084
G1 X87.648 Y93.849 E.0084
G1 X87.277 Y93.595 E.0084
G1 X86.932 Y93.306 E.0084
G1 X86.618 Y92.984 E.0084
G1 X86.338 Y92.633 E.0084
G1 X86.094 Y92.255 E.0084
G1 X85.889 Y91.855 E.0084
G1 X85.724 Y91.436 E.0084
G1 X85.603 Y91.004 E.0084
G1 X85.525 Y90.561 E.0084
G1 X85.491 Y90.112 E.0084
G1 X85.502 Y89.663 E.0084
G1 X85.558 Y89.217 E.0084
G1 X85.658 Y88.778 E.00841
G1 X85.801 Y88.352 E.0084
G1 X85.986 Y87.942 E.0084
G1 X86.211 Y87.553 E.0084
G1 X86.474 Y87.188 E.0084
G1 X86.771 Y86.851 E.0084
G1 X87.101 Y86.545 E.0084
G1 X87.459 Y86.273 E.0084
G1 X87.843 Y86.039 E.00841
G1 X88.248 Y85.844 E.0084
G1 X88.67 Y85.69 E.0084
G1 X89.106 Y85.579 E.0084
G1 X89.55 Y85.512 E.00839
G1 X90.225 Y85.495 E.01263
G1 X90.672 Y85.54 E.00839
G1 X91.113 Y85.629 E.0084
G1 X91.542 Y85.762 E.0084
G1 X91.957 Y85.936 E.0084
G1 X92.352 Y86.151 E.0084
G1 X92.723 Y86.405 E.0084
G1 X93.068 Y86.694 E.0084
G1 X93.382 Y87.016 E.0084
G1 X93.662 Y87.367 E.0084
G1 X93.906 Y87.745 E.0084
G1 X94.111 Y88.145 E.0084
G1 X94.275 Y88.563 E.0084
G1 X94.397 Y88.996 E.0084
G1 X94.475 Y89.439 E.0084
G1 X94.509 Y89.888 E.0084
G1 X94.497 Y90.337 E.0084
G1 X94.442 Y90.783 E.0084
G1 X94.342 Y91.222 E.0084
G1 X94.198 Y91.648 E.00841
G1 X94.033 Y92.014 E.00751
; WIPE_START
M204 S6000
G1 X93.789 Y92.447 E-.07079
G1 X93.527 Y92.811 E-.06392
G1 X93.067 Y93.307 E-.09632
G1 X92.777 Y93.55 E-.05397
; WIPE_END
G1 E-.015
M204 S10000
G1 X88.487 Y87.237 Z2.16 F18000
G1 X86.941 Y84.963 Z2.16
G1 Z1.76
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F2402
M204 S6000
G1 X87.374 Y84.725 E.00993
G1 X88.045 Y84.441 E.01464
G1 X88.509 Y84.299 E.00975
G1 X89.223 Y84.159 E.01464
G1 X89.715 Y84.114 E.00994
G1 X90.209 Y84.111 E.00994
G1 X90.934 Y84.182 E.01463
M73 P72 R3
G1 X91.409 Y84.278 E.00976
G1 X92.103 Y84.496 E.01463
G1 X92.558 Y84.691 E.00994
G1 X92.993 Y84.924 E.00994
G1 X93.596 Y85.332 E.01464
G1 X93.975 Y85.649 E.00993
G1 X94.325 Y85.999 E.00995
G1 X94.786 Y86.562 E.01464
G1 X95.052 Y86.968 E.00975
G1 X95.388 Y87.614 E.01465
G1 X95.566 Y88.066 E.00975
G1 X95.762 Y88.768 E.01466
G1 X95.846 Y89.255 E.00995
G1 X95.888 Y89.757 E.01012
G1 X95.887 Y90.252 E.00996
G1 X95.811 Y90.978 E.01466
G1 X95.708 Y91.462 E.00995
G1 X95.562 Y91.944 E.01014
G1 X95.377 Y92.408 E.01004
G1 X95.087 Y92.97 E.01272
G1 X94.818 Y93.391 E.01005
G1 X94.505 Y93.799 E.01032
G1 X94.025 Y94.303 E.01401
G1 X93.638 Y94.635 E.01025
G1 X93.23 Y94.929 E.01012
G1 X92.805 Y95.182 E.00993
G1 X92.146 Y95.488 E.01462
G1 X91.689 Y95.645 E.00972
G1 X90.984 Y95.809 E.01456
G1 X90.505 Y95.871 E.0097
G1 X89.82 Y95.89 E.01378
G1 X89.375 Y95.859 E.00897
G1 X88.661 Y95.738 E.01456
G1 X88.195 Y95.609 E.00971
G1 X87.519 Y95.344 E.0146
G1 X87.079 Y95.118 E.00995
G1 X86.653 Y94.851 E.01012
G1 X86.259 Y94.553 E.00995
G1 X85.725 Y94.056 E.01466
G1 X85.399 Y93.683 E.00996
G1 X85.106 Y93.283 E.00997
G1 X84.738 Y92.653 E.01466
G1 X84.537 Y92.21 E.00979
G1 X84.306 Y91.518 E.01466
G1 X84.198 Y91.034 E.00996
G1 X84.132 Y90.544 E.00995
G1 X84.11 Y89.815 E.01467
G1 X84.145 Y89.33 E.00976
G1 X84.273 Y88.613 E.01465
G1 X84.409 Y88.137 E.00994
G1 X84.585 Y87.675 E.00995
G1 X84.913 Y87.025 E.01464
G1 X85.175 Y86.617 E.00976
G1 X85.629 Y86.048 E.01464
G1 X85.969 Y85.701 E.00976
G1 X86.53 Y85.237 E.01463
G1 X86.891 Y84.996 E.00873
M204 S10000
G1 X86.721 Y84.6 F18000
G1 F2402
M204 S6000
G1 X87.189 Y84.342 E.01074
G1 X87.9 Y84.042 E.01552
G1 X88.405 Y83.887 E.01063
G1 X89.163 Y83.738 E.01552
G1 X89.694 Y83.69 E.01074
G1 X90.229 Y83.687 E.01075
G1 X90.996 Y83.762 E.01551
G1 X91.515 Y83.867 E.01064
G1 X92.251 Y84.097 E.01551
G1 X92.742 Y84.308 E.01074
G1 X93.213 Y84.561 E.01075
G1 X93.852 Y84.993 E.01552
G1 X94.261 Y85.336 E.01073
G1 X94.64 Y85.713 E.01075
G1 X95.128 Y86.311 E.01552
G1 X95.419 Y86.753 E.01063
G1 X95.775 Y87.438 E.01553
G1 X95.969 Y87.93 E.01063
G1 X96.177 Y88.674 E.01553
G1 X96.267 Y89.202 E.01076
G1 X96.312 Y89.74 E.01085
G1 X96.311 Y90.275 E.01076
G1 X96.23 Y91.044 E.01555
G1 X96.12 Y91.567 E.01076
G1 X95.963 Y92.085 E.01087
G1 X95.763 Y92.584 E.01081
G1 X95.455 Y93.182 E.01352
G1 X95.165 Y93.635 E.01082
G1 X94.833 Y94.069 E.01098
G1 X94.313 Y94.615 E.01516
G1 X93.9 Y94.969 E.01093
G1 X93.462 Y95.284 E.01085
G1 X93.004 Y95.558 E.01074
G1 X92.305 Y95.882 E.01549
G1 X91.806 Y96.054 E.0106
G1 X91.059 Y96.228 E.01543
G1 X90.538 Y96.294 E.01056
G1 X89.811 Y96.314 E.01462
G1 X89.325 Y96.281 E.0098
G1 X88.568 Y96.153 E.01542
G1 X88.061 Y96.012 E.01059
G1 X87.344 Y95.731 E.01547
G1 X86.869 Y95.487 E.01074
G1 X86.412 Y95.2 E.01085
G1 X85.985 Y94.878 E.01075
G1 X85.42 Y94.351 E.01554
G1 X85.068 Y93.948 E.01077
G1 X84.751 Y93.516 E.01077
G1 X84.361 Y92.848 E.01555
G1 X84.142 Y92.365 E.01066
G1 X83.897 Y91.632 E.01555
G1 X83.78 Y91.109 E.01077
G1 X83.709 Y90.579 E.01076
G1 X83.685 Y89.806 E.01555
G1 X83.724 Y89.278 E.01064
G1 X83.859 Y88.517 E.01553
G1 X84.006 Y88.003 E.01075
G1 X84.197 Y87.504 E.01075
G1 X84.544 Y86.815 E.01552
G1 X84.83 Y86.369 E.01064
G1 X85.311 Y85.766 E.01552
G1 X85.682 Y85.388 E.01064
G1 X86.276 Y84.897 E.01551
G1 X86.671 Y84.633 E.00954
M204 S250
G1 X86.508 Y84.25 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1800
M204 S5000
G1 X87.01 Y83.974 E.0107
G1 X87.76 Y83.657 E.01521
G1 X88.306 Y83.49 E.01067
G1 X89.104 Y83.333 E.01521
G1 X89.675 Y83.281 E.0107
G1 X90.248 Y83.277 E.01071
G1 X91.057 Y83.356 E.0152
G1 X91.617 Y83.47 E.01067
G1 X92.393 Y83.713 E.0152
G1 X92.92 Y83.939 E.01071
G1 X93.425 Y84.21 E.01071
G1 X94.099 Y84.666 E.01521
G1 X94.538 Y85.034 E.0107
G1 X94.944 Y85.438 E.01071
G1 X95.459 Y86.069 E.01521
G1 X95.772 Y86.546 E.01067
G1 X96.148 Y87.269 E.01522
G1 X96.357 Y87.8 E.01067
G1 X96.576 Y88.585 E.01522
G1 X96.673 Y89.15 E.01072
G1 X96.721 Y89.723 E.01075
G1 X96.72 Y90.297 E.01072
G1 X96.635 Y91.108 E.01524
G1 X96.516 Y91.669 E.01073
G1 X96.349 Y92.22 E.01076
G1 X96.136 Y92.754 E.01074
G1 X95.811 Y93.386 E.01329
G1 X95.501 Y93.871 E.01075
G1 X95.149 Y94.329 E.0108
G1 X94.926 Y94.581 E.00629
G1 X94.591 Y94.915 E.00883
G1 X94.154 Y95.291 E.01077
G1 X93.687 Y95.627 E.01074
G1 X93.195 Y95.92 E.01071
G1 X92.458 Y96.262 E.01518
G1 X91.92 Y96.447 E.01064
G1 X91.132 Y96.631 E.01512
G1 X90.57 Y96.703 E.01059
G1 X89.803 Y96.724 E.01433
G1 X89.276 Y96.688 E.00986
G1 X88.479 Y96.553 E.0151
G1 X87.931 Y96.401 E.01063
G1 X87.176 Y96.105 E.01517
G1 X86.666 Y95.843 E.0107
G1 X86.18 Y95.537 E.01074
G1 X85.722 Y95.192 E.01072
G1 X85.125 Y94.636 E.01524
G1 X84.748 Y94.204 E.01073
G1 X84.408 Y93.74 E.01073
G1 X83.997 Y93.036 E.01524
G1 X83.76 Y92.515 E.0107
G1 X83.502 Y91.741 E.01524
G1 X83.377 Y91.181 E.01073
G1 X83.301 Y90.612 E.01072
G1 X83.276 Y89.797 E.01524
G1 X83.317 Y89.227 E.01068
G1 X83.46 Y88.425 E.01522
G1 X83.617 Y87.874 E.01071
G1 X83.822 Y87.338 E.01071
G1 X84.188 Y86.611 E.01521
G1 X84.497 Y86.13 E.01068
G1 X85.005 Y85.494 E.01521
G1 X85.405 Y85.087 E.01068
G1 X86.032 Y84.568 E.0152
G1 X86.458 Y84.283 E.00958
; WIPE_START
M204 S6000
G1 X87.01 Y83.974 E-.09014
G1 X87.76 Y83.657 E-.11599
G1 X88.289 Y83.495 E-.07887
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
G1 X0 Y90.0001 ; move to safe pos
G1 X-13.0 F3000 ; move to safe pos
M400
M1004 S5 P1  ; external shutter
M400 P300
M971 S11 C11 O0
G92 E0
G1 X0 F18000
M623

; SKIPTYPE: head_wrap_detect
M622.1 S1
M1002 judge_flag g39_3rd_layer_detect_flag
M622 J1
    ; enable nozzle clog detect at 3rd layer
    


    M622.1 S1
    M1002 judge_flag g39_detection_flag
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




G1 X88.559 Y84.58
G1 Z1.76
G1 E.3 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.148191
G1 F2400
M204 S6000
G1 X88.885 Y84.499 E.00194
G1 X89.431 Y84.413 E.00321
G1 X89.839 Y84.386 E.00237
G1 X90.281 Y84.391 E.00257
G1 X90.893 Y84.454 E.00357
G1 X91.383 Y84.556 E.0029
G1 X92.008 Y84.754 E.00381
G1 X92.438 Y84.938 E.00272
G1 X92.926 Y85.206 E.00323
G1 X93.394 Y85.524 E.00328
G1 X93.819 Y85.88 E.00322
G1 X94.208 Y86.282 E.00325
G1 X94.565 Y86.725 E.0033
G1 X94.862 Y87.189 E.0032
G1 X95.138 Y87.728 E.00351
G1 X95.323 Y88.208 E.00298
G1 X95.493 Y88.828 E.00373
G1 X95.575 Y89.298 E.00277
G1 X95.615 Y89.857 E.00325
G1 X95.599 Y90.417 E.00325
G1 X95.533 Y90.972 E.00325
G1 X95.407 Y91.518 E.00325
G1 X95.228 Y92.049 E.00325
G1 X94.997 Y92.559 E.00325
G1 X94.719 Y93.044 E.00325
G1 X94.397 Y93.494 E.00321
G1 X94.129 Y93.802 E.00237
G1 X93.82 Y94.119 E.00257
G1 X93.394 Y94.476 E.00322
G1 X92.931 Y94.791 E.00325
G1 X92.433 Y95.059 E.00328
G1 X91.924 Y95.277 E.00322
G1 X91.388 Y95.44 E.00325
G1 X90.84 Y95.554 E.00325
G1 X90.277 Y95.608 E.00328
G1 X89.723 Y95.61 E.00321
G1 X89.166 Y95.551 E.00325
G1 X88.617 Y95.444 E.00325
G1 X88.082 Y95.276 E.00325
G1 X87.565 Y95.062 E.00325
G1 X87.074 Y94.794 E.00325
G1 X86.606 Y94.475 E.00328
G1 X86.184 Y94.117 E.00322
G1 X85.791 Y93.718 E.00325
G1 X85.438 Y93.276 E.00328
G1 X85.137 Y92.804 E.00325
G1 X84.879 Y92.307 E.00325
G1 X84.68 Y91.79 E.00321
G1 X84.525 Y91.253 E.00325
G1 X84.427 Y90.695 E.00329
G1 X84.388 Y90.137 E.00325
G1 X84.399 Y89.577 E.00325
G1 X84.471 Y89.028 E.00321
G1 X84.593 Y88.481 E.00325
G1 X84.773 Y87.945 E.00328
G1 X85.006 Y87.436 E.00325
G1 X85.284 Y86.95 E.00325
G1 X85.609 Y86.503 E.00321
G1 X85.977 Y86.081 E.00325
G1 X86.39 Y85.702 E.00325
G1 X86.833 Y85.361 E.00325
G1 X87.317 Y85.066 E.00328
G1 X87.817 Y84.829 E.00322
G1 X88.342 Y84.634 E.00325
G1 X88.501 Y84.594 E.00095
; CHANGE_LAYER
; Z_HEIGHT: 1.88
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F2400
G1 X88.885 Y84.499 E-.05629
G1 X89.431 Y84.413 E-.07889
G1 X89.839 Y84.386 E-.05813
G1 X90.281 Y84.391 E-.0631
G1 X90.481 Y84.411 E-.02859
; WIPE_END
G1 E-.015 F1800
; layer num/total_layer_count: 15/33
; update layer progress
M73 L15
M991 S0 P14 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z2.16 I-1.077 J.566 P1  F18000
G1 X94.728 Y92.488 Z2.16
G1 Z1.88
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1775
M204 S6000
G1 X94.49 Y92.9 E.00957
G1 X94.181 Y93.328 E.01062
G1 X93.924 Y93.626 E.00791
G1 X93.632 Y93.921 E.00834
G1 X93.227 Y94.26 E.01063
G1 X92.787 Y94.561 E.01071
G1 X92.319 Y94.815 E.01071
G1 X91.828 Y95.022 E.01072
G1 X91.319 Y95.18 E.01072
G1 X90.796 Y95.285 E.01071
G1 X90.266 Y95.338 E.01071
G1 X89.733 Y95.338 E.01071
G1 X89.203 Y95.285 E.01071
G1 X88.681 Y95.18 E.01071
G1 X88.172 Y95.022 E.01072
G1 X87.681 Y94.815 E.01071
G1 X87.213 Y94.561 E.01071
G1 X86.773 Y94.261 E.01071
G1 X86.364 Y93.918 E.01072
G1 X85.992 Y93.537 E.01071
G1 X85.66 Y93.12 E.01072
G1 X85.371 Y92.673 E.01071
G1 X85.128 Y92.198 E.01072
G1 X84.933 Y91.702 E.01072
G1 X84.789 Y91.19 E.0107
G1 X84.697 Y90.665 E.01072
G1 X84.657 Y90.133 E.01071
G1 X84.67 Y89.601 E.01071
G1 X84.736 Y89.072 E.01071
G1 X84.855 Y88.552 E.01072
G1 X85.025 Y88.047 E.01071
G1 X85.244 Y87.561 E.01072
G1 X85.51 Y87.1 E.01071
G1 X85.821 Y86.668 E.01071
G1 X86.174 Y86.268 E.01071
G1 X86.564 Y85.906 E.01072
G1 X86.989 Y85.584 E.01071
G1 X87.444 Y85.306 E.01072
G1 X87.924 Y85.075 E.01071
G1 X88.425 Y84.893 E.01071
G1 X88.941 Y84.761 E.01071
G1 X89.463 Y84.683 E.01062
G1 X89.855 Y84.659 E.00791
G1 X90.27 Y84.662 E.00834
G1 X90.796 Y84.715 E.01063
G1 X91.319 Y84.82 E.01071
G1 X91.828 Y84.978 E.01072
G1 X92.319 Y85.185 E.01071
G1 X92.787 Y85.439 E.01071
G1 X93.227 Y85.739 E.01071
G1 X93.635 Y86.082 E.01072
G1 X94.007 Y86.464 E.01072
G1 X94.339 Y86.88 E.01071
G1 X94.628 Y87.328 E.01071
G1 X94.872 Y87.802 E.01072
G1 X95.066 Y88.298 E.01071
G1 X95.211 Y88.81 E.01071
G1 X95.303 Y89.335 E.01072
G1 X95.343 Y89.867 E.01071
G1 X95.33 Y90.399 E.01071
G1 X95.263 Y90.928 E.01071
G1 X95.145 Y91.448 E.01072
G1 X94.975 Y91.953 E.01071
G1 X94.757 Y92.435 E.01065
M204 S10000
G1 X94.36 Y92.275 F18000
G1 F1775
M204 S6000
G1 X94.133 Y92.669 E.00914
G1 X93.848 Y93.065 E.00981
G1 X93.612 Y93.337 E.00724
G1 X93.344 Y93.608 E.00766
G1 X92.971 Y93.922 E.00981
G1 X92.565 Y94.198 E.00986
M73 P73 R3
G1 X92.135 Y94.433 E.00986
G1 X91.683 Y94.623 E.00986
G1 X91.214 Y94.768 E.00987
G1 X90.733 Y94.865 E.00986
G1 X90.245 Y94.914 E.00986
G1 X89.755 Y94.914 E.00986
G1 X89.267 Y94.865 E.00986
G1 X88.786 Y94.768 E.00986
G1 X88.317 Y94.623 E.00987
G1 X87.865 Y94.433 E.00986
G1 X87.434 Y94.198 E.00986
G1 X87.029 Y93.922 E.00986
G1 X86.653 Y93.607 E.00987
G1 X86.311 Y93.256 E.00986
G1 X86.005 Y92.872 E.00986
G1 X85.739 Y92.46 E.00986
G1 X85.515 Y92.023 E.00986
G1 X85.336 Y91.567 E.00987
G1 X85.203 Y91.095 E.00985
G1 X85.118 Y90.612 E.00987
G1 X85.081 Y90.123 E.00986
G1 X85.094 Y89.632 E.00986
G1 X85.155 Y89.146 E.00986
G1 X85.264 Y88.667 E.00987
G1 X85.42 Y88.202 E.00986
G1 X85.622 Y87.755 E.00986
G1 X85.867 Y87.331 E.00986
G1 X86.153 Y86.932 E.00986
G1 X86.478 Y86.565 E.00986
G1 X86.837 Y86.231 E.00986
G1 X87.228 Y85.935 E.00986
G1 X87.647 Y85.679 E.00986
G1 X88.089 Y85.466 E.00986
G1 X88.55 Y85.299 E.00986
G1 X89.025 Y85.178 E.00986
G1 X89.507 Y85.105 E.00981
G1 X89.866 Y85.084 E.00724
G1 X90.247 Y85.086 E.00766
G1 X90.733 Y85.135 E.00982
G1 X91.214 Y85.232 E.00986
G1 X91.683 Y85.377 E.00987
G1 X92.135 Y85.567 E.00986
G1 X92.565 Y85.802 E.00986
G1 X92.97 Y86.078 E.00986
G1 X93.346 Y86.393 E.00986
G1 X93.689 Y86.745 E.00986
G1 X93.995 Y87.128 E.00986
G1 X94.261 Y87.54 E.00986
G1 X94.484 Y87.977 E.00987
G1 X94.664 Y88.433 E.00986
G1 X94.796 Y88.905 E.00986
G1 X94.882 Y89.388 E.00987
G1 X94.918 Y89.877 E.00986
G1 X94.906 Y90.368 E.00986
G1 X94.845 Y90.854 E.00986
G1 X94.736 Y91.333 E.00987
G1 X94.58 Y91.797 E.00986
G1 X94.388 Y92.222 E.00937
M204 S250
G1 X94.006 Y92.071 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1775
M204 S5000
G1 X93.789 Y92.447 E.00812
G1 X93.527 Y92.811 E.00838
G1 X93.067 Y93.307 E.01263
G1 X92.723 Y93.595 E.00838
G1 X92.352 Y93.848 E.0084
G1 X91.957 Y94.064 E.0084
G1 X91.543 Y94.238 E.0084
G1 X91.113 Y94.371 E.00841
G1 X90.672 Y94.46 E.0084
G1 X90.225 Y94.505 E.0084
G1 X89.775 Y94.505 E.0084
G1 X89.328 Y94.46 E.0084
G1 X88.887 Y94.371 E.0084
G1 X88.457 Y94.238 E.00841
G1 X88.043 Y94.064 E.0084
G1 X87.648 Y93.849 E.0084
G1 X87.277 Y93.595 E.0084
G1 X86.932 Y93.306 E.0084
G1 X86.618 Y92.984 E.0084
G1 X86.338 Y92.633 E.0084
G1 X86.094 Y92.255 E.0084
G1 X85.889 Y91.855 E.0084
G1 X85.724 Y91.436 E.0084
G1 X85.603 Y91.004 E.0084
G1 X85.525 Y90.561 E.0084
G1 X85.491 Y90.112 E.0084
G1 X85.502 Y89.663 E.0084
G1 X85.558 Y89.217 E.0084
G1 X85.658 Y88.778 E.00841
G1 X85.801 Y88.352 E.0084
G1 X85.986 Y87.942 E.0084
G1 X86.211 Y87.553 E.0084
G1 X86.474 Y87.188 E.0084
G1 X86.771 Y86.851 E.0084
G1 X87.101 Y86.545 E.0084
G1 X87.459 Y86.273 E.0084
G1 X87.843 Y86.039 E.0084
G1 X88.248 Y85.844 E.0084
G1 X88.67 Y85.69 E.0084
G1 X89.106 Y85.579 E.0084
G1 X89.55 Y85.512 E.00839
G1 X90.225 Y85.495 E.01263
G1 X90.672 Y85.54 E.00839
G1 X91.113 Y85.629 E.0084
G1 X91.543 Y85.762 E.00841
G1 X91.957 Y85.936 E.0084
G1 X92.352 Y86.151 E.0084
G1 X92.723 Y86.405 E.0084
G1 X93.068 Y86.694 E.0084
G1 X93.382 Y87.016 E.0084
G1 X93.662 Y87.367 E.0084
G1 X93.906 Y87.745 E.0084
G1 X94.111 Y88.145 E.0084
G1 X94.275 Y88.564 E.0084
G1 X94.397 Y88.996 E.0084
G1 X94.475 Y89.439 E.0084
G1 X94.509 Y89.888 E.0084
G1 X94.497 Y90.337 E.0084
G1 X94.442 Y90.783 E.0084
G1 X94.342 Y91.222 E.0084
G1 X94.198 Y91.648 E.0084
G1 X94.032 Y92.017 E.00756
; WIPE_START
G1 F1800
M204 S6000
G1 X93.789 Y92.447 E-.07042
G1 X93.527 Y92.811 E-.06394
G1 X93.067 Y93.307 E-.09634
G1 X92.775 Y93.552 E-.05431
; WIPE_END
G1 E-.015
M204 S10000
G1 X88.494 Y87.233 Z2.28 F18000
G1 X87.028 Y85.067 Z2.28
G1 Z1.88
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1775
M204 S6000
G1 X87.549 Y84.788 E.01189
G1 X88.03 Y84.588 E.01046
G1 X88.562 Y84.423 E.01122
G1 X89.133 Y84.306 E.01171
G1 X89.746 Y84.246 E.01239
G1 X90.294 Y84.248 E.01103
G1 X90.872 Y84.307 E.01168
G1 X91.462 Y84.429 E.01211
G1 X91.994 Y84.597 E.01122
G1 X92.484 Y84.804 E.01069
G1 X92.969 Y85.065 E.01108
G1 X93.469 Y85.403 E.01213
G1 X93.887 Y85.75 E.01093
G1 X94.281 Y86.148 E.01126
G1 X94.647 Y86.598 E.01166
G1 X94.962 Y87.076 E.01151
G1 X95.219 Y87.565 E.01112
G1 X95.426 Y88.069 E.01096
G1 X95.592 Y88.624 E.01166
G1 X95.701 Y89.187 E.01151
G1 X95.755 Y89.787 E.01212
G1 X95.751 Y90.299 E.0103
G1 X95.685 Y90.922 E.01261
G1 X95.594 Y91.373 E.00925
G1 X95.423 Y91.939 E.01188
G1 X95.208 Y92.459 E.01132
G1 X94.914 Y93.003 E.01243
G1 X94.627 Y93.43 E.01034
G1 X94.28 Y93.854 E.01101
G1 X93.884 Y94.253 E.01131
G1 X93.415 Y94.637 E.01219
G1 X92.936 Y94.955 E.01155
G1 X92.48 Y95.198 E.01039
G1 X91.946 Y95.42 E.01163
G1 X91.384 Y95.59 E.01181
G1 X90.893 Y95.69 E.01008
G1 X90.244 Y95.754 E.01311
G1 X89.744 Y95.754 E.01007
G1 X89.208 Y95.705 E.01083
G1 X88.625 Y95.593 E.01193
G1 X88.071 Y95.427 E.01163
G1 X87.575 Y95.224 E.01077
G1 X87.057 Y94.951 E.01177
G1 X86.6 Y94.649 E.01102
G1 X86.165 Y94.297 E.01125
G1 X85.782 Y93.922 E.01076
G1 X85.398 Y93.463 E.01204
G1 X85.063 Y92.965 E.01207
G1 X84.787 Y92.449 E.01178
G1 X84.575 Y91.933 E.01121
G1 X84.419 Y91.422 E.01075
G1 X84.303 Y90.849 E.01175
G1 X84.248 Y90.297 E.01115
G1 X84.245 Y89.76 E.01079
G1 X84.299 Y89.182 E.01169
G1 X84.404 Y88.636 E.01117
G1 X84.578 Y88.058 E.01215
G1 X84.776 Y87.574 E.01051
G1 X85.047 Y87.061 E.01166
G1 X85.343 Y86.611 E.01084
G1 X85.719 Y86.148 E.01199
G1 X86.119 Y85.744 E.01144
G1 X86.503 Y85.424 E.01005
G1 X86.978 Y85.101 E.01154
M204 S10000
G1 X86.808 Y84.704 F18000
G1 F1775
M204 S6000
G1 X87.367 Y84.404 E.01276
G1 X87.885 Y84.189 E.01128
G1 X88.457 Y84.011 E.01204
G1 X89.07 Y83.886 E.01258
G1 X89.726 Y83.822 E.01326
G1 X90.317 Y83.824 E.01188
G1 X90.937 Y83.888 E.01254
G1 X91.569 Y84.018 E.01297
G1 X92.141 Y84.198 E.01206
G1 X92.667 Y84.421 E.01149
G1 X93.189 Y84.702 E.01191
G1 X93.724 Y85.063 E.01298
G1 X94.174 Y85.437 E.01177
G1 X94.597 Y85.864 E.01209
G1 X94.989 Y86.347 E.01251
G1 X95.327 Y86.86 E.01235
G1 X95.604 Y87.385 E.01194
G1 X95.826 Y87.927 E.01178
G1 X96.005 Y88.523 E.0125
G1 X96.122 Y89.127 E.01238
G1 X96.18 Y89.769 E.01296
G1 X96.175 Y90.323 E.01113
G1 X96.105 Y90.987 E.01343
G1 X96.005 Y91.477 E.01005
G1 X95.823 Y92.082 E.0127
G1 X95.592 Y92.641 E.01218
G1 X95.278 Y93.223 E.01329
G1 X94.967 Y93.683 E.01116
G1 X94.595 Y94.138 E.01182
G1 X94.17 Y94.567 E.01215
G1 X93.667 Y94.979 E.01306
G1 X93.154 Y95.32 E.01239
G1 X92.662 Y95.582 E.0112
G1 X92.09 Y95.82 E.01247
G1 X91.488 Y96.002 E.01264
G1 X90.956 Y96.11 E.01091
G1 X90.265 Y96.179 E.01396
G1 X89.724 Y96.178 E.01088
G1 X89.148 Y96.125 E.01163
G1 X88.524 Y96.005 E.01278
G1 X87.929 Y95.827 E.01247
G1 X87.395 Y95.609 E.0116
G1 X86.841 Y95.316 E.0126
G1 X86.349 Y94.992 E.01185
G1 X85.882 Y94.614 E.01207
G1 X85.471 Y94.211 E.01159
G1 X85.059 Y93.718 E.01291
G1 X84.699 Y93.184 E.01295
G1 X84.403 Y92.63 E.01264
G1 X84.175 Y92.076 E.01204
G1 X84.007 Y91.526 E.01156
G1 X83.882 Y90.912 E.0126
G1 X83.824 Y90.319 E.01198
G1 X83.821 Y89.742 E.01161
G1 X83.878 Y89.122 E.01252
G1 X83.992 Y88.535 E.01202
G1 X84.177 Y87.916 E.01299
G1 X84.391 Y87.394 E.01134
G1 X84.681 Y86.845 E.01249
G1 X85 Y86.36 E.01167
G1 X85.402 Y85.864 E.01284
G1 X85.832 Y85.431 E.01227
G1 X86.247 Y85.085 E.01087
G1 X86.758 Y84.737 E.01242
M204 S250
G1 X86.595 Y84.353 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1775
M204 S5000
G1 X87.191 Y84.034 E.01263
G1 X87.745 Y83.804 E.01121
G1 X88.355 Y83.615 E.01193
G1 X89.009 Y83.481 E.01246
G1 X89.707 Y83.413 E.01311
G1 X90.338 Y83.415 E.0118
G1 X90.999 Y83.483 E.01242
G1 X91.672 Y83.622 E.01283
G1 X92.282 Y83.814 E.01196
G1 X92.845 Y84.051 E.0114
G1 X93.401 Y84.351 E.01181
G1 X93.97 Y84.735 E.01283
G1 X94.451 Y85.135 E.01168
G1 X94.902 Y85.59 E.01198
G1 X95.32 Y86.105 E.01239
G1 X95.68 Y86.651 E.01223
G1 X95.975 Y87.212 E.01184
G1 X96.212 Y87.791 E.01169
G1 X96.403 Y88.425 E.01237
G1 X96.528 Y89.07 E.01227
G1 X96.589 Y89.753 E.01281
G1 X96.584 Y90.346 E.01109
G1 X96.51 Y91.049 E.01321
G1 X96.403 Y91.577 E.01006
G1 X96.209 Y92.219 E.01254
G1 X95.962 Y92.817 E.01209
G1 X95.628 Y93.435 E.01312
G1 X95.296 Y93.928 E.0111
G1 X94.9 Y94.412 E.0117
G1 X94.445 Y94.87 E.01205
G1 X93.911 Y95.308 E.01292
G1 X93.364 Y95.671 E.01227
G1 X92.837 Y95.952 E.01114
G1 X92.228 Y96.206 E.01233
G1 X91.588 Y96.4 E.0125
G1 X91.017 Y96.515 E.01088
G1 X90.285 Y96.588 E.01375
G1 X89.705 Y96.587 E.01084
G1 X89.091 Y96.531 E.01153
G1 X88.426 Y96.403 E.01264
G1 X87.793 Y96.214 E.01235
G1 X87.222 Y95.98 E.01152
G1 X86.632 Y95.669 E.01246
G1 X86.107 Y95.322 E.01176
G1 X85.61 Y94.92 E.01195
G1 X85.17 Y94.489 E.01151
G1 X84.731 Y93.965 E.01277
G1 X84.348 Y93.396 E.01282
G1 X84.032 Y92.804 E.01252
G1 X83.789 Y92.214 E.01193
G1 X83.61 Y91.627 E.01147
G1 X83.477 Y90.973 E.01246
G1 X83.415 Y90.34 E.01188
G1 X83.412 Y89.724 E.01152
G1 X83.473 Y89.064 E.01238
G1 X83.594 Y88.437 E.01193
G1 X83.791 Y87.779 E.01284
G1 X84.02 Y87.221 E.01128
G1 X84.328 Y86.636 E.01234
G1 X84.67 Y86.118 E.01159
G1 X85.097 Y85.59 E.01269
G1 X85.555 Y85.129 E.01215
G1 X86.001 Y84.757 E.01083
G1 X86.546 Y84.387 E.01232
; WIPE_START
G1 F1800
M204 S6000
G1 X87.191 Y84.034 E-.10484
G1 X87.745 Y83.804 E-.08549
G1 X88.355 Y83.615 E-.09098
G1 X88.381 Y83.609 E-.0037
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
G1 X0 Y90.0001 ; move to safe pos
G1 X-13.0 F3000 ; move to safe pos
M400
M1004 S5 P1  ; external shutter
M400 P300
M971 S11 C11 O0
G92 E0
G1 X0 F18000
M623

; SKIPTYPE: head_wrap_detect
M622.1 S1
M1002 judge_flag g39_3rd_layer_detect_flag
M622 J1
    ; enable nozzle clog detect at 3rd layer
    


    M622.1 S1
    M1002 judge_flag g39_detection_flag
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




; CHANGE_LAYER
; Z_HEIGHT: 2
; LAYER_HEIGHT: 0.12
; layer num/total_layer_count: 16/33
; update layer progress
M73 L16
M991 S0 P15 ;notify layer change
; OBJECT_ID: 8
G1 X94.726 Y92.49 F18000
G1 Z2
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1843
M204 S6000
G1 X94.49 Y92.9 E.00952
G1 X94.181 Y93.329 E.01062
G1 X93.919 Y93.631 E.00805
G1 X93.632 Y93.921 E.00819
G1 X93.227 Y94.261 E.01063
G1 X92.787 Y94.561 E.01071
G1 X92.319 Y94.815 E.01071
G1 X91.828 Y95.022 E.01072
G1 X91.319 Y95.18 E.01072
G1 X90.796 Y95.285 E.01071
G1 X90.266 Y95.338 E.01071
G1 X89.733 Y95.338 E.01071
G1 X89.203 Y95.285 E.01071
G1 X88.681 Y95.18 E.01071
G1 X88.172 Y95.022 E.01072
G1 X87.681 Y94.815 E.01071
G1 X87.213 Y94.561 E.01072
G1 X86.773 Y94.261 E.01071
G1 X86.364 Y93.918 E.01072
G1 X85.992 Y93.537 E.01071
G1 X85.66 Y93.12 E.01071
G1 X85.371 Y92.673 E.01071
G1 X85.128 Y92.198 E.01072
G1 X84.933 Y91.702 E.01071
G1 X84.789 Y91.189 E.01071
G1 X84.697 Y90.665 E.01072
G1 X84.657 Y90.133 E.01071
G1 X84.67 Y89.601 E.01071
G1 X84.736 Y89.072 E.01071
G1 X84.855 Y88.552 E.01072
G1 X85.025 Y88.047 E.01071
G1 X85.244 Y87.561 E.01072
G1 X85.51 Y87.1 E.01071
G1 X85.821 Y86.668 E.01071
G1 X86.174 Y86.268 E.01072
G1 X86.564 Y85.906 E.01071
G1 X86.989 Y85.584 E.01071
G1 X87.444 Y85.306 E.01072
G1 X87.924 Y85.075 E.01072
G1 X88.425 Y84.893 E.01071
G1 X88.941 Y84.761 E.01071
G1 X89.463 Y84.682 E.01063
G1 X89.863 Y84.659 E.00804
G1 X90.27 Y84.662 E.0082
G1 X90.796 Y84.715 E.01063
G1 X91.319 Y84.82 E.01071
G1 X91.828 Y84.978 E.01072
G1 X92.319 Y85.185 E.01071
G1 X92.787 Y85.439 E.01071
G1 X93.227 Y85.739 E.01071
G1 X93.635 Y86.082 E.01072
M73 P74 R3
G1 X94.007 Y86.463 E.01071
G1 X94.339 Y86.88 E.01072
G1 X94.628 Y87.328 E.01071
G1 X94.872 Y87.802 E.01072
G1 X95.066 Y88.298 E.01071
G1 X95.211 Y88.81 E.01071
G1 X95.303 Y89.335 E.01072
G1 X95.343 Y89.867 E.01071
G1 X95.33 Y90.399 E.01071
G1 X95.263 Y90.928 E.01071
G1 X95.145 Y91.448 E.01072
G1 X94.975 Y91.953 E.01071
G1 X94.756 Y92.438 E.0107
M204 S10000
G1 X94.359 Y92.278 F18000
G1 F1843
M204 S6000
G1 X94.133 Y92.669 E.00909
G1 X93.848 Y93.065 E.00981
G1 X93.608 Y93.343 E.00738
G1 X93.344 Y93.608 E.00752
G1 X92.97 Y93.922 E.00981
G1 X92.565 Y94.198 E.00986
G1 X92.135 Y94.433 E.00986
G1 X91.683 Y94.623 E.00986
G1 X91.214 Y94.768 E.00986
G1 X90.733 Y94.865 E.00986
G1 X90.245 Y94.914 E.00986
G1 X89.755 Y94.914 E.00986
G1 X89.267 Y94.865 E.00986
G1 X88.786 Y94.768 E.00986
G1 X88.317 Y94.623 E.00987
G1 X87.865 Y94.433 E.00986
G1 X87.434 Y94.198 E.00987
G1 X87.029 Y93.922 E.00986
G1 X86.653 Y93.607 E.00986
G1 X86.311 Y93.255 E.00986
G1 X86.005 Y92.872 E.00986
G1 X85.739 Y92.46 E.00986
G1 X85.515 Y92.023 E.00987
G1 X85.336 Y91.567 E.00986
G1 X85.203 Y91.095 E.00986
G1 X85.118 Y90.612 E.00986
G1 X85.081 Y90.123 E.00986
G1 X85.094 Y89.632 E.00986
G1 X85.155 Y89.146 E.00986
G1 X85.264 Y88.667 E.00987
G1 X85.42 Y88.202 E.00986
G1 X85.622 Y87.755 E.00986
G1 X85.867 Y87.331 E.00986
G1 X86.153 Y86.933 E.00986
G1 X86.478 Y86.565 E.00987
G1 X86.837 Y86.231 E.00986
G1 X87.228 Y85.935 E.00986
G1 X87.647 Y85.679 E.00987
G1 X88.089 Y85.466 E.00987
G1 X88.55 Y85.299 E.00986
G1 X89.025 Y85.178 E.00986
G1 X89.507 Y85.105 E.00981
G1 X89.874 Y85.083 E.00737
G1 X90.247 Y85.086 E.00752
G1 X90.733 Y85.135 E.00981
G1 X91.214 Y85.232 E.00986
G1 X91.683 Y85.377 E.00987
G1 X92.135 Y85.567 E.00986
G1 X92.565 Y85.802 E.00986
G1 X92.97 Y86.078 E.00986
G1 X93.346 Y86.393 E.00987
G1 X93.689 Y86.744 E.00986
G1 X93.995 Y87.128 E.00986
G1 X94.261 Y87.54 E.00986
G1 X94.485 Y87.977 E.00987
G1 X94.664 Y88.433 E.00986
G1 X94.796 Y88.905 E.00986
G1 X94.882 Y89.388 E.00987
G1 X94.918 Y89.877 E.00986
G1 X94.906 Y90.368 E.00986
G1 X94.845 Y90.854 E.00986
G1 X94.736 Y91.333 E.00987
G1 X94.58 Y91.798 E.00986
G1 X94.387 Y92.225 E.00942
M204 S250
G1 X94.004 Y92.073 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1800
M204 S5000
G1 X93.789 Y92.447 E.00807
G1 X93.527 Y92.811 E.00839
G1 X93.067 Y93.307 E.01263
G1 X92.723 Y93.595 E.00839
G1 X92.352 Y93.849 E.0084
G1 X91.957 Y94.064 E.0084
G1 X91.542 Y94.238 E.0084
G1 X91.113 Y94.371 E.0084
G1 X90.672 Y94.46 E.0084
G1 X90.225 Y94.505 E.0084
G1 X89.775 Y94.505 E.0084
G1 X89.328 Y94.46 E.0084
G1 X88.887 Y94.371 E.0084
G1 X88.457 Y94.238 E.0084
G1 X88.043 Y94.064 E.0084
G1 X87.648 Y93.848 E.00841
G1 X87.277 Y93.595 E.0084
G1 X86.932 Y93.306 E.0084
G1 X86.618 Y92.984 E.0084
G1 X86.338 Y92.633 E.0084
G1 X86.094 Y92.255 E.0084
G1 X85.889 Y91.855 E.0084
G1 X85.724 Y91.436 E.0084
G1 X85.603 Y91.004 E.0084
G1 X85.525 Y90.561 E.0084
G1 X85.491 Y90.112 E.0084
G1 X85.502 Y89.663 E.0084
G1 X85.558 Y89.217 E.0084
G1 X85.658 Y88.778 E.0084
G1 X85.801 Y88.352 E.00841
G1 X85.986 Y87.942 E.0084
G1 X86.211 Y87.553 E.0084
G1 X86.474 Y87.188 E.0084
G1 X86.771 Y86.851 E.0084
G1 X87.101 Y86.545 E.0084
G1 X87.459 Y86.274 E.0084
G1 X87.843 Y86.039 E.0084
G1 X88.248 Y85.844 E.00841
G1 X88.67 Y85.69 E.0084
G1 X89.106 Y85.579 E.0084
G1 X89.55 Y85.512 E.00839
G1 X90.225 Y85.495 E.01263
G1 X90.672 Y85.54 E.00839
G1 X91.113 Y85.629 E.0084
G1 X91.542 Y85.762 E.0084
G1 X91.957 Y85.936 E.0084
G1 X92.352 Y86.151 E.0084
G1 X92.723 Y86.405 E.0084
G1 X93.068 Y86.694 E.0084
G1 X93.382 Y87.016 E.0084
G1 X93.662 Y87.367 E.0084
G1 X93.906 Y87.745 E.0084
G1 X94.111 Y88.145 E.0084
G1 X94.275 Y88.563 E.0084
G1 X94.397 Y88.996 E.0084
G1 X94.475 Y89.439 E.0084
G1 X94.509 Y89.888 E.0084
G1 X94.497 Y90.337 E.0084
G1 X94.442 Y90.783 E.0084
G1 X94.341 Y91.222 E.0084
G1 X94.198 Y91.648 E.0084
G1 X94.031 Y92.019 E.00761
; WIPE_START
M204 S6000
G1 X93.789 Y92.447 E-.07004
G1 X93.527 Y92.811 E-.06395
G1 X93.067 Y93.307 E-.09632
G1 X92.773 Y93.554 E-.0547
; WIPE_END
G1 E-.015
M204 S10000
G1 X88.478 Y87.244 Z2.4 F18000
G1 X87.011 Y85.087 Z2.4
G1 Z2
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1843
M204 S6000
G1 X87.162 Y84.993 E.00359
G1 X87.817 Y84.676 E.01463
G1 X88.506 Y84.442 E.01463
G1 X88.962 Y84.339 E.00939
G1 X89.427 Y84.273 E.00944
G1 X90.083 Y84.247 E.0132
G1 X90.632 Y84.279 E.01108
G1 X91.09 Y84.349 E.00931
G1 X91.804 Y84.535 E.01485
G1 X92.232 Y84.695 E.00918
G1 X92.893 Y85.025 E.01484
G1 X93.28 Y85.271 E.00923
G1 X93.796 Y85.676 E.01319
G1 X94.187 Y86.052 E.01091
G1 X94.606 Y86.552 E.01312
G1 X94.91 Y86.999 E.01086
G1 X95.253 Y87.648 E.01477
G1 X95.423 Y88.072 E.00918
G1 X95.625 Y88.783 E.01486
G1 X95.706 Y89.244 E.00941
G1 X95.749 Y89.721 E.00962
G1 X95.752 Y90.189 E.00942
G1 X95.68 Y90.925 E.01487
G1 X95.586 Y91.384 E.00942
G1 X95.455 Y91.834 E.00941
G1 X95.174 Y92.519 E.01489
G1 X94.953 Y92.932 E.00943
G1 X94.691 Y93.334 E.00964
G1 X94.405 Y93.704 E.00942
G1 X93.893 Y94.239 E.01488
G1 X93.536 Y94.541 E.00941
G1 X93.146 Y94.819 E.00962
G1 X92.745 Y95.058 E.0094
G1 X92.076 Y95.368 E.01482
G1 X91.645 Y95.515 E.00914
G1 X90.93 Y95.68 E.01476
G1 X90.478 Y95.735 E.00916
G1 X89.85 Y95.753 E.01263
G1 X89.224 Y95.703 E.01263
G1 X88.774 Y95.623 E.00919
G1 X88.068 Y95.421 E.01478
G1 X87.645 Y95.252 E.00915
G1 X86.993 Y94.907 E.01484
G1 X86.604 Y94.647 E.0094
G1 X86.23 Y94.349 E.00962
G1 X85.881 Y94.02 E.00964
G1 X85.567 Y93.67 E.00946
G1 X85.177 Y93.139 E.01324
G1 X84.897 Y92.663 E.01111
G1 X84.695 Y92.233 E.00955
G1 X84.531 Y91.794 E.00942
G1 X84.348 Y91.085 E.01472
G1 X84.263 Y90.444 E.01301
G1 X84.245 Y89.892 E.0111
G1 X84.274 Y89.419 E.00954
G1 X84.342 Y88.944 E.00963
G1 X84.447 Y88.489 E.0094
G1 X84.683 Y87.8 E.01465
G1 X85.002 Y87.146 E.01463
G1 X85.246 Y86.756 E.00924
G1 X85.647 Y86.237 E.0132
G1 X86.026 Y85.837 E.01108
G1 X86.381 Y85.524 E.00953
G1 X86.766 Y85.239 E.00962
G1 X86.96 Y85.119 E.00459
M204 S10000
G1 X86.787 Y84.727 F18000
G1 F1843
M204 S6000
G1 X86.957 Y84.621 E.00403
G1 X87.656 Y84.282 E.01561
G1 X88.391 Y84.033 E.0156
G1 X88.885 Y83.921 E.01019
G1 X89.388 Y83.85 E.01022
G1 X90.087 Y83.822 E.01405
G1 X90.677 Y83.857 E.01189
G1 X91.176 Y83.933 E.01014
G1 X91.933 Y84.13 E.01573
G1 X92.401 Y84.306 E.01006
G1 X93.102 Y84.655 E.01573
G1 X93.525 Y84.924 E.01009
G1 X94.075 Y85.356 E.01405
G1 X94.498 Y85.762 E.0118
G1 X94.945 Y86.296 E.014
G1 X95.274 Y86.78 E.01177
G1 X95.638 Y87.47 E.01569
G1 X95.825 Y87.935 E.01007
G1 X96.039 Y88.688 E.01575
G1 X96.127 Y89.188 E.0102
G1 X96.173 Y89.7 E.01033
G1 X96.176 Y90.208 E.01022
G1 X96.1 Y90.989 E.01576
G1 X95.999 Y91.486 E.01021
G1 X95.856 Y91.974 E.01022
G1 X95.559 Y92.7 E.01578
G1 X95.318 Y93.148 E.01023
G1 X95.038 Y93.58 E.01035
G1 X94.726 Y93.982 E.01022
G1 X94.184 Y94.548 E.01577
G1 X93.796 Y94.877 E.01021
G1 X93.378 Y95.175 E.01033
G1 X92.943 Y95.434 E.01019
G1 X92.234 Y95.762 E.01571
G1 X91.762 Y95.923 E.01002
G1 X91.004 Y96.098 E.01564
G1 X90.51 Y96.159 E.01
G1 X89.839 Y96.178 E.0135
G1 X89.17 Y96.124 E.0135
G1 X88.679 Y96.037 E.01003
G1 X87.93 Y95.823 E.01566
G1 X87.467 Y95.637 E.01003
G1 X86.775 Y95.272 E.01572
G1 X86.354 Y94.99 E.0102
G1 X85.952 Y94.67 E.01033
G1 X85.577 Y94.317 E.01035
G1 X85.237 Y93.938 E.01024
G1 X84.823 Y93.372 E.0141
G1 X84.522 Y92.861 E.01193
G1 X84.304 Y92.397 E.0103
G1 X84.126 Y91.921 E.01022
G1 X83.931 Y91.167 E.01567
G1 X83.84 Y90.479 E.01396
G1 X83.821 Y89.886 E.01192
G1 X83.851 Y89.376 E.01028
G1 X83.924 Y88.866 E.01034
G1 X84.038 Y88.372 E.0102
G1 X84.29 Y87.637 E.01562
G1 X84.631 Y86.94 E.01561
G1 X84.897 Y86.514 E.0101
G1 X85.324 Y85.961 E.01405
G1 X85.731 Y85.531 E.01189
G1 X86.114 Y85.194 E.01027
G1 X86.527 Y84.888 E.01033
G1 X86.736 Y84.758 E.00495
M204 S250
G1 X86.571 Y84.379 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1800
M204 S5000
G1 X86.76 Y84.262 E.00415
G1 X87.5 Y83.903 E.01538
G1 X88.28 Y83.639 E.01538
G1 X88.811 Y83.518 E.01018
G1 X89.351 Y83.442 E.01019
G1 X90.09 Y83.412 E.01382
G1 X90.72 Y83.45 E.01178
G1 X91.258 Y83.532 E.01017
G1 X92.057 Y83.739 E.01542
G1 X92.565 Y83.93 E.01014
G1 X93.303 Y84.298 E.01542
G1 X93.762 Y84.59 E.01016
G1 X94.344 Y85.046 E.01382
G1 X94.797 Y85.482 E.01176
G1 X95.272 Y86.049 E.01381
G1 X95.626 Y86.569 E.01175
G1 X96.01 Y87.298 E.01541
G1 X96.212 Y87.802 E.01015
G1 X96.438 Y88.597 E.01543
G1 X96.533 Y89.134 E.0102
G1 X96.582 Y89.68 E.01024
G1 X96.586 Y90.227 E.01021
G1 X96.505 Y91.049 E.01545
G1 X96.396 Y91.585 E.01021
G1 X96.243 Y92.109 E.01021
G1 X95.929 Y92.875 E.01546
G1 X95.671 Y93.357 E.01022
G1 X95.372 Y93.817 E.01026
G1 X95.037 Y94.249 E.01021
G1 X94.465 Y94.847 E.01545
G1 X94.048 Y95.2 E.01021
G1 X93.602 Y95.518 E.01023
G1 X93.134 Y95.797 E.01019
G1 X92.386 Y96.142 E.01539
G1 X91.874 Y96.318 E.01011
G1 X91.075 Y96.501 E.01532
G1 X90.541 Y96.568 E.01005
G1 X89.829 Y96.587 E.01332
G1 X89.118 Y96.53 E.01333
G1 X88.586 Y96.436 E.01008
G1 X87.797 Y96.211 E.01534
G1 X87.295 Y96.009 E.01011
G1 X86.565 Y95.624 E.01541
G1 X86.112 Y95.321 E.01019
G1 X85.683 Y94.979 E.01024
G1 X85.284 Y94.603 E.01025
G1 X84.919 Y94.196 E.01022
G1 X84.48 Y93.598 E.01386
G1 X84.16 Y93.052 E.01182
G1 X83.926 Y92.556 E.01025
G1 X83.735 Y92.044 E.01021
G1 X83.529 Y91.245 E.01542
G1 X83.431 Y90.512 E.01382
G1 X83.411 Y89.88 E.01181
G1 X83.444 Y89.334 E.01022
G1 X83.522 Y88.791 E.01025
G1 X83.644 Y88.26 E.01019
G1 X83.911 Y87.481 E.01539
G1 X84.272 Y86.741 E.01538
G1 X84.561 Y86.28 E.01016
G1 X85.013 Y85.694 E.01382
G1 X85.447 Y85.236 E.01178
G1 X85.857 Y84.875 E.01021
G1 X86.297 Y84.549 E.01023
G1 X86.52 Y84.41 E.00491
; WIPE_START
M204 S6000
G1 X86.76 Y84.262 E-.04018
G1 X87.5 Y83.903 E-.11726
G1 X88.28 Y83.639 E-.11725
G1 X88.35 Y83.623 E-.01031
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
G1 X0 Y90.0001 ; move to safe pos
G1 X-13.0 F3000 ; move to safe pos
M400
M1004 S5 P1  ; external shutter
M400 P300
M971 S11 C11 O0
G92 E0
G1 X0 F18000
M623

; SKIPTYPE: head_wrap_detect
M622.1 S1
M1002 judge_flag g39_3rd_layer_detect_flag
M622 J1
    ; enable nozzle clog detect at 3rd layer
    


    M622.1 S1
    M1002 judge_flag g39_detection_flag
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




; CHANGE_LAYER
; Z_HEIGHT: 2.12
; LAYER_HEIGHT: 0.12
; layer num/total_layer_count: 17/33
; update layer progress
M73 L17
M991 S0 P16 ;notify layer change
; OBJECT_ID: 8
G1 X94.725 Y92.492 F18000
G1 Z2.12
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1843
M204 S6000
G1 X94.49 Y92.9 E.00946
G1 X94.179 Y93.332 E.01071
G1 X93.826 Y93.732 E.01072
G1 X93.435 Y94.094 E.01071
G1 X93.011 Y94.416 E.01071
G1 X92.556 Y94.694 E.01071
G1 X92.076 Y94.925 E.01072
G1 X91.575 Y95.107 E.01071
G1 X91.059 Y95.239 E.01071
G1 X90.532 Y95.318 E.01072
G1 X90 Y95.345 E.01071
G1 X89.468 Y95.318 E.01071
G1 X88.941 Y95.239 E.01072
G1 X88.425 Y95.107 E.0107
G1 X87.924 Y94.925 E.01072
G1 X87.444 Y94.694 E.01071
G1 X86.989 Y94.416 E.01072
G1 X86.564 Y94.094 E.01071
G1 X86.164 Y93.723 E.01098
G1 X85.667 Y93.131 E.01554
G1 X85.371 Y92.672 E.01098
G1 X85.128 Y92.198 E.01072
G1 X84.933 Y91.702 E.01071
G1 X84.789 Y91.19 E.01071
G1 X84.697 Y90.665 E.01072
G1 X84.657 Y90.133 E.01071
G1 X84.67 Y89.601 E.01071
G1 X84.736 Y89.072 E.01071
G1 X84.855 Y88.552 E.01072
G1 X85.025 Y88.047 E.01071
G1 X85.244 Y87.562 E.01071
G1 X85.51 Y87.1 E.01071
G1 X85.821 Y86.668 E.01071
G1 X86.174 Y86.268 E.01072
G1 X86.564 Y85.906 E.01071
G1 X86.989 Y85.584 E.01072
G1 X87.444 Y85.306 E.01071
G1 X87.924 Y85.075 E.01071
G1 X88.425 Y84.893 E.01071
G1 X88.941 Y84.761 E.01071
M73 P75 R3
G1 X89.464 Y84.682 E.01064
G1 X89.87 Y84.659 E.00819
G1 X90.271 Y84.662 E.00805
G1 X90.796 Y84.715 E.01062
G1 X91.319 Y84.82 E.01071
G1 X91.828 Y84.978 E.01072
G1 X92.319 Y85.185 E.01071
G1 X92.787 Y85.439 E.01071
G1 X93.227 Y85.74 E.01071
G1 X93.635 Y86.082 E.01071
G1 X94.007 Y86.463 E.01071
G1 X94.339 Y86.88 E.01072
G1 X94.629 Y87.328 E.01071
G1 X94.872 Y87.802 E.01072
G1 X95.066 Y88.298 E.01071
G1 X95.211 Y88.811 E.01071
G1 X95.303 Y89.335 E.01072
G1 X95.343 Y89.867 E.01071
G1 X95.33 Y90.399 E.01071
G1 X95.263 Y90.928 E.01071
G1 X95.145 Y91.448 E.01072
G1 X94.975 Y91.953 E.01071
G1 X94.756 Y92.439 E.01072
G1 X94.755 Y92.44 E.00004
M204 S10000
G1 X94.358 Y92.28 F18000
G1 F1843
M204 S6000
G1 X94.133 Y92.669 E.00904
G1 X93.847 Y93.067 E.00986
G1 X93.522 Y93.435 E.00987
G1 X93.162 Y93.769 E.00986
G1 X92.771 Y94.065 E.00986
G1 X92.353 Y94.321 E.00986
G1 X91.911 Y94.534 E.00986
G1 X91.45 Y94.701 E.00986
G1 X90.975 Y94.822 E.00986
G1 X90.49 Y94.896 E.00987
G1 X90 Y94.92 E.00986
G1 X89.51 Y94.896 E.00986
G1 X89.025 Y94.822 E.00987
G1 X88.55 Y94.701 E.00986
G1 X88.089 Y94.534 E.00987
G1 X87.647 Y94.321 E.00986
G1 X87.228 Y94.065 E.00987
G1 X86.837 Y93.769 E.00986
G1 X86.472 Y93.43 E.01002
G1 X86.009 Y92.879 E.01448
G1 X85.739 Y92.46 E.01002
G1 X85.515 Y92.023 E.00986
G1 X85.336 Y91.567 E.00986
G1 X85.203 Y91.095 E.00986
G1 X85.118 Y90.612 E.00987
G1 X85.081 Y90.123 E.00986
G1 X85.094 Y89.632 E.00986
G1 X85.155 Y89.146 E.00986
G1 X85.264 Y88.667 E.00987
G1 X85.42 Y88.202 E.00986
G1 X85.622 Y87.755 E.00986
G1 X85.867 Y87.331 E.00986
G1 X86.153 Y86.933 E.00986
G1 X86.478 Y86.565 E.00987
G1 X86.837 Y86.231 E.00986
G1 X87.228 Y85.935 E.00986
G1 X87.647 Y85.679 E.00986
G1 X88.089 Y85.466 E.00986
G1 X88.55 Y85.299 E.00986
G1 X89.025 Y85.178 E.00986
G1 X89.508 Y85.105 E.00982
G1 X89.881 Y85.083 E.00752
G1 X90.248 Y85.086 E.00738
G1 X90.733 Y85.135 E.00981
G1 X91.214 Y85.232 E.00986
G1 X91.683 Y85.377 E.00987
G1 X92.135 Y85.567 E.00986
G1 X92.565 Y85.802 E.00986
G1 X92.971 Y86.078 E.00986
G1 X93.346 Y86.393 E.00986
G1 X93.689 Y86.745 E.00986
G1 X93.995 Y87.128 E.00986
G1 X94.261 Y87.54 E.00986
G1 X94.485 Y87.977 E.00986
G1 X94.664 Y88.433 E.00986
G1 X94.796 Y88.905 E.00986
G1 X94.882 Y89.388 E.00986
G1 X94.918 Y89.877 E.00986
G1 X94.906 Y90.368 E.00986
G1 X94.845 Y90.854 E.00986
G1 X94.736 Y91.333 E.00987
G1 X94.58 Y91.798 E.00986
G1 X94.386 Y92.227 E.00948
M204 S250
G1 X94.003 Y92.075 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1800
M204 S5000
G1 X93.789 Y92.447 E.00802
G1 X93.526 Y92.812 E.0084
G1 X93.229 Y93.149 E.0084
G1 X92.899 Y93.455 E.0084
G1 X92.54 Y93.727 E.0084
G1 X92.157 Y93.961 E.0084
G1 X91.752 Y94.156 E.0084
G1 X91.329 Y94.31 E.0084
G1 X90.894 Y94.421 E.0084
G1 X90.449 Y94.488 E.0084
G1 X90 Y94.51 E.0084
G1 X89.551 Y94.488 E.0084
G1 X89.106 Y94.421 E.00841
G1 X88.67 Y94.31 E.0084
G1 X88.248 Y94.156 E.0084
G1 X87.843 Y93.961 E.0084
G1 X87.459 Y93.727 E.0084
G1 X87.101 Y93.455 E.0084
G1 X86.769 Y93.147 E.00845
G1 X86.339 Y92.635 E.0125
G1 X86.094 Y92.255 E.00845
G1 X85.889 Y91.855 E.0084
G1 X85.724 Y91.437 E.0084
G1 X85.603 Y91.004 E.0084
G1 X85.525 Y90.561 E.0084
G1 X85.491 Y90.112 E.0084
G1 X85.502 Y89.663 E.0084
G1 X85.558 Y89.217 E.0084
G1 X85.658 Y88.778 E.00841
G1 X85.801 Y88.352 E.0084
G1 X85.986 Y87.942 E.0084
G1 X86.211 Y87.553 E.0084
G1 X86.474 Y87.188 E.0084
G1 X86.771 Y86.851 E.0084
G1 X87.101 Y86.545 E.0084
G1 X87.459 Y86.273 E.0084
G1 X87.843 Y86.039 E.0084
G1 X88.248 Y85.844 E.0084
G1 X88.67 Y85.69 E.0084
G1 X89.106 Y85.579 E.0084
G1 X89.55 Y85.512 E.00839
G1 X90.226 Y85.495 E.01263
G1 X90.672 Y85.54 E.00838
G1 X91.113 Y85.629 E.0084
G1 X91.543 Y85.762 E.00841
G1 X91.957 Y85.936 E.0084
G1 X92.352 Y86.152 E.00841
G1 X92.723 Y86.405 E.0084
G1 X93.068 Y86.694 E.0084
G1 X93.382 Y87.016 E.0084
G1 X93.662 Y87.367 E.0084
G1 X93.906 Y87.745 E.0084
G1 X94.111 Y88.145 E.0084
G1 X94.275 Y88.564 E.0084
G1 X94.397 Y88.996 E.0084
G1 X94.475 Y89.439 E.0084
G1 X94.509 Y89.888 E.0084
G1 X94.497 Y90.337 E.0084
G1 X94.442 Y90.783 E.0084
G1 X94.342 Y91.222 E.0084
G1 X94.198 Y91.648 E.00841
G1 X94.03 Y92.022 E.00766
; WIPE_START
M204 S6000
G1 X93.789 Y92.447 E-.06967
G1 X93.526 Y92.812 E-.06407
G1 X93.229 Y93.149 E-.06409
G1 X92.899 Y93.455 E-.06406
G1 X92.77 Y93.553 E-.02311
; WIPE_END
G1 E-.015
M204 S10000
G1 X88.446 Y87.263 Z2.52 F18000
G1 X86.97 Y85.116 Z2.52
G1 Z2.12
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1843
M204 S6000
G1 X87.39 Y84.871 E.00978
G1 X87.807 Y84.679 E.00922
G1 X88.506 Y84.442 E.01484
G1 X88.962 Y84.339 E.00939
G1 X89.431 Y84.273 E.00952
G1 X89.981 Y84.246 E.01108
G1 X90.636 Y84.28 E.0132
G1 X91.09 Y84.349 E.00922
G1 X91.805 Y84.535 E.01485
G1 X92.242 Y84.699 E.00939
G1 X92.67 Y84.901 E.00952
G1 X93.145 Y85.181 E.01108
G1 X93.674 Y85.57 E.0132
G1 X94.015 Y85.877 E.00923
G1 X94.51 Y86.425 E.01485
G1 X94.779 Y86.794 E.00918
G1 X95.15 Y87.432 E.01485
G1 X95.338 Y87.849 E.00919
G1 X95.569 Y88.55 E.01486
G1 X95.669 Y89.007 E.0094
G1 X95.732 Y89.482 E.00963
G1 X95.755 Y89.949 E.00941
G1 X95.714 Y90.688 E.01488
G1 X95.641 Y91.139 E.00919
G1 X95.448 Y91.854 E.01489
G1 X95.28 Y92.292 E.00942
G1 X95.072 Y92.719 E.00955
G1 X94.787 Y93.192 E.01111
G1 X94.392 Y93.719 E.01324
G1 X94.074 Y94.066 E.00947
G1 X93.721 Y94.391 E.00963
G1 X93.344 Y94.685 E.00963
G1 X92.952 Y94.94 E.0094
G1 X92.296 Y95.277 E.01483
G1 X91.872 Y95.442 E.00915
G1 X91.164 Y95.636 E.01477
G1 X90.717 Y95.71 E.0091
G1 X89.992 Y95.755 E.01461
G1 X89.463 Y95.73 E.01065
G1 X89.007 Y95.669 E.00925
G1 X88.294 Y95.496 E.01475
G1 X87.865 Y95.345 E.00914
G1 X87.199 Y95.028 E.01483
G1 X86.81 Y94.79 E.00918
G1 X86.222 Y94.341 E.01487
G1 X85.889 Y94.028 E.00919
G1 X85.406 Y93.467 E.01488
G1 X85.139 Y93.082 E.00943
G1 X84.899 Y92.667 E.00963
G1 X84.695 Y92.233 E.00965
G1 X84.531 Y91.794 E.00942
G1 X84.347 Y91.081 E.0148
G1 X84.272 Y90.545 E.01088
G1 X84.246 Y89.888 E.01323
G1 X84.274 Y89.419 E.00945
G1 X84.342 Y88.944 E.00963
G1 X84.447 Y88.489 E.0094
G1 X84.686 Y87.79 E.01486
G1 X84.878 Y87.375 E.00919
G1 X85.256 Y86.741 E.01485
G1 X85.529 Y86.375 E.00917
G1 X86.031 Y85.833 E.01486
G1 X86.378 Y85.527 E.00931
G1 X86.823 Y85.202 E.01107
G1 X86.918 Y85.147 E.00222
M204 S10000
G1 X86.756 Y84.75 F18000
G1 F1843
M204 S6000
G1 X87.194 Y84.494 E.0102
G1 X87.65 Y84.284 E.01009
G1 X88.391 Y84.033 E.01573
G1 X88.885 Y83.921 E.01019
G1 X89.391 Y83.85 E.01026
G1 X89.982 Y83.821 E.0119
G1 X90.679 Y83.857 E.01405
G1 X91.175 Y83.933 E.01009
G1 X91.933 Y84.13 E.01573
G1 X92.407 Y84.308 E.01019
G1 X92.869 Y84.526 E.01027
G1 X93.379 Y84.827 E.0119
G1 X93.942 Y85.24 E.01405
G1 X94.315 Y85.576 E.01009
G1 X94.84 Y86.157 E.01574
G1 X95.135 Y86.561 E.01007
G1 X95.528 Y87.238 E.01573
G1 X95.734 Y87.695 E.01008
G1 X95.979 Y88.438 E.01575
G1 X96.087 Y88.934 E.0102
G1 X96.155 Y89.444 E.01034
G1 X96.18 Y89.951 E.01021
G1 X96.136 Y90.734 E.01577
G1 X96.056 Y91.229 E.01008
G1 X95.852 Y91.986 E.01578
G1 X95.669 Y92.461 E.01022
G1 X95.446 Y92.922 E.0103
G1 X95.139 Y93.43 E.01193
G1 X94.719 Y93.99 E.01409
G1 X94.374 Y94.366 E.01025
G1 X93.996 Y94.714 E.01034
G1 X93.59 Y95.03 E.01034
G1 X93.166 Y95.307 E.0102
G1 X92.47 Y95.665 E.01572
G1 X92.005 Y95.845 E.01003
G1 X91.255 Y96.051 E.01565
G1 X90.765 Y96.132 E.00998
G1 X89.995 Y96.18 E.01551
G1 X89.424 Y96.153 E.01149
G1 X88.928 Y96.086 E.01006
G1 X88.173 Y95.904 E.01563
G1 X87.702 Y95.737 E.01003
G1 X86.997 Y95.401 E.01571
G1 X86.57 Y95.141 E.01006
G1 X85.947 Y94.665 E.01575
G1 X85.582 Y94.321 E.01008
G1 X85.07 Y93.727 E.01577
G1 X84.78 Y93.309 E.01023
G1 X84.523 Y92.863 E.01035
G1 X84.304 Y92.397 E.01036
G1 X84.126 Y91.921 E.01022
G1 X83.931 Y91.164 E.01572
G1 X83.849 Y90.584 E.01179
G1 X83.821 Y89.884 E.01408
G1 X83.851 Y89.376 E.01023
G1 X83.924 Y88.867 E.01034
G1 X84.038 Y88.372 E.0102
G1 X84.292 Y87.631 E.01575
G1 X84.502 Y87.177 E.01007
G1 X84.903 Y86.505 E.01574
G1 X85.203 Y86.104 E.01006
G1 X85.734 Y85.529 E.01574
G1 X86.113 Y85.195 E.01014
G1 X86.591 Y84.847 E.01189
G1 X86.704 Y84.781 E.00264
M204 S250
G1 X86.549 Y84.397 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1800
M204 S5000
G1 X87.004 Y84.13 E.00986
G1 X87.498 Y83.904 E.01015
G1 X88.28 Y83.639 E.01542
G1 X88.811 Y83.518 E.01019
G1 X89.352 Y83.442 E.01021
G1 X89.982 Y83.412 E.01179
G1 X90.721 Y83.45 E.01382
G1 X91.258 Y83.532 E.01015
G1 X92.057 Y83.739 E.01542
G1 X92.567 Y83.931 E.01019
G1 X93.061 Y84.164 E.01021
G1 X93.604 Y84.485 E.01179
G1 X94.2 Y84.923 E.01382
G1 X94.605 Y85.286 E.01016
G1 X95.157 Y85.898 E.01542
G1 X95.478 Y86.337 E.01015
G1 X95.893 Y87.051 E.01542
G1 X96.116 Y87.546 E.01016
G1 X96.374 Y88.33 E.01543
G1 X96.491 Y88.863 E.0102
G1 X96.563 Y89.407 E.01024
G1 X96.589 Y89.952 E.0102
G1 X96.544 Y90.778 E.01545
G1 X96.457 Y91.315 E.01017
G1 X96.241 Y92.113 E.01546
G1 X96.045 Y92.624 E.01022
G1 X95.806 Y93.117 E.01024
G1 X95.479 Y93.659 E.01182
G1 X95.034 Y94.252 E.01386
G1 X94.664 Y94.655 E.01022
G1 X94.261 Y95.027 E.01025
G1 X93.828 Y95.364 E.01025
G1 X93.372 Y95.662 E.01019
G1 X92.638 Y96.038 E.0154
G1 X92.134 Y96.235 E.01011
G1 X91.342 Y96.452 E.01534
G1 X90.811 Y96.54 E.01006
G1 X89.998 Y96.59 E.01522
G1 X89.387 Y96.561 E.01143
G1 X88.853 Y96.489 E.01008
G1 X88.056 Y96.297 E.01532
G1 X87.546 Y96.116 E.01011
G1 X86.802 Y95.762 E.01539
G1 X86.338 Y95.479 E.01015
G1 X85.682 Y94.978 E.01543
G1 X85.286 Y94.605 E.01017
G1 X84.746 Y93.978 E.01545
G1 X84.434 Y93.528 E.01022
G1 X84.16 Y93.053 E.01025
G1 X83.926 Y92.556 E.01026
G1 X83.735 Y92.044 E.01021
G1 X83.529 Y91.244 E.01544
G1 X83.441 Y90.62 E.01177
G1 X83.411 Y89.88 E.01385
G1 X83.444 Y89.334 E.01021
G1 X83.522 Y88.791 E.01025
G1 X83.644 Y88.26 E.01019
G1 X83.912 Y87.479 E.01543
G1 X84.14 Y86.986 E.01015
G1 X84.563 Y86.277 E.01542
G1 X84.888 Y85.842 E.01015
G1 X85.448 Y85.235 E.01542
G1 X85.856 Y84.876 E.01017
G1 X86.366 Y84.504 E.01179
G1 X86.497 Y84.427 E.00284
; WIPE_START
M204 S6000
G1 X87.004 Y84.13 E-.08374
G1 X87.498 Y83.904 E-.07743
G1 X88.28 Y83.639 E-.11756
G1 X88.322 Y83.629 E-.00627
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
G1 X0 Y90.0001 ; move to safe pos
G1 X-13.0 F3000 ; move to safe pos
M400
M1004 S5 P1  ; external shutter
M400 P300
M971 S11 C11 O0
G92 E0
G1 X0 F18000
M623

; SKIPTYPE: head_wrap_detect
M622.1 S1
M1002 judge_flag g39_3rd_layer_detect_flag
M622 J1
    ; enable nozzle clog detect at 3rd layer
    


    M622.1 S1
    M1002 judge_flag g39_detection_flag
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




; CHANGE_LAYER
; Z_HEIGHT: 2.24
; LAYER_HEIGHT: 0.12
; layer num/total_layer_count: 18/33
; update layer progress
M73 L18
M991 S0 P17 ;notify layer change
; OBJECT_ID: 8
G1 X94.724 Y92.494 F18000
G1 Z2.24
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1844
M204 S6000
G1 X94.49 Y92.9 E.00941
G1 X94.179 Y93.332 E.01071
G1 X93.826 Y93.732 E.01072
G1 X93.435 Y94.094 E.01071
G1 X93.011 Y94.416 E.01071
G1 X92.556 Y94.694 E.01072
G1 X92.076 Y94.925 E.01071
G1 X91.575 Y95.107 E.01071
G1 X91.059 Y95.239 E.01071
G1 X90.532 Y95.318 E.01072
G1 X90 Y95.345 E.01071
G1 X89.468 Y95.318 E.01071
M73 P76 R3
G1 X88.941 Y95.239 E.01072
G1 X88.425 Y95.107 E.01071
G1 X87.924 Y94.925 E.01072
G1 X87.444 Y94.694 E.01071
G1 X86.989 Y94.416 E.01071
G1 X86.564 Y94.094 E.01072
G1 X86.164 Y93.723 E.01098
G1 X85.667 Y93.131 E.01554
G1 X85.371 Y92.672 E.01097
G1 X85.128 Y92.198 E.01072
G1 X84.933 Y91.702 E.01071
G1 X84.789 Y91.19 E.01071
G1 X84.697 Y90.665 E.01072
G1 X84.657 Y90.133 E.01071
G1 X84.67 Y89.601 E.01071
G1 X84.736 Y89.072 E.01071
G1 X84.855 Y88.552 E.01072
G1 X85.024 Y88.047 E.01071
G1 X85.244 Y87.561 E.01072
G1 X85.51 Y87.1 E.01071
G1 X85.821 Y86.668 E.01071
G1 X86.174 Y86.268 E.01072
G1 X86.564 Y85.906 E.01071
G1 X86.989 Y85.584 E.01071
G1 X87.444 Y85.306 E.01072
G1 X87.924 Y85.075 E.01071
G1 X88.425 Y84.893 E.01071
G1 X88.941 Y84.761 E.01071
G1 X89.464 Y84.682 E.01065
G1 X89.878 Y84.659 E.00833
G1 X90.271 Y84.662 E.0079
G1 X90.796 Y84.715 E.01062
G1 X91.319 Y84.82 E.01071
G1 X91.828 Y84.978 E.01072
G1 X92.319 Y85.185 E.01071
G1 X92.787 Y85.439 E.01072
G1 X93.227 Y85.74 E.01071
G1 X93.635 Y86.082 E.01072
G1 X94.007 Y86.463 E.01071
G1 X94.339 Y86.88 E.01072
G1 X94.628 Y87.328 E.01071
G1 X94.872 Y87.802 E.01071
G1 X95.066 Y88.298 E.01072
G1 X95.211 Y88.81 E.0107
G1 X95.303 Y89.335 E.01072
G1 X95.343 Y89.867 E.01071
G1 X95.33 Y90.399 E.01071
G1 X95.263 Y90.928 E.01071
G1 X95.145 Y91.448 E.01072
G1 X94.975 Y91.953 E.01072
G1 X94.756 Y92.439 E.01072
G1 X94.754 Y92.443 E.00009
M204 S10000
G1 X94.356 Y92.282 F18000
G1 F1844
M204 S6000
G1 X94.133 Y92.669 E.00898
G1 X93.847 Y93.067 E.00986
G1 X93.522 Y93.435 E.00987
G1 X93.162 Y93.769 E.00986
G1 X92.771 Y94.065 E.00986
G1 X92.353 Y94.321 E.00987
G1 X91.911 Y94.534 E.00986
G1 X91.45 Y94.701 E.00986
G1 X90.975 Y94.822 E.00986
G1 X90.49 Y94.896 E.00987
G1 X90 Y94.92 E.00986
G1 X89.51 Y94.896 E.00986
G1 X89.025 Y94.822 E.00987
G1 X88.55 Y94.701 E.00986
G1 X88.089 Y94.534 E.00986
G1 X87.647 Y94.321 E.00986
G1 X87.228 Y94.065 E.00986
G1 X86.837 Y93.769 E.00986
G1 X86.472 Y93.43 E.01002
G1 X86.009 Y92.879 E.01448
G1 X85.739 Y92.46 E.01002
G1 X85.515 Y92.023 E.00987
G1 X85.336 Y91.567 E.00986
G1 X85.203 Y91.095 E.00986
G1 X85.118 Y90.612 E.00987
G1 X85.081 Y90.123 E.00986
G1 X85.094 Y89.632 E.00986
G1 X85.155 Y89.146 E.00986
G1 X85.264 Y88.667 E.00987
G1 X85.42 Y88.203 E.00986
G1 X85.622 Y87.755 E.00987
G1 X85.867 Y87.331 E.00986
G1 X86.153 Y86.933 E.00986
G1 X86.478 Y86.565 E.00987
G1 X86.837 Y86.231 E.00986
G1 X87.228 Y85.935 E.00986
G1 X87.647 Y85.679 E.00987
G1 X88.089 Y85.466 E.00986
G1 X88.55 Y85.299 E.00986
G1 X89.025 Y85.178 E.00986
G1 X89.508 Y85.105 E.00982
G1 X89.888 Y85.083 E.00766
G1 X90.248 Y85.086 E.00724
G1 X90.733 Y85.135 E.0098
G1 X91.214 Y85.232 E.00986
G1 X91.683 Y85.377 E.00987
G1 X92.134 Y85.567 E.00986
G1 X92.565 Y85.802 E.00987
G1 X92.971 Y86.078 E.00986
G1 X93.346 Y86.393 E.00986
G1 X93.689 Y86.744 E.00986
G1 X93.995 Y87.128 E.00986
G1 X94.261 Y87.54 E.00986
G1 X94.484 Y87.977 E.00986
G1 X94.664 Y88.433 E.00987
G1 X94.796 Y88.905 E.00985
G1 X94.882 Y89.388 E.00987
G1 X94.918 Y89.877 E.00986
G1 X94.906 Y90.368 E.00986
G1 X94.845 Y90.854 E.00986
G1 X94.736 Y91.333 E.00986
G1 X94.58 Y91.798 E.00987
G1 X94.385 Y92.23 E.00953
M204 S250
G1 X94.002 Y92.078 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1800
M204 S5000
G1 X93.789 Y92.447 E.00797
G1 X93.526 Y92.812 E.0084
G1 X93.229 Y93.149 E.0084
G1 X92.899 Y93.455 E.0084
G1 X92.54 Y93.727 E.0084
G1 X92.157 Y93.961 E.0084
G1 X91.752 Y94.156 E.0084
G1 X91.329 Y94.31 E.0084
G1 X90.894 Y94.421 E.0084
G1 X90.449 Y94.488 E.0084
G1 X90 Y94.51 E.0084
G1 X89.551 Y94.488 E.0084
G1 X89.106 Y94.421 E.00841
G1 X88.67 Y94.31 E.0084
G1 X88.248 Y94.156 E.0084
G1 X87.843 Y93.961 E.0084
G1 X87.459 Y93.727 E.0084
G1 X87.101 Y93.455 E.0084
G1 X86.769 Y93.147 E.00845
G1 X86.339 Y92.635 E.0125
G1 X86.094 Y92.255 E.00845
G1 X85.889 Y91.855 E.0084
G1 X85.724 Y91.436 E.0084
G1 X85.603 Y91.004 E.0084
G1 X85.525 Y90.561 E.0084
G1 X85.491 Y90.112 E.0084
G1 X85.502 Y89.663 E.0084
G1 X85.558 Y89.217 E.0084
G1 X85.658 Y88.778 E.00841
G1 X85.801 Y88.352 E.0084
G1 X85.986 Y87.942 E.0084
G1 X86.211 Y87.553 E.0084
G1 X86.474 Y87.188 E.0084
G1 X86.771 Y86.851 E.0084
G1 X87.101 Y86.545 E.0084
G1 X87.459 Y86.273 E.0084
G1 X87.843 Y86.039 E.00841
G1 X88.248 Y85.844 E.0084
G1 X88.67 Y85.69 E.0084
G1 X89.106 Y85.579 E.0084
G1 X89.55 Y85.512 E.00839
G1 X90.226 Y85.495 E.01263
G1 X90.672 Y85.54 E.00838
G1 X91.113 Y85.629 E.0084
G1 X91.542 Y85.762 E.0084
G1 X91.957 Y85.936 E.0084
G1 X92.352 Y86.151 E.0084
G1 X92.723 Y86.405 E.0084
G1 X93.068 Y86.694 E.0084
G1 X93.382 Y87.016 E.0084
G1 X93.662 Y87.367 E.0084
G1 X93.906 Y87.745 E.0084
G1 X94.111 Y88.145 E.0084
G1 X94.275 Y88.564 E.0084
G1 X94.397 Y88.996 E.0084
G1 X94.475 Y89.439 E.0084
G1 X94.509 Y89.888 E.0084
G1 X94.497 Y90.337 E.0084
G1 X94.442 Y90.783 E.0084
G1 X94.342 Y91.222 E.0084
G1 X94.198 Y91.648 E.00841
G1 X94.029 Y92.024 E.00771
; WIPE_START
M204 S6000
G1 X93.789 Y92.447 E-.06929
G1 X93.526 Y92.812 E-.06408
G1 X93.229 Y93.149 E-.06409
G1 X92.899 Y93.455 E-.06406
G1 X92.768 Y93.555 E-.02349
; WIPE_END
G1 E-.015
M204 S10000
G1 X88.473 Y87.245 Z2.64 F18000
G1 X87.001 Y85.082 Z2.64
G1 Z2.24
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1844
M204 S6000
G1 X87.547 Y84.789 E.01247
G1 X88.098 Y84.563 E.01198
G1 X88.62 Y84.408 E.01094
G1 X89.195 Y84.297 E.01177
G1 X89.744 Y84.246 E.01109
G1 X90.285 Y84.247 E.01088
G1 X90.855 Y84.304 E.01152
G1 X91.302 Y84.39 E.00914
G1 X91.967 Y84.587 E.01395
G1 X92.411 Y84.77 E.00967
G1 X92.929 Y85.041 E.01174
G1 X93.442 Y85.382 E.01239
G1 X93.878 Y85.742 E.01137
G1 X94.299 Y86.168 E.01203
G1 X94.666 Y86.625 E.0118
G1 X94.941 Y87.042 E.01005
G1 X95.195 Y87.514 E.01077
G1 X95.432 Y88.087 E.01248
G1 X95.592 Y88.624 E.01126
G1 X95.702 Y89.19 E.0116
G1 X95.752 Y89.701 E.01033
G1 X95.753 Y90.271 E.01146
G1 X95.694 Y90.862 E.01193
G1 X95.585 Y91.405 E.01114
G1 X95.413 Y91.968 E.01185
G1 X95.207 Y92.462 E.01075
G1 X94.972 Y92.908 E.01014
G1 X94.613 Y93.447 E.01303
G1 X94.259 Y93.877 E.01121
G1 X93.884 Y94.253 E.01067
G1 X93.439 Y94.62 E.0116
G1 X92.969 Y94.935 E.01137
G1 X92.501 Y95.188 E.0107
G1 X91.943 Y95.422 E.01216
G1 X91.443 Y95.576 E.01052
G1 X90.882 Y95.692 E.01152
G1 X90.316 Y95.751 E.01145
G1 X89.725 Y95.753 E.01188
G1 X89.18 Y95.701 E.01102
G1 X88.613 Y95.59 E.01162
G1 X88.02 Y95.408 E.01246
G1 X87.465 Y95.172 E.01213
G1 X87.008 Y94.921 E.01049
G1 X86.589 Y94.641 E.01013
G1 X86.116 Y94.253 E.0123
G1 X85.713 Y93.846 E.01153
G1 X85.362 Y93.414 E.01119
G1 X85.03 Y92.91 E.01214
G1 X84.78 Y92.435 E.01079
G1 X84.576 Y91.937 E.01083
G1 X84.402 Y91.357 E.01217
G1 X84.31 Y90.892 E.00952
G1 X84.248 Y90.298 E.01201
G1 X84.249 Y89.679 E.01245
G1 X84.303 Y89.153 E.01063
G1 X84.419 Y88.576 E.01184
G1 X84.59 Y88.024 E.01162
G1 X84.819 Y87.484 E.01179
G1 X85.06 Y87.038 E.0102
G1 X85.371 Y86.573 E.01124
G1 X85.739 Y86.125 E.01167
G1 X86.116 Y85.747 E.01075
G1 X86.561 Y85.38 E.01159
G1 X86.951 Y85.116 E.00947
M204 S10000
G1 X86.781 Y84.718 F18000
G1 F1844
M204 S6000
G1 X87.366 Y84.405 E.01335
G1 X87.957 Y84.163 E.01284
G1 X88.519 Y83.996 E.01178
G1 X89.135 Y83.877 E.01261
G1 X89.725 Y83.822 E.01192
G1 X90.307 Y83.823 E.0117
G1 X90.916 Y83.884 E.01232
G1 X91.402 Y83.977 E.00995
G1 X92.108 Y84.186 E.0148
G1 X92.591 Y84.385 E.0105
G1 X93.145 Y84.676 E.01259
G1 X93.695 Y85.041 E.01327
G1 X94.164 Y85.429 E.01224
G1 X94.616 Y85.885 E.0129
G1 X95.01 Y86.374 E.01264
G1 X95.306 Y86.824 E.01083
G1 X95.579 Y87.332 E.01159
G1 X95.832 Y87.945 E.01335
G1 X96.005 Y88.522 E.01211
G1 X96.122 Y89.129 E.01243
G1 X96.176 Y89.681 E.01114
G1 X96.177 Y90.292 E.01229
G1 X96.114 Y90.924 E.01279
G1 X95.997 Y91.509 E.01199
G1 X95.812 Y92.113 E.01269
G1 X95.591 Y92.643 E.01155
G1 X95.337 Y93.125 E.01095
G1 X94.955 Y93.7 E.0139
G1 X94.573 Y94.163 E.01205
G1 X94.169 Y94.567 E.01149
G1 X93.692 Y94.961 E.01244
G1 X93.188 Y95.299 E.0122
G1 X92.684 Y95.571 E.01153
G1 X92.088 Y95.821 E.013
G1 X91.549 Y95.987 E.01134
G1 X90.947 Y96.111 E.01235
G1 X90.339 Y96.175 E.01231
G1 X89.706 Y96.177 E.01273
G1 X89.119 Y96.121 E.01186
G1 X88.51 Y96.002 E.01248
G1 X87.875 Y95.808 E.01335
G1 X87.28 Y95.554 E.013
G1 X86.788 Y95.284 E.01128
G1 X86.336 Y94.982 E.01093
G1 X85.83 Y94.567 E.01315
G1 X85.397 Y94.13 E.01238
G1 X85.019 Y93.665 E.01204
G1 X84.664 Y93.126 E.01299
G1 X84.396 Y92.614 E.01162
G1 X84.176 Y92.078 E.01165
G1 X83.99 Y91.459 E.01299
G1 X83.89 Y90.956 E.01032
G1 X83.824 Y90.32 E.01286
G1 X83.825 Y89.657 E.01332
G1 X83.883 Y89.09 E.01147
G1 X84.008 Y88.471 E.01268
G1 X84.191 Y87.878 E.01248
G1 X84.436 Y87.3 E.01263
G1 X84.696 Y86.819 E.011
G1 X85.03 Y86.32 E.01206
G1 X85.424 Y85.84 E.0125
G1 X85.831 Y85.433 E.01157
G1 X86.306 Y85.04 E.01241
G1 X86.731 Y84.752 E.01032
M204 S250
G1 X86.569 Y84.368 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1800
M204 S5000
G1 X87.192 Y84.034 E.0132
G1 X87.821 Y83.776 E.01271
G1 X88.421 Y83.598 E.01171
G1 X89.077 Y83.471 E.01247
G1 X89.706 Y83.413 E.01182
G1 X90.327 Y83.414 E.0116
G1 X90.975 Y83.478 E.01216
G1 X91.499 Y83.579 E.00997
G1 X92.244 Y83.8 E.01452
G1 X92.764 Y84.014 E.01051
G1 X93.354 Y84.323 E.01245
G1 X93.939 Y84.712 E.01313
G1 X94.441 Y85.126 E.01215
G1 X94.921 Y85.612 E.01277
G1 X95.341 Y86.133 E.0125
G1 X95.658 Y86.614 E.01077
G1 X95.949 Y87.156 E.0115
G1 X96.219 Y87.808 E.01318
G1 X96.403 Y88.425 E.01202
G1 X96.528 Y89.07 E.01229
G1 X96.585 Y89.66 E.01108
G1 X96.586 Y90.311 E.01217
G1 X96.52 Y90.985 E.01265
G1 X96.394 Y91.61 E.0119
G1 X96.198 Y92.252 E.01255
G1 X95.961 Y92.817 E.01145
G1 X95.689 Y93.334 E.01091
G1 X95.284 Y93.945 E.0137
G1 X94.876 Y94.438 E.01196
G1 X94.445 Y94.87 E.0114
G1 X93.937 Y95.29 E.01231
G1 X93.4 Y95.649 E.01208
G1 X92.861 Y95.941 E.01146
G1 X92.227 Y96.206 E.01284
G1 X91.651 Y96.384 E.01127
G1 X91.01 Y96.516 E.01222
G1 X90.361 Y96.585 E.0122
G1 X89.687 Y96.587 E.0126
G1 X89.06 Y96.527 E.01177
G1 X88.41 Y96.399 E.01237
G1 X87.734 Y96.193 E.01321
G1 X87.101 Y95.922 E.01287
G1 X86.575 Y95.635 E.0112
G1 X86.092 Y95.311 E.01087
G1 X85.555 Y94.87 E.01299
G1 X85.092 Y94.404 E.01227
G1 X84.689 Y93.908 E.01195
G1 X84.311 Y93.334 E.01283
G1 X84.024 Y92.787 E.01153
G1 X83.789 Y92.215 E.01156
G1 X83.593 Y91.558 E.01281
G1 X83.485 Y91.017 E.01031
G1 X83.415 Y90.34 E.01271
G1 X83.416 Y89.636 E.01317
G1 X83.478 Y89.028 E.01141
G1 X83.611 Y88.37 E.01254
G1 X83.806 Y87.738 E.01237
G1 X84.067 Y87.122 E.01249
G1 X84.346 Y86.607 E.01094
G1 X84.701 Y86.076 E.01194
G1 X85.12 Y85.565 E.01236
M73 P77 R3
G1 X85.555 Y85.13 E.01149
G1 X86.061 Y84.712 E.01226
G1 X86.52 Y84.401 E.01035
; WIPE_START
M204 S6000
G1 X87.192 Y84.034 E-.10914
G1 X87.821 Y83.776 E-.0969
G1 X88.352 Y83.618 E-.07896
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
G1 X0 Y90.0001 ; move to safe pos
G1 X-13.0 F3000 ; move to safe pos
M400
M1004 S5 P1  ; external shutter
M400 P300
M971 S11 C11 O0
G92 E0
G1 X0 F18000
M623

; SKIPTYPE: head_wrap_detect
M622.1 S1
M1002 judge_flag g39_3rd_layer_detect_flag
M622 J1
    ; enable nozzle clog detect at 3rd layer
    


    M622.1 S1
    M1002 judge_flag g39_detection_flag
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




; CHANGE_LAYER
; Z_HEIGHT: 2.36
; LAYER_HEIGHT: 0.12
; layer num/total_layer_count: 19/33
; update layer progress
M73 L19
M991 S0 P18 ;notify layer change
; OBJECT_ID: 8
G1 X94.722 Y92.497 F18000
G1 Z2.36
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F2400
M204 S6000
G1 X94.49 Y92.9 E.00936
G1 X94.179 Y93.332 E.01071
G1 X93.826 Y93.732 E.01072
G1 X93.435 Y94.094 E.01071
G1 X93.011 Y94.416 E.01071
G1 X92.556 Y94.694 E.01072
G1 X92.076 Y94.925 E.01071
G1 X91.575 Y95.107 E.01071
G1 X91.059 Y95.239 E.01071
G1 X90.532 Y95.318 E.01072
G1 X90 Y95.345 E.01071
G1 X89.468 Y95.318 E.01071
G1 X88.941 Y95.239 E.01072
G1 X88.425 Y95.107 E.0107
G1 X87.924 Y94.925 E.01072
G1 X87.444 Y94.694 E.01071
G1 X86.978 Y94.409 E.01098
G1 X86.373 Y93.927 E.01554
G1 X85.992 Y93.536 E.01098
G1 X85.66 Y93.12 E.01071
G1 X85.371 Y92.673 E.01071
G1 X85.128 Y92.198 E.01072
G1 X84.933 Y91.702 E.01071
G1 X84.789 Y91.19 E.01071
G1 X84.697 Y90.665 E.01072
G1 X84.657 Y90.133 E.01071
G1 X84.67 Y89.601 E.01071
G1 X84.736 Y89.072 E.01071
G1 X84.855 Y88.552 E.01072
G1 X85.025 Y88.047 E.01071
G1 X85.244 Y87.561 E.01072
G1 X85.51 Y87.1 E.01071
G1 X85.821 Y86.668 E.01071
G1 X86.174 Y86.268 E.01072
G1 X86.564 Y85.906 E.01071
G1 X86.989 Y85.584 E.01071
G1 X87.444 Y85.306 E.01072
G1 X87.924 Y85.075 E.01072
G1 X88.424 Y84.893 E.01071
G1 X88.941 Y84.761 E.01071
G1 X89.464 Y84.682 E.01065
G1 X89.885 Y84.658 E.00848
G1 X90.271 Y84.662 E.00776
G1 X90.796 Y84.715 E.01061
G1 X91.319 Y84.82 E.01071
G1 X91.828 Y84.978 E.01072
G1 X92.319 Y85.185 E.01071
G1 X92.787 Y85.439 E.01071
G1 X93.227 Y85.739 E.01071
G1 X93.635 Y86.082 E.01072
G1 X94.007 Y86.464 E.01072
G1 X94.339 Y86.88 E.01071
G1 X94.628 Y87.328 E.01072
G1 X94.872 Y87.802 E.01072
G1 X95.066 Y88.298 E.01071
G1 X95.211 Y88.81 E.01071
G1 X95.303 Y89.335 E.01072
G1 X95.343 Y89.867 E.01071
G1 X95.33 Y90.399 E.01071
G1 X95.263 Y90.928 E.01071
G1 X95.145 Y91.448 E.01072
G1 X94.975 Y91.953 E.01071
G1 X94.756 Y92.439 E.01072
G1 X94.752 Y92.445 E.00014
M204 S10000
G1 X94.355 Y92.285 F18000
G1 F2400
M204 S6000
G1 X94.133 Y92.669 E.00893
G1 X93.847 Y93.067 E.00986
G1 X93.522 Y93.435 E.00987
G1 X93.162 Y93.769 E.00986
G1 X92.771 Y94.065 E.00986
G1 X92.353 Y94.321 E.00987
G1 X91.911 Y94.534 E.00986
G1 X91.45 Y94.701 E.00986
G1 X90.975 Y94.822 E.00986
G1 X90.49 Y94.896 E.00987
G1 X90 Y94.92 E.00986
G1 X89.51 Y94.896 E.00986
G1 X89.025 Y94.822 E.00987
G1 X88.55 Y94.701 E.00986
G1 X88.089 Y94.534 E.00987
G1 X87.647 Y94.321 E.00986
G1 X87.222 Y94.061 E.01002
G1 X86.659 Y93.612 E.01448
G1 X86.311 Y93.255 E.01002
G1 X86.005 Y92.872 E.00986
G1 X85.739 Y92.46 E.00986
G1 X85.515 Y92.023 E.00987
G1 X85.336 Y91.567 E.00986
G1 X85.203 Y91.095 E.00986
G1 X85.118 Y90.612 E.00987
G1 X85.081 Y90.123 E.00986
G1 X85.094 Y89.632 E.00986
G1 X85.155 Y89.146 E.00986
G1 X85.264 Y88.667 E.00987
G1 X85.42 Y88.202 E.00986
G1 X85.622 Y87.755 E.00986
G1 X85.867 Y87.331 E.00986
G1 X86.153 Y86.933 E.00986
G1 X86.478 Y86.565 E.00987
G1 X86.837 Y86.231 E.00986
G1 X87.228 Y85.935 E.00986
G1 X87.647 Y85.679 E.00986
G1 X88.089 Y85.466 E.00986
G1 X88.55 Y85.299 E.00986
G1 X89.025 Y85.178 E.00986
G1 X89.508 Y85.105 E.00983
G1 X89.895 Y85.083 E.0078
G1 X90.248 Y85.086 E.0071
G1 X90.733 Y85.135 E.0098
G1 X91.214 Y85.232 E.00986
G1 X91.683 Y85.377 E.00987
G1 X92.135 Y85.567 E.00986
G1 X92.565 Y85.802 E.00986
G1 X92.97 Y86.078 E.00986
G1 X93.346 Y86.393 E.00987
G1 X93.689 Y86.745 E.00986
G1 X93.994 Y87.128 E.00986
G1 X94.261 Y87.54 E.00987
G1 X94.485 Y87.977 E.00987
G1 X94.664 Y88.433 E.00986
G1 X94.796 Y88.905 E.00986
G1 X94.882 Y89.388 E.00986
M73 P77 R2
G1 X94.918 Y89.877 E.00986
G1 X94.906 Y90.368 E.00986
G1 X94.845 Y90.854 E.00986
G1 X94.736 Y91.332 E.00986
G1 X94.58 Y91.798 E.00986
G1 X94.384 Y92.232 E.00958
M204 S250
G1 X94 Y92.08 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1800
M204 S5000
G1 X93.789 Y92.447 E.00792
G1 X93.526 Y92.812 E.0084
G1 X93.229 Y93.149 E.0084
G1 X92.899 Y93.455 E.0084
G1 X92.541 Y93.727 E.0084
G1 X92.157 Y93.961 E.00841
G1 X91.752 Y94.156 E.0084
G1 X91.329 Y94.31 E.0084
G1 X90.894 Y94.421 E.0084
G1 X90.449 Y94.488 E.0084
G1 X90 Y94.51 E.0084
G1 X89.551 Y94.488 E.0084
G1 X89.106 Y94.421 E.0084
G1 X88.67 Y94.31 E.0084
G1 X88.248 Y94.156 E.0084
G1 X87.843 Y93.961 E.0084
G1 X87.457 Y93.725 E.00845
G1 X86.934 Y93.308 E.0125
G1 X86.618 Y92.984 E.00845
G1 X86.338 Y92.633 E.0084
G1 X86.094 Y92.255 E.0084
G1 X85.889 Y91.855 E.0084
G1 X85.724 Y91.437 E.0084
G1 X85.603 Y91.004 E.0084
G1 X85.525 Y90.561 E.0084
G1 X85.491 Y90.112 E.0084
G1 X85.502 Y89.663 E.0084
G1 X85.558 Y89.217 E.0084
G1 X85.658 Y88.778 E.00841
G1 X85.801 Y88.352 E.0084
G1 X85.986 Y87.942 E.0084
G1 X86.211 Y87.553 E.0084
G1 X86.474 Y87.188 E.0084
G1 X86.771 Y86.851 E.0084
G1 X87.101 Y86.545 E.0084
G1 X87.459 Y86.273 E.0084
G1 X87.843 Y86.039 E.0084
G1 X88.248 Y85.844 E.0084
G1 X88.67 Y85.69 E.0084
G1 X89.106 Y85.579 E.0084
G1 X89.55 Y85.512 E.00839
G1 X90.226 Y85.495 E.01263
G1 X90.672 Y85.54 E.00838
G1 X91.113 Y85.629 E.0084
G1 X91.543 Y85.762 E.00841
G1 X91.957 Y85.936 E.0084
G1 X92.352 Y86.151 E.0084
G1 X92.723 Y86.405 E.0084
G1 X93.068 Y86.694 E.0084
G1 X93.382 Y87.016 E.0084
G1 X93.662 Y87.367 E.0084
G1 X93.906 Y87.745 E.0084
G1 X94.111 Y88.145 E.0084
G1 X94.275 Y88.564 E.0084
G1 X94.397 Y88.996 E.0084
G1 X94.475 Y89.439 E.0084
G1 X94.509 Y89.888 E.0084
G1 X94.497 Y90.337 E.0084
G1 X94.442 Y90.783 E.0084
G1 X94.342 Y91.221 E.0084
G1 X94.198 Y91.648 E.00841
G1 X94.027 Y92.026 E.00776
; WIPE_START
M204 S6000
G1 X93.789 Y92.447 E-.06892
G1 X93.526 Y92.812 E-.06407
M106 S229.5
G1 X93.229 Y93.149 E-.06409
G1 X92.899 Y93.455 E-.06406
G1 X92.765 Y93.556 E-.02387
; WIPE_END
G1 E-.015
M204 S10000
G1 X88.483 Y87.238 Z2.76 F18000
G1 X86.941 Y84.963 Z2.76
G1 Z2.36
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F2400
M204 S6000
G1 X87.374 Y84.725 E.00993
G1 X88.045 Y84.441 E.01464
G1 X88.509 Y84.299 E.00975
G1 X89.223 Y84.159 E.01464
G1 X89.715 Y84.114 E.00994
G1 X90.209 Y84.111 E.00994
G1 X90.934 Y84.182 E.01463
G1 X91.409 Y84.278 E.00976
G1 X92.103 Y84.496 E.01463
G1 X92.558 Y84.691 E.00994
G1 X92.993 Y84.924 E.00994
G1 X93.596 Y85.332 E.01464
G1 X93.975 Y85.649 E.00993
G1 X94.325 Y85.999 E.00995
G1 X94.786 Y86.562 E.01464
G1 X95.052 Y86.968 E.00975
G1 X95.388 Y87.614 E.01465
G1 X95.566 Y88.066 E.00975
G1 X95.762 Y88.768 E.01466
G1 X95.846 Y89.255 E.00995
G1 X95.888 Y89.757 E.01012
G1 X95.887 Y90.252 E.00996
G1 X95.811 Y90.978 E.01466
G1 X95.708 Y91.462 E.00995
G1 X95.562 Y91.944 E.01014
G1 X95.377 Y92.408 E.01004
G1 X95.087 Y92.97 E.01272
G1 X94.818 Y93.392 E.01006
G1 X94.505 Y93.798 E.01032
G1 X94.025 Y94.303 E.01401
G1 X93.638 Y94.635 E.01025
G1 X93.229 Y94.929 E.01012
G1 X92.805 Y95.182 E.00993
G1 X92.146 Y95.488 E.01461
G1 X91.689 Y95.645 E.00972
G1 X90.983 Y95.81 E.01456
G1 X90.505 Y95.871 E.0097
G1 X89.82 Y95.89 E.01378
G1 X89.375 Y95.859 E.00897
G1 X88.661 Y95.738 E.01456
G1 X88.195 Y95.609 E.00971
G1 X87.519 Y95.344 E.0146
G1 X87.079 Y95.118 E.00995
G1 X86.653 Y94.851 E.01012
G1 X86.259 Y94.553 E.00995
G1 X85.725 Y94.056 E.01466
G1 X85.399 Y93.683 E.00996
G1 X85.106 Y93.283 E.00997
G1 X84.738 Y92.653 E.01467
G1 X84.537 Y92.21 E.00978
G1 X84.306 Y91.518 E.01467
G1 X84.198 Y91.034 E.00996
G1 X84.132 Y90.544 E.00995
G1 X84.11 Y89.815 E.01467
G1 X84.145 Y89.33 E.00976
G1 X84.273 Y88.613 E.01465
G1 X84.409 Y88.137 E.00994
G1 X84.585 Y87.675 E.00995
G1 X84.913 Y87.025 E.01464
G1 X85.175 Y86.617 E.00976
G1 X85.629 Y86.048 E.01464
G1 X85.969 Y85.701 E.00976
G1 X86.53 Y85.237 E.01463
G1 X86.891 Y84.996 E.00873
M204 S10000
G1 X86.721 Y84.6 F18000
G1 F2400
M204 S6000
G1 X87.189 Y84.342 E.01074
G1 X87.9 Y84.042 E.01552
G1 X88.405 Y83.887 E.01063
G1 X89.163 Y83.738 E.01552
G1 X89.694 Y83.69 E.01074
G1 X90.229 Y83.687 E.01075
G1 X90.996 Y83.762 E.01551
G1 X91.515 Y83.867 E.01064
G1 X92.251 Y84.097 E.01551
G1 X92.742 Y84.308 E.01074
G1 X93.213 Y84.561 E.01075
G1 X93.852 Y84.993 E.01552
G1 X94.261 Y85.336 E.01073
G1 X94.64 Y85.713 E.01075
G1 X95.128 Y86.311 E.01552
G1 X95.419 Y86.753 E.01063
G1 X95.775 Y87.438 E.01553
G1 X95.969 Y87.93 E.01063
G1 X96.177 Y88.674 E.01554
G1 X96.267 Y89.202 E.01075
G1 X96.312 Y89.74 E.01086
G1 X96.311 Y90.275 E.01076
G1 X96.23 Y91.044 E.01555
G1 X96.12 Y91.567 E.01076
G1 X95.963 Y92.085 E.01087
G1 X95.763 Y92.584 E.01081
G1 X95.455 Y93.182 E.01353
G1 X95.165 Y93.635 E.01082
G1 X94.833 Y94.069 E.01098
G1 X94.313 Y94.615 E.01516
G1 X93.9 Y94.969 E.01093
G1 X93.462 Y95.284 E.01085
G1 X93.004 Y95.558 E.01074
G1 X92.305 Y95.882 E.01549
G1 X91.806 Y96.054 E.0106
G1 X91.059 Y96.228 E.01543
G1 X90.538 Y96.294 E.01056
G1 X89.811 Y96.314 E.01462
G1 X89.325 Y96.281 E.0098
G1 X88.568 Y96.153 E.01542
G1 X88.061 Y96.012 E.01059
G1 X87.344 Y95.731 E.01547
G1 X86.869 Y95.487 E.01075
G1 X86.412 Y95.2 E.01085
G1 X85.985 Y94.878 E.01075
G1 X85.42 Y94.351 E.01554
G1 X85.068 Y93.948 E.01077
G1 X84.751 Y93.516 E.01077
G1 X84.361 Y92.848 E.01555
G1 X84.142 Y92.365 E.01066
G1 X83.897 Y91.632 E.01555
G1 X83.78 Y91.109 E.01077
G1 X83.709 Y90.579 E.01076
G1 X83.685 Y89.806 E.01555
G1 X83.724 Y89.278 E.01064
G1 X83.859 Y88.517 E.01553
G1 X84.006 Y88.003 E.01075
G1 X84.197 Y87.504 E.01075
G1 X84.544 Y86.815 E.01552
G1 X84.83 Y86.369 E.01064
G1 X85.311 Y85.766 E.01552
G1 X85.682 Y85.388 E.01064
G1 X86.276 Y84.897 E.01551
G1 X86.671 Y84.633 E.00954
M204 S250
G1 X86.508 Y84.25 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1980
M204 S5000
G1 X87.01 Y83.974 E.0107
M106 S73.95
M106 S229.5
G1 F2340
G1 X87.76 Y83.657 E.01521
M106 S73.95
M106 S229.5
G1 F1980
G1 X88.306 Y83.49 E.01067
M106 S73.95
M106 S229.5
G1 F2340
G1 X89.104 Y83.333 E.01521
M106 S73.95
M106 S229.5
G1 F2160
G1 X89.675 Y83.281 E.0107
M106 S73.95
M106 S229.5
G1 F1980
G1 X90.248 Y83.277 E.01071
M106 S73.95
M106 S229.5
G1 F2340
G1 X91.057 Y83.356 E.0152
M106 S73.95
M106 S229.5
G1 F2160
G1 X91.617 Y83.47 E.01067
M106 S73.95
M106 S229.5
G1 F2340
G1 X92.393 Y83.713 E.0152
M106 S73.95
M106 S229.5
G1 F1980
G1 X92.92 Y83.939 E.01071
M106 S73.95
M106 S229.5
G1 F2160
G1 X93.425 Y84.21 E.01071
M106 S73.95
M106 S229.5
G1 F2340
G1 X94.099 Y84.666 E.01521
M106 S73.95
M106 S229.5
G1 F1980
G1 X94.538 Y85.034 E.0107
M106 S73.95
M106 S229.5
G1 F2160
G1 X94.944 Y85.438 E.01071
M106 S73.95
M106 S229.5
G1 F2340
G1 X95.459 Y86.069 E.01521
M106 S73.95
M106 S229.5
G1 F2160
G1 X95.772 Y86.546 E.01067
M106 S73.95
M106 S229.5
G1 F2340
G1 X96.148 Y87.269 E.01522
M106 S73.95
M106 S229.5
G1 F1980
G1 X96.357 Y87.8 E.01067
M106 S73.95
M106 S229.5
G1 F2340
G1 X96.576 Y88.585 E.01522
M106 S73.95
M106 S229.5
G1 F1980
G1 X96.673 Y89.15 E.01072
G1 X96.721 Y89.723 E.01075
M106 S73.95
M106 S229.5
G1 F2160
G1 X96.72 Y90.297 E.01072
M106 S73.95
M106 S229.5
G1 F2340
G1 X96.635 Y91.108 E.01524
M106 S73.95
M106 S229.5
G1 F1980
G1 X96.516 Y91.669 E.01073
M106 S73.95
M106 S229.5
G1 F2160
G1 X96.349 Y92.22 E.01076
G1 X96.136 Y92.754 E.01074
G1 X95.811 Y93.386 E.01329
G1 X95.501 Y93.871 E.01075
M106 S73.95
M106 S229.5
G1 F1980
G1 X95.149 Y94.329 E.0108
G1 X94.926 Y94.581 E.00629
G1 X94.591 Y94.915 E.00883
G1 X94.154 Y95.291 E.01077
G1 X93.687 Y95.627 E.01074
G1 X93.195 Y95.92 E.01071
M106 S73.95
M106 S229.5
G1 F2340
G1 X92.458 Y96.262 E.01518
M106 S73.95
M106 S229.5
G1 F1980
G1 X91.92 Y96.447 E.01064
M106 S73.95
M106 S229.5
G1 F2340
G1 X91.131 Y96.631 E.01512
M106 S73.95
M106 S229.5
G1 F1980
G1 X90.57 Y96.703 E.01059
M106 S73.95
M106 S229.5
G1 F2160
G1 X89.803 Y96.724 E.01433
M106 S73.95
M106 S229.5
G1 F1980
G1 X89.276 Y96.688 E.00986
M106 S73.95
M106 S229.5
G1 F2160
G1 X88.479 Y96.553 E.0151
M106 S73.95
M106 S229.5
G1 F1980
G1 X87.931 Y96.401 E.01063
M106 S73.95
M106 S229.5
G1 F2340
G1 X87.176 Y96.105 E.01517
M106 S73.95
M106 S229.5
G1 F1980
G1 X86.666 Y95.843 E.0107
G1 X86.18 Y95.537 E.01074
G1 X85.722 Y95.192 E.01072
M106 S73.95
M106 S229.5
G1 F2340
G1 X85.125 Y94.636 E.01524
M106 S73.95
M106 S229.5
G1 F1980
G1 X84.748 Y94.204 E.01073
M106 S73.95
M106 S229.5
G1 F2160
G1 X84.408 Y93.74 E.01073
M106 S73.95
M106 S229.5
G1 F2340
G1 X83.997 Y93.036 E.01524
M106 S73.95
M106 S229.5
G1 F1980
G1 X83.76 Y92.515 E.0107
M106 S73.95
M106 S229.5
G1 F2160
G1 X83.502 Y91.741 E.01524
M106 S73.95
M106 S229.5
G1 F1980
G1 X83.377 Y91.181 E.01073
G1 X83.301 Y90.612 E.01072
M106 S73.95
M106 S229.5
G1 F2160
G1 X83.276 Y89.797 E.01524
M106 S73.95
M106 S229.5
G1 F1980
G1 X83.317 Y89.227 E.01068
M106 S73.95
M106 S229.5
G1 F2160
G1 X83.46 Y88.425 E.01522
M106 S73.95
M106 S229.5
M73 P78 R2
G1 F1980
G1 X83.617 Y87.874 E.01071
G1 X83.822 Y87.338 E.01071
M106 S73.95
M106 S229.5
G1 F2160
G1 X84.188 Y86.611 E.01521
M106 S73.95
M106 S229.5
G1 F1980
G1 X84.497 Y86.13 E.01068
M106 S73.95
M106 S229.5
G1 F2340
G1 X85.005 Y85.494 E.01521
M106 S73.95
M106 S229.5
G1 F1980
G1 X85.405 Y85.087 E.01068
M106 S73.95
M106 S229.5
G1 F2340
G1 X86.032 Y84.568 E.0152
M106 S73.95
M106 S229.5
G1 F2160
G1 X86.458 Y84.283 E.00958
M106 S73.95
; WIPE_START
M204 S6000
G1 X87.01 Y83.974 E-.09014
G1 X87.76 Y83.657 E-.11599
G1 X88.289 Y83.495 E-.07887
; WIPE_END
G1 E-.015 F1800
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
G1 X0 Y90.0001 ; move to safe pos
G1 X-13.0 F3000 ; move to safe pos
M400
M1004 S5 P1  ; external shutter
M400 P300
M971 S11 C11 O0
G92 E0
G1 X0 F18000
M623

; SKIPTYPE: head_wrap_detect
M622.1 S1
M1002 judge_flag g39_3rd_layer_detect_flag
M622 J1
    ; enable nozzle clog detect at 3rd layer
    


    M622.1 S1
    M1002 judge_flag g39_detection_flag
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




G1 X88.559 Y84.58
G1 Z2.36
G1 E.3 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.148298
G1 F2400
M204 S6000
G1 X88.885 Y84.499 E.00195
G1 X89.433 Y84.412 E.00323
G1 X89.877 Y84.386 E.00258
G1 X90.284 Y84.391 E.00236
G1 X90.893 Y84.454 E.00356
G1 X91.383 Y84.556 E.00291
G1 X92.008 Y84.754 E.00381
G1 X92.438 Y84.938 E.00272
G1 X92.926 Y85.206 E.00323
G1 X93.394 Y85.524 E.00329
G1 X93.819 Y85.88 E.00322
G1 X94.208 Y86.282 E.00325
G1 X94.565 Y86.725 E.0033
G1 X94.862 Y87.189 E.0032
G1 X95.138 Y87.728 E.00352
G1 X95.323 Y88.208 E.00299
G1 X95.493 Y88.828 E.00373
G1 X95.575 Y89.298 E.00277
G1 X95.615 Y89.857 E.00325
G1 X95.599 Y90.417 E.00325
G1 X95.533 Y90.972 E.00325
G1 X95.407 Y91.518 E.00325
G1 X95.228 Y92.049 E.00325
G1 X94.997 Y92.559 E.00325
G1 X94.716 Y93.049 E.00328
G1 X94.389 Y93.504 E.00325
G1 X94.017 Y93.922 E.00325
G1 X93.607 Y94.304 E.00325
G1 X93.162 Y94.643 E.00325
G1 X92.684 Y94.936 E.00325
G1 X92.178 Y95.175 E.00325
G1 X91.653 Y95.369 E.00325
G1 X91.11 Y95.504 E.00325
G1 X90.556 Y95.59 E.00325
G1 X90.003 Y95.615 E.00322
G1 X89.437 Y95.59 E.00329
G1 X88.884 Y95.503 E.00325
G1 X88.341 Y95.367 E.00325
G1 X87.822 Y95.174 E.00322
G1 X87.311 Y94.931 E.00328
G1 X86.824 Y94.635 E.00331
G1 X86.191 Y94.124 E.00473
G1 X85.791 Y93.718 E.00331
G1 X85.438 Y93.276 E.00328
G1 X85.137 Y92.804 E.00325
G1 X84.882 Y92.312 E.00322
G1 X84.68 Y91.791 E.00325
G1 X84.525 Y91.253 E.00325
G1 X84.427 Y90.695 E.00329
G1 X84.388 Y90.137 E.00325
G1 X84.399 Y89.577 E.00325
G1 X84.471 Y89.028 E.00322
G1 X84.593 Y88.482 E.00325
G1 X84.773 Y87.945 E.00329
G1 X85.006 Y87.437 E.00325
G1 X85.284 Y86.95 E.00325
G1 X85.613 Y86.498 E.00325
G1 X85.977 Y86.081 E.00322
G1 X86.39 Y85.702 E.00325
G1 X86.833 Y85.361 E.00325
G1 X87.316 Y85.066 E.00329
G1 X87.817 Y84.829 E.00322
G1 X88.342 Y84.634 E.00325
G1 X88.501 Y84.594 E.00096
; CHANGE_LAYER
; Z_HEIGHT: 2.48
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F2400
G1 X88.885 Y84.499 E-.05628
G1 X89.433 Y84.412 E-.07919
G1 X89.877 Y84.386 E-.06334
G1 X90.284 Y84.391 E-.05792
G1 X90.481 Y84.411 E-.02827
; WIPE_END
G1 E-.015 F1800
; layer num/total_layer_count: 20/33
; update layer progress
M73 L20
M991 S0 P19 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z2.76 I-1.078 J.565 P1  F18000
G1 X94.721 Y92.499 Z2.76
G1 Z2.48
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F2649
M204 S6000
G1 X94.49 Y92.9 E.00931
G1 X94.179 Y93.332 E.01071
G1 X93.826 Y93.732 E.01072
G1 X93.435 Y94.094 E.01071
G1 X93.011 Y94.416 E.01071
G1 X92.556 Y94.694 E.01071
G1 X92.076 Y94.925 E.01072
G1 X91.575 Y95.107 E.01071
G1 X91.059 Y95.239 E.01071
G1 X90.532 Y95.318 E.01072
G1 X90 Y95.345 E.01071
G1 X89.468 Y95.318 E.01071
G1 X88.941 Y95.239 E.01072
G1 X88.425 Y95.107 E.01071
G1 X87.924 Y94.925 E.01072
G1 X87.444 Y94.694 E.01071
G1 X86.989 Y94.416 E.01072
G1 X86.564 Y94.094 E.01071
G1 X86.174 Y93.732 E.01071
G1 X85.823 Y93.335 E.01065
G1 X85.571 Y92.988 E.00862
G1 X85.369 Y92.667 E.00762
G1 X85.128 Y92.198 E.01061
G1 X84.933 Y91.702 E.01071
G1 X84.789 Y91.19 E.01071
G1 X84.697 Y90.665 E.01072
G1 X84.657 Y90.133 E.01071
G1 X84.67 Y89.601 E.01071
G1 X84.736 Y89.072 E.01071
G1 X84.855 Y88.552 E.01072
G1 X85.024 Y88.047 E.01071
G1 X85.244 Y87.561 E.01072
G1 X85.51 Y87.1 E.01071
G1 X85.821 Y86.668 E.01071
G1 X86.174 Y86.268 E.01072
G1 X86.564 Y85.906 E.01071
G1 X86.989 Y85.584 E.01071
G1 X87.444 Y85.306 E.01071
G1 X87.924 Y85.075 E.01072
G1 X88.425 Y84.893 E.01071
G1 X88.941 Y84.761 E.01071
G1 X89.465 Y84.682 E.01066
G1 X89.893 Y84.658 E.00862
G1 X90.272 Y84.662 E.00762
G1 X90.796 Y84.715 E.0106
G1 X91.319 Y84.82 E.01071
G1 X91.828 Y84.978 E.01072
G1 X92.319 Y85.185 E.01071
G1 X92.787 Y85.439 E.01072
G1 X93.227 Y85.739 E.01071
G1 X93.635 Y86.082 E.01072
G1 X94.007 Y86.463 E.01071
G1 X94.339 Y86.88 E.01072
G1 X94.628 Y87.328 E.01071
G1 X94.872 Y87.802 E.01072
G1 X95.066 Y88.298 E.01071
G1 X95.211 Y88.81 E.0107
G1 X95.303 Y89.335 E.01072
G1 X95.343 Y89.867 E.01071
G1 X95.33 Y90.399 E.01071
G1 X95.263 Y90.928 E.01071
G1 X95.145 Y91.448 E.01072
G1 X94.975 Y91.953 E.01072
G1 X94.756 Y92.439 E.01072
G1 X94.751 Y92.447 E.0002
M204 S10000
G1 X94.354 Y92.287 F18000
G1 F2649
M204 S6000
G1 X94.133 Y92.669 E.00888
G1 X93.846 Y93.068 E.00986
G1 X93.522 Y93.435 E.00986
G1 X93.162 Y93.769 E.00986
G1 X92.771 Y94.065 E.00986
G1 X92.353 Y94.321 E.00986
G1 X91.911 Y94.534 E.00987
G1 X91.45 Y94.701 E.00986
G1 X90.975 Y94.822 E.00986
G1 X90.49 Y94.896 E.00987
G1 X90 Y94.92 E.00986
G1 X89.51 Y94.896 E.00986
G1 X89.025 Y94.822 E.00987
G1 X88.55 Y94.701 E.00986
G1 X88.089 Y94.534 E.00986
G1 X87.647 Y94.321 E.00986
G1 X87.228 Y94.065 E.00987
G1 X86.837 Y93.769 E.00986
G1 X86.478 Y93.435 E.00986
G1 X86.154 Y93.069 E.00983
G1 X85.922 Y92.75 E.00794
G1 X85.737 Y92.457 E.00696
G1 X85.515 Y92.023 E.0098
G1 X85.336 Y91.567 E.00986
G1 X85.203 Y91.095 E.00986
G1 X85.118 Y90.612 E.00987
G1 X85.081 Y90.123 E.00986
G1 X85.094 Y89.632 E.00986
G1 X85.155 Y89.146 E.00986
G1 X85.264 Y88.667 E.00987
G1 X85.42 Y88.203 E.00986
G1 X85.622 Y87.755 E.00987
G1 X85.867 Y87.331 E.00986
G1 X86.153 Y86.932 E.00986
G1 X86.478 Y86.565 E.00986
G1 X86.837 Y86.231 E.00986
G1 X87.228 Y85.935 E.00986
G1 X87.647 Y85.679 E.00986
G1 X88.089 Y85.466 E.00987
G1 X88.55 Y85.299 E.00986
G1 X89.025 Y85.178 E.00986
G1 X89.508 Y85.105 E.00983
G1 X89.902 Y85.083 E.00794
G1 X90.248 Y85.086 E.00696
G1 X90.733 Y85.135 E.00979
G1 X91.214 Y85.232 E.00986
G1 X91.683 Y85.377 E.00987
G1 X92.135 Y85.567 E.00986
G1 X92.565 Y85.802 E.00987
G1 X92.97 Y86.078 E.00986
G1 X93.346 Y86.393 E.00987
G1 X93.689 Y86.744 E.00986
G1 X93.995 Y87.128 E.00986
G1 X94.261 Y87.54 E.00986
G1 X94.485 Y87.977 E.00987
G1 X94.664 Y88.433 E.00986
G1 X94.796 Y88.905 E.00985
G1 X94.882 Y89.388 E.00987
G1 X94.918 Y89.877 E.00986
G1 X94.906 Y90.368 E.00986
G1 X94.845 Y90.854 E.00986
G1 X94.736 Y91.333 E.00986
G1 X94.58 Y91.798 E.00987
G1 X94.383 Y92.234 E.00964
M204 S250
G1 X93.999 Y92.082 F18000
M106 S229.5
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1800
M204 S5000
G1 X93.789 Y92.447 E.00787
G1 X93.526 Y92.812 E.0084
G1 X93.229 Y93.149 E.0084
G1 X92.899 Y93.455 E.0084
G1 X92.541 Y93.727 E.0084
G1 X92.157 Y93.961 E.0084
G1 X91.752 Y94.156 E.0084
G1 X91.329 Y94.31 E.0084
G1 X90.894 Y94.421 E.0084
G1 X90.449 Y94.488 E.00841
G1 X90 Y94.51 E.0084
G1 X89.551 Y94.488 E.0084
G1 X89.106 Y94.421 E.00841
G1 X88.67 Y94.31 E.0084
G1 X88.248 Y94.156 E.0084
G1 X87.843 Y93.961 E.0084
G1 X87.459 Y93.726 E.00841
G1 X87.101 Y93.455 E.0084
G1 X86.771 Y93.149 E.0084
G1 X86.474 Y92.813 E.00839
G1 X86.093 Y92.254 E.01263
G1 X85.889 Y91.855 E.00838
G1 X85.724 Y91.436 E.0084
G1 X85.603 Y91.004 E.0084
G1 X85.525 Y90.561 E.0084
G1 X85.491 Y90.112 E.0084
G1 X85.502 Y89.663 E.0084
G1 X85.558 Y89.217 E.0084
G1 X85.658 Y88.778 E.00841
G1 X85.801 Y88.352 E.0084
G1 X85.986 Y87.942 E.0084
G1 X86.211 Y87.553 E.0084
G1 X86.474 Y87.188 E.0084
G1 X86.771 Y86.851 E.0084
G1 X87.101 Y86.545 E.0084
G1 X87.459 Y86.273 E.0084
G1 X87.843 Y86.039 E.0084
G1 X88.248 Y85.844 E.00841
G1 X88.67 Y85.69 E.0084
G1 X89.106 Y85.579 E.0084
G1 X89.55 Y85.512 E.00839
G1 X90.226 Y85.495 E.01263
G1 X90.672 Y85.54 E.00838
G1 X91.113 Y85.629 E.0084
G1 X91.542 Y85.762 E.0084
G1 X91.957 Y85.936 E.0084
G1 X92.352 Y86.152 E.00841
G1 X92.723 Y86.405 E.0084
G1 X93.068 Y86.694 E.0084
G1 X93.382 Y87.016 E.0084
G1 X93.662 Y87.367 E.0084
G1 X93.906 Y87.745 E.0084
G1 X94.111 Y88.145 E.0084
G1 X94.275 Y88.564 E.0084
G1 X94.397 Y88.996 E.0084
G1 X94.475 Y89.439 E.0084
G1 X94.509 Y89.888 E.0084
G1 X94.497 Y90.337 E.0084
G1 X94.442 Y90.783 E.0084
G1 X94.342 Y91.222 E.0084
G1 X94.198 Y91.648 E.00841
G1 X94.026 Y92.029 E.00781
; WIPE_START
M204 S6000
G1 X93.789 Y92.447 E-.06854
G1 X93.526 Y92.812 E-.0641
G1 X93.229 Y93.149 E-.06406
G1 X92.899 Y93.455 E-.06406
G1 X92.763 Y93.558 E-.02424
; WIPE_END
G1 E-.015
M204 S10000
G1 X88.485 Y87.237 Z2.88 F18000
G1 X86.852 Y84.824 Z2.88
G1 Z2.48
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F2649
M204 S6000
G1 X87.321 Y84.567 E.01077
G1 X87.972 Y84.292 E.01421
G1 X88.478 Y84.137 E.01064
G1 X89.171 Y84 E.0142
G1 X89.704 Y83.949 E.01077
G1 X90.24 Y83.947 E.01078
G1 X90.943 Y84.016 E.0142
G1 X91.462 Y84.121 E.01064
G1 X92.136 Y84.332 E.0142
G1 X92.629 Y84.542 E.01077
G1 X93.101 Y84.796 E.01077
G1 X93.686 Y85.193 E.01421
G1 X94.096 Y85.537 E.01076
G1 X94.474 Y85.917 E.01079
G1 X94.919 Y86.466 E.01421
G1 X95.209 Y86.908 E.01064
G1 X95.534 Y87.536 E.01421
G1 X95.728 Y88.029 E.01064
G1 X95.918 Y88.71 E.01422
G1 X96.01 Y89.238 E.01078
G1 X96.053 Y89.778 E.01089
G1 X96.048 Y90.315 E.01081
G1 X95.971 Y91.019 E.01422
G1 X95.858 Y91.542 E.01076
G1 X95.695 Y92.059 E.01091
G1 X95.485 Y92.564 E.011
G1 X95.28 Y92.964 E.00903
G1 X94.991 Y93.43 E.01102
G1 X94.661 Y93.869 E.01103
G1 X94.201 Y94.362 E.01355
G1 X93.783 Y94.73 E.0112
G1 X93.346 Y95.05 E.0109
G1 X92.887 Y95.325 E.01075
G1 X92.248 Y95.624 E.01419
G1 X91.75 Y95.799 E.01062
G1 X91.066 Y95.962 E.01415
G1 X90.543 Y96.033 E.0106
G1 X89.868 Y96.055 E.01358
G1 X89.361 Y96.024 E.01022
G1 X88.834 Y95.944 E.01072
G1 X88.152 Y95.769 E.01416
G1 X87.65 Y95.584 E.01075
G1 X87.167 Y95.354 E.01077
G1 X86.562 Y94.988 E.01421
G1 X86.14 Y94.669 E.01065
G1 X85.622 Y94.187 E.01423
G1 X85.268 Y93.783 E.01079
G1 X84.952 Y93.349 E.0108
G1 X84.596 Y92.738 E.01423
G1 X84.377 Y92.255 E.01066
G1 X84.153 Y91.584 E.01423
G1 X84.035 Y91.06 E.01079
G1 X83.965 Y90.528 E.01079
G1 X83.945 Y89.821 E.01423
G1 X83.984 Y89.293 E.01065
G1 X84.107 Y88.597 E.01422
G1 X84.254 Y88.081 E.01078
G1 X84.446 Y87.581 E.01078
G1 X84.766 Y86.95 E.01421
G1 X85.052 Y86.505 E.01064
G1 X85.493 Y85.953 E.01421
G1 X85.863 Y85.575 E.01064
G1 X86.407 Y85.123 E.01421
G1 X86.802 Y84.858 E.00957
M204 S10000
G1 X86.631 Y84.462 F18000
G1 F2649
M204 S6000
G1 X87.136 Y84.185 E.01159
G1 X87.827 Y83.893 E.01508
G1 X88.374 Y83.725 E.01151
G1 X89.11 Y83.579 E.01507
G1 X89.684 Y83.525 E.01159
G1 X90.26 Y83.523 E.0116
G1 X91.006 Y83.596 E.01507
G1 X91.568 Y83.71 E.01152
G1 X92.283 Y83.933 E.01507
G1 X92.813 Y84.16 E.01159
G1 X93.321 Y84.433 E.01159
G1 X93.942 Y84.854 E.01508
G1 X94.383 Y85.224 E.01158
G1 X94.79 Y85.633 E.01161
G1 X95.263 Y86.215 E.01508
G1 X95.576 Y86.694 E.01151
G1 X95.921 Y87.36 E.01508
G1 X96.13 Y87.893 E.01152
G1 X96.333 Y88.616 E.01509
G1 X96.431 Y89.185 E.0116
G1 X96.478 Y89.763 E.01166
G1 X96.472 Y90.341 E.01162
G1 X96.39 Y91.087 E.01509
G1 X96.268 Y91.65 E.01159
G1 X96.094 Y92.205 E.01168
G1 X95.87 Y92.743 E.01173
G1 X95.649 Y93.173 E.00972
G1 X95.342 Y93.67 E.01175
G1 X94.99 Y94.137 E.01175
G1 X94.492 Y94.671 E.0147
G1 X94.049 Y95.061 E.01185
G1 X93.581 Y95.403 E.01167
G1 X93.087 Y95.7 E.01158
G1 X92.409 Y96.017 E.01506
G1 X91.87 Y96.207 E.01149
G1 X91.144 Y96.38 E.01501
G1 X90.579 Y96.456 E.01146
G1 X89.862 Y96.48 E.01441
G1 X89.316 Y96.446 E.011
G1 X88.749 Y96.361 E.01154
G1 X88.025 Y96.174 E.01502
G1 X87.486 Y95.975 E.01157
G1 X86.965 Y95.728 E.01158
G1 X86.324 Y95.34 E.01507
G1 X85.867 Y94.994 E.01152
G1 X85.317 Y94.482 E.0151
G1 X84.937 Y94.048 E.01161
G1 X84.597 Y93.581 E.01162
G1 X84.219 Y92.932 E.0151
G1 X83.982 Y92.41 E.01154
G1 X83.744 Y91.698 E.0151
G1 X83.617 Y91.134 E.01161
G1 X83.542 Y90.562 E.01161
G1 X83.52 Y89.812 E.0151
G1 X83.562 Y89.24 E.01152
G1 X83.693 Y88.501 E.01509
G1 X83.851 Y87.946 E.0116
G1 X84.058 Y87.408 E.01159
G1 X84.397 Y86.739 E.01508
G1 X84.707 Y86.258 E.01151
G1 X85.175 Y85.671 E.01508
G1 X85.575 Y85.262 E.01152
G1 X86.152 Y84.783 E.01507
G1 X86.581 Y84.495 E.01039
M204 S250
G1 X86.418 Y84.112 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1560
M204 S5000
G1 X86.958 Y83.816 E.0115
G1 X87.687 Y83.508 E.01479
G1 X88.274 Y83.327 E.01148
G1 X89.051 Y83.174 E.01479
G1 X89.664 Y83.116 E.01151
G1 X90.28 Y83.114 E.01151
G1 X91.067 Y83.191 E.01478
M106 S73.95
M106 S229.5
G1 X91.669 Y83.313 E.01148
G1 X92.425 Y83.549 E.01479
G1 X92.991 Y83.791 E.0115
G1 X93.533 Y84.083 E.01151
G1 X94.188 Y84.527 E.01479
G1 X94.66 Y84.922 E.0115
G1 X95.095 Y85.359 E.01151
G1 X95.594 Y85.973 E.01479
G1 X95.93 Y86.488 E.01148
G1 X96.294 Y87.191 E.01479
G1 X96.519 Y87.763 E.01149
G1 X96.732 Y88.526 E.0148
G1 X96.837 Y89.133 E.01152
G1 X96.887 Y89.748 E.01153
G1 X96.881 Y90.365 E.01152
G1 X96.795 Y91.153 E.01481
G1 X96.664 Y91.755 E.01152
M73 P79 R2
G1 X96.479 Y92.345 E.01155
G1 X96.242 Y92.916 E.01156
G1 X96.006 Y93.374 E.00964
G1 X95.68 Y93.901 E.01157
G1 X95.308 Y94.396 E.01157
M106 S73.95
M106 S229.5
G1 F1440
G1 X95.013 Y94.729 E.0083
G1 X94.772 Y94.97 E.00638
M106 S73.95
M106 S229.5
G1 F1560
G1 X94.306 Y95.38 E.0116
G1 X93.807 Y95.745 E.01154
G1 X93.28 Y96.062 E.0115
G1 X92.564 Y96.397 E.01477
G1 X91.985 Y96.6 E.01146
G1 X91.219 Y96.783 E.01473
G1 X90.613 Y96.865 E.01142
G1 X89.856 Y96.89 E.01415
G1 X89.273 Y96.854 E.01092
G1 X88.667 Y96.762 E.01145
G1 X87.903 Y96.565 E.01474
G1 X87.327 Y96.353 E.01148
G1 X86.771 Y96.089 E.0115
G1 X86.094 Y95.679 E.01479
G1 X85.603 Y95.308 E.01149
G1 X85.023 Y94.768 E.01481
G1 X84.617 Y94.304 E.01152
G1 X84.254 Y93.805 E.01153
G1 X83.854 Y93.12 E.01481
G1 X83.601 Y92.56 E.0115
G1 X83.349 Y91.808 E.01481
G1 X83.214 Y91.206 E.01152
G1 X83.134 Y90.595 E.01152
G1 X83.11 Y89.802 E.01481
G1 X83.156 Y89.189 E.01149
G1 X83.294 Y88.409 E.0148
G1 X83.463 Y87.817 E.01152
G1 X83.684 Y87.242 E.01151
G1 X84.042 Y86.535 E.0148
G1 X84.374 Y86.019 E.01148
G1 X84.868 Y85.4 E.01479
G1 X85.298 Y84.961 E.01148
G1 X85.907 Y84.455 E.01479
G1 X86.368 Y84.145 E.01039
M106 S73.95
; WIPE_START
M204 S6000
G1 X86.958 Y83.816 E-.09626
G1 X87.687 Y83.508 E-.1128
G1 X88.196 Y83.351 E-.07595
; WIPE_END
G1 E-.015 F1800
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
G1 X0 Y90.0001 ; move to safe pos
G1 X-13.0 F3000 ; move to safe pos
M400
M1004 S5 P1  ; external shutter
M400 P300
M971 S11 C11 O0
G92 E0
G1 X0 F18000
M623

; SKIPTYPE: head_wrap_detect
M622.1 S1
M1002 judge_flag g39_3rd_layer_detect_flag
M622 J1
    ; enable nozzle clog detect at 3rd layer
    


    M622.1 S1
    M1002 judge_flag g39_detection_flag
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




G1 X88.489 Y84.513
G1 Z2.48
G1 E.3 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.313087
G1 F2400
M204 S6000
G1 X88.864 Y84.418 E.00527
G1 X89.422 Y84.331 E.00769
G1 X89.88 Y84.304 E.00625
G1 X90.285 Y84.308 E.00552
G1 X90.89 Y84.37 E.00828
G1 X91.399 Y84.474 E.00708
G1 X92.012 Y84.668 E.00876
G1 X92.474 Y84.864 E.00683
G1 X92.966 Y85.133 E.00763
G1 X93.447 Y85.46 E.00793
G1 X93.872 Y85.816 E.00755
G1 X94.268 Y86.224 E.00774
G1 X94.631 Y86.676 E.0079
G1 X94.932 Y87.144 E.00758
G1 X95.209 Y87.684 E.00826
G1 X95.401 Y88.178 E.00722
G1 X95.569 Y88.788 E.00862
G1 X95.656 Y89.284 E.00685
G1 X95.698 Y89.851 E.00774
G1 X95.682 Y90.419 E.00774
G1 X95.615 Y90.983 E.00773
G1 X95.488 Y91.537 E.00774
G1 X95.306 Y92.075 E.00774
G1 X95.073 Y92.593 E.00774
G1 X94.782 Y93.097 E.00792
G1 X94.451 Y93.559 E.00774
G1 X94.073 Y93.983 E.00774
G1 X93.657 Y94.37 E.00774
G1 X93.205 Y94.713 E.00774
G1 X92.72 Y95.01 E.00774
G1 X92.207 Y95.254 E.00774
G1 X91.673 Y95.449 E.00774
G1 X91.122 Y95.586 E.00773
G1 X90.56 Y95.672 E.00774
G1 X90.007 Y95.698 E.00754
G1 X89.425 Y95.672 E.00793
G1 X88.905 Y95.594 E.00716
G1 X88.313 Y95.444 E.00832
G1 X87.789 Y95.255 E.00759
G1 X87.28 Y95.009 E.00769
G1 X86.763 Y94.692 E.00826
G1 X86.341 Y94.371 E.00722
G1 X85.915 Y93.975 E.00793
G1 X85.547 Y93.56 E.00754
G1 X85.252 Y93.153 E.00685
G1 X84.916 Y92.573 E.00914
G1 X84.712 Y92.123 E.00672
G1 X84.598 Y91.808 E.00457
G1 X84.443 Y91.261 E.00773
G1 X84.345 Y90.702 E.00774
G1 X84.305 Y90.135 E.00773
G1 X84.318 Y89.567 E.00774
G1 X84.389 Y89.018 E.00754
G1 X84.513 Y88.463 E.00774
G1 X84.698 Y87.912 E.00792
G1 X84.934 Y87.395 E.00774
G1 X85.217 Y86.902 E.00773
G1 X85.551 Y86.443 E.00773
G1 X85.916 Y86.026 E.00755
G1 X86.333 Y85.641 E.00774
G1 X86.784 Y85.296 E.00773
G1 X87.281 Y84.992 E.00793
G1 X87.781 Y84.754 E.00755
G1 X88.314 Y84.557 E.00773
G1 X88.431 Y84.527 E.00164
; CHANGE_LAYER
; Z_HEIGHT: 2.6
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F2400
G1 X88.864 Y84.418 E-.06369
G1 X89.422 Y84.331 E-.08044
G1 X89.88 Y84.304 E-.06543
G1 X90.285 Y84.308 E-.05771
G1 X90.409 Y84.321 E-.01772
; WIPE_END
G1 E-.015 F1800
; layer num/total_layer_count: 21/33
; update layer progress
M73 L21
M991 S0 P20 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z2.88 I-1.077 J.567 P1  F18000
G1 X94.72 Y92.501 Z2.88
G1 Z2.6
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F2814
M204 S6000
G1 X94.49 Y92.9 E.00925
G1 X94.178 Y93.332 E.01072
G1 X93.826 Y93.732 E.01071
G1 X93.435 Y94.094 E.01072
G1 X93.011 Y94.416 E.01071
G1 X92.556 Y94.694 E.01071
G1 X92.076 Y94.925 E.01072
G1 X91.575 Y95.107 E.01071
G1 X91.059 Y95.239 E.01071
G1 X90.532 Y95.318 E.01072
G1 X90 Y95.345 E.01071
G1 X89.468 Y95.318 E.01071
G1 X88.941 Y95.239 E.01072
G1 X88.425 Y95.107 E.0107
G1 X87.924 Y94.925 E.01072
G1 X87.444 Y94.694 E.01071
G1 X86.989 Y94.416 E.01072
G1 X86.569 Y94.098 E.01059
G1 X86.293 Y93.848 E.00748
G1 X85.991 Y93.534 E.00877
G1 X85.66 Y93.12 E.01066
G1 X85.371 Y92.673 E.01071
G1 X85.128 Y92.198 E.01072
G1 X84.933 Y91.702 E.01072
G1 X84.789 Y91.189 E.0107
G1 X84.697 Y90.665 E.01072
G1 X84.657 Y90.133 E.01071
G1 X84.67 Y89.601 E.01071
G1 X84.736 Y89.072 E.01071
G1 X84.855 Y88.552 E.01072
G1 X85.025 Y88.047 E.01071
G1 X85.244 Y87.561 E.01072
G1 X85.51 Y87.1 E.01071
G1 X85.821 Y86.667 E.01072
G1 X86.174 Y86.268 E.0107
G1 X86.564 Y85.906 E.01072
G1 X86.989 Y85.584 E.01071
G1 X87.444 Y85.306 E.01072
G1 X87.924 Y85.075 E.01071
G1 X88.425 Y84.893 E.01071
G1 X88.941 Y84.761 E.01071
G1 X89.465 Y84.682 E.01066
G1 X89.9 Y84.658 E.00877
G1 X90.272 Y84.662 E.00748
G1 X90.796 Y84.715 E.01059
G1 X91.319 Y84.82 E.01071
G1 X91.828 Y84.978 E.01072
G1 X92.319 Y85.185 E.01071
G1 X92.787 Y85.439 E.01071
G1 X93.227 Y85.74 E.01071
G1 X93.635 Y86.082 E.01072
G1 X94.007 Y86.463 E.01071
G1 X94.339 Y86.88 E.01072
G1 X94.628 Y87.328 E.01071
G1 X94.872 Y87.802 E.01072
G1 X95.066 Y88.298 E.01072
G1 X95.211 Y88.81 E.0107
G1 X95.303 Y89.335 E.01072
G1 X95.343 Y89.867 E.01071
G1 X95.33 Y90.399 E.01072
G1 X95.263 Y90.928 E.01071
G1 X95.145 Y91.448 E.01072
G1 X94.975 Y91.953 E.01071
G1 X94.756 Y92.439 E.01072
G1 X94.75 Y92.449 E.00025
M204 S10000
G1 X94.352 Y92.289 F18000
G1 F2814
M204 S6000
G1 X94.133 Y92.669 E.00883
G1 X93.846 Y93.068 E.00987
G1 X93.522 Y93.435 E.00986
G1 X93.162 Y93.769 E.00986
G1 X92.771 Y94.065 E.00986
G1 X92.353 Y94.321 E.00986
G1 X91.911 Y94.534 E.00986
G1 X91.45 Y94.701 E.00986
G1 X90.975 Y94.822 E.00986
G1 X90.49 Y94.896 E.00987
G1 X90 Y94.92 E.00986
G1 X89.51 Y94.896 E.00986
G1 X89.025 Y94.822 E.00987
G1 X88.55 Y94.701 E.00986
G1 X88.089 Y94.534 E.00987
G1 X87.647 Y94.321 E.00986
G1 X87.228 Y94.065 E.00987
G1 X86.84 Y93.771 E.00979
G1 X86.589 Y93.543 E.00682
G1 X86.31 Y93.254 E.00808
G1 X86.005 Y92.872 E.00983
G1 X85.739 Y92.46 E.00986
G1 X85.515 Y92.023 E.00986
G1 X85.336 Y91.567 E.00987
G1 X85.203 Y91.095 E.00986
G1 X85.118 Y90.612 E.00986
G1 X85.081 Y90.123 E.00986
G1 X85.094 Y89.632 E.00986
G1 X85.155 Y89.146 E.00986
G1 X85.264 Y88.668 E.00986
G1 X85.42 Y88.202 E.00986
G1 X85.622 Y87.755 E.00986
G1 X85.867 Y87.331 E.00986
G1 X86.153 Y86.932 E.00987
G1 X86.478 Y86.565 E.00986
G1 X86.837 Y86.231 E.00987
G1 X87.228 Y85.935 E.00986
G1 X87.647 Y85.679 E.00987
G1 X88.089 Y85.466 E.00986
G1 X88.55 Y85.299 E.00986
G1 X89.025 Y85.178 E.00986
G1 X89.508 Y85.105 E.00983
G1 X89.91 Y85.082 E.00808
G1 X90.249 Y85.086 E.00682
G1 X90.733 Y85.135 E.00979
G1 X91.214 Y85.232 E.00986
G1 X91.683 Y85.377 E.00987
G1 X92.135 Y85.567 E.00986
G1 X92.565 Y85.802 E.00986
G1 X92.971 Y86.078 E.00986
G1 X93.346 Y86.393 E.00986
G1 X93.689 Y86.744 E.00986
G1 X93.995 Y87.128 E.00986
G1 X94.261 Y87.54 E.00986
G1 X94.484 Y87.977 E.00987
G1 X94.664 Y88.433 E.00986
G1 X94.796 Y88.905 E.00985
G1 X94.882 Y89.388 E.00987
G1 X94.918 Y89.877 E.00986
G1 X94.906 Y90.368 E.00986
G1 X94.845 Y90.854 E.00986
G1 X94.736 Y91.333 E.00987
G1 X94.58 Y91.798 E.00986
G1 X94.381 Y92.237 E.00969
M204 S250
G1 X93.998 Y92.085 F18000
M106 S229.5
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1800
M204 S5000
G1 X93.789 Y92.447 E.00782
G1 X93.526 Y92.812 E.0084
G1 X93.229 Y93.149 E.0084
G1 X92.899 Y93.455 E.0084
G1 X92.54 Y93.727 E.0084
G1 X92.157 Y93.961 E.0084
G1 X91.752 Y94.156 E.0084
G1 X91.329 Y94.31 E.0084
G1 X90.894 Y94.421 E.0084
G1 X90.449 Y94.488 E.00841
G1 X90 Y94.51 E.0084
G1 X89.551 Y94.488 E.0084
G1 X89.106 Y94.421 E.00841
G1 X88.67 Y94.31 E.0084
G1 X88.248 Y94.156 E.0084
G1 X87.843 Y93.961 E.0084
G1 X87.459 Y93.727 E.0084
G1 X87.102 Y93.456 E.00838
G1 X86.618 Y92.984 E.01263
G1 X86.338 Y92.633 E.00839
G1 X86.094 Y92.255 E.0084
G1 X85.889 Y91.855 E.0084
G1 X85.724 Y91.436 E.0084
G1 X85.603 Y91.004 E.0084
G1 X85.525 Y90.561 E.0084
G1 X85.491 Y90.112 E.0084
G1 X85.502 Y89.663 E.0084
G1 X85.558 Y89.217 E.0084
G1 X85.658 Y88.779 E.0084
G1 X85.801 Y88.352 E.00841
G1 X85.986 Y87.942 E.0084
G1 X86.211 Y87.553 E.0084
G1 X86.474 Y87.188 E.0084
G1 X86.771 Y86.851 E.0084
G1 X87.101 Y86.545 E.0084
G1 X87.459 Y86.273 E.0084
G1 X87.843 Y86.039 E.00841
G1 X88.248 Y85.844 E.0084
G1 X88.67 Y85.69 E.0084
G1 X89.106 Y85.579 E.0084
G1 X89.55 Y85.512 E.00839
G1 X90.226 Y85.495 E.01263
G1 X90.672 Y85.54 E.00838
G1 X91.113 Y85.629 E.0084
G1 X91.543 Y85.762 E.00841
G1 X91.957 Y85.936 E.0084
G1 X92.352 Y86.151 E.0084
G1 X92.723 Y86.405 E.0084
G1 X93.068 Y86.694 E.0084
G1 X93.382 Y87.016 E.0084
G1 X93.662 Y87.367 E.0084
G1 X93.906 Y87.745 E.0084
G1 X94.111 Y88.145 E.0084
G1 X94.275 Y88.564 E.0084
G1 X94.397 Y88.996 E.0084
G1 X94.475 Y89.439 E.0084
G1 X94.509 Y89.888 E.0084
G1 X94.497 Y90.337 E.0084
G1 X94.442 Y90.783 E.0084
G1 X94.342 Y91.222 E.0084
G1 X94.198 Y91.648 E.0084
G1 X94.025 Y92.031 E.00786
; WIPE_START
M204 S6000
G1 X93.789 Y92.447 E-.06818
G1 X93.526 Y92.812 E-.06409
G1 X93.229 Y93.149 E-.06404
G1 X92.899 Y93.455 E-.06408
G1 X92.761 Y93.559 E-.0246
; WIPE_END
G1 E-.015
M204 S10000
G1 X88.486 Y87.236 Z3 F18000
G1 X86.762 Y84.686 Z3
G1 Z2.6
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F2814
M204 S6000
G1 X87.268 Y84.409 E.01161
G1 X87.899 Y84.143 E.01377
G1 X88.447 Y83.974 E.01153
G1 X89.119 Y83.84 E.01377
G1 X89.694 Y83.785 E.01161
G1 X90.271 Y83.783 E.01161
G1 X90.953 Y83.851 E.01377
G1 X91.515 Y83.965 E.01153
G1 X92.169 Y84.168 E.01377
G1 X92.7 Y84.394 E.01161
G1 X93.208 Y84.668 E.01162
G1 X93.775 Y85.053 E.01377
G1 X94.217 Y85.424 E.01161
G1 X94.623 Y85.836 E.01162
G1 X95.053 Y86.369 E.01377
G1 X95.366 Y86.849 E.01153
G1 X95.68 Y87.458 E.01377
G1 X95.889 Y87.992 E.01153
G1 X96.074 Y88.652 E.01378
G1 X96.174 Y89.221 E.01162
G1 X96.219 Y89.8 E.01168
G1 X96.21 Y90.379 E.01164
G1 X96.131 Y91.06 E.01378
G1 X96.007 Y91.62 E.01154
G1 X95.793 Y92.272 E.01381
G1 X95.472 Y92.956 E.01519
G1 X95.165 Y93.467 E.01198
G1 X94.823 Y93.93 E.01158
G1 X94.357 Y94.44 E.01389
G1 X94.01 Y94.759 E.00948
G1 X93.46 Y95.171 E.01381
G1 X92.97 Y95.468 E.01153
G1 X92.351 Y95.761 E.01376
G1 X91.807 Y95.954 E.0116
G1 X91.249 Y96.096 E.01158
G1 X90.578 Y96.195 E.01363
G1 X89.917 Y96.221 E.01331
G1 X89.357 Y96.19 E.01127
G1 X88.788 Y96.104 E.01157
M73 P80 R2
G1 X88.127 Y95.934 E.01374
G1 X87.585 Y95.735 E.0116
G1 X87.064 Y95.486 E.01161
G1 X86.479 Y95.131 E.01377
G1 X86.021 Y94.785 E.01153
G1 X85.519 Y94.318 E.01378
G1 X85.138 Y93.884 E.01162
G1 X84.798 Y93.415 E.01163
G1 X84.454 Y92.823 E.01378
G1 X84.218 Y92.3 E.01154
G1 X84 Y91.65 E.01378
G1 X83.872 Y91.086 E.01163
G1 X83.799 Y90.512 E.01162
G1 X83.78 Y89.827 E.01378
G1 X83.822 Y89.255 E.01154
G1 X83.941 Y88.581 E.01377
G1 X84.099 Y88.025 E.01162
G1 X84.308 Y87.486 E.01161
G1 X84.618 Y86.875 E.01378
G1 X84.929 Y86.394 E.01153
G1 X85.356 Y85.858 E.01377
G1 X85.757 Y85.448 E.01153
G1 X86.283 Y85.01 E.01377
G1 X86.712 Y84.72 E.01041
M204 S10000
G1 X86.541 Y84.323 F18000
G1 F2814
M204 S6000
G1 X87.084 Y84.026 E.01245
G1 X87.754 Y83.743 E.01463
G1 X88.343 Y83.562 E.01239
G1 X89.057 Y83.42 E.01463
G1 X89.673 Y83.36 E.01244
G1 X90.292 Y83.359 E.01245
G1 X91.016 Y83.431 E.01463
G1 X91.62 Y83.553 E.01239
G1 X92.315 Y83.769 E.01463
G1 X92.884 Y84.011 E.01244
G1 X93.429 Y84.305 E.01245
G1 X94.031 Y84.714 E.01463
G1 X94.505 Y85.112 E.01244
G1 X94.94 Y85.553 E.01245
G1 X95.397 Y86.119 E.01463
G1 X95.733 Y86.636 E.0124
G1 X96.067 Y87.283 E.01464
G1 X96.292 Y87.856 E.01239
G1 X96.489 Y88.558 E.01464
G1 X96.595 Y89.168 E.01245
G1 X96.644 Y89.787 E.01249
G1 X96.634 Y90.406 E.01246
G1 X96.55 Y91.13 E.01464
G1 X96.417 Y91.732 E.0124
G1 X96.189 Y92.425 E.01467
G1 X95.843 Y93.163 E.01639
G1 X95.519 Y93.703 E.01266
G1 X95.151 Y94.2 E.01243
G1 X94.658 Y94.74 E.01471
G1 X94.281 Y95.085 E.01027
G1 X93.698 Y95.523 E.01466
G1 X93.171 Y95.842 E.0124
G1 X92.513 Y96.153 E.01462
G1 X91.931 Y96.361 E.01243
G1 X91.332 Y96.512 E.01242
G1 X90.618 Y96.618 E.01452
G1 X89.913 Y96.646 E.01418
G1 X89.314 Y96.612 E.01207
G1 X88.704 Y96.52 E.0124
G1 X88 Y96.339 E.0146
G1 X87.42 Y96.127 E.01243
G1 X86.862 Y95.86 E.01244
G1 X86.24 Y95.482 E.01463
G1 X85.748 Y95.11 E.0124
G1 X85.215 Y94.614 E.01465
G1 X84.806 Y94.149 E.01245
G1 X84.442 Y93.647 E.01246
G1 X84.076 Y93.017 E.01465
G1 X83.822 Y92.455 E.01241
G1 X83.591 Y91.764 E.01465
G1 X83.454 Y91.16 E.01246
G1 X83.375 Y90.545 E.01245
G1 X83.355 Y89.817 E.01465
G1 X83.4 Y89.202 E.0124
G1 X83.527 Y88.486 E.01464
G1 X83.696 Y87.89 E.01245
G1 X83.92 Y87.313 E.01244
G1 X84.25 Y86.664 E.01464
G1 X84.584 Y86.146 E.01239
G1 X85.038 Y85.577 E.01463
G1 X85.469 Y85.136 E.0124
G1 X86.028 Y84.67 E.01463
G1 X86.491 Y84.357 E.01124
M204 S250
G1 X86.327 Y83.974 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1440
M204 S5000
G1 X86.906 Y83.657 E.01231
M106 S73.95
M106 S229.5
G1 F1560
G1 X87.614 Y83.358 E.01437
M106 S73.95
M106 S229.5
G1 F1440
G1 X88.243 Y83.165 E.01229
M106 S73.95
M106 S229.5
G1 F1560
G1 X88.997 Y83.015 E.01437
M106 S73.95
M106 S229.5
G1 F1440
G1 X89.653 Y82.951 E.01231
G1 X90.312 Y82.95 E.01231
M106 S73.95
M106 S229.5
G1 F1560
G1 X91.077 Y83.025 E.01437
M106 S73.95
M106 S229.5
G1 F1440
G1 X91.722 Y83.156 E.0123
M106 S73.95
M106 S229.5
G1 F1560
G1 X92.456 Y83.384 E.01437
M106 S73.95
M106 S229.5
G1 F1440
G1 X93.062 Y83.642 E.01231
G1 X93.642 Y83.955 E.01231
M106 S73.95
M106 S229.5
G1 F1560
G1 X94.278 Y84.387 E.01437
M106 S73.95
M106 S229.5
G1 F1440
G1 X94.783 Y84.811 E.01231
G1 X95.245 Y85.28 E.01231
M106 S73.95
M106 S229.5
G1 F1560
G1 X95.728 Y85.878 E.01437
M106 S73.95
M106 S229.5
G1 F1440
G1 X96.087 Y86.43 E.01229
M106 S73.95
M106 S229.5
G1 F1560
G1 X96.44 Y87.114 E.01438
M106 S73.95
M106 S229.5
G1 F1440
G1 X96.681 Y87.726 E.01229
M106 S73.95
M106 S229.5
G1 F1560
G1 X96.888 Y88.467 E.01438
M106 S73.95
M106 S229.5
G1 F1440
G1 X97.002 Y89.116 E.01232
G1 X97.053 Y89.774 E.01232
M106 S73.95
M106 S229.5
G1 F1560
G1 X97.043 Y90.433 E.01232
G1 X96.955 Y91.198 E.01438
G1 X96.812 Y91.841 E.0123
G1 X96.572 Y92.572 E.01439
M106 S73.95
M106 S229.5
G1 F1440
G1 X96.348 Y93.077 E.01031
M106 S73.95
M106 S229.5
G1 F1560
G1 X96.201 Y93.362 E.00601
G1 X95.859 Y93.93 E.01238
G1 X95.468 Y94.46 E.01231
G1 X94.947 Y95.029 E.0144
M106 S73.95
M106 S229.5
G1 F1440
G1 X94.543 Y95.4 E.01025
M106 S73.95
M106 S229.5
G1 F1560
G1 X93.928 Y95.863 E.01439
M106 S73.95
M106 S229.5
G1 F1440
G1 X93.365 Y96.203 E.0123
M106 S73.95
M106 S229.5
G1 F1560
G1 X92.67 Y96.532 E.01436
G1 X92.05 Y96.753 E.01229
M106 S73.95
M106 S229.5
G1 F1440
G1 X91.413 Y96.914 E.01228
M106 S73.95
M106 S229.5
G1 F1560
G1 X90.656 Y97.026 E.0143
G1 X89.91 Y97.056 E.01395
G1 X89.272 Y97.02 E.01195
M106 S73.95
M106 S229.5
G1 F1440
G1 X88.622 Y96.921 E.01227
M106 S73.95
M106 S229.5
G1 F1560
G1 X87.879 Y96.731 E.01434
M106 S73.95
M106 S229.5
G1 F1440
G1 X87.261 Y96.504 E.01229
G1 X86.667 Y96.22 E.01231
M106 S73.95
M106 S229.5
G1 F1560
G1 X86.01 Y95.821 E.01437
M106 S73.95
M106 S229.5
G1 F1440
G1 X85.485 Y95.424 E.0123
M106 S73.95
M106 S229.5
G1 F1560
G1 X84.921 Y94.9 E.01438
M106 S73.95
M106 S229.5
G1 F1440
G1 X84.486 Y94.404 E.01232
G1 X84.099 Y93.87 E.01232
M106 S73.95
M106 S229.5
G1 F1560
G1 X83.712 Y93.205 E.01439
M106 S73.95
M106 S229.5
G1 F1440
G1 X83.441 Y92.604 E.01231
M106 S73.95
M106 S229.5
G1 F1560
G1 X83.196 Y91.874 E.01439
M106 S73.95
M106 S229.5
G1 F1440
G1 X83.051 Y91.231 E.01232
G1 X82.967 Y90.577 E.01232
M106 S73.95
M106 S229.5
G1 F1560
G1 X82.945 Y89.808 E.01438
M106 S73.95
M106 S229.5
G1 F1440
G1 X82.994 Y89.152 E.0123
M106 S73.95
M106 S229.5
G1 F1560
G1 X83.128 Y88.394 E.01438
M106 S73.95
M106 S229.5
G1 F1440
G1 X83.308 Y87.76 E.01232
G1 X83.546 Y87.146 E.01231
M106 S73.95
M106 S229.5
G1 F1560
G1 X83.895 Y86.46 E.01438
M106 S73.95
M106 S229.5
G1 F1440
G1 X84.251 Y85.907 E.01229
M106 S73.95
M106 S229.5
G1 F1560
G1 X84.731 Y85.305 E.01437
M106 S73.95
M106 S229.5
G1 F1440
G1 X85.191 Y84.835 E.0123
M106 S73.95
M106 S229.5
G1 F1560
G1 X85.782 Y84.343 E.01437
M106 S73.95
M106 S229.5
G1 F1440
G1 X86.278 Y84.007 E.01119
M106 S73.95
; WIPE_START
M204 S6000
G1 X86.906 Y83.657 E-.10241
G1 X87.614 Y83.358 E-.10958
G1 X88.104 Y83.208 E-.07301
; WIPE_END
G1 E-.015 F1800
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
G1 X0 Y90.0001 ; move to safe pos
G1 X-13.0 F3000 ; move to safe pos
M400
M1004 S5 P1  ; external shutter
M400 P300
M971 S11 C11 O0
G92 E0
G1 X0 F18000
M623

; SKIPTYPE: head_wrap_detect
M622.1 S1
M1002 judge_flag g39_3rd_layer_detect_flag
M622 J1
    ; enable nozzle clog detect at 3rd layer
    


    M622.1 S1
    M1002 judge_flag g39_detection_flag
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




G1 X88.418 Y84.446
G1 Z2.6
G1 E.3 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.477936
G1 F2400
M204 S6000
G1 X88.844 Y84.338 E.00941
G1 X89.41 Y84.25 E.01228
G1 X89.883 Y84.221 E.01017
G1 X90.287 Y84.225 E.00864
G1 X90.887 Y84.285 E.01294
G1 X91.416 Y84.393 E.01155
G1 X92.017 Y84.581 E.0135
G1 X92.51 Y84.789 E.01146
G1 X93.005 Y85.06 E.01211
G1 X93.501 Y85.397 E.01284
G1 X93.925 Y85.753 E.01187
G1 X94.328 Y86.166 E.01235
G1 X94.698 Y86.626 E.01266
G1 X95.002 Y87.099 E.01204
G1 X95.276 Y87.632 E.01285
G1 X95.478 Y88.148 E.01187
G1 X95.64 Y88.724 E.01283
G1 X95.738 Y89.276 E.01201
G1 X95.78 Y89.844 E.01222
G1 X95.766 Y90.421 E.01236
G1 X95.697 Y90.993 E.01235
G1 X95.569 Y91.555 E.01236
G1 X95.384 Y92.112 E.01258
G1 X95.138 Y92.647 E.01261
G1 X94.85 Y93.146 E.01234
G1 X94.513 Y93.614 E.01236
G1 X94.13 Y94.044 E.01235
G1 X93.729 Y94.421 E.01179
G1 X93.248 Y94.784 E.01292
G1 X92.762 Y95.081 E.0122
G1 X92.235 Y95.332 E.01251
G1 X91.693 Y95.53 E.01236
G1 X91.163 Y95.665 E.01174
G1 X90.564 Y95.755 E.01297
G1 X90.011 Y95.781 E.01187
G1 X89.413 Y95.753 E.01283
G1 X88.876 Y95.673 E.01164
G1 X88.285 Y95.522 E.01307
G1 X87.755 Y95.33 E.01207
G1 X87.244 Y95.084 E.01216
G1 X86.733 Y94.772 E.01284
G1 X86.304 Y94.448 E.01152
G1 X85.985 Y94.156 E.00927
G1 X85.656 Y93.814 E.01017
G1 X85.3 Y93.365 E.01227
G1 X84.99 Y92.88 E.01234
G1 X84.726 Y92.367 E.01236
G1 X84.518 Y91.83 E.01235
G1 X84.362 Y91.276 E.01234
G1 X84.263 Y90.708 E.01235
G1 X84.222 Y90.133 E.01234
G1 X84.236 Y89.557 E.01235
G1 X84.311 Y88.986 E.01234
G1 X84.439 Y88.424 E.01235
G1 X84.623 Y87.878 E.01235
G1 X84.862 Y87.354 E.01235
G1 X85.15 Y86.854 E.01235
G1 X85.475 Y86.405 E.01188
G1 X85.854 Y85.972 E.01234
G1 X86.277 Y85.58 E.01235
G1 X86.734 Y85.23 E.01234
G1 X87.245 Y84.918 E.01283
G1 X87.745 Y84.679 E.01187
G1 X88.285 Y84.48 E.01235
G1 X88.36 Y84.461 E.00165
; CHANGE_LAYER
; Z_HEIGHT: 2.72
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F2400
G1 X88.844 Y84.338 E-.07108
G1 X89.41 Y84.25 E-.08166
G1 X89.883 Y84.221 E-.0676
G1 X90.287 Y84.225 E-.05748
G1 X90.337 Y84.23 E-.00718
; WIPE_END
G1 E-.015 F1800
; layer num/total_layer_count: 22/33
; update layer progress
M73 L22
M991 S0 P21 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z3 I-1.075 J.57 P1  F18000
G1 X94.718 Y92.504 Z3
G1 Z2.72
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F2950
M204 S6000
G1 X94.49 Y92.9 E.0092
G1 X94.178 Y93.332 E.01072
G1 X93.826 Y93.732 E.01071
G1 X93.435 Y94.094 E.01072
G1 X93.011 Y94.416 E.01071
G1 X92.556 Y94.694 E.01072
G1 X92.076 Y94.925 E.01072
G1 X91.575 Y95.107 E.01071
G1 X91.059 Y95.239 E.01071
G1 X90.532 Y95.318 E.01072
G1 X90 Y95.345 E.01071
G1 X89.468 Y95.318 E.01071
G1 X88.941 Y95.239 E.01072
G1 X88.425 Y95.107 E.01071
G1 X87.924 Y94.925 E.01072
G1 X87.444 Y94.694 E.01071
G1 X86.989 Y94.416 E.01071
G1 X86.57 Y94.098 E.01058
G1 X86.299 Y93.853 E.00734
G1 X85.991 Y93.535 E.00892
G1 X85.66 Y93.12 E.01066
G1 X85.371 Y92.673 E.01071
G1 X85.128 Y92.198 E.01072
G1 X84.933 Y91.702 E.01071
G1 X84.789 Y91.19 E.01071
G1 X84.697 Y90.665 E.01072
G1 X84.657 Y90.133 E.01071
G1 X84.67 Y89.601 E.01072
G1 X84.736 Y89.072 E.01071
G1 X84.855 Y88.552 E.01072
G1 X85.025 Y88.047 E.01071
G1 X85.244 Y87.561 E.01072
G1 X85.51 Y87.1 E.01071
G1 X85.821 Y86.667 E.01072
G1 X86.174 Y86.268 E.01071
G1 X86.564 Y85.906 E.01071
G1 X86.989 Y85.584 E.01072
G1 X87.444 Y85.306 E.01071
G1 X87.924 Y85.075 E.01072
G1 X88.425 Y84.893 E.01071
G1 X88.941 Y84.761 E.01071
G1 X89.465 Y84.682 E.01067
G1 X89.908 Y84.658 E.00891
G1 X90.273 Y84.663 E.00734
G1 X90.796 Y84.715 E.01058
G1 X91.319 Y84.82 E.01071
G1 X91.828 Y84.978 E.01072
G1 X92.319 Y85.185 E.01071
G1 X92.787 Y85.439 E.01072
G1 X93.227 Y85.739 E.01071
G1 X93.635 Y86.082 E.01072
G1 X94.007 Y86.463 E.01071
G1 X94.339 Y86.88 E.01071
G1 X94.628 Y87.328 E.01071
G1 X94.872 Y87.802 E.01072
G1 X95.066 Y88.298 E.01071
G1 X95.211 Y88.81 E.01071
G1 X95.303 Y89.335 E.01072
G1 X95.343 Y89.867 E.01071
G1 X95.33 Y90.399 E.01071
G1 X95.263 Y90.928 E.01071
G1 X95.145 Y91.448 E.01072
G1 X94.975 Y91.953 E.01071
G1 X94.756 Y92.439 E.01072
G1 X94.748 Y92.452 E.0003
M204 S10000
G1 X94.351 Y92.291 F18000
G1 F2950
M204 S6000
G1 X94.133 Y92.669 E.00877
G1 X93.846 Y93.068 E.00987
G1 X93.522 Y93.435 E.00986
G1 X93.162 Y93.769 E.00986
G1 X92.771 Y94.065 E.00986
G1 X92.353 Y94.321 E.00986
G1 X91.911 Y94.534 E.00986
G1 X91.45 Y94.701 E.00986
G1 X90.975 Y94.822 E.00986
G1 X90.49 Y94.896 E.00987
G1 X90 Y94.92 E.00986
G1 X89.51 Y94.896 E.00986
G1 X89.025 Y94.822 E.00987
G1 X88.55 Y94.701 E.00986
G1 X88.089 Y94.534 E.00986
G1 X87.647 Y94.321 E.00986
G1 X87.228 Y94.065 E.00986
G1 X86.84 Y93.771 E.00978
G1 X86.594 Y93.548 E.00668
G1 X86.31 Y93.254 E.00822
G1 X86.005 Y92.872 E.00983
G1 X85.739 Y92.46 E.00986
G1 X85.515 Y92.023 E.00987
G1 X85.336 Y91.567 E.00986
G1 X85.203 Y91.095 E.00986
G1 X85.118 Y90.612 E.00986
G1 X85.081 Y90.123 E.00986
G1 X85.094 Y89.632 E.00986
G1 X85.155 Y89.146 E.00986
G1 X85.264 Y88.667 E.00987
G1 X85.42 Y88.202 E.00986
G1 X85.622 Y87.755 E.00986
G1 X85.867 Y87.331 E.00986
G1 X86.153 Y86.932 E.00987
G1 X86.478 Y86.565 E.00986
M73 P81 R2
G1 X86.837 Y86.231 E.00986
G1 X87.228 Y85.935 E.00986
G1 X87.647 Y85.679 E.00986
G1 X88.089 Y85.466 E.00987
G1 X88.55 Y85.299 E.00986
G1 X89.025 Y85.178 E.00986
G1 X89.509 Y85.105 E.00984
G1 X89.917 Y85.082 E.00822
G1 X90.249 Y85.087 E.00668
G1 X90.733 Y85.135 E.00978
G1 X91.214 Y85.232 E.00986
G1 X91.683 Y85.377 E.00987
G1 X92.135 Y85.567 E.00986
G1 X92.565 Y85.802 E.00987
G1 X92.97 Y86.078 E.00986
G1 X93.346 Y86.393 E.00986
G1 X93.689 Y86.744 E.00986
G1 X93.995 Y87.128 E.00986
G1 X94.261 Y87.54 E.00986
G1 X94.485 Y87.977 E.00987
G1 X94.664 Y88.433 E.00986
G1 X94.796 Y88.905 E.00986
G1 X94.882 Y89.388 E.00986
G1 X94.918 Y89.877 E.00986
G1 X94.906 Y90.368 E.00986
G1 X94.845 Y90.854 E.00986
G1 X94.736 Y91.333 E.00987
G1 X94.58 Y91.798 E.00986
G1 X94.38 Y92.239 E.00974
M204 S250
G1 X93.997 Y92.087 F18000
M106 S229.5
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1800
M204 S5000
G1 X93.789 Y92.447 E.00777
G1 X93.526 Y92.812 E.0084
G1 X93.229 Y93.149 E.0084
G1 X92.899 Y93.455 E.0084
G1 X92.541 Y93.727 E.0084
G1 X92.157 Y93.961 E.0084
G1 X91.752 Y94.156 E.0084
G1 X91.329 Y94.31 E.0084
G1 X90.894 Y94.421 E.0084
G1 X90.449 Y94.488 E.00841
G1 X90 Y94.51 E.0084
G1 X89.551 Y94.488 E.0084
G1 X89.106 Y94.421 E.0084
G1 X88.67 Y94.31 E.0084
G1 X88.248 Y94.156 E.0084
G1 X87.843 Y93.961 E.0084
G1 X87.459 Y93.727 E.0084
G1 X87.102 Y93.456 E.00838
G1 X86.618 Y92.984 E.01263
G1 X86.338 Y92.633 E.00839
G1 X86.094 Y92.255 E.0084
G1 X85.889 Y91.855 E.0084
G1 X85.724 Y91.436 E.0084
G1 X85.603 Y91.004 E.0084
G1 X85.525 Y90.561 E.0084
G1 X85.491 Y90.112 E.0084
G1 X85.502 Y89.663 E.0084
G1 X85.558 Y89.217 E.0084
G1 X85.658 Y88.778 E.00841
G1 X85.801 Y88.352 E.0084
G1 X85.986 Y87.942 E.0084
G1 X86.211 Y87.553 E.0084
G1 X86.474 Y87.188 E.0084
G1 X86.771 Y86.851 E.0084
G1 X87.101 Y86.545 E.0084
G1 X87.459 Y86.273 E.0084
G1 X87.843 Y86.039 E.0084
G1 X88.248 Y85.844 E.0084
G1 X88.67 Y85.69 E.0084
G1 X89.106 Y85.579 E.0084
G1 X89.55 Y85.512 E.0084
G1 X90.226 Y85.495 E.01263
G1 X90.672 Y85.54 E.00838
G1 X91.113 Y85.629 E.0084
G1 X91.542 Y85.762 E.0084
G1 X91.957 Y85.936 E.0084
G1 X92.352 Y86.152 E.0084
G1 X92.723 Y86.405 E.0084
G1 X93.068 Y86.694 E.0084
G1 X93.381 Y87.016 E.0084
G1 X93.662 Y87.367 E.0084
G1 X93.906 Y87.745 E.0084
G1 X94.111 Y88.145 E.0084
G1 X94.275 Y88.564 E.0084
G1 X94.397 Y88.996 E.0084
G1 X94.475 Y89.439 E.0084
G1 X94.509 Y89.888 E.0084
G1 X94.497 Y90.337 E.0084
G1 X94.442 Y90.783 E.0084
G1 X94.342 Y91.222 E.0084
G1 X94.198 Y91.648 E.0084
G1 X94.024 Y92.034 E.00791
; WIPE_START
M204 S6000
G1 X93.789 Y92.447 E-.06781
G1 X93.526 Y92.812 E-.06409
G1 X93.229 Y93.149 E-.06404
G1 X92.899 Y93.455 E-.06408
G1 X92.759 Y93.561 E-.02497
; WIPE_END
G1 E-.015
M204 S10000
G1 X88.488 Y87.236 Z3.12 F18000
G1 X86.672 Y84.548 Z3.12
G1 Z2.72
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F2950
M204 S6000
G1 X87.215 Y84.251 E.01245
G1 X87.826 Y83.993 E.01333
G1 X88.417 Y83.812 E.01242
G1 X89.067 Y83.681 E.01334
G1 X89.683 Y83.62 E.01245
G1 X90.303 Y83.62 E.01245
G1 X90.962 Y83.685 E.01333
G1 X91.568 Y83.808 E.01242
G1 X92.201 Y84.004 E.01333
G1 X92.772 Y84.245 E.01246
G1 X93.316 Y84.541 E.01245
G1 X93.864 Y84.914 E.01334
G1 X94.337 Y85.311 E.01242
G1 X94.8 Y85.786 E.01334
G1 X95.186 Y86.27 E.01245
G1 X95.522 Y86.79 E.01245
G1 X95.825 Y87.38 E.01333
G1 X96.051 Y87.955 E.01243
G1 X96.231 Y88.593 E.01334
G1 X96.338 Y89.204 E.01246
G1 X96.385 Y89.822 E.01248
G1 X96.372 Y90.442 E.01247
G1 X96.292 Y91.099 E.01331
G1 X96.145 Y91.744 E.0133
G1 X95.947 Y92.331 E.01246
G1 X95.71 Y92.859 E.01163
G1 X95.383 Y93.438 E.01338
G1 X94.999 Y93.976 E.01328
G1 X94.592 Y94.44 E.01242
G1 X94.108 Y94.891 E.0133
G1 X93.58 Y95.29 E.0133
G1 X93.051 Y95.612 E.01246
G1 X92.493 Y95.881 E.01245
G1 X91.87 Y96.108 E.01332
G1 X91.272 Y96.26 E.01241
G1 X90.619 Y96.357 E.01328
G1 X89.966 Y96.387 E.01315
G1 X89.355 Y96.355 E.01231
G1 X88.743 Y96.263 E.01244
G1 X88.101 Y96.099 E.01332
G1 X87.52 Y95.887 E.01244
G1 X86.961 Y95.619 E.01245
G1 X86.395 Y95.273 E.01334
G1 X85.902 Y94.9 E.01242
G1 X85.417 Y94.449 E.01333
G1 X85.007 Y93.984 E.01246
G1 X84.645 Y93.482 E.01246
G1 X84.312 Y92.907 E.01334
G1 X84.058 Y92.344 E.01243
G1 X83.847 Y91.716 E.01333
G1 X83.709 Y91.111 E.01246
G1 X83.632 Y90.497 E.01246
G1 X83.614 Y89.833 E.01334
G1 X83.66 Y89.218 E.01242
G1 X83.776 Y88.564 E.01334
G1 X83.944 Y87.968 E.01246
G1 X84.169 Y87.391 E.01245
G1 X84.471 Y86.801 E.01334
G1 X84.806 Y86.282 E.01242
G1 X85.219 Y85.763 E.01333
G1 X85.651 Y85.321 E.01242
G1 X86.159 Y84.896 E.01333
G1 X86.622 Y84.581 E.01126
M204 S10000
G1 X86.451 Y84.185 F18000
G1 F2950
M204 S6000
G1 X87.031 Y83.869 E.01329
G1 X87.681 Y83.594 E.01419
G1 X88.312 Y83.4 E.01328
G1 X89.004 Y83.261 E.01419
G1 X89.662 Y83.196 E.0133
G1 X90.323 Y83.195 E.0133
G1 X91.025 Y83.265 E.01418
G1 X91.673 Y83.396 E.01328
G1 X92.347 Y83.605 E.01418
G1 X92.956 Y83.862 E.0133
G1 X93.537 Y84.178 E.0133
G1 X94.12 Y84.575 E.01419
G1 X94.626 Y84.999 E.01327
G1 X95.119 Y85.505 E.01419
G1 X95.53 Y86.022 E.01329
G1 X95.89 Y86.577 E.0133
G1 X96.212 Y87.205 E.01419
G1 X96.454 Y87.82 E.01328
G1 X96.645 Y88.499 E.01419
G1 X96.759 Y89.151 E.0133
G1 X96.81 Y89.811 E.01331
G1 X96.795 Y90.472 E.01331
G1 X96.711 Y91.172 E.01417
G1 X96.554 Y91.859 E.01418
G1 X96.342 Y92.486 E.0133
G1 X96.089 Y93.05 E.01243
G1 X95.741 Y93.666 E.01422
G1 X95.332 Y94.239 E.01416
G1 X94.896 Y94.736 E.01328
G1 X94.381 Y95.217 E.01417
G1 X93.819 Y95.641 E.01417
G1 X93.254 Y95.985 E.0133
G1 X92.658 Y96.272 E.01329
G1 X91.996 Y96.514 E.01418
G1 X91.356 Y96.676 E.01327
G1 X90.66 Y96.78 E.01414
G1 X89.965 Y96.812 E.01401
G1 X89.312 Y96.778 E.01315
G1 X88.658 Y96.679 E.01329
G1 X87.975 Y96.505 E.01418
G1 X87.355 Y96.278 E.01328
G1 X86.759 Y95.992 E.0133
G1 X86.156 Y95.624 E.01419
G1 X85.629 Y95.226 E.01328
G1 X85.112 Y94.746 E.01419
G1 X84.675 Y94.249 E.0133
G1 X84.288 Y93.713 E.0133
G1 X83.934 Y93.101 E.0142
G1 X83.662 Y92.499 E.01328
G1 X83.438 Y91.83 E.01419
G1 X83.291 Y91.185 E.01331
G1 X83.208 Y90.529 E.0133
G1 X83.19 Y89.823 E.0142
G1 X83.239 Y89.165 E.01327
G1 X83.362 Y88.47 E.0142
G1 X83.541 Y87.833 E.0133
G1 X83.782 Y87.217 E.01329
G1 X84.103 Y86.589 E.01419
G1 X84.461 Y86.034 E.01328
G1 X84.901 Y85.482 E.01419
G1 X85.362 Y85.01 E.01328
G1 X85.903 Y84.557 E.01419
G1 X86.401 Y84.219 E.0121
M204 S250
G1 X86.237 Y83.835 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1440
M204 S5000
G1 X86.853 Y83.499 E.01311
G1 X87.541 Y83.209 E.01395
G1 X88.211 Y83.003 E.01311
G1 X88.943 Y82.856 E.01396
G1 X89.642 Y82.787 E.01311
G1 X90.344 Y82.786 E.01312
G1 X91.086 Y82.86 E.01395
M106 S73.95
M106 S229.5
G1 X91.774 Y82.999 E.01311
G1 X92.487 Y83.22 E.01395
G1 X93.134 Y83.493 E.01311
G1 X93.75 Y83.828 E.01311
G1 X94.368 Y84.248 E.01395
G1 X94.905 Y84.699 E.0131
G1 X95.426 Y85.234 E.01396
G1 X95.863 Y85.783 E.01311
G1 X96.244 Y86.372 E.01311
G1 X96.586 Y87.036 E.01395
G1 X96.842 Y87.689 E.01311
G1 X97.044 Y88.408 E.01396
G1 X97.166 Y89.1 E.01312
G1 X97.219 Y89.8 E.01312
G1 X97.204 Y90.501 E.01312
G1 X97.114 Y91.242 E.01395
G1 X96.948 Y91.971 E.01395
G1 X96.724 Y92.636 E.01312
G1 X96.455 Y93.235 E.01228
M106 S73.95
M106 S229.5
G1 F1560
G1 X96.087 Y93.886 E.01397
G1 X95.654 Y94.494 E.01395
M106 S73.95
M106 S229.5
G1 F1440
G1 X95.191 Y95.021 E.01311
G1 X94.645 Y95.53 E.01395
M106 S73.95
M106 S229.5
G1 F1560
G1 X94.049 Y95.98 E.01394
M106 S73.95
M106 S229.5
G1 F1440
G1 X93.449 Y96.345 E.01312
G1 X92.817 Y96.65 E.01311
G1 X92.116 Y96.905 E.01394
G1 X91.437 Y97.078 E.0131
G1 X90.7 Y97.188 E.01392
G1 X89.963 Y97.222 E.01378
G1 X89.27 Y97.185 E.01297
G1 X88.577 Y97.081 E.0131
G1 X87.854 Y96.896 E.01394
G1 X87.196 Y96.656 E.0131
G1 X86.563 Y96.352 E.01311
G1 X85.925 Y95.963 E.01396
G1 X85.366 Y95.54 E.01311
G1 X84.819 Y95.031 E.01395
G1 X84.355 Y94.505 E.01312
G1 X83.944 Y93.935 E.01312
G1 X83.57 Y93.289 E.01396
G1 X83.281 Y92.649 E.01311
G1 X83.043 Y91.941 E.01395
G1 X82.888 Y91.256 E.01312
G1 X82.799 Y90.56 E.01312
G1 X82.78 Y89.813 E.01396
G1 X82.832 Y89.114 E.01311
G1 X82.962 Y88.378 E.01396
G1 X83.153 Y87.703 E.01312
G1 X83.408 Y87.049 E.01311
M106 S73.95
M106 S229.5
G1 F1560
G1 X83.748 Y86.384 E.01395
M106 S73.95
M106 S229.5
G1 F1440
G1 X84.128 Y85.795 E.01311
G1 X84.594 Y85.211 E.01395
G1 X85.084 Y84.709 E.01311
M106 S73.95
M106 S229.5
G1 F1560
G1 X85.656 Y84.23 E.01395
M106 S73.95
M106 S229.5
G1 F1440
G1 X86.187 Y83.869 E.012
M106 S73.95
; WIPE_START
M204 S6000
G1 X86.853 Y83.499 E-.10849
G1 X87.541 Y83.209 E-.10639
G1 X88.011 Y83.064 E-.07011
; WIPE_END
G1 E-.015 F1800
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
G1 X0 Y90.0001 ; move to safe pos
G1 X-13.0 F3000 ; move to safe pos
M400
M1004 S5 P1  ; external shutter
M400 P300
M971 S11 C11 O0
G92 E0
G1 X0 F18000
M623

; SKIPTYPE: head_wrap_detect
M622.1 S1
M1002 judge_flag g39_3rd_layer_detect_flag
M622 J1
    ; enable nozzle clog detect at 3rd layer
    


    M622.1 S1
    M1002 judge_flag g39_detection_flag
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




G1 X88.348 Y84.379
G1 Z2.72
G1 E.3 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.643007
G1 F2400
M204 S6000
G1 X88.823 Y84.257 E.01434
G1 X89.398 Y84.169 E.01702
G1 X89.886 Y84.139 E.01432
G1 X90.289 Y84.142 E.01176
G1 X90.885 Y84.201 E.01753
G1 X91.439 Y84.313 E.01654
G1 X92.022 Y84.494 E.01786
G1 X92.545 Y84.715 E.01661
G1 X93.045 Y84.987 E.01666
G1 X93.549 Y85.33 E.01783
G1 X93.982 Y85.693 E.01653
G1 X94.409 Y86.131 E.01788
G1 X94.762 Y86.575 E.0166
G1 X95.071 Y87.052 E.01662
G1 X95.35 Y87.594 E.01786
G1 X95.557 Y88.121 E.01655
G1 X95.722 Y88.709 E.01787
G1 X95.82 Y89.268 E.01661
G1 X95.863 Y89.837 E.01667
G1 X95.851 Y90.405 E.01664
G1 X95.778 Y91.01 E.01781
G1 X95.643 Y91.603 E.0178
G1 X95.461 Y92.141 E.01663
G1 X95.225 Y92.662 E.01673
G1 X94.943 Y93.157 E.01669
G1 X94.59 Y93.652 E.01776
G1 X94.217 Y94.077 E.01655
G1 X93.772 Y94.492 E.01779
G1 X93.291 Y94.855 E.01763
G1 X92.802 Y95.154 E.01678
G1 X92.29 Y95.4 E.01661
G1 X91.717 Y95.609 E.01786
G1 X91.169 Y95.748 E.01653
G1 X90.569 Y95.838 E.01776
G1 X90.015 Y95.865 E.01621
G1 X89.407 Y95.836 E.0178
G1 X88.846 Y95.751 E.0166
G1 X88.256 Y95.601 E.01781
G1 X87.722 Y95.406 E.01663
G1 X87.208 Y95.159 E.01669
G1 X86.688 Y94.842 E.0178
G1 X86.238 Y94.501 E.01654
G1 X85.931 Y94.219 E.01219
G1 X85.592 Y93.865 E.01432
G1 X85.231 Y93.41 E.01701
G1 X84.916 Y92.918 E.01709
G1 X84.65 Y92.397 E.01712
G1 X84.438 Y91.853 E.01708
G1 X84.281 Y91.29 E.01709
G1 X84.181 Y90.714 E.01711
G1 X84.139 Y90.131 E.01709
G1 X84.155 Y89.547 E.0171
G1 X84.23 Y88.967 E.01709
G1 X84.361 Y88.397 E.01711
G1 X84.548 Y87.844 E.01709
G1 X84.791 Y87.312 E.0171
G1 X85.084 Y86.807 E.01709
G1 X85.426 Y86.333 E.0171
G1 X85.792 Y85.918 E.0162
G1 X86.22 Y85.519 E.0171
G1 X86.685 Y85.165 E.0171
G1 X87.183 Y84.859 E.0171
G1 X87.709 Y84.604 E.01711
G1 X88.257 Y84.402 E.01709
G1 X88.29 Y84.394 E.00099
; CHANGE_LAYER
; Z_HEIGHT: 2.84
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F2400
G1 X88.823 Y84.257 E-.07841
G1 X89.398 Y84.169 E-.0829
G1 X89.886 Y84.139 E-.06973
M73 P82 R2
G1 X90.265 Y84.142 E-.05397
; WIPE_END
G1 E-.015 F1800
; layer num/total_layer_count: 23/33
; update layer progress
M73 L23
M991 S0 P22 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z3.12 I-1.074 J.572 P1  F18000
G1 X94.717 Y92.506 Z3.12
G1 Z2.84
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F3548
M204 S6000
G1 X94.483 Y92.911 E.00941
G1 X94.016 Y93.527 E.01554
G1 X93.635 Y93.918 E.01098
G1 X93.227 Y94.261 E.01072
G1 X92.787 Y94.561 E.01071
G1 X92.319 Y94.815 E.01071
G1 X91.828 Y95.022 E.01072
G1 X91.319 Y95.18 E.01072
G1 X90.796 Y95.285 E.01071
G1 X90.266 Y95.338 E.01071
G1 X89.733 Y95.338 E.01071
G1 X89.203 Y95.285 E.01071
G1 X88.681 Y95.18 E.01071
G1 X88.172 Y95.022 E.01072
G1 X87.681 Y94.815 E.01071
G1 X87.213 Y94.561 E.01071
G1 X86.773 Y94.261 E.01071
G1 X86.364 Y93.918 E.01072
G1 X85.992 Y93.537 E.01071
G1 X85.66 Y93.12 E.01072
G1 X85.371 Y92.673 E.01071
G1 X85.128 Y92.198 E.01072
G1 X84.933 Y91.702 E.01071
G1 X84.789 Y91.19 E.01071
G1 X84.697 Y90.665 E.01072
G1 X84.657 Y90.133 E.01071
G1 X84.67 Y89.601 E.01072
G1 X84.736 Y89.072 E.01071
G1 X84.855 Y88.552 E.01072
G1 X85.024 Y88.047 E.01071
G1 X85.244 Y87.561 E.01072
G1 X85.517 Y87.089 E.01097
G1 X85.983 Y86.473 E.01554
G1 X86.364 Y86.082 E.01098
G1 X86.773 Y85.739 E.01072
G1 X87.213 Y85.439 E.01071
G1 X87.681 Y85.184 E.01072
G1 X88.172 Y84.978 E.01071
G1 X88.681 Y84.821 E.01072
G1 X89.203 Y84.715 E.01071
G1 X89.733 Y84.662 E.01071
G1 X90.266 Y84.662 E.01071
G1 X90.796 Y84.715 E.01071
G1 X91.319 Y84.82 E.01071
G1 X91.828 Y84.978 E.01072
G1 X92.319 Y85.185 E.01071
G1 X92.787 Y85.439 E.01071
G1 X93.227 Y85.74 E.01072
G1 X93.635 Y86.082 E.01071
G1 X94.007 Y86.463 E.01071
G1 X94.34 Y86.88 E.01072
G1 X94.628 Y87.328 E.01071
G1 X94.872 Y87.802 E.01072
G1 X95.066 Y88.298 E.01072
G1 X95.211 Y88.81 E.0107
G1 X95.303 Y89.335 E.01072
G1 X95.343 Y89.867 E.01071
G1 X95.33 Y90.399 E.01072
G1 X95.263 Y90.928 E.01071
G1 X95.145 Y91.448 E.01072
G1 X94.975 Y91.953 E.01072
G1 X94.756 Y92.438 E.01071
G1 X94.747 Y92.454 E.00036
M204 S10000
G1 X94.35 Y92.294 F18000
G1 F3548
M204 S6000
G1 X94.129 Y92.676 E.00888
G1 X93.694 Y93.25 E.01447
G1 X93.346 Y93.607 E.01002
G1 X92.97 Y93.922 E.00986
G1 X92.565 Y94.198 E.00986
G1 X92.135 Y94.433 E.00986
G1 X91.683 Y94.623 E.00986
G1 X91.214 Y94.768 E.00987
G1 X90.733 Y94.865 E.00986
G1 X90.245 Y94.914 E.00986
G1 X89.755 Y94.914 E.00986
G1 X89.267 Y94.865 E.00986
G1 X88.786 Y94.768 E.00986
G1 X88.317 Y94.623 E.00987
G1 X87.865 Y94.433 E.00986
G1 X87.434 Y94.198 E.00986
G1 X87.029 Y93.922 E.00986
G1 X86.653 Y93.607 E.00986
G1 X86.311 Y93.256 E.00986
G1 X86.005 Y92.872 E.00986
G1 X85.739 Y92.46 E.00986
G1 X85.515 Y92.023 E.00987
G1 X85.336 Y91.567 E.00986
G1 X85.203 Y91.095 E.00986
G1 X85.118 Y90.612 E.00987
G1 X85.081 Y90.123 E.00986
G1 X85.094 Y89.632 E.00986
G1 X85.155 Y89.146 E.00986
G1 X85.264 Y88.667 E.00987
G1 X85.42 Y88.203 E.00986
G1 X85.622 Y87.755 E.00987
G1 X85.871 Y87.324 E.01001
G1 X86.305 Y86.75 E.01448
G1 X86.653 Y86.393 E.01002
G1 X87.029 Y86.078 E.00987
G1 X87.434 Y85.802 E.00986
G1 X87.865 Y85.567 E.00987
G1 X88.317 Y85.377 E.00986
G1 X88.786 Y85.232 E.00986
G1 X89.267 Y85.135 E.00986
G1 X89.755 Y85.086 E.00986
G1 X90.245 Y85.086 E.00986
G1 X90.733 Y85.135 E.00986
G1 X91.214 Y85.232 E.00986
G1 X91.683 Y85.377 E.00987
G1 X92.135 Y85.567 E.00986
G1 X92.565 Y85.802 E.00986
G1 X92.971 Y86.078 E.00987
G1 X93.346 Y86.393 E.00986
G1 X93.689 Y86.744 E.00986
G1 X93.995 Y87.128 E.00987
G1 X94.261 Y87.54 E.00986
G1 X94.484 Y87.977 E.00987
G1 X94.664 Y88.433 E.00987
G1 X94.796 Y88.905 E.00985
G1 X94.882 Y89.388 E.00986
G1 X94.918 Y89.877 E.00986
G1 X94.906 Y90.368 E.00986
G1 X94.845 Y90.854 E.00986
G1 X94.736 Y91.333 E.00986
G1 X94.58 Y91.798 E.00987
G1 X94.379 Y92.241 E.00979
M204 S250
G1 X93.995 Y92.089 F18000
M106 S229.5
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1800
M204 S5000
G1 X93.787 Y92.449 E.00778
G1 X93.383 Y92.982 E.0125
G1 X93.068 Y93.306 E.00845
G1 X92.723 Y93.595 E.0084
G1 X92.352 Y93.848 E.0084
G1 X91.957 Y94.064 E.0084
G1 X91.543 Y94.238 E.0084
G1 X91.113 Y94.371 E.0084
G1 X90.672 Y94.46 E.0084
G1 X90.225 Y94.505 E.0084
G1 X89.775 Y94.505 E.0084
G1 X89.328 Y94.46 E.0084
G1 X88.887 Y94.371 E.0084
G1 X88.457 Y94.238 E.00841
G1 X88.043 Y94.064 E.0084
G1 X87.648 Y93.849 E.0084
G1 X87.277 Y93.595 E.0084
G1 X86.932 Y93.306 E.0084
G1 X86.618 Y92.984 E.0084
G1 X86.338 Y92.633 E.0084
G1 X86.094 Y92.255 E.0084
G1 X85.889 Y91.855 E.0084
G1 X85.724 Y91.437 E.0084
G1 X85.603 Y91.004 E.0084
G1 X85.525 Y90.561 E.0084
G1 X85.491 Y90.112 E.0084
G1 X85.502 Y89.663 E.0084
G1 X85.558 Y89.217 E.0084
G1 X85.658 Y88.778 E.00841
G1 X85.801 Y88.352 E.0084
G1 X85.986 Y87.942 E.0084
G1 X86.212 Y87.551 E.00845
G1 X86.616 Y87.018 E.0125
G1 X86.932 Y86.694 E.00845
G1 X87.277 Y86.405 E.0084
G1 X87.648 Y86.152 E.0084
G1 X88.043 Y85.936 E.00841
G1 X88.457 Y85.762 E.0084
G1 X88.887 Y85.629 E.0084
G1 X89.328 Y85.54 E.0084
G1 X89.775 Y85.495 E.0084
G1 X90.225 Y85.495 E.0084
G1 X90.672 Y85.54 E.0084
G1 X91.113 Y85.629 E.0084
G1 X91.543 Y85.762 E.00841
G1 X91.957 Y85.936 E.0084
G1 X92.352 Y86.151 E.0084
G1 X92.723 Y86.405 E.0084
G1 X93.068 Y86.694 E.0084
G1 X93.381 Y87.016 E.0084
G1 X93.662 Y87.367 E.00841
G1 X93.906 Y87.745 E.0084
G1 X94.111 Y88.145 E.0084
G1 X94.275 Y88.564 E.0084
G1 X94.397 Y88.996 E.0084
G1 X94.475 Y89.439 E.0084
G1 X94.509 Y89.888 E.0084
G1 X94.497 Y90.337 E.0084
G1 X94.442 Y90.783 E.0084
G1 X94.342 Y91.222 E.0084
G1 X94.198 Y91.648 E.00841
G1 X94.023 Y92.036 E.00795
; WIPE_START
M204 S6000
G1 X93.787 Y92.449 E-.06784
G1 X93.383 Y92.982 E-.09529
G1 X93.068 Y93.306 E-.06446
G1 X92.759 Y93.565 E-.05741
; WIPE_END
G1 E-.015
M204 S10000
G1 X88.491 Y87.237 Z3.24 F18000
G1 X86.583 Y84.409 Z3.24
G1 Z2.84
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F3548
M204 S6000
G1 X87.157 Y84.096 E.01313
G1 X87.759 Y83.843 E.01313
G1 X88.383 Y83.65 E.01314
G1 X89.023 Y83.52 E.01313
G1 X89.673 Y83.455 E.01314
G1 X90.326 Y83.455 E.01313
G1 X90.92 Y83.515 E.012
G1 X91.62 Y83.651 E.01434
G1 X92.241 Y83.842 E.01306
G1 X92.843 Y84.096 E.01314
G1 X93.417 Y84.409 E.01313
G1 X93.956 Y84.777 E.01313
G1 X94.457 Y85.197 E.01314
G1 X94.913 Y85.664 E.01313
G1 X95.32 Y86.175 E.01314
G1 X95.675 Y86.724 E.01314
G1 X95.973 Y87.305 E.01313
G1 X96.211 Y87.913 E.01313
G1 X96.388 Y88.542 E.01314
G1 X96.502 Y89.185 E.01313
G1 X96.551 Y89.837 E.01314
G1 X96.534 Y90.49 E.01313
G1 X96.453 Y91.138 E.01314
G1 X96.308 Y91.775 E.01313
G1 X96.1 Y92.394 E.01313
G1 X95.831 Y92.989 E.01314
G1 X95.504 Y93.555 E.01314
G1 X95.123 Y94.086 E.01313
G1 X94.691 Y94.575 E.01314
G1 X94.212 Y95.02 E.01313
G1 X93.691 Y95.414 E.01314
G1 X93.134 Y95.755 E.01313
G1 X92.545 Y96.038 E.01313
G1 X91.931 Y96.262 E.01314
G1 X91.298 Y96.423 E.01314
G1 X90.652 Y96.52 E.01314
G1 X90 Y96.553 E.01313
G1 X89.348 Y96.52 E.01313
G1 X88.701 Y96.423 E.01314
G1 X88.068 Y96.262 E.01314
G1 X87.455 Y96.038 E.01313
G1 X86.866 Y95.755 E.01314
G1 X86.309 Y95.414 E.01313
G1 X85.788 Y95.02 E.01314
G1 X85.309 Y94.575 E.01313
G1 X84.877 Y94.086 E.01314
G1 X84.495 Y93.555 E.01314
G1 X84.169 Y92.989 E.01314
G1 X83.9 Y92.394 E.01314
G1 X83.692 Y91.775 E.01313
G1 X83.547 Y91.138 E.01313
G1 X83.465 Y90.49 E.01314
G1 X83.449 Y89.837 E.01313
G1 X83.498 Y89.185 E.01314
G1 X83.611 Y88.542 E.01313
G1 X83.788 Y87.913 E.01314
G1 X84.027 Y87.305 E.01313
G1 X84.325 Y86.724 E.01314
G1 X84.679 Y86.175 E.01313
G1 X85.087 Y85.664 E.01313
G1 X85.543 Y85.197 E.01314
G1 X86.043 Y84.777 E.01314
G1 X86.534 Y84.442 E.01193
M204 S10000
G1 X86.362 Y84.046 F18000
G1 F3548
M204 S6000
G1 X86.972 Y83.714 E.01398
G1 X87.613 Y83.443 E.01399
G1 X88.278 Y83.238 E.01399
G1 X88.96 Y83.1 E.01399
G1 X89.652 Y83.031 E.01399
G1 X90.348 Y83.031 E.01399
G1 X90.982 Y83.095 E.01282
G1 X91.724 Y83.239 E.01519
G1 X92.386 Y83.443 E.01394
G1 X93.027 Y83.714 E.01399
G1 X93.638 Y84.046 E.01399
G1 X94.213 Y84.438 E.01398
G1 X94.746 Y84.885 E.01399
G1 X95.231 Y85.383 E.01399
G1 X95.665 Y85.927 E.01399
G1 X96.043 Y86.511 E.01399
G1 X96.36 Y87.13 E.01398
G1 X96.614 Y87.778 E.01398
G1 X96.802 Y88.447 E.01399
G1 X96.923 Y89.132 E.01399
G1 X96.975 Y89.826 E.01399
G1 X96.958 Y90.521 E.01398
G1 X96.871 Y91.212 E.01399
G1 X96.717 Y91.89 E.01398
G1 X96.495 Y92.549 E.01399
G1 X96.209 Y93.183 E.01399
G1 X95.861 Y93.786 E.01399
G1 X95.455 Y94.35 E.01399
G1 X94.995 Y94.872 E.01399
G1 X94.485 Y95.345 E.01399
G1 X93.93 Y95.765 E.01399
G1 X93.337 Y96.128 E.01399
G1 X92.71 Y96.43 E.01398
G1 X92.056 Y96.668 E.01399
G1 X91.382 Y96.839 E.01398
G1 X90.694 Y96.943 E.01399
G1 X90 Y96.978 E.01399
G1 X89.305 Y96.943 E.01399
G1 X88.617 Y96.839 E.01399
G1 X87.943 Y96.668 E.01399
G1 X87.29 Y96.43 E.01399
G1 X86.663 Y96.128 E.01399
G1 X86.069 Y95.765 E.01399
G1 X85.515 Y95.345 E.01399
G1 X85.005 Y94.872 E.01399
G1 X84.545 Y94.35 E.01399
G1 X84.139 Y93.786 E.01399
G1 X83.791 Y93.183 E.01399
G1 X83.505 Y92.549 E.01399
G1 X83.283 Y91.89 E.01399
G1 X83.128 Y91.212 E.01399
G1 X83.042 Y90.521 E.01399
G1 X83.024 Y89.826 E.01398
G1 X83.076 Y89.132 E.01399
G1 X83.197 Y88.447 E.01399
G1 X83.386 Y87.778 E.01399
G1 X83.64 Y87.13 E.01398
G1 X83.957 Y86.511 E.01399
G1 X84.334 Y85.927 E.01398
G1 X84.768 Y85.383 E.01399
G1 X85.254 Y84.885 E.01399
G1 X85.787 Y84.438 E.01399
G1 X86.312 Y84.08 E.01278
M204 S250
G1 X86.148 Y83.696 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1440
M204 S5000
G1 X86.795 Y83.344 E.01376
G1 X87.473 Y83.058 E.01376
G1 X88.177 Y82.841 E.01376
G1 X88.899 Y82.695 E.01376
G1 X89.632 Y82.622 E.01376
G1 X90.368 Y82.622 E.01376
G1 X91.042 Y82.689 E.01265
G1 X91.823 Y82.841 E.01488
G1 X92.526 Y83.058 E.01375
G1 X93.205 Y83.344 E.01376
G1 X93.852 Y83.697 E.01376
G1 X94.46 Y84.111 E.01376
G1 X95.024 Y84.585 E.01376
G1 X95.539 Y85.112 E.01376
G1 X95.998 Y85.688 E.01376
G1 X96.397 Y86.306 E.01376
G1 X96.733 Y86.962 E.01376
G1 X97.002 Y87.647 E.01376
G1 X97.202 Y88.356 E.01376
G1 X97.33 Y89.081 E.01376
G1 X97.385 Y89.816 E.01376
G1 X97.366 Y90.552 E.01376
G1 X97.275 Y91.283 E.01376
G1 X97.111 Y92.001 E.01376
G1 X96.876 Y92.699 E.01376
G1 X96.574 Y93.37 E.01376
G1 X96.205 Y94.008 E.01376
G1 X95.775 Y94.606 E.01376
G1 X95.288 Y95.158 E.01376
G1 X94.748 Y95.659 E.01376
G1 X94.161 Y96.104 E.01376
G1 X93.533 Y96.488 E.01376
G1 X92.869 Y96.807 E.01376
G1 X92.177 Y97.059 E.01376
G1 X91.464 Y97.241 E.01376
G1 X90.735 Y97.351 E.01376
G1 X90 Y97.387 E.01376
G1 X89.264 Y97.351 E.01376
G1 X88.536 Y97.241 E.01376
G1 X87.822 Y97.059 E.01376
G1 X87.13 Y96.807 E.01376
G1 X86.467 Y96.488 E.01376
G1 X85.838 Y96.104 E.01376
G1 X85.251 Y95.659 E.01376
G1 X84.712 Y95.158 E.01376
G1 X84.224 Y94.606 E.01376
G1 X83.794 Y94.008 E.01376
G1 X83.426 Y93.37 E.01376
G1 X83.123 Y92.699 E.01376
G1 X82.889 Y92.001 E.01376
G1 X82.725 Y91.283 E.01376
G1 X82.633 Y90.552 E.01376
G1 X82.615 Y89.816 E.01376
G1 X82.67 Y89.081 E.01376
G1 X82.798 Y88.356 E.01376
G1 X82.997 Y87.647 E.01376
G1 X83.266 Y86.962 E.01376
G1 X83.602 Y86.306 E.01376
G1 X84.002 Y85.688 E.01376
G1 X84.461 Y85.112 E.01376
G1 X84.975 Y84.585 E.01376
G1 X85.539 Y84.111 E.01376
G1 X86.098 Y83.73 E.01264
M106 S73.95
; WIPE_START
M204 S6000
G1 X86.795 Y83.344 E-.11343
G1 X87.473 Y83.058 E-.10495
G1 X87.92 Y82.92 E-.06662
; WIPE_END
G1 E-.015 F1800
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
G1 X0 Y90.0001 ; move to safe pos
G1 X-13.0 F3000 ; move to safe pos
M400
M1004 S5 P1  ; external shutter
M400 P300
M971 S11 C11 O0
G92 E0
G1 X0 F18000
M623

; SKIPTYPE: head_wrap_detect
M622.1 S1
M1002 judge_flag g39_3rd_layer_detect_flag
M622 J1
    ; enable nozzle clog detect at 3rd layer
    


    M622.1 S1
    M1002 judge_flag g39_detection_flag
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




G1 X90.942 Y83.933
G1 Z2.84
G1 E.3 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.418757
G1 F3548
M204 S6000
G1 X90.335 Y83.866 E.01138
G1 X89.723 Y83.863 E.0114
G1 X89.113 Y83.921 E.01141
G1 X88.512 Y84.04 E.01141
G1 X87.926 Y84.217 E.01141
G1 X87.361 Y84.453 E.0114
G1 X86.821 Y84.743 E.01142
G1 X86.314 Y85.085 E.0114
G1 X85.843 Y85.477 E.01142
G1 X85.402 Y85.925 E.0117
G1 X85.02 Y86.407 E.01147
G1 X84.685 Y86.92 E.01141
G1 X84.405 Y87.465 E.0114
G1 X84.181 Y88.034 E.01141
G1 X84.014 Y88.624 E.01141
G1 X83.907 Y89.226 E.0114
G1 X83.86 Y89.837 E.01141
G1 X83.874 Y90.449 E.01141
G1 X83.949 Y91.057 E.0114
G1 X84.085 Y91.654 E.01141
G1 X84.279 Y92.235 E.0114
G1 X84.529 Y92.793 E.0114
G1 X84.835 Y93.324 E.01141
G1 X85.192 Y93.822 E.01141
G1 X85.596 Y94.282 E.0114
G1 X86.044 Y94.699 E.01141
G1 X86.532 Y95.069 E.0114
G1 X87.054 Y95.39 E.01141
G1 X87.605 Y95.656 E.0114
G1 X88.18 Y95.866 E.01141
G1 X88.773 Y96.018 E.0114
G1 X89.379 Y96.111 E.01141
G1 X89.99 Y96.142 E.0114
G1 X90.601 Y96.113 E.0114
G1 X91.207 Y96.022 E.01141
G1 X91.801 Y95.872 E.0114
G1 X92.377 Y95.664 E.01141
G1 X92.929 Y95.399 E.0114
G1 X93.452 Y95.08 E.01141
G1 X93.94 Y94.712 E.01141
G1 X94.39 Y94.296 E.01141
G1 X94.795 Y93.837 E.0114
G1 X95.13 Y93.378 E.01057
G1 X95.453 Y92.829 E.01188
G1 X95.708 Y92.272 E.01141
G1 X95.905 Y91.692 E.01141
G1 X96.045 Y91.095 E.01141
G1 X96.124 Y90.488 E.01141
G1 X96.142 Y89.857 E.01177
G1 X96.099 Y89.265 E.01105
G1 X95.995 Y88.661 E.01141
G1 X95.832 Y88.071 E.0114
G1 X95.611 Y87.5 E.01141
G1 X95.334 Y86.954 E.01142
G1 X95.005 Y86.438 E.0114
G1 X94.625 Y85.957 E.01142
G1 X94.2 Y85.517 E.0114
G1 X93.732 Y85.121 E.01141
G1 X93.228 Y84.773 E.01141
G1 X92.692 Y84.478 E.0114
G1 X92.128 Y84.237 E.01141
G1 X91.544 Y84.054 E.01141
G1 X91.001 Y83.945 E.01031
; WIPE_START
G1 F4800
G1 X91.544 Y84.054 E-.07891
G1 X92.128 Y84.237 E-.08731
G1 X92.692 Y84.478 E-.08726
M73 P83 R2
G1 X92.885 Y84.585 E-.03153
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X94.223 Y92.099 Z3.24 F18000
G1 X94.488 Y93.585 Z3.24
G1 Z2.84
G1 E.3 F1800
; LINE_WIDTH: 0.417181
G1 F3548
M204 S6000
G1 X94.114 Y94.013 E.01053
G1 X93.694 Y94.403 E.01063
G1 X93.238 Y94.749 E.01063
G1 X92.749 Y95.048 E.01063
G1 X92.233 Y95.296 E.01063
G1 X91.694 Y95.492 E.01064
G1 X91.139 Y95.634 E.01063
G1 X90.572 Y95.719 E.01063
G1 X90 Y95.748 E.01063
G1 X89.428 Y95.719 E.01063
G1 X88.861 Y95.634 E.01063
G1 X88.306 Y95.492 E.01063
G1 X87.767 Y95.296 E.01063
G1 X87.251 Y95.048 E.01063
G1 X86.762 Y94.749 E.01063
G1 X86.305 Y94.403 E.01063
G1 X85.694 Y93.813 E.01576
G1 X85.336 Y93.365 E.01064
G1 X85.024 Y92.884 E.01063
G1 X84.762 Y92.374 E.01064
G1 X84.552 Y91.841 E.01063
G1 X84.395 Y91.289 E.01063
G1 X84.295 Y90.725 E.01064
G1 X84.251 Y90.153 E.01063
G1 X84.264 Y89.58 E.01063
G1 X84.335 Y89.011 E.01064
G1 X84.461 Y88.452 E.01064
G1 X84.643 Y87.908 E.01063
G1 X84.878 Y87.385 E.01064
G1 X85.172 Y86.874 E.01092
G1 X85.667 Y86.216 E.01528
G1 X86.08 Y85.79 E.01102
G1 X86.519 Y85.42 E.01065
G1 X86.992 Y85.097 E.01063
G1 X87.495 Y84.821 E.01065
G1 X88.023 Y84.598 E.01064
G1 X88.571 Y84.428 E.01064
G1 X89.133 Y84.313 E.01064
G1 X89.703 Y84.255 E.01064
G1 X90.277 Y84.254 E.01063
G1 X90.813 Y84.307 E.01
G1 X91.41 Y84.423 E.01128
G1 X91.958 Y84.591 E.01064
G1 X92.487 Y84.813 E.01064
G1 X92.991 Y85.086 E.01063
G1 X93.465 Y85.409 E.01064
G1 X93.905 Y85.777 E.01064
G1 X94.306 Y86.186 E.01064
G1 X94.665 Y86.634 E.01065
G1 X94.977 Y87.115 E.01063
G1 X95.239 Y87.625 E.01065
G1 X95.45 Y88.159 E.01064
G1 X95.606 Y88.71 E.01063
G1 X95.706 Y89.275 E.01064
G1 X95.75 Y89.847 E.01064
G1 X95.737 Y90.42 E.01064
G1 X95.667 Y90.989 E.01064
G1 X95.54 Y91.549 E.01064
G1 X95.358 Y92.093 E.01064
G1 X95.123 Y92.616 E.01064
G1 X94.829 Y93.127 E.01093
G1 X94.523 Y93.537 E.0095
; CHANGE_LAYER
; Z_HEIGHT: 2.96
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F4800
G1 X94.829 Y93.127 E-.07296
G1 X95.123 Y92.616 E-.08397
G1 X95.358 Y92.093 E-.08172
G1 X95.461 Y91.784 E-.04635
; WIPE_END
G1 E-.015 F1800
; layer num/total_layer_count: 24/33
; update layer progress
M73 L24
M991 S0 P23 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z3.24 I-.824 J-.896 P1  F18000
G1 X94.737 Y92.45 Z3.24
G1 Z2.96
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F3536
M204 S6000
G1 X94.636 Y92.661 E.00472
G1 X94.34 Y93.12 E.01097
G1 X94.007 Y93.537 E.01072
G1 X93.635 Y93.918 E.01071
G1 X93.227 Y94.26 E.01071
G1 X92.787 Y94.561 E.01071
G1 X92.319 Y94.815 E.01071
G1 X91.828 Y95.022 E.01071
G1 X91.319 Y95.18 E.01072
G1 X90.797 Y95.285 E.01071
G1 X90.266 Y95.338 E.01072
G1 X89.733 Y95.338 E.01071
G1 X89.203 Y95.285 E.01071
G1 X88.681 Y95.18 E.01071
G1 X88.172 Y95.022 E.01072
G1 X87.681 Y94.815 E.01071
G1 X87.213 Y94.561 E.01072
G1 X86.773 Y94.26 E.01071
G1 X86.364 Y93.918 E.01071
G1 X85.992 Y93.537 E.01071
G1 X85.66 Y93.12 E.01072
G1 X85.371 Y92.672 E.01071
G1 X85.128 Y92.198 E.01071
G1 X84.932 Y91.698 E.01081
G1 X84.776 Y91.127 E.01189
G1 X84.696 Y90.663 E.00948
G1 X84.657 Y90.133 E.01067
G1 X84.67 Y89.601 E.01072
G1 X84.736 Y89.072 E.01071
G1 X84.855 Y88.552 E.01072
G1 X85.025 Y88.047 E.01071
G1 X85.244 Y87.561 E.01072
G1 X85.517 Y87.089 E.01098
G1 X85.983 Y86.473 E.01554
G1 X86.364 Y86.082 E.01098
G1 X86.773 Y85.74 E.01071
G1 X87.213 Y85.439 E.01072
G1 X87.681 Y85.184 E.01071
G1 X88.172 Y84.978 E.01071
G1 X88.681 Y84.82 E.01072
G1 X89.203 Y84.715 E.01071
G1 X89.733 Y84.662 E.01071
G1 X90.266 Y84.662 E.01071
G1 X90.796 Y84.715 E.01071
G1 X91.319 Y84.82 E.01071
G1 X91.828 Y84.978 E.01072
G1 X92.319 Y85.185 E.01071
G1 X92.787 Y85.439 E.01072
G1 X93.227 Y85.739 E.01071
G1 X93.635 Y86.082 E.01072
G1 X94.007 Y86.463 E.01071
G1 X94.339 Y86.88 E.01072
G1 X94.628 Y87.328 E.01071
G1 X94.872 Y87.802 E.01072
G1 X95.066 Y88.298 E.01071
G1 X95.211 Y88.81 E.01071
G1 X95.303 Y89.335 E.01072
G1 X95.343 Y89.867 E.01071
G1 X95.33 Y90.399 E.01072
G1 X95.263 Y90.928 E.01071
G1 X95.145 Y91.448 E.01072
G1 X94.971 Y91.965 E.01097
G1 X94.763 Y92.396 E.00962
M204 S10000
G1 X94.355 Y92.266 F18000
G1 F3536
M204 S6000
G1 X94.265 Y92.454 E.00419
G1 X93.995 Y92.872 E.01001
G1 X93.689 Y93.255 E.00986
G1 X93.346 Y93.607 E.00986
G1 X92.971 Y93.922 E.00986
G1 X92.565 Y94.198 E.00986
G1 X92.135 Y94.433 E.00986
G1 X91.683 Y94.623 E.00986
G1 X91.214 Y94.768 E.00986
G1 X90.733 Y94.865 E.00986
G1 X90.245 Y94.914 E.00987
G1 X89.755 Y94.914 E.00986
G1 X89.267 Y94.865 E.00986
G1 X88.786 Y94.768 E.00986
G1 X88.317 Y94.623 E.00987
G1 X87.865 Y94.433 E.00986
G1 X87.434 Y94.198 E.00986
G1 X87.029 Y93.922 E.00986
G1 X86.653 Y93.607 E.00986
G1 X86.311 Y93.256 E.00986
G1 X86.005 Y92.872 E.00986
G1 X85.739 Y92.46 E.00986
G1 X85.515 Y92.024 E.00986
G1 X85.335 Y91.564 E.00992
G1 X85.191 Y91.035 E.01102
G1 X85.118 Y90.611 E.00867
G1 X85.081 Y90.123 E.00984
G1 X85.094 Y89.632 E.00986
G1 X85.155 Y89.146 E.00986
G1 X85.264 Y88.667 E.00987
G1 X85.42 Y88.202 E.00986
G1 X85.622 Y87.755 E.00986
G1 X85.871 Y87.324 E.01002
G1 X86.305 Y86.75 E.01447
G1 X86.653 Y86.393 E.01002
G1 X87.029 Y86.078 E.00986
G1 X87.434 Y85.802 E.00986
G1 X87.865 Y85.567 E.00986
G1 X88.317 Y85.377 E.00986
G1 X88.786 Y85.232 E.00987
G1 X89.267 Y85.135 E.00986
G1 X89.755 Y85.086 E.00986
G1 X90.245 Y85.086 E.00986
G1 X90.733 Y85.135 E.00986
G1 X91.214 Y85.232 E.00986
G1 X91.683 Y85.377 E.00987
G1 X92.134 Y85.567 E.00986
G1 X92.566 Y85.802 E.00987
G1 X92.971 Y86.078 E.00986
G1 X93.346 Y86.393 E.00986
G1 X93.689 Y86.744 E.00986
G1 X93.995 Y87.128 E.00986
G1 X94.261 Y87.54 E.00986
G1 X94.485 Y87.977 E.00987
G1 X94.664 Y88.433 E.00986
G1 X94.796 Y88.905 E.00986
G1 X94.882 Y89.388 E.00987
G1 X94.918 Y89.877 E.00986
G1 X94.906 Y90.368 E.00986
G1 X94.845 Y90.854 E.00986
G1 X94.736 Y91.333 E.00987
G1 X94.577 Y91.805 E.01001
G1 X94.381 Y92.212 E.00909
M204 S250
G1 X93.987 Y92.088 F18000
M106 S229.5
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1800
M204 S5000
G1 X93.907 Y92.253 E.00342
G1 X93.662 Y92.633 E.00845
G1 X93.382 Y92.984 E.0084
G1 X93.068 Y93.306 E.0084
G1 X92.723 Y93.595 E.0084
G1 X92.352 Y93.848 E.0084
G1 X91.957 Y94.064 E.0084
G1 X91.542 Y94.238 E.0084
G1 X91.113 Y94.371 E.0084
G1 X90.672 Y94.46 E.0084
G1 X90.225 Y94.505 E.0084
G1 X89.775 Y94.505 E.0084
G1 X89.328 Y94.46 E.0084
G1 X88.887 Y94.371 E.0084
G1 X88.457 Y94.238 E.0084
G1 X88.043 Y94.064 E.0084
G1 X87.648 Y93.849 E.0084
G1 X87.276 Y93.595 E.0084
G1 X86.932 Y93.306 E.0084
G1 X86.618 Y92.984 E.0084
G1 X86.338 Y92.633 E.0084
G1 X86.094 Y92.255 E.0084
G1 X85.889 Y91.855 E.0084
G1 X85.724 Y91.435 E.00842
G1 X85.591 Y90.947 E.00946
G1 X85.525 Y90.561 E.00732
G1 X85.491 Y90.112 E.0084
G1 X85.502 Y89.663 E.0084
G1 X85.558 Y89.217 E.0084
G1 X85.658 Y88.778 E.00841
G1 X85.801 Y88.352 E.0084
G1 X85.986 Y87.942 E.0084
G1 X86.212 Y87.551 E.00845
G1 X86.616 Y87.018 E.0125
G1 X86.932 Y86.694 E.00845
G1 X87.276 Y86.405 E.0084
G1 X87.648 Y86.151 E.0084
G1 X88.043 Y85.936 E.00841
G1 X88.457 Y85.762 E.0084
G1 X88.887 Y85.629 E.00841
G1 X89.328 Y85.54 E.0084
G1 X89.775 Y85.495 E.0084
G1 X90.225 Y85.495 E.0084
G1 X90.672 Y85.54 E.0084
G1 X91.113 Y85.629 E.0084
G1 X91.542 Y85.762 E.0084
G1 X91.957 Y85.936 E.0084
G1 X92.352 Y86.152 E.00841
G1 X92.723 Y86.405 E.0084
G1 X93.068 Y86.694 E.0084
G1 X93.381 Y87.016 E.0084
G1 X93.662 Y87.367 E.0084
G1 X93.906 Y87.745 E.0084
G1 X94.111 Y88.145 E.0084
G1 X94.275 Y88.564 E.0084
G1 X94.397 Y88.996 E.0084
G1 X94.475 Y89.439 E.0084
G1 X94.509 Y89.888 E.0084
G1 X94.497 Y90.337 E.0084
G1 X94.442 Y90.783 E.0084
G1 X94.342 Y91.222 E.0084
G1 X94.198 Y91.65 E.00845
G1 X94.013 Y92.034 E.00796
; WIPE_START
M204 S6000
G1 X93.907 Y92.253 E-.03459
G1 X93.662 Y92.633 E-.06443
G1 X93.382 Y92.984 E-.06407
G1 X93.068 Y93.306 E-.06409
G1 X92.757 Y93.567 E-.05781
; WIPE_END
G1 E-.015
M204 S10000
G1 X88.495 Y87.235 Z3.36 F18000
G1 X86.497 Y84.268 Z3.36
G1 Z2.96
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F3536
M204 S6000
G1 X87.085 Y83.948 E.01347
G1 X87.702 Y83.687 E.01346
G1 X88.342 Y83.49 E.01347
G1 X88.999 Y83.357 E.01346
G1 X89.665 Y83.291 E.01347
G1 X90.335 Y83.291 E.01346
G1 X90.802 Y83.337 E.00945
G1 X91.001 Y83.357 E.00402
G1 X91.657 Y83.49 E.01346
G1 X92.297 Y83.687 E.01347
G1 X92.914 Y83.948 E.01346
G1 X93.503 Y84.268 E.01347
G1 X94.056 Y84.645 E.01347
G1 X94.569 Y85.076 E.01347
G1 X95.037 Y85.555 E.01346
G1 X95.454 Y86.079 E.01347
G1 X95.818 Y86.641 E.01347
G1 X96.123 Y87.237 E.01346
G1 X96.368 Y87.86 E.01347
G1 X96.549 Y88.505 E.01347
G1 X96.665 Y89.165 E.01347
G1 X96.715 Y89.833 E.01347
G1 X96.699 Y90.502 E.01346
G1 X96.615 Y91.167 E.01347
G1 X96.467 Y91.819 E.01346
G1 X96.253 Y92.454 E.01347
G1 X95.978 Y93.065 E.01346
G1 X95.643 Y93.645 E.01347
G1 X95.252 Y94.188 E.01346
G1 X94.809 Y94.691 E.01347
G1 X94.318 Y95.146 E.01347
G1 X93.784 Y95.55 E.01347
G1 X93.213 Y95.9 E.01346
G1 X92.609 Y96.19 E.01347
G1 X91.98 Y96.419 E.01347
G1 X91.331 Y96.585 E.01346
G1 X90.669 Y96.684 E.01347
G1 X90 Y96.718 E.01346
G1 X89.331 Y96.684 E.01346
G1 X88.669 Y96.585 E.01347
G1 X88.02 Y96.419 E.01346
G1 X87.39 Y96.19 E.01347
G1 X86.787 Y95.9 E.01346
G1 X86.216 Y95.55 E.01347
G1 X85.682 Y95.146 E.01347
G1 X85.191 Y94.691 E.01347
G1 X84.748 Y94.188 E.01347
G1 X84.357 Y93.645 E.01346
G1 X84.022 Y93.065 E.01347
G1 X83.747 Y92.454 E.01346
G1 X83.533 Y91.819 E.01347
G1 X83.384 Y91.167 E.01346
G1 X83.301 Y90.502 E.01347
G1 X83.284 Y89.833 E.01346
G1 X83.334 Y89.165 E.01347
G1 X83.451 Y88.505 E.01347
G1 X83.632 Y87.86 E.01347
G1 X83.877 Y87.237 E.01347
G1 X84.182 Y86.641 E.01347
G1 X84.545 Y86.079 E.01347
G1 X84.963 Y85.555 E.01346
G1 X85.431 Y85.076 E.01347
G1 X85.944 Y84.645 E.01347
G1 X86.447 Y84.302 E.01226
M204 S10000
G1 X86.276 Y83.905 F18000
G1 F3536
M204 S6000
G1 X86.901 Y83.565 E.01432
G1 X87.557 Y83.288 E.01432
G1 X88.237 Y83.078 E.01432
G1 X88.935 Y82.937 E.01432
G1 X89.644 Y82.866 E.01432
G1 X90.356 Y82.866 E.01432
G1 X90.845 Y82.915 E.00988
G1 X91.064 Y82.937 E.00444
G1 X91.762 Y83.078 E.01432
G1 X92.443 Y83.288 E.01432
G1 X93.099 Y83.565 E.01432
G1 X93.724 Y83.905 E.01432
G1 X94.313 Y84.307 E.01432
G1 X94.858 Y84.764 E.01432
G1 X95.355 Y85.274 E.01432
G1 X95.799 Y85.831 E.01432
G1 X96.185 Y86.429 E.01432
G1 X96.51 Y87.062 E.01432
G1 X96.77 Y87.725 E.01432
G1 X96.963 Y88.411 E.01432
G1 X97.087 Y89.112 E.01432
G1 X97.14 Y89.822 E.01432
G1 X97.122 Y90.534 E.01431
G1 X97.034 Y91.24 E.01432
G1 X96.875 Y91.934 E.01431
G1 X96.649 Y92.61 E.01432
G1 X96.356 Y93.259 E.01432
G1 X96 Y93.875 E.01432
G1 X95.584 Y94.453 E.01431
G1 X95.113 Y94.987 E.01432
G1 X94.591 Y95.471 E.01432
G1 X94.023 Y95.901 E.01432
G1 X93.416 Y96.273 E.01432
G1 X92.774 Y96.582 E.01432
G1 X92.105 Y96.825 E.01432
G1 X91.415 Y97.001 E.01432
G1 X90.711 Y97.107 E.01432
G1 X90 Y97.143 E.01432
G1 X89.289 Y97.107 E.01432
G1 X88.585 Y97.001 E.01432
G1 X87.895 Y96.825 E.01431
G1 X87.225 Y96.582 E.01432
G1 X86.584 Y96.273 E.01432
G1 X85.976 Y95.901 E.01432
G1 X85.409 Y95.471 E.01432
G1 X84.887 Y94.987 E.01432
G1 X84.416 Y94.453 E.01432
G1 X84 Y93.875 E.01432
G1 X83.644 Y93.258 E.01432
G1 X83.351 Y92.61 E.01431
G1 X83.124 Y91.934 E.01432
G1 X82.966 Y91.24 E.01432
G1 X82.877 Y90.534 E.01432
G1 X82.86 Y89.822 E.01431
G1 X82.913 Y89.112 E.01432
G1 X83.036 Y88.411 E.01432
G1 X83.229 Y87.725 E.01432
G1 X83.489 Y87.062 E.01432
G1 X83.814 Y86.429 E.01432
G1 X84.201 Y85.831 E.01432
G1 X84.644 Y85.274 E.01432
G1 X85.142 Y84.764 E.01432
G1 X85.687 Y84.307 E.01432
G1 X86.226 Y83.939 E.01311
M204 S250
G1 X86.062 Y83.556 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1440
M204 S5000
G1 X86.723 Y83.196 E.01406
G1 X87.417 Y82.903 E.01407
G1 X88.136 Y82.681 E.01407
G1 X88.874 Y82.532 E.01407
G1 X89.623 Y82.457 E.01407
G1 X90.376 Y82.457 E.01407
G1 X90.885 Y82.508 E.00956
G1 X91.125 Y82.532 E.00451
G1 X91.863 Y82.681 E.01407
G1 X92.583 Y82.903 E.01407
G1 X93.277 Y83.196 E.01407
G1 X93.938 Y83.556 E.01407
G1 X94.56 Y83.98 E.01407
G1 X95.137 Y84.464 E.01407
G1 X95.662 Y85.003 E.01407
G1 X96.132 Y85.591 E.01407
G1 X96.54 Y86.224 E.01407
G1 X96.884 Y86.894 E.01407
G1 X97.159 Y87.595 E.01407
G1 X97.363 Y88.319 E.01407
G1 X97.493 Y89.061 E.01407
G1 X97.55 Y89.812 E.01407
G1 X97.531 Y90.564 E.01407
G1 X97.437 Y91.311 E.01407
G1 X97.27 Y92.045 E.01407
G1 X97.03 Y92.759 E.01407
G1 X96.72 Y93.445 E.01406
G1 X96.344 Y94.098 E.01407
G1 X95.904 Y94.709 E.01407
G1 X95.406 Y95.273 E.01407
G1 X94.854 Y95.785 E.01407
G1 X94.254 Y96.24 E.01407
G1 X93.612 Y96.633 E.01407
G1 X92.933 Y96.959 E.01407
G1 X92.226 Y97.217 E.01407
G1 X91.496 Y97.403 E.01407
G1 X90.752 Y97.515 E.01407
G1 X90 Y97.552 E.01407
G1 X89.248 Y97.515 E.01407
G1 X88.503 Y97.403 E.01407
G1 X87.774 Y97.217 E.01407
G1 X87.066 Y96.959 E.01407
G1 X86.388 Y96.633 E.01407
G1 X85.745 Y96.24 E.01407
G1 X85.145 Y95.785 E.01407
G1 X84.593 Y95.273 E.01407
G1 X84.095 Y94.709 E.01407
G1 X83.656 Y94.098 E.01407
G1 X83.279 Y93.445 E.01407
G1 X82.97 Y92.759 E.01407
G1 X82.73 Y92.045 E.01407
G1 X82.562 Y91.311 E.01407
G1 X82.469 Y90.564 E.01407
G1 X82.45 Y89.812 E.01407
G1 X82.506 Y89.061 E.01407
G1 X82.637 Y88.319 E.01407
G1 X82.841 Y87.595 E.01407
G1 X83.116 Y86.894 E.01407
G1 X83.459 Y86.224 E.01407
G1 X83.868 Y85.591 E.01407
G1 X84.337 Y85.003 E.01407
G1 X84.863 Y84.464 E.01407
G1 X85.44 Y83.98 E.01407
G1 X86.012 Y83.589 E.01295
M106 S73.95
; WIPE_START
M204 S6000
G1 X86.723 Y83.196 E-.11577
G1 X87.417 Y82.903 E-.1073
G1 X87.832 Y82.775 E-.06193
; WIPE_END
G1 E-.015 F1800
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
G1 X0 Y90.0001 ; move to safe pos
G1 X-13.0 F3000 ; move to safe pos
M400
M1004 S5 P1  ; external shutter
M400 P300
M971 S11 C11 O0
G92 E0
G1 X0 F18000
M623

; SKIPTYPE: head_wrap_detect
M622.1 S1
M1002 judge_flag g39_3rd_layer_detect_flag
M622 J1
    ; enable nozzle clog detect at 3rd layer
    


    M622.1 S1
    M1002 judge_flag g39_detection_flag
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




G1 X95.569 Y92.868
G1 Z2.96
G1 E.3 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.501338
G1 F3536
M204 S6000
G1 X95.809 Y92.347 E.01294
G1 X96.023 Y91.731 E.01469
G1 X96.165 Y91.123 E.01408
G1 X96.246 Y90.503 E.01408
G1 X96.266 Y89.856 E.01461
G1 X96.222 Y89.256 E.01355
G1 X96.117 Y88.64 E.01409
G1 X95.951 Y88.038 E.01408
G1 X95.726 Y87.455 E.01408
G1 X95.444 Y86.897 E.01409
G1 X95.109 Y86.371 E.01408
G1 X94.722 Y85.88 E.01409
G1 X94.288 Y85.43 E.01408
G1 X93.812 Y85.026 E.01409
G1 X93.298 Y84.671 E.01407
G1 X92.751 Y84.369 E.01409
M73 P84 R2
G1 X92.176 Y84.124 E.01408
G1 X91.58 Y83.936 E.01409
G1 X90.969 Y83.809 E.01408
G1 X90.347 Y83.743 E.01409
G1 X89.723 Y83.739 E.01407
G1 X89.101 Y83.798 E.01409
G1 X88.488 Y83.918 E.01408
G1 X87.89 Y84.099 E.01409
G1 X87.313 Y84.339 E.01408
G1 X86.763 Y84.634 E.01408
G1 X86.244 Y84.983 E.01409
G1 X85.763 Y85.382 E.01408
G1 X85.314 Y85.838 E.01444
G1 X84.92 Y86.333 E.01425
G1 X84.579 Y86.857 E.01408
G1 X84.293 Y87.412 E.01408
G1 X84.064 Y87.993 E.01408
G1 X83.894 Y88.594 E.01408
G1 X83.784 Y89.209 E.01408
G1 X83.736 Y89.832 E.01409
G1 X83.751 Y90.457 E.01408
G1 X83.827 Y91.076 E.01408
G1 X83.965 Y91.685 E.01408
G1 X84.163 Y92.278 E.01409
G1 X84.418 Y92.848 E.01407
G1 X84.73 Y93.39 E.01409
G1 X85.094 Y93.897 E.01408
G1 X85.506 Y94.366 E.01407
G1 X85.963 Y94.792 E.01409
G1 X86.46 Y95.17 E.01408
G1 X86.993 Y95.497 E.01408
G1 X87.555 Y95.769 E.01407
G1 X88.142 Y95.984 E.01409
G1 X88.746 Y96.139 E.01407
G1 X89.364 Y96.234 E.01409
G1 X89.988 Y96.266 E.01408
G1 X90.612 Y96.236 E.01408
G1 X91.23 Y96.144 E.01408
G1 X91.835 Y95.991 E.01408
G1 X92.423 Y95.778 E.01409
G1 X92.986 Y95.509 E.01408
G1 X93.52 Y95.184 E.01408
G1 X94.018 Y94.808 E.01408
G1 X94.477 Y94.383 E.01409
G1 X94.891 Y93.916 E.01407
G1 X95.257 Y93.41 E.01407
G1 X95.539 Y92.92 E.01273
M204 S10000
G1 X95.145 Y92.644 F18000
; LINE_WIDTH: 0.501336
G1 F3536
M204 S6000
G1 X94.862 Y93.141 E.01288
G1 X94.526 Y93.609 E.013
G1 X94.144 Y94.042 E.013
G1 X93.721 Y94.435 E.01302
G1 X93.261 Y94.783 E.01301
G1 X92.768 Y95.084 E.01301
G1 X92.249 Y95.334 E.013
G1 X91.706 Y95.532 E.01301
G1 X91.147 Y95.674 E.013
G1 X90.576 Y95.76 E.01301
G1 X90 Y95.789 E.01301
G1 X89.424 Y95.76 E.01301
G1 X88.853 Y95.674 E.01301
G1 X88.294 Y95.532 E.013
G1 X87.751 Y95.334 E.01302
G1 X87.231 Y95.084 E.013
G1 X86.739 Y94.783 E.01301
G1 X86.279 Y94.435 E.01301
G1 X85.856 Y94.042 E.01302
G1 X85.474 Y93.609 E.013
G1 X85.137 Y93.141 E.013
G1 X84.848 Y92.641 E.01302
G1 X84.611 Y92.115 E.013
G1 X84.429 Y91.569 E.01297
G1 X84.298 Y91.006 E.01303
G1 X84.227 Y90.433 E.01303
G1 X84.213 Y89.856 E.01301
G1 X84.256 Y89.28 E.01301
G1 X84.356 Y88.712 E.013
G1 X84.512 Y88.156 E.01301
G1 X84.723 Y87.619 E.01301
G1 X84.986 Y87.106 E.013
G1 X85.299 Y86.628 E.01287
G1 X85.634 Y86.192 E.01239
G1 X86.05 Y85.761 E.01351
G1 X86.492 Y85.389 E.01302
G1 X86.969 Y85.062 E.01302
G1 X87.476 Y84.785 E.01302
G1 X88.007 Y84.56 E.01301
G1 X88.559 Y84.388 E.01303
G1 X89.125 Y84.273 E.01302
G1 X89.699 Y84.214 E.01302
G1 X90.277 Y84.213 E.01301
G1 X90.852 Y84.269 E.01302
G1 X91.418 Y84.383 E.01301
G1 X91.97 Y84.552 E.01302
G1 X92.503 Y84.775 E.01302
G1 X93.011 Y85.05 E.01303
G1 X93.489 Y85.375 E.01301
G1 X93.932 Y85.745 E.01302
G1 X94.336 Y86.158 E.01301
G1 X94.697 Y86.609 E.01302
G1 X95.011 Y87.093 E.01301
G1 X95.276 Y87.607 E.01303
G1 X95.488 Y88.144 E.01301
G1 X95.645 Y88.699 E.01301
G1 X95.747 Y89.268 E.01303
G1 X95.791 Y89.844 E.01302
G1 X95.778 Y90.421 E.01302
G1 X95.707 Y90.994 E.01302
G1 X95.58 Y91.558 E.01302
G1 X95.392 Y92.12 E.01337
G1 X95.171 Y92.59 E.01171
; CHANGE_LAYER
; Z_HEIGHT: 3.08
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F4800
G1 X95.392 Y92.12 E-.07402
G1 X95.58 Y91.558 E-.08451
G1 X95.707 Y90.994 E-.08231
G1 X95.745 Y90.687 E-.04416
; WIPE_END
G1 E-.015 F1800
; layer num/total_layer_count: 25/33
; update layer progress
M73 L25
M991 S0 P24 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z3.36 I-1.059 J-.599 P1  F18000
G1 X94.715 Y92.51 Z3.36
G1 Z3.08
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F3600
M204 S6000
G1 X94.489 Y92.9 E.00905
G1 X94.179 Y93.332 E.01071
G1 X93.826 Y93.732 E.01072
G1 X93.436 Y94.094 E.01071
G1 X93.011 Y94.416 E.01072
G1 X92.556 Y94.694 E.01071
G1 X92.064 Y94.931 E.01098
G1 X91.332 Y95.177 E.01553
G1 X90.797 Y95.285 E.01098
G1 X90.266 Y95.338 E.01072
G1 X89.733 Y95.338 E.01071
G1 X89.203 Y95.285 E.01071
G1 X88.681 Y95.18 E.01071
G1 X88.172 Y95.022 E.01072
G1 X87.681 Y94.815 E.01071
G1 X87.213 Y94.561 E.01072
G1 X86.773 Y94.261 E.01071
G1 X86.364 Y93.918 E.01072
G1 X85.992 Y93.537 E.01071
G1 X85.66 Y93.12 E.01071
G1 X85.371 Y92.672 E.01072
G1 X85.128 Y92.198 E.01072
G1 X84.933 Y91.702 E.01071
G1 X84.789 Y91.19 E.01071
G1 X84.697 Y90.665 E.01072
G1 X84.657 Y90.133 E.01071
G1 X84.67 Y89.601 E.01071
G1 X84.736 Y89.072 E.01071
G1 X84.855 Y88.552 E.01072
G1 X85.025 Y88.047 E.01071
G1 X85.244 Y87.562 E.01071
G1 X85.51 Y87.1 E.01071
G1 X85.821 Y86.668 E.01071
G1 X86.174 Y86.268 E.01072
G1 X86.564 Y85.906 E.01071
G1 X86.989 Y85.584 E.01071
G1 X87.444 Y85.306 E.01072
G1 X87.935 Y85.069 E.01098
G1 X88.668 Y84.823 E.01554
G1 X89.203 Y84.715 E.01098
G1 X89.733 Y84.662 E.01071
G1 X90.266 Y84.662 E.01071
G1 X90.796 Y84.715 E.01071
G1 X91.319 Y84.82 E.01071
G1 X91.828 Y84.978 E.01072
G1 X92.319 Y85.184 E.01071
G1 X92.787 Y85.439 E.01072
G1 X93.227 Y85.74 E.01071
G1 X93.635 Y86.082 E.01071
G1 X94.007 Y86.463 E.01071
G1 X94.339 Y86.88 E.01071
G1 X94.629 Y87.328 E.01072
G1 X94.872 Y87.802 E.01072
G1 X95.066 Y88.298 E.01071
G1 X95.211 Y88.81 E.01071
G1 X95.303 Y89.335 E.01072
G1 X95.343 Y89.867 E.01071
G1 X95.33 Y90.399 E.01071
G1 X95.263 Y90.928 E.01071
G1 X95.145 Y91.448 E.01072
G1 X94.975 Y91.953 E.01071
G1 X94.756 Y92.439 E.01072
G1 X94.745 Y92.458 E.00045
M204 S10000
G1 X94.347 Y92.298 F18000
G1 F3600
M204 S6000
G1 X94.133 Y92.669 E.00863
G1 X93.846 Y93.068 E.00986
G1 X93.522 Y93.435 E.00987
G1 X93.162 Y93.769 E.00986
G1 X92.771 Y94.065 E.00986
G1 X92.353 Y94.321 E.00986
G1 X91.904 Y94.537 E.01002
G1 X91.221 Y94.766 E.01447
G1 X90.733 Y94.865 E.01002
G1 X90.245 Y94.914 E.00987
G1 X89.755 Y94.914 E.00986
G1 X89.267 Y94.865 E.00986
G1 X88.786 Y94.768 E.00986
G1 X88.317 Y94.623 E.00987
G1 X87.865 Y94.433 E.00986
G1 X87.434 Y94.198 E.00987
G1 X87.029 Y93.922 E.00986
G1 X86.653 Y93.607 E.00986
G1 X86.311 Y93.256 E.00986
G1 X86.005 Y92.872 E.00986
G1 X85.739 Y92.46 E.00987
G1 X85.515 Y92.023 E.00986
G1 X85.336 Y91.567 E.00986
G1 X85.203 Y91.095 E.00986
G1 X85.118 Y90.612 E.00986
G1 X85.081 Y90.123 E.00986
G1 X85.094 Y89.632 E.00986
G1 X85.155 Y89.146 E.00986
G1 X85.264 Y88.667 E.00987
G1 X85.42 Y88.202 E.00986
G1 X85.622 Y87.755 E.00986
G1 X85.867 Y87.331 E.00986
G1 X86.153 Y86.932 E.00986
G1 X86.478 Y86.565 E.00986
G1 X86.837 Y86.231 E.00986
G1 X87.228 Y85.935 E.00986
G1 X87.647 Y85.679 E.00986
G1 X88.096 Y85.463 E.01002
G1 X88.778 Y85.234 E.01448
G1 X89.267 Y85.135 E.01002
G1 X89.755 Y85.086 E.00986
G1 X90.245 Y85.086 E.00986
G1 X90.733 Y85.135 E.00986
G1 X91.214 Y85.232 E.00986
G1 X91.683 Y85.377 E.00987
G1 X92.134 Y85.567 E.00986
G1 X92.565 Y85.802 E.00987
G1 X92.971 Y86.078 E.00986
G1 X93.346 Y86.393 E.00986
G1 X93.689 Y86.744 E.00986
G1 X93.995 Y87.128 E.00986
G1 X94.261 Y87.54 E.00987
G1 X94.485 Y87.977 E.00986
G1 X94.664 Y88.433 E.00986
G1 X94.796 Y88.905 E.00986
G1 X94.882 Y89.388 E.00986
G1 X94.918 Y89.877 E.00986
G1 X94.906 Y90.368 E.00986
G1 X94.845 Y90.854 E.00986
G1 X94.736 Y91.333 E.00987
G1 X94.58 Y91.798 E.00986
G1 X94.378 Y92.245 E.00987
G1 X94.377 Y92.246 E.00003
M204 S250
G1 X93.993 Y92.093 F18000
M106 S229.5
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1800
M204 S5000
G1 X93.789 Y92.447 E.00763
G1 X93.526 Y92.812 E.0084
G1 X93.229 Y93.149 E.0084
G1 X92.899 Y93.455 E.0084
G1 X92.541 Y93.727 E.0084
G1 X92.157 Y93.961 E.0084
G1 X91.749 Y94.157 E.00846
G1 X91.115 Y94.37 E.0125
G1 X90.672 Y94.46 E.00845
G1 X90.225 Y94.505 E.0084
G1 X89.775 Y94.505 E.0084
G1 X89.328 Y94.46 E.0084
G1 X88.887 Y94.371 E.0084
G1 X88.457 Y94.238 E.00841
G1 X88.043 Y94.064 E.0084
G1 X87.648 Y93.848 E.00841
G1 X87.276 Y93.595 E.0084
G1 X86.932 Y93.306 E.0084
G1 X86.618 Y92.984 E.0084
G1 X86.338 Y92.633 E.0084
G1 X86.094 Y92.255 E.00841
G1 X85.889 Y91.855 E.0084
G1 X85.724 Y91.437 E.0084
G1 X85.603 Y91.004 E.0084
G1 X85.525 Y90.561 E.0084
G1 X85.491 Y90.112 E.0084
G1 X85.502 Y89.663 E.0084
G1 X85.558 Y89.217 E.0084
G1 X85.658 Y88.778 E.00841
G1 X85.801 Y88.352 E.0084
G1 X85.986 Y87.942 E.0084
G1 X86.211 Y87.553 E.0084
G1 X86.474 Y87.188 E.0084
G1 X86.771 Y86.851 E.0084
G1 X87.101 Y86.545 E.0084
G1 X87.459 Y86.273 E.0084
G1 X87.843 Y86.039 E.0084
G1 X88.25 Y85.843 E.00845
G1 X88.884 Y85.63 E.0125
G1 X89.328 Y85.54 E.00845
G1 X89.775 Y85.495 E.0084
G1 X90.225 Y85.495 E.0084
G1 X90.672 Y85.54 E.0084
G1 X91.113 Y85.629 E.0084
G1 X91.543 Y85.762 E.00841
G1 X91.957 Y85.936 E.0084
G1 X92.352 Y86.152 E.00841
G1 X92.723 Y86.405 E.0084
G1 X93.068 Y86.694 E.0084
G1 X93.381 Y87.016 E.0084
G1 X93.662 Y87.367 E.0084
G1 X93.906 Y87.745 E.00841
G1 X94.111 Y88.145 E.0084
G1 X94.275 Y88.563 E.0084
G1 X94.397 Y88.996 E.0084
G1 X94.475 Y89.439 E.0084
G1 X94.509 Y89.888 E.0084
G1 X94.497 Y90.337 E.0084
G1 X94.442 Y90.783 E.0084
G1 X94.342 Y91.222 E.0084
G1 X94.198 Y91.648 E.0084
G1 X94.021 Y92.04 E.00805
; WIPE_START
M204 S6000
G1 X93.789 Y92.447 E-.06676
G1 X93.526 Y92.812 E-.06406
G1 X93.229 Y93.149 E-.06408
G1 X92.899 Y93.455 E-.06405
G1 X92.753 Y93.565 E-.02605
; WIPE_END
G1 E-.015
M204 S10000
G1 X88.496 Y87.23 Z3.48 F18000
G1 X86.411 Y84.127 Z3.48
G1 Z3.08
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F3600
M204 S6000
G1 X87.013 Y83.799 E.01379
G1 X87.646 Y83.532 E.0138
G1 X88.302 Y83.33 E.0138
G1 X88.974 Y83.194 E.01379
G1 X89.657 Y83.126 E.0138
G1 X90.343 Y83.126 E.0138
G1 X90.636 Y83.155 E.00593
G1 X91.026 Y83.194 E.00787
G1 X91.698 Y83.33 E.01379
G1 X92.354 Y83.532 E.0138
G1 X92.986 Y83.799 E.0138
G1 X93.589 Y84.127 E.01379
G1 X94.156 Y84.514 E.0138
G1 X94.681 Y84.955 E.01379
G1 X95.16 Y85.446 E.0138
G1 X95.588 Y85.982 E.01379
G1 X95.96 Y86.559 E.0138
G1 X96.273 Y87.169 E.01379
G1 X96.524 Y87.808 E.0138
G1 X96.71 Y88.469 E.0138
G1 X96.829 Y89.144 E.01379
G1 X96.88 Y89.828 E.0138
G1 X96.863 Y90.514 E.01379
G1 X96.778 Y91.195 E.0138
G1 X96.625 Y91.864 E.01379
G1 X96.407 Y92.515 E.0138
G1 X96.125 Y93.14 E.0138
G1 X95.781 Y93.734 E.0138
G1 X95.381 Y94.291 E.01379
G1 X94.927 Y94.806 E.0138
G1 X94.424 Y95.272 E.01379
G1 X93.877 Y95.687 E.0138
G1 X93.291 Y96.045 E.0138
G1 X92.673 Y96.342 E.0138
G1 X92.029 Y96.577 E.01379
G1 X91.364 Y96.746 E.0138
G1 X90.685 Y96.849 E.0138
G1 X90 Y96.883 E.01379
G1 X89.315 Y96.849 E.01379
G1 X88.636 Y96.746 E.0138
G1 X87.971 Y96.577 E.0138
G1 X87.326 Y96.342 E.0138
G1 X86.708 Y96.045 E.0138
G1 X86.123 Y95.687 E.0138
G1 X85.576 Y95.272 E.0138
G1 X85.073 Y94.806 E.0138
G1 X84.619 Y94.291 E.0138
G1 X84.218 Y93.734 E.01379
G1 X83.875 Y93.14 E.0138
G1 X83.593 Y92.515 E.0138
G1 X83.374 Y91.864 E.0138
G1 X83.222 Y91.195 E.01379
G1 X83.136 Y90.514 E.0138
G1 X83.119 Y89.828 E.01379
G1 X83.171 Y89.144 E.0138
G1 X83.29 Y88.469 E.01379
G1 X83.476 Y87.808 E.0138
G1 X83.726 Y87.169 E.0138
G1 X84.039 Y86.559 E.01379
G1 X84.411 Y85.982 E.0138
G1 X84.839 Y85.446 E.0138
G1 X85.318 Y84.955 E.0138
G1 X85.844 Y84.514 E.01379
G1 X86.361 Y84.161 E.01259
M204 S10000
G1 X86.19 Y83.765 F18000
G1 F3600
M204 S6000
G1 X86.829 Y83.416 E.01464
G1 X87.501 Y83.133 E.01465
G1 X88.197 Y82.918 E.01465
G1 X88.911 Y82.774 E.01465
G1 X89.636 Y82.702 E.01465
G1 X90.364 Y82.702 E.01465
G1 X90.679 Y82.733 E.00635
G1 X91.089 Y82.774 E.00829
G1 X91.803 Y82.918 E.01465
G1 X92.499 Y83.133 E.01465
G1 X93.171 Y83.416 E.01465
G1 X93.81 Y83.765 E.01464
G1 X94.412 Y84.175 E.01465
G1 X94.97 Y84.643 E.01465
G1 X95.479 Y85.165 E.01465
G1 X95.933 Y85.734 E.01465
G1 X96.328 Y86.346 E.01465
G1 X96.661 Y86.994 E.01464
G1 X96.927 Y87.673 E.01465
G1 X97.124 Y88.374 E.01465
G1 X97.251 Y89.091 E.01465
G1 X97.305 Y89.818 E.01465
G1 X97.287 Y90.546 E.01464
G1 X97.196 Y91.269 E.01465
G1 X97.034 Y91.979 E.01465
G1 X96.802 Y92.67 E.01465
G1 X96.503 Y93.334 E.01465
G1 X96.138 Y93.965 E.01465
G1 X95.713 Y94.556 E.01464
G1 X95.231 Y95.102 E.01465
G1 X94.697 Y95.598 E.01465
G1 X94.116 Y96.038 E.01465
G1 X93.495 Y96.418 E.01465
M73 P84 R1
G1 X92.838 Y96.734 E.01465
G1 X92.154 Y96.983 E.01465
G1 X91.448 Y97.163 E.01465
G1 X90.727 Y97.271 E.01465
G1 X90 Y97.308 E.01465
G1 X89.272 Y97.271 E.01465
G1 X88.552 Y97.163 E.01465
G1 X87.846 Y96.983 E.01465
G1 X87.161 Y96.734 E.01465
G1 X86.505 Y96.418 E.01465
G1 X85.883 Y96.038 E.01465
G1 X85.303 Y95.598 E.01465
G1 X84.769 Y95.102 E.01465
G1 X84.287 Y94.556 E.01465
G1 X83.861 Y93.965 E.01465
G1 X83.497 Y93.334 E.01465
G1 X83.197 Y92.67 E.01464
G1 X82.965 Y91.979 E.01465
G1 X82.803 Y91.269 E.01465
G1 X82.713 Y90.546 E.01465
G1 X82.695 Y89.818 E.01464
G1 X82.749 Y89.091 E.01465
G1 X82.876 Y88.374 E.01465
M73 P85 R1
G1 X83.073 Y87.673 E.01465
G1 X83.339 Y86.995 E.01465
G1 X83.671 Y86.346 E.01465
G1 X84.067 Y85.734 E.01465
G1 X84.521 Y85.165 E.01465
G1 X85.03 Y84.643 E.01465
G1 X85.587 Y84.175 E.01465
G1 X86.14 Y83.798 E.01345
M204 S250
G1 X85.973 Y83.417 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1440
M204 S5000
G1 X85.976 Y83.415 E.00006
G1 X86.651 Y83.047 E.01437
G1 X87.36 Y82.748 E.01438
G1 X88.096 Y82.521 E.01438
G1 X88.85 Y82.369 E.01438
G1 X89.615 Y82.292 E.01438
G1 X90.384 Y82.292 E.01437
G1 X90.719 Y82.326 E.00629
G1 X91.15 Y82.369 E.00809
G1 X91.904 Y82.521 E.01438
G1 X92.639 Y82.748 E.01438
G1 X93.348 Y83.047 E.01438
G1 X94.024 Y83.415 E.01437
G1 X94.66 Y83.848 E.01438
G1 X95.249 Y84.343 E.01437
G1 X95.786 Y84.894 E.01438
G1 X96.266 Y85.495 E.01437
G1 X96.683 Y86.141 E.01438
G1 X97.034 Y86.826 E.01437
G1 X97.315 Y87.542 E.01437
G1 X97.524 Y88.283 E.01438
G1 X97.657 Y89.04 E.01437
G1 X97.715 Y89.808 E.01438
G1 X97.695 Y90.577 E.01437
G1 X97.6 Y91.34 E.01438
G1 X97.429 Y92.09 E.01437
G1 X97.184 Y92.82 E.01438
G1 X96.867 Y93.521 E.01437
G1 X96.482 Y94.187 E.01438
G1 X96.033 Y94.812 E.01437
G1 X95.524 Y95.388 E.01438
G1 X94.96 Y95.912 E.01438
G1 X94.347 Y96.376 E.01438
G1 X93.691 Y96.777 E.01438
G1 X92.997 Y97.111 E.01438
G1 X92.275 Y97.374 E.01437
G1 X91.529 Y97.564 E.01438
G1 X90.768 Y97.679 E.01438
G1 X90 Y97.717 E.01438
G1 X89.231 Y97.679 E.01438
G1 X88.471 Y97.564 E.01438
G1 X87.725 Y97.374 E.01437
G1 X87.002 Y97.111 E.01438
G1 X86.309 Y96.777 E.01438
G1 X85.653 Y96.376 E.01438
G1 X85.039 Y95.912 E.01438
G1 X84.475 Y95.388 E.01438
G1 X83.966 Y94.812 E.01438
G1 X83.517 Y94.187 E.01437
G1 X83.132 Y93.521 E.01438
G1 X82.816 Y92.82 E.01437
G1 X82.571 Y92.09 E.01438
G1 X82.4 Y91.34 E.01437
G1 X82.304 Y90.577 E.01438
G1 X82.285 Y89.808 E.01437
G1 X82.342 Y89.04 E.01438
G1 X82.476 Y88.283 E.01437
G1 X82.684 Y87.542 E.01438
G1 X82.965 Y86.826 E.01437
G1 X83.317 Y86.141 E.01438
G1 X83.734 Y85.495 E.01437
G1 X84.214 Y84.894 E.01438
G1 X84.751 Y84.343 E.01438
G1 X85.34 Y83.848 E.01437
G1 X85.923 Y83.451 E.01319
M106 S73.95
; WIPE_START
M204 S6000
G1 X85.976 Y83.415 E-.00903
G1 X86.651 Y83.047 E-.10961
G1 X87.36 Y82.748 E-.10964
G1 X87.741 Y82.631 E-.05672
; WIPE_END
G1 E-.015 F1800
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
G1 X0 Y90.0001 ; move to safe pos
G1 X-13.0 F3000 ; move to safe pos
M400
M1004 S5 P1  ; external shutter
M400 P300
M971 S11 C11 O0
G92 E0
G1 X0 F18000
M623

; SKIPTYPE: head_wrap_detect
M622.1 S1
M1002 judge_flag g39_3rd_layer_detect_flag
M622 J1
    ; enable nozzle clog detect at 3rd layer
    


    M622.1 S1
    M1002 judge_flag g39_detection_flag
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




G1 X91.869 Y96.109
G1 Z3.08
G1 E.3 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.583636
G1 F3654
M204 S6000
G1 X92.416 Y95.915 E.01533
G1 X93.02 Y95.632 E.01763
G1 X93.565 Y95.303 E.01684
G1 X94.076 Y94.922 E.01685
G1 X94.545 Y94.492 E.01683
G1 X94.97 Y94.016 E.01686
G1 X95.345 Y93.502 E.01683
G1 X95.667 Y92.952 E.01684
G1 X95.933 Y92.373 E.01685
G1 X96.14 Y91.771 E.01685
G1 X96.286 Y91.15 E.01684
G1 X96.369 Y90.519 E.01685
G1 X96.389 Y89.855 E.01757
G1 X96.345 Y89.247 E.01611
G1 X96.239 Y88.618 E.01685
G1 X96.07 Y88.004 E.01684
G1 X95.842 Y87.41 E.01683
G1 X95.554 Y86.841 E.01685
G1 X95.212 Y86.304 E.01684
G1 X94.818 Y85.803 E.01685
G1 X94.377 Y85.344 E.01683
G1 X93.891 Y84.931 E.01685
G1 X93.367 Y84.569 E.01684
G1 X92.81 Y84.261 E.01685
G1 X92.224 Y84.01 E.01684
G1 X91.617 Y83.818 E.01685
G1 X90.993 Y83.688 E.01684
G1 X90.36 Y83.62 E.01685
G1 X89.723 Y83.616 E.01684
G1 X89.089 Y83.675 E.01685
G1 X88.448 Y83.8 E.01726
G1 X87.828 Y83.992 E.01716
G1 X87.24 Y84.237 E.01684
G1 X86.68 Y84.541 E.01684
G1 X86.153 Y84.898 E.01685
G1 X85.664 Y85.307 E.01684
G1 X85.218 Y85.762 E.01684
G1 X84.82 Y86.259 E.01685
G1 X84.473 Y86.793 E.01684
G1 X84.182 Y87.359 E.01683
G1 X83.948 Y87.952 E.01685
G1 X83.774 Y88.565 E.01685
G1 X83.662 Y89.192 E.01683
G1 X83.613 Y89.827 E.01685
G1 X83.627 Y90.464 E.01684
G1 X83.705 Y91.096 E.01684
G1 X83.845 Y91.717 E.01685
G1 X84.047 Y92.321 E.01684
G1 X84.308 Y92.902 E.01683
G1 X84.625 Y93.455 E.01686
G1 X84.996 Y93.973 E.01684
G1 X85.416 Y94.451 E.01683
G1 X85.882 Y94.886 E.01685
G1 X86.389 Y95.271 E.01685
G1 X86.932 Y95.605 E.01684
G1 X87.505 Y95.882 E.01684
G1 X88.103 Y96.102 E.01685
G1 X88.72 Y96.26 E.01683
G1 X89.35 Y96.356 E.01685
G1 X89.986 Y96.389 E.01684
G1 X90.622 Y96.359 E.01684
G1 X91.252 Y96.266 E.01685
G1 X91.811 Y96.123 E.01525
M204 S10000
G1 X91.71 Y95.57 F18000
; LINE_WIDTH: 0.583635
G1 F3654
M204 S6000
G1 X91.155 Y95.715 E.01517
G1 X90.58 Y95.801 E.01537
G1 X90 Y95.83 E.01536
G1 X89.419 Y95.801 E.01537
G1 X88.845 Y95.714 E.01537
G1 X88.282 Y95.571 E.01536
G1 X87.735 Y95.372 E.01538
G1 X87.212 Y95.12 E.01536
G1 X86.716 Y94.817 E.01537
G1 X86.252 Y94.466 E.01537
G1 X85.826 Y94.071 E.01537
G1 X85.442 Y93.635 E.01536
G1 X85.103 Y93.163 E.01536
G1 X84.812 Y92.66 E.01538
G1 X84.573 Y92.13 E.01536
G1 X84.388 Y91.579 E.01537
G1 X84.258 Y91.012 E.01537
G1 X84.186 Y90.436 E.01536
G1 X84.172 Y89.855 E.01537
G1 X84.215 Y89.275 E.01537
G1 X84.316 Y88.703 E.01536
G1 X84.473 Y88.143 E.01537
G1 X84.686 Y87.602 E.01537
G1 X84.951 Y87.085 E.01536
G1 X85.266 Y86.597 E.01537
G1 X85.629 Y86.142 E.01538
G1 X86.034 Y85.726 E.01536
G1 X86.48 Y85.353 E.01537
G1 X86.96 Y85.025 E.01537
G1 X87.47 Y84.747 E.01536
G1 X88 Y84.527 E.01518
G1 X88.525 Y84.355 E.0146
G1 X89.116 Y84.232 E.01597
G1 X89.695 Y84.173 E.01539
G1 X90.277 Y84.172 E.01537
G1 X90.856 Y84.228 E.01538
G1 X91.426 Y84.342 E.01538
G1 X91.983 Y84.512 E.01539
G1 X92.519 Y84.737 E.01537
G1 X93.031 Y85.014 E.01539
G1 X93.512 Y85.341 E.01538
G1 X93.958 Y85.714 E.01539
G1 X94.365 Y86.129 E.01537
G1 X94.729 Y86.583 E.01538
G1 X95.046 Y87.071 E.01538
G1 X95.313 Y87.588 E.01539
G1 X95.526 Y88.128 E.01537
G1 X95.685 Y88.688 E.01538
G1 X95.788 Y89.261 E.01539
G1 X95.832 Y89.841 E.01538
G1 X95.819 Y90.422 E.01538
G1 X95.748 Y90.999 E.01538
G1 X95.62 Y91.567 E.01538
G1 X95.436 Y92.119 E.01538
G1 X95.198 Y92.65 E.01539
G1 X94.909 Y93.154 E.01538
G1 X94.57 Y93.627 E.01537
G1 X94.186 Y94.064 E.01539
G1 X93.761 Y94.461 E.01537
G1 X93.298 Y94.813 E.01538
G1 X92.803 Y95.118 E.01538
G1 X92.265 Y95.378 E.01581
G1 X91.767 Y95.55 E.01392
; CHANGE_LAYER
; Z_HEIGHT: 3.2
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F4800
G1 X92.265 Y95.378 E-.07501
G1 X92.803 Y95.118 E-.08519
G1 X93.298 Y94.813 E-.08288
G1 X93.532 Y94.635 E-.04193
; WIPE_END
G1 E-.015 F1800
; layer num/total_layer_count: 26/33
; update layer progress
M73 L26
M991 S0 P25 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z3.48 I1.063 J.592 P1  F18000
G1 X94.713 Y92.512 Z3.48
G1 Z3.2
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F3600
M204 S6000
G1 X94.49 Y92.9 E.009
G1 X94.178 Y93.333 E.01072
G1 X93.826 Y93.732 E.01071
G1 X93.435 Y94.094 E.01071
G1 X93.011 Y94.416 E.01072
G1 X92.556 Y94.694 E.01072
G1 X92.064 Y94.931 E.01098
G1 X91.332 Y95.177 E.01554
G1 X90.797 Y95.285 E.01098
G1 X90.266 Y95.338 E.01072
G1 X89.733 Y95.338 E.01071
G1 X89.203 Y95.285 E.01071
G1 X88.681 Y95.179 E.01072
G1 X88.172 Y95.022 E.01072
G1 X87.681 Y94.815 E.01071
G1 X87.213 Y94.561 E.01071
G1 X86.77 Y94.259 E.01079
G1 X86.33 Y93.884 E.01161
G1 X85.991 Y93.535 E.00977
G1 X85.66 Y93.12 E.01068
G1 X85.371 Y92.672 E.01071
G1 X85.128 Y92.198 E.01071
G1 X84.933 Y91.702 E.01072
G1 X84.789 Y91.189 E.01071
G1 X84.697 Y90.665 E.01072
G1 X84.657 Y90.133 E.01071
G1 X84.67 Y89.601 E.01071
G1 X84.736 Y89.072 E.01071
G1 X84.855 Y88.552 E.01072
G1 X85.025 Y88.047 E.01071
G1 X85.244 Y87.561 E.01072
G1 X85.51 Y87.1 E.01071
G1 X85.821 Y86.668 E.01072
G1 X86.174 Y86.268 E.01071
G1 X86.564 Y85.906 E.01071
G1 X86.989 Y85.584 E.01071
G1 X87.444 Y85.306 E.01071
G1 X87.936 Y85.069 E.01098
G1 X88.668 Y84.823 E.01554
G1 X89.203 Y84.715 E.01098
G1 X89.733 Y84.662 E.01071
G1 X90.266 Y84.662 E.01071
G1 X90.796 Y84.715 E.01071
G1 X91.319 Y84.821 E.01072
G1 X91.828 Y84.978 E.01072
G1 X92.319 Y85.184 E.01071
G1 X92.787 Y85.439 E.01071
G1 X93.227 Y85.739 E.01071
G1 X93.635 Y86.082 E.01072
G1 X94.007 Y86.463 E.01071
G1 X94.339 Y86.88 E.01071
G1 X94.628 Y87.327 E.01071
G1 X94.872 Y87.802 E.01072
G1 X95.066 Y88.298 E.01071
G1 X95.211 Y88.81 E.0107
G1 X95.303 Y89.335 E.01072
G1 X95.343 Y89.867 E.01071
G1 X95.33 Y90.399 E.01071
G1 X95.263 Y90.928 E.01071
G1 X95.145 Y91.448 E.01072
G1 X94.975 Y91.953 E.01071
G1 X94.756 Y92.438 E.01072
G1 X94.743 Y92.46 E.0005
M204 S10000
G1 X94.346 Y92.3 F18000
G1 F3600
M204 S6000
G1 X94.133 Y92.669 E.00857
G1 X93.846 Y93.068 E.00987
G1 X93.522 Y93.435 E.00986
G1 X93.162 Y93.769 E.00986
G1 X92.771 Y94.065 E.00986
G1 X92.353 Y94.321 E.00986
G1 X91.904 Y94.537 E.01002
G1 X91.221 Y94.766 E.01447
G1 X90.733 Y94.865 E.01002
G1 X90.245 Y94.914 E.00987
G1 X89.755 Y94.914 E.00986
G1 X89.267 Y94.865 E.00986
G1 X88.786 Y94.768 E.00986
G1 X88.317 Y94.623 E.00986
G1 X87.865 Y94.433 E.00986
G1 X87.434 Y94.198 E.00986
G1 X87.027 Y93.921 E.0099
G1 X86.62 Y93.574 E.01075
G1 X86.31 Y93.255 E.00895
G1 X86.005 Y92.872 E.00984
G1 X85.739 Y92.46 E.00986
G1 X85.515 Y92.024 E.00986
G1 X85.336 Y91.567 E.00987
G1 X85.203 Y91.095 E.00986
G1 X85.118 Y90.612 E.00986
G1 X85.081 Y90.123 E.00986
G1 X85.094 Y89.632 E.00986
G1 X85.155 Y89.146 E.00986
G1 X85.264 Y88.667 E.00987
G1 X85.42 Y88.202 E.00986
G1 X85.622 Y87.755 E.00986
G1 X85.867 Y87.331 E.00986
G1 X86.153 Y86.932 E.00986
G1 X86.478 Y86.565 E.00986
G1 X86.837 Y86.231 E.00986
G1 X87.228 Y85.935 E.00986
G1 X87.647 Y85.679 E.00986
G1 X88.096 Y85.463 E.01002
G1 X88.778 Y85.234 E.01448
G1 X89.267 Y85.135 E.01002
G1 X89.755 Y85.086 E.00986
G1 X90.245 Y85.086 E.00986
G1 X90.733 Y85.135 E.00986
G1 X91.214 Y85.232 E.00986
G1 X91.683 Y85.377 E.00986
G1 X92.134 Y85.567 E.00986
G1 X92.565 Y85.802 E.00986
G1 X92.97 Y86.078 E.00986
G1 X93.346 Y86.393 E.00987
G1 X93.689 Y86.745 E.00986
G1 X93.995 Y87.128 E.00986
G1 X94.261 Y87.54 E.00986
G1 X94.484 Y87.977 E.00987
G1 X94.664 Y88.433 E.00986
G1 X94.796 Y88.905 E.00985
G1 X94.882 Y89.388 E.00986
G1 X94.918 Y89.877 E.00986
G1 X94.906 Y90.368 E.00986
G1 X94.845 Y90.854 E.00986
G1 X94.736 Y91.333 E.00987
G1 X94.58 Y91.798 E.00986
G1 X94.378 Y92.245 E.00986
G1 X94.376 Y92.248 E.00008
M204 S250
G1 X93.992 Y92.095 F18000
M106 S229.5
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1800
M204 S5000
G1 X93.789 Y92.447 E.00759
G1 X93.526 Y92.812 E.00841
G1 X93.229 Y93.149 E.0084
G1 X92.899 Y93.455 E.0084
G1 X92.541 Y93.727 E.0084
G1 X92.157 Y93.961 E.0084
G1 X91.749 Y94.157 E.00845
G1 X91.115 Y94.37 E.0125
G1 X90.672 Y94.46 E.00845
G1 X90.225 Y94.505 E.00841
G1 X89.775 Y94.505 E.0084
G1 X89.328 Y94.46 E.0084
G1 X88.887 Y94.371 E.0084
G1 X88.457 Y94.238 E.0084
G1 X88.043 Y94.064 E.0084
G1 X87.648 Y93.849 E.0084
G1 X87.276 Y93.595 E.00842
G1 X86.9 Y93.275 E.00922
G1 X86.618 Y92.984 E.00758
G1 X86.338 Y92.633 E.0084
G1 X86.094 Y92.255 E.0084
G1 X85.889 Y91.855 E.0084
G1 X85.724 Y91.436 E.00841
G1 X85.603 Y91.004 E.0084
G1 X85.525 Y90.561 E.0084
G1 X85.491 Y90.112 E.00841
G1 X85.502 Y89.663 E.0084
G1 X85.558 Y89.217 E.0084
G1 X85.658 Y88.778 E.0084
G1 X85.801 Y88.352 E.0084
G1 X85.986 Y87.942 E.0084
G1 X86.211 Y87.553 E.0084
G1 X86.474 Y87.188 E.0084
G1 X86.771 Y86.851 E.0084
G1 X87.101 Y86.545 E.0084
G1 X87.459 Y86.273 E.0084
G1 X87.843 Y86.039 E.0084
G1 X88.25 Y85.843 E.00845
G1 X88.884 Y85.63 E.0125
G1 X89.328 Y85.54 E.00845
G1 X89.775 Y85.495 E.0084
G1 X90.225 Y85.495 E.0084
G1 X90.672 Y85.54 E.0084
G1 X91.113 Y85.629 E.0084
G1 X91.542 Y85.762 E.0084
G1 X91.957 Y85.936 E.0084
G1 X92.352 Y86.151 E.0084
G1 X92.723 Y86.405 E.0084
G1 X93.068 Y86.694 E.0084
G1 X93.382 Y87.016 E.0084
G1 X93.662 Y87.367 E.0084
G1 X93.906 Y87.745 E.0084
G1 X94.111 Y88.145 E.0084
M73 P86 R1
G1 X94.275 Y88.564 E.0084
G1 X94.397 Y88.996 E.0084
G1 X94.475 Y89.439 E.0084
G1 X94.509 Y89.888 E.00841
G1 X94.497 Y90.337 E.0084
G1 X94.442 Y90.783 E.0084
G1 X94.342 Y91.222 E.0084
G1 X94.198 Y91.648 E.0084
G1 X94.02 Y92.043 E.00809
; WIPE_START
M204 S6000
G1 X93.789 Y92.447 E-.06639
G1 X93.526 Y92.812 E-.06411
G1 X93.229 Y93.149 E-.06406
G1 X92.899 Y93.455 E-.06406
G1 X92.751 Y93.567 E-.02638
; WIPE_END
G1 E-.015
M204 S10000
G1 X88.5 Y87.228 Z3.6 F18000
G1 X86.325 Y83.986 Z3.6
G1 Z3.2
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F3600
M204 S6000
G1 X86.942 Y83.65 E.01413
G1 X87.589 Y83.377 E.01413
G1 X88.261 Y83.17 E.01413
G1 X88.949 Y83.031 E.01413
G1 X89.649 Y82.961 E.01413
G1 X90.47 Y82.973 E.01652
G1 X91.05 Y83.031 E.01172
G1 X91.739 Y83.17 E.01413
G1 X92.41 Y83.377 E.01413
G1 X93.058 Y83.65 E.01413
G1 X93.675 Y83.986 E.01413
G1 X94.255 Y84.382 E.01413
G1 X94.794 Y84.834 E.01413
G1 X95.284 Y85.337 E.01413
G1 X95.722 Y85.886 E.01413
G1 X96.103 Y86.476 E.01413
G1 X96.424 Y87.101 E.01412
G1 X96.681 Y87.755 E.01413
G1 X96.871 Y88.432 E.01413
G1 X96.993 Y89.124 E.01413
G1 X97.045 Y89.824 E.01413
G1 X97.028 Y90.527 E.01412
G1 X96.94 Y91.224 E.01413
G1 X96.784 Y91.909 E.01412
G1 X96.56 Y92.575 E.01413
G1 X96.271 Y93.215 E.01412
G1 X95.92 Y93.824 E.01414
G1 X95.51 Y94.394 E.01412
G1 X95.045 Y94.921 E.01413
G1 X94.53 Y95.399 E.01412
G1 X93.97 Y95.823 E.01413
G1 X93.37 Y96.189 E.01413
G1 X92.737 Y96.494 E.01413
G1 X92.077 Y96.735 E.01413
G1 X91.396 Y96.908 E.01412
G1 X90.701 Y97.013 E.01413
G1 X90 Y97.048 E.01413
G1 X89.298 Y97.013 E.01413
G1 X88.603 Y96.908 E.01413
G1 X87.922 Y96.735 E.01413
G1 X87.262 Y96.494 E.01413
G1 X86.629 Y96.189 E.01413
G1 X86.03 Y95.823 E.01413
G1 X85.47 Y95.399 E.01413
G1 X84.955 Y94.921 E.01413
G1 X84.49 Y94.394 E.01413
G1 X84.08 Y93.824 E.01413
G1 X83.728 Y93.215 E.01413
G1 X83.439 Y92.575 E.01412
G1 X83.215 Y91.909 E.01413
G1 X83.059 Y91.224 E.01412
G1 X82.972 Y90.527 E.01413
G1 X82.954 Y89.824 E.01412
G1 X83.007 Y89.124 E.01413
G1 X83.129 Y88.432 E.01413
G1 X83.319 Y87.755 E.01413
G1 X83.576 Y87.101 E.01413
G1 X83.896 Y86.476 E.01413
G1 X84.277 Y85.886 E.01413
G1 X84.716 Y85.337 E.01413
G1 X85.206 Y84.834 E.01413
G1 X85.744 Y84.382 E.01413
G1 X86.275 Y84.02 E.01292
M204 S10000
G1 X86.103 Y83.624 F18000
G1 F3600
M204 S6000
G1 X86.758 Y83.268 E.01498
G1 X87.444 Y82.978 E.01498
G1 X88.156 Y82.759 E.01498
G1 X88.886 Y82.611 E.01498
G1 X89.627 Y82.537 E.01498
G1 X90.512 Y82.551 E.0178
G1 X91.114 Y82.611 E.01215
G1 X91.844 Y82.759 E.01498
G1 X92.556 Y82.978 E.01498
G1 X93.242 Y83.268 E.01498
G1 X93.896 Y83.624 E.01498
G1 X94.512 Y84.043 E.01498
G1 X95.082 Y84.522 E.01498
G1 X95.603 Y85.056 E.01498
G1 X96.067 Y85.638 E.01498
G1 X96.471 Y86.264 E.01498
G1 X96.811 Y86.927 E.01498
G1 X97.083 Y87.62 E.01498
G1 X97.285 Y88.337 E.01498
G1 X97.414 Y89.071 E.01498
G1 X97.47 Y89.814 E.01498
G1 X97.451 Y90.558 E.01497
G1 X97.359 Y91.298 E.01498
G1 X97.193 Y92.024 E.01498
G1 X96.956 Y92.73 E.01498
G1 X96.649 Y93.409 E.01498
G1 X96.277 Y94.054 E.01499
G1 X95.842 Y94.659 E.01497
G1 X95.349 Y95.218 E.01498
G1 X94.803 Y95.724 E.01498
G1 X94.209 Y96.174 E.01498
G1 X93.574 Y96.563 E.01498
G1 X92.902 Y96.886 E.01498
G1 X92.202 Y97.141 E.01498
G1 X91.481 Y97.324 E.01498
G1 X90.744 Y97.435 E.01498
G1 X90 Y97.473 E.01498
G1 X89.256 Y97.435 E.01498
G1 X88.519 Y97.324 E.01498
G1 X87.797 Y97.141 E.01498
G1 X87.097 Y96.886 E.01498
G1 X86.426 Y96.563 E.01498
G1 X85.79 Y96.174 E.01498
G1 X85.197 Y95.724 E.01498
G1 X84.651 Y95.218 E.01498
G1 X84.158 Y94.659 E.01498
G1 X83.723 Y94.054 E.01498
G1 X83.35 Y93.409 E.01498
G1 X83.044 Y92.73 E.01498
G1 X82.807 Y92.024 E.01498
G1 X82.641 Y91.298 E.01498
G1 X82.548 Y90.558 E.01498
G1 X82.53 Y89.814 E.01497
G1 X82.585 Y89.071 E.01498
G1 X82.715 Y88.337 E.01498
G1 X82.916 Y87.62 E.01498
G1 X83.189 Y86.927 E.01498
G1 X83.528 Y86.264 E.01498
G1 X83.933 Y85.638 E.01498
G1 X84.397 Y85.056 E.01498
G1 X84.917 Y84.522 E.01498
G1 X85.488 Y84.043 E.01498
G1 X86.054 Y83.658 E.01378
M204 S250
G1 X85.88 Y83.281 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1440
M204 S5000
G1 X85.89 Y83.274 E.00021
G1 X86.58 Y82.898 E.01468
G1 X87.304 Y82.593 E.01468
G1 X88.055 Y82.362 E.01468
G1 X88.825 Y82.206 E.01468
G1 X89.607 Y82.128 E.01468
G1 X90.393 Y82.128 E.01468
G1 X90.553 Y82.144 E.00301
G1 X91.175 Y82.206 E.01167
G1 X91.945 Y82.362 E.01468
G1 X92.696 Y82.593 E.01468
G1 X93.42 Y82.898 E.01468
G1 X94.11 Y83.274 E.01468
G1 X94.759 Y83.717 E.01469
G1 X95.361 Y84.222 E.01468
G1 X95.91 Y84.784 E.01468
G1 X96.4 Y85.399 E.01468
G1 X96.826 Y86.059 E.01468
G1 X97.185 Y86.758 E.01468
G1 X97.472 Y87.49 E.01468
G1 X97.684 Y88.246 E.01468
G1 X97.821 Y89.02 E.01468
G1 X97.88 Y89.804 E.01468
G1 X97.86 Y90.589 E.01468
G1 X97.762 Y91.369 E.01469
G1 X97.587 Y92.135 E.01468
G1 X97.337 Y92.88 E.01469
G1 X97.014 Y93.596 E.01468
G1 X96.621 Y94.277 E.01469
G1 X96.162 Y94.914 E.01468
G1 X95.642 Y95.504 E.01468
G1 X95.066 Y96.038 E.01468
G1 X94.44 Y96.513 E.01468
G1 X93.77 Y96.922 E.01468
G1 X93.062 Y97.263 E.01468
G1 X92.323 Y97.532 E.01469
G1 X91.562 Y97.726 E.01468
G1 X90.785 Y97.843 E.01468
G1 X90 Y97.882 E.01468
G1 X89.215 Y97.843 E.01468
G1 X88.438 Y97.726 E.01468
G1 X87.676 Y97.532 E.01468
G1 X86.938 Y97.263 E.01468
G1 X86.23 Y96.922 E.01468
G1 X85.56 Y96.513 E.01468
G1 X84.933 Y96.038 E.01468
G1 X84.357 Y95.504 E.01468
G1 X83.837 Y94.915 E.01468
G1 X83.379 Y94.277 E.01468
G1 X82.986 Y93.596 E.01469
G1 X82.662 Y92.88 E.01468
G1 X82.412 Y92.135 E.01469
G1 X82.237 Y91.369 E.01468
G1 X82.14 Y90.589 E.01469
G1 X82.12 Y89.804 E.01468
G1 X82.179 Y89.02 E.01468
G1 X82.315 Y88.246 E.01468
G1 X82.528 Y87.49 E.01468
G1 X82.815 Y86.758 E.01468
G1 X83.174 Y86.059 E.01468
G1 X83.6 Y85.399 E.01468
G1 X84.09 Y84.784 E.01468
G1 X84.639 Y84.222 E.01468
G1 X85.24 Y83.717 E.01468
G1 X85.831 Y83.314 E.01335
M106 S73.95
; WIPE_START
M204 S6000
G1 X85.89 Y83.274 E-.01019
G1 X86.58 Y82.898 E-.11195
G1 X87.304 Y82.593 E-.11199
G1 X87.645 Y82.488 E-.05088
; WIPE_END
G1 E-.015 F1800
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
G1 X0 Y90.0001 ; move to safe pos
G1 X-13.0 F3000 ; move to safe pos
M400
M1004 S5 P1  ; external shutter
M400 P300
M971 S11 C11 O0
G92 E0
G1 X0 F18000
M623

; SKIPTYPE: head_wrap_detect
M622.1 S1
M1002 judge_flag g39_3rd_layer_detect_flag
M622 J1
    ; enable nozzle clog detect at 3rd layer
    


    M622.1 S1
    M1002 judge_flag g39_detection_flag
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




G1 X90.466 Y83.384
G1 Z3.2
G1 E.3 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.419992
G1 F4800
M204 S6000
G1 X89.729 Y83.371 E.01376
G1 X89.064 Y83.431 E.01248
G1 X88.399 Y83.56 E.01265
G1 X87.751 Y83.756 E.01266
G1 X87.14 Y84.011 E.01236
G1 X86.558 Y84.325 E.01236
G1 X86.01 Y84.696 E.01237
G1 X85.502 Y85.12 E.01236
G1 X85.038 Y85.592 E.01236
G1 X84.624 Y86.108 E.01237
G1 X84.263 Y86.662 E.01236
G1 X83.959 Y87.25 E.01236
G1 X83.716 Y87.865 E.01237
G1 X83.534 Y88.502 E.01236
G1 X83.417 Y89.153 E.01236
G1 X83.366 Y89.812 E.01237
G1 X83.38 Y90.474 E.01236
G1 X83.46 Y91.131 E.01236
G1 X83.605 Y91.776 E.01237
G1 X83.814 Y92.404 E.01236
G1 X84.084 Y93.008 E.01236
G1 X84.413 Y93.582 E.01237
G1 X84.797 Y94.121 E.01236
G1 X85.233 Y94.618 E.01236
G1 X85.717 Y95.07 E.01237
G1 X86.243 Y95.471 E.01236
G1 X86.806 Y95.818 E.01237
G1 X87.401 Y96.107 E.01236
G1 X88.023 Y96.336 E.01237
G1 X88.663 Y96.501 E.01236
G1 X89.317 Y96.602 E.01237
G1 X89.978 Y96.637 E.01236
G1 X90.638 Y96.606 E.01236
G1 X91.293 Y96.51 E.01237
G1 X91.934 Y96.349 E.01235
G1 X92.498 Y96.146 E.01118
G1 X93.126 Y95.853 E.01295
G1 X93.693 Y95.513 E.01236
G1 X94.224 Y95.117 E.01236
G1 X94.712 Y94.672 E.01236
G1 X95.154 Y94.179 E.01236
G1 X95.545 Y93.645 E.01237
G1 X95.88 Y93.075 E.01235
G1 X96.157 Y92.474 E.01236
G1 X96.373 Y91.849 E.01236
G1 X96.525 Y91.205 E.01236
G1 X96.613 Y90.549 E.01236
G1 X96.635 Y89.857 E.01295
G1 X96.59 Y89.228 E.01177
G1 X96.481 Y88.576 E.01237
G1 X96.307 Y87.938 E.01235
G1 X96.07 Y87.32 E.01236
G1 X95.773 Y86.729 E.01237
G1 X95.419 Y86.17 E.01236
G1 X95.01 Y85.65 E.01236
G1 X94.552 Y85.173 E.01236
G1 X94.049 Y84.743 E.01237
G1 X93.506 Y84.366 E.01236
G1 X92.927 Y84.045 E.01236
G1 X92.32 Y83.783 E.01236
G1 X91.689 Y83.583 E.01236
G1 X91.042 Y83.447 E.01236
G1 X90.525 Y83.39 E.00971
; WIPE_START
G1 X91.042 Y83.447 E-.07408
G1 X91.689 Y83.583 E-.09426
G1 X92.32 Y83.783 E-.09427
G1 X92.464 Y83.846 E-.0224
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X91.952 Y91.461 Z3.6 F18000
G1 X91.682 Y95.491 Z3.6
G1 Z3.2
G1 E.3 F1800
G1 F4800
M204 S6000
G1 X91.139 Y95.633 E.01049
G1 X90.572 Y95.719 E.01071
G1 X90 Y95.747 E.0107
G1 X89.428 Y95.719 E.0107
G1 X88.861 Y95.633 E.01071
G1 X88.306 Y95.492 E.0107
G1 X87.767 Y95.296 E.01071
G1 X87.251 Y95.048 E.0107
G1 X86.762 Y94.749 E.01071
G1 X86.309 Y94.404 E.01065
G1 X85.886 Y94.014 E.01074
G1 X85.506 Y93.584 E.01072
G1 X85.172 Y93.118 E.0107
G1 X84.885 Y92.622 E.01072
G1 X84.65 Y92.1 E.0107
G1 X84.467 Y91.557 E.01071
G1 X84.34 Y90.998 E.01071
G1 X84.269 Y90.43 E.0107
G1 X84.254 Y89.857 E.01071
G1 X84.297 Y89.285 E.01071
G1 X84.397 Y88.721 E.0107
G1 X84.552 Y88.17 E.01071
G1 X84.761 Y87.636 E.01071
G1 X85.022 Y87.126 E.0107
G1 X85.333 Y86.645 E.01071
G1 X85.691 Y86.197 E.01071
G1 X86.091 Y85.787 E.01071
G1 X86.529 Y85.419 E.0107
G1 X87.003 Y85.096 E.01071
G1 X87.506 Y84.822 E.0107
G1 X88.025 Y84.607 E.01049
G1 X88.555 Y84.429 E.01045
G1 X89.132 Y84.312 E.01101
G1 X89.703 Y84.254 E.01072
G1 X90.277 Y84.253 E.01071
G1 X90.848 Y84.309 E.01072
G1 X91.41 Y84.421 E.01072
G1 X91.959 Y84.59 E.01072
G1 X92.487 Y84.811 E.01072
G1 X92.992 Y85.085 E.01072
G1 X93.466 Y85.407 E.01071
G1 X93.906 Y85.775 E.01073
G1 X94.308 Y86.185 E.01072
G1 X94.666 Y86.633 E.01072
G1 X94.978 Y87.114 E.01071
G1 X95.241 Y87.625 E.01073
G1 X95.451 Y88.158 E.01072
G1 X95.607 Y88.71 E.01071
G1 X95.708 Y89.275 E.01072
G1 X95.752 Y89.847 E.01072
G1 X95.739 Y90.42 E.01072
G1 X95.668 Y90.989 E.01072
G1 X95.542 Y91.549 E.01072
G1 X95.36 Y92.093 E.01072
G1 X95.125 Y92.616 E.01072
G1 X94.839 Y93.113 E.01071
G1 X94.505 Y93.58 E.01073
G1 X94.126 Y94.011 E.01072
G1 X93.706 Y94.401 E.01071
G1 X93.249 Y94.749 E.01072
G1 X92.76 Y95.049 E.01072
M73 P87 R1
G1 X92.23 Y95.305 E.01102
G1 X91.738 Y95.472 E.00969
M204 S10000
G1 X91.824 Y95.915 F18000
; LINE_WIDTH: 0.517876
G1 F4800
M204 S6000
G1 X92.347 Y95.732 E.01292
G1 X92.934 Y95.456 E.01514
G1 X93.463 Y95.136 E.01441
G1 X93.957 Y94.766 E.01441
G1 X94.412 Y94.348 E.0144
G1 X94.823 Y93.887 E.0144
G1 X95.186 Y93.387 E.01441
G1 X95.498 Y92.854 E.0144
G1 X95.755 Y92.293 E.0144
G1 X95.954 Y91.708 E.01441
G1 X96.095 Y91.107 E.0144
G1 X96.175 Y90.495 E.01441
G1 X96.194 Y89.846 E.01514
G1 X96.15 Y89.261 E.01367
G1 X96.046 Y88.652 E.01441
G1 X95.882 Y88.057 E.01439
G1 X95.659 Y87.481 E.0144
G1 X95.38 Y86.93 E.01442
G1 X95.048 Y86.41 E.0144
G1 X94.666 Y85.925 E.0144
G1 X94.237 Y85.481 E.0144
G1 X93.765 Y85.081 E.01441
G1 X93.257 Y84.731 E.0144
G1 X92.716 Y84.433 E.0144
G1 X92.148 Y84.19 E.0144
G1 X91.559 Y84.005 E.01441
G1 X90.955 Y83.879 E.0144
G1 X90.422 Y83.823 E.0125
G1 X89.723 Y83.812 E.0163
G1 X89.108 Y83.87 E.01441
G1 X88.487 Y83.992 E.01476
G1 X87.883 Y84.183 E.01478
G1 X87.313 Y84.421 E.0144
G1 X86.771 Y84.716 E.01439
G1 X86.261 Y85.064 E.01441
G1 X85.788 Y85.461 E.0144
G1 X85.357 Y85.903 E.0144
G1 X84.972 Y86.385 E.0144
G1 X84.637 Y86.904 E.0144
G1 X84.355 Y87.453 E.01439
G1 X84.13 Y88.028 E.0144
G1 X83.963 Y88.622 E.0144
G1 X83.856 Y89.23 E.0144
G1 X83.809 Y89.846 E.0144
G1 X83.825 Y90.463 E.0144
G1 X83.901 Y91.075 E.01439
G1 X84.039 Y91.677 E.0144
G1 X84.236 Y92.262 E.0144
G1 X84.489 Y92.825 E.01439
G1 X84.798 Y93.36 E.01441
G1 X85.158 Y93.861 E.0144
G1 X85.567 Y94.324 E.01439
G1 X86.02 Y94.743 E.01441
G1 X86.511 Y95.116 E.01439
G1 X87.038 Y95.438 E.0144
G1 X87.594 Y95.706 E.01439
G1 X88.175 Y95.917 E.0144
G1 X88.773 Y96.07 E.01439
G1 X89.383 Y96.162 E.01441
G1 X90 Y96.192 E.01439
G1 X90.616 Y96.162 E.0144
G1 X91.227 Y96.07 E.0144
G1 X91.766 Y95.93 E.01299
; CHANGE_LAYER
; Z_HEIGHT: 3.32
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F4800
G1 X91.227 Y96.07 E-.07934
G1 X90.616 Y96.162 E-.088
G1 X90 Y96.192 E-.08796
G1 X89.792 Y96.182 E-.0297
; WIPE_END
G1 E-.015 F1800
; layer num/total_layer_count: 27/33
; update layer progress
M73 L27
M991 S0 P26 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z3.6 I.731 J.973 P1  F18000
G1 X94.729 Y92.476 Z3.6
G1 Z3.32
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F3600
M204 S6000
G1 X94.629 Y92.672 E.00443
G1 X94.339 Y93.12 E.01071
G1 X94.007 Y93.536 E.01071
G1 X93.635 Y93.918 E.01072
G1 X93.227 Y94.261 E.01072
G1 X92.787 Y94.561 E.01071
G1 X92.319 Y94.815 E.01072
G1 X91.828 Y95.022 E.01071
G1 X91.319 Y95.179 E.01072
G1 X90.797 Y95.285 E.01071
G1 X90.266 Y95.338 E.01071
G1 X89.733 Y95.338 E.01072
G1 X89.203 Y95.285 E.01071
G1 X88.681 Y95.179 E.01071
G1 X88.172 Y95.022 E.01072
G1 X87.681 Y94.815 E.01071
G1 X87.213 Y94.561 E.01071
G1 X86.773 Y94.26 E.01072
G1 X86.365 Y93.918 E.01071
G1 X85.992 Y93.537 E.01072
G1 X85.66 Y93.12 E.01071
G1 X85.371 Y92.672 E.01071
G1 X85.128 Y92.198 E.01072
G1 X84.933 Y91.702 E.01072
G1 X84.789 Y91.189 E.01071
G1 X84.697 Y90.665 E.01072
G1 X84.657 Y90.133 E.01071
G1 X84.67 Y89.601 E.01071
G1 X84.736 Y89.072 E.01071
G1 X84.855 Y88.552 E.01072
G1 X85.025 Y88.047 E.01071
G1 X85.244 Y87.561 E.01072
G1 X85.51 Y87.1 E.01071
G1 X85.821 Y86.667 E.01072
G1 X86.174 Y86.268 E.0107
G1 X86.564 Y85.906 E.01072
G1 X86.999 Y85.576 E.01097
G1 X87.669 Y85.19 E.01555
G1 X88.172 Y84.978 E.01097
G1 X88.681 Y84.82 E.01072
G1 X89.203 Y84.715 E.01071
G1 X89.733 Y84.662 E.01071
G1 X90.266 Y84.662 E.01071
G1 X90.796 Y84.715 E.01071
G1 X91.319 Y84.821 E.01072
G1 X91.828 Y84.978 E.01072
G1 X92.319 Y85.185 E.01071
G1 X92.787 Y85.439 E.01071
G1 X93.227 Y85.739 E.01072
G1 X93.635 Y86.082 E.01072
G1 X94.007 Y86.463 E.01071
G1 X94.339 Y86.88 E.01071
G1 X94.628 Y87.328 E.01072
G1 X94.872 Y87.802 E.01072
G1 X95.066 Y88.298 E.01072
G1 X95.211 Y88.811 E.0107
G1 X95.303 Y89.335 E.01072
G1 X95.343 Y89.867 E.01071
G1 X95.33 Y90.399 E.01071
G1 X95.262 Y90.941 E.01097
G1 X95.071 Y91.69 E.01555
G1 X94.872 Y92.198 E.01097
G1 X94.756 Y92.423 E.00508
M204 S10000
G1 X94.351 Y92.283 F18000
G1 F3600
M204 S6000
G1 X94.261 Y92.46 E.004
G1 X93.995 Y92.872 E.00986
G1 X93.689 Y93.255 E.00986
G1 X93.346 Y93.607 E.00987
G1 X92.97 Y93.922 E.00986
G1 X92.565 Y94.198 E.00986
G1 X92.135 Y94.433 E.00986
G1 X91.683 Y94.623 E.00986
G1 X91.214 Y94.768 E.00987
G1 X90.733 Y94.865 E.00986
G1 X90.245 Y94.914 E.00986
G1 X89.754 Y94.914 E.00987
G1 X89.267 Y94.865 E.00986
G1 X88.786 Y94.768 E.00986
G1 X88.317 Y94.623 E.00987
G1 X87.865 Y94.433 E.00986
G1 X87.434 Y94.198 E.00986
G1 X87.029 Y93.922 E.00986
G1 X86.653 Y93.607 E.00986
G1 X86.311 Y93.255 E.00987
G1 X86.005 Y92.872 E.00986
G1 X85.739 Y92.46 E.00986
G1 X85.515 Y92.023 E.00987
G1 X85.336 Y91.567 E.00986
G1 X85.203 Y91.095 E.00986
G1 X85.118 Y90.612 E.00986
G1 X85.081 Y90.123 E.00986
G1 X85.094 Y89.632 E.00986
G1 X85.155 Y89.146 E.00986
G1 X85.264 Y88.667 E.00987
G1 X85.42 Y88.202 E.00986
G1 X85.622 Y87.755 E.00986
G1 X85.867 Y87.331 E.00986
G1 X86.153 Y86.932 E.00986
G1 X86.478 Y86.565 E.00986
G1 X86.837 Y86.231 E.00987
G1 X87.234 Y85.93 E.01001
G1 X87.858 Y85.57 E.01448
G1 X88.317 Y85.377 E.01002
G1 X88.786 Y85.232 E.00987
G1 X89.267 Y85.135 E.00986
G1 X89.755 Y85.086 E.00986
G1 X90.245 Y85.086 E.00986
G1 X90.733 Y85.135 E.00986
G1 X91.214 Y85.232 E.00986
G1 X91.683 Y85.377 E.00987
G1 X92.135 Y85.567 E.00986
G1 X92.565 Y85.802 E.00986
G1 X92.971 Y86.078 E.00986
G1 X93.346 Y86.393 E.00986
G1 X93.689 Y86.745 E.00986
G1 X93.994 Y87.128 E.00986
G1 X94.261 Y87.54 E.00986
G1 X94.484 Y87.977 E.00987
G1 X94.664 Y88.433 E.00986
G1 X94.796 Y88.905 E.00986
G1 X94.882 Y89.388 E.00986
G1 X94.918 Y89.877 E.00986
G1 X94.906 Y90.368 E.00986
G1 X94.844 Y90.862 E.01002
G1 X94.666 Y91.56 E.01448
G1 X94.484 Y92.024 E.01002
G1 X94.379 Y92.23 E.00466
M204 S250
G1 X93.987 Y92.096 F18000
M106 S229.5
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1800
M204 S5000
G1 X93.906 Y92.255 E.00334
G1 X93.662 Y92.633 E.0084
G1 X93.382 Y92.984 E.0084
G1 X93.067 Y93.306 E.00841
G1 X92.723 Y93.595 E.0084
G1 X92.352 Y93.848 E.00839
G1 X91.957 Y94.064 E.0084
G1 X91.543 Y94.238 E.0084
G1 X91.113 Y94.371 E.0084
G1 X90.672 Y94.46 E.0084
G1 X90.225 Y94.505 E.0084
G1 X89.775 Y94.505 E.00841
G1 X89.328 Y94.46 E.0084
G1 X88.887 Y94.371 E.0084
G1 X88.457 Y94.238 E.0084
G1 X88.043 Y94.064 E.0084
G1 X87.648 Y93.849 E.0084
G1 X87.277 Y93.595 E.0084
G1 X86.932 Y93.306 E.0084
G1 X86.618 Y92.984 E.00841
G1 X86.338 Y92.633 E.0084
G1 X86.094 Y92.255 E.0084
G1 X85.889 Y91.855 E.0084
G1 X85.724 Y91.436 E.0084
G1 X85.603 Y91.004 E.0084
G1 X85.525 Y90.561 E.0084
G1 X85.491 Y90.112 E.0084
G1 X85.502 Y89.663 E.0084
G1 X85.558 Y89.217 E.0084
G1 X85.658 Y88.778 E.0084
G1 X85.801 Y88.352 E.0084
G1 X85.986 Y87.942 E.0084
G1 X86.211 Y87.553 E.0084
G1 X86.474 Y87.188 E.0084
G1 X86.771 Y86.851 E.0084
G1 X87.101 Y86.545 E.0084
G1 X87.461 Y86.272 E.00845
G1 X88.041 Y85.937 E.0125
G1 X88.457 Y85.762 E.00845
G1 X88.887 Y85.629 E.0084
G1 X89.328 Y85.54 E.0084
G1 X89.775 Y85.495 E.0084
G1 X90.225 Y85.495 E.0084
G1 X90.672 Y85.54 E.0084
G1 X91.113 Y85.629 E.0084
G1 X91.543 Y85.762 E.0084
G1 X91.957 Y85.936 E.0084
G1 X92.352 Y86.151 E.0084
G1 X92.723 Y86.405 E.0084
G1 X93.068 Y86.694 E.0084
G1 X93.382 Y87.016 E.0084
G1 X93.662 Y87.367 E.0084
G1 X93.906 Y87.745 E.0084
G1 X94.111 Y88.145 E.0084
G1 X94.275 Y88.564 E.0084
G1 X94.397 Y88.996 E.0084
G1 X94.475 Y89.439 E.0084
G1 X94.509 Y89.888 E.0084
G1 X94.497 Y90.337 E.0084
G1 X94.441 Y90.786 E.00845
G1 X94.276 Y91.434 E.0125
G1 X94.111 Y91.855 E.00845
G1 X94.015 Y92.043 E.00394
; WIPE_START
M204 S6000
G1 X93.906 Y92.255 E-.034
G1 X93.662 Y92.633 E-.06407
G1 X93.382 Y92.984 E-.06406
G1 X93.067 Y93.306 E-.06411
G1 X92.752 Y93.571 E-.05876
; WIPE_END
G1 E-.015
M204 S10000
G1 X88.505 Y87.23 Z3.72 F18000
G1 X86.238 Y83.846 Z3.72
G1 Z3.32
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F3600
M204 S6000
G1 X86.87 Y83.502 E.01446
G1 X87.532 Y83.223 E.01446
G1 X88.221 Y83.01 E.01449
G1 X88.925 Y82.868 E.01445
G1 X89.641 Y82.796 E.01445
G1 X90.36 Y82.796 E.01446
G1 X91.075 Y82.868 E.01446
G1 X91.779 Y83.01 E.01445
G1 X92.466 Y83.222 E.01445
G1 X93.129 Y83.501 E.01445
G1 X93.76 Y83.845 E.01446
G1 X94.354 Y84.25 E.01445
G1 X94.906 Y84.713 E.01449
G1 X95.408 Y85.228 E.01445
G1 X95.856 Y85.79 E.01446
G1 X96.246 Y86.394 E.01445
G1 X96.574 Y87.033 E.01445
G1 X96.837 Y87.703 E.01446
G1 X97.032 Y88.395 E.01446
G1 X97.156 Y89.103 E.01445
G1 X97.21 Y89.82 E.01446
G1 X97.192 Y90.54 E.01449
G1 X97.103 Y91.253 E.01445
G1 X96.943 Y91.954 E.01445
G1 X96.714 Y92.635 E.01446
G1 X96.418 Y93.291 E.01445
G1 X96.059 Y93.913 E.01446
G1 X95.639 Y94.497 E.01445
G1 X95.163 Y95.036 E.01446
G1 X94.637 Y95.525 E.01445
G1 X94.063 Y95.959 E.01447
G1 X93.45 Y96.334 E.01445
G1 X92.801 Y96.647 E.01449
G1 X92.125 Y96.892 E.01445
G1 X91.429 Y97.07 E.01445
G1 X90.718 Y97.177 E.01446
G1 X90 Y97.213 E.01446
G1 X89.283 Y97.177 E.01443
G1 X88.57 Y97.07 E.01449
G1 X87.874 Y96.892 E.01445
G1 X87.198 Y96.646 E.01446
G1 X86.551 Y96.335 E.01445
G1 X85.937 Y95.96 E.01445
G1 X85.364 Y95.526 E.01446
G1 X84.836 Y95.036 E.01449
G1 X84.361 Y94.498 E.01442
G1 X83.941 Y93.913 E.01449
G1 X83.581 Y93.29 E.01446
G1 X83.286 Y92.635 E.01446
G1 X83.057 Y91.955 E.01442
G1 X82.896 Y91.251 E.01453
G1 X82.807 Y90.539 E.01441
G1 X82.789 Y89.819 E.01449
G1 X82.843 Y89.104 E.01442
G1 X82.968 Y88.396 E.01445
G1 X83.163 Y87.702 E.0145
G1 X83.426 Y87.033 E.01445
G1 X83.754 Y86.393 E.01446
G1 X84.144 Y85.789 E.01445
G1 X84.592 Y85.227 E.01446
G1 X85.094 Y84.713 E.01445
G1 X85.645 Y84.251 E.01446
G1 X86.189 Y83.88 E.01324
M204 S10000
G1 X86.017 Y83.483 F18000
G1 F3600
M204 S6000
G1 X86.685 Y83.119 E.01531
G1 X87.387 Y82.823 E.01531
G1 X88.116 Y82.598 E.01534
G1 X88.862 Y82.448 E.0153
G1 X89.62 Y82.372 E.01531
G1 X90.381 Y82.372 E.01531
G1 X91.138 Y82.448 E.01531
G1 X91.884 Y82.599 E.0153
G1 X92.612 Y82.823 E.01531
G1 X93.313 Y83.119 E.01531
G1 X93.982 Y83.483 E.01531
G1 X94.611 Y83.911 E.0153
G1 X95.195 Y84.402 E.01535
G1 X95.727 Y84.947 E.0153
G1 X96.201 Y85.542 E.01531
G1 X96.614 Y86.181 E.0153
G1 X96.961 Y86.859 E.0153
G1 X97.24 Y87.567 E.01531
G1 X97.446 Y88.3 E.01531
G1 X97.578 Y89.05 E.0153
G1 X97.635 Y89.809 E.01531
G1 X97.616 Y90.572 E.01534
G1 X97.521 Y91.327 E.0153
G1 X97.352 Y92.069 E.0153
G1 X97.109 Y92.791 E.01531
G1 X96.796 Y93.484 E.01531
G1 X96.415 Y94.144 E.01531
G1 X95.971 Y94.762 E.01531
G1 X95.467 Y95.333 E.01531
G1 X94.91 Y95.85 E.0153
G1 X94.302 Y96.31 E.01532
G1 X93.653 Y96.707 E.0153
G1 X92.966 Y97.038 E.01535
G1 X92.25 Y97.298 E.01531
G1 X91.513 Y97.486 E.0153
G1 X90.76 Y97.6 E.01531
G1 X90 Y97.638 E.01531
G1 X89.241 Y97.6 E.01528
G1 X88.486 Y97.486 E.01534
G1 X87.749 Y97.298 E.0153
G1 X87.033 Y97.038 E.01531
G1 X86.347 Y96.708 E.01531
G1 X85.698 Y96.311 E.0153
G1 X85.091 Y95.851 E.01531
G1 X84.532 Y95.332 E.01534
G1 X84.029 Y94.763 E.01527
G1 X83.584 Y94.143 E.01534
G1 X83.203 Y93.484 E.01531
G1 X82.89 Y92.79 E.0153
G1 X82.648 Y92.07 E.01527
G1 X82.478 Y91.324 E.01538
G1 X82.384 Y90.571 E.01527
G1 X82.365 Y89.808 E.01535
G1 X82.422 Y89.051 E.01527
G1 X82.554 Y88.301 E.0153
G1 X82.76 Y87.567 E.01535
G1 X83.038 Y86.858 E.0153
G1 X83.386 Y86.181 E.01531
G1 X83.799 Y85.541 E.01531
G1 X84.273 Y84.946 E.01531
G1 X84.805 Y84.401 E.0153
G1 X85.388 Y83.912 E.01531
G1 X85.967 Y83.517 E.01409
M204 S250
G1 X85.788 Y83.144 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1440
M204 S5000
G1 X85.803 Y83.134 E.00035
G1 X86.507 Y82.75 E.01499
G1 X87.247 Y82.438 E.01499
G1 X88.015 Y82.201 E.01502
G1 X88.801 Y82.043 E.01499
G1 X89.599 Y81.963 E.01499
G1 X90.401 Y81.963 E.01499
G1 X91.199 Y82.043 E.01499
G1 X91.985 Y82.202 E.01498
G1 X92.752 Y82.438 E.01499
G1 X93.491 Y82.749 E.01499
G1 X94.195 Y83.133 E.01499
G1 X94.858 Y83.585 E.01498
G1 X95.474 Y84.102 E.01503
G1 X96.034 Y84.676 E.01498
G1 X96.534 Y85.303 E.01499
G1 X96.969 Y85.977 E.01498
G1 X97.335 Y86.69 E.01499
G1 X97.628 Y87.437 E.01499
G1 X97.845 Y88.209 E.01499
G1 X97.985 Y88.999 E.01499
G1 X98.045 Y89.799 E.01499
G1 X98.024 Y90.602 E.01502
G1 X97.925 Y91.398 E.01499
G1 X97.746 Y92.18 E.01499
G1 X97.491 Y92.94 E.01499
G1 X97.161 Y93.671 E.01499
G1 X96.76 Y94.366 E.01499
G1 X96.291 Y95.017 E.01499
G1 X95.761 Y95.619 E.01499
G1 X95.173 Y96.164 E.01498
G1 X94.533 Y96.649 E.015
G1 X93.849 Y97.067 E.01498
G1 X93.125 Y97.416 E.01502
G1 X92.371 Y97.69 E.01499
G1 X91.594 Y97.888 E.01498
G1 X90.801 Y98.007 E.01499
G1 X90 Y98.047 E.01499
G1 X89.2 Y98.007 E.01496
G1 X88.405 Y97.888 E.01502
G1 X87.628 Y97.69 E.01498
G1 X86.874 Y97.415 E.01499
G1 X86.151 Y97.067 E.01499
G1 X85.467 Y96.649 E.01498
G1 X84.828 Y96.165 E.01499
G1 X84.239 Y95.618 E.01502
G1 X83.709 Y95.018 E.01495
G1 X83.24 Y94.366 E.01502
G1 X82.839 Y93.671 E.01499
G1 X82.509 Y92.94 E.01499
G1 X82.254 Y92.181 E.01495
G1 X82.075 Y91.396 E.01506
G1 X81.975 Y90.602 E.01495
G1 X81.955 Y89.798 E.01503
G1 X82.015 Y89 E.01495
G1 X82.154 Y88.21 E.01499
G1 X82.372 Y87.436 E.01502
G1 X82.665 Y86.69 E.01498
G1 X83.031 Y85.976 E.01499
G1 X83.466 Y85.302 E.01499
G1 X83.966 Y84.675 E.01499
G1 X84.526 Y84.101 E.01499
G1 X85.141 Y83.585 E.01499
G1 X85.738 Y83.178 E.01351
M106 S73.95
; WIPE_START
M204 S6000
G1 X85.803 Y83.134 E-.01124
G1 X86.507 Y82.75 E-.11429
G1 X87.247 Y82.438 E-.11433
G1 X87.549 Y82.345 E-.04514
; WIPE_END
G1 E-.015 F1800
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
G1 X0 Y90.0001 ; move to safe pos
G1 X-13.0 F3000 ; move to safe pos
M400
M1004 S5 P1  ; external shutter
M400 P300
M971 S11 C11 O0
G92 E0
G1 X0 F18000
M623

; SKIPTYPE: head_wrap_detect
M622.1 S1
M1002 judge_flag g39_3rd_layer_detect_flag
M622 J1
    ; enable nozzle clog detect at 3rd layer
    


    M622.1 S1
    M1002 judge_flag g39_detection_flag
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




G1 X85.892 Y85.485
G1 Z3.32
G1 E.3 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F6000
M204 S6000
G1 X86.313 Y85.132 E.01103
G1 X86.816 Y84.789 E.01224
G1 X87.29 Y84.531 E.01085
G1 X87.334 Y84.964 E.00874
G1 X87.507 Y84.864 E.00402
G1 X88.047 Y84.636 E.01179
G1 X88.591 Y84.468 E.01145
G1 X89.149 Y84.356 E.01144
G1 X89.715 Y84.299 E.01144
G1 X90.284 Y84.299 E.01144
G1 X90.949 Y84.376 E.01346
G1 X90.978 Y84.082 E.00592
G1 X90.966 Y83.978 E.00212
G1 X91.512 Y84.084 E.01118
G1 X92.088 Y84.262 E.01213
G1 X92.649 Y84.498 E.01224
G1 X93.184 Y84.789 E.01224
G1 X93.687 Y85.132 E.01224
G1 X94.153 Y85.524 E.01225
G1 X94.415 Y85.792 E.00754
G1 X94.367 Y85.903 E.00244
G1 X94.18 Y86.121 E.00577
G1 X94.634 Y86.668 E.01429
G1 X94.943 Y87.146 E.01145
G1 X95.203 Y87.652 E.01145
G1 X95.411 Y88.182 E.01145
G1 X95.565 Y88.73 E.01143
G1 X95.664 Y89.29 E.01144
G1 X95.706 Y89.858 E.01144
G1 X95.692 Y90.427 E.01144
G1 X95.619 Y91.009 E.01179
G1 X95.417 Y91.802 E.01646
G1 X95.203 Y92.348 E.01179
G1 X94.943 Y92.854 E.01144
G1 X94.634 Y93.332 E.01144
G1 X94.28 Y93.777 E.01144
G1 X93.882 Y94.184 E.01145
G1 X93.446 Y94.55 E.01144
G1 X92.897 Y94.914 E.01324
G1 X92.846 Y95.007 E.00214
G1 X92.708 Y95.465 E.00961
G1 X92.372 Y95.627 E.00751
G1 X91.8 Y95.835 E.01224
G1 X91.21 Y95.985 E.01224
G1 X90.608 Y96.076 E.01224
G1 X90 Y96.106 E.01224
G1 X89.282 Y96.06 E.01446
G1 X89.204 Y95.918 E.00326
G1 X89.12 Y95.638 E.00586
G1 X88.591 Y95.532 E.01085
G1 X88.047 Y95.364 E.01145
G1 X87.523 Y95.143 E.01144
G1 X87.024 Y94.871 E.01144
G1 X86.553 Y94.55 E.01145
G1 X86.125 Y94.191 E.01125
G1 X85.869 Y94.487 E.00787
G1 X85.628 Y94.264 E.00659
G1 X85.226 Y93.807 E.01224
G1 X84.87 Y93.313 E.01224
G1 X84.795 Y93.182 E.00304
; WIPE_START
G1 X84.87 Y93.313 E-.02157
G1 X85.226 Y93.807 E-.08675
G1 X85.628 Y94.264 E-.08677
G1 X85.869 Y94.487 E-.04673
G1 X86.067 Y94.257 E-.04318
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X89.202 Y87.299 Z3.72 F18000
G1 X91.026 Y83.249 Z3.72
G1 Z3.32
G1 E.3 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.366333
G1 F4800
M204 S6000
G1 X90.361 Y83.181 E.01079
G1 X89.681 Y83.179 E.01099
G1 X89.003 Y83.244 E.01099
M73 P88 R1
G1 X88.335 Y83.377 E.01098
G1 X87.684 Y83.576 E.01099
G1 X87.056 Y83.838 E.01099
G1 X86.457 Y84.162 E.01099
G1 X85.893 Y84.544 E.01099
G1 X85.37 Y84.98 E.01099
G1 X84.894 Y85.466 E.01099
G1 X84.467 Y85.997 E.01099
G1 X84.096 Y86.567 E.01099
G1 X83.784 Y87.172 E.01098
G1 X83.533 Y87.805 E.01099
G1 X83.347 Y88.46 E.011
G1 X83.227 Y89.13 E.01098
G1 X83.174 Y89.809 E.01099
G1 X83.189 Y90.489 E.01099
G1 X83.271 Y91.165 E.01099
G1 X83.421 Y91.829 E.01099
G1 X83.635 Y92.475 E.01098
G1 X83.913 Y93.097 E.01099
G1 X84.252 Y93.687 E.01099
G1 X84.648 Y94.241 E.01099
G1 X85.097 Y94.753 E.01099
G1 X85.594 Y95.218 E.01099
G1 X86.136 Y95.63 E.01099
G1 X86.715 Y95.987 E.01099
G1 X87.328 Y96.284 E.01099
G1 X87.967 Y96.519 E.01099
G1 X88.626 Y96.689 E.01099
G1 X89.299 Y96.793 E.01099
G1 X89.979 Y96.829 E.01099
G1 X90.659 Y96.797 E.01099
G1 X91.332 Y96.698 E.01099
G1 X91.993 Y96.532 E.01099
G1 X92.633 Y96.301 E.01099
G1 X93.247 Y96.007 E.01099
G1 X93.829 Y95.654 E.01099
G1 X94.373 Y95.245 E.01099
G1 X94.874 Y94.783 E.01098
G1 X95.326 Y94.274 E.01099
G1 X95.725 Y93.723 E.01099
G1 X96.067 Y93.134 E.01099
G1 X96.349 Y92.515 E.01099
G1 X96.568 Y91.87 E.01099
G1 X96.721 Y91.207 E.01099
G1 X96.808 Y90.531 E.01099
G1 X96.827 Y89.838 E.0112
G1 X96.778 Y89.172 E.01078
G1 X96.662 Y88.501 E.01099
G1 X96.48 Y87.845 E.011
G1 X96.233 Y87.211 E.01099
G1 X95.924 Y86.604 E.01099
G1 X95.557 Y86.031 E.01099
G1 X95.134 Y85.497 E.01099
G1 X94.66 Y85.009 E.01099
G1 X94.14 Y84.569 E.011
G1 X93.579 Y84.184 E.01098
G1 X92.982 Y83.857 E.01099
G1 X92.355 Y83.59 E.01099
G1 X91.71 Y83.389 E.01092
G1 X91.085 Y83.261 E.01029
M204 S10000
G1 X90.899 Y83.577 F18000
; LINE_WIDTH: 0.366093
G1 F4800
M204 S6000
G1 X91.592 Y83.71 E.01137
G1 X92.207 Y83.898 E.01038
G1 X92.804 Y84.149 E.01044
G1 X93.372 Y84.457 E.01043
G1 X93.907 Y84.82 E.01043
G1 X94.404 Y85.235 E.01044
G1 X94.856 Y85.697 E.01043
G1 X95.261 Y86.202 E.01044
G1 X95.613 Y86.745 E.01044
G1 X95.909 Y87.32 E.01043
G1 X96.146 Y87.921 E.01043
G1 X96.323 Y88.544 E.01044
G1 X96.436 Y89.181 E.01043
G1 X96.486 Y89.826 E.01043
G1 X96.471 Y90.472 E.01043
G1 X96.392 Y91.114 E.01044
G1 X96.249 Y91.745 E.01044
G1 X96.044 Y92.359 E.01043
G1 X95.78 Y92.949 E.01043
G1 X95.457 Y93.51 E.01043
G1 X95.081 Y94.036 E.01043
G1 X94.654 Y94.522 E.01044
G1 X94.18 Y94.962 E.01043
G1 X93.666 Y95.354 E.01043
G1 X93.114 Y95.692 E.01044
G1 X92.532 Y95.974 E.01044
G1 X91.925 Y96.197 E.01043
G1 X91.298 Y96.357 E.01043
G1 X90.659 Y96.455 E.01043
G1 X90.013 Y96.489 E.01044
G1 X89.367 Y96.458 E.01043
G1 X88.727 Y96.362 E.01043
G1 X88.099 Y96.204 E.01044
G1 X87.491 Y95.984 E.01043
G1 X86.898 Y95.7 E.01061
G1 X86.355 Y95.368 E.01027
G1 X85.839 Y94.979 E.01043
G1 X85.364 Y94.54 E.01043
G1 X84.935 Y94.055 E.01044
G1 X84.556 Y93.531 E.01043
G1 X84.232 Y92.971 E.01043
G1 X83.964 Y92.382 E.01044
G1 X83.757 Y91.77 E.01043
G1 X83.612 Y91.14 E.01043
G1 X83.53 Y90.498 E.01044
G1 X83.513 Y89.851 E.01043
G1 X83.56 Y89.206 E.01043
G1 X83.671 Y88.569 E.01043
G1 X83.845 Y87.945 E.01044
G1 X84.08 Y87.343 E.01043
G1 X84.374 Y86.767 E.01043
G1 X84.724 Y86.223 E.01043
G1 X85.126 Y85.716 E.01044
G1 X85.577 Y85.252 E.01043
G1 X86.072 Y84.835 E.01044
G1 X86.606 Y84.47 E.01044
G1 X87.173 Y84.16 E.01043
G1 X87.769 Y83.907 E.01043
G1 X88.387 Y83.715 E.01044
G1 X89.02 Y83.586 E.01043
G1 X89.664 Y83.52 E.01044
G1 X90.311 Y83.519 E.01044
G1 X90.84 Y83.571 E.00857
; CHANGE_LAYER
; Z_HEIGHT: 3.44
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F4800
G1 X90.311 Y83.519 E-.07573
G1 X89.664 Y83.52 E-.09219
G1 X89.02 Y83.586 E-.0922
G1 X88.849 Y83.621 E-.02488
; WIPE_END
G1 E-.015 F1800
; layer num/total_layer_count: 28/33
; update layer progress
M73 L28
M991 S0 P27 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z3.72 I-1.016 J.67 P1  F18000
G1 X94.711 Y92.516 Z3.72
G1 Z3.44
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F3600
M204 S6000
G1 X94.49 Y92.9 E.00891
G1 X94.178 Y93.333 E.01072
G1 X93.826 Y93.732 E.01071
G1 X93.435 Y94.094 E.01072
G1 X93.011 Y94.416 E.01072
G1 X92.556 Y94.694 E.01071
G1 X92.076 Y94.925 E.01071
G1 X91.575 Y95.107 E.01072
G1 X91.046 Y95.242 E.01097
G1 X90.279 Y95.338 E.01554
G1 X89.733 Y95.338 E.01097
G1 X89.203 Y95.285 E.01071
G1 X88.681 Y95.18 E.01071
G1 X88.172 Y95.022 E.01071
G1 X87.681 Y94.815 E.01072
G1 X87.213 Y94.561 E.01071
G1 X86.773 Y94.26 E.01071
G1 X86.364 Y93.918 E.01072
G1 X85.992 Y93.537 E.01071
G1 X85.66 Y93.12 E.01072
G1 X85.371 Y92.672 E.01071
G1 X85.128 Y92.198 E.01072
G1 X84.933 Y91.702 E.01071
G1 X84.789 Y91.19 E.01071
G1 X84.697 Y90.665 E.01072
G1 X84.657 Y90.133 E.01071
G1 X84.67 Y89.601 E.01071
G1 X84.736 Y89.072 E.01071
G1 X84.855 Y88.552 E.01072
G1 X85.025 Y88.047 E.01071
G1 X85.244 Y87.561 E.01072
G1 X85.51 Y87.1 E.01071
G1 X85.821 Y86.668 E.01072
G1 X86.174 Y86.268 E.01071
G1 X86.564 Y85.906 E.01071
G1 X86.999 Y85.576 E.01098
G1 X87.669 Y85.19 E.01554
G1 X88.172 Y84.978 E.01098
G1 X88.681 Y84.82 E.01072
G1 X89.203 Y84.715 E.01071
G1 X89.733 Y84.662 E.01071
G1 X90.266 Y84.662 E.01071
G1 X90.796 Y84.715 E.01071
G1 X91.319 Y84.821 E.01071
G1 X91.828 Y84.978 E.01071
G1 X92.319 Y85.185 E.01072
G1 X92.787 Y85.439 E.01071
G1 X93.227 Y85.74 E.01072
G1 X93.635 Y86.082 E.01071
G1 X94.007 Y86.463 E.01071
G1 X94.34 Y86.88 E.01072
G1 X94.628 Y87.328 E.0107
G1 X94.872 Y87.802 E.01072
G1 X95.066 Y88.298 E.01071
G1 X95.211 Y88.81 E.01071
G1 X95.303 Y89.335 E.01072
G1 X95.343 Y89.867 E.01071
G1 X95.33 Y90.399 E.01071
G1 X95.263 Y90.928 E.01071
G1 X95.145 Y91.448 E.01072
G1 X94.975 Y91.953 E.01071
G1 X94.756 Y92.438 E.01072
G1 X94.741 Y92.464 E.0006
M204 S10000
G1 X94.344 Y92.304 F18000
G1 F3600
M204 S6000
G1 X94.133 Y92.669 E.00848
G1 X93.846 Y93.068 E.00987
G1 X93.522 Y93.435 E.00986
G1 X93.162 Y93.769 E.00986
G1 X92.771 Y94.065 E.00986
G1 X92.353 Y94.321 E.00986
G1 X91.911 Y94.534 E.00986
G1 X91.45 Y94.701 E.00987
G1 X90.967 Y94.824 E.01002
G1 X90.253 Y94.914 E.01448
G1 X89.755 Y94.914 E.01002
G1 X89.267 Y94.865 E.00986
G1 X88.786 Y94.768 E.00986
G1 X88.317 Y94.623 E.00986
G1 X87.865 Y94.433 E.00987
G1 X87.434 Y94.198 E.00986
G1 X87.029 Y93.922 E.00986
G1 X86.653 Y93.607 E.00986
G1 X86.311 Y93.255 E.00986
G1 X86.005 Y92.872 E.00986
G1 X85.739 Y92.46 E.00986
G1 X85.515 Y92.024 E.00986
G1 X85.336 Y91.567 E.00986
G1 X85.203 Y91.095 E.00986
G1 X85.118 Y90.612 E.00987
G1 X85.081 Y90.123 E.00986
G1 X85.094 Y89.632 E.00986
G1 X85.155 Y89.146 E.00986
G1 X85.264 Y88.667 E.00987
G1 X85.42 Y88.202 E.00986
G1 X85.622 Y87.755 E.00986
G1 X85.867 Y87.331 E.00986
G1 X86.153 Y86.932 E.00987
G1 X86.478 Y86.565 E.00986
G1 X86.837 Y86.231 E.00986
G1 X87.234 Y85.93 E.01002
G1 X87.858 Y85.57 E.01448
G1 X88.317 Y85.377 E.01002
G1 X88.786 Y85.232 E.00987
G1 X89.267 Y85.135 E.00986
G1 X89.755 Y85.086 E.00986
G1 X90.245 Y85.086 E.00986
G1 X90.733 Y85.135 E.00986
G1 X91.214 Y85.232 E.00986
G1 X91.683 Y85.377 E.00986
G1 X92.135 Y85.567 E.00986
G1 X92.565 Y85.802 E.00986
G1 X92.971 Y86.078 E.00986
G1 X93.346 Y86.393 E.00986
G1 X93.689 Y86.745 E.00986
G1 X93.995 Y87.128 E.00987
G1 X94.261 Y87.54 E.00986
G1 X94.485 Y87.977 E.00987
G1 X94.664 Y88.433 E.00986
G1 X94.796 Y88.905 E.00986
G1 X94.882 Y89.388 E.00986
G1 X94.918 Y89.877 E.00986
G1 X94.906 Y90.368 E.00986
G1 X94.845 Y90.854 E.00986
G1 X94.736 Y91.333 E.00987
G1 X94.58 Y91.797 E.00986
G1 X94.378 Y92.245 E.00986
G1 X94.374 Y92.252 E.00017
M204 S250
G1 X93.989 Y92.099 F18000
M106 S229.5
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1800
M204 S5000
G1 X93.789 Y92.447 E.0075
G1 X93.526 Y92.812 E.0084
G1 X93.229 Y93.149 E.0084
G1 X92.899 Y93.455 E.0084
G1 X92.54 Y93.727 E.0084
G1 X92.157 Y93.961 E.0084
G1 X91.752 Y94.156 E.0084
G1 X91.329 Y94.31 E.0084
G1 X90.891 Y94.421 E.00845
G1 X90.227 Y94.505 E.0125
G1 X89.775 Y94.505 E.00845
G1 X89.328 Y94.46 E.0084
G1 X88.887 Y94.371 E.0084
G1 X88.457 Y94.238 E.0084
G1 X88.043 Y94.064 E.0084
G1 X87.648 Y93.848 E.0084
G1 X87.276 Y93.595 E.0084
G1 X86.932 Y93.306 E.0084
G1 X86.618 Y92.984 E.0084
G1 X86.338 Y92.633 E.0084
G1 X86.094 Y92.255 E.0084
G1 X85.889 Y91.855 E.0084
G1 X85.724 Y91.436 E.0084
G1 X85.603 Y91.004 E.0084
G1 X85.525 Y90.561 E.0084
G1 X85.491 Y90.112 E.0084
G1 X85.502 Y89.663 E.0084
G1 X85.558 Y89.217 E.0084
G1 X85.658 Y88.778 E.00841
G1 X85.801 Y88.352 E.0084
G1 X85.986 Y87.942 E.0084
G1 X86.211 Y87.553 E.0084
G1 X86.474 Y87.188 E.00841
G1 X86.771 Y86.851 E.0084
G1 X87.101 Y86.545 E.0084
G1 X87.461 Y86.272 E.00845
G1 X88.04 Y85.937 E.0125
G1 X88.457 Y85.762 E.00845
G1 X88.887 Y85.629 E.0084
G1 X89.328 Y85.54 E.0084
G1 X89.775 Y85.495 E.0084
G1 X90.225 Y85.495 E.0084
G1 X90.672 Y85.54 E.0084
G1 X91.113 Y85.629 E.0084
G1 X91.542 Y85.762 E.0084
G1 X91.957 Y85.936 E.0084
G1 X92.352 Y86.151 E.0084
G1 X92.723 Y86.405 E.0084
G1 X93.068 Y86.694 E.0084
G1 X93.382 Y87.016 E.0084
G1 X93.662 Y87.367 E.0084
G1 X93.906 Y87.745 E.0084
G1 X94.111 Y88.145 E.0084
G1 X94.275 Y88.564 E.0084
G1 X94.397 Y88.996 E.0084
G1 X94.475 Y89.439 E.0084
G1 X94.509 Y89.888 E.00841
G1 X94.497 Y90.337 E.0084
G1 X94.442 Y90.783 E.0084
G1 X94.342 Y91.222 E.0084
G1 X94.198 Y91.648 E.0084
G1 X94.018 Y92.047 E.00818
; WIPE_START
M204 S6000
G1 X93.789 Y92.447 E-.06576
G1 X93.526 Y92.812 E-.06408
G1 X93.229 Y93.149 E-.06406
G1 X92.899 Y93.455 E-.06406
G1 X92.748 Y93.57 E-.02703
; WIPE_END
G1 E-.015
M204 S10000
G1 X88.494 Y87.232 Z3.84 F18000
G1 X86.135 Y83.716 Z3.84
G1 Z3.44
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F3600
M204 S6000
G1 X86.769 Y83.368 E.01455
G1 X87.434 Y83.083 E.01455
G1 X88.219 Y82.841 E.01651
G1 X88.929 Y82.701 E.01455
G1 X89.652 Y82.631 E.01461
G1 X90.378 Y82.632 E.0146
G1 X91.101 Y82.705 E.01461
G1 X91.814 Y82.849 E.01461
G1 X92.508 Y83.062 E.01461
G1 X93.179 Y83.342 E.01461
G1 X93.818 Y83.687 E.0146
G1 X94.418 Y84.092 E.01456
G1 X95.047 Y84.62 E.01651
G1 X95.55 Y85.14 E.01454
G1 X96.001 Y85.709 E.01461
G1 X96.394 Y86.32 E.01461
G1 X96.725 Y86.967 E.01461
G1 X96.991 Y87.643 E.01461
G1 X97.189 Y88.343 E.01462
G1 X97.317 Y89.058 E.01461
G1 X97.374 Y89.783 E.01462
G1 X97.36 Y90.506 E.01455
G1 X97.258 Y91.322 E.01653
G1 X97.093 Y92.027 E.01456
G1 X96.86 Y92.716 E.01462
G1 X96.559 Y93.378 E.01462
G1 X96.195 Y94.007 E.01461
G1 X95.77 Y94.597 E.01462
G1 X95.29 Y95.143 E.01462
G1 X94.758 Y95.638 E.01462
G1 X94.18 Y96.079 E.01461
G1 X93.564 Y96.459 E.01455
G1 X92.825 Y96.815 E.0165
G1 X92.144 Y97.059 E.01454
G1 X91.44 Y97.236 E.01459
G1 X90.723 Y97.342 E.01458
G1 X89.999 Y97.378 E.01459
G1 X89.338 Y97.347 E.01329
G1 X88.526 Y97.229 E.01651
G1 X87.826 Y97.05 E.01452
G1 X87.143 Y96.802 E.01462
G1 X86.574 Y96.531 E.01268
G1 X85.863 Y96.109 E.01661
G1 X85.361 Y95.733 E.01261
G1 X84.636 Y95.062 E.01986
G1 X84.211 Y94.573 E.01303
G1 X83.788 Y93.98 E.01464
G1 X83.427 Y93.35 E.01461
G1 X83.129 Y92.687 E.01462
G1 X82.898 Y91.998 E.01461
G1 X82.735 Y91.288 E.01463
G1 X82.644 Y90.571 E.01454
G1 X82.627 Y89.749 E.01653
G1 X82.687 Y89.028 E.01456
G1 X82.818 Y88.313 E.01462
G1 X83.019 Y87.614 E.01461
G1 X83.287 Y86.939 E.01461
G1 X83.621 Y86.293 E.01462
G1 X84.016 Y85.684 E.01461
G1 X84.47 Y85.116 E.01461
G1 X84.977 Y84.596 E.01461
G1 X85.533 Y84.128 E.01461
G1 X86.085 Y83.75 E.01346
M204 S10000
G1 X85.931 Y83.344 F18000
G1 F3600
M204 S6000
G1 X86.583 Y82.986 E.01497
G1 X87.288 Y82.684 E.01541
G1 X88.115 Y82.429 E.0174
G1 X88.867 Y82.28 E.01542
G1 X89.632 Y82.206 E.01545
G1 X90.4 Y82.208 E.01544
G1 X91.165 Y82.285 E.01545
G1 X91.918 Y82.437 E.01545
G1 X92.653 Y82.662 E.01545
G1 X93.362 Y82.959 E.01545
G1 X94.037 Y83.324 E.01544
G1 X94.673 Y83.753 E.01542
G1 X95.337 Y84.309 E.0174
G1 X95.87 Y84.86 E.01541
G1 X96.347 Y85.462 E.01545
G1 X96.763 Y86.108 E.01545
G1 X97.113 Y86.792 E.01545
G1 X97.394 Y87.508 E.01545
G1 X97.603 Y88.248 E.01546
G1 X97.738 Y89.004 E.01545
G1 X97.799 Y89.77 E.01546
G1 X97.783 Y90.537 E.01542
G1 X97.676 Y91.397 E.01742
G1 X97.502 Y92.144 E.01543
G1 X97.254 Y92.872 E.01546
G1 X96.937 Y93.572 E.01546
G1 X96.551 Y94.237 E.01546
G1 X96.103 Y94.862 E.01546
G1 X95.594 Y95.439 E.01546
G1 X95.032 Y95.963 E.01546
G1 X94.42 Y96.429 E.01546
G1 X93.768 Y96.832 E.01541
G1 X92.989 Y97.207 E.01739
G1 X92.267 Y97.465 E.01541
G1 X91.523 Y97.652 E.01543
G1 X90.765 Y97.765 E.01542
G1 X89.999 Y97.803 E.01542
G1 X89.298 Y97.77 E.01411
G1 X88.442 Y97.645 E.01738
G1 X87.701 Y97.456 E.01538
G1 X86.979 Y97.194 E.01546
G1 X86.373 Y96.906 E.01348
G1 X85.627 Y96.462 E.01746
G1 X85.092 Y96.061 E.01344
G1 X84.51 Y95.54 E.01571
G1 X84.325 Y95.35 E.00534
G1 X83.877 Y94.836 E.01369
G1 X83.431 Y94.21 E.01548
G1 X83.048 Y93.543 E.01546
G1 X82.733 Y92.841 E.01546
G1 X82.489 Y92.113 E.01545
G1 X82.317 Y91.363 E.01547
G1 X82.221 Y90.602 E.01541
G1 X82.203 Y89.736 E.01742
G1 X82.266 Y88.972 E.01542
G1 X82.405 Y88.216 E.01546
G1 X82.617 Y87.477 E.01545
G1 X82.901 Y86.763 E.01545
G1 X83.254 Y86.08 E.01546
G1 X83.672 Y85.436 E.01545
G1 X84.151 Y84.835 E.01545
G1 X84.688 Y84.285 E.01545
G1 X85.276 Y83.79 E.01546
G1 X85.88 Y83.376 E.01472
M204 S250
G1 X85.733 Y82.986 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1440
M204 S5000
G1 X86.404 Y82.617 E.01429
G1 X87.147 Y82.3 E.0151
G1 X88.015 Y82.032 E.01697
G1 X88.807 Y81.875 E.0151
G1 X89.613 Y81.797 E.01512
G1 X90.421 Y81.799 E.01511
M106 S73.95
M106 S229.5
G1 X91.226 Y81.88 E.01512
G1 X92.019 Y82.04 E.01511
G1 X92.792 Y82.277 E.01511
G1 X93.538 Y82.589 E.01511
G1 X94.25 Y82.973 E.01511
G1 X94.92 Y83.425 E.01511
G1 X95.616 Y84.009 E.01698
G1 X96.178 Y84.59 E.0151
G1 X96.68 Y85.224 E.01511
G1 X97.118 Y85.904 E.01511
G1 X97.486 Y86.624 E.01511
G1 X97.782 Y87.377 E.01512
G1 X98.002 Y88.156 E.01512
G1 X98.145 Y88.952 E.01511
G1 X98.208 Y89.758 E.01512
G1 X98.192 Y90.567 E.01511
G1 X98.079 Y91.469 E.01699
G1 X97.896 Y92.256 E.01511
G1 X97.635 Y93.023 E.01512
G1 X97.301 Y93.76 E.01512
G1 X96.895 Y94.46 E.01512
G1 X96.423 Y95.117 E.01512
G1 X95.888 Y95.724 E.01512
G1 X95.296 Y96.276 E.01512
G1 X94.653 Y96.767 E.01512
G1 X93.965 Y97.191 E.0151
G1 X93.147 Y97.585 E.01696
G1 X92.387 Y97.858 E.01509
G1 X91.603 Y98.054 E.01509
G1 X90.805 Y98.173 E.01508
G1 X89.999 Y98.212 E.01507
G1 X89.259 Y98.178 E.01385
G1 X88.362 Y98.047 E.01693
G1 X87.58 Y97.848 E.01508
G1 X86.82 Y97.572 E.01511
G1 X86.18 Y97.267 E.01325
M106 S73.95
M106 S229.5
G1 F1560
G1 X85.399 Y96.802 E.01699
M106 S73.95
M106 S229.5
G1 F1440
G1 X84.832 Y96.378 E.01323
M106 S73.95
M106 S229.5
G1 F1560
G1 X84.227 Y95.835 E.01519
G1 X84.024 Y95.627 E.00543
M106 S73.95
M106 S229.5
G1 F1440
G1 X83.556 Y95.09 E.01331
G1 X83.086 Y94.431 E.01513
G1 X82.683 Y93.729 E.01512
G1 X82.352 Y92.991 E.01512
G1 X82.094 Y92.224 E.01512
G1 X81.914 Y91.434 E.01513
G1 X81.812 Y90.632 E.01511
G1 X81.793 Y89.724 E.01699
G1 X81.86 Y88.918 E.0151
G1 X82.006 Y88.122 E.01512
G1 X82.229 Y87.345 E.01511
G1 X82.528 Y86.593 E.01511
G1 X82.899 Y85.874 E.01512
G1 X83.339 Y85.196 E.01511
G1 X83.844 Y84.564 E.01511
G1 X84.409 Y83.985 E.01511
G1 X85.028 Y83.464 E.01512
G1 X85.682 Y83.016 E.01481
M106 S73.95
; WIPE_START
M204 S6000
G1 X86.404 Y82.617 E-.11752
G1 X87.147 Y82.3 E-.11515
G1 X87.498 Y82.191 E-.05233
; WIPE_END
G1 E-.015 F1800
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
G1 X0 Y90.0001 ; move to safe pos
G1 X-13.0 F3000 ; move to safe pos
M400
M1004 S5 P1  ; external shutter
M400 P300
M971 S11 C11 O0
G92 E0
G1 X0 F18000
M623

; SKIPTYPE: head_wrap_detect
M622.1 S1
M1002 judge_flag g39_3rd_layer_detect_flag
M622 J1
    ; enable nozzle clog detect at 3rd layer
    


    M622.1 S1
    M1002 judge_flag g39_detection_flag
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




G1 X85.932 Y85.998
G1 Z3.44
G1 E.3 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F6000
M204 S6000
M73 P89 R1
G1 X86.331 Y85.627 E.01094
G1 X86.798 Y85.273 E.0118
G1 X87.289 Y84.99 E.01138
G1 X87.278 Y84.538 E.0091
G1 X87.24 Y84.371 E.00344
G1 X87.279 Y84.35 E.00089
G1 X87.855 Y84.107 E.01257
G1 X88.452 Y83.922 E.01257
G1 X89.065 Y83.799 E.01257
G1 X89.687 Y83.736 E.01257
G1 X90.313 Y83.736 E.01258
G1 X90.872 Y83.792 E.01131
G1 X90.93 Y84.082 E.00595
G1 X90.923 Y84.37 E.00579
G1 X91.408 Y84.468 E.00995
G1 X91.952 Y84.636 E.01144
G1 X92.477 Y84.857 E.01144
G1 X92.976 Y85.129 E.01144
G1 X93.447 Y85.45 E.01145
G1 X93.882 Y85.816 E.01144
G1 X94.115 Y86.054 E.00669
G1 X94.247 Y85.903 E.00403
G1 X94.422 Y85.563 E.00769
G1 X94.702 Y85.85 E.00807
G1 X95.092 Y86.339 E.01257
G1 X95.452 Y86.904 E.01348
; WIPE_START
G1 X95.092 Y86.339 E-.0955
G1 X94.702 Y85.85 E-.08908
G1 X94.422 Y85.563 E-.05721
G1 X94.283 Y85.833 E-.04321
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X94.185 Y93.465 Z3.84 F18000
G1 X94.18 Y93.879 Z3.84
G1 Z3.44
G1 E.3 F1800
G1 F6000
M204 S6000
G1 X93.669 Y94.373 E.01428
G1 X93.215 Y94.716 E.01144
G1 X92.859 Y94.934 E.00839
G1 X92.825 Y95.007 E.00163
G1 X92.722 Y95.462 E.00938
G1 X92.718 Y95.643 E.00363
G1 X92.436 Y95.779 E.0063
G1 X91.848 Y95.993 E.01257
G1 X91.242 Y96.147 E.01257
G1 X90.624 Y96.24 E.01257
G1 X90 Y96.271 E.01257
G1 X89.375 Y96.24 E.01257
G1 X89.331 Y96.234 E.00091
G1 X89.184 Y95.918 E.00701
G1 X89.121 Y95.639 E.00575
G1 X88.591 Y95.532 E.01086
G1 X88.047 Y95.364 E.01144
G1 X87.523 Y95.143 E.01145
G1 X87.023 Y94.871 E.01144
G1 X86.553 Y94.55 E.01144
G1 X86.073 Y94.139 E.01272
G1 X85.737 Y94.589 E.0113
G1 X85.51 Y94.379 E.00621
G1 X85.097 Y93.91 E.01257
G1 X84.663 Y93.283 E.01533
; WIPE_START
G1 X85.097 Y93.91 E-.10863
G1 X85.51 Y94.379 E-.08911
G1 X85.737 Y94.589 E-.044
G1 X85.918 Y94.346 E-.04326
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X85.494 Y95.338 Z3.84 F18000
G1 Z3.44
G1 E.3 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.366144
G1 F4800
M204 S6000
G1 X86.044 Y95.766 E.01125
G1 X86.641 Y96.128 E.01126
G1 X87.264 Y96.437 E.01122
G1 X87.918 Y96.677 E.01124
G1 X88.592 Y96.851 E.01122
G1 X89.284 Y96.954 E.01128
G1 X89.979 Y96.994 E.01124
G1 X90.675 Y96.962 E.01124
G1 X91.357 Y96.861 E.01112
G1 X92.024 Y96.695 E.01109
G1 X92.668 Y96.464 E.01104
G1 X93.325 Y96.15 E.01175
G1 X93.922 Y95.789 E.01126
G1 X94.479 Y95.37 E.01125
G1 X94.992 Y94.898 E.01124
G1 X95.455 Y94.377 E.01125
G1 X95.863 Y93.812 E.01124
G1 X96.214 Y93.21 E.01125
G1 X96.5 Y92.582 E.01112
G1 X96.722 Y91.93 E.01112
G1 X96.878 Y91.263 E.01104
G1 X96.97 Y90.543 E.01171
G1 X96.991 Y89.802 E.01196
G1 X96.941 Y89.151 E.01054
G1 X96.822 Y88.464 E.01124
G1 X96.636 Y87.792 E.01125
G1 X96.383 Y87.143 E.01124
G1 X96.068 Y86.521 E.01124
G1 X95.694 Y85.939 E.01116
G1 X95.267 Y85.399 E.01111
G1 X94.792 Y84.906 E.01103
G1 X94.238 Y84.439 E.01169
G1 X93.663 Y84.044 E.01126
G1 X93.052 Y83.708 E.01124
G1 X92.411 Y83.436 E.01125
G1 X91.746 Y83.228 E.01124
G1 X91.063 Y83.087 E.01124
G1 X90.37 Y83.016 E.01125
G1 X89.679 Y83.013 E.01115
G1 X88.993 Y83.079 E.01111
G1 X88.322 Y83.211 E.01104
G1 X87.628 Y83.423 E.0117
G1 X86.984 Y83.691 E.01125
G1 X86.371 Y84.022 E.01124
G1 X85.794 Y84.413 E.01124
G1 X85.258 Y84.859 E.01125
G1 X84.77 Y85.357 E.01125
G1 X84.333 Y85.9 E.01124
G1 X83.957 Y86.479 E.01114
G1 X83.64 Y87.091 E.01112
G1 X83.384 Y87.731 E.01111
G1 X83.194 Y88.392 E.01111
G1 X83.069 Y89.07 E.01112
G1 X83.011 Y89.752 E.01105
G1 X83.025 Y90.501 E.01208
G1 X83.109 Y91.194 E.01126
G1 X83.262 Y91.874 E.01124
G1 X83.481 Y92.536 E.01125
G1 X83.764 Y93.169 E.01119
G1 X84.106 Y93.766 E.01111
G1 X84.507 Y94.329 E.01114
G1 X84.906 Y94.788 E.00981
G1 X85.45 Y95.297 E.01203
M204 S10000
G1 X85.819 Y95.171 F18000
; LINE_WIDTH: 0.365892
G1 F4800
M204 S6000
G1 X85.247 Y94.653 E.01243
G1 X84.806 Y94.158 E.01069
G1 X84.418 Y93.621 E.01069
G1 X84.085 Y93.047 E.0107
G1 X83.811 Y92.443 E.01069
G1 X83.598 Y91.814 E.01069
G1 X83.449 Y91.168 E.01069
G1 X83.366 Y90.51 E.0107
G1 X83.349 Y89.847 E.01069
G1 X83.397 Y89.185 E.01069
G1 X83.511 Y88.532 E.01069
G1 X83.689 Y87.893 E.0107
G1 X83.93 Y87.275 E.01069
G1 X84.232 Y86.684 E.01069
G1 X84.59 Y86.126 E.01069
G1 X85.003 Y85.607 E.01069
G1 X85.465 Y85.131 E.01069
G1 X85.972 Y84.704 E.01069
G1 X86.518 Y84.33 E.01067
G1 X87.093 Y84.015 E.01056
G1 X87.692 Y83.76 E.01049
G1 X88.346 Y83.556 E.01105
G1 X88.995 Y83.423 E.01069
G1 X89.655 Y83.356 E.01069
G1 X90.319 Y83.354 E.0107
G1 X90.979 Y83.419 E.01069
G1 X91.629 Y83.549 E.01069
G1 X92.264 Y83.743 E.01069
G1 X92.874 Y83.999 E.01067
G1 X93.449 Y84.311 E.01055
G1 X93.989 Y84.675 E.01049
G1 X94.516 Y85.114 E.01106
G1 X94.98 Y85.588 E.01069
G1 X95.394 Y86.106 E.01069
G1 X95.756 Y86.662 E.0107
G1 X96.059 Y87.252 E.01069
G1 X96.303 Y87.869 E.01069
G1 X96.484 Y88.507 E.0107
G1 X96.6 Y89.158 E.01066
G1 X96.651 Y89.812 E.01057
G1 X96.637 Y90.462 E.01049
G1 X96.554 Y91.143 E.01105
G1 X96.408 Y91.79 E.01069
G1 X96.198 Y92.419 E.0107
G1 X95.926 Y93.024 E.01069
G1 X95.596 Y93.599 E.0107
G1 X95.21 Y94.138 E.01069
G1 X94.772 Y94.637 E.0107
G1 X94.287 Y95.089 E.01069
G1 X93.763 Y95.487 E.0106
G1 X93.209 Y95.828 E.01049
G1 X92.596 Y96.126 E.01099
G1 X91.973 Y96.354 E.01069
G1 X91.331 Y96.519 E.01069
G1 X90.675 Y96.619 E.01069
G1 X90.013 Y96.654 E.01069
G1 X89.4 Y96.625 E.00989
G1 X88.694 Y96.524 E.0115
G1 X88.051 Y96.362 E.01069
G1 X87.427 Y96.136 E.0107
G1 X86.909 Y95.888 E.00926
G1 X86.262 Y95.505 E.01212
G1 X85.867 Y95.207 E.00798
; CHANGE_LAYER
; Z_HEIGHT: 3.56
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F4800
G1 X86.262 Y95.505 E-.0705
G1 X86.909 Y95.888 E-.10711
G1 X87.427 Y96.136 E-.08189
G1 X87.595 Y96.197 E-.0255
; WIPE_END
G1 E-.015 F1800
; layer num/total_layer_count: 29/33
; update layer progress
M73 L29
M991 S0 P28 ;notify layer change
M106 S71.4
; OBJECT_ID: 8
M204 S10000
G17
G3 Z3.84 I.559 J1.081 P1  F18000
G1 X94.71 Y92.518 Z3.84
G1 Z3.56
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F3600
M204 S6000
G1 X94.49 Y92.9 E.00886
G1 X94.178 Y93.333 E.01072
G1 X93.826 Y93.732 E.01071
G1 X93.436 Y94.094 E.01071
G1 X93.011 Y94.416 E.01071
G1 X92.556 Y94.694 E.01072
G1 X92.076 Y94.925 E.01071
G1 X91.575 Y95.107 E.01072
G1 X91.046 Y95.242 E.01097
G1 X90.279 Y95.338 E.01554
G1 X89.733 Y95.338 E.01097
G1 X89.203 Y95.285 E.01071
G1 X88.681 Y95.18 E.01071
G1 X88.172 Y95.022 E.01072
G1 X87.681 Y94.815 E.01072
G1 X87.213 Y94.561 E.01071
G1 X86.771 Y94.259 E.01075
G1 X86.346 Y93.9 E.01119
G1 X85.992 Y93.536 E.01021
G1 X85.66 Y93.12 E.0107
G1 X85.371 Y92.672 E.01071
G1 X85.128 Y92.198 E.01072
G1 X84.933 Y91.702 E.01071
G1 X84.789 Y91.19 E.01071
G1 X84.697 Y90.665 E.01072
G1 X84.657 Y90.133 E.01071
G1 X84.67 Y89.601 E.01071
G1 X84.736 Y89.072 E.01071
G1 X84.855 Y88.552 E.01072
G1 X85.024 Y88.048 E.0107
G1 X85.244 Y87.562 E.01072
G1 X85.51 Y87.1 E.01071
G1 X85.821 Y86.667 E.01072
G1 X86.174 Y86.268 E.01071
G1 X86.564 Y85.906 E.01072
G1 X86.999 Y85.576 E.01097
G1 X87.669 Y85.19 E.01555
G1 X88.172 Y84.978 E.01098
G1 X88.681 Y84.82 E.01072
G1 X89.203 Y84.715 E.01071
G1 X89.733 Y84.662 E.01071
G1 X90.266 Y84.662 E.01071
G1 X90.796 Y84.715 E.01071
G1 X91.319 Y84.82 E.01071
G1 X91.828 Y84.978 E.01072
G1 X92.319 Y85.185 E.01072
G1 X92.786 Y85.439 E.0107
G1 X93.227 Y85.74 E.01072
G1 X93.635 Y86.082 E.01072
G1 X94.007 Y86.463 E.01071
G1 X94.34 Y86.88 E.01072
G1 X94.629 Y87.328 E.01071
G1 X94.872 Y87.802 E.01072
G1 X95.066 Y88.298 E.01072
G1 X95.211 Y88.81 E.0107
G1 X95.303 Y89.335 E.01072
G1 X95.343 Y89.867 E.01071
G1 X95.33 Y90.399 E.01071
G1 X95.263 Y90.928 E.01071
G1 X95.145 Y91.448 E.01072
G1 X94.975 Y91.953 E.01071
G1 X94.756 Y92.438 E.01072
G1 X94.74 Y92.466 E.00064
M204 S10000
G1 X94.343 Y92.306 F18000
G1 F3600
M204 S6000
G1 X94.133 Y92.669 E.00844
G1 X93.846 Y93.068 E.00987
G1 X93.522 Y93.435 E.00986
G1 X93.162 Y93.769 E.00986
G1 X92.772 Y94.065 E.00986
G1 X92.353 Y94.321 E.00987
G1 X91.911 Y94.534 E.00986
G1 X91.45 Y94.701 E.00987
G1 X90.967 Y94.824 E.01002
G1 X90.253 Y94.914 E.01448
G1 X89.755 Y94.914 E.01002
G1 X89.267 Y94.865 E.00986
G1 X88.786 Y94.768 E.00986
G1 X88.317 Y94.623 E.00986
G1 X87.865 Y94.433 E.00986
G1 X87.434 Y94.198 E.00986
G1 X87.028 Y93.921 E.00989
G1 X86.636 Y93.589 E.01033
G1 X86.311 Y93.255 E.00938
G1 X86.005 Y92.872 E.00986
G1 X85.739 Y92.46 E.00986
G1 X85.515 Y92.024 E.00986
G1 X85.336 Y91.567 E.00986
G1 X85.203 Y91.095 E.00986
G1 X85.118 Y90.612 E.00986
G1 X85.081 Y90.123 E.00986
G1 X85.094 Y89.632 E.00986
G1 X85.155 Y89.146 E.00986
G1 X85.264 Y88.667 E.00987
G1 X85.42 Y88.203 E.00986
G1 X85.622 Y87.755 E.00987
G1 X85.867 Y87.331 E.00986
G1 X86.153 Y86.932 E.00987
G1 X86.478 Y86.565 E.00986
G1 X86.837 Y86.231 E.00986
G1 X87.234 Y85.93 E.01001
G1 X87.858 Y85.57 E.01448
G1 X88.317 Y85.377 E.01002
G1 X88.786 Y85.232 E.00986
G1 X89.267 Y85.135 E.00986
G1 X89.755 Y85.086 E.00986
G1 X90.245 Y85.086 E.00986
G1 X90.733 Y85.135 E.00986
G1 X91.214 Y85.232 E.00986
G1 X91.683 Y85.377 E.00986
G1 X92.135 Y85.567 E.00986
G1 X92.565 Y85.802 E.00986
G1 X92.971 Y86.078 E.00987
G1 X93.346 Y86.393 E.00986
G1 X93.689 Y86.744 E.00986
G1 X93.995 Y87.128 E.00987
G1 X94.261 Y87.54 E.00986
G1 X94.484 Y87.977 E.00987
G1 X94.664 Y88.433 E.00986
G1 X94.796 Y88.905 E.00985
G1 X94.882 Y89.388 E.00987
G1 X94.918 Y89.877 E.00986
G1 X94.906 Y90.368 E.00986
G1 X94.845 Y90.854 E.00986
G1 X94.736 Y91.333 E.00986
G1 X94.58 Y91.797 E.00986
G1 X94.378 Y92.245 E.00986
G1 X94.373 Y92.254 E.00022
M204 S250
G1 X93.988 Y92.101 F18000
M106 S229.5
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1800
M204 S5000
G1 X93.789 Y92.447 E.00746
G1 X93.526 Y92.812 E.00841
G1 X93.229 Y93.149 E.0084
G1 X92.899 Y93.455 E.0084
G1 X92.541 Y93.726 E.0084
G1 X92.157 Y93.961 E.00841
G1 X91.752 Y94.156 E.0084
G1 X91.329 Y94.31 E.0084
G1 X90.891 Y94.422 E.00845
G1 X90.227 Y94.505 E.0125
G1 X89.775 Y94.505 E.00845
G1 X89.328 Y94.46 E.0084
G1 X88.887 Y94.371 E.0084
G1 X88.457 Y94.238 E.0084
G1 X88.043 Y94.064 E.0084
G1 X87.648 Y93.849 E.0084
G1 X87.276 Y93.595 E.00841
G1 X86.915 Y93.29 E.00883
G1 X86.618 Y92.984 E.00796
G1 X86.338 Y92.633 E.0084
G1 X86.094 Y92.255 E.0084
G1 X85.889 Y91.855 E.0084
G1 X85.724 Y91.437 E.0084
G1 X85.603 Y91.004 E.0084
G1 X85.525 Y90.561 E.0084
G1 X85.491 Y90.112 E.0084
G1 X85.502 Y89.663 E.0084
G1 X85.558 Y89.217 E.0084
G1 X85.658 Y88.778 E.00841
G1 X85.801 Y88.352 E.0084
G1 X85.986 Y87.942 E.00841
G1 X86.211 Y87.553 E.0084
G1 X86.474 Y87.188 E.0084
G1 X86.771 Y86.851 E.0084
G1 X87.101 Y86.545 E.0084
G1 X87.461 Y86.272 E.00845
G1 X88.041 Y85.937 E.0125
G1 X88.457 Y85.762 E.00845
G1 X88.887 Y85.629 E.0084
G1 X89.328 Y85.54 E.0084
G1 X89.775 Y85.495 E.0084
G1 X90.225 Y85.495 E.0084
G1 X90.672 Y85.54 E.0084
G1 X91.113 Y85.629 E.0084
G1 X91.542 Y85.762 E.0084
G1 X91.957 Y85.936 E.0084
G1 X92.351 Y86.151 E.0084
G1 X92.723 Y86.405 E.00841
G1 X93.068 Y86.694 E.0084
G1 X93.382 Y87.016 E.0084
G1 X93.662 Y87.367 E.0084
G1 X93.906 Y87.745 E.0084
G1 X94.111 Y88.145 E.0084
G1 X94.275 Y88.564 E.0084
G1 X94.397 Y88.996 E.0084
G1 X94.475 Y89.439 E.0084
G1 X94.509 Y89.888 E.0084
G1 X94.497 Y90.337 E.0084
G1 X94.442 Y90.783 E.0084
G1 X94.342 Y91.222 E.0084
G1 X94.198 Y91.648 E.0084
G1 X94.017 Y92.049 E.00822
; WIPE_START
M204 S6000
G1 X93.789 Y92.447 E-.06542
G1 X93.526 Y92.812 E-.06411
G1 X93.229 Y93.149 E-.06406
G1 X92.899 Y93.455 E-.06405
G1 X92.746 Y93.571 E-.02736
; WIPE_END
G1 E-.015
M204 S10000
G1 X88.502 Y87.227 Z3.96 F18000
G1 X86.056 Y83.572 Z3.96
G1 Z3.56
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F3600
M204 S6000
G1 X86.668 Y83.233 E.01406
G1 X87.336 Y82.944 E.01464
G1 X88.217 Y82.672 E.01854
G1 X88.932 Y82.533 E.01465
G1 X89.663 Y82.465 E.01476
G1 X90.397 Y82.468 E.01476
G1 X91.128 Y82.542 E.01476
G1 X91.848 Y82.687 E.01477
G1 X92.55 Y82.901 E.01476
G1 X93.228 Y83.183 E.01476
G1 X93.875 Y83.529 E.01476
G1 X94.481 Y83.934 E.01465
G1 X95.188 Y84.526 E.01854
G1 X95.692 Y85.051 E.01464
G1 X96.146 Y85.628 E.01477
G1 X96.542 Y86.247 E.01476
G1 X96.876 Y86.901 E.01477
G1 X97.145 Y87.584 E.01476
G1 X97.346 Y88.291 E.01478
G1 X97.478 Y89.014 E.01476
G1 X97.538 Y89.746 E.01478
G1 X97.527 Y90.475 E.01466
G1 X97.412 Y91.391 E.01856
G1 X97.244 Y92.1 E.01466
G1 X97.005 Y92.796 E.01478
G1 X96.7 Y93.464 E.01478
G1 X96.331 Y94.1 E.01478
G1 X95.901 Y94.697 E.01478
G1 X95.416 Y95.25 E.01478
G1 X94.879 Y95.752 E.01478
G1 X94.297 Y96.199 E.01478
G1 X93.673 Y96.587 E.01477
G1 X93.016 Y96.913 E.01475
G1 X92.335 Y97.171 E.01463
G1 X91.446 Y97.402 E.01848
G1 X90.729 Y97.507 E.01457
G1 X89.997 Y97.543 E.01473
G1 X89.378 Y97.516 E.01245
G1 X88.491 Y97.391 E.01802
G1 X87.779 Y97.208 E.01479
G1 X87.086 Y96.958 E.0148
G1 X86.577 Y96.719 E.01131
G1 X86.276 Y96.559 E.00685
G1 X85.8 Y96.266 E.01125
G1 X85.341 Y95.927 E.01147
G1 X85.075 Y95.713 E.00687
G1 X84.801 Y95.459 E.00752
G1 X84.422 Y95.071 E.0109
M73 P90 R1
G1 X84.062 Y94.651 E.01113
G1 X83.636 Y94.049 E.01483
G1 X83.272 Y93.41 E.01478
G1 X82.972 Y92.739 E.01478
G1 X82.739 Y92.041 E.01478
G1 X82.574 Y91.325 E.01478
G1 X82.482 Y90.602 E.01464
G1 X82.465 Y89.679 E.01856
G1 X82.531 Y88.953 E.01466
G1 X82.668 Y88.231 E.01478
G1 X82.875 Y87.527 E.01476
G1 X83.149 Y86.845 E.01477
G1 X83.488 Y86.194 E.01477
G1 X83.889 Y85.579 E.01476
G1 X84.348 Y85.005 E.01477
G1 X84.86 Y84.479 E.01477
G1 X85.421 Y84.006 E.01476
G1 X86.005 Y83.604 E.01426
M204 S10000
G1 X85.851 Y83.201 F18000
G1 F3600
M204 S6000
G1 X86.481 Y82.852 E.01448
G1 X87.189 Y82.546 E.01552
G1 X88.114 Y82.26 E.01947
G1 X88.872 Y82.113 E.01553
G1 X89.644 Y82.041 E.0156
G1 X90.42 Y82.044 E.01559
G1 X91.191 Y82.122 E.0156
G1 X91.952 Y82.275 E.0156
G1 X92.694 Y82.502 E.01559
G1 X93.41 Y82.799 E.01559
G1 X94.093 Y83.165 E.01559
G1 X94.736 Y83.594 E.01554
G1 X95.478 Y84.216 E.01947
G1 X96.012 Y84.773 E.01552
G1 X96.492 Y85.382 E.0156
G1 X96.911 Y86.035 E.0156
G1 X97.264 Y86.726 E.0156
G1 X97.548 Y87.448 E.0156
G1 X97.76 Y88.195 E.01561
G1 X97.899 Y88.958 E.0156
G1 X97.962 Y89.732 E.01561
G1 X97.951 Y90.504 E.01554
G1 X97.831 Y91.466 E.01949
G1 X97.652 Y92.219 E.01554
G1 X97.4 Y92.953 E.01562
G1 X97.077 Y93.66 E.01561
G1 X96.687 Y94.331 E.01562
G1 X96.234 Y94.962 E.01562
G1 X95.721 Y95.545 E.01562
G1 X95.154 Y96.076 E.01561
G1 X94.538 Y96.548 E.01561
G1 X93.88 Y96.958 E.0156
G1 X93.185 Y97.302 E.01558
G1 X92.464 Y97.576 E.0155
G1 X91.53 Y97.819 E.01941
G1 X90.77 Y97.93 E.01545
G1 X89.998 Y97.968 E.01554
G1 X89.346 Y97.94 E.01312
G1 X88.405 Y97.806 E.01911
G1 X87.654 Y97.614 E.01559
G1 X86.924 Y97.35 E.01561
G1 X86.387 Y97.098 E.01191
G1 X86.066 Y96.927 E.00733
G1 X85.563 Y96.618 E.01187
G1 X85.082 Y96.263 E.01201
G1 X84.797 Y96.034 E.00735
G1 X84.505 Y95.763 E.00803
G1 X84.109 Y95.358 E.01138
G1 X83.727 Y94.912 E.01181
G1 X83.277 Y94.276 E.01565
G1 X82.893 Y93.602 E.01561
G1 X82.576 Y92.893 E.01562
G1 X82.33 Y92.156 E.01561
G1 X82.156 Y91.399 E.01562
G1 X82.058 Y90.633 E.01553
G1 X82.041 Y89.664 E.01949
G1 X82.11 Y88.895 E.01553
G1 X82.255 Y88.132 E.01561
G1 X82.473 Y87.387 E.0156
G1 X82.763 Y86.668 E.0156
G1 X83.121 Y85.979 E.0156
G1 X83.545 Y85.33 E.0156
G1 X84.029 Y84.724 E.0156
G1 X84.571 Y84.168 E.0156
G1 X85.164 Y83.668 E.01559
G1 X85.798 Y83.231 E.0155
M204 S250
G1 X85.652 Y82.843 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1440
M204 S5000
G1 X86.3 Y82.485 E.01383
G1 X87.047 Y82.161 E.01522
M106 S71.4
M106 S229.5
G1 F1560
G1 X88.014 Y81.862 E.01892
M106 S71.4
M106 S229.5
G1 F1440
G1 X88.814 Y81.707 E.01522
G1 X89.626 Y81.631 E.01524
G1 X90.441 Y81.634 E.01524
M106 S71.4
M106 S229.5
G1 X91.253 Y81.717 E.01524
G1 X92.052 Y81.878 E.01524
G1 X92.832 Y82.116 E.01524
G1 X93.585 Y82.429 E.01524
G1 X94.304 Y82.813 E.01523
G1 X94.982 Y83.266 E.01522
M106 S71.4
M106 S229.5
G1 F1560
G1 X95.758 Y83.916 E.01893
M106 S71.4
M106 S229.5
G1 F1440
G1 X96.322 Y84.504 E.01521
G1 X96.826 Y85.145 E.01524
G1 X97.266 Y85.831 E.01524
G1 X97.637 Y86.558 E.01524
G1 X97.936 Y87.317 E.01524
G1 X98.159 Y88.102 E.01525
G1 X98.305 Y88.905 E.01524
G1 X98.372 Y89.718 E.01525
G1 X98.36 Y90.533 E.01523
M106 S71.4
M106 S229.5
G1 F1560
G1 X98.234 Y91.539 E.01895
M106 S71.4
M106 S229.5
G1 F1440
G1 X98.045 Y92.333 E.01524
G1 X97.78 Y93.105 E.01526
G1 X97.441 Y93.848 E.01526
G1 X97.031 Y94.554 E.01526
G1 X96.554 Y95.217 E.01526
G1 X96.015 Y95.83 E.01526
G1 X95.419 Y96.388 E.01525
G1 X94.772 Y96.885 E.01525
G1 X94.079 Y97.316 E.01524
G1 X93.349 Y97.678 E.01523
G1 X92.589 Y97.966 E.01519
M106 S71.4
M106 S229.5
G1 F1560
G1 X91.612 Y98.221 E.01887
M106 S71.4
M106 S229.5
G1 F1440
G1 X90.81 Y98.338 E.01515
G1 X89.999 Y98.377 E.01516
G1 X89.315 Y98.348 E.0128
G1 X88.321 Y98.207 E.01875
G1 X87.533 Y98.006 E.01521
G1 X86.767 Y97.728 E.01523
G1 X85.862 Y97.283 E.01884
G1 X85.334 Y96.957 E.0116
G1 X84.832 Y96.587 E.01164
G1 X84.53 Y96.344 E.00726
G1 X84.219 Y96.056 E.00791
M106 S71.4
M106 S229.5
G1 F1560
G1 X83.807 Y95.634 E.01101
M106 S71.4
M106 S229.5
G1 F1440
G1 X83.404 Y95.164 E.01158
G1 X82.932 Y94.497 E.01527
G1 X82.528 Y93.787 E.01526
G1 X82.194 Y93.042 E.01526
G1 X81.935 Y92.267 E.01526
G1 X81.753 Y91.471 E.01526
G1 X81.649 Y90.663 E.01523
M106 S71.4
M106 S229.5
G1 F1560
G1 X81.631 Y89.649 E.01895
G1 X81.705 Y88.838 E.01522
M106 S71.4
M106 S229.5
G1 F1440
G1 X81.857 Y88.036 E.01525
G1 X82.086 Y87.253 E.01524
G1 X82.391 Y86.496 E.01524
G1 X82.767 Y85.773 E.01524
G1 X83.213 Y85.089 E.01524
G1 X83.722 Y84.453 E.01524
G1 X84.292 Y83.869 E.01524
G1 X84.915 Y83.343 E.01524
G1 X85.587 Y82.88 E.01524
G1 X85.6 Y82.872 E.00028
M106 S71.4
; WIPE_START
M204 S6000
G1 X86.3 Y82.485 E-.11402
G1 X87.047 Y82.161 E-.11603
G1 X87.415 Y82.047 E-.05495
; WIPE_END
G1 E-.015 F1800
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
G1 X0 Y90.0001 ; move to safe pos
G1 X-13.0 F3000 ; move to safe pos
M400
M1004 S5 P1  ; external shutter
M400 P300
M971 S11 C11 O0
G92 E0
G1 X0 F18000
M623

; SKIPTYPE: head_wrap_detect
M622.1 S1
M1002 judge_flag g39_3rd_layer_detect_flag
M622 J1
    ; enable nozzle clog detect at 3rd layer
    


    M622.1 S1
    M1002 judge_flag g39_detection_flag
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




G1 X97.128 Y89.793
G1 Z3.56
G1 E.3 F1800
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.419992
G1 F3840
M204 S6000
G1 X97.081 Y89.187 E.01137
G1 X96.966 Y88.486 E.01326
G1 X96.782 Y87.802 E.01324
G1 X96.53 Y87.139 E.01325
G1 X96.214 Y86.504 E.01326
G1 X95.837 Y85.904 E.01325
G1 X95.404 Y85.347 E.01319
G1 X94.934 Y84.852 E.01274
G1 X94.363 Y84.369 E.01399
G1 X93.777 Y83.956 E.01339
G1 X93.158 Y83.61 E.01324
G1 X92.508 Y83.327 E.01325
G1 X91.833 Y83.11 E.01325
G1 X91.14 Y82.962 E.01325
G1 X90.435 Y82.883 E.01326
G1 X89.726 Y82.874 E.01325
G1 X89.024 Y82.936 E.01317
G1 X88.354 Y83.062 E.01274
G1 X87.637 Y83.28 E.014
G1 X86.958 Y83.554 E.01368
G1 X86.272 Y83.921 E.01454
G1 X85.698 Y84.312 E.01298
G1 X85.165 Y84.757 E.01297
G1 X84.678 Y85.252 E.01298
G1 X84.242 Y85.792 E.01297
G1 X83.86 Y86.372 E.01297
G1 X83.537 Y86.987 E.01298
G1 X83.274 Y87.63 E.01297
G1 X83.076 Y88.295 E.01297
G1 X82.977 Y88.797 E.00957
G1 X82.9 Y89.414 E.0116
G1 X82.883 Y90.129 E.01337
G1 X82.925 Y90.844 E.0134
G1 X83.044 Y91.543 E.01325
G1 X83.232 Y92.227 E.01324
G1 X83.487 Y92.888 E.01324
G1 X83.806 Y93.521 E.01325
G1 X84.187 Y94.118 E.01324
G1 X84.621 Y94.674 E.01318
G1 X85.064 Y95.143 E.01206
G1 X85.574 Y95.588 E.01264
G1 X85.997 Y95.902 E.00986
G1 X86.737 Y96.338 E.01605
G1 X87.215 Y96.566 E.00989
G1 X87.868 Y96.805 E.01299
G1 X88.534 Y96.979 E.01287
G1 X89.382 Y97.104 E.01602
G1 X89.964 Y97.132 E.01088
G1 X90.655 Y97.101 E.01293
G1 X91.296 Y97.011 E.01208
G1 X92.028 Y96.828 E.01411
G1 X92.704 Y96.593 E.01337
G1 X93.346 Y96.293 E.01325
G1 X93.955 Y95.93 E.01325
G1 X94.525 Y95.508 E.01325
G1 X95.05 Y95.031 E.01325
G1 X95.525 Y94.505 E.01324
G1 X95.946 Y93.934 E.01326
G1 X96.308 Y93.324 E.01325
G1 X96.608 Y92.681 E.01326
G1 X96.84 Y92.018 E.01312
G1 X97 Y91.355 E.01276
G1 X97.098 Y90.61 E.01404
G1 X97.127 Y89.853 E.01415
M204 S10000
G1 X96.685 Y89.787 F18000
; LINE_WIDTH: 0.517596
G1 F3840
M204 S6000
G1 X96.64 Y89.223 E.01318
G1 X96.531 Y88.566 E.01553
G1 X96.356 Y87.923 E.01551
G1 X96.118 Y87.301 E.01553
G1 X95.82 Y86.705 E.01553
G1 X95.464 Y86.143 E.01552
G1 X95.055 Y85.621 E.01545
G1 X94.614 Y85.159 E.01488
G1 X94.079 Y84.707 E.01633
G1 X93.531 Y84.323 E.01559
G1 X92.95 Y84 E.01551
G1 X92.338 Y83.736 E.01553
G1 X91.704 Y83.534 E.01553
G1 X91.052 Y83.396 E.01552
G1 X90.39 Y83.324 E.01553
G1 X89.724 Y83.317 E.01552
G1 X89.065 Y83.377 E.01542
G1 X88.438 Y83.497 E.01489
G1 X87.767 Y83.701 E.01635
G1 X87.133 Y83.96 E.01595
G1 X86.488 Y84.311 E.01713
G1 X85.95 Y84.679 E.01518
G1 X85.452 Y85.097 E.01517
G1 X84.997 Y85.563 E.01518
G1 X84.589 Y86.07 E.01517
G1 X84.233 Y86.615 E.01517
G1 X83.931 Y87.192 E.01518
G1 X83.687 Y87.796 E.01518
G1 X83.502 Y88.42 E.01518
G1 X83.38 Y89.06 E.01519
G1 X83.321 Y89.697 E.01492
G1 X83.324 Y90.209 E.01192
G1 X83.363 Y90.788 E.01354
G1 X83.475 Y91.445 E.01553
G1 X83.651 Y92.087 E.01552
G1 X83.89 Y92.708 E.01552
G1 X84.19 Y93.302 E.01552
G1 X84.547 Y93.864 E.01551
G1 X84.956 Y94.386 E.01548
G1 X85.381 Y94.833 E.01437
G1 X85.864 Y95.253 E.01491
G1 X86.272 Y95.552 E.01179
G1 X86.96 Y95.955 E.0186
G1 X87.414 Y96.168 E.01168
G1 X88.019 Y96.387 E.015
G1 X88.644 Y96.548 E.01505
G1 X89.445 Y96.664 E.01886
G1 X89.983 Y96.687 E.01256
G1 X90.634 Y96.656 E.01519
G1 X91.231 Y96.573 E.01406
G1 X91.917 Y96.401 E.01647
G1 X92.547 Y96.18 E.01558
G1 X93.15 Y95.896 E.01553
G1 X93.721 Y95.554 E.01552
G1 X94.256 Y95.157 E.01552
G1 X94.748 Y94.708 E.01552
G1 X95.193 Y94.213 E.01552
G1 X95.587 Y93.675 E.01554
G1 X95.925 Y93.102 E.01552
G1 X96.205 Y92.497 E.01553
G1 X96.42 Y91.874 E.01537
G1 X96.569 Y91.252 E.01491
G1 X96.66 Y90.555 E.01639
G1 X96.684 Y89.847 E.01653
; WIPE_START
G1 X96.66 Y90.555 E-.10104
G1 X96.569 Y91.252 E-.10016
G1 X96.432 Y91.824 E-.0838
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X94.126 Y94.011 Z3.96 F18000
G1 Z3.56
G1 E.3 F1800
; LINE_WIDTH: 0.419992
G1 F3840
M204 S6000
G1 X93.706 Y94.401 E.01072
G1 X93.254 Y94.745 E.01062
G1 X92.778 Y95.038 E.01044
G1 X92.277 Y95.283 E.01042
G1 X91.765 Y95.474 E.0102
G1 X91.134 Y95.642 E.0122
G1 X90.536 Y95.718 E.01128
G1 X89.994 Y95.747 E.01014
G1 X89.152 Y95.691 E.01577
G1 X88.59 Y95.579 E.01071
G1 X88.041 Y95.41 E.01072
G1 X87.512 Y95.188 E.01072
G1 X87.008 Y94.915 E.01072
G1 X86.531 Y94.591 E.01076
G1 X86.074 Y94.206 E.01118
G1 X85.726 Y93.849 E.00931
G1 X85.333 Y93.367 E.01162
G1 X85.022 Y92.886 E.01071
G1 X84.759 Y92.376 E.01072
G1 X84.549 Y91.842 E.01072
G1 X84.392 Y91.29 E.01072
G1 X84.292 Y90.725 E.01072
G1 X84.248 Y90.153 E.01072
G1 X84.261 Y89.58 E.01072
G1 X84.331 Y89.011 E.01072
G1 X84.458 Y88.451 E.01072
G1 X84.64 Y87.907 E.01071
G1 X84.875 Y87.383 E.01073
G1 X85.161 Y86.886 E.01072
G1 X85.495 Y86.42 E.01072
G1 X85.874 Y85.989 E.01071
G1 X86.294 Y85.598 E.01072
G1 X86.763 Y85.242 E.011
G1 X87.476 Y84.829 E.0154
M73 P91 R1
G1 X87.986 Y84.612 E.01036
G1 X88.571 Y84.426 E.01146
G1 X89.132 Y84.312 E.01071
G1 X89.703 Y84.254 E.01072
G1 X90.277 Y84.253 E.01071
G1 X90.848 Y84.309 E.01072
G1 X91.41 Y84.421 E.01071
G1 X91.959 Y84.59 E.01072
G1 X92.488 Y84.812 E.01072
G1 X92.98 Y85.078 E.01046
G1 X93.433 Y85.385 E.01022
G1 X93.907 Y85.775 E.01147
G1 X94.308 Y86.185 E.01072
G1 X94.666 Y86.633 E.01072
G1 X94.978 Y87.114 E.01071
G1 X95.241 Y87.625 E.01072
G1 X95.451 Y88.158 E.01072
G1 X95.607 Y88.71 E.01071
G1 X95.708 Y89.275 E.01073
G1 X95.751 Y89.834 E.01048
G1 X95.739 Y90.381 E.01022
G1 X95.668 Y90.989 E.01145
G1 X95.542 Y91.549 E.01072
G1 X95.36 Y92.093 E.01072
G1 X95.125 Y92.616 E.01072
G1 X94.839 Y93.113 E.01071
G1 X94.504 Y93.58 E.01073
G1 X94.165 Y93.966 E.00959
; WIPE_START
G1 X94.504 Y93.58 E-.07314
G1 X94.839 Y93.113 E-.08182
G1 X95.125 Y92.616 E-.08168
G1 X95.264 Y92.307 E-.04836
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X92.469 Y95.682 Z3.96 F18000
G1 Z3.56
G1 E.3 F1800
; LINE_WIDTH: 0.516064
G1 F3840
M204 S6000
G1 X91.917 Y95.89 E.01372
G1 X91.243 Y96.07 E.01619
G1 X90.591 Y96.161 E.01531
G1 X89.994 Y96.192 E.0139
G1 X89.108 Y96.129 E.02063
G1 X88.502 Y96.011 E.01435
G1 X87.911 Y95.832 E.01435
G1 X87.34 Y95.596 E.01435
G1 X86.797 Y95.302 E.01435
G1 X86.283 Y94.956 E.0144
G1 X85.789 Y94.543 E.01496
G1 X85.408 Y94.158 E.01258
G1 X84.988 Y93.642 E.01546
G1 X84.651 Y93.125 E.01434
G1 X84.366 Y92.577 E.01435
G1 X84.138 Y92.003 E.01435
G1 X83.967 Y91.41 E.01435
G1 X83.857 Y90.802 E.01436
G1 X83.809 Y90.186 E.01435
G1 X83.82 Y89.569 E.01435
G1 X83.893 Y88.956 E.01435
G1 X84.028 Y88.353 E.01436
G1 X84.221 Y87.767 E.01434
G1 X84.473 Y87.202 E.01436
G1 X84.779 Y86.666 E.01435
G1 X85.137 Y86.162 E.01436
G1 X85.543 Y85.697 E.01435
G1 X85.994 Y85.275 E.01435
G1 X86.496 Y84.89 E.01471
G1 X87.254 Y84.445 E.02043
G1 X87.814 Y84.203 E.01417
G1 X88.441 Y84.004 E.01528
G1 X89.045 Y83.878 E.01435
G1 X89.659 Y83.813 E.01436
G1 X90.277 Y83.81 E.01435
G1 X90.892 Y83.868 E.01436
G1 X91.498 Y83.987 E.01435
G1 X92.089 Y84.166 E.01436
G1 X92.66 Y84.403 E.01436
G1 X93.192 Y84.689 E.01404
G1 X93.683 Y85.018 E.01374
G1 X94.19 Y85.437 E.01529
G1 X94.624 Y85.877 E.01435
G1 X95.012 Y86.357 E.01436
G1 X95.35 Y86.874 E.01435
G1 X95.635 Y87.423 E.01436
G1 X95.863 Y87.997 E.01436
G1 X96.034 Y88.59 E.01434
G1 X96.144 Y89.198 E.01436
G1 X96.193 Y89.801 E.01407
G1 X96.183 Y90.392 E.01374
G1 X96.106 Y91.044 E.01526
G1 X95.973 Y91.647 E.01435
G1 X95.779 Y92.234 E.01436
G1 X95.528 Y92.798 E.01436
G1 X95.222 Y93.335 E.01434
G1 X94.864 Y93.839 E.01437
G1 X94.458 Y94.304 E.01435
G1 X94.008 Y94.726 E.01435
G1 X93.521 Y95.099 E.01423
G1 X93.009 Y95.416 E.01401
G1 X92.523 Y95.656 E.01259
; CHANGE_LAYER
; Z_HEIGHT: 3.68
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F3840
G1 X93.009 Y95.416 E-.07722
G1 X93.521 Y95.099 E-.08589
G1 X94.008 Y94.726 E-.08727
G1 X94.185 Y94.56 E-.03462
; WIPE_END
G1 E-.015 F1800
; layer num/total_layer_count: 30/33
; update layer progress
M73 L30
M991 S0 P29 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z3.96 I1.179 J.303 P1  F18000
G1 X94.709 Y92.52 Z3.96
G1 Z3.68
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F3600
M204 S6000
G1 X94.49 Y92.9 E.00882
G1 X94.178 Y93.333 E.01072
G1 X93.826 Y93.732 E.01071
G1 X93.435 Y94.094 E.01072
G1 X93.011 Y94.416 E.01071
G1 X92.556 Y94.694 E.01072
G1 X92.076 Y94.925 E.01071
G1 X91.575 Y95.107 E.01072
G1 X91.046 Y95.242 E.01097
G1 X90.279 Y95.338 E.01554
G1 X89.733 Y95.338 E.01098
G1 X89.203 Y95.285 E.01071
G1 X88.681 Y95.18 E.01071
G1 X88.172 Y95.022 E.01072
G1 X87.681 Y94.815 E.01071
G1 X87.213 Y94.561 E.01071
G1 X86.771 Y94.26 E.01074
G1 X86.351 Y93.905 E.01105
G1 X85.992 Y93.536 E.01036
G1 X85.66 Y93.12 E.0107
G1 X85.371 Y92.672 E.01072
G1 X85.128 Y92.198 E.01072
G1 X84.933 Y91.702 E.01071
G1 X84.789 Y91.189 E.01071
G1 X84.697 Y90.665 E.01072
G1 X84.657 Y90.133 E.01071
G1 X84.67 Y89.601 E.01071
G1 X84.736 Y89.072 E.01071
G1 X84.855 Y88.552 E.01072
G1 X85.024 Y88.047 E.01071
G1 X85.244 Y87.562 E.01072
G1 X85.51 Y87.1 E.01071
G1 X85.821 Y86.668 E.01072
G1 X86.174 Y86.268 E.01072
G1 X86.564 Y85.906 E.01071
G1 X86.999 Y85.576 E.01097
G1 X87.669 Y85.19 E.01555
G1 X88.172 Y84.978 E.01097
G1 X88.681 Y84.82 E.01072
G1 X89.203 Y84.715 E.01071
G1 X89.733 Y84.662 E.01071
G1 X90.266 Y84.662 E.01071
G1 X90.796 Y84.715 E.01071
G1 X91.319 Y84.82 E.01071
G1 X91.828 Y84.978 E.01072
G1 X92.319 Y85.184 E.01071
G1 X92.787 Y85.439 E.01072
G1 X93.227 Y85.739 E.01071
G1 X93.635 Y86.082 E.01072
G1 X94.007 Y86.463 E.01071
G1 X94.339 Y86.88 E.01071
G1 X94.629 Y87.328 E.01072
G1 X94.872 Y87.802 E.01072
G1 X95.066 Y88.298 E.01071
G1 X95.211 Y88.811 E.01071
G1 X95.303 Y89.335 E.01072
G1 X95.343 Y89.867 E.01071
G1 X95.33 Y90.399 E.01071
G1 X95.263 Y90.928 E.01071
G1 X95.145 Y91.448 E.01072
G1 X94.975 Y91.952 E.01071
G1 X94.756 Y92.438 E.01072
G1 X94.739 Y92.468 E.00068
M204 S10000
G1 X94.342 Y92.308 F18000
G1 F3600
M204 S6000
G1 X94.133 Y92.669 E.00839
G1 X93.846 Y93.068 E.00987
G1 X93.522 Y93.435 E.00986
G1 X93.162 Y93.769 E.00986
G1 X92.771 Y94.065 E.00986
G1 X92.353 Y94.321 E.00987
G1 X91.911 Y94.534 E.00986
G1 X91.45 Y94.701 E.00987
G1 X90.967 Y94.824 E.01002
G1 X90.253 Y94.914 E.01447
G1 X89.754 Y94.914 E.01002
G1 X89.267 Y94.865 E.00986
G1 X88.786 Y94.768 E.00986
G1 X88.317 Y94.623 E.00986
G1 X87.865 Y94.433 E.00986
G1 X87.434 Y94.198 E.00986
G1 X87.028 Y93.921 E.00988
G1 X86.641 Y93.594 E.0102
G1 X86.311 Y93.255 E.00952
G1 X86.005 Y92.872 E.00985
G1 X85.739 Y92.46 E.00987
G1 X85.515 Y92.023 E.00986
G1 X85.336 Y91.567 E.00986
G1 X85.203 Y91.095 E.00986
G1 X85.118 Y90.612 E.00986
G1 X85.081 Y90.123 E.00986
G1 X85.094 Y89.632 E.00986
G1 X85.155 Y89.146 E.00986
G1 X85.264 Y88.667 E.00987
G1 X85.42 Y88.203 E.00986
G1 X85.622 Y87.755 E.00987
G1 X85.867 Y87.331 E.00986
G1 X86.153 Y86.932 E.00986
G1 X86.478 Y86.565 E.00986
G1 X86.837 Y86.231 E.00986
G1 X87.234 Y85.93 E.01001
G1 X87.858 Y85.57 E.01448
G1 X88.317 Y85.377 E.01001
G1 X88.786 Y85.232 E.00987
G1 X89.267 Y85.135 E.00986
G1 X89.755 Y85.086 E.00986
G1 X90.245 Y85.086 E.00986
G1 X90.733 Y85.135 E.00986
G1 X91.214 Y85.232 E.00986
G1 X91.683 Y85.377 E.00987
G1 X92.134 Y85.567 E.00986
G1 X92.565 Y85.802 E.00987
G1 X92.97 Y86.078 E.00986
G1 X93.346 Y86.393 E.00987
G1 X93.689 Y86.744 E.00986
G1 X93.994 Y87.128 E.00986
G1 X94.261 Y87.54 E.00987
G1 X94.485 Y87.977 E.00986
G1 X94.664 Y88.433 E.00986
G1 X94.796 Y88.905 E.00986
G1 X94.882 Y89.388 E.00986
G1 X94.918 Y89.877 E.00986
G1 X94.906 Y90.368 E.00986
G1 X94.845 Y90.854 E.00986
G1 X94.736 Y91.333 E.00987
G1 X94.58 Y91.797 E.00986
G1 X94.378 Y92.245 E.00986
G1 X94.372 Y92.256 E.00026
M204 S250
G1 X93.987 Y92.103 F18000
M106 S229.5
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1800
M204 S5000
G1 X93.789 Y92.447 E.00742
G1 X93.526 Y92.812 E.0084
G1 X93.229 Y93.149 E.0084
G1 X92.899 Y93.455 E.0084
G1 X92.541 Y93.726 E.0084
G1 X92.157 Y93.961 E.0084
G1 X91.752 Y94.156 E.0084
G1 X91.329 Y94.31 E.0084
G1 X90.891 Y94.422 E.00845
G1 X90.227 Y94.505 E.0125
G1 X89.775 Y94.505 E.00846
G1 X89.328 Y94.46 E.0084
G1 X88.887 Y94.371 E.0084
G1 X88.457 Y94.238 E.0084
G1 X88.043 Y94.064 E.0084
G1 X87.648 Y93.848 E.00841
G1 X87.276 Y93.595 E.0084
G1 X86.92 Y93.295 E.00871
G1 X86.618 Y92.984 E.00809
G1 X86.338 Y92.633 E.0084
G1 X86.094 Y92.255 E.00841
G1 X85.889 Y91.855 E.0084
G1 X85.724 Y91.436 E.0084
G1 X85.603 Y91.004 E.0084
G1 X85.525 Y90.561 E.0084
G1 X85.491 Y90.112 E.0084
G1 X85.502 Y89.663 E.0084
G1 X85.558 Y89.217 E.0084
G1 X85.658 Y88.778 E.00841
G1 X85.801 Y88.352 E.0084
G1 X85.986 Y87.942 E.0084
G1 X86.211 Y87.553 E.0084
G1 X86.474 Y87.188 E.0084
G1 X86.771 Y86.851 E.0084
G1 X87.101 Y86.545 E.0084
G1 X87.461 Y86.272 E.00845
G1 X88.041 Y85.937 E.0125
G1 X88.457 Y85.762 E.00845
G1 X88.887 Y85.629 E.00841
G1 X89.328 Y85.54 E.0084
G1 X89.775 Y85.495 E.0084
G1 X90.225 Y85.495 E.0084
G1 X90.672 Y85.54 E.0084
G1 X91.113 Y85.629 E.0084
G1 X91.542 Y85.762 E.0084
G1 X91.957 Y85.936 E.0084
G1 X92.352 Y86.151 E.00841
G1 X92.723 Y86.405 E.0084
G1 X93.068 Y86.694 E.0084
G1 X93.381 Y87.016 E.0084
G1 X93.662 Y87.367 E.0084
G1 X93.906 Y87.745 E.00841
G1 X94.111 Y88.145 E.0084
G1 X94.275 Y88.564 E.0084
G1 X94.397 Y88.996 E.0084
G1 X94.475 Y89.439 E.0084
G1 X94.509 Y89.888 E.0084
G1 X94.497 Y90.337 E.0084
G1 X94.442 Y90.783 E.0084
G1 X94.341 Y91.222 E.00841
G1 X94.198 Y91.648 E.0084
G1 X94.016 Y92.051 E.00826
; WIPE_START
M204 S6000
G1 X93.789 Y92.447 E-.06513
G1 X93.526 Y92.812 E-.0641
G1 X93.229 Y93.149 E-.06407
G1 X92.899 Y93.455 E-.06407
G1 X92.744 Y93.572 E-.02764
; WIPE_END
G1 E-.015
M204 S10000
G1 X88.508 Y87.223 Z4.08 F18000
G1 X85.977 Y83.429 Z4.08
G1 Z3.68
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F3600
M204 S6000
G1 X86.567 Y83.099 E.01361
G1 X87.25 Y82.8 E.01499
G1 X87.748 Y82.632 E.01056
G1 X88.202 Y82.505 E.00948
G1 X88.936 Y82.366 E.01502
G1 X89.675 Y82.299 E.01492
G1 X90.416 Y82.303 E.01491
G1 X91.154 Y82.379 E.01492
G1 X91.882 Y82.525 E.01492
G1 X92.592 Y82.741 E.01492
G1 X93.277 Y83.024 E.01492
G1 X93.933 Y83.371 E.01491
G1 X94.555 Y83.783 E.015
G1 X94.965 Y84.11 E.01055
G1 X95.319 Y84.422 E.00949
G1 X95.834 Y84.963 E.01502
G1 X96.291 Y85.547 E.01492
G1 X96.69 Y86.173 E.01492
G1 X97.027 Y86.834 E.01492
G1 X97.299 Y87.525 E.01493
G1 X97.504 Y88.239 E.01493
G1 X97.638 Y88.969 E.01493
G1 X97.702 Y89.709 E.01493
G1 X97.694 Y90.455 E.01501
G1 X97.641 Y90.98 E.01059
G1 X97.571 Y91.446 E.00949
G1 X97.395 Y92.174 E.01505
G1 X97.151 Y92.876 E.01495
G1 X96.841 Y93.551 E.01495
G1 X96.467 Y94.194 E.01495
G1 X96.033 Y94.797 E.01495
G1 X95.542 Y95.356 E.01495
G1 X95.001 Y95.865 E.01494
G1 X94.413 Y96.319 E.01494
G1 X93.785 Y96.714 E.01492
G1 X93.122 Y97.046 E.01491
G1 X92.432 Y97.313 E.01488
G1 X91.72 Y97.512 E.01487
G1 X90.994 Y97.642 E.01483
G1 X90.249 Y97.702 E.01503
G1 X89.447 Y97.687 E.01612
G1 X88.704 Y97.597 E.01505
G1 X87.984 Y97.438 E.01483
G1 X87.281 Y97.21 E.01487
G1 X86.581 Y96.906 E.01533
G1 X85.944 Y96.552 E.01467
G1 X85.332 Y96.13 E.01494
G1 X84.773 Y95.66 E.01468
G1 X84.39 Y95.286 E.01077
G1 X84.225 Y95.1 E.005
G1 X83.76 Y94.52 E.01495
G1 X83.353 Y93.899 E.01493
G1 X83.013 Y93.25 E.01473
G1 X82.726 Y92.541 E.01537
G1 X82.514 Y91.829 E.01495
G1 X82.373 Y91.1 E.01493
G1 X82.302 Y90.36 E.01494
G1 X82.303 Y89.617 E.01493
G1 X82.375 Y88.879 E.01493
G1 X82.518 Y88.15 E.01493
G1 X82.73 Y87.439 E.01492
G1 X83.01 Y86.751 E.01493
G1 X83.355 Y86.094 E.01492
G1 X83.762 Y85.473 E.01492
G1 X84.226 Y84.894 E.01492
G1 X84.743 Y84.363 E.01491
G1 X85.31 Y83.883 E.01492
G1 X85.919 Y83.461 E.01491
G1 X85.924 Y83.458 E.00011
M204 S10000
G1 X85.77 Y83.059 F18000
G1 F3600
M204 S6000
G1 X86.378 Y82.719 E.01402
G1 X87.097 Y82.404 E.01578
G1 X87.623 Y82.227 E.01116
G1 X88.105 Y82.091 E.01007
G1 X88.877 Y81.946 E.0158
G1 X89.657 Y81.875 E.01574
G1 X90.439 Y81.879 E.01573
G1 X91.218 Y81.959 E.01574
G1 X91.985 Y82.114 E.01574
G1 X92.734 Y82.341 E.01574
G1 X93.458 Y82.64 E.01574
G1 X94.149 Y83.006 E.01573
G1 X94.805 Y83.439 E.01579
G1 X95.238 Y83.785 E.01115
G1 X95.614 Y84.116 E.01007
G1 X96.156 Y84.686 E.0158
G1 X96.638 Y85.302 E.01574
G1 X97.059 Y85.962 E.01574
G1 X97.415 Y86.66 E.01574
G1 X97.702 Y87.389 E.01575
G1 X97.917 Y88.142 E.01575
G1 X98.059 Y88.912 E.01575
G1 X98.126 Y89.693 E.01576
G1 X98.118 Y90.479 E.0158
G1 X98.062 Y91.033 E.01119
G1 X97.987 Y91.528 E.01008
G1 X97.802 Y92.293 E.01583
G1 X97.545 Y93.034 E.01577
G1 X97.218 Y93.747 E.01577
G1 X96.823 Y94.425 E.01577
G1 X96.365 Y95.062 E.01577
G1 X95.848 Y95.651 E.01577
G1 X95.277 Y96.188 E.01576
G1 X94.656 Y96.667 E.01576
G1 X93.994 Y97.084 E.01574
G1 X93.294 Y97.435 E.01573
G1 X92.566 Y97.716 E.0157
G1 X91.815 Y97.926 E.01569
G1 X91.048 Y98.063 E.01565
G1 X90.267 Y98.127 E.01575
G1 X89.814 Y98.13 E.00911
G1 X89.411 Y98.11 E.00811
G1 X88.633 Y98.015 E.01577
G1 X87.873 Y97.847 E.01565
G1 X87.131 Y97.607 E.01569
G1 X86.402 Y97.291 E.01597
G1 X85.724 Y96.915 E.01558
G1 X85.079 Y96.47 E.01576
G1 X84.865 Y96.307 E.00541
G1 X84.485 Y95.971 E.0102
G1 X84.083 Y95.579 E.01129
G1 X83.904 Y95.378 E.00542
G1 X83.413 Y94.765 E.01577
G1 X82.985 Y94.109 E.01576
G1 X82.624 Y93.42 E.01564
G1 X82.325 Y92.682 E.01602
G1 X82.102 Y91.93 E.01577
G1 X81.952 Y91.161 E.01576
G1 X81.878 Y90.38 E.01577
G1 X81.878 Y89.596 E.01576
G1 X81.955 Y88.817 E.01575
G1 X82.106 Y88.048 E.01576
G1 X82.33 Y87.298 E.01574
G1 X82.625 Y86.572 E.01575
G1 X82.989 Y85.879 E.01574
G1 X83.418 Y85.224 E.01574
G1 X83.908 Y84.613 E.01575
G1 X84.454 Y84.052 E.01574
G1 X85.051 Y83.546 E.01574
G1 X85.695 Y83.101 E.01574
G1 X85.717 Y83.088 E.00052
M204 S250
G1 X85.57 Y82.701 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1560
M204 S5000
G1 X86.196 Y82.352 E.0134
G1 X86.949 Y82.021 E.01537
G1 X87.502 Y81.836 E.0109
G1 X88.012 Y81.693 E.00988
G1 X88.821 Y81.54 E.01538
G1 X89.639 Y81.465 E.01536
M106 S71.4
M106 S229.5
G1 F1440
G1 X90.461 Y81.47 E.01536
M106 S71.4
M106 S229.5
G1 F1560
G1 X91.279 Y81.554 E.01537
G1 X92.086 Y81.716 E.01536
M106 S71.4
M106 S229.5
G1 F1440
G1 X92.872 Y81.955 E.01536
G1 X93.632 Y82.269 E.01536
M106 S71.4
M106 S229.5
G1 F1560
G1 X94.359 Y82.654 E.01536
G1 X95.045 Y83.108 E.01538
G1 X95.502 Y83.471 E.0109
G1 X95.898 Y83.821 E.00989
G1 X96.466 Y84.418 E.01538
G1 X96.973 Y85.065 E.01536
M106 S71.4
M106 S229.5
G1 F1440
G1 X97.415 Y85.759 E.01537
M106 S71.4
M106 S229.5
G1 F1560
G1 X97.788 Y86.492 E.01537
G1 X98.09 Y87.257 E.01537
M106 S71.4
M106 S229.5
G1 F1440
G1 X98.316 Y88.048 E.01538
G1 X98.465 Y88.858 E.01537
M106 S71.4
M106 S229.5
G1 F1560
G1 X98.536 Y89.678 E.01538
G1 X98.527 Y90.502 E.0154
G1 X98.469 Y91.084 E.01093
G1 X98.389 Y91.607 E.00989
G1 X98.195 Y92.409 E.01541
G1 X97.925 Y93.187 E.01539
M106 S71.4
M106 S229.5
G1 F1440
G1 X97.581 Y93.936 E.01539
M106 S71.4
M106 S229.5
G1 F1560
G1 X97.167 Y94.648 E.0154
G1 X96.686 Y95.317 E.0154
G1 X96.143 Y95.936 E.01539
M106 S71.4
M106 S229.5
G1 F1440
G1 X95.542 Y96.5 E.01539
M106 S71.4
M106 S229.5
G1 F1560
G1 X94.891 Y97.003 E.01538
G1 X94.195 Y97.441 E.01537
G1 X93.46 Y97.809 E.01535
G1 X92.695 Y98.105 E.01533
G1 X91.906 Y98.326 E.01531
G1 X91.101 Y98.47 E.01528
G1 X90.286 Y98.536 E.01529
M106 S71.4
M106 S229.5
G1 F1440
G1 X89.806 Y98.539 E.00897
G1 X89.376 Y98.518 E.00804
M106 S71.4
M106 S229.5
G1 F1560
G1 X88.564 Y98.419 E.01529
G1 X87.765 Y98.243 E.01528
G1 X86.986 Y97.99 E.01531
G1 X86.229 Y97.662 E.01542
M106 S71.4
M106 S229.5
G1 F1440
G1 X85.973 Y97.533 E.00535
G1 X85.267 Y97.111 E.01537
G1 X84.605 Y96.623 E.01537
M106 S71.4
M106 S229.5
G1 F1560
G1 X84.206 Y96.271 E.00993
G1 X83.787 Y95.862 E.01096
M106 S71.4
M106 S229.5
G1 F1440
G1 X83.594 Y95.645 E.00541
M106 S71.4
M106 S229.5
G1 F1560
G1 X83.251 Y95.236 E.00998
M106 S71.4
M106 S229.5
G1 F1440
G1 X82.777 Y94.561 E.0154
G1 X82.371 Y93.844 E.0154
G1 X82.249 Y93.584 E.00537
M106 S71.4
M106 S229.5
G1 F1560
G1 X81.938 Y92.817 E.01547
G1 X81.704 Y92.027 E.01539
G1 X81.547 Y91.219 E.01538
G1 X81.468 Y90.399 E.01539
G1 X81.469 Y89.576 E.01538
G1 X81.549 Y88.757 E.01538
G1 X81.708 Y87.95 E.01538
G1 X81.943 Y87.162 E.01537
G1 X82.254 Y86.399 E.01538
G1 X82.636 Y85.671 E.01537
M106 S71.4
M106 S229.5
G1 F1440
G1 X83.086 Y84.983 E.01537
M106 S71.4
M106 S229.5
G1 F1560
G1 X83.601 Y84.341 E.01537
G1 X84.174 Y83.752 E.01536
M106 S71.4
M106 S229.5
G1 F1440
G1 X84.802 Y83.221 E.01537
G1 X85.478 Y82.753 E.01536
M106 S71.4
M106 S229.5
G1 F1560
G1 X85.518 Y82.731 E.00085
M106 S71.4
; WIPE_START
M204 S6000
G1 X86.196 Y82.352 E-.11071
G1 X86.949 Y82.021 E-.11723
G1 X87.329 Y81.894 E-.05706
; WIPE_END
G1 E-.015 F1800
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
G1 X0 Y90.0001 ; move to safe pos
G1 X-13.0 F3000 ; move to safe pos
M400
M1004 S5 P1  ; external shutter
M400 P300
M971 S11 C11 O0
G92 E0
G1 X0 F18000
M623

; SKIPTYPE: head_wrap_detect
M622.1 S1
M1002 judge_flag g39_3rd_layer_detect_flag
M622 J1
    ; enable nozzle clog detect at 3rd layer
    


    M622.1 S1
    M1002 judge_flag g39_detection_flag
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




G1 X90.793 Y96.084
G1 Z3.68
G1 E.3 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.419992
G1 F4800
M204 S6000
G1 X90.293 Y96.142 E.00942
G1 X89.723 Y96.142 E.01065
G1 X89.113 Y96.084 E.01145
G1 X88.511 Y95.965 E.01145
G1 X87.925 Y95.787 E.01146
G1 X87.359 Y95.552 E.01145
G1 X86.819 Y95.261 E.01145
G1 X86.31 Y94.917 E.01148
G1 X85.825 Y94.513 E.0118
G1 X85.409 Y94.089 E.0111
G1 X85.026 Y93.613 E.01143
G1 X84.69 Y93.099 E.01145
G1 X84.421 Y92.58 E.01093
G1 X84.192 Y92.013 E.01143
G1 X84.026 Y91.445 E.01105
G1 X83.916 Y90.865 E.01105
G1 X83.862 Y90.276 E.01105
G1 X83.864 Y89.685 E.01104
G1 X83.923 Y89.098 E.01103
G1 X84.038 Y88.518 E.01104
G1 X84.208 Y87.953 E.01102
G1 X84.432 Y87.407 E.01103
G1 X84.707 Y86.885 E.01102
G1 X85.03 Y86.391 E.01103
G1 X85.399 Y85.931 E.01102
G1 X85.811 Y85.509 E.01102
G1 X86.261 Y85.127 E.01103
G1 X86.739 Y84.799 E.01084
G1 X87.281 Y84.486 E.0117
G1 X87.823 Y84.252 E.01104
G1 X88.454 Y84.05 E.01238
G1 X89.054 Y83.925 E.01145
G1 X89.664 Y83.861 E.01146
G1 X90.277 Y83.858 E.01145
G1 X90.887 Y83.917 E.01146
G1 X91.488 Y84.035 E.01145
G1 X92.075 Y84.213 E.01146
G1 X92.628 Y84.443 E.01119
G1 X93.148 Y84.721 E.01102
G1 X93.646 Y85.053 E.01119
G1 X94.16 Y85.473 E.0124
G1 X94.59 Y85.91 E.01145
G1 X94.974 Y86.387 E.01145
G1 X95.309 Y86.901 E.01145
G1 X95.592 Y87.445 E.01146
G1 X95.818 Y88.014 E.01144
G1 X95.987 Y88.603 E.01145
G1 X96.094 Y89.193 E.0112
G1 X96.142 Y89.782 E.01104
G1 X96.134 Y90.38 E.01119
G1 X96.059 Y91.038 E.01237
G1 X95.926 Y91.637 E.01146
M73 P92 R1
G1 X95.734 Y92.218 E.01145
G1 X95.484 Y92.779 E.01146
G1 X95.18 Y93.311 E.01145
G1 X94.825 Y93.81 E.01146
G1 X94.421 Y94.272 E.01145
G1 X93.977 Y94.688 E.01138
G1 X93.508 Y95.048 E.01105
G1 X93.007 Y95.36 E.01103
G1 X92.479 Y95.623 E.01102
G1 X91.929 Y95.834 E.011
G1 X91.363 Y95.991 E.01099
G1 X90.853 Y96.074 E.00966
M204 S10000
G1 X90.744 Y95.692 F18000
G1 F4800
M204 S6000
G1 X90.212 Y95.747 E.01
G1 X89.703 Y95.746 E.00951
G1 X89.148 Y95.691 E.01043
G1 X88.59 Y95.579 E.01063
G1 X88.041 Y95.41 E.01072
G1 X87.512 Y95.188 E.01072
G1 X87.008 Y94.915 E.01072
G1 X86.532 Y94.592 E.01075
G1 X86.08 Y94.211 E.01104
G1 X85.692 Y93.814 E.01038
G1 X85.334 Y93.367 E.0107
G1 X85.022 Y92.886 E.01072
G1 X84.772 Y92.401 E.01019
G1 X84.559 Y91.869 E.01069
G1 X84.406 Y91.339 E.01032
G1 X84.304 Y90.796 E.01031
G1 X84.255 Y90.247 E.01031
G1 X84.258 Y89.695 E.01031
G1 X84.314 Y89.147 E.01029
G1 X84.423 Y88.606 E.01031
G1 X84.582 Y88.079 E.01029
G1 X84.791 Y87.569 E.0103
G1 X85.048 Y87.082 E.01029
G1 X85.35 Y86.621 E.01029
G1 X85.695 Y86.192 E.01029
G1 X86.079 Y85.798 E.01028
G1 X86.499 Y85.442 E.01029
G1 X86.936 Y85.14 E.00992
G1 X87.476 Y84.828 E.01166
G1 X87.977 Y84.616 E.01015
G1 X88.571 Y84.426 E.01165
G1 X89.132 Y84.312 E.01071
G1 X89.703 Y84.254 E.01072
G1 X90.277 Y84.253 E.01071
G1 X90.848 Y84.309 E.01072
G1 X91.41 Y84.421 E.01071
G1 X91.959 Y84.59 E.01072
G1 X92.474 Y84.806 E.01045
G1 X92.959 Y85.067 E.01029
G1 X93.424 Y85.379 E.01046
G1 X93.906 Y85.775 E.01167
G1 X94.308 Y86.185 E.01072
G1 X94.666 Y86.633 E.01072
G1 X94.978 Y87.114 E.01072
G1 X95.241 Y87.625 E.01073
G1 X95.451 Y88.158 E.01071
G1 X95.607 Y88.71 E.01072
G1 X95.706 Y89.261 E.01047
G1 X95.749 Y89.811 E.0103
G1 X95.74 Y90.371 E.01046
G1 X95.668 Y90.989 E.01164
G1 X95.541 Y91.549 E.01072
G1 X95.36 Y92.093 E.01071
G1 X95.125 Y92.616 E.01072
G1 X94.839 Y93.113 E.01071
G1 X94.505 Y93.58 E.01072
G1 X94.126 Y94.011 E.01072
G1 X93.709 Y94.399 E.01065
G1 X93.27 Y94.733 E.01031
G1 X92.801 Y95.024 E.0103
G1 X92.308 Y95.268 E.01029
G1 X91.794 Y95.463 E.01026
G1 X91.265 Y95.609 E.01025
G1 X90.804 Y95.683 E.00874
; WIPE_START
G1 X91.265 Y95.609 E-.06666
G1 X91.794 Y95.463 E-.07818
G1 X92.308 Y95.268 E-.07826
G1 X92.697 Y95.075 E-.0619
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X96.406 Y91.178 Z4.08 F18000
G1 Z3.68
G1 E.3 F1800
; LINE_WIDTH: 0.384381
G1 F4800
M204 S6000
G1 X96.501 Y90.535 E.01104
G1 X96.52 Y89.753 E.0133
G1 X96.478 Y89.237 E.00881
G1 X96.37 Y88.595 E.01106
G1 X96.199 Y87.968 E.01105
G1 X95.967 Y87.361 E.01105
G1 X95.674 Y86.78 E.01106
G1 X95.326 Y86.231 E.01105
G1 X94.949 Y85.749 E.0104
G1 X94.465 Y85.258 E.01172
G1 X93.977 Y84.829 E.01105
G1 X93.442 Y84.46 E.01105
G1 X92.873 Y84.144 E.01105
G1 X92.276 Y83.887 E.01105
G1 X91.656 Y83.69 E.01106
G1 X91.02 Y83.556 E.01105
G1 X90.373 Y83.486 E.01106
G1 X89.725 Y83.481 E.01102
G1 X89.116 Y83.536 E.0104
G1 X88.439 Y83.676 E.01174
G1 X87.814 Y83.854 E.01104
G1 X87.199 Y84.109 E.01132
G1 X86.548 Y84.468 E.01264
G1 X86.031 Y84.824 E.01067
G1 X85.552 Y85.23 E.01068
G1 X85.114 Y85.679 E.01067
G1 X84.721 Y86.169 E.01067
G1 X84.377 Y86.695 E.01068
G1 X84.085 Y87.25 E.01067
G1 X83.848 Y87.832 E.01068
G1 X83.668 Y88.434 E.01067
G1 X83.547 Y89.051 E.01069
G1 X83.492 Y89.561 E.00872
G1 X83.479 Y90.115 E.00941
G1 X83.523 Y90.763 E.01105
G1 X83.631 Y91.404 E.01105
G1 X83.803 Y92.031 E.01105
G1 X84.035 Y92.638 E.01105
G1 X84.327 Y93.219 E.01106
G1 X84.676 Y93.768 E.01106
G1 X85.08 Y94.277 E.01104
G1 X85.514 Y94.735 E.01072
G1 X86.02 Y95.168 E.01131
G1 X86.557 Y95.541 E.01112
G1 X87.105 Y95.846 E.01066
G1 X87.699 Y96.104 E.01101
G1 X88.294 Y96.296 E.01064
G1 X88.904 Y96.43 E.01061
G1 X89.53 Y96.506 E.01072
G1 X90.212 Y96.52 E.01159
G1 X90.841 Y96.464 E.01074
G1 X91.456 Y96.358 E.01061
G1 X91.968 Y96.219 E.00902
G1 X92.489 Y96.028 E.00942
G1 X93.077 Y95.751 E.01105
G1 X93.634 Y95.416 E.01105
G1 X94.156 Y95.028 E.01105
G1 X94.636 Y94.589 E.01106
G1 X95.07 Y94.105 E.01105
G1 X95.454 Y93.58 E.01106
G1 X95.784 Y93.02 E.01105
G1 X96.054 Y92.435 E.01095
G1 X96.254 Y91.856 E.01042
G1 X96.393 Y91.236 E.01078
M204 S10000
G1 X96.765 Y91.252 F18000
; LINE_WIDTH: 0.419992
G1 F4800
M204 S6000
G1 X96.875 Y90.573 E.01286
G1 X96.898 Y89.757 E.01524
G1 X96.852 Y89.205 E.01036
G1 X96.74 Y88.527 E.01283
G1 X96.561 Y87.864 E.01283
G1 X96.317 Y87.223 E.01282
G1 X96.01 Y86.608 E.01284
G1 X95.645 Y86.028 E.01282
G1 X95.247 Y85.516 E.01211
G1 X94.722 Y84.996 E.0138
G1 X94.211 Y84.536 E.01286
G1 X93.649 Y84.147 E.01277
G1 X93.049 Y83.812 E.01283
G1 X92.419 Y83.539 E.01282
G1 X91.766 Y83.33 E.01283
G1 X91.094 Y83.187 E.01283
G1 X90.412 Y83.111 E.01283
G1 X89.727 Y83.103 E.0128
G1 X89.081 Y83.16 E.01211
G1 X88.359 Y83.318 E.01382
G1 X87.694 Y83.498 E.01286
G1 X87.048 Y83.765 E.01306
G1 X86.361 Y84.134 E.01457
G1 X85.814 Y84.511 E.01241
G1 X85.306 Y84.939 E.01242
G1 X84.841 Y85.414 E.01241
G1 X84.424 Y85.931 E.01241
G1 X84.059 Y86.486 E.01242
G1 X83.749 Y87.074 E.01241
G1 X83.496 Y87.689 E.01243
G1 X83.35 Y88.173 E.00945
G1 X83.219 Y88.748 E.01103
G1 X83.128 Y89.428 E.01282
G1 X83.106 Y90.114 E.01282
G1 X83.151 Y90.799 E.01282
G1 X83.264 Y91.476 E.01283
G1 X83.444 Y92.138 E.01282
G1 X83.689 Y92.779 E.01282
G1 X83.996 Y93.394 E.01284
G1 X84.362 Y93.974 E.01282
G1 X84.794 Y94.513 E.0129
G1 X85.251 Y95.004 E.01255
G1 X85.778 Y95.455 E.01295
G1 X86.343 Y95.851 E.0129
G1 X86.921 Y96.176 E.01239
G1 X87.549 Y96.45 E.01279
G1 X88.178 Y96.656 E.01237
G1 X88.822 Y96.8 E.01234
G1 X89.484 Y96.882 E.01247
G1 X90.205 Y96.898 E.01346
G1 X90.872 Y96.846 E.01251
G1 X91.39 Y96.755 E.00982
G1 X91.977 Y96.606 E.01131
G1 X92.624 Y96.378 E.01282
G1 X93.245 Y96.086 E.01283
G1 X93.834 Y95.734 E.01282
G1 X94.385 Y95.325 E.01282
G1 X94.893 Y94.863 E.01283
G1 X95.353 Y94.354 E.01283
G1 X95.76 Y93.8 E.01284
M73 P92 R0
G1 X96.11 Y93.209 E.01283
G1 X96.397 Y92.592 E.01272
G1 X96.611 Y91.98 E.01213
G1 X96.753 Y91.311 E.01277
M204 S10000
G1 X97.151 Y91.332 F18000
G1 F4800
M204 S6000
G1 X97.267 Y90.612 E.01362
G1 X97.292 Y89.762 E.0159
G1 X97.245 Y89.171 E.01107
G1 X97.127 Y88.456 E.01354
G1 X96.94 Y87.756 E.01353
G1 X96.684 Y87.079 E.01353
G1 X96.362 Y86.429 E.01355
G1 X95.977 Y85.816 E.01353
G1 X95.557 Y85.273 E.01282
G1 X94.999 Y84.715 E.01475
G1 X94.456 Y84.227 E.01363
G1 X93.866 Y83.818 E.01343
G1 X93.234 Y83.464 E.01353
G1 X92.57 Y83.175 E.01353
G1 X91.88 Y82.953 E.01354
G1 X91.172 Y82.8 E.01353
G1 X90.452 Y82.719 E.01354
G1 X89.729 Y82.709 E.0135
G1 X89.046 Y82.767 E.01282
G1 X88.273 Y82.934 E.01478
G1 X87.569 Y83.124 E.01362
G1 X86.89 Y83.404 E.01372
G1 X86.169 Y83.79 E.01528
G1 X85.59 Y84.187 E.01312
G1 X85.051 Y84.638 E.01313
G1 X84.559 Y85.139 E.01312
G1 X84.117 Y85.684 E.01312
G1 X83.729 Y86.27 E.01313
G1 X83.399 Y86.891 E.01312
G1 X83.199 Y87.372 E.00975
G1 X82.999 Y87.968 E.01174
G1 X82.832 Y88.672 E.01353
G1 X82.736 Y89.39 E.01353
G1 X82.711 Y90.114 E.01353
G1 X82.758 Y90.836 E.01353
G1 X82.877 Y91.551 E.01354
G1 X83.066 Y92.25 E.01353
G1 X83.323 Y92.927 E.01353
G1 X83.646 Y93.577 E.01357
G1 X84.032 Y94.189 E.01353
G1 X84.489 Y94.763 E.0137
G1 X84.976 Y95.286 E.01336
G1 X85.524 Y95.757 E.0135
G1 X86.12 Y96.176 E.01361
G1 X86.73 Y96.52 E.01309
G1 X87.392 Y96.812 E.01351
G1 X88.056 Y97.031 E.01308
G1 X88.737 Y97.185 E.01305
G1 X89.437 Y97.274 E.01317
G1 X90.197 Y97.292 E.01422
G1 X90.904 Y97.239 E.01324
G1 X91.459 Y97.143 E.01053
G1 X92.083 Y96.986 E.01202
G1 X92.766 Y96.745 E.01353
G1 X93.422 Y96.438 E.01353
G1 X94.044 Y96.068 E.01353
G1 X94.626 Y95.637 E.01353
G1 X95.163 Y95.151 E.01354
G1 X95.649 Y94.614 E.01354
G1 X96.08 Y94.03 E.01355
G1 X96.451 Y93.408 E.01354
G1 X96.755 Y92.757 E.01343
G1 X96.984 Y92.109 E.01284
G1 X97.139 Y91.391 E.01373
; CHANGE_LAYER
; Z_HEIGHT: 3.8
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F4800
G1 X96.984 Y92.109 E-.10468
G1 X96.755 Y92.757 E-.09794
G1 X96.51 Y93.281 E-.08238
; WIPE_END
G1 E-.015 F1800
; layer num/total_layer_count: 31/33
; update layer progress
M73 L31
M991 S0 P30 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z4.08 I.472 J-1.122 P1  F18000
G1 X94.708 Y92.522 Z4.08
G1 Z3.8
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F3600
M204 S6000
G1 X94.49 Y92.9 E.00878
G1 X94.179 Y93.332 E.01072
G1 X93.817 Y93.742 E.01098
G1 X93.238 Y94.253 E.01554
G1 X92.787 Y94.561 E.01098
G1 X92.319 Y94.815 E.01071
G1 X91.828 Y95.022 E.01072
G1 X91.319 Y95.18 E.01072
G1 X90.796 Y95.285 E.01071
G1 X90.266 Y95.338 E.01071
G1 X89.733 Y95.338 E.01072
G1 X89.203 Y95.285 E.01071
G1 X88.681 Y95.18 E.01071
G1 X88.172 Y95.022 E.01072
G1 X87.681 Y94.815 E.01071
G1 X87.213 Y94.561 E.01071
G1 X86.772 Y94.26 E.01074
G1 X86.357 Y93.911 E.01091
G1 X85.992 Y93.536 E.01051
G1 X85.66 Y93.12 E.01071
G1 X85.371 Y92.673 E.01071
G1 X85.128 Y92.198 E.01072
G1 X84.933 Y91.702 E.01071
G1 X84.789 Y91.19 E.01071
G1 X84.697 Y90.665 E.01072
G1 X84.657 Y90.133 E.01071
G1 X84.67 Y89.601 E.01071
G1 X84.736 Y89.072 E.01071
G1 X84.855 Y88.552 E.01072
G1 X85.024 Y88.047 E.01071
G1 X85.244 Y87.562 E.01072
G1 X85.51 Y87.1 E.01071
G1 X85.821 Y86.668 E.01071
G1 X86.182 Y86.258 E.01097
G1 X86.762 Y85.747 E.01555
G1 X87.213 Y85.439 E.01097
G1 X87.681 Y85.185 E.01071
G1 X88.172 Y84.978 E.01071
G1 X88.681 Y84.82 E.01072
G1 X89.203 Y84.715 E.01071
G1 X89.733 Y84.662 E.01072
G1 X90.266 Y84.662 E.01071
G1 X90.796 Y84.715 E.01072
G1 X91.319 Y84.82 E.01071
G1 X91.828 Y84.978 E.01072
G1 X92.319 Y85.184 E.01071
G1 X92.787 Y85.439 E.01071
G1 X93.227 Y85.74 E.01072
G1 X93.635 Y86.082 E.01072
G1 X94.007 Y86.463 E.01071
G1 X94.339 Y86.88 E.01071
G1 X94.629 Y87.328 E.01072
G1 X94.872 Y87.802 E.01071
G1 X95.066 Y88.298 E.01071
G1 X95.211 Y88.811 E.01071
G1 X95.303 Y89.335 E.01072
G1 X95.343 Y89.867 E.01071
G1 X95.33 Y90.399 E.01071
G1 X95.263 Y90.928 E.01071
G1 X95.145 Y91.448 E.01072
G1 X94.975 Y91.953 E.01071
G1 X94.756 Y92.438 E.01072
G1 X94.738 Y92.47 E.00072
M204 S10000
G1 X94.341 Y92.309 F18000
G1 F3600
M204 S6000
G1 X94.133 Y92.669 E.00835
G1 X93.846 Y93.068 E.00986
G1 X93.517 Y93.441 E.01002
G1 X92.977 Y93.918 E.01448
G1 X92.565 Y94.198 E.01002
G1 X92.135 Y94.433 E.00986
G1 X91.683 Y94.623 E.00986
G1 X91.214 Y94.768 E.00987
G1 X90.733 Y94.865 E.00986
G1 X90.245 Y94.914 E.00986
G1 X89.755 Y94.914 E.00987
G1 X89.266 Y94.865 E.00986
G1 X88.786 Y94.768 E.00986
G1 X88.317 Y94.623 E.00987
G1 X87.865 Y94.433 E.00986
G1 X87.435 Y94.198 E.00986
G1 X87.029 Y93.922 E.00988
G1 X86.646 Y93.6 E.01005
G1 X86.311 Y93.255 E.00966
G1 X86.005 Y92.872 E.00986
G1 X85.739 Y92.46 E.00986
G1 X85.515 Y92.023 E.00987
G1 X85.336 Y91.567 E.00986
G1 X85.203 Y91.095 E.00986
G1 X85.118 Y90.612 E.00986
G1 X85.081 Y90.123 E.00986
G1 X85.094 Y89.632 E.00986
G1 X85.155 Y89.146 E.00986
G1 X85.264 Y88.667 E.00987
G1 X85.42 Y88.203 E.00986
G1 X85.622 Y87.755 E.00986
G1 X85.867 Y87.331 E.00986
G1 X86.153 Y86.932 E.00986
G1 X86.483 Y86.559 E.01002
G1 X87.023 Y86.082 E.01448
G1 X87.434 Y85.802 E.01002
G1 X87.865 Y85.567 E.00986
G1 X88.317 Y85.377 E.00986
G1 X88.786 Y85.232 E.00987
G1 X89.266 Y85.135 E.00986
G1 X89.755 Y85.086 E.00986
G1 X90.245 Y85.086 E.00986
G1 X90.733 Y85.135 E.00986
G1 X91.214 Y85.232 E.00986
G1 X91.683 Y85.377 E.00987
G1 X92.134 Y85.567 E.00986
G1 X92.565 Y85.802 E.00986
G1 X92.971 Y86.078 E.00987
G1 X93.346 Y86.393 E.00986
G1 X93.689 Y86.745 E.00986
G1 X93.995 Y87.128 E.00986
G1 X94.261 Y87.54 E.00986
G1 X94.484 Y87.977 E.00986
G1 X94.664 Y88.433 E.00986
G1 X94.796 Y88.905 E.00986
G1 X94.882 Y89.388 E.00986
G1 X94.918 Y89.877 E.00986
G1 X94.906 Y90.368 E.00986
G1 X94.845 Y90.854 E.00986
G1 X94.736 Y91.333 E.00986
G1 X94.58 Y91.797 E.00986
G1 X94.378 Y92.245 E.00986
G1 X94.371 Y92.257 E.0003
M204 S250
G1 X93.986 Y92.105 F18000
M106 S229.5
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1800
M204 S5000
G1 X93.789 Y92.447 E.00738
G1 X93.526 Y92.812 E.0084
G1 X93.227 Y93.151 E.00845
G1 X92.725 Y93.594 E.0125
G1 X92.352 Y93.849 E.00845
G1 X91.957 Y94.064 E.0084
G1 X91.542 Y94.238 E.0084
G1 X91.113 Y94.371 E.0084
G1 X90.672 Y94.46 E.0084
G1 X90.225 Y94.505 E.0084
G1 X89.775 Y94.505 E.00841
G1 X89.328 Y94.46 E.0084
G1 X88.887 Y94.371 E.0084
G1 X88.457 Y94.238 E.00841
G1 X88.043 Y94.064 E.0084
G1 X87.648 Y93.849 E.0084
G1 X87.276 Y93.595 E.00841
G1 X86.925 Y93.299 E.00858
G1 X86.618 Y92.984 E.00822
G1 X86.338 Y92.633 E.0084
G1 X86.094 Y92.255 E.0084
G1 X85.889 Y91.855 E.0084
G1 X85.724 Y91.437 E.0084
G1 X85.603 Y91.004 E.0084
G1 X85.525 Y90.561 E.0084
G1 X85.491 Y90.112 E.0084
G1 X85.502 Y89.663 E.0084
G1 X85.558 Y89.217 E.0084
G1 X85.658 Y88.778 E.0084
G1 X85.801 Y88.352 E.0084
G1 X85.986 Y87.942 E.0084
G1 X86.211 Y87.553 E.0084
G1 X86.473 Y87.188 E.0084
G1 X86.773 Y86.849 E.00845
G1 X87.274 Y86.406 E.0125
G1 X87.648 Y86.151 E.00845
G1 X88.043 Y85.936 E.0084
G1 X88.457 Y85.762 E.0084
G1 X88.887 Y85.629 E.0084
G1 X89.328 Y85.54 E.0084
G1 X89.775 Y85.495 E.0084
G1 X90.225 Y85.495 E.0084
G1 X90.672 Y85.54 E.0084
G1 X91.113 Y85.629 E.0084
G1 X91.543 Y85.762 E.00841
G1 X91.957 Y85.936 E.0084
G1 X92.351 Y86.151 E.0084
G1 X92.723 Y86.405 E.00841
G1 X93.068 Y86.694 E.0084
G1 X93.382 Y87.016 E.0084
G1 X93.662 Y87.367 E.0084
G1 X93.906 Y87.745 E.0084
G1 X94.111 Y88.145 E.0084
G1 X94.275 Y88.564 E.0084
G1 X94.397 Y88.996 E.0084
G1 X94.475 Y89.439 E.0084
G1 X94.509 Y89.888 E.0084
G1 X94.497 Y90.337 E.0084
G1 X94.442 Y90.783 E.0084
G1 X94.342 Y91.222 E.0084
G1 X94.198 Y91.648 E.0084
G1 X94.016 Y92.053 E.0083
; WIPE_START
M204 S6000
G1 X93.789 Y92.447 E-.06484
G1 X93.526 Y92.812 E-.06407
G1 X93.227 Y93.151 E-.06446
G1 X92.745 Y93.577 E-.09164
; WIPE_END
G1 E-.015
M204 S10000
G1 X88.516 Y87.223 Z4.2 F18000
G1 X85.896 Y83.286 Z4.2
G1 Z3.8
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F3600
M204 S6000
G1 X86.466 Y82.965 E.01316
G1 X87.152 Y82.66 E.01509
G1 X87.828 Y82.433 E.01434
G1 X88.192 Y82.337 E.00758
G1 X88.939 Y82.199 E.01528
G1 X89.686 Y82.133 E.01507
G1 X90.435 Y82.139 E.01506
G1 X91.181 Y82.216 E.01508
G1 X91.916 Y82.364 E.01507
G1 X92.633 Y82.581 E.01507
G1 X93.327 Y82.865 E.01507
G1 X93.99 Y83.213 E.01507
G1 X94.618 Y83.624 E.01509
G1 X95.176 Y84.068 E.01434
G1 X95.455 Y84.323 E.00759
G1 X95.976 Y84.875 E.01528
G1 X96.436 Y85.467 E.01507
G1 X96.839 Y86.1 E.01508
G1 X97.179 Y86.768 E.01508
G1 X97.454 Y87.466 E.01508
G1 X97.661 Y88.187 E.01509
G1 X97.799 Y88.924 E.01508
G1 X97.866 Y89.672 E.01509
G1 X97.861 Y90.423 E.01511
G1 X97.79 Y91.135 E.01437
G1 X97.727 Y91.507 E.0076
G1 X97.545 Y92.247 E.01531
G1 X97.297 Y92.956 E.01511
G1 X96.982 Y93.638 E.01511
G1 X96.603 Y94.288 E.01512
G1 X96.164 Y94.898 E.01511
G1 X95.669 Y95.463 E.01511
G1 X95.123 Y95.978 E.0151
G1 X94.53 Y96.439 E.0151
G1 X93.897 Y96.841 E.01508
G1 X93.229 Y97.18 E.01506
G1 X92.534 Y97.454 E.01503
G1 X91.817 Y97.66 E.01501
G1 X91.085 Y97.797 E.01496
G1 X90.333 Y97.866 E.0152
G1 X89.493 Y97.857 E.01689
G1 X88.784 Y97.778 E.01433
G1 X88.416 Y97.712 E.00753
G1 X87.683 Y97.524 E.0152
G1 X86.981 Y97.271 E.01502
G1 X86.304 Y96.951 E.01505
G1 X85.659 Y96.568 E.01508
G1 X85.054 Y96.125 E.01508
G1 X84.492 Y95.626 E.01512
G1 X84.005 Y95.103 E.01437
G1 X83.532 Y94.489 E.01558
G1 X83.128 Y93.841 E.01535
G1 X82.792 Y93.167 E.01514
G1 X82.539 Y92.512 E.01412
G1 X82.333 Y91.788 E.01515
G1 X82.198 Y91.049 E.0151
G1 X82.133 Y90.301 E.0151
G1 X82.14 Y89.55 E.0151
G1 X82.219 Y88.804 E.01509
G1 X82.368 Y88.068 E.01509
G1 X82.586 Y87.351 E.01508
G1 X82.872 Y86.657 E.01509
G1 X83.222 Y85.994 E.01507
G1 X83.634 Y85.367 E.01508
G1 X84.104 Y84.783 E.01507
G1 X84.627 Y84.246 E.01507
G1 X85.198 Y83.761 E.01507
G1 X85.813 Y83.333 E.01507
G1 X85.844 Y83.316 E.0007
M204 S10000
G1 X85.688 Y82.917 F18000
G1 F3600
M204 S6000
G1 X86.275 Y82.585 E.01357
G1 X86.998 Y82.265 E.01589
G1 X87.706 Y82.027 E.01502
G1 X88.099 Y81.923 E.00818
G1 X88.882 Y81.778 E.01601
G1 X89.669 Y81.709 E.01588
G1 X90.459 Y81.715 E.01588
G1 X91.245 Y81.796 E.01589
G1 X92.019 Y81.952 E.01588
G1 X92.775 Y82.18 E.01588
G1 X93.506 Y82.48 E.01588
G1 X94.205 Y82.847 E.01588
G1 X94.867 Y83.28 E.0159
G1 X95.451 Y83.745 E.01502
G1 X95.752 Y84.02 E.00819
G1 X96.299 Y84.599 E.01601
G1 X96.784 Y85.222 E.01588
G1 X97.207 Y85.889 E.01589
G1 X97.566 Y86.594 E.01589
G1 X97.856 Y87.329 E.01589
G1 X98.074 Y88.089 E.01591
G1 X98.22 Y88.866 E.0159
M73 P93 R0
G1 X98.29 Y89.654 E.01591
G1 X98.285 Y90.446 E.01592
G1 X98.211 Y91.191 E.01505
G1 X98.143 Y91.593 E.0082
G1 X97.952 Y92.368 E.01604
G1 X97.69 Y93.116 E.01593
G1 X97.358 Y93.835 E.01592
G1 X96.959 Y94.519 E.01593
G1 X96.496 Y95.162 E.01593
G1 X95.975 Y95.758 E.01592
G1 X95.399 Y96.301 E.01591
G1 X94.774 Y96.786 E.01591
G1 X94.107 Y97.21 E.01589
G1 X93.403 Y97.567 E.01587
G1 X92.671 Y97.856 E.01584
G1 X91.915 Y98.073 E.01582
G1 X91.144 Y98.218 E.01577
G1 X90.357 Y98.29 E.01589
G1 X90.003 Y98.298 E.00713
G1 X89.463 Y98.28 E.01087
G1 X88.724 Y98.198 E.01495
G1 X88.326 Y98.127 E.00813
G1 X87.558 Y97.93 E.01592
G1 X86.818 Y97.663 E.01583
G1 X86.105 Y97.326 E.01586
G1 X85.425 Y96.923 E.01589
G1 X84.787 Y96.456 E.0159
G1 X84.195 Y95.929 E.01593
G1 X83.685 Y95.382 E.01505
G1 X83.18 Y94.726 E.01664
G1 X82.757 Y94.048 E.01607
G1 X82.404 Y93.338 E.01594
G1 X82.136 Y92.647 E.0149
G1 X81.92 Y91.884 E.01595
G1 X81.777 Y91.106 E.01591
G1 X81.709 Y90.317 E.01592
G1 X81.716 Y89.526 E.01591
G1 X81.799 Y88.739 E.0159
G1 X81.956 Y87.964 E.01591
G1 X82.186 Y87.208 E.01589
G1 X82.488 Y86.477 E.0159
G1 X82.857 Y85.778 E.01589
G1 X83.291 Y85.118 E.01589
G1 X83.786 Y84.502 E.01589
G1 X84.337 Y83.936 E.01588
G1 X84.939 Y83.424 E.01589
G1 X85.587 Y82.973 E.01588
G1 X85.635 Y82.946 E.00111
M204 S250
G1 X85.487 Y82.56 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1560
M204 S5000
G1 X86.092 Y82.219 E.01297
G1 X86.849 Y81.883 E.01549
G1 X87.588 Y81.635 E.01456
M106 S71.4
M106 S229.5
G1 F1440
G1 X88.01 Y81.523 E.00815
M106 S71.4
M106 S229.5
G1 F1560
G1 X88.827 Y81.372 E.01553
G1 X89.653 Y81.3 E.01549
G1 X90.481 Y81.306 E.01549
M106 S71.4
M106 S229.5
G1 X91.306 Y81.391 E.01549
G1 X92.119 Y81.555 E.01549
G1 X92.912 Y81.794 E.01549
G1 X93.679 Y82.108 E.01549
G1 X94.413 Y82.494 E.01549
G1 X95.107 Y82.948 E.01549
G1 X95.717 Y83.434 E.01456
M106 S71.4
M106 S229.5
G1 F1440
G1 X96.039 Y83.728 E.00815
M106 S71.4
M106 S229.5
G1 F1560
G1 X96.61 Y84.332 E.01553
G1 X97.119 Y84.986 E.01549
G1 X97.563 Y85.686 E.0155
G1 X97.939 Y86.425 E.0155
G1 X98.244 Y87.197 E.0155
G1 X98.473 Y87.995 E.01551
G1 X98.625 Y88.81 E.0155
G1 X98.699 Y89.637 E.01551
G1 X98.694 Y90.468 E.01552
G1 X98.616 Y91.245 E.0146
M106 S71.4
M106 S229.5
G1 F1440
G1 X98.544 Y91.676 E.00816
M106 S71.4
M106 S229.5
G1 F1560
G1 X98.345 Y92.485 E.01556
G1 X98.07 Y93.269 E.01553
G1 X97.722 Y94.024 E.01553
G1 X97.303 Y94.742 E.01554
G1 X96.817 Y95.417 E.01553
G1 X96.27 Y96.042 E.01553
G1 X95.666 Y96.612 E.01552
G1 X95.01 Y97.121 E.01552
G1 X94.31 Y97.566 E.01549
G1 X93.571 Y97.941 E.01548
G1 X92.802 Y98.244 E.01544
G1 X92.009 Y98.472 E.01542
G1 X91.201 Y98.624 E.01537
G1 X90.381 Y98.699 E.01538
M106 S71.4
M106 S229.5
G1 F1440
G1 X90.001 Y98.707 E.0071
G1 X89.433 Y98.689 E.01061
M106 S71.4
M106 S229.5
G1 F1560
G1 X88.665 Y98.604 E.01444
M106 S71.4
M106 S229.5
G1 F1440
G1 X88.239 Y98.527 E.0081
M106 S71.4
M106 S229.5
G1 F1560
G1 X87.438 Y98.322 E.01545
G1 X86.661 Y98.042 E.01544
G1 X85.912 Y97.688 E.01547
G1 X85.199 Y97.264 E.01549
G1 X84.53 Y96.775 E.0155
G1 X83.909 Y96.222 E.01552
G1 X83.377 Y95.651 E.0146
M106 S71.4
M106 S229.5
G1 F1440
G1 X82.84 Y94.955 E.0164
M106 S71.4
M106 S229.5
G1 F1560
G1 X82.399 Y94.248 E.01558
G1 X82.029 Y93.504 E.01554
G1 X81.748 Y92.777 E.01456
G1 X81.521 Y91.977 E.01554
G1 X81.371 Y91.16 E.01552
G1 X81.299 Y90.333 E.01552
G1 X81.307 Y89.502 E.01552
G1 X81.394 Y88.677 E.0155
G1 X81.559 Y87.863 E.01551
G1 X81.8 Y87.07 E.0155
G1 X82.117 Y86.303 E.01551
G1 X82.504 Y85.57 E.0155
G1 X82.959 Y84.877 E.01549
G1 X83.479 Y84.23 E.01549
G1 X84.057 Y83.636 E.01549
G1 X84.689 Y83.1 E.01549
G1 X85.369 Y82.626 E.01549
G1 X85.434 Y82.589 E.00139
M106 S71.4
; WIPE_START
M204 S6000
G1 X86.092 Y82.219 E-.10748
G1 X86.849 Y81.883 E-.11814
G1 X87.244 Y81.75 E-.05938
; WIPE_END
G1 E-.015 F1800
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
G1 X0 Y90.0001 ; move to safe pos
G1 X-13.0 F3000 ; move to safe pos
M400
M1004 S5 P1  ; external shutter
M400 P300
M971 S11 C11 O0
G92 E0
G1 X0 F18000
M623

; SKIPTYPE: head_wrap_detect
M622.1 S1
M1002 judge_flag g39_3rd_layer_detect_flag
M622 J1
    ; enable nozzle clog detect at 3rd layer
    


    M622.1 S1
    M1002 judge_flag g39_detection_flag
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




G1 X94.849 Y84.879
G1 Z3.8
G1 E.3 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.419992
G1 F4800
M204 S6000
G1 X94.314 Y84.409 E.01329
G1 X93.738 Y84.009 E.01311
G1 X93.126 Y83.667 E.01311
G1 X92.482 Y83.387 E.01312
G1 X91.813 Y83.172 E.01312
G1 X91.127 Y83.025 E.01311
G1 X90.429 Y82.946 E.01313
G1 X89.74 Y82.937 E.01287
G1 X89.083 Y82.993 E.01233
G1 X88.329 Y83.148 E.01439
G1 X87.644 Y83.343 E.01329
G1 X86.996 Y83.609 E.0131
G1 X86.376 Y83.938 E.01312
G1 X85.779 Y84.336 E.01341
G1 X85.193 Y84.819 E.0142
G1 X84.722 Y85.3 E.01258
G1 X84.298 Y85.824 E.01257
G1 X83.927 Y86.385 E.01258
G1 X83.611 Y86.979 E.01257
G1 X83.41 Y87.462 E.00977
G1 X83.22 Y88.028 E.01116
G1 X83.057 Y88.711 E.01311
G1 X82.963 Y89.407 E.01312
G1 X82.938 Y90.108 E.01312
G1 X82.983 Y90.809 E.01312
G1 X83.098 Y91.502 E.01313
G1 X83.28 Y92.18 E.01312
G1 X83.521 Y92.822 E.01282
G1 X83.82 Y93.429 E.01264
G1 X84.18 Y94.01 E.01278
G1 X84.605 Y94.565 E.01306
G1 X85.04 Y95.034 E.01195
G1 X85.543 Y95.485 E.01262
G1 X86.085 Y95.884 E.01258
G1 X86.663 Y96.23 E.01258
G1 X87.269 Y96.519 E.01255
G1 X87.887 Y96.744 E.01229
G1 X88.86 Y96.972 E.01867
G1 X89.519 Y97.051 E.0124
G1 X90.272 Y97.062 E.01407
G1 X90.953 Y97.002 E.01278
G1 X91.61 Y96.881 E.01248
G1 X92.254 Y96.698 E.01251
G1 X92.879 Y96.454 E.01254
G1 X93.479 Y96.152 E.01256
G1 X94.049 Y95.793 E.01258
G1 X94.582 Y95.381 E.01259
G1 X94.976 Y95.012 E.01009
G1 X95.477 Y94.462 E.0139
G1 X95.894 Y93.897 E.01313
G1 X96.253 Y93.293 E.01312
G1 X96.542 Y92.674 E.01276
G1 X96.763 Y92.05 E.01236
G1 X96.932 Y91.295 E.01447
G1 X97.037 Y90.591 E.01329
G1 X97.062 Y89.727 E.01614
G1 X97.016 Y89.19 E.01008
G1 X96.902 Y88.497 E.01312
G1 X96.719 Y87.819 E.01312
G1 X96.47 Y87.162 E.01312
G1 X96.158 Y86.533 E.01312
G1 X95.791 Y85.948 E.01291
G1 X95.387 Y85.426 E.01233
G1 X94.891 Y84.922 E.01323
; WIPE_START
G1 X95.387 Y85.426 E-.1009
G1 X95.791 Y85.948 E-.09401
G1 X96.127 Y86.484 E-.09009
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X97.317 Y91.379 Z4.2 F18000
G1 Z3.8
G1 E.3 F1800
G1 F4800
M204 S6000
G1 X97.429 Y90.63 E.01415
G1 X97.456 Y89.73 E.01684
G1 X97.409 Y89.155 E.01078
G1 X97.289 Y88.424 E.01383
G1 X97.098 Y87.71 E.01382
G1 X96.837 Y87.018 E.01382
G1 X96.509 Y86.355 E.01382
G1 X96.123 Y85.737 E.01361
G1 X95.698 Y85.184 E.01303
G1 X95.128 Y84.601 E.01523
G1 X94.56 Y84.101 E.01415
G1 X93.954 Y83.679 E.0138
G1 X93.309 Y83.318 E.01381
G1 X92.631 Y83.022 E.01382
G1 X91.927 Y82.795 E.01382
G1 X91.204 Y82.638 E.01382
G1 X90.469 Y82.554 E.01383
G1 X89.743 Y82.543 E.01357
G1 X89.048 Y82.6 E.01303
G1 X88.247 Y82.763 E.01527
G1 X87.519 Y82.969 E.01415
G1 X86.836 Y83.249 E.01379
G1 X86.182 Y83.595 E.01382
G1 X85.553 Y84.012 E.01411
G1 X84.937 Y84.519 E.0149
G1 X84.439 Y85.025 E.01328
G1 X83.991 Y85.577 E.01327
G1 X83.713 Y85.993 E.00937
G1 X83.395 Y86.543 E.01186
G1 X83.085 Y87.215 E.01382
G1 X82.843 Y87.913 E.01382
G1 X82.671 Y88.633 E.01382
G1 X82.571 Y89.365 E.01382
G1 X82.544 Y90.104 E.01382
G1 X82.591 Y90.843 E.01382
G1 X82.71 Y91.573 E.01383
G1 X82.901 Y92.288 E.01382
G1 X83.153 Y92.965 E.0135
G1 X83.467 Y93.605 E.01332
G1 X83.846 Y94.219 E.01348
G1 X84.293 Y94.806 E.0138
G1 X84.751 Y95.303 E.01263
G1 X85.281 Y95.779 E.01331
G1 X85.852 Y96.202 E.01328
G1 X86.461 Y96.569 E.01328
G1 X87.101 Y96.875 E.01325
G1 X87.754 Y97.115 E.01299
G1 X88.771 Y97.356 E.01954
G1 X89.475 Y97.443 E.01326
G1 X90.267 Y97.456 E.0148
G1 X90.989 Y97.395 E.01353
G1 X91.682 Y97.269 E.01317
G1 X92.363 Y97.077 E.01321
G1 X93.023 Y96.821 E.01323
G1 X93.658 Y96.503 E.01326
G1 X94.26 Y96.126 E.01328
G1 X94.824 Y95.692 E.01329
G1 X95.247 Y95.299 E.0108
G1 X95.774 Y94.722 E.0146
G1 X96.214 Y94.127 E.01383
G1 X96.593 Y93.491 E.01383
G1 X96.9 Y92.839 E.01346
G1 X97.135 Y92.181 E.01307
G1 X97.304 Y91.438 E.01424
M204 S10000
G1 X96.49 Y91.197 F18000
; LINE_WIDTH: 0.55106
G1 F4800
M204 S6000
G1 X96.582 Y90.545 E.01639
G1 X96.604 Y89.888 E.01639
G1 X96.559 Y89.216 E.01677
G1 X96.451 Y88.581 E.01602
G1 X96.278 Y87.946 E.01639
G1 X96.043 Y87.331 E.0164
G1 X95.748 Y86.742 E.0164
G1 X95.402 Y86.195 E.01611
G1 X95.023 Y85.71 E.01533
G1 X94.527 Y85.198 E.01775
G1 X94.029 Y84.767 E.01639
G1 X93.488 Y84.392 E.0164
G1 X92.913 Y84.072 E.01639
G1 X92.308 Y83.811 E.01639
G1 X91.68 Y83.611 E.0164
G1 X91.036 Y83.475 E.01639
G1 X90.381 Y83.404 E.01641
G1 X89.737 Y83.398 E.01605
G1 X89.123 Y83.452 E.01533
G1 X88.422 Y83.591 E.0178
G1 X87.79 Y83.776 E.01639
G1 X87.181 Y84.027 E.01639
G1 X86.6 Y84.337 E.0164
G1 X86.04 Y84.712 E.01678
G1 X85.493 Y85.174 E.01783
G1 X85.053 Y85.623 E.01566
G1 X84.66 Y86.114 E.01566
G1 X84.314 Y86.639 E.01567
G1 X84.02 Y87.195 E.01565
G1 X83.78 Y87.777 E.01567
G1 X83.627 Y88.261 E.01264
G1 X83.505 Y88.802 E.01379
G1 X83.418 Y89.455 E.0164
G1 X83.396 Y90.112 E.01639
G1 X83.44 Y90.769 E.01639
G1 X83.548 Y91.419 E.0164
G1 X83.721 Y92.054 E.01639
G1 X83.95 Y92.656 E.01603
G1 X84.233 Y93.224 E.01578
G1 X84.572 Y93.766 E.01593
G1 X84.971 Y94.284 E.01626
G1 X85.378 Y94.719 E.01485
G1 X85.851 Y95.139 E.01574
G1 X86.358 Y95.511 E.01566
G1 X86.899 Y95.832 E.01567
G1 X87.467 Y96.1 E.01562
G1 X88.044 Y96.308 E.01529
G1 X88.963 Y96.525 E.0235
G1 X89.569 Y96.593 E.01519
G1 X90.277 Y96.602 E.01761
G1 X90.911 Y96.544 E.01586
G1 X91.525 Y96.428 E.01555
G1 X92.126 Y96.254 E.01559
G1 X92.71 Y96.024 E.01561
G1 X93.269 Y95.739 E.01564
G1 X93.801 Y95.402 E.01567
G1 X94.296 Y95.013 E.01568
G1 X94.687 Y94.655 E.01321
G1 X95.132 Y94.16 E.01657
G1 X95.521 Y93.628 E.0164
G1 X95.856 Y93.061 E.01639
G1 X96.124 Y92.481 E.01591
G1 X96.328 Y91.898 E.01538
G1 X96.477 Y91.256 E.01641
; WIPE_START
G1 X96.328 Y91.898 E-.09395
G1 X96.124 Y92.481 E-.08803
G1 X95.856 Y93.061 E-.09104
G1 X95.813 Y93.133 E-.01198
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X93.726 Y94.368 Z4.2 F18000
G1 Z3.8
G1 E.3 F1800
; LINE_WIDTH: 0.419992
G1 F4800
M204 S6000
G1 X93.318 Y94.694 E.00977
G1 X92.86 Y94.987 E.01016
G1 X92.377 Y95.235 E.01014
G1 X91.874 Y95.436 E.01012
G1 X91.355 Y95.59 E.01011
G1 X90.865 Y95.689 E.00935
G1 X90.296 Y95.746 E.01067
G1 X89.723 Y95.747 E.01072
G1 X89.152 Y95.691 E.01072
G1 X88.59 Y95.579 E.01071
G1 X88.041 Y95.41 E.01072
G1 X87.512 Y95.188 E.01072
G1 X87.008 Y94.915 E.01071
G1 X86.532 Y94.592 E.01074
G1 X86.085 Y94.217 E.01091
G1 X85.639 Y93.75 E.01206
G1 X85.322 Y93.351 E.00953
G1 X85.02 Y92.883 E.01041
G1 X84.759 Y92.375 E.01067
G1 X84.549 Y91.842 E.01071
G1 X84.392 Y91.29 E.01072
G1 X84.293 Y90.732 E.0106
G1 X84.25 Y90.188 E.01018
G1 X84.26 Y89.643 E.01019
G1 X84.32 Y89.102 E.01017
G1 X84.431 Y88.57 E.01017
G1 X84.592 Y88.05 E.01016
G1 X84.801 Y87.548 E.01017
G1 X85.056 Y87.068 E.01015
G1 X85.356 Y86.614 E.01016
G1 X85.696 Y86.191 E.01015
G1 X86.062 Y85.819 E.00975
G1 X86.504 Y85.429 E.01101
G1 X86.968 Y85.111 E.01051
G1 X87.444 Y84.848 E.01016
G1 X87.944 Y84.63 E.01019
G1 X88.571 Y84.426 E.01232
G1 X89.132 Y84.312 E.01071
G1 X89.703 Y84.254 E.01072
G1 X90.277 Y84.253 E.01071
G1 X90.848 Y84.309 E.01072
G1 X91.41 Y84.421 E.01071
G1 X91.958 Y84.59 E.01071
G1 X92.46 Y84.8 E.01016
G1 X92.939 Y85.056 E.01016
G1 X93.394 Y85.358 E.01019
G1 X93.906 Y85.775 E.01236
G1 X94.308 Y86.185 E.01071
G1 X94.666 Y86.633 E.01072
G1 X94.978 Y87.115 E.01072
M73 P94 R0
G1 X95.241 Y87.624 E.01072
G1 X95.451 Y88.158 E.01072
G1 X95.607 Y88.71 E.01071
G1 X95.703 Y89.246 E.01018
G1 X95.747 Y89.789 E.01018
G1 X95.741 Y90.335 E.01021
G1 X95.688 Y90.834 E.00937
G1 X95.541 Y91.549 E.01364
G1 X95.36 Y92.093 E.01072
G1 X95.125 Y92.616 E.01072
G1 X94.839 Y93.113 E.01071
G1 X94.505 Y93.58 E.01072
G1 X94.118 Y94.02 E.01095
G1 X93.771 Y94.328 E.00866
M204 S10000
G1 X93.987 Y94.663 F18000
G1 F4800
M204 S6000
G1 X93.54 Y95.02 E.01069
G1 X93.048 Y95.333 E.0109
G1 X92.53 Y95.598 E.01088
G1 X91.99 Y95.813 E.01086
G1 X91.488 Y95.965 E.0098
G1 X90.937 Y96.076 E.0105
G1 X90.336 Y96.139 E.0113
G1 X89.723 Y96.142 E.01145
G1 X89.113 Y96.084 E.01146
G1 X88.511 Y95.965 E.01145
G1 X87.925 Y95.787 E.01145
G1 X87.359 Y95.552 E.01145
G1 X86.819 Y95.261 E.01145
G1 X86.31 Y94.918 E.01148
G1 X85.831 Y94.519 E.01165
G1 X85.331 Y93.996 E.01351
G1 X85.019 Y93.605 E.00934
G1 X84.69 Y93.1 E.01127
G1 X84.408 Y92.555 E.01146
G1 X84.182 Y91.986 E.01144
G1 X84.013 Y91.397 E.01145
G1 X83.905 Y90.8 E.01133
G1 X83.857 Y90.218 E.01092
G1 X83.865 Y89.633 E.01092
G1 X83.929 Y89.053 E.0109
G1 X84.047 Y88.482 E.01091
G1 X84.218 Y87.924 E.0109
G1 X84.442 Y87.386 E.0109
G1 X84.715 Y86.871 E.01089
G1 X85.036 Y86.384 E.0109
G1 X85.401 Y85.93 E.01089
G1 X85.801 Y85.523 E.01067
G1 X86.24 Y85.136 E.01094
G1 X86.746 Y84.785 E.01149
G1 X87.255 Y84.502 E.01089
G1 X87.79 Y84.266 E.01093
G1 X88.302 Y84.097 E.01007
G1 X89.054 Y83.925 E.01442
G1 X89.664 Y83.861 E.01146
G1 X90.277 Y83.858 E.01145
G1 X90.887 Y83.917 E.01146
G1 X91.488 Y84.035 E.01145
G1 X92.074 Y84.213 E.01145
G1 X92.613 Y84.436 E.01089
G1 X93.128 Y84.71 E.0109
G1 X93.616 Y85.032 E.01093
G1 X94.036 Y85.37 E.01007
G1 X94.59 Y85.91 E.01445
G1 X94.974 Y86.387 E.01145
G1 X95.309 Y86.901 E.01145
G1 X95.591 Y87.445 E.01145
G1 X95.818 Y88.014 E.01145
G1 X95.987 Y88.603 E.01144
G1 X96.091 Y89.177 E.01091
G1 X96.141 Y89.759 E.01091
G1 X96.135 Y90.345 E.01095
G1 X96.079 Y90.883 E.01011
G1 X95.926 Y91.637 E.01437
G1 X95.733 Y92.219 E.01145
G1 X95.484 Y92.778 E.01145
G1 X95.18 Y93.311 E.01145
G1 X94.825 Y93.81 E.01145
G1 X94.413 Y94.281 E.01169
G1 X94.032 Y94.623 E.00958
; CHANGE_LAYER
; Z_HEIGHT: 3.92
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F4800
G1 X94.413 Y94.281 E-.07303
G1 X94.825 Y93.81 E-.08912
G1 X95.18 Y93.311 E-.08736
G1 X95.304 Y93.094 E-.03549
; WIPE_END
G1 E-.015 F1800
; layer num/total_layer_count: 32/33
; update layer progress
M73 L32
M991 S0 P31 ;notify layer change
M106 S73.95
; OBJECT_ID: 8
M204 S10000
G17
G3 Z4.2 I.841 J-.879 P1  F18000
G1 X94.707 Y92.523 Z4.2
G1 Z3.92
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F3600
M204 S6000
G1 X94.49 Y92.9 E.00874
G1 X94.178 Y93.332 E.01072
G1 X93.817 Y93.742 E.01098
G1 X93.238 Y94.253 E.01554
G1 X92.787 Y94.561 E.01097
G1 X92.319 Y94.815 E.01071
G1 X91.828 Y95.022 E.01071
G1 X91.319 Y95.179 E.01071
G1 X90.796 Y95.285 E.01072
G1 X90.266 Y95.338 E.01071
G1 X89.733 Y95.338 E.01071
G1 X89.203 Y95.285 E.01071
G1 X88.681 Y95.18 E.01071
G1 X88.172 Y95.022 E.01072
G1 X87.681 Y94.815 E.01071
G1 X87.213 Y94.561 E.01071
G1 X86.773 Y94.261 E.01071
G1 X86.364 Y93.918 E.01072
G1 X85.992 Y93.537 E.01071
G1 X85.66 Y93.12 E.01071
G1 X85.371 Y92.672 E.01072
G1 X85.127 Y92.195 E.01077
G1 X84.933 Y91.702 E.01065
G1 X84.789 Y91.189 E.01071
G1 X84.697 Y90.665 E.01072
G1 X84.657 Y90.133 E.01071
G1 X84.67 Y89.601 E.01071
G1 X84.736 Y89.072 E.01072
G1 X84.855 Y88.552 E.01072
G1 X85.024 Y88.047 E.01071
G1 X85.244 Y87.561 E.01072
G1 X85.51 Y87.1 E.01071
G1 X85.821 Y86.668 E.01072
G1 X86.182 Y86.258 E.01098
G1 X86.762 Y85.747 E.01554
G1 X87.213 Y85.439 E.01098
G1 X87.681 Y85.185 E.01071
G1 X88.172 Y84.978 E.01071
G1 X88.681 Y84.82 E.01072
G1 X89.203 Y84.715 E.01071
G1 X89.734 Y84.662 E.01072
G1 X90.27 Y84.662 E.01077
G1 X90.8 Y84.716 E.01072
G1 X91.319 Y84.82 E.01064
G1 X91.828 Y84.978 E.01072
G1 X92.319 Y85.184 E.01071
G1 X92.787 Y85.439 E.01072
G1 X93.227 Y85.739 E.01071
G1 X93.635 Y86.082 E.01072
G1 X94.007 Y86.463 E.01071
G1 X94.34 Y86.88 E.01072
G1 X94.629 Y87.328 E.01071
G1 X94.872 Y87.802 E.01072
G1 X95.066 Y88.298 E.01072
G1 X95.211 Y88.81 E.0107
G1 X95.303 Y89.335 E.01072
G1 X95.343 Y89.867 E.01071
G1 X95.33 Y90.399 E.01071
G1 X95.263 Y90.928 E.01072
G1 X95.145 Y91.448 E.01072
G1 X94.975 Y91.953 E.01071
G1 X94.756 Y92.438 E.01071
G1 X94.737 Y92.471 E.00076
M204 S10000
G1 X94.34 Y92.311 F18000
G1 F3600
M204 S6000
G1 X94.133 Y92.669 E.00832
G1 X93.846 Y93.068 E.00986
G1 X93.517 Y93.441 E.01002
G1 X92.977 Y93.918 E.01448
G1 X92.565 Y94.198 E.01001
G1 X92.135 Y94.433 E.00986
G1 X91.683 Y94.623 E.00986
G1 X91.214 Y94.768 E.00986
G1 X90.733 Y94.865 E.00987
G1 X90.245 Y94.914 E.00986
G1 X89.754 Y94.914 E.00986
G1 X89.267 Y94.865 E.00986
G1 X88.786 Y94.768 E.00986
G1 X88.317 Y94.623 E.00987
G1 X87.865 Y94.433 E.00986
G1 X87.434 Y94.198 E.00986
G1 X87.029 Y93.922 E.00986
G1 X86.653 Y93.607 E.00986
G1 X86.311 Y93.256 E.00986
G1 X86.005 Y92.872 E.00986
G1 X85.739 Y92.46 E.00987
G1 X85.514 Y92.021 E.00992
G1 X85.336 Y91.567 E.0098
G1 X85.203 Y91.095 E.00987
G1 X85.118 Y90.612 E.00986
G1 X85.081 Y90.123 E.00986
G1 X85.094 Y89.632 E.00986
G1 X85.155 Y89.146 E.00987
G1 X85.264 Y88.667 E.00987
G1 X85.42 Y88.203 E.00986
G1 X85.622 Y87.755 E.00987
G1 X85.867 Y87.331 E.00986
G1 X86.153 Y86.932 E.00986
G1 X86.483 Y86.559 E.01002
G1 X87.023 Y86.082 E.01448
G1 X87.434 Y85.802 E.01002
G1 X87.865 Y85.567 E.00986
G1 X88.317 Y85.377 E.00986
G1 X88.786 Y85.232 E.00987
G1 X89.267 Y85.135 E.00986
G1 X89.755 Y85.086 E.00987
G1 X90.248 Y85.086 E.00992
G1 X90.736 Y85.136 E.00986
G1 X91.214 Y85.232 E.0098
G1 X91.683 Y85.377 E.00987
G1 X92.134 Y85.567 E.00986
G1 X92.565 Y85.802 E.00987
G1 X92.97 Y86.078 E.00986
G1 X93.346 Y86.393 E.00986
G1 X93.689 Y86.744 E.00986
G1 X93.995 Y87.128 E.00987
G1 X94.261 Y87.54 E.00986
G1 X94.484 Y87.977 E.00987
G1 X94.664 Y88.433 E.00987
G1 X94.796 Y88.905 E.00985
G1 X94.882 Y89.388 E.00987
G1 X94.918 Y89.877 E.00986
G1 X94.906 Y90.368 E.00986
G1 X94.845 Y90.854 E.00987
G1 X94.736 Y91.333 E.00986
G1 X94.58 Y91.797 E.00986
G1 X94.378 Y92.245 E.00986
G1 X94.37 Y92.259 E.00034
M204 S250
G1 X93.985 Y92.106 F18000
M106 S229.5
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1800
M204 S5000
G1 X93.789 Y92.447 E.00735
G1 X93.526 Y92.812 E.0084
G1 X93.227 Y93.151 E.00845
G1 X92.725 Y93.594 E.0125
G1 X92.352 Y93.849 E.00845
G1 X91.957 Y94.064 E.0084
G1 X91.543 Y94.238 E.0084
G1 X91.113 Y94.371 E.0084
G1 X90.672 Y94.46 E.00841
G1 X90.225 Y94.505 E.0084
G1 X89.775 Y94.505 E.0084
G1 X89.328 Y94.46 E.0084
G1 X88.887 Y94.371 E.0084
G1 X88.457 Y94.238 E.00841
G1 X88.043 Y94.064 E.0084
G1 X87.648 Y93.849 E.0084
G1 X87.277 Y93.595 E.0084
G1 X86.932 Y93.306 E.0084
G1 X86.618 Y92.984 E.0084
G1 X86.338 Y92.633 E.0084
G1 X86.094 Y92.255 E.0084
G1 X85.888 Y91.852 E.00845
G1 X85.725 Y91.437 E.00835
G1 X85.603 Y91.004 E.00841
G1 X85.525 Y90.561 E.0084
G1 X85.491 Y90.112 E.0084
G1 X85.502 Y89.663 E.0084
G1 X85.558 Y89.217 E.00841
G1 X85.658 Y88.778 E.0084
G1 X85.801 Y88.352 E.0084
G1 X85.986 Y87.942 E.0084
G1 X86.211 Y87.553 E.0084
G1 X86.474 Y87.188 E.0084
G1 X86.773 Y86.849 E.00845
G1 X87.274 Y86.406 E.0125
G1 X87.648 Y86.151 E.00845
G1 X88.043 Y85.936 E.0084
G1 X88.457 Y85.762 E.0084
G1 X88.887 Y85.629 E.00841
G1 X89.328 Y85.54 E.0084
G1 X89.775 Y85.495 E.00841
G1 X90.227 Y85.496 E.00845
G1 X90.675 Y85.541 E.0084
G1 X91.113 Y85.629 E.00834
G1 X91.542 Y85.762 E.0084
G1 X91.957 Y85.936 E.0084
G1 X92.352 Y86.152 E.00841
G1 X92.723 Y86.405 E.0084
G1 X93.068 Y86.694 E.0084
G1 X93.381 Y87.016 E.0084
G1 X93.662 Y87.367 E.0084
G1 X93.906 Y87.745 E.0084
G1 X94.111 Y88.145 E.0084
G1 X94.275 Y88.564 E.0084
G1 X94.397 Y88.996 E.0084
G1 X94.475 Y89.439 E.0084
G1 X94.509 Y89.888 E.0084
G1 X94.497 Y90.337 E.0084
G1 X94.442 Y90.783 E.00841
G1 X94.341 Y91.222 E.0084
G1 X94.198 Y91.648 E.0084
G1 X94.015 Y92.054 E.00834
; WIPE_START
M204 S6000
G1 X93.789 Y92.447 E-.06458
G1 X93.526 Y92.812 E-.06408
G1 X93.227 Y93.151 E-.06445
G1 X92.743 Y93.578 E-.09189
; WIPE_END
G1 E-.015
M204 S10000
G1 X88.519 Y87.221 Z4.32 F18000
G1 X85.855 Y83.212 Z4.32
G1 Z3.92
G1 E.3 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F3600
M204 S6000
G1 X86.491 Y82.861 E.01459
G1 X87.19 Y82.558 E.01533
G1 X87.915 Y82.323 E.01533
G1 X88.66 Y82.159 E.01533
G1 X89.416 Y82.067 E.01532
G1 X90.182 Y82.048 E.0154
G1 X90.862 Y82.091 E.01371
G1 X91.692 Y82.227 E.0169
G1 X92.054 Y82.316 E.0075
G1 X92.617 Y82.489 E.01183
G1 X93.339 Y82.78 E.01566
G1 X93.753 Y82.985 E.00928
G1 X94.072 Y83.165 E.00738
G1 X94.642 Y83.54 E.01371
G1 X95.242 Y84.017 E.0154
G1 X95.79 Y84.545 E.01532
G1 X96.286 Y85.125 E.01533
G1 X96.724 Y85.749 E.01533
G1 X97.1 Y86.412 E.01532
G1 X97.411 Y87.108 E.01534
G1 X97.654 Y87.831 E.01534
G1 X97.826 Y88.575 E.01534
G1 X97.927 Y89.331 E.01535
G1 X97.954 Y90.093 E.01534
G1 X97.908 Y90.859 E.01542
G1 X97.806 Y91.534 E.01373
G1 X97.729 Y91.886 E.00724
G1 X97.508 Y92.63 E.0156
G1 X97.221 Y93.338 E.01536
G1 X96.867 Y94.015 E.01536
G1 X96.451 Y94.655 E.01536
G1 X95.974 Y95.253 E.01536
G1 X95.443 Y95.801 E.01535
G1 X94.862 Y96.296 E.01536
G1 X94.237 Y96.733 E.01533
G1 X93.573 Y97.107 E.01532
G1 X92.877 Y97.416 E.01531
G1 X92.156 Y97.657 E.01528
G1 X91.413 Y97.828 E.01533
G1 X90.744 Y97.921 E.0136
G1 X90.388 Y97.947 E.00718
G1 X89.675 Y97.949 E.01432
G1 X89.059 Y97.9 E.01243
G1 X88.704 Y97.849 E.00721
G1 X87.95 Y97.687 E.0155
G1 X87.226 Y97.456 E.01528
G1 X86.527 Y97.157 E.0153
G1 X85.858 Y96.792 E.01532
G1 X85.226 Y96.364 E.01533
G1 X84.637 Y95.876 E.0154
G1 X84.162 Y95.403 E.01347
G1 X83.668 Y94.815 E.01544
G1 X83.235 Y94.186 E.01536
G1 X82.865 Y93.518 E.01536
G1 X82.56 Y92.817 E.01536
G1 X82.324 Y92.091 E.01536
G1 X82.159 Y91.345 E.01536
G1 X82.066 Y90.587 E.01535
G1 X82.046 Y89.824 E.01535
G1 X82.1 Y89.062 E.01535
G1 X82.226 Y88.31 E.01534
G1 X82.424 Y87.573 E.01533
G1 X82.692 Y86.856 E.0154
G1 X82.988 Y86.242 E.01371
G1 X83.165 Y85.928 E.00724
G1 X83.594 Y85.283 E.01557
G1 X84.075 Y84.692 E.01533
G1 X84.61 Y84.149 E.01533
G1 X85.195 Y83.66 E.01532
G1 X85.804 Y83.242 E.01485
M204 S10000
G1 X85.65 Y82.84 F18000
G1 F3600
M204 S6000
G1 X86.303 Y82.479 E.015
G1 X87.04 Y82.16 E.01615
G1 X87.804 Y81.913 E.01614
G1 X88.588 Y81.74 E.01614
G1 X89.385 Y81.643 E.01615
G1 X90.19 Y81.623 E.01619
G1 X90.903 Y81.668 E.01437
G1 X91.293 Y81.72 E.0079
G1 X91.781 Y81.813 E.01
G1 X92.167 Y81.906 E.00798
G1 X92.759 Y82.089 E.01245
G1 X93.512 Y82.393 E.01634
G1 X93.951 Y82.61 E.00984
G1 X94.294 Y82.803 E.00791
G1 X94.891 Y83.196 E.01438
G1 X95.521 Y83.697 E.01619
G1 X96.099 Y84.254 E.01614
G1 X96.621 Y84.864 E.01615
G1 X97.083 Y85.522 E.01615
G1 X97.479 Y86.22 E.01614
G1 X97.807 Y86.954 E.01616
G1 X98.063 Y87.716 E.01616
G1 X98.244 Y88.499 E.01616
G1 X98.35 Y89.296 E.01617
G1 X98.379 Y90.099 E.01616
G1 X98.331 Y90.903 E.01621
G1 X98.223 Y91.612 E.0144
G1 X98.14 Y91.992 E.00783
G1 X97.909 Y92.77 E.01632
G1 X97.606 Y93.516 E.01619
G1 X97.234 Y94.23 E.01618
G1 X96.795 Y94.904 E.01618
G1 X96.293 Y95.533 E.01618
G1 X95.734 Y96.111 E.01617
G1 X95.122 Y96.633 E.01617
G1 X94.463 Y97.092 E.01615
G1 X93.764 Y97.487 E.01614
G1 X93.031 Y97.812 E.01612
G1 X92.271 Y98.065 E.0161
G1 X91.49 Y98.245 E.01611
G1 X90.788 Y98.343 E.01426
G1 X90.403 Y98.371 E.00775
G1 X89.659 Y98.373 E.01497
G1 X89.012 Y98.322 E.01305
G1 X88.629 Y98.267 E.00778
G1 X87.841 Y98.097 E.01621
G1 X87.078 Y97.854 E.01609
G1 X86.341 Y97.539 E.01612
G1 X85.637 Y97.155 E.01614
G1 X84.972 Y96.704 E.01616
G1 X84.351 Y96.19 E.0162
G1 X83.849 Y95.69 E.01424
G1 X83.33 Y95.072 E.01623
G1 X82.874 Y94.409 E.01618
G1 X82.484 Y93.706 E.01618
G1 X82.163 Y92.968 E.01618
G1 X81.914 Y92.202 E.01618
G1 X81.74 Y91.416 E.01618
G1 X81.643 Y90.618 E.01617
G1 X81.622 Y89.815 E.01617
G1 X81.678 Y89.012 E.01617
G1 X81.811 Y88.22 E.01616
G1 X82.019 Y87.444 E.01615
G1 X82.302 Y86.689 E.01619
G1 X82.612 Y86.045 E.01438
G1 X82.803 Y85.706 E.00782
G1 X83.252 Y85.032 E.01629
G1 X83.758 Y84.408 E.01615
G1 X84.322 Y83.836 E.01615
G1 X84.938 Y83.321 E.01615
G1 X85.598 Y82.869 E.01608
M204 S250
G1 X85.452 Y82.482 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3420
M204 S5000
G1 X86.123 Y82.112 E.01431
G1 X86.896 Y81.777 E.01574
G1 F3240
G1 X87.697 Y81.518 E.01574
G1 X88.519 Y81.336 E.01573
G1 X89.355 Y81.235 E.01574
G1 X90.198 Y81.213 E.01575
G1 F3420
G1 X90.943 Y81.261 E.01396
G1 F3600
G1 X91.358 Y81.316 E.00782
G1 X92.276 Y81.512 E.01753
M106 S73.95
M106 S229.5
G1 F3420
G1 X92.896 Y81.703 E.01213
G1 F3240
G1 X93.68 Y82.019 E.0158
G1 F3600
G1 X94.143 Y82.248 E.00965
G1 X94.507 Y82.454 E.00782
M106 S73.95
M106 S229.5
G1 F3420
G1 X95.131 Y82.864 E.01396
G1 F3240
G1 X95.791 Y83.389 E.01576
G1 X96.397 Y83.973 E.01573
G1 X96.945 Y84.613 E.01574
G1 X97.429 Y85.303 E.01574
G1 X97.845 Y86.035 E.01574
G1 X98.188 Y86.805 E.01575
G1 X98.457 Y87.604 E.01575
G1 X98.647 Y88.425 E.01575
G1 X98.758 Y89.261 E.01576
G1 X98.789 Y90.104 E.01575
G1 X98.738 Y90.946 E.01578
G1 F3420
G1 X98.626 Y91.686 E.01398
G1 F3600
G1 X98.536 Y92.094 E.00781
M106 S73.95
M106 S229.5
G1 F3240
G1 X98.295 Y92.905 E.01581
G1 X97.978 Y93.688 E.01578
G1 X97.588 Y94.436 E.01578
G1 X97.127 Y95.144 E.01577
G1 X96.601 Y95.804 E.01578
G1 X96.014 Y96.41 E.01576
G1 X95.372 Y96.957 E.01576
G1 X94.681 Y97.439 E.01575
G1 X93.948 Y97.853 E.01573
G1 X93.179 Y98.194 E.01572
G1 X92.382 Y98.46 E.01569
G1 X91.565 Y98.648 E.01568
G1 F3420
G1 X90.831 Y98.751 E.01384
G1 F3600
G1 X90.419 Y98.78 E.00772
M106 S73.95
M106 S229.5
G1 F3420
G1 X89.643 Y98.783 E.01448
G1 X88.967 Y98.729 E.01268
G1 F3600
G1 X88.557 Y98.67 E.00774
M106 S73.95
M106 S229.5
G1 F3240
G1 X87.736 Y98.493 E.0157
G1 X86.936 Y98.238 E.01569
G1 X86.162 Y97.908 E.01571
G1 X85.423 Y97.504 E.01573
G1 X84.726 Y97.032 E.01575
G1 X84.076 Y96.493 E.01577
G1 F3420
G1 X83.547 Y95.968 E.01393
G1 F3240
G1 X83.004 Y95.32 E.01579
G1 X82.526 Y94.625 E.01577
G1 X82.116 Y93.887 E.01577
G1 X81.78 Y93.113 E.01577
G1 F3420
G1 X81.519 Y92.31 E.01577
G1 X81.337 Y91.486 E.01578
G1 X81.234 Y90.648 E.01576
G1 X81.212 Y89.805 E.01576
G1 X81.271 Y88.964 E.01576
G1 X81.411 Y88.133 E.01575
G1 X81.629 Y87.319 E.01575
G1 X81.925 Y86.529 E.01576
G1 X82.249 Y85.855 E.01396
G1 F3600
G1 X82.454 Y85.492 E.0078
M106 S73.95
G1 F3240
G1 X82.922 Y84.789 E.01578
G1 X83.453 Y84.135 E.01574
G1 F3420
G1 X84.045 Y83.535 E.01574
G1 X84.691 Y82.995 E.01574
G1 X85.386 Y82.519 E.01574
G1 X85.4 Y82.511 E.0003
; WIPE_START
M204 S6000
G1 X86.123 Y82.112 E-.11768
G1 X86.896 Y81.777 E-.12003
G1 X87.211 Y81.675 E-.04729
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
G1 X0 Y90.0001 ; move to safe pos
G1 X-13.0 F3000 ; move to safe pos
M400
M1004 S5 P1  ; external shutter
M400 P300
M971 S11 C11 O0
G92 E0
G1 X0 F18000
M623

; SKIPTYPE: head_wrap_detect
M622.1 S1
M1002 judge_flag g39_3rd_layer_detect_flag
M622 J1
    ; enable nozzle clog detect at 3rd layer
    


    M622.1 S1
    M1002 judge_flag g39_detection_flag
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




G1 X95.722 Y87.768
G1 Z3.92
G1 E.3 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.419992
G1 F4800
M204 S6000
G1 X95.909 Y88.325 E.01097
G1 X96.042 Y88.897 E.01097
G1 X96.12 Y89.479 E.01097
G1 X96.142 Y90.065 E.01097
G1 X96.107 Y90.659 E.01111
G1 X96.035 Y91.157 E.0094
G1 X95.92 Y91.661 E.00966
G1 X95.733 Y92.219 E.01099
G1 X95.484 Y92.779 E.01145
G1 X95.18 Y93.311 E.01145
G1 X94.825 Y93.81 E.01145
G1 X94.411 Y94.283 E.01175
G1 X93.759 Y94.864 E.01631
G1 X93.258 Y95.212 E.0114
G1 X92.746 Y95.498 E.01096
G1 X92.209 Y95.734 E.01095
G1 X91.654 Y95.917 E.01093
G1 X91.076 Y96.048 E.01107
G1 X90.336 Y96.139 E.01394
G1 X89.723 Y96.142 E.01145
G1 X89.113 Y96.084 E.01145
G1 X88.512 Y95.965 E.01145
G1 X87.925 Y95.787 E.01146
G1 X87.359 Y95.552 E.01145
G1 X86.819 Y95.261 E.01145
G1 X86.311 Y94.919 E.01145
G1 X85.84 Y94.527 E.01146
G1 X85.485 Y94.167 E.00944
G1 X85.102 Y93.709 E.01115
G1 X84.771 Y93.224 E.01099
G1 X84.487 Y92.709 E.01098
G1 X84.254 Y92.169 E.01098
G1 X84.073 Y91.61 E.01099
G1 X83.946 Y91.036 E.01098
G1 X83.875 Y90.453 E.01098
G1 X83.86 Y89.865 E.01098
G1 X83.9 Y89.279 E.01098
G1 X83.997 Y88.7 E.01097
G1 X84.148 Y88.133 E.01096
G1 X84.355 Y87.577 E.0111
G1 X84.569 Y87.122 E.00939
G1 X84.82 Y86.689 E.00934
G1 X85.175 Y86.19 E.01145
G1 X85.589 Y85.717 E.01175
G1 X86.24 Y85.136 E.01631
G1 X86.769 Y84.769 E.01202
G1 X87.306 Y84.474 E.01145
G1 X87.846 Y84.243 E.01099
G1 X88.405 Y84.065 E.01096
G1 X88.979 Y83.94 E.01097
G1 X89.562 Y83.872 E.01096
G1 X90.157 Y83.859 E.01112
G1 X90.663 Y83.894 E.00949
G1 X91.311 Y83.999 E.01225
G1 X92.044 Y84.203 E.01422
G1 X92.597 Y84.43 E.01117
G1 X93.165 Y84.731 E.01201
G1 X93.592 Y85.016 E.00958
G1 X94.056 Y85.386 E.01111
G1 X94.477 Y85.794 E.01095
G1 X94.858 Y86.241 E.01097
G1 X95.194 Y86.722 E.01096
G1 X95.483 Y87.232 E.01095
G1 X95.697 Y87.714 E.00984
; WIPE_START
G1 X95.483 Y87.232 E-.07507
G1 X95.194 Y86.722 E-.08353
G1 X94.858 Y86.241 E-.0836
G1 X94.663 Y86.013 E-.0428
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X91.75 Y93.067 Z4.32 F18000
G1 X90.277 Y96.636 Z4.32
G1 Z3.92
G1 E.3 F1800
; LINE_WIDTH: 0.634167
G1 F4800
M204 S6000
G1 X90.937 Y96.58 E.0191
G1 X91.587 Y96.453 E.01911
G1 X92.222 Y96.263 E.0191
G1 X92.834 Y96.011 E.0191
G1 X93.419 Y95.699 E.01911
G1 X93.982 Y95.322 E.01955
G1 X94.546 Y94.845 E.0213
G1 X94.991 Y94.388 E.01838
G1 X95.389 Y93.889 E.0184
G1 X95.737 Y93.354 E.0184
G1 X96.032 Y92.789 E.0184
G1 X96.268 Y92.209 E.01806
G1 X96.525 Y91.269 E.0281
G1 X96.607 Y90.722 E.01595
G1 X96.646 Y90.078 E.0186
M73 P95 R0
G1 X96.622 Y89.441 E.01837
G1 X96.538 Y88.809 E.01838
G1 X96.394 Y88.188 E.01838
G1 X96.191 Y87.584 E.01838
G1 X95.931 Y87.002 E.01837
G1 X95.618 Y86.449 E.01835
G1 X95.252 Y85.927 E.01837
G1 X94.838 Y85.443 E.01838
G1 X94.48 Y85.091 E.01445
G1 X94.055 Y84.736 E.01598
G1 X93.512 Y84.357 E.01909
G1 X92.932 Y84.036 E.01911
G1 X92.324 Y83.774 E.0191
G1 X91.691 Y83.576 E.01911
G1 X91.047 Y83.439 E.01899
G1 X90.39 Y83.366 E.01908
G1 X89.724 Y83.361 E.01919
G1 X89.063 Y83.421 E.01914
G1 X88.413 Y83.546 E.0191
G1 X87.778 Y83.736 E.01911
G1 X87.165 Y83.988 E.0191
G1 X86.58 Y84.3 E.01911
G1 X86.017 Y84.677 E.01956
G1 X85.499 Y85.114 E.01953
G1 X85.05 Y85.565 E.01836
G1 X84.655 Y86.05 E.01801
G1 X84.134 Y86.871 E.02805
G1 X83.896 Y87.37 E.01593
G1 X83.67 Y87.973 E.01858
G1 X83.505 Y88.588 E.01836
G1 X83.4 Y89.217 E.01838
G1 X83.355 Y89.853 E.01839
G1 X83.372 Y90.49 E.01839
G1 X83.449 Y91.123 E.01839
G1 X83.587 Y91.746 E.0184
G1 X83.784 Y92.353 E.0184
G1 X84.039 Y92.939 E.0184
G1 X84.348 Y93.497 E.0184
G1 X84.635 Y93.924 E.01484
G1 X84.982 Y94.356 E.01598
G1 X85.439 Y94.835 E.0191
G1 X85.943 Y95.266 E.01912
G1 X86.487 Y95.644 E.0191
G1 X87.066 Y95.966 E.01911
G1 X87.675 Y96.229 E.01911
G1 X88.275 Y96.42 E.01817
G1 X88.956 Y96.559 E.02005
G1 X89.614 Y96.636 E.0191
G1 X90.217 Y96.636 E.01738
; WIPE_START
G1 X89.614 Y96.636 E-.08587
G1 X88.956 Y96.559 E-.09437
G1 X88.275 Y96.42 E-.09908
G1 X88.237 Y96.408 E-.00568
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X84.268 Y90.423 Z4.32 F18000
G1 Z3.92
G1 E.3 F1800
; LINE_WIDTH: 0.419992
G1 F4800
M204 S6000
G1 X84.254 Y89.875 E.01024
G1 X84.292 Y89.328 E.01024
G1 X84.381 Y88.788 E.01024
G1 X84.522 Y88.259 E.01023
G1 X84.715 Y87.739 E.01037
G1 X85.161 Y86.886 E.01798
G1 X85.495 Y86.42 E.01072
G1 X85.884 Y85.977 E.01102
G1 X86.501 Y85.431 E.01539
G1 X86.991 Y85.095 E.0111
G1 X87.494 Y84.82 E.01072
G1 X88 Y84.606 E.01025
G1 X88.522 Y84.441 E.01023
G1 X89.057 Y84.327 E.01023
G1 X89.601 Y84.264 E.01023
G1 X90.156 Y84.253 E.01038
G1 X90.851 Y84.309 E.01303
G1 X91.41 Y84.421 E.01065
G1 X91.928 Y84.58 E.01012
G1 X92.444 Y84.793 E.01044
G1 X92.977 Y85.077 E.01127
G1 X93.466 Y85.407 E.01104
G1 X93.906 Y85.775 E.01072
G1 X94.308 Y86.185 E.01072
G1 X94.666 Y86.633 E.01072
G1 X94.978 Y87.114 E.01071
G1 X95.241 Y87.625 E.01072
G1 X95.451 Y88.158 E.01072
G1 X95.607 Y88.71 E.01071
G1 X95.708 Y89.275 E.01073
G1 X95.752 Y89.847 E.01072
G1 X95.739 Y90.42 E.01071
G1 X95.668 Y90.99 E.01072
G1 X95.541 Y91.549 E.01072
G1 X95.36 Y92.093 E.01072
G1 X95.125 Y92.616 E.01072
G1 X94.839 Y93.113 E.01072
G1 X94.505 Y93.58 E.01072
G1 X94.115 Y94.022 E.01101
G1 X93.499 Y94.569 E.0154
G1 X93.036 Y94.886 E.01048
G1 X92.557 Y95.152 E.01023
G1 X92.056 Y95.37 E.01022
G1 X91.538 Y95.54 E.01019
G1 X90.998 Y95.662 E.01033
G1 X90.296 Y95.746 E.01321
G1 X89.723 Y95.747 E.01072
G1 X89.152 Y95.691 E.01072
G1 X88.59 Y95.579 E.01071
G1 X88.041 Y95.41 E.01072
G1 X87.512 Y95.188 E.01072
G1 X87.008 Y94.915 E.01072
G1 X86.533 Y94.593 E.01071
G1 X86.093 Y94.225 E.01072
G1 X85.767 Y93.892 E.00871
G1 X85.411 Y93.463 E.01041
G1 X85.102 Y93.01 E.01025
G1 X84.838 Y92.529 E.01024
G1 X84.621 Y92.025 E.01025
G1 X84.452 Y91.503 E.01026
G1 X84.334 Y90.967 E.01025
G1 X84.275 Y90.483 E.00912
; WIPE_START
G1 X84.334 Y90.967 E-.06956
G1 X84.452 Y91.503 E-.07816
G1 X84.621 Y92.025 E-.07822
G1 X84.785 Y92.406 E-.05906
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X83.977 Y86.18 Z4.32 F18000
G1 Z3.92
G1 E.3 F1800
G1 F4800
M204 S6000
G1 X83.694 Y86.627 E.00989
G1 X83.432 Y87.172 E.01129
G1 X83.19 Y87.819 E.01291
G1 X83.012 Y88.481 E.0128
G1 X82.899 Y89.157 E.01282
G1 X82.851 Y89.842 E.01282
G1 X82.868 Y90.528 E.01282
G1 X82.952 Y91.209 E.01282
G1 X83.1 Y91.879 E.01283
G1 X83.312 Y92.532 E.01283
G1 X83.586 Y93.162 E.01283
G1 X83.919 Y93.762 E.01283
G1 X84.308 Y94.328 E.01283
G1 X84.754 Y94.859 E.01295
G1 X85.177 Y95.28 E.01116
G1 X85.709 Y95.721 E.0129
G1 X86.277 Y96.105 E.01281
G1 X86.878 Y96.433 E.01279
G1 X87.507 Y96.702 E.01278
G1 X88.151 Y96.907 E.01263
G1 X89.162 Y97.102 E.01923
G1 X89.699 Y97.145 E.01007
G1 X90.673 Y97.12 E.0182
G1 X91.267 Y97.037 E.01122
G1 X91.938 Y96.882 E.01287
G1 X92.586 Y96.666 E.01276
G1 X93.212 Y96.388 E.01279
G1 X93.808 Y96.052 E.0128
G1 X94.37 Y95.66 E.0128
G1 X94.893 Y95.215 E.01283
G1 X95.37 Y94.722 E.01282
G1 X95.798 Y94.185 E.01283
G1 X96.173 Y93.609 E.01283
G1 X96.491 Y93 E.01283
G1 X96.746 Y92.37 E.01271
G1 X97.018 Y91.373 E.01931
G1 X97.109 Y90.775 E.01131
G1 X97.15 Y90.084 E.01293
G1 X97.126 Y89.423 E.01236
G1 X97.038 Y88.743 E.01281
G1 X96.885 Y88.074 E.01281
G1 X96.669 Y87.424 E.01281
G1 X96.392 Y86.797 E.01281
G1 X96.056 Y86.2 E.0128
G1 X95.664 Y85.638 E.0128
G1 X95.325 Y85.238 E.00979
G1 X94.905 Y84.808 E.01124
G1 X94.365 Y84.346 E.01328
G1 X93.787 Y83.939 E.0132
G1 X93.164 Y83.595 E.0133
G1 X92.51 Y83.312 E.01331
G1 X91.826 Y83.1 E.01338
G1 X91.128 Y82.949 E.01335
G1 X90.421 Y82.868 E.01329
G1 X89.711 Y82.863 E.01326
G1 X89.003 Y82.927 E.01329
G1 X88.306 Y83.06 E.01327
G1 X87.624 Y83.262 E.01328
G1 X86.967 Y83.53 E.01327
G1 X86.339 Y83.862 E.01328
G1 X85.734 Y84.264 E.01357
G1 X85.174 Y84.725 E.01355
G1 X84.691 Y85.211 E.01281
G1 X84.265 Y85.732 E.01258
G1 X84.009 Y86.129 E.00883
M204 S10000
G1 X83.702 Y85.878 F18000
G1 F4800
M204 S6000
G1 X83.349 Y86.436 E.01233
G1 X83.069 Y87.017 E.01205
G1 X82.814 Y87.698 E.0136
G1 X82.627 Y88.397 E.01351
G1 X82.507 Y89.111 E.01353
G1 X82.456 Y89.833 E.01353
G1 X82.475 Y90.557 E.01353
G1 X82.563 Y91.275 E.01353
G1 X82.719 Y91.983 E.01354
G1 X82.943 Y92.672 E.01354
G1 X83.232 Y93.336 E.01353
G1 X83.584 Y93.97 E.01354
G1 X83.994 Y94.567 E.01354
G1 X84.463 Y95.126 E.01364
G1 X84.912 Y95.573 E.01183
G1 X85.472 Y96.036 E.01359
G1 X86.071 Y96.442 E.01352
G1 X86.705 Y96.788 E.0135
G1 X87.369 Y97.072 E.01349
G1 X88.054 Y97.29 E.01342
G1 X89.109 Y97.493 E.02008
G1 X89.689 Y97.539 E.01087
G1 X90.705 Y97.513 E.019
G1 X91.339 Y97.425 E.01196
G1 X92.045 Y97.262 E.01354
G1 X92.729 Y97.034 E.01347
G1 X93.389 Y96.741 E.0135
G1 X94.019 Y96.386 E.0135
G1 X94.611 Y95.972 E.01351
G1 X95.163 Y95.502 E.01354
G1 X95.667 Y94.982 E.01353
G1 X96.118 Y94.416 E.01354
G1 X96.514 Y93.808 E.01354
G1 X96.849 Y93.166 E.01354
G1 X97.12 Y92.496 E.01351
G1 X97.404 Y91.455 E.02017
G1 X97.501 Y90.816 E.01207
G1 X97.545 Y90.089 E.01362
G1 X97.52 Y89.409 E.01271
G1 X97.429 Y88.691 E.01352
G1 X97.269 Y87.985 E.01352
G1 X97.043 Y87.298 E.01352
G1 X96.752 Y86.636 E.01351
G1 X96.504 Y86.19 E.00954
G1 X96.157 Y85.653 E.01195
G1 X95.695 Y85.064 E.01398
G1 X95.178 Y84.524 E.01397
G1 X94.61 Y84.037 E.01398
G1 X94.003 Y83.61 E.01386
G1 X93.347 Y83.246 E.01403
G1 X92.657 Y82.947 E.01405
G1 X91.933 Y82.721 E.01418
G1 X91.192 Y82.56 E.01418
G1 X90.446 Y82.475 E.01402
G1 X89.702 Y82.469 E.01392
G1 X88.955 Y82.535 E.014
G1 X88.221 Y82.675 E.01397
G1 X87.503 Y82.887 E.01398
G1 X86.81 Y83.168 E.01398
G1 X86.148 Y83.517 E.01398
G1 X85.511 Y83.939 E.01427
G1 X84.921 Y84.422 E.01425
G1 X84.41 Y84.934 E.01351
G1 X84.078 Y85.336 E.00975
G1 X83.736 Y85.829 E.0112
; CHANGE_LAYER
; Z_HEIGHT: 4.04
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F4800
G1 X84.078 Y85.336 E-.08543
G1 X84.41 Y84.934 E-.07432
G1 X84.921 Y84.422 E-.10305
G1 X85.041 Y84.324 E-.0222
; WIPE_END
G1 E-.015 F1800
; layer num/total_layer_count: 33/33
; update layer progress
M73 L33
M991 S0 P32 ;notify layer change
M106 S63.75
; OBJECT_ID: 8
M204 S10000
G17
G3 Z4.32 I-.798 J.918 P1  F18000
G1 X94.011 Y92.122 Z4.32
G1 Z4.04
G1 E.3 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
M204 S5000
G1 X93.935 Y92.272 E.00314
G1 X93.689 Y92.652 E.00846
G1 X93.407 Y93.006 E.00846
G1 X93.09 Y93.331 E.00847
G1 X92.743 Y93.622 E.00847
G1 X92.369 Y93.877 E.00846
G1 X91.971 Y94.094 E.00847
G1 X91.554 Y94.27 E.00846
G1 X91.121 Y94.403 E.00847
G1 X90.677 Y94.493 E.00847
G1 X90.226 Y94.538 E.00846
G1 X89.773 Y94.538 E.00846
G1 X89.323 Y94.493 E.00846
G1 X88.879 Y94.403 E.00846
G1 X88.446 Y94.27 E.00847
G1 X88.028 Y94.094 E.00846
G1 X87.631 Y93.877 E.00847
G1 X87.256 Y93.622 E.00846
G1 X86.909 Y93.331 E.00847
G1 X86.593 Y93.007 E.00846
G1 X86.311 Y92.652 E.00847
G1 X86.065 Y92.272 E.00847
G1 X85.858 Y91.869 E.00846
G1 X85.693 Y91.447 E.00846
G1 X85.57 Y91.011 E.00847
G1 X85.491 Y90.565 E.00846
G1 X85.458 Y90.113 E.00847
G1 X85.469 Y89.661 E.00846
G1 X85.525 Y89.211 E.00846
G1 X85.626 Y88.769 E.00846
G1 X85.77 Y88.34 E.00846
G1 X85.956 Y87.927 E.00846
G1 X86.183 Y87.535 E.00846
G1 X86.447 Y87.167 E.00846
G1 X86.747 Y86.827 E.00847
G1 X87.079 Y86.519 E.00846
G1 X87.44 Y86.246 E.00846
G1 X87.827 Y86.01 E.00847
G1 X88.235 Y85.813 E.00846
G1 X88.66 Y85.658 E.00846
G1 X89.099 Y85.546 E.00846
G1 X89.546 Y85.479 E.00843
G1 X90.226 Y85.462 E.01273
G1 X90.677 Y85.507 E.00846
G1 X91.121 Y85.597 E.00847
G1 X91.554 Y85.73 E.00846
G1 X91.971 Y85.906 E.00846
G1 X92.369 Y86.123 E.00847
G1 X92.743 Y86.378 E.00846
G1 X93.09 Y86.669 E.00847
G1 X93.407 Y86.994 E.00847
G1 X93.689 Y87.348 E.00846
G1 X93.935 Y87.728 E.00847
G1 X94.141 Y88.131 E.00846
G1 X94.307 Y88.553 E.00846
G1 X94.43 Y88.989 E.00847
G1 X94.508 Y89.435 E.00846
G1 X94.542 Y89.889 E.00852
G1 X94.509 Y90.563 E.01259
G1 X94.43 Y91.011 E.00851
G1 X94.307 Y91.447 E.00847
G1 X94.141 Y91.869 E.00846
G1 X94.039 Y92.069 E.00421
; WIPE_START
M204 S6000
G1 X93.935 Y92.272 E-.03248
G1 X93.689 Y92.652 E-.06455
G1 X93.407 Y93.006 E-.06454
G1 X93.09 Y93.331 E-.06456
G1 X92.774 Y93.596 E-.05888
; WIPE_END
G1 E-.015
M204 S10000
G1 X88.53 Y87.253 Z4.44 F18000
G1 X85.389 Y82.559 Z4.44
G1 Z4.04
G1 E.3 F1800
M204 S5000
G1 X85.434 Y82.528 E.00101
G1 X86.201 Y82.111 E.01631
G1 X87.005 Y81.772 E.01631
G1 X87.839 Y81.514 E.01631
G1 X88.695 Y81.342 E.01631
G1 X89.564 Y81.255 E.01631
G1 X90.369 Y81.253 E.01505
G1 X90.87 Y81.287 E.00937
G1 X91.735 Y81.417 E.01635
G1 X92.581 Y81.633 E.01631
G1 X93.401 Y81.931 E.01631
G1 X94.187 Y82.31 E.01631
G1 X94.932 Y82.765 E.01631
G1 X95.628 Y83.292 E.01631
G1 X96.268 Y83.886 E.01631
G1 X96.846 Y84.54 E.01631
G1 X97.355 Y85.249 E.01631
G1 X97.792 Y86.005 E.01631
G1 X98.151 Y86.801 E.01631
G1 X98.429 Y87.628 E.01631
G1 X98.623 Y88.48 E.01631
G1 X98.732 Y89.346 E.01631
G1 X98.753 Y90.218 E.01631
G1 X98.688 Y91.089 E.01632
G1 X98.537 Y91.949 E.01631
G1 X98.3 Y92.789 E.01631
G1 X97.981 Y93.601 E.01631
G1 X97.583 Y94.378 E.01631
G1 X97.109 Y95.111 E.01631
G1 X96.565 Y95.794 E.01631
G1 X95.956 Y96.419 E.01631
G1 X95.287 Y96.98 E.01631
G1 X94.566 Y97.472 E.01632
G1 X93.799 Y97.889 E.01631
G1 X92.995 Y98.228 E.01631
G1 X92.16 Y98.486 E.01631
G1 X91.305 Y98.659 E.01631
G1 X90.436 Y98.745 E.01631
G1 X89.563 Y98.745 E.01631
G1 X88.695 Y98.658 E.01631
G1 X87.839 Y98.486 E.01631
G1 X87.005 Y98.228 E.01631
G1 X86.2 Y97.889 E.01631
G1 X85.434 Y97.472 E.01631
G1 X84.713 Y96.98 E.01631
G1 X84.044 Y96.419 E.01631
G1 X83.48 Y95.843 E.01506
G1 X83.155 Y95.461 E.00937
G1 X82.644 Y94.751 E.01635
G1 X82.208 Y93.995 E.01631
G1 X81.849 Y93.199 E.01631
G1 X81.571 Y92.372 E.01631
G1 X81.377 Y91.52 E.01631
G1 X81.268 Y90.654 E.01631
G1 X81.246 Y89.782 E.01631
G1 X81.312 Y88.911 E.01632
G1 X81.463 Y88.052 E.01631
G1 X81.699 Y87.211 E.01631
G1 X82.018 Y86.399 E.01631
G1 X82.417 Y85.622 E.01631
G1 X82.89 Y84.889 E.01631
G1 X83.435 Y84.206 E.01631
G1 X84.044 Y83.581 E.01631
G1 X84.713 Y83.02 E.01631
G1 X85.34 Y82.593 E.01418
; WIPE_START
M204 S6000
G1 X85.434 Y82.528 E-.01625
G1 X86.201 Y82.111 E-.12441
G1 X87.005 Y81.772 E-.12439
G1 X87.139 Y81.731 E-.01995
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
G1 X0 Y90.0001 ; move to safe pos
G1 X-13.0 F3000 ; move to safe pos
M400
M1004 S5 P1  ; external shutter
M400 P300
M971 S11 C11 O0
G92 E0
G1 X0 F18000
M623

; SKIPTYPE: head_wrap_detect
M622.1 S1
M1002 judge_flag g39_3rd_layer_detect_flag
M622 J1
    ; enable nozzle clog detect at 3rd layer
    


    M622.1 S1
    M1002 judge_flag g39_detection_flag
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




G1 X97.652 Y86.222
G1 Z4.04
G1 E.3 F1800
; FEATURE: Top surface
G1 F3600
M204 S2000
G1 X93.788 Y82.358 E.10212
G1 X92.824 Y81.952
G1 X98.048 Y87.176 E.13805
G1 X98.284 Y87.97
G1 X92.031 Y81.716 E.16525
G1 X91.333 Y81.576
G1 X98.429 Y88.672 E.18751
G1 X98.509 Y89.309
G1 X90.691 Y81.492 E.20657
G1 X90.112 Y81.47
G1 X98.528 Y89.886 E.2224
G1 X98.52 Y90.435
G1 X89.557 Y81.473 E.23683
G1 X89.051 Y81.524
G1 X98.481 Y90.954 E.2492
G1 X98.407 Y91.437
G1 X88.559 Y81.59 E.26022
G1 X88.095 Y81.684
G1 X92.19 Y85.779 E.10821
G1 X91.27 Y85.416
G1 X87.653 Y81.799 E.09558
G1 X87.227 Y81.93
G1 X90.576 Y85.279 E.08849
G1 X89.99 Y85.251
G1 X86.823 Y82.084 E.08369
G1 X86.431 Y82.249
G1 X89.455 Y85.274 E.07992
G1 X88.978 Y85.354
G1 X86.059 Y82.435 E.07713
G1 X85.698 Y82.632
G1 X88.538 Y85.472 E.07506
G1 X88.131 Y85.622
G1 X85.354 Y82.845 E.07339
G1 X85.023 Y83.071
G1 X87.755 Y85.804 E.0722
G1 X87.406 Y86.012
G1 X84.704 Y83.31 E.07141
G1 X84.401 Y83.565
G1 X87.082 Y86.245 E.07084
G1 X86.78 Y86.501
G1 X84.106 Y83.828 E.07065
G1 X83.831 Y84.11
G1 X86.5 Y86.779 E.07054
G1 X86.243 Y87.08
G1 X83.56 Y84.396 E.0709
G1 X83.313 Y84.707
G1 X86.01 Y87.404 E.07128
G1 X85.805 Y87.756
G1 X83.065 Y85.017 E.07239
G1 X82.847 Y85.356
G1 X85.625 Y88.134 E.07342
G1 X85.474 Y88.541
G1 X82.628 Y85.694 E.07521
G1 X82.436 Y86.06
G1 X85.356 Y88.98 E.07716
G1 X85.276 Y89.457
G1 X82.247 Y86.428 E.08004
G1 X82.085 Y86.824
G1 X85.244 Y89.983 E.08349
G1 X85.274 Y90.571
G1 X81.927 Y87.224 E.08845
G1 X81.8 Y87.654
G1 X85.418 Y91.273 E.09562
G1 X85.78 Y92.192
G1 X81.678 Y88.089 E.10841
; WIPE_START
M204 S6000
G1 X83.092 Y89.504 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X90.637 Y88.354 Z4.44 F18000
G1 X94.219 Y87.808 Z4.44
G1 Z4.04
G1 E.3 F1800
G1 F3600
M204 S2000
G1 X98.322 Y91.91 E.10842
G1 X98.2 Y92.346
G1 X94.581 Y88.727 E.09562
G1 X94.725 Y89.429
G1 X98.072 Y92.776 E.08845
G1 X97.915 Y93.176
G1 X94.753 Y90.014 E.08356
G1 X94.727 Y90.545
G1 X97.753 Y93.571 E.07997
G1 X97.564 Y93.94
G1 X94.648 Y91.024 E.07707
G1 X94.528 Y91.462
G1 X97.372 Y94.305 E.07515
G1 X97.153 Y94.644
M73 P96 R0
G1 X94.375 Y91.866 E.0734
G1 X94.194 Y92.242
G1 X96.934 Y94.983 E.07242
G1 X96.687 Y95.293
G1 X93.986 Y92.592 E.07138
G1 X93.754 Y92.918
G1 X96.44 Y95.603 E.07096
G1 X96.169 Y95.89
G1 X93.5 Y93.221 E.07052
G1 X93.223 Y93.502
G1 X95.893 Y96.172 E.07055
G1 X95.599 Y96.435
G1 X92.92 Y93.757 E.07078
G1 X92.593 Y93.987
G1 X95.296 Y96.69 E.07142
G1 X94.977 Y96.929
G1 X92.242 Y94.193 E.07228
G1 X91.865 Y94.374
G1 X94.646 Y97.155 E.07348
G1 X94.302 Y97.368
G1 X91.459 Y94.526 E.07512
G1 X91.021 Y94.645
G1 X93.941 Y97.565 E.07717
G1 X93.569 Y97.751
G1 X90.543 Y94.724 E.07997
G1 X90.016 Y94.755
G1 X93.177 Y97.916 E.08354
G1 X92.773 Y98.07
G1 X89.424 Y94.721 E.08849
G1 X88.73 Y94.584
G1 X92.347 Y98.201 E.09558
G1 X91.904 Y98.316
G1 X87.81 Y94.222 E.1082
; WIPE_START
M204 S6000
G1 X89.224 Y95.636 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X91.441 Y98.41 Z4.44 F18000
G1 Z4.04
G1 E.3 F1800
G1 F3600
M204 S2000
G1 X81.593 Y88.562 E.26022
G1 X81.519 Y89.046
G1 X90.949 Y98.476 E.2492
G1 X90.442 Y98.527
G1 X81.48 Y89.564 E.23684
G1 X81.471 Y90.113
G1 X89.887 Y98.529 E.22238
G1 X89.302 Y98.501
G1 X81.491 Y90.691 E.2064
G1 X81.571 Y91.328
G1 X88.677 Y98.434 E.18777
G1 X87.978 Y98.292
G1 X81.715 Y92.03 E.16549
G1 X81.951 Y92.823
G1 X87.185 Y98.057 E.13829
G1 X86.227 Y97.657
G1 X82.348 Y93.777 E.10251
; WIPE_START
M204 S6000
G1 X83.762 Y95.191 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X90.296 Y91.247 Z4.44 F18000
G1 X97.859 Y86.681 Z4.44
G1 Z4.04
G1 E.3 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.0948778
G1 F2400
M204 S6000
G1 X97.768 Y86.55 E.00052
; LINE_WIDTH: 0.138518
G1 X97.678 Y86.418 E.00085
; LINE_WIDTH: 0.182158
G1 X97.587 Y86.287 E.00118
; WIPE_START
G1 X97.678 Y86.418 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X91.991 Y91.509 Z4.44 F18000
G1 X85.542 Y97.281 Z4.44
G1 Z4.04
G1 E.3 F1800
; LINE_WIDTH: 0.0921937
G1 F2400
M204 S6000
G1 X85.379 Y97.146 E.00066
; LINE_WIDTH: 0.130449
G1 X85.217 Y97.012 E.00105
; LINE_WIDTH: 0.168704
G1 X85.055 Y96.877 E.00143
; LINE_WIDTH: 0.206959
G1 X84.892 Y96.743 E.00181
; LINE_WIDTH: 0.244454
G1 X84.582 Y96.458 E.00437
; LINE_WIDTH: 0.285351
G1 X84.271 Y96.173 E.00518
G1 X83.4 Y95.269 E.01545
; LINE_WIDTH: 0.23011
G1 X83.216 Y95.053 E.00275
; LINE_WIDTH: 0.184107
G1 X83.032 Y94.836 E.00213
; LINE_WIDTH: 0.138104
G1 X82.848 Y94.619 E.00151
; LINE_WIDTH: 0.0940764
G1 X82.735 Y94.473 E.0006
; WIPE_START
G1 X82.848 Y94.619 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X87.746 Y94.286 Z4.44 F18000
G1 Z4.04
G1 E.3 F1800
; LINE_WIDTH: 0.196493
G1 F2400
M204 S6000
G1 X87.622 Y94.193 E.00125
; LINE_WIDTH: 0.165044
G1 X87.493 Y94.096 E.00106
; LINE_WIDTH: 0.129852
G1 X87.328 Y93.959 E.00106
; LINE_WIDTH: 0.0919947
G1 X87.162 Y93.822 E.00067
; WIPE_START
G1 X87.328 Y93.959 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X93.51 Y89.483 Z4.44 F18000
G1 X94.652 Y88.656 Z4.44
M73 P97 R0
G1 Z4.04
G1 E.3 F1800
; LINE_WIDTH: 0.121756
G1 F2400
M204 S6000
G1 X94.464 Y88.353 E.00162
M204 S10000
G1 X94.283 Y87.743 F18000
; LINE_WIDTH: 0.194432
G1 F2400
M204 S6000
G1 X94.17 Y87.588 E.00154
; LINE_WIDTH: 0.162038
G1 X94.07 Y87.465 E.00102
; LINE_WIDTH: 0.128516
G1 X93.971 Y87.341 E.00077
; LINE_WIDTH: 0.0891104
G1 X93.826 Y87.167 E.00068
; WIPE_START
G1 X93.971 Y87.341 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X92.838 Y86.178 Z4.44 F18000
G1 Z4.04
G1 E.3 F1800
; LINE_WIDTH: 0.0920368
G1 F2400
M204 S6000
G1 X92.672 Y86.041 E.00068
; LINE_WIDTH: 0.130533
G1 X92.502 Y85.9 E.0011
; LINE_WIDTH: 0.165787
G1 X92.378 Y85.807 E.00103
; LINE_WIDTH: 0.196534
G1 X92.254 Y85.715 E.00125
; WIPE_START
G1 X92.378 Y85.807 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X90.883 Y85.327 Z4.44 F18000
G1 Z4.04
G1 E.3 F1800
; LINE_WIDTH: 0.167539
G1 F2400
M204 S6000
G1 X90.715 Y85.241 E.00127
G1 X90.559 Y85.296 E.00111
M204 S10000
G1 X89.651 Y85.191 F18000
; LINE_WIDTH: 0.0889939
G1 F2400
M204 S6000
G1 X89.478 Y85.274 E.00057
; WIPE_START
G1 X89.651 Y85.191 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X86.489 Y92.138 Z4.44 F18000
G1 X86.173 Y92.832 Z4.44
G1 Z4.04
G1 E.3 F1800
; LINE_WIDTH: 0.0754459
G1 F2400
M204 S6000
G1 X86.128 Y92.782 E.00016
; LINE_WIDTH: 0.0948291
G1 X86.029 Y92.658 E.00052
; LINE_WIDTH: 0.128359
G1 X85.929 Y92.535 E.00077
; LINE_WIDTH: 0.162719
G1 X85.825 Y92.406 E.00108
; LINE_WIDTH: 0.194965
G1 X85.716 Y92.256 E.00148
; WIPE_START
G1 X85.825 Y92.406 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X82.412 Y93.712 Z4.44 F18000
G1 Z4.04
G1 E.3 F1800
; LINE_WIDTH: 0.182153
G1 F2400
M204 S6000
G1 X82.322 Y93.581 E.00118
; LINE_WIDTH: 0.138515
G1 X82.231 Y93.45 E.00085
; LINE_WIDTH: 0.0948767
G1 X82.14 Y93.319 E.00052
; WIPE_START
G1 X82.231 Y93.45 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X84.528 Y86.171 Z4.44 F18000
G1 X85.634 Y82.667 Z4.44
G1 Z4.04
G1 E.3 F1800
; LINE_WIDTH: 0.0852148
G1 F2400
M204 S6000
G1 X85.559 Y82.723 E.00026
G1 X85.509 Y82.716 E.00014
; WIPE_START
G1 X85.559 Y82.723 E-.09991
G1 X85.634 Y82.667 E-.18509
; WIPE_END
G1 E-.015 F1800
M204 S10000
G1 X93.045 Y84.489 Z4.44 F18000
G1 X97.264 Y85.526 Z4.44
G1 Z4.04
G1 E.3 F1800
; LINE_WIDTH: 0.0939994
G1 F2400
M204 S6000
G1 X97.152 Y85.38 E.0006
; LINE_WIDTH: 0.13781
G1 X96.969 Y85.165 E.0015
; LINE_WIDTH: 0.183564
G1 X96.786 Y84.95 E.00211
; LINE_WIDTH: 0.229318
G1 X96.603 Y84.734 E.00273
; LINE_WIDTH: 0.265313
G1 X96.315 Y84.428 E.00477
; LINE_WIDTH: 0.289769
G1 X96.027 Y84.121 E.00526
G1 X95.422 Y83.538 E.01051
; LINE_WIDTH: 0.253883
G1 X95.209 Y83.353 E.00305
; LINE_WIDTH: 0.215256
G1 X94.997 Y83.168 E.00253
; LINE_WIDTH: 0.176628
G1 X94.784 Y82.983 E.00202
; LINE_WIDTH: 0.136243
G1 X94.635 Y82.865 E.001
; LINE_WIDTH: 0.0941252
G1 X94.485 Y82.748 E.00062
; close powerlost recovery
M1003 S0
; WIPE_START
G1 F2400
G1 X94.635 Y82.865 E-.285
; WIPE_END
G1 E-.015 F1800
M204 S10000
G17
G3 Z4.44 I1.217 J0 P1  F18000
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
G1 Z4.44 F900 ; lower z a little
G1 X0 Y90.0001 F18000 ; move to safe pos
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

    G1 Z104.04 F600
    G1 Z102.04

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

