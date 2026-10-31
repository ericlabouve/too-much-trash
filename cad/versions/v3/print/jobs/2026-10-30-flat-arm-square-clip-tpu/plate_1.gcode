; HEADER_BLOCK_START
; BambuStudio 02.07.01.62
; model printing time: 16m 40s; total estimated time: 24m 44s
; total layer number: 49
; total filament length [mm] : 395.54
; total filament volume [cm^3] : 951.39
; total filament weight [g] : 1.18
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
M73 P1 R24
    G1 E50 F200
    M400
    M1002 set_filament_type:TPU

    M104 S250

    G92 E0
    G1 E50 F49.8898
    M400
    M106 P1 S178
    G92 E0
M73 P3 R24
    G1 E5 F49.8898
    M109 S210 ; drop nozzle temp, make filament shink a bit
    M104 S190
    G92 E0
M73 P7 R23
    G1 E-0.5 F300

M73 P7 R22
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
    G29 A1 X77.9306 Y76.1009 I24.1389 J27.7982
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
    
M73 P26 R18
    G1 X-13.5 F3000
    M400
    M984 A0.1 E1 S1 F0.49281 H0.4
    M106 P1 S178
    M400 S7
    G1 X0 F18000
M73 P27 R17
    G1 X-13.5 F3000
    G1 X0 F18000 ;wipe and shake
    G1 X-13.5 F3000
    G1 X0 F12000 ;wipe and shake
M73 P28 R17
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
G1 X84.816 Y102.366 F18000
M204 S6000
G1 Z.4
M73 P29 R17
G1 Z.2
M73 P30 R17
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.5
G1 F900
M204 S500
G1 X84.438 Y102.162 E.01632
G1 X84.058 Y101.859 E.01848
G1 X83.745 Y101.502 E.01804
G1 X83.565 Y101.22 E.01271
G1 X83.421 Y100.92 E.01265
G1 X83.28 Y100.464 E.01813
G1 X83.222 Y99.982 E.01847
G1 X83.251 Y99.497 E.01846
G1 X83.364 Y99.035 E.01807
G1 X83.49 Y98.726 E.01271
G1 X83.652 Y98.435 E.01264
G1 X83.944 Y98.058 E.01814
G1 X84.299 Y97.738 E.01814
G1 X84.576 Y97.555 E.01263
G1 X84.875 Y97.406 E.0127
G1 X85.327 Y97.259 E.01807
G1 X85.798 Y97.195 E.01807
G1 X86.133 Y97.2 E.01271
M73 P31 R16
G1 X86.465 Y97.245 E.01274
M73 P32 R16
G1 X86.913 Y97.376 E.01774
G1 X87.214 Y97.516 E.01262
G1 X87.499 Y97.692 E.01272
G1 X87.861 Y97.999 E.01806
G1 X88.17 Y98.375 E.01848
G1 X88.402 Y98.791 E.01813
G1 X88.519 Y99.103 E.01264
G1 X88.597 Y99.425 E.01262
G1 X88.64 Y99.899 E.01808
G1 X88.597 Y100.385 E.01853
G1 X88.47 Y100.845 E.01814
G1 X88.334 Y101.148 E.01263
G1 X88.164 Y101.434 E.01263
G1 X87.861 Y101.803 E.01814
G1 X87.499 Y102.11 E.01807
G1 X87.214 Y102.286 E.01271
G1 X86.91 Y102.426 E.01271
G1 X86.454 Y102.56 E.01806
G1 X85.982 Y102.609 E.01807
G1 X85.648 Y102.594 E.0127
G1 X85.317 Y102.54 E.01273
G1 X84.869 Y102.394 E.01792
M204 S6000
G1 X85.032 Y101.963 F18000
; FEATURE: Outer wall
G1 F900
M204 S500
G1 X84.69 Y101.779 E.01476
G1 X84.375 Y101.528 E.01535
G1 X84.112 Y101.227 E.01517
G1 X83.965 Y100.997 E.01038
G1 X83.847 Y100.753 E.01031
G1 X83.729 Y100.369 E.01527
G1 X83.681 Y99.968 E.01533
G1 X83.705 Y99.565 E.01534
G1 X83.8 Y99.177 E.0152
G1 X83.903 Y98.924 E.01038
G1 X84.035 Y98.688 E.01029
G1 X84.28 Y98.37 E.01527
G1 X84.579 Y98.101 E.01527
G1 X84.805 Y97.952 E.0103
G1 X85.049 Y97.83 E.01036
G1 X85.43 Y97.706 E.0152
G1 X85.826 Y97.653 E.0152
G1 X86.099 Y97.657 E.01037
G1 X86.369 Y97.693 E.01038
G1 X86.751 Y97.805 E.01513
G1 X86.997 Y97.919 E.01028
G1 X87.229 Y98.063 E.01037
G1 X87.534 Y98.321 E.0152
G1 X87.791 Y98.633 E.01534
G1 X87.986 Y98.984 E.01526
G1 X88.081 Y99.238 E.0103
G1 X88.145 Y99.501 E.01029
G1 X88.182 Y99.899 E.01522
G1 X88.145 Y100.303 E.01539
G1 X88.038 Y100.69 E.01527
G1 X87.928 Y100.937 E.01029
G1 X87.789 Y101.17 E.0103
G1 X87.534 Y101.481 E.01527
G1 X87.229 Y101.739 E.0152
G1 X86.997 Y101.883 E.01037
G1 X86.749 Y101.997 E.01037
G1 X86.366 Y102.109 E.0152
G1 X85.968 Y102.151 E.0152
G1 X85.695 Y102.139 E.01036
G1 X85.426 Y102.094 E.01038
G1 X85.088 Y101.985 E.0135
; WIPE_START
G1 X84.69 Y101.779 E-.08504
G1 X84.375 Y101.528 E-.07674
G1 X84.112 Y101.227 E-.07586
G1 X83.965 Y100.997 E-.05187
G1 X83.847 Y100.753 E-.05152
G1 X83.787 Y100.557 E-.03897
; WIPE_END
G1 E-.02 F1800
M204 S6000
G1 X84.914 Y96.208 Z.6 F18000
G1 Z.2
G1 E.4 F1800
; FEATURE: Inner wall
G1 F900
M204 S500
G1 X87.073 Y96.208 E.08204
G1 X88.545 Y97.899 E.08522
G1 X88.858 Y98.394 E.02226
G1 X88.938 Y98.561 E.00704
G1 X89.126 Y99.112 E.02212
G1 X89.216 Y99.684 E.02201
G1 X89.202 Y100.27 E.02227
G1 X89.133 Y100.662 E.01511
G1 X89.019 Y101.04 E.01501
G1 X88.774 Y101.56 E.02186
G1 X88.551 Y101.893 E.01524
G1 X88.292 Y102.195 E.01512
G1 X87.845 Y102.58 E.0224
G1 X87.7 Y102.677 E.00663
G1 X87.18 Y102.947 E.02227
G1 X86.62 Y103.12 E.02227
G1 X86.039 Y103.191 E.02226
G1 X85.638 Y103.18 E.01526
G1 X85.241 Y103.12 E.01525
G1 X84.681 Y102.947 E.02227
G1 X84.17 Y102.682 E.02187
G1 X83.853 Y102.454 E.01486
G1 X83.565 Y102.19 E.01485
G1 X83.31 Y101.893 E.01484
G1 X83.093 Y101.569 E.01486
G1 X82.91 Y101.211 E.01525
G1 X82.73 Y100.669 E.02173
G1 X82.661 Y100.28 E.015
G1 X82.639 Y99.89 E.01484
G1 X82.663 Y99.501 E.01484
G1 X82.735 Y99.112 E.015
G1 X82.919 Y98.571 E.02175
G1 X83.104 Y98.215 E.01524
G1 X83.323 Y97.892 E.01485
G1 X84.788 Y96.208 E.08481
G1 X84.854 Y96.208 E.00252
; WIPE_START
G1 X86.854 Y96.208 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S6000
G1 X79.597 Y96.148 Z.6 F18000
G1 Z.2
G1 E.4 F1800
G1 F900
M204 S500
G1 X79.552 Y96.403 E.00983
G1 X79.238 Y96.367 E.01198
G1 X79.108 Y96.323 E.00524
G1 X78.966 Y96.242 E.0062
G1 X78.848 Y96.136 E.00603
G1 X78.73 Y95.964 E.00792
G1 X78.664 Y95.783 E.00735
G1 X78.629 Y95.486 E.01135
G1 X78.841 Y95.416 E.00849
G1 X79.079 Y95.829 E.01812
G1 X79.435 Y96.11 E.01725
G1 X79.538 Y96.135 E.00401
; WIPE_START
G1 X79.552 Y96.403 E-.0511
G1 X79.238 Y96.367 E-.05991
G1 X79.108 Y96.323 E-.02618
G1 X78.966 Y96.242 E-.03099
G1 X78.848 Y96.136 E-.03013
G1 X78.73 Y95.964 E-.03961
G1 X78.664 Y95.783 E-.03676
G1 X78.629 Y95.486 E-.05674
G1 X78.841 Y95.416 E-.04244
G1 X78.857 Y95.444 E-.00614
; WIPE_END
G1 E-.02 F1800
M204 S6000
G1 X79.165 Y87.817 Z.6 F18000
G1 X79.599 Y77.053 Z.6
G1 Z.2
G1 E.4 F1800
G1 F900
M204 S500
G1 X79.466 Y77.084 E.00519
G1 X79.207 Y77.255 E.0118
G1 X78.999 Y77.488 E.01187
G1 X78.852 Y77.803 E.01321
G1 X78.638 Y77.756 E.00836
G1 X78.644 Y77.519 E.00899
G1 X78.674 Y77.374 E.00563
G1 X78.724 Y77.246 E.00523
G1 X78.848 Y77.065 E.00833
G1 X78.966 Y76.96 E.00601
G1 X79.16 Y76.858 E.00833
G1 X79.302 Y76.82 E.00558
G1 X79.571 Y76.81 E.01021
G1 X79.592 Y76.993 E.00699
; WIPE_START
G1 X79.466 Y77.084 E-.02954
G1 X79.207 Y77.255 E-.05899
G1 X78.999 Y77.488 E-.05933
G1 X78.852 Y77.803 E-.06603
G1 X78.638 Y77.756 E-.04181
G1 X78.644 Y77.519 E-.04492
G1 X78.674 Y77.374 E-.02816
G1 X78.724 Y77.246 E-.02614
G1 X78.799 Y77.137 E-.02508
; WIPE_END
G1 E-.02 F1800
M204 S6000
G1 X85.662 Y80.477 Z.6 F18000
G1 X100.673 Y87.781 Z.6
G1 Z.2
G1 E.4 F1800
; FEATURE: Outer wall
G1 F900
M204 S500
G1 X98.665 Y90.648 E.13302
G1 X95.798 Y88.64 E.13302
G1 X97.555 Y86.132 E.11639
G1 X97.806 Y85.773 E.01663
G1 X100.624 Y87.746 E.13074
; WIPE_START
G1 X99.505 Y89.404 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S6000
G1 X98.141 Y91.396 Z.6 F18000
G1 Z.2
G1 E.4 F1800
; FEATURE: Inner wall
G1 F900
M204 S500
G1 X98.211 Y91.446 E.00327
G1 X95.302 Y95.6 E.19276
G1 X93.956 Y94.658 E.06245
G1 X93.72 Y94.909 E.01309
G1 X93.524 Y94.762 E.0093
G1 X93.692 Y94.473 E.01271
G1 X92.294 Y93.494 E.06486
G1 X95.203 Y89.34 E.19276
G1 X98.092 Y91.362 E.134
M204 S6000
G1 X98.403 Y91.022 F18000
G1 F900
M204 S500
G1 X98.848 Y91.334 E.02064
G1 X95.414 Y96.237 E.2275
G1 X94.018 Y95.259 E.06479
G1 X93.418 Y95.896 E.03324
G1 X93.14 Y96.03 E.01175
G1 X92.853 Y96.268 E.01418
G1 X92.75 Y96.323 E.00442
G1 X92.52 Y96.391 E.00912
G1 X92.666 Y95.348 E.04004
G1 X93.086 Y94.606 E.03238
M73 P33 R16
G1 X91.658 Y93.607 E.06626
G1 X95.091 Y88.703 E.2275
G1 X98.354 Y90.988 E.15138
; WIPE_START
G1 X98.848 Y91.334 E-.11456
G1 X98.046 Y92.478 E-.26544
; WIPE_END
G1 E-.02 F1800
M204 S6000
G1 X90.742 Y94.692 Z.6 F18000
G1 X83.623 Y96.851 Z.6
G1 Z.2
G1 E.4 F1800
; FEATURE: Outer wall
G1 F900
M204 S500
G1 X79.445 Y96.851 E.15878
G1 X79.139 Y96.815 E.01171
G1 X78.932 Y96.747 E.00828
G1 X78.806 Y96.683 E.00538
G1 X78.687 Y96.605 E.00538
G1 X78.519 Y96.456 E.00856
G1 X78.431 Y96.35 E.00524
G1 X78.316 Y96.165 E.00827
G1 X78.216 Y95.889 E.01116
G1 X78.181 Y95.586 E.01157
G1 X78.181 Y77.608 E.68328
G1 X78.189 Y77.459 E.00566
G1 X78.234 Y77.243 E.00842
G1 X78.314 Y77.04 E.00827
G1 X78.431 Y76.852 E.00842
G1 X78.519 Y76.746 E.00525
G1 X78.687 Y76.597 E.00855
G1 X78.803 Y76.521 E.00525
G1 X79.003 Y76.427 E.00841
G1 X79.216 Y76.37 E.00836
G1 X79.358 Y76.353 E.00544
G1 X92.417 Y76.351 E.49634
G1 X92.722 Y76.387 E.01166
G1 X92.925 Y76.454 E.00814
G1 X93.117 Y76.557 E.00828
G1 X93.288 Y76.692 E.00827
G1 X93.433 Y76.855 E.00828
G1 X93.547 Y77.04 E.00827
G1 X93.627 Y77.243 E.00827
G1 X93.67 Y77.452 E.00815
G1 X93.68 Y88.751 E.42941
G1 X92.581 Y88.751 E.0418
G1 X92.581 Y77.451 E.42947
G1 X79.901 Y77.451 E.48189
G1 X79.65 Y77.51 E.00981
G1 X79.508 Y77.604 E.00645
G1 X79.385 Y77.742 E.00704
G1 X79.305 Y77.914 E.00719
G1 X79.281 Y78.083 E.00649
G1 X79.281 Y95.123 E.64763
G1 X79.316 Y95.324 E.00778
G1 X79.432 Y95.524 E.00878
G1 X79.639 Y95.689 E.01007
G1 X79.901 Y95.751 E.01023
G1 X92.148 Y95.751 E.46545
G1 X92.22 Y95.234 E.01984
G1 X92.273 Y95.093 E.00571
G1 X92.479 Y94.74 E.01555
G1 X91.021 Y93.719 E.06765
G1 X97.216 Y84.872 E.41047
G1 X101.721 Y88.027 E.20904
G1 X95.527 Y96.873 E.41047
G1 X94.08 Y95.86 E.06713
G1 X93.715 Y96.248 E.02022
G1 X93.585 Y96.334 E.00595
G1 X93.382 Y96.423 E.0084
G1 X93.109 Y96.649 E.01349
G1 X92.924 Y96.748 E.00794
G1 X92.642 Y96.832 E.0112
G1 X92.42 Y96.851 E.00848
G1 X88.238 Y96.851 E.15892
G1 X88.903 Y97.615 E.03849
G1 X89.029 Y97.789 E.00818
G1 X89.261 Y98.178 E.0172
G1 X89.356 Y98.375 E.00833
G1 X89.439 Y98.578 E.00832
G1 X89.571 Y99.003 E.01692
G1 X89.653 Y99.448 E.01721
G1 X89.673 Y99.663 E.00818
G1 X89.674 Y100.115 E.0172
G1 X89.656 Y100.33 E.00818
G1 X89.578 Y100.768 E.01691
G1 X89.449 Y101.198 E.01708
G1 X89.27 Y101.606 E.01691
G1 X89.165 Y101.798 E.00833
G1 X88.915 Y102.17 E.01705
G1 X88.625 Y102.508 E.01692
G1 X88.468 Y102.661 E.00833
G1 X88.117 Y102.947 E.0172
G1 X87.939 Y103.067 E.00818
G1 X87.543 Y103.286 E.0172
G1 X87.346 Y103.373 E.00819
G1 X86.917 Y103.519 E.0172
G1 X86.708 Y103.569 E.00818
G1 X86.261 Y103.636 E.0172
G1 X86.046 Y103.649 E.00818
G1 X85.597 Y103.636 E.01706
G1 X85.153 Y103.569 E.01706
G1 X84.944 Y103.518 E.00819
G1 X84.515 Y103.373 E.01719
G1 X84.318 Y103.286 E.00819
G1 X83.925 Y103.069 E.01705
G1 X83.564 Y102.809 E.01693
G1 X83.236 Y102.508 E.01692
G1 X82.946 Y102.171 E.01691
G1 X82.698 Y101.801 E.01693
G1 X82.494 Y101.401 E.01706
G1 X82.413 Y101.201 E.00818
G1 X82.284 Y100.775 E.01692
G1 X82.206 Y100.333 E.01707
G1 X82.181 Y99.889 E.01692
G1 X82.209 Y99.445 E.01691
G1 X82.29 Y99.003 E.01707
G1 X82.421 Y98.581 E.01677
G1 X82.504 Y98.379 E.00833
G1 X82.71 Y97.98 E.01706
G1 X82.961 Y97.612 E.01692
G1 X83.583 Y96.896 E.03606
; WIPE_START
G1 X81.584 Y96.874 E-.38
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




G1 X79.802 Y96.301
G1 Z.2
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.68586
G1 F900
M204 S500
G1 X84.404 Y96.301 E.24604
M204 S6000
G1 X84.536 Y96.846 F18000
; LINE_WIDTH: 0.678796
G1 F900
M204 S500
G1 X85.181 Y96.743 E.03454
; LINE_WIDTH: 0.631216
G1 X85.492 Y96.72 E.01526
; LINE_WIDTH: 0.592487
G1 X85.749 Y96.703 E.01175
; LINE_WIDTH: 0.575678
G1 X86.186 Y96.705 E.01936
; LINE_WIDTH: 0.605336
G1 X86.552 Y96.73 E.01716
; LINE_WIDTH: 0.65306
M73 P34 R16
G1 X86.957 Y96.787 E.02077
; LINE_WIDTH: 0.687172
G1 X87.318 Y96.838 E.01954
M204 S6000
G1 X87.39 Y97.167 F18000
; LINE_WIDTH: 0.344076
G1 F900
M204 S500
G1 X87.499 Y97.259 E.00357
; LINE_WIDTH: 0.304091
G1 X87.593 Y97.339 E.00268
; LINE_WIDTH: 0.267096
G1 X87.687 Y97.419 E.0023
; LINE_WIDTH: 0.226839
G1 X87.882 Y97.61 E.00417
; LINE_WIDTH: 0.186698
G1 X88.065 Y97.791 E.00308
; LINE_WIDTH: 0.168261
G1 X88.404 Y98.209 E.00561
G1 X88.598 Y98.535 E.00396
G1 X88.671 Y98.678 E.00167
G1 X88.841 Y99.183 E.00555
G1 X88.92 Y99.7 E.00545
G1 X88.926 Y99.904 E.00213
G1 X88.882 Y100.431 E.00551
G1 X88.745 Y100.939 E.00548
G1 X88.521 Y101.409 E.00543
G1 X88.315 Y101.714 E.00384
G1 X88.072 Y102.003 E.00393
G1 X87.67 Y102.346 E.00551
G1 X87.353 Y102.536 E.00386
G1 X87.008 Y102.699 E.00397
G1 X86.516 Y102.843 E.00535
G1 X85.986 Y102.9 E.00555
G1 X85.621 Y102.884 E.00381
G1 X85.244 Y102.82 E.00398
G1 X84.757 Y102.661 E.00534
G1 X84.283 Y102.407 E.00561
G1 X83.862 Y102.072 E.00561
G1 X83.544 Y101.716 E.00497
G1 X83.314 Y101.364 E.00438
G1 X83.153 Y101.03 E.00386
G1 X82.998 Y100.53 E.00546
G1 X82.933 Y99.996 E.00561
G1 X82.955 Y99.536 E.00479
G1 X83.023 Y99.184 E.00374
G1 X83.187 Y98.692 E.0054
G1 X83.356 Y98.365 E.00384
G1 X83.558 Y98.073 E.00371
G1 X83.917 Y97.673 E.00559
; LINE_WIDTH: 0.210118
G1 X84.098 Y97.489 E.00359
; LINE_WIDTH: 0.227245
G1 X84.108 Y97.48 E.00021
; LINE_WIDTH: 0.253416
G1 X84.246 Y97.359 E.00321
; LINE_WIDTH: 0.303058
G1 X84.383 Y97.238 E.00396
; LINE_WIDTH: 0.330732
G1 X84.397 Y97.227 E.00042
; LINE_WIDTH: 0.357688
G1 X84.495 Y97.151 E.00325
; LINE_WIDTH: 0.405865
G1 X84.593 Y97.075 E.00374
; LINE_WIDTH: 0.454042
G1 X84.691 Y96.999 E.00424
; LINE_WIDTH: 0.48599
G1 X84.719 Y96.979 E.00125
; WIPE_START
G1 X84.691 Y96.999 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S6000
G1 X87.457 Y96.301 Z.6 F18000
G1 Z.2
G1 E.4 F1800
; LINE_WIDTH: 0.68586
G1 F900
M204 S500
G1 X92.302 Y96.301 E.25901
M204 S6000
G1 X92.811 Y95.963 F18000
; LINE_WIDTH: 0.273977
G1 F900
M204 S500
G1 X93.446 Y94.989 E.02234
; WIPE_START
G1 X92.811 Y95.963 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S6000
G1 X95.18 Y89.692 Z.6 F18000
G1 Z.2
G1 E.4 F1800
; FEATURE: Bottom surface
; LINE_WIDTH: 0.52124
G1 F900
M204 S500
G1 X97.406 Y91.918 E.12521
G1 X97.128 Y92.316 E.01932
G1 X95.049 Y90.237 E.11691
G1 X94.771 Y90.635 E.01932
G1 X96.849 Y92.714 E.11691
G1 X96.571 Y93.111 E.01932
G1 X94.492 Y91.033 E.11691
G1 X94.214 Y91.431 E.01932
G1 X96.292 Y93.509 E.11691
G1 X96.013 Y93.907 E.01932
G1 X93.935 Y91.829 E.11691
G1 X93.656 Y92.227 E.01932
G1 X95.735 Y94.305 E.11691
G1 X95.456 Y94.703 E.01932
G1 X93.378 Y92.624 E.11691
G1 X93.099 Y93.022 E.01932
G1 X95.325 Y95.248 E.12521
; WIPE_START
G1 X93.911 Y93.834 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S6000
G1 X98.944 Y91.122 Z.6 F18000
G1 Z.2
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.58588
G1 F900
M204 S500
G1 X101.181 Y87.927 E.17607
; WIPE_START
G1 X100.033 Y89.565 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S6000
G1 X97.494 Y85.346 Z.6 F18000
G1 Z.2
G1 E.4 F1800
; LINE_WIDTH: 0.585857
G1 F900
M204 S500
G1 X95.258 Y88.541 E.17606
; WIPE_START
G1 X96.405 Y86.902 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S6000
G1 X93.13 Y88.522 Z.6 F18000
G1 Z.2
G1 E.4 F1800
; LINE_WIDTH: 0.680305
G1 F900
M204 S500
G1 X93.114 Y77.396 E.58967
; LINE_WIDTH: 0.628648
G1 X93.09 Y77.27 E.00627
; LINE_WIDTH: 0.591012
G1 X93.076 Y77.222 E.00224
; LINE_WIDTH: 0.560913
G1 X93.047 Y77.142 E.00368
; LINE_WIDTH: 0.539823
G1 X92.963 Y77.036 E.00558
G1 X92.848 Y76.966 E.00557
; LINE_WIDTH: 0.56941
G1 X92.809 Y76.955 E.00178
M204 S6000
G1 X92.605 Y76.914 F18000
; LINE_WIDTH: 0.684448
G1 F900
M204 S500
G1 X92.385 Y76.901 E.01175
G1 X79.812 Y76.902 E.67071
; WIPE_START
G1 X81.812 Y76.902 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S6000
G1 X78.734 Y78.011 Z.6 F18000
G1 Z.2
G1 E.4 F1800
; LINE_WIDTH: 0.688878
G1 F900
M204 S500
G1 X78.731 Y95.212 E.92386
; WIPE_START
G1 X78.731 Y93.212 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S6000
G1 X83.678 Y87.4 Z.6 F18000
G1 X92.605 Y76.914 Z.6
G1 Z.2
G1 E.4 F1800
; LINE_WIDTH: 0.641745
G1 F900
M204 S500
G1 X93.266 Y77.02 E.03333
; CHANGE_LAYER
; Z_HEIGHT: 0.32
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F900
G1 X92.605 Y76.914 E-.38
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
G3 Z.6 I-.98 J.722 P1  F18000
G1 X100.617 Y87.791 Z.6
G1 Z.32
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X98.655 Y90.592 E.06727
G1 X95.854 Y88.63 E.06727
G1 X97.415 Y86.4 E.05355
G1 X97.815 Y85.829 E.01372
G1 X100.568 Y87.756 E.06609
; WIPE_START
M204 S6000
G1 X99.45 Y89.414 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X95.09 Y83.149 Z.72 F18000
G1 X93.304 Y80.582 Z.72
G1 Z.32
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X93.311 Y88.382 E.1651
G1 X92.95 Y88.382 E.00764
G1 X92.95 Y77.128 E.23818
G1 X93.135 Y77.076 E.00407
G1 X93.216 Y77.207 E.00325
G1 X93.272 Y77.349 E.00324
G1 X93.301 Y77.49 E.00305
G1 X93.304 Y80.522 E.06416
; WIPE_START
M204 S6000
G1 X93.306 Y82.522 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X89.428 Y89.096 Z.72 F18000
G1 X84.692 Y97.126 Z.72
G1 Z.32
G1 E.4 F1800
G1 F1500
M204 S500
G1 X84.577 Y96.963 E.00423
G1 X84.941 Y96.544 E.01174
G1 X86.92 Y96.544 E.04188
G1 X87.266 Y96.942 E.01116
G1 X87.159 Y97.104 E.0041
G1 X86.697 Y96.954 E.01029
G1 X86.324 Y96.88 E.00805
G1 X85.81 Y96.857 E.0109
G1 X85.432 Y96.897 E.00804
G1 X85.061 Y96.981 E.00804
G1 X84.748 Y97.104 E.00712
; WIPE_START
M204 S6000
G1 X84.577 Y96.963 E-.04213
G1 X84.941 Y96.544 E-.10542
G1 X86.165 Y96.544 E-.23245
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X84.857 Y102.288 Z.72 F18000
G1 Z.32
G1 E.4 F1800
G1 F1500
M204 S500
G1 X84.486 Y102.089 E.00891
G1 X84.119 Y101.796 E.00995
G1 X83.816 Y101.449 E.00975
G1 X83.642 Y101.177 E.00683
G1 X83.502 Y100.886 E.00683
G1 X83.366 Y100.446 E.00975
G1 X83.31 Y99.979 E.00995
G1 X83.338 Y99.51 E.00995
G1 X83.447 Y99.063 E.00975
G1 X83.57 Y98.764 E.00683
G1 X83.727 Y98.482 E.00683
G1 X84.009 Y98.118 E.00975
G1 X84.358 Y97.803 E.00995
G1 X84.758 Y97.556 E.00995
G1 X85.187 Y97.388 E.00975
G1 X85.501 Y97.316 E.00683
G1 X85.822 Y97.282 E.00683
G1 X86.273 Y97.302 E.00955
G1 X86.59 Y97.365 E.00684
G1 X86.897 Y97.465 E.00683
G1 X87.309 Y97.671 E.00975
G1 X87.677 Y97.947 E.00976
G1 X87.904 Y98.177 E.00683
G1 X88.101 Y98.432 E.00683
G1 X88.321 Y98.826 E.00955
G1 X88.435 Y99.129 E.00683
G1 X88.511 Y99.442 E.00683
G1 X88.552 Y99.901 E.00975
G1 X88.51 Y100.369 E.00995
G1 X88.388 Y100.813 E.00975
G1 X88.256 Y101.108 E.00682
G1 X88.094 Y101.38 E.00671
G1 X87.798 Y101.741 E.00987
G1 X87.442 Y102.042 E.00987
G1 X87.172 Y102.208 E.00671
G1 X86.879 Y102.344 E.00683
G1 X86.437 Y102.473 E.00975
G1 X85.979 Y102.521 E.00976
G1 X85.657 Y102.507 E.00682
G1 X85.344 Y102.455 E.00671
G1 X84.911 Y102.315 E.00964
M204 S250
G1 X85.051 Y101.928 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X84.713 Y101.746 E.00756
G1 X84.403 Y101.499 E.0078
G1 X84.144 Y101.203 E.00773
G1 X84 Y100.977 E.00526
G1 X83.884 Y100.736 E.00526
G1 X83.768 Y100.361 E.00774
G1 X83.721 Y99.967 E.0078
G1 X83.744 Y99.571 E.0078
G1 X83.838 Y99.19 E.00773
G1 X83.939 Y98.942 E.00527
G1 X84.069 Y98.708 E.00526
G1 X84.31 Y98.397 E.00773
G1 X84.604 Y98.132 E.0078
G1 X84.942 Y97.924 E.0078
G1 X85.308 Y97.78 E.00773
G1 X85.568 Y97.72 E.00526
G1 X85.835 Y97.692 E.00526
G1 X86.224 Y97.71 E.00767
G1 X86.487 Y97.762 E.00527
G1 X86.741 Y97.844 E.00526
G1 X87.093 Y98.02 E.00773
G1 X87.407 Y98.256 E.00774
G1 X87.595 Y98.447 E.00526
G1 X87.759 Y98.658 E.00526
G1 X87.949 Y98.999 E.00767
G1 X88.043 Y99.249 E.00526
G1 X88.106 Y99.509 E.00526
G1 X88.141 Y99.901 E.00773
G1 X88.106 Y100.296 E.0078
G1 X88.001 Y100.675 E.00773
G1 X87.892 Y100.919 E.00526
G1 X87.758 Y101.144 E.00516
G1 X87.506 Y101.453 E.00784
G1 X87.201 Y101.71 E.00784
G1 X86.978 Y101.847 E.00516
G1 X86.735 Y101.96 E.00526
G1 X86.358 Y102.07 E.00773
G1 X85.967 Y102.111 E.00774
G1 X85.7 Y102.099 E.00526
G1 X85.441 Y102.056 E.00516
G1 X85.107 Y101.949 E.0069
; WIPE_START
M204 S6000
G1 X84.713 Y101.746 E-.08425
G1 X84.403 Y101.499 E-.07535
G1 X84.144 Y101.203 E-.07468
G1 X84 Y100.977 E-.05083
G1 X83.884 Y100.736 E-.05079
G1 X83.816 Y100.515 E-.0441
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X90.234 Y96.385 Z.72 F18000
G1 X98.177 Y91.275 Z.72
G1 Z.32
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X98.379 Y91.416 E.00522
G1 X95.332 Y95.768 E.11246
G1 X93.972 Y94.816 E.03513
G1 X93.201 Y95.636 E.02381
G1 X92.957 Y95.742 E.00564
G1 X92.98 Y95.478 E.00561
G1 X93.489 Y94.478 E.02376
G1 X92.126 Y93.524 E.03521
G1 X95.174 Y89.172 E.11245
G1 X98.128 Y91.24 E.07633
; WIPE_START
M204 S6000
G1 X98.379 Y91.416 E-.05824
G1 X97.408 Y92.803 E-.32176
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X90.022 Y94.73 Z.72 F18000
G1 X84.691 Y96.12 Z.72
G1 Z.32
G1 E.4 F1800
G1 F1500
M204 S500
G1 X92.5 Y96.12 E.16528
G1 X92.579 Y95.33 E.01681
G1 X92.944 Y94.614 E.017
G1 X91.536 Y93.628 E.03638
G1 X97.307 Y85.386 E.21296
G1 X97.521 Y85.536 E.00554
G1 X95.284 Y88.731 E.08255
G1 X98.756 Y91.162 E.08971
G1 X100.993 Y87.967 E.08255
M73 P35 R16
G1 X101.207 Y88.117 E.00554
G1 X95.436 Y96.359 E.21296
G1 X94.03 Y95.375 E.03633
G1 X93.476 Y95.964 E.01712
G1 X93.186 Y96.105 E.00682
G1 X92.902 Y96.341 E.00783
G1 X92.784 Y96.404 E.00283
G1 X92.573 Y96.467 E.00465
G1 X92.404 Y96.482 E.0036
G1 X87.428 Y96.482 E.10532
G1 X88.614 Y97.845 E.03825
G1 X88.721 Y97.992 E.00386
G1 X88.936 Y98.353 E.00888
G1 X89.159 Y98.902 E.01254
G1 X89.286 Y99.49 E.01274
G1 X89.305 Y100.1 E.01291
G1 X89.22 Y100.676 E.01234
G1 X89.101 Y101.07 E.00871
G1 X88.849 Y101.606 E.01253
G1 X88.495 Y102.104 E.01294
G1 X88.064 Y102.522 E.01271
G1 X87.738 Y102.757 E.0085
G1 X87.387 Y102.951 E.00849
G1 X87.211 Y103.029 E.00407
G1 X86.814 Y103.164 E.00887
G1 X86.222 Y103.269 E.01273
G1 X85.62 Y103.266 E.01274
G1 X85.038 Y103.161 E.01253
G1 X84.483 Y102.955 E.01253
G1 X84.123 Y102.756 E.00871
G1 X83.797 Y102.522 E.00848
G1 X83.502 Y102.251 E.00849
G1 X83.234 Y101.94 E.00869
G1 X82.925 Y101.446 E.01234
G1 X82.759 Y101.069 E.0087
G1 X82.643 Y100.686 E.00848
G1 X82.573 Y100.291 E.00849
G1 X82.551 Y99.89 E.00849
G1 X82.576 Y99.49 E.00848
G1 X82.651 Y99.086 E.00871
G1 X82.839 Y98.534 E.01233
G1 X83.028 Y98.17 E.00869
G1 X83.254 Y97.838 E.00849
G1 X84.433 Y96.482 E.03805
G1 X79.467 Y96.482 E.10513
G1 X79.219 Y96.453 E.00527
G1 X79.074 Y96.405 E.00324
G1 X78.815 Y96.228 E.00664
G1 X78.665 Y96.033 E.00521
G1 X78.579 Y95.812 E.00501
G1 X78.55 Y95.565 E.00527
G1 X78.55 Y77.628 E.37966
G1 X78.586 Y77.357 E.00579
G1 X78.691 Y77.125 E.00539
G1 X78.792 Y76.998 E.00342
G1 X78.91 Y76.892 E.00336
G1 X79.13 Y76.775 E.00527
G1 X79.38 Y76.723 E.0054
G1 X92.398 Y76.72 E.27553
G1 X92.641 Y76.749 E.00519
G1 X92.779 Y76.794 E.00306
G1 X92.955 Y76.889 E.00424
G1 X92.906 Y77.082 E.0042
G1 X79.895 Y77.082 E.2754
G1 X79.685 Y77.106 E.00446
G1 X79.392 Y77.223 E.00669
G1 X79.085 Y77.512 E.00892
G1 X78.948 Y77.807 E.00688
G1 X78.911 Y78.055 E.00532
G1 X78.911 Y95.155 E.36193
G1 X78.964 Y95.453 E.0064
G1 X79.147 Y95.77 E.00777
G1 X79.475 Y96.029 E.00884
G1 X79.858 Y96.12 E.00834
G1 X84.631 Y96.12 E.10103
; WIPE_START
M204 S6000
G1 X86.631 Y96.12 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X83.535 Y96.891 Z.72 F18000
G1 Z.32
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X79.443 Y96.891 E.08049
G1 X79.13 Y96.854 E.00619
G1 X78.917 Y96.784 E.00442
G1 X78.791 Y96.721 E.00277
G1 X78.542 Y96.535 E.00612
G1 X78.443 Y96.429 E.00284
G1 X78.312 Y96.243 E.00447
G1 X78.248 Y96.114 E.00283
G1 X78.177 Y95.901 E.00442
M73 P35 R15
G1 X78.141 Y95.589 E.00619
G1 X78.141 Y77.61 E.35363
G1 X78.161 Y77.377 E.00459
G1 X78.195 Y77.234 E.00291
G1 X78.278 Y77.023 E.00446
G1 X78.352 Y76.895 E.0029
G1 X78.493 Y76.716 E.00448
G1 X78.66 Y76.567 E.00441
G1 X78.783 Y76.486 E.0029
G1 X78.99 Y76.389 E.00448
G1 X79.206 Y76.331 E.00441
G1 X79.356 Y76.313 E.00296
G1 X92.422 Y76.311 E.257
G1 X92.731 Y76.347 E.00611
G1 X92.941 Y76.417 E.00436
G1 X93.139 Y76.524 E.00442
G1 X93.315 Y76.663 E.00442
G1 X93.465 Y76.831 E.00442
G1 X93.583 Y77.022 E.00442
G1 X93.666 Y77.231 E.00442
G1 X93.71 Y77.448 E.00436
G1 X93.72 Y88.791 E.2231
G1 X92.541 Y88.791 E.02321
G1 X92.541 Y77.491 E.22226
G1 X79.918 Y77.491 E.24827
G1 X79.786 Y77.506 E.00261
G1 X79.616 Y77.574 E.00361
G1 X79.423 Y77.756 E.00521
G1 X79.344 Y77.925 E.00368
G1 X79.321 Y78.085 E.00318
G1 X79.321 Y95.119 E.33504
G1 X79.354 Y95.31 E.00382
G1 X79.462 Y95.498 E.00426
G1 X79.657 Y95.652 E.00489
G1 X79.906 Y95.711 E.00503
G1 X92.124 Y95.711 E.24031
G1 X92.155 Y95.336 E.0074
G1 X92.194 Y95.185 E.00307
G1 X92.418 Y94.745 E.0097
G1 X90.966 Y93.729 E.03486
G1 X97.206 Y84.816 E.214
G1 X101.777 Y88.017 E.10975
G1 X95.536 Y96.929 E.214
G1 X94.085 Y95.913 E.03485
G1 X93.741 Y96.278 E.00987
G1 X93.604 Y96.37 E.00324
G1 X93.403 Y96.457 E.00431
G1 X93.131 Y96.683 E.00696
G1 X92.94 Y96.785 E.00426
G1 X92.65 Y96.871 E.00595
G1 X92.421 Y96.891 E.0045
G1 X88.326 Y96.891 E.08055
G1 X88.934 Y97.59 E.01823
G1 X89.063 Y97.767 E.0043
G1 X89.296 Y98.159 E.00897
G1 X89.391 Y98.356 E.0043
G1 X89.551 Y98.78 E.00891
G1 X89.657 Y99.21 E.00871
G1 X89.713 Y99.661 E.00892
G1 X89.714 Y100.117 E.00897
G1 X89.695 Y100.335 E.00431
G1 X89.619 Y100.771 E.00871
G1 X89.486 Y101.212 E.00905
G1 X89.305 Y101.627 E.00891
G1 X89.199 Y101.819 E.0043
G1 X88.951 Y102.189 E.00878
G1 X88.806 Y102.37 E.00457
G1 X88.656 Y102.534 E.00436
G1 X88.323 Y102.84 E.00891
G1 X87.957 Y103.103 E.00885
G1 X87.57 Y103.318 E.00872
G1 X87.36 Y103.411 E.00451
G1 X86.928 Y103.557 E.00897
G1 X86.716 Y103.608 E.0043
G1 X86.265 Y103.676 E.00897
G1 X86.047 Y103.689 E.0043
G1 X85.583 Y103.674 E.00911
G1 X85.145 Y103.608 E.00871
G1 X84.93 Y103.556 E.00437
G1 X84.717 Y103.491 E.00437
G1 X84.307 Y103.325 E.00871
G1 X83.904 Y103.103 E.00905
G1 X83.539 Y102.84 E.00885
G1 X83.207 Y102.536 E.00885
G1 X82.912 Y102.192 E.00891
G1 X82.785 Y102.014 E.00431
G1 X82.56 Y101.633 E.00871
G1 X82.375 Y101.211 E.00905
G1 X82.245 Y100.781 E.00885
G1 X82.166 Y100.338 E.00885
G1 X82.141 Y99.889 E.00885
G1 X82.169 Y99.44 E.00884
G1 X82.253 Y98.987 E.00905
G1 X82.384 Y98.564 E.00871
G1 X82.467 Y98.362 E.0043
G1 X82.676 Y97.96 E.00891
G1 X82.929 Y97.588 E.00885
G1 X83.496 Y96.936 E.01698
; WIPE_START
M204 S6000
G1 X81.496 Y96.914 E-.38
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




G1 X79.358 Y96.247
G1 Z.32
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.144735
G1 F1500
M204 S6000
G1 X79.152 Y96.13 E.00141
G1 X78.977 Y95.991 E.00133
G1 X78.878 Y95.85 E.00102
G1 X78.778 Y95.626 E.00145
; WIPE_START
G1 X78.878 Y95.85 E-.10598
G1 X78.977 Y95.991 E-.0745
G1 X79.152 Y96.13 E-.09703
G1 X79.358 Y96.247 E-.10249
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X84.466 Y97.174 Z.72 F18000
G1 Z.32
G1 E.4 F1800
; LINE_WIDTH: 0.473061
G1 F1500
M204 S6000
G1 X84.296 Y97.318 E.00499
; LINE_WIDTH: 0.438143
G1 X84.099 Y97.487 E.00533
; LINE_WIDTH: 0.401756
G1 X83.921 Y97.669 E.00478
; LINE_WIDTH: 0.359855
G1 X83.558 Y98.073 E.00904
G1 X83.356 Y98.365 E.00593
M73 P36 R15
G1 X83.188 Y98.69 E.0061
G1 X83.024 Y99.18 E.00862
G1 X82.955 Y99.537 E.00606
G1 X82.934 Y100.005 E.00781
G1 X83 Y100.539 E.00896
G1 X83.146 Y101.013 E.00826
G1 X83.309 Y101.351 E.00626
G1 X83.537 Y101.709 E.00707
G1 X83.869 Y102.078 E.00827
G1 X84.291 Y102.412 E.00897
G1 X84.739 Y102.652 E.00848
G1 X85.243 Y102.82 E.00885
G1 X85.627 Y102.884 E.0065
G1 X85.978 Y102.895 E.00585
G1 X86.186 Y102.886 E.00347
G1 X86.71 Y102.793 E.00888
G1 X87.222 Y102.606 E.00908
G1 X87.653 Y102.354 E.00833
G1 X88.054 Y102.013 E.00877
G1 X88.31 Y101.721 E.00648
G1 X88.598 Y101.274 E.00887
G1 X88.745 Y100.94 E.00609
G1 X88.883 Y100.422 E.00893
G1 X88.926 Y99.915 E.00847
G1 X88.905 Y99.542 E.00622
G1 X88.799 Y99.027 E.00878
G1 X88.596 Y98.532 E.00891
G1 X88.42 Y98.236 E.00573
G1 X88.194 Y97.936 E.00626
G1 X87.924 Y97.645 E.00663
; LINE_WIDTH: 0.397709
G1 X87.802 Y97.532 E.00308
; LINE_WIDTH: 0.432799
G1 X87.68 Y97.419 E.00338
; LINE_WIDTH: 0.468104
G1 X87.557 Y97.304 E.00371
; LINE_WIDTH: 0.468384
G1 X87.396 Y97.34 E.00365
; LINE_WIDTH: 0.433394
G1 X87.234 Y97.375 E.00336
; WIPE_START
G1 X87.396 Y97.34 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X92.721 Y96.198 Z.72 F18000
G1 Z.32
G1 E.4 F1800
; LINE_WIDTH: 0.109325
G1 F1500
M204 S6000
G1 X92.764 Y96.114 E.00039
G1 X92.932 Y96.01 E.00082
; WIPE_START
G1 X92.764 Y96.114 E-.25686
G1 X92.721 Y96.198 E-.12314
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X93.5 Y94.975 Z.72 F18000
G1 Z.32
G1 E.4 F1800
; LINE_WIDTH: 0.102836
G1 F1500
M204 S6000
G1 X93.617 Y94.808 E.00079
; LINE_WIDTH: 0.148996
G1 X93.735 Y94.641 E.00126
; LINE_WIDTH: 0.195155
G1 X93.853 Y94.474 E.00173
; WIPE_START
G1 X93.735 Y94.641 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X92.696 Y93.423 Z.72 F18000
G1 Z.32
G1 E.4 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.419992
G1 F1500
M204 S6000
G1 X93.551 Y94.022 E.02052
G1 X93.701 Y93.926 E.0035
G1 X93.835 Y93.961 E.00272
G1 X94.351 Y94.324 E.01243
G1 X94.429 Y94.438 E.00272
G1 X94.395 Y94.61 E.00344
G1 X95.231 Y95.198 E.02012
G1 X97.809 Y91.517 E.0884
G1 X95.274 Y89.742 E.06087
G1 X92.731 Y93.374 E.08722
M204 S10000
G1 X93.245 Y93.327 F18000
G1 F1500
M204 S6000
G1 X93.595 Y93.572 E.0084
G1 X93.66 Y93.534 E.00147
G1 X94.061 Y93.638 E.00817
G1 X94.578 Y94.002 E.01243
G1 X94.812 Y94.344 E.00815
G1 X94.797 Y94.413 E.00139
G1 X95.134 Y94.649 E.0081
G1 X97.26 Y91.613 E.07289
G1 X95.371 Y90.291 E.04536
G1 X93.28 Y93.277 E.07171
M204 S10000
G1 X93.82 Y93.194 F18000
G1 F1500
M204 S6000
G1 X94.288 Y93.316 E.00953
G1 X94.805 Y93.679 E.01243
G1 X95.066 Y94.06 E.00907
G1 X96.711 Y91.71 E.05643
G1 X95.468 Y90.84 E.02985
G1 X93.854 Y93.145 E.05535
M204 S10000
G1 X94.453 Y92.977 F18000
G1 F1500
M204 S6000
G1 X95.032 Y93.357 E.01363
G1 X95.054 Y93.389 E.00077
G1 X96.162 Y91.807 E.03799
G1 X95.565 Y91.389 E.01434
G1 X94.487 Y92.928 E.03696
M204 S10000
G1 X94.973 Y92.87 F18000
; LINE_WIDTH: 0.360592
G1 F1500
M204 S6000
G1 X95.62 Y91.946 E.01884
; WIPE_START
G1 X94.973 Y92.87 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X97.699 Y85.741 Z.72 F18000
G1 X97.786 Y85.515 Z.72
G1 Z.32
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.0965247
G1 F1500
M204 S6000
G1 X100.922 Y87.711 E.01352
; WIPE_START
G1 X99.284 Y86.564 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X92.413 Y83.24 Z.72 F18000
G1 X79.428 Y76.956 Z.72
G1 Z.32
G1 E.4 F1800
; LINE_WIDTH: 0.0907146
G1 F1500
M204 S6000
G1 X79.247 Y77.01 E.00061
; LINE_WIDTH: 0.118616
G1 X79.219 Y77.024 E.00015
; LINE_WIDTH: 0.158437
G1 X79.002 Y77.196 E.00183
G1 X78.874 Y77.347 E.00131
; LINE_WIDTH: 0.124518
G1 X78.836 Y77.432 E.00046
; LINE_WIDTH: 0.0998984
G1 X78.788 Y77.595 E.00063
; CHANGE_LAYER
; Z_HEIGHT: 0.44
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F1500
G1 X78.836 Y77.432 E-.38
; WIPE_END
G1 E-.02 F1800
; layer num/total_layer_count: 3/49
; update layer progress
M73 L3
M991 S0 P2 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z.72 I-.523 J1.099 P1  F18000
G1 X100.617 Y87.791 Z.72
G1 Z.44
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X98.655 Y90.592 E.06727
G1 X95.854 Y88.63 E.06727
G1 X97.286 Y86.585 E.04912
G1 X97.815 Y85.829 E.01814
G1 X100.568 Y87.756 E.06609
; WIPE_START
M204 S6000
G1 X99.45 Y89.414 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X95.09 Y83.149 Z.84 F18000
G1 X93.304 Y80.582 Z.84
G1 Z.44
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X93.311 Y88.382 E.1651
G1 X92.95 Y88.382 E.00764
G1 X92.95 Y77.128 E.23818
G1 X93.135 Y77.076 E.00407
G1 X93.216 Y77.207 E.00325
G1 X93.272 Y77.349 E.00324
G1 X93.301 Y77.49 E.00306
G1 X93.304 Y80.522 E.06416
; WIPE_START
M204 S6000
G1 X93.306 Y82.522 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X89.431 Y89.097 Z.84 F18000
G1 X84.702 Y97.12 Z.84
G1 Z.44
G1 E.4 F1800
G1 F1500
M204 S500
G1 X84.583 Y96.956 E.00429
G1 X84.941 Y96.544 E.01155
G1 X86.918 Y96.544 E.04184
G1 X87.275 Y96.955 E.01152
G1 X87.16 Y97.118 E.00423
G1 X86.857 Y96.999 E.00689
G1 X86.34 Y96.881 E.01124
G1 X85.794 Y96.856 E.01156
G1 X85.268 Y96.928 E.01124
G1 X84.903 Y97.034 E.00803
G1 X84.758 Y97.096 E.00335
; WIPE_START
M204 S6000
G1 X84.583 Y96.956 E-.04255
G1 X84.941 Y96.544 E-.10366
G1 X86.172 Y96.544 E-.2338
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X84.883 Y102.293 Z.84 F18000
G1 Z.44
G1 E.4 F1800
G1 F1500
M204 S500
G1 X84.621 Y102.171 E.00612
G1 X84.359 Y101.997 E.00666
G1 X84.113 Y101.789 E.00682
G1 X83.81 Y101.442 E.00975
G1 X83.573 Y101.046 E.00976
G1 X83.451 Y100.748 E.00683
G1 X83.365 Y100.437 E.00682
G1 X83.31 Y99.979 E.00975
G1 X83.338 Y99.52 E.00975
G1 X83.405 Y99.204 E.00684
G1 X83.509 Y98.898 E.00683
G1 X83.721 Y98.489 E.00975
G1 X84.009 Y98.118 E.00995
G1 X84.358 Y97.803 E.00995
G1 X84.75 Y97.561 E.00975
G1 X85.047 Y97.434 E.00683
G1 X85.356 Y97.344 E.00682
G1 X85.813 Y97.282 E.00976
G1 X86.282 Y97.303 E.00995
G1 X86.732 Y97.405 E.00975
G1 X87.032 Y97.523 E.00683
G1 X87.316 Y97.676 E.00683
G1 X87.677 Y97.947 E.00955
G1 X87.904 Y98.177 E.00683
G1 X88.102 Y98.433 E.00685
G1 X88.324 Y98.834 E.00972
G1 X88.435 Y99.129 E.00666
G1 X88.511 Y99.442 E.00682
G1 X88.552 Y99.901 E.00975
G1 X88.51 Y100.37 E.00996
G1 X88.384 Y100.821 E.00992
G1 X88.256 Y101.108 E.00666
G1 X88.091 Y101.385 E.00683
G1 X87.798 Y101.741 E.00975
G1 X87.447 Y102.039 E.00975
G1 X87.173 Y102.208 E.00682
G1 X86.887 Y102.341 E.00666
G1 X86.438 Y102.473 E.00991
G1 X85.97 Y102.522 E.00997
G1 X85.501 Y102.487 E.00994
G1 X85.045 Y102.369 E.00997
G1 X84.937 Y102.318 E.00252
M204 S250
G1 X85.056 Y101.922 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X84.821 Y101.813 E.00509
G1 X84.605 Y101.669 E.00511
G1 X84.401 Y101.497 E.00526
G1 X84.142 Y101.201 E.00773
G1 X83.94 Y100.863 E.00774
G1 X83.839 Y100.615 E.00526
G1 X83.768 Y100.357 E.00526
G1 X83.721 Y99.967 E.00773
G1 X83.744 Y99.575 E.00773
G1 X83.8 Y99.313 E.00527
G1 X83.886 Y99.06 E.00526
G1 X84.067 Y98.711 E.00773
G1 X84.31 Y98.397 E.00779
G1 X84.604 Y98.132 E.0078
G1 X84.939 Y97.925 E.00773
G1 X85.185 Y97.82 E.00526
G1 X85.442 Y97.745 E.00526
G1 X85.831 Y97.692 E.00774
G1 X86.227 Y97.71 E.00779
G1 X86.611 Y97.798 E.00774
G1 X86.86 Y97.895 E.00526
G1 X87.095 Y98.022 E.00526
G1 X87.407 Y98.256 E.00767
G1 X87.595 Y98.447 E.00526
G1 X87.759 Y98.658 E.00527
G1 X87.952 Y99.006 E.00782
G1 X88.043 Y99.25 E.00511
G1 X88.106 Y99.509 E.00526
G1 X88.141 Y99.901 E.00773
G1 X88.106 Y100.296 E.0078
G1 X87.998 Y100.682 E.00789
G1 X87.892 Y100.919 E.00511
G1 X87.755 Y101.149 E.00526
G1 X87.506 Y101.452 E.00773
G1 X87.206 Y101.707 E.00773
G1 X86.978 Y101.847 E.00526
G1 X86.743 Y101.957 E.00511
G1 X86.358 Y102.07 E.00788
G1 X85.964 Y102.111 E.0078
G1 X85.569 Y102.082 E.00779
G1 X85.184 Y101.982 E.00781
G1 X85.11 Y101.947 E.00161
; WIPE_START
M204 S6000
G1 X84.821 Y101.813 E-.0606
G1 X84.605 Y101.669 E-.04936
G1 X84.401 Y101.497 E-.05078
G1 X84.142 Y101.201 E-.0747
G1 X83.94 Y100.863 E-.07474
G1 X83.839 Y100.615 E-.05086
G1 X83.812 Y100.519 E-.01897
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X90.231 Y96.389 Z.84 F18000
G1 X98.177 Y91.275 Z.84
G1 Z.44
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X98.379 Y91.416 E.00522
G1 X95.332 Y95.768 E.11246
G1 X93.972 Y94.816 E.03512
G1 X93.202 Y95.636 E.02381
G1 X92.957 Y95.743 E.00564
G1 X92.98 Y95.478 E.00561
G1 X93.489 Y94.478 E.02376
G1 X92.126 Y93.524 E.0352
G1 X95.174 Y89.172 E.11246
G1 X98.128 Y91.24 E.07633
; WIPE_START
M204 S6000
G1 X98.379 Y91.416 E-.05824
G1 X97.408 Y92.803 E-.32176
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X90.022 Y94.73 Z.84 F18000
G1 X84.691 Y96.12 Z.84
G1 Z.44
G1 E.4 F1800
G1 F1500
M204 S500
G1 X92.5 Y96.12 E.16528
G1 X92.579 Y95.331 E.01679
G1 X92.943 Y94.614 E.01703
G1 X91.536 Y93.628 E.03638
G1 X97.307 Y85.386 E.21296
G1 X97.521 Y85.536 E.00554
G1 X95.284 Y88.731 E.08255
G1 X98.756 Y91.162 E.08971
G1 X100.993 Y87.967 E.08255
G1 X101.207 Y88.117 E.00554
G1 X95.436 Y96.359 E.21296
G1 X94.03 Y95.375 E.03633
G1 X93.476 Y95.963 E.01711
G1 X93.186 Y96.105 E.00682
G1 X92.909 Y96.336 E.00764
G1 X92.72 Y96.43 E.00446
G1 X92.582 Y96.466 E.00302
G1 X92.404 Y96.482 E.00378
G1 X87.426 Y96.482 E.10536
G1 X88.605 Y97.834 E.03798
G1 X88.829 Y98.161 E.00839
G1 X89.091 Y98.703 E.01274
G1 X89.209 Y99.081 E.00839
G1 X89.304 Y99.68 E.01283
G1 X89.289 Y100.282 E.01274
G1 X89.221 Y100.672 E.00839
G1 X89.101 Y101.071 E.0088
G1 X88.845 Y101.614 E.01271
G1 X88.503 Y102.092 E.01243
G1 X88.215 Y102.392 E.00881
G1 X87.897 Y102.65 E.00867
G1 X87.379 Y102.955 E.01273
G1 X87.024 Y103.099 E.0081
G1 X86.628 Y103.208 E.00869
G1 X86.222 Y103.269 E.00868
G1 X85.839 Y103.28 E.00811
G1 X85.431 Y103.243 E.00869
G1 X85.029 Y103.159 E.00869
G1 X84.474 Y102.951 E.01253
G1 X84.123 Y102.757 E.00849
G1 X83.797 Y102.522 E.0085
G1 X83.502 Y102.251 E.00849
G1 X83.24 Y101.947 E.00849
G1 X83.017 Y101.613 E.0085
G1 X82.762 Y101.078 E.01255
G1 X82.643 Y100.686 E.00867
G1 X82.573 Y100.29 E.0085
G1 X82.551 Y99.89 E.00849
G1 X82.576 Y99.49 E.00847
G1 X82.652 Y99.081 E.00881
G1 X82.839 Y98.534 E.01224
G1 X83.028 Y98.17 E.00868
G1 X83.254 Y97.838 E.00849
G1 X84.433 Y96.482 E.03805
G1 X79.467 Y96.482 E.10513
G1 X79.228 Y96.454 E.00508
G1 X78.955 Y96.34 E.00626
G1 X78.828 Y96.24 E.00343
G1 X78.72 Y96.119 E.00343
G1 X78.625 Y95.953 E.00404
G1 X78.579 Y95.813 E.00314
G1 X78.55 Y95.565 E.00528
G1 X78.55 Y77.628 E.37965
G1 X78.588 Y77.349 E.00597
G1 X78.697 Y77.118 E.00539
G1 X78.792 Y76.998 E.00325
G1 X78.909 Y76.893 E.00333
G1 X79.13 Y76.775 E.0053
G1 X79.38 Y76.723 E.00539
G1 X92.4 Y76.72 E.27558
G1 X92.641 Y76.749 E.00515
G1 X92.778 Y76.794 E.00306
G1 X92.955 Y76.889 E.00424
G1 X92.906 Y77.082 E.0042
G1 X79.858 Y77.082 E.27618
G1 X79.502 Y77.166 E.00775
G1 X79.265 Y77.322 E.006
G1 X79.073 Y77.537 E.0061
G1 X78.948 Y77.807 E.00629
G1 X78.911 Y78.056 E.00533
G1 X78.911 Y95.155 E.36192
G1 X78.964 Y95.453 E.0064
G1 X79.152 Y95.778 E.00796
G1 X79.512 Y96.047 E.00951
G1 X79.867 Y96.12 E.00767
G1 X84.631 Y96.12 E.10084
; WIPE_START
M204 S6000
G1 X86.631 Y96.12 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X83.535 Y96.891 Z.84 F18000
G1 Z.44
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X79.443 Y96.891 E.08049
G1 X79.133 Y96.855 E.00613
G1 X78.847 Y96.75 E.006
G1 X78.725 Y96.68 E.00277
G1 X78.546 Y96.539 E.00448
G1 X78.395 Y96.369 E.00448
G1 X78.314 Y96.246 E.00289
G1 X78.246 Y96.11 E.00299
G1 X78.177 Y95.901 E.00431
G1 X78.141 Y95.589 E.00619
G1 X78.141 Y77.61 E.35362
G1 X78.161 Y77.374 E.00466
M73 P37 R15
G1 X78.195 Y77.231 E.00289
G1 X78.245 Y77.093 E.00289
G1 X78.353 Y76.892 E.00448
G1 X78.493 Y76.716 E.00442
G1 X78.659 Y76.568 E.00438
G1 X78.783 Y76.486 E.00294
G1 X78.99 Y76.389 E.00448
G1 X79.21 Y76.33 E.00448
G1 X79.356 Y76.313 E.00289
G1 X92.424 Y76.311 E.25704
G1 X92.731 Y76.347 E.00608
G1 X92.941 Y76.417 E.00436
G1 X93.139 Y76.524 E.00442
G1 X93.315 Y76.663 E.00442
G1 X93.465 Y76.831 E.00442
G1 X93.583 Y77.022 E.00442
G1 X93.666 Y77.231 E.00442
G1 X93.71 Y77.448 E.00436
G1 X93.72 Y88.791 E.2231
G1 X92.541 Y88.791 E.02321
G1 X92.541 Y77.491 E.22226
G1 X79.906 Y77.491 E.24851
G1 X79.667 Y77.548 E.00484
G1 X79.535 Y77.634 E.0031
G1 X79.419 Y77.764 E.00343
G1 X79.344 Y77.925 E.00349
G1 X79.321 Y78.085 E.00318
G1 X79.321 Y95.119 E.33504
G1 X79.354 Y95.311 E.00382
G1 X79.464 Y95.501 E.00431
G1 X79.684 Y95.664 E.0054
G1 X79.909 Y95.711 E.00452
G1 X92.124 Y95.711 E.24025
G1 X92.155 Y95.336 E.0074
G1 X92.193 Y95.186 E.00304
G1 X92.417 Y94.745 E.00973
G1 X90.966 Y93.729 E.03486
G1 X97.206 Y84.816 E.214
G1 X101.777 Y88.017 E.10975
G1 X95.536 Y96.929 E.214
G1 X94.085 Y95.913 E.03485
G1 X93.742 Y96.278 E.00987
G1 X93.604 Y96.369 E.00325
G1 X93.403 Y96.457 E.00431
G1 X93.133 Y96.681 E.0069
G1 X92.865 Y96.814 E.00589
G1 X92.653 Y96.871 E.00432
G1 X92.421 Y96.891 E.00456
G1 X88.326 Y96.891 E.08056
G1 X88.925 Y97.579 E.01794
G1 X89.184 Y97.957 E.00901
G1 X89.394 Y98.362 E.00898
G1 X89.477 Y98.564 E.0043
G1 X89.607 Y98.983 E.00862
G1 X89.693 Y99.443 E.0092
G1 X89.713 Y99.661 E.0043
G1 X89.714 Y100.117 E.00897
G1 X89.695 Y100.335 E.00431
G1 X89.62 Y100.767 E.00862
G1 X89.486 Y101.212 E.00914
G1 X89.305 Y101.627 E.00891
G1 X89.08 Y102.009 E.00873
G1 X88.815 Y102.358 E.00862
G1 X88.492 Y102.693 E.00915
G1 X88.141 Y102.979 E.0089
G1 X87.96 Y103.102 E.00431
G1 X87.561 Y103.322 E.00897
G1 X87.358 Y103.412 E.00436
G1 X87.15 Y103.489 E.00437
G1 X86.713 Y103.609 E.00891
G1 X86.265 Y103.676 E.00891
G1 X86.043 Y103.689 E.00437
G1 X85.821 Y103.689 E.00437
G1 X85.37 Y103.649 E.00891
G1 X84.927 Y103.555 E.00891
G1 X84.717 Y103.491 E.0043
G1 X84.298 Y103.321 E.00891
G1 X83.904 Y103.103 E.00885
G1 X83.539 Y102.84 E.00885
G1 X83.207 Y102.536 E.00885
G1 X82.914 Y102.195 E.00885
G1 X82.663 Y101.821 E.00886
G1 X82.464 Y101.431 E.00862
G1 X82.376 Y101.214 E.00459
G1 X82.245 Y100.781 E.00891
G1 X82.166 Y100.338 E.00885
G1 X82.141 Y99.889 E.00885
G1 X82.169 Y99.44 E.00884
G1 X82.254 Y98.983 E.00914
G1 X82.384 Y98.564 E.00862
G1 X82.467 Y98.362 E.00431
G1 X82.676 Y97.96 E.00891
G1 X82.929 Y97.588 E.00885
G1 X83.496 Y96.936 E.01698
; WIPE_START
M204 S6000
G1 X81.496 Y96.914 E-.38
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
G1 X79.376 Y96.249
G1 Z.44
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.146275
G1 F1500
M204 S6000
G1 X79.143 Y96.123 E.00159
G1 X78.954 Y95.971 E.00146
G1 X78.877 Y95.848 E.00087
G1 X78.778 Y95.627 E.00146
; WIPE_START
G1 X78.877 Y95.848 E-.10291
G1 X78.954 Y95.971 E-.06165
G1 X79.143 Y96.123 E-.10317
G1 X79.376 Y96.249 E-.11227
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X84.474 Y97.167 Z.84 F18000
G1 Z.44
G1 E.4 F1800
; LINE_WIDTH: 0.475211
G1 F1500
M204 S6000
G1 X84.3 Y97.315 E.00513
; LINE_WIDTH: 0.438836
G1 X84.099 Y97.487 E.00545
; LINE_WIDTH: 0.401782
G1 X83.921 Y97.669 E.00478
; LINE_WIDTH: 0.359638
G1 X83.723 Y97.872 E.00473
G1 X83.396 Y98.299 E.00895
G1 X83.158 Y98.762 E.00866
G1 X83.022 Y99.173 E.00721
G1 X82.955 Y99.537 E.00617
G1 X82.934 Y100.005 E.0078
G1 X83.014 Y100.595 E.00991
G1 X83.186 Y101.106 E.00898
G1 X83.348 Y101.418 E.00586
G1 X83.544 Y101.716 E.00594
G1 X83.857 Y102.066 E.00782
G1 X84.038 Y102.226 E.00403
G1 X84.327 Y102.434 E.00593
G1 X84.64 Y102.604 E.00593
G1 X84.977 Y102.744 E.00609
G1 X85.487 Y102.867 E.00873
G1 X85.99 Y102.9 E.0084
G1 X86.526 Y102.841 E.00898
G1 X87.009 Y102.698 E.00839
G1 X87.342 Y102.543 E.00612
G1 X87.675 Y102.342 E.00648
G1 X88.056 Y102.015 E.00836
G1 X88.389 Y101.61 E.00874
G1 X88.584 Y101.289 E.00625
G1 X88.745 Y100.937 E.00645
G1 X88.883 Y100.423 E.00888
G1 X88.925 Y99.915 E.00848
G1 X88.92 Y99.702 E.00355
G1 X88.838 Y99.173 E.00891
G1 X88.675 Y98.689 E.00851
G1 X88.498 Y98.356 E.00629
G1 X88.305 Y98.071 E.00573
G1 X87.924 Y97.645 E.00952
; LINE_WIDTH: 0.397068
G1 X87.805 Y97.535 E.003
; LINE_WIDTH: 0.4311
G1 X87.686 Y97.425 E.00327
; LINE_WIDTH: 0.465682
G1 X87.564 Y97.311 E.00367
; LINE_WIDTH: 0.470391
G1 X87.401 Y97.344 E.00369
; LINE_WIDTH: 0.444538
G1 X87.238 Y97.377 E.00348
; WIPE_START
G1 X87.401 Y97.344 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X93.499 Y94.976 Z.84 F18000
G1 Z.44
G1 E.4 F1800
; LINE_WIDTH: 0.102953
G1 F1500
M204 S6000
G1 X93.617 Y94.809 E.00079
; LINE_WIDTH: 0.149351
G1 X93.734 Y94.641 E.00126
; LINE_WIDTH: 0.195749
G1 X93.852 Y94.474 E.00174
; WIPE_START
G1 X93.734 Y94.641 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X92.696 Y93.423 Z.84 F18000
G1 Z.44
G1 E.4 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.419992
G1 F1500
M204 S6000
G1 X93.55 Y94.021 E.0205
G1 X93.7 Y93.926 E.0035
G1 X93.834 Y93.96 E.00272
G1 X94.341 Y94.317 E.0122
G1 X94.419 Y94.43 E.0027
G1 X94.393 Y94.611 E.00359
G1 X95.231 Y95.198 E.02014
G1 X97.809 Y91.517 E.0884
G1 X95.274 Y89.742 E.06087
G1 X92.731 Y93.374 E.08722
M204 S10000
G1 X93.245 Y93.327 F18000
G1 F1500
M204 S6000
G1 X93.595 Y93.571 E.00839
G1 X93.659 Y93.534 E.00146
G1 X94.061 Y93.638 E.00816
G1 X94.568 Y93.995 E.0122
G1 X94.802 Y94.335 E.00811
G1 X94.788 Y94.407 E.00145
G1 X95.134 Y94.649 E.00831
G1 X97.26 Y91.613 E.07289
G1 X95.371 Y90.291 E.04536
G1 X93.28 Y93.277 E.07171
M204 S10000
G1 X93.82 Y93.194 F18000
G1 F1500
M204 S6000
G1 X94.287 Y93.315 E.0095
G1 X94.795 Y93.672 E.0122
G1 X95.063 Y94.063 E.00934
G1 X96.711 Y91.71 E.0565
G1 X95.468 Y90.84 E.02985
G1 X93.854 Y93.145 E.05534
M204 S10000
G1 X94.453 Y92.977 F18000
G1 F1500
M204 S6000
G1 X95.021 Y93.349 E.01337
G1 X95.051 Y93.393 E.00104
G1 X96.162 Y91.807 E.03808
G1 X95.565 Y91.389 E.01434
G1 X94.487 Y92.928 E.03695
M204 S10000
G1 X94.973 Y92.87 F18000
; LINE_WIDTH: 0.360602
G1 F1500
M204 S6000
G1 X95.62 Y91.946 E.01884
; WIPE_START
G1 X94.973 Y92.87 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X97.699 Y85.741 Z.84 F18000
G1 X97.786 Y85.515 Z.84
G1 Z.44
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.096525
G1 F1500
M204 S6000
G1 X100.922 Y87.711 E.01352
; WIPE_START
G1 X99.284 Y86.564 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X92.412 Y83.243 Z.84 F18000
G1 X79.399 Y76.955 Z.84
G1 Z.44
G1 E.4 F1800
; LINE_WIDTH: 0.0924923
G1 F1500
M204 S6000
G1 X79.31 Y76.992 E.00032
; LINE_WIDTH: 0.139452
G1 X79.078 Y77.118 E.0015
; LINE_WIDTH: 0.15252
G1 X79.001 Y77.192 E.00068
G1 X78.85 Y77.399 E.00162
; LINE_WIDTH: 0.104957
G1 X78.788 Y77.595 E.00081
; CHANGE_LAYER
; Z_HEIGHT: 0.56
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F1500
G1 X78.85 Y77.399 E-.38
; WIPE_END
M73 P38 R15
G1 E-.02 F1800
; layer num/total_layer_count: 4/49
; update layer progress
M73 L4
M991 S0 P3 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z.84 I-.524 J1.098 P1  F18000
G1 X100.617 Y87.791 Z.84
G1 Z.56
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X98.655 Y90.592 E.06727
G1 X95.854 Y88.63 E.06727
G1 X97.157 Y86.769 E.0447
G1 X97.815 Y85.829 E.02257
G1 X100.568 Y87.756 E.06609
; WIPE_START
M204 S6000
G1 X99.45 Y89.414 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X95.09 Y83.149 Z.96 F18000
G1 X93.304 Y80.581 Z.96
G1 Z.56
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X93.311 Y88.382 E.1651
G1 X92.95 Y88.382 E.00764
G1 X92.95 Y77.128 E.23818
G1 X93.135 Y77.076 E.00407
G1 X93.216 Y77.207 E.00325
G1 X93.272 Y77.349 E.00324
G1 X93.301 Y77.49 E.00306
G1 X93.304 Y80.521 E.06416
; WIPE_START
M204 S6000
G1 X93.306 Y82.521 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X89.428 Y89.096 Z.96 F18000
G1 X84.692 Y97.126 Z.96
G1 Z.56
G1 E.4 F1800
G1 F1500
M204 S500
G1 X84.577 Y96.963 E.00423
G1 X84.941 Y96.544 E.01174
G1 X86.92 Y96.544 E.04188
G1 X87.273 Y96.951 E.0114
G1 X87.15 Y97.115 E.00436
G1 X87.029 Y97.059 E.00282
G1 X86.535 Y96.915 E.0109
G1 X86.158 Y96.864 E.00804
G1 X85.794 Y96.859 E.00771
G1 X85.432 Y96.897 E.00771
G1 X85.061 Y96.981 E.00804
G1 X84.748 Y97.104 E.00712
; WIPE_START
M204 S6000
G1 X84.577 Y96.963 E-.04213
G1 X84.941 Y96.544 E-.10541
G1 X86.165 Y96.544 E-.23246
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X84.856 Y102.288 Z.96 F18000
G1 Z.56
G1 E.4 F1800
G1 F1500
M204 S500
G1 X84.486 Y102.089 E.00889
G1 X84.119 Y101.796 E.00995
G1 X83.816 Y101.449 E.00975
G1 X83.642 Y101.177 E.00682
G1 X83.507 Y100.897 E.0066
G1 X83.366 Y100.447 E.00997
G1 X83.31 Y99.979 E.00997
G1 X83.338 Y99.519 E.00975
G1 X83.405 Y99.204 E.00682
G1 X83.505 Y98.909 E.0066
G1 X83.721 Y98.49 E.00997
G1 X84.009 Y98.118 E.00997
G1 X84.358 Y97.803 E.00995
G1 X84.758 Y97.556 E.00995
G1 X85.187 Y97.388 E.00975
G1 X85.501 Y97.316 E.00683
G1 X85.813 Y97.283 E.00663
G1 X86.126 Y97.288 E.00663
G1 X86.446 Y97.331 E.00683
G1 X86.879 Y97.458 E.00955
G1 X87.172 Y97.593 E.00683
G1 X87.447 Y97.763 E.00683
G1 X87.798 Y98.061 E.00975
G1 X88.097 Y98.424 E.00995
G1 X88.321 Y98.826 E.00975
G1 X88.435 Y99.129 E.00683
G1 X88.511 Y99.442 E.00683
G1 X88.552 Y99.901 E.00975
G1 X88.511 Y100.36 E.00975
G1 X88.435 Y100.673 E.00683
G1 X88.321 Y100.975 E.00683
G1 X88.097 Y101.378 E.00975
G1 X87.798 Y101.741 E.00995
G1 X87.447 Y102.039 E.00975
G1 X87.173 Y102.208 E.00682
G1 X86.89 Y102.34 E.0066
G1 X86.438 Y102.473 E.00997
G1 X85.979 Y102.521 E.00977
G1 X85.657 Y102.507 E.00683
G1 X85.338 Y102.454 E.00683
G1 X84.91 Y102.315 E.00954
M204 S250
G1 X85.05 Y101.928 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X84.713 Y101.746 E.00753
G1 X84.403 Y101.499 E.0078
G1 X84.144 Y101.203 E.00773
G1 X84 Y100.977 E.00526
G1 X83.888 Y100.746 E.00506
G1 X83.768 Y100.361 E.00793
G1 X83.721 Y99.967 E.0078
G1 X83.744 Y99.574 E.00774
G1 X83.8 Y99.313 E.00526
G1 X83.883 Y99.069 E.00506
G1 X84.067 Y98.711 E.00793
G1 X84.31 Y98.397 E.0078
G1 X84.604 Y98.132 E.0078
G1 X84.942 Y97.924 E.0078
G1 X85.308 Y97.78 E.00773
G1 X85.568 Y97.72 E.00526
G1 X85.831 Y97.693 E.0052
G1 X86.096 Y97.697 E.0052
G1 X86.361 Y97.733 E.00526
G1 X86.735 Y97.842 E.00767
G1 X86.978 Y97.954 E.00526
G1 X87.206 Y98.095 E.00526
G1 X87.506 Y98.349 E.00773
G1 X87.757 Y98.656 E.0078
G1 X87.949 Y98.999 E.00774
G1 X88.043 Y99.25 E.00526
G1 X88.106 Y99.509 E.00526
G1 X88.141 Y99.901 E.00773
G1 X88.106 Y100.292 E.00773
G1 X88.043 Y100.552 E.00526
G1 X87.949 Y100.803 E.00526
G1 X87.757 Y101.146 E.00774
G1 X87.506 Y101.452 E.0078
G1 X87.206 Y101.707 E.00773
G1 X86.978 Y101.847 E.00526
G1 X86.745 Y101.956 E.00506
G1 X86.358 Y102.07 E.00793
G1 X85.967 Y102.111 E.00774
G1 X85.7 Y102.099 E.00526
G1 X85.436 Y102.055 E.00526
G1 X85.106 Y101.948 E.00682
; WIPE_START
M204 S6000
G1 X84.713 Y101.746 E-.08405
G1 X84.403 Y101.499 E-.07533
G1 X84.144 Y101.203 E-.07469
G1 X84 Y100.977 E-.0508
G1 X83.888 Y100.746 E-.04889
G1 X83.816 Y100.513 E-.04624
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X90.235 Y96.384 Z.96 F18000
G1 X98.177 Y91.275 Z.96
G1 Z.56
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X98.379 Y91.416 E.00522
G1 X95.332 Y95.768 E.11246
G1 X93.972 Y94.816 E.03514
G1 X93.202 Y95.636 E.0238
G1 X92.95 Y95.746 E.00582
G1 X92.994 Y95.432 E.0067
G1 X93.533 Y94.509 E.02263
G1 X92.126 Y93.524 E.03633
G1 X95.174 Y89.172 E.11245
G1 X98.128 Y91.24 E.07633
; WIPE_START
M204 S6000
G1 X98.379 Y91.416 E-.05824
G1 X97.408 Y92.803 E-.32176
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X90.022 Y94.73 Z.96 F18000
G1 X84.691 Y96.12 Z.96
G1 Z.56
G1 E.4 F1800
G1 F1500
M204 S500
G1 X92.469 Y96.12 E.16462
G1 X92.581 Y95.325 E.01699
G1 X92.969 Y94.632 E.01682
G1 X91.536 Y93.628 E.03705
G1 X97.307 Y85.386 E.21296
G1 X97.521 Y85.536 E.00554
G1 X95.284 Y88.731 E.08255
G1 X98.756 Y91.162 E.08971
G1 X100.993 Y87.967 E.08255
G1 X101.207 Y88.117 E.00554
G1 X95.436 Y96.359 E.21296
G1 X94.029 Y95.374 E.03634
G1 X93.476 Y95.963 E.0171
G1 X93.186 Y96.105 E.00683
G1 X92.902 Y96.341 E.00781
G1 X92.778 Y96.407 E.00297
G1 X92.573 Y96.467 E.00452
G1 X92.404 Y96.482 E.00361
G1 X87.428 Y96.482 E.10532
G1 X88.614 Y97.845 E.03825
G1 X88.721 Y97.993 E.00386
G1 X88.936 Y98.353 E.00888
G1 X89.159 Y98.901 E.01254
G1 X89.286 Y99.49 E.01274
G1 X89.305 Y100.1 E.01292
G1 X89.222 Y100.668 E.01215
G1 X89.101 Y101.071 E.00891
G1 X88.849 Y101.607 E.01253
G1 X88.621 Y101.947 E.00866
G1 X88.353 Y102.258 E.00869
G1 X87.911 Y102.639 E.01235
G1 X87.744 Y102.753 E.00428
G1 X87.395 Y102.947 E.00846
G1 X87.21 Y103.029 E.00428
G1 X86.832 Y103.158 E.00846
G1 X86.636 Y103.207 E.00427
G1 X86.222 Y103.269 E.00885
G1 X85.63 Y103.267 E.01254
G1 X85.047 Y103.164 E.01254
G1 X84.65 Y103.029 E.00886
G1 X84.124 Y102.757 E.01255
G1 X83.797 Y102.522 E.0085
G1 X83.502 Y102.251 E.00849
G1 X83.24 Y101.947 E.00849
G1 X83.017 Y101.613 E.0085
G1 X82.83 Y101.248 E.00869
G1 X82.648 Y100.703 E.01215
G1 X82.573 Y100.289 E.0089
G1 X82.551 Y99.89 E.00847
G1 X82.576 Y99.49 E.00849
G1 X82.648 Y99.095 E.0085
G1 X82.767 Y98.712 E.00849
G1 X82.934 Y98.337 E.00869
G1 X83.254 Y97.838 E.01253
G1 X84.434 Y96.482 E.03805
G1 X79.467 Y96.482 E.10513
G1 X79.219 Y96.453 E.00528
G1 X79.079 Y96.407 E.00311
G1 X78.913 Y96.312 E.00406
G1 X78.731 Y96.133 E.00539
G1 X78.65 Y96.003 E.00324
G1 X78.578 Y95.803 E.0045
G1 X78.55 Y95.565 E.00508
G1 X78.55 Y77.628 E.37965
G1 X78.588 Y77.349 E.00597
G1 X78.701 Y77.11 E.00558
G1 X78.866 Y76.928 E.0052
G1 X78.991 Y76.84 E.00324
G1 X79.131 Y76.775 E.00325
G1 X79.381 Y76.723 E.00541
G1 X92.401 Y76.72 E.27559
G1 X92.641 Y76.749 E.00512
G1 X92.778 Y76.794 E.00306
G1 X92.955 Y76.889 E.00424
G1 X92.906 Y77.082 E.0042
G1 X79.895 Y77.082 E.2754
G1 X79.685 Y77.106 E.00446
G1 X79.392 Y77.223 E.00668
G1 X79.085 Y77.512 E.00892
G1 X78.948 Y77.806 E.00688
G1 X78.911 Y78.055 E.00533
G1 X78.911 Y95.155 E.36193
G1 X78.964 Y95.452 E.00639
G1 X79.152 Y95.778 E.00796
G1 X79.512 Y96.047 E.00952
G1 X79.867 Y96.12 E.00768
G1 X84.631 Y96.12 E.10083
; WIPE_START
M204 S6000
G1 X86.631 Y96.12 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X83.535 Y96.891 Z.96 F18000
G1 Z.56
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X79.443 Y96.891 E.08049
G1 X79.13 Y96.854 E.00619
G1 X78.923 Y96.786 E.00428
G1 X78.785 Y96.718 E.00303
G1 X78.663 Y96.637 E.00288
G1 X78.491 Y96.484 E.00454
G1 X78.398 Y96.373 E.00283
G1 X78.28 Y96.182 E.00442
G1 X78.177 Y95.898 E.00595
G1 X78.141 Y95.589 E.00613
G1 X78.141 Y77.61 E.35362
G1 X78.161 Y77.374 E.00466
G1 X78.195 Y77.231 E.00289
G1 X78.245 Y77.093 E.00289
G1 X78.355 Y76.89 E.00454
G1 X78.441 Y76.774 E.00283
G1 X78.602 Y76.613 E.00448
G1 X78.786 Y76.484 E.00442
G1 X78.99 Y76.389 E.00442
G1 X79.203 Y76.332 E.00434
G1 X79.356 Y76.313 E.00303
G1 X92.425 Y76.311 E.25706
G1 X92.731 Y76.347 E.00605
G1 X92.941 Y76.417 E.00436
G1 X93.139 Y76.524 E.00442
G1 X93.315 Y76.663 E.00442
G1 X93.465 Y76.831 E.00442
G1 X93.583 Y77.022 E.00442
G1 X93.666 Y77.231 E.00442
G1 X93.71 Y77.448 E.00436
G1 X93.72 Y88.791 E.2231
G1 X92.541 Y88.791 E.02321
G1 X92.541 Y77.491 E.22226
G1 X79.918 Y77.491 E.24827
G1 X79.786 Y77.506 E.00262
G1 X79.616 Y77.574 E.00361
G1 X79.423 Y77.756 E.00521
G1 X79.344 Y77.925 E.00367
G1 X79.321 Y78.085 E.00318
G1 X79.321 Y95.119 E.33504
G1 X79.354 Y95.31 E.00382
G1 X79.464 Y95.5 E.00431
G1 X79.684 Y95.664 E.0054
G1 X79.909 Y95.711 E.00453
G1 X92.113 Y95.711 E.24004
G1 X92.182 Y95.223 E.0097
G1 X92.239 Y95.073 E.00315
G1 X92.426 Y94.751 E.00733
G1 X90.966 Y93.729 E.03507
G1 X97.206 Y84.816 E.214
G1 X101.777 Y88.017 E.10975
G1 X95.536 Y96.929 E.214
G1 X94.085 Y95.913 E.03485
G1 X93.742 Y96.278 E.00986
G1 X93.604 Y96.369 E.00325
G1 X93.403 Y96.457 E.00431
M73 P39 R15
G1 X93.131 Y96.683 E.00695
G1 X92.934 Y96.787 E.0044
G1 X92.65 Y96.871 E.00582
G1 X92.421 Y96.891 E.00451
G1 X88.326 Y96.891 E.08055
G1 X88.934 Y97.59 E.01823
G1 X89.063 Y97.767 E.0043
G1 X89.296 Y98.159 E.00897
G1 X89.391 Y98.356 E.00431
G1 X89.551 Y98.78 E.00891
G1 X89.659 Y99.22 E.00891
G1 X89.713 Y99.661 E.00873
G1 X89.714 Y100.117 E.00897
G1 X89.695 Y100.335 E.00431
G1 X89.621 Y100.762 E.00853
G1 X89.486 Y101.212 E.00924
G1 X89.313 Y101.609 E.00852
G1 X89.199 Y101.819 E.00469
G1 X88.947 Y102.195 E.0089
G1 X88.652 Y102.538 E.00891
G1 X88.495 Y102.691 E.00431
G1 X88.157 Y102.967 E.00859
G1 X87.959 Y103.102 E.0047
G1 X87.578 Y103.313 E.00858
G1 X87.36 Y103.411 E.0047
G1 X86.947 Y103.551 E.00858
G1 X86.715 Y103.609 E.00469
G1 X86.265 Y103.676 E.00896
G1 X86.046 Y103.689 E.00431
G1 X85.593 Y103.675 E.00891
G1 X85.145 Y103.608 E.00891
G1 X84.933 Y103.557 E.00431
G1 X84.501 Y103.411 E.00897
G1 X84.283 Y103.313 E.00469
G1 X83.904 Y103.103 E.00853
G1 X83.539 Y102.84 E.00885
G1 X83.207 Y102.536 E.00885
G1 X82.914 Y102.195 E.00885
G1 X82.663 Y101.821 E.00885
G1 X82.457 Y101.417 E.00891
G1 X82.376 Y101.215 E.0043
G1 X82.25 Y100.8 E.00853
G1 X82.166 Y100.337 E.00923
G1 X82.141 Y99.889 E.00884
G1 X82.169 Y99.44 E.00885
G1 X82.25 Y98.997 E.00885
G1 X82.383 Y98.567 E.00885
G1 X82.568 Y98.153 E.00891
G1 X82.674 Y97.962 E.0043
G1 X82.929 Y97.588 E.00891
G1 X83.496 Y96.936 E.01698
; WIPE_START
M204 S6000
G1 X81.496 Y96.914 E-.38
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




G1 X79.339 Y96.25
G1 Z.56
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.159536
G1 F1500
M204 S6000
G1 X78.988 Y96.005 E.00285
G1 X78.897 Y95.882 E.00102
; LINE_WIDTH: 0.133671
G1 X78.778 Y95.627 E.00152
; WIPE_START
G1 X78.897 Y95.882 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X84.466 Y97.174 Z.96 F18000
G1 Z.56
G1 E.4 F1800
; LINE_WIDTH: 0.473061
G1 F1500
M204 S6000
G1 X84.296 Y97.318 E.00499
; LINE_WIDTH: 0.438146
G1 X84.099 Y97.487 E.00533
; LINE_WIDTH: 0.401747
G1 X83.921 Y97.669 E.00478
; LINE_WIDTH: 0.359203
G1 X83.558 Y98.073 E.00903
G1 X83.351 Y98.374 E.00608
G1 X83.154 Y98.773 E.00741
G1 X83.019 Y99.186 E.00722
G1 X82.955 Y99.536 E.00593
G1 X82.934 Y100.005 E.00781
G1 X83.001 Y100.54 E.00897
G1 X83.152 Y101.024 E.00842
G1 X83.317 Y101.37 E.00639
G1 X83.544 Y101.716 E.00688
G1 X83.848 Y102.058 E.00761
G1 X84.266 Y102.395 E.00894
G1 X84.767 Y102.661 E.00943
G1 X85.151 Y102.795 E.00676
G1 X85.664 Y102.888 E.00867
G1 X86.185 Y102.886 E.00868
G1 X86.525 Y102.836 E.00572
G1 X87.011 Y102.693 E.00842
G1 X87.359 Y102.533 E.00637
G1 X87.686 Y102.333 E.00639
G1 X88.08 Y101.994 E.00864
M73 P39 R14
G1 X88.416 Y101.577 E.0089
G1 X88.655 Y101.143 E.00825
G1 X88.797 Y100.775 E.00657
G1 X88.88 Y100.433 E.00584
G1 X88.907 Y100.238 E.00329
G1 X88.926 Y99.886 E.00585
G1 X88.883 Y99.393 E.00825
G1 X88.796 Y99.014 E.00647
G1 X88.596 Y98.532 E.00868
G1 X88.398 Y98.201 E.00641
G1 X88.058 Y97.784 E.00895
; LINE_WIDTH: 0.378805
G1 X87.881 Y97.609 E.00438
; LINE_WIDTH: 0.419294
G1 X87.678 Y97.411 E.00557
; LINE_WIDTH: 0.468114
G1 X87.38 Y97.162 E.00858
; WIPE_START
G1 X87.678 Y97.411 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X92.678 Y96.157 Z.96 F18000
G1 Z.56
G1 E.4 F1800
; LINE_WIDTH: 0.123652
G1 F1500
M204 S6000
G1 X92.843 Y96.065 E.00092
; LINE_WIDTH: 0.0923716
G1 X92.932 Y96.011 E.00035
; WIPE_START
G1 X92.843 Y96.065 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X93.592 Y94.876 Z.96 F18000
G1 Z.56
G1 E.4 F1800
; LINE_WIDTH: 0.101341
G1 F1500
M204 S6000
G1 X93.735 Y94.684 E.0009
; LINE_WIDTH: 0.14453
G1 X93.878 Y94.492 E.00142
; WIPE_START
G1 X93.735 Y94.684 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X92.696 Y93.423 Z.96 F18000
G1 Z.56
G1 E.4 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.419992
G1 F1500
M204 S6000
G1 X93.602 Y94.057 E.02174
G1 X93.757 Y93.956 E.00366
G1 X93.895 Y93.994 E.00281
G1 X94.351 Y94.334 E.01119
G1 X94.424 Y94.441 E.00255
G1 X94.391 Y94.61 E.00338
G1 X95.231 Y95.198 E.02017
G1 X97.809 Y91.517 E.0884
G1 X95.274 Y89.742 E.06087
G1 X92.731 Y93.374 E.08722
M204 S10000
G1 X93.245 Y93.327 F18000
G1 F1500
M204 S6000
G1 X93.643 Y93.605 E.00955
G1 X93.717 Y93.563 E.00167
G1 X94.131 Y93.678 E.00844
G1 X94.587 Y94.018 E.01119
G1 X94.805 Y94.34 E.00765
G1 X94.791 Y94.409 E.00138
G1 X95.134 Y94.649 E.00824
G1 X97.26 Y91.613 E.07289
G1 X95.371 Y90.291 E.04536
G1 X93.28 Y93.277 E.07171
M204 S10000
G1 X93.81 Y93.208 F18000
G1 F1500
M204 S6000
G1 X94.367 Y93.362 E.01136
G1 X94.823 Y93.702 E.01119
G1 X95.065 Y94.061 E.00852
G1 X96.711 Y91.71 E.05644
G1 X95.468 Y90.84 E.02985
G1 X93.844 Y93.159 E.05568
M204 S10000
G1 X94.437 Y93 F18000
G1 F1500
M204 S6000
G1 X94.602 Y93.046 E.00338
G1 X95.057 Y93.385 E.01116
G1 X96.162 Y91.807 E.03789
G1 X95.565 Y91.389 E.01434
G1 X94.471 Y92.951 E.0375
M204 S10000
G1 X94.974 Y92.868 F18000
; LINE_WIDTH: 0.360612
G1 F1500
M204 S6000
G1 X95.62 Y91.946 E.01881
; WIPE_START
G1 X94.974 Y92.868 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X97.7 Y85.739 Z.96 F18000
G1 X97.786 Y85.515 Z.96
G1 Z.56
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.0965249
G1 F1500
M204 S6000
G1 X100.922 Y87.711 E.01352
; WIPE_START
G1 X99.284 Y86.564 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X92.413 Y83.24 Z.96 F18000
G1 X79.428 Y76.957 Z.96
G1 Z.56
G1 E.4 F1800
; LINE_WIDTH: 0.0989882
G1 F1500
M204 S6000
G1 X79.223 Y77.022 E.00078
; LINE_WIDTH: 0.138177
G1 X79.137 Y77.086 E.0006
; LINE_WIDTH: 0.159798
G1 X78.937 Y77.265 E.00179
G1 X78.862 Y77.368 E.00085
; LINE_WIDTH: 0.107898
G1 X78.788 Y77.595 E.00098
; CHANGE_LAYER
; Z_HEIGHT: 0.68
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F1500
G1 X78.862 Y77.368 E-.38
; WIPE_END
G1 E-.02 F1800
; layer num/total_layer_count: 5/49
; update layer progress
M73 L5
M991 S0 P4 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z.96 I-.526 J1.098 P1  F18000
G1 X100.617 Y87.791 Z.96
G1 Z.68
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X98.655 Y90.592 E.06727
G1 X95.854 Y88.63 E.06727
G1 X97.028 Y86.953 E.04027
G1 X97.815 Y85.829 E.027
G1 X100.568 Y87.756 E.06609
; WIPE_START
M204 S6000
G1 X99.45 Y89.414 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X95.115 Y83.132 Z1.08 F18000
G1 X93.304 Y80.509 Z1.08
G1 Z.68
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X93.311 Y88.382 E.16664
G1 X92.95 Y88.382 E.00764
G1 X92.95 Y77.128 E.23818
G1 X93.135 Y77.076 E.00407
G1 X93.216 Y77.207 E.00325
G1 X93.272 Y77.349 E.00324
G1 X93.301 Y77.49 E.00306
G1 X93.304 Y80.449 E.06262
; WIPE_START
M204 S6000
G1 X93.306 Y82.449 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X89.458 Y89.04 Z1.08 F18000
G1 X84.752 Y97.102 Z1.08
G1 Z.68
G1 E.4 F1800
G1 F1500
M204 S500
G1 X84.638 Y96.936 E.00428
G1 X84.995 Y96.544 E.01122
G1 X86.92 Y96.544 E.04073
G1 X87.266 Y96.942 E.01117
G1 X87.159 Y97.104 E.0041
G1 X86.697 Y96.953 E.0103
G1 X86.324 Y96.88 E.00804
G1 X85.81 Y96.857 E.0109
G1 X85.432 Y96.897 E.00804
G1 X85.061 Y96.981 E.00805
G1 X84.808 Y97.081 E.00575
; WIPE_START
M204 S6000
G1 X84.638 Y96.936 E-.04247
G1 X84.995 Y96.544 E-.10074
G1 X86.242 Y96.544 E-.23679
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X84.855 Y102.288 Z1.08 F18000
G1 Z.68
G1 E.4 F1800
G1 F1500
M204 S500
G1 X84.486 Y102.089 E.00887
G1 X84.126 Y101.802 E.00975
G1 X83.907 Y101.565 E.00683
G1 X83.717 Y101.304 E.00683
G1 X83.505 Y100.895 E.00975
G1 X83.366 Y100.446 E.00995
G1 X83.311 Y99.989 E.00975
G1 X83.321 Y99.666 E.00683
G1 X83.369 Y99.347 E.00683
G1 X83.505 Y98.907 E.00975
G1 X83.721 Y98.489 E.00995
G1 X84.009 Y98.118 E.00995
G1 X84.358 Y97.803 E.00995
G1 X84.758 Y97.556 E.00995
G1 X85.187 Y97.388 E.00975
G1 X85.501 Y97.316 E.00683
G1 X85.822 Y97.282 E.00683
G1 X86.273 Y97.302 E.00955
G1 X86.59 Y97.365 E.00683
G1 X86.897 Y97.465 E.00683
G1 X87.309 Y97.671 E.00975
G1 X87.677 Y97.947 E.00975
G1 X87.904 Y98.177 E.00683
G1 X88.101 Y98.432 E.00683
G1 X88.321 Y98.826 E.00956
G1 X88.435 Y99.129 E.00683
G1 X88.511 Y99.442 E.00683
G1 X88.552 Y99.901 E.00975
G1 X88.511 Y100.36 E.00975
G1 X88.435 Y100.673 E.00683
G1 X88.321 Y100.975 E.00683
G1 X88.097 Y101.378 E.00975
G1 X87.798 Y101.741 E.00995
G1 X87.447 Y102.039 E.00975
G1 X87.173 Y102.208 E.00682
G1 X86.892 Y102.338 E.00654
G1 X86.439 Y102.473 E.01002
G1 X85.979 Y102.521 E.00978
G1 X85.657 Y102.507 E.00682
G1 X85.352 Y102.457 E.00654
G1 X84.909 Y102.315 E.00986
M204 S250
G1 X85.049 Y101.927 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X84.713 Y101.746 E.00752
G1 X84.405 Y101.501 E.00773
G1 X84.223 Y101.305 E.00526
G1 X84.066 Y101.088 E.00526
G1 X83.885 Y100.739 E.00773
G1 X83.768 Y100.361 E.0078
G1 X83.721 Y99.97 E.00773
G1 X83.729 Y99.703 E.00526
G1 X83.769 Y99.438 E.00526
G1 X83.885 Y99.062 E.00773
G1 X84.067 Y98.711 E.00779
G1 X84.31 Y98.397 E.00779
G1 X84.604 Y98.132 E.0078
G1 X84.942 Y97.924 E.0078
G1 X85.308 Y97.78 E.00773
G1 X85.568 Y97.72 E.00526
G1 X85.835 Y97.692 E.00526
G1 X86.224 Y97.71 E.00767
G1 X86.487 Y97.762 E.00526
G1 X86.741 Y97.844 E.00526
G1 X87.093 Y98.02 E.00774
G1 X87.407 Y98.256 E.00773
G1 X87.595 Y98.447 E.00526
G1 X87.759 Y98.658 E.00526
G1 X87.949 Y98.999 E.00767
G1 X88.043 Y99.249 E.00526
G1 X88.106 Y99.509 E.00526
G1 X88.141 Y99.901 E.00773
G1 X88.106 Y100.292 E.00773
G1 X88.043 Y100.552 E.00526
G1 X87.949 Y100.803 E.00526
G1 X87.757 Y101.146 E.00774
G1 X87.506 Y101.452 E.00779
G1 X87.206 Y101.707 E.00773
G1 X86.978 Y101.847 E.00526
G1 X86.747 Y101.955 E.00501
G1 X86.358 Y102.07 E.00798
G1 X85.967 Y102.111 E.00774
G1 X85.7 Y102.099 E.00525
G1 X85.448 Y102.058 E.00501
G1 X85.105 Y101.948 E.00708
; WIPE_START
M204 S6000
G1 X84.713 Y101.746 E-.08391
G1 X84.405 Y101.501 E-.0747
G1 X84.223 Y101.305 E-.05084
G1 X84.066 Y101.088 E-.05084
G1 X83.885 Y100.739 E-.07467
G1 X83.815 Y100.513 E-.04504
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X90.234 Y96.384 Z1.08 F18000
G1 X98.177 Y91.275 Z1.08
G1 Z.68
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X98.379 Y91.416 E.00522
G1 X95.332 Y95.768 E.11246
G1 X93.972 Y94.816 E.03514
G1 X93.202 Y95.636 E.02381
G1 X92.95 Y95.746 E.00582
G1 X92.994 Y95.432 E.0067
G1 X93.533 Y94.509 E.02263
G1 X92.126 Y93.524 E.03634
G1 X95.174 Y89.172 E.11245
G1 X98.128 Y91.24 E.07633
; WIPE_START
M204 S6000
G1 X98.379 Y91.416 E-.05824
G1 X97.408 Y92.803 E-.32176
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X90.025 Y94.738 Z1.08 F18000
G1 X84.751 Y96.12 Z1.08
G1 Z.68
G1 E.4 F1800
G1 F1500
M204 S500
G1 X92.469 Y96.12 E.16335
G1 X92.581 Y95.325 E.01699
M73 P40 R14
G1 X92.97 Y94.632 E.01682
G1 X91.536 Y93.628 E.03705
G1 X97.307 Y85.386 E.21296
G1 X97.521 Y85.536 E.00554
G1 X95.284 Y88.731 E.08255
G1 X98.756 Y91.162 E.08971
G1 X100.993 Y87.967 E.08255
G1 X101.207 Y88.117 E.00554
G1 X95.436 Y96.359 E.21296
G1 X94.029 Y95.374 E.03634
G1 X93.476 Y95.963 E.0171
G1 X93.186 Y96.105 E.00683
G1 X92.902 Y96.341 E.00783
G1 X92.784 Y96.404 E.00283
G1 X92.573 Y96.467 E.00465
G1 X92.404 Y96.482 E.00359
G1 X87.428 Y96.482 E.10532
G1 X88.614 Y97.845 E.03825
G1 X88.931 Y98.345 E.01254
G1 X89.089 Y98.699 E.0082
G1 X89.157 Y98.894 E.00437
G1 X89.257 Y99.3 E.00885
G1 X89.304 Y99.68 E.00811
G1 X89.289 Y100.282 E.01274
G1 X89.222 Y100.663 E.0082
G1 X89.101 Y101.072 E.00901
G1 X88.848 Y101.607 E.01253
G1 X88.621 Y101.947 E.00865
G1 X88.353 Y102.258 E.00869
G1 X87.915 Y102.637 E.01226
G1 X87.744 Y102.753 E.00438
G1 X87.399 Y102.945 E.00836
G1 X87.024 Y103.099 E.00857
G1 X86.628 Y103.208 E.00869
G1 X86.222 Y103.269 E.00869
G1 X85.63 Y103.267 E.01254
G1 X85.038 Y103.161 E.01273
G1 X84.474 Y102.951 E.01273
G1 X84.123 Y102.757 E.00849
G1 X83.797 Y102.522 E.00849
G1 X83.502 Y102.251 E.00849
G1 X83.24 Y101.947 E.00849
G1 X83.017 Y101.613 E.00849
G1 X82.762 Y101.078 E.01254
G1 X82.649 Y100.708 E.0082
G1 X82.573 Y100.289 E.009
G1 X82.551 Y99.89 E.00846
G1 X82.576 Y99.49 E.00849
G1 X82.648 Y99.095 E.00849
G1 X82.767 Y98.712 E.00849
G1 X82.93 Y98.345 E.00849
G1 X83.136 Y98 E.0085
G1 X83.372 Y97.693 E.00821
G1 X84.478 Y96.482 E.03471
G1 X79.467 Y96.482 E.10607
G1 X79.228 Y96.454 E.00508
G1 X79.029 Y96.381 E.0045
G1 X78.898 Y96.301 E.00324
G1 X78.72 Y96.119 E.00539
G1 X78.669 Y96.042 E.00195
G1 X78.579 Y95.813 E.00521
G1 X78.55 Y95.565 E.00528
G1 X78.55 Y77.619 E.37984
G1 X78.589 Y77.348 E.00579
G1 X78.692 Y77.124 E.00521
G1 X78.792 Y76.998 E.00342
G1 X78.907 Y76.895 E.00327
G1 X79.131 Y76.775 E.00537
G1 X79.381 Y76.723 E.00541
G1 X92.403 Y76.72 E.27562
G1 X92.641 Y76.749 E.00508
G1 X92.779 Y76.794 E.00306
G1 X92.955 Y76.889 E.00424
G1 X92.906 Y77.082 E.0042
G1 X79.858 Y77.082 E.27617
G1 X79.502 Y77.166 E.00775
G1 X79.265 Y77.322 E.00602
G1 X79.074 Y77.537 E.00609
G1 X78.948 Y77.807 E.00629
G1 X78.911 Y78.055 E.00532
G1 X78.911 Y95.155 E.36193
G1 X78.964 Y95.453 E.0064
G1 X79.152 Y95.778 E.00795
G1 X79.512 Y96.047 E.00951
G1 X79.867 Y96.12 E.00767
G1 X84.691 Y96.12 E.1021
; WIPE_START
M204 S6000
G1 X86.691 Y96.12 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X83.55 Y96.891 Z1.08 F18000
G1 Z.68
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X79.443 Y96.891 E.08079
G1 X79.133 Y96.855 E.00613
G1 X78.849 Y96.751 E.00595
G1 X78.658 Y96.633 E.00442
G1 X78.548 Y96.541 E.00283
G1 X78.394 Y96.368 E.00454
G1 X78.314 Y96.246 E.00288
G1 X78.245 Y96.107 E.00306
G1 X78.177 Y95.901 E.00425
G1 X78.141 Y95.589 E.00619
G1 X78.141 Y77.607 E.35368
G1 X78.149 Y77.454 E.00301
G1 X78.196 Y77.231 E.00449
G1 X78.276 Y77.027 E.00431
G1 X78.352 Y76.895 E.003
G1 X78.493 Y76.716 E.00448
G1 X78.656 Y76.57 E.00431
G1 X78.784 Y76.486 E.003
G1 X78.99 Y76.389 E.00448
G1 X79.201 Y76.332 E.00431
G1 X79.356 Y76.313 E.00306
G1 X92.427 Y76.311 E.25709
G1 X92.731 Y76.347 E.00601
G1 X92.941 Y76.417 E.00436
G1 X93.139 Y76.524 E.00442
G1 X93.315 Y76.663 E.00442
G1 X93.465 Y76.831 E.00442
G1 X93.583 Y77.022 E.00442
G1 X93.666 Y77.231 E.00442
G1 X93.71 Y77.448 E.00436
G1 X93.72 Y88.791 E.2231
G1 X92.541 Y88.791 E.02321
G1 X92.541 Y77.491 E.22226
G1 X79.906 Y77.491 E.24851
G1 X79.667 Y77.548 E.00484
G1 X79.535 Y77.634 E.00311
G1 X79.419 Y77.764 E.00342
G1 X79.344 Y77.925 E.00349
G1 X79.321 Y78.085 E.00318
G1 X79.321 Y95.119 E.33504
G1 X79.354 Y95.311 E.00383
G1 X79.464 Y95.501 E.00431
G1 X79.684 Y95.664 E.00539
G1 X79.909 Y95.711 E.00452
G1 X92.113 Y95.711 E.24004
G1 X92.182 Y95.222 E.0097
G1 X92.239 Y95.073 E.00315
G1 X92.426 Y94.751 E.00731
G1 X90.966 Y93.729 E.03507
G1 X97.206 Y84.816 E.214
G1 X101.777 Y88.017 E.10975
G1 X95.536 Y96.929 E.214
G1 X94.085 Y95.913 E.03485
G1 X93.742 Y96.278 E.00986
G1 X93.604 Y96.369 E.00325
G1 X93.403 Y96.457 E.00431
G1 X93.131 Y96.683 E.00695
G1 X92.94 Y96.785 E.00426
G1 X92.649 Y96.871 E.00596
G1 X92.421 Y96.891 E.0045
G1 X88.326 Y96.891 E.08055
G1 X88.934 Y97.59 E.01823
G1 X89.063 Y97.767 E.0043
G1 X89.295 Y98.156 E.00891
G1 X89.47 Y98.548 E.00844
G1 X89.55 Y98.778 E.00478
G1 X89.659 Y99.22 E.00896
G1 X89.713 Y99.661 E.00873
G1 X89.714 Y100.117 E.00897
G1 X89.695 Y100.335 E.00431
G1 X89.621 Y100.758 E.00844
G1 X89.486 Y101.212 E.00933
G1 X89.315 Y101.605 E.00843
G1 X89.199 Y101.819 E.00478
G1 X88.947 Y102.195 E.0089
G1 X88.652 Y102.538 E.00891
G1 X88.495 Y102.691 E.00431
G1 X88.16 Y102.965 E.0085
G1 X87.959 Y103.102 E.00479
G1 X87.582 Y103.311 E.00849
G1 X87.357 Y103.412 E.00485
G1 X87.15 Y103.489 E.00435
G1 X86.713 Y103.609 E.00892
G1 X86.265 Y103.676 E.00891
G1 X86.046 Y103.689 E.0043
G1 X85.593 Y103.675 E.00892
G1 X85.145 Y103.608 E.00891
G1 X84.929 Y103.556 E.00437
G1 X84.717 Y103.491 E.00436
G1 X84.298 Y103.321 E.00891
G1 X83.904 Y103.103 E.00885
G1 X83.539 Y102.84 E.00885
G1 X83.207 Y102.536 E.00885
G1 X82.914 Y102.195 E.00885
G1 X82.663 Y101.821 E.00885
G1 X82.457 Y101.418 E.00891
G1 X82.376 Y101.214 E.00431
G1 X82.251 Y100.804 E.00844
G1 X82.166 Y100.337 E.00933
G1 X82.141 Y99.889 E.00884
G1 X82.169 Y99.44 E.00885
G1 X82.25 Y98.997 E.00885
G1 X82.383 Y98.567 E.00885
G1 X82.566 Y98.156 E.00885
G1 X82.797 Y97.77 E.00885
G1 X83.058 Y97.429 E.00844
G1 X83.51 Y96.935 E.01316
; WIPE_START
M204 S6000
G1 X81.51 Y96.913 E-.38
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




G1 X79.376 Y96.249
G1 Z.68
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.139308
G1 F1500
M204 S6000
G1 X79.153 Y96.128 E.00144
; LINE_WIDTH: 0.148671
G1 X78.938 Y95.954 E.0017
G1 X78.778 Y95.627 E.00223
; WIPE_START
G1 X78.938 Y95.954 E-.21601
G1 X79.153 Y96.128 E-.16399
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X84.522 Y97.141 Z1.08 F18000
G1 Z.68
G1 E.4 F1800
; LINE_WIDTH: 0.471748
G1 F1500
M204 S6000
G1 X84.325 Y97.304 E.00569
; LINE_WIDTH: 0.430722
G1 X84.102 Y97.491 E.00586
; LINE_WIDTH: 0.373604
G1 X83.721 Y97.871 E.00935
M73 P41 R14
G1 X83.452 Y98.214 E.00757
; LINE_WIDTH: 0.360043
G1 X83.272 Y98.522 E.00595
G1 X83.125 Y98.846 E.00593
G1 X82.999 Y99.275 E.00746
G1 X82.955 Y99.536 E.00441
G1 X82.933 Y99.891 E.00593
G1 X82.955 Y100.244 E.0059
G1 X83.02 Y100.616 E.00629
G1 X83.179 Y101.094 E.00841
G1 X83.403 Y101.512 E.00791
G1 X83.544 Y101.715 E.00413
G1 X83.776 Y101.985 E.00594
G1 X84.04 Y102.224 E.00593
G1 X84.327 Y102.435 E.00594
G1 X84.74 Y102.653 E.00779
G1 X85.252 Y102.822 E.00898
G1 X85.628 Y102.884 E.00636
G1 X86.002 Y102.895 E.00625
G1 X86.497 Y102.846 E.0083
G1 X87.015 Y102.696 E.00899
G1 X87.342 Y102.543 E.00603
G1 X87.69 Y102.33 E.00679
G1 X88.057 Y102.016 E.00806
G1 X88.315 Y101.715 E.00663
G1 X88.517 Y101.412 E.00606
G1 X88.665 Y101.121 E.00545
G1 X88.797 Y100.775 E.00619
G1 X88.885 Y100.409 E.00627
G1 X88.926 Y99.886 E.00875
G1 X88.884 Y99.372 E.00861
G1 X88.794 Y99.007 E.00626
G1 X88.59 Y98.522 E.00878
G1 X88.42 Y98.236 E.00555
G1 X88.194 Y97.936 E.00626
G1 X87.924 Y97.645 E.00663
; LINE_WIDTH: 0.39771
G1 X87.802 Y97.532 E.00308
; LINE_WIDTH: 0.432777
G1 X87.68 Y97.419 E.00337
; LINE_WIDTH: 0.468078
G1 X87.557 Y97.304 E.00371
; LINE_WIDTH: 0.468432
G1 X87.396 Y97.34 E.00365
; LINE_WIDTH: 0.433602
G1 X87.234 Y97.375 E.00336
; WIPE_START
G1 X87.396 Y97.34 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X92.678 Y96.157 Z1.08 F18000
G1 Z.68
G1 E.4 F1800
; LINE_WIDTH: 0.123902
G1 F1500
M204 S6000
G1 X92.843 Y96.066 E.00092
; LINE_WIDTH: 0.092464
G1 X92.932 Y96.011 E.00035
; WIPE_START
G1 X92.843 Y96.066 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X93.592 Y94.875 Z1.08 F18000
G1 Z.68
G1 E.4 F1800
; LINE_WIDTH: 0.101253
G1 F1500
M204 S6000
G1 X93.735 Y94.684 E.0009
; LINE_WIDTH: 0.144262
G1 X93.878 Y94.492 E.00141
; WIPE_START
G1 X93.735 Y94.684 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X92.696 Y93.423 Z1.08 F18000
G1 Z.68
G1 E.4 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.419992
G1 F1500
M204 S6000
G1 X93.602 Y94.057 E.02174
G1 X93.758 Y93.956 E.00366
G1 X93.895 Y93.994 E.00281
G1 X94.359 Y94.34 E.01138
G1 X94.432 Y94.448 E.00256
G1 X94.396 Y94.613 E.00333
G1 X95.231 Y95.198 E.02007
G1 X97.809 Y91.517 E.0884
G1 X95.274 Y89.742 E.06087
G1 X92.731 Y93.374 E.08722
M204 S10000
G1 X93.245 Y93.327 F18000
G1 F1500
M204 S6000
G1 X93.644 Y93.605 E.00956
G1 X93.718 Y93.563 E.00167
G1 X94.131 Y93.678 E.00844
G1 X94.595 Y94.024 E.01138
G1 X94.813 Y94.347 E.00768
G1 X94.798 Y94.414 E.00134
G1 X95.134 Y94.649 E.00807
G1 X97.26 Y91.613 E.07289
G1 X95.371 Y90.291 E.04536
G1 X93.28 Y93.277 E.07171
M204 S10000
G1 X93.81 Y93.208 F18000
G1 F1500
M204 S6000
G1 X94.367 Y93.362 E.01137
G1 X94.831 Y93.708 E.01138
G1 X95.067 Y94.058 E.00831
G1 X96.711 Y91.71 E.05638
G1 X95.468 Y90.84 E.02985
G1 X93.844 Y93.159 E.05568
M204 S10000
G1 X94.437 Y93 F18000
G1 F1500
M204 S6000
G1 X94.603 Y93.046 E.00339
G1 X95.057 Y93.385 E.01115
G1 X96.162 Y91.807 E.03789
G1 X95.565 Y91.389 E.01434
G1 X94.471 Y92.951 E.03751
M204 S10000
G1 X94.974 Y92.868 F18000
; LINE_WIDTH: 0.360612
G1 F1500
M204 S6000
G1 X95.62 Y91.946 E.01881
; WIPE_START
G1 X94.974 Y92.868 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X97.7 Y85.739 Z1.08 F18000
G1 X97.786 Y85.515 Z1.08
G1 Z.68
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.096519
G1 F1500
M204 S6000
G1 X100.922 Y87.711 E.01352
; WIPE_START
G1 X99.284 Y86.564 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X92.412 Y83.243 Z1.08 F18000
G1 X79.399 Y76.955 Z1.08
G1 Z.68
G1 E.4 F1800
; LINE_WIDTH: 0.0925921
G1 F1500
M204 S6000
G1 X79.31 Y76.992 E.00032
; LINE_WIDTH: 0.139498
G1 X79.078 Y77.119 E.0015
; LINE_WIDTH: 0.152583
G1 X78.893 Y77.327 E.00176
G1 X78.84 Y77.422 E.00069
; LINE_WIDTH: 0.0996205
G1 X78.785 Y77.602 E.00069
; CHANGE_LAYER
; Z_HEIGHT: 0.8
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F1500
G1 X78.84 Y77.422 E-.38
; WIPE_END
G1 E-.02 F1800
; layer num/total_layer_count: 6/49
; update layer progress
M73 L6
M991 S0 P5 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z1.08 I-.523 J1.099 P1  F18000
G1 X100.617 Y87.791 Z1.08
G1 Z.8
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X98.655 Y90.592 E.06727
G1 X95.854 Y88.63 E.06727
G1 X96.899 Y87.137 E.03585
G1 X97.815 Y85.829 E.03142
G1 X100.568 Y87.756 E.06609
; WIPE_START
M204 S6000
G1 X99.45 Y89.414 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X95.09 Y83.149 Z1.2 F18000
G1 X93.304 Y80.581 Z1.2
G1 Z.8
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X93.311 Y88.382 E.1651
G1 X92.95 Y88.382 E.00764
G1 X92.95 Y77.128 E.23818
G1 X93.135 Y77.076 E.00407
G1 X93.216 Y77.207 E.00325
G1 X93.272 Y77.349 E.00324
G1 X93.301 Y77.49 E.00306
G1 X93.304 Y80.521 E.06416
; WIPE_START
M204 S6000
G1 X93.306 Y82.521 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X89.428 Y89.096 Z1.2 F18000
G1 X84.692 Y97.126 Z1.2
G1 Z.8
G1 E.4 F1800
G1 F1500
M204 S500
G1 X84.577 Y96.963 E.00423
G1 X84.941 Y96.544 E.01174
G1 X86.92 Y96.544 E.04188
G1 X87.266 Y96.942 E.01117
G1 X87.159 Y97.104 E.0041
G1 X86.697 Y96.953 E.01029
G1 X86.324 Y96.88 E.00804
G1 X85.81 Y96.857 E.0109
G1 X85.432 Y96.897 E.00804
G1 X85.061 Y96.981 E.00805
G1 X84.748 Y97.104 E.00712
; WIPE_START
M204 S6000
G1 X84.577 Y96.963 E-.04213
G1 X84.941 Y96.544 E-.10541
G1 X86.165 Y96.544 E-.23245
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X84.855 Y102.287 Z1.2 F18000
G1 Z.8
G1 E.4 F1800
G1 F1500
M204 S500
G1 X84.486 Y102.089 E.00886
G1 X84.119 Y101.796 E.00995
G1 X83.816 Y101.449 E.00975
G1 X83.642 Y101.178 E.00682
G1 X83.509 Y100.902 E.00649
G1 X83.366 Y100.447 E.01007
G1 X83.31 Y99.979 E.00998
G1 X83.338 Y99.51 E.00995
G1 X83.449 Y99.054 E.00994
G1 X83.637 Y98.633 E.00976
G1 X83.811 Y98.361 E.00683
G1 X84.016 Y98.111 E.00682
G1 X84.358 Y97.803 E.00975
G1 X84.758 Y97.556 E.00995
G1 X85.187 Y97.388 E.00975
G1 X85.501 Y97.316 E.00683
G1 X85.822 Y97.282 E.00683
G1 X86.273 Y97.302 E.00955
G1 X86.59 Y97.365 E.00683
G1 X86.897 Y97.465 E.00683
G1 X87.309 Y97.671 E.00976
G1 X87.685 Y97.953 E.00994
G1 X87.998 Y98.29 E.00975
G1 X88.18 Y98.557 E.00683
G1 X88.324 Y98.835 E.00664
G1 X88.434 Y99.128 E.00662
G1 X88.508 Y99.426 E.00648
G1 X88.553 Y99.901 E.01011
G1 X88.508 Y100.376 E.01011
G1 X88.434 Y100.674 E.00648
G1 X88.321 Y100.975 E.00682
G1 X88.097 Y101.378 E.00975
G1 X87.798 Y101.741 E.00995
G1 X87.447 Y102.039 E.00975
G1 X87.173 Y102.208 E.00682
G1 X86.895 Y102.337 E.00649
G1 X86.439 Y102.473 E.01007
G1 X85.979 Y102.521 E.00979
G1 X85.657 Y102.507 E.00681
G1 X85.355 Y102.457 E.00649
G1 X84.908 Y102.314 E.00993
M204 S250
G1 X85.049 Y101.927 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X84.713 Y101.746 E.00751
G1 X84.403 Y101.499 E.0078
G1 X84.144 Y101.203 E.00773
G1 X84 Y100.978 E.00526
G1 X83.89 Y100.75 E.00496
G1 X83.768 Y100.361 E.00803
G1 X83.721 Y99.967 E.00781
G1 X83.744 Y99.571 E.0078
G1 X83.838 Y99.186 E.00779
G1 X83.998 Y98.827 E.00774
G1 X84.142 Y98.602 E.00526
G1 X84.312 Y98.395 E.00526
G1 X84.604 Y98.132 E.00773
G1 X84.942 Y97.924 E.0078
G1 X85.308 Y97.78 E.00773
G1 X85.568 Y97.72 E.00526
G1 X85.835 Y97.692 E.00526
G1 X86.224 Y97.71 E.00767
G1 X86.487 Y97.762 E.00526
G1 X86.741 Y97.844 E.00526
G1 X87.093 Y98.02 E.00774
G1 X87.41 Y98.258 E.00779
G1 X87.677 Y98.546 E.00774
G1 X87.828 Y98.767 E.00526
G1 X87.95 Y99.002 E.0052
G1 X88.043 Y99.249 E.0052
G1 X88.103 Y99.494 E.00496
G1 X88.142 Y99.901 E.00804
G1 X88.103 Y100.308 E.00804
G1 X88.043 Y100.553 E.00496
G1 X87.949 Y100.803 E.00526
G1 X87.757 Y101.146 E.00774
G1 X87.506 Y101.452 E.0078
G1 X87.206 Y101.707 E.00773
G1 X86.978 Y101.847 E.00526
G1 X86.749 Y101.954 E.00496
G1 X86.358 Y102.07 E.00803
G1 X85.967 Y102.111 E.00775
G1 X85.7 Y102.099 E.00525
G1 X85.451 Y102.058 E.00496
G1 X85.105 Y101.948 E.00714
; WIPE_START
M204 S6000
G1 X84.713 Y101.746 E-.08381
G1 X84.403 Y101.499 E-.0753
G1 X84.144 Y101.203 E-.07469
G1 X84 Y100.978 E-.05079
G1 X83.89 Y100.75 E-.04795
G1 X83.815 Y100.512 E-.04746
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X90.235 Y96.383 Z1.2 F18000
G1 X98.177 Y91.275 Z1.2
G1 Z.8
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X98.379 Y91.416 E.00522
G1 X95.332 Y95.768 E.11246
G1 X93.972 Y94.816 E.03514
G1 X93.202 Y95.636 E.0238
G1 X92.95 Y95.746 E.00582
G1 X92.994 Y95.432 E.00671
G1 X93.533 Y94.509 E.02263
G1 X92.126 Y93.524 E.03635
G1 X95.174 Y89.172 E.11246
G1 X98.128 Y91.24 E.07633
; WIPE_START
M204 S6000
G1 X98.379 Y91.416 E-.05824
G1 X97.408 Y92.803 E-.32176
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X90.023 Y94.73 Z1.2 F18000
G1 X84.691 Y96.12 Z1.2
G1 Z.8
G1 E.4 F1800
G1 F1500
M204 S500
G1 X92.469 Y96.12 E.16461
G1 X92.581 Y95.325 E.017
G1 X92.97 Y94.632 E.01681
G1 X91.536 Y93.628 E.03706
G1 X97.307 Y85.386 E.21296
G1 X97.521 Y85.536 E.00554
G1 X95.284 Y88.731 E.08255
G1 X98.756 Y91.162 E.08971
G1 X100.993 Y87.967 E.08255
G1 X101.207 Y88.117 E.00554
G1 X95.436 Y96.359 E.21296
G1 X94.029 Y95.374 E.03634
G1 X93.476 Y95.963 E.0171
G1 X93.186 Y96.105 E.00684
G1 X92.902 Y96.341 E.00783
G1 X92.784 Y96.404 E.00283
G1 X92.573 Y96.467 E.00466
G1 X92.404 Y96.482 E.00359
G1 X87.428 Y96.482 E.10532
G1 X88.614 Y97.845 E.03825
G1 X88.721 Y97.993 E.00386
G1 X88.935 Y98.353 E.00888
G1 X89.159 Y98.901 E.01254
G1 X89.286 Y99.49 E.01273
G1 X89.305 Y100.091 E.01273
G1 X89.259 Y100.49 E.0085
G1 X89.105 Y101.063 E.01257
G1 X88.845 Y101.614 E.01289
G1 X88.494 Y102.103 E.01273
G1 X88.215 Y102.392 E.0085
G1 X87.918 Y102.634 E.00811
G1 X87.744 Y102.753 E.00447
G1 X87.379 Y102.955 E.00884
G1 X87.024 Y103.099 E.00811
G1 X86.628 Y103.208 E.00869
G1 X86.222 Y103.269 E.00869
G1 X85.63 Y103.267 E.01254
G1 X85.037 Y103.161 E.01274
G1 X84.499 Y102.962 E.01215
G1 X84.122 Y102.756 E.0091
G1 X83.797 Y102.522 E.00846
G1 X83.502 Y102.251 E.0085
G1 X83.24 Y101.947 E.00849
G1 X83.017 Y101.613 E.0085
G1 X82.831 Y101.25 E.00864
G1 X82.643 Y100.686 E.01257
G1 X82.573 Y100.291 E.00851
G1 X82.551 Y99.89 E.00849
G1 X82.576 Y99.491 E.00846
G1 X82.656 Y99.069 E.0091
G1 X82.839 Y98.534 E.01196
G1 X83.028 Y98.17 E.00869
G1 X83.254 Y97.838 E.0085
G1 X84.433 Y96.482 E.03804
G1 X79.467 Y96.482 E.10513
G1 X79.228 Y96.454 E.00508
G1 X78.955 Y96.34 E.00627
G1 X78.763 Y96.173 E.00539
G1 X78.665 Y96.033 E.00362
G1 X78.579 Y95.812 E.00501
G1 X78.55 Y95.565 E.00527
G1 X78.55 Y77.628 E.37965
G1 X78.586 Y77.357 E.00579
G1 X78.696 Y77.116 E.0056
G1 X78.866 Y76.928 E.00536
G1 X78.991 Y76.84 E.00324
G1 X79.131 Y76.775 E.00326
G1 X79.381 Y76.723 E.00541
G1 X92.404 Y76.72 E.27565
G1 X92.641 Y76.749 E.00504
G1 X92.779 Y76.794 E.00307
G1 X92.955 Y76.889 E.00424
G1 X92.906 Y77.082 E.0042
G1 X79.857 Y77.082 E.2762
G1 X79.488 Y77.171 E.00803
G1 X79.234 Y77.35 E.0066
G1 X79.07 Y77.545 E.0054
G1 X78.948 Y77.807 E.0061
G1 X78.911 Y78.056 E.00533
G1 X78.911 Y95.155 E.36192
G1 X78.964 Y95.453 E.0064
G1 X79.152 Y95.778 E.00796
G1 X79.512 Y96.047 E.00951
G1 X79.867 Y96.12 E.00768
G1 X84.631 Y96.12 E.10084
; WIPE_START
M204 S6000
G1 X86.631 Y96.12 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X83.535 Y96.891 Z1.2 F18000
G1 Z.8
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X79.443 Y96.891 E.08049
G1 X79.133 Y96.855 E.00613
G1 X78.847 Y96.75 E.006
G1 X78.724 Y96.68 E.00277
G1 X78.543 Y96.537 E.00454
G1 X78.445 Y96.432 E.00283
G1 X78.312 Y96.243 E.00454
G1 X78.248 Y96.114 E.00283
G1 X78.177 Y95.901 E.00442
M73 P42 R14
G1 X78.141 Y95.589 E.00619
G1 X78.141 Y77.61 E.35362
G1 X78.161 Y77.374 E.00466
G1 X78.194 Y77.234 E.00283
G1 X78.275 Y77.028 E.00434
G1 X78.353 Y76.892 E.00309
G1 X78.441 Y76.774 E.00288
G1 X78.602 Y76.613 E.00448
G1 X78.786 Y76.484 E.00442
G1 X78.99 Y76.389 E.00443
G1 X79.2 Y76.332 E.00428
G1 X79.356 Y76.313 E.0031
G1 X92.429 Y76.311 E.25713
G1 X92.731 Y76.347 E.00598
G1 X92.941 Y76.417 E.00437
G1 X93.139 Y76.524 E.00442
G1 X93.315 Y76.663 E.00442
G1 X93.465 Y76.831 E.00442
G1 X93.583 Y77.022 E.00442
G1 X93.666 Y77.231 E.00442
G1 X93.71 Y77.448 E.00436
G1 X93.72 Y88.791 E.2231
G1 X92.541 Y88.791 E.02321
G1 X92.541 Y77.491 E.22226
G1 X79.906 Y77.491 E.24852
G1 X79.66 Y77.55 E.00497
G1 X79.513 Y77.654 E.00355
G1 X79.418 Y77.767 E.00291
G1 X79.344 Y77.925 E.00343
G1 X79.321 Y78.086 E.00319
G1 X79.321 Y95.119 E.33504
G1 X79.354 Y95.311 E.00382
G1 X79.464 Y95.501 E.00431
G1 X79.684 Y95.664 E.00539
G1 X79.909 Y95.711 E.00453
G1 X92.113 Y95.711 E.24004
G1 X92.182 Y95.222 E.00971
G1 X92.239 Y95.072 E.00316
G1 X92.426 Y94.751 E.0073
G1 X90.966 Y93.729 E.03507
G1 X97.206 Y84.816 E.214
G1 X101.777 Y88.017 E.10975
G1 X95.536 Y96.929 E.214
G1 X94.085 Y95.913 E.03485
G1 X93.742 Y96.278 E.00985
G1 X93.604 Y96.369 E.00326
G1 X93.403 Y96.457 E.00431
G1 X93.131 Y96.683 E.00696
G1 X92.94 Y96.785 E.00426
G1 X92.649 Y96.871 E.00596
G1 X92.421 Y96.891 E.0045
G1 X88.326 Y96.891 E.08055
G1 X88.934 Y97.59 E.01823
G1 X89.063 Y97.767 E.0043
G1 X89.296 Y98.159 E.00897
G1 X89.391 Y98.356 E.00431
G1 X89.551 Y98.78 E.00891
G1 X89.659 Y99.22 E.00891
G1 X89.713 Y99.661 E.00873
G1 X89.714 Y100.114 E.00891
G1 X89.662 Y100.561 E.00885
G1 X89.565 Y100.974 E.00835
G1 X89.487 Y101.209 E.00487
G1 X89.305 Y101.627 E.00896
G1 X89.08 Y102.009 E.00872
G1 X88.806 Y102.37 E.00892
G1 X88.493 Y102.693 E.00885
G1 X88.164 Y102.962 E.00835
G1 X87.959 Y103.102 E.00488
G1 X87.561 Y103.322 E.00895
G1 X87.358 Y103.412 E.00437
G1 X87.15 Y103.489 E.00437
G1 X86.713 Y103.609 E.00891
G1 X86.265 Y103.676 E.00891
G1 X86.046 Y103.689 E.00431
G1 X85.593 Y103.675 E.00891
G1 X85.145 Y103.608 E.00891
G1 X84.929 Y103.556 E.00437
G1 X84.717 Y103.491 E.00437
G1 X84.324 Y103.332 E.00835
G1 X83.903 Y103.103 E.00942
G1 X83.539 Y102.84 E.00884
G1 X83.207 Y102.536 E.00885
G1 X82.914 Y102.195 E.00885
G1 X82.663 Y101.821 E.00885
G1 X82.458 Y101.418 E.00889
G1 X82.367 Y101.188 E.00488
G1 X82.245 Y100.781 E.00835
G1 X82.166 Y100.338 E.00885
G1 X82.141 Y99.889 E.00885
G1 X82.169 Y99.44 E.00884
G1 X82.258 Y98.97 E.00942
G1 X82.384 Y98.564 E.00835
G1 X82.467 Y98.362 E.0043
G1 X82.676 Y97.96 E.00891
G1 X82.929 Y97.588 E.00885
G1 X83.496 Y96.936 E.01698
; WIPE_START
M204 S6000
G1 X81.496 Y96.914 E-.38
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




G1 X79.376 Y96.249
G1 Z.8
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.144842
G1 F1500
M204 S6000
G1 X79.143 Y96.123 E.00157
G1 X78.956 Y95.967 E.00145
G1 X78.878 Y95.849 E.00085
G1 X78.778 Y95.627 E.00145
; WIPE_START
G1 X78.878 Y95.849 E-.10356
G1 X78.956 Y95.967 E-.06056
G1 X79.143 Y96.123 E-.10355
G1 X79.376 Y96.249 E-.11234
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X84.466 Y97.174 Z1.2 F18000
G1 Z.8
G1 E.4 F1800
; LINE_WIDTH: 0.473072
G1 F1500
M204 S6000
G1 X84.296 Y97.318 E.00499
; LINE_WIDTH: 0.438165
G1 X84.099 Y97.487 E.00533
; LINE_WIDTH: 0.402167
G1 X83.925 Y97.664 E.00466
; LINE_WIDTH: 0.360589
G1 X83.556 Y98.071 E.00917
G1 X83.357 Y98.363 E.00591
G1 X83.128 Y98.838 E.0088
G1 X83.028 Y99.162 E.00566
G1 X82.955 Y99.539 E.00642
G1 X82.934 Y100.005 E.0078
G1 X83.001 Y100.542 E.00903
G1 X83.162 Y101.052 E.00894
G1 X83.345 Y101.42 E.00687
G1 X83.544 Y101.716 E.00595
G1 X83.869 Y102.078 E.00813
G1 X84.291 Y102.412 E.00898
G1 X84.74 Y102.653 E.00853
G1 X85.254 Y102.823 E.00904
G1 X85.628 Y102.884 E.00632
G1 X85.978 Y102.895 E.00585
G1 X86.498 Y102.846 E.00872
G1 X86.904 Y102.735 E.00703
G1 X87.343 Y102.544 E.008
G1 X87.68 Y102.338 E.0066
G1 X88.076 Y101.994 E.00877
G1 X88.397 Y101.6 E.00849
G1 X88.513 Y101.419 E.0036
G1 X88.746 Y100.929 E.00906
G1 X88.883 Y100.427 E.00868
G1 X88.929 Y99.916 E.00857
G1 X88.884 Y99.372 E.00913
G1 X88.799 Y99.025 E.00595
G1 X88.665 Y98.667 E.0064
G1 X88.496 Y98.357 E.0059
G1 X88.302 Y98.064 E.00587
G1 X87.933 Y97.654 E.00922
; LINE_WIDTH: 0.395478
G1 X87.808 Y97.538 E.00314
; LINE_WIDTH: 0.431419
G1 X87.683 Y97.422 E.00345
; LINE_WIDTH: 0.467617
G1 X87.557 Y97.304 E.00381
; LINE_WIDTH: 0.468565
G1 X87.395 Y97.34 E.00365
; LINE_WIDTH: 0.433944
G1 X87.234 Y97.375 E.00337
; WIPE_START
G1 X87.395 Y97.34 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X92.678 Y96.157 Z1.2 F18000
G1 Z.8
G1 E.4 F1800
; LINE_WIDTH: 0.124041
G1 F1500
M204 S6000
G1 X92.843 Y96.066 E.00093
; LINE_WIDTH: 0.0924973
G1 X92.932 Y96.011 E.00035
; WIPE_START
G1 X92.843 Y96.066 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X93.593 Y94.874 Z1.2 F18000
G1 Z.8
G1 E.4 F1800
; LINE_WIDTH: 0.10115
G1 F1500
M204 S6000
G1 X93.736 Y94.683 E.0009
; LINE_WIDTH: 0.143968
G1 X93.879 Y94.492 E.00141
; WIPE_START
G1 X93.736 Y94.683 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X96.018 Y94.156 Z1.2 F18000
G1 Z.8
G1 E.4 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F1500
M204 S6000
G1 X96.991 Y92.766 E.03592
G1 X96.939 Y92.731 E.00133
G1 X96.505 Y92.276 E.01331
G1 X96.224 Y91.821 E.01132
G1 X95.907 Y90.91 E.0204
G1 X95.877 Y90.455 E.00966
G1 X96.027 Y90.212 E.00604
G1 X95.263 Y89.677 E.01974
G1 X94.825 Y90.303 E.01618
; WIPE_START
G1 X95.263 Y89.677 E-.14523
G1 X96.027 Y90.212 E-.17719
G1 X95.877 Y90.455 E-.05426
G1 X95.878 Y90.473 E-.00331
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X97.786 Y85.515 Z1.2 F18000
G1 Z.8
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.096525
G1 F1500
M204 S6000
G1 X100.922 Y87.711 E.01352
; WIPE_START
G1 X99.284 Y86.564 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X92.411 Y83.244 Z1.2 F18000
G1 X79.361 Y76.941 Z1.2
G1 Z.8
G1 E.4 F1800
; LINE_WIDTH: 0.149878
G1 F1500
M204 S6000
G1 X79.044 Y77.144 E.00234
G1 X78.894 Y77.327 E.00146
G1 X78.835 Y77.433 E.00075
; LINE_WIDTH: 0.0999692
G1 X78.788 Y77.595 E.00062
; CHANGE_LAYER
; Z_HEIGHT: 0.92
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F1500
G1 X78.835 Y77.433 E-.38
; WIPE_END
G1 E-.02 F1800
; layer num/total_layer_count: 7/49
; update layer progress
M73 L7
M991 S0 P6 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z1.2 I-.523 J1.099 P1  F18000
G1 X100.617 Y87.791 Z1.2
G1 Z.92
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X98.655 Y90.592 E.06727
G1 X95.854 Y88.63 E.06727
G1 X96.77 Y87.322 E.03142
G1 X97.815 Y85.829 E.03585
G1 X100.568 Y87.756 E.06609
; WIPE_START
M204 S6000
G1 X99.45 Y89.414 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X95.09 Y83.149 Z1.32 F18000
G1 X93.304 Y80.581 Z1.32
G1 Z.92
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X93.311 Y88.382 E.1651
G1 X92.95 Y88.382 E.00764
G1 X92.95 Y77.128 E.23818
G1 X93.135 Y77.076 E.00407
G1 X93.216 Y77.207 E.00325
G1 X93.272 Y77.349 E.00324
G1 X93.301 Y77.49 E.00306
G1 X93.304 Y80.521 E.06415
; WIPE_START
M204 S6000
G1 X93.306 Y82.521 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X89.428 Y89.096 Z1.32 F18000
G1 X84.692 Y97.126 Z1.32
G1 Z.92
G1 E.4 F1800
G1 F1500
M204 S500
G1 X84.577 Y96.963 E.00423
G1 X84.941 Y96.544 E.01174
G1 X86.853 Y96.544 E.04046
G1 X87.196 Y96.916 E.01069
G1 X87.09 Y97.081 E.00416
G1 X86.697 Y96.954 E.00874
G1 X86.324 Y96.88 E.00805
G1 X85.81 Y96.857 E.0109
G1 X85.432 Y96.897 E.00804
G1 X85.061 Y96.981 E.00804
G1 X84.748 Y97.104 E.00712
; WIPE_START
M204 S6000
G1 X84.577 Y96.963 E-.04213
G1 X84.941 Y96.544 E-.10541
G1 X86.165 Y96.544 E-.23246
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X84.855 Y102.287 Z1.32 F18000
G1 Z.92
G1 E.4 F1800
M73 P43 R14
G1 F1500
M204 S500
G1 X84.486 Y102.089 E.00885
G1 X84.119 Y101.796 E.00995
G1 X83.816 Y101.449 E.00975
G1 X83.642 Y101.177 E.00682
G1 X83.51 Y100.904 E.00643
G1 X83.366 Y100.448 E.01013
G1 X83.31 Y99.979 E.00998
G1 X83.338 Y99.519 E.00975
G1 X83.405 Y99.204 E.00682
G1 X83.502 Y98.917 E.00643
G1 X83.72 Y98.491 E.01013
G1 X84.01 Y98.116 E.01002
G1 X84.374 Y97.792 E.01033
G1 X84.759 Y97.556 E.00955
G1 X85.187 Y97.388 E.00973
G1 X85.501 Y97.316 E.00683
G1 X85.822 Y97.282 E.00683
G1 X86.273 Y97.302 E.00955
G1 X86.59 Y97.365 E.00684
G1 X86.897 Y97.464 E.00682
G1 X87.301 Y97.667 E.00956
G1 X87.564 Y97.852 E.00683
G1 X87.804 Y98.068 E.00683
G1 X88.098 Y98.425 E.00979
G1 X88.329 Y98.845 E.01013
G1 X88.435 Y99.129 E.00643
G1 X88.511 Y99.442 E.00681
G1 X88.552 Y99.903 E.00979
G1 X88.507 Y100.379 E.01013
G1 X88.434 Y100.674 E.00643
G1 X88.321 Y100.975 E.00682
G1 X88.097 Y101.378 E.00975
G1 X87.798 Y101.741 E.00995
G1 X87.447 Y102.039 E.00975
G1 X87.173 Y102.208 E.00681
G1 X86.897 Y102.336 E.00643
G1 X86.439 Y102.473 E.01013
G1 X85.979 Y102.521 E.00979
G1 X85.657 Y102.507 E.00683
G1 X85.338 Y102.454 E.00683
G1 X84.908 Y102.314 E.00958
M204 S250
G1 X85.048 Y101.927 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X84.713 Y101.746 E.0075
G1 X84.403 Y101.499 E.0078
G1 X84.144 Y101.203 E.00773
G1 X84 Y100.977 E.00526
G1 X83.891 Y100.753 E.00491
G1 X83.768 Y100.361 E.00807
G1 X83.721 Y99.967 E.00781
G1 X83.744 Y99.575 E.00773
G1 X83.8 Y99.313 E.00526
G1 X83.88 Y99.076 E.00491
G1 X84.067 Y98.711 E.00807
G1 X84.31 Y98.397 E.00782
G1 X84.619 Y98.122 E.00814
G1 X84.942 Y97.923 E.00745
G1 X85.308 Y97.78 E.00773
G1 X85.568 Y97.72 E.00526
G1 X85.835 Y97.692 E.00526
G1 X86.224 Y97.71 E.00767
G1 X86.487 Y97.762 E.00527
G1 X86.741 Y97.844 E.00526
G1 X87.09 Y98.019 E.00768
G1 X87.309 Y98.173 E.00526
G1 X87.508 Y98.352 E.00526
G1 X87.758 Y98.656 E.00775
G1 X87.956 Y99.016 E.00807
G1 X88.043 Y99.25 E.00491
G1 X88.106 Y99.509 E.00526
G1 X88.141 Y99.901 E.00774
G1 X88.102 Y100.31 E.00807
G1 X88.043 Y100.553 E.00491
G1 X87.949 Y100.803 E.00526
G1 X87.757 Y101.146 E.00774
G1 X87.506 Y101.452 E.0078
G1 X87.206 Y101.707 E.00773
G1 X86.978 Y101.847 E.00526
G1 X86.752 Y101.953 E.00491
G1 X86.358 Y102.07 E.00807
G1 X85.967 Y102.111 E.00775
G1 X85.7 Y102.099 E.00526
G1 X85.436 Y102.055 E.00527
G1 X85.104 Y101.948 E.00685
; WIPE_START
M204 S6000
G1 X84.713 Y101.746 E-.08372
G1 X84.403 Y101.499 E-.07533
G1 X84.144 Y101.203 E-.0747
G1 X84 Y100.977 E-.0508
G1 X83.891 Y100.753 E-.04746
G1 X83.815 Y100.512 E-.048
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X90.235 Y96.383 Z1.32 F18000
G1 X98.177 Y91.275 Z1.32
G1 Z.92
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X98.379 Y91.416 E.00522
G1 X95.332 Y95.768 E.11245
G1 X93.972 Y94.816 E.03514
G1 X93.202 Y95.636 E.0238
G1 X92.95 Y95.746 E.00582
G1 X92.994 Y95.433 E.00669
G1 X93.53 Y94.507 E.02265
G1 X92.126 Y93.524 E.03627
G1 X95.174 Y89.172 E.11245
G1 X98.128 Y91.24 E.07633
; WIPE_START
M204 S6000
G1 X98.379 Y91.416 E-.05824
G1 X97.408 Y92.803 E-.32176
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X90.022 Y94.73 Z1.32 F18000
G1 X84.691 Y96.12 Z1.32
G1 Z.92
G1 E.4 F1800
G1 F1500
M204 S500
G1 X92.469 Y96.12 E.16461
G1 X92.581 Y95.323 E.01704
G1 X92.968 Y94.631 E.01678
G1 X91.536 Y93.628 E.03701
G1 X97.307 Y85.386 E.21296
G1 X97.521 Y85.536 E.00554
G1 X95.284 Y88.731 E.08255
G1 X98.756 Y91.162 E.08971
G1 X100.993 Y87.967 E.08255
G1 X101.207 Y88.117 E.00554
G1 X95.436 Y96.359 E.21296
G1 X94.029 Y95.374 E.03634
G1 X93.476 Y95.963 E.0171
G1 X93.186 Y96.105 E.00684
G1 X92.909 Y96.336 E.00763
G1 X92.72 Y96.43 E.00446
G1 X92.582 Y96.466 E.00303
G1 X92.404 Y96.482 E.00378
G1 X87.372 Y96.482 E.10649
G1 X88.475 Y97.675 E.03439
G1 X88.731 Y98.008 E.00888
G1 X89.004 Y98.497 E.01187
G1 X89.16 Y98.903 E.0092
G1 X89.286 Y99.49 E.0127
G1 X89.305 Y100.1 E.01292
G1 X89.224 Y100.655 E.01187
G1 X89.101 Y101.072 E.00921
G1 X88.844 Y101.616 E.01273
G1 X88.514 Y102.078 E.01202
G1 X88.214 Y102.392 E.0092
G1 X87.897 Y102.65 E.00865
G1 X87.406 Y102.941 E.01207
G1 X87.209 Y103.03 E.00458
G1 X86.844 Y103.154 E.00816
G1 X86.635 Y103.207 E.00456
G1 X86.222 Y103.269 E.00883
G1 X85.623 Y103.267 E.01269
G1 X85.03 Y103.159 E.01277
G1 X84.503 Y102.963 E.01188
G1 X84.122 Y102.755 E.0092
G1 X83.797 Y102.522 E.00845
G1 X83.502 Y102.251 E.00849
G1 X83.24 Y101.947 E.00849
G1 X83.017 Y101.613 E.00849
G1 X82.834 Y101.256 E.0085
G1 X82.696 Y100.879 E.00849
G1 X82.602 Y100.489 E.0085
G1 X82.556 Y100.091 E.00849
G1 X82.574 Y99.499 E.01254
G1 X82.648 Y99.095 E.00869
G1 X82.77 Y98.703 E.00869
G1 X83.013 Y98.197 E.01187
G1 X83.255 Y97.836 E.0092
G1 X84.434 Y96.482 E.03801
G1 X79.467 Y96.482 E.10513
G1 X79.23 Y96.454 E.00504
G1 X79.02 Y96.376 E.00474
G1 X78.899 Y96.301 E.00301
G1 X78.757 Y96.165 E.00417
M73 P43 R13
G1 X78.666 Y96.035 E.00336
G1 X78.579 Y95.813 E.00505
G1 X78.55 Y95.565 E.00529
G1 X78.55 Y77.628 E.37964
G1 X78.586 Y77.357 E.00578
G1 X78.646 Y77.207 E.00343
G1 X78.731 Y77.069 E.00343
G1 X78.913 Y76.89 E.00539
G1 X79.13 Y76.775 E.0052
G1 X79.38 Y76.723 E.0054
G1 X92.406 Y76.72 E.27572
G1 X92.641 Y76.749 E.005
G1 X92.779 Y76.794 E.00307
G1 X92.955 Y76.889 E.00424
G1 X92.906 Y77.082 E.0042
G1 X79.857 Y77.082 E.2762
G1 X79.488 Y77.171 E.00804
G1 X79.233 Y77.35 E.00659
G1 X79.07 Y77.545 E.00539
G1 X78.948 Y77.807 E.0061
G1 X78.911 Y78.056 E.00533
G1 X78.911 Y95.155 E.36192
G1 X78.964 Y95.453 E.0064
G1 X79.152 Y95.778 E.00796
G1 X79.512 Y96.047 E.00952
G1 X79.867 Y96.12 E.00767
G1 X84.631 Y96.12 E.10083
; WIPE_START
M204 S6000
G1 X86.631 Y96.12 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X83.535 Y96.891 Z1.32 F18000
G1 Z.92
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X79.443 Y96.891 E.08049
G1 X79.134 Y96.855 E.00612
G1 X78.839 Y96.746 E.00618
G1 X78.658 Y96.634 E.00418
G1 X78.546 Y96.539 E.00288
G1 X78.438 Y96.423 E.00313
G1 X78.313 Y96.244 E.00429
G1 X78.243 Y96.104 E.00308
G1 X78.177 Y95.902 E.00419
G1 X78.141 Y95.589 E.0062
G1 X78.141 Y77.61 E.35362
G1 X78.161 Y77.374 E.00466
G1 X78.194 Y77.234 E.00283
G1 X78.278 Y77.022 E.00448
G1 X78.398 Y76.828 E.00448
G1 X78.491 Y76.718 E.00283
G1 X78.663 Y76.565 E.00454
G1 X78.783 Y76.486 E.00283
G1 X78.99 Y76.389 E.00448
G1 X79.21 Y76.33 E.00448
G1 X79.356 Y76.313 E.00289
G1 X92.43 Y76.311 E.25717
G1 X92.73 Y76.347 E.00594
G1 X92.941 Y76.417 E.00437
G1 X93.139 Y76.524 E.00442
G1 X93.315 Y76.663 E.00442
G1 X93.465 Y76.831 E.00442
G1 X93.583 Y77.022 E.00442
G1 X93.666 Y77.231 E.00442
G1 X93.71 Y77.448 E.00436
G1 X93.72 Y88.791 E.2231
G1 X92.541 Y88.791 E.02321
G1 X92.541 Y77.491 E.22226
G1 X79.906 Y77.491 E.24852
G1 X79.66 Y77.55 E.00497
G1 X79.513 Y77.654 E.00354
G1 X79.418 Y77.767 E.00291
G1 X79.344 Y77.925 E.00343
G1 X79.321 Y78.085 E.00319
G1 X79.321 Y95.119 E.33504
G1 X79.354 Y95.31 E.00382
G1 X79.464 Y95.501 E.00432
G1 X79.684 Y95.664 E.0054
G1 X79.909 Y95.711 E.00452
G1 X92.113 Y95.711 E.24004
G1 X92.182 Y95.221 E.00973
G1 X92.235 Y95.08 E.00297
G1 X92.426 Y94.751 E.00748
G1 X90.966 Y93.729 E.03506
G1 X97.206 Y84.816 E.214
G1 X101.777 Y88.017 E.10975
G1 X95.536 Y96.929 E.214
G1 X94.085 Y95.913 E.03485
G1 X93.742 Y96.278 E.00985
G1 X93.604 Y96.369 E.00325
G1 X93.403 Y96.457 E.00432
G1 X93.133 Y96.681 E.00689
G1 X92.865 Y96.814 E.0059
G1 X92.652 Y96.871 E.00432
G1 X92.421 Y96.891 E.00456
G1 X88.307 Y96.891 E.08092
G1 X88.788 Y97.411 E.01393
G1 X89.066 Y97.772 E.00897
G1 X89.184 Y97.957 E.00431
G1 X89.378 Y98.329 E.00825
G1 X89.551 Y98.781 E.00951
G1 X89.659 Y99.22 E.0089
G1 X89.713 Y99.661 E.00873
G1 X89.714 Y100.117 E.00897
G1 X89.695 Y100.335 E.00431
G1 X89.623 Y100.748 E.00825
G1 X89.486 Y101.212 E.00952
G1 X89.319 Y101.597 E.00825
G1 X89.08 Y102.009 E.00938
G1 X88.827 Y102.344 E.00825
G1 X88.492 Y102.694 E.00952
G1 X88.141 Y102.979 E.0089
G1 X87.96 Y103.102 E.00431
G1 X87.59 Y103.307 E.00832
G1 X87.36 Y103.411 E.00498
M73 P44 R13
G1 X86.96 Y103.547 E.0083
G1 X86.715 Y103.609 E.00497
G1 X86.265 Y103.676 E.00895
G1 X86.046 Y103.689 E.00431
G1 X85.591 Y103.675 E.00896
G1 X85.34 Y103.644 E.00497
G1 X84.927 Y103.555 E.00832
G1 X84.717 Y103.491 E.00431
G1 X84.328 Y103.334 E.00825
G1 X83.903 Y103.103 E.00951
G1 X83.539 Y102.84 E.00884
G1 X83.207 Y102.536 E.00885
G1 X82.914 Y102.195 E.00885
G1 X82.663 Y101.821 E.00885
G1 X82.459 Y101.42 E.00885
G1 X82.303 Y100.998 E.00885
G1 X82.199 Y100.56 E.00885
G1 X82.147 Y100.114 E.00885
G1 X82.148 Y99.661 E.00891
G1 X82.169 Y99.443 E.0043
G1 X82.25 Y98.997 E.00891
G1 X82.384 Y98.564 E.00891
G1 X82.467 Y98.362 E.00431
G1 X82.66 Y97.989 E.00825
G1 X82.929 Y97.587 E.00951
G1 X83.496 Y96.936 E.01697
; WIPE_START
M204 S6000
G1 X81.496 Y96.914 E-.38
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




G1 X79.376 Y96.249
G1 Z.92
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.139335
G1 F1500
M204 S6000
G1 X79.145 Y96.124 E.00149
; LINE_WIDTH: 0.145791
G1 X79.025 Y96.037 E.00089
G1 X78.943 Y95.949 E.00072
G1 X78.874 Y95.841 E.00077
G1 X78.778 Y95.626 E.00141
; WIPE_START
G1 X78.874 Y95.841 E-.14123
G1 X78.943 Y95.949 E-.07737
G1 X79.025 Y96.037 E-.07229
G1 X79.145 Y96.124 E-.0891
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X84.466 Y97.174 Z1.32 F18000
G1 Z.92
G1 E.4 F1800
; LINE_WIDTH: 0.473937
G1 F1500
M204 S6000
G1 X84.304 Y97.311 E.00476
; LINE_WIDTH: 0.442002
G1 X84.115 Y97.473 E.00516
; LINE_WIDTH: 0.40556
G1 X83.93 Y97.66 E.005
; LINE_WIDTH: 0.360317
G1 X83.724 Y97.871 E.00491
G1 X83.395 Y98.302 E.00906
G1 X83.15 Y98.781 E.00897
G1 X83.019 Y99.186 E.0071
G1 X82.954 Y99.545 E.0061
G1 X82.937 Y100.071 E.00878
G1 X83.002 Y100.542 E.00792
G1 X83.163 Y101.055 E.00898
G1 X83.346 Y101.42 E.00682
G1 X83.544 Y101.716 E.00594
G1 X83.869 Y102.078 E.00813
G1 X84.291 Y102.412 E.00898
G1 X84.739 Y102.651 E.00848
G1 X85.128 Y102.788 E.00689
G1 X85.627 Y102.884 E.00848
G1 X86.002 Y102.895 E.00626
G1 X86.528 Y102.841 E.00882
G1 X87.02 Y102.694 E.00857
G1 X87.359 Y102.532 E.00626
G1 X87.657 Y102.349 E.00585
G1 X88.056 Y102.015 E.00868
G1 X88.401 Y101.603 E.00897
G1 X88.607 Y101.248 E.00685
G1 X88.741 Y100.941 E.00559
G1 X88.875 Y100.454 E.00844
G1 X88.926 Y99.919 E.00897
G1 X88.905 Y99.536 E.00639
G1 X88.796 Y99.014 E.0089
G1 X88.657 Y98.654 E.00645
G1 X88.416 Y98.228 E.00817
G1 X88.087 Y97.815 E.00881
G1 X87.804 Y97.534 E.00666
; LINE_WIDTH: 0.415226
G1 X87.671 Y97.418 E.00343
; LINE_WIDTH: 0.45633
G1 X87.511 Y97.28 E.00452
; LINE_WIDTH: 0.484422
G1 X87.311 Y97.129 E.00575
; WIPE_START
G1 X87.511 Y97.28 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X92.678 Y96.154 Z1.32 F18000
G1 Z.92
G1 E.4 F1800
; LINE_WIDTH: 0.111318
G1 F1500
M204 S6000
G1 X92.932 Y96.011 E.00124
; WIPE_START
G1 X92.678 Y96.154 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X93.585 Y94.883 Z1.32 F18000
G1 Z.92
G1 E.4 F1800
; LINE_WIDTH: 0.102131
G1 F1500
M204 S6000
G1 X93.731 Y94.687 E.00093
; LINE_WIDTH: 0.146897
G1 X93.877 Y94.491 E.00148
; WIPE_START
G1 X93.731 Y94.687 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X96.038 Y94.127 Z1.32 F18000
G1 Z.92
G1 E.4 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F1500
M204 S6000
G1 X97.011 Y92.737 E.03592
G1 X96.828 Y92.611 E.00471
G1 X96.373 Y92.128 E.01405
G1 X95.918 Y91.316 E.0197
G1 X95.462 Y90.211 E.0253
G1 X95.007 Y90.174 E.00967
G1 X94.889 Y90.211 E.00261
G1 X93.916 Y91.601 E.03592
; WIPE_START
G1 X94.889 Y90.211 E-.32243
G1 X95.007 Y90.174 E-.02346
G1 X95.186 Y90.188 E-.03411
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X97.786 Y85.515 Z1.32 F18000
G1 Z.92
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.0965025
G1 F1500
M204 S6000
G1 X100.922 Y87.711 E.01352
; WIPE_START
G1 X99.284 Y86.564 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X92.412 Y83.242 Z1.32 F18000
G1 X79.372 Y76.938 Z1.32
G1 Z.92
G1 E.4 F1800
; LINE_WIDTH: 0.150985
G1 F1500
M204 S6000
G1 X79.038 Y77.15 E.00247
G1 X78.891 Y77.332 E.00146
G1 X78.835 Y77.433 E.00073
; LINE_WIDTH: 0.0998757
G1 X78.788 Y77.595 E.00062
; CHANGE_LAYER
; Z_HEIGHT: 1.04
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F1500
G1 X78.835 Y77.433 E-.38
; WIPE_END
G1 E-.02 F1800
; layer num/total_layer_count: 8/49
; update layer progress
M73 L8
M991 S0 P7 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z1.32 I-.523 J1.099 P1  F18000
G1 X100.617 Y87.791 Z1.32
G1 Z1.04
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X98.655 Y90.592 E.06727
G1 X95.854 Y88.63 E.06727
G1 X96.641 Y87.506 E.027
G1 X97.815 Y85.829 E.04027
G1 X100.568 Y87.756 E.06609
; WIPE_START
M204 S6000
G1 X99.45 Y89.414 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X95.09 Y83.149 Z1.44 F18000
G1 X93.304 Y80.581 Z1.44
G1 Z1.04
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X93.311 Y88.382 E.1651
G1 X92.95 Y88.382 E.00764
G1 X92.95 Y77.128 E.23818
G1 X93.135 Y77.076 E.00407
G1 X93.216 Y77.207 E.00325
G1 X93.272 Y77.349 E.00324
G1 X93.301 Y77.49 E.00305
G1 X93.304 Y80.521 E.06416
; WIPE_START
M204 S6000
G1 X93.306 Y82.521 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X89.431 Y89.097 Z1.44 F18000
G1 X84.703 Y97.12 Z1.44
G1 Z1.04
G1 E.4 F1800
G1 F1500
M204 S500
G1 X84.583 Y96.956 E.00429
G1 X84.941 Y96.544 E.01154
G1 X86.853 Y96.544 E.04045
G1 X87.196 Y96.916 E.0107
G1 X87.09 Y97.081 E.00416
G1 X86.697 Y96.953 E.00874
G1 X86.324 Y96.88 E.00804
G1 X85.794 Y96.856 E.01123
G1 X85.268 Y96.928 E.01124
G1 X84.903 Y97.034 E.00804
G1 X84.758 Y97.096 E.00335
; WIPE_START
M204 S6000
G1 X84.583 Y96.956 E-.04255
G1 X84.941 Y96.544 E-.10363
G1 X86.172 Y96.544 E-.23382
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X84.854 Y102.287 Z1.44 F18000
G1 Z1.04
G1 E.4 F1800
G1 F1500
M204 S500
G1 X84.486 Y102.089 E.00883
G1 X84.126 Y101.802 E.00975
G1 X83.907 Y101.566 E.00682
G1 X83.729 Y101.322 E.00637
G1 X83.505 Y100.897 E.01018
G1 X83.366 Y100.446 E.00999
G1 X83.31 Y99.979 E.00995
G1 X83.338 Y99.51 E.00995
G1 X83.449 Y99.054 E.00994
G1 X83.637 Y98.633 E.00976
G1 X83.811 Y98.361 E.00683
G1 X84.016 Y98.111 E.00683
G1 X84.358 Y97.803 E.00975
G1 X84.75 Y97.561 E.00975
G1 X85.047 Y97.434 E.00683
G1 X85.356 Y97.344 E.00683
G1 X85.813 Y97.282 E.00976
G1 X86.273 Y97.302 E.00975
G1 X86.59 Y97.365 E.00683
G1 X86.888 Y97.462 E.00663
G1 X87.172 Y97.593 E.00663
G1 X87.447 Y97.763 E.00683
G1 X87.798 Y98.061 E.00975
G1 X88.098 Y98.426 E.00999
G1 X88.33 Y98.847 E.01018
G1 X88.435 Y99.129 E.00638
G1 X88.511 Y99.442 E.00681
G1 X88.552 Y99.903 E.00979
G1 X88.506 Y100.382 E.01018
G1 X88.434 Y100.674 E.00637
G1 X88.321 Y100.975 E.00681
G1 X88.097 Y101.378 E.00975
G1 X87.798 Y101.741 E.00995
G1 X87.447 Y102.039 E.00975
G1 X87.173 Y102.208 E.00681
G1 X86.9 Y102.335 E.00638
G1 X86.439 Y102.473 E.01018
G1 X85.97 Y102.522 E.00999
G1 X85.511 Y102.488 E.00975
G1 X85.196 Y102.416 E.00683
G1 X84.908 Y102.313 E.00648
M204 S250
G1 X85.048 Y101.926 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X84.713 Y101.746 E.00748
G1 X84.405 Y101.501 E.00774
G1 X84.223 Y101.305 E.00526
G1 X84.078 Y101.105 E.00486
G1 X83.885 Y100.74 E.00812
G1 X83.768 Y100.361 E.00781
G1 X83.721 Y99.967 E.0078
G1 X83.744 Y99.571 E.0078
G1 X83.838 Y99.186 E.00779
G1 X83.998 Y98.827 E.00774
G1 X84.142 Y98.602 E.00526
G1 X84.312 Y98.395 E.00526
G1 X84.604 Y98.132 E.00773
G1 X84.939 Y97.925 E.00774
G1 X85.185 Y97.82 E.00526
G1 X85.442 Y97.745 E.00526
G1 X85.831 Y97.692 E.00774
G1 X86.224 Y97.71 E.00773
G1 X86.487 Y97.762 E.00526
G1 X86.738 Y97.843 E.0052
G1 X86.978 Y97.954 E.0052
G1 X87.206 Y98.095 E.00526
G1 X87.506 Y98.349 E.00774
G1 X87.758 Y98.656 E.00781
G1 X87.957 Y99.018 E.00812
G1 X88.043 Y99.25 E.00487
G1 X88.106 Y99.509 E.00526
G1 X88.141 Y99.902 E.00775
G1 X88.102 Y100.313 E.00812
G1 X88.043 Y100.553 E.00486
G1 X87.949 Y100.803 E.00526
G1 X87.757 Y101.146 E.00774
G1 X87.506 Y101.452 E.0078
G1 X87.206 Y101.707 E.00773
G1 X86.978 Y101.847 E.00526
G1 X86.754 Y101.952 E.00487
G1 X86.359 Y102.07 E.00812
G1 X85.964 Y102.111 E.00781
G1 X85.572 Y102.082 E.00773
G1 X85.311 Y102.023 E.00526
G1 X85.103 Y101.948 E.00433
; WIPE_START
M204 S6000
G1 X84.713 Y101.746 E-.08359
G1 X84.405 Y101.501 E-.07473
G1 X84.223 Y101.305 E-.05079
G1 X84.078 Y101.105 E-.04698
G1 X83.885 Y100.74 E-.07845
G1 X83.815 Y100.511 E-.04546
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X90.234 Y96.383 Z1.44 F18000
G1 X98.177 Y91.275 Z1.44
G1 Z1.04
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X98.379 Y91.416 E.00522
G1 X95.332 Y95.768 E.11246
G1 X93.972 Y94.816 E.03514
G1 X93.202 Y95.636 E.0238
G1 X92.95 Y95.746 E.00582
G1 X92.994 Y95.432 E.00671
G1 X93.534 Y94.509 E.02262
G1 X92.126 Y93.524 E.03636
G1 X95.174 Y89.172 E.11246
G1 X98.128 Y91.24 E.07633
; WIPE_START
M204 S6000
G1 X98.379 Y91.416 E-.05824
G1 X97.408 Y92.803 E-.32176
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X90.023 Y94.73 Z1.44 F18000
G1 X84.691 Y96.12 Z1.44
G1 Z1.04
G1 E.4 F1800
G1 F1500
M204 S500
G1 X92.468 Y96.12 E.1646
G1 X92.581 Y95.324 E.01701
G1 X92.97 Y94.633 E.0168
G1 X91.536 Y93.628 E.03707
G1 X97.307 Y85.386 E.21296
G1 X97.521 Y85.536 E.00554
G1 X95.284 Y88.731 E.08255
G1 X98.756 Y91.162 E.08971
G1 X100.993 Y87.967 E.08255
G1 X101.207 Y88.117 E.00554
G1 X95.436 Y96.359 E.21296
G1 X94.029 Y95.374 E.03634
G1 X93.476 Y95.963 E.0171
G1 X93.186 Y96.105 E.00684
G1 X92.909 Y96.336 E.00764
G1 X92.72 Y96.43 E.00446
G1 X92.582 Y96.466 E.00302
G1 X92.404 Y96.482 E.00378
G1 X87.372 Y96.482 E.10649
G1 X88.475 Y97.675 E.03439
G1 X88.731 Y98.008 E.00889
G1 X89.002 Y98.494 E.01178
G1 X89.16 Y98.903 E.00929
G1 X89.286 Y99.49 E.01269
G1 X89.305 Y100.1 E.01292
G1 X89.225 Y100.651 E.01178
G1 X89.101 Y101.073 E.00931
G1 X88.844 Y101.616 E.01272
G1 X88.517 Y102.075 E.01192
G1 X88.214 Y102.392 E.0093
G1 X87.897 Y102.65 E.00864
G1 X87.41 Y102.939 E.01199
G1 X87.024 Y103.099 E.00885
G1 X86.628 Y103.208 E.00869
G1 X86.222 Y103.269 E.00868
G1 X85.63 Y103.267 E.01254
G1 X85.038 Y103.161 E.01273
G1 X84.507 Y102.965 E.01197
G1 X84.121 Y102.755 E.00929
G1 X83.797 Y102.522 E.00845
G1 X83.502 Y102.251 E.0085
G1 X83.24 Y101.947 E.00849
G1 X83.017 Y101.613 E.00849
G1 X82.762 Y101.078 E.01255
G1 X82.653 Y100.72 E.00791
G1 X82.573 Y100.289 E.00929
G1 X82.551 Y99.89 E.00845
G1 X82.576 Y99.49 E.00849
G1 X82.648 Y99.095 E.0085
G1 X82.839 Y98.533 E.01255
G1 X83.011 Y98.201 E.00791
G1 X83.255 Y97.836 E.0093
G1 X84.434 Y96.482 E.038
G1 X79.467 Y96.482 E.10513
M73 P45 R13
G1 X79.23 Y96.454 E.00504
G1 X79.019 Y96.376 E.00478
G1 X78.899 Y96.301 E.00298
G1 X78.72 Y96.119 E.00542
G1 X78.67 Y96.042 E.00193
G1 X78.579 Y95.813 E.00522
G1 X78.55 Y95.565 E.0053
G1 X78.55 Y77.628 E.37964
G1 X78.586 Y77.357 E.00578
G1 X78.646 Y77.207 E.00343
G1 X78.726 Y77.076 E.00324
G1 X78.905 Y76.895 E.00539
G1 X79.13 Y76.775 E.00539
G1 X79.379 Y76.723 E.00539
G1 X92.408 Y76.721 E.27575
G1 X92.641 Y76.749 E.00497
G1 X92.778 Y76.794 E.00307
G1 X92.955 Y76.889 E.00424
G1 X92.906 Y77.082 E.0042
G1 X79.857 Y77.082 E.27621
G1 X79.487 Y77.171 E.00805
G1 X79.233 Y77.35 E.00658
G1 X79.069 Y77.546 E.0054
G1 X78.948 Y77.807 E.0061
G1 X78.911 Y78.056 E.00533
G1 X78.911 Y95.155 E.36192
G1 X78.964 Y95.453 E.0064
G1 X79.147 Y95.77 E.00776
G1 X79.475 Y96.029 E.00884
G1 X79.858 Y96.12 E.00834
G1 X84.631 Y96.12 E.10103
; WIPE_START
M204 S6000
G1 X86.631 Y96.12 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X83.535 Y96.891 Z1.44 F18000
G1 Z1.04
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X79.443 Y96.891 E.08049
G1 X79.134 Y96.855 E.00612
G1 X78.838 Y96.745 E.00622
G1 X78.658 Y96.634 E.00415
G1 X78.548 Y96.541 E.00284
G1 X78.394 Y96.368 E.00454
G1 X78.314 Y96.246 E.00287
G1 X78.243 Y96.102 E.00316
G1 X78.177 Y95.902 E.00415
G1 X78.141 Y95.589 E.0062
G1 X78.141 Y77.61 E.35362
G1 X78.161 Y77.374 E.00466
G1 X78.194 Y77.234 E.00283
G1 X78.278 Y77.022 E.00448
G1 X78.397 Y76.831 E.00442
G1 X78.548 Y76.661 E.00448
G1 X78.66 Y76.566 E.00289
G1 X78.783 Y76.486 E.00289
G1 X78.99 Y76.389 E.00448
G1 X79.21 Y76.33 E.00448
G1 X79.356 Y76.313 E.00289
G1 X92.432 Y76.311 E.2572
G1 X92.73 Y76.347 E.00591
G1 X92.941 Y76.417 E.00437
G1 X93.139 Y76.524 E.00442
G1 X93.315 Y76.663 E.00442
G1 X93.465 Y76.831 E.00442
G1 X93.583 Y77.022 E.00442
G1 X93.666 Y77.231 E.00442
G1 X93.71 Y77.448 E.00436
G1 X93.72 Y88.791 E.2231
G1 X92.541 Y88.791 E.02321
G1 X92.541 Y77.491 E.22226
G1 X79.906 Y77.491 E.24852
G1 X79.659 Y77.551 E.00498
G1 X79.513 Y77.654 E.00353
G1 X79.418 Y77.767 E.00291
G1 X79.344 Y77.925 E.00343
G1 X79.321 Y78.086 E.00318
G1 X79.321 Y95.119 E.33503
G1 X79.354 Y95.311 E.00382
G1 X79.462 Y95.498 E.00425
G1 X79.657 Y95.652 E.00489
G1 X79.906 Y95.711 E.00503
G1 X92.113 Y95.711 E.2401
G1 X92.182 Y95.221 E.00973
G1 X92.24 Y95.071 E.00316
G1 X92.426 Y94.752 E.00728
G1 X90.966 Y93.729 E.03508
G1 X97.206 Y84.816 E.214
G1 X101.777 Y88.017 E.10975
G1 X95.536 Y96.929 E.214
G1 X94.085 Y95.913 E.03485
G1 X93.742 Y96.278 E.00985
G1 X93.604 Y96.369 E.00326
G1 X93.403 Y96.457 E.00432
G1 X93.133 Y96.681 E.0069
G1 X92.865 Y96.814 E.00589
G1 X92.652 Y96.871 E.00432
G1 X92.421 Y96.891 E.00456
G1 X88.307 Y96.891 E.08092
G1 X88.788 Y97.411 E.01393
G1 X89.066 Y97.772 E.00897
G1 X89.184 Y97.957 E.00431
G1 X89.376 Y98.325 E.00816
G1 X89.551 Y98.781 E.0096
G1 X89.659 Y99.22 E.0089
G1 X89.713 Y99.661 E.00873
G1 X89.714 Y100.117 E.00897
G1 X89.695 Y100.335 E.00431
G1 X89.624 Y100.744 E.00816
G1 X89.486 Y101.212 E.00961
G1 X89.321 Y101.593 E.00815
G1 X89.08 Y102.009 E.00947
G1 X88.829 Y102.34 E.00816
G1 X88.492 Y102.694 E.00961
G1 X88.141 Y102.979 E.00889
G1 X87.96 Y103.102 E.00431
G1 X87.594 Y103.305 E.00823
G1 X87.357 Y103.412 E.00512
G1 X87.15 Y103.489 E.00435
G1 X86.713 Y103.609 E.00891
G1 X86.265 Y103.676 E.00891
G1 X86.046 Y103.689 E.00431
G1 X85.593 Y103.676 E.00891
G1 X85.145 Y103.608 E.00891
G1 X84.93 Y103.556 E.00437
G1 X84.717 Y103.491 E.00437
G1 X84.332 Y103.336 E.00816
G1 X83.903 Y103.103 E.00961
G1 X83.539 Y102.84 E.00884
G1 X83.207 Y102.536 E.00885
G1 X82.914 Y102.195 E.00885
G1 X82.663 Y101.821 E.00885
G1 X82.457 Y101.417 E.00891
G1 X82.376 Y101.214 E.00431
G1 X82.254 Y100.817 E.00816
G1 X82.166 Y100.337 E.0096
G1 X82.141 Y99.889 E.00884
G1 X82.169 Y99.44 E.00885
G1 X82.25 Y98.997 E.00885
G1 X82.384 Y98.564 E.00891
G1 X82.467 Y98.362 E.00431
G1 X82.657 Y97.993 E.00816
G1 X82.929 Y97.587 E.00961
G1 X83.496 Y96.936 E.01697
; WIPE_START
M204 S6000
G1 X81.496 Y96.914 E-.38
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




G1 X79.363 Y96.236
G1 Z1.04
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.0939604
G1 F1500
M204 S6000
G1 X79.29 Y96.206 E.00027
; LINE_WIDTH: 0.121254
G1 X79.217 Y96.165 E.0004
; LINE_WIDTH: 0.155378
G1 X79.03 Y96.04 E.00145
G1 X78.939 Y95.953 E.00081
G1 X78.876 Y95.845 E.00081
; LINE_WIDTH: 0.128541
G1 X78.834 Y95.734 E.00061
; LINE_WIDTH: 0.0944514
G1 X78.792 Y95.622 E.00041
; WIPE_START
G1 X78.834 Y95.734 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X84.474 Y97.167 Z1.44 F18000
G1 Z1.04
G1 E.4 F1800
; LINE_WIDTH: 0.4752
G1 F1500
M204 S6000
G1 X84.3 Y97.315 E.00513
; LINE_WIDTH: 0.438791
G1 X84.099 Y97.487 E.00545
; LINE_WIDTH: 0.402125
G1 X83.925 Y97.664 E.00466
; LINE_WIDTH: 0.359891
G1 X83.558 Y98.068 E.00909
G1 X83.34 Y98.392 E.00652
G1 X83.128 Y98.837 E.0082
G1 X83.022 Y99.186 E.00609
G1 X82.955 Y99.536 E.00593
G1 X82.934 Y100.005 E.00783
G1 X83.001 Y100.539 E.00896
G1 X83.121 Y100.945 E.00707
G1 X83.349 Y101.421 E.00879
G1 X83.61 Y101.798 E.00765
G1 X83.879 Y102.086 E.00657
G1 X84.291 Y102.412 E.00876
G1 X84.728 Y102.646 E.00826
G1 X85.138 Y102.793 E.00727
G1 X85.664 Y102.884 E.0089
G1 X85.961 Y102.896 E.00495
G1 X86.498 Y102.846 E.009
G1 X86.903 Y102.735 E.007
G1 X87.241 Y102.597 E.00609
G1 X87.541 Y102.43 E.00572
G1 X87.955 Y102.109 E.00873
G1 X88.225 Y101.826 E.00652
G1 X88.428 Y101.563 E.00554
G1 X88.668 Y101.123 E.00837
G1 X88.791 Y100.794 E.00584
G1 X88.878 Y100.433 E.0062
G1 X88.926 Y99.919 E.00861
G1 X88.883 Y99.393 E.0088
G1 X88.796 Y99.015 E.00646
G1 X88.655 Y98.65 E.00652
G1 X88.416 Y98.228 E.00808
G1 X88.058 Y97.784 E.00951
; LINE_WIDTH: 0.375798
G1 X87.879 Y97.612 E.00434
; LINE_WIDTH: 0.408485
G1 X87.672 Y97.416 E.00543
; LINE_WIDTH: 0.445778
G1 X87.492 Y97.272 E.00484
; LINE_WIDTH: 0.479641
G1 X87.312 Y97.128 E.00523
; WIPE_START
G1 X87.492 Y97.272 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X92.678 Y96.154 Z1.44 F18000
G1 Z1.04
G1 E.4 F1800
; LINE_WIDTH: 0.111534
G1 F1500
M204 S6000
G1 X92.932 Y96.01 E.00125
; WIPE_START
G1 X92.678 Y96.154 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X93.595 Y94.873 Z1.44 F18000
G1 Z1.04
G1 E.4 F1800
; LINE_WIDTH: 0.100999
G1 F1500
M204 S6000
G1 X93.737 Y94.683 E.00089
; LINE_WIDTH: 0.143505
G1 X93.879 Y94.492 E.0014
; WIPE_START
G1 X93.737 Y94.683 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X95.733 Y93.875 Z1.44 F18000
G1 Z1.04
G1 E.4 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F1500
M204 S6000
G1 X96.707 Y92.484 E.03592
G1 X96.373 Y92.173 E.00967
G1 X95.918 Y91.51 E.01702
G1 X95.462 Y90.75 E.01875
G1 X95.14 Y90.54 E.00814
G1 X94.167 Y91.93 E.03592
; WIPE_START
G1 X95.14 Y90.54 E-.32243
G1 X95.394 Y90.705 E-.05757
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X97.756 Y91.645 Z1.44 F18000
G1 Z1.04
G1 E.4 F1800
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.365752
G1 F1200
M204 S6000
G1 X95.334 Y95.105 E.07163
; LINE_WIDTH: 0.378262
G1 X95.283 Y95.153 E.00124
; LINE_WIDTH: 0.394943
G1 X95.232 Y95.201 E.0013
G1 X95.102 Y95.146 E.00259
; LINE_WIDTH: 0.365752
G1 X94.348 Y94.617 E.01563
G1 X94.272 Y94.44 E.00326
G1 X93.811 Y94.106 E.00966
G1 X93.61 Y94.1 E.00341
G1 X92.79 Y93.526 E.01697
; LINE_WIDTH: 0.378267
G1 X92.742 Y93.475 E.00124
; LINE_WIDTH: 0.394955
G1 X92.693 Y93.424 E.0013
G1 X92.749 Y93.295 E.00259
; LINE_WIDTH: 0.365752
G1 X95.171 Y89.835 E.07163
; LINE_WIDTH: 0.378267
G1 X95.223 Y89.787 E.00124
; LINE_WIDTH: 0.394955
G1 X95.274 Y89.739 E.0013
G1 X95.403 Y89.794 E.00259
; LINE_WIDTH: 0.365752
G1 X97.716 Y91.414 E.04788
; LINE_WIDTH: 0.378267
G1 X97.764 Y91.465 E.00124
; LINE_WIDTH: 0.396592
G1 X97.812 Y91.516 E.0013
G1 X97.783 Y91.592 E.0015
; WIPE_START
G1 X97.812 Y91.516 E-.20359
G1 X97.764 Y91.465 E-.17641
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X100.922 Y87.711 Z1.44 F18000
G1 Z1.04
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.0965191
G1 F1500
M204 S6000
G1 X97.786 Y85.515 E.01352
; WIPE_START
G1 X99.424 Y86.662 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X92.557 Y83.33 Z1.44 F18000
G1 X79.382 Y76.936 Z1.44
G1 Z1.04
M73 P46 R13
G1 E.4 F1800
; LINE_WIDTH: 0.150225
G1 F1500
M204 S6000
G1 X79.037 Y77.15 E.00252
G1 X78.89 Y77.333 E.00146
G1 X78.835 Y77.433 E.00071
; LINE_WIDTH: 0.099851
G1 X78.788 Y77.595 E.00062
; CHANGE_LAYER
; Z_HEIGHT: 1.16
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F1500
G1 X78.835 Y77.433 E-.38
; WIPE_END
G1 E-.02 F1800
; layer num/total_layer_count: 9/49
; update layer progress
M73 L9
M991 S0 P8 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z1.44 I-.523 J1.099 P1  F18000
G1 X100.617 Y87.791 Z1.44
G1 Z1.16
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X98.655 Y90.592 E.06727
G1 X95.854 Y88.63 E.06727
G1 X96.512 Y87.69 E.02257
G1 X97.815 Y85.829 E.0447
G1 X100.568 Y87.756 E.06609
; WIPE_START
M204 S6000
G1 X99.45 Y89.414 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X95.09 Y83.149 Z1.56 F18000
G1 X93.304 Y80.581 Z1.56
G1 Z1.16
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X93.311 Y88.382 E.1651
G1 X92.95 Y88.382 E.00764
G1 X92.95 Y77.128 E.23818
G1 X93.135 Y77.076 E.00407
G1 X93.216 Y77.207 E.00325
G1 X93.272 Y77.349 E.00324
G1 X93.301 Y77.49 E.00306
G1 X93.304 Y80.521 E.06416
; WIPE_START
M204 S6000
G1 X93.306 Y82.521 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X89.431 Y89.097 Z1.56 F18000
G1 X84.703 Y97.12 Z1.56
G1 Z1.16
G1 E.4 F1800
G1 F1500
M204 S500
G1 X84.583 Y96.956 E.00429
G1 X84.941 Y96.544 E.01155
G1 X86.92 Y96.544 E.04188
G1 X87.273 Y96.951 E.0114
G1 X87.15 Y97.115 E.00436
G1 X86.697 Y96.954 E.01018
G1 X86.324 Y96.88 E.00805
G1 X85.794 Y96.856 E.01123
G1 X85.268 Y96.928 E.01124
G1 X84.903 Y97.034 E.00803
G1 X84.758 Y97.096 E.00335
; WIPE_START
M204 S6000
G1 X84.583 Y96.956 E-.04255
G1 X84.941 Y96.544 E-.10365
G1 X86.172 Y96.544 E-.2338
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X84.853 Y102.286 Z1.56 F18000
G1 Z1.16
G1 E.4 F1800
G1 F1500
M204 S500
G1 X84.486 Y102.089 E.00882
G1 X84.126 Y101.802 E.00976
G1 X83.907 Y101.566 E.00681
G1 X83.731 Y101.325 E.00632
G1 X83.505 Y100.897 E.01023
G1 X83.366 Y100.446 E.00999
G1 X83.31 Y99.979 E.00995
G1 X83.338 Y99.519 E.00975
G1 X83.404 Y99.205 E.00681
G1 X83.5 Y98.922 E.00632
G1 X83.72 Y98.491 E.01023
G1 X84.009 Y98.118 E.00999
G1 X84.358 Y97.803 E.00995
G1 X84.75 Y97.561 E.00975
G1 X85.047 Y97.434 E.00683
G1 X85.356 Y97.344 E.00683
G1 X85.813 Y97.282 E.00975
G1 X86.273 Y97.302 E.00975
G1 X86.59 Y97.365 E.00683
G1 X86.888 Y97.462 E.00663
G1 X87.172 Y97.593 E.00663
G1 X87.447 Y97.763 E.00683
G1 X87.798 Y98.061 E.00975
G1 X88.098 Y98.426 E.00999
G1 X88.331 Y98.85 E.01023
G1 X88.435 Y99.13 E.00632
G1 X88.511 Y99.442 E.00681
G1 X88.552 Y99.901 E.00975
G1 X88.51 Y100.371 E.00999
G1 X88.378 Y100.836 E.01023
G1 X88.256 Y101.109 E.00633
G1 X88.091 Y101.385 E.00681
G1 X87.798 Y101.741 E.00975
G1 X87.447 Y102.039 E.00975
G1 X87.173 Y102.208 E.00681
G1 X86.902 Y102.334 E.00632
G1 X86.439 Y102.473 E.01023
G1 X85.979 Y102.521 E.0098
G1 X85.658 Y102.507 E.00681
G1 X85.363 Y102.459 E.00632
G1 X84.906 Y102.314 E.01014
M204 S250
G1 X85.047 Y101.926 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X84.713 Y101.746 E.00747
G1 X84.405 Y101.501 E.00774
G1 X84.223 Y101.305 E.00525
G1 X84.079 Y101.107 E.00482
G1 X83.885 Y100.74 E.00817
G1 X83.768 Y100.361 E.00781
G1 X83.721 Y99.967 E.0078
G1 X83.744 Y99.574 E.00774
G1 X83.8 Y99.313 E.00526
G1 X83.878 Y99.081 E.00482
G1 X84.067 Y98.711 E.00817
G1 X84.31 Y98.397 E.00781
G1 X84.605 Y98.132 E.0078
G1 X84.939 Y97.925 E.00773
G1 X85.185 Y97.82 E.00526
G1 X85.442 Y97.745 E.00526
G1 X85.831 Y97.692 E.00774
G1 X86.224 Y97.71 E.00773
G1 X86.487 Y97.762 E.00526
G1 X86.738 Y97.843 E.0052
G1 X86.978 Y97.954 E.0052
G1 X87.206 Y98.095 E.00526
G1 X87.506 Y98.349 E.00773
G1 X87.758 Y98.656 E.00781
G1 X87.957 Y99.02 E.00817
G1 X88.043 Y99.25 E.00482
G1 X88.106 Y99.509 E.00526
G1 X88.141 Y99.901 E.00773
G1 X88.106 Y100.296 E.00781
G1 X87.993 Y100.696 E.00817
G1 X87.892 Y100.919 E.00482
G1 X87.755 Y101.149 E.00525
G1 X87.506 Y101.452 E.00773
G1 X87.206 Y101.707 E.00773
G1 X86.978 Y101.847 E.00526
G1 X86.756 Y101.951 E.00482
G1 X86.359 Y102.07 E.00817
G1 X85.967 Y102.111 E.00775
G1 X85.7 Y102.099 E.00525
G1 X85.458 Y102.06 E.00482
G1 X85.103 Y101.947 E.00733
; WIPE_START
M204 S6000
G1 X84.713 Y101.746 E-.08343
G1 X84.405 Y101.501 E-.07476
G1 X84.223 Y101.305 E-.05074
G1 X84.079 Y101.107 E-.04653
G1 X83.885 Y100.74 E-.07891
G1 X83.814 Y100.51 E-.04564
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X90.234 Y96.382 Z1.56 F18000
G1 X98.177 Y91.275 Z1.56
G1 Z1.16
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X98.379 Y91.416 E.00522
G1 X95.332 Y95.768 E.11245
G1 X93.972 Y94.816 E.03514
G1 X93.202 Y95.636 E.0238
G1 X92.95 Y95.746 E.00582
G1 X92.994 Y95.432 E.00672
G1 X93.534 Y94.51 E.02262
G1 X92.126 Y93.524 E.03637
G1 X95.174 Y89.172 E.11245
G1 X98.128 Y91.24 E.07633
; WIPE_START
M204 S6000
G1 X98.379 Y91.416 E-.05824
G1 X97.408 Y92.803 E-.32176
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X90.022 Y94.73 Z1.56 F18000
G1 X84.691 Y96.12 Z1.56
G1 Z1.16
G1 E.4 F1800
G1 F1500
M204 S500
G1 X92.468 Y96.12 E.16461
G1 X92.581 Y95.324 E.01701
G1 X92.97 Y94.633 E.0168
G1 X91.536 Y93.628 E.03707
G1 X97.307 Y85.386 E.21296
G1 X97.521 Y85.536 E.00554
G1 X95.284 Y88.731 E.08255
G1 X98.756 Y91.162 E.08971
G1 X100.993 Y87.967 E.08255
G1 X101.207 Y88.117 E.00554
G1 X95.436 Y96.359 E.21296
G1 X94.029 Y95.374 E.03634
G1 X93.476 Y95.963 E.01709
G1 X93.186 Y96.105 E.00684
G1 X92.909 Y96.336 E.00764
G1 X92.72 Y96.43 E.00446
G1 X92.582 Y96.466 E.00302
G1 X92.404 Y96.482 E.00378
G1 X87.428 Y96.482 E.10532
G1 X88.614 Y97.845 E.03825
G1 X88.931 Y98.345 E.01253
G1 X89.098 Y98.72 E.00869
G1 X89.257 Y99.3 E.01273
G1 X89.286 Y99.489 E.00406
G1 X89.305 Y100.1 E.01293
G1 X89.226 Y100.646 E.01168
G1 X89.098 Y101.081 E.00959
G1 X88.84 Y101.622 E.01268
G1 X88.52 Y102.071 E.01169
G1 X88.214 Y102.393 E.0094
G1 X87.897 Y102.65 E.00863
G1 X87.379 Y102.955 E.01274
G1 X86.852 Y103.152 E.01189
G1 X86.634 Y103.207 E.00476
G1 X86.222 Y103.269 E.00883
G1 X85.63 Y103.267 E.01253
G1 X85.038 Y103.161 E.01274
G1 X84.511 Y102.967 E.01188
G1 X84.121 Y102.755 E.00939
G1 X83.797 Y102.522 E.00844
G1 X83.502 Y102.251 E.0085
G1 X83.24 Y101.947 E.00849
G1 X83.017 Y101.613 E.00849
G1 X82.834 Y101.256 E.00849
G1 X82.696 Y100.879 E.00849
G1 X82.602 Y100.489 E.0085
G1 X82.555 Y100.081 E.00868
G1 X82.572 Y99.53 E.01169
G1 X82.649 Y99.093 E.00939
G1 X82.77 Y98.703 E.00864
G1 X83.008 Y98.205 E.01169
G1 X83.255 Y97.836 E.00939
G1 X84.433 Y96.482 E.038
G1 X79.467 Y96.482 E.10513
G1 X79.218 Y96.453 E.0053
G1 X79.086 Y96.409 E.00295
G1 X78.913 Y96.311 E.0042
G1 X78.724 Y96.123 E.00565
G1 X78.651 Y96.004 E.00295
G1 X78.578 Y95.803 E.00452
G1 X78.55 Y95.565 E.00508
G1 X78.55 Y77.619 E.37984
G1 X78.591 Y77.34 E.00597
G1 X78.697 Y77.118 E.0052
G1 X78.792 Y76.997 E.00326
G1 X78.903 Y76.898 E.00314
G1 X79.131 Y76.775 E.00549
G1 X79.382 Y76.723 E.00541
G1 X92.409 Y76.721 E.27574
G1 X92.64 Y76.749 E.00493
G1 X92.779 Y76.794 E.00308
G1 X92.955 Y76.889 E.00424
G1 X92.906 Y77.082 E.0042
G1 X79.895 Y77.082 E.2754
G1 X79.685 Y77.106 E.00446
G1 X79.392 Y77.223 E.00668
G1 X79.085 Y77.512 E.00893
G1 X78.948 Y77.807 E.00688
G1 X78.911 Y78.056 E.00533
G1 X78.911 Y95.155 E.36192
G1 X78.964 Y95.453 E.0064
G1 X79.152 Y95.778 E.00796
G1 X79.513 Y96.047 E.00952
G1 X79.867 Y96.12 E.00767
G1 X84.631 Y96.12 E.10083
; WIPE_START
M204 S6000
G1 X86.631 Y96.12 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X83.535 Y96.891 Z1.56 F18000
G1 Z1.16
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X79.443 Y96.891 E.08049
G1 X79.13 Y96.854 E.0062
G1 X78.931 Y96.789 E.00412
G1 X78.785 Y96.717 E.0032
G1 X78.663 Y96.637 E.00287
G1 X78.491 Y96.484 E.00453
G1 X78.39 Y96.361 E.00313
G1 X78.28 Y96.182 E.00412
G1 X78.177 Y95.898 E.00595
G1 X78.141 Y95.589 E.00613
G1 X78.141 Y77.607 E.35368
G1 X78.149 Y77.454 E.00301
G1 X78.196 Y77.228 E.00454
G1 X78.245 Y77.093 E.00283
G1 X78.353 Y76.892 E.00448
G1 X78.493 Y76.716 E.00443
G1 X78.651 Y76.574 E.00418
G1 X78.784 Y76.485 E.00313
G1 X78.99 Y76.389 E.00447
G1 X79.195 Y76.333 E.00418
G1 X79.356 Y76.313 E.0032
G1 X92.434 Y76.311 E.25722
G1 X92.73 Y76.347 E.00588
G1 X92.941 Y76.417 E.00437
G1 X93.139 Y76.524 E.00442
G1 X93.315 Y76.663 E.00442
G1 X93.465 Y76.831 E.00442
G1 X93.583 Y77.022 E.00442
G1 X93.666 Y77.231 E.00442
G1 X93.71 Y77.448 E.00436
G1 X93.72 Y88.791 E.2231
G1 X92.541 Y88.791 E.02321
G1 X92.541 Y77.491 E.22226
G1 X79.918 Y77.491 E.24827
G1 X79.786 Y77.506 E.00261
G1 X79.616 Y77.574 E.00361
G1 X79.423 Y77.756 E.00521
G1 X79.344 Y77.925 E.00368
G1 X79.321 Y78.086 E.00319
G1 X79.321 Y95.119 E.33504
G1 X79.354 Y95.311 E.00382
G1 X79.464 Y95.501 E.00431
G1 X79.684 Y95.664 E.0054
G1 X79.909 Y95.711 E.00452
G1 X92.113 Y95.711 E.24004
G1 X92.182 Y95.221 E.00973
G1 X92.24 Y95.07 E.00317
G1 X92.427 Y94.752 E.00726
G1 X90.966 Y93.729 E.03508
G1 X97.206 Y84.816 E.214
G1 X101.777 Y88.017 E.10975
G1 X95.536 Y96.929 E.214
G1 X94.085 Y95.913 E.03485
G1 X93.742 Y96.278 E.00984
G1 X93.604 Y96.369 E.00326
G1 X93.403 Y96.457 E.00432
G1 X93.133 Y96.681 E.0069
G1 X92.865 Y96.814 E.0059
G1 X92.653 Y96.871 E.00432
G1 X92.421 Y96.891 E.00456
G1 X88.326 Y96.891 E.08055
G1 X88.934 Y97.59 E.01823
G1 X89.063 Y97.767 E.0043
G1 X89.295 Y98.156 E.00891
G1 X89.479 Y98.57 E.00891
M73 P47 R13
G1 X89.55 Y98.777 E.0043
G1 X89.659 Y99.22 E.00897
G1 X89.713 Y99.661 E.00873
G1 X89.714 Y100.117 E.00897
G1 X89.695 Y100.335 E.00431
G1 X89.625 Y100.739 E.00807
G1 X89.485 Y101.215 E.00976
G1 X89.404 Y101.417 E.00429
G1 X89.196 Y101.824 E.00897
G1 X89.08 Y102.009 E.00431
G1 X88.832 Y102.337 E.00807
G1 X88.492 Y102.694 E.0097
G1 X88.141 Y102.979 E.00889
G1 X87.96 Y103.102 E.00431
G1 X87.561 Y103.322 E.00897
G1 X87.36 Y103.411 E.00431
G1 X86.969 Y103.545 E.00814
G1 X86.715 Y103.609 E.00515
G1 X86.264 Y103.676 E.00896
G1 X86.046 Y103.689 E.0043
G1 X85.593 Y103.676 E.00891
G1 X85.145 Y103.608 E.00891
G1 X84.93 Y103.556 E.00437
G1 X84.717 Y103.491 E.00437
G1 X84.336 Y103.338 E.00807
G1 X83.903 Y103.103 E.0097
G1 X83.539 Y102.84 E.00883
G1 X83.207 Y102.536 E.00885
G1 X82.914 Y102.195 E.00885
G1 X82.663 Y101.821 E.00885
G1 X82.459 Y101.42 E.00885
G1 X82.303 Y100.998 E.00885
G1 X82.199 Y100.56 E.00885
G1 X82.147 Y100.11 E.00891
G1 X82.141 Y99.891 E.00431
G1 X82.165 Y99.482 E.00807
G1 X82.251 Y98.996 E.0097
G1 X82.384 Y98.564 E.0089
G1 X82.467 Y98.362 E.00431
G1 X82.655 Y97.997 E.00807
G1 X82.929 Y97.587 E.0097
G1 X83.496 Y96.936 E.01697
; WIPE_START
M204 S6000
G1 X81.496 Y96.914 E-.38
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




G1 X79.342 Y96.25
G1 Z1.16
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.159156
G1 F1500
M204 S6000
G1 X78.99 Y96.006 E.00285
G1 X78.897 Y95.883 E.00103
; LINE_WIDTH: 0.133841
G1 X78.778 Y95.627 E.00153
; WIPE_START
G1 X78.897 Y95.883 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X84.474 Y97.167 Z1.56 F18000
G1 Z1.16
G1 E.4 F1800
; LINE_WIDTH: 0.475209
G1 F1500
M204 S6000
G1 X84.3 Y97.315 E.00513
; LINE_WIDTH: 0.438857
G1 X84.099 Y97.487 E.00545
; LINE_WIDTH: 0.401798
G1 X83.921 Y97.669 E.00478
; LINE_WIDTH: 0.359879
G1 X83.723 Y97.872 E.00474
G1 X83.394 Y98.303 E.00903
G1 X83.147 Y98.786 E.00905
G1 X83.02 Y99.182 E.00693
G1 X82.952 Y99.574 E.00663
G1 X82.935 Y100.005 E.00719
G1 X82.995 Y100.51 E.00847
G1 X83.163 Y101.056 E.00952
G1 X83.405 Y101.514 E.00865
G1 X83.61 Y101.798 E.00584
G1 X83.879 Y102.086 E.00656
G1 X84.291 Y102.412 E.00876
G1 X84.741 Y102.654 E.00852
G1 X85.263 Y102.825 E.00915
G1 X85.628 Y102.884 E.00617
G1 X85.978 Y102.9 E.00583
G1 X86.529 Y102.84 E.00924
G1 X87.026 Y102.692 E.00865
G1 X87.343 Y102.542 E.00584
G1 X87.675 Y102.342 E.00647
G1 X87.953 Y102.111 E.00602
G1 X88.226 Y101.824 E.00659
G1 X88.509 Y101.43 E.00809
G1 X88.739 Y100.955 E.00881
G1 X88.854 Y100.559 E.00686
G1 X88.907 Y100.238 E.00542
G1 X88.919 Y99.696 E.00904
G1 X88.878 Y99.369 E.0055
G1 X88.793 Y99.002 E.00627
G1 X88.589 Y98.522 E.0087
G1 X88.399 Y98.204 E.00618
M73 P47 R12
G1 X88.058 Y97.784 E.00902
; LINE_WIDTH: 0.378816
G1 X87.881 Y97.609 E.00438
; LINE_WIDTH: 0.41932
G1 X87.678 Y97.411 E.00557
; LINE_WIDTH: 0.468133
G1 X87.38 Y97.162 E.00857
; WIPE_START
G1 X87.678 Y97.411 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X92.678 Y96.154 Z1.56 F18000
G1 Z1.16
G1 E.4 F1800
; LINE_WIDTH: 0.111409
G1 F1500
M204 S6000
G1 X92.932 Y96.011 E.00125
; WIPE_START
G1 X92.678 Y96.154 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X93.596 Y94.871 Z1.56 F18000
G1 Z1.16
G1 E.4 F1800
; LINE_WIDTH: 0.100869
G1 F1500
M204 S6000
G1 X93.737 Y94.682 E.00089
; LINE_WIDTH: 0.143101
G1 X93.879 Y94.492 E.00139
; WIPE_START
G1 X93.737 Y94.682 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X94.741 Y95.144 Z1.56 F18000
G1 Z1.16
G1 E.4 F1800
; FEATURE: Bridge
; LINE_WIDTH: 0.40963
; LAYER_HEIGHT: 0.4
G1 F910.559
M204 S6000
G1 X97.559 Y91.932 E.23411
G1 X97.856 Y91.508 E.02831
G1 X97.524 Y91.276 E.02223
G1 X94.497 Y94.725 E.25143
G1 X94.351 Y94.623 E.00979
G1 X94.476 Y94.47 E.01085
G1 X94.255 Y94.304 E.01513
G1 X97.145 Y91.011 E.24008
G1 X96.766 Y90.745 E.02533
G1 X93.886 Y94.028 E.23929
G1 X93.746 Y93.924 E.00957
G1 X93.611 Y94.104 E.01237
G1 X93.361 Y93.93 E.01671
G1 X96.387 Y90.48 E.25143
G1 X96.009 Y90.215 E.02533
G1 X92.982 Y93.664 E.25143
G1 X92.65 Y93.432 E.02223
G1 X92.946 Y93.008 E.02832
G1 X95.764 Y89.797 E.2341
; WIPE_START
G1 X94.445 Y91.3 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X97.786 Y85.515 Z1.56 F18000
G1 Z1.16
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.0965025
; LAYER_HEIGHT: 0.12
G1 F1500
M204 S6000
G1 X100.922 Y87.711 E.01352
; WIPE_START
G1 X99.284 Y86.564 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X92.413 Y83.24 Z1.56 F18000
G1 X79.428 Y76.956 Z1.56
G1 Z1.16
G1 E.4 F1800
; LINE_WIDTH: 0.0908534
G1 F1500
M204 S6000
G1 X79.247 Y77.01 E.00061
; LINE_WIDTH: 0.118566
G1 X79.22 Y77.024 E.00014
; LINE_WIDTH: 0.155085
G1 X79.004 Y77.194 E.00178
G1 X78.862 Y77.368 E.00145
; LINE_WIDTH: 0.11505
G1 X78.823 Y77.485 E.00055
; LINE_WIDTH: 0.0889632
G1 X78.785 Y77.601 E.00039
; CHANGE_LAYER
; Z_HEIGHT: 1.28
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F1500
G1 X78.823 Y77.485 E-.38
; WIPE_END
G1 E-.02 F1800
; layer num/total_layer_count: 10/49
; update layer progress
M73 L10
M991 S0 P9 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z1.56 I-.52 J1.1 P1  F18000
G1 X100.617 Y87.791 Z1.56
G1 Z1.28
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X98.655 Y90.592 E.06727
G1 X95.854 Y88.63 E.06727
G1 X96.383 Y87.875 E.01814
G1 X97.815 Y85.829 E.04912
G1 X100.568 Y87.756 E.06609
; WIPE_START
M204 S6000
G1 X99.45 Y89.414 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X95.09 Y83.149 Z1.68 F18000
G1 X93.304 Y80.581 Z1.68
G1 Z1.28
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X93.311 Y88.382 E.1651
G1 X92.95 Y88.382 E.00764
G1 X92.95 Y77.128 E.23818
G1 X93.135 Y77.076 E.00407
G1 X93.216 Y77.207 E.00325
G1 X93.272 Y77.349 E.00324
G1 X93.301 Y77.49 E.00306
G1 X93.304 Y80.521 E.06415
; WIPE_START
M204 S6000
G1 X93.306 Y82.521 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X89.431 Y89.097 Z1.68 F18000
G1 X84.703 Y97.12 Z1.68
G1 Z1.28
G1 E.4 F1800
G1 F1500
M204 S500
G1 X84.583 Y96.956 E.00429
G1 X84.941 Y96.544 E.01155
G1 X86.853 Y96.544 E.04046
G1 X87.196 Y96.916 E.0107
G1 X87.09 Y97.081 E.00416
G1 X86.697 Y96.953 E.00874
G1 X86.324 Y96.88 E.00804
G1 X85.794 Y96.856 E.01123
G1 X85.268 Y96.928 E.01124
G1 X84.903 Y97.034 E.00804
G1 X84.758 Y97.096 E.00335
; WIPE_START
M204 S6000
G1 X84.583 Y96.956 E-.04255
G1 X84.941 Y96.544 E-.10364
G1 X86.172 Y96.544 E-.23381
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X84.853 Y102.286 Z1.68 F18000
G1 Z1.28
G1 E.4 F1800
G1 F1500
M204 S500
G1 X84.486 Y102.089 E.00881
G1 X84.119 Y101.796 E.00995
G1 X83.816 Y101.449 E.00975
G1 X83.643 Y101.178 E.00681
G1 X83.513 Y100.912 E.00627
G1 X83.366 Y100.448 E.01028
G1 X83.31 Y99.979 E.01
G1 X83.338 Y99.519 E.00975
G1 X83.404 Y99.205 E.00681
G1 X83.499 Y98.924 E.00626
G1 X83.72 Y98.491 E.01028
G1 X84.009 Y98.118 E.01
G1 X84.358 Y97.803 E.00995
G1 X84.75 Y97.561 E.00975
G1 X85.047 Y97.434 E.00683
G1 X85.356 Y97.344 E.00683
G1 X85.813 Y97.282 E.00976
G1 X86.273 Y97.302 E.00975
G1 X86.59 Y97.365 E.00683
G1 X86.897 Y97.465 E.00683
G1 X87.309 Y97.671 E.00975
G1 X87.677 Y97.947 E.00975
G1 X87.904 Y98.177 E.00683
G1 X88.101 Y98.432 E.00683
G1 X88.321 Y98.826 E.00956
G1 X88.435 Y99.129 E.00683
G1 X88.511 Y99.442 E.00683
G1 X88.552 Y99.901 E.00975
G1 X88.51 Y100.371 E.01
G1 X88.377 Y100.839 E.01028
G1 X88.256 Y101.109 E.00627
G1 X88.091 Y101.385 E.00681
G1 X87.798 Y101.741 E.00975
G1 X87.447 Y102.039 E.00975
G1 X87.173 Y102.208 E.00681
G1 X86.905 Y102.333 E.00627
G1 X86.44 Y102.473 E.01028
G1 X85.979 Y102.521 E.0098
G1 X85.658 Y102.507 E.0068
G1 X85.366 Y102.459 E.00627
G1 X84.906 Y102.314 E.01021
M204 S250
G1 X85.047 Y101.926 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X84.713 Y101.746 E.00746
G1 X84.403 Y101.499 E.0078
G1 X84.144 Y101.203 E.00773
G1 X84 Y100.978 E.00526
G1 X83.894 Y100.76 E.00477
G1 X83.768 Y100.361 E.00822
G1 X83.721 Y99.967 E.00781
G1 X83.744 Y99.574 E.00774
G1 X83.8 Y99.313 E.00525
G1 X83.877 Y99.084 E.00477
G1 X84.067 Y98.711 E.00822
M73 P48 R12
G1 X84.31 Y98.397 E.00781
G1 X84.604 Y98.132 E.0078
G1 X84.939 Y97.925 E.00773
G1 X85.185 Y97.82 E.00526
G1 X85.442 Y97.745 E.00526
G1 X85.831 Y97.692 E.00774
G1 X86.224 Y97.71 E.00773
G1 X86.487 Y97.762 E.00526
G1 X86.741 Y97.844 E.00526
G1 X87.093 Y98.02 E.00774
G1 X87.407 Y98.256 E.00773
G1 X87.595 Y98.447 E.00526
G1 X87.759 Y98.658 E.00526
G1 X87.949 Y98.999 E.00767
G1 X88.043 Y99.249 E.00526
G1 X88.106 Y99.509 E.00526
G1 X88.141 Y99.901 E.00773
G1 X88.106 Y100.296 E.00781
G1 X87.992 Y100.698 E.00822
G1 X87.892 Y100.919 E.00477
G1 X87.755 Y101.149 E.00525
G1 X87.506 Y101.452 E.00773
G1 X87.206 Y101.707 E.00773
G1 X86.978 Y101.847 E.00526
G1 X86.759 Y101.95 E.00477
G1 X86.359 Y102.07 E.00821
G1 X85.967 Y102.111 E.00775
G1 X85.7 Y102.099 E.00525
G1 X85.461 Y102.06 E.00477
G1 X85.102 Y101.947 E.00739
; WIPE_START
M204 S6000
G1 X84.713 Y101.746 E-.08332
G1 X84.403 Y101.499 E-.07533
G1 X84.144 Y101.203 E-.07468
G1 X84 Y100.978 E-.05078
G1 X83.894 Y100.76 E-.04606
G1 X83.815 Y100.51 E-.04983
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X90.235 Y96.382 Z1.68 F18000
G1 X98.177 Y91.275 Z1.68
G1 Z1.28
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X98.379 Y91.416 E.00522
G1 X95.332 Y95.768 E.11245
G1 X93.972 Y94.816 E.03514
G1 X93.202 Y95.636 E.0238
G1 X92.957 Y95.743 E.00565
G1 X92.98 Y95.48 E.00558
G1 X93.487 Y94.476 E.02379
G1 X92.126 Y93.524 E.03514
G1 X95.174 Y89.172 E.11245
G1 X98.128 Y91.24 E.07633
; WIPE_START
M204 S6000
G1 X98.379 Y91.416 E-.05824
G1 X97.408 Y92.803 E-.32176
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X90.022 Y94.73 Z1.68 F18000
G1 X84.691 Y96.12 Z1.68
G1 Z1.28
G1 E.4 F1800
G1 F1500
M204 S500
G1 X92.5 Y96.12 E.16527
G1 X92.577 Y95.335 E.0167
G1 X92.942 Y94.613 E.01712
G1 X91.536 Y93.628 E.03634
G1 X97.307 Y85.386 E.21296
G1 X97.521 Y85.536 E.00554
G1 X95.284 Y88.731 E.08255
G1 X98.756 Y91.162 E.08971
G1 X100.993 Y87.967 E.08255
G1 X101.207 Y88.117 E.00554
G1 X95.436 Y96.359 E.21296
G1 X94.029 Y95.374 E.03635
G1 X93.477 Y95.963 E.01709
G1 X93.186 Y96.105 E.00685
G1 X92.902 Y96.341 E.00782
G1 X92.784 Y96.404 E.00283
G1 X92.573 Y96.467 E.00465
G1 X92.404 Y96.482 E.00359
G1 X87.372 Y96.482 E.10649
G1 X88.475 Y97.675 E.03439
G1 X88.725 Y98 E.00869
G1 X89.015 Y98.517 E.01254
G1 X89.159 Y98.901 E.00868
G1 X89.257 Y99.3 E.00869
G1 X89.304 Y99.68 E.00811
G1 X89.289 Y100.283 E.01275
G1 X89.227 Y100.642 E.00772
G1 X89.1 Y101.073 E.00951
G1 X88.847 Y101.609 E.01255
G1 X88.499 Y102.098 E.01271
G1 X88.215 Y102.391 E.00862
G1 X87.897 Y102.65 E.00868
G1 X87.379 Y102.955 E.01273
G1 X86.815 Y103.163 E.01273
G1 X86.222 Y103.269 E.01273
G1 X85.63 Y103.267 E.01254
G1 X85.038 Y103.161 E.01273
G1 X84.515 Y102.969 E.01178
G1 X84.121 Y102.755 E.00949
G1 X83.797 Y102.522 E.00844
G1 X83.502 Y102.251 E.00849
G1 X83.24 Y101.947 E.00849
G1 X83.017 Y101.613 E.0085
G1 X82.834 Y101.256 E.00849
G1 X82.696 Y100.879 E.00849
G1 X82.574 Y100.299 E.01255
G1 X82.552 Y99.935 E.00772
G1 X82.576 Y99.487 E.00949
G1 X82.648 Y99.095 E.00844
G1 X82.767 Y98.712 E.00849
G1 X82.93 Y98.345 E.00849
G1 X83.248 Y97.845 E.01254
G1 X84.434 Y96.482 E.03824
G1 X79.467 Y96.482 E.10513
G1 X79.228 Y96.454 E.00508
G1 X78.955 Y96.34 E.00627
G1 X78.754 Y96.162 E.00568
G1 X78.627 Y95.957 E.0051
G1 X78.579 Y95.812 E.00324
G1 X78.55 Y95.565 E.00527
G1 X78.55 Y77.628 E.37965
G1 X78.588 Y77.349 E.00597
G1 X78.697 Y77.118 E.00539
G1 X78.859 Y76.933 E.0052
G1 X78.993 Y76.839 E.00346
G1 X79.125 Y76.777 E.00311
G1 X79.389 Y76.723 E.00569
G1 X92.411 Y76.721 E.27563
G1 X92.64 Y76.749 E.0049
G1 X92.779 Y76.794 E.00308
G1 X92.955 Y76.889 E.00424
G1 X92.906 Y77.082 E.0042
G1 X79.856 Y77.082 E.27622
G1 X79.485 Y77.172 E.00808
G1 X79.233 Y77.351 E.00654
G1 X79.07 Y77.546 E.00539
G1 X78.948 Y77.807 E.0061
G1 X78.911 Y78.056 E.00532
G1 X78.911 Y95.155 E.36192
G1 X78.964 Y95.453 E.0064
G1 X79.152 Y95.778 E.00795
G1 X79.512 Y96.047 E.00952
G1 X79.867 Y96.12 E.00767
G1 X84.631 Y96.12 E.10083
; WIPE_START
M204 S6000
G1 X86.631 Y96.12 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X83.535 Y96.891 Z1.68 F18000
G1 Z1.28
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X79.443 Y96.891 E.08049
G1 X79.133 Y96.855 E.00613
G1 X78.846 Y96.75 E.006
G1 X78.724 Y96.68 E.00277
G1 X78.544 Y96.537 E.00452
G1 X78.435 Y96.419 E.00317
G1 X78.312 Y96.243 E.00421
G1 X78.248 Y96.114 E.00284
G1 X78.177 Y95.901 E.00442
G1 X78.141 Y95.589 E.00619
G1 X78.141 Y77.61 E.35362
G1 X78.161 Y77.374 E.00466
G1 X78.195 Y77.231 E.00289
G1 X78.245 Y77.093 E.00289
G1 X78.353 Y76.892 E.00448
G1 X78.495 Y76.714 E.00448
G1 X78.599 Y76.615 E.00283
G1 X78.786 Y76.484 E.00449
G1 X78.977 Y76.394 E.00415
G1 X79.131 Y76.347 E.00317
G1 X79.359 Y76.313 E.00453
G1 X92.436 Y76.311 E.25721
G1 X92.73 Y76.347 E.00584
G1 X92.941 Y76.417 E.00437
G1 X93.139 Y76.524 E.00442
G1 X93.315 Y76.663 E.00442
G1 X93.465 Y76.831 E.00442
G1 X93.583 Y77.022 E.00442
G1 X93.666 Y77.231 E.00442
G1 X93.71 Y77.448 E.00436
G1 X93.72 Y88.791 E.2231
G1 X92.541 Y88.791 E.02321
G1 X92.541 Y77.491 E.22226
G1 X79.905 Y77.491 E.24852
G1 X79.658 Y77.551 E.005
G1 X79.513 Y77.654 E.00351
G1 X79.418 Y77.767 E.00291
G1 X79.344 Y77.925 E.00343
G1 X79.321 Y78.086 E.00318
G1 X79.321 Y95.119 E.33504
G1 X79.354 Y95.311 E.00383
G1 X79.464 Y95.501 E.00431
G1 X79.684 Y95.664 E.0054
G1 X79.909 Y95.711 E.00452
G1 X92.124 Y95.711 E.24025
G1 X92.155 Y95.334 E.00744
G1 X92.192 Y95.191 E.0029
G1 X92.417 Y94.745 E.00983
G1 X90.966 Y93.729 E.03485
G1 X97.206 Y84.816 E.214
G1 X101.777 Y88.017 E.10975
G1 X95.536 Y96.929 E.214
G1 X94.085 Y95.913 E.03485
G1 X93.743 Y96.277 E.00983
G1 X93.604 Y96.369 E.00326
G1 X93.403 Y96.457 E.00432
G1 X93.131 Y96.683 E.00695
G1 X92.94 Y96.785 E.00426
G1 X92.65 Y96.871 E.00596
G1 X92.421 Y96.891 E.0045
G1 X88.307 Y96.891 E.08092
G1 X88.788 Y97.411 E.01393
G1 X89.064 Y97.77 E.00891
G1 X89.296 Y98.159 E.00891
G1 X89.391 Y98.356 E.00431
G1 X89.551 Y98.78 E.00891
G1 X89.659 Y99.22 E.00891
G1 X89.713 Y99.661 E.00873
G1 X89.714 Y100.117 E.00897
G1 X89.695 Y100.335 E.00431
G1 X89.626 Y100.735 E.00798
G1 X89.486 Y101.213 E.0098
G1 X89.325 Y101.584 E.00796
G1 X89.199 Y101.82 E.00525
G1 X88.973 Y102.159 E.00802
G1 X88.807 Y102.368 E.00525
G1 X88.493 Y102.693 E.00889
G1 X88.142 Y102.979 E.0089
G1 X87.96 Y103.102 E.00431
G1 X87.561 Y103.322 E.00897
G1 X87.361 Y103.411 E.00431
G1 X86.929 Y103.557 E.00897
G1 X86.716 Y103.608 E.00431
G1 X86.265 Y103.676 E.00897
G1 X86.046 Y103.689 E.00431
G1 X85.593 Y103.676 E.00891
G1 X85.145 Y103.608 E.00891
G1 X84.929 Y103.556 E.00437
G1 X84.717 Y103.491 E.00437
G1 X84.341 Y103.34 E.00798
G1 X83.903 Y103.103 E.00979
G1 X83.539 Y102.84 E.00883
G1 X83.207 Y102.536 E.00885
G1 X82.914 Y102.195 E.00885
G1 X82.663 Y101.821 E.00885
G1 X82.459 Y101.42 E.00885
G1 X82.303 Y100.998 E.00885
G1 X82.198 Y100.557 E.00891
M73 P49 R12
G1 X82.166 Y100.341 E.0043
G1 X82.142 Y99.936 E.00798
G1 X82.169 Y99.439 E.00979
G1 X82.25 Y98.997 E.00883
G1 X82.383 Y98.567 E.00885
G1 X82.566 Y98.156 E.00885
G1 X82.799 Y97.767 E.00891
G1 X82.927 Y97.59 E.0043
G1 X83.496 Y96.936 E.01704
; WIPE_START
M204 S6000
G1 X81.496 Y96.914 E-.38
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




G1 X79.376 Y96.249
G1 Z1.28
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.144737
G1 F1500
M204 S6000
G1 X79.143 Y96.123 E.00157
G1 X78.957 Y95.967 E.00144
G1 X78.878 Y95.849 E.00085
G1 X78.778 Y95.627 E.00144
; WIPE_START
G1 X78.878 Y95.849 E-.10348
G1 X78.957 Y95.967 E-.06066
G1 X79.143 Y96.123 E-.10338
G1 X79.376 Y96.249 E-.11249
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X84.474 Y97.167 Z1.68 F18000
G1 Z1.28
G1 E.4 F1800
; LINE_WIDTH: 0.47521
G1 F1500
M204 S6000
G1 X84.3 Y97.315 E.00513
; LINE_WIDTH: 0.438823
G1 X84.099 Y97.487 E.00545
; LINE_WIDTH: 0.401764
G1 X83.921 Y97.669 E.00477
; LINE_WIDTH: 0.359846
G1 X83.723 Y97.872 E.00473
G1 X83.397 Y98.305 E.00902
G1 X83.146 Y98.789 E.00909
G1 X83.019 Y99.186 E.00695
G1 X82.955 Y99.532 E.00587
G1 X82.934 Y100.005 E.0079
G1 X83.005 Y100.542 E.00902
G1 X83.166 Y101.063 E.00909
G1 X83.346 Y101.42 E.00666
G1 X83.544 Y101.716 E.00594
G1 X83.869 Y102.078 E.00812
G1 X84.291 Y102.412 E.00896
G1 X84.742 Y102.653 E.00852
G1 X85.139 Y102.79 E.007
G1 X85.629 Y102.884 E.00831
G1 X85.978 Y102.895 E.00583
G1 X86.186 Y102.886 E.00346
G1 X86.711 Y102.793 E.00889
G1 X87.214 Y102.61 E.00892
G1 X87.657 Y102.349 E.00858
G1 X88.056 Y102.015 E.00867
G1 X88.332 Y101.693 E.00707
G1 X88.587 Y101.293 E.00792
G1 X88.738 Y100.957 E.00613
G1 X88.876 Y100.455 E.00869
G1 X88.921 Y100.081 E.00627
G1 X88.905 Y99.536 E.00909
G1 X88.799 Y99.027 E.00867
G1 X88.656 Y98.658 E.00659
G1 X88.411 Y98.214 E.00845
G1 X88.184 Y97.921 E.00618
G1 X87.922 Y97.647 E.00632
; LINE_WIDTH: 0.397665
G1 X87.737 Y97.48 E.00462
; LINE_WIDTH: 0.442841
G1 X87.553 Y97.314 E.00518
; LINE_WIDTH: 0.480643
G1 X87.311 Y97.129 E.0069
; WIPE_START
G1 X87.553 Y97.314 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X92.72 Y96.198 Z1.68 F18000
G1 Z1.28
G1 E.4 F1800
; LINE_WIDTH: 0.109443
G1 F1500
M204 S6000
G1 X92.764 Y96.114 E.00039
G1 X92.932 Y96.011 E.00082
; WIPE_START
G1 X92.764 Y96.114 E-.25699
G1 X92.72 Y96.198 E-.12301
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X93.497 Y94.978 Z1.68 F18000
G1 Z1.28
G1 E.4 F1800
; LINE_WIDTH: 0.10319
G1 F1500
M204 S6000
G1 X93.615 Y94.81 E.0008
; LINE_WIDTH: 0.150051
G1 X93.733 Y94.641 E.00128
; LINE_WIDTH: 0.196911
G1 X93.851 Y94.472 E.00176
; WIPE_START
G1 X93.733 Y94.641 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X92.696 Y93.423 Z1.68 F18000
G1 Z1.28
G1 E.4 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.419992
G1 F1500
M204 S6000
G1 X93.548 Y94.02 E.02044
G1 X93.697 Y93.924 E.00349
G1 X93.831 Y93.959 E.00271
G1 X94.34 Y94.315 E.01222
G1 X94.418 Y94.429 E.00271
G1 X94.392 Y94.611 E.00361
G1 X95.231 Y95.198 E.02015
G1 X97.809 Y91.517 E.0884
G1 X95.274 Y89.742 E.06087
G1 X92.731 Y93.374 E.08722
M204 S10000
G1 X93.245 Y93.327 F18000
G1 F1500
M204 S6000
G1 X93.593 Y93.57 E.00834
G1 X93.656 Y93.532 E.00145
G1 X94.057 Y93.636 E.00814
G1 X94.566 Y93.992 E.01222
G1 X94.801 Y94.333 E.00814
G1 X94.787 Y94.406 E.00145
G1 X95.134 Y94.649 E.00834
G1 X97.26 Y91.613 E.07289
G1 X95.371 Y90.291 E.04536
G1 X93.28 Y93.277 E.07171
M204 S10000
G1 X93.82 Y93.193 F18000
G1 F1500
M204 S6000
G1 X94.283 Y93.313 E.00941
G1 X94.792 Y93.669 E.01222
G1 X95.063 Y94.064 E.00941
G1 X96.711 Y91.71 E.05651
G1 X95.468 Y90.84 E.02985
G1 X93.855 Y93.144 E.05533
M204 S10000
G1 X94.454 Y92.976 F18000
G1 F1500
M204 S6000
G1 X95.018 Y93.346 E.01329
G1 X95.051 Y93.394 E.00113
G1 X96.162 Y91.807 E.0381
G1 X95.565 Y91.389 E.01434
G1 X94.488 Y92.927 E.03692
M204 S10000
G1 X94.973 Y92.87 F18000
; LINE_WIDTH: 0.360602
G1 F1500
M204 S6000
G1 X95.62 Y91.946 E.01884
; WIPE_START
G1 X94.973 Y92.87 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X97.699 Y85.741 Z1.68 F18000
G1 X97.786 Y85.515 Z1.68
G1 Z1.28
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.0965003
G1 F1500
M204 S6000
G1 X100.922 Y87.711 E.01352
; WIPE_START
G1 X99.284 Y86.564 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X92.412 Y83.242 Z1.68 F18000
G1 X79.376 Y76.939 Z1.68
G1 Z1.28
G1 E.4 F1800
; LINE_WIDTH: 0.150452
G1 F1500
M204 S6000
G1 X79.039 Y77.152 E.00248
G1 X78.845 Y77.41 E.00201
; LINE_WIDTH: 0.103751
G1 X78.788 Y77.595 E.00075
; CHANGE_LAYER
; Z_HEIGHT: 1.4
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F1500
G1 X78.845 Y77.41 E-.38
; WIPE_END
G1 E-.02 F1800
; layer num/total_layer_count: 11/49
; update layer progress
M73 L11
M991 S0 P10 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z1.68 I-.524 J1.098 P1  F18000
G1 X100.617 Y87.791 Z1.68
G1 Z1.4
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X98.655 Y90.592 E.06727
G1 X95.854 Y88.63 E.06727
G1 X96.254 Y88.059 E.01372
G1 X97.815 Y85.829 E.05355
G1 X100.568 Y87.756 E.06609
; WIPE_START
M204 S6000
G1 X99.45 Y89.414 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X95.09 Y83.149 Z1.8 F18000
G1 X93.304 Y80.581 Z1.8
G1 Z1.4
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X93.311 Y88.382 E.1651
G1 X92.95 Y88.382 E.00764
G1 X92.95 Y77.128 E.23818
G1 X93.135 Y77.076 E.00407
G1 X93.216 Y77.207 E.00325
G1 X93.272 Y77.349 E.00324
G1 X93.301 Y77.49 E.00306
G1 X93.304 Y80.521 E.06415
; WIPE_START
M204 S6000
G1 X93.306 Y82.521 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X89.431 Y89.097 Z1.8 F18000
G1 X84.703 Y97.12 Z1.8
G1 Z1.4
G1 E.4 F1800
G1 F1500
M204 S500
G1 X84.583 Y96.956 E.00429
G1 X84.941 Y96.544 E.01155
G1 X86.92 Y96.544 E.04188
G1 X87.285 Y96.964 E.01176
G1 X87.165 Y97.128 E.00429
G1 X86.872 Y97.002 E.00674
G1 X86.34 Y96.881 E.01157
G1 X85.794 Y96.856 E.01156
G1 X85.268 Y96.928 E.01124
G1 X84.903 Y97.034 E.00803
G1 X84.758 Y97.096 E.00335
; WIPE_START
M204 S6000
G1 X84.583 Y96.956 E-.04255
G1 X84.941 Y96.544 E-.10364
G1 X86.172 Y96.544 E-.23381
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X84.852 Y102.286 Z1.8 F18000
G1 Z1.4
G1 E.4 F1800
G1 F1500
M204 S500
G1 X84.486 Y102.089 E.0088
G1 X84.119 Y101.796 E.00995
G1 X83.816 Y101.449 E.00975
G1 X83.643 Y101.178 E.00681
G1 X83.514 Y100.914 E.00621
G1 X83.366 Y100.449 E.01034
G1 X83.31 Y99.979 E.01
G1 X83.338 Y99.519 E.00975
G1 X83.404 Y99.205 E.00681
G1 X83.498 Y98.927 E.00621
G1 X83.72 Y98.491 E.01034
G1 X84.009 Y98.118 E.01
G1 X84.358 Y97.803 E.00995
G1 X84.75 Y97.561 E.00975
G1 X85.047 Y97.434 E.00683
G1 X85.356 Y97.344 E.00682
G1 X85.813 Y97.282 E.00976
G1 X86.282 Y97.303 E.00995
G1 X86.741 Y97.407 E.00995
G1 X87.163 Y97.588 E.00972
G1 X87.413 Y97.741 E.00621
G1 X87.689 Y97.957 E.00742
G1 X87.998 Y98.29 E.00962
G1 X88.18 Y98.557 E.00683
G1 X88.324 Y98.835 E.00664
G1 X88.434 Y99.128 E.00661
G1 X88.505 Y99.412 E.00621
G1 X88.553 Y99.901 E.01039
G1 X88.505 Y100.39 E.01039
G1 X88.434 Y100.674 E.00621
G1 X88.321 Y100.975 E.00681
G1 X88.097 Y101.378 E.00975
G1 X87.798 Y101.741 E.00995
G1 X87.447 Y102.039 E.00975
G1 X87.173 Y102.208 E.0068
G1 X86.907 Y102.332 E.00621
G1 X86.44 Y102.473 E.01034
G1 X85.979 Y102.521 E.00981
G1 X85.658 Y102.507 E.0068
G1 X85.368 Y102.46 E.00621
G1 X84.905 Y102.314 E.01028
M204 S250
G1 X85.046 Y101.925 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X84.712 Y101.746 E.00745
G1 X84.403 Y101.499 E.00779
G1 X84.144 Y101.203 E.00773
G1 X84 Y100.978 E.00526
G1 X83.895 Y100.762 E.00472
G1 X83.768 Y100.361 E.00826
G1 X83.721 Y99.967 E.00781
G1 X83.744 Y99.574 E.00774
G1 X83.8 Y99.313 E.00525
G1 X83.876 Y99.086 E.00472
G1 X84.067 Y98.711 E.00826
G1 X84.31 Y98.397 E.00781
G1 X84.604 Y98.132 E.0078
G1 X84.939 Y97.925 E.00773
G1 X85.185 Y97.82 E.00526
G1 X85.442 Y97.745 E.00526
G1 X85.831 Y97.692 E.00774
G1 X86.227 Y97.71 E.00779
G1 X86.614 Y97.798 E.0078
G1 X86.975 Y97.953 E.00772
G1 X87.179 Y98.078 E.00472
G1 X87.411 Y98.26 E.00579
G1 X87.677 Y98.546 E.00769
G1 X87.828 Y98.767 E.00526
G1 X87.95 Y99.002 E.0052
G1 X88.043 Y99.249 E.00519
G1 X88.1 Y99.482 E.00472
G1 X88.142 Y99.901 E.00828
G1 X88.1 Y100.32 E.00828
G1 X88.043 Y100.553 E.00472
G1 X87.949 Y100.803 E.00525
G1 X87.757 Y101.146 E.00774
G1 X87.506 Y101.452 E.0078
G1 X87.205 Y101.707 E.00774
G1 X86.978 Y101.847 E.00525
G1 X86.761 Y101.949 E.00472
G1 X86.359 Y102.07 E.00826
G1 X85.967 Y102.111 E.00775
G1 X85.7 Y102.099 E.00525
G1 X85.463 Y102.061 E.00472
G1 X85.102 Y101.947 E.00745
; WIPE_START
M204 S6000
G1 X84.712 Y101.746 E-.08323
G1 X84.403 Y101.499 E-.07528
G1 X84.144 Y101.203 E-.07468
G1 X84 Y100.978 E-.0508
G1 X83.895 Y100.762 E-.04557
G1 X83.815 Y100.509 E-.05043
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X90.235 Y96.381 Z1.8 F18000
G1 X98.177 Y91.275 Z1.8
G1 Z1.4
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X98.379 Y91.416 E.00522
G1 X95.332 Y95.768 E.11246
G1 X93.972 Y94.816 E.03515
G1 X93.202 Y95.636 E.0238
G1 X92.95 Y95.746 E.00583
G1 X92.994 Y95.431 E.00673
G1 X93.534 Y94.51 E.02261
G1 X92.126 Y93.524 E.03638
G1 X95.174 Y89.172 E.11245
G1 X98.128 Y91.24 E.07633
; WIPE_START
M204 S6000
G1 X98.379 Y91.416 E-.05824
G1 X97.408 Y92.803 E-.32176
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X90.023 Y94.73 Z1.8 F18000
G1 X84.691 Y96.12 Z1.8
G1 Z1.4
G1 E.4 F1800
G1 F1500
M204 S500
G1 X92.468 Y96.12 E.1646
G1 X92.581 Y95.324 E.01703
G1 X92.971 Y94.633 E.01678
G1 X91.536 Y93.628 E.03708
G1 X97.307 Y85.386 E.21296
G1 X97.521 Y85.536 E.00554
G1 X95.284 Y88.731 E.08255
G1 X98.756 Y91.162 E.08971
G1 X100.993 Y87.967 E.08255
G1 X101.207 Y88.117 E.00554
G1 X95.436 Y96.359 E.21296
G1 X94.029 Y95.374 E.03635
G1 X93.477 Y95.963 E.01708
G1 X93.186 Y96.105 E.00685
G1 X92.904 Y96.34 E.00777
G1 X92.769 Y96.41 E.00321
G1 X92.574 Y96.467 E.0043
G1 X92.404 Y96.482 E.00362
G1 X87.428 Y96.482 E.10532
G1 X88.614 Y97.845 E.03825
G1 X88.721 Y97.992 E.00385
G1 X88.935 Y98.353 E.00888
G1 X89.159 Y98.901 E.01254
G1 X89.286 Y99.49 E.01274
G1 X89.305 Y100.091 E.01273
G1 X89.259 Y100.49 E.00851
G1 X89.101 Y101.073 E.01278
G1 X88.844 Y101.613 E.01266
G1 X88.621 Y101.947 E.0085
G1 X88.353 Y102.258 E.00869
G1 X87.936 Y102.621 E.01171
G1 X87.742 Y102.754 E.00498
G1 X87.422 Y102.933 E.00777
G1 X87.209 Y103.03 E.00495
G1 X86.815 Y103.163 E.00881
G1 X86.222 Y103.269 E.01273
G1 X85.63 Y103.267 E.01254
G1 X85.047 Y103.164 E.01254
G1 X84.661 Y103.033 E.00863
G1 X84.254 Y102.834 E.00959
G1 X83.804 Y102.528 E.0115
G1 X83.502 Y102.251 E.00869
G1 X83.24 Y101.947 E.00849
G1 X83.017 Y101.613 E.00849
G1 X82.834 Y101.256 E.00849
G1 X82.696 Y100.88 E.00849
G1 X82.574 Y100.299 E.01256
G1 X82.552 Y99.939 E.00762
G1 X82.577 Y99.487 E.00959
G1 X82.648 Y99.095 E.00843
G1 X82.767 Y98.712 E.00849
G1 X82.934 Y98.336 E.00869
G1 X83.254 Y97.838 E.01253
G1 X84.434 Y96.482 E.03805
G1 X79.467 Y96.482 E.10513
G1 X79.218 Y96.453 E.0053
G1 X79.088 Y96.41 E.00289
G1 X78.913 Y96.311 E.00426
G1 X78.8 Y96.211 E.00319
G1 X78.659 Y96.018 E.00507
G1 X78.58 Y95.821 E.00449
G1 X78.55 Y95.565 E.00546
G1 X78.55 Y77.628 E.37965
G1 X78.586 Y77.356 E.00581
G1 X78.693 Y77.123 E.00542
G1 X78.793 Y76.997 E.00341
G1 X78.901 Y76.9 E.00308
G1 X79.13 Y76.775 E.00552
G1 X79.379 Y76.723 E.00539
G1 X92.412 Y76.721 E.27585
G1 X92.64 Y76.749 E.00486
G1 X92.779 Y76.794 E.00308
G1 X92.955 Y76.889 E.00424
G1 X92.906 Y77.082 E.0042
G1 X79.892 Y77.082 E.27546
M73 P50 R12
G1 X79.677 Y77.108 E.0046
G1 X79.391 Y77.224 E.00652
G1 X79.085 Y77.512 E.00889
G1 X78.948 Y77.806 E.00688
G1 X78.911 Y78.056 E.00533
G1 X78.911 Y95.155 E.36192
G1 X78.964 Y95.453 E.00639
G1 X79.151 Y95.777 E.00792
G1 X79.504 Y96.043 E.00936
G1 X79.865 Y96.12 E.00781
G1 X84.631 Y96.12 E.10088
; WIPE_START
M204 S6000
G1 X86.631 Y96.12 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X83.535 Y96.891 Z1.8 F18000
G1 Z1.4
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X79.443 Y96.891 E.08049
G1 X79.13 Y96.854 E.0062
G1 X78.934 Y96.79 E.00405
G1 X78.785 Y96.717 E.00326
G1 X78.663 Y96.637 E.00288
G1 X78.496 Y96.488 E.0044
G1 X78.304 Y96.227 E.00638
G1 X78.177 Y95.904 E.00681
G1 X78.141 Y95.589 E.00625
G1 X78.141 Y77.61 E.35362
G1 X78.161 Y77.374 E.00466
G1 X78.195 Y77.234 E.00284
G1 X78.272 Y77.036 E.00418
G1 X78.352 Y76.894 E.0032
G1 X78.493 Y76.716 E.00447
G1 X78.649 Y76.576 E.00412
G1 X78.784 Y76.485 E.0032
G1 X78.99 Y76.389 E.00447
G1 X79.21 Y76.33 E.00448
G1 X79.356 Y76.313 E.00289
G1 X92.437 Y76.311 E.2573
G1 X92.73 Y76.347 E.00581
G1 X92.941 Y76.417 E.00437
G1 X93.139 Y76.524 E.00442
G1 X93.315 Y76.663 E.00442
G1 X93.465 Y76.831 E.00442
G1 X93.583 Y77.022 E.00442
G1 X93.666 Y77.231 E.00442
G1 X93.71 Y77.448 E.00436
G1 X93.72 Y88.791 E.2231
G1 X92.541 Y88.791 E.02321
G1 X92.541 Y77.491 E.22226
G1 X79.918 Y77.491 E.24828
G1 X79.78 Y77.508 E.00272
G1 X79.615 Y77.574 E.0035
G1 X79.423 Y77.756 E.0052
G1 X79.344 Y77.925 E.00367
G1 X79.321 Y78.086 E.00319
G1 X79.321 Y95.119 E.33504
G1 X79.354 Y95.31 E.00382
G1 X79.464 Y95.5 E.0043
G1 X79.678 Y95.662 E.00528
G1 X79.908 Y95.711 E.00463
G1 X92.113 Y95.711 E.24005
G1 X92.183 Y95.22 E.00975
G1 X92.24 Y95.069 E.00318
G1 X92.427 Y94.752 E.00724
G1 X90.966 Y93.729 E.03508
G1 X97.206 Y84.816 E.214
G1 X101.777 Y88.017 E.10975
G1 X95.536 Y96.929 E.214
G1 X94.085 Y95.913 E.03485
G1 X93.743 Y96.277 E.00983
G1 X93.605 Y96.369 E.00327
G1 X93.403 Y96.457 E.00432
G1 X93.132 Y96.682 E.00694
G1 X92.923 Y96.792 E.00463
G1 X92.65 Y96.871 E.0056
G1 X92.421 Y96.891 E.00451
G1 X88.326 Y96.891 E.08055
G1 X88.934 Y97.59 E.01823
G1 X89.063 Y97.767 E.0043
G1 X89.296 Y98.159 E.00897
G1 X89.391 Y98.356 E.00431
G1 X89.551 Y98.78 E.00891
G1 X89.659 Y99.22 E.00891
G1 X89.713 Y99.661 E.00873
G1 X89.714 Y100.114 E.00891
G1 X89.662 Y100.561 E.00885
G1 X89.571 Y100.952 E.0079
G1 X89.404 Y101.417 E.00973
G1 X89.198 Y101.821 E.00891
G1 X88.947 Y102.195 E.00885
G1 X88.652 Y102.538 E.00891
G1 X88.495 Y102.691 E.00432
G1 X88.182 Y102.948 E.00795
G1 X87.959 Y103.102 E.00534
G1 X87.607 Y103.299 E.00793
G1 X87.36 Y103.411 E.00533
G1 X86.929 Y103.557 E.00895
G1 X86.716 Y103.609 E.00431
G1 X86.265 Y103.676 E.00897
G1 X86.046 Y103.689 E.00431
G1 X85.593 Y103.676 E.00891
G1 X85.145 Y103.608 E.00891
G1 X84.933 Y103.557 E.00431
G1 X84.504 Y103.412 E.00889
G1 X84.053 Y103.191 E.00988
G1 X83.715 Y102.976 E.00789
G1 X83.541 Y102.842 E.00431
G1 X83.207 Y102.536 E.00891
G1 X82.914 Y102.195 E.00885
G1 X82.663 Y101.821 E.00885
G1 X82.459 Y101.42 E.00885
G1 X82.303 Y100.998 E.00885
G1 X82.198 Y100.557 E.00891
G1 X82.166 Y100.341 E.00431
G1 X82.142 Y99.94 E.00789
G1 X82.169 Y99.439 E.00988
G1 X82.25 Y98.997 E.00883
G1 X82.383 Y98.567 E.00885
G1 X82.568 Y98.153 E.00891
G1 X82.674 Y97.962 E.0043
G1 X82.929 Y97.588 E.00891
G1 X83.496 Y96.936 E.01698
; WIPE_START
M204 S6000
G1 X81.496 Y96.914 E-.38
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




G1 X79.341 Y96.251
G1 Z1.4
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.156091
G1 F1500
M204 S6000
G1 X79.009 Y96.021 E.00262
G1 X78.94 Y95.948 E.00065
G1 X78.855 Y95.803 E.00109
; LINE_WIDTH: 0.12408
G1 X78.824 Y95.712 E.00047
; LINE_WIDTH: 0.0938165
G1 X78.792 Y95.622 E.00033
; WIPE_START
G1 X78.824 Y95.712 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X84.474 Y97.167 Z1.8 F18000
G1 Z1.4
G1 E.4 F1800
; LINE_WIDTH: 0.475193
G1 F1500
M204 S6000
G1 X84.3 Y97.315 E.00513
; LINE_WIDTH: 0.438817
G1 X84.099 Y97.487 E.00545
; LINE_WIDTH: 0.401765
G1 X83.921 Y97.669 E.00478
; LINE_WIDTH: 0.360287
G1 X83.723 Y97.872 E.00474
G1 X83.393 Y98.303 E.00905
G1 X83.146 Y98.792 E.00914
G1 X83.019 Y99.186 E.00691
G1 X82.955 Y99.532 E.00587
G1 X82.935 Y100.005 E.00791
G1 X82.995 Y100.513 E.00854
G1 X83.167 Y101.066 E.00965
G1 X83.346 Y101.42 E.00662
G1 X83.544 Y101.716 E.00594
G1 X83.849 Y102.057 E.00764
G1 X84.291 Y102.411 E.00945
G1 X84.77 Y102.666 E.00906
G1 X85.269 Y102.825 E.00874
G1 X85.629 Y102.884 E.00608
G1 X86.003 Y102.9 E.00625
G1 X86.528 Y102.836 E.00884
G1 X87.031 Y102.69 E.00874
G1 X87.344 Y102.544 E.00576
G1 X87.679 Y102.338 E.00657
G1 X88.079 Y101.996 E.00877
G1 X88.315 Y101.714 E.00614
G1 X88.512 Y101.421 E.0059
G1 X88.742 Y100.942 E.00886
G1 X88.88 Y100.442 E.00866
G1 X88.921 Y100.069 E.00626
G1 X88.919 Y99.701 E.00614
G1 X88.876 Y99.336 E.00613
G1 X88.797 Y99.016 E.00551
G1 X88.597 Y98.531 E.00875
G1 X88.313 Y98.077 E.00894
G1 X87.941 Y97.663 E.00929
; LINE_WIDTH: 0.394633
G1 X87.803 Y97.531 E.00351
; LINE_WIDTH: 0.433336
G1 X87.647 Y97.384 E.00438
; LINE_WIDTH: 0.470087
G1 X87.396 Y97.171 E.00728
; WIPE_START
G1 X87.647 Y97.384 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X92.677 Y96.157 Z1.8 F18000
G1 Z1.4
G1 E.4 F1800
; LINE_WIDTH: 0.130328
G1 F1500
M204 S6000
G1 X92.757 Y96.119 E.00046
; LINE_WIDTH: 0.10461
G1 X92.932 Y96.011 E.00081
; WIPE_START
G1 X92.757 Y96.119 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X93.597 Y94.87 Z1.8 F18000
G1 Z1.4
G1 E.4 F1800
; LINE_WIDTH: 0.100684
G1 F1500
M204 S6000
G1 X93.738 Y94.681 E.00088
; LINE_WIDTH: 0.142542
G1 X93.879 Y94.492 E.00137
; WIPE_START
G1 X93.738 Y94.681 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X92.696 Y93.423 Z1.8 F18000
G1 Z1.4
G1 E.4 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.419992
G1 F1500
M204 S6000
G1 X93.604 Y94.059 E.02178
G1 X93.759 Y93.957 E.00366
G1 X93.897 Y93.995 E.00282
G1 X94.359 Y94.34 E.01134
G1 X94.432 Y94.448 E.00255
G1 X94.396 Y94.613 E.00333
G1 X95.231 Y95.198 E.02006
G1 X97.809 Y91.517 E.0884
G1 X95.274 Y89.742 E.06087
G1 X92.731 Y93.374 E.08722
M204 S10000
G1 X93.245 Y93.327 F18000
G1 F1500
M204 S6000
G1 X93.645 Y93.606 E.0096
G1 X93.72 Y93.564 E.00168
G1 X94.133 Y93.679 E.00845
G1 X94.595 Y94.024 E.01134
G1 X94.813 Y94.348 E.00766
G1 X94.798 Y94.414 E.00134
G1 X95.134 Y94.649 E.00807
G1 X97.26 Y91.613 E.07289
G1 X95.371 Y90.291 E.04536
G1 X93.28 Y93.277 E.07171
M204 S10000
G1 X93.81 Y93.208 F18000
G1 F1500
M204 S6000
G1 X94.369 Y93.363 E.01143
G1 X94.831 Y93.709 E.01134
G1 X95.067 Y94.058 E.00829
G1 X96.711 Y91.71 E.05638
G1 X95.468 Y90.84 E.02985
G1 X93.844 Y93.159 E.05569
M204 S10000
G1 X94.436 Y93.001 F18000
G1 F1500
M204 S6000
G1 X94.606 Y93.048 E.00346
G1 X95.057 Y93.385 E.01109
G1 X96.162 Y91.807 E.03789
G1 X95.565 Y91.389 E.01434
G1 X94.471 Y92.952 E.03752
M204 S10000
G1 X94.974 Y92.868 F18000
; LINE_WIDTH: 0.360612
G1 F1500
M204 S6000
G1 X95.62 Y91.946 E.01881
; WIPE_START
G1 X94.974 Y92.868 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X100.741 Y87.868 Z1.8 F18000
G1 X100.922 Y87.711 Z1.8
G1 Z1.4
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.0965026
G1 F1500
M204 S6000
G1 X97.786 Y85.515 E.01352
; WIPE_START
G1 X99.424 Y86.662 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X92.558 Y83.329 Z1.8 F18000
G1 X79.428 Y76.956 Z1.8
G1 Z1.4
G1 E.4 F1800
; LINE_WIDTH: 0.0913382
G1 F1500
M204 S6000
G1 X79.245 Y77.011 E.00062
; LINE_WIDTH: 0.119324
G1 X79.219 Y77.024 E.00014
; LINE_WIDTH: 0.156936
G1 X79.003 Y77.195 E.0018
G1 X78.865 Y77.364 E.00143
; LINE_WIDTH: 0.107282
G1 X78.788 Y77.595 E.00099
; CHANGE_LAYER
; Z_HEIGHT: 1.52
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F1500
G1 X78.865 Y77.364 E-.38
; WIPE_END
G1 E-.02 F1800
; layer num/total_layer_count: 12/49
; update layer progress
M73 L12
M991 S0 P11 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
M73 P51 R12
G3 Z1.8 I-.526 J1.097 P1  F18000
G1 X100.617 Y87.791 Z1.8
G1 Z1.52
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X98.655 Y90.592 E.06727
G1 X95.854 Y88.63 E.06727
G1 X96.125 Y88.243 E.00929
G1 X97.815 Y85.829 E.05797
G1 X100.568 Y87.756 E.06609
; WIPE_START
M204 S6000
G1 X99.45 Y89.414 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X95.09 Y83.149 Z1.92 F18000
G1 X93.304 Y80.581 Z1.92
G1 Z1.52
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X93.311 Y88.382 E.1651
G1 X92.95 Y88.382 E.00764
G1 X92.95 Y77.128 E.23818
G1 X93.135 Y77.076 E.00407
G1 X93.216 Y77.207 E.00325
G1 X93.272 Y77.349 E.00324
G1 X93.301 Y77.49 E.00306
G1 X93.304 Y80.521 E.06415
; WIPE_START
M204 S6000
G1 X93.306 Y82.521 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X89.427 Y89.095 Z1.92 F18000
G1 X84.696 Y97.11 Z1.92
G1 Z1.52
G1 E.4 F1800
G1 F1500
M204 S500
G1 X84.589 Y96.949 E.0041
G1 X84.941 Y96.544 E.01135
G1 X86.92 Y96.544 E.04188
G1 X87.266 Y96.942 E.01116
G1 X87.159 Y97.104 E.0041
G1 X86.697 Y96.953 E.01029
G1 X86.324 Y96.88 E.00804
G1 X85.794 Y96.856 E.01123
G1 X85.252 Y96.93 E.01157
G1 X84.753 Y97.092 E.01111
; WIPE_START
M204 S6000
G1 X84.589 Y96.949 E-.04131
G1 X84.941 Y96.544 E-.10187
G1 X86.188 Y96.544 E-.23682
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X84.852 Y102.286 Z1.92 F18000
G1 Z1.52
G1 E.4 F1800
G1 F1500
M204 S500
G1 X84.486 Y102.089 E.00878
G1 X84.126 Y101.802 E.00975
G1 X83.907 Y101.565 E.00683
G1 X83.717 Y101.304 E.00683
G1 X83.505 Y100.895 E.00975
G1 X83.366 Y100.446 E.00995
G1 X83.31 Y99.979 E.00995
G1 X83.338 Y99.519 E.00975
G1 X83.404 Y99.205 E.0068
G1 X83.497 Y98.929 E.00616
G1 X83.719 Y98.492 E.01039
G1 X84.009 Y98.118 E.01001
G1 X84.351 Y97.809 E.00975
G1 X84.62 Y97.632 E.00683
G1 X84.909 Y97.487 E.00683
G1 X85.347 Y97.345 E.00975
G1 X85.813 Y97.282 E.00995
G1 X86.273 Y97.302 E.00975
G1 X86.59 Y97.365 E.00683
G1 X86.897 Y97.465 E.00683
G1 X87.309 Y97.671 E.00975
G1 X87.677 Y97.947 E.00975
G1 X87.904 Y98.177 E.00683
G1 X88.101 Y98.432 E.00683
G1 X88.326 Y98.835 E.00975
G1 X88.475 Y99.271 E.00975
G1 X88.532 Y99.588 E.00683
G1 X88.552 Y99.913 E.00689
G1 X88.504 Y100.392 E.01019
G1 X88.434 Y100.674 E.00616
G1 X88.321 Y100.975 E.0068
G1 X88.097 Y101.378 E.00975
G1 X87.798 Y101.741 E.00995
G1 X87.447 Y102.039 E.00975
G1 X87.173 Y102.208 E.0068
G1 X86.91 Y102.331 E.00615
G1 X86.44 Y102.473 E.01039
G1 X85.979 Y102.521 E.00981
G1 X85.657 Y102.507 E.00683
G1 X85.338 Y102.454 E.00684
G1 X84.905 Y102.313 E.00964
M204 S250
G1 X85.046 Y101.925 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X84.713 Y101.746 E.00744
G1 X84.405 Y101.501 E.00773
G1 X84.223 Y101.305 E.00526
G1 X84.066 Y101.088 E.00526
G1 X83.885 Y100.739 E.00773
G1 X83.768 Y100.361 E.0078
G1 X83.721 Y99.967 E.0078
G1 X83.744 Y99.574 E.00774
G1 X83.8 Y99.313 E.00525
G1 X83.876 Y99.088 E.00467
G1 X84.067 Y98.711 E.00831
G1 X84.31 Y98.397 E.00781
G1 X84.602 Y98.134 E.00773
G1 X84.825 Y97.987 E.00526
G1 X85.065 Y97.867 E.00526
G1 X85.439 Y97.745 E.00773
G1 X85.831 Y97.692 E.0078
G1 X86.224 Y97.71 E.00773
G1 X86.487 Y97.762 E.00526
G1 X86.741 Y97.844 E.00526
G1 X87.093 Y98.02 E.00773
G1 X87.407 Y98.256 E.00773
G1 X87.595 Y98.447 E.00526
G1 X87.759 Y98.658 E.00526
G1 X87.95 Y99.002 E.00773
G1 X88.077 Y99.374 E.00773
G1 X88.125 Y99.637 E.00526
G1 X88.141 Y99.905 E.00528
G1 X88.1 Y100.322 E.00825
G1 X88.043 Y100.553 E.00467
G1 X87.949 Y100.803 E.00525
G1 X87.757 Y101.146 E.00773
G1 X87.506 Y101.452 E.0078
G1 X87.206 Y101.707 E.00773
G1 X86.978 Y101.847 E.00525
G1 X86.763 Y101.948 E.00467
G1 X86.359 Y102.07 E.00831
G1 X85.967 Y102.111 E.00776
G1 X85.7 Y102.099 E.00526
G1 X85.436 Y102.055 E.00527
G1 X85.101 Y101.947 E.00691
; WIPE_START
M204 S6000
G1 X84.713 Y101.746 E-.08315
G1 X84.405 Y101.501 E-.07471
G1 X84.223 Y101.305 E-.05082
G1 X84.066 Y101.088 E-.05085
G1 X83.885 Y100.739 E-.07468
G1 X83.814 Y100.509 E-.04579
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X90.234 Y96.382 Z1.92 F18000
G1 X98.177 Y91.275 Z1.92
G1 Z1.52
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X98.379 Y91.416 E.00522
G1 X95.332 Y95.768 E.11246
G1 X93.972 Y94.816 E.03515
G1 X93.202 Y95.635 E.02379
G1 X92.957 Y95.743 E.00566
G1 X92.988 Y95.443 E.00638
G1 X93.535 Y94.51 E.02288
G1 X92.126 Y93.524 E.03639
G1 X95.174 Y89.172 E.11245
G1 X98.128 Y91.24 E.07633
; WIPE_START
M204 S6000
G1 X98.379 Y91.416 E-.05824
G1 X97.408 Y92.803 E-.32176
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X90.022 Y94.73 Z1.92 F18000
G1 X84.691 Y96.12 Z1.92
G1 Z1.52
G1 E.4 F1800
G1 F1500
M204 S500
G1 X92.499 Y96.12 E.16526
G1 X92.56 Y95.401 E.01527
G1 X92.583 Y95.313 E.00193
G1 X92.971 Y94.633 E.01656
G1 X91.536 Y93.628 E.03709
G1 X97.307 Y85.386 E.21296
G1 X97.521 Y85.536 E.00554
G1 X95.284 Y88.731 E.08255
G1 X98.756 Y91.162 E.08971
G1 X100.993 Y87.967 E.08255
G1 X101.207 Y88.117 E.00554
G1 X95.436 Y96.359 E.21296
G1 X94.029 Y95.374 E.03635
G1 X93.477 Y95.963 E.01708
G1 X93.186 Y96.106 E.00686
G1 X92.904 Y96.34 E.00777
G1 X92.768 Y96.411 E.00323
G1 X92.575 Y96.467 E.00427
G1 X92.404 Y96.482 E.00363
G1 X87.428 Y96.482 E.10532
G1 X88.614 Y97.845 E.03825
G1 X88.721 Y97.992 E.00386
G1 X88.935 Y98.353 E.00888
G1 X89.159 Y98.901 E.01254
G1 X89.286 Y99.49 E.01274
G1 X89.305 Y100.1 E.01292
G1 X89.229 Y100.633 E.01141
G1 X89.1 Y101.074 E.00971
G1 X88.847 Y101.61 E.01255
G1 X88.646 Y101.911 E.00766
G1 X88.493 Y102.106 E.00525
G1 X88.057 Y102.529 E.01285
G1 X87.565 Y102.859 E.01254
G1 X87.203 Y103.032 E.00849
G1 X86.815 Y103.163 E.00869
G1 X86.222 Y103.269 E.01273
G1 X85.63 Y103.267 E.01254
G1 X85.047 Y103.163 E.01254
G1 X84.661 Y103.033 E.00862
G1 X84.25 Y102.832 E.00968
G1 X83.95 Y102.64 E.00753
G1 X83.502 Y102.251 E.01256
G1 X83.24 Y101.947 E.00849
G1 X83.017 Y101.613 E.0085
G1 X82.834 Y101.256 E.00849
G1 X82.696 Y100.879 E.00849
G1 X82.602 Y100.489 E.0085
G1 X82.556 Y100.091 E.00849
G1 X82.574 Y99.499 E.01253
G1 X82.648 Y99.095 E.00869
G1 X82.767 Y98.712 E.00849
G1 X82.93 Y98.345 E.00849
G1 X83.248 Y97.845 E.01254
G1 X84.434 Y96.482 E.03824
G1 X79.467 Y96.482 E.10513
G1 X79.218 Y96.453 E.0053
M73 P51 R11
G1 X79.09 Y96.411 E.00285
G1 X78.9 Y96.301 E.00464
G1 X78.801 Y96.213 E.0028
G1 X78.658 Y96.017 E.00514
G1 X78.58 Y95.821 E.00446
G1 X78.55 Y95.565 E.00546
G1 X78.55 Y77.628 E.37965
G1 X78.586 Y77.356 E.00581
G1 X78.693 Y77.123 E.00542
G1 X78.793 Y76.997 E.00341
G1 X78.9 Y76.901 E.00304
G1 X79.132 Y76.775 E.00559
G1 X79.382 Y76.723 E.00542
G1 X92.414 Y76.721 E.27582
G1 X92.64 Y76.748 E.00482
G1 X92.778 Y76.794 E.00308
G1 X92.955 Y76.889 E.00424
G1 X92.906 Y77.082 E.0042
G1 X79.892 Y77.082 E.27546
G1 X79.676 Y77.109 E.00461
G1 X79.391 Y77.224 E.00651
G1 X79.085 Y77.512 E.00888
G1 X78.948 Y77.806 E.00688
G1 X78.911 Y78.056 E.00533
G1 X78.911 Y95.155 E.36192
G1 X78.964 Y95.453 E.0064
G1 X79.151 Y95.777 E.00792
G1 X79.503 Y96.043 E.00935
G1 X79.865 Y96.12 E.00783
G1 X84.631 Y96.12 E.10089
; WIPE_START
M204 S6000
G1 X86.631 Y96.12 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X83.535 Y96.891 Z1.92 F18000
G1 Z1.52
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X79.443 Y96.891 E.08049
G1 X79.13 Y96.854 E.0062
G1 X78.935 Y96.791 E.00402
G1 X78.786 Y96.718 E.00328
G1 X78.648 Y96.625 E.00328
G1 X78.496 Y96.489 E.00401
G1 X78.303 Y96.225 E.00642
G1 X78.177 Y95.904 E.00678
G1 X78.141 Y95.589 E.00625
G1 X78.141 Y77.61 E.35362
G1 X78.161 Y77.374 E.00466
G1 X78.195 Y77.233 E.00284
G1 X78.271 Y77.037 E.00414
G1 X78.352 Y76.894 E.00323
G1 X78.493 Y76.716 E.00447
G1 X78.647 Y76.577 E.00408
G1 X78.784 Y76.485 E.00324
G1 X78.99 Y76.389 E.00447
G1 X79.19 Y76.334 E.00408
G1 X79.357 Y76.313 E.00329
G1 X92.439 Y76.311 E.25732
G1 X92.73 Y76.347 E.00577
G1 X92.941 Y76.417 E.00437
G1 X93.139 Y76.524 E.00442
G1 X93.315 Y76.663 E.00442
G1 X93.465 Y76.831 E.00442
G1 X93.583 Y77.022 E.00442
G1 X93.666 Y77.231 E.00442
G1 X93.71 Y77.448 E.00436
G1 X93.72 Y88.791 E.2231
G1 X92.541 Y88.791 E.02321
G1 X92.541 Y77.491 E.22226
G1 X79.918 Y77.491 E.24828
G1 X79.78 Y77.508 E.00274
G1 X79.615 Y77.575 E.00349
G1 X79.423 Y77.756 E.0052
G1 X79.344 Y77.925 E.00368
G1 X79.321 Y78.086 E.00319
G1 X79.321 Y95.119 E.33504
G1 X79.354 Y95.311 E.00382
G1 X79.464 Y95.5 E.0043
G1 X79.678 Y95.661 E.00527
G1 X79.908 Y95.711 E.00464
G1 X92.123 Y95.711 E.24026
G1 X92.156 Y95.333 E.00745
G1 X92.193 Y95.185 E.00302
G1 X92.24 Y95.071 E.00243
G1 X92.427 Y94.752 E.00727
G1 X90.966 Y93.729 E.03508
G1 X97.206 Y84.816 E.214
G1 X101.777 Y88.017 E.10975
G1 X95.536 Y96.929 E.214
G1 X94.085 Y95.913 E.03485
G1 X93.743 Y96.277 E.00983
G1 X93.605 Y96.369 E.00327
G1 X93.403 Y96.457 E.00433
G1 X93.132 Y96.682 E.00694
G1 X92.922 Y96.792 E.00466
G1 X92.65 Y96.871 E.00556
G1 X92.421 Y96.891 E.00452
G1 X88.326 Y96.891 E.08055
G1 X88.934 Y97.59 E.01823
M73 P52 R11
G1 X89.063 Y97.767 E.0043
G1 X89.296 Y98.159 E.00897
G1 X89.391 Y98.356 E.00431
G1 X89.551 Y98.78 E.00891
G1 X89.659 Y99.22 E.00891
G1 X89.713 Y99.661 E.00873
G1 X89.714 Y100.117 E.00897
G1 X89.695 Y100.335 E.00431
G1 X89.628 Y100.726 E.00779
G1 X89.486 Y101.213 E.00998
G1 X89.329 Y101.576 E.00778
G1 X89.199 Y101.82 E.00544
G1 X88.978 Y102.152 E.00784
G1 X88.656 Y102.534 E.00983
G1 X88.32 Y102.842 E.00898
G1 X88.146 Y102.975 E.0043
G1 X87.764 Y103.218 E.00891
G1 X87.358 Y103.412 E.00885
G1 X86.929 Y103.557 E.00891
G1 X86.716 Y103.609 E.00431
G1 X86.265 Y103.676 E.00897
G1 X86.046 Y103.689 E.00431
G1 X85.593 Y103.676 E.00891
G1 X85.145 Y103.608 E.00891
G1 X84.933 Y103.557 E.00431
G1 X84.505 Y103.412 E.00889
G1 X84.049 Y103.189 E.00997
G1 X83.541 Y102.842 E.0121
G1 X83.207 Y102.536 E.00891
G1 X82.914 Y102.195 E.00885
G1 X82.663 Y101.821 E.00885
G1 X82.459 Y101.42 E.00885
G1 X82.303 Y100.998 E.00885
G1 X82.199 Y100.56 E.00885
G1 X82.147 Y100.113 E.00885
G1 X82.148 Y99.661 E.00891
G1 X82.169 Y99.443 E.0043
G1 X82.25 Y98.997 E.00891
G1 X82.383 Y98.567 E.00885
G1 X82.566 Y98.156 E.00885
G1 X82.798 Y97.767 E.00891
G1 X82.927 Y97.59 E.0043
G1 X83.496 Y96.936 E.01704
; WIPE_START
M204 S6000
G1 X81.496 Y96.914 E-.38
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




G1 X79.338 Y96.25
G1 Z1.52
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.155748
G1 F1500
M204 S6000
G1 X79.011 Y96.023 E.00258
G1 X78.94 Y95.948 E.00067
G1 X78.856 Y95.803 E.00109
; LINE_WIDTH: 0.124098
G1 X78.824 Y95.713 E.00047
; LINE_WIDTH: 0.0938226
G1 X78.792 Y95.622 E.00033
; WIPE_START
G1 X78.824 Y95.713 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X84.478 Y97.165 Z1.92 F18000
G1 Z1.52
G1 E.4 F1800
; LINE_WIDTH: 0.477118
G1 F1500
M204 S6000
G1 X84.297 Y97.319 E.00533
; LINE_WIDTH: 0.438412
G1 X84.091 Y97.496 E.00561
; LINE_WIDTH: 0.400617
G1 X83.916 Y97.673 E.00464
; LINE_WIDTH: 0.3598
G1 X83.723 Y97.872 E.00463
G1 X83.393 Y98.304 E.00905
G1 X83.144 Y98.794 E.00917
G1 X83.02 Y99.184 E.00682
G1 X82.942 Y99.704 E.00877
G1 X82.937 Y100.069 E.00609
G1 X83.001 Y100.539 E.0079
G1 X83.161 Y101.052 E.00896
G1 X83.389 Y101.492 E.00826
G1 X83.609 Y101.797 E.00626
G1 X83.879 Y102.086 E.00659
G1 X84.292 Y102.409 E.00874
G1 X84.765 Y102.664 E.00896
G1 X85.148 Y102.794 E.00673
G1 X85.627 Y102.884 E.00812
G1 X85.978 Y102.895 E.00585
G1 X86.186 Y102.886 E.00346
G1 X86.529 Y102.836 E.00578
G1 X87.034 Y102.689 E.00877
G1 X87.362 Y102.536 E.00603
G1 X87.68 Y102.338 E.00624
G1 X88.098 Y101.975 E.00924
G1 X88.397 Y101.6 E.00799
G1 X88.516 Y101.414 E.00368
G1 X88.741 Y100.941 E.00872
G1 X88.874 Y100.468 E.00819
G1 X88.925 Y99.933 E.00896
G1 X88.909 Y99.541 E.00654
G1 X88.834 Y99.165 E.0064
G1 X88.662 Y98.669 E.00874
G1 X88.42 Y98.236 E.00826
G1 X88.194 Y97.936 E.00626
G1 X87.924 Y97.645 E.00662
; LINE_WIDTH: 0.397705
G1 X87.802 Y97.532 E.00308
; LINE_WIDTH: 0.432764
G1 X87.68 Y97.419 E.00337
; LINE_WIDTH: 0.468069
G1 X87.557 Y97.304 E.00372
; LINE_WIDTH: 0.468491
G1 X87.396 Y97.34 E.00365
; LINE_WIDTH: 0.433769
G1 X87.234 Y97.375 E.00337
; WIPE_START
G1 X87.396 Y97.34 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X92.721 Y96.196 Z1.92 F18000
G1 Z1.52
G1 E.4 F1800
; LINE_WIDTH: 0.109879
G1 F1500
M204 S6000
G1 X92.764 Y96.115 E.00039
G1 X92.932 Y96.011 E.00083
; WIPE_START
G1 X92.764 Y96.115 E-.25931
G1 X92.721 Y96.196 E-.12069
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X93.598 Y94.868 Z1.92 F18000
G1 Z1.52
G1 E.4 F1800
; LINE_WIDTH: 0.10056
G1 F1500
M204 S6000
G1 X93.739 Y94.68 E.00088
; LINE_WIDTH: 0.14219
G1 X93.879 Y94.493 E.00136
; WIPE_START
G1 X93.739 Y94.68 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X92.696 Y93.423 Z1.92 F18000
G1 Z1.52
G1 E.4 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.419992
G1 F1500
M204 S6000
G1 X93.604 Y94.059 E.02179
G1 X93.76 Y93.957 E.00366
G1 X93.898 Y93.995 E.00282
G1 X94.351 Y94.335 E.01114
G1 X94.424 Y94.442 E.00254
G1 X94.391 Y94.61 E.00337
G1 X95.231 Y95.198 E.02017
G1 X97.809 Y91.517 E.0884
G1 X95.274 Y89.742 E.06087
G1 X92.731 Y93.374 E.08722
M204 S10000
G1 X93.245 Y93.327 F18000
G1 F1500
M204 S6000
G1 X93.646 Y93.607 E.00961
G1 X93.72 Y93.565 E.00168
G1 X94.134 Y93.679 E.00845
G1 X94.588 Y94.019 E.01114
G1 X94.805 Y94.34 E.00763
G1 X94.792 Y94.409 E.00138
G1 X95.134 Y94.649 E.00823
G1 X97.26 Y91.613 E.07289
G1 X95.371 Y90.291 E.04536
G1 X93.28 Y93.277 E.07171
M204 S10000
G1 X93.81 Y93.208 F18000
G1 F1500
M204 S6000
G1 X94.37 Y93.364 E.01144
G1 X94.824 Y93.703 E.01114
G1 X95.065 Y94.061 E.00849
G1 X96.711 Y91.71 E.05644
G1 X95.468 Y90.84 E.02985
G1 X93.844 Y93.159 E.05569
M204 S10000
G1 X94.436 Y93.001 F18000
G1 F1500
M204 S6000
G1 X94.606 Y93.048 E.00347
G1 X95.057 Y93.385 E.01107
G1 X96.162 Y91.807 E.03789
G1 X95.565 Y91.389 E.01434
G1 X94.47 Y92.952 E.03753
M204 S10000
G1 X94.974 Y92.868 F18000
; LINE_WIDTH: 0.360612
G1 F1500
M204 S6000
G1 X95.62 Y91.946 E.01881
; WIPE_START
G1 X94.974 Y92.868 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X97.7 Y85.739 Z1.92 F18000
G1 X97.786 Y85.515 Z1.92
G1 Z1.52
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.0965003
G1 F1500
M204 S6000
G1 X100.922 Y87.711 E.01352
; WIPE_START
G1 X99.284 Y86.564 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X92.413 Y83.24 Z1.92 F18000
G1 X79.428 Y76.956 Z1.92
G1 Z1.52
G1 E.4 F1800
; LINE_WIDTH: 0.0917069
G1 F1500
M204 S6000
G1 X79.245 Y77.011 E.00063
; LINE_WIDTH: 0.119308
G1 X79.22 Y77.023 E.00013
; LINE_WIDTH: 0.156765
G1 X79.003 Y77.194 E.00181
G1 X78.865 Y77.364 E.00143
; LINE_WIDTH: 0.107339
G1 X78.788 Y77.595 E.00099
; CHANGE_LAYER
; Z_HEIGHT: 1.64
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F1500
G1 X78.865 Y77.364 E-.38
; WIPE_END
G1 E-.02 F1800
; layer num/total_layer_count: 13/49
; update layer progress
M73 L13
M991 S0 P12 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z1.92 I-.526 J1.097 P1  F18000
G1 X100.617 Y87.791 Z1.92
G1 Z1.64
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X98.655 Y90.592 E.06727
G1 X95.854 Y88.63 E.06727
G1 X97.815 Y85.829 E.06727
G1 X100.568 Y87.756 E.06609
; WIPE_START
M204 S6000
G1 X99.45 Y89.414 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X95.353 Y82.974 Z2.04 F18000
G1 X93.303 Y79.751 Z2.04
G1 Z1.64
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X93.31 Y87.24 E.15853
G1 X93.128 Y87.5 E.00672
G1 X92.95 Y87.444 E.00395
G1 X92.95 Y77.128 E.21834
G1 X93.135 Y77.076 E.00407
G1 X93.216 Y77.207 E.00325
G1 X93.272 Y77.349 E.00324
G1 X93.301 Y77.49 E.00306
G1 X93.303 Y79.691 E.04657
; WIPE_START
M204 S6000
G1 X93.305 Y81.691 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X89.586 Y88.356 Z2.04 F18000
G1 X84.692 Y97.126 Z2.04
G1 Z1.64
G1 E.4 F1800
G1 F1500
M204 S500
G1 X84.577 Y96.963 E.00423
G1 X84.941 Y96.544 E.01174
G1 X86.91 Y96.544 E.04167
G1 X87.256 Y96.938 E.0111
G1 X87.149 Y97.101 E.00411
G1 X86.697 Y96.953 E.01007
G1 X86.324 Y96.88 E.00804
G1 X85.81 Y96.857 E.0109
G1 X85.432 Y96.897 E.00804
G1 X85.061 Y96.981 E.00804
G1 X84.748 Y97.104 E.00712
; WIPE_START
M204 S6000
G1 X84.577 Y96.963 E-.04213
G1 X84.941 Y96.544 E-.10541
G1 X86.165 Y96.544 E-.23246
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X84.851 Y102.285 Z2.04 F18000
G1 Z1.64
G1 E.4 F1800
G1 F1500
M204 S500
G1 X84.486 Y102.089 E.00876
G1 X84.119 Y101.796 E.00995
G1 X83.81 Y101.442 E.00994
G1 X83.573 Y101.046 E.00975
G1 X83.451 Y100.748 E.00683
G1 X83.365 Y100.437 E.00682
G1 X83.31 Y99.979 E.00975
G1 X83.338 Y99.519 E.00975
G1 X83.404 Y99.205 E.0068
G1 X83.496 Y98.932 E.0061
G1 X83.719 Y98.492 E.01044
G1 X84.009 Y98.118 E.01001
G1 X84.358 Y97.803 E.00995
G1 X84.758 Y97.556 E.00995
G1 X85.187 Y97.388 E.00975
G1 X85.501 Y97.316 E.00683
G1 X85.822 Y97.282 E.00683
G1 X86.273 Y97.302 E.00955
G1 X86.59 Y97.365 E.00683
G1 X86.897 Y97.465 E.00683
G1 X87.309 Y97.671 E.00975
G1 X87.685 Y97.952 E.00994
G1 X87.998 Y98.29 E.00975
G1 X88.18 Y98.557 E.00683
G1 X88.329 Y98.843 E.00683
G1 X88.475 Y99.271 E.00956
G1 X88.532 Y99.588 E.00683
G1 X88.551 Y99.91 E.00683
G1 X88.51 Y100.369 E.00975
G1 X88.388 Y100.813 E.00975
G1 X88.257 Y101.107 E.0068
G1 X88.11 Y101.355 E.0061
G1 X87.801 Y101.739 E.01044
G1 X87.447 Y102.039 E.00982
G1 X87.174 Y102.208 E.0068
G1 X86.912 Y102.33 E.0061
G1 X86.44 Y102.473 E.01044
G1 X85.979 Y102.521 E.00982
G1 X85.658 Y102.507 E.0068
G1 X85.374 Y102.461 E.0061
G1 X84.904 Y102.313 E.01042
M204 S250
G1 X85.045 Y101.925 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X84.713 Y101.746 E.00742
G1 X84.403 Y101.499 E.0078
G1 X84.142 Y101.2 E.00779
G1 X83.94 Y100.863 E.00774
G1 X83.839 Y100.615 E.00526
G1 X83.768 Y100.357 E.00526
G1 X83.721 Y99.967 E.00773
G1 X83.744 Y99.574 E.00774
G1 X83.8 Y99.313 E.00525
G1 X83.875 Y99.091 E.00462
G1 X84.067 Y98.712 E.00836
G1 X84.31 Y98.397 E.00782
G1 X84.604 Y98.132 E.0078
G1 X84.942 Y97.924 E.0078
G1 X85.308 Y97.78 E.00773
G1 X85.568 Y97.72 E.00526
G1 X85.835 Y97.692 E.00526
G1 X86.224 Y97.71 E.00767
G1 X86.487 Y97.762 E.00526
G1 X86.741 Y97.844 E.00526
G1 X87.093 Y98.02 E.00773
G1 X87.41 Y98.258 E.00779
G1 X87.677 Y98.546 E.00773
G1 X87.828 Y98.767 E.00526
G1 X87.951 Y99.005 E.00526
G1 X88.077 Y99.374 E.00767
G1 X88.125 Y99.637 E.00526
G1 X88.141 Y99.904 E.00526
G1 X88.106 Y100.296 E.00773
G1 X88.001 Y100.675 E.00774
G1 X87.893 Y100.919 E.00525
G1 X87.773 Y101.121 E.00462
G1 X87.506 Y101.452 E.00836
G1 X87.206 Y101.707 E.00775
G1 X86.978 Y101.847 E.00525
G1 X86.766 Y101.947 E.00462
G1 X86.359 Y102.07 E.00836
G1 X85.967 Y102.111 E.00776
G1 X85.7 Y102.099 E.00525
G1 X85.468 Y102.062 E.00463
G1 X85.101 Y101.946 E.00757
; WIPE_START
M204 S6000
G1 X84.713 Y101.746 E-.08297
G1 X84.403 Y101.499 E-.07533
G1 X84.142 Y101.2 E-.07528
G1 X83.94 Y100.863 E-.07472
G1 X83.839 Y100.615 E-.05084
G1 X83.81 Y100.509 E-.02086
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X84.691 Y96.12 Z2.04 F18000
G1 Z1.64
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
M73 P53 R11
G1 F1500
M204 S500
G1 X91.241 Y96.12 E.13862
G1 X91.503 Y96.304 E.00677
G1 X91.447 Y96.482 E.00395
G1 X87.419 Y96.482 E.08524
G1 X88.577 Y97.8 E.03714
G1 X88.723 Y97.996 E.00515
G1 X88.935 Y98.353 E.0088
G1 X89.159 Y98.901 E.01254
G1 X89.286 Y99.489 E.01273
G1 X89.305 Y100.091 E.01273
G1 X89.221 Y100.677 E.01254
G1 X89.099 Y101.079 E.00888
G1 X88.844 Y101.613 E.01253
G1 X88.621 Y101.947 E.00849
G1 X88.353 Y102.258 E.00868
G1 X88.071 Y102.517 E.00811
G1 X87.738 Y102.757 E.00869
G1 X87.379 Y102.955 E.00869
G1 X86.814 Y103.164 E.01273
G1 X86.222 Y103.269 E.01273
G1 X85.63 Y103.267 E.01254
G1 X85.038 Y103.161 E.01273
G1 X84.474 Y102.951 E.01273
G1 X84.123 Y102.757 E.00849
G1 X83.797 Y102.522 E.00849
G1 X83.502 Y102.251 E.0085
G1 X83.24 Y101.947 E.00849
G1 X83.017 Y101.613 E.00849
G1 X82.834 Y101.256 E.00849
G1 X82.696 Y100.879 E.00849
G1 X82.602 Y100.489 E.0085
G1 X82.556 Y100.091 E.00849
G1 X82.574 Y99.499 E.01254
G1 X82.648 Y99.095 E.00869
G1 X82.767 Y98.712 E.00849
G1 X82.934 Y98.337 E.00869
G1 X83.254 Y97.838 E.01254
G1 X84.434 Y96.482 E.03805
G1 X79.467 Y96.482 E.10513
G1 X79.231 Y96.454 E.00502
G1 X79.012 Y96.372 E.00494
G1 X78.9 Y96.302 E.00282
G1 X78.72 Y96.119 E.00543
G1 X78.67 Y96.043 E.00191
G1 X78.579 Y95.814 E.00523
G1 X78.55 Y95.565 E.00531
G1 X78.55 Y77.619 E.37984
G1 X78.589 Y77.349 E.00577
G1 X78.711 Y77.099 E.00588
G1 X78.876 Y76.921 E.00514
G1 X78.991 Y76.84 E.00299
G1 X79.13 Y76.775 E.00324
G1 X79.379 Y76.723 E.00539
G1 X92.473 Y76.723 E.27713
G1 X92.633 Y76.746 E.00343
G1 X92.776 Y76.793 E.00318
G1 X92.952 Y76.891 E.00426
G1 X92.903 Y77.082 E.00418
G1 X79.858 Y77.082 E.2761
G1 X79.466 Y77.175 E.00854
G1 X79.121 Y77.464 E.00952
G1 X78.962 Y77.758 E.00708
G1 X78.911 Y78.047 E.0062
G1 X78.911 Y95.146 E.36192
G1 X78.952 Y95.42 E.00587
G1 X79.165 Y95.796 E.00913
G1 X79.519 Y96.048 E.00921
G1 X79.867 Y96.12 E.00753
G1 X84.631 Y96.12 E.10084
; WIPE_START
M204 S6000
G1 X86.631 Y96.12 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X83.535 Y96.891 Z2.04 F18000
G1 Z1.64
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X79.443 Y96.891 E.08049
G1 X79.134 Y96.855 E.00611
G1 X78.831 Y96.741 E.00638
G1 X78.548 Y96.541 E.00681
G1 X78.394 Y96.369 E.00454
G1 X78.314 Y96.247 E.00287
G1 X78.24 Y96.095 E.00333
G1 X78.177 Y95.902 E.00399
G1 X78.141 Y95.589 E.0062
G1 X78.141 Y77.607 E.35368
G1 X78.149 Y77.454 E.00301
G1 X78.196 Y77.231 E.00448
G1 X78.279 Y77.022 E.00443
G1 X78.383 Y76.851 E.00393
G1 X78.605 Y76.611 E.00644
G1 X78.786 Y76.484 E.00434
G1 X78.99 Y76.389 E.00442
G1 X79.21 Y76.33 E.00448
G1 X79.356 Y76.313 E.00289
G1 X92.503 Y76.313 E.25859
G1 X92.728 Y76.346 E.00448
G1 X92.94 Y76.417 E.0044
G1 X93.156 Y76.536 E.00485
G1 X93.315 Y76.663 E.00399
G1 X93.465 Y76.831 E.00443
G1 X93.583 Y77.022 E.00442
G1 X93.666 Y77.231 E.00442
G1 X93.71 Y77.448 E.00436
G1 X93.72 Y88.791 E.2231
G1 X92.541 Y88.791 E.02321
G1 X92.541 Y77.491 E.22226
G1 X79.906 Y77.491 E.24851
G1 X79.654 Y77.551 E.00509
G1 X79.444 Y77.727 E.0054
G1 X79.354 Y77.894 E.00374
G1 X79.321 Y78.082 E.00376
G1 X79.321 Y95.116 E.33504
G1 X79.345 Y95.285 E.00336
G1 X79.476 Y95.515 E.0052
G1 X79.686 Y95.665 E.00508
G1 X79.909 Y95.711 E.00448
G1 X92.113 Y95.711 E.24004
G1 X92.183 Y95.219 E.00976
G1 X92.241 Y95.068 E.00319
G1 X92.427 Y94.752 E.00722
G1 X90.966 Y93.729 E.03509
G1 X97.206 Y84.816 E.214
G1 X101.777 Y88.017 E.10975
G1 X95.536 Y96.929 E.214
G1 X94.085 Y95.913 E.03485
G1 X93.743 Y96.277 E.00983
G1 X93.605 Y96.369 E.00327
G1 X93.403 Y96.457 E.00433
G1 X93.133 Y96.681 E.00689
G1 X92.865 Y96.814 E.0059
G1 X92.652 Y96.871 E.00432
G1 X92.421 Y96.891 E.00456
G1 X88.323 Y96.891 E.08061
G1 X88.896 Y97.543 E.01707
G1 X89.063 Y97.768 E.00552
G1 X89.296 Y98.159 E.00895
G1 X89.391 Y98.356 E.00431
G1 X89.551 Y98.78 E.00891
G1 X89.659 Y99.22 E.00891
G1 X89.713 Y99.661 E.00873
G1 X89.714 Y100.114 E.00891
G1 X89.662 Y100.564 E.00891
G1 X89.618 Y100.778 E.00431
G1 X89.485 Y101.215 E.00897
G1 X89.404 Y101.417 E.0043
G1 X89.198 Y101.821 E.00891
G1 X88.947 Y102.195 E.00885
G1 X88.652 Y102.538 E.00891
G1 X88.325 Y102.838 E.00873
G1 X87.957 Y103.103 E.00891
G1 X87.561 Y103.322 E.00891
G1 X87.361 Y103.411 E.00431
G1 X86.929 Y103.557 E.00897
G1 X86.716 Y103.608 E.0043
G1 X86.265 Y103.676 E.00897
G1 X86.046 Y103.689 E.00431
G1 X85.593 Y103.676 E.00891
G1 X85.145 Y103.608 E.00891
G1 X84.929 Y103.556 E.00437
G1 X84.717 Y103.491 E.00436
G1 X84.298 Y103.321 E.00891
G1 X83.904 Y103.103 E.00885
G1 X83.539 Y102.84 E.00885
G1 X83.207 Y102.536 E.00885
G1 X82.914 Y102.195 E.00885
G1 X82.663 Y101.821 E.00885
G1 X82.459 Y101.42 E.00885
G1 X82.303 Y100.998 E.00885
G1 X82.199 Y100.56 E.00885
G1 X82.147 Y100.114 E.00885
G1 X82.148 Y99.661 E.00891
G1 X82.169 Y99.443 E.0043
G1 X82.25 Y98.997 E.00891
G1 X82.383 Y98.567 E.00885
G1 X82.568 Y98.153 E.00891
G1 X82.674 Y97.962 E.0043
G1 X82.929 Y97.588 E.00891
G1 X83.496 Y96.936 E.01698
; WIPE_START
M204 S6000
G1 X81.496 Y96.914 E-.38
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




G1 X79.381 Y96.249
G1 Z1.64
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.14759
G1 F1500
M204 S6000
G1 X79.028 Y96.043 E.00249
G1 X78.952 Y95.97 E.00064
G1 X78.875 Y95.84 E.00092
; LINE_WIDTH: 0.130441
G1 X78.833 Y95.725 E.00064
; LINE_WIDTH: 0.0952417
G1 X78.79 Y95.61 E.00042
; WIPE_START
G1 X78.833 Y95.725 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X83.921 Y97.669 Z2.04 F18000
G1 Z1.64
G1 E.4 F1800
; LINE_WIDTH: 0.401762
G1 F1500
M204 S6000
G1 X84.099 Y97.487 E.00478
; LINE_WIDTH: 0.438136
G1 X84.296 Y97.318 E.00533
; LINE_WIDTH: 0.473051
G1 X84.466 Y97.174 E.00499
M204 S10000
G1 X83.921 Y97.669 F18000
; LINE_WIDTH: 0.360197
G1 F1500
M204 S6000
G1 X83.723 Y97.872 E.00474
G1 X83.392 Y98.304 E.00906
G1 X83.144 Y98.797 E.00922
G1 X83.02 Y99.184 E.00677
G1 X82.942 Y99.704 E.00878
G1 X82.937 Y100.069 E.00609
G1 X82.998 Y100.522 E.00762
G1 X83.061 Y100.769 E.00426
G1 X83.184 Y101.103 E.00594
G1 X83.348 Y101.418 E.00594
G1 X83.544 Y101.716 E.00594
G1 X83.869 Y102.078 E.00812
G1 X84.291 Y102.412 E.00898
G1 X84.742 Y102.654 E.00855
G1 X85.275 Y102.827 E.00934
G1 X85.662 Y102.888 E.00653
G1 X85.978 Y102.895 E.00528
G1 X86.186 Y102.886 E.00347
G1 X86.71 Y102.793 E.00889
G1 X87.214 Y102.61 E.00894
G1 X87.658 Y102.351 E.00859
G1 X88.079 Y101.997 E.00917
G1 X88.314 Y101.714 E.00614
G1 X88.515 Y101.42 E.00594
G1 X88.736 Y100.951 E.00865
G1 X88.848 Y100.585 E.00638
G1 X88.922 Y100.069 E.0087
G1 X88.908 Y99.536 E.0089
G1 X88.834 Y99.165 E.00632
G1 X88.677 Y98.707 E.00806
G1 X88.508 Y98.372 E.00626
G1 X88.287 Y98.044 E.0066
G1 X87.933 Y97.654 E.0088
; LINE_WIDTH: 0.394449
G1 X87.808 Y97.538 E.00313
; LINE_WIDTH: 0.42962
G1 X87.683 Y97.422 E.00343
; LINE_WIDTH: 0.466135
G1 X87.548 Y97.298 E.00402
; LINE_WIDTH: 0.472727
G1 X87.386 Y97.336 E.00373
; LINE_WIDTH: 0.447384
G1 X87.223 Y97.375 E.00352
; WIPE_START
G1 X87.386 Y97.336 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X91.617 Y96.623 Z2.04 F18000
G1 Z1.64
G1 E.4 F1800
; LINE_WIDTH: 0.217029
G1 F1500
M204 S6000
G1 X92.627 Y96.55 E.00966
M204 S10000
G1 X92.444 Y96.482 F18000
; LINE_WIDTH: 0.341959
G1 F1500
M204 S6000
G1 X92.58 Y96.288 E.00375
; LINE_WIDTH: 0.295083
G1 X92.716 Y96.093 E.00319
; LINE_WIDTH: 0.248207
G1 X92.852 Y95.899 E.00263
; LINE_WIDTH: 0.201332
G1 X92.988 Y95.704 E.00208
; LINE_WIDTH: 0.154456
G1 X93.124 Y95.51 E.00152
; LINE_WIDTH: 0.123515
G1 X93.158 Y95.463 E.00028
; WIPE_START
G1 X93.124 Y95.51 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X92.444 Y96.482 Z2.04 F18000
G1 Z1.64
G1 E.4 F1800
; LINE_WIDTH: 0.388835
G1 F1500
M204 S6000
G1 X92.307 Y96.677 E.0043
; WIPE_START
M73 P54 R11
G1 X92.444 Y96.482 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X93.187 Y88.886 Z2.04 F18000
G1 X93.253 Y88.218 Z2.04
G1 Z1.64
G1 E.4 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.643132
G1 F1500
M204 S6000
G1 X93.176 Y88.218 E.00238
G1 X93.137 Y88.285 E.00238
G1 X93.176 Y88.352 E.00238
G1 X93.253 Y88.352 E.00238
G1 X93.261 Y88.337 E.00053
; WIPE_START
G1 X93.253 Y88.352 E-.02002
G1 X93.176 Y88.352 E-.09
G1 X93.137 Y88.285 E-.08999
G1 X93.176 Y88.218 E-.09
G1 X93.253 Y88.218 E-.08999
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X97.798 Y85.524 Z2.04 F18000
G1 Z1.64
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.0965025
G1 F1500
M204 S6000
G1 X100.91 Y87.703 E.01341
M204 S10000
G1 X100.886 Y87.784 F18000
; FEATURE: Top surface
; LINE_WIDTH: 0.42
G1 F1500
M204 S2000
G1 X101.35 Y88.248 E.01291
G1 X101.121 Y88.576
G1 X100.657 Y88.112 E.01291
G1 X100.427 Y88.44
G1 X100.891 Y88.904 E.01291
G1 X100.661 Y89.232
G1 X100.197 Y88.768 E.01291
G1 X99.968 Y89.096
G1 X100.432 Y89.56 E.01291
G1 X100.202 Y89.888
G1 X99.738 Y89.424 E.01291
G1 X99.508 Y89.752
G1 X99.973 Y90.216 E.01291
G1 X99.743 Y90.544
G1 X99.279 Y90.08 E.01291
G1 X99.049 Y90.407
G1 X99.513 Y90.872 E.01291
G1 X99.284 Y91.199
G1 X98.82 Y90.735 E.01291
G1 X97.748 Y90.222
G1 X99.054 Y91.527 E.03632
G1 X98.824 Y91.855
G1 X95.889 Y88.919 E.08167
; WIPE_START
M204 S6000
G1 X97.303 Y90.334 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X97.66 Y85.673 Z2.04 F18000
G1 Z1.64
G1 E.4 F1800
G1 F1500
M204 S2000
G1 X97.196 Y85.209 E.01291
G1 X96.966 Y85.537
G1 X97.43 Y86.001 E.01291
G1 X97.201 Y86.329
G1 X96.737 Y85.865 E.01291
G1 X96.507 Y86.193
G1 X96.971 Y86.657 E.01291
G1 X96.741 Y86.985
G1 X96.277 Y86.521 E.01291
G1 X96.048 Y86.848
G1 X96.512 Y87.313 E.01291
G1 X96.282 Y87.64
G1 X95.818 Y87.176 E.01291
G1 X95.589 Y87.504
G1 X96.053 Y87.968 E.01291
G1 X95.823 Y88.296
G1 X95.359 Y87.832 E.01291
G1 X95.129 Y88.16
G1 X95.593 Y88.624 E.01291
G1 X94.9 Y88.488
G1 X98.595 Y92.183 E.10279
G1 X98.365 Y92.511
G1 X94.67 Y88.816 E.10279
G1 X94.44 Y89.144
G1 X98.136 Y92.839 E.10279
G1 X97.906 Y93.167
G1 X94.211 Y89.472 E.10279
G1 X93.981 Y89.8
G1 X97.676 Y93.495 E.10278
G1 X97.447 Y93.823
G1 X93.752 Y90.128 E.10279
G1 X93.522 Y90.456
G1 X97.217 Y94.151 E.10278
G1 X96.988 Y94.479
G1 X93.292 Y90.784 E.10279
G1 X93.063 Y91.111
G1 X96.758 Y94.807 E.10279
G1 X96.528 Y95.135
G1 X92.833 Y91.439 E.10279
G1 X92.604 Y91.767
G1 X96.299 Y95.462 E.10279
G1 X96.069 Y95.79
G1 X92.374 Y92.095 E.10279
G1 X92.144 Y92.423
G1 X95.839 Y96.118 E.10279
G1 X95.61 Y96.446
G1 X91.915 Y92.751 E.10279
G1 X91.685 Y93.079
G1 X94.649 Y96.043 E.08246
G1 X93.872 Y95.823
G1 X91.456 Y93.407 E.06721
; WIPE_START
M204 S6000
G1 X92.87 Y94.821 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X92.517 Y95.026 Z2.04 F18000
G1 Z1.64
G1 E.4 F1800
G1 F1500
M204 S2000
G1 X93.009 Y95.518 E.01369
G1 X92.746 Y95.813
G1 X92.371 Y95.437 E.01044
G1 X93.14 Y95.649
G1 X93.602 Y96.111 E.01283
G1 X93.242 Y96.309
G1 X92.946 Y96.012 E.00825
; WIPE_START
M204 S6000
G1 X93.242 Y96.309 E-.07971
G1 X93.602 Y96.111 E-.07797
G1 X93.14 Y95.649 E-.12398
G1 X92.641 Y95.512 E-.09835
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X97.685 Y90.285 Z2.04 F18000
G1 Z1.64
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.204944
G1 F1500
M204 S6000
G1 X97.496 Y90.126 E.00221
; LINE_WIDTH: 0.167263
G1 X97.307 Y89.967 E.00174
; LINE_WIDTH: 0.129582
G1 X97.118 Y89.809 E.00128
; LINE_WIDTH: 0.0919007
G1 X96.928 Y89.65 E.00081
; WIPE_START
G1 X97.118 Y89.809 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X95.531 Y96.556 Z2.04 F18000
G1 Z1.64
G1 E.4 F1800
; LINE_WIDTH: 0.0778492
G1 F1500
M204 S6000
G1 X95.481 Y96.613 E.0002
G1 X95.454 Y96.602 E.00008
; LINE_WIDTH: 0.0913276
G1 X95.269 Y96.447 E.00079
; LINE_WIDTH: 0.129173
G1 X95.083 Y96.291 E.00125
; LINE_WIDTH: 0.167018
G1 X94.898 Y96.136 E.00171
; LINE_WIDTH: 0.204863
G1 X94.713 Y95.98 E.00216
; WIPE_START
G1 X94.898 Y96.136 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X93.056 Y96.489 Z2.04 F18000
G1 Z1.64
G1 E.4 F1800
; LINE_WIDTH: 0.166125
G1 F1500
M204 S6000
G1 X92.795 Y96.252 E.00247
M204 S10000
G1 X93.196 Y95.447 F18000
; LINE_WIDTH: 0.085187
G1 F1500
M204 S6000
G1 X93.226 Y95.51 E.00021
G1 X93.174 Y95.587 E.00027
; WIPE_START
G1 X93.226 Y95.51 E-.21686
G1 X93.196 Y95.447 E-.16314
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X91.75 Y94.011 Z2.04 F18000
G1 Z1.64
G1 E.4 F1800
; LINE_WIDTH: 0.0955739
G1 F1500
M204 S6000
G1 X91.516 Y93.815 E.00106
; LINE_WIDTH: 0.140601
G1 X91.283 Y93.619 E.00175
; WIPE_START
G1 X91.516 Y93.815 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X86.804 Y87.811 Z2.04 F18000
G1 X78.785 Y77.596 Z2.04
G1 Z1.64
G1 E.4 F1800
; LINE_WIDTH: 0.0898968
G1 F1500
M204 S6000
G1 X78.814 Y77.51 E.00029
; LINE_WIDTH: 0.115797
G1 X78.843 Y77.424 E.00041
; LINE_WIDTH: 0.150083
G1 X78.906 Y77.302 E.00085
G1 X79.064 Y77.139 E.00141
G1 X79.349 Y76.941 E.00215
; CHANGE_LAYER
; Z_HEIGHT: 1.76
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F1500
G1 X79.064 Y77.139 E-.18547
G1 X78.906 Y77.302 E-.12112
G1 X78.843 Y77.424 E-.07341
; WIPE_END
G1 E-.02 F1800
; layer num/total_layer_count: 14/49
; update layer progress
M73 L14
M991 S0 P13 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z2.04 I-.26 J1.189 P1  F18000
G1 X93.304 Y80.581 Z2.04
G1 Z1.76
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X93.311 Y88.382 E.1651
G1 X92.95 Y88.382 E.00764
G1 X92.95 Y77.128 E.23818
G1 X93.135 Y77.076 E.00407
G1 X93.216 Y77.207 E.00325
G1 X93.272 Y77.349 E.00324
G1 X93.301 Y77.49 E.00306
G1 X93.304 Y80.521 E.06415
; WIPE_START
M204 S6000
G1 X93.306 Y82.521 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X93.287 Y90.154 Z2.16 F18000
G1 X93.273 Y95.441 Z2.16
G1 Z1.76
G1 E.4 F1800
G1 F1500
M204 S500
G1 X93.281 Y95.517 E.00162
G1 X93.266 Y95.565 E.00106
G1 X93.229 Y95.625 E.00149
G1 X92.954 Y95.743 E.00633
G1 X92.985 Y95.456 E.00611
G1 X93.027 Y95.378 E.00187
G1 X93.133 Y95.345 E.00235
G1 X93.182 Y95.358 E.00108
G1 X93.229 Y95.4 E.00135
; WIPE_START
M204 S6000
G1 X93.281 Y95.517 E-.0422
G1 X93.266 Y95.565 E-.01649
G1 X93.229 Y95.625 E-.02328
G1 X92.954 Y95.743 E-.09887
G1 X92.985 Y95.456 E-.09545
G1 X93.027 Y95.378 E-.02925
G1 X93.133 Y95.345 E-.03662
G1 X93.182 Y95.358 E-.01683
G1 X93.229 Y95.4 E-.02102
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X85.747 Y96.909 Z2.16 F18000
G1 X84.703 Y97.12 Z2.16
G1 Z1.76
G1 E.4 F1800
G1 F1500
M204 S500
G1 X84.583 Y96.956 E.00429
G1 X84.941 Y96.544 E.01154
G1 X86.92 Y96.544 E.04187
G1 X87.266 Y96.942 E.01116
G1 X87.159 Y97.104 E.0041
G1 X86.697 Y96.954 E.01029
G1 X86.324 Y96.88 E.00805
G1 X85.794 Y96.856 E.01123
G1 X85.268 Y96.928 E.01124
G1 X84.903 Y97.034 E.00803
G1 X84.758 Y97.096 E.00335
; WIPE_START
M204 S6000
G1 X84.583 Y96.956 E-.04255
G1 X84.941 Y96.544 E-.10364
G1 X86.172 Y96.544 E-.23382
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X84.881 Y102.297 Z2.16 F18000
G1 Z1.76
G1 E.4 F1800
G1 F1500
M204 S500
G1 X84.758 Y102.244 E.00281
G1 X84.479 Y102.083 E.00683
G1 X84.119 Y101.796 E.00975
G1 X83.81 Y101.442 E.00995
G1 X83.573 Y101.046 E.00975
G1 X83.451 Y100.748 E.00683
G1 X83.365 Y100.437 E.00683
G1 X83.31 Y99.979 E.00975
G1 X83.338 Y99.519 E.00975
G1 X83.405 Y99.204 E.00683
G1 X83.509 Y98.898 E.00683
G1 X83.721 Y98.489 E.00975
G1 X84.009 Y98.118 E.00995
G1 X84.358 Y97.803 E.00995
G1 X84.75 Y97.561 E.00976
G1 X85.047 Y97.434 E.00683
G1 X85.356 Y97.344 E.00683
G1 X85.813 Y97.282 E.00975
G1 X86.273 Y97.302 E.00975
G1 X86.59 Y97.365 E.00683
G1 X86.897 Y97.465 E.00683
G1 X87.309 Y97.671 E.00975
G1 X87.685 Y97.953 E.00995
G1 X87.998 Y98.29 E.00975
G1 X88.18 Y98.557 E.00683
G1 X88.329 Y98.843 E.00684
G1 X88.475 Y99.27 E.00955
G1 X88.532 Y99.588 E.00683
G1 X88.551 Y99.91 E.00683
G1 X88.511 Y100.36 E.00955
G1 X88.435 Y100.673 E.00683
G1 X88.321 Y100.975 E.00683
G1 X88.097 Y101.378 E.00975
G1 X87.796 Y101.743 E.01002
G1 X87.415 Y102.06 E.0105
G1 X87.171 Y102.209 E.00604
G1 X86.88 Y102.344 E.0068
G1 X86.437 Y102.473 E.00975
G1 X85.97 Y102.522 E.00995
G1 X85.501 Y102.487 E.00995
G1 X85.055 Y102.371 E.00975
G1 X84.936 Y102.32 E.00275
M204 S250
G1 X85.042 Y101.92 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X84.942 Y101.878 E.00213
G1 X84.71 Y101.744 E.00526
G1 X84.403 Y101.499 E.00773
G1 X84.142 Y101.2 E.0078
G1 X83.94 Y100.863 E.00774
G1 X83.839 Y100.615 E.00526
G1 X83.768 Y100.357 E.00526
G1 X83.721 Y99.967 E.00773
G1 X83.744 Y99.575 E.00774
G1 X83.8 Y99.313 E.00526
G1 X83.886 Y99.06 E.00526
G1 X84.067 Y98.711 E.00773
G1 X84.31 Y98.397 E.0078
G1 X84.604 Y98.132 E.00779
G1 X84.939 Y97.925 E.00774
G1 X85.185 Y97.82 E.00526
G1 X85.442 Y97.745 E.00526
G1 X85.831 Y97.692 E.00774
G1 X86.224 Y97.71 E.00773
G1 X86.487 Y97.762 E.00526
G1 X86.741 Y97.844 E.00526
G1 X87.093 Y98.02 E.00773
G1 X87.41 Y98.258 E.00779
G1 X87.677 Y98.546 E.00774
G1 X87.828 Y98.767 E.00526
G1 X87.951 Y99.005 E.00527
G1 X88.077 Y99.374 E.00767
G1 X88.125 Y99.637 E.00526
G1 X88.141 Y99.904 E.00526
G1 X88.106 Y100.292 E.00767
G1 X88.043 Y100.552 E.00526
G1 X87.949 Y100.803 E.00526
G1 X87.757 Y101.146 E.00774
G1 X87.505 Y101.453 E.00782
G1 X87.176 Y101.726 E.00841
G1 X86.977 Y101.848 E.00457
G1 X86.735 Y101.96 E.00525
G1 X86.358 Y102.07 E.00773
G1 X85.964 Y102.111 E.0078
G1 X85.568 Y102.082 E.00779
G1 X85.188 Y101.983 E.00773
G1 X85.097 Y101.944 E.00195
; WIPE_START
M204 S6000
G1 X84.942 Y101.878 E-.032
G1 X84.71 Y101.744 E-.05085
G1 X84.403 Y101.499 E-.07467
G1 X84.142 Y101.2 E-.07533
G1 X83.94 Y100.863 E-.07473
G1 X83.839 Y100.615 E-.05084
G1 X83.809 Y100.506 E-.02158
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X84.691 Y96.12 Z2.16 F18000
G1 Z1.76
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X92.487 Y96.12 E.16501
G1 X92.566 Y95.378 E.0158
G1 X92.66 Y95.165 E.00492
G1 X92.802 Y95.025 E.0042
G1 X92.884 Y94.979 E.00201
G1 X93.031 Y94.932 E.00325
G1 X93.226 Y94.93 E.00413
G1 X93.326 Y94.956 E.00218
G1 X93.503 Y95.058 E.00433
G1 X93.575 Y95.131 E.00218
G1 X93.634 Y95.216 E.00217
G1 X93.692 Y95.358 E.00326
G1 X93.699 Y95.605 E.00523
G1 X93.654 Y95.743 E.00307
G1 X93.538 Y95.912 E.00434
G1 X93.403 Y96.012 E.00354
G1 X93.174 Y96.11 E.00527
G1 X92.983 Y96.284 E.00546
G1 X92.868 Y96.363 E.00296
G1 X92.729 Y96.427 E.00325
G1 X92.582 Y96.466 E.00321
G1 X92.404 Y96.482 E.00378
G1 X87.427 Y96.482 E.10532
G1 X88.614 Y97.845 E.03824
G1 X88.932 Y98.346 E.01257
G1 X89.074 Y98.663 E.00735
G1 X89.158 Y98.896 E.00525
G1 X89.257 Y99.3 E.00879
G1 X89.304 Y99.68 E.00811
G1 X89.289 Y100.283 E.01276
G1 X89.231 Y100.625 E.00734
G1 X89.1 Y101.074 E.00991
G1 X88.847 Y101.609 E.01251
G1 X88.621 Y101.947 E.0086
G1 X88.353 Y102.258 E.00869
G1 X87.946 Y102.613 E.01143
G1 X87.742 Y102.754 E.00525
G1 X87.379 Y102.955 E.00879
G1 X86.873 Y103.146 E.01143
G1 X86.633 Y103.207 E.00525
G1 X86.222 Y103.269 E.00879
G1 X85.63 Y103.267 E.01254
G1 X85.038 Y103.161 E.01273
G1 X84.474 Y102.951 E.01273
G1 X84.123 Y102.757 E.00849
G1 X83.797 Y102.522 E.00849
G1 X83.502 Y102.251 E.0085
G1 X83.24 Y101.947 E.00849
G1 X83.017 Y101.613 E.00849
G1 X82.834 Y101.256 E.00849
G1 X82.696 Y100.88 E.00849
G1 X82.602 Y100.489 E.0085
G1 X82.555 Y100.081 E.00869
G1 X82.57 Y99.551 E.01122
G1 X82.649 Y99.092 E.00988
G1 X82.767 Y98.712 E.00842
G1 X82.93 Y98.345 E.00849
G1 X83.248 Y97.845 E.01254
G1 X84.434 Y96.482 E.03824
G1 X79.467 Y96.482 E.10513
G1 X79.219 Y96.453 E.00527
G1 X79.074 Y96.405 E.00324
G1 X78.815 Y96.228 E.00665
G1 X78.667 Y96.035 E.00514
G1 X78.579 Y95.814 E.00504
G1 X78.55 Y95.565 E.00531
G1 X78.55 Y77.628 E.37965
G1 X78.588 Y77.349 E.00597
G1 X78.697 Y77.118 E.00539
G1 X78.793 Y76.997 E.00328
G1 X78.898 Y76.902 E.00298
G1 X79.13 Y76.775 E.00561
G1 X79.379 Y76.723 E.00539
G1 X92.417 Y76.721 E.27595
G1 X92.64 Y76.748 E.00475
G1 X92.778 Y76.794 E.00309
G1 X92.955 Y76.889 E.00424
G1 X92.906 Y77.082 E.0042
G1 X79.886 Y77.082 E.2756
G1 X79.627 Y77.119 E.00552
G1 X79.322 Y77.273 E.00724
G1 X79.094 Y77.505 E.00687
G1 X78.949 Y77.8 E.00697
G1 X78.911 Y78.056 E.00548
G1 X78.911 Y95.155 E.36192
G1 X78.964 Y95.453 E.0064
G1 X79.152 Y95.778 E.00796
G1 X79.512 Y96.047 E.00951
G1 X79.867 Y96.12 E.00767
G1 X84.631 Y96.12 E.10084
; WIPE_START
M204 S6000
G1 X86.632 Y96.12 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X83.535 Y96.891 Z2.16 F18000
G1 Z1.76
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X79.443 Y96.891 E.08049
G1 X79.13 Y96.854 E.00619
G1 X78.917 Y96.784 E.00442
G1 X78.791 Y96.72 E.00277
G1 X78.541 Y96.535 E.00612
G1 X78.445 Y96.432 E.00277
G1 X78.313 Y96.244 E.00452
G1 X78.239 Y96.093 E.0033
G1 X78.177 Y95.902 E.00396
G1 X78.141 Y95.589 E.0062
G1 X78.141 Y77.61 E.35362
G1 X78.161 Y77.374 E.00466
G1 X78.195 Y77.231 E.00289
G1 X78.245 Y77.093 E.00289
G1 X78.353 Y76.893 E.00448
G1 X78.493 Y76.716 E.00443
G1 X78.645 Y76.579 E.00402
G1 X78.784 Y76.485 E.0033
G1 X78.99 Y76.389 E.00446
G1 X79.21 Y76.33 E.00448
G1 X79.356 Y76.313 E.00289
G1 X92.442 Y76.312 E.2574
G1 X92.73 Y76.347 E.00571
G1 X92.941 Y76.417 E.00437
G1 X93.139 Y76.524 E.00442
G1 X93.315 Y76.663 E.00442
G1 X93.465 Y76.831 E.00442
G1 X93.583 Y77.022 E.00442
G1 X93.666 Y77.231 E.00442
G1 X93.71 Y77.448 E.00436
G1 X93.72 Y88.791 E.2231
G1 X92.541 Y88.791 E.02321
G1 X92.541 Y77.491 E.22226
G1 X79.915 Y77.491 E.24833
G1 X79.752 Y77.515 E.00325
G1 X79.566 Y77.608 E.00409
G1 X79.432 Y77.744 E.00375
M73 P55 R11
G1 X79.344 Y77.923 E.00392
G1 X79.321 Y78.086 E.00323
G1 X79.321 Y95.119 E.33504
G1 X79.354 Y95.311 E.00382
G1 X79.464 Y95.501 E.00432
G1 X79.684 Y95.664 E.00539
G1 X79.909 Y95.711 E.00452
G1 X92.119 Y95.711 E.24016
G1 X92.164 Y95.294 E.00824
G1 X92.218 Y95.121 E.00358
G1 X92.321 Y94.932 E.00422
G1 X92.433 Y94.799 E.00342
G1 X92.568 Y94.687 E.00345
G1 X92.72 Y94.601 E.00343
G1 X92.947 Y94.529 E.00469
G1 X93.119 Y94.512 E.0034
G1 X93.294 Y94.525 E.00345
G1 X93.464 Y94.57 E.00346
G1 X93.623 Y94.643 E.00345
G1 X93.767 Y94.744 E.00346
G1 X93.891 Y94.869 E.00346
G1 X93.991 Y95.013 E.00345
G1 X94.095 Y95.281 E.00566
G1 X94.119 Y95.521 E.00475
G1 X94.101 Y95.691 E.00336
G1 X94.028 Y95.916 E.00464
G1 X93.906 Y96.114 E.00458
G1 X93.701 Y96.309 E.00556
G1 X93.399 Y96.459 E.00664
G1 X93.238 Y96.606 E.00429
G1 X93.071 Y96.72 E.00398
G1 X92.868 Y96.814 E.0044
G1 X92.652 Y96.871 E.00438
G1 X92.421 Y96.891 E.00456
G1 X88.326 Y96.891 E.08055
G1 X88.934 Y97.59 E.01822
G1 X89.063 Y97.767 E.00431
G1 X89.295 Y98.157 E.00892
G1 X89.454 Y98.51 E.00762
G1 X89.55 Y98.778 E.00561
G1 X89.659 Y99.22 E.00894
G1 X89.713 Y99.661 E.00873
G1 X89.714 Y100.117 E.00897
G1 X89.695 Y100.335 E.00432
G1 X89.63 Y100.717 E.00761
G1 X89.486 Y101.213 E.01017
G1 X89.333 Y101.568 E.00759
G1 X89.199 Y101.82 E.00561
G1 X88.947 Y102.195 E.00889
G1 X88.652 Y102.538 E.00891
G1 X88.193 Y102.939 E.01198
G1 X87.959 Y103.102 E.00561
G1 X87.561 Y103.322 E.00895
G1 X86.991 Y103.538 E.01198
G1 X86.714 Y103.609 E.00562
G1 X86.265 Y103.676 E.00894
G1 X86.046 Y103.689 E.00431
G1 X85.593 Y103.676 E.00891
G1 X85.145 Y103.608 E.00891
G1 X84.93 Y103.556 E.00437
G1 X84.717 Y103.491 E.00436
G1 X84.298 Y103.321 E.00891
G1 X83.904 Y103.103 E.00885
G1 X83.539 Y102.84 E.00885
G1 X83.207 Y102.536 E.00885
G1 X82.914 Y102.195 E.00885
G1 X82.663 Y101.821 E.00885
G1 X82.459 Y101.42 E.00885
G1 X82.303 Y100.998 E.00885
G1 X82.199 Y100.56 E.00885
G1 X82.147 Y100.11 E.00891
G1 X82.163 Y99.505 E.01191
G1 X82.251 Y98.996 E.01016
G1 X82.383 Y98.567 E.00883
G1 X82.566 Y98.156 E.00885
G1 X82.798 Y97.767 E.00891
G1 X82.927 Y97.59 E.00431
G1 X83.496 Y96.936 E.01704
; WIPE_START
M204 S6000
G1 X81.496 Y96.914 E-.38
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




G1 X79.318 Y96.245
G1 Z1.76
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.153473
G1 F1500
M204 S6000
G1 X79.006 Y96.02 E.00245
G1 X78.872 Y95.837 E.00145
; LINE_WIDTH: 0.127262
G1 X78.832 Y95.729 E.00058
; LINE_WIDTH: 0.0941291
G1 X78.792 Y95.622 E.00039
; WIPE_START
G1 X78.832 Y95.729 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X84.474 Y97.167 Z2.16 F18000
G1 Z1.76
G1 E.4 F1800
; LINE_WIDTH: 0.475188
G1 F1500
M204 S6000
G1 X84.3 Y97.315 E.00514
; LINE_WIDTH: 0.438759
G1 X84.099 Y97.487 E.00545
; LINE_WIDTH: 0.401694
G1 X83.921 Y97.669 E.00477
; LINE_WIDTH: 0.360269
G1 X83.723 Y97.872 E.00474
G1 X83.396 Y98.299 E.00897
G1 X83.157 Y98.761 E.00868
G1 X83.02 Y99.181 E.00736
G1 X82.95 Y99.595 E.00702
G1 X82.935 Y100.005 E.00685
G1 X82.998 Y100.522 E.00868
G1 X83.061 Y100.769 E.00426
G1 X83.184 Y101.103 E.00594
G1 X83.348 Y101.418 E.00594
G1 X83.544 Y101.716 E.00594
G1 X83.869 Y102.078 E.00813
G1 X84.327 Y102.435 E.00968
G1 X84.639 Y102.607 E.00594
G1 X84.98 Y102.745 E.00615
G1 X85.454 Y102.861 E.00814
G1 X85.961 Y102.896 E.00848
G1 X86.496 Y102.846 E.00896
G1 X86.761 Y102.778 E.00457
G1 X87.213 Y102.61 E.00805
G1 X87.625 Y102.375 E.00792
G1 X88.076 Y101.999 E.00979
G1 X88.316 Y101.714 E.00622
G1 X88.515 Y101.415 E.00601
G1 X88.741 Y100.942 E.00874
G1 X88.881 Y100.434 E.00881
G1 X88.925 Y99.928 E.00847
G1 X88.909 Y99.541 E.00646
G1 X88.834 Y99.165 E.0064
G1 X88.677 Y98.708 E.00806
G1 X88.506 Y98.373 E.00627
G1 X88.302 Y98.064 E.00618
G1 X87.933 Y97.654 E.00921
; LINE_WIDTH: 0.395482
G1 X87.808 Y97.538 E.00314
; LINE_WIDTH: 0.43143
G1 X87.683 Y97.422 E.00345
; LINE_WIDTH: 0.467633
G1 X87.557 Y97.304 E.00381
; LINE_WIDTH: 0.468551
G1 X87.395 Y97.34 E.00365
; LINE_WIDTH: 0.433919
G1 X87.234 Y97.375 E.00337
; WIPE_START
G1 X87.395 Y97.34 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
M73 P55 R10
G1 X92.698 Y96.144 Z2.16 F18000
G1 Z1.76
G1 E.4 F1800
; LINE_WIDTH: 0.110621
G1 F1500
M204 S6000
G1 X92.943 Y96.003 E.00119
; WIPE_START
G1 X92.698 Y96.144 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X88.118 Y90.038 Z2.16 F18000
G1 X78.787 Y77.598 Z2.16
G1 Z1.76
G1 E.4 F1800
; LINE_WIDTH: 0.0969952
G1 F1500
M204 S6000
G1 X78.82 Y77.482 E.00043
; LINE_WIDTH: 0.12416
G1 X78.863 Y77.371 E.00058
; LINE_WIDTH: 0.15414
G1 X79.002 Y77.192 E.00145
G1 X79.124 Y77.082 E.00105
; LINE_WIDTH: 0.12798
G1 X79.327 Y76.991 E.00113
; LINE_WIDTH: 0.0894067
G1 X79.435 Y76.955 E.00036
; CHANGE_LAYER
; Z_HEIGHT: 1.88
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F1500
G1 X79.327 Y76.991 E-.38
; WIPE_END
G1 E-.02 F1800
; layer num/total_layer_count: 15/49
; update layer progress
M73 L15
M991 S0 P14 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z2.16 I-.304 J1.178 P1  F18000
G1 X93.305 Y80.592 Z2.16
G1 Z1.88
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X93.312 Y85.92 E.11277
G1 X93.748 Y85.92 E.00923
G1 F1920
G1 X93.768 Y85.92 E.00043
G1 F2357.113
G1 X93.768 Y87.282 E.02882
G1 F1920
G1 X93.748 Y87.282 E.00043
G1 F1500
G1 X93.311 Y87.282 E.00924
G1 X93.311 Y88.382 E.02328
G1 X92.95 Y88.382 E.00765
G1 X92.95 Y77.128 E.23818
G1 X93.135 Y77.076 E.00407
G1 X93.216 Y77.207 E.00325
G1 X93.272 Y77.349 E.00324
G1 X93.301 Y77.49 E.00306
G1 X93.305 Y80.532 E.06438
; WIPE_START
M204 S6000
G1 X93.308 Y82.532 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X93.288 Y90.165 Z2.28 F18000
G1 X93.274 Y95.441 Z2.28
G1 Z1.88
G1 E.4 F1800
G1 F1500
M204 S500
G1 X93.281 Y95.517 E.00162
G1 X93.266 Y95.564 E.00105
G1 X93.229 Y95.625 E.0015
G1 X92.954 Y95.743 E.00633
G1 X92.985 Y95.456 E.00612
G1 X93.027 Y95.378 E.00187
G1 X93.133 Y95.345 E.00234
G1 X93.182 Y95.357 E.00108
G1 X93.229 Y95.401 E.00135
; WIPE_START
M204 S6000
G1 X93.281 Y95.517 E-.04217
G1 X93.266 Y95.564 E-.01635
G1 X93.229 Y95.625 E-.02348
G1 X92.954 Y95.743 E-.09881
G1 X92.985 Y95.456 E-.09546
G1 X93.027 Y95.378 E-.02925
G1 X93.133 Y95.345 E-.0365
G1 X93.182 Y95.357 E-.01683
G1 X93.229 Y95.401 E-.02115
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X85.748 Y96.913 Z2.28 F18000
G1 X84.692 Y97.126 Z2.28
G1 Z1.88
G1 E.4 F1800
G1 F1500
M204 S500
G1 X84.577 Y96.963 E.00423
G1 X84.941 Y96.544 E.01174
G1 X86.92 Y96.544 E.04188
G1 X87.273 Y96.951 E.0114
G1 X87.15 Y97.115 E.00436
G1 X86.697 Y96.953 E.01018
G1 X86.324 Y96.88 E.00804
G1 X85.81 Y96.857 E.0109
G1 X85.432 Y96.897 E.00804
G1 X85.061 Y96.981 E.00804
G1 X84.748 Y97.104 E.00712
; WIPE_START
M204 S6000
G1 X84.577 Y96.963 E-.04213
G1 X84.941 Y96.544 E-.10541
G1 X86.165 Y96.544 E-.23245
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X84.85 Y102.284 Z2.28 F18000
G1 Z1.88
G1 E.4 F1800
G1 F1500
M204 S500
G1 X84.486 Y102.089 E.00873
G1 X84.119 Y101.796 E.00995
G1 X83.816 Y101.449 E.00975
G1 X83.642 Y101.177 E.00683
G1 X83.502 Y100.886 E.00683
G1 X83.366 Y100.446 E.00975
G1 X83.31 Y99.979 E.00995
G1 X83.338 Y99.519 E.00975
G1 X83.404 Y99.205 E.00679
G1 X83.494 Y98.937 E.00599
G1 X83.719 Y98.492 E.01055
G1 X84.009 Y98.118 E.01002
G1 X84.358 Y97.803 E.00995
G1 X84.758 Y97.556 E.00995
G1 X85.187 Y97.388 E.00975
G1 X85.501 Y97.316 E.00683
G1 X85.822 Y97.282 E.00683
G1 X86.273 Y97.302 E.00955
G1 X86.59 Y97.365 E.00683
G1 X86.888 Y97.462 E.00664
G1 X87.172 Y97.593 E.00663
G1 X87.447 Y97.763 E.00683
G1 X87.791 Y98.055 E.00956
G1 X88.002 Y98.297 E.00679
G1 X88.163 Y98.53 E.00599
G1 X88.384 Y98.976 E.01055
G1 X88.51 Y99.433 E.01002
G1 X88.552 Y99.901 E.00995
G1 X88.51 Y100.372 E.01002
G1 X88.372 Y100.851 E.01055
G1 X88.255 Y101.109 E.00599
G1 X88.091 Y101.385 E.00679
G1 X87.796 Y101.743 E.00982
G1 X87.412 Y102.062 E.01055
G1 X87.171 Y102.209 E.00599
G1 X86.879 Y102.344 E.00679
G1 X86.437 Y102.473 E.00975
G1 X85.979 Y102.521 E.00975
G1 X85.658 Y102.507 E.00679
G1 X85.379 Y102.462 E.00599
G1 X84.903 Y102.313 E.01055
G1 X84.903 Y102.313 E.00002
M204 S250
G1 X85.044 Y101.924 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X84.713 Y101.746 E.00739
G1 X84.403 Y101.499 E.0078
G1 X84.144 Y101.203 E.00773
G1 X84 Y100.977 E.00527
G1 X83.884 Y100.736 E.00526
G1 X83.768 Y100.361 E.00773
G1 X83.721 Y99.967 E.0078
G1 X83.744 Y99.574 E.00774
G1 X83.8 Y99.313 E.00525
G1 X83.873 Y99.095 E.00453
G1 X84.067 Y98.712 E.00845
G1 X84.31 Y98.397 E.00782
G1 X84.605 Y98.132 E.0078
G1 X84.942 Y97.924 E.00779
G1 X85.308 Y97.78 E.00773
G1 X85.568 Y97.72 E.00526
G1 X85.835 Y97.692 E.00526
G1 X86.224 Y97.71 E.00767
G1 X86.487 Y97.762 E.00526
G1 X86.738 Y97.843 E.0052
G1 X86.978 Y97.954 E.0052
G1 X87.205 Y98.095 E.00526
G1 X87.503 Y98.347 E.00767
G1 X87.679 Y98.548 E.00525
G1 X87.809 Y98.738 E.00453
G1 X88 Y99.123 E.00845
G1 X88.106 Y99.506 E.00782
G1 X88.141 Y99.901 E.00779
G1 X88.106 Y100.297 E.00782
G1 X87.987 Y100.71 E.00846
G1 X87.892 Y100.92 E.00453
G1 X87.755 Y101.149 E.00525
G1 X87.505 Y101.453 E.00776
G1 X87.174 Y101.728 E.00845
G1 X86.978 Y101.848 E.00453
G1 X86.735 Y101.96 E.00525
G1 X86.358 Y102.07 E.00773
G1 X85.967 Y102.111 E.00774
G1 X85.7 Y102.099 E.00525
G1 X85.473 Y102.063 E.00453
G1 X85.099 Y101.946 E.0077
; WIPE_START
M204 S6000
G1 X84.713 Y101.746 E-.0827
G1 X84.403 Y101.499 E-.07531
G1 X84.144 Y101.203 E-.07468
G1 X84 Y100.977 E-.05087
G1 X83.884 Y100.736 E-.0508
G1 X83.813 Y100.507 E-.04563
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X84.691 Y96.12 Z2.28 F18000
G1 Z1.88
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X92.487 Y96.12 E.16501
G1 X92.566 Y95.378 E.01579
G1 X92.66 Y95.165 E.00492
G1 X92.801 Y95.026 E.0042
G1 X92.886 Y94.978 E.00205
G1 X93.03 Y94.932 E.00321
G1 X93.226 Y94.93 E.00414
G1 X93.325 Y94.956 E.00218
G1 X93.503 Y95.058 E.00433
G1 X93.575 Y95.131 E.00218
G1 X93.633 Y95.215 E.00217
G1 X93.692 Y95.359 E.00328
G1 X93.698 Y95.606 E.00523
G1 X93.654 Y95.743 E.00304
G1 X93.537 Y95.913 E.00437
G1 X93.402 Y96.012 E.00355
G1 X93.171 Y96.111 E.00532
G1 X92.999 Y96.272 E.00499
G1 X92.866 Y96.364 E.00341
G1 X92.728 Y96.427 E.00321
G1 X92.582 Y96.466 E.00321
G1 X92.404 Y96.482 E.00378
G1 X87.428 Y96.482 E.10533
G1 X88.614 Y97.845 E.03824
G1 X88.721 Y97.992 E.00386
G1 X88.935 Y98.353 E.00888
G1 X89.159 Y98.901 E.01254
G1 X89.286 Y99.489 E.01273
G1 X89.305 Y100.091 E.01273
G1 X89.258 Y100.491 E.00852
G1 X89.103 Y101.067 E.01263
G1 X88.847 Y101.609 E.01269
G1 X88.621 Y101.947 E.0086
G1 X88.353 Y102.258 E.00868
G1 X87.95 Y102.61 E.01134
G1 X87.742 Y102.754 E.00535
G1 X87.379 Y102.955 E.00879
G1 X87.024 Y103.099 E.00811
G1 X86.628 Y103.208 E.00869
G1 X86.222 Y103.269 E.00868
G1 X85.63 Y103.267 E.01254
G1 X85.047 Y103.163 E.01254
G1 X84.661 Y103.033 E.00861
G1 X84.238 Y102.825 E.00998
G1 X83.804 Y102.529 E.01112
G1 X83.502 Y102.251 E.00869
G1 X83.24 Y101.947 E.00849
G1 X83.017 Y101.613 E.0085
G1 X82.834 Y101.256 E.00849
G1 X82.696 Y100.879 E.00849
G1 X82.574 Y100.298 E.01257
G1 X82.553 Y99.957 E.00725
G1 X82.577 Y99.486 E.00997
G1 X82.648 Y99.095 E.00842
G1 X82.767 Y98.712 E.00849
G1 X82.93 Y98.345 E.00849
G1 X83.248 Y97.845 E.01253
G1 X84.433 Y96.482 E.03824
G1 X79.467 Y96.482 E.10513
G1 X79.228 Y96.454 E.00508
G1 X79.029 Y96.381 E.0045
G1 X78.898 Y96.301 E.00324
G1 X78.72 Y96.119 E.00539
G1 X78.669 Y96.041 E.00197
G1 X78.579 Y95.812 E.0052
G1 X78.55 Y95.565 E.00527
G1 X78.55 Y77.628 E.37965
G1 X78.588 Y77.349 E.00597
G1 X78.697 Y77.118 E.00539
G1 X78.793 Y76.996 E.00329
G1 X78.896 Y76.903 E.00295
G1 X79.132 Y76.775 E.00568
G1 X79.383 Y76.723 E.00542
G1 X92.419 Y76.721 E.27591
G1 X92.64 Y76.748 E.00471
G1 X92.779 Y76.794 E.0031
G1 X92.955 Y76.889 E.00424
G1 X92.906 Y77.082 E.0042
G1 X79.876 Y77.082 E.27579
G1 X79.588 Y77.133 E.00621
G1 X79.318 Y77.278 E.00649
G1 X79.101 Y77.495 E.00649
G1 X78.949 Y77.797 E.00716
M73 P56 R10
G1 X78.911 Y78.056 E.00553
G1 X78.911 Y95.155 E.36192
G1 X78.964 Y95.453 E.0064
G1 X79.147 Y95.77 E.00776
G1 X79.475 Y96.029 E.00883
G1 X79.858 Y96.12 E.00834
G1 X84.631 Y96.12 E.10103
; WIPE_START
M204 S6000
G1 X86.631 Y96.12 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X83.535 Y96.891 Z2.28 F18000
G1 Z1.88
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X79.443 Y96.891 E.08049
G1 X79.133 Y96.855 E.00613
G1 X78.849 Y96.751 E.00594
G1 X78.658 Y96.633 E.00442
G1 X78.548 Y96.541 E.00283
G1 X78.394 Y96.368 E.00454
G1 X78.314 Y96.246 E.00289
G1 X78.248 Y96.114 E.00289
G1 X78.177 Y95.901 E.00442
G1 X78.141 Y95.589 E.00619
G1 X78.141 Y77.61 E.35362
G1 X78.161 Y77.374 E.00466
G1 X78.195 Y77.231 E.00289
G1 X78.245 Y77.093 E.00289
G1 X78.353 Y76.893 E.00448
G1 X78.493 Y76.716 E.00444
G1 X78.644 Y76.58 E.00398
G1 X78.784 Y76.485 E.00333
G1 X78.99 Y76.389 E.00447
G1 X79.186 Y76.335 E.00398
G1 X79.357 Y76.313 E.00339
G1 X92.444 Y76.312 E.25741
G1 X92.73 Y76.347 E.00567
G1 X92.941 Y76.417 E.00438
G1 X93.139 Y76.524 E.00442
G1 X93.315 Y76.663 E.00442
G1 X93.465 Y76.831 E.00442
G1 X93.583 Y77.022 E.00442
G1 X93.666 Y77.231 E.00442
G1 X93.71 Y77.448 E.00436
G1 X93.72 Y85.111 E.15071
G1 X93.721 Y85.511 E.00787
G1 F746.167
G1 X93.762 Y85.511 E.0008
G1 F600
G1 X94.131 Y85.511 E.00726
; FEATURE: Overhang wall
; LINE_WIDTH: 0.45

G1 X94.178 Y85.511 E.001
G1 X94.178 Y87.691 E.04614
G1 X94.131 Y87.691 E.001
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 X93.762 Y87.691 E.00726
G1 F747.19
G1 X93.721 Y87.691 E.00081
G1 F1500
G1 X93.721 Y88.091 E.00787
G1 X93.721 Y88.791 E.01377
G1 X92.541 Y88.791 E.02321
G1 X92.541 Y77.491 E.22226
G1 X79.912 Y77.491 E.24839
G1 X79.724 Y77.524 E.00376
G1 X79.565 Y77.61 E.00355
G1 X79.437 Y77.738 E.00355
G1 X79.345 Y77.922 E.00406
G1 X79.321 Y78.086 E.00325
G1 X79.321 Y95.119 E.33504
G1 X79.354 Y95.311 E.00382
G1 X79.462 Y95.498 E.00425
G1 X79.657 Y95.652 E.00489
G1 X79.906 Y95.711 E.00503
G1 X92.119 Y95.711 E.24023
G1 X92.164 Y95.295 E.00823
G1 X92.218 Y95.12 E.00361
G1 X92.321 Y94.933 E.0042
G1 X92.433 Y94.8 E.00342
G1 X92.568 Y94.688 E.00345
G1 X92.721 Y94.601 E.00347
G1 X92.947 Y94.529 E.00465
G1 X93.118 Y94.512 E.0034
G1 X93.293 Y94.525 E.00345
G1 X93.464 Y94.569 E.00346
G1 X93.623 Y94.643 E.00345
G1 X93.767 Y94.744 E.00345
G1 X93.891 Y94.868 E.00346
G1 X93.991 Y95.013 E.00345
G1 X94.095 Y95.282 E.00569
G1 X94.119 Y95.521 E.00472
G1 X94.101 Y95.692 E.00339
G1 X94.028 Y95.915 E.00461
G1 X93.907 Y96.114 E.00458
G1 X93.702 Y96.309 E.00556
G1 X93.398 Y96.459 E.00667
G1 X93.256 Y96.592 E.00382
G1 X93.07 Y96.72 E.00445
G1 X92.868 Y96.814 E.00438
G1 X92.653 Y96.871 E.00438
G1 X92.421 Y96.891 E.00456
G1 X88.326 Y96.891 E.08055
G1 X88.934 Y97.59 E.01822
G1 X89.063 Y97.767 E.00431
G1 X89.296 Y98.159 E.00897
G1 X89.391 Y98.356 E.00431
G1 X89.551 Y98.78 E.00891
G1 X89.659 Y99.22 E.00891
G1 X89.713 Y99.661 E.00873
G1 X89.714 Y100.114 E.00891
G1 X89.662 Y100.561 E.00886
G1 X89.575 Y100.934 E.00752
G1 X89.487 Y101.211 E.00572
G1 X89.335 Y101.563 E.00755
G1 X89.199 Y101.82 E.00571
G1 X88.947 Y102.195 E.00889
G1 X88.652 Y102.538 E.00891
G1 X88.197 Y102.937 E.01189
G1 X87.959 Y103.102 E.00571
G1 X87.561 Y103.322 E.00894
G1 X87.15 Y103.489 E.00873
G1 X86.713 Y103.609 E.00891
G1 X86.265 Y103.676 E.00891
G1 X86.046 Y103.689 E.00431
G1 X85.593 Y103.676 E.00891
G1 X85.145 Y103.608 E.00891
G1 X84.933 Y103.557 E.00431
G1 X84.505 Y103.412 E.00889
G1 X84.037 Y103.182 E.01025
G1 X83.715 Y102.976 E.00752
G1 X83.541 Y102.842 E.00431
G1 X83.207 Y102.536 E.00891
G1 X82.914 Y102.195 E.00885
G1 X82.663 Y101.821 E.00885
G1 X82.459 Y101.42 E.00885
G1 X82.303 Y100.998 E.00885
G1 X82.198 Y100.557 E.00891
G1 X82.143 Y99.959 E.01182
G1 X82.169 Y99.438 E.01025
G1 X82.25 Y98.997 E.00883
G1 X82.383 Y98.567 E.00885
G1 X82.566 Y98.156 E.00885
G1 X82.798 Y97.767 E.00891
G1 X82.927 Y97.59 E.0043
G1 X83.496 Y96.936 E.01705
; WIPE_START
M204 S6000
G1 X81.496 Y96.914 E-.38
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




G1 X79.359 Y96.245
G1 Z1.88
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.134216
G1 F1500
M204 S6000
G1 X79.152 Y96.129 E.00128
; LINE_WIDTH: 0.149237
G1 X78.939 Y95.953 E.00171
G1 X78.778 Y95.627 E.00224
; WIPE_START
G1 X78.939 Y95.953 E-.21581
G1 X79.152 Y96.129 E-.16419
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X84.466 Y97.174 Z2.28 F18000
G1 Z1.88
G1 E.4 F1800
; LINE_WIDTH: 0.473067
G1 F1500
M204 S6000
G1 X84.296 Y97.318 E.00499
; LINE_WIDTH: 0.438182
G1 X84.099 Y97.487 E.00533
; LINE_WIDTH: 0.401797
G1 X83.921 Y97.669 E.00478
; LINE_WIDTH: 0.360629
G1 X83.723 Y97.872 E.00475
G1 X83.392 Y98.305 E.00909
G1 X83.15 Y98.78 E.00892
G1 X83.037 Y99.115 E.0059
G1 X82.962 Y99.481 E.00624
G1 X82.933 Y99.976 E.00828
G1 X82.977 Y100.413 E.00733
G1 X83.064 Y100.768 E.00611
G1 X83.184 Y101.103 E.00594
G1 X83.346 Y101.42 E.00595
G1 X83.506 Y101.666 E.0049
G1 X83.777 Y101.985 E.00699
G1 X84.048 Y102.231 E.00611
G1 X84.429 Y102.492 E.00772
G1 X84.771 Y102.667 E.00643
G1 X85.148 Y102.792 E.00664
G1 X85.664 Y102.888 E.00875
G1 X86.188 Y102.885 E.00876
G1 X86.525 Y102.841 E.00568
G1 X87.001 Y102.702 E.00828
G1 X87.357 Y102.537 E.00656
G1 X87.642 Y102.363 E.00558
G1 X88.075 Y101.999 E.00945
G1 X88.392 Y101.612 E.00836
G1 X88.592 Y101.275 E.00655
G1 X88.745 Y100.934 E.00624
G1 X88.885 Y100.423 E.00885
G1 X88.928 Y99.916 E.00851
G1 X88.885 Y99.372 E.00912
G1 X88.741 Y98.857 E.00893
G1 X88.597 Y98.537 E.00585
G1 X88.312 Y98.077 E.00904
G1 X88.049 Y97.775 E.00669
; LINE_WIDTH: 0.380235
G1 X87.877 Y97.605 E.00429
; LINE_WIDTH: 0.419781
G1 X87.678 Y97.411 E.00545
; LINE_WIDTH: 0.468115
G1 X87.38 Y97.162 E.00857
; WIPE_START
G1 X87.678 Y97.411 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X92.698 Y96.143 Z2.28 F18000
G1 Z1.88
G1 E.4 F1800
; LINE_WIDTH: 0.10958
G1 F1500
M204 S6000
G1 X92.944 Y96.003 E.00118
; WIPE_START
G1 X92.698 Y96.143 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X93.253 Y88.531 Z2.28 F18000
G1 X93.359 Y87.07 Z2.28
G1 Z1.88
G1 E.4 F1800
; LINE_WIDTH: 0.420042
G1 F1500
M204 S6000
G1 X93.359 Y86.132 E.01844
; WIPE_START
G1 X93.359 Y87.07 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X87.183 Y82.586 Z2.28 F18000
G1 X79.427 Y76.955 Z2.28
G1 Z1.88
G1 E.4 F1800
; LINE_WIDTH: 0.0897991
G1 F1500
M204 S6000
G1 X79.324 Y76.991 E.00035
; LINE_WIDTH: 0.130059
G1 X79.125 Y77.082 E.00114
; LINE_WIDTH: 0.153615
G1 X79.003 Y77.191 E.00105
G1 X78.864 Y77.371 E.00145
; LINE_WIDTH: 0.125541
G1 X78.82 Y77.482 E.00059
; LINE_WIDTH: 0.0974885
G1 X78.787 Y77.598 E.00043
; CHANGE_LAYER
; Z_HEIGHT: 2
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F1500
G1 X78.82 Y77.482 E-.38
; WIPE_END
G1 E-.02 F1800
; layer num/total_layer_count: 16/49
; update layer progress
M73 L16
M991 S0 P15 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z2.28 I-.593 J1.063 P1  F18000
G1 X93.94 Y85.92 Z2.28
G1 Z2
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X93.94 Y87.282 E.02882
G1 X93.311 Y87.282 E.0133
G1 X93.311 Y88.382 E.02328
G1 X92.95 Y88.382 E.00765
G1 X92.95 Y77.128 E.23818
G1 X93.135 Y77.076 E.00407
G1 X93.216 Y77.207 E.00325
G1 X93.272 Y77.349 E.00324
G1 X93.301 Y77.49 E.00306
G1 X93.312 Y85.92 E.17842
G1 X93.88 Y85.92 E.01201
; WIPE_START
M204 S6000
G1 X93.94 Y87.282 E-.25894
G1 X93.311 Y87.282 E-.11939
G1 X93.311 Y87.29 E-.00167
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X93.276 Y94.923 Z2.4 F18000
G1 X93.274 Y95.441 Z2.4
G1 Z2
G1 E.4 F1800
G1 F1500
M204 S500
G1 X93.281 Y95.517 E.00162
G1 X93.266 Y95.564 E.00104
G1 X93.229 Y95.625 E.00151
G1 X92.954 Y95.743 E.00633
G1 X92.985 Y95.456 E.00611
G1 X93.027 Y95.378 E.00188
G1 X93.132 Y95.345 E.00233
G1 X93.182 Y95.357 E.00108
G1 X93.229 Y95.401 E.00136
; WIPE_START
M204 S6000
G1 X93.281 Y95.517 E-.04215
G1 X93.266 Y95.564 E-.01622
G1 X93.229 Y95.625 E-.02365
G1 X92.954 Y95.743 E-.09876
G1 X92.985 Y95.456 E-.0954
G1 X93.027 Y95.378 E-.02931
G1 X93.132 Y95.345 E-.03644
G1 X93.182 Y95.357 E-.01682
G1 X93.229 Y95.401 E-.02126
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X85.745 Y96.896 Z2.4 F18000
G1 X84.73 Y97.099 Z2.4
G1 Z2
G1 E.4 F1800
G1 F1500
M204 S500
G1 X84.624 Y96.936 E.00413
G1 X84.975 Y96.544 E.01113
G1 X86.92 Y96.544 E.04116
G1 X87.266 Y96.942 E.01116
G1 X87.159 Y97.104 E.0041
G1 X86.697 Y96.954 E.01029
G1 X86.324 Y96.88 E.00805
G1 X85.794 Y96.856 E.01123
G1 X85.252 Y96.93 E.01157
G1 X84.787 Y97.081 E.01035
; WIPE_START
M204 S6000
G1 X84.624 Y96.936 E-.04152
G1 X84.975 Y96.544 E-.09988
G1 X86.231 Y96.544 E-.2386
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X84.88 Y102.296 Z2.4 F18000
G1 Z2
G1 E.4 F1800
G1 F1500
M204 S500
G1 X84.759 Y102.244 E.0028
G1 X84.479 Y102.083 E.00684
G1 X84.119 Y101.796 E.00975
G1 X83.81 Y101.442 E.00994
G1 X83.573 Y101.046 E.00975
G1 X83.451 Y100.748 E.00683
G1 X83.365 Y100.437 E.00683
G1 X83.31 Y99.979 E.00975
M73 P57 R10
G1 X83.338 Y99.51 E.00995
G1 X83.447 Y99.063 E.00975
G1 X83.57 Y98.764 E.00683
G1 X83.727 Y98.482 E.00683
G1 X84.009 Y98.118 E.00975
G1 X84.351 Y97.809 E.00975
G1 X84.62 Y97.632 E.00683
G1 X84.909 Y97.487 E.00683
G1 X85.347 Y97.345 E.00975
G1 X85.813 Y97.282 E.00995
G1 X86.273 Y97.302 E.00975
G1 X86.59 Y97.365 E.00683
G1 X86.897 Y97.465 E.00683
G1 X87.309 Y97.671 E.00975
G1 X87.685 Y97.953 E.00994
G1 X88.005 Y98.297 E.00995
G1 X88.258 Y98.693 E.00995
G1 X88.432 Y99.12 E.00975
G1 X88.508 Y99.431 E.00679
G1 X88.543 Y99.707 E.00588
G1 X88.538 Y100.166 E.00971
G1 X88.437 Y100.67 E.01089
G1 X88.262 Y101.098 E.00979
G1 X88.12 Y101.34 E.00593
G1 X87.901 Y101.63 E.00768
G1 X87.572 Y101.944 E.00964
G1 X87.308 Y102.13 E.00683
G1 X87.024 Y102.283 E.00682
G1 X86.59 Y102.438 E.00975
G1 X86.127 Y102.515 E.00995
G1 X85.668 Y102.508 E.00971
G1 X85.391 Y102.464 E.00593
G1 X85.05 Y102.369 E.00749
G1 X84.935 Y102.32 E.00265
M204 S250
G1 X85.041 Y101.92 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X84.942 Y101.878 E.00211
G1 X84.71 Y101.744 E.00527
G1 X84.403 Y101.499 E.00773
G1 X84.142 Y101.2 E.00779
G1 X83.94 Y100.863 E.00774
G1 X83.839 Y100.615 E.00526
G1 X83.768 Y100.357 E.00526
G1 X83.721 Y99.967 E.00773
G1 X83.744 Y99.571 E.0078
G1 X83.838 Y99.19 E.00773
G1 X83.939 Y98.942 E.00526
G1 X84.069 Y98.708 E.00526
G1 X84.31 Y98.397 E.00773
G1 X84.602 Y98.134 E.00774
G1 X84.825 Y97.987 E.00526
G1 X85.065 Y97.867 E.00526
G1 X85.439 Y97.745 E.00773
G1 X85.831 Y97.692 E.0078
G1 X86.224 Y97.71 E.00773
G1 X86.487 Y97.762 E.00526
G1 X86.741 Y97.844 E.00526
G1 X87.093 Y98.02 E.00774
G1 X87.41 Y98.258 E.00779
G1 X87.68 Y98.548 E.0078
G1 X87.893 Y98.882 E.0078
G1 X88.042 Y99.246 E.00774
G1 X88.105 Y99.506 E.00525
G1 X88.134 Y99.731 E.00446
G1 X88.13 Y100.123 E.00772
G1 X88.044 Y100.551 E.00859
G1 X87.894 Y100.916 E.00774
G1 X87.779 Y101.112 E.00448
G1 X87.594 Y101.357 E.00603
G1 X87.311 Y101.627 E.0077
G1 X87.092 Y101.781 E.00526
G1 X86.857 Y101.908 E.00526
G1 X86.487 Y102.041 E.00774
G1 X86.096 Y102.106 E.0078
G1 X85.703 Y102.1 E.00772
G1 X85.479 Y102.064 E.00448
G1 X85.186 Y101.982 E.00597
G1 X85.096 Y101.944 E.00193
; WIPE_START
M204 S6000
G1 X84.942 Y101.878 E-.03183
G1 X84.71 Y101.744 E-.05088
G1 X84.403 Y101.499 E-.07469
G1 X84.142 Y101.2 E-.07527
G1 X83.94 Y100.863 E-.07474
G1 X83.839 Y100.615 E-.05081
G1 X83.808 Y100.505 E-.02178
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X84.728 Y96.12 Z2.4 F18000
G1 Z2
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X92.488 Y96.12 E.16423
G1 X92.566 Y95.379 E.01578
G1 X92.66 Y95.166 E.00493
G1 X92.801 Y95.026 E.0042
G1 X92.886 Y94.978 E.00208
G1 X93.029 Y94.932 E.00317
G1 X93.225 Y94.93 E.00415
G1 X93.325 Y94.956 E.00218
G1 X93.502 Y95.058 E.00433
G1 X93.575 Y95.131 E.00217
G1 X93.633 Y95.215 E.00218
G1 X93.692 Y95.36 E.00331
G1 X93.698 Y95.607 E.00522
G1 X93.654 Y95.742 E.00301
G1 X93.537 Y95.914 E.0044
G1 X93.401 Y96.013 E.00355
G1 X93.171 Y96.111 E.00529
G1 X92.999 Y96.272 E.00499
G1 X92.866 Y96.364 E.0034
G1 X92.729 Y96.427 E.00321
G1 X92.582 Y96.466 E.00321
G1 X92.404 Y96.482 E.00379
G1 X87.428 Y96.482 E.10532
G1 X88.614 Y97.845 E.03824
G1 X88.721 Y97.992 E.00386
G1 X88.935 Y98.353 E.00888
G1 X89.159 Y98.901 E.01254
G1 X89.285 Y99.482 E.01258
G1 X89.309 Y99.829 E.00735
G1 X89.305 Y100.095 E.00564
G1 X89.232 Y100.616 E.01113
G1 X89.1 Y101.075 E.01012
G1 X88.847 Y101.609 E.01251
G1 X88.621 Y101.947 E.0086
G1 X88.353 Y102.258 E.00868
G1 X87.897 Y102.65 E.01273
G1 X87.441 Y102.923 E.01124
G1 X87.208 Y103.03 E.00544
G1 X86.814 Y103.164 E.00879
G1 X86.231 Y103.267 E.01254
G1 X85.639 Y103.269 E.01254
G1 X85.038 Y103.161 E.01293
G1 X84.474 Y102.951 E.01273
G1 X84.123 Y102.757 E.00849
G1 X83.797 Y102.522 E.00849
G1 X83.502 Y102.251 E.0085
G1 X83.24 Y101.947 E.00849
G1 X83.017 Y101.613 E.00849
G1 X82.834 Y101.256 E.00849
G1 X82.696 Y100.879 E.00849
G1 X82.602 Y100.489 E.0085
G1 X82.556 Y100.091 E.00849
G1 X82.574 Y99.499 E.01253
G1 X82.648 Y99.095 E.00869
G1 X82.767 Y98.712 E.00849
G1 X82.93 Y98.345 E.00849
G1 X83.137 Y97.999 E.00853
G1 X83.342 Y97.73 E.00716
G1 X84.461 Y96.482 E.03549
G1 X79.467 Y96.482 E.10571
G1 X79.228 Y96.454 E.00508
G1 X78.955 Y96.34 E.00626
G1 X78.828 Y96.24 E.00343
G1 X78.72 Y96.119 E.00343
G1 X78.627 Y95.957 E.00394
G1 X78.579 Y95.812 E.00324
G1 X78.55 Y95.565 E.00527
G1 X78.55 Y77.628 E.37965
G1 X78.586 Y77.355 E.00582
G1 X78.693 Y77.122 E.00542
G1 X78.793 Y76.996 E.0034
G1 X78.895 Y76.904 E.00292
G1 X79.13 Y76.775 E.00567
G1 X79.379 Y76.723 E.00539
G1 X92.42 Y76.721 E.27602
G1 X92.64 Y76.748 E.00468
G1 X92.778 Y76.794 E.0031
G1 X92.955 Y76.889 E.00424
G1 X92.906 Y77.082 E.0042
G1 X79.876 Y77.082 E.27579
G1 X79.588 Y77.132 E.0062
G1 X79.31 Y77.282 E.00669
G1 X79.077 Y77.529 E.00717
G1 X78.948 Y77.806 E.00649
G1 X78.911 Y78.056 E.00533
G1 X78.911 Y95.155 E.36192
G1 X78.964 Y95.453 E.00639
G1 X79.15 Y95.776 E.0079
G1 X79.5 Y96.041 E.00929
G1 X79.864 Y96.12 E.00788
G1 X84.668 Y96.12 E.10169
; WIPE_START
M204 S6000
G1 X86.668 Y96.12 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X83.544 Y96.891 Z2.4 F18000
G1 Z2
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X79.443 Y96.891 E.08067
G1 X79.133 Y96.855 E.00613
G1 X78.846 Y96.75 E.00601
G1 X78.725 Y96.68 E.00277
G1 X78.546 Y96.539 E.00448
G1 X78.394 Y96.368 E.00448
G1 X78.314 Y96.246 E.00289
G1 X78.248 Y96.114 E.00289
G1 X78.177 Y95.901 E.00442
G1 X78.141 Y95.589 E.00619
G1 X78.141 Y77.61 E.35362
G1 X78.161 Y77.374 E.00466
G1 X78.195 Y77.233 E.00284
G1 X78.269 Y77.043 E.00401
G1 X78.352 Y76.894 E.00336
G1 X78.493 Y76.716 E.00447
G1 X78.642 Y76.581 E.00395
G1 X78.784 Y76.485 E.00337
G1 X78.99 Y76.389 E.00446
G1 X79.21 Y76.33 E.00448
G1 X79.356 Y76.313 E.00289
G1 X92.446 Y76.312 E.25747
G1 X92.73 Y76.347 E.00564
G1 X92.941 Y76.417 E.00437
G1 X93.139 Y76.524 E.00442
G1 X93.315 Y76.663 E.00441
G1 X93.465 Y76.831 E.00442
G1 X93.583 Y77.022 E.00442
G1 X93.666 Y77.231 E.00442
G1 X93.71 Y77.448 E.00436
G1 X93.721 Y85.511 E.15858
G1 X94.219 Y85.511 E.00979
G1 F1870.275
G1 X94.349 Y85.511 E.00256
G1 F1320
G1 X94.349 Y87.691 E.04288
G1 F1668.612
G1 X94.219 Y87.691 E.00256
G1 F1500
G1 X93.721 Y87.691 E.0098
G1 X93.721 Y88.791 E.02164
G1 X92.541 Y88.791 E.02321
G1 X92.541 Y77.491 E.22226
G1 X79.912 Y77.491 E.24839
G1 X79.724 Y77.524 E.00376
G1 X79.562 Y77.611 E.00362
G1 X79.42 Y77.762 E.00406
G1 X79.344 Y77.925 E.00355
G1 X79.321 Y78.086 E.00319
G1 X79.321 Y95.119 E.33504
G1 X79.354 Y95.31 E.00382
G1 X79.463 Y95.5 E.0043
G1 X79.675 Y95.66 E.00523
G1 X79.908 Y95.711 E.00468
G1 X92.119 Y95.711 E.24019
G1 X92.163 Y95.296 E.00821
G1 X92.218 Y95.119 E.00363
G1 X92.321 Y94.933 E.00418
G1 X92.433 Y94.8 E.00342
G1 X92.567 Y94.688 E.00345
G1 X92.722 Y94.6 E.0035
G1 X92.946 Y94.529 E.00462
G1 X93.118 Y94.512 E.0034
G1 X93.293 Y94.525 E.00345
G1 X93.463 Y94.569 E.00346
G1 X93.622 Y94.643 E.00345
G1 X93.767 Y94.743 E.00346
G1 X93.89 Y94.868 E.00345
G1 X93.991 Y95.012 E.00346
G1 X94.096 Y95.284 E.00572
G1 X94.119 Y95.52 E.00468
G1 X94.1 Y95.693 E.00343
G1 X94.028 Y95.915 E.00457
G1 X93.907 Y96.114 E.00459
G1 X93.702 Y96.309 E.00556
G1 X93.398 Y96.459 E.00667
G1 X93.256 Y96.592 E.00382
G1 X93.07 Y96.72 E.00444
G1 X92.868 Y96.814 E.00438
G1 X92.652 Y96.871 E.00438
G1 X92.421 Y96.891 E.00456
G1 X88.326 Y96.891 E.08055
G1 X88.934 Y97.59 E.01823
G1 X89.063 Y97.767 E.0043
G1 X89.296 Y98.159 E.00897
G1 X89.391 Y98.356 E.00431
G1 X89.551 Y98.78 E.00891
G1 X89.659 Y99.22 E.00891
G1 X89.718 Y99.817 E.0118
G1 X89.714 Y100.115 E.00586
G1 X89.632 Y100.707 E.01176
G1 X89.486 Y101.213 E.01036
G1 X89.337 Y101.559 E.0074
G1 X89.199 Y101.82 E.0058
G1 X88.947 Y102.195 E.00888
G1 X88.652 Y102.538 E.00891
G1 X88.495 Y102.691 E.00431
G1 X88.141 Y102.979 E.00897
G1 X87.627 Y103.288 E.0118
G1 X87.359 Y103.411 E.0058
G1 X86.928 Y103.557 E.00894
G1 X86.716 Y103.608 E.00431
G1 X86.268 Y103.676 E.00891
G1 X85.815 Y103.689 E.00891
G1 X85.596 Y103.676 E.00431
G1 X85.145 Y103.608 E.00897
G1 X84.717 Y103.491 E.00873
G1 X84.298 Y103.321 E.00891
G1 X83.904 Y103.103 E.00885
G1 X83.539 Y102.84 E.00885
G1 X83.207 Y102.536 E.00885
G1 X82.914 Y102.195 E.00885
G1 X82.663 Y101.821 E.00885
G1 X82.459 Y101.42 E.00885
G1 X82.303 Y100.998 E.00885
G1 X82.199 Y100.56 E.00885
G1 X82.147 Y100.113 E.00885
G1 X82.148 Y99.661 E.00891
G1 X82.169 Y99.443 E.0043
G1 X82.25 Y98.997 E.00891
G1 X82.383 Y98.567 E.00885
G1 X82.566 Y98.156 E.00885
G1 X82.797 Y97.769 E.00886
G1 X83.026 Y97.469 E.00743
G1 X83.504 Y96.936 E.01409
; WIPE_START
M204 S6000
G1 X81.505 Y96.914 E-.38
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




G1 X79.371 Y96.248
G1 Z2
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.139555
G1 F1500
M204 S6000
G1 X79.143 Y96.123 E.00147
; LINE_WIDTH: 0.148719
G1 X78.938 Y95.953 E.00163
G1 X78.778 Y95.626 E.00223
; WIPE_START
G1 X78.938 Y95.953 E-.21948
G1 X79.143 Y96.123 E-.16052
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X84.505 Y97.141 Z2.4 F18000
G1 Z2
G1 E.4 F1800
; LINE_WIDTH: 0.469535
G1 F1500
M204 S6000
G1 X84.309 Y97.31 E.00571
; LINE_WIDTH: 0.431266
G1 X84.092 Y97.498 E.00581
; LINE_WIDTH: 0.396783
G1 X83.917 Y97.674 E.0046
; LINE_WIDTH: 0.360315
G1 X83.722 Y97.872 E.00464
G1 X83.405 Y98.285 E.00869
G1 X83.269 Y98.521 E.00455
G1 X83.124 Y98.846 E.00594
G1 X83.022 Y99.187 E.00594
G1 X82.954 Y99.546 E.0061
G1 X82.937 Y100.071 E.00878
G1 X82.998 Y100.522 E.00758
G1 X83.061 Y100.769 E.00426
G1 X83.184 Y101.103 E.00594
G1 X83.348 Y101.418 E.00594
G1 X83.544 Y101.716 E.00594
G1 X83.869 Y102.078 E.00813
G1 X84.327 Y102.435 E.00969
G1 X84.598 Y102.587 E.00519
G1 X84.915 Y102.722 E.00574
G1 X85.3 Y102.833 E.00669
G1 X85.673 Y102.889 E.00631
G1 X86.14 Y102.892 E.00779
G1 X86.7 Y102.801 E.00946
G1 X87.066 Y102.674 E.00647
G1 X87.497 Y102.454 E.00807
G1 X87.8 Y102.241 E.00619
G1 X88.174 Y101.89 E.00856
G1 X88.428 Y101.557 E.00699
G1 X88.602 Y101.254 E.00583
G1 X88.791 Y100.794 E.00831
G1 X88.911 Y100.239 E.00947
G1 X88.925 Y99.839 E.00667
G1 X88.883 Y99.37 E.00787
G1 X88.797 Y99.016 E.00608
G1 X88.586 Y98.506 E.00921
G1 X88.313 Y98.077 E.00849
G1 X87.933 Y97.654 E.0095
; LINE_WIDTH: 0.395492
G1 X87.808 Y97.538 E.00314
; LINE_WIDTH: 0.431435
G1 X87.683 Y97.422 E.00345
; LINE_WIDTH: 0.467629
G1 X87.557 Y97.304 E.00381
; LINE_WIDTH: 0.468534
G1 X87.396 Y97.34 E.00365
; LINE_WIDTH: 0.433864
G1 X87.234 Y97.375 E.00337
; WIPE_START
G1 X87.396 Y97.34 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X92.699 Y96.143 Z2.4 F18000
G1 Z2
G1 E.4 F1800
; LINE_WIDTH: 0.109837
M73 P58 R10
G1 F1500
M204 S6000
G1 X92.944 Y96.002 E.00119
; WIPE_START
G1 X92.699 Y96.143 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X88.119 Y90.037 Z2.4 F18000
G1 X78.788 Y77.595 Z2.4
G1 Z2
G1 E.4 F1800
; LINE_WIDTH: 0.106472
G1 F1500
M204 S6000
G1 X78.863 Y77.373 E.00094
; LINE_WIDTH: 0.156905
G1 X79.002 Y77.192 E.00149
G1 X79.124 Y77.08 E.00108
; LINE_WIDTH: 0.129472
G1 X79.323 Y76.991 E.00113
; LINE_WIDTH: 0.0897761
G1 X79.427 Y76.955 E.00035
; CHANGE_LAYER
; Z_HEIGHT: 2.12
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F1500
G1 X79.323 Y76.991 E-.38
; WIPE_END
G1 E-.02 F1800
; layer num/total_layer_count: 17/49
; update layer progress
M73 L17
M991 S0 P16 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z2.4 I-.664 J1.02 P1  F18000
G1 X93.687 Y86.344 Z2.4
G1 Z2.12
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X93.687 Y86.857 E.01086
G1 X93.374 Y86.857 E.00662
G1 X93.374 Y86.344 E.01086
G1 X93.627 Y86.344 E.00535
M204 S10000
G1 X94.111 Y85.92 F18000
G1 F1500
M204 S500
G1 X94.111 Y87.282 E.02882
G1 X93.311 Y87.282 E.01693
G1 X93.311 Y88.382 E.02328
G1 X92.95 Y88.382 E.00765
G1 X92.95 Y77.128 E.23818
G1 X93.135 Y77.076 E.00407
G1 X93.216 Y77.207 E.00325
G1 X93.272 Y77.349 E.00324
G1 X93.301 Y77.49 E.00306
G1 X93.312 Y85.92 E.17842
G1 X94.051 Y85.92 E.01564
; WIPE_START
M204 S6000
G1 X94.111 Y87.282 E-.25894
G1 X93.474 Y87.282 E-.12106
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X93.287 Y94.912 Z2.52 F18000
G1 X93.274 Y95.441 Z2.52
G1 Z2.12
G1 E.4 F1800
G1 F1500
M204 S500
G1 X93.281 Y95.517 E.00162
G1 X93.266 Y95.563 E.00102
G1 X93.229 Y95.625 E.00153
G1 X92.954 Y95.743 E.00632
G1 X92.985 Y95.456 E.00611
G1 X93.027 Y95.378 E.00188
G1 X93.132 Y95.345 E.00233
G1 X93.182 Y95.357 E.00108
G1 X93.229 Y95.401 E.00136
; WIPE_START
M204 S6000
G1 X93.281 Y95.517 E-.04215
G1 X93.266 Y95.563 E-.01596
G1 X93.229 Y95.625 E-.02394
G1 X92.954 Y95.743 E-.09868
G1 X92.985 Y95.456 E-.09532
G1 X93.027 Y95.378 E-.02937
G1 X93.132 Y95.345 E-.03641
G1 X93.182 Y95.357 E-.01686
G1 X93.229 Y95.401 E-.0213
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X85.747 Y96.907 Z2.52 F18000
G1 X84.728 Y97.112 Z2.52
G1 Z2.12
G1 E.4 F1800
G1 F1500
M204 S500
G1 X84.613 Y96.947 E.00426
G1 X84.974 Y96.544 E.01144
G1 X86.853 Y96.544 E.03977
G1 X87.196 Y96.916 E.0107
G1 X87.09 Y97.081 E.00416
G1 X86.697 Y96.954 E.00874
G1 X86.324 Y96.88 E.00804
G1 X85.81 Y96.857 E.0109
G1 X85.432 Y96.897 E.00804
G1 X85.061 Y96.981 E.00805
G1 X84.784 Y97.09 E.00631
; WIPE_START
M204 S6000
G1 X84.613 Y96.947 E-.04233
G1 X84.974 Y96.544 E-.10269
G1 X86.21 Y96.544 E-.23497
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X84.879 Y102.296 Z2.52 F18000
G1 Z2.12
G1 E.4 F1800
G1 F1500
M204 S500
G1 X84.758 Y102.244 E.00277
G1 X84.479 Y102.083 E.00683
G1 X84.126 Y101.802 E.00956
G1 X83.907 Y101.565 E.00683
G1 X83.717 Y101.304 E.00683
G1 X83.505 Y100.895 E.00975
G1 X83.366 Y100.446 E.00995
G1 X83.31 Y99.979 E.00995
G1 X83.338 Y99.519 E.00975
G1 X83.404 Y99.206 E.00679
G1 X83.492 Y98.942 E.00588
G1 X83.719 Y98.493 E.01065
G1 X84.009 Y98.118 E.01003
G1 X84.358 Y97.803 E.00995
G1 X84.758 Y97.556 E.00995
G1 X85.187 Y97.388 E.00975
G1 X85.501 Y97.316 E.00683
G1 X85.822 Y97.282 E.00683
G1 X86.273 Y97.302 E.00955
G1 X86.59 Y97.365 E.00683
G1 X86.897 Y97.465 E.00683
G1 X87.309 Y97.671 E.00975
G1 X87.685 Y97.953 E.00995
G1 X87.998 Y98.29 E.00975
G1 X88.18 Y98.557 E.00683
G1 X88.329 Y98.843 E.00683
G1 X88.478 Y99.279 E.00975
G1 X88.548 Y99.744 E.00995
G1 X88.534 Y100.214 E.00995
G1 X88.436 Y100.674 E.00995
G1 X88.261 Y101.1 E.00975
G1 X88.096 Y101.377 E.00683
G1 X87.898 Y101.632 E.00683
G1 X87.565 Y101.951 E.00975
G1 X87.173 Y102.21 E.00995
G1 X86.749 Y102.391 E.00975
G1 X86.437 Y102.472 E.00683
G1 X86.126 Y102.514 E.00664
G1 X85.813 Y102.519 E.00663
G1 X85.492 Y102.485 E.00683
G1 X85.055 Y102.371 E.00955
G1 X84.934 Y102.319 E.00279
M204 S250
G1 X85.04 Y101.92 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X84.942 Y101.878 E.00209
G1 X84.71 Y101.744 E.00526
G1 X84.405 Y101.501 E.00768
G1 X84.223 Y101.305 E.00526
G1 X84.066 Y101.088 E.00526
G1 X83.885 Y100.739 E.00773
G1 X83.768 Y100.361 E.0078
G1 X83.721 Y99.967 E.0078
G1 X83.744 Y99.574 E.00774
G1 X83.8 Y99.313 E.00525
G1 X83.871 Y99.1 E.00443
G1 X84.067 Y98.712 E.00855
G1 X84.31 Y98.397 E.00782
G1 X84.604 Y98.132 E.00779
G1 X84.942 Y97.924 E.0078
G1 X85.308 Y97.78 E.00773
G1 X85.568 Y97.72 E.00526
G1 X85.835 Y97.692 E.00526
G1 X86.224 Y97.71 E.00767
G1 X86.487 Y97.762 E.00526
G1 X86.741 Y97.844 E.00526
G1 X87.093 Y98.02 E.00773
G1 X87.41 Y98.258 E.0078
G1 X87.677 Y98.546 E.00773
G1 X87.828 Y98.767 E.00526
G1 X87.951 Y99.005 E.00526
G1 X88.078 Y99.377 E.00773
G1 X88.137 Y99.769 E.0078
G1 X88.126 Y100.165 E.0078
G1 X88.043 Y100.552 E.00779
G1 X87.894 Y100.916 E.00774
G1 X87.757 Y101.146 E.00526
G1 X87.593 Y101.358 E.00526
G1 X87.309 Y101.629 E.00774
G1 X86.978 Y101.848 E.0078
G1 X86.617 Y102.002 E.00773
G1 X86.358 Y102.07 E.00526
G1 X86.096 Y102.105 E.0052
G1 X85.831 Y102.109 E.0052
G1 X85.565 Y102.081 E.00526
G1 X85.188 Y101.983 E.00767
G1 X85.095 Y101.943 E.00199
; WIPE_START
M204 S6000
G1 X84.942 Y101.878 E-.03161
G1 X84.71 Y101.744 E-.05082
G1 X84.405 Y101.501 E-.07414
G1 X84.223 Y101.305 E-.0508
G1 X84.066 Y101.088 E-.05085
G1 X83.885 Y100.739 E-.07469
G1 X83.812 Y100.502 E-.04708
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X84.727 Y96.12 Z2.52 F18000
G1 Z2.12
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X92.488 Y96.12 E.16427
G1 X92.566 Y95.38 E.01576
G1 X92.66 Y95.166 E.00494
G1 X92.8 Y95.026 E.00419
G1 X92.887 Y94.977 E.00212
G1 X93.029 Y94.932 E.00314
G1 X93.225 Y94.93 E.00415
G1 X93.325 Y94.956 E.00217
G1 X93.502 Y95.058 E.00433
G1 X93.575 Y95.131 E.00218
G1 X93.633 Y95.215 E.00217
G1 X93.692 Y95.362 E.00335
G1 X93.708 Y95.518 E.00332
G1 X93.698 Y95.609 E.00194
G1 X93.654 Y95.742 E.00296
G1 X93.536 Y95.914 E.00443
G1 X93.4 Y96.013 E.00355
G1 X93.18 Y96.108 E.00508
G1 X92.874 Y96.36 E.00839
G1 X92.729 Y96.427 E.0034
G1 X92.582 Y96.466 E.00321
G1 X92.404 Y96.482 E.00378
G1 X87.372 Y96.482 E.10649
G1 X88.475 Y97.675 E.03439
G1 X88.725 Y98 E.00868
G1 X88.936 Y98.353 E.00869
G1 X89.092 Y98.704 E.00814
G1 X89.192 Y99.022 E.00705
G1 X89.287 Y99.503 E.01037
G1 X89.305 Y100.1 E.01264
G1 X89.233 Y100.612 E.01094
G1 X89.1 Y101.075 E.01021
G1 X88.842 Y101.618 E.01271
G1 X88.542 Y102.044 E.01103
G1 X88.211 Y102.395 E.01021
G1 X87.957 Y102.605 E.00698
G1 X87.574 Y102.855 E.00969
G1 X87.201 Y103.033 E.00873
G1 X86.886 Y103.142 E.00706
G1 X86.633 Y103.207 E.00554
G1 X86.222 Y103.269 E.00878
G1 X85.63 Y103.267 E.01254
G1 X85.047 Y103.164 E.01253
G1 X84.662 Y103.033 E.0086
G1 X84.231 Y102.82 E.01018
G1 X83.804 Y102.529 E.01094
G1 X83.502 Y102.251 E.00869
G1 X83.24 Y101.947 E.00849
G1 X83.017 Y101.613 E.00849
G1 X82.834 Y101.256 E.00849
G1 X82.696 Y100.879 E.0085
G1 X82.574 Y100.298 E.01257
G1 X82.553 Y99.965 E.00705
G1 X82.577 Y99.486 E.01017
G1 X82.648 Y99.095 E.00841
G1 X82.767 Y98.712 E.00849
G1 X82.93 Y98.345 E.0085
G1 X83.137 Y97.999 E.00853
G1 X83.339 Y97.733 E.00706
G1 X84.46 Y96.482 E.03557
G1 X79.467 Y96.482 E.10569
G1 X79.133 Y96.429 E.00714
G1 X78.9 Y96.302 E.00562
G1 X78.763 Y96.173 E.00399
G1 X78.665 Y96.033 E.00362
G1 X78.579 Y95.812 E.00501
G1 X78.55 Y95.565 E.00527
G1 X78.55 Y77.628 E.37965
G1 X78.586 Y77.357 E.00578
G1 X78.646 Y77.207 E.00343
G1 X78.726 Y77.076 E.00324
G1 X78.898 Y76.901 E.0052
G1 X79.124 Y76.777 E.00544
G1 X79.383 Y76.723 E.00562
G1 X92.422 Y76.721 E.27597
G1 X92.639 Y76.748 E.00464
G1 X92.778 Y76.794 E.0031
G1 X92.955 Y76.889 E.00424
G1 X92.906 Y77.082 E.0042
G1 X79.876 Y77.082 E.27579
G1 X79.588 Y77.133 E.0062
G1 X79.315 Y77.28 E.00656
G1 X79.093 Y77.507 E.00671
G1 X78.949 Y77.8 E.00693
G1 X78.911 Y78.056 E.00546
G1 X78.911 Y95.155 E.36192
G1 X78.964 Y95.453 E.0064
G1 X79.152 Y95.778 E.00796
G1 X79.512 Y96.047 E.00952
G1 X79.867 Y96.12 E.00767
G1 X84.667 Y96.12 E.10159
; WIPE_START
M204 S6000
G1 X86.667 Y96.12 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X83.544 Y96.891 Z2.52 F18000
G1 Z2.12
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X79.443 Y96.891 E.08067
G1 X79.127 Y96.854 E.00625
G1 X78.83 Y96.741 E.00625
G1 X78.546 Y96.539 E.00687
G1 X78.445 Y96.432 E.00289
G1 X78.312 Y96.243 E.00454
G1 X78.248 Y96.114 E.00283
G1 X78.177 Y95.901 E.00442
G1 X78.141 Y95.589 E.00619
G1 X78.141 Y77.61 E.35362
G1 X78.161 Y77.374 E.00466
G1 X78.194 Y77.234 E.00283
G1 X78.279 Y77.022 E.00448
G1 X78.396 Y76.831 E.00442
G1 X78.548 Y76.661 E.00448
G1 X78.658 Y76.568 E.00283
G1 X78.855 Y76.447 E.00454
G1 X78.987 Y76.39 E.00284
G1 X79.182 Y76.336 E.00398
G1 X79.357 Y76.313 E.00346
G1 X92.447 Y76.312 E.25748
G1 X92.73 Y76.347 E.0056
G1 X92.941 Y76.417 E.00438
G1 X93.139 Y76.524 E.00442
G1 X93.315 Y76.663 E.00442
G1 X93.465 Y76.831 E.00442
G1 X93.583 Y77.022 E.00442
G1 X93.666 Y77.231 E.00442
G1 X93.71 Y77.448 E.00436
G1 X93.721 Y85.511 E.15858
G1 X94.39 Y85.511 E.01316
G1 F1870.275
G1 X94.52 Y85.511 E.00256
G1 F1320
G1 X94.52 Y87.691 E.04288
G1 F1668.612
G1 X94.39 Y87.691 E.00256
G1 F1500
G1 X93.721 Y87.691 E.01317
G1 X93.721 Y88.791 E.02164
G1 X92.541 Y88.791 E.02321
G1 X92.541 Y77.491 E.22226
G1 X79.912 Y77.491 E.24839
G1 X79.724 Y77.524 E.00376
G1 X79.564 Y77.61 E.00358
G1 X79.431 Y77.746 E.00373
G1 X79.344 Y77.923 E.00389
G1 X79.321 Y78.086 E.00323
G1 X79.321 Y95.119 E.33504
G1 X79.354 Y95.311 E.00382
G1 X79.464 Y95.501 E.00431
G1 X79.684 Y95.664 E.0054
G1 X79.909 Y95.711 E.00452
G1 X92.12 Y95.711 E.24017
G1 X92.163 Y95.297 E.00819
G1 X92.218 Y95.119 E.00366
G1 X92.32 Y94.934 E.00416
G1 X92.432 Y94.8 E.00342
G1 X92.567 Y94.688 E.00345
G1 X92.723 Y94.6 E.00353
G1 X92.945 Y94.529 E.00458
G1 X93.117 Y94.512 E.0034
G1 X93.292 Y94.525 E.00345
G1 X93.462 Y94.569 E.00345
G1 X93.622 Y94.643 E.00346
G1 X93.766 Y94.743 E.00345
G1 X93.89 Y94.867 E.00346
G1 X93.99 Y95.012 E.00345
G1 X94.096 Y95.285 E.00576
G1 X94.119 Y95.519 E.00464
G1 X94.1 Y95.695 E.00348
G1 X94.029 Y95.914 E.00453
G1 X93.907 Y96.114 E.0046
G1 X93.702 Y96.309 E.00557
G1 X93.401 Y96.458 E.00661
G1 X93.193 Y96.641 E.00546
G1 X93.073 Y96.719 E.00281
G1 X92.868 Y96.814 E.00444
G1 X92.652 Y96.871 E.00438
G1 X92.421 Y96.891 E.00456
G1 X88.307 Y96.891 E.08092
G1 X88.788 Y97.411 E.01393
G1 X89.064 Y97.77 E.00891
G1 X89.296 Y98.159 E.00891
G1 X89.393 Y98.359 E.00437
G1 X89.59 Y98.92 E.0117
G1 X89.693 Y99.444 E.0105
G1 X89.713 Y99.661 E.00428
G1 X89.714 Y100.117 E.00897
G1 X89.633 Y100.703 E.01164
G1 X89.486 Y101.213 E.01045
G1 X89.339 Y101.555 E.00731
G1 X89.197 Y101.823 E.00596
G1 X88.856 Y102.308 E.01167
G1 X88.491 Y102.694 E.01045
G1 X88.204 Y102.931 E.00731
G1 X87.766 Y103.216 E.01029
G1 X87.357 Y103.412 E.00892
G1 X87.004 Y103.534 E.00734
G1 X86.714 Y103.609 E.00589
G1 X86.265 Y103.676 E.00894
G1 X86.046 Y103.689 E.00431
G1 X85.593 Y103.676 E.00891
G1 X85.145 Y103.608 E.00891
G1 X84.933 Y103.557 E.0043
G1 X84.505 Y103.412 E.00889
G1 X84.029 Y103.177 E.01044
G1 X83.715 Y102.976 E.00733
G1 X83.541 Y102.842 E.00432
G1 X83.207 Y102.536 E.00891
G1 X82.914 Y102.195 E.00885
G1 X82.663 Y101.821 E.00885
G1 X82.459 Y101.42 E.00885
G1 X82.303 Y100.998 E.00885
M73 P59 R10
G1 X82.198 Y100.557 E.00891
G1 X82.143 Y99.968 E.01164
G1 X82.169 Y99.438 E.01043
G1 X82.25 Y98.997 E.00882
G1 X82.383 Y98.567 E.00885
G1 X82.566 Y98.156 E.00885
G1 X82.797 Y97.769 E.00886
G1 X83.023 Y97.472 E.00734
G1 X83.504 Y96.936 E.01418
; WIPE_START
M204 S6000
G1 X81.504 Y96.914 E-.38
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




G1 X79.346 Y96.253
G1 Z2.12
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.146896
G1 F1500
M204 S6000
G1 X79.022 Y96.034 E.00236
G1 X78.957 Y95.967 E.00056
G1 X78.878 Y95.848 E.00086
G1 X78.778 Y95.627 E.00147
; WIPE_START
G1 X78.878 Y95.848 E-.10619
G1 X78.957 Y95.967 E-.06228
G1 X79.022 Y96.034 E-.0407
G1 X79.346 Y96.253 E-.17083
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X84.499 Y97.155 Z2.52 F18000
G1 Z2.12
G1 E.4 F1800
; LINE_WIDTH: 0.472379
G1 F1500
M204 S6000
G1 X84.313 Y97.31 E.0054
; LINE_WIDTH: 0.43371
G1 X84.101 Y97.489 E.00565
; LINE_WIDTH: 0.39791
G1 X83.921 Y97.67 E.00472
; LINE_WIDTH: 0.360419
G1 X83.722 Y97.872 E.00474
G1 X83.392 Y98.305 E.00909
G1 X83.138 Y98.808 E.0094
G1 X83.019 Y99.186 E.00662
G1 X82.956 Y99.529 E.00584
G1 X82.933 Y100.005 E.00795
G1 X83.004 Y100.538 E.00897
G1 X83.15 Y101.024 E.00848
G1 X83.389 Y101.492 E.00877
G1 X83.609 Y101.797 E.00628
G1 X83.862 Y102.068 E.00619
G1 X84.256 Y102.388 E.00848
G1 X84.582 Y102.576 E.00628
G1 X84.923 Y102.722 E.00619
G1 X85.413 Y102.854 E.00847
G1 X85.806 Y102.893 E.0066
G1 X86.188 Y102.889 E.00638
G1 X86.557 Y102.834 E.00622
G1 X86.86 Y102.752 E.00524
G1 X87.365 Y102.536 E.00918
G1 X87.728 Y102.299 E.00723
G1 X87.949 Y102.114 E.0048
G1 X88.169 Y101.892 E.00522
G1 X88.403 Y101.599 E.00627
G1 X88.604 Y101.258 E.00661
G1 X88.738 Y100.946 E.00566
G1 X88.858 Y100.529 E.00725
G1 X88.921 Y100.081 E.00754
G1 X88.906 Y99.552 E.00884
G1 X88.84 Y99.176 E.00638
G1 X88.68 Y98.706 E.00828
G1 X88.498 Y98.355 E.00661
G1 X88.285 Y98.046 E.00627
G1 X87.932 Y97.656 E.00879
; LINE_WIDTH: 0.395931
G1 X87.742 Y97.485 E.00471
; LINE_WIDTH: 0.442265
G1 X87.553 Y97.314 E.0053
; LINE_WIDTH: 0.480648
G1 X87.311 Y97.129 E.0069
; WIPE_START
G1 X87.553 Y97.314 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X92.699 Y96.144 Z2.52 F18000
G1 Z2.12
G1 E.4 F1800
; LINE_WIDTH: 0.130883
G1 F1500
M204 S6000
G1 X92.786 Y96.102 E.00051
; LINE_WIDTH: 0.104615
G1 X92.943 Y96.003 E.00073
; WIPE_START
G1 X92.786 Y96.102 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X88.182 Y90.015 Z2.52 F18000
G1 X78.787 Y77.597 Z2.52
G1 Z2.12
G1 E.4 F1800
; LINE_WIDTH: 0.101826
G1 F1500
M204 S6000
G1 X78.837 Y77.434 E.00065
; LINE_WIDTH: 0.149073
G1 X78.887 Y77.331 E.0007
G1 X79.032 Y77.162 E.00137
G1 X79.147 Y77.07 E.00091
; LINE_WIDTH: 0.127886
G1 X79.307 Y76.996 E.0009
; LINE_WIDTH: 0.0942379
G1 X79.4 Y76.962 E.00034
; LINE_WIDTH: 0.0799435
G1 X79.427 Y76.955 E.00008
; CHANGE_LAYER
; Z_HEIGHT: 2.24
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F1500
G1 X79.4 Y76.962 E-.38
; WIPE_END
G1 E-.02 F1800
; layer num/total_layer_count: 18/49
; update layer progress
M73 L18
M991 S0 P17 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z2.52 I-.662 J1.021 P1  F18000
G1 X93.858 Y86.344 Z2.52
G1 Z2.24
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X93.858 Y86.857 E.01086
G1 X93.374 Y86.857 E.01025
G1 X93.374 Y86.344 E.01086
G1 X93.798 Y86.344 E.00898
M204 S10000
G1 X94.282 Y85.92 F18000
G1 F1500
M204 S500
G1 X94.282 Y87.282 E.02882
G1 X93.311 Y87.282 E.02055
G1 X93.311 Y88.382 E.02328
G1 X92.95 Y88.382 E.00765
G1 X92.95 Y77.125 E.23825
G1 X93.142 Y77.077 E.0042
G1 X93.237 Y77.253 E.00424
G1 X93.282 Y77.39 E.00305
G1 X93.311 Y77.637 E.00527
G1 X93.311 Y85.92 E.17532
G1 X94.222 Y85.92 E.01929
; WIPE_START
M204 S6000
G1 X94.282 Y87.282 E-.25894
G1 X93.645 Y87.282 E-.12106
; WIPE_END
G1 E-.02 F1800
M204 S10000
G17
G3 Z2.64 I-1.216 J-.055 P1  F18000
G1 X93.274 Y95.441 Z2.64
G1 Z2.24
G1 E.4 F1800
G1 F1500
M204 S500
G1 X93.282 Y95.517 E.00162
G1 X93.267 Y95.563 E.00101
G1 X93.229 Y95.625 E.00154
G1 X92.954 Y95.743 E.00632
G1 X92.984 Y95.456 E.00611
G1 X93.027 Y95.378 E.00188
G1 X93.132 Y95.345 E.00233
G1 X93.182 Y95.357 E.00108
G1 X93.23 Y95.401 E.00137
; WIPE_START
M204 S6000
G1 X93.282 Y95.517 E-.04214
G1 X93.267 Y95.563 E-.01583
G1 X93.229 Y95.625 E-.02405
G1 X92.954 Y95.743 E-.09866
G1 X92.984 Y95.456 E-.09532
G1 X93.027 Y95.378 E-.02937
G1 X93.132 Y95.345 E-.03635
G1 X93.182 Y95.357 E-.01687
G1 X93.23 Y95.401 E-.0214
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X85.748 Y96.909 Z2.64 F18000
G1 X84.703 Y97.12 Z2.64
G1 Z2.24
G1 E.4 F1800
G1 F1500
M204 S500
G1 X84.583 Y96.956 E.00429
G1 X84.941 Y96.544 E.01155
G1 X86.92 Y96.544 E.04188
G1 X87.266 Y96.942 E.01117
G1 X87.159 Y97.104 E.0041
G1 X86.697 Y96.954 E.01029
G1 X86.324 Y96.88 E.00804
G1 X85.794 Y96.856 E.01123
G1 X85.268 Y96.928 E.01124
G1 X84.903 Y97.034 E.00804
G1 X84.758 Y97.096 E.00335
; WIPE_START
M204 S6000
G1 X84.583 Y96.956 E-.04255
G1 X84.941 Y96.544 E-.10365
G1 X86.172 Y96.544 E-.2338
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X84.848 Y102.283 Z2.64 F18000
G1 Z2.24
G1 E.4 F1800
G1 F1500
M204 S500
G1 X84.486 Y102.089 E.00869
G1 X84.119 Y101.796 E.00995
G1 X83.81 Y101.442 E.00995
G1 X83.566 Y101.035 E.01004
G1 X83.395 Y100.559 E.01071
G1 X83.339 Y100.289 E.00582
G1 X83.311 Y99.97 E.00679
G1 X83.338 Y99.519 E.00955
G1 X83.404 Y99.206 E.00679
G1 X83.491 Y98.945 E.00583
G1 X83.719 Y98.493 E.01071
G1 X84.009 Y98.118 E.01003
G1 X84.358 Y97.803 E.00995
G1 X84.75 Y97.561 E.00975
G1 X85.047 Y97.434 E.00683
G1 X85.356 Y97.344 E.00683
G1 X85.813 Y97.282 E.00975
G1 X86.273 Y97.302 E.00975
G1 X86.59 Y97.365 E.00683
G1 X86.897 Y97.465 E.00683
G1 X87.309 Y97.671 E.00976
G1 X87.685 Y97.953 E.00994
G1 X87.998 Y98.29 E.00975
G1 X88.18 Y98.557 E.00683
G1 X88.329 Y98.843 E.00683
G1 X88.475 Y99.27 E.00955
G1 X88.532 Y99.588 E.00683
G1 X88.551 Y99.91 E.00683
G1 X88.51 Y100.373 E.00983
G1 X88.369 Y100.859 E.01071
G1 X88.255 Y101.11 E.00582
G1 X88.091 Y101.385 E.00679
G1 X87.798 Y101.741 E.00975
G1 X87.447 Y102.039 E.00975
G1 X87.174 Y102.207 E.0068
G1 X86.925 Y102.325 E.00582
G1 X86.441 Y102.473 E.01071
G1 X85.979 Y102.521 E.00984
G1 X85.659 Y102.507 E.00678
G1 X85.387 Y102.464 E.00583
G1 X84.904 Y102.314 E.01071
G1 X84.901 Y102.312 E.00007
M204 S250
G1 X85.042 Y101.923 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X84.713 Y101.746 E.00735
G1 X84.403 Y101.499 E.0078
G1 X84.142 Y101.2 E.0078
G1 X83.938 Y100.859 E.00782
G1 X83.79 Y100.448 E.0086
G1 X83.745 Y100.23 E.00438
G1 X83.721 Y99.964 E.00525
G1 X83.744 Y99.574 E.00767
G1 X83.8 Y99.314 E.00525
G1 X83.87 Y99.102 E.00438
G1 X84.067 Y98.712 E.0086
G1 X84.31 Y98.397 E.00782
G1 X84.604 Y98.132 E.0078
G1 X84.939 Y97.925 E.00773
G1 X85.185 Y97.82 E.00526
G1 X85.442 Y97.745 E.00526
G1 X85.831 Y97.692 E.00774
G1 X86.224 Y97.71 E.00773
G1 X86.487 Y97.762 E.00526
G1 X86.741 Y97.844 E.00526
G1 X87.093 Y98.02 E.00774
G1 X87.41 Y98.258 E.00779
G1 X87.677 Y98.546 E.00774
G1 X87.828 Y98.767 E.00526
G1 X87.951 Y99.005 E.00526
G1 X88.077 Y99.374 E.00767
G1 X88.125 Y99.637 E.00526
G1 X88.141 Y99.904 E.00526
G1 X88.106 Y100.297 E.00776
G1 X87.984 Y100.717 E.0086
G1 X87.892 Y100.92 E.00438
G1 X87.755 Y101.149 E.00525
G1 X87.506 Y101.452 E.00773
G1 X87.206 Y101.707 E.00773
G1 X86.978 Y101.847 E.00525
G1 X86.777 Y101.942 E.00438
G1 X86.359 Y102.07 E.0086
G1 X85.967 Y102.111 E.00776
G1 X85.7 Y102.099 E.00524
G1 X85.48 Y102.064 E.00438
G1 X85.097 Y101.945 E.00789
; WIPE_START
M204 S6000
G1 X84.713 Y101.746 E-.08229
G1 X84.403 Y101.499 E-.0753
G1 X84.142 Y101.2 E-.07533
G1 X83.938 Y100.859 E-.07557
G1 X83.81 Y100.505 E-.07151
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X84.691 Y96.12 Z2.64 F18000
G1 Z2.24
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X92.488 Y96.12 E.16502
G1 X92.566 Y95.381 E.01574
G1 X92.659 Y95.166 E.00495
G1 X92.8 Y95.027 E.0042
G1 X92.888 Y94.977 E.00215
G1 X93.029 Y94.932 E.00311
G1 X93.225 Y94.93 E.00416
G1 X93.324 Y94.956 E.00218
G1 X93.502 Y95.058 E.00433
G1 X93.575 Y95.13 E.00217
G1 X93.633 Y95.215 E.00218
G1 X93.692 Y95.363 E.00337
G1 X93.708 Y95.517 E.00328
G1 X93.698 Y95.61 E.00198
G1 X93.655 Y95.741 E.00293
G1 X93.535 Y95.915 E.00446
G1 X93.399 Y96.014 E.00356
G1 X93.171 Y96.111 E.00525
G1 X92.999 Y96.272 E.005
G1 X92.867 Y96.364 E.0034
G1 X92.728 Y96.427 E.00322
G1 X92.582 Y96.466 E.00321
G1 X92.404 Y96.482 E.00378
G1 X87.428 Y96.482 E.10532
G1 X88.608 Y97.838 E.03805
G1 X88.931 Y98.344 E.01272
G1 X89.159 Y98.901 E.01274
G1 X89.286 Y99.489 E.01273
G1 X89.305 Y100.1 E.01292
G1 X89.234 Y100.607 E.01084
G1 X89.099 Y101.076 E.01032
G1 X88.847 Y101.61 E.0125
G1 X88.621 Y101.947 E.00859
G1 X88.353 Y102.258 E.00868
G1 X87.897 Y102.65 E.01274
G1 X87.379 Y102.955 E.01273
G1 X86.814 Y103.164 E.01273
G1 X86.222 Y103.269 E.01273
G1 X85.63 Y103.267 E.01254
G1 X85.038 Y103.161 E.01274
G1 X84.548 Y102.983 E.01104
G1 X84.12 Y102.754 E.01027
G1 X83.797 Y102.522 E.0084
G1 X83.502 Y102.251 E.0085
G1 X83.24 Y101.947 E.00849
G1 X83.017 Y101.613 E.0085
G1 X82.834 Y101.256 E.00849
G1 X82.696 Y100.879 E.00849
G1 X82.574 Y100.298 E.01258
G1 X82.553 Y99.97 E.00695
G1 X82.577 Y99.485 E.01027
G1 X82.648 Y99.095 E.00841
G1 X82.767 Y98.712 E.00849
G1 X82.934 Y98.337 E.00868
G1 X83.254 Y97.838 E.01254
G1 X84.433 Y96.482 E.03805
G1 X79.467 Y96.482 E.10513
G1 X79.217 Y96.452 E.00532
G1 X79.097 Y96.414 E.00266
G1 X78.859 Y96.269 E.00592
G1 X78.728 Y96.129 E.00404
G1 X78.662 Y96.026 E.00259
G1 X78.58 Y95.821 E.00467
G1 X78.55 Y95.565 E.00546
G1 X78.55 Y77.619 E.37984
G1 X78.589 Y77.349 E.00578
G1 X78.691 Y77.125 E.0052
G1 X78.793 Y76.996 E.00349
G1 X78.893 Y76.906 E.00285
G1 X79.132 Y76.774 E.00578
G1 X79.384 Y76.723 E.00543
G1 X92.433 Y76.721 E.27619
G1 X92.581 Y76.735 E.00314
G1 X92.731 Y76.775 E.0033
G1 X92.96 Y76.904 E.00556
G1 X92.904 Y77.082 E.00395
G1 X79.886 Y77.082 E.27555
G1 X79.627 Y77.12 E.00553
G1 X79.316 Y77.276 E.00737
G1 X79.077 Y77.529 E.00736
G1 X78.948 Y77.807 E.00649
G1 X78.911 Y78.056 E.00533
G1 X78.911 Y95.155 E.36192
G1 X78.964 Y95.453 E.0064
G1 X79.152 Y95.778 E.00796
G1 X79.512 Y96.047 E.00952
M73 P59 R9
G1 X79.867 Y96.12 E.00767
G1 X84.631 Y96.12 E.10084
; WIPE_START
M204 S6000
G1 X86.631 Y96.12 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X83.535 Y96.891 Z2.64 F18000
G1 Z2.24
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X79.443 Y96.891 E.08049
G1 X79.129 Y96.854 E.00621
G1 X78.944 Y96.795 E.00382
G1 X78.787 Y96.718 E.00343
G1 X78.599 Y96.587 E.00451
G1 X78.493 Y96.486 E.00289
G1 X78.301 Y96.222 E.0064
G1 X78.177 Y95.904 E.00671
G1 X78.141 Y95.589 E.00625
G1 X78.141 Y77.607 E.35368
G1 X78.149 Y77.454 E.00301
G1 X78.196 Y77.231 E.00448
G1 X78.28 Y77.019 E.00448
G1 X78.352 Y76.895 E.00283
G1 X78.493 Y76.716 E.0045
G1 X78.64 Y76.583 E.00389
G1 X78.785 Y76.485 E.00344
G1 X78.99 Y76.389 E.00447
G1 X79.181 Y76.336 E.00389
G1 X79.357 Y76.313 E.00349
G1 X92.452 Y76.312 E.25757
G1 X92.654 Y76.331 E.00398
G1 X92.872 Y76.389 E.00444
G1 X93.075 Y76.484 E.00442
G1 X93.262 Y76.615 E.00448
G1 X93.366 Y76.714 E.00283
G1 X93.508 Y76.893 E.00448
G1 X93.614 Y77.09 E.00442
G1 X93.684 Y77.301 E.00436
G1 X93.721 Y77.613 E.00619
G1 X93.721 Y85.511 E.15534
G1 X94.561 Y85.511 E.01654
G1 F1870.275
G1 X94.692 Y85.511 E.00256
G1 F1320
G1 X94.692 Y87.691 E.04288
G1 F1668.612
G1 X94.561 Y87.691 E.00256
G1 F1500
G1 X93.721 Y87.691 E.01654
G1 X93.721 Y88.791 E.02164
G1 X92.541 Y88.791 E.02321
G1 X92.541 Y77.491 E.22226
G1 X79.915 Y77.491 E.24833
G1 X79.752 Y77.515 E.00325
G1 X79.564 Y77.609 E.00413
G1 X79.42 Y77.762 E.00413
G1 X79.344 Y77.925 E.00355
G1 X79.321 Y78.086 E.00319
G1 X79.321 Y95.119 E.33504
G1 X79.354 Y95.311 E.00382
G1 X79.464 Y95.501 E.00431
G1 X79.684 Y95.664 E.0054
G1 X79.909 Y95.711 E.00452
G1 X92.12 Y95.711 E.24017
G1 X92.163 Y95.298 E.00817
G1 X92.219 Y95.118 E.0037
G1 X92.32 Y94.934 E.00413
G1 X92.432 Y94.801 E.00343
G1 X92.566 Y94.688 E.00344
G1 X92.724 Y94.599 E.00356
G1 X92.945 Y94.53 E.00455
G1 X93.117 Y94.512 E.0034
G1 X93.292 Y94.525 E.00345
G1 X93.462 Y94.569 E.00346
G1 X93.622 Y94.642 E.00345
G1 X93.766 Y94.743 E.00345
G1 X93.89 Y94.867 E.00346
G1 X93.99 Y95.011 E.00346
G1 X94.096 Y95.286 E.00579
G1 X94.119 Y95.519 E.0046
G1 X94.1 Y95.696 E.00351
G1 X94.029 Y95.913 E.00449
G1 X93.907 Y96.113 E.0046
G1 X93.702 Y96.308 E.00557
G1 X93.398 Y96.459 E.00668
G1 X93.256 Y96.592 E.00382
G1 X93.07 Y96.72 E.00444
G1 X92.868 Y96.814 E.00439
G1 X92.653 Y96.871 E.00438
G1 X92.421 Y96.891 E.00456
G1 X88.326 Y96.891 E.08055
G1 X88.932 Y97.588 E.01817
M73 P60 R9
G1 X89.187 Y97.962 E.00891
G1 X89.391 Y98.356 E.00873
G1 X89.551 Y98.78 E.00891
G1 X89.659 Y99.22 E.00891
G1 X89.713 Y99.661 E.00873
G1 X89.714 Y100.117 E.00897
G1 X89.634 Y100.698 E.01155
G1 X89.486 Y101.214 E.01054
G1 X89.341 Y101.551 E.00722
G1 X89.199 Y101.82 E.00598
G1 X88.947 Y102.195 E.00888
G1 X88.652 Y102.538 E.00891
G1 X88.495 Y102.691 E.00431
G1 X88.141 Y102.979 E.00897
G1 X87.96 Y103.102 E.00431
G1 X87.561 Y103.322 E.00897
G1 X87.361 Y103.411 E.0043
G1 X86.929 Y103.557 E.00897
G1 X86.716 Y103.608 E.0043
G1 X86.265 Y103.676 E.00897
G1 X86.046 Y103.689 E.00431
G1 X85.593 Y103.676 E.00891
G1 X85.145 Y103.608 E.00891
G1 X84.929 Y103.556 E.00437
G1 X84.375 Y103.355 E.01161
G1 X83.903 Y103.102 E.01053
G1 X83.539 Y102.84 E.00882
G1 X83.207 Y102.536 E.00885
G1 X82.914 Y102.195 E.00885
G1 X82.663 Y101.821 E.00885
G1 X82.459 Y101.42 E.00885
G1 X82.303 Y100.998 E.00885
G1 X82.198 Y100.557 E.00891
G1 X82.143 Y99.973 E.01155
G1 X82.169 Y99.438 E.01053
G1 X82.25 Y98.997 E.00882
G1 X82.383 Y98.567 E.00885
G1 X82.568 Y98.153 E.00891
G1 X82.674 Y97.962 E.00431
G1 X82.929 Y97.588 E.00891
G1 X83.496 Y96.936 E.01698
; WIPE_START
M204 S6000
G1 X81.496 Y96.914 E-.38
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




G1 X79.328 Y96.248
G1 Z2.24
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.152552
G1 F1500
M204 S6000
G1 X78.993 Y96.009 E.0026
G1 X78.94 Y95.951 E.0005
G1 X78.856 Y95.804 E.00107
; LINE_WIDTH: 0.12432
G1 X78.824 Y95.713 E.00047
; LINE_WIDTH: 0.0938835
G1 X78.792 Y95.622 E.00033
; WIPE_START
G1 X78.824 Y95.713 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X84.474 Y97.167 Z2.64 F18000
G1 Z2.24
G1 E.4 F1800
; LINE_WIDTH: 0.475199
G1 F1500
M204 S6000
G1 X84.3 Y97.315 E.00513
; LINE_WIDTH: 0.438835
G1 X84.099 Y97.487 E.00545
; LINE_WIDTH: 0.401786
G1 X83.921 Y97.669 E.00478
; LINE_WIDTH: 0.360021
G1 X83.723 Y97.872 E.00474
G1 X83.391 Y98.305 E.00909
G1 X83.138 Y98.811 E.00943
G1 X83.019 Y99.186 E.00656
G1 X82.956 Y99.529 E.00582
G1 X82.933 Y99.988 E.00766
G1 X82.967 Y100.354 E.00612
G1 X83.028 Y100.65 E.00504
G1 X83.185 Y101.103 E.00799
G1 X83.348 Y101.418 E.00593
G1 X83.544 Y101.716 E.00594
G1 X83.869 Y102.078 E.00812
G1 X84.291 Y102.412 E.00897
G1 X84.743 Y102.655 E.00857
G1 X85.289 Y102.831 E.00956
G1 X85.664 Y102.888 E.00633
G1 X86.003 Y102.9 E.00566
G1 X86.501 Y102.845 E.00836
G1 X86.705 Y102.794 E.00351
G1 X87.212 Y102.611 E.00898
G1 X87.673 Y102.343 E.0089
G1 X88.079 Y101.996 E.0089
G1 X88.315 Y101.715 E.00614
G1 X88.516 Y101.417 E.00599
G1 X88.741 Y100.944 E.00872
G1 X88.877 Y100.458 E.00842
G1 X88.925 Y99.928 E.00888
G1 X88.909 Y99.541 E.00646
G1 X88.834 Y99.165 E.0064
G1 X88.677 Y98.708 E.00805
G1 X88.506 Y98.373 E.00626
G1 X88.302 Y98.064 E.00618
G1 X87.933 Y97.654 E.00921
; LINE_WIDTH: 0.395494
G1 X87.808 Y97.538 E.00314
; LINE_WIDTH: 0.431443
G1 X87.683 Y97.422 E.00345
; LINE_WIDTH: 0.467634
G1 X87.557 Y97.304 E.0038
; LINE_WIDTH: 0.468491
G1 X87.396 Y97.34 E.00365
; LINE_WIDTH: 0.433752
G1 X87.234 Y97.375 E.00337
; WIPE_START
G1 X87.396 Y97.34 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X92.699 Y96.142 Z2.64 F18000
G1 Z2.24
G1 E.4 F1800
; LINE_WIDTH: 0.110007
G1 F1500
M204 S6000
G1 X92.945 Y96.002 E.00119
; WIPE_START
G1 X92.699 Y96.142 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X88.118 Y90.038 Z2.64 F18000
G1 X78.785 Y77.602 Z2.64
G1 Z2.24
G1 E.4 F1800
; LINE_WIDTH: 0.103528
G1 F1500
M204 S6000
G1 X78.855 Y77.387 E.00087
; LINE_WIDTH: 0.156456
G1 X79.002 Y77.193 E.00159
G1 X79.125 Y77.08 E.00108
; LINE_WIDTH: 0.127512
G1 X79.328 Y76.99 E.00113
; LINE_WIDTH: 0.0894544
G1 X79.435 Y76.955 E.00036
; CHANGE_LAYER
; Z_HEIGHT: 2.36
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F1500
G1 X79.328 Y76.99 E-.38
; WIPE_END
G1 E-.02 F1800
; layer num/total_layer_count: 19/49
; update layer progress
M73 L19
M991 S0 P18 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z2.64 I-.653 J1.027 P1  F18000
G1 X94.03 Y86.344 Z2.64
G1 Z2.36
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X94.03 Y86.857 E.01086
G1 X93.374 Y86.857 E.01388
G1 X93.374 Y86.344 E.01086
G1 X93.97 Y86.344 E.01261
M204 S10000
G1 X94.454 Y85.92 F18000
G1 F1500
M204 S500
G1 X94.454 Y87.282 E.02882
G1 X93.311 Y87.282 E.02418
G1 X93.311 Y88.382 E.02328
G1 X92.95 Y88.382 E.00765
G1 X92.95 Y77.127 E.23821
G1 X93.128 Y77.071 E.00395
G1 X93.191 Y77.162 E.00234
G1 X93.256 Y77.3 E.00324
G1 X93.296 Y77.448 E.00324
G1 X93.311 Y77.628 E.00382
G1 X93.311 Y85.92 E.17551
G1 X94.394 Y85.92 E.02291
; WIPE_START
M204 S6000
G1 X94.454 Y87.282 E-.25894
G1 X93.817 Y87.282 E-.12106
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X93.31 Y94.897 Z2.76 F18000
G1 X93.274 Y95.441 Z2.76
G1 Z2.36
G1 E.4 F1800
G1 F1500
M204 S500
G1 X93.282 Y95.517 E.00162
G1 X93.267 Y95.562 E.00101
G1 X93.229 Y95.625 E.00155
G1 X92.954 Y95.742 E.00631
G1 X92.984 Y95.456 E.0061
G1 X93.027 Y95.378 E.00188
G1 X93.132 Y95.345 E.00232
G1 X93.182 Y95.357 E.00109
G1 X93.23 Y95.401 E.00137
; WIPE_START
M204 S6000
G1 X93.282 Y95.517 E-.04214
G1 X93.267 Y95.562 E-.0157
G1 X93.229 Y95.625 E-.02427
G1 X92.954 Y95.742 E-.09857
G1 X92.984 Y95.456 E-.09528
G1 X93.027 Y95.378 E-.02942
G1 X93.132 Y95.345 E-.03627
G1 X93.182 Y95.357 E-.01696
G1 X93.23 Y95.401 E-.0214
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X85.746 Y96.9 Z2.76 F18000
G1 X84.696 Y97.11 Z2.76
G1 Z2.36
G1 E.4 F1800
G1 F1500
M204 S500
G1 X84.589 Y96.949 E.0041
G1 X84.941 Y96.544 E.01135
G1 X86.853 Y96.544 E.04046
G1 X87.196 Y96.916 E.0107
G1 X87.09 Y97.081 E.00416
G1 X86.697 Y96.953 E.00874
G1 X86.324 Y96.88 E.00804
G1 X85.794 Y96.856 E.01123
G1 X85.252 Y96.93 E.01157
G1 X84.753 Y97.092 E.01111
; WIPE_START
M204 S6000
G1 X84.589 Y96.949 E-.04131
G1 X84.941 Y96.544 E-.10188
G1 X86.188 Y96.544 E-.23681
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X84.847 Y102.283 Z2.76 F18000
G1 Z2.36
G1 E.4 F1800
G1 F1500
M204 S500
G1 X84.486 Y102.089 E.00867
G1 X84.119 Y101.796 E.00995
G1 X83.81 Y101.442 E.00995
G1 X83.566 Y101.035 E.01004
G1 X83.394 Y100.556 E.01076
G1 X83.339 Y100.289 E.00577
G1 X83.311 Y99.97 E.00679
G1 X83.338 Y99.519 E.00955
G1 X83.404 Y99.206 E.00678
G1 X83.49 Y98.947 E.00577
G1 X83.719 Y98.493 E.01077
G1 X84.009 Y98.118 E.01003
G1 X84.351 Y97.809 E.00975
G1 X84.62 Y97.632 E.00683
G1 X84.909 Y97.487 E.00683
G1 X85.347 Y97.345 E.00975
G1 X85.813 Y97.282 E.00995
G1 X86.273 Y97.302 E.00975
G1 X86.59 Y97.365 E.00683
G1 X86.888 Y97.462 E.00663
G1 X87.17 Y97.592 E.00659
G1 X87.403 Y97.734 E.00577
G1 X87.796 Y98.058 E.01076
G1 X88.097 Y98.424 E.01004
G1 X88.321 Y98.826 E.00975
G1 X88.434 Y99.127 E.00678
G1 X88.5 Y99.391 E.00577
G1 X88.553 Y99.897 E.01076
G1 X88.51 Y100.373 E.01013
G1 X88.368 Y100.861 E.01076
G1 X88.255 Y101.11 E.00577
G1 X88.091 Y101.385 E.00679
G1 X87.798 Y101.741 E.00975
G1 X87.447 Y102.039 E.00975
G1 X87.174 Y102.207 E.00678
G1 X86.928 Y102.324 E.00577
G1 X86.441 Y102.473 E.01076
G1 X85.979 Y102.521 E.00984
G1 X85.659 Y102.507 E.00678
G1 X85.39 Y102.464 E.00578
G1 X84.904 Y102.314 E.01076
G1 X84.9 Y102.312 E.00009
M204 S250
G1 X85.041 Y101.923 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X84.713 Y101.746 E.00734
G1 X84.403 Y101.499 E.0078
G1 X84.142 Y101.2 E.0078
G1 X83.938 Y100.859 E.00782
G1 X83.789 Y100.445 E.00864
G1 X83.745 Y100.23 E.00433
G1 X83.721 Y99.964 E.00525
G1 X83.744 Y99.574 E.00767
G1 X83.8 Y99.314 E.00525
G1 X83.869 Y99.105 E.00433
G1 X84.067 Y98.712 E.00865
G1 X84.31 Y98.397 E.00782
G1 X84.602 Y98.134 E.00774
G1 X84.825 Y97.987 E.00526
G1 X85.065 Y97.867 E.00526
G1 X85.438 Y97.746 E.00773
G1 X85.831 Y97.692 E.0078
G1 X86.224 Y97.71 E.00773
G1 X86.487 Y97.762 E.00526
G1 X86.738 Y97.843 E.0052
G1 X86.977 Y97.954 E.00519
G1 X87.166 Y98.069 E.00433
G1 X87.505 Y98.348 E.00864
G1 X87.757 Y98.655 E.00782
G1 X87.949 Y98.999 E.00773
G1 X88.042 Y99.249 E.00525
G1 X88.096 Y99.462 E.00433
G1 X88.142 Y99.899 E.00865
G1 X88.106 Y100.297 E.00785
G1 X87.983 Y100.719 E.00865
G1 X87.892 Y100.92 E.00433
G1 X87.755 Y101.149 E.00525
G1 X87.506 Y101.452 E.00773
G1 X87.206 Y101.707 E.00773
G1 X86.979 Y101.847 E.00525
G1 X86.779 Y101.941 E.00433
G1 X86.359 Y102.07 E.00864
G1 X85.967 Y102.111 E.00776
G1 X85.7 Y102.099 E.00524
G1 X85.483 Y102.065 E.00433
G1 X85.097 Y101.945 E.00795
; WIPE_START
M204 S6000
G1 X84.713 Y101.746 E-.08216
G1 X84.403 Y101.499 E-.0753
G1 X84.142 Y101.2 E-.07532
G1 X83.938 Y100.859 E-.07559
G1 X83.81 Y100.504 E-.07163
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X84.691 Y96.12 Z2.76 F18000
G1 Z2.36
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X92.488 Y96.12 E.16503
G1 X92.566 Y95.381 E.01572
G1 X92.659 Y95.167 E.00496
G1 X92.799 Y95.027 E.00419
G1 X92.89 Y94.976 E.00219
G1 X93.028 Y94.932 E.00307
G1 X93.225 Y94.93 E.00416
G1 X93.324 Y94.956 E.00218
G1 X93.502 Y95.057 E.00432
G1 X93.574 Y95.13 E.00218
G1 X93.633 Y95.214 E.00217
G1 X93.693 Y95.363 E.0034
G1 X93.708 Y95.516 E.00325
G1 X93.697 Y95.61 E.00201
G1 X93.655 Y95.741 E.0029
G1 X93.535 Y95.915 E.00449
G1 X93.399 Y96.014 E.00356
G1 X93.172 Y96.111 E.00523
G1 X92.999 Y96.272 E.005
G1 X92.866 Y96.364 E.00341
G1 X92.729 Y96.427 E.00321
G1 X92.582 Y96.466 E.00321
G1 X92.404 Y96.482 E.00379
G1 X87.372 Y96.482 E.10649
G1 X88.475 Y97.675 E.03439
G1 X88.725 Y98 E.00869
G1 X88.932 Y98.347 E.00854
G1 X89.066 Y98.642 E.00687
G1 X89.158 Y98.897 E.00574
G1 X89.257 Y99.3 E.00877
G1 X89.304 Y99.68 E.00811
G1 X89.289 Y100.284 E.01278
G1 X89.235 Y100.603 E.00685
G1 X89.099 Y101.076 E.01041
G1 X88.846 Y101.612 E.01255
G1 X88.497 Y102.1 E.01269
G1 X88.214 Y102.393 E.00862
G1 X87.964 Y102.599 E.00687
G1 X87.574 Y102.855 E.00987
G1 X87.203 Y103.032 E.00869
G1 X86.814 Y103.164 E.00869
G1 X86.222 Y103.269 E.01273
G1 X85.63 Y103.267 E.01254
G1 X85.038 Y103.161 E.01274
G1 X84.552 Y102.985 E.01095
G1 X84.12 Y102.754 E.01036
G1 X83.797 Y102.522 E.0084
G1 X83.502 Y102.251 E.00849
G1 X83.24 Y101.947 E.00849
G1 X83.017 Y101.613 E.0085
G1 X82.834 Y101.256 E.00849
G1 X82.696 Y100.879 E.00849
G1 X82.602 Y100.489 E.0085
G1 X82.556 Y100.091 E.00849
G1 X82.574 Y99.499 E.01253
G1 X82.648 Y99.095 E.00869
G1 X82.767 Y98.712 E.00849
G1 X82.93 Y98.345 E.00849
G1 X83.248 Y97.845 E.01253
G1 X84.433 Y96.482 E.03824
G1 X79.467 Y96.482 E.10513
G1 X79.219 Y96.453 E.00527
G1 X79.074 Y96.405 E.00324
G1 X78.859 Y96.269 E.00539
G1 X78.728 Y96.13 E.00404
G1 X78.661 Y96.025 E.00262
G1 X78.58 Y95.821 E.00465
G1 X78.55 Y95.565 E.00546
G1 X78.55 Y77.628 E.37964
G1 X78.586 Y77.357 E.00578
G1 X78.691 Y77.125 E.0054
G1 X78.793 Y76.996 E.00349
G1 X78.892 Y76.907 E.00282
G1 X79.13 Y76.775 E.00575
G1 X79.379 Y76.723 E.00539
G1 X92.434 Y76.721 E.27632
G1 X92.58 Y76.735 E.00311
G1 X92.731 Y76.775 E.0033
G1 X92.96 Y76.904 E.00556
G1 X92.904 Y77.082 E.00395
G1 X79.882 Y77.082 E.27564
G1 X79.612 Y77.125 E.00578
G1 X79.319 Y77.275 E.00698
G1 X79.092 Y77.508 E.00687
G1 X78.949 Y77.801 E.0069
G1 X78.911 Y78.056 E.00546
G1 X78.911 Y95.155 E.36192
G1 X78.964 Y95.453 E.0064
G1 X79.147 Y95.77 E.00775
G1 X79.475 Y96.029 E.00884
G1 X79.858 Y96.12 E.00834
G1 X84.631 Y96.12 E.10103
; WIPE_START
M204 S6000
G1 X86.631 Y96.12 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X83.535 Y96.891 Z2.76 F18000
G1 Z2.36
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X79.443 Y96.891 E.08049
G1 X79.13 Y96.854 E.00619
G1 X78.917 Y96.784 E.00442
G1 X78.788 Y96.719 E.00283
G1 X78.599 Y96.587 E.00454
G1 X78.493 Y96.486 E.00289
G1 X78.301 Y96.221 E.00643
G1 X78.177 Y95.904 E.00669
G1 X78.141 Y95.589 E.00625
G1 X78.141 Y77.61 E.35362
G1 X78.161 Y77.374 E.00466
G1 X78.194 Y77.234 E.00283
G1 X78.28 Y77.019 E.00454
G1 X78.352 Y76.895 E.00283
G1 X78.493 Y76.716 E.0045
G1 X78.639 Y76.584 E.00385
G1 X78.784 Y76.485 E.00347
G1 X78.99 Y76.389 E.00445
G1 X79.21 Y76.33 E.00448
G1 X79.356 Y76.313 E.00289
G1 X92.454 Y76.312 E.25763
G1 X92.653 Y76.331 E.00394
G1 X92.871 Y76.389 E.00444
G1 X93.075 Y76.484 E.00442
G1 X93.259 Y76.613 E.00442
G1 X93.418 Y76.772 E.00442
G1 X93.547 Y76.956 E.00442
G1 X93.642 Y77.16 E.00442
G1 X93.7 Y77.377 E.00442
G1 X93.721 Y77.61 E.0046
G1 X93.721 Y85.511 E.1554
G1 X94.733 Y85.511 E.01991
G1 F1870.245
G1 X94.863 Y85.511 E.00256
G1 F1320
G1 X94.863 Y87.691 E.04288
G1 F1668.584
G1 X94.733 Y87.691 E.00256
G1 F1500
G1 X93.721 Y87.691 E.01991
G1 X93.721 Y88.791 E.02164
G1 X92.541 Y88.791 E.02321
M73 P61 R9
G1 X92.541 Y77.491 E.22226
G1 X79.914 Y77.491 E.24835
G1 X79.741 Y77.518 E.00344
G1 X79.565 Y77.609 E.00389
G1 X79.431 Y77.747 E.00379
G1 X79.344 Y77.923 E.00386
G1 X79.321 Y78.086 E.00323
G1 X79.321 Y95.119 E.33504
G1 X79.354 Y95.311 E.00382
G1 X79.462 Y95.498 E.00425
G1 X79.657 Y95.652 E.00489
G1 X79.906 Y95.711 E.00503
G1 X92.12 Y95.711 E.24023
G1 X92.163 Y95.299 E.00815
G1 X92.219 Y95.117 E.00373
G1 X92.32 Y94.934 E.00411
G1 X92.431 Y94.801 E.00342
G1 X92.566 Y94.689 E.00345
G1 X92.726 Y94.599 E.00361
G1 X92.944 Y94.53 E.00451
G1 X93.116 Y94.512 E.0034
G1 X93.291 Y94.525 E.00345
G1 X93.462 Y94.569 E.00346
G1 X93.621 Y94.642 E.00345
G1 X93.765 Y94.742 E.00345
G1 X93.89 Y94.867 E.00346
G1 X93.99 Y95.011 E.00345
G1 X94.096 Y95.287 E.00582
G1 X94.119 Y95.518 E.00457
G1 X94.1 Y95.697 E.00354
G1 X94.029 Y95.913 E.00446
G1 X93.908 Y96.113 E.0046
G1 X93.702 Y96.308 E.00557
G1 X93.398 Y96.459 E.00668
G1 X93.256 Y96.592 E.00382
G1 X93.07 Y96.72 E.00444
G1 X92.868 Y96.814 E.00438
G1 X92.653 Y96.871 E.00438
G1 X92.421 Y96.891 E.00456
G1 X88.307 Y96.891 E.08092
G1 X88.788 Y97.411 E.01393
G1 X89.064 Y97.77 E.00891
G1 X89.295 Y98.157 E.00886
G1 X89.445 Y98.488 E.00715
G1 X89.55 Y98.779 E.00608
G1 X89.659 Y99.22 E.00894
G1 X89.713 Y99.661 E.00873
G1 X89.714 Y100.117 E.00897
G1 X89.635 Y100.694 E.01146
G1 X89.486 Y101.214 E.01063
G1 X89.343 Y101.547 E.00713
G1 X89.198 Y101.82 E.00609
G1 X88.997 Y102.125 E.00718
G1 X88.806 Y102.369 E.00608
G1 X88.492 Y102.694 E.00889
G1 X88.212 Y102.925 E.00715
G1 X87.766 Y103.216 E.01046
G1 X87.358 Y103.412 E.00891
G1 X86.928 Y103.557 E.00892
G1 X86.716 Y103.609 E.00431
G1 X86.265 Y103.676 E.00897
G1 X86.046 Y103.689 E.00431
G1 X85.593 Y103.676 E.00891
G1 X85.145 Y103.608 E.00891
G1 X84.717 Y103.491 E.00874
G1 X84.379 Y103.357 E.00715
G1 X83.903 Y103.102 E.01062
G1 X83.539 Y102.84 E.00882
G1 X83.207 Y102.536 E.00885
G1 X82.914 Y102.195 E.00885
G1 X82.663 Y101.821 E.00885
G1 X82.459 Y101.42 E.00885
G1 X82.303 Y100.998 E.00885
G1 X82.199 Y100.56 E.00885
G1 X82.147 Y100.113 E.00885
G1 X82.148 Y99.661 E.00891
G1 X82.169 Y99.443 E.0043
G1 X82.25 Y98.997 E.00891
G1 X82.383 Y98.567 E.00885
G1 X82.566 Y98.156 E.00885
G1 X82.798 Y97.767 E.00891
G1 X82.927 Y97.59 E.0043
G1 X83.496 Y96.936 E.01705
; WIPE_START
M204 S6000
G1 X81.496 Y96.914 E-.38
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




G1 X79.309 Y96.244
G1 Z2.36
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.154416
G1 F1500
M204 S6000
G1 X78.995 Y96.009 E.00252
G1 X78.933 Y95.941 E.00059
G1 X78.856 Y95.804 E.001
; LINE_WIDTH: 0.124366
G1 X78.824 Y95.713 E.00048
; LINE_WIDTH: 0.0938975
G1 X78.792 Y95.622 E.00033
; WIPE_START
G1 X78.824 Y95.713 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X84.478 Y97.165 Z2.76 F18000
G1 Z2.36
G1 E.4 F1800
; LINE_WIDTH: 0.477121
G1 F1500
M204 S6000
G1 X84.297 Y97.319 E.00533
; LINE_WIDTH: 0.438433
G1 X84.091 Y97.496 E.00561
; LINE_WIDTH: 0.400651
G1 X83.916 Y97.673 E.00465
; LINE_WIDTH: 0.360308
G1 X83.723 Y97.872 E.00464
G1 X83.395 Y98.307 E.00909
G1 X83.146 Y98.791 E.00909
G1 X83.037 Y99.116 E.00571
G1 X82.954 Y99.545 E.00731
G1 X82.935 Y99.988 E.00739
G1 X82.978 Y100.423 E.00729
G1 X83.063 Y100.768 E.00594
G1 X83.219 Y101.182 E.00737
G1 X83.496 Y101.652 E.00911
G1 X83.777 Y101.985 E.00727
G1 X84.04 Y102.224 E.00594
G1 X84.321 Y102.431 E.00582
G1 X84.744 Y102.655 E.00799
G1 X85.139 Y102.789 E.00696
G1 X85.664 Y102.888 E.00892
G1 X86.186 Y102.886 E.00871
G1 X86.531 Y102.836 E.00583
G1 X87.06 Y102.68 E.0092
G1 X87.391 Y102.521 E.00612
G1 X87.735 Y102.294 E.00687
G1 X88.076 Y101.994 E.00759
G1 X88.393 Y101.613 E.00827
G1 X88.629 Y101.206 E.00785
G1 X88.74 Y100.948 E.00469
G1 X88.881 Y100.427 E.009
G1 X88.926 Y99.91 E.00867
G1 X88.903 Y99.536 E.00624
G1 X88.871 Y99.337 E.00337
G1 X88.795 Y99.009 E.00563
G1 X88.59 Y98.522 E.00881
G1 X88.412 Y98.213 E.00595
G1 X88.053 Y97.778 E.00942
; LINE_WIDTH: 0.379059
G1 X87.855 Y97.591 E.00481
; LINE_WIDTH: 0.418631
G1 X87.629 Y97.38 E.00605
; LINE_WIDTH: 0.455597
G1 X87.47 Y97.254 E.00434
; LINE_WIDTH: 0.481757
G1 X87.312 Y97.128 E.00461
; WIPE_START
G1 X87.47 Y97.254 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X92.699 Y96.142 Z2.76 F18000
G1 Z2.36
G1 E.4 F1800
; LINE_WIDTH: 0.110156
G1 F1500
M204 S6000
G1 X92.945 Y96.001 E.00119
; WIPE_START
G1 X92.699 Y96.142 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X93.406 Y88.542 Z2.76 F18000
G1 X93.586 Y86.601 Z2.76
G1 Z2.36
G1 E.4 F1800
; LINE_WIDTH: 0.114562
G1 F1500
M204 S6000
G1 X93.817 Y86.601 E.00102
; WIPE_START
G1 X93.586 Y86.601 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X87.279 Y82.303 Z2.76 F18000
G1 X79.432 Y76.955 Z2.76
G1 Z2.36
G1 E.4 F1800
; LINE_WIDTH: 0.0895423
G1 F1500
M204 S6000
G1 X79.326 Y76.991 E.00036
; LINE_WIDTH: 0.128438
G1 X79.125 Y77.081 E.00113
; LINE_WIDTH: 0.152355
G1 X78.894 Y77.32 E.0021
G1 X78.837 Y77.434 E.0008
; LINE_WIDTH: 0.101716
G1 X78.787 Y77.597 E.00065
; CHANGE_LAYER
; Z_HEIGHT: 2.48
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F1500
G1 X78.837 Y77.434 E-.38
; WIPE_END
G1 E-.02 F1800
; layer num/total_layer_count: 20/49
; update layer progress
M73 L20
M991 S0 P19 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z2.76 I-.611 J1.053 P1  F18000
G1 X94.201 Y86.344 Z2.76
G1 Z2.48
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X94.201 Y86.857 E.01086
G1 X93.374 Y86.857 E.0175
G1 X93.374 Y86.344 E.01086
G1 X94.141 Y86.344 E.01623
M204 S10000
G1 X94.625 Y85.92 F18000
G1 F1500
M204 S500
G1 X94.625 Y87.282 E.02882
G1 X93.311 Y87.282 E.02781
G1 X93.311 Y88.382 E.02328
G1 X92.95 Y88.382 E.00765
G1 X92.95 Y77.127 E.23821
G1 X93.128 Y77.071 E.00395
G1 X93.191 Y77.162 E.00234
G1 X93.256 Y77.3 E.00324
G1 X93.296 Y77.448 E.00324
G1 X93.311 Y77.628 E.00381
G1 X93.311 Y85.92 E.17551
G1 X94.565 Y85.92 E.02654
; WIPE_START
M204 S6000
G1 X94.625 Y87.282 E-.25894
G1 X93.988 Y87.282 E-.12106
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X93.323 Y94.885 Z2.88 F18000
G1 X93.274 Y95.442 Z2.88
G1 Z2.48
G1 E.4 F1800
G1 F1500
M204 S500
G1 X93.267 Y95.562 E.00255
G1 X93.229 Y95.625 E.00157
G1 X92.954 Y95.742 E.00631
G1 X92.984 Y95.456 E.0061
G1 X93.027 Y95.377 E.00189
G1 X93.132 Y95.344 E.00232
G1 X93.182 Y95.357 E.00109
G1 X93.23 Y95.401 E.00138
; WIPE_START
M204 S6000
G1 X93.267 Y95.562 E-.05487
G1 X93.229 Y95.625 E-.02474
G1 X92.954 Y95.742 E-.0993
G1 X92.984 Y95.456 E-.09603
G1 X93.027 Y95.377 E-.02969
G1 X93.132 Y95.344 E-.03648
G1 X93.182 Y95.357 E-.01711
G1 X93.23 Y95.401 E-.02178
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X85.748 Y96.908 Z2.88 F18000
G1 X84.723 Y97.114 Z2.88
G1 Z2.48
G1 E.4 F1800
G1 F1500
M204 S500
G1 X84.608 Y96.949 E.00425
G1 X84.969 Y96.544 E.01148
G1 X86.92 Y96.544 E.04128
G1 X87.266 Y96.942 E.01116
G1 X87.159 Y97.104 E.0041
G1 X86.697 Y96.953 E.01029
G1 X86.324 Y96.88 E.00804
G1 X85.81 Y96.857 E.0109
G1 X85.432 Y96.897 E.00804
G1 X85.061 Y96.981 E.00804
G1 X84.779 Y97.092 E.00642
; WIPE_START
M204 S6000
G1 X84.608 Y96.949 E-.04231
G1 X84.969 Y96.544 E-.10307
G1 X86.204 Y96.544 E-.23463
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X84.847 Y102.283 Z2.88 F18000
G1 Z2.48
G1 E.4 F1800
G1 F1500
M204 S500
G1 X84.486 Y102.089 E.00866
G1 X84.119 Y101.796 E.00995
G1 X83.816 Y101.449 E.00975
G1 X83.642 Y101.177 E.00683
G1 X83.502 Y100.886 E.00683
G1 X83.366 Y100.446 E.00975
G1 X83.31 Y99.979 E.00995
G1 X83.338 Y99.51 E.00995
G1 X83.45 Y99.054 E.00995
G1 X83.637 Y98.633 E.00975
G1 X83.811 Y98.361 E.00683
G1 X84.018 Y98.108 E.00692
G1 X84.403 Y97.771 E.01083
G1 X84.761 Y97.555 E.00883
G1 X85.187 Y97.388 E.00969
G1 X85.501 Y97.316 E.00683
G1 X85.822 Y97.282 E.00683
G1 X86.273 Y97.302 E.00955
G1 X86.59 Y97.365 E.00683
G1 X86.897 Y97.465 E.00683
G1 X87.309 Y97.671 E.00975
G1 X87.685 Y97.953 E.00995
G1 X87.998 Y98.29 E.00975
G1 X88.18 Y98.557 E.00683
G1 X88.332 Y98.849 E.00696
G1 X88.498 Y99.369 E.01155
G1 X88.552 Y99.887 E.01103
G1 X88.532 Y100.214 E.00692
G1 X88.475 Y100.531 E.00683
G1 X88.326 Y100.967 E.00975
G1 X88.097 Y101.378 E.00995
G1 X87.798 Y101.741 E.00995
G1 X87.435 Y102.049 E.01008
G1 X86.949 Y102.317 E.01175
G1 X86.442 Y102.473 E.01123
G1 X85.964 Y102.523 E.01018
G1 X85.411 Y102.471 E.01175
G1 X84.904 Y102.314 E.01123
G1 X84.899 Y102.311 E.00011
M204 S250
G1 X85.04 Y101.922 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X84.713 Y101.746 E.00732
G1 X84.403 Y101.499 E.0078
G1 X84.144 Y101.203 E.00773
G1 X84 Y100.977 E.00526
G1 X83.884 Y100.736 E.00526
G1 X83.768 Y100.361 E.00773
G1 X83.721 Y99.967 E.0078
G1 X83.744 Y99.571 E.0078
G1 X83.838 Y99.186 E.0078
G1 X83.998 Y98.827 E.00773
G1 X84.142 Y98.602 E.00526
G1 X84.313 Y98.394 E.00529
G1 X84.646 Y98.103 E.0087
G1 X84.943 Y97.923 E.00682
G1 X85.308 Y97.78 E.00771
G1 X85.568 Y97.72 E.00526
G1 X85.835 Y97.692 E.00526
G1 X86.224 Y97.71 E.00767
G1 X86.487 Y97.762 E.00526
G1 X86.741 Y97.844 E.00526
G1 X87.093 Y98.02 E.00773
G1 X87.41 Y98.258 E.0078
G1 X87.677 Y98.546 E.00773
G1 X87.828 Y98.767 E.00526
G1 X87.952 Y99.007 E.00531
G1 X88.095 Y99.453 E.00922
G1 X88.141 Y99.896 E.00876
G1 X88.125 Y100.165 E.00529
G1 X88.077 Y100.428 E.00526
G1 X87.95 Y100.8 E.00773
G1 X87.757 Y101.146 E.0078
G1 X87.506 Y101.452 E.00779
G1 X87.201 Y101.71 E.00784
G1 X86.788 Y101.938 E.00929
G1 X86.359 Y102.07 E.00882
G1 X85.961 Y102.112 E.00787
G1 X85.491 Y102.067 E.00929
G1 X85.096 Y101.945 E.00814
; WIPE_START
M204 S6000
G1 X84.713 Y101.746 E-.08201
G1 X84.403 Y101.499 E-.07534
G1 X84.144 Y101.203 E-.07468
G1 X84 Y100.977 E-.05085
G1 X83.884 Y100.736 E-.05084
G1 X83.812 Y100.503 E-.04629
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X84.722 Y96.12 Z2.88 F18000
G1 Z2.48
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X92.489 Y96.12 E.16438
G1 X92.565 Y95.382 E.0157
G1 X92.659 Y95.167 E.00496
G1 X92.799 Y95.027 E.00419
G1 X92.891 Y94.976 E.00223
G1 X93.027 Y94.933 E.00304
G1 X93.224 Y94.93 E.00417
G1 X93.324 Y94.956 E.00218
G1 X93.502 Y95.057 E.00433
G1 X93.574 Y95.13 E.00217
G1 X93.633 Y95.214 E.00217
G1 X93.693 Y95.365 E.00344
G1 X93.708 Y95.515 E.00319
G1 X93.697 Y95.612 E.00206
G1 X93.655 Y95.74 E.00286
G1 X93.534 Y95.916 E.00452
G1 X93.398 Y96.014 E.00356
G1 X93.172 Y96.111 E.0052
G1 X92.999 Y96.272 E.00501
G1 X92.867 Y96.364 E.0034
G1 X92.729 Y96.427 E.00322
G1 X92.582 Y96.466 E.00321
G1 X92.404 Y96.482 E.00378
G1 X87.427 Y96.482 E.10532
G1 X88.614 Y97.845 E.03825
G1 X88.72 Y97.992 E.00386
G1 X88.935 Y98.353 E.00888
G1 X89.159 Y98.901 E.01254
G1 X89.286 Y99.489 E.01273
G1 X89.305 Y100.084 E.01259
G1 X89.233 Y100.608 E.01119
G1 X89.099 Y101.076 E.01031
G1 X88.845 Y101.612 E.01255
G1 X88.497 Y102.1 E.01269
G1 X88.214 Y102.393 E.00863
G1 X87.967 Y102.596 E.00677
G1 X87.574 Y102.855 E.00997
G1 X87.203 Y103.032 E.00869
G1 X86.814 Y103.164 E.00869
G1 X86.222 Y103.269 E.01273
G1 X85.63 Y103.267 E.01254
G1 X85.053 Y103.165 E.01241
G1 X84.547 Y102.982 E.01139
G1 X84.119 Y102.754 E.01025
G1 X83.797 Y102.522 E.0084
G1 X83.502 Y102.251 E.00849
G1 X83.24 Y101.947 E.00849
G1 X83.017 Y101.613 E.0085
G1 X82.834 Y101.256 E.00849
G1 X82.696 Y100.879 E.00849
G1 X82.604 Y100.495 E.00836
G1 X82.554 Y99.969 E.01119
M73 P62 R9
G1 X82.577 Y99.485 E.01026
G1 X82.648 Y99.095 E.0084
G1 X82.767 Y98.712 E.00849
G1 X82.93 Y98.345 E.00849
G1 X83.137 Y97.998 E.00854
G1 X83.331 Y97.743 E.00678
G1 X84.457 Y96.482 E.0358
G1 X79.467 Y96.482 E.10562
G1 X79.228 Y96.454 E.00508
G1 X79.024 Y96.38 E.00459
G1 X78.932 Y96.324 E.00227
G1 X78.746 Y96.151 E.00539
G1 X78.668 Y96.039 E.00288
G1 X78.579 Y95.815 E.0051
G1 X78.55 Y95.565 E.00533
G1 X78.55 Y77.628 E.37965
G1 X78.588 Y77.349 E.00597
G1 X78.697 Y77.118 E.00539
G1 X78.891 Y76.908 E.00607
G1 X79.13 Y76.775 E.00579
G1 X79.379 Y76.723 E.00539
G1 X92.436 Y76.721 E.27635
G1 X92.58 Y76.735 E.00307
G1 X92.731 Y76.775 E.0033
G1 X92.96 Y76.904 E.00557
G1 X92.904 Y77.082 E.00395
G1 X79.876 Y77.082 E.27574
G1 X79.588 Y77.132 E.0062
G1 X79.31 Y77.282 E.00668
G1 X79.077 Y77.529 E.00717
G1 X78.948 Y77.807 E.00649
G1 X78.911 Y78.056 E.00533
G1 X78.911 Y95.155 E.36192
G1 X78.964 Y95.453 E.0064
G1 X79.152 Y95.778 E.00796
G1 X79.513 Y96.047 E.00952
G1 X79.867 Y96.12 E.00767
G1 X84.662 Y96.12 E.10149
; WIPE_START
M204 S6000
G1 X86.662 Y96.12 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X83.543 Y96.891 Z2.88 F18000
G1 Z2.48
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X79.443 Y96.891 E.08064
G1 X79.133 Y96.855 E.00613
G1 X78.848 Y96.751 E.00597
G1 X78.698 Y96.661 E.00344
G1 X78.545 Y96.538 E.00385
G1 X78.424 Y96.406 E.00352
G1 X78.314 Y96.245 E.00385
G1 X78.236 Y96.084 E.00352
G1 X78.177 Y95.902 E.00376
G1 X78.141 Y95.589 E.00621
G1 X78.141 Y77.61 E.35362
G1 X78.161 Y77.374 E.00466
G1 X78.195 Y77.231 E.00289
G1 X78.245 Y77.093 E.00289
G1 X78.353 Y76.893 E.00448
G1 X78.493 Y76.716 E.00444
G1 X78.637 Y76.585 E.00382
G1 X78.785 Y76.485 E.0035
G1 X78.99 Y76.389 E.00445
G1 X79.21 Y76.33 E.00448
G1 X79.356 Y76.313 E.00289
G1 X92.456 Y76.312 E.25767
G1 X92.653 Y76.331 E.00391
G1 X92.871 Y76.389 E.00444
G1 X93.075 Y76.484 E.00442
G1 X93.259 Y76.613 E.00442
G1 X93.418 Y76.772 E.00442
G1 X93.547 Y76.956 E.00442
G1 X93.642 Y77.16 E.00442
G1 X93.7 Y77.377 E.00442
G1 X93.721 Y77.61 E.0046
G1 X93.721 Y85.511 E.1554
G1 X94.904 Y85.511 E.02328
G1 F1870.275
G1 X95.034 Y85.511 E.00256
G1 F1320
G1 X95.034 Y87.691 E.04288
G1 F1668.612
G1 X94.904 Y87.691 E.00256
G1 F1500
G1 X93.721 Y87.691 E.02328
G1 X93.721 Y88.791 E.02164
G1 X92.541 Y88.791 E.02321
G1 X92.541 Y77.491 E.22226
G1 X79.912 Y77.491 E.24839
G1 X79.724 Y77.524 E.00376
G1 X79.562 Y77.611 E.00361
G1 X79.42 Y77.762 E.00407
G1 X79.344 Y77.925 E.00355
G1 X79.321 Y78.086 E.00319
G1 X79.321 Y95.119 E.33504
G1 X79.354 Y95.311 E.00382
G1 X79.464 Y95.501 E.00431
G1 X79.684 Y95.664 E.0054
G1 X79.909 Y95.711 E.00452
G1 X92.12 Y95.711 E.24017
G1 X92.163 Y95.3 E.00813
G1 X92.219 Y95.117 E.00376
G1 X92.319 Y94.935 E.00408
G1 X92.431 Y94.802 E.00342
G1 X92.565 Y94.689 E.00344
G1 X92.727 Y94.598 E.00365
G1 X92.944 Y94.53 E.00448
G1 X93.116 Y94.512 E.0034
G1 X93.291 Y94.525 E.00345
G1 X93.461 Y94.569 E.00346
G1 X93.621 Y94.642 E.00345
G1 X93.765 Y94.742 E.00346
G1 X93.889 Y94.866 E.00346
G1 X93.99 Y95.01 E.00345
G1 X94.097 Y95.289 E.00587
G1 X94.119 Y95.518 E.00452
G1 X94.099 Y95.699 E.00359
G1 X94.029 Y95.912 E.00442
G1 X93.908 Y96.113 E.00461
G1 X93.703 Y96.308 E.00557
G1 X93.398 Y96.459 E.00669
G1 X93.256 Y96.592 E.00383
G1 X93.07 Y96.72 E.00444
G1 X92.868 Y96.814 E.00439
G1 X92.652 Y96.871 E.00438
G1 X92.421 Y96.891 E.00456
G1 X88.326 Y96.891 E.08055
G1 X88.934 Y97.59 E.01823
G1 X89.063 Y97.767 E.0043
G1 X89.296 Y98.159 E.00897
G1 X89.391 Y98.356 E.00431
G1 X89.551 Y98.78 E.00891
G1 X89.659 Y99.22 E.00891
G1 X89.713 Y99.661 E.00873
G1 X89.714 Y100.111 E.00886
G1 X89.635 Y100.693 E.01154
G1 X89.485 Y101.214 E.01066
G1 X89.345 Y101.542 E.00703
G1 X89.198 Y101.821 E.00619
G1 X89 Y102.121 E.00709
G1 X88.807 Y102.369 E.00617
G1 X88.492 Y102.694 E.00889
G1 X88.215 Y102.922 E.00706
G1 X87.766 Y103.216 E.01056
G1 X87.358 Y103.412 E.00891
G1 X86.928 Y103.557 E.00891
G1 X86.716 Y103.609 E.00431
G1 X86.265 Y103.676 E.00897
G1 X86.046 Y103.689 E.00431
G1 X85.593 Y103.676 E.00891
G1 X85.145 Y103.608 E.00891
G1 X84.935 Y103.557 E.00427
G1 X84.38 Y103.357 E.0116
G1 X83.903 Y103.102 E.01064
G1 X83.539 Y102.84 E.00882
G1 X83.207 Y102.536 E.00885
G1 X82.914 Y102.195 E.00885
G1 X82.663 Y101.821 E.00885
G1 X82.459 Y101.42 E.00885
G1 X82.303 Y100.998 E.00885
G1 X82.199 Y100.563 E.00881
G1 X82.144 Y99.979 E.01153
G1 X82.169 Y99.438 E.01065
G1 X82.25 Y98.997 E.00882
G1 X82.383 Y98.567 E.00885
G1 X82.566 Y98.156 E.00885
G1 X82.797 Y97.769 E.00886
G1 X83.014 Y97.483 E.00706
G1 X83.503 Y96.936 E.01443
; WIPE_START
M204 S6000
G1 X81.503 Y96.914 E-.38
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




G1 X79.376 Y96.249
G1 Z2.48
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.14906
G1 F1500
M204 S6000
G1 X79.148 Y96.126 E.00159
G1 X79.021 Y96.033 E.00097
G1 X78.94 Y95.951 E.0007
G1 X78.871 Y95.834 E.00084
; LINE_WIDTH: 0.127474
G1 X78.831 Y95.728 E.00057
; LINE_WIDTH: 0.0943149
G1 X78.792 Y95.622 E.00039
; WIPE_START
G1 X78.831 Y95.728 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X84.494 Y97.157 Z2.88 F18000
G1 Z2.48
G1 E.4 F1800
; LINE_WIDTH: 0.474824
G1 F1500
M204 S6000
G1 X84.333 Y97.291 E.00469
; LINE_WIDTH: 0.444589
G1 X84.146 Y97.449 E.00512
; LINE_WIDTH: 0.408931
G1 X83.951 Y97.642 E.00524
; LINE_WIDTH: 0.360255
G1 X83.625 Y97.986 E.00791
G1 X83.453 Y98.212 E.00474
G1 X83.311 Y98.443 E.00453
G1 X83.125 Y98.846 E.00741
G1 X83.022 Y99.186 E.00594
G1 X82.956 Y99.529 E.00582
G1 X82.935 Y100.005 E.00796
G1 X82.995 Y100.51 E.00848
G1 X83.155 Y101.036 E.00917
G1 X83.317 Y101.37 E.0062
G1 X83.544 Y101.716 E.00691
G1 X83.869 Y102.078 E.00813
G1 X84.291 Y102.412 E.00898
G1 X84.744 Y102.654 E.00858
G1 X85.159 Y102.795 E.0073
G1 X85.664 Y102.882 E.00856
G1 X85.949 Y102.896 E.00477
G1 X86.186 Y102.886 E.00394
G1 X86.712 Y102.792 E.00893
G1 X87.112 Y102.658 E.00703
G1 X87.661 Y102.349 E.01052
G1 X87.954 Y102.111 E.00629
G1 X88.205 Y101.85 E.00604
G1 X88.514 Y101.417 E.00889
G1 X88.738 Y100.945 E.00872
G1 X88.861 Y100.53 E.00722
G1 X88.923 Y100.061 E.00789
G1 X88.903 Y99.536 E.00876
G1 X88.859 Y99.276 E.0044
G1 X88.79 Y99.016 E.0045
G1 X88.597 Y98.531 E.0087
G1 X88.313 Y98.077 E.00894
G1 X87.933 Y97.654 E.0095
; LINE_WIDTH: 0.395494
G1 X87.808 Y97.537 E.00314
; LINE_WIDTH: 0.431467
G1 X87.683 Y97.421 E.00345
; LINE_WIDTH: 0.467662
G1 X87.557 Y97.304 E.0038
; LINE_WIDTH: 0.468405
G1 X87.395 Y97.34 E.00365
; LINE_WIDTH: 0.433495
G1 X87.234 Y97.375 E.00336
; WIPE_START
G1 X87.395 Y97.34 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X92.7 Y96.142 Z2.88 F18000
G1 Z2.48
G1 E.4 F1800
; LINE_WIDTH: 0.110206
G1 F1500
M204 S6000
G1 X92.945 Y96.001 E.00119
; WIPE_START
G1 X92.7 Y96.142 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X93.406 Y88.542 Z2.88 F18000
G1 X93.586 Y86.601 Z2.88
G1 Z2.48
G1 E.4 F1800
; LINE_WIDTH: 0.114562
G1 F1500
M204 S6000
G1 X93.989 Y86.601 E.00178
; WIPE_START
G1 X93.586 Y86.601 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X87.278 Y82.304 Z2.88 F18000
G1 X79.427 Y76.955 Z2.88
G1 Z2.48
G1 E.4 F1800
; LINE_WIDTH: 0.0897851
G1 F1500
M204 S6000
G1 X79.323 Y76.991 E.00035
; LINE_WIDTH: 0.129386
G1 X79.125 Y77.08 E.00112
; LINE_WIDTH: 0.154276
G1 X79.004 Y77.191 E.00106
G1 X78.854 Y77.387 E.00158
; LINE_WIDTH: 0.10607
G1 X78.788 Y77.595 E.00087
; CHANGE_LAYER
; Z_HEIGHT: 2.6
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F1500
G1 X78.854 Y77.387 E-.38
; WIPE_END
G1 E-.02 F1800
; layer num/total_layer_count: 21/49
; update layer progress
M73 L21
M991 S0 P20 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z2.88 I-.608 J1.054 P1  F18000
G1 X94.372 Y86.344 Z2.88
G1 Z2.6
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X94.372 Y86.857 E.01086
G1 X93.374 Y86.857 E.02113
G1 X93.374 Y86.344 E.01086
G1 X94.312 Y86.344 E.01986
M204 S10000
G1 X94.797 Y85.92 F18000
G1 F1500
M204 S500
G1 X94.797 Y87.282 E.02882
G1 X93.311 Y87.282 E.03144
G1 X93.311 Y88.382 E.02328
G1 X92.95 Y88.382 E.00765
G1 X92.95 Y77.127 E.23821
G1 X93.128 Y77.071 E.00395
G1 X93.191 Y77.162 E.00234
G1 X93.256 Y77.3 E.00324
G1 X93.296 Y77.448 E.00324
G1 X93.311 Y77.628 E.00382
G1 X93.311 Y85.92 E.17551
G1 X94.737 Y85.92 E.03017
; WIPE_START
M204 S6000
G1 X94.797 Y87.282 E-.25894
G1 X94.159 Y87.282 E-.12106
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X93.336 Y94.87 Z3 F18000
G1 X93.274 Y95.442 Z3
G1 Z2.6
G1 E.4 F1800
G1 F1500
M204 S500
G1 X93.273 Y95.554 E.00239
G1 X93.229 Y95.625 E.00175
G1 X92.955 Y95.742 E.00632
G1 X92.984 Y95.457 E.00608
G1 X93.027 Y95.378 E.0019
G1 X93.132 Y95.344 E.00233
G1 X93.182 Y95.357 E.00109
G1 X93.23 Y95.401 E.00138
; WIPE_START
M204 S6000
G1 X93.273 Y95.554 E-.05278
G1 X93.229 Y95.625 E-.02752
G1 X92.955 Y95.742 E-.09919
G1 X92.984 Y95.457 E-.09533
G1 X93.027 Y95.378 E-.02978
G1 X93.132 Y95.344 E-.03654
G1 X93.182 Y95.357 E-.01714
G1 X93.23 Y95.401 E-.02171
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X85.746 Y96.9 Z3 F18000
G1 X84.696 Y97.11 Z3
G1 Z2.6
G1 E.4 F1800
G1 F1500
M204 S500
G1 X84.589 Y96.949 E.0041
G1 X84.941 Y96.544 E.01135
G1 X86.853 Y96.544 E.04046
G1 X87.196 Y96.916 E.0107
G1 X87.09 Y97.081 E.00416
G1 X86.697 Y96.953 E.00874
G1 X86.324 Y96.88 E.00804
G1 X85.794 Y96.856 E.01123
G1 X85.252 Y96.93 E.01157
G1 X84.753 Y97.092 E.01111
; WIPE_START
M204 S6000
G1 X84.589 Y96.949 E-.04131
G1 X84.941 Y96.544 E-.10187
G1 X86.188 Y96.544 E-.23681
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X84.846 Y102.282 Z3 F18000
G1 Z2.6
G1 E.4 F1800
G1 F1500
M204 S500
G1 X84.486 Y102.089 E.00864
G1 X84.119 Y101.796 E.00995
G1 X83.806 Y101.437 E.01008
G1 X83.531 Y100.958 E.0117
G1 X83.367 Y100.451 E.01128
M73 P63 R9
G1 X83.31 Y99.979 E.01005
G1 X83.338 Y99.51 E.00995
G1 X83.45 Y99.054 E.00995
G1 X83.637 Y98.633 E.00975
G1 X83.811 Y98.361 E.00683
G1 X84.016 Y98.111 E.00683
G1 X84.351 Y97.809 E.00956
G1 X84.62 Y97.632 E.00683
G1 X84.909 Y97.487 E.00683
G1 X85.347 Y97.345 E.00975
G1 X85.813 Y97.282 E.00995
G1 X86.273 Y97.302 E.00975
G1 X86.59 Y97.365 E.00683
G1 X86.897 Y97.465 E.00683
G1 X87.309 Y97.671 E.00975
G1 X87.685 Y97.953 E.00995
G1 X87.998 Y98.29 E.00975
G1 X88.18 Y98.557 E.00683
G1 X88.329 Y98.843 E.00683
G1 X88.475 Y99.27 E.00955
G1 X88.532 Y99.588 E.00683
G1 X88.551 Y99.901 E.00663
G1 X88.532 Y100.214 E.00663
G1 X88.475 Y100.531 E.00683
G1 X88.326 Y100.967 E.00975
G1 X88.097 Y101.378 E.00995
G1 X87.798 Y101.741 E.00995
G1 X87.435 Y102.049 E.01008
G1 X86.951 Y102.316 E.0117
G1 X86.442 Y102.473 E.01128
G1 X85.964 Y102.523 E.01018
G1 X85.414 Y102.471 E.0117
G1 X84.904 Y102.314 E.01128
G1 X84.899 Y102.311 E.00013
M204 S250
G1 X85.04 Y101.922 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X84.713 Y101.746 E.00731
G1 X84.403 Y101.499 E.00779
G1 X84.141 Y101.199 E.00784
G1 X83.908 Y100.791 E.00924
G1 X83.768 Y100.362 E.00887
G1 X83.721 Y99.967 E.00783
G1 X83.744 Y99.571 E.0078
G1 X83.838 Y99.186 E.0078
G1 X83.998 Y98.827 E.00773
G1 X84.142 Y98.602 E.00526
G1 X84.312 Y98.395 E.00526
G1 X84.602 Y98.134 E.00767
G1 X84.825 Y97.987 E.00526
G1 X85.065 Y97.867 E.00526
G1 X85.439 Y97.745 E.00773
G1 X85.831 Y97.692 E.0078
G1 X86.224 Y97.71 E.00773
G1 X86.487 Y97.762 E.00526
G1 X86.741 Y97.844 E.00526
G1 X87.093 Y98.02 E.00774
G1 X87.41 Y98.258 E.00779
G1 X87.677 Y98.546 E.00774
G1 X87.828 Y98.767 E.00526
G1 X87.951 Y99.005 E.00527
G1 X88.077 Y99.374 E.00767
G1 X88.125 Y99.637 E.00526
G1 X88.141 Y99.901 E.0052
G1 X88.125 Y100.165 E.0052
G1 X88.077 Y100.428 E.00526
G1 X87.95 Y100.8 E.00773
G1 X87.757 Y101.146 E.0078
G1 X87.506 Y101.452 E.00779
G1 X87.202 Y101.71 E.00784
G1 X86.79 Y101.937 E.00924
G1 X86.359 Y102.07 E.00887
G1 X85.962 Y102.112 E.00787
G1 X85.494 Y102.068 E.00924
G1 X85.095 Y101.945 E.00821
; WIPE_START
M204 S6000
G1 X84.713 Y101.746 E-.0819
G1 X84.403 Y101.499 E-.07528
G1 X84.141 Y101.199 E-.07571
G1 X83.908 Y100.791 E-.08925
G1 X83.813 Y100.501 E-.05786
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X84.691 Y96.12 Z3 F18000
G1 Z2.6
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X92.489 Y96.12 E.16504
G1 X92.565 Y95.384 E.01567
G1 X92.659 Y95.167 E.00498
G1 X92.799 Y95.028 E.00419
G1 X92.892 Y94.975 E.00226
G1 X93.027 Y94.933 E.00301
G1 X93.224 Y94.93 E.00417
G1 X93.324 Y94.956 E.00217
G1 X93.501 Y95.057 E.00433
G1 X93.574 Y95.13 E.00217
G1 X93.633 Y95.214 E.00217
G1 X93.693 Y95.366 E.00347
G1 X93.707 Y95.507 E.003
G1 X93.688 Y95.651 E.00307
G1 X93.654 Y95.744 E.00208
G1 X93.533 Y95.917 E.00447
G1 X93.397 Y96.015 E.00356
G1 X93.18 Y96.107 E.00498
G1 X92.874 Y96.36 E.0084
G1 X92.729 Y96.427 E.0034
G1 X92.582 Y96.466 E.00322
G1 X92.404 Y96.482 E.00378
G1 X87.372 Y96.482 E.10649
G1 X88.475 Y97.675 E.03439
G1 X88.725 Y98 E.00868
G1 X88.936 Y98.353 E.00869
G1 X89.159 Y98.901 E.01254
G1 X89.286 Y99.49 E.01274
G1 X89.305 Y100.084 E.0126
G1 X89.234 Y100.604 E.01109
G1 X89.097 Y101.083 E.01055
G1 X88.847 Y101.608 E.0123
G1 X88.547 Y102.037 E.0111
G1 X88.21 Y102.396 E.01041
G1 X87.971 Y102.594 E.00657
G1 X87.573 Y102.855 E.01006
G1 X87.201 Y103.033 E.00874
G1 X86.903 Y103.136 E.00667
G1 X86.632 Y103.207 E.00594
G1 X86.222 Y103.269 E.00876
G1 X85.63 Y103.267 E.01254
G1 X85.053 Y103.165 E.01241
G1 X84.551 Y102.984 E.01129
G1 X84.119 Y102.754 E.01035
G1 X83.797 Y102.522 E.00839
G1 X83.502 Y102.251 E.00849
G1 X83.24 Y101.947 E.00849
G1 X83.017 Y101.613 E.00849
G1 X82.834 Y101.256 E.00849
G1 X82.696 Y100.879 E.00849
G1 X82.602 Y100.489 E.0085
G1 X82.556 Y100.091 E.00849
G1 X82.574 Y99.499 E.01254
G1 X82.648 Y99.095 E.00869
G1 X82.767 Y98.712 E.00849
G1 X82.934 Y98.336 E.00869
G1 X83.254 Y97.838 E.01254
G1 X84.433 Y96.482 E.03805
G1 X79.467 Y96.482 E.10513
G1 X79.216 Y96.452 E.00533
G1 X79.101 Y96.415 E.00256
G1 X78.859 Y96.269 E.006
G1 X78.691 Y96.076 E.0054
G1 X78.578 Y95.803 E.00626
G1 X78.55 Y95.565 E.00508
G1 X78.55 Y77.619 E.37984
G1 X78.591 Y77.34 E.00597
G1 X78.697 Y77.118 E.0052
G1 X78.89 Y76.908 E.00604
G1 X79.13 Y76.775 E.00582
G1 X79.38 Y76.723 E.00539
G1 X92.438 Y76.721 E.27638
G1 X92.58 Y76.735 E.00303
G1 X92.731 Y76.775 E.0033
G1 X92.96 Y76.904 E.00556
G1 X92.904 Y77.082 E.00395
G1 X79.876 Y77.082 E.27575
G1 X79.588 Y77.132 E.0062
G1 X79.318 Y77.278 E.00649
G1 X79.101 Y77.495 E.00649
G1 X78.949 Y77.798 E.00717
G1 X78.911 Y78.056 E.00552
G1 X78.911 Y95.155 E.36192
G1 X78.964 Y95.453 E.0064
G1 X79.152 Y95.778 E.00796
G1 X79.513 Y96.047 E.00952
G1 X79.867 Y96.12 E.00767
G1 X84.631 Y96.12 E.10083
; WIPE_START
M204 S6000
G1 X86.631 Y96.12 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X83.535 Y96.891 Z3 F18000
G1 Z2.6
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X79.443 Y96.891 E.08049
G1 X79.129 Y96.854 E.00621
G1 X78.949 Y96.796 E.00373
G1 X78.787 Y96.718 E.00354
G1 X78.599 Y96.587 E.0045
G1 X78.495 Y96.488 E.00283
G1 X78.352 Y96.307 E.00454
G1 X78.281 Y96.185 E.00277
G1 X78.177 Y95.898 E.006
G1 X78.141 Y95.589 E.00613
G1 X78.141 Y77.607 E.35368
G1 X78.149 Y77.454 E.00301
G1 X78.196 Y77.228 E.00454
G1 X78.245 Y77.093 E.00283
G1 X78.353 Y76.892 E.00448
G1 X78.493 Y76.715 E.00444
G1 X78.636 Y76.586 E.00379
G1 X78.785 Y76.485 E.00353
G1 X78.99 Y76.389 E.00445
G1 X79.21 Y76.33 E.00448
G1 X79.356 Y76.313 E.00289
G1 X92.457 Y76.312 E.2577
G1 X92.653 Y76.331 E.00387
G1 X92.871 Y76.389 E.00444
G1 X93.075 Y76.484 E.00442
G1 X93.259 Y76.613 E.00442
G1 X93.418 Y76.772 E.00443
G1 X93.547 Y76.956 E.00442
G1 X93.642 Y77.16 E.00442
G1 X93.7 Y77.377 E.00442
G1 X93.721 Y77.61 E.0046
G1 X93.721 Y85.511 E.1554
G1 X95.075 Y85.511 E.02665
G1 F1870.275
G1 X95.206 Y85.511 E.00256
G1 F1320
G1 X95.206 Y87.691 E.04288
G1 F1668.612
G1 X95.075 Y87.691 E.00256
G1 F1500
G1 X93.721 Y87.691 E.02665
G1 X93.721 Y88.791 E.02164
G1 X92.541 Y88.791 E.02321
G1 X92.541 Y77.491 E.22226
G1 X79.912 Y77.491 E.24839
G1 X79.724 Y77.524 E.00376
G1 X79.565 Y77.61 E.00355
G1 X79.437 Y77.738 E.00356
G1 X79.345 Y77.922 E.00406
G1 X79.321 Y78.086 E.00325
G1 X79.321 Y95.119 E.33504
G1 X79.354 Y95.311 E.00382
G1 X79.464 Y95.501 E.00431
G1 X79.684 Y95.664 E.0054
G1 X79.909 Y95.711 E.00452
G1 X92.12 Y95.711 E.24017
G1 X92.162 Y95.301 E.0081
G1 X92.22 Y95.116 E.00381
G1 X92.319 Y94.935 E.00406
G1 X92.431 Y94.802 E.00343
G1 X92.565 Y94.69 E.00344
G1 X92.728 Y94.598 E.00368
G1 X92.943 Y94.53 E.00444
G1 X93.115 Y94.512 E.00341
G1 X93.291 Y94.525 E.00345
G1 X93.461 Y94.568 E.00346
G1 X93.62 Y94.642 E.00345
G1 X93.765 Y94.742 E.00346
G1 X93.889 Y94.866 E.00345
G1 X93.989 Y95.01 E.00346
G1 X94.097 Y95.29 E.0059
G1 X94.119 Y95.514 E.00443
G1 X94.088 Y95.749 E.00466
G1 X94.025 Y95.922 E.00363
G1 X93.908 Y96.112 E.00437
G1 X93.703 Y96.308 E.00559
G1 X93.401 Y96.458 E.00663
G1 X93.193 Y96.641 E.00546
G1 X93.073 Y96.719 E.00281
G1 X92.868 Y96.814 E.00444
G1 X92.652 Y96.871 E.00438
G1 X92.421 Y96.891 E.00456
G1 X88.307 Y96.891 E.08092
G1 X88.788 Y97.411 E.01393
G1 X89.064 Y97.77 E.00891
G1 X89.296 Y98.159 E.00891
G1 X89.391 Y98.356 E.00431
G1 X89.551 Y98.78 E.00891
G1 X89.659 Y99.22 E.00891
G1 X89.713 Y99.661 E.00873
M73 P63 R8
G1 X89.714 Y100.111 E.00887
G1 X89.636 Y100.688 E.01145
G1 X89.485 Y101.216 E.0108
G1 X89.404 Y101.417 E.00427
G1 X89.199 Y101.819 E.00887
G1 X88.865 Y102.296 E.01145
G1 X88.491 Y102.695 E.01076
G1 X88.219 Y102.92 E.00694
G1 X87.766 Y103.216 E.01065
G1 X87.357 Y103.412 E.00893
G1 X87.022 Y103.528 E.00697
G1 X86.714 Y103.609 E.00626
G1 X86.265 Y103.676 E.00893
G1 X86.046 Y103.689 E.00431
G1 X85.593 Y103.676 E.00891
G1 X85.145 Y103.608 E.00891
G1 X84.935 Y103.557 E.00426
G1 X84.384 Y103.359 E.01151
G1 X83.903 Y103.102 E.01074
G1 X83.539 Y102.84 E.00882
G1 X83.207 Y102.536 E.00885
G1 X82.914 Y102.195 E.00885
G1 X82.663 Y101.821 E.00885
G1 X82.459 Y101.42 E.00885
G1 X82.303 Y100.998 E.00885
G1 X82.199 Y100.56 E.00885
G1 X82.147 Y100.114 E.00885
G1 X82.148 Y99.661 E.00891
G1 X82.169 Y99.443 E.0043
G1 X82.25 Y98.997 E.00891
G1 X82.383 Y98.567 E.00885
G1 X82.568 Y98.153 E.00891
G1 X82.674 Y97.962 E.0043
G1 X82.929 Y97.588 E.00891
G1 X83.496 Y96.936 E.01698
; WIPE_START
M204 S6000
G1 X81.496 Y96.914 E-.38
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




G1 X79.331 Y96.249
G1 Z2.6
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.147391
G1 F1500
M204 S6000
G1 X78.955 Y95.969 E.00284
G1 X78.901 Y95.892 E.00057
G1 X78.778 Y95.627 E.00178
; WIPE_START
G1 X78.901 Y95.892 E-.13002
G1 X78.955 Y95.969 E-.04194
G1 X79.331 Y96.249 E-.20805
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X84.478 Y97.165 Z3 F18000
G1 Z2.6
G1 E.4 F1800
; LINE_WIDTH: 0.477112
G1 F1500
M204 S6000
G1 X84.297 Y97.319 E.00533
; LINE_WIDTH: 0.438422
G1 X84.091 Y97.496 E.00561
; LINE_WIDTH: 0.401005
G1 X83.921 Y97.669 E.00453
; LINE_WIDTH: 0.360555
G1 X83.556 Y98.071 E.00907
G1 X83.35 Y98.373 E.00611
G1 X83.124 Y98.848 E.00879
G1 X83.022 Y99.187 E.00591
G1 X82.954 Y99.545 E.0061
G1 X82.937 Y100.071 E.00879
G1 X83.003 Y100.547 E.00802
G1 X83.182 Y101.104 E.00977
G1 X83.35 Y101.418 E.00595
G1 X83.544 Y101.716 E.00594
G1 X83.869 Y102.078 E.00814
G1 X84.291 Y102.412 E.00898
G1 X84.744 Y102.654 E.00859
G1 X85.158 Y102.794 E.0073
G1 X85.664 Y102.882 E.00858
G1 X85.982 Y102.896 E.00531
G1 X86.502 Y102.845 E.00873
G1 X86.791 Y102.768 E.005
G1 X87.114 Y102.656 E.00571
G1 X87.635 Y102.367 E.00995
G1 X87.947 Y102.116 E.00669
G1 X88.249 Y101.795 E.00735
G1 X88.518 Y101.41 E.00785
G1 X88.685 Y101.09 E.00603
G1 X88.862 Y100.526 E.00988
G1 X88.923 Y100.062 E.00782
G1 X88.908 Y99.536 E.00878
G1 X88.839 Y99.188 E.00592
G1 X88.677 Y98.707 E.00847
G1 X88.508 Y98.372 E.00627
G1 X88.285 Y98.046 E.0066
G1 X87.931 Y97.655 E.0088
; LINE_WIDTH: 0.395941
G1 X87.742 Y97.485 E.00471
; LINE_WIDTH: 0.442262
G1 X87.553 Y97.314 E.0053
; LINE_WIDTH: 0.480645
G1 X87.311 Y97.129 E.0069
; WIPE_START
G1 X87.553 Y97.314 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X92.7 Y96.143 Z3 F18000
G1 Z2.6
G1 E.4 F1800
; LINE_WIDTH: 0.124804
G1 F1500
M204 S6000
G1 X92.865 Y96.052 E.00093
; LINE_WIDTH: 0.0924075
G1 X92.944 Y96.002 E.00031
; WIPE_START
G1 X92.865 Y96.052 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X93.446 Y88.441 Z3 F18000
G1 X93.586 Y86.601 Z3
G1 Z2.6
M73 P64 R8
G1 E.4 F1800
; LINE_WIDTH: 0.114562
G1 F1500
M204 S6000
G1 X94.16 Y86.601 E.00254
; WIPE_START
G1 X93.586 Y86.601 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X87.278 Y82.304 Z3 F18000
G1 X79.427 Y76.955 Z3
G1 Z2.6
G1 E.4 F1800
; LINE_WIDTH: 0.089781
G1 F1500
M204 S6000
G1 X79.323 Y76.991 E.00035
; LINE_WIDTH: 0.129833
G1 X79.126 Y77.081 E.00113
; LINE_WIDTH: 0.153673
G1 X79.003 Y77.191 E.00105
G1 X78.866 Y77.369 E.00144
; LINE_WIDTH: 0.12063
G1 X78.825 Y77.487 E.00059
; LINE_WIDTH: 0.0908408
G1 X78.785 Y77.604 E.0004
; CHANGE_LAYER
; Z_HEIGHT: 2.72
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F1500
G1 X78.825 Y77.487 E-.38
; WIPE_END
G1 E-.02 F1800
; layer num/total_layer_count: 22/49
; update layer progress
M73 L22
M991 S0 P21 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z3 I-.597 J1.06 P1  F18000
G1 X94.544 Y86.344 Z3
G1 Z2.72
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X94.544 Y86.857 E.01086
G1 X93.374 Y86.857 E.02476
G1 X93.374 Y86.344 E.01086
G1 X94.484 Y86.344 E.02349
M204 S10000
G1 X94.968 Y85.92 F18000
G1 F1500
M204 S500
G1 X94.968 Y87.282 E.02882
G1 X93.311 Y87.282 E.03506
G1 X93.311 Y88.382 E.02328
G1 X92.95 Y88.382 E.00765
G1 X92.95 Y77.127 E.23821
G1 X93.128 Y77.071 E.00395
G1 X93.191 Y77.162 E.00234
G1 X93.256 Y77.3 E.00324
G1 X93.296 Y77.448 E.00324
G1 X93.311 Y77.628 E.00382
G1 X93.311 Y85.92 E.17551
G1 X94.908 Y85.92 E.03379
; WIPE_START
M204 S6000
G1 X94.968 Y87.282 E-.25894
G1 X94.331 Y87.282 E-.12106
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X93.351 Y94.851 Z3.12 F18000
G1 X93.274 Y95.442 Z3.12
G1 Z2.72
G1 E.4 F1800
G1 F1500
M204 S500
G1 X93.273 Y95.555 E.00238
G1 X93.229 Y95.625 E.00175
G1 X92.955 Y95.742 E.00632
G1 X92.983 Y95.469 E.0058
G1 X93.027 Y95.377 E.00216
G1 X93.131 Y95.344 E.00231
G1 X93.181 Y95.357 E.0011
G1 X93.23 Y95.402 E.00139
; WIPE_START
M204 S6000
G1 X93.273 Y95.555 E-.05279
G1 X93.229 Y95.625 E-.0275
G1 X92.955 Y95.742 E-.09927
G1 X92.983 Y95.469 E-.09111
G1 X93.027 Y95.377 E-.03398
G1 X93.131 Y95.344 E-.03628
G1 X93.181 Y95.357 E-.0172
G1 X93.23 Y95.402 E-.02186
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X85.748 Y96.908 Z3.12 F18000
G1 X84.72 Y97.115 Z3.12
G1 Z2.72
G1 E.4 F1800
G1 F1500
M204 S500
G1 X84.605 Y96.95 E.00425
G1 X84.967 Y96.544 E.01151
G1 X86.92 Y96.544 E.04134
G1 X87.266 Y96.942 E.01117
G1 X87.159 Y97.104 E.0041
G1 X86.697 Y96.953 E.01029
G1 X86.324 Y96.88 E.00804
G1 X85.81 Y96.857 E.0109
G1 X85.432 Y96.897 E.00804
G1 X85.061 Y96.981 E.00804
G1 X84.776 Y97.093 E.00649
; WIPE_START
M204 S6000
G1 X84.605 Y96.95 E-.04229
G1 X84.967 Y96.544 E-.1033
G1 X86.2 Y96.544 E-.23441
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X84.845 Y102.282 Z3.12 F18000
G1 Z2.72
G1 E.4 F1800
G1 F1500
M204 S500
G1 X84.486 Y102.089 E.00863
G1 X84.119 Y101.796 E.00995
G1 X83.81 Y101.442 E.00995
G1 X83.566 Y101.034 E.01005
G1 X83.386 Y100.53 E.01134
G1 X83.31 Y99.985 E.01164
G1 X83.338 Y99.51 E.01007
G1 X83.451 Y99.048 E.01007
G1 X83.684 Y98.55 E.01164
G1 X84.005 Y98.121 E.01133
G1 X84.358 Y97.803 E.01005
G1 X84.758 Y97.556 E.00995
G1 X85.187 Y97.388 E.00975
G1 X85.501 Y97.316 E.00683
G1 X85.822 Y97.282 E.00683
G1 X86.273 Y97.302 E.00955
G1 X86.59 Y97.365 E.00683
G1 X86.897 Y97.465 E.00683
G1 X87.3 Y97.666 E.00955
G1 X87.564 Y97.852 E.00683
G1 X87.804 Y98.068 E.00683
G1 X88.097 Y98.424 E.00975
G1 X88.326 Y98.835 E.00995
G1 X88.475 Y99.27 E.00975
G1 X88.532 Y99.588 E.00683
G1 X88.551 Y99.91 E.00683
G1 X88.51 Y100.374 E.00985
G1 X88.359 Y100.888 E.01134
G1 X88.1 Y101.373 E.01164
G1 X87.798 Y101.741 E.01007
G1 X87.435 Y102.049 E.01007
G1 X86.954 Y102.315 E.01164
G1 X86.442 Y102.473 E.01134
G1 X85.964 Y102.523 E.01018
G1 X85.416 Y102.472 E.01164
G1 X84.904 Y102.314 E.01134
G1 X84.898 Y102.311 E.00015
M204 S250
G1 X85.039 Y101.922 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X84.713 Y101.746 E.00729
G1 X84.403 Y101.499 E.0078
G1 X84.142 Y101.2 E.0078
G1 X83.938 Y100.859 E.00783
G1 X83.785 Y100.432 E.00892
G1 X83.721 Y99.969 E.00919
G1 X83.744 Y99.571 E.00784
G1 X83.839 Y99.184 E.00783
G1 X84.037 Y98.761 E.00919
G1 X84.309 Y98.398 E.00892
G1 X84.604 Y98.132 E.00783
G1 X84.942 Y97.924 E.0078
G1 X85.308 Y97.78 E.00773
G1 X85.568 Y97.72 E.00526
G1 X85.835 Y97.692 E.00526
G1 X86.224 Y97.71 E.00767
G1 X86.487 Y97.762 E.00526
G1 X86.741 Y97.844 E.00526
G1 X87.09 Y98.019 E.00767
G1 X87.309 Y98.173 E.00526
G1 X87.508 Y98.352 E.00526
G1 X87.757 Y98.655 E.00773
G1 X87.95 Y99.002 E.0078
G1 X88.077 Y99.374 E.00773
G1 X88.125 Y99.637 E.00526
G1 X88.141 Y99.904 E.00526
G1 X88.106 Y100.297 E.00776
G1 X87.978 Y100.732 E.00892
G1 X87.759 Y101.145 E.00919
G1 X87.506 Y101.452 E.00784
G1 X87.202 Y101.71 E.00784
G1 X86.793 Y101.936 E.00919
G1 X86.359 Y102.07 E.00892
G1 X85.962 Y102.112 E.00787
G1 X85.496 Y102.068 E.00919
G1 X85.095 Y101.944 E.00827
; WIPE_START
M204 S6000
G1 X84.713 Y101.746 E-.08175
G1 X84.403 Y101.499 E-.0753
G1 X84.142 Y101.2 E-.07532
G1 X83.938 Y100.859 E-.07563
G1 X83.81 Y100.502 E-.072
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X84.719 Y96.12 Z3.12 F18000
G1 Z2.72
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X92.489 Y96.12 E.16445
G1 X92.565 Y95.384 E.01566
G1 X92.658 Y95.168 E.00498
G1 X92.798 Y95.028 E.00418
G1 X92.892 Y94.975 E.00229
G1 X93.026 Y94.933 E.00297
G1 X93.224 Y94.93 E.00418
G1 X93.323 Y94.956 E.00218
G1 X93.501 Y95.057 E.00433
G1 X93.574 Y95.129 E.00217
G1 X93.632 Y95.214 E.00217
G1 X93.693 Y95.367 E.0035
G1 X93.707 Y95.507 E.00296
G1 X93.688 Y95.651 E.00308
G1 X93.654 Y95.745 E.00211
G1 X93.533 Y95.917 E.00446
G1 X93.396 Y96.015 E.00356
G1 X93.177 Y96.109 E.00505
G1 X92.975 Y96.291 E.00575
G1 X92.869 Y96.362 E.0027
G1 X92.729 Y96.427 E.00328
G1 X92.582 Y96.466 E.00322
G1 X92.404 Y96.482 E.00378
G1 X87.428 Y96.482 E.10533
G1 X88.614 Y97.845 E.03824
G1 X88.721 Y97.992 E.00386
G1 X88.935 Y98.353 E.00888
G1 X89.159 Y98.901 E.01254
G1 X89.286 Y99.49 E.01274
G1 X89.305 Y100.091 E.01273
G1 X89.258 Y100.492 E.00855
G1 X89.102 Y101.069 E.01266
G1 X88.845 Y101.613 E.01273
G1 X88.497 Y102.1 E.01268
G1 X88.214 Y102.393 E.00863
G1 X87.974 Y102.591 E.00658
G1 X87.574 Y102.855 E.01016
G1 X87.203 Y103.032 E.00868
G1 X86.814 Y103.164 E.00869
G1 X86.222 Y103.269 E.01273
G1 X85.63 Y103.267 E.01254
G1 X85.047 Y103.163 E.01254
G1 X84.658 Y103.032 E.00869
G1 X84.301 Y102.861 E.00837
G1 X83.868 Y102.575 E.011
G1 X83.498 Y102.247 E.01045
G1 X83.24 Y101.947 E.00839
G1 X83.017 Y101.613 E.00849
G1 X82.837 Y101.261 E.00837
G1 X82.667 Y100.77 E.011
G1 X82.573 Y100.286 E.01045
G1 X82.551 Y99.89 E.00839
G1 X82.576 Y99.49 E.00849
G1 X82.648 Y99.095 E.0085
G1 X82.767 Y98.712 E.00849
G1 X82.93 Y98.345 E.00849
G1 X83.137 Y97.998 E.00855
G1 X83.325 Y97.75 E.00658
G1 X84.454 Y96.482 E.03595
G1 X79.467 Y96.482 E.10557
G1 X79.216 Y96.452 E.00534
G1 X79.103 Y96.416 E.00252
G1 X79.003 Y96.368 E.00234
G1 X78.814 Y96.228 E.00497
G1 X78.665 Y96.033 E.0052
G1 X78.579 Y95.812 E.00501
G1 X78.55 Y95.565 E.00527
G1 X78.55 Y77.628 E.37965
G1 X78.586 Y77.354 E.00584
G1 X78.694 Y77.121 E.00543
G1 X78.889 Y76.909 E.00609
G1 X79.133 Y76.774 E.00591
G1 X79.384 Y76.723 E.00543
G1 X92.439 Y76.721 E.27631
G1 X92.58 Y76.735 E.003
G1 X92.731 Y76.775 E.00331
G1 X92.96 Y76.904 E.00556
G1 X92.904 Y77.082 E.00395
G1 X79.876 Y77.082 E.27575
G1 X79.588 Y77.133 E.0062
G1 X79.314 Y77.28 E.00658
G1 X79.091 Y77.51 E.00679
G1 X78.949 Y77.801 E.00686
G1 X78.911 Y78.056 E.00545
G1 X78.911 Y95.155 E.36192
G1 X78.964 Y95.453 E.0064
G1 X79.152 Y95.778 E.00796
G1 X79.513 Y96.047 E.00952
G1 X79.867 Y96.12 E.00767
G1 X84.659 Y96.12 E.10142
; WIPE_START
M204 S6000
G1 X86.659 Y96.12 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X83.542 Y96.891 Z3.12 F18000
G1 Z2.72
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X79.443 Y96.891 E.08063
G1 X79.129 Y96.854 E.00621
G1 X78.95 Y96.797 E.00369
G1 X78.79 Y96.72 E.00351
G1 X78.541 Y96.534 E.00609
G1 X78.445 Y96.432 E.00277
G1 X78.312 Y96.243 E.00454
G1 X78.248 Y96.114 E.00283
G1 X78.177 Y95.901 E.00442
G1 X78.141 Y95.589 E.00619
G1 X78.141 Y77.61 E.35362
G1 X78.161 Y77.374 E.00466
G1 X78.195 Y77.233 E.00285
G1 X78.264 Y77.052 E.00382
G1 X78.353 Y76.894 E.00357
G1 X78.493 Y76.715 E.00447
G1 X78.635 Y76.587 E.00375
G1 X78.785 Y76.485 E.00357
G1 X78.991 Y76.389 E.00447
G1 X79.174 Y76.338 E.00376
G1 X79.357 Y76.313 E.00363
G1 X92.459 Y76.312 E.2577
G1 X92.653 Y76.331 E.00384
G1 X92.872 Y76.389 E.00444
G1 X93.075 Y76.484 E.00442
G1 X93.259 Y76.613 E.00442
G1 X93.418 Y76.772 E.00442
G1 X93.547 Y76.956 E.00442
G1 X93.642 Y77.16 E.00442
G1 X93.7 Y77.377 E.00442
G1 X93.721 Y77.61 E.0046
G1 X93.721 Y85.511 E.1554
G1 X95.247 Y85.511 E.03002
G1 F1870.275
G1 X95.377 Y85.511 E.00256
G1 F1320
G1 X95.377 Y87.691 E.04288
G1 F1668.612
G1 X95.247 Y87.691 E.00256
G1 F1500
G1 X93.721 Y87.691 E.03002
G1 X93.721 Y88.791 E.02164
G1 X92.541 Y88.791 E.02321
G1 X92.541 Y77.491 E.22226
G1 X79.912 Y77.491 E.24839
G1 X79.724 Y77.524 E.00376
G1 X79.564 Y77.61 E.00358
G1 X79.43 Y77.748 E.00378
G1 X79.344 Y77.923 E.00384
G1 X79.321 Y78.086 E.00322
G1 X79.321 Y95.119 E.33504
G1 X79.354 Y95.311 E.00382
G1 X79.464 Y95.501 E.00431
G1 X79.684 Y95.664 E.0054
G1 X79.909 Y95.711 E.00452
G1 X92.12 Y95.711 E.24017
G1 X92.162 Y95.302 E.00809
G1 X92.22 Y95.116 E.00383
G1 X92.319 Y94.936 E.00404
G1 X92.43 Y94.802 E.00343
G1 X92.564 Y94.69 E.00343
G1 X92.729 Y94.597 E.00371
G1 X92.943 Y94.53 E.00441
G1 X93.115 Y94.512 E.00341
G1 X93.29 Y94.525 E.00345
G1 X93.46 Y94.568 E.00346
G1 X93.62 Y94.641 E.00345
G1 X93.764 Y94.741 E.00346
G1 X93.889 Y94.866 E.00346
G1 X93.989 Y95.01 E.00345
G1 X94.097 Y95.291 E.00594
G1 X94.119 Y95.514 E.0044
G1 X94.088 Y95.749 E.00466
G1 X94.024 Y95.924 E.00366
G1 X93.909 Y96.111 E.00434
G1 X93.703 Y96.308 E.00559
G1 X93.4 Y96.458 E.00667
G1 X93.228 Y96.614 E.00456
G1 X93.071 Y96.72 E.00373
G1 X92.868 Y96.814 E.0044
G1 X92.652 Y96.871 E.00438
G1 X92.421 Y96.891 E.00456
G1 X88.326 Y96.891 E.08055
G1 X88.934 Y97.59 E.01822
G1 X89.063 Y97.767 E.00431
G1 X89.296 Y98.159 E.00897
G1 X89.391 Y98.356 E.00431
G1 X89.551 Y98.78 E.00891
G1 X89.659 Y99.22 E.00891
G1 X89.713 Y99.661 E.00873
G1 X89.714 Y100.114 E.00891
G1 X89.662 Y100.561 E.00887
G1 X89.584 Y100.902 E.00688
G1 X89.487 Y101.211 E.00638
G1 X89.349 Y101.534 E.0069
G1 X89.198 Y101.821 E.00637
G1 X89.005 Y102.114 E.0069
G1 X88.806 Y102.369 E.00636
G1 X88.492 Y102.694 E.00889
G1 X88.223 Y102.917 E.00688
G1 X87.766 Y103.216 E.01074
G1 X87.358 Y103.412 E.00891
G1 X86.928 Y103.557 E.00892
G1 X86.716 Y103.608 E.0043
G1 X86.265 Y103.676 E.00897
G1 X86.046 Y103.689 E.00431
G1 X85.593 Y103.676 E.00891
G1 X85.145 Y103.608 E.00891
G1 X84.933 Y103.557 E.00431
G1 X84.504 Y103.412 E.00891
G1 X84.099 Y103.219 E.00881
G1 X83.618 Y102.901 E.01135
G1 X83.206 Y102.535 E.01083
G1 X82.914 Y102.195 E.00882
G1 X82.663 Y101.821 E.00885
M73 P65 R8
G1 X82.46 Y101.422 E.00881
G1 X82.271 Y100.877 E.01135
G1 X82.166 Y100.336 E.01083
G1 X82.141 Y99.889 E.00882
G1 X82.169 Y99.44 E.00885
G1 X82.25 Y98.997 E.00885
G1 X82.383 Y98.567 E.00885
G1 X82.566 Y98.156 E.00885
G1 X82.797 Y97.769 E.00887
G1 X83.008 Y97.49 E.00688
G1 X83.502 Y96.936 E.0146
; WIPE_START
M204 S6000
G1 X81.502 Y96.914 E-.38
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




G1 X79.331 Y96.249
G1 Z2.72
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.14752
G1 F1500
M204 S6000
G1 X78.956 Y95.968 E.00285
G1 X78.878 Y95.849 E.00087
G1 X78.778 Y95.627 E.00148
; WIPE_START
G1 X78.878 Y95.849 E-.10827
G1 X78.956 Y95.968 E-.06334
G1 X79.331 Y96.249 E-.20839
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X84.492 Y97.159 Z3.12 F18000
G1 Z2.72
G1 E.4 F1800
; LINE_WIDTH: 0.472569
G1 F1500
M204 S6000
G1 X84.309 Y97.312 E.00531
; LINE_WIDTH: 0.434717
G1 X84.101 Y97.489 E.00558
; LINE_WIDTH: 0.398612
G1 X83.919 Y97.672 E.0048
; LINE_WIDTH: 0.361243
G1 X83.621 Y97.994 E.00734
G1 X83.353 Y98.37 E.00774
G1 X83.101 Y98.907 E.00993
G1 X82.968 Y99.439 E.00918
G1 X82.933 Y99.891 E.00758
G1 X82.956 Y100.238 E.00582
G1 X83.024 Y100.636 E.00676
G1 X83.189 Y101.111 E.00842
G1 X83.348 Y101.418 E.00579
G1 X83.544 Y101.716 E.00596
G1 X83.849 Y102.057 E.00766
G1 X84.293 Y102.409 E.00947
G1 X84.744 Y102.655 E.00861
G1 X85.149 Y102.792 E.00715
G1 X85.36 Y102.841 E.00362
G1 X85.664 Y102.882 E.00514
G1 X85.95 Y102.896 E.00479
G1 X86.186 Y102.886 E.00395
G1 X86.712 Y102.792 E.00895
G1 X87.117 Y102.655 E.00715
G1 X87.662 Y102.348 E.01046
G1 X87.953 Y102.111 E.00629
G1 X88.204 Y101.851 E.00606
G1 X88.513 Y101.417 E.00891
G1 X88.714 Y101.014 E.00753
G1 X88.884 Y100.428 E.01022
G1 X88.922 Y100.069 E.00605
G1 X88.922 Y99.701 E.00616
G1 X88.881 Y99.372 E.00554
G1 X88.792 Y99.015 E.00616
G1 X88.666 Y98.667 E.0062
G1 X88.398 Y98.201 E.00899
G1 X88.07 Y97.797 E.00871
; LINE_WIDTH: 0.382469
G1 X87.806 Y97.53 E.00667
; LINE_WIDTH: 0.426796
G1 X87.682 Y97.418 E.00336
; LINE_WIDTH: 0.467462
G1 X87.557 Y97.305 E.0037
G1 X87.532 Y97.31 E.00057
; LINE_WIDTH: 0.436258
G1 X87.382 Y97.344 E.00314
; LINE_WIDTH: 0.40795
G1 X87.232 Y97.378 E.00293
; WIPE_START
G1 X87.382 Y97.344 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X92.7 Y96.142 Z3.12 F18000
G1 Z2.72
G1 E.4 F1800
; LINE_WIDTH: 0.125883
G1 F1500
M204 S6000
G1 X92.815 Y96.084 E.00064
; LINE_WIDTH: 0.100819
G1 X92.945 Y96.001 E.00058
; WIPE_START
G1 X92.815 Y96.084 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X93.434 Y88.477 Z3.12 F18000
G1 X93.586 Y86.601 Z3.12
G1 Z2.72
G1 E.4 F1800
; LINE_WIDTH: 0.114562
G1 F1500
M204 S6000
G1 X94.332 Y86.601 E.0033
; WIPE_START
G1 X93.586 Y86.601 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X87.278 Y82.304 Z3.12 F18000
G1 X79.427 Y76.955 Z3.12
G1 Z2.72
G1 E.4 F1800
; LINE_WIDTH: 0.0898232
G1 F1500
M204 S6000
G1 X79.325 Y76.991 E.00034
; LINE_WIDTH: 0.129686
G1 X79.126 Y77.08 E.00113
; LINE_WIDTH: 0.156294
G1 X79.003 Y77.191 E.00108
G1 X78.868 Y77.364 E.00143
; LINE_WIDTH: 0.121865
G1 X78.819 Y77.482 E.00061
; LINE_WIDTH: 0.0965766
G1 X78.788 Y77.597 E.00042
; CHANGE_LAYER
; Z_HEIGHT: 2.84
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F1500
G1 X78.819 Y77.482 E-.38
; WIPE_END
G1 E-.02 F1800
; layer num/total_layer_count: 23/49
; update layer progress
M73 L23
M991 S0 P22 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z3.12 I-.593 J1.063 P1  F18000
G1 X94.715 Y86.344 Z3.12
G1 Z2.84
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X94.715 Y86.857 E.01086
G1 X93.374 Y86.857 E.02838
G1 X93.374 Y86.344 E.01086
G1 X94.655 Y86.344 E.02711
M204 S10000
G1 X95.139 Y85.92 F18000
G1 F1500
M204 S500
G1 X95.139 Y87.282 E.02882
G1 X93.311 Y87.282 E.03869
G1 X93.311 Y88.382 E.02328
G1 X92.95 Y88.382 E.00765
G1 X92.95 Y77.127 E.23821
G1 X93.128 Y77.071 E.00395
G1 X93.191 Y77.162 E.00234
G1 X93.256 Y77.3 E.00324
G1 X93.296 Y77.448 E.00324
G1 X93.311 Y77.628 E.00382
G1 X93.311 Y85.92 E.17551
G1 X95.079 Y85.92 E.03742
; WIPE_START
M204 S6000
G1 X95.139 Y87.282 E-.25894
G1 X94.502 Y87.282 E-.12106
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X93.367 Y94.829 Z3.24 F18000
G1 X93.275 Y95.442 Z3.24
G1 Z2.84
G1 E.4 F1800
G1 F1500
M204 S500
G1 X93.273 Y95.555 E.00239
G1 X93.23 Y95.625 E.00175
G1 X92.955 Y95.742 E.00632
G1 X92.983 Y95.47 E.00578
G1 X93.027 Y95.377 E.00219
G1 X93.131 Y95.344 E.0023
G1 X93.181 Y95.357 E.0011
G1 X93.23 Y95.402 E.0014
; WIPE_START
M204 S6000
G1 X93.273 Y95.555 E-.05283
G1 X93.23 Y95.625 E-.02742
G1 X92.955 Y95.742 E-.09925
G1 X92.983 Y95.47 E-.09077
G1 X93.027 Y95.377 E-.03436
G1 X93.131 Y95.344 E-.03616
G1 X93.181 Y95.357 E-.01726
G1 X93.23 Y95.402 E-.02194
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X85.749 Y96.913 Z3.24 F18000
G1 X84.692 Y97.126 Z3.24
G1 Z2.84
G1 E.4 F1800
G1 F1500
M204 S500
G1 X84.577 Y96.963 E.00423
G1 X84.941 Y96.544 E.01174
G1 X86.9 Y96.544 E.04146
G1 X87.259 Y96.949 E.01145
G1 X87.148 Y97.113 E.00418
G1 X86.697 Y96.951 E.01013
G1 X86.158 Y96.862 E.01157
G1 X85.612 Y96.87 E.01157
G1 X85.076 Y96.975 E.01157
G1 X84.748 Y97.104 E.00745
; WIPE_START
M204 S6000
G1 X84.577 Y96.963 E-.04213
G1 X84.941 Y96.544 E-.1054
G1 X86.165 Y96.544 E-.23247
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X84.885 Y102.296 Z3.24 F18000
G1 Z2.84
G1 E.4 F1800
G1 F1500
M204 S500
G1 X84.758 Y102.246 E.00288
G1 X84.358 Y101.999 E.00995
G1 X84.016 Y101.69 E.00975
G1 X83.811 Y101.441 E.00683
G1 X83.637 Y101.169 E.00683
G1 X83.455 Y100.76 E.00948
G1 X83.385 Y100.517 E.00535
G1 X83.319 Y100.132 E.00826
G1 X83.319 Y99.675 E.00968
G1 X83.367 Y99.356 E.00683
G1 X83.453 Y99.045 E.00682
G1 X83.641 Y98.624 E.00975
G1 X83.9 Y98.243 E.00975
G1 X84.12 Y98.007 E.00683
G1 X84.366 Y97.798 E.00683
G1 X84.758 Y97.556 E.00975
G1 X85.195 Y97.384 E.00995
G1 X85.657 Y97.294 E.00995
G1 X86.127 Y97.286 E.00995
G1 X86.59 Y97.363 E.00995
G1 X87.03 Y97.521 E.00988
G1 X87.369 Y97.712 E.00826
G1 X87.567 Y97.854 E.00515
G1 X87.797 Y98.062 E.00656
G1 X88.009 Y98.305 E.00683
G1 X88.258 Y98.693 E.00976
G1 X88.436 Y99.128 E.00994
G1 X88.534 Y99.588 E.00995
G1 X88.548 Y100.058 E.00995
G1 X88.478 Y100.523 E.00995
G1 X88.33 Y100.955 E.00968
G1 X88.216 Y101.181 E.00535
G1 X88.002 Y101.507 E.00826
G1 X87.691 Y101.842 E.00968
G1 X87.439 Y102.044 E.00683
G1 X87.165 Y102.213 E.00683
G1 X86.741 Y102.394 E.00975
G1 X86.291 Y102.497 E.00975
G1 X85.97 Y102.521 E.00683
G1 X85.647 Y102.506 E.00683
G1 X85.195 Y102.417 E.00975
G1 X84.941 Y102.317 E.00579
M204 S250
G1 X85.034 Y101.915 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X84.942 Y101.878 E.00196
G1 X84.604 Y101.67 E.0078
G1 X84.312 Y101.407 E.00773
G1 X84.142 Y101.2 E.00526
G1 X83.998 Y100.975 E.00527
G1 X83.84 Y100.619 E.00765
G1 X83.784 Y100.426 E.00396
G1 X83.729 Y100.098 E.00654
G1 X83.729 Y99.706 E.00771
G1 X83.769 Y99.441 E.00526
G1 X83.84 Y99.184 E.00526
G1 X84 Y98.824 E.00774
G1 X84.221 Y98.499 E.00774
G1 X84.403 Y98.303 E.00526
G1 X84.607 Y98.13 E.00526
G1 X84.942 Y97.924 E.00773
G1 X85.311 Y97.779 E.0078
G1 X85.7 Y97.702 E.0078
G1 X86.096 Y97.696 E.00779
G1 X86.487 Y97.761 E.0078
G1 X86.859 Y97.895 E.00777
G1 X87.149 Y98.058 E.00654
G1 X87.31 Y98.173 E.0039
G1 X87.505 Y98.35 E.00518
G1 X87.681 Y98.551 E.00526
G1 X87.893 Y98.883 E.00774
G1 X88.043 Y99.249 E.00779
G1 X88.126 Y99.637 E.0078
G1 X88.137 Y100.033 E.0078
G1 X88.078 Y100.425 E.0078
G1 X87.952 Y100.796 E.00771
G1 X87.861 Y100.976 E.00396
G1 X87.679 Y101.254 E.00654
G1 X87.412 Y101.542 E.00771
G1 X87.203 Y101.708 E.00526
G1 X86.975 Y101.849 E.00526
G1 X86.614 Y102.004 E.00774
G1 X86.23 Y102.091 E.00774
G1 X85.964 Y102.111 E.00526
G1 X85.696 Y102.099 E.00526
G1 X85.311 Y102.023 E.00774
G1 X85.09 Y101.937 E.00466
; WIPE_START
M204 S6000
G1 X84.942 Y101.878 E-.0303
G1 X84.604 Y101.67 E-.07534
G1 X84.312 Y101.407 E-.0747
G1 X84.142 Y101.2 E-.0508
G1 X83.998 Y100.975 E-.05086
G1 X83.84 Y100.619 E-.07386
G1 X83.805 Y100.497 E-.02413
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X84.691 Y96.12 Z3.24 F18000
G1 Z2.84
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X92.489 Y96.12 E.16505
G1 X92.565 Y95.385 E.01564
G1 X92.658 Y95.168 E.00499
G1 X92.798 Y95.028 E.00418
G1 X92.894 Y94.974 E.00234
G1 X93.026 Y94.933 E.00293
G1 X93.223 Y94.93 E.00418
G1 X93.323 Y94.956 E.00218
G1 X93.501 Y95.057 E.00433
G1 X93.574 Y95.129 E.00217
G1 X93.632 Y95.214 E.00217
G1 X93.694 Y95.368 E.00352
G1 X93.707 Y95.506 E.00294
G1 X93.688 Y95.65 E.00307
G1 X93.653 Y95.746 E.00215
G1 X93.532 Y95.918 E.00446
G1 X93.395 Y96.016 E.00356
G1 X93.172 Y96.111 E.00513
G1 X92.999 Y96.272 E.00502
G1 X92.866 Y96.364 E.0034
G1 X92.728 Y96.427 E.00322
G1 X92.582 Y96.466 E.00321
G1 X92.404 Y96.482 E.00379
G1 X87.411 Y96.482 E.10567
G1 X88.549 Y97.766 E.03632
G1 X88.723 Y97.997 E.00612
G1 X88.932 Y98.347 E.00863
G1 X89.059 Y98.626 E.00648
G1 X89.158 Y98.898 E.00613
G1 X89.257 Y99.3 E.00876
G1 X89.304 Y99.68 E.00811
G1 X89.305 Y100.085 E.00856
G1 X89.236 Y100.595 E.0109
G1 X89.1 Y101.075 E.01055
G1 X88.849 Y101.606 E.01243
G1 X88.501 Y102.096 E.01273
G1 X88.215 Y102.391 E.00869
G1 X87.897 Y102.65 E.00868
G1 X87.379 Y102.955 E.01274
G1 X86.814 Y103.164 E.01273
G1 X86.222 Y103.269 E.01273
G1 X85.63 Y103.267 E.01254
G1 X85.038 Y103.161 E.01274
G1 X84.474 Y102.951 E.01272
G1 X84.123 Y102.757 E.00849
G1 X83.797 Y102.522 E.00849
G1 X83.502 Y102.251 E.00849
G1 X83.24 Y101.947 E.00849
G1 X83.017 Y101.613 E.0085
G1 X82.834 Y101.256 E.00849
G1 X82.696 Y100.879 E.00849
G1 X82.602 Y100.489 E.0085
G1 X82.556 Y100.091 E.00849
G1 X82.574 Y99.499 E.01253
G1 X82.648 Y99.095 E.00869
G1 X82.767 Y98.712 E.00849
G1 X82.93 Y98.345 E.00849
G1 X83.248 Y97.845 E.01254
G1 X84.434 Y96.482 E.03824
G1 X79.467 Y96.482 E.10513
G1 X79.228 Y96.454 E.00508
G1 X78.955 Y96.34 E.00626
G1 X78.828 Y96.24 E.00343
G1 X78.72 Y96.119 E.00343
G1 X78.615 Y95.928 E.00461
G1 X78.579 Y95.815 E.00249
G1 X78.55 Y95.565 E.00534
G1 X78.55 Y77.628 E.37965
G1 X78.586 Y77.357 E.00578
G1 X78.691 Y77.125 E.0054
G1 X78.888 Y76.91 E.00617
G1 X79.13 Y76.775 E.00587
G1 X79.379 Y76.723 E.00539
G1 X92.441 Y76.721 E.27645
G1 X92.58 Y76.735 E.00296
G1 X92.731 Y76.775 E.00331
G1 X92.96 Y76.904 E.00557
G1 X92.904 Y77.082 E.00395
G1 X79.876 Y77.082 E.27574
G1 X79.588 Y77.133 E.0062
G1 X79.31 Y77.282 E.00669
G1 X79.077 Y77.529 E.00717
G1 X78.948 Y77.807 E.00649
G1 X78.911 Y78.056 E.00533
G1 X78.911 Y95.155 E.36192
G1 X78.964 Y95.452 E.00639
G1 X79.152 Y95.778 E.00796
G1 X79.512 Y96.047 E.00952
G1 X79.867 Y96.12 E.00767
G1 X84.631 Y96.12 E.10084
; WIPE_START
M204 S6000
G1 X86.632 Y96.12 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X83.535 Y96.891 Z3.24 F18000
G1 Z2.84
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X79.443 Y96.891 E.08049
G1 X79.133 Y96.855 E.00613
G1 X78.846 Y96.75 E.006
G1 X78.725 Y96.68 E.00277
G1 X78.546 Y96.539 E.00448
G1 X78.394 Y96.368 E.00448
G1 X78.315 Y96.247 E.00286
G1 X78.234 Y96.08 E.00366
G1 X78.177 Y95.902 E.00366
G1 X78.141 Y95.589 E.00621
G1 X78.141 Y77.61 E.35362
G1 X78.161 Y77.374 E.00466
G1 X78.194 Y77.234 E.00283
G1 X78.28 Y77.019 E.00454
G1 X78.352 Y76.895 E.00283
G1 X78.493 Y76.715 E.0045
G1 X78.634 Y76.588 E.00372
G1 X78.785 Y76.485 E.0036
G1 X78.99 Y76.389 E.00445
G1 X79.21 Y76.33 E.00448
G1 X79.356 Y76.313 E.00289
G1 X92.461 Y76.312 E.25776
G1 X92.653 Y76.331 E.00381
G1 X92.871 Y76.389 E.00444
G1 X93.075 Y76.484 E.00442
G1 X93.259 Y76.613 E.00442
G1 X93.418 Y76.772 E.00442
G1 X93.547 Y76.956 E.00442
G1 X93.642 Y77.16 E.00442
G1 X93.7 Y77.377 E.00442
G1 X93.721 Y77.61 E.0046
G1 X93.721 Y85.511 E.1554
G1 X95.418 Y85.511 E.03339
G1 F1870.245
G1 X95.549 Y85.511 E.00256
G1 F1320
G1 X95.549 Y87.691 E.04288
G1 F1668.584
G1 X95.418 Y87.691 E.00256
G1 F1500
G1 X93.721 Y87.691 E.03339
G1 X93.721 Y88.791 E.02164
G1 X92.541 Y88.791 E.02321
G1 X92.541 Y77.491 E.22226
G1 X79.912 Y77.491 E.24839
G1 X79.724 Y77.524 E.00376
G1 X79.562 Y77.611 E.00362
G1 X79.42 Y77.762 E.00406
G1 X79.344 Y77.925 E.00355
G1 X79.321 Y78.086 E.00319
G1 X79.321 Y95.119 E.33504
G1 X79.354 Y95.31 E.00382
G1 X79.464 Y95.5 E.00431
G1 X79.684 Y95.664 E.0054
G1 X79.909 Y95.711 E.00452
G1 X92.12 Y95.711 E.24018
G1 X92.162 Y95.303 E.00807
G1 X92.22 Y95.115 E.00386
G1 X92.318 Y94.936 E.00401
G1 X92.43 Y94.802 E.00343
G1 X92.564 Y94.69 E.00344
M73 P66 R8
G1 X92.731 Y94.597 E.00376
G1 X92.942 Y94.53 E.00436
G1 X93.114 Y94.512 E.00341
G1 X93.29 Y94.525 E.00345
G1 X93.46 Y94.568 E.00346
G1 X93.619 Y94.641 E.00345
G1 X93.764 Y94.741 E.00346
G1 X93.888 Y94.865 E.00346
G1 X93.989 Y95.009 E.00346
G1 X94.097 Y95.292 E.00596
G1 X94.119 Y95.513 E.00437
G1 X94.088 Y95.748 E.00466
G1 X94.024 Y95.925 E.0037
G1 X93.909 Y96.111 E.0043
G1 X93.704 Y96.308 E.00559
G1 X93.398 Y96.459 E.0067
G1 X93.256 Y96.592 E.00383
G1 X93.07 Y96.72 E.00444
G1 X92.868 Y96.814 E.00439
G1 X92.652 Y96.871 E.00438
G1 X92.421 Y96.891 E.00456
G1 X88.321 Y96.891 E.08066
G1 X88.866 Y97.507 E.01619
G1 X89.064 Y97.769 E.00644
G1 X89.295 Y98.157 E.00889
G1 X89.438 Y98.471 E.00679
G1 X89.55 Y98.779 E.00645
G1 X89.659 Y99.22 E.00893
G1 X89.713 Y99.661 E.00873
G1 X89.714 Y100.112 E.00887
G1 X89.638 Y100.679 E.01126
G1 X89.486 Y101.213 E.01092
G1 X89.305 Y101.627 E.00888
G1 X89.199 Y101.818 E.0043
G1 X88.945 Y102.197 E.00897
G1 X88.808 Y102.368 E.00431
G1 X88.493 Y102.693 E.00891
G1 X88.141 Y102.979 E.0089
G1 X87.96 Y103.102 E.00431
G1 X87.561 Y103.322 E.00897
G1 X87.361 Y103.411 E.0043
G1 X86.928 Y103.557 E.00898
G1 X86.716 Y103.608 E.0043
G1 X86.265 Y103.676 E.00897
G1 X86.046 Y103.689 E.00431
G1 X85.593 Y103.676 E.00891
G1 X85.145 Y103.608 E.00891
G1 X84.929 Y103.556 E.00437
G1 X84.717 Y103.491 E.00436
G1 X84.298 Y103.321 E.00891
G1 X83.904 Y103.103 E.00885
G1 X83.539 Y102.84 E.00885
G1 X83.207 Y102.536 E.00885
G1 X82.914 Y102.195 E.00885
G1 X82.663 Y101.821 E.00885
G1 X82.459 Y101.42 E.00885
G1 X82.303 Y100.998 E.00885
G1 X82.199 Y100.56 E.00885
G1 X82.147 Y100.113 E.00885
G1 X82.148 Y99.661 E.00891
G1 X82.169 Y99.443 E.0043
G1 X82.25 Y98.997 E.00891
G1 X82.383 Y98.567 E.00885
G1 X82.566 Y98.156 E.00885
G1 X82.798 Y97.767 E.00891
G1 X82.927 Y97.59 E.0043
G1 X83.496 Y96.936 E.01704
; WIPE_START
M204 S6000
G1 X81.496 Y96.914 E-.38
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




G1 X79.376 Y96.249
G1 Z2.84
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.149557
G1 F1500
M204 S6000
G1 X79.143 Y96.123 E.00163
G1 X79.021 Y96.033 E.00094
G1 X78.939 Y95.954 E.00071
G1 X78.868 Y95.829 E.00089
; LINE_WIDTH: 0.126699
G1 X78.83 Y95.726 E.00056
; LINE_WIDTH: 0.0941143
G1 X78.792 Y95.622 E.00038
; WIPE_START
G1 X78.83 Y95.726 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X84.466 Y97.174 Z3.24 F18000
G1 Z2.84
G1 E.4 F1800
; LINE_WIDTH: 0.474015
G1 F1500
M204 S6000
G1 X84.301 Y97.314 E.00486
; LINE_WIDTH: 0.4415
G1 X84.113 Y97.475 E.00513
; LINE_WIDTH: 0.408458
G1 X83.988 Y97.599 E.00336
; LINE_WIDTH: 0.360019
G1 X83.597 Y98.018 E.00955
G1 X83.319 Y98.428 E.00827
G1 X83.125 Y98.846 E.00769
G1 X83.02 Y99.184 E.0059
G1 X82.942 Y99.659 E.00804
G1 X82.938 Y100.069 E.00683
G1 X82.98 Y100.422 E.00593
G1 X83.061 Y100.769 E.00594
G1 X83.187 Y101.102 E.00593
G1 X83.299 Y101.337 E.00435
G1 X83.499 Y101.655 E.00627
G1 X83.751 Y101.961 E.0066
G1 X84.039 Y102.225 E.00653
G1 X84.329 Y102.432 E.00593
G1 X84.638 Y102.607 E.00594
G1 X85.104 Y102.783 E.0083
G1 X85.664 Y102.888 E.0095
G1 X86.029 Y102.898 E.0061
G1 X86.56 Y102.829 E.00893
G1 X87.069 Y102.671 E.00889
G1 X87.548 Y102.425 E.00898
G1 X87.958 Y102.112 E.0086
G1 X88.21 Y101.846 E.00611
G1 X88.521 Y101.41 E.00894
G1 X88.67 Y101.111 E.00557
G1 X88.739 Y100.943 E.00303
G1 X88.863 Y100.517 E.00739
G1 X88.926 Y100.062 E.00767
G1 X88.909 Y99.536 E.00878
G1 X88.796 Y99.009 E.00898
G1 X88.595 Y98.521 E.00881
G1 X88.319 Y98.088 E.00855
G1 X88.061 Y97.788 E.0066
; LINE_WIDTH: 0.381592
G1 X87.81 Y97.536 E.00631
; LINE_WIDTH: 0.417545
G1 X87.711 Y97.446 E.00262
; LINE_WIDTH: 0.450029
G1 X87.592 Y97.34 E.00336
; LINE_WIDTH: 0.477667
G1 X87.371 Y97.162 E.00641
; WIPE_START
G1 X87.592 Y97.34 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X92.7 Y96.141 Z3.24 F18000
G1 Z2.84
G1 E.4 F1800
; LINE_WIDTH: 0.110594
G1 F1500
M204 S6000
G1 X92.946 Y96 E.0012
; WIPE_START
G1 X92.7 Y96.141 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X93.406 Y88.541 Z3.24 F18000
G1 X93.586 Y86.601 Z3.24
G1 Z2.84
G1 E.4 F1800
; LINE_WIDTH: 0.114562
G1 F1500
M204 S6000
G1 X94.503 Y86.601 E.00406
; WIPE_START
G1 X93.586 Y86.601 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X87.278 Y82.304 Z3.24 F18000
G1 X79.427 Y76.955 Z3.24
G1 Z2.84
G1 E.4 F1800
; LINE_WIDTH: 0.0897818
G1 F1500
M204 S6000
G1 X79.323 Y76.991 E.00035
; LINE_WIDTH: 0.129336
G1 X79.125 Y77.079 E.00112
; LINE_WIDTH: 0.1564
G1 X79.003 Y77.192 E.00109
G1 X78.855 Y77.387 E.0016
; LINE_WIDTH: 0.10515
G1 X78.788 Y77.595 E.00086
; CHANGE_LAYER
; Z_HEIGHT: 2.96
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F1500
G1 X78.855 Y77.387 E-.38
; WIPE_END
G1 E-.02 F1800
; layer num/total_layer_count: 24/49
; update layer progress
M73 L24
M991 S0 P23 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z3.24 I-.594 J1.062 P1  F18000
G1 X94.887 Y86.344 Z3.24
G1 Z2.96
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X94.887 Y86.857 E.01086
G1 X93.374 Y86.857 E.03201
G1 X93.374 Y86.344 E.01086
G1 X94.827 Y86.344 E.03074
M204 S10000
G1 X95.311 Y85.92 F18000
G1 F1500
M204 S500
G1 X95.311 Y87.282 E.02882
G1 X93.311 Y87.282 E.04232
G1 X93.311 Y88.382 E.02328
G1 X92.95 Y88.382 E.00765
G1 X92.95 Y77.127 E.23821
G1 X93.128 Y77.071 E.00395
G1 X93.191 Y77.162 E.00234
G1 X93.256 Y77.3 E.00324
G1 X93.296 Y77.448 E.00324
G1 X93.311 Y77.628 E.00382
G1 X93.311 Y85.92 E.17551
G1 X95.251 Y85.92 E.04105
; WIPE_START
M204 S6000
G1 X95.311 Y87.282 E-.25894
G1 X94.674 Y87.282 E-.12106
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X93.384 Y94.804 Z3.36 F18000
G1 X93.275 Y95.442 Z3.36
G1 Z2.96
G1 E.4 F1800
G1 F1500
M204 S500
G1 X93.273 Y95.555 E.00239
G1 X93.23 Y95.625 E.00174
G1 X92.955 Y95.742 E.00632
G1 X92.982 Y95.471 E.00576
G1 X93.02 Y95.39 E.00189
G1 X93.131 Y95.344 E.00254
G1 X93.181 Y95.357 E.0011
G1 X93.23 Y95.402 E.00141
; WIPE_START
M204 S6000
G1 X93.273 Y95.555 E-.05302
G1 X93.23 Y95.625 E-.02746
G1 X92.955 Y95.742 E-.09955
G1 X92.982 Y95.471 E-.0908
G1 X93.02 Y95.39 E-.02976
G1 X93.131 Y95.344 E-.03999
G1 X93.181 Y95.357 E-.01726
G1 X93.23 Y95.402 E-.02215
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X85.749 Y96.913 Z3.36 F18000
G1 X84.692 Y97.126 Z3.36
G1 Z2.96
G1 E.4 F1800
G1 F1500
M204 S500
G1 X84.577 Y96.963 E.00423
G1 X84.941 Y96.544 E.01174
G1 X86.92 Y96.544 E.04187
G1 X87.284 Y96.963 E.01176
G1 X87.165 Y97.127 E.00429
G1 X86.887 Y97.009 E.0064
G1 X86.519 Y96.913 E.00804
G1 X86.143 Y96.862 E.00804
G1 X85.612 Y96.87 E.01123
G1 X85.076 Y96.975 E.01157
G1 X84.748 Y97.104 E.00746
; WIPE_START
M204 S6000
G1 X84.577 Y96.963 E-.04213
G1 X84.941 Y96.544 E-.10541
G1 X86.165 Y96.544 E-.23246
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X84.883 Y102.295 Z3.36 F18000
G1 Z2.96
G1 E.4 F1800
G1 F1500
M204 S500
G1 X84.758 Y102.246 E.00286
G1 X84.353 Y101.996 E.01007
G1 X83.958 Y101.627 E.01145
G1 X83.677 Y101.24 E.01012
G1 X83.448 Y100.748 E.01147
G1 X83.327 Y100.212 E.01164
G1 X83.318 Y99.671 E.01144
G1 X83.403 Y99.203 E.01006
G1 X83.565 Y98.772 E.00975
G1 X83.722 Y98.49 E.00683
G1 X83.912 Y98.229 E.00683
G1 X84.229 Y97.908 E.00956
G1 X84.487 Y97.714 E.00683
G1 X84.767 Y97.553 E.00683
G1 X85.195 Y97.384 E.00975
G1 X85.657 Y97.294 E.00995
G1 X86.117 Y97.287 E.00975
G1 X86.437 Y97.33 E.00683
G1 X86.749 Y97.411 E.00683
G1 X87.178 Y97.594 E.00987
G1 X87.627 Y97.903 E.01154
G1 X88.002 Y98.293 E.01145
G1 X88.256 Y98.69 E.00998
G1 X88.414 Y99.065 E.00862
G1 X88.533 Y99.583 E.01124
G1 X88.548 Y100.058 E.01006
G1 X88.479 Y100.513 E.00975
G1 X88.384 Y100.822 E.00683
G1 X88.252 Y101.117 E.00683
G1 X88.002 Y101.509 E.00986
G1 X87.627 Y101.899 E.01145
G1 X87.178 Y102.207 E.01153
G1 X86.741 Y102.394 E.01006
G1 X86.291 Y102.497 E.00975
G1 X85.97 Y102.521 E.00683
G1 X85.647 Y102.506 E.00683
G1 X85.195 Y102.417 E.00975
G1 X84.939 Y102.317 E.00582
M204 S250
G1 X85.033 Y101.914 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X84.942 Y101.878 E.00193
G1 X84.603 Y101.669 E.00783
G1 X84.266 Y101.354 E.00907
G1 X84.032 Y101.031 E.00785
G1 X83.838 Y100.615 E.00902
G1 X83.736 Y100.163 E.00913
G1 X83.728 Y99.704 E.00901
G1 X83.799 Y99.313 E.00783
G1 X83.938 Y98.944 E.00774
G1 X84.068 Y98.711 E.00526
G1 X84.225 Y98.495 E.00526
G1 X84.499 Y98.217 E.00767
G1 X84.713 Y98.056 E.00526
G1 X84.945 Y97.922 E.00526
G1 X85.311 Y97.779 E.00774
G1 X85.7 Y97.702 E.0078
G1 X86.093 Y97.696 E.00773
G1 X86.358 Y97.732 E.00526
G1 X86.617 Y97.799 E.00526
G1 X86.98 Y97.955 E.00777
G1 X87.361 Y98.216 E.0091
G1 X87.679 Y98.547 E.00902
G1 X87.892 Y98.881 E.00781
G1 X88.024 Y99.192 E.00663
G1 X88.126 Y99.635 E.00895
G1 X88.137 Y100.033 E.00783
G1 X88.079 Y100.422 E.00773
G1 X88 Y100.678 E.00526
G1 X87.891 Y100.922 E.00526
G1 X87.679 Y101.255 E.00777
G1 X87.361 Y101.586 E.00902
G1 X86.98 Y101.847 E.00909
G1 X86.614 Y102.004 E.00783
G1 X86.23 Y102.091 E.00774
G1 X85.964 Y102.111 E.00526
G1 X85.696 Y102.099 E.00526
G1 X85.311 Y102.023 E.00774
G1 X85.089 Y101.936 E.00469
; WIPE_START
M204 S6000
G1 X84.942 Y101.878 E-.03004
G1 X84.603 Y101.669 E-.07568
G1 X84.266 Y101.354 E-.08759
G1 X84.032 Y101.031 E-.0758
G1 X83.838 Y100.615 E-.08716
G1 X83.811 Y100.494 E-.02374
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X84.691 Y96.12 Z3.36 F18000
G1 Z2.96
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X92.49 Y96.12 E.16506
G1 X92.565 Y95.386 E.01563
G1 X92.599 Y95.276 E.00244
G1 X92.658 Y95.168 E.00259
G1 X92.797 Y95.029 E.00418
G1 X92.895 Y94.974 E.00236
G1 X93.026 Y94.933 E.0029
G1 X93.223 Y94.93 E.00419
G1 X93.323 Y94.955 E.00217
G1 X93.416 Y94.998 E.00218
G1 X93.573 Y95.129 E.00433
G1 X93.632 Y95.213 E.00217
G1 X93.694 Y95.369 E.00355
G1 X93.707 Y95.506 E.0029
G1 X93.688 Y95.65 E.00307
G1 X93.653 Y95.747 E.00219
G1 X93.531 Y95.919 E.00445
G1 X93.394 Y96.016 E.00356
G1 X93.172 Y96.11 E.0051
G1 X92.999 Y96.272 E.00502
G1 X92.866 Y96.364 E.0034
G1 X92.729 Y96.427 E.00321
G1 X92.582 Y96.466 E.00321
G1 X92.404 Y96.482 E.00378
G1 X87.427 Y96.482 E.10533
G1 X88.614 Y97.845 E.03825
G1 X88.72 Y97.992 E.00385
G1 X88.935 Y98.353 E.00889
G1 X89.159 Y98.901 E.01254
G1 X89.286 Y99.489 E.01273
G1 X89.305 Y100.085 E.01261
G1 X89.237 Y100.591 E.01081
G1 X89.097 Y101.083 E.01084
G1 X88.844 Y101.613 E.01242
G1 X88.505 Y102.092 E.01242
G1 X88.136 Y102.459 E.011
G1 X87.726 Y102.765 E.01084
G1 X87.574 Y102.855 E.00375
G1 X87.024 Y103.099 E.01273
G1 X86.628 Y103.208 E.00869
G1 X86.222 Y103.269 E.00869
G1 X85.63 Y103.267 E.01254
G1 X85.038 Y103.161 E.01274
G1 X84.474 Y102.951 E.01273
G1 X84.123 Y102.757 E.00849
G1 X83.797 Y102.522 E.00849
G1 X83.502 Y102.251 E.0085
G1 X83.24 Y101.947 E.00849
G1 X83.017 Y101.613 E.00849
G1 X82.837 Y101.261 E.00837
G1 X82.669 Y100.779 E.0108
G1 X82.573 Y100.285 E.01064
G1 X82.551 Y99.89 E.00838
G1 X82.576 Y99.49 E.00849
G1 X82.648 Y99.095 E.0085
G1 X82.767 Y98.712 E.00849
G1 X82.934 Y98.337 E.00869
G1 X83.254 Y97.838 E.01254
G1 X84.434 Y96.482 E.03805
G1 X79.467 Y96.482 E.10513
G1 X79.138 Y96.43 E.00703
G1 X78.991 Y96.362 E.00344
G1 X78.859 Y96.269 E.00343
G1 X78.728 Y96.13 E.00402
G1 X78.658 Y96.019 E.00279
G1 X78.58 Y95.821 E.0045
G1 X78.55 Y95.565 E.00546
G1 X78.55 Y77.628 E.37965
G1 X78.587 Y77.354 E.00585
G1 X78.694 Y77.121 E.00543
G1 X78.887 Y76.911 E.00603
G1 X79.138 Y76.772 E.00609
G1 X79.389 Y76.723 E.0054
G1 X92.442 Y76.721 E.27629
G1 X92.58 Y76.735 E.00292
G1 X92.731 Y76.775 E.00332
G1 X92.96 Y76.904 E.00556
G1 X92.904 Y77.082 E.00395
G1 X79.877 Y77.082 E.27574
G1 X79.588 Y77.132 E.0062
G1 X79.318 Y77.278 E.0065
G1 X79.101 Y77.495 E.00649
G1 X78.949 Y77.797 E.00717
G1 X78.911 Y78.056 E.00553
G1 X78.911 Y95.155 E.36192
G1 X78.964 Y95.453 E.0064
G1 X79.152 Y95.778 E.00796
G1 X79.512 Y96.047 E.00951
G1 X79.867 Y96.12 E.00767
G1 X84.631 Y96.12 E.10083
; WIPE_START
M204 S6000
G1 X86.631 Y96.12 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X83.535 Y96.891 Z3.36 F18000
G1 Z2.96
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X79.443 Y96.891 E.08049
G1 X79.127 Y96.854 E.00625
G1 X78.992 Y96.814 E.00277
M73 P67 R8
G1 X78.786 Y96.717 E.00448
G1 X78.599 Y96.587 E.00448
G1 X78.492 Y96.486 E.00289
G1 X78.297 Y96.214 E.00659
G1 X78.177 Y95.904 E.00653
G1 X78.141 Y95.589 E.00625
G1 X78.141 Y77.61 E.35362
G1 X78.161 Y77.374 E.00466
G1 X78.195 Y77.233 E.00286
G1 X78.263 Y77.055 E.00375
G1 X78.353 Y76.894 E.00363
G1 X78.494 Y76.715 E.00447
G1 X78.632 Y76.589 E.00369
G1 X78.785 Y76.485 E.00363
G1 X78.992 Y76.388 E.00451
G1 X79.13 Y76.347 E.00283
G1 X79.359 Y76.313 E.00454
G1 X92.462 Y76.312 E.25774
G1 X92.653 Y76.331 E.00377
G1 X92.871 Y76.389 E.00444
G1 X93.075 Y76.484 E.00442
G1 X93.259 Y76.613 E.00442
G1 X93.418 Y76.772 E.00442
G1 X93.547 Y76.956 E.00442
G1 X93.642 Y77.16 E.00442
G1 X93.7 Y77.377 E.00442
G1 X93.721 Y77.61 E.0046
G1 X93.721 Y85.511 E.1554
G1 X95.59 Y85.511 E.03676
G1 F1870.275
G1 X95.72 Y85.511 E.00256
G1 F1320
G1 X95.72 Y87.691 E.04288
G1 F1668.612
G1 X95.59 Y87.691 E.00256
G1 F1500
G1 X93.721 Y87.691 E.03676
G1 X93.721 Y88.791 E.02164
G1 X92.541 Y88.791 E.02321
G1 X92.541 Y77.491 E.22226
G1 X79.912 Y77.491 E.24839
G1 X79.724 Y77.524 E.00376
G1 X79.565 Y77.61 E.00356
G1 X79.437 Y77.737 E.00355
G1 X79.345 Y77.922 E.00406
G1 X79.321 Y78.086 E.00325
G1 X79.321 Y95.119 E.33504
G1 X79.354 Y95.311 E.00382
G1 X79.464 Y95.501 E.00431
G1 X79.684 Y95.664 E.0054
G1 X79.909 Y95.711 E.00452
G1 X92.12 Y95.711 E.24018
G1 X92.162 Y95.304 E.00805
G1 X92.22 Y95.115 E.00389
G1 X92.318 Y94.937 E.004
G1 X92.43 Y94.803 E.00342
G1 X92.563 Y94.691 E.00344
G1 X92.731 Y94.596 E.00379
G1 X92.942 Y94.53 E.00434
G1 X93.114 Y94.512 E.00341
G1 X93.289 Y94.525 E.00345
G1 X93.459 Y94.568 E.00346
G1 X93.619 Y94.641 E.00346
G1 X93.764 Y94.741 E.00345
G1 X93.888 Y94.865 E.00346
G1 X93.989 Y95.009 E.00346
G1 X94.098 Y95.294 E.00599
G1 X94.119 Y95.513 E.00433
G1 X94.088 Y95.747 E.00466
G1 X94.023 Y95.926 E.00374
G1 X93.909 Y96.111 E.00427
G1 X93.704 Y96.307 E.0056
G1 X93.398 Y96.459 E.00671
G1 X93.256 Y96.592 E.00383
G1 X93.07 Y96.72 E.00444
G1 X92.868 Y96.814 E.00438
G1 X92.653 Y96.871 E.00438
G1 X92.421 Y96.891 E.00456
G1 X88.326 Y96.891 E.08055
G1 X88.934 Y97.59 E.01823
G1 X89.063 Y97.767 E.0043
G1 X89.296 Y98.159 E.00897
G1 X89.391 Y98.356 E.00431
G1 X89.551 Y98.78 E.00891
G1 X89.659 Y99.22 E.00891
G1 X89.713 Y99.661 E.00873
G1 X89.714 Y100.112 E.00887
G1 X89.638 Y100.675 E.01117
G1 X89.485 Y101.216 E.01107
G1 X89.404 Y101.418 E.00427
G1 X89.198 Y101.821 E.00891
G1 X88.945 Y102.197 E.00891
G1 X88.809 Y102.366 E.00427
G1 X88.405 Y102.769 E.01123
G1 X87.953 Y103.106 E.01108
G1 X87.766 Y103.216 E.00427
G1 X87.355 Y103.413 E.00897
G1 X87.15 Y103.489 E.0043
G1 X86.713 Y103.609 E.00891
G1 X86.265 Y103.676 E.00891
G1 X86.046 Y103.689 E.00431
G1 X85.593 Y103.676 E.00891
G1 X85.145 Y103.608 E.00891
G1 X84.929 Y103.556 E.00437
G1 X84.717 Y103.491 E.00436
G1 X84.298 Y103.321 E.00891
G1 X83.904 Y103.103 E.00885
G1 X83.539 Y102.84 E.00885
G1 X83.207 Y102.536 E.00885
G1 X82.914 Y102.195 E.00885
G1 X82.663 Y101.821 E.00885
G1 X82.46 Y101.422 E.00881
G1 X82.273 Y100.886 E.01117
G1 X82.166 Y100.336 E.01101
G1 X82.141 Y99.889 E.00882
G1 X82.169 Y99.44 E.00885
G1 X82.25 Y98.997 E.00885
G1 X82.383 Y98.567 E.00885
G1 X82.568 Y98.153 E.00891
G1 X82.674 Y97.962 E.0043
G1 X82.929 Y97.588 E.00891
G1 X83.496 Y96.936 E.01698
; WIPE_START
M204 S6000
G1 X81.496 Y96.914 E-.38
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




G1 X79.368 Y96.256
G1 Z2.96
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.153903
G1 F1500
M204 S6000
G1 X78.995 Y96.011 E.00285
G1 X78.94 Y95.951 E.00052
G1 X78.857 Y95.805 E.00107
; LINE_WIDTH: 0.12457
G1 X78.824 Y95.714 E.00048
; LINE_WIDTH: 0.0939464
G1 X78.792 Y95.622 E.00033
; WIPE_START
G1 X78.824 Y95.714 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X84.466 Y97.173 Z3.36 F18000
G1 Z2.96
G1 E.4 F1800
; LINE_WIDTH: 0.475782
G1 F1500
M204 S6000
G1 X84.239 Y97.362 E.00662
; LINE_WIDTH: 0.44439
G1 X84.109 Y97.482 E.00369
; LINE_WIDTH: 0.404378
G1 X83.961 Y97.621 E.00385
; LINE_WIDTH: 0.36083
G1 X83.616 Y97.995 E.00849
G1 X83.399 Y98.295 E.0062
G1 X83.221 Y98.626 E.00627
G1 X83.036 Y99.117 E.00878
G1 X82.945 Y99.624 E.00861
G1 X82.949 Y100.238 E.01026
G1 X83.04 Y100.679 E.00752
G1 X83.101 Y100.885 E.00359
G1 X83.344 Y101.421 E.00984
G1 X83.547 Y101.714 E.00595
G1 X83.778 Y101.984 E.00594
G1 X84.138 Y102.304 E.00806
G1 X84.602 Y102.59 E.00912
G1 X85.104 Y102.784 E.00899
G1 X85.615 Y102.882 E.0087
G1 X85.985 Y102.895 E.00619
G1 X86.36 Y102.867 E.00628
G1 X86.843 Y102.758 E.00829
G1 X87.345 Y102.545 E.00911
G1 X87.512 Y102.444 E.00326
G1 X87.889 Y102.172 E.00777
G1 X88.287 Y101.753 E.00965
G1 X88.514 Y101.419 E.00676
G1 X88.739 Y100.955 E.00862
G1 X88.864 Y100.513 E.00768
G1 X88.926 Y100.06 E.00765
G1 X88.905 Y99.519 E.00906
G1 X88.795 Y99.017 E.00859
G1 X88.599 Y98.53 E.00877
G1 X88.313 Y98.077 E.00896
G1 X87.867 Y97.588 E.01107
; LINE_WIDTH: 0.408655
G1 X87.709 Y97.45 E.004
; LINE_WIDTH: 0.443632
G1 X87.552 Y97.311 E.00437
; LINE_WIDTH: 0.478609
G1 X87.394 Y97.173 E.00473
; WIPE_START
G1 X87.552 Y97.311 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X92.701 Y96.141 Z3.36 F18000
G1 Z2.96
G1 E.4 F1800
; LINE_WIDTH: 0.11069
G1 F1500
M204 S6000
G1 X92.947 Y96 E.0012
; WIPE_START
G1 X92.701 Y96.141 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X93.406 Y88.541 Z3.36 F18000
G1 X93.586 Y86.601 Z3.36
G1 Z2.96
G1 E.4 F1800
; LINE_WIDTH: 0.114562
G1 F1500
M204 S6000
G1 X94.674 Y86.601 E.00482
; WIPE_START
G1 X93.586 Y86.601 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X87.278 Y82.304 Z3.36 F18000
M73 P67 R7
G1 X79.424 Y76.954 Z3.36
G1 Z2.96
G1 E.4 F1800
; LINE_WIDTH: 0.0926119
G1 F1500
M204 S6000
G1 X79.328 Y76.988 E.00034
; LINE_WIDTH: 0.130579
G1 X79.127 Y77.081 E.00116
; LINE_WIDTH: 0.156424
G1 X79.003 Y77.191 E.00108
G1 X78.877 Y77.344 E.00129
; LINE_WIDTH: 0.125852
G1 X78.82 Y77.482 E.00075
; LINE_WIDTH: 0.0973245
G1 X78.787 Y77.598 E.00043
; CHANGE_LAYER
; Z_HEIGHT: 3.08
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F1500
G1 X78.82 Y77.482 E-.38
; WIPE_END
G1 E-.02 F1800
; layer num/total_layer_count: 25/49
; update layer progress
M73 L25
M991 S0 P24 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z3.36 I-.583 J1.068 P1  F18000
G1 X95.058 Y86.344 Z3.36
G1 Z3.08
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X95.058 Y86.857 E.01086
G1 X93.374 Y86.857 E.03564
G1 X93.374 Y86.344 E.01086
G1 X94.998 Y86.344 E.03437
M204 S10000
G1 X95.482 Y85.92 F18000
G1 F1500
M204 S500
G1 X95.482 Y87.282 E.02882
G1 X93.311 Y87.282 E.04595
G1 X93.311 Y88.382 E.02328
G1 X92.95 Y88.382 E.00765
G1 X92.95 Y77.127 E.23821
G1 X93.128 Y77.071 E.00395
G1 X93.191 Y77.162 E.00234
G1 X93.256 Y77.3 E.00324
G1 X93.296 Y77.448 E.00324
G1 X93.311 Y77.628 E.00382
G1 X93.311 Y85.92 E.17551
G1 X95.422 Y85.92 E.04468
; WIPE_START
M204 S6000
G1 X95.482 Y87.282 E-.25894
G1 X94.845 Y87.282 E-.12106
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X93.403 Y94.777 Z3.48 F18000
G1 X93.275 Y95.442 Z3.48
G1 Z3.08
G1 E.4 F1800
G1 F1500
M204 S500
G1 X93.273 Y95.555 E.00239
G1 X93.235 Y95.617 E.00153
G1 X93.2 Y95.638 E.00086
G1 X92.955 Y95.742 E.00564
G1 X92.982 Y95.472 E.00574
G1 X93.02 Y95.39 E.0019
G1 X93.131 Y95.344 E.00254
G1 X93.181 Y95.357 E.00111
G1 X93.23 Y95.402 E.0014
; WIPE_START
M204 S6000
G1 X93.273 Y95.555 E-.05309
G1 X93.235 Y95.617 E-.02408
G1 X93.2 Y95.638 E-.0136
G1 X92.955 Y95.742 E-.08896
G1 X92.982 Y95.472 E-.09054
G1 X93.02 Y95.39 E-.03004
G1 X93.131 Y95.344 E-.04007
G1 X93.181 Y95.357 E-.01747
G1 X93.23 Y95.402 E-.02215
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X85.749 Y96.913 Z3.48 F18000
G1 X84.692 Y97.126 Z3.48
G1 Z3.08
G1 E.4 F1800
G1 F1500
M204 S500
G1 X84.577 Y96.963 E.00423
G1 X84.941 Y96.544 E.01174
G1 X86.92 Y96.544 E.04188
G1 X87.285 Y96.964 E.01176
G1 X87.165 Y97.128 E.00429
G1 X86.872 Y97.002 E.00675
G1 X86.346 Y96.882 E.01143
G1 X85.901 Y96.857 E.00942
G1 X85.591 Y96.874 E.00656
G1 X85.076 Y96.975 E.01112
G1 X84.748 Y97.104 E.00746
; WIPE_START
M204 S6000
G1 X84.577 Y96.963 E-.04213
G1 X84.941 Y96.544 E-.10542
G1 X86.165 Y96.544 E-.23245
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X84.857 Y102.281 Z3.48 F18000
G1 Z3.08
G1 E.4 F1800
G1 F1500
M204 S500
G1 X84.62 Y102.171 E.00554
G1 X84.235 Y101.901 E.00995
G1 X83.905 Y101.566 E.00995
G1 X83.641 Y101.178 E.00995
G1 X83.447 Y100.743 E.01006
G1 X83.329 Y100.218 E.0114
G1 X83.314 Y99.741 E.01011
G1 X83.401 Y99.208 E.01142
G1 X83.564 Y98.775 E.0098
G1 X83.687 Y98.549 E.00544
G1 X83.903 Y98.241 E.00797
G1 X84.12 Y98.007 E.00675
G1 X84.366 Y97.798 E.00683
G1 X84.758 Y97.556 E.00975
G1 X85.195 Y97.384 E.00995
G1 X85.644 Y97.296 E.00969
G1 X85.901 Y97.282 E.00543
G1 X86.286 Y97.304 E.00817
M73 P68 R7
G1 X86.741 Y97.407 E.00987
G1 X87.164 Y97.589 E.00975
G1 X87.439 Y97.758 E.00683
G1 X87.691 Y97.959 E.00683
G1 X88.002 Y98.294 E.00967
G1 X88.213 Y98.616 E.00815
G1 X88.33 Y98.846 E.00546
G1 X88.478 Y99.279 E.00968
G1 X88.548 Y99.744 E.00995
G1 X88.534 Y100.214 E.00995
G1 X88.438 Y100.664 E.00975
G1 X88.324 Y100.967 E.00683
G1 X88.176 Y101.253 E.00683
G1 X87.907 Y101.623 E.00968
G1 X87.617 Y101.906 E.00858
G1 X87.178 Y102.207 E.01127
G1 X86.749 Y102.391 E.00987
G1 X86.437 Y102.472 E.00683
G1 X86.117 Y102.515 E.00683
G1 X85.669 Y102.508 E.00949
G1 X85.415 Y102.469 E.00544
G1 X85.043 Y102.367 E.00817
G1 X84.912 Y102.307 E.00306
M204 S250
G1 X85.029 Y101.91 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X84.825 Y101.816 E.00442
G1 X84.501 Y101.587 E.0078
G1 X84.223 Y101.305 E.0078
G1 X84 Y100.977 E.0078
G1 X83.838 Y100.614 E.00783
G1 X83.737 Y100.167 E.00902
G1 X83.725 Y99.768 E.00785
G1 X83.799 Y99.314 E.00904
G1 X83.937 Y98.946 E.00775
G1 X84.035 Y98.765 E.00404
G1 X84.222 Y98.498 E.0064
G1 X84.403 Y98.303 E.00524
G1 X84.607 Y98.13 E.00526
G1 X84.942 Y97.924 E.00773
G1 X85.311 Y97.779 E.0078
G1 X85.695 Y97.703 E.00771
G1 X85.9 Y97.692 E.00404
G1 X86.228 Y97.71 E.00646
G1 X86.614 Y97.798 E.00777
G1 X86.975 Y97.953 E.00774
G1 X87.203 Y98.093 E.00526
G1 X87.412 Y98.26 E.00526
G1 X87.679 Y98.548 E.00771
G1 X87.858 Y98.822 E.00645
G1 X87.952 Y99.006 E.00406
G1 X88.078 Y99.377 E.00771
G1 X88.137 Y99.769 E.0078
G1 X88.126 Y100.165 E.0078
G1 X88.044 Y100.549 E.00773
G1 X87.95 Y100.8 E.00526
G1 X87.827 Y101.037 E.00526
G1 X87.596 Y101.354 E.00771
G1 X87.357 Y101.589 E.00659
G1 X86.98 Y101.847 E.00898
G1 X86.617 Y102.002 E.00777
G1 X86.358 Y102.07 E.00526
G1 X86.093 Y102.106 E.00526
G1 X85.704 Y102.1 E.00765
G1 X85.501 Y102.068 E.00404
G1 X85.184 Y101.982 E.00646
G1 X85.084 Y101.935 E.00217
; WIPE_START
M204 S6000
G1 X84.825 Y101.816 E-.05412
G1 X84.501 Y101.587 E-.07532
G1 X84.223 Y101.305 E-.07531
G1 X84 Y100.977 E-.07531
G1 X83.838 Y100.614 E-.07562
G1 X83.809 Y100.489 E-.02432
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X84.691 Y96.12 Z3.48 F18000
G1 Z3.08
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X92.49 Y96.12 E.16507
G1 X92.565 Y95.387 E.0156
G1 X92.599 Y95.275 E.00249
G1 X92.658 Y95.169 E.00256
G1 X92.797 Y95.029 E.00418
G1 X92.896 Y94.974 E.0024
G1 X93.025 Y94.933 E.00286
G1 X93.223 Y94.93 E.00419
G1 X93.323 Y94.955 E.00218
G1 X93.501 Y95.056 E.00433
G1 X93.573 Y95.129 E.00217
G1 X93.632 Y95.213 E.00217
G1 X93.694 Y95.37 E.00358
G1 X93.707 Y95.505 E.00287
G1 X93.688 Y95.649 E.00308
G1 X93.653 Y95.747 E.00221
G1 X93.531 Y95.919 E.00445
G1 X93.393 Y96.017 E.00358
G1 X93.172 Y96.11 E.00508
G1 X92.999 Y96.272 E.00503
G1 X92.866 Y96.364 E.0034
G1 X92.728 Y96.427 E.00322
G1 X92.582 Y96.466 E.00321
G1 X92.404 Y96.482 E.00378
G1 X87.428 Y96.482 E.10532
G1 X88.614 Y97.845 E.03824
G1 X88.72 Y97.992 E.00385
G1 X88.936 Y98.353 E.00888
G1 X89.159 Y98.901 E.01254
G1 X89.286 Y99.49 E.01273
G1 X89.305 Y100.085 E.01261
G1 X89.238 Y100.586 E.01071
G1 X89.099 Y101.078 E.01081
G1 X88.846 Y101.611 E.01248
G1 X88.501 Y102.096 E.0126
G1 X88.213 Y102.393 E.00875
G1 X87.985 Y102.583 E.00629
G1 X87.738 Y102.757 E.00639
G1 X87.477 Y102.905 E.00635
G1 X87.024 Y103.099 E.01043
G1 X86.628 Y103.208 E.00869
G1 X86.222 Y103.269 E.00868
G1 X85.63 Y103.267 E.01254
G1 X85.038 Y103.161 E.01274
G1 X84.474 Y102.951 E.01272
G1 X84.123 Y102.757 E.0085
G1 X83.797 Y102.522 E.00849
G1 X83.502 Y102.251 E.00849
G1 X83.24 Y101.947 E.00849
G1 X83.017 Y101.613 E.0085
G1 X82.834 Y101.256 E.00849
G1 X82.696 Y100.879 E.00849
G1 X82.604 Y100.494 E.00838
G1 X82.554 Y99.991 E.01071
G1 X82.577 Y99.484 E.01074
G1 X82.648 Y99.095 E.00838
G1 X82.767 Y98.712 E.00849
G1 X82.93 Y98.345 E.00849
G1 X83.248 Y97.845 E.01254
G1 X84.433 Y96.482 E.03824
G1 X79.467 Y96.482 E.10512
G1 X79.135 Y96.429 E.00711
G1 X78.901 Y96.303 E.00562
G1 X78.72 Y96.119 E.00547
G1 X78.669 Y96.041 E.00197
G1 X78.579 Y95.812 E.0052
G1 X78.55 Y95.565 E.00527
G1 X78.55 Y77.628 E.37965
G1 X78.588 Y77.349 E.00597
G1 X78.697 Y77.118 E.00539
G1 X78.885 Y76.912 E.00592
G1 X79.133 Y76.774 E.00601
G1 X79.385 Y76.723 E.00543
G1 X92.444 Y76.721 E.2764
G1 X92.58 Y76.735 E.00289
G1 X92.731 Y76.775 E.00332
G1 X92.96 Y76.904 E.00556
G1 X92.904 Y77.082 E.00395
G1 X79.876 Y77.082 E.27575
G1 X79.588 Y77.133 E.0062
G1 X79.313 Y77.28 E.0066
G1 X79.089 Y77.512 E.00682
G1 X78.949 Y77.802 E.00682
G1 X78.911 Y78.056 E.00544
G1 X78.911 Y95.155 E.36192
G1 X78.964 Y95.453 E.0064
G1 X79.152 Y95.779 E.00796
G1 X79.513 Y96.047 E.00951
G1 X79.867 Y96.12 E.00767
G1 X84.631 Y96.12 E.10083
; WIPE_START
M204 S6000
G1 X86.631 Y96.12 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X83.535 Y96.891 Z3.48 F18000
G1 Z3.08
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X79.443 Y96.891 E.08049
G1 X79.127 Y96.854 E.00625
G1 X78.819 Y96.735 E.0065
G1 X78.548 Y96.541 E.00655
G1 X78.394 Y96.369 E.00454
G1 X78.314 Y96.246 E.00289
G1 X78.248 Y96.114 E.00289
G1 X78.177 Y95.901 E.00442
G1 X78.141 Y95.589 E.00619
G1 X78.141 Y77.61 E.35362
G1 X78.161 Y77.374 E.00466
G1 X78.195 Y77.231 E.00289
G1 X78.245 Y77.093 E.00289
G1 X78.353 Y76.893 E.00448
G1 X78.494 Y76.715 E.00445
G1 X78.631 Y76.59 E.00366
G1 X78.785 Y76.485 E.00367
G1 X78.991 Y76.389 E.00447
G1 X79.17 Y76.339 E.00365
G1 X79.357 Y76.313 E.00373
G1 X92.464 Y76.312 E.2578
G1 X92.653 Y76.331 E.00374
G1 X92.871 Y76.389 E.00444
G1 X93.075 Y76.484 E.00442
G1 X93.259 Y76.613 E.00442
G1 X93.418 Y76.772 E.00442
G1 X93.547 Y76.956 E.00442
G1 X93.642 Y77.16 E.00442
G1 X93.7 Y77.377 E.00442
G1 X93.721 Y77.61 E.0046
G1 X93.721 Y85.511 E.1554
G1 X95.761 Y85.511 E.04013
G1 F1870.275
G1 X95.891 Y85.511 E.00256
G1 F1320
G1 X95.891 Y87.691 E.04288
G1 F1668.612
G1 X95.761 Y87.691 E.00256
G1 F1500
G1 X93.721 Y87.691 E.04013
G1 X93.721 Y88.791 E.02164
G1 X92.541 Y88.791 E.02321
G1 X92.541 Y77.491 E.22226
G1 X79.912 Y77.491 E.24839
G1 X79.724 Y77.524 E.00376
G1 X79.563 Y77.611 E.00359
G1 X79.429 Y77.75 E.00381
G1 X79.344 Y77.924 E.0038
G1 X79.321 Y78.086 E.00322
G1 X79.321 Y95.119 E.33504
G1 X79.354 Y95.311 E.00383
G1 X79.464 Y95.501 E.00431
G1 X79.684 Y95.664 E.00539
G1 X79.909 Y95.711 E.00452
G1 X92.12 Y95.711 E.24018
G1 X92.161 Y95.305 E.00802
G1 X92.221 Y95.114 E.00394
G1 X92.318 Y94.937 E.00397
G1 X92.429 Y94.803 E.00343
G1 X92.563 Y94.691 E.00344
G1 X92.733 Y94.596 E.00382
G1 X92.941 Y94.53 E.00429
G1 X93.113 Y94.512 E.00341
G1 X93.288 Y94.524 E.00345
G1 X93.459 Y94.568 E.00346
G1 X93.619 Y94.641 E.00345
G1 X93.763 Y94.741 E.00346
G1 X93.888 Y94.864 E.00345
G1 X93.988 Y95.008 E.00346
G1 X94.098 Y95.294 E.00602
G1 X94.119 Y95.512 E.00431
G1 X94.088 Y95.747 E.00466
G1 X94.023 Y95.927 E.00376
G1 X93.91 Y96.11 E.00425
G1 X93.704 Y96.307 E.0056
G1 X93.398 Y96.459 E.00671
G1 X93.256 Y96.592 E.00383
G1 X93.07 Y96.72 E.00444
G1 X92.868 Y96.814 E.00438
G1 X92.653 Y96.871 E.00438
G1 X92.421 Y96.891 E.00456
G1 X88.326 Y96.891 E.08055
G1 X88.934 Y97.59 E.01823
G1 X89.063 Y97.767 E.0043
G1 X89.296 Y98.159 E.00897
G1 X89.391 Y98.356 E.00431
G1 X89.551 Y98.78 E.00891
G1 X89.659 Y99.22 E.00891
G1 X89.713 Y99.661 E.00873
G1 X89.714 Y100.112 E.00887
G1 X89.639 Y100.67 E.01108
G1 X89.485 Y101.214 E.01113
G1 X89.355 Y101.521 E.00657
G1 X89.198 Y101.82 E.00663
G1 X88.945 Y102.197 E.00893
G1 X88.808 Y102.368 E.0043
G1 X88.492 Y102.694 E.00893
G1 X88.234 Y102.908 E.0066
G1 X87.957 Y103.103 E.00665
G1 X87.664 Y103.269 E.00662
G1 X87.15 Y103.489 E.01101
G1 X86.713 Y103.609 E.00891
G1 X86.265 Y103.676 E.00891
G1 X86.046 Y103.689 E.00431
G1 X85.593 Y103.676 E.00891
G1 X85.145 Y103.608 E.00891
G1 X84.717 Y103.491 E.00873
G1 X84.298 Y103.321 E.00891
G1 X83.904 Y103.103 E.00885
G1 X83.539 Y102.84 E.00885
G1 X83.207 Y102.536 E.00885
G1 X82.914 Y102.195 E.00885
G1 X82.663 Y101.821 E.00885
G1 X82.459 Y101.42 E.00885
G1 X82.303 Y100.998 E.00885
G1 X82.199 Y100.562 E.00882
G1 X82.144 Y100.002 E.01107
G1 X82.169 Y99.438 E.01111
G1 X82.25 Y98.997 E.00881
G1 X82.383 Y98.567 E.00885
G1 X82.566 Y98.156 E.00885
G1 X82.798 Y97.767 E.00891
G1 X82.927 Y97.59 E.00431
G1 X83.496 Y96.936 E.01704
; WIPE_START
M204 S6000
G1 X81.496 Y96.914 E-.38
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




G1 X79.348 Y96.253
G1 Z3.08
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.148788
G1 F1500
M204 S6000
G1 X79.028 Y96.039 E.00237
G1 X78.954 Y95.971 E.00061
G1 X78.879 Y95.851 E.00087
G1 X78.778 Y95.627 E.00151
; WIPE_START
G1 X78.879 Y95.851 E-.10703
G1 X78.954 Y95.971 E-.06177
G1 X79.028 Y96.039 E-.04343
G1 X79.348 Y96.253 E-.16777
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X84.466 Y97.174 Z3.48 F18000
G1 Z3.08
G1 E.4 F1800
; LINE_WIDTH: 0.474028
G1 F1500
M204 S6000
G1 X84.301 Y97.314 E.00485
; LINE_WIDTH: 0.441537
G1 X84.113 Y97.475 E.00513
; LINE_WIDTH: 0.408502
G1 X83.988 Y97.599 E.00336
; LINE_WIDTH: 0.360431
G1 X83.602 Y98.012 E.00944
G1 X83.364 Y98.36 E.00703
G1 X83.217 Y98.629 E.00512
G1 X83.033 Y99.127 E.00887
G1 X82.96 Y99.528 E.0068
G1 X82.938 Y99.981 E.00758
G1 X82.983 Y100.431 E.00755
G1 X83.085 Y100.847 E.00715
G1 X83.304 Y101.348 E.00914
G1 X83.545 Y101.715 E.00733
G1 X83.778 Y101.984 E.00594
G1 X84.038 Y102.227 E.00594
G1 X84.444 Y102.504 E.00822
G1 X84.902 Y102.713 E.0084
G1 X85.139 Y102.791 E.00416
G1 X85.664 Y102.888 E.00891
G1 X86.152 Y102.892 E.00816
G1 X86.55 Y102.835 E.0067
G1 X86.903 Y102.738 E.00612
G1 X87.374 Y102.53 E.00859
G1 X87.846 Y102.208 E.00955
G1 X88.203 Y101.86 E.00832
G1 X88.504 Y101.441 E.00861
G1 X88.67 Y101.11 E.00619
G1 X88.8 Y100.758 E.00627
G1 X88.907 Y100.244 E.00876
G1 X88.925 Y99.706 E.00898
G1 X88.846 Y99.204 E.00849
G1 X88.679 Y98.711 E.00869
G1 X88.543 Y98.436 E.00513
G1 X88.309 Y98.072 E.00723
G1 X87.945 Y97.666 E.00909
; LINE_WIDTH: 0.392108
G1 X87.818 Y97.544 E.00322
; LINE_WIDTH: 0.426485
G1 X87.672 Y97.406 E.00403
; LINE_WIDTH: 0.465855
G1 X87.396 Y97.171 E.00794
; WIPE_START
G1 X87.672 Y97.406 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X92.701 Y96.14 Z3.48 F18000
G1 Z3.08
G1 E.4 F1800
; LINE_WIDTH: 0.110861
G1 F1500
M204 S6000
G1 X92.947 Y96 E.0012
; WIPE_START
G1 X92.701 Y96.14 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X93.406 Y88.54 Z3.48 F18000
G1 X93.586 Y86.601 Z3.48
G1 Z3.08
G1 E.4 F1800
; LINE_WIDTH: 0.114562
G1 F1500
M204 S6000
G1 X94.846 Y86.601 E.00558
; WIPE_START
G1 X93.586 Y86.601 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X87.279 Y82.303 Z3.48 F18000
G1 X79.426 Y76.953 Z3.48
G1 Z3.08
G1 E.4 F1800
; LINE_WIDTH: 0.0922722
G1 F1500
M204 S6000
G1 X79.325 Y76.99 E.00036
; LINE_WIDTH: 0.130044
G1 X79.126 Y77.08 E.00114
; LINE_WIDTH: 0.154458
M73 P69 R7
G1 X79.004 Y77.19 E.00106
G1 X78.863 Y77.371 E.00147
; LINE_WIDTH: 0.122958
G1 X78.819 Y77.482 E.00058
; LINE_WIDTH: 0.0965599
G1 X78.788 Y77.597 E.00042
; CHANGE_LAYER
; Z_HEIGHT: 3.2
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F1500
G1 X78.819 Y77.482 E-.38
; WIPE_END
G1 E-.02 F1800
; layer num/total_layer_count: 26/49
; update layer progress
M73 L26
M991 S0 P25 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z3.48 I-.578 J1.071 P1  F18000
G1 X95.229 Y86.344 Z3.48
G1 Z3.2
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X95.229 Y86.857 E.01086
G1 X93.374 Y86.857 E.03927
G1 X93.374 Y86.344 E.01086
G1 X95.169 Y86.344 E.038
M204 S10000
G1 X95.654 Y85.92 F18000
G1 F1500
M204 S500
G1 X95.654 Y87.282 E.02882
G1 X93.311 Y87.282 E.04957
G1 X93.311 Y88.382 E.02328
G1 X92.95 Y88.382 E.00765
G1 X92.95 Y77.127 E.23821
G1 X93.128 Y77.071 E.00395
G1 X93.191 Y77.162 E.00234
G1 X93.256 Y77.3 E.00324
G1 X93.296 Y77.448 E.00324
G1 X93.311 Y77.628 E.00381
G1 X93.311 Y85.92 E.17551
G1 X95.594 Y85.92 E.0483
; WIPE_START
M204 S6000
G1 X95.654 Y87.282 E-.25894
G1 X95.016 Y87.282 E-.12106
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X93.424 Y94.746 Z3.6 F18000
G1 X93.275 Y95.443 Z3.6
G1 Z3.2
G1 E.4 F1800
G1 F1500
M204 S500
G1 X93.273 Y95.555 E.00239
G1 X93.235 Y95.617 E.00153
G1 X93.199 Y95.638 E.00088
G1 X92.955 Y95.742 E.00561
G1 X92.982 Y95.473 E.00572
G1 X93.02 Y95.391 E.00191
G1 X93.131 Y95.345 E.00255
G1 X93.181 Y95.357 E.00109
G1 X93.231 Y95.402 E.00142
; WIPE_START
M204 S6000
G1 X93.273 Y95.555 E-.05308
G1 X93.235 Y95.617 E-.02412
G1 X93.199 Y95.638 E-.01392
G1 X92.955 Y95.742 E-.08856
G1 X92.982 Y95.473 E-.09025
G1 X93.02 Y95.391 E-.03019
G1 X93.131 Y95.345 E-.04031
G1 X93.181 Y95.357 E-.01721
G1 X93.231 Y95.402 E-.02236
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X85.749 Y96.913 Z3.6 F18000
G1 X84.704 Y97.124 Z3.6
G1 Z3.2
G1 E.4 F1800
G1 F1500
M204 S500
G1 X84.581 Y96.959 E.00436
G1 X84.942 Y96.544 E.01163
G1 X86.92 Y96.544 E.04187
G1 X87.279 Y96.958 E.0116
G1 X87.168 Y97.12 E.00416
G1 X86.697 Y96.951 E.01059
G1 X86.158 Y96.862 E.01156
G1 X85.628 Y96.87 E.01123
G1 X85.253 Y96.932 E.00805
G1 X84.888 Y97.038 E.00804
G1 X84.759 Y97.098 E.00302
; WIPE_START
M204 S6000
G1 X84.581 Y96.959 E-.04297
G1 X84.942 Y96.544 E-.10441
G1 X86.166 Y96.544 E-.23262
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X84.883 Y102.295 Z3.6 F18000
G1 Z3.2
G1 E.4 F1800
G1 F1500
M204 S500
G1 X84.758 Y102.246 E.00284
G1 X84.358 Y101.999 E.00995
G1 X84.016 Y101.69 E.00975
G1 X83.811 Y101.441 E.00683
G1 X83.637 Y101.169 E.00683
G1 X83.45 Y100.748 E.00975
G1 X83.338 Y100.292 E.00995
G1 X83.311 Y99.832 E.00975
G1 X83.34 Y99.51 E.00683
G1 X83.407 Y99.195 E.00683
G1 X83.568 Y98.763 E.00975
G1 X83.812 Y98.355 E.01006
G1 X84.174 Y97.955 E.01143
G1 X84.615 Y97.633 E.01155
G1 X85.038 Y97.437 E.00987
G1 X85.347 Y97.346 E.00683
G1 X85.666 Y97.293 E.00684
G1 X86.127 Y97.286 E.00975
G1 X86.59 Y97.363 E.00995
G1 X87.029 Y97.521 E.00987
G1 X87.363 Y97.708 E.00809
G1 X87.574 Y97.86 E.00551
G1 X87.909 Y98.179 E.0098
G1 X88.219 Y98.621 E.01143
G1 X88.435 Y99.123 E.01156
G1 X88.534 Y99.588 E.01006
G1 X88.548 Y100.058 E.00995
G1 X88.478 Y100.519 E.00987
G1 X88.357 Y100.888 E.00822
G1 X88.251 Y101.119 E.00539
G1 X88.005 Y101.505 E.00968
G1 X87.691 Y101.842 E.00975
G1 X87.439 Y102.044 E.00683
G1 X87.165 Y102.213 E.00682
G1 X86.741 Y102.394 E.00975
G1 X86.292 Y102.497 E.00975
G1 X85.97 Y102.521 E.00683
G1 X85.648 Y102.506 E.00683
G1 X85.195 Y102.417 E.00975
G1 X84.939 Y102.317 E.00584
M204 S250
G1 X85.032 Y101.914 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X84.942 Y101.878 E.00192
G1 X84.604 Y101.67 E.0078
G1 X84.312 Y101.407 E.00773
G1 X84.142 Y101.2 E.00526
G1 X83.998 Y100.975 E.00526
G1 X83.838 Y100.615 E.00773
G1 X83.744 Y100.23 E.0078
G1 X83.721 Y99.838 E.00774
G1 X83.745 Y99.571 E.00526
G1 X83.801 Y99.31 E.00526
G1 X83.939 Y98.942 E.00773
G1 X84.143 Y98.6 E.00783
G1 X84.449 Y98.26 E.009
G1 X84.823 Y97.987 E.00911
G1 X85.182 Y97.821 E.00777
G1 X85.439 Y97.746 E.00526
G1 X85.703 Y97.702 E.00527
G1 X86.096 Y97.696 E.00773
G1 X86.487 Y97.761 E.0078
G1 X86.859 Y97.894 E.00777
G1 X87.142 Y98.054 E.0064
G1 X87.312 Y98.175 E.0041
G1 X87.597 Y98.447 E.00775
G1 X87.86 Y98.822 E.009
G1 X88.043 Y99.247 E.00911
G1 X88.126 Y99.637 E.00783
G1 X88.137 Y100.033 E.0078
G1 X88.079 Y100.424 E.00777
G1 X87.975 Y100.738 E.00651
G1 X87.891 Y100.923 E.00399
G1 X87.679 Y101.253 E.00771
G1 X87.412 Y101.541 E.00773
G1 X87.203 Y101.708 E.00526
G1 X86.975 Y101.849 E.00526
G1 X86.614 Y102.004 E.00774
G1 X86.23 Y102.091 E.00774
G1 X85.964 Y102.111 E.00526
G1 X85.697 Y102.099 E.00526
G1 X85.311 Y102.023 E.00774
G1 X85.088 Y101.936 E.0047
; WIPE_START
M204 S6000
G1 X84.942 Y101.878 E-.02992
G1 X84.604 Y101.67 E-.07532
G1 X84.312 Y101.407 E-.0747
G1 X84.142 Y101.2 E-.0508
G1 X83.998 Y100.975 E-.05085
G1 X83.838 Y100.615 E-.07471
G1 X83.809 Y100.494 E-.0237
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X84.692 Y96.12 Z3.6 F18000
G1 Z3.2
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X92.49 Y96.12 E.16506
G1 X92.564 Y95.388 E.01558
G1 X92.6 Y95.274 E.00252
G1 X92.657 Y95.169 E.00253
G1 X92.796 Y95.029 E.00418
G1 X92.897 Y94.973 E.00245
G1 X93.024 Y94.933 E.00282
G1 X93.223 Y94.93 E.0042
G1 X93.322 Y94.955 E.00218
G1 X93.416 Y94.998 E.00217
G1 X93.573 Y95.129 E.00433
G1 X93.632 Y95.213 E.00217
G1 X93.694 Y95.372 E.00362
G1 X93.707 Y95.505 E.00282
G1 X93.688 Y95.649 E.00308
G1 X93.652 Y95.749 E.00225
G1 X93.53 Y95.92 E.00444
G1 X93.392 Y96.017 E.00358
G1 X93.172 Y96.11 E.00505
G1 X92.999 Y96.272 E.00503
G1 X92.866 Y96.364 E.0034
G1 X92.728 Y96.427 E.00322
G1 X92.582 Y96.466 E.00321
G1 X92.404 Y96.482 E.00378
G1 X87.427 Y96.482 E.10533
G1 X88.608 Y97.838 E.03805
G1 X88.931 Y98.345 E.01273
G1 X89.159 Y98.901 E.01273
G1 X89.286 Y99.489 E.01273
G1 X89.305 Y100.085 E.01261
G1 X89.239 Y100.582 E.01061
G1 X89.097 Y101.084 E.01103
G1 X88.847 Y101.609 E.0123
G1 X88.56 Y102.02 E.01062
G1 X88.209 Y102.397 E.0109
G1 X87.988 Y102.581 E.00607
G1 X87.573 Y102.855 E.01053
G1 X87.203 Y103.032 E.00869
G1 X86.814 Y103.164 E.00869
G1 X86.222 Y103.269 E.01273
G1 X85.63 Y103.267 E.01254
G1 X85.038 Y103.161 E.01273
G1 X84.474 Y102.951 E.01273
G1 X84.123 Y102.757 E.0085
G1 X83.797 Y102.522 E.00849
G1 X83.502 Y102.251 E.00849
G1 X83.24 Y101.947 E.00849
G1 X83.02 Y101.618 E.00838
G1 X82.8 Y101.167 E.01061
G1 X82.644 Y100.685 E.01072
G1 X82.566 Y100.196 E.01049
G1 X82.558 Y99.684 E.01084
G1 X82.606 Y99.291 E.00837
G1 X82.702 Y98.901 E.00849
G1 X82.843 Y98.526 E.00849
G1 X83.028 Y98.17 E.0085
G1 X83.254 Y97.838 E.00849
G1 X84.434 Y96.482 E.03805
G1 X79.467 Y96.482 E.10513
G1 X79.135 Y96.429 E.0071
G1 X78.901 Y96.303 E.00562
G1 X78.763 Y96.173 E.00402
G1 X78.665 Y96.033 E.00362
G1 X78.579 Y95.812 E.00501
G1 X78.55 Y95.565 E.00527
G1 X78.55 Y77.628 E.37965
G1 X78.588 Y77.348 E.00597
G1 X78.697 Y77.118 E.00539
G1 X78.884 Y76.913 E.00589
G1 X79.134 Y76.774 E.00604
G1 X79.385 Y76.723 E.00543
G1 X92.445 Y76.721 E.27643
G1 X92.579 Y76.735 E.00285
G1 X92.731 Y76.775 E.00332
G1 X92.96 Y76.904 E.00557
G1 X92.904 Y77.082 E.00395
G1 X79.88 Y77.082 E.27566
G1 X79.607 Y77.126 E.00587
G1 X79.317 Y77.277 E.00691
G1 X79.089 Y77.513 E.00694
G1 X78.949 Y77.802 E.0068
G1 X78.911 Y78.056 E.00543
G1 X78.911 Y95.155 E.36192
G1 X78.964 Y95.453 E.00639
G1 X79.152 Y95.778 E.00796
G1 X79.512 Y96.047 E.00952
G1 X79.867 Y96.12 E.00767
G1 X84.632 Y96.12 E.10084
; WIPE_START
M204 S6000
G1 X86.632 Y96.12 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X83.535 Y96.891 Z3.6 F18000
G1 Z3.2
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X79.443 Y96.891 E.08049
G1 X79.127 Y96.854 E.00625
G1 X78.817 Y96.734 E.00654
G1 X78.546 Y96.539 E.00658
G1 X78.445 Y96.432 E.00289
G1 X78.312 Y96.243 E.00454
G1 X78.248 Y96.114 E.00283
G1 X78.177 Y95.901 E.00442
G1 X78.141 Y95.589 E.00619
G1 X78.141 Y77.61 E.35362
G1 X78.161 Y77.374 E.00466
G1 X78.195 Y77.231 E.00289
G1 X78.245 Y77.093 E.00289
G1 X78.353 Y76.893 E.00448
G1 X78.494 Y76.715 E.00445
G1 X78.63 Y76.591 E.00362
G1 X78.785 Y76.485 E.0037
G1 X78.991 Y76.389 E.00447
G1 X79.168 Y76.339 E.00362
G1 X79.357 Y76.313 E.00376
G1 X92.466 Y76.312 E.25783
G1 X92.653 Y76.331 E.00371
G1 X92.871 Y76.389 E.00444
G1 X93.075 Y76.484 E.00442
G1 X93.259 Y76.613 E.00442
G1 X93.418 Y76.772 E.00442
G1 X93.547 Y76.956 E.00442
G1 X93.642 Y77.16 E.00442
G1 X93.7 Y77.377 E.00442
G1 X93.721 Y77.61 E.0046
G1 X93.721 Y85.511 E.1554
G1 X95.932 Y85.511 E.0435
G1 F1688.638
G1 X96.001 Y85.511 E.00134
G1 F1800
G1 X96.063 Y85.464 E.00153
G1 F1320
G1 X96.063 Y87.738 E.04471
G1 F1800
G1 X96.001 Y87.691 E.00153
G1 F2006.11
G1 X95.932 Y87.691 E.00134
G1 F1500
G1 X93.721 Y87.691 E.0435
G1 X93.721 Y88.791 E.02164
G1 X92.541 Y88.791 E.02321
G1 X92.541 Y77.491 E.22226
G1 X79.914 Y77.491 E.24836
G1 X79.737 Y77.52 E.00351
G1 X79.565 Y77.609 E.00383
G1 X79.428 Y77.75 E.00385
G1 X79.344 Y77.924 E.00379
G1 X79.321 Y78.086 E.00322
G1 X79.321 Y95.119 E.33504
G1 X79.354 Y95.311 E.00382
G1 X79.464 Y95.5 E.00431
G1 X79.684 Y95.664 E.0054
G1 X79.909 Y95.711 E.00452
G1 X92.12 Y95.711 E.24018
G1 X92.161 Y95.306 E.008
G1 X92.221 Y95.113 E.00397
G1 X92.318 Y94.938 E.00394
G1 X92.429 Y94.803 E.00343
G1 X92.563 Y94.691 E.00343
G1 X92.734 Y94.595 E.00387
G1 X92.94 Y94.53 E.00425
G1 X93.113 Y94.512 E.00342
G1 X93.288 Y94.524 E.00345
G1 X93.458 Y94.568 E.00346
G1 X93.618 Y94.64 E.00345
G1 X93.763 Y94.74 E.00346
G1 X93.887 Y94.864 E.00345
G1 X93.988 Y95.008 E.00345
G1 X94.063 Y95.169 E.00349
G1 X94.098 Y95.296 E.0026
G1 X94.119 Y95.512 E.00425
G1 X94.088 Y95.747 E.00466
G1 X94.022 Y95.928 E.0038
G1 X93.91 Y96.11 E.00421
G1 X93.814 Y96.216 E.00281
G1 X93.578 Y96.383 E.00568
G1 X93.398 Y96.459 E.00385
G1 X93.256 Y96.592 E.00383
G1 X93.07 Y96.72 E.00444
G1 X92.868 Y96.814 E.00439
G1 X92.652 Y96.871 E.00438
G1 X92.421 Y96.891 E.00456
G1 X88.326 Y96.891 E.08055
G1 X88.932 Y97.588 E.01817
G1 X89.187 Y97.962 E.00891
G1 X89.391 Y98.356 E.00873
G1 X89.551 Y98.78 E.00891
G1 X89.659 Y99.22 E.00891
G1 X89.692 Y99.44 E.00437
G1 X89.713 Y99.661 E.00437
G1 X89.714 Y100.112 E.00887
G1 X89.64 Y100.665 E.01099
G1 X89.485 Y101.216 E.01126
G1 X89.404 Y101.418 E.00427
G1 X89.199 Y101.819 E.00887
G1 X88.88 Y102.278 E.01099
G1 X88.491 Y102.695 E.01122
G1 X88.237 Y102.906 E.00647
G1 X87.766 Y103.216 E.0111
G1 X87.358 Y103.412 E.00891
G1 X86.928 Y103.557 E.00891
G1 X86.716 Y103.608 E.00431
G1 X86.265 Y103.676 E.00897
G1 X86.046 Y103.689 E.00431
G1 X85.593 Y103.676 E.00891
G1 X85.145 Y103.608 E.00891
G1 X84.93 Y103.556 E.00437
G1 X84.717 Y103.491 E.00436
G1 X84.298 Y103.321 E.00891
G1 X83.904 Y103.103 E.00885
G1 X83.539 Y102.84 E.00885
G1 X83.207 Y102.536 E.00885
G1 X82.914 Y102.195 E.00885
G1 X82.664 Y101.823 E.00882
G1 X82.419 Y101.321 E.01098
G1 X82.245 Y100.781 E.01116
G1 X82.157 Y100.231 E.01095
G1 X82.149 Y99.662 E.0112
G1 X82.203 Y99.217 E.00881
G1 X82.31 Y98.78 E.00885
G1 X82.469 Y98.359 E.00885
M73 P70 R7
G1 X82.676 Y97.96 E.00885
G1 X82.929 Y97.588 E.00885
G1 X83.496 Y96.936 E.01698
; WIPE_START
M204 S6000
G1 X81.496 Y96.914 E-.38
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




G1 X79.369 Y96.256
G1 Z3.2
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.148773
G1 F1500
M204 S6000
G1 X79.148 Y96.126 E.00158
G1 X78.956 Y95.967 E.00153
G1 X78.878 Y95.848 E.00087
G1 X78.778 Y95.626 E.00149
; WIPE_START
G1 X78.878 Y95.848 E-.10372
G1 X78.956 Y95.967 E-.06066
G1 X79.148 Y96.126 E-.10617
G1 X79.369 Y96.256 E-.10944
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X84.466 Y97.16 Z3.6 F18000
G1 Z3.2
G1 E.4 F1800
; LINE_WIDTH: 0.47016
G1 F1500
M204 S6000
G1 X84.287 Y97.325 E.00541
; LINE_WIDTH: 0.433053
G1 X84.107 Y97.49 E.00495
; LINE_WIDTH: 0.39329
G1 X83.902 Y97.68 E.00513
; LINE_WIDTH: 0.359259
G1 X83.556 Y98.071 E.00869
G1 X83.358 Y98.367 E.00592
G1 X83.192 Y98.681 E.00592
G1 X83.041 Y99.101 E.00742
G1 X82.968 Y99.444 E.00585
G1 X82.935 Y99.838 E.00658
G1 X82.971 Y100.362 E.00873
G1 X83.1 Y100.883 E.00894
G1 X83.311 Y101.358 E.00865
G1 X83.511 Y101.671 E.00618
G1 X83.776 Y101.986 E.00684
G1 X84.12 Y102.291 E.00766
G1 X84.636 Y102.606 E.01006
G1 X85.138 Y102.794 E.00892
G1 X85.664 Y102.888 E.00888
G1 X86.186 Y102.888 E.00868
G1 X86.713 Y102.794 E.00891
G1 X87.058 Y102.676 E.00607
G1 X87.39 Y102.521 E.0061
G1 X87.663 Y102.345 E.0054
G1 X87.948 Y102.121 E.00603
G1 X88.293 Y101.746 E.00847
G1 X88.585 Y101.289 E.00903
G1 X88.737 Y100.955 E.0061
G1 X88.865 Y100.505 E.00779
G1 X88.926 Y100.063 E.00743
G1 X88.909 Y99.536 E.00878
G1 X88.797 Y99.013 E.00889
G1 X88.592 Y98.521 E.00888
G1 X88.301 Y98.071 E.00891
G1 X88.183 Y97.922 E.00315
; LINE_WIDTH: 0.375582
G1 X87.839 Y97.561 E.00872
; LINE_WIDTH: 0.400628
G1 X87.82 Y97.543 E.00049
; LINE_WIDTH: 0.419482
G1 X87.713 Y97.445 E.00284
; LINE_WIDTH: 0.470903
G1 X87.39 Y97.172 E.0094
; WIPE_START
G1 X87.713 Y97.445 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X92.702 Y96.14 Z3.6 F18000
G1 Z3.2
G1 E.4 F1800
; LINE_WIDTH: 0.110916
G1 F1500
M204 S6000
G1 X92.947 Y95.999 E.0012
; WIPE_START
G1 X92.702 Y96.14 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X93.406 Y88.54 Z3.6 F18000
G1 X93.586 Y86.601 Z3.6
G1 Z3.2
G1 E.4 F1800
; LINE_WIDTH: 0.114562
G1 F1500
M204 S6000
G1 X95.017 Y86.601 E.00634
; WIPE_START
G1 X93.586 Y86.601 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X87.279 Y82.303 Z3.6 F18000
G1 X79.431 Y76.955 Z3.6
G1 Z3.2
G1 E.4 F1800
; LINE_WIDTH: 0.0896656
G1 F1500
M204 S6000
G1 X79.328 Y76.99 E.00035
; LINE_WIDTH: 0.128621
G1 X79.126 Y77.08 E.00113
; LINE_WIDTH: 0.154509
G1 X79.004 Y77.19 E.00106
G1 X78.863 Y77.371 E.00147
; LINE_WIDTH: 0.122855
G1 X78.819 Y77.482 E.00058
; LINE_WIDTH: 0.096528
G1 X78.788 Y77.597 E.00042
; CHANGE_LAYER
; Z_HEIGHT: 3.32
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F1500
G1 X78.819 Y77.482 E-.38
; WIPE_END
G1 E-.02 F1800
; layer num/total_layer_count: 27/49
; update layer progress
M73 L27
M991 S0 P26 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z3.6 I-.574 J1.073 P1  F18000
G1 X95.401 Y86.344 Z3.6
G1 Z3.32
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X95.401 Y86.857 E.01086
G1 X93.374 Y86.857 E.04289
G1 X93.374 Y86.344 E.01086
G1 X95.341 Y86.344 E.04162
M204 S10000
G1 X95.825 Y85.92 F18000
G1 F1500
M204 S500
G1 X95.825 Y87.282 E.02882
G1 X93.311 Y87.282 E.0532
G1 X93.311 Y88.382 E.02328
G1 X92.95 Y88.382 E.00765
G1 X92.95 Y77.127 E.23821
G1 X93.128 Y77.071 E.00395
G1 X93.191 Y77.162 E.00234
G1 X93.256 Y77.3 E.00324
G1 X93.296 Y77.448 E.00324
G1 X93.311 Y77.628 E.00382
G1 X93.311 Y85.92 E.17551
G1 X95.765 Y85.92 E.05193
; WIPE_START
M204 S6000
G1 X95.825 Y87.282 E-.25894
G1 X95.188 Y87.282 E-.12106
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X93.446 Y94.713 Z3.72 F18000
G1 X93.275 Y95.443 Z3.72
G1 Z3.32
G1 E.4 F1800
G1 F1500
M204 S500
G1 X93.273 Y95.556 E.00239
G1 X93.235 Y95.617 E.00152
G1 X93.198 Y95.639 E.0009
G1 X92.955 Y95.741 E.00559
G1 X92.982 Y95.473 E.0057
G1 X93.02 Y95.391 E.00193
G1 X93.131 Y95.345 E.00256
G1 X93.181 Y95.357 E.00109
G1 X93.231 Y95.402 E.00142
; WIPE_START
M204 S6000
G1 X93.273 Y95.556 E-.05309
G1 X93.235 Y95.617 E-.02401
G1 X93.198 Y95.639 E-.01428
G1 X92.955 Y95.741 E-.08827
G1 X92.982 Y95.473 E-.08999
G1 X93.02 Y95.391 E-.03039
G1 X93.131 Y95.345 E-.04036
G1 X93.181 Y95.357 E-.01719
G1 X93.231 Y95.402 E-.02242
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X85.747 Y96.9 Z3.72 F18000
G1 X84.696 Y97.11 Z3.72
G1 Z3.32
G1 E.4 F1800
G1 F1500
M204 S500
G1 X84.589 Y96.949 E.0041
G1 X84.941 Y96.544 E.01135
G1 X86.853 Y96.544 E.04045
G1 X87.193 Y96.913 E.01063
G1 X87.091 Y97.078 E.0041
G1 X86.51 Y96.908 E.01281
G1 X85.878 Y96.853 E.01343
G1 X85.26 Y96.927 E.01318
G1 X84.753 Y97.092 E.01128
; WIPE_START
M204 S6000
G1 X84.589 Y96.949 E-.04131
G1 X84.941 Y96.544 E-.10189
G1 X86.188 Y96.544 E-.2368
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X84.842 Y102.28 Z3.72 F18000
G1 Z3.32
G1 E.4 F1800
G1 F1500
M204 S500
G1 X84.486 Y102.089 E.00855
G1 X84.119 Y101.796 E.00995
G1 X83.81 Y101.442 E.00995
G1 X83.573 Y101.046 E.00975
G1 X83.451 Y100.748 E.00683
G1 X83.365 Y100.437 E.00683
G1 X83.31 Y99.979 E.00975
G1 X83.338 Y99.51 E.00995
G1 X83.449 Y99.054 E.00994
G1 X83.637 Y98.633 E.00975
G1 X83.811 Y98.361 E.00683
G1 X84.016 Y98.111 E.00683
G1 X84.351 Y97.809 E.00956
G1 X84.62 Y97.632 E.00683
G1 X84.909 Y97.487 E.00683
G1 X85.352 Y97.343 E.00985
G1 X85.885 Y97.28 E.01137
G1 X86.432 Y97.327 E.01161
G1 X86.88 Y97.458 E.00987
G1 X87.172 Y97.593 E.00683
G1 X87.447 Y97.763 E.00683
G1 X87.798 Y98.061 E.00975
G1 X88.091 Y98.417 E.00975
G1 X88.256 Y98.694 E.00683
G1 X88.388 Y98.989 E.00683
G1 X88.51 Y99.433 E.00975
G1 X88.551 Y99.892 E.00975
G1 X88.532 Y100.214 E.00683
G1 X88.475 Y100.531 E.00683
G1 X88.326 Y100.967 E.00975
G1 X88.097 Y101.378 E.00995
G1 X87.798 Y101.741 E.00995
G1 X87.436 Y102.048 E.01005
G1 X86.966 Y102.309 E.01137
G1 X86.443 Y102.473 E.01161
G1 X85.965 Y102.523 E.01018
G1 X85.43 Y102.474 E.01137
G1 X84.905 Y102.314 E.01161
G1 X84.895 Y102.309 E.00025
M204 S250
G1 X85.036 Y101.92 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X84.713 Y101.746 E.00722
G1 X84.403 Y101.499 E.0078
G1 X84.142 Y101.2 E.0078
G1 X83.94 Y100.863 E.00774
G1 X83.839 Y100.615 E.00526
G1 X83.768 Y100.357 E.00526
G1 X83.721 Y99.967 E.00773
G1 X83.744 Y99.571 E.0078
G1 X83.838 Y99.186 E.00779
G1 X83.998 Y98.827 E.00774
G1 X84.142 Y98.602 E.00526
G1 X84.312 Y98.395 E.00526
G1 X84.602 Y98.134 E.00767
G1 X84.825 Y97.987 E.00526
G1 X85.065 Y97.867 E.00526
G1 X85.44 Y97.745 E.00776
G1 X85.892 Y97.691 E.00895
G1 X86.356 Y97.731 E.00916
G1 X86.735 Y97.842 E.00777
G1 X86.978 Y97.954 E.00526
G1 X87.206 Y98.095 E.00526
G1 X87.506 Y98.349 E.00773
G1 X87.755 Y98.653 E.00773
G1 X87.892 Y98.883 E.00526
G1 X88.001 Y99.127 E.00526
G1 X88.106 Y99.506 E.00774
G1 X88.141 Y99.898 E.00773
G1 X88.125 Y100.165 E.00526
G1 X88.077 Y100.428 E.00526
G1 X87.95 Y100.8 E.00773
G1 X87.757 Y101.146 E.0078
G1 X87.506 Y101.452 E.0078
G1 X87.202 Y101.71 E.00783
G1 X86.804 Y101.931 E.00895
G1 X86.36 Y102.07 E.00916
G1 X85.962 Y102.112 E.00787
G1 X85.509 Y102.07 E.00895
G1 X85.091 Y101.943 E.00859
; WIPE_START
M204 S6000
G1 X84.713 Y101.746 E-.08105
G1 X84.403 Y101.499 E-.07531
G1 X84.142 Y101.2 E-.0753
G1 X83.94 Y100.863 E-.07473
G1 X83.839 Y100.615 E-.05083
G1 X83.807 Y100.5 E-.02278
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X84.691 Y96.12 Z3.72 F18000
G1 Z3.32
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X92.491 Y96.12 E.16508
G1 X92.564 Y95.389 E.01556
G1 X92.6 Y95.274 E.00255
G1 X92.657 Y95.17 E.00251
G1 X92.796 Y95.03 E.00417
G1 X92.898 Y94.973 E.00247
G1 X93.024 Y94.933 E.00279
G1 X93.222 Y94.93 E.0042
G1 X93.322 Y94.955 E.00218
G1 X93.5 Y95.056 E.00432
G1 X93.573 Y95.128 E.00218
G1 X93.632 Y95.213 E.00217
G1 X93.695 Y95.373 E.00364
G1 X93.707 Y95.504 E.00279
G1 X93.688 Y95.648 E.00307
G1 X93.652 Y95.749 E.00228
G1 X93.529 Y95.921 E.00445
G1 X93.391 Y96.018 E.00357
G1 X93.172 Y96.11 E.00503
G1 X92.999 Y96.272 E.00503
G1 X92.866 Y96.364 E.0034
G1 X92.729 Y96.427 E.00321
G1 X92.582 Y96.466 E.00321
G1 X92.404 Y96.482 E.00378
G1 X87.372 Y96.482 E.1065
G1 X88.475 Y97.675 E.03439
G1 X88.725 Y98 E.00868
G1 X88.936 Y98.353 E.00869
G1 X89.159 Y98.901 E.01254
G1 X89.286 Y99.49 E.01273
G1 X89.305 Y100.085 E.01262
G1 X89.239 Y100.578 E.01051
G1 X89.098 Y101.079 E.01101
G1 X88.848 Y101.606 E.01236
G1 X88.563 Y102.017 E.01058
G1 X88.211 Y102.395 E.01093
G1 X87.897 Y102.65 E.00856
G1 X87.573 Y102.855 E.00811
G1 X87.203 Y103.032 E.00868
G1 X86.814 Y103.164 E.00869
G1 X86.222 Y103.269 E.01273
G1 X85.63 Y103.267 E.01254
G1 X85.038 Y103.161 E.01274
G1 X84.474 Y102.951 E.01272
G1 X84.123 Y102.757 E.0085
G1 X83.797 Y102.522 E.00849
G1 X83.502 Y102.251 E.0085
G1 X83.24 Y101.947 E.00849
G1 X83.017 Y101.613 E.0085
G1 X82.834 Y101.256 E.00849
G1 X82.696 Y100.879 E.00849
G1 X82.604 Y100.494 E.00839
G1 X82.555 Y100 E.01051
G1 X82.577 Y99.484 E.01093
G1 X82.648 Y99.095 E.00837
G1 X82.766 Y98.716 E.00838
G1 X82.975 Y98.266 E.01052
G1 X83.258 Y97.833 E.01093
G1 X84.434 Y96.482 E.03792
G1 X79.467 Y96.482 E.10513
G1 X79.215 Y96.452 E.00536
G1 X79.109 Y96.419 E.00236
G1 X78.859 Y96.269 E.00618
G1 X78.661 Y96.025 E.00665
G1 X78.579 Y95.812 E.00482
G1 X78.55 Y95.565 E.00527
G1 X78.55 Y77.628 E.37965
G1 X78.588 Y77.349 E.00596
G1 X78.699 Y77.115 E.00548
G1 X78.863 Y76.93 E.00524
G1 X78.991 Y76.84 E.00331
G1 X79.13 Y76.775 E.00324
G1 X79.379 Y76.723 E.00539
G1 X92.447 Y76.721 E.27658
G1 X92.579 Y76.735 E.00281
G1 X92.731 Y76.775 E.00333
G1 X92.96 Y76.904 E.00556
G1 X92.904 Y77.082 E.00395
G1 X79.877 Y77.082 E.27575
G1 X79.588 Y77.132 E.0062
G1 X79.313 Y77.281 E.00661
G1 X79.088 Y77.513 E.00685
G1 X78.948 Y77.802 E.00679
G1 X78.911 Y78.056 E.00542
G1 X78.911 Y95.155 E.36192
G1 X78.964 Y95.453 E.0064
G1 X79.152 Y95.778 E.00795
G1 X79.512 Y96.047 E.00952
G1 X79.867 Y96.12 E.00767
G1 X84.631 Y96.12 E.10084
; WIPE_START
M204 S6000
G1 X86.631 Y96.12 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X83.535 Y96.891 Z3.72 F18000
G1 Z3.32
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X79.443 Y96.891 E.08049
G1 X79.129 Y96.854 E.00622
G1 X78.958 Y96.8 E.00353
G1 X78.787 Y96.718 E.00373
G1 X78.599 Y96.587 E.0045
G1 X78.497 Y96.49 E.00277
G1 X78.311 Y96.24 E.00613
G1 X78.248 Y96.114 E.00277
G1 X78.177 Y95.901 E.00442
G1 X78.141 Y95.589 E.00619
G1 X78.141 Y77.61 E.35362
G1 X78.161 Y77.374 E.00466
G1 X78.195 Y77.231 E.00289
G1 X78.245 Y77.093 E.00289
G1 X78.354 Y76.891 E.00451
G1 X78.465 Y76.747 E.00359
G1 X78.601 Y76.614 E.00373
G1 X78.786 Y76.484 E.00444
G1 X78.99 Y76.389 E.00442
G1 X79.21 Y76.33 E.00448
G1 X79.356 Y76.313 E.00289
G1 X92.467 Y76.312 E.2579
G1 X92.653 Y76.331 E.00367
G1 X92.872 Y76.389 E.00445
G1 X93.075 Y76.484 E.00442
G1 X93.259 Y76.613 E.00442
G1 X93.418 Y76.772 E.00442
G1 X93.547 Y76.956 E.00442
G1 X93.642 Y77.16 E.00442
G1 X93.7 Y77.377 E.00442
G1 X93.721 Y77.61 E.0046
G1 X93.721 Y85.511 E.1554
G1 X96.001 Y85.511 E.04485
G1 X96.104 Y85.434 E.00254
G1 F1969.233
G1 X96.234 Y85.336 E.00321
G1 F1320
G1 X96.234 Y87.866 E.04977
G1 F1762.136
G1 X96.104 Y87.768 E.00321
G1 F1500
G1 X96.001 Y87.691 E.00254
G1 X93.721 Y87.691 E.04485
G1 X93.721 Y88.791 E.02164
G1 X92.541 Y88.791 E.02321
G1 X92.541 Y77.491 E.22226
G1 X79.912 Y77.491 E.24839
G1 X79.724 Y77.524 E.00376
G1 X79.563 Y77.611 E.00359
G1 X79.428 Y77.751 E.00383
G1 X79.344 Y77.924 E.00378
G1 X79.321 Y78.086 E.00322
G1 X79.321 Y95.119 E.33504
G1 X79.354 Y95.311 E.00382
G1 X79.464 Y95.5 E.00431
G1 X79.684 Y95.664 E.0054
G1 X79.909 Y95.711 E.00452
G1 X92.12 Y95.711 E.24019
G1 X92.161 Y95.307 E.00798
G1 X92.221 Y95.113 E.004
G1 X92.317 Y94.938 E.00392
G1 X92.429 Y94.804 E.00343
G1 X92.562 Y94.692 E.00342
G1 X92.735 Y94.595 E.0039
G1 X92.94 Y94.531 E.00422
G1 X93.113 Y94.512 E.00342
G1 X93.287 Y94.524 E.00345
G1 X93.458 Y94.568 E.00346
G1 X93.618 Y94.64 E.00345
G1 X93.762 Y94.74 E.00345
G1 X93.887 Y94.864 E.00346
G1 X93.988 Y95.008 E.00345
G1 X94.062 Y95.169 E.00349
G1 X94.098 Y95.297 E.00263
M73 P71 R7
G1 X94.119 Y95.511 E.00422
G1 X94.088 Y95.746 E.00466
G1 X94.022 Y95.929 E.00383
G1 X93.91 Y96.11 E.00418
G1 X93.813 Y96.217 E.00285
G1 X93.577 Y96.383 E.00567
G1 X93.398 Y96.459 E.00382
G1 X93.256 Y96.592 E.00383
G1 X93.07 Y96.72 E.00444
G1 X92.868 Y96.814 E.00438
G1 X92.652 Y96.871 E.00438
G1 X92.421 Y96.891 E.00456
G1 X88.307 Y96.891 E.08092
G1 X88.788 Y97.411 E.01393
G1 X89.064 Y97.77 E.00891
G1 X89.296 Y98.159 E.00891
G1 X89.391 Y98.356 E.00431
G1 X89.551 Y98.78 E.00891
G1 X89.659 Y99.22 E.00891
G1 X89.692 Y99.44 E.00437
G1 X89.713 Y99.661 E.00437
G1 X89.714 Y100.112 E.00887
G1 X89.641 Y100.661 E.01089
G1 X89.485 Y101.215 E.01132
G1 X89.359 Y101.513 E.00638
G1 X89.199 Y101.819 E.00678
G1 X88.882 Y102.274 E.01091
G1 X88.491 Y102.694 E.01129
G1 X88.141 Y102.979 E.00887
G1 X87.766 Y103.216 E.00873
G1 X87.358 Y103.412 E.00891
G1 X86.928 Y103.557 E.00891
G1 X86.716 Y103.608 E.0043
G1 X86.265 Y103.676 E.00897
G1 X86.046 Y103.689 E.00431
G1 X85.593 Y103.676 E.00891
G1 X85.145 Y103.608 E.00891
G1 X84.929 Y103.556 E.00437
G1 X84.717 Y103.491 E.00436
G1 X84.298 Y103.321 E.00891
G1 X83.904 Y103.103 E.00885
G1 X83.539 Y102.84 E.00885
G1 X83.207 Y102.536 E.00885
G1 X82.914 Y102.195 E.00885
G1 X82.663 Y101.821 E.00885
G1 X82.459 Y101.42 E.00885
G1 X82.303 Y100.998 E.00885
G1 X82.199 Y100.562 E.00882
G1 X82.144 Y100.011 E.01089
G1 X82.169 Y99.438 E.01129
G1 X82.25 Y98.997 E.00881
G1 X82.383 Y98.569 E.00882
G1 X82.617 Y98.067 E.01089
G1 X82.93 Y97.586 E.01129
G1 X83.496 Y96.936 E.01694
; WIPE_START
M204 S6000
G1 X81.496 Y96.914 E-.38
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




G1 X79.362 Y96.255
G1 Z3.32
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.149747
G1 F1500
M204 S6000
G1 X79.138 Y96.12 E.00162
G1 X78.956 Y95.967 E.00147
G1 X78.878 Y95.849 E.00088
G1 X78.778 Y95.627 E.00151
; WIPE_START
G1 X78.878 Y95.849 E-.10459
G1 X78.956 Y95.967 E-.06115
G1 X79.138 Y96.12 E-.10182
G1 X79.362 Y96.255 E-.11244
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X84.478 Y97.165 Z3.72 F18000
G1 Z3.32
G1 E.4 F1800
; LINE_WIDTH: 0.477112
G1 F1500
M204 S6000
G1 X84.297 Y97.319 E.00533
; LINE_WIDTH: 0.438412
G1 X84.09 Y97.496 E.00561
; LINE_WIDTH: 0.401008
G1 X83.921 Y97.669 E.00453
; LINE_WIDTH: 0.359957
G1 X83.562 Y98.063 E.00889
G1 X83.306 Y98.45 E.00773
G1 X83.122 Y98.854 E.00741
G1 X83.022 Y99.186 E.00579
G1 X82.956 Y99.527 E.00578
G1 X82.932 Y99.989 E.00772
G1 X82.992 Y100.498 E.00853
G1 X83.097 Y100.879 E.00659
G1 X83.242 Y101.226 E.00627
G1 X83.544 Y101.716 E.0096
G1 X83.848 Y102.058 E.00763
G1 X84.266 Y102.395 E.00896
G1 X84.747 Y102.654 E.00909
G1 X85.14 Y102.789 E.00693
G1 X85.374 Y102.843 E.00402
G1 X85.664 Y102.882 E.00488
G1 X85.952 Y102.896 E.0048
G1 X86.186 Y102.886 E.0039
G1 X86.712 Y102.792 E.00892
G1 X87.131 Y102.649 E.00737
G1 X87.638 Y102.368 E.00967
G1 X87.949 Y102.115 E.00669
G1 X88.265 Y101.776 E.00772
G1 X88.519 Y101.408 E.00747
G1 X88.676 Y101.107 E.00565
G1 X88.84 Y100.614 E.00867
G1 X88.905 Y100.249 E.00618
G1 X88.925 Y99.874 E.00626
G1 X88.881 Y99.38 E.00826
G1 X88.792 Y99.015 E.00627
G1 X88.598 Y98.528 E.00873
G1 X88.408 Y98.209 E.0062
G1 X88.058 Y97.784 E.00918
; LINE_WIDTH: 0.375759
G1 X87.879 Y97.612 E.00434
; LINE_WIDTH: 0.408419
G1 X87.673 Y97.416 E.00543
; LINE_WIDTH: 0.445757
G1 X87.491 Y97.272 E.00486
; LINE_WIDTH: 0.479735
G1 X87.31 Y97.127 E.00525
; WIPE_START
G1 X87.491 Y97.272 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X92.702 Y96.14 Z3.72 F18000
G1 Z3.32
G1 E.4 F1800
; LINE_WIDTH: 0.111022
G1 F1500
M204 S6000
G1 X92.948 Y95.999 E.0012
; WIPE_START
G1 X92.702 Y96.14 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X93.406 Y88.54 Z3.72 F18000
G1 X93.586 Y86.601 Z3.72
G1 Z3.32
G1 E.4 F1800
; LINE_WIDTH: 0.114562
G1 F1500
M204 S6000
G1 X95.189 Y86.601 E.0071
; WIPE_START
G1 X93.586 Y86.601 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X87.278 Y82.304 Z3.72 F18000
G1 X79.427 Y76.955 Z3.72
G1 Z3.32
G1 E.4 F1800
; LINE_WIDTH: 0.0896005
G1 F1500
M204 S6000
G1 X79.324 Y76.991 E.00035
; LINE_WIDTH: 0.12554
G1 X79.145 Y77.072 E.00098
; LINE_WIDTH: 0.155585
G1 X79.045 Y77.15 E.00082
G1 X78.863 Y77.368 E.00184
; LINE_WIDTH: 0.122926
G1 X78.819 Y77.482 E.00059
; LINE_WIDTH: 0.0964909
G1 X78.788 Y77.597 E.00042
; CHANGE_LAYER
; Z_HEIGHT: 3.44
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F1500
G1 X78.819 Y77.482 E-.38
; WIPE_END
G1 E-.02 F1800
; layer num/total_layer_count: 28/49
; update layer progress
M73 L28
M991 S0 P27 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z3.72 I-.569 J1.076 P1  F18000
G1 X95.572 Y86.344 Z3.72
G1 Z3.44
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X95.572 Y86.857 E.01086
G1 X93.374 Y86.857 E.04652
G1 X93.374 Y86.344 E.01086
G1 X95.512 Y86.344 E.04525
M204 S10000
G1 X95.996 Y85.92 F18000
G1 F1500
M204 S500
G1 X95.996 Y87.282 E.02882
G1 X93.311 Y87.282 E.05683
G1 X93.311 Y88.382 E.02328
G1 X92.95 Y88.382 E.00765
G1 X92.95 Y77.127 E.23821
G1 X93.128 Y77.071 E.00395
G1 X93.191 Y77.162 E.00234
G1 X93.256 Y77.3 E.00324
G1 X93.296 Y77.448 E.00324
G1 X93.311 Y77.628 E.00382
G1 X93.311 Y85.92 E.17551
G1 X95.936 Y85.92 E.05556
; WIPE_START
M204 S6000
G1 X95.996 Y87.282 E-.25894
G1 X95.359 Y87.282 E-.12106
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X93.471 Y94.677 Z3.84 F18000
G1 X93.275 Y95.443 Z3.84
G1 Z3.44
G1 E.4 F1800
G1 F1500
M204 S500
G1 X93.273 Y95.556 E.00239
G1 X93.235 Y95.616 E.0015
G1 X93.198 Y95.639 E.00093
G1 X92.955 Y95.741 E.00558
G1 X92.993 Y95.439 E.00644
G1 X93.019 Y95.391 E.00117
G1 X93.068 Y95.364 E.00117
G1 X93.155 Y95.35 E.00186
G1 X93.228 Y95.384 E.0017
G1 X93.238 Y95.396 E.00034
; WIPE_START
M204 S6000
G1 X93.273 Y95.556 E-.05448
G1 X93.235 Y95.616 E-.02366
G1 X93.198 Y95.639 E-.01457
G1 X92.955 Y95.741 E-.08774
G1 X92.993 Y95.439 E-.10132
G1 X93.019 Y95.391 E-.01843
G1 X93.068 Y95.364 E-.01846
G1 X93.155 Y95.35 E-.0293
G1 X93.228 Y95.384 E-.02675
G1 X93.238 Y95.396 E-.0053
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X85.755 Y96.898 Z3.84 F18000
G1 X84.696 Y97.11 Z3.84
G1 Z3.44
G1 E.4 F1800
G1 F1500
M204 S500
G1 X84.589 Y96.949 E.0041
G1 X84.941 Y96.544 E.01135
G1 X86.92 Y96.544 E.04188
G1 X87.273 Y96.951 E.0114
G1 X87.15 Y97.115 E.00436
G1 X87.029 Y97.059 E.00282
G1 X86.51 Y96.908 E.01144
G1 X85.875 Y96.853 E.01348
G1 X85.26 Y96.927 E.01312
G1 X84.753 Y97.092 E.01128
; WIPE_START
M204 S6000
G1 X84.589 Y96.949 E-.04131
G1 X84.941 Y96.544 E-.10188
G1 X86.188 Y96.544 E-.23681
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X84.841 Y102.28 Z3.84 F18000
G1 Z3.44
G1 E.4 F1800
G1 F1500
M204 S500
G1 X84.486 Y102.089 E.00854
G1 X84.119 Y101.796 E.00994
G1 X83.81 Y101.442 E.00995
G1 X83.568 Y101.038 E.00995
G1 X83.407 Y100.607 E.00975
G1 X83.34 Y100.292 E.00683
G1 X83.31 Y99.965 E.00693
G1 X83.35 Y99.441 E.01112
G1 X83.502 Y98.912 E.01167
G1 X83.721 Y98.489 E.01007
G1 X84.012 Y98.113 E.01007
G1 X84.429 Y97.752 E.01166
G1 X84.896 Y97.492 E.01132
G1 X85.352 Y97.343 E.01015
G1 X85.883 Y97.28 E.01132
G1 X86.432 Y97.327 E.01166
G1 X86.88 Y97.458 E.00988
G1 X87.172 Y97.593 E.00683
G1 X87.447 Y97.763 E.00683
G1 X87.798 Y98.061 E.00975
G1 X88.101 Y98.429 E.01008
G1 X88.36 Y98.915 E.01166
G1 X88.51 Y99.428 E.01132
M73 P71 R6
G1 X88.553 Y99.907 E.01017
G1 X88.493 Y100.454 E.01166
G1 X88.328 Y100.963 E.01132
G1 X88.097 Y101.378 E.01004
G1 X87.798 Y101.741 E.00995
G1 X87.436 Y102.048 E.01005
G1 X86.969 Y102.308 E.01132
G1 X86.443 Y102.473 E.01166
G1 X85.965 Y102.523 E.01018
G1 X85.432 Y102.475 E.01132
G1 X84.905 Y102.314 E.01166
G1 X84.894 Y102.308 E.00027
M204 S250
G1 X85.035 Y101.92 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X84.713 Y101.746 E.00721
G1 X84.403 Y101.499 E.00779
G1 X84.142 Y101.2 E.0078
G1 X83.939 Y100.86 E.0078
G1 X83.801 Y100.492 E.00773
G1 X83.745 Y100.23 E.00526
G1 X83.721 Y99.962 E.00529
G1 X83.754 Y99.514 E.00884
G1 X83.884 Y99.064 E.00921
G1 X84.067 Y98.711 E.00783
G1 X84.311 Y98.396 E.00784
G1 X84.665 Y98.089 E.00921
G1 X85.06 Y97.868 E.0089
G1 X85.44 Y97.745 E.00786
G1 X85.89 Y97.691 E.00891
G1 X86.356 Y97.731 E.00921
G1 X86.735 Y97.842 E.00777
G1 X86.978 Y97.954 E.00526
G1 X87.206 Y98.095 E.00526
G1 X87.506 Y98.349 E.00773
G1 X87.759 Y98.657 E.00784
G1 X87.979 Y99.07 E.0092
G1 X88.106 Y99.505 E.0089
G1 X88.142 Y99.903 E.00787
G1 X88.091 Y100.368 E.00921
G1 X87.951 Y100.799 E.0089
G1 X87.757 Y101.146 E.00782
G1 X87.506 Y101.452 E.0078
G1 X87.202 Y101.71 E.00783
G1 X86.807 Y101.93 E.0089
G1 X86.36 Y102.07 E.00921
G1 X85.962 Y102.112 E.00787
G1 X85.511 Y102.071 E.0089
G1 X85.09 Y101.943 E.00865
; WIPE_START
M204 S6000
G1 X84.713 Y101.746 E-.08094
G1 X84.403 Y101.499 E-.07528
G1 X84.142 Y101.2 E-.0753
G1 X83.939 Y100.86 E-.07534
G1 X83.803 Y100.5 E-.07314
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X84.691 Y96.12 Z3.84 F18000
G1 Z3.44
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X92.491 Y96.12 E.16508
G1 X92.564 Y95.39 E.01554
G1 X92.6 Y95.273 E.00259
G1 X92.657 Y95.17 E.00248
G1 X92.795 Y95.03 E.00417
G1 X92.899 Y94.972 E.00251
G1 X93.023 Y94.933 E.00276
G1 X93.222 Y94.93 E.00421
G1 X93.322 Y94.955 E.00218
G1 X93.5 Y95.056 E.00433
G1 X93.573 Y95.128 E.00218
G1 X93.632 Y95.212 E.00217
G1 X93.695 Y95.374 E.00367
G1 X93.707 Y95.504 E.00276
G1 X93.689 Y95.648 E.00307
G1 X93.651 Y95.751 E.00233
G1 X93.529 Y95.921 E.00444
G1 X93.39 Y96.018 E.00357
G1 X93.173 Y96.11 E.005
G1 X92.999 Y96.272 E.00504
G1 X92.866 Y96.364 E.0034
G1 X92.729 Y96.427 E.00322
G1 X92.582 Y96.466 E.00321
G1 X92.404 Y96.482 E.00378
G1 X87.428 Y96.482 E.10532
G1 X88.614 Y97.845 E.03825
G1 X88.72 Y97.992 E.00385
G1 X88.933 Y98.348 E.00877
G1 X89.158 Y98.899 E.0126
G1 X89.286 Y99.49 E.01279
G1 X89.305 Y100.086 E.01262
G1 X89.24 Y100.574 E.01042
G1 X89.098 Y101.079 E.01111
G1 X88.844 Y101.614 E.01255
G1 X88.496 Y102.101 E.01265
G1 X88.216 Y102.391 E.00855
G1 X87.897 Y102.65 E.00868
G1 X87.574 Y102.855 E.00811
G1 X87.203 Y103.032 E.00869
G1 X86.814 Y103.164 E.00869
G1 X86.222 Y103.269 E.01273
G1 X85.63 Y103.267 E.01254
G1 X85.047 Y103.163 E.01254
G1 X84.658 Y103.032 E.00869
G1 X84.3 Y102.861 E.00839
G1 X83.889 Y102.591 E.01042
G1 X83.498 Y102.246 E.01103
G1 X83.24 Y101.947 E.00836
G1 X83.017 Y101.613 E.00849
G1 X82.834 Y101.256 E.0085
G1 X82.696 Y100.879 E.00849
G1 X82.602 Y100.489 E.0085
G1 X82.556 Y100.091 E.00849
G1 X82.574 Y99.499 E.01253
G1 X82.648 Y99.095 E.00869
G1 X82.766 Y98.716 E.00839
G1 X82.973 Y98.27 E.01042
G1 X83.258 Y97.833 E.01103
G1 X84.434 Y96.482 E.03792
G1 X79.467 Y96.482 E.10513
G1 X79.228 Y96.454 E.00508
G1 X79.026 Y96.38 E.00456
G1 X78.923 Y96.318 E.00254
G1 X78.739 Y96.142 E.00539
G1 X78.67 Y96.041 E.00259
G1 X78.579 Y95.816 E.00513
G1 X78.55 Y95.565 E.00536
G1 X78.55 Y77.628 E.37965
G1 X78.587 Y77.353 E.00586
G1 X78.695 Y77.121 E.00543
G1 X78.882 Y76.914 E.00589
G1 X79.134 Y76.774 E.00611
G1 X79.385 Y76.723 E.00543
G1 X92.449 Y76.722 E.27649
G1 X92.579 Y76.735 E.00277
G1 X92.731 Y76.775 E.00333
G1 X92.96 Y76.904 E.00556
G1 X92.904 Y77.082 E.00395
G1 X79.876 Y77.082 E.27574
G1 X79.588 Y77.133 E.0062
G1 X79.318 Y77.278 E.00649
G1 X79.101 Y77.495 E.00649
G1 X78.949 Y77.798 E.00717
G1 X78.911 Y78.056 E.00552
G1 X78.911 Y95.155 E.36192
G1 X78.964 Y95.453 E.0064
G1 X79.152 Y95.778 E.00796
G1 X79.512 Y96.047 E.00951
G1 X79.867 Y96.12 E.00767
G1 X84.631 Y96.12 E.10083
; WIPE_START
M204 S6000
G1 X86.631 Y96.12 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X83.535 Y96.891 Z3.84 F18000
G1 Z3.44
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X79.443 Y96.891 E.08049
G1 X79.133 Y96.855 E.00613
G1 X78.848 Y96.751 E.00597
G1 X78.687 Y96.654 E.0037
G1 X78.546 Y96.539 E.00358
G1 X78.416 Y96.396 E.00379
G1 X78.314 Y96.246 E.00358
G1 X78.231 Y96.072 E.00379
G1 X78.177 Y95.903 E.00349
G1 X78.141 Y95.589 E.00622
G1 X78.141 Y77.61 E.35362
M73 P72 R6
G1 X78.161 Y77.374 E.00466
G1 X78.195 Y77.233 E.00286
G1 X78.26 Y77.061 E.00362
G1 X78.353 Y76.893 E.00377
G1 X78.494 Y76.715 E.00447
G1 X78.627 Y76.593 E.00356
G1 X78.785 Y76.485 E.00377
G1 X78.991 Y76.389 E.00447
G1 X79.165 Y76.34 E.00356
G1 X79.358 Y76.313 E.00383
G1 X92.469 Y76.312 E.25789
G1 X92.653 Y76.331 E.00364
G1 X92.871 Y76.389 E.00445
G1 X93.075 Y76.484 E.00442
G1 X93.259 Y76.613 E.00442
G1 X93.418 Y76.772 E.00442
G1 X93.547 Y76.956 E.00442
G1 X93.642 Y77.16 E.00442
G1 X93.7 Y77.377 E.00442
G1 X93.721 Y77.61 E.0046
G1 X93.721 Y85.511 E.1554
G1 X96.001 Y85.511 E.04485
G1 X96.275 Y85.305 E.00675
G1 F1843.769
G1 X96.324 Y85.269 E.0012
G1 F1910.313
G1 X96.405 Y85.337 E.00209
G1 F1320
G1 X96.405 Y87.865 E.04973
G1 F1910.313
G1 X96.324 Y87.933 E.00209
G1 F2098.7
G1 X96.275 Y87.897 E.00119
G1 F1500
G1 X96.001 Y87.691 E.00675
G1 X93.721 Y87.691 E.04485
G1 X93.721 Y88.791 E.02164
G1 X92.541 Y88.791 E.02321
G1 X92.541 Y77.491 E.22226
G1 X79.912 Y77.491 E.24839
G1 X79.724 Y77.524 E.00376
G1 X79.565 Y77.61 E.00355
G1 X79.437 Y77.738 E.00355
G1 X79.344 Y77.922 E.00407
G1 X79.321 Y78.086 E.00324
G1 X79.321 Y95.119 E.33504
G1 X79.354 Y95.311 E.00382
G1 X79.464 Y95.501 E.00431
G1 X79.684 Y95.664 E.0054
G1 X79.909 Y95.711 E.00452
G1 X92.121 Y95.711 E.24019
G1 X92.161 Y95.308 E.00796
G1 X92.221 Y95.112 E.00404
G1 X92.317 Y94.939 E.0039
G1 X92.428 Y94.804 E.00343
G1 X92.562 Y94.692 E.00343
G1 X92.736 Y94.594 E.00393
G1 X92.939 Y94.531 E.00419
G1 X93.112 Y94.512 E.00342
G1 X93.287 Y94.524 E.00345
G1 X93.458 Y94.567 E.00346
G1 X93.618 Y94.64 E.00346
G1 X93.762 Y94.74 E.00345
G1 X93.887 Y94.863 E.00346
G1 X93.988 Y95.007 E.00346
G1 X94.062 Y95.168 E.00349
G1 X94.099 Y95.299 E.00266
G1 X94.119 Y95.51 E.00418
G1 X94.089 Y95.745 E.00466
G1 X94.021 Y95.931 E.00388
G1 X93.91 Y96.109 E.00414
G1 X93.812 Y96.218 E.00288
G1 X93.576 Y96.384 E.00568
G1 X93.399 Y96.459 E.00379
G1 X93.256 Y96.592 E.00384
G1 X93.07 Y96.72 E.00444
G1 X92.868 Y96.814 E.00439
G1 X92.653 Y96.871 E.00438
G1 X92.421 Y96.891 E.00456
G1 X88.326 Y96.891 E.08055
G1 X88.934 Y97.59 E.01823
G1 X89.063 Y97.767 E.0043
G1 X89.295 Y98.157 E.00894
G1 X89.43 Y98.449 E.00632
G1 X89.551 Y98.779 E.00691
G1 X89.659 Y99.22 E.00893
G1 X89.692 Y99.44 E.00437
G1 X89.713 Y99.661 E.00437
G1 X89.714 Y100.112 E.00888
G1 X89.642 Y100.656 E.0108
G1 X89.485 Y101.215 E.01141
G1 X89.36 Y101.509 E.00628
G1 X89.198 Y101.821 E.00693
G1 X89.021 Y102.091 E.00634
G1 X88.806 Y102.369 E.00691
G1 X88.493 Y102.693 E.00887
G1 X88.141 Y102.979 E.00891
G1 X87.766 Y103.216 E.00873
G1 X87.358 Y103.412 E.00891
G1 X86.928 Y103.557 E.00892
G1 X86.716 Y103.608 E.0043
G1 X86.265 Y103.676 E.00897
G1 X86.046 Y103.689 E.00431
G1 X85.593 Y103.676 E.00891
G1 X85.145 Y103.608 E.00891
G1 X84.933 Y103.557 E.00431
G1 X84.504 Y103.412 E.00891
G1 X84.099 Y103.218 E.00882
G1 X83.64 Y102.917 E.0108
G1 X83.206 Y102.534 E.01138
G1 X82.914 Y102.195 E.00881
G1 X82.663 Y101.821 E.00885
G1 X82.459 Y101.42 E.00885
G1 X82.303 Y100.998 E.00885
G1 X82.199 Y100.56 E.00885
G1 X82.147 Y100.113 E.00885
G1 X82.148 Y99.661 E.00891
G1 X82.169 Y99.443 E.0043
G1 X82.25 Y98.997 E.00891
G1 X82.383 Y98.569 E.00882
G1 X82.614 Y98.071 E.0108
G1 X82.93 Y97.586 E.01138
G1 X83.496 Y96.936 E.01694
; WIPE_START
M204 S6000
G1 X81.496 Y96.914 E-.38
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




G1 X79.376 Y96.249
G1 Z3.44
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.14888
G1 F1500
M204 S6000
G1 X79.15 Y96.127 E.00158
G1 X79.023 Y96.035 E.00096
G1 X78.94 Y95.951 E.00072
G1 X78.866 Y95.825 E.0009
; LINE_WIDTH: 0.126487
G1 X78.829 Y95.723 E.00054
; LINE_WIDTH: 0.0941362
G1 X78.792 Y95.622 E.00037
; WIPE_START
G1 X78.829 Y95.723 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X84.48 Y97.168 Z3.84 F18000
G1 Z3.44
G1 E.4 F1800
; LINE_WIDTH: 0.470515
G1 F1500
M204 S6000
G1 X84.203 Y97.393 E.00791
; LINE_WIDTH: 0.444188
G1 X84.171 Y97.421 E.0009
; LINE_WIDTH: 0.418023
G1 X83.96 Y97.632 E.00582
; LINE_WIDTH: 0.361206
G1 X83.728 Y97.866 E.00553
G1 X83.399 Y98.301 E.00912
G1 X83.147 Y98.787 E.00917
G1 X83.023 Y99.187 E.007
G1 X82.956 Y99.546 E.00611
G1 X82.935 Y99.981 E.0073
G1 X82.967 Y100.358 E.00632
G1 X83.061 Y100.769 E.00706
G1 X83.236 Y101.215 E.00802
G1 X83.513 Y101.676 E.009
G1 X83.849 Y102.057 E.00851
G1 X84.121 Y102.286 E.00595
G1 X84.489 Y102.526 E.00735
G1 X84.801 Y102.68 E.00582
G1 X85.345 Y102.838 E.00948
G1 X85.664 Y102.882 E.0054
; LINE_WIDTH: 0.360764
G1 X86.186 Y102.886 E.00871
G1 X86.534 Y102.835 E.00589
G1 X87.06 Y102.679 E.00916
G1 X87.39 Y102.515 E.00615
G1 X87.673 Y102.344 E.00554
G1 X88.076 Y101.994 E.00892
G1 X88.414 Y101.576 E.00898
G1 X88.664 Y101.127 E.0086
G1 X88.736 Y100.948 E.00322
G1 X88.869 Y100.497 E.00785
G1 X88.929 Y99.927 E.00959
G1 X88.885 Y99.372 E.0093
G1 X88.79 Y99.015 E.00617
G1 X88.699 Y98.759 E.00454
G1 X88.59 Y98.527 E.00428
G1 X88.402 Y98.208 E.00618
G1 X88.058 Y97.784 E.00913
; LINE_WIDTH: 0.378805
G1 X87.881 Y97.609 E.00438
; LINE_WIDTH: 0.41929
G1 X87.678 Y97.411 E.00556
; LINE_WIDTH: 0.468123
G1 X87.38 Y97.162 E.00858
; WIPE_START
G1 X87.678 Y97.411 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X92.702 Y96.139 Z3.84 F18000
G1 Z3.44
G1 E.4 F1800
; LINE_WIDTH: 0.111225
G1 F1500
M204 S6000
G1 X92.948 Y95.999 E.00121
; WIPE_START
G1 X92.702 Y96.139 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X93.406 Y88.539 Z3.84 F18000
G1 X93.586 Y86.601 Z3.84
G1 Z3.44
G1 E.4 F1800
; LINE_WIDTH: 0.114562
G1 F1500
M204 S6000
G1 X95.36 Y86.601 E.00786
; WIPE_START
G1 X93.586 Y86.601 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X87.279 Y82.303 Z3.84 F18000
G1 X79.426 Y76.953 Z3.84
G1 Z3.44
G1 E.4 F1800
; LINE_WIDTH: 0.0923131
G1 F1500
M204 S6000
G1 X79.326 Y76.989 E.00035
; LINE_WIDTH: 0.130267
G1 X79.127 Y77.08 E.00114
; LINE_WIDTH: 0.155957
G1 X79.004 Y77.19 E.00107
G1 X78.876 Y77.348 E.00132
; LINE_WIDTH: 0.125785
G1 X78.82 Y77.482 E.00073
; LINE_WIDTH: 0.0973428
G1 X78.787 Y77.598 E.00043
; CHANGE_LAYER
; Z_HEIGHT: 3.56
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F1500
G1 X78.82 Y77.482 E-.38
; WIPE_END
G1 E-.02 F1800
; layer num/total_layer_count: 29/49
; update layer progress
M73 L29
M991 S0 P28 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z3.84 I-.565 J1.078 P1  F18000
G1 X95.743 Y86.344 Z3.84
G1 Z3.56
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X95.743 Y86.857 E.01086
G1 X93.374 Y86.857 E.05015
G1 X93.374 Y86.344 E.01086
G1 X95.683 Y86.344 E.04888
M204 S10000
G1 X96.168 Y85.92 F18000
G1 F1500
M204 S500
G1 X96.168 Y87.282 E.02882
G1 X93.311 Y87.282 E.06046
G1 X93.311 Y88.382 E.02328
G1 X92.95 Y88.382 E.00765
G1 X92.95 Y77.127 E.23821
G1 X93.128 Y77.071 E.00395
G1 X93.191 Y77.162 E.00234
G1 X93.256 Y77.3 E.00324
G1 X93.296 Y77.448 E.00324
G1 X93.311 Y77.628 E.00382
G1 X93.311 Y85.92 E.17551
G1 X96.108 Y85.92 E.05919
; WIPE_START
M204 S6000
G1 X96.168 Y87.282 E-.25894
G1 X95.53 Y87.282 E-.12106
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X93.497 Y94.638 Z3.96 F18000
G1 X93.275 Y95.442 Z3.96
G1 Z3.56
G1 E.4 F1800
G1 F1500
M204 S500
G1 X93.273 Y95.556 E.00242
G1 X93.236 Y95.616 E.0015
G1 X93.197 Y95.639 E.00095
G1 X92.955 Y95.741 E.00556
G1 X92.993 Y95.439 E.00645
G1 X93.019 Y95.391 E.00115
G1 X93.069 Y95.363 E.0012
G1 X93.155 Y95.35 E.00184
G1 X93.228 Y95.384 E.0017
G1 X93.237 Y95.395 E.00031
; WIPE_START
M204 S6000
G1 X93.273 Y95.556 E-.05493
G1 X93.236 Y95.616 E-.02356
G1 X93.197 Y95.639 E-.01491
G1 X92.955 Y95.741 E-.08746
G1 X92.993 Y95.439 E-.1015
G1 X93.019 Y95.391 E-.01816
G1 X93.069 Y95.363 E-.01893
G1 X93.155 Y95.35 E-.02889
G1 X93.228 Y95.384 E-.02678
G1 X93.237 Y95.395 E-.00487
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X85.754 Y96.898 Z3.96 F18000
G1 X84.696 Y97.11 Z3.96
G1 Z3.56
G1 E.4 F1800
G1 F1500
M204 S500
G1 X84.589 Y96.949 E.0041
G1 X84.941 Y96.544 E.01135
G1 X86.92 Y96.544 E.04188
G1 X87.273 Y96.951 E.0114
G1 X87.15 Y97.115 E.00436
G1 X87.029 Y97.06 E.00282
G1 X86.51 Y96.908 E.01145
G1 X85.872 Y96.853 E.01354
G1 X85.26 Y96.927 E.01306
G1 X84.753 Y97.092 E.01127
; WIPE_START
M204 S6000
G1 X84.589 Y96.949 E-.04131
G1 X84.941 Y96.544 E-.10189
G1 X86.188 Y96.544 E-.2368
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X84.862 Y102.281 Z3.96 F18000
G1 Z3.56
G1 E.4 F1800
G1 F1500
M204 S500
G1 X84.543 Y102.125 E.00753
G1 X84.118 Y101.796 E.01136
G1 X83.771 Y101.387 E.01136
G1 X83.506 Y100.901 E.01172
G1 X83.366 Y100.446 E.01008
G1 X83.31 Y99.979 E.00995
G1 X83.338 Y99.51 E.00995
G1 X83.449 Y99.054 E.00994
G1 X83.637 Y98.633 E.00976
G1 X83.811 Y98.361 E.00683
G1 X84.016 Y98.111 E.00683
G1 X84.351 Y97.809 E.00955
G1 X84.62 Y97.632 E.00683
G1 X84.909 Y97.487 E.00683
G1 X85.351 Y97.344 E.00984
G1 X85.88 Y97.28 E.01127
G1 X86.432 Y97.327 E.01172
G1 X86.88 Y97.458 E.00988
G1 X87.172 Y97.593 E.00683
G1 X87.447 Y97.763 E.00683
G1 X87.798 Y98.061 E.00975
G1 X88.097 Y98.424 E.00995
G1 X88.326 Y98.835 E.00995
G1 X88.475 Y99.271 E.00975
G1 X88.532 Y99.588 E.00683
M73 P73 R6
G1 X88.551 Y99.901 E.00663
G1 X88.532 Y100.214 E.00663
G1 X88.475 Y100.531 E.00683
G1 X88.326 Y100.967 E.00975
G1 X88.097 Y101.378 E.00995
G1 X87.798 Y101.741 E.00995
G1 X87.436 Y102.048 E.01004
G1 X86.972 Y102.307 E.01127
G1 X86.443 Y102.473 E.01172
G1 X85.97 Y102.522 E.01008
G1 X85.501 Y102.487 E.00995
G1 X85.04 Y102.367 E.01008
G1 X84.916 Y102.307 E.00292
M204 S250
G1 X85.042 Y101.913 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X84.76 Y101.776 E.00617
G1 X84.403 Y101.499 E.00889
G1 X84.11 Y101.155 E.00888
G1 X83.885 Y100.741 E.00926
G1 X83.768 Y100.361 E.00784
G1 X83.721 Y99.967 E.0078
G1 X83.744 Y99.571 E.0078
G1 X83.838 Y99.186 E.00779
G1 X83.998 Y98.827 E.00774
G1 X84.142 Y98.602 E.00526
G1 X84.312 Y98.395 E.00526
G1 X84.602 Y98.134 E.00767
G1 X84.825 Y97.987 E.00526
G1 X85.065 Y97.867 E.00526
G1 X85.44 Y97.745 E.00776
G1 X85.887 Y97.691 E.00886
G1 X86.356 Y97.731 E.00926
G1 X86.735 Y97.842 E.00778
G1 X86.978 Y97.954 E.00526
G1 X87.206 Y98.095 E.00526
G1 X87.506 Y98.349 E.00773
G1 X87.757 Y98.656 E.0078
G1 X87.95 Y99.002 E.00779
G1 X88.077 Y99.374 E.00773
G1 X88.125 Y99.637 E.00526
G1 X88.141 Y99.901 E.0052
G1 X88.125 Y100.165 E.0052
G1 X88.077 Y100.428 E.00526
G1 X87.95 Y100.8 E.00773
G1 X87.757 Y101.146 E.00779
G1 X87.506 Y101.452 E.0078
G1 X87.202 Y101.71 E.00783
G1 X86.809 Y101.929 E.00886
G1 X86.36 Y102.07 E.00925
G1 X85.964 Y102.111 E.00784
G1 X85.568 Y102.082 E.0078
G1 X85.183 Y101.982 E.00784
G1 X85.096 Y101.939 E.00191
; WIPE_START
M204 S6000
G1 X84.76 Y101.776 E-.07097
G1 X84.403 Y101.499 E-.08584
G1 X84.11 Y101.155 E-.08582
G1 X83.885 Y100.741 E-.0894
G1 X83.811 Y100.5 E-.04797
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X84.691 Y96.12 Z3.96 F18000
G1 Z3.56
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X92.491 Y96.12 E.16509
G1 X92.564 Y95.39 E.01552
G1 X92.6 Y95.272 E.00262
G1 X92.656 Y95.17 E.00246
G1 X92.795 Y95.03 E.00417
G1 X92.9 Y94.972 E.00255
G1 X93.023 Y94.933 E.00272
G1 X93.222 Y94.93 E.00421
G1 X93.322 Y94.955 E.00218
G1 X93.5 Y95.056 E.00432
G1 X93.572 Y95.128 E.00217
G1 X93.631 Y95.212 E.00217
G1 X93.695 Y95.375 E.00371
G1 X93.707 Y95.503 E.00272
G1 X93.689 Y95.647 E.00307
G1 X93.65 Y95.752 E.00236
G1 X93.528 Y95.922 E.00443
G1 X93.39 Y96.018 E.00357
G1 X93.173 Y96.11 E.00498
G1 X92.999 Y96.272 E.00504
G1 X92.866 Y96.364 E.0034
G1 X92.729 Y96.427 E.00321
G1 X92.582 Y96.466 E.00321
G1 X92.404 Y96.482 E.00379
G1 X87.428 Y96.482 E.10532
G1 X88.614 Y97.845 E.03825
G1 X88.721 Y97.992 E.00386
G1 X88.933 Y98.348 E.00877
G1 X89.159 Y98.899 E.0126
G1 X89.286 Y99.489 E.01278
G1 X89.305 Y100.091 E.01273
G1 X89.258 Y100.493 E.00857
G1 X89.102 Y101.071 E.01268
G1 X88.844 Y101.615 E.01273
G1 X88.496 Y102.101 E.01265
G1 X88.213 Y102.394 E.00863
G1 X87.999 Y102.572 E.0059
G1 X87.574 Y102.855 E.01081
G1 X87.203 Y103.032 E.00869
G1 X86.814 Y103.164 E.00869
G1 X86.222 Y103.269 E.01273
G1 X85.63 Y103.267 E.01254
G1 X85.051 Y103.165 E.01244
G1 X84.583 Y102.998 E.01051
G1 X84.118 Y102.753 E.01113
G1 X83.797 Y102.522 E.00836
G1 X83.502 Y102.251 E.00849
G1 X83.24 Y101.947 E.00849
G1 X83.017 Y101.613 E.0085
G1 X82.837 Y101.26 E.00839
G1 X82.675 Y100.8 E.01032
G1 X82.573 Y100.284 E.01112
G1 X82.551 Y99.89 E.00836
G1 X82.576 Y99.49 E.00849
G1 X82.648 Y99.095 E.0085
G1 X82.767 Y98.712 E.00849
G1 X82.93 Y98.345 E.0085
G1 X83.248 Y97.845 E.01253
G1 X84.434 Y96.482 E.03825
G1 X79.467 Y96.482 E.10513
G1 X79.138 Y96.43 E.00704
G1 X79 Y96.365 E.00324
G1 X78.822 Y96.233 E.00469
G1 X78.669 Y96.041 E.0052
G1 X78.579 Y95.812 E.0052
G1 X78.55 Y95.565 E.00527
G1 X78.55 Y77.628 E.37965
G1 X78.588 Y77.349 E.00597
G1 X78.697 Y77.118 E.00539
G1 X78.792 Y76.998 E.00324
G1 X78.906 Y76.896 E.00324
G1 X79.125 Y76.776 E.0053
G1 X79.386 Y76.723 E.00562
G1 X92.45 Y76.722 E.27652
G1 X92.579 Y76.735 E.00274
G1 X92.731 Y76.775 E.00333
G1 X92.96 Y76.904 E.00557
G1 X92.904 Y77.082 E.00395
G1 X79.88 Y77.082 E.27567
G1 X79.604 Y77.127 E.00591
G1 X79.313 Y77.279 E.00696
G1 X79.078 Y77.529 E.00726
G1 X78.948 Y77.807 E.00649
G1 X78.911 Y78.056 E.00533
G1 X78.911 Y95.155 E.36192
G1 X78.964 Y95.453 E.0064
G1 X79.152 Y95.778 E.00796
G1 X79.512 Y96.047 E.00952
G1 X79.867 Y96.12 E.00767
G1 X84.631 Y96.12 E.10084
; WIPE_START
M204 S6000
G1 X86.631 Y96.12 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X83.535 Y96.891 Z3.96 F18000
G1 Z3.56
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X79.443 Y96.891 E.08049
G1 X79.127 Y96.854 E.00625
G1 X78.992 Y96.814 E.00277
G1 X78.789 Y96.719 E.00442
G1 X78.544 Y96.536 E.00601
G1 X78.394 Y96.368 E.00442
G1 X78.248 Y96.114 E.00577
G1 X78.177 Y95.901 E.00442
G1 X78.141 Y95.589 E.00619
G1 X78.141 Y77.61 E.35362
G1 X78.161 Y77.374 E.00466
G1 X78.195 Y77.231 E.00289
G1 X78.245 Y77.093 E.00289
G1 X78.353 Y76.892 E.00448
G1 X78.493 Y76.716 E.00442
G1 X78.661 Y76.567 E.00442
G1 X78.855 Y76.447 E.00448
G1 X79.163 Y76.34 E.00643
G1 X79.358 Y76.313 E.00386
G1 X92.471 Y76.312 E.25792
G1 X92.653 Y76.331 E.0036
G1 X92.871 Y76.389 E.00445
G1 X93.075 Y76.484 E.00442
G1 X93.259 Y76.613 E.00442
G1 X93.418 Y76.772 E.00442
G1 X93.547 Y76.956 E.00442
G1 X93.642 Y77.16 E.00442
G1 X93.7 Y77.377 E.00442
G1 X93.721 Y77.61 E.0046
G1 X93.721 Y85.511 E.1554
G1 X96.001 Y85.511 E.04485
G1 X96.324 Y85.269 E.00794
G1 X96.446 Y85.371 E.00314
G1 F1989.986
G1 X96.577 Y85.479 E.00334
G1 F1320
G1 X96.577 Y87.722 E.04411
G1 F1781.807
G1 X96.446 Y87.831 E.00334
G1 F1500
G1 X96.324 Y87.933 E.00314
G1 X96.001 Y87.691 E.00795
G1 X93.721 Y87.691 E.04485
G1 X93.721 Y88.791 E.02164
G1 X92.541 Y88.791 E.02321
G1 X92.541 Y77.491 E.22226
G1 X79.913 Y77.491 E.24837
G1 X79.736 Y77.52 E.00355
G1 X79.563 Y77.61 E.00382
G1 X79.42 Y77.761 E.00409
G1 X79.344 Y77.925 E.00356
G1 X79.321 Y78.086 E.00319
G1 X79.321 Y95.119 E.33504
G1 X79.354 Y95.311 E.00382
G1 X79.464 Y95.501 E.00431
G1 X79.684 Y95.664 E.0054
G1 X79.909 Y95.711 E.00452
G1 X92.121 Y95.711 E.24019
G1 X92.161 Y95.309 E.00794
G1 X92.222 Y95.111 E.00407
G1 X92.317 Y94.939 E.00387
G1 X92.428 Y94.805 E.00343
G1 X92.561 Y94.692 E.00343
G1 X92.737 Y94.594 E.00397
G1 X92.939 Y94.531 E.00414
G1 X93.112 Y94.512 E.00342
G1 X93.287 Y94.524 E.00345
G1 X93.457 Y94.567 E.00346
G1 X93.617 Y94.64 E.00345
G1 X93.762 Y94.739 E.00345
G1 X93.886 Y94.863 E.00345
G1 X93.987 Y95.007 E.00346
G1 X94.062 Y95.168 E.00349
G1 X94.099 Y95.3 E.0027
G1 X94.119 Y95.51 E.00415
G1 X94.089 Y95.745 E.00466
G1 X94.021 Y95.932 E.00391
G1 X93.911 Y96.109 E.0041
G1 X93.811 Y96.218 E.00291
G1 X93.575 Y96.384 E.00568
G1 X93.399 Y96.459 E.00377
G1 X93.256 Y96.592 E.00384
G1 X93.07 Y96.72 E.00444
G1 X92.868 Y96.814 E.00438
G1 X92.652 Y96.871 E.00438
G1 X92.421 Y96.891 E.00456
G1 X88.326 Y96.891 E.08055
G1 X88.934 Y97.59 E.01823
G1 X89.063 Y97.767 E.0043
G1 X89.295 Y98.157 E.00894
G1 X89.428 Y98.445 E.00623
G1 X89.551 Y98.779 E.007
G1 X89.659 Y99.22 E.00892
G1 X89.692 Y99.44 E.00437
G1 X89.713 Y99.661 E.00437
G1 X89.714 Y100.114 E.00891
G1 X89.662 Y100.562 E.00887
G1 X89.592 Y100.871 E.00624
G1 X89.486 Y101.212 E.00703
G1 X89.362 Y101.505 E.00625
G1 X89.198 Y101.821 E.00703
G1 X89.024 Y102.087 E.00625
G1 X88.806 Y102.369 E.007
G1 X88.492 Y102.694 E.00889
G1 X88.249 Y102.897 E.00623
G1 X87.766 Y103.216 E.01138
G1 X87.358 Y103.412 E.00891
G1 X86.928 Y103.557 E.00891
G1 X86.716 Y103.608 E.0043
G1 X86.265 Y103.676 E.00897
G1 X86.046 Y103.689 E.00431
G1 X85.593 Y103.676 E.00891
G1 X85.145 Y103.608 E.00891
G1 X84.934 Y103.557 E.00428
G1 X84.418 Y103.374 E.01077
G1 X83.902 Y103.102 E.01148
G1 X83.539 Y102.84 E.00881
G1 X83.207 Y102.536 E.00885
G1 X82.914 Y102.195 E.00885
G1 X82.663 Y101.821 E.00885
G1 X82.46 Y101.422 E.00881
G1 X82.279 Y100.908 E.01071
G1 X82.166 Y100.336 E.01147
G1 X82.141 Y99.889 E.00881
G1 X82.169 Y99.44 E.00885
G1 X82.25 Y98.997 E.00885
G1 X82.383 Y98.567 E.00885
G1 X82.566 Y98.156 E.00885
G1 X82.798 Y97.767 E.00891
G1 X82.927 Y97.59 E.0043
G1 X83.496 Y96.936 E.01705
; WIPE_START
M204 S6000
G1 X81.496 Y96.914 E-.38
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




G1 X79.368 Y96.256
G1 Z3.56
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.149508
G1 F1500
M204 S6000
G1 X79.144 Y96.123 E.00161
G1 X78.954 Y95.971 E.00151
G1 X78.879 Y95.851 E.00087
G1 X78.778 Y95.627 E.00152
; WIPE_START
G1 X78.879 Y95.851 E-.1049
G1 X78.954 Y95.971 E-.06024
G1 X79.144 Y96.123 E-.10397
G1 X79.368 Y96.256 E-.11088
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X84.478 Y97.165 Z3.96 F18000
G1 Z3.56
G1 E.4 F1800
; LINE_WIDTH: 0.477108
G1 F1500
M204 S6000
G1 X84.297 Y97.319 E.00534
; LINE_WIDTH: 0.438395
G1 X84.09 Y97.496 E.00562
; LINE_WIDTH: 0.400995
G1 X83.921 Y97.669 E.00453
; LINE_WIDTH: 0.360145
G1 X83.55 Y98.078 E.00921
G1 X83.312 Y98.444 E.00728
G1 X83.125 Y98.846 E.0074
G1 X83.022 Y99.186 E.00593
G1 X82.955 Y99.536 E.00594
G1 X82.934 Y100.005 E.00783
G1 X83.004 Y100.538 E.00896
G1 X83.166 Y101.062 E.00916
G1 X83.349 Y101.418 E.00668
G1 X83.546 Y101.714 E.00594
G1 X83.871 Y102.08 E.00816
G1 X84.318 Y102.43 E.00947
G1 X84.738 Y102.646 E.00787
G1 X85.156 Y102.794 E.00741
G1 X85.454 Y102.858 E.00509
G1 X85.961 Y102.896 E.00848
G1 X86.186 Y102.886 E.00375
G1 X86.712 Y102.792 E.00893
G1 X87.136 Y102.647 E.00747
G1 X87.637 Y102.364 E.00959
G1 X87.952 Y102.113 E.00673
G1 X88.204 Y101.852 E.00605
G1 X88.512 Y101.42 E.00885
G1 X88.673 Y101.106 E.00589
G1 X88.83 Y100.667 E.00779
G1 X88.881 Y100.429 E.00406
G1 X88.923 Y100.071 E.006
G1 X88.908 Y99.536 E.00894
G1 X88.791 Y99.012 E.00895
G1 X88.592 Y98.526 E.00876
G1 X88.398 Y98.201 E.00631
G1 X88.058 Y97.784 E.00898
; LINE_WIDTH: 0.378795
G1 X87.881 Y97.609 E.00438
; LINE_WIDTH: 0.41929
G1 X87.678 Y97.411 E.00557
; LINE_WIDTH: 0.468117
G1 X87.38 Y97.162 E.00858
; WIPE_START
G1 X87.678 Y97.411 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X92.702 Y96.139 Z3.96 F18000
G1 Z3.56
G1 E.4 F1800
; LINE_WIDTH: 0.111373
G1 F1500
M204 S6000
G1 X92.949 Y95.998 E.00121
; WIPE_START
G1 X92.702 Y96.139 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X93.407 Y88.539 Z3.96 F18000
G1 X93.586 Y86.601 Z3.96
G1 Z3.56
G1 E.4 F1800
; LINE_WIDTH: 0.114562
G1 F1500
M204 S6000
G1 X95.531 Y86.601 E.00862
; WIPE_START
G1 X93.586 Y86.601 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X87.279 Y82.303 Z3.96 F18000
G1 X79.431 Y76.955 Z3.96
G1 Z3.56
G1 E.4 F1800
; LINE_WIDTH: 0.0801301
G1 F1500
M204 S6000
G1 X79.403 Y76.962 E.00008
; LINE_WIDTH: 0.094321
G1 X79.309 Y76.995 E.00034
; LINE_WIDTH: 0.127921
G1 X79.143 Y77.07 E.00093
; LINE_WIDTH: 0.154209
G1 X79.002 Y77.192 E.00119
G1 X78.854 Y77.387 E.00157
; LINE_WIDTH: 0.106112
G1 X78.788 Y77.595 E.00087
; CHANGE_LAYER
; Z_HEIGHT: 3.68
; LAYER_HEIGHT: 0.12
; WIPE_START
M73 P74 R6
G1 F1500
G1 X78.854 Y77.387 E-.38
; WIPE_END
G1 E-.02 F1800
; layer num/total_layer_count: 30/49
; update layer progress
M73 L30
M991 S0 P29 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z3.96 I-.566 J1.077 P1  F18000
G1 X95.887 Y86.344 Z3.96
G1 Z3.68
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X95.887 Y86.857 E.01086
G1 X93.374 Y86.857 E.05319
G1 X93.374 Y86.344 E.01086
G1 X95.827 Y86.344 E.05192
M204 S10000
G1 X96.311 Y85.789 F18000
G1 F1500
M204 S500
G1 X96.311 Y87.412 E.03435
G1 X96.137 Y87.282 E.00461
G1 X93.311 Y87.282 E.05981
G1 X93.311 Y88.382 E.02328
G1 X92.95 Y88.382 E.00765
G1 X92.95 Y77.127 E.23821
G1 X93.128 Y77.071 E.00395
G1 X93.191 Y77.162 E.00234
G1 X93.256 Y77.3 E.00324
G1 X93.296 Y77.448 E.00324
G1 X93.311 Y77.628 E.00382
G1 X93.311 Y85.92 E.17551
G1 X96.137 Y85.92 E.05981
G1 X96.263 Y85.825 E.00334
; WIPE_START
M204 S6000
G1 X96.311 Y87.412 E-.30164
G1 X96.137 Y87.282 E-.04139
G1 X95.942 Y87.282 E-.03697
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X93.571 Y94.536 Z4.08 F18000
G1 X93.274 Y95.442 Z4.08
G1 Z3.68
G1 E.4 F1800
G1 F1500
M204 S500
G1 X93.273 Y95.556 E.00243
G1 X93.236 Y95.616 E.00149
G1 X93.196 Y95.64 E.00097
G1 X92.955 Y95.741 E.00554
G1 X92.993 Y95.438 E.00646
G1 X93.019 Y95.391 E.00113
G1 X93.07 Y95.363 E.00122
G1 X93.154 Y95.35 E.00181
G1 X93.228 Y95.384 E.00171
G1 X93.237 Y95.395 E.00031
; WIPE_START
M204 S6000
G1 X93.273 Y95.556 E-.05507
G1 X93.236 Y95.616 E-.0234
G1 X93.196 Y95.64 E-.01525
G1 X92.955 Y95.741 E-.08719
G1 X92.993 Y95.438 E-.10169
G1 X93.019 Y95.391 E-.01785
G1 X93.07 Y95.363 E-.01928
G1 X93.154 Y95.35 E-.0285
G1 X93.228 Y95.384 E-.02691
G1 X93.237 Y95.395 E-.00486
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X86.591 Y96.544 Z4.08 F18000
G1 Z3.68
G1 E.4 F1800
G1 F1500
M204 S500
G1 X86.951 Y96.544 E.00764
G1 X87.311 Y96.97 E.0118
G1 X87.187 Y97.133 E.00433
G1 X87.029 Y97.06 E.00369
G1 X86.51 Y96.908 E.01145
G1 X85.869 Y96.853 E.0136
G1 X85.259 Y96.927 E.01301
G1 X84.712 Y97.105 E.01217
G1 X84.606 Y96.943 E.00411
G1 X84.957 Y96.544 E.01124
G1 X86.531 Y96.544 E.0333
; WIPE_START
M204 S6000
G1 X86.951 Y96.544 E-.07996
G1 X87.311 Y96.97 E-.10592
G1 X87.187 Y97.133 E-.03883
G1 X87.029 Y97.06 E-.0331
G1 X86.51 Y96.908 E-.10283
G1 X86.408 Y96.899 E-.01937
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X84.84 Y102.279 Z4.08 F18000
G1 Z3.68
G1 E.4 F1800
G1 F1500
M204 S500
G1 X84.486 Y102.089 E.0085
G1 X84.119 Y101.796 E.00995
G1 X83.807 Y101.439 E.01004
G1 X83.541 Y100.98 E.01121
G1 X83.367 Y100.452 E.01177
G1 X83.31 Y99.979 E.01008
G1 X83.338 Y99.51 E.00995
G1 X83.449 Y99.054 E.00994
G1 X83.637 Y98.633 E.00976
G1 X83.811 Y98.361 E.00683
G1 X84.016 Y98.111 E.00683
G1 X84.351 Y97.809 E.00956
G1 X84.62 Y97.632 E.00683
G1 X84.909 Y97.487 E.00683
G1 X85.351 Y97.344 E.00984
G1 X85.877 Y97.28 E.01121
G1 X86.431 Y97.327 E.01177
G1 X86.88 Y97.458 E.00988
G1 X87.172 Y97.593 E.00683
G1 X87.447 Y97.763 E.00683
G1 X87.798 Y98.061 E.00975
G1 X88.091 Y98.417 E.00975
G1 X88.256 Y98.694 E.00683
G1 X88.388 Y98.989 E.00683
G1 X88.51 Y99.433 E.00975
G1 X88.551 Y99.892 E.00975
G1 X88.532 Y100.214 E.00683
G1 X88.475 Y100.531 E.00683
G1 X88.326 Y100.967 E.00975
G1 X88.097 Y101.378 E.00995
G1 X87.798 Y101.741 E.00995
G1 X87.447 Y102.039 E.00976
G1 X87.172 Y102.208 E.00683
G1 X86.88 Y102.344 E.00683
G1 X86.437 Y102.473 E.00975
G1 X85.965 Y102.523 E.01004
G1 X85.438 Y102.476 E.01121
G1 X84.906 Y102.315 E.01177
G1 X84.893 Y102.308 E.00031
M204 S250
G1 X85.034 Y101.919 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X84.713 Y101.746 E.00718
G1 X84.403 Y101.499 E.0078
G1 X84.141 Y101.199 E.00783
G1 X83.917 Y100.812 E.00881
G1 X83.768 Y100.363 E.0093
G1 X83.721 Y99.967 E.00784
G1 X83.744 Y99.571 E.0078
G1 X83.838 Y99.186 E.00779
G1 X83.998 Y98.827 E.00774
G1 X84.142 Y98.602 E.00526
G1 X84.312 Y98.395 E.00526
G1 X84.602 Y98.134 E.00767
G1 X84.825 Y97.987 E.00526
G1 X85.065 Y97.867 E.00526
G1 X85.44 Y97.745 E.00776
G1 X85.885 Y97.691 E.00881
G1 X86.356 Y97.731 E.0093
G1 X86.735 Y97.842 E.00778
G1 X86.978 Y97.954 E.00526
G1 X87.206 Y98.095 E.00526
G1 X87.506 Y98.349 E.00773
G1 X87.755 Y98.653 E.00773
G1 X87.892 Y98.883 E.00526
G1 X88.001 Y99.127 E.00526
G1 X88.106 Y99.506 E.00774
G1 X88.141 Y99.898 E.00773
G1 X88.125 Y100.165 E.00526
G1 X88.077 Y100.428 E.00526
G1 X87.95 Y100.8 E.00773
G1 X87.757 Y101.146 E.00779
G1 X87.506 Y101.452 E.00779
G1 X87.205 Y101.707 E.00774
G1 X86.978 Y101.847 E.00526
G1 X86.735 Y101.96 E.00526
G1 X86.358 Y102.07 E.00774
G1 X85.962 Y102.112 E.00783
G1 X85.516 Y102.072 E.00881
G1 X85.089 Y101.943 E.00878
; WIPE_START
M204 S6000
G1 X84.713 Y101.746 E-.08064
G1 X84.403 Y101.499 E-.07531
G1 X84.141 Y101.199 E-.07561
G1 X83.917 Y100.812 E-.08507
G1 X83.812 Y100.495 E-.06337
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X84.709 Y96.12 Z4.08 F18000
G1 Z3.68
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X92.491 Y96.12 E.16472
G1 X92.564 Y95.391 E.0155
G1 X92.601 Y95.272 E.00265
G1 X92.656 Y95.171 E.00244
G1 X92.795 Y95.031 E.00417
G1 X92.901 Y94.971 E.00258
G1 X93.022 Y94.933 E.00269
G1 X93.221 Y94.93 E.00421
G1 X93.321 Y94.955 E.00218
G1 X93.499 Y95.055 E.00433
G1 X93.572 Y95.128 E.00218
G1 X93.631 Y95.212 E.00217
G1 X93.695 Y95.376 E.00372
G1 X93.707 Y95.503 E.0027
G1 X93.689 Y95.647 E.00307
G1 X93.65 Y95.753 E.00239
G1 X93.527 Y95.922 E.00443
G1 X93.389 Y96.019 E.00358
G1 X93.173 Y96.11 E.00496
G1 X92.999 Y96.272 E.00504
G1 X92.866 Y96.364 E.0034
G1 X92.729 Y96.427 E.00321
G1 X92.582 Y96.466 E.00321
G1 X92.404 Y96.482 E.00378
G1 X87.454 Y96.482 E.10477
G1 X88.652 Y97.901 E.03933
G1 X88.933 Y98.351 E.01122
G1 X89.098 Y98.72 E.00855
G1 X89.257 Y99.3 E.01273
G1 X89.286 Y99.49 E.00406
G1 X89.305 Y100.086 E.01263
G1 X89.242 Y100.565 E.01023
G1 X89.098 Y101.079 E.01131
G1 X88.848 Y101.607 E.01236
G1 X88.571 Y102.007 E.01028
G1 X88.208 Y102.398 E.01131
G1 X88.002 Y102.57 E.00567
G1 X87.574 Y102.855 E.0109
G1 X87.203 Y103.032 E.00868
G1 X86.814 Y103.164 E.00869
G1 X86.222 Y103.269 E.01273
G1 X85.63 Y103.267 E.01254
G1 X85.051 Y103.165 E.01244
G1 X84.587 Y103 E.01042
G1 X84.118 Y102.753 E.01122
G1 X83.797 Y102.522 E.00836
G1 X83.502 Y102.251 E.00849
G1 X83.24 Y101.947 E.00849
G1 X83.017 Y101.613 E.00849
G1 X82.836 Y101.26 E.0084
G1 X82.676 Y100.804 E.01022
G1 X82.573 Y100.284 E.01122
G1 X82.551 Y99.89 E.00836
G1 X82.576 Y99.49 E.00849
G1 X82.648 Y99.095 E.0085
G1 X82.767 Y98.712 E.00849
G1 X82.93 Y98.345 E.00849
G1 X83.138 Y97.997 E.00857
G1 X83.302 Y97.778 E.0058
G1 X84.447 Y96.482 E.03659
G1 X79.467 Y96.482 E.10541
G1 X79.219 Y96.453 E.00527
G1 X79.074 Y96.405 E.00324
G1 X78.88 Y96.286 E.00482
G1 X78.729 Y96.131 E.00457
G1 X78.654 Y96.012 E.00299
G1 X78.58 Y95.821 E.00432
G1 X78.55 Y95.565 E.00546
G1 X78.55 Y77.628 E.37965
G1 X78.586 Y77.357 E.00578
G1 X78.646 Y77.207 E.00343
G1 X78.731 Y77.069 E.00343
G1 X78.906 Y76.896 E.0052
G1 X79.121 Y76.778 E.0052
G1 X79.379 Y76.723 E.00558
G1 X92.452 Y76.722 E.27668
G1 X92.579 Y76.735 E.00271
G1 X92.731 Y76.775 E.00334
G1 X92.96 Y76.904 E.00557
G1 X92.904 Y77.082 E.00395
G1 X79.88 Y77.082 E.27568
G1 X79.603 Y77.127 E.00593
G1 X79.313 Y77.279 E.00695
G1 X79.077 Y77.529 E.00726
G1 X78.948 Y77.807 E.00649
G1 X78.911 Y78.056 E.00533
G1 X78.911 Y95.155 E.36192
G1 X78.964 Y95.453 E.0064
G1 X79.152 Y95.778 E.00796
G1 X79.512 Y96.047 E.00951
G1 X79.867 Y96.12 E.00768
G1 X84.649 Y96.12 E.10121
; WIPE_START
M204 S6000
G1 X86.649 Y96.12 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X83.54 Y96.891 Z4.08 F18000
G1 Z3.68
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X79.443 Y96.891 E.08058
G1 X79.13 Y96.854 E.00619
G1 X78.917 Y96.784 E.00442
G1 X78.625 Y96.607 E.00673
G1 X78.397 Y96.373 E.00641
G1 X78.292 Y96.205 E.00389
G1 X78.177 Y95.904 E.00633
G1 X78.141 Y95.589 E.00625
G1 X78.141 Y77.61 E.35362
G1 X78.161 Y77.374 E.00466
G1 X78.194 Y77.234 E.00283
G1 X78.278 Y77.022 E.00448
G1 X78.398 Y76.828 E.00448
G1 X78.491 Y76.718 E.00283
G1 X78.661 Y76.567 E.00448
G1 X78.855 Y76.447 E.00448
G1 X78.987 Y76.39 E.00283
G1 X79.21 Y76.33 E.00454
G1 X79.356 Y76.313 E.00289
G1 X92.472 Y76.312 E.258
G1 X92.653 Y76.331 E.00357
G1 X92.871 Y76.389 E.00445
G1 X93.075 Y76.484 E.00442
G1 X93.259 Y76.613 E.00442
G1 X93.418 Y76.772 E.00442
G1 X93.547 Y76.956 E.00442
G1 X93.642 Y77.16 E.00442
G1 X93.7 Y77.377 E.00442
G1 X93.721 Y77.61 E.0046
G1 X93.721 Y85.511 E.1554
G1 X96.001 Y85.511 E.04485
G1 X96.324 Y85.269 E.00794
G1 X96.618 Y85.514 E.00753
G1 F1880.221
G1 X96.721 Y85.599 E.00263
G1 F1680
G1 X96.721 Y87.603 E.0394
G1 F2081.157
G1 X96.618 Y87.688 E.00263
G1 F1500
G1 X96.324 Y87.933 E.00753
G1 X96.001 Y87.691 E.00794
G1 X93.721 Y87.691 E.04485
G1 X93.721 Y88.791 E.02164
G1 X92.541 Y88.791 E.02321
G1 X92.541 Y77.491 E.22226
G1 X79.913 Y77.491 E.24837
G1 X79.735 Y77.52 E.00355
G1 X79.563 Y77.61 E.00381
G1 X79.42 Y77.762 E.00409
G1 X79.344 Y77.925 E.00355
G1 X79.321 Y78.086 E.00319
G1 X79.321 Y95.119 E.33504
G1 X79.354 Y95.311 E.00382
G1 X79.464 Y95.5 E.00431
G1 X79.684 Y95.664 E.0054
G1 X79.909 Y95.711 E.00452
G1 X92.121 Y95.711 E.24019
G1 X92.161 Y95.31 E.00792
G1 X92.222 Y95.111 E.0041
G1 X92.316 Y94.939 E.00385
G1 X92.428 Y94.805 E.00343
G1 X92.561 Y94.693 E.00343
G1 X92.738 Y94.593 E.004
G1 X92.938 Y94.531 E.00412
G1 X93.111 Y94.512 E.00342
G1 X93.286 Y94.524 E.00345
G1 X93.457 Y94.567 E.00346
G1 X93.617 Y94.639 E.00345
G1 X93.761 Y94.739 E.00345
G1 X93.886 Y94.863 E.00346
G1 X93.987 Y95.006 E.00346
G1 X94.062 Y95.167 E.00348
G1 X94.099 Y95.301 E.00273
G1 X94.119 Y95.509 E.00412
G1 X94.089 Y95.744 E.00466
G1 X94.02 Y95.933 E.00394
G1 X93.911 Y96.109 E.00407
G1 X93.811 Y96.219 E.00293
G1 X93.574 Y96.385 E.00568
G1 X93.399 Y96.459 E.00375
G1 X93.256 Y96.592 E.00384
G1 X93.07 Y96.72 E.00444
G1 X92.868 Y96.814 E.00438
G1 X92.652 Y96.871 E.00438
G1 X92.421 Y96.891 E.00456
G1 X88.335 Y96.891 E.08038
G1 X88.984 Y97.659 E.01979
G1 X89.296 Y98.158 E.01157
G1 X89.479 Y98.57 E.00887
G1 X89.55 Y98.777 E.00431
G1 X89.659 Y99.22 E.00897
G1 X89.692 Y99.44 E.00437
G1 X89.713 Y99.661 E.00437
G1 X89.714 Y100.112 E.00888
G1 X89.644 Y100.647 E.01062
G1 X89.485 Y101.215 E.01159
G1 X89.364 Y101.5 E.0061
G1 X89.199 Y101.819 E.00706
G1 X88.891 Y102.264 E.01064
G1 X88.49 Y102.695 E.01159
G1 X88.252 Y102.894 E.0061
G1 X87.766 Y103.216 E.01147
G1 X87.358 Y103.412 E.00891
G1 X86.928 Y103.557 E.00891
G1 X86.716 Y103.608 E.0043
G1 X86.265 Y103.676 E.00897
G1 X86.046 Y103.689 E.00431
G1 X85.593 Y103.676 E.00891
G1 X85.145 Y103.608 E.00891
G1 X84.934 Y103.557 E.00427
G1 X84.423 Y103.376 E.01068
G1 X83.902 Y103.102 E.01157
G1 X83.539 Y102.84 E.00881
G1 X83.207 Y102.536 E.00885
G1 X82.914 Y102.195 E.00885
G1 X82.663 Y101.821 E.00885
G1 X82.46 Y101.422 E.00882
G1 X82.28 Y100.913 E.01062
G1 X82.166 Y100.336 E.01157
G1 X82.141 Y99.889 E.00881
G1 X82.169 Y99.44 E.00885
G1 X82.25 Y98.997 E.00885
G1 X82.383 Y98.567 E.00885
G1 X82.566 Y98.156 E.00885
G1 X82.798 Y97.769 E.00888
G1 X82.985 Y97.519 E.00614
G1 X83.5 Y96.936 E.0153
; WIPE_START
M204 S6000
G1 X81.5 Y96.914 E-.38
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
M73 P75 R6
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




G1 X79.315 Y96.244
G1 Z3.68
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.15143
G1 F1500
M204 S6000
G1 X78.992 Y96.008 E.00251
G1 X78.856 Y95.803 E.00154
; LINE_WIDTH: 0.123888
G1 X78.824 Y95.713 E.00047
; LINE_WIDTH: 0.0937062
G1 X78.792 Y95.622 E.00033
; WIPE_START
G1 X78.824 Y95.713 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X84.489 Y97.151 Z4.08 F18000
G1 Z3.68
G1 E.4 F1800
; LINE_WIDTH: 0.470767
G1 F1500
M204 S6000
G1 X84.301 Y97.314 E.00552
; LINE_WIDTH: 0.433849
G1 X84.092 Y97.497 E.00566
; LINE_WIDTH: 0.399199
G1 X83.921 Y97.669 E.00451
; LINE_WIDTH: 0.359968
G1 X83.598 Y98.019 E.00793
G1 X83.311 Y98.443 E.00855
G1 X83.125 Y98.846 E.0074
G1 X83.022 Y99.186 E.00593
G1 X82.955 Y99.536 E.00594
G1 X82.934 Y100.005 E.00783
G1 X83.006 Y100.549 E.00915
G1 X83.185 Y101.11 E.00982
G1 X83.35 Y101.418 E.00582
G1 X83.544 Y101.716 E.00593
G1 X83.869 Y102.078 E.00812
G1 X84.291 Y102.412 E.00897
G1 X84.746 Y102.656 E.00861
G1 X85.156 Y102.793 E.00721
G1 X85.383 Y102.845 E.00388
G1 X85.664 Y102.883 E.00473
G1 X85.953 Y102.896 E.00482
G1 X86.186 Y102.886 E.00388
G1 X86.495 Y102.842 E.00521
G1 X87.001 Y102.702 E.00875
G1 X87.361 Y102.537 E.0066
G1 X87.657 Y102.349 E.00585
G1 X87.944 Y102.12 E.00612
G1 X88.272 Y101.766 E.00805
G1 X88.517 Y101.412 E.00718
G1 X88.673 Y101.106 E.00572
G1 X88.834 Y100.637 E.00827
G1 X88.906 Y100.249 E.00659
G1 X88.928 Y99.874 E.00626
G1 X88.885 Y99.372 E.0084
G1 X88.79 Y99.006 E.0063
G1 X88.597 Y98.527 E.0086
G1 X88.344 Y98.126 E.00791
G1 X88.058 Y97.784 E.00743
; LINE_WIDTH: 0.379973
G1 X87.882 Y97.608 E.0044
; LINE_WIDTH: 0.424071
G1 X87.683 Y97.411 E.00557
; LINE_WIDTH: 0.468512
G1 X87.417 Y97.181 E.00776
; WIPE_START
G1 X87.683 Y97.411 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X92.703 Y96.139 Z4.08 F18000
G1 Z3.68
G1 E.4 F1800
; LINE_WIDTH: 0.111501
G1 F1500
M204 S6000
G1 X92.949 Y95.998 E.00121
; WIPE_START
G1 X92.703 Y96.139 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X93.407 Y88.539 Z4.08 F18000
G1 X93.586 Y86.601 Z4.08
G1 Z3.68
G1 E.4 F1800
; LINE_WIDTH: 0.114562
G1 F1500
M204 S6000
G1 X95.675 Y86.601 E.00925
; WIPE_START
G1 X93.675 Y86.601 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X87.355 Y82.321 Z4.08 F18000
G1 X79.43 Y76.955 Z4.08
G1 Z3.68
G1 E.4 F1800
; LINE_WIDTH: 0.0820032
G1 F1500
M204 S6000
G1 X79.395 Y76.964 E.0001
; LINE_WIDTH: 0.0972363
G1 X79.303 Y76.997 E.00035
; LINE_WIDTH: 0.128681
G1 X79.142 Y77.07 E.0009
; LINE_WIDTH: 0.15624
G1 X78.993 Y77.201 E.00129
G1 X78.855 Y77.387 E.00151
; LINE_WIDTH: 0.105119
G1 X78.788 Y77.595 E.00086
; CHANGE_LAYER
; Z_HEIGHT: 3.8
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F1500
G1 X78.855 Y77.387 E-.38
; WIPE_END
G1 E-.02 F1800
; layer num/total_layer_count: 31/49
; update layer progress
M73 L31
M991 S0 P30 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z4.08 I-.566 J1.077 P1  F18000
G1 X95.887 Y86.344 Z4.08
G1 Z3.8
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X95.887 Y86.857 E.01086
G1 X93.374 Y86.857 E.05319
G1 X93.374 Y86.344 E.01086
G1 X95.827 Y86.344 E.05192
M204 S10000
G1 X96.311 Y85.789 F18000
G1 F1500
M204 S500
G1 X96.311 Y87.412 E.03435
G1 X96.137 Y87.282 E.00461
G1 X93.311 Y87.282 E.05981
G1 X93.311 Y88.382 E.02328
G1 X92.95 Y88.382 E.00765
G1 X92.95 Y77.127 E.23821
G1 X93.128 Y77.071 E.00395
G1 X93.191 Y77.162 E.00234
G1 X93.256 Y77.301 E.00324
G1 X93.296 Y77.448 E.00324
G1 X93.311 Y77.628 E.00382
G1 X93.311 Y85.92 E.17551
G1 X96.137 Y85.92 E.05981
G1 X96.263 Y85.825 E.00334
; WIPE_START
M204 S6000
G1 X96.311 Y87.412 E-.30164
G1 X96.137 Y87.282 E-.04139
G1 X95.942 Y87.282 E-.03697
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X93.556 Y94.532 Z4.2 F18000
G1 X93.263 Y95.425 Z4.2
G1 Z3.8
G1 E.4 F1800
G1 F1500
M204 S500
G1 X93.281 Y95.495 E.00154
G1 X93.273 Y95.556 E.00131
G1 X93.236 Y95.616 E.00148
G1 X93.196 Y95.64 E.00099
G1 X92.955 Y95.741 E.00552
G1 X92.993 Y95.438 E.00647
G1 X93.019 Y95.391 E.00112
G1 X93.071 Y95.362 E.00126
G1 X93.154 Y95.35 E.00178
G1 X93.222 Y95.381 E.00158
; WIPE_START
M204 S6000
G1 X93.281 Y95.495 E-.04254
G1 X93.273 Y95.556 E-.02057
G1 X93.236 Y95.616 E-.02319
G1 X93.196 Y95.64 E-.01558
G1 X92.955 Y95.741 E-.08658
G1 X92.993 Y95.438 E-.1015
G1 X93.019 Y95.391 E-.01754
G1 X93.071 Y95.362 E-.01975
G1 X93.154 Y95.35 E-.02796
G1 X93.222 Y95.381 E-.02478
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X85.742 Y96.898 Z4.2 F18000
G1 X84.696 Y97.11 Z4.2
G1 Z3.8
G1 E.4 F1800
G1 F1500
M204 S500
G1 X84.589 Y96.949 E.0041
G1 X84.941 Y96.544 E.01135
G1 X86.92 Y96.544 E.04188
G1 X87.269 Y96.946 E.01127
G1 X87.139 Y97.112 E.00445
G1 X87.051 Y97.066 E.00211
G1 X86.535 Y96.915 E.01137
G1 X86.162 Y96.865 E.00797
G1 X85.834 Y96.857 E.00694
G1 X85.259 Y96.927 E.01226
G1 X84.753 Y97.092 E.01126
; WIPE_START
M204 S6000
G1 X84.589 Y96.949 E-.04131
G1 X84.941 Y96.544 E-.10189
G1 X86.188 Y96.544 E-.2368
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X84.84 Y102.279 Z4.2 F18000
G1 Z3.8
G1 E.4 F1800
G1 F1500
M204 S500
G1 X84.486 Y102.089 E.0085
G1 X84.119 Y101.796 E.00996
G1 X83.81 Y101.442 E.00994
G1 X83.573 Y101.046 E.00975
G1 X83.451 Y100.748 E.00683
G1 X83.365 Y100.437 E.00683
G1 X83.31 Y99.979 E.00975
G1 X83.338 Y99.506 E.01004
G1 X83.465 Y99.014 E.01075
G1 X83.571 Y98.762 E.00579
G1 X83.727 Y98.482 E.00678
G1 X84.009 Y98.118 E.00975
G1 X84.351 Y97.809 E.00975
G1 X84.62 Y97.632 E.00683
G1 X84.909 Y97.487 E.00683
G1 X85.351 Y97.344 E.00984
G1 X85.855 Y97.282 E.01075
G1 X86.129 Y97.288 E.00579
G1 X86.446 Y97.331 E.00679
G1 X86.892 Y97.462 E.00983
G1 X87.343 Y97.695 E.01075
G1 X87.566 Y97.854 E.00579
G1 X87.807 Y98.071 E.00687
G1 X88.119 Y98.46 E.01055
G1 X88.257 Y98.696 E.00579
G1 X88.388 Y98.989 E.00678
G1 X88.51 Y99.433 E.00975
G1 X88.551 Y99.892 E.00975
G1 X88.532 Y100.212 E.00678
G1 X88.485 Y100.481 E.00579
G1 X88.328 Y100.964 E.01075
G1 X88.097 Y101.378 E.01003
G1 X87.798 Y101.741 E.00995
G1 X87.44 Y102.045 E.00995
G1 X87.041 Y102.275 E.00975
G1 X86.742 Y102.392 E.00679
G1 X86.478 Y102.463 E.00579
G1 X85.983 Y102.522 E.01055
G1 X85.657 Y102.507 E.00691
G1 X85.338 Y102.454 E.00684
G1 X84.9 Y102.312 E.00975
G1 X84.893 Y102.308 E.00018
M204 S250
G1 X85.034 Y101.919 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X84.713 Y101.746 E.00717
G1 X84.403 Y101.499 E.0078
G1 X84.142 Y101.2 E.00779
G1 X83.94 Y100.863 E.00773
G1 X83.839 Y100.615 E.00526
G1 X83.768 Y100.357 E.00526
G1 X83.721 Y99.967 E.00773
G1 X83.745 Y99.57 E.00783
G1 X83.854 Y99.145 E.00863
G1 X83.94 Y98.941 E.00435
G1 X84.069 Y98.708 E.00524
G1 X84.31 Y98.397 E.00773
G1 X84.602 Y98.134 E.00774
G1 X84.825 Y97.987 E.00526
G1 X85.065 Y97.867 E.00526
G1 X85.44 Y97.745 E.00776
G1 X85.875 Y97.692 E.00863
G1 X86.096 Y97.697 E.00435
G1 X86.361 Y97.733 E.00525
G1 X86.74 Y97.843 E.00776
G1 X87.129 Y98.045 E.00863
G1 X87.309 Y98.173 E.00435
G1 X87.509 Y98.353 E.00527
G1 X87.781 Y98.693 E.00857
G1 X87.893 Y98.883 E.00435
G1 X88.001 Y99.127 E.00525
G1 X88.106 Y99.506 E.00774
G1 X88.141 Y99.898 E.00773
G1 X88.125 Y100.164 E.00525
G1 X88.087 Y100.382 E.00435
G1 X87.951 Y100.799 E.00863
G1 X87.757 Y101.146 E.00782
G1 X87.506 Y101.452 E.0078
G1 X87.203 Y101.709 E.0078
G1 X86.863 Y101.905 E.00773
G1 X86.614 Y102.003 E.00525
G1 X86.401 Y102.06 E.00435
G1 X85.968 Y102.111 E.00857
G1 X85.7 Y102.099 E.00529
G1 X85.435 Y102.055 E.00527
G1 X85.089 Y101.943 E.00717
; WIPE_START
M204 S6000
G1 X84.713 Y101.746 E-.08059
G1 X84.403 Y101.499 E-.07536
G1 X84.142 Y101.2 E-.07527
G1 X83.94 Y100.863 E-.0747
G1 X83.839 Y100.615 E-.05083
G1 X83.806 Y100.497 E-.02325
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X84.691 Y96.12 Z4.2 F18000
G1 Z3.8
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X92.491 Y96.12 E.16509
G1 X92.564 Y95.392 E.01549
G1 X92.601 Y95.271 E.00267
G1 X92.656 Y95.171 E.00242
G1 X92.794 Y95.031 E.00416
G1 X92.903 Y94.971 E.00263
G1 X93.022 Y94.933 E.00264
G1 X93.221 Y94.93 E.00423
G1 X93.321 Y94.955 E.00218
G1 X93.499 Y95.055 E.00433
G1 X93.572 Y95.128 E.00218
G1 X93.631 Y95.212 E.00217
G1 X93.695 Y95.377 E.00376
G1 X93.707 Y95.502 E.00265
G1 X93.689 Y95.646 E.00307
G1 X93.649 Y95.754 E.00243
G1 X93.527 Y95.923 E.00442
G1 X93.388 Y96.019 E.00358
G1 X93.179 Y96.107 E.00479
G1 X92.871 Y96.362 E.00846
G1 X92.729 Y96.427 E.00331
G1 X92.582 Y96.466 E.00321
G1 X92.404 Y96.482 E.00378
G1 X87.428 Y96.482 E.10532
G1 X88.608 Y97.838 E.03805
G1 X88.927 Y98.337 E.01254
G1 X89.098 Y98.72 E.00888
G1 X89.257 Y99.3 E.01273
G1 X89.286 Y99.49 E.00406
G1 X89.305 Y100.086 E.01263
G1 X89.242 Y100.57 E.01034
G1 X89.104 Y101.065 E.01087
G1 X88.845 Y101.611 E.01279
G1 X88.621 Y101.947 E.00854
G1 X88.223 Y102.385 E.01254
G1 X87.897 Y102.65 E.00888
G1 X87.573 Y102.855 E.00811
G1 X87.203 Y103.032 E.00868
G1 X86.814 Y103.164 E.00869
G1 X86.222 Y103.269 E.01273
G1 X85.63 Y103.267 E.01254
G1 X85.051 Y103.165 E.01245
G1 X84.582 Y102.998 E.01053
G1 X84.131 Y102.762 E.01079
G1 X83.797 Y102.522 E.00869
G1 X83.502 Y102.251 E.00849
G1 X83.24 Y101.947 E.00849
G1 X83.019 Y101.617 E.0084
G1 X82.803 Y101.179 E.01033
G1 X82.646 Y100.699 E.01069
G1 X82.566 Y100.208 E.01053
G1 X82.556 Y99.699 E.01079
G1 X82.606 Y99.291 E.00869
G1 X82.702 Y98.901 E.00849
G1 X82.843 Y98.526 E.00849
G1 X83.028 Y98.17 E.0085
G1 X83.254 Y97.838 E.00849
G1 X84.433 Y96.482 E.03805
G1 X79.467 Y96.482 E.10513
G1 X79.219 Y96.453 E.00527
G1 X79.074 Y96.405 E.00324
G1 X78.913 Y96.312 E.00394
G1 X78.729 Y96.131 E.00545
G1 X78.653 Y96.01 E.00302
G1 X78.58 Y95.821 E.00429
G1 X78.55 Y95.565 E.00546
G1 X78.55 Y77.628 E.37965
G1 X78.587 Y77.353 E.00588
G1 X78.695 Y77.12 E.00543
G1 X78.879 Y76.917 E.0058
G1 X78.989 Y76.841 E.00283
G1 X79.134 Y76.773 E.0034
G1 X79.386 Y76.723 E.00543
G1 X92.453 Y76.722 E.27658
G1 X92.578 Y76.735 E.00266
G1 X92.731 Y76.775 E.00334
G1 X92.96 Y76.904 E.00557
G1 X92.904 Y77.082 E.00395
G1 X79.876 Y77.082 E.27575
G1 X79.588 Y77.133 E.0062
G1 X79.31 Y77.282 E.00669
G1 X79.077 Y77.529 E.00717
G1 X78.948 Y77.807 E.00648
G1 X78.911 Y78.056 E.00533
G1 X78.911 Y95.155 E.36192
G1 X78.964 Y95.453 E.0064
G1 X79.147 Y95.77 E.00776
G1 X79.475 Y96.029 E.00884
G1 X79.858 Y96.12 E.00834
G1 X84.631 Y96.12 E.10103
; WIPE_START
M204 S6000
G1 X86.631 Y96.12 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X83.535 Y96.891 Z4.2 F18000
G1 Z3.8
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X79.443 Y96.891 E.08049
G1 X79.13 Y96.854 E.00619
G1 X78.917 Y96.784 E.00442
G1 X78.786 Y96.718 E.00289
G1 X78.663 Y96.637 E.00289
G1 X78.491 Y96.484 E.00454
G1 X78.291 Y96.204 E.00675
G1 X78.177 Y95.904 E.0063
G1 X78.141 Y95.589 E.00625
G1 X78.141 Y77.61 E.35362
G1 X78.161 Y77.374 E.00466
G1 X78.195 Y77.232 E.00286
G1 X78.258 Y77.065 E.00352
G1 X78.353 Y76.893 E.00386
G1 X78.494 Y76.715 E.00447
G1 X78.623 Y76.596 E.00346
M73 P75 R5
G1 X78.785 Y76.485 E.00387
G1 X78.991 Y76.389 E.00447
G1 X79.16 Y76.341 E.00346
G1 X79.358 Y76.313 E.00392
G1 X92.474 Y76.312 E.25799
G1 X92.653 Y76.331 E.00353
G1 X92.871 Y76.389 E.00445
G1 X93.075 Y76.484 E.00442
G1 X93.259 Y76.613 E.00442
G1 X93.418 Y76.772 E.00442
G1 X93.547 Y76.956 E.00442
G1 X93.642 Y77.16 E.00442
G1 X93.7 Y77.377 E.00442
G1 X93.721 Y77.61 E.0046
G1 X93.721 Y85.511 E.1554
G1 X96.001 Y85.511 E.04485
G1 X96.324 Y85.269 E.00794
G1 X96.721 Y85.599 E.01016
G1 X96.721 Y87.603 E.0394
G1 X96.324 Y87.933 E.01016
G1 X96.001 Y87.691 E.00795
G1 X93.721 Y87.691 E.04485
G1 X93.721 Y88.791 E.02164
G1 X92.541 Y88.791 E.02321
G1 X92.541 Y77.491 E.22226
G1 X79.912 Y77.491 E.24839
G1 X79.724 Y77.524 E.00376
G1 X79.562 Y77.611 E.00361
G1 X79.42 Y77.762 E.00406
G1 X79.344 Y77.925 E.00355
G1 X79.321 Y78.086 E.00319
G1 X79.321 Y95.119 E.33504
G1 X79.354 Y95.311 E.00382
G1 X79.462 Y95.498 E.00425
G1 X79.657 Y95.652 E.00489
G1 X79.906 Y95.711 E.00503
G1 X92.121 Y95.711 E.24025
G1 X92.16 Y95.31 E.00792
G1 X92.222 Y95.11 E.00412
G1 X92.316 Y94.94 E.00383
G1 X92.427 Y94.805 E.00344
G1 X92.56 Y94.693 E.00342
G1 X92.74 Y94.593 E.00405
G1 X92.937 Y94.531 E.00407
G1 X93.111 Y94.512 E.00343
G1 X93.286 Y94.524 E.00345
G1 X93.456 Y94.567 E.00346
G1 X93.616 Y94.639 E.00345
G1 X93.761 Y94.739 E.00346
G1 X93.886 Y94.862 E.00346
G1 X93.987 Y95.006 E.00346
G1 X94.062 Y95.167 E.00348
G1 X94.099 Y95.302 E.00278
G1 X94.119 Y95.509 E.00408
G1 X94.089 Y95.744 E.00466
G1 X94.019 Y95.934 E.00398
G1 X93.911 Y96.108 E.00403
G1 X93.705 Y96.306 E.00562
G1 X93.401 Y96.458 E.00669
G1 X93.216 Y96.623 E.00486
G1 X93.072 Y96.72 E.00343
M73 P76 R5
G1 X92.868 Y96.814 E.00441
G1 X92.653 Y96.871 E.00438
G1 X92.421 Y96.891 E.00456
G1 X88.326 Y96.891 E.08055
G1 X88.932 Y97.588 E.01816
G1 X89.187 Y97.962 E.00891
G1 X89.293 Y98.153 E.00431
G1 X89.479 Y98.57 E.00897
G1 X89.55 Y98.777 E.00431
G1 X89.659 Y99.22 E.00897
G1 X89.713 Y99.661 E.00873
G1 X89.714 Y100.112 E.00888
G1 X89.645 Y100.646 E.01059
G1 X89.557 Y101 E.00718
G1 X89.366 Y101.496 E.01045
G1 X89.198 Y101.82 E.00719
G1 X88.947 Y102.195 E.00886
G1 X88.652 Y102.538 E.00891
G1 X88.495 Y102.691 E.00431
G1 X88.141 Y102.979 E.00897
G1 X87.957 Y103.103 E.00437
G1 X87.766 Y103.216 E.00437
G1 X87.358 Y103.412 E.00891
G1 X86.928 Y103.557 E.00891
G1 X86.716 Y103.609 E.00431
G1 X86.265 Y103.676 E.00897
G1 X86.046 Y103.689 E.00431
G1 X85.593 Y103.676 E.00891
G1 X85.145 Y103.608 E.00891
G1 X84.934 Y103.557 E.00428
G1 X84.424 Y103.376 E.01065
G1 X84.095 Y103.217 E.00718
G1 X83.906 Y103.105 E.00432
G1 X83.539 Y102.84 E.00891
G1 X83.207 Y102.536 E.00885
G1 X82.914 Y102.195 E.00885
G1 X82.664 Y101.822 E.00882
G1 X82.426 Y101.339 E.01059
G1 X82.245 Y100.785 E.01146
G1 X82.159 Y100.251 E.01065
G1 X82.141 Y99.886 E.00718
G1 X82.148 Y99.667 E.00432
G1 X82.203 Y99.217 E.00891
G1 X82.31 Y98.78 E.00885
G1 X82.469 Y98.359 E.00885
G1 X82.676 Y97.96 E.00885
G1 X82.929 Y97.588 E.00885
G1 X83.496 Y96.936 E.01698
; WIPE_START
M204 S6000
G1 X81.496 Y96.914 E-.38
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




G1 X79.328 Y96.249
G1 Z3.8
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.155513
G1 F1500
M204 S6000
G1 X78.991 Y96.005 E.00269
G1 X78.856 Y95.804 E.00157
; LINE_WIDTH: 0.123992
G1 X78.824 Y95.713 E.00047
; LINE_WIDTH: 0.0937296
G1 X78.792 Y95.622 E.00033
; WIPE_START
G1 X78.824 Y95.713 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X84.478 Y97.165 Z4.2 F18000
G1 Z3.8
G1 E.4 F1800
; LINE_WIDTH: 0.477118
G1 F1500
M204 S6000
G1 X84.297 Y97.319 E.00533
; LINE_WIDTH: 0.438435
G1 X84.091 Y97.496 E.00561
; LINE_WIDTH: 0.400638
G1 X83.916 Y97.673 E.00465
; LINE_WIDTH: 0.359933
G1 X83.723 Y97.872 E.00463
G1 X83.405 Y98.285 E.00867
G1 X83.192 Y98.681 E.00751
G1 X83.069 Y99.015 E.00593
G1 X82.964 Y99.463 E.00767
G1 X82.935 Y99.976 E.00857
G1 X82.994 Y100.497 E.00875
G1 X83.09 Y100.861 E.00626
G1 X83.244 Y101.225 E.00659
G1 X83.496 Y101.652 E.00826
G1 X83.777 Y101.985 E.00727
G1 X84.038 Y102.223 E.00589
G1 X84.293 Y102.408 E.00525
G1 X84.738 Y102.653 E.00847
G1 X85.155 Y102.796 E.00735
G1 X85.664 Y102.888 E.00862
G1 X86.185 Y102.885 E.0087
G1 X86.56 Y102.829 E.00632
G1 X87.059 Y102.678 E.00869
G1 X87.39 Y102.517 E.00613
G1 X87.673 Y102.344 E.00553
G1 X88.075 Y101.993 E.00889
G1 X88.399 Y101.602 E.00848
G1 X88.651 Y101.163 E.00843
G1 X88.849 Y100.584 E.0102
G1 X88.904 Y100.264 E.00541
G1 X88.925 Y99.874 E.00651
G1 X88.881 Y99.38 E.00826
G1 X88.789 Y99.004 E.00646
G1 X88.588 Y98.51 E.00889
G1 X88.301 Y98.071 E.00874
G1 X88.074 Y97.801 E.00589
; LINE_WIDTH: 0.381877
G1 X87.81 Y97.533 E.00668
; LINE_WIDTH: 0.423645
G1 X87.697 Y97.432 E.00301
; LINE_WIDTH: 0.477419
G1 X87.371 Y97.16 E.00956
; WIPE_START
G1 X87.697 Y97.432 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X92.703 Y96.139 Z4.2 F18000
G1 Z3.8
G1 E.4 F1800
; LINE_WIDTH: 0.129822
G1 F1500
M204 S6000
G1 X92.805 Y96.089 E.00059
; LINE_WIDTH: 0.103303
G1 X92.948 Y95.998 E.00066
; WIPE_START
G1 X92.805 Y96.089 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X93.431 Y88.482 Z4.2 F18000
G1 X93.586 Y86.601 Z4.2
G1 Z3.8
G1 E.4 F1800
; LINE_WIDTH: 0.114562
G1 F1500
M204 S6000
G1 X95.675 Y86.601 E.00925
; WIPE_START
G1 X93.675 Y86.601 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X87.355 Y82.322 Z4.2 F18000
G1 X79.426 Y76.954 Z4.2
G1 Z3.8
G1 E.4 F1800
; LINE_WIDTH: 0.0923625
G1 F1500
M204 S6000
G1 X79.326 Y76.989 E.00035
; LINE_WIDTH: 0.129828
G1 X79.127 Y77.078 E.00113
; LINE_WIDTH: 0.154982
G1 X79.005 Y77.19 E.00107
G1 X78.855 Y77.388 E.0016
; LINE_WIDTH: 0.105507
G1 X78.788 Y77.595 E.00087
; CHANGE_LAYER
; Z_HEIGHT: 3.92
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F1500
G1 X78.855 Y77.388 E-.38
; WIPE_END
G1 E-.02 F1800
; layer num/total_layer_count: 32/49
; update layer progress
M73 L32
M991 S0 P31 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z4.2 I-.566 J1.077 P1  F18000
G1 X95.887 Y86.344 Z4.2
G1 Z3.92
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X95.887 Y86.857 E.01086
G1 X93.374 Y86.857 E.05319
G1 X93.374 Y86.344 E.01086
G1 X95.827 Y86.344 E.05192
M204 S10000
G1 X96.311 Y85.789 F18000
G1 F1500
M204 S500
G1 X96.311 Y87.412 E.03435
G1 X96.137 Y87.282 E.00461
G1 X93.311 Y87.282 E.05981
G1 X93.311 Y88.382 E.02328
G1 X92.95 Y88.382 E.00765
G1 X92.95 Y77.127 E.23821
G1 X93.128 Y77.071 E.00395
G1 X93.191 Y77.162 E.00234
G1 X93.256 Y77.3 E.00324
G1 X93.296 Y77.448 E.00324
G1 X93.311 Y77.628 E.00382
G1 X93.311 Y85.92 E.17551
G1 X96.137 Y85.92 E.05981
G1 X96.263 Y85.825 E.00334
; WIPE_START
M204 S6000
G1 X96.311 Y87.412 E-.30164
G1 X96.137 Y87.282 E-.04139
G1 X95.942 Y87.282 E-.03697
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X93.557 Y94.532 Z4.32 F18000
G1 X93.263 Y95.425 Z4.32
G1 Z3.92
G1 E.4 F1800
G1 F1500
M204 S500
G1 X93.281 Y95.495 E.00152
G1 X93.273 Y95.557 E.00132
G1 X93.236 Y95.616 E.00147
G1 X93.195 Y95.64 E.00101
G1 X92.955 Y95.741 E.0055
G1 X92.994 Y95.437 E.00648
G1 X93.019 Y95.392 E.0011
G1 X93.072 Y95.362 E.00128
G1 X93.154 Y95.35 E.00177
G1 X93.222 Y95.381 E.00158
; WIPE_START
M204 S6000
G1 X93.281 Y95.495 E-.04237
G1 X93.273 Y95.557 E-.02078
G1 X93.236 Y95.616 E-.02307
G1 X93.195 Y95.64 E-.01589
G1 X92.955 Y95.741 E-.0863
G1 X92.994 Y95.437 E-.10165
G1 X93.019 Y95.392 E-.01722
G1 X93.072 Y95.362 E-.02013
G1 X93.154 Y95.35 E-.02782
G1 X93.222 Y95.381 E-.02476
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X85.742 Y96.898 Z4.32 F18000
G1 X84.696 Y97.11 Z4.32
G1 Z3.92
G1 E.4 F1800
G1 F1500
M204 S500
G1 X84.589 Y96.949 E.0041
G1 X84.941 Y96.544 E.01135
G1 X86.92 Y96.544 E.04187
G1 X87.269 Y96.946 E.01127
G1 X87.14 Y97.112 E.00445
G1 X87.05 Y97.066 E.00212
G1 X86.535 Y96.915 E.01137
G1 X86.161 Y96.864 E.00797
G1 X85.831 Y96.857 E.007
G1 X85.259 Y96.928 E.0122
G1 X84.753 Y97.092 E.01125
; WIPE_START
M204 S6000
G1 X84.589 Y96.949 E-.04131
G1 X84.941 Y96.544 E-.10187
G1 X86.188 Y96.544 E-.23681
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X84.869 Y102.292 Z4.32 F18000
G1 Z3.92
G1 E.4 F1800
G1 F1500
M204 S500
G1 X84.759 Y102.244 E.00254
G1 X84.479 Y102.083 E.00683
G1 X84.119 Y101.796 E.00975
G1 X83.81 Y101.442 E.00995
G1 X83.568 Y101.038 E.00995
G1 X83.407 Y100.607 E.00975
G1 X83.34 Y100.291 E.00683
G1 X83.311 Y99.97 E.00683
G1 X83.338 Y99.506 E.00984
G1 X83.464 Y99.017 E.01069
G1 X83.571 Y98.762 E.00585
G1 X83.727 Y98.482 E.00679
G1 X84.009 Y98.118 E.00975
G1 X84.351 Y97.809 E.00975
G1 X84.62 Y97.632 E.00683
G1 X84.909 Y97.487 E.00683
G1 X85.351 Y97.344 E.00983
G1 X85.852 Y97.282 E.01069
G1 X86.128 Y97.288 E.00584
G1 X86.446 Y97.331 E.00679
G1 X86.892 Y97.461 E.00983
G1 X87.341 Y97.693 E.01069
G1 X87.566 Y97.854 E.00585
G1 X87.804 Y98.068 E.00679
G1 X88.097 Y98.424 E.00975
G1 X88.328 Y98.838 E.01003
G1 X88.485 Y99.318 E.01069
G1 X88.532 Y99.59 E.00585
G1 X88.551 Y99.91 E.00679
G1 X88.51 Y100.369 E.00975
G1 X88.384 Y100.826 E.01003
G1 X88.159 Y101.278 E.01069
G1 X88.002 Y101.505 E.00585
G1 X87.791 Y101.747 E.00678
G1 X87.44 Y102.045 E.00975
G1 X87.041 Y102.275 E.00975
G1 X86.74 Y102.393 E.00683
G1 X86.428 Y102.474 E.00683
G1 X85.97 Y102.522 E.00975
G1 X85.501 Y102.487 E.00995
G1 X85.055 Y102.371 E.00975
G1 X84.924 Y102.315 E.00302
M204 S250
G1 X85.03 Y101.915 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X84.942 Y101.878 E.00188
G1 X84.71 Y101.744 E.00526
G1 X84.403 Y101.499 E.00773
G1 X84.142 Y101.2 E.0078
G1 X83.939 Y100.86 E.0078
G1 X83.801 Y100.492 E.00773
G1 X83.745 Y100.23 E.00526
G1 X83.721 Y99.964 E.00526
G1 X83.744 Y99.57 E.00776
G1 X83.853 Y99.148 E.00858
G1 X83.939 Y98.941 E.0044
G1 X84.069 Y98.708 E.00525
G1 X84.31 Y98.397 E.00774
G1 X84.602 Y98.134 E.00773
G1 X84.825 Y97.987 E.00526
G1 X85.065 Y97.867 E.00526
G1 X85.44 Y97.745 E.00776
G1 X85.873 Y97.692 E.00858
G1 X86.096 Y97.697 E.0044
G1 X86.361 Y97.733 E.00525
G1 X86.74 Y97.843 E.00776
G1 X87.127 Y98.043 E.00858
G1 X87.309 Y98.173 E.0044
G1 X87.508 Y98.352 E.00525
G1 X87.757 Y98.656 E.00774
G1 X87.951 Y99.003 E.00782
G1 X88.087 Y99.417 E.00858
G1 X88.125 Y99.638 E.0044
G1 X88.141 Y99.904 E.00525
G1 X88.106 Y100.296 E.00773
G1 X88 Y100.679 E.00782
G1 X87.806 Y101.07 E.00858
G1 X87.679 Y101.254 E.0044
G1 X87.503 Y101.455 E.00525
G1 X87.203 Y101.709 E.00774
G1 X86.863 Y101.905 E.00773
G1 X86.614 Y102.003 E.00526
G1 X86.355 Y102.07 E.00526
G1 X85.964 Y102.111 E.00774
G1 X85.568 Y102.082 E.0078
G1 X85.188 Y101.983 E.00773
G1 X85.085 Y101.939 E.0022
; WIPE_START
M204 S6000
G1 X84.942 Y101.878 E-.02953
G1 X84.71 Y101.744 E-.05085
G1 X84.403 Y101.499 E-.07469
G1 X84.142 Y101.2 E-.07532
G1 X83.939 Y100.86 E-.07531
G1 X83.801 Y100.494 E-.07429
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X84.691 Y96.12 Z4.32 F18000
G1 Z3.92
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X92.492 Y96.12 E.1651
G1 X92.563 Y95.393 E.01547
G1 X92.601 Y95.27 E.00271
G1 X92.656 Y95.171 E.00239
G1 X92.794 Y95.031 E.00417
G1 X92.903 Y94.97 E.00265
G1 X93.021 Y94.933 E.00262
G1 X93.221 Y94.93 E.00423
G1 X93.321 Y94.955 E.00217
G1 X93.499 Y95.055 E.00433
G1 X93.572 Y95.127 E.00217
G1 X93.631 Y95.211 E.00218
G1 X93.696 Y95.379 E.00379
G1 X93.707 Y95.502 E.00262
G1 X93.689 Y95.646 E.00308
G1 X93.649 Y95.755 E.00246
G1 X93.526 Y95.923 E.00442
G1 X93.387 Y96.02 E.00359
G1 X93.173 Y96.109 E.00491
G1 X92.999 Y96.272 E.00505
G1 X92.866 Y96.364 E.0034
G1 X92.729 Y96.427 E.00321
G1 X92.582 Y96.466 E.00321
G1 X92.404 Y96.482 E.00379
G1 X87.428 Y96.482 E.10532
G1 X88.614 Y97.845 E.03825
G1 X88.721 Y97.992 E.00386
G1 X88.933 Y98.349 E.00878
G1 X89.159 Y98.9 E.0126
G1 X89.286 Y99.49 E.01277
G1 X89.305 Y100.086 E.01264
G1 X89.243 Y100.566 E.01024
G1 X89.102 Y101.07 E.01107
G1 X88.844 Y101.613 E.01273
G1 X88.501 Y102.096 E.01254
G1 X88.216 Y102.391 E.00869
G1 X87.897 Y102.65 E.00869
G1 X87.379 Y102.955 E.01273
G1 X87.024 Y103.099 E.00811
G1 X86.628 Y103.208 E.00869
G1 X86.222 Y103.269 E.00868
G1 X85.63 Y103.267 E.01254
G1 X85.051 Y103.164 E.01245
G1 X84.586 Y103 E.01043
G1 X84.131 Y102.762 E.01088
G1 X83.797 Y102.522 E.00869
G1 X83.502 Y102.251 E.00849
G1 X83.24 Y101.947 E.00849
G1 X83.017 Y101.613 E.00849
G1 X82.834 Y101.256 E.00849
G1 X82.696 Y100.879 E.00849
G1 X82.603 Y100.493 E.00841
G1 X82.554 Y100.012 E.01023
G1 X82.574 Y99.499 E.01088
G1 X82.648 Y99.095 E.00869
G1 X82.767 Y98.711 E.00849
G1 X82.93 Y98.345 E.00849
G1 X83.248 Y97.845 E.01254
G1 X84.434 Y96.482 E.03824
G1 X79.467 Y96.482 E.10513
G1 X79.228 Y96.454 E.00508
G1 X78.955 Y96.34 E.00626
G1 X78.828 Y96.24 E.00343
G1 X78.72 Y96.119 E.00343
G1 X78.627 Y95.957 E.00394
G1 X78.579 Y95.812 E.00324
G1 X78.55 Y95.565 E.00527
G1 X78.55 Y77.628 E.37965
G1 X78.588 Y77.349 E.00597
G1 X78.701 Y77.11 E.00559
G1 X78.866 Y76.928 E.0052
G1 X78.991 Y76.84 E.00324
G1 X79.135 Y76.773 E.00335
G1 X79.386 Y76.723 E.00543
G1 X92.455 Y76.722 E.27661
G1 X92.578 Y76.735 E.00263
G1 X92.731 Y76.775 E.00335
G1 X92.96 Y76.904 E.00557
M73 P77 R5
G1 X92.904 Y77.082 E.00395
G1 X79.886 Y77.082 E.27555
G1 X79.627 Y77.119 E.00553
G1 X79.325 Y77.271 E.00717
G1 X79.101 Y77.495 E.00668
G1 X78.949 Y77.797 E.00717
G1 X78.911 Y78.056 E.00553
G1 X78.911 Y95.155 E.36192
G1 X78.964 Y95.453 E.0064
G1 X79.149 Y95.773 E.00783
G1 X79.488 Y96.035 E.00908
G1 X79.861 Y96.12 E.0081
G1 X84.631 Y96.12 E.10097
; WIPE_START
M204 S6000
G1 X86.631 Y96.12 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X83.535 Y96.891 Z4.32 F18000
G1 Z3.92
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X79.443 Y96.891 E.08049
G1 X79.133 Y96.855 E.00613
G1 X78.846 Y96.75 E.00601
G1 X78.725 Y96.68 E.00277
G1 X78.546 Y96.539 E.00448
G1 X78.394 Y96.368 E.00448
G1 X78.314 Y96.246 E.00289
G1 X78.248 Y96.114 E.00289
G1 X78.177 Y95.901 E.00442
G1 X78.141 Y95.589 E.00619
G1 X78.141 Y77.61 E.35362
G1 X78.161 Y77.374 E.00466
G1 X78.195 Y77.231 E.00289
G1 X78.245 Y77.093 E.00289
G1 X78.355 Y76.89 E.00454
G1 X78.441 Y76.774 E.00283
G1 X78.602 Y76.613 E.00448
G1 X78.786 Y76.484 E.00442
G1 X78.991 Y76.389 E.00445
G1 X79.159 Y76.341 E.00342
G1 X79.358 Y76.313 E.00396
G1 X92.476 Y76.313 E.25802
G1 X92.653 Y76.331 E.0035
G1 X92.871 Y76.389 E.00445
G1 X93.075 Y76.484 E.00442
G1 X93.259 Y76.613 E.00442
G1 X93.418 Y76.772 E.00442
G1 X93.547 Y76.956 E.00442
G1 X93.642 Y77.16 E.00442
G1 X93.7 Y77.377 E.00442
G1 X93.721 Y77.61 E.0046
G1 X93.721 Y85.511 E.1554
G1 X96.001 Y85.511 E.04485
G1 X96.324 Y85.269 E.00794
G1 X96.721 Y85.599 E.01016
G1 X96.721 Y87.603 E.0394
G1 X96.324 Y87.933 E.01016
G1 X96.001 Y87.691 E.00795
G1 X93.721 Y87.691 E.04485
G1 X93.721 Y88.791 E.02164
G1 X92.541 Y88.791 E.02321
G1 X92.541 Y77.491 E.22226
G1 X79.915 Y77.491 E.24833
G1 X79.752 Y77.515 E.00325
G1 X79.567 Y77.608 E.00406
G1 X79.437 Y77.737 E.00361
G1 X79.345 Y77.922 E.00406
G1 X79.321 Y78.086 E.00325
G1 X79.321 Y95.119 E.33504
G1 X79.354 Y95.311 E.00382
G1 X79.463 Y95.499 E.00427
G1 X79.667 Y95.656 E.00507
G1 X79.907 Y95.711 E.00484
G1 X92.121 Y95.711 E.24023
G1 X92.16 Y95.311 E.0079
G1 X92.222 Y95.11 E.00415
G1 X92.316 Y94.94 E.00381
G1 X92.427 Y94.806 E.00343
G1 X92.56 Y94.693 E.00342
G1 X92.741 Y94.592 E.00408
G1 X92.937 Y94.531 E.00404
G1 X93.11 Y94.512 E.00342
G1 X93.285 Y94.524 E.00346
G1 X93.456 Y94.567 E.00346
G1 X93.616 Y94.639 E.00345
G1 X93.761 Y94.738 E.00346
G1 X93.886 Y94.862 E.00345
G1 X93.987 Y95.006 E.00346
G1 X94.061 Y95.166 E.00348
G1 X94.1 Y95.304 E.00281
G1 X94.119 Y95.508 E.00404
G1 X94.089 Y95.743 E.00466
G1 X94.019 Y95.935 E.00401
G1 X93.912 Y96.108 E.00401
G1 X93.706 Y96.306 E.00563
G1 X93.572 Y96.386 E.00306
G1 X93.399 Y96.459 E.0037
G1 X93.256 Y96.592 E.00384
G1 X93.07 Y96.72 E.00444
G1 X92.868 Y96.814 E.00438
G1 X92.652 Y96.871 E.00438
G1 X92.421 Y96.891 E.00456
G1 X88.326 Y96.891 E.08055
G1 X88.934 Y97.59 E.01823
G1 X89.063 Y97.767 E.0043
G1 X89.295 Y98.158 E.00894
G1 X89.423 Y98.432 E.00595
G1 X89.551 Y98.78 E.00728
G1 X89.659 Y99.22 E.00892
G1 X89.713 Y99.661 E.00873
G1 X89.714 Y100.112 E.00888
G1 X89.646 Y100.641 E.0105
G1 X89.557 Y101.001 E.00727
G1 X89.404 Y101.418 E.00874
G1 X89.198 Y101.821 E.00891
G1 X88.945 Y102.197 E.00891
G1 X88.808 Y102.368 E.00431
G1 X88.493 Y102.693 E.00891
G1 X88.141 Y102.979 E.00891
G1 X87.96 Y103.102 E.00431
G1 X87.561 Y103.322 E.00897
G1 X87.15 Y103.489 E.00873
G1 X86.713 Y103.609 E.00891
G1 X86.265 Y103.676 E.00891
G1 X86.046 Y103.689 E.00431
G1 X85.593 Y103.676 E.00891
G1 X85.145 Y103.608 E.00891
G1 X84.934 Y103.557 E.00428
G1 X84.428 Y103.378 E.01056
G1 X84.095 Y103.217 E.00727
G1 X83.906 Y103.105 E.00432
G1 X83.539 Y102.84 E.00891
G1 X83.207 Y102.536 E.00885
G1 X82.914 Y102.195 E.00885
G1 X82.663 Y101.821 E.00885
G1 X82.459 Y101.42 E.00885
G1 X82.303 Y100.998 E.00885
G1 X82.199 Y100.562 E.00882
G1 X82.145 Y100.031 E.01049
G1 X82.148 Y99.661 E.00727
G1 X82.169 Y99.443 E.00432
G1 X82.25 Y98.997 E.00891
G1 X82.383 Y98.567 E.00885
G1 X82.566 Y98.156 E.00885
G1 X82.798 Y97.767 E.00891
G1 X82.927 Y97.59 E.00431
G1 X83.496 Y96.936 E.01704
; WIPE_START
M204 S6000
G1 X81.496 Y96.914 E-.38
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




G1 X79.366 Y96.246
G1 Z3.92
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.125252
G1 F1500
M204 S6000
G1 X79.254 Y96.185 E.00063
; LINE_WIDTH: 0.149189
G1 X79.143 Y96.124 E.00078
G1 X78.938 Y95.953 E.00164
G1 X78.778 Y95.627 E.00224
; WIPE_START
G1 X78.938 Y95.953 E-.18262
G1 X79.143 Y96.124 E-.13359
G1 X79.254 Y96.185 E-.06379
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X84.478 Y97.165 Z4.32 F18000
G1 Z3.92
G1 E.4 F1800
; LINE_WIDTH: 0.477108
G1 F1500
M204 S6000
G1 X84.297 Y97.319 E.00534
; LINE_WIDTH: 0.438389
G1 X84.09 Y97.496 E.00562
; LINE_WIDTH: 0.400605
G1 X83.916 Y97.673 E.00464
; LINE_WIDTH: 0.360069
G1 X83.552 Y98.08 E.0091
G1 X83.268 Y98.523 E.00878
G1 X83.109 Y98.885 E.0066
G1 X82.969 Y99.432 E.00942
G1 X82.933 Y99.988 E.00929
G1 X82.968 Y100.357 E.00619
G1 X83.047 Y100.725 E.00627
G1 X83.185 Y101.103 E.0067
G1 X83.348 Y101.419 E.00594
G1 X83.544 Y101.716 E.00593
G1 X83.869 Y102.078 E.00812
G1 X84.277 Y102.402 E.00868
G1 X84.736 Y102.649 E.00869
G1 X85.16 Y102.796 E.0075
G1 X85.454 Y102.861 E.00502
G1 X85.961 Y102.9 E.00847
G1 X86.508 Y102.843 E.00917
G1 X86.867 Y102.75 E.00619
G1 X87.21 Y102.615 E.00616
G1 X87.67 Y102.346 E.00888
G1 X88.047 Y102.024 E.00827
G1 X88.292 Y101.743 E.00622
G1 X88.515 Y101.42 E.00655
G1 X88.743 Y100.946 E.00877
G1 X88.869 Y100.494 E.00784
G1 X88.922 Y100.062 E.00725
G1 X88.922 Y99.701 E.00603
G1 X88.854 Y99.238 E.0078
G1 X88.791 Y99.015 E.00386
G1 X88.593 Y98.527 E.0088
G1 X88.398 Y98.201 E.00632
G1 X88.07 Y97.797 E.00869
; LINE_WIDTH: 0.382204
G1 X87.809 Y97.533 E.00659
; LINE_WIDTH: 0.423828
G1 X87.696 Y97.431 E.00304
; LINE_WIDTH: 0.477697
G1 X87.371 Y97.16 E.00953
; WIPE_START
G1 X87.696 Y97.431 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X92.703 Y96.138 Z4.32 F18000
G1 Z3.92
G1 E.4 F1800
; LINE_WIDTH: 0.123516
G1 F1500
M204 S6000
G1 X92.838 Y96.07 E.00074
; LINE_WIDTH: 0.0983789
G1 X92.949 Y95.998 E.00048
; WIPE_START
G1 X92.838 Y96.07 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X93.439 Y88.461 Z4.32 F18000
G1 X93.586 Y86.601 Z4.32
G1 Z3.92
G1 E.4 F1800
; LINE_WIDTH: 0.114562
G1 F1500
M204 S6000
G1 X95.675 Y86.601 E.00925
; WIPE_START
G1 X93.675 Y86.601 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X87.356 Y82.321 Z4.32 F18000
G1 X79.435 Y76.955 Z4.32
G1 Z3.92
G1 E.4 F1800
; LINE_WIDTH: 0.0974167
G1 F1500
M204 S6000
G1 X79.298 Y76.996 E.00051
; LINE_WIDTH: 0.128811
G1 X79.128 Y77.08 E.00098
; LINE_WIDTH: 0.156993
G1 X78.936 Y77.264 E.00174
G1 X78.865 Y77.369 E.00083
; LINE_WIDTH: 0.125736
G1 X78.82 Y77.482 E.0006
; LINE_WIDTH: 0.097471
G1 X78.787 Y77.598 E.00043
; CHANGE_LAYER
; Z_HEIGHT: 4.04
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F1500
G1 X78.82 Y77.482 E-.38
; WIPE_END
G1 E-.02 F1800
; layer num/total_layer_count: 33/49
; update layer progress
M73 L33
M991 S0 P32 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z4.32 I-.561 J1.08 P1  F18000
G1 X95.887 Y86.344 Z4.32
G1 Z4.04
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X95.887 Y86.857 E.01086
G1 X93.374 Y86.857 E.05319
G1 X93.374 Y86.344 E.01086
G1 X95.827 Y86.344 E.05192
M204 S10000
G1 X96.311 Y85.789 F18000
G1 F1500
M204 S500
G1 X96.311 Y87.412 E.03435
G1 X96.137 Y87.282 E.00461
G1 X93.311 Y87.282 E.05981
G1 X93.311 Y88.382 E.02328
G1 X92.95 Y88.382 E.00765
G1 X92.95 Y77.127 E.23821
G1 X93.128 Y77.071 E.00395
G1 X93.191 Y77.162 E.00234
G1 X93.256 Y77.3 E.00324
G1 X93.296 Y77.448 E.00325
G1 X93.311 Y77.628 E.00381
G1 X93.311 Y85.92 E.17551
G1 X96.137 Y85.92 E.05981
G1 X96.263 Y85.825 E.00334
; WIPE_START
M204 S6000
G1 X96.311 Y87.412 E-.30164
G1 X96.137 Y87.282 E-.04139
G1 X95.942 Y87.282 E-.03697
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X93.556 Y94.531 Z4.44 F18000
G1 X93.262 Y95.424 Z4.44
G1 Z4.04
G1 E.4 F1800
G1 F1500
M204 S500
G1 X93.281 Y95.494 E.00153
G1 X93.273 Y95.557 E.00134
G1 X93.236 Y95.616 E.00146
G1 X93.194 Y95.641 E.00103
G1 X92.956 Y95.741 E.00548
G1 X92.994 Y95.436 E.00649
G1 X93.018 Y95.392 E.00107
G1 X93.073 Y95.362 E.00131
G1 X93.154 Y95.35 E.00175
G1 X93.222 Y95.381 E.00157
; WIPE_START
M204 S6000
G1 X93.281 Y95.494 E-.04246
G1 X93.273 Y95.557 E-.02098
G1 X93.236 Y95.616 E-.02297
G1 X93.194 Y95.641 E-.01622
G1 X92.956 Y95.741 E-.08602
G1 X92.994 Y95.436 E-.10186
G1 X93.018 Y95.392 E-.01684
G1 X93.073 Y95.362 E-.02062
G1 X93.154 Y95.35 E-.02742
G1 X93.222 Y95.381 E-.0246
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X85.741 Y96.897 Z4.44 F18000
G1 X84.709 Y97.106 Z4.44
G1 Z4.04
G1 E.4 F1800
G1 F1500
M204 S500
G1 X84.603 Y96.944 E.00411
G1 X84.954 Y96.544 E.01127
G1 X86.92 Y96.544 E.0416
G1 X87.269 Y96.946 E.01128
G1 X87.14 Y97.112 E.00445
G1 X87.05 Y97.066 E.00213
G1 X86.535 Y96.915 E.01136
G1 X86.161 Y96.864 E.00798
G1 X85.828 Y96.857 E.00706
G1 X85.258 Y96.928 E.01215
G1 X84.766 Y97.088 E.01095
; WIPE_START
M204 S6000
G1 X84.603 Y96.944 E-.04139
G1 X84.954 Y96.544 E-.10112
G1 X86.204 Y96.544 E-.23748
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X84.866 Y102.291 Z4.44 F18000
G1 Z4.04
G1 E.4 F1800
G1 F1500
M204 S500
G1 X84.757 Y102.244 E.00251
G1 X84.479 Y102.083 E.00679
G1 X84.119 Y101.796 E.00975
G1 X83.81 Y101.442 E.00995
G1 X83.573 Y101.046 E.00975
G1 X83.451 Y100.748 E.00683
G1 X83.365 Y100.437 E.00683
G1 X83.31 Y99.979 E.00975
G1 X83.338 Y99.51 E.00995
G1 X83.447 Y99.062 E.00975
G1 X83.57 Y98.764 E.00683
G1 X83.727 Y98.482 E.00682
G1 X84.009 Y98.118 E.00975
G1 X84.351 Y97.809 E.00975
M73 P78 R5
G1 X84.62 Y97.632 E.00683
G1 X84.909 Y97.487 E.00683
G1 X85.351 Y97.344 E.00983
G1 X85.85 Y97.282 E.01064
G1 X86.128 Y97.288 E.0059
G1 X86.446 Y97.331 E.00679
G1 X86.892 Y97.461 E.00983
G1 X87.339 Y97.692 E.01064
G1 X87.566 Y97.854 E.0059
G1 X87.804 Y98.068 E.00679
G1 X88.091 Y98.417 E.00956
G1 X88.255 Y98.692 E.00679
G1 X88.37 Y98.946 E.0059
G1 X88.51 Y99.429 E.01064
G1 X88.552 Y99.901 E.01003
G1 X88.51 Y100.369 E.00995
G1 X88.385 Y100.822 E.00995
G1 X88.185 Y101.237 E.00975
G1 X88.003 Y101.504 E.00683
G1 X87.791 Y101.747 E.00683
G1 X87.437 Y102.047 E.00983
G1 X86.999 Y102.293 E.01064
G1 X86.739 Y102.393 E.0059
G1 X86.428 Y102.474 E.00679
G1 X85.97 Y102.522 E.00975
G1 X85.497 Y102.487 E.01003
G1 X85.012 Y102.355 E.01064
G1 X84.921 Y102.315 E.00212
M204 S250
G1 X85.029 Y101.916 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X84.941 Y101.877 E.00188
G1 X84.71 Y101.744 E.00525
G1 X84.403 Y101.499 E.00773
G1 X84.142 Y101.2 E.0078
G1 X83.94 Y100.863 E.00773
G1 X83.839 Y100.615 E.00526
G1 X83.768 Y100.357 E.00526
G1 X83.721 Y99.967 E.00773
G1 X83.744 Y99.571 E.0078
G1 X83.838 Y99.189 E.00774
G1 X83.939 Y98.942 E.00526
G1 X84.069 Y98.708 E.00526
G1 X84.31 Y98.397 E.00773
G1 X84.602 Y98.134 E.00774
G1 X84.825 Y97.987 E.00526
G1 X85.065 Y97.867 E.00526
G1 X85.44 Y97.745 E.00776
G1 X85.87 Y97.692 E.00854
G1 X86.096 Y97.697 E.00445
G1 X86.361 Y97.733 E.00525
G1 X86.739 Y97.843 E.00776
G1 X87.125 Y98.042 E.00853
G1 X87.309 Y98.173 E.00445
G1 X87.507 Y98.352 E.00525
G1 X87.755 Y98.653 E.00767
G1 X87.892 Y98.882 E.00525
G1 X87.985 Y99.088 E.00445
G1 X88.106 Y99.505 E.00853
G1 X88.141 Y99.901 E.00782
G1 X88.106 Y100.296 E.00779
G1 X88 Y100.678 E.0078
G1 X87.83 Y101.032 E.00773
G1 X87.679 Y101.253 E.00526
G1 X87.503 Y101.455 E.00526
G1 X87.202 Y101.71 E.00776
G1 X86.824 Y101.922 E.00853
G1 X86.613 Y102.003 E.00444
G1 X86.355 Y102.07 E.00525
G1 X85.964 Y102.111 E.00774
G1 X85.567 Y102.082 E.00782
G1 X85.149 Y101.968 E.00853
G1 X85.084 Y101.939 E.00139
; WIPE_START
M204 S6000
G1 X84.941 Y101.877 E-.02954
G1 X84.71 Y101.744 E-.05072
G1 X84.403 Y101.499 E-.07471
G1 X84.142 Y101.2 E-.0753
G1 X83.94 Y100.863 E-.07471
G1 X83.839 Y100.615 E-.05082
G1 X83.805 Y100.493 E-.02421
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X84.706 Y96.12 Z4.44 F18000
G1 Z4.04
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X92.492 Y96.12 E.1648
G1 X92.563 Y95.394 E.01545
G1 X92.601 Y95.27 E.00275
G1 X92.655 Y95.172 E.00237
G1 X92.793 Y95.032 E.00416
G1 X92.904 Y94.97 E.00269
G1 X93.021 Y94.934 E.00258
G1 X93.221 Y94.93 E.00423
G1 X93.32 Y94.955 E.00218
G1 X93.414 Y94.997 E.00217
G1 X93.572 Y95.127 E.00433
G1 X93.631 Y95.211 E.00217
G1 X93.696 Y95.379 E.00382
G1 X93.707 Y95.501 E.00258
G1 X93.689 Y95.645 E.00308
G1 X93.649 Y95.756 E.00249
G1 X93.526 Y95.924 E.00441
G1 X93.386 Y96.02 E.00359
G1 X93.173 Y96.109 E.00488
G1 X92.999 Y96.272 E.00506
G1 X92.866 Y96.364 E.0034
G1 X92.728 Y96.427 E.00322
G1 X92.582 Y96.466 E.00321
G1 X92.404 Y96.482 E.00379
G1 X87.428 Y96.482 E.10532
G1 X88.614 Y97.845 E.03824
G1 X88.721 Y97.992 E.00386
G1 X88.935 Y98.353 E.00888
G1 X89.159 Y98.901 E.01254
G1 X89.286 Y99.49 E.01273
G1 X89.305 Y100.087 E.01264
G1 X89.244 Y100.562 E.01014
G1 X89.102 Y101.07 E.01117
G1 X88.842 Y101.617 E.01283
G1 X88.496 Y102.101 E.0126
G1 X88.215 Y102.391 E.00854
G1 X87.897 Y102.65 E.00869
G1 X87.508 Y102.889 E.00966
G1 X87.024 Y103.099 E.01117
G1 X86.628 Y103.208 E.00869
G1 X86.222 Y103.269 E.00869
G1 X85.63 Y103.267 E.01254
G1 X85.047 Y103.163 E.01254
G1 X84.649 Y103.029 E.00888
G1 X84.187 Y102.794 E.01097
G1 X83.795 Y102.52 E.01014
G1 X83.502 Y102.251 E.00841
G1 X83.24 Y101.947 E.00849
G1 X83.017 Y101.613 E.0085
G1 X82.836 Y101.259 E.00841
G1 X82.676 Y100.808 E.01014
G1 X82.574 Y100.3 E.01097
G1 X82.551 Y99.89 E.00869
G1 X82.576 Y99.49 E.00849
G1 X82.648 Y99.095 E.0085
G1 X82.767 Y98.712 E.00849
G1 X82.93 Y98.345 E.00849
G1 X83.138 Y97.996 E.00859
G1 X83.294 Y97.788 E.00551
G1 X84.444 Y96.482 E.03684
G1 X79.467 Y96.482 E.10536
G1 X79.219 Y96.453 E.00527
G1 X79.074 Y96.405 E.00324
G1 X78.859 Y96.269 E.0054
G1 X78.729 Y96.131 E.00399
G1 X78.652 Y96.008 E.00309
G1 X78.58 Y95.821 E.00424
G1 X78.55 Y95.565 E.00546
G1 X78.55 Y77.628 E.37965
G1 X78.586 Y77.357 E.00578
G1 X78.691 Y77.125 E.00539
G1 X78.858 Y76.933 E.00539
G1 X79.096 Y76.789 E.00588
G1 X79.226 Y76.746 E.00289
G1 X79.388 Y76.723 E.00348
G1 X92.456 Y76.722 E.27659
G1 X92.578 Y76.734 E.0026
G1 X92.731 Y76.775 E.00335
G1 X92.96 Y76.904 E.00557
G1 X92.904 Y77.082 E.00395
G1 X79.879 Y77.082 E.27569
G1 X79.601 Y77.128 E.00597
G1 X79.312 Y77.28 E.0069
G1 X79.077 Y77.529 E.00724
G1 X78.948 Y77.807 E.00649
G1 X78.911 Y78.056 E.00533
G1 X78.911 Y95.155 E.36192
G1 X78.964 Y95.453 E.0064
G1 X79.152 Y95.778 E.00796
G1 X79.512 Y96.047 E.00951
G1 X79.867 Y96.12 E.00767
G1 X84.646 Y96.12 E.10114
; WIPE_START
M204 S6000
G1 X86.646 Y96.12 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X83.539 Y96.891 Z4.44 F18000
G1 Z4.04
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X79.443 Y96.891 E.08056
G1 X79.13 Y96.854 E.00619
G1 X78.917 Y96.784 E.00442
G1 X78.789 Y96.719 E.00283
G1 X78.599 Y96.587 E.00454
G1 X78.492 Y96.486 E.00289
G1 X78.29 Y96.201 E.00688
G1 X78.177 Y95.904 E.00624
G1 X78.141 Y95.589 E.00625
G1 X78.141 Y77.61 E.35362
G1 X78.161 Y77.374 E.00466
G1 X78.194 Y77.234 E.00283
G1 X78.28 Y77.019 E.00454
G1 X78.352 Y76.895 E.00283
G1 X78.495 Y76.714 E.00454
G1 X78.599 Y76.615 E.00283
G1 X78.787 Y76.483 E.00452
G1 X78.942 Y76.408 E.00339
G1 X79.133 Y76.347 E.00393
G1 X79.359 Y76.313 E.00449
G1 X92.477 Y76.313 E.25804
G1 X92.653 Y76.331 E.00347
G1 X92.871 Y76.389 E.00445
G1 X93.075 Y76.484 E.00442
G1 X93.259 Y76.613 E.00442
G1 X93.418 Y76.772 E.00442
G1 X93.547 Y76.956 E.00442
G1 X93.642 Y77.16 E.00442
G1 X93.7 Y77.377 E.00442
G1 X93.721 Y77.61 E.0046
G1 X93.721 Y85.511 E.1554
G1 X96.001 Y85.511 E.04485
G1 X96.324 Y85.269 E.00794
G1 X96.721 Y85.599 E.01016
G1 X96.721 Y87.603 E.0394
G1 X96.324 Y87.933 E.01016
G1 X96.001 Y87.691 E.00795
G1 X93.721 Y87.691 E.04485
G1 X93.721 Y88.791 E.02164
G1 X92.541 Y88.791 E.02321
G1 X92.541 Y77.491 E.22226
G1 X79.913 Y77.491 E.24837
G1 X79.733 Y77.521 E.00359
G1 X79.563 Y77.61 E.00378
G1 X79.42 Y77.762 E.00409
G1 X79.344 Y77.925 E.00355
G1 X79.321 Y78.086 E.00319
G1 X79.321 Y95.119 E.33504
G1 X79.354 Y95.311 E.00382
G1 X79.464 Y95.501 E.00431
G1 X79.684 Y95.664 E.0054
G1 X79.909 Y95.711 E.00452
G1 X92.121 Y95.711 E.2402
G1 X92.16 Y95.313 E.00787
G1 X92.223 Y95.109 E.00419
G1 X92.315 Y94.941 E.00378
G1 X92.427 Y94.806 E.00344
G1 X92.559 Y94.694 E.00342
G1 X92.742 Y94.592 E.00412
G1 X92.936 Y94.531 E.004
G1 X93.11 Y94.512 E.00343
G1 X93.285 Y94.524 E.00345
G1 X93.455 Y94.567 E.00346
G1 X93.615 Y94.639 E.00345
G1 X93.76 Y94.738 E.00346
G1 X93.885 Y94.862 E.00345
G1 X93.986 Y95.005 E.00345
G1 X94.061 Y95.166 E.00349
G1 X94.1 Y95.305 E.00284
G1 X94.119 Y95.508 E.00401
G1 X94.089 Y95.743 E.00466
G1 X94.018 Y95.936 E.00404
G1 X93.912 Y96.107 E.00397
G1 X93.706 Y96.306 E.00563
G1 X93.571 Y96.386 E.00308
G1 X93.399 Y96.459 E.00367
G1 X93.256 Y96.592 E.00384
G1 X93.07 Y96.72 E.00444
G1 X92.868 Y96.814 E.00439
G1 X92.652 Y96.871 E.00438
G1 X92.421 Y96.891 E.00456
G1 X88.326 Y96.891 E.08055
G1 X88.934 Y97.59 E.01822
G1 X89.063 Y97.767 E.00431
G1 X89.296 Y98.159 E.00897
G1 X89.391 Y98.356 E.00431
G1 X89.551 Y98.78 E.00891
G1 X89.659 Y99.22 E.00891
G1 X89.713 Y99.661 E.00873
G1 X89.714 Y100.112 E.00888
G1 X89.646 Y100.637 E.01041
G1 X89.557 Y101.001 E.00736
G1 X89.404 Y101.418 E.00874
G1 X89.197 Y101.822 E.00894
G1 X89.035 Y102.072 E.00586
G1 X88.806 Y102.369 E.00737
G1 X88.493 Y102.693 E.00886
G1 X88.141 Y102.979 E.00891
G1 X87.697 Y103.252 E.01025
G1 X87.15 Y103.489 E.01173
G1 X86.713 Y103.609 E.00891
G1 X86.265 Y103.676 E.00891
G1 X86.046 Y103.689 E.00431
G1 X85.593 Y103.676 E.00891
G1 X85.145 Y103.608 E.00891
G1 X84.933 Y103.557 E.00431
G1 X84.5 Y103.411 E.00897
G1 X83.971 Y103.143 E.01167
G1 X83.538 Y102.839 E.0104
G1 X83.207 Y102.536 E.00882
G1 X82.914 Y102.195 E.00885
G1 X82.663 Y101.821 E.00885
G1 X82.459 Y101.421 E.00882
G1 X82.283 Y100.923 E.0104
G1 X82.198 Y100.558 E.00737
G1 X82.166 Y100.341 E.00431
G1 X82.141 Y99.889 E.00891
G1 X82.169 Y99.44 E.00885
G1 X82.25 Y98.997 E.00885
G1 X82.383 Y98.567 E.00885
G1 X82.566 Y98.156 E.00885
G1 X82.798 Y97.768 E.00888
G1 X82.976 Y97.53 E.00586
G1 X83.499 Y96.936 E.01556
; WIPE_START
M204 S6000
G1 X81.499 Y96.914 E-.38
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




G1 X79.316 Y96.244
G1 Z4.04
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.151727
G1 F1500
M204 S6000
G1 X78.996 Y96.011 E.00249
G1 X78.856 Y95.804 E.00157
; LINE_WIDTH: 0.123989
G1 X78.824 Y95.713 E.00047
; LINE_WIDTH: 0.0937189
G1 X78.792 Y95.622 E.00033
; WIPE_START
G1 X78.824 Y95.713 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X84.49 Y97.159 Z4.44 F18000
G1 Z4.04
G1 E.4 F1800
; LINE_WIDTH: 0.476978
G1 F1500
M204 S6000
G1 X84.304 Y97.316 E.00548
; LINE_WIDTH: 0.436779
G1 X84.091 Y97.497 E.00573
; LINE_WIDTH: 0.39916
G1 X83.917 Y97.674 E.00463
; LINE_WIDTH: 0.360316
G1 X83.592 Y98.03 E.00804
G1 X83.418 Y98.264 E.00487
G1 X83.269 Y98.521 E.00496
G1 X83.093 Y98.934 E.0075
G1 X82.968 Y99.439 E.00869
G1 X82.933 Y99.891 E.00756
G1 X82.956 Y100.257 E.00611
G1 X83.043 Y100.703 E.00759
G1 X83.187 Y101.109 E.00718
G1 X83.348 Y101.418 E.00583
G1 X83.544 Y101.716 E.00594
G1 X83.869 Y102.078 E.00813
G1 X84.278 Y102.4 E.00868
G1 X84.644 Y102.61 E.00705
G1 X85.151 Y102.792 E.00898
G1 X85.449 Y102.857 E.0051
G1 X85.961 Y102.896 E.00857
G1 X86.483 Y102.848 E.00876
G1 X86.863 Y102.751 E.00655
G1 X87.33 Y102.547 E.0085
G1 X87.666 Y102.349 E.0065
G1 X88.047 Y102.024 E.00836
G1 X88.294 Y101.741 E.00627
G1 X88.515 Y101.424 E.00645
G1 X88.733 Y100.968 E.00843
G1 X88.87 Y100.492 E.00827
G1 X88.922 Y100.063 E.00722
G1 X88.92 Y99.701 E.00604
G1 X88.885 Y99.371 E.00553
G1 X88.791 Y99.018 E.00611
G1 X88.599 Y98.53 E.00875
G1 X88.39 Y98.191 E.00665
G1 X88.07 Y97.797 E.00848
; LINE_WIDTH: 0.382241
G1 X87.809 Y97.533 E.00659
; LINE_WIDTH: 0.424071
G1 X87.695 Y97.429 E.00306
; LINE_WIDTH: 0.477989
G1 X87.372 Y97.159 E.0095
; WIPE_START
G1 X87.695 Y97.429 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X92.704 Y96.138 Z4.44 F18000
G1 Z4.04
G1 E.4 F1800
; LINE_WIDTH: 0.123875
M73 P79 R5
G1 F1500
M204 S6000
G1 X92.837 Y96.07 E.00073
; LINE_WIDTH: 0.0985704
G1 X92.95 Y95.997 E.00049
; WIPE_START
G1 X92.837 Y96.07 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X93.439 Y88.461 Z4.44 F18000
G1 X93.586 Y86.601 Z4.44
G1 Z4.04
G1 E.4 F1800
; LINE_WIDTH: 0.114562
G1 F1500
M204 S6000
G1 X95.675 Y86.601 E.00925
; WIPE_START
G1 X93.675 Y86.601 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X87.355 Y82.321 Z4.44 F18000
G1 X79.429 Y76.954 Z4.44
G1 Z4.04
G1 E.4 F1800
; LINE_WIDTH: 0.10035
G1 F1500
M204 S6000
G1 X79.286 Y77 E.00056
; LINE_WIDTH: 0.146185
G1 X79.14 Y77.069 E.00097
G1 X79.043 Y77.151 E.00077
G1 X78.895 Y77.322 E.00136
G1 X78.835 Y77.434 E.00076
; LINE_WIDTH: 0.0998625
G1 X78.788 Y77.595 E.00062
; CHANGE_LAYER
; Z_HEIGHT: 4.16
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F1500
G1 X78.835 Y77.434 E-.38
; WIPE_END
G1 E-.02 F1800
; layer num/total_layer_count: 34/49
; update layer progress
M73 L34
M991 S0 P33 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z4.44 I-.565 J1.078 P1  F18000
G1 X95.833 Y86.344 Z4.44
G1 Z4.16
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X95.833 Y86.857 E.01086
G1 X93.374 Y86.857 E.05204
G1 X93.374 Y86.344 E.01086
G1 X95.773 Y86.344 E.05077
M204 S10000
G1 X96.257 Y85.92 F18000
G1 F1500
M204 S500
G1 X96.257 Y87.282 E.02882
G1 X93.311 Y87.282 E.06234
G1 X93.311 Y88.382 E.02328
G1 X92.95 Y88.382 E.00765
G1 X92.95 Y77.127 E.23821
G1 X93.128 Y77.071 E.00395
G1 X93.191 Y77.162 E.00234
G1 X93.256 Y77.3 E.00324
G1 X93.296 Y77.448 E.00324
G1 X93.311 Y77.628 E.00382
G1 X93.311 Y85.92 E.17551
G1 X96.197 Y85.92 E.06107
; WIPE_START
M204 S6000
G1 X96.257 Y87.282 E-.25894
G1 X95.62 Y87.282 E-.12106
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X93.497 Y94.613 Z4.56 F18000
G1 X93.262 Y95.424 Z4.56
G1 Z4.16
G1 E.4 F1800
G1 F1500
M204 S500
G1 X93.281 Y95.494 E.00151
G1 X93.273 Y95.556 E.00134
G1 X93.237 Y95.615 E.00146
G1 X93.194 Y95.641 E.00107
G1 X92.956 Y95.74 E.00546
G1 X92.981 Y95.478 E.00558
G1 X93.005 Y95.4 E.00173
G1 X93.073 Y95.362 E.00165
G1 X93.154 Y95.35 E.00174
G1 X93.222 Y95.381 E.00157
; WIPE_START
M204 S6000
G1 X93.281 Y95.494 E-.04212
G1 X93.273 Y95.556 E-.0209
G1 X93.237 Y95.615 E-.02287
G1 X93.194 Y95.641 E-.01673
G1 X92.956 Y95.74 E-.08545
G1 X92.981 Y95.478 E-.0873
G1 X93.005 Y95.4 E-.02714
G1 X93.073 Y95.362 E-.02576
G1 X93.154 Y95.35 E-.02718
G1 X93.222 Y95.381 E-.02456
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X85.742 Y96.898 Z4.56 F18000
G1 X84.696 Y97.11 Z4.56
G1 Z4.16
G1 E.4 F1800
G1 F1500
M204 S500
G1 X84.589 Y96.949 E.0041
G1 X84.941 Y96.544 E.01135
G1 X86.92 Y96.544 E.04188
G1 X87.273 Y96.951 E.0114
G1 X87.15 Y97.115 E.00436
G1 X87.029 Y97.059 E.00282
G1 X86.535 Y96.915 E.01089
G1 X86.161 Y96.864 E.00798
G1 X85.825 Y96.858 E.00711
G1 X85.258 Y96.928 E.01209
G1 X84.753 Y97.092 E.01124
; WIPE_START
M204 S6000
G1 X84.589 Y96.949 E-.04131
G1 X84.941 Y96.544 E-.10188
G1 X86.188 Y96.544 E-.23681
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X84.838 Y102.278 Z4.56 F18000
G1 Z4.16
G1 E.4 F1800
G1 F1500
M204 S500
G1 X84.486 Y102.089 E.00844
G1 X84.119 Y101.796 E.00995
G1 X83.81 Y101.442 E.00995
G1 X83.573 Y101.046 E.00975
G1 X83.452 Y100.749 E.0068
G1 X83.375 Y100.479 E.00595
G1 X83.31 Y99.983 E.01059
G1 X83.338 Y99.507 E.0101
G1 X83.462 Y99.022 E.01059
G1 X83.571 Y98.762 E.00596
G1 X83.727 Y98.482 E.00679
G1 X84.003 Y98.125 E.00955
G1 X84.236 Y97.902 E.00683
G1 X84.494 Y97.708 E.00683
G1 X84.9 Y97.49 E.00975
G1 X85.351 Y97.344 E.01002
G1 X85.847 Y97.282 E.01059
G1 X86.128 Y97.288 E.00595
G1 X86.446 Y97.331 E.0068
G1 X86.879 Y97.458 E.00955
G1 X87.172 Y97.593 E.00683
G1 X87.447 Y97.763 E.00683
G1 X87.791 Y98.055 E.00955
G1 X88.003 Y98.298 E.00683
G1 X88.185 Y98.565 E.00683
G1 X88.385 Y98.98 E.00975
G1 X88.51 Y99.433 E.00995
G1 X88.551 Y99.892 E.00975
G1 X88.532 Y100.214 E.00683
G1 X88.475 Y100.531 E.00683
G1 X88.326 Y100.967 E.00975
G1 X88.097 Y101.378 E.00994
G1 X87.798 Y101.741 E.00995
G1 X87.437 Y102.047 E.01002
G1 X87.001 Y102.292 E.01059
G1 X86.739 Y102.393 E.00595
G1 X86.428 Y102.474 E.00679
G1 X85.966 Y102.523 E.00983
G1 X85.468 Y102.48 E.01058
G1 X85.194 Y102.415 E.00595
G1 X84.892 Y102.307 E.00679
G1 X84.89 Y102.306 E.00004
M204 S250
G1 X85.031 Y101.918 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X84.713 Y101.746 E.00712
G1 X84.403 Y101.499 E.0078
G1 X84.142 Y101.2 E.00779
G1 X83.94 Y100.863 E.00773
G1 X83.839 Y100.616 E.00525
G1 X83.777 Y100.396 E.00449
G1 X83.721 Y99.968 E.00849
G1 X83.744 Y99.57 E.00785
G1 X83.852 Y99.152 E.00849
G1 X83.939 Y98.941 E.0045
G1 X84.069 Y98.708 E.00525
G1 X84.308 Y98.4 E.00767
G1 X84.501 Y98.215 E.00526
G1 X84.715 Y98.054 E.00526
G1 X85.062 Y97.868 E.00773
G1 X85.44 Y97.745 E.00782
G1 X85.868 Y97.692 E.00849
G1 X86.096 Y97.697 E.00449
G1 X86.361 Y97.733 E.00525
G1 X86.735 Y97.842 E.00767
G1 X86.978 Y97.954 E.00526
G1 X87.206 Y98.095 E.00526
G1 X87.503 Y98.347 E.00767
G1 X87.679 Y98.549 E.00526
G1 X87.83 Y98.77 E.00526
G1 X88 Y99.124 E.00773
G1 X88.106 Y99.506 E.0078
G1 X88.141 Y99.898 E.00773
G1 X88.125 Y100.165 E.00526
G1 X88.077 Y100.428 E.00526
G1 X87.95 Y100.8 E.00773
G1 X87.757 Y101.146 E.00779
G1 X87.506 Y101.452 E.0078
G1 X87.202 Y101.71 E.00782
G1 X86.826 Y101.921 E.00849
G1 X86.613 Y102.003 E.00449
G1 X86.355 Y102.07 E.00525
G1 X85.962 Y102.112 E.00776
G1 X85.533 Y102.074 E.00848
G1 X85.31 Y102.022 E.00449
G1 X85.086 Y101.942 E.00468
; WIPE_START
M204 S6000
G1 X84.713 Y101.746 E-.08011
G1 X84.403 Y101.499 E-.07534
G1 X84.142 Y101.2 E-.0753
G1 X83.94 Y100.863 E-.0747
G1 X83.839 Y100.616 E-.05075
G1 X83.805 Y100.495 E-.02381
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X84.691 Y96.12 Z4.56 F18000
G1 Z4.16
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X92.492 Y96.12 E.16511
G1 X92.563 Y95.394 E.01544
G1 X92.602 Y95.269 E.00277
G1 X92.655 Y95.172 E.00235
G1 X92.793 Y95.032 E.00416
G1 X92.905 Y94.969 E.00272
G1 X93.02 Y94.934 E.00255
G1 X93.22 Y94.93 E.00424
G1 X93.32 Y94.955 E.00217
G1 X93.499 Y95.055 E.00433
G1 X93.572 Y95.127 E.00217
G1 X93.631 Y95.211 E.00217
G1 X93.696 Y95.381 E.00385
G1 X93.708 Y95.5 E.00254
G1 X93.689 Y95.645 E.00307
G1 X93.648 Y95.757 E.00253
G1 X93.525 Y95.925 E.00442
G1 X93.385 Y96.021 E.00358
G1 X93.173 Y96.109 E.00486
G1 X92.999 Y96.272 E.00506
G1 X92.866 Y96.364 E.0034
G1 X92.728 Y96.427 E.00322
G1 X92.582 Y96.466 E.00321
G1 X92.404 Y96.482 E.00378
G1 X87.428 Y96.482 E.10532
G1 X88.614 Y97.845 E.03824
G1 X88.721 Y97.993 E.00386
G1 X88.935 Y98.353 E.00888
G1 X89.159 Y98.901 E.01254
G1 X89.286 Y99.489 E.01273
G1 X89.305 Y100.087 E.01265
G1 X89.244 Y100.557 E.01004
G1 X89.105 Y101.061 E.01107
G1 X88.845 Y101.614 E.01292
G1 X88.495 Y102.103 E.01273
G1 X88.212 Y102.395 E.0086
G1 X88.016 Y102.559 E.00541
G1 X87.574 Y102.855 E.01127
G1 X87.024 Y103.099 E.01273
G1 X86.628 Y103.208 E.00869
G1 X86.222 Y103.269 E.00869
G1 X85.63 Y103.267 E.01254
G1 X85.047 Y103.164 E.01254
G1 X84.649 Y103.029 E.00888
G1 X84.123 Y102.757 E.01253
G1 X83.797 Y102.522 E.0085
G1 X83.502 Y102.251 E.00849
G1 X83.24 Y101.947 E.00849
G1 X83.017 Y101.613 E.0085
G1 X82.834 Y101.256 E.00849
G1 X82.696 Y100.88 E.00849
G1 X82.603 Y100.493 E.00842
G1 X82.554 Y100.021 E.01004
G1 X82.574 Y99.499 E.01106
G1 X82.648 Y99.095 E.00869
G1 X82.767 Y98.712 E.00849
G1 X82.93 Y98.345 E.00849
G1 X83.248 Y97.845 E.01254
G1 X84.434 Y96.482 E.03824
G1 X79.467 Y96.482 E.10513
G1 X79.228 Y96.454 E.00508
G1 X79.027 Y96.38 E.00454
G1 X78.916 Y96.313 E.00274
G1 X78.83 Y96.243 E.00236
G1 X78.667 Y96.037 E.00554
G1 X78.579 Y95.812 E.00512
G1 X78.55 Y95.565 E.00527
G1 X78.55 Y77.628 E.37965
G1 X78.588 Y77.349 E.00597
G1 X78.697 Y77.118 E.00539
G1 X78.858 Y76.933 E.0052
G1 X79.074 Y76.797 E.00539
G1 X79.228 Y76.746 E.00343
G1 X79.388 Y76.723 E.00343
G1 X92.458 Y76.722 E.27662
G1 X92.578 Y76.734 E.00256
G1 X92.731 Y76.775 E.00335
G1 X92.96 Y76.904 E.00556
G1 X92.904 Y77.082 E.00395
G1 X79.876 Y77.082 E.27575
G1 X79.588 Y77.133 E.00621
G1 X79.31 Y77.282 E.00668
G1 X79.077 Y77.529 E.00717
G1 X78.948 Y77.807 E.00649
G1 X78.911 Y78.056 E.00533
G1 X78.911 Y95.155 E.36192
G1 X78.964 Y95.453 E.0064
G1 X79.147 Y95.77 E.00776
G1 X79.475 Y96.029 E.00884
G1 X79.858 Y96.12 E.00834
G1 X84.631 Y96.12 E.10103
; WIPE_START
M204 S6000
G1 X86.631 Y96.12 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X83.535 Y96.891 Z4.56 F18000
G1 Z4.16
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X79.443 Y96.891 E.08049
G1 X79.133 Y96.855 E.00613
G1 X78.849 Y96.751 E.00596
G1 X78.679 Y96.648 E.0039
G1 X78.547 Y96.54 E.00337
G1 X78.41 Y96.389 E.004
G1 X78.313 Y96.244 E.00342
G1 X78.248 Y96.114 E.00286
G1 X78.177 Y95.901 E.00442
G1 X78.141 Y95.589 E.00619
G1 X78.141 Y77.61 E.35362
G1 X78.161 Y77.374 E.00466
G1 X78.195 Y77.231 E.00289
G1 X78.245 Y77.093 E.00289
G1 X78.353 Y76.892 E.00448
G1 X78.495 Y76.714 E.00448
G1 X78.599 Y76.615 E.00283
G1 X78.788 Y76.483 E.00454
G1 X78.917 Y76.418 E.00283
G1 X79.133 Y76.346 E.00448
G1 X79.359 Y76.313 E.00448
G1 X92.479 Y76.313 E.25807
G1 X92.653 Y76.331 E.00343
G1 X92.871 Y76.389 E.00445
G1 X93.075 Y76.484 E.00442
G1 X93.259 Y76.613 E.00442
G1 X93.418 Y76.772 E.00442
G1 X93.547 Y76.956 E.00442
G1 X93.642 Y77.16 E.00442
G1 X93.7 Y77.377 E.00442
G1 X93.721 Y77.61 E.0046
G1 X93.721 Y85.511 E.1554
G1 X96.001 Y85.511 E.04485
G1 X96.324 Y85.269 E.00794
G1 X96.666 Y85.554 E.00876
G1 X96.666 Y87.648 E.04119
G1 X96.324 Y87.933 E.00876
G1 X96.001 Y87.691 E.00795
G1 X93.721 Y87.691 E.04485
G1 X93.721 Y88.791 E.02164
G1 X92.541 Y88.791 E.02321
G1 X92.541 Y77.491 E.22226
G1 X79.912 Y77.491 E.24839
G1 X79.724 Y77.524 E.00376
G1 X79.562 Y77.611 E.00361
G1 X79.42 Y77.762 E.00406
G1 X79.344 Y77.925 E.00355
G1 X79.321 Y78.086 E.00319
G1 X79.321 Y95.119 E.33504
G1 X79.354 Y95.311 E.00382
G1 X79.462 Y95.498 E.00425
G1 X79.657 Y95.652 E.00489
G1 X79.906 Y95.711 E.00503
G1 X92.121 Y95.711 E.24026
G1 X92.16 Y95.313 E.00786
G1 X92.223 Y95.109 E.00422
G1 X92.315 Y94.941 E.00376
G1 X92.426 Y94.806 E.00344
G1 X92.559 Y94.694 E.00342
G1 X92.743 Y94.591 E.00415
G1 X92.936 Y94.531 E.00397
G1 X93.109 Y94.512 E.00343
G1 X93.284 Y94.524 E.00345
G1 X93.455 Y94.566 E.00345
G1 X93.615 Y94.638 E.00345
G1 X93.76 Y94.738 E.00346
G1 X93.885 Y94.861 E.00346
G1 X93.986 Y95.005 E.00345
G1 X94.061 Y95.165 E.00348
G1 X94.1 Y95.306 E.00288
G1 X94.119 Y95.507 E.00397
G1 X94.089 Y95.742 E.00466
G1 X94.018 Y95.937 E.00408
G1 X93.912 Y96.107 E.00394
G1 X93.706 Y96.306 E.00563
G1 X93.57 Y96.387 E.00312
G1 X93.399 Y96.459 E.00365
G1 X93.256 Y96.592 E.00384
G1 X93.07 Y96.72 E.00444
G1 X92.868 Y96.814 E.00439
G1 X92.653 Y96.871 E.00438
G1 X92.421 Y96.891 E.00456
G1 X88.326 Y96.891 E.08055
M73 P79 R4
G1 X88.934 Y97.59 E.01822
G1 X89.063 Y97.767 E.00431
G1 X89.296 Y98.159 E.00897
G1 X89.391 Y98.356 E.00431
G1 X89.551 Y98.78 E.00891
G1 X89.659 Y99.22 E.00891
G1 X89.713 Y99.661 E.00873
G1 X89.714 Y100.112 E.00888
G1 X89.647 Y100.632 E.01031
G1 X89.488 Y101.209 E.01177
G1 X89.305 Y101.627 E.00897
G1 X89.08 Y102.009 E.00873
G1 X88.806 Y102.37 E.00891
G1 X88.492 Y102.694 E.00888
G1 X88.267 Y102.883 E.00577
G1 X87.955 Y103.105 E.00752
G1 X87.766 Y103.216 E.00432
G1 X87.355 Y103.413 E.00897
G1 X87.15 Y103.489 E.0043
G1 X86.713 Y103.609 E.00891
G1 X86.265 Y103.676 E.00891
G1 X86.046 Y103.689 E.00431
G1 X85.593 Y103.676 E.00891
G1 X85.145 Y103.608 E.00891
G1 X84.933 Y103.557 E.0043
G1 X84.501 Y103.411 E.00898
G1 X84.3 Y103.322 E.0043
G1 X83.904 Y103.103 E.00891
G1 X83.539 Y102.84 E.00885
G1 X83.207 Y102.536 E.00885
G1 X82.914 Y102.195 E.00885
G1 X82.663 Y101.821 E.00885
G1 X82.459 Y101.42 E.00885
G1 X82.303 Y100.998 E.00885
G1 X82.199 Y100.562 E.00883
G1 X82.145 Y100.04 E.01031
G1 X82.148 Y99.661 E.00746
G1 X82.169 Y99.443 E.00431
G1 X82.25 Y98.997 E.00891
G1 X82.383 Y98.567 E.00885
G1 X82.566 Y98.156 E.00885
G1 X82.798 Y97.767 E.00891
G1 X82.927 Y97.59 E.0043
M73 P80 R4
G1 X83.496 Y96.936 E.01705
; WIPE_START
M204 S6000
G1 X81.496 Y96.914 E-.38
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




G1 X79.359 Y96.245
G1 Z4.16
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.122092
G1 F1500
M204 S6000
G1 X79.255 Y96.187 E.00058
; LINE_WIDTH: 0.148716
G1 X79.15 Y96.128 E.00073
G1 X78.946 Y95.96 E.00163
G1 X78.778 Y95.627 E.00229
; WIPE_START
G1 X78.946 Y95.96 E-.18701
G1 X79.15 Y96.128 E-.13296
G1 X79.255 Y96.187 E-.06003
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X84.479 Y97.167 Z4.56 F18000
G1 Z4.16
G1 E.4 F1800
; LINE_WIDTH: 0.479801
G1 F1500
M204 S6000
G1 X84.248 Y97.353 E.00673
; LINE_WIDTH: 0.447028
G1 X84.119 Y97.473 E.00371
; LINE_WIDTH: 0.407527
G1 X83.974 Y97.609 E.00378
; LINE_WIDTH: 0.360115
G1 X83.715 Y97.882 E.00628
G1 X83.409 Y98.286 E.00846
G1 X83.268 Y98.523 E.00459
G1 X83.124 Y98.846 E.0059
G1 X83.023 Y99.187 E.00594
G1 X82.954 Y99.546 E.0061
G1 X82.932 Y100.005 E.00767
G1 X83.003 Y100.543 E.00905
G1 X83.098 Y100.881 E.00586
G1 X83.242 Y101.226 E.00623
G1 X83.544 Y101.716 E.0096
G1 X83.848 Y102.058 E.00763
G1 X84.266 Y102.395 E.00897
G1 X84.648 Y102.61 E.0073
G1 X85.15 Y102.796 E.00894
G1 X85.664 Y102.883 E.0087
G1 X85.954 Y102.896 E.00485
G1 X86.483 Y102.848 E.00886
G1 X86.864 Y102.751 E.00655
G1 X87.171 Y102.626 E.00554
G1 X87.638 Y102.363 E.00894
G1 X87.951 Y102.114 E.00667
G1 X88.202 Y101.854 E.00602
G1 X88.516 Y101.414 E.00902
G1 X88.673 Y101.106 E.00577
G1 X88.837 Y100.638 E.00827
G1 X88.906 Y100.249 E.0066
G1 X88.928 Y99.874 E.00627
G1 X88.885 Y99.372 E.00841
G1 X88.74 Y98.862 E.00884
G1 X88.595 Y98.532 E.00601
G1 X88.312 Y98.077 E.00894
G1 X88.049 Y97.775 E.00668
; LINE_WIDTH: 0.380247
G1 X87.877 Y97.605 E.00429
; LINE_WIDTH: 0.419789
G1 X87.678 Y97.411 E.00545
; LINE_WIDTH: 0.468125
G1 X87.38 Y97.162 E.00858
; WIPE_START
G1 X87.678 Y97.411 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X92.704 Y96.137 Z4.56 F18000
G1 Z4.16
G1 E.4 F1800
; LINE_WIDTH: 0.124038
G1 F1500
M204 S6000
G1 X92.837 Y96.07 E.00074
; LINE_WIDTH: 0.0986395
G1 X92.95 Y95.997 E.00049
; WIPE_START
G1 X92.837 Y96.07 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X93.439 Y88.461 Z4.56 F18000
G1 X93.586 Y86.601 Z4.56
G1 Z4.16
G1 E.4 F1800
; LINE_WIDTH: 0.114562
G1 F1500
M204 S6000
G1 X95.62 Y86.601 E.00901
; WIPE_START
G1 X93.62 Y86.601 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X87.308 Y82.311 Z4.56 F18000
G1 X79.424 Y76.954 Z4.56
G1 Z4.16
G1 E.4 F1800
; LINE_WIDTH: 0.0998273
G1 F1500
M204 S6000
G1 X79.289 Y76.999 E.00053
; LINE_WIDTH: 0.131257
G1 X79.136 Y77.071 E.00089
; LINE_WIDTH: 0.157139
G1 X78.932 Y77.274 E.00189
G1 X78.854 Y77.387 E.0009
; LINE_WIDTH: 0.106084
G1 X78.788 Y77.595 E.00087
; CHANGE_LAYER
; Z_HEIGHT: 4.28
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F1500
G1 X78.854 Y77.387 E-.38
; WIPE_END
G1 E-.02 F1800
; layer num/total_layer_count: 35/49
; update layer progress
M73 L35
M991 S0 P34 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z4.56 I-.02 J1.217 P1  F18000
G1 X93.311 Y77.628 Z4.56
G1 Z4.28
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X93.311 Y83.71 E.12872
G1 X92.95 Y83.71 E.00765
G1 X92.95 Y77.127 E.13932
G1 X93.128 Y77.071 E.00395
G1 X93.191 Y77.162 E.00234
G1 X93.256 Y77.3 E.00324
G1 X93.296 Y77.448 E.00324
G1 X93.306 Y77.568 E.00255
; WIPE_START
M204 S6000
G1 X93.308 Y79.568 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X93.286 Y87.201 Z4.68 F18000
G1 X93.262 Y95.424 Z4.68
G1 Z4.28
G1 E.4 F1800
G1 F1500
M204 S500
G1 X93.281 Y95.493 E.00151
G1 X93.264 Y95.571 E.00168
G1 X93.237 Y95.615 E.0011
G1 X93.193 Y95.641 E.00108
G1 X92.956 Y95.74 E.00544
G1 X92.981 Y95.479 E.00555
G1 X93.006 Y95.399 E.00177
G1 X93.074 Y95.361 E.00167
G1 X93.154 Y95.35 E.0017
G1 X93.205 Y95.368 E.00114
G1 X93.22 Y95.382 E.00043
; WIPE_START
M204 S6000
G1 X93.281 Y95.493 E-.04199
G1 X93.264 Y95.571 E-.02639
G1 X93.237 Y95.615 E-.01729
G1 X93.193 Y95.641 E-.01694
G1 X92.956 Y95.74 E-.08521
G1 X92.981 Y95.479 E-.087
G1 X93.006 Y95.399 E-.02773
G1 X93.074 Y95.361 E-.02614
G1 X93.154 Y95.35 E-.02667
G1 X93.205 Y95.368 E-.01792
G1 X93.22 Y95.382 E-.00671
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X85.739 Y96.898 Z4.68 F18000
G1 X84.708 Y97.107 Z4.68
G1 Z4.28
G1 E.4 F1800
G1 F1500
M204 S500
G1 X84.601 Y96.944 E.00411
G1 X84.953 Y96.544 E.01128
G1 X86.92 Y96.544 E.04164
G1 X87.273 Y96.951 E.0114
G1 X87.15 Y97.115 E.00436
G1 X87.029 Y97.059 E.00282
G1 X86.535 Y96.915 E.01089
G1 X86.161 Y96.864 E.00799
G1 X85.822 Y96.858 E.00717
G1 X85.258 Y96.928 E.01204
G1 X84.765 Y97.088 E.01097
; WIPE_START
M204 S6000
G1 X84.601 Y96.944 E-.04138
G1 X84.953 Y96.544 E-.10122
G1 X86.202 Y96.544 E-.23739
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X84.837 Y102.278 Z4.68 F18000
G1 Z4.28
G1 E.4 F1800
G1 F1500
M204 S500
G1 X84.486 Y102.089 E.00844
G1 X84.119 Y101.796 E.00995
G1 X83.807 Y101.439 E.01002
G1 X83.557 Y101.009 E.01053
G1 X83.45 Y100.746 E.00601
G1 X83.365 Y100.437 E.0068
G1 X83.31 Y99.979 E.00975
G1 X83.338 Y99.507 E.01002
G1 X83.461 Y99.025 E.01053
G1 X83.571 Y98.763 E.00601
G1 X83.727 Y98.482 E.0068
G1 X84.009 Y98.118 E.00975
G1 X84.351 Y97.809 E.00975
G1 X84.62 Y97.632 E.00683
G1 X84.909 Y97.487 E.00683
G1 X85.35 Y97.344 E.00982
G1 X85.844 Y97.282 E.01054
G1 X86.128 Y97.288 E.00601
G1 X86.446 Y97.331 E.0068
G1 X86.879 Y97.458 E.00955
G1 X87.172 Y97.593 E.00683
G1 X87.447 Y97.763 E.00683
G1 X87.798 Y98.061 E.00975
G1 X88.091 Y98.417 E.00975
G1 X88.256 Y98.694 E.00683
G1 X88.388 Y98.989 E.00683
G1 X88.51 Y99.433 E.00975
G1 X88.551 Y99.892 E.00975
G1 X88.532 Y100.212 E.0068
G1 X88.483 Y100.492 E.00601
G1 X88.327 Y100.964 E.01053
G1 X88.097 Y101.378 E.01002
G1 X87.798 Y101.741 E.00995
G1 X87.447 Y102.039 E.00975
G1 X87.172 Y102.208 E.00683
G1 X86.879 Y102.344 E.00683
G1 X86.437 Y102.473 E.00975
G1 X85.979 Y102.521 E.00975
G1 X85.657 Y102.507 E.00683
G1 X85.338 Y102.454 E.00684
G1 X84.9 Y102.312 E.00975
G1 X84.89 Y102.306 E.00024
M204 S250
G1 X85.031 Y101.917 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X84.713 Y101.746 E.00712
G1 X84.403 Y101.499 E.0078
G1 X84.141 Y101.199 E.00782
G1 X83.925 Y100.829 E.00844
G1 X83.839 Y100.615 E.00454
G1 X83.768 Y100.357 E.00525
G1 X83.721 Y99.967 E.00773
G1 X83.744 Y99.57 E.00782
G1 X83.851 Y99.155 E.00844
G1 X83.939 Y98.941 E.00454
G1 X84.069 Y98.708 E.00525
G1 X84.31 Y98.397 E.00774
G1 X84.602 Y98.134 E.00773
G1 X84.825 Y97.987 E.00526
G1 X85.065 Y97.867 E.00526
G1 X85.44 Y97.745 E.00775
G1 X85.865 Y97.692 E.00844
G1 X86.096 Y97.697 E.00454
G1 X86.361 Y97.733 E.00525
G1 X86.735 Y97.842 E.00767
G1 X86.978 Y97.954 E.00526
G1 X87.206 Y98.095 E.00526
G1 X87.506 Y98.349 E.00773
G1 X87.755 Y98.653 E.00773
G1 X87.892 Y98.883 E.00526
G1 X88.001 Y99.127 E.00526
G1 X88.106 Y99.506 E.00774
G1 X88.141 Y99.898 E.00773
G1 X88.125 Y100.164 E.00525
G1 X88.085 Y100.392 E.00454
G1 X87.951 Y100.799 E.00844
G1 X87.757 Y101.146 E.00782
G1 X87.506 Y101.452 E.0078
G1 X87.206 Y101.707 E.00773
G1 X86.978 Y101.847 E.00526
G1 X86.735 Y101.96 E.00526
G1 X86.358 Y102.07 E.00773
G1 X85.967 Y102.111 E.00774
G1 X85.7 Y102.099 E.00526
G1 X85.435 Y102.055 E.00527
G1 X85.086 Y101.942 E.00723
; WIPE_START
M204 S6000
G1 X84.713 Y101.746 E-.08006
G1 X84.403 Y101.499 E-.07533
G1 X84.141 Y101.199 E-.07553
G1 X83.925 Y100.829 E-.0815
G1 X83.839 Y100.615 E-.0439
G1 X83.806 Y100.495 E-.02368
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X84.704 Y96.12 Z4.68 F18000
G1 Z4.28
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X92.493 Y96.12 E.16486
G1 X92.563 Y95.396 E.01541
G1 X92.602 Y95.269 E.00281
G1 X92.655 Y95.172 E.00233
G1 X92.793 Y95.032 E.00416
G1 X92.907 Y94.969 E.00276
G1 X93.02 Y94.934 E.00251
G1 X93.22 Y94.93 E.00424
G1 X93.32 Y94.955 E.00218
G1 X93.414 Y94.997 E.00217
G1 X93.571 Y95.127 E.00433
G1 X93.631 Y95.211 E.00217
G1 X93.696 Y95.382 E.00389
G1 X93.708 Y95.5 E.00251
G1 X93.689 Y95.644 E.00307
G1 X93.647 Y95.758 E.00257
G1 X93.524 Y95.926 E.0044
G1 X93.384 Y96.021 E.00359
G1 X93.182 Y96.106 E.00463
G1 X92.874 Y96.36 E.00845
G1 X92.729 Y96.427 E.0034
G1 X92.582 Y96.466 E.00321
G1 X92.404 Y96.482 E.00378
G1 X87.428 Y96.482 E.10533
G1 X88.614 Y97.845 E.03824
G1 X88.72 Y97.992 E.00386
G1 X88.935 Y98.353 E.00888
G1 X89.159 Y98.901 E.01254
G1 X89.286 Y99.489 E.01273
G1 X89.305 Y100.087 E.01265
G1 X89.245 Y100.553 E.00995
G1 X89.104 Y101.066 E.01126
G1 X89.003 Y101.306 E.00551
G1 X88.843 Y101.616 E.00739
G1 X88.496 Y102.102 E.01263
G1 X88.212 Y102.395 E.00864
G1 X88.02 Y102.556 E.00531
G1 X87.739 Y102.756 E.00729
G1 X87.379 Y102.955 E.00872
G1 X87.024 Y103.099 E.00811
G1 X86.628 Y103.208 E.00868
G1 X86.222 Y103.269 E.00869
G1 X85.63 Y103.267 E.01254
G1 X85.047 Y103.164 E.01254
G1 X84.649 Y103.029 E.00888
G1 X84.123 Y102.757 E.01254
G1 X83.797 Y102.522 E.00849
G1 X83.502 Y102.251 E.00849
G1 X83.24 Y101.947 E.00849
G1 X83.017 Y101.613 E.0085
G1 X82.836 Y101.259 E.00841
G1 X82.679 Y100.816 E.00995
G1 X82.574 Y100.3 E.01115
G1 X82.551 Y99.89 E.00869
G1 X82.576 Y99.49 E.00849
G1 X82.648 Y99.095 E.0085
G1 X82.767 Y98.712 E.00849
G1 X82.93 Y98.345 E.0085
G1 X83.138 Y97.996 E.0086
G1 X83.288 Y97.795 E.00531
G1 X84.443 Y96.482 E.03701
G1 X79.467 Y96.482 E.10533
G1 X79.228 Y96.454 E.00508
G1 X78.955 Y96.34 E.00626
G1 X78.828 Y96.24 E.00343
G1 X78.72 Y96.119 E.00343
G1 X78.609 Y95.912 E.00497
G1 X78.579 Y95.818 E.00209
G1 X78.55 Y95.565 E.00539
G1 X78.55 Y77.628 E.37965
G1 X78.586 Y77.357 E.00578
G1 X78.691 Y77.125 E.00539
G1 X78.875 Y76.92 E.00582
G1 X78.99 Y76.841 E.00296
G1 X79.135 Y76.773 E.0034
G1 X79.386 Y76.723 E.00542
G1 X92.459 Y76.722 E.2767
G1 X92.578 Y76.734 E.00252
G1 X92.731 Y76.775 E.00336
G1 X92.96 Y76.904 E.00556
G1 X92.904 Y77.082 E.00395
G1 X79.877 Y77.082 E.27574
G1 X79.588 Y77.132 E.0062
G1 X79.31 Y77.282 E.00669
G1 X79.077 Y77.529 E.00717
G1 X78.948 Y77.807 E.00649
G1 X78.911 Y78.056 E.00533
G1 X78.911 Y95.155 E.36192
G1 X78.964 Y95.453 E.0064
G1 X79.152 Y95.778 E.00796
G1 X79.512 Y96.047 E.00951
G1 X79.867 Y96.12 E.00767
G1 X84.644 Y96.12 E.1011
; WIPE_START
M204 S6000
G1 X86.644 Y96.12 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X83.538 Y96.891 Z4.68 F18000
G1 Z4.28
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X79.443 Y96.891 E.08055
G1 X79.133 Y96.855 E.00613
G1 X78.846 Y96.75 E.00601
G1 X78.725 Y96.68 E.00277
G1 X78.546 Y96.539 E.00448
G1 X78.394 Y96.369 E.00448
G1 X78.315 Y96.248 E.00284
G1 X78.227 Y96.061 E.00406
G1 X78.177 Y95.903 E.00326
G1 X78.141 Y95.589 E.00623
G1 X78.141 Y77.61 E.35362
G1 X78.161 Y77.374 E.00466
G1 X78.194 Y77.234 E.00283
G1 X78.28 Y77.019 E.00454
G1 X78.352 Y76.895 E.00283
G1 X78.494 Y76.715 E.00452
G1 X78.618 Y76.6 E.00332
G1 X78.785 Y76.485 E.004
G1 X78.991 Y76.389 E.00447
G1 X79.154 Y76.342 E.00332
G1 X79.358 Y76.313 E.00406
G1 X92.481 Y76.313 E.25811
G1 X92.653 Y76.331 E.0034
G1 X92.872 Y76.389 E.00446
G1 X93.075 Y76.484 E.00442
G1 X93.259 Y76.613 E.00442
G1 X93.418 Y76.772 E.00442
G1 X93.547 Y76.956 E.00442
G1 X93.642 Y77.16 E.00442
G1 X93.7 Y77.377 E.00442
G1 X93.721 Y77.61 E.0046
G1 X93.721 Y85.511 E.1554
G1 X96.001 Y85.511 E.04485
G1 X96.324 Y85.269 E.00794
G1 X96.535 Y85.445 E.00541
G1 X96.535 Y87.757 E.04548
G1 X96.324 Y87.933 E.00541
G1 X96.001 Y87.691 E.00795
G1 X93.721 Y87.691 E.04485
G1 X93.721 Y88.791 E.02164
G1 X92.541 Y88.791 E.02321
G1 X92.541 Y77.491 E.22226
G1 X79.912 Y77.491 E.24839
G1 X79.724 Y77.524 E.00376
G1 X79.562 Y77.611 E.00362
G1 X79.42 Y77.762 E.00406
G1 X79.344 Y77.925 E.00355
G1 X79.321 Y78.086 E.00319
G1 X79.321 Y95.119 E.33504
G1 X79.354 Y95.311 E.00382
G1 X79.464 Y95.501 E.00432
G1 X79.684 Y95.664 E.00539
G1 X79.909 Y95.711 E.00452
G1 X92.121 Y95.711 E.2402
G1 X92.16 Y95.315 E.00783
G1 X92.223 Y95.108 E.00425
G1 X92.315 Y94.942 E.00374
G1 X92.426 Y94.807 E.00344
G1 X92.558 Y94.694 E.00342
G1 X92.745 Y94.591 E.00419
G1 X92.935 Y94.531 E.00393
G1 X93.109 Y94.512 E.00343
G1 X93.284 Y94.524 E.00345
G1 X93.454 Y94.566 E.00346
G1 X93.615 Y94.638 E.00345
G1 X93.76 Y94.738 E.00346
G1 X93.885 Y94.861 E.00345
G1 X93.986 Y95.004 E.00346
G1 X94.061 Y95.164 E.00348
G1 X94.1 Y95.307 E.00292
G1 X94.119 Y95.507 E.00393
G1 X94.089 Y95.742 E.00466
G1 X94.017 Y95.939 E.00413
G1 X93.912 Y96.107 E.00389
G1 X93.706 Y96.306 E.00564
G1 X93.569 Y96.388 E.00315
G1 X93.402 Y96.457 E.00356
G1 X93.192 Y96.641 E.00548
G1 X93.073 Y96.719 E.00281
G1 X92.868 Y96.814 E.00444
G1 X92.653 Y96.871 E.00438
G1 X92.421 Y96.891 E.00456
G1 X88.326 Y96.891 E.08055
G1 X88.934 Y97.59 E.01823
G1 X89.063 Y97.767 E.0043
M73 P81 R4
G1 X89.296 Y98.159 E.00897
G1 X89.391 Y98.356 E.00431
G1 X89.551 Y98.78 E.00891
G1 X89.659 Y99.22 E.00891
G1 X89.713 Y99.661 E.00873
G1 X89.714 Y100.112 E.00888
G1 X89.648 Y100.628 E.01022
G1 X89.557 Y101.001 E.00755
G1 X89.374 Y101.48 E.01008
G1 X89.197 Y101.822 E.00758
G1 X89.04 Y102.065 E.00569
G1 X88.806 Y102.369 E.00755
G1 X88.491 Y102.694 E.0089
G1 X88.271 Y102.88 E.00567
G1 X87.958 Y103.103 E.00756
G1 X87.561 Y103.322 E.00892
G1 X87.15 Y103.489 E.00873
G1 X86.713 Y103.609 E.00891
G1 X86.265 Y103.676 E.00891
G1 X86.046 Y103.689 E.00431
G1 X85.593 Y103.676 E.00891
G1 X85.145 Y103.608 E.00891
G1 X84.933 Y103.557 E.0043
G1 X84.501 Y103.411 E.00898
G1 X84.3 Y103.322 E.0043
G1 X83.904 Y103.103 E.00891
G1 X83.539 Y102.84 E.00885
G1 X83.207 Y102.536 E.00885
G1 X82.914 Y102.195 E.00885
G1 X82.663 Y101.821 E.00885
G1 X82.459 Y101.421 E.00882
G1 X82.285 Y100.932 E.01022
G1 X82.198 Y100.558 E.00755
G1 X82.166 Y100.341 E.00431
G1 X82.141 Y99.889 E.00891
G1 X82.169 Y99.44 E.00885
G1 X82.25 Y98.997 E.00885
G1 X82.383 Y98.567 E.00885
G1 X82.566 Y98.156 E.00885
G1 X82.798 Y97.768 E.00888
G1 X82.97 Y97.537 E.00568
G1 X83.499 Y96.936 E.01574
; WIPE_START
M204 S6000
G1 X81.499 Y96.914 E-.38
; WIPE_END
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




G1 X79.376 Y96.249
G1 Z4.28
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.149196
G1 F1500
M204 S6000
G1 X79.143 Y96.123 E.00163
G1 X79.021 Y96.033 E.00093
G1 X78.939 Y95.954 E.0007
G1 X78.862 Y95.816 E.00098
; LINE_WIDTH: 0.125232
G1 X78.827 Y95.719 E.00051
; LINE_WIDTH: 0.0938705
G1 X78.792 Y95.622 E.00035
; WIPE_START
G1 X78.827 Y95.719 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X84.489 Y97.16 Z4.68 F18000
G1 Z4.28
G1 E.4 F1800
; LINE_WIDTH: 0.476993
G1 F1500
M204 S6000
G1 X84.303 Y97.316 E.00546
; LINE_WIDTH: 0.436989
G1 X84.091 Y97.497 E.00571
; LINE_WIDTH: 0.399358
G1 X83.917 Y97.673 E.00463
; LINE_WIDTH: 0.360206
G1 X83.587 Y98.036 E.00819
G1 X83.418 Y98.264 E.00472
G1 X83.269 Y98.521 E.00496
G1 X83.107 Y98.894 E.00679
G1 X82.969 Y99.433 E.00929
G1 X82.933 Y99.889 E.00763
G1 X82.978 Y100.416 E.00882
G1 X83.045 Y100.709 E.00501
G1 X83.186 Y101.108 E.00707
G1 X83.349 Y101.418 E.00584
G1 X83.544 Y101.716 E.00594
G1 X83.869 Y102.078 E.00812
G1 X84.291 Y102.412 E.00897
G1 X84.765 Y102.665 E.00897
G1 X85.237 Y102.817 E.00827
G1 X85.627 Y102.884 E.00661
G1 X85.978 Y102.9 E.00586
G1 X86.525 Y102.841 E.00918
G1 X86.904 Y102.736 E.00657
G1 X87.342 Y102.545 E.00798
G1 X87.658 Y102.351 E.00619
G1 X87.95 Y102.114 E.00627
G1 X88.203 Y101.853 E.00606
G1 X88.511 Y101.422 E.00883
G1 X88.675 Y101.1 E.00603
G1 X88.845 Y100.595 E.0089
G1 X88.906 Y100.247 E.0059
G1 X88.928 Y99.874 E.00623
G1 X88.885 Y99.372 E.00841
G1 X88.793 Y99.017 E.00611
G1 X88.599 Y98.53 E.00875
G1 X88.31 Y98.08 E.00893
G1 X88.058 Y97.784 E.00648
; LINE_WIDTH: 0.378794
G1 X87.881 Y97.609 E.00438
; LINE_WIDTH: 0.419282
G1 X87.678 Y97.411 E.00556
; LINE_WIDTH: 0.46811
G1 X87.38 Y97.162 E.00858
; WIPE_START
G1 X87.678 Y97.411 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X92.704 Y96.138 Z4.68 F18000
G1 Z4.28
G1 E.4 F1800
; LINE_WIDTH: 0.12753
G1 F1500
M204 S6000
G1 X92.867 Y96.049 E.00095
; LINE_WIDTH: 0.0933146
G1 X92.95 Y95.997 E.00033
; WIPE_START
G1 X92.867 Y96.049 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X94.743 Y88.65 Z4.68 F18000
G1 X95.485 Y85.728 Z4.68
G1 Z4.28
G1 E.4 F1800
; FEATURE: Top surface
; LINE_WIDTH: 0.42
G1 F1500
M204 S2000
G1 X96.318 Y86.561 E.02319
G1 X96.318 Y87.119
G1 X94.927 Y85.728 E.0387
G1 X94.369 Y85.728
G1 X96.245 Y87.603 E.05216
G1 X95.558 Y87.474
G1 X93.812 Y85.728 E.04858
G1 X93.504 Y84.862
G1 X92.833 Y84.191 E.01865
G1 X92.811 Y84.727
G1 X93.504 Y85.42 E.01926
G1 X92.811 Y85.285
G1 X95.001 Y87.474 E.0609
G1 X94.443 Y87.474
G1 X92.811 Y85.842 E.04539
G1 X92.811 Y86.4
G1 X93.886 Y87.474 E.02989
G1 X93.504 Y87.65
G1 X92.811 Y86.957 E.01926
G1 X92.811 Y87.515
G1 X93.504 Y88.207 E.01926
G1 X93.313 Y88.574
G1 X92.811 Y88.072 E.01396
; WIPE_START
M204 S6000
G1 X93.313 Y88.574 E-.13482
G1 X93.504 Y88.207 E-.07856
G1 X92.884 Y87.587 E-.16662
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X96.338 Y85.529 Z4.68 F18000
G1 Z4.28
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.376754
G1 F1500
M204 S6000
G1 X96.157 Y85.865 E.00669
; LINE_WIDTH: 0.364273
G1 X95.984 Y85.821 E.00301
; LINE_WIDTH: 0.316699
G1 X95.812 Y85.776 E.00258
; WIPE_START
G1 X95.984 Y85.821 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X93.481 Y85.675 Z4.68 F18000
G1 Z4.28
G1 E.4 F1800
; LINE_WIDTH: 0.0827709
G1 F1500
M204 S6000
G1 X93.502 Y85.54 E.00039
M204 S10000
G1 X93.596 Y85.764 F18000
; LINE_WIDTH: 0.0756839
G1 F1500
M204 S6000
G1 X93.523 Y85.649 E.00034
M204 S10000
G1 X92.834 Y85.029 F18000
; LINE_WIDTH: 0.0827796
G1 F1500
M204 S6000
G1 X92.813 Y85.164 E.00039
; WIPE_START
G1 X92.834 Y85.029 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X92.901 Y84.031 Z4.68 F18000
G1 Z4.28
G1 E.4 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.365752
G1 F1500
M204 S6000
G1 X93.402 Y83.988 E.00854
; WIPE_START
G1 X92.901 Y84.031 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X86.144 Y80.482 Z4.68 F18000
G1 X79.426 Y76.954 Z4.68
G1 Z4.28
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.099244
G1 F1500
M204 S6000
G1 X79.295 Y76.997 E.0005
; LINE_WIDTH: 0.145011
G1 X79.137 Y77.072 E.00104
G1 X79.056 Y77.139 E.00063
G1 X78.895 Y77.323 E.00145
G1 X78.835 Y77.433 E.00075
; LINE_WIDTH: 0.0998677
G1 X78.788 Y77.595 E.00062
; CHANGE_LAYER
; Z_HEIGHT: 4.4
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F1500
G1 X78.835 Y77.433 E-.38
; WIPE_END
G1 E-.02 F1800
; layer num/total_layer_count: 36/49
; update layer progress
M73 L36
M991 S0 P35 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z4.68 I-.259 J1.189 P1  F18000
G1 X93.304 Y80.581 Z4.68
G1 Z4.4
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X93.311 Y88.382 E.1651
G1 X92.95 Y88.382 E.00764
G1 X92.95 Y77.128 E.23818
G1 X93.135 Y77.076 E.00407
G1 X93.216 Y77.207 E.00325
G1 X93.272 Y77.349 E.00324
G1 X93.301 Y77.49 E.00305
G1 X93.304 Y80.521 E.06416
; WIPE_START
M204 S6000
G1 X93.306 Y82.521 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X93.28 Y90.154 Z4.8 F18000
G1 X93.262 Y95.424 Z4.8
G1 Z4.4
G1 E.4 F1800
G1 F1500
M204 S500
G1 X93.284 Y95.47 E.00107
G1 X93.264 Y95.572 E.00219
G1 X93.237 Y95.615 E.00109
G1 X93.192 Y95.642 E.0011
G1 X92.956 Y95.74 E.00542
G1 X92.981 Y95.48 E.00553
G1 X93.006 Y95.399 E.00179
G1 X93.075 Y95.361 E.00169
G1 X93.154 Y95.35 E.00168
G1 X93.205 Y95.368 E.00114
G1 X93.22 Y95.382 E.00043
; WIPE_START
M204 S6000
G1 X93.284 Y95.47 E-.03591
G1 X93.264 Y95.572 E-.03414
G1 X93.237 Y95.615 E-.01694
G1 X93.192 Y95.642 E-.01717
G1 X92.956 Y95.74 E-.08453
G1 X92.981 Y95.48 E-.08635
G1 X93.006 Y95.399 E-.02786
G1 X93.075 Y95.361 E-.02633
G1 X93.154 Y95.35 E-.02616
G1 X93.205 Y95.368 E-.01786
G1 X93.22 Y95.382 E-.00676
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X85.739 Y96.899 Z4.8 F18000
G1 X84.696 Y97.11 Z4.8
G1 Z4.4
G1 E.4 F1800
G1 F1500
M204 S500
G1 X84.589 Y96.949 E.0041
G1 X84.941 Y96.544 E.01135
G1 X86.92 Y96.544 E.04188
G1 X87.274 Y96.951 E.0114
G1 X87.15 Y97.115 E.00436
G1 X87.029 Y97.059 E.00282
G1 X86.535 Y96.915 E.01089
G1 X86.161 Y96.864 E.00799
G1 X85.819 Y96.858 E.00723
G1 X85.257 Y96.928 E.01198
G1 X84.753 Y97.092 E.01122
; WIPE_START
M204 S6000
G1 X84.589 Y96.949 E-.04131
G1 X84.941 Y96.544 E-.10189
G1 X86.188 Y96.544 E-.2368
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X84.836 Y102.277 Z4.8 F18000
G1 Z4.4
G1 E.4 F1800
G1 F1500
M204 S500
G1 X84.486 Y102.089 E.00841
G1 X84.119 Y101.796 E.00995
G1 X83.81 Y101.442 E.00995
G1 X83.573 Y101.046 E.00975
G1 X83.451 Y100.749 E.0068
G1 X83.374 Y100.473 E.00606
G1 X83.31 Y99.982 E.01048
G1 X83.338 Y99.51 E.01002
G1 X83.449 Y99.054 E.00994
G1 X83.637 Y98.633 E.00976
G1 X83.811 Y98.361 E.00683
G1 X84.016 Y98.111 E.00683
G1 X84.351 Y97.809 E.00956
G1 X84.62 Y97.632 E.00683
G1 X84.909 Y97.487 E.00683
G1 X85.35 Y97.344 E.00981
G1 X85.841 Y97.282 E.01048
G1 X86.128 Y97.288 E.00607
G1 X86.446 Y97.331 E.0068
G1 X86.879 Y97.458 E.00955
G1 X87.172 Y97.593 E.00683
G1 X87.447 Y97.763 E.00683
G1 X87.798 Y98.061 E.00975
G1 X88.091 Y98.417 E.00975
G1 X88.256 Y98.692 E.0068
G1 X88.373 Y98.954 E.00607
G1 X88.51 Y99.43 E.01048
G1 X88.551 Y99.892 E.00982
G1 X88.532 Y100.212 E.0068
G1 X88.482 Y100.494 E.00606
G1 X88.327 Y100.965 E.01048
G1 X88.097 Y101.378 E.01002
G1 X87.798 Y101.741 E.00995
G1 X87.437 Y102.047 E.01001
G1 X87.006 Y102.29 E.01048
G1 X86.739 Y102.393 E.00606
G1 X86.428 Y102.474 E.0068
G1 X85.967 Y102.523 E.00982
G1 X85.473 Y102.481 E.01048
G1 X85.194 Y102.416 E.00606
G1 X84.892 Y102.307 E.0068
G1 X84.889 Y102.306 E.00007
M204 S250
G1 X85.03 Y101.917 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X84.713 Y101.746 E.00709
G1 X84.403 Y101.499 E.00779
G1 X84.142 Y101.2 E.0078
G1 X83.94 Y100.863 E.00774
G1 X83.839 Y100.616 E.00525
G1 X83.776 Y100.391 E.00459
G1 X83.721 Y99.968 E.00839
G1 X83.744 Y99.571 E.00782
G1 X83.838 Y99.186 E.00779
G1 X83.998 Y98.827 E.00774
G1 X84.142 Y98.602 E.00526
G1 X84.312 Y98.395 E.00526
G1 X84.602 Y98.134 E.00767
G1 X84.825 Y97.987 E.00526
G1 X85.065 Y97.867 E.00526
G1 X85.439 Y97.745 E.00775
G1 X85.863 Y97.692 E.00839
G1 X86.096 Y97.697 E.00459
G1 X86.361 Y97.733 E.00525
G1 X86.735 Y97.842 E.00767
G1 X86.978 Y97.954 E.00526
G1 X87.206 Y98.095 E.00526
G1 X87.506 Y98.349 E.00773
G1 X87.755 Y98.653 E.00773
G1 X87.892 Y98.882 E.00525
G1 X87.988 Y99.095 E.00459
G1 X88.106 Y99.505 E.00839
G1 X88.141 Y99.898 E.00775
G1 X88.125 Y100.164 E.00525
G1 X88.085 Y100.394 E.00459
G1 X87.951 Y100.799 E.00839
G1 X87.757 Y101.146 E.00782
G1 X87.506 Y101.452 E.00779
G1 X87.202 Y101.709 E.00782
G1 X86.831 Y101.919 E.00839
G1 X86.613 Y102.003 E.00459
G1 X86.355 Y102.07 E.00525
G1 X85.963 Y102.112 E.00776
G1 X85.538 Y102.075 E.00839
G1 X85.31 Y102.022 E.00459
G1 X85.085 Y101.942 E.00471
; WIPE_START
M204 S6000
G1 X84.713 Y101.746 E-.07987
G1 X84.403 Y101.499 E-.07529
G1 X84.142 Y101.2 E-.07531
G1 X83.94 Y100.863 E-.07473
G1 X83.839 Y100.616 E-.05074
G1 X83.805 Y100.494 E-.02406
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X84.691 Y96.12 Z4.8 F18000
G1 Z4.4
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X92.493 Y96.12 E.16513
G1 X92.563 Y95.396 E.01539
G1 X92.602 Y95.268 E.00285
G1 X92.655 Y95.173 E.0023
G1 X92.792 Y95.033 E.00416
G1 X92.908 Y94.968 E.0028
G1 X93.019 Y94.934 E.00247
G1 X93.22 Y94.93 E.00425
G1 X93.32 Y94.954 E.00218
G1 X93.498 Y95.054 E.00433
G1 X93.571 Y95.126 E.00217
G1 X93.631 Y95.21 E.00217
G1 X93.697 Y95.383 E.00392
G1 X93.708 Y95.499 E.00247
G1 X93.689 Y95.644 E.00308
G1 X93.647 Y95.759 E.0026
G1 X93.524 Y95.926 E.0044
G1 X93.383 Y96.022 E.0036
G1 X93.174 Y96.109 E.0048
G1 X92.999 Y96.272 E.00507
G1 X92.866 Y96.364 E.0034
G1 X92.729 Y96.427 E.00321
G1 X92.582 Y96.466 E.00321
G1 X92.404 Y96.482 E.00379
G1 X87.428 Y96.482 E.10532
G1 X88.614 Y97.845 E.03825
G1 X88.721 Y97.992 E.00386
G1 X88.935 Y98.353 E.00888
G1 X89.159 Y98.901 E.01254
G1 X89.286 Y99.49 E.01274
G1 X89.305 Y100.087 E.01266
G1 X89.246 Y100.549 E.00985
G1 X89.105 Y101.061 E.01125
M73 P82 R4
G1 X88.847 Y101.61 E.01284
G1 X88.496 Y102.102 E.01279
G1 X88.216 Y102.391 E.00852
G1 X87.897 Y102.65 E.00869
G1 X87.379 Y102.955 E.01273
G1 X87.024 Y103.099 E.00811
G1 X86.628 Y103.208 E.00869
G1 X86.222 Y103.269 E.00868
G1 X85.63 Y103.267 E.01254
G1 X85.038 Y103.161 E.01273
G1 X84.474 Y102.951 E.01273
G1 X84.123 Y102.757 E.0085
G1 X83.797 Y102.522 E.00849
G1 X83.502 Y102.251 E.00849
G1 X83.24 Y101.947 E.00849
G1 X83.017 Y101.613 E.0085
G1 X82.836 Y101.259 E.00842
G1 X82.68 Y100.821 E.00984
G1 X82.574 Y100.3 E.01125
G1 X82.551 Y99.89 E.00869
G1 X82.576 Y99.49 E.00849
G1 X82.648 Y99.095 E.00849
G1 X82.767 Y98.712 E.00849
G1 X82.93 Y98.345 E.00849
G1 X83.248 Y97.845 E.01254
G1 X84.433 Y96.482 E.03824
G1 X79.467 Y96.482 E.10513
G1 X79.219 Y96.453 E.00527
G1 X79.074 Y96.405 E.00324
G1 X78.858 Y96.269 E.0054
G1 X78.691 Y96.076 E.0054
G1 X78.578 Y95.803 E.00626
G1 X78.55 Y95.565 E.00508
G1 X78.55 Y77.628 E.37965
G1 X78.587 Y77.352 E.0059
G1 X78.696 Y77.12 E.00542
G1 X78.873 Y76.921 E.00564
G1 X78.99 Y76.841 E.00299
G1 X79.135 Y76.773 E.0034
G1 X79.387 Y76.723 E.00542
G1 X92.452 Y76.722 E.27653
G1 X92.636 Y76.747 E.00394
G1 X92.779 Y76.794 E.00318
G1 X92.955 Y76.889 E.00424
G1 X92.906 Y77.082 E.0042
G1 X79.876 Y77.082 E.27579
G1 X79.588 Y77.132 E.0062
G1 X79.31 Y77.282 E.00669
G1 X79.078 Y77.529 E.00717
G1 X78.948 Y77.807 E.00649
G1 X78.911 Y78.056 E.00533
G1 X78.911 Y95.155 E.36192
G1 X78.964 Y95.453 E.0064
G1 X79.152 Y95.778 E.00796
G1 X79.513 Y96.047 E.00952
G1 X79.867 Y96.12 E.00767
G1 X84.631 Y96.12 E.10083
; WIPE_START
M204 S6000
G1 X86.631 Y96.12 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X83.535 Y96.891 Z4.8 F18000
G1 Z4.4
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X79.443 Y96.891 E.08049
G1 X79.13 Y96.854 E.00619
G1 X78.917 Y96.784 E.00442
G1 X78.789 Y96.719 E.00283
G1 X78.599 Y96.587 E.00454
G1 X78.495 Y96.488 E.00283
G1 X78.351 Y96.307 E.00454
G1 X78.281 Y96.185 E.00277
G1 X78.177 Y95.898 E.00601
G1 X78.141 Y95.589 E.00613
G1 X78.141 Y77.61 E.35362
G1 X78.161 Y77.374 E.00466
G1 X78.195 Y77.232 E.00287
G1 X78.255 Y77.073 E.00335
G1 X78.353 Y76.893 E.00403
G1 X78.494 Y76.715 E.00447
G1 X78.617 Y76.601 E.00329
G1 X78.785 Y76.485 E.00403
G1 X78.991 Y76.389 E.00447
G1 X79.152 Y76.342 E.00329
G1 X79.358 Y76.313 E.00409
G1 X92.479 Y76.313 E.25809
G1 X92.729 Y76.347 E.00495
G1 X92.941 Y76.417 E.0044
G1 X93.139 Y76.524 E.00442
G1 X93.315 Y76.663 E.00442
G1 X93.465 Y76.831 E.00442
G1 X93.583 Y77.022 E.00442
G1 X93.666 Y77.231 E.00442
G1 X93.71 Y77.448 E.00436
G1 X93.72 Y88.791 E.2231
G1 X92.541 Y88.791 E.02321
G1 X92.541 Y77.491 E.22226
G1 X79.912 Y77.491 E.24839
G1 X79.724 Y77.524 E.00376
G1 X79.562 Y77.611 E.00362
G1 X79.42 Y77.761 E.00406
G1 X79.344 Y77.925 E.00356
G1 X79.321 Y78.086 E.00319
G1 X79.321 Y95.119 E.33504
G1 X79.354 Y95.311 E.00382
G1 X79.464 Y95.5 E.00431
G1 X79.684 Y95.664 E.0054
G1 X79.909 Y95.711 E.00452
G1 X92.121 Y95.711 E.2402
G1 X92.159 Y95.316 E.00781
G1 X92.223 Y95.107 E.00429
G1 X92.314 Y94.942 E.00371
G1 X92.426 Y94.807 E.00344
G1 X92.558 Y94.695 E.00342
G1 X92.746 Y94.59 E.00422
G1 X92.935 Y94.531 E.00389
G1 X93.108 Y94.512 E.00343
G1 X93.283 Y94.524 E.00345
G1 X93.454 Y94.566 E.00346
G1 X93.614 Y94.638 E.00345
G1 X93.759 Y94.737 E.00345
G1 X93.884 Y94.86 E.00345
G1 X93.986 Y95.004 E.00346
G1 X94.061 Y95.164 E.00348
G1 X94.101 Y95.309 E.00295
G1 X94.119 Y95.506 E.00389
G1 X94.09 Y95.741 E.00466
G1 X94.017 Y95.94 E.00416
G1 X93.913 Y96.106 E.00387
G1 X93.706 Y96.305 E.00564
G1 X93.568 Y96.388 E.00318
G1 X93.399 Y96.458 E.00359
G1 X93.256 Y96.592 E.00385
G1 X93.07 Y96.72 E.00444
G1 X92.868 Y96.814 E.00438
G1 X92.653 Y96.871 E.00438
G1 X92.421 Y96.891 E.00456
G1 X88.326 Y96.891 E.08055
G1 X88.934 Y97.59 E.01823
G1 X89.063 Y97.767 E.0043
G1 X89.296 Y98.159 E.00897
G1 X89.391 Y98.356 E.00431
G1 X89.551 Y98.78 E.00891
G1 X89.659 Y99.22 E.00891
G1 X89.713 Y99.661 E.00873
G1 X89.714 Y100.112 E.00889
G1 X89.649 Y100.623 E.01013
G1 X89.488 Y101.209 E.01194
G1 X89.305 Y101.627 E.00897
G1 X89.043 Y102.061 E.00998
G1 X88.806 Y102.369 E.00765
G1 X88.493 Y102.693 E.00886
G1 X88.141 Y102.979 E.00891
G1 X87.96 Y103.102 E.00431
G1 X87.561 Y103.322 E.00897
G1 X87.358 Y103.412 E.00437
G1 X87.15 Y103.489 E.00437
G1 X86.713 Y103.609 E.00891
G1 X86.265 Y103.676 E.00891
G1 X86.046 Y103.689 E.00431
G1 X85.593 Y103.676 E.00891
G1 X85.145 Y103.608 E.00891
G1 X84.93 Y103.556 E.00436
G1 X84.717 Y103.491 E.00437
G1 X84.298 Y103.321 E.00891
G1 X83.904 Y103.103 E.00885
G1 X83.539 Y102.84 E.00885
G1 X83.207 Y102.536 E.00885
G1 X82.914 Y102.195 E.00885
G1 X82.663 Y101.821 E.00885
G1 X82.459 Y101.421 E.00883
G1 X82.287 Y100.936 E.01012
G1 X82.198 Y100.558 E.00765
G1 X82.166 Y100.341 E.00431
G1 X82.141 Y99.889 E.00891
G1 X82.169 Y99.44 E.00885
G1 X82.25 Y98.997 E.00885
G1 X82.383 Y98.567 E.00885
G1 X82.566 Y98.156 E.00885
G1 X82.798 Y97.767 E.00891
G1 X82.927 Y97.59 E.0043
G1 X83.496 Y96.936 E.01705
; WIPE_START
M204 S6000
G1 X81.496 Y96.914 E-.38
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




G1 X79.318 Y96.245
G1 Z4.4
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.148793
G1 F1500
M204 S6000
G1 X78.955 Y95.969 E.0028
G1 X78.901 Y95.892 E.00058
G1 X78.778 Y95.627 E.0018
; WIPE_START
G1 X78.901 Y95.892 E-.13211
G1 X78.955 Y95.969 E-.04242
G1 X79.318 Y96.245 E-.20547
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X84.478 Y97.165 Z4.8 F18000
G1 Z4.4
G1 E.4 F1800
; LINE_WIDTH: 0.477113
G1 F1500
M204 S6000
G1 X84.297 Y97.319 E.00533
; LINE_WIDTH: 0.438415
G1 X84.09 Y97.496 E.00561
; LINE_WIDTH: 0.40102
G1 X83.921 Y97.669 E.00453
; LINE_WIDTH: 0.360257
G1 X83.55 Y98.078 E.00922
G1 X83.3 Y98.465 E.00769
G1 X83.098 Y98.918 E.00828
G1 X82.968 Y99.439 E.00897
G1 X82.934 Y99.98 E.00904
G1 X82.979 Y100.415 E.0073
G1 X83.046 Y100.713 E.00509
G1 X83.187 Y101.108 E.00699
G1 X83.348 Y101.418 E.00585
G1 X83.544 Y101.716 E.00594
G1 X83.869 Y102.078 E.00813
G1 X84.291 Y102.412 E.00897
G1 X84.727 Y102.647 E.00827
G1 X85.078 Y102.775 E.00624
G1 X85.426 Y102.855 E.00595
G1 X85.955 Y102.896 E.00885
G1 X86.483 Y102.848 E.00885
G1 X86.864 Y102.751 E.00656
G1 X87.21 Y102.613 E.00621
G1 X87.666 Y102.348 E.00881
G1 X87.956 Y102.109 E.00628
G1 X88.203 Y101.853 E.00592
G1 X88.516 Y101.414 E.009
G1 X88.675 Y101.101 E.00587
G1 X88.844 Y100.598 E.00886
G1 X88.906 Y100.247 E.00595
G1 X88.928 Y99.874 E.00624
G1 X88.885 Y99.372 E.00841
G1 X88.792 Y99.017 E.00611
G1 X88.599 Y98.53 E.00874
G1 X88.31 Y98.08 E.00894
G1 X88.058 Y97.784 E.00648
; LINE_WIDTH: 0.378814
G1 X87.881 Y97.609 E.00438
; LINE_WIDTH: 0.419315
G1 X87.678 Y97.411 E.00557
; LINE_WIDTH: 0.46812
G1 X87.38 Y97.162 E.00857
; WIPE_START
G1 X87.678 Y97.411 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X92.704 Y96.137 Z4.8 F18000
G1 Z4.4
G1 E.4 F1800
; LINE_WIDTH: 0.124503
G1 F1500
M204 S6000
G1 X92.837 Y96.069 E.00073
; LINE_WIDTH: 0.0988917
G1 X92.951 Y95.996 E.00049
; WIPE_START
G1 X92.837 Y96.069 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X88.217 Y89.994 Z4.8 F18000
G1 X78.788 Y77.595 Z4.8
G1 Z4.4
G1 E.4 F1800
; LINE_WIDTH: 0.105675
G1 F1500
M204 S6000
G1 X78.855 Y77.387 E.00087
; LINE_WIDTH: 0.148734
G1 X79.054 Y77.141 E.00194
G1 X79.137 Y77.072 E.00066
G1 X79.294 Y76.997 E.00107
; LINE_WIDTH: 0.0993979
G1 X79.425 Y76.954 E.00051
; WIPE_START
G1 X79.294 Y76.997 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X85.714 Y81.124 Z4.8 F18000
G1 X96.172 Y87.847 Z4.8
G1 Z4.4
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.376624
G1 F1500
M204 S500
G1 X96.172 Y85.355 E.04362
G1 X96.324 Y85.241 E.00333
G1 X96.351 Y85.263 E.0006
G1 X96.426 Y85.325 E.00171
G1 X96.426 Y87.876 E.04465
G1 X96.324 Y87.961 E.00231
G1 X96.22 Y87.883 E.00228
; CHANGE_LAYER
; Z_HEIGHT: 4.52
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F1500
M204 S6000
G1 X96.182 Y85.883 E-.38
; WIPE_END
G1 E-.02 F1800
; layer num/total_layer_count: 37/49
; update layer progress
M73 L37
M991 S0 P36 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z4.8 I1.07 J-.581 P1  F18000
G1 X93.304 Y80.582 Z4.8
G1 Z4.52
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X93.311 Y88.382 E.1651
G1 X92.95 Y88.382 E.00764
G1 X92.95 Y77.128 E.23818
G1 X93.135 Y77.076 E.00407
G1 X93.215 Y77.207 E.00325
G1 X93.272 Y77.349 E.00324
G1 X93.301 Y77.49 E.00305
G1 X93.304 Y80.522 E.06416
; WIPE_START
M204 S6000
G1 X93.306 Y82.522 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X93.28 Y90.154 Z4.92 F18000
G1 X93.262 Y95.424 Z4.92
G1 Z4.52
G1 E.4 F1800
G1 F1500
M204 S500
G1 X93.284 Y95.47 E.00107
G1 X93.263 Y95.572 E.00221
G1 X93.237 Y95.615 E.00106
G1 X93.191 Y95.642 E.00112
G1 X92.956 Y95.74 E.0054
G1 X92.981 Y95.481 E.00551
G1 X93.006 Y95.399 E.0018
G1 X93.076 Y95.36 E.00171
G1 X93.154 Y95.35 E.00166
G1 X93.222 Y95.381 E.00157
; WIPE_START
M204 S6000
G1 X93.284 Y95.47 E-.03588
G1 X93.263 Y95.572 E-.03446
G1 X93.237 Y95.615 E-.0166
G1 X93.191 Y95.642 E-.01748
G1 X92.956 Y95.74 E-.0843
G1 X92.981 Y95.481 E-.08609
G1 X93.006 Y95.399 E-.02806
G1 X93.076 Y95.36 E-.02672
G1 X93.154 Y95.35 E-.02588
G1 X93.222 Y95.381 E-.02454
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X85.742 Y96.898 Z4.92 F18000
G1 X84.696 Y97.11 Z4.92
G1 Z4.52
G1 E.4 F1800
G1 F1500
M204 S500
G1 X84.589 Y96.949 E.0041
G1 X84.941 Y96.544 E.01135
G1 X86.92 Y96.544 E.04188
G1 X87.271 Y96.948 E.01133
G1 X87.143 Y97.113 E.00443
G1 X87.044 Y97.064 E.00235
G1 X86.535 Y96.915 E.01123
G1 X86.16 Y96.864 E.00799
G1 X85.816 Y96.858 E.00729
G1 X85.257 Y96.928 E.01193
G1 X84.753 Y97.092 E.01121
; WIPE_START
M204 S6000
G1 X84.589 Y96.949 E-.04131
G1 X84.941 Y96.544 E-.10188
G1 X86.187 Y96.544 E-.2368
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X84.836 Y102.277 Z4.92 F18000
G1 Z4.52
G1 E.4 F1800
G1 F1500
M204 S500
G1 X84.486 Y102.089 E.0084
G1 X84.119 Y101.796 E.00995
G1 X83.81 Y101.442 E.00995
G1 X83.569 Y101.039 E.00995
G1 X83.407 Y100.607 E.00975
G1 X83.339 Y100.291 E.00683
G1 X83.311 Y99.97 E.00683
G1 X83.338 Y99.51 E.00975
G1 X83.449 Y99.054 E.00994
G1 X83.637 Y98.633 E.00976
G1 X83.811 Y98.361 E.00683
M73 P83 R4
G1 X84.01 Y98.119 E.00663
G1 X84.235 Y97.903 E.0066
G1 X84.466 Y97.729 E.00612
G1 X84.897 Y97.491 E.01043
G1 X85.35 Y97.344 E.01007
G1 X85.839 Y97.282 E.01043
G1 X86.128 Y97.288 E.00612
G1 X86.446 Y97.331 E.0068
G1 X86.888 Y97.46 E.00975
G1 X87.3 Y97.666 E.00975
G1 X87.564 Y97.852 E.00683
G1 X87.804 Y98.068 E.00683
G1 X88.097 Y98.424 E.00975
G1 X88.326 Y98.835 E.00995
G1 X88.475 Y99.27 E.00975
G1 X88.532 Y99.588 E.00683
G1 X88.551 Y99.91 E.00683
G1 X88.511 Y100.36 E.00955
G1 X88.435 Y100.672 E.0068
G1 X88.334 Y100.943 E.00612
G1 X88.099 Y101.376 E.01043
G1 X87.798 Y101.741 E.01001
G1 X87.437 Y102.047 E.01001
G1 X87.009 Y102.289 E.01042
G1 X86.739 Y102.393 E.00612
G1 X86.428 Y102.474 E.0068
G1 X85.967 Y102.523 E.00981
G1 X85.476 Y102.481 E.01043
G1 X85.194 Y102.416 E.00612
G1 X84.892 Y102.307 E.0068
G1 X84.889 Y102.305 E.00008
M204 S250
G1 X85.03 Y101.917 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X84.713 Y101.746 E.00708
G1 X84.403 Y101.499 E.0078
G1 X84.142 Y101.2 E.0078
G1 X83.939 Y100.86 E.00779
G1 X83.801 Y100.492 E.00774
G1 X83.745 Y100.23 E.00526
G1 X83.721 Y99.964 E.00526
G1 X83.744 Y99.571 E.00773
G1 X83.838 Y99.186 E.00779
G1 X83.998 Y98.827 E.00774
G1 X84.142 Y98.602 E.00526
G1 X84.31 Y98.397 E.0052
G1 X84.501 Y98.215 E.00519
G1 X84.689 Y98.073 E.00464
G1 X85.061 Y97.868 E.00834
G1 X85.439 Y97.745 E.00783
G1 X85.86 Y97.692 E.00835
G1 X86.096 Y97.697 E.00464
G1 X86.361 Y97.733 E.00525
G1 X86.738 Y97.843 E.00773
G1 X87.09 Y98.019 E.00773
G1 X87.309 Y98.173 E.00526
G1 X87.508 Y98.352 E.00526
G1 X87.757 Y98.656 E.00773
G1 X87.95 Y99.002 E.0078
G1 X88.077 Y99.374 E.00773
G1 X88.125 Y99.637 E.00526
G1 X88.141 Y99.904 E.00526
G1 X88.106 Y100.292 E.00767
G1 X88.043 Y100.552 E.00525
G1 X87.961 Y100.773 E.00464
G1 X87.758 Y101.146 E.00834
G1 X87.506 Y101.452 E.00782
G1 X87.202 Y101.709 E.00782
G1 X86.833 Y101.918 E.00834
G1 X86.613 Y102.003 E.00464
G1 X86.355 Y102.07 E.00525
G1 X85.963 Y102.112 E.00776
G1 X85.54 Y102.076 E.00834
G1 X85.31 Y102.022 E.00464
G1 X85.084 Y101.941 E.00473
; WIPE_START
M204 S6000
G1 X84.713 Y101.746 E-.07973
G1 X84.403 Y101.499 E-.07531
G1 X84.142 Y101.2 E-.07531
G1 X83.939 Y100.86 E-.0753
G1 X83.801 Y100.494 E-.07436
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X84.691 Y96.12 Z4.92 F18000
G1 Z4.52
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X92.493 Y96.12 E.16514
G1 X92.563 Y95.397 E.01537
G1 X92.602 Y95.267 E.00288
G1 X92.654 Y95.173 E.00228
G1 X92.792 Y95.033 E.00415
G1 X92.909 Y94.968 E.00283
G1 X93.019 Y94.934 E.00243
G1 X93.22 Y94.93 E.00426
G1 X93.319 Y94.954 E.00217
G1 X93.498 Y95.054 E.00433
G1 X93.571 Y95.126 E.00217
G1 X93.63 Y95.21 E.00217
G1 X93.697 Y95.384 E.00394
G1 X93.708 Y95.499 E.00244
G1 X93.689 Y95.643 E.00308
G1 X93.647 Y95.76 E.00263
G1 X93.523 Y95.927 E.0044
G1 X93.382 Y96.022 E.00359
G1 X93.174 Y96.109 E.00478
G1 X92.999 Y96.272 E.00507
G1 X92.866 Y96.364 E.0034
G1 X92.728 Y96.427 E.00322
G1 X92.582 Y96.466 E.00321
G1 X92.404 Y96.482 E.00379
G1 X87.428 Y96.482 E.10532
G1 X88.611 Y97.842 E.03816
G1 X88.935 Y98.352 E.01278
G1 X89.159 Y98.901 E.01257
G1 X89.286 Y99.49 E.01273
G1 X89.305 Y100.087 E.01266
G1 X89.247 Y100.545 E.00975
G1 X89.105 Y101.061 E.01134
G1 X88.849 Y101.606 E.01273
G1 X88.621 Y101.946 E.00868
G1 X88.353 Y102.258 E.00869
G1 X88.027 Y102.551 E.00928
G1 X87.739 Y102.756 E.00748
G1 X87.379 Y102.955 E.00872
G1 X86.814 Y103.164 E.01273
G1 X86.222 Y103.269 E.01273
G1 X85.63 Y103.267 E.01254
G1 X85.038 Y103.161 E.01273
G1 X84.474 Y102.951 E.01273
G1 X84.123 Y102.757 E.00849
G1 X83.798 Y102.522 E.00849
G1 X83.502 Y102.251 E.0085
G1 X83.24 Y101.947 E.00849
G1 X83.017 Y101.613 E.0085
G1 X82.834 Y101.256 E.00849
G1 X82.696 Y100.879 E.0085
G1 X82.602 Y100.489 E.00849
G1 X82.556 Y100.091 E.00849
G1 X82.558 Y99.68 E.00868
G1 X82.648 Y99.098 E.01247
G1 X82.789 Y98.659 E.00975
G1 X82.933 Y98.338 E.00746
G1 X83.254 Y97.838 E.01256
G1 X84.433 Y96.482 E.03805
G1 X79.467 Y96.482 E.10512
G1 X79.137 Y96.43 E.00707
G1 X79.015 Y96.374 E.00282
G1 X78.82 Y96.231 E.00512
G1 X78.669 Y96.041 E.00515
G1 X78.579 Y95.812 E.0052
G1 X78.55 Y95.565 E.00527
G1 X78.55 Y77.628 E.37965
G1 X78.586 Y77.357 E.00578
G1 X78.701 Y77.111 E.00576
G1 X78.79 Y76.999 E.00302
G1 X78.906 Y76.896 E.00328
G1 X79.127 Y76.775 E.00533
G1 X79.387 Y76.723 E.00561
G1 X92.453 Y76.722 E.27656
G1 X92.636 Y76.747 E.0039
G1 X92.779 Y76.794 E.00318
G1 X92.955 Y76.889 E.00424
G1 X92.906 Y77.082 E.0042
G1 X79.886 Y77.082 E.2756
G1 X79.627 Y77.119 E.00552
G1 X79.318 Y77.275 E.00732
G1 X79.084 Y77.52 E.00718
G1 X78.948 Y77.804 E.00665
G1 X78.911 Y78.056 E.00539
G1 X78.911 Y95.155 E.36192
G1 X78.964 Y95.453 E.0064
G1 X79.147 Y95.77 E.00776
G1 X79.475 Y96.029 E.00884
G1 X79.858 Y96.12 E.00835
G1 X84.631 Y96.12 E.10102
; WIPE_START
M204 S6000
G1 X86.631 Y96.12 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X83.535 Y96.891 Z4.92 F18000
G1 Z4.52
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X79.443 Y96.891 E.08049
G1 X79.127 Y96.854 E.00625
G1 X78.807 Y96.729 E.00676
G1 X78.543 Y96.536 E.00643
G1 X78.394 Y96.368 E.00441
G1 X78.314 Y96.246 E.00289
G1 X78.248 Y96.114 E.00289
G1 X78.177 Y95.901 E.00442
G1 X78.141 Y95.589 E.00619
G1 X78.141 Y77.61 E.35362
G1 X78.161 Y77.374 E.00466
G1 X78.194 Y77.234 E.00283
G1 X78.279 Y77.02 E.00452
G1 X78.363 Y76.878 E.00326
G1 X78.492 Y76.717 E.00406
G1 X78.661 Y76.567 E.00443
G1 X78.855 Y76.447 E.00448
G1 X78.989 Y76.389 E.00287
G1 X79.151 Y76.343 E.00332
G1 X79.358 Y76.313 E.00412
G1 X92.481 Y76.313 E.25812
G1 X92.729 Y76.347 E.00492
G1 X92.941 Y76.417 E.0044
G1 X93.139 Y76.524 E.00442
G1 X93.315 Y76.663 E.00442
G1 X93.465 Y76.831 E.00442
G1 X93.583 Y77.022 E.00442
G1 X93.666 Y77.231 E.00442
G1 X93.71 Y77.448 E.00436
G1 X93.72 Y88.791 E.2231
G1 X92.541 Y88.791 E.02321
G1 X92.541 Y77.491 E.22226
G1 X79.915 Y77.491 E.24833
G1 X79.752 Y77.515 E.00325
G1 X79.565 Y77.609 E.00411
G1 X79.425 Y77.755 E.00399
G1 X79.344 Y77.924 E.00368
G1 X79.321 Y78.086 E.00321
G1 X79.321 Y95.119 E.33504
G1 X79.354 Y95.311 E.00382
G1 X79.462 Y95.498 E.00425
G1 X79.657 Y95.652 E.00489
G1 X79.906 Y95.711 E.00503
G1 X92.121 Y95.711 E.24026
G1 X92.159 Y95.317 E.00779
G1 X92.224 Y95.107 E.00432
G1 X92.314 Y94.943 E.00369
G1 X92.425 Y94.807 E.00344
G1 X92.557 Y94.695 E.00341
G1 X92.747 Y94.59 E.00427
G1 X92.934 Y94.532 E.00386
G1 X93.108 Y94.512 E.00343
G1 X93.283 Y94.524 E.00346
G1 X93.454 Y94.566 E.00345
G1 X93.614 Y94.638 E.00346
G1 X93.759 Y94.737 E.00345
G1 X93.884 Y94.86 E.00346
G1 X93.986 Y95.003 E.00346
G1 X94.06 Y95.163 E.00347
G1 X94.101 Y95.31 E.00299
G1 X94.119 Y95.505 E.00386
G1 X94.09 Y95.741 E.00466
G1 X94.016 Y95.94 E.00419
G1 X93.913 Y96.106 E.00384
G1 X93.707 Y96.305 E.00564
G1 X93.567 Y96.389 E.0032
G1 X93.399 Y96.458 E.00357
G1 X93.256 Y96.592 E.00385
G1 X93.07 Y96.72 E.00444
G1 X92.868 Y96.814 E.00439
G1 X92.652 Y96.871 E.00438
G1 X92.421 Y96.891 E.00456
G1 X88.326 Y96.891 E.08055
G1 X88.933 Y97.589 E.0182
G1 X89.095 Y97.817 E.0055
G1 X89.296 Y98.159 E.0078
G1 X89.391 Y98.356 E.00431
G1 X89.551 Y98.78 E.00891
G1 X89.659 Y99.22 E.00891
G1 X89.713 Y99.661 E.00873
G1 X89.714 Y100.112 E.00889
G1 X89.65 Y100.619 E.01004
G1 X89.488 Y101.209 E.01204
G1 X89.305 Y101.627 E.00897
G1 X89.199 Y101.818 E.00431
G1 X88.947 Y102.195 E.00891
G1 X88.652 Y102.538 E.00891
G1 X88.494 Y102.693 E.00434
G1 X88.278 Y102.874 E.00555
G1 X87.958 Y103.103 E.00774
G1 X87.561 Y103.322 E.00892
G1 X87.36 Y103.411 E.00431
G1 X86.928 Y103.557 E.00897
G1 X86.716 Y103.608 E.0043
G1 X86.265 Y103.676 E.00897
G1 X86.046 Y103.689 E.00431
G1 X85.593 Y103.676 E.00891
G1 X85.145 Y103.608 E.00891
G1 X84.93 Y103.556 E.00436
G1 X84.717 Y103.491 E.00437
G1 X84.298 Y103.321 E.00891
G1 X83.904 Y103.103 E.00885
G1 X83.539 Y102.84 E.00885
G1 X83.207 Y102.536 E.00885
G1 X82.914 Y102.195 E.00885
G1 X82.663 Y101.821 E.00885
G1 X82.459 Y101.42 E.00885
G1 X82.303 Y100.998 E.00885
G1 X82.199 Y100.561 E.00885
G1 X82.147 Y100.113 E.00885
G1 X82.148 Y99.661 E.00891
G1 X82.169 Y99.443 E.0043
G1 X82.25 Y98.998 E.00889
G1 X82.406 Y98.512 E.01004
G1 X82.674 Y97.962 E.01204
G1 X82.929 Y97.588 E.00891
G1 X83.496 Y96.936 E.01698
; WIPE_START
M204 S6000
G1 X81.496 Y96.914 E-.38
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




G1 X79.357 Y96.249
G1 Z4.52
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.146265
G1 F1500
M204 S6000
G1 X79.156 Y96.132 E.0014
G1 X78.939 Y95.953 E.00169
G1 X78.778 Y95.627 E.00219
; WIPE_START
G1 X78.939 Y95.953 E-.15742
G1 X79.156 Y96.132 E-.12174
G1 X79.357 Y96.249 E-.10084
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X84.479 Y97.168 Z4.92 F18000
G1 Z4.52
G1 E.4 F1800
; LINE_WIDTH: 0.476066
G1 F1500
M204 S6000
G1 X84.22 Y97.378 E.0075
; LINE_WIDTH: 0.440202
G1 X84.104 Y97.487 E.00329
; LINE_WIDTH: 0.405161
M73 P83 R3
G1 X83.972 Y97.61 E.00341
; LINE_WIDTH: 0.360258
G1 X83.726 Y97.869 E.00596
G1 X83.5 Y98.147 E.00598
G1 X83.311 Y98.443 E.00586
G1 X83.09 Y98.946 E.00917
G1 X82.963 Y99.469 E.00897
G1 X82.935 Y99.963 E.00827
G1 X82.967 Y100.357 E.0066
G1 X83.061 Y100.769 E.00704
G1 X83.223 Y101.189 E.00751
G1 X83.496 Y101.652 E.00897
G1 X83.777 Y101.985 E.00727
G1 X84.04 Y102.224 E.00594
G1 X84.327 Y102.435 E.00594
G1 X84.75 Y102.656 E.00797
G1 X84.98 Y102.744 E.00411
G1 X85.3 Y102.832 E.00553
G1 X85.662 Y102.883 E.0061
G1 X86.186 Y102.886 E.00874
G1 X86.711 Y102.795 E.0089
G1 X87.181 Y102.626 E.00834
G1 X87.535 Y102.431 E.00673
G1 X87.79 Y102.25 E.00523
G1 X88.079 Y101.996 E.00642
G1 X88.419 Y101.573 E.00905
G1 X88.67 Y101.109 E.00881
G1 X88.791 Y100.791 E.00568
G1 X88.885 Y100.409 E.00655
G1 X88.928 Y99.904 E.00847
G1 X88.881 Y99.372 E.0089
G1 X88.793 Y99.017 E.00611
G1 X88.595 Y98.53 E.00877
G1 X88.398 Y98.201 E.0064
G1 X88.07 Y97.797 E.00869
; LINE_WIDTH: 0.3825
G1 X87.806 Y97.53 E.00667
; LINE_WIDTH: 0.426923
G1 X87.681 Y97.417 E.00338
; LINE_WIDTH: 0.46809
G1 X87.556 Y97.304 E.00372
G1 X87.533 Y97.308 E.0005
; LINE_WIDTH: 0.442936
G1 X87.374 Y97.338 E.00337
; LINE_WIDTH: 0.4162
G1 X87.215 Y97.367 E.00316
; WIPE_START
G1 X87.374 Y97.338 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X92.705 Y96.136 Z4.92 F18000
G1 Z4.52
G1 E.4 F1800
; LINE_WIDTH: 0.124761
G1 F1500
M204 S6000
G1 X92.837 Y96.069 E.00073
; LINE_WIDTH: 0.0990244
G1 X92.951 Y95.996 E.0005
; WIPE_START
G1 X92.837 Y96.069 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X88.217 Y89.994 Z4.92 F18000
G1 X78.788 Y77.596 Z4.92
G1 Z4.52
G1 E.4 F1800
; LINE_WIDTH: 0.100719
G1 F1500
M204 S6000
G1 X78.836 Y77.434 E.00063
; LINE_WIDTH: 0.152154
G1 X78.893 Y77.324 E.00078
G1 X79 Y77.195 E.00106
G1 X79.151 Y77.064 E.00126
; LINE_WIDTH: 0.124897
G1 X79.326 Y76.991 E.00094
; LINE_WIDTH: 0.0898153
G1 X79.435 Y76.955 E.00037
; CHANGE_LAYER
; Z_HEIGHT: 4.64
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F1500
G1 X79.326 Y76.991 E-.38
; WIPE_END
G1 E-.02 F1800
; layer num/total_layer_count: 38/49
; update layer progress
M73 L38
M991 S0 P37 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z4.92 I-.303 J1.179 P1  F18000
G1 X93.304 Y80.581 Z4.92
G1 Z4.64
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X93.311 Y88.382 E.1651
G1 X92.95 Y88.382 E.00764
G1 X92.95 Y77.128 E.23818
G1 X93.135 Y77.076 E.00407
M73 P84 R3
G1 X93.215 Y77.207 E.00325
G1 X93.272 Y77.349 E.00325
G1 X93.301 Y77.49 E.00305
G1 X93.304 Y80.521 E.06416
; WIPE_START
M204 S6000
G1 X93.306 Y82.521 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X93.28 Y90.154 Z5.04 F18000
G1 X93.262 Y95.424 Z5.04
G1 Z4.64
G1 E.4 F1800
G1 F1500
M204 S500
G1 X93.284 Y95.47 E.00107
G1 X93.263 Y95.573 E.00223
G1 X93.237 Y95.615 E.00104
G1 X93.191 Y95.642 E.00114
G1 X92.956 Y95.74 E.00538
G1 X92.981 Y95.481 E.0055
G1 X93.006 Y95.399 E.00181
G1 X93.077 Y95.36 E.00173
G1 X93.154 Y95.35 E.00164
G1 X93.222 Y95.381 E.00157
; WIPE_START
M204 S6000
G1 X93.284 Y95.47 E-.03587
G1 X93.263 Y95.573 E-.03484
G1 X93.237 Y95.615 E-.01622
G1 X93.191 Y95.642 E-.01781
G1 X92.956 Y95.74 E-.08405
G1 X92.981 Y95.481 E-.08591
G1 X93.006 Y95.399 E-.02822
G1 X93.077 Y95.36 E-.02694
G1 X93.154 Y95.35 E-.02562
G1 X93.222 Y95.381 E-.02453
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X85.742 Y96.898 Z5.04 F18000
G1 X84.696 Y97.11 Z5.04
G1 Z4.64
G1 E.4 F1800
G1 F1500
M204 S500
G1 X84.589 Y96.949 E.0041
G1 X84.941 Y96.544 E.01135
G1 X86.92 Y96.544 E.04188
G1 X87.273 Y96.951 E.0114
G1 X87.15 Y97.115 E.00436
G1 X87.029 Y97.059 E.00282
G1 X86.535 Y96.915 E.01089
G1 X86.16 Y96.864 E.008
G1 X85.813 Y96.858 E.00735
G1 X85.257 Y96.928 E.01187
G1 X84.753 Y97.092 E.01121
; WIPE_START
M204 S6000
G1 X84.589 Y96.949 E-.04131
G1 X84.941 Y96.544 E-.10188
G1 X86.188 Y96.544 E-.23681
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X84.836 Y102.277 Z5.04 F18000
G1 Z4.64
G1 E.4 F1800
G1 F1500
M204 S500
G1 X84.486 Y102.089 E.00839
G1 X84.119 Y101.796 E.00995
G1 X83.808 Y101.44 E.01
G1 X83.56 Y101.017 E.01038
G1 X83.451 Y100.747 E.00617
G1 X83.365 Y100.437 E.0068
G1 X83.31 Y99.979 E.00975
G1 X83.338 Y99.519 E.00975
G1 X83.405 Y99.204 E.00683
G1 X83.509 Y98.898 E.00684
G1 X83.721 Y98.489 E.00975
G1 X84.009 Y98.118 E.00994
G1 X84.351 Y97.809 E.00975
G1 X84.62 Y97.632 E.00683
G1 X84.909 Y97.487 E.00683
G1 X85.35 Y97.344 E.00981
G1 X85.836 Y97.282 E.01037
G1 X86.128 Y97.288 E.00618
G1 X86.446 Y97.331 E.00681
G1 X86.879 Y97.458 E.00955
G1 X87.172 Y97.593 E.00683
G1 X87.447 Y97.763 E.00683
G1 X87.798 Y98.061 E.00975
G1 X88.097 Y98.424 E.00995
G1 X88.326 Y98.835 E.00995
G1 X88.475 Y99.27 E.00975
G1 X88.532 Y99.588 E.00683
G1 X88.551 Y99.901 E.00663
G1 X88.532 Y100.214 E.00663
G1 X88.475 Y100.531 E.00683
G1 X88.326 Y100.967 E.00975
G1 X88.097 Y101.378 E.00995
G1 X87.798 Y101.741 E.00995
G1 X87.438 Y102.046 E.01001
G1 X87.011 Y102.288 E.01037
G1 X86.739 Y102.393 E.00617
G1 X86.428 Y102.474 E.0068
G1 X85.979 Y102.521 E.00956
G1 X85.657 Y102.507 E.00683
G1 X85.338 Y102.454 E.00683
G1 X84.9 Y102.312 E.00975
G1 X84.888 Y102.305 E.00028
M204 S250
G1 X85.03 Y101.917 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X84.713 Y101.746 E.00708
G1 X84.403 Y101.499 E.0078
G1 X84.141 Y101.2 E.00781
G1 X83.928 Y100.836 E.0083
G1 X83.839 Y100.615 E.00469
G1 X83.768 Y100.357 E.00525
G1 X83.721 Y99.967 E.00773
G1 X83.744 Y99.574 E.00774
G1 X83.8 Y99.313 E.00526
G1 X83.886 Y99.06 E.00527
G1 X84.068 Y98.711 E.00773
G1 X84.31 Y98.397 E.00779
G1 X84.602 Y98.134 E.00774
G1 X84.825 Y97.987 E.00526
G1 X85.065 Y97.867 E.00526
G1 X85.44 Y97.745 E.00775
G1 X85.858 Y97.692 E.0083
G1 X86.096 Y97.697 E.00469
G1 X86.361 Y97.733 E.00525
G1 X86.735 Y97.842 E.00767
G1 X86.978 Y97.954 E.00526
G1 X87.206 Y98.095 E.00527
G1 X87.506 Y98.349 E.00773
G1 X87.757 Y98.656 E.0078
G1 X87.95 Y99.002 E.00779
G1 X88.077 Y99.374 E.00773
G1 X88.125 Y99.637 E.00526
G1 X88.141 Y99.901 E.0052
G1 X88.125 Y100.165 E.0052
G1 X88.077 Y100.428 E.00526
G1 X87.95 Y100.8 E.00774
G1 X87.757 Y101.146 E.00779
G1 X87.506 Y101.452 E.0078
G1 X87.202 Y101.709 E.00781
G1 X86.835 Y101.917 E.0083
G1 X86.613 Y102.003 E.00469
G1 X86.355 Y102.07 E.00525
G1 X85.967 Y102.111 E.00767
G1 X85.699 Y102.099 E.00526
G1 X85.436 Y102.055 E.00526
G1 X85.084 Y101.941 E.00727
; WIPE_START
M204 S6000
G1 X84.713 Y101.746 E-.07968
G1 X84.403 Y101.499 E-.07532
G1 X84.141 Y101.2 E-.07548
G1 X83.928 Y100.836 E-.08015
G1 X83.839 Y100.615 E-.04527
G1 X83.805 Y100.493 E-.0241
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X84.691 Y96.12 Z5.04 F18000
G1 Z4.64
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X92.493 Y96.12 E.16513
G1 X92.562 Y95.398 E.01536
G1 X92.603 Y95.267 E.0029
G1 X92.654 Y95.174 E.00225
G1 X92.791 Y95.033 E.00416
G1 X92.909 Y94.968 E.00286
G1 X93.018 Y94.934 E.00241
G1 X93.219 Y94.929 E.00426
G1 X93.319 Y94.954 E.00218
G1 X93.413 Y94.996 E.00217
G1 X93.571 Y95.126 E.00433
G1 X93.63 Y95.21 E.00217
G1 X93.697 Y95.385 E.00397
G1 X93.708 Y95.498 E.0024
G1 X93.69 Y95.642 E.00307
G1 X93.646 Y95.761 E.00267
G1 X93.522 Y95.927 E.0044
G1 X93.382 Y96.022 E.00359
G1 X93.174 Y96.109 E.00476
G1 X92.999 Y96.272 E.00507
G1 X92.866 Y96.364 E.0034
G1 X92.728 Y96.427 E.00322
G1 X92.582 Y96.466 E.00321
G1 X92.404 Y96.482 E.00379
G1 X87.428 Y96.482 E.10532
G1 X88.614 Y97.845 E.03824
G1 X88.721 Y97.993 E.00386
G1 X88.934 Y98.35 E.00881
G1 X89.159 Y98.9 E.01259
G1 X89.284 Y99.477 E.0125
G1 X89.309 Y99.942 E.00985
G1 X89.26 Y100.486 E.01156
G1 X89.207 Y100.727 E.00522
G1 X89.101 Y101.074 E.00769
G1 X88.845 Y101.612 E.01261
G1 X88.621 Y101.947 E.00852
G1 X88.353 Y102.258 E.00869
G1 X87.897 Y102.65 E.01273
G1 X87.528 Y102.879 E.00919
G1 X87.199 Y103.034 E.0077
G1 X86.975 Y103.114 E.00504
G1 X86.629 Y103.208 E.00758
G1 X86.222 Y103.269 E.00871
G1 X85.63 Y103.267 E.01254
G1 X85.05 Y103.164 E.01247
G1 X84.61 Y103.011 E.00985
G1 X84.131 Y102.762 E.01144
G1 X83.797 Y102.522 E.00868
G1 X83.502 Y102.251 E.00849
G1 X83.24 Y101.947 E.00849
G1 X83.017 Y101.613 E.00849
G1 X82.834 Y101.256 E.0085
G1 X82.696 Y100.879 E.00849
G1 X82.603 Y100.492 E.00843
G1 X82.555 Y100.039 E.00965
G1 X82.574 Y99.499 E.01144
G1 X82.648 Y99.095 E.00869
G1 X82.767 Y98.712 E.00849
G1 X82.93 Y98.345 E.00849
G1 X83.248 Y97.845 E.01254
G1 X84.434 Y96.482 E.03824
G1 X79.467 Y96.482 E.10513
G1 X79.137 Y96.43 E.00707
G1 X79.014 Y96.373 E.00286
G1 X78.82 Y96.231 E.00509
G1 X78.669 Y96.041 E.00515
G1 X78.579 Y95.812 E.0052
G1 X78.55 Y95.565 E.00527
G1 X78.55 Y77.628 E.37965
G1 X78.588 Y77.349 E.00597
G1 X78.697 Y77.118 E.00539
G1 X78.859 Y76.933 E.0052
G1 X79.089 Y76.791 E.00573
G1 X79.226 Y76.746 E.00306
G1 X79.388 Y76.723 E.00347
G1 X92.455 Y76.722 E.27656
G1 X92.636 Y76.747 E.00387
G1 X92.779 Y76.794 E.00318
G1 X92.955 Y76.889 E.00424
G1 X92.906 Y77.082 E.0042
G1 X79.876 Y77.082 E.27579
G1 X79.588 Y77.132 E.0062
G1 X79.311 Y77.282 E.00665
G1 X79.083 Y77.521 E.007
G1 X78.948 Y77.804 E.00664
G1 X78.911 Y78.056 E.00538
G1 X78.911 Y95.155 E.36192
G1 X78.964 Y95.452 E.00639
G1 X79.147 Y95.77 E.00776
G1 X79.475 Y96.029 E.00884
G1 X79.858 Y96.12 E.00834
G1 X84.631 Y96.12 E.10103
; WIPE_START
M204 S6000
G1 X86.631 Y96.12 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X83.535 Y96.891 Z5.04 F18000
G1 Z4.64
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X79.443 Y96.891 E.08049
G1 X79.127 Y96.854 E.00625
G1 X78.806 Y96.728 E.00679
G1 X78.543 Y96.536 E.0064
G1 X78.394 Y96.368 E.0044
G1 X78.314 Y96.246 E.00289
G1 X78.248 Y96.114 E.00289
G1 X78.177 Y95.901 E.00442
G1 X78.141 Y95.589 E.00619
G1 X78.141 Y77.61 E.35362
G1 X78.161 Y77.374 E.00466
G1 X78.195 Y77.231 E.00289
G1 X78.245 Y77.093 E.00289
G1 X78.353 Y76.892 E.00448
G1 X78.495 Y76.714 E.00448
G1 X78.599 Y76.615 E.00283
G1 X78.788 Y76.483 E.00452
G1 X78.935 Y76.411 E.00322
G1 X79.133 Y76.347 E.00409
G1 X79.359 Y76.313 E.00449
G1 X92.483 Y76.313 E.25814
G1 X92.729 Y76.347 E.00489
G1 X92.941 Y76.417 E.0044
G1 X93.139 Y76.524 E.00442
G1 X93.315 Y76.663 E.00442
G1 X93.465 Y76.831 E.00442
G1 X93.583 Y77.022 E.00442
G1 X93.666 Y77.231 E.00442
G1 X93.71 Y77.448 E.00436
G1 X93.72 Y88.791 E.2231
G1 X92.541 Y88.791 E.02321
G1 X92.541 Y77.491 E.22226
G1 X79.912 Y77.491 E.24839
G1 X79.724 Y77.524 E.00376
G1 X79.563 Y77.611 E.00361
G1 X79.424 Y77.756 E.00394
G1 X79.344 Y77.924 E.00367
G1 X79.321 Y78.086 E.0032
G1 X79.321 Y95.119 E.33504
G1 X79.354 Y95.31 E.00382
G1 X79.462 Y95.498 E.00425
G1 X79.657 Y95.652 E.00489
G1 X79.906 Y95.711 E.00503
G1 X92.121 Y95.711 E.24026
G1 X92.159 Y95.317 E.00778
G1 X92.224 Y95.106 E.00434
G1 X92.314 Y94.943 E.00367
G1 X92.425 Y94.808 E.00344
G1 X92.557 Y94.695 E.00341
G1 X92.748 Y94.589 E.00429
G1 X92.934 Y94.532 E.00383
G1 X93.107 Y94.512 E.00343
G1 X93.282 Y94.523 E.00345
G1 X93.453 Y94.566 E.00346
G1 X93.613 Y94.638 E.00345
G1 X93.759 Y94.737 E.00346
G1 X93.884 Y94.86 E.00345
G1 X93.985 Y95.003 E.00345
G1 X94.06 Y95.163 E.00347
G1 X94.101 Y95.311 E.00303
G1 X94.119 Y95.505 E.00383
G1 X94.09 Y95.74 E.00466
G1 X94.016 Y95.942 E.00423
G1 X93.913 Y96.106 E.00381
G1 X93.707 Y96.305 E.00564
G1 X93.566 Y96.389 E.00323
G1 X93.399 Y96.458 E.00355
G1 X93.256 Y96.592 E.00385
G1 X93.07 Y96.72 E.00444
G1 X92.868 Y96.814 E.00438
G1 X92.653 Y96.871 E.00438
G1 X92.421 Y96.891 E.00456
G1 X88.326 Y96.891 E.08055
G1 X88.934 Y97.59 E.01823
G1 X89.063 Y97.767 E.00431
G1 X89.296 Y98.158 E.00895
G1 X89.412 Y98.407 E.0054
G1 X89.551 Y98.78 E.00783
G1 X89.659 Y99.22 E.00892
G1 X89.692 Y99.435 E.00429
G1 X89.719 Y99.943 E.01
G1 X89.695 Y100.341 E.00783
G1 X89.603 Y100.831 E.0098
G1 X89.486 Y101.213 E.00787
G1 X89.38 Y101.467 E.00541
G1 X89.198 Y101.821 E.00783
G1 X88.947 Y102.195 E.00886
G1 X88.652 Y102.538 E.00891
G1 X88.495 Y102.691 E.00431
G1 X88.141 Y102.979 E.00897
G1 X87.958 Y103.103 E.00434
G1 X87.718 Y103.241 E.00546
G1 X87.356 Y103.412 E.00787
G1 X87.097 Y103.505 E.00541
G1 X86.713 Y103.609 E.00783
G1 X86.265 Y103.676 E.00892
G1 X86.046 Y103.689 E.00431
G1 X85.593 Y103.676 E.00891
G1 X85.145 Y103.608 E.00891
G1 X84.934 Y103.557 E.00428
G1 X84.453 Y103.389 E.01001
G1 X84.095 Y103.217 E.00782
G1 X83.906 Y103.105 E.00432
G1 X83.539 Y102.84 E.00891
G1 X83.207 Y102.536 E.00885
G1 X82.914 Y102.195 E.00885
G1 X82.663 Y101.821 E.00885
G1 X82.459 Y101.42 E.00885
G1 X82.303 Y100.998 E.00885
G1 X82.199 Y100.561 E.00883
G1 X82.145 Y100.059 E.00994
G1 X82.148 Y99.661 E.00783
G1 X82.169 Y99.443 E.00431
G1 X82.25 Y98.997 E.00891
G1 X82.383 Y98.567 E.00885
G1 X82.566 Y98.156 E.00885
G1 X82.798 Y97.767 E.00891
G1 X82.927 Y97.59 E.0043
G1 X83.496 Y96.936 E.01705
; WIPE_START
M204 S6000
G1 X81.496 Y96.914 E-.38
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




G1 X79.357 Y96.249
G1 Z4.64
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.146274
G1 F1500
M204 S6000
G1 X79.155 Y96.131 E.00141
G1 X78.939 Y95.953 E.00168
G1 X78.778 Y95.626 E.00219
; WIPE_START
G1 X78.939 Y95.953 E-.15747
G1 X79.155 Y96.131 E-.12118
M73 P85 R3
G1 X79.357 Y96.249 E-.10136
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X84.478 Y97.165 Z5.04 F18000
G1 Z4.64
G1 E.4 F1800
; LINE_WIDTH: 0.477121
G1 F1500
M204 S6000
G1 X84.297 Y97.319 E.00533
; LINE_WIDTH: 0.438413
G1 X84.09 Y97.496 E.00561
; LINE_WIDTH: 0.400639
G1 X83.916 Y97.673 E.00464
; LINE_WIDTH: 0.359874
G1 X83.723 Y97.872 E.00463
G1 X83.399 Y98.301 E.00895
G1 X83.157 Y98.761 E.00867
G1 X83.019 Y99.186 E.00744
G1 X82.954 Y99.546 E.0061
G1 X82.934 Y100.022 E.00794
G1 X82.992 Y100.498 E.00799
G1 X83.09 Y100.859 E.00624
G1 X83.227 Y101.194 E.00604
G1 X83.511 Y101.673 E.00928
G1 X83.777 Y101.985 E.00683
G1 X84.038 Y102.223 E.00589
G1 X84.293 Y102.408 E.00525
G1 X84.755 Y102.661 E.00878
G1 X85.237 Y102.817 E.00844
G1 X85.664 Y102.888 E.00721
G1 X86.188 Y102.885 E.00874
G1 X86.551 Y102.835 E.00612
G1 X86.865 Y102.751 E.00541
G1 X87.162 Y102.634 E.00532
G1 X87.347 Y102.539 E.00347
G1 X87.672 Y102.344 E.00631
G1 X88.08 Y101.994 E.00897
G1 X88.416 Y101.577 E.00892
G1 X88.661 Y101.132 E.00847
G1 X88.84 Y100.633 E.00885
G1 X88.91 Y100.256 E.00638
G1 X88.929 Y99.911 E.00577
G1 X88.906 Y99.522 E.0065
G1 X88.792 Y99.014 E.00868
G1 X88.593 Y98.528 E.00874
G1 X88.398 Y98.201 E.00635
G1 X88.058 Y97.784 E.00897
; LINE_WIDTH: 0.378815
G1 X87.881 Y97.609 E.00438
; LINE_WIDTH: 0.419295
G1 X87.678 Y97.411 E.00556
; LINE_WIDTH: 0.468119
G1 X87.38 Y97.162 E.00858
; WIPE_START
G1 X87.678 Y97.411 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X92.705 Y96.136 Z5.04 F18000
G1 Z4.64
G1 E.4 F1800
; LINE_WIDTH: 0.125021
G1 F1500
M204 S6000
G1 X92.837 Y96.069 E.00073
; LINE_WIDTH: 0.0991519
G1 X92.952 Y95.995 E.0005
; WIPE_START
G1 X92.837 Y96.069 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X88.217 Y89.994 Z5.04 F18000
G1 X78.788 Y77.596 Z5.04
G1 Z4.64
G1 E.4 F1800
; LINE_WIDTH: 0.108107
G1 F1500
M204 S6000
G1 X78.859 Y77.377 E.00095
; LINE_WIDTH: 0.149941
G1 X79.042 Y77.152 E.00179
G1 X79.138 Y77.07 E.00079
G1 X79.287 Y77 E.00102
; LINE_WIDTH: 0.100175
G1 X79.424 Y76.954 E.00054
; CHANGE_LAYER
; Z_HEIGHT: 4.76
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F1500
G1 X79.287 Y77 E-.38
; WIPE_END
G1 E-.02 F1800
; layer num/total_layer_count: 39/49
; update layer progress
M73 L39
M991 S0 P38 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z5.04 I-.301 J1.179 P1  F18000
G1 X93.304 Y80.581 Z5.04
G1 Z4.76
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X93.311 Y88.382 E.1651
G1 X92.95 Y88.382 E.00764
G1 X92.95 Y77.128 E.23818
G1 X93.135 Y77.076 E.00407
G1 X93.215 Y77.207 E.00325
G1 X93.272 Y77.349 E.00324
G1 X93.301 Y77.49 E.00305
G1 X93.304 Y80.521 E.06416
; WIPE_START
M204 S6000
G1 X93.306 Y82.521 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X93.28 Y90.154 Z5.16 F18000
G1 X93.262 Y95.424 Z5.16
G1 Z4.76
G1 E.4 F1800
G1 F1500
M204 S500
G1 X93.284 Y95.47 E.00107
G1 X93.263 Y95.574 E.00225
G1 X93.237 Y95.615 E.00101
G1 X93.19 Y95.643 E.00116
G1 X92.956 Y95.74 E.00536
G1 X92.98 Y95.482 E.00548
G1 X93.006 Y95.399 E.00183
G1 X93.078 Y95.359 E.00174
G1 X93.154 Y95.35 E.00162
G1 X93.205 Y95.368 E.00114
G1 X93.219 Y95.382 E.00043
; WIPE_START
M204 S6000
G1 X93.284 Y95.47 E-.03603
G1 X93.263 Y95.574 E-.03518
G1 X93.237 Y95.615 E-.01575
G1 X93.19 Y95.643 E-.01813
G1 X92.956 Y95.74 E-.08377
G1 X92.98 Y95.482 E-.08553
G1 X93.006 Y95.399 E-.02858
G1 X93.078 Y95.359 E-.02723
G1 X93.154 Y95.35 E-.02527
G1 X93.205 Y95.368 E-.01781
G1 X93.219 Y95.382 E-.00672
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X85.739 Y96.899 Z5.16 F18000
G1 X84.696 Y97.11 Z5.16
G1 Z4.76
G1 E.4 F1800
G1 F1500
M204 S500
G1 X84.589 Y96.949 E.0041
G1 X84.941 Y96.544 E.01135
G1 X86.92 Y96.544 E.04188
G1 X87.273 Y96.951 E.0114
G1 X87.15 Y97.115 E.00436
G1 X87.029 Y97.059 E.00282
G1 X86.535 Y96.915 E.01089
G1 X86.16 Y96.864 E.00801
G1 X85.81 Y96.858 E.00741
G1 X85.256 Y96.928 E.01182
G1 X84.753 Y97.092 E.0112
; WIPE_START
M204 S6000
G1 X84.589 Y96.949 E-.04131
G1 X84.941 Y96.544 E-.10189
G1 X86.188 Y96.544 E-.2368
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X84.835 Y102.277 Z5.16 F18000
G1 Z4.76
G1 E.4 F1800
G1 F1500
M204 S500
G1 X84.486 Y102.089 E.00838
G1 X84.119 Y101.796 E.00995
G1 X83.808 Y101.44 E.01
G1 X83.561 Y101.019 E.01032
G1 X83.451 Y100.747 E.00623
G1 X83.365 Y100.437 E.00681
G1 X83.31 Y99.979 E.00975
G1 X83.338 Y99.508 E.01
G1 X83.458 Y99.035 E.01032
G1 X83.57 Y98.763 E.00623
G1 X83.727 Y98.482 E.00681
G1 X84.009 Y98.118 E.00975
G1 X84.351 Y97.809 E.00975
G1 X84.62 Y97.632 E.00683
G1 X84.909 Y97.487 E.00683
G1 X85.349 Y97.344 E.0098
G1 X85.833 Y97.283 E.01032
G1 X86.128 Y97.288 E.00623
G1 X86.446 Y97.331 E.00681
G1 X86.879 Y97.458 E.00955
G1 X87.172 Y97.593 E.00683
G1 X87.447 Y97.763 E.00683
G1 X87.798 Y98.061 E.00975
G1 X88.091 Y98.417 E.00975
G1 X88.256 Y98.693 E.00681
G1 X88.376 Y98.961 E.00623
G1 X88.51 Y99.43 E.01032
G1 X88.551 Y99.892 E.0098
G1 X88.532 Y100.213 E.00681
G1 X88.481 Y100.502 E.00623
G1 X88.327 Y100.965 E.01032
G1 X88.097 Y101.378 E.01
G1 X87.798 Y101.741 E.00995
G1 X87.438 Y102.046 E.01
G1 X87.014 Y102.287 E.01032
G1 X86.739 Y102.393 E.00623
G1 X86.428 Y102.474 E.00681
G1 X85.979 Y102.521 E.00955
G1 X85.657 Y102.507 E.00683
G1 X85.338 Y102.454 E.00683
G1 X84.9 Y102.312 E.00975
G1 X84.888 Y102.305 E.0003
M204 S250
G1 X85.029 Y101.916 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X84.713 Y101.746 E.00706
G1 X84.403 Y101.499 E.0078
G1 X84.141 Y101.2 E.00781
G1 X83.929 Y100.838 E.00825
G1 X83.839 Y100.615 E.00474
G1 X83.768 Y100.357 E.00526
G1 X83.721 Y99.967 E.00773
G1 X83.744 Y99.571 E.00781
G1 X83.847 Y99.164 E.00825
G1 X83.939 Y98.942 E.00474
G1 X84.069 Y98.708 E.00526
G1 X84.31 Y98.397 E.00773
G1 X84.602 Y98.134 E.00773
G1 X84.825 Y97.987 E.00526
G1 X85.065 Y97.867 E.00526
G1 X85.439 Y97.745 E.00775
G1 X85.855 Y97.692 E.00825
G1 X86.096 Y97.697 E.00474
G1 X86.361 Y97.733 E.00526
G1 X86.735 Y97.842 E.00767
G1 X86.978 Y97.954 E.00526
G1 X87.206 Y98.095 E.00526
G1 X87.506 Y98.349 E.00773
G1 X87.755 Y98.653 E.00773
G1 X87.892 Y98.882 E.00525
G1 X87.991 Y99.102 E.00474
G1 X88.106 Y99.505 E.00825
G1 X88.141 Y99.898 E.00775
G1 X88.125 Y100.164 E.00525
G1 X88.083 Y100.401 E.00474
G1 X87.951 Y100.799 E.00825
G1 X87.757 Y101.146 E.00781
G1 X87.506 Y101.452 E.0078
G1 X87.202 Y101.709 E.00782
G1 X86.838 Y101.916 E.00825
G1 X86.613 Y102.003 E.00474
G1 X86.355 Y102.07 E.00525
G1 X85.967 Y102.111 E.00767
G1 X85.7 Y102.099 E.00526
G1 X85.436 Y102.055 E.00527
G1 X85.083 Y101.941 E.00728
; WIPE_START
M204 S6000
G1 X84.713 Y101.746 E-.07956
G1 X84.403 Y101.499 E-.07531
G1 X84.141 Y101.2 E-.07547
G1 X83.929 Y100.838 E-.0797
G1 X83.839 Y100.615 E-.04575
G1 X83.805 Y100.492 E-.02422
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X84.691 Y96.12 Z5.16 F18000
G1 Z4.76
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X92.494 Y96.12 E.16515
G1 X92.562 Y95.399 E.01533
G1 X92.603 Y95.266 E.00294
G1 X92.654 Y95.174 E.00223
G1 X92.791 Y95.034 E.00415
G1 X92.91 Y94.967 E.00289
G1 X93.017 Y94.934 E.00237
G1 X93.219 Y94.929 E.00427
G1 X93.319 Y94.954 E.00218
G1 X93.497 Y95.054 E.00433
G1 X93.571 Y95.126 E.00217
G1 X93.63 Y95.21 E.00217
G1 X93.697 Y95.387 E.00401
G1 X93.708 Y95.498 E.00236
G1 X93.69 Y95.642 E.00308
G1 X93.645 Y95.762 E.00271
G1 X93.521 Y95.928 E.00439
G1 X93.381 Y96.023 E.00359
G1 X93.174 Y96.109 E.00473
G1 X92.999 Y96.272 E.00508
G1 X92.866 Y96.364 E.0034
G1 X92.728 Y96.427 E.00322
G1 X92.582 Y96.466 E.00321
G1 X92.404 Y96.482 E.00378
G1 X87.428 Y96.482 E.10532
G1 X88.608 Y97.838 E.03805
G1 X88.93 Y98.342 E.01267
G1 X89.159 Y98.9 E.01277
G1 X89.286 Y99.49 E.01276
G1 X89.305 Y100.088 E.01267
G1 X89.249 Y100.536 E.00956
G1 X89.103 Y101.067 E.01166
G1 X88.845 Y101.612 E.01277
G1 X88.501 Y102.096 E.01256
G1 X88.211 Y102.395 E.00881
G1 X88.034 Y102.546 E.00492
G1 X87.739 Y102.756 E.00767
G1 X87.379 Y102.955 E.00871
G1 X86.979 Y103.113 E.0091
G1 X86.629 Y103.208 E.00767
G1 X86.222 Y103.269 E.00871
G1 X85.63 Y103.267 E.01254
G1 X85.047 Y103.164 E.01253
G1 X84.658 Y103.032 E.00869
G1 X84.298 Y102.86 E.00843
G1 X83.919 Y102.615 E.00956
G1 X83.508 Y102.258 E.01153
G1 X83.24 Y101.947 E.00868
G1 X83.017 Y101.613 E.0085
G1 X82.836 Y101.258 E.00843
G1 X82.683 Y100.833 E.00956
G1 X82.574 Y100.3 E.01153
G1 X82.551 Y99.89 E.00869
G1 X82.576 Y99.49 E.00849
G1 X82.648 Y99.098 E.00843
G1 X82.785 Y98.667 E.00956
G1 X82.933 Y98.338 E.00765
G1 X83.254 Y97.838 E.01257
G1 X84.433 Y96.482 E.03804
G1 X79.467 Y96.482 E.10512
G1 X79.138 Y96.43 E.00703
G1 X78.913 Y96.311 E.0054
G1 X78.792 Y96.204 E.00343
G1 X78.691 Y96.076 E.00343
G1 X78.578 Y95.803 E.00627
G1 X78.55 Y95.565 E.00508
G1 X78.55 Y77.628 E.37965
G1 X78.587 Y77.351 E.00591
G1 X78.696 Y77.119 E.00542
G1 X78.87 Y76.924 E.00554
G1 X78.99 Y76.841 E.00309
G1 X79.136 Y76.773 E.00341
G1 X79.387 Y76.723 E.00542
G1 X92.456 Y76.722 E.27662
G1 X92.635 Y76.747 E.00383
G1 X92.779 Y76.794 E.00319
G1 X92.955 Y76.889 E.00424
G1 X92.906 Y77.082 E.0042
G1 X79.885 Y77.082 E.2756
G1 X79.627 Y77.12 E.00553
G1 X79.316 Y77.276 E.00736
G1 X79.077 Y77.529 E.00737
G1 X78.948 Y77.807 E.00649
G1 X78.911 Y78.056 E.00533
G1 X78.911 Y95.155 E.36192
G1 X78.964 Y95.453 E.0064
G1 X79.152 Y95.778 E.00795
G1 X79.512 Y96.047 E.00952
G1 X79.867 Y96.12 E.00767
G1 X84.631 Y96.12 E.10083
; WIPE_START
M204 S6000
G1 X86.631 Y96.12 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X83.535 Y96.891 Z5.16 F18000
G1 Z4.76
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X79.443 Y96.891 E.08049
G1 X79.127 Y96.854 E.00625
G1 X78.992 Y96.814 E.00277
G1 X78.783 Y96.716 E.00454
G1 X78.663 Y96.637 E.00283
G1 X78.493 Y96.486 E.00448
G1 X78.352 Y96.307 E.00448
G1 X78.281 Y96.185 E.00277
G1 X78.177 Y95.898 E.00601
G1 X78.141 Y95.589 E.00613
G1 X78.141 Y77.61 E.35362
G1 X78.161 Y77.374 E.00466
G1 X78.195 Y77.232 E.00287
G1 X78.253 Y77.077 E.00325
G1 X78.353 Y76.893 E.00413
G1 X78.494 Y76.714 E.00447
G1 X78.613 Y76.604 E.00319
G1 X78.786 Y76.485 E.00413
G1 X78.992 Y76.389 E.00447
G1 X79.147 Y76.343 E.00319
G1 X79.358 Y76.313 E.00418
G1 X92.484 Y76.313 E.25818
G1 X92.729 Y76.347 E.00485
G1 X92.941 Y76.417 E.00441
G1 X93.139 Y76.524 E.00442
G1 X93.315 Y76.663 E.00442
G1 X93.465 Y76.831 E.00442
G1 X93.583 Y77.022 E.00442
G1 X93.666 Y77.231 E.00442
G1 X93.71 Y77.448 E.00436
G1 X93.72 Y88.791 E.2231
G1 X92.541 Y88.791 E.02321
G1 X92.541 Y77.491 E.22226
G1 X79.915 Y77.491 E.24833
G1 X79.752 Y77.515 E.00325
G1 X79.564 Y77.609 E.00413
G1 X79.42 Y77.762 E.00413
G1 X79.344 Y77.925 E.00355
G1 X79.321 Y78.086 E.00319
G1 X79.321 Y95.119 E.33504
G1 X79.354 Y95.311 E.00382
G1 X79.464 Y95.501 E.00431
G1 X79.684 Y95.664 E.0054
G1 X79.909 Y95.711 E.00452
G1 X92.122 Y95.711 E.24021
G1 X92.159 Y95.319 E.00775
G1 X92.224 Y95.106 E.00439
G1 X92.314 Y94.943 E.00364
G1 X92.425 Y94.808 E.00344
G1 X92.556 Y94.696 E.00341
G1 X92.749 Y94.589 E.00433
G1 X92.933 Y94.532 E.00379
G1 X93.107 Y94.512 E.00344
G1 X93.282 Y94.523 E.00345
G1 X93.453 Y94.566 E.00346
G1 X93.613 Y94.637 E.00345
G1 X93.758 Y94.736 E.00346
G1 X93.883 Y94.859 E.00345
G1 X93.985 Y95.003 E.00345
G1 X94.06 Y95.162 E.00347
G1 X94.101 Y95.313 E.00307
G1 X94.119 Y95.504 E.00379
G1 X94.09 Y95.739 E.00466
G1 X94.015 Y95.943 E.00427
G1 X93.914 Y96.105 E.00376
G1 X93.707 Y96.305 E.00565
G1 X93.565 Y96.39 E.00326
G1 X93.399 Y96.458 E.00352
G1 X93.256 Y96.592 E.00385
G1 X93.07 Y96.72 E.00444
G1 X92.868 Y96.814 E.00439
G1 X92.653 Y96.871 E.00438
G1 X92.421 Y96.891 E.00456
G1 X88.326 Y96.891 E.08055
G1 X88.932 Y97.588 E.01816
G1 X89.187 Y97.962 E.00891
G1 X89.41 Y98.402 E.00971
G1 X89.551 Y98.78 E.00792
G1 X89.659 Y99.22 E.00892
G1 X89.713 Y99.661 E.00873
G1 X89.714 Y100.113 E.00889
G1 X89.652 Y100.61 E.00985
G1 X89.557 Y101.001 E.00792
G1 X89.382 Y101.463 E.00972
G1 X89.198 Y101.821 E.00792
G1 X88.945 Y102.197 E.00892
G1 X88.808 Y102.368 E.00431
G1 X88.491 Y102.695 E.00895
G1 X88.285 Y102.869 E.00531
G1 X87.958 Y103.103 E.00792
G1 X87.561 Y103.322 E.00892
G1 X87.102 Y103.504 E.0097
G1 X86.713 Y103.609 E.00792
G1 X86.265 Y103.676 E.00892
G1 X86.046 Y103.689 E.00431
G1 X85.593 Y103.676 E.00891
G1 X85.145 Y103.608 E.00891
G1 X84.933 Y103.557 E.0043
G1 X84.503 Y103.412 E.00891
G1 X84.098 Y103.218 E.00883
G1 X83.677 Y102.947 E.00985
G1 X83.366 Y102.691 E.00792
G1 X83.209 Y102.538 E.00431
G1 X82.914 Y102.195 E.00891
G1 X82.663 Y101.821 E.00885
M73 P86 R3
G1 X82.459 Y101.421 E.00883
G1 X82.29 Y100.95 E.00985
G1 X82.198 Y100.558 E.00792
G1 X82.166 Y100.341 E.00431
G1 X82.141 Y99.889 E.00891
G1 X82.169 Y99.44 E.00885
G1 X82.25 Y98.998 E.00883
G1 X82.402 Y98.521 E.00985
G1 X82.567 Y98.154 E.00792
G1 X82.674 Y97.962 E.00431
G1 X82.929 Y97.588 E.00891
G1 X83.496 Y96.936 E.01698
; WIPE_START
M204 S6000
G1 X81.496 Y96.914 E-.38
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




G1 X79.374 Y96.254
G1 Z4.76
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.146623
G1 F1500
M204 S6000
G1 X79.124 Y96.111 E.00174
G1 X78.955 Y95.969 E.00133
G1 X78.778 Y95.627 E.00233
; WIPE_START
G1 X78.955 Y95.969 E-.16397
G1 X79.124 Y96.111 E-.09358
G1 X79.374 Y96.254 E-.12245
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X84.478 Y97.165 Z5.16 F18000
G1 Z4.76
G1 E.4 F1800
; LINE_WIDTH: 0.477106
G1 F1500
M204 S6000
G1 X84.297 Y97.319 E.00533
; LINE_WIDTH: 0.438418
G1 X84.09 Y97.496 E.00561
; LINE_WIDTH: 0.40064
G1 X83.916 Y97.673 E.00464
; LINE_WIDTH: 0.35999
G1 X83.558 Y98.073 E.00894
G1 X83.351 Y98.374 E.0061
G1 X83.104 Y98.905 E.00977
G1 X82.969 Y99.435 E.00912
G1 X82.933 Y99.889 E.00759
G1 X82.978 Y100.415 E.0088
G1 X83.049 Y100.725 E.00531
G1 X83.186 Y101.107 E.00676
G1 X83.349 Y101.418 E.00586
G1 X83.542 Y101.714 E.0059
G1 X83.897 Y102.105 E.0088
G1 X84.292 Y102.41 E.00832
G1 X84.765 Y102.665 E.00897
G1 X85.237 Y102.817 E.00826
G1 X85.627 Y102.884 E.0066
G1 X85.978 Y102.9 E.00586
G1 X86.507 Y102.843 E.00888
G1 X86.863 Y102.752 E.00612
G1 X87.212 Y102.612 E.00628
G1 X87.64 Y102.364 E.00825
G1 X87.949 Y102.115 E.00661
G1 X88.209 Y101.845 E.00625
G1 X88.514 Y101.417 E.00876
G1 X88.675 Y101.102 E.00591
G1 X88.841 Y100.606 E.00872
G1 X88.906 Y100.247 E.00608
G1 X88.928 Y99.874 E.00624
G1 X88.885 Y99.371 E.00841
G1 X88.792 Y99.016 E.00612
G1 X88.592 Y98.516 E.00898
G1 X88.302 Y98.07 E.00887
G1 X88.058 Y97.784 E.00627
; LINE_WIDTH: 0.378823
G1 X87.881 Y97.609 E.00438
; LINE_WIDTH: 0.41929
G1 X87.678 Y97.411 E.00556
; LINE_WIDTH: 0.468119
G1 X87.38 Y97.162 E.00858
; WIPE_START
G1 X87.678 Y97.411 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X92.705 Y96.136 Z5.16 F18000
G1 Z4.76
G1 E.4 F1800
; LINE_WIDTH: 0.125285
G1 F1500
M204 S6000
G1 X92.837 Y96.069 E.00073
; LINE_WIDTH: 0.0992893
G1 X92.952 Y95.995 E.0005
; WIPE_START
G1 X92.837 Y96.069 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X88.217 Y89.994 Z5.16 F18000
G1 X78.788 Y77.595 Z5.16
G1 Z4.76
G1 E.4 F1800
; LINE_WIDTH: 0.105745
G1 F1500
M204 S6000
G1 X78.855 Y77.387 E.00087
; LINE_WIDTH: 0.14858
G1 X79.051 Y77.143 E.00192
G1 X79.147 Y77.065 E.00076
G1 X79.29 Y76.999 E.00097
; LINE_WIDTH: 0.0984407
G1 X79.435 Y76.955 E.00055
; CHANGE_LAYER
; Z_HEIGHT: 4.88
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F1500
G1 X79.29 Y76.999 E-.38
; WIPE_END
G1 E-.02 F1800
; layer num/total_layer_count: 40/49
; update layer progress
M73 L40
M991 S0 P39 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z5.16 I-.301 J1.179 P1  F18000
G1 X93.304 Y80.581 Z5.16
G1 Z4.88
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X93.311 Y88.382 E.1651
G1 X92.95 Y88.382 E.00764
G1 X92.95 Y77.128 E.23818
G1 X93.135 Y77.076 E.00407
G1 X93.215 Y77.207 E.00325
G1 X93.272 Y77.349 E.00324
G1 X93.301 Y77.49 E.00305
G1 X93.304 Y80.521 E.06416
; WIPE_START
M204 S6000
G1 X93.306 Y82.521 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X93.28 Y90.154 Z5.28 F18000
G1 X93.262 Y95.424 Z5.28
G1 Z4.88
G1 E.4 F1800
G1 F1500
M204 S500
G1 X93.284 Y95.47 E.00107
G1 X93.262 Y95.575 E.00227
G1 X93.238 Y95.614 E.00099
G1 X93.189 Y95.643 E.00119
G1 X92.956 Y95.74 E.00534
G1 X92.98 Y95.483 E.00546
G1 X93.006 Y95.4 E.00184
G1 X93.079 Y95.359 E.00178
G1 X93.154 Y95.35 E.00159
G1 X93.222 Y95.381 E.00157
; WIPE_START
M204 S6000
G1 X93.284 Y95.47 E-.0359
G1 X93.262 Y95.575 E-.03548
G1 X93.238 Y95.614 E-.01542
G1 X93.189 Y95.643 E-.01852
G1 X92.956 Y95.74 E-.08348
G1 X92.98 Y95.483 E-.08529
G1 X93.006 Y95.4 E-.02878
G1 X93.079 Y95.359 E-.02778
G1 X93.154 Y95.35 E-.02479
G1 X93.222 Y95.381 E-.02456
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X85.742 Y96.898 Z5.28 F18000
G1 X84.696 Y97.11 Z5.28
G1 Z4.88
G1 E.4 F1800
G1 F1500
M204 S500
G1 X84.589 Y96.949 E.0041
G1 X84.941 Y96.544 E.01135
G1 X86.92 Y96.544 E.04188
G1 X87.274 Y96.951 E.01141
G1 X87.15 Y97.115 E.00436
G1 X87.029 Y97.06 E.00282
G1 X86.535 Y96.915 E.0109
G1 X86.16 Y96.864 E.00801
G1 X85.807 Y96.858 E.00746
G1 X85.256 Y96.928 E.01177
G1 X84.753 Y97.092 E.01119
; WIPE_START
M204 S6000
G1 X84.589 Y96.949 E-.04131
G1 X84.941 Y96.544 E-.10189
G1 X86.188 Y96.544 E-.2368
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X84.866 Y102.291 Z5.28 F18000
G1 Z4.88
G1 E.4 F1800
G1 F1500
M204 S500
G1 X84.758 Y102.244 E.00251
G1 X84.479 Y102.083 E.00681
G1 X84.119 Y101.796 E.00975
G1 X83.81 Y101.442 E.00995
G1 X83.569 Y101.039 E.00995
G1 X83.407 Y100.607 E.00975
G1 X83.339 Y100.291 E.00683
G1 X83.311 Y99.97 E.00683
G1 X83.338 Y99.508 E.0098
G1 X83.457 Y99.037 E.01027
G1 X83.57 Y98.763 E.00628
G1 X83.727 Y98.482 E.00681
G1 X84.009 Y98.118 E.00975
G1 X84.351 Y97.809 E.00975
G1 X84.62 Y97.632 E.00683
G1 X84.909 Y97.487 E.00683
G1 X85.349 Y97.344 E.0098
G1 X85.831 Y97.283 E.01027
G1 X86.127 Y97.288 E.00629
G1 X86.446 Y97.331 E.00681
G1 X86.88 Y97.458 E.00955
G1 X87.172 Y97.593 E.00683
G1 X87.447 Y97.763 E.00683
G1 X87.8 Y98.062 E.0098
G1 X88.105 Y98.439 E.01027
G1 X88.257 Y98.695 E.00628
G1 X88.388 Y98.989 E.00681
G1 X88.51 Y99.433 E.00975
G1 X88.552 Y99.901 E.00995
G1 X88.511 Y100.36 E.00975
G1 X88.435 Y100.672 E.00681
G1 X88.331 Y100.951 E.00629
G1 X88.098 Y101.376 E.01027
G1 X87.798 Y101.741 E.01
G1 X87.438 Y102.046 E.01
G1 X87.016 Y102.286 E.01027
G1 X86.739 Y102.393 E.00628
G1 X86.428 Y102.474 E.00681
G1 X85.97 Y102.522 E.00975
G1 X85.499 Y102.487 E.01
G1 X85.03 Y102.362 E.01027
G1 X84.922 Y102.315 E.0025
M204 S250
G1 X85.029 Y101.915 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X84.942 Y101.878 E.00186
G1 X84.71 Y101.744 E.00526
G1 X84.403 Y101.499 E.00773
G1 X84.142 Y101.2 E.0078
G1 X83.939 Y100.86 E.00779
G1 X83.801 Y100.492 E.00774
G1 X83.745 Y100.23 E.00526
G1 X83.721 Y99.964 E.00526
G1 X83.744 Y99.571 E.00775
G1 X83.846 Y99.166 E.0082
G1 X83.939 Y98.941 E.00479
G1 X84.069 Y98.708 E.00525
G1 X84.31 Y98.397 E.00773
G1 X84.602 Y98.134 E.00774
G1 X84.825 Y97.987 E.00526
G1 X85.065 Y97.867 E.00526
G1 X85.439 Y97.745 E.00775
G1 X85.853 Y97.692 E.0082
G1 X86.096 Y97.697 E.00478
G1 X86.361 Y97.733 E.00526
G1 X86.735 Y97.842 E.00767
G1 X86.978 Y97.954 E.00526
G1 X87.206 Y98.095 E.00526
G1 X87.506 Y98.35 E.00775
G1 X87.769 Y98.674 E.0082
G1 X87.893 Y98.883 E.00478
G1 X88.001 Y99.127 E.00526
G1 X88.106 Y99.506 E.00773
G1 X88.141 Y99.901 E.0078
G1 X88.106 Y100.292 E.00773
G1 X88.043 Y100.552 E.00525
G1 X87.958 Y100.78 E.00479
G1 X87.758 Y101.146 E.0082
G1 X87.506 Y101.452 E.00781
G1 X87.203 Y101.709 E.00781
G1 X86.84 Y101.915 E.0082
G1 X86.613 Y102.003 E.00478
G1 X86.355 Y102.07 E.00525
G1 X85.964 Y102.111 E.00774
G1 X85.568 Y102.082 E.00781
G1 X85.165 Y101.974 E.0082
G1 X85.084 Y101.939 E.00174
; WIPE_START
M204 S6000
G1 X84.942 Y101.878 E-.02938
G1 X84.71 Y101.744 E-.05076
G1 X84.403 Y101.499 E-.07471
G1 X84.142 Y101.2 E-.07531
G1 X83.939 Y100.86 E-.07529
G1 X83.801 Y100.493 E-.07454
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X84.691 Y96.12 Z5.28 F18000
G1 Z4.88
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X92.494 Y96.12 E.16515
G1 X92.562 Y95.4 E.01531
G1 X92.603 Y95.266 E.00297
G1 X92.654 Y95.174 E.00221
G1 X92.79 Y95.034 E.00415
G1 X92.912 Y94.967 E.00294
G1 X93.017 Y94.934 E.00232
G1 X93.219 Y94.929 E.00428
G1 X93.318 Y94.954 E.00217
G1 X93.412 Y94.996 E.00217
G1 X93.57 Y95.126 E.00433
G1 X93.63 Y95.209 E.00218
G1 X93.697 Y95.387 E.00403
G1 X93.708 Y95.497 E.00234
G1 X93.69 Y95.642 E.00307
G1 X93.645 Y95.763 E.00273
G1 X93.521 Y95.929 E.00439
G1 X93.38 Y96.023 E.00359
G1 X93.174 Y96.108 E.00471
G1 X92.999 Y96.272 E.00508
G1 X92.866 Y96.364 E.0034
G1 X92.729 Y96.427 E.00321
G1 X92.582 Y96.466 E.00321
G1 X92.404 Y96.482 E.00379
G1 X87.428 Y96.482 E.10532
G1 X88.614 Y97.845 E.03824
G1 X88.72 Y97.992 E.00386
G1 X88.934 Y98.35 E.00882
G1 X89.159 Y98.9 E.01258
G1 X89.286 Y99.49 E.01276
G1 X89.305 Y100.088 E.01267
G1 X89.25 Y100.531 E.00946
G1 X89.103 Y101.067 E.01175
G1 X88.846 Y101.61 E.01272
G1 X88.594 Y101.98 E.00948
G1 X88.218 Y102.39 E.01176
G1 X88.037 Y102.543 E.00502
G1 X87.574 Y102.855 E.01183
G1 X87.206 Y103.031 E.00863
G1 X86.781 Y103.171 E.00946
G1 X86.422 Y103.245 E.00775
G1 X86.04 Y103.279 E.00812
G1 X85.63 Y103.267 E.00869
G1 X85.047 Y103.164 E.01254
G1 X84.658 Y103.032 E.00869
G1 X84.296 Y102.859 E.00849
G1 X83.957 Y102.644 E.00849
G1 X83.646 Y102.391 E.00849
G1 X83.368 Y102.104 E.00844
G1 X83.101 Y101.747 E.00946
G1 X82.838 Y101.265 E.01162
G1 X82.696 Y100.879 E.00869
G1 X82.602 Y100.489 E.0085
G1 X82.556 Y100.091 E.00849
G1 X82.574 Y99.499 E.01254
G1 X82.648 Y99.095 E.00869
G1 X82.767 Y98.712 E.00849
G1 X82.93 Y98.345 E.00849
G1 X83.248 Y97.845 E.01254
G1 X84.433 Y96.482 E.03824
G1 X79.467 Y96.482 E.10512
G1 X79.228 Y96.454 E.00508
G1 X78.955 Y96.34 E.00626
G1 X78.827 Y96.239 E.00346
G1 X78.728 Y96.129 E.00312
G1 X78.627 Y95.957 E.00423
G1 X78.579 Y95.812 E.00324
G1 X78.55 Y95.565 E.00527
G1 X78.55 Y77.628 E.37965
G1 X78.587 Y77.351 E.00592
G1 X78.696 Y77.119 E.00542
G1 X78.869 Y76.925 E.00551
G1 X78.99 Y76.841 E.00312
G1 X79.136 Y76.773 E.00341
G1 X79.387 Y76.723 E.00542
G1 X92.458 Y76.722 E.27665
G1 X92.635 Y76.747 E.00379
G1 X92.779 Y76.794 E.0032
G1 X92.955 Y76.889 E.00424
G1 X92.906 Y77.082 E.0042
G1 X79.885 Y77.082 E.2756
G1 X79.627 Y77.12 E.00553
G1 X79.316 Y77.276 E.00736
G1 X79.077 Y77.529 E.00737
G1 X78.948 Y77.807 E.00649
G1 X78.911 Y78.056 E.00533
G1 X78.911 Y95.155 E.36192
G1 X78.964 Y95.453 E.0064
G1 X79.148 Y95.772 E.00781
G1 X79.482 Y96.033 E.00896
G1 X79.86 Y96.12 E.00821
G1 X84.631 Y96.12 E.10099
; WIPE_START
M204 S6000
G1 X86.631 Y96.12 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X83.535 Y96.891 Z5.28 F18000
G1 Z4.88
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X79.443 Y96.891 E.08049
G1 X79.133 Y96.855 E.00613
G1 X78.846 Y96.75 E.00601
G1 X78.725 Y96.68 E.00277
G1 X78.546 Y96.538 E.00449
G1 X78.404 Y96.381 E.00416
G1 X78.313 Y96.245 E.00322
G1 X78.248 Y96.114 E.00287
G1 X78.177 Y95.901 E.00442
G1 X78.141 Y95.589 E.00619
G1 X78.141 Y77.61 E.35362
G1 X78.161 Y77.374 E.00466
G1 X78.195 Y77.232 E.00288
G1 X78.252 Y77.079 E.00322
G1 X78.353 Y76.893 E.00416
G1 X78.494 Y76.714 E.00448
G1 X78.612 Y76.605 E.00315
G1 X78.786 Y76.485 E.00416
G1 X78.992 Y76.388 E.00447
G1 X79.146 Y76.344 E.00315
G1 X79.358 Y76.313 E.00422
G1 X92.486 Y76.313 E.25821
G1 X92.729 Y76.347 E.00481
G1 X92.941 Y76.417 E.00441
G1 X93.139 Y76.524 E.00442
G1 X93.315 Y76.663 E.00442
G1 X93.465 Y76.831 E.00442
G1 X93.583 Y77.022 E.00442
G1 X93.666 Y77.231 E.00442
G1 X93.71 Y77.448 E.00436
G1 X93.72 Y88.791 E.2231
G1 X92.541 Y88.791 E.02321
G1 X92.541 Y77.491 E.22226
G1 X79.915 Y77.491 E.24833
G1 X79.752 Y77.515 E.00325
G1 X79.565 Y77.609 E.00412
G1 X79.42 Y77.762 E.00413
G1 X79.344 Y77.925 E.00355
G1 X79.321 Y78.086 E.00319
G1 X79.321 Y95.119 E.33504
G1 X79.354 Y95.311 E.00382
G1 X79.463 Y95.499 E.00427
G1 X79.663 Y95.654 E.00498
G1 X79.907 Y95.711 E.00493
G1 X92.122 Y95.711 E.24026
G1 X92.159 Y95.32 E.00773
G1 X92.224 Y95.105 E.00442
G1 X92.313 Y94.944 E.00362
G1 X92.424 Y94.808 E.00344
G1 X92.556 Y94.696 E.00341
G1 X92.751 Y94.588 E.00437
G1 X92.932 Y94.532 E.00374
G1 X93.106 Y94.512 E.00344
G1 X93.282 Y94.523 E.00346
G1 X93.452 Y94.565 E.00345
G1 X93.612 Y94.637 E.00345
G1 X93.758 Y94.736 E.00346
G1 X93.883 Y94.859 E.00345
G1 X93.985 Y95.002 E.00346
G1 X94.06 Y95.162 E.00347
G1 X94.102 Y95.313 E.00309
G1 X94.119 Y95.504 E.00376
G1 X94.09 Y95.739 E.00466
G1 X94.014 Y95.944 E.0043
G1 X93.914 Y96.105 E.00374
G1 X93.707 Y96.305 E.00565
G1 X93.564 Y96.39 E.00329
G1 X93.399 Y96.458 E.0035
G1 X93.256 Y96.592 E.00385
G1 X93.07 Y96.72 E.00444
G1 X92.868 Y96.814 E.00438
G1 X92.652 Y96.871 E.00438
G1 X92.421 Y96.891 E.00456
G1 X88.326 Y96.891 E.08055
G1 X88.934 Y97.59 E.01823
G1 X89.063 Y97.767 E.0043
G1 X89.296 Y98.158 E.00895
M73 P87 R3
G1 X89.409 Y98.398 E.00522
G1 X89.551 Y98.78 E.00801
G1 X89.659 Y99.22 E.00891
G1 X89.713 Y99.661 E.00873
G1 X89.714 Y100.113 E.00889
G1 X89.653 Y100.605 E.00976
G1 X89.557 Y101.001 E.00801
G1 X89.384 Y101.459 E.00962
G1 X89.198 Y101.82 E.008
G1 X88.919 Y102.23 E.00976
G1 X88.652 Y102.538 E.00801
G1 X88.494 Y102.693 E.00435
G1 X88.289 Y102.866 E.00528
G1 X87.955 Y103.105 E.00807
G1 X87.766 Y103.216 E.00432
G1 X87.358 Y103.411 E.00889
G1 X86.887 Y103.567 E.00976
G1 X86.488 Y103.649 E.00801
G1 X86.268 Y103.676 E.00437
G1 X86.046 Y103.689 E.00437
G1 X85.593 Y103.676 E.00891
G1 X85.145 Y103.608 E.00891
G1 X84.933 Y103.557 E.0043
G1 X84.503 Y103.412 E.00891
G1 X84.098 Y103.218 E.00885
G1 X83.717 Y102.977 E.00885
G1 X83.368 Y102.693 E.00885
G1 X83.056 Y102.37 E.00883
G1 X82.759 Y101.973 E.00976
G1 X82.554 Y101.621 E.00801
G1 X82.46 Y101.423 E.0043
G1 X82.303 Y100.998 E.00892
G1 X82.199 Y100.56 E.00885
G1 X82.147 Y100.114 E.00885
G1 X82.148 Y99.661 E.00891
G1 X82.169 Y99.443 E.0043
G1 X82.25 Y98.997 E.00891
G1 X82.383 Y98.567 E.00885
G1 X82.566 Y98.156 E.00885
G1 X82.798 Y97.767 E.00891
G1 X82.927 Y97.59 E.0043
G1 X83.496 Y96.936 E.01705
; WIPE_START
M204 S6000
G1 X81.496 Y96.914 E-.38
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




G1 X79.363 Y96.246
G1 Z4.88
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.12417
G1 F1500
M204 S6000
G1 X79.253 Y96.185 E.00062
; LINE_WIDTH: 0.149101
G1 X79.143 Y96.124 E.00077
G1 X78.946 Y95.962 E.00157
G1 X78.778 Y95.627 E.00231
; WIPE_START
G1 X78.946 Y95.962 E-.18876
G1 X79.143 Y96.124 E-.12799
G1 X79.253 Y96.185 E-.06324
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X84.478 Y97.165 Z5.28 F18000
G1 Z4.88
G1 E.4 F1800
; LINE_WIDTH: 0.477118
G1 F1500
M204 S6000
G1 X84.297 Y97.319 E.00533
; LINE_WIDTH: 0.438428
G1 X84.09 Y97.496 E.00561
; LINE_WIDTH: 0.400651
G1 X83.916 Y97.673 E.00464
; LINE_WIDTH: 0.360339
G1 X83.552 Y98.08 E.00911
G1 X83.268 Y98.523 E.00878
G1 X83.102 Y98.907 E.007
G1 X82.969 Y99.435 E.00909
G1 X82.935 Y99.988 E.00924
G1 X82.967 Y100.358 E.00619
G1 X83.06 Y100.767 E.00701
G1 X83.223 Y101.189 E.00755
G1 X83.42 Y101.535 E.00665
G1 X83.661 Y101.855 E.00669
G1 X83.903 Y102.11 E.00587
G1 X84.277 Y102.401 E.00791
G1 X84.481 Y102.525 E.00397
G1 X84.802 Y102.678 E.00594
G1 X85.149 Y102.792 E.0061
G1 X85.451 Y102.857 E.00516
G1 X85.961 Y102.9 E.00853
G1 X86.483 Y102.847 E.00877
G1 X86.846 Y102.754 E.00625
G1 X87.189 Y102.621 E.00613
G1 X87.639 Y102.361 E.00869
G1 X87.957 Y102.109 E.00677
G1 X88.291 Y101.744 E.00826
G1 X88.515 Y101.414 E.00667
G1 X88.68 Y101.097 E.00596
G1 X88.799 Y100.779 E.00566
G1 X88.885 Y100.409 E.00634
G1 X88.928 Y99.916 E.00827
G1 X88.885 Y99.371 E.00911
G1 X88.793 Y99.016 E.00613
G1 X88.597 Y98.527 E.00879
G1 X88.309 Y98.08 E.00888
G1 X88.06 Y97.786 E.00642
; LINE_WIDTH: 0.378492
G1 X87.882 Y97.61 E.0044
; LINE_WIDTH: 0.419228
G1 X87.678 Y97.411 E.00559
; LINE_WIDTH: 0.468149
G1 X87.38 Y97.162 E.00857
; WIPE_START
G1 X87.678 Y97.411 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X92.706 Y96.135 Z5.28 F18000
G1 Z4.88
G1 E.4 F1800
; LINE_WIDTH: 0.125553
G1 F1500
M204 S6000
G1 X92.837 Y96.069 E.00073
; LINE_WIDTH: 0.0994117
G1 X92.953 Y95.995 E.00051
; WIPE_START
G1 X92.837 Y96.069 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X88.217 Y89.994 Z5.28 F18000
G1 X78.788 Y77.595 Z5.28
G1 Z4.88
G1 E.4 F1800
; LINE_WIDTH: 0.105795
G1 F1500
M204 S6000
G1 X78.855 Y77.387 E.00087
; LINE_WIDTH: 0.148724
G1 X79.05 Y77.144 E.00191
G1 X79.147 Y77.065 E.00077
G1 X79.289 Y76.999 E.00096
; LINE_WIDTH: 0.0986004
G1 X79.435 Y76.955 E.00055
; CHANGE_LAYER
; Z_HEIGHT: 5
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F1500
G1 X79.289 Y76.999 E-.38
; WIPE_END
G1 E-.02 F1800
; layer num/total_layer_count: 41/49
; update layer progress
M73 L41
M991 S0 P40 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z5.28 I-.301 J1.179 P1  F18000
G1 X93.304 Y80.581 Z5.28
G1 Z5
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X93.311 Y88.382 E.1651
G1 X92.95 Y88.382 E.00764
G1 X92.95 Y77.128 E.23818
G1 X93.135 Y77.076 E.00407
G1 X93.215 Y77.207 E.00325
G1 X93.272 Y77.349 E.00324
G1 X93.301 Y77.49 E.00306
G1 X93.304 Y80.521 E.06416
; WIPE_START
M204 S6000
G1 X93.306 Y82.521 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X93.28 Y90.154 Z5.4 F18000
G1 X93.262 Y95.424 Z5.4
G1 Z5
G1 E.4 F1800
G1 F1500
M204 S500
G1 X93.284 Y95.47 E.00107
G1 X93.262 Y95.576 E.00228
G1 X93.238 Y95.614 E.00096
G1 X93.189 Y95.643 E.00121
G1 X92.956 Y95.739 E.00532
G1 X92.98 Y95.484 E.00544
G1 X93.006 Y95.4 E.00186
G1 X93.101 Y95.347 E.0023
G1 X93.154 Y95.35 E.00112
G1 X93.205 Y95.368 E.00114
G1 X93.219 Y95.382 E.00043
; WIPE_START
M204 S6000
G1 X93.284 Y95.47 E-.03591
G1 X93.262 Y95.576 E-.03562
G1 X93.238 Y95.614 E-.01502
G1 X93.189 Y95.643 E-.01886
G1 X92.956 Y95.739 E-.08299
G1 X92.98 Y95.484 E-.08482
G1 X93.006 Y95.4 E-.02897
G1 X93.101 Y95.347 E-.03585
G1 X93.154 Y95.35 E-.01741
G1 X93.205 Y95.368 E-.01781
G1 X93.219 Y95.382 E-.00674
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X85.739 Y96.899 Z5.4 F18000
G1 X84.696 Y97.11 Z5.4
G1 Z5
G1 E.4 F1800
G1 F1500
M204 S500
G1 X84.589 Y96.949 E.0041
G1 X84.941 Y96.544 E.01135
G1 X86.92 Y96.544 E.04188
G1 X87.274 Y96.951 E.0114
G1 X87.15 Y97.115 E.00436
G1 X87.029 Y97.059 E.00282
G1 X86.535 Y96.915 E.01089
G1 X86.16 Y96.864 E.00801
G1 X85.804 Y96.858 E.00752
G1 X85.256 Y96.928 E.01171
G1 X84.753 Y97.092 E.01119
; WIPE_START
M204 S6000
G1 X84.589 Y96.949 E-.04131
G1 X84.941 Y96.544 E-.10188
G1 X86.188 Y96.544 E-.23681
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X84.833 Y102.276 Z5.4 F18000
G1 Z5
G1 E.4 F1800
G1 F1500
M204 S500
G1 X84.486 Y102.089 E.00834
G1 X84.119 Y101.796 E.00995
G1 X83.808 Y101.44 E.00999
G1 X83.563 Y101.024 E.01021
G1 X83.451 Y100.747 E.00634
G1 X83.365 Y100.437 E.00681
G1 X83.31 Y99.979 E.00975
G1 X83.338 Y99.508 E.00999
G1 X83.456 Y99.04 E.01022
G1 X83.57 Y98.763 E.00634
G1 X83.727 Y98.482 E.00681
G1 X84.003 Y98.125 E.00956
G1 X84.236 Y97.903 E.00681
G1 X84.475 Y97.722 E.00634
G1 X84.898 Y97.491 E.01021
G1 X85.349 Y97.344 E.01004
G1 X85.828 Y97.283 E.01021
G1 X86.127 Y97.288 E.00634
G1 X86.446 Y97.331 E.00681
G1 X86.879 Y97.458 E.00955
G1 X87.172 Y97.593 E.00683
G1 X87.447 Y97.763 E.00683
G1 X87.798 Y98.061 E.00975
G1 X88.091 Y98.417 E.00975
G1 X88.256 Y98.693 E.00681
G1 X88.379 Y98.966 E.00634
G1 X88.51 Y99.431 E.01022
G1 X88.552 Y99.901 E.00999
G1 X88.51 Y100.369 E.00995
G1 X88.385 Y100.824 E.00999
G1 X88.172 Y101.258 E.01021
G1 X88.003 Y101.504 E.00634
G1 X87.797 Y101.74 E.00662
G1 X87.565 Y101.949 E.00661
G1 X87.321 Y102.122 E.00634
G1 X86.89 Y102.341 E.01022
G1 X86.437 Y102.473 E.00999
G1 X85.968 Y102.523 E.00999
G1 X85.487 Y102.483 E.01021
G1 X85.195 Y102.416 E.00634
G1 X84.892 Y102.307 E.00681
G1 X84.886 Y102.304 E.00014
M204 S250
G1 X85.027 Y101.915 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X84.713 Y101.746 E.00703
G1 X84.403 Y101.499 E.0078
G1 X84.141 Y101.2 E.00781
G1 X83.931 Y100.843 E.00815
G1 X83.839 Y100.615 E.00484
G1 X83.768 Y100.357 E.00525
G1 X83.721 Y99.967 E.00773
G1 X83.744 Y99.571 E.00781
G1 X83.845 Y99.169 E.00815
G1 X83.939 Y98.942 E.00483
G1 X84.069 Y98.708 E.00526
G1 X84.308 Y98.4 E.00767
G1 X84.501 Y98.215 E.00525
G1 X84.697 Y98.067 E.00483
G1 X85.061 Y97.868 E.00815
G1 X85.439 Y97.745 E.00783
G1 X85.85 Y97.692 E.00815
G1 X86.096 Y97.697 E.00483
G1 X86.361 Y97.733 E.00526
G1 X86.735 Y97.842 E.00767
G1 X86.978 Y97.954 E.00526
G1 X87.205 Y98.095 E.00526
G1 X87.506 Y98.349 E.00774
G1 X87.755 Y98.653 E.00773
G1 X87.892 Y98.883 E.00526
G1 X87.993 Y99.107 E.00483
G1 X88.106 Y99.506 E.00815
G1 X88.141 Y99.901 E.00781
G1 X88.106 Y100.296 E.00779
G1 X88 Y100.678 E.00781
G1 X87.818 Y101.051 E.00815
G1 X87.679 Y101.253 E.00483
G1 X87.505 Y101.452 E.0052
G1 X87.309 Y101.629 E.00519
G1 X87.108 Y101.771 E.00483
G1 X86.739 Y101.959 E.00815
G1 X86.358 Y102.07 E.00781
G1 X85.963 Y102.112 E.00781
G1 X85.55 Y102.078 E.00815
G1 X85.31 Y102.022 E.00483
G1 X85.082 Y101.94 E.00478
; WIPE_START
M204 S6000
G1 X84.713 Y101.746 E-.07924
G1 X84.403 Y101.499 E-.07534
G1 X84.141 Y101.2 E-.07544
G1 X83.931 Y100.843 E-.07875
G1 X83.839 Y100.615 E-.04671
G1 X83.804 Y100.49 E-.02452
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X84.691 Y96.12 Z5.4 F18000
G1 Z5
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X92.494 Y96.12 E.16516
G1 X92.562 Y95.401 E.0153
G1 X92.604 Y95.265 E.00301
G1 X92.653 Y95.175 E.00218
G1 X92.79 Y95.034 E.00415
G1 X92.913 Y94.966 E.00297
G1 X93.016 Y94.934 E.0023
G1 X93.219 Y94.929 E.00428
G1 X93.318 Y94.954 E.00218
G1 X93.497 Y95.054 E.00433
G1 X93.57 Y95.125 E.00217
M73 P87 R2
G1 X93.63 Y95.209 E.00217
G1 X93.698 Y95.389 E.00407
G1 X93.708 Y95.497 E.0023
G1 X93.69 Y95.641 E.00308
G1 X93.645 Y95.764 E.00277
G1 X93.52 Y95.929 E.00438
G1 X93.379 Y96.024 E.0036
G1 X93.183 Y96.105 E.00449
G1 X92.875 Y96.36 E.00847
G1 X92.729 Y96.427 E.0034
G1 X92.582 Y96.466 E.00322
G1 X92.404 Y96.482 E.00378
G1 X87.428 Y96.482 E.10532
G1 X88.612 Y97.843 E.03818
G1 X88.935 Y98.352 E.01277
G1 X89.159 Y98.901 E.01256
G1 X89.286 Y99.49 E.01273
G1 X89.305 Y100.088 E.01268
G1 X89.251 Y100.527 E.00936
G1 X89.105 Y101.061 E.01172
G1 X88.849 Y101.606 E.01273
G1 X88.621 Y101.947 E.00869
G1 X88.353 Y102.258 E.00869
G1 X88.041 Y102.54 E.00891
G1 X87.739 Y102.756 E.00786
G1 X87.379 Y102.955 E.00871
G1 X86.814 Y103.164 E.01273
G1 X86.222 Y103.269 E.01273
G1 X85.63 Y103.267 E.01254
G1 X85.049 Y103.164 E.01249
G1 X84.622 Y103.016 E.00956
G1 X84.288 Y102.855 E.00785
G1 X83.797 Y102.522 E.01256
G1 X83.502 Y102.251 E.00849
G1 X83.24 Y101.947 E.00849
G1 X83.017 Y101.613 E.00849
G1 X82.835 Y101.258 E.00845
G1 X82.686 Y100.842 E.00936
G1 X82.574 Y100.3 E.01172
G1 X82.551 Y99.89 E.00869
G1 X82.576 Y99.49 E.00849
G1 X82.648 Y99.095 E.0085
G1 X82.767 Y98.712 E.00849
G1 X82.93 Y98.345 E.00849
G1 X83.248 Y97.845 E.01253
G1 X84.433 Y96.482 E.03824
G1 X79.467 Y96.482 E.10513
G1 X79.219 Y96.453 E.00527
G1 X79.074 Y96.405 E.00324
G1 X78.858 Y96.269 E.00539
G1 X78.73 Y96.132 E.00396
G1 X78.656 Y96.014 E.00295
G1 X78.577 Y95.801 E.0048
G1 X78.55 Y95.565 E.00504
G1 X78.55 Y77.628 E.37965
G1 X78.588 Y77.349 E.00597
G1 X78.697 Y77.118 E.00539
G1 X78.868 Y76.926 E.00546
G1 X78.99 Y76.841 E.00315
G1 X79.136 Y76.773 E.00342
G1 X79.387 Y76.723 E.00541
G1 X92.459 Y76.722 E.27668
G1 X92.635 Y76.747 E.00376
G1 X92.778 Y76.794 E.00319
G1 X92.955 Y76.889 E.00424
G1 X92.906 Y77.082 E.0042
G1 X79.876 Y77.082 E.27579
G1 X79.588 Y77.133 E.0062
G1 X79.31 Y77.282 E.00668
G1 X79.077 Y77.529 E.00717
G1 X78.948 Y77.807 E.00649
G1 X78.911 Y78.056 E.00533
G1 X78.911 Y95.155 E.36192
G1 X78.964 Y95.453 E.00639
G1 X79.152 Y95.778 E.00796
G1 X79.512 Y96.047 E.00951
G1 X79.867 Y96.12 E.00767
G1 X84.631 Y96.12 E.10083
; WIPE_START
M204 S6000
G1 X86.631 Y96.12 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X83.535 Y96.891 Z5.4 F18000
G1 Z5
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X79.443 Y96.891 E.08049
G1 X79.13 Y96.854 E.00619
G1 X78.917 Y96.784 E.00442
G1 X78.789 Y96.719 E.00283
G1 X78.599 Y96.587 E.00454
G1 X78.493 Y96.486 E.00289
M73 P88 R2
G1 X78.398 Y96.373 E.0029
G1 X78.287 Y96.195 E.00413
G1 X78.177 Y95.897 E.00624
G1 X78.141 Y95.589 E.00611
G1 X78.141 Y77.61 E.35362
G1 X78.161 Y77.374 E.00466
G1 X78.195 Y77.231 E.00289
G1 X78.245 Y77.093 E.00289
G1 X78.353 Y76.893 E.00448
G1 X78.494 Y76.714 E.00447
G1 X78.611 Y76.606 E.00312
G1 X78.786 Y76.485 E.00419
G1 X78.992 Y76.388 E.00448
G1 X79.144 Y76.344 E.00312
G1 X79.358 Y76.313 E.00425
G1 X92.488 Y76.313 E.25824
G1 X92.729 Y76.347 E.00478
G1 X92.941 Y76.417 E.0044
G1 X93.139 Y76.524 E.00442
G1 X93.315 Y76.663 E.00442
G1 X93.465 Y76.831 E.00442
G1 X93.583 Y77.022 E.00442
G1 X93.666 Y77.231 E.00442
G1 X93.71 Y77.448 E.00436
G1 X93.72 Y88.791 E.2231
G1 X92.541 Y88.791 E.02321
G1 X92.541 Y77.491 E.22226
G1 X79.912 Y77.491 E.24839
G1 X79.724 Y77.524 E.00376
G1 X79.562 Y77.611 E.00361
G1 X79.42 Y77.762 E.00406
G1 X79.344 Y77.925 E.00355
G1 X79.321 Y78.086 E.00319
G1 X79.321 Y95.119 E.33504
G1 X79.354 Y95.311 E.00382
G1 X79.464 Y95.5 E.00431
G1 X79.684 Y95.664 E.0054
G1 X79.909 Y95.711 E.00452
G1 X92.122 Y95.711 E.24021
G1 X92.158 Y95.321 E.00771
G1 X92.225 Y95.104 E.00445
G1 X92.313 Y94.944 E.0036
G1 X92.424 Y94.809 E.00345
G1 X92.556 Y94.696 E.00341
G1 X92.751 Y94.588 E.0044
G1 X92.932 Y94.532 E.00372
G1 X93.106 Y94.512 E.00344
G1 X93.281 Y94.523 E.00345
G1 X93.452 Y94.565 E.00346
G1 X93.612 Y94.637 E.00345
G1 X93.757 Y94.736 E.00346
G1 X93.883 Y94.859 E.00345
G1 X93.985 Y95.002 E.00346
G1 X94.06 Y95.161 E.00347
G1 X94.102 Y95.315 E.00313
G1 X94.119 Y95.503 E.00371
G1 X94.09 Y95.738 E.00466
G1 X94.014 Y95.945 E.00433
G1 X93.914 Y96.105 E.0037
G1 X93.708 Y96.305 E.00565
G1 X93.562 Y96.391 E.00332
G1 X93.402 Y96.457 E.00341
G1 X93.192 Y96.641 E.00549
G1 X93.073 Y96.719 E.00281
G1 X92.868 Y96.814 E.00444
G1 X92.652 Y96.871 E.00439
G1 X92.421 Y96.891 E.00456
G1 X88.326 Y96.891 E.08055
G1 X88.934 Y97.589 E.01821
G1 X89.085 Y97.801 E.00512
G1 X89.296 Y98.159 E.00817
G1 X89.391 Y98.356 E.00431
G1 X89.551 Y98.78 E.00891
G1 X89.659 Y99.22 E.00891
G1 X89.713 Y99.661 E.00873
G1 X89.714 Y100.113 E.00889
G1 X89.654 Y100.601 E.00967
G1 X89.557 Y101.001 E.0081
G1 X89.488 Y101.209 E.00431
G1 X89.305 Y101.627 E.00897
G1 X89.199 Y101.818 E.0043
G1 X88.947 Y102.195 E.00891
G1 X88.652 Y102.538 E.00891
G1 X88.494 Y102.693 E.00435
G1 X88.293 Y102.863 E.00518
G1 X87.958 Y103.103 E.0081
G1 X87.561 Y103.322 E.00892
G1 X87.361 Y103.411 E.0043
G1 X86.929 Y103.557 E.00897
G1 X86.716 Y103.608 E.0043
G1 X86.265 Y103.676 E.00897
G1 X86.046 Y103.689 E.00431
G1 X85.593 Y103.676 E.00891
G1 X85.145 Y103.608 E.00891
G1 X84.933 Y103.557 E.00429
G1 X84.466 Y103.395 E.00973
G1 X84.095 Y103.217 E.0081
G1 X83.906 Y103.105 E.00431
G1 X83.539 Y102.84 E.00891
G1 X83.207 Y102.536 E.00885
G1 X82.914 Y102.195 E.00885
G1 X82.663 Y101.821 E.00885
G1 X82.459 Y101.421 E.00884
G1 X82.293 Y100.959 E.00966
G1 X82.198 Y100.558 E.00811
G1 X82.166 Y100.341 E.0043
G1 X82.141 Y99.889 E.00891
G1 X82.169 Y99.44 E.00885
G1 X82.25 Y98.997 E.00885
G1 X82.383 Y98.567 E.00885
G1 X82.566 Y98.156 E.00885
G1 X82.798 Y97.767 E.00891
G1 X82.927 Y97.59 E.0043
G1 X83.496 Y96.936 E.01705
; WIPE_START
M204 S6000
G1 X81.496 Y96.914 E-.38
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




G1 X79.316 Y96.244
G1 Z5
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.147955
G1 F1500
M204 S6000
G1 X78.955 Y95.97 E.00277
G1 X78.778 Y95.627 E.00235
; WIPE_START
G1 X78.955 Y95.97 E-.17457
G1 X79.316 Y96.244 E-.20543
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X84.479 Y97.167 Z5.4 F18000
G1 Z5
G1 E.4 F1800
; LINE_WIDTH: 0.477222
G1 F1500
M204 S6000
G1 X84.229 Y97.37 E.00726
; LINE_WIDTH: 0.442313
G1 X84.108 Y97.483 E.00342
; LINE_WIDTH: 0.405872
G1 X83.973 Y97.61 E.00353
; LINE_WIDTH: 0.36014
G1 X83.715 Y97.882 E.00626
G1 X83.409 Y98.287 E.00846
G1 X83.268 Y98.523 E.00458
G1 X83.124 Y98.846 E.0059
G1 X83.023 Y99.187 E.00593
G1 X82.955 Y99.536 E.00594
G1 X82.934 Y99.976 E.00735
G1 X82.992 Y100.498 E.00876
G1 X83.098 Y100.877 E.00657
G1 X83.23 Y101.202 E.00586
G1 X83.544 Y101.716 E.01004
G1 X83.848 Y102.058 E.00763
G1 X84.266 Y102.395 E.00897
G1 X84.75 Y102.657 E.00917
G1 X85.099 Y102.776 E.00615
G1 X85.441 Y102.858 E.00586
G1 X85.957 Y102.9 E.00864
G1 X86.561 Y102.833 E.01014
G1 X87.076 Y102.673 E.00899
G1 X87.536 Y102.435 E.00865
G1 X87.805 Y102.242 E.00552
G1 X88.06 Y102.013 E.00572
G1 X88.308 Y101.729 E.00629
G1 X88.521 Y101.412 E.00636
G1 X88.744 Y100.944 E.00865
G1 X88.878 Y100.457 E.00842
G1 X88.922 Y100.065 E.00657
G1 X88.92 Y99.701 E.00608
G1 X88.885 Y99.371 E.00553
G1 X88.792 Y99.017 E.00611
G1 X88.598 Y98.529 E.00876
G1 X88.307 Y98.077 E.00898
G1 X88.058 Y97.784 E.00641
; LINE_WIDTH: 0.378827
G1 X87.881 Y97.609 E.00438
; LINE_WIDTH: 0.419328
G1 X87.678 Y97.411 E.00557
; LINE_WIDTH: 0.468122
G1 X87.38 Y97.162 E.00857
; WIPE_START
G1 X87.678 Y97.411 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X92.706 Y96.136 Z5.4 F18000
G1 Z5
G1 E.4 F1800
; LINE_WIDTH: 0.128732
G1 F1500
M204 S6000
G1 X92.868 Y96.047 E.00095
; LINE_WIDTH: 0.0937245
G1 X92.952 Y95.995 E.00033
; WIPE_START
G1 X92.868 Y96.047 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X88.238 Y89.98 Z5.4 F18000
G1 X78.788 Y77.595 Z5.4
G1 Z5
G1 E.4 F1800
; LINE_WIDTH: 0.106091
G1 F1500
M204 S6000
G1 X78.854 Y77.387 E.00087
; LINE_WIDTH: 0.149314
G1 X79.049 Y77.145 E.00192
G1 X79.137 Y77.072 E.0007
G1 X79.288 Y76.999 E.00104
; LINE_WIDTH: 0.100296
G1 X79.425 Y76.954 E.00054
; CHANGE_LAYER
; Z_HEIGHT: 5.12
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F1500
G1 X79.288 Y76.999 E-.38
; WIPE_END
G1 E-.02 F1800
; layer num/total_layer_count: 42/49
; update layer progress
M73 L42
M991 S0 P41 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z5.4 I-.301 J1.179 P1  F18000
G1 X93.304 Y80.582 Z5.4
G1 Z5.12
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X93.311 Y88.382 E.1651
G1 X92.95 Y88.382 E.00764
G1 X92.95 Y77.128 E.23818
G1 X93.135 Y77.076 E.00407
G1 X93.216 Y77.207 E.00325
G1 X93.272 Y77.349 E.00324
G1 X93.301 Y77.49 E.00306
G1 X93.304 Y80.522 E.06416
; WIPE_START
M204 S6000
G1 X93.306 Y82.522 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X93.293 Y90.154 Z5.52 F18000
G1 X93.284 Y95.47 Z5.52
G1 Z5.12
G1 E.4 F1800
G1 F1500
M204 S500
G1 X93.25 Y95.606 E.00298
G1 X92.956 Y95.739 E.00683
G1 X92.98 Y95.484 E.00543
G1 X93.006 Y95.4 E.00186
G1 X93.101 Y95.347 E.0023
G1 X93.154 Y95.35 E.00111
G1 X93.227 Y95.383 E.0017
G1 X93.251 Y95.419 E.00092
; WIPE_START
M204 S6000
G1 X93.25 Y95.606 E-.06235
G1 X92.956 Y95.739 E-.10765
G1 X92.98 Y95.484 E-.08556
G1 X93.006 Y95.4 E-.02936
G1 X93.101 Y95.347 E-.03629
G1 X93.154 Y95.35 E-.01748
G1 X93.227 Y95.383 E-.02683
G1 X93.251 Y95.419 E-.01449
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X85.763 Y96.899 Z5.52 F18000
G1 X84.696 Y97.11 Z5.52
G1 Z5.12
G1 E.4 F1800
G1 F1500
M204 S500
G1 X84.589 Y96.949 E.0041
G1 X84.941 Y96.544 E.01135
G1 X86.92 Y96.544 E.04188
G1 X87.273 Y96.951 E.0114
G1 X87.15 Y97.115 E.00436
G1 X87.029 Y97.059 E.00282
G1 X86.535 Y96.915 E.0109
G1 X86.159 Y96.864 E.00802
G1 X85.802 Y96.858 E.00758
G1 X85.255 Y96.929 E.01166
G1 X84.753 Y97.092 E.01118
; WIPE_START
M204 S6000
G1 X84.589 Y96.949 E-.04131
G1 X84.941 Y96.544 E-.10189
G1 X86.187 Y96.544 E-.2368
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X84.833 Y102.276 Z5.52 F18000
G1 Z5.12
G1 E.4 F1800
G1 F1500
M204 S500
G1 X84.486 Y102.089 E.00834
G1 X84.119 Y101.796 E.00995
G1 X83.808 Y101.441 E.00999
G1 X83.565 Y101.027 E.01016
G1 X83.451 Y100.747 E.0064
G1 X83.365 Y100.437 E.00682
G1 X83.31 Y99.979 E.00975
G1 X83.338 Y99.51 E.00995
G1 X83.447 Y99.063 E.00975
G1 X83.57 Y98.764 E.00683
G1 X83.727 Y98.482 E.00683
G1 X84.009 Y98.118 E.00975
G1 X84.351 Y97.809 E.00975
G1 X84.62 Y97.632 E.00683
G1 X84.909 Y97.487 E.00683
G1 X85.349 Y97.344 E.00979
G1 X85.825 Y97.283 E.01016
G1 X86.127 Y97.288 E.00639
G1 X86.446 Y97.331 E.00682
G1 X86.879 Y97.458 E.00955
G1 X87.172 Y97.593 E.00683
G1 X87.447 Y97.763 E.00683
G1 X87.798 Y98.061 E.00975
G1 X88.091 Y98.417 E.00975
G1 X88.256 Y98.693 E.00682
G1 X88.38 Y98.969 E.00639
G1 X88.51 Y99.431 E.01016
G1 X88.552 Y99.901 E.00999
G1 X88.511 Y100.36 E.00975
G1 X88.435 Y100.672 E.00681
G1 X88.329 Y100.956 E.0064
G1 X88.098 Y101.376 E.01016
G1 X87.804 Y101.734 E.00979
G1 X87.565 Y101.949 E.00681
G1 X87.318 Y102.124 E.00639
G1 X86.89 Y102.341 E.01016
G1 X86.437 Y102.473 E.00998
G1 X85.979 Y102.521 E.00975
G1 X85.657 Y102.507 E.00683
G1 X85.338 Y102.454 E.00683
G1 X84.9 Y102.312 E.00975
G1 X84.886 Y102.304 E.00034
M204 S250
G1 X85.027 Y101.915 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X84.713 Y101.746 E.00703
G1 X84.403 Y101.499 E.0078
G1 X84.142 Y101.2 E.00781
G1 X83.932 Y100.845 E.00811
G1 X83.839 Y100.615 E.00488
G1 X83.768 Y100.357 E.00526
G1 X83.721 Y99.967 E.00773
G1 X83.744 Y99.571 E.0078
G1 X83.838 Y99.189 E.00773
G1 X83.939 Y98.942 E.00526
G1 X84.069 Y98.708 E.00526
G1 X84.31 Y98.397 E.00773
G1 X84.602 Y98.134 E.00774
M73 P89 R2
G1 X84.825 Y97.987 E.00526
G1 X85.065 Y97.867 E.00526
G1 X85.439 Y97.745 E.00775
G1 X85.848 Y97.692 E.0081
G1 X86.096 Y97.697 E.00488
G1 X86.361 Y97.733 E.00526
G1 X86.735 Y97.842 E.00767
G1 X86.978 Y97.954 E.00526
G1 X87.205 Y98.095 E.00526
G1 X87.506 Y98.349 E.00774
G1 X87.755 Y98.653 E.00773
G1 X87.892 Y98.883 E.00526
G1 X87.994 Y99.109 E.00488
G1 X88.106 Y99.506 E.00811
G1 X88.141 Y99.901 E.00781
G1 X88.106 Y100.292 E.00773
G1 X88.043 Y100.552 E.00526
G1 X87.956 Y100.785 E.00488
G1 X87.758 Y101.146 E.00811
G1 X87.508 Y101.45 E.00775
G1 X87.309 Y101.629 E.00526
G1 X87.106 Y101.772 E.00488
G1 X86.739 Y101.959 E.00811
G1 X86.358 Y102.07 E.00781
G1 X85.967 Y102.111 E.00774
G1 X85.7 Y102.099 E.00526
G1 X85.436 Y102.055 E.00527
G1 X85.082 Y101.94 E.00732
; WIPE_START
M204 S6000
G1 X84.713 Y101.746 E-.07923
G1 X84.403 Y101.499 E-.0753
G1 X84.142 Y101.2 E-.07544
G1 X83.932 Y100.845 E-.0783
G1 X83.839 Y100.615 E-.04716
G1 X83.804 Y100.49 E-.02457
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X84.691 Y96.12 Z5.52 F18000
G1 Z5.12
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X92.494 Y96.12 E.16516
G1 X92.562 Y95.401 E.01529
G1 X92.604 Y95.264 E.00303
G1 X92.653 Y95.175 E.00216
G1 X92.79 Y95.035 E.00415
G1 X92.914 Y94.966 E.00301
G1 X93.016 Y94.934 E.00225
G1 X93.218 Y94.929 E.00428
G1 X93.318 Y94.954 E.00218
G1 X93.412 Y94.996 E.00217
G1 X93.57 Y95.125 E.00433
G1 X93.63 Y95.209 E.00217
G1 X93.698 Y95.39 E.00409
G1 X93.708 Y95.496 E.00227
G1 X93.69 Y95.64 E.00307
G1 X93.644 Y95.765 E.00281
G1 X93.519 Y95.93 E.00438
G1 X93.378 Y96.024 E.0036
G1 X93.182 Y96.105 E.00449
G1 X92.873 Y96.361 E.00849
G1 X92.728 Y96.427 E.00337
G1 X92.582 Y96.466 E.00321
G1 X92.404 Y96.482 E.00378
G1 X87.428 Y96.482 E.10532
G1 X88.608 Y97.838 E.03805
G1 X88.931 Y98.345 E.01273
G1 X89.159 Y98.901 E.01273
G1 X89.286 Y99.489 E.01273
G1 X89.305 Y100.089 E.01269
G1 X89.252 Y100.523 E.00926
G1 X89.102 Y101.07 E.01201
G1 X88.844 Y101.613 E.01273
G1 X88.621 Y101.947 E.0085
G1 X88.353 Y102.258 E.00869
G1 X87.897 Y102.65 E.01274
G1 X87.379 Y102.955 E.01273
G1 X86.992 Y103.109 E.00882
G1 X86.629 Y103.208 E.00795
G1 X86.222 Y103.269 E.0087
G1 X85.63 Y103.267 E.01254
G1 X85.049 Y103.164 E.01249
G1 X84.626 Y103.018 E.00946
G1 X84.131 Y102.762 E.01181
G1 X83.797 Y102.522 E.00869
G1 X83.502 Y102.251 E.00849
G1 X83.24 Y101.947 E.00849
G1 X83.017 Y101.613 E.00849
G1 X82.834 Y101.256 E.0085
G1 X82.696 Y100.879 E.00849
G1 X82.602 Y100.489 E.0085
G1 X82.556 Y100.091 E.00849
G1 X82.574 Y99.499 E.01254
G1 X82.648 Y99.095 E.00869
G1 X82.767 Y98.712 E.00849
G1 X82.93 Y98.345 E.0085
G1 X83.247 Y97.845 E.01253
G1 X84.433 Y96.482 E.03825
G1 X79.467 Y96.482 E.10512
G1 X79.219 Y96.453 E.00527
G1 X79.074 Y96.405 E.00324
G1 X78.858 Y96.269 E.0054
G1 X78.73 Y96.132 E.00396
G1 X78.656 Y96.012 E.00299
G1 X78.577 Y95.801 E.00476
G1 X78.55 Y95.565 E.00504
G1 X78.55 Y77.619 E.37984
G1 X78.591 Y77.34 E.00597
G1 X78.697 Y77.118 E.0052
G1 X78.859 Y76.933 E.0052
G1 X79.084 Y76.793 E.00562
G1 X79.227 Y76.746 E.00319
G1 X79.388 Y76.723 E.00345
G1 X92.461 Y76.722 E.27669
G1 X92.635 Y76.747 E.00372
G1 X92.779 Y76.794 E.0032
G1 X92.955 Y76.889 E.00424
G1 X92.906 Y77.082 E.0042
G1 X79.878 Y77.082 E.27576
G1 X79.594 Y77.131 E.00609
G1 X79.311 Y77.281 E.00679
G1 X79.078 Y77.529 E.0072
G1 X78.948 Y77.807 E.0065
G1 X78.911 Y78.056 E.00533
G1 X78.911 Y95.155 E.36192
G1 X78.964 Y95.453 E.0064
G1 X79.147 Y95.77 E.00775
G1 X79.475 Y96.029 E.00885
G1 X79.858 Y96.12 E.00834
G1 X84.631 Y96.12 E.10102
; WIPE_START
M204 S6000
G1 X86.631 Y96.12 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X83.535 Y96.891 Z5.52 F18000
G1 Z5.12
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X79.443 Y96.891 E.08049
G1 X79.13 Y96.854 E.00619
G1 X78.917 Y96.784 E.00442
G1 X78.788 Y96.719 E.00283
G1 X78.599 Y96.587 E.00454
G1 X78.492 Y96.486 E.00289
G1 X78.398 Y96.373 E.00289
G1 X78.286 Y96.193 E.00417
G1 X78.177 Y95.897 E.0062
G1 X78.141 Y95.589 E.00612
G1 X78.141 Y77.607 E.35368
G1 X78.149 Y77.454 E.00301
G1 X78.196 Y77.228 E.00454
G1 X78.245 Y77.093 E.00283
G1 X78.353 Y76.892 E.00448
G1 X78.495 Y76.714 E.00448
G1 X78.599 Y76.615 E.00283
G1 X78.788 Y76.483 E.00453
G1 X78.929 Y76.413 E.00309
G1 X79.133 Y76.346 E.00423
G1 X79.359 Y76.313 E.00449
G1 X92.489 Y76.313 E.25827
G1 X92.728 Y76.347 E.00475
G1 X92.941 Y76.417 E.00441
G1 X93.139 Y76.524 E.00442
G1 X93.315 Y76.663 E.00442
G1 X93.465 Y76.831 E.00442
G1 X93.583 Y77.022 E.00442
G1 X93.666 Y77.231 E.00442
G1 X93.71 Y77.448 E.00436
G1 X93.72 Y88.791 E.2231
G1 X92.541 Y88.791 E.02321
G1 X92.541 Y77.491 E.22226
G1 X79.913 Y77.491 E.24838
G1 X79.728 Y77.523 E.00368
G1 X79.563 Y77.611 E.00369
G1 X79.42 Y77.761 E.00407
G1 X79.344 Y77.925 E.00356
G1 X79.321 Y78.086 E.00319
G1 X79.321 Y95.119 E.33504
G1 X79.354 Y95.311 E.00382
G1 X79.462 Y95.498 E.00425
G1 X79.657 Y95.652 E.00489
G1 X79.906 Y95.711 E.00503
G1 X92.122 Y95.711 E.24027
G1 X92.158 Y95.321 E.0077
G1 X92.225 Y95.104 E.00447
G1 X92.313 Y94.945 E.00357
G1 X92.423 Y94.809 E.00344
G1 X92.555 Y94.697 E.00341
G1 X92.753 Y94.587 E.00445
G1 X92.931 Y94.532 E.00367
G1 X93.105 Y94.512 E.00344
G1 X93.28 Y94.523 E.00345
G1 X93.451 Y94.565 E.00346
G1 X93.612 Y94.637 E.00345
G1 X93.757 Y94.735 E.00346
G1 X93.882 Y94.858 E.00345
G1 X93.984 Y95.001 E.00345
G1 X94.059 Y95.161 E.00347
G1 X94.102 Y95.316 E.00316
G1 X94.119 Y95.503 E.00369
G1 X94.09 Y95.738 E.00466
G1 X94.013 Y95.946 E.00437
G1 X93.914 Y96.104 E.00367
G1 X93.708 Y96.304 E.00566
G1 X93.561 Y96.391 E.00335
G1 X93.402 Y96.457 E.0034
G1 X93.202 Y96.634 E.00523
G1 X93.072 Y96.719 E.00306
G1 X92.868 Y96.814 E.00443
G1 X92.653 Y96.871 E.00438
G1 X92.421 Y96.891 E.00456
G1 X88.326 Y96.891 E.08055
G1 X88.932 Y97.588 E.01817
G1 X89.187 Y97.962 E.00891
G1 X89.391 Y98.356 E.00873
G1 X89.551 Y98.78 E.00891
G1 X89.659 Y99.22 E.00891
G1 X89.713 Y99.661 E.00873
G1 X89.714 Y100.113 E.0089
G1 X89.655 Y100.596 E.00957
G1 X89.557 Y101.001 E.00819
G1 X89.404 Y101.418 E.00873
G1 X89.198 Y101.821 E.00891
G1 X88.947 Y102.195 E.00885
G1 X88.652 Y102.538 E.00891
G1 X88.495 Y102.691 E.0043
G1 X88.141 Y102.979 E.00898
G1 X87.96 Y103.102 E.0043
G1 X87.561 Y103.322 E.00897
G1 X87.115 Y103.5 E.00943
G1 X86.713 Y103.609 E.0082
G1 X86.265 Y103.676 E.00892
G1 X86.046 Y103.689 E.00431
G1 X85.593 Y103.676 E.00891
G1 X85.145 Y103.608 E.00891
G1 X84.933 Y103.557 E.00429
G1 X84.47 Y103.397 E.00964
G1 X84.095 Y103.216 E.0082
G1 X83.906 Y103.105 E.00431
G1 X83.539 Y102.84 E.00891
G1 X83.207 Y102.536 E.00885
G1 X82.914 Y102.195 E.00885
G1 X82.663 Y101.821 E.00885
G1 X82.459 Y101.42 E.00885
G1 X82.303 Y100.998 E.00885
G1 X82.199 Y100.56 E.00885
G1 X82.147 Y100.114 E.00885
G1 X82.148 Y99.661 E.00891
G1 X82.169 Y99.443 E.0043
G1 X82.25 Y98.997 E.00891
G1 X82.383 Y98.567 E.00885
G1 X82.566 Y98.156 E.00885
G1 X82.799 Y97.767 E.00891
G1 X82.927 Y97.59 E.0043
G1 X83.496 Y96.936 E.01705
; WIPE_START
M204 S6000
G1 X81.496 Y96.914 E-.38
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




G1 X79.309 Y96.244
G1 Z5.12
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.14805
G1 F1500
M204 S6000
G1 X78.947 Y95.958 E.00282
G1 X78.778 Y95.627 E.00227
; WIPE_START
G1 X78.947 Y95.958 E-.16957
G1 X79.309 Y96.244 E-.21043
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X84.478 Y97.165 Z5.52 F18000
G1 Z5.12
G1 E.4 F1800
; LINE_WIDTH: 0.477119
G1 F1500
M204 S6000
G1 X84.297 Y97.319 E.00533
; LINE_WIDTH: 0.438436
G1 X84.09 Y97.496 E.00561
; LINE_WIDTH: 0.400656
G1 X83.916 Y97.673 E.00465
; LINE_WIDTH: 0.359761
G1 X83.552 Y98.08 E.0091
G1 X83.268 Y98.523 E.00876
G1 X83.093 Y98.934 E.00746
G1 X82.968 Y99.439 E.00867
G1 X82.934 Y100.005 E.00945
G1 X82.979 Y100.423 E.00699
G1 X83.061 Y100.769 E.00593
G1 X83.184 Y101.103 E.00593
G1 X83.349 Y101.418 E.00593
G1 X83.544 Y101.716 E.00593
G1 X83.869 Y102.078 E.00812
G1 X84.291 Y102.412 E.00896
G1 X84.765 Y102.665 E.00896
G1 X85.237 Y102.817 E.00826
G1 X85.627 Y102.884 E.00659
G1 X85.978 Y102.9 E.00585
G1 X86.525 Y102.841 E.00916
G1 X86.873 Y102.745 E.00603
G1 X87.209 Y102.61 E.00602
G1 X87.672 Y102.341 E.00892
G1 X88.08 Y101.994 E.00893
G1 X88.316 Y101.714 E.00609
G1 X88.512 Y101.42 E.00589
G1 X88.743 Y100.938 E.00893
G1 X88.878 Y100.453 E.00839
G1 X88.922 Y100.066 E.00649
G1 X88.92 Y99.701 E.00608
G1 X88.885 Y99.371 E.00552
G1 X88.792 Y99.017 E.0061
G1 X88.594 Y98.52 E.00893
G1 X88.302 Y98.07 E.00893
G1 X88.058 Y97.784 E.00627
; LINE_WIDTH: 0.378831
G1 X87.881 Y97.609 E.00438
; LINE_WIDTH: 0.419338
G1 X87.678 Y97.411 E.00557
; LINE_WIDTH: 0.468141
G1 X87.38 Y97.162 E.00857
; WIPE_START
G1 X87.678 Y97.411 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X92.706 Y96.136 Z5.52 F18000
G1 Z5.12
G1 E.4 F1800
; LINE_WIDTH: 0.127558
G1 F1500
M204 S6000
G1 X92.873 Y96.045 E.00096
; LINE_WIDTH: 0.0931489
G1 X92.953 Y95.995 E.00032
; WIPE_START
G1 X92.873 Y96.045 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X88.24 Y89.979 Z5.52 F18000
G1 X78.785 Y77.602 Z5.52
G1 Z5.12
G1 E.4 F1800
; LINE_WIDTH: 0.0995831
G1 F1500
M204 S6000
G1 X78.856 Y77.387 E.00083
; LINE_WIDTH: 0.149612
G1 X79.042 Y77.152 E.00185
G1 X79.138 Y77.07 E.00078
G1 X79.288 Y77 E.00103
; LINE_WIDTH: 0.100069
G1 X79.426 Y76.954 E.00054
; CHANGE_LAYER
; Z_HEIGHT: 5.24
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F1500
G1 X79.288 Y77 E-.38
; WIPE_END
G1 E-.02 F1800
; layer num/total_layer_count: 43/49
; update layer progress
M73 L43
M991 S0 P42 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z5.52 I-.301 J1.179 P1  F18000
G1 X93.304 Y80.581 Z5.52
G1 Z5.24
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X93.311 Y88.382 E.1651
G1 X92.95 Y88.382 E.00764
G1 X92.95 Y77.128 E.23818
G1 X93.135 Y77.076 E.00407
G1 X93.216 Y77.207 E.00325
G1 X93.272 Y77.349 E.00324
G1 X93.301 Y77.49 E.00306
G1 X93.304 Y80.521 E.06415
; WIPE_START
M204 S6000
G1 X93.306 Y82.521 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X93.293 Y90.154 Z5.64 F18000
G1 X93.284 Y95.469 Z5.64
G1 Z5.24
G1 E.4 F1800
G1 F1500
M204 S500
G1 X93.25 Y95.607 E.003
G1 X92.956 Y95.739 E.00681
G1 X92.98 Y95.485 E.00541
G1 X93.006 Y95.4 E.00188
G1 X93.101 Y95.347 E.00231
G1 X93.154 Y95.35 E.0011
G1 X93.227 Y95.383 E.0017
G1 X93.251 Y95.419 E.00092
; WIPE_START
M204 S6000
G1 X93.25 Y95.607 E-.06265
G1 X92.956 Y95.739 E-.10739
G1 X92.98 Y95.485 E-.08528
G1 X93.006 Y95.4 E-.02958
G1 X93.101 Y95.347 E-.03639
G1 X93.154 Y95.35 E-.0174
G1 X93.227 Y95.383 E-.02684
G1 X93.251 Y95.419 E-.01447
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X85.763 Y96.899 Z5.64 F18000
G1 X84.696 Y97.11 Z5.64
M73 P90 R2
G1 Z5.24
G1 E.4 F1800
G1 F1500
M204 S500
G1 X84.589 Y96.949 E.0041
G1 X84.941 Y96.544 E.01135
G1 X86.92 Y96.544 E.04188
G1 X87.274 Y96.951 E.01141
G1 X87.15 Y97.116 E.00436
G1 X87.029 Y97.059 E.00282
G1 X86.535 Y96.915 E.0109
G1 X86.159 Y96.864 E.00802
G1 X85.798 Y96.858 E.00764
G1 X85.255 Y96.929 E.0116
G1 X84.753 Y97.092 E.01116
; WIPE_START
M204 S6000
G1 X84.589 Y96.949 E-.04131
G1 X84.941 Y96.544 E-.10189
G1 X86.188 Y96.544 E-.2368
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X84.833 Y102.275 Z5.64 F18000
G1 Z5.24
G1 E.4 F1800
G1 F1500
M204 S500
G1 X84.486 Y102.089 E.00833
G1 X84.119 Y101.796 E.00995
G1 X83.81 Y101.442 E.00995
G1 X83.569 Y101.039 E.00995
G1 X83.407 Y100.607 E.00975
G1 X83.34 Y100.291 E.00683
G1 X83.311 Y99.97 E.00683
G1 X83.338 Y99.51 E.00975
G1 X83.447 Y99.063 E.00975
G1 X83.57 Y98.764 E.00684
G1 X83.727 Y98.482 E.00683
G1 X84.009 Y98.118 E.00975
G1 X84.351 Y97.809 E.00975
G1 X84.62 Y97.632 E.00683
G1 X84.909 Y97.487 E.00683
G1 X85.349 Y97.344 E.00979
G1 X85.822 Y97.283 E.01011
G1 X86.127 Y97.288 E.00645
G1 X86.446 Y97.331 E.00682
G1 X86.879 Y97.458 E.00955
G1 X87.172 Y97.593 E.00683
G1 X87.447 Y97.763 E.00683
G1 X87.799 Y98.062 E.00979
G1 X88.101 Y98.433 E.01011
G1 X88.257 Y98.694 E.00645
G1 X88.388 Y98.989 E.00681
G1 X88.51 Y99.433 E.00975
G1 X88.552 Y99.901 E.00995
G1 X88.511 Y100.36 E.00975
G1 X88.435 Y100.672 E.00681
G1 X88.328 Y100.958 E.00646
G1 X88.098 Y101.377 E.01011
G1 X87.798 Y101.741 E.00998
G1 X87.44 Y102.045 E.00995
G1 X87.041 Y102.275 E.00975
G1 X86.74 Y102.393 E.00683
G1 X86.428 Y102.474 E.00683
G1 X85.979 Y102.521 E.00956
G1 X85.657 Y102.507 E.00683
G1 X85.338 Y102.454 E.00683
G1 X84.9 Y102.312 E.00975
G1 X84.886 Y102.304 E.00035
M204 S250
G1 X85.027 Y101.915 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X84.713 Y101.746 E.00702
G1 X84.403 Y101.499 E.00779
G1 X84.142 Y101.2 E.0078
G1 X83.939 Y100.86 E.00779
G1 X83.801 Y100.492 E.00774
G1 X83.745 Y100.23 E.00526
G1 X83.721 Y99.964 E.00526
G1 X83.744 Y99.571 E.00774
G1 X83.838 Y99.189 E.00773
G1 X83.939 Y98.942 E.00527
G1 X84.069 Y98.708 E.00526
G1 X84.31 Y98.397 E.00774
G1 X84.602 Y98.134 E.00774
G1 X84.825 Y97.987 E.00526
G1 X85.065 Y97.867 E.00526
G1 X85.439 Y97.745 E.00775
G1 X85.845 Y97.692 E.00806
G1 X86.096 Y97.697 E.00493
G1 X86.361 Y97.733 E.00526
G1 X86.735 Y97.842 E.00767
G1 X86.978 Y97.954 E.00526
G1 X87.205 Y98.095 E.00526
G1 X87.506 Y98.35 E.00775
G1 X87.764 Y98.667 E.00806
G1 X87.893 Y98.883 E.00493
G1 X88.001 Y99.127 E.00526
G1 X88.106 Y99.506 E.00774
G1 X88.141 Y99.901 E.00779
G1 X88.106 Y100.292 E.00773
G1 X88.043 Y100.552 E.00525
G1 X87.955 Y100.787 E.00493
G1 X87.758 Y101.146 E.00806
G1 X87.506 Y101.452 E.00781
G1 X87.203 Y101.709 E.0078
G1 X86.863 Y101.905 E.00773
G1 X86.614 Y102.003 E.00527
G1 X86.355 Y102.07 E.00526
G1 X85.967 Y102.111 E.00767
G1 X85.699 Y102.099 E.00526
G1 X85.436 Y102.055 E.00526
G1 X85.081 Y101.94 E.00733
; WIPE_START
M204 S6000
G1 X84.713 Y101.746 E-.07911
G1 X84.403 Y101.499 E-.07529
G1 X84.142 Y101.2 E-.07532
G1 X83.939 Y100.86 E-.07528
G1 X83.801 Y100.492 E-.07473
G1 X83.8 Y100.491 E-.00026
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X84.691 Y96.12 Z5.64 F18000
G1 Z5.24
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X92.495 Y96.12 E.16517
G1 X92.562 Y95.402 E.01527
G1 X92.604 Y95.264 E.00306
G1 X92.653 Y95.175 E.00214
G1 X92.789 Y95.035 E.00414
G1 X92.915 Y94.965 E.00305
G1 X93.015 Y94.934 E.00221
G1 X93.218 Y94.929 E.00429
G1 X93.318 Y94.954 E.00218
G1 X93.412 Y94.995 E.00217
G1 X93.57 Y95.125 E.00433
G1 X93.63 Y95.209 E.00217
G1 X93.698 Y95.391 E.00413
G1 X93.708 Y95.496 E.00222
G1 X93.69 Y95.64 E.00308
G1 X93.643 Y95.766 E.00285
G1 X93.519 Y95.93 E.00436
G1 X93.377 Y96.025 E.0036
G1 X93.182 Y96.105 E.00445
G1 X92.873 Y96.361 E.0085
G1 X92.729 Y96.427 E.00336
G1 X92.582 Y96.466 E.00322
G1 X92.404 Y96.482 E.00379
G1 X87.428 Y96.482 E.10532
G1 X88.614 Y97.845 E.03824
G1 X88.721 Y97.992 E.00386
G1 X88.934 Y98.351 E.00884
G1 X89.159 Y98.901 E.01257
G1 X89.286 Y99.49 E.01275
G1 X89.305 Y100.091 E.01273
G1 X89.221 Y100.675 E.0125
G1 X89.09 Y101.098 E.00936
G1 X88.845 Y101.614 E.0121
G1 X88.495 Y102.103 E.01273
G1 X88.216 Y102.391 E.00849
G1 X87.897 Y102.65 E.00868
G1 X87.574 Y102.855 E.00811
G1 X87.197 Y103.035 E.00883
G1 X86.996 Y103.108 E.00453
G1 X86.629 Y103.208 E.00805
G1 X86.222 Y103.269 E.0087
G1 X85.63 Y103.267 E.01254
G1 X85.047 Y103.164 E.01254
G1 X84.658 Y103.032 E.00869
G1 X84.296 Y102.859 E.00849
G1 X83.957 Y102.644 E.00849
G1 X83.646 Y102.391 E.00849
G1 X83.367 Y102.103 E.00849
G1 X83.124 Y101.783 E.0085
G1 X82.92 Y101.437 E.00849
G1 X82.756 Y101.061 E.00869
G1 X82.603 Y100.491 E.0125
G1 X82.555 Y100.061 E.00916
G1 X82.574 Y99.499 E.0119
G1 X82.648 Y99.095 E.00869
G1 X82.767 Y98.712 E.00849
G1 X82.93 Y98.345 E.0085
G1 X83.248 Y97.845 E.01254
G1 X84.433 Y96.482 E.03824
G1 X79.467 Y96.482 E.10513
G1 X79.138 Y96.43 E.00705
G1 X79.008 Y96.37 E.00302
G1 X78.821 Y96.232 E.00492
G1 X78.669 Y96.041 E.00517
G1 X78.579 Y95.812 E.0052
G1 X78.55 Y95.565 E.00527
G1 X78.55 Y77.628 E.37965
G1 X78.587 Y77.35 E.00593
G1 X78.696 Y77.119 E.00541
G1 X78.859 Y76.933 E.00522
G1 X79.083 Y76.794 E.00559
G1 X79.227 Y76.746 E.00322
G1 X79.388 Y76.723 E.00345
G1 X92.462 Y76.722 E.27672
G1 X92.635 Y76.747 E.00369
G1 X92.778 Y76.794 E.0032
G1 X92.955 Y76.889 E.00424
G1 X92.906 Y77.082 E.0042
G1 X79.876 Y77.082 E.27579
G1 X79.588 Y77.133 E.0062
G1 X79.311 Y77.282 E.00666
G1 X79.081 Y77.524 E.00708
G1 X78.948 Y77.805 E.00657
G1 X78.911 Y78.056 E.00536
G1 X78.911 Y95.155 E.36192
G1 X78.964 Y95.453 E.0064
G1 X79.152 Y95.778 E.00796
G1 X79.513 Y96.047 E.00952
G1 X79.867 Y96.12 E.00767
G1 X84.631 Y96.12 E.10083
; WIPE_START
M204 S6000
G1 X86.631 Y96.12 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X83.535 Y96.891 Z5.64 F18000
G1 Z5.24
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X79.443 Y96.891 E.08049
G1 X79.127 Y96.854 E.00625
G1 X78.992 Y96.814 E.00277
G1 X78.799 Y96.724 E.0042
G1 X78.543 Y96.536 E.00623
G1 X78.394 Y96.368 E.00441
G1 X78.314 Y96.246 E.00289
G1 X78.248 Y96.114 E.00289
G1 X78.177 Y95.901 E.00442
G1 X78.141 Y95.589 E.00619
G1 X78.141 Y77.61 E.35362
G1 X78.161 Y77.374 E.00466
G1 X78.195 Y77.232 E.00288
G1 X78.25 Y77.083 E.00312
G1 X78.353 Y76.893 E.00426
G1 X78.495 Y76.714 E.00448
G1 X78.599 Y76.615 E.00283
G1 X78.788 Y76.483 E.00453
G1 X78.927 Y76.414 E.00305
G1 X79.133 Y76.346 E.00426
G1 X79.359 Y76.313 E.00449
G1 X92.491 Y76.313 E.2583
G1 X92.728 Y76.347 E.00472
G1 X92.941 Y76.417 E.00441
G1 X93.139 Y76.524 E.00442
G1 X93.315 Y76.663 E.00442
G1 X93.465 Y76.831 E.00442
G1 X93.583 Y77.022 E.00442
G1 X93.666 Y77.231 E.00442
G1 X93.71 Y77.448 E.00436
G1 X93.72 Y88.791 E.2231
G1 X92.541 Y88.791 E.02321
G1 X92.541 Y77.491 E.22226
G1 X79.912 Y77.491 E.24839
G1 X79.724 Y77.524 E.00376
G1 X79.563 Y77.611 E.0036
G1 X79.423 Y77.758 E.004
G1 X79.344 Y77.925 E.00362
G1 X79.321 Y78.086 E.0032
G1 X79.321 Y95.119 E.33504
G1 X79.354 Y95.311 E.00382
G1 X79.464 Y95.501 E.00431
G1 X79.684 Y95.664 E.0054
G1 X79.909 Y95.711 E.00452
G1 X92.122 Y95.711 E.24021
G1 X92.158 Y95.322 E.00768
G1 X92.225 Y95.103 E.0045
G1 X92.312 Y94.945 E.00355
G1 X92.423 Y94.81 E.00345
G1 X92.555 Y94.697 E.0034
G1 X92.754 Y94.587 E.00449
G1 X92.931 Y94.532 E.00363
G1 X93.105 Y94.512 E.00344
G1 X93.28 Y94.523 E.00345
G1 X93.451 Y94.565 E.00346
G1 X93.611 Y94.636 E.00345
G1 X93.757 Y94.735 E.00346
G1 X93.882 Y94.858 E.00345
G1 X93.984 Y95.001 E.00346
G1 X94.059 Y95.16 E.00347
G1 X94.102 Y95.318 E.00321
G1 X94.119 Y95.502 E.00364
G1 X94.09 Y95.737 E.00466
G1 X94.013 Y95.948 E.00442
G1 X93.915 Y96.104 E.00362
G1 X93.708 Y96.304 E.00566
G1 X93.56 Y96.392 E.00338
G1 X93.402 Y96.457 E.00337
G1 X93.201 Y96.634 E.00527
G1 X93.072 Y96.719 E.00303
G1 X92.868 Y96.814 E.00443
G1 X92.653 Y96.871 E.00438
G1 X92.421 Y96.891 E.00456
G1 X88.326 Y96.891 E.08055
G1 X88.934 Y97.59 E.01823
G1 X89.063 Y97.767 E.0043
G1 X89.296 Y98.158 E.00896
G1 X89.403 Y98.385 E.00494
G1 X89.551 Y98.78 E.00829
G1 X89.659 Y99.22 E.00892
G1 X89.713 Y99.661 E.00873
G1 X89.714 Y100.114 E.00891
G1 X89.662 Y100.564 E.00891
G1 X89.618 Y100.777 E.0043
G1 X89.475 Y101.241 E.00954
G1 X89.305 Y101.626 E.00829
G1 X89.08 Y102.009 E.00873
G1 X88.806 Y102.37 E.00891
G1 X88.493 Y102.693 E.00885
G1 X88.141 Y102.979 E.00891
G1 X87.957 Y103.103 E.00437
G1 X87.766 Y103.216 E.00437
G1 X87.355 Y103.413 E.00895
G1 X87.12 Y103.499 E.00494
G1 X86.713 Y103.609 E.00829
G1 X86.265 Y103.676 E.00891
G1 X86.046 Y103.689 E.00431
G1 X85.593 Y103.676 E.00891
G1 X85.145 Y103.608 E.00891
G1 X84.933 Y103.557 E.00431
G1 X84.504 Y103.412 E.00891
G1 X84.098 Y103.218 E.00885
G1 X83.717 Y102.977 E.00885
G1 X83.368 Y102.693 E.00885
G1 X83.056 Y102.37 E.00885
G1 X82.783 Y102.012 E.00885
G1 X82.555 Y101.624 E.00885
G1 X82.374 Y101.209 E.00891
G1 X82.304 Y101.001 E.00431
G1 X82.199 Y100.561 E.0089
G1 X82.146 Y100.082 E.00948
G1 X82.148 Y99.661 E.00828
G1 X82.169 Y99.443 E.00431
G1 X82.25 Y98.997 E.00891
G1 X82.383 Y98.567 E.00885
G1 X82.566 Y98.156 E.00885
G1 X82.799 Y97.767 E.00891
G1 X82.927 Y97.59 E.0043
G1 X83.496 Y96.936 E.01705
; WIPE_START
M204 S6000
G1 X81.496 Y96.914 E-.38
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




G1 X79.368 Y96.256
G1 Z5.24
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.149345
G1 F1500
M204 S6000
G1 X79.151 Y96.128 E.00155
G1 X78.954 Y95.971 E.00156
G1 X78.879 Y95.851 E.00087
G1 X78.778 Y95.627 E.00152
; WIPE_START
G1 X78.879 Y95.851 E-.10487
G1 X78.954 Y95.971 E-.06027
G1 X79.151 Y96.128 E-.10749
G1 X79.368 Y96.256 E-.10737
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X84.478 Y97.165 Z5.64 F18000
G1 Z5.24
G1 E.4 F1800
; LINE_WIDTH: 0.477126
G1 F1500
M204 S6000
G1 X84.297 Y97.319 E.00533
; LINE_WIDTH: 0.438444
G1 X84.091 Y97.496 E.00561
; LINE_WIDTH: 0.400676
G1 X83.916 Y97.673 E.00465
; LINE_WIDTH: 0.359949
G1 X83.552 Y98.08 E.0091
G1 X83.268 Y98.523 E.00877
G1 X83.124 Y98.846 E.0059
G1 X83.022 Y99.186 E.00593
G1 X82.954 Y99.546 E.0061
G1 X82.934 Y99.988 E.00738
G1 X82.979 Y100.425 E.00733
G1 X83.063 Y100.778 E.00605
G1 X83.236 Y101.215 E.00783
G1 X83.441 Y101.57 E.00684
G1 X83.658 Y101.852 E.00594
M73 P91 R2
G1 X83.903 Y102.11 E.00593
G1 X84.291 Y102.411 E.00819
G1 X84.765 Y102.665 E.00896
G1 X85.237 Y102.816 E.00827
G1 X85.664 Y102.888 E.00721
G1 X86.188 Y102.885 E.00874
G1 X86.551 Y102.835 E.00611
G1 X87.049 Y102.682 E.00869
G1 X87.39 Y102.517 E.00632
G1 X87.673 Y102.344 E.00553
G1 X88.076 Y101.994 E.0089
G1 X88.42 Y101.576 E.00902
G1 X88.666 Y101.126 E.00855
G1 X88.797 Y100.774 E.00628
G1 X88.882 Y100.409 E.00624
G1 X88.926 Y99.915 E.00826
G1 X88.881 Y99.38 E.00895
G1 X88.792 Y99.014 E.00629
G1 X88.598 Y98.528 E.00873
G1 X88.309 Y98.08 E.00888
G1 X88.06 Y97.786 E.00643
; LINE_WIDTH: 0.3786
G1 X87.882 Y97.61 E.0044
; LINE_WIDTH: 0.419274
G1 X87.678 Y97.411 E.00559
; LINE_WIDTH: 0.468136
G1 X87.38 Y97.163 E.00857
; WIPE_START
G1 X87.678 Y97.411 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X92.706 Y96.136 Z5.64 F18000
G1 Z5.24
G1 E.4 F1800
; LINE_WIDTH: 0.128176
G1 F1500
M204 S6000
G1 X92.872 Y96.045 E.00097
; LINE_WIDTH: 0.0933757
G1 X92.953 Y95.994 E.00032
; WIPE_START
G1 X92.872 Y96.045 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X88.241 Y89.978 Z5.64 F18000
G1 X78.788 Y77.595 Z5.64
G1 Z5.24
G1 E.4 F1800
; LINE_WIDTH: 0.107006
G1 F1500
M204 S6000
G1 X78.858 Y77.381 E.00091
; LINE_WIDTH: 0.157495
G1 X78.93 Y77.275 E.00085
G1 X79.134 Y77.072 E.00189
; LINE_WIDTH: 0.131311
G1 X79.288 Y77 E.0009
; LINE_WIDTH: 0.100018
G1 X79.424 Y76.954 E.00053
; CHANGE_LAYER
; Z_HEIGHT: 5.36
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F1500
G1 X79.288 Y77 E-.38
; WIPE_END
G1 E-.02 F1800
; layer num/total_layer_count: 44/49
; update layer progress
M73 L44
M991 S0 P43 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z5.64 I-.301 J1.179 P1  F18000
G1 X93.304 Y80.581 Z5.64
G1 Z5.36
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X93.311 Y88.382 E.1651
G1 X92.95 Y88.382 E.00764
G1 X92.95 Y77.128 E.23818
G1 X93.135 Y77.076 E.00407
G1 X93.216 Y77.207 E.00325
G1 X93.272 Y77.349 E.00324
G1 X93.301 Y77.49 E.00305
G1 X93.304 Y80.521 E.06416
; WIPE_START
M204 S6000
G1 X93.306 Y82.521 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X93.293 Y90.154 Z5.76 F18000
G1 X93.284 Y95.469 Z5.76
G1 Z5.36
G1 E.4 F1800
G1 F1500
M204 S500
G1 X93.25 Y95.607 E.003
G1 X92.956 Y95.739 E.00681
G1 X92.98 Y95.485 E.00539
G1 X93.006 Y95.4 E.00189
G1 X93.102 Y95.347 E.00231
G1 X93.153 Y95.35 E.0011
G1 X93.227 Y95.383 E.0017
G1 X93.251 Y95.419 E.00092
; WIPE_START
M204 S6000
G1 X93.25 Y95.607 E-.06269
G1 X92.956 Y95.739 E-.1074
G1 X92.98 Y95.485 E-.08502
G1 X93.006 Y95.4 E-.02983
G1 X93.102 Y95.347 E-.03641
G1 X93.153 Y95.35 E-.01734
G1 X93.227 Y95.383 E-.02679
G1 X93.251 Y95.419 E-.01453
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X85.763 Y96.899 Z5.76 F18000
G1 X84.696 Y97.11 Z5.76
G1 Z5.36
G1 E.4 F1800
G1 F1500
M204 S500
G1 X84.589 Y96.949 E.0041
G1 X84.941 Y96.544 E.01135
G1 X86.92 Y96.544 E.04188
G1 X87.273 Y96.951 E.0114
G1 X87.15 Y97.115 E.00436
G1 X87.029 Y97.059 E.00282
G1 X86.535 Y96.915 E.0109
G1 X86.159 Y96.864 E.00802
G1 X85.795 Y96.858 E.0077
G1 X85.254 Y96.929 E.01155
G1 X84.753 Y97.092 E.01116
; WIPE_START
M204 S6000
G1 X84.589 Y96.949 E-.04131
G1 X84.941 Y96.544 E-.10189
G1 X86.188 Y96.544 E-.2368
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X84.862 Y102.289 Z5.76 F18000
G1 Z5.36
G1 E.4 F1800
G1 F1500
M204 S500
G1 X84.759 Y102.245 E.00236
G1 X84.492 Y102.091 E.00651
G1 X84.12 Y101.797 E.01006
G1 X83.81 Y101.442 E.00998
G1 X83.573 Y101.047 E.00975
G1 X83.451 Y100.748 E.00683
G1 X83.365 Y100.437 E.00683
G1 X83.31 Y99.979 E.00975
G1 X83.338 Y99.51 E.00995
G1 X83.447 Y99.063 E.00975
G1 X83.57 Y98.764 E.00683
G1 X83.727 Y98.482 E.00683
G1 X84.009 Y98.118 E.00975
G1 X84.351 Y97.809 E.00975
G1 X84.62 Y97.632 E.00683
G1 X84.909 Y97.487 E.00683
G1 X85.348 Y97.344 E.00978
G1 X85.82 Y97.283 E.01006
G1 X86.127 Y97.288 E.00651
G1 X86.446 Y97.331 E.00682
G1 X86.879 Y97.458 E.00955
G1 X87.172 Y97.593 E.00683
G1 X87.447 Y97.763 E.00683
G1 X87.798 Y98.061 E.00976
G1 X88.097 Y98.424 E.00995
G1 X88.326 Y98.835 E.00995
G1 X88.475 Y99.27 E.00975
G1 X88.532 Y99.588 E.00683
G1 X88.551 Y99.91 E.00683
G1 X88.511 Y100.36 E.00955
G1 X88.435 Y100.673 E.00682
G1 X88.327 Y100.961 E.00651
G1 X88.098 Y101.377 E.01006
G1 X87.798 Y101.741 E.00998
G1 X87.44 Y102.045 E.00995
G1 X87.033 Y102.28 E.00995
G1 X86.599 Y102.435 E.00975
G1 X86.282 Y102.498 E.00683
G1 X85.96 Y102.522 E.00683
G1 X85.501 Y102.487 E.00975
G1 X85.055 Y102.371 E.00975
G1 X84.917 Y102.312 E.00319
M204 S250
G1 X85.022 Y101.912 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X84.942 Y101.878 E.00172
G1 X84.723 Y101.752 E.00498
G1 X84.403 Y101.499 E.00801
G1 X84.142 Y101.2 E.00781
G1 X83.94 Y100.863 E.00773
G1 X83.839 Y100.615 E.00526
G1 X83.768 Y100.357 E.00526
G1 X83.721 Y99.967 E.00773
G1 X83.744 Y99.571 E.0078
G1 X83.838 Y99.189 E.00773
G1 X83.939 Y98.942 E.00526
G1 X84.069 Y98.708 E.00526
G1 X84.31 Y98.397 E.00773
G1 X84.602 Y98.134 E.00773
G1 X84.825 Y97.987 E.00526
G1 X85.065 Y97.867 E.00526
G1 X85.439 Y97.745 E.00774
G1 X85.843 Y97.692 E.00801
G1 X86.096 Y97.697 E.00498
G1 X86.361 Y97.733 E.00526
G1 X86.735 Y97.842 E.00767
G1 X86.978 Y97.954 E.00526
G1 X87.205 Y98.095 E.00526
G1 X87.506 Y98.349 E.00774
G1 X87.757 Y98.655 E.00779
G1 X87.95 Y99.002 E.0078
G1 X88.077 Y99.374 E.00773
G1 X88.125 Y99.637 E.00526
G1 X88.141 Y99.904 E.00526
G1 X88.106 Y100.292 E.00767
G1 X88.043 Y100.552 E.00526
G1 X87.954 Y100.789 E.00498
G1 X87.758 Y101.146 E.00801
G1 X87.506 Y101.452 E.00781
G1 X87.203 Y101.709 E.0078
G1 X86.86 Y101.907 E.00779
G1 X86.49 Y102.04 E.00773
G1 X86.227 Y102.091 E.00526
G1 X85.96 Y102.111 E.00526
G1 X85.568 Y102.082 E.00773
G1 X85.188 Y101.983 E.00773
G1 X85.078 Y101.936 E.00236
; WIPE_START
M204 S6000
G1 X84.942 Y101.878 E-.02802
G1 X84.723 Y101.752 E-.04809
G1 X84.403 Y101.499 E-.07736
G1 X84.142 Y101.2 E-.07541
G1 X83.94 Y100.863 E-.0747
G1 X83.839 Y100.615 E-.05083
G1 X83.803 Y100.486 E-.02558
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X84.691 Y96.12 Z5.76 F18000
G1 Z5.36
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X92.495 Y96.12 E.16517
G1 X92.562 Y95.403 E.01525
G1 X92.604 Y95.263 E.00309
G1 X92.652 Y95.176 E.00211
G1 X92.789 Y95.035 E.00415
G1 X92.916 Y94.965 E.00307
G1 X93.015 Y94.934 E.00219
G1 X93.218 Y94.929 E.0043
G1 X93.318 Y94.954 E.00218
G1 X93.496 Y95.053 E.00432
G1 X93.57 Y95.125 E.00218
G1 X93.629 Y95.208 E.00217
G1 X93.698 Y95.392 E.00415
G1 X93.708 Y95.495 E.0022
G1 X93.69 Y95.639 E.00308
G1 X93.643 Y95.767 E.00287
G1 X93.518 Y95.931 E.00437
G1 X93.376 Y96.025 E.00361
G1 X93.175 Y96.108 E.0046
G1 X92.999 Y96.272 E.0051
G1 X92.866 Y96.364 E.0034
G1 X92.729 Y96.427 E.00321
G1 X92.582 Y96.466 E.00322
G1 X92.404 Y96.482 E.00378
G1 X87.428 Y96.482 E.10532
G1 X88.614 Y97.845 E.03824
G1 X88.721 Y97.993 E.00386
G1 X88.934 Y98.351 E.00884
G1 X89.159 Y98.901 E.01257
G1 X89.286 Y99.487 E.0127
G1 X89.305 Y100.088 E.01273
G1 X89.253 Y100.514 E.00908
G1 X89.103 Y101.068 E.01215
G1 X88.845 Y101.613 E.01276
G1 X88.621 Y101.947 E.0085
G1 X88.353 Y102.258 E.00869
G1 X88.051 Y102.532 E.00863
G1 X87.733 Y102.761 E.0083
G1 X87.551 Y102.866 E.00445
G1 X87.204 Y103.032 E.00815
G1 X86.814 Y103.164 E.0087
G1 X86.222 Y103.269 E.01273
G1 X85.63 Y103.267 E.01254
G1 X85.047 Y103.164 E.01254
G1 X84.658 Y103.032 E.00869
G1 X84.297 Y102.86 E.00846
G1 X83.936 Y102.629 E.00906
G1 X83.508 Y102.258 E.012
G1 X83.24 Y101.947 E.00869
G1 X83.017 Y101.613 E.0085
G1 X82.834 Y101.256 E.00849
G1 X82.696 Y100.879 E.00849
G1 X82.602 Y100.489 E.0085
G1 X82.556 Y100.091 E.00849
G1 X82.574 Y99.499 E.01253
G1 X82.648 Y99.095 E.00869
G1 X82.767 Y98.712 E.00849
G1 X82.933 Y98.338 E.00865
G1 X83.253 Y97.838 E.01256
G1 X84.434 Y96.482 E.03806
G1 X79.467 Y96.482 E.10513
G1 X79.228 Y96.454 E.00508
G1 X79.028 Y96.381 E.00452
G1 X78.905 Y96.305 E.00306
G1 X78.763 Y96.173 E.00411
G1 X78.669 Y96.04 E.00345
G1 X78.58 Y95.82 E.00503
G1 X78.55 Y95.565 E.00543
G1 X78.55 Y77.628 E.37965
G1 X78.587 Y77.35 E.00594
G1 X78.696 Y77.119 E.00541
G1 X78.859 Y76.933 E.00522
G1 X79.081 Y76.794 E.00556
G1 X79.227 Y76.746 E.00325
G1 X79.388 Y76.723 E.00345
G1 X92.464 Y76.722 E.27675
G1 X92.634 Y76.747 E.00365
G1 X92.779 Y76.794 E.00322
G1 X92.955 Y76.889 E.00424
G1 X92.906 Y77.082 E.0042
G1 X79.877 Y77.082 E.27577
G1 X79.592 Y77.131 E.00612
G1 X79.319 Y77.277 E.00656
G1 X79.101 Y77.495 E.00651
G1 X78.949 Y77.798 E.00718
G1 X78.911 Y78.056 E.00552
G1 X78.911 Y95.155 E.36193
G1 X78.964 Y95.453 E.0064
G1 X79.152 Y95.779 E.00796
G1 X79.513 Y96.047 E.0095
G1 X79.867 Y96.12 E.00767
G1 X84.631 Y96.12 E.10083
; WIPE_START
M204 S6000
G1 X86.631 Y96.12 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X83.535 Y96.891 Z5.76 F18000
G1 Z5.36
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X79.443 Y96.891 E.08049
G1 X79.133 Y96.855 E.00613
G1 X78.849 Y96.751 E.00595
G1 X78.666 Y96.639 E.00423
G1 X78.545 Y96.539 E.00308
G1 X78.445 Y96.432 E.00288
G1 X78.314 Y96.245 E.00448
G1 X78.221 Y96.048 E.00429
G1 X78.177 Y95.904 E.00296
G1 X78.141 Y95.589 E.00624
G1 X78.141 Y77.61 E.35362
G1 X78.161 Y77.374 E.00466
G1 X78.195 Y77.232 E.00288
G1 X78.249 Y77.084 E.00309
G1 X78.353 Y76.893 E.00429
G1 X78.495 Y76.714 E.00449
G1 X78.599 Y76.615 E.00283
G1 X78.788 Y76.483 E.00453
G1 X78.926 Y76.415 E.00303
G1 X79.133 Y76.346 E.00429
G1 X79.359 Y76.313 E.00448
G1 X92.493 Y76.313 E.25834
G1 X92.728 Y76.347 E.00468
G1 X92.941 Y76.417 E.00441
G1 X93.139 Y76.524 E.00442
G1 X93.315 Y76.663 E.00442
G1 X93.465 Y76.831 E.00442
G1 X93.583 Y77.022 E.00442
G1 X93.666 Y77.231 E.00442
G1 X93.71 Y77.448 E.00436
G1 X93.72 Y88.791 E.2231
G1 X92.541 Y88.791 E.02321
G1 X92.541 Y77.491 E.22226
G1 X79.913 Y77.491 E.24838
G1 X79.727 Y77.523 E.0037
G1 X79.565 Y77.609 E.00361
G1 X79.437 Y77.737 E.00356
G1 X79.344 Y77.922 E.00407
G1 X79.321 Y78.086 E.00325
G1 X79.321 Y95.119 E.33504
G1 X79.354 Y95.311 E.00382
G1 X79.464 Y95.501 E.00432
G1 X79.684 Y95.664 E.00539
G1 X79.909 Y95.711 E.00452
G1 X92.122 Y95.711 E.24022
G1 X92.158 Y95.323 E.00766
G1 X92.225 Y95.103 E.00453
G1 X92.312 Y94.946 E.00353
G1 X92.423 Y94.81 E.00345
G1 X92.554 Y94.697 E.0034
G1 X92.755 Y94.586 E.00451
G1 X92.93 Y94.532 E.00361
G1 X93.104 Y94.512 E.00345
G1 X93.28 Y94.523 E.00345
G1 X93.45 Y94.565 E.00346
G1 X93.611 Y94.636 E.00345
G1 X93.756 Y94.735 E.00346
G1 X93.882 Y94.858 E.00346
G1 X93.984 Y95 E.00345
G1 X94.059 Y95.16 E.00346
G1 X94.103 Y95.318 E.00324
G1 X94.119 Y95.501 E.00362
G1 X94.091 Y95.737 E.00466
G1 X94.012 Y95.948 E.00444
G1 X93.915 Y96.104 E.0036
G1 X93.708 Y96.304 E.00566
G1 X93.559 Y96.393 E.00341
G1 X93.399 Y96.458 E.0034
G1 X93.256 Y96.592 E.00386
G1 X93.07 Y96.72 E.00444
G1 X92.868 Y96.814 E.00438
G1 X92.652 Y96.871 E.00439
G1 X92.421 Y96.891 E.00456
G1 X88.326 Y96.891 E.08055
G1 X88.934 Y97.59 E.01822
G1 X89.063 Y97.767 E.00431
G1 X89.296 Y98.158 E.00896
G1 X89.401 Y98.381 E.00485
G1 X89.551 Y98.78 E.00838
G1 X89.659 Y99.22 E.00891
G1 X89.714 Y99.688 E.00926
G1 X89.714 Y100.113 E.00837
G1 X89.657 Y100.587 E.00939
G1 X89.557 Y101.001 E.00837
G1 X89.392 Y101.442 E.00926
G1 X89.198 Y101.821 E.00838
G1 X88.947 Y102.195 E.00885
G1 X88.652 Y102.538 E.00891
G1 X88.493 Y102.693 E.00435
G1 X88.304 Y102.855 E.00491
G1 X87.956 Y103.104 E.00843
G1 X87.743 Y103.229 E.00485
G1 X87.358 Y103.412 E.00838
G1 X86.928 Y103.557 E.00891
G1 X86.716 Y103.608 E.00431
G1 X86.265 Y103.676 E.00897
G1 X86.046 Y103.689 E.00431
G1 X85.593 Y103.676 E.00891
G1 X85.145 Y103.608 E.00891
G1 X84.933 Y103.557 E.00431
G1 X84.503 Y103.412 E.00891
G1 X84.098 Y103.218 E.00884
G1 X83.696 Y102.961 E.00939
G1 X83.366 Y102.691 E.00838
G1 X83.209 Y102.539 E.00431
G1 X82.914 Y102.195 E.00891
G1 X82.663 Y101.821 E.00885
G1 X82.459 Y101.42 E.00885
G1 X82.303 Y100.998 E.00885
G1 X82.199 Y100.56 E.00885
G1 X82.147 Y100.114 E.00885
G1 X82.148 Y99.661 E.00891
G1 X82.169 Y99.443 E.0043
G1 X82.25 Y98.997 E.00891
G1 X82.383 Y98.567 E.00885
G1 X82.567 Y98.154 E.0089
G1 X82.689 Y97.94 E.00485
G1 X82.929 Y97.588 E.00838
G1 X83.496 Y96.936 E.01699
; WIPE_START
M204 S6000
G1 X81.496 Y96.914 E-.38
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
M73 P91 R1
G1 X0 F18000
M623

; SKIPTYPE: head_wrap_detect
M622.1 S1
M1002 judge_flag g39_3rd_layer_detect_flag
M622 J1
    ; enable nozzle clog detect at 3rd layer
    


    M622.1 S1
    M1002 judge_flag g39_detection_flag
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




G1 X79.376 Y96.249
G1 Z5.36
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.148435
G1 F1500
M204 S6000
G1 X79.152 Y96.128 E.00156
G1 X79.021 Y96.033 E.00099
G1 X78.941 Y95.952 E.0007
G1 X78.858 Y95.807 E.00102
; LINE_WIDTH: 0.12449
G1 X78.825 Y95.715 E.00048
; LINE_WIDTH: 0.093832
G1 X78.792 Y95.622 E.00033
; WIPE_START
M73 P92 R1
G1 X78.825 Y95.715 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X84.478 Y97.165 Z5.76 F18000
G1 Z5.36
G1 E.4 F1800
; LINE_WIDTH: 0.477096
G1 F1500
M204 S6000
G1 X84.297 Y97.319 E.00533
; LINE_WIDTH: 0.4384
G1 X84.09 Y97.496 E.00561
; LINE_WIDTH: 0.400605
G1 X83.916 Y97.673 E.00464
; LINE_WIDTH: 0.359554
G1 X83.559 Y98.071 E.00891
G1 X83.272 Y98.514 E.00879
G1 X83.124 Y98.846 E.00605
G1 X83.022 Y99.186 E.00592
G1 X82.954 Y99.546 E.00609
G1 X82.934 Y100.005 E.00766
G1 X82.992 Y100.498 E.00825
G1 X83.097 Y100.879 E.00659
G1 X83.242 Y101.226 E.00626
G1 X83.544 Y101.716 E.00958
G1 X83.85 Y102.059 E.00765
G1 X84.271 Y102.396 E.00899
G1 X84.483 Y102.526 E.00413
G1 X84.802 Y102.678 E.00589
G1 X85.149 Y102.792 E.00608
G1 X85.454 Y102.858 E.0052
G1 X85.948 Y102.895 E.00825
G1 X86.323 Y102.87 E.00625
G1 X86.714 Y102.797 E.00662
G1 X87.178 Y102.627 E.00822
G1 X87.522 Y102.44 E.00653
G1 X87.959 Y102.107 E.00914
G1 X88.075 Y101.993 E.00271
G1 X88.4 Y101.6 E.0085
G1 X88.674 Y101.114 E.00929
G1 X88.799 Y100.78 E.00594
G1 X88.882 Y100.434 E.00593
G1 X88.926 Y99.928 E.00846
G1 X88.908 Y99.533 E.00658
G1 X88.792 Y99.014 E.00886
G1 X88.594 Y98.53 E.00871
G1 X88.398 Y98.201 E.00638
G1 X88.058 Y97.784 E.00896
; LINE_WIDTH: 0.378814
G1 X87.881 Y97.609 E.00438
; LINE_WIDTH: 0.419322
G1 X87.678 Y97.411 E.00557
; LINE_WIDTH: 0.468129
G1 X87.38 Y97.162 E.00857
; WIPE_START
G1 X87.678 Y97.411 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X92.707 Y96.134 Z5.76 F18000
G1 Z5.36
G1 E.4 F1800
; LINE_WIDTH: 0.126732
G1 F1500
M204 S6000
G1 X92.837 Y96.069 E.00073
; LINE_WIDTH: 0.100038
G1 X92.954 Y95.993 E.00052
; WIPE_START
G1 X92.837 Y96.069 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X88.216 Y89.994 Z5.76 F18000
G1 X78.787 Y77.598 Z5.76
G1 Z5.36
G1 E.4 F1800
; LINE_WIDTH: 0.0974282
G1 F1500
M204 S6000
G1 X78.82 Y77.482 E.00043
; LINE_WIDTH: 0.125818
G1 X78.868 Y77.363 E.00064
; LINE_WIDTH: 0.157244
G1 X78.929 Y77.274 E.00071
G1 X79.135 Y77.074 E.00189
; LINE_WIDTH: 0.131453
G1 X79.288 Y77 E.0009
; LINE_WIDTH: 0.100009
G1 X79.426 Y76.954 E.00054
; CHANGE_LAYER
; Z_HEIGHT: 5.48
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F1500
G1 X79.288 Y77 E-.38
; WIPE_END
G1 E-.02 F1800
; layer num/total_layer_count: 45/49
; update layer progress
M73 L45
M991 S0 P44 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z5.76 I-.301 J1.179 P1  F18000
G1 X93.304 Y80.581 Z5.76
G1 Z5.48
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X93.311 Y88.382 E.1651
G1 X92.95 Y88.382 E.00764
G1 X92.95 Y77.128 E.23818
G1 X93.135 Y77.076 E.00407
G1 X93.216 Y77.207 E.00325
G1 X93.272 Y77.349 E.00324
G1 X93.301 Y77.49 E.00306
G1 X93.304 Y80.521 E.06415
; WIPE_START
M204 S6000
G1 X93.306 Y82.521 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X93.293 Y90.154 Z5.88 F18000
G1 X93.284 Y95.469 Z5.88
G1 Z5.48
G1 E.4 F1800
G1 F1500
M204 S500
G1 X93.25 Y95.607 E.003
G1 X92.957 Y95.739 E.0068
G1 X92.98 Y95.486 E.00536
G1 X93.006 Y95.4 E.00191
G1 X93.102 Y95.347 E.00231
G1 X93.153 Y95.35 E.0011
G1 X93.227 Y95.383 E.0017
G1 X93.251 Y95.419 E.00092
; WIPE_START
M204 S6000
G1 X93.25 Y95.607 E-.06274
G1 X92.957 Y95.739 E-.10728
G1 X92.98 Y95.486 E-.08465
G1 X93.006 Y95.4 E-.03019
G1 X93.102 Y95.347 E-.03646
G1 X93.153 Y95.35 E-.01729
G1 X93.227 Y95.383 E-.02685
G1 X93.251 Y95.419 E-.01454
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X85.763 Y96.899 Z5.88 F18000
G1 X84.696 Y97.11 Z5.88
G1 Z5.48
G1 E.4 F1800
G1 F1500
M204 S500
G1 X84.589 Y96.949 E.0041
G1 X84.941 Y96.544 E.01135
G1 X86.929 Y96.544 E.04206
G1 X87.284 Y96.956 E.01152
G1 X87.161 Y97.12 E.00435
G1 X87.029 Y97.059 E.00307
G1 X86.535 Y96.915 E.01089
G1 X86.159 Y96.864 E.00803
G1 X85.793 Y96.858 E.00775
G1 X85.254 Y96.929 E.01149
G1 X84.753 Y97.092 E.01115
; WIPE_START
M204 S6000
G1 X84.589 Y96.949 E-.04131
G1 X84.941 Y96.544 E-.10188
G1 X86.188 Y96.544 E-.23681
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X84.86 Y102.288 Z5.88 F18000
G1 Z5.48
G1 E.4 F1800
G1 F1500
M204 S500
G1 X84.758 Y102.244 E.00236
G1 X84.479 Y102.083 E.00682
G1 X84.119 Y101.796 E.00975
G1 X83.809 Y101.441 E.00997
G1 X83.568 Y101.034 E.01001
G1 X83.451 Y100.747 E.00656
G1 X83.365 Y100.437 E.00682
G1 X83.31 Y99.979 E.00975
G1 X83.338 Y99.509 E.00997
G1 X83.452 Y99.05 E.01
G1 X83.57 Y98.764 E.00656
G1 X83.727 Y98.482 E.00682
G1 X84.003 Y98.125 E.00956
G1 X84.236 Y97.902 E.00682
G1 X84.484 Y97.716 E.00656
G1 X84.899 Y97.491 E.01
G1 X85.348 Y97.345 E.01
G1 X85.817 Y97.283 E.01
G1 X86.127 Y97.288 E.00656
G1 X86.446 Y97.331 E.00682
G1 X86.879 Y97.458 E.00955
G1 X87.172 Y97.594 E.00684
G1 X87.447 Y97.763 E.00682
G1 X87.798 Y98.061 E.00975
G1 X88.097 Y98.424 E.00995
G1 X88.326 Y98.835 E.00995
G1 X88.475 Y99.271 E.00975
G1 X88.532 Y99.588 E.00683
G1 X88.551 Y99.91 E.00683
G1 X88.51 Y100.369 E.00975
G1 X88.385 Y100.823 E.00997
G1 X88.178 Y101.248 E.01
G1 X88.003 Y101.504 E.00656
G1 X87.791 Y101.747 E.00682
G1 X87.439 Y102.046 E.00978
G1 X87.029 Y102.28 E.01
G1 X86.74 Y102.393 E.00656
G1 X86.428 Y102.474 E.00682
G1 X85.97 Y102.522 E.00976
G1 X85.5 Y102.487 E.00997
G1 X85.043 Y102.367 E.01
G1 X84.916 Y102.312 E.00293
M204 S250
G1 X85.022 Y101.912 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X84.942 Y101.878 E.00172
G1 X84.71 Y101.744 E.00526
G1 X84.403 Y101.499 E.00773
G1 X84.142 Y101.2 E.00781
G1 X83.935 Y100.852 E.00796
G1 X83.839 Y100.615 E.00503
G1 X83.768 Y100.357 E.00526
G1 X83.721 Y99.967 E.00773
G1 X83.744 Y99.571 E.0078
G1 X83.842 Y99.178 E.00796
G1 X83.939 Y98.942 E.00503
G1 X84.069 Y98.708 E.00526
G1 X84.308 Y98.4 E.00767
G1 X84.501 Y98.215 E.00526
G1 X84.705 Y98.061 E.00503
G1 X85.061 Y97.868 E.00796
G1 X85.439 Y97.745 E.00781
G1 X85.84 Y97.693 E.00796
G1 X86.096 Y97.697 E.00503
G1 X86.361 Y97.733 E.00526
G1 X86.735 Y97.842 E.00767
G1 X86.978 Y97.955 E.00527
G1 X87.205 Y98.095 E.00526
G1 X87.505 Y98.349 E.00774
G1 X87.757 Y98.655 E.0078
G1 X87.95 Y99.002 E.0078
G1 X88.077 Y99.374 E.00774
G1 X88.125 Y99.637 E.00526
G1 X88.141 Y99.904 E.00526
G1 X88.106 Y100.296 E.00773
G1 X88 Y100.678 E.0078
G1 X87.823 Y101.042 E.00796
G1 X87.679 Y101.253 E.00503
G1 X87.503 Y101.455 E.00526
G1 X87.203 Y101.709 E.00774
G1 X86.851 Y101.91 E.00796
G1 X86.613 Y102.003 E.00503
G1 X86.355 Y102.07 E.00526
G1 X85.964 Y102.111 E.00774
G1 X85.568 Y102.082 E.0078
G1 X85.177 Y101.979 E.00796
G1 X85.077 Y101.936 E.00213
; WIPE_START
M204 S6000
G1 X84.942 Y101.878 E-.02797
G1 X84.71 Y101.744 E-.0508
G1 X84.403 Y101.499 E-.07471
G1 X84.142 Y101.2 E-.0754
G1 X83.935 Y100.852 E-.07693
G1 X83.839 Y100.615 E-.04855
G1 X83.803 Y100.485 E-.02565
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X84.691 Y96.12 Z5.88 F18000
G1 Z5.48
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X92.496 Y96.12 E.16518
G1 X92.561 Y95.404 E.01522
G1 X92.605 Y95.262 E.00313
G1 X92.652 Y95.176 E.00209
G1 X92.788 Y95.035 E.00414
G1 X92.917 Y94.965 E.0031
G1 X93.014 Y94.935 E.00216
G1 X93.217 Y94.929 E.0043
G1 X93.317 Y94.954 E.00217
G1 X93.496 Y95.053 E.00433
G1 X93.57 Y95.124 E.00218
G1 X93.629 Y95.208 E.00217
G1 X93.699 Y95.393 E.00419
G1 X93.708 Y95.495 E.00215
G1 X93.69 Y95.639 E.00307
G1 X93.642 Y95.768 E.00292
G1 X93.518 Y95.931 E.00434
G1 X93.375 Y96.026 E.00361
G1 X93.175 Y96.108 E.00458
G1 X92.999 Y96.272 E.00511
G1 X92.866 Y96.364 E.0034
G1 X92.729 Y96.427 E.00321
G1 X92.582 Y96.466 E.00321
G1 X92.404 Y96.482 E.00378
G1 X87.435 Y96.482 E.10517
G1 X88.62 Y97.855 E.03839
G1 X88.932 Y98.345 E.01229
G1 X89.162 Y98.908 E.01289
G1 X89.287 Y99.498 E.01276
G1 X89.305 Y100.089 E.01252
G1 X89.254 Y100.51 E.00897
G1 X89.105 Y101.061 E.01209
G1 X88.845 Y101.614 E.01293
G1 X88.495 Y102.102 E.0127
G1 X88.2 Y102.405 E.00897
G1 X87.898 Y102.65 E.00823
G1 X87.379 Y102.955 E.01275
G1 X87.024 Y103.099 E.0081
G1 X86.628 Y103.208 E.00869
G1 X86.222 Y103.269 E.00869
G1 X85.63 Y103.267 E.01254
G1 X85.047 Y103.164 E.01254
G1 X84.658 Y103.032 E.00869
G1 X84.131 Y102.762 E.01254
G1 X83.797 Y102.522 E.00869
G1 X83.502 Y102.251 E.00849
G1 X83.24 Y101.947 E.00849
G1 X83.017 Y101.613 E.00849
G1 X82.834 Y101.256 E.0085
G1 X82.696 Y100.879 E.00849
G1 X82.603 Y100.49 E.00847
G1 X82.556 Y100.069 E.00897
G1 X82.574 Y99.499 E.01208
G1 X82.648 Y99.095 E.00869
G1 X82.767 Y98.712 E.00849
G1 X82.934 Y98.337 E.00869
G1 X83.254 Y97.838 E.01254
G1 X84.434 Y96.482 E.03805
G1 X79.467 Y96.482 E.10513
G1 X79.219 Y96.453 E.00527
G1 X79.074 Y96.405 E.00324
G1 X78.858 Y96.269 E.0054
G1 X78.691 Y96.077 E.00539
G1 X78.578 Y95.803 E.00627
G1 X78.55 Y95.565 E.00508
G1 X78.55 Y77.628 E.37965
G1 X78.586 Y77.357 E.00578
G1 X78.691 Y77.125 E.00539
G1 X78.864 Y76.929 E.00553
G1 X78.991 Y76.84 E.00329
G1 X79.138 Y76.772 E.00344
G1 X79.388 Y76.723 E.00539
G1 X92.465 Y76.722 E.27678
G1 X92.634 Y76.747 E.00361
G1 X92.778 Y76.794 E.00321
G1 X92.955 Y76.889 E.00424
G1 X92.906 Y77.082 E.0042
G1 X79.877 Y77.082 E.27577
G1 X79.591 Y77.131 E.00614
G1 X79.31 Y77.282 E.00674
G1 X79.077 Y77.529 E.00718
G1 X78.948 Y77.807 E.00649
G1 X78.911 Y78.056 E.00533
G1 X78.911 Y95.155 E.36192
G1 X78.964 Y95.453 E.00639
G1 X79.148 Y95.771 E.00779
G1 X79.478 Y96.031 E.0089
G1 X79.859 Y96.12 E.00828
G1 X84.631 Y96.12 E.10101
; WIPE_START
M204 S6000
G1 X86.631 Y96.12 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X83.535 Y96.891 Z5.88 F18000
G1 Z5.48
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X79.443 Y96.891 E.08049
G1 X79.13 Y96.854 E.00619
G1 X78.917 Y96.784 E.00442
G1 X78.788 Y96.719 E.00283
G1 X78.599 Y96.587 E.00454
G1 X78.495 Y96.488 E.00283
G1 X78.352 Y96.307 E.00454
G1 X78.281 Y96.185 E.00277
G1 X78.177 Y95.898 E.00601
G1 X78.141 Y95.589 E.00613
G1 X78.141 Y77.61 E.35362
G1 X78.161 Y77.374 E.00466
G1 X78.194 Y77.234 E.00283
G1 X78.28 Y77.019 E.00454
G1 X78.352 Y76.895 E.00283
G1 X78.494 Y76.714 E.00453
G1 X78.605 Y76.61 E.00299
G1 X78.786 Y76.484 E.00433
G1 X78.992 Y76.388 E.00448
G1 X79.13 Y76.347 E.00283
G1 X79.359 Y76.313 E.00454
G1 X92.494 Y76.313 E.25837
G1 X92.728 Y76.347 E.00465
G1 X92.941 Y76.417 E.00441
G1 X93.139 Y76.524 E.00442
G1 X93.315 Y76.663 E.00443
G1 X93.465 Y76.831 E.00442
G1 X93.583 Y77.022 E.00442
G1 X93.666 Y77.231 E.00442
G1 X93.71 Y77.448 E.00436
G1 X93.72 Y88.791 E.2231
G1 X92.541 Y88.791 E.02321
G1 X92.541 Y77.491 E.22226
G1 X79.912 Y77.491 E.24838
G1 X79.726 Y77.523 E.00372
G1 X79.562 Y77.611 E.00366
G1 X79.42 Y77.762 E.00407
G1 X79.344 Y77.925 E.00355
G1 X79.321 Y78.086 E.00319
G1 X79.321 Y95.119 E.33504
G1 X79.354 Y95.31 E.00382
G1 X79.463 Y95.498 E.00426
G1 X79.66 Y95.653 E.00494
G1 X79.906 Y95.711 E.00498
G1 X92.122 Y95.711 E.24027
G1 X92.158 Y95.325 E.00763
G1 X92.226 Y95.102 E.00458
G1 X92.312 Y94.946 E.0035
G1 X92.422 Y94.81 E.00345
G1 X92.554 Y94.698 E.0034
G1 X92.756 Y94.586 E.00454
G1 X92.93 Y94.532 E.00358
G1 X93.104 Y94.512 E.00345
G1 X93.279 Y94.523 E.00345
G1 X93.45 Y94.565 E.00346
G1 X93.61 Y94.636 E.00346
G1 X93.756 Y94.734 E.00345
G1 X93.881 Y94.857 E.00346
G1 X93.984 Y95 E.00346
G1 X94.059 Y95.159 E.00346
G1 X94.103 Y95.32 E.00328
G1 X94.119 Y95.501 E.00357
G1 X94.091 Y95.736 E.00466
G1 X94.011 Y95.95 E.00449
G1 X93.915 Y96.103 E.00355
G1 X93.708 Y96.304 E.00567
G1 X93.558 Y96.393 E.00344
G1 X93.399 Y96.458 E.00337
G1 X93.256 Y96.592 E.00386
G1 X93.07 Y96.72 E.00444
G1 X92.868 Y96.814 E.00438
G1 X92.653 Y96.871 E.00438
G1 X92.421 Y96.891 E.00456
G1 X88.329 Y96.891 E.0805
G1 X88.945 Y97.606 E.01857
G1 X89.187 Y97.962 E.00847
G1 X89.391 Y98.356 E.00873
G1 X89.552 Y98.783 E.00896
G1 X89.615 Y99.016 E.00475
G1 X89.693 Y99.443 E.00853
G1 X89.713 Y99.661 E.00431
G1 X89.714 Y100.113 E.0089
G1 X89.658 Y100.582 E.0093
G1 X89.557 Y101.001 E.00847
G1 X89.488 Y101.209 E.00431
G1 X89.305 Y101.627 E.00897
G1 X89.08 Y102.009 E.00873
G1 X88.806 Y102.369 E.0089
G1 X88.476 Y102.708 E.0093
G1 X88.142 Y102.979 E.00847
G1 X87.96 Y103.102 E.00431
G1 X87.561 Y103.322 E.00897
G1 X87.358 Y103.412 E.00437
G1 X87.15 Y103.489 E.00436
G1 X86.713 Y103.609 E.00891
G1 X86.265 Y103.676 E.00891
G1 X86.046 Y103.689 E.0043
G1 X85.593 Y103.676 E.00891
G1 X85.145 Y103.608 E.00891
M73 P93 R1
G1 X84.933 Y103.557 E.0043
G1 X84.503 Y103.412 E.00891
G1 X84.095 Y103.216 E.00891
G1 X83.906 Y103.105 E.00431
G1 X83.539 Y102.84 E.00891
G1 X83.207 Y102.536 E.00885
G1 X82.914 Y102.195 E.00885
G1 X82.663 Y101.821 E.00885
G1 X82.459 Y101.42 E.00885
G1 X82.303 Y100.998 E.00885
G1 X82.199 Y100.561 E.00884
G1 X82.146 Y100.091 E.00929
G1 X82.148 Y99.661 E.00847
G1 X82.169 Y99.443 E.00431
G1 X82.25 Y98.997 E.00891
G1 X82.383 Y98.567 E.00885
G1 X82.568 Y98.153 E.00891
G1 X82.674 Y97.962 E.0043
G1 X82.929 Y97.588 E.00891
G1 X83.496 Y96.936 E.01698
; WIPE_START
M204 S6000
G1 X81.496 Y96.914 E-.38
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




G1 X79.311 Y96.244
G1 Z5.48
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.14885
G1 F1500
M204 S6000
G1 X78.948 Y95.959 E.00284
G1 X78.778 Y95.627 E.00229
; WIPE_START
G1 X78.948 Y95.959 E-.16994
G1 X79.311 Y96.244 E-.21006
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X84.479 Y97.167 Z5.88 F18000
G1 Z5.48
G1 E.4 F1800
; LINE_WIDTH: 0.478365
G1 F1500
M204 S6000
G1 X84.238 Y97.363 E.00702
; LINE_WIDTH: 0.444409
G1 X84.113 Y97.479 E.00355
; LINE_WIDTH: 0.406586
G1 X83.973 Y97.61 E.00364
; LINE_WIDTH: 0.35975
G1 X83.558 Y98.073 E.01036
G1 X83.351 Y98.373 E.00609
G1 X83.123 Y98.848 E.00877
G1 X83.022 Y99.187 E.00589
G1 X82.954 Y99.546 E.0061
G1 X82.936 Y100.051 E.00843
G1 X82.992 Y100.498 E.00749
G1 X83.097 Y100.878 E.00658
G1 X83.236 Y101.213 E.00604
G1 X83.544 Y101.716 E.00983
G1 X83.848 Y102.058 E.00763
G1 X84.256 Y102.388 E.00875
G1 X84.599 Y102.583 E.00657
G1 X84.932 Y102.725 E.00603
G1 X85.423 Y102.856 E.00846
G1 X85.961 Y102.9 E.00899
G1 X86.508 Y102.843 E.00916
G1 X86.866 Y102.75 E.00617
G1 X87.21 Y102.614 E.00617
G1 X87.668 Y102.347 E.00884
G1 X88.046 Y102.023 E.00829
G1 X88.294 Y101.741 E.00625
G1 X88.517 Y101.421 E.00651
G1 X88.744 Y100.943 E.00882
G1 X88.882 Y100.441 E.00867
G1 X88.922 Y100.067 E.00626
G1 X88.922 Y99.704 E.00606
G1 X88.845 Y99.188 E.00869
G1 X88.673 Y98.696 E.00869
G1 X88.59 Y98.522 E.00321
G1 X88.398 Y98.201 E.00623
G1 X88.058 Y97.784 E.00897
; LINE_WIDTH: 0.379196
G1 X87.881 Y97.609 E.00439
; LINE_WIDTH: 0.42075
G1 X87.679 Y97.411 E.00558
; LINE_WIDTH: 0.468425
G1 X87.39 Y97.168 E.00833
; WIPE_START
G1 X87.679 Y97.411 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X92.707 Y96.134 Z5.88 F18000
G1 Z5.48
G1 E.4 F1800
; LINE_WIDTH: 0.126884
G1 F1500
M204 S6000
G1 X92.836 Y96.068 E.00073
; LINE_WIDTH: 0.100119
G1 X92.955 Y95.993 E.00052
; WIPE_START
G1 X92.836 Y96.068 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X88.216 Y89.993 Z5.88 F18000
G1 X78.788 Y77.595 Z5.88
G1 Z5.48
G1 E.4 F1800
; LINE_WIDTH: 0.0999015
G1 F1500
M204 S6000
G1 X78.835 Y77.434 E.00062
; LINE_WIDTH: 0.146533
G1 X78.895 Y77.322 E.00076
G1 X79.047 Y77.147 E.0014
G1 X79.137 Y77.071 E.00071
G1 X79.278 Y77.003 E.00094
; LINE_WIDTH: 0.10181
G1 X79.426 Y76.954 E.00059
; CHANGE_LAYER
; Z_HEIGHT: 5.6
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F1500
G1 X79.278 Y77.003 E-.38
; WIPE_END
G1 E-.02 F1800
; layer num/total_layer_count: 46/49
; update layer progress
M73 L46
M991 S0 P45 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z5.88 I-.301 J1.179 P1  F18000
G1 X93.304 Y80.581 Z5.88
G1 Z5.6
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X93.311 Y88.382 E.1651
G1 X92.95 Y88.382 E.00764
G1 X92.95 Y77.128 E.23818
G1 X93.135 Y77.076 E.00407
G1 X93.216 Y77.207 E.00325
G1 X93.272 Y77.349 E.00324
G1 X93.301 Y77.49 E.00306
G1 X93.304 Y80.521 E.06416
; WIPE_START
M204 S6000
G1 X93.306 Y82.521 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X93.293 Y90.154 Z6 F18000
G1 X93.284 Y95.469 Z6
G1 Z5.6
G1 E.4 F1800
G1 F1500
M204 S500
G1 X93.25 Y95.607 E.003
G1 X92.957 Y95.739 E.00679
G1 X92.98 Y95.487 E.00535
G1 X93.006 Y95.4 E.00193
G1 X93.102 Y95.347 E.00232
G1 X93.153 Y95.35 E.00109
G1 X93.227 Y95.383 E.0017
G1 X93.251 Y95.419 E.00092
; WIPE_START
M204 S6000
G1 X93.25 Y95.607 E-.06279
G1 X92.957 Y95.739 E-.10727
G1 X92.98 Y95.487 E-.0844
G1 X93.006 Y95.4 E-.03042
G1 X93.102 Y95.347 E-.03656
G1 X93.153 Y95.35 E-.01723
G1 X93.227 Y95.383 E-.02682
G1 X93.251 Y95.419 E-.01452
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X85.763 Y96.899 Z6 F18000
G1 X84.696 Y97.11 Z6
G1 Z5.6
G1 E.4 F1800
G1 F1500
M204 S500
G1 X84.589 Y96.949 E.0041
G1 X84.941 Y96.544 E.01135
G1 X86.92 Y96.544 E.04188
G1 X87.271 Y96.948 E.01132
G1 X87.142 Y97.113 E.00443
G1 X87.045 Y97.064 E.0023
G1 X86.535 Y96.915 E.01126
G1 X86.159 Y96.864 E.00803
G1 X85.79 Y96.858 E.00781
G1 X85.254 Y96.929 E.01144
G1 X84.753 Y97.092 E.01114
; WIPE_START
M204 S6000
G1 X84.589 Y96.949 E-.04131
G1 X84.941 Y96.544 E-.10189
G1 X86.188 Y96.544 E-.2368
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X84.831 Y102.275 Z6 F18000
G1 Z5.6
G1 E.4 F1800
G1 F1500
M204 S500
G1 X84.486 Y102.089 E.00829
G1 X84.119 Y101.796 E.00995
G1 X83.81 Y101.442 E.00994
G1 X83.573 Y101.047 E.00975
G1 X83.451 Y100.748 E.00682
G1 X83.367 Y100.447 E.00662
G1 X83.31 Y99.98 E.00995
G1 X83.338 Y99.509 E.00999
G1 X83.451 Y99.053 E.00995
G1 X83.57 Y98.764 E.00662
G1 X83.727 Y98.482 E.00682
G1 X84.009 Y98.118 E.00975
G1 X84.351 Y97.809 E.00975
G1 X84.62 Y97.632 E.00683
G1 X84.909 Y97.487 E.00683
G1 X85.348 Y97.345 E.00977
G1 X85.814 Y97.283 E.00995
G1 X86.127 Y97.288 E.00662
G1 X86.446 Y97.331 E.00683
G1 X86.889 Y97.461 E.00977
G1 X87.309 Y97.672 E.00995
G1 X87.565 Y97.852 E.00662
G1 X87.804 Y98.068 E.00682
G1 X88.097 Y98.424 E.00975
G1 X88.326 Y98.835 E.00997
G1 X88.477 Y99.281 E.00995
G1 X88.532 Y99.588 E.00662
G1 X88.551 Y99.901 E.00663
G1 X88.532 Y100.213 E.00663
G1 X88.477 Y100.521 E.00662
G1 X88.326 Y100.967 E.00995
G1 X88.097 Y101.378 E.00997
G1 X87.798 Y101.741 E.00995
G1 X87.44 Y102.045 E.00995
G1 X87.041 Y102.275 E.00975
G1 X86.741 Y102.393 E.00682
G1 X86.438 Y102.472 E.00662
G1 X85.98 Y102.521 E.00975
G1 X85.657 Y102.507 E.00685
G1 X85.338 Y102.454 E.00683
G1 X84.9 Y102.312 E.00975
G1 X84.884 Y102.303 E.00038
M204 S250
G1 X85.025 Y101.914 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X84.713 Y101.746 E.00698
G1 X84.403 Y101.499 E.0078
G1 X84.142 Y101.2 E.00779
G1 X83.94 Y100.863 E.00773
G1 X83.839 Y100.615 E.00526
G1 X83.77 Y100.367 E.00508
G1 X83.721 Y99.967 E.00791
G1 X83.744 Y99.571 E.00781
G1 X83.841 Y99.18 E.00791
G1 X83.939 Y98.942 E.00508
G1 X84.069 Y98.708 E.00526
G1 X84.31 Y98.397 E.00774
G1 X84.602 Y98.134 E.00773
G1 X84.825 Y97.987 E.00526
G1 X85.065 Y97.867 E.00526
G1 X85.439 Y97.745 E.00774
G1 X85.838 Y97.693 E.00792
G1 X86.096 Y97.697 E.00508
G1 X86.361 Y97.733 E.00526
G1 X86.739 Y97.843 E.00774
G1 X87.098 Y98.024 E.00792
G1 X87.309 Y98.173 E.00507
G1 X87.508 Y98.352 E.00526
G1 X87.757 Y98.655 E.00773
G1 X87.95 Y99.002 E.00781
G1 X88.079 Y99.383 E.00791
G1 X88.125 Y99.637 E.00508
G1 X88.141 Y99.901 E.0052
G1 X88.125 Y100.165 E.0052
G1 X88.079 Y100.419 E.00508
G1 X87.95 Y100.8 E.00792
G1 X87.757 Y101.146 E.0078
G1 X87.506 Y101.452 E.00779
G1 X87.203 Y101.709 E.0078
G1 X86.863 Y101.905 E.00773
G1 X86.614 Y102.003 E.00526
G1 X86.364 Y102.068 E.00508
G1 X85.967 Y102.111 E.00785
G1 X85.7 Y102.099 E.00527
G1 X85.436 Y102.055 E.00526
G1 X85.079 Y101.94 E.00736
; WIPE_START
M204 S6000
G1 X84.713 Y101.746 E-.07879
G1 X84.403 Y101.499 E-.07533
G1 X84.142 Y101.2 E-.07528
G1 X83.94 Y100.863 E-.0747
G1 X83.839 Y100.615 E-.05083
G1 X83.804 Y100.488 E-.02508
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X84.691 Y96.12 Z6 F18000
G1 Z5.6
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X92.496 Y96.12 E.16519
G1 X92.561 Y95.405 E.0152
G1 X92.605 Y95.262 E.00317
G1 X92.652 Y95.176 E.00206
G1 X92.788 Y95.036 E.00414
G1 X92.918 Y94.964 E.00315
G1 X93.014 Y94.935 E.00212
G1 X93.217 Y94.929 E.00431
G1 X93.317 Y94.953 E.00217
G1 X93.411 Y94.995 E.00218
G1 X93.569 Y95.124 E.00433
G1 X93.629 Y95.208 E.00217
G1 X93.699 Y95.394 E.00421
G1 X93.708 Y95.494 E.00212
G1 X93.69 Y95.638 E.00308
G1 X93.642 Y95.769 E.00295
G1 X93.517 Y95.932 E.00435
G1 X93.375 Y96.026 E.00361
G1 X93.184 Y96.104 E.00436
G1 X92.874 Y96.36 E.0085
G1 X92.729 Y96.427 E.0034
G1 X92.582 Y96.466 E.00321
G1 X92.404 Y96.482 E.00378
G1 X87.428 Y96.482 E.10532
G1 X88.613 Y97.844 E.03822
G1 X88.729 Y98.006 E.00423
G1 X88.935 Y98.351 E.0085
G1 X89.159 Y98.901 E.01257
G1 X89.286 Y99.49 E.01274
G1 X89.305 Y100.09 E.01271
G1 X89.255 Y100.506 E.00887
G1 X89.105 Y101.061 E.01218
G1 X88.937 Y101.446 E.00889
G1 X88.621 Y101.947 E.01254
G1 X88.217 Y102.391 E.0127
G1 X88.058 Y102.527 E.00443
G1 X87.574 Y102.855 E.01238
G1 X87.024 Y103.099 E.01273
G1 X86.628 Y103.208 E.00869
G1 X86.222 Y103.269 E.00869
G1 X85.63 Y103.267 E.01254
G1 X85.047 Y103.164 E.01254
G1 X84.658 Y103.032 E.00869
G1 X84.297 Y102.859 E.00847
G1 X83.943 Y102.634 E.00887
G1 X83.508 Y102.258 E.01218
G1 X83.24 Y101.947 E.00869
G1 X83.017 Y101.613 E.00849
G1 X82.835 Y101.257 E.00847
G1 X82.691 Y100.863 E.00887
G1 X82.574 Y100.3 E.01218
G1 X82.551 Y99.89 E.00869
G1 X82.576 Y99.49 E.00849
G1 X82.648 Y99.095 E.0085
G1 X82.767 Y98.712 E.00849
G1 X82.934 Y98.338 E.00866
G1 X83.253 Y97.838 E.01256
G1 X84.433 Y96.482 E.03806
G1 X79.467 Y96.482 E.10513
G1 X79.138 Y96.43 E.00703
G1 X78.991 Y96.362 E.00344
G1 X78.859 Y96.269 E.00343
G1 X78.73 Y96.133 E.00395
G1 X78.653 Y96.008 E.00312
G1 X78.578 Y95.802 E.00463
G1 X78.55 Y95.565 E.00506
G1 X78.55 Y77.628 E.37965
G1 X78.588 Y77.349 E.00597
G1 X78.697 Y77.118 E.00539
G1 X78.863 Y76.93 E.00531
G1 X78.991 Y76.84 E.00331
G1 X79.13 Y76.775 E.00325
G1 X79.379 Y76.723 E.00539
G1 X92.467 Y76.722 E.27701
G1 X92.634 Y76.746 E.00357
G1 X92.779 Y76.794 E.00322
G1 X92.955 Y76.889 E.00424
G1 X92.906 Y77.082 E.0042
G1 X79.877 Y77.082 E.27578
G1 X79.589 Y77.132 E.00619
G1 X79.318 Y77.278 E.00651
G1 X79.101 Y77.495 E.00649
G1 X78.949 Y77.798 E.00718
G1 X78.911 Y78.056 E.00553
G1 X78.911 Y95.155 E.36192
G1 X78.964 Y95.453 E.00641
G1 X79.152 Y95.779 E.00796
G1 X79.513 Y96.047 E.00951
G1 X79.867 Y96.12 E.00766
G1 X84.631 Y96.12 E.10083
; WIPE_START
M204 S6000
G1 X86.631 Y96.12 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X83.535 Y96.891 Z6 F18000
G1 Z5.6
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X79.443 Y96.891 E.08049
G1 X79.127 Y96.854 E.00625
G1 X78.993 Y96.814 E.00276
G1 X78.786 Y96.717 E.00448
G1 X78.599 Y96.587 E.00448
G1 X78.493 Y96.486 E.00289
G1 X78.398 Y96.373 E.00289
G1 X78.283 Y96.188 E.00429
G1 X78.177 Y95.898 E.00607
G1 X78.141 Y95.589 E.00612
G1 X78.141 Y77.61 E.35362
G1 X78.161 Y77.374 E.00466
G1 X78.195 Y77.231 E.00289
G1 X78.245 Y77.093 E.00289
G1 X78.353 Y76.893 E.00448
G1 X78.495 Y76.714 E.00447
G1 X78.604 Y76.611 E.00296
G1 X78.786 Y76.484 E.00436
G1 X78.99 Y76.389 E.00442
G1 X79.21 Y76.33 E.00448
G1 X79.356 Y76.313 E.00289
G1 X92.496 Y76.313 E.25846
G1 X92.728 Y76.347 E.00461
G1 X92.941 Y76.417 E.00441
G1 X93.139 Y76.524 E.00442
G1 X93.315 Y76.663 E.00442
G1 X93.465 Y76.831 E.00442
G1 X93.583 Y77.022 E.00442
G1 X93.666 Y77.231 E.00442
G1 X93.71 Y77.448 E.00436
G1 X93.72 Y88.791 E.2231
G1 X92.541 Y88.791 E.02321
G1 X92.541 Y77.491 E.22226
G1 X79.912 Y77.491 E.24839
G1 X79.725 Y77.524 E.00375
G1 X79.565 Y77.61 E.00357
G1 X79.437 Y77.737 E.00355
G1 X79.345 Y77.922 E.00407
G1 X79.321 Y78.086 E.00325
G1 X79.321 Y95.119 E.33504
G1 X79.354 Y95.311 E.00383
G1 X79.464 Y95.501 E.00432
G1 X79.684 Y95.665 E.0054
G1 X79.909 Y95.711 E.00451
G1 X92.122 Y95.711 E.24022
G1 X92.157 Y95.326 E.00761
G1 X92.226 Y95.101 E.00461
G1 X92.311 Y94.947 E.00348
G1 X92.422 Y94.81 E.00345
G1 X92.553 Y94.698 E.0034
G1 X92.757 Y94.585 E.00459
G1 X92.929 Y94.532 E.00353
G1 X93.103 Y94.512 E.00345
G1 X93.279 Y94.523 E.00345
M73 P94 R1
G1 X93.449 Y94.564 E.00345
G1 X93.61 Y94.636 E.00346
G1 X93.755 Y94.734 E.00346
G1 X93.881 Y94.857 E.00345
G1 X93.983 Y95 E.00346
G1 X94.059 Y95.159 E.00346
G1 X94.103 Y95.321 E.00331
G1 X94.119 Y95.5 E.00354
G1 X94.091 Y95.736 E.00466
G1 X94.011 Y95.951 E.00452
G1 X93.916 Y96.103 E.00352
G1 X93.709 Y96.304 E.00567
G1 X93.557 Y96.394 E.00347
G1 X93.402 Y96.457 E.00329
G1 X93.193 Y96.641 E.00549
G1 X93.073 Y96.719 E.00281
G1 X92.868 Y96.814 E.00444
G1 X92.653 Y96.871 E.00438
G1 X92.421 Y96.891 E.00456
G1 X88.326 Y96.891 E.08055
G1 X88.934 Y97.59 E.01822
G1 X89.072 Y97.782 E.00466
G1 X89.296 Y98.158 E.00862
G1 X89.398 Y98.372 E.00466
G1 X89.551 Y98.78 E.00856
G1 X89.659 Y99.22 E.00891
G1 X89.713 Y99.661 E.00873
G1 X89.714 Y100.113 E.0089
G1 X89.659 Y100.578 E.0092
G1 X89.557 Y101.001 E.00856
G1 X89.488 Y101.209 E.0043
G1 X89.305 Y101.627 E.00898
G1 X89.2 Y101.818 E.0043
G1 X88.947 Y102.195 E.00891
G1 X88.652 Y102.539 E.00891
G1 X88.493 Y102.693 E.00435
G1 X88.311 Y102.849 E.00472
G1 X87.955 Y103.105 E.00862
G1 X87.766 Y103.216 E.00431
G1 X87.355 Y103.413 E.00897
G1 X87.15 Y103.489 E.0043
G1 X86.713 Y103.609 E.00891
G1 X86.265 Y103.676 E.00891
G1 X86.046 Y103.689 E.0043
G1 X85.593 Y103.676 E.00891
G1 X85.145 Y103.608 E.00891
G1 X84.933 Y103.557 E.00431
G1 X84.504 Y103.412 E.00891
G1 X84.098 Y103.218 E.00884
G1 X83.703 Y102.966 E.0092
G1 X83.366 Y102.691 E.00856
G1 X83.209 Y102.538 E.00431
G1 X82.914 Y102.195 E.00891
G1 X82.663 Y101.821 E.00885
G1 X82.459 Y101.421 E.00884
G1 X82.299 Y100.981 E.0092
G1 X82.198 Y100.558 E.00856
G1 X82.166 Y100.341 E.0043
G1 X82.141 Y99.889 E.00891
G1 X82.169 Y99.44 E.00885
G1 X82.25 Y98.997 E.00885
G1 X82.383 Y98.567 E.00885
G1 X82.567 Y98.154 E.0089
G1 X82.684 Y97.947 E.00466
G1 X82.929 Y97.588 E.00856
G1 X83.496 Y96.936 E.01699
; WIPE_START
M204 S6000
G1 X81.496 Y96.914 E-.38
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




G1 X79.368 Y96.256
G1 Z5.6
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.148141
G1 F1500
M204 S6000
G1 X79.134 Y96.117 E.00166
G1 X78.955 Y95.97 E.00141
G1 X78.778 Y95.627 E.00236
; WIPE_START
G1 X78.955 Y95.97 E-.16508
G1 X79.134 Y96.117 E-.09891
G1 X79.368 Y96.256 E-.11601
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X84.478 Y97.165 Z6 F18000
G1 Z5.6
G1 E.4 F1800
; LINE_WIDTH: 0.477102
G1 F1500
M204 S6000
G1 X84.297 Y97.319 E.00533
; LINE_WIDTH: 0.438407
G1 X84.09 Y97.496 E.00561
; LINE_WIDTH: 0.400613
G1 X83.916 Y97.673 E.00464
; LINE_WIDTH: 0.359652
G1 X83.559 Y98.071 E.00891
G1 X83.273 Y98.514 E.00879
G1 X83.124 Y98.846 E.00606
G1 X83.022 Y99.187 E.00593
G1 X82.955 Y99.536 E.00593
G1 X82.933 Y99.977 E.00736
G1 X82.998 Y100.508 E.00891
G1 X83.091 Y100.861 E.00608
G1 X83.242 Y101.226 E.00658
G1 X83.513 Y101.676 E.00875
G1 X83.849 Y102.057 E.00846
G1 X84.17 Y102.325 E.00697
G1 X84.483 Y102.523 E.00618
G1 X84.801 Y102.679 E.0059
G1 X85.237 Y102.816 E.00761
G1 X85.664 Y102.888 E.0072
G1 X86.188 Y102.885 E.00873
G1 X86.55 Y102.835 E.00608
G1 X86.902 Y102.738 E.00609
G1 X87.39 Y102.517 E.00892
G1 X87.823 Y102.223 E.00871
G1 X88.075 Y101.993 E.00569
G1 X88.398 Y101.601 E.00846
G1 X88.662 Y101.132 E.00897
G1 X88.839 Y100.627 E.00891
G1 X88.905 Y100.268 E.00608
G1 X88.928 Y99.891 E.00629
G1 X88.881 Y99.372 E.00868
G1 X88.792 Y99.017 E.0061
G1 X88.595 Y98.53 E.00875
G1 X88.398 Y98.201 E.00639
G1 X88.07 Y97.797 E.00867
; LINE_WIDTH: 0.382433
G1 X87.807 Y97.531 E.00666
; LINE_WIDTH: 0.426785
G1 X87.681 Y97.417 E.00339
; LINE_WIDTH: 0.467976
G1 X87.549 Y97.305 E.00383
; LINE_WIDTH: 0.465054
G1 X87.382 Y97.336 E.00374
; LINE_WIDTH: 0.437203
G1 X87.214 Y97.367 E.0035
; WIPE_START
G1 X87.382 Y97.336 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X92.708 Y96.135 Z6 F18000
G1 Z5.6
G1 E.4 F1800
; LINE_WIDTH: 0.129865
G1 F1500
M204 S6000
G1 X92.869 Y96.046 E.00096
; LINE_WIDTH: 0.0941119
G1 X92.955 Y95.993 E.00034
; WIPE_START
G1 X92.869 Y96.046 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X88.238 Y89.979 Z6 F18000
G1 X78.787 Y77.598 Z6
G1 Z5.6
G1 E.4 F1800
; LINE_WIDTH: 0.0974692
G1 F1500
M204 S6000
G1 X78.82 Y77.482 E.00043
; LINE_WIDTH: 0.125737
G1 X78.865 Y77.369 E.0006
; LINE_WIDTH: 0.154188
G1 X79.043 Y77.151 E.0018
G1 X79.152 Y77.068 E.00088
; LINE_WIDTH: 0.125185
G1 X79.325 Y76.991 E.00094
; LINE_WIDTH: 0.089585
G1 X79.427 Y76.955 E.00035
; CHANGE_LAYER
; Z_HEIGHT: 5.72
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F1500
G1 X79.325 Y76.991 E-.38
; WIPE_END
G1 E-.02 F1800
; layer num/total_layer_count: 47/49
; update layer progress
M73 L47
M991 S0 P46 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z6 I-.296 J1.18 P1  F18000
G1 X93.304 Y80.492 Z6
G1 Z5.72
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X93.311 Y88.382 E.16698
G1 X92.95 Y88.382 E.00764
G1 X92.95 Y77.128 E.23818
G1 X93.135 Y77.076 E.00407
G1 X93.216 Y77.207 E.00325
G1 X93.272 Y77.349 E.00324
G1 X93.301 Y77.49 E.00306
G1 X93.304 Y80.432 E.06227
; WIPE_START
M204 S6000
G1 X93.306 Y82.432 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X93.293 Y90.065 Z6.12 F18000
G1 X93.284 Y95.469 Z6.12
G1 Z5.72
G1 E.4 F1800
G1 F1500
M204 S500
G1 X93.249 Y95.607 E.00301
G1 X92.957 Y95.738 E.00679
G1 X92.979 Y95.488 E.00532
G1 X93.006 Y95.4 E.00194
G1 X93.102 Y95.347 E.00231
G1 X93.153 Y95.35 E.00108
G1 X93.227 Y95.383 E.0017
G1 X93.251 Y95.419 E.00092
; WIPE_START
M204 S6000
G1 X93.249 Y95.607 E-.06286
G1 X92.957 Y95.738 E-.10723
G1 X92.979 Y95.488 E-.0841
G1 X93.006 Y95.4 E-.03071
G1 X93.102 Y95.347 E-.03652
G1 X93.153 Y95.35 E-.01711
G1 X93.227 Y95.383 E-.02693
G1 X93.251 Y95.419 E-.01454
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X85.762 Y96.892 Z6.12 F18000
G1 X84.765 Y97.088 Z6.12
G1 Z5.72
G1 E.4 F1800
G1 F1500
M204 S500
G1 X84.659 Y96.922 E.00416
G1 X85.008 Y96.544 E.01089
G1 X86.92 Y96.544 E.04046
G1 X87.271 Y96.948 E.01133
G1 X87.143 Y97.113 E.00442
G1 X87.044 Y97.064 E.00235
G1 X86.535 Y96.915 E.01123
G1 X86.159 Y96.864 E.00803
G1 X85.787 Y96.858 E.00787
G1 X85.253 Y96.929 E.01139
G1 X84.822 Y97.069 E.00959
; WIPE_START
M204 S6000
G1 X84.659 Y96.922 E-.04172
G1 X85.008 Y96.544 E-.09775
G1 X86.274 Y96.544 E-.24054
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X84.83 Y102.274 Z6.12 F18000
G1 Z5.72
G1 E.4 F1800
G1 F1500
M204 S500
G1 X84.486 Y102.089 E.00827
G1 X84.119 Y101.796 E.00995
G1 X83.809 Y101.441 E.00996
G1 X83.57 Y101.039 E.0099
G1 X83.451 Y100.748 E.00667
G1 X83.365 Y100.437 E.00683
G1 X83.31 Y99.979 E.00975
G1 X83.338 Y99.509 E.00996
G1 X83.45 Y99.055 E.0099
G1 X83.57 Y98.764 E.00667
G1 X83.727 Y98.482 E.00682
G1 X84.003 Y98.125 E.00956
G1 X84.236 Y97.902 E.00683
G1 X84.495 Y97.708 E.00683
G1 X84.9 Y97.49 E.00975
G1 X85.348 Y97.345 E.00996
G1 X85.811 Y97.283 E.0099
G1 X86.127 Y97.288 E.00667
G1 X86.446 Y97.331 E.00682
G1 X86.888 Y97.46 E.00975
G1 X87.301 Y97.667 E.00975
G1 X87.564 Y97.852 E.00682
G1 X87.804 Y98.068 E.00684
G1 X88.091 Y98.417 E.00955
G1 X88.256 Y98.694 E.00683
G1 X88.385 Y98.982 E.00667
G1 X88.51 Y99.432 E.0099
G1 X88.552 Y99.901 E.00996
G1 X88.51 Y100.369 E.00995
G1 X88.388 Y100.813 E.00975
G1 X88.256 Y101.108 E.00683
G1 X88.091 Y101.385 E.00683
G1 X87.798 Y101.741 E.00975
G1 X87.44 Y102.045 E.00995
G1 X87.041 Y102.275 E.00975
G1 X86.74 Y102.393 E.00683
G1 X86.428 Y102.474 E.00683
G1 X85.97 Y102.522 E.00975
G1 X85.51 Y102.488 E.00975
G1 X85.196 Y102.416 E.00683
G1 X84.892 Y102.307 E.00683
G1 X84.883 Y102.303 E.00021
M204 S250
G1 X85.024 Y101.914 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X84.713 Y101.746 E.00696
G1 X84.403 Y101.499 E.0078
G1 X84.142 Y101.2 E.0078
G1 X83.937 Y100.856 E.00787
G1 X83.839 Y100.615 E.00512
G1 X83.768 Y100.357 E.00526
G1 X83.721 Y99.967 E.00773
G1 X83.744 Y99.571 E.0078
G1 X83.84 Y99.183 E.00787
G1 X83.939 Y98.942 E.00512
G1 X84.069 Y98.708 E.00526
G1 X84.308 Y98.4 E.00768
G1 X84.501 Y98.215 E.00526
G1 X84.715 Y98.054 E.00526
G1 X85.062 Y97.868 E.00774
G1 X85.439 Y97.745 E.0078
G1 X85.835 Y97.693 E.00787
G1 X86.096 Y97.697 E.00512
G1 X86.361 Y97.733 E.00526
G1 X86.738 Y97.843 E.00774
G1 X87.09 Y98.019 E.00774
G1 X87.309 Y98.173 E.00526
G1 X87.508 Y98.352 E.00527
G1 X87.755 Y98.653 E.00767
G1 X87.892 Y98.883 E.00527
G1 X87.999 Y99.121 E.00512
G1 X88.106 Y99.506 E.00787
G1 X88.141 Y99.901 E.0078
G1 X88.106 Y100.296 E.00779
G1 X88.001 Y100.675 E.00774
G1 X87.892 Y100.919 E.00526
G1 X87.755 Y101.149 E.00526
G1 X87.506 Y101.452 E.00773
G1 X87.203 Y101.709 E.0078
G1 X86.863 Y101.905 E.00773
G1 X86.614 Y102.003 E.00526
G1 X86.355 Y102.07 E.00526
G1 X85.964 Y102.111 E.00774
G1 X85.572 Y102.082 E.00773
G1 X85.311 Y102.023 E.00526
G1 X85.078 Y101.939 E.00485
; WIPE_START
M204 S6000
G1 X84.713 Y101.746 E-.07859
G1 X84.403 Y101.499 E-.07533
G1 X84.142 Y101.2 E-.07534
G1 X83.937 Y100.856 E-.07602
G1 X83.839 Y100.615 E-.04949
G1 X83.804 Y100.487 E-.02523
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X84.765 Y96.12 Z6.12 F18000
G1 Z5.72
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X92.496 Y96.12 E.16364
G1 X92.561 Y95.406 E.01518
G1 X92.605 Y95.261 E.0032
G1 X92.652 Y95.177 E.00204
G1 X92.788 Y95.036 E.00414
G1 X92.919 Y94.964 E.00318
G1 X93.013 Y94.935 E.00208
G1 X93.217 Y94.929 E.00431
G1 X93.317 Y94.953 E.00218
G1 X93.496 Y95.052 E.00433
G1 X93.569 Y95.124 E.00218
G1 X93.629 Y95.207 E.00217
G1 X93.699 Y95.395 E.00425
G1 X93.708 Y95.493 E.00208
G1 X93.69 Y95.638 E.00308
G1 X93.642 Y95.77 E.00298
G1 X93.516 Y95.933 E.00435
G1 X93.374 Y96.027 E.00361
G1 X93.176 Y96.107 E.00453
G1 X92.999 Y96.272 E.00512
G1 X92.866 Y96.364 E.0034
G1 X92.728 Y96.427 E.00322
G1 X92.582 Y96.466 E.00321
G1 X92.404 Y96.482 E.00378
G1 X87.428 Y96.482 E.10532
M73 P95 R1
G1 X88.613 Y97.845 E.03824
G1 X88.936 Y98.356 E.0128
G1 X89.098 Y98.72 E.00842
G1 X89.257 Y99.3 E.01274
G1 X89.31 Y99.902 E.0128
G1 X89.26 Y100.488 E.01245
G1 X89.102 Y101.07 E.01275
G1 X88.849 Y101.606 E.01254
G1 X88.496 Y102.103 E.01291
G1 X88.065 Y102.522 E.01272
G1 X87.727 Y102.763 E.00878
G1 X87.379 Y102.955 E.00842
G1 X86.823 Y103.161 E.01255
G1 X86.231 Y103.268 E.01273
G1 X85.63 Y103.267 E.01273
G1 X85.047 Y103.164 E.01254
G1 X84.658 Y103.032 E.00869
G1 X84.296 Y102.859 E.00849
G1 X83.957 Y102.644 E.0085
G1 X83.646 Y102.391 E.00849
G1 X83.367 Y102.103 E.00849
G1 X83.124 Y101.783 E.0085
G1 X82.92 Y101.437 E.00849
G1 X82.756 Y101.061 E.00869
G1 X82.602 Y100.489 E.01254
G1 X82.556 Y100.091 E.00849
G1 X82.574 Y99.499 E.01254
G1 X82.648 Y99.095 E.00869
G1 X82.767 Y98.712 E.00849
G1 X82.93 Y98.346 E.00848
G1 X83.143 Y97.99 E.00877
G1 X83.386 Y97.675 E.00842
G1 X84.489 Y96.482 E.03439
G1 X79.467 Y96.482 E.10629
G1 X79.135 Y96.429 E.00711
G1 X78.991 Y96.362 E.00335
G1 X78.862 Y96.271 E.00335
G1 X78.731 Y96.133 E.00403
G1 X78.652 Y96.006 E.00315
G1 X78.578 Y95.802 E.0046
G1 X78.55 Y95.565 E.00506
G1 X78.55 Y77.62 E.37982
G1 X78.591 Y77.34 E.00597
G1 X78.697 Y77.118 E.00521
G1 X78.859 Y76.933 E.00521
G1 X79.078 Y76.796 E.00547
G1 X79.228 Y76.746 E.00334
G1 X79.388 Y76.723 E.00344
G1 X92.468 Y76.723 E.27685
G1 X92.634 Y76.746 E.00354
G1 X92.779 Y76.794 E.00323
G1 X92.955 Y76.889 E.00424
G1 X92.906 Y77.082 E.0042
G1 X79.886 Y77.082 E.2756
G1 X79.627 Y77.119 E.00552
G1 X79.316 Y77.276 E.00737
G1 X79.077 Y77.529 E.00737
G1 X78.948 Y77.807 E.00649
G1 X78.911 Y78.056 E.00533
G1 X78.911 Y95.155 E.36192
G1 X78.964 Y95.453 E.0064
G1 X79.152 Y95.778 E.00796
G1 X79.512 Y96.047 E.00951
G1 X79.867 Y96.12 E.00768
G1 X84.705 Y96.12 E.10239
; WIPE_START
M204 S6000
G1 X86.705 Y96.12 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X83.554 Y96.891 Z6.12 F18000
G1 Z5.72
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X79.443 Y96.891 E.08086
G1 X79.128 Y96.854 E.00625
G1 X78.988 Y96.812 E.00286
G1 X78.786 Y96.717 E.00439
G1 X78.603 Y96.59 E.00439
G1 X78.492 Y96.486 E.00299
G1 X78.398 Y96.373 E.00288
G1 X78.282 Y96.186 E.00433
G1 X78.177 Y95.898 E.00604
G1 X78.141 Y95.589 E.00612
G1 X78.141 Y77.607 E.35368
G1 X78.15 Y77.45 E.00311
G1 X78.196 Y77.228 E.00445
G1 X78.245 Y77.093 E.00283
G1 X78.353 Y76.892 E.00448
G1 X78.495 Y76.714 E.00448
G1 X78.599 Y76.615 E.00283
G1 X78.788 Y76.483 E.00453
G1 X78.921 Y76.416 E.00292
G1 X79.133 Y76.346 E.00439
G1 X79.359 Y76.313 E.00448
G1 X92.498 Y76.313 E.25843
G1 X92.728 Y76.347 E.00458
G1 X92.941 Y76.417 E.00442
G1 X93.139 Y76.524 E.00442
G1 X93.315 Y76.663 E.00442
G1 X93.465 Y76.831 E.00442
G1 X93.583 Y77.022 E.00442
G1 X93.666 Y77.231 E.00442
G1 X93.71 Y77.448 E.00436
G1 X93.72 Y88.791 E.2231
G1 X92.541 Y88.791 E.02321
G1 X92.541 Y77.491 E.22226
G1 X79.915 Y77.491 E.24833
G1 X79.752 Y77.515 E.00325
G1 X79.564 Y77.609 E.00413
G1 X79.42 Y77.762 E.00413
G1 X79.344 Y77.925 E.00355
G1 X79.321 Y78.086 E.00319
G1 X79.321 Y95.119 E.33503
G1 X79.354 Y95.311 E.00382
G1 X79.464 Y95.501 E.00431
G1 X79.684 Y95.664 E.00539
G1 X79.909 Y95.711 E.00452
G1 X92.122 Y95.711 E.24022
G1 X92.157 Y95.327 E.00759
G1 X92.226 Y95.101 E.00464
G1 X92.311 Y94.947 E.00346
G1 X92.422 Y94.811 E.00345
G1 X92.553 Y94.698 E.0034
G1 X92.758 Y94.585 E.00462
G1 X92.928 Y94.533 E.0035
G1 X93.103 Y94.512 E.00345
G1 X93.278 Y94.523 E.00345
G1 X93.449 Y94.564 E.00346
G1 X93.609 Y94.635 E.00345
G1 X93.755 Y94.734 E.00346
G1 X93.881 Y94.856 E.00346
G1 X93.983 Y94.999 E.00345
G1 X94.059 Y95.158 E.00346
G1 X94.103 Y95.323 E.00335
G1 X94.119 Y95.5 E.0035
G1 X94.091 Y95.735 E.00466
G1 X94.011 Y95.952 E.00455
G1 X93.916 Y96.102 E.0035
G1 X93.709 Y96.304 E.00568
G1 X93.556 Y96.394 E.00349
G1 X93.4 Y96.458 E.00332
G1 X93.256 Y96.592 E.00386
G1 X93.07 Y96.72 E.00444
G1 X92.868 Y96.814 E.00439
G1 X92.652 Y96.871 E.00438
G1 X92.421 Y96.891 E.00456
G1 X88.326 Y96.891 E.08055
G1 X88.934 Y97.59 E.01822
G1 X89.063 Y97.767 E.0043
G1 X89.3 Y98.168 E.00917
G1 X89.479 Y98.57 E.00865
G1 X89.55 Y98.777 E.00431
G1 X89.659 Y99.22 E.00897
G1 X89.692 Y99.436 E.0043
G1 X89.72 Y99.902 E.00917
G1 X89.695 Y100.341 E.00865
G1 X89.663 Y100.56 E.00436
G1 X89.614 Y100.79 E.00463
G1 X89.486 Y101.212 E.00865
G1 X89.305 Y101.627 E.00891
G1 X89.2 Y101.818 E.0043
G1 X88.945 Y102.197 E.00898
G1 X88.647 Y102.543 E.00898
G1 X88.323 Y102.84 E.00865
G1 X87.946 Y103.11 E.00911
G1 X87.561 Y103.322 E.00865
G1 X87.361 Y103.411 E.00431
G1 X86.931 Y103.556 E.00892
G1 X86.488 Y103.649 E.00891
G1 X86.268 Y103.676 E.00437
G1 X86.046 Y103.689 E.00436
G1 X85.593 Y103.676 E.00891
G1 X85.145 Y103.608 E.00891
G1 X84.933 Y103.557 E.0043
G1 X84.504 Y103.412 E.00891
G1 X84.098 Y103.218 E.00885
G1 X83.717 Y102.977 E.00885
G1 X83.368 Y102.693 E.00885
G1 X83.056 Y102.37 E.00885
G1 X82.783 Y102.011 E.00885
G1 X82.555 Y101.624 E.00885
G1 X82.374 Y101.209 E.00891
G1 X82.304 Y101.001 E.0043
G1 X82.199 Y100.56 E.00891
G1 X82.147 Y100.114 E.00885
G1 X82.148 Y99.661 E.00891
G1 X82.169 Y99.443 E.00431
G1 X82.25 Y98.997 E.00891
G1 X82.383 Y98.567 E.00885
G1 X82.566 Y98.157 E.00884
G1 X82.805 Y97.759 E.00911
G1 X83.073 Y97.411 E.00866
G1 X83.513 Y96.935 E.01274
; WIPE_START
M204 S6000
G1 X81.513 Y96.913 E-.38
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




G1 X79.367 Y96.256
G1 Z5.72
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.148285
G1 F1500
M204 S6000
G1 X79.135 Y96.117 E.00166
G1 X78.955 Y95.97 E.00142
G1 X78.778 Y95.627 E.00236
; WIPE_START
G1 X78.955 Y95.97 E-.16489
G1 X79.135 Y96.117 E-.09942
G1 X79.367 Y96.256 E-.1157
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X84.543 Y97.134 Z6.12 F18000
G1 Z5.72
G1 E.4 F1800
; LINE_WIDTH: 0.471159
G1 F1500
M204 S6000
G1 X84.253 Y97.36 E.00816
; LINE_WIDTH: 0.431876
G1 X84.122 Y97.478 E.00357
; LINE_WIDTH: 0.397996
G1 X83.976 Y97.611 E.00367
; LINE_WIDTH: 0.359973
G1 X83.713 Y97.88 E.00628
G1 X83.406 Y98.285 E.00847
G1 X83.269 Y98.522 E.00456
G1 X83.124 Y98.846 E.00591
G1 X83.022 Y99.187 E.00593
G1 X82.954 Y99.546 E.00609
G1 X82.934 Y100.005 E.00767
G1 X82.992 Y100.497 E.00826
G1 X83.098 Y100.878 E.00659
G1 X83.261 Y101.266 E.00701
G1 X83.513 Y101.674 E.008
G1 X83.869 Y102.079 E.00898
G1 X84.267 Y102.395 E.00848
G1 X84.75 Y102.657 E.00917
G1 X85.1 Y102.778 E.00618
G1 X85.466 Y102.862 E.00627
G1 X85.961 Y102.9 E.00826
G1 X86.483 Y102.847 E.00876
G1 X86.847 Y102.753 E.00627
G1 X87.215 Y102.612 E.00657
G1 X87.644 Y102.361 E.00829
G1 X88.054 Y102.013 E.00896
G1 X88.204 Y101.852 E.00367
G1 X88.521 Y101.409 E.00908
G1 X88.746 Y100.936 E.00874
G1 X88.845 Y100.596 E.00591
G1 X88.905 Y100.258 E.00572
G1 X88.931 Y99.903 E.00594
G1 X88.875 Y99.351 E.00926
G1 X88.789 Y99.004 E.00596
G1 X88.599 Y98.531 E.0085
G1 X88.39 Y98.191 E.00664
G1 X88.07 Y97.797 E.00847
; LINE_WIDTH: 0.382527
G1 X87.806 Y97.53 E.00668
; LINE_WIDTH: 0.426978
G1 X87.681 Y97.417 E.00337
; LINE_WIDTH: 0.468123
G1 X87.556 Y97.304 E.00372
G1 X87.534 Y97.308 E.0005
; LINE_WIDTH: 0.443257
G1 X87.374 Y97.338 E.00338
; LINE_WIDTH: 0.416507
G1 X87.215 Y97.367 E.00316
; WIPE_START
G1 X87.374 Y97.338 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X92.708 Y96.133 Z6.12 F18000
G1 Z5.72
G1 E.4 F1800
; LINE_WIDTH: 0.127664
G1 F1500
M204 S6000
G1 X92.836 Y96.068 E.00073
; LINE_WIDTH: 0.100523
G1 X92.956 Y95.992 E.00053
; WIPE_START
G1 X92.836 Y96.068 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X88.215 Y89.994 Z6.12 F18000
G1 X78.785 Y77.601 Z6.12
G1 Z5.72
G1 E.4 F1800
; LINE_WIDTH: 0.0995435
G1 F1500
M204 S6000
G1 X78.855 Y77.388 E.00083
; LINE_WIDTH: 0.157064
G1 X78.931 Y77.274 E.00089
G1 X79.135 Y77.071 E.00188
; LINE_WIDTH: 0.129356
G1 X79.288 Y77 E.00087
; LINE_WIDTH: 0.0983132
G1 X79.435 Y76.955 E.00055
; CHANGE_LAYER
; Z_HEIGHT: 5.84
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F1500
G1 X79.288 Y77 E-.38
; WIPE_END
G1 E-.02 F1800
; layer num/total_layer_count: 48/49
; update layer progress
M73 L48
M991 S0 P47 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z6.12 I-.301 J1.179 P1  F18000
G1 X93.304 Y80.581 Z6.12
G1 Z5.84
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X93.311 Y88.382 E.1651
G1 X92.95 Y88.382 E.00764
G1 X92.95 Y77.128 E.23818
G1 X93.135 Y77.076 E.00407
G1 X93.216 Y77.207 E.00325
G1 X93.272 Y77.349 E.00324
G1 X93.301 Y77.49 E.00305
G1 X93.304 Y80.521 E.06415
; WIPE_START
M204 S6000
G1 X93.306 Y82.521 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X93.293 Y90.154 Z6.24 F18000
G1 X93.284 Y95.469 Z6.24
G1 Z5.84
G1 E.4 F1800
G1 F1500
M204 S500
G1 X93.249 Y95.607 E.00301
G1 X92.957 Y95.738 E.00678
G1 X92.979 Y95.488 E.00531
G1 X93.006 Y95.4 E.00195
G1 X93.102 Y95.347 E.00232
G1 X93.153 Y95.35 E.00108
G1 X93.227 Y95.383 E.0017
G1 X93.251 Y95.419 E.00092
; WIPE_START
M204 S6000
G1 X93.249 Y95.607 E-.06289
G1 X92.957 Y95.738 E-.10719
G1 X92.979 Y95.488 E-.08387
G1 X93.006 Y95.4 E-.03089
G1 X93.102 Y95.347 E-.03667
G1 X93.153 Y95.35 E-.01704
G1 X93.227 Y95.383 E-.02688
G1 X93.251 Y95.419 E-.01456
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X85.763 Y96.899 Z6.24 F18000
G1 X84.696 Y97.11 Z6.24
G1 Z5.84
G1 E.4 F1800
G1 F1500
M204 S500
G1 X84.589 Y96.949 E.0041
G1 X84.941 Y96.544 E.01135
G1 X86.92 Y96.544 E.04187
G1 X87.271 Y96.948 E.01133
G1 X87.143 Y97.113 E.00443
G1 X87.044 Y97.064 E.00234
G1 X86.535 Y96.915 E.01122
G1 X86.158 Y96.864 E.00804
G1 X85.784 Y96.858 E.00793
G1 X85.253 Y96.929 E.01133
G1 X84.753 Y97.092 E.01113
; WIPE_START
M204 S6000
G1 X84.589 Y96.949 E-.04131
G1 X84.941 Y96.544 E-.10187
G1 X86.188 Y96.544 E-.23681
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X84.859 Y102.288 Z6.24 F18000
G1 Z5.84
G1 E.4 F1800
G1 F1500
M204 S500
G1 X84.758 Y102.244 E.00232
G1 X84.483 Y102.086 E.00673
G1 X84.119 Y101.796 E.00984
G1 X83.809 Y101.442 E.00997
G1 X83.571 Y101.042 E.00985
G1 X83.451 Y100.748 E.00673
G1 X83.365 Y100.437 E.00683
G1 X83.31 Y99.979 E.00975
G1 X83.338 Y99.51 E.00995
G1 X83.45 Y99.054 E.00995
G1 X83.637 Y98.633 E.00975
G1 X83.811 Y98.361 E.00683
G1 X84.016 Y98.112 E.00683
G1 X84.351 Y97.809 E.00956
G1 X84.62 Y97.632 E.00683
M73 P95 R0
G1 X84.909 Y97.487 E.00683
G1 X85.348 Y97.345 E.00976
G1 X85.809 Y97.283 E.00984
G1 X86.127 Y97.288 E.00673
G1 X86.446 Y97.331 E.00683
G1 X86.888 Y97.46 E.00975
M73 P96 R0
G1 X87.3 Y97.666 E.00975
G1 X87.564 Y97.852 E.00683
G1 X87.804 Y98.068 E.00684
G1 X88.091 Y98.417 E.00955
G1 X88.256 Y98.694 E.00683
G1 X88.386 Y98.984 E.00673
G1 X88.51 Y99.432 E.00985
G1 X88.551 Y99.892 E.00976
G1 X88.532 Y100.214 E.00683
G1 X88.475 Y100.531 E.00683
G1 X88.326 Y100.967 E.00975
G1 X88.097 Y101.378 E.00994
G1 X87.798 Y101.741 E.00995
G1 X87.44 Y102.045 E.00995
G1 X87.041 Y102.275 E.00975
G1 X86.74 Y102.393 E.00683
G1 X86.428 Y102.474 E.00683
G1 X85.97 Y102.522 E.00975
G1 X85.501 Y102.487 E.00996
G1 X85.051 Y102.37 E.00984
G1 X84.915 Y102.311 E.00313
M204 S250
G1 X85.02 Y101.911 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X84.942 Y101.878 E.00168
G1 X84.714 Y101.746 E.00517
G1 X84.403 Y101.499 E.00782
G1 X84.142 Y101.2 E.0078
G1 X83.938 Y100.859 E.00782
G1 X83.839 Y100.615 E.00517
G1 X83.768 Y100.357 E.00526
G1 X83.721 Y99.967 E.00773
G1 X83.744 Y99.571 E.0078
G1 X83.838 Y99.186 E.0078
G1 X83.998 Y98.827 E.00773
G1 X84.142 Y98.602 E.00526
G1 X84.312 Y98.395 E.00526
G1 X84.602 Y98.134 E.00767
G1 X84.825 Y97.987 E.00526
G1 X85.065 Y97.867 E.00526
G1 X85.439 Y97.745 E.00774
G1 X85.833 Y97.693 E.00782
G1 X86.096 Y97.697 E.00517
G1 X86.361 Y97.733 E.00526
G1 X86.738 Y97.843 E.00773
G1 X87.09 Y98.019 E.00773
G1 X87.309 Y98.173 E.00526
G1 X87.508 Y98.352 E.00527
G1 X87.755 Y98.653 E.00767
G1 X87.892 Y98.883 E.00526
G1 X88 Y99.123 E.00517
G1 X88.106 Y99.506 E.00782
G1 X88.141 Y99.898 E.00774
G1 X88.125 Y100.165 E.00526
G1 X88.077 Y100.428 E.00526
G1 X87.95 Y100.8 E.00774
G1 X87.757 Y101.146 E.00779
G1 X87.506 Y101.452 E.0078
G1 X87.203 Y101.709 E.0078
G1 X86.863 Y101.905 E.00773
G1 X86.614 Y102.003 E.00526
G1 X86.355 Y102.07 E.00526
G1 X85.964 Y102.111 E.00774
G1 X85.568 Y102.082 E.0078
G1 X85.184 Y101.981 E.00782
G1 X85.076 Y101.935 E.00231
; WIPE_START
M204 S6000
G1 X84.942 Y101.878 E-.02765
G1 X84.714 Y101.746 E-.04996
G1 X84.403 Y101.499 E-.07552
G1 X84.142 Y101.2 E-.07538
G1 X83.938 Y100.859 E-.07555
G1 X83.839 Y100.615 E-.04995
G1 X83.802 Y100.483 E-.02599
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X84.692 Y96.12 Z6.24 F18000
G1 Z5.84
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X92.497 Y96.12 E.1652
G1 X92.561 Y95.407 E.01516
G1 X92.605 Y95.261 E.00323
G1 X92.651 Y95.177 E.00202
G1 X92.787 Y95.037 E.00414
G1 X92.92 Y94.963 E.00322
G1 X93.013 Y94.935 E.00204
G1 X93.217 Y94.929 E.00432
G1 X93.316 Y94.953 E.00217
G1 X93.495 Y95.052 E.00433
G1 X93.569 Y95.124 E.00218
G1 X93.629 Y95.207 E.00217
G1 X93.699 Y95.396 E.00427
G1 X93.708 Y95.493 E.00205
G1 X93.691 Y95.638 E.00308
G1 X93.641 Y95.771 E.00301
G1 X93.516 Y95.934 E.00435
G1 X93.373 Y96.027 E.00361
G1 X93.184 Y96.104 E.00431
G1 X92.874 Y96.36 E.00851
G1 X92.729 Y96.427 E.0034
G1 X92.582 Y96.466 E.00322
G1 X92.404 Y96.482 E.00378
G1 X87.428 Y96.482 E.10533
G1 X88.613 Y97.845 E.03824
G1 X88.726 Y98 E.00406
G1 X89.018 Y98.525 E.01272
G1 X89.161 Y98.909 E.00867
G1 X89.285 Y99.48 E.01237
G1 X89.306 Y100.081 E.01272
G1 X89.257 Y100.497 E.00887
G1 X89.103 Y101.069 E.01255
G1 X88.84 Y101.622 E.01294
G1 X88.743 Y101.776 E.00386
G1 X88.366 Y102.245 E.01273
G1 X88.064 Y102.522 E.00867
G1 X87.731 Y102.761 E.00868
G1 X87.379 Y102.955 E.00851
G1 X86.814 Y103.164 E.01274
G1 X86.222 Y103.269 E.01273
G1 X85.63 Y103.267 E.01254
G1 X85.047 Y103.164 E.01254
G1 X84.658 Y103.032 E.00869
G1 X84.296 Y102.859 E.00848
G1 X83.95 Y102.639 E.00867
G1 X83.508 Y102.258 E.01237
G1 X83.24 Y101.947 E.00869
G1 X83.017 Y101.613 E.00849
G1 X82.835 Y101.256 E.00848
G1 X82.694 Y100.872 E.00867
G1 X82.574 Y100.3 E.01237
G1 X82.551 Y99.89 E.00869
G1 X82.576 Y99.49 E.00849
G1 X82.648 Y99.095 E.0085
G1 X82.767 Y98.711 E.00849
G1 X82.934 Y98.337 E.00867
G1 X83.254 Y97.838 E.01255
G1 X84.434 Y96.482 E.03805
G1 X79.467 Y96.482 E.10513
G1 X79.219 Y96.453 E.00527
G1 X79.074 Y96.405 E.00324
G1 X78.86 Y96.27 E.00534
G1 X78.731 Y96.133 E.004
G1 X78.652 Y96.005 E.00318
G1 X78.578 Y95.803 E.00456
G1 X78.55 Y95.565 E.00507
G1 X78.55 Y77.619 E.37983
G1 X78.591 Y77.341 E.00596
G1 X78.697 Y77.118 E.00521
G1 X78.86 Y76.932 E.00526
G1 X78.991 Y76.84 E.00338
G1 X79.138 Y76.772 E.00342
G1 X79.388 Y76.723 E.0054
G1 X92.47 Y76.723 E.27688
G1 X92.633 Y76.746 E.0035
G1 X92.779 Y76.794 E.00323
G1 X92.955 Y76.889 E.00424
G1 X92.906 Y77.082 E.0042
G1 X79.885 Y77.082 E.2756
G1 X79.627 Y77.12 E.00553
G1 X79.316 Y77.276 E.00736
G1 X79.077 Y77.529 E.00736
G1 X78.948 Y77.807 E.00649
G1 X78.911 Y78.056 E.00533
G1 X78.911 Y95.155 E.36192
G1 X78.964 Y95.453 E.0064
G1 X79.152 Y95.778 E.00796
G1 X79.512 Y96.047 E.00951
G1 X79.867 Y96.12 E.00767
G1 X84.632 Y96.12 E.10084
; WIPE_START
M204 S6000
G1 X86.632 Y96.12 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X83.535 Y96.891 Z6.24 F18000
G1 Z5.84
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X79.443 Y96.891 E.08049
G1 X79.13 Y96.854 E.00619
G1 X78.917 Y96.784 E.00442
G1 X78.788 Y96.719 E.00283
G1 X78.602 Y96.589 E.00448
G1 X78.492 Y96.486 E.00295
G1 X78.398 Y96.373 E.00288
G1 X78.281 Y96.185 E.00436
G1 X78.177 Y95.898 E.006
G1 X78.141 Y95.589 E.00613
G1 X78.141 Y77.607 E.35368
G1 X78.15 Y77.451 E.00307
G1 X78.196 Y77.228 E.00448
G1 X78.247 Y77.09 E.00289
G1 X78.353 Y76.893 E.00442
G1 X78.495 Y76.714 E.00448
G1 X78.602 Y76.613 E.00289
G1 X78.786 Y76.484 E.00442
G1 X78.992 Y76.388 E.00448
G1 X79.133 Y76.346 E.00289
G1 X79.359 Y76.313 E.00448
G1 X92.499 Y76.313 E.25847
G1 X92.728 Y76.346 E.00454
G1 X92.941 Y76.417 E.00442
G1 X93.139 Y76.524 E.00442
G1 X93.315 Y76.663 E.00442
G1 X93.465 Y76.831 E.00442
G1 X93.583 Y77.022 E.00442
G1 X93.666 Y77.231 E.00442
G1 X93.71 Y77.448 E.00436
G1 X93.72 Y88.791 E.2231
G1 X92.541 Y88.791 E.02321
G1 X92.541 Y77.491 E.22226
G1 X79.915 Y77.491 E.24833
G1 X79.752 Y77.515 E.00325
G1 X79.564 Y77.609 E.00412
G1 X79.42 Y77.762 E.00413
G1 X79.344 Y77.925 E.00355
G1 X79.321 Y78.086 E.00319
G1 X79.321 Y95.119 E.33504
G1 X79.354 Y95.311 E.00382
G1 X79.464 Y95.501 E.00431
G1 X79.684 Y95.664 E.00539
G1 X79.909 Y95.711 E.00452
G1 X92.123 Y95.711 E.24023
G1 X92.157 Y95.328 E.00757
G1 X92.226 Y95.1 E.00467
G1 X92.311 Y94.947 E.00343
G1 X92.422 Y94.811 E.00345
G1 X92.552 Y94.699 E.00339
G1 X92.76 Y94.584 E.00466
G1 X92.928 Y94.533 E.00346
G1 X93.102 Y94.512 E.00345
G1 X93.278 Y94.523 E.00345
G1 X93.448 Y94.564 E.00345
G1 X93.609 Y94.635 E.00345
G1 X93.755 Y94.733 E.00346
G1 X93.881 Y94.856 E.00346
G1 X93.983 Y94.999 E.00345
G1 X94.058 Y95.158 E.00346
G1 X94.104 Y95.323 E.00338
G1 X94.119 Y95.499 E.00347
G1 X94.091 Y95.735 E.00466
G1 X94.01 Y95.953 E.00458
G1 X93.916 Y96.102 E.00346
G1 X93.709 Y96.303 E.00568
G1 X93.555 Y96.395 E.00353
G1 X93.402 Y96.457 E.00324
G1 X93.192 Y96.641 E.0055
G1 X93.073 Y96.719 E.00281
G1 X92.868 Y96.814 E.00444
G1 X92.653 Y96.871 E.00438
G1 X92.421 Y96.891 E.00456
G1 X88.326 Y96.891 E.08055
G1 X88.934 Y97.59 E.01822
G1 X89.184 Y97.957 E.00873
G1 X89.392 Y98.359 E.00891
G1 X89.553 Y98.788 E.00902
G1 X89.659 Y99.22 E.00874
G1 X89.692 Y99.437 E.00431
G1 X89.72 Y99.892 E.00897
G1 X89.715 Y100.11 E.0043
G1 X89.661 Y100.569 E.00908
G1 X89.557 Y101.001 E.00874
G1 X89.4 Y101.425 E.0089
G1 X89.196 Y101.824 E.00881
G1 X89.08 Y102.009 E.0043
G1 X88.804 Y102.372 E.00897
G1 X88.656 Y102.534 E.0043
G1 X88.323 Y102.84 E.00891
G1 X87.95 Y103.107 E.00902
G1 X87.561 Y103.322 E.00874
G1 X87.361 Y103.411 E.00431
G1 X86.928 Y103.557 E.00897
G1 X86.716 Y103.608 E.0043
G1 X86.265 Y103.676 E.00898
G1 X86.046 Y103.689 E.0043
G1 X85.593 Y103.676 E.00891
G1 X85.145 Y103.608 E.00891
G1 X84.933 Y103.557 E.0043
G1 X84.504 Y103.412 E.00891
G1 X84.098 Y103.218 E.00885
G1 X83.711 Y102.972 E.00902
G1 X83.366 Y102.691 E.00874
G1 X83.209 Y102.538 E.00431
G1 X82.914 Y102.195 E.00891
G1 X82.663 Y101.821 E.00885
G1 X82.459 Y101.42 E.00885
G1 X82.301 Y100.99 E.00902
G1 X82.198 Y100.558 E.00874
G1 X82.166 Y100.341 E.00431
G1 X82.141 Y99.889 E.00891
G1 X82.169 Y99.44 E.00885
G1 X82.25 Y98.997 E.00885
G1 X82.383 Y98.567 E.00885
G1 X82.568 Y98.154 E.00891
G1 X82.679 Y97.955 E.00447
G1 X82.929 Y97.588 E.00874
G1 X83.496 Y96.936 E.01698
; WIPE_START
M204 S6000
G1 X81.496 Y96.914 E-.38
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




G1 X79.316 Y96.244
G1 Z5.84
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.148084
G1 F1500
M204 S6000
G1 X78.955 Y95.97 E.00277
G1 X78.778 Y95.627 E.00236
; WIPE_START
G1 X78.955 Y95.97 E-.17471
G1 X79.316 Y96.244 E-.20529
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X84.478 Y97.165 Z6.24 F18000
G1 Z5.84
G1 E.4 F1800
; LINE_WIDTH: 0.477089
G1 F1500
M204 S6000
G1 X84.297 Y97.319 E.00534
; LINE_WIDTH: 0.438351
G1 X84.09 Y97.496 E.00562
; LINE_WIDTH: 0.400951
G1 X83.921 Y97.669 E.00453
; LINE_WIDTH: 0.359773
G1 X83.557 Y98.069 E.00901
G1 X83.311 Y98.444 E.00746
G1 X83.125 Y98.846 E.00739
G1 X83.022 Y99.187 E.00593
G1 X82.955 Y99.536 E.00593
G1 X82.936 Y100.005 E.00782
G1 X82.998 Y100.522 E.00867
G1 X83.091 Y100.86 E.00585
G1 X83.185 Y101.104 E.00435
G1 X83.348 Y101.418 E.00591
G1 X83.542 Y101.714 E.00589
G1 X83.896 Y102.105 E.00878
G1 X84.281 Y102.404 E.00813
G1 X84.581 Y102.577 E.00577
G1 X84.941 Y102.728 E.0065
G1 X85.424 Y102.856 E.00833
G1 X85.961 Y102.9 E.00897
G1 X86.483 Y102.844 E.00875
G1 X86.847 Y102.753 E.00625
G1 X87.215 Y102.612 E.00657
G1 X87.644 Y102.361 E.00829
G1 X88.057 Y102.016 E.00896
G1 X88.192 Y101.866 E.00338
G1 X88.507 Y101.429 E.00897
G1 X88.673 Y101.106 E.00605
G1 X88.833 Y100.637 E.00826
G1 X88.903 Y100.268 E.00626
G1 X88.931 Y99.898 E.00618
G1 X88.884 Y99.368 E.00887
G1 X88.744 Y98.868 E.00866
G1 X88.595 Y98.529 E.00618
G1 X88.392 Y98.19 E.00659
G1 X88.07 Y97.797 E.00847
; LINE_WIDTH: 0.38252
G1 X87.806 Y97.53 E.00667
; LINE_WIDTH: 0.426951
G1 X87.681 Y97.417 E.00338
; LINE_WIDTH: 0.468113
G1 X87.556 Y97.304 E.00372
G1 X87.534 Y97.308 E.0005
; LINE_WIDTH: 0.443274
G1 X87.374 Y97.338 E.00338
; LINE_WIDTH: 0.416512
G1 X87.215 Y97.367 E.00316
; WIPE_START
G1 X87.374 Y97.338 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X92.708 Y96.134 Z6.24 F18000
G1 Z5.84
G1 E.4 F1800
; LINE_WIDTH: 0.130569
G1 F1500
M204 S6000
G1 X92.87 Y96.045 E.00096
; LINE_WIDTH: 0.0943617
G1 X92.956 Y95.992 E.00035
; WIPE_START
G1 X92.87 Y96.045 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X88.238 Y89.979 Z6.24 F18000
G1 X78.785 Y77.601 Z6.24
G1 Z5.84
G1 E.4 F1800
; LINE_WIDTH: 0.0993566
G1 F1500
M204 S6000
G1 X78.856 Y77.387 E.00083
; LINE_WIDTH: 0.149527
G1 X79.043 Y77.151 E.00186
G1 X79.147 Y77.065 E.00083
G1 X79.28 Y77.002 E.00091
; LINE_WIDTH: 0.0997428
G1 X79.435 Y76.955 E.0006
; CHANGE_LAYER
; Z_HEIGHT: 5.96
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F1500
G1 X79.28 Y77.002 E-.38
; WIPE_END
G1 E-.02 F1800
; layer num/total_layer_count: 49/49
; update layer progress
M73 L49
M991 S0 P48 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z6.24 I-1.186 J.273 P1  F18000
G1 X85.023 Y101.913 Z6.24
G1 Z5.96
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X84.713 Y101.746 E.00694
G1 X84.403 Y101.499 E.00779
G1 X84.142 Y101.2 E.0078
G1 X83.94 Y100.861 E.00777
G1 X83.839 Y100.616 E.00522
G1 X83.768 Y100.359 E.00523
G1 X83.721 Y99.967 E.00777
G1 X83.744 Y99.572 E.00779
G1 X83.838 Y99.189 E.00774
G1 X83.939 Y98.942 E.00527
G1 X84.069 Y98.708 E.00526
G1 X84.308 Y98.399 E.00768
G1 X84.501 Y98.215 E.00525
G1 X84.714 Y98.055 E.00522
G1 X85.061 Y97.868 E.00777
G1 X85.439 Y97.745 E.0078
G1 X85.83 Y97.693 E.00777
G1 X86.096 Y97.697 E.00522
G1 X86.36 Y97.733 E.00525
G1 X86.738 Y97.843 E.00774
G1 X87.09 Y98.019 E.00774
G1 X87.309 Y98.173 E.00525
G1 X87.506 Y98.35 E.00523
G1 X87.757 Y98.655 E.00777
G1 X87.95 Y99.002 E.0078
G1 X88.077 Y99.374 E.00773
G1 X88.125 Y99.637 E.00526
M73 P97 R0
G1 X88.141 Y99.901 E.00521
G1 X88.125 Y100.165 E.00519
G1 X88.077 Y100.428 E.00526
G1 X87.95 Y100.8 E.00773
G1 X87.757 Y101.146 E.00779
G1 X87.505 Y101.453 E.0078
G1 X87.203 Y101.709 E.00779
G1 X86.86 Y101.907 E.00779
G1 X86.49 Y102.04 E.00774
G1 X86.228 Y102.091 E.00526
G1 X85.96 Y102.111 E.00527
G1 X85.571 Y102.082 E.00769
G1 X85.311 Y102.023 E.00525
G1 X85.077 Y101.939 E.00487
; WIPE_START
M204 S6000
G1 X84.713 Y101.746 E-.07843
G1 X84.403 Y101.499 E-.07528
G1 X84.142 Y101.2 E-.07536
G1 X83.94 Y100.861 E-.07502
G1 X83.839 Y100.616 E-.05038
G1 X83.803 Y100.486 E-.02552
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X83.535 Y96.891 Z6.36 F18000
G1 Z5.96
G1 E.4 F1800
G1 F1500
M204 S500
G1 X79.443 Y96.891 E.08049
G1 X79.127 Y96.854 E.00625
G1 X78.991 Y96.813 E.0028
G1 X78.789 Y96.719 E.00439
G1 X78.544 Y96.536 E.00601
G1 X78.395 Y96.369 E.00442
G1 X78.314 Y96.246 E.00289
G1 X78.248 Y96.114 E.00289
G1 X78.177 Y95.902 E.00439
G1 X78.141 Y95.589 E.00622
G1 X78.141 Y77.61 E.35362
G1 X78.161 Y77.374 E.00466
G1 X78.194 Y77.234 E.00283
G1 X78.28 Y77.019 E.00454
G1 X78.352 Y76.895 E.00283
G1 X78.495 Y76.714 E.00454
G1 X78.601 Y76.614 E.00286
G1 X78.786 Y76.484 E.00445
G1 X78.99 Y76.389 E.00442
G1 X79.21 Y76.33 E.00448
G1 X79.356 Y76.313 E.00289
G1 X92.501 Y76.313 E.25856
G1 X92.728 Y76.346 E.00451
G1 X92.941 Y76.417 E.00442
G1 X93.139 Y76.524 E.00442
G1 X93.315 Y76.663 E.00442
G1 X93.465 Y76.831 E.00442
G1 X93.583 Y77.022 E.00442
G1 X93.666 Y77.231 E.00442
G1 X93.71 Y77.448 E.00436
G1 X93.72 Y88.791 E.2231
G1 X92.541 Y88.791 E.02321
G1 X92.541 Y77.491 E.22226
G1 X79.912 Y77.491 E.24839
G1 X79.724 Y77.524 E.00376
G1 X79.562 Y77.611 E.00361
G1 X79.42 Y77.762 E.00407
G1 X79.344 Y77.925 E.00355
G1 X79.321 Y78.086 E.00319
G1 X79.321 Y95.119 E.33504
G1 X79.354 Y95.311 E.00382
G1 X79.464 Y95.501 E.00432
G1 X79.684 Y95.664 E.0054
G1 X79.909 Y95.711 E.00452
G1 X92.123 Y95.711 E.24023
G1 X92.157 Y95.328 E.00755
G1 X92.227 Y95.1 E.0047
G1 X92.31 Y94.948 E.00342
G1 X92.421 Y94.812 E.00346
G1 X92.552 Y94.699 E.0034
G1 X92.761 Y94.584 E.00469
G1 X92.928 Y94.533 E.00343
G1 X93.102 Y94.512 E.00345
G1 X93.277 Y94.523 E.00346
G1 X93.448 Y94.564 E.00345
G1 X93.609 Y94.635 E.00345
G1 X93.754 Y94.733 E.00345
G1 X93.88 Y94.856 E.00347
G1 X93.983 Y94.999 E.00345
G1 X94.058 Y95.157 E.00345
G1 X94.104 Y95.325 E.00343
G1 X94.119 Y95.499 E.00343
G1 X94.091 Y95.734 E.00466
G1 X94.01 Y95.953 E.0046
G1 X93.88 Y96.146 E.00458
G1 X93.704 Y96.306 E.00468
G1 X93.553 Y96.396 E.00345
G1 X93.405 Y96.455 E.00313
G1 X93.131 Y96.683 E.00702
G1 X92.936 Y96.787 E.00435
G1 X92.797 Y96.837 E.00289
G1 X92.656 Y96.871 E.00286
G1 X92.421 Y96.891 E.00462
G1 X88.307 Y96.891 E.08092
G1 X88.788 Y97.411 E.01393
G1 X89.066 Y97.772 E.00897
G1 X89.184 Y97.957 E.00431
G1 X89.392 Y98.359 E.00891
G1 X89.551 Y98.78 E.00885
G1 X89.659 Y99.22 E.00891
G1 X89.713 Y99.661 E.00873
G1 X89.714 Y100.114 E.00891
G1 X89.662 Y100.563 E.00891
G1 X89.617 Y100.782 E.00438
G1 X89.485 Y101.214 E.00889
G1 X89.402 Y101.421 E.00438
G1 X89.198 Y101.821 E.00883
G1 X88.945 Y102.198 E.00893
G1 X88.652 Y102.538 E.00883
G1 X88.322 Y102.841 E.0088
G1 X87.957 Y103.103 E.00883
G1 X87.561 Y103.322 E.00891
G1 X87.36 Y103.411 E.00431
G1 X86.929 Y103.557 E.00897
G1 X86.716 Y103.608 E.0043
G1 X86.265 Y103.676 E.00898
G1 X86.046 Y103.689 E.0043
G1 X85.593 Y103.676 E.00891
G1 X85.145 Y103.608 E.00891
G1 X84.933 Y103.557 E.0043
G1 X84.504 Y103.412 E.00891
G1 X84.097 Y103.218 E.00885
G1 X83.717 Y102.977 E.00885
G1 X83.368 Y102.693 E.00885
G1 X83.056 Y102.37 E.00885
G1 X82.781 Y102.008 E.00893
G1 X82.554 Y101.621 E.00883
G1 X82.46 Y101.423 E.00431
G1 X82.303 Y100.998 E.00891
G1 X82.199 Y100.56 E.00885
G1 X82.147 Y100.114 E.00885
G1 X82.148 Y99.661 E.00891
G1 X82.169 Y99.443 E.0043
G1 X82.251 Y98.994 E.00897
G1 X82.311 Y98.78 E.00438
G1 X82.469 Y98.359 E.00884
G1 X82.676 Y97.96 E.00885
G1 X82.929 Y97.588 E.00885
G1 X83.496 Y96.936 E.01698
; WIPE_START
M204 S6000
G1 X81.496 Y96.914 E-.38
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




G1 X92.42 Y76.53
G1 Z5.96
G1 E.4 F1800
; FEATURE: Top surface
G1 F1500
M204 S2000
G1 X93.494 Y77.604 E.02987
G1 X92.757 Y77.425
G1 X93.494 Y78.162 E.0205
G1 X93.495 Y78.72
G1 X92.757 Y77.983 E.02051
G1 X92.757 Y78.54
G1 X93.495 Y79.278 E.02052
G1 X93.496 Y79.836
G1 X92.757 Y79.098 E.02054
G1 X92.757 Y79.655
G1 X93.496 Y80.394 E.02055
G1 X93.497 Y80.952
G1 X92.757 Y80.213 E.02056
G1 X92.757 Y80.77
G1 X93.497 Y81.51 E.02058
G1 X93.498 Y82.068
G1 X92.757 Y81.328 E.02059
G1 X92.757 Y81.885
G1 X93.498 Y82.626 E.02061
G1 X93.499 Y83.184
G1 X92.757 Y82.443 E.02062
G1 X92.757 Y83.001
G1 X93.499 Y83.742 E.02063
G1 X93.5 Y84.3
G1 X92.757 Y83.558 E.02065
G1 X92.757 Y84.116
G1 X93.5 Y84.858 E.02066
G1 X93.501 Y85.416
G1 X92.757 Y84.673 E.02067
G1 X92.757 Y85.231
G1 X93.501 Y85.974 E.02069
G1 X93.502 Y86.532
G1 X92.757 Y85.788 E.0207
G1 X92.757 Y86.346
G1 X93.502 Y87.09 E.02071
G1 X93.503 Y87.648
G1 X92.757 Y86.903 E.02073
G1 X92.757 Y87.461
G1 X93.503 Y88.207 E.02074
G1 X93.313 Y88.574
G1 X92.757 Y88.018 E.01546
; WIPE_START
M204 S6000
G1 X93.313 Y88.574 E-.1493
G1 X93.503 Y88.207 E-.07861
G1 X92.937 Y87.641 E-.15209
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X92.694 Y80.012 Z6.36 F18000
G1 X92.606 Y77.274 Z6.36
G1 Z5.96
G1 E.4 F1800
G1 F1500
M204 S2000
G1 X91.862 Y76.53 E.02069
G1 X91.305 Y76.53
G1 X92.049 Y77.274 E.02069
G1 X91.491 Y77.274
G1 X90.747 Y76.53 E.02069
G1 X90.19 Y76.53
G1 X90.934 Y77.274 E.02069
G1 X90.376 Y77.274
G1 X89.632 Y76.53 E.02069
G1 X89.075 Y76.53
G1 X89.819 Y77.274 E.02069
G1 X89.261 Y77.274
G1 X88.517 Y76.53 E.02069
G1 X87.96 Y76.53
G1 X88.704 Y77.274 E.02069
G1 X88.146 Y77.274
G1 X87.402 Y76.53 E.02069
G1 X86.845 Y76.53
G1 X87.588 Y77.274 E.02069
G1 X87.031 Y77.274
G1 X86.287 Y76.53 E.02069
G1 X85.73 Y76.53
G1 X86.473 Y77.274 E.02069
G1 X85.916 Y77.274
G1 X85.172 Y76.53 E.02069
G1 X84.614 Y76.53
G1 X85.358 Y77.274 E.02069
G1 X84.801 Y77.274
G1 X84.057 Y76.53 E.02069
G1 X83.499 Y76.53
G1 X84.243 Y77.274 E.02069
G1 X83.686 Y77.274
G1 X82.942 Y76.53 E.02069
G1 X82.384 Y76.53
G1 X83.128 Y77.274 E.02069
G1 X82.571 Y77.274
G1 X81.827 Y76.53 E.02069
G1 X81.269 Y76.53
G1 X82.013 Y77.274 E.02069
G1 X81.456 Y77.274
G1 X80.712 Y76.53 E.02069
G1 X80.154 Y76.53
G1 X80.898 Y77.274 E.02069
G1 X80.34 Y77.274
G1 X79.597 Y76.53 E.02069
G1 X79.095 Y76.586
G1 X79.799 Y77.291 E.01961
G1 X79.409 Y77.458
G1 X78.736 Y76.785 E.01872
G1 X78.487 Y77.093
G1 X79.173 Y77.779 E.01907
G1 X79.104 Y78.268
G1 X78.365 Y77.529 E.02054
G1 X78.357 Y78.079
G1 X79.104 Y78.825 E.02076
G1 X79.104 Y79.383
G1 X78.357 Y78.636 E.02076
G1 X78.357 Y79.194
G1 X79.104 Y79.94 E.02076
G1 X79.104 Y80.498
G1 X78.357 Y79.751 E.02076
G1 X78.357 Y80.309
G1 X79.104 Y81.055 E.02076
G1 X79.104 Y81.613
G1 X78.357 Y80.866 E.02076
G1 X78.357 Y81.424
G1 X79.104 Y82.17 E.02076
G1 X79.104 Y82.728
G1 X78.357 Y81.981 E.02076
G1 X78.357 Y82.539
G1 X79.104 Y83.285 E.02076
G1 X79.104 Y83.843
G1 X78.357 Y83.097 E.02076
G1 X78.357 Y83.654
G1 X79.104 Y84.4 E.02076
G1 X79.104 Y84.958
G1 X78.357 Y84.212 E.02076
G1 X78.357 Y84.769
G1 X79.104 Y85.516 E.02076
G1 X79.104 Y86.073
G1 X78.357 Y85.327 E.02076
G1 X78.357 Y85.884
G1 X79.104 Y86.631 E.02076
G1 X79.104 Y87.188
G1 X78.357 Y86.442 E.02076
G1 X78.357 Y86.999
G1 X79.104 Y87.746 E.02076
G1 X79.104 Y88.303
G1 X78.357 Y87.557 E.02076
G1 X78.357 Y88.114
G1 X79.104 Y88.861 E.02076
G1 X79.104 Y89.418
G1 X78.357 Y88.672 E.02076
G1 X78.357 Y89.229
G1 X79.104 Y89.976 E.02076
G1 X79.104 Y90.533
G1 X78.357 Y89.787 E.02076
G1 X78.357 Y90.345
G1 X79.104 Y91.091 E.02076
G1 X79.104 Y91.648
G1 X78.357 Y90.902 E.02076
G1 X78.357 Y91.46
G1 X79.104 Y92.206 E.02076
G1 X79.104 Y92.764
G1 X78.357 Y92.017 E.02076
G1 X78.357 Y92.575
G1 X79.104 Y93.321 E.02076
G1 X79.104 Y93.879
G1 X78.357 Y93.132 E.02076
G1 X78.357 Y93.69
G1 X79.104 Y94.436 E.02076
G1 X79.104 Y94.994
G1 X78.357 Y94.247 E.02076
; WIPE_START
M204 S6000
G1 X79.104 Y94.994 E-.20054
G1 X79.104 Y94.436 E-.10593
G1 X78.83 Y94.163 E-.07352
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X86.455 Y94.504 Z6.36 F18000
G1 X92.838 Y94.789 Z6.36
G1 Z5.96
G1 E.4 F1800
G1 F1500
M204 S2000
G1 X93.839 Y95.79 E.02785
G1 X93.599 Y96.108
G1 X92.522 Y95.031 E.02997
G1 X92.365 Y95.432
G1 X93.242 Y96.309 E.0244
G1 X92.924 Y96.548
G1 X92.304 Y95.928 E.01725
G1 X91.746 Y95.928
G1 X92.486 Y96.668 E.02058
G1 X91.935 Y96.674
G1 X91.189 Y95.928 E.02076
G1 X90.631 Y95.928
G1 X91.377 Y96.674 E.02076
G1 X90.82 Y96.674
G1 X90.073 Y95.928 E.02076
G1 X89.516 Y95.928
G1 X90.262 Y96.674 E.02076
G1 X89.705 Y96.674
G1 X88.958 Y95.928 E.02076
G1 X88.401 Y95.928
G1 X89.147 Y96.674 E.02076
G1 X88.59 Y96.674
G1 X87.843 Y95.928 E.02076
G1 X87.286 Y95.928
M73 P98 R0
G1 X88.032 Y96.674 E.02076
; WIPE_START
M204 S6000
G1 X87.286 Y95.928 E-.20055
G1 X87.843 Y95.928 E-.10593
G1 X88.117 Y96.201 E-.07352
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X89.136 Y98.335 Z6.36 F18000
G1 Z5.96
G1 E.4 F1800
G1 F1500
M204 S2000
G1 X86.728 Y95.928 E.06697
G1 X86.171 Y95.928
G1 X89.427 Y99.184 E.09056
G1 X89.496 Y99.811
G1 X85.613 Y95.928 E.10802
G1 X85.056 Y95.928
G1 X86.748 Y97.62 E.04707
G1 X86.05 Y97.479
G1 X84.498 Y95.928 E.04316
G1 X83.941 Y95.928
G1 X85.528 Y97.515 E.04414
G1 X85.087 Y97.632
G1 X83.383 Y95.928 E.0474
G1 X83.572 Y96.674
G1 X82.825 Y95.928 E.02076
G1 X82.268 Y95.928
G1 X83.014 Y96.674 E.02076
G1 X82.457 Y96.674
G1 X81.71 Y95.928 E.02076
G1 X81.153 Y95.928
G1 X81.899 Y96.674 E.02076
G1 X81.342 Y96.674
G1 X80.595 Y95.928 E.02076
G1 X80.038 Y95.928
G1 X80.784 Y96.674 E.02076
G1 X80.227 Y96.674
G1 X78.357 Y94.805 E.05199
G1 X78.357 Y95.362
G1 X79.669 Y96.674 E.03648
; WIPE_START
M204 S6000
G1 X78.357 Y95.362 E-.35244
G1 X78.357 Y95.217 E-.02756
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X83.807 Y96.909 Z6.36 F18000
G1 Z5.96
G1 E.4 F1800
G1 F1500
M204 S2000
G1 X84.709 Y97.812 E.02511
G1 X84.377 Y98.037
G1 X83.547 Y97.207 E.02308
G1 X83.288 Y97.505
G1 X84.099 Y98.316 E.02255
G1 X83.861 Y98.636
G1 X83.038 Y97.813 E.0229
G1 X82.82 Y98.153
G1 X83.677 Y99.009 E.02384
G1 X83.553 Y99.443
G1 X82.637 Y98.527 E.02547
G1 X82.491 Y98.939
G1 X83.504 Y99.952 E.02818
G1 X83.615 Y100.62
G1 X82.397 Y99.402 E.0339
; WIPE_START
M204 S6000
G1 X83.615 Y100.62 E-.32748
G1 X83.57 Y100.348 E-.05252
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X88.205 Y99.077 Z6.36 F18000
G1 Z5.96
G1 E.4 F1800
G1 F1500
M204 S2000
G1 X89.469 Y100.342 E.03517
G1 X89.381 Y100.811
G1 X88.351 Y99.781 E.02866
G1 X88.32 Y100.307
G1 X89.245 Y101.232 E.02573
G1 X89.063 Y101.608
G1 X88.199 Y100.743 E.02404
G1 X88.019 Y101.122
G1 X88.849 Y101.951 E.02308
G1 X88.603 Y102.263
G1 X87.789 Y101.449 E.02264
G1 X87.513 Y101.73
G1 X88.326 Y102.543 E.02261
G1 X88.018 Y102.793
G1 X87.191 Y101.966 E.02299
G1 X86.819 Y102.152
G1 X87.678 Y103.01 E.02387
G1 X87.307 Y103.197
G1 X86.39 Y102.28 E.02551
G1 X85.875 Y102.322
G1 X86.893 Y103.34 E.02831
G1 X86.427 Y103.432
G1 X85.213 Y102.218 E.03379
; WIPE_START
M204 S6000
G1 X86.427 Y103.432 E-.32636
G1 X86.704 Y103.377 E-.05364
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X85.905 Y103.468 Z6.36 F18000
G1 Z5.96
G1 E.4 F1800
G1 F1500
M204 S2000
G1 X82.364 Y99.927 E.0985
G1 X82.416 Y100.536
G1 X85.291 Y103.411 E.07997
G1 X84.485 Y103.162
G1 X82.659 Y101.337 E.05078
; WIPE_START
M204 S6000
G1 X84.073 Y102.751 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X90.217 Y98.223 Z6.36 F18000
G1 X93.921 Y95.493 Z6.36
G1 Z5.96
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.282051
G1 F1500
M204 S6000
G1 X93.693 Y95.17 E.00506
; LINE_WIDTH: 0.313518
G1 X93.447 Y94.927 E.00495
; LINE_WIDTH: 0.275253
G1 X93.131 Y94.711 E.00476
; WIPE_START
G1 X93.447 Y94.927 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X89.329 Y98.751 Z6.36 F18000
G1 Z5.96
G1 E.4 F1800
; LINE_WIDTH: 0.209331
G1 F1500
M204 S6000
G1 X89.072 Y98.399 E.00399
; WIPE_START
G1 X89.329 Y98.751 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X88.276 Y99.007 Z6.36 F18000
G1 Z5.96
G1 E.4 F1800
; LINE_WIDTH: 0.169857
G1 F1500
M204 S6000
G1 X88.193 Y98.887 E.00105
; LINE_WIDTH: 0.143874
G1 X88.083 Y98.741 E.00108
; LINE_WIDTH: 0.0966725
G1 X87.972 Y98.595 E.00065
; WIPE_START
G1 X88.083 Y98.741 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X89.033 Y101.666 Z6.36 F18000
G1 Z5.96
G1 E.4 F1800
; LINE_WIDTH: 0.0829791
G1 F1500
M204 S6000
G1 X88.949 Y101.773 E.00039
; WIPE_START
G1 X89.033 Y101.666 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X85.141 Y102.29 Z6.36 F18000
G1 Z5.96
G1 E.4 F1800
; LINE_WIDTH: 0.13508
G1 F1500
M204 S6000
G1 X84.953 Y102.16 E.00124
; LINE_WIDTH: 0.118444
G1 X84.86 Y102.091 E.00054
; LINE_WIDTH: 0.0881894
G1 X84.767 Y102.022 E.00036
; WIPE_START
G1 X84.86 Y102.091 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X83.655 Y102.643 Z6.36 F18000
G1 Z5.96
G1 E.4 F1800
; LINE_WIDTH: 0.0831575
G1 F1500
M204 S6000
G1 X83.169 Y102.157 E.00197
; WIPE_START
G1 X83.655 Y102.643 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X83.571 Y100.854 Z6.36 F18000
G1 Z5.96
G1 E.4 F1800
; LINE_WIDTH: 0.12028
G1 F1500
M204 S6000
G1 X83.628 Y100.608 E.00119
M204 S10000
G1 X83.803 Y101.057 F18000
; LINE_WIDTH: 0.0931087
G1 F1500
M204 S6000
G1 X83.539 Y100.697 E.0015
; WIPE_START
G1 X83.803 Y101.057 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X82.744 Y98.355 Z6.36 F18000
G1 Z5.96
G1 E.4 F1800
; LINE_WIDTH: 0.0887959
G1 F1500
M204 S6000
G1 X82.651 Y98.487 E.00051
; WIPE_START
G1 X82.744 Y98.355 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X87.219 Y97.841 Z6.36 F18000
G1 Z5.96
G1 E.4 F1800
; LINE_WIDTH: 0.0936634
G1 F1500
M204 S6000
G1 X87.085 Y97.744 E.00056
; LINE_WIDTH: 0.134868
G1 X86.951 Y97.647 E.0009
; LINE_WIDTH: 0.176072
G1 X86.817 Y97.551 E.00124
; WIPE_START
G1 X86.951 Y97.647 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X88.06 Y96.948 Z6.36 F18000
G1 Z5.96
G1 E.4 F1800
; LINE_WIDTH: 0.0762881
G1 F1500
M204 S6000
G1 X87.912 Y96.794 E.00054
; WIPE_START
G1 X88.06 Y96.948 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X83.294 Y95.929 Z6.36 F18000
G1 Z5.96
G1 E.4 F1800
; LINE_WIDTH: 0.085428
G1 F1500
M204 S6000
G1 X83.126 Y95.95 E.0005
M204 S10000
G1 X83.828 Y96.652 F18000
; LINE_WIDTH: 0.0854405
G1 F1500
M204 S6000
G1 X83.66 Y96.673 E.0005
; WIPE_START
G1 X83.828 Y96.652 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X79.307 Y96.677 Z6.36 F18000
G1 Z5.96
G1 E.4 F1800
; LINE_WIDTH: 0.24948
G1 F1500
M204 S6000
G1 X79.133 Y96.555 E.00237
; LINE_WIDTH: 0.279
G1 X78.96 Y96.433 E.00268
; LINE_WIDTH: 0.314438
G1 X78.78 Y96.278 E.00341
G1 X78.603 Y96.079 E.00385
; LINE_WIDTH: 0.280797
G1 X78.357 Y95.738 E.00535
; WIPE_START
G1 X78.603 Y96.079 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X79.164 Y88.467 Z6.36 F18000
G1 X79.994 Y77.207 Z6.36
G1 Z5.96
G1 E.4 F1800
; LINE_WIDTH: 0.105054
G1 F1500
M204 S6000
G1 X79.822 Y77.287 E.00075
; WIPE_START
G1 X79.994 Y77.207 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X87.627 Y77.223 Z6.36 F18000
G1 X93.447 Y77.236 Z6.36
G1 Z5.96
G1 E.4 F1800
; LINE_WIDTH: 0.138082
G1 F1500
M204 S6000
G1 X93.252 Y76.989 E.00176
; LINE_WIDTH: 0.161718
G1 X92.996 Y76.741 E.00242
; LINE_WIDTH: 0.135395
G1 X92.894 Y76.664 E.0007
; LINE_WIDTH: 0.108749
G1 X92.791 Y76.588 E.00053
; WIPE_START
G1 X92.894 Y76.664 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X93.473 Y77.862 Z6.36 F18000
G1 Z5.96
G1 E.4 F1800
; LINE_WIDTH: 0.0847254
G1 F1500
M204 S6000
G1 X93.493 Y77.697 E.00049
; close powerlost recovery
M1003 S0
; WIPE_START
G1 F1500
G1 X93.473 Y77.862 E-.38
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

