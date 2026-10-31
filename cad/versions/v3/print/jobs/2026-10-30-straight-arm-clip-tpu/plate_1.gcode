; HEADER_BLOCK_START
; BambuStudio 02.07.01.62
; model printing time: 16m 43s; total estimated time: 24m 47s
; total layer number: 49
; total filament length [mm] : 392.24
; total filament volume [cm^3] : 943.44
; total filament weight [g] : 1.17
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
    G29 A1 X78.8316 Y76.1009 I22.3367 J27.7982
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
M73 P28 R17
G1 E-.4 F1800
; layer num/total_layer_count: 1/49
; update layer progress
M73 L1
M991 S0 P0 ;notify layer change
M106 S0
; OBJECT_ID: 8
G1 X93.549 Y95.416 F18000
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
G1 X93.588 Y95.29 E.00501
G1 X93.688 Y95.152 E.00649
G1 X93.854 Y95.045 E.00749
G1 X94.452 Y94.902 E.02338
G1 X94.522 Y95.525 E.02382
G1 X94.502 Y95.636 E.00429
G1 X94.447 Y95.76 E.00518
G1 X94.377 Y95.849 E.00429
G1 X94.258 Y95.935 E.00557
G1 X94.031 Y96.035 E.00943
G1 X93.8 Y96.237 E.01168
G1 X93.683 Y96.309 E.0052
G1 X93.463 Y96.395 E.00898
G1 X93.544 Y95.476 E.03507
; WIPE_START
G1 X93.588 Y95.29 E-.03627
G1 X93.688 Y95.152 E-.03242
G1 X93.854 Y95.045 E-.03742
G1 X94.452 Y94.902 E-.11686
M73 P31 R16
G1 X94.522 Y95.525 E-.11908
M73 P32 R16
G1 X94.502 Y95.636 E-.02146
G1 X94.467 Y95.715 E-.01648
; WIPE_END
G1 E-.02 F1800
M204 S6000
G1 X89.228 Y101.266 Z.6 F18000
G1 X89.035 Y101.47 Z.6
G1 Z.2
G1 E.4 F1800
G1 F900
M204 S500
G1 X88.762 Y101.802 E.01633
G1 X88.4 Y102.11 E.01808
G1 X88.115 Y102.286 E.01271
G1 X87.812 Y102.426 E.0127
G1 X87.355 Y102.56 E.01807
G1 X86.872 Y102.611 E.01847
G1 X86.399 Y102.575 E.01805
G1 X86.072 Y102.501 E.01272
G1 X85.759 Y102.388 E.01264
G1 X85.339 Y102.163 E.01813
G1 X84.959 Y101.859 E.01849
G1 X84.646 Y101.502 E.01804
G1 X84.466 Y101.22 E.01272
G1 X84.322 Y100.92 E.01264
G1 X84.181 Y100.464 E.01813
G1 X84.123 Y99.982 E.01847
G1 X84.151 Y99.508 E.01806
G1 X84.221 Y99.18 E.01272
G1 X84.328 Y98.866 E.01263
G1 X84.548 Y98.442 E.01814
G1 X84.845 Y98.058 E.01848
G1 X85.2 Y97.738 E.01814
G1 X85.477 Y97.555 E.01264
G1 X85.776 Y97.406 E.0127
G1 X86.228 Y97.259 E.01807
G1 X86.71 Y97.194 E.01847
G1 X87.185 Y97.215 E.01806
G1 X87.513 Y97.28 E.01272
G1 X87.821 Y97.38 E.01231
G1 X88.115 Y97.516 E.0123
G1 X88.4 Y97.692 E.01272
G1 X88.762 Y97.999 E.01806
G1 X89.071 Y98.374 E.01847
G1 X89.307 Y98.798 E.01845
G1 X89.461 Y99.248 E.01806
G1 X89.521 Y99.578 E.01272
G1 X89.541 Y99.911 E.0127
G1 X89.498 Y100.385 E.01808
G1 X89.371 Y100.845 E.01814
G1 X89.235 Y101.149 E.01264
G1 X89.072 Y101.423 E.01214
M204 S6000
G1 X88.682 Y101.18 F18000
; FEATURE: Outer wall
G1 F900
M204 S500
G1 X88.435 Y101.48 E.01477
G1 X88.13 Y101.739 E.01521
G1 X87.898 Y101.883 E.01037
G1 X87.651 Y101.997 E.01036
G1 X87.267 Y102.109 E.0152
G1 X86.865 Y102.152 E.01535
G1 X86.467 Y102.122 E.01518
G1 X86.201 Y102.061 E.01038
G1 X85.945 Y101.97 E.0103
G1 X85.592 Y101.78 E.01526
G1 X85.276 Y101.528 E.01536
G1 X85.013 Y101.227 E.01517
G1 X84.866 Y100.997 E.01038
G1 X84.748 Y100.753 E.01031
G1 X84.63 Y100.369 E.01526
G1 X84.582 Y99.968 E.01534
G1 X84.606 Y99.569 E.01519
G1 X84.662 Y99.302 E.01038
G1 X84.75 Y99.046 E.01029
G1 X84.935 Y98.689 E.01527
G1 X85.182 Y98.37 E.01534
G1 X85.48 Y98.101 E.01527
G1 X85.706 Y97.952 E.0103
G1 X85.95 Y97.83 E.01036
G1 X86.331 Y97.706 E.0152
G1 X86.731 Y97.652 E.01534
G1 X87.13 Y97.67 E.0152
G1 X87.398 Y97.723 E.01037
G1 X87.654 Y97.806 E.01023
G1 X87.898 Y97.919 E.01022
G1 X88.13 Y98.063 E.01038
G1 X88.435 Y98.321 E.0152
G1 X88.692 Y98.633 E.01534
G1 X88.888 Y98.985 E.01533
G1 X89.017 Y99.364 E.0152
G1 X89.066 Y99.632 E.01038
G1 X89.082 Y99.904 E.01036
G1 X89.046 Y100.303 E.0152
G1 X88.939 Y100.69 E.01527
G1 X88.829 Y100.938 E.0103
G1 X88.714 Y101.13 E.0085
; WIPE_START
G1 X88.435 Y101.48 E-.08514
G1 X88.13 Y101.739 E-.07605
G1 X87.898 Y101.883 E-.05185
G1 X87.651 Y101.997 E-.05179
G1 X87.267 Y102.109 E-.07601
G1 X87.062 Y102.131 E-.03916
; WIPE_END
G1 E-.02 F1800
M204 S6000
G1 X87.852 Y96.208 Z.6 F18000
G1 Z.2
G1 E.4 F1800
; FEATURE: Inner wall
G1 F900
M204 S500
G1 X87.973 Y96.208 E.00462
G1 X89.443 Y97.897 E.08509
G1 X89.548 Y98.041 E.00679
G1 X89.835 Y98.552 E.02227
G1 X90.027 Y99.106 E.02226
G1 X90.099 Y99.5 E.01524
G1 X90.123 Y99.89 E.01485
G1 X90.101 Y100.287 E.01511
G1 X89.98 Y100.864 E.0224
G1 X89.761 Y101.404 E.02214
G1 X89.675 Y101.56 E.00677
G1 X89.33 Y102.046 E.02266
G1 X88.912 Y102.452 E.02213
G1 X88.592 Y102.682 E.015
G1 X88.241 Y102.876 E.01524
G1 X87.701 Y103.076 E.02187
G1 X87.135 Y103.179 E.02187
G1 X86.734 Y103.191 E.01525
G1 X86.345 Y103.156 E.01485
G1 X85.962 Y103.076 E.01486
G1 X85.592 Y102.95 E.01485
G1 X85.08 Y102.689 E.02186
G1 X84.754 Y102.454 E.01526
G1 X84.466 Y102.19 E.01485
G1 X84.211 Y101.893 E.01485
G1 X83.994 Y101.569 E.01485
G1 X83.811 Y101.211 E.01525
G1 X83.631 Y100.669 E.02173
G1 X83.562 Y100.28 E.01501
G1 X83.54 Y99.89 E.01485
G1 X83.564 Y99.5 E.01484
G1 X83.635 Y99.116 E.01486
G1 X83.751 Y98.742 E.01486
G1 X83.914 Y98.376 E.01525
G1 X84.222 Y97.895 E.02173
G1 X85.687 Y96.208 E.08491
G1 X87.792 Y96.208 E.07999
; WIPE_START
G1 X87.973 Y96.208 E-.03447
G1 X89.167 Y97.58 E-.34553
; WIPE_END
G1 E-.02 F1800
M204 S6000
G1 X81.713 Y95.939 Z.6 F18000
G1 X79.527 Y95.458 Z.6
G1 Z.2
G1 E.4 F1800
G1 F900
M204 S500
G1 X79.751 Y95.394 E.00888
G1 X79.9 Y95.713 E.0134
G1 X80.115 Y95.955 E.01228
G1 X80.501 Y96.192 E.01721
G1 X80.428 Y96.4 E.00837
G1 X80.14 Y96.367 E.01105
G1 X80.009 Y96.323 E.00524
G1 X79.867 Y96.242 E.0062
G1 X79.749 Y96.136 E.00601
G1 X79.631 Y95.964 E.00793
G1 X79.565 Y95.783 E.00735
G1 X79.534 Y95.517 E.01016
; WIPE_START
G1 X79.751 Y95.394 E-.04754
G1 X79.9 Y95.713 E-.067
G1 X80.115 Y95.955 E-.06138
G1 X80.501 Y96.192 E-.08602
G1 X80.428 Y96.4 E-.04182
G1 X80.14 Y96.367 E-.05525
G1 X80.035 Y96.332 E-.02099
; WIPE_END
G1 E-.02 F1800
M204 S6000
G1 X79.836 Y88.702 Z.6 F18000
G1 X79.545 Y77.519 Z.6
G1 Z.2
G1 E.4 F1800
G1 F900
M204 S500
G1 X79.575 Y77.374 E.00563
G1 X79.629 Y77.237 E.00562
G1 X79.757 Y77.059 E.00833
G1 X79.867 Y76.961 E.00558
G1 X80.062 Y76.858 E.00837
G1 X80.203 Y76.82 E.00559
G1 X80.465 Y76.81 E.00994
G1 X80.517 Y77.018 E.00812
G1 X80.157 Y77.212 E.01557
G1 X79.905 Y77.479 E.01396
G1 X79.754 Y77.803 E.01359
G1 X79.539 Y77.756 E.00837
G1 X79.543 Y77.579 E.00671
; WIPE_START
G1 X79.575 Y77.374 E-.03943
G1 X79.629 Y77.237 E-.02811
G1 X79.757 Y77.059 E-.04164
G1 X79.867 Y76.961 E-.02791
G1 X80.062 Y76.858 E-.04185
G1 X80.203 Y76.82 E-.02793
G1 X80.465 Y76.81 E-.04969
G1 X80.517 Y77.018 E-.04059
G1 X80.157 Y77.212 E-.07782
G1 X80.138 Y77.231 E-.00504
; WIPE_END
G1 E-.02 F1800
M204 S6000
G1 X83.321 Y84.168 Z.6 F18000
G1 X89.14 Y96.852 Z.6
G1 Z.2
G1 E.4 F1800
; FEATURE: Outer wall
G1 F900
M204 S500
G1 X89.802 Y97.612 E.03827
G1 X89.93 Y97.789 E.00834
G1 X90.16 Y98.175 E.01705
G1 X90.256 Y98.372 E.00833
G1 X90.414 Y98.792 E.01705
G1 X90.472 Y99.003 E.00833
G1 X90.553 Y99.444 E.01705
G1 X90.581 Y99.889 E.01692
G1 X90.556 Y100.333 E.01691
G1 X90.525 Y100.55 E.00834
G1 X90.42 Y100.99 E.01719
G1 X90.351 Y101.194 E.00819
G1 X90.171 Y101.606 E.01706
G1 X90.066 Y101.798 E.00832
G1 X89.814 Y102.174 E.0172
G1 X89.677 Y102.344 E.00832
G1 X89.529 Y102.506 E.00832
G1 X89.201 Y102.807 E.01692
G1 X88.837 Y103.069 E.01707
G1 X88.444 Y103.286 E.01705
G1 X88.247 Y103.373 E.00819
G1 X87.822 Y103.517 E.01705
G1 X87.386 Y103.609 E.01691
G1 X87.169 Y103.635 E.00833
G1 X86.72 Y103.649 E.01706
G1 X86.277 Y103.609 E.01692
G1 X85.841 Y103.517 E.01692
G1 X85.42 Y103.374 E.01692
G1 X85.015 Y103.181 E.01705
G1 X84.83 Y103.071 E.00818
G1 X84.465 Y102.809 E.01707
G1 X84.137 Y102.508 E.01692
G1 X83.847 Y102.17 E.01692
G1 X83.599 Y101.801 E.01692
G1 X83.395 Y101.401 E.01706
G1 X83.315 Y101.201 E.00818
G1 X83.186 Y100.775 E.01691
G1 X83.107 Y100.333 E.01707
G1 X83.082 Y99.889 E.01692
G1 X83.11 Y99.445 E.01691
G1 X83.19 Y99.007 E.01692
G1 X83.322 Y98.581 E.01692
G1 X83.505 Y98.171 E.01706
G1 X83.609 Y97.983 E.00818
G1 X83.859 Y97.615 E.01692
G1 X84.523 Y96.851 E.03848
G1 X80.346 Y96.851 E.15876
G1 X80.04 Y96.815 E.01171
G1 X79.833 Y96.747 E.00828
G1 X79.707 Y96.683 E.00538
G1 X79.588 Y96.605 E.00539
G1 X79.42 Y96.456 E.00855
G1 X79.331 Y96.349 E.0053
M73 P33 R16
G1 X79.217 Y96.165 E.00822
G1 X79.117 Y95.889 E.01115
G1 X79.082 Y95.586 E.01157
G1 X79.082 Y77.608 E.68328
G1 X79.09 Y77.459 E.00566
G1 X79.135 Y77.243 E.00842
G1 X79.217 Y77.037 E.00841
G1 X79.286 Y76.917 E.00525
G1 X79.423 Y76.744 E.00841
G1 X79.587 Y76.597 E.00836
G1 X79.704 Y76.521 E.0053
G1 X79.905 Y76.427 E.00842
G1 X80.117 Y76.37 E.00836
G1 X80.259 Y76.353 E.00543
G1 X93.322 Y76.351 E.49647
G1 X93.548 Y76.371 E.00864
G1 X93.757 Y76.427 E.0082
G1 X94.021 Y76.56 E.01124
G1 X94.188 Y76.692 E.00809
G1 X94.334 Y76.855 E.00832
G1 X94.448 Y77.04 E.00828
G1 X94.528 Y77.243 E.00827
G1 X94.572 Y77.452 E.00814
G1 X94.581 Y88.751 E.42941
G1 X93.482 Y88.751 E.0418
G1 X93.482 Y77.451 E.42947
G1 X80.81 Y77.451 E.48161
G1 X80.612 Y77.486 E.00764
G1 X80.439 Y77.579 E.00748
G1 X80.288 Y77.739 E.00835
G1 X80.206 Y77.914 E.00732
G1 X80.182 Y78.083 E.00649
G1 X80.182 Y95.119 E.64749
G1 X80.206 Y95.288 E.00649
G1 X80.286 Y95.46 E.00719
G1 X80.412 Y95.601 E.00719
G1 X80.58 Y95.704 E.00748
G1 X80.806 Y95.751 E.00879
G1 X93.061 Y95.751 E.46576
G1 X93.097 Y95.336 E.01581
G1 X93.141 Y95.173 E.00642
G1 X93.27 Y94.935 E.0103
G1 X93.378 Y94.814 E.00617
G1 X93.559 Y94.678 E.00859
G1 X93.702 Y94.611 E.006
G1 X94.04 Y94.53 E.0132
G1 X99.919 Y86.134 E.38958
G1 X100.82 Y86.765 E.04181
G1 X94.941 Y95.161 E.38957
G1 X94.981 Y95.514 E.01349
G1 X94.939 Y95.778 E.01018
G1 X94.845 Y95.989 E.00878
G1 X94.676 Y96.198 E.01018
G1 X94.485 Y96.334 E.00891
G1 X94.28 Y96.425 E.00855
G1 X94.072 Y96.607 E.0105
G1 X93.888 Y96.719 E.0082
G1 X93.687 Y96.798 E.0082
G1 X93.479 Y96.841 E.00808
G1 X89.2 Y96.852 E.1626
; WIPE_START
G1 X89.802 Y97.612 E-.18406
G1 X89.93 Y97.789 E-.04169
G1 X90.16 Y98.175 E-.08524
G1 X90.256 Y98.372 E-.04166
G1 X90.306 Y98.507 E-.02735
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




G1 X88.966 Y97.791
G1 Z.2
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.168522
G1 F900
M204 S500
G1 X89.305 Y98.201 E.00556
G1 X89.568 Y98.668 E.0056
G1 X89.743 Y99.173 E.00558
G1 X89.809 Y99.536 E.00385
G1 X89.831 Y99.911 E.00392
G1 X89.78 Y100.431 E.00546
G1 X89.695 Y100.781 E.00377
G1 X89.498 Y101.276 E.00556
G1 X89.3 Y101.597 E.00394
G1 X89.105 Y101.853 E.00337
G1 X88.724 Y102.223 E.00554
G1 X88.434 Y102.434 E.00375
G1 X88.112 Y102.612 E.00385
G1 X87.623 Y102.79 E.00544
G1 X87.111 Y102.883 E.00544
G1 X86.743 Y102.896 E.00385
G1 X86.36 Y102.863 E.00401
G1 X85.987 Y102.778 E.00399
G1 X85.637 Y102.651 E.00389
G1 X85.178 Y102.398 E.00548
G1 X84.763 Y102.072 E.00551
G1 X84.445 Y101.716 E.00498
G1 X84.215 Y101.364 E.00439
G1 X84.054 Y101.03 E.00387
G1 X83.899 Y100.53 E.00547
G1 X83.834 Y99.996 E.00562
G1 X83.856 Y99.536 E.00481
G1 X83.92 Y99.186 E.00372
G1 X84.06 Y98.756 E.00472
G1 X84.304 Y98.293 E.00547
G1 X84.63 Y97.865 E.00561
G1 X84.818 Y97.673 E.00281
; LINE_WIDTH: 0.210279
G1 X84.999 Y97.489 E.00359
; LINE_WIDTH: 0.227516
G1 X85.009 Y97.48 E.00021
; LINE_WIDTH: 0.253744
G1 X85.147 Y97.359 E.00321
; LINE_WIDTH: 0.303511
G1 X85.284 Y97.238 E.00397
; LINE_WIDTH: 0.331283
G1 X85.298 Y97.227 E.00042
; LINE_WIDTH: 0.358299
G1 X85.396 Y97.151 E.00325
; LINE_WIDTH: 0.406582
G1 X85.494 Y97.075 E.00375
; LINE_WIDTH: 0.454866
G1 X85.592 Y96.999 E.00425
; LINE_WIDTH: 0.486897
G1 X85.62 Y96.979 E.00126
M204 S6000
G1 X85.436 Y96.846 F18000
; LINE_WIDTH: 0.679006
G1 F900
M204 S500
G1 X86.083 Y96.743 E.03462
; LINE_WIDTH: 0.630731
G1 X86.401 Y96.719 E.01559
; LINE_WIDTH: 0.591061
G1 X86.664 Y96.702 E.01204
; LINE_WIDTH: 0.581793
G1 X87.225 Y96.712 E.02511
; LINE_WIDTH: 0.613235
G1 X87.449 Y96.732 E.01067
; LINE_WIDTH: 0.652611
G1 X87.631 Y96.75 E.00931
; LINE_WIDTH: 0.687441
G1 X88.223 Y96.843 E.03211
M204 S6000
G1 X88.291 Y97.167 F18000
; LINE_WIDTH: 0.343907
G1 F900
M204 S500
G1 X88.4 Y97.259 E.00357
; LINE_WIDTH: 0.303941
G1 X88.494 Y97.339 E.00268
; LINE_WIDTH: 0.266968
G1 X88.588 Y97.419 E.0023
; LINE_WIDTH: 0.226775
G1 X88.783 Y97.61 E.00417
; LINE_WIDTH: 0.186697
G1 X88.966 Y97.791 E.00307
; WIPE_START
G1 X88.783 Y97.61 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S6000
G1 X88.359 Y96.303 Z.6 F18000
G1 Z.2
G1 E.4 F1800
; LINE_WIDTH: 0.682799
G1 F900
M204 S500
G1 X93.242 Y96.296 E.25983
; WIPE_START
G1 X91.242 Y96.299 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S6000
G1 X94.83 Y94.921 Z.6 F18000
G1 Z.2
G1 E.4 F1800
; LINE_WIDTH: 0.432346
G1 F900
M204 S500
G1 X94.831 Y94.827 E.00305
; LINE_WIDTH: 0.47844
G1 X94.831 Y94.733 E.00341
; LINE_WIDTH: 0.524534
G1 X94.832 Y94.638 E.00378
; LINE_WIDTH: 0.570628
G1 X94.833 Y94.544 E.00414
; LINE_WIDTH: 0.616722
G1 X94.833 Y94.45 E.0045
; LINE_WIDTH: 0.662816
G1 X94.834 Y94.355 E.00486
; LINE_WIDTH: 0.685871
G1 X100.239 Y86.636 E.50377
; WIPE_START
G1 X99.091 Y88.275 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S6000
G1 X94.031 Y88.522 Z.6 F18000
G1 Z.2
G1 E.4 F1800
; LINE_WIDTH: 0.680315
G1 F900
M204 S500
G1 X94.015 Y77.396 E.58968
; LINE_WIDTH: 0.628684
G1 X93.991 Y77.27 E.00627
; LINE_WIDTH: 0.591038
G1 X93.977 Y77.222 E.00225
; LINE_WIDTH: 0.560907
G1 X93.948 Y77.142 E.00367
; LINE_WIDTH: 0.542745
G1 X93.864 Y77.035 E.00566
G1 X93.71 Y76.957 E.00717
M204 S6000
G1 X94.155 Y77 F18000
; LINE_WIDTH: 0.683135
G1 F900
M204 S500
G1 X93.298 Y76.901 E.04591
G1 X80.724 Y76.902 E.66937
; WIPE_START
G1 X82.724 Y76.902 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S6000
G1 X79.635 Y78.011 Z.6 F18000
G1 Z.2
G1 E.4 F1800
; LINE_WIDTH: 0.691881
G1 F900
M204 S500
G1 X79.635 Y95.189 E.92696
; WIPE_START
G1 X79.635 Y93.189 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S6000
G1 X80.705 Y96.301 Z.6 F18000
G1 Z.2
G1 E.4 F1800
; LINE_WIDTH: 0.68586
G1 F900
M204 S500
G1 X85.304 Y96.301 E.24586
; CHANGE_LAYER
; Z_HEIGHT: 0.32
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F900
G1 X83.304 Y96.301 E-.38
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
G3 Z.6 I.907 J.811 P1  F18000
G1 X93.851 Y84.504 Z.6
G1 Z.32
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
M73 P34 R16
G1 X93.851 Y77.128 E.15612
G1 X94.036 Y77.076 E.00407
G1 X94.117 Y77.207 E.00325
G1 X94.173 Y77.349 E.00324
G1 X94.202 Y77.49 E.00305
G1 X94.212 Y88.382 E.23053
G1 X93.851 Y88.382 E.00764
G1 X93.851 Y84.564 E.08079
; WIPE_START
M204 S6000
G1 X93.851 Y82.564 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X93.869 Y90.197 Z.72 F18000
G1 X93.882 Y95.465 Z.72
G1 Z.32
G1 E.4 F1800
G1 F1500
M204 S500
G1 X93.904 Y95.411 E.00124
G1 X93.956 Y95.372 E.00138
G1 X94.16 Y95.319 E.00446
G1 X94.183 Y95.524 E.00437
G1 X94.15 Y95.598 E.00172
G1 X94.091 Y95.641 E.00154
G1 X93.858 Y95.743 E.00538
G1 X93.877 Y95.525 E.00464
; WIPE_START
M204 S6000
G1 X93.904 Y95.411 E-.03625
G1 X93.956 Y95.372 E-.02019
G1 X94.16 Y95.319 E-.06529
G1 X94.183 Y95.524 E-.06394
G1 X94.15 Y95.598 E-.0252
G1 X94.091 Y95.641 E-.02254
G1 X93.858 Y95.743 E-.07876
G1 X93.877 Y95.525 E-.06782
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X88.059 Y97.103 Z.72 F18000
G1 Z.32
G1 E.4 F1800
G1 F1500
M204 S500
G1 X87.598 Y96.954 E.01026
G1 X87.225 Y96.88 E.00805
G1 X86.711 Y96.857 E.0109
G1 X86.333 Y96.897 E.00804
G1 X85.962 Y96.981 E.00804
G1 X85.593 Y97.126 E.00839
G1 X85.478 Y96.963 E.00423
G1 X85.842 Y96.544 E.01174
G1 X87.82 Y96.544 E.04185
G1 X88.166 Y96.942 E.01116
G1 X88.092 Y97.053 E.00283
; WIPE_START
M204 S6000
G1 X87.598 Y96.954 E-.09579
G1 X87.225 Y96.88 E-.07223
G1 X86.711 Y96.857 E-.09782
G1 X86.333 Y96.897 E-.07219
G1 X86.117 Y96.946 E-.04197
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X88.984 Y101.387 Z.72 F18000
G1 Z.32
G1 E.4 F1800
G1 F1500
M204 S500
G1 X88.904 Y101.504 E.003
G1 X88.692 Y101.747 E.00684
G1 X88.343 Y102.042 E.00967
G1 X88.073 Y102.208 E.0067
G1 X87.786 Y102.342 E.00671
G1 X87.339 Y102.473 E.00986
G1 X86.871 Y102.522 E.00996
G1 X86.412 Y102.488 E.00974
G1 X86.097 Y102.416 E.00683
G1 X85.798 Y102.309 E.00671
G1 X85.388 Y102.089 E.00986
G1 X85.02 Y101.796 E.00996
G1 X84.717 Y101.449 E.00975
G1 X84.543 Y101.177 E.00683
G1 X84.405 Y100.892 E.00671
G1 X84.267 Y100.447 E.00986
G1 X84.211 Y99.979 E.00996
G1 X84.239 Y99.519 E.00975
G1 X84.306 Y99.204 E.00683
G1 X84.41 Y98.898 E.00683
G1 X84.622 Y98.49 E.00975
G1 X84.91 Y98.118 E.00995
G1 X85.259 Y97.803 E.00995
G1 X85.659 Y97.556 E.00995
G1 X86.088 Y97.388 E.00975
G1 X86.402 Y97.316 E.00683
G1 X86.723 Y97.282 E.00683
G1 X87.174 Y97.302 E.00955
G1 X87.491 Y97.365 E.00683
G1 X87.798 Y97.465 E.00683
G1 X88.201 Y97.666 E.00955
G1 X88.465 Y97.852 E.00683
G1 X88.705 Y98.068 E.00683
G1 X88.998 Y98.424 E.00975
G1 X89.222 Y98.826 E.00975
G1 X89.336 Y99.129 E.00683
G1 X89.412 Y99.442 E.00683
G1 X89.453 Y99.901 E.00975
G1 X89.411 Y100.369 E.00995
G1 X89.286 Y100.822 E.00995
G1 X89.086 Y101.237 E.00975
G1 X89.018 Y101.337 E.00256
M204 S250
G1 X88.646 Y101.156 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X88.58 Y101.253 E.00231
G1 X88.404 Y101.455 E.00526
G1 X88.102 Y101.71 E.00777
G1 X87.879 Y101.847 E.00515
G1 X87.641 Y101.958 E.00516
G1 X87.259 Y102.07 E.00784
G1 X86.865 Y102.111 E.0078
G1 X86.473 Y102.082 E.00773
G1 X86.212 Y102.023 E.00526
G1 X85.965 Y101.934 E.00516
G1 X85.614 Y101.746 E.00784
G1 X85.304 Y101.499 E.0078
G1 X85.045 Y101.203 E.00773
G1 X84.901 Y100.977 E.00526
G1 X84.787 Y100.741 E.00516
G1 X84.669 Y100.361 E.00783
G1 X84.622 Y99.967 E.0078
G1 X84.645 Y99.574 E.00774
G1 X84.701 Y99.313 E.00526
G1 X84.787 Y99.06 E.00526
G1 X84.968 Y98.711 E.00773
G1 X85.211 Y98.397 E.0078
G1 X85.505 Y98.132 E.0078
G1 X85.843 Y97.924 E.0078
G1 X86.209 Y97.78 E.00773
G1 X86.469 Y97.72 E.00526
G1 X86.736 Y97.692 E.00526
G1 X87.125 Y97.71 E.00767
G1 X87.388 Y97.762 E.00527
G1 X87.642 Y97.844 E.00526
G1 X87.991 Y98.019 E.00767
G1 X88.21 Y98.173 E.00526
G1 X88.409 Y98.352 E.00526
G1 X88.658 Y98.656 E.00774
G1 X88.85 Y98.999 E.00773
G1 X88.944 Y99.249 E.00526
G1 X89.007 Y99.509 E.00526
G1 X89.042 Y99.901 E.00773
G1 X89.007 Y100.296 E.0078
G1 X88.901 Y100.678 E.0078
G1 X88.731 Y101.032 E.00773
G1 X88.68 Y101.107 E.00178
; WIPE_START
M204 S6000
G1 X88.58 Y101.253 E-.03368
G1 X88.404 Y101.455 E-.05086
G1 X88.102 Y101.71 E-.07508
G1 X87.879 Y101.847 E-.04979
G1 X87.641 Y101.958 E-.04982
G1 X87.259 Y102.07 E-.07569
G1 X87.023 Y102.095 E-.04509
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X88.074 Y96.12 Z.72 F18000
G1 Z.32
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X93.399 Y96.12 E.11272
G1 X93.463 Y95.392 E.01547
G1 X93.514 Y95.242 E.00336
G1 X93.567 Y95.156 E.00212
G1 X93.742 Y95.002 E.00494
G1 X93.873 Y94.945 E.00303
G1 X94.256 Y94.865 E.00827
G1 X100.01 Y86.648 E.21232
G1 X100.306 Y86.855 E.00765
G1 X94.558 Y95.064 E.21209
G1 X94.607 Y95.566 E.01067
G1 X94.586 Y95.663 E.0021
G1 X94.522 Y95.806 E.00333
G1 X94.435 Y95.916 E.00297
G1 X94.302 Y96.011 E.00346
G1 X94.079 Y96.109 E.00516
G1 X93.852 Y96.308 E.00638
G1 X93.723 Y96.387 E.00321
G1 X93.581 Y96.443 E.00321
G1 X93.441 Y96.472 E.00304
G1 X88.331 Y96.485 E.10816
G1 X89.509 Y97.838 E.03796
G1 X89.73 Y98.161 E.0083
G1 X89.919 Y98.526 E.00869
G1 X90.112 Y99.086 E.01254
G1 X90.205 Y99.68 E.01274
G1 X90.19 Y100.283 E.01275
G1 X90.069 Y100.872 E.01273
G1 X89.846 Y101.43 E.01273
G1 X89.639 Y101.783 E.00867
G1 X89.396 Y102.103 E.0085
G1 X88.972 Y102.517 E.01254
G1 X88.474 Y102.855 E.01274
G1 X88.113 Y103.028 E.00848
G1 X87.724 Y103.161 E.00871
G1 X87.141 Y103.267 E.01254
G1 X86.731 Y103.279 E.00867
G1 X86.332 Y103.243 E.00849
G1 X85.939 Y103.161 E.00849
G1 X85.56 Y103.032 E.00848
G1 X85.189 Y102.854 E.00871
G1 X84.85 Y102.64 E.00848
G1 X84.403 Y102.251 E.01254
G1 X84.141 Y101.947 E.00849
G1 X83.918 Y101.613 E.00849
G1 X83.663 Y101.078 E.01254
G1 X83.547 Y100.695 E.00848
G1 X83.474 Y100.29 E.0087
G1 X83.452 Y99.89 E.00848
G1 X83.477 Y99.49 E.00849
G1 X83.55 Y99.095 E.0085
G1 X83.668 Y98.712 E.00849
G1 X83.831 Y98.345 E.0085
G1 X84.149 Y97.845 E.01253
G1 X85.335 Y96.482 E.03824
G1 X80.368 Y96.482 E.10513
G1 X80.129 Y96.454 E.00508
G1 X79.854 Y96.339 E.00632
G1 X79.662 Y96.171 E.00539
G1 X79.566 Y96.033 E.00355
G1 X79.48 Y95.812 E.00502
G1 X79.451 Y95.565 E.00528
G1 X79.451 Y77.628 E.37965
G1 X79.487 Y77.357 E.00579
G1 X79.592 Y77.125 E.00538
G1 X79.693 Y76.998 E.00343
G1 X79.807 Y76.896 E.00324
G1 X80.023 Y76.778 E.00521
G1 X80.281 Y76.723 E.00559
G1 X93.299 Y76.72 E.27554
G1 X93.543 Y76.749 E.00519
G1 X93.68 Y76.794 E.00305
G1 X93.856 Y76.889 E.00424
G1 X93.807 Y77.082 E.0042
G1 X80.786 Y77.082 E.2756
G1 X80.528 Y77.12 E.00553
G1 X80.226 Y77.271 E.00716
G1 X80.002 Y77.495 E.00669
G1 X79.85 Y77.797 E.00717
G1 X79.812 Y78.056 E.00553
G1 X79.812 Y95.146 E.36173
G1 X79.849 Y95.395 E.00533
G1 X79.975 Y95.665 E.00629
G1 X80.172 Y95.887 E.00629
G1 X80.441 Y96.053 E.00669
G1 X80.768 Y96.12 E.00707
G1 X88.014 Y96.12 E.15335
; WIPE_START
M204 S6000
G1 X90.014 Y96.12 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X89.228 Y96.892 Z.72 F18000
G1 Z.32
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X89.829 Y97.582 E.018
G1 X89.966 Y97.77 E.00457
G1 X90.085 Y97.957 E.00436
G1 X90.293 Y98.359 E.00891
G1 X90.453 Y98.783 E.00891
G1 X90.511 Y98.994 E.00431
G1 X90.594 Y99.443 E.00897
G1 X90.614 Y99.661 E.00431
G1 X90.616 Y100.107 E.00877
G1 X90.596 Y100.335 E.00451
G1 X90.519 Y100.774 E.00877
G1 X90.46 Y100.996 E.00451
G1 X90.306 Y101.414 E.00877
G1 X90.208 Y101.621 E.00451
G1 X89.979 Y102.012 E.0089
G1 X89.707 Y102.37 E.00885
G1 X89.392 Y102.695 E.00891
G1 X89.226 Y102.839 E.00431
G1 X88.856 Y103.105 E.00897
G1 X88.667 Y103.216 E.0043
G1 X88.268 Y103.408 E.00871
G1 X87.832 Y103.556 E.00905
G1 X87.399 Y103.648 E.00871
G1 X87.172 Y103.675 E.0045
G1 X86.719 Y103.689 E.00891
G1 X86.271 Y103.649 E.00885
G1 X85.831 Y103.556 E.00885
G1 X85.405 Y103.412 E.00884
G1 X84.99 Y103.213 E.00905
G1 X84.616 Y102.975 E.00871
G1 X84.442 Y102.842 E.00431
G1 X84.108 Y102.536 E.00891
G1 X83.815 Y102.195 E.00885
G1 X83.564 Y101.821 E.00885
G1 X83.358 Y101.417 E.00891
G1 X83.277 Y101.215 E.0043
G1 X83.148 Y100.791 E.00871
G1 X83.067 Y100.338 E.00905
G1 X83.042 Y99.888 E.00885
G1 X83.07 Y99.44 E.00884
G1 X83.151 Y98.997 E.00885
G1 X83.284 Y98.567 E.00885
G1 X83.467 Y98.156 E.00885
G1 X83.7 Y97.767 E.00891
G1 X83.828 Y97.59 E.0043
G1 X84.436 Y96.891 E.01823
G1 X80.344 Y96.891 E.08049
G1 X80.034 Y96.855 E.00613
G1 X79.748 Y96.75 E.006
G1 X79.623 Y96.678 E.00284
G1 X79.445 Y96.537 E.00447
G1 X79.344 Y96.429 E.0029
G1 X79.214 Y96.243 E.00447
G1 X79.148 Y96.111 E.0029
G1 X79.078 Y95.901 E.00435
G1 X79.042 Y95.589 E.00619
G1 X79.042 Y77.61 E.35362
G1 X79.062 Y77.377 E.00459
G1 X79.096 Y77.234 E.0029
G1 X79.181 Y77.02 E.00453
G1 X79.253 Y76.895 E.00283
G1 X79.394 Y76.716 E.00448
G1 X79.562 Y76.567 E.00442
G1 X79.756 Y76.447 E.00448
G1 X79.888 Y76.39 E.00283
G1 X80.107 Y76.331 E.00447
G1 X80.257 Y76.313 E.00296
G1 X93.323 Y76.311 E.257
G1 X93.632 Y76.347 E.00611
G1 X93.842 Y76.417 E.00436
G1 X94.04 Y76.524 E.00442
G1 X94.216 Y76.663 E.00442
G1 X94.366 Y76.831 E.00442
G1 X94.484 Y77.022 E.00442
G1 X94.567 Y77.231 E.00442
G1 X94.612 Y77.448 E.00436
G1 X94.621 Y88.791 E.2231
G1 X93.442 Y88.791 E.02321
G1 X93.442 Y77.491 E.22226
G1 X80.816 Y77.491 E.24833
G1 X80.653 Y77.515 E.00325
G1 X80.468 Y77.607 E.00405
G1 X80.338 Y77.738 E.00362
G1 X80.246 Y77.922 E.00406
G1 X80.222 Y78.086 E.00325
G1 X80.222 Y95.116 E.33498
G1 X80.245 Y95.277 E.00319
G1 X80.32 Y95.437 E.00349
G1 X80.438 Y95.57 E.00349
G1 X80.595 Y95.666 E.00361
G1 X80.81 Y95.711 E.00433
G1 X93.024 Y95.711 E.24024
G1 X93.058 Y95.327 E.00759
G1 X93.084 Y95.218 E.0022
G1 X93.147 Y95.058 E.00339
G1 X93.237 Y94.911 E.00338
G1 X93.352 Y94.783 E.00338
G1 X93.536 Y94.646 E.00451
G1 X93.749 Y94.553 E.00457
M73 P35 R16
G1 X94.014 Y94.498 E.00532
G1 X99.909 Y86.078 E.20217
G1 X100.876 Y86.755 E.02321
G1 X94.982 Y95.172 E.2021
G1 X95.021 Y95.513 E.00675
G1 X94.977 Y95.791 E.00553
G1 X94.878 Y96.012 E.00476
G1 X94.702 Y96.228 E.00548
G1 X94.505 Y96.369 E.00477
G1 X94.301 Y96.459 E.00438
G1 X94.096 Y96.639 E.00538
G1 X93.906 Y96.755 E.00438
G1 X93.698 Y96.837 E.00438
G1 X93.483 Y96.881 E.00433
G1 X89.288 Y96.892 E.08251
; WIPE_START
M204 S6000
G1 X89.829 Y97.582 E-.16665
G1 X89.966 Y97.77 E-.04413
G1 X90.085 Y97.957 E-.04211
G1 X90.293 Y98.359 E-.0861
G1 X90.369 Y98.561 E-.04101
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




G1 X88.971 Y97.797
G1 Z.32
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.382441
G1 F1500
M204 S6000
G1 X88.707 Y97.53 E.00667
; LINE_WIDTH: 0.426685
G1 X88.582 Y97.418 E.00337
; LINE_WIDTH: 0.467557
G1 X88.457 Y97.305 E.00372
G1 X88.433 Y97.309 E.00053
; LINE_WIDTH: 0.438724
G1 X88.283 Y97.343 E.00318
; LINE_WIDTH: 0.410254
G1 X88.132 Y97.377 E.00296
M204 S10000
G1 X88.971 Y97.797 F18000
; LINE_WIDTH: 0.360109
G1 F1500
M204 S6000
G1 X89.301 Y98.2 E.00869
G1 X89.56 Y98.656 E.00876
G1 X89.7 Y99.023 E.00654
G1 X89.779 Y99.369 E.00592
G1 X89.821 Y99.697 E.00551
G1 X89.808 Y100.236 E.009
G1 X89.702 Y100.758 E.00889
G1 X89.63 Y100.967 E.00368
G1 X89.418 Y101.415 E.00827
G1 X89.196 Y101.742 E.0066
G1 X88.945 Y102.022 E.00628
G1 X88.553 Y102.351 E.00855
G1 X88.244 Y102.546 E.00608
G1 X87.931 Y102.691 E.00576
G1 X87.624 Y102.789 E.00538
G1 X87.107 Y102.884 E.00876
G1 X86.743 Y102.896 E.00608
G1 X86.368 Y102.864 E.00628
G1 X85.982 Y102.776 E.0066
G1 X85.634 Y102.649 E.00617
G1 X85.17 Y102.393 E.00884
G1 X84.77 Y102.078 E.00849
G1 X84.445 Y101.716 E.00812
G1 X84.218 Y101.37 E.0069
G1 X84.059 Y101.041 E.00609
G1 X83.902 Y100.54 E.00876
G1 X83.835 Y100.005 E.00899
G1 X83.856 Y99.536 E.00783
G1 X83.92 Y99.186 E.00594
G1 X84.059 Y98.761 E.00744
G1 X84.297 Y98.299 E.00867
G1 X84.624 Y97.872 E.00897
G1 X84.822 Y97.669 E.00474
; LINE_WIDTH: 0.401765
G1 X85 Y97.487 E.00478
; LINE_WIDTH: 0.438155
G1 X85.197 Y97.318 E.00533
; LINE_WIDTH: 0.473072
G1 X85.367 Y97.174 E.00499
; WIPE_START
G1 X85.197 Y97.318 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X80.294 Y96.251 Z.72 F18000
G1 Z.32
G1 E.4 F1800
; LINE_WIDTH: 0.137454
G1 F1500
M204 S6000
G1 X79.989 Y96.092 E.00192
; LINE_WIDTH: 0.152789
G1 X79.918 Y96.028 E.00061
G1 X79.751 Y95.803 E.00177
; LINE_WIDTH: 0.10408
G1 X79.693 Y95.617 E.00076
; WIPE_START
G1 X79.751 Y95.803 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X87.382 Y95.991 Z.72 F18000
G1 X93.61 Y96.144 Z.72
G1 Z.32
G1 E.4 F1800
; LINE_WIDTH: 0.10972
G1 F1500
M204 S6000
G1 X93.837 Y96.009 E.0011
; WIPE_START
G1 X93.61 Y96.144 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X89.028 Y90.04 Z.72 F18000
G1 X79.688 Y77.598 Z.72
G1 Z.32
G1 E.4 F1800
; LINE_WIDTH: 0.102627
G1 F1500
M204 S6000
G1 X79.739 Y77.433 E.00066
; LINE_WIDTH: 0.151668
G1 X79.794 Y77.32 E.00079
G1 X79.902 Y77.193 E.00104
G1 X80.061 Y77.059 E.00131
; LINE_WIDTH: 0.115662
G1 X80.297 Y76.965 E.00114
; LINE_WIDTH: 0.0827259
G1 X80.336 Y76.956 E.00011
; CHANGE_LAYER
; Z_HEIGHT: 0.44
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F1500
G1 X80.297 Y76.965 E-.38
; WIPE_END
G1 E-.02 F1800
; layer num/total_layer_count: 3/49
; update layer progress
M73 L3
M991 S0 P2 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z.72 I-.592 J1.064 P1  F18000
G1 X93.851 Y84.503 Z.72
G1 Z.44
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X93.851 Y77.128 E.1561
G1 X94.036 Y77.076 E.00407
G1 X94.117 Y77.207 E.00325
G1 X94.173 Y77.349 E.00324
G1 X94.202 Y77.49 E.00306
G1 X94.212 Y88.382 E.23052
G1 X93.851 Y88.382 E.00764
G1 X93.851 Y84.563 E.08082
; WIPE_START
M204 S6000
G1 X93.851 Y82.563 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X93.869 Y90.196 Z.84 F18000
G1 X93.882 Y95.465 Z.84
G1 Z.44
G1 E.4 F1800
G1 F1500
M204 S500
G1 X93.904 Y95.411 E.00122
G1 X93.968 Y95.363 E.00169
G1 X94.157 Y95.318 E.00412
G1 X94.183 Y95.471 E.00328
G1 X94.151 Y95.598 E.00277
G1 X93.858 Y95.743 E.00691
G1 X93.877 Y95.525 E.00464
; WIPE_START
M204 S6000
G1 X93.904 Y95.411 E-.03621
G1 X93.968 Y95.363 E-.02486
G1 X94.157 Y95.318 E-.06043
G1 X94.183 Y95.471 E-.0482
G1 X94.151 Y95.598 E-.04067
G1 X93.858 Y95.743 E-.1015
G1 X93.877 Y95.525 E-.06814
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X88.048 Y97.114 Z.84 F18000
G1 Z.44
G1 E.4 F1800
G1 F1500
M204 S500
G1 X87.598 Y96.953 E.01012
G1 X87.225 Y96.88 E.00804
G1 X86.695 Y96.856 E.01123
M73 P35 R15
G1 X86.169 Y96.928 E.01124
G1 X85.684 Y97.086 E.0108
G1 X85.565 Y96.917 E.00436
G1 X85.909 Y96.544 E.01075
G1 X87.819 Y96.544 E.04041
G1 X88.172 Y96.95 E.01138
G1 X88.084 Y97.066 E.00309
; WIPE_START
M204 S6000
G1 X87.598 Y96.953 E-.09488
G1 X87.225 Y96.88 E-.07222
G1 X86.695 Y96.856 E-.1008
G1 X86.169 Y96.928 E-.10088
G1 X86.113 Y96.946 E-.01122
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X88.968 Y101.415 Z.84 F18000
G1 Z.44
G1 E.4 F1800
G1 F1500
M204 S500
G1 X88.699 Y101.741 E.00894
G1 X88.341 Y102.045 E.00995
G1 X87.942 Y102.275 E.00975
G1 X87.641 Y102.393 E.00683
G1 X87.329 Y102.474 E.00683
G1 X86.88 Y102.521 E.00956
G1 X86.558 Y102.507 E.00683
G1 X86.239 Y102.454 E.00683
G1 X85.801 Y102.312 E.00975
G1 X85.387 Y102.089 E.00995
G1 X85.02 Y101.796 E.00995
G1 X84.711 Y101.442 E.00995
G1 X84.474 Y101.046 E.00975
G1 X84.352 Y100.748 E.00683
G1 X84.266 Y100.437 E.00682
G1 X84.212 Y99.989 E.00956
G1 X84.222 Y99.666 E.00682
G1 X84.268 Y99.355 E.00666
G1 X84.405 Y98.907 E.00992
G1 X84.622 Y98.49 E.00996
G1 X84.91 Y98.118 E.00995
G1 X85.259 Y97.803 E.00995
G1 X85.651 Y97.561 E.00975
G1 X85.948 Y97.434 E.00683
G1 X86.257 Y97.344 E.00682
G1 X86.714 Y97.282 E.00976
G1 X87.174 Y97.302 E.00975
G1 X87.491 Y97.365 E.00683
G1 X87.789 Y97.462 E.00664
G1 X88.073 Y97.593 E.00663
G1 X88.348 Y97.763 E.00684
G1 X88.699 Y98.061 E.00975
G1 X88.998 Y98.425 E.00996
G1 X89.225 Y98.834 E.00991
G1 X89.336 Y99.129 E.00666
G1 X89.412 Y99.442 E.00682
G1 X89.453 Y99.901 E.00975
G1 X89.411 Y100.37 E.00996
G1 X89.285 Y100.821 E.00992
G1 X89.157 Y101.108 E.00666
G1 X89.003 Y101.366 E.00636
M204 S250
G1 X88.651 Y101.155 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X88.407 Y101.452 E.00758
G1 X88.104 Y101.709 E.0078
G1 X87.764 Y101.905 E.00773
G1 X87.515 Y102.003 E.00527
G1 X87.256 Y102.07 E.00526
G1 X86.868 Y102.111 E.00767
G1 X86.601 Y102.099 E.00526
G1 X86.337 Y102.055 E.00526
G1 X85.963 Y101.934 E.00773
G1 X85.614 Y101.746 E.0078
G1 X85.304 Y101.499 E.0078
G1 X85.043 Y101.2 E.0078
G1 X84.841 Y100.863 E.00773
G1 X84.74 Y100.615 E.00526
G1 X84.669 Y100.358 E.00526
G1 X84.622 Y99.97 E.00767
G1 X84.63 Y99.703 E.00526
G1 X84.669 Y99.446 E.00511
G1 X84.786 Y99.063 E.00789
G1 X84.968 Y98.711 E.0078
G1 X85.211 Y98.397 E.0078
G1 X85.506 Y98.132 E.0078
G1 X85.84 Y97.925 E.00773
G1 X86.086 Y97.82 E.00526
G1 X86.343 Y97.745 E.00526
G1 X86.732 Y97.692 E.00774
G1 X87.125 Y97.71 E.00773
G1 X87.388 Y97.762 E.00526
G1 X87.639 Y97.843 E.0052
G1 X87.879 Y97.954 E.0052
G1 X88.107 Y98.095 E.00527
G1 X88.407 Y98.349 E.00773
G1 X88.659 Y98.656 E.0078
G1 X88.853 Y99.006 E.00788
G1 X88.944 Y99.25 E.00511
G1 X89.007 Y99.509 E.00526
G1 X89.042 Y99.901 E.00773
G1 X89.007 Y100.296 E.0078
G1 X88.899 Y100.682 E.00789
G1 X88.793 Y100.919 E.00511
G1 X88.683 Y101.104 E.00423
; WIPE_START
M204 S6000
G1 X88.407 Y101.452 E-.08457
G1 X88.104 Y101.709 E-.07532
G1 X87.764 Y101.905 E-.07469
G1 X87.515 Y102.003 E-.05086
G1 X87.256 Y102.07 E-.0508
G1 X87.027 Y102.094 E-.04377
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X88.073 Y96.12 Z.84 F18000
G1 Z.44
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X93.399 Y96.12 E.11274
G1 X93.463 Y95.392 E.01546
G1 X93.514 Y95.242 E.00336
G1 X93.567 Y95.156 E.00214
G1 X93.628 Y95.087 E.00194
G1 X93.828 Y94.961 E.005
G1 X94.262 Y94.857 E.00944
G1 X100.01 Y86.648 E.21212
G1 X100.306 Y86.855 E.00765
G1 X94.547 Y95.08 E.21252
G1 X94.609 Y95.529 E.00958
G1 X94.582 Y95.672 E.00308
G1 X94.519 Y95.813 E.00326
G1 X94.427 Y95.922 E.00302
G1 X94.302 Y96.011 E.00326
G1 X94.079 Y96.109 E.00516
G1 X93.852 Y96.308 E.00638
G1 X93.723 Y96.387 E.00321
G1 X93.582 Y96.443 E.00321
G1 X93.441 Y96.472 E.00304
G1 X88.33 Y96.485 E.10817
G1 X89.506 Y97.834 E.03788
G1 X89.73 Y98.161 E.00839
G1 X89.919 Y98.526 E.00869
G1 X90.112 Y99.086 E.01254
G1 X90.205 Y99.681 E.01274
G1 X90.19 Y100.283 E.01275
G1 X90.069 Y100.872 E.01272
G1 X89.928 Y101.256 E.00867
G1 X89.748 Y101.61 E.00839
G1 X89.644 Y101.777 E.00417
G1 X89.396 Y102.103 E.00867
G1 X89.117 Y102.391 E.00849
G1 X88.798 Y102.65 E.00869
G1 X88.28 Y102.955 E.01273
G1 X87.716 Y103.164 E.01274
G1 X87.132 Y103.267 E.01254
G1 X86.731 Y103.279 E.0085
G1 X86.332 Y103.243 E.00849
G1 X85.93 Y103.159 E.00869
G1 X85.375 Y102.951 E.01254
G1 X85.024 Y102.757 E.00849
G1 X84.698 Y102.522 E.0085
G1 X84.403 Y102.251 E.00849
G1 X84.141 Y101.946 E.0085
G1 X83.918 Y101.613 E.00849
G1 X83.663 Y101.078 E.01254
G1 X83.548 Y100.699 E.00839
G1 X83.474 Y100.29 E.0088
G1 X83.452 Y99.89 E.00847
G1 X83.477 Y99.49 E.00849
G1 X83.549 Y99.095 E.0085
G1 X83.668 Y98.712 E.00849
G1 X83.831 Y98.345 E.00849
G1 X84.037 Y98 E.0085
G1 X84.287 Y97.675 E.00868
G1 X85.39 Y96.482 E.03439
G1 X80.368 Y96.482 E.1063
G1 X80.129 Y96.454 E.00508
G1 X79.93 Y96.381 E.0045
G1 X79.799 Y96.301 E.00324
G1 X79.661 Y96.17 E.00403
G1 X79.571 Y96.04 E.00333
G1 X79.481 Y95.821 E.00502
G1 X79.451 Y95.565 E.00546
G1 X79.451 Y77.628 E.37965
G1 X79.487 Y77.357 E.00578
G1 X79.547 Y77.206 E.00344
G1 X79.629 Y77.072 E.00333
G1 X79.814 Y76.89 E.00548
G1 X80.032 Y76.775 E.00521
G1 X80.281 Y76.723 E.0054
G1 X93.301 Y76.72 E.27556
G1 X93.542 Y76.749 E.00515
G1 X93.68 Y76.794 E.00306
G1 X93.856 Y76.889 E.00424
G1 X93.807 Y77.082 E.0042
G1 X80.786 Y77.082 E.2756
G1 X80.528 Y77.12 E.00552
G1 X80.226 Y77.271 E.00717
G1 X80.002 Y77.495 E.00668
G1 X79.85 Y77.797 E.00717
G1 X79.812 Y78.055 E.00552
G1 X79.812 Y95.146 E.36173
G1 X79.849 Y95.395 E.00533
G1 X79.974 Y95.665 E.00629
G1 X80.172 Y95.887 E.00629
G1 X80.441 Y96.052 E.00668
G1 X80.768 Y96.12 E.00708
G1 X88.013 Y96.12 E.15334
; WIPE_START
M204 S6000
G1 X90.013 Y96.12 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X89.228 Y96.892 Z.84 F18000
G1 Z.44
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X89.826 Y97.579 E.01791
G1 X89.966 Y97.77 E.00466
G1 X90.085 Y97.957 E.00436
G1 X90.293 Y98.359 E.00891
G1 X90.453 Y98.783 E.00891
G1 X90.511 Y98.994 E.00431
G1 X90.594 Y99.443 E.00897
G1 X90.614 Y99.661 E.00431
G1 X90.616 Y100.102 E.00868
G1 X90.596 Y100.335 E.0046
G1 X90.52 Y100.77 E.00868
G1 X90.46 Y100.995 E.00459
G1 X90.303 Y101.42 E.00891
M73 P36 R15
G1 X90.104 Y101.811 E.00862
G1 X89.981 Y102.009 E.0046
G1 X89.707 Y102.37 E.00891
G1 X89.394 Y102.693 E.00885
G1 X89.042 Y102.979 E.00891
G1 X88.861 Y103.102 E.00431
G1 X88.462 Y103.322 E.00896
G1 X88.262 Y103.411 E.00431
G1 X87.83 Y103.557 E.00897
G1 X87.617 Y103.608 E.00431
G1 X87.169 Y103.675 E.00891
G1 X86.719 Y103.689 E.00885
G1 X86.271 Y103.649 E.00885
G1 X85.828 Y103.555 E.00891
G1 X85.618 Y103.491 E.0043
G1 X85.199 Y103.321 E.00891
G1 X84.805 Y103.103 E.00884
G1 X84.44 Y102.84 E.00885
G1 X84.108 Y102.536 E.00885
G1 X83.815 Y102.195 E.00885
G1 X83.564 Y101.821 E.00885
G1 X83.358 Y101.417 E.00891
G1 X83.277 Y101.215 E.0043
G1 X83.149 Y100.795 E.00862
G1 X83.067 Y100.338 E.00914
G1 X83.042 Y99.889 E.00884
G1 X83.07 Y99.44 E.00885
G1 X83.151 Y98.997 E.00885
G1 X83.284 Y98.567 E.00885
G1 X83.467 Y98.156 E.00885
G1 X83.698 Y97.77 E.00885
G1 X83.974 Y97.411 E.00891
G1 X84.455 Y96.891 E.01393
G1 X80.344 Y96.891 E.08086
G1 X80.034 Y96.855 E.00613
G1 X79.75 Y96.751 E.00595
G1 X79.559 Y96.633 E.00442
G1 X79.447 Y96.539 E.00288
G1 X79.343 Y96.428 E.003
G1 X79.215 Y96.246 E.00438
G1 X79.119 Y96.039 E.00448
G1 X79.079 Y95.904 E.00277
G1 X79.042 Y95.589 E.00625
G1 X79.042 Y77.61 E.35362
G1 X79.062 Y77.374 E.00466
G1 X79.095 Y77.234 E.00283
G1 X79.18 Y77.022 E.00448
G1 X79.296 Y76.833 E.00438
G1 X79.392 Y76.718 E.00293
G1 X79.564 Y76.565 E.00453
G1 X79.684 Y76.486 E.00283
G1 X79.891 Y76.389 E.00448
G1 X80.106 Y76.332 E.00438
G1 X80.257 Y76.313 E.003
G1 X93.325 Y76.311 E.25703
G1 X93.632 Y76.347 E.00608
G1 X93.842 Y76.417 E.00436
G1 X94.04 Y76.524 E.00442
G1 X94.216 Y76.663 E.00442
G1 X94.366 Y76.831 E.00442
G1 X94.484 Y77.022 E.00442
G1 X94.567 Y77.231 E.00442
G1 X94.612 Y77.448 E.00436
G1 X94.621 Y88.791 E.2231
G1 X93.442 Y88.791 E.02321
G1 X93.442 Y77.491 E.22226
G1 X80.816 Y77.491 E.24833
G1 X80.653 Y77.515 E.00325
G1 X80.468 Y77.608 E.00406
G1 X80.338 Y77.737 E.00361
G1 X80.246 Y77.922 E.00407
G1 X80.222 Y78.085 E.00325
G1 X80.222 Y95.116 E.33498
G1 X80.245 Y95.276 E.00319
G1 X80.32 Y95.437 E.00349
G1 X80.438 Y95.57 E.00349
G1 X80.594 Y95.666 E.00361
G1 X80.81 Y95.711 E.00433
G1 X93.024 Y95.711 E.24024
G1 X93.058 Y95.327 E.00759
G1 X93.084 Y95.217 E.00222
G1 X93.147 Y95.058 E.00337
G1 X93.237 Y94.911 E.00339
G1 X93.35 Y94.785 E.00333
G1 X93.538 Y94.644 E.00462
G1 X93.692 Y94.572 E.00335
G1 X94.016 Y94.495 E.00653
G1 X99.909 Y86.078 E.20211
G1 X100.876 Y86.755 E.02321
G1 X94.979 Y95.177 E.20223
G1 X95.015 Y95.391 E.00427
G1 X95.019 Y95.562 E.00336
G1 X94.976 Y95.794 E.00464
G1 X94.879 Y96.012 E.0047
G1 X94.7 Y96.23 E.00554
G1 X94.505 Y96.369 E.0047
G1 X94.301 Y96.459 E.00438
G1 X94.096 Y96.639 E.00538
G1 X93.906 Y96.755 E.00438
G1 X93.698 Y96.837 E.00438
G1 X93.483 Y96.881 E.00433
G1 X89.288 Y96.892 E.08251
; WIPE_START
M204 S6000
G1 X89.826 Y97.579 E-.1658
G1 X89.966 Y97.77 E-.045
G1 X90.085 Y97.957 E-.0421
G1 X90.293 Y98.359 E-.0861
G1 X90.369 Y98.561 E-.04099
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
G1 X88.959 Y97.784
G1 Z.44
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.359578
G1 F1500
M204 S6000
G1 X89.301 Y98.201 E.00898
G1 X89.564 Y98.664 E.00888
G1 X89.697 Y99.028 E.00644
G1 X89.781 Y99.368 E.00584
G1 X89.827 Y99.886 E.00866
G1 X89.823 Y100.068 E.00303
G1 X89.746 Y100.596 E.00888
G1 X89.633 Y100.959 E.00633
G1 X89.494 Y101.272 E.00571
G1 X89.294 Y101.613 E.00658
G1 X88.957 Y102.015 E.00874
G1 X88.568 Y102.342 E.00847
G1 X88.116 Y102.612 E.00877
G1 X87.766 Y102.746 E.00624
G1 X87.408 Y102.84 E.00617
G1 X87.096 Y102.884 E.00524
G1 X86.743 Y102.897 E.00589
G1 X86.39 Y102.866 E.00589
G1 X85.879 Y102.741 E.00876
G1 X85.54 Y102.605 E.00608
G1 X85.192 Y102.412 E.00663
G1 X84.771 Y102.078 E.00895
G1 X84.445 Y101.716 E.00812
G1 X84.249 Y101.418 E.00592
G1 X84.081 Y101.094 E.00608
G1 X83.918 Y100.608 E.00854
G1 X83.856 Y100.245 E.00613
G1 X83.834 Y99.891 E.0059
G1 X83.847 Y99.623 E.00447
G1 X83.898 Y99.284 E.00571
G1 X84.026 Y98.846 E.0076
G1 X84.173 Y98.522 E.00593
G1 X84.353 Y98.215 E.00593
; LINE_WIDTH: 0.373102
G1 X84.622 Y97.871 E.00757
G1 X85.004 Y97.492 E.00933
; LINE_WIDTH: 0.409034
G1 X85.032 Y97.467 E.00072
; LINE_WIDTH: 0.434366
G1 X85.242 Y97.296 E.00551
; LINE_WIDTH: 0.477887
G1 X85.452 Y97.126 E.0061
; WIPE_START
G1 X85.242 Y97.296 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X88.279 Y97.161 Z.84 F18000
G1 Z.44
G1 E.4 F1800
; LINE_WIDTH: 0.480542
G1 F1500
M204 S6000
G1 X88.429 Y97.286 E.00444
; LINE_WIDTH: 0.455524
G1 X88.579 Y97.412 E.0042
; LINE_WIDTH: 0.418924
G1 X88.782 Y97.61 E.00556
; LINE_WIDTH: 0.378722
G1 X88.959 Y97.784 E.00438
; WIPE_START
G1 X88.782 Y97.61 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X93.61 Y96.144 Z.84 F18000
G1 Z.44
G1 E.4 F1800
; LINE_WIDTH: 0.109739
G1 F1500
M204 S6000
G1 X93.837 Y96.009 E.0011
; WIPE_START
G1 X93.61 Y96.144 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X85.978 Y96.205 Z.84 F18000
G1 X80.294 Y96.251 Z.84
G1 Z.44
G1 E.4 F1800
; LINE_WIDTH: 0.136739
G1 F1500
M204 S6000
G1 X79.989 Y96.091 E.00191
; LINE_WIDTH: 0.154948
G1 X79.812 Y95.9 E.00168
G1 X79.75 Y95.803 E.00074
; LINE_WIDTH: 0.102394
G1 X79.693 Y95.617 E.00074
; WIPE_START
G1 X79.75 Y95.803 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X79.724 Y88.17 Z.84 F18000
G1 X79.688 Y77.598 Z.84
G1 Z.44
G1 E.4 F1800
; LINE_WIDTH: 0.102634
G1 F1500
M204 S6000
G1 X79.739 Y77.434 E.00066
; LINE_WIDTH: 0.151792
G1 X79.788 Y77.329 E.00073
G1 X79.894 Y77.2 E.00105
G1 X80.061 Y77.059 E.00137
; LINE_WIDTH: 0.123553
G1 X80.229 Y76.991 E.00088
; LINE_WIDTH: 0.0893197
G1 X80.336 Y76.955 E.00036
; CHANGE_LAYER
; Z_HEIGHT: 0.56
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F1500
G1 X80.229 Y76.991 E-.38
; WIPE_END
G1 E-.02 F1800
; layer num/total_layer_count: 4/49
; update layer progress
M73 L4
M991 S0 P3 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z.84 I-.588 J1.066 P1  F18000
G1 X93.851 Y84.506 Z.84
G1 Z.56
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X93.851 Y77.128 E.15616
G1 X94.036 Y77.076 E.00407
G1 X94.117 Y77.207 E.00325
G1 X94.173 Y77.349 E.00324
G1 X94.202 Y77.49 E.00306
G1 X94.212 Y88.382 E.23052
G1 X93.851 Y88.382 E.00764
G1 X93.851 Y84.566 E.08075
; WIPE_START
M204 S6000
G1 X93.851 Y82.566 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X93.867 Y90.199 Z.96 F18000
G1 X93.877 Y95.495 Z.96
G1 Z.56
G1 E.4 F1800
G1 F1500
M204 S500
G1 X93.904 Y95.411 E.00188
G1 X93.967 Y95.363 E.00167
G1 X94.159 Y95.318 E.00417
G1 X94.184 Y95.493 E.00374
G1 X94.15 Y95.599 E.00236
G1 X93.862 Y95.741 E.00679
G1 X93.874 Y95.555 E.00395
; WIPE_START
M204 S6000
G1 X93.904 Y95.411 E-.046
G1 X93.967 Y95.363 E-.02467
G1 X94.159 Y95.318 E-.06137
G1 X94.184 Y95.493 E-.05507
G1 X94.15 Y95.599 E-.0347
G1 X93.862 Y95.741 E-.10003
G1 X93.874 Y95.555 E-.05817
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X88.051 Y97.115 Z.96 F18000
G1 Z.56
G1 E.4 F1800
G1 F1500
M204 S500
G1 X87.93 Y97.059 E.00282
G1 X87.436 Y96.915 E.0109
G1 X87.059 Y96.864 E.00804
G1 X86.695 Y96.859 E.00771
G1 X86.333 Y96.897 E.00771
G1 X85.962 Y96.981 E.00804
G1 X85.669 Y97.097 E.00668
G1 X85.554 Y96.929 E.00429
G1 X85.91 Y96.544 E.01109
G1 X87.821 Y96.544 E.04046
G1 X88.175 Y96.951 E.0114
G1 X88.087 Y97.067 E.00309
; WIPE_START
M204 S6000
G1 X87.93 Y97.059 E-.02986
G1 X87.436 Y96.915 E-.09782
G1 X87.059 Y96.864 E-.07219
G1 X86.695 Y96.859 E-.06923
G1 X86.333 Y96.897 E-.06917
G1 X86.119 Y96.946 E-.04172
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X88.968 Y101.413 Z.96 F18000
G1 Z.56
G1 E.4 F1800
G1 F1500
M204 S500
G1 X88.7 Y101.74 E.00895
G1 X88.348 Y102.039 E.00977
G1 X88.074 Y102.208 E.00682
G1 X87.791 Y102.34 E.0066
G1 X87.339 Y102.473 E.00997
G1 X86.88 Y102.521 E.00977
G1 X86.558 Y102.507 E.00683
G1 X86.239 Y102.454 E.00683
G1 X85.801 Y102.312 E.00975
G1 X85.387 Y102.089 E.00995
G1 X85.02 Y101.796 E.00995
G1 X84.711 Y101.442 E.00995
G1 X84.469 Y101.038 E.00997
G1 X84.305 Y100.596 E.00997
G1 X84.241 Y100.291 E.0066
G1 X84.212 Y99.97 E.00682
G1 X84.239 Y99.519 E.00956
G1 X84.306 Y99.204 E.00683
G1 X84.41 Y98.898 E.00683
G1 X84.622 Y98.489 E.00975
G1 X84.91 Y98.118 E.00995
G1 X85.259 Y97.803 E.00995
G1 X85.659 Y97.556 E.00995
G1 X86.088 Y97.388 E.00975
G1 X86.402 Y97.316 E.00683
G1 X86.714 Y97.283 E.00663
G1 X87.027 Y97.288 E.00663
G1 X87.347 Y97.331 E.00683
G1 X87.78 Y97.458 E.00955
G1 X88.073 Y97.593 E.00683
G1 X88.348 Y97.763 E.00683
G1 X88.699 Y98.061 E.00975
G1 X88.998 Y98.424 E.00995
G1 X89.222 Y98.826 E.00975
G1 X89.336 Y99.129 E.00683
G1 X89.412 Y99.442 E.00683
G1 X89.453 Y99.901 E.00975
G1 X89.411 Y100.369 E.00995
G1 X89.289 Y100.813 E.00976
G1 X89.158 Y101.108 E.00682
G1 X89.004 Y101.365 E.00635
M204 S250
G1 X88.651 Y101.154 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X88.407 Y101.452 E.00758
G1 X88.107 Y101.707 E.00774
M73 P37 R15
G1 X87.879 Y101.847 E.00526
G1 X87.646 Y101.956 E.00506
G1 X87.259 Y102.07 E.00793
G1 X86.868 Y102.111 E.00774
G1 X86.601 Y102.099 E.00526
G1 X86.337 Y102.055 E.00527
G1 X85.963 Y101.934 E.00773
G1 X85.614 Y101.746 E.0078
G1 X85.304 Y101.499 E.0078
G1 X85.043 Y101.2 E.00779
G1 X84.84 Y100.86 E.0078
G1 X84.699 Y100.482 E.00793
G1 X84.646 Y100.23 E.00506
G1 X84.622 Y99.964 E.00526
G1 X84.645 Y99.574 E.00767
G1 X84.701 Y99.313 E.00526
G1 X84.787 Y99.06 E.00526
G1 X84.969 Y98.711 E.00773
G1 X85.211 Y98.397 E.00779
G1 X85.505 Y98.132 E.0078
G1 X85.843 Y97.924 E.0078
G1 X86.209 Y97.78 E.00774
G1 X86.47 Y97.72 E.00526
G1 X86.732 Y97.693 E.0052
G1 X86.997 Y97.697 E.0052
G1 X87.262 Y97.733 E.00526
G1 X87.636 Y97.842 E.00767
G1 X87.879 Y97.954 E.00526
G1 X88.107 Y98.095 E.00526
G1 X88.406 Y98.349 E.00773
G1 X88.658 Y98.656 E.0078
G1 X88.85 Y98.999 E.00774
G1 X88.944 Y99.249 E.00526
G1 X89.007 Y99.509 E.00526
G1 X89.042 Y99.901 E.00773
G1 X89.007 Y100.296 E.0078
G1 X88.902 Y100.675 E.00774
G1 X88.794 Y100.919 E.00526
G1 X88.684 Y101.104 E.00423
; WIPE_START
M204 S6000
G1 X88.407 Y101.452 E-.08454
G1 X88.107 Y101.707 E-.07477
G1 X87.879 Y101.847 E-.05079
G1 X87.646 Y101.956 E-.04888
G1 X87.259 Y102.07 E-.0766
G1 X87.027 Y102.094 E-.04441
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X88.075 Y96.12 Z.96 F18000
G1 Z.56
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X93.414 Y96.12 E.113
G1 X93.456 Y95.439 E.01445
G1 X93.477 Y95.336 E.00222
G1 X93.567 Y95.157 E.00423
G1 X93.631 Y95.085 E.00205
G1 X93.828 Y94.96 E.00494
G1 X94.262 Y94.857 E.00942
G1 X100.01 Y86.648 E.21212
G1 X100.306 Y86.855 E.00765
G1 X94.552 Y95.072 E.21231
G1 X94.61 Y95.52 E.00955
G1 X94.582 Y95.671 E.00325
G1 X94.521 Y95.808 E.00318
G1 X94.435 Y95.916 E.00293
G1 X94.302 Y96.011 E.00346
G1 X94.079 Y96.109 E.00516
G1 X93.852 Y96.308 E.00638
G1 X93.723 Y96.387 E.00321
G1 X93.581 Y96.443 E.00322
G1 X93.441 Y96.472 E.00304
G1 X88.332 Y96.485 E.10814
G1 X89.515 Y97.845 E.03814
G1 X89.627 Y98 E.00406
G1 X89.919 Y98.526 E.01273
G1 X90.063 Y98.91 E.00868
G1 X90.185 Y99.481 E.01236
G1 X90.205 Y99.682 E.00428
G1 X90.207 Y100.082 E.00846
G1 X90.19 Y100.283 E.00427
G1 X90.119 Y100.686 E.00866
G1 X90.003 Y101.07 E.0085
G1 X89.749 Y101.607 E.01257
G1 X89.527 Y101.94 E.00846
G1 X89.267 Y102.245 E.00849
G1 X88.965 Y102.522 E.00869
G1 X88.639 Y102.757 E.0085
G1 X88.288 Y102.951 E.00849
G1 X87.725 Y103.161 E.01273
G1 X87.132 Y103.267 E.01273
G1 X86.731 Y103.279 E.0085
G1 X86.332 Y103.243 E.00849
G1 X85.939 Y103.161 E.00849
G1 X85.559 Y103.032 E.00849
G1 X85.032 Y102.762 E.01254
G1 X84.698 Y102.522 E.00869
G1 X84.403 Y102.251 E.00849
G1 X84.141 Y101.947 E.00849
G1 X83.918 Y101.613 E.0085
G1 X83.663 Y101.078 E.01254
G1 X83.549 Y100.703 E.00829
G1 X83.474 Y100.289 E.0089
G1 X83.452 Y99.89 E.00847
G1 X83.477 Y99.49 E.00849
G1 X83.549 Y99.095 E.00849
G1 X83.668 Y98.712 E.00849
G1 X83.831 Y98.345 E.00849
G1 X84.037 Y98 E.00849
G1 X84.287 Y97.675 E.00868
G1 X85.39 Y96.482 E.03439
G1 X80.368 Y96.482 E.1063
G1 X80.039 Y96.43 E.00703
G1 X79.814 Y96.312 E.00539
G1 X79.699 Y96.21 E.00324
G1 X79.562 Y96.024 E.00489
G1 X79.48 Y95.812 E.00482
G1 X79.451 Y95.565 E.00527
G1 X79.451 Y77.628 E.37965
G1 X79.489 Y77.349 E.00597
G1 X79.598 Y77.118 E.0054
G1 X79.76 Y76.933 E.0052
G1 X79.892 Y76.84 E.00343
G1 X80.032 Y76.775 E.00325
G1 X80.282 Y76.723 E.00541
G1 X93.302 Y76.72 E.27559
G1 X93.542 Y76.749 E.00512
G1 X93.68 Y76.794 E.00306
G1 X93.856 Y76.889 E.00424
G1 X93.807 Y77.082 E.0042
G1 X80.778 Y77.082 E.27579
G1 X80.489 Y77.132 E.0062
G1 X80.218 Y77.278 E.00651
G1 X80 Y77.497 E.00654
G1 X79.85 Y77.798 E.00711
G1 X79.812 Y78.056 E.00552
G1 X79.812 Y95.146 E.36173
G1 X79.849 Y95.395 E.00533
G1 X79.975 Y95.665 E.0063
G1 X80.172 Y95.887 E.00629
G1 X80.441 Y96.053 E.00668
G1 X80.769 Y96.12 E.00708
G1 X88.015 Y96.12 E.15338
; WIPE_START
M204 S6000
G1 X90.015 Y96.12 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X89.228 Y96.892 Z.96 F18000
G1 Z.56
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X89.835 Y97.59 E.01819
G1 X90.085 Y97.957 E.00873
G1 X90.293 Y98.359 E.00892
G1 X90.453 Y98.783 E.00891
G1 X90.511 Y98.994 E.00431
G1 X90.591 Y99.424 E.00859
G1 X90.614 Y99.661 E.00469
G1 X90.616 Y100.098 E.00858
G1 X90.596 Y100.335 E.00469
G1 X90.518 Y100.781 E.0089
G1 X90.387 Y101.212 E.00885
G1 X90.214 Y101.609 E.00853
G1 X90.1 Y101.819 E.00469
G1 X89.858 Y102.182 E.00858
G1 X89.707 Y102.37 E.00475
G1 X89.557 Y102.534 E.00435
G1 X89.224 Y102.84 E.00891
G1 X88.858 Y103.103 E.00885
G1 X88.465 Y103.321 E.00885
G1 X88.045 Y103.491 E.00891
G1 X87.833 Y103.556 E.00436
G1 X87.617 Y103.609 E.00437
G1 X87.169 Y103.675 E.0089
G1 X86.719 Y103.689 E.00885
G1 X86.271 Y103.649 E.00885
G1 X85.831 Y103.556 E.00885
G1 X85.405 Y103.412 E.00885
G1 X84.996 Y103.216 E.00891
G1 X84.807 Y103.105 E.0043
G1 X84.44 Y102.84 E.00891
G1 X84.108 Y102.536 E.00885
G1 X83.815 Y102.195 E.00885
G1 X83.564 Y101.821 E.00885
G1 X83.358 Y101.417 E.00891
G1 X83.277 Y101.214 E.00431
G1 X83.151 Y100.8 E.00853
G1 X83.067 Y100.337 E.00924
G1 X83.042 Y99.888 E.00885
G1 X83.07 Y99.44 E.00885
G1 X83.151 Y98.997 E.00885
G1 X83.284 Y98.567 E.00885
G1 X83.467 Y98.156 E.00885
G1 X83.698 Y97.77 E.00885
G1 X83.974 Y97.411 E.00891
G1 X84.455 Y96.891 E.01393
G1 X80.344 Y96.891 E.08086
G1 X80.028 Y96.854 E.00625
G1 X79.893 Y96.814 E.00277
G1 X79.684 Y96.716 E.00454
G1 X79.564 Y96.637 E.00283
G1 X79.396 Y96.488 E.00442
G1 X79.212 Y96.24 E.00607
G1 X79.149 Y96.114 E.00277
G1 X79.078 Y95.901 E.00442
G1 X79.042 Y95.589 E.00619
G1 X79.042 Y77.61 E.35362
G1 X79.062 Y77.374 E.00466
G1 X79.096 Y77.231 E.00289
G1 X79.146 Y77.093 E.00289
G1 X79.255 Y76.892 E.00448
G1 X79.396 Y76.714 E.00448
G1 X79.5 Y76.615 E.00283
G1 X79.687 Y76.484 E.00448
G1 X79.891 Y76.389 E.00443
G1 X80.104 Y76.332 E.00434
G1 X80.257 Y76.313 E.00303
G1 X93.326 Y76.311 E.25706
G1 X93.632 Y76.347 E.00605
G1 X93.842 Y76.417 E.00436
G1 X94.04 Y76.524 E.00442
G1 X94.216 Y76.663 E.00442
G1 X94.366 Y76.831 E.00442
G1 X94.484 Y77.022 E.00442
G1 X94.567 Y77.231 E.00442
G1 X94.612 Y77.448 E.00436
G1 X94.621 Y88.791 E.2231
G1 X93.442 Y88.791 E.02321
G1 X93.442 Y77.491 E.22226
G1 X80.813 Y77.491 E.24839
G1 X80.625 Y77.524 E.00376
G1 X80.466 Y77.61 E.00356
G1 X80.337 Y77.739 E.00359
G1 X80.246 Y77.922 E.00402
G1 X80.222 Y78.086 E.00325
G1 X80.222 Y95.116 E.33497
G1 X80.245 Y95.276 E.00319
G1 X80.32 Y95.437 E.00349
G1 X80.438 Y95.57 E.00349
G1 X80.594 Y95.666 E.00361
G1 X80.81 Y95.711 E.00433
G1 X93.029 Y95.711 E.24033
G1 X93.049 Y95.384 E.00644
G1 X93.084 Y95.218 E.00334
G1 X93.147 Y95.058 E.00339
G1 X93.237 Y94.911 E.00338
G1 X93.354 Y94.781 E.00343
G1 X93.538 Y94.644 E.00451
G1 X93.694 Y94.572 E.00338
G1 X94.016 Y94.495 E.00651
G1 X99.909 Y86.078 E.20211
G1 X100.876 Y86.755 E.02321
G1 X94.98 Y95.175 E.20217
G1 X95.019 Y95.559 E.0076
G1 X94.976 Y95.794 E.0047
G1 X94.877 Y96.014 E.00475
G1 X94.702 Y96.228 E.00543
G1 X94.505 Y96.369 E.00476
G1 X94.301 Y96.459 E.00438
G1 X94.096 Y96.639 E.00538
G1 X93.906 Y96.755 E.00438
G1 X93.698 Y96.837 E.00438
G1 X93.483 Y96.881 E.00433
G1 X89.288 Y96.892 E.0825
; WIPE_START
M204 S6000
G1 X89.835 Y97.59 E-.1685
G1 X90.085 Y97.957 E-.0843
G1 X90.293 Y98.359 E-.08612
G1 X90.37 Y98.562 E-.04108
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




G1 X88.959 Y97.784
G1 Z.56
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.360297
G1 F1500
M204 S6000
G1 X89.212 Y98.081 E.00652
G1 X89.399 Y98.355 E.00553
G1 X89.571 Y98.678 E.00611
G1 X89.74 Y99.175 E.00875
G1 X89.821 Y99.704 E.00893
G1 X89.827 Y99.915 E.00353
G1 X89.784 Y100.422 E.00848
G1 X89.647 Y100.937 E.0089
G1 X89.42 Y101.414 E.00882
G1 X89.219 Y101.711 E.00598
G1 X88.981 Y101.994 E.00619
G1 X88.579 Y102.336 E.0088
G1 X88.244 Y102.545 E.00659
G1 X87.913 Y102.696 E.00608
G1 X87.463 Y102.833 E.00786
G1 X87.098 Y102.884 E.00614
G1 X86.743 Y102.897 E.00594
G1 X86.388 Y102.865 E.00594
G1 X86.04 Y102.791 E.00594
G1 X85.64 Y102.652 E.00707
G1 X85.192 Y102.412 E.00848
G1 X84.77 Y102.078 E.00898
G1 X84.445 Y101.716 E.00813
G1 X84.249 Y101.418 E.00594
G1 X84.082 Y101.094 E.0061
G1 X83.94 Y100.689 E.00715
G1 X83.854 Y100.245 E.00755
G1 X83.834 Y99.891 E.00591
G1 X83.863 Y99.481 E.00686
G1 X83.945 Y99.094 E.00661
G1 X84.068 Y98.739 E.00627
G1 X84.353 Y98.215 E.00995
; LINE_WIDTH: 0.373106
G1 X84.622 Y97.871 E.00757
M73 P38 R15
G1 X85.004 Y97.492 E.00933
; LINE_WIDTH: 0.428918
G1 X85.233 Y97.301 E.00599
; LINE_WIDTH: 0.471313
G1 X85.437 Y97.133 E.00586
; WIPE_START
G1 X85.233 Y97.301 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X88.281 Y97.162 Z.96 F18000
G1 Z.56
G1 E.4 F1800
; LINE_WIDTH: 0.468123
G1 F1500
M204 S6000
G1 X88.579 Y97.411 E.00857
; LINE_WIDTH: 0.419308
G1 X88.782 Y97.609 E.00556
; LINE_WIDTH: 0.37882
G1 X88.959 Y97.784 E.00438
; WIPE_START
G1 X88.782 Y97.609 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X93.626 Y96.136 Z.96 F18000
G1 Z.56
G1 E.4 F1800
; LINE_WIDTH: 0.108389
G1 F1500
M204 S6000
G1 X93.837 Y96.009 E.00102
; WIPE_START
G1 X93.626 Y96.136 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X85.993 Y96.205 Z.96 F18000
G1 X80.281 Y96.257 Z.96
G1 Z.56
G1 E.4 F1800
; LINE_WIDTH: 0.149694
G1 F1500
M204 S6000
G1 X79.988 Y96.092 E.00208
G1 X79.909 Y96.017 E.00068
G1 X79.751 Y95.803 E.00164
; LINE_WIDTH: 0.104039
G1 X79.693 Y95.617 E.00076
; WIPE_START
G1 X79.751 Y95.803 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X79.725 Y88.171 Z.96 F18000
G1 X79.688 Y77.598 Z.96
G1 Z.56
G1 E.4 F1800
; LINE_WIDTH: 0.0973321
G1 F1500
M204 S6000
G1 X79.721 Y77.482 E.00043
; LINE_WIDTH: 0.125368
G1 X79.766 Y77.369 E.0006
; LINE_WIDTH: 0.154427
G1 X79.941 Y77.154 E.00178
G1 X80.052 Y77.069 E.0009
; LINE_WIDTH: 0.125247
G1 X80.226 Y76.991 E.00095
; LINE_WIDTH: 0.089604
G1 X80.328 Y76.955 E.00034
; CHANGE_LAYER
; Z_HEIGHT: 0.68
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F1500
G1 X80.226 Y76.991 E-.38
; WIPE_END
G1 E-.02 F1800
; layer num/total_layer_count: 5/49
; update layer progress
M73 L5
M991 S0 P4 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z.96 I-.587 J1.066 P1  F18000
G1 X93.851 Y84.501 Z.96
G1 Z.68
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X93.851 Y77.128 E.15606
G1 X94.036 Y77.076 E.00407
G1 X94.117 Y77.207 E.00325
G1 X94.173 Y77.349 E.00324
G1 X94.202 Y77.49 E.00306
G1 X94.212 Y88.382 E.23052
G1 X93.851 Y88.382 E.00764
G1 X93.851 Y84.561 E.08086
; WIPE_START
M204 S6000
G1 X93.851 Y82.561 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X93.867 Y90.194 Z1.08 F18000
G1 X93.878 Y95.494 Z1.08
G1 Z.68
G1 E.4 F1800
G1 F1500
M204 S500
G1 X93.904 Y95.41 E.00186
G1 X93.967 Y95.363 E.00167
G1 X94.157 Y95.318 E.00412
G1 X94.185 Y95.485 E.00358
G1 X94.17 Y95.567 E.00178
G1 X94.132 Y95.611 E.00123
G1 X93.862 Y95.741 E.00634
G1 X93.874 Y95.554 E.00397
; WIPE_START
M204 S6000
G1 X93.904 Y95.41 E-.04582
G1 X93.967 Y95.363 E-.02462
G1 X94.157 Y95.318 E-.06076
G1 X94.185 Y95.485 E-.05274
G1 X94.17 Y95.567 E-.02615
G1 X94.132 Y95.611 E-.01806
G1 X93.862 Y95.741 E-.0934
G1 X93.874 Y95.554 E-.05845
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X88.057 Y97.103 Z1.08 F18000
G1 Z.68
G1 E.4 F1800
G1 F1500
M204 S500
G1 X87.598 Y96.953 E.01021
G1 X87.225 Y96.88 E.00804
G1 X86.695 Y96.856 E.01123
G1 X86.153 Y96.93 E.01157
G1 X85.588 Y97.113 E.01259
G1 X85.481 Y96.953 E.00409
G1 X85.833 Y96.544 E.01141
G1 X87.817 Y96.544 E.042
G1 X88.164 Y96.941 E.01114
G1 X88.09 Y97.053 E.00283
; WIPE_START
M204 S6000
G1 X87.598 Y96.953 E-.09536
G1 X87.225 Y96.88 E-.07221
G1 X86.695 Y96.856 E-.1008
G1 X86.153 Y96.93 E-.10385
G1 X86.114 Y96.942 E-.00778
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X88.968 Y101.414 Z1.08 F18000
G1 Z.68
G1 E.4 F1800
G1 F1500
M204 S500
G1 X88.699 Y101.741 E.00895
G1 X88.348 Y102.039 E.00975
G1 X88.074 Y102.208 E.00682
G1 X87.793 Y102.338 E.00654
G1 X87.34 Y102.473 E.01002
G1 X86.88 Y102.521 E.00978
G1 X86.558 Y102.507 E.00682
G1 X86.253 Y102.457 E.00654
G1 X85.802 Y102.312 E.01002
G1 X85.387 Y102.089 E.00998
G1 X85.02 Y101.796 E.00995
G1 X84.711 Y101.442 E.00995
G1 X84.474 Y101.046 E.00975
G1 X84.352 Y100.748 E.00683
G1 X84.266 Y100.437 E.00683
G1 X84.212 Y99.989 E.00955
G1 X84.222 Y99.666 E.00683
G1 X84.27 Y99.347 E.00683
G1 X84.406 Y98.907 E.00975
G1 X84.622 Y98.489 E.00995
G1 X84.91 Y98.118 E.00995
G1 X85.252 Y97.809 E.00975
G1 X85.521 Y97.632 E.00683
G1 X85.81 Y97.487 E.00683
G1 X86.248 Y97.345 E.00975
G1 X86.714 Y97.282 E.00995
G1 X87.174 Y97.302 E.00975
G1 X87.491 Y97.365 E.00683
G1 X87.798 Y97.465 E.00683
G1 X88.21 Y97.671 E.00975
G1 X88.578 Y97.947 E.00975
G1 X88.805 Y98.177 E.00683
G1 X89.002 Y98.432 E.00683
G1 X89.222 Y98.826 E.00955
G1 X89.336 Y99.129 E.00684
G1 X89.412 Y99.442 E.00683
G1 X89.453 Y99.902 E.00978
G1 X89.409 Y100.374 E.01002
G1 X89.335 Y100.674 E.00654
G1 X89.222 Y100.975 E.00683
G1 X89.004 Y101.367 E.00948
M204 S250
G1 X88.652 Y101.154 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X88.407 Y101.452 E.00759
G1 X88.107 Y101.707 E.00773
G1 X87.879 Y101.847 E.00526
G1 X87.648 Y101.955 E.00501
G1 X87.259 Y102.07 E.00798
G1 X86.868 Y102.111 E.00774
G1 X86.601 Y102.099 E.00525
G1 X86.349 Y102.058 E.00501
G1 X85.963 Y101.934 E.00798
G1 X85.614 Y101.746 E.00781
G1 X85.304 Y101.499 E.0078
G1 X85.043 Y101.2 E.0078
G1 X84.841 Y100.863 E.00774
G1 X84.74 Y100.615 E.00526
G1 X84.669 Y100.357 E.00526
G1 X84.622 Y99.97 E.00767
G1 X84.63 Y99.703 E.00526
G1 X84.67 Y99.438 E.00526
G1 X84.786 Y99.062 E.00773
G1 X84.969 Y98.711 E.0078
G1 X85.211 Y98.397 E.00779
G1 X85.503 Y98.134 E.00773
G1 X85.726 Y97.987 E.00526
G1 X85.966 Y97.867 E.00526
G1 X86.34 Y97.746 E.00773
G1 X86.732 Y97.692 E.0078
G1 X87.125 Y97.71 E.00773
G1 X87.388 Y97.762 E.00526
G1 X87.642 Y97.844 E.00526
G1 X87.994 Y98.02 E.00774
G1 X88.308 Y98.256 E.00773
G1 X88.496 Y98.447 E.00526
G1 X88.66 Y98.658 E.00526
G1 X88.85 Y98.999 E.00767
G1 X88.944 Y99.25 E.00527
G1 X89.007 Y99.509 E.00526
G1 X89.043 Y99.901 E.00774
G1 X89.005 Y100.305 E.00798
G1 X88.944 Y100.552 E.00501
G1 X88.85 Y100.803 E.00526
G1 X88.683 Y101.103 E.00675
; WIPE_START
M204 S6000
G1 X88.407 Y101.452 E-.08463
G1 X88.107 Y101.707 E-.07472
G1 X87.879 Y101.847 E-.05078
G1 X87.648 Y101.955 E-.04841
G1 X87.259 Y102.07 E-.07707
G1 X87.027 Y102.094 E-.0444
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X88.071 Y96.12 Z1.08 F18000
G1 Z.68
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X93.414 Y96.12 E.11307
G1 X93.456 Y95.437 E.01448
G1 X93.477 Y95.336 E.0022
G1 X93.567 Y95.157 E.00423
G1 X93.632 Y95.084 E.00208
G1 X93.829 Y94.96 E.00493
G1 X94.261 Y94.858 E.0094
G1 X100.01 Y86.648 E.21212
G1 X100.306 Y86.855 E.00765
G1 X94.547 Y95.08 E.21251
G1 X94.609 Y95.529 E.00959
G1 X94.58 Y95.681 E.00328
G1 X94.542 Y95.775 E.00216
G1 X94.42 Y95.927 E.00412
G1 X94.302 Y96.011 E.00307
G1 X94.079 Y96.109 E.00516
G1 X93.852 Y96.308 E.00638
G1 X93.723 Y96.387 E.00321
G1 X93.581 Y96.443 E.00322
G1 X93.441 Y96.472 E.00304
G1 X88.329 Y96.485 E.1082
G1 X89.5 Y97.827 E.03771
G1 X89.628 Y98.001 E.00457
G1 X89.919 Y98.526 E.01271
G1 X90.056 Y98.889 E.0082
G1 X90.113 Y99.088 E.00438
G1 X90.185 Y99.477 E.00837
G1 X90.205 Y99.682 E.00437
G1 X90.206 Y100.091 E.00865
G1 X90.16 Y100.489 E.00849
G1 X90.006 Y101.062 E.01255
G1 X89.745 Y101.615 E.01295
G1 X89.644 Y101.776 E.00402
G1 X89.267 Y102.245 E.01274
G1 X88.982 Y102.508 E.0082
G1 X88.638 Y102.757 E.009
G1 X88.28 Y102.955 E.00866
G1 X87.716 Y103.163 E.01273
G1 X87.132 Y103.267 E.01254
G1 X86.731 Y103.279 E.0085
G1 X86.332 Y103.243 E.00849
G1 X85.939 Y103.161 E.00849
G1 X85.552 Y103.029 E.00865
G1 X85.025 Y102.757 E.01256
G1 X84.698 Y102.522 E.00851
G1 X84.403 Y102.251 E.00849
G1 X84.141 Y101.947 E.00849
G1 X83.918 Y101.613 E.0085
G1 X83.663 Y101.078 E.01255
G1 X83.55 Y100.708 E.00819
G1 X83.474 Y100.289 E.009
G1 X83.452 Y99.89 E.00846
G1 X83.477 Y99.49 E.00849
G1 X83.55 Y99.095 E.0085
G1 X83.668 Y98.712 E.00849
G1 X83.835 Y98.336 E.00869
G1 X84.141 Y97.856 E.01206
G1 X85.327 Y96.482 E.03842
G1 X80.368 Y96.482 E.10496
G1 X80.12 Y96.453 E.00528
G1 X79.982 Y96.407 E.00308
G1 X79.718 Y96.228 E.00675
G1 X79.571 Y96.042 E.00502
G1 X79.48 Y95.813 E.00521
G1 X79.451 Y95.565 E.00528
G1 X79.451 Y77.619 E.37984
G1 X79.49 Y77.348 E.00579
G1 X79.593 Y77.124 E.00521
G1 X79.76 Y76.933 E.00537
G1 X79.893 Y76.84 E.00345
G1 X80.033 Y76.774 E.00327
G1 X80.29 Y76.723 E.00554
G1 X93.304 Y76.72 E.27546
G1 X93.542 Y76.749 E.00508
G1 X93.68 Y76.794 E.00307
G1 X93.856 Y76.889 E.00424
G1 X93.807 Y77.082 E.0042
G1 X80.785 Y77.082 E.27562
G1 X80.524 Y77.121 E.00559
G1 X80.217 Y77.276 E.00729
G1 X79.978 Y77.53 E.00738
G1 X79.848 Y77.811 E.00656
G1 X79.812 Y78.057 E.00525
G1 X79.812 Y95.146 E.36171
G1 X79.849 Y95.395 E.00533
G1 X79.974 Y95.664 E.00629
G1 X80.172 Y95.887 E.0063
G1 X80.441 Y96.053 E.00669
G1 X80.768 Y96.12 E.00707
G1 X88.011 Y96.12 E.1533
; WIPE_START
M204 S6000
G1 X90.011 Y96.12 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X89.227 Y96.892 Z1.08 F18000
G1 Z.68
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X89.82 Y97.571 E.01774
G1 X89.966 Y97.77 E.00485
G1 X90.085 Y97.957 E.00436
G1 X90.294 Y98.359 E.00891
G1 X90.445 Y98.761 E.00844
G1 X90.511 Y98.995 E.00479
G1 X90.59 Y99.419 E.00849
G1 X90.614 Y99.661 E.00478
G1 X90.615 Y100.114 E.0089
G1 X90.563 Y100.56 E.00885
G1 X90.458 Y101.001 E.00891
G1 X90.389 Y101.209 E.00431
G1 X90.216 Y101.605 E.0085
G1 X90.099 Y101.822 E.00484
G1 X89.981 Y102.009 E.00436
G1 X89.705 Y102.372 E.00897
G1 X89.557 Y102.534 E.0043
G1 X89.242 Y102.825 E.00844
G1 X88.858 Y103.103 E.00933
G1 X88.462 Y103.322 E.0089
G1 X88.262 Y103.411 E.00431
G1 X87.83 Y103.557 E.00897
G1 X87.617 Y103.609 E.00431
G1 X87.169 Y103.675 E.0089
G1 X86.719 Y103.689 E.00885
G1 X86.271 Y103.649 E.00885
G1 X85.831 Y103.556 E.00885
G1 X85.402 Y103.411 E.0089
G1 X85.18 Y103.311 E.00478
G1 X84.805 Y103.103 E.00844
G1 X84.44 Y102.84 E.00886
G1 X84.108 Y102.536 E.00885
G1 X83.815 Y102.195 E.00885
G1 X83.564 Y101.821 E.00885
G1 X83.358 Y101.417 E.00891
G1 X83.277 Y101.214 E.00431
G1 X83.152 Y100.804 E.00843
G1 X83.067 Y100.337 E.00933
G1 X83.042 Y99.889 E.00884
G1 X83.07 Y99.44 E.00885
G1 X83.151 Y98.997 E.00885
G1 X83.284 Y98.567 E.00885
G1 X83.469 Y98.153 E.00891
G1 X83.575 Y97.962 E.0043
G1 X83.816 Y97.607 E.00844
G1 X84.433 Y96.891 E.0186
G1 X80.344 Y96.891 E.08044
G1 X80.031 Y96.854 E.00619
G1 X79.826 Y96.787 E.00425
G1 X79.692 Y96.72 E.00293
G1 X79.439 Y96.53 E.00623
G1 X79.296 Y96.369 E.00425
G1 X79.215 Y96.246 E.00289
G1 X79.146 Y96.107 E.00306
G1 X79.078 Y95.901 E.00425
G1 X79.042 Y95.589 E.00619
G1 X79.042 Y77.607 E.35368
G1 X79.051 Y77.454 E.00301
G1 X79.097 Y77.231 E.00449
G1 X79.177 Y77.027 E.00431
G1 X79.253 Y76.895 E.003
G1 X79.396 Y76.714 E.00453
G1 X79.5 Y76.615 E.00283
G1 X79.687 Y76.484 E.00448
G1 X79.886 Y76.391 E.00431
G1 X80.032 Y76.347 E.003
G1 X80.26 Y76.313 E.00453
G1 X93.328 Y76.311 E.25704
G1 X93.632 Y76.347 E.00601
G1 X93.842 Y76.417 E.00437
G1 X94.04 Y76.524 E.00442
G1 X94.216 Y76.663 E.00442
G1 X94.366 Y76.831 E.00442
G1 X94.484 Y77.022 E.00442
G1 X94.567 Y77.231 E.00442
G1 X94.612 Y77.448 E.00436
G1 X94.621 Y88.791 E.2231
G1 X93.442 Y88.791 E.02321
G1 X93.442 Y77.491 E.22226
G1 X80.816 Y77.491 E.24834
G1 X80.65 Y77.516 E.0033
G1 X80.465 Y77.609 E.00407
G1 X80.321 Y77.762 E.00414
G1 X80.244 Y77.928 E.0036
G1 X80.222 Y78.086 E.00313
G1 X80.222 Y95.116 E.33497
G1 X80.245 Y95.277 E.00319
G1 X80.32 Y95.437 E.00349
G1 X80.438 Y95.57 E.00349
G1 X80.595 Y95.666 E.00362
G1 X80.81 Y95.711 E.00433
G1 X93.029 Y95.711 E.24033
G1 X93.049 Y95.383 E.00647
G1 X93.084 Y95.218 E.00331
G1 X93.147 Y95.058 E.00339
G1 X93.237 Y94.911 E.00338
G1 X93.355 Y94.78 E.00346
G1 X93.538 Y94.644 E.00448
G1 X93.695 Y94.571 E.00341
G1 X94.016 Y94.495 E.00648
G1 X99.909 Y86.078 E.20211
G1 X100.876 Y86.755 E.02321
G1 X94.979 Y95.177 E.20223
G1 X95.015 Y95.394 E.00432
G1 X95.019 Y95.562 E.00331
G1 X94.975 Y95.797 E.00471
G1 X94.854 Y96.051 E.00554
G1 X94.697 Y96.232 E.0047
G1 X94.505 Y96.369 E.00464
G1 X94.301 Y96.459 E.00439
G1 X94.096 Y96.639 E.00538
G1 X93.906 Y96.755 E.00438
G1 X93.698 Y96.837 E.00438
G1 X93.483 Y96.881 E.00433
M73 P39 R15
G1 X89.287 Y96.892 E.08252
; WIPE_START
M204 S6000
G1 X89.82 Y97.571 E-.16408
G1 X89.966 Y97.77 E-.04682
G1 X90.085 Y97.957 E-.04207
G1 X90.294 Y98.359 E-.08611
G1 X90.37 Y98.561 E-.04091
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




G1 X88.825 Y97.645
G1 Z.68
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.397331
G1 F1500
M204 S6000
G1 X88.703 Y97.532 E.00308
; LINE_WIDTH: 0.432127
G1 X88.581 Y97.419 E.00337
; LINE_WIDTH: 0.467555
G1 X88.455 Y97.302 E.00379
; LINE_WIDTH: 0.469917
G1 X88.293 Y97.338 E.00368
; LINE_WIDTH: 0.438435
G1 X88.131 Y97.375 E.00342
M204 S10000
G1 X88.825 Y97.645 F18000
; LINE_WIDTH: 0.36008
G1 F1500
M204 S6000
G1 X89.095 Y97.936 E.00663
G1 X89.324 Y98.235 E.00627
G1 X89.571 Y98.678 E.00847
G1 X89.695 Y99.007 E.00587
G1 X89.804 Y99.528 E.00886
G1 X89.827 Y99.918 E.00652
G1 X89.786 Y100.423 E.00846
G1 X89.695 Y100.795 E.00639
G1 X89.503 Y101.257 E.00835
G1 X89.302 Y101.603 E.00667
G1 X88.976 Y101.993 E.00848
G1 X88.579 Y102.336 E.00875
G1 X88.115 Y102.61 E.00899
G1 X87.612 Y102.793 E.00893
G1 X87.398 Y102.842 E.00365
G1 X86.879 Y102.898 E.00871
G1 X86.388 Y102.865 E.00821
G1 X86.04 Y102.791 E.00594
G1 X85.669 Y102.666 E.00654
G1 X85.192 Y102.412 E.00901
G1 X84.77 Y102.078 E.00897
G1 X84.445 Y101.716 E.00812
G1 X84.249 Y101.419 E.00593
G1 X84.081 Y101.094 E.0061
G1 X83.921 Y100.616 E.00841
G1 X83.856 Y100.244 E.00629
G1 X83.835 Y99.993 E.0042
G1 X83.845 Y99.642 E.00586
G1 X83.905 Y99.251 E.0066
G1 X84.052 Y98.778 E.00827
G1 X84.253 Y98.373 E.00753
G1 X84.446 Y98.09 E.00572
G1 X84.817 Y97.673 E.0093
; LINE_WIDTH: 0.401682
G1 X84.991 Y97.496 E.00466
; LINE_WIDTH: 0.43958
G1 X85.194 Y97.321 E.00553
; LINE_WIDTH: 0.477183
G1 X85.37 Y97.17 E.00523
; WIPE_START
G1 X85.194 Y97.321 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X80.299 Y96.239 Z1.08 F18000
G1 Z.68
G1 E.4 F1800
; LINE_WIDTH: 0.0944656
G1 F1500
M204 S6000
G1 X80.193 Y96.196 E.00039
; LINE_WIDTH: 0.136153
G1 X80.087 Y96.154 E.00063
G1 X79.991 Y96.09 E.00064
; LINE_WIDTH: 0.154882
G1 X79.848 Y95.948 E.00129
G1 X79.751 Y95.803 E.00113
; LINE_WIDTH: 0.104082
G1 X79.693 Y95.617 E.00076
; WIPE_START
G1 X79.751 Y95.803 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X87.381 Y95.986 Z1.08 F18000
G1 X93.625 Y96.136 Z1.08
G1 Z.68
G1 E.4 F1800
; LINE_WIDTH: 0.108388
G1 F1500
M204 S6000
G1 X93.837 Y96.009 E.00102
; WIPE_START
G1 X93.625 Y96.136 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X89.037 Y90.036 Z1.08 F18000
G1 X79.686 Y77.602 Z1.08
G1 Z.68
G1 E.4 F1800
; LINE_WIDTH: 0.099414
G1 F1500
M204 S6000
G1 X79.741 Y77.422 E.00069
; LINE_WIDTH: 0.146496
G1 X79.793 Y77.327 E.00065
G1 X79.944 Y77.151 E.0014
G1 X80.048 Y77.065 E.00081
G1 X80.18 Y77.002 E.00088
; LINE_WIDTH: 0.0997459
G1 X80.335 Y76.955 E.0006
; CHANGE_LAYER
; Z_HEIGHT: 0.8
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F1500
G1 X80.18 Y77.002 E-.38
; WIPE_END
G1 E-.02 F1800
; layer num/total_layer_count: 6/49
; update layer progress
M73 L6
M991 S0 P5 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z1.08 I-.585 J1.067 P1  F18000
G1 X93.851 Y84.5 Z1.08
G1 Z.8
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X93.851 Y77.128 E.15603
G1 X94.036 Y77.076 E.00407
G1 X94.117 Y77.207 E.00325
G1 X94.173 Y77.349 E.00324
G1 X94.202 Y77.49 E.00306
G1 X94.212 Y88.382 E.23052
G1 X93.851 Y88.382 E.00764
G1 X93.851 Y84.56 E.08088
; WIPE_START
M204 S6000
G1 X93.851 Y82.56 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X93.867 Y90.193 Z1.2 F18000
G1 X93.878 Y95.494 Z1.2
G1 Z.8
G1 E.4 F1800
G1 F1500
M204 S500
G1 X93.904 Y95.411 E.00183
G1 X93.968 Y95.363 E.0017
G1 X94.159 Y95.318 E.00415
G1 X94.184 Y95.493 E.00374
G1 X94.143 Y95.613 E.00268
G1 X93.862 Y95.745 E.00659
G1 X93.874 Y95.553 E.00407
; WIPE_START
M204 S6000
G1 X93.904 Y95.411 E-.04499
G1 X93.968 Y95.363 E-.0249
G1 X94.159 Y95.318 E-.06059
G1 X94.184 Y95.493 E-.05466
G1 X94.143 Y95.613 E-.03915
G1 X93.862 Y95.745 E-.09625
G1 X93.874 Y95.553 E-.05946
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X88.062 Y97.125 Z1.2 F18000
G1 Z.8
G1 E.4 F1800
G1 F1500
M204 S500
G1 X87.773 Y97.002 E.00663
G1 X87.241 Y96.881 E.01157
G1 X86.695 Y96.856 E.01156
G1 X86.153 Y96.93 E.01157
G1 X85.666 Y97.088 E.01084
G1 X85.56 Y96.922 E.00416
G1 X85.909 Y96.544 E.01089
G1 X87.817 Y96.544 E.04037
G1 X88.181 Y96.961 E.01172
G1 X88.097 Y97.077 E.00303
; WIPE_START
M204 S6000
M73 P39 R14
G1 X87.773 Y97.002 E-.06308
G1 X87.241 Y96.881 E-.10382
G1 X86.695 Y96.856 E-.10378
G1 X86.153 Y96.93 E-.10383
G1 X86.126 Y96.939 E-.0055
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X88.968 Y101.414 Z1.2 F18000
G1 Z.8
G1 E.4 F1800
G1 F1500
M204 S500
G1 X88.699 Y101.741 E.00895
G1 X88.348 Y102.039 E.00975
G1 X88.074 Y102.208 E.00682
G1 X87.796 Y102.337 E.00649
G1 X87.34 Y102.473 E.01007
G1 X86.88 Y102.521 E.00979
G1 X86.558 Y102.507 E.00681
G1 X86.256 Y102.457 E.00649
G1 X85.803 Y102.312 E.01007
G1 X85.387 Y102.089 E.00998
G1 X85.02 Y101.796 E.00995
G1 X84.717 Y101.449 E.00975
G1 X84.543 Y101.177 E.00683
G1 X84.403 Y100.886 E.00683
G1 X84.267 Y100.446 E.00975
G1 X84.211 Y99.979 E.00995
G1 X84.239 Y99.519 E.00975
G1 X84.306 Y99.204 E.00683
G1 X84.41 Y98.898 E.00683
G1 X84.622 Y98.49 E.00975
G1 X84.91 Y98.118 E.00995
G1 X85.252 Y97.809 E.00975
G1 X85.521 Y97.632 E.00683
G1 X85.81 Y97.487 E.00683
G1 X86.248 Y97.345 E.00975
G1 X86.714 Y97.282 E.00995
G1 X87.183 Y97.303 E.00995
G1 X87.642 Y97.407 E.00995
G1 X88.065 Y97.588 E.00975
G1 X88.34 Y97.758 E.00684
G1 X88.585 Y97.954 E.00663
G1 X88.805 Y98.177 E.00664
G1 X89.003 Y98.433 E.00686
G1 X89.229 Y98.842 E.00988
G1 X89.336 Y99.129 E.00649
G1 X89.412 Y99.442 E.00682
G1 X89.454 Y99.902 E.00978
G1 X89.409 Y100.376 E.01007
G1 X89.335 Y100.674 E.00649
G1 X89.222 Y100.975 E.00682
G1 X89.004 Y101.366 E.00948
M204 S250
G1 X88.652 Y101.154 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X88.407 Y101.452 E.0076
G1 X88.107 Y101.707 E.00773
G1 X87.879 Y101.847 E.00526
G1 X87.651 Y101.954 E.00496
G1 X87.259 Y102.07 E.00802
G1 X86.868 Y102.111 E.00775
G1 X86.601 Y102.099 E.00525
G1 X86.352 Y102.058 E.00496
G1 X85.963 Y101.934 E.00802
G1 X85.614 Y101.746 E.00781
G1 X85.304 Y101.499 E.00779
G1 X85.045 Y101.203 E.00774
G1 X84.901 Y100.977 E.00526
G1 X84.785 Y100.736 E.00526
G1 X84.669 Y100.361 E.00774
G1 X84.622 Y99.967 E.0078
G1 X84.645 Y99.574 E.00774
G1 X84.701 Y99.313 E.00526
G1 X84.787 Y99.06 E.00526
G1 X84.968 Y98.711 E.00773
G1 X85.211 Y98.397 E.0078
G1 X85.503 Y98.134 E.00773
G1 X85.726 Y97.987 E.00526
G1 X85.966 Y97.867 E.00526
G1 X86.34 Y97.745 E.00773
G1 X86.732 Y97.692 E.0078
G1 X87.128 Y97.71 E.00779
G1 X87.515 Y97.798 E.0078
G1 X87.876 Y97.953 E.00773
G1 X88.104 Y98.093 E.00526
G1 X88.311 Y98.258 E.0052
G1 X88.496 Y98.447 E.0052
G1 X88.66 Y98.658 E.00527
G1 X88.856 Y99.013 E.00797
G1 X88.944 Y99.25 E.00496
G1 X89.007 Y99.509 E.00526
G1 X89.043 Y99.901 E.00774
G1 X89.004 Y100.308 E.00803
G1 X88.944 Y100.553 E.00496
G1 X88.85 Y100.803 E.00526
G1 X88.683 Y101.103 E.00675
; WIPE_START
M204 S6000
G1 X88.407 Y101.452 E-.08466
G1 X88.107 Y101.707 E-.0747
G1 X87.879 Y101.847 E-.0508
G1 X87.651 Y101.954 E-.04793
G1 X87.259 Y102.07 E-.07752
G1 X87.027 Y102.094 E-.04439
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X88.071 Y96.12 Z1.2 F18000
G1 Z.8
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X93.413 Y96.12 E.11308
G1 X93.456 Y95.437 E.0145
G1 X93.477 Y95.336 E.00218
G1 X93.567 Y95.156 E.00426
G1 X93.749 Y94.998 E.0051
G1 X93.83 Y94.96 E.00191
G1 X94.261 Y94.858 E.00937
G1 X100.01 Y86.648 E.21213
G1 X100.306 Y86.855 E.00765
G1 X94.552 Y95.072 E.21231
G1 X94.61 Y95.52 E.00955
G1 X94.582 Y95.67 E.00324
G1 X94.52 Y95.81 E.00324
G1 X94.429 Y95.922 E.00305
G1 X94.341 Y95.988 E.00233
G1 X94.072 Y96.115 E.0063
G1 X93.852 Y96.308 E.0062
G1 X93.723 Y96.387 E.00322
G1 X93.581 Y96.443 E.00321
G1 X93.441 Y96.472 E.00304
G1 X88.328 Y96.485 E.10821
G1 X89.498 Y97.824 E.03763
G1 X89.628 Y98.002 E.00466
G1 X89.919 Y98.526 E.01269
G1 X90.063 Y98.91 E.00868
G1 X90.188 Y99.499 E.01274
G1 X90.206 Y100.091 E.01253
G1 X90.122 Y100.677 E.01254
G1 X90 Y101.079 E.00888
G1 X89.745 Y101.614 E.01255
G1 X89.401 Y102.098 E.01257
G1 X89.117 Y102.391 E.00864
G1 X88.798 Y102.65 E.00869
G1 X88.28 Y102.955 E.01273
G1 X87.716 Y103.163 E.01273
G1 X87.132 Y103.267 E.01254
G1 X86.731 Y103.279 E.00849
G1 X86.332 Y103.243 E.00849
G1 X85.938 Y103.16 E.00851
G1 X85.382 Y102.954 E.01256
G1 X85.024 Y102.757 E.00865
G1 X84.698 Y102.522 E.00849
G1 X84.403 Y102.251 E.00849
G1 X84.141 Y101.946 E.0085
G1 X83.918 Y101.613 E.00849
G1 X83.663 Y101.078 E.01255
G1 X83.551 Y100.712 E.0081
G1 X83.474 Y100.289 E.0091
G1 X83.452 Y99.89 E.00846
G1 X83.477 Y99.49 E.00849
G1 X83.549 Y99.095 E.0085
G1 X83.668 Y98.712 E.00849
G1 X83.831 Y98.345 E.00849
G1 X84.037 Y98 E.00849
G1 X84.288 Y97.675 E.00869
G1 X85.39 Y96.482 E.03439
G1 X80.368 Y96.482 E.1063
G1 X80.13 Y96.454 E.00508
G1 X79.849 Y96.336 E.00644
G1 X79.664 Y96.173 E.00522
G1 X79.566 Y96.033 E.00362
G1 X79.48 Y95.812 E.00501
G1 X79.451 Y95.565 E.00527
G1 X79.451 Y77.619 E.37984
G1 X79.49 Y77.349 E.00577
G1 X79.592 Y77.125 E.0052
G1 X79.693 Y76.997 E.00345
G1 X79.807 Y76.896 E.00324
G1 X80.032 Y76.775 E.0054
G1 X80.282 Y76.723 E.00541
G1 X93.305 Y76.72 E.27565
G1 X93.542 Y76.749 E.00504
G1 X93.68 Y76.794 E.00306
G1 X93.856 Y76.889 E.00424
G1 X93.807 Y77.082 E.0042
G1 X80.785 Y77.082 E.27562
G1 X80.523 Y77.121 E.00561
G1 X80.217 Y77.276 E.00727
G1 X79.978 Y77.53 E.00737
G1 X79.848 Y77.812 E.00658
G1 X79.812 Y78.057 E.00524
G1 X79.812 Y95.146 E.36171
G1 X79.849 Y95.395 E.00533
G1 X79.975 Y95.665 E.00629
G1 X80.172 Y95.887 E.00629
G1 X80.441 Y96.052 E.00668
G1 X80.768 Y96.12 E.00708
G1 X88.011 Y96.12 E.15329
; WIPE_START
M204 S6000
G1 X90.011 Y96.12 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X89.227 Y96.892 Z1.2 F18000
G1 Z.8
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X89.817 Y97.568 E.01765
G1 X89.966 Y97.77 E.00494
G1 X90.085 Y97.957 E.00435
G1 X90.293 Y98.359 E.00891
G1 X90.453 Y98.783 E.00891
G1 X90.511 Y98.994 E.00431
G1 X90.594 Y99.443 E.00897
G1 X90.614 Y99.661 E.0043
G1 X90.615 Y100.114 E.00891
G1 X90.563 Y100.564 E.00891
G1 X90.519 Y100.778 E.00431
G1 X90.386 Y101.215 E.00897
G1 X90.305 Y101.418 E.0043
G1 X90.099 Y101.821 E.00891
G1 X89.863 Y102.174 E.00835
G1 X89.708 Y102.368 E.00488
G1 X89.394 Y102.693 E.0089
G1 X89.042 Y102.979 E.00891
G1 X88.861 Y103.102 E.00431
G1 X88.462 Y103.322 E.00897
M73 P40 R14
G1 X88.262 Y103.411 E.00431
G1 X87.83 Y103.557 E.00897
G1 X87.617 Y103.609 E.00431
G1 X87.169 Y103.676 E.00891
G1 X86.719 Y103.689 E.00885
G1 X86.271 Y103.649 E.00885
G1 X85.83 Y103.556 E.00885
G1 X85.428 Y103.42 E.00835
G1 X85.201 Y103.322 E.00487
G1 X84.805 Y103.103 E.0089
G1 X84.44 Y102.84 E.00885
G1 X84.108 Y102.536 E.00885
G1 X83.815 Y102.195 E.00885
G1 X83.564 Y101.821 E.00885
G1 X83.358 Y101.417 E.00891
G1 X83.277 Y101.214 E.00431
G1 X83.153 Y100.808 E.00834
G1 X83.067 Y100.337 E.00942
G1 X83.042 Y99.889 E.00884
G1 X83.07 Y99.44 E.00885
G1 X83.151 Y98.997 E.00885
G1 X83.284 Y98.567 E.00885
G1 X83.467 Y98.156 E.00885
G1 X83.698 Y97.77 E.00885
G1 X83.975 Y97.411 E.00891
G1 X84.455 Y96.891 E.01392
G1 X80.344 Y96.891 E.08086
G1 X80.034 Y96.855 E.00613
G1 X79.748 Y96.75 E.006
G1 X79.617 Y96.674 E.00297
G1 X79.445 Y96.537 E.00434
G1 X79.346 Y96.432 E.00284
G1 X79.213 Y96.243 E.00454
G1 X79.149 Y96.114 E.00283
G1 X79.078 Y95.901 E.00442
G1 X79.042 Y95.589 E.00619
G1 X79.042 Y77.607 E.35368
G1 X79.051 Y77.454 E.00301
G1 X79.097 Y77.231 E.00448
G1 X79.181 Y77.019 E.00448
G1 X79.253 Y76.895 E.00283
G1 X79.394 Y76.716 E.00449
G1 X79.556 Y76.571 E.00428
G1 X79.685 Y76.485 E.00304
G1 X79.891 Y76.389 E.00448
G1 X80.101 Y76.332 E.00428
G1 X80.257 Y76.313 E.0031
G1 X93.33 Y76.311 E.25713
G1 X93.632 Y76.347 E.00598
G1 X93.842 Y76.417 E.00436
G1 X94.04 Y76.524 E.00442
G1 X94.216 Y76.663 E.00441
G1 X94.366 Y76.831 E.00442
G1 X94.484 Y77.022 E.00442
G1 X94.567 Y77.231 E.00442
G1 X94.612 Y77.448 E.00436
G1 X94.621 Y88.791 E.2231
G1 X93.442 Y88.791 E.02321
G1 X93.442 Y77.491 E.22226
G1 X80.816 Y77.491 E.24833
G1 X80.649 Y77.516 E.00331
G1 X80.465 Y77.609 E.00406
G1 X80.321 Y77.762 E.00413
G1 X80.244 Y77.929 E.00362
G1 X80.222 Y78.086 E.00312
G1 X80.222 Y95.116 E.33497
G1 X80.245 Y95.277 E.00319
G1 X80.32 Y95.437 E.00349
G1 X80.438 Y95.57 E.00349
G1 X80.594 Y95.666 E.00361
G1 X80.81 Y95.711 E.00434
G1 X93.029 Y95.711 E.24033
G1 X93.05 Y95.382 E.00649
G1 X93.084 Y95.218 E.00329
G1 X93.147 Y95.058 E.00339
G1 X93.237 Y94.911 E.00338
G1 X93.35 Y94.785 E.00333
G1 X93.538 Y94.644 E.00462
G1 X93.696 Y94.571 E.00343
G1 X94.015 Y94.495 E.00646
G1 X99.909 Y86.078 E.20211
G1 X100.876 Y86.755 E.02321
G1 X94.98 Y95.175 E.20217
G1 X95.019 Y95.559 E.0076
G1 X94.976 Y95.793 E.00469
G1 X94.875 Y96.016 E.00481
G1 X94.7 Y96.23 E.00543
G1 X94.554 Y96.34 E.0036
G1 X94.299 Y96.461 E.00554
G1 X94.096 Y96.639 E.00532
G1 X93.906 Y96.755 E.00438
G1 X93.698 Y96.837 E.00438
G1 X93.483 Y96.881 E.00433
G1 X89.287 Y96.892 E.08253
; WIPE_START
M204 S6000
G1 X89.817 Y97.568 E-.16324
G1 X89.966 Y97.77 E-.0477
G1 X90.085 Y97.957 E-.04205
G1 X90.293 Y98.359 E-.08609
G1 X90.369 Y98.561 E-.04092
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




G1 X88.837 Y97.658
G1 Z.8
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.393346
G1 F1500
M204 S6000
G1 X88.714 Y97.54 E.00312
; LINE_WIDTH: 0.426195
G1 X88.573 Y97.406 E.0039
; LINE_WIDTH: 0.465447
G1 X88.293 Y97.169 E.00805
M204 S10000
G1 X88.837 Y97.658 F18000
; LINE_WIDTH: 0.36013
G1 F1500
M204 S6000
G1 X89.198 Y98.061 E.00903
G1 X89.399 Y98.356 E.00595
G1 X89.571 Y98.678 E.0061
G1 X89.74 Y99.174 E.00874
G1 X89.821 Y99.704 E.00894
G1 X89.83 Y99.918 E.00358
G1 X89.784 Y100.432 E.00861
G1 X89.696 Y100.775 E.00591
G1 X89.566 Y101.122 E.00617
G1 X89.414 Y101.419 E.00558
G1 X89.109 Y101.847 E.00877
G1 X88.858 Y102.108 E.00604
G1 X88.576 Y102.342 E.0061
G1 X88.113 Y102.611 E.00894
G1 X87.606 Y102.795 E.00899
G1 X87.399 Y102.846 E.00357
G1 X86.904 Y102.897 E.0083
G1 X86.51 Y102.881 E.00658
G1 X86.156 Y102.821 E.00598
G1 X85.669 Y102.667 E.00853
G1 X85.228 Y102.435 E.00831
G1 X84.941 Y102.224 E.00594
G1 X84.678 Y101.985 E.00593
G1 X84.407 Y101.666 E.00698
G1 X84.218 Y101.37 E.00586
G1 X84.048 Y101.012 E.0066
G1 X83.902 Y100.539 E.00827
G1 X83.834 Y99.976 E.00946
G1 X83.863 Y99.481 E.00827
G1 X83.939 Y99.113 E.00627
G1 X84.068 Y98.739 E.0066
G1 X84.312 Y98.274 E.00876
; LINE_WIDTH: 0.371788
G1 X84.622 Y97.871 E.00877
G1 X84.995 Y97.5 E.00908
; LINE_WIDTH: 0.406697
G1 X85.016 Y97.481 E.00054
; LINE_WIDTH: 0.449161
G1 X85.26 Y97.274 E.00676
G1 X85.284 Y97.279 E.00051
; LINE_WIDTH: 0.435156
G1 X85.307 Y97.284 E.00049
; LINE_WIDTH: 0.396959
G1 X85.583 Y97.351 E.00526
; WIPE_START
G1 X85.307 Y97.284 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X80.294 Y96.251 Z1.2 F18000
G1 Z.8
G1 E.4 F1800
; LINE_WIDTH: 0.137342
G1 F1500
M204 S6000
G1 X79.988 Y96.092 E.00192
; LINE_WIDTH: 0.152983
G1 X79.918 Y96.027 E.00061
G1 X79.751 Y95.803 E.00177
; LINE_WIDTH: 0.104043
G1 X79.693 Y95.617 E.00076
; WIPE_START
G1 X79.751 Y95.803 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X87.382 Y95.99 Z1.2 F18000
G1 X93.624 Y96.142 Z1.2
G1 Z.8
G1 E.4 F1800
; LINE_WIDTH: 0.0921279
G1 F1500
M204 S6000
G1 X93.815 Y96.028 E.00074
; WIPE_START
G1 X93.624 Y96.142 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X89.038 Y90.041 Z1.2 F18000
G1 X79.686 Y77.602 Z1.2
G1 Z.8
G1 E.4 F1800
; LINE_WIDTH: 0.10315
G1 F1500
M204 S6000
G1 X79.755 Y77.389 E.00087
; LINE_WIDTH: 0.156461
G1 X79.902 Y77.194 E.00159
G1 X80.023 Y77.082 E.00108
; LINE_WIDTH: 0.127984
G1 X80.228 Y76.991 E.00114
; LINE_WIDTH: 0.0894683
G1 X80.335 Y76.955 E.00036
; CHANGE_LAYER
; Z_HEIGHT: 0.92
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F1500
G1 X80.228 Y76.991 E-.38
; WIPE_END
G1 E-.02 F1800
; layer num/total_layer_count: 7/49
; update layer progress
M73 L7
M991 S0 P6 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z1.2 I-.588 J1.066 P1  F18000
G1 X93.851 Y84.506 Z1.2
G1 Z.92
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X93.851 Y77.128 E.15616
G1 X94.036 Y77.076 E.00407
G1 X94.117 Y77.207 E.00325
G1 X94.173 Y77.349 E.00324
G1 X94.202 Y77.49 E.00305
G1 X94.212 Y88.382 E.23052
G1 X93.851 Y88.382 E.00764
G1 X93.851 Y84.566 E.08075
; WIPE_START
M204 S6000
G1 X93.851 Y82.566 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X93.867 Y90.199 Z1.32 F18000
G1 X93.878 Y95.493 Z1.32
G1 Z.92
G1 E.4 F1800
G1 F1500
M204 S500
G1 X93.904 Y95.41 E.00184
G1 X93.968 Y95.363 E.00167
G1 X94.159 Y95.318 E.00416
G1 X94.184 Y95.493 E.00374
G1 X94.151 Y95.598 E.00234
G1 X93.862 Y95.741 E.00682
G1 X93.874 Y95.553 E.004
; WIPE_START
M204 S6000
G1 X93.904 Y95.41 E-.04542
G1 X93.968 Y95.363 E-.02457
G1 X94.159 Y95.318 E-.06124
G1 X94.184 Y95.493 E-.05501
G1 X94.151 Y95.598 E-.0344
G1 X93.862 Y95.741 E-.10044
G1 X93.874 Y95.553 E-.05893
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X88.051 Y97.115 Z1.32 F18000
G1 Z.92
G1 E.4 F1800
G1 F1500
M204 S500
G1 X87.598 Y96.953 E.01018
G1 X87.225 Y96.88 E.00805
G1 X86.695 Y96.856 E.01123
G1 X86.153 Y96.93 E.01157
G1 X85.597 Y97.11 E.01237
G1 X85.491 Y96.949 E.0041
G1 X85.842 Y96.544 E.01135
G1 X87.821 Y96.544 E.04187
G1 X88.175 Y96.951 E.0114
G1 X88.087 Y97.067 E.00309
; WIPE_START
M204 S6000
G1 X87.598 Y96.953 E-.0954
G1 X87.225 Y96.88 E-.07223
G1 X86.695 Y96.856 E-.1008
G1 X86.153 Y96.93 E-.10385
G1 X86.115 Y96.942 E-.00773
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X88.968 Y101.414 Z1.32 F18000
G1 Z.92
G1 E.4 F1800
G1 F1500
M204 S500
G1 X88.699 Y101.741 E.00895
G1 X88.348 Y102.039 E.00975
G1 X88.074 Y102.208 E.00681
G1 X87.799 Y102.336 E.00643
G1 X87.34 Y102.473 E.01013
G1 X86.88 Y102.521 E.00979
G1 X86.558 Y102.507 E.00683
G1 X86.239 Y102.454 E.00683
G1 X85.801 Y102.312 E.00975
G1 X85.387 Y102.089 E.00995
G1 X85.02 Y101.796 E.00995
G1 X84.711 Y101.442 E.00995
G1 X84.47 Y101.038 E.00995
G1 X84.308 Y100.607 E.00975
G1 X84.241 Y100.292 E.00683
G1 X84.212 Y99.979 E.00663
G1 X84.222 Y99.667 E.00662
G1 X84.266 Y99.366 E.00643
G1 X84.405 Y98.908 E.01013
G1 X84.622 Y98.489 E.00998
G1 X84.91 Y98.118 E.00995
G1 X85.252 Y97.809 E.00975
G1 X85.522 Y97.632 E.00683
G1 X85.81 Y97.487 E.00683
G1 X86.248 Y97.345 E.00975
G1 X86.714 Y97.282 E.00995
G1 X87.174 Y97.302 E.00975
G1 X87.491 Y97.365 E.00683
G1 X87.789 Y97.462 E.00663
G1 X88.073 Y97.593 E.00664
G1 X88.348 Y97.763 E.00683
G1 X88.699 Y98.061 E.00975
G1 X88.999 Y98.425 E.00999
G1 X89.23 Y98.844 E.01013
G1 X89.336 Y99.129 E.00643
G1 X89.412 Y99.442 E.00681
G1 X89.453 Y99.901 E.00975
G1 X89.411 Y100.369 E.00995
G1 X89.289 Y100.813 E.00975
G1 X89.157 Y101.108 E.00683
G1 X89.003 Y101.366 E.00636
M204 S250
G1 X88.652 Y101.154 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X88.407 Y101.452 E.0076
G1 X88.107 Y101.707 E.00773
G1 X87.879 Y101.847 E.00526
G1 X87.653 Y101.953 E.00491
G1 X87.26 Y102.07 E.00807
G1 X86.868 Y102.111 E.00775
G1 X86.601 Y102.099 E.00526
G1 X86.337 Y102.055 E.00527
G1 X85.963 Y101.934 E.00773
G1 X85.614 Y101.746 E.0078
G1 X85.304 Y101.499 E.0078
G1 X85.043 Y101.2 E.0078
G1 X84.84 Y100.86 E.0078
G1 X84.702 Y100.492 E.00774
G1 X84.646 Y100.23 E.00526
G1 X84.622 Y99.967 E.0052
G1 X84.63 Y99.703 E.0052
G1 X84.667 Y99.456 E.00491
G1 X84.786 Y99.063 E.00807
G1 X84.969 Y98.711 E.00781
G1 X85.211 Y98.397 E.0078
G1 X85.503 Y98.134 E.00773
G1 X85.726 Y97.987 E.00526
G1 X85.966 Y97.867 E.00526
G1 X86.34 Y97.746 E.00773
G1 X86.732 Y97.692 E.0078
G1 X87.125 Y97.71 E.00773
G1 X87.388 Y97.762 E.00527
G1 X87.639 Y97.843 E.0052
G1 X87.879 Y97.954 E.0052
G1 X88.107 Y98.095 E.00526
G1 X88.407 Y98.349 E.00774
G1 X88.659 Y98.656 E.00781
G1 X88.857 Y99.016 E.00807
G1 X88.944 Y99.25 E.00491
G1 X89.007 Y99.509 E.00526
G1 X89.042 Y99.901 E.00773
G1 X89.007 Y100.296 E.0078
G1 X88.902 Y100.675 E.00773
G1 X88.794 Y100.919 E.00526
G1 X88.684 Y101.103 E.00422
; WIPE_START
M204 S6000
G1 X88.407 Y101.452 E-.08469
G1 X88.107 Y101.707 E-.0747
G1 X87.879 Y101.847 E-.05078
G1 X87.653 Y101.953 E-.04747
G1 X87.26 Y102.07 E-.07798
G1 X87.027 Y102.094 E-.04438
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X88.075 Y96.12 Z1.32 F18000
G1 Z.92
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X93.413 Y96.12 E.11297
G1 X93.456 Y95.435 E.01452
G1 X93.477 Y95.336 E.00215
G1 X93.566 Y95.157 E.00423
G1 X93.634 Y95.083 E.00213
G1 X93.831 Y94.959 E.00493
G1 X94.261 Y94.858 E.00935
G1 X100.01 Y86.648 E.21213
G1 X100.306 Y86.855 E.00765
M73 P41 R14
G1 X94.552 Y95.072 E.21231
G1 X94.61 Y95.52 E.00956
G1 X94.582 Y95.672 E.00326
G1 X94.523 Y95.804 E.00307
G1 X94.435 Y95.916 E.00302
G1 X94.302 Y96.011 E.00346
G1 X94.079 Y96.109 E.00516
G1 X93.852 Y96.308 E.00638
G1 X93.723 Y96.387 E.00321
G1 X93.581 Y96.443 E.00321
G1 X93.441 Y96.472 E.00304
G1 X88.332 Y96.485 E.10814
G1 X89.515 Y97.845 E.03814
G1 X89.627 Y98 E.00406
G1 X89.919 Y98.526 E.01273
G1 X90.063 Y98.91 E.00868
G1 X90.188 Y99.499 E.01274
G1 X90.206 Y100.091 E.01253
G1 X90.122 Y100.677 E.01254
G1 X90.003 Y101.07 E.0087
G1 X89.745 Y101.616 E.01276
G1 X89.396 Y102.103 E.01269
G1 X89.117 Y102.391 E.00849
G1 X88.798 Y102.65 E.00869
G1 X88.28 Y102.955 E.01273
G1 X87.754 Y103.151 E.01187
G1 X87.33 Y103.244 E.00919
G1 X86.932 Y103.279 E.00845
G1 X86.524 Y103.267 E.00864
G1 X85.939 Y103.161 E.01259
G1 X85.381 Y102.954 E.01258
G1 X85.024 Y102.757 E.00864
G1 X84.699 Y102.522 E.00849
G1 X84.403 Y102.251 E.0085
G1 X84.141 Y101.947 E.00849
G1 X83.918 Y101.613 E.00849
G1 X83.663 Y101.078 E.01255
G1 X83.553 Y100.716 E.00801
G1 X83.474 Y100.289 E.0092
G1 X83.452 Y99.89 E.00845
G1 X83.477 Y99.49 E.00849
G1 X83.549 Y99.095 E.00849
G1 X83.74 Y98.533 E.01255
G1 X83.914 Y98.197 E.00801
G1 X84.156 Y97.836 E.00919
G1 X85.335 Y96.482 E.03801
G1 X80.368 Y96.482 E.10513
G1 X80.131 Y96.454 E.00504
G1 X79.921 Y96.376 E.00474
G1 X79.8 Y96.301 E.00301
G1 X79.658 Y96.165 E.00416
G1 X79.567 Y96.035 E.00336
G1 X79.48 Y95.813 E.00505
G1 X79.451 Y95.565 E.00529
G1 X79.451 Y77.628 E.37965
G1 X79.487 Y77.357 E.00578
G1 X79.592 Y77.125 E.00539
G1 X79.693 Y76.997 E.00345
G1 X79.806 Y76.896 E.00321
G1 X80.031 Y76.775 E.00541
G1 X80.281 Y76.723 E.00539
G1 X93.307 Y76.72 E.27572
G1 X93.542 Y76.749 E.005
G1 X93.68 Y76.794 E.00307
G1 X93.856 Y76.889 E.00424
G1 X93.807 Y77.082 E.0042
G1 X80.778 Y77.082 E.27579
G1 X80.489 Y77.132 E.0062
G1 X80.218 Y77.279 E.00652
G1 X79.999 Y77.5 E.00658
G1 X79.85 Y77.799 E.00707
G1 X79.812 Y78.056 E.0055
G1 X79.812 Y95.146 E.36172
G1 X79.849 Y95.395 E.00533
G1 X79.974 Y95.664 E.00629
G1 X80.172 Y95.887 E.0063
G1 X80.441 Y96.053 E.00668
G1 X80.768 Y96.12 E.00707
G1 X88.015 Y96.12 E.15338
; WIPE_START
M204 S6000
G1 X90.015 Y96.12 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X89.228 Y96.892 Z1.32 F18000
G1 Z.92
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X89.835 Y97.59 E.01819
G1 X90.085 Y97.957 E.00873
G1 X90.293 Y98.359 E.00891
G1 X90.453 Y98.783 E.00891
G1 X90.511 Y98.994 E.00431
G1 X90.594 Y99.443 E.00897
G1 X90.614 Y99.661 E.0043
G1 X90.615 Y100.114 E.00891
G1 X90.563 Y100.564 E.00891
G1 X90.519 Y100.778 E.00431
G1 X90.387 Y101.212 E.00891
G1 X90.22 Y101.597 E.00826
G1 X90.099 Y101.822 E.00503
G1 X89.981 Y102.009 E.00435
G1 X89.707 Y102.37 E.00891
G1 X89.394 Y102.693 E.00885
G1 X89.042 Y102.979 E.00891
G1 X88.861 Y103.102 E.0043
G1 X88.462 Y103.322 E.00897
G1 X88.261 Y103.411 E.00431
G1 X87.864 Y103.546 E.00825
G1 X87.392 Y103.649 E.00951
G1 X86.944 Y103.689 E.00884
G1 X86.492 Y103.675 E.0089
G1 X86.242 Y103.644 E.00497
G1 X85.831 Y103.556 E.00826
G1 X85.433 Y103.422 E.00826
G1 X85.201 Y103.322 E.00497
G1 X84.805 Y103.103 E.0089
G1 X84.44 Y102.84 E.00885
G1 X84.108 Y102.536 E.00885
G1 X83.815 Y102.195 E.00885
G1 X83.564 Y101.821 E.00885
G1 X83.358 Y101.417 E.00891
G1 X83.277 Y101.214 E.00431
G1 X83.154 Y100.813 E.00825
G1 X83.067 Y100.337 E.00951
G1 X83.042 Y99.889 E.00884
G1 X83.07 Y99.44 E.00885
G1 X83.151 Y98.997 E.00885
G1 X83.285 Y98.564 E.00891
G1 X83.368 Y98.362 E.00431
G1 X83.561 Y97.989 E.00825
G1 X83.83 Y97.587 E.00951
G1 X84.436 Y96.891 E.01815
G1 X80.344 Y96.891 E.08049
G1 X80.035 Y96.855 E.00612
G1 X79.74 Y96.746 E.00618
G1 X79.559 Y96.634 E.00419
G1 X79.447 Y96.539 E.00288
G1 X79.339 Y96.423 E.00313
G1 X79.214 Y96.244 E.00429
G1 X79.145 Y96.104 E.00308
G1 X79.078 Y95.901 E.00419
G1 X79.042 Y95.589 E.0062
G1 X79.042 Y77.61 E.35362
G1 X79.062 Y77.374 E.00466
G1 X79.095 Y77.234 E.00283
G1 X79.181 Y77.019 E.00454
G1 X79.253 Y76.895 E.00283
G1 X79.394 Y76.716 E.00448
G1 X79.555 Y76.572 E.00425
G1 X79.685 Y76.485 E.00307
G1 X79.891 Y76.389 E.00447
G1 X80.111 Y76.33 E.00448
G1 X80.257 Y76.313 E.00289
G1 X93.332 Y76.311 E.25717
G1 X93.632 Y76.347 E.00594
G1 X93.842 Y76.417 E.00437
G1 X94.04 Y76.524 E.00442
G1 X94.216 Y76.663 E.00442
G1 X94.366 Y76.831 E.00442
G1 X94.484 Y77.022 E.00442
G1 X94.567 Y77.231 E.00442
G1 X94.612 Y77.448 E.00436
G1 X94.621 Y88.791 E.2231
G1 X93.442 Y88.791 E.02321
G1 X93.442 Y77.491 E.22226
G1 X80.813 Y77.491 E.24839
G1 X80.625 Y77.524 E.00376
G1 X80.466 Y77.61 E.00356
G1 X80.336 Y77.741 E.00362
G1 X80.246 Y77.923 E.00399
G1 X80.222 Y78.086 E.00324
G1 X80.222 Y95.116 E.33497
G1 X80.245 Y95.276 E.00319
G1 X80.32 Y95.437 E.00349
G1 X80.438 Y95.57 E.0035
G1 X80.594 Y95.666 E.00361
G1 X80.81 Y95.711 E.00433
G1 X93.029 Y95.711 E.24032
G1 X93.05 Y95.38 E.00652
G1 X93.084 Y95.218 E.00326
G1 X93.147 Y95.058 E.00339
G1 X93.237 Y94.912 E.00337
G1 X93.357 Y94.779 E.00352
G1 X93.537 Y94.644 E.00443
G1 X93.697 Y94.57 E.00346
G1 X94.015 Y94.495 E.00643
G1 X99.909 Y86.078 E.20211
G1 X100.876 Y86.755 E.02321
G1 X94.98 Y95.175 E.20217
G1 X95.019 Y95.559 E.0076
G1 X94.976 Y95.794 E.0047
G1 X94.88 Y96.009 E.00464
G1 X94.702 Y96.228 E.00554
G1 X94.505 Y96.369 E.00476
G1 X94.301 Y96.459 E.00438
G1 X94.096 Y96.639 E.00538
G1 X93.906 Y96.755 E.00438
G1 X93.698 Y96.837 E.00438
G1 X93.483 Y96.881 E.00433
G1 X89.288 Y96.892 E.0825
; WIPE_START
M204 S6000
G1 X89.835 Y97.59 E-.1685
G1 X90.085 Y97.957 E-.08433
G1 X90.293 Y98.359 E-.08609
G1 X90.37 Y98.562 E-.04109
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




G1 X88.959 Y97.784
G1 Z.92
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.378836
G1 F1500
M204 S6000
G1 X88.782 Y97.609 E.00438
; LINE_WIDTH: 0.419328
G1 X88.579 Y97.411 E.00557
; LINE_WIDTH: 0.468153
G1 X88.281 Y97.162 E.00857
M204 S10000
G1 X88.959 Y97.784 F18000
; LINE_WIDTH: 0.360119
G1 F1500
M204 S6000
G1 X89.212 Y98.081 E.00652
G1 X89.398 Y98.356 E.00553
G1 X89.571 Y98.679 E.00611
G1 X89.74 Y99.174 E.00874
G1 X89.821 Y99.704 E.00894
G1 X89.823 Y100.069 E.00609
G1 X89.785 Y100.433 E.0061
G1 X89.646 Y100.939 E.00876
G1 X89.486 Y101.289 E.00642
G1 X89.29 Y101.61 E.00626
G1 X88.978 Y101.994 E.00827
G1 X88.576 Y102.342 E.00886
G1 X88.112 Y102.611 E.00894
G1 X87.649 Y102.781 E.00824
G1 X87.272 Y102.865 E.00644
G1 X86.879 Y102.9 E.00658
G1 X86.508 Y102.883 E.00619
G1 X86.04 Y102.791 E.00796
G1 X85.639 Y102.654 E.00707
G1 X85.192 Y102.412 E.00848
G1 X84.77 Y102.078 E.00897
G1 X84.445 Y101.716 E.00812
G1 X84.249 Y101.418 E.00594
G1 X84.082 Y101.094 E.0061
G1 X83.922 Y100.624 E.00828
G1 X83.854 Y100.244 E.00645
G1 X83.835 Y99.981 E.0044
G1 X83.845 Y99.643 E.00564
G1 X83.901 Y99.272 E.00626
G1 X84.062 Y98.752 E.00907
G1 X84.243 Y98.392 E.00673
G1 X84.461 Y98.07 E.00648
G1 X84.817 Y97.673 E.0089
; LINE_WIDTH: 0.400595
G1 X84.991 Y97.496 E.00464
; LINE_WIDTH: 0.438377
M73 P42 R14
G1 X85.199 Y97.319 E.00562
; LINE_WIDTH: 0.477107
G1 X85.379 Y97.165 E.00534
; WIPE_START
G1 X85.199 Y97.319 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X80.294 Y96.251 Z1.32 F18000
G1 Z.92
G1 E.4 F1800
; LINE_WIDTH: 0.13621
G1 F1500
M204 S6000
G1 X79.989 Y96.092 E.0019
; LINE_WIDTH: 0.151941
G1 X79.927 Y96.037 E.00052
G1 X79.751 Y95.803 E.00184
; LINE_WIDTH: 0.10411
G1 X79.693 Y95.617 E.00076
; WIPE_START
G1 X79.751 Y95.803 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X87.381 Y95.986 Z1.32 F18000
G1 X93.624 Y96.136 Z1.32
G1 Z.92
G1 E.4 F1800
; LINE_WIDTH: 0.108454
G1 F1500
M204 S6000
G1 X93.837 Y96.009 E.00102
; WIPE_START
G1 X93.624 Y96.136 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X89.038 Y90.035 Z1.32 F18000
G1 X79.688 Y77.598 Z1.32
G1 Z.92
G1 E.4 F1800
; LINE_WIDTH: 0.102319
G1 F1500
M204 S6000
G1 X79.739 Y77.434 E.00065
; LINE_WIDTH: 0.152244
G1 X79.794 Y77.32 E.0008
G1 X80.024 Y77.083 E.00208
; LINE_WIDTH: 0.131849
G1 X80.209 Y76.995 E.00108
; LINE_WIDTH: 0.0957231
G1 X80.296 Y76.963 E.00032
; LINE_WIDTH: 0.0812161
G1 X80.328 Y76.955 E.00009
; CHANGE_LAYER
; Z_HEIGHT: 1.04
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F1500
G1 X80.296 Y76.963 E-.38
; WIPE_END
G1 E-.02 F1800
; layer num/total_layer_count: 8/49
; update layer progress
M73 L8
M991 S0 P7 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z1.32 I-.591 J1.064 P1  F18000
G1 X93.851 Y84.498 Z1.32
G1 Z1.04
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X93.851 Y77.128 E.15599
G1 X94.036 Y77.076 E.00407
G1 X94.117 Y77.207 E.00325
G1 X94.173 Y77.349 E.00324
G1 X94.202 Y77.49 E.00305
G1 X94.212 Y88.382 E.23053
G1 X93.851 Y88.382 E.00764
G1 X93.851 Y84.558 E.08093
; WIPE_START
M204 S6000
G1 X93.851 Y82.558 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X93.869 Y90.191 Z1.44 F18000
G1 X93.882 Y95.465 Z1.44
G1 Z1.04
G1 E.4 F1800
G1 F1500
M204 S500
G1 X93.904 Y95.41 E.00126
G1 X93.968 Y95.363 E.00167
G1 X94.157 Y95.318 E.00413
G1 X94.185 Y95.486 E.00359
G1 X94.145 Y95.611 E.00279
G1 X93.858 Y95.748 E.00673
G1 X93.877 Y95.525 E.00473
; WIPE_START
M204 S6000
G1 X93.904 Y95.41 E-.03643
G1 X93.968 Y95.363 E-.02429
G1 X94.157 Y95.318 E-.05997
G1 X94.185 Y95.486 E-.05221
G1 X94.145 Y95.611 E-.04057
G1 X93.858 Y95.748 E-.09782
G1 X93.877 Y95.525 E-.06871
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X88.044 Y97.112 Z1.44 F18000
G1 Z1.04
G1 E.4 F1800
G1 F1500
M204 S500
G1 X87.598 Y96.953 E.01002
G1 X87.225 Y96.88 E.00804
G1 X86.695 Y96.856 E.01123
G1 X86.153 Y96.93 E.01157
G1 X85.597 Y97.11 E.01237
G1 X85.49 Y96.949 E.0041
G1 X85.842 Y96.544 E.01135
G1 X87.815 Y96.544 E.04175
G1 X88.167 Y96.947 E.01133
G1 X88.08 Y97.064 E.00309
; WIPE_START
M204 S6000
G1 X87.598 Y96.953 E-.09397
G1 X87.225 Y96.88 E-.07221
G1 X86.695 Y96.856 E-.1008
G1 X86.153 Y96.93 E-.10386
G1 X86.107 Y96.945 E-.00916
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X88.968 Y101.414 Z1.44 F18000
G1 Z1.04
G1 E.4 F1800
G1 F1500
M204 S500
G1 X88.699 Y101.741 E.00896
G1 X88.348 Y102.039 E.00975
G1 X88.074 Y102.208 E.00681
G1 X87.801 Y102.335 E.00638
G1 X87.34 Y102.473 E.01018
G1 X86.88 Y102.521 E.00979
G1 X86.559 Y102.507 E.00681
G1 X86.261 Y102.458 E.00638
G1 X85.803 Y102.313 E.01018
G1 X85.387 Y102.089 E.00999
G1 X85.027 Y101.802 E.00975
G1 X84.808 Y101.566 E.00681
G1 X84.63 Y101.322 E.00638
G1 X84.406 Y100.897 E.01018
G1 X84.267 Y100.446 E.00999
G1 X84.212 Y99.989 E.00975
G1 X84.222 Y99.667 E.00681
G1 X84.266 Y99.369 E.00638
G1 X84.405 Y98.908 E.01018
G1 X84.622 Y98.49 E.00999
G1 X84.911 Y98.116 E.00999
G1 X85.27 Y97.797 E.01018
G1 X85.522 Y97.631 E.00637
G1 X85.81 Y97.487 E.00682
G1 X86.248 Y97.345 E.00975
G1 X86.714 Y97.282 E.00995
G1 X87.174 Y97.302 E.00975
G1 X87.491 Y97.365 E.00683
G1 X87.789 Y97.462 E.00664
G1 X88.073 Y97.593 E.00663
G1 X88.348 Y97.763 E.00683
G1 X88.699 Y98.061 E.00975
G1 X88.999 Y98.425 E.00999
G1 X89.231 Y98.847 E.01018
G1 X89.336 Y99.129 E.00638
G1 X89.412 Y99.442 E.00681
G1 X89.454 Y99.903 E.00979
G1 X89.407 Y100.382 E.01018
G1 X89.335 Y100.674 E.00637
G1 X89.222 Y100.975 E.00682
G1 X89.004 Y101.366 E.00947
M204 S250
G1 X88.652 Y101.154 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X88.407 Y101.452 E.0076
G1 X88.107 Y101.707 E.00773
G1 X87.879 Y101.847 E.00526
G1 X87.655 Y101.952 E.00487
G1 X87.26 Y102.07 E.00812
G1 X86.868 Y102.111 E.00775
G1 X86.601 Y102.099 E.00525
G1 X86.357 Y102.059 E.00487
G1 X85.963 Y101.934 E.00812
G1 X85.614 Y101.746 E.00781
G1 X85.306 Y101.501 E.00774
G1 X85.125 Y101.305 E.00526
G1 X84.979 Y101.105 E.00487
G1 X84.786 Y100.74 E.00812
G1 X84.669 Y100.361 E.00781
G1 X84.622 Y99.97 E.00773
G1 X84.63 Y99.703 E.00526
G1 X84.666 Y99.458 E.00487
G1 X84.786 Y99.063 E.00812
G1 X84.968 Y98.711 E.00781
G1 X85.211 Y98.397 E.00781
G1 X85.52 Y98.122 E.00812
G1 X85.727 Y97.987 E.00486
G1 X85.966 Y97.867 E.00526
G1 X86.34 Y97.746 E.00773
G1 X86.732 Y97.692 E.0078
G1 X87.125 Y97.71 E.00773
G1 X87.388 Y97.762 E.00526
G1 X87.639 Y97.843 E.0052
G1 X87.879 Y97.954 E.0052
G1 X88.107 Y98.095 E.00526
G1 X88.407 Y98.349 E.00773
G1 X88.659 Y98.656 E.00781
G1 X88.858 Y99.018 E.00812
G1 X88.944 Y99.25 E.00487
G1 X89.007 Y99.509 E.00526
G1 X89.043 Y99.902 E.00775
G1 X89.003 Y100.313 E.00812
G1 X88.944 Y100.553 E.00486
G1 X88.85 Y100.803 E.00526
G1 X88.683 Y101.102 E.00675
; WIPE_START
M204 S6000
G1 X88.407 Y101.452 E-.08472
G1 X88.107 Y101.707 E-.0747
G1 X87.879 Y101.847 E-.05078
G1 X87.655 Y101.952 E-.047
G1 X87.26 Y102.07 E-.07844
G1 X87.027 Y102.094 E-.04437
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X88.069 Y96.12 Z1.44 F18000
G1 Z1.04
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X93.399 Y96.12 E.11282
G1 X93.463 Y95.392 E.01548
G1 X93.514 Y95.242 E.00335
G1 X93.566 Y95.158 E.00209
G1 X93.634 Y95.082 E.00215
G1 X93.832 Y94.959 E.00493
G1 X94.261 Y94.858 E.00932
G1 X100.01 Y86.648 E.21213
G1 X100.306 Y86.855 E.00765
G1 X94.548 Y95.079 E.21249
G1 X94.609 Y95.528 E.00959
G1 X94.582 Y95.672 E.00309
G1 X94.523 Y95.804 E.00307
G1 X94.428 Y95.923 E.00321
G1 X94.347 Y95.985 E.00216
G1 X94.072 Y96.116 E.00645
G1 X93.852 Y96.308 E.00618
G1 X93.723 Y96.387 E.00322
G1 X93.581 Y96.443 E.00321
G1 X93.441 Y96.472 E.00304
G1 X88.327 Y96.485 E.10824
G1 X89.492 Y97.817 E.03746
G1 X89.73 Y98.162 E.00886
G1 X89.919 Y98.526 E.00869
G1 X90.112 Y99.086 E.01253
G1 X90.205 Y99.681 E.01275
G1 X90.189 Y100.293 E.01296
G1 X90.067 Y100.879 E.01267
G1 X89.928 Y101.256 E.00849
G1 X89.745 Y101.614 E.00851
G1 X89.537 Y101.926 E.00793
G1 X89.4 Y102.098 E.00466
G1 X89.117 Y102.391 E.00864
G1 X88.647 Y102.752 E.01253
G1 X88.112 Y103.029 E.01275
G1 X87.759 Y103.15 E.00791
G1 X87.33 Y103.244 E.00929
G1 X86.932 Y103.279 E.00845
G1 X86.531 Y103.267 E.00849
G1 X85.948 Y103.163 E.01254
G1 X85.553 Y103.03 E.00882
G1 X85.025 Y102.757 E.01258
G1 X84.698 Y102.522 E.00851
G1 X84.403 Y102.251 E.00849
G1 X84.141 Y101.946 E.0085
G1 X83.918 Y101.613 E.00849
G1 X83.731 Y101.248 E.00869
G1 X83.554 Y100.72 E.01178
G1 X83.474 Y100.289 E.00929
G1 X83.452 Y99.89 E.00845
G1 X83.477 Y99.49 E.00849
G1 X83.549 Y99.095 E.0085
G1 X83.74 Y98.533 E.01255
G1 X83.912 Y98.201 E.00791
G1 X84.156 Y97.836 E.0093
G1 X85.335 Y96.482 E.038
G1 X80.368 Y96.482 E.10513
G1 X80.111 Y96.452 E.00546
G1 X79.902 Y96.366 E.00478
G1 X79.715 Y96.225 E.00497
G1 X79.622 Y96.12 E.00298
G1 X79.481 Y95.821 E.00698
G1 X79.451 Y95.565 E.00546
G1 X79.451 Y77.628 E.37965
G1 X79.487 Y77.356 E.0058
G1 X79.593 Y77.124 E.00541
G1 X79.693 Y76.998 E.00339
G1 X79.814 Y76.89 E.00344
G1 X80.032 Y76.775 E.00522
G1 X80.283 Y76.723 E.00541
G1 X93.309 Y76.721 E.27571
G1 X93.542 Y76.749 E.00497
G1 X93.679 Y76.794 E.00307
G1 X93.856 Y76.889 E.00424
G1 X93.807 Y77.082 E.0042
G1 X80.777 Y77.082 E.27579
G1 X80.489 Y77.133 E.00621
G1 X80.217 Y77.279 E.00652
G1 X79.998 Y77.5 E.0066
G1 X79.85 Y77.799 E.00705
G1 X79.812 Y78.056 E.0055
G1 X79.812 Y95.146 E.36173
G1 X79.849 Y95.395 E.00533
G1 X79.975 Y95.665 E.00629
G1 X80.172 Y95.887 E.00629
G1 X80.441 Y96.052 E.00669
G1 X80.768 Y96.12 E.00708
G1 X88.009 Y96.12 E.15325
; WIPE_START
M204 S6000
G1 X90.009 Y96.12 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X89.227 Y96.892 Z1.44 F18000
G1 Z1.04
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X89.811 Y97.561 E.01747
G1 X89.966 Y97.77 E.00512
G1 X90.085 Y97.957 E.00435
G1 X90.293 Y98.359 E.00891
G1 X90.453 Y98.783 E.00891
G1 X90.511 Y98.994 E.00431
G1 X90.594 Y99.443 E.00897
G1 X90.614 Y99.661 E.00431
G1 X90.616 Y100.079 E.00823
G1 X90.596 Y100.339 E.00512
G1 X90.564 Y100.557 E.00434
G1 X90.459 Y100.998 E.00891
G1 X90.303 Y101.42 E.00885
G1 X90.099 Y101.821 E.00885
G1 X89.868 Y102.167 E.00817
G1 X89.708 Y102.368 E.00506
G1 X89.394 Y102.693 E.0089
G1 X89.042 Y102.979 E.00891
G1 X88.861 Y103.102 E.00431
G1 X88.462 Y103.322 E.00897
G1 X88.261 Y103.411 E.00431
G1 X87.869 Y103.545 E.00816
G1 X87.392 Y103.649 E.0096
G1 X86.944 Y103.689 E.00883
G1 X86.494 Y103.676 E.00885
G1 X86.046 Y103.608 E.00891
G1 X85.834 Y103.557 E.00431
G1 X85.403 Y103.411 E.00895
G1 X85.168 Y103.305 E.00506
G1 X84.805 Y103.103 E.00817
G1 X84.44 Y102.84 E.00886
G1 X84.108 Y102.536 E.00885
G1 X83.815 Y102.195 E.00885
G1 X83.564 Y101.821 E.00885
G1 X83.359 Y101.418 E.00891
G1 X83.277 Y101.214 E.00431
G1 X83.155 Y100.817 E.00816
G1 X83.067 Y100.337 E.0096
G1 X83.042 Y99.889 E.00884
G1 X83.07 Y99.44 E.00885
G1 X83.151 Y98.997 E.00885
G1 X83.285 Y98.564 E.00891
G1 X83.369 Y98.362 E.00431
G1 X83.559 Y97.993 E.00816
G1 X83.831 Y97.587 E.00961
G1 X84.436 Y96.891 E.01815
G1 X80.344 Y96.891 E.08049
G1 X80.028 Y96.854 E.00625
G1 X79.893 Y96.814 E.00277
G1 X79.69 Y96.719 E.00441
G1 X79.435 Y96.527 E.00628
G1 X79.296 Y96.369 E.00415
G1 X79.216 Y96.248 E.00284
G1 X79.119 Y96.039 E.00454
G1 X79.079 Y95.904 E.00277
G1 X79.042 Y95.589 E.00625
G1 X79.042 Y77.61 E.35362
G1 X79.062 Y77.374 E.00466
G1 X79.096 Y77.234 E.00284
G1 X79.175 Y77.031 E.00427
G1 X79.253 Y76.894 E.0031
G1 X79.394 Y76.716 E.00447
G1 X79.564 Y76.565 E.00448
G1 X79.684 Y76.486 E.00283
G1 X79.891 Y76.389 E.00449
G1 X80.098 Y76.333 E.00421
G1 X80.257 Y76.313 E.00316
G1 X93.333 Y76.311 E.25719
G1 X93.632 Y76.347 E.00591
G1 X93.842 Y76.417 E.00436
G1 X94.04 Y76.524 E.00442
G1 X94.216 Y76.663 E.00442
G1 X94.366 Y76.831 E.00442
G1 X94.484 Y77.022 E.00442
G1 X94.567 Y77.231 E.00442
G1 X94.612 Y77.448 E.00436
G1 X94.621 Y88.791 E.2231
G1 X93.442 Y88.791 E.02321
G1 X93.442 Y77.491 E.22226
G1 X80.813 Y77.491 E.24839
G1 X80.625 Y77.524 E.00376
G1 X80.465 Y77.61 E.00356
G1 X80.336 Y77.741 E.00363
G1 X80.246 Y77.923 E.00398
G1 X80.222 Y78.086 E.00324
G1 X80.222 Y95.116 E.33498
G1 X80.245 Y95.276 E.00319
G1 X80.32 Y95.437 E.00349
G1 X80.438 Y95.57 E.00349
G1 X80.594 Y95.666 E.00361
G1 X80.81 Y95.711 E.00434
G1 X93.024 Y95.711 E.24024
G1 X93.058 Y95.326 E.00759
G1 X93.083 Y95.22 E.00214
G1 X93.147 Y95.058 E.00344
G1 X93.237 Y94.912 E.00337
G1 X93.357 Y94.778 E.00354
G1 X93.538 Y94.644 E.00441
G1 X93.698 Y94.57 E.00348
G1 X94.015 Y94.495 E.00641
G1 X99.909 Y86.078 E.20211
G1 X100.876 Y86.755 E.02321
G1 X94.979 Y95.177 E.20222
G1 X95.015 Y95.398 E.0044
G1 X95.019 Y95.562 E.00323
G1 X94.976 Y95.794 E.00465
G1 X94.88 Y96.01 E.00464
G1 X94.7 Y96.23 E.0056
G1 X94.561 Y96.336 E.00344
G1 X94.299 Y96.461 E.00571
G1 X94.096 Y96.639 E.00532
G1 X93.906 Y96.755 E.00438
G1 X93.698 Y96.837 E.00438
G1 X93.483 Y96.881 E.00433
G1 X89.287 Y96.892 E.08253
; WIPE_START
M204 S6000
G1 X89.811 Y97.561 E-.16153
G1 X89.966 Y97.77 E-.04949
G1 X90.085 Y97.957 E-.04202
G1 X90.293 Y98.359 E-.08608
G1 X90.369 Y98.56 E-.04087
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




G1 X88.959 Y97.784
G1 Z1.04
M73 P43 R14
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.378588
G1 F1500
M204 S6000
G1 X88.782 Y97.61 E.00437
; LINE_WIDTH: 0.418364
G1 X88.579 Y97.412 E.00555
; LINE_WIDTH: 0.455097
G1 X88.427 Y97.285 E.00424
; LINE_WIDTH: 0.480766
G1 X88.274 Y97.159 E.0045
M204 S10000
G1 X88.959 Y97.784 F18000
; LINE_WIDTH: 0.360394
G1 F1500
M204 S6000
G1 X89.319 Y98.227 E.00953
G1 X89.571 Y98.679 E.00863
G1 X89.697 Y99.029 E.00621
G1 X89.781 Y99.368 E.00585
G1 X89.828 Y99.919 E.00923
G1 X89.787 Y100.411 E.00825
G1 X89.703 Y100.769 E.00614
G1 X89.579 Y101.103 E.00594
G1 X89.317 Y101.578 E.00905
G1 X89.111 Y101.844 E.00563
G1 X88.859 Y102.107 E.00608
G1 X88.443 Y102.429 E.00878
G1 X88.114 Y102.61 E.00627
G1 X87.653 Y102.78 E.00821
G1 X87.272 Y102.865 E.00652
G1 X86.879 Y102.9 E.00658
G1 X86.529 Y102.884 E.00584
G1 X86.161 Y102.823 E.00623
G1 X85.67 Y102.666 E.00861
G1 X85.192 Y102.412 E.00904
G1 X84.78 Y102.086 E.00877
G1 X84.511 Y101.798 E.00658
G1 X84.304 Y101.512 E.0059
G1 X84.063 Y101.055 E.00862
G1 X83.924 Y100.628 E.00751
G1 X83.856 Y100.243 E.00652
G1 X83.834 Y99.891 E.00588
G1 X83.856 Y99.536 E.00594
G1 X83.9 Y99.275 E.00443
G1 X84.062 Y98.753 E.00913
G1 X84.241 Y98.395 E.00667
G1 X84.462 Y98.07 E.00657
G1 X84.828 Y97.664 E.00913
; LINE_WIDTH: 0.404857
G1 X85.009 Y97.48 E.00489
; LINE_WIDTH: 0.44268
G1 X85.208 Y97.31 E.00542
; LINE_WIDTH: 0.47806
G1 X85.379 Y97.165 E.00507
; WIPE_START
G1 X85.208 Y97.31 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X80.281 Y96.258 Z1.44 F18000
G1 Z1.04
G1 E.4 F1800
; LINE_WIDTH: 0.149903
G1 F1500
M204 S6000
G1 X79.989 Y96.091 E.00208
G1 X79.818 Y95.909 E.00155
G1 X79.75 Y95.803 E.00078
; LINE_WIDTH: 0.102409
G1 X79.693 Y95.617 E.00074
; WIPE_START
G1 X79.75 Y95.803 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X87.38 Y95.994 Z1.44 F18000
G1 X93.609 Y96.151 Z1.44
G1 Z1.04
G1 E.4 F1800
; LINE_WIDTH: 0.0923714
G1 F1500
M204 S6000
G1 X93.813 Y96.03 E.00079
; WIPE_START
G1 X93.609 Y96.151 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X89.029 Y90.046 Z1.44 F18000
G1 X79.688 Y77.598 Z1.44
G1 Z1.04
G1 E.4 F1800
; LINE_WIDTH: 0.102416
G1 F1500
M204 S6000
G1 X79.739 Y77.433 E.00066
; LINE_WIDTH: 0.152174
G1 X79.789 Y77.328 E.00073
G1 X80.022 Y77.084 E.00213
; LINE_WIDTH: 0.1304
G1 X80.225 Y76.991 E.00117
; LINE_WIDTH: 0.0898015
G1 X80.328 Y76.955 E.00035
; CHANGE_LAYER
; Z_HEIGHT: 1.16
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F1500
G1 X80.225 Y76.991 E-.38
; WIPE_END
G1 E-.02 F1800
; layer num/total_layer_count: 9/49
; update layer progress
M73 L9
M991 S0 P8 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z1.44 I-.582 J1.069 P1  F18000
G1 X93.851 Y84.415 Z1.44
G1 Z1.16
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X93.851 Y77.128 E.15422
G1 X94.036 Y77.076 E.00407
G1 X94.117 Y77.207 E.00325
G1 X94.173 Y77.349 E.00324
G1 X94.202 Y77.49 E.00305
G1 X94.212 Y88.382 E.23053
G1 X93.851 Y88.382 E.00764
G1 X93.851 Y84.475 E.08269
; WIPE_START
M204 S6000
G1 X93.851 Y82.475 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X93.874 Y90.107 Z1.56 F18000
G1 X93.89 Y95.435 Z1.56
G1 Z1.16
G1 E.4 F1800
G1 F1500
M204 S500
G1 X93.955 Y95.366 E.002
G1 X94.159 Y95.318 E.00444
G1 X94.184 Y95.493 E.00374
G1 X94.172 Y95.558 E.0014
G1 X94.121 Y95.619 E.00168
G1 X93.863 Y95.741 E.00605
G1 X93.885 Y95.494 E.00524
; WIPE_START
M204 S6000
G1 X93.955 Y95.366 E-.04593
G1 X94.159 Y95.318 E-.06578
G1 X94.184 Y95.493 E-.05539
G1 X94.172 Y95.558 E-.0207
G1 X94.121 Y95.619 E-.02497
G1 X93.863 Y95.741 E-.08963
G1 X93.885 Y95.494 E-.07761
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X87.99 Y97.081 Z1.56 F18000
G1 Z1.16
G1 E.4 F1800
G1 F1500
M204 S500
G1 X87.598 Y96.953 E.00874
G1 X87.225 Y96.88 E.00804
G1 X86.695 Y96.856 E.01123
G1 X86.153 Y96.93 E.01157
G1 X85.597 Y97.11 E.01238
G1 X85.49 Y96.949 E.0041
G1 X85.842 Y96.544 E.01135
G1 X87.754 Y96.544 E.04045
G1 X88.096 Y96.915 E.01069
G1 X88.023 Y97.031 E.00289
; WIPE_START
M204 S6000
G1 X87.598 Y96.953 E-.08206
G1 X87.225 Y96.88 E-.0722
G1 X86.695 Y96.856 E-.1008
G1 X86.153 Y96.93 E-.10385
G1 X86.048 Y96.964 E-.02109
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X88.968 Y101.414 Z1.56 F18000
G1 Z1.16
G1 E.4 F1800
G1 F1500
M204 S500
G1 X88.699 Y101.741 E.00896
G1 X88.348 Y102.039 E.00975
G1 X88.074 Y102.208 E.00681
G1 X87.804 Y102.334 E.00632
G1 X87.341 Y102.473 E.01023
G1 X86.88 Y102.521 E.0098
G1 X86.559 Y102.507 E.00681
G1 X86.264 Y102.459 E.00632
G1 X85.803 Y102.313 E.01023
G1 X85.387 Y102.089 E.00999
G1 X85.02 Y101.796 E.00995
G1 X84.711 Y101.442 E.00995
G1 X84.47 Y101.038 E.00995
G1 X84.308 Y100.607 E.00976
G1 X84.241 Y100.291 E.00683
G1 X84.212 Y99.97 E.00683
G1 X84.239 Y99.51 E.00975
G1 X84.348 Y99.063 E.00975
G1 X84.471 Y98.764 E.00683
G1 X84.628 Y98.482 E.00683
G1 X84.91 Y98.118 E.00975
G1 X85.252 Y97.809 E.00975
G1 X85.521 Y97.632 E.00683
G1 X85.81 Y97.487 E.00684
G1 X86.248 Y97.345 E.00975
G1 X86.714 Y97.282 E.00995
G1 X87.174 Y97.302 E.00975
G1 X87.491 Y97.365 E.00683
G1 X87.798 Y97.465 E.00683
G1 X88.21 Y97.671 E.00975
G1 X88.578 Y97.947 E.00975
G1 X88.805 Y98.177 E.00683
G1 X89.004 Y98.434 E.00687
G1 X89.232 Y98.85 E.01003
G1 X89.336 Y99.13 E.00632
G1 X89.412 Y99.442 E.00681
G1 X89.453 Y99.901 E.00975
G1 X89.411 Y100.371 E.00999
G1 X89.279 Y100.836 E.01023
G1 X89.157 Y101.109 E.00632
G1 X89.004 Y101.366 E.00633
M204 S250
G1 X88.652 Y101.154 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X88.407 Y101.452 E.0076
G1 X88.107 Y101.707 E.00773
G1 X87.879 Y101.847 E.00526
G1 X87.657 Y101.951 E.00482
G1 X87.26 Y102.07 E.00817
G1 X86.868 Y102.111 E.00775
G1 X86.601 Y102.099 E.00525
G1 X86.359 Y102.06 E.00482
G1 X85.963 Y101.934 E.00817
G1 X85.614 Y101.746 E.00781
G1 X85.304 Y101.499 E.0078
G1 X85.043 Y101.2 E.00779
G1 X84.84 Y100.86 E.0078
G1 X84.702 Y100.492 E.00774
G1 X84.646 Y100.23 E.00526
G1 X84.622 Y99.964 E.00526
G1 X84.645 Y99.571 E.00774
G1 X84.739 Y99.189 E.00773
G1 X84.84 Y98.942 E.00526
G1 X84.97 Y98.708 E.00526
G1 X85.211 Y98.397 E.00773
G1 X85.503 Y98.134 E.00774
G1 X85.726 Y97.987 E.00526
G1 X85.966 Y97.867 E.00527
G1 X86.34 Y97.746 E.00773
G1 X86.732 Y97.692 E.0078
M73 P43 R13
G1 X87.125 Y97.71 E.00773
G1 X87.388 Y97.762 E.00526
G1 X87.642 Y97.844 E.00526
G1 X87.994 Y98.02 E.00774
G1 X88.308 Y98.256 E.00773
G1 X88.496 Y98.447 E.00526
G1 X88.66 Y98.659 E.00528
G1 X88.859 Y99.02 E.00811
G1 X88.944 Y99.25 E.00482
G1 X89.007 Y99.509 E.00526
G1 X89.042 Y99.901 E.00773
G1 X89.007 Y100.296 E.00781
G1 X88.894 Y100.696 E.00817
G1 X88.793 Y100.919 E.00482
G1 X88.684 Y101.103 E.00421
; WIPE_START
M204 S6000
G1 X88.407 Y101.452 E-.08475
G1 X88.107 Y101.707 E-.07471
G1 X87.879 Y101.847 E-.05077
G1 X87.657 Y101.951 E-.04652
G1 X87.26 Y102.07 E-.07889
G1 X87.028 Y102.094 E-.04436
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X88.001 Y96.12 Z1.56 F18000
G1 Z1.16
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X93.416 Y96.12 E.1146
G1 X93.455 Y95.443 E.01436
G1 X93.477 Y95.335 E.00232
G1 X93.563 Y95.164 E.00405
G1 X93.666 Y95.053 E.00321
G1 X93.833 Y94.959 E.00406
G1 X94.261 Y94.858 E.0093
G1 X100.01 Y86.648 E.21214
G1 X100.306 Y86.855 E.00765
G1 X94.552 Y95.072 E.21231
G1 X94.61 Y95.52 E.00956
G1 X94.583 Y95.67 E.00322
G1 X94.526 Y95.795 E.00292
G1 X94.413 Y95.932 E.00374
G1 X94.302 Y96.011 E.0029
G1 X94.079 Y96.109 E.00516
G1 X93.852 Y96.308 E.00638
G1 X93.723 Y96.387 E.00321
G1 X93.582 Y96.443 E.00321
G1 X93.441 Y96.472 E.00304
G1 X88.277 Y96.485 E.1093
G1 X89.376 Y97.675 E.03429
G1 X89.632 Y98.008 E.00889
G1 X89.919 Y98.526 E.01254
G1 X90.112 Y99.087 E.01256
G1 X90.205 Y99.684 E.01279
G1 X90.189 Y100.294 E.01291
G1 X90.067 Y100.879 E.01267
G1 X89.928 Y101.256 E.00849
G1 X89.644 Y101.776 E.01254
G1 X89.396 Y102.103 E.00869
G1 X89.116 Y102.391 E.0085
G1 X88.647 Y102.752 E.01253
G1 X88.112 Y103.029 E.01275
G1 X87.763 Y103.149 E.00781
G1 X87.329 Y103.244 E.00939
G1 X86.932 Y103.279 E.00845
G1 X86.531 Y103.267 E.00849
G1 X85.939 Y103.161 E.01274
G1 X85.375 Y102.951 E.01273
G1 X85.024 Y102.757 E.0085
G1 X84.698 Y102.522 E.00849
G1 X84.403 Y102.251 E.00849
G1 X84.141 Y101.947 E.00849
G1 X83.918 Y101.613 E.00849
G1 X83.663 Y101.078 E.01255
G1 X83.555 Y100.725 E.00782
G1 X83.474 Y100.288 E.00939
G1 X83.452 Y99.89 E.00844
G1 X83.477 Y99.49 E.00849
G1 X83.549 Y99.095 E.00849
G1 X83.74 Y98.533 E.01256
G1 X83.909 Y98.205 E.00782
G1 X84.156 Y97.836 E.00939
G1 X85.335 Y96.482 E.038
G1 X80.368 Y96.482 E.10513
G1 X80.12 Y96.453 E.00527
G1 X79.975 Y96.405 E.00324
G1 X79.814 Y96.311 E.00394
G1 X79.699 Y96.21 E.00324
G1 X79.567 Y96.032 E.00469
G1 X79.481 Y95.821 E.00482
G1 X79.451 Y95.565 E.00546
G1 X79.451 Y77.628 E.37965
G1 X79.487 Y77.357 E.00578
G1 X79.592 Y77.125 E.00539
G1 X79.76 Y76.933 E.0054
G1 X79.892 Y76.84 E.00343
G1 X80.032 Y76.775 E.00327
G1 X80.283 Y76.723 E.00541
G1 X93.31 Y76.721 E.27574
G1 X93.542 Y76.749 E.00493
G1 X93.68 Y76.794 E.00308
G1 X93.856 Y76.889 E.00424
G1 X93.807 Y77.082 E.0042
G1 X80.778 Y77.082 E.27579
G1 X80.489 Y77.133 E.0062
G1 X80.217 Y77.279 E.00653
G1 X79.998 Y77.501 E.00661
G1 X79.85 Y77.799 E.00704
G1 X79.812 Y78.056 E.00549
G1 X79.812 Y95.146 E.36172
G1 X79.849 Y95.395 E.00533
G1 X79.975 Y95.665 E.0063
G1 X80.172 Y95.887 E.00629
G1 X80.441 Y96.053 E.00669
G1 X80.768 Y96.12 E.00708
G1 X87.941 Y96.12 E.15183
; WIPE_START
M204 S6000
G1 X89.942 Y96.12 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X89.209 Y96.892 Z1.56 F18000
G1 Z1.16
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X89.689 Y97.411 E.01389
G1 X89.967 Y97.772 E.00898
G1 X90.085 Y97.957 E.0043
G1 X90.293 Y98.359 E.00891
G1 X90.453 Y98.783 E.00891
G1 X90.511 Y98.994 E.00431
G1 X90.587 Y99.401 E.00813
G1 X90.614 Y99.662 E.00516
G1 X90.616 Y100.074 E.00811
G1 X90.596 Y100.339 E.00522
G1 X90.564 Y100.557 E.00434
G1 X90.459 Y100.998 E.00891
G1 X90.303 Y101.42 E.00885
G1 X90.097 Y101.824 E.00891
G1 X89.981 Y102.009 E.00431
G1 X89.707 Y102.37 E.00891
G1 X89.394 Y102.693 E.00885
G1 X89.042 Y102.979 E.00891
G1 X88.861 Y103.102 E.00431
G1 X88.462 Y103.322 E.00897
G1 X88.261 Y103.411 E.00431
G1 X87.873 Y103.544 E.00807
G1 X87.392 Y103.649 E.00969
G1 X86.944 Y103.689 E.00884
G1 X86.494 Y103.676 E.00885
G1 X86.046 Y103.608 E.00891
G1 X85.831 Y103.556 E.00437
G1 X85.618 Y103.491 E.00436
G1 X85.199 Y103.321 E.00891
G1 X84.805 Y103.103 E.00885
G1 X84.44 Y102.84 E.00885
G1 X84.108 Y102.536 E.00885
M73 P44 R13
G1 X83.815 Y102.195 E.00885
G1 X83.564 Y101.821 E.00885
G1 X83.358 Y101.418 E.00891
G1 X83.277 Y101.214 E.00431
G1 X83.157 Y100.822 E.00807
G1 X83.067 Y100.337 E.0097
G1 X83.042 Y99.889 E.00884
G1 X83.07 Y99.44 E.00885
G1 X83.151 Y98.997 E.00885
G1 X83.285 Y98.564 E.00891
G1 X83.369 Y98.362 E.00431
G1 X83.556 Y97.997 E.00807
G1 X83.831 Y97.587 E.0097
G1 X84.436 Y96.891 E.01815
G1 X80.344 Y96.891 E.08049
G1 X80.031 Y96.854 E.00619
G1 X79.818 Y96.784 E.00442
G1 X79.687 Y96.718 E.00289
G1 X79.564 Y96.637 E.00289
G1 X79.396 Y96.488 E.00442
G1 X79.214 Y96.243 E.006
G1 X79.119 Y96.039 E.00442
G1 X79.079 Y95.904 E.00277
G1 X79.042 Y95.589 E.00625
G1 X79.042 Y77.61 E.35362
G1 X79.062 Y77.374 E.00466
G1 X79.095 Y77.234 E.00283
G1 X79.181 Y77.019 E.00454
G1 X79.253 Y76.895 E.00283
G1 X79.396 Y76.714 E.00454
G1 X79.501 Y76.615 E.00283
G1 X79.687 Y76.484 E.00448
G1 X79.891 Y76.389 E.00443
G1 X80.096 Y76.333 E.00418
G1 X80.257 Y76.313 E.0032
G1 X93.335 Y76.311 E.25722
G1 X93.631 Y76.347 E.00587
G1 X93.842 Y76.417 E.00437
G1 X94.04 Y76.524 E.00442
G1 X94.216 Y76.663 E.00442
G1 X94.366 Y76.831 E.00442
G1 X94.484 Y77.022 E.00442
G1 X94.567 Y77.231 E.00442
G1 X94.612 Y77.448 E.00436
G1 X94.621 Y88.791 E.2231
G1 X93.442 Y88.791 E.02321
G1 X93.442 Y77.491 E.22226
G1 X80.813 Y77.491 E.24839
G1 X80.625 Y77.524 E.00376
G1 X80.465 Y77.61 E.00357
G1 X80.335 Y77.742 E.00364
G1 X80.245 Y77.923 E.00397
G1 X80.222 Y78.086 E.00324
G1 X80.222 Y95.116 E.33497
G1 X80.245 Y95.276 E.00319
G1 X80.32 Y95.437 E.00349
G1 X80.438 Y95.57 E.00349
G1 X80.594 Y95.666 E.00362
G1 X80.81 Y95.711 E.00433
G1 X93.03 Y95.711 E.24035
G1 X93.048 Y95.389 E.00634
G1 X93.084 Y95.218 E.00345
G1 X93.147 Y95.058 E.00339
G1 X93.236 Y94.914 E.00332
G1 X93.397 Y94.742 E.00463
G1 X93.535 Y94.645 E.00331
G1 X93.7 Y94.57 E.00357
G1 X94.015 Y94.495 E.00638
G1 X99.909 Y86.078 E.20211
G1 X100.876 Y86.755 E.02321
G1 X94.98 Y95.175 E.20217
G1 X95.019 Y95.559 E.0076
G1 X94.976 Y95.793 E.00469
G1 X94.876 Y96.014 E.00476
G1 X94.695 Y96.233 E.0056
G1 X94.505 Y96.369 E.00459
G1 X94.301 Y96.459 E.00438
G1 X94.096 Y96.639 E.00538
G1 X93.906 Y96.755 E.00438
G1 X93.698 Y96.837 E.00438
G1 X93.483 Y96.881 E.00433
G1 X89.269 Y96.892 E.08287
; WIPE_START
M204 S6000
G1 X89.689 Y97.411 E-.12675
G1 X89.967 Y97.772 E-.08671
G1 X90.085 Y97.957 E-.04156
G1 X90.293 Y98.359 E-.0861
G1 X90.365 Y98.551 E-.03888
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




G1 X88.823 Y97.647
G1 Z1.16
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.397623
G1 F1500
M204 S6000
G1 X88.638 Y97.48 E.00462
; LINE_WIDTH: 0.44275
G1 X88.454 Y97.314 E.00517
; LINE_WIDTH: 0.480579
G1 X88.211 Y97.129 E.00691
M204 S10000
G1 X88.823 Y97.647 F18000
; LINE_WIDTH: 0.360234
G1 F1500
M204 S6000
G1 X89.084 Y97.92 E.0063
G1 X89.324 Y98.239 E.00667
G1 X89.572 Y98.681 E.00845
G1 X89.7 Y99.023 E.0061
G1 X89.803 Y99.516 E.0084
G1 X89.83 Y99.916 E.00668
G1 X89.786 Y100.425 E.00853
G1 X89.638 Y100.954 E.00917
G1 X89.493 Y101.273 E.00585
G1 X89.294 Y101.613 E.00657
G1 X88.957 Y102.015 E.00876
G1 X88.558 Y102.349 E.00868
G1 X88.114 Y102.61 E.00859
G1 X87.657 Y102.779 E.00814
G1 X87.271 Y102.865 E.00659
G1 X86.904 Y102.9 E.00616
G1 X86.53 Y102.884 E.00625
G1 X86.04 Y102.79 E.00831
G1 X85.643 Y102.652 E.00702
G1 X85.192 Y102.412 E.00853
G1 X84.77 Y102.078 E.00898
G1 X84.445 Y101.716 E.00813
G1 X84.251 Y101.42 E.0059
G1 X84.024 Y100.945 E.00879
G1 X83.942 Y100.701 E.00429
G1 X83.87 Y100.357 E.00586
G1 X83.835 Y99.988 E.00619
G1 X83.856 Y99.536 E.00755
G1 X83.923 Y99.186 E.00594
G1 X84.029 Y98.837 E.0061
G1 X84.24 Y98.397 E.00814
G1 X84.462 Y98.07 E.0066
G1 X84.817 Y97.673 E.00889
; LINE_WIDTH: 0.400635
G1 X84.992 Y97.496 E.00464
; LINE_WIDTH: 0.438424
G1 X85.199 Y97.319 E.00561
; LINE_WIDTH: 0.477116
G1 X85.379 Y97.165 E.00533
; WIPE_START
G1 X85.199 Y97.319 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X80.294 Y96.251 Z1.56 F18000
G1 Z1.16
G1 E.4 F1800
; LINE_WIDTH: 0.148016
G1 F1500
M204 S6000
G1 X79.982 Y96.09 E.00215
G1 X79.75 Y95.803 E.00225
; LINE_WIDTH: 0.102386
G1 X79.693 Y95.617 E.00074
; WIPE_START
G1 X79.75 Y95.803 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X87.38 Y95.984 Z1.56 F18000
G1 X93.628 Y96.132 Z1.56
G1 Z1.16
G1 E.4 F1800
; LINE_WIDTH: 0.0967572
G1 F1500
M204 S6000
G1 X93.837 Y96.009 E.00086
; WIPE_START
G1 X93.628 Y96.132 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X89.04 Y90.032 Z1.56 F18000
G1 X79.688 Y77.598 Z1.56
G1 Z1.16
G1 E.4 F1800
; LINE_WIDTH: 0.102221
G1 F1500
M204 S6000
G1 X79.738 Y77.434 E.00065
; LINE_WIDTH: 0.149288
G1 X79.794 Y77.321 E.00077
G1 X79.942 Y77.153 E.00138
G1 X80.05 Y77.069 E.00084
; LINE_WIDTH: 0.125308
G1 X80.226 Y76.991 E.00096
; LINE_WIDTH: 0.0895971
G1 X80.328 Y76.955 E.00034
; CHANGE_LAYER
; Z_HEIGHT: 1.28
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F1500
G1 X80.226 Y76.991 E-.38
; WIPE_END
G1 E-.02 F1800
; layer num/total_layer_count: 10/49
; update layer progress
M73 L10
M991 S0 P9 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z1.56 I-.587 J1.066 P1  F18000
G1 X93.851 Y84.496 Z1.56
G1 Z1.28
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X93.851 Y77.128 E.15595
G1 X94.036 Y77.076 E.00407
G1 X94.117 Y77.207 E.00325
G1 X94.173 Y77.349 E.00324
G1 X94.202 Y77.49 E.00306
G1 X94.212 Y88.382 E.23052
G1 X93.851 Y88.382 E.00764
G1 X93.851 Y84.556 E.08097
; WIPE_START
M204 S6000
G1 X93.851 Y82.556 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X93.878 Y90.189 Z1.68 F18000
G1 X93.897 Y95.416 Z1.68
G1 Z1.28
G1 E.4 F1800
G1 F1500
M204 S500
G1 X93.969 Y95.362 E.0019
G1 X94.159 Y95.318 E.00413
G1 X94.184 Y95.493 E.00374
G1 X94.144 Y95.612 E.00267
G1 X93.858 Y95.747 E.0067
G1 X93.89 Y95.476 E.00578
; WIPE_START
M204 S6000
G1 X93.969 Y95.362 E-.04287
G1 X94.159 Y95.318 E-.06048
G1 X94.184 Y95.493 E-.05472
G1 X94.144 Y95.612 E-.03912
G1 X93.858 Y95.747 E-.09815
G1 X93.89 Y95.476 E-.08465
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X88.053 Y97.101 Z1.68 F18000
G1 Z1.28
G1 E.4 F1800
G1 F1500
M204 S500
G1 X87.598 Y96.953 E.01013
G1 X87.225 Y96.88 E.00804
G1 X86.695 Y96.856 E.01123
G1 X86.153 Y96.93 E.01157
G1 X85.597 Y97.11 E.01237
G1 X85.491 Y96.949 E.0041
G1 X85.842 Y96.544 E.01135
G1 X87.814 Y96.544 E.04172
G1 X88.16 Y96.939 E.01112
G1 X88.086 Y97.051 E.00283
; WIPE_START
M204 S6000
G1 X87.598 Y96.953 E-.09462
G1 X87.225 Y96.88 E-.0722
G1 X86.695 Y96.856 E-.1008
G1 X86.153 Y96.93 E-.10386
G1 X86.111 Y96.944 E-.00852
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X88.968 Y101.414 Z1.68 F18000
G1 Z1.28
G1 E.4 F1800
G1 F1500
M204 S500
G1 X88.699 Y101.741 E.00896
G1 X88.348 Y102.039 E.00975
G1 X88.074 Y102.208 E.00681
G1 X87.806 Y102.333 E.00627
G1 X87.341 Y102.473 E.01028
G1 X86.88 Y102.521 E.0098
G1 X86.559 Y102.507 E.0068
G1 X86.267 Y102.459 E.00627
G1 X85.803 Y102.313 E.01028
G1 X85.387 Y102.089 E.01
G1 X85.02 Y101.796 E.00995
G1 X84.711 Y101.442 E.00995
G1 X84.47 Y101.038 E.00995
G1 X84.308 Y100.607 E.00975
G1 X84.241 Y100.291 E.00683
G1 X84.212 Y99.97 E.00683
G1 X84.239 Y99.519 E.00955
G1 X84.306 Y99.205 E.00681
G1 X84.4 Y98.924 E.00626
G1 X84.621 Y98.491 E.01028
G1 X84.911 Y98.116 E.01005
G1 X85.275 Y97.793 E.01029
G1 X85.522 Y97.631 E.00626
G1 X85.81 Y97.487 E.00681
G1 X86.248 Y97.345 E.00975
G1 X86.714 Y97.282 E.00995
G1 X87.174 Y97.302 E.00975
G1 X87.491 Y97.365 E.00683
G1 X87.798 Y97.465 E.00683
G1 X88.21 Y97.671 E.00975
G1 X88.579 Y97.947 E.00975
G1 X88.805 Y98.177 E.00683
G1 X89.004 Y98.434 E.00688
G1 X89.233 Y98.852 E.01009
G1 X89.336 Y99.13 E.00627
G1 X89.412 Y99.442 E.00681
G1 X89.453 Y99.901 E.00975
G1 X89.411 Y100.371 E.01
G1 X89.278 Y100.839 E.01028
G1 X89.157 Y101.109 E.00627
G1 X89.004 Y101.365 E.00632
M204 S250
G1 X88.652 Y101.154 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X88.407 Y101.452 E.00761
G1 X88.107 Y101.707 E.00773
G1 X87.879 Y101.847 E.00526
G1 X87.66 Y101.95 E.00477
G1 X87.26 Y102.07 E.00822
G1 X86.868 Y102.111 E.00775
G1 X86.601 Y102.099 E.00525
G1 X86.362 Y102.06 E.00477
G1 X85.963 Y101.934 E.00821
G1 X85.614 Y101.746 E.00781
G1 X85.304 Y101.499 E.0078
G1 X85.043 Y101.2 E.0078
G1 X84.84 Y100.86 E.0078
G1 X84.702 Y100.492 E.00773
G1 X84.646 Y100.23 E.00526
G1 X84.622 Y99.964 E.00526
G1 X84.645 Y99.575 E.00767
G1 X84.701 Y99.313 E.00526
G1 X84.778 Y99.084 E.00477
G1 X84.968 Y98.711 E.00822
G1 X85.211 Y98.397 E.00783
G1 X85.524 Y98.119 E.00822
G1 X85.727 Y97.987 E.00477
G1 X85.966 Y97.867 E.00526
G1 X86.34 Y97.746 E.00773
G1 X86.732 Y97.692 E.0078
G1 X87.125 Y97.71 E.00773
G1 X87.388 Y97.762 E.00526
G1 X87.642 Y97.844 E.00526
G1 X87.994 Y98.02 E.00774
G1 X88.309 Y98.256 E.00773
G1 X88.496 Y98.447 E.00526
G1 X88.66 Y98.659 E.00528
G1 X88.859 Y99.022 E.00815
G1 X88.944 Y99.25 E.00477
G1 X89.007 Y99.509 E.00525
G1 X89.042 Y99.901 E.00773
G1 X89.007 Y100.296 E.00781
G1 X88.893 Y100.698 E.00822
G1 X88.793 Y100.919 E.00477
G1 X88.684 Y101.103 E.0042
; WIPE_START
M204 S6000
G1 X88.407 Y101.452 E-.08478
G1 X88.107 Y101.707 E-.07469
G1 X87.879 Y101.847 E-.05077
G1 X87.66 Y101.95 E-.04607
G1 X87.26 Y102.07 E-.07936
G1 X87.028 Y102.094 E-.04433
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X88.067 Y96.12 Z1.68 F18000
G1 Z1.28
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X93.399 Y96.12 E.11285
G1 X93.462 Y95.401 E.01529
G1 X93.49 Y95.295 E.00232
G1 X93.567 Y95.156 E.00335
G1 X93.748 Y94.998 E.00508
G1 X93.834 Y94.958 E.00201
G1 X94.261 Y94.858 E.00928
G1 X100.01 Y86.648 E.21214
G1 X100.306 Y86.855 E.00765
G1 X94.552 Y95.072 E.21231
G1 X94.61 Y95.52 E.00956
G1 X94.582 Y95.672 E.00326
G1 X94.523 Y95.804 E.00307
G1 X94.43 Y95.921 E.00317
G1 X94.338 Y95.99 E.00244
G1 X94.073 Y96.115 E.0062
G1 X93.852 Y96.308 E.00621
G1 X93.723 Y96.387 E.00321
G1 X93.582 Y96.443 E.00321
G1 X93.441 Y96.472 E.00304
G1 X88.326 Y96.485 E.10827
G1 X89.487 Y97.811 E.03729
G1 X89.629 Y98.002 E.00505
G1 X89.919 Y98.526 E.01267
G1 X90.063 Y98.91 E.00869
G1 X90.181 Y99.455 E.0118
G1 X90.205 Y99.683 E.00486
G1 X90.206 Y100.091 E.00862
G1 X90.16 Y100.489 E.00849
G1 X90.003 Y101.07 E.01274
G1 X89.745 Y101.614 E.01275
G1 X89.4 Y102.098 E.01258
G1 X89.116 Y102.391 E.00863
G1 X88.798 Y102.65 E.00868
G1 X88.474 Y102.855 E.00813
G1 X88.145 Y103.014 E.00772
G1 X87.713 Y103.164 E.00969
G1 X87.132 Y103.267 E.01248
G1 X86.731 Y103.279 E.00849
G1 X86.332 Y103.243 E.00849
G1 X85.93 Y103.159 E.00869
G1 X85.375 Y102.951 E.01253
G1 X85.024 Y102.757 E.00849
G1 X84.699 Y102.522 E.00849
G1 X84.403 Y102.251 E.00849
G1 X84.141 Y101.947 E.00849
G1 X83.918 Y101.613 E.0085
G1 X83.663 Y101.077 E.01256
G1 X83.556 Y100.729 E.00772
G1 X83.474 Y100.288 E.00949
G1 X83.452 Y99.89 E.00844
G1 X83.477 Y99.49 E.00849
G1 X83.549 Y99.095 E.00849
G1 X83.74 Y98.533 E.01256
M73 P45 R13
G1 X83.907 Y98.209 E.00772
G1 X84.156 Y97.836 E.00949
G1 X85.335 Y96.482 E.038
G1 X80.368 Y96.482 E.10513
G1 X80.132 Y96.454 E.00503
G1 X79.917 Y96.374 E.00484
G1 X79.8 Y96.302 E.00291
G1 X79.655 Y96.162 E.00426
G1 X79.571 Y96.041 E.00311
G1 X79.481 Y95.821 E.00504
G1 X79.451 Y95.565 E.00546
G1 X79.451 Y77.628 E.37965
G1 X79.487 Y77.356 E.00581
G1 X79.594 Y77.123 E.00542
G1 X79.694 Y76.997 E.00341
G1 X79.803 Y76.899 E.00311
G1 X80.031 Y76.775 E.00549
G1 X80.281 Y76.723 E.00539
G1 X93.312 Y76.721 E.27582
G1 X93.541 Y76.749 E.00489
G1 X93.68 Y76.794 E.00308
G1 X93.856 Y76.889 E.00424
G1 X93.807 Y77.082 E.0042
G1 X80.778 Y77.082 E.27579
G1 X80.489 Y77.132 E.0062
G1 X80.217 Y77.279 E.00654
G1 X79.997 Y77.502 E.00662
G1 X79.85 Y77.799 E.00702
G1 X79.812 Y78.056 E.00549
G1 X79.812 Y95.146 E.36173
G1 X79.849 Y95.395 E.00533
G1 X79.975 Y95.665 E.00629
G1 X80.172 Y95.887 E.00629
G1 X80.441 Y96.053 E.00669
G1 X80.768 Y96.12 E.00707
G1 X88.007 Y96.12 E.15322
; WIPE_START
M204 S6000
G1 X90.007 Y96.12 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X89.226 Y96.892 Z1.68 F18000
G1 Z1.28
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X89.806 Y97.554 E.0173
G1 X89.966 Y97.771 E.00531
G1 X90.085 Y97.957 E.00435
G1 X90.293 Y98.359 E.00891
G1 X90.453 Y98.783 E.00891
G1 X90.511 Y98.994 E.00431
G1 X90.587 Y99.396 E.00804
G1 X90.614 Y99.662 E.00525
G1 X90.615 Y100.114 E.00889
G1 X90.563 Y100.56 E.00885
G1 X90.458 Y101.001 E.00891
G1 X90.305 Y101.417 E.00873
G1 X90.099 Y101.821 E.00892
G1 X89.874 Y102.159 E.00798
G1 X89.708 Y102.368 E.00525
G1 X89.394 Y102.693 E.00889
G1 X89.042 Y102.979 E.00891
G1 X88.858 Y103.103 E.00437
G1 X88.667 Y103.217 E.00437
G1 X88.302 Y103.393 E.00798
G1 X87.829 Y103.557 E.00985
G1 X87.617 Y103.609 E.00429
G1 X87.169 Y103.676 E.00891
G1 X86.719 Y103.689 E.00885
G1 X86.271 Y103.649 E.00885
G1 X85.828 Y103.555 E.00891
G1 X85.618 Y103.491 E.0043
G1 X85.199 Y103.321 E.00891
G1 X84.805 Y103.103 E.00885
G1 X84.44 Y102.84 E.00885
G1 X84.108 Y102.536 E.00885
G1 X83.815 Y102.195 E.00885
G1 X83.564 Y101.821 E.00885
G1 X83.359 Y101.418 E.00891
G1 X83.277 Y101.214 E.00431
G1 X83.158 Y100.826 E.00797
G1 X83.067 Y100.337 E.00979
G1 X83.042 Y99.889 E.00883
G1 X83.07 Y99.44 E.00885
G1 X83.151 Y98.997 E.00885
G1 X83.285 Y98.564 E.00891
G1 X83.369 Y98.361 E.00431
G1 X83.554 Y98.001 E.00798
G1 X83.831 Y97.587 E.00979
G1 X84.436 Y96.891 E.01815
G1 X80.344 Y96.891 E.08049
G1 X80.035 Y96.855 E.00612
G1 X79.736 Y96.743 E.00628
G1 X79.56 Y96.634 E.00408
G1 X79.447 Y96.54 E.00288
G1 X79.336 Y96.419 E.00323
G1 X79.215 Y96.246 E.00415
G1 X79.119 Y96.039 E.00449
G1 X79.079 Y95.904 E.00277
G1 X79.042 Y95.589 E.00625
G1 X79.042 Y77.61 E.35362
G1 X79.062 Y77.374 E.00466
G1 X79.096 Y77.234 E.00284
G1 X79.174 Y77.034 E.00421
G1 X79.253 Y76.894 E.00317
G1 X79.394 Y76.716 E.00447
G1 X79.551 Y76.575 E.00415
G1 X79.685 Y76.485 E.00317
G1 X79.891 Y76.389 E.00446
G1 X80.111 Y76.33 E.00448
G1 X80.257 Y76.313 E.00289
G1 X93.337 Y76.311 E.25727
G1 X93.631 Y76.347 E.00584
G1 X93.842 Y76.417 E.00437
G1 X94.04 Y76.524 E.00442
G1 X94.216 Y76.663 E.00442
G1 X94.366 Y76.831 E.00442
G1 X94.484 Y77.022 E.00442
G1 X94.567 Y77.231 E.00442
G1 X94.612 Y77.448 E.00436
G1 X94.621 Y88.791 E.2231
G1 X93.442 Y88.791 E.02321
G1 X93.442 Y77.491 E.22226
G1 X80.813 Y77.491 E.24839
G1 X80.625 Y77.524 E.00376
G1 X80.465 Y77.61 E.00357
G1 X80.335 Y77.742 E.00365
G1 X80.245 Y77.923 E.00396
G1 X80.222 Y78.086 E.00324
G1 X80.222 Y95.116 E.33498
G1 X80.245 Y95.277 E.00319
G1 X80.32 Y95.437 E.00349
G1 X80.438 Y95.57 E.00349
G1 X80.594 Y95.666 E.00361
G1 X80.81 Y95.711 E.00433
G1 X93.024 Y95.711 E.24023
G1 X93.057 Y95.329 E.00753
G1 X93.103 Y95.16 E.00344
G1 X93.237 Y94.911 E.00557
G1 X93.35 Y94.785 E.00333
G1 X93.538 Y94.644 E.00461
G1 X93.701 Y94.569 E.00353
G1 X94.015 Y94.495 E.00636
G1 X99.909 Y86.078 E.20211
G1 X100.876 Y86.755 E.02321
G1 X94.98 Y95.175 E.20217
G1 X95.019 Y95.559 E.0076
G1 X94.976 Y95.794 E.0047
G1 X94.88 Y96.009 E.00464
G1 X94.701 Y96.23 E.00559
G1 X94.55 Y96.343 E.00371
G1 X94.299 Y96.46 E.00544
G1 X94.096 Y96.639 E.00533
G1 X93.906 Y96.755 E.00438
G1 X93.698 Y96.837 E.00438
G1 X93.483 Y96.881 E.00433
G1 X89.286 Y96.892 E.08254
; WIPE_START
M204 S6000
G1 X89.806 Y97.554 E-.15984
G1 X89.966 Y97.771 E-.05126
G1 X90.085 Y97.957 E-.042
G1 X90.293 Y98.359 E-.08608
G1 X90.369 Y98.56 E-.04083
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




G1 X88.825 Y97.645
G1 Z1.28
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.39691
G1 F1500
M204 S6000
G1 X88.703 Y97.532 E.00308
; LINE_WIDTH: 0.431433
G1 X88.581 Y97.419 E.00336
; LINE_WIDTH: 0.466997
G1 X88.452 Y97.3 E.00388
; LINE_WIDTH: 0.471509
G1 X88.289 Y97.337 E.00371
; LINE_WIDTH: 0.443552
G1 X88.127 Y97.375 E.00347
M204 S10000
G1 X88.825 Y97.645 F18000
; LINE_WIDTH: 0.360205
G1 F1500
M204 S6000
G1 X89.188 Y98.048 E.00905
G1 X89.399 Y98.356 E.00623
G1 X89.573 Y98.684 E.00618
G1 X89.74 Y99.176 E.00868
G1 X89.821 Y99.708 E.00898
G1 X89.823 Y100.069 E.00602
G1 X89.786 Y100.425 E.00597
G1 X89.646 Y100.938 E.00888
G1 X89.485 Y101.29 E.00646
G1 X89.29 Y101.61 E.00624
G1 X88.978 Y101.994 E.00827
G1 X88.574 Y102.344 E.0089
G1 X88.263 Y102.537 E.00611
G1 X87.929 Y102.689 E.00612
G1 X87.43 Y102.841 E.0087
G1 X86.879 Y102.898 E.00925
G1 X86.39 Y102.866 E.00817
G1 X85.88 Y102.74 E.00878
G1 X85.54 Y102.605 E.00609
G1 X85.192 Y102.412 E.00665
G1 X84.771 Y102.078 E.00897
G1 X84.445 Y101.716 E.00813
G1 X84.249 Y101.418 E.00594
G1 X84.082 Y101.093 E.0061
G1 X83.925 Y100.636 E.00807
G1 X83.854 Y100.243 E.00667
G1 X83.834 Y99.891 E.00587
G1 X83.856 Y99.536 E.00594
G1 X83.92 Y99.186 E.00594
G1 X84.047 Y98.789 E.00695
G1 X84.295 Y98.303 E.0091
G1 X84.626 Y97.87 E.00909
G1 X84.83 Y97.661 E.00487
; LINE_WIDTH: 0.405883
G1 X85.014 Y97.476 E.00495
; LINE_WIDTH: 0.443718
G1 X85.21 Y97.308 E.00537
; LINE_WIDTH: 0.478284
G1 X85.379 Y97.165 E.00501
; WIPE_START
G1 X85.21 Y97.308 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X80.294 Y96.251 Z1.68 F18000
G1 Z1.28
G1 E.4 F1800
; LINE_WIDTH: 0.136084
G1 F1500
M204 S6000
G1 X79.988 Y96.092 E.0019
; LINE_WIDTH: 0.155032
G1 X79.813 Y95.901 E.00168
G1 X79.75 Y95.803 E.00075
; LINE_WIDTH: 0.102412
G1 X79.693 Y95.617 E.00074
; WIPE_START
G1 X79.75 Y95.803 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X87.38 Y95.995 Z1.68 F18000
G1 X93.609 Y96.151 Z1.68
G1 Z1.28
G1 E.4 F1800
; LINE_WIDTH: 0.103411
G1 F1500
M204 S6000
G1 X93.817 Y96.026 E.00094
; WIPE_START
G1 X93.609 Y96.151 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X89.029 Y90.046 Z1.68 F18000
G1 X79.688 Y77.598 Z1.68
G1 Z1.28
G1 E.4 F1800
; LINE_WIDTH: 0.102371
G1 F1500
M204 S6000
G1 X79.739 Y77.432 E.00066
; LINE_WIDTH: 0.152081
G1 X79.788 Y77.33 E.00071
G1 X80.025 Y77.082 E.00216
; LINE_WIDTH: 0.131747
G1 X80.209 Y76.995 E.00108
; LINE_WIDTH: 0.0957378
G1 X80.296 Y76.963 E.00032
; LINE_WIDTH: 0.0812225
G1 X80.328 Y76.955 E.00009
; CHANGE_LAYER
; Z_HEIGHT: 1.4
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F1500
G1 X80.296 Y76.963 E-.38
; WIPE_END
G1 E-.02 F1800
; layer num/total_layer_count: 11/49
; update layer progress
M73 L11
M991 S0 P10 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z1.68 I-.592 J1.063 P1  F18000
G1 X93.851 Y84.506 Z1.68
G1 Z1.4
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X93.851 Y77.128 E.15616
G1 X94.036 Y77.076 E.00407
G1 X94.117 Y77.207 E.00325
G1 X94.173 Y77.349 E.00324
G1 X94.202 Y77.49 E.00306
G1 X94.212 Y88.382 E.23052
G1 X93.851 Y88.382 E.00764
G1 X93.851 Y84.566 E.08075
; WIPE_START
M204 S6000
G1 X93.851 Y82.566 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X93.869 Y90.199 Z1.8 F18000
G1 X93.882 Y95.464 Z1.8
G1 Z1.4
G1 E.4 F1800
G1 F1500
M204 S500
G1 X93.903 Y95.412 E.00119
G1 X93.967 Y95.364 E.00169
G1 X94.158 Y95.318 E.00414
G1 X94.185 Y95.486 E.00361
G1 X94.151 Y95.598 E.00248
G1 X93.858 Y95.743 E.00692
G1 X93.877 Y95.523 E.00467
; WIPE_START
M204 S6000
G1 X93.903 Y95.412 E-.03559
G1 X93.967 Y95.364 E-.02483
G1 X94.158 Y95.318 E-.06068
G1 X94.185 Y95.486 E-.05284
G1 X94.151 Y95.598 E-.03628
G1 X93.858 Y95.743 E-.10135
G1 X93.877 Y95.523 E-.06843
; WIPE_END
G1 E-.02 F1800
M204 S10000
M73 P46 R13
G1 X88.066 Y97.128 Z1.8 F18000
G1 Z1.4
G1 E.4 F1800
G1 F1500
M204 S500
G1 X87.773 Y97.002 E.00674
G1 X87.241 Y96.881 E.01157
G1 X86.695 Y96.856 E.01156
G1 X86.153 Y96.93 E.01157
G1 X85.597 Y97.11 E.01237
G1 X85.49 Y96.949 E.0041
G1 X85.842 Y96.544 E.01135
G1 X87.821 Y96.544 E.04188
G1 X88.186 Y96.964 E.01176
G1 X88.102 Y97.079 E.00302
; WIPE_START
M204 S6000
G1 X87.773 Y97.002 E-.06406
G1 X87.241 Y96.881 E-.10382
G1 X86.695 Y96.856 E-.10378
G1 X86.153 Y96.93 E-.10386
G1 X86.131 Y96.937 E-.00448
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X88.969 Y101.413 Z1.8 F18000
G1 Z1.4
G1 E.4 F1800
G1 F1500
M204 S500
G1 X88.699 Y101.741 E.00897
G1 X88.348 Y102.039 E.00975
G1 X88.074 Y102.208 E.00681
G1 X87.809 Y102.332 E.00621
G1 X87.341 Y102.473 E.01034
G1 X86.88 Y102.521 E.00981
G1 X86.559 Y102.507 E.0068
G1 X86.269 Y102.46 E.00621
G1 X85.804 Y102.313 E.01033
G1 X85.387 Y102.089 E.01
G1 X85.02 Y101.796 E.00995
G1 X84.711 Y101.442 E.00995
G1 X84.47 Y101.038 E.00995
G1 X84.308 Y100.607 E.00975
G1 X84.241 Y100.292 E.00683
G1 X84.212 Y99.97 E.00683
G1 X84.239 Y99.519 E.00955
G1 X84.306 Y99.205 E.00681
G1 X84.399 Y98.927 E.00621
G1 X84.621 Y98.491 E.01034
G1 X84.91 Y98.118 E.01
G1 X85.252 Y97.809 E.00975
G1 X85.521 Y97.632 E.00683
G1 X85.81 Y97.487 E.00683
G1 X86.248 Y97.345 E.00975
G1 X86.714 Y97.282 E.00995
G1 X87.183 Y97.303 E.00995
G1 X87.642 Y97.407 E.00995
G1 X88.065 Y97.588 E.00975
G1 X88.34 Y97.758 E.00684
G1 X88.585 Y97.954 E.00663
G1 X88.805 Y98.177 E.00664
G1 X89.004 Y98.434 E.00688
G1 X89.234 Y98.855 E.01014
G1 X89.336 Y99.13 E.00621
G1 X89.412 Y99.442 E.0068
G1 X89.454 Y99.903 E.0098
G1 X89.406 Y100.39 E.01034
G1 X89.335 Y100.674 E.00621
G1 X89.222 Y100.975 E.00681
G1 X89.005 Y101.366 E.00946
M204 S250
G1 X88.652 Y101.153 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X88.407 Y101.452 E.00761
G1 X88.107 Y101.707 E.00773
G1 X87.879 Y101.847 E.00526
G1 X87.662 Y101.949 E.00472
G1 X87.26 Y102.07 E.00826
G1 X86.868 Y102.111 E.00775
G1 X86.601 Y102.099 E.00525
G1 X86.364 Y102.061 E.00472
G1 X85.964 Y101.934 E.00826
G1 X85.614 Y101.746 E.00781
G1 X85.304 Y101.499 E.0078
G1 X85.043 Y101.2 E.0078
G1 X84.84 Y100.86 E.0078
G1 X84.702 Y100.492 E.00773
G1 X84.646 Y100.23 E.00526
G1 X84.622 Y99.964 E.00526
G1 X84.645 Y99.574 E.00767
G1 X84.701 Y99.313 E.00525
G1 X84.778 Y99.086 E.00472
G1 X84.968 Y98.711 E.00826
G1 X85.211 Y98.397 E.00781
G1 X85.503 Y98.134 E.00774
G1 X85.726 Y97.987 E.00526
G1 X85.966 Y97.867 E.00526
G1 X86.34 Y97.746 E.00773
G1 X86.732 Y97.692 E.0078
G1 X87.128 Y97.71 E.00779
G1 X87.515 Y97.798 E.0078
G1 X87.876 Y97.953 E.00773
G1 X88.104 Y98.094 E.00527
G1 X88.311 Y98.258 E.0052
G1 X88.496 Y98.447 E.0052
G1 X88.66 Y98.659 E.00528
G1 X88.86 Y99.025 E.0082
G1 X88.944 Y99.25 E.00472
G1 X89.007 Y99.509 E.00525
G1 X89.043 Y99.902 E.00775
G1 X89.001 Y100.32 E.00826
G1 X88.944 Y100.553 E.00472
G1 X88.85 Y100.803 E.00526
G1 X88.683 Y101.102 E.00674
; WIPE_START
M204 S6000
G1 X88.407 Y101.452 E-.08482
G1 X88.107 Y101.707 E-.0747
G1 X87.879 Y101.847 E-.05077
G1 X87.662 Y101.949 E-.04558
G1 X87.26 Y102.07 E-.07983
G1 X87.028 Y102.094 E-.04431
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X88.075 Y96.12 Z1.8 F18000
G1 Z1.4
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X93.399 Y96.12 E.11269
G1 X93.463 Y95.394 E.01542
G1 X93.514 Y95.243 E.00339
G1 X93.567 Y95.156 E.00216
G1 X93.628 Y95.088 E.00194
G1 X93.824 Y94.962 E.00494
G1 X94.262 Y94.857 E.00952
G1 X100.01 Y86.648 E.21211
G1 X100.306 Y86.855 E.00765
G1 X94.548 Y95.078 E.21247
G1 X94.609 Y95.528 E.0096
G1 X94.582 Y95.672 E.0031
G1 X94.523 Y95.804 E.00307
G1 X94.435 Y95.916 E.00302
G1 X94.302 Y96.011 E.00346
G1 X94.079 Y96.109 E.00516
G1 X93.852 Y96.308 E.00638
G1 X93.723 Y96.387 E.00322
G1 X93.582 Y96.443 E.00321
G1 X93.441 Y96.472 E.00304
G1 X88.332 Y96.485 E.10814
G1 X89.515 Y97.845 E.03814
G1 X89.73 Y98.161 E.0081
G1 X89.919 Y98.526 E.00869
G1 X90.112 Y99.086 E.01253
G1 X90.205 Y99.681 E.01276
G1 X90.207 Y100.051 E.00783
G1 X90.189 Y100.294 E.00515
G1 X90.067 Y100.879 E.01266
G1 X89.928 Y101.256 E.00849
G1 X89.741 Y101.621 E.00868
G1 X89.39 Y102.11 E.01274
G1 X89.002 Y102.49 E.0115
G1 X88.629 Y102.764 E.00979
G1 X88.474 Y102.855 E.00382
G1 X88.149 Y103.012 E.00763
G1 X87.713 Y103.164 E.00978
G1 X87.132 Y103.267 E.01248
G1 X86.731 Y103.279 E.00849
G1 X86.332 Y103.243 E.00849
G1 X85.93 Y103.159 E.00869
G1 X85.42 Y102.971 E.0115
G1 X85.022 Y102.755 E.00959
G1 X84.699 Y102.522 E.00843
G1 X84.403 Y102.251 E.0085
G1 X84.141 Y101.947 E.00849
G1 X83.918 Y101.613 E.00849
G1 X83.663 Y101.078 E.01256
G1 X83.557 Y100.733 E.00763
G1 X83.474 Y100.288 E.00958
G1 X83.452 Y99.89 E.00843
G1 X83.477 Y99.49 E.00849
G1 X83.549 Y99.095 E.0085
G1 X83.741 Y98.533 E.01256
G1 X83.905 Y98.213 E.00762
G1 X84.157 Y97.836 E.00959
G1 X85.335 Y96.482 E.03799
G1 X80.368 Y96.482 E.10513
G1 X80.12 Y96.453 E.00527
G1 X79.975 Y96.405 E.00324
G1 X79.814 Y96.312 E.00394
G1 X79.693 Y96.204 E.00344
G1 X79.592 Y96.076 E.00343
G1 X79.479 Y95.803 E.00627
G1 X79.451 Y95.565 E.00508
G1 X79.451 Y77.628 E.37964
G1 X79.487 Y77.357 E.00578
G1 X79.547 Y77.205 E.00346
G1 X79.623 Y77.081 E.00308
G1 X79.807 Y76.896 E.00552
G1 X80.023 Y76.778 E.0052
G1 X80.281 Y76.723 E.00559
G1 X93.313 Y76.721 E.27585
G1 X93.541 Y76.749 E.00486
G1 X93.68 Y76.794 E.00308
G1 X93.856 Y76.889 E.00424
G1 X93.807 Y77.082 E.0042
G1 X80.784 Y77.082 E.27565
G1 X80.52 Y77.122 E.00567
G1 X80.222 Y77.274 E.00706
G1 X79.997 Y77.502 E.00679
G1 X79.85 Y77.799 E.00701
G1 X79.812 Y78.056 E.00549
G1 X79.812 Y95.146 E.36173
G1 X79.849 Y95.395 E.00533
G1 X79.975 Y95.665 E.0063
G1 X80.172 Y95.887 E.00629
G1 X80.441 Y96.053 E.00669
G1 X80.768 Y96.12 E.00707
G1 X88.015 Y96.12 E.15338
; WIPE_START
M204 S6000
G1 X90.015 Y96.12 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X89.228 Y96.892 Z1.8 F18000
G1 Z1.4
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X89.835 Y97.59 E.01819
G1 X90.085 Y97.957 E.00873
G1 X90.293 Y98.359 E.00891
G1 X90.453 Y98.783 E.00891
G1 X90.511 Y98.994 E.00431
G1 X90.594 Y99.443 E.00897
G1 X90.614 Y99.661 E.00431
G1 X90.617 Y100.065 E.00795
G1 X90.596 Y100.339 E.0054
G1 X90.564 Y100.557 E.00434
G1 X90.459 Y100.998 E.00891
G1 X90.303 Y101.42 E.00885
G1 X90.097 Y101.824 E.00891
G1 X89.981 Y102.009 E.00431
G1 X89.705 Y102.372 E.00897
G1 X89.557 Y102.534 E.00431
G1 X89.263 Y102.806 E.00789
G1 X88.855 Y103.105 E.00995
G1 X88.667 Y103.217 E.00429
G1 X88.306 Y103.391 E.00789
G1 X87.829 Y103.557 E.00995
G1 X87.617 Y103.609 E.00429
G1 X87.169 Y103.676 E.00891
G1 X86.719 Y103.689 E.00885
G1 X86.271 Y103.649 E.00885
G1 X85.828 Y103.555 E.00891
G1 X85.618 Y103.491 E.00431
G1 X85.246 Y103.342 E.00788
G1 X84.804 Y103.102 E.00988
G1 X84.44 Y102.84 E.00883
G1 X84.108 Y102.536 E.00885
G1 X83.815 Y102.195 E.00885
G1 X83.564 Y101.821 E.00885
G1 X83.358 Y101.417 E.00891
G1 X83.277 Y101.214 E.00431
G1 X83.159 Y100.831 E.00789
G1 X83.067 Y100.337 E.00988
G1 X83.042 Y99.889 E.00883
G1 X83.07 Y99.44 E.00885
G1 X83.151 Y98.997 E.00885
G1 X83.285 Y98.564 E.00891
G1 X83.369 Y98.361 E.00431
G1 X83.552 Y98.005 E.00789
G1 X83.831 Y97.587 E.00988
G1 X84.436 Y96.891 E.01814
G1 X80.344 Y96.891 E.08049
G1 X80.031 Y96.854 E.00619
G1 X79.818 Y96.784 E.00442
G1 X79.687 Y96.718 E.00289
G1 X79.564 Y96.637 E.00289
G1 X79.394 Y96.486 E.00448
G1 X79.253 Y96.307 E.00448
G1 X79.182 Y96.185 E.00277
G1 X79.078 Y95.898 E.00601
G1 X79.042 Y95.589 E.00613
G1 X79.042 Y77.61 E.35362
G1 X79.062 Y77.374 E.00467
G1 X79.095 Y77.234 E.00283
G1 X79.18 Y77.022 E.00449
G1 X79.289 Y76.843 E.00412
G1 X79.392 Y76.718 E.0032
G1 X79.562 Y76.567 E.00446
G1 X79.756 Y76.447 E.00448
G1 X79.888 Y76.39 E.00283
G1 X80.111 Y76.33 E.00454
G1 X80.257 Y76.313 E.00289
G1 X93.338 Y76.311 E.2573
G1 X93.631 Y76.347 E.00581
G1 X93.842 Y76.417 E.00437
G1 X94.04 Y76.524 E.00442
G1 X94.216 Y76.663 E.00442
G1 X94.366 Y76.831 E.00442
G1 X94.484 Y77.022 E.00442
G1 X94.567 Y77.231 E.00442
G1 X94.612 Y77.448 E.00436
G1 X94.621 Y88.791 E.2231
G1 X93.442 Y88.791 E.02321
G1 X93.442 Y77.491 E.22226
G1 X80.816 Y77.491 E.24834
G1 X80.647 Y77.517 E.00336
G1 X80.467 Y77.608 E.00397
G1 X80.335 Y77.743 E.00371
G1 X80.246 Y77.923 E.00395
G1 X80.222 Y78.086 E.00324
G1 X80.222 Y95.116 E.33498
G1 X80.245 Y95.276 E.00319
G1 X80.32 Y95.437 E.00349
G1 X80.438 Y95.57 E.00349
G1 X80.595 Y95.666 E.00361
G1 X80.81 Y95.711 E.00433
G1 X93.024 Y95.711 E.24024
G1 X93.058 Y95.327 E.00757
G1 X93.087 Y95.207 E.00244
G1 X93.147 Y95.058 E.00316
G1 X93.238 Y94.911 E.00339
G1 X93.35 Y94.785 E.00332
G1 X93.538 Y94.644 E.00463
G1 X93.689 Y94.573 E.00327
G1 X94.016 Y94.495 E.00662
G1 X99.909 Y86.078 E.2021
G1 X100.876 Y86.755 E.02321
G1 X94.979 Y95.177 E.20222
G1 X95.016 Y95.401 E.00448
G1 X95.019 Y95.561 E.00315
G1 X94.976 Y95.794 E.00465
G1 X94.88 Y96.009 E.00464
G1 X94.702 Y96.228 E.00554
G1 X94.505 Y96.369 E.00477
G1 X94.301 Y96.459 E.00438
G1 X94.096 Y96.639 E.00538
G1 X93.906 Y96.755 E.00439
G1 X93.698 Y96.837 E.00438
G1 X93.483 Y96.881 E.00433
G1 X89.288 Y96.892 E.0825
; WIPE_START
M204 S6000
G1 X89.835 Y97.59 E-.16852
G1 X90.085 Y97.957 E-.0843
G1 X90.293 Y98.359 E-.0861
G1 X90.37 Y98.562 E-.04109
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




G1 X88.837 Y97.658
G1 Z1.4
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.393779
G1 F1500
M204 S6000
G1 X88.714 Y97.54 E.00312
; LINE_WIDTH: 0.42698
G1 X88.573 Y97.406 E.00391
; LINE_WIDTH: 0.465817
G1 X88.297 Y97.171 E.00795
M204 S10000
G1 X88.837 Y97.658 F18000
; LINE_WIDTH: 0.360065
G1 F1500
M204 S6000
G1 X89.214 Y98.081 E.00944
G1 X89.398 Y98.356 E.00552
G1 X89.583 Y98.709 E.00665
G1 X89.7 Y99.023 E.00559
G1 X89.779 Y99.369 E.00592
G1 X89.828 Y99.89 E.00873
M73 P47 R13
G1 X89.807 Y100.246 E.00596
G1 X89.702 Y100.772 E.00893
G1 X89.579 Y101.103 E.0059
G1 X89.315 Y101.576 E.00904
G1 X89.096 Y101.862 E.00599
G1 X88.758 Y102.194 E.00791
G1 X88.557 Y102.347 E.00421
G1 X88.263 Y102.537 E.00584
G1 X87.932 Y102.689 E.00608
G1 X87.429 Y102.836 E.00874
G1 X86.879 Y102.898 E.00924
G1 X86.388 Y102.866 E.00821
G1 X86.031 Y102.787 E.0061
G1 X85.643 Y102.653 E.00684
G1 X85.192 Y102.412 E.00853
G1 X84.77 Y102.078 E.00897
G1 X84.445 Y101.716 E.00812
G1 X84.251 Y101.42 E.00589
G1 X84.024 Y100.944 E.0088
G1 X83.942 Y100.701 E.00428
G1 X83.87 Y100.357 E.00586
G1 X83.835 Y99.988 E.00619
G1 X83.856 Y99.536 E.00754
G1 X83.92 Y99.186 E.00594
G1 X84.046 Y98.792 E.0069
G1 X84.295 Y98.304 E.00914
G1 X84.624 Y97.872 E.00904
G1 X84.817 Y97.673 E.00463
; LINE_WIDTH: 0.40062
G1 X84.992 Y97.496 E.00464
; LINE_WIDTH: 0.438395
G1 X85.199 Y97.319 E.00561
; LINE_WIDTH: 0.477097
G1 X85.379 Y97.165 E.00533
; WIPE_START
G1 X85.199 Y97.319 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X80.294 Y96.251 Z1.8 F18000
G1 Z1.4
G1 E.4 F1800
; LINE_WIDTH: 0.148594
G1 F1500
M204 S6000
G1 X79.982 Y96.09 E.00216
G1 X79.805 Y95.891 E.00163
G1 X79.76 Y95.814 E.00054
; LINE_WIDTH: 0.103826
G1 X79.693 Y95.617 E.00081
; WIPE_START
G1 X79.76 Y95.814 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X87.39 Y95.996 Z1.8 F18000
G1 X93.61 Y96.144 Z1.8
G1 Z1.4
G1 E.4 F1800
; LINE_WIDTH: 0.109728
G1 F1500
M204 S6000
G1 X93.837 Y96.009 E.0011
; WIPE_START
G1 X93.61 Y96.144 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X89.028 Y90.04 Z1.8 F18000
G1 X79.688 Y77.598 Z1.8
G1 Z1.4
G1 E.4 F1800
; LINE_WIDTH: 0.102133
G1 F1500
M204 S6000
G1 X79.738 Y77.434 E.00065
; LINE_WIDTH: 0.151265
G1 X79.789 Y77.328 E.00074
G1 X79.896 Y77.198 E.00105
G1 X80.071 Y77.052 E.00142
; LINE_WIDTH: 0.11502
G1 X80.296 Y76.965 E.00108
; LINE_WIDTH: 0.0826035
G1 X80.334 Y76.955 E.00011
; CHANGE_LAYER
; Z_HEIGHT: 1.52
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F1500
G1 X80.296 Y76.965 E-.38
; WIPE_END
G1 E-.02 F1800
; layer num/total_layer_count: 12/49
; update layer progress
M73 L12
M991 S0 P11 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z1.8 I-.586 J1.066 P1  F18000
G1 X93.851 Y84.415 Z1.8
G1 Z1.52
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X93.851 Y77.128 E.15423
G1 X94.036 Y77.076 E.00407
G1 X94.117 Y77.207 E.00325
G1 X94.173 Y77.349 E.00324
G1 X94.202 Y77.49 E.00305
G1 X94.212 Y88.382 E.23052
G1 X93.851 Y88.382 E.00764
G1 X93.851 Y84.475 E.08269
; WIPE_START
M204 S6000
G1 X93.851 Y82.475 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X93.874 Y90.107 Z1.92 F18000
G1 X93.89 Y95.436 Z1.92
G1 Z1.52
G1 E.4 F1800
G1 F1500
M204 S500
G1 X93.944 Y95.377 E.0017
G1 X94.16 Y95.319 E.00474
G1 X94.183 Y95.523 E.00434
G1 X94.116 Y95.626 E.00261
G1 X93.861 Y95.745 E.00595
G1 X93.884 Y95.496 E.0053
; WIPE_START
M204 S6000
G1 X93.944 Y95.377 E-.04148
G1 X94.16 Y95.319 E-.06991
G1 X94.183 Y95.523 E-.064
G1 X94.116 Y95.626 E-.03852
G1 X93.861 Y95.745 E-.08783
G1 X93.884 Y95.496 E-.07825
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X87.99 Y97.081 Z1.92 F18000
G1 Z1.52
G1 E.4 F1800
G1 F1500
M204 S500
G1 X87.598 Y96.953 E.00874
G1 X87.225 Y96.88 E.00804
G1 X86.695 Y96.856 E.01123
G1 X86.153 Y96.93 E.01157
G1 X85.597 Y97.11 E.01238
G1 X85.491 Y96.949 E.0041
G1 X85.842 Y96.544 E.01135
G1 X87.754 Y96.544 E.04045
G1 X88.096 Y96.915 E.01069
G1 X88.023 Y97.031 E.00289
; WIPE_START
M204 S6000
G1 X87.598 Y96.953 E-.08204
G1 X87.225 Y96.88 E-.07222
G1 X86.695 Y96.856 E-.1008
G1 X86.153 Y96.93 E-.10383
G1 X86.048 Y96.964 E-.02112
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X88.969 Y101.413 Z1.92 F18000
G1 Z1.52
G1 E.4 F1800
G1 F1500
M204 S500
G1 X88.699 Y101.741 E.00897
G1 X88.348 Y102.039 E.00975
G1 X88.074 Y102.208 E.00681
G1 X87.811 Y102.331 E.00615
G1 X87.341 Y102.473 E.01039
G1 X86.88 Y102.521 E.00981
G1 X86.558 Y102.507 E.00683
G1 X86.239 Y102.454 E.00684
G1 X85.801 Y102.312 E.00975
G1 X85.387 Y102.089 E.00995
G1 X85.02 Y101.796 E.00995
G1 X84.711 Y101.442 E.00995
G1 X84.468 Y101.036 E.01
G1 X84.3 Y100.575 E.01039
G1 X84.24 Y100.29 E.00616
G1 X84.212 Y99.97 E.0068
G1 X84.239 Y99.519 E.00955
G1 X84.305 Y99.205 E.0068
G1 X84.398 Y98.929 E.00615
G1 X84.621 Y98.492 E.01039
G1 X84.912 Y98.115 E.01007
G1 X85.279 Y97.79 E.01039
G1 X85.523 Y97.631 E.00615
G1 X85.81 Y97.487 E.00681
G1 X86.248 Y97.345 E.00975
G1 X86.714 Y97.282 E.00995
G1 X87.174 Y97.302 E.00975
G1 X87.491 Y97.365 E.00683
G1 X87.789 Y97.462 E.00664
G1 X88.072 Y97.593 E.0066
G1 X88.32 Y97.745 E.00616
G1 X88.697 Y98.059 E.01039
G1 X89 Y98.426 E.01007
G1 X89.235 Y98.857 E.01039
G1 X89.336 Y99.13 E.00616
G1 X89.412 Y99.442 E.0068
G1 X89.453 Y99.901 E.00975
G1 X89.411 Y100.372 E.01001
G1 X89.276 Y100.844 E.01039
G1 X89.157 Y101.109 E.00616
G1 X89.004 Y101.365 E.00631
M204 S250
G1 X88.652 Y101.153 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X88.407 Y101.452 E.00761
G1 X88.107 Y101.707 E.00773
G1 X87.879 Y101.847 E.00525
G1 X87.664 Y101.948 E.00467
G1 X87.26 Y102.07 E.00831
G1 X86.868 Y102.111 E.00776
G1 X86.601 Y102.099 E.00526
G1 X86.337 Y102.055 E.00527
G1 X85.963 Y101.934 E.00773
G1 X85.614 Y101.746 E.0078
G1 X85.304 Y101.499 E.0078
G1 X85.043 Y101.2 E.0078
G1 X84.839 Y100.859 E.00781
G1 X84.694 Y100.462 E.00831
G1 X84.646 Y100.23 E.00467
G1 X84.622 Y99.964 E.00525
G1 X84.645 Y99.574 E.00767
G1 X84.701 Y99.313 E.00525
G1 X84.777 Y99.088 E.00467
G1 X84.968 Y98.711 E.00831
G1 X85.212 Y98.396 E.00784
G1 X85.528 Y98.116 E.00831
G1 X85.727 Y97.986 E.00467
G1 X85.966 Y97.867 E.00526
G1 X86.34 Y97.745 E.00773
G1 X86.732 Y97.692 E.0078
G1 X87.125 Y97.71 E.00773
G1 X87.388 Y97.762 E.00526
G1 X87.639 Y97.843 E.0052
G1 X87.879 Y97.954 E.00519
G1 X88.081 Y98.078 E.00467
G1 X88.406 Y98.349 E.00831
G1 X88.659 Y98.656 E.00783
G1 X88.861 Y99.027 E.00831
G1 X88.944 Y99.25 E.00467
G1 X89.007 Y99.509 E.00525
G1 X89.042 Y99.901 E.00773
G1 X89.007 Y100.297 E.00781
G1 X88.891 Y100.703 E.00831
G1 X88.793 Y100.919 E.00467
G1 X88.684 Y101.102 E.00419
; WIPE_START
M204 S6000
G1 X88.407 Y101.452 E-.08485
G1 X88.107 Y101.707 E-.0747
G1 X87.879 Y101.847 E-.05076
G1 X87.664 Y101.948 E-.04511
G1 X87.26 Y102.07 E-.08027
G1 X87.028 Y102.094 E-.0443
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X88.002 Y96.12 Z1.92 F18000
G1 Z1.52
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X93.41 Y96.12 E.11448
G1 X93.457 Y95.43 E.01463
G1 X93.477 Y95.337 E.00203
G1 X93.563 Y95.164 E.00409
G1 X93.667 Y95.053 E.00321
G1 X93.873 Y94.945 E.00494
G1 X94.256 Y94.865 E.00827
G1 X97.353 Y90.442 E.11429
G1 X97.649 Y90.65 E.00765
G1 X94.558 Y95.064 E.11405
G1 X94.61 Y95.52 E.00971
G1 X94.587 Y95.659 E.00299
G1 X94.524 Y95.798 E.00323
G1 X94.41 Y95.936 E.00379
G1 X94.336 Y95.991 E.00195
G1 X94.073 Y96.114 E.00615
G1 X93.852 Y96.308 E.00622
G1 X93.723 Y96.387 E.00321
G1 X93.582 Y96.443 E.00321
G1 X93.441 Y96.472 E.00304
G1 X88.277 Y96.485 E.10931
G1 X89.376 Y97.675 E.03429
G1 X89.632 Y98.008 E.00889
G1 X89.919 Y98.526 E.01254
G1 X90.112 Y99.086 E.01253
G1 X90.205 Y99.68 E.01273
G1 X90.19 Y100.283 E.01276
G1 X90.069 Y100.874 E.01278
G1 X89.928 Y101.256 E.00861
G1 X89.745 Y101.614 E.00852
G1 X89.547 Y101.911 E.00754
G1 X89.267 Y102.245 E.00922
G1 X88.965 Y102.522 E.00869
G1 X88.639 Y102.757 E.00849
G1 X88.112 Y103.029 E.01256
G1 X87.776 Y103.145 E.00753
G1 X87.329 Y103.244 E.00969
G1 X86.932 Y103.279 E.00843
G1 X86.531 Y103.267 E.00849
G1 X85.939 Y103.161 E.01274
G1 X85.375 Y102.951 E.01273
G1 X85.024 Y102.757 E.00849
G1 X84.699 Y102.522 E.00849
G1 X84.403 Y102.251 E.00849
G1 X84.141 Y101.946 E.0085
G1 X83.918 Y101.613 E.00849
G1 X83.663 Y101.077 E.01256
G1 X83.558 Y100.737 E.00753
G1 X83.474 Y100.288 E.00968
G1 X83.452 Y99.89 E.00843
G1 X83.477 Y99.49 E.00849
G1 X83.549 Y99.095 E.00849
M73 P47 R12
G1 X83.741 Y98.533 E.01256
G1 X83.903 Y98.216 E.00753
G1 X84.157 Y97.836 E.00969
G1 X85.335 Y96.482 E.03798
G1 X80.368 Y96.482 E.10513
G1 X80.12 Y96.453 E.00527
G1 X79.975 Y96.405 E.00324
G1 X79.76 Y96.269 E.00539
G1 X79.563 Y96.027 E.00659
G1 X79.48 Y95.814 E.00485
G1 X79.451 Y95.565 E.0053
G1 X79.451 Y77.628 E.37965
G1 X79.487 Y77.357 E.00578
G1 X79.592 Y77.125 E.00539
G1 X79.693 Y76.998 E.00343
G1 X79.814 Y76.89 E.00343
G1 X80.033 Y76.775 E.00524
G1 X80.283 Y76.723 E.00542
G1 X93.315 Y76.721 E.27582
G1 X93.541 Y76.748 E.00482
G1 X93.679 Y76.794 E.00308
G1 X93.856 Y76.889 E.00424
G1 X93.807 Y77.082 E.0042
G1 X80.787 Y77.082 E.27559
G1 X80.528 Y77.119 E.00553
G1 X80.226 Y77.271 E.00717
G1 X80.002 Y77.495 E.00669
G1 X79.85 Y77.798 E.00717
G1 X79.812 Y78.056 E.00553
G1 X79.812 Y95.146 E.36173
G1 X79.849 Y95.395 E.00533
G1 X79.975 Y95.665 E.00629
G1 X80.172 Y95.887 E.0063
G1 X80.441 Y96.053 E.00668
G1 X80.768 Y96.12 E.00707
G1 X87.942 Y96.12 E.15183
; WIPE_START
M204 S6000
G1 X89.942 Y96.12 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X89.209 Y96.892 Z1.92 F18000
G1 Z1.52
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X89.689 Y97.411 E.01389
G1 X89.967 Y97.772 E.00897
G1 X90.085 Y97.957 E.00431
G1 X90.293 Y98.359 E.00891
G1 X90.453 Y98.783 E.00891
G1 X90.511 Y98.994 E.00431
G1 X90.594 Y99.443 E.00897
G1 X90.614 Y99.661 E.0043
G1 X90.615 Y100.117 E.00897
G1 X90.596 Y100.335 E.00431
G1 X90.529 Y100.729 E.00786
G1 X90.46 Y100.996 E.00543
G1 X90.303 Y101.42 E.00889
G1 X90.099 Y101.821 E.00886
G1 X89.879 Y102.152 E.0078
G1 X89.706 Y102.371 E.00549
G1 X89.557 Y102.534 E.00434
G1 X89.224 Y102.84 E.00891
G1 X88.858 Y103.103 E.00885
G1 X88.462 Y103.322 E.00891
G1 X87.886 Y103.539 E.0121
G1 X87.391 Y103.649 E.00998
G1 X86.944 Y103.689 E.00883
G1 X86.494 Y103.676 E.00885
G1 X86.046 Y103.608 E.00891
G1 X85.83 Y103.556 E.00437
G1 X85.618 Y103.491 E.00436
G1 X85.199 Y103.321 E.00891
G1 X84.805 Y103.103 E.00885
G1 X84.44 Y102.84 E.00885
G1 X84.108 Y102.536 E.00885
G1 X83.815 Y102.195 E.00885
G1 X83.564 Y101.821 E.00885
G1 X83.359 Y101.418 E.00891
G1 X83.16 Y100.835 E.0121
G1 X83.067 Y100.337 E.00997
G1 X83.042 Y99.889 E.00883
G1 X83.07 Y99.44 E.00885
G1 X83.151 Y98.997 E.00885
G1 X83.285 Y98.564 E.00891
G1 X83.55 Y98.009 E.0121
G1 X83.831 Y97.587 E.00997
G1 X84.436 Y96.891 E.01814
G1 X80.344 Y96.891 E.08049
G1 X80.031 Y96.854 E.00619
G1 X79.818 Y96.784 E.00442
G1 X79.69 Y96.719 E.00283
G1 X79.501 Y96.587 E.00454
G1 X79.398 Y96.49 E.00277
G1 X79.213 Y96.241 E.00611
G1 X79.142 Y96.096 E.00318
G1 X79.078 Y95.902 E.00402
G1 X79.042 Y95.589 E.0062
G1 X79.042 Y77.61 E.35362
G1 X79.062 Y77.374 E.00466
G1 X79.095 Y77.234 E.00283
G1 X79.181 Y77.019 E.00454
G1 X79.253 Y76.895 E.00283
G1 X79.394 Y76.716 E.00448
G1 X79.564 Y76.565 E.00448
G1 X79.684 Y76.486 E.00283
G1 X79.891 Y76.389 E.00449
G1 X80.092 Y76.334 E.00408
G1 X80.258 Y76.313 E.00329
G1 X93.34 Y76.311 E.25732
G1 X93.631 Y76.347 E.00577
G1 X93.842 Y76.417 E.00437
G1 X94.04 Y76.524 E.00442
G1 X94.216 Y76.663 E.00442
G1 X94.366 Y76.831 E.00442
G1 X94.484 Y77.022 E.00442
G1 X94.567 Y77.231 E.00442
G1 X94.612 Y77.448 E.00436
G1 X94.621 Y88.791 E.2231
G1 X93.442 Y88.791 E.02321
G1 X93.442 Y77.491 E.22226
G1 X80.816 Y77.491 E.24833
G1 X80.653 Y77.515 E.00325
G1 X80.468 Y77.607 E.00406
G1 X80.338 Y77.738 E.00362
G1 X80.246 Y77.922 E.00406
G1 X80.222 Y78.086 E.00325
G1 X80.222 Y95.116 E.33497
G1 X80.245 Y95.276 E.00319
G1 X80.32 Y95.437 E.00349
G1 X80.438 Y95.57 E.00349
G1 X80.594 Y95.666 E.00361
G1 X80.81 Y95.711 E.00433
G1 X93.028 Y95.711 E.24031
G1 X93.051 Y95.374 E.00664
G1 X93.084 Y95.218 E.00313
G1 X93.147 Y95.058 E.0034
G1 X93.236 Y94.914 E.00333
G1 X93.397 Y94.742 E.00463
M73 P48 R12
G1 X93.533 Y94.647 E.00327
G1 X93.749 Y94.553 E.00463
G1 X94.014 Y94.498 E.00532
G1 X99.909 Y86.078 E.20217
G1 X100.876 Y86.755 E.02321
G1 X94.982 Y95.172 E.2021
G1 X95.021 Y95.512 E.00674
G1 X94.977 Y95.79 E.00553
G1 X94.874 Y96.017 E.00491
G1 X94.694 Y96.235 E.00556
G1 X94.547 Y96.344 E.0036
G1 X94.299 Y96.46 E.00539
G1 X94.096 Y96.639 E.00533
G1 X93.906 Y96.755 E.00438
G1 X93.698 Y96.837 E.00438
G1 X93.483 Y96.881 E.00433
G1 X89.269 Y96.892 E.08287
; WIPE_START
M204 S6000
G1 X89.689 Y97.411 E-.12675
G1 X89.967 Y97.772 E-.08669
G1 X90.085 Y97.957 E-.04159
G1 X90.293 Y98.359 E-.0861
G1 X90.365 Y98.551 E-.03888
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




G1 X88.956 Y97.78
G1 Z1.52
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.377841
G1 F1500
M204 S6000
G1 X88.764 Y97.598 E.00463
; LINE_WIDTH: 0.414863
G1 X88.546 Y97.393 E.00582
; LINE_WIDTH: 0.451952
G1 X88.379 Y97.26 E.00453
; LINE_WIDTH: 0.480999
G1 X88.212 Y97.128 E.00484
M204 S10000
G1 X88.956 Y97.78 F18000
; LINE_WIDTH: 0.36064
G1 F1500
M204 S6000
G1 X89.318 Y98.229 E.00965
G1 X89.571 Y98.681 E.00865
G1 X89.7 Y99.023 E.0061
G1 X89.779 Y99.369 E.00593
G1 X89.807 Y99.548 E.00303
G1 X89.822 Y100.081 E.00891
G1 X89.753 Y100.565 E.00816
G1 X89.626 Y100.985 E.00733
G1 X89.487 Y101.292 E.00564
G1 X89.24 Y101.685 E.00776
G1 X88.979 Y101.996 E.00677
G1 X88.559 Y102.35 E.00919
G1 X88.114 Y102.61 E.00861
G1 X87.669 Y102.775 E.00793
G1 X87.27 Y102.865 E.00683
G1 X86.879 Y102.9 E.00656
G1 X86.528 Y102.884 E.00587
G1 X86.138 Y102.818 E.00662
G1 X85.64 Y102.652 E.00877
G1 X85.192 Y102.412 E.00849
G1 X84.77 Y102.078 E.00899
G1 X84.445 Y101.716 E.00814
G1 X84.251 Y101.42 E.0059
G1 X84.024 Y100.944 E.00882
G1 X83.927 Y100.647 E.00522
G1 X83.866 Y100.336 E.00528
G1 X83.835 Y99.988 E.00584
G1 X83.856 Y99.536 E.00756
G1 X83.92 Y99.186 E.00595
G1 X84.045 Y98.794 E.00687
G1 X84.295 Y98.304 E.00919
G1 X84.626 Y97.869 E.00913
G1 X84.833 Y97.659 E.00492
; LINE_WIDTH: 0.406937
G1 X85.018 Y97.472 E.00501
; LINE_WIDTH: 0.44478
G1 X85.212 Y97.306 E.00532
; LINE_WIDTH: 0.478515
G1 X85.379 Y97.165 E.00495
; WIPE_START
G1 X85.212 Y97.306 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X80.294 Y96.251 Z1.92 F18000
G1 Z1.52
G1 E.4 F1800
; LINE_WIDTH: 0.145592
G1 F1500
M204 S6000
G1 X79.99 Y96.09 E.00206
G1 X79.915 Y96.024 E.0006
G1 X79.759 Y95.815 E.00156
; LINE_WIDTH: 0.0992109
G1 X79.693 Y95.617 E.00076
; WIPE_START
G1 X79.759 Y95.815 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X87.389 Y95.995 Z1.92 F18000
G1 X93.621 Y96.143 Z1.92
G1 Z1.52
G1 E.4 F1800
; LINE_WIDTH: 0.0928107
G1 F1500
M204 S6000
G1 X93.818 Y96.025 E.00077
; WIPE_START
G1 X93.621 Y96.143 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X98.239 Y90.065 Z1.92 F18000
G1 X98.934 Y89.15 Z1.92
G1 Z1.52
G1 E.4 F1800
; FEATURE: Top surface
; LINE_WIDTH: 0.42
G1 F1500
M204 S2000
G1 X97.689 Y90.395 E.03461
G1 X97.362 Y90.165
G1 X100.236 Y87.291 E.07996
G1 X100.331 Y86.638
G1 X98.499 Y88.47 E.05096
; WIPE_START
M204 S6000
G1 X99.913 Y87.056 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X100.069 Y86.43 Z1.92 F18000
G1 Z1.52
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.25452
G1 F1500
M204 S6000
G1 X99.901 Y86.63 E.00298
; LINE_WIDTH: 0.214195
G1 X99.733 Y86.83 E.00245
; LINE_WIDTH: 0.173871
G1 X99.565 Y87.03 E.00193
; LINE_WIDTH: 0.133547
G1 X99.397 Y87.23 E.0014
; LINE_WIDTH: 0.0932222
G1 X99.23 Y87.43 E.00088
M204 S10000
G1 X99.505 Y88.331 F18000
; LINE_WIDTH: 0.091899
G1 F1500
M204 S6000
G1 X99.347 Y88.52 E.00081
; LINE_WIDTH: 0.129577
G1 X99.188 Y88.709 E.00128
; LINE_WIDTH: 0.167254
G1 X99.029 Y88.898 E.00174
; LINE_WIDTH: 0.204932
G1 X98.871 Y89.087 E.00221
M204 S10000
G1 X98.562 Y88.533 F18000
; LINE_WIDTH: 0.204944
G1 F1500
M204 S6000
G1 X98.403 Y88.722 E.00221
; LINE_WIDTH: 0.167263
G1 X98.245 Y88.912 E.00174
; LINE_WIDTH: 0.129582
G1 X98.086 Y89.101 E.00128
; LINE_WIDTH: 0.0919005
G1 X97.927 Y89.29 E.00081
M204 S10000
G1 X98.203 Y90.19 F18000
; LINE_WIDTH: 0.0905389
G1 F1500
M204 S6000
G1 X98.048 Y90.376 E.00078
; LINE_WIDTH: 0.125497
G1 X97.892 Y90.561 E.0012
; WIPE_START
G1 X98.048 Y90.376 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X91.964 Y85.766 Z1.92 F18000
G1 X80.336 Y76.955 Z1.92
G1 Z1.52
G1 E.4 F1800
; LINE_WIDTH: 0.0894153
G1 F1500
M204 S6000
G1 X80.229 Y76.991 E.00036
; LINE_WIDTH: 0.128723
G1 X80.022 Y77.084 E.00117
; LINE_WIDTH: 0.152182
G1 X79.794 Y77.32 E.00207
G1 X79.739 Y77.434 E.0008
; LINE_WIDTH: 0.102598
G1 X79.688 Y77.598 E.00066
; CHANGE_LAYER
; Z_HEIGHT: 1.64
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F1500
G1 X79.739 Y77.434 E-.38
; WIPE_END
G1 E-.02 F1800
; layer num/total_layer_count: 13/49
; update layer progress
M73 L13
M991 S0 P12 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z1.92 I-.545 J1.088 P1  F18000
G1 X93.851 Y84.507 Z1.92
G1 Z1.64
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X93.851 Y77.128 E.15617
G1 X94.036 Y77.076 E.00407
G1 X94.117 Y77.207 E.00325
G1 X94.173 Y77.349 E.00324
G1 X94.202 Y77.49 E.00306
G1 X94.212 Y88.382 E.23052
G1 X93.851 Y88.382 E.00764
G1 X93.851 Y84.567 E.08075
; WIPE_START
M204 S6000
G1 X93.851 Y82.567 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X93.871 Y90.199 Z2.04 F18000
G1 X93.884 Y95.441 Z2.04
G1 Z1.64
G1 E.4 F1800
G1 F1500
M204 S500
G1 X93.954 Y95.367 E.00215
G1 X94.16 Y95.318 E.00449
G1 X94.185 Y95.539 E.00472
G1 X94.105 Y95.634 E.00264
G1 X93.858 Y95.743 E.00571
G1 X93.879 Y95.501 E.00515
; WIPE_START
M204 S6000
G1 X93.954 Y95.367 E-.04749
G1 X94.16 Y95.318 E-.06569
G1 X94.185 Y95.539 E-.06913
G1 X94.105 Y95.634 E-.03858
G1 X93.858 Y95.743 E-.08365
G1 X93.879 Y95.501 E-.07546
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X88.06 Y97.104 Z2.04 F18000
G1 Z1.64
G1 E.4 F1800
G1 F1500
M204 S500
G1 X87.598 Y96.953 E.0103
G1 X87.225 Y96.88 E.00804
G1 X86.695 Y96.856 E.01123
G1 X86.153 Y96.93 E.01157
G1 X85.597 Y97.11 E.01238
G1 X85.491 Y96.949 E.0041
G1 X85.842 Y96.544 E.01135
G1 X87.821 Y96.544 E.04188
G1 X88.167 Y96.942 E.01117
G1 X88.094 Y97.054 E.00283
; WIPE_START
M204 S6000
G1 X87.598 Y96.953 E-.09611
G1 X87.225 Y96.88 E-.07221
G1 X86.695 Y96.856 E-.1008
G1 X86.153 Y96.93 E-.10383
G1 X86.118 Y96.941 E-.00706
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X88.969 Y101.413 Z2.04 F18000
G1 Z1.64
G1 E.4 F1800
G1 F1500
M204 S500
G1 X88.699 Y101.741 E.00898
G1 X88.348 Y102.039 E.00975
G1 X88.075 Y102.208 E.0068
G1 X87.814 Y102.33 E.0061
G1 X87.341 Y102.473 E.01044
G1 X86.88 Y102.521 E.00982
G1 X86.559 Y102.507 E.0068
G1 X86.275 Y102.461 E.0061
G1 X85.804 Y102.313 E.01044
G1 X85.387 Y102.089 E.01001
G1 X85.02 Y101.796 E.00995
G1 X84.711 Y101.442 E.00995
G1 X84.474 Y101.046 E.00975
G1 X84.352 Y100.748 E.00683
G1 X84.266 Y100.437 E.00683
G1 X84.211 Y99.979 E.00975
G1 X84.239 Y99.519 E.00975
G1 X84.305 Y99.205 E.0068
G1 X84.397 Y98.932 E.0061
G1 X84.62 Y98.492 E.01044
G1 X84.904 Y98.125 E.00981
G1 X85.137 Y97.902 E.00683
G1 X85.396 Y97.708 E.00683
G1 X85.801 Y97.49 E.00975
G1 X86.248 Y97.345 E.00995
G1 X86.714 Y97.282 E.00995
G1 X87.174 Y97.302 E.00975
G1 X87.491 Y97.365 E.00683
G1 X87.798 Y97.465 E.00683
G1 X88.21 Y97.671 E.00975
G1 X88.578 Y97.947 E.00975
G1 X88.805 Y98.177 E.00683
G1 X89.002 Y98.432 E.00683
G1 X89.227 Y98.835 E.00975
G1 X89.376 Y99.27 E.00975
G1 X89.433 Y99.588 E.00683
G1 X89.453 Y99.91 E.00683
G1 X89.411 Y100.372 E.00981
G1 X89.275 Y100.846 E.01044
G1 X89.157 Y101.109 E.0061
G1 X89.004 Y101.365 E.00631
M204 S250
G1 X88.653 Y101.153 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X88.407 Y101.452 E.00762
G1 X88.107 Y101.707 E.00773
G1 X87.88 Y101.847 E.00525
G1 X87.667 Y101.947 E.00462
G1 X87.26 Y102.07 E.00836
G1 X86.868 Y102.111 E.00776
G1 X86.601 Y102.099 E.00525
G1 X86.369 Y102.062 E.00463
G1 X85.964 Y101.934 E.00836
G1 X85.614 Y101.746 E.00782
G1 X85.304 Y101.499 E.0078
G1 X85.043 Y101.2 E.0078
G1 X84.841 Y100.863 E.00773
G1 X84.74 Y100.615 E.00526
G1 X84.669 Y100.357 E.00526
G1 X84.622 Y99.967 E.00773
G1 X84.645 Y99.574 E.00774
G1 X84.701 Y99.313 E.00525
G1 X84.776 Y99.091 E.00462
G1 X84.968 Y98.712 E.00836
G1 X85.209 Y98.4 E.00775
G1 X85.402 Y98.215 E.00526
G1 X85.616 Y98.054 E.00526
G1 X85.963 Y97.868 E.00773
G1 X86.34 Y97.745 E.0078
G1 X86.732 Y97.692 E.0078
G1 X87.125 Y97.71 E.00773
G1 X87.388 Y97.762 E.00526
G1 X87.642 Y97.844 E.00526
G1 X87.994 Y98.02 E.00773
G1 X88.308 Y98.256 E.00773
G1 X88.496 Y98.447 E.00526
G1 X88.66 Y98.658 E.00526
G1 X88.851 Y99.002 E.00773
G1 X88.978 Y99.374 E.00773
G1 X89.026 Y99.637 E.00526
G1 X89.042 Y99.904 E.00526
G1 X89.007 Y100.297 E.00775
G1 X88.89 Y100.705 E.00836
G1 X88.793 Y100.919 E.00462
G1 X88.684 Y101.102 E.00419
; WIPE_START
M204 S6000
G1 X88.407 Y101.452 E-.08488
G1 X88.107 Y101.707 E-.0747
G1 X87.88 Y101.847 E-.05074
G1 X87.667 Y101.947 E-.04466
G1 X87.26 Y102.07 E-.08073
G1 X87.028 Y102.094 E-.04429
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X88.075 Y96.12 Z2.04 F18000
G1 Z1.64
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X93.399 Y96.12 E.11268
G1 X93.463 Y95.392 E.01548
G1 X93.515 Y95.242 E.00336
G1 X93.563 Y95.164 E.00194
G1 X93.667 Y95.053 E.00321
G1 X93.824 Y94.962 E.00386
G1 X94.262 Y94.857 E.00952
G1 X97.773 Y89.843 E.12956
G1 X98.069 Y90.05 E.00765
G1 X94.558 Y95.064 E.12955
G1 X94.61 Y95.52 E.00971
G1 X94.583 Y95.676 E.00337
G1 X94.466 Y95.883 E.00503
G1 X94.31 Y96.008 E.00422
G1 X94.079 Y96.11 E.00535
G1 X93.852 Y96.308 E.00637
G1 X93.723 Y96.387 E.00321
G1 X93.582 Y96.443 E.00321
G1 X93.441 Y96.472 E.00304
G1 X88.332 Y96.485 E.10814
G1 X89.515 Y97.845 E.03814
G1 X89.627 Y98 E.00406
G1 X89.919 Y98.526 E.01273
G1 X90.06 Y98.901 E.00849
G1 X90.186 Y99.48 E.01254
G1 X90.211 Y99.891 E.00872
G1 X90.161 Y100.484 E.01258
G1 X90.006 Y101.061 E.01266
G1 X89.842 Y101.438 E.00869
G1 X89.639 Y101.783 E.00849
G1 X89.39 Y102.11 E.00869
G1 X88.958 Y102.529 E.01273
G1 X88.516 Y102.829 E.01131
G1 X88.101 Y103.033 E.00978
G1 X87.715 Y103.164 E.00862
G1 X87.132 Y103.267 E.01254
G1 X86.731 Y103.279 E.00849
G1 X86.332 Y103.243 E.00849
G1 X85.939 Y103.161 E.00849
G1 X85.559 Y103.032 E.0085
G1 X85.197 Y102.859 E.00849
G1 X84.858 Y102.644 E.00849
G1 X84.54 Y102.385 E.00869
G1 X84.141 Y101.947 E.01254
G1 X83.918 Y101.613 E.00849
G1 X83.663 Y101.077 E.01257
G1 X83.559 Y100.742 E.00743
G1 X83.474 Y100.287 E.00978
G1 X83.452 Y99.89 E.00842
G1 X83.477 Y99.49 E.00849
G1 X83.549 Y99.095 E.00849
G1 X83.668 Y98.711 E.0085
G1 X83.831 Y98.345 E.00849
G1 X84.149 Y97.845 E.01253
G1 X85.335 Y96.482 E.03825
G1 X80.368 Y96.482 E.10513
G1 X80.039 Y96.43 E.00703
G1 X79.901 Y96.365 E.00324
G1 X79.718 Y96.23 E.00482
G1 X79.568 Y96.037 E.00517
G1 X79.48 Y95.814 E.00507
G1 X79.451 Y95.565 E.00531
G1 X79.451 Y77.628 E.37965
G1 X79.487 Y77.356 E.00581
G1 X79.594 Y77.123 E.00542
G1 X79.694 Y76.997 E.0034
G1 X79.8 Y76.901 E.00302
G1 X80.031 Y76.775 E.00558
G1 X80.281 Y76.723 E.00539
G1 X93.317 Y76.721 E.27592
G1 X93.541 Y76.748 E.00479
G1 X93.68 Y76.794 E.00309
G1 X93.856 Y76.889 E.00424
G1 X93.807 Y77.082 E.0042
G1 X80.787 Y77.082 E.2756
G1 X80.528 Y77.12 E.00553
G1 X80.226 Y77.272 E.00717
G1 X80.002 Y77.495 E.00668
G1 X79.85 Y77.797 E.00717
G1 X79.812 Y78.056 E.00553
G1 X79.812 Y95.176 E.36236
G1 X79.904 Y95.548 E.00811
G1 X80.082 Y95.799 E.0065
M73 P49 R12
G1 X80.276 Y95.962 E.00537
G1 X80.537 Y96.084 E.0061
G1 X80.787 Y96.12 E.00533
G1 X88.015 Y96.12 E.153
; WIPE_START
M204 S6000
G1 X90.015 Y96.12 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X89.228 Y96.892 Z2.04 F18000
G1 Z1.64
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X89.835 Y97.59 E.01819
G1 X90.085 Y97.957 E.00873
G1 X90.293 Y98.359 E.00891
G1 X90.452 Y98.78 E.00885
G1 X90.56 Y99.22 E.00891
G1 X90.593 Y99.437 E.00431
G1 X90.621 Y99.889 E.00892
G1 X90.601 Y100.28 E.00771
G1 X90.564 Y100.559 E.00552
G1 X90.458 Y101.001 E.00895
G1 X90.389 Y101.209 E.0043
G1 X90.207 Y101.624 E.00891
G1 X89.979 Y102.012 E.00885
G1 X89.705 Y102.372 E.00891
G1 X89.557 Y102.534 E.0043
G1 X89.221 Y102.842 E.00898
G1 X88.717 Y103.187 E.01201
G1 X88.258 Y103.412 E.01007
G1 X87.83 Y103.557 E.00889
G1 X87.617 Y103.608 E.0043
G1 X87.169 Y103.676 E.00891
G1 X86.719 Y103.689 E.00885
G1 X86.271 Y103.649 E.00885
G1 X85.831 Y103.556 E.00885
G1 X85.405 Y103.412 E.00885
G1 X84.999 Y103.218 E.00885
G1 X84.618 Y102.977 E.00885
G1 X84.267 Y102.691 E.00891
G1 X84.11 Y102.538 E.00431
G1 X83.815 Y102.195 E.00891
G1 X83.564 Y101.821 E.00885
G1 X83.358 Y101.417 E.00891
G1 X83.162 Y100.84 E.012
G1 X83.067 Y100.337 E.01007
G1 X83.042 Y99.889 E.00883
G1 X83.07 Y99.44 E.00885
G1 X83.151 Y98.997 E.00885
G1 X83.284 Y98.567 E.00885
G1 X83.467 Y98.156 E.00885
G1 X83.7 Y97.767 E.00891
G1 X83.828 Y97.59 E.0043
G1 X84.436 Y96.891 E.01823
G1 X80.344 Y96.891 E.08049
G1 X80.028 Y96.854 E.00625
G1 X79.894 Y96.814 E.00277
G1 X79.69 Y96.719 E.00442
G1 X79.443 Y96.535 E.00605
G1 X79.333 Y96.415 E.00321
G1 X79.214 Y96.244 E.00409
G1 X79.141 Y96.095 E.00328
G1 X79.078 Y95.902 E.00399
G1 X79.042 Y95.589 E.0062
G1 X79.042 Y77.61 E.35362
G1 X79.062 Y77.374 E.00466
G1 X79.096 Y77.233 E.00284
G1 X79.172 Y77.039 E.00411
G1 X79.253 Y76.894 E.00327
G1 X79.394 Y76.716 E.00447
G1 X79.547 Y76.578 E.00405
G1 X79.685 Y76.485 E.00327
G1 X79.891 Y76.389 E.00446
G1 X80.111 Y76.33 E.00448
G1 X80.257 Y76.313 E.00289
G1 X93.342 Y76.312 E.25737
G1 X93.631 Y76.347 E.00574
G1 X93.842 Y76.417 E.00437
G1 X94.04 Y76.524 E.00442
G1 X94.216 Y76.663 E.00442
G1 X94.366 Y76.831 E.00442
G1 X94.484 Y77.022 E.00442
G1 X94.567 Y77.231 E.00442
G1 X94.612 Y77.448 E.00436
G1 X94.621 Y88.791 E.2231
G1 X93.442 Y88.791 E.02321
G1 X93.442 Y77.491 E.22226
G1 X80.816 Y77.491 E.24833
G1 X80.653 Y77.515 E.00325
G1 X80.468 Y77.608 E.00406
G1 X80.338 Y77.737 E.00361
G1 X80.246 Y77.922 E.00407
G1 X80.222 Y78.086 E.00325
G1 X80.222 Y95.126 E.33517
G1 X80.283 Y95.375 E.00503
G1 X80.385 Y95.519 E.00348
G1 X80.498 Y95.614 E.0029
G1 X80.656 Y95.687 E.00343
G1 X80.816 Y95.711 E.00319
G1 X93.024 Y95.711 E.24011
G1 X93.058 Y95.326 E.00759
G1 X93.083 Y95.22 E.00214
G1 X93.147 Y95.058 E.00345
G1 X93.236 Y94.914 E.00332
G1 X93.397 Y94.742 E.00462
G1 X93.536 Y94.645 E.00333
G1 X93.689 Y94.573 E.00332
G1 X94.016 Y94.495 E.00662
G1 X97.672 Y89.273 E.12539
G1 X98.639 Y89.95 E.02321
G1 X94.982 Y95.172 E.12539
G1 X95.021 Y95.512 E.00673
G1 X94.976 Y95.795 E.00565
G1 X94.85 Y96.057 E.00572
G1 X94.654 Y96.27 E.00568
G1 X94.508 Y96.368 E.00345
G1 X94.301 Y96.459 E.00445
G1 X94.096 Y96.639 E.00538
G1 X93.906 Y96.755 E.00438
G1 X93.698 Y96.837 E.00438
G1 X93.483 Y96.881 E.00433
G1 X89.288 Y96.892 E.0825
; WIPE_START
M204 S6000
G1 X89.835 Y97.59 E-.16851
G1 X90.085 Y97.957 E-.0843
G1 X90.293 Y98.359 E-.0861
G1 X90.37 Y98.562 E-.04109
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




G1 X88.825 Y97.645
G1 Z1.64
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.397741
G1 F1500
M204 S6000
G1 X88.703 Y97.532 E.00308
; LINE_WIDTH: 0.432815
G1 X88.581 Y97.419 E.00337
; LINE_WIDTH: 0.468109
G1 X88.458 Y97.304 E.00371
; LINE_WIDTH: 0.468427
G1 X88.297 Y97.34 E.00365
; LINE_WIDTH: 0.433497
G1 X88.135 Y97.375 E.00336
M204 S10000
G1 X88.825 Y97.645 F18000
; LINE_WIDTH: 0.360531
G1 F1500
M204 S6000
G1 X89.213 Y98.081 E.00975
G1 X89.399 Y98.355 E.00553
G1 X89.573 Y98.68 E.00615
G1 X89.743 Y99.188 E.00894
G1 X89.804 Y99.534 E.00587
G1 X89.83 Y99.928 E.0066
G1 X89.786 Y100.426 E.00835
G1 X89.635 Y100.965 E.00936
G1 X89.497 Y101.276 E.00567
G1 X89.293 Y101.612 E.00657
G1 X88.979 Y101.995 E.00828
G1 X88.56 Y102.352 E.00919
G1 X88.262 Y102.534 E.00583
G1 X87.956 Y102.682 E.00567
G1 X87.614 Y102.792 E.00602
G1 X87.096 Y102.884 E.00878
G1 X86.743 Y102.897 E.00591
G1 X86.511 Y102.881 E.00387
G1 X86.2 Y102.831 E.00527
G1 X85.702 Y102.679 E.00868
G1 X85.383 Y102.522 E.00594
G1 X85.081 Y102.334 E.00594
G1 X84.77 Y102.079 E.00673
G1 X84.414 Y101.676 E.00898
G1 X84.143 Y101.226 E.00877
G1 X84.001 Y100.878 E.00628
G1 X83.895 Y100.497 E.00659
G1 X83.834 Y99.976 E.00877
G1 X83.863 Y99.481 E.00828
G1 X83.939 Y99.115 E.00625
G1 X84.053 Y98.775 E.00599
G1 X84.31 Y98.278 E.00935
G1 X84.616 Y97.882 E.00835
G1 X84.875 Y97.609 E.00629
; LINE_WIDTH: 0.40748
G1 X85.02 Y97.473 E.00378
; LINE_WIDTH: 0.447009
G1 X85.149 Y97.353 E.00371
; LINE_WIDTH: 0.479792
G1 X85.38 Y97.167 E.00673
; WIPE_START
G1 X85.149 Y97.353 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X80.315 Y96.239 Z2.04 F18000
G1 Z1.64
G1 E.4 F1800
; LINE_WIDTH: 0.102469
G1 F1500
M204 S6000
G1 X80.128 Y96.181 E.00075
; LINE_WIDTH: 0.150606
G1 X79.911 Y96.023 E.00168
G1 X79.685 Y95.708 E.00241
; WIPE_START
G1 X79.911 Y96.023 E-.22428
G1 X80.128 Y96.181 E-.15572
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X87.761 Y96.16 Z2.04 F18000
G1 X93.61 Y96.144 Z2.04
G1 Z1.64
G1 E.4 F1800
; LINE_WIDTH: 0.109708
G1 F1500
M204 S6000
G1 X93.837 Y96.009 E.0011
; WIPE_START
G1 X93.61 Y96.144 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X89.028 Y90.04 Z2.04 F18000
G1 X79.688 Y77.598 Z2.04
G1 Z1.64
G1 E.4 F1800
; LINE_WIDTH: 0.0972964
G1 F1500
M204 S6000
G1 X79.721 Y77.483 E.00043
; LINE_WIDTH: 0.125102
G1 X79.779 Y77.344 E.00074
; LINE_WIDTH: 0.157113
G1 X79.902 Y77.192 E.00128
G1 X80.025 Y77.082 E.00108
; LINE_WIDTH: 0.128285
G1 X80.228 Y76.991 E.00114
; LINE_WIDTH: 0.0894177
G1 X80.336 Y76.955 E.00036
; WIPE_START
G1 X80.228 Y76.991 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X87.086 Y80.341 Z2.04 F18000
G1 X99.634 Y86.471 Z2.04
G1 Z1.64
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X99.909 Y86.078 E.00944
G1 X100.082 Y86.199 E.00416
G1 X100.876 Y86.755 E.01905
G1 X100.601 Y87.148 E.00944
G1 X99.683 Y86.506 E.02203
M204 S10000
G1 X99.939 Y86.392 F18000
; FEATURE: Gap infill
; LINE_WIDTH: 0.0965169
G1 F1500
M204 S6000
G1 X100.571 Y86.834 E.00272
; CHANGE_LAYER
; Z_HEIGHT: 1.76
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F1500
G1 X99.939 Y86.392 E-.38
; WIPE_END
G1 E-.02 F1800
; layer num/total_layer_count: 14/49
; update layer progress
M73 L14
M991 S0 P13 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z2.04 I.363 J-1.162 P1  F18000
G1 X93.851 Y84.491 Z2.04
G1 Z1.76
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X93.851 Y77.128 E.15584
G1 X94.036 Y77.076 E.00407
G1 X94.117 Y77.207 E.00325
G1 X94.173 Y77.349 E.00324
G1 X94.202 Y77.49 E.00305
G1 X94.212 Y88.382 E.23053
G1 X93.851 Y88.382 E.00764
G1 X93.851 Y84.551 E.08107
; WIPE_START
M204 S6000
G1 X93.851 Y82.551 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X93.871 Y90.184 Z2.16 F18000
G1 X93.884 Y95.46 Z2.16
G1 Z1.76
G1 E.4 F1800
G1 F1500
M204 S500
G1 X93.954 Y95.367 E.00246
G1 X94.158 Y95.318 E.00443
G1 X94.184 Y95.479 E.00346
G1 X94.185 Y95.526 E.00098
G1 X94.105 Y95.635 E.00285
G1 X93.861 Y95.742 E.00564
G1 X93.879 Y95.52 E.00471
; WIPE_START
M204 S6000
G1 X93.954 Y95.367 E-.0533
G1 X94.158 Y95.318 E-.06562
G1 X94.184 Y95.479 E-.05117
G1 X94.185 Y95.526 E-.01454
G1 X94.105 Y95.635 E-.04223
G1 X93.861 Y95.742 E-.08343
G1 X93.879 Y95.52 E-.06972
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X88.049 Y97.1 Z2.16 F18000
G1 Z1.76
G1 E.4 F1800
G1 F1500
M204 S500
G1 X87.598 Y96.954 E.01005
G1 X87.225 Y96.88 E.00805
G1 X86.695 Y96.856 E.01123
G1 X86.153 Y96.93 E.01157
G1 X85.666 Y97.088 E.01084
G1 X85.56 Y96.922 E.00416
G1 X85.909 Y96.544 E.01089
G1 X87.81 Y96.544 E.04023
G1 X88.156 Y96.938 E.01109
G1 X88.082 Y97.05 E.00284
; WIPE_START
M204 S6000
G1 X87.598 Y96.954 E-.09387
G1 X87.225 Y96.88 E-.07222
G1 X86.695 Y96.856 E-.10081
G1 X86.153 Y96.93 E-.10385
G1 X86.107 Y96.945 E-.00925
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X88.969 Y101.413 Z2.16 F18000
G1 Z1.76
G1 E.4 F1800
G1 F1500
M204 S500
G1 X88.699 Y101.741 E.00898
G1 X88.341 Y102.045 E.00995
G1 X87.931 Y102.281 E.01001
G1 X87.462 Y102.444 E.0105
G1 X87.182 Y102.498 E.00605
G1 X86.871 Y102.521 E.0066
M73 P50 R12
G1 X86.559 Y102.507 E.0066
G1 X86.277 Y102.462 E.00605
G1 X85.804 Y102.313 E.0105
G1 X85.387 Y102.089 E.01002
G1 X85.02 Y101.796 E.00995
G1 X84.711 Y101.442 E.00995
G1 X84.474 Y101.046 E.00975
G1 X84.352 Y100.748 E.00683
G1 X84.266 Y100.437 E.00683
G1 X84.211 Y99.979 E.00975
G1 X84.239 Y99.519 E.00975
G1 X84.305 Y99.205 E.0068
G1 X84.396 Y98.934 E.00605
G1 X84.62 Y98.492 E.01049
G1 X84.91 Y98.118 E.01002
G1 X85.252 Y97.809 E.00975
G1 X85.522 Y97.632 E.00683
G1 X85.81 Y97.487 E.00683
G1 X86.248 Y97.345 E.00975
G1 X86.714 Y97.282 E.00995
G1 X87.174 Y97.302 E.00975
G1 X87.491 Y97.365 E.00683
G1 X87.798 Y97.465 E.00683
G1 X88.21 Y97.671 E.00975
G1 X88.578 Y97.947 E.00975
G1 X88.805 Y98.177 E.00683
G1 X89.002 Y98.432 E.00683
G1 X89.222 Y98.826 E.00955
G1 X89.336 Y99.129 E.00683
G1 X89.412 Y99.442 E.00683
G1 X89.453 Y99.901 E.00975
G1 X89.411 Y100.372 E.01002
G1 X89.274 Y100.849 E.0105
G1 X89.157 Y101.109 E.00604
G1 X89.004 Y101.365 E.0063
M204 S250
G1 X88.653 Y101.153 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X88.407 Y101.452 E.00762
G1 X88.104 Y101.709 E.0078
G1 X87.76 Y101.907 E.00781
G1 X87.356 Y102.047 E.00841
G1 X87.128 Y102.091 E.00458
G1 X86.865 Y102.111 E.00519
G1 X86.601 Y102.099 E.00519
G1 X86.372 Y102.062 E.00458
G1 X85.964 Y101.934 E.00841
G1 X85.614 Y101.746 E.00782
G1 X85.304 Y101.499 E.0078
G1 X85.043 Y101.2 E.0078
G1 X84.841 Y100.863 E.00774
G1 X84.74 Y100.615 E.00526
G1 X84.669 Y100.357 E.00526
G1 X84.622 Y99.967 E.00773
G1 X84.645 Y99.574 E.00774
G1 X84.701 Y99.313 E.00525
G1 X84.775 Y99.093 E.00457
G1 X84.968 Y98.712 E.00841
G1 X85.211 Y98.397 E.00782
G1 X85.503 Y98.134 E.00774
G1 X85.726 Y97.987 E.00526
G1 X85.966 Y97.867 E.00526
G1 X86.34 Y97.746 E.00773
G1 X86.732 Y97.692 E.0078
G1 X87.125 Y97.71 E.00773
G1 X87.388 Y97.762 E.00526
G1 X87.642 Y97.844 E.00526
G1 X87.994 Y98.02 E.00774
G1 X88.308 Y98.256 E.00773
G1 X88.496 Y98.447 E.00526
G1 X88.66 Y98.658 E.00526
G1 X88.85 Y98.999 E.00767
G1 X88.944 Y99.249 E.00526
G1 X89.007 Y99.509 E.00526
G1 X89.042 Y99.901 E.00773
G1 X89.007 Y100.297 E.00782
G1 X88.889 Y100.708 E.00841
G1 X88.793 Y100.92 E.00457
G1 X88.684 Y101.102 E.00418
; WIPE_START
M204 S6000
G1 X88.407 Y101.452 E-.08491
G1 X88.104 Y101.709 E-.07532
G1 X87.76 Y101.907 E-.07549
G1 X87.356 Y102.047 E-.08122
G1 X87.128 Y102.091 E-.0442
G1 X87.029 Y102.099 E-.01886
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X88.063 Y96.12 Z2.16 F18000
G1 Z1.76
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X93.41 Y96.12 E.11316
G1 X93.457 Y95.428 E.01468
G1 X93.515 Y95.242 E.00413
G1 X93.563 Y95.164 E.00194
G1 X93.667 Y95.053 E.00321
G1 X93.824 Y94.962 E.00386
G1 X94.262 Y94.857 E.00952
G1 X97.773 Y89.843 E.12956
G1 X98.069 Y90.05 E.00765
G1 X94.549 Y95.078 E.12991
G1 X94.607 Y95.442 E.0078
G1 X94.6 Y95.612 E.0036
G1 X94.504 Y95.828 E.00501
G1 X94.382 Y95.96 E.00381
G1 X94.31 Y96.008 E.00182
G1 X94.079 Y96.109 E.00536
G1 X93.852 Y96.308 E.00638
G1 X93.723 Y96.387 E.00321
G1 X93.581 Y96.443 E.00321
G1 X93.441 Y96.472 E.00304
G1 X88.323 Y96.485 E.10833
G1 X89.476 Y97.797 E.03696
G1 X89.624 Y97.996 E.00525
G1 X89.832 Y98.345 E.0086
G1 X89.999 Y98.72 E.00869
G1 X90.156 Y99.291 E.01254
G1 X90.212 Y99.881 E.01254
G1 X90.189 Y100.292 E.00872
G1 X90.068 Y100.875 E.01259
G1 X89.928 Y101.256 E.0086
G1 X89.741 Y101.621 E.00869
G1 X89.39 Y102.11 E.01273
G1 X88.958 Y102.529 E.01273
G1 X88.52 Y102.827 E.01122
G1 X88.101 Y103.033 E.00988
G1 X87.716 Y103.164 E.00861
G1 X87.132 Y103.267 E.01254
G1 X86.731 Y103.279 E.00849
G1 X86.332 Y103.243 E.00849
G1 X85.939 Y103.161 E.00849
G1 X85.562 Y103.033 E.00842
G1 X85.143 Y102.827 E.00988
G1 X84.851 Y102.64 E.00734
G1 X84.403 Y102.251 E.01257
G1 X84.141 Y101.947 E.00849
G1 X83.918 Y101.613 E.00849
G1 X83.663 Y101.077 E.01257
G1 X83.561 Y100.746 E.00734
G1 X83.474 Y100.287 E.00988
G1 X83.452 Y99.89 E.00842
G1 X83.477 Y99.49 E.00849
G1 X83.549 Y99.095 E.00849
G1 X83.668 Y98.711 E.0085
G1 X83.831 Y98.345 E.00849
G1 X84.037 Y98 E.00849
G1 X84.287 Y97.675 E.00869
G1 X85.39 Y96.482 E.03439
G1 X80.368 Y96.482 E.1063
G1 X80.129 Y96.454 E.00508
G1 X79.93 Y96.381 E.0045
G1 X79.799 Y96.301 E.00324
G1 X79.664 Y96.173 E.00394
G1 X79.571 Y96.04 E.00343
G1 X79.481 Y95.821 E.00501
G1 X79.451 Y95.565 E.00546
G1 X79.451 Y77.628 E.37965
G1 X79.487 Y77.357 E.00578
G1 X79.596 Y77.118 E.00558
G1 X79.773 Y76.922 E.00559
G1 X79.984 Y76.794 E.00521
G1 X80.129 Y76.746 E.00324
G1 X80.29 Y76.723 E.00344
G1 X93.318 Y76.721 E.27576
G1 X93.541 Y76.748 E.00475
G1 X93.679 Y76.794 E.00309
G1 X93.856 Y76.889 E.00424
G1 X93.807 Y77.082 E.0042
G1 X80.784 Y77.082 E.27566
G1 X80.517 Y77.123 E.00571
G1 X80.216 Y77.277 E.00717
G1 X79.978 Y77.529 E.00731
G1 X79.849 Y77.807 E.00649
G1 X79.812 Y78.056 E.00533
G1 X79.812 Y95.173 E.3623
G1 X79.897 Y95.53 E.00775
G1 X80.053 Y95.766 E.006
G1 X80.268 Y95.958 E.0061
G1 X80.537 Y96.084 E.00629
G1 X80.786 Y96.12 E.00533
G1 X88.003 Y96.12 E.15275
; WIPE_START
M204 S6000
G1 X90.003 Y96.12 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X89.225 Y96.892 Z2.16 F18000
G1 Z1.76
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X89.794 Y97.539 E.01695
G1 X89.964 Y97.768 E.00561
G1 X90.196 Y98.156 E.00888
G1 X90.38 Y98.57 E.00891
G1 X90.451 Y98.777 E.00431
G1 X90.559 Y99.217 E.00891
G1 X90.614 Y99.667 E.00891
G1 X90.621 Y99.886 E.0043
G1 X90.596 Y100.338 E.00892
G1 X90.53 Y100.72 E.00762
G1 X90.46 Y100.996 E.00561
G1 X90.303 Y101.42 E.00888
G1 X90.097 Y101.824 E.00891
G1 X89.981 Y102.009 E.0043
G1 X89.705 Y102.372 E.00898
G1 X89.557 Y102.534 E.0043
G1 X89.221 Y102.842 E.00897
G1 X89.047 Y102.976 E.00432
G1 X88.721 Y103.184 E.00761
G1 X88.257 Y103.412 E.01016
G1 X87.83 Y103.557 E.00889
G1 X87.617 Y103.609 E.00431
G1 X87.169 Y103.676 E.00891
G1 X86.719 Y103.689 E.00885
G1 X86.271 Y103.649 E.00885
G1 X85.831 Y103.556 E.00885
G1 X85.406 Y103.412 E.00883
G1 X84.942 Y103.184 E.01016
G1 X84.442 Y102.842 E.01191
G1 X84.108 Y102.536 E.00891
G1 X83.815 Y102.195 E.00885
G1 X83.564 Y101.821 E.00885
G1 X83.359 Y101.418 E.00891
G1 X83.163 Y100.844 E.01192
G1 X83.067 Y100.337 E.01016
G1 X83.042 Y99.889 E.00883
G1 X83.07 Y99.44 E.00885
G1 X83.151 Y98.997 E.00885
G1 X83.284 Y98.567 E.00885
G1 X83.467 Y98.156 E.00885
G1 X83.698 Y97.77 E.00885
G1 X83.974 Y97.411 E.00891
G1 X84.455 Y96.891 E.01393
G1 X80.344 Y96.891 E.08086
G1 X80.034 Y96.855 E.00613
G1 X79.75 Y96.751 E.00594
G1 X79.559 Y96.633 E.00442
G1 X79.447 Y96.539 E.00289
G1 X79.346 Y96.432 E.00289
G1 X79.215 Y96.246 E.00448
G1 X79.119 Y96.039 E.00448
G1 X79.079 Y95.904 E.00277
G1 X79.042 Y95.589 E.00625
G1 X79.042 Y77.61 E.35362
G1 X79.062 Y77.374 E.00467
G1 X79.095 Y77.234 E.00283
G1 X79.181 Y77.019 E.00454
G1 X79.254 Y76.892 E.00288
G1 X79.342 Y76.774 E.0029
G1 X79.505 Y76.611 E.00454
G1 X79.62 Y76.525 E.00283
G1 X79.821 Y76.417 E.00448
G1 X80.034 Y76.346 E.00442
G1 X80.26 Y76.313 E.00448
G1 X93.343 Y76.312 E.25734
G1 X93.631 Y76.347 E.00571
G1 X93.842 Y76.417 E.00437
G1 X94.04 Y76.524 E.00442
G1 X94.216 Y76.663 E.00442
G1 X94.366 Y76.831 E.00442
G1 X94.484 Y77.022 E.00442
G1 X94.567 Y77.231 E.00442
G1 X94.612 Y77.448 E.00436
G1 X94.621 Y88.791 E.2231
G1 X93.442 Y88.791 E.02321
G1 X93.442 Y77.491 E.22226
G1 X80.815 Y77.491 E.24835
G1 X80.645 Y77.517 E.00339
G1 X80.465 Y77.61 E.00398
G1 X80.321 Y77.762 E.00411
G1 X80.245 Y77.925 E.00355
G1 X80.222 Y78.086 E.00319
G1 X80.222 Y95.125 E.33516
G1 X80.278 Y95.365 E.00484
G1 X80.365 Y95.497 E.0031
G1 X80.495 Y95.612 E.00343
G1 X80.656 Y95.687 E.00349
G1 X80.816 Y95.711 E.00319
G1 X93.028 Y95.711 E.24019
G1 X93.051 Y95.371 E.00669
G1 X93.084 Y95.218 E.00308
G1 X93.147 Y95.058 E.0034
G1 X93.236 Y94.914 E.00333
G1 X93.397 Y94.742 E.00463
G1 X93.535 Y94.645 E.00332
G1 X93.689 Y94.573 E.00333
G1 X94.016 Y94.495 E.00662
G1 X97.672 Y89.273 E.12539
G1 X98.639 Y89.95 E.02321
G1 X94.979 Y95.176 E.1255
G1 X95.016 Y95.405 E.00456
G1 X95.019 Y95.566 E.00317
G1 X94.959 Y95.845 E.0056
G1 X94.84 Y96.068 E.00497
G1 X94.649 Y96.273 E.00553
G1 X94.508 Y96.368 E.00333
G1 X94.301 Y96.459 E.00445
G1 X94.096 Y96.639 E.00538
G1 X93.906 Y96.755 E.00438
G1 X93.698 Y96.837 E.00438
G1 X93.483 Y96.881 E.00433
G1 X89.285 Y96.892 E.08256
; WIPE_START
M204 S6000
G1 X89.794 Y97.539 E-.15644
G1 X89.964 Y97.768 E-.05424
G1 X90.196 Y98.156 E-.08581
G1 X90.375 Y98.558 E-.08351
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




G1 X88.824 Y97.645
G1 Z1.76
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.360165
G1 F1500
M204 S6000
G1 X89.096 Y97.936 E.00663
G1 X89.312 Y98.213 E.00586
G1 X89.559 Y98.657 E.00848
G1 X89.696 Y99.028 E.0066
G1 X89.783 Y99.368 E.00586
G1 X89.832 Y99.886 E.00868
G1 X89.784 Y100.426 E.00905
G1 X89.7 Y100.76 E.00574
G1 X89.579 Y101.101 E.00604
G1 X89.308 Y101.592 E.00937
G1 X88.995 Y101.978 E.00829
G1 X88.589 Y102.332 E.00898
G1 X88.332 Y102.493 E.00507
G1 X87.957 Y102.677 E.00698
G1 X87.548 Y102.81 E.00716
G1 X87.222 Y102.873 E.00554
G1 X86.743 Y102.897 E.00801
G1 X86.388 Y102.866 E.00594
G1 X86.041 Y102.79 E.00593
G1 X85.672 Y102.667 E.00648
G1 X85.331 Y102.493 E.00638
G1 X85.075 Y102.33 E.00507
G1 X84.676 Y101.983 E.00882
G1 X84.397 Y101.651 E.00724
G1 X84.143 Y101.226 E.00827
G1 X83.994 Y100.86 E.00659
G1 X83.896 Y100.497 E.00626
G1 X83.834 Y99.976 E.00876
G1 X83.863 Y99.481 E.00827
G1 X83.939 Y99.115 E.00624
G1 X84.052 Y98.778 E.00594
G1 X84.31 Y98.278 E.00938
; LINE_WIDTH: 0.371703
G1 X84.622 Y97.871 E.00885
G1 X84.995 Y97.5 E.00908
; LINE_WIDTH: 0.406698
G1 X85.017 Y97.481 E.00054
; LINE_WIDTH: 0.449136
G1 X85.26 Y97.274 E.00676
G1 X85.284 Y97.279 E.00051
; LINE_WIDTH: 0.434891
G1 X85.307 Y97.284 E.00049
; LINE_WIDTH: 0.396613
G1 X85.583 Y97.351 E.00525
; WIPE_START
G1 X85.307 Y97.284 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X88.123 Y97.375 Z2.16 F18000
M73 P51 R12
G1 Z1.76
G1 E.4 F1800
; LINE_WIDTH: 0.462745
G1 F1500
M204 S6000
G1 X88.449 Y97.298 E.00729
G1 X88.581 Y97.42 E.00392
; LINE_WIDTH: 0.430762
G1 X88.703 Y97.532 E.00336
; LINE_WIDTH: 0.396523
G1 X88.824 Y97.645 E.00307
; WIPE_START
G1 X88.703 Y97.532 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X93.621 Y96.138 Z2.16 F18000
G1 Z1.76
G1 E.4 F1800
; LINE_WIDTH: 0.108778
G1 F1500
M204 S6000
G1 X93.837 Y96.009 E.00104
; WIPE_START
G1 X93.621 Y96.138 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X85.989 Y96.196 Z2.16 F18000
G1 X80.315 Y96.239 Z2.16
G1 Z1.76
G1 E.4 F1800
; LINE_WIDTH: 0.103833
G1 F1500
M204 S6000
G1 X80.118 Y96.173 E.00081
; LINE_WIDTH: 0.150936
G1 X79.924 Y96.033 E.00149
G1 X79.849 Y95.953 E.00069
G1 X79.676 Y95.659 E.00213
; WIPE_START
G1 X79.849 Y95.953 E-.18796
G1 X79.924 Y96.033 E-.06043
G1 X80.118 Y96.173 E-.1316
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X79.942 Y88.542 Z2.16 F18000
G1 X79.689 Y77.595 Z2.16
G1 Z1.76
G1 E.4 F1800
; LINE_WIDTH: 0.105147
G1 F1500
M204 S6000
G1 X79.756 Y77.387 E.00086
; LINE_WIDTH: 0.158719
G1 X79.956 Y77.139 E.00212
; LINE_WIDTH: 0.139883
G1 X80.062 Y77.057 E.00076
G1 X80.189 Y77 E.00079
; LINE_WIDTH: 0.0984411
G1 X80.334 Y76.955 E.00055
; WIPE_START
G1 X80.189 Y77 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X87.05 Y80.342 Z2.16 F18000
G1 X99.634 Y86.471 Z2.16
G1 Z1.76
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X99.909 Y86.078 E.00944
G1 X100.109 Y86.218 E.00479
G1 X100.876 Y86.755 E.01842
G1 X100.601 Y87.148 E.00944
G1 X99.683 Y86.506 E.02203
M204 S10000
G1 X99.939 Y86.392 F18000
; FEATURE: Gap infill
; LINE_WIDTH: 0.0965102
G1 F1500
M204 S6000
G1 X100.571 Y86.834 E.00272
; CHANGE_LAYER
; Z_HEIGHT: 1.88
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F1500
G1 X99.939 Y86.392 E-.38
; WIPE_END
G1 E-.02 F1800
; layer num/total_layer_count: 15/49
; update layer progress
M73 L15
M991 S0 P14 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z2.16 I.376 J-1.157 P1  F18000
G1 X93.851 Y84.415 Z2.16
G1 Z1.88
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X93.851 Y77.128 E.15423
G1 X94.036 Y77.076 E.00407
G1 X94.117 Y77.207 E.00325
G1 X94.173 Y77.349 E.00324
G1 X94.202 Y77.49 E.00306
G1 X94.213 Y85.92 E.17842
G1 X94.649 Y85.92 E.00923
G1 F1920
G1 X94.669 Y85.92 E.00043
G1 F2357.113
G1 X94.669 Y87.282 E.02882
G1 F1920
G1 X94.649 Y87.282 E.00043
G1 F1500
G1 X94.212 Y87.282 E.00924
G1 X94.212 Y88.382 E.02328
G1 X93.851 Y88.382 E.00765
G1 X93.851 Y84.475 E.08269
; WIPE_START
M204 S6000
G1 X93.851 Y82.475 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X93.871 Y90.107 Z2.28 F18000
G1 X93.885 Y95.457 Z2.28
G1 Z1.88
G1 E.4 F1800
G1 F1500
M204 S500
G1 X93.904 Y95.411 E.00105
G1 X93.967 Y95.364 E.00168
G1 X94.159 Y95.318 E.00417
G1 X94.188 Y95.52 E.00432
G1 X94.105 Y95.634 E.00299
G1 X93.863 Y95.741 E.0056
G1 X93.881 Y95.517 E.00475
; WIPE_START
M204 S6000
G1 X93.904 Y95.411 E-.03378
G1 X93.967 Y95.364 E-.02474
G1 X94.159 Y95.318 E-.06143
G1 X94.188 Y95.52 E-.06357
G1 X94.105 Y95.634 E-.04407
G1 X93.863 Y95.741 E-.08242
G1 X93.881 Y95.517 E-.06999
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X87.99 Y97.081 Z2.28 F18000
G1 Z1.88
G1 E.4 F1800
G1 F1500
M204 S500
G1 X87.598 Y96.953 E.00873
G1 X87.225 Y96.88 E.00804
G1 X86.695 Y96.856 E.01123
G1 X86.153 Y96.93 E.01157
G1 X85.597 Y97.11 E.01237
G1 X85.491 Y96.949 E.0041
G1 X85.842 Y96.544 E.01135
G1 X87.754 Y96.544 E.04045
G1 X88.096 Y96.915 E.01069
G1 X88.023 Y97.03 E.00289
; WIPE_START
M204 S6000
G1 X87.598 Y96.953 E-.08204
G1 X87.225 Y96.88 E-.07221
G1 X86.695 Y96.856 E-.10081
G1 X86.153 Y96.93 E-.10385
G1 X86.048 Y96.964 E-.0211
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X88.969 Y101.413 Z2.28 F18000
G1 Z1.88
G1 E.4 F1800
G1 F1500
M204 S500
G1 X88.699 Y101.741 E.00899
G1 X88.341 Y102.045 E.00995
G1 X87.934 Y102.28 E.00995
G1 X87.5 Y102.435 E.00976
G1 X87.183 Y102.498 E.00683
G1 X86.871 Y102.521 E.00663
G1 X86.56 Y102.507 E.00659
G1 X86.28 Y102.462 E.00599
G1 X85.804 Y102.313 E.01055
G1 X85.387 Y102.089 E.01002
G1 X85.02 Y101.796 E.00995
G1 X84.711 Y101.442 E.00995
G1 X84.468 Y101.036 E.01002
G1 X84.298 Y100.567 E.01055
G1 X84.24 Y100.29 E.00599
G1 X84.212 Y99.97 E.0068
G1 X84.239 Y99.519 E.00955
G1 X84.305 Y99.205 E.00679
G1 X84.395 Y98.937 E.00599
G1 X84.62 Y98.492 E.01055
G1 X84.91 Y98.118 E.01002
G1 X85.252 Y97.809 E.00975
G1 X85.521 Y97.632 E.00683
G1 X85.81 Y97.487 E.00683
G1 X86.248 Y97.345 E.00975
G1 X86.714 Y97.282 E.00995
G1 X87.174 Y97.302 E.00975
G1 X87.491 Y97.365 E.00683
G1 X87.789 Y97.462 E.00663
G1 X88.073 Y97.593 E.00663
G1 X88.348 Y97.763 E.00683
G1 X88.692 Y98.055 E.00956
G1 X88.903 Y98.297 E.00679
G1 X89.064 Y98.53 E.00599
G1 X89.285 Y98.976 E.01055
G1 X89.411 Y99.433 E.01002
G1 X89.454 Y99.904 E.01002
G1 X89.404 Y100.4 E.01055
G1 X89.335 Y100.675 E.00599
G1 X89.222 Y100.975 E.0068
G1 X89.005 Y101.365 E.00944
M204 S250
G1 X88.653 Y101.153 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X88.407 Y101.452 E.00763
G1 X88.104 Y101.709 E.0078
G1 X87.761 Y101.907 E.00779
G1 X87.391 Y102.04 E.00774
G1 X87.128 Y102.091 E.00526
G1 X86.865 Y102.111 E.0052
G1 X86.601 Y102.099 E.00519
G1 X86.374 Y102.063 E.00453
G1 X85.964 Y101.934 E.00845
G1 X85.614 Y101.746 E.00782
G1 X85.304 Y101.499 E.0078
G1 X85.043 Y101.2 E.0078
G1 X84.839 Y100.859 E.00782
G1 X84.693 Y100.455 E.00846
G1 X84.646 Y100.23 E.00452
G1 X84.622 Y99.964 E.00525
G1 X84.645 Y99.574 E.00767
G1 X84.701 Y99.313 E.00525
G1 X84.774 Y99.095 E.00453
G1 X84.968 Y98.712 E.00846
G1 X85.211 Y98.397 E.00782
G1 X85.503 Y98.134 E.00774
G1 X85.726 Y97.987 E.00526
G1 X85.966 Y97.867 E.00526
G1 X86.34 Y97.746 E.00773
G1 X86.732 Y97.692 E.0078
G1 X87.125 Y97.71 E.00773
G1 X87.388 Y97.762 E.00526
G1 X87.639 Y97.843 E.0052
G1 X87.879 Y97.954 E.0052
G1 X88.107 Y98.095 E.00526
G1 X88.404 Y98.347 E.00767
G1 X88.58 Y98.548 E.00525
G1 X88.71 Y98.738 E.00452
G1 X88.901 Y99.123 E.00845
G1 X89.007 Y99.506 E.00782
G1 X89.043 Y99.902 E.00782
G1 X88.999 Y100.33 E.00845
G1 X88.944 Y100.553 E.00452
G1 X88.85 Y100.803 E.00525
G1 X88.683 Y101.101 E.00672
; WIPE_START
M204 S6000
G1 X88.407 Y101.452 E-.08495
G1 X88.104 Y101.709 E-.0753
G1 X87.761 Y101.907 E-.07529
G1 X87.391 Y102.04 E-.07475
G1 X87.128 Y102.091 E-.05082
G1 X87.029 Y102.099 E-.01889
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X88.002 Y96.12 Z2.28 F18000
G1 Z1.88
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X93.416 Y96.12 E.1146
G1 X93.455 Y95.443 E.01436
G1 X93.477 Y95.335 E.00232
G1 X93.567 Y95.156 E.00424
G1 X93.628 Y95.088 E.00194
G1 X93.824 Y94.962 E.00494
G1 X94.262 Y94.857 E.00952
G1 X97.773 Y89.843 E.12956
G1 X98.069 Y90.05 E.00765
G1 X94.552 Y95.072 E.12977
G1 X94.61 Y95.479 E.0087
G1 X94.599 Y95.613 E.00283
G1 X94.504 Y95.829 E.00501
G1 X94.382 Y95.96 E.00378
G1 X94.31 Y96.008 E.00182
G1 X94.079 Y96.109 E.00536
G1 X93.852 Y96.308 E.00638
G1 X93.723 Y96.387 E.00321
G1 X93.582 Y96.443 E.00321
G1 X93.441 Y96.472 E.00304
G1 X88.277 Y96.485 E.10931
G1 X89.376 Y97.675 E.03428
G1 X89.632 Y98.008 E.00889
G1 X89.919 Y98.526 E.01254
G1 X90.06 Y98.901 E.00849
G1 X90.186 Y99.48 E.01254
G1 X90.211 Y99.892 E.00872
G1 X90.194 Y100.234 E.00726
G1 X90.161 Y100.484 E.00534
G1 X90.067 Y100.879 E.0086
G1 X89.927 Y101.257 E.00853
G1 X89.773 Y101.564 E.00726
G1 X89.642 Y101.779 E.00534
G1 X89.39 Y102.11 E.00879
G1 X88.958 Y102.528 E.01273
G1 X88.524 Y102.825 E.01113
G1 X88.101 Y103.033 E.00998
G1 X87.715 Y103.164 E.00861
G1 X87.132 Y103.267 E.01254
G1 X86.731 Y103.279 E.00849
G1 X86.332 Y103.243 E.00849
G1 X85.939 Y103.161 E.00849
G1 X85.559 Y103.032 E.00849
G1 X85.03 Y102.761 E.01257
G1 X84.752 Y102.563 E.00724
G1 X84.4 Y102.248 E.00998
G1 X84.141 Y101.947 E.00841
G1 X83.918 Y101.613 E.00849
G1 X83.663 Y101.077 E.01257
G1 X83.562 Y100.75 E.00724
G1 X83.474 Y100.287 E.00998
G1 X83.452 Y99.89 E.00841
G1 X83.477 Y99.49 E.00849
G1 X83.549 Y99.095 E.00849
G1 X83.668 Y98.711 E.0085
G1 X83.831 Y98.345 E.00849
G1 X84.149 Y97.845 E.01253
G1 X85.335 Y96.482 E.03825
G1 X80.368 Y96.482 E.10513
G1 X80.129 Y96.454 E.00508
G1 X79.93 Y96.381 E.0045
G1 X79.799 Y96.301 E.00324
G1 X79.621 Y96.119 E.0054
G1 X79.481 Y95.821 E.00696
G1 X79.451 Y95.565 E.00546
G1 X79.451 Y77.628 E.37965
G1 X79.487 Y77.357 E.00578
G1 X79.592 Y77.125 E.00539
G1 X79.694 Y76.996 E.00348
G1 X79.797 Y76.903 E.00295
G1 X80.033 Y76.775 E.00568
G1 X80.284 Y76.723 E.00542
G1 X93.32 Y76.721 E.27591
G1 X93.541 Y76.748 E.00471
G1 X93.679 Y76.794 E.00309
G1 X93.856 Y76.889 E.00424
G1 X93.807 Y77.082 E.0042
G1 X80.778 Y77.082 E.27579
G1 X80.489 Y77.133 E.0062
G1 X80.216 Y77.28 E.00656
G1 X79.995 Y77.505 E.00669
G1 X79.85 Y77.8 E.00695
G1 X79.812 Y78.056 E.00548
G1 X79.812 Y95.137 E.36154
G1 X79.837 Y95.346 E.00446
G1 X79.954 Y95.64 E.00669
G1 X80.243 Y95.946 E.00892
G1 X80.537 Y96.084 E.00688
G1 X80.787 Y96.12 E.00533
G1 X87.942 Y96.12 E.15144
; WIPE_START
M204 S6000
G1 X89.942 Y96.12 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X89.209 Y96.892 Z2.28 F18000
G1 Z1.88
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X89.689 Y97.411 E.01389
G1 X89.967 Y97.772 E.00897
G1 X90.085 Y97.957 E.00431
G1 X90.293 Y98.359 E.00891
G1 X90.452 Y98.78 E.00885
G1 X90.56 Y99.22 E.00891
G1 X90.593 Y99.437 E.00431
G1 X90.621 Y99.889 E.00892
G1 X90.602 Y100.271 E.00752
G1 X90.564 Y100.559 E.00571
G1 X90.459 Y100.998 E.00888
G1 X90.303 Y101.421 E.00886
G1 X90.131 Y101.763 E.00753
G1 X89.98 Y102.01 E.00571
G1 X89.705 Y102.372 E.00895
G1 X89.557 Y102.534 E.0043
G1 X89.221 Y102.842 E.00897
G1 X89.047 Y102.976 E.00432
M73 P51 R11
G1 X88.725 Y103.182 E.00752
G1 X88.257 Y103.412 E.01025
G1 X87.83 Y103.557 E.00889
G1 X87.617 Y103.608 E.0043
G1 X87.169 Y103.676 E.00891
G1 X86.719 Y103.689 E.00885
G1 X86.271 Y103.649 E.00885
G1 X85.831 Y103.556 E.00885
G1 X85.404 Y103.412 E.00885
G1 X84.996 Y103.216 E.00891
G1 X84.807 Y103.105 E.00431
G1 X84.496 Y102.883 E.00752
G1 X84.107 Y102.535 E.01025
G1 X83.815 Y102.195 E.00883
G1 X83.564 Y101.821 E.00885
G1 X83.359 Y101.418 E.00891
G1 X83.277 Y101.214 E.00432
G1 X83.164 Y100.849 E.00752
G1 X83.067 Y100.337 E.01025
G1 X83.042 Y99.889 E.00883
G1 X83.07 Y99.44 E.00885
G1 X83.151 Y98.997 E.00885
G1 X83.284 Y98.567 E.00885
G1 X83.467 Y98.156 E.00885
G1 X83.7 Y97.767 E.00891
G1 X83.828 Y97.59 E.0043
G1 X84.436 Y96.891 E.01823
G1 X80.344 Y96.891 E.08049
G1 X80.034 Y96.855 E.00613
G1 X79.75 Y96.751 E.00594
G1 X79.559 Y96.633 E.00442
G1 X79.449 Y96.541 E.00283
G1 X79.295 Y96.368 E.00454
G1 X79.216 Y96.248 E.00283
G1 X79.119 Y96.039 E.00454
G1 X79.079 Y95.904 E.00277
G1 X79.042 Y95.589 E.00625
G1 X79.042 Y77.61 E.35362
G1 X79.062 Y77.374 E.00467
G1 X79.095 Y77.234 E.00283
G1 X79.181 Y77.019 E.00454
G1 X79.253 Y76.895 E.00283
G1 X79.394 Y76.716 E.0045
G1 X79.545 Y76.58 E.00398
G1 X79.685 Y76.485 E.00333
G1 X79.891 Y76.389 E.00447
G1 X80.087 Y76.335 E.00398
G1 X80.258 Y76.313 E.00339
G1 X93.345 Y76.312 E.25741
G1 X93.631 Y76.347 E.00567
G1 X93.842 Y76.417 E.00437
G1 X94.04 Y76.524 E.00442
G1 X94.216 Y76.663 E.00442
G1 X94.366 Y76.831 E.00442
G1 X94.484 Y77.022 E.00442
G1 X94.567 Y77.231 E.00442
G1 X94.612 Y77.448 E.00436
G1 X94.621 Y85.111 E.15071
G1 X94.622 Y85.511 E.00787
G1 F746.205
G1 X94.663 Y85.511 E.0008
G1 F600
G1 X95.032 Y85.511 E.00726
; FEATURE: Overhang wall
; LINE_WIDTH: 0.45

G1 X95.079 Y85.511 E.001
G1 X95.079 Y87.691 E.04614
G1 X95.032 Y87.691 E.001
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 X94.663 Y87.691 E.00726
G1 F747.19
G1 X94.622 Y87.691 E.00081
G1 F1500
G1 X94.622 Y88.091 E.00787
G1 X94.622 Y88.791 E.01377
G1 X93.442 Y88.791 E.02321
G1 X93.442 Y77.491 E.22226
G1 X80.813 Y77.491 E.24839
G1 X80.625 Y77.524 E.00376
G1 X80.465 Y77.61 E.00357
G1 X80.333 Y77.745 E.00371
G1 X80.246 Y77.923 E.0039
G1 X80.222 Y78.086 E.00324
G1 X80.222 Y95.113 E.33491
G1 X80.237 Y95.245 E.00261
G1 X80.305 Y95.416 E.00362
G1 X80.487 Y95.608 E.00521
G1 X80.656 Y95.687 E.00368
G1 X80.816 Y95.711 E.00319
G1 X93.03 Y95.711 E.24023
G1 X93.048 Y95.389 E.00634
G1 X93.084 Y95.218 E.00345
G1 X93.147 Y95.058 E.00339
G1 X93.237 Y94.911 E.00338
G1 X93.35 Y94.785 E.00333
G1 X93.538 Y94.644 E.00463
G1 X93.689 Y94.573 E.00327
M73 P52 R11
G1 X94.016 Y94.495 E.00662
G1 X97.672 Y89.273 E.12539
G1 X98.639 Y89.95 E.02321
G1 X94.98 Y95.175 E.12546
G1 X95.019 Y95.564 E.00769
G1 X94.959 Y95.845 E.00565
G1 X94.84 Y96.069 E.005
G1 X94.649 Y96.273 E.0055
G1 X94.508 Y96.368 E.00333
G1 X94.301 Y96.459 E.00445
G1 X94.096 Y96.639 E.00538
G1 X93.906 Y96.755 E.00438
G1 X93.698 Y96.837 E.00438
G1 X93.483 Y96.881 E.00433
G1 X89.269 Y96.892 E.08287
; WIPE_START
M204 S6000
G1 X89.689 Y97.411 E-.12675
G1 X89.967 Y97.772 E-.08669
G1 X90.085 Y97.957 E-.0416
G1 X90.293 Y98.359 E-.08608
G1 X90.365 Y98.551 E-.03888
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




G1 X88.95 Y97.775
G1 Z1.88
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.359983
G1 F1500
M204 S6000
G1 X89.207 Y98.073 E.00655
G1 X89.393 Y98.35 E.00557
G1 X89.631 Y98.828 E.0089
G1 X89.785 Y99.369 E.00938
G1 X89.832 Y99.893 E.00878
G1 X89.785 Y100.419 E.0088
G1 X89.703 Y100.769 E.006
G1 X89.58 Y101.103 E.00593
G1 X89.327 Y101.567 E.0088
G1 X88.996 Y101.978 E.00881
G1 X88.546 Y102.362 E.00986
G1 X88.078 Y102.626 E.00896
G1 X87.611 Y102.793 E.00827
G1 X87.224 Y102.872 E.00659
G1 X86.743 Y102.897 E.00804
G1 X86.388 Y102.866 E.00593
G1 X86.041 Y102.79 E.00593
G1 X85.672 Y102.667 E.00647
G1 X85.167 Y102.396 E.00956
G1 X84.75 Y102.057 E.00896
G1 X84.445 Y101.716 E.00763
G1 X84.251 Y101.42 E.0059
G1 X84.024 Y100.943 E.00881
G1 X83.93 Y100.659 E.00499
G1 X83.867 Y100.336 E.00549
G1 X83.835 Y99.988 E.00582
G1 X83.856 Y99.536 E.00754
G1 X83.92 Y99.186 E.00594
G1 X84.042 Y98.802 E.00671
G1 X84.297 Y98.306 E.0093
G1 X84.624 Y97.872 E.00906
G1 X84.817 Y97.673 E.00463
; LINE_WIDTH: 0.400604
G1 X84.992 Y97.496 E.00464
; LINE_WIDTH: 0.438388
G1 X85.199 Y97.319 E.00561
; LINE_WIDTH: 0.4771
G1 X85.379 Y97.165 E.00533
; WIPE_START
G1 X85.199 Y97.319 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X88.212 Y97.128 Z2.28 F18000
G1 Z1.88
G1 E.4 F1800
; LINE_WIDTH: 0.479634
G1 F1500
M204 S6000
G1 X88.393 Y97.272 E.00523
; LINE_WIDTH: 0.445739
G1 X88.573 Y97.416 E.00484
; LINE_WIDTH: 0.408814
G1 X88.775 Y97.608 E.00532
; LINE_WIDTH: 0.376908
G1 X88.95 Y97.775 E.00424
; WIPE_START
G1 X88.775 Y97.608 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X93.628 Y96.132 Z2.28 F18000
G1 Z1.88
G1 E.4 F1800
; LINE_WIDTH: 0.0966632
G1 F1500
M204 S6000
G1 X93.837 Y96.009 E.00086
; WIPE_START
G1 X93.628 Y96.132 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X94.159 Y88.518 Z2.28 F18000
G1 X94.26 Y87.07 Z2.28
G1 Z1.88
G1 E.4 F1800
; LINE_WIDTH: 0.420052
G1 F1500
M204 S6000
G1 X94.26 Y86.132 E.01844
; WIPE_START
G1 X94.26 Y87.07 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X88.084 Y82.586 Z2.28 F18000
G1 X80.328 Y76.955 Z2.28
G1 Z1.88
G1 E.4 F1800
; LINE_WIDTH: 0.0898085
G1 F1500
M204 S6000
G1 X80.226 Y76.991 E.00035
; LINE_WIDTH: 0.12988
G1 X80.026 Y77.081 E.00114
; LINE_WIDTH: 0.152311
G1 X79.795 Y77.32 E.0021
G1 X79.738 Y77.434 E.0008
; LINE_WIDTH: 0.101917
G1 X79.688 Y77.597 E.00065
; WIPE_START
G1 X79.738 Y77.434 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X79.72 Y85.066 Z2.28 F18000
G1 X79.695 Y95.628 Z2.28
G1 Z1.88
G1 E.4 F1800
; LINE_WIDTH: 0.0962702
G1 F1500
M204 S6000
G1 X79.748 Y95.802 E.00064
; LINE_WIDTH: 0.148081
G1 X79.851 Y95.947 E.00108
; LINE_WIDTH: 0.162864
G1 X80.079 Y96.156 E.00212
; LINE_WIDTH: 0.106894
G1 X80.315 Y96.239 E.00101
; WIPE_START
G1 X80.079 Y96.156 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X86.919 Y92.769 Z2.28 F18000
G1 X99.634 Y86.471 Z2.28
G1 Z1.88
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X99.909 Y86.078 E.00944
G1 X100.135 Y86.236 E.00542
G1 X100.876 Y86.755 E.01779
G1 X100.601 Y87.148 E.00944
G1 X99.683 Y86.506 E.02203
M204 S10000
G1 X99.939 Y86.392 F18000
; FEATURE: Gap infill
; LINE_WIDTH: 0.0965068
G1 F1500
M204 S6000
G1 X100.571 Y86.834 E.00272
; CHANGE_LAYER
; Z_HEIGHT: 2
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F1500
G1 X99.939 Y86.392 E-.38
; WIPE_END
G1 E-.02 F1800
; layer num/total_layer_count: 16/49
; update layer progress
M73 L16
M991 S0 P15 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z2.28 I.363 J-1.162 P1  F18000
G1 X93.851 Y84.489 Z2.28
G1 Z2
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X93.851 Y77.128 E.15579
G1 X94.036 Y77.076 E.00407
G1 X94.117 Y77.207 E.00325
G1 X94.173 Y77.349 E.00324
G1 X94.202 Y77.49 E.00306
G1 X94.213 Y85.92 E.17842
G1 X94.841 Y85.92 E.01328
G1 X94.841 Y87.282 E.02882
G1 X94.212 Y87.282 E.0133
G1 X94.212 Y88.382 E.02328
G1 X93.851 Y88.382 E.00765
G1 X93.851 Y84.549 E.08112
; WIPE_START
M204 S6000
G1 X93.851 Y82.549 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X93.874 Y90.181 Z2.4 F18000
G1 X93.89 Y95.435 Z2.4
G1 Z2
G1 E.4 F1800
G1 F1500
M204 S500
G1 X93.956 Y95.365 E.00202
G1 X94.159 Y95.318 E.00442
G1 X94.188 Y95.52 E.00431
G1 X94.105 Y95.634 E.00299
G1 X93.863 Y95.741 E.0056
G1 X93.885 Y95.494 E.00524
; WIPE_START
M204 S6000
G1 X93.956 Y95.365 E-.0462
G1 X94.159 Y95.318 E-.06537
G1 X94.188 Y95.52 E-.0638
G1 X94.105 Y95.634 E-.04429
G1 X93.863 Y95.741 E-.08285
G1 X93.885 Y95.494 E-.0775
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X88.048 Y97.1 Z2.4 F18000
G1 Z2
G1 E.4 F1800
G1 F1500
M204 S500
G1 X87.598 Y96.954 E.01001
G1 X87.225 Y96.88 E.00804
G1 X86.695 Y96.856 E.01123
G1 X86.153 Y96.93 E.01157
G1 X85.597 Y97.11 E.01237
G1 X85.491 Y96.949 E.0041
G1 X85.842 Y96.544 E.01135
G1 X87.808 Y96.544 E.04161
G1 X88.154 Y96.937 E.01108
G1 X88.081 Y97.05 E.00284
; WIPE_START
M204 S6000
G1 X87.598 Y96.954 E-.09353
G1 X87.225 Y96.88 E-.07222
G1 X86.695 Y96.856 E-.1008
G1 X86.153 Y96.93 E-.10386
G1 X86.105 Y96.945 E-.00959
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X88.969 Y101.406 Z2.4 F18000
G1 Z2
G1 E.4 F1800
G1 F1500
M204 S500
G1 X88.702 Y101.738 E.00902
G1 X88.341 Y102.045 E.01003
G1 X87.942 Y102.275 E.00975
G1 X87.642 Y102.393 E.00683
G1 X87.329 Y102.474 E.00683
G1 X86.88 Y102.521 E.00956
G1 X86.56 Y102.507 E.00679
G1 X86.283 Y102.463 E.00594
G1 X85.804 Y102.313 E.0106
G1 X85.387 Y102.089 E.01003
G1 X85.02 Y101.796 E.00995
G1 X84.711 Y101.442 E.00995
G1 X84.468 Y101.035 E.01003
G1 X84.297 Y100.564 E.0106
G1 X84.24 Y100.29 E.00593
G1 X84.212 Y99.979 E.0066
G1 X84.222 Y99.668 E.00659
G1 X84.262 Y99.39 E.00594
G1 X84.404 Y98.91 E.0106
G1 X84.622 Y98.49 E.01002
G1 X84.91 Y98.118 E.00995
G1 X85.252 Y97.809 E.00975
G1 X85.521 Y97.632 E.00683
G1 X85.81 Y97.487 E.00683
G1 X86.248 Y97.345 E.00975
G1 X86.714 Y97.282 E.00995
G1 X87.174 Y97.302 E.00975
G1 X87.491 Y97.365 E.00683
G1 X87.798 Y97.465 E.00683
G1 X88.21 Y97.671 E.00975
G1 X88.578 Y97.947 E.00975
G1 X88.805 Y98.177 E.00683
G1 X89.005 Y98.435 E.00691
G1 X89.239 Y98.867 E.01041
G1 X89.336 Y99.13 E.00594
G1 X89.412 Y99.442 E.00679
G1 X89.453 Y99.901 E.00975
G1 X89.411 Y100.369 E.00995
G1 X89.289 Y100.813 E.00975
G1 X89.158 Y101.106 E.00679
G1 X89.016 Y101.348 E.00594
G1 X89.006 Y101.359 E.00031
M204 S250
G1 X88.65 Y101.15 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X88.408 Y101.452 E.00761
G1 X88.104 Y101.709 E.00782
G1 X87.764 Y101.905 E.00773
G1 X87.515 Y102.003 E.00526
G1 X87.256 Y102.07 E.00526
G1 X86.868 Y102.111 E.00767
G1 X86.601 Y102.099 E.00525
G1 X86.376 Y102.063 E.00448
G1 X85.964 Y101.934 E.0085
G1 X85.614 Y101.746 E.00782
G1 X85.304 Y101.499 E.0078
G1 X85.043 Y101.2 E.00779
G1 X84.839 Y100.859 E.00782
G1 X84.692 Y100.453 E.0085
G1 X84.646 Y100.23 E.00448
G1 X84.622 Y99.967 E.00519
G1 X84.63 Y99.703 E.00519
G1 X84.663 Y99.478 E.00448
G1 X84.785 Y99.063 E.00851
G1 X84.968 Y98.711 E.00782
G1 X85.211 Y98.397 E.0078
G1 X85.503 Y98.134 E.00773
G1 X85.726 Y97.987 E.00526
G1 X85.966 Y97.867 E.00526
G1 X86.34 Y97.746 E.00773
G1 X86.732 Y97.692 E.0078
G1 X87.125 Y97.71 E.00773
G1 X87.388 Y97.762 E.00526
G1 X87.642 Y97.844 E.00526
G1 X87.994 Y98.02 E.00774
G1 X88.308 Y98.256 E.00773
G1 X88.496 Y98.447 E.00526
G1 X88.661 Y98.659 E.00529
G1 X88.865 Y99.036 E.00844
G1 X88.944 Y99.25 E.00448
G1 X89.007 Y99.509 E.00525
G1 X89.042 Y99.901 E.00773
G1 X89.007 Y100.296 E.0078
G1 X88.902 Y100.675 E.00773
G1 X88.794 Y100.919 E.00525
G1 X88.686 Y101.102 E.00419
; WIPE_START
M204 S6000
G1 X88.408 Y101.452 E-.08488
G1 X88.104 Y101.709 E-.07554
G1 X87.764 Y101.905 E-.07468
G1 X87.515 Y102.003 E-.05083
G1 X87.256 Y102.07 E-.05085
G1 X87.03 Y102.094 E-.04323
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X88.062 Y96.12 Z2.4 F18000
G1 Z2
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X93.416 Y96.12 E.11333
G1 X93.455 Y95.443 E.01436
G1 X93.477 Y95.335 E.00232
G1 X93.563 Y95.164 E.00405
G1 X93.667 Y95.053 E.00321
G1 X93.84 Y94.956 E.00421
G1 X94.26 Y94.859 E.00913
G1 X97.773 Y89.843 E.12962
G1 X98.069 Y90.05 E.00765
G1 X94.552 Y95.072 E.12977
G1 X94.61 Y95.479 E.0087
G1 X94.599 Y95.614 E.00286
G1 X94.503 Y95.83 E.00501
G1 X94.382 Y95.96 E.00376
G1 X94.31 Y96.008 E.00183
G1 X94.079 Y96.109 E.00535
G1 X93.852 Y96.308 E.00638
G1 X93.723 Y96.387 E.00321
G1 X93.582 Y96.443 E.00321
G1 X93.441 Y96.472 E.00304
G1 X88.322 Y96.485 E.10835
G1 X89.47 Y97.79 E.03679
G1 X89.624 Y97.996 E.00545
G1 X89.833 Y98.346 E.00863
G1 X89.972 Y98.655 E.00716
G1 X90.059 Y98.897 E.00544
G1 X90.158 Y99.3 E.00879
G1 X90.211 Y99.89 E.01254
G1 X90.189 Y100.292 E.00853
G1 X90.068 Y100.875 E.01259
G1 X89.928 Y101.256 E.00859
G1 X89.741 Y101.621 E.00869
G1 X89.39 Y102.11 E.01274
G1 X88.958 Y102.529 E.01273
G1 X88.466 Y102.859 E.01254
G1 X88.104 Y103.032 E.00849
G1 X87.715 Y103.164 E.00869
G1 X87.132 Y103.267 E.01253
G1 X86.731 Y103.279 E.00849
G1 X86.332 Y103.243 E.00849
G1 X85.93 Y103.159 E.00869
G1 X85.375 Y102.951 E.01253
G1 X85.024 Y102.757 E.0085
G1 X84.699 Y102.522 E.00849
G1 X84.403 Y102.251 E.0085
G1 X84.141 Y101.947 E.00849
G1 X83.918 Y101.613 E.00849
G1 X83.663 Y101.077 E.01257
G1 X83.563 Y100.754 E.00715
G1 X83.474 Y100.287 E.01007
G1 X83.452 Y99.89 E.00841
G1 X83.477 Y99.49 E.00849
G1 X83.549 Y99.095 E.00849
G1 X83.668 Y98.712 E.00849
G1 X83.832 Y98.343 E.00853
G1 X84.152 Y97.841 E.01259
G1 X85.335 Y96.482 E.03815
G1 X80.368 Y96.482 E.10513
G1 X80.129 Y96.454 E.00508
G1 X79.856 Y96.34 E.00627
G1 X79.729 Y96.24 E.00343
G1 X79.621 Y96.119 E.00343
G1 X79.52 Y95.937 E.00441
G1 X79.48 Y95.814 E.00272
G1 X79.451 Y95.565 E.00532
G1 X79.451 Y77.628 E.37965
G1 X79.487 Y77.357 E.00578
G1 X79.592 Y77.125 E.00539
G1 X79.694 Y76.996 E.00348
G1 X79.796 Y76.904 E.00292
G1 X80.031 Y76.775 E.00567
G1 X80.281 Y76.723 E.00539
G1 X93.321 Y76.721 E.27602
G1 X93.541 Y76.748 E.00468
G1 X93.68 Y76.794 E.0031
G1 X93.856 Y76.889 E.00424
G1 X93.807 Y77.082 E.0042
G1 X80.778 Y77.082 E.27579
G1 X80.489 Y77.133 E.00621
G1 X80.219 Y77.278 E.00649
G1 X80.002 Y77.495 E.00649
G1 X79.85 Y77.797 E.00717
G1 X79.812 Y78.056 E.00553
G1 X79.812 Y95.146 E.36173
G1 X79.847 Y95.386 E.00513
G1 X79.96 Y95.646 E.006
G1 X80.243 Y95.946 E.00873
G1 X80.537 Y96.084 E.00688
G1 X80.787 Y96.12 E.00533
G1 X88.002 Y96.12 E.15271
; WIPE_START
M204 S6000
G1 X90.002 Y96.12 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X89.225 Y96.892 Z2.4 F18000
G1 Z2
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X89.788 Y97.532 E.01677
G1 X89.965 Y97.769 E.0058
G1 X90.196 Y98.157 E.00889
G1 X90.352 Y98.501 E.00743
G1 X90.451 Y98.779 E.0058
G1 X90.56 Y99.22 E.00894
G1 X90.593 Y99.437 E.00431
G1 X90.621 Y99.889 E.00891
G1 X90.596 Y100.338 E.00886
G1 X90.532 Y100.711 E.00743
G1 X90.46 Y100.997 E.0058
G1 X90.303 Y101.42 E.00888
G1 X90.097 Y101.824 E.00891
G1 X89.981 Y102.009 E.00431
G1 X89.705 Y102.372 E.00897
G1 X89.557 Y102.534 E.0043
G1 X89.221 Y102.842 E.00897
G1 X89.047 Y102.975 E.00431
G1 X88.665 Y103.218 E.00891
G1 X88.259 Y103.412 E.00885
G1 X87.83 Y103.557 E.00891
G1 X87.617 Y103.608 E.0043
G1 X87.169 Y103.675 E.00891
G1 X86.719 Y103.689 E.00885
G1 X86.271 Y103.649 E.00885
G1 X85.828 Y103.555 E.00891
G1 X85.618 Y103.491 E.0043
G1 X85.199 Y103.321 E.00891
M73 P53 R11
G1 X84.805 Y103.103 E.00885
G1 X84.44 Y102.84 E.00885
G1 X84.108 Y102.536 E.00885
G1 X83.815 Y102.195 E.00885
G1 X83.564 Y101.821 E.00885
G1 X83.358 Y101.417 E.00891
G1 X83.277 Y101.214 E.00431
G1 X83.165 Y100.853 E.00743
G1 X83.067 Y100.337 E.01034
G1 X83.042 Y99.889 E.00883
G1 X83.07 Y99.44 E.00885
G1 X83.151 Y98.997 E.00885
G1 X83.284 Y98.567 E.00885
G1 X83.468 Y98.156 E.00886
G1 X83.659 Y97.83 E.00743
G1 X83.829 Y97.589 E.0058
G1 X84.436 Y96.891 E.0182
G1 X80.344 Y96.891 E.08049
G1 X80.034 Y96.855 E.00613
G1 X79.748 Y96.75 E.006
G1 X79.626 Y96.68 E.00277
G1 X79.447 Y96.539 E.00448
G1 X79.295 Y96.368 E.00448
G1 X79.215 Y96.247 E.00286
G1 X79.139 Y96.09 E.00343
G1 X79.078 Y95.902 E.00389
G1 X79.042 Y95.589 E.0062
G1 X79.042 Y77.61 E.35362
G1 X79.062 Y77.374 E.00466
G1 X79.095 Y77.234 E.00283
G1 X79.181 Y77.019 E.00454
G1 X79.253 Y76.895 E.00283
G1 X79.394 Y76.716 E.0045
G1 X79.543 Y76.581 E.00395
G1 X79.685 Y76.485 E.00337
G1 X79.891 Y76.389 E.00446
G1 X80.111 Y76.33 E.00448
G1 X80.257 Y76.313 E.00289
G1 X93.347 Y76.312 E.25747
G1 X93.631 Y76.347 E.00564
G1 X93.842 Y76.417 E.00438
G1 X94.04 Y76.524 E.00442
G1 X94.216 Y76.663 E.00442
G1 X94.366 Y76.831 E.00442
G1 X94.484 Y77.022 E.00442
G1 X94.567 Y77.231 E.00442
G1 X94.612 Y77.448 E.00436
G1 X94.622 Y85.511 E.15858
G1 X95.12 Y85.511 E.00979
G1 F1870.275
G1 X95.25 Y85.511 E.00256
G1 F1320
G1 X95.25 Y87.691 E.04288
G1 F1668.612
G1 X95.12 Y87.691 E.00256
G1 F1500
G1 X94.622 Y87.691 E.0098
G1 X94.622 Y88.791 E.02164
G1 X93.442 Y88.791 E.02321
G1 X93.442 Y77.491 E.22226
G1 X80.813 Y77.491 E.24839
G1 X80.625 Y77.524 E.00376
G1 X80.466 Y77.61 E.00355
G1 X80.338 Y77.737 E.00355
G1 X80.246 Y77.922 E.00406
G1 X80.222 Y78.086 E.00325
G1 X80.222 Y95.116 E.33498
G1 X80.245 Y95.273 E.00312
G1 X80.307 Y95.418 E.0031
G1 X80.487 Y95.608 E.00515
G1 X80.656 Y95.687 E.00368
G1 X80.816 Y95.711 E.00319
G1 X93.03 Y95.711 E.24023
G1 X93.048 Y95.389 E.00634
G1 X93.084 Y95.218 E.00345
G1 X93.147 Y95.058 E.00339
G1 X93.236 Y94.914 E.00332
G1 X93.397 Y94.742 E.00463
G1 X93.534 Y94.646 E.0033
G1 X93.708 Y94.567 E.00375
G1 X94.015 Y94.496 E.0062
G1 X97.672 Y89.273 E.12541
G1 X98.639 Y89.95 E.02321
G1 X94.98 Y95.175 E.12546
G1 X95.019 Y95.564 E.00769
G1 X94.959 Y95.845 E.00565
G1 X94.839 Y96.07 E.00502
G1 X94.649 Y96.273 E.00548
G1 X94.508 Y96.368 E.00333
G1 X94.301 Y96.459 E.00445
G1 X94.096 Y96.639 E.00538
G1 X93.906 Y96.755 E.00438
G1 X93.698 Y96.837 E.00438
G1 X93.483 Y96.881 E.00433
G1 X89.285 Y96.892 E.08257
; WIPE_START
M204 S6000
G1 X89.788 Y97.532 E-.15472
G1 X89.965 Y97.769 E-.05605
G1 X90.196 Y98.157 E-.0859
G1 X90.352 Y98.501 E-.07179
G1 X90.372 Y98.558 E-.01155
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




G1 X88.824 Y97.645
G1 Z2
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.360428
G1 F1500
M204 S6000
G1 X89.096 Y97.936 E.00664
G1 X89.315 Y98.217 E.00595
G1 X89.49 Y98.522 E.00588
G1 X89.701 Y99.029 E.00916
G1 X89.805 Y99.527 E.00849
G1 X89.832 Y99.891 E.0061
G1 X89.781 Y100.422 E.0089
G1 X89.639 Y100.952 E.00917
G1 X89.411 Y101.428 E.00881
G1 X89.096 Y101.861 E.00894
G1 X88.959 Y102.01 E.00338
G1 X88.568 Y102.342 E.00857
G1 X88.116 Y102.609 E.00875
G1 X87.749 Y102.754 E.0066
G1 X87.384 Y102.844 E.00627
G1 X86.879 Y102.898 E.00848
G1 X86.39 Y102.866 E.00818
G1 X85.88 Y102.74 E.00878
G1 X85.541 Y102.605 E.00609
G1 X85.192 Y102.412 E.00666
G1 X84.77 Y102.078 E.00898
G1 X84.445 Y101.716 E.00813
G1 X84.249 Y101.418 E.00594
G1 X84.082 Y101.093 E.00611
G1 X83.931 Y100.661 E.00765
G1 X83.853 Y100.24 E.00713
G1 X83.834 Y99.891 E.00584
G1 X83.856 Y99.536 E.00594
G1 X83.896 Y99.298 E.00403
G1 X84.049 Y98.783 E.00896
G1 X84.296 Y98.299 E.00909
G1 X84.624 Y97.872 E.00898
G1 X84.818 Y97.673 E.00464
; LINE_WIDTH: 0.400582
G1 X84.992 Y97.496 E.00464
; LINE_WIDTH: 0.438371
G1 X85.199 Y97.319 E.00561
; LINE_WIDTH: 0.477095
G1 X85.379 Y97.165 E.00533
; WIPE_START
G1 X85.199 Y97.319 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X88.121 Y97.375 Z2.4 F18000
G1 Z2
G1 E.4 F1800
; LINE_WIDTH: 0.463609
G1 F1500
M204 S6000
G1 X88.447 Y97.297 E.00732
G1 X88.581 Y97.42 E.00397
; LINE_WIDTH: 0.430458
G1 X88.702 Y97.533 E.00335
; LINE_WIDTH: 0.396345
G1 X88.824 Y97.645 E.00307
; WIPE_START
G1 X88.702 Y97.533 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X93.628 Y96.132 Z2.4 F18000
G1 Z2
G1 E.4 F1800
; LINE_WIDTH: 0.096709
G1 F1500
M204 S6000
G1 X93.837 Y96.009 E.00086
; WIPE_START
G1 X93.628 Y96.132 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X85.996 Y96.193 Z2.4 F18000
G1 X80.315 Y96.239 Z2.4
G1 Z2
G1 E.4 F1800
; LINE_WIDTH: 0.106912
G1 F1500
M204 S6000
G1 X80.079 Y96.156 E.00101
; LINE_WIDTH: 0.160897
G1 X79.926 Y96.029 E.00134
G1 X79.771 Y95.838 E.00166
; LINE_WIDTH: 0.121767
G1 X79.743 Y95.78 E.0003
; LINE_WIDTH: 0.0919629
G1 X79.695 Y95.626 E.00053
; WIPE_START
G1 X79.743 Y95.78 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X79.72 Y88.148 Z2.4 F18000
G1 X79.688 Y77.598 Z2.4
G1 Z2
G1 E.4 F1800
; LINE_WIDTH: 0.102625
G1 F1500
M204 S6000
G1 X79.739 Y77.434 E.00066
; LINE_WIDTH: 0.152056
G1 X79.794 Y77.32 E.0008
G1 X80.026 Y77.082 E.0021
; LINE_WIDTH: 0.129982
G1 X80.224 Y76.991 E.00113
; LINE_WIDTH: 0.0897928
G1 X80.328 Y76.955 E.00035
; WIPE_START
G1 X80.224 Y76.991 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X87.083 Y80.341 Z2.4 F18000
G1 X99.634 Y86.471 Z2.4
G1 Z2
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X99.909 Y86.078 E.00944
G1 X100.161 Y86.254 E.00604
G1 X100.876 Y86.755 E.01716
G1 X100.601 Y87.148 E.00944
G1 X99.683 Y86.506 E.02203
M204 S10000
G1 X99.939 Y86.392 F18000
; FEATURE: Gap infill
; LINE_WIDTH: 0.096513
G1 F1500
M204 S6000
G1 X100.571 Y86.834 E.00272
; CHANGE_LAYER
; Z_HEIGHT: 2.12
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F1500
G1 X99.939 Y86.392 E-.38
; WIPE_END
G1 E-.02 F1800
; layer num/total_layer_count: 17/49
; update layer progress
M73 L17
M991 S0 P16 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z2.4 I.01 J-1.217 P1  F18000
G1 X94.275 Y86.344 Z2.4
G1 Z2.12
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X94.588 Y86.344 E.00662
G1 X94.588 Y86.857 E.01086
G1 X94.275 Y86.857 E.00662
G1 X94.275 Y86.404 E.00959
; WIPE_START
M204 S6000
G1 X94.588 Y86.344 E-.07577
G1 X94.588 Y86.857 E-.12205
G1 X94.275 Y86.857 E-.07441
G1 X94.275 Y86.404 E-.10777
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X93.851 Y84.415 Z2.52 F18000
G1 Z2.12
G1 E.4 F1800
G1 F1500
M204 S500
G1 X93.851 Y77.128 E.15423
G1 X94.036 Y77.076 E.00407
G1 X94.117 Y77.207 E.00325
G1 X94.173 Y77.349 E.00324
G1 X94.202 Y77.49 E.00306
G1 X94.213 Y85.92 E.17842
G1 X95.012 Y85.92 E.01691
G1 X95.012 Y87.282 E.02882
G1 X94.212 Y87.282 E.01693
G1 X94.212 Y88.382 E.02328
G1 X93.851 Y88.382 E.00765
G1 X93.851 Y84.475 E.08268
; WIPE_START
M204 S6000
G1 X93.851 Y82.475 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X93.878 Y90.108 Z2.52 F18000
G1 X93.897 Y95.416 Z2.52
G1 Z2.12
G1 E.4 F1800
G1 F1500
M204 S500
G1 X93.97 Y95.362 E.00193
G1 X94.159 Y95.318 E.0041
G1 X94.188 Y95.521 E.00435
G1 X94.142 Y95.61 E.0021
G1 X93.858 Y95.743 E.00665
G1 X93.89 Y95.476 E.0057
; WIPE_START
M204 S6000
G1 X93.97 Y95.362 E-.04338
G1 X94.159 Y95.318 E-.06033
G1 X94.188 Y95.521 E-.0639
G1 X94.142 Y95.61 E-.03089
G1 X93.858 Y95.743 E-.09772
G1 X93.89 Y95.476 E-.08377
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X87.991 Y97.081 Z2.52 F18000
G1 Z2.12
G1 E.4 F1800
G1 F1500
M204 S500
G1 X87.598 Y96.953 E.00874
G1 X87.225 Y96.88 E.00804
G1 X86.695 Y96.856 E.01123
G1 X86.153 Y96.93 E.01157
G1 X85.666 Y97.088 E.01084
G1 X85.56 Y96.922 E.00416
G1 X85.909 Y96.544 E.01089
G1 X87.754 Y96.544 E.03904
G1 X88.097 Y96.916 E.0107
G1 X88.023 Y97.031 E.00289
; WIPE_START
M204 S6000
G1 X87.598 Y96.953 E-.0821
G1 X87.225 Y96.88 E-.07221
G1 X86.695 Y96.856 E-.10081
G1 X86.153 Y96.93 E-.10383
G1 X86.048 Y96.964 E-.02106
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X88.98 Y101.386 Z2.52 F18000
G1 Z2.12
G1 E.4 F1800
G1 F1500
M204 S500
G1 X88.809 Y101.622 E.00616
G1 X88.549 Y101.879 E.00774
G1 X88.331 Y102.05 E.00587
G1 X87.934 Y102.28 E.00971
G1 X87.491 Y102.438 E.00995
G1 X87.028 Y102.515 E.00995
G1 X86.558 Y102.508 E.00995
G1 X86.106 Y102.419 E.00975
G1 X85.802 Y102.31 E.00683
G1 X85.513 Y102.166 E.00683
G1 X85.144 Y101.906 E.00955
G1 X84.911 Y101.683 E.00683
G1 X84.706 Y101.434 E.00683
G1 X84.474 Y101.046 E.00955
M73 P54 R11
G1 X84.352 Y100.748 E.00683
G1 X84.266 Y100.437 E.00683
G1 X84.211 Y99.979 E.00975
G1 X84.239 Y99.519 E.00975
G1 X84.305 Y99.206 E.00679
G1 X84.393 Y98.942 E.00588
G1 X84.62 Y98.493 E.01065
G1 X84.91 Y98.118 E.01003
G1 X85.252 Y97.809 E.00975
G1 X85.521 Y97.632 E.00683
G1 X85.81 Y97.487 E.00684
G1 X86.248 Y97.345 E.00975
G1 X86.714 Y97.282 E.00995
G1 X87.174 Y97.302 E.00975
G1 X87.491 Y97.365 E.00683
G1 X87.798 Y97.465 E.00683
G1 X88.21 Y97.671 E.00975
G1 X88.578 Y97.947 E.00975
G1 X88.805 Y98.177 E.00683
G1 X89.002 Y98.432 E.00683
G1 X89.227 Y98.835 E.00975
G1 X89.379 Y99.279 E.00995
G1 X89.449 Y99.744 E.00995
G1 X89.435 Y100.214 E.00995
G1 X89.339 Y100.665 E.00975
G1 X89.225 Y100.967 E.00683
G1 X89.077 Y101.253 E.00683
G1 X89.015 Y101.338 E.00221
M204 S250
G1 X88.649 Y101.146 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X88.498 Y101.354 E.00506
G1 X88.278 Y101.571 E.00608
G1 X88.101 Y101.711 E.00443
G1 X87.761 Y101.907 E.00772
G1 X87.388 Y102.041 E.0078
G1 X86.997 Y102.106 E.00779
G1 X86.601 Y102.1 E.00779
G1 X86.215 Y102.024 E.00774
G1 X85.963 Y101.933 E.00526
G1 X85.724 Y101.814 E.00526
G1 X85.405 Y101.589 E.00767
G1 X85.211 Y101.404 E.00526
G1 X85.041 Y101.198 E.00526
G1 X84.841 Y100.863 E.00767
G1 X84.74 Y100.615 E.00526
G1 X84.669 Y100.357 E.00526
G1 X84.622 Y99.967 E.00773
G1 X84.645 Y99.574 E.00774
G1 X84.701 Y99.313 E.00525
G1 X84.772 Y99.1 E.00443
G1 X84.968 Y98.712 E.00855
G1 X85.211 Y98.397 E.00782
G1 X85.503 Y98.134 E.00774
G1 X85.726 Y97.987 E.00526
G1 X85.966 Y97.867 E.00526
G1 X86.34 Y97.745 E.00773
G1 X86.732 Y97.692 E.0078
G1 X87.125 Y97.71 E.00773
G1 X87.388 Y97.762 E.00526
G1 X87.642 Y97.844 E.00526
G1 X87.994 Y98.02 E.00773
G1 X88.308 Y98.256 E.00773
G1 X88.496 Y98.447 E.00526
G1 X88.66 Y98.658 E.00526
G1 X88.851 Y99.002 E.00773
G1 X88.979 Y99.377 E.0078
G1 X89.039 Y99.769 E.00779
G1 X89.027 Y100.165 E.0078
G1 X88.945 Y100.55 E.00774
G1 X88.851 Y100.8 E.00526
G1 X88.728 Y101.037 E.00526
G1 X88.684 Y101.097 E.00145
; WIPE_START
M204 S6000
G1 X88.498 Y101.354 E-.06031
G1 X88.278 Y101.571 E-.05874
G1 X88.101 Y101.711 E-.04276
G1 X87.761 Y101.907 E-.07457
G1 X87.388 Y102.041 E-.07536
G1 X87.033 Y102.1 E-.06827
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X88.002 Y96.12 Z2.52 F18000
G1 Z2.12
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X93.399 Y96.12 E.11424
G1 X93.462 Y95.401 E.01529
G1 X93.51 Y95.249 E.00335
G1 X93.567 Y95.156 E.00232
G1 X93.747 Y94.999 E.00505
G1 X93.841 Y94.956 E.0022
G1 X94.26 Y94.859 E.0091
G1 X97.773 Y89.843 E.12962
G1 X98.069 Y90.05 E.00765
G1 X94.552 Y95.072 E.12977
G1 X94.61 Y95.479 E.0087
G1 X94.599 Y95.615 E.00288
G1 X94.5 Y95.841 E.00522
G1 X94.395 Y95.951 E.00322
G1 X94.31 Y96.008 E.00216
G1 X94.079 Y96.109 E.00536
G1 X93.852 Y96.308 E.00638
G1 X93.723 Y96.387 E.00321
G1 X93.582 Y96.443 E.00321
G1 X93.441 Y96.472 E.00304
G1 X88.277 Y96.485 E.1093
G1 X89.376 Y97.675 E.03429
G1 X89.632 Y98.008 E.00888
G1 X89.919 Y98.526 E.01254
G1 X90.06 Y98.901 E.00849
G1 X90.186 Y99.48 E.01254
G1 X90.211 Y99.892 E.00873
G1 X90.195 Y100.225 E.00706
G1 X90.161 Y100.485 E.00554
G1 X90.067 Y100.879 E.00859
G1 X89.928 Y101.256 E.00849
G1 X89.741 Y101.621 E.00869
G1 X89.39 Y102.11 E.01273
G1 X89.124 Y102.385 E.0081
G1 X88.805 Y102.644 E.00869
G1 X88.466 Y102.859 E.0085
G1 X88.104 Y103.032 E.00849
G1 X87.715 Y103.164 E.00869
G1 X87.132 Y103.267 E.01254
G1 X86.731 Y103.279 E.00849
G1 X86.332 Y103.243 E.00849
G1 X85.939 Y103.161 E.00849
G1 X85.384 Y102.955 E.01253
G1 X85.024 Y102.757 E.00869
G1 X84.699 Y102.522 E.00849
G1 X84.403 Y102.251 E.0085
G1 X84.141 Y101.947 E.00849
G1 X83.918 Y101.613 E.00849
G1 X83.663 Y101.077 E.01257
G1 X83.564 Y100.759 E.00705
G1 X83.474 Y100.287 E.01017
G1 X83.452 Y99.89 E.00841
G1 X83.477 Y99.49 E.00849
G1 X83.549 Y99.095 E.00849
G1 X83.668 Y98.712 E.00849
G1 X83.831 Y98.345 E.00849
G1 X84.037 Y98 E.00849
G1 X84.287 Y97.675 E.00869
G1 X85.39 Y96.482 E.03439
G1 X80.368 Y96.482 E.1063
G1 X80.129 Y96.454 E.00508
G1 X79.93 Y96.381 E.0045
G1 X79.799 Y96.301 E.00324
G1 X79.621 Y96.119 E.00539
G1 X79.57 Y96.041 E.00198
G1 X79.48 Y95.812 E.0052
G1 X79.451 Y95.565 E.00527
G1 X79.451 Y77.628 E.37965
G1 X79.487 Y77.357 E.00578
G1 X79.548 Y77.205 E.00348
G1 X79.618 Y77.088 E.00288
G1 X79.814 Y76.89 E.00589
G1 X80.031 Y76.775 E.0052
G1 X80.281 Y76.723 E.00539
G1 X93.323 Y76.721 E.27605
G1 X93.54 Y76.748 E.00464
G1 X93.68 Y76.794 E.0031
G1 X93.856 Y76.889 E.00424
G1 X93.807 Y77.082 E.0042
G1 X80.777 Y77.082 E.27579
G1 X80.489 Y77.133 E.0062
G1 X80.216 Y77.28 E.00656
G1 X79.994 Y77.507 E.00671
G1 X79.85 Y77.8 E.00693
G1 X79.812 Y78.056 E.00546
G1 X79.812 Y95.177 E.36238
G1 X79.905 Y95.551 E.00817
G1 X80.082 Y95.799 E.00645
G1 X80.276 Y95.962 E.00536
G1 X80.538 Y96.084 E.0061
G1 X80.787 Y96.12 E.00533
G1 X87.942 Y96.12 E.15145
; WIPE_START
M204 S6000
G1 X89.942 Y96.12 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X89.21 Y96.892 Z2.52 F18000
G1 Z2.12
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X89.689 Y97.411 E.01389
G1 X89.967 Y97.772 E.00897
G1 X90.085 Y97.957 E.0043
G1 X90.293 Y98.359 E.00891
G1 X90.452 Y98.78 E.00885
G1 X90.56 Y99.22 E.00891
G1 X90.593 Y99.437 E.00431
G1 X90.621 Y99.889 E.00892
G1 X90.603 Y100.262 E.00734
G1 X90.564 Y100.559 E.00589
G1 X90.459 Y100.998 E.00888
G1 X90.303 Y101.42 E.00885
G1 X90.097 Y101.824 E.00891
G1 X89.981 Y102.009 E.0043
G1 X89.705 Y102.372 E.00898
G1 X89.396 Y102.691 E.00873
G1 X89.045 Y102.977 E.00891
G1 X88.665 Y103.218 E.00885
G1 X88.259 Y103.412 E.00885
G1 X87.83 Y103.557 E.00891
G1 X87.617 Y103.608 E.0043
G1 X87.169 Y103.676 E.00891
G1 X86.719 Y103.689 E.00885
G1 X86.271 Y103.649 E.00885
G1 X85.831 Y103.556 E.00885
G1 X85.402 Y103.411 E.00892
G1 X85.202 Y103.322 E.0043
G1 X84.805 Y103.103 E.00891
G1 X84.44 Y102.84 E.00885
G1 X84.108 Y102.536 E.00885
G1 X83.815 Y102.195 E.00885
G1 X83.564 Y101.821 E.00885
G1 X83.358 Y101.417 E.00891
G1 X83.277 Y101.214 E.00431
G1 X83.166 Y100.858 E.00734
G1 X83.067 Y100.337 E.01043
G1 X83.042 Y99.889 E.00882
G1 X83.07 Y99.44 E.00885
G1 X83.151 Y98.997 E.00885
G1 X83.284 Y98.567 E.00885
G1 X83.467 Y98.156 E.00885
G1 X83.698 Y97.77 E.00885
G1 X83.974 Y97.411 E.00891
G1 X84.455 Y96.891 E.01393
G1 X80.344 Y96.891 E.08086
G1 X80.034 Y96.855 E.00613
G1 X79.75 Y96.751 E.00594
G1 X79.559 Y96.633 E.00442
G1 X79.449 Y96.541 E.00282
G1 X79.296 Y96.369 E.00454
G1 X79.215 Y96.246 E.00289
G1 X79.149 Y96.114 E.00289
G1 X79.078 Y95.901 E.00442
G1 X79.042 Y95.589 E.00619
G1 X79.042 Y77.61 E.35362
G1 X79.062 Y77.374 E.00466
G1 X79.095 Y77.234 E.00283
G1 X79.18 Y77.022 E.00449
G1 X79.283 Y76.851 E.00392
G1 X79.392 Y76.717 E.0034
G1 X79.564 Y76.565 E.00452
G1 X79.684 Y76.486 E.00283
G1 X79.891 Y76.389 E.00448
G1 X80.111 Y76.33 E.00448
G1 X80.257 Y76.313 E.00289
G1 X93.348 Y76.312 E.2575
G1 X93.631 Y76.347 E.0056
G1 X93.842 Y76.417 E.00438
G1 X94.04 Y76.524 E.00442
G1 X94.216 Y76.663 E.00442
G1 X94.366 Y76.831 E.00442
G1 X94.484 Y77.022 E.00442
G1 X94.567 Y77.231 E.00442
G1 X94.612 Y77.448 E.00436
G1 X94.622 Y85.511 E.15858
G1 X95.291 Y85.511 E.01316
G1 F1870.245
G1 X95.421 Y85.511 E.00256
G1 F1320
G1 X95.421 Y87.691 E.04288
G1 F1668.584
G1 X95.291 Y87.691 E.00256
G1 F1500
G1 X94.622 Y87.691 E.01317
G1 X94.622 Y88.791 E.02164
G1 X93.442 Y88.791 E.02321
G1 X93.442 Y77.491 E.22226
G1 X80.813 Y77.491 E.24839
G1 X80.625 Y77.524 E.00376
G1 X80.465 Y77.61 E.00358
G1 X80.333 Y77.746 E.00372
G1 X80.245 Y77.923 E.00389
G1 X80.222 Y78.086 E.00323
G1 X80.222 Y95.127 E.33518
G1 X80.284 Y95.377 E.00507
G1 X80.385 Y95.519 E.00344
G1 X80.498 Y95.614 E.0029
G1 X80.656 Y95.687 E.00343
G1 X80.816 Y95.711 E.00318
G1 X93.024 Y95.711 E.24012
G1 X93.057 Y95.329 E.00753
G1 X93.103 Y95.16 E.00345
G1 X93.238 Y94.911 E.00557
G1 X93.35 Y94.785 E.00333
G1 X93.537 Y94.645 E.0046
G1 X93.709 Y94.566 E.00372
G1 X94.015 Y94.496 E.00617
G1 X97.672 Y89.273 E.12541
G1 X98.639 Y89.95 E.02321
G1 X94.98 Y95.175 E.12546
G1 X95.019 Y95.564 E.00769
G1 X94.959 Y95.846 E.00567
G1 X94.847 Y96.061 E.00478
G1 X94.653 Y96.27 E.0056
G1 X94.508 Y96.368 E.00344
G1 X94.301 Y96.459 E.00445
G1 X94.096 Y96.639 E.00538
G1 X93.906 Y96.755 E.00438
G1 X93.698 Y96.837 E.00438
G1 X93.483 Y96.881 E.00433
G1 X89.27 Y96.892 E.08287
; WIPE_START
M204 S6000
G1 X89.689 Y97.411 E-.12678
G1 X89.967 Y97.772 E-.08667
G1 X90.085 Y97.957 E-.04156
G1 X90.293 Y98.359 E-.0861
G1 X90.365 Y98.551 E-.03889
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




G1 X88.823 Y97.647
G1 Z2.12
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.39766
G1 F1500
M204 S6000
G1 X88.638 Y97.48 E.00462
; LINE_WIDTH: 0.442851
G1 X88.454 Y97.314 E.00518
; LINE_WIDTH: 0.480644
G1 X88.212 Y97.129 E.0069
M204 S10000
G1 X88.823 Y97.647 F18000
; LINE_WIDTH: 0.360407
G1 F1500
M204 S6000
G1 X89.084 Y97.919 E.0063
G1 X89.4 Y98.358 E.00902
G1 X89.573 Y98.68 E.0061
G1 X89.693 Y99.013 E.0059
G1 X89.804 Y99.527 E.00878
G1 X89.828 Y99.894 E.00615
G1 X89.808 Y100.274 E.00634
G1 X89.703 Y100.77 E.00846
G1 X89.576 Y101.112 E.0061
G1 X89.326 Y101.562 E.0086
G1 X89.1 Y101.865 E.00631
G1 X88.792 Y102.168 E.00721
G1 X88.533 Y102.37 E.00548
G1 X88.079 Y102.627 E.00872
G1 X87.571 Y102.805 E.00898
G1 X87.099 Y102.888 E.00801
G1 X86.743 Y102.895 E.00594
G1 X86.388 Y102.865 E.00594
G1 X86.017 Y102.787 E.00634
G1 X85.549 Y102.61 E.00836
G1 X85.229 Y102.433 E.0061
G1 X84.895 Y102.19 E.0069
G1 X84.677 Y101.986 E.00498
G1 X84.445 Y101.716 E.00594
G1 X84.251 Y101.42 E.0059
G1 X84.02 Y100.944 E.00883
G1 X83.934 Y100.666 E.00485
G1 X83.856 Y100.24 E.00724
G1 X83.834 Y99.891 E.00583
G1 X83.863 Y99.481 E.00686
G1 X83.944 Y99.097 E.00655
G1 X84.049 Y98.786 E.00549
G1 X84.31 Y98.278 E.00952
; LINE_WIDTH: 0.371693
G1 X84.622 Y97.871 E.00886
G1 X84.995 Y97.5 E.00908
; LINE_WIDTH: 0.406685
G1 X85.016 Y97.481 E.00054
; LINE_WIDTH: 0.449148
G1 X85.26 Y97.274 E.00676
G1 X85.284 Y97.279 E.0005
; LINE_WIDTH: 0.435217
G1 X85.307 Y97.284 E.00049
; LINE_WIDTH: 0.397023
G1 X85.583 Y97.351 E.00526
; WIPE_START
G1 X85.307 Y97.284 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X80.315 Y96.239 Z2.52 F18000
G1 Z2.12
G1 E.4 F1800
; LINE_WIDTH: 0.102689
G1 F1500
M204 S6000
G1 X80.131 Y96.178 E.00074
; LINE_WIDTH: 0.155095
G1 X79.883 Y95.995 E.00199
G1 X79.684 Y95.698 E.00231
; WIPE_START
M73 P55 R11
G1 X79.883 Y95.995 E-.20381
G1 X80.131 Y96.178 E-.17619
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X87.763 Y96.159 Z2.52 F18000
G1 X93.61 Y96.144 Z2.52
G1 Z2.12
G1 E.4 F1800
; LINE_WIDTH: 0.109684
G1 F1500
M204 S6000
G1 X93.837 Y96.009 E.0011
; WIPE_START
G1 X93.61 Y96.144 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X89.028 Y90.04 Z2.52 F18000
G1 X79.689 Y77.597 Z2.52
G1 Z2.12
G1 E.4 F1800
; LINE_WIDTH: 0.101835
G1 F1500
M204 S6000
G1 X79.738 Y77.434 E.00065
; LINE_WIDTH: 0.152479
G1 X79.79 Y77.327 E.00075
G1 X79.897 Y77.198 E.00106
G1 X80.046 Y77.069 E.00124
; LINE_WIDTH: 0.128386
G1 X80.209 Y76.995 E.00092
; LINE_WIDTH: 0.095669
G1 X80.296 Y76.963 E.00032
; LINE_WIDTH: 0.0812148
G1 X80.328 Y76.955 E.00009
; WIPE_START
G1 X80.296 Y76.963 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X87.145 Y80.331 Z2.52 F18000
G1 X99.634 Y86.471 Z2.52
G1 Z2.12
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X99.909 Y86.078 E.00944
G1 X100.187 Y86.273 E.00667
G1 X100.876 Y86.755 E.01654
G1 X100.601 Y87.148 E.00944
G1 X99.683 Y86.506 E.02203
M204 S10000
G1 X99.939 Y86.392 F18000
; FEATURE: Gap infill
; LINE_WIDTH: 0.0965072
G1 F1500
M204 S6000
G1 X100.571 Y86.834 E.00272
; CHANGE_LAYER
; Z_HEIGHT: 2.24
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F1500
G1 X99.939 Y86.392 E-.38
; WIPE_END
G1 E-.02 F1800
; layer num/total_layer_count: 18/49
; update layer progress
M73 L18
M991 S0 P17 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z2.52 I.01 J-1.217 P1  F18000
G1 X94.275 Y86.344 Z2.52
G1 Z2.24
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X94.759 Y86.344 E.01025
G1 X94.759 Y86.857 E.01086
G1 X94.275 Y86.857 E.01025
G1 X94.275 Y86.404 E.00959
; WIPE_START
M204 S6000
G1 X94.759 Y86.344 E-.09566
G1 X94.759 Y86.857 E-.10059
G1 X94.275 Y86.857 E-.09493
G1 X94.275 Y86.404 E-.08882
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X93.851 Y84.415 Z2.64 F18000
G1 Z2.24
G1 E.4 F1800
G1 F1500
M204 S500
G1 X93.851 Y77.125 E.1543
G1 X94.043 Y77.077 E.0042
G1 X94.138 Y77.253 E.00424
G1 X94.183 Y77.39 E.00305
G1 X94.212 Y77.637 E.00527
G1 X94.212 Y85.92 E.17532
G1 X95.184 Y85.92 E.02055
G1 X95.184 Y87.282 E.02882
G1 X94.212 Y87.282 E.02055
G1 X94.212 Y88.382 E.02328
G1 X93.851 Y88.382 E.00765
G1 X93.851 Y84.475 E.08269
; WIPE_START
M204 S6000
G1 X93.851 Y82.475 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X93.869 Y90.107 Z2.64 F18000
G1 X93.881 Y95.474 Z2.64
G1 Z2.24
G1 E.4 F1800
G1 F1500
M204 S500
G1 X93.927 Y95.392 E.00199
G1 X93.965 Y95.364 E.001
G1 X94.158 Y95.318 E.0042
G1 X94.184 Y95.483 E.00353
G1 X94.175 Y95.566 E.00177
G1 X94.111 Y95.632 E.00195
G1 X93.858 Y95.743 E.00585
G1 X93.876 Y95.534 E.00444
; WIPE_START
M204 S6000
G1 X93.927 Y95.392 E-.04682
G1 X93.965 Y95.364 E-.01463
G1 X94.158 Y95.318 E-.0615
G1 X94.184 Y95.483 E-.0517
G1 X94.175 Y95.566 E-.02599
G1 X94.111 Y95.632 E-.02862
G1 X93.858 Y95.743 E-.08569
G1 X93.876 Y95.534 E-.06505
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X87.99 Y97.081 Z2.64 F18000
G1 Z2.24
G1 E.4 F1800
G1 F1500
M204 S500
G1 X87.598 Y96.954 E.00873
G1 X87.225 Y96.88 E.00804
G1 X86.695 Y96.856 E.01123
G1 X86.153 Y96.93 E.01157
G1 X85.597 Y97.11 E.01237
G1 X85.491 Y96.949 E.0041
G1 X85.842 Y96.544 E.01135
G1 X87.754 Y96.544 E.04045
G1 X88.096 Y96.915 E.01069
G1 X88.023 Y97.03 E.00289
; WIPE_START
M204 S6000
G1 X87.598 Y96.954 E-.08203
G1 X87.225 Y96.88 E-.07221
G1 X86.695 Y96.856 E-.10081
G1 X86.153 Y96.93 E-.10385
G1 X86.048 Y96.964 E-.0211
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X88.969 Y101.413 Z2.64 F18000
G1 Z2.24
G1 E.4 F1800
G1 F1500
M204 S500
G1 X88.699 Y101.741 E.009
G1 X88.348 Y102.039 E.00975
G1 X88.075 Y102.207 E.00679
G1 X87.826 Y102.325 E.00582
G1 X87.342 Y102.473 E.01071
G1 X86.88 Y102.521 E.00984
G1 X86.56 Y102.507 E.00678
G1 X86.288 Y102.464 E.00583
G1 X85.805 Y102.314 E.01071
G1 X85.387 Y102.089 E.01003
G1 X85.02 Y101.796 E.00995
G1 X84.711 Y101.442 E.00995
G1 X84.474 Y101.047 E.00975
G1 X84.352 Y100.748 E.00684
G1 X84.266 Y100.437 E.00683
G1 X84.212 Y99.989 E.00955
G1 X84.222 Y99.668 E.00679
G1 X84.261 Y99.396 E.00583
G1 X84.404 Y98.91 E.01071
G1 X84.622 Y98.489 E.01003
G1 X84.91 Y98.118 E.00995
G1 X85.252 Y97.809 E.00975
G1 X85.521 Y97.632 E.00683
G1 X85.81 Y97.487 E.00683
G1 X86.248 Y97.345 E.00975
G1 X86.714 Y97.282 E.00995
G1 X87.174 Y97.302 E.00975
G1 X87.491 Y97.365 E.00683
G1 X87.789 Y97.462 E.00663
G1 X88.073 Y97.593 E.00663
G1 X88.348 Y97.763 E.00683
G1 X88.692 Y98.055 E.00956
G1 X88.905 Y98.298 E.00683
G1 X89.086 Y98.564 E.00683
G1 X89.286 Y98.98 E.00975
G1 X89.411 Y99.433 E.00995
G1 X89.453 Y99.901 E.00995
G1 X89.411 Y100.373 E.01003
G1 X89.27 Y100.859 E.01071
G1 X89.156 Y101.11 E.00583
G1 X89.004 Y101.364 E.00627
M204 S250
G1 X88.653 Y101.153 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X88.406 Y101.453 E.00764
G1 X88.107 Y101.707 E.00773
G1 X87.88 Y101.847 E.00525
G1 X87.678 Y101.942 E.00438
G1 X87.26 Y102.07 E.0086
G1 X86.868 Y102.111 E.00776
G1 X86.601 Y102.099 E.00524
G1 X86.381 Y102.064 E.00438
G1 X85.964 Y101.935 E.0086
G1 X85.614 Y101.746 E.00782
G1 X85.304 Y101.499 E.0078
G1 X85.043 Y101.2 E.0078
G1 X84.841 Y100.863 E.00773
G1 X84.74 Y100.615 E.00527
G1 X84.669 Y100.357 E.00526
G1 X84.622 Y99.97 E.00767
G1 X84.63 Y99.704 E.00525
G1 X84.662 Y99.483 E.00438
G1 X84.785 Y99.064 E.0086
G1 X84.969 Y98.711 E.00782
G1 X85.211 Y98.397 E.0078
G1 X85.503 Y98.134 E.00773
G1 X85.726 Y97.987 E.00526
G1 X85.966 Y97.867 E.00526
G1 X86.34 Y97.746 E.00773
G1 X86.732 Y97.692 E.0078
G1 X87.125 Y97.71 E.00773
G1 X87.388 Y97.762 E.00526
G1 X87.639 Y97.843 E.0052
G1 X87.879 Y97.954 E.0052
G1 X88.107 Y98.095 E.00526
G1 X88.404 Y98.347 E.00767
G1 X88.58 Y98.549 E.00526
G1 X88.731 Y98.77 E.00526
G1 X88.902 Y99.124 E.00773
G1 X89.007 Y99.506 E.0078
G1 X89.042 Y99.901 E.00779
G1 X89.007 Y100.297 E.00782
G1 X88.885 Y100.717 E.0086
G1 X88.793 Y100.92 E.00438
G1 X88.685 Y101.102 E.00417
; WIPE_START
M204 S6000
G1 X88.406 Y101.453 E-.08508
G1 X88.107 Y101.707 E-.07468
G1 X87.88 Y101.847 E-.05073
G1 X87.678 Y101.942 E-.04229
G1 X87.26 Y102.07 E-.08304
G1 X87.029 Y102.094 E-.04418
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X88.002 Y96.12 Z2.64 F18000
G1 Z2.24
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X93.399 Y96.12 E.11425
G1 X93.462 Y95.401 E.01529
G1 X93.49 Y95.295 E.00232
G1 X93.565 Y95.159 E.00327
G1 X93.642 Y95.075 E.00241
G1 X93.824 Y94.962 E.00455
G1 X94.262 Y94.857 E.00952
G1 X97.773 Y89.843 E.12956
G1 X98.069 Y90.05 E.00765
G1 X94.549 Y95.077 E.12989
G1 X94.608 Y95.446 E.0079
G1 X94.592 Y95.649 E.00431
G1 X94.502 Y95.839 E.00446
G1 X94.387 Y95.956 E.00346
G1 X94.31 Y96.008 E.00197
G1 X94.079 Y96.109 E.00536
G1 X93.852 Y96.308 E.00638
G1 X93.723 Y96.387 E.00322
G1 X93.581 Y96.443 E.00321
G1 X93.441 Y96.472 E.00304
G1 X88.277 Y96.485 E.10931
G1 X89.376 Y97.675 E.03428
G1 X89.632 Y98.008 E.00889
G1 X89.919 Y98.526 E.01254
G1 X90.06 Y98.901 E.00849
G1 X90.156 Y99.291 E.00849
G1 X90.206 Y99.699 E.00869
G1 X90.195 Y100.221 E.01106
G1 X90.161 Y100.485 E.00564
G1 X90.067 Y100.879 E.00859
G1 X89.928 Y101.256 E.00849
G1 X89.741 Y101.622 E.00869
G1 X89.528 Y101.94 E.00811
G1 X89.259 Y102.253 E.00873
G1 X89.018 Y102.477 E.00696
G1 X88.809 Y102.642 E.00565
G1 X88.466 Y102.859 E.00858
G1 X88.104 Y103.032 E.00849
G1 X87.715 Y103.164 E.00869
G1 X87.132 Y103.267 E.01253
G1 X86.731 Y103.279 E.00849
G1 X86.332 Y103.243 E.00849
G1 X85.939 Y103.161 E.00849
G1 X85.563 Y103.033 E.00841
G1 X85.128 Y102.818 E.01027
G1 X84.852 Y102.641 E.00695
G1 X84.403 Y102.251 E.01258
G1 X84.141 Y101.947 E.00849
G1 X83.918 Y101.613 E.00849
G1 X83.662 Y101.077 E.01258
G1 X83.565 Y100.763 E.00695
G1 X83.474 Y100.286 E.01027
G1 X83.452 Y99.89 E.0084
G1 X83.477 Y99.49 E.00849
G1 X83.549 Y99.095 E.00849
G1 X83.668 Y98.711 E.0085
G1 X83.835 Y98.336 E.00869
G1 X84.155 Y97.838 E.01253
G1 X85.335 Y96.482 E.03805
G1 X80.368 Y96.482 E.10513
G1 X80.039 Y96.43 E.00703
G1 X79.814 Y96.311 E.00539
G1 X79.693 Y96.204 E.00343
G1 X79.592 Y96.076 E.00343
G1 X79.479 Y95.803 E.00627
G1 X79.451 Y95.565 E.00508
G1 X79.451 Y77.628 E.37965
G1 X79.487 Y77.357 E.00578
G1 X79.592 Y77.125 E.00539
G1 X79.694 Y76.996 E.00349
G1 X79.794 Y76.906 E.00285
G1 X80.031 Y76.775 E.00573
G1 X80.281 Y76.723 E.00539
G1 X93.334 Y76.721 E.27628
G1 X93.482 Y76.735 E.00314
G1 X93.632 Y76.775 E.00329
G1 X93.862 Y76.904 E.00556
G1 X93.805 Y77.082 E.00395
G1 X80.778 Y77.082 E.27575
G1 X80.489 Y77.133 E.00621
G1 X80.211 Y77.282 E.00669
G1 X79.979 Y77.529 E.00717
G1 X79.849 Y77.807 E.00649
G1 X79.812 Y78.056 E.00533
G1 X79.812 Y95.137 E.36153
G1 X79.837 Y95.346 E.00445
G1 X79.953 Y95.64 E.00669
G1 X80.243 Y95.946 E.00893
G1 X80.538 Y96.084 E.00688
G1 X80.787 Y96.12 E.00533
G1 X87.942 Y96.12 E.15144
; WIPE_START
M204 S6000
G1 X89.942 Y96.12 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X89.209 Y96.892 Z2.64 F18000
G1 Z2.24
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X89.689 Y97.411 E.01389
G1 X89.967 Y97.772 E.00897
G1 X90.085 Y97.957 E.00431
G1 X90.293 Y98.359 E.00891
G1 X90.452 Y98.78 E.00885
G1 X90.559 Y99.217 E.00885
G1 X90.614 Y99.667 E.00891
G1 X90.621 Y99.886 E.00432
G1 X90.603 Y100.257 E.00731
G1 X90.564 Y100.559 E.00598
G1 X90.459 Y100.998 E.00888
G1 X90.303 Y101.42 E.00885
G1 X90.097 Y101.824 E.00891
G1 X89.85 Y102.192 E.00873
G1 X89.555 Y102.537 E.00892
G1 X89.285 Y102.787 E.00725
G1 X89.046 Y102.976 E.00599
G1 X88.665 Y103.218 E.00888
G1 X88.259 Y103.412 E.00885
G1 X87.829 Y103.557 E.00892
G1 X87.617 Y103.608 E.0043
G1 X87.169 Y103.676 E.00891
G1 X86.719 Y103.689 E.00885
G1 X86.271 Y103.649 E.00885
G1 X85.831 Y103.556 E.00885
G1 X85.406 Y103.412 E.00883
G1 X84.926 Y103.175 E.01052
G1 X84.616 Y102.976 E.00724
G1 X84.442 Y102.842 E.00432
G1 X84.108 Y102.536 E.00891
G1 X83.815 Y102.195 E.00885
G1 X83.564 Y101.821 E.00885
M73 P55 R10
G1 X83.359 Y101.418 E.00891
G1 X83.168 Y100.862 E.01155
G1 X83.067 Y100.336 E.01053
G1 X83.042 Y99.889 E.00882
G1 X83.07 Y99.44 E.00885
G1 X83.151 Y98.997 E.00885
G1 X83.284 Y98.567 E.00885
G1 X83.469 Y98.153 E.00891
G1 X83.575 Y97.962 E.0043
G1 X83.83 Y97.588 E.00891
G1 X84.436 Y96.891 E.01816
G1 X80.344 Y96.891 E.08049
G1 X80.028 Y96.854 E.00625
G1 X79.893 Y96.814 E.00277
G1 X79.684 Y96.716 E.00454
G1 X79.564 Y96.637 E.00283
G1 X79.394 Y96.486 E.00448
G1 X79.253 Y96.307 E.00448
G1 X79.182 Y96.185 E.00277
G1 X79.078 Y95.898 E.00601
G1 X79.042 Y95.589 E.00613
G1 X79.042 Y77.61 E.35362
G1 X79.062 Y77.374 E.00466
G1 X79.095 Y77.234 E.00283
G1 X79.181 Y77.02 E.00454
G1 X79.253 Y76.895 E.00283
G1 X79.394 Y76.716 E.0045
G1 X79.541 Y76.583 E.00389
G1 X79.686 Y76.485 E.00343
G1 X79.891 Y76.389 E.00446
G1 X80.111 Y76.33 E.00448
G1 X80.257 Y76.313 E.00289
G1 X93.353 Y76.312 E.2576
G1 X93.555 Y76.331 E.00398
G1 X93.773 Y76.389 E.00444
G1 X93.976 Y76.484 E.00442
G1 X94.162 Y76.614 E.00445
G1 X94.287 Y76.736 E.00343
G1 X94.408 Y76.892 E.00389
G1 X94.515 Y77.09 E.00444
G1 X94.585 Y77.301 E.00436
G1 X94.622 Y77.613 E.00619
G1 X94.622 Y85.511 E.15534
G1 X95.462 Y85.511 E.01654
G1 F1870.275
G1 X95.593 Y85.511 E.00256
G1 F1320
G1 X95.593 Y87.691 E.04288
G1 F1668.612
G1 X95.462 Y87.691 E.00256
G1 F1500
G1 X94.622 Y87.691 E.01654
G1 X94.622 Y88.791 E.02164
G1 X93.442 Y88.791 E.02321
G1 X93.442 Y77.491 E.22226
G1 X80.813 Y77.491 E.24839
G1 X80.625 Y77.524 E.00376
G1 X80.463 Y77.611 E.00362
G1 X80.321 Y77.762 E.00406
G1 X80.245 Y77.925 E.00355
G1 X80.222 Y78.086 E.00319
G1 X80.222 Y95.113 E.33491
G1 X80.237 Y95.245 E.00261
G1 X80.305 Y95.416 E.00361
G1 X80.487 Y95.608 E.00521
G1 X80.656 Y95.687 E.00368
G1 X80.816 Y95.711 E.00318
G1 X93.024 Y95.711 E.24012
G1 X93.057 Y95.329 E.00753
G1 X93.103 Y95.16 E.00345
G1 X93.237 Y94.912 E.00555
G1 X93.367 Y94.769 E.0038
G1 X93.537 Y94.644 E.00416
G1 X93.689 Y94.573 E.00328
G1 X94.016 Y94.495 E.00661
G1 X97.672 Y89.273 E.12539
G1 X98.639 Y89.95 E.02321
G1 X94.979 Y95.176 E.1255
G1 X95.016 Y95.41 E.00466
G1 X95.019 Y95.564 E.00303
G1 X94.992 Y95.741 E.00352
G1 X94.88 Y96.01 E.00572
G1 X94.82 Y96.099 E.00212
G1 X94.651 Y96.272 E.00476
M73 P56 R10
G1 X94.508 Y96.368 E.00338
G1 X94.301 Y96.459 E.00445
G1 X94.096 Y96.639 E.00538
G1 X93.906 Y96.755 E.00439
G1 X93.698 Y96.837 E.00438
G1 X93.483 Y96.881 E.00433
G1 X89.269 Y96.892 E.08287
; WIPE_START
M204 S6000
G1 X89.689 Y97.411 E-.12675
G1 X89.967 Y97.772 E-.08669
G1 X90.085 Y97.957 E-.0416
G1 X90.293 Y98.359 E-.08608
G1 X90.365 Y98.551 E-.03888
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




G1 X88.95 Y97.775
G1 Z2.24
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.360784
G1 F1500
M204 S6000
G1 X89.195 Y98.061 E.00629
G1 X89.42 Y98.386 E.00661
G1 X89.643 Y98.861 E.00878
G1 X89.783 Y99.359 E.00865
G1 X89.828 Y99.886 E.00884
G1 X89.787 Y100.416 E.00888
G1 X89.697 Y100.768 E.00607
G1 X89.578 Y101.103 E.00595
G1 X89.41 Y101.43 E.00615
G1 X89.224 Y101.705 E.00554
G1 X88.979 Y101.996 E.00636
G1 X88.56 Y102.352 E.0092
G1 X88.282 Y102.526 E.00548
G1 X87.963 Y102.679 E.00591
G1 X87.46 Y102.834 E.0088
G1 X87.098 Y102.884 E.00611
G1 X86.743 Y102.897 E.00595
G1 X86.214 Y102.833 E.0089
G1 X85.709 Y102.681 E.00881
G1 X85.317 Y102.485 E.00733
G1 X85.076 Y102.33 E.00478
G1 X84.75 Y102.057 E.00711
G1 X84.414 Y101.676 E.00849
G1 X84.251 Y101.42 E.00507
G1 X84.02 Y100.944 E.00885
G1 X83.901 Y100.521 E.00734
G1 X83.836 Y100.018 E.00848
G1 X83.856 Y99.536 E.00806
G1 X83.923 Y99.186 E.00595
G1 X84.049 Y98.784 E.00705
G1 X84.252 Y98.374 E.00766
G1 X84.459 Y98.073 E.00611
G1 X84.818 Y97.673 E.00897
; LINE_WIDTH: 0.400588
G1 X84.992 Y97.496 E.00464
; LINE_WIDTH: 0.438376
G1 X85.199 Y97.319 E.00562
; LINE_WIDTH: 0.477101
G1 X85.379 Y97.165 E.00534
; WIPE_START
G1 X85.199 Y97.319 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X88.212 Y97.128 Z2.64 F18000
G1 Z2.24
G1 E.4 F1800
; LINE_WIDTH: 0.479635
G1 F1500
M204 S6000
G1 X88.393 Y97.272 E.00523
; LINE_WIDTH: 0.445744
G1 X88.573 Y97.416 E.00484
; LINE_WIDTH: 0.408812
G1 X88.775 Y97.608 E.00532
; LINE_WIDTH: 0.376899
G1 X88.95 Y97.775 E.00424
; WIPE_START
G1 X88.775 Y97.608 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X93.61 Y96.144 Z2.64 F18000
G1 Z2.24
G1 E.4 F1800
; LINE_WIDTH: 0.109742
G1 F1500
M204 S6000
G1 X93.837 Y96.009 E.0011
; WIPE_START
G1 X93.61 Y96.144 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X85.978 Y96.198 Z2.64 F18000
G1 X80.315 Y96.239 Z2.64
G1 Z2.24
G1 E.4 F1800
; LINE_WIDTH: 0.106237
G1 F1500
M204 S6000
G1 X80.095 Y96.167 E.00093
; LINE_WIDTH: 0.139402
G1 X80.023 Y96.117 E.0005
; LINE_WIDTH: 0.167207
G1 X79.903 Y96.005 E.00116
G1 X79.685 Y95.744 E.0024
M204 S10000
G1 X79.696 Y95.628 F18000
; LINE_WIDTH: 0.10292
G1 F1500
M204 S6000
G1 X79.735 Y95.77 E.00057
G1 X79.896 Y96.097 E.0014
; WIPE_START
G1 X79.735 Y95.77 E-.27082
G1 X79.696 Y95.628 E-.10918
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X79.693 Y87.996 Z2.64 F18000
G1 X79.689 Y77.595 Z2.64
G1 Z2.24
G1 E.4 F1800
; LINE_WIDTH: 0.105142
G1 F1500
M204 S6000
G1 X79.756 Y77.387 E.00086
; LINE_WIDTH: 0.156441
G1 X79.903 Y77.193 E.00159
G1 X80.026 Y77.08 E.00108
; LINE_WIDTH: 0.129448
G1 X80.224 Y76.991 E.00113
; LINE_WIDTH: 0.0897839
G1 X80.328 Y76.955 E.00035
; WIPE_START
G1 X80.224 Y76.991 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X87.083 Y80.341 Z2.64 F18000
G1 X99.634 Y86.471 Z2.64
G1 Z2.24
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X99.909 Y86.078 E.00944
G1 X100.213 Y86.291 E.0073
G1 X100.876 Y86.755 E.01591
G1 X100.601 Y87.148 E.00944
G1 X99.683 Y86.506 E.02203
M204 S10000
G1 X99.939 Y86.392 F18000
; FEATURE: Gap infill
; LINE_WIDTH: 0.0965125
G1 F1500
M204 S6000
G1 X100.571 Y86.834 E.00272
; CHANGE_LAYER
; Z_HEIGHT: 2.36
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F1500
G1 X99.939 Y86.392 E-.38
; WIPE_END
G1 E-.02 F1800
; layer num/total_layer_count: 19/49
; update layer progress
M73 L19
M991 S0 P18 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z2.64 I.01 J-1.217 P1  F18000
G1 X94.275 Y86.344 Z2.64
G1 Z2.36
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X94.931 Y86.344 E.01388
G1 X94.931 Y86.857 E.01086
G1 X94.275 Y86.857 E.01388
G1 X94.275 Y86.404 E.00959
; WIPE_START
M204 S6000
G1 X94.931 Y86.344 E-.12508
G1 X94.931 Y86.857 E-.09748
G1 X94.275 Y86.857 E-.12456
G1 X94.275 Y86.684 E-.03288
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X93.851 Y84.485 Z2.76 F18000
G1 Z2.36
G1 E.4 F1800
G1 F1500
M204 S500
G1 X93.851 Y77.127 E.15573
G1 X94.029 Y77.071 E.00395
G1 X94.092 Y77.162 E.00234
G1 X94.157 Y77.3 E.00324
G1 X94.197 Y77.448 E.00324
G1 X94.212 Y77.628 E.00382
G1 X94.212 Y85.92 E.17551
G1 X95.355 Y85.92 E.02418
G1 X95.355 Y87.282 E.02882
G1 X94.212 Y87.282 E.02418
G1 X94.212 Y88.382 E.02328
G1 X93.851 Y88.382 E.00765
G1 X93.851 Y84.545 E.08121
; WIPE_START
M204 S6000
G1 X93.851 Y82.545 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X93.869 Y90.177 Z2.76 F18000
G1 X93.882 Y95.465 Z2.76
G1 Z2.36
G1 E.4 F1800
G1 F1500
M204 S500
G1 X93.899 Y95.423 E.00097
G1 X93.968 Y95.362 E.00195
G1 X94.16 Y95.318 E.00417
G1 X94.185 Y95.538 E.00468
G1 X94.105 Y95.634 E.00265
G1 X93.858 Y95.743 E.00571
G1 X93.877 Y95.525 E.00463
; WIPE_START
M204 S6000
G1 X93.899 Y95.423 E-.03234
G1 X93.968 Y95.362 E-.02849
G1 X94.16 Y95.318 E-.06093
G1 X94.185 Y95.538 E-.06844
G1 X94.105 Y95.634 E-.03876
G1 X93.858 Y95.743 E-.08346
G1 X93.877 Y95.525 E-.0676
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X88.045 Y97.099 Z2.76 F18000
G1 Z2.36
G1 E.4 F1800
G1 F1500
M204 S500
G1 X87.598 Y96.954 E.00995
G1 X87.225 Y96.88 E.00804
G1 X86.695 Y96.856 E.01123
G1 X86.153 Y96.93 E.01157
G1 X85.597 Y97.11 E.01237
G1 X85.491 Y96.949 E.0041
G1 X85.842 Y96.544 E.01135
G1 X87.806 Y96.544 E.04155
G1 X88.151 Y96.936 E.01106
G1 X88.078 Y97.049 E.00284
; WIPE_START
M204 S6000
G1 X87.598 Y96.954 E-.09294
G1 X87.225 Y96.88 E-.07221
G1 X86.695 Y96.856 E-.10081
G1 X86.153 Y96.93 E-.10386
G1 X86.102 Y96.946 E-.01019
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X88.969 Y101.412 Z2.76 F18000
G1 Z2.36
G1 E.4 F1800
G1 F1500
M204 S500
G1 X88.699 Y101.741 E.009
G1 X88.341 Y102.045 E.00995
G1 X87.93 Y102.282 E.01004
G1 X87.449 Y102.447 E.01077
G1 X87.181 Y102.498 E.00577
G1 X86.871 Y102.521 E.00659
G1 X86.56 Y102.507 E.00658
G1 X86.291 Y102.464 E.00578
G1 X85.805 Y102.314 E.01076
G1 X85.387 Y102.089 E.01004
G1 X85.02 Y101.796 E.00995
G1 X84.711 Y101.442 E.00995
G1 X84.467 Y101.035 E.01004
G1 X84.295 Y100.556 E.01076
G1 X84.24 Y100.289 E.00577
G1 X84.212 Y99.97 E.00679
G1 X84.239 Y99.51 E.00975
G1 X84.348 Y99.063 E.00975
G1 X84.47 Y98.766 E.00678
G1 X84.601 Y98.527 E.00577
G1 X84.907 Y98.121 E.01076
G1 X85.252 Y97.809 E.00984
G1 X85.521 Y97.632 E.00683
G1 X85.81 Y97.487 E.00683
G1 X86.248 Y97.345 E.00975
G1 X86.714 Y97.282 E.00995
G1 X87.174 Y97.302 E.00975
G1 X87.491 Y97.365 E.00683
G1 X87.798 Y97.465 E.00683
G1 X88.21 Y97.671 E.00975
G1 X88.578 Y97.947 E.00975
G1 X88.805 Y98.177 E.00683
G1 X89.002 Y98.432 E.00683
G1 X89.222 Y98.826 E.00955
G1 X89.336 Y99.129 E.00683
G1 X89.412 Y99.442 E.00683
G1 X89.453 Y99.901 E.00975
G1 X89.411 Y100.373 E.01004
G1 X89.269 Y100.862 E.01076
G1 X89.156 Y101.11 E.00577
G1 X89.004 Y101.364 E.00627
M204 S250
G1 X88.653 Y101.152 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X88.407 Y101.452 E.00764
G1 X88.104 Y101.709 E.00779
G1 X87.76 Y101.908 E.00782
G1 X87.344 Y102.05 E.00865
G1 X87.128 Y102.091 E.00433
G1 X86.865 Y102.111 E.00519
G1 X86.601 Y102.099 E.00518
G1 X86.384 Y102.065 E.00433
G1 X85.964 Y101.935 E.00864
G1 X85.614 Y101.746 E.00782
G1 X85.304 Y101.499 E.0078
G1 X85.043 Y101.2 E.0078
G1 X84.839 Y100.859 E.00783
G1 X84.69 Y100.445 E.00864
G1 X84.646 Y100.23 E.00433
G1 X84.622 Y99.964 E.00525
G1 X84.645 Y99.571 E.00774
G1 X84.739 Y99.189 E.00773
G1 X84.84 Y98.943 E.00525
G1 X84.946 Y98.749 E.00433
G1 X85.21 Y98.398 E.00864
G1 X85.503 Y98.134 E.00776
G1 X85.726 Y97.987 E.00526
G1 X85.966 Y97.867 E.00526
G1 X86.34 Y97.746 E.00773
G1 X86.732 Y97.692 E.0078
G1 X87.125 Y97.71 E.00773
G1 X87.388 Y97.762 E.00526
G1 X87.642 Y97.844 E.00526
G1 X87.994 Y98.02 E.00774
G1 X88.308 Y98.256 E.00773
G1 X88.496 Y98.447 E.00526
G1 X88.66 Y98.658 E.00526
G1 X88.85 Y98.999 E.00767
G1 X88.944 Y99.249 E.00526
G1 X89.007 Y99.509 E.00526
G1 X89.042 Y99.901 E.00773
G1 X89.007 Y100.297 E.00782
G1 X88.884 Y100.719 E.00865
G1 X88.793 Y100.92 E.00433
G1 X88.685 Y101.101 E.00416
; WIPE_START
M204 S6000
G1 X88.407 Y101.452 E-.0851
G1 X88.104 Y101.709 E-.07529
G1 X87.76 Y101.908 E-.07557
G1 X87.344 Y102.05 E-.08353
G1 X87.128 Y102.091 E-.04186
G1 X87.03 Y102.099 E-.01865
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X88.058 Y96.12 Z2.76 F18000
G1 Z2.36
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X93.399 Y96.12 E.11304
G1 X93.463 Y95.392 E.01548
G1 X93.515 Y95.242 E.00336
G1 X93.565 Y95.159 E.00204
G1 X93.643 Y95.074 E.00244
G1 X93.744 Y95 E.00265
G1 X93.843 Y94.955 E.00231
G1 X94.26 Y94.86 E.00905
G1 X97.773 Y89.843 E.12963
G1 X98.069 Y90.05 E.00765
G1 X94.558 Y95.064 E.12954
G1 X94.61 Y95.518 E.00968
G1 X94.583 Y95.679 E.00344
G1 X94.475 Y95.873 E.00471
G1 X94.31 Y96.008 E.00451
G1 X94.079 Y96.109 E.00536
G1 X93.852 Y96.308 E.00638
G1 X93.723 Y96.387 E.00321
G1 X93.582 Y96.443 E.00321
G1 X93.441 Y96.472 E.00304
G1 X88.319 Y96.485 E.10841
G1 X89.462 Y97.78 E.03655
G1 X89.73 Y98.162 E.00987
G1 X89.919 Y98.526 E.00869
G1 X90.06 Y98.901 E.00849
G1 X90.156 Y99.291 E.00849
G1 X90.206 Y99.699 E.00869
G1 X90.195 Y100.216 E.01096
G1 X90.161 Y100.485 E.00574
G1 X90.067 Y100.879 E.00858
G1 X89.928 Y101.256 E.0085
G1 X89.741 Y101.622 E.00869
G1 X89.39 Y102.11 E.01274
G1 X89.122 Y102.387 E.00815
G1 X88.872 Y102.593 E.00686
G1 X88.462 Y102.861 E.01036
G1 X88.104 Y103.032 E.0084
G1 X87.715 Y103.164 E.00869
G1 X87.132 Y103.267 E.01254
G1 X86.731 Y103.279 E.00849
G1 X86.332 Y103.243 E.00849
G1 X85.93 Y103.159 E.00869
G1 X85.453 Y102.985 E.01075
G1 X85.021 Y102.754 E.01037
G1 X84.699 Y102.522 E.0084
G1 X84.403 Y102.251 E.00849
G1 X84.141 Y101.947 E.00849
G1 X83.918 Y101.613 E.00849
G1 X83.662 Y101.077 E.01258
G1 X83.566 Y100.767 E.00686
G1 X83.474 Y100.286 E.01037
G1 X83.452 Y99.89 E.0084
G1 X83.477 Y99.49 E.00849
G1 X83.549 Y99.095 E.00849
G1 X83.668 Y98.711 E.0085
G1 X83.831 Y98.345 E.00849
G1 X84.149 Y97.845 E.01253
G1 X85.335 Y96.482 E.03825
G1 X80.368 Y96.482 E.10513
G1 X80.12 Y96.453 E.00527
G1 X79.975 Y96.405 E.00324
G1 X79.723 Y96.233 E.00646
G1 X79.575 Y96.048 E.00501
G1 X79.481 Y95.821 E.0052
G1 X79.451 Y95.565 E.00546
G1 X79.451 Y77.628 E.37965
G1 X79.487 Y77.357 E.00578
G1 X79.592 Y77.125 E.00539
G1 X79.693 Y76.998 E.00343
G1 X79.807 Y76.896 E.00324
G1 X80.025 Y76.777 E.00526
G1 X80.285 Y76.723 E.00562
G1 X93.335 Y76.721 E.27623
G1 X93.482 Y76.735 E.00311
G1 X93.632 Y76.775 E.0033
G1 X93.862 Y76.904 E.00556
G1 X93.805 Y77.082 E.00395
G1 X80.783 Y77.082 E.27564
G1 X80.513 Y77.125 E.00578
G1 X80.215 Y77.278 E.0071
G1 X79.978 Y77.529 E.0073
G1 X79.849 Y77.807 E.00649
G1 X79.812 Y78.056 E.00533
G1 X79.812 Y95.173 E.36231
G1 X79.897 Y95.529 E.00774
G1 X80.052 Y95.766 E.006
G1 X80.268 Y95.958 E.0061
G1 X80.538 Y96.084 E.0063
G1 X80.787 Y96.12 E.00533
G1 X87.998 Y96.12 E.15264
; WIPE_START
M204 S6000
G1 X89.998 Y96.12 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X89.224 Y96.892 Z2.76 F18000
G1 Z2.36
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X89.779 Y97.521 E.01651
G1 X89.966 Y97.771 E.00614
G1 X90.085 Y97.957 E.00434
G1 X90.293 Y98.359 E.00891
G1 X90.452 Y98.78 E.00885
G1 X90.559 Y99.217 E.00885
G1 X90.614 Y99.667 E.00891
G1 X90.621 Y99.886 E.00432
G1 X90.603 Y100.253 E.00722
G1 X90.564 Y100.559 E.00608
G1 X90.459 Y100.998 E.00888
G1 X90.303 Y101.42 E.00885
G1 X90.097 Y101.824 E.00891
G1 X89.981 Y102.009 E.0043
G1 X89.705 Y102.372 E.00898
G1 X89.396 Y102.692 E.00874
G1 X89.115 Y102.923 E.00715
G1 X88.663 Y103.218 E.01062
G1 X88.259 Y103.412 E.00882
G1 X87.829 Y103.557 E.00892
G1 X87.617 Y103.609 E.00431
G1 X87.169 Y103.676 E.00891
G1 X86.719 Y103.689 E.00885
G1 X86.271 Y103.649 E.00885
G1 X85.828 Y103.555 E.00891
G1 X85.618 Y103.491 E.00432
G1 X85.28 Y103.357 E.00715
M73 P57 R10
G1 X84.804 Y103.102 E.01062
G1 X84.44 Y102.84 E.00882
G1 X84.108 Y102.536 E.00885
G1 X83.815 Y102.195 E.00885
G1 X83.564 Y101.821 E.00885
G1 X83.358 Y101.417 E.00891
G1 X83.169 Y100.867 E.01146
G1 X83.067 Y100.336 E.01062
G1 X83.042 Y99.889 E.00882
G1 X83.07 Y99.44 E.00885
G1 X83.151 Y98.997 E.00885
G1 X83.284 Y98.567 E.00885
G1 X83.467 Y98.156 E.00885
G1 X83.7 Y97.767 E.00891
G1 X83.828 Y97.59 E.0043
G1 X84.436 Y96.891 E.01823
G1 X80.344 Y96.891 E.08049
G1 X80.031 Y96.854 E.00619
G1 X79.818 Y96.784 E.00442
G1 X79.692 Y96.72 E.00277
G1 X79.445 Y96.536 E.00607
G1 X79.296 Y96.369 E.00442
G1 X79.216 Y96.248 E.00283
G1 X79.119 Y96.039 E.00454
G1 X79.079 Y95.904 E.00276
G1 X79.042 Y95.589 E.00625
G1 X79.042 Y77.61 E.35362
G1 X79.062 Y77.374 E.00466
G1 X79.095 Y77.234 E.00283
G1 X79.181 Y77.019 E.00454
G1 X79.253 Y76.895 E.00283
G1 X79.394 Y76.716 E.00448
G1 X79.562 Y76.567 E.00442
G1 X79.756 Y76.447 E.00448
G1 X79.889 Y76.39 E.00285
G1 X80.08 Y76.337 E.00391
G1 X80.258 Y76.313 E.00353
G1 X93.355 Y76.312 E.2576
G1 X93.555 Y76.331 E.00394
G1 X93.773 Y76.389 E.00444
G1 X93.976 Y76.484 E.00442
G1 X94.16 Y76.613 E.00442
G1 X94.319 Y76.772 E.00442
G1 X94.448 Y76.956 E.00442
G1 X94.543 Y77.16 E.00442
G1 X94.601 Y77.377 E.00442
G1 X94.622 Y77.61 E.0046
G1 X94.622 Y85.511 E.1554
G1 X95.634 Y85.511 E.01991
G1 F1870.275
G1 X95.764 Y85.511 E.00256
G1 F1320
G1 X95.764 Y87.691 E.04288
G1 F1668.612
G1 X95.634 Y87.691 E.00256
G1 F1500
G1 X94.622 Y87.691 E.01991
G1 X94.622 Y88.791 E.02164
G1 X93.442 Y88.791 E.02321
G1 X93.442 Y77.491 E.22226
G1 X80.815 Y77.491 E.24835
G1 X80.642 Y77.518 E.00344
G1 X80.465 Y77.61 E.00393
G1 X80.321 Y77.762 E.00411
G1 X80.245 Y77.925 E.00355
G1 X80.222 Y78.086 E.00319
G1 X80.222 Y95.125 E.33516
G1 X80.278 Y95.365 E.00484
G1 X80.365 Y95.496 E.0031
G1 X80.495 Y95.612 E.00343
G1 X80.656 Y95.687 E.0035
G1 X80.816 Y95.711 E.00319
G1 X93.024 Y95.711 E.24011
G1 X93.058 Y95.326 E.00759
G1 X93.083 Y95.22 E.00214
G1 X93.147 Y95.058 E.00345
G1 X93.237 Y94.912 E.00336
G1 X93.368 Y94.768 E.00383
G1 X93.536 Y94.645 E.0041
G1 X93.712 Y94.566 E.00379
G1 X94.015 Y94.496 E.00612
G1 X97.672 Y89.273 E.12542
G1 X98.639 Y89.95 E.02321
G1 X94.982 Y95.172 E.12539
G1 X95.021 Y95.511 E.00673
G1 X94.976 Y95.796 E.00567
G1 X94.849 Y96.059 E.00574
G1 X94.653 Y96.27 E.00566
G1 X94.508 Y96.368 E.00344
G1 X94.301 Y96.459 E.00445
G1 X94.096 Y96.639 E.00538
G1 X93.906 Y96.755 E.00438
G1 X93.698 Y96.837 E.00438
G1 X93.483 Y96.881 E.00433
G1 X89.284 Y96.892 E.08259
; WIPE_START
M204 S6000
G1 X89.779 Y97.521 E-.15219
G1 X89.966 Y97.771 E-.05928
G1 X90.085 Y97.957 E-.04188
G1 X90.293 Y98.359 E-.08608
G1 X90.369 Y98.559 E-.04057
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




G1 X88.824 Y97.645
G1 Z2.36
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.396034
G1 F1500
M204 S6000
G1 X88.702 Y97.533 E.00307
; LINE_WIDTH: 0.429924
G1 X88.58 Y97.42 E.00335
; LINE_WIDTH: 0.465216
G1 X88.444 Y97.295 E.00405
G1 X88.118 Y97.374 E.00737
M204 S10000
G1 X88.824 Y97.645 F18000
; LINE_WIDTH: 0.360992
G1 F1500
M204 S6000
G1 X89.164 Y98.019 E.00844
G1 X89.399 Y98.357 E.00689
G1 X89.572 Y98.68 E.00614
G1 X89.697 Y99.014 E.00595
G1 X89.782 Y99.36 E.00596
G1 X89.822 Y99.724 E.00613
G1 X89.813 Y100.185 E.00771
G1 X89.779 Y100.459 E.00462
G1 X89.619 Y101.004 E.0095
G1 X89.411 Y101.428 E.0079
G1 X89.095 Y101.864 E.00901
G1 X88.864 Y102.103 E.00556
G1 X88.569 Y102.343 E.00637
G1 X88.1 Y102.617 E.00908
G1 X87.614 Y102.794 E.00865
G1 X87.221 Y102.871 E.0067
G1 X86.867 Y102.898 E.00595
G1 X86.39 Y102.866 E.00798
G1 X85.876 Y102.739 E.00886
G1 X85.613 Y102.641 E.00471
G1 X85.192 Y102.412 E.00801
G1 X84.771 Y102.078 E.00899
G1 X84.445 Y101.716 E.00815
G1 X84.249 Y101.419 E.00595
G1 X84.082 Y101.093 E.00613
G1 X83.934 Y100.67 E.00749
G1 X83.853 Y100.239 E.00733
G1 X83.834 Y99.891 E.00583
G1 X83.856 Y99.536 E.00595
G1 X83.923 Y99.187 E.00595
G1 X84.025 Y98.846 E.00595
G1 X84.133 Y98.595 E.00457
G1 X84.278 Y98.332 E.00501
G1 X84.618 Y97.878 E.00949
G1 X84.815 Y97.675 E.00473
; LINE_WIDTH: 0.400417
G1 X84.992 Y97.496 E.0047
; LINE_WIDTH: 0.438376
G1 X85.199 Y97.319 E.00562
; LINE_WIDTH: 0.477102
G1 X85.379 Y97.165 E.00534
; WIPE_START
G1 X85.199 Y97.319 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X80.315 Y96.239 Z2.76 F18000
G1 Z2.36
G1 E.4 F1800
; LINE_WIDTH: 0.105492
G1 F1500
M204 S6000
G1 X80.116 Y96.175 E.00083
; LINE_WIDTH: 0.15065
G1 X79.849 Y95.953 E.00217
G1 X79.676 Y95.659 E.00213
; WIPE_START
G1 X79.849 Y95.953 E-.18825
G1 X80.116 Y96.175 E-.19175
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X87.749 Y96.157 Z2.76 F18000
G1 X93.61 Y96.144 Z2.76
G1 Z2.36
G1 E.4 F1800
; LINE_WIDTH: 0.109816
G1 F1500
M204 S6000
G1 X93.837 Y96.009 E.00111
; WIPE_START
G1 X93.61 Y96.144 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X94.309 Y88.543 Z2.76 F18000
G1 X94.487 Y86.601 Z2.76
G1 Z2.36
G1 E.4 F1800
; LINE_WIDTH: 0.114562
G1 F1500
M204 S6000
G1 X94.719 Y86.601 E.00102
; WIPE_START
G1 X94.487 Y86.601 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X88.18 Y82.303 Z2.76 F18000
G1 X80.333 Y76.955 Z2.76
G1 Z2.36
G1 E.4 F1800
; LINE_WIDTH: 0.0810283
G1 F1500
M204 S6000
G1 X80.302 Y76.963 E.00009
; LINE_WIDTH: 0.0956089
G1 X80.208 Y76.996 E.00035
; LINE_WIDTH: 0.127694
G1 X80.046 Y77.068 E.00091
; LINE_WIDTH: 0.156114
G1 X79.902 Y77.194 E.00124
G1 X79.756 Y77.387 E.00158
; LINE_WIDTH: 0.105131
G1 X79.689 Y77.595 E.00086
; WIPE_START
G1 X79.756 Y77.387 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X86.698 Y80.56 Z2.76 F18000
G1 X99.634 Y86.471 Z2.76
G1 Z2.36
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X99.909 Y86.078 E.00944
G1 X100.24 Y86.309 E.00793
G1 X100.876 Y86.755 E.01528
G1 X100.601 Y87.148 E.00944
G1 X99.683 Y86.506 E.02203
M204 S10000
G1 X99.939 Y86.392 F18000
; FEATURE: Gap infill
; LINE_WIDTH: 0.0965116
G1 F1500
M204 S6000
G1 X100.571 Y86.834 E.00272
; CHANGE_LAYER
; Z_HEIGHT: 2.48
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F1500
G1 X99.939 Y86.392 E-.38
; WIPE_END
G1 E-.02 F1800
; layer num/total_layer_count: 20/49
; update layer progress
M73 L20
M991 S0 P19 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z2.76 I.01 J-1.217 P1  F18000
G1 X94.275 Y86.344 Z2.76
G1 Z2.48
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X95.102 Y86.344 E.0175
G1 X95.102 Y86.857 E.01086
G1 X94.275 Y86.857 E.0175
G1 X94.275 Y86.404 E.00959
; WIPE_START
M204 S6000
G1 X95.102 Y86.344 E-.15753
G1 X95.102 Y86.857 E-.09748
G1 X94.444 Y86.857 E-.12499
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X93.851 Y84.507 Z2.88 F18000
G1 Z2.48
G1 E.4 F1800
G1 F1500
M204 S500
G1 X93.851 Y77.127 E.15619
G1 X94.029 Y77.071 E.00395
G1 X94.092 Y77.162 E.00234
G1 X94.157 Y77.3 E.00324
G1 X94.197 Y77.448 E.00324
G1 X94.212 Y77.628 E.00382
G1 X94.212 Y85.92 E.17551
G1 X95.526 Y85.92 E.02781
G1 X95.526 Y87.282 E.02882
G1 X94.212 Y87.282 E.02781
G1 X94.212 Y88.382 E.02328
G1 X93.851 Y88.382 E.00765
G1 X93.851 Y84.567 E.08075
; WIPE_START
M204 S6000
G1 X93.851 Y82.567 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X93.869 Y90.199 Z2.88 F18000
G1 X93.881 Y95.474 Z2.88
G1 Z2.48
G1 E.4 F1800
G1 F1500
M204 S500
G1 X93.893 Y95.432 E.00093
G1 X93.956 Y95.365 E.00196
G1 X94.159 Y95.318 E.00441
G1 X94.188 Y95.521 E.00435
G1 X94.142 Y95.61 E.0021
G1 X93.858 Y95.743 E.00665
G1 X93.876 Y95.534 E.00444
; WIPE_START
M204 S6000
G1 X93.893 Y95.432 E-.03195
G1 X93.956 Y95.365 E-.0285
G1 X94.159 Y95.318 E-.06416
G1 X94.188 Y95.521 E-.0633
G1 X94.142 Y95.61 E-.03062
G1 X93.858 Y95.743 E-.09683
G1 X93.876 Y95.534 E-.06464
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X88.066 Y97.128 Z2.88 F18000
G1 Z2.48
G1 E.4 F1800
G1 F1500
M204 S500
G1 X87.773 Y97.002 E.00674
G1 X87.241 Y96.881 E.01156
G1 X86.695 Y96.856 E.01156
G1 X86.153 Y96.93 E.01157
G1 X85.597 Y97.11 E.01238
G1 X85.49 Y96.949 E.0041
G1 X85.842 Y96.544 E.01135
G1 X87.821 Y96.544 E.04188
G1 X88.186 Y96.964 E.01176
G1 X88.102 Y97.079 E.00302
; WIPE_START
M204 S6000
G1 X87.773 Y97.002 E-.06407
G1 X87.241 Y96.881 E-.10382
G1 X86.695 Y96.856 E-.10378
G1 X86.153 Y96.93 E-.10385
G1 X86.131 Y96.937 E-.00448
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X88.97 Y101.412 Z2.88 F18000
G1 Z2.48
G1 E.4 F1800
G1 F1500
M204 S500
G1 X88.699 Y101.741 E.00901
G1 X88.341 Y102.045 E.00995
G1 X87.934 Y102.28 E.00994
G1 X87.5 Y102.435 E.00975
G1 X87.183 Y102.498 E.00683
G1 X86.855 Y102.522 E.00696
G1 X86.312 Y102.471 E.01155
G1 X85.805 Y102.314 E.01123
G1 X85.387 Y102.089 E.01004
G1 X85.02 Y101.796 E.00995
G1 X84.711 Y101.442 E.00995
G1 X84.467 Y101.035 E.01004
G1 X84.288 Y100.535 E.01123
G1 X84.211 Y99.986 E.01175
M73 P58 R10
G1 X84.24 Y99.504 E.01021
G1 X84.382 Y98.967 E.01175
G1 X84.619 Y98.493 E.01123
G1 X84.912 Y98.114 E.01014
G1 X85.312 Y97.765 E.01123
G1 X85.795 Y97.492 E.01175
G1 X86.248 Y97.345 E.01008
G1 X86.714 Y97.282 E.00995
G1 X87.183 Y97.303 E.00995
G1 X87.642 Y97.407 E.00995
G1 X88.063 Y97.588 E.0097
G1 X88.294 Y97.728 E.00571
G1 X88.582 Y97.95 E.0077
G1 X88.805 Y98.177 E.00673
G1 X89.002 Y98.432 E.00683
G1 X89.222 Y98.826 E.00955
G1 X89.336 Y99.128 E.00683
G1 X89.412 Y99.442 E.00683
G1 X89.454 Y99.905 E.00984
G1 X89.399 Y100.433 E.01123
G1 X89.23 Y100.962 E.01175
G1 X89.005 Y101.364 E.00975
M204 S250
G1 X88.654 Y101.152 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X88.407 Y101.452 E.00765
G1 X88.104 Y101.709 E.0078
G1 X87.761 Y101.907 E.00779
G1 X87.391 Y102.04 E.00774
G1 X87.128 Y102.091 E.00526
G1 X86.859 Y102.111 E.0053
G1 X86.393 Y102.067 E.00922
G1 X85.964 Y101.935 E.00882
G1 X85.614 Y101.746 E.00783
G1 X85.304 Y101.499 E.00779
G1 X85.043 Y101.2 E.0078
G1 X84.839 Y100.859 E.00783
G1 X84.687 Y100.437 E.00882
G1 X84.622 Y99.969 E.00929
G1 X84.646 Y99.569 E.00788
G1 X84.767 Y99.113 E.00929
G1 X84.968 Y98.712 E.00882
G1 X85.212 Y98.396 E.00786
G1 X85.549 Y98.101 E.00882
G1 X85.961 Y97.869 E.00929
G1 X86.34 Y97.746 E.00784
G1 X86.732 Y97.692 E.0078
G1 X87.128 Y97.71 E.00779
G1 X87.515 Y97.798 E.00779
G1 X87.876 Y97.952 E.00772
G1 X88.062 Y98.066 E.00428
G1 X88.31 Y98.257 E.00616
G1 X88.496 Y98.447 E.00523
G1 X88.66 Y98.658 E.00526
G1 X88.85 Y98.999 E.00767
G1 X88.944 Y99.249 E.00526
G1 X89.007 Y99.509 E.00526
G1 X89.043 Y99.902 E.00776
G1 X88.996 Y100.349 E.00882
G1 X88.852 Y100.798 E.00929
G1 X88.684 Y101.1 E.0068
; WIPE_START
M204 S6000
G1 X88.407 Y101.452 E-.08516
G1 X88.104 Y101.709 E-.07533
G1 X87.761 Y101.907 E-.07526
G1 X87.391 Y102.04 E-.07472
G1 X87.128 Y102.091 E-.05085
G1 X87.03 Y102.099 E-.01868
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X88.075 Y96.12 Z2.88 F18000
G1 Z2.48
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X93.399 Y96.12 E.11269
G1 X93.462 Y95.401 E.01529
G1 X93.49 Y95.295 E.00232
G1 X93.563 Y95.164 E.00317
G1 X93.667 Y95.053 E.00321
G1 X93.844 Y94.955 E.0043
G1 X94.26 Y94.86 E.00903
G1 X97.773 Y89.843 E.12963
G1 X98.069 Y90.05 E.00765
G1 X94.552 Y95.072 E.12977
G1 X94.61 Y95.479 E.0087
G1 X94.598 Y95.618 E.00295
G1 X94.502 Y95.837 E.00506
G1 X94.397 Y95.949 E.00325
G1 X94.31 Y96.008 E.00223
G1 X94.079 Y96.109 E.00535
G1 X93.852 Y96.308 E.00638
G1 X93.723 Y96.387 E.00321
G1 X93.581 Y96.443 E.00321
G1 X93.441 Y96.472 E.00304
G1 X88.332 Y96.485 E.10814
G1 X89.509 Y97.838 E.03795
G1 X89.736 Y98.172 E.00854
G1 X89.998 Y98.716 E.01279
G1 X90.158 Y99.3 E.01281
G1 X90.211 Y99.892 E.01258
G1 X90.161 Y100.485 E.0126
G1 X90.067 Y100.879 E.00858
G1 X89.846 Y101.43 E.01254
G1 X89.639 Y101.783 E.00868
G1 X89.39 Y102.11 E.0087
G1 X89.272 Y102.24 E.00372
G1 X88.868 Y102.596 E.01139
G1 X88.462 Y102.861 E.01026
G1 X88.104 Y103.032 E.00839
G1 X87.715 Y103.164 E.00869
G1 X87.132 Y103.267 E.01254
G1 X86.731 Y103.279 E.00849
G1 X86.332 Y103.243 E.00849
G1 X85.93 Y103.159 E.00869
G1 X85.375 Y102.951 E.01254
G1 X85.024 Y102.757 E.00849
G1 X84.698 Y102.522 E.0085
G1 X84.403 Y102.251 E.00849
G1 X84.141 Y101.947 E.00849
G1 X83.918 Y101.613 E.0085
G1 X83.738 Y101.262 E.00836
G1 X83.566 Y100.762 E.01119
G1 X83.474 Y100.286 E.01026
G1 X83.452 Y99.89 E.00839
G1 X83.477 Y99.49 E.00849
G1 X83.549 Y99.095 E.00849
G1 X83.666 Y98.718 E.00836
G1 X83.891 Y98.239 E.01119
G1 X84.158 Y97.834 E.01026
G1 X85.335 Y96.482 E.03795
G1 X80.368 Y96.482 E.10513
G1 X80.129 Y96.454 E.00508
G1 X79.856 Y96.34 E.00626
G1 X79.647 Y96.151 E.00597
G1 X79.57 Y96.039 E.00288
G1 X79.48 Y95.815 E.00511
G1 X79.451 Y95.565 E.00533
G1 X79.451 Y77.628 E.37965
G1 X79.487 Y77.355 E.00584
G1 X79.595 Y77.122 E.00543
G1 X79.792 Y76.908 E.00616
G1 X80.031 Y76.775 E.00578
G1 X80.281 Y76.723 E.00539
G1 X93.337 Y76.721 E.27635
G1 X93.481 Y76.735 E.00307
G1 X93.632 Y76.775 E.0033
G1 X93.862 Y76.904 E.00556
G1 X93.805 Y77.082 E.00395
G1 X80.778 Y77.082 E.27575
G1 X80.489 Y77.132 E.0062
G1 X80.215 Y77.28 E.00658
G1 X79.993 Y77.509 E.00676
G1 X79.85 Y77.801 E.00689
G1 X79.812 Y78.056 E.00545
G1 X79.812 Y95.173 E.3623
G1 X79.899 Y95.539 E.00795
G1 X80.08 Y95.798 E.00669
G1 X80.276 Y95.962 E.00542
G1 X80.538 Y96.084 E.0061
G1 X80.787 Y96.12 E.00533
G1 X88.015 Y96.12 E.153
; WIPE_START
M204 S6000
G1 X90.015 Y96.12 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X89.228 Y96.892 Z2.88 F18000
G1 Z2.48
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X89.833 Y97.588 E.01813
G1 X90.087 Y97.96 E.00887
G1 X90.254 Y98.278 E.00706
G1 X90.451 Y98.777 E.01056
G1 X90.56 Y99.22 E.00897
G1 X90.593 Y99.437 E.00431
G1 X90.621 Y99.889 E.00892
G1 X90.604 Y100.248 E.00707
G1 X90.564 Y100.559 E.00617
G1 X90.459 Y100.998 E.00888
G1 X90.302 Y101.423 E.00891
G1 X90.209 Y101.621 E.00431
G1 X89.979 Y102.012 E.00891
G1 X89.705 Y102.372 E.00892
G1 X89.559 Y102.532 E.00426
G1 X89.116 Y102.922 E.0116
G1 X88.663 Y103.218 E.01065
G1 X88.259 Y103.412 E.00882
G1 X87.829 Y103.557 E.00891
G1 X87.617 Y103.609 E.00431
G1 X87.169 Y103.676 E.00891
G1 X86.719 Y103.689 E.00885
G1 X86.271 Y103.649 E.00885
G1 X85.828 Y103.555 E.00891
G1 X85.619 Y103.491 E.0043
G1 X85.199 Y103.321 E.00891
G1 X84.805 Y103.103 E.00885
G1 X84.44 Y102.84 E.00885
G1 X84.108 Y102.536 E.00885
G1 X83.815 Y102.195 E.00885
G1 X83.564 Y101.821 E.00885
G1 X83.361 Y101.422 E.00881
G1 X83.169 Y100.868 E.01153
G1 X83.067 Y100.336 E.01065
G1 X83.042 Y99.889 E.00882
G1 X83.07 Y99.44 E.00885
G1 X83.151 Y98.997 E.00885
G1 X83.284 Y98.569 E.00881
G1 X83.533 Y98.038 E.01154
G1 X83.831 Y97.586 E.01065
G1 X84.436 Y96.891 E.01813
G1 X80.344 Y96.891 E.08049
G1 X80.034 Y96.855 E.00613
G1 X79.748 Y96.75 E.006
G1 X79.626 Y96.68 E.00277
G1 X79.446 Y96.538 E.00451
G1 X79.326 Y96.406 E.0035
G1 X79.215 Y96.245 E.00385
G1 X79.137 Y96.084 E.00352
G1 X79.078 Y95.902 E.00376
G1 X79.042 Y95.589 E.00621
G1 X79.042 Y77.61 E.35362
G1 X79.062 Y77.374 E.00466
G1 X79.096 Y77.233 E.00285
G1 X79.167 Y77.049 E.00388
G1 X79.254 Y76.894 E.0035
G1 X79.394 Y76.716 E.00447
G1 X79.538 Y76.585 E.00382
G1 X79.686 Y76.485 E.0035
G1 X79.891 Y76.389 E.00445
G1 X80.111 Y76.33 E.00448
G1 X80.257 Y76.313 E.00289
G1 X93.357 Y76.312 E.25767
G1 X93.554 Y76.331 E.00391
G1 X93.773 Y76.389 E.00444
G1 X93.976 Y76.484 E.00442
G1 X94.16 Y76.613 E.00442
G1 X94.319 Y76.772 E.00442
G1 X94.448 Y76.956 E.00442
G1 X94.543 Y77.16 E.00442
G1 X94.601 Y77.377 E.00442
G1 X94.622 Y77.61 E.0046
G1 X94.622 Y85.511 E.1554
G1 X95.805 Y85.511 E.02328
G1 F1870.275
G1 X95.936 Y85.511 E.00256
G1 F1320
G1 X95.936 Y87.691 E.04288
G1 F1668.612
G1 X95.805 Y87.691 E.00256
G1 F1500
G1 X94.622 Y87.691 E.02328
G1 X94.622 Y88.791 E.02164
G1 X93.442 Y88.791 E.02321
G1 X93.442 Y77.491 E.22226
G1 X80.813 Y77.491 E.24839
G1 X80.625 Y77.524 E.00376
G1 X80.465 Y77.61 E.00358
G1 X80.332 Y77.747 E.00376
G1 X80.245 Y77.923 E.00386
G1 X80.222 Y78.086 E.00323
G1 X80.222 Y95.125 E.33516
G1 X80.279 Y95.368 E.00491
G1 X80.385 Y95.519 E.00362
G1 X80.498 Y95.614 E.00292
G1 X80.656 Y95.687 E.00343
G1 X80.816 Y95.711 E.00318
G1 X93.024 Y95.711 E.24012
G1 X93.057 Y95.329 E.00753
G1 X93.103 Y95.16 E.00344
G1 X93.236 Y94.914 E.00551
G1 X93.397 Y94.742 E.00463
G1 X93.534 Y94.646 E.0033
G1 X93.713 Y94.565 E.00386
G1 X94.015 Y94.496 E.0061
G1 X97.672 Y89.273 E.12542
G1 X98.639 Y89.95 E.02321
G1 X94.98 Y95.175 E.12546
G1 X95.019 Y95.563 E.00769
G1 X94.959 Y95.845 E.00567
G1 X94.848 Y96.06 E.00475
G1 X94.654 Y96.27 E.00561
G1 X94.508 Y96.368 E.00346
G1 X94.301 Y96.459 E.00444
G1 X94.096 Y96.639 E.00538
G1 X93.906 Y96.755 E.00438
G1 X93.698 Y96.837 E.00438
G1 X93.483 Y96.881 E.00432
G1 X89.288 Y96.892 E.08251
; WIPE_START
M204 S6000
G1 X89.833 Y97.588 E-.16792
G1 X90.087 Y97.96 E-.08564
G1 X90.254 Y98.278 E-.06823
G1 X90.367 Y98.563 E-.05821
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




G1 X88.831 Y97.651
G1 Z2.48
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.361242
G1 F1500
M204 S6000
G1 X89.206 Y98.071 E.00942
G1 X89.405 Y98.367 E.00597
G1 X89.642 Y98.857 E.00912
G1 X89.695 Y99.007 E.00266
G1 X89.779 Y99.369 E.00622
G1 X89.833 Y99.895 E.00885
G1 X89.812 Y100.178 E.00475
G1 X89.764 Y100.527 E.00589
G1 X89.579 Y101.096 E.01002
G1 X89.323 Y101.572 E.00905
G1 X89.095 Y101.864 E.00621
G1 X88.957 Y102.015 E.00342
G1 X88.544 Y102.36 E.009
G1 X88.105 Y102.615 E.0085
G1 X87.615 Y102.797 E.00876
G1 X87.224 Y102.871 E.00666
G1 X86.838 Y102.899 E.00648
G1 X86.388 Y102.863 E.00754
G1 X86.032 Y102.787 E.00611
G1 X85.646 Y102.653 E.00683
G1 X85.192 Y102.412 E.00861
G1 X84.771 Y102.078 E.009
G1 X84.445 Y101.716 E.00815
G1 X84.249 Y101.418 E.00596
G1 X84.09 Y101.112 E.00578
G1 X83.926 Y100.642 E.00833
G1 X83.857 Y100.239 E.00685
G1 X83.834 Y99.891 E.00583
G1 X83.871 Y99.428 E.00777
G1 X84.02 Y98.855 E.00992
G1 X84.225 Y98.426 E.00795
G1 X84.464 Y98.067 E.00722
G1 X84.649 Y97.844 E.00484
G1 X84.851 Y97.641 E.00481
; LINE_WIDTH: 0.413755
G1 X85.054 Y97.437 E.00556
; LINE_WIDTH: 0.438326
G1 X85.086 Y97.409 E.00088
; LINE_WIDTH: 0.468214
G1 X85.381 Y97.168 E.00841
; WIPE_START
G1 X85.086 Y97.409 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X88.297 Y97.172 Z2.88 F18000
G1 Z2.48
G1 E.4 F1800
; LINE_WIDTH: 0.473438
M73 P59 R10
G1 F1500
M204 S6000
G1 X88.528 Y97.366 E.00674
; LINE_WIDTH: 0.439468
G1 X88.688 Y97.517 E.00455
; LINE_WIDTH: 0.398507
G1 X88.831 Y97.651 E.00364
; WIPE_START
G1 X88.688 Y97.517 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X93.61 Y96.144 Z2.88 F18000
G1 Z2.48
G1 E.4 F1800
; LINE_WIDTH: 0.109712
G1 F1500
M204 S6000
G1 X93.837 Y96.009 E.0011
; WIPE_START
G1 X93.61 Y96.144 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X94.309 Y88.543 Z2.88 F18000
G1 X94.487 Y86.601 Z2.88
G1 Z2.48
G1 E.4 F1800
; LINE_WIDTH: 0.114562
G1 F1500
M204 S6000
G1 X94.89 Y86.601 E.00178
; WIPE_START
G1 X94.487 Y86.601 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X88.179 Y82.304 Z2.88 F18000
G1 X80.328 Y76.955 Z2.88
G1 Z2.48
G1 E.4 F1800
; LINE_WIDTH: 0.0897786
G1 F1500
M204 S6000
G1 X80.224 Y76.991 E.00035
; LINE_WIDTH: 0.129632
G1 X80.027 Y77.08 E.00112
; LINE_WIDTH: 0.156442
G1 X79.904 Y77.192 E.00108
G1 X79.77 Y77.362 E.00141
; LINE_WIDTH: 0.122129
G1 X79.721 Y77.482 E.00063
; LINE_WIDTH: 0.0966535
G1 X79.689 Y77.597 E.00042
; WIPE_START
G1 X79.721 Y77.482 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X79.703 Y85.115 Z2.88 F18000
G1 X79.678 Y95.672 Z2.88
G1 Z2.48
G1 E.4 F1800
; LINE_WIDTH: 0.153143
G1 F1500
M204 S6000
G1 X79.881 Y95.991 E.00241
G1 X80.042 Y96.127 E.00134
G1 X80.131 Y96.179 E.00065
; LINE_WIDTH: 0.10264
G1 X80.315 Y96.239 E.00074
; WIPE_START
G1 X80.131 Y96.179 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X86.964 Y92.778 Z2.88 F18000
G1 X99.634 Y86.471 Z2.88
G1 Z2.48
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X99.909 Y86.078 E.00944
G1 X100.266 Y86.328 E.00856
G1 X100.876 Y86.755 E.01465
G1 X100.601 Y87.148 E.00944
G1 X99.683 Y86.506 E.02203
M204 S10000
G1 X99.939 Y86.392 F18000
; FEATURE: Gap infill
; LINE_WIDTH: 0.0965118
G1 F1500
M204 S6000
G1 X100.571 Y86.834 E.00272
; CHANGE_LAYER
; Z_HEIGHT: 2.6
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F1500
G1 X99.939 Y86.392 E-.38
; WIPE_END
G1 E-.02 F1800
; layer num/total_layer_count: 21/49
; update layer progress
M73 L21
M991 S0 P20 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z2.88 I.01 J-1.217 P1  F18000
G1 X94.275 Y86.344 Z2.88
G1 Z2.6
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X95.273 Y86.344 E.02113
G1 X95.273 Y86.857 E.01086
G1 X94.275 Y86.857 E.02113
G1 X94.275 Y86.404 E.00959
; WIPE_START
M204 S6000
G1 X95.273 Y86.344 E-.19002
G1 X95.273 Y86.857 E-.09748
G1 X94.787 Y86.857 E-.0925
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X93.851 Y84.415 Z3 F18000
G1 Z2.6
G1 E.4 F1800
G1 F1500
M204 S500
G1 X93.851 Y77.127 E.15426
G1 X94.029 Y77.071 E.00395
G1 X94.092 Y77.162 E.00234
G1 X94.157 Y77.3 E.00324
G1 X94.197 Y77.448 E.00324
G1 X94.212 Y77.628 E.00382
G1 X94.212 Y85.92 E.17551
G1 X95.698 Y85.92 E.03144
G1 X95.698 Y87.282 E.02882
G1 X94.212 Y87.282 E.03144
G1 X94.212 Y88.382 E.02328
G1 X93.851 Y88.382 E.00765
G1 X93.851 Y84.475 E.08268
; WIPE_START
M204 S6000
G1 X93.851 Y82.475 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X93.869 Y90.108 Z3 F18000
G1 X93.881 Y95.474 Z3
G1 Z2.6
G1 E.4 F1800
G1 F1500
M204 S500
G1 X93.893 Y95.432 E.00093
G1 X93.956 Y95.364 E.00195
G1 X94.158 Y95.318 E.00438
G1 X94.184 Y95.485 E.00356
G1 X94.185 Y95.526 E.00088
G1 X94.142 Y95.609 E.00198
G1 X93.858 Y95.743 E.00665
G1 X93.876 Y95.534 E.00445
; WIPE_START
M204 S6000
G1 X93.893 Y95.432 E-.03197
G1 X93.956 Y95.364 E-.02844
G1 X94.158 Y95.318 E-.06396
G1 X94.184 Y95.485 E-.05195
G1 X94.185 Y95.526 E-.01281
G1 X94.142 Y95.609 E-.02892
G1 X93.858 Y95.743 E-.09706
G1 X93.876 Y95.534 E-.0649
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X87.991 Y97.081 Z3 F18000
G1 Z2.6
G1 E.4 F1800
G1 F1500
M204 S500
G1 X87.598 Y96.953 E.00874
G1 X87.225 Y96.88 E.00804
G1 X86.695 Y96.856 E.01123
G1 X86.153 Y96.93 E.01157
G1 X85.597 Y97.11 E.01237
G1 X85.49 Y96.949 E.0041
G1 X85.842 Y96.544 E.01135
G1 X87.754 Y96.544 E.04046
G1 X88.097 Y96.916 E.0107
G1 X88.023 Y97.031 E.00289
; WIPE_START
M204 S6000
G1 X87.598 Y96.953 E-.0821
G1 X87.225 Y96.88 E-.07221
G1 X86.695 Y96.856 E-.1008
G1 X86.153 Y96.93 E-.10386
G1 X86.048 Y96.964 E-.02103
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X88.97 Y101.412 Z3 F18000
G1 Z2.6
G1 E.4 F1800
G1 F1500
M204 S500
G1 X88.699 Y101.741 E.00901
G1 X88.341 Y102.045 E.00995
G1 X87.934 Y102.28 E.00994
G1 X87.5 Y102.435 E.00975
G1 X87.183 Y102.498 E.00683
G1 X86.856 Y102.522 E.00696
G1 X86.315 Y102.471 E.0115
G1 X85.805 Y102.314 E.01128
G1 X85.387 Y102.089 E.01005
G1 X85.02 Y101.796 E.00995
G1 X84.711 Y101.442 E.00995
G1 X84.47 Y101.039 E.00995
G1 X84.308 Y100.607 E.00975
G1 X84.241 Y100.292 E.00683
G1 X84.212 Y99.97 E.00683
G1 X84.24 Y99.504 E.00988
G1 X84.381 Y98.97 E.0117
G1 X84.619 Y98.493 E.01128
G1 X84.91 Y98.118 E.01005
G1 X85.252 Y97.809 E.00975
G1 X85.521 Y97.632 E.00683
G1 X85.81 Y97.487 E.00683
G1 X86.248 Y97.345 E.00975
G1 X86.714 Y97.282 E.00995
G1 X87.174 Y97.302 E.00975
G1 X87.491 Y97.365 E.00683
G1 X87.798 Y97.465 E.00683
G1 X88.21 Y97.671 E.00975
G1 X88.578 Y97.947 E.00975
G1 X88.805 Y98.177 E.00683
G1 X89.002 Y98.432 E.00683
G1 X89.23 Y98.84 E.00988
G1 X89.398 Y99.366 E.0117
G1 X89.454 Y99.896 E.01128
G1 X89.411 Y100.369 E.01004
G1 X89.289 Y100.813 E.00975
G1 X89.157 Y101.108 E.00683
G1 X89.005 Y101.364 E.0063
M204 S250
G1 X88.654 Y101.152 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X88.407 Y101.452 E.00765
G1 X88.104 Y101.709 E.0078
G1 X87.761 Y101.907 E.00779
G1 X87.391 Y102.04 E.00774
G1 X87.128 Y102.091 E.00526
G1 X86.859 Y102.111 E.0053
G1 X86.395 Y102.068 E.00918
G1 X85.964 Y101.935 E.00887
G1 X85.614 Y101.746 E.00783
G1 X85.304 Y101.499 E.0078
G1 X85.043 Y101.2 E.00779
G1 X84.84 Y100.86 E.00779
G1 X84.702 Y100.492 E.00773
G1 X84.646 Y100.23 E.00526
G1 X84.622 Y99.964 E.00526
G1 X84.646 Y99.569 E.00778
G1 X84.766 Y99.115 E.00924
G1 X84.968 Y98.712 E.00887
G1 X85.211 Y98.397 E.00783
G1 X85.503 Y98.134 E.00774
G1 X85.726 Y97.987 E.00526
G1 X85.966 Y97.867 E.00526
G1 X86.34 Y97.746 E.00773
G1 X86.732 Y97.692 E.0078
G1 X87.125 Y97.71 E.00773
G1 X87.388 Y97.762 E.00526
G1 X87.642 Y97.844 E.00526
G1 X87.994 Y98.02 E.00774
G1 X88.308 Y98.256 E.00773
G1 X88.496 Y98.447 E.00526
G1 X88.66 Y98.658 E.00526
G1 X88.852 Y99.003 E.00777
G1 X88.996 Y99.451 E.00924
G1 X89.043 Y99.899 E.00887
G1 X89.007 Y100.296 E.00783
G1 X88.902 Y100.675 E.00774
G1 X88.794 Y100.919 E.00526
G1 X88.685 Y101.101 E.00417
; WIPE_START
M204 S6000
G1 X88.407 Y101.452 E-.08517
G1 X88.104 Y101.709 E-.07532
G1 X87.761 Y101.907 E-.07527
G1 X87.391 Y102.04 E-.07472
G1 X87.128 Y102.091 E-.05085
G1 X87.03 Y102.099 E-.01867
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X88.002 Y96.12 Z3 F18000
G1 Z2.6
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X93.399 Y96.12 E.11424
G1 X93.462 Y95.401 E.01529
G1 X93.488 Y95.303 E.00213
G1 X93.556 Y95.17 E.00317
G1 X93.667 Y95.053 E.0034
G1 X93.845 Y94.955 E.00432
G1 X94.26 Y94.86 E.009
G1 X97.773 Y89.843 E.12964
G1 X98.069 Y90.05 E.00765
G1 X94.55 Y95.076 E.12987
G1 X94.608 Y95.449 E.00798
G1 X94.592 Y95.649 E.00424
G1 X94.504 Y95.833 E.00431
G1 X94.403 Y95.946 E.00321
G1 X94.31 Y96.008 E.00236
G1 X94.079 Y96.109 E.00535
G1 X93.852 Y96.308 E.00638
G1 X93.723 Y96.387 E.00321
G1 X93.582 Y96.443 E.00321
G1 X93.441 Y96.472 E.00304
G1 X88.277 Y96.485 E.1093
G1 X89.376 Y97.675 E.03428
G1 X89.632 Y98.008 E.00888
G1 X89.919 Y98.526 E.01254
G1 X90.06 Y98.901 E.00849
G1 X90.158 Y99.3 E.00869
G1 X90.211 Y99.892 E.01259
G1 X90.161 Y100.485 E.0126
G1 X90.066 Y100.882 E.00863
G1 X89.844 Y101.434 E.0126
G1 X89.528 Y101.94 E.01261
G1 X89.261 Y102.251 E.00869
G1 X88.958 Y102.529 E.00869
G1 X88.466 Y102.859 E.01254
G1 X88.104 Y103.032 E.0085
G1 X87.715 Y103.164 E.00869
G1 X87.132 Y103.267 E.01254
G1 X86.731 Y103.279 E.00849
G1 X86.332 Y103.243 E.00849
G1 X85.939 Y103.161 E.00849
G1 X85.559 Y103.032 E.00849
G1 X85.202 Y102.862 E.00837
G1 X84.765 Y102.572 E.01109
G1 X84.4 Y102.247 E.01036
G1 X84.141 Y101.947 E.00839
G1 X83.918 Y101.613 E.0085
G1 X83.738 Y101.262 E.00836
G1 X83.567 Y100.766 E.0111
G1 X83.474 Y100.286 E.01036
G1 X83.452 Y99.89 E.00839
G1 X83.477 Y99.49 E.00849
G1 X83.549 Y99.095 E.00849
G1 X83.666 Y98.717 E.00836
G1 X83.889 Y98.243 E.0111
G1 X84.158 Y97.834 E.01035
G1 X85.335 Y96.482 E.03795
G1 X80.368 Y96.482 E.10513
G1 X80.12 Y96.453 E.00527
G1 X79.975 Y96.405 E.00324
G1 X79.723 Y96.233 E.00646
G1 X79.575 Y96.048 E.00501
G1 X79.481 Y95.821 E.0052
G1 X79.451 Y95.565 E.00546
G1 X79.451 Y77.628 E.37965
G1 X79.487 Y77.355 E.00584
G1 X79.595 Y77.122 E.00543
G1 X79.791 Y76.908 E.00613
G1 X80.031 Y76.775 E.00581
G1 X80.281 Y76.723 E.00539
G1 X93.339 Y76.721 E.27638
G1 X93.481 Y76.735 E.00303
G1 X93.632 Y76.775 E.0033
G1 X93.862 Y76.904 E.00556
G1 X93.805 Y77.082 E.00395
G1 X80.778 Y77.082 E.27574
G1 X80.489 Y77.132 E.0062
G1 X80.215 Y77.28 E.00658
G1 X79.992 Y77.509 E.00677
G1 X79.85 Y77.801 E.00688
G1 X79.812 Y78.056 E.00545
G1 X79.812 Y95.177 E.36239
G1 X79.907 Y95.554 E.00822
G1 X80.083 Y95.8 E.0064
G1 X80.276 Y95.962 E.00534
G1 X80.538 Y96.084 E.0061
G1 X80.787 Y96.12 E.00533
G1 X87.942 Y96.12 E.15145
; WIPE_START
M204 S6000
G1 X89.942 Y96.12 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X89.21 Y96.892 Z3 F18000
G1 Z2.6
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X89.689 Y97.411 E.01389
G1 X89.967 Y97.772 E.00897
G1 X90.085 Y97.957 E.00431
G1 X90.293 Y98.359 E.00891
G1 X90.452 Y98.78 E.00885
G1 X90.56 Y99.22 E.00891
G1 X90.593 Y99.437 E.00431
G1 X90.621 Y99.889 E.00893
G1 X90.604 Y100.243 E.00697
G1 X90.564 Y100.559 E.00626
G1 X90.459 Y100.999 E.00889
G1 X90.339 Y101.332 E.00697
G1 X90.208 Y101.623 E.00627
G1 X89.977 Y102.014 E.00893
G1 X89.85 Y102.192 E.0043
G1 X89.555 Y102.536 E.00891
G1 X89.221 Y102.842 E.00891
G1 X89.048 Y102.975 E.0043
G1 X88.665 Y103.218 E.00891
G1 X88.259 Y103.412 E.00885
G1 X87.83 Y103.557 E.00891
G1 X87.617 Y103.608 E.0043
G1 X87.169 Y103.676 E.00891
G1 X86.719 Y103.689 E.00885
G1 X86.271 Y103.649 E.00885
G1 X85.831 Y103.556 E.00885
G1 X85.405 Y103.412 E.00885
G1 X85 Y103.219 E.00881
G1 X84.515 Y102.898 E.01144
G1 X84.107 Y102.535 E.01074
G1 X83.815 Y102.195 E.00882
M73 P59 R9
G1 X83.564 Y101.821 E.00885
G1 X83.361 Y101.422 E.00881
G1 X83.171 Y100.872 E.01145
G1 X83.067 Y100.336 E.01074
G1 X83.042 Y99.889 E.00882
G1 X83.07 Y99.44 E.00885
G1 X83.151 Y98.997 E.00885
G1 X83.284 Y98.569 E.00881
G1 X83.531 Y98.043 E.01145
G1 X83.831 Y97.587 E.01073
G1 X84.436 Y96.891 E.01814
G1 X80.344 Y96.891 E.08049
G1 X80.031 Y96.854 E.00619
G1 X79.818 Y96.784 E.00442
G1 X79.692 Y96.72 E.00277
G1 X79.445 Y96.536 E.00607
G1 X79.296 Y96.369 E.00442
G1 X79.216 Y96.248 E.00283
G1 X79.119 Y96.039 E.00454
G1 X79.079 Y95.904 E.00277
G1 X79.042 Y95.589 E.00625
G1 X79.042 Y77.61 E.35362
G1 X79.062 Y77.374 E.00466
G1 X79.096 Y77.233 E.00285
G1 X79.166 Y77.051 E.00385
G1 X79.254 Y76.894 E.00353
G1 X79.395 Y76.715 E.00447
G1 X79.537 Y76.586 E.00379
G1 X79.686 Y76.485 E.00353
G1 X79.891 Y76.389 E.00445
G1 X80.111 Y76.33 E.00448
G1 X80.257 Y76.313 E.00289
G1 X93.358 Y76.312 E.2577
G1 X93.554 Y76.331 E.00387
G1 X93.772 Y76.389 E.00444
G1 X93.976 Y76.484 E.00442
G1 X94.16 Y76.613 E.00442
G1 X94.319 Y76.772 E.00442
G1 X94.448 Y76.956 E.00442
G1 X94.543 Y77.16 E.00442
G1 X94.601 Y77.377 E.00442
G1 X94.622 Y77.61 E.0046
G1 X94.622 Y85.511 E.1554
G1 X95.977 Y85.511 E.02665
G1 F1870.275
G1 X96.107 Y85.511 E.00256
G1 F1320
G1 X96.107 Y87.691 E.04288
G1 F1668.612
G1 X95.977 Y87.691 E.00256
G1 F1500
G1 X94.622 Y87.691 E.02665
G1 X94.622 Y88.791 E.02164
G1 X93.442 Y88.791 E.02321
G1 X93.442 Y77.491 E.22226
G1 X80.813 Y77.491 E.24839
G1 X80.625 Y77.524 E.00376
G1 X80.465 Y77.61 E.00358
G1 X80.331 Y77.748 E.00377
G1 X80.245 Y77.924 E.00385
G1 X80.222 Y78.086 E.00322
G1 X80.222 Y95.127 E.33518
G1 X80.285 Y95.379 E.00511
G1 X80.385 Y95.519 E.0034
G1 X80.498 Y95.614 E.00289
G1 X80.656 Y95.687 E.00343
G1 X80.816 Y95.711 E.00319
G1 X93.024 Y95.711 E.24011
G1 X93.057 Y95.329 E.00753
G1 X93.102 Y95.163 E.00338
G1 X93.234 Y94.916 E.00551
G1 X93.397 Y94.742 E.00469
G1 X93.534 Y94.646 E.0033
G1 X93.714 Y94.565 E.00388
G1 X94.015 Y94.496 E.00607
G1 X97.672 Y89.273 E.12542
G1 X98.639 Y89.95 E.02321
G1 X94.979 Y95.176 E.12549
G1 X95.017 Y95.414 E.00475
G1 X95.019 Y95.564 E.00294
M73 P60 R9
G1 X94.992 Y95.741 E.00352
G1 X94.96 Y95.843 E.00211
G1 X94.848 Y96.059 E.00477
G1 X94.656 Y96.268 E.0056
G1 X94.508 Y96.368 E.0035
G1 X94.301 Y96.459 E.00444
G1 X94.096 Y96.639 E.00538
G1 X93.906 Y96.755 E.00438
G1 X93.698 Y96.837 E.00438
G1 X93.483 Y96.881 E.00433
G1 X89.27 Y96.892 E.08287
; WIPE_START
M204 S6000
G1 X89.689 Y97.411 E-.12678
G1 X89.967 Y97.772 E-.08665
G1 X90.085 Y97.957 E-.04159
G1 X90.293 Y98.359 E-.0861
G1 X90.366 Y98.551 E-.03889
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




G1 X88.823 Y97.647
G1 Z2.6
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.360678
G1 F1500
M204 S6000
G1 X89.085 Y97.92 E.00633
G1 X89.325 Y98.234 E.0066
G1 X89.574 Y98.682 E.00856
G1 X89.763 Y99.272 E.01036
G1 X89.832 Y99.91 E.01071
G1 X89.787 Y100.422 E.00859
G1 X89.64 Y100.952 E.00919
G1 X89.498 Y101.274 E.00587
G1 X89.294 Y101.613 E.00662
G1 X88.979 Y101.996 E.00828
G1 X88.571 Y102.346 E.00899
G1 X88.079 Y102.627 E.00947
G1 X87.611 Y102.793 E.00829
G1 X87.224 Y102.872 E.00661
G1 X86.838 Y102.899 E.00647
G1 X86.388 Y102.863 E.00754
G1 X86.041 Y102.789 E.00594
G1 X85.645 Y102.655 E.00698
G1 X85.194 Y102.408 E.0086
G1 X84.75 Y102.057 E.00946
G1 X84.445 Y101.716 E.00765
G1 X84.249 Y101.418 E.00595
G1 X84.09 Y101.112 E.00577
G1 X83.934 Y100.668 E.00786
G1 X83.853 Y100.239 E.00729
G1 X83.834 Y99.891 E.00582
G1 X83.871 Y99.428 E.00776
G1 X84.02 Y98.855 E.00991
G1 X84.224 Y98.43 E.00787
G1 X84.464 Y98.067 E.00728
G1 X84.817 Y97.673 E.00884
; LINE_WIDTH: 0.400584
G1 X84.992 Y97.496 E.00464
; LINE_WIDTH: 0.438377
G1 X85.199 Y97.319 E.00561
; LINE_WIDTH: 0.477097
G1 X85.379 Y97.165 E.00533
; WIPE_START
G1 X85.199 Y97.319 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X88.212 Y97.129 Z3 F18000
G1 Z2.6
G1 E.4 F1800
; LINE_WIDTH: 0.480631
G1 F1500
M204 S6000
G1 X88.454 Y97.314 E.0069
; LINE_WIDTH: 0.442834
G1 X88.638 Y97.48 E.00518
; LINE_WIDTH: 0.397662
G1 X88.823 Y97.647 E.00462
; WIPE_START
G1 X88.638 Y97.48 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X93.61 Y96.144 Z3 F18000
G1 Z2.6
G1 E.4 F1800
; LINE_WIDTH: 0.109748
G1 F1500
M204 S6000
G1 X93.837 Y96.009 E.0011
; WIPE_START
G1 X93.61 Y96.144 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X94.309 Y88.543 Z3 F18000
G1 X94.487 Y86.601 Z3
G1 Z2.6
G1 E.4 F1800
; LINE_WIDTH: 0.114562
G1 F1500
M204 S6000
G1 X95.061 Y86.601 E.00254
; WIPE_START
G1 X94.487 Y86.601 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X88.179 Y82.304 Z3 F18000
G1 X80.328 Y76.955 Z3
G1 Z2.6
G1 E.4 F1800
; LINE_WIDTH: 0.0897801
G1 F1500
M204 S6000
G1 X80.224 Y76.991 E.00035
; LINE_WIDTH: 0.129606
G1 X80.027 Y77.08 E.00112
; LINE_WIDTH: 0.15636
G1 X79.904 Y77.191 E.00108
G1 X79.769 Y77.363 E.00142
; LINE_WIDTH: 0.121966
G1 X79.721 Y77.482 E.00062
; LINE_WIDTH: 0.0965926
G1 X79.689 Y77.597 E.00042
; WIPE_START
G1 X79.721 Y77.482 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X79.702 Y85.115 Z3 F18000
G1 X79.676 Y95.667 Z3
G1 Z2.6
G1 E.4 F1800
; LINE_WIDTH: 0.15098
G1 F1500
M204 S6000
G1 X79.884 Y95.995 E.00242
G1 X80.13 Y96.18 E.00192
; LINE_WIDTH: 0.104104
G1 X80.315 Y96.239 E.00076
; WIPE_START
G1 X80.13 Y96.18 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X86.962 Y92.779 Z3 F18000
G1 X99.634 Y86.471 Z3
G1 Z2.6
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X99.909 Y86.078 E.00944
G1 X100.292 Y86.346 E.00919
G1 X100.876 Y86.755 E.01402
G1 X100.601 Y87.148 E.00944
G1 X99.683 Y86.506 E.02203
M204 S10000
G1 X99.939 Y86.392 F18000
; FEATURE: Gap infill
; LINE_WIDTH: 0.0965132
G1 F1500
M204 S6000
G1 X100.571 Y86.834 E.00272
; CHANGE_LAYER
; Z_HEIGHT: 2.72
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F1500
G1 X99.939 Y86.392 E-.38
; WIPE_END
G1 E-.02 F1800
; layer num/total_layer_count: 22/49
; update layer progress
M73 L22
M991 S0 P21 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z3 I.01 J-1.217 P1  F18000
G1 X94.275 Y86.344 Z3
G1 Z2.72
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X95.445 Y86.344 E.02476
G1 X95.445 Y86.857 E.01086
G1 X94.275 Y86.857 E.02476
G1 X94.275 Y86.404 E.00959
; WIPE_START
M204 S6000
G1 X95.445 Y86.344 E-.22254
G1 X95.445 Y86.857 E-.09748
G1 X95.129 Y86.857 E-.05999
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X93.851 Y84.48 Z3.12 F18000
G1 Z2.72
G1 E.4 F1800
G1 F1500
M204 S500
G1 X93.851 Y77.127 E.15564
G1 X94.029 Y77.071 E.00395
G1 X94.092 Y77.162 E.00234
G1 X94.157 Y77.3 E.00324
G1 X94.197 Y77.448 E.00324
G1 X94.212 Y77.628 E.00382
G1 X94.212 Y85.92 E.17551
G1 X95.869 Y85.92 E.03506
G1 X95.869 Y87.282 E.02882
G1 X94.212 Y87.282 E.03506
G1 X94.212 Y88.382 E.02328
G1 X93.851 Y88.382 E.00765
G1 X93.851 Y84.54 E.0813
; WIPE_START
M204 S6000
G1 X93.851 Y82.54 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X93.871 Y90.173 Z3.12 F18000
G1 X93.885 Y95.439 Z3.12
G1 Z2.72
G1 E.4 F1800
G1 F1500
M204 S500
G1 X93.939 Y95.379 E.00171
G1 X94.157 Y95.319 E.00478
G1 X94.183 Y95.468 E.0032
G1 X94.184 Y95.529 E.00128
G1 X94.142 Y95.609 E.00192
G1 X93.858 Y95.743 E.00665
G1 X93.879 Y95.499 E.00519
; WIPE_START
M204 S6000
G1 X93.939 Y95.379 E-.04155
G1 X94.157 Y95.319 E-.07031
G1 X94.183 Y95.468 E-.04701
G1 X94.184 Y95.529 E-.01877
G1 X94.142 Y95.609 E-.02828
G1 X93.858 Y95.743 E-.09779
G1 X93.879 Y95.499 E-.0763
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X88.041 Y97.098 Z3.12 F18000
G1 Z2.72
G1 E.4 F1800
G1 F1500
M204 S500
G1 X87.598 Y96.953 E.00987
G1 X87.225 Y96.88 E.00804
G1 X86.695 Y96.856 E.01123
G1 X86.153 Y96.93 E.01157
G1 X85.597 Y97.11 E.01238
G1 X85.491 Y96.949 E.0041
G1 X85.842 Y96.544 E.01135
G1 X87.802 Y96.544 E.04148
G1 X88.148 Y96.935 E.01104
G1 X88.074 Y97.047 E.00285
; WIPE_START
M204 S6000
G1 X87.598 Y96.953 E-.09228
G1 X87.225 Y96.88 E-.07221
G1 X86.695 Y96.856 E-.10081
G1 X86.153 Y96.93 E-.10383
G1 X86.099 Y96.947 E-.01088
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X88.97 Y101.412 Z3.12 F18000
G1 Z2.72
G1 E.4 F1800
G1 F1500
M204 S500
G1 X88.699 Y101.741 E.00901
G1 X88.336 Y102.049 E.01008
G1 X87.855 Y102.315 E.01164
G1 X87.343 Y102.473 E.01133
G1 X86.865 Y102.523 E.01018
G1 X86.317 Y102.472 E.01164
G1 X85.806 Y102.314 E.01133
G1 X85.387 Y102.089 E.01005
G1 X85.02 Y101.796 E.00995
G1 X84.711 Y101.442 E.00995
G1 X84.474 Y101.046 E.00975
G1 X84.352 Y100.748 E.00683
G1 X84.266 Y100.437 E.00683
G1 X84.211 Y99.979 E.00975
G1 X84.239 Y99.519 E.00975
G1 X84.306 Y99.204 E.00683
G1 X84.41 Y98.898 E.00683
G1 X84.622 Y98.489 E.00975
G1 X84.91 Y98.118 E.00995
G1 X85.252 Y97.809 E.00975
G1 X85.521 Y97.632 E.00683
G1 X85.81 Y97.487 E.00683
G1 X86.248 Y97.345 E.00975
G1 X86.714 Y97.282 E.00995
G1 X87.174 Y97.302 E.00975
G1 X87.491 Y97.365 E.00683
G1 X87.789 Y97.462 E.00663
G1 X88.073 Y97.593 E.00663
G1 X88.348 Y97.763 E.00684
G1 X88.699 Y98.061 E.00975
G1 X88.998 Y98.424 E.00995
G1 X89.23 Y98.84 E.01007
G1 X89.398 Y99.363 E.01164
G1 X89.454 Y99.896 E.01134
G1 X89.411 Y100.369 E.01005
G1 X89.289 Y100.813 E.00975
G1 X89.157 Y101.108 E.00683
G1 X89.005 Y101.363 E.0063
M204 S250
G1 X88.654 Y101.152 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X88.407 Y101.452 E.00765
G1 X88.103 Y101.71 E.00784
G1 X87.694 Y101.936 E.00919
G1 X87.261 Y102.07 E.00892
G1 X86.863 Y102.112 E.00787
G1 X86.398 Y102.068 E.00919
G1 X85.964 Y101.935 E.00892
G1 X85.614 Y101.746 E.00783
G1 X85.304 Y101.499 E.0078
G1 X85.043 Y101.2 E.0078
G1 X84.841 Y100.863 E.00773
G1 X84.74 Y100.615 E.00526
G1 X84.669 Y100.357 E.00526
G1 X84.622 Y99.967 E.00773
G1 X84.645 Y99.574 E.00774
G1 X84.701 Y99.313 E.00526
G1 X84.787 Y99.06 E.00526
G1 X84.969 Y98.711 E.00773
G1 X85.211 Y98.397 E.00779
G1 X85.503 Y98.134 E.00774
G1 X85.726 Y97.987 E.00526
G1 X85.966 Y97.867 E.00526
G1 X86.34 Y97.745 E.00773
G1 X86.732 Y97.692 E.0078
G1 X87.125 Y97.71 E.00773
G1 X87.388 Y97.762 E.00526
G1 X87.639 Y97.843 E.0052
G1 X87.879 Y97.954 E.0052
G1 X88.107 Y98.095 E.00526
G1 X88.407 Y98.349 E.00773
G1 X88.658 Y98.655 E.0078
G1 X88.852 Y99.003 E.00783
G1 X88.995 Y99.448 E.00919
G1 X89.043 Y99.899 E.00892
G1 X89.007 Y100.296 E.00783
G1 X88.902 Y100.675 E.00774
G1 X88.794 Y100.919 E.00526
G1 X88.685 Y101.101 E.00416
; WIPE_START
M204 S6000
G1 X88.407 Y101.452 E-.08521
G1 X88.103 Y101.71 E-.07571
G1 X87.694 Y101.936 E-.08876
G1 X87.261 Y102.07 E-.08614
G1 X87.029 Y102.094 E-.04418
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X88.055 Y96.12 Z3.12 F18000
G1 Z2.72
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X93.399 Y96.12 E.11312
G1 X93.462 Y95.396 E.01538
G1 X93.513 Y95.244 E.00339
G1 X93.565 Y95.16 E.0021
G1 X93.739 Y95.003 E.00496
G1 X93.873 Y94.945 E.00309
G1 X94.256 Y94.865 E.00827
G1 X97.773 Y89.843 E.12978
G1 X98.069 Y90.05 E.00765
G1 X94.546 Y95.081 E.12999
G1 X94.606 Y95.427 E.00743
G1 X94.598 Y95.62 E.00409
G1 X94.502 Y95.836 E.00501
G1 X94.398 Y95.949 E.00325
G1 X94.31 Y96.008 E.00223
G1 X94.079 Y96.109 E.00535
G1 X93.852 Y96.308 E.00638
G1 X93.723 Y96.387 E.00321
G1 X93.581 Y96.443 E.00321
G1 X93.441 Y96.472 E.00304
G1 X88.317 Y96.485 E.10846
G1 X89.453 Y97.77 E.03631
G1 X89.73 Y98.161 E.01015
G1 X89.919 Y98.526 E.00869
G1 X90.06 Y98.901 E.00849
G1 X90.186 Y99.48 E.01254
G1 X90.211 Y99.893 E.00874
G1 X90.197 Y100.203 E.00658
G1 X90.161 Y100.486 E.00603
G1 X90.067 Y100.879 E.00857
G1 X89.846 Y101.43 E.01254
G1 X89.528 Y101.94 E.01273
G1 X89.264 Y102.246 E.00855
G1 X88.875 Y102.59 E.011
G1 X88.462 Y102.861 E.01045
G1 X88.104 Y103.032 E.00839
G1 X87.715 Y103.164 E.00869
G1 X87.132 Y103.267 E.01254
G1 X86.731 Y103.279 E.00849
G1 X86.332 Y103.243 E.00849
G1 X85.939 Y103.161 E.00849
G1 X85.559 Y103.032 E.00849
G1 X85.202 Y102.861 E.00837
G1 X84.769 Y102.575 E.011
G1 X84.4 Y102.247 E.01045
G1 X84.141 Y101.947 E.00838
G1 X83.918 Y101.613 E.0085
G1 X83.738 Y101.261 E.00836
G1 X83.568 Y100.77 E.011
G1 X83.474 Y100.286 E.01045
G1 X83.452 Y99.89 E.00839
G1 X83.477 Y99.49 E.00849
G1 X83.549 Y99.095 E.00849
G1 X83.668 Y98.711 E.00849
G1 X83.831 Y98.345 E.00849
G1 X84.149 Y97.845 E.01253
G1 X85.335 Y96.482 E.03825
G1 X80.368 Y96.482 E.10513
G1 X80.129 Y96.454 E.00508
G1 X79.93 Y96.381 E.0045
G1 X79.799 Y96.301 E.00324
G1 X79.664 Y96.173 E.00394
G1 X79.571 Y96.04 E.00343
G1 X79.481 Y95.821 E.00501
G1 X79.451 Y95.565 E.00547
G1 X79.451 Y77.628 E.37965
G1 X79.487 Y77.357 E.00578
G1 X79.592 Y77.125 E.00539
G1 X79.693 Y76.998 E.00344
G1 X79.807 Y76.896 E.00324
G1 X80.025 Y76.777 E.00527
G1 X80.285 Y76.723 E.00562
G1 X93.34 Y76.721 E.27631
G1 X93.481 Y76.735 E.003
G1 X93.632 Y76.775 E.00331
G1 X93.862 Y76.904 E.00556
G1 X93.805 Y77.082 E.00395
G1 X80.778 Y77.082 E.27575
G1 X80.489 Y77.133 E.0062
G1 X80.219 Y77.278 E.00649
G1 X80.002 Y77.495 E.00649
G1 X79.85 Y77.798 E.00717
G1 X79.812 Y78.056 E.00552
G1 X79.812 Y95.137 E.36153
G1 X79.836 Y95.341 E.00436
G1 X79.929 Y95.585 E.00552
G1 X80.083 Y95.8 E.0056
G1 X80.276 Y95.962 E.00534
G1 X80.537 Y96.084 E.0061
G1 X80.787 Y96.12 E.00533
G1 X87.995 Y96.12 E.15257
; WIPE_START
M204 S6000
M73 P61 R9
G1 X89.995 Y96.12 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X89.223 Y96.892 Z3.12 F18000
G1 Z2.72
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X89.77 Y97.511 E.01625
G1 X89.967 Y97.771 E.00642
G1 X90.085 Y97.957 E.00433
G1 X90.293 Y98.359 E.00891
G1 X90.452 Y98.78 E.00885
G1 X90.56 Y99.22 E.00891
G1 X90.593 Y99.437 E.00431
G1 X90.621 Y99.889 E.00893
G1 X90.605 Y100.239 E.00688
G1 X90.564 Y100.559 E.00635
G1 X90.459 Y100.998 E.00887
G1 X90.302 Y101.423 E.00891
G1 X90.209 Y101.621 E.00431
G1 X89.978 Y102.014 E.00897
G1 X89.85 Y102.192 E.00431
G1 X89.557 Y102.534 E.00887
G1 X89.124 Y102.916 E.01136
G1 X88.663 Y103.218 E.01083
G1 X88.259 Y103.412 E.00882
G1 X87.829 Y103.557 E.00891
G1 X87.617 Y103.608 E.0043
G1 X87.169 Y103.676 E.00891
G1 X86.719 Y103.689 E.00885
G1 X86.271 Y103.649 E.00885
G1 X85.831 Y103.556 E.00885
G1 X85.405 Y103.412 E.00885
G1 X85 Y103.219 E.00881
G1 X84.519 Y102.901 E.01135
G1 X84.107 Y102.535 E.01083
G1 X83.815 Y102.195 E.00881
G1 X83.564 Y101.821 E.00885
G1 X83.361 Y101.422 E.00881
G1 X83.172 Y100.877 E.01135
G1 X83.067 Y100.336 E.01083
G1 X83.042 Y99.889 E.00882
G1 X83.07 Y99.44 E.00885
G1 X83.151 Y98.997 E.00885
G1 X83.284 Y98.567 E.00885
G1 X83.467 Y98.156 E.00885
G1 X83.7 Y97.767 E.00891
G1 X83.828 Y97.59 E.0043
G1 X84.436 Y96.891 E.01823
G1 X80.344 Y96.891 E.08049
G1 X80.034 Y96.855 E.00613
G1 X79.75 Y96.751 E.00594
G1 X79.559 Y96.633 E.00442
G1 X79.447 Y96.539 E.00289
G1 X79.346 Y96.432 E.00289
G1 X79.215 Y96.246 E.00448
G1 X79.119 Y96.039 E.00448
G1 X79.079 Y95.904 E.00277
G1 X79.042 Y95.589 E.00625
G1 X79.042 Y77.61 E.35362
G1 X79.062 Y77.374 E.00466
G1 X79.095 Y77.234 E.00283
G1 X79.181 Y77.02 E.00454
G1 X79.253 Y76.895 E.00283
G1 X79.394 Y76.716 E.00448
G1 X79.562 Y76.567 E.00442
G1 X79.756 Y76.447 E.00448
G1 X79.889 Y76.39 E.00285
G1 X80.076 Y76.338 E.00381
G1 X80.258 Y76.313 E.00363
G1 X93.36 Y76.312 E.2577
G1 X93.554 Y76.331 E.00384
G1 X93.773 Y76.389 E.00444
G1 X93.976 Y76.484 E.00442
G1 X94.16 Y76.613 E.00442
G1 X94.319 Y76.772 E.00442
G1 X94.448 Y76.956 E.00442
G1 X94.543 Y77.16 E.00442
G1 X94.601 Y77.377 E.00442
G1 X94.622 Y77.61 E.0046
G1 X94.622 Y85.511 E.1554
G1 X96.148 Y85.511 E.03002
G1 F1870.245
G1 X96.278 Y85.511 E.00256
G1 F1320
G1 X96.278 Y87.691 E.04288
G1 F1668.584
G1 X96.148 Y87.691 E.00256
G1 F1500
G1 X94.622 Y87.691 E.03002
G1 X94.622 Y88.791 E.02164
G1 X93.442 Y88.791 E.02321
G1 X93.442 Y77.491 E.22226
G1 X80.813 Y77.491 E.24839
G1 X80.625 Y77.524 E.00376
G1 X80.466 Y77.61 E.00355
G1 X80.338 Y77.738 E.00356
G1 X80.246 Y77.922 E.00406
G1 X80.222 Y78.086 E.00325
G1 X80.222 Y95.113 E.33491
G1 X80.237 Y95.243 E.00258
G1 X80.293 Y95.39 E.00308
G1 X80.386 Y95.519 E.00314
G1 X80.498 Y95.614 E.00289
G1 X80.656 Y95.687 E.00343
G1 X80.816 Y95.711 E.00319
G1 X93.024 Y95.711 E.24011
G1 X93.058 Y95.328 E.00756
G1 X93.092 Y95.194 E.00272
G1 X93.147 Y95.059 E.00287
G1 X93.237 Y94.912 E.00338
G1 X93.371 Y94.766 E.00391
G1 X93.535 Y94.646 E.004
G1 X93.749 Y94.553 E.00459
G1 X94.014 Y94.498 E.00532
G1 X97.672 Y89.273 E.12546
G1 X98.639 Y89.95 E.02321
G1 X94.978 Y95.178 E.12553
G1 X95.015 Y95.387 E.00418
G1 X95.019 Y95.566 E.00353
G1 X94.959 Y95.845 E.00561
G1 X94.848 Y96.06 E.00476
G1 X94.654 Y96.27 E.00561
G1 X94.508 Y96.368 E.00346
G1 X94.301 Y96.459 E.00445
G1 X94.096 Y96.639 E.00538
G1 X93.906 Y96.755 E.00438
G1 X93.698 Y96.837 E.00438
G1 X93.483 Y96.881 E.00433
G1 X89.283 Y96.892 E.08261
; WIPE_START
M204 S6000
G1 X89.77 Y97.511 E-.14965
G1 X89.967 Y97.771 E-.06197
G1 X90.085 Y97.957 E-.04182
G1 X90.293 Y98.359 E-.0861
G1 X90.368 Y98.558 E-.04046
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




G1 X88.959 Y97.784
G1 Z2.72
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.378029
G1 F1500
M204 S6000
G1 X88.782 Y97.61 E.00436
; LINE_WIDTH: 0.416222
G1 X88.578 Y97.413 E.00552
; LINE_WIDTH: 0.452984
G1 X88.419 Y97.282 E.00439
; LINE_WIDTH: 0.480451
G1 X88.26 Y97.151 E.00468
M204 S10000
G1 X88.959 Y97.784 F18000
; LINE_WIDTH: 0.360893
G1 F1500
M204 S6000
G1 X89.316 Y98.225 E.00948
G1 X89.57 Y98.674 E.00863
G1 X89.69 Y99.013 E.00602
G1 X89.766 Y99.303 E.005
G1 X89.833 Y99.895 E.00997
G1 X89.814 Y100.17 E.0046
G1 X89.78 Y100.451 E.00473
G1 X89.636 Y100.951 E.0087
G1 X89.498 Y101.273 E.00587
G1 X89.223 Y101.707 E.00859
G1 X88.979 Y101.995 E.00631
G1 X88.562 Y102.348 E.00913
G1 X88.018 Y102.655 E.01045
G1 X87.613 Y102.792 E.00714
G1 X87.403 Y102.841 E.00362
G1 X86.851 Y102.899 E.00928
G1 X86.388 Y102.863 E.00776
G1 X86.041 Y102.789 E.00594
G1 X85.645 Y102.656 E.00698
G1 X85.194 Y102.409 E.00861
G1 X84.75 Y102.057 E.00946
G1 X84.445 Y101.716 E.00765
G1 X84.249 Y101.418 E.00595
G1 X84.089 Y101.112 E.00579
G1 X83.995 Y100.86 E.0045
G1 X83.901 Y100.521 E.00587
G1 X83.835 Y100.005 E.00869
G1 X83.856 Y99.536 E.00785
G1 X83.92 Y99.186 E.00595
G1 X84.059 Y98.761 E.00746
G1 X84.297 Y98.299 E.0087
G1 X84.624 Y97.872 E.00899
G1 X84.817 Y97.673 E.00465
; LINE_WIDTH: 0.400601
G1 X84.992 Y97.496 E.00464
; LINE_WIDTH: 0.43839
G1 X85.199 Y97.319 E.00562
; LINE_WIDTH: 0.477107
G1 X85.379 Y97.165 E.00534
; WIPE_START
G1 X85.199 Y97.319 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X80.315 Y96.239 Z3.12 F18000
G1 Z2.72
G1 E.4 F1800
; LINE_WIDTH: 0.102703
G1 F1500
M204 S6000
G1 X80.131 Y96.178 E.00074
; LINE_WIDTH: 0.151107
G1 X79.885 Y95.995 E.00192
G1 X79.678 Y95.67 E.00241
M204 S10000
G1 X79.697 Y95.638 F18000
; LINE_WIDTH: 0.0863681
G1 F1500
M204 S6000
G1 X79.821 Y96.018 E.00121
; WIPE_START
G1 X79.697 Y95.638 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X87.324 Y95.915 Z3.12 F18000
G1 X93.61 Y96.144 Z3.12
G1 Z2.72
G1 E.4 F1800
; LINE_WIDTH: 0.109731
G1 F1500
M204 S6000
G1 X93.837 Y96.009 E.0011
; WIPE_START
G1 X93.61 Y96.144 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X94.309 Y88.543 Z3.12 F18000
G1 X94.487 Y86.601 Z3.12
G1 Z2.72
G1 E.4 F1800
; LINE_WIDTH: 0.114562
G1 F1500
M204 S6000
G1 X95.233 Y86.601 E.0033
; WIPE_START
G1 X94.487 Y86.601 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X88.18 Y82.303 Z3.12 F18000
G1 X80.327 Y76.953 Z3.12
G1 Z2.72
G1 E.4 F1800
; LINE_WIDTH: 0.0939222
G1 F1500
M204 S6000
G1 X80.221 Y76.991 E.00038
; LINE_WIDTH: 0.128083
G1 X80.051 Y77.066 E.00095
; LINE_WIDTH: 0.151967
G1 X79.902 Y77.193 E.00124
G1 X79.794 Y77.32 E.00105
G1 X79.739 Y77.434 E.0008
; LINE_WIDTH: 0.10261
G1 X79.688 Y77.598 E.00066
; WIPE_START
G1 X79.739 Y77.434 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X86.688 Y80.591 Z3.12 F18000
G1 X99.634 Y86.471 Z3.12
G1 Z2.72
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X99.909 Y86.078 E.00944
G1 X100.318 Y86.364 E.00982
G1 X100.876 Y86.755 E.01339
G1 X100.601 Y87.148 E.00944
G1 X99.683 Y86.506 E.02203
M204 S10000
G1 X99.939 Y86.392 F18000
; FEATURE: Gap infill
; LINE_WIDTH: 0.0965163
G1 F1500
M204 S6000
G1 X100.571 Y86.834 E.00272
; CHANGE_LAYER
; Z_HEIGHT: 2.84
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F1500
G1 X99.939 Y86.392 E-.38
; WIPE_END
G1 E-.02 F1800
; layer num/total_layer_count: 23/49
; update layer progress
M73 L23
M991 S0 P22 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z3.12 I.01 J-1.217 P1  F18000
G1 X94.275 Y86.344 Z3.12
G1 Z2.84
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X95.616 Y86.344 E.02839
G1 X95.616 Y86.857 E.01086
G1 X94.275 Y86.857 E.02839
G1 X94.275 Y86.404 E.00959
; WIPE_START
M204 S6000
G1 X95.616 Y86.344 E-.25506
G1 X95.616 Y86.857 E-.09748
G1 X95.472 Y86.857 E-.02746
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X93.851 Y84.415 Z3.24 F18000
G1 Z2.84
G1 E.4 F1800
G1 F1500
M204 S500
G1 X93.851 Y77.127 E.15426
G1 X94.029 Y77.071 E.00395
G1 X94.092 Y77.162 E.00234
G1 X94.157 Y77.3 E.00324
G1 X94.197 Y77.448 E.00324
G1 X94.212 Y77.628 E.00382
G1 X94.212 Y85.92 E.17551
G1 X96.04 Y85.92 E.03869
G1 X96.04 Y87.282 E.02882
G1 X94.212 Y87.282 E.03869
G1 X94.212 Y88.382 E.02328
G1 X93.851 Y88.382 E.00765
G1 X93.851 Y84.475 E.08268
; WIPE_START
M204 S6000
G1 X93.851 Y82.475 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X93.868 Y90.108 Z3.24 F18000
G1 X93.88 Y95.47 Z3.24
G1 Z2.84
G1 E.4 F1800
G1 F1500
M204 S500
G1 X93.899 Y95.424 E.00106
G1 X93.964 Y95.364 E.00187
G1 X94.159 Y95.318 E.00423
G1 X94.192 Y95.549 E.00494
G1 X94.111 Y95.632 E.00246
G1 X93.86 Y95.742 E.0058
G1 X93.876 Y95.53 E.0045
; WIPE_START
M204 S6000
G1 X93.899 Y95.424 E-.03356
G1 X93.964 Y95.364 E-.02722
G1 X94.159 Y95.318 E-.06161
G1 X94.192 Y95.549 E-.07189
G1 X94.111 Y95.632 E-.03575
G1 X93.86 Y95.742 E-.08442
G1 X93.876 Y95.53 E-.06554
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X87.987 Y97.094 Z3.24 F18000
G1 Z2.84
G1 E.4 F1800
G1 F1500
M204 S500
G1 X87.788 Y97.009 E.00459
G1 X87.42 Y96.913 E.00804
G1 X87.044 Y96.862 E.00804
G1 X86.529 Y96.87 E.0109
G1 X86.154 Y96.932 E.00805
G1 X85.789 Y97.038 E.00804
G1 X85.69 Y97.085 E.00232
G1 X85.567 Y96.916 E.00442
M73 P62 R9
G1 X85.909 Y96.544 E.0107
G1 X87.754 Y96.544 E.03904
G1 X88.106 Y96.926 E.01098
G1 X88.022 Y97.045 E.00309
; WIPE_START
M204 S6000
G1 X87.788 Y97.009 E-.04497
G1 X87.42 Y96.913 E-.07215
G1 X87.044 Y96.862 E-.0722
G1 X86.529 Y96.87 E-.09784
G1 X86.154 Y96.932 E-.07223
G1 X86.05 Y96.962 E-.0206
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X88.989 Y101.376 Z3.24 F18000
G1 Z2.84
G1 E.4 F1800
G1 F1500
M204 S500
G1 X88.901 Y101.511 E.00343
G1 X88.537 Y101.891 E.01112
G1 X88.214 Y102.127 E.00847
G1 X87.933 Y102.278 E.00676
G1 X87.633 Y102.396 E.00683
G1 X87.193 Y102.497 E.00956
G1 X86.871 Y102.521 E.00683
G1 X86.549 Y102.506 E.00683
G1 X86.096 Y102.417 E.00975
G1 X85.659 Y102.246 E.00995
G1 X85.259 Y101.999 E.00995
G1 X84.906 Y101.68 E.01007
G1 X84.579 Y101.241 E.01159
G1 X84.357 Y100.765 E.01112
G1 X84.286 Y100.517 E.00545
G1 X84.22 Y100.132 E.00826
G1 X84.22 Y99.675 E.00968
G1 X84.269 Y99.356 E.00683
G1 X84.354 Y99.045 E.00683
G1 X84.542 Y98.624 E.00976
G1 X84.807 Y98.236 E.00994
G1 X85.136 Y97.901 E.00995
G1 X85.521 Y97.63 E.00995
G1 X85.939 Y97.437 E.00975
G1 X86.248 Y97.346 E.00683
G1 X86.567 Y97.293 E.00684
G1 X87.018 Y97.287 E.00955
G1 X87.338 Y97.33 E.00683
G1 X87.65 Y97.411 E.00683
G1 X88.079 Y97.594 E.00987
G1 X88.531 Y97.904 E.01159
G1 X88.903 Y98.293 E.01139
G1 X89.159 Y98.693 E.01005
G1 X89.337 Y99.128 E.00995
G1 X89.433 Y99.579 E.00975
G1 X89.452 Y99.901 E.00683
G1 X89.433 Y100.223 E.00683
G1 X89.336 Y100.679 E.00986
G1 X89.128 Y101.164 E.01119
G1 X89.022 Y101.325 E.00407
M204 S250
G1 X88.647 Y101.152 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X88.579 Y101.256 E.00244
G1 X88.267 Y101.582 E.00888
G1 X87.995 Y101.78 E.00661
G1 X87.761 Y101.906 E.00524
G1 X87.512 Y102.004 E.00526
G1 X87.131 Y102.091 E.00767
G1 X86.865 Y102.111 E.00526
G1 X86.598 Y102.099 E.00526
G1 X86.212 Y102.023 E.00774
G1 X85.843 Y101.878 E.0078
G1 X85.505 Y101.67 E.0078
G1 X85.21 Y101.403 E.00783
G1 X84.932 Y101.031 E.00914
G1 X84.742 Y100.621 E.00888
G1 X84.686 Y100.426 E.00399
G1 X84.63 Y100.098 E.00654
G1 X84.63 Y99.706 E.00771
G1 X84.67 Y99.441 E.00526
G1 X84.741 Y99.184 E.00526
G1 X84.901 Y98.824 E.00774
G1 X85.124 Y98.497 E.00779
G1 X85.402 Y98.214 E.0078
G1 X85.726 Y97.986 E.0078
G1 X86.083 Y97.821 E.00773
G1 X86.34 Y97.746 E.00526
G1 X86.604 Y97.702 E.00527
G1 X86.994 Y97.696 E.00767
G1 X87.259 Y97.732 E.00526
G1 X87.518 Y97.799 E.00526
G1 X87.881 Y97.955 E.00777
G1 X88.264 Y98.218 E.00914
G1 X88.58 Y98.547 E.00897
G1 X88.794 Y98.882 E.00783
G1 X88.944 Y99.249 E.0078
G1 X89.026 Y99.634 E.00773
G1 X89.042 Y99.901 E.00526
G1 X89.026 Y100.168 E.00526
G1 X88.944 Y100.554 E.00777
G1 X88.766 Y100.97 E.0089
G1 X88.68 Y101.101 E.00308
; WIPE_START
M204 S6000
G1 X88.579 Y101.256 E-.03501
G1 X88.267 Y101.582 E-.08579
G1 X87.995 Y101.78 E-.06386
G1 X87.761 Y101.906 E-.05063
G1 X87.512 Y102.004 E-.05082
G1 X87.131 Y102.091 E-.07412
G1 X87.028 Y102.099 E-.01976
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X88.002 Y96.12 Z3.24 F18000
G1 Z2.84
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X93.406 Y96.12 E.11439
G1 X93.459 Y95.419 E.01488
G1 X93.515 Y95.242 E.00393
G1 X93.565 Y95.16 E.00203
G1 X93.646 Y95.072 E.00254
G1 X93.824 Y94.962 E.00444
G1 X94.262 Y94.857 E.00952
G1 X97.773 Y89.843 E.12956
G1 X98.069 Y90.05 E.00765
G1 X94.552 Y95.072 E.12977
G1 X94.61 Y95.479 E.0087
G1 X94.598 Y95.621 E.00301
G1 X94.502 Y95.839 E.00504
G1 X94.387 Y95.956 E.00346
G1 X94.31 Y96.008 E.00197
G1 X94.079 Y96.109 E.00535
G1 X93.852 Y96.308 E.00638
G1 X93.723 Y96.387 E.00321
G1 X93.582 Y96.443 E.00321
G1 X93.441 Y96.472 E.00304
G1 X88.277 Y96.485 E.1093
G1 X89.376 Y97.675 E.03428
G1 X89.632 Y98.008 E.00888
G1 X89.919 Y98.526 E.01254
G1 X90.06 Y98.901 E.00849
G1 X90.156 Y99.291 E.00849
G1 X90.206 Y99.699 E.00869
G1 X90.197 Y100.199 E.01059
G1 X90.161 Y100.486 E.00613
G1 X90.066 Y100.882 E.00862
G1 X89.844 Y101.434 E.0126
G1 X89.528 Y101.94 E.01261
G1 X89.26 Y102.251 E.00869
G1 X88.958 Y102.529 E.00869
G1 X88.466 Y102.859 E.01254
G1 X88.104 Y103.032 E.00849
G1 X87.715 Y103.164 E.00869
G1 X87.132 Y103.267 E.01254
G1 X86.731 Y103.279 E.00849
G1 X86.332 Y103.243 E.00849
G1 X85.939 Y103.161 E.00849
G1 X85.564 Y103.033 E.00838
G1 X85.118 Y102.811 E.01055
G1 X84.694 Y102.518 E.0109
G1 X84.403 Y102.251 E.00837
G1 X84.141 Y101.947 E.00849
G1 X83.918 Y101.613 E.00849
G1 X83.738 Y101.261 E.00837
G1 X83.569 Y100.775 E.0109
G1 X83.474 Y100.285 E.01055
G1 X83.452 Y99.89 E.00838
G1 X83.477 Y99.49 E.00849
G1 X83.549 Y99.095 E.00849
G1 X83.668 Y98.711 E.0085
G1 X83.831 Y98.345 E.00849
G1 X84.037 Y98 E.00849
G1 X84.287 Y97.675 E.00868
G1 X85.39 Y96.482 E.0344
G1 X80.368 Y96.482 E.1063
G1 X80.12 Y96.453 E.00527
G1 X79.975 Y96.405 E.00324
G1 X79.811 Y96.309 E.00402
G1 X79.623 Y96.121 E.00562
G1 X79.516 Y95.928 E.00468
G1 X79.48 Y95.815 E.00249
G1 X79.451 Y95.565 E.00534
G1 X79.451 Y77.628 E.37965
G1 X79.487 Y77.357 E.00578
G1 X79.613 Y77.095 E.00617
G1 X79.807 Y76.896 E.00587
G1 X80.023 Y76.778 E.00521
G1 X80.281 Y76.723 E.00558
G1 X93.342 Y76.721 E.27645
G1 X93.481 Y76.735 E.00296
G1 X93.632 Y76.775 E.00331
G1 X93.862 Y76.904 E.00556
G1 X93.805 Y77.082 E.00395
G1 X80.778 Y77.082 E.27575
G1 X80.489 Y77.132 E.0062
G1 X80.211 Y77.282 E.00669
G1 X79.979 Y77.529 E.00717
G1 X79.849 Y77.807 E.00649
G1 X79.812 Y78.056 E.00533
G1 X79.812 Y95.137 E.36153
G1 X79.836 Y95.342 E.00437
G1 X79.929 Y95.586 E.00553
G1 X80.083 Y95.8 E.00558
G1 X80.276 Y95.962 E.00533
G1 X80.537 Y96.084 E.0061
G1 X80.787 Y96.12 E.00533
G1 X87.942 Y96.12 E.15145
; WIPE_START
M204 S6000
G1 X89.942 Y96.12 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X89.21 Y96.892 Z3.24 F18000
G1 Z2.84
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X89.689 Y97.411 E.01389
G1 X89.967 Y97.772 E.00897
G1 X90.085 Y97.957 E.00431
G1 X90.293 Y98.359 E.00891
G1 X90.452 Y98.78 E.00885
G1 X90.559 Y99.217 E.00885
G1 X90.614 Y99.667 E.00891
G1 X90.621 Y99.886 E.00432
G1 X90.605 Y100.234 E.00685
G1 X90.564 Y100.559 E.00645
G1 X90.459 Y100.999 E.00889
G1 X90.342 Y101.324 E.00679
G1 X90.208 Y101.623 E.00645
G1 X89.978 Y102.014 E.00893
G1 X89.85 Y102.192 E.00431
G1 X89.555 Y102.536 E.00891
G1 X89.221 Y102.842 E.00891
G1 X89.048 Y102.975 E.0043
G1 X88.665 Y103.218 E.00891
G1 X88.259 Y103.412 E.00885
G1 X87.829 Y103.557 E.00891
G1 X87.617 Y103.608 E.0043
G1 X87.169 Y103.676 E.00891
G1 X86.719 Y103.689 E.00885
G1 X86.271 Y103.649 E.00885
G1 X85.831 Y103.556 E.00885
G1 X85.406 Y103.412 E.00882
G1 X84.909 Y103.164 E.01092
G1 X84.438 Y102.839 E.01126
G1 X84.108 Y102.536 E.00881
G1 X83.815 Y102.195 E.00885
G1 X83.564 Y101.821 E.00885
G1 X83.361 Y101.422 E.00881
G1 X83.173 Y100.881 E.01126
G1 X83.067 Y100.336 E.01092
G1 X83.042 Y99.889 E.00882
G1 X83.07 Y99.44 E.00885
G1 X83.151 Y98.997 E.00885
G1 X83.284 Y98.567 E.00885
G1 X83.467 Y98.156 E.00885
G1 X83.698 Y97.77 E.00885
G1 X83.974 Y97.411 E.00891
G1 X84.455 Y96.891 E.01393
G1 X80.344 Y96.891 E.08086
G1 X80.031 Y96.854 E.00619
G1 X79.818 Y96.784 E.00442
G1 X79.687 Y96.718 E.00289
G1 X79.422 Y96.514 E.00656
G1 X79.216 Y96.247 E.00664
G1 X79.135 Y96.08 E.00366
G1 X79.078 Y95.902 E.00366
G1 X79.042 Y95.589 E.00621
G1 X79.042 Y77.61 E.35362
G1 X79.062 Y77.374 E.00466
G1 X79.095 Y77.234 E.00283
G1 X79.18 Y77.021 E.0045
G1 X79.278 Y76.859 E.00372
G1 X79.393 Y76.717 E.0036
G1 X79.562 Y76.567 E.00445
G1 X79.756 Y76.447 E.00448
G1 X79.888 Y76.39 E.00283
G1 X80.111 Y76.33 E.00454
G1 X80.257 Y76.313 E.00289
G1 X93.362 Y76.312 E.25776
G1 X93.554 Y76.331 E.00381
G1 X93.772 Y76.389 E.00444
G1 X93.976 Y76.484 E.00442
G1 X94.16 Y76.613 E.00442
G1 X94.319 Y76.772 E.00442
G1 X94.448 Y76.956 E.00442
G1 X94.543 Y77.16 E.00442
G1 X94.601 Y77.377 E.00442
G1 X94.622 Y77.61 E.0046
G1 X94.622 Y85.511 E.1554
G1 X96.319 Y85.511 E.03339
G1 F1870.275
G1 X96.45 Y85.511 E.00256
G1 F1320
G1 X96.45 Y87.691 E.04288
G1 F1668.612
G1 X96.319 Y87.691 E.00256
G1 F1500
G1 X94.622 Y87.691 E.03339
G1 X94.622 Y88.791 E.02164
G1 X93.442 Y88.791 E.02321
G1 X93.442 Y77.491 E.22226
G1 X80.813 Y77.491 E.24839
G1 X80.625 Y77.524 E.00376
G1 X80.463 Y77.611 E.00362
G1 X80.322 Y77.762 E.00406
G1 X80.245 Y77.925 E.00355
G1 X80.222 Y78.086 E.00319
G1 X80.222 Y95.113 E.33491
G1 X80.237 Y95.244 E.00258
G1 X80.293 Y95.39 E.00309
G1 X80.385 Y95.519 E.00312
G1 X80.498 Y95.614 E.00289
G1 X80.656 Y95.687 E.00343
G1 X80.816 Y95.711 E.00319
G1 X93.027 Y95.711 E.24016
G1 X93.053 Y95.36 E.00692
G1 X93.083 Y95.219 E.00285
G1 X93.147 Y95.058 E.00341
G1 X93.237 Y94.913 E.00335
G1 X93.372 Y94.765 E.00393
G1 X93.537 Y94.644 E.00403
G1 X93.689 Y94.573 E.00329
G1 X94.016 Y94.495 E.00662
G1 X97.672 Y89.273 E.1254
G1 X98.639 Y89.95 E.02321
G1 X94.98 Y95.175 E.12546
G1 X95.019 Y95.563 E.00768
G1 X94.958 Y95.848 E.00573
G1 X94.82 Y96.099 E.00562
G1 X94.651 Y96.272 E.00477
G1 X94.508 Y96.368 E.00338
G1 X94.301 Y96.459 E.00444
G1 X94.096 Y96.639 E.00538
G1 X93.906 Y96.755 E.00438
G1 X93.698 Y96.837 E.00438
G1 X93.483 Y96.881 E.00433
G1 X89.27 Y96.892 E.08287
; WIPE_START
M204 S6000
G1 X89.689 Y97.411 E-.12678
G1 X89.967 Y97.772 E-.08664
G1 X90.085 Y97.957 E-.0416
G1 X90.293 Y98.359 E-.08609
G1 X90.366 Y98.551 E-.03889
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




G1 X88.77 Y97.595
G1 Z2.84
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.360976
G1 F1500
M204 S6000
G1 X89.082 Y97.924 E.00758
G1 X89.314 Y98.224 E.00636
G1 X89.497 Y98.534 E.00601
G1 X89.698 Y99.013 E.0087
G1 X89.802 Y99.517 E.00859
G1 X89.831 Y99.883 E.00615
G1 X89.782 Y100.421 E.00903
G1 X89.691 Y100.808 E.00666
G1 X89.503 Y101.258 E.00816
G1 X89.315 Y101.578 E.0062
G1 X88.983 Y101.982 E.00876
G1 X88.589 Y102.328 E.00875
G1 X88.406 Y102.452 E.00371
G1 X88.1 Y102.616 E.0058
G1 X87.754 Y102.75 E.0062
G1 X87.261 Y102.867 E.00849
G1 X86.867 Y102.898 E.00661
G1 X86.491 Y102.879 E.00628
G1 X85.976 Y102.775 E.00878
G1 X85.479 Y102.574 E.00898
G1 X85.046 Y102.307 E.0085
G1 X84.677 Y101.986 E.00818
G1 X84.449 Y101.713 E.00595
G1 X84.245 Y101.421 E.00595
G1 X84.011 Y100.907 E.00944
G1 X83.921 Y100.61 E.0052
G1 X83.844 Y100.15 E.00779
G1 X83.846 Y99.635 E.00862
M73 P63 R9
G1 X83.92 Y99.186 E.00761
G1 X84.026 Y98.846 E.00595
G1 X84.22 Y98.428 E.00771
G1 X84.525 Y97.985 E.00899
G1 X84.873 Y97.615 E.0085
; LINE_WIDTH: 0.397393
G1 X85.021 Y97.483 E.00368
; LINE_WIDTH: 0.435706
G1 X85.146 Y97.373 E.0034
; LINE_WIDTH: 0.470874
G1 X85.271 Y97.264 E.00369
; LINE_WIDTH: 0.476728
G1 X85.288 Y97.266 E.00038
; LINE_WIDTH: 0.448619
G1 X85.448 Y97.3 E.00346
; LINE_WIDTH: 0.415868
G1 X85.609 Y97.334 E.00319
; WIPE_START
G1 X85.448 Y97.3 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X88.226 Y97.124 Z3.24 F18000
G1 Z2.84
G1 E.4 F1800
; LINE_WIDTH: 0.472934
G1 F1500
M204 S6000
G1 X88.407 Y97.281 E.00535
; LINE_WIDTH: 0.436812
G1 X88.588 Y97.438 E.00492
; LINE_WIDTH: 0.40069
G1 X88.77 Y97.595 E.00449
; WIPE_START
G1 X88.588 Y97.438 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X93.618 Y96.14 Z3.24 F18000
G1 Z2.84
G1 E.4 F1800
; LINE_WIDTH: 0.109059
G1 F1500
M204 S6000
G1 X93.837 Y96.009 E.00106
; WIPE_START
G1 X93.618 Y96.14 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X94.311 Y88.539 Z3.24 F18000
G1 X94.487 Y86.601 Z3.24
G1 Z2.84
G1 E.4 F1800
; LINE_WIDTH: 0.114562
G1 F1500
M204 S6000
G1 X95.404 Y86.601 E.00406
; WIPE_START
G1 X94.487 Y86.601 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X88.179 Y82.304 Z3.24 F18000
G1 X80.328 Y76.955 Z3.24
G1 Z2.84
G1 E.4 F1800
; LINE_WIDTH: 0.081227
G1 F1500
M204 S6000
G1 X80.296 Y76.963 E.00009
; LINE_WIDTH: 0.0962939
G1 X80.204 Y76.997 E.00034
; LINE_WIDTH: 0.129665
G1 X80.039 Y77.073 E.00094
; LINE_WIDTH: 0.156359
G1 X79.899 Y77.197 E.00122
G1 X79.756 Y77.387 E.00155
; LINE_WIDTH: 0.105153
G1 X79.689 Y77.595 E.00086
; WIPE_START
G1 X79.756 Y77.387 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X79.79 Y85.02 Z3.24 F18000
G1 X79.838 Y96.046 Z3.24
G1 Z2.84
G1 E.4 F1800
; LINE_WIDTH: 0.084525
G1 F1500
M204 S6000
G1 X79.697 Y95.637 E.00127
M204 S10000
G1 X79.683 Y95.69 F18000
; LINE_WIDTH: 0.153177
G1 F1500
M204 S6000
G1 X79.883 Y95.996 E.00233
G1 X80.129 Y96.18 E.00195
; LINE_WIDTH: 0.10416
G1 X80.315 Y96.239 E.00076
; WIPE_START
G1 X80.129 Y96.18 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X86.962 Y92.779 Z3.24 F18000
G1 X99.634 Y86.471 Z3.24
G1 Z2.84
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X99.909 Y86.078 E.00944
G1 X100.345 Y86.383 E.01045
G1 X100.876 Y86.755 E.01276
G1 X100.601 Y87.148 E.00944
G1 X99.683 Y86.506 E.02203
M204 S10000
G1 X99.939 Y86.392 F18000
; FEATURE: Gap infill
; LINE_WIDTH: 0.0965177
G1 F1500
M204 S6000
G1 X100.571 Y86.834 E.00272
; CHANGE_LAYER
; Z_HEIGHT: 2.96
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F1500
G1 X99.939 Y86.392 E-.38
; WIPE_END
G1 E-.02 F1800
; layer num/total_layer_count: 24/49
; update layer progress
M73 L24
M991 S0 P23 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z3.24 I.01 J-1.217 P1  F18000
G1 X94.275 Y86.344 Z3.24
G1 Z2.96
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X95.788 Y86.344 E.03201
G1 X95.788 Y86.857 E.01086
G1 X94.275 Y86.857 E.03201
G1 X94.275 Y86.404 E.00959
; WIPE_START
M204 S6000
G1 X95.788 Y86.344 E-.28759
G1 X95.788 Y86.831 E-.09241
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X93.851 Y84.477 Z3.36 F18000
G1 Z2.96
G1 E.4 F1800
G1 F1500
M204 S500
G1 X93.851 Y77.127 E.15557
G1 X94.029 Y77.071 E.00395
G1 X94.092 Y77.162 E.00234
G1 X94.157 Y77.3 E.00324
G1 X94.197 Y77.448 E.00324
G1 X94.212 Y77.628 E.00382
G1 X94.212 Y85.92 E.17551
G1 X96.212 Y85.92 E.04232
G1 X96.212 Y87.282 E.02882
G1 X94.212 Y87.282 E.04232
G1 X94.212 Y88.382 E.02328
G1 X93.851 Y88.382 E.00765
G1 X93.851 Y84.537 E.08137
; WIPE_START
M204 S6000
G1 X93.851 Y82.537 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X93.868 Y90.17 Z3.36 F18000
G1 X93.88 Y95.47 Z3.36
G1 Z2.96
G1 E.4 F1800
G1 F1500
M204 S500
G1 X93.899 Y95.424 E.00106
G1 X93.956 Y95.37 E.00167
G1 X94.158 Y95.318 E.00441
G1 X94.189 Y95.516 E.00424
G1 X94.106 Y95.634 E.00304
G1 X93.86 Y95.742 E.0057
G1 X93.876 Y95.53 E.00451
; WIPE_START
M204 S6000
G1 X93.899 Y95.424 E-.03381
G1 X93.956 Y95.37 E-.02448
G1 X94.158 Y95.318 E-.06479
G1 X94.189 Y95.516 E-.06231
G1 X94.106 Y95.634 E-.04469
G1 X93.86 Y95.742 E-.08371
G1 X93.876 Y95.53 E-.06621
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X88.039 Y97.097 Z3.36 F18000
G1 Z2.96
G1 E.4 F1800
G1 F1500
M204 S500
G1 X87.583 Y96.949 E.01015
G1 X87.059 Y96.862 E.01123
G1 X86.529 Y96.87 E.01123
G1 X86.154 Y96.932 E.00805
G1 X85.789 Y97.038 E.00804
G1 X85.605 Y97.124 E.00429
G1 X85.482 Y96.959 E.00436
G1 X85.842 Y96.544 E.01163
G1 X87.8 Y96.544 E.04143
G1 X88.146 Y96.934 E.01103
G1 X88.072 Y97.047 E.00285
; WIPE_START
M204 S6000
G1 X87.583 Y96.949 E-.09474
G1 X87.059 Y96.862 E-.10082
G1 X86.529 Y96.87 E-.10083
G1 X86.154 Y96.932 E-.07224
G1 X86.096 Y96.949 E-.01137
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X88.991 Y101.371 Z3.36 F18000
G1 Z2.96
G1 E.4 F1800
G1 F1500
M204 S500
G1 X88.903 Y101.509 E.00346
G1 X88.535 Y101.892 E.01124
G1 X88.21 Y102.131 E.00854
G1 X87.868 Y102.306 E.00813
G1 X87.63 Y102.397 E.0054
G1 X87.193 Y102.497 E.00949
G1 X86.871 Y102.521 E.00683
G1 X86.549 Y102.506 E.00683
G1 X86.091 Y102.416 E.00986
G1 X85.591 Y102.211 E.01144
G1 X85.143 Y101.907 E.01146
G1 X84.864 Y101.63 E.00832
G1 X84.704 Y101.431 E.0054
G1 X84.467 Y101.034 E.00979
G1 X84.289 Y100.534 E.01124
G1 X84.221 Y100.136 E.00854
G1 X84.216 Y99.732 E.00854
G1 X84.303 Y99.208 E.01124
G1 X84.466 Y98.772 E.00986
G1 X84.623 Y98.49 E.00683
G1 X84.813 Y98.229 E.00683
G1 X85.136 Y97.901 E.00975
G1 X85.521 Y97.63 E.00995
G1 X85.939 Y97.437 E.00975
G1 X86.248 Y97.346 E.00683
G1 X86.567 Y97.293 E.00684
G1 X87.028 Y97.286 E.00975
G1 X87.482 Y97.362 E.00975
G1 X87.789 Y97.462 E.00683
G1 X88.082 Y97.597 E.00683
G1 X88.466 Y97.851 E.00976
G1 X88.806 Y98.176 E.00995
G1 X89.08 Y98.553 E.00986
G1 X89.251 Y98.896 E.00811
G1 X89.339 Y99.14 E.00549
G1 X89.433 Y99.579 E.00949
G1 X89.452 Y99.901 E.00683
G1 X89.433 Y100.223 E.00683
G1 X89.337 Y100.674 E.00975
G1 X89.159 Y101.109 E.00995
G1 X89.023 Y101.321 E.00533
M204 S250
G1 X88.646 Y101.151 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X88.58 Y101.255 E.00243
G1 X88.265 Y101.583 E.00895
G1 X87.994 Y101.781 E.0066
G1 X87.701 Y101.932 E.00647
G1 X87.511 Y102.004 E.00401
G1 X87.131 Y102.091 E.00765
G1 X86.865 Y102.111 E.00526
G1 X86.598 Y102.099 E.00526
G1 X86.21 Y102.023 E.00777
G1 X85.786 Y101.848 E.00901
G1 X85.404 Y101.589 E.00907
G1 X85.169 Y101.355 E.00653
G1 X85.041 Y101.197 E.00401
G1 X84.839 Y100.859 E.00775
G1 X84.686 Y100.43 E.00895
G1 X84.63 Y100.099 E.0066
G1 X84.626 Y99.763 E.0066
G1 X84.7 Y99.314 E.00895
G1 X84.839 Y98.945 E.00777
G1 X84.969 Y98.711 E.00526
G1 X85.126 Y98.495 E.00526
G1 X85.402 Y98.214 E.00774
G1 X85.726 Y97.986 E.0078
G1 X86.083 Y97.821 E.00773
G1 X86.34 Y97.746 E.00526
G1 X86.604 Y97.702 E.00527
G1 X86.997 Y97.696 E.00773
G1 X87.385 Y97.761 E.00773
G1 X87.639 Y97.843 E.00526
G1 X87.882 Y97.956 E.00526
G1 X88.21 Y98.172 E.00774
G1 X88.497 Y98.446 E.0078
G1 X88.729 Y98.766 E.00777
G1 X88.874 Y99.058 E.00642
G1 X88.945 Y99.253 E.00409
G1 X89.026 Y99.634 E.00765
G1 X89.042 Y99.901 E.00526
G1 X89.026 Y100.168 E.00526
G1 X88.944 Y100.553 E.00773
G1 X88.794 Y100.919 E.0078
G1 X88.678 Y101.1 E.00422
; WIPE_START
M204 S6000
G1 X88.58 Y101.255 E-.03483
G1 X88.265 Y101.583 E-.08647
G1 X87.994 Y101.781 E-.06377
G1 X87.701 Y101.932 E-.06252
G1 X87.511 Y102.004 E-.03872
G1 X87.131 Y102.091 E-.07391
G1 X87.028 Y102.099 E-.01977
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X88.052 Y96.12 Z3.36 F18000
G1 Z2.96
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X93.406 Y96.12 E.11332
G1 X93.459 Y95.418 E.0149
G1 X93.515 Y95.242 E.00391
G1 X93.565 Y95.16 E.00202
G1 X93.647 Y95.071 E.00257
G1 X93.742 Y95.001 E.00251
G1 X93.848 Y94.954 E.00245
G1 X94.259 Y94.86 E.00893
G1 X97.773 Y89.843 E.12965
G1 X98.069 Y90.05 E.00765
G1 X94.55 Y95.076 E.12986
G1 X94.608 Y95.452 E.00806
G1 X94.598 Y95.622 E.0036
G1 X94.498 Y95.837 E.00501
G1 X94.383 Y95.959 E.00355
G1 X94.31 Y96.008 E.00186
G1 X94.079 Y96.109 E.00535
G1 X93.852 Y96.308 E.00638
G1 X93.723 Y96.388 E.00322
G1 X93.582 Y96.443 E.00321
G1 X93.441 Y96.472 E.00304
G1 X88.315 Y96.485 E.1085
G1 X89.448 Y97.763 E.03615
G1 X89.73 Y98.161 E.01034
G1 X89.919 Y98.526 E.00869
G1 X90.06 Y98.901 E.00849
G1 X90.156 Y99.291 E.00849
G1 X90.206 Y99.699 E.00869
G1 X90.197 Y100.194 E.0105
G1 X90.16 Y100.486 E.00622
G1 X90.067 Y100.879 E.00856
G1 X89.928 Y101.256 E.0085
G1 X89.741 Y101.622 E.00869
G1 X89.39 Y102.11 E.01273
G1 X89.271 Y102.241 E.00374
G1 X88.882 Y102.585 E.011
G1 X88.462 Y102.861 E.01064
G1 X88.104 Y103.032 E.00838
G1 X87.715 Y103.164 E.00869
G1 X87.132 Y103.267 E.01254
G1 X86.731 Y103.279 E.00849
G1 X86.332 Y103.243 E.00849
G1 X85.939 Y103.161 E.00849
G1 X85.559 Y103.032 E.00849
G1 X85.197 Y102.859 E.00849
G1 X84.858 Y102.644 E.00849
G1 X84.409 Y102.258 E.01254
G1 X84.141 Y101.947 E.00869
G1 X83.918 Y101.613 E.0085
G1 X83.738 Y101.261 E.00837
G1 X83.57 Y100.779 E.0108
G1 X83.474 Y100.285 E.01064
G1 X83.452 Y99.89 E.00838
G1 X83.477 Y99.49 E.00849
G1 X83.549 Y99.095 E.00849
G1 X83.668 Y98.711 E.0085
G1 X83.831 Y98.345 E.00849
G1 X84.149 Y97.845 E.01253
G1 X85.335 Y96.482 E.03825
G1 X80.368 Y96.482 E.10513
G1 X80.129 Y96.454 E.00508
G1 X79.93 Y96.381 E.0045
G1 X79.799 Y96.301 E.00324
G1 X79.621 Y96.119 E.0054
G1 X79.481 Y95.821 E.00696
G1 X79.451 Y95.565 E.00546
G1 X79.451 Y77.628 E.37965
G1 X79.488 Y77.354 E.00585
G1 X79.595 Y77.121 E.00543
G1 X79.788 Y76.911 E.00603
G1 X80.031 Y76.775 E.0059
G1 X80.28 Y76.723 E.00539
G1 X93.343 Y76.721 E.27649
G1 X93.481 Y76.735 E.00292
G1 X93.632 Y76.775 E.00331
G1 X93.862 Y76.904 E.00557
G1 X93.805 Y77.082 E.00395
G1 X80.778 Y77.082 E.27574
G1 X80.489 Y77.132 E.0062
G1 X80.219 Y77.278 E.00649
G1 X80.002 Y77.495 E.00648
G1 X79.85 Y77.797 E.00717
G1 X79.812 Y78.056 E.00553
G1 X79.812 Y95.137 E.36153
G1 X79.837 Y95.346 E.00445
G1 X79.954 Y95.64 E.00669
G1 X80.243 Y95.946 E.00892
G1 X80.538 Y96.084 E.00688
G1 X80.787 Y96.12 E.00533
G1 X87.992 Y96.12 E.15251
; WIPE_START
M204 S6000
G1 X89.992 Y96.12 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X89.222 Y96.892 Z3.36 F18000
G1 Z2.96
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
M73 P63 R8
G1 X89.765 Y97.504 E.01607
G1 X89.967 Y97.771 E.0066
G1 X90.085 Y97.957 E.00433
G1 X90.293 Y98.359 E.00891
G1 X90.452 Y98.78 E.00885
G1 X90.559 Y99.217 E.00885
G1 X90.614 Y99.667 E.00891
G1 X90.605 Y100.23 E.01107
G1 X90.564 Y100.559 E.00654
G1 X90.459 Y100.998 E.00887
G1 X90.303 Y101.42 E.00885
G1 X90.097 Y101.824 E.00891
G1 X89.981 Y102.009 E.0043
G1 X89.705 Y102.372 E.00898
G1 X89.559 Y102.533 E.00426
G1 X89.131 Y102.911 E.01123
G1 X88.663 Y103.218 E.01102
G1 X88.259 Y103.412 E.00882
G1 X87.83 Y103.557 E.00891
G1 X87.617 Y103.608 E.0043
G1 X87.169 Y103.676 E.00891
G1 X86.719 Y103.689 E.00885
G1 X86.271 Y103.649 E.00885
G1 X85.831 Y103.556 E.00885
G1 X85.405 Y103.412 E.00885
G1 X84.999 Y103.218 E.00885
G1 X84.618 Y102.977 E.00885
G1 X84.267 Y102.691 E.00891
G1 X84.11 Y102.538 E.0043
G1 X83.815 Y102.195 E.00891
G1 X83.564 Y101.821 E.00885
G1 X83.361 Y101.422 E.00881
G1 X83.174 Y100.886 E.01117
G1 X83.067 Y100.336 E.01101
G1 X83.042 Y99.889 E.00882
G1 X83.07 Y99.44 E.00885
G1 X83.151 Y98.997 E.00885
G1 X83.284 Y98.567 E.00885
G1 X83.467 Y98.156 E.00885
G1 X83.7 Y97.767 E.00891
G1 X83.828 Y97.59 E.0043
G1 X84.436 Y96.891 E.01823
G1 X80.344 Y96.891 E.08049
G1 X80.034 Y96.855 E.00613
G1 X79.75 Y96.751 E.00594
G1 X79.559 Y96.633 E.00442
G1 X79.449 Y96.541 E.00283
G1 X79.295 Y96.368 E.00455
G1 X79.216 Y96.248 E.00283
G1 X79.119 Y96.039 E.00454
G1 X79.079 Y95.904 E.00276
G1 X79.042 Y95.589 E.00625
G1 X79.042 Y77.61 E.35362
G1 X79.062 Y77.374 E.00466
G1 X79.096 Y77.233 E.00285
G1 X79.164 Y77.055 E.00375
G1 X79.254 Y76.894 E.00363
G1 X79.395 Y76.715 E.00447
G1 X79.533 Y76.589 E.00369
G1 X79.686 Y76.485 E.00363
G1 X79.891 Y76.389 E.00444
G1 X80.111 Y76.33 E.00448
G1 X80.257 Y76.313 E.00289
G1 X93.363 Y76.312 E.2578
G1 X93.554 Y76.331 E.00377
G1 X93.772 Y76.389 E.00444
G1 X93.976 Y76.484 E.00442
G1 X94.16 Y76.613 E.00442
M73 P64 R8
G1 X94.319 Y76.772 E.00442
G1 X94.448 Y76.956 E.00442
G1 X94.543 Y77.16 E.00442
G1 X94.601 Y77.377 E.00442
G1 X94.622 Y77.61 E.0046
G1 X94.622 Y85.511 E.1554
G1 X96.491 Y85.511 E.03676
G1 F1870.275
G1 X96.621 Y85.511 E.00256
G1 F1320
G1 X96.621 Y87.691 E.04288
G1 F1668.612
G1 X96.491 Y87.691 E.00256
G1 F1500
G1 X94.622 Y87.691 E.03676
G1 X94.622 Y88.791 E.02164
G1 X93.442 Y88.791 E.02321
G1 X93.442 Y77.491 E.22226
G1 X80.813 Y77.491 E.24839
G1 X80.625 Y77.524 E.00376
G1 X80.466 Y77.61 E.00356
G1 X80.338 Y77.737 E.00355
G1 X80.246 Y77.922 E.00407
G1 X80.222 Y78.086 E.00325
G1 X80.222 Y95.113 E.33491
G1 X80.237 Y95.245 E.00261
G1 X80.305 Y95.416 E.00362
G1 X80.487 Y95.608 E.00521
G1 X80.656 Y95.687 E.00368
G1 X80.816 Y95.711 E.00319
G1 X93.026 Y95.711 E.24016
G1 X93.053 Y95.359 E.00695
G1 X93.083 Y95.219 E.00282
G1 X93.147 Y95.058 E.00341
G1 X93.237 Y94.913 E.00335
G1 X93.373 Y94.764 E.00396
G1 X93.536 Y94.645 E.00397
G1 X93.718 Y94.564 E.00392
G1 X94.015 Y94.496 E.00599
G1 X97.672 Y89.273 E.12542
G1 X98.639 Y89.95 E.02321
G1 X94.98 Y95.176 E.12549
G1 X95.017 Y95.418 E.00482
G1 X95.019 Y95.565 E.00289
G1 X94.959 Y95.844 E.0056
G1 X94.833 Y96.078 E.00524
G1 X94.649 Y96.273 E.00527
G1 X94.508 Y96.368 E.00334
G1 X94.301 Y96.459 E.00444
G1 X94.096 Y96.639 E.00538
G1 X93.906 Y96.755 E.00439
G1 X93.698 Y96.837 E.00438
G1 X93.483 Y96.881 E.00433
G1 X89.282 Y96.892 E.08262
; WIPE_START
M204 S6000
G1 X89.765 Y97.504 E-.14798
G1 X89.967 Y97.771 E-.06374
G1 X90.085 Y97.957 E-.0418
G1 X90.293 Y98.359 E-.08609
G1 X90.368 Y98.558 E-.0404
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




G1 X88.727 Y97.55
G1 Z2.96
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.361576
G1 F1500
M204 S6000
G1 X89.1 Y97.939 E.00902
G1 X89.403 Y98.355 E.00862
G1 X89.57 Y98.681 E.00614
G1 X89.7 Y99.024 E.00615
G1 X89.804 Y99.516 E.00842
G1 X89.828 Y99.891 E.0063
G1 X89.805 Y100.286 E.00663
G1 X89.694 Y100.799 E.0088
G1 X89.486 Y101.295 E.009
G1 X89.206 Y101.727 E.00863
G1 X89 Y101.965 E.00527
G1 X88.649 Y102.281 E.00791
G1 X88.273 Y102.528 E.00753
G1 X88.014 Y102.656 E.00485
G1 X87.75 Y102.754 E.00472
G1 X87.236 Y102.869 E.00881
G1 X86.867 Y102.898 E.00621
G1 X86.491 Y102.879 E.00629
G1 X86.04 Y102.793 E.0077
G1 X85.704 Y102.674 E.00596
G1 X85.381 Y102.526 E.00596
G1 X84.916 Y102.207 E.00945
G1 X84.592 Y101.887 E.00762
G1 X84.388 Y101.637 E.00541
G1 X84.249 Y101.418 E.00434
G1 X84.09 Y101.111 E.00581
G1 X83.928 Y100.643 E.0083
G1 X83.846 Y100.182 E.00783
G1 X83.842 Y99.689 E.00826
G1 X83.92 Y99.186 E.00854
G1 X84.119 Y98.625 E.00997
G1 X84.3 Y98.296 E.00629
G1 X84.517 Y97.995 E.00622
G1 X84.894 Y97.589 E.00927
; LINE_WIDTH: 0.414906
G1 X85.131 Y97.375 E.0062
; LINE_WIDTH: 0.463879
G1 X85.368 Y97.161 E.00698
; WIPE_START
G1 X85.131 Y97.375 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X88.258 Y97.15 Z3.36 F18000
G1 Z2.96
G1 E.4 F1800
; LINE_WIDTH: 0.476201
G1 F1500
M204 S6000
G1 X88.479 Y97.337 E.00651
; LINE_WIDTH: 0.428136
G1 X88.7 Y97.525 E.00582
; LINE_WIDTH: 0.400649
G1 X88.727 Y97.55 E.00071
; WIPE_START
G1 X88.7 Y97.525 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X93.617 Y96.14 Z3.36 F18000
G1 Z2.96
G1 E.4 F1800
; LINE_WIDTH: 0.109122
G1 F1500
M204 S6000
G1 X93.837 Y96.009 E.00106
; WIPE_START
G1 X93.617 Y96.14 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X94.311 Y88.539 Z3.36 F18000
G1 X94.487 Y86.601 Z3.36
G1 Z2.96
G1 E.4 F1800
; LINE_WIDTH: 0.114562
G1 F1500
M204 S6000
G1 X95.575 Y86.601 E.00482
; WIPE_START
G1 X94.487 Y86.601 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X88.179 Y82.304 Z3.36 F18000
G1 X80.328 Y76.955 Z3.36
G1 Z2.96
G1 E.4 F1800
; LINE_WIDTH: 0.0812339
G1 F1500
M204 S6000
G1 X80.296 Y76.963 E.00009
; LINE_WIDTH: 0.0957571
G1 X80.209 Y76.995 E.00032
; LINE_WIDTH: 0.131561
G1 X80.028 Y77.081 E.00106
; LINE_WIDTH: 0.15643
G1 X79.904 Y77.191 E.00108
G1 X79.779 Y77.344 E.00129
; LINE_WIDTH: 0.125842
G1 X79.721 Y77.482 E.00075
; LINE_WIDTH: 0.0973195
G1 X79.688 Y77.598 E.00043
; WIPE_START
G1 X79.721 Y77.482 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X79.71 Y85.115 Z3.36 F18000
G1 X79.695 Y95.628 Z3.36
G1 Z2.96
G1 E.4 F1800
; LINE_WIDTH: 0.0962721
G1 F1500
M204 S6000
G1 X79.748 Y95.802 E.00064
; LINE_WIDTH: 0.148094
G1 X79.851 Y95.947 E.00108
; LINE_WIDTH: 0.162877
G1 X80.079 Y96.156 E.00212
; LINE_WIDTH: 0.106889
G1 X80.315 Y96.239 E.00101
; WIPE_START
G1 X80.079 Y96.156 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X86.919 Y92.769 Z3.36 F18000
G1 X99.634 Y86.471 Z3.36
G1 Z2.96
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X99.909 Y86.078 E.00944
G1 X100.371 Y86.401 E.01108
G1 X100.876 Y86.755 E.01213
G1 X100.601 Y87.148 E.00944
G1 X99.683 Y86.506 E.02203
M204 S10000
G1 X99.939 Y86.392 F18000
; FEATURE: Gap infill
; LINE_WIDTH: 0.0965075
G1 F1500
M204 S6000
G1 X100.571 Y86.834 E.00272
; CHANGE_LAYER
; Z_HEIGHT: 3.08
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F1500
G1 X99.939 Y86.392 E-.38
; WIPE_END
G1 E-.02 F1800
; layer num/total_layer_count: 25/49
; update layer progress
M73 L25
M991 S0 P24 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z3.36 I.01 J-1.217 P1  F18000
G1 X94.275 Y86.344 Z3.36
G1 Z3.08
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X95.959 Y86.344 E.03564
G1 X95.959 Y86.857 E.01086
G1 X94.275 Y86.857 E.03564
G1 X94.275 Y86.404 E.00959
; WIPE_START
M204 S6000
G1 X95.959 Y86.344 E-.32013
G1 X95.959 Y86.659 E-.05987
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X93.851 Y84.507 Z3.48 F18000
G1 Z3.08
G1 E.4 F1800
G1 F1500
M204 S500
G1 X93.851 Y77.127 E.1562
G1 X94.029 Y77.071 E.00395
G1 X94.092 Y77.162 E.00234
G1 X94.157 Y77.301 E.00324
G1 X94.197 Y77.448 E.00324
G1 X94.212 Y77.628 E.00382
G1 X94.212 Y85.92 E.17551
G1 X96.383 Y85.92 E.04595
G1 X96.383 Y87.282 E.02882
G1 X94.212 Y87.282 E.04595
G1 X94.212 Y88.382 E.02328
G1 X93.851 Y88.382 E.00765
G1 X93.851 Y84.567 E.08074
; WIPE_START
M204 S6000
G1 X93.851 Y82.567 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X93.869 Y90.199 Z3.48 F18000
G1 X93.881 Y95.475 Z3.48
G1 Z3.08
G1 E.4 F1800
G1 F1500
M204 S500
G1 X93.893 Y95.43 E.00099
G1 X93.931 Y95.388 E.00119
G1 X93.984 Y95.358 E.00129
G1 X94.159 Y95.318 E.0038
G1 X94.183 Y95.487 E.00361
G1 X94.134 Y95.622 E.00303
G1 X93.858 Y95.743 E.00639
G1 X93.876 Y95.534 E.00443
; WIPE_START
M204 S6000
G1 X93.893 Y95.43 E-.03286
G1 X93.931 Y95.388 E-.01734
G1 X93.984 Y95.358 E-.01885
G1 X94.159 Y95.318 E-.05555
G1 X94.183 Y95.487 E-.05282
G1 X94.134 Y95.622 E-.04427
G1 X93.858 Y95.743 E-.09346
G1 X93.876 Y95.534 E-.06486
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X88.051 Y97.116 Z3.48 F18000
G1 Z3.08
G1 E.4 F1800
G1 F1500
M204 S500
G1 X87.583 Y96.949 E.01052
G1 X87.059 Y96.862 E.01123
G1 X86.529 Y96.87 E.01123
G1 X86.154 Y96.932 E.00804
G1 X85.789 Y97.038 E.00804
G1 X85.605 Y97.124 E.0043
G1 X85.481 Y96.959 E.00436
G1 X85.842 Y96.544 E.01164
G1 X87.821 Y96.544 E.04189
G1 X88.175 Y96.951 E.01141
G1 X88.087 Y97.068 E.00309
; WIPE_START
M204 S6000
G1 X87.583 Y96.949 E-.09847
G1 X87.059 Y96.862 E-.10081
G1 X86.529 Y96.87 E-.10083
G1 X86.154 Y96.932 E-.07221
G1 X86.115 Y96.943 E-.00769
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X88.978 Y101.402 Z3.48 F18000
G1 Z3.08
G1 E.4 F1800
G1 F1500
M204 S500
G1 X88.802 Y101.629 E.00609
G1 X88.518 Y101.906 E.00839
G1 X88.079 Y102.207 E.01127
G1 X87.65 Y102.391 E.00987
G1 X87.338 Y102.472 E.00683
G1 X87.018 Y102.515 E.00683
G1 X86.558 Y102.508 E.00975
G1 X86.096 Y102.417 E.00995
G1 X85.668 Y102.249 E.00975
G1 X85.388 Y102.088 E.00683
G1 X85.137 Y101.9 E.00664
G1 X84.911 Y101.683 E.00663
G1 X84.706 Y101.434 E.00683
G1 X84.47 Y101.038 E.00975
G1 X84.304 Y100.598 E.00995
G1 X84.221 Y100.14 E.00987
G1 X84.216 Y99.735 E.00856
G1 X84.303 Y99.208 E.0113
G1 X84.471 Y98.758 E.01018
G1 X84.757 Y98.298 E.01148
G1 X85.132 Y97.904 E.0115
G1 X85.521 Y97.63 E.01006
G1 X85.939 Y97.437 E.00975
G1 X86.248 Y97.346 E.00683
G1 X86.567 Y97.293 E.00683
G1 X87.028 Y97.286 E.00975
G1 X87.482 Y97.362 E.00975
G1 X87.789 Y97.462 E.00683
G1 X88.082 Y97.597 E.00683
G1 X88.466 Y97.851 E.00975
G1 X88.806 Y98.176 E.00995
G1 X89.075 Y98.546 E.00969
G1 X89.196 Y98.773 E.00544
G1 X89.338 Y99.132 E.00817
G1 X89.433 Y99.579 E.00967
G1 X89.452 Y99.901 E.00683
G1 X89.433 Y100.223 E.00683
G1 X89.337 Y100.674 E.00975
G1 X89.162 Y101.1 E.00975
G1 X89.011 Y101.352 E.00622
M204 S250
G1 X88.654 Y101.151 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X88.495 Y101.357 E.00511
G1 X88.258 Y101.589 E.00653
G1 X87.881 Y101.847 E.00898
G1 X87.518 Y102.002 E.00777
G1 X87.259 Y102.07 E.00526
G1 X86.994 Y102.106 E.00526
G1 X86.601 Y102.1 E.00773
G1 X86.212 Y102.023 E.0078
G1 X85.846 Y101.879 E.00773
G1 X85.614 Y101.746 E.00526
G1 X85.402 Y101.587 E.0052
G1 X85.211 Y101.404 E.0052
G1 X85.041 Y101.198 E.00526
G1 X84.84 Y100.86 E.00773
G1 X84.7 Y100.489 E.00779
G1 X84.63 Y100.1 E.00777
G1 X84.626 Y99.766 E.00658
G1 X84.7 Y99.314 E.009
G1 X84.84 Y98.94 E.00787
G1 X85.083 Y98.549 E.00905
G1 X85.401 Y98.215 E.00906
G1 X85.726 Y97.986 E.00783
G1 X86.083 Y97.821 E.00773
G1 X86.34 Y97.746 E.00526
G1 X86.604 Y97.702 E.00527
G1 X86.997 Y97.696 E.00773
G1 X87.385 Y97.761 E.00773
G1 X87.639 Y97.843 E.00526
G1 X87.882 Y97.956 E.00526
G1 X88.21 Y98.172 E.00773
G1 X88.496 Y98.446 E.0078
G1 X88.727 Y98.763 E.00771
G1 X88.824 Y98.945 E.00404
G1 X88.945 Y99.251 E.00647
G1 X89.026 Y99.634 E.00771
G1 X89.042 Y99.901 E.00526
G1 X89.026 Y100.168 E.00526
G1 X88.944 Y100.552 E.00773
G1 X88.795 Y100.916 E.00774
G1 X88.685 Y101.1 E.00421
; WIPE_START
M204 S6000
G1 X88.495 Y101.357 E-.06066
G1 X88.258 Y101.589 E-.0631
G1 X87.881 Y101.847 E-.08674
G1 X87.518 Y102.002 E-.07507
G1 X87.259 Y102.07 E-.05084
G1 X87.031 Y102.1 E-.04359
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X88.075 Y96.12 Z3.48 F18000
G1 Z3.08
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X93.399 Y96.12 E.11268
G1 X93.462 Y95.401 E.01528
G1 X93.49 Y95.295 E.00232
G1 X93.565 Y95.16 E.00325
G1 X93.647 Y95.07 E.00259
G1 X93.742 Y95.001 E.00248
G1 X93.849 Y94.953 E.00248
G1 X94.259 Y94.861 E.0089
G1 X97.773 Y89.843 E.12966
G1 X98.069 Y90.05 E.00765
G1 X94.552 Y95.072 E.12977
G1 X94.61 Y95.479 E.0087
G1 X94.575 Y95.688 E.00447
G1 X94.475 Y95.873 E.00446
G1 X94.31 Y96.008 E.0045
G1 X94.079 Y96.109 E.00536
G1 X93.852 Y96.308 E.00638
G1 X93.723 Y96.387 E.00321
G1 X93.581 Y96.443 E.00321
G1 X93.441 Y96.472 E.00304
G1 X88.332 Y96.485 E.10813
G1 X89.515 Y97.845 E.03814
G1 X89.73 Y98.162 E.00811
G1 X89.919 Y98.526 E.00869
G1 X90.06 Y98.901 E.00849
G1 X90.186 Y99.48 E.01254
G1 X90.211 Y99.89 E.00869
G1 X90.189 Y100.294 E.00856
G1 X90.068 Y100.877 E.0126
G1 X89.928 Y101.256 E.00856
G1 X89.741 Y101.621 E.00869
G1 X89.39 Y102.11 E.01274
G1 X89.124 Y102.385 E.00811
G1 X88.805 Y102.644 E.00869
G1 X88.466 Y102.859 E.00849
G1 X88.104 Y103.032 E.0085
G1 X87.716 Y103.164 E.00868
G1 X87.132 Y103.267 E.01254
G1 X86.731 Y103.279 E.00849
M73 P65 R8
G1 X86.332 Y103.243 E.00849
G1 X85.93 Y103.159 E.00869
G1 X85.375 Y102.951 E.01253
G1 X85.024 Y102.757 E.00849
G1 X84.699 Y102.522 E.00849
G1 X84.403 Y102.251 E.00849
G1 X84.141 Y101.947 E.00849
G1 X83.918 Y101.613 E.0085
G1 X83.738 Y101.261 E.00838
G1 X83.571 Y100.783 E.01071
G1 X83.474 Y100.285 E.01074
G1 X83.452 Y99.89 E.00837
G1 X83.477 Y99.49 E.00849
G1 X83.549 Y99.095 E.00849
G1 X83.668 Y98.711 E.0085
G1 X83.831 Y98.345 E.00849
G1 X84.149 Y97.845 E.01254
G1 X85.334 Y96.482 E.03824
G1 X80.368 Y96.482 E.10512
G1 X80.129 Y96.454 E.00508
G1 X79.856 Y96.341 E.00626
G1 X79.729 Y96.24 E.00344
G1 X79.621 Y96.119 E.00343
G1 X79.515 Y95.925 E.00467
G1 X79.48 Y95.816 E.00243
G1 X79.451 Y95.565 E.00535
G1 X79.451 Y77.628 E.37965
G1 X79.487 Y77.357 E.00578
G1 X79.547 Y77.207 E.00343
G1 X79.632 Y77.069 E.00343
G1 X79.814 Y76.89 E.0054
G1 X80.035 Y76.774 E.00528
G1 X80.286 Y76.723 E.00543
G1 X93.345 Y76.721 E.2764
G1 X93.481 Y76.735 E.00289
G1 X93.632 Y76.775 E.00332
G1 X93.862 Y76.904 E.00556
G1 X93.805 Y77.082 E.00395
G1 X80.787 Y77.082 E.27555
G1 X80.528 Y77.119 E.00553
G1 X80.226 Y77.272 E.00717
G1 X80.002 Y77.495 E.00668
G1 X79.85 Y77.798 E.00717
G1 X79.812 Y78.056 E.00553
G1 X79.812 Y95.137 E.36153
G1 X79.836 Y95.342 E.00437
G1 X79.93 Y95.587 E.00556
G1 X80.083 Y95.8 E.00555
G1 X80.276 Y95.962 E.00533
G1 X80.538 Y96.084 E.0061
G1 X80.787 Y96.12 E.00533
G1 X88.015 Y96.12 E.153
; WIPE_START
M204 S6000
G1 X90.015 Y96.12 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X89.228 Y96.892 Z3.48 F18000
G1 Z3.08
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X89.835 Y97.59 E.01819
G1 X90.085 Y97.957 E.00873
G1 X90.293 Y98.359 E.00891
G1 X90.452 Y98.78 E.00885
G1 X90.56 Y99.22 E.00891
G1 X90.593 Y99.437 E.00431
G1 X90.621 Y99.889 E.00891
G1 X90.596 Y100.339 E.00887
G1 X90.541 Y100.67 E.0066
G1 X90.459 Y100.997 E.00664
G1 X90.303 Y101.42 E.00887
G1 X90.097 Y101.824 E.00891
G1 X89.981 Y102.009 E.00431
G1 X89.705 Y102.372 E.00897
G1 X89.396 Y102.691 E.00873
G1 X89.045 Y102.977 E.00891
G1 X88.665 Y103.218 E.00885
G1 X88.259 Y103.412 E.00885
G1 X87.83 Y103.557 E.00891
G1 X87.617 Y103.608 E.0043
G1 X87.169 Y103.676 E.00891
G1 X86.719 Y103.689 E.00885
G1 X86.271 Y103.649 E.00885
G1 X85.828 Y103.555 E.00891
G1 X85.619 Y103.491 E.0043
G1 X85.199 Y103.321 E.00891
G1 X84.805 Y103.103 E.00885
G1 X84.44 Y102.84 E.00885
G1 X84.108 Y102.536 E.00885
G1 X83.815 Y102.195 E.00885
G1 X83.564 Y101.821 E.00885
G1 X83.361 Y101.422 E.00881
G1 X83.175 Y100.89 E.01108
G1 X83.067 Y100.336 E.01111
G1 X83.042 Y99.889 E.00881
G1 X83.07 Y99.44 E.00885
G1 X83.151 Y98.997 E.00885
G1 X83.284 Y98.567 E.00885
G1 X83.467 Y98.156 E.00885
G1 X83.7 Y97.767 E.00891
G1 X83.828 Y97.59 E.0043
G1 X84.436 Y96.891 E.01822
G1 X80.344 Y96.891 E.08049
G1 X80.034 Y96.855 E.00613
G1 X79.748 Y96.75 E.006
G1 X79.626 Y96.68 E.00277
G1 X79.447 Y96.539 E.00448
G1 X79.296 Y96.369 E.00448
G1 X79.216 Y96.247 E.00286
G1 X79.134 Y96.076 E.00373
G1 X79.078 Y95.902 E.00359
G1 X79.042 Y95.589 E.00621
G1 X79.042 Y77.61 E.35362
G1 X79.062 Y77.374 E.00466
G1 X79.095 Y77.234 E.00283
G1 X79.18 Y77.022 E.00448
G1 X79.299 Y76.828 E.00448
G1 X79.392 Y76.718 E.00283
G1 X79.564 Y76.565 E.00454
G1 X79.684 Y76.486 E.00283
G1 X79.892 Y76.389 E.0045
G1 X80.071 Y76.339 E.00366
G1 X80.258 Y76.313 E.00373
G1 X93.365 Y76.312 E.2578
G1 X93.554 Y76.331 E.00374
G1 X93.772 Y76.389 E.00444
G1 X93.976 Y76.484 E.00442
G1 X94.16 Y76.613 E.00442
G1 X94.319 Y76.772 E.00442
G1 X94.448 Y76.956 E.00442
G1 X94.543 Y77.16 E.00442
G1 X94.601 Y77.377 E.00442
G1 X94.622 Y77.61 E.0046
G1 X94.622 Y85.511 E.1554
G1 X96.662 Y85.511 E.04013
G1 F1870.275
G1 X96.792 Y85.511 E.00256
G1 F1320
G1 X96.792 Y87.691 E.04288
G1 F1668.612
G1 X96.662 Y87.691 E.00256
G1 F1500
G1 X94.622 Y87.691 E.04013
G1 X94.622 Y88.791 E.02164
G1 X93.442 Y88.791 E.02321
G1 X93.442 Y77.491 E.22226
G1 X80.816 Y77.491 E.24833
G1 X80.653 Y77.515 E.00325
G1 X80.468 Y77.608 E.00407
G1 X80.338 Y77.737 E.00361
G1 X80.246 Y77.922 E.00407
G1 X80.222 Y78.086 E.00325
G1 X80.222 Y95.113 E.33491
G1 X80.237 Y95.244 E.00258
G1 X80.293 Y95.391 E.00311
G1 X80.386 Y95.519 E.00311
G1 X80.498 Y95.614 E.00289
G1 X80.656 Y95.687 E.00343
G1 X80.816 Y95.711 E.00319
G1 X93.024 Y95.711 E.24011
G1 X93.057 Y95.329 E.00753
G1 X93.103 Y95.16 E.00345
G1 X93.237 Y94.913 E.00554
G1 X93.374 Y94.763 E.00398
G1 X93.536 Y94.645 E.00394
G1 X93.719 Y94.563 E.00395
G1 X94.015 Y94.496 E.00597
G1 X97.672 Y89.273 E.12543
G1 X98.639 Y89.95 E.02321
G1 X94.98 Y95.175 E.12546
G1 X95.019 Y95.557 E.00756
G1 X94.966 Y95.822 E.00531
G1 X94.846 Y96.063 E.0053
G1 X94.653 Y96.27 E.00557
G1 X94.508 Y96.368 E.00344
G1 X94.301 Y96.459 E.00445
G1 X94.096 Y96.639 E.00538
G1 X93.906 Y96.755 E.00438
G1 X93.698 Y96.837 E.00438
G1 X93.483 Y96.881 E.00433
G1 X89.288 Y96.892 E.0825
; WIPE_START
M204 S6000
G1 X89.835 Y97.59 E-.1685
G1 X90.085 Y97.957 E-.0843
G1 X90.293 Y98.359 E-.0861
G1 X90.37 Y98.562 E-.0411
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




G1 X89.08 Y97.917
G1 Z3.08
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.376752
G1 F1500
M204 S6000
G1 X88.728 Y97.549 E.00891
; LINE_WIDTH: 0.403753
G1 X88.701 Y97.523 E.00071
; LINE_WIDTH: 0.43027
G1 X88.491 Y97.343 E.00558
; LINE_WIDTH: 0.476097
G1 X88.281 Y97.163 E.00622
; WIPE_START
G1 X88.491 Y97.343 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X89.08 Y97.917 Z3.48 F18000
G1 Z3.08
G1 E.4 F1800
; LINE_WIDTH: 0.360784
G1 F1500
M204 S6000
G1 X89.402 Y98.353 E.00907
G1 X89.57 Y98.681 E.00616
G1 X89.697 Y99.011 E.00591
G1 X89.809 Y99.526 E.0088
G1 X89.831 Y99.891 E.00611
G1 X89.805 Y100.286 E.00661
G1 X89.703 Y100.771 E.00829
G1 X89.493 Y101.279 E.00919
G1 X89.3 Y101.596 E.0062
G1 X89.097 Y101.868 E.00569
G1 X88.989 Y101.981 E.00261
G1 X88.745 Y102.204 E.00553
G1 X88.275 Y102.531 E.00956
G1 X87.783 Y102.741 E.00895
G1 X87.421 Y102.841 E.00628
G1 X87.053 Y102.892 E.00621
G1 X86.533 Y102.884 E.0087
G1 X85.977 Y102.774 E.00947
G1 X85.54 Y102.607 E.00783
G1 X85.228 Y102.435 E.00595
G1 X84.9 Y102.195 E.00679
G1 X84.64 Y101.948 E.00599
G1 X84.39 Y101.641 E.00662
G1 X84.124 Y101.189 E.00878
G1 X83.937 Y100.685 E.00899
G1 X83.852 Y100.238 E.0076
G1 X83.835 Y99.891 E.0058
G1 X83.859 Y99.536 E.00594
G1 X83.943 Y99.096 E.0075
G1 X84.14 Y98.577 E.00927
G1 X84.363 Y98.204 E.00726
G1 X84.469 Y98.053 E.00309
G1 X84.888 Y97.594 E.01039
; LINE_WIDTH: 0.413673
G1 X85.128 Y97.378 E.00625
; LINE_WIDTH: 0.463496
G1 X85.368 Y97.162 E.00705
; WIPE_START
G1 X85.128 Y97.378 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X80.315 Y96.239 Z3.48 F18000
G1 Z3.08
G1 E.4 F1800
; LINE_WIDTH: 0.102677
G1 F1500
M204 S6000
G1 X80.131 Y96.178 E.00074
; LINE_WIDTH: 0.153488
G1 X79.884 Y95.996 E.00196
G1 X79.682 Y95.689 E.00234
M204 S10000
G1 X79.697 Y95.637 F18000
; LINE_WIDTH: 0.0851108
G1 F1500
M204 S6000
G1 X79.837 Y96.042 E.00127
; WIPE_START
G1 X79.697 Y95.637 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X87.324 Y95.915 Z3.48 F18000
G1 X93.61 Y96.144 Z3.48
G1 Z3.08
G1 E.4 F1800
; LINE_WIDTH: 0.109793
G1 F1500
M204 S6000
G1 X93.837 Y96.009 E.00111
; WIPE_START
G1 X93.61 Y96.144 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X94.309 Y88.543 Z3.48 F18000
G1 X94.487 Y86.601 Z3.48
G1 Z3.08
G1 E.4 F1800
; LINE_WIDTH: 0.114562
G1 F1500
M204 S6000
G1 X95.747 Y86.601 E.00558
; WIPE_START
G1 X94.487 Y86.601 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X88.18 Y82.302 Z3.48 F18000
M73 P66 R8
G1 X80.336 Y76.955 Z3.48
G1 Z3.08
G1 E.4 F1800
; LINE_WIDTH: 0.0894025
G1 F1500
M204 S6000
G1 X80.231 Y76.99 E.00035
; LINE_WIDTH: 0.123735
G1 X80.061 Y77.059 E.00089
; LINE_WIDTH: 0.151795
G1 X79.894 Y77.201 E.00138
G1 X79.788 Y77.329 E.00105
G1 X79.739 Y77.434 E.00073
; LINE_WIDTH: 0.10263
G1 X79.688 Y77.598 E.00066
; WIPE_START
G1 X79.739 Y77.434 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X86.688 Y80.591 Z3.48 F18000
G1 X99.634 Y86.471 Z3.48
G1 Z3.08
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X99.909 Y86.078 E.00944
G1 X100.397 Y86.42 E.01171
G1 X100.876 Y86.755 E.0115
G1 X100.601 Y87.148 E.00944
G1 X99.683 Y86.506 E.02203
M204 S10000
G1 X99.939 Y86.392 F18000
; FEATURE: Gap infill
; LINE_WIDTH: 0.0965153
G1 F1500
M204 S6000
G1 X100.571 Y86.834 E.00272
; CHANGE_LAYER
; Z_HEIGHT: 3.2
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F1500
G1 X99.939 Y86.392 E-.38
; WIPE_END
G1 E-.02 F1800
; layer num/total_layer_count: 26/49
; update layer progress
M73 L26
M991 S0 P25 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z3.48 I.01 J-1.217 P1  F18000
G1 X94.275 Y86.344 Z3.48
G1 Z3.2
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X96.13 Y86.344 E.03927
G1 X96.13 Y86.857 E.01086
G1 X94.275 Y86.857 E.03927
G1 X94.275 Y86.404 E.00959
; WIPE_START
M204 S6000
G1 X96.13 Y86.344 E-.35267
G1 X96.13 Y86.488 E-.02733
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X93.851 Y84.415 Z3.6 F18000
G1 Z3.2
G1 E.4 F1800
G1 F1500
M204 S500
G1 X93.851 Y77.127 E.15425
G1 X94.029 Y77.071 E.00395
G1 X94.092 Y77.162 E.00234
G1 X94.157 Y77.3 E.00324
G1 X94.197 Y77.448 E.00324
G1 X94.212 Y77.628 E.00382
G1 X94.212 Y85.92 E.17551
G1 X96.555 Y85.92 E.04957
G1 X96.555 Y87.282 E.02882
G1 X94.212 Y87.282 E.04957
G1 X94.212 Y88.382 E.02328
G1 X93.851 Y88.382 E.00765
G1 X93.851 Y84.475 E.08269
; WIPE_START
M204 S6000
G1 X93.851 Y82.475 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X93.869 Y90.107 Z3.6 F18000
G1 X93.882 Y95.466 Z3.6
G1 Z3.2
G1 E.4 F1800
G1 F1500
M204 S500
G1 X93.932 Y95.388 E.00195
G1 X93.985 Y95.358 E.00129
G1 X94.159 Y95.318 E.00378
G1 X94.184 Y95.493 E.00373
G1 X94.168 Y95.581 E.0019
G1 X94.127 Y95.619 E.00118
G1 X93.858 Y95.743 E.00628
G1 X93.877 Y95.525 E.00463
; WIPE_START
M204 S6000
G1 X93.932 Y95.388 E-.04599
G1 X93.985 Y95.358 E-.01893
G1 X94.159 Y95.318 E-.05539
G1 X94.184 Y95.493 E-.05472
G1 X94.168 Y95.581 E-.0278
G1 X94.127 Y95.619 E-.0173
G1 X93.858 Y95.743 E-.09204
G1 X93.877 Y95.525 E-.06784
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X87.987 Y97.094 Z3.6 F18000
G1 Z3.2
G1 E.4 F1800
G1 F1500
M204 S500
G1 X87.773 Y97.002 E.00491
G1 X87.246 Y96.882 E.01144
G1 X86.799 Y96.857 E.00948
G1 X86.508 Y96.873 E.00617
G1 X86.154 Y96.932 E.0076
G1 X85.789 Y97.038 E.00804
G1 X85.69 Y97.084 E.00232
G1 X85.567 Y96.915 E.00442
G1 X85.91 Y96.544 E.01069
G1 X87.754 Y96.544 E.03903
G1 X88.105 Y96.925 E.01098
G1 X88.021 Y97.045 E.00309
; WIPE_START
M204 S6000
G1 X87.773 Y97.002 E-.04781
G1 X87.246 Y96.882 E-.10268
G1 X86.799 Y96.857 E-.0851
G1 X86.508 Y96.873 E-.05541
G1 X86.154 Y96.932 E-.06824
G1 X86.049 Y96.963 E-.02076
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X88.989 Y101.374 Z3.6 F18000
G1 Z3.2
G1 E.4 F1800
G1 F1500
M204 S500
G1 X88.906 Y101.505 E.00327
G1 X88.586 Y101.849 E.00995
G1 X88.213 Y102.129 E.00986
G1 X87.873 Y102.304 E.0081
G1 X87.63 Y102.397 E.00551
G1 X87.193 Y102.497 E.0095
G1 X86.871 Y102.521 E.00683
G1 X86.549 Y102.506 E.00683
G1 X86.096 Y102.417 E.00975
G1 X85.654 Y102.244 E.01006
G1 X85.2 Y101.953 E.01143
G1 X84.81 Y101.571 E.01155
G1 X84.547 Y101.185 E.00987
G1 X84.407 Y100.895 E.00683
G1 X84.303 Y100.589 E.00683
G1 X84.22 Y100.136 E.00975
G1 X84.22 Y99.666 E.00994
G1 X84.304 Y99.203 E.00995
G1 X84.466 Y98.772 E.00975
G1 X84.623 Y98.49 E.00683
G1 X84.813 Y98.229 E.00683
G1 X85.136 Y97.901 E.00975
G1 X85.521 Y97.63 E.00995
G1 X85.939 Y97.437 E.00975
G1 X86.248 Y97.346 E.00683
G1 X86.555 Y97.295 E.00657
G1 X86.799 Y97.282 E.00518
G1 X87.187 Y97.304 E.00822
G1 X87.642 Y97.407 E.00987
G1 X88.074 Y97.592 E.00995
G1 X88.466 Y97.851 E.00995
G1 X88.806 Y98.176 E.00995
G1 X89.082 Y98.556 E.00995
G1 X89.281 Y98.968 E.00968
G1 X89.358 Y99.211 E.00539
G1 X89.435 Y99.591 E.00822
G1 X89.449 Y100.063 E.00998
G1 X89.36 Y100.595 E.01142
G1 X89.162 Y101.104 E.01155
G1 X89.021 Y101.324 E.00552
M204 S250
G1 X88.644 Y101.154 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X88.581 Y101.253 E.00232
G1 X88.311 Y101.544 E.0078
G1 X87.995 Y101.781 E.00777
G1 X87.706 Y101.93 E.0064
G1 X87.511 Y102.004 E.0041
G1 X87.131 Y102.091 E.00765
G1 X86.865 Y102.111 E.00526
G1 X86.598 Y102.099 E.00526
G1 X86.212 Y102.023 E.00774
G1 X85.841 Y101.878 E.00783
G1 X85.456 Y101.631 E.009
G1 X85.125 Y101.307 E.00911
G1 X84.902 Y100.98 E.00777
G1 X84.786 Y100.739 E.00526
G1 X84.7 Y100.486 E.00526
G1 X84.63 Y100.099 E.00774
G1 X84.63 Y99.703 E.00779
G1 X84.7 Y99.313 E.0078
G1 X84.839 Y98.945 E.00773
G1 X84.969 Y98.711 E.00526
G1 X85.126 Y98.495 E.00526
G1 X85.402 Y98.214 E.00774
G1 X85.726 Y97.986 E.0078
G1 X86.083 Y97.821 E.00773
G1 X86.34 Y97.746 E.00526
G1 X86.6 Y97.703 E.00518
G1 X86.799 Y97.692 E.00393
G1 X87.129 Y97.71 E.00651
G1 X87.515 Y97.798 E.00777
G1 X87.879 Y97.954 E.0078
G1 X88.21 Y98.172 E.0078
G1 X88.497 Y98.446 E.0078
G1 X88.73 Y98.767 E.00779
G1 X88.9 Y99.12 E.00771
G1 X88.962 Y99.314 E.00399
G1 X89.027 Y99.638 E.00651
G1 X89.039 Y100.035 E.00781
G1 X88.963 Y100.486 E.009
G1 X88.795 Y100.918 E.00911
G1 X88.676 Y101.103 E.00433
; WIPE_START
M204 S6000
G1 X88.581 Y101.253 E-.03379
G1 X88.311 Y101.544 E-.07532
G1 X87.995 Y101.781 E-.07504
G1 X87.706 Y101.93 E-.06183
G1 X87.511 Y102.004 E-.03965
G1 X87.131 Y102.091 E-.07394
G1 X87.024 Y102.099 E-.02044
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X88.001 Y96.12 Z3.6 F18000
G1 Z3.2
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X93.399 Y96.12 E.11424
G1 X93.463 Y95.392 E.01548
G1 X93.515 Y95.242 E.00336
G1 X93.564 Y95.161 E.00201
G1 X93.742 Y95.002 E.00504
G1 X93.85 Y94.953 E.00251
G1 X94.259 Y94.861 E.00888
G1 X97.773 Y89.843 E.12966
G1 X98.069 Y90.05 E.00765
G1 X94.552 Y95.072 E.12977
G1 X94.61 Y95.479 E.0087
G1 X94.58 Y95.681 E.00432
G1 X94.475 Y95.873 E.00464
G1 X94.31 Y96.008 E.0045
G1 X94.079 Y96.109 E.00535
G1 X93.852 Y96.308 E.00638
G1 X93.723 Y96.387 E.00321
G1 X93.581 Y96.443 E.00322
G1 X93.441 Y96.472 E.00304
G1 X88.277 Y96.485 E.10931
G1 X89.376 Y97.675 E.03429
G1 X89.632 Y98.007 E.00887
G1 X89.919 Y98.526 E.01255
G1 X90.06 Y98.901 E.00849
G1 X90.186 Y99.48 E.01254
G1 X90.211 Y99.893 E.00876
G1 X90.198 Y100.185 E.00619
G1 X90.16 Y100.486 E.00642
G1 X90.067 Y100.879 E.00855
G1 X89.928 Y101.256 E.00849
G1 X89.741 Y101.622 E.00869
G1 X89.462 Y102.021 E.01031
G1 X89.266 Y102.245 E.0063
G1 X88.889 Y102.58 E.01067
G1 X88.461 Y102.861 E.01084
G1 X88.104 Y103.032 E.00837
G1 X87.716 Y103.164 E.00869
G1 X87.132 Y103.267 E.01254
G1 X86.731 Y103.279 E.00849
G1 X86.332 Y103.243 E.00849
G1 X85.93 Y103.159 E.00869
G1 X85.375 Y102.951 E.01253
G1 X85.024 Y102.757 E.00849
G1 X84.699 Y102.522 E.00849
G1 X84.403 Y102.251 E.0085
G1 X84.141 Y101.947 E.00849
G1 X83.918 Y101.613 E.00849
G1 X83.738 Y101.261 E.00838
G1 X83.573 Y100.787 E.01061
G1 X83.474 Y100.285 E.01084
G1 X83.452 Y99.89 E.00837
G1 X83.477 Y99.49 E.00849
G1 X83.549 Y99.095 E.00849
G1 X83.668 Y98.712 E.00849
G1 X83.831 Y98.345 E.00849
G1 X84.037 Y98 E.00849
G1 X84.288 Y97.675 E.00869
G1 X85.39 Y96.482 E.03439
G1 X80.368 Y96.482 E.1063
G1 X80.129 Y96.454 E.00508
G1 X79.93 Y96.381 E.0045
G1 X79.799 Y96.301 E.00324
G1 X79.641 Y96.145 E.0047
G1 X79.571 Y96.041 E.00266
G1 X79.48 Y95.816 E.00513
G1 X79.451 Y95.565 E.00535
G1 X79.451 Y77.628 E.37965
G1 X79.487 Y77.357 E.00578
G1 X79.547 Y77.207 E.00343
G1 X79.632 Y77.069 E.00344
G1 X79.807 Y76.896 E.0052
G1 X80.023 Y76.778 E.00521
G1 X80.28 Y76.723 E.00558
G1 X93.346 Y76.721 E.27655
G1 X93.48 Y76.735 E.00285
G1 X93.632 Y76.775 E.00332
G1 X93.862 Y76.904 E.00557
G1 X93.805 Y77.082 E.00395
G1 X80.787 Y77.082 E.27555
G1 X80.528 Y77.119 E.00553
G1 X80.226 Y77.271 E.00717
G1 X80.002 Y77.495 E.00669
G1 X79.85 Y77.798 E.00717
G1 X79.812 Y78.056 E.00553
G1 X79.812 Y95.146 E.36173
G1 X79.848 Y95.386 E.00513
G1 X79.96 Y95.646 E.006
G1 X80.243 Y95.946 E.00873
G1 X80.537 Y96.084 E.00688
G1 X80.787 Y96.12 E.00533
G1 X87.941 Y96.12 E.15144
; WIPE_START
M204 S6000
G1 X89.941 Y96.12 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X89.209 Y96.892 Z3.6 F18000
G1 Z3.2
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X89.689 Y97.411 E.0139
G1 X89.967 Y97.772 E.00897
G1 X90.085 Y97.957 E.00431
G1 X90.293 Y98.359 E.00891
G1 X90.452 Y98.78 E.00885
G1 X90.56 Y99.22 E.00891
G1 X90.593 Y99.437 E.00431
G1 X90.621 Y99.89 E.00893
G1 X90.606 Y100.22 E.00651
G1 X90.564 Y100.56 E.00672
G1 X90.459 Y100.998 E.00887
G1 X90.303 Y101.42 E.00885
G1 X90.097 Y101.824 E.00891
G1 X89.98 Y102.01 E.00433
G1 X89.781 Y102.278 E.00657
G1 X89.557 Y102.534 E.00669
G1 X89.138 Y102.905 E.01101
G1 X88.663 Y103.219 E.0112
G1 X88.259 Y103.412 E.00881
G1 X87.83 Y103.557 E.00891
G1 X87.617 Y103.608 E.0043
G1 X87.169 Y103.676 E.00891
G1 X86.719 Y103.689 E.00885
G1 X86.271 Y103.649 E.00885
G1 X85.828 Y103.555 E.00891
G1 X85.619 Y103.491 E.0043
G1 X85.199 Y103.321 E.00891
G1 X84.805 Y103.103 E.00885
G1 X84.44 Y102.84 E.00885
G1 X84.108 Y102.536 E.00885
G1 X83.815 Y102.195 E.00885
G1 X83.564 Y101.821 E.00885
G1 X83.361 Y101.422 E.00881
G1 X83.177 Y100.895 E.01098
G1 X83.067 Y100.336 E.0112
G1 X83.042 Y99.889 E.00881
G1 X83.07 Y99.44 E.00885
G1 X83.151 Y98.997 E.00885
G1 X83.284 Y98.567 E.00885
G1 X83.467 Y98.156 E.00885
G1 X83.698 Y97.77 E.00885
G1 X83.975 Y97.411 E.00891
G1 X84.455 Y96.891 E.01393
G1 X80.344 Y96.891 E.08086
G1 X80.034 Y96.855 E.00613
G1 X79.75 Y96.751 E.00594
G1 X79.559 Y96.633 E.00442
G1 X79.448 Y96.54 E.00285
G1 X79.319 Y96.399 E.00376
G1 X79.215 Y96.246 E.00364
G1 X79.133 Y96.075 E.00372
G1 X79.078 Y95.902 E.00356
G1 X79.042 Y95.589 E.00622
G1 X79.042 Y77.61 E.35362
G1 X79.062 Y77.374 E.00466
G1 X79.095 Y77.234 E.00283
G1 X79.18 Y77.022 E.00448
G1 X79.299 Y76.828 E.00448
G1 X79.392 Y76.718 E.00283
G1 X79.562 Y76.567 E.00448
G1 X79.756 Y76.447 E.00448
G1 X79.888 Y76.39 E.00283
G1 X80.111 Y76.33 E.00454
G1 X80.257 Y76.313 E.00289
G1 X93.367 Y76.312 E.25786
G1 X93.554 Y76.331 E.00371
G1 X93.772 Y76.389 E.00444
G1 X93.976 Y76.484 E.00442
G1 X94.16 Y76.613 E.00442
G1 X94.319 Y76.772 E.00442
G1 X94.448 Y76.956 E.00442
G1 X94.543 Y77.16 E.00442
G1 X94.601 Y77.377 E.00442
G1 X94.622 Y77.61 E.0046
G1 X94.622 Y85.511 E.1554
G1 X96.833 Y85.511 E.0435
G1 F1737.298
G1 X96.919 Y85.511 E.00168
G1 F1680
G1 X96.964 Y85.466 E.00126
G1 F1320
G1 X96.964 Y87.736 E.04466
G1 F1680
G1 X96.919 Y87.691 E.00126
G1 F1930.624
G1 X96.833 Y87.691 E.00168
G1 F1500
G1 X94.622 Y87.691 E.0435
G1 X94.622 Y88.791 E.02164
G1 X93.442 Y88.791 E.02321
G1 X93.442 Y77.491 E.22226
G1 X80.816 Y77.491 E.24833
G1 X80.653 Y77.515 E.00325
G1 X80.468 Y77.608 E.00406
G1 X80.338 Y77.738 E.00362
G1 X80.246 Y77.922 E.00406
G1 X80.222 Y78.086 E.00325
G1 X80.222 Y95.116 E.33498
G1 X80.245 Y95.273 E.00312
G1 X80.307 Y95.418 E.0031
G1 X80.487 Y95.608 E.00515
G1 X80.656 Y95.687 E.00368
G1 X80.816 Y95.711 E.00319
G1 X93.024 Y95.711 E.24011
G1 X93.058 Y95.326 E.00759
G1 X93.083 Y95.22 E.00214
G1 X93.147 Y95.058 E.00345
G1 X93.236 Y94.913 E.00335
G1 X93.375 Y94.762 E.00401
G1 X93.535 Y94.645 E.00391
G1 X93.72 Y94.563 E.00398
G1 X94.015 Y94.496 E.00594
G1 X97.672 Y89.273 E.12543
G1 X98.639 Y89.95 E.02321
G1 X94.98 Y95.175 E.12546
G1 X95.019 Y95.559 E.0076
G1 X94.975 Y95.797 E.00476
G1 X94.851 Y96.056 E.00566
G1 X94.653 Y96.27 E.00573
G1 X94.508 Y96.368 E.00344
G1 X94.301 Y96.459 E.00445
G1 X94.096 Y96.639 E.00538
G1 X93.906 Y96.755 E.00438
G1 X93.698 Y96.837 E.00439
G1 X93.483 Y96.881 E.00433
G1 X89.269 Y96.892 E.08287
; WIPE_START
M204 S6000
G1 X89.689 Y97.411 E-.12681
G1 X89.967 Y97.772 E-.0866
G1 X90.085 Y97.957 E-.04162
G1 X90.293 Y98.359 E-.08609
G1 X90.365 Y98.551 E-.03888
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




G1 X88.701 Y97.53
G1 Z3.2
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.41952
G1 F1500
M204 S6000
G1 X88.463 Y97.328 E.00615
; LINE_WIDTH: 0.466802
G1 X88.224 Y97.125 E.00688
M204 S10000
G1 X88.701 Y97.53 F18000
; LINE_WIDTH: 0.361006
G1 F1500
M204 S6000
G1 X89.086 Y97.92 E.00917
G1 X89.315 Y98.224 E.00635
G1 X89.569 Y98.684 E.0088
G1 X89.695 Y99.014 E.00591
G1 X89.781 Y99.37 E.00611
G1 X89.827 Y99.895 E.00883
G1 X89.78 Y100.421 E.00883
G1 X89.701 Y100.769 E.00597
G1 X89.502 Y101.259 E.00885
G1 X89.324 Y101.563 E.00589
G1 X88.991 Y101.977 E.00888
G1 X88.655 Y102.275 E.00751
G1 X88.273 Y102.528 E.00767
G1 X88.019 Y102.653 E.00473
G1 X87.75 Y102.754 E.0048
G1 X87.236 Y102.869 E.00881
G1 X86.867 Y102.898 E.00621
G1 X86.491 Y102.879 E.00628
G1 X85.977 Y102.774 E.00878
G1 X85.54 Y102.607 E.00783
G1 X85.231 Y102.43 E.00595
M73 P67 R8
G1 X84.938 Y102.228 E.00595
G1 X84.511 Y101.8 E.01012
G1 X84.226 Y101.385 E.00841
G1 X84.055 Y101.028 E.00662
G1 X83.938 Y100.688 E.00601
G1 X83.846 Y100.184 E.00857
G1 X83.844 Y99.647 E.00899
G1 X83.92 Y99.186 E.00782
G1 X84.119 Y98.625 E.00995
G1 X84.3 Y98.295 E.00629
G1 X84.533 Y97.976 E.00662
G1 X84.873 Y97.615 E.00829
; LINE_WIDTH: 0.397375
G1 X85.021 Y97.483 E.00368
; LINE_WIDTH: 0.435682
G1 X85.146 Y97.373 E.0034
; LINE_WIDTH: 0.470849
G1 X85.272 Y97.264 E.0037
; LINE_WIDTH: 0.477036
G1 X85.288 Y97.266 E.00037
; LINE_WIDTH: 0.449219
G1 X85.448 Y97.3 E.00347
; LINE_WIDTH: 0.416402
G1 X85.609 Y97.334 E.0032
; WIPE_START
G1 X85.448 Y97.3 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X80.315 Y96.239 Z3.6 F18000
G1 Z3.2
G1 E.4 F1800
; LINE_WIDTH: 0.106864
G1 F1500
M204 S6000
G1 X80.08 Y96.156 E.00101
; LINE_WIDTH: 0.159408
G1 X79.931 Y96.035 E.00127
G1 X79.765 Y95.828 E.00177
; LINE_WIDTH: 0.120741
G1 X79.742 Y95.781 E.00025
; LINE_WIDTH: 0.0929744
G1 X79.695 Y95.626 E.00054
; WIPE_START
G1 X79.742 Y95.781 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X87.372 Y95.98 Z3.6 F18000
G1 X93.61 Y96.144 Z3.6
G1 Z3.2
G1 E.4 F1800
; LINE_WIDTH: 0.109796
G1 F1500
M204 S6000
G1 X93.837 Y96.009 E.00111
; WIPE_START
G1 X93.61 Y96.144 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X94.309 Y88.543 Z3.6 F18000
G1 X94.487 Y86.601 Z3.6
G1 Z3.2
G1 E.4 F1800
; LINE_WIDTH: 0.114562
G1 F1500
M204 S6000
G1 X95.918 Y86.601 E.00634
; WIPE_START
G1 X94.487 Y86.601 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X88.18 Y82.302 Z3.6 F18000
G1 X80.336 Y76.956 Z3.6
G1 Z3.2
G1 E.4 F1800
; LINE_WIDTH: 0.0829123
G1 F1500
M204 S6000
G1 X80.296 Y76.965 E.00012
; LINE_WIDTH: 0.115834
G1 X80.061 Y77.059 E.00114
; LINE_WIDTH: 0.151603
G1 X79.894 Y77.201 E.00138
G1 X79.788 Y77.329 E.00105
G1 X79.739 Y77.434 E.00073
; LINE_WIDTH: 0.10261
G1 X79.688 Y77.598 E.00066
; WIPE_START
G1 X79.739 Y77.434 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X86.688 Y80.591 Z3.6 F18000
G1 X99.634 Y86.471 Z3.6
G1 Z3.2
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X99.909 Y86.078 E.00944
G1 X100.423 Y86.438 E.01234
G1 X100.876 Y86.755 E.01087
G1 X100.601 Y87.148 E.00944
G1 X99.683 Y86.506 E.02203
M204 S10000
G1 X99.939 Y86.392 F18000
; FEATURE: Gap infill
; LINE_WIDTH: 0.0965135
G1 F1500
M204 S6000
G1 X100.571 Y86.834 E.00272
; CHANGE_LAYER
; Z_HEIGHT: 3.32
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F1500
G1 X99.939 Y86.392 E-.38
; WIPE_END
G1 E-.02 F1800
; layer num/total_layer_count: 27/49
; update layer progress
M73 L27
M991 S0 P26 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z3.6 I-.006 J-1.217 P1  F18000
G1 X94.275 Y86.421 Z3.6
G1 Z3.32
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X96.302 Y86.421 E.04289
G1 X96.302 Y86.781 E.00762
G1 X94.275 Y86.781 E.04289
G1 X94.275 Y86.481 E.00635
; WIPE_START
M204 S6000
G1 X96.274 Y86.422 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X93.851 Y84.472 Z3.72 F18000
G1 Z3.32
G1 E.4 F1800
G1 F1500
M204 S500
G1 X93.851 Y77.127 E.15547
G1 X94.029 Y77.071 E.00395
G1 X94.092 Y77.162 E.00234
G1 X94.157 Y77.301 E.00324
G1 X94.197 Y77.448 E.00324
G1 X94.212 Y77.628 E.00382
G1 X94.212 Y85.997 E.17713
G1 X96.726 Y85.997 E.0532
G1 X96.726 Y87.205 E.02558
G1 X94.212 Y87.205 E.0532
G1 X94.212 Y88.382 E.0249
G1 X93.851 Y88.382 E.00765
G1 X93.851 Y84.532 E.08147
; WIPE_START
M204 S6000
G1 X93.851 Y82.532 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X93.869 Y90.165 Z3.72 F18000
G1 X93.881 Y95.474 Z3.72
G1 Z3.32
G1 E.4 F1800
G1 F1500
M204 S500
G1 X93.893 Y95.43 E.00098
G1 X93.94 Y95.379 E.00147
G1 X94.158 Y95.319 E.00478
G1 X94.189 Y95.516 E.00422
G1 X94.107 Y95.634 E.00303
G1 X93.858 Y95.743 E.00576
G1 X93.876 Y95.534 E.00444
; WIPE_START
M204 S6000
G1 X93.893 Y95.43 E-.03281
G1 X93.94 Y95.379 E-.0215
G1 X94.158 Y95.319 E-.07008
G1 X94.189 Y95.516 E-.06189
G1 X94.107 Y95.634 E-.04435
G1 X93.858 Y95.743 E-.08433
G1 X93.876 Y95.534 E-.06504
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X88.021 Y97.102 Z3.72 F18000
G1 Z3.32
G1 E.4 F1800
G1 F1500
M204 S500
G1 X87.93 Y97.059 E.00212
G1 X87.412 Y96.908 E.01143
G1 X86.779 Y96.853 E.01343
G1 X86.161 Y96.927 E.01318
G1 X85.597 Y97.11 E.01255
G1 X85.491 Y96.949 E.0041
G1 X85.842 Y96.544 E.01135
G1 X87.796 Y96.544 E.04136
G1 X88.144 Y96.935 E.01108
G1 X88.057 Y97.053 E.00311
; WIPE_START
M204 S6000
G1 X87.93 Y97.059 E-.0241
G1 X87.412 Y96.908 E-.10262
G1 X86.779 Y96.853 E-.12055
G1 X86.161 Y96.927 E-.11827
G1 X86.089 Y96.951 E-.01446
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X88.97 Y101.411 Z3.72 F18000
G1 Z3.32
G1 E.4 F1800
G1 F1500
M204 S500
G1 X88.699 Y101.741 E.00904
G1 X88.337 Y102.048 E.01005
G1 X87.868 Y102.309 E.01138
G1 X87.344 Y102.473 E.01161
G1 X86.866 Y102.523 E.01018
G1 X86.331 Y102.474 E.01137
G1 X85.806 Y102.314 E.01161
G1 X85.387 Y102.089 E.01007
G1 X85.02 Y101.796 E.00995
G1 X84.711 Y101.442 E.00995
G1 X84.467 Y101.034 E.01007
G1 X84.283 Y100.517 E.01161
G1 X84.211 Y99.984 E.01137
G1 X84.239 Y99.505 E.01016
G1 X84.375 Y98.985 E.01137
G1 X84.619 Y98.494 E.01161
G1 X84.91 Y98.118 E.01006
G1 X85.252 Y97.809 E.00975
G1 X85.521 Y97.632 E.00683
G1 X85.81 Y97.487 E.00683
G1 X86.253 Y97.343 E.00985
G1 X86.786 Y97.28 E.01137
G1 X87.333 Y97.327 E.01161
G1 X87.78 Y97.458 E.00987
G1 X88.073 Y97.593 E.00683
G1 X88.348 Y97.763 E.00683
G1 X88.703 Y98.064 E.00986
G1 X89.038 Y98.484 E.01137
G1 X89.285 Y98.974 E.01161
G1 X89.411 Y99.433 E.01007
G1 X89.453 Y99.901 E.00995
G1 X89.411 Y100.375 E.01007
G1 X89.255 Y100.901 E.01161
G1 X89.007 Y101.363 E.01112
M204 S250
G1 X88.654 Y101.151 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X88.407 Y101.452 E.00767
G1 X88.103 Y101.71 E.00783
G1 X87.705 Y101.931 E.00895
G1 X87.261 Y102.07 E.00916
G1 X86.863 Y102.112 E.00787
G1 X86.41 Y102.07 E.00895
G1 X85.964 Y101.935 E.00916
G1 X85.614 Y101.746 E.00783
G1 X85.304 Y101.499 E.0078
G1 X85.043 Y101.2 E.0078
G1 X84.839 Y100.859 E.00783
G1 X84.683 Y100.42 E.00916
G1 X84.622 Y99.969 E.00895
G1 X84.646 Y99.57 E.00786
G1 X84.76 Y99.129 E.00895
G1 X84.967 Y98.712 E.00916
G1 X85.211 Y98.397 E.00783
G1 X85.503 Y98.134 E.00774
G1 X85.726 Y97.987 E.00526
G1 X85.966 Y97.867 E.00526
G1 X86.341 Y97.745 E.00777
G1 X86.793 Y97.691 E.00895
G1 X87.257 Y97.731 E.00916
G1 X87.636 Y97.842 E.00777
G1 X87.879 Y97.954 E.00526
G1 X88.107 Y98.095 E.00526
G1 X88.408 Y98.35 E.00777
G1 X88.691 Y98.706 E.00895
G1 X88.901 Y99.122 E.00916
G1 X89.007 Y99.506 E.00784
G1 X89.042 Y99.901 E.00779
G1 X89.007 Y100.298 E.00783
G1 X88.875 Y100.744 E.00916
G1 X88.684 Y101.099 E.00793
; WIPE_START
M204 S6000
G1 X88.407 Y101.452 E-.08536
G1 X88.103 Y101.71 E-.0756
G1 X87.705 Y101.931 E-.08648
G1 X87.261 Y102.07 E-.08846
G1 X87.03 Y102.094 E-.0441
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X88.048 Y96.12 Z3.72 F18000
G1 Z3.32
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X93.399 Y96.12 E.11325
G1 X93.462 Y95.401 E.01529
G1 X93.49 Y95.295 E.00232
G1 X93.564 Y95.161 E.00324
G1 X93.738 Y95.004 E.00496
G1 X93.873 Y94.945 E.00311
G1 X94.256 Y94.865 E.00827
G1 X97.773 Y89.843 E.12978
G1 X98.069 Y90.05 E.00765
G1 X94.55 Y95.075 E.12985
G1 X94.609 Y95.455 E.00814
G1 X94.597 Y95.625 E.0036
G1 X94.496 Y95.839 E.00501
G1 X94.384 Y95.958 E.00347
G1 X94.31 Y96.008 E.00187
G1 X94.079 Y96.109 E.00536
G1 X93.852 Y96.308 E.00638
G1 X93.723 Y96.387 E.00321
G1 X93.581 Y96.443 E.00321
G1 X93.441 Y96.472 E.00304
G1 X88.312 Y96.485 E.10856
G1 X89.439 Y97.752 E.0359
G1 X89.73 Y98.161 E.01062
G1 X89.919 Y98.526 E.00869
G1 X90.06 Y98.901 E.00849
G1 X90.158 Y99.3 E.00869
G1 X90.212 Y99.893 E.01261
G1 X90.16 Y100.486 E.0126
G1 X90.066 Y100.883 E.00863
G1 X89.843 Y101.435 E.0126
G1 X89.637 Y101.786 E.00862
G1 X89.465 Y102.017 E.00609
G1 X89.263 Y102.249 E.00651
G1 X88.969 Y102.519 E.00844
G1 X88.561 Y102.802 E.01052
G1 X88.099 Y103.034 E.01094
G1 X87.716 Y103.164 E.00856
G1 X87.132 Y103.267 E.01254
G1 X86.731 Y103.279 E.00849
G1 X86.332 Y103.243 E.00849
G1 X85.939 Y103.161 E.00849
G1 X85.559 Y103.032 E.00849
G1 X85.202 Y102.861 E.00838
G1 X84.786 Y102.589 E.01051
G1 X84.399 Y102.247 E.01093
G1 X84.141 Y101.947 E.00837
G1 X83.918 Y101.613 E.0085
G1 X83.738 Y101.26 E.00838
G1 X83.574 Y100.792 E.01051
G1 X83.474 Y100.285 E.01094
G1 X83.452 Y99.89 E.00837
G1 X83.477 Y99.49 E.00849
G1 X83.549 Y99.095 E.0085
G1 X83.668 Y98.712 E.00849
G1 X83.831 Y98.345 E.00849
G1 X84.149 Y97.845 E.01253
G1 X85.335 Y96.482 E.03825
G1 X80.368 Y96.482 E.10513
G1 X80.12 Y96.453 E.00527
G1 X79.975 Y96.405 E.00324
M73 P67 R7
G1 X79.814 Y96.312 E.00394
G1 X79.693 Y96.204 E.00344
G1 X79.592 Y96.077 E.00343
G1 X79.479 Y95.803 E.00627
G1 X79.451 Y95.565 E.00508
G1 X79.451 Y77.628 E.37965
G1 X79.487 Y77.357 E.00578
G1 X79.592 Y77.125 E.0054
G1 X79.784 Y76.914 E.00605
G1 X80.031 Y76.775 E.00599
G1 X80.281 Y76.723 E.00539
G1 X93.348 Y76.721 E.27658
G1 X93.48 Y76.735 E.00281
G1 X93.632 Y76.775 E.00333
G1 X93.862 Y76.904 E.00556
G1 X93.805 Y77.082 E.00395
G1 X80.781 Y77.082 E.27567
G1 X80.507 Y77.127 E.00588
G1 X80.222 Y77.275 E.00679
G1 X80.002 Y77.495 E.00659
G1 X79.85 Y77.798 E.00717
G1 X79.812 Y78.056 E.00552
G1 X79.812 Y95.137 E.36153
G1 X79.837 Y95.346 E.00445
G1 X79.953 Y95.64 E.00669
G1 X80.243 Y95.946 E.00892
G1 X80.537 Y96.084 E.00688
G1 X80.787 Y96.12 E.00533
G1 X87.988 Y96.12 E.15243
; WIPE_START
M204 S6000
G1 X89.988 Y96.12 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X89.221 Y96.892 Z3.72 F18000
G1 Z3.32
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X89.756 Y97.493 E.01581
G1 X89.967 Y97.771 E.00688
G1 X90.085 Y97.957 E.00433
G1 X90.293 Y98.359 E.00891
G1 X90.452 Y98.78 E.00885
G1 X90.56 Y99.22 E.00891
G1 X90.593 Y99.437 E.00431
G1 X90.621 Y99.89 E.00893
G1 X90.607 Y100.216 E.00642
G1 X90.564 Y100.56 E.00681
G1 X90.459 Y100.999 E.00889
G1 X90.349 Y101.307 E.00642
G1 X90.207 Y101.623 E.00682
G1 X89.978 Y102.013 E.00889
G1 X89.784 Y102.274 E.00642
G1 X89.556 Y102.535 E.00682
G1 X89.225 Y102.839 E.00883
G1 X88.77 Y103.155 E.0109
G1 X88.257 Y103.412 E.01129
G1 X87.83 Y103.557 E.00887
G1 X87.617 Y103.608 E.0043
G1 X87.169 Y103.676 E.00891
G1 X86.719 Y103.689 E.00885
G1 X86.271 Y103.649 E.00885
G1 X85.831 Y103.556 E.00885
G1 X85.405 Y103.412 E.00885
G1 X85 Y103.218 E.00881
G1 X84.537 Y102.915 E.01089
G1 X84.107 Y102.535 E.01129
G1 X83.815 Y102.195 E.00881
G1 X83.564 Y101.821 E.00885
G1 X83.361 Y101.422 E.00882
G1 X83.178 Y100.899 E.01089
G1 X83.067 Y100.336 E.01129
G1 X83.042 Y99.889 E.00881
G1 X83.07 Y99.44 E.00885
G1 X83.151 Y98.997 E.00885
G1 X83.284 Y98.567 E.00885
G1 X83.467 Y98.156 E.00885
G1 X83.7 Y97.767 E.00891
G1 X83.828 Y97.59 E.0043
G1 X84.436 Y96.891 E.01823
G1 X80.344 Y96.891 E.08049
G1 X80.031 Y96.854 E.00619
G1 X79.818 Y96.784 E.00442
G1 X79.564 Y96.637 E.00577
G1 X79.394 Y96.486 E.00448
G1 X79.253 Y96.307 E.00448
G1 X79.182 Y96.185 E.00277
G1 X79.078 Y95.898 E.006
G1 X79.042 Y95.589 E.00613
G1 X79.042 Y77.61 E.35362
G1 X79.062 Y77.374 E.00466
G1 X79.095 Y77.234 E.00283
G1 X79.181 Y77.019 E.00454
G1 X79.253 Y76.895 E.00283
G1 X79.395 Y76.715 E.00451
M73 P68 R7
G1 X79.529 Y76.592 E.00359
G1 X79.686 Y76.485 E.00373
G1 X79.891 Y76.389 E.00444
G1 X80.111 Y76.33 E.00448
G1 X80.257 Y76.313 E.00289
G1 X93.369 Y76.312 E.2579
G1 X93.554 Y76.331 E.00367
G1 X93.772 Y76.389 E.00445
G1 X93.976 Y76.484 E.00442
G1 X94.16 Y76.613 E.00442
G1 X94.319 Y76.772 E.00442
G1 X94.448 Y76.956 E.00442
G1 X94.543 Y77.16 E.00442
G1 X94.601 Y77.377 E.00442
G1 X94.622 Y77.61 E.0046
G1 X94.622 Y85.587 E.1569
G1 X97.005 Y85.587 E.04687
G1 F1704.219
G1 X97.042 Y85.587 E.00072
G1 F2536.476
G1 X97.042 Y85.388 E.00392
G1 F1980
G1 X97.135 Y85.294 E.0026
G1 F1320
G1 X97.135 Y87.907 E.0514
G1 F1980
G1 X97.042 Y87.814 E.0026
G1 F2536.476
G1 X97.042 Y87.614 E.00392
G1 F1704.219
G1 X97.005 Y87.614 E.00072
G1 F1500
G1 X94.622 Y87.614 E.04687
G1 X94.622 Y88.791 E.02314
G1 X93.442 Y88.791 E.02321
G1 X93.442 Y77.491 E.22226
G1 X80.815 Y77.491 E.24836
G1 X80.638 Y77.52 E.00352
G1 X80.467 Y77.609 E.00378
G1 X80.338 Y77.738 E.00359
G1 X80.246 Y77.922 E.00406
G1 X80.222 Y78.086 E.00325
G1 X80.222 Y95.113 E.33491
G1 X80.237 Y95.245 E.00261
G1 X80.305 Y95.416 E.00362
G1 X80.487 Y95.608 E.00521
G1 X80.656 Y95.687 E.00368
G1 X80.816 Y95.711 E.00319
G1 X93.024 Y95.711 E.24011
G1 X93.057 Y95.329 E.00753
G1 X93.103 Y95.16 E.00344
G1 X93.237 Y94.913 E.00554
G1 X93.375 Y94.762 E.00404
G1 X93.534 Y94.646 E.00386
G1 X93.749 Y94.553 E.0046
G1 X94.014 Y94.498 E.00532
G1 X97.672 Y89.273 E.12546
G1 X98.639 Y89.95 E.02321
G1 X94.98 Y95.176 E.12549
G1 X95.017 Y95.422 E.0049
G1 X95.019 Y95.565 E.00281
G1 X94.959 Y95.843 E.0056
G1 X94.831 Y96.081 E.00533
G1 X94.649 Y96.273 E.00519
G1 X94.508 Y96.368 E.00334
G1 X94.301 Y96.459 E.00445
G1 X94.096 Y96.639 E.00538
G1 X93.906 Y96.755 E.00438
G1 X93.698 Y96.837 E.00438
G1 X93.483 Y96.881 E.00432
G1 X89.281 Y96.892 E.08264
; WIPE_START
M204 S6000
G1 X89.756 Y97.493 E-.14542
G1 X89.967 Y97.771 E-.06643
G1 X90.085 Y97.957 E-.04178
G1 X90.293 Y98.359 E-.08609
G1 X90.368 Y98.558 E-.04028
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




G1 X88.964 Y97.789
G1 Z3.32
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.37709
G1 F1500
M204 S6000
G1 X88.784 Y97.613 E.00441
; LINE_WIDTH: 0.415206
G1 X88.577 Y97.413 E.00559
; LINE_WIDTH: 0.452864
G1 X88.414 Y97.28 E.00448
; LINE_WIDTH: 0.481849
G1 X88.252 Y97.147 E.00478
M204 S10000
G1 X88.964 Y97.789 F18000
; LINE_WIDTH: 0.361911
G1 F1500
M204 S6000
G1 X89.14 Y97.995 E.00455
G1 X89.401 Y98.356 E.00748
G1 X89.641 Y98.854 E.00927
G1 X89.782 Y99.38 E.00914
G1 X89.833 Y99.897 E.0087
G1 X89.787 Y100.419 E.00879
G1 X89.696 Y100.769 E.00608
G1 X89.594 Y101.058 E.00513
G1 X89.321 Y101.577 E.00984
G1 X89.166 Y101.776 E.00423
G1 X88.958 Y102.016 E.00533
G1 X88.537 Y102.364 E.00916
G1 X88.001 Y102.662 E.01029
G1 X87.613 Y102.792 E.00685
G1 X87.404 Y102.841 E.00361
G1 X86.853 Y102.899 E.0093
G1 X86.388 Y102.864 E.00781
G1 X86.041 Y102.788 E.00596
G1 X85.646 Y102.656 E.00698
G1 X85.194 Y102.409 E.00865
G1 X84.75 Y102.057 E.00949
G1 X84.445 Y101.716 E.00768
G1 X84.249 Y101.418 E.00597
G1 X84.089 Y101.11 E.00583
G1 X83.923 Y100.621 E.00866
G1 X83.857 Y100.237 E.00655
G1 X83.834 Y99.891 E.00581
G1 X83.87 Y99.43 E.00775
G1 X84.023 Y98.845 E.01015
G1 X84.174 Y98.523 E.00597
G1 X84.308 Y98.28 E.00465
G1 X84.45 Y98.084 E.00405
G1 X84.817 Y97.673 E.00925
; LINE_WIDTH: 0.400597
G1 X84.992 Y97.496 E.00464
; LINE_WIDTH: 0.438393
G1 X85.199 Y97.319 E.00561
; LINE_WIDTH: 0.477106
G1 X85.379 Y97.165 E.00533
; WIPE_START
G1 X85.199 Y97.319 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X80.315 Y96.239 Z3.72 F18000
G1 Z3.32
G1 E.4 F1800
; LINE_WIDTH: 0.107412
G1 F1500
M204 S6000
G1 X80.095 Y96.167 E.00094
; LINE_WIDTH: 0.163829
G1 X79.904 Y96.006 E.00172
G1 X79.685 Y95.744 E.00235
M204 S10000
G1 X79.696 Y95.628 F18000
; LINE_WIDTH: 0.103006
G1 F1500
M204 S6000
G1 X79.735 Y95.77 E.00057
G1 X79.9 Y96.104 E.00143
; WIPE_START
G1 X79.735 Y95.77 E-.27239
G1 X79.696 Y95.628 E-.10761
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X87.323 Y95.911 Z3.72 F18000
G1 X93.61 Y96.144 Z3.72
G1 Z3.32
G1 E.4 F1800
; LINE_WIDTH: 0.109771
G1 F1500
M204 S6000
G1 X93.837 Y96.009 E.00111
; WIPE_START
G1 X93.61 Y96.144 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X89.028 Y90.04 Z3.72 F18000
G1 X79.688 Y77.598 Z3.72
G1 Z3.32
G1 E.4 F1800
; LINE_WIDTH: 0.102598
G1 F1500
M204 S6000
G1 X79.739 Y77.434 E.00066
; LINE_WIDTH: 0.15202
G1 X79.794 Y77.32 E.0008
G1 X80.028 Y77.08 E.00211
; LINE_WIDTH: 0.128823
G1 X80.226 Y76.991 E.00112
; LINE_WIDTH: 0.0896241
G1 X80.332 Y76.955 E.00036
; WIPE_START
G1 X80.226 Y76.991 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X87.084 Y80.341 Z3.72 F18000
G1 X99.634 Y86.471 Z3.72
G1 Z3.32
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X99.909 Y86.078 E.00944
G1 X100.449 Y86.456 E.01297
G1 X100.876 Y86.755 E.01024
G1 X100.601 Y87.148 E.00944
G1 X99.683 Y86.506 E.02203
M204 S10000
G1 X99.939 Y86.392 F18000
; FEATURE: Gap infill
; LINE_WIDTH: 0.0965146
G1 F1500
M204 S6000
G1 X100.571 Y86.834 E.00272
; CHANGE_LAYER
; Z_HEIGHT: 3.44
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F1500
G1 X99.939 Y86.392 E-.38
; WIPE_END
G1 E-.02 F1800
; layer num/total_layer_count: 28/49
; update layer progress
M73 L28
M991 S0 P27 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z3.72 I.36 J-1.163 P1  F18000
G1 X93.851 Y84.507 Z3.72
G1 Z3.44
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X93.851 Y77.127 E.1562
G1 X94.029 Y77.071 E.00395
G1 X94.092 Y77.162 E.00234
G1 X94.157 Y77.3 E.00324
G1 X94.197 Y77.448 E.00325
G1 X94.212 Y77.628 E.00382
G1 X94.212 Y86.08 E.1789
G1 X96.897 Y86.08 E.05683
G1 X96.897 Y87.122 E.02204
G1 X94.212 Y87.122 E.05683
G1 X94.212 Y88.382 E.02667
G1 X93.851 Y88.382 E.00765
G1 X93.851 Y84.567 E.08074
; WIPE_START
M204 S6000
G1 X93.851 Y82.567 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X93.869 Y90.199 Z3.84 F18000
G1 X93.881 Y95.474 Z3.84
G1 Z3.44
G1 E.4 F1800
G1 F1500
M204 S500
G1 X93.893 Y95.43 E.00098
G1 X93.951 Y95.368 E.00179
G1 X94.159 Y95.318 E.00453
G1 X94.188 Y95.521 E.00435
G1 X94.142 Y95.609 E.0021
G1 X93.858 Y95.743 E.00665
G1 X93.876 Y95.534 E.00444
; WIPE_START
M204 S6000
G1 X93.893 Y95.43 E-.03256
G1 X93.951 Y95.368 E-.02604
G1 X94.159 Y95.318 E-.066
G1 X94.188 Y95.521 E-.06337
G1 X94.142 Y95.609 E-.03059
G1 X93.858 Y95.743 E-.0968
G1 X93.876 Y95.534 E-.06464
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X88.051 Y97.116 Z3.84 F18000
G1 Z3.44
G1 E.4 F1800
G1 F1500
M204 S500
G1 X87.93 Y97.059 E.00283
G1 X87.411 Y96.908 E.01144
G1 X86.776 Y96.853 E.01348
G1 X86.161 Y96.927 E.01312
G1 X85.597 Y97.11 E.01255
G1 X85.49 Y96.949 E.0041
G1 X85.842 Y96.544 E.01135
G1 X87.821 Y96.544 E.04188
G1 X88.175 Y96.951 E.01141
G1 X88.087 Y97.068 E.00309
; WIPE_START
M204 S6000
G1 X87.93 Y97.059 E-.02993
G1 X87.411 Y96.908 E-.10268
G1 X86.776 Y96.853 E-.12104
G1 X86.161 Y96.927 E-.1178
G1 X86.118 Y96.941 E-.00856
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X88.971 Y101.411 Z3.84 F18000
G1 Z3.44
G1 E.4 F1800
G1 F1500
M204 S500
G1 X88.699 Y101.741 E.00904
G1 X88.337 Y102.048 E.01005
G1 X87.87 Y102.308 E.01132
G1 X87.344 Y102.473 E.01166
G1 X86.866 Y102.523 E.01018
G1 X86.334 Y102.475 E.01132
G1 X85.806 Y102.314 E.01166
G1 X85.387 Y102.089 E.01008
G1 X85.02 Y101.796 E.00995
G1 X84.711 Y101.442 E.00995
G1 X84.47 Y101.038 E.00995
G1 X84.308 Y100.607 E.00975
G1 X84.241 Y100.292 E.00683
G1 X84.211 Y99.965 E.00693
G1 X84.251 Y99.441 E.01112
G1 X84.403 Y98.912 E.01166
G1 X84.622 Y98.49 E.01007
G1 X84.91 Y98.118 E.00995
G1 X85.252 Y97.809 E.00975
G1 X85.521 Y97.632 E.00683
G1 X85.81 Y97.487 E.00683
G1 X86.253 Y97.343 E.00985
G1 X86.784 Y97.28 E.01132
G1 X87.333 Y97.327 E.01166
G1 X87.78 Y97.458 E.00987
G1 X88.073 Y97.593 E.00683
G1 X88.348 Y97.763 E.00683
G1 X88.699 Y98.061 E.00975
G1 X89.002 Y98.429 E.01007
G1 X89.261 Y98.915 E.01166
G1 X89.411 Y99.428 E.01132
G1 X89.453 Y99.901 E.01005
G1 X89.411 Y100.375 E.01007
G1 X89.254 Y100.903 E.01166
G1 X89.007 Y101.363 E.01106
M204 S250
G1 X88.654 Y101.151 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X88.407 Y101.452 E.00768
G1 X88.103 Y101.71 E.00783
G1 X87.708 Y101.93 E.0089
G1 X87.261 Y102.07 E.00921
G1 X86.863 Y102.112 E.00787
G1 X86.412 Y102.071 E.0089
G1 X85.965 Y101.935 E.00921
G1 X85.614 Y101.746 E.00784
G1 X85.304 Y101.499 E.0078
G1 X85.043 Y101.2 E.0078
G1 X84.84 Y100.86 E.00779
G1 X84.702 Y100.492 E.00773
G1 X84.646 Y100.23 E.00526
G1 X84.622 Y99.962 E.00529
G1 X84.656 Y99.514 E.00884
G1 X84.785 Y99.064 E.00921
G1 X84.968 Y98.711 E.00783
G1 X85.211 Y98.397 E.0078
G1 X85.503 Y98.134 E.00773
G1 X85.726 Y97.987 E.00526
G1 X85.966 Y97.867 E.00526
G1 X86.341 Y97.745 E.00776
G1 X86.791 Y97.691 E.00891
G1 X87.257 Y97.731 E.00921
G1 X87.636 Y97.842 E.00777
G1 X87.879 Y97.954 E.00526
G1 X88.107 Y98.095 E.00526
M73 P69 R7
G1 X88.407 Y98.349 E.00774
G1 X88.66 Y98.657 E.00783
G1 X88.88 Y99.07 E.00921
G1 X89.007 Y99.505 E.0089
G1 X89.042 Y99.901 E.00783
G1 X89.007 Y100.298 E.00783
G1 X88.874 Y100.746 E.00921
G1 X88.684 Y101.099 E.00787
; WIPE_START
M204 S6000
G1 X88.407 Y101.452 E-.0854
G1 X88.103 Y101.71 E-.07561
G1 X87.708 Y101.93 E-.086
G1 X87.261 Y102.07 E-.08892
G1 X87.03 Y102.094 E-.04407
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X88.075 Y96.12 Z3.84 F18000
G1 Z3.44
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X93.399 Y96.12 E.11268
G1 X93.462 Y95.4 E.01529
G1 X93.49 Y95.295 E.00232
G1 X93.564 Y95.161 E.00324
G1 X93.65 Y95.068 E.00267
G1 X93.824 Y94.962 E.00433
G1 X94.262 Y94.857 E.00952
G1 X97.805 Y89.797 E.13074
G1 X98.101 Y90.004 E.00765
G1 X94.552 Y95.072 E.13095
G1 X94.61 Y95.479 E.0087
G1 X94.592 Y95.648 E.0036
G1 X94.475 Y95.873 E.00536
G1 X94.31 Y96.008 E.0045
G1 X94.079 Y96.109 E.00535
G1 X93.852 Y96.308 E.00638
G1 X93.723 Y96.387 E.00321
G1 X93.581 Y96.443 E.00321
G1 X93.441 Y96.472 E.00304
G1 X88.332 Y96.485 E.10814
G1 X89.515 Y97.845 E.03815
G1 X89.73 Y98.162 E.00811
G1 X89.919 Y98.526 E.00869
G1 X90.06 Y98.901 E.00849
G1 X90.156 Y99.291 E.00849
G1 X90.206 Y99.699 E.00869
G1 X90.199 Y100.177 E.01012
G1 X90.16 Y100.487 E.00661
G1 X90.067 Y100.879 E.00855
G1 X89.928 Y101.256 E.00849
G1 X89.741 Y101.622 E.00869
G1 X89.468 Y102.014 E.01012
G1 X89.262 Y102.249 E.00661
G1 X88.958 Y102.529 E.00875
G1 X88.466 Y102.859 E.01254
G1 X88.104 Y103.032 E.00849
G1 X87.715 Y103.164 E.00869
G1 X87.132 Y103.267 E.01253
G1 X86.731 Y103.279 E.00849
G1 X86.332 Y103.243 E.00849
G1 X85.93 Y103.159 E.00869
G1 X85.375 Y102.951 E.01253
G1 X85.024 Y102.757 E.00849
G1 X84.698 Y102.522 E.0085
G1 X84.403 Y102.251 E.00849
G1 X84.141 Y101.947 E.00849
G1 X83.918 Y101.613 E.00849
G1 X83.738 Y101.26 E.00839
G1 X83.575 Y100.796 E.01042
G1 X83.474 Y100.285 E.01103
G1 X83.452 Y99.89 E.00836
G1 X83.477 Y99.49 E.00849
G1 X83.549 Y99.095 E.0085
G1 X83.668 Y98.712 E.00849
G1 X83.831 Y98.345 E.00849
G1 X84.149 Y97.845 E.01254
G1 X85.335 Y96.482 E.03824
G1 X80.368 Y96.482 E.10512
G1 X80.12 Y96.453 E.00527
G1 X79.975 Y96.405 E.00324
G1 X79.811 Y96.31 E.00401
G1 X79.623 Y96.122 E.00562
G1 X79.575 Y96.048 E.00187
G1 X79.481 Y95.821 E.0052
G1 X79.451 Y95.565 E.00546
G1 X79.451 Y77.628 E.37965
G1 X79.487 Y77.357 E.00578
G1 X79.547 Y77.207 E.00343
G1 X79.632 Y77.069 E.00343
G1 X79.807 Y76.896 E.0052
G1 X80.026 Y76.776 E.00529
G1 X80.286 Y76.723 E.00562
G1 X93.35 Y76.722 E.27649
G1 X93.48 Y76.735 E.00278
G1 X93.632 Y76.775 E.00333
G1 X93.862 Y76.904 E.00556
G1 X93.805 Y77.082 E.00395
G1 X80.778 Y77.082 E.27575
G1 X80.489 Y77.132 E.0062
G1 X80.211 Y77.282 E.00669
G1 X79.978 Y77.529 E.00717
G1 X79.849 Y77.807 E.00649
G1 X79.812 Y78.056 E.00532
G1 X79.812 Y95.173 E.3623
G1 X79.897 Y95.53 E.00775
G1 X80.053 Y95.766 E.006
G1 X80.268 Y95.958 E.0061
G1 X80.537 Y96.084 E.00629
G1 X80.787 Y96.12 E.00533
G1 X88.015 Y96.12 E.153
; WIPE_START
M204 S6000
G1 X90.015 Y96.12 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X89.228 Y96.892 Z3.84 F18000
G1 Z3.44
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X89.835 Y97.59 E.0182
G1 X89.965 Y97.77 E.00436
G1 X90.085 Y97.957 E.00437
G1 X90.293 Y98.359 E.00891
G1 X90.452 Y98.78 E.00885
G1 X90.559 Y99.217 E.00885
G1 X90.614 Y99.667 E.00891
G1 X90.607 Y100.211 E.01071
G1 X90.564 Y100.56 E.00691
G1 X90.459 Y100.998 E.00887
G1 X90.303 Y101.42 E.00885
G1 X90.097 Y101.824 E.00891
G1 X89.98 Y102.01 E.00433
G1 X89.787 Y102.271 E.00639
G1 X89.556 Y102.535 E.00691
G1 X89.221 Y102.842 E.00893
G1 X89.048 Y102.975 E.0043
G1 X88.665 Y103.218 E.00891
G1 X88.259 Y103.412 E.00885
G1 X87.829 Y103.557 E.00892
G1 X87.617 Y103.608 E.0043
G1 X87.169 Y103.676 E.00891
G1 X86.719 Y103.689 E.00885
G1 X86.271 Y103.649 E.00885
G1 X85.828 Y103.555 E.00891
G1 X85.619 Y103.491 E.0043
G1 X85.199 Y103.321 E.00891
G1 X84.805 Y103.103 E.00885
G1 X84.44 Y102.84 E.00885
G1 X84.108 Y102.536 E.00885
G1 X83.815 Y102.195 E.00885
G1 X83.564 Y101.821 E.00885
G1 X83.361 Y101.422 E.00882
G1 X83.179 Y100.904 E.0108
G1 X83.067 Y100.336 E.01138
G1 X83.042 Y99.889 E.00881
G1 X83.07 Y99.44 E.00885
G1 X83.151 Y98.997 E.00885
G1 X83.284 Y98.567 E.00885
G1 X83.467 Y98.156 E.00885
G1 X83.7 Y97.767 E.00891
G1 X83.828 Y97.59 E.0043
G1 X84.436 Y96.891 E.01823
G1 X80.344 Y96.891 E.08049
G1 X80.031 Y96.854 E.00619
G1 X79.818 Y96.784 E.00442
G1 X79.687 Y96.718 E.00289
G1 X79.417 Y96.509 E.00672
G1 X79.216 Y96.248 E.00646
G1 X79.119 Y96.039 E.00454
G1 X79.079 Y95.904 E.00277
G1 X79.042 Y95.589 E.00625
G1 X79.042 Y77.61 E.35362
G1 X79.062 Y77.374 E.00466
G1 X79.095 Y77.234 E.00283
G1 X79.18 Y77.022 E.00448
G1 X79.299 Y76.828 E.00448
G1 X79.392 Y76.718 E.00283
G1 X79.562 Y76.567 E.00448
G1 X79.756 Y76.447 E.00448
G1 X80.066 Y76.34 E.00646
G1 X80.259 Y76.313 E.00383
G1 X93.37 Y76.312 E.25789
G1 X93.554 Y76.331 E.00364
G1 X93.772 Y76.389 E.00445
G1 X93.976 Y76.484 E.00442
G1 X94.16 Y76.613 E.00442
G1 X94.319 Y76.772 E.00442
G1 X94.448 Y76.956 E.00442
G1 X94.543 Y77.16 E.00442
G1 X94.601 Y77.377 E.00442
G1 X94.622 Y77.61 E.0046
G1 X94.622 Y85.671 E.15855
G1 X97.042 Y85.671 E.0476
G1 X97.042 Y85.388 E.00557
G1 X97.176 Y85.253 E.00374
G1 F1717.838
G1 X97.232 Y85.198 E.00154
G1 F1800
G1 X97.307 Y85.273 E.00208
G1 F1320
G1 X97.307 Y87.929 E.05224
G1 F1800
G1 X97.232 Y88.004 E.00208
G1 F2037.925
G1 X97.176 Y87.948 E.00154
G1 F1500
G1 X97.042 Y87.814 E.00374
G1 X97.042 Y87.531 E.00557
G1 X94.622 Y87.531 E.0476
G1 X94.622 Y88.791 E.02478
G1 X93.442 Y88.791 E.02321
G1 X93.442 Y77.491 E.22226
G1 X80.813 Y77.491 E.24839
G1 X80.625 Y77.524 E.00376
G1 X80.463 Y77.611 E.00361
G1 X80.321 Y77.762 E.00407
G1 X80.245 Y77.926 E.00356
G1 X80.222 Y78.086 E.00318
G1 X80.222 Y95.125 E.33516
G1 X80.278 Y95.365 E.00484
G1 X80.365 Y95.497 E.0031
G1 X80.495 Y95.612 E.00343
G1 X80.656 Y95.687 E.00349
G1 X80.816 Y95.711 E.00319
G1 X93.024 Y95.711 E.24011
G1 X93.057 Y95.329 E.00753
G1 X93.103 Y95.16 E.00344
G1 X93.236 Y94.913 E.00553
G1 X93.376 Y94.761 E.00406
G1 X93.537 Y94.644 E.0039
G1 X93.689 Y94.573 E.0033
G1 X94.016 Y94.495 E.00661
G1 X97.696 Y89.239 E.1262
G1 F1920
G1 X97.704 Y89.227 E.0003
G1 F2340
G1 X98.671 Y89.904 E.02321
G1 F1920
G1 X98.662 Y89.916 E.0003
G1 F1500
G1 X94.98 Y95.175 E.12627
G1 X95.02 Y95.451 E.0055
G1 X94.992 Y95.741 E.00572
G1 X94.96 Y95.844 E.00211
G1 X94.847 Y96.061 E.00483
G1 X94.653 Y96.27 E.0056
G1 X94.508 Y96.368 E.00344
G1 X94.301 Y96.459 E.00445
G1 X94.096 Y96.639 E.00538
G1 X93.906 Y96.755 E.00438
G1 X93.698 Y96.837 E.00438
G1 X93.483 Y96.881 E.00433
G1 X89.288 Y96.892 E.0825
; WIPE_START
M204 S6000
G1 X89.835 Y97.59 E-.16853
G1 X89.965 Y97.77 E-.04212
G1 X90.085 Y97.957 E-.04221
G1 X90.293 Y98.359 E-.08608
G1 X90.37 Y98.561 E-.04106
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




G1 X88.959 Y97.784
G1 Z3.44
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.36186
G1 F1500
M204 S6000
G1 X89.306 Y98.206 E.00915
G1 X89.569 Y98.682 E.00912
G1 X89.691 Y99.015 E.00596
G1 X89.783 Y99.359 E.00597
G1 X89.829 Y99.886 E.00887
G1 X89.787 Y100.419 E.00896
G1 X89.697 Y100.768 E.00604
G1 X89.597 Y101.063 E.00522
G1 X89.408 Y101.428 E.00689
G1 X89.167 Y101.775 E.00709
G1 X88.958 Y102.016 E.00536
G1 X88.537 Y102.363 E.00915
G1 X88.034 Y102.648 E.00968
G1 X87.613 Y102.792 E.00746
G1 X87.404 Y102.841 E.0036
G1 X86.853 Y102.899 E.0093
G1 X86.388 Y102.864 E.00781
G1 X86.032 Y102.786 E.00612
G1 X85.648 Y102.654 E.00681
G1 X85.192 Y102.412 E.00866
G1 X84.77 Y102.078 E.00902
G1 X84.445 Y101.716 E.00816
G1 X84.249 Y101.418 E.00597
G1 X84.089 Y101.11 E.00583
G1 X83.94 Y100.696 E.00737
G1 X83.853 Y100.237 E.00784
G1 X83.834 Y99.891 E.0058
G1 X83.883 Y99.358 E.00897
G1 X84.025 Y98.846 E.00892
G1 X84.172 Y98.524 E.00593
G1 X84.453 Y98.08 E.00881
G1 X84.818 Y97.673 E.00916
; LINE_WIDTH: 0.400635
G1 X84.992 Y97.496 E.00464
; LINE_WIDTH: 0.438433
G1 X85.198 Y97.319 E.00561
; LINE_WIDTH: 0.477117
G1 X85.379 Y97.165 E.00533
; WIPE_START
G1 X85.198 Y97.319 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X88.281 Y97.163 Z3.84 F18000
G1 Z3.44
G1 E.4 F1800
; LINE_WIDTH: 0.468131
G1 F1500
M204 S6000
G1 X88.58 Y97.411 E.00857
; LINE_WIDTH: 0.419334
G1 X88.782 Y97.609 E.00557
; LINE_WIDTH: 0.378828
G1 X88.959 Y97.784 E.00438
; WIPE_START
G1 X88.782 Y97.609 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X93.61 Y96.144 Z3.84 F18000
G1 Z3.44
G1 E.4 F1800
; LINE_WIDTH: 0.109757
G1 F1500
M204 S6000
G1 X93.837 Y96.009 E.00111
; WIPE_START
G1 X93.61 Y96.144 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X93.972 Y88.52 Z3.84 F18000
G1 X94.063 Y86.601 Z3.84
G1 Z3.44
G1 E.4 F1800
; LINE_WIDTH: 0.643042
G1 F1500
M204 S6000
G1 X96.685 Y86.601 E.08076
; WIPE_START
G1 X94.685 Y86.601 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X88.35 Y82.344 Z3.84 F18000
G1 X80.327 Y76.953 Z3.84
G1 Z3.44
G1 E.4 F1800
; LINE_WIDTH: 0.0927402
G1 F1500
M204 S6000
G1 X80.222 Y76.991 E.00037
; LINE_WIDTH: 0.128411
G1 X80.039 Y77.073 E.00103
; LINE_WIDTH: 0.15646
G1 X79.894 Y77.201 E.00126
G1 X79.756 Y77.387 E.00151
; LINE_WIDTH: 0.105092
G1 X79.689 Y77.595 E.00086
; WIPE_START
G1 X79.756 Y77.387 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X79.722 Y85.02 Z3.84 F18000
G1 X79.676 Y95.659 Z3.84
G1 Z3.44
G1 E.4 F1800
; LINE_WIDTH: 0.150905
M73 P70 R7
G1 F1500
M204 S6000
G1 X79.849 Y95.954 E.00213
G1 X80.117 Y96.175 E.00217
; LINE_WIDTH: 0.105471
G1 X80.315 Y96.239 E.00083
; WIPE_START
G1 X80.117 Y96.175 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X86.954 Y92.783 Z3.84 F18000
G1 X99.61 Y86.505 Z3.84
G1 Z3.44
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X99.909 Y86.078 E.01025
G1 X100.476 Y86.475 E.0136
G1 X100.876 Y86.755 E.00961
G1 X100.577 Y87.182 E.01025
G1 F1920
G1 X100.568 Y87.194 E.0003
G1 F2340
G1 X99.639 Y86.543 E.02232
M204 S10000
G1 X99.923 Y86.415 F18000
; FEATURE: Gap infill
; LINE_WIDTH: 0.152523
G1 F1500
M204 S6000
G1 X100.555 Y86.857 E.00487
; CHANGE_LAYER
; Z_HEIGHT: 3.56
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F1500
G1 X99.923 Y86.415 E-.38
; WIPE_END
G1 E-.02 F1800
; layer num/total_layer_count: 29/49
; update layer progress
M73 L29
M991 S0 P28 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z3.84 I.381 J-1.156 P1  F18000
G1 X93.851 Y84.415 Z3.84
G1 Z3.56
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X93.851 Y77.127 E.15426
G1 X94.029 Y77.071 E.00395
G1 X94.092 Y77.162 E.00234
G1 X94.157 Y77.3 E.00324
G1 X94.197 Y77.448 E.00324
G1 X94.212 Y77.628 E.00382
G1 X94.212 Y86.164 E.18066
G1 X97.069 Y86.164 E.06046
G1 X97.069 Y87.038 E.01851
G1 X94.212 Y87.038 E.06046
G1 X94.212 Y88.382 E.02844
G1 X93.851 Y88.382 E.00765
G1 X93.851 Y84.475 E.08269
; WIPE_START
M204 S6000
G1 X93.851 Y82.475 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X93.869 Y90.108 Z3.96 F18000
G1 X93.881 Y95.474 Z3.96
G1 Z3.56
G1 E.4 F1800
G1 F1500
M204 S500
G1 X93.893 Y95.43 E.00097
G1 X93.951 Y95.368 E.00179
G1 X94.159 Y95.318 E.00453
G1 X94.187 Y95.518 E.00429
G1 X94.107 Y95.634 E.00297
G1 X93.858 Y95.743 E.00576
G1 X93.876 Y95.534 E.00444
; WIPE_START
M204 S6000
G1 X93.893 Y95.43 E-.03264
G1 X93.951 Y95.368 E-.02618
G1 X94.159 Y95.318 E-.06615
G1 X94.187 Y95.518 E-.06262
G1 X94.107 Y95.634 E-.0434
G1 X93.858 Y95.743 E-.08417
G1 X93.876 Y95.534 E-.06485
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X87.992 Y97.078 Z3.96 F18000
G1 Z3.56
G1 E.4 F1800
G1 F1500
M204 S500
G1 X87.411 Y96.908 E.01282
G1 X86.773 Y96.853 E.01354
G1 X86.161 Y96.927 E.01306
G1 X85.597 Y97.11 E.01254
G1 X85.491 Y96.949 E.0041
G1 X85.842 Y96.544 E.01135
G1 X87.754 Y96.544 E.04045
G1 X88.094 Y96.913 E.01062
G1 X88.024 Y97.027 E.00283
; WIPE_START
M204 S6000
G1 X87.411 Y96.908 E-.11863
G1 X86.773 Y96.853 E-.12157
G1 X86.161 Y96.927 E-.11727
G1 X86.048 Y96.964 E-.02253
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X88.97 Y101.4 Z3.96 F18000
G1 Z3.56
G1 E.4 F1800
G1 F1500
M204 S500
G1 X88.704 Y101.737 E.0091
G1 X88.337 Y102.048 E.01017
G1 X87.873 Y102.307 E.01127
G1 X87.344 Y102.473 E.01172
G1 X86.866 Y102.523 E.01018
G1 X86.336 Y102.475 E.01126
G1 X85.807 Y102.315 E.01172
G1 X85.387 Y102.089 E.01007
G1 X85.02 Y101.796 E.00995
G1 X84.711 Y101.442 E.00995
G1 X84.47 Y101.039 E.00995
G1 X84.308 Y100.607 E.00975
G1 X84.241 Y100.292 E.00683
G1 X84.212 Y99.97 E.00683
G1 X84.239 Y99.506 E.00985
G1 X84.373 Y98.991 E.01126
G1 X84.618 Y98.494 E.01171
G1 X84.913 Y98.113 E.01021
G1 X85.332 Y97.751 E.01172
G1 X85.797 Y97.492 E.01126
G1 X86.252 Y97.344 E.01014
G1 X86.781 Y97.28 E.01127
G1 X87.333 Y97.327 E.01172
G1 X87.78 Y97.458 E.00988
G1 X88.073 Y97.593 E.00683
G1 X88.348 Y97.763 E.00683
G1 X88.699 Y98.061 E.00975
G1 X88.992 Y98.417 E.00975
G1 X89.157 Y98.694 E.00683
G1 X89.289 Y98.989 E.00683
G1 X89.411 Y99.433 E.00975
G1 X89.453 Y99.901 E.00995
G1 X89.411 Y100.369 E.00995
G1 X89.285 Y100.826 E.01004
G1 X89.047 Y101.303 E.01126
G1 X89.008 Y101.353 E.00135
M204 S250
G1 X88.649 Y101.146 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X88.408 Y101.451 E.00765
G1 X88.103 Y101.71 E.00787
G1 X87.71 Y101.929 E.00886
G1 X87.261 Y102.07 E.00925
G1 X86.863 Y102.112 E.00787
G1 X86.415 Y102.071 E.00885
G1 X85.965 Y101.935 E.00925
G1 X85.614 Y101.746 E.00784
G1 X85.304 Y101.499 E.0078
G1 X85.043 Y101.2 E.0078
G1 X84.84 Y100.86 E.00779
G1 X84.702 Y100.492 E.00774
G1 X84.646 Y100.23 E.00526
G1 X84.622 Y99.964 E.00526
G1 X84.646 Y99.57 E.00777
G1 X84.759 Y99.134 E.00885
G1 X84.967 Y98.712 E.00925
G1 X85.212 Y98.396 E.00788
G1 X85.568 Y98.088 E.00926
G1 X85.961 Y97.868 E.00885
G1 X86.341 Y97.745 E.00785
G1 X86.788 Y97.691 E.00886
G1 X87.257 Y97.731 E.00926
G1 X87.636 Y97.842 E.00777
G1 X87.879 Y97.954 E.00526
G1 X88.107 Y98.095 E.00526
G1 X88.407 Y98.349 E.00773
G1 X88.656 Y98.653 E.00773
G1 X88.794 Y98.883 E.00526
G1 X88.902 Y99.127 E.00526
G1 X89.007 Y99.506 E.00774
G1 X89.042 Y99.901 E.00779
G1 X89.007 Y100.296 E.0078
G1 X88.901 Y100.679 E.00783
G1 X88.7 Y101.082 E.00885
G1 X88.687 Y101.099 E.00042
; WIPE_START
M204 S6000
G1 X88.408 Y101.451 E-.08531
G1 X88.103 Y101.71 E-.07598
G1 X87.71 Y101.929 E-.08554
G1 X87.261 Y102.07 E-.08939
G1 X87.032 Y102.094 E-.04377
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X88.002 Y96.12 Z3.96 F18000
G1 Z3.56
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X93.399 Y96.12 E.11424
G1 X93.462 Y95.401 E.01529
G1 X93.489 Y95.301 E.00219
G1 X93.561 Y95.164 E.00327
G1 X93.651 Y95.067 E.00279
G1 X93.824 Y94.962 E.00431
G1 X94.262 Y94.857 E.00952
G1 X97.853 Y89.728 E.13252
G1 X98.149 Y89.935 E.00765
G1 X94.552 Y95.072 E.13273
G1 X94.61 Y95.479 E.0087
G1 X94.596 Y95.627 E.00315
G1 X94.495 Y95.841 E.00501
G1 X94.384 Y95.958 E.00342
G1 X94.31 Y96.008 E.00188
G1 X94.079 Y96.109 E.00535
G1 X93.852 Y96.308 E.00638
G1 X93.723 Y96.387 E.00322
G1 X93.582 Y96.443 E.00321
G1 X93.441 Y96.472 E.00304
G1 X88.277 Y96.485 E.10931
G1 X89.376 Y97.675 E.03429
G1 X89.632 Y98.008 E.00888
G1 X89.919 Y98.526 E.01254
G1 X90.06 Y98.901 E.00849
G1 X90.156 Y99.291 E.00849
G1 X90.206 Y99.699 E.00869
G1 X90.199 Y100.172 E.01003
G1 X90.16 Y100.487 E.00671
G1 X90.067 Y100.879 E.00854
G1 X89.926 Y101.26 E.00858
G1 X89.803 Y101.509 E.0059
G1 X89.528 Y101.94 E.01081
G1 X89.26 Y102.251 E.00869
G1 X88.968 Y102.519 E.00839
G1 X88.568 Y102.798 E.01032
G1 X88.098 Y103.034 E.01113
G1 X87.716 Y103.164 E.00856
G1 X87.132 Y103.267 E.01254
G1 X86.731 Y103.279 E.00849
G1 X86.332 Y103.243 E.00849
G1 X85.939 Y103.161 E.00849
G1 X85.559 Y103.032 E.00849
G1 X85.197 Y102.859 E.00849
G1 X84.858 Y102.644 E.0085
G1 X84.539 Y102.385 E.00869
G1 X84.141 Y101.947 E.01254
G1 X83.918 Y101.613 E.0085
G1 X83.738 Y101.26 E.00839
G1 X83.576 Y100.8 E.01032
G1 X83.474 Y100.284 E.01113
G1 X83.452 Y99.89 E.00836
G1 X83.477 Y99.49 E.00849
G1 X83.549 Y99.095 E.00849
G1 X83.668 Y98.711 E.00849
G1 X83.831 Y98.345 E.00849
G1 X84.149 Y97.845 E.01253
G1 X85.335 Y96.482 E.03825
G1 X80.368 Y96.482 E.10513
G1 X80.129 Y96.454 E.00508
G1 X79.93 Y96.381 E.0045
G1 X79.799 Y96.301 E.00324
G1 X79.621 Y96.119 E.00539
G1 X79.481 Y95.821 E.00696
G1 X79.451 Y95.565 E.00546
G1 X79.451 Y77.624 E.37974
G1 X79.489 Y77.352 E.00581
G1 X79.592 Y77.125 E.00526
G1 X79.76 Y76.933 E.00539
G1 X80.002 Y76.787 E.00599
G1 X80.126 Y76.747 E.00276
G1 X80.29 Y76.723 E.0035
G1 X93.351 Y76.722 E.27646
G1 X93.48 Y76.735 E.00274
G1 X93.632 Y76.775 E.00334
G1 X93.862 Y76.904 E.00556
G1 X93.805 Y77.082 E.00395
G1 X80.787 Y77.082 E.27555
G1 X80.528 Y77.119 E.00553
G1 X80.226 Y77.271 E.00717
G1 X80.002 Y77.495 E.00669
G1 X79.85 Y77.798 E.00717
G1 X79.812 Y78.056 E.00552
G1 X79.812 Y95.141 E.36162
G1 X79.841 Y95.363 E.00473
G1 X79.956 Y95.642 E.00639
G1 X80.243 Y95.946 E.00885
G1 X80.537 Y96.084 E.00688
G1 X80.787 Y96.12 E.00533
G1 X87.942 Y96.12 E.15144
; WIPE_START
M204 S6000
G1 X89.942 Y96.12 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X89.21 Y96.892 Z3.96 F18000
G1 Z3.56
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X89.689 Y97.411 E.01389
G1 X89.967 Y97.772 E.00897
G1 X90.085 Y97.957 E.00431
G1 X90.293 Y98.359 E.00891
G1 X90.452 Y98.78 E.00885
G1 X90.559 Y99.217 E.00885
G1 X90.614 Y99.667 E.00891
G1 X90.607 Y100.206 E.01061
G1 X90.564 Y100.56 E.007
G1 X90.459 Y100.998 E.00887
G1 X90.303 Y101.422 E.00888
G1 X90.162 Y101.705 E.00623
G1 X89.85 Y102.192 E.01138
G1 X89.555 Y102.536 E.00891
G1 X89.225 Y102.839 E.00882
G1 X88.778 Y103.15 E.01071
G1 X88.257 Y103.412 E.01147
G1 X87.83 Y103.557 E.00887
G1 X87.617 Y103.608 E.0043
G1 X87.169 Y103.676 E.00891
G1 X86.719 Y103.689 E.00885
G1 X86.271 Y103.649 E.00885
G1 X85.831 Y103.556 E.00885
G1 X85.405 Y103.412 E.00885
G1 X84.999 Y103.218 E.00885
G1 X84.618 Y102.977 E.00885
G1 X84.267 Y102.691 E.00891
G1 X84.11 Y102.538 E.0043
G1 X83.815 Y102.195 E.00891
G1 X83.564 Y101.821 E.00885
G1 X83.361 Y101.422 E.00882
G1 X83.18 Y100.908 E.01071
G1 X83.067 Y100.336 E.01147
G1 X83.042 Y99.889 E.00881
G1 X83.07 Y99.44 E.00885
G1 X83.151 Y98.997 E.00885
G1 X83.284 Y98.567 E.00885
G1 X83.467 Y98.156 E.00885
G1 X83.7 Y97.767 E.00891
G1 X83.828 Y97.59 E.0043
G1 X84.436 Y96.891 E.01823
G1 X80.344 Y96.891 E.08049
G1 X80.034 Y96.855 E.00613
G1 X79.75 Y96.751 E.00594
G1 X79.559 Y96.633 E.00442
G1 X79.449 Y96.541 E.00283
G1 X79.295 Y96.368 E.00454
G1 X79.216 Y96.248 E.00283
G1 X79.119 Y96.039 E.00454
G1 X79.079 Y95.904 E.00277
G1 X79.042 Y95.589 E.00625
G1 X79.042 Y77.609 E.35365
G1 X79.055 Y77.421 E.0037
G1 X79.096 Y77.232 E.0038
G1 X79.181 Y77.019 E.0045
G1 X79.253 Y76.895 E.00283
G1 X79.396 Y76.714 E.00454
G1 X79.5 Y76.615 E.00283
G1 X79.688 Y76.484 E.00451
G1 X79.849 Y76.406 E.00352
G1 X80.033 Y76.347 E.0038
G1 X80.26 Y76.313 E.0045
G1 X93.372 Y76.312 E.2579
G1 X93.554 Y76.331 E.0036
G1 X93.773 Y76.389 E.00445
G1 X93.976 Y76.484 E.00442
G1 X94.16 Y76.613 E.00442
G1 X94.319 Y76.772 E.00442
G1 X94.448 Y76.956 E.00442
G1 X94.543 Y77.16 E.00442
G1 X94.601 Y77.377 E.00442
G1 X94.622 Y77.61 E.0046
G1 X94.622 Y85.754 E.16019
G1 X97.042 Y85.754 E.0476
G1 X97.042 Y85.388 E.00721
G1 X97.232 Y85.198 E.00529
G1 X97.348 Y85.314 E.00322
G1 F2035.599
G1 X97.478 Y85.444 E.00363
G1 F1320
G1 X97.478 Y87.758 E.0455
G1 F1824.963
G1 X97.348 Y87.888 E.00363
G1 F1500
G1 X97.232 Y88.004 E.00322
G1 X97.042 Y87.814 E.00529
G1 X97.042 Y87.447 E.00721
G1 X94.622 Y87.447 E.0476
G1 X94.622 Y88.791 E.02643
G1 X93.442 Y88.791 E.02321
G1 X93.442 Y77.491 E.22226
G1 X80.816 Y77.491 E.24833
G1 X80.653 Y77.515 E.00325
G1 X80.468 Y77.608 E.00407
G1 X80.338 Y77.737 E.00361
G1 X80.246 Y77.922 E.00407
G1 X80.222 Y78.086 E.00325
G1 X80.222 Y95.115 E.33494
G1 X80.24 Y95.257 E.00282
G1 X80.306 Y95.417 E.0034
G1 X80.487 Y95.608 E.00519
G1 X80.656 Y95.687 E.00367
G1 X80.816 Y95.711 E.00319
G1 X93.024 Y95.711 E.24011
G1 X93.057 Y95.329 E.00753
G1 X93.102 Y95.162 E.0034
G1 X93.235 Y94.914 E.00554
G1 X93.377 Y94.76 E.00412
G1 X93.537 Y94.645 E.00387
G1 X93.689 Y94.573 E.0033
G1 X94.016 Y94.495 E.00661
G1 X97.728 Y89.193 E.1273
G1 F1739.816
G1 X97.753 Y89.158 E.00085
G1 F2536.476
G1 X98.08 Y89.387 E.00787
G1 X98.392 Y89.605 E.00747
G1 X98.719 Y89.835 E.00787
G1 F1739.816
G1 X98.695 Y89.87 E.00085
G1 F1500
G1 X94.98 Y95.175 E.12737
G1 X95.019 Y95.563 E.00768
G1 X94.96 Y95.843 E.00563
G1 X94.829 Y96.084 E.00538
G1 X94.65 Y96.273 E.00513
G1 X94.508 Y96.368 E.00335
G1 X94.301 Y96.459 E.00444
G1 X94.096 Y96.639 E.00538
G1 X93.906 Y96.755 E.00438
G1 X93.698 Y96.837 E.00438
G1 X93.483 Y96.881 E.00433
G1 X89.27 Y96.892 E.08287
; WIPE_START
M204 S6000
G1 X89.689 Y97.411 E-.12676
G1 X89.967 Y97.772 E-.08668
G1 X90.085 Y97.957 E-.0416
G1 X90.293 Y98.359 E-.08608
G1 X90.365 Y98.551 E-.03888
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
M73 P71 R7
G1 X-13.0 F3000 ; move to safe pos
M400
M1004 S5 P1  ; external shutter
M400 P300
M971 S11 C11 O0
G92 E0
G1 X0 F18000
M623

; SKIPTYPE: head_wrap_detect
M622.1 S1
M1002 judge_flag g39_3rd_layer_detect_flag
M622 J1
    ; enable nozzle clog detect at 3rd layer
    


    M622.1 S1
    M1002 judge_flag g39_detection_flag
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




G1 X88.959 Y97.784
G1 Z3.56
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.375767
G1 F1500
M204 S6000
G1 X88.78 Y97.612 E.00434
; LINE_WIDTH: 0.408418
G1 X88.574 Y97.416 E.00543
; LINE_WIDTH: 0.445762
G1 X88.393 Y97.272 E.00486
; LINE_WIDTH: 0.479752
G1 X88.211 Y97.127 E.00525
M204 S10000
G1 X88.959 Y97.784 F18000
; LINE_WIDTH: 0.360583
G1 F1500
M204 S6000
G1 X89.309 Y98.209 E.00919
G1 X89.494 Y98.53 E.0062
G1 X89.647 Y98.873 E.00627
G1 X89.783 Y99.357 E.0084
G1 X89.832 Y99.884 E.00884
G1 X89.787 Y100.422 E.00902
G1 X89.63 Y100.976 E.00962
G1 X89.316 Y101.578 E.01134
G1 X88.987 Y101.989 E.00881
G1 X88.563 Y102.346 E.00925
G1 X88.372 Y102.468 E.00379
G1 X87.953 Y102.681 E.00784
G1 X87.437 Y102.839 E.00902
G1 X86.885 Y102.899 E.00928
G1 X86.388 Y102.864 E.00832
G1 X86.041 Y102.788 E.00594
G1 X85.677 Y102.67 E.0064
G1 X85.192 Y102.411 E.00917
G1 X84.684 Y101.992 E.011
G1 X84.414 Y101.676 E.00695
G1 X84.137 Y101.215 E.00898
G1 X83.942 Y100.701 E.00918
G1 X83.868 Y100.338 E.00619
G1 X83.834 Y99.963 E.00628
G1 X83.856 Y99.536 E.00715
G1 X83.924 Y99.187 E.00595
G1 X84.023 Y98.845 E.00595
G1 X84.294 Y98.31 E.01001
G1 X84.453 Y98.08 E.00468
; LINE_WIDTH: 0.368579
G1 X84.651 Y97.842 E.00529
G1 X84.863 Y97.631 E.00511
; LINE_WIDTH: 0.418517
G1 X85.074 Y97.419 E.00586
; LINE_WIDTH: 0.444893
G1 X85.106 Y97.39 E.0009
; LINE_WIDTH: 0.470766
G1 X85.381 Y97.168 E.00785
; WIPE_START
G1 X85.106 Y97.39 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X80.315 Y96.239 Z3.96 F18000
G1 Z3.56
G1 E.4 F1800
; LINE_WIDTH: 0.106852
G1 F1500
M204 S6000
G1 X80.08 Y96.156 E.00101
; LINE_WIDTH: 0.162891
G1 X79.851 Y95.947 E.00212
; LINE_WIDTH: 0.148118
G1 X79.748 Y95.802 E.00109
; LINE_WIDTH: 0.0970598
G1 X79.695 Y95.627 E.00065
; WIPE_START
G1 X79.748 Y95.802 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X87.378 Y95.99 Z3.96 F18000
G1 X93.61 Y96.144 Z3.96
G1 Z3.56
G1 E.4 F1800
; LINE_WIDTH: 0.10977
G1 F1500
M204 S6000
G1 X93.837 Y96.009 E.00111
; WIPE_START
G1 X93.61 Y96.144 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X93.972 Y88.52 Z3.96 F18000
G1 X94.063 Y86.601 Z3.96
G1 Z3.56
G1 E.4 F1800
; LINE_WIDTH: 0.476082
G1 F1500
M204 S6000
G1 X96.857 Y86.601 E.06276
; WIPE_START
G1 X94.857 Y86.601 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X88.499 Y82.378 Z3.96 F18000
G1 X80.336 Y76.955 Z3.96
G1 Z3.56
G1 E.4 F1800
; LINE_WIDTH: 0.0987999
G1 F1500
M204 S6000
G1 X80.186 Y77.001 E.00057
; LINE_WIDTH: 0.145864
G1 X80.061 Y77.058 E.00083
G1 X79.944 Y77.151 E.00089
G1 X79.793 Y77.321 E.00136
G1 X79.742 Y77.427 E.00071
; LINE_WIDTH: 0.102568
G1 X79.687 Y77.602 E.0007
; WIPE_START
G1 X79.742 Y77.427 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X86.676 Y80.616 Z3.96 F18000
G1 X99.578 Y86.551 Z3.96
G1 Z3.56
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X99.909 Y86.078 E.01135
G1 X100.502 Y86.493 E.01423
G1 X100.876 Y86.755 E.00898
G1 X100.545 Y87.228 E.01135
G1 F1739.816
G1 X100.52 Y87.263 E.00085
G1 F2536.476
G1 X100.193 Y87.033 E.00787
G1 X99.568 Y86.596 E.01501
M204 S10000
G1 X99.899 Y86.449 F18000
; FEATURE: Gap infill
; LINE_WIDTH: 0.236547
G1 F1500
M204 S6000
G1 X100.53 Y86.891 E.00811
; CHANGE_LAYER
; Z_HEIGHT: 3.68
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F1500
G1 X99.899 Y86.449 E-.38
; WIPE_END
G1 E-.02 F1800
; layer num/total_layer_count: 30/49
; update layer progress
M73 L30
M991 S0 P29 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z3.96 I.379 J-1.156 P1  F18000
G1 X93.851 Y84.467 Z3.96
G1 Z3.68
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X93.851 Y77.127 E.15535
G1 X94.029 Y77.071 E.00395
G1 X94.092 Y77.162 E.00234
G1 X94.157 Y77.301 E.00324
G1 X94.197 Y77.448 E.00324
G1 X94.212 Y77.628 E.00382
G1 X94.212 Y86.247 E.18243
G1 X97.212 Y86.247 E.0635
G1 X97.212 Y86.955 E.01498
G1 X94.212 Y86.955 E.0635
G1 X94.212 Y88.382 E.0302
G1 X93.851 Y88.382 E.00765
G1 X93.851 Y84.527 E.08159
; WIPE_START
M204 S6000
G1 X93.851 Y82.527 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X93.87 Y90.159 Z4.08 F18000
G1 X93.883 Y95.452 Z4.08
G1 Z3.68
G1 E.4 F1800
G1 F1500
M204 S500
G1 X93.967 Y95.364 E.00258
G1 X94.159 Y95.318 E.00417
G1 X94.185 Y95.504 E.00399
G1 X94.177 Y95.564 E.00129
G1 X94.111 Y95.632 E.002
G1 X93.858 Y95.743 E.00585
G1 X93.878 Y95.512 E.00492
; WIPE_START
M204 S6000
G1 X93.967 Y95.364 E-.05372
G1 X94.159 Y95.318 E-.06124
G1 X94.185 Y95.504 E-.05855
G1 X94.177 Y95.564 E-.0189
G1 X94.111 Y95.632 E-.02938
G1 X93.858 Y95.743 E-.08591
G1 X93.878 Y95.512 E-.0723
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X88.032 Y97.089 Z4.08 F18000
G1 Z3.68
G1 E.4 F1800
G1 F1500
M204 S500
G1 X87.411 Y96.908 E.01369
G1 X86.77 Y96.853 E.0136
G1 X86.16 Y96.927 E.01301
G1 X85.597 Y97.11 E.01253
G1 X85.491 Y96.949 E.0041
G1 X85.842 Y96.544 E.01135
G1 X87.793 Y96.544 E.04128
G1 X88.134 Y96.927 E.01085
G1 X88.064 Y97.038 E.00279
; WIPE_START
M204 S6000
G1 X87.411 Y96.908 E-.12655
G1 X86.77 Y96.853 E-.12206
G1 X86.16 Y96.927 E-.11675
G1 X86.087 Y96.951 E-.01464
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X88.971 Y101.399 Z4.08 F18000
G1 Z3.68
G1 E.4 F1800
G1 F1500
M204 S500
G1 X88.704 Y101.737 E.0091
G1 X88.341 Y102.045 E.01008
G1 X87.928 Y102.283 E.01008
G1 X87.401 Y102.46 E.01177
G1 X86.871 Y102.523 E.0113
G1 X86.339 Y102.476 E.0113
G1 X85.807 Y102.315 E.01177
G1 X85.387 Y102.089 E.01008
G1 X85.02 Y101.796 E.00995
G1 X84.711 Y101.442 E.00995
G1 X84.47 Y101.039 E.00995
G1 X84.308 Y100.607 E.00975
G1 X84.241 Y100.292 E.00683
G1 X84.212 Y99.97 E.00683
G1 X84.239 Y99.519 E.00955
G1 X84.306 Y99.204 E.00683
G1 X84.41 Y98.898 E.00684
G1 X84.622 Y98.49 E.00974
G1 X84.91 Y98.118 E.00995
G1 X85.252 Y97.809 E.00975
G1 X85.521 Y97.632 E.00683
G1 X85.81 Y97.487 E.00683
G1 X86.252 Y97.344 E.00984
G1 X86.778 Y97.28 E.01121
G1 X87.332 Y97.327 E.01177
G1 X87.789 Y97.46 E.01008
G1 X88.202 Y97.667 E.00976
G1 X88.465 Y97.852 E.00683
G1 X88.705 Y98.068 E.00683
G1 X89.002 Y98.429 E.00988
G1 X89.263 Y98.92 E.01177
G1 X89.411 Y99.428 E.01121
G1 X89.453 Y99.901 E.01004
G1 X89.411 Y100.369 E.00995
G1 X89.285 Y100.826 E.01004
G1 X89.049 Y101.3 E.01121
G1 X89.008 Y101.352 E.0014
M204 S250
G1 X88.649 Y101.146 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X88.408 Y101.451 E.00765
G1 X88.104 Y101.709 E.00784
G1 X87.759 Y101.908 E.00784
G1 X87.311 Y102.059 E.0093
G1 X86.865 Y102.112 E.00884
G1 X86.417 Y102.072 E.00883
G1 X85.965 Y101.935 E.0093
G1 X85.614 Y101.746 E.00784
G1 X85.304 Y101.499 E.0078
G1 X85.043 Y101.2 E.0078
G1 X84.84 Y100.86 E.00779
G1 X84.702 Y100.492 E.00774
G1 X84.646 Y100.23 E.00526
G1 X84.622 Y99.964 E.00526
G1 X84.645 Y99.574 E.00767
G1 X84.701 Y99.313 E.00526
G1 X84.787 Y99.06 E.00527
G1 X84.968 Y98.711 E.00773
G1 X85.211 Y98.397 E.0078
G1 X85.503 Y98.134 E.00773
G1 X85.726 Y97.987 E.00526
G1 X85.966 Y97.867 E.00526
G1 X86.341 Y97.745 E.00776
G1 X86.786 Y97.691 E.00881
G1 X87.257 Y97.731 E.0093
G1 X87.639 Y97.843 E.00784
G1 X87.991 Y98.019 E.00774
G1 X88.21 Y98.173 E.00526
G1 X88.409 Y98.352 E.00526
G1 X88.66 Y98.657 E.00777
G1 X88.882 Y99.075 E.0093
G1 X89.007 Y99.505 E.00881
G1 X89.042 Y99.901 E.00782
G1 X89.007 Y100.296 E.00779
G1 X88.901 Y100.679 E.00783
G1 X88.701 Y101.08 E.00881
G1 X88.686 Y101.098 E.00047
; WIPE_START
M204 S6000
G1 X88.408 Y101.451 E-.08532
G1 X88.104 Y101.709 E-.07572
G1 X87.759 Y101.908 E-.07571
G1 X87.311 Y102.059 E-.08988
G1 X87.032 Y102.092 E-.05336
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X88.044 Y96.12 Z4.08 F18000
G1 Z3.68
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X93.399 Y96.12 E.11334
G1 X93.462 Y95.398 E.01535
G1 X93.512 Y95.245 E.00339
G1 X93.567 Y95.156 E.00222
G1 X93.628 Y95.087 E.00194
G1 X93.825 Y94.962 E.00494
G1 X94.262 Y94.857 E.00952
G1 X97.901 Y89.659 E.1343
G1 X98.198 Y89.867 E.00765
G1 X94.552 Y95.072 E.13451
G1 X94.61 Y95.479 E.0087
G1 X94.596 Y95.628 E.00317
G1 X94.55 Y95.759 E.00294
G1 X94.495 Y95.845 E.00216
G1 X94.31 Y96.008 E.00521
G1 X94.079 Y96.109 E.00535
G1 X93.852 Y96.308 E.00638
G1 X93.723 Y96.387 E.00321
G1 X93.581 Y96.443 E.00321
G1 X93.441 Y96.472 E.00304
G1 X88.308 Y96.485 E.10863
G1 X89.431 Y97.742 E.03567
G1 X89.73 Y98.162 E.0109
G1 X89.919 Y98.526 E.00869
G1 X90.06 Y98.901 E.00849
G1 X90.186 Y99.48 E.01254
M73 P71 R6
G1 X90.211 Y99.89 E.00869
G1 X90.189 Y100.295 E.00858
G1 X90.067 Y100.877 E.0126
G1 X89.928 Y101.256 E.00854
G1 X89.741 Y101.621 E.00869
G1 X89.39 Y102.11 E.01274
G1 X88.968 Y102.519 E.01244
G1 X88.572 Y102.796 E.01022
G1 X88.098 Y103.034 E.01122
G1 X87.715 Y103.164 E.00855
G1 X87.132 Y103.267 E.01254
G1 X86.731 Y103.279 E.00849
G1 X86.332 Y103.243 E.00849
G1 X85.943 Y103.161 E.0084
G1 X85.488 Y103 E.01022
G1 X85.019 Y102.753 E.01122
G1 X84.698 Y102.522 E.00836
G1 X84.403 Y102.251 E.00849
G1 X84.141 Y101.947 E.00849
G1 X83.918 Y101.613 E.0085
G1 X83.738 Y101.26 E.00839
G1 X83.577 Y100.804 E.01023
G1 X83.474 Y100.284 E.01122
G1 X83.452 Y99.89 E.00836
G1 X83.477 Y99.49 E.00849
G1 X83.549 Y99.095 E.00849
G1 X83.668 Y98.711 E.00849
G1 X83.831 Y98.345 E.00849
G1 X84.149 Y97.845 E.01253
G1 X85.335 Y96.482 E.03825
G1 X80.368 Y96.482 E.10513
G1 X80.12 Y96.453 E.00527
G1 X79.975 Y96.405 E.00324
G1 X79.781 Y96.286 E.00482
G1 X79.608 Y96.099 E.00539
G1 X79.553 Y96.007 E.00226
G1 X79.479 Y95.803 E.00459
G1 X79.451 Y95.565 E.00508
G1 X79.451 Y77.628 E.37965
G1 X79.487 Y77.357 E.00578
G1 X79.547 Y77.207 E.00343
G1 X79.632 Y77.069 E.00343
G1 X79.814 Y76.89 E.0054
G1 X80.031 Y76.775 E.0052
G1 X80.28 Y76.723 E.00539
G1 X93.353 Y76.722 E.27668
G1 X93.48 Y76.735 E.0027
G1 X93.632 Y76.775 E.00334
G1 X93.862 Y76.904 E.00556
G1 X93.805 Y77.082 E.00395
G1 X80.778 Y77.082 E.27574
G1 X80.489 Y77.132 E.0062
G1 X80.219 Y77.278 E.00649
G1 X80.002 Y77.495 E.00649
G1 X79.85 Y77.798 E.00717
G1 X79.812 Y78.056 E.00552
G1 X79.812 Y95.137 E.36153
G1 X79.837 Y95.346 E.00445
G1 X79.953 Y95.64 E.00669
G1 X80.243 Y95.946 E.00892
G1 X80.538 Y96.084 E.00689
G1 X80.787 Y96.12 E.00533
G1 X87.984 Y96.12 E.15234
; WIPE_START
M204 S6000
G1 X89.984 Y96.12 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X89.22 Y96.892 Z4.08 F18000
G1 Z3.68
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X89.747 Y97.482 E.01555
G1 X89.967 Y97.772 E.00715
G1 X90.085 Y97.957 E.00432
G1 X90.293 Y98.359 E.00891
G1 X90.452 Y98.78 E.00885
G1 X90.56 Y99.22 E.00891
G1 X90.593 Y99.437 E.00431
G1 X90.621 Y99.889 E.00891
G1 X90.596 Y100.339 E.00888
G1 X90.546 Y100.647 E.00614
G1 X90.459 Y100.997 E.00709
G1 X90.303 Y101.42 E.00887
G1 X90.097 Y101.824 E.00891
G1 X89.981 Y102.009 E.00431
G1 X89.705 Y102.372 E.00897
G1 X89.557 Y102.534 E.0043
G1 X89.225 Y102.839 E.00888
G1 X88.782 Y103.148 E.01062
G1 X88.257 Y103.412 E.01157
G1 X87.83 Y103.557 E.00887
G1 X87.617 Y103.608 E.0043
G1 X87.169 Y103.676 E.00891
G1 X86.719 Y103.689 E.00885
G1 X86.271 Y103.649 E.00885
G1 X85.832 Y103.556 E.00882
G1 X85.324 Y103.376 E.01062
G1 X84.803 Y103.102 E.01157
G1 X84.44 Y102.84 E.00881
G1 X84.108 Y102.536 E.00885
G1 X83.815 Y102.195 E.00885
G1 X83.564 Y101.821 E.00885
G1 X83.361 Y101.422 E.00882
G1 X83.181 Y100.913 E.01062
G1 X83.067 Y100.336 E.01157
G1 X83.042 Y99.889 E.00881
G1 X83.07 Y99.44 E.00885
G1 X83.151 Y98.997 E.00885
G1 X83.284 Y98.567 E.00885
G1 X83.467 Y98.156 E.00885
G1 X83.7 Y97.767 E.00891
G1 X83.828 Y97.59 E.0043
G1 X84.436 Y96.891 E.01823
G1 X80.344 Y96.891 E.08049
G1 X80.031 Y96.854 E.00619
G1 X79.818 Y96.784 E.00442
G1 X79.526 Y96.607 E.00672
G1 X79.394 Y96.486 E.00351
G1 X79.271 Y96.333 E.00386
M73 P72 R6
G1 X79.182 Y96.184 E.00343
G1 X79.078 Y95.898 E.00597
G1 X79.042 Y95.589 E.00613
G1 X79.042 Y77.61 E.35362
G1 X79.062 Y77.374 E.00466
G1 X79.095 Y77.234 E.00283
G1 X79.18 Y77.022 E.00448
G1 X79.299 Y76.828 E.00448
G1 X79.392 Y76.718 E.00283
G1 X79.564 Y76.565 E.00454
G1 X79.684 Y76.486 E.00283
G1 X79.891 Y76.389 E.00448
G1 X80.111 Y76.33 E.00448
G1 X80.257 Y76.313 E.00289
G1 X93.373 Y76.312 E.258
G1 X93.554 Y76.331 E.00357
G1 X93.773 Y76.389 E.00445
G1 X93.976 Y76.484 E.00442
G1 X94.16 Y76.613 E.00442
G1 X94.319 Y76.772 E.00442
G1 X94.448 Y76.956 E.00442
G1 X94.543 Y77.16 E.00442
G1 X94.601 Y77.377 E.00442
G1 X94.622 Y77.61 E.0046
G1 X94.622 Y85.838 E.16183
G1 X97.042 Y85.838 E.0476
G1 X97.042 Y85.388 E.00885
G1 X97.232 Y85.198 E.00529
G1 X97.519 Y85.485 E.00799
G1 F1915.075
G1 X97.622 Y85.588 E.00286
G1 F1680
G1 X97.622 Y87.614 E.03985
G1 F2117.799
G1 X97.519 Y87.717 E.00286
G1 F1500
G1 X97.232 Y88.004 E.00799
G1 X97.042 Y87.814 E.00529
G1 X97.042 Y87.364 E.00885
G1 X94.622 Y87.364 E.0476
G1 X94.622 Y88.791 E.02807
G1 X93.442 Y88.791 E.02321
G1 X93.442 Y77.491 E.22226
G1 X80.813 Y77.491 E.24839
G1 X80.625 Y77.524 E.00376
G1 X80.466 Y77.61 E.00355
G1 X80.338 Y77.738 E.00355
G1 X80.246 Y77.922 E.00407
G1 X80.222 Y78.086 E.00325
G1 X80.222 Y95.113 E.33491
G1 X80.237 Y95.245 E.00261
G1 X80.305 Y95.416 E.00362
G1 X80.487 Y95.608 E.00521
G1 X80.656 Y95.687 E.00368
G1 X80.816 Y95.711 E.00319
G1 X93.024 Y95.711 E.24011
G1 X93.058 Y95.328 E.00755
G1 X93.095 Y95.184 E.00293
G1 X93.147 Y95.059 E.00266
G1 X93.237 Y94.911 E.00341
G1 X93.35 Y94.785 E.00333
G1 X93.538 Y94.644 E.00463
G1 X93.689 Y94.573 E.00327
G1 X94.016 Y94.495 E.00662
G1 X97.776 Y89.124 E.12895
G1 F1739.85
G1 X97.801 Y89.089 E.00085
G1 F2536.476
G1 X98.129 Y89.319 E.00787
G1 X98.44 Y89.537 E.00747
G1 X98.767 Y89.766 E.00787
G1 F1739.85
G1 X98.743 Y89.801 E.00085
G1 F1500
G1 X94.98 Y95.175 E.12902
G1 X95.019 Y95.563 E.00768
G1 X94.957 Y95.851 E.00579
G1 X94.818 Y96.101 E.00563
G1 X94.651 Y96.272 E.0047
G1 X94.508 Y96.368 E.00338
G1 X94.301 Y96.459 E.00444
G1 X94.096 Y96.639 E.00538
G1 X93.906 Y96.755 E.00438
G1 X93.698 Y96.837 E.00438
G1 X93.483 Y96.881 E.00433
G1 X89.28 Y96.892 E.08266
; WIPE_START
M204 S6000
G1 X89.747 Y97.482 E-.1429
G1 X89.967 Y97.772 E-.06912
G1 X90.085 Y97.957 E-.04175
G1 X90.293 Y98.359 E-.08608
G1 X90.368 Y98.557 E-.04015
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




G1 X88.971 Y97.797
G1 Z3.68
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.380699
G1 F1500
M204 S6000
G1 X88.706 Y97.532 E.00663
; LINE_WIDTH: 0.422537
G1 X88.574 Y97.415 E.0035
; LINE_WIDTH: 0.467902
G1 X88.431 Y97.287 E.00424
G1 X88.105 Y97.37 E.00741
M204 S10000
G1 X88.971 Y97.797 F18000
; LINE_WIDTH: 0.360949
G1 F1500
M204 S6000
G1 X89.323 Y98.234 E.00938
G1 X89.569 Y98.682 E.00854
G1 X89.691 Y99.013 E.0059
G1 X89.781 Y99.374 E.00623
G1 X89.832 Y99.891 E.00868
G1 X89.807 Y100.249 E.006
G1 X89.699 Y100.768 E.00886
G1 X89.576 Y101.102 E.00596
G1 X89.375 Y101.488 E.00727
G1 X89.096 Y101.861 E.0078
G1 X88.726 Y102.221 E.00863
G1 X88.376 Y102.466 E.00715
G1 X88.068 Y102.631 E.00584
G1 X87.614 Y102.793 E.00806
G1 X87.096 Y102.884 E.00879
G1 X86.743 Y102.896 E.00591
G1 X86.284 Y102.849 E.00771
G1 X86.048 Y102.79 E.00406
G1 X85.647 Y102.656 E.00707
G1 X85.192 Y102.412 E.00864
G1 X84.771 Y102.078 E.00899
G1 X84.445 Y101.716 E.00814
G1 X84.249 Y101.418 E.00595
G1 X84.089 Y101.109 E.00583
G1 X83.942 Y100.704 E.0072
G1 X83.853 Y100.236 E.00797
G1 X83.834 Y99.891 E.00578
G1 X83.856 Y99.536 E.00595
G1 X83.92 Y99.186 E.00596
G1 X84.059 Y98.761 E.00747
G1 X84.297 Y98.299 E.00869
G1 X84.624 Y97.872 E.00899
G1 X84.818 Y97.673 E.00465
; LINE_WIDTH: 0.400601
G1 X84.992 Y97.496 E.00464
; LINE_WIDTH: 0.438385
G1 X85.199 Y97.319 E.00562
; LINE_WIDTH: 0.477095
G1 X85.379 Y97.165 E.00533
; WIPE_START
G1 X85.199 Y97.319 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X80.315 Y96.239 Z4.08 F18000
G1 Z3.68
G1 E.4 F1800
; LINE_WIDTH: 0.107437
G1 F1500
M204 S6000
G1 X80.095 Y96.167 E.00094
; LINE_WIDTH: 0.160806
G1 X79.903 Y96.006 E.00169
G1 X79.685 Y95.741 E.00231
M204 S10000
G1 X79.696 Y95.628 F18000
; LINE_WIDTH: 0.102898
G1 F1500
M204 S6000
G1 X79.735 Y95.77 E.00057
G1 X79.894 Y96.092 E.00138
; WIPE_START
G1 X79.735 Y95.77 E-.26954
G1 X79.696 Y95.628 E-.11046
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X87.323 Y95.911 Z4.08 F18000
G1 X93.61 Y96.144 Z4.08
G1 Z3.68
G1 E.4 F1800
; LINE_WIDTH: 0.109719
G1 F1500
M204 S6000
G1 X93.837 Y96.009 E.0011
; WIPE_START
G1 X93.61 Y96.144 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X93.972 Y88.52 Z4.08 F18000
G1 X94.063 Y86.601 Z4.08
G1 Z3.68
G1 E.4 F1800
; LINE_WIDTH: 0.309132
G1 F1500
M204 S6000
G1 X97 Y86.601 E.04153
M204 S10000
G1 X97.332 Y87.159 F18000
; LINE_WIDTH: 0.196522
G1 F1500
M204 S6000
G1 X97.332 Y87.615 E.00388
; WIPE_START
G1 X97.332 Y87.159 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X97.332 Y86.042 Z4.08 F18000
G1 Z3.68
G1 E.4 F1800
G1 F1500
M204 S6000
G1 X97.332 Y85.587 E.00388
; WIPE_START
G1 X97.332 Y86.042 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X90.6 Y82.445 Z4.08 F18000
G1 X80.328 Y76.955 Z4.08
G1 Z3.68
G1 E.4 F1800
; LINE_WIDTH: 0.0897006
G1 F1500
M204 S6000
G1 X80.225 Y76.991 E.00035
; LINE_WIDTH: 0.126348
G1 X80.051 Y77.066 E.00095
; LINE_WIDTH: 0.152198
G1 X79.894 Y77.201 E.00131
G1 X79.788 Y77.329 E.00105
G1 X79.739 Y77.434 E.00073
; LINE_WIDTH: 0.102615
G1 X79.688 Y77.598 E.00066
; WIPE_START
G1 X79.739 Y77.434 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X86.662 Y80.647 Z4.08 F18000
G1 X99.53 Y86.62 Z4.08
G1 Z3.68
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X99.909 Y86.078 E.013
G1 X100.528 Y86.511 E.01486
G1 X100.876 Y86.755 E.00835
G1 X100.497 Y87.296 E.013
G1 F1739.736
G1 X100.472 Y87.332 E.00085
G1 F2536.476
G1 X100.144 Y87.102 E.00787
G1 X99.519 Y86.665 E.01501
M204 S10000
G1 X99.875 Y86.484 F18000
; FEATURE: Gap infill
; LINE_WIDTH: 0.320571
G1 F1500
M204 S6000
G1 X100.506 Y86.926 E.01134
; CHANGE_LAYER
; Z_HEIGHT: 3.8
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F1500
G1 X99.875 Y86.484 E-.38
; WIPE_END
G1 E-.02 F1800
; layer num/total_layer_count: 31/49
; update layer progress
M73 L31
M991 S0 P30 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z4.08 I.387 J-1.154 P1  F18000
G1 X93.851 Y84.465 Z4.08
G1 Z3.8
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X93.851 Y77.127 E.15532
G1 X94.029 Y77.071 E.00395
G1 X94.092 Y77.162 E.00234
G1 X94.157 Y77.301 E.00325
G1 X94.197 Y77.448 E.00324
G1 X94.212 Y77.628 E.00382
G1 X94.212 Y86.331 E.1842
G1 X97.212 Y86.331 E.0635
G1 X97.212 Y86.871 E.01144
G1 X94.212 Y86.871 E.0635
G1 X94.212 Y88.382 E.03197
G1 X93.851 Y88.382 E.00765
G1 X93.851 Y84.525 E.08163
; WIPE_START
M204 S6000
G1 X93.851 Y82.525 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X93.869 Y90.158 Z4.2 F18000
G1 X93.881 Y95.475 Z4.2
G1 Z3.8
G1 E.4 F1800
G1 F1500
M204 S500
G1 X93.893 Y95.43 E.00097
G1 X93.941 Y95.378 E.00149
G1 X94.159 Y95.319 E.00477
G1 X94.186 Y95.5 E.00388
G1 X94.177 Y95.564 E.00137
G1 X94.111 Y95.632 E.002
G1 X93.858 Y95.743 E.00585
G1 X93.876 Y95.534 E.00444
; WIPE_START
M204 S6000
G1 X93.893 Y95.43 E-.03262
G1 X93.941 Y95.378 E-.0218
G1 X94.159 Y95.319 E-.06965
G1 X94.186 Y95.5 E-.05667
G1 X94.177 Y95.564 E-.01997
G1 X94.111 Y95.632 E-.02915
G1 X93.858 Y95.743 E-.08538
G1 X93.876 Y95.534 E-.06477
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X88.03 Y97.089 Z4.2 F18000
G1 Z3.8
G1 E.4 F1800
G1 F1500
M204 S500
G1 X87.436 Y96.915 E.01311
G1 X87.063 Y96.865 E.00797
G1 X86.735 Y96.857 E.00694
G1 X86.16 Y96.927 E.01226
G1 X85.612 Y97.105 E.01219
G1 X85.506 Y96.943 E.00411
G1 X85.857 Y96.544 E.01125
G1 X87.791 Y96.544 E.04093
G1 X88.133 Y96.926 E.01085
G1 X88.062 Y97.038 E.00279
; WIPE_START
M204 S6000
G1 X87.436 Y96.915 E-.12129
G1 X87.063 Y96.865 E-.07155
G1 X86.735 Y96.857 E-.06232
G1 X86.16 Y96.927 E-.11005
G1 X86.086 Y96.952 E-.0148
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X88.971 Y101.41 Z4.2 F18000
G1 Z3.8
G1 E.4 F1800
G1 F1500
M204 S500
G1 X88.699 Y101.741 E.00905
G1 X88.341 Y102.045 E.00995
G1 X87.942 Y102.275 E.00975
G1 X87.643 Y102.392 E.00679
G1 X87.379 Y102.463 E.00579
G1 X86.871 Y102.523 E.01083
G1 X86.361 Y102.478 E.01083
G1 X86.095 Y102.415 E.00579
G1 X85.793 Y102.307 E.00678
G1 X85.387 Y102.089 E.00975
G1 X85.02 Y101.796 E.00995
G1 X84.711 Y101.442 E.00995
G1 X84.47 Y101.039 E.00994
G1 X84.308 Y100.607 E.00975
G1 X84.241 Y100.292 E.00683
G1 X84.212 Y99.97 E.00683
G1 X84.239 Y99.506 E.00984
G1 X84.366 Y99.014 E.01075
G1 X84.472 Y98.762 E.00579
G1 X84.628 Y98.482 E.00679
G1 X84.91 Y98.118 E.00975
G1 X85.252 Y97.809 E.00975
G1 X85.521 Y97.632 E.00683
G1 X85.81 Y97.487 E.00683
G1 X86.252 Y97.344 E.00983
G1 X86.756 Y97.282 E.01075
G1 X87.03 Y97.288 E.00579
G1 X87.347 Y97.331 E.00679
M73 P73 R6
G1 X87.793 Y97.462 E.00983
G1 X88.244 Y97.695 E.01075
G1 X88.467 Y97.854 E.00579
G1 X88.705 Y98.068 E.00678
G1 X88.992 Y98.417 E.00955
G1 X89.157 Y98.694 E.00683
G1 X89.289 Y98.989 E.00683
G1 X89.411 Y99.433 E.00975
G1 X89.453 Y99.901 E.00995
G1 X89.412 Y100.36 E.00975
G1 X89.336 Y100.671 E.00678
G1 X89.242 Y100.928 E.00579
G1 X89.007 Y101.363 E.01046
M204 S250
G1 X88.655 Y101.151 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X88.407 Y101.452 E.00769
G1 X88.104 Y101.709 E.0078
G1 X87.764 Y101.905 E.00773
G1 X87.515 Y102.003 E.00525
G1 X87.302 Y102.06 E.00435
G1 X86.865 Y102.112 E.00866
G1 X86.426 Y102.073 E.00866
G1 X86.211 Y102.022 E.00435
G1 X85.96 Y101.932 E.00525
G1 X85.614 Y101.746 E.00773
G1 X85.304 Y101.499 E.0078
G1 X85.043 Y101.2 E.0078
G1 X84.84 Y100.86 E.0078
G1 X84.702 Y100.492 E.00774
G1 X84.646 Y100.23 E.00526
G1 X84.622 Y99.964 E.00526
G1 X84.646 Y99.57 E.00776
G1 X84.755 Y99.145 E.00863
G1 X84.841 Y98.941 E.00435
G1 X84.97 Y98.708 E.00525
G1 X85.211 Y98.397 E.00773
G1 X85.503 Y98.134 E.00774
G1 X85.726 Y97.987 E.00526
G1 X85.966 Y97.867 E.00526
G1 X86.341 Y97.745 E.00776
G1 X86.777 Y97.692 E.00863
G1 X86.998 Y97.697 E.00435
G1 X87.262 Y97.733 E.00525
G1 X87.641 Y97.843 E.00776
G1 X88.03 Y98.045 E.00863
G1 X88.21 Y98.173 E.00435
G1 X88.409 Y98.352 E.00525
G1 X88.656 Y98.653 E.00767
G1 X88.794 Y98.883 E.00526
G1 X88.902 Y99.127 E.00526
G1 X89.007 Y99.506 E.00774
G1 X89.042 Y99.901 E.00779
G1 X89.007 Y100.292 E.00773
G1 X88.944 Y100.552 E.00525
G1 X88.868 Y100.759 E.00435
G1 X88.684 Y101.098 E.00758
; WIPE_START
M204 S6000
G1 X88.407 Y101.452 E-.08551
G1 X88.104 Y101.709 E-.07532
G1 X87.764 Y101.905 E-.07468
G1 X87.515 Y102.003 E-.05071
G1 X87.302 Y102.06 E-.04199
G1 X87.031 Y102.092 E-.05178
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X88.043 Y96.12 Z4.2 F18000
G1 Z3.8
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X93.399 Y96.12 E.11337
G1 X93.462 Y95.401 E.01529
G1 X93.49 Y95.295 E.00232
G1 X93.564 Y95.161 E.00322
G1 X93.738 Y95.004 E.00496
G1 X93.873 Y94.945 E.00313
G1 X94.256 Y94.865 E.00827
G1 X97.95 Y89.59 E.1363
G1 X98.246 Y89.798 E.00765
G1 X94.551 Y95.075 E.13635
G1 X94.609 Y95.46 E.00824
G1 X94.596 Y95.629 E.0036
G1 X94.534 Y95.788 E.0036
G1 X94.387 Y95.956 E.00472
G1 X94.31 Y96.008 E.00197
G1 X94.079 Y96.109 E.00536
G1 X93.852 Y96.308 E.00638
G1 X93.723 Y96.387 E.00321
G1 X93.581 Y96.443 E.00322
G1 X93.441 Y96.472 E.00304
G1 X88.307 Y96.485 E.10865
G1 X89.428 Y97.739 E.03559
G1 X89.73 Y98.162 E.01099
G1 X89.919 Y98.526 E.00869
G1 X90.06 Y98.901 E.00849
G1 X90.158 Y99.3 E.00869
G1 X90.212 Y99.894 E.01263
G1 X90.16 Y100.487 E.0126
G1 X90.066 Y100.883 E.00863
G1 X89.843 Y101.436 E.0126
G1 X89.636 Y101.787 E.00863
G1 X89.476 Y102.004 E.0057
G1 X89.262 Y102.25 E.0069
G1 X88.968 Y102.519 E.00844
G1 X88.568 Y102.799 E.01034
G1 X88.113 Y103.029 E.01079
G1 X87.724 Y103.16 E.00868
G1 X87.332 Y103.243 E.0085
G1 X86.932 Y103.279 E.00849
G1 X86.531 Y103.267 E.00849
G1 X85.948 Y103.164 E.01254
G1 X85.55 Y103.029 E.00889
G1 X85.096 Y102.799 E.01078
G1 X84.695 Y102.519 E.01034
G1 X84.403 Y102.251 E.0084
G1 X84.141 Y101.947 E.00849
G1 X83.918 Y101.613 E.0085
G1 X83.738 Y101.26 E.0084
G1 X83.575 Y100.799 E.01033
G1 X83.475 Y100.3 E.01079
G1 X83.452 Y99.89 E.00869
G1 X83.477 Y99.49 E.00849
G1 X83.549 Y99.095 E.0085
G1 X83.668 Y98.712 E.00849
G1 X83.831 Y98.345 E.0085
G1 X84.039 Y97.997 E.00858
G1 X84.201 Y97.781 E.00571
G1 X85.347 Y96.482 E.03667
G1 X80.368 Y96.482 E.10539
G1 X80.129 Y96.454 E.00508
G1 X79.93 Y96.381 E.0045
G1 X79.799 Y96.301 E.00324
G1 X79.637 Y96.139 E.00485
G1 X79.573 Y96.044 E.00242
G1 X79.481 Y95.821 E.00511
G1 X79.451 Y95.565 E.00546
G1 X79.451 Y77.628 E.37965
G1 X79.487 Y77.357 E.00578
G1 X79.592 Y77.125 E.00539
G1 X79.78 Y76.917 E.00593
G1 X79.89 Y76.841 E.00283
G1 X80.036 Y76.773 E.0034
G1 X80.287 Y76.723 E.00543
G1 X93.354 Y76.722 E.27658
G1 X93.48 Y76.735 E.00266
G1 X93.632 Y76.775 E.00334
G1 X93.862 Y76.904 E.00557
G1 X93.805 Y77.082 E.00395
G1 X80.778 Y77.082 E.27574
G1 X80.489 Y77.133 E.0062
G1 X80.214 Y77.281 E.00662
G1 X79.987 Y77.516 E.0069
G1 X79.849 Y77.803 E.00673
G1 X79.812 Y78.056 E.00541
G1 X79.812 Y95.137 E.36154
G1 X79.836 Y95.343 E.00439
G1 X79.946 Y95.626 E.00643
G1 X80.239 Y95.945 E.00916
G1 X80.538 Y96.084 E.00697
G1 X80.787 Y96.12 E.00533
G1 X87.983 Y96.12 E.15231
; WIPE_START
M204 S6000
G1 X89.983 Y96.12 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X89.22 Y96.892 Z4.2 F18000
G1 Z3.8
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X89.744 Y97.478 E.01547
G1 X89.967 Y97.772 E.00725
G1 X90.085 Y97.957 E.00432
G1 X90.293 Y98.359 E.00891
G1 X90.452 Y98.78 E.00885
G1 X90.56 Y99.22 E.00891
G1 X90.593 Y99.437 E.00431
G1 X90.621 Y99.89 E.00894
G1 X90.608 Y100.197 E.00605
G1 X90.564 Y100.56 E.00718
G1 X90.459 Y100.999 E.00889
G1 X90.356 Y101.289 E.00605
G1 X90.207 Y101.623 E.00719
G1 X89.978 Y102.013 E.00889
G1 X89.796 Y102.26 E.00605
G1 X89.556 Y102.536 E.00718
G1 X89.225 Y102.839 E.00883
G1 X88.783 Y103.147 E.01059
G1 X88.262 Y103.411 E.01149
G1 X87.833 Y103.556 E.00891
G1 X87.392 Y103.649 E.00885
G1 X86.944 Y103.689 E.00885
G1 X86.494 Y103.676 E.00885
G1 X86.046 Y103.608 E.00891
G1 X85.834 Y103.557 E.0043
G1 X85.402 Y103.411 E.00898
G1 X85.201 Y103.322 E.00431
G1 X84.88 Y103.148 E.00718
G1 X84.439 Y102.839 E.01059
G1 X84.108 Y102.536 E.00882
G1 X83.815 Y102.195 E.00885
G1 X83.564 Y101.821 E.00885
G1 X83.361 Y101.422 E.00882
G1 X83.182 Y100.914 E.01059
G1 X83.067 Y100.341 E.01149
G1 X83.042 Y99.889 E.00891
G1 X83.07 Y99.44 E.00885
G1 X83.151 Y98.997 E.00885
G1 X83.284 Y98.567 E.00885
G1 X83.467 Y98.156 E.00885
G1 X83.699 Y97.769 E.00888
G1 X83.883 Y97.523 E.00605
G1 X84.44 Y96.891 E.01657
G1 X80.344 Y96.891 E.08057
G1 X80.034 Y96.855 E.00613
G1 X79.75 Y96.751 E.00594
G1 X79.559 Y96.633 E.00442
G1 X79.448 Y96.54 E.00284
G1 X79.314 Y96.392 E.00393
G1 X79.216 Y96.247 E.00346
G1 X79.119 Y96.039 E.00451
G1 X79.079 Y95.904 E.00277
G1 X79.042 Y95.589 E.00625
G1 X79.042 Y77.61 E.35362
G1 X79.062 Y77.374 E.00466
G1 X79.095 Y77.234 E.00283
G1 X79.181 Y77.02 E.00454
G1 X79.253 Y76.895 E.00283
G1 X79.395 Y76.715 E.00451
G1 X79.524 Y76.596 E.00346
G1 X79.686 Y76.485 E.00387
G1 X79.892 Y76.389 E.00447
G1 X80.061 Y76.341 E.00346
G1 X80.259 Y76.313 E.00392
G1 X93.375 Y76.312 E.25799
G1 X93.554 Y76.331 E.00353
G1 X93.772 Y76.389 E.00445
G1 X93.976 Y76.484 E.00442
G1 X94.16 Y76.613 E.00442
G1 X94.319 Y76.772 E.00442
G1 X94.448 Y76.956 E.00442
G1 X94.543 Y77.16 E.00442
G1 X94.601 Y77.377 E.00442
G1 X94.622 Y77.61 E.0046
G1 X94.622 Y85.921 E.16347
G1 X97.042 Y85.921 E.0476
G1 X97.042 Y85.388 E.01049
G1 X97.232 Y85.198 E.00529
G1 X97.622 Y85.588 E.01085
G1 X97.622 Y87.614 E.03985
G1 X97.232 Y88.004 E.01085
G1 X97.042 Y87.814 E.00529
G1 X97.042 Y87.28 E.01049
G1 X94.622 Y87.28 E.0476
G1 X94.622 Y88.791 E.02971
G1 X93.442 Y88.791 E.02321
G1 X93.442 Y77.491 E.22226
G1 X80.813 Y77.491 E.24839
G1 X80.625 Y77.524 E.00376
G1 X80.464 Y77.611 E.00359
G1 X80.328 Y77.753 E.00387
G1 X80.245 Y77.924 E.00374
G1 X80.222 Y78.086 E.00321
G1 X80.222 Y95.113 E.33491
G1 X80.237 Y95.244 E.00259
G1 X80.3 Y95.406 E.00342
G1 X80.485 Y95.608 E.0054
G1 X80.656 Y95.687 E.00371
G1 X80.816 Y95.711 E.00319
G1 X93.024 Y95.711 E.24011
G1 X93.057 Y95.329 E.00753
G1 X93.103 Y95.16 E.00345
G1 X93.236 Y94.913 E.00553
G1 X93.379 Y94.758 E.00414
G1 X93.534 Y94.646 E.00376
G1 X93.749 Y94.553 E.0046
G1 X94.014 Y94.498 E.00532
G1 X97.824 Y89.056 E.13068
G1 F1739.897
G1 X97.849 Y89.02 E.00085
G1 F2536.476
G1 X98.177 Y89.25 E.00787
G1 X98.488 Y89.468 E.00747
G1 X98.816 Y89.697 E.00787
G1 F1739.85
G1 X98.791 Y89.732 E.00085
G1 F1500
G1 X94.98 Y95.175 E.13069
G1 X95.018 Y95.427 E.00501
G1 X95.019 Y95.564 E.0027
G1 X94.958 Y95.849 E.00572
G1 X94.819 Y96.1 E.00564
G1 X94.651 Y96.272 E.00474
G1 X94.508 Y96.368 E.00338
G1 X94.301 Y96.459 E.00445
G1 X94.096 Y96.639 E.00538
G1 X93.906 Y96.755 E.00438
G1 X93.698 Y96.837 E.00438
G1 X93.483 Y96.881 E.00433
G1 X89.28 Y96.892 E.08267
; WIPE_START
M204 S6000
G1 X89.744 Y97.478 E-.14208
G1 X89.967 Y97.772 E-.06999
G1 X90.085 Y97.957 E-.04174
G1 X90.293 Y98.359 E-.08608
G1 X90.368 Y98.557 E-.04011
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




G1 X88.725 Y97.55
G1 Z3.8
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.399807
G1 F1500
M204 S6000
G1 X88.709 Y97.535 E.00039
; LINE_WIDTH: 0.418247
G1 X88.597 Y97.434 E.00296
; LINE_WIDTH: 0.455405
G1 X88.459 Y97.312 E.00394
; LINE_WIDTH: 0.484342
G1 X88.246 Y97.147 E.00618
M204 S10000
G1 X88.725 Y97.55 F18000
; LINE_WIDTH: 0.361086
G1 F1500
M204 S6000
G1 X88.988 Y97.815 E.00625
G1 X89.305 Y98.211 E.00849
G1 X89.496 Y98.529 E.00621
G1 X89.693 Y99.013 E.00873
G1 X89.782 Y99.38 E.00633
G1 X89.833 Y99.898 E.0087
G1 X89.787 Y100.42 E.00876
G1 X89.702 Y100.773 E.00607
G1 X89.499 Y101.262 E.00886
G1 X89.305 Y101.599 E.0065
G1 X88.979 Y101.996 E.0086
G1 X88.568 Y102.342 E.009
G1 X88.119 Y102.611 E.00875
G1 X87.752 Y102.751 E.00658
G1 X87.439 Y102.835 E.00542
G1 X86.893 Y102.9 E.00919
G1 X86.313 Y102.849 E.00975
G1 X85.996 Y102.781 E.00542
G1 X85.651 Y102.657 E.00614
G1 X85.193 Y102.41 E.00871
G1 X84.77 Y102.078 E.00899
G1 X84.445 Y101.716 E.00815
G1 X84.249 Y101.418 E.00596
G1 X84.089 Y101.109 E.00583
G1 X83.941 Y100.701 E.00726
G1 X83.869 Y100.357 E.00588
G1 X83.834 Y99.889 E.00786
G1 X83.87 Y99.432 E.00767
G1 X84.011 Y98.882 E.00949
G1 X84.17 Y98.521 E.00661
G1 X84.32 Y98.264 E.00497
G1 X84.498 Y98.023 E.00502
G1 X84.818 Y97.674 E.00792
; LINE_WIDTH: 0.39894
G1 X84.993 Y97.497 E.00462
; LINE_WIDTH: 0.433983
G1 X85.201 Y97.314 E.00565
; LINE_WIDTH: 0.470831
G1 X85.389 Y97.151 E.00551
; WIPE_START
G1 X85.201 Y97.314 E-.38
; WIPE_END
M73 P74 R6
G1 E-.02 F1800
M204 S10000
G1 X80.315 Y96.239 Z4.2 F18000
G1 Z3.8
G1 E.4 F1800
; LINE_WIDTH: 0.107309
G1 F1500
M204 S6000
G1 X80.074 Y96.154 E.00104
; LINE_WIDTH: 0.158687
G1 X79.932 Y96.036 E.00122
G1 X79.75 Y95.802 E.00196
; LINE_WIDTH: 0.0960991
G1 X79.696 Y95.634 E.00062
; WIPE_START
G1 X79.75 Y95.802 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X87.381 Y95.99 Z4.2 F18000
G1 X93.61 Y96.144 Z4.2
G1 Z3.8
G1 E.4 F1800
; LINE_WIDTH: 0.109736
G1 F1500
M204 S6000
G1 X93.837 Y96.009 E.0011
; WIPE_START
G1 X93.61 Y96.144 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X93.972 Y88.52 Z4.2 F18000
G1 X94.063 Y86.601 Z4.2
G1 Z3.8
G1 E.4 F1800
; LINE_WIDTH: 0.142172
G1 F1500
M204 S6000
G1 X97 Y86.601 E.01706
M204 S10000
G1 X97.332 Y87.076 F18000
; LINE_WIDTH: 0.196522
G1 F1500
M204 S6000
G1 X97.332 Y87.615 E.00459
; WIPE_START
G1 X97.332 Y87.076 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X97.332 Y86.126 Z4.2 F18000
G1 Z3.8
G1 E.4 F1800
G1 F1500
M204 S6000
G1 X97.332 Y85.587 E.00459
; WIPE_START
G1 X97.332 Y86.126 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X90.614 Y82.502 Z4.2 F18000
G1 X80.327 Y76.954 Z4.2
G1 Z3.8
G1 E.4 F1800
; LINE_WIDTH: 0.0923525
G1 F1500
M204 S6000
G1 X80.227 Y76.989 E.00035
; LINE_WIDTH: 0.129937
G1 X80.028 Y77.079 E.00113
; LINE_WIDTH: 0.152481
G1 X79.796 Y77.321 E.00212
G1 X79.737 Y77.434 E.0008
; LINE_WIDTH: 0.101069
G1 X79.689 Y77.596 E.00064
; WIPE_START
G1 X79.737 Y77.434 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X86.648 Y80.673 Z4.2 F18000
G1 X99.482 Y86.688 Z4.2
G1 Z3.8
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X99.909 Y86.078 E.01465
G1 X100.554 Y86.53 E.01549
G1 X100.876 Y86.755 E.00772
G1 X100.449 Y87.365 E.01465
G1 F1739.736
G1 X100.424 Y87.4 E.00085
G1 F2536.476
G1 X100.096 Y87.171 E.00787
G1 X99.471 Y86.733 E.01501
M204 S10000
G1 X99.851 Y86.518 F18000
; FEATURE: Gap infill
; LINE_WIDTH: 0.40416
G1 F1500
M204 S6000
G1 X100.327 Y86.852 E.01097
G1 X100.59 Y86.804 E.00504
; CHANGE_LAYER
; Z_HEIGHT: 3.92
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F1500
G1 X100.327 Y86.852 E-.11955
G1 X99.851 Y86.518 E-.26045
; WIPE_END
G1 E-.02 F1800
; layer num/total_layer_count: 32/49
; update layer progress
M73 L32
M991 S0 P31 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z4.2 I.403 J-1.148 P1  F18000
G1 X93.851 Y84.415 Z4.2
G1 Z3.92
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X93.851 Y77.127 E.15426
G1 X94.029 Y77.071 E.00395
G1 X94.092 Y77.162 E.00234
G1 X94.157 Y77.301 E.00324
G1 X94.197 Y77.448 E.00324
G1 X94.212 Y77.628 E.00382
G1 X94.212 Y86.414 E.18596
G1 X97.212 Y86.414 E.0635
G1 X97.212 Y86.788 E.00791
G1 X94.212 Y86.788 E.0635
G1 X94.212 Y88.382 E.03374
G1 X93.851 Y88.382 E.00765
G1 X93.851 Y84.475 E.08269
; WIPE_START
M204 S6000
G1 X93.851 Y82.475 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X93.869 Y90.108 Z4.32 F18000
G1 X93.882 Y95.466 Z4.32
G1 Z3.92
G1 E.4 F1800
G1 F1500
M204 S500
G1 X93.943 Y95.377 E.00228
G1 X94.159 Y95.318 E.00474
G1 X94.184 Y95.493 E.00373
G1 X94.168 Y95.581 E.00189
G1 X94.127 Y95.619 E.00118
G1 X93.858 Y95.743 E.00628
G1 X93.877 Y95.525 E.00463
; WIPE_START
M204 S6000
G1 X93.943 Y95.377 E-.05051
G1 X94.159 Y95.318 E-.06959
G1 X94.184 Y95.493 E-.05474
G1 X94.168 Y95.581 E-.02781
G1 X94.127 Y95.619 E-.01729
G1 X93.858 Y95.743 E-.09215
G1 X93.877 Y95.525 E-.0679
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X87.992 Y97.078 Z4.32 F18000
G1 Z3.92
G1 E.4 F1800
G1 F1500
M204 S500
G1 X87.436 Y96.915 E.01227
G1 X87.063 Y96.864 E.00797
G1 X86.732 Y96.857 E.007
G1 X86.16 Y96.928 E.0122
G1 X85.597 Y97.11 E.01252
G1 X85.491 Y96.949 E.0041
G1 X85.843 Y96.544 E.01135
G1 X87.754 Y96.544 E.04045
G1 X88.094 Y96.913 E.01062
G1 X88.024 Y97.027 E.00283
; WIPE_START
M204 S6000
G1 X87.436 Y96.915 E-.11371
G1 X87.063 Y96.864 E-.07159
G1 X86.732 Y96.857 E-.06283
G1 X86.16 Y96.928 E-.10951
G1 X86.048 Y96.964 E-.02236
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X88.971 Y101.41 Z4.32 F18000
G1 Z3.92
G1 E.4 F1800
G1 F1500
M204 S500
G1 X88.699 Y101.741 E.00906
G1 X88.348 Y102.039 E.00975
G1 X88.073 Y102.208 E.00683
G1 X87.781 Y102.344 E.00683
G1 X87.338 Y102.473 E.00975
G1 X86.867 Y102.523 E.01004
G1 X86.364 Y102.479 E.01069
G1 X86.095 Y102.415 E.00584
G1 X85.793 Y102.307 E.00679
G1 X85.387 Y102.089 E.00975
G1 X85.02 Y101.796 E.00995
G1 X84.711 Y101.442 E.00995
G1 X84.47 Y101.038 E.00995
G1 X84.308 Y100.607 E.00975
G1 X84.241 Y100.292 E.00683
G1 X84.212 Y99.97 E.00683
G1 X84.239 Y99.506 E.00984
G1 X84.365 Y99.017 E.01069
G1 X84.472 Y98.762 E.00584
G1 X84.628 Y98.482 E.00679
G1 X84.904 Y98.125 E.00955
G1 X85.136 Y97.903 E.00679
G1 X85.356 Y97.736 E.00585
G1 X85.797 Y97.491 E.01069
G1 X86.252 Y97.344 E.01012
G1 X86.753 Y97.282 E.01069
G1 X87.029 Y97.288 E.00584
G1 X87.347 Y97.331 E.00679
G1 X87.793 Y97.461 E.00983
G1 X88.242 Y97.693 E.01069
G1 X88.467 Y97.853 E.00584
G1 X88.708 Y98.071 E.00687
G1 X89.018 Y98.458 E.01049
G1 X89.158 Y98.696 E.00584
G1 X89.289 Y98.989 E.00679
G1 X89.411 Y99.433 E.00975
G1 X89.453 Y99.892 E.00975
G1 X89.433 Y100.212 E.00679
G1 X89.386 Y100.484 E.00585
G1 X89.229 Y100.964 E.01069
G1 X89.007 Y101.362 E.00965
M204 S250
G1 X88.655 Y101.15 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X88.406 Y101.453 E.0077
G1 X88.107 Y101.707 E.00773
G1 X87.879 Y101.847 E.00526
G1 X87.636 Y101.96 E.00526
G1 X87.259 Y102.07 E.00773
G1 X86.863 Y102.112 E.00783
G1 X86.429 Y102.073 E.00858
G1 X86.211 Y102.022 E.0044
G1 X85.96 Y101.932 E.00525
G1 X85.614 Y101.746 E.00773
G1 X85.304 Y101.499 E.00779
G1 X85.043 Y101.2 E.0078
G1 X84.84 Y100.86 E.0078
G1 X84.702 Y100.492 E.00773
G1 X84.646 Y100.23 E.00526
G1 X84.622 Y99.964 E.00526
G1 X84.646 Y99.57 E.00776
G1 X84.754 Y99.148 E.00858
G1 X84.84 Y98.941 E.0044
G1 X84.97 Y98.708 E.00525
G1 X85.209 Y98.4 E.00767
G1 X85.402 Y98.215 E.00525
G1 X85.58 Y98.08 E.0044
G1 X85.961 Y97.868 E.00858
G1 X86.341 Y97.745 E.00785
G1 X86.774 Y97.692 E.00858
G1 X86.997 Y97.697 E.0044
G1 X87.262 Y97.733 E.00525
G1 X87.641 Y97.843 E.00776
G1 X88.028 Y98.043 E.00858
G1 X88.21 Y98.173 E.0044
G1 X88.41 Y98.353 E.00528
G1 X88.68 Y98.691 E.00852
G1 X88.794 Y98.883 E.0044
G1 X88.902 Y99.127 E.00525
G1 X89.007 Y99.506 E.00773
G1 X89.042 Y99.898 E.00773
G1 X89.026 Y100.164 E.00525
G1 X88.988 Y100.384 E.0044
G1 X88.852 Y100.799 E.00858
G1 X88.685 Y101.098 E.00674
; WIPE_START
M204 S6000
G1 X88.406 Y101.453 E-.08561
G1 X88.107 Y101.707 E-.0747
G1 X87.879 Y101.847 E-.05081
G1 X87.636 Y101.96 E-.05081
G1 X87.259 Y102.07 E-.07471
G1 X87.032 Y102.094 E-.04335
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X88.002 Y96.12 Z4.32 F18000
G1 Z3.92
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X93.399 Y96.12 E.11424
G1 X93.463 Y95.392 E.01548
G1 X93.515 Y95.242 E.00336
G1 X93.564 Y95.161 E.00199
G1 X93.74 Y95.003 E.00502
G1 X93.856 Y94.951 E.00269
G1 X94.259 Y94.862 E.00873
G1 X97.998 Y89.522 E.13798
G1 X98.294 Y89.729 E.00765
G1 X94.552 Y95.072 E.13807
G1 X94.61 Y95.52 E.00956
G1 X94.58 Y95.681 E.00346
G1 X94.542 Y95.775 E.00216
G1 X94.395 Y95.951 E.00483
G1 X94.31 Y96.008 E.00217
G1 X94.079 Y96.109 E.00535
G1 X93.852 Y96.308 E.00638
G1 X93.723 Y96.387 E.00321
G1 X93.582 Y96.443 E.00321
G1 X93.441 Y96.472 E.00304
G1 X88.277 Y96.485 E.10931
G1 X89.376 Y97.675 E.03429
G1 X89.632 Y98.008 E.00889
G1 X89.919 Y98.526 E.01254
G1 X90.06 Y98.901 E.00849
G1 X90.156 Y99.291 E.00849
G1 X90.206 Y99.699 E.00869
G1 X90.189 Y100.295 E.01263
G1 X90.067 Y100.878 E.0126
G1 X89.928 Y101.256 E.00853
G1 X89.741 Y101.622 E.00869
G1 X89.479 Y102 E.00975
G1 X89.262 Y102.25 E.00699
G1 X88.968 Y102.519 E.00845
G1 X88.572 Y102.797 E.01024
G1 X88.113 Y103.029 E.01088
G1 X87.724 Y103.161 E.00869
G1 X87.332 Y103.243 E.00849
G1 X86.932 Y103.279 E.00849
G1 X86.531 Y103.267 E.00849
G1 X85.948 Y103.164 E.01254
G1 X85.559 Y103.032 E.00869
G1 X85.201 Y102.861 E.0084
G1 X84.795 Y102.596 E.01024
G1 X84.409 Y102.258 E.01088
G1 X84.141 Y101.947 E.00869
G1 X83.918 Y101.613 E.00849
G1 X83.737 Y101.26 E.0084
G1 X83.576 Y100.804 E.01024
G1 X83.475 Y100.3 E.01088
G1 X83.452 Y99.89 E.00869
G1 X83.477 Y99.49 E.00849
G1 X83.549 Y99.095 E.0085
G1 X83.668 Y98.712 E.00849
G1 X83.831 Y98.345 E.00849
G1 X84.149 Y97.845 E.01254
G1 X85.335 Y96.482 E.03824
G1 X80.368 Y96.482 E.10513
G1 X80.129 Y96.454 E.00508
G1 X79.856 Y96.34 E.00627
G1 X79.729 Y96.24 E.00343
G1 X79.621 Y96.119 E.00343
G1 X79.481 Y95.821 E.00696
G1 X79.451 Y95.565 E.00546
G1 X79.451 Y77.628 E.37965
G1 X79.487 Y77.357 E.00578
G1 X79.592 Y77.125 E.00539
G1 X79.779 Y76.918 E.00591
G1 X79.89 Y76.841 E.00286
G1 X80.036 Y76.773 E.0034
G1 X80.287 Y76.723 E.00543
G1 X93.356 Y76.722 E.27661
G1 X93.479 Y76.735 E.00263
G1 X93.632 Y76.775 E.00335
G1 X93.862 Y76.904 E.00556
G1 X93.805 Y77.082 E.00395
G1 X80.778 Y77.082 E.27574
G1 X80.489 Y77.133 E.0062
G1 X80.219 Y77.278 E.00649
G1 X80.002 Y77.495 E.00649
G1 X79.85 Y77.797 E.00717
G1 X79.812 Y78.056 E.00553
G1 X79.812 Y95.137 E.36154
G1 X79.837 Y95.343 E.0044
G1 X79.946 Y95.627 E.00644
G1 X80.239 Y95.945 E.00915
G1 X80.537 Y96.084 E.00696
G1 X80.787 Y96.12 E.00533
G1 X87.942 Y96.12 E.15144
; WIPE_START
M204 S6000
G1 X89.942 Y96.12 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X89.21 Y96.892 Z4.32 F18000
G1 Z3.92
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X89.689 Y97.411 E.01389
G1 X89.967 Y97.772 E.00898
G1 X90.085 Y97.957 E.0043
G1 X90.293 Y98.359 E.00892
G1 X90.452 Y98.78 E.00885
G1 X90.559 Y99.217 E.00885
G1 X90.614 Y99.667 E.00891
G1 X90.621 Y99.886 E.0043
G1 X90.596 Y100.339 E.00894
G1 X90.547 Y100.638 E.00595
G1 X90.459 Y100.998 E.00728
G1 X90.303 Y101.42 E.00886
G1 X90.097 Y101.824 E.00891
G1 X89.798 Y102.256 E.01034
G1 X89.556 Y102.536 E.00728
G1 X89.225 Y102.839 E.00884
G1 X88.787 Y103.145 E.0105
G1 X88.262 Y103.411 E.01158
G1 X87.833 Y103.556 E.00891
G1 X87.392 Y103.649 E.00885
G1 X86.944 Y103.689 E.00885
G1 X86.494 Y103.676 E.00885
G1 X86.047 Y103.608 E.00891
G1 X85.834 Y103.557 E.00431
G1 X85.405 Y103.412 E.00891
G1 X85 Y103.218 E.00882
G1 X84.553 Y102.927 E.0105
G1 X84.268 Y102.692 E.00727
G1 X84.11 Y102.538 E.00432
G1 X83.815 Y102.195 E.00891
G1 X83.564 Y101.821 E.00885
G1 X83.361 Y101.422 E.00882
G1 X83.183 Y100.918 E.0105
G1 X83.067 Y100.341 E.01158
G1 X83.042 Y99.889 E.00891
G1 X83.07 Y99.44 E.00885
G1 X83.151 Y98.997 E.00885
G1 X83.284 Y98.567 E.00885
G1 X83.467 Y98.156 E.00885
G1 X83.7 Y97.767 E.00891
G1 X83.828 Y97.59 E.00431
G1 X84.436 Y96.891 E.01822
G1 X80.344 Y96.891 E.08049
G1 X80.034 Y96.855 E.00613
G1 X79.748 Y96.75 E.006
G1 X79.626 Y96.68 E.00277
G1 X79.447 Y96.539 E.00448
G1 X79.296 Y96.368 E.00448
G1 X79.216 Y96.248 E.00283
G1 X79.119 Y96.039 E.00454
G1 X79.079 Y95.904 E.00277
G1 X79.042 Y95.589 E.00625
G1 X79.042 Y77.61 E.35362
G1 X79.062 Y77.374 E.00466
G1 X79.095 Y77.234 E.00283
G1 X79.181 Y77.019 E.00454
G1 X79.253 Y76.895 E.00283
G1 X79.395 Y76.715 E.00451
G1 X79.523 Y76.597 E.00342
G1 X79.686 Y76.485 E.0039
G1 X79.892 Y76.389 E.00447
G1 X80.06 Y76.341 E.00342
G1 X80.259 Y76.313 E.00396
G1 X93.377 Y76.313 E.25802
G1 X93.554 Y76.331 E.0035
G1 X93.772 Y76.389 E.00445
G1 X93.976 Y76.484 E.00442
G1 X94.16 Y76.613 E.00442
G1 X94.319 Y76.772 E.00442
G1 X94.448 Y76.956 E.00442
G1 X94.543 Y77.16 E.00442
G1 X94.601 Y77.377 E.00442
G1 X94.622 Y77.61 E.0046
G1 X94.622 Y86.005 E.16511
G1 X97.042 Y86.005 E.0476
G1 X97.042 Y85.388 E.01213
G1 X97.232 Y85.198 E.00529
G1 X97.622 Y85.588 E.01085
G1 X97.622 Y87.614 E.03985
G1 X97.232 Y88.004 E.01085
G1 X97.042 Y87.814 E.00529
G1 X97.042 Y87.197 E.01213
G1 X94.622 Y87.197 E.0476
G1 X94.622 Y88.791 E.03135
G1 X93.442 Y88.791 E.02321
G1 X93.442 Y77.491 E.22226
G1 X80.813 Y77.491 E.24839
G1 X80.625 Y77.524 E.00376
G1 X80.466 Y77.61 E.00355
G1 X80.338 Y77.737 E.00355
G1 X80.246 Y77.922 E.00407
G1 X80.222 Y78.086 E.00325
G1 X80.222 Y95.113 E.33492
G1 X80.237 Y95.244 E.00259
G1 X80.3 Y95.407 E.00343
G1 X80.486 Y95.608 E.00539
G1 X80.656 Y95.687 E.0037
G1 X80.816 Y95.711 E.00319
G1 X93.024 Y95.711 E.24011
G1 X93.058 Y95.326 E.00759
G1 X93.083 Y95.22 E.00214
G1 X93.147 Y95.058 E.00345
M73 P75 R6
G1 X93.236 Y94.913 E.00334
G1 X93.38 Y94.757 E.00417
G1 X93.535 Y94.646 E.00375
G1 X93.727 Y94.56 E.00414
G1 X94.015 Y94.497 E.00579
G1 X97.873 Y88.987 E.1323
G1 F1739.769
G1 X97.897 Y88.952 E.00085
G1 F2536.476
G1 X98.225 Y89.181 E.00787
G1 X98.536 Y89.399 E.00747
G1 X98.864 Y89.628 E.00787
G1 F1739.816
G1 X98.839 Y89.664 E.00085
G1 F1500
G1 X94.98 Y95.175 E.13233
G1 X95.019 Y95.559 E.0076
G1 X94.975 Y95.797 E.00476
G1 X94.851 Y96.056 E.00566
G1 X94.654 Y96.27 E.00572
G1 X94.508 Y96.368 E.00344
G1 X94.301 Y96.459 E.00445
G1 X94.096 Y96.639 E.00538
G1 X93.906 Y96.755 E.00438
G1 X93.698 Y96.837 E.00438
G1 X93.483 Y96.881 E.00433
G1 X89.27 Y96.892 E.08287
; WIPE_START
M204 S6000
G1 X89.689 Y97.411 E-.12676
G1 X89.967 Y97.772 E-.0867
G1 X90.085 Y97.957 E-.04153
G1 X90.293 Y98.359 E-.08613
G1 X90.365 Y98.551 E-.03888
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




G1 X88.707 Y97.537
G1 Z3.92
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.360777
G1 F1500
M204 S6000
G1 X88.993 Y97.82 E.00673
G1 X89.324 Y98.232 E.00883
G1 X89.571 Y98.684 E.0086
G1 X89.693 Y99.015 E.0059
G1 X89.783 Y99.357 E.00592
G1 X89.832 Y99.882 E.0088
G1 X89.811 Y100.254 E.00623
G1 X89.755 Y100.564 E.00526
G1 X89.699 Y100.765 E.00349
G1 X89.581 Y101.102 E.00596
G1 X89.319 Y101.579 E.0091
G1 X88.979 Y101.996 E.00899
G1 X88.578 Y102.335 E.00878
G1 X88.243 Y102.545 E.00661
G1 X87.901 Y102.698 E.00627
G1 X87.397 Y102.845 E.00878
G1 X86.886 Y102.9 E.00859
G1 X86.315 Y102.853 E.00957
G1 X85.998 Y102.777 E.00546
G1 X85.651 Y102.657 E.00613
G1 X85.193 Y102.409 E.0087
G1 X84.749 Y102.058 E.00947
G1 X84.445 Y101.716 E.00765
G1 X84.249 Y101.418 E.00595
G1 X84.089 Y101.109 E.00583
G1 X83.941 Y100.7 E.00727
G1 X83.855 Y100.257 E.00754
G1 X83.834 Y99.891 E.00612
G1 X83.856 Y99.536 E.00595
G1 X83.924 Y99.187 E.00595
G1 X84.025 Y98.846 E.00595
G1 X84.169 Y98.523 E.00591
G1 X84.31 Y98.286 E.00459
G1 X84.616 Y97.882 E.00848
G1 X84.873 Y97.611 E.00624
; LINE_WIDTH: 0.404133
G1 X84.999 Y97.492 E.00327
; LINE_WIDTH: 0.437386
G1 X85.11 Y97.388 E.00313
; LINE_WIDTH: 0.474516
G1 X85.381 Y97.168 E.00781
; WIPE_START
G1 X85.11 Y97.388 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X88.21 Y97.129 Z4.32 F18000
G1 Z3.92
G1 E.4 F1800
; LINE_WIDTH: 0.479836
G1 F1500
M204 S6000
G1 X88.454 Y97.315 E.00696
; LINE_WIDTH: 0.446305
G1 X88.593 Y97.436 E.00386
; LINE_WIDTH: 0.411625
G1 X88.707 Y97.537 E.00294
; WIPE_START
G1 X88.593 Y97.436 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X93.61 Y96.144 Z4.32 F18000
G1 Z3.92
G1 E.4 F1800
; LINE_WIDTH: 0.109755
G1 F1500
M204 S6000
G1 X93.837 Y96.009 E.00111
; WIPE_START
G1 X93.61 Y96.144 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X96.662 Y89.148 Z4.32 F18000
G1 X97.332 Y87.615 Z4.32
G1 Z3.92
G1 E.4 F1800
; LINE_WIDTH: 0.196522
G1 F1500
M204 S6000
G1 X97.332 Y86.992 E.0053
M204 S10000
G1 X97.332 Y86.209 F18000
G1 F1500
M204 S6000
G1 X97.332 Y85.587 E.0053
; WIPE_START
G1 X97.332 Y86.209 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X90.628 Y82.56 Z4.32 F18000
G1 X80.327 Y76.954 Z4.32
G1 Z3.92
G1 E.4 F1800
; LINE_WIDTH: 0.0923742
G1 F1500
M204 S6000
G1 X80.227 Y76.989 E.00035
; LINE_WIDTH: 0.130246
G1 X80.029 Y77.08 E.00113
; LINE_WIDTH: 0.152025
G1 X79.794 Y77.32 E.00212
G1 X79.739 Y77.434 E.0008
; LINE_WIDTH: 0.102637
G1 X79.688 Y77.598 E.00066
; WIPE_START
G1 X79.739 Y77.434 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X79.721 Y85.067 Z4.32 F18000
G1 X79.696 Y95.634 Z4.32
G1 Z3.92
G1 E.4 F1800
; LINE_WIDTH: 0.0961166
G1 F1500
M204 S6000
G1 X79.75 Y95.802 E.00062
; LINE_WIDTH: 0.158983
G1 X79.927 Y96.03 E.00192
G1 X80.074 Y96.154 E.00128
; LINE_WIDTH: 0.107261
G1 X80.315 Y96.239 E.00104
; WIPE_START
G1 X80.074 Y96.154 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X86.941 Y92.821 Z4.32 F18000
G1 X99.434 Y86.757 Z4.32
G1 Z3.92
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X99.909 Y86.078 E.01631
G1 X100.58 Y86.548 E.01612
G1 X100.876 Y86.755 E.00709
G1 X100.4 Y87.434 E.01631
G1 F1739.736
G1 X100.376 Y87.469 E.00085
G1 F2536.476
G1 X100.048 Y87.24 E.00787
G1 X99.423 Y86.802 E.01501
; CHANGE_LAYER
; Z_HEIGHT: 4.04
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F2536.476
M204 S6000
G1 X99.909 Y86.078 E-.16574
G1 X100.58 Y86.548 E-.15567
G1 X100.833 Y86.725 E-.05859
; WIPE_END
G1 E-.02 F1800
; layer num/total_layer_count: 33/49
; update layer progress
M73 L33
M991 S0 P32 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z4.32 I.375 J-1.158 P1  F18000
G1 X93.851 Y84.461 Z4.32
G1 Z4.04
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X93.851 Y77.127 E.15523
G1 X94.029 Y77.071 E.00395
G1 X94.092 Y77.162 E.00234
G1 X94.157 Y77.3 E.00324
G1 X94.197 Y77.448 E.00324
G1 X94.212 Y77.628 E.00382
G1 X94.212 Y88.382 E.22761
G1 X93.851 Y88.382 E.00765
G1 X93.851 Y84.521 E.08171
; WIPE_START
M204 S6000
G1 X93.851 Y82.521 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X93.869 Y90.153 Z4.44 F18000
G1 X93.882 Y95.466 Z4.44
G1 Z4.04
G1 E.4 F1800
G1 F1500
M204 S500
G1 X93.943 Y95.377 E.00228
G1 X94.159 Y95.319 E.00473
G1 X94.186 Y95.499 E.00386
G1 X94.175 Y95.566 E.00144
G1 X94.111 Y95.632 E.00195
G1 X93.858 Y95.743 E.00585
G1 X93.877 Y95.525 E.00463
; WIPE_START
M204 S6000
G1 X93.943 Y95.377 E-.05052
G1 X94.159 Y95.319 E-.06938
G1 X94.186 Y95.499 E-.05664
G1 X94.175 Y95.566 E-.02108
G1 X94.111 Y95.632 E-.02867
G1 X93.858 Y95.743 E-.08581
G1 X93.877 Y95.525 E-.0679
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X88.027 Y97.088 Z4.44 F18000
G1 Z4.04
G1 E.4 F1800
G1 F1500
M204 S500
G1 X87.436 Y96.915 E.01304
G1 X87.062 Y96.864 E.00798
G1 X86.729 Y96.857 E.00706
G1 X86.159 Y96.928 E.01215
G1 X85.597 Y97.11 E.01251
G1 X85.49 Y96.949 E.0041
G1 X85.842 Y96.544 E.01135
G1 X87.788 Y96.544 E.04118
G1 X88.13 Y96.925 E.01083
G1 X88.059 Y97.037 E.0028
; WIPE_START
M204 S6000
G1 X87.436 Y96.915 E-.1207
G1 X87.062 Y96.864 E-.07163
G1 X86.729 Y96.857 E-.06334
G1 X86.159 Y96.928 E-.10905
G1 X86.083 Y96.953 E-.01529
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X88.988 Y101.382 Z4.44 F18000
G1 Z4.04
G1 E.4 F1800
G1 F1500
M204 S500
G1 X88.904 Y101.504 E.00313
G1 X88.692 Y101.747 E.00683
G1 X88.341 Y102.045 E.00975
G1 X87.934 Y102.28 E.00995
G1 X87.5 Y102.435 E.00975
G1 X87.183 Y102.498 E.00683
G1 X86.858 Y102.522 E.00691
G1 X86.366 Y102.479 E.01044
G1 X86.095 Y102.415 E.0059
G1 X85.793 Y102.307 E.00679
G1 X85.387 Y102.089 E.00975
G1 X85.017 Y101.793 E.01003
G1 X84.691 Y101.411 E.01064
G1 X84.542 Y101.175 E.0059
G1 X84.403 Y100.886 E.00679
G1 X84.267 Y100.446 E.00975
G1 X84.211 Y99.979 E.00995
G1 X84.239 Y99.506 E.01003
G1 X84.364 Y99.02 E.01064
G1 X84.472 Y98.762 E.0059
G1 X84.628 Y98.482 E.00679
G1 X84.91 Y98.118 E.00975
G1 X85.252 Y97.809 E.00975
G1 X85.521 Y97.632 E.00683
G1 X85.81 Y97.487 E.00683
G1 X86.252 Y97.344 E.00983
G1 X86.751 Y97.282 E.01064
G1 X87.029 Y97.288 E.0059
G1 X87.347 Y97.331 E.00679
G1 X87.793 Y97.461 E.00983
G1 X88.24 Y97.692 E.01064
G1 X88.467 Y97.854 E.0059
G1 X88.708 Y98.071 E.00687
G1 X89.017 Y98.455 E.01044
G1 X89.158 Y98.695 E.0059
G1 X89.289 Y98.989 E.00679
G1 X89.411 Y99.433 E.00975
G1 X89.453 Y99.901 E.00995
G1 X89.411 Y100.369 E.00995
G1 X89.286 Y100.822 E.00995
G1 X89.086 Y101.237 E.00976
G1 X89.022 Y101.332 E.00243
M204 S250
G1 X88.65 Y101.151 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X88.58 Y101.253 E.00242
G1 X88.404 Y101.455 E.00526
G1 X88.104 Y101.709 E.00773
G1 X87.761 Y101.907 E.00779
G1 X87.391 Y102.04 E.00774
G1 X87.128 Y102.091 E.00526
G1 X86.86 Y102.111 E.00529
G1 X86.431 Y102.074 E.00847
G1 X86.211 Y102.022 E.00444
G1 X85.96 Y101.932 E.00525
G1 X85.614 Y101.746 E.00773
G1 X85.303 Y101.498 E.00782
G1 X85.021 Y101.168 E.00853
G1 X84.901 Y100.977 E.00444
G1 X84.785 Y100.736 E.00525
M73 P75 R5
G1 X84.669 Y100.361 E.00773
G1 X84.622 Y99.967 E.0078
G1 X84.646 Y99.57 E.00782
G1 X84.753 Y99.15 E.00853
G1 X84.84 Y98.941 E.00445
G1 X84.97 Y98.708 E.00525
G1 X85.211 Y98.397 E.00773
G1 X85.503 Y98.134 E.00774
G1 X85.726 Y97.987 E.00526
G1 X85.966 Y97.867 E.00526
G1 X86.341 Y97.745 E.00776
G1 X86.771 Y97.692 E.00854
G1 X86.997 Y97.697 E.00445
G1 X87.262 Y97.733 E.00525
G1 X87.641 Y97.843 E.00776
G1 X88.026 Y98.042 E.00853
G1 X88.21 Y98.173 E.00445
G1 X88.41 Y98.353 E.00527
G1 X88.679 Y98.689 E.00847
G1 X88.794 Y98.883 E.00444
G1 X88.902 Y99.127 E.00525
G1 X89.007 Y99.506 E.00773
G1 X89.042 Y99.901 E.00779
G1 X89.007 Y100.296 E.00779
G1 X88.902 Y100.678 E.0078
G1 X88.731 Y101.032 E.00774
G1 X88.683 Y101.102 E.00166
; WIPE_START
M204 S6000
G1 X88.58 Y101.253 E-.03482
G1 X88.404 Y101.455 E-.05082
G1 X88.104 Y101.709 E-.07472
G1 X87.761 Y101.907 E-.07528
G1 X87.391 Y102.04 E-.07473
G1 X87.128 Y102.091 E-.05083
G1 X87.03 Y102.099 E-.01879
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X88.039 Y96.12 Z4.44 F18000
G1 Z4.04
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X93.399 Y96.12 E.11344
G1 X93.463 Y95.391 E.01548
G1 X93.515 Y95.242 E.00336
G1 X93.564 Y95.162 E.00199
G1 X93.74 Y95.003 E.00501
G1 X93.857 Y94.951 E.00272
G1 X94.258 Y94.862 E.0087
G1 X98.046 Y89.453 E.13977
G1 X98.342 Y89.66 E.00765
G1 X94.551 Y95.075 E.1399
G1 X94.609 Y95.462 E.00829
G1 X94.592 Y95.649 E.00397
G1 X94.525 Y95.805 E.0036
G1 X94.388 Y95.956 E.00431
G1 X94.31 Y96.008 E.00197
G1 X94.079 Y96.109 E.00535
G1 X93.852 Y96.308 E.00638
G1 X93.723 Y96.387 E.00321
G1 X93.581 Y96.443 E.00321
G1 X93.441 Y96.472 E.00304
G1 X88.305 Y96.485 E.10871
G1 X89.422 Y97.732 E.03544
G1 X89.628 Y98.002 E.00719
G1 X89.918 Y98.524 E.01264
G1 X90.06 Y98.901 E.00853
G1 X90.156 Y99.291 E.00849
G1 X90.206 Y99.699 E.00869
G1 X90.201 Y100.155 E.00966
G1 X90.16 Y100.487 E.00709
G1 X90.067 Y100.879 E.00853
G1 X89.926 Y101.26 E.00859
G1 X89.811 Y101.494 E.00551
G1 X89.64 Y101.782 E.00709
G1 X89.39 Y102.11 E.00873
G1 X88.968 Y102.52 E.01245
G1 X88.575 Y102.794 E.01013
G1 X88.113 Y103.029 E.01097
G1 X87.724 Y103.161 E.00869
G1 X87.331 Y103.243 E.0085
G1 X86.932 Y103.279 E.00849
G1 X86.531 Y103.267 E.00849
G1 X85.948 Y103.163 E.01254
G1 X85.559 Y103.032 E.00869
G1 X85.197 Y102.859 E.00849
G1 X84.858 Y102.644 E.00849
G1 X84.409 Y102.258 E.01254
G1 X84.141 Y101.947 E.00869
G1 X83.918 Y101.613 E.00849
G1 X83.737 Y101.26 E.00841
G1 X83.577 Y100.808 E.01014
G1 X83.475 Y100.3 E.01097
G1 X83.452 Y99.89 E.00869
G1 X83.477 Y99.49 E.00849
G1 X83.549 Y99.095 E.0085
G1 X83.668 Y98.712 E.00849
G1 X83.831 Y98.345 E.00849
G1 X84.149 Y97.845 E.01254
G1 X85.335 Y96.482 E.03825
G1 X80.368 Y96.482 E.10513
G1 X80.12 Y96.453 E.00527
G1 X79.975 Y96.405 E.00324
G1 X79.812 Y96.31 E.00399
G1 X79.624 Y96.123 E.00562
G1 X79.575 Y96.048 E.00189
G1 X79.481 Y95.821 E.00521
G1 X79.451 Y95.565 E.00546
G1 X79.451 Y77.628 E.37965
G1 X79.487 Y77.357 E.00578
G1 X79.547 Y77.207 E.00343
G1 X79.627 Y77.076 E.00324
G1 X79.799 Y76.901 E.0052
G1 X80.027 Y76.776 E.0055
G1 X80.287 Y76.723 E.00562
G1 X93.357 Y76.722 E.27664
G1 X93.479 Y76.734 E.00259
G1 X93.632 Y76.775 E.00335
G1 X93.862 Y76.904 E.00556
G1 X93.805 Y77.082 E.00395
G1 X80.778 Y77.082 E.27575
G1 X80.489 Y77.133 E.0062
G1 X80.213 Y77.281 E.00663
G1 X79.987 Y77.517 E.00693
G1 X79.849 Y77.803 E.00671
G1 X79.812 Y78.056 E.0054
G1 X79.812 Y95.137 E.36154
G1 X79.837 Y95.346 E.00446
G1 X79.94 Y95.605 E.00591
G1 X80.091 Y95.809 E.00536
G1 X80.3 Y95.976 E.00566
G1 X80.543 Y96.084 E.00564
G1 X80.787 Y96.12 E.00521
G1 X87.979 Y96.12 E.15224
; WIPE_START
M204 S6000
G1 X89.979 Y96.12 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X89.219 Y96.892 Z4.44 F18000
G1 Z4.04
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X89.738 Y97.471 E.0153
G1 X89.966 Y97.771 E.0074
M73 P76 R5
G1 X90.123 Y98.025 E.00588
G1 X90.293 Y98.359 E.00737
G1 X90.452 Y98.78 E.00886
G1 X90.559 Y99.217 E.00885
G1 X90.614 Y99.667 E.00891
G1 X90.609 Y100.188 E.01025
G1 X90.564 Y100.56 E.00737
G1 X90.459 Y100.998 E.00886
G1 X90.303 Y101.422 E.00888
G1 X90.171 Y101.689 E.00586
G1 X89.979 Y102.011 E.00737
G1 X89.705 Y102.372 E.00893
G1 X89.557 Y102.534 E.0043
G1 X89.224 Y102.839 E.00889
G1 X88.791 Y103.143 E.0104
G1 X88.262 Y103.411 E.01167
G1 X87.833 Y103.556 E.00891
G1 X87.392 Y103.649 E.00885
G1 X86.944 Y103.689 E.00884
G1 X86.494 Y103.676 E.00885
G1 X86.047 Y103.608 E.00891
G1 X85.834 Y103.557 E.00431
G1 X85.405 Y103.412 E.00891
G1 X84.999 Y103.218 E.00885
G1 X84.618 Y102.977 E.00885
G1 X84.267 Y102.691 E.00891
G1 X84.11 Y102.538 E.0043
G1 X83.815 Y102.195 E.00891
G1 X83.565 Y101.821 E.00885
G1 X83.361 Y101.422 E.00883
G1 X83.184 Y100.923 E.0104
G1 X83.067 Y100.341 E.01167
G1 X83.042 Y99.889 E.00891
G1 X83.07 Y99.44 E.00885
G1 X83.151 Y98.997 E.00885
G1 X83.284 Y98.567 E.00885
G1 X83.467 Y98.156 E.00885
G1 X83.7 Y97.767 E.00891
G1 X83.828 Y97.59 E.0043
G1 X84.436 Y96.891 E.01823
G1 X80.344 Y96.891 E.08049
G1 X80.031 Y96.854 E.00619
G1 X79.818 Y96.784 E.00442
G1 X79.687 Y96.718 E.00289
G1 X79.411 Y96.503 E.00688
G1 X79.216 Y96.248 E.0063
G1 X79.119 Y96.039 E.00454
G1 X79.079 Y95.904 E.00277
G1 X79.042 Y95.589 E.00625
G1 X79.042 Y77.61 E.35362
G1 X79.062 Y77.374 E.00466
G1 X79.095 Y77.234 E.00283
G1 X79.18 Y77.022 E.00448
G1 X79.298 Y76.831 E.00442
G1 X79.449 Y76.661 E.00448
G1 X79.559 Y76.568 E.00283
G1 X79.756 Y76.447 E.00454
G1 X80.058 Y76.341 E.0063
G1 X80.259 Y76.313 E.00399
G1 X93.379 Y76.313 E.25805
G1 X93.554 Y76.331 E.00346
G1 X93.772 Y76.389 E.00445
G1 X93.976 Y76.484 E.00442
G1 X94.16 Y76.613 E.00442
G1 X94.319 Y76.772 E.00442
G1 X94.448 Y76.956 E.00442
G1 X94.543 Y77.16 E.00442
G1 X94.601 Y77.377 E.00442
G1 X94.622 Y77.61 E.0046
G1 X94.622 Y86.088 E.16676
G1 X97.042 Y86.088 E.0476
G1 X97.042 Y85.388 E.01378
G1 X97.232 Y85.198 E.00529
G1 X97.622 Y85.588 E.01085
G1 X97.622 Y87.614 E.03985
G1 X97.232 Y88.004 E.01085
G1 X97.042 Y87.814 E.00529
G1 X97.042 Y87.113 E.01378
G1 X94.622 Y87.113 E.0476
G1 X94.622 Y88.791 E.03299
G1 X93.442 Y88.791 E.02321
G1 X93.442 Y77.491 E.22226
G1 X80.813 Y77.491 E.24839
G1 X80.625 Y77.524 E.00376
G1 X80.464 Y77.611 E.00359
G1 X80.327 Y77.753 E.00389
G1 X80.245 Y77.924 E.00372
G1 X80.222 Y78.086 E.00321
G1 X80.222 Y95.113 E.33491
G1 X80.237 Y95.245 E.00261
G1 X80.3 Y95.404 E.00337
G1 X80.388 Y95.522 E.0029
G1 X80.515 Y95.624 E.00319
G1 X80.658 Y95.688 E.00308
G1 X80.816 Y95.711 E.00315
G1 X93.024 Y95.711 E.24011
G1 X93.058 Y95.326 E.00759
G1 X93.083 Y95.221 E.00214
G1 X93.147 Y95.058 E.00345
G1 X93.236 Y94.913 E.00334
G1 X93.381 Y94.757 E.00419
G1 X93.535 Y94.646 E.00372
G1 X93.729 Y94.56 E.00417
G1 X94.014 Y94.497 E.00576
G1 X97.921 Y88.918 E.13396
G1 F1739.897
G1 X97.945 Y88.883 E.00085
G1 F2536.476
G1 X98.273 Y89.112 E.00787
G1 X98.584 Y89.33 E.00747
G1 X98.912 Y89.56 E.00787
G1 F1739.85
G1 X98.887 Y89.595 E.00085
G1 F1500
G1 X94.98 Y95.175 E.134
G1 X95.018 Y95.43 E.00506
G1 X95.019 Y95.563 E.00263
G1 X94.992 Y95.741 E.00354
G1 X94.88 Y96.01 E.00572
G1 X94.82 Y96.099 E.00212
G1 X94.651 Y96.272 E.00476
G1 X94.508 Y96.368 E.00338
G1 X94.301 Y96.459 E.00444
G1 X94.096 Y96.639 E.00538
G1 X93.906 Y96.755 E.00438
G1 X93.698 Y96.837 E.00438
G1 X93.483 Y96.881 E.00432
G1 X89.279 Y96.892 E.08268
; WIPE_START
M204 S6000
G1 X89.738 Y97.471 E-.14042
G1 X89.966 Y97.771 E-.07146
G1 X90.123 Y98.025 E-.05676
G1 X90.293 Y98.359 E-.07123
G1 X90.368 Y98.556 E-.04012
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




G1 X88.724 Y97.55
G1 Z4.04
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.361335
G1 F1500
M204 S6000
G1 X88.993 Y97.82 E.00638
G1 X89.322 Y98.23 E.0088
G1 X89.569 Y98.679 E.00857
G1 X89.693 Y99.015 E.006
G1 X89.783 Y99.359 E.00596
G1 X89.829 Y99.915 E.00934
G1 X89.787 Y100.422 E.00851
G1 X89.643 Y100.94 E.00901
G1 X89.419 Y101.415 E.00879
G1 X89.209 Y101.727 E.00629
G1 X88.946 Y102.022 E.00661
G1 X88.568 Y102.343 E.0083
G1 X88.119 Y102.611 E.00877
G1 X87.622 Y102.794 E.00887
G1 X87.275 Y102.867 E.00593
G1 X86.921 Y102.898 E.00596
G1 X86.568 Y102.883 E.00592
G1 X85.997 Y102.781 E.00971
G1 X85.628 Y102.647 E.00657
G1 X85.168 Y102.395 E.00879
G1 X84.766 Y102.075 E.00859
G1 X84.445 Y101.713 E.00811
G1 X84.247 Y101.42 E.00592
G1 X84.057 Y101.035 E.00718
G1 X83.895 Y100.51 E.0092
G1 X83.837 Y100.005 E.00851
G1 X83.856 Y99.536 E.00786
G1 X83.924 Y99.187 E.00596
G1 X84.025 Y98.846 E.00595
G1 X84.17 Y98.521 E.00596
G1 X84.306 Y98.285 E.00456
G1 X84.624 Y97.872 E.00871
G1 X84.817 Y97.673 E.00465
; LINE_WIDTH: 0.400599
G1 X84.992 Y97.496 E.00464
; LINE_WIDTH: 0.438389
G1 X85.199 Y97.319 E.00562
; LINE_WIDTH: 0.477104
G1 X85.379 Y97.165 E.00534
; WIPE_START
G1 X85.199 Y97.319 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X88.242 Y97.145 Z4.44 F18000
G1 Z4.04
G1 E.4 F1800
; LINE_WIDTH: 0.484692
G1 F1500
M204 S6000
G1 X88.454 Y97.309 E.00614
; LINE_WIDTH: 0.455817
G1 X88.594 Y97.432 E.004
; LINE_WIDTH: 0.418157
G1 X88.709 Y97.535 E.00301
; LINE_WIDTH: 0.399466
G1 X88.724 Y97.55 E.0004
; WIPE_START
G1 X88.709 Y97.535 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X93.61 Y96.144 Z4.44 F18000
G1 Z4.04
G1 E.4 F1800
; LINE_WIDTH: 0.109771
G1 F1500
M204 S6000
G1 X93.837 Y96.009 E.00111
; WIPE_START
G1 X93.61 Y96.144 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X94.253 Y88.538 Z4.44 F18000
G1 X94.417 Y86.601 Z4.44
G1 Z4.04
G1 E.4 F1800
; LINE_WIDTH: 0.641742
G1 F1500
M204 S6000
G1 X97.417 Y86.601 E.09219
M204 S10000
G1 X97.024 Y86.909 F18000
; LINE_WIDTH: 0.345945
G1 F1500
M204 S6000
G1 X97.101 Y86.755 E.00275
; LINE_WIDTH: 0.30325
G1 X97.178 Y86.601 E.00238
; LINE_WIDTH: 0.260567
G1 X97.255 Y86.755 E.00202
; LINE_WIDTH: 0.217877
G1 X97.332 Y86.909 E.00165
; LINE_WIDTH: 0.196522
G1 X97.332 Y87.615 E.00601
; WIPE_START
G1 X97.332 Y86.909 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X97.024 Y86.293 Z4.44 F18000
G1 Z4.04
G1 E.4 F1800
; LINE_WIDTH: 0.345947
G1 F1500
M204 S6000
G1 X97.101 Y86.447 E.00275
; LINE_WIDTH: 0.303257
G1 X97.178 Y86.601 E.00238
; LINE_WIDTH: 0.260555
G1 X97.255 Y86.447 E.00202
; LINE_WIDTH: 0.200708
G1 X97.332 Y86.293 E.0015
G1 X97.332 Y85.587 E.00616
; WIPE_START
G1 X97.332 Y86.293 E-.30546
G1 X97.255 Y86.447 E-.07454
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X90.598 Y82.714 Z4.44 F18000
G1 X80.327 Y76.954 Z4.44
G1 Z4.04
G1 E.4 F1800
; LINE_WIDTH: 0.0927015
G1 F1500
M204 S6000
G1 X80.223 Y76.991 E.00037
; LINE_WIDTH: 0.127189
G1 X80.044 Y77.073 E.00099
; LINE_WIDTH: 0.14931
G1 X79.933 Y77.162 E.00088
G1 X79.789 Y77.331 E.00137
G1 X79.737 Y77.434 E.00071
; LINE_WIDTH: 0.100955
G1 X79.689 Y77.596 E.00064
; WIPE_START
G1 X79.737 Y77.434 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X79.774 Y85.066 Z4.44 F18000
G1 X79.828 Y96.032 Z4.44
G1 Z4.04
G1 E.4 F1800
; LINE_WIDTH: 0.0940678
G1 F1500
M204 S6000
G1 X79.695 Y95.628 E.00145
M204 S10000
G1 X79.679 Y95.677 F18000
; LINE_WIDTH: 0.151924
G1 F1500
M204 S6000
G1 X79.895 Y96.009 E.0025
G1 X80.16 Y96.194 E.00203
; LINE_WIDTH: 0.0987253
G1 X80.31 Y96.238 E.00057
; WIPE_START
G1 X80.16 Y96.194 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X87.021 Y92.851 Z4.44 F18000
G1 X99.386 Y86.826 Z4.44
G1 Z4.04
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X99.909 Y86.078 E.01796
G1 X100.607 Y86.566 E.01674
G1 X100.876 Y86.755 E.00646
G1 X100.352 Y87.503 E.01796
G1 F1739.736
G1 X100.327 Y87.538 E.00085
G1 F2536.476
G1 X100 Y87.309 E.00787
G1 X99.375 Y86.871 E.01501
; CHANGE_LAYER
; Z_HEIGHT: 4.16
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F2536.476
M204 S6000
G1 X99.909 Y86.078 E-.1817
G1 X100.607 Y86.566 E-.16175
G1 X100.764 Y86.677 E-.03655
; WIPE_END
G1 E-.02 F1800
; layer num/total_layer_count: 34/49
; update layer progress
M73 L34
M991 S0 P33 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z4.44 I.364 J-1.161 P1  F18000
M73 P77 R5
G1 X93.851 Y84.507 Z4.44
G1 Z4.16
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X93.851 Y77.128 E.15617
G1 X94.036 Y77.076 E.00407
G1 X94.117 Y77.207 E.00325
G1 X94.173 Y77.349 E.00324
G1 X94.202 Y77.49 E.00306
G1 X94.212 Y88.382 E.23052
G1 X93.851 Y88.382 E.00765
G1 X93.851 Y84.567 E.08075
; WIPE_START
M204 S6000
G1 X93.851 Y82.567 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X93.869 Y90.199 Z4.56 F18000
G1 X93.881 Y95.474 Z4.56
G1 Z4.16
G1 E.4 F1800
G1 F1500
M204 S500
G1 X93.893 Y95.432 E.00093
G1 X93.954 Y95.367 E.00188
G1 X94.159 Y95.318 E.00445
G1 X94.184 Y95.49 E.00369
G1 X94.168 Y95.581 E.00194
G1 X94.128 Y95.619 E.00118
G1 X93.858 Y95.743 E.00628
G1 X93.876 Y95.534 E.00445
; WIPE_START
M204 S6000
G1 X93.893 Y95.432 E-.03199
G1 X93.954 Y95.367 E-.02742
G1 X94.159 Y95.318 E-.06492
G1 X94.184 Y95.49 E-.05382
G1 X94.168 Y95.581 E-.02833
G1 X94.128 Y95.619 E-.01719
G1 X93.858 Y95.743 E-.09154
G1 X93.876 Y95.534 E-.0648
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X88.044 Y97.114 Z4.56 F18000
G1 Z4.16
G1 E.4 F1800
G1 F1500
M204 S500
G1 X87.945 Y97.064 E.00235
G1 X87.436 Y96.915 E.01123
G1 X87.062 Y96.864 E.00798
G1 X86.726 Y96.858 E.00711
G1 X86.159 Y96.928 E.01209
G1 X85.666 Y97.088 E.01097
G1 X85.56 Y96.922 E.00416
G1 X85.909 Y96.544 E.01089
G1 X87.821 Y96.544 E.04046
G1 X88.172 Y96.948 E.01133
G1 X88.081 Y97.066 E.00315
; WIPE_START
M204 S6000
G1 X87.945 Y97.064 E-.02585
G1 X87.436 Y96.915 E-.10079
G1 X87.062 Y96.864 E-.07168
G1 X86.726 Y96.858 E-.06382
G1 X86.159 Y96.928 E-.10857
G1 X86.113 Y96.943 E-.00929
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X88.971 Y101.41 Z4.56 F18000
G1 Z4.16
G1 E.4 F1800
G1 F1500
M204 S500
G1 X88.699 Y101.741 E.00907
G1 X88.341 Y102.045 E.00995
G1 X87.942 Y102.275 E.00975
G1 X87.643 Y102.392 E.0068
G1 X87.371 Y102.465 E.00595
G1 X86.871 Y102.523 E.01066
G1 X86.369 Y102.48 E.01066
G1 X86.095 Y102.415 E.00595
G1 X85.793 Y102.307 E.00679
G1 X85.387 Y102.089 E.00975
G1 X85.02 Y101.796 E.00995
G1 X84.711 Y101.442 E.00995
G1 X84.47 Y101.039 E.00994
G1 X84.308 Y100.607 E.00975
G1 X84.241 Y100.291 E.00683
G1 X84.212 Y99.97 E.00683
G1 X84.239 Y99.507 E.00983
G1 X84.364 Y99.022 E.01058
G1 X84.472 Y98.762 E.00595
G1 X84.628 Y98.482 E.0068
G1 X84.91 Y98.118 E.00975
G1 X85.252 Y97.809 E.00975
G1 X85.521 Y97.632 E.00683
G1 X85.81 Y97.487 E.00683
G1 X86.252 Y97.344 E.00983
G1 X86.748 Y97.282 E.01059
G1 X87.029 Y97.288 E.00595
G1 X87.347 Y97.331 E.0068
G1 X87.789 Y97.46 E.00975
G1 X88.201 Y97.666 E.00975
G1 X88.465 Y97.852 E.00683
G1 X88.708 Y98.071 E.00691
G1 X89.015 Y98.453 E.01039
G1 X89.158 Y98.695 E.00596
G1 X89.289 Y98.989 E.00679
G1 X89.411 Y99.433 E.00975
G1 X89.453 Y99.901 E.00995
G1 X89.412 Y100.36 E.00975
G1 X89.336 Y100.671 E.00679
G1 X89.239 Y100.935 E.00596
G1 X89.007 Y101.362 E.01027
M204 S250
G1 X88.655 Y101.15 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X88.407 Y101.452 E.0077
G1 X88.104 Y101.709 E.0078
G1 X87.764 Y101.905 E.00773
G1 X87.515 Y102.003 E.00525
G1 X87.294 Y102.062 E.00449
G1 X86.865 Y102.112 E.00851
G1 X86.434 Y102.074 E.00851
G1 X86.211 Y102.022 E.00449
G1 X85.96 Y101.932 E.00525
G1 X85.614 Y101.746 E.00773
G1 X85.304 Y101.499 E.0078
G1 X85.043 Y101.2 E.0078
G1 X84.84 Y100.86 E.00779
G1 X84.702 Y100.492 E.00774
G1 X84.646 Y100.23 E.00526
G1 X84.622 Y99.964 E.00526
G1 X84.646 Y99.57 E.00776
G1 X84.753 Y99.152 E.00848
G1 X84.84 Y98.941 E.00449
G1 X84.97 Y98.708 E.00525
G1 X85.211 Y98.397 E.00773
G1 X85.503 Y98.134 E.00773
G1 X85.726 Y97.987 E.00526
G1 X85.966 Y97.867 E.00526
G1 X86.341 Y97.745 E.00776
G1 X86.769 Y97.692 E.00849
G1 X86.997 Y97.697 E.00449
G1 X87.262 Y97.733 E.00525
G1 X87.639 Y97.843 E.00773
G1 X87.991 Y98.019 E.00773
G1 X88.21 Y98.173 E.00526
G1 X88.409 Y98.353 E.00529
G1 X88.678 Y98.686 E.00842
G1 X88.794 Y98.883 E.00449
G1 X88.902 Y99.127 E.00525
G1 X89.007 Y99.506 E.00774
G1 X89.042 Y99.901 E.00779
G1 X89.007 Y100.292 E.00773
G1 X88.944 Y100.552 E.00525
G1 X88.865 Y100.766 E.0045
G1 X88.685 Y101.098 E.00743
; WIPE_START
M204 S6000
G1 X88.407 Y101.452 E-.08562
G1 X88.104 Y101.709 E-.07533
G1 X87.764 Y101.905 E-.07468
G1 X87.515 Y102.003 E-.05073
G1 X87.294 Y102.062 E-.04341
G1 X87.032 Y102.092 E-.05024
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X88.075 Y96.12 Z4.56 F18000
G1 Z4.16
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X93.399 Y96.12 E.11268
G1 X93.462 Y95.401 E.01529
G1 X93.489 Y95.301 E.00217
G1 X93.559 Y95.168 E.0032
G1 X93.667 Y95.053 E.00333
G1 X93.825 Y94.962 E.00387
G1 X94.262 Y94.857 E.00952
G1 X98.094 Y89.384 E.14141
G1 X98.39 Y89.591 E.00765
G1 X94.551 Y95.074 E.14167
G1 X94.61 Y95.524 E.0096
G1 X94.58 Y95.681 E.00338
G1 X94.542 Y95.775 E.00216
G1 X94.395 Y95.951 E.00483
G1 X94.31 Y96.008 E.00217
G1 X94.079 Y96.109 E.00536
G1 X93.852 Y96.308 E.00638
G1 X93.723 Y96.387 E.00321
G1 X93.581 Y96.443 E.00322
G1 X93.441 Y96.472 E.00304
G1 X88.332 Y96.485 E.10814
G1 X89.515 Y97.845 E.03814
G1 X89.764 Y98.222 E.00956
G1 X89.918 Y98.524 E.0072
G1 X90.06 Y98.901 E.00852
G1 X90.156 Y99.291 E.00849
G1 X90.206 Y99.699 E.00869
G1 X90.188 Y100.295 E.01264
G1 X90.067 Y100.878 E.01259
G1 X89.928 Y101.256 E.00853
G1 X89.741 Y101.621 E.00869
G1 X89.39 Y102.11 E.01274
G1 X89.27 Y102.242 E.00378
G1 X88.909 Y102.565 E.01024
G1 X88.475 Y102.855 E.01107
G1 X88.104 Y103.032 E.00869
G1 X87.716 Y103.164 E.00869
G1 X87.132 Y103.267 E.01254
G1 X86.731 Y103.279 E.00849
G1 X86.332 Y103.243 E.00849
G1 X85.939 Y103.161 E.00849
G1 X85.383 Y102.955 E.01254
G1 X85.024 Y102.757 E.00869
G1 X84.699 Y102.522 E.00849
G1 X84.403 Y102.251 E.00849
G1 X84.141 Y101.947 E.00849
G1 X83.918 Y101.613 E.0085
G1 X83.737 Y101.259 E.00841
G1 X83.579 Y100.812 E.01004
G1 X83.475 Y100.3 E.01107
G1 X83.452 Y99.89 E.00869
G1 X83.477 Y99.49 E.00849
G1 X83.549 Y99.095 E.00849
G1 X83.668 Y98.712 E.00849
G1 X83.83 Y98.348 E.00841
G1 X84.078 Y97.944 E.01004
G1 X84.286 Y97.676 E.00718
G1 X85.39 Y96.482 E.03442
G1 X80.368 Y96.482 E.1063
G1 X80.129 Y96.454 E.00508
G1 X79.856 Y96.34 E.00626
G1 X79.664 Y96.173 E.0054
G1 X79.57 Y96.038 E.00348
G1 X79.48 Y95.817 E.00504
G1 X79.451 Y95.565 E.00538
G1 X79.451 Y77.628 E.37965
G1 X79.487 Y77.357 E.00578
G1 X79.592 Y77.125 E.0054
G1 X79.777 Y76.92 E.00585
G1 X79.89 Y76.841 E.00293
G1 X80.031 Y76.775 E.00329
G1 X80.28 Y76.723 E.00539
G1 X93.35 Y76.722 E.27662
G1 X93.538 Y76.747 E.00402
G1 X93.68 Y76.794 E.00317
G1 X93.856 Y76.889 E.00424
G1 X93.807 Y77.082 E.0042
G1 X80.786 Y77.082 E.2756
G1 X80.528 Y77.12 E.00552
G1 X80.226 Y77.271 E.00717
G1 X80.002 Y77.495 E.00669
G1 X79.85 Y77.798 E.00717
G1 X79.812 Y78.056 E.00552
G1 X79.812 Y95.137 E.36154
G1 X79.837 Y95.346 E.00446
G1 X79.94 Y95.605 E.0059
G1 X80.093 Y95.811 E.00542
G1 X80.312 Y95.984 E.0059
G1 X80.547 Y96.085 E.00542
G1 X80.787 Y96.12 E.00513
G1 X88.015 Y96.12 E.153
; WIPE_START
M204 S6000
G1 X90.015 Y96.12 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X89.228 Y96.892 Z4.56 F18000
G1 Z4.16
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X89.835 Y97.59 E.01819
G1 X89.965 Y97.768 E.00433
G1 X90.12 Y98.021 E.00583
G1 X90.293 Y98.359 E.00747
G1 X90.452 Y98.78 E.00886
G1 X90.559 Y99.217 E.00885
G1 X90.614 Y99.667 E.00891
G1 X90.621 Y99.886 E.0043
G1 X90.596 Y100.339 E.00894
G1 X90.549 Y100.629 E.00577
G1 X90.459 Y100.998 E.00746
G1 X90.303 Y101.42 E.00886
G1 X90.097 Y101.824 E.00891
G1 X89.981 Y102.009 E.00431
G1 X89.705 Y102.372 E.00897
G1 X89.558 Y102.533 E.00428
G1 X89.165 Y102.885 E.01038
G1 X88.856 Y103.105 E.00746
G1 X88.667 Y103.216 E.00431
G1 X88.259 Y103.412 E.00891
G1 X87.83 Y103.557 E.00891
G1 X87.617 Y103.608 E.0043
G1 X87.169 Y103.676 E.00891
G1 X86.719 Y103.689 E.00885
G1 X86.271 Y103.649 E.00885
G1 X85.831 Y103.556 E.00885
G1 X85.402 Y103.411 E.00891
G1 X85.201 Y103.322 E.0043
G1 X84.805 Y103.103 E.00891
G1 X84.44 Y102.84 E.00885
G1 X84.108 Y102.536 E.00885
G1 X83.815 Y102.195 E.00885
G1 X83.564 Y101.821 E.00885
G1 X83.361 Y101.421 E.00882
G1 X83.185 Y100.927 E.01031
G1 X83.067 Y100.341 E.01176
G1 X83.042 Y99.889 E.00891
G1 X83.07 Y99.44 E.00885
G1 X83.151 Y98.997 E.00885
G1 X83.284 Y98.567 E.00885
G1 X83.467 Y98.157 E.00882
G1 X83.741 Y97.71 E.01031
G1 X83.974 Y97.411 E.00745
G1 X84.455 Y96.891 E.01394
G1 X80.344 Y96.891 E.08086
G1 X80.034 Y96.855 E.00613
G1 X79.748 Y96.75 E.006
G1 X79.626 Y96.68 E.00277
G1 X79.445 Y96.537 E.00454
G1 X79.346 Y96.432 E.00283
G1 X79.215 Y96.245 E.00449
G1 X79.128 Y96.063 E.00397
G1 X79.078 Y95.903 E.00329
G1 X79.042 Y95.589 E.00623
G1 X79.042 Y77.61 E.35362
G1 X79.062 Y77.374 E.00466
G1 X79.095 Y77.234 E.00283
G1 X79.181 Y77.02 E.00454
G1 X79.253 Y76.895 E.00283
G1 X79.395 Y76.715 E.00451
G1 X79.521 Y76.599 E.00336
G1 X79.686 Y76.485 E.00396
G1 X79.891 Y76.389 E.00444
G1 X80.111 Y76.33 E.00448
G1 X80.257 Y76.313 E.00289
G1 X93.377 Y76.313 E.25807
G1 X93.63 Y76.347 E.00502
G1 X93.842 Y76.417 E.0044
G1 X94.04 Y76.524 E.00442
G1 X94.216 Y76.663 E.00442
G1 X94.366 Y76.831 E.00442
G1 X94.484 Y77.022 E.00442
G1 X94.567 Y77.231 E.00442
G1 X94.612 Y77.448 E.00436
G1 X94.622 Y86.172 E.17158
G1 X97.042 Y86.172 E.04759
G1 X97.042 Y85.388 E.01542
G1 X97.232 Y85.198 E.00529
G1 X97.622 Y85.588 E.01085
G1 X97.622 Y87.614 E.03985
G1 X97.232 Y88.004 E.01085
G1 X97.042 Y87.814 E.00529
G1 X97.042 Y87.03 E.01542
G1 X94.622 Y87.03 E.0476
G1 X94.622 Y88.791 E.03463
G1 X93.442 Y88.791 E.02321
G1 X93.442 Y77.491 E.22226
G1 X80.816 Y77.491 E.24833
G1 X80.653 Y77.515 E.00325
G1 X80.468 Y77.608 E.00406
G1 X80.338 Y77.738 E.00362
G1 X80.246 Y77.922 E.00406
G1 X80.222 Y78.086 E.00325
G1 X80.222 Y95.113 E.33491
G1 X80.237 Y95.245 E.00261
G1 X80.3 Y95.404 E.00337
G1 X80.389 Y95.523 E.00292
G1 X80.523 Y95.629 E.00337
G1 X80.659 Y95.688 E.00291
G1 X80.816 Y95.711 E.00312
G1 X93.024 Y95.711 E.24011
G1 X93.057 Y95.329 E.00753
G1 X93.102 Y95.162 E.0034
G1 X93.235 Y94.915 E.00552
G1 X93.397 Y94.742 E.00466
G1 X93.535 Y94.645 E.00333
G1 X93.689 Y94.573 E.00333
G1 X94.016 Y94.495 E.00662
G1 X97.969 Y88.849 E.13556
G1 F1739.769
G1 X97.994 Y88.814 E.00085
G1 F2536.476
G1 X98.321 Y89.043 E.00787
G1 X98.633 Y89.261 E.00747
G1 X98.96 Y89.491 E.00787
G1 F1739.816
G1 X98.936 Y89.526 E.00085
G1 F1500
G1 X94.98 Y95.175 E.13565
G1 X95.018 Y95.431 E.00509
G1 X95.019 Y95.56 E.00254
G1 X94.975 Y95.797 E.00474
G1 X94.851 Y96.056 E.00566
G1 X94.653 Y96.27 E.00572
G1 X94.508 Y96.368 E.00344
G1 X94.301 Y96.459 E.00445
G1 X94.096 Y96.639 E.00538
G1 X93.906 Y96.755 E.00438
G1 X93.698 Y96.837 E.00438
G1 X93.483 Y96.881 E.00432
G1 X89.288 Y96.892 E.0825
; WIPE_START
M204 S6000
G1 X89.835 Y97.59 E-.16852
G1 X89.965 Y97.768 E-.04186
G1 X90.12 Y98.021 E-.05634
G1 X90.293 Y98.359 E-.07213
G1 X90.37 Y98.561 E-.04116
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




G1 X88.974 Y97.801
G1 Z4.16
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.382217
G1 F1500
M204 S6000
G1 X88.707 Y97.53 E.00675
; LINE_WIDTH: 0.426947
G1 X88.582 Y97.417 E.00337
; LINE_WIDTH: 0.468082
G1 X88.457 Y97.304 E.00372
G1 X88.434 Y97.308 E.00051
; LINE_WIDTH: 0.442599
G1 X88.275 Y97.338 E.00337
; LINE_WIDTH: 0.415876
G1 X88.116 Y97.368 E.00315
M204 S10000
G1 X88.974 Y97.801 F18000
; LINE_WIDTH: 0.360011
G1 F1500
M204 S6000
G1 X89.318 Y98.229 E.00917
G1 X89.489 Y98.514 E.00554
G1 X89.647 Y98.873 E.00654
G1 X89.783 Y99.359 E.00842
G1 X89.827 Y99.886 E.00882
G1 X89.807 Y100.252 E.00611
G1 X89.703 Y100.77 E.0088
G1 X89.589 Y101.081 E.00553
G1 X89.319 Y101.571 E.00933
G1 X89.097 Y101.861 E.00608
G1 X88.954 Y102.012 E.00347
G1 X88.568 Y102.343 E.00848
G1 X88.289 Y102.518 E.00549
G1 X87.96 Y102.678 E.0061
G1 X87.614 Y102.795 E.00609
G1 X87.096 Y102.884 E.00877
G1 X86.743 Y102.896 E.0059
G1 X86.321 Y102.855 E.00706
G1 X85.997 Y102.78 E.00554
G1 X85.549 Y102.61 E.008
G1 X85.192 Y102.412 E.0068
G1 X84.77 Y102.078 E.00897
G1 X84.445 Y101.716 E.00812
G1 X84.249 Y101.419 E.00593
G1 X84.088 Y101.108 E.00583
G1 X83.943 Y100.708 E.0071
G1 X83.855 Y100.257 E.00767
M73 P78 R5
G1 X83.834 Y99.891 E.00611
G1 X83.87 Y99.433 E.00767
G1 X84.009 Y98.891 E.00933
G1 X84.168 Y98.526 E.00663
G1 X84.392 Y98.162 E.00714
; LINE_WIDTH: 0.373717
G1 X84.622 Y97.871 E.00644
G1 X84.995 Y97.5 E.00913
; LINE_WIDTH: 0.406708
G1 X85.016 Y97.481 E.00054
; LINE_WIDTH: 0.449151
G1 X85.26 Y97.274 E.00675
G1 X85.284 Y97.279 E.00051
; LINE_WIDTH: 0.435002
G1 X85.307 Y97.284 E.00049
; LINE_WIDTH: 0.396751
G1 X85.583 Y97.351 E.00525
; WIPE_START
G1 X85.307 Y97.284 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X80.307 Y96.238 Z4.56 F18000
G1 Z4.16
G1 E.4 F1800
; LINE_WIDTH: 0.095099
G1 F1500
M204 S6000
G1 X80.176 Y96.2 E.00047
; LINE_WIDTH: 0.133998
G1 X80.043 Y96.126 E.00082
; LINE_WIDTH: 0.154539
G1 X79.887 Y95.999 E.00129
G1 X79.681 Y95.682 E.00243
M204 S10000
G1 X79.695 Y95.628 F18000
; LINE_WIDTH: 0.092037
G1 F1500
M204 S6000
G1 X79.835 Y96.037 E.00143
; WIPE_START
G1 X79.695 Y95.628 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X87.323 Y95.911 Z4.56 F18000
G1 X93.61 Y96.144 Z4.56
G1 Z4.16
G1 E.4 F1800
; LINE_WIDTH: 0.109726
G1 F1500
M204 S6000
G1 X93.837 Y96.009 E.0011
; WIPE_START
G1 X93.61 Y96.144 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X96.662 Y89.148 Z4.56 F18000
G1 X97.332 Y87.615 Z4.56
G1 Z4.16
G1 E.4 F1800
; LINE_WIDTH: 0.196522
G1 F1500
M204 S6000
G1 X97.332 Y86.825 E.00672
; LINE_WIDTH: 0.217877
G1 X97.276 Y86.713 E.0012
; LINE_WIDTH: 0.260567
G1 X97.219 Y86.601 E.00147
; LINE_WIDTH: 0.260555
G1 X97.276 Y86.489 E.00147
; LINE_WIDTH: 0.19945
G1 X97.332 Y86.376 E.00109
G1 X97.332 Y85.587 E.00684
M204 S10000
G1 X97.107 Y86.376 F18000
; LINE_WIDTH: 0.345947
G1 F1500
M204 S6000
G1 X97.163 Y86.489 E.002
; LINE_WIDTH: 0.303257
G1 X97.219 Y86.601 E.00174
; LINE_WIDTH: 0.30325
G1 X97.163 Y86.713 E.00174
; LINE_WIDTH: 0.345945
G1 X97.107 Y86.825 E.002
M204 S10000
G1 X97.417 Y86.601 F18000
; LINE_WIDTH: 0.474782
G1 F1500
M204 S6000
G1 X94.418 Y86.601 E.06719
; WIPE_START
G1 X96.418 Y86.601 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X89.872 Y82.675 Z4.56 F18000
G1 X80.336 Y76.955 Z4.56
G1 Z4.16
G1 E.4 F1800
; LINE_WIDTH: 0.093044
G1 F1500
M204 S6000
G1 X80.235 Y76.983 E.00035
; LINE_WIDTH: 0.124327
G1 X80.063 Y77.06 E.00093
; LINE_WIDTH: 0.148227
G1 X79.956 Y77.141 E.00082
G1 X79.793 Y77.321 E.00149
G1 X79.739 Y77.434 E.00076
; LINE_WIDTH: 0.102607
G1 X79.688 Y77.598 E.00066
; WIPE_START
G1 X79.739 Y77.434 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X86.612 Y80.752 Z4.56 F18000
G1 X99.337 Y86.895 Z4.56
G1 Z4.16
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X99.909 Y86.078 E.01961
G1 X100.633 Y86.585 E.01737
G1 X100.876 Y86.755 E.00584
G1 X100.304 Y87.572 E.01961
G1 F1739.816
G1 X100.279 Y87.607 E.00085
G1 F2536.476
G1 X99.952 Y87.378 E.00787
G1 X99.327 Y86.94 E.01501
; CHANGE_LAYER
; Z_HEIGHT: 4.28
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F2536.476
M204 S6000
G1 X99.909 Y86.078 E-.19766
G1 X100.633 Y86.585 E-.16783
G1 X100.695 Y86.629 E-.01451
; WIPE_END
G1 E-.02 F1800
; layer num/total_layer_count: 35/49
; update layer progress
M73 L35
M991 S0 P34 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z4.56 I.856 J-.865 P1  F18000
G1 X93.851 Y79.858 Z4.56
G1 Z4.28
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X93.851 Y77.128 E.05778
G1 X94.036 Y77.076 E.00407
G1 X94.117 Y77.207 E.00325
G1 X94.173 Y77.349 E.00324
G1 X94.202 Y77.49 E.00306
G1 X94.211 Y84.454 E.14739
G1 X93.851 Y84.454 E.00761
G1 X93.851 Y79.918 E.09601
; WIPE_START
M204 S6000
G1 X93.851 Y77.918 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X93.865 Y85.55 Z4.68 F18000
G1 X93.884 Y95.44 Z4.68
G1 Z4.28
G1 E.4 F1800
G1 F1500
M204 S500
G1 X93.942 Y95.378 E.00179
G1 X94.159 Y95.319 E.00476
G1 X94.187 Y95.518 E.00425
G1 X94.108 Y95.633 E.00296
G1 X93.858 Y95.743 E.00578
G1 X93.879 Y95.5 E.00517
; WIPE_START
M204 S6000
G1 X93.942 Y95.378 E-.04261
G1 X94.159 Y95.319 E-.0701
G1 X94.187 Y95.518 E-.0625
G1 X94.108 Y95.633 E-.0436
G1 X93.858 Y95.743 E-.0851
G1 X93.879 Y95.5 E-.07608
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X88.024 Y97.087 Z4.68 F18000
G1 Z4.28
G1 E.4 F1800
G1 F1500
M204 S500
G1 X87.436 Y96.915 E.01297
G1 X87.062 Y96.864 E.00799
G1 X86.723 Y96.858 E.00717
G1 X86.159 Y96.928 E.01204
G1 X85.597 Y97.11 E.01249
G1 X85.491 Y96.949 E.0041
G1 X85.842 Y96.544 E.01135
G1 X87.785 Y96.544 E.04111
G1 X88.126 Y96.924 E.01081
G1 X88.056 Y97.036 E.0028
; WIPE_START
M204 S6000
G1 X87.436 Y96.915 E-.12003
G1 X87.062 Y96.864 E-.07174
G1 X86.723 Y96.858 E-.06436
G1 X86.159 Y96.928 E-.10807
G1 X86.08 Y96.954 E-.0158
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X88.99 Y101.38 Z4.68 F18000
G1 Z4.28
G1 E.4 F1800
G1 F1500
M204 S500
G1 X88.903 Y101.505 E.00323
G1 X88.692 Y101.747 E.00679
G1 X88.341 Y102.045 E.00975
G1 X87.934 Y102.28 E.00995
G1 X87.5 Y102.435 E.00975
G1 X87.183 Y102.498 E.00683
G1 X86.861 Y102.522 E.00683
G1 X86.411 Y102.488 E.00955
G1 X86.097 Y102.416 E.00683
G1 X85.793 Y102.307 E.00683
G1 X85.387 Y102.089 E.00975
G1 X85.02 Y101.796 E.00995
G1 X84.717 Y101.449 E.00975
G1 X84.543 Y101.177 E.00683
G1 X84.403 Y100.886 E.00683
G1 X84.267 Y100.446 E.00975
G1 X84.211 Y99.979 E.00995
G1 X84.239 Y99.507 E.01002
G1 X84.363 Y99.025 E.01053
G1 X84.472 Y98.763 E.00601
G1 X84.628 Y98.482 E.0068
G1 X84.91 Y98.118 E.00975
G1 X85.252 Y97.809 E.00975
G1 X85.521 Y97.632 E.00683
G1 X85.81 Y97.487 E.00683
G1 X86.251 Y97.344 E.00982
G1 X86.745 Y97.282 E.01053
G1 X87.029 Y97.288 E.00601
G1 X87.347 Y97.331 E.0068
G1 X87.78 Y97.458 E.00955
G1 X88.073 Y97.593 E.00683
G1 X88.348 Y97.763 E.00683
G1 X88.692 Y98.055 E.00956
G1 X88.905 Y98.298 E.00683
G1 X89.086 Y98.565 E.00683
G1 X89.286 Y98.98 E.00975
G1 X89.411 Y99.433 E.00995
G1 X89.453 Y99.901 E.00995
G1 X89.411 Y100.369 E.00995
G1 X89.285 Y100.825 E.01002
G1 X89.065 Y101.271 E.01053
G1 X89.024 Y101.33 E.00151
M204 S250
G1 X88.653 Y101.147 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X88.58 Y101.253 E.00254
G1 X88.404 Y101.454 E.00525
G1 X88.104 Y101.709 E.00774
G1 X87.761 Y101.907 E.0078
G1 X87.391 Y102.04 E.00774
G1 X87.128 Y102.091 E.00526
G1 X86.861 Y102.111 E.00526
G1 X86.473 Y102.082 E.00767
G1 X86.212 Y102.023 E.00526
G1 X85.96 Y101.932 E.00526
G1 X85.614 Y101.746 E.00773
G1 X85.304 Y101.499 E.0078
G1 X85.045 Y101.203 E.00773
G1 X84.901 Y100.977 E.00526
G1 X84.785 Y100.736 E.00526
G1 X84.669 Y100.361 E.00774
G1 X84.622 Y99.967 E.0078
G1 X84.646 Y99.57 E.00782
G1 X84.752 Y99.155 E.00844
G1 X84.84 Y98.941 E.00454
G1 X84.97 Y98.708 E.00525
G1 X85.211 Y98.397 E.00773
G1 X85.503 Y98.134 E.00773
G1 X85.726 Y97.987 E.00526
G1 X85.966 Y97.867 E.00526
G1 X86.341 Y97.745 E.00775
G1 X86.766 Y97.692 E.00844
G1 X86.997 Y97.697 E.00454
G1 X87.262 Y97.733 E.00525
G1 X87.636 Y97.842 E.00767
G1 X87.879 Y97.954 E.00526
G1 X88.107 Y98.095 E.00526
G1 X88.404 Y98.347 E.00767
G1 X88.58 Y98.549 E.00526
G1 X88.731 Y98.77 E.00526
G1 X88.902 Y99.124 E.00773
G1 X89.007 Y99.506 E.0078
G1 X89.042 Y99.901 E.00779
G1 X89.007 Y100.296 E.0078
G1 X88.901 Y100.679 E.00782
G1 X88.711 Y101.063 E.00844
G1 X88.687 Y101.098 E.00082
; WIPE_START
M204 S6000
G1 X88.58 Y101.253 E-.0359
G1 X88.404 Y101.454 E-.05072
G1 X88.104 Y101.709 E-.07472
G1 X87.761 Y101.907 E-.0753
G1 X87.391 Y102.04 E-.07473
G1 X87.128 Y102.091 E-.05083
G1 X87.035 Y102.098 E-.0178
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X88.036 Y96.12 Z4.68 F18000
G1 Z4.28
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X93.399 Y96.12 E.11352
G1 X93.462 Y95.398 E.01533
G1 X93.512 Y95.246 E.00338
G1 X93.564 Y95.162 E.0021
G1 X93.737 Y95.004 E.00496
G1 X93.873 Y94.945 E.00314
G1 X94.256 Y94.865 E.00827
G1 X98.142 Y89.315 E.14341
G1 X98.438 Y89.522 E.00765
G1 X94.552 Y95.072 E.1434
G1 X94.61 Y95.479 E.0087
G1 X94.592 Y95.648 E.0036
G1 X94.491 Y95.846 E.00469
G1 X94.385 Y95.958 E.00327
G1 X94.079 Y96.109 E.00723
G1 X93.852 Y96.308 E.00638
G1 X93.723 Y96.387 E.00321
G1 X93.581 Y96.443 E.00322
G1 X93.441 Y96.472 E.00304
G1 X88.302 Y96.485 E.10876
G1 X89.417 Y97.725 E.03529
G1 X89.626 Y97.999 E.00729
G1 X89.837 Y98.353 E.00872
G1 X90.06 Y98.901 E.01254
G1 X90.186 Y99.48 E.01254
G1 X90.212 Y99.895 E.00879
G1 X90.159 Y100.497 E.01279
G1 X90.003 Y101.07 E.01257
G1 X89.842 Y101.437 E.00849
G1 X89.634 Y101.791 E.00869
G1 X89.261 Y102.251 E.01253
G1 X88.965 Y102.522 E.0085
G1 X88.642 Y102.755 E.00842
G1 X88.228 Y102.977 E.00994
G1 X87.733 Y103.159 E.01116
G1 X87.331 Y103.243 E.00869
G1 X86.932 Y103.279 E.00849
G1 X86.531 Y103.267 E.00849
G1 X85.948 Y103.164 E.01254
G1 X85.55 Y103.029 E.00889
G1 X85.024 Y102.757 E.01253
G1 X84.699 Y102.522 E.00849
G1 X84.403 Y102.251 E.00849
G1 X84.141 Y101.947 E.00849
G1 X83.918 Y101.613 E.0085
G1 X83.737 Y101.259 E.00841
G1 X83.58 Y100.816 E.00994
G1 X83.475 Y100.3 E.01116
G1 X83.452 Y99.89 E.00869
G1 X83.477 Y99.49 E.00849
G1 X83.549 Y99.095 E.00849
G1 X83.668 Y98.711 E.0085
G1 X83.833 Y98.34 E.0086
G1 X84.154 Y97.839 E.01259
G1 X85.335 Y96.482 E.03808
G1 X80.368 Y96.482 E.10513
G1 X80.039 Y96.43 E.00703
G1 X79.892 Y96.362 E.00343
G1 X79.76 Y96.269 E.00343
G1 X79.592 Y96.076 E.0054
G1 X79.479 Y95.803 E.00626
G1 X79.451 Y95.565 E.00508
G1 X79.451 Y77.628 E.37965
G1 X79.487 Y77.357 E.00578
G1 X79.592 Y77.125 E.00539
G1 X79.776 Y76.92 E.00582
G1 X79.891 Y76.841 E.00296
G1 X80.031 Y76.775 E.00328
G1 X80.281 Y76.723 E.00539
G1 X93.351 Y76.722 E.27665
G1 X93.537 Y76.747 E.00398
G1 X93.68 Y76.794 E.00317
G1 X93.856 Y76.889 E.00424
G1 X93.807 Y77.082 E.0042
G1 X80.78 Y77.082 E.27574
G1 X80.501 Y77.129 E.00599
G1 X80.215 Y77.279 E.00683
G1 X79.986 Y77.519 E.00703
G1 X79.849 Y77.804 E.00668
G1 X79.812 Y78.056 E.00539
G1 X79.812 Y95.137 E.36154
G1 X79.837 Y95.346 E.00446
G1 X79.943 Y95.614 E.0061
G1 X80.122 Y95.84 E.0061
G1 X80.32 Y95.987 E.00523
G1 X80.547 Y96.085 E.00522
G1 X80.787 Y96.12 E.00513
G1 X87.976 Y96.12 E.15217
; WIPE_START
M204 S6000
G1 X89.976 Y96.12 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X89.218 Y96.892 Z4.68 F18000
G1 Z4.28
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X89.732 Y97.464 E.01512
G1 X89.965 Y97.769 E.00756
G1 X90.197 Y98.159 E.00892
G1 X90.292 Y98.356 E.00431
G1 X90.452 Y98.78 E.00891
G1 X90.56 Y99.22 E.00891
G1 X90.593 Y99.437 E.00431
G1 X90.621 Y99.89 E.00894
G1 X90.61 Y100.179 E.00568
G1 X90.563 Y100.563 E.00761
G1 X90.519 Y100.778 E.00432
G1 X90.387 Y101.212 E.00891
G1 X90.207 Y101.624 E.00885
G1 X89.977 Y102.014 E.00891
G1 X89.85 Y102.192 E.0043
G1 X89.555 Y102.536 E.00891
G1 X89.224 Y102.84 E.00885
G1 X88.859 Y103.102 E.00883
G1 X88.402 Y103.348 E.01022
G1 X88.045 Y103.491 E.00755
G1 X87.836 Y103.555 E.00431
G1 X87.392 Y103.649 E.00892
G1 X86.944 Y103.689 E.00885
G1 X86.494 Y103.676 E.00885
G1 X86.046 Y103.608 E.00891
G1 X85.834 Y103.557 E.0043
G1 X85.402 Y103.411 E.00898
G1 X85.202 Y103.322 E.0043
G1 X84.805 Y103.103 E.00891
G1 X84.44 Y102.84 E.00885
G1 X84.108 Y102.536 E.00885
G1 X83.815 Y102.195 E.00885
G1 X83.564 Y101.821 E.00885
G1 X83.36 Y101.421 E.00882
G1 X83.186 Y100.932 E.01022
G1 X83.099 Y100.558 E.00755
G1 X83.067 Y100.341 E.00431
G1 X83.042 Y99.889 E.00891
G1 X83.07 Y99.44 E.00885
G1 X83.151 Y98.997 E.00885
G1 X83.284 Y98.567 E.00885
G1 X83.468 Y98.155 E.00888
G1 X83.612 Y97.904 E.00568
G1 X83.83 Y97.588 E.00755
G1 X84.436 Y96.891 E.01818
G1 X80.344 Y96.891 E.08049
G1 X80.028 Y96.854 E.00625
G1 X79.893 Y96.814 E.00277
G1 X79.687 Y96.717 E.00448
G1 X79.5 Y96.587 E.00448
G1 X79.396 Y96.488 E.00283
G1 X79.253 Y96.307 E.00454
G1 X79.182 Y96.185 E.00277
G1 X79.078 Y95.898 E.006
G1 X79.042 Y95.589 E.00613
G1 X79.042 Y77.61 E.35362
G1 X79.062 Y77.374 E.00466
G1 X79.095 Y77.234 E.00283
G1 X79.181 Y77.019 E.00454
G1 X79.253 Y76.895 E.00283
G1 X79.395 Y76.715 E.00451
G1 X79.519 Y76.6 E.00333
G1 X79.686 Y76.485 E.004
G1 X79.891 Y76.389 E.00443
G1 X80.111 Y76.33 E.00448
G1 X80.257 Y76.313 E.00289
G1 X93.379 Y76.313 E.2581
G1 X93.63 Y76.347 E.00499
G1 X93.842 Y76.417 E.0044
G1 X94.04 Y76.524 E.00442
G1 X94.216 Y76.663 E.00442
G1 X94.366 Y76.831 E.00442
G1 X94.484 Y77.022 E.00442
G1 X94.567 Y77.231 E.00442
G1 X94.612 Y77.448 E.00436
G1 X94.622 Y86.255 E.17322
G1 X97.042 Y86.255 E.04759
G1 X97.042 Y85.388 E.01706
G1 X97.232 Y85.198 E.00529
G1 X97.502 Y85.468 E.00751
G1 X97.502 Y87.734 E.04457
G1 X97.232 Y88.004 E.00751
G1 X97.042 Y87.814 E.00529
M73 P79 R5
G1 X97.042 Y86.947 E.01706
G1 X94.622 Y86.947 E.0476
G1 X94.622 Y88.791 E.03628
G1 X93.442 Y88.791 E.02321
G1 X93.442 Y77.491 E.22226
G1 X80.814 Y77.491 E.24837
G1 X80.633 Y77.521 E.00361
G1 X80.465 Y77.61 E.00375
G1 X80.326 Y77.754 E.00393
G1 X80.245 Y77.924 E.0037
G1 X80.222 Y78.086 E.00321
G1 X80.222 Y95.113 E.33491
G1 X80.237 Y95.245 E.00261
G1 X80.301 Y95.407 E.00343
G1 X80.409 Y95.544 E.00343
G1 X80.526 Y95.63 E.00286
G1 X80.659 Y95.688 E.00285
G1 X80.816 Y95.711 E.00312
G1 X93.024 Y95.711 E.24012
G1 X93.057 Y95.329 E.00755
G1 X93.097 Y95.178 E.00306
G1 X93.236 Y94.913 E.00589
G1 X93.383 Y94.755 E.00425
G1 X93.534 Y94.646 E.00365
G1 X93.749 Y94.553 E.00461
G1 X94.014 Y94.498 E.00532
G1 X98.017 Y88.78 E.13729
G1 F1739.897
G1 X98.042 Y88.745 E.00085
G1 F2536.476
G1 X98.37 Y88.975 E.00787
G1 X98.681 Y89.192 E.00747
G1 X99.008 Y89.422 E.00787
G1 F1739.85
G1 X98.984 Y89.457 E.00085
G1 F1500
G1 X94.98 Y95.175 E.13728
G1 X95.02 Y95.451 E.0055
G1 X94.992 Y95.741 E.00572
G1 X94.96 Y95.841 E.00207
G1 X94.825 Y96.09 E.00557
G1 X94.65 Y96.273 E.00497
G1 X94.508 Y96.368 E.00335
G1 X94.301 Y96.459 E.00445
G1 X94.096 Y96.639 E.00538
G1 X93.906 Y96.755 E.00438
G1 X93.698 Y96.837 E.00438
G1 X93.483 Y96.881 E.00433
G1 X89.278 Y96.892 E.0827
; WIPE_START
M204 S6000
G1 X89.732 Y97.464 E-.13875
G1 X89.965 Y97.769 E-.07299
G1 X90.197 Y98.159 E-.08615
G1 X90.292 Y98.356 E-.04162
G1 X90.367 Y98.556 E-.04049
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




G1 X88.95 Y97.775
G1 Z4.28
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.360317
G1 F1500
M204 S6000
G1 X89.209 Y98.075 E.00661
G1 X89.495 Y98.53 E.00897
G1 X89.641 Y98.862 E.00605
G1 X89.776 Y99.352 E.00848
G1 X89.833 Y99.899 E.00918
G1 X89.819 Y100.113 E.00357
G1 X89.748 Y100.587 E.00801
G1 X89.632 Y100.975 E.00675
G1 X89.393 Y101.451 E.0089
G1 X89.208 Y101.73 E.00559
G1 X88.967 Y102.007 E.00614
G1 X88.545 Y102.361 E.00918
G1 X88.106 Y102.615 E.00848
G1 X87.786 Y102.74 E.00572
G1 X87.273 Y102.867 E.00883
G1 X86.849 Y102.899 E.00709
G1 X86.368 Y102.859 E.00806
G1 X86.051 Y102.796 E.00539
G1 X85.629 Y102.646 E.00748
G1 X85.192 Y102.412 E.00827
G1 X84.77 Y102.078 E.00898
G1 X84.445 Y101.716 E.00812
G1 X84.218 Y101.37 E.00691
G1 X84.057 Y101.035 E.00619
G1 X83.895 Y100.51 E.00917
G1 X83.837 Y100.005 E.00848
G1 X83.856 Y99.536 E.00783
G1 X83.924 Y99.187 E.00594
G1 X84.025 Y98.846 E.00594
G1 X84.136 Y98.589 E.00466
G1 X84.28 Y98.325 E.00502
G1 X84.624 Y97.872 E.00949
G1 X84.818 Y97.673 E.00464
; LINE_WIDTH: 0.400588
G1 X84.992 Y97.496 E.00464
; LINE_WIDTH: 0.438362
G1 X85.199 Y97.319 E.00562
; LINE_WIDTH: 0.477085
G1 X85.379 Y97.165 E.00534
; WIPE_START
G1 X85.199 Y97.319 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X88.241 Y97.14 Z4.68 F18000
G1 Z4.28
G1 E.4 F1800
; LINE_WIDTH: 0.480746
G1 F1500
M204 S6000
G1 X88.409 Y97.277 E.00491
; LINE_WIDTH: 0.450594
G1 X88.577 Y97.414 E.00459
; LINE_WIDTH: 0.413879
G1 X88.777 Y97.606 E.00537
; LINE_WIDTH: 0.378517
G1 X88.95 Y97.775 E.00426
; WIPE_START
G1 X88.777 Y97.606 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X93.61 Y96.144 Z4.68 F18000
G1 Z4.28
G1 E.4 F1800
; LINE_WIDTH: 0.109722
G1 F1500
M204 S6000
G1 X93.837 Y96.009 E.0011
; WIPE_START
G1 X93.61 Y96.144 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X93.87 Y88.516 Z4.68 F18000
G1 X93.876 Y88.353 Z4.68
G1 Z4.28
G1 E.4 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.391245
G1 F1500
M204 S6000
G1 X94.241 Y88.353 E.00667
G1 X94.24 Y84.849 E.06389
G1 X93.875 Y84.849 E.00666
G1 X93.876 Y88.293 E.0628
; WIPE_START
G1 X93.875 Y86.293 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X95.486 Y86.601 Z4.68 F18000
G1 Z4.28
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.307822
G1 F1500
M204 S6000
G1 X96.217 Y86.601 E.01028
; WIPE_START
G1 X95.486 Y86.601 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X89.049 Y82.501 Z4.68 F18000
G1 X80.328 Y76.946 Z4.68
G1 Z4.28
G1 E.4 F1800
; LINE_WIDTH: 0.124076
G1 F1500
M204 S6000
G1 X80.047 Y77.07 E.00151
; LINE_WIDTH: 0.149213
G1 X79.955 Y77.142 E.00072
G1 X79.795 Y77.322 E.00149
G1 X79.737 Y77.434 E.00077
; LINE_WIDTH: 0.100828
G1 X79.689 Y77.596 E.00063
; WIPE_START
G1 X79.737 Y77.434 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X79.72 Y85.066 Z4.68 F18000
G1 X79.696 Y95.628 Z4.68
G1 Z4.28
G1 E.4 F1800
; LINE_WIDTH: 0.0905795
G1 F1500
M204 S6000
G1 X79.722 Y95.735 E.00036
; LINE_WIDTH: 0.117045
G1 X79.766 Y95.818 E.00043
; LINE_WIDTH: 0.145151
G1 X79.806 Y95.89 E.00049
; LINE_WIDTH: 0.153338
G1 X79.934 Y96.045 E.00128
G1 X80.256 Y96.253 E.00244
M204 S10000
G1 X80.307 Y96.238 F18000
; LINE_WIDTH: 0.0987819
G1 F1500
M204 S6000
G1 X79.9 Y96.101 E.00156
; WIPE_START
G1 X80.307 Y96.238 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X87.192 Y92.945 Z4.68 F18000
G1 X99.834 Y86.898 Z4.68
G1 Z4.28
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X100.01 Y86.648 E.00647
G1 X100.306 Y86.855 E.00765
G1 X100.131 Y87.106 E.00647
G1 X99.884 Y86.933 E.00638
M204 S250
G1 X99.289 Y86.964 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X99.909 Y86.078 E.02127
G1 X100.659 Y86.603 E.018
G1 X100.876 Y86.755 E.00521
G1 X100.256 Y87.641 E.02127
G1 F1739.689
G1 X100.231 Y87.676 E.00085
G1 F2536.476
G1 X99.903 Y87.446 E.00787
G1 X99.278 Y87.009 E.01501
; CHANGE_LAYER
; Z_HEIGHT: 4.4
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F2536.476
M204 S6000
G1 X99.909 Y86.078 E-.21362
G1 X100.627 Y86.58 E-.16638
; WIPE_END
G1 E-.02 F1800
; layer num/total_layer_count: 36/49
; update layer progress
M73 L36
M991 S0 P35 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z4.68 I.364 J-1.161 P1  F18000
G1 X93.851 Y84.455 Z4.68
G1 Z4.4
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X93.851 Y77.128 E.15507
G1 X94.036 Y77.076 E.00407
G1 X94.117 Y77.207 E.00325
G1 X94.173 Y77.349 E.00324
G1 X94.202 Y77.49 E.00306
G1 X94.212 Y88.382 E.23052
G1 X93.851 Y88.382 E.00764
G1 X93.851 Y84.515 E.08185
; WIPE_START
M204 S6000
G1 X93.851 Y82.515 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X93.874 Y90.147 Z4.8 F18000
G1 X93.89 Y95.434 Z4.8
G1 Z4.4
G1 E.4 F1800
G1 F1500
M204 S500
G1 X93.952 Y95.367 E.00191
G1 X94.159 Y95.318 E.0045
G1 X94.188 Y95.516 E.00425
G1 X94.108 Y95.633 E.00299
G1 X93.863 Y95.741 E.00567
G1 X93.885 Y95.493 E.00526
; WIPE_START
M204 S6000
G1 X93.952 Y95.367 E-.04467
G1 X94.159 Y95.318 E-.06654
G1 X94.188 Y95.516 E-.06285
G1 X94.108 Y95.633 E-.04423
G1 X93.863 Y95.741 E-.0839
G1 X93.885 Y95.493 E-.07781
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X88.023 Y97.087 Z4.8 F18000
G1 Z4.4
G1 E.4 F1800
G1 F1500
M204 S500
G1 X87.436 Y96.915 E.01294
G1 X87.062 Y96.864 E.00799
G1 X86.72 Y96.858 E.00723
G1 X86.158 Y96.928 E.01198
G1 X85.597 Y97.11 E.01248
G1 X85.491 Y96.949 E.0041
G1 X85.843 Y96.544 E.01135
G1 X87.784 Y96.544 E.04108
G1 X88.125 Y96.924 E.0108
G1 X88.055 Y97.036 E.0028
; WIPE_START
M204 S6000
G1 X87.436 Y96.915 E-.11974
G1 X87.062 Y96.864 E-.07175
G1 X86.72 Y96.858 E-.06493
G1 X86.158 Y96.928 E-.10756
G1 X86.078 Y96.954 E-.01601
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X88.972 Y101.41 Z4.8 F18000
G1 Z4.4
G1 E.4 F1800
G1 F1500
M204 S500
G1 X88.699 Y101.741 E.00908
G1 X88.341 Y102.045 E.00995
G1 X87.934 Y102.28 E.00995
G1 X87.5 Y102.435 E.00975
G1 X87.183 Y102.498 E.00683
G1 X86.858 Y102.522 E.0069
G1 X86.374 Y102.481 E.01028
G1 X86.095 Y102.416 E.00606
G1 X85.793 Y102.307 E.0068
G1 X85.387 Y102.089 E.00975
G1 X85.027 Y101.802 E.00975
G1 X84.808 Y101.565 E.00683
G1 X84.618 Y101.304 E.00683
G1 X84.406 Y100.895 E.00974
G1 X84.267 Y100.446 E.00995
G1 X84.211 Y99.976 E.01001
G1 X84.245 Y99.482 E.01048
G1 X84.306 Y99.202 E.00606
G1 X84.41 Y98.898 E.0068
G1 X84.622 Y98.489 E.00975
G1 X84.91 Y98.118 E.00995
G1 X85.252 Y97.809 E.00975
G1 X85.521 Y97.632 E.00683
G1 X85.81 Y97.487 E.00683
G1 X86.251 Y97.344 E.00981
G1 X86.742 Y97.282 E.01048
G1 X87.029 Y97.288 E.00607
G1 X87.347 Y97.331 E.0068
G1 X87.789 Y97.46 E.00975
G1 X88.202 Y97.666 E.00975
G1 X88.465 Y97.852 E.00683
G1 X88.705 Y98.068 E.00683
G1 X88.992 Y98.417 E.00955
G1 X89.157 Y98.693 E.0068
G1 X89.274 Y98.954 E.00606
G1 X89.411 Y99.43 E.01048
G1 X89.453 Y99.892 E.00982
G1 X89.433 Y100.212 E.0068
G1 X89.384 Y100.494 E.00606
G1 X89.228 Y100.964 E.01048
G1 X89.007 Y101.361 E.00962
M204 S250
G1 X88.656 Y101.15 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
M73 P79 R4
G1 F1500
M204 S500
G1 X88.407 Y101.452 E.00771
G1 X88.104 Y101.709 E.0078
G1 X87.761 Y101.907 E.0078
G1 X87.391 Y102.04 E.00774
G1 X87.128 Y102.091 E.00526
G1 X86.86 Y102.111 E.00528
G1 X86.439 Y102.075 E.00833
G1 X86.211 Y102.022 E.00459
G1 X85.96 Y101.932 E.00525
G1 X85.614 Y101.746 E.00773
G1 X85.306 Y101.501 E.00773
G1 X85.124 Y101.305 E.00526
G1 X84.967 Y101.088 E.00526
G1 X84.786 Y100.739 E.00773
G1 X84.669 Y100.361 E.0078
G1 X84.622 Y99.966 E.00782
G1 X84.651 Y99.54 E.00839
G1 X84.701 Y99.312 E.00459
G1 X84.787 Y99.06 E.00526
G1 X84.969 Y98.711 E.00773
G1 X85.211 Y98.397 E.0078
G1 X85.503 Y98.134 E.00773
G1 X85.726 Y97.987 E.00526
G1 X85.966 Y97.867 E.00526
G1 X86.341 Y97.745 E.00775
G1 X86.764 Y97.692 E.00839
G1 X86.997 Y97.697 E.00459
G1 X87.262 Y97.733 E.00525
G1 X87.639 Y97.843 E.00773
G1 X87.991 Y98.019 E.00774
G1 X88.21 Y98.173 E.00526
G1 X88.409 Y98.352 E.00526
G1 X88.656 Y98.653 E.00767
G1 X88.793 Y98.882 E.00526
G1 X88.889 Y99.095 E.00459
G1 X89.007 Y99.505 E.00839
G1 X89.042 Y99.898 E.00775
G1 X89.026 Y100.164 E.00525
G1 X88.986 Y100.394 E.00459
G1 X88.852 Y100.799 E.00839
G1 X88.685 Y101.098 E.00672
; WIPE_START
M204 S6000
G1 X88.407 Y101.452 E-.08573
G1 X88.104 Y101.709 E-.0753
G1 X87.761 Y101.907 E-.0753
G1 X87.391 Y102.04 E-.07473
G1 X87.128 Y102.091 E-.05083
G1 X87.033 Y102.098 E-.01811
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X88.034 Y96.12 Z4.8 F18000
G1 Z4.4
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X93.416 Y96.12 E.11391
G1 X93.455 Y95.443 E.01436
M73 P80 R4
G1 X93.477 Y95.335 E.00232
G1 X93.564 Y95.162 E.00409
G1 X93.656 Y95.063 E.00288
G1 X93.825 Y94.962 E.00416
G1 X94.262 Y94.857 E.00952
G1 X98.191 Y89.246 E.14497
G1 X98.487 Y89.454 E.00765
G1 X94.551 Y95.074 E.14523
G1 X94.609 Y95.465 E.00836
G1 X94.592 Y95.649 E.00391
G1 X94.491 Y95.847 E.00471
G1 X94.385 Y95.958 E.00324
G1 X94.079 Y96.11 E.00724
G1 X93.852 Y96.308 E.00638
G1 X93.723 Y96.387 E.00321
G1 X93.582 Y96.443 E.00321
G1 X93.441 Y96.472 E.00304
G1 X88.301 Y96.485 E.10879
G1 X89.414 Y97.722 E.03521
G1 X89.73 Y98.162 E.01146
G1 X89.919 Y98.526 E.00869
G1 X90.06 Y98.901 E.00849
G1 X90.186 Y99.48 E.01254
G1 X90.211 Y99.89 E.00869
G1 X90.188 Y100.296 E.0086
G1 X90.067 Y100.878 E.01259
G1 X89.926 Y101.261 E.00863
G1 X89.818 Y101.482 E.00522
G1 X89.637 Y101.787 E.0075
G1 X89.49 Y101.987 E.00525
G1 X89.124 Y102.385 E.01146
G1 X88.805 Y102.644 E.00869
G1 X88.466 Y102.859 E.0085
G1 X88.104 Y103.032 E.00849
G1 X87.724 Y103.161 E.00849
G1 X87.331 Y103.243 E.0085
G1 X86.932 Y103.279 E.00849
G1 X86.531 Y103.267 E.00849
G1 X85.948 Y103.164 E.01253
G1 X85.559 Y103.032 E.00869
G1 X85.2 Y102.86 E.00842
G1 X84.81 Y102.607 E.00985
G1 X84.409 Y102.258 E.01125
G1 X84.141 Y101.947 E.00869
G1 X83.918 Y101.613 E.00849
G1 X83.737 Y101.259 E.00842
G1 X83.581 Y100.821 E.00985
G1 X83.475 Y100.3 E.01125
G1 X83.452 Y99.89 E.00869
G1 X83.477 Y99.49 E.00849
G1 X83.549 Y99.095 E.00849
G1 X83.668 Y98.711 E.00849
G1 X83.831 Y98.345 E.00849
G1 X84.149 Y97.845 E.01253
G1 X85.335 Y96.482 E.03825
G1 X80.368 Y96.482 E.10513
G1 X80.12 Y96.453 E.00527
G1 X79.975 Y96.405 E.00324
G1 X79.76 Y96.269 E.00539
G1 X79.632 Y96.133 E.00394
G1 X79.551 Y96.003 E.00324
G1 X79.479 Y95.803 E.0045
G1 X79.451 Y95.565 E.00508
G1 X79.451 Y77.628 E.37965
G1 X79.487 Y77.357 E.00578
G1 X79.592 Y77.125 E.00539
G1 X79.693 Y76.998 E.00343
G1 X79.807 Y76.896 E.00324
G1 X80.028 Y76.776 E.00533
G1 X80.288 Y76.723 E.00561
G1 X93.353 Y76.722 E.27653
G1 X93.537 Y76.747 E.00394
G1 X93.68 Y76.794 E.00318
G1 X93.856 Y76.889 E.00424
G1 X93.807 Y77.082 E.0042
G1 X80.778 Y77.082 E.27579
G1 X80.489 Y77.132 E.0062
G1 X80.211 Y77.282 E.00668
G1 X79.979 Y77.529 E.00717
G1 X79.849 Y77.807 E.00649
G1 X79.812 Y78.056 E.00533
G1 X79.812 Y95.137 E.36153
G1 X79.837 Y95.346 E.00446
G1 X79.943 Y95.614 E.0061
G1 X80.122 Y95.84 E.0061
G1 X80.32 Y95.987 E.00523
G1 X80.547 Y96.085 E.00522
G1 X80.787 Y96.12 E.00513
G1 X87.974 Y96.12 E.15213
; WIPE_START
M204 S6000
G1 X89.974 Y96.12 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X89.218 Y96.892 Z4.8 F18000
G1 Z4.4
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X89.729 Y97.46 E.01504
G1 X89.967 Y97.772 E.0077
G1 X90.085 Y97.957 E.00432
G1 X90.293 Y98.359 E.00891
G1 X90.452 Y98.78 E.00885
G1 X90.56 Y99.22 E.00891
G1 X90.593 Y99.437 E.00431
G1 X90.621 Y99.889 E.00891
G1 X90.596 Y100.34 E.00889
G1 X90.551 Y100.62 E.00558
G1 X90.459 Y100.998 E.00765
G1 X90.303 Y101.422 E.00889
G1 X90.178 Y101.677 E.00559
G1 X89.978 Y102.013 E.00768
G1 X89.81 Y102.242 E.0056
G1 X89.396 Y102.691 E.01201
G1 X89.045 Y102.977 E.00891
G1 X88.665 Y103.218 E.00885
G1 X88.259 Y103.412 E.00885
G1 X87.833 Y103.556 E.00885
G1 X87.392 Y103.649 E.00885
G1 X86.944 Y103.689 E.00884
G1 X86.494 Y103.676 E.00885
G1 X86.046 Y103.608 E.00891
G1 X85.834 Y103.557 E.0043
G1 X85.405 Y103.412 E.00891
G1 X85 Y103.218 E.00883
G1 X84.568 Y102.938 E.01013
G1 X84.11 Y102.538 E.01195
G1 X83.815 Y102.195 E.00891
G1 X83.565 Y101.821 E.00885
G1 X83.36 Y101.421 E.00883
G1 X83.188 Y100.936 E.01013
G1 X83.099 Y100.558 E.00765
G1 X83.067 Y100.341 E.00431
G1 X83.042 Y99.889 E.00891
G1 X83.07 Y99.44 E.00885
G1 X83.151 Y98.997 E.00885
G1 X83.284 Y98.567 E.00885
G1 X83.467 Y98.156 E.00885
G1 X83.7 Y97.767 E.00891
G1 X83.828 Y97.59 E.0043
G1 X84.436 Y96.891 E.01823
G1 X80.344 Y96.891 E.08049
G1 X80.031 Y96.854 E.00619
G1 X79.818 Y96.784 E.00442
G1 X79.69 Y96.719 E.00283
G1 X79.501 Y96.587 E.00454
G1 X79.299 Y96.373 E.00577
G1 X79.181 Y96.182 E.00442
G1 X79.078 Y95.898 E.00595
G1 X79.042 Y95.589 E.00613
G1 X79.042 Y77.61 E.35362
G1 X79.062 Y77.374 E.00466
G1 X79.095 Y77.234 E.00283
G1 X79.181 Y77.02 E.00454
G1 X79.253 Y76.895 E.00283
G1 X79.394 Y76.716 E.00448
G1 X79.562 Y76.567 E.00442
G1 X79.756 Y76.447 E.00448
G1 X80.053 Y76.342 E.00621
G1 X80.259 Y76.313 E.00409
G1 X93.38 Y76.313 E.25809
G1 X93.63 Y76.347 E.00495
G1 X93.842 Y76.417 E.0044
G1 X94.04 Y76.524 E.00442
G1 X94.216 Y76.663 E.00442
G1 X94.366 Y76.831 E.00442
G1 X94.484 Y77.022 E.00442
G1 X94.567 Y77.231 E.00442
G1 X94.612 Y77.448 E.00436
G1 X94.621 Y88.791 E.2231
G1 X93.442 Y88.791 E.02321
G1 X93.442 Y77.491 E.22226
G1 X80.813 Y77.491 E.24839
G1 X80.625 Y77.524 E.00376
G1 X80.463 Y77.611 E.00361
G1 X80.322 Y77.761 E.00406
G1 X80.245 Y77.925 E.00356
G1 X80.222 Y78.086 E.00319
G1 X80.222 Y95.113 E.33491
G1 X80.237 Y95.245 E.00261
G1 X80.301 Y95.407 E.00343
G1 X80.41 Y95.544 E.00343
G1 X80.526 Y95.63 E.00285
G1 X80.659 Y95.688 E.00285
G1 X80.816 Y95.711 E.00312
G1 X93.03 Y95.711 E.24023
G1 X93.048 Y95.389 E.00634
G1 X93.084 Y95.218 E.00345
G1 X93.147 Y95.058 E.00338
G1 X93.236 Y94.913 E.00334
G1 X93.384 Y94.754 E.00427
G1 X93.536 Y94.645 E.00369
G1 X93.689 Y94.573 E.00331
G1 X94.016 Y94.495 E.00662
G1 X98.065 Y88.711 E.13887
G1 F1739.85
G1 X98.09 Y88.676 E.00085
G1 F2536.476
G1 X98.418 Y88.906 E.00787
G1 X98.729 Y89.124 E.00747
G1 X99.057 Y89.353 E.00787
G1 F1739.816
G1 X99.032 Y89.388 E.00085
G1 F1500
G1 X94.98 Y95.175 E.13895
G1 X95.018 Y95.434 E.00514
G1 X94.992 Y95.741 E.00607
G1 X94.96 Y95.841 E.00206
G1 X94.824 Y96.091 E.0056
G1 X94.65 Y96.273 E.00495
G1 X94.508 Y96.368 E.00335
G1 X94.301 Y96.459 E.00445
G1 X94.096 Y96.639 E.00538
G1 X93.906 Y96.755 E.00438
G1 X93.698 Y96.837 E.00438
G1 X93.483 Y96.881 E.00433
G1 X89.278 Y96.892 E.08271
; WIPE_START
M204 S6000
G1 X89.729 Y97.46 E-.13793
G1 X89.967 Y97.772 E-.07443
G1 X90.085 Y97.957 E-.0417
G1 X90.293 Y98.359 E-.08608
G1 X90.367 Y98.555 E-.03986
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




G1 X88.722 Y97.548
G1 Z4.4
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.36084
G1 F1500
M204 S6000
G1 X88.988 Y97.815 E.0063
G1 X89.305 Y98.211 E.00848
G1 X89.57 Y98.681 E.00902
G1 X89.691 Y99.013 E.00591
G1 X89.781 Y99.376 E.00625
G1 X89.832 Y99.891 E.00865
G1 X89.811 Y100.251 E.00603
G1 X89.698 Y100.768 E.00885
G1 X89.578 Y101.112 E.00608
G1 X89.319 Y101.579 E.00893
G1 X88.981 Y101.995 E.00896
G1 X88.582 Y102.337 E.00879
G1 X88.105 Y102.615 E.00922
G1 X87.624 Y102.794 E.00858
G1 X87.275 Y102.867 E.00596
G1 X86.921 Y102.898 E.00595
G1 X86.567 Y102.883 E.00591
G1 X86.049 Y102.796 E.00879
G1 X85.651 Y102.657 E.00705
G1 X85.193 Y102.41 E.0087
G1 X84.798 Y102.106 E.00833
G1 X84.511 Y101.796 E.00706
G1 X84.29 Y101.492 E.00629
G1 X84.063 Y101.052 E.00828
G1 X83.895 Y100.51 E.00948
G1 X83.837 Y100.001 E.00857
G1 X83.858 Y99.536 E.00777
G1 X83.92 Y99.186 E.00595
G1 X84.059 Y98.761 E.00746
G1 X84.297 Y98.299 E.0087
G1 X84.624 Y97.872 E.00899
G1 X84.818 Y97.673 E.00464
; LINE_WIDTH: 0.400602
G1 X84.992 Y97.496 E.00464
; LINE_WIDTH: 0.438388
G1 X85.199 Y97.319 E.00562
; LINE_WIDTH: 0.477104
G1 X85.379 Y97.165 E.00534
; WIPE_START
G1 X85.199 Y97.319 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X88.095 Y97.37 Z4.8 F18000
G1 Z4.4
G1 E.4 F1800
; LINE_WIDTH: 0.472507
G1 F1500
M204 S6000
G1 X88.423 Y97.282 E.00756
G1 X88.574 Y97.415 E.00449
; LINE_WIDTH: 0.420825
G1 X88.706 Y97.533 E.00348
; LINE_WIDTH: 0.399171
G1 X88.722 Y97.548 E.00042
; WIPE_START
G1 X88.706 Y97.533 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X93.628 Y96.132 Z4.8 F18000
G1 Z4.4
G1 E.4 F1800
; LINE_WIDTH: 0.0966507
G1 F1500
M204 S6000
G1 X93.837 Y96.009 E.00086
; WIPE_START
G1 X93.628 Y96.132 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X85.996 Y96.193 Z4.8 F18000
G1 X80.307 Y96.238 Z4.8
G1 Z4.4
G1 E.4 F1800
; LINE_WIDTH: 0.0951425
G1 F1500
M204 S6000
G1 X80.176 Y96.201 E.00047
; LINE_WIDTH: 0.150377
G1 X79.922 Y96.033 E.00189
G1 X79.801 Y95.88 E.00122
; LINE_WIDTH: 0.130009
G1 X79.725 Y95.745 E.00081
; LINE_WIDTH: 0.0916602
G1 X79.696 Y95.628 E.00039
; WIPE_START
G1 X79.725 Y95.745 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X79.71 Y88.112 Z4.8 F18000
G1 X79.689 Y77.595 Z4.8
G1 Z4.4
G1 E.4 F1800
; LINE_WIDTH: 0.10517
G1 F1500
M204 S6000
G1 X79.756 Y77.387 E.00086
; LINE_WIDTH: 0.156468
G1 X79.902 Y77.194 E.00158
G1 X80.039 Y77.073 E.00119
; LINE_WIDTH: 0.128432
G1 X80.223 Y76.991 E.00103
; LINE_WIDTH: 0.0928335
G1 X80.326 Y76.954 E.00037
; WIPE_START
G1 X80.223 Y76.991 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X86.624 Y81.147 Z4.8 F18000
G1 X97.232 Y88.035 Z4.8
G1 Z4.4
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.376624
G1 F1500
M204 S500
G1 X97.06 Y87.863 E.00425
G1 X97.06 Y85.339 E.04418
G1 X97.232 Y85.167 E.00425
G1 X97.403 Y85.339 E.00425
G1 X97.403 Y87.863 E.04418
G1 X97.274 Y87.992 E.0032
; WIPE_START
M204 S6000
G1 X97.06 Y87.863 E-.04752
G1 X97.06 Y86.113 E-.33248
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X99.786 Y86.967 Z4.8 F18000
G1 Z4.4
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X100.01 Y86.648 E.00825
M73 P81 R4
G1 X100.306 Y86.855 E.00765
G1 X100.082 Y87.175 E.00825
G1 X99.835 Y87.002 E.00638
M204 S250
G1 X99.241 Y87.033 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X99.909 Y86.078 E.02292
G1 X100.685 Y86.621 E.01863
G1 X100.876 Y86.755 E.00458
G1 X100.208 Y87.709 E.02292
G1 F1739.816
G1 X100.183 Y87.745 E.00085
G1 F2536.476
G1 X99.855 Y87.515 E.00787
G1 X99.23 Y87.078 E.01501
; CHANGE_LAYER
; Z_HEIGHT: 4.52
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F2536.476
M204 S6000
G1 X99.909 Y86.078 E-.22959
G1 X100.558 Y86.532 E-.15042
; WIPE_END
G1 E-.02 F1800
; layer num/total_layer_count: 37/49
; update layer progress
M73 L37
M991 S0 P36 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z4.8 I.36 J-1.162 P1  F18000
G1 X93.851 Y84.452 Z4.8
G1 Z4.52
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X93.851 Y77.128 E.15502
G1 X94.036 Y77.076 E.00407
G1 X94.117 Y77.207 E.00325
G1 X94.173 Y77.349 E.00324
G1 X94.202 Y77.49 E.00306
G1 X94.212 Y88.382 E.23052
G1 X93.851 Y88.382 E.00764
G1 X93.851 Y84.512 E.08189
; WIPE_START
M204 S6000
G1 X93.851 Y82.512 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X93.871 Y90.145 Z4.92 F18000
G1 X93.885 Y95.457 Z4.92
G1 Z4.52
G1 E.4 F1800
G1 F1500
M204 S500
G1 X93.904 Y95.411 E.00105
G1 X93.967 Y95.364 E.00168
G1 X94.159 Y95.318 E.00416
G1 X94.189 Y95.52 E.00433
G1 X94.142 Y95.61 E.00214
G1 X93.863 Y95.741 E.00652
G1 X93.881 Y95.517 E.00476
; WIPE_START
M204 S6000
G1 X93.904 Y95.411 E-.03367
G1 X93.967 Y95.364 E-.02463
G1 X94.159 Y95.318 E-.0611
G1 X94.189 Y95.52 E-.06355
G1 X94.142 Y95.61 E-.03146
G1 X93.863 Y95.741 E-.09576
G1 X93.881 Y95.517 E-.06983
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X88.021 Y97.086 Z4.92 F18000
G1 Z4.52
G1 E.4 F1800
G1 F1500
M204 S500
G1 X87.436 Y96.915 E.0129
G1 X87.062 Y96.864 E.008
G1 X86.717 Y96.858 E.00729
G1 X86.158 Y96.928 E.01192
G1 X85.607 Y97.107 E.01228
G1 X85.5 Y96.945 E.00411
G1 X85.852 Y96.544 E.01129
G1 X87.782 Y96.544 E.04085
G1 X88.123 Y96.923 E.01079
G1 X88.053 Y97.035 E.0028
; WIPE_START
M204 S6000
G1 X87.436 Y96.915 E-.11942
G1 X87.062 Y96.864 E-.07177
G1 X86.717 Y96.858 E-.06545
G1 X86.158 Y96.928 E-.10701
G1 X86.077 Y96.955 E-.01635
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X88.972 Y101.409 Z4.92 F18000
G1 Z4.52
G1 E.4 F1800
G1 F1500
M204 S500
G1 X88.699 Y101.741 E.00908
G1 X88.341 Y102.045 E.00995
G1 X87.942 Y102.275 E.00975
G1 X87.641 Y102.393 E.00683
G1 X87.329 Y102.474 E.00683
G1 X86.868 Y102.523 E.00982
G1 X86.377 Y102.481 E.01043
G1 X86.096 Y102.416 E.00612
G1 X85.793 Y102.307 E.0068
G1 X85.387 Y102.089 E.00975
G1 X85.02 Y101.796 E.00995
G1 X84.711 Y101.442 E.00995
G1 X84.47 Y101.039 E.00995
G1 X84.308 Y100.607 E.00975
G1 X84.241 Y100.292 E.00683
G1 X84.212 Y99.979 E.00664
G1 X84.222 Y99.666 E.00663
G1 X84.27 Y99.347 E.00683
G1 X84.406 Y98.907 E.00975
G1 X84.622 Y98.489 E.00995
G1 X84.904 Y98.125 E.00975
G1 X85.136 Y97.903 E.0068
G1 X85.367 Y97.729 E.00612
G1 X85.798 Y97.491 E.01043
G1 X86.251 Y97.344 E.01008
G1 X86.74 Y97.282 E.01042
G1 X87.029 Y97.288 E.00612
G1 X87.347 Y97.331 E.0068
G1 X87.789 Y97.46 E.00975
G1 X88.201 Y97.666 E.00975
G1 X88.465 Y97.852 E.00683
G1 X88.705 Y98.068 E.00683
G1 X88.992 Y98.417 E.00955
G1 X89.157 Y98.694 E.00683
G1 X89.289 Y98.989 E.00683
G1 X89.411 Y99.433 E.00975
G1 X89.453 Y99.892 E.00975
G1 X89.433 Y100.212 E.0068
G1 X89.383 Y100.497 E.00612
G1 X89.228 Y100.965 E.01043
G1 X89.007 Y101.361 E.00961
M204 S250
G1 X88.656 Y101.15 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X88.407 Y101.452 E.00771
G1 X88.104 Y101.709 E.0078
G1 X87.764 Y101.905 E.00773
G1 X87.515 Y102.003 E.00527
G1 X87.256 Y102.07 E.00526
G1 X86.864 Y102.112 E.00776
G1 X86.441 Y102.076 E.00834
G1 X86.211 Y102.022 E.00464
G1 X85.96 Y101.932 E.00525
G1 X85.614 Y101.746 E.00774
G1 X85.304 Y101.499 E.0078
G1 X85.043 Y101.2 E.00779
G1 X84.84 Y100.86 E.00779
G1 X84.702 Y100.492 E.00774
G1 X84.646 Y100.23 E.00526
G1 X84.622 Y99.967 E.0052
G1 X84.63 Y99.703 E.0052
G1 X84.67 Y99.438 E.00526
G1 X84.786 Y99.062 E.00773
G1 X84.969 Y98.711 E.0078
G1 X85.209 Y98.4 E.00773
G1 X85.402 Y98.215 E.00525
G1 X85.59 Y98.073 E.00464
G1 X85.962 Y97.868 E.00834
G1 X86.341 Y97.745 E.00784
G1 X86.761 Y97.692 E.00834
G1 X86.997 Y97.697 E.00464
G1 X87.262 Y97.733 E.00525
G1 X87.639 Y97.843 E.00773
G1 X87.991 Y98.019 E.00773
G1 X88.21 Y98.173 E.00526
G1 X88.409 Y98.352 E.00526
G1 X88.656 Y98.653 E.00767
G1 X88.794 Y98.883 E.00526
G1 X88.902 Y99.127 E.00526
G1 X89.007 Y99.506 E.00774
G1 X89.042 Y99.898 E.00773
G1 X89.026 Y100.164 E.00525
G1 X88.985 Y100.397 E.00464
G1 X88.852 Y100.799 E.00834
G1 X88.685 Y101.098 E.00672
; WIPE_START
M204 S6000
G1 X88.407 Y101.452 E-.08576
G1 X88.104 Y101.709 E-.0753
G1 X87.764 Y101.905 E-.0747
G1 X87.515 Y102.003 E-.05086
G1 X87.256 Y102.07 E-.0508
G1 X87.033 Y102.094 E-.04258
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X88.032 Y96.12 Z4.92 F18000
G1 Z4.52
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X93.416 Y96.12 E.11395
G1 X93.455 Y95.443 E.01436
G1 X93.477 Y95.335 E.00232
G1 X93.567 Y95.156 E.00425
G1 X93.628 Y95.088 E.00194
G1 X93.824 Y94.962 E.00494
G1 X94.262 Y94.857 E.00952
G1 X98.239 Y89.177 E.14675
G1 X98.535 Y89.385 E.00765
G1 X94.551 Y95.074 E.147
G1 X94.609 Y95.466 E.00839
G1 X94.595 Y95.635 E.0036
G1 X94.504 Y95.834 E.00463
G1 X94.4 Y95.947 E.00324
G1 X94.31 Y96.008 E.00229
G1 X94.079 Y96.109 E.00536
G1 X93.852 Y96.308 E.00638
G1 X93.723 Y96.387 E.00321
G1 X93.581 Y96.443 E.00321
G1 X93.441 Y96.472 E.00304
G1 X88.3 Y96.485 E.10882
G1 X89.411 Y97.718 E.03514
G1 X89.631 Y98.007 E.00768
G1 X89.919 Y98.526 E.01256
G1 X90.06 Y98.901 E.00849
G1 X90.156 Y99.291 E.00849
G1 X90.212 Y99.886 E.01265
G1 X90.16 Y100.488 E.01278
G1 X90.006 Y101.061 E.01257
G1 X89.84 Y101.442 E.0088
G1 X89.523 Y101.946 E.01259
G1 X89.26 Y102.251 E.00852
G1 X88.958 Y102.528 E.00869
G1 X88.466 Y102.859 E.01254
G1 X88.104 Y103.032 E.00849
G1 X87.724 Y103.161 E.00849
G1 X87.332 Y103.243 E.00849
G1 X86.932 Y103.279 E.00849
G1 X86.531 Y103.267 E.00849
G1 X85.939 Y103.161 E.01273
G1 X85.375 Y102.951 E.01273
G1 X85.024 Y102.757 E.00849
G1 X84.698 Y102.522 E.00849
G1 X84.403 Y102.251 E.00849
G1 X84.141 Y101.947 E.00849
G1 X83.918 Y101.613 E.00849
G1 X83.737 Y101.259 E.00843
G1 X83.582 Y100.825 E.00975
G1 X83.475 Y100.3 E.01135
G1 X83.452 Y99.89 E.00869
G1 X83.477 Y99.49 E.00849
G1 X83.549 Y99.095 E.00849
G1 X83.668 Y98.712 E.00849
G1 X83.831 Y98.345 E.0085
G1 X84.04 Y97.996 E.0086
G1 X84.184 Y97.802 E.00512
G1 X85.342 Y96.482 E.03717
G1 X80.368 Y96.482 E.10529
G1 X80.129 Y96.454 E.00508
G1 X79.856 Y96.34 E.00626
G1 X79.729 Y96.24 E.00343
G1 X79.621 Y96.119 E.00344
G1 X79.481 Y95.821 E.00696
G1 X79.451 Y95.565 E.00546
G1 X79.451 Y77.628 E.37965
G1 X79.488 Y77.352 E.0059
G1 X79.597 Y77.12 E.00542
G1 X79.773 Y76.922 E.00561
G1 X79.891 Y76.841 E.00303
G1 X80.037 Y76.773 E.0034
G1 X80.288 Y76.723 E.00542
G1 X93.354 Y76.722 E.27656
G1 X93.537 Y76.747 E.00391
G1 X93.68 Y76.794 E.00318
G1 X93.856 Y76.889 E.00424
G1 X93.807 Y77.082 E.0042
G1 X80.778 Y77.082 E.27579
G1 X80.489 Y77.133 E.0062
G1 X80.219 Y77.278 E.00649
G1 X80.002 Y77.495 E.00649
G1 X79.85 Y77.797 E.00717
G1 X79.812 Y78.056 E.00553
G1 X79.812 Y95.14 E.36159
G1 X79.84 Y95.356 E.00462
G1 X79.941 Y95.607 E.00572
G1 X80.093 Y95.81 E.00537
G1 X80.311 Y95.984 E.0059
G1 X80.546 Y96.085 E.00542
G1 X80.787 Y96.12 E.00514
G1 X87.972 Y96.12 E.15209
; WIPE_START
M204 S6000
G1 X89.972 Y96.12 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X89.217 Y96.892 Z4.92 F18000
G1 Z4.52
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X89.726 Y97.457 E.01495
G1 X89.967 Y97.772 E.0078
G1 X90.085 Y97.957 E.00431
G1 X90.293 Y98.359 E.00891
G1 X90.452 Y98.78 E.00885
G1 X90.559 Y99.217 E.00885
G1 X90.614 Y99.667 E.00891
G1 X90.611 Y100.169 E.00989
G1 X90.564 Y100.56 E.00774
G1 X90.458 Y101.001 E.00892
G1 X90.389 Y101.209 E.00431
G1 X90.206 Y101.625 E.00895
G1 X90.069 Y101.869 E.00549
G1 X89.849 Y102.194 E.00773
G1 X89.555 Y102.536 E.00886
G1 X89.221 Y102.842 E.00891
G1 X89.047 Y102.975 E.00431
G1 X88.665 Y103.218 E.00891
G1 X88.259 Y103.412 E.00885
G1 X87.833 Y103.556 E.00885
G1 X87.392 Y103.649 E.00885
G1 X86.944 Y103.689 E.00885
G1 X86.494 Y103.676 E.00885
G1 X86.046 Y103.608 E.00891
G1 X85.831 Y103.556 E.00436
G1 X85.618 Y103.491 E.00437
G1 X85.199 Y103.321 E.00891
G1 X84.805 Y103.103 E.00885
G1 X84.44 Y102.84 E.00885
G1 X84.108 Y102.536 E.00885
G1 X83.815 Y102.195 E.00885
G1 X83.564 Y101.821 E.00885
G1 X83.36 Y101.421 E.00883
G1 X83.189 Y100.941 E.01004
G1 X83.067 Y100.341 E.01204
G1 X83.042 Y99.889 E.00891
G1 X83.07 Y99.44 E.00885
G1 X83.151 Y98.997 E.00885
G1 X83.284 Y98.567 E.00885
G1 X83.467 Y98.156 E.00885
G1 X83.699 Y97.768 E.00888
G1 X83.865 Y97.544 E.0055
G1 X84.439 Y96.891 E.01709
G1 X80.344 Y96.891 E.08054
G1 X80.034 Y96.855 E.00613
G1 X79.748 Y96.75 E.006
G1 X79.626 Y96.68 E.00277
G1 X79.447 Y96.539 E.00448
G1 X79.295 Y96.368 E.00449
G1 X79.216 Y96.248 E.00283
G1 X79.119 Y96.039 E.00454
G1 X79.079 Y95.904 E.00277
G1 X79.042 Y95.589 E.00625
G1 X79.042 Y77.61 E.35362
G1 X79.062 Y77.374 E.00466
G1 X79.096 Y77.232 E.00287
G1 X79.155 Y77.074 E.00332
G1 X79.254 Y76.893 E.00406
G1 X79.395 Y76.715 E.00447
G1 X79.517 Y76.602 E.00326
G1 X79.687 Y76.485 E.00406
G1 X79.893 Y76.389 E.00447
G1 X80.052 Y76.343 E.00326
G1 X80.259 Y76.313 E.00412
G1 X93.382 Y76.313 E.25812
G1 X93.63 Y76.347 E.00492
G1 X93.842 Y76.417 E.0044
G1 X94.04 Y76.524 E.00442
G1 X94.216 Y76.663 E.00442
G1 X94.366 Y76.831 E.00442
G1 X94.484 Y77.022 E.00442
G1 X94.567 Y77.231 E.00442
G1 X94.612 Y77.448 E.00436
G1 X94.621 Y88.791 E.2231
G1 X93.442 Y88.791 E.02321
G1 X93.442 Y77.491 E.22226
G1 X80.813 Y77.491 E.24839
G1 X80.625 Y77.524 E.00376
G1 X80.466 Y77.61 E.00355
G1 X80.338 Y77.737 E.00355
G1 X80.246 Y77.922 E.00406
G1 X80.222 Y78.086 E.00325
G1 X80.222 Y95.114 E.33493
G1 X80.239 Y95.252 E.00274
G1 X80.301 Y95.405 E.00323
G1 X80.389 Y95.523 E.0029
G1 X80.523 Y95.629 E.00337
G1 X80.659 Y95.688 E.00292
G1 X80.816 Y95.711 E.00313
G1 X93.03 Y95.711 E.24023
G1 X93.048 Y95.389 E.00634
G1 X93.084 Y95.218 E.00344
G1 X93.147 Y95.058 E.00339
G1 X93.238 Y94.911 E.00338
G1 X93.35 Y94.785 E.00332
G1 X93.538 Y94.644 E.00463
G1 X93.689 Y94.573 E.00326
G1 X94.016 Y94.495 E.00662
G1 X98.114 Y88.643 E.14052
G1 F1739.769
G1 X98.138 Y88.607 E.00085
G1 F2536.476
G1 X98.466 Y88.837 E.00787
G1 X98.777 Y89.055 E.00747
G1 X99.105 Y89.284 E.00787
G1 F1739.897
G1 X99.08 Y89.319 E.00085
G1 F1500
G1 X94.98 Y95.175 E.1406
G1 X95.019 Y95.435 E.00517
G1 X94.995 Y95.725 E.00572
G1 X94.959 Y95.845 E.00246
G1 X94.848 Y96.059 E.00475
G1 X94.655 Y96.269 E.00561
G1 X94.508 Y96.368 E.00348
G1 X94.301 Y96.459 E.00445
G1 X94.096 Y96.639 E.00538
G1 X93.906 Y96.755 E.00438
G1 X93.698 Y96.837 E.00438
G1 X93.483 Y96.881 E.00433
G1 X89.277 Y96.892 E.08272
; WIPE_START
M204 S6000
G1 X89.726 Y97.457 E-.13709
G1 X89.967 Y97.772 E-.07537
G1 X90.085 Y97.957 E-.04162
G1 X90.293 Y98.359 E-.08611
G1 X90.367 Y98.555 E-.03982
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




G1 X88.722 Y97.548
G1 Z4.52
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.361299
G1 F1500
M204 S6000
G1 X88.988 Y97.815 E.00631
G1 X89.305 Y98.211 E.00849
G1 X89.496 Y98.529 E.00621
G1 X89.693 Y99.015 E.00877
G1 X89.783 Y99.359 E.00596
G1 X89.829 Y99.898 E.00905
G1 X89.784 Y100.421 E.00878
G1 X89.695 Y100.777 E.00615
G1 X89.497 Y101.269 E.00888
G1 X89.299 Y101.601 E.00647
G1 X88.988 Y101.987 E.00831
G1 X88.715 Y102.23 E.00612
G1 X88.278 Y102.524 E.00881
G1 X87.96 Y102.678 E.00592
G1 X87.623 Y102.792 E.00596
G1 X87.408 Y102.842 E.0037
G1 X86.887 Y102.9 E.00878
G1 X86.33 Y102.856 E.00936
G1 X85.98 Y102.775 E.00602
G1 X85.628 Y102.647 E.00626
G1 X85.192 Y102.412 E.0083
G1 X84.77 Y102.078 E.009
G1 X84.445 Y101.716 E.00815
G1 X84.249 Y101.419 E.00596
G1 X84.088 Y101.107 E.00587
G1 X83.945 Y100.718 E.00694
G1 X83.867 Y100.338 E.0065
G1 X83.834 Y99.889 E.00754
G1 X83.856 Y99.536 E.00592
G1 X83.905 Y99.251 E.00484
G1 X84.051 Y98.777 E.0083
G1 X84.297 Y98.299 E.009
G1 X84.615 Y97.882 E.00879
G1 X84.874 Y97.611 E.00627
; LINE_WIDTH: 0.403824
G1 X85.005 Y97.488 E.0034
; LINE_WIDTH: 0.438113
G1 X85.122 Y97.379 E.00327
; LINE_WIDTH: 0.474911
G1 X85.389 Y97.163 E.00771
; WIPE_START
G1 X85.122 Y97.379 E-.38
; WIPE_END
M73 P82 R4
G1 E-.02 F1800
M204 S10000
G1 X88.093 Y97.37 Z4.92 F18000
G1 Z4.52
G1 E.4 F1800
; LINE_WIDTH: 0.473245
G1 F1500
M204 S6000
G1 X88.421 Y97.281 E.00759
G1 X88.573 Y97.415 E.00453
; LINE_WIDTH: 0.42051
G1 X88.706 Y97.533 E.00348
; LINE_WIDTH: 0.398923
G1 X88.722 Y97.548 E.00042
; WIPE_START
G1 X88.706 Y97.533 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X93.628 Y96.132 Z4.92 F18000
G1 Z4.52
G1 E.4 F1800
; LINE_WIDTH: 0.0966741
G1 F1500
M204 S6000
G1 X93.837 Y96.009 E.00086
; WIPE_START
G1 X93.628 Y96.132 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X85.996 Y96.193 Z4.92 F18000
G1 X80.307 Y96.238 Z4.92
G1 Z4.52
G1 E.4 F1800
; LINE_WIDTH: 0.0951407
G1 F1500
M204 S6000
G1 X80.176 Y96.2 E.00047
; LINE_WIDTH: 0.134035
G1 X80.043 Y96.126 E.00082
; LINE_WIDTH: 0.15368
G1 X79.887 Y95.998 E.00128
G1 X79.679 Y95.677 E.00244
M204 S10000
G1 X79.695 Y95.627 F18000
; LINE_WIDTH: 0.0950249
G1 F1500
M204 S6000
G1 X79.826 Y96.025 E.00145
; WIPE_START
G1 X79.695 Y95.627 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X79.692 Y87.995 Z4.92 F18000
G1 X79.688 Y77.598 Z4.92
G1 Z4.52
G1 E.4 F1800
; LINE_WIDTH: 0.0973834
G1 F1500
M204 S6000
G1 X79.721 Y77.482 E.00043
; LINE_WIDTH: 0.12569
G1 X79.772 Y77.358 E.00067
; LINE_WIDTH: 0.154856
G1 X79.906 Y77.188 E.00139
G1 X80.03 Y77.079 E.00106
; LINE_WIDTH: 0.130179
G1 X80.227 Y76.989 E.00113
; LINE_WIDTH: 0.0924308
G1 X80.326 Y76.954 E.00035
; WIPE_START
G1 X80.227 Y76.989 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X86.628 Y81.147 Z4.92 F18000
G1 X97.232 Y88.035 Z4.92
G1 Z4.52
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.376624
G1 F1500
M204 S500
G1 X97.18 Y87.983 E.00128
G1 X97.18 Y85.219 E.04838
G1 X97.232 Y85.167 E.00128
G1 X97.283 Y85.219 E.00128
G1 X97.283 Y87.983 E.04838
G1 X97.274 Y87.992 E.00023
; WIPE_START
M204 S6000
G1 X97.18 Y87.983 E-.01797
G1 X97.18 Y86.077 E-.36203
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X99.738 Y87.036 Z4.92 F18000
G1 Z4.52
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X100.01 Y86.648 E.01003
G1 X100.306 Y86.855 E.00765
G1 X100.034 Y87.243 E.01003
G1 X99.787 Y87.071 E.00638
M204 S250
G1 X99.193 Y87.101 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X99.909 Y86.078 E.02457
G1 X100.712 Y86.64 E.01926
G1 X100.876 Y86.755 E.00395
G1 X100.159 Y87.778 E.02457
G1 F1739.769
G1 X100.135 Y87.813 E.00085
G1 F2536.476
G1 X99.807 Y87.584 E.00787
G1 X99.182 Y87.146 E.01501
; CHANGE_LAYER
; Z_HEIGHT: 4.64
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F2536.476
M204 S6000
G1 X99.909 Y86.078 E-.24555
G1 X100.489 Y86.484 E-.13445
; WIPE_END
G1 E-.02 F1800
; layer num/total_layer_count: 38/49
; update layer progress
M73 L38
M991 S0 P37 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z4.92 I.347 J-1.166 P1  F18000
G1 X93.851 Y84.507 Z4.92
G1 Z4.64
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X93.851 Y77.128 E.15617
G1 X94.036 Y77.076 E.00407
G1 X94.117 Y77.207 E.00325
G1 X94.173 Y77.349 E.00324
G1 X94.202 Y77.49 E.00306
G1 X94.212 Y88.382 E.23052
G1 X93.851 Y88.382 E.00764
G1 X93.851 Y84.567 E.08075
; WIPE_START
M204 S6000
G1 X93.851 Y82.567 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X93.869 Y90.199 Z5.04 F18000
G1 X93.882 Y95.466 Z5.04
G1 Z4.64
G1 E.4 F1800
G1 F1500
M204 S500
G1 X93.904 Y95.411 E.00124
G1 X93.957 Y95.372 E.0014
G1 X94.159 Y95.319 E.00442
G1 X94.185 Y95.503 E.00394
G1 X94.176 Y95.565 E.00132
G1 X94.111 Y95.632 E.00198
G1 X93.858 Y95.743 E.00584
G1 X93.877 Y95.525 E.00463
; WIPE_START
M204 S6000
G1 X93.904 Y95.411 E-.03624
G1 X93.957 Y95.372 E-.02048
G1 X94.159 Y95.319 E-.06462
G1 X94.185 Y95.503 E-.05754
G1 X94.176 Y95.565 E-.01932
G1 X94.111 Y95.632 E-.02889
G1 X93.858 Y95.743 E-.08536
G1 X93.877 Y95.525 E-.06755
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X88.044 Y97.113 Z5.04 F18000
G1 Z4.64
G1 E.4 F1800
G1 F1500
M204 S500
G1 X87.945 Y97.064 E.00235
G1 X87.436 Y96.915 E.01123
G1 X87.061 Y96.864 E.008
G1 X86.714 Y96.858 E.00735
G1 X86.158 Y96.928 E.01187
G1 X85.667 Y97.088 E.01093
G1 X85.561 Y96.922 E.00416
G1 X85.91 Y96.544 E.01089
G1 X87.821 Y96.544 E.04045
G1 X88.172 Y96.948 E.01133
G1 X88.081 Y97.066 E.00315
; WIPE_START
M204 S6000
G1 X87.945 Y97.064 E-.02585
G1 X87.436 Y96.915 E-.10078
G1 X87.061 Y96.864 E-.0718
G1 X86.714 Y96.858 E-.06596
G1 X86.158 Y96.928 E-.10656
G1 X86.113 Y96.943 E-.00905
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X88.972 Y101.409 Z5.04 F18000
G1 Z4.64
G1 E.4 F1800
G1 F1500
M204 S500
G1 X88.699 Y101.741 E.00908
G1 X88.339 Y102.046 E.01
G1 X87.912 Y102.288 E.01038
G1 X87.64 Y102.393 E.00617
G1 X87.329 Y102.474 E.0068
G1 X86.871 Y102.522 E.00975
G1 X86.399 Y102.487 E.01001
G1 X85.926 Y102.36 E.01037
G1 X85.659 Y102.244 E.00617
G1 X85.38 Y102.083 E.0068
G1 X85.018 Y101.794 E.00981
G1 X84.698 Y101.422 E.01037
G1 X84.542 Y101.176 E.00618
G1 X84.403 Y100.886 E.0068
G1 X84.267 Y100.446 E.00975
G1 X84.211 Y99.979 E.00995
G1 X84.239 Y99.51 E.00995
G1 X84.351 Y99.051 E.01
G1 X84.554 Y98.605 E.01037
G1 X84.713 Y98.36 E.00618
G1 X84.917 Y98.111 E.0068
G1 X85.252 Y97.809 E.00956
G1 X85.521 Y97.632 E.00683
G1 X85.81 Y97.487 E.00683
G1 X86.251 Y97.344 E.00981
G1 X86.737 Y97.282 E.01037
G1 X87.029 Y97.288 E.00618
G1 X87.347 Y97.331 E.00681
G1 X87.789 Y97.46 E.00975
G1 X88.202 Y97.666 E.00975
G1 X88.465 Y97.852 E.00683
G1 X88.707 Y98.07 E.00689
G1 X89.009 Y98.444 E.01018
G1 X89.158 Y98.695 E.00618
G1 X89.289 Y98.989 E.0068
G1 X89.411 Y99.433 E.00975
G1 X89.453 Y99.892 E.00975
G1 X89.433 Y100.212 E.0068
G1 X89.382 Y100.5 E.00618
G1 X89.228 Y100.965 E.01037
G1 X89.007 Y101.361 E.0096
M204 S250
G1 X88.656 Y101.149 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X88.407 Y101.452 E.00772
G1 X88.104 Y101.709 E.00781
G1 X87.736 Y101.917 E.0083
G1 X87.514 Y102.003 E.00469
G1 X87.256 Y102.07 E.00525
G1 X86.865 Y102.111 E.00774
G1 X86.469 Y102.082 E.00781
G1 X86.061 Y101.972 E.00829
G1 X85.843 Y101.878 E.00469
G1 X85.611 Y101.744 E.00525
G1 X85.303 Y101.498 E.00775
G1 X85.028 Y101.178 E.0083
G1 X84.901 Y100.977 E.00469
G1 X84.785 Y100.736 E.00525
G1 X84.669 Y100.361 E.00774
G1 X84.622 Y99.967 E.0078
G1 X84.645 Y99.571 E.0078
G1 X84.74 Y99.186 E.00781
G1 X84.915 Y98.802 E.0083
G1 X85.044 Y98.601 E.00469
G1 X85.213 Y98.395 E.00525
G1 X85.503 Y98.134 E.00767
G1 X85.726 Y97.987 E.00526
G1 X85.966 Y97.867 E.00526
G1 X86.341 Y97.745 E.00775
G1 X86.759 Y97.692 E.0083
G1 X86.997 Y97.697 E.00469
G1 X87.262 Y97.733 E.00525
G1 X87.639 Y97.843 E.00773
G1 X87.991 Y98.019 E.00774
G1 X88.21 Y98.173 E.00526
G1 X88.409 Y98.352 E.00528
G1 X88.672 Y98.678 E.00823
G1 X88.794 Y98.883 E.00469
G1 X88.902 Y99.127 E.00525
G1 X89.007 Y99.506 E.00774
G1 X89.042 Y99.898 E.00773
G1 X89.026 Y100.164 E.00525
G1 X88.985 Y100.399 E.00469
G1 X88.852 Y100.799 E.0083
G1 X88.686 Y101.097 E.00671
; WIPE_START
M204 S6000
G1 X88.407 Y101.452 E-.08579
G1 X88.104 Y101.709 E-.07545
G1 X87.736 Y101.917 E-.08016
G1 X87.514 Y102.003 E-.04527
G1 X87.256 Y102.07 E-.05075
G1 X87.033 Y102.094 E-.04257
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X88.075 Y96.12 Z5.04 F18000
G1 Z4.64
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X93.399 Y96.12 E.11269
G1 X93.463 Y95.392 E.01548
G1 X93.515 Y95.242 E.00336
G1 X93.567 Y95.156 E.00213
G1 X93.743 Y95.002 E.00494
G1 X93.873 Y94.945 E.00302
G1 X94.256 Y94.865 E.00827
G1 X98.287 Y89.109 E.14875
G1 X98.583 Y89.316 E.00765
G1 X94.552 Y95.072 E.14874
G1 X94.61 Y95.479 E.0087
G1 X94.594 Y95.637 E.00335
G1 X94.525 Y95.805 E.00386
G1 X94.387 Y95.956 E.00432
G1 X94.31 Y96.008 E.00197
G1 X94.079 Y96.109 E.00535
G1 X93.852 Y96.308 E.00638
G1 X93.723 Y96.387 E.00321
G1 X93.581 Y96.443 E.00321
G1 X93.441 Y96.472 E.00304
G1 X88.332 Y96.485 E.10814
G1 X89.515 Y97.845 E.03814
G1 X89.837 Y98.353 E.01273
G1 X89.916 Y98.517 E.00387
G1 X90.06 Y98.901 E.00868
G1 X90.186 Y99.48 E.01254
G1 X90.212 Y99.896 E.00881
G1 X90.203 Y100.133 E.00502
G1 X90.16 Y100.488 E.00757
G1 X90.067 Y100.879 E.00852
G1 X89.926 Y101.261 E.00861
G1 X89.822 Y101.475 E.00502
G1 X89.528 Y101.94 E.01165
G1 X89.26 Y102.251 E.00869
G1 X88.958 Y102.529 E.00869
G1 X88.466 Y102.859 E.01254
G1 X88.104 Y103.032 E.00849
G1 X87.724 Y103.161 E.0085
G1 X87.332 Y103.243 E.00849
G1 X86.932 Y103.279 E.00849
G1 X86.531 Y103.267 E.00849
G1 X85.948 Y103.164 E.01253
G1 X85.55 Y103.029 E.00889
G1 X85.024 Y102.757 E.01253
G1 X84.699 Y102.522 E.00849
G1 X84.403 Y102.251 E.00849
G1 X84.141 Y101.947 E.00849
G1 X83.918 Y101.613 E.00849
G1 X83.737 Y101.259 E.00843
G1 X83.583 Y100.829 E.00965
G1 X83.475 Y100.3 E.01144
G1 X83.452 Y99.89 E.00869
G1 X83.477 Y99.49 E.00849
G1 X83.549 Y99.095 E.00849
G1 X83.668 Y98.712 E.00849
G1 X83.83 Y98.348 E.00843
G1 X84.067 Y97.958 E.00965
G1 X84.287 Y97.676 E.00756
G1 X85.39 Y96.482 E.03442
G1 X80.368 Y96.482 E.1063
G1 X80.129 Y96.454 E.00508
G1 X79.93 Y96.381 E.0045
G1 X79.799 Y96.301 E.00324
G1 X79.621 Y96.119 E.00539
G1 X79.57 Y96.041 E.00197
G1 X79.48 Y95.812 E.0052
G1 X79.451 Y95.565 E.00527
G1 X79.451 Y77.628 E.37965
G1 X79.488 Y77.351 E.00591
G1 X79.6 Y77.114 E.00555
G1 X79.766 Y76.929 E.00526
G1 X79.99 Y76.791 E.00557
G1 X80.127 Y76.746 E.00306
G1 X80.29 Y76.723 E.00347
G1 X93.356 Y76.722 E.27656
G1 X93.537 Y76.747 E.00387
G1 X93.68 Y76.794 E.00318
G1 X93.856 Y76.889 E.00424
G1 X93.807 Y77.082 E.0042
G1 X80.779 Y77.082 E.27575
G1 X80.498 Y77.129 E.00604
G1 X80.213 Y77.281 E.00684
G1 X79.978 Y77.529 E.00722
G1 X79.849 Y77.807 E.00649
G1 X79.812 Y78.056 E.00533
G1 X79.812 Y95.139 E.36159
G1 X79.839 Y95.356 E.00461
G1 X79.944 Y95.615 E.00593
G1 X80.122 Y95.84 E.00606
G1 X80.32 Y95.987 E.00523
G1 X80.547 Y96.085 E.00522
G1 X80.787 Y96.12 E.00513
G1 X88.015 Y96.12 E.153
; WIPE_START
M204 S6000
G1 X90.015 Y96.12 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X89.228 Y96.892 Z5.04 F18000
G1 Z4.64
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X89.835 Y97.59 E.01819
G1 X89.964 Y97.767 E.0043
G1 X90.197 Y98.159 E.00897
G1 X90.292 Y98.356 E.00431
G1 X90.452 Y98.78 E.00891
G1 X90.56 Y99.22 E.00891
G1 X90.593 Y99.437 E.00431
G1 X90.621 Y99.891 E.00895
G1 X90.611 Y100.165 E.0054
G1 X90.564 Y100.56 E.00783
G1 X90.459 Y100.998 E.00886
G1 X90.303 Y101.422 E.00889
G1 X90.182 Y101.669 E.0054
G1 X89.978 Y102.014 E.00789
G1 X89.85 Y102.192 E.00432
G1 X89.555 Y102.536 E.00891
G1 X89.221 Y102.842 E.00891
G1 X89.048 Y102.975 E.0043
G1 X88.665 Y103.218 E.00891
G1 X88.259 Y103.412 E.00885
G1 X87.833 Y103.556 E.00885
G1 X87.392 Y103.649 E.00885
G1 X86.944 Y103.689 E.00885
G1 X86.494 Y103.676 E.00885
G1 X86.046 Y103.608 E.00891
G1 X85.834 Y103.557 E.0043
G1 X85.402 Y103.411 E.00898
G1 X85.202 Y103.322 E.0043
G1 X84.805 Y103.103 E.00891
G1 X84.44 Y102.84 E.00885
G1 X84.108 Y102.536 E.00885
G1 X83.815 Y102.195 E.00885
G1 X83.564 Y101.821 E.00885
G1 X83.36 Y101.421 E.00883
G1 X83.19 Y100.945 E.00994
G1 X83.099 Y100.558 E.00783
G1 X83.067 Y100.341 E.00431
G1 X83.042 Y99.889 E.00891
G1 X83.07 Y99.44 E.00885
G1 X83.151 Y98.997 E.00885
G1 X83.284 Y98.567 E.00885
G1 X83.467 Y98.157 E.00883
G1 X83.73 Y97.725 E.00994
G1 X83.974 Y97.411 E.00783
G1 X84.455 Y96.891 E.01393
G1 X80.344 Y96.891 E.08086
G1 X80.034 Y96.855 E.00613
G1 X79.75 Y96.751 E.00594
G1 X79.559 Y96.633 E.00442
G1 X79.449 Y96.541 E.00283
G1 X79.296 Y96.368 E.00454
G1 X79.149 Y96.114 E.00577
G1 X79.078 Y95.901 E.00442
G1 X79.042 Y95.589 E.00619
G1 X79.042 Y77.61 E.35362
G1 X79.062 Y77.374 E.00466
G1 X79.096 Y77.232 E.00287
G1 X79.155 Y77.076 E.00329
G1 X79.255 Y76.891 E.00413
G1 X79.355 Y76.76 E.00324
G1 X79.503 Y76.614 E.00409
G1 X79.689 Y76.483 E.00447
G1 X79.836 Y76.411 E.00322
G1 X80.034 Y76.347 E.00409
G1 X80.26 Y76.313 E.00449
G1 X93.384 Y76.313 E.25814
G1 X93.63 Y76.347 E.00489
G1 X93.842 Y76.417 E.0044
G1 X94.04 Y76.524 E.00442
G1 X94.216 Y76.663 E.00442
G1 X94.366 Y76.831 E.00442
M73 P83 R4
G1 X94.484 Y77.022 E.00442
G1 X94.567 Y77.231 E.00442
G1 X94.612 Y77.448 E.00436
G1 X94.621 Y88.791 E.2231
G1 X93.442 Y88.791 E.02321
G1 X93.442 Y77.491 E.22226
G1 X80.814 Y77.491 E.24838
G1 X80.632 Y77.522 E.00364
G1 X80.464 Y77.611 E.00373
G1 X80.321 Y77.762 E.00408
G1 X80.245 Y77.925 E.00355
G1 X80.222 Y78.086 E.00319
G1 X80.222 Y95.114 E.33493
G1 X80.239 Y95.252 E.00273
G1 X80.302 Y95.408 E.00331
G1 X80.409 Y95.544 E.00341
G1 X80.526 Y95.63 E.00286
G1 X80.659 Y95.688 E.00285
G1 X80.816 Y95.711 E.00312
G1 X93.024 Y95.711 E.24012
G1 X93.058 Y95.326 E.00759
G1 X93.083 Y95.22 E.00214
G1 X93.147 Y95.058 E.00344
G1 X93.238 Y94.911 E.00339
G1 X93.35 Y94.785 E.00332
G1 X93.536 Y94.646 E.00457
G1 X93.749 Y94.553 E.00457
G1 X94.014 Y94.498 E.00532
G1 X98.162 Y88.574 E.14225
G1 F1739.85
G1 X98.186 Y88.539 E.00085
G1 F2536.476
G1 X98.514 Y88.768 E.00787
G1 X98.825 Y88.986 E.00747
G1 X99.153 Y89.215 E.00787
G1 F1739.816
G1 X99.128 Y89.251 E.00085
G1 F1500
G1 X94.98 Y95.175 E.14224
G1 X95.019 Y95.562 E.00767
G1 X94.958 Y95.847 E.00573
G1 X94.82 Y96.099 E.00564
G1 X94.651 Y96.272 E.00477
G1 X94.508 Y96.368 E.00338
G1 X94.301 Y96.459 E.00445
G1 X94.096 Y96.639 E.00538
G1 X93.906 Y96.755 E.00438
G1 X93.698 Y96.837 E.00438
G1 X93.483 Y96.881 E.00432
G1 X89.288 Y96.892 E.0825
; WIPE_START
M204 S6000
G1 X89.835 Y97.59 E-.16851
G1 X89.964 Y97.767 E-.04158
G1 X90.197 Y98.159 E-.08665
G1 X90.292 Y98.356 E-.04164
G1 X90.37 Y98.561 E-.04162
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




G1 X88.973 Y97.8
G1 Z4.64
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.382266
G1 F1500
M204 S6000
G1 X88.708 Y97.53 E.00673
; LINE_WIDTH: 0.426887
G1 X88.582 Y97.417 E.00338
; LINE_WIDTH: 0.468061
G1 X88.457 Y97.304 E.00372
G1 X88.435 Y97.308 E.0005
; LINE_WIDTH: 0.443113
G1 X88.275 Y97.338 E.00338
; LINE_WIDTH: 0.416339
G1 X88.116 Y97.367 E.00316
M204 S10000
G1 X88.973 Y97.8 F18000
; LINE_WIDTH: 0.36033
G1 F1500
M204 S6000
G1 X89.21 Y98.08 E.00612
G1 X89.5 Y98.53 E.00894
G1 X89.693 Y99.015 E.00871
G1 X89.782 Y99.38 E.00628
G1 X89.832 Y99.898 E.00869
G1 X89.809 Y100.247 E.00583
G1 X89.745 Y100.604 E.00605
G1 X89.577 Y101.113 E.00894
G1 X89.315 Y101.577 E.00889
G1 X89.223 Y101.707 E.00267
G1 X88.958 Y102.016 E.0068
G1 X88.54 Y102.361 E.00905
G1 X88.084 Y102.624 E.00877
G1 X87.747 Y102.755 E.00604
G1 X87.384 Y102.847 E.00625
G1 X86.891 Y102.9 E.00828
G1 X86.352 Y102.857 E.00904
G1 X86.052 Y102.792 E.00511
G1 X85.548 Y102.611 E.00894
G1 X85.228 Y102.435 E.0061
G1 X84.941 Y102.224 E.00594
G1 X84.678 Y101.985 E.00594
G1 X84.388 Y101.637 E.00756
G1 X84.217 Y101.367 E.00533
G1 X84.087 Y101.107 E.00485
G1 X83.952 Y100.723 E.0068
G1 X83.857 Y100.256 E.00795
G1 X83.834 Y99.891 E.00611
G1 X83.864 Y99.469 E.00707
G1 X83.99 Y98.942 E.00903
G1 X84.17 Y98.526 E.00757
G1 X84.38 Y98.174 E.00684
G1 X84.578 Y97.923 E.00533
; LINE_WIDTH: 0.379486
G1 X85.016 Y97.481 E.01099
; LINE_WIDTH: 0.449108
G1 X85.26 Y97.274 E.00676
G1 X85.284 Y97.279 E.0005
; LINE_WIDTH: 0.435503
G1 X85.307 Y97.284 E.00049
; LINE_WIDTH: 0.397397
G1 X85.583 Y97.351 E.00527
; WIPE_START
G1 X85.307 Y97.284 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X80.307 Y96.238 Z5.04 F18000
G1 Z4.64
G1 E.4 F1800
; LINE_WIDTH: 0.0933377
G1 F1500
M204 S6000
G1 X80.188 Y96.205 E.00041
; LINE_WIDTH: 0.131116
G1 X80.052 Y96.132 E.00081
; LINE_WIDTH: 0.159077
G1 X79.928 Y96.043 E.00102
G1 X79.781 Y95.851 E.00161
; LINE_WIDTH: 0.12712
G1 X79.723 Y95.737 E.00064
; LINE_WIDTH: 0.0912769
G1 X79.695 Y95.628 E.00037
; WIPE_START
G1 X79.723 Y95.737 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X87.353 Y95.96 Z5.04 F18000
G1 X93.61 Y96.144 Z5.04
G1 Z4.64
G1 E.4 F1800
; LINE_WIDTH: 0.109743
G1 F1500
M204 S6000
G1 X93.837 Y96.009 E.0011
; WIPE_START
G1 X93.61 Y96.144 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X89.029 Y90.039 Z5.04 F18000
G1 X79.689 Y77.595 Z5.04
G1 Z4.64
G1 E.4 F1800
; LINE_WIDTH: 0.105671
G1 F1500
M204 S6000
G1 X79.756 Y77.387 E.00087
; LINE_WIDTH: 0.149603
G1 X79.95 Y77.146 E.00191
G1 X80.04 Y77.069 E.00073
G1 X80.188 Y77 E.00101
; LINE_WIDTH: 0.100205
G1 X80.328 Y76.954 E.00055
; WIPE_START
G1 X80.188 Y77 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X86.965 Y80.511 Z5.04 F18000
G1 X99.69 Y87.105 Z5.04
G1 Z4.64
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X100.01 Y86.648 E.01181
G1 X100.306 Y86.855 E.00765
G1 X99.986 Y87.312 E.01181
G1 X99.739 Y87.139 E.00638
M204 S250
G1 X99.145 Y87.17 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X99.909 Y86.078 E.02622
G1 X100.738 Y86.658 E.01989
G1 X100.876 Y86.755 E.00332
G1 X100.111 Y87.847 E.02622
G1 F1739.816
G1 X100.087 Y87.882 E.00085
G1 F2536.476
G1 X99.759 Y87.653 E.00787
G1 X99.134 Y87.215 E.01501
; CHANGE_LAYER
; Z_HEIGHT: 4.76
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F2536.476
M204 S6000
G1 X99.909 Y86.078 E-.26151
G1 X100.42 Y86.436 E-.11849
; WIPE_END
G1 E-.02 F1800
; layer num/total_layer_count: 39/49
; update layer progress
M73 L39
M991 S0 P38 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z5.04 I.353 J-1.165 P1  F18000
G1 X93.851 Y84.448 Z5.04
G1 Z4.76
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X93.851 Y77.128 E.15492
G1 X94.036 Y77.076 E.00407
G1 X94.117 Y77.207 E.00325
G1 X94.173 Y77.349 E.00324
G1 X94.202 Y77.49 E.00306
G1 X94.212 Y88.382 E.23052
G1 X93.851 Y88.382 E.00764
G1 X93.851 Y84.508 E.082
; WIPE_START
M204 S6000
G1 X93.851 Y82.508 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X93.874 Y90.14 Z5.16 F18000
G1 X93.89 Y95.435 Z5.16
G1 Z4.76
G1 E.4 F1800
G1 F1500
M204 S500
G1 X93.954 Y95.367 E.00197
G1 X94.159 Y95.318 E.00446
G1 X94.185 Y95.503 E.00396
G1 X94.176 Y95.565 E.00133
G1 X94.111 Y95.632 E.00198
G1 X93.863 Y95.741 E.00573
G1 X93.885 Y95.494 E.00524
; WIPE_START
M204 S6000
G1 X93.954 Y95.367 E-.0453
G1 X94.159 Y95.318 E-.06579
G1 X94.185 Y95.503 E-.05844
G1 X94.176 Y95.565 E-.01958
G1 X94.111 Y95.632 E-.02914
G1 X93.863 Y95.741 E-.08451
G1 X93.885 Y95.494 E-.07723
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X88.017 Y97.085 Z5.16 F18000
G1 Z4.76
G1 E.4 F1800
G1 F1500
M204 S500
G1 X87.436 Y96.915 E.01282
G1 X87.061 Y96.864 E.008
G1 X86.711 Y96.858 E.00741
G1 X86.157 Y96.928 E.01182
G1 X85.597 Y97.11 E.01247
G1 X85.49 Y96.949 E.0041
G1 X85.842 Y96.544 E.01135
G1 X87.778 Y96.544 E.04098
G1 X88.12 Y96.922 E.01077
G1 X88.049 Y97.034 E.0028
; WIPE_START
M204 S6000
G1 X87.436 Y96.915 E-.11873
G1 X87.061 Y96.864 E-.07182
G1 X86.711 Y96.858 E-.06648
G1 X86.157 Y96.928 E-.1061
G1 X86.073 Y96.956 E-.01687
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X88.972 Y101.409 Z5.16 F18000
G1 Z4.76
G1 E.4 F1800
G1 F1500
M204 S500
G1 X88.699 Y101.741 E.00909
G1 X88.339 Y102.046 E.01
G1 X87.915 Y102.287 E.01032
G1 X87.64 Y102.393 E.00623
G1 X87.329 Y102.474 E.00681
G1 X86.88 Y102.521 E.00955
G1 X86.558 Y102.507 E.00683
G1 X86.239 Y102.454 E.00683
G1 X85.801 Y102.312 E.00975
G1 X85.387 Y102.089 E.00995
G1 X85.018 Y101.794 E.01
G1 X84.7 Y101.425 E.01032
G1 X84.542 Y101.176 E.00623
G1 X84.403 Y100.886 E.0068
G1 X84.267 Y100.446 E.00976
G1 X84.211 Y99.979 E.00994
G1 X84.239 Y99.519 E.00975
G1 X84.306 Y99.204 E.00683
G1 X84.41 Y98.898 E.00683
G1 X84.622 Y98.489 E.00975
G1 X84.91 Y98.118 E.00995
G1 X85.252 Y97.809 E.00975
G1 X85.521 Y97.632 E.00683
G1 X85.81 Y97.487 E.00683
G1 X86.25 Y97.344 E.0098
G1 X86.734 Y97.283 E.01032
G1 X87.029 Y97.288 E.00623
G1 X87.347 Y97.331 E.00681
G1 X87.78 Y97.458 E.00955
G1 X88.073 Y97.593 E.00683
G1 X88.348 Y97.763 E.00683
G1 X88.699 Y98.061 E.00975
G1 X88.992 Y98.417 E.00975
G1 X89.157 Y98.693 E.00681
G1 X89.278 Y98.961 E.00623
G1 X89.411 Y99.43 E.01032
G1 X89.453 Y99.901 E.01
G1 X89.412 Y100.36 E.00975
G1 X89.336 Y100.672 E.00681
G1 X89.233 Y100.948 E.00623
G1 X89.007 Y101.361 E.00997
M204 S250
G1 X88.656 Y101.149 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X88.406 Y101.453 E.00772
G1 X88.103 Y101.709 E.00781
G1 X87.739 Y101.916 E.00825
G1 X87.514 Y102.003 E.00474
G1 X87.256 Y102.07 E.00525
G1 X86.868 Y102.111 E.00767
G1 X86.601 Y102.099 E.00526
G1 X86.337 Y102.055 E.00527
M73 P83 R3
G1 X85.963 Y101.934 E.00773
G1 X85.614 Y101.746 E.0078
G1 X85.303 Y101.498 E.00782
G1 X85.03 Y101.18 E.00825
G1 X84.901 Y100.977 E.00474
G1 X84.785 Y100.736 E.00525
G1 X84.669 Y100.36 E.00774
G1 X84.622 Y99.967 E.00779
G1 X84.645 Y99.574 E.00774
G1 X84.701 Y99.313 E.00526
G1 X84.787 Y99.06 E.00526
G1 X84.969 Y98.711 E.00773
G1 X85.211 Y98.397 E.0078
G1 X85.503 Y98.134 E.00773
G1 X85.726 Y97.987 E.00526
G1 X85.966 Y97.867 E.00526
G1 X86.34 Y97.745 E.00775
G1 X86.756 Y97.692 E.00825
G1 X86.997 Y97.697 E.00474
G1 X87.262 Y97.733 E.00525
G1 X87.636 Y97.842 E.00767
G1 X87.879 Y97.954 E.00526
G1 X88.107 Y98.095 E.00527
G1 X88.407 Y98.349 E.00773
G1 X88.656 Y98.653 E.00773
G1 X88.793 Y98.882 E.00525
G1 X88.892 Y99.102 E.00474
G1 X89.007 Y99.505 E.00825
G1 X89.042 Y99.901 E.00781
G1 X89.007 Y100.292 E.00773
G1 X88.944 Y100.552 E.00526
G1 X88.86 Y100.778 E.00474
G1 X88.685 Y101.097 E.00716
; WIPE_START
M204 S6000
G1 X88.406 Y101.453 E-.08582
G1 X88.103 Y101.709 E-.07547
G1 X87.739 Y101.916 E-.07965
G1 X87.514 Y102.003 E-.04577
G1 X87.256 Y102.07 E-.05073
G1 X87.033 Y102.094 E-.04257
; WIPE_END
G1 E-.02 F1800
M204 S10000
M73 P84 R3
G1 X88.028 Y96.12 Z5.16 F18000
G1 Z4.76
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X93.416 Y96.12 E.11403
G1 X93.455 Y95.443 E.01436
G1 X93.477 Y95.335 E.00232
G1 X93.563 Y95.164 E.00405
G1 X93.667 Y95.053 E.00321
G1 X93.825 Y94.962 E.00386
G1 X94.262 Y94.857 E.00952
G1 X98.335 Y89.04 E.15031
G1 X98.631 Y89.247 E.00765
G1 X94.552 Y95.072 E.15052
G1 X94.61 Y95.479 E.0087
G1 X94.594 Y95.638 E.00337
G1 X94.55 Y95.759 E.00274
G1 X94.495 Y95.845 E.00216
G1 X94.388 Y95.956 E.00327
G1 X94.31 Y96.008 E.00197
G1 X94.079 Y96.109 E.00535
G1 X93.852 Y96.308 E.00638
G1 X93.723 Y96.387 E.00321
G1 X93.581 Y96.443 E.00322
G1 X93.441 Y96.472 E.00304
G1 X88.297 Y96.485 E.10888
G1 X89.406 Y97.712 E.03499
G1 X89.631 Y98.007 E.00786
G1 X89.919 Y98.526 E.01256
G1 X90.06 Y98.901 E.00849
G1 X90.186 Y99.48 E.01254
G1 X90.212 Y99.896 E.00881
G1 X90.159 Y100.497 E.01278
G1 X90.003 Y101.07 E.01256
G1 X89.842 Y101.438 E.0085
G1 X89.638 Y101.783 E.00849
G1 X89.39 Y102.11 E.00868
G1 X89.269 Y102.243 E.0038
G1 X88.927 Y102.551 E.00975
G1 X88.475 Y102.855 E.01153
G1 X88.104 Y103.032 E.00869
G1 X87.716 Y103.164 E.00869
G1 X87.132 Y103.267 E.01254
G1 X86.731 Y103.279 E.00849
G1 X86.332 Y103.243 E.00849
G1 X85.939 Y103.161 E.00849
G1 X85.55 Y103.029 E.00869
G1 X85.024 Y102.757 E.01253
G1 X84.698 Y102.522 E.0085
G1 X84.403 Y102.251 E.00849
G1 X84.141 Y101.947 E.00849
G1 X83.918 Y101.613 E.00849
G1 X83.737 Y101.258 E.00844
G1 X83.584 Y100.833 E.00956
G1 X83.475 Y100.3 E.01153
G1 X83.452 Y99.89 E.00869
G1 X83.477 Y99.49 E.00849
G1 X83.549 Y99.095 E.00849
G1 X83.668 Y98.712 E.00849
G1 X83.834 Y98.34 E.00862
G1 X84.154 Y97.839 E.01258
G1 X85.334 Y96.482 E.03807
G1 X80.368 Y96.482 E.10512
G1 X80.114 Y96.452 E.00541
G1 X80.026 Y96.425 E.00196
G1 X79.814 Y96.312 E.00508
G1 X79.699 Y96.21 E.00324
G1 X79.566 Y96.031 E.00472
G1 X79.481 Y95.818 E.00484
G1 X79.451 Y95.565 E.00541
G1 X79.451 Y77.628 E.37965
G1 X79.487 Y77.357 E.00578
G1 X79.592 Y77.125 E.00539
G1 X79.693 Y76.998 E.00343
G1 X79.807 Y76.896 E.00324
G1 X80.028 Y76.775 E.00533
G1 X80.288 Y76.723 E.00561
G1 X93.357 Y76.722 E.27662
G1 X93.537 Y76.747 E.00383
G1 X93.68 Y76.794 E.00319
G1 X93.856 Y76.889 E.00424
G1 X93.807 Y77.082 E.0042
G1 X80.786 Y77.082 E.2756
G1 X80.528 Y77.12 E.00553
G1 X80.217 Y77.276 E.00736
G1 X79.978 Y77.529 E.00736
G1 X79.849 Y77.806 E.00649
G1 X79.812 Y78.056 E.00533
G1 X79.812 Y95.137 E.36154
G1 X79.837 Y95.346 E.00446
G1 X79.943 Y95.612 E.00607
G1 X80.116 Y95.833 E.00594
G1 X80.318 Y95.986 E.00536
G1 X80.547 Y96.085 E.00528
G1 X80.787 Y96.12 E.00514
G1 X87.968 Y96.12 E.15201
; WIPE_START
M204 S6000
G1 X89.968 Y96.12 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X89.216 Y96.892 Z5.16 F18000
G1 Z4.76
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X89.72 Y97.45 E.01478
G1 X89.967 Y97.772 E.00798
G1 X90.085 Y97.957 E.00431
G1 X90.293 Y98.359 E.00891
G1 X90.452 Y98.78 E.00885
G1 X90.56 Y99.22 E.00891
G1 X90.593 Y99.437 E.00431
G1 X90.621 Y99.891 E.00895
G1 X90.611 Y100.16 E.00531
G1 X90.563 Y100.563 E.00798
G1 X90.519 Y100.778 E.00431
G1 X90.387 Y101.212 E.00891
G1 X90.207 Y101.624 E.00885
G1 X89.979 Y102.012 E.00885
G1 X89.705 Y102.372 E.00891
G1 X89.558 Y102.533 E.00429
G1 X89.184 Y102.871 E.00991
G1 X88.856 Y103.105 E.00792
G1 X88.668 Y103.216 E.00431
G1 X88.259 Y103.412 E.00891
G1 X87.829 Y103.557 E.00891
G1 X87.617 Y103.608 E.0043
G1 X87.169 Y103.676 E.00891
G1 X86.719 Y103.689 E.00885
G1 X86.271 Y103.649 E.00885
G1 X85.831 Y103.556 E.00885
G1 X85.402 Y103.411 E.00891
G1 X85.202 Y103.322 E.0043
G1 X84.805 Y103.103 E.00891
G1 X84.44 Y102.84 E.00885
G1 X84.108 Y102.536 E.00885
G1 X83.815 Y102.195 E.00885
G1 X83.564 Y101.821 E.00885
G1 X83.36 Y101.421 E.00883
G1 X83.191 Y100.95 E.00985
G1 X83.099 Y100.558 E.00792
G1 X83.067 Y100.341 E.00431
G1 X83.042 Y99.889 E.00891
G1 X83.07 Y99.44 E.00885
G1 X83.151 Y98.997 E.00885
G1 X83.284 Y98.567 E.00885
G1 X83.468 Y98.154 E.00889
G1 X83.602 Y97.92 E.00531
G1 X83.83 Y97.588 E.00792
G1 X84.436 Y96.891 E.01817
G1 X80.344 Y96.891 E.08049
G1 X80.029 Y96.854 E.00623
G1 X79.877 Y96.807 E.00313
G1 X79.685 Y96.716 E.00419
G1 X79.564 Y96.637 E.00284
G1 X79.396 Y96.488 E.00442
G1 X79.214 Y96.242 E.00602
G1 X79.125 Y96.055 E.00407
G1 X79.078 Y95.903 E.00313
G1 X79.042 Y95.589 E.00623
G1 X79.042 Y77.61 E.35362
G1 X79.062 Y77.374 E.00466
G1 X79.095 Y77.234 E.00283
G1 X79.181 Y77.019 E.00454
G1 X79.253 Y76.895 E.00283
G1 X79.394 Y76.716 E.00448
G1 X79.562 Y76.567 E.00442
G1 X79.756 Y76.447 E.00448
G1 X80.048 Y76.343 E.00611
G1 X80.259 Y76.313 E.00418
G1 X93.385 Y76.313 E.25818
G1 X93.63 Y76.347 E.00485
G1 X93.842 Y76.417 E.00441
G1 X94.04 Y76.524 E.00442
G1 X94.216 Y76.663 E.00442
G1 X94.366 Y76.831 E.00442
G1 X94.484 Y77.022 E.00442
G1 X94.567 Y77.231 E.00442
G1 X94.612 Y77.448 E.00436
G1 X94.621 Y88.791 E.2231
G1 X93.442 Y88.791 E.02321
G1 X93.442 Y77.491 E.22226
G1 X80.816 Y77.491 E.24833
G1 X80.653 Y77.515 E.00325
G1 X80.465 Y77.609 E.00413
G1 X80.321 Y77.762 E.00413
G1 X80.245 Y77.925 E.00355
G1 X80.222 Y78.086 E.00319
G1 X80.222 Y95.113 E.33491
G1 X80.237 Y95.245 E.00261
G1 X80.301 Y95.407 E.00342
G1 X80.405 Y95.539 E.00331
G1 X80.525 Y95.63 E.00296
G1 X80.659 Y95.688 E.00287
G1 X80.816 Y95.711 E.00312
G1 X93.03 Y95.711 E.24023
G1 X93.048 Y95.389 E.00634
G1 X93.084 Y95.218 E.00345
G1 X93.147 Y95.058 E.00338
G1 X93.236 Y94.914 E.00332
G1 X93.397 Y94.742 E.00463
G1 X93.536 Y94.645 E.00333
G1 X93.689 Y94.573 E.00332
G1 X94.016 Y94.495 E.00662
G1 X98.21 Y88.505 E.14383
G1 F1739.816
G1 X98.235 Y88.47 E.00085
G1 F2536.476
G1 X98.562 Y88.699 E.00787
G1 X98.874 Y88.917 E.00747
G1 X99.201 Y89.147 E.00787
G1 F1739.85
G1 X99.177 Y89.182 E.00085
G1 F1500
G1 X94.98 Y95.175 E.1439
G1 X95.02 Y95.451 E.0055
G1 X94.994 Y95.727 E.00545
G1 X94.912 Y95.953 E.00474
G1 X94.818 Y96.101 E.00344
G1 X94.651 Y96.272 E.0047
G1 X94.508 Y96.368 E.00338
G1 X94.301 Y96.459 E.00444
G1 X94.096 Y96.639 E.00538
G1 X93.906 Y96.755 E.00438
G1 X93.698 Y96.837 E.00439
G1 X93.483 Y96.881 E.00432
G1 X89.276 Y96.892 E.08274
; WIPE_START
M204 S6000
G1 X89.72 Y97.45 E-.13545
G1 X89.967 Y97.772 E-.07712
G1 X90.085 Y97.957 E-.04167
G1 X90.293 Y98.359 E-.08608
G1 X90.367 Y98.555 E-.03969
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




G1 X88.959 Y97.784
G1 Z4.76
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.37694
G1 F1500
M204 S6000
G1 X88.781 Y97.611 E.00435
; LINE_WIDTH: 0.412364
G1 X88.576 Y97.415 E.00547
; LINE_WIDTH: 0.449537
G1 X88.405 Y97.276 E.00465
; LINE_WIDTH: 0.48052
G1 X88.235 Y97.138 E.00499
M204 S10000
G1 X88.959 Y97.784 F18000
; LINE_WIDTH: 0.360414
G1 F1500
M204 S6000
G1 X89.291 Y98.191 E.00878
G1 X89.495 Y98.527 E.00656
G1 X89.636 Y98.843 E.00577
G1 X89.782 Y99.377 E.00924
G1 X89.832 Y99.886 E.00854
G1 X89.821 Y100.096 E.00351
G1 X89.75 Y100.587 E.00829
G1 X89.581 Y101.094 E.00891
G1 X89.323 Y101.572 E.00908
G1 X89.099 Y101.859 E.00609
G1 X88.954 Y102.012 E.00351
G1 X88.54 Y102.362 E.00905
G1 X88.065 Y102.633 E.00913
G1 X87.614 Y102.795 E.00801
G1 X87.096 Y102.884 E.00878
G1 X86.743 Y102.897 E.0059
G1 X86.388 Y102.865 E.00594
G1 X86.04 Y102.791 E.00594
G1 X85.666 Y102.665 E.00659
G1 X85.167 Y102.395 E.00947
G1 X84.746 Y102.055 E.00905
G1 X84.446 Y101.715 E.00756
G1 X84.217 Y101.368 E.00695
G1 X84.048 Y101.012 E.00657
G1 X83.895 Y100.51 E.00877
G1 X83.837 Y100.005 E.00848
G1 X83.856 Y99.536 E.00784
G1 X83.92 Y99.186 E.00595
G1 X84.058 Y98.762 E.00745
G1 X84.272 Y98.339 E.0079
G1 X84.458 Y98.074 E.00541
G1 X84.817 Y97.673 E.00899
; LINE_WIDTH: 0.400643
G1 X84.992 Y97.496 E.00464
; LINE_WIDTH: 0.438438
G1 X85.198 Y97.319 E.00561
; LINE_WIDTH: 0.477125
G1 X85.379 Y97.165 E.00533
; WIPE_START
G1 X85.198 Y97.319 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X79.892 Y96.094 Z5.16 F18000
G1 Z4.76
G1 E.4 F1800
; LINE_WIDTH: 0.0980614
G1 F1500
M204 S6000
G1 X80.307 Y96.238 E.00158
M204 S10000
G1 X80.25 Y96.252 F18000
; LINE_WIDTH: 0.152063
G1 F1500
M204 S6000
G1 X79.914 Y96.027 E.00255
G1 X79.681 Y95.686 E.0026
M204 S10000
G1 X79.695 Y95.628 F18000
; LINE_WIDTH: 0.0944931
G1 F1500
M204 S6000
G1 X79.834 Y96.035 E.00147
; WIPE_START
G1 X79.695 Y95.628 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X87.323 Y95.904 Z5.16 F18000
G1 X93.628 Y96.132 Z5.16
G1 Z4.76
G1 E.4 F1800
; LINE_WIDTH: 0.0967031
G1 F1500
M204 S6000
G1 X93.837 Y96.009 E.00086
; WIPE_START
G1 X93.628 Y96.132 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X89.041 Y90.032 Z5.16 F18000
G1 X79.689 Y77.595 Z5.16
G1 Z4.76
G1 E.4 F1800
; LINE_WIDTH: 0.105134
G1 F1500
M204 S6000
G1 X79.756 Y77.387 E.00086
; LINE_WIDTH: 0.155879
G1 X79.902 Y77.194 E.00157
G1 X80.049 Y77.066 E.00126
; LINE_WIDTH: 0.125085
G1 X80.227 Y76.991 E.00096
; LINE_WIDTH: 0.0898468
G1 X80.336 Y76.955 E.00037
; WIPE_START
G1 X80.227 Y76.991 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X86.986 Y80.536 Z5.16 F18000
G1 X99.642 Y87.174 Z5.16
G1 Z4.76
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X100.01 Y86.648 E.01358
G1 X100.306 Y86.855 E.00765
G1 X99.938 Y87.381 E.01358
G1 X99.691 Y87.208 E.00638
M204 S250
G1 X99.096 Y87.239 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X99.909 Y86.078 E.02788
G1 X100.764 Y86.677 E.02052
G1 X100.876 Y86.755 E.00269
G1 X100.063 Y87.916 E.02788
G1 F1739.769
G1 X100.038 Y87.951 E.00085
G1 F2536.476
G1 X99.711 Y87.722 E.00787
G1 X99.086 Y87.284 E.01501
; CHANGE_LAYER
; Z_HEIGHT: 4.88
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F2536.476
M204 S6000
G1 X99.909 Y86.078 E-.27748
G1 X100.351 Y86.388 E-.10252
; WIPE_END
G1 E-.02 F1800
; layer num/total_layer_count: 40/49
; update layer progress
M73 L40
M991 S0 P39 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z5.16 I.338 J-1.169 P1  F18000
G1 X93.851 Y84.507 Z5.16
M73 P85 R3
G1 Z4.88
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X93.851 Y77.128 E.15617
G1 X94.036 Y77.076 E.00407
G1 X94.117 Y77.207 E.00325
G1 X94.173 Y77.349 E.00324
G1 X94.202 Y77.49 E.00306
G1 X94.212 Y88.382 E.23052
G1 X93.851 Y88.382 E.00764
G1 X93.851 Y84.567 E.08075
; WIPE_START
M204 S6000
G1 X93.851 Y82.567 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X93.874 Y90.199 Z5.28 F18000
G1 X93.89 Y95.434 Z5.28
G1 Z4.88
G1 E.4 F1800
G1 F1500
M204 S500
G1 X93.943 Y95.378 E.00163
G1 X94.159 Y95.319 E.00474
G1 X94.188 Y95.516 E.00422
G1 X94.109 Y95.633 E.00297
G1 X93.863 Y95.741 E.00569
G1 X93.885 Y95.494 E.00525
; WIPE_START
M204 S6000
G1 X93.943 Y95.378 E-.0407
G1 X94.159 Y95.319 E-.0703
G1 X94.188 Y95.516 E-.06262
G1 X94.109 Y95.633 E-.04408
G1 X93.863 Y95.741 E-.0844
G1 X93.885 Y95.494 E-.0779
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X88.042 Y97.113 Z5.28 F18000
G1 Z4.88
G1 E.4 F1800
G1 F1500
M204 S500
G1 X87.949 Y97.065 E.00222
G1 X87.436 Y96.915 E.01131
G1 X87.061 Y96.864 E.00801
G1 X86.708 Y96.858 E.00746
G1 X86.157 Y96.928 E.01177
G1 X85.597 Y97.11 E.01246
G1 X85.49 Y96.949 E.0041
G1 X85.842 Y96.544 E.01135
G1 X87.821 Y96.544 E.04188
G1 X88.171 Y96.947 E.0113
G1 X88.079 Y97.065 E.00317
; WIPE_START
M204 S6000
G1 X87.949 Y97.065 E-.0248
G1 X87.436 Y96.915 E-.10153
G1 X87.061 Y96.864 E-.07187
G1 X86.708 Y96.858 E-.067
G1 X86.157 Y96.928 E-.10561
G1 X86.111 Y96.943 E-.00918
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X88.972 Y101.409 Z5.28 F18000
G1 Z4.88
G1 E.4 F1800
G1 F1500
M204 S500
G1 X88.699 Y101.741 E.00909
G1 X88.339 Y102.046 E.01
G1 X87.917 Y102.286 E.01026
G1 X87.64 Y102.393 E.00628
G1 X87.329 Y102.474 E.00681
G1 X86.869 Y102.523 E.0098
G1 X86.385 Y102.483 E.01027
G1 X86.096 Y102.416 E.00628
G1 X85.793 Y102.307 E.00681
G1 X85.387 Y102.089 E.00975
G1 X85.018 Y101.794 E.01
G1 X84.702 Y101.427 E.01027
G1 X84.543 Y101.176 E.00628
G1 X84.403 Y100.886 E.00681
G1 X84.267 Y100.446 E.00975
G1 X84.211 Y99.979 E.00995
G1 X84.239 Y99.508 E.01
G1 X84.358 Y99.037 E.01027
G1 X84.471 Y98.763 E.00629
G1 X84.628 Y98.482 E.0068
G1 X84.91 Y98.118 E.00975
G1 X85.252 Y97.809 E.00975
G1 X85.521 Y97.632 E.00683
G1 X85.81 Y97.487 E.00683
G1 X86.25 Y97.344 E.0098
G1 X86.732 Y97.283 E.01027
G1 X87.028 Y97.288 E.00629
G1 X87.347 Y97.331 E.00681
G1 X87.792 Y97.461 E.0098
G1 X88.224 Y97.681 E.01027
G1 X88.466 Y97.853 E.00628
G1 X88.707 Y98.07 E.00686
G1 X89.006 Y98.439 E.01007
G1 X89.158 Y98.695 E.00629
G1 X89.289 Y98.989 E.00681
G1 X89.411 Y99.433 E.00975
G1 X89.453 Y99.901 E.00995
G1 X89.412 Y100.36 E.00975
G1 X89.336 Y100.672 E.00681
G1 X89.232 Y100.951 E.00628
G1 X89.007 Y101.361 E.00991
M204 S250
G1 X88.656 Y101.149 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X88.407 Y101.452 E.00772
G1 X88.104 Y101.709 E.00781
G1 X87.741 Y101.915 E.0082
G1 X87.514 Y102.003 E.00478
G1 X87.256 Y102.07 E.00525
G1 X86.864 Y102.112 E.00775
G1 X86.448 Y102.077 E.0082
G1 X86.212 Y102.022 E.00478
G1 X85.96 Y101.932 E.00526
G1 X85.614 Y101.746 E.00773
G1 X85.303 Y101.498 E.00781
G1 X85.031 Y101.182 E.0082
G1 X84.901 Y100.977 E.00478
G1 X84.785 Y100.736 E.00526
G1 X84.669 Y100.361 E.00773
G1 X84.622 Y99.967 E.0078
G1 X84.646 Y99.571 E.00781
G1 X84.747 Y99.166 E.0082
G1 X84.84 Y98.941 E.00479
G1 X84.97 Y98.708 E.00525
G1 X85.211 Y98.397 E.00773
G1 X85.503 Y98.134 E.00773
G1 X85.726 Y97.987 E.00526
G1 X85.966 Y97.867 E.00526
G1 X86.34 Y97.745 E.00775
G1 X86.754 Y97.692 E.0082
G1 X86.997 Y97.697 E.00478
G1 X87.262 Y97.733 E.00525
G1 X87.64 Y97.843 E.00775
G1 X88.012 Y98.032 E.0082
G1 X88.21 Y98.173 E.00479
G1 X88.409 Y98.352 E.00527
G1 X88.67 Y98.674 E.00814
G1 X88.794 Y98.883 E.00478
G1 X88.902 Y99.127 E.00526
G1 X89.007 Y99.506 E.00773
G1 X89.042 Y99.901 E.0078
G1 X89.007 Y100.292 E.00773
G1 X88.944 Y100.552 E.00526
G1 X88.859 Y100.78 E.00478
G1 X88.685 Y101.097 E.00711
; WIPE_START
M204 S6000
G1 X88.407 Y101.452 E-.08583
G1 X88.104 Y101.709 E-.07547
G1 X87.741 Y101.915 E-.0792
G1 X87.514 Y102.003 E-.04622
G1 X87.256 Y102.07 E-.05075
G1 X87.033 Y102.094 E-.04253
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X88.075 Y96.12 Z5.28 F18000
G1 Z4.88
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X93.416 Y96.12 E.11304
G1 X93.455 Y95.443 E.01437
G1 X93.477 Y95.335 E.00232
G1 X93.563 Y95.162 E.00408
G1 X93.736 Y95.005 E.00495
G1 X93.873 Y94.945 E.00317
G1 X94.256 Y94.865 E.00827
G1 X98.383 Y88.971 E.15231
G1 X98.679 Y89.178 E.00765
G1 X94.552 Y95.074 E.15233
G1 X94.61 Y95.469 E.00846
G1 X94.592 Y95.649 E.00381
G1 X94.488 Y95.85 E.0048
G1 X94.386 Y95.957 E.00313
G1 X94.079 Y96.109 E.00726
G1 X93.852 Y96.308 E.00638
G1 X93.723 Y96.387 E.00321
G1 X93.581 Y96.443 E.00321
G1 X93.441 Y96.472 E.00304
G1 X88.332 Y96.485 E.10814
G1 X89.515 Y97.845 E.03814
G1 X89.627 Y98 E.00406
G1 X89.919 Y98.526 E.01273
G1 X90.063 Y98.91 E.00869
G1 X90.186 Y99.49 E.01254
G1 X90.212 Y99.896 E.00862
G1 X90.159 Y100.497 E.01277
G1 X90.003 Y101.07 E.01256
G1 X89.842 Y101.437 E.00849
G1 X89.634 Y101.791 E.00869
G1 X89.256 Y102.256 E.01267
G1 X88.806 Y102.644 E.01258
G1 X88.466 Y102.859 E.00852
G1 X88.104 Y103.032 E.00849
G1 X87.724 Y103.161 E.00849
G1 X87.331 Y103.243 E.0085
G1 X86.932 Y103.279 E.00849
G1 X86.531 Y103.267 E.00849
G1 X85.948 Y103.164 E.01253
G1 X85.55 Y103.029 E.00889
G1 X85.061 Y102.779 E.01162
G1 X84.697 Y102.521 E.00946
G1 X84.403 Y102.251 E.00844
G1 X84.141 Y101.947 E.00849
G1 X83.918 Y101.613 E.00849
G1 X83.737 Y101.258 E.00844
G1 X83.585 Y100.838 E.00946
G1 X83.475 Y100.3 E.01162
G1 X83.452 Y99.89 E.00869
G1 X83.477 Y99.49 E.00849
G1 X83.549 Y99.095 E.00849
G1 X83.667 Y98.714 E.00844
G1 X83.852 Y98.307 E.00946
G1 X84.149 Y97.845 E.01162
G1 X85.335 Y96.482 E.03825
G1 X80.368 Y96.482 E.10513
G1 X80.039 Y96.43 E.00703
G1 X79.814 Y96.312 E.0054
G1 X79.693 Y96.204 E.00343
G1 X79.592 Y96.077 E.00343
G1 X79.479 Y95.803 E.00627
G1 X79.451 Y95.565 E.00508
G1 X79.451 Y77.628 E.37965
G1 X79.487 Y77.357 E.00578
G1 X79.6 Y77.114 E.00567
G1 X79.692 Y76.999 E.00312
G1 X79.814 Y76.89 E.00346
G1 X80.031 Y76.775 E.0052
G1 X80.28 Y76.723 E.00539
G1 X93.359 Y76.722 E.27681
G1 X93.536 Y76.747 E.00379
G1 X93.68 Y76.794 E.00319
G1 X93.856 Y76.889 E.00424
G1 X93.807 Y77.082 E.0042
G1 X80.778 Y77.082 E.27579
G1 X80.489 Y77.133 E.0062
G1 X80.212 Y77.282 E.00665
G1 X79.983 Y77.522 E.00703
G1 X79.849 Y77.805 E.00662
G1 X79.812 Y78.056 E.00538
G1 X79.812 Y95.139 E.36158
G1 X79.839 Y95.354 E.00458
G1 X79.944 Y95.615 E.00596
G1 X80.122 Y95.84 E.00607
G1 X80.32 Y95.987 E.00523
G1 X80.547 Y96.085 E.00522
G1 X80.787 Y96.12 E.00513
G1 X88.015 Y96.12 E.153
; WIPE_START
M204 S6000
G1 X90.015 Y96.12 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X89.228 Y96.892 Z5.28 F18000
G1 Z4.88
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X89.835 Y97.59 E.01819
G1 X89.966 Y97.77 E.00437
G1 X90.085 Y97.957 E.00436
G1 X90.293 Y98.359 E.00891
G1 X90.453 Y98.783 E.00891
G1 X90.511 Y98.994 E.0043
G1 X90.593 Y99.44 E.00891
G1 X90.621 Y99.891 E.00889
G1 X90.612 Y100.156 E.00522
G1 X90.563 Y100.563 E.00807
G1 X90.519 Y100.778 E.00431
G1 X90.387 Y101.212 E.00891
G1 X90.207 Y101.624 E.00885
G1 X89.977 Y102.014 E.00891
G1 X89.85 Y102.192 E.00431
G1 X89.554 Y102.538 E.00895
G1 X89.362 Y102.721 E.00522
G1 X89.045 Y102.977 E.00801
G1 X88.665 Y103.218 E.00886
G1 X88.259 Y103.412 E.00884
G1 X87.833 Y103.556 E.00885
G1 X87.392 Y103.649 E.00885
G1 X86.944 Y103.689 E.00884
G1 X86.494 Y103.676 E.00885
G1 X86.046 Y103.608 E.00891
G1 X85.834 Y103.557 E.0043
G1 X85.402 Y103.411 E.00898
G1 X85.201 Y103.322 E.00431
G1 X84.844 Y103.126 E.00801
G1 X84.439 Y102.84 E.00976
G1 X84.108 Y102.536 E.00884
G1 X83.815 Y102.195 E.00885
G1 X83.565 Y101.821 E.00885
G1 X83.36 Y101.421 E.00884
G1 X83.192 Y100.954 E.00976
G1 X83.099 Y100.558 E.00801
G1 X83.067 Y100.341 E.00431
G1 X83.042 Y99.889 E.00891
G1 X83.07 Y99.44 E.00885
G1 X83.151 Y98.997 E.00885
G1 X83.284 Y98.568 E.00883
G1 X83.49 Y98.116 E.00976
G1 X83.699 Y97.767 E.00801
G1 X83.828 Y97.59 E.00431
G1 X84.436 Y96.891 E.01823
G1 X80.344 Y96.891 E.08049
G1 X80.028 Y96.854 E.00625
G1 X79.893 Y96.814 E.00277
G1 X79.684 Y96.716 E.00454
G1 X79.564 Y96.637 E.00283
G1 X79.394 Y96.486 E.00448
G1 X79.253 Y96.307 E.00448
G1 X79.182 Y96.185 E.00277
G1 X79.078 Y95.898 E.00601
G1 X79.042 Y95.589 E.00613
G1 X79.042 Y77.61 E.35362
G1 X79.062 Y77.374 E.00466
G1 X79.095 Y77.234 E.00283
G1 X79.18 Y77.02 E.00452
G1 X79.262 Y76.882 E.00316
G1 X79.394 Y76.716 E.00416
G1 X79.564 Y76.565 E.00449
G1 X79.684 Y76.486 E.00283
G1 X79.891 Y76.389 E.00448
G1 X80.111 Y76.33 E.00448
G1 X80.257 Y76.313 E.00289
G1 X93.387 Y76.313 E.25826
G1 X93.63 Y76.347 E.00481
G1 X93.842 Y76.417 E.00441
G1 X94.04 Y76.524 E.00442
G1 X94.216 Y76.663 E.00442
G1 X94.366 Y76.831 E.00442
G1 X94.484 Y77.022 E.00442
G1 X94.567 Y77.231 E.00442
G1 X94.612 Y77.448 E.00436
G1 X94.621 Y88.791 E.2231
G1 X93.442 Y88.791 E.02321
G1 X93.442 Y77.491 E.22226
G1 X80.813 Y77.491 E.24839
G1 X80.625 Y77.524 E.00376
G1 X80.464 Y77.611 E.0036
G1 X80.325 Y77.757 E.00397
G1 X80.245 Y77.925 E.00365
G1 X80.222 Y78.086 E.0032
G1 X80.222 Y95.114 E.33493
G1 X80.239 Y95.25 E.00271
G1 X80.302 Y95.407 E.00332
G1 X80.409 Y95.544 E.00342
G1 X80.526 Y95.63 E.00286
G1 X80.659 Y95.688 E.00285
G1 X80.816 Y95.711 E.00312
G1 X93.03 Y95.711 E.24023
G1 X93.048 Y95.389 E.00634
G1 X93.084 Y95.218 E.00344
G1 X93.147 Y95.058 E.00339
G1 X93.236 Y94.913 E.00334
G1 X93.388 Y94.751 E.00437
G1 X93.534 Y94.647 E.00353
G1 X93.749 Y94.553 E.00461
G1 X94.014 Y94.498 E.00532
G1 X98.258 Y88.436 E.14555
G1 F1739.897
G1 X98.283 Y88.401 E.00085
G1 F2536.476
G1 X98.61 Y88.63 E.00787
G1 X98.922 Y88.848 E.00747
G1 X99.249 Y89.078 E.00787
G1 F1739.816
G1 X99.225 Y89.113 E.00085
G1 F1500
G1 X94.98 Y95.175 E.14556
G1 X95.019 Y95.439 E.00525
G1 X94.992 Y95.741 E.00597
G1 X94.96 Y95.841 E.00206
G1 X94.821 Y96.095 E.0057
G1 X94.65 Y96.272 E.00484
G1 X94.508 Y96.368 E.00336
G1 X94.301 Y96.459 E.00445
G1 X94.096 Y96.639 E.00538
G1 X93.906 Y96.755 E.00438
G1 X93.698 Y96.837 E.00438
G1 X93.483 Y96.881 E.00432
G1 X89.288 Y96.892 E.0825
; WIPE_START
M204 S6000
G1 X89.835 Y97.59 E-.16849
G1 X89.966 Y97.77 E-.04223
G1 X90.085 Y97.957 E-.04213
G1 X90.293 Y98.359 E-.0861
G1 X90.37 Y98.561 E-.04106
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




G1 X88.973 Y97.799
G1 Z4.88
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.360605
G1 F1500
M204 S6000
G1 X89.31 Y98.214 E.00892
G1 X89.497 Y98.53 E.00614
G1 X89.647 Y98.873 E.00625
G1 X89.782 Y99.38 E.00877
G1 X89.832 Y99.886 E.00849
G1 X89.821 Y100.092 E.00345
G1 X89.75 Y100.587 E.00836
G1 X89.58 Y101.096 E.00896
G1 X89.5 Y101.26 E.00305
G1 X89.223 Y101.707 E.00879
G1 X88.958 Y102.017 E.0068
G1 X88.542 Y102.364 E.00906
G1 X88.09 Y102.621 E.00869
G1 X87.747 Y102.755 E.00614
G1 X87.384 Y102.847 E.00625
G1 X86.857 Y102.9 E.00884
G1 X86.567 Y102.884 E.00485
G1 X86.051 Y102.796 E.00875
G1 X85.629 Y102.646 E.00749
G1 X85.192 Y102.411 E.00828
G1 X84.768 Y102.076 E.00903
G1 X84.446 Y101.715 E.00808
G1 X84.247 Y101.42 E.00594
G1 X84.057 Y101.035 E.00717
G1 X83.905 Y100.538 E.00869
G1 X83.835 Y100.005 E.00897
G1 X83.856 Y99.536 E.00785
G1 X83.924 Y99.187 E.00595
G1 X84.024 Y98.85 E.00588
G1 X84.189 Y98.487 E.00666
G1 X84.453 Y98.08 E.0081
G1 X84.817 Y97.673 E.00913
; LINE_WIDTH: 0.400591
G1 X84.991 Y97.496 E.00464
; LINE_WIDTH: 0.438381
G1 X85.199 Y97.319 E.00562
; LINE_WIDTH: 0.47711
G1 X85.379 Y97.165 E.00534
; WIPE_START
G1 X85.199 Y97.319 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X88.109 Y97.372 Z5.28 F18000
G1 Z4.88
G1 E.4 F1800
; LINE_WIDTH: 0.469767
G1 F1500
M204 S6000
G1 X88.456 Y97.303 E.00784
G1 X88.588 Y97.422 E.00393
; LINE_WIDTH: 0.425721
G1 X88.709 Y97.532 E.00326
; LINE_WIDTH: 0.382184
M73 P86 R3
G1 X88.973 Y97.799 E.00668
; WIPE_START
G1 X88.709 Y97.532 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X93.628 Y96.132 Z5.28 F18000
G1 Z4.88
G1 E.4 F1800
; LINE_WIDTH: 0.096733
G1 F1500
M204 S6000
G1 X93.837 Y96.009 E.00086
; WIPE_START
G1 X93.628 Y96.132 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X85.995 Y96.115 Z5.28 F18000
G1 X79.901 Y96.101 Z5.28
G1 Z4.88
G1 E.4 F1800
; LINE_WIDTH: 0.0988428
G1 F1500
M204 S6000
G1 X80.307 Y96.238 E.00156
M204 S10000
G1 X80.256 Y96.253 F18000
; LINE_WIDTH: 0.153668
G1 F1500
M204 S6000
G1 X79.934 Y96.045 E.00245
G1 X79.807 Y95.89 E.00128
; LINE_WIDTH: 0.145323
G1 X79.767 Y95.819 E.00049
; LINE_WIDTH: 0.117548
G1 X79.723 Y95.737 E.00043
; LINE_WIDTH: 0.0910997
G1 X79.695 Y95.628 E.00037
; WIPE_START
G1 X79.723 Y95.737 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X79.709 Y88.104 Z5.28 F18000
G1 X79.689 Y77.596 Z5.28
G1 Z4.88
G1 E.4 F1800
; LINE_WIDTH: 0.100512
G1 F1500
M204 S6000
G1 X79.737 Y77.434 E.00063
; LINE_WIDTH: 0.1529
G1 X79.794 Y77.324 E.00079
G1 X79.901 Y77.195 E.00106
G1 X80.041 Y77.072 E.00118
; LINE_WIDTH: 0.126908
G1 X80.225 Y76.991 E.00101
; LINE_WIDTH: 0.089683
G1 X80.328 Y76.955 E.00035
; WIPE_START
G1 X80.225 Y76.991 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X86.971 Y80.562 Z5.28 F18000
G1 X99.593 Y87.243 Z5.28
G1 Z4.88
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X100.01 Y86.648 E.01536
G1 X100.306 Y86.855 E.00765
G1 X99.89 Y87.45 E.01536
G1 X99.643 Y87.277 E.00638
M204 S250
G1 X99.048 Y87.308 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X99.909 Y86.078 E.02953
G1 X100.79 Y86.695 E.02115
G1 X100.876 Y86.755 E.00206
G1 X100.015 Y87.985 E.02953
G1 F1739.816
G1 X99.99 Y88.02 E.00085
G1 F2536.476
G1 X99.662 Y87.791 E.00787
G1 X99.037 Y87.353 E.01501
; CHANGE_LAYER
; Z_HEIGHT: 5
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F2536.476
M204 S6000
G1 X99.909 Y86.078 E-.29344
G1 X100.282 Y86.339 E-.08656
; WIPE_END
G1 E-.02 F1800
; layer num/total_layer_count: 41/49
; update layer progress
M73 L41
M991 S0 P40 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z5.28 I.334 J-1.17 P1  F18000
G1 X93.851 Y84.507 Z5.28
G1 Z5
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X93.851 Y77.128 E.15617
G1 X94.036 Y77.076 E.00407
G1 X94.117 Y77.207 E.00325
G1 X94.173 Y77.349 E.00324
G1 X94.202 Y77.49 E.00306
G1 X94.212 Y88.382 E.23052
G1 X93.851 Y88.382 E.00764
G1 X93.851 Y84.567 E.08075
; WIPE_START
M204 S6000
G1 X93.851 Y82.567 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X93.869 Y90.199 Z5.4 F18000
G1 X93.881 Y95.474 Z5.4
G1 Z5
G1 E.4 F1800
G1 F1500
M204 S500
G1 X93.893 Y95.431 E.00093
G1 X93.954 Y95.367 E.00188
G1 X94.157 Y95.318 E.00442
G1 X94.183 Y95.468 E.00322
G1 X94.169 Y95.572 E.00223
G1 X94.135 Y95.614 E.00114
G1 X93.858 Y95.743 E.00647
G1 X93.876 Y95.534 E.00445
; WIPE_START
M204 S6000
G1 X93.893 Y95.431 E-.03202
G1 X93.954 Y95.367 E-.02746
G1 X94.157 Y95.318 E-.06456
G1 X94.183 Y95.468 E-.04712
G1 X94.169 Y95.572 E-.03253
G1 X94.135 Y95.614 E-.01669
G1 X93.858 Y95.743 E-.09454
G1 X93.876 Y95.534 E-.06507
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X88.051 Y97.115 Z5.4 F18000
G1 Z5
G1 E.4 F1800
G1 F1500
M204 S500
G1 X87.93 Y97.059 E.00282
G1 X87.436 Y96.915 E.01089
G1 X87.061 Y96.864 E.00801
G1 X86.705 Y96.858 E.00752
G1 X86.157 Y96.929 E.01171
G1 X85.597 Y97.11 E.01245
G1 X85.491 Y96.949 E.0041
G1 X85.842 Y96.544 E.01135
G1 X87.821 Y96.544 E.04188
G1 X88.175 Y96.951 E.01141
G1 X88.087 Y97.068 E.00309
; WIPE_START
M204 S6000
G1 X87.93 Y97.059 E-.02988
G1 X87.436 Y96.915 E-.09779
G1 X87.061 Y96.864 E-.07194
G1 X86.705 Y96.858 E-.06751
G1 X86.157 Y96.929 E-.10509
G1 X86.118 Y96.941 E-.00779
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X88.991 Y101.378 Z5.4 F18000
G1 Z5
G1 E.4 F1800
G1 F1500
M204 S500
G1 X88.904 Y101.504 E.00326
G1 X88.692 Y101.747 E.00681
G1 X88.339 Y102.046 E.0098
G1 X87.92 Y102.285 E.01021
G1 X87.64 Y102.393 E.00634
G1 X87.329 Y102.474 E.00681
G1 X86.869 Y102.523 E.00979
G1 X86.388 Y102.483 E.01021
G1 X86.096 Y102.416 E.00634
G1 X85.793 Y102.307 E.00681
G1 X85.387 Y102.089 E.00975
G1 X85.018 Y101.795 E.01
G1 X84.703 Y101.429 E.01021
G1 X84.543 Y101.176 E.00634
G1 X84.403 Y100.886 E.0068
G1 X84.267 Y100.446 E.00975
G1 X84.211 Y99.979 E.00995
G1 X84.239 Y99.508 E.00999
G1 X84.357 Y99.04 E.01022
G1 X84.471 Y98.763 E.00634
G1 X84.628 Y98.482 E.00681
G1 X84.904 Y98.125 E.00955
G1 X85.137 Y97.903 E.00681
G1 X85.376 Y97.722 E.00634
G1 X85.799 Y97.491 E.01021
G1 X86.25 Y97.344 E.01004
G1 X86.729 Y97.283 E.01021
G1 X87.028 Y97.288 E.00634
G1 X87.347 Y97.331 E.00681
G1 X87.78 Y97.458 E.00955
G1 X88.073 Y97.593 E.00683
G1 X88.348 Y97.763 E.00683
G1 X88.699 Y98.061 E.00975
G1 X88.992 Y98.417 E.00975
G1 X89.157 Y98.694 E.00683
G1 X89.289 Y98.989 E.00683
G1 X89.411 Y99.433 E.00975
G1 X89.453 Y99.901 E.00995
G1 X89.411 Y100.369 E.00995
G1 X89.286 Y100.824 E.00999
G1 X89.073 Y101.258 E.01022
G1 X89.025 Y101.328 E.00181
M204 S250
G1 X88.654 Y101.146 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X88.58 Y101.253 E.00256
G1 X88.404 Y101.454 E.00526
G1 X88.104 Y101.709 E.00775
G1 X87.743 Y101.914 E.00815
G1 X87.514 Y102.003 E.00483
G1 X87.256 Y102.07 E.00526
G1 X86.864 Y102.112 E.00775
G1 X86.451 Y102.078 E.00815
G1 X86.211 Y102.022 E.00483
G1 X85.96 Y101.932 E.00525
G1 X85.614 Y101.746 E.00773
G1 X85.303 Y101.498 E.00781
G1 X85.033 Y101.184 E.00815
G1 X84.901 Y100.977 E.00483
G1 X84.785 Y100.736 E.00525
G1 X84.669 Y100.361 E.00774
G1 X84.622 Y99.967 E.0078
G1 X84.646 Y99.571 E.00781
G1 X84.746 Y99.169 E.00815
G1 X84.84 Y98.942 E.00483
G1 X84.97 Y98.708 E.00526
G1 X85.209 Y98.4 E.00767
G1 X85.402 Y98.215 E.00525
G1 X85.598 Y98.067 E.00483
G1 X85.962 Y97.868 E.00815
G1 X86.34 Y97.745 E.00783
G1 X86.751 Y97.692 E.00815
G1 X86.997 Y97.697 E.00483
G1 X87.262 Y97.733 E.00526
G1 X87.636 Y97.842 E.00767
G1 X87.879 Y97.954 E.00526
G1 X88.107 Y98.095 E.00527
G1 X88.407 Y98.349 E.00773
G1 X88.656 Y98.653 E.00773
G1 X88.794 Y98.883 E.00526
G1 X88.902 Y99.127 E.00526
G1 X89.007 Y99.506 E.00774
G1 X89.042 Y99.901 E.00779
G1 X89.007 Y100.296 E.00779
G1 X88.901 Y100.678 E.00781
G1 X88.719 Y101.051 E.00815
G1 X88.688 Y101.097 E.00109
; WIPE_START
M204 S6000
G1 X88.58 Y101.253 E-.0361
G1 X88.404 Y101.454 E-.05079
G1 X88.104 Y101.709 E-.07486
G1 X87.743 Y101.914 E-.07874
G1 X87.514 Y102.003 E-.04669
G1 X87.256 Y102.07 E-.05077
G1 X87.036 Y102.094 E-.04206
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X88.075 Y96.12 Z5.4 F18000
G1 Z5
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X93.399 Y96.12 E.11269
G1 X93.462 Y95.4 E.01529
G1 X93.488 Y95.303 E.00213
G1 X93.556 Y95.17 E.00317
G1 X93.667 Y95.053 E.0034
G1 X93.824 Y94.962 E.00386
G1 X94.262 Y94.857 E.00952
G1 X98.432 Y88.902 E.15386
G1 X98.728 Y89.109 E.00765
G1 X94.546 Y95.081 E.1543
G1 X94.609 Y95.529 E.00958
G1 X94.564 Y95.728 E.00431
G1 X94.51 Y95.826 E.00236
G1 X94.403 Y95.946 E.00341
G1 X94.31 Y96.008 E.00236
G1 X94.079 Y96.109 E.00535
G1 X93.852 Y96.308 E.00638
G1 X93.723 Y96.387 E.00321
G1 X93.582 Y96.443 E.00321
G1 X93.441 Y96.472 E.00304
G1 X88.332 Y96.485 E.10814
G1 X89.515 Y97.845 E.03814
G1 X89.627 Y98 E.00405
G1 X89.919 Y98.526 E.01273
G1 X90.06 Y98.902 E.0085
G1 X90.156 Y99.291 E.00849
G1 X90.212 Y99.887 E.01268
G1 X90.159 Y100.497 E.01296
G1 X90.003 Y101.07 E.01256
G1 X89.842 Y101.437 E.00849
G1 X89.528 Y101.94 E.01254
G1 X89.262 Y102.249 E.00864
G1 X88.934 Y102.546 E.00936
G1 X88.475 Y102.855 E.01172
G1 X88.104 Y103.032 E.00869
G1 X87.724 Y103.161 E.00849
G1 X87.331 Y103.243 E.0085
G1 X86.932 Y103.279 E.00849
G1 X86.531 Y103.267 E.00849
G1 X85.95 Y103.164 E.01249
G1 X85.523 Y103.016 E.00956
G1 X85.189 Y102.855 E.00785
G1 X84.698 Y102.522 E.01256
G1 X84.403 Y102.251 E.00849
G1 X84.141 Y101.947 E.00849
G1 X83.918 Y101.613 E.00849
G1 X83.737 Y101.258 E.00845
G1 X83.587 Y100.842 E.00936
G1 X83.475 Y100.3 E.01172
G1 X83.452 Y99.89 E.00869
G1 X83.477 Y99.49 E.00849
G1 X83.549 Y99.095 E.00849
G1 X83.668 Y98.712 E.00849
G1 X83.831 Y98.345 E.00849
G1 X84.149 Y97.845 E.01253
G1 X85.335 Y96.482 E.03825
G1 X80.368 Y96.482 E.10513
G1 X80.13 Y96.454 E.00508
G1 X79.93 Y96.381 E.0045
G1 X79.799 Y96.301 E.00324
G1 X79.621 Y96.119 E.00539
G1 X79.507 Y95.904 E.00514
G1 X79.481 Y95.819 E.00189
G1 X79.451 Y95.565 E.00542
G1 X79.451 Y77.628 E.37965
G1 X79.487 Y77.357 E.00578
G1 X79.592 Y77.125 E.0054
G1 X79.769 Y76.926 E.00564
G1 X79.891 Y76.841 E.00316
G1 X80.038 Y76.772 E.00341
G1 X80.288 Y76.723 E.00541
G1 X93.36 Y76.722 E.27668
G1 X93.536 Y76.747 E.00376
G1 X93.68 Y76.794 E.0032
G1 X93.856 Y76.889 E.00424
G1 X93.807 Y77.082 E.0042
G1 X80.778 Y77.082 E.27579
G1 X80.489 Y77.132 E.0062
G1 X80.219 Y77.278 E.00649
G1 X80.002 Y77.495 E.00649
G1 X79.85 Y77.798 E.00717
G1 X79.812 Y78.056 E.00552
G1 X79.812 Y95.137 E.36154
G1 X79.837 Y95.346 E.00446
G1 X79.943 Y95.614 E.0061
G1 X80.122 Y95.84 E.0061
G1 X80.321 Y95.988 E.00526
G1 X80.554 Y96.087 E.00534
G1 X80.788 Y96.12 E.00501
G1 X88.015 Y96.12 E.15297
; WIPE_START
M204 S6000
G1 X90.015 Y96.12 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X89.228 Y96.892 Z5.4 F18000
G1 Z5
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X89.835 Y97.59 E.01819
G1 X89.966 Y97.77 E.00437
G1 X90.085 Y97.957 E.00437
G1 X90.293 Y98.359 E.00891
G1 X90.452 Y98.78 E.00885
G1 X90.559 Y99.217 E.00885
G1 X90.614 Y99.667 E.00891
G1 X90.612 Y100.151 E.00953
G1 X90.563 Y100.563 E.00816
G1 X90.519 Y100.778 E.00431
G1 X90.387 Y101.212 E.00891
G1 X90.207 Y101.624 E.00885
G1 X89.977 Y102.014 E.00891
G1 X89.85 Y102.192 E.00431
G1 X89.556 Y102.535 E.00889
G1 X89.191 Y102.865 E.00967
G1 X88.856 Y103.105 E.0081
G1 X88.667 Y103.216 E.00431
G1 X88.259 Y103.412 E.00891
G1 X87.833 Y103.556 E.00885
G1 X87.392 Y103.649 E.00885
G1 X86.944 Y103.689 E.00884
G1 X86.494 Y103.676 E.00885
G1 X86.046 Y103.608 E.00891
G1 X85.835 Y103.557 E.00429
G1 X85.367 Y103.395 E.00973
G1 X84.996 Y103.217 E.0081
G1 X84.807 Y103.105 E.00431
G1 X84.44 Y102.84 E.00891
G1 X84.108 Y102.536 E.00885
G1 X83.815 Y102.195 E.00885
G1 X83.565 Y101.821 E.00885
G1 X83.36 Y101.421 E.00884
G1 X83.194 Y100.959 E.00967
G1 X83.099 Y100.558 E.0081
G1 X83.067 Y100.341 E.00431
G1 X83.042 Y99.889 E.00891
G1 X83.07 Y99.44 E.00885
G1 X83.151 Y98.997 E.00885
G1 X83.284 Y98.567 E.00885
G1 X83.467 Y98.156 E.00885
G1 X83.7 Y97.767 E.00891
G1 X83.828 Y97.59 E.0043
G1 X84.436 Y96.891 E.01823
G1 X80.344 Y96.891 E.08049
G1 X80.034 Y96.855 E.00613
G1 X79.75 Y96.751 E.00595
G1 X79.559 Y96.633 E.00442
G1 X79.449 Y96.541 E.00283
G1 X79.296 Y96.369 E.00454
G1 X79.216 Y96.248 E.00284
G1 X79.124 Y96.052 E.00425
G1 X79.078 Y95.903 E.00306
G1 X79.042 Y95.589 E.00623
G1 X79.042 Y77.61 E.35362
G1 X79.062 Y77.374 E.00466
G1 X79.095 Y77.234 E.00283
G1 X79.181 Y77.02 E.00454
G1 X79.253 Y76.895 E.00283
G1 X79.395 Y76.714 E.00452
G1 X79.512 Y76.606 E.00312
G1 X79.687 Y76.485 E.00419
G1 X79.893 Y76.388 E.00447
G1 X80.045 Y76.344 E.00312
G1 X80.259 Y76.313 E.00425
G1 X93.389 Y76.313 E.25825
G1 X93.63 Y76.347 E.00478
G1 X93.842 Y76.417 E.00441
G1 X94.04 Y76.524 E.00442
G1 X94.216 Y76.663 E.00442
G1 X94.366 Y76.831 E.00442
G1 X94.484 Y77.022 E.00442
G1 X94.567 Y77.231 E.00442
G1 X94.612 Y77.448 E.00436
G1 X94.621 Y88.791 E.2231
G1 X93.442 Y88.791 E.02321
G1 X93.442 Y77.491 E.22226
G1 X80.813 Y77.491 E.24839
G1 X80.625 Y77.524 E.00376
G1 X80.466 Y77.61 E.00355
G1 X80.338 Y77.738 E.00355
G1 X80.246 Y77.922 E.00407
G1 X80.222 Y78.086 E.00325
G1 X80.222 Y95.113 E.33492
M73 P87 R3
G1 X80.237 Y95.245 E.00261
G1 X80.301 Y95.407 E.00343
G1 X80.41 Y95.544 E.00343
G1 X80.526 Y95.631 E.00286
G1 X80.664 Y95.689 E.00294
G1 X80.817 Y95.711 E.00303
G1 X93.024 Y95.711 E.24011
G1 X93.057 Y95.329 E.00753
G1 X93.102 Y95.163 E.00338
G1 X93.234 Y94.916 E.00551
G1 X93.397 Y94.742 E.00469
G1 X93.535 Y94.645 E.00332
G1 X93.689 Y94.573 E.00333
G1 X94.016 Y94.495 E.00662
G1 X98.306 Y88.367 E.14713
G1 F1739.897
G1 X98.331 Y88.332 E.00085
G1 F2536.476
G1 X98.659 Y88.562 E.00787
G1 X98.97 Y88.779 E.00747
G1 X99.298 Y89.009 E.00787
G1 F1739.897
G1 X99.273 Y89.044 E.00085
G1 F1500
G1 X94.978 Y95.178 E.14727
G1 X95.015 Y95.387 E.00418
G1 X95.019 Y95.562 E.00344
G1 X94.975 Y95.8 E.00476
G1 X94.85 Y96.056 E.0056
G1 X94.656 Y96.269 E.00566
G1 X94.508 Y96.368 E.0035
G1 X94.301 Y96.459 E.00445
G1 X94.096 Y96.639 E.00538
G1 X93.906 Y96.755 E.00438
G1 X93.698 Y96.837 E.00438
G1 X93.483 Y96.881 E.00433
G1 X89.288 Y96.892 E.0825
; WIPE_START
M204 S6000
G1 X89.835 Y97.59 E-.16851
G1 X89.966 Y97.77 E-.04218
G1 X90.085 Y97.957 E-.04218
G1 X90.293 Y98.359 E-.08608
G1 X90.369 Y98.561 E-.04105
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




G1 X88.959 Y97.784
G1 Z5
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.360457
G1 F1500
M204 S6000
G1 X89.293 Y98.189 E.00877
G1 X89.487 Y98.512 E.00628
G1 X89.647 Y98.873 E.0066
G1 X89.783 Y99.357 E.00839
G1 X89.833 Y99.892 E.00897
G1 X89.821 Y100.088 E.00328
G1 X89.748 Y100.587 E.00843
G1 X89.633 Y100.972 E.00671
G1 X89.402 Y101.436 E.00865
G1 X89.209 Y101.729 E.00586
G1 X88.966 Y102.007 E.00617
G1 X88.566 Y102.344 E.00874
G1 X88.092 Y102.62 E.00914
G1 X87.747 Y102.755 E.00619
G1 X87.384 Y102.847 E.00626
G1 X86.858 Y102.9 E.00883
G1 X86.342 Y102.855 E.00865
G1 X85.999 Y102.781 E.00586
G1 X85.628 Y102.647 E.00658
G1 X85.17 Y102.392 E.00876
G1 X84.768 Y102.076 E.00853
G1 X84.446 Y101.715 E.00808
G1 X84.217 Y101.368 E.00694
G1 X84.048 Y101.013 E.00657
G1 X83.905 Y100.538 E.00828
G1 X83.835 Y100.005 E.00897
G1 X83.856 Y99.536 E.00784
G1 X83.924 Y99.187 E.00594
G1 X84.025 Y98.846 E.00594
G1 X84.169 Y98.523 E.00591
G1 X84.31 Y98.286 E.00459
G1 X84.616 Y97.882 E.00847
G1 X84.874 Y97.61 E.00626
; LINE_WIDTH: 0.40582
G1 X85.01 Y97.483 E.00353
; LINE_WIDTH: 0.44227
G1 X85.13 Y97.37 E.00342
; LINE_WIDTH: 0.477188
G1 X85.381 Y97.167 E.00727
; WIPE_START
G1 X85.13 Y97.37 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X88.281 Y97.162 Z5.4 F18000
G1 Z5
G1 E.4 F1800
; LINE_WIDTH: 0.468109
G1 F1500
M204 S6000
G1 X88.579 Y97.411 E.00858
; LINE_WIDTH: 0.419299
G1 X88.782 Y97.609 E.00556
; LINE_WIDTH: 0.378817
G1 X88.959 Y97.784 E.00438
; WIPE_START
G1 X88.782 Y97.609 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X93.61 Y96.144 Z5.4 F18000
G1 Z5
G1 E.4 F1800
; LINE_WIDTH: 0.109727
G1 F1500
M204 S6000
G1 X93.837 Y96.009 E.0011
; WIPE_START
G1 X93.61 Y96.144 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X85.978 Y96.198 Z5.4 F18000
G1 X80.307 Y96.238 Z5.4
G1 Z5
G1 E.4 F1800
; LINE_WIDTH: 0.0930045
G1 F1500
M204 S6000
G1 X80.188 Y96.205 E.00041
; LINE_WIDTH: 0.131113
G1 X80.052 Y96.132 E.00081
; LINE_WIDTH: 0.15506
G1 X79.92 Y96.035 E.00105
G1 X79.683 Y95.694 E.00268
M204 S10000
G1 X79.695 Y95.628 F18000
; LINE_WIDTH: 0.0952146
G1 F1500
M204 S6000
G1 X79.835 Y96.04 E.00151
; WIPE_START
G1 X79.695 Y95.628 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X79.692 Y87.996 Z5.4 F18000
G1 X79.688 Y77.598 Z5.4
G1 Z5
G1 E.4 F1800
; LINE_WIDTH: 0.102609
G1 F1500
M204 S6000
G1 X79.739 Y77.434 E.00066
; LINE_WIDTH: 0.145374
G1 X79.793 Y77.321 E.00075
G1 X79.952 Y77.144 E.00142
G1 X80.051 Y77.066 E.00075
G1 X80.189 Y76.999 E.00092
; LINE_WIDTH: 0.100303
G1 X80.326 Y76.954 E.00054
; WIPE_START
G1 X80.189 Y76.999 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X86.925 Y80.588 Z5.4 F18000
G1 X99.545 Y87.311 Z5.4
G1 Z5
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X100.01 Y86.648 E.01714
G1 X100.306 Y86.855 E.00765
G1 X99.841 Y87.519 E.01714
G1 X99.594 Y87.346 E.00638
M204 S250
G1 X99 Y87.377 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X99.909 Y86.078 E.03118
G1 X100.816 Y86.713 E.02178
G1 X100.876 Y86.755 E.00143
G1 X99.967 Y88.054 E.03118
G1 F1739.736
G1 X99.942 Y88.089 E.00085
G1 F2536.476
G1 X99.614 Y87.859 E.00787
G1 X98.989 Y87.422 E.01501
; CHANGE_LAYER
; Z_HEIGHT: 5.12
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F2536.476
M204 S6000
G1 X99.909 Y86.078 E-.3094
G1 X100.214 Y86.291 E-.0706
; WIPE_END
G1 E-.02 F1800
; layer num/total_layer_count: 42/49
; update layer progress
M73 L42
M991 S0 P41 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z5.4 I.329 J-1.172 P1  F18000
G1 X93.851 Y84.507 Z5.4
G1 Z5.12
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X93.851 Y77.128 E.15617
G1 X94.036 Y77.076 E.00407
G1 X94.117 Y77.207 E.00325
G1 X94.173 Y77.349 E.00324
G1 X94.202 Y77.49 E.00306
G1 X94.212 Y88.382 E.23052
G1 X93.851 Y88.382 E.00764
G1 X93.851 Y84.567 E.08075
; WIPE_START
M204 S6000
G1 X93.851 Y82.567 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X93.871 Y90.199 Z5.52 F18000
G1 X93.884 Y95.44 Z5.52
G1 Z5.12
G1 E.4 F1800
G1 F1500
M204 S500
G1 X93.953 Y95.367 E.00212
G1 X94.159 Y95.318 E.00449
G1 X94.183 Y95.484 E.00355
G1 X94.136 Y95.621 E.00306
G1 X93.858 Y95.743 E.00642
G1 X93.879 Y95.5 E.00516
; WIPE_START
M204 S6000
G1 X93.953 Y95.367 E-.04721
G1 X94.159 Y95.318 E-.06584
G1 X94.183 Y95.484 E-.05212
G1 X94.136 Y95.621 E-.04494
G1 X93.858 Y95.743 E-.0942
G1 X93.879 Y95.5 E-.07568
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X88.051 Y97.116 Z5.52 F18000
G1 Z5.12
G1 E.4 F1800
G1 F1500
M204 S500
G1 X87.93 Y97.059 E.00282
G1 X87.436 Y96.915 E.01089
G1 X87.061 Y96.864 E.00802
G1 X86.703 Y96.858 E.00758
G1 X86.156 Y96.929 E.01166
G1 X85.597 Y97.11 E.01245
G1 X85.49 Y96.949 E.0041
G1 X85.842 Y96.544 E.01135
G1 X87.821 Y96.544 E.04188
G1 X88.175 Y96.951 E.01141
G1 X88.087 Y97.068 E.00309
; WIPE_START
M204 S6000
G1 X87.93 Y97.059 E-.02988
G1 X87.436 Y96.915 E-.09779
G1 X87.061 Y96.864 E-.07197
G1 X86.703 Y96.858 E-.06802
G1 X86.156 Y96.929 E-.10463
G1 X86.118 Y96.941 E-.0077
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X88.972 Y101.409 Z5.52 F18000
G1 Z5.12
G1 E.4 F1800
G1 F1500
M204 S500
G1 X88.699 Y101.741 E.0091
G1 X88.341 Y102.045 E.00995
G1 X87.942 Y102.275 E.00975
G1 X87.641 Y102.393 E.00683
G1 X87.329 Y102.474 E.00683
G1 X86.869 Y102.523 E.00979
G1 X86.39 Y102.484 E.01016
G1 X86.096 Y102.416 E.0064
G1 X85.793 Y102.307 E.00681
G1 X85.387 Y102.089 E.00975
G1 X85.02 Y101.796 E.00995
G1 X84.717 Y101.449 E.00975
G1 X84.543 Y101.177 E.00683
G1 X84.403 Y100.886 E.00683
G1 X84.267 Y100.446 E.00976
G1 X84.211 Y99.979 E.00994
G1 X84.239 Y99.508 E.00999
G1 X84.356 Y99.043 E.01016
G1 X84.471 Y98.763 E.00639
G1 X84.628 Y98.482 E.00682
G1 X84.91 Y98.118 E.00975
G1 X85.252 Y97.809 E.00975
G1 X85.521 Y97.632 E.00683
G1 X85.81 Y97.487 E.00683
G1 X86.25 Y97.344 E.00979
G1 X86.726 Y97.283 E.01016
G1 X87.028 Y97.288 E.00639
G1 X87.347 Y97.331 E.00682
G1 X87.78 Y97.458 E.00955
G1 X88.073 Y97.593 E.00683
G1 X88.348 Y97.763 E.00683
G1 X88.699 Y98.061 E.00976
G1 X88.992 Y98.417 E.00975
G1 X89.157 Y98.694 E.00683
G1 X89.289 Y98.989 E.00683
G1 X89.411 Y99.433 E.00975
G1 X89.453 Y99.901 E.00995
G1 X89.412 Y100.36 E.00975
G1 X89.336 Y100.672 E.00681
G1 X89.23 Y100.956 E.0064
G1 X89.008 Y101.361 E.00978
M204 S250
G1 X88.656 Y101.149 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X88.407 Y101.452 E.00773
G1 X88.104 Y101.709 E.0078
G1 X87.764 Y101.905 E.00773
G1 X87.515 Y102.003 E.00526
G1 X87.256 Y102.07 E.00526
G1 X86.864 Y102.112 E.00775
G1 X86.453 Y102.078 E.0081
G1 X86.212 Y102.022 E.00488
G1 X85.96 Y101.932 E.00526
G1 X85.614 Y101.746 E.00773
G1 X85.304 Y101.499 E.0078
G1 X85.045 Y101.203 E.00773
G1 X84.901 Y100.977 E.00526
G1 X84.785 Y100.736 E.00526
G1 X84.669 Y100.36 E.00774
G1 X84.622 Y99.967 E.00779
G1 X84.646 Y99.571 E.00781
G1 X84.746 Y99.171 E.0081
G1 X84.84 Y98.942 E.00488
G1 X84.97 Y98.708 E.00526
G1 X85.211 Y98.397 E.00773
M73 P87 R2
G1 X85.503 Y98.134 E.00773
G1 X85.726 Y97.987 E.00526
G1 X85.966 Y97.867 E.00526
G1 X86.34 Y97.745 E.00775
G1 X86.749 Y97.692 E.0081
G1 X86.997 Y97.697 E.00488
G1 X87.262 Y97.733 E.00526
G1 X87.636 Y97.842 E.00767
G1 X87.879 Y97.954 E.00526
G1 X88.107 Y98.095 E.00526
G1 X88.407 Y98.349 E.00774
G1 X88.656 Y98.653 E.00773
G1 X88.794 Y98.883 E.00526
G1 X88.902 Y99.127 E.00526
G1 X89.007 Y99.506 E.00773
G1 X89.042 Y99.901 E.0078
G1 X89.007 Y100.292 E.00773
G1 X88.944 Y100.552 E.00526
G1 X88.857 Y100.785 E.00488
G1 X88.686 Y101.097 E.00701
; WIPE_START
M204 S6000
G1 X88.407 Y101.452 E-.08589
G1 X88.104 Y101.709 E-.07532
G1 X87.764 Y101.905 E-.07468
G1 X87.515 Y102.003 E-.05085
G1 X87.256 Y102.07 E-.05081
G1 X87.034 Y102.094 E-.04245
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X88.075 Y96.12 Z5.52 F18000
G1 Z5.12
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X93.399 Y96.12 E.11268
G1 X93.463 Y95.392 E.01548
G1 X93.515 Y95.242 E.00335
G1 X93.563 Y95.163 E.00196
G1 X93.661 Y95.058 E.00302
G1 X93.825 Y94.962 E.00403
G1 X94.262 Y94.857 E.00952
G1 X98.48 Y88.833 E.15564
G1 X98.776 Y89.041 E.00765
G1 X94.552 Y95.072 E.15585
G1 X94.61 Y95.512 E.00939
G1 X94.57 Y95.704 E.00416
M73 P88 R2
G1 X94.499 Y95.842 E.00328
G1 X94.395 Y95.951 E.00317
G1 X94.31 Y96.008 E.00217
G1 X94.079 Y96.109 E.00535
G1 X93.852 Y96.308 E.00638
G1 X93.723 Y96.387 E.00322
G1 X93.581 Y96.443 E.00321
G1 X93.441 Y96.472 E.00304
G1 X88.332 Y96.485 E.10814
G1 X89.515 Y97.845 E.03814
G1 X89.627 Y98 E.00405
G1 X89.919 Y98.526 E.01274
G1 X90.06 Y98.901 E.00849
G1 X90.186 Y99.48 E.01254
G1 X90.211 Y99.89 E.00869
G1 X90.161 Y100.489 E.01273
G1 X90.003 Y101.07 E.01273
G1 X89.839 Y101.444 E.00864
G1 X89.522 Y101.946 E.01257
G1 X89.262 Y102.25 E.00847
G1 X88.937 Y102.543 E.00926
G1 X88.475 Y102.855 E.01181
G1 X88.104 Y103.032 E.00869
G1 X87.715 Y103.164 E.00869
G1 X87.132 Y103.267 E.01254
G1 X86.731 Y103.279 E.00849
G1 X86.332 Y103.243 E.00849
G1 X85.939 Y103.161 E.00849
G1 X85.559 Y103.032 E.0085
G1 X85.197 Y102.859 E.00849
G1 X84.858 Y102.644 E.00849
G1 X84.409 Y102.258 E.01254
G1 X84.141 Y101.947 E.00869
G1 X83.918 Y101.613 E.00849
G1 X83.736 Y101.258 E.00845
G1 X83.588 Y100.846 E.00926
G1 X83.475 Y100.3 E.01181
G1 X83.452 Y99.89 E.00869
G1 X83.477 Y99.49 E.00849
G1 X83.549 Y99.095 E.00849
G1 X83.668 Y98.712 E.00849
G1 X83.834 Y98.339 E.00864
G1 X84.154 Y97.838 E.01257
G1 X85.334 Y96.482 E.03806
G1 X80.368 Y96.482 E.10512
G1 X80.12 Y96.453 E.00527
G1 X79.975 Y96.405 E.00324
G1 X79.768 Y96.275 E.00517
G1 X79.598 Y96.085 E.00539
G1 X79.479 Y95.803 E.00649
G1 X79.451 Y95.565 E.00508
G1 X79.451 Y77.628 E.37964
G1 X79.488 Y77.351 E.00593
G1 X79.597 Y77.119 E.00541
G1 X79.768 Y76.927 E.00545
G1 X79.892 Y76.841 E.00319
G1 X80.038 Y76.772 E.00342
G1 X80.288 Y76.723 E.00541
G1 X93.362 Y76.722 E.27671
G1 X93.536 Y76.747 E.00372
G1 X93.68 Y76.794 E.0032
G1 X93.856 Y76.889 E.00424
G1 X93.807 Y77.082 E.0042
G1 X80.777 Y77.082 E.27579
G1 X80.489 Y77.133 E.0062
G1 X80.211 Y77.282 E.00668
G1 X79.979 Y77.529 E.00717
G1 X79.849 Y77.807 E.00649
G1 X79.812 Y78.056 E.00533
G1 X79.812 Y95.137 E.36153
G1 X79.837 Y95.346 E.00445
G1 X79.94 Y95.605 E.00591
G1 X80.093 Y95.811 E.00542
G1 X80.319 Y95.989 E.0061
G1 X80.587 Y96.096 E.0061
G1 X80.796 Y96.12 E.00446
G1 X88.015 Y96.12 E.15281
; WIPE_START
M204 S6000
G1 X90.015 Y96.12 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X89.228 Y96.892 Z5.52 F18000
G1 Z5.12
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X89.835 Y97.59 E.01819
G1 X89.966 Y97.77 E.00436
G1 X90.085 Y97.957 E.00437
G1 X90.294 Y98.359 E.00891
G1 X90.452 Y98.78 E.00885
G1 X90.56 Y99.22 E.00891
G1 X90.593 Y99.437 E.00431
G1 X90.621 Y99.889 E.00891
G1 X90.596 Y100.341 E.00891
G1 X90.564 Y100.56 E.00436
G1 X90.519 Y100.778 E.00437
G1 X90.387 Y101.212 E.00891
G1 X90.206 Y101.626 E.0089
G1 X90.081 Y101.849 E.00503
G1 X89.848 Y102.195 E.0082
G1 X89.555 Y102.536 E.00884
G1 X89.195 Y102.862 E.00957
G1 X88.856 Y103.105 E.00819
G1 X88.668 Y103.216 E.00431
G1 X88.259 Y103.412 E.00891
G1 X87.829 Y103.557 E.00891
G1 X87.617 Y103.608 E.0043
G1 X87.169 Y103.676 E.00891
G1 X86.719 Y103.689 E.00885
G1 X86.271 Y103.649 E.00885
G1 X85.831 Y103.556 E.00885
G1 X85.405 Y103.412 E.00885
G1 X84.999 Y103.218 E.00885
G1 X84.618 Y102.977 E.00885
G1 X84.267 Y102.691 E.0089
G1 X84.11 Y102.538 E.00431
G1 X83.815 Y102.195 E.00891
G1 X83.564 Y101.821 E.00885
G1 X83.36 Y101.421 E.00884
G1 X83.195 Y100.963 E.00957
G1 X83.099 Y100.558 E.0082
G1 X83.067 Y100.341 E.00431
G1 X83.042 Y99.889 E.00891
G1 X83.07 Y99.44 E.00885
G1 X83.151 Y98.997 E.00885
G1 X83.284 Y98.567 E.00885
G1 X83.468 Y98.154 E.0089
G1 X83.595 Y97.932 E.00503
G1 X83.83 Y97.588 E.0082
G1 X84.436 Y96.891 E.01817
G1 X80.344 Y96.891 E.08049
G1 X80.031 Y96.854 E.00619
G1 X79.818 Y96.784 E.00442
G1 X79.689 Y96.719 E.00284
G1 X79.51 Y96.595 E.00428
G1 X79.395 Y96.487 E.0031
G1 X79.26 Y96.317 E.00427
G1 X79.182 Y96.184 E.00303
G1 X79.078 Y95.898 E.00599
G1 X79.042 Y95.589 E.00613
G1 X79.042 Y77.61 E.35362
G1 X79.062 Y77.374 E.00466
G1 X79.096 Y77.232 E.00287
G1 X79.152 Y77.081 E.00315
G1 X79.254 Y76.893 E.00422
G1 X79.395 Y76.714 E.00447
G1 X79.51 Y76.607 E.00309
G1 X79.687 Y76.485 E.00423
G1 X79.893 Y76.388 E.00448
G1 X80.044 Y76.344 E.00309
G1 X80.259 Y76.313 E.00428
G1 X93.39 Y76.313 E.25828
G1 X93.629 Y76.347 E.00475
G1 X93.842 Y76.417 E.00441
G1 X94.04 Y76.524 E.00442
G1 X94.216 Y76.663 E.00442
G1 X94.366 Y76.831 E.00442
G1 X94.484 Y77.022 E.00442
G1 X94.567 Y77.231 E.00442
G1 X94.612 Y77.448 E.00436
G1 X94.621 Y88.791 E.2231
G1 X93.442 Y88.791 E.02321
G1 X93.442 Y77.491 E.22226
G1 X80.813 Y77.491 E.24839
G1 X80.625 Y77.524 E.00376
G1 X80.463 Y77.611 E.00361
G1 X80.322 Y77.762 E.00406
G1 X80.245 Y77.925 E.00356
G1 X80.222 Y78.086 E.00319
G1 X80.222 Y95.113 E.33491
G1 X80.237 Y95.245 E.00261
G1 X80.3 Y95.404 E.00337
G1 X80.389 Y95.523 E.00292
G1 X80.526 Y95.631 E.00343
G1 X80.688 Y95.695 E.00343
G1 X80.819 Y95.711 E.00261
G1 X93.024 Y95.711 E.24005
G1 X93.058 Y95.326 E.00759
G1 X93.083 Y95.22 E.00214
G1 X93.147 Y95.058 E.00344
G1 X93.236 Y94.913 E.00333
G1 X93.39 Y94.749 E.00443
G1 X93.536 Y94.645 E.00353
G1 X93.689 Y94.573 E.00332
G1 X94.016 Y94.495 E.00662
G1 X98.355 Y88.299 E.14879
G1 F1739.85
G1 X98.379 Y88.263 E.00085
G1 F2536.476
G1 X98.707 Y88.493 E.00787
G1 X99.018 Y88.711 E.00747
G1 X99.346 Y88.94 E.00787
G1 F1739.816
G1 X99.321 Y88.975 E.00085
G1 F1500
G1 X94.98 Y95.175 E.14885
G1 X95.019 Y95.556 E.00754
G1 X94.959 Y95.842 E.00575
G1 X94.846 Y96.062 E.00485
G1 X94.653 Y96.27 E.00558
G1 X94.508 Y96.368 E.00344
G1 X94.301 Y96.459 E.00444
G1 X94.096 Y96.639 E.00538
G1 X93.906 Y96.755 E.00438
G1 X93.698 Y96.837 E.00438
G1 X93.483 Y96.881 E.00432
G1 X89.288 Y96.892 E.0825
; WIPE_START
M204 S6000
G1 X89.835 Y97.59 E-.16851
G1 X89.966 Y97.77 E-.04216
G1 X90.085 Y97.957 E-.0422
G1 X90.294 Y98.359 E-.0861
G1 X90.37 Y98.561 E-.04104
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




G1 X88.959 Y97.784
G1 Z5.12
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.360414
G1 F1500
M204 S6000
G1 X89.293 Y98.189 E.00877
G1 X89.487 Y98.512 E.00628
G1 X89.647 Y98.873 E.0066
G1 X89.785 Y99.369 E.00859
G1 X89.832 Y99.893 E.00879
G1 X89.806 Y100.259 E.00612
G1 X89.75 Y100.585 E.00553
G1 X89.578 Y101.102 E.00909
G1 X89.497 Y101.268 E.0031
G1 X89.216 Y101.715 E.00882
G1 X88.958 Y102.016 E.00662
G1 X88.544 Y102.359 E.00897
G1 X88.094 Y102.62 E.00868
G1 X87.614 Y102.795 E.00853
G1 X87.096 Y102.884 E.00878
G1 X86.743 Y102.896 E.0059
G1 X86.345 Y102.86 E.00667
G1 X85.98 Y102.776 E.00624
G1 X85.628 Y102.647 E.00626
G1 X85.168 Y102.395 E.00877
G1 X84.75 Y102.057 E.00898
G1 X84.445 Y101.716 E.00764
G1 X84.218 Y101.37 E.00691
G1 X84.048 Y101.012 E.0066
G1 X83.905 Y100.538 E.00828
G1 X83.835 Y100.005 E.00896
G1 X83.856 Y99.536 E.00784
G1 X83.924 Y99.187 E.00594
G1 X84.025 Y98.846 E.00594
G1 X84.173 Y98.515 E.00605
G1 X84.46 Y98.071 E.00882
G1 X84.817 Y97.673 E.00893
; LINE_WIDTH: 0.400663
G1 X84.992 Y97.496 E.00464
; LINE_WIDTH: 0.438446
G1 X85.198 Y97.319 E.00561
; LINE_WIDTH: 0.477145
G1 X85.379 Y97.165 E.00533
; WIPE_START
G1 X85.198 Y97.319 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X88.281 Y97.162 Z5.52 F18000
G1 Z5.12
G1 E.4 F1800
; LINE_WIDTH: 0.468129
G1 F1500
M204 S6000
G1 X88.579 Y97.411 E.00857
; LINE_WIDTH: 0.419335
G1 X88.782 Y97.609 E.00557
; LINE_WIDTH: 0.378828
G1 X88.959 Y97.784 E.00438
; WIPE_START
G1 X88.782 Y97.609 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X93.61 Y96.144 Z5.52 F18000
G1 Z5.12
G1 E.4 F1800
; LINE_WIDTH: 0.109816
G1 F1500
M204 S6000
G1 X93.837 Y96.009 E.00111
; WIPE_START
G1 X93.61 Y96.144 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X85.978 Y96.197 Z5.52 F18000
G1 X80.304 Y96.237 Z5.52
G1 Z5.12
G1 E.4 F1800
; LINE_WIDTH: 0.0933407
G1 F1500
M204 S6000
G1 X80.176 Y96.202 E.00045
; LINE_WIDTH: 0.150343
G1 X79.901 Y96.015 E.00207
G1 X79.805 Y95.888 E.00099
; LINE_WIDTH: 0.132332
G1 X79.727 Y95.744 E.00087
; LINE_WIDTH: 0.0915831
G1 X79.696 Y95.628 E.00039
; WIPE_START
G1 X79.727 Y95.744 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X79.711 Y88.112 Z5.52 F18000
G1 X79.689 Y77.595 Z5.52
G1 Z5.12
G1 E.4 F1800
; LINE_WIDTH: 0.10584
G1 F1500
M204 S6000
G1 X79.756 Y77.387 E.00087
; LINE_WIDTH: 0.149462
G1 X79.95 Y77.146 E.00191
G1 X80.038 Y77.072 E.00071
G1 X80.188 Y76.999 E.00103
; LINE_WIDTH: 0.100469
G1 X80.326 Y76.954 E.00054
; WIPE_START
G1 X80.188 Y76.999 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X86.911 Y80.614 Z5.52 F18000
G1 X99.497 Y87.38 Z5.52
G1 Z5.12
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X100.01 Y86.648 E.01892
G1 X100.306 Y86.855 E.00765
G1 X99.793 Y87.588 E.01892
G1 X99.546 Y87.415 E.00638
M204 S250
G1 X98.952 Y87.446 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X99.909 Y86.078 E.03283
G1 X100.843 Y86.732 E.02241
G1 X100.876 Y86.755 E.0008
G1 X99.918 Y88.122 E.03283
G1 F1739.736
G1 X99.894 Y88.158 E.00085
G1 F2536.476
G1 X99.566 Y87.928 E.00787
G1 X98.941 Y87.491 E.01501
; CHANGE_LAYER
; Z_HEIGHT: 5.24
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F2536.476
M204 S6000
G1 X99.909 Y86.078 E-.32537
G1 X100.145 Y86.243 E-.05463
; WIPE_END
G1 E-.02 F1800
; layer num/total_layer_count: 43/49
; update layer progress
M73 L43
M991 S0 P42 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z5.52 I.339 J-1.169 P1  F18000
G1 X93.851 Y84.416 Z5.52
G1 Z5.24
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X93.851 Y77.128 E.15424
G1 X94.036 Y77.076 E.00407
G1 X94.117 Y77.207 E.00325
M73 P89 R2
G1 X94.173 Y77.349 E.00324
G1 X94.202 Y77.49 E.00306
G1 X94.212 Y88.382 E.23052
G1 X93.851 Y88.382 E.00764
G1 X93.851 Y84.476 E.08268
; WIPE_START
M204 S6000
G1 X93.851 Y82.476 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X93.871 Y90.108 Z5.64 F18000
G1 X93.884 Y95.44 Z5.64
G1 Z5.24
G1 E.4 F1800
G1 F1500
M204 S500
G1 X93.953 Y95.367 E.00213
G1 X94.159 Y95.318 E.00448
G1 X94.188 Y95.519 E.00431
G1 X94.136 Y95.621 E.00242
G1 X93.858 Y95.743 E.00643
G1 X93.879 Y95.5 E.00516
; WIPE_START
M204 S6000
G1 X93.953 Y95.367 E-.04707
G1 X94.159 Y95.318 E-.06543
G1 X94.188 Y95.519 E-.06289
G1 X94.136 Y95.621 E-.03537
G1 X93.858 Y95.743 E-.09388
G1 X93.879 Y95.5 E-.07538
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X87.993 Y97.078 Z5.64 F18000
G1 Z5.24
G1 E.4 F1800
G1 F1500
M204 S500
G1 X87.436 Y96.915 E.01228
G1 X87.06 Y96.864 E.00802
G1 X86.699 Y96.858 E.00764
G1 X86.156 Y96.929 E.0116
G1 X85.667 Y97.088 E.01089
G1 X85.561 Y96.922 E.00416
G1 X85.91 Y96.544 E.01089
G1 X87.754 Y96.544 E.03903
G1 X88.095 Y96.913 E.01063
G1 X88.024 Y97.027 E.00283
; WIPE_START
M204 S6000
G1 X87.436 Y96.915 E-.11379
G1 X87.06 Y96.864 E-.07199
G1 X86.699 Y96.858 E-.06857
G1 X86.156 Y96.929 E-.10413
G1 X86.048 Y96.964 E-.02152
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X88.989 Y101.38 Z5.64 F18000
G1 Z5.24
G1 E.4 F1800
G1 F1500
M204 S500
G1 X88.905 Y101.504 E.00316
G1 X88.692 Y101.747 E.00683
G1 X88.339 Y102.046 E.00979
G1 X87.925 Y102.282 E.01011
G1 X87.641 Y102.393 E.00645
G1 X87.329 Y102.474 E.00681
G1 X86.88 Y102.521 E.00956
G1 X86.558 Y102.507 E.00683
G1 X86.239 Y102.454 E.00683
G1 X85.801 Y102.312 E.00975
G1 X85.387 Y102.089 E.00994
G1 X85.02 Y101.796 E.00995
G1 X84.711 Y101.442 E.00995
G1 X84.47 Y101.039 E.00995
G1 X84.308 Y100.607 E.00975
G1 X84.241 Y100.291 E.00683
G1 X84.211 Y99.968 E.00687
G1 X84.242 Y99.501 E.00991
G1 X84.306 Y99.203 E.00645
G1 X84.41 Y98.898 E.00682
G1 X84.622 Y98.49 E.00975
G1 X84.91 Y98.118 E.00995
G1 X85.252 Y97.809 E.00975
G1 X85.521 Y97.632 E.00683
G1 X85.81 Y97.487 E.00683
G1 X86.25 Y97.344 E.00978
G1 X86.723 Y97.283 E.01011
G1 X87.028 Y97.288 E.00645
G1 X87.347 Y97.331 E.00682
G1 X87.78 Y97.458 E.00955
G1 X88.073 Y97.593 E.00683
G1 X88.348 Y97.763 E.00683
G1 X88.699 Y98.061 E.00976
G1 X88.992 Y98.417 E.00975
G1 X89.157 Y98.694 E.00683
G1 X89.289 Y98.989 E.00683
G1 X89.411 Y99.433 E.00975
G1 X89.453 Y99.901 E.00995
G1 X89.411 Y100.369 E.00995
G1 X89.286 Y100.822 E.00995
G1 X89.086 Y101.237 E.00975
G1 X89.023 Y101.331 E.00239
M204 S250
G1 X88.651 Y101.15 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X88.58 Y101.253 E.00246
G1 X88.404 Y101.455 E.00526
G1 X88.104 Y101.709 E.00775
G1 X87.748 Y101.912 E.00806
G1 X87.514 Y102.003 E.00493
G1 X87.256 Y102.07 E.00526
G1 X86.868 Y102.111 E.00767
G1 X86.601 Y102.099 E.00526
G1 X86.337 Y102.055 E.00526
G1 X85.963 Y101.934 E.00773
G1 X85.614 Y101.746 E.00779
G1 X85.304 Y101.499 E.00779
G1 X85.043 Y101.2 E.0078
G1 X84.84 Y100.86 E.0078
G1 X84.702 Y100.492 E.00774
G1 X84.646 Y100.23 E.00526
G1 X84.622 Y99.963 E.00527
G1 X84.648 Y99.558 E.008
G1 X84.701 Y99.313 E.00493
G1 X84.787 Y99.06 E.00526
G1 X84.968 Y98.711 E.00773
G1 X85.211 Y98.397 E.0078
G1 X85.503 Y98.134 E.00773
G1 X85.726 Y97.987 E.00526
G1 X85.966 Y97.867 E.00526
G1 X86.34 Y97.745 E.00774
G1 X86.746 Y97.692 E.00806
G1 X86.997 Y97.697 E.00493
G1 X87.262 Y97.733 E.00526
G1 X87.636 Y97.842 E.00767
G1 X87.879 Y97.954 E.00526
G1 X88.107 Y98.095 E.00526
G1 X88.407 Y98.349 E.00774
G1 X88.656 Y98.653 E.00773
G1 X88.794 Y98.883 E.00526
G1 X88.902 Y99.127 E.00526
G1 X89.007 Y99.506 E.00774
G1 X89.042 Y99.901 E.00779
G1 X89.007 Y100.296 E.00779
G1 X88.901 Y100.678 E.0078
G1 X88.731 Y101.032 E.00773
G1 X88.684 Y101.1 E.00162
; WIPE_START
M204 S6000
G1 X88.58 Y101.253 E-.03516
G1 X88.404 Y101.455 E-.05085
G1 X88.104 Y101.709 E-.07483
G1 X87.748 Y101.912 E-.07782
G1 X87.514 Y102.003 E-.04763
G1 X87.256 Y102.07 E-.05077
G1 X87.031 Y102.094 E-.04296
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X88.002 Y96.12 Z5.64 F18000
G1 Z5.24
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X93.399 Y96.12 E.11423
G1 X93.463 Y95.392 E.01548
G1 X93.515 Y95.242 E.00336
G1 X93.563 Y95.163 E.00196
G1 X93.661 Y95.058 E.00305
G1 X93.824 Y94.962 E.00401
G1 X94.262 Y94.857 E.00952
G1 X98.528 Y88.764 E.15742
G1 X98.824 Y88.972 E.00765
G1 X94.552 Y95.073 E.15765
G1 X94.61 Y95.472 E.00854
G1 X94.603 Y95.598 E.00267
G1 X94.578 Y95.689 E.002
G1 X94.499 Y95.842 E.00364
G1 X94.395 Y95.951 E.00318
G1 X94.31 Y96.008 E.00217
G1 X94.079 Y96.109 E.00535
G1 X93.852 Y96.308 E.00638
G1 X93.723 Y96.387 E.00321
G1 X93.581 Y96.443 E.00321
G1 X93.441 Y96.472 E.00304
G1 X88.277 Y96.485 E.1093
G1 X89.376 Y97.675 E.03428
G1 X89.632 Y98.008 E.00888
G1 X89.919 Y98.526 E.01254
G1 X90.06 Y98.901 E.00849
G1 X90.186 Y99.48 E.01254
G1 X90.212 Y99.897 E.00883
G1 X90.205 Y100.111 E.00454
G1 X90.16 Y100.488 E.00805
G1 X90.067 Y100.879 E.00851
G1 X89.925 Y101.262 E.00864
G1 X89.832 Y101.455 E.00453
G1 X89.639 Y101.783 E.00804
G1 X89.39 Y102.11 E.00871
G1 X88.966 Y102.521 E.0125
G1 X88.613 Y102.772 E.00916
G1 X88.113 Y103.029 E.0119
G1 X87.724 Y103.161 E.00869
G1 X87.332 Y103.243 E.00849
G1 X86.932 Y103.279 E.00849
G1 X86.531 Y103.267 E.00849
G1 X85.948 Y103.164 E.01253
G1 X85.559 Y103.032 E.00869
G1 X85.198 Y102.86 E.00845
G1 X84.834 Y102.626 E.00916
G1 X84.409 Y102.258 E.0119
G1 X84.141 Y101.947 E.00869
G1 X83.918 Y101.613 E.0085
G1 X83.736 Y101.257 E.00846
G1 X83.589 Y100.85 E.00916
G1 X83.475 Y100.3 E.0119
G1 X83.452 Y99.89 E.00869
G1 X83.477 Y99.49 E.00849
G1 X83.549 Y99.095 E.00849
G1 X83.668 Y98.712 E.00849
G1 X83.831 Y98.345 E.0085
G1 X84.037 Y98 E.00849
G1 X84.288 Y97.675 E.00869
G1 X85.39 Y96.482 E.03439
G1 X80.368 Y96.482 E.1063
G1 X80.039 Y96.43 E.00703
G1 X79.813 Y96.311 E.00541
G1 X79.706 Y96.217 E.00302
G1 X79.566 Y96.03 E.00494
G1 X79.481 Y95.819 E.0048
G1 X79.451 Y95.565 E.00543
G1 X79.451 Y77.628 E.37965
G1 X79.487 Y77.357 E.00578
G1 X79.592 Y77.125 E.0054
G1 X79.76 Y76.933 E.0054
G1 X79.892 Y76.84 E.00343
G1 X80.039 Y76.772 E.00343
G1 X80.29 Y76.723 E.00539
G1 X93.363 Y76.722 E.27672
G1 X93.536 Y76.747 E.00369
G1 X93.68 Y76.794 E.0032
G1 X93.856 Y76.889 E.00424
G1 X93.807 Y77.082 E.0042
G1 X80.779 Y77.082 E.27577
G1 X80.494 Y77.131 E.00611
G1 X80.213 Y77.281 E.00675
G1 X79.982 Y77.524 E.0071
G1 X79.849 Y77.805 E.00658
G1 X79.812 Y78.056 E.00536
G1 X79.812 Y95.137 E.36154
G1 X79.837 Y95.346 E.00445
G1 X79.94 Y95.605 E.0059
G1 X80.092 Y95.81 E.00541
G1 X80.311 Y95.984 E.00591
G1 X80.546 Y96.085 E.00542
G1 X80.787 Y96.12 E.00514
G1 X87.942 Y96.12 E.15145
; WIPE_START
M204 S6000
G1 X89.942 Y96.12 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X89.21 Y96.892 Z5.64 F18000
G1 Z5.24
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X89.689 Y97.411 E.01389
G1 X89.967 Y97.772 E.00897
G1 X90.085 Y97.957 E.00431
G1 X90.293 Y98.359 E.00891
G1 X90.452 Y98.78 E.00885
G1 X90.56 Y99.22 E.00891
G1 X90.593 Y99.437 E.00431
G1 X90.621 Y99.891 E.00895
G1 X90.613 Y100.142 E.00494
G1 X90.563 Y100.56 E.00828
G1 X90.459 Y100.998 E.00885
G1 X90.302 Y101.423 E.0089
G1 X90.193 Y101.649 E.00494
G1 X89.979 Y102.011 E.00829
G1 X89.705 Y102.372 E.00892
G1 X89.557 Y102.534 E.0043
G1 X89.224 Y102.84 E.0089
G1 X88.831 Y103.119 E.00948
G1 X88.462 Y103.322 E.00828
G1 X88.262 Y103.411 E.00431
G1 X87.833 Y103.556 E.00891
G1 X87.392 Y103.649 E.00885
G1 X86.944 Y103.689 E.00885
G1 X86.494 Y103.676 E.00885
G1 X86.046 Y103.608 E.00891
G1 X85.834 Y103.557 E.0043
G1 X85.405 Y103.412 E.00891
G1 X84.999 Y103.218 E.00884
G1 X84.593 Y102.958 E.00948
G1 X84.267 Y102.691 E.00829
G1 X84.11 Y102.538 E.00431
G1 X83.815 Y102.195 E.00891
G1 X83.564 Y101.821 E.00885
G1 X83.36 Y101.421 E.00884
G1 X83.196 Y100.968 E.00948
G1 X83.099 Y100.558 E.00829
G1 X83.067 Y100.341 E.00431
G1 X83.042 Y99.889 E.00891
G1 X83.07 Y99.44 E.00885
G1 X83.151 Y98.997 E.00885
G1 X83.284 Y98.567 E.00885
G1 X83.467 Y98.156 E.00885
G1 X83.698 Y97.77 E.00885
G1 X83.975 Y97.411 E.00891
G1 X84.455 Y96.891 E.01393
G1 X80.344 Y96.891 E.08086
G1 X80.028 Y96.854 E.00625
G1 X79.894 Y96.814 E.00277
G1 X79.684 Y96.716 E.00454
G1 X79.564 Y96.637 E.00283
G1 X79.404 Y96.496 E.0042
G1 X79.213 Y96.242 E.00624
G1 X79.123 Y96.049 E.00419
G1 X79.078 Y95.904 E.00299
G1 X79.042 Y95.589 E.00624
G1 X79.042 Y77.61 E.35362
G1 X79.062 Y77.374 E.00466
G1 X79.095 Y77.234 E.00283
G1 X79.181 Y77.02 E.00454
G1 X79.253 Y76.895 E.00283
G1 X79.396 Y76.714 E.00454
G1 X79.501 Y76.615 E.00283
G1 X79.687 Y76.484 E.00448
G1 X79.894 Y76.388 E.00448
G1 X80.031 Y76.347 E.00283
G1 X80.26 Y76.313 E.00454
G1 X93.392 Y76.313 E.2583
G1 X93.63 Y76.347 E.00472
G1 X93.842 Y76.417 E.00441
G1 X94.04 Y76.524 E.00442
G1 X94.216 Y76.663 E.00442
G1 X94.366 Y76.831 E.00442
G1 X94.484 Y77.022 E.00442
G1 X94.567 Y77.231 E.00442
G1 X94.612 Y77.448 E.00436
G1 X94.621 Y88.791 E.2231
G1 X93.442 Y88.791 E.02321
G1 X93.442 Y77.491 E.22226
G1 X80.814 Y77.491 E.24838
G1 X80.629 Y77.523 E.00369
G1 X80.464 Y77.611 E.00367
G1 X80.324 Y77.758 E.004
G1 X80.245 Y77.925 E.00362
G1 X80.222 Y78.086 E.0032
G1 X80.222 Y95.113 E.33492
G1 X80.237 Y95.245 E.00261
G1 X80.3 Y95.404 E.00337
G1 X80.389 Y95.523 E.00291
G1 X80.523 Y95.629 E.00337
G1 X80.659 Y95.688 E.00291
G1 X80.816 Y95.711 E.00313
G1 X93.024 Y95.711 E.24011
G1 X93.058 Y95.326 E.00759
G1 X93.083 Y95.221 E.00213
G1 X93.147 Y95.058 E.00345
G1 X93.236 Y94.913 E.00333
G1 X93.391 Y94.748 E.00445
G1 X93.536 Y94.645 E.00351
G1 X93.689 Y94.573 E.00331
G1 X94.016 Y94.495 E.00662
G1 X98.403 Y88.23 E.15044
G1 F1739.897
G1 X98.427 Y88.194 E.00085
G1 F2536.476
G1 X98.755 Y88.424 E.00787
G1 X99.066 Y88.642 E.00747
G1 X99.394 Y88.871 E.00787
G1 F1739.897
G1 X99.369 Y88.907 E.00085
G1 F1500
G1 X94.98 Y95.175 E.15051
G1 X95.019 Y95.443 E.00532
G1 X95.019 Y95.566 E.00242
G1 X94.961 Y95.838 E.00548
G1 X94.847 Y96.062 E.00495
G1 X94.653 Y96.27 E.00559
G1 X94.508 Y96.368 E.00344
G1 X94.301 Y96.459 E.00445
G1 X94.096 Y96.639 E.00538
G1 X93.906 Y96.755 E.00438
G1 X93.698 Y96.837 E.00438
G1 X93.483 Y96.881 E.00433
G1 X89.27 Y96.892 E.08287
; WIPE_START
M204 S6000
G1 X89.689 Y97.411 E-.12677
G1 X89.967 Y97.772 E-.08664
G1 X90.085 Y97.957 E-.0416
G1 X90.293 Y98.359 E-.0861
G1 X90.366 Y98.551 E-.03888
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




G1 X88.959 Y97.784
G1 Z5.24
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.375814
G1 F1500
M204 S6000
G1 X88.78 Y97.612 E.00434
; LINE_WIDTH: 0.4085
G1 X88.574 Y97.416 E.00543
; LINE_WIDTH: 0.445826
G1 X88.393 Y97.272 E.00485
; LINE_WIDTH: 0.479763
G1 X88.212 Y97.127 E.00525
M204 S10000
G1 X88.959 Y97.784 F18000
; LINE_WIDTH: 0.359565
G1 F1500
M204 S6000
G1 X89.318 Y98.222 E.00942
G1 X89.571 Y98.684 E.00877
G1 X89.693 Y99.015 E.00588
G1 X89.785 Y99.369 E.00609
G1 X89.833 Y99.9 E.00888
G1 X89.786 Y100.425 E.00877
G1 X89.699 Y100.768 E.00591
G1 X89.574 Y101.108 E.00603
G1 X89.404 Y101.435 E.00613
G1 X89.206 Y101.725 E.00585
G1 X88.994 Y101.98 E.00552
G1 X88.724 Y102.222 E.00604
G1 X88.542 Y102.362 E.00382
G1 X88.116 Y102.611 E.00822
G1 X87.747 Y102.753 E.00659
G1 X87.408 Y102.842 E.00583
G1 X86.879 Y102.9 E.00887
G1 X86.528 Y102.884 E.00585
G1 X86.162 Y102.824 E.00618
G1 X85.7 Y102.678 E.00806
G1 X85.385 Y102.524 E.00584
G1 X85.061 Y102.317 E.00641
G1 X84.771 Y102.077 E.00627
G1 X84.397 Y101.652 E.00944
G1 X84.249 Y101.418 E.0046
G1 X84.087 Y101.105 E.00588
G1 X83.948 Y100.725 E.00674
G1 X83.867 Y100.338 E.00659
; LINE_WIDTH: 0.364406
G1 X83.834 Y99.96 E.0064
G1 X83.857 Y99.536 E.00718
G1 X83.92 Y99.186 E.00602
G1 X84.059 Y98.761 E.00754
G1 X84.173 Y98.522 E.00448
G1 X84.353 Y98.215 E.00601
G1 X84.622 Y97.871 E.00738
G1 X84.995 Y97.5 E.00889
; LINE_WIDTH: 0.406637
G1 X85.016 Y97.481 E.00054
; LINE_WIDTH: 0.449107
G1 X85.26 Y97.274 E.00676
G1 X85.284 Y97.279 E.0005
; LINE_WIDTH: 0.435414
G1 X85.307 Y97.284 E.00049
; LINE_WIDTH: 0.39729
G1 X85.583 Y97.351 E.00527
; WIPE_START
G1 X85.307 Y97.284 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X80.307 Y96.238 Z5.64 F18000
M73 P90 R2
G1 Z5.24
G1 E.4 F1800
; LINE_WIDTH: 0.0923499
G1 F1500
M204 S6000
G1 X80.176 Y96.199 E.00045
; LINE_WIDTH: 0.120422
G1 X80.131 Y96.18 E.00023
; LINE_WIDTH: 0.151754
G1 X79.898 Y96.011 E.00181
G1 X79.68 Y95.679 E.0025
M204 S10000
G1 X79.695 Y95.628 F18000
; LINE_WIDTH: 0.092976
G1 F1500
M204 S6000
G1 X79.828 Y96.025 E.0014
; WIPE_START
G1 X79.695 Y95.628 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X87.323 Y95.911 Z5.64 F18000
G1 X93.61 Y96.144 Z5.64
G1 Z5.24
G1 E.4 F1800
; LINE_WIDTH: 0.109721
G1 F1500
M204 S6000
G1 X93.837 Y96.009 E.0011
; WIPE_START
G1 X93.61 Y96.144 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X89.028 Y90.039 Z5.64 F18000
G1 X79.689 Y77.595 Z5.64
G1 Z5.24
G1 E.4 F1800
; LINE_WIDTH: 0.100336
G1 F1500
M204 S6000
G1 X79.737 Y77.434 E.00063
; LINE_WIDTH: 0.146657
G1 X79.796 Y77.322 E.00076
G1 X79.944 Y77.151 E.00137
G1 X80.041 Y77.07 E.00076
G1 X80.179 Y77.003 E.00093
; LINE_WIDTH: 0.101803
G1 X80.327 Y76.954 E.00059
; WIPE_START
G1 X80.179 Y77.003 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X86.889 Y80.64 Z5.64 F18000
G1 X99.449 Y87.449 Z5.64
G1 Z5.24
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X100.01 Y86.648 E.0207
G1 X100.306 Y86.855 E.00765
G1 X99.745 Y87.656 E.0207
G1 X99.498 Y87.484 E.00638
M204 S250
G1 X98.904 Y87.514 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X99.909 Y86.078 E.03449
G1 X100.869 Y86.75 E.02304
G1 X99.87 Y88.191 E.03449
G1 F1739.816
G1 X99.846 Y88.226 E.00085
G1 F2536.476
G1 X99.518 Y87.997 E.00787
G1 X98.893 Y87.559 E.01501
; CHANGE_LAYER
; Z_HEIGHT: 5.36
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F2536.476
M204 S6000
G1 X99.909 Y86.078 E-.34133
G1 X100.076 Y86.195 E-.03867
; WIPE_END
G1 E-.02 F1800
; layer num/total_layer_count: 44/49
; update layer progress
M73 L44
M991 S0 P43 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z5.64 I.319 J-1.175 P1  F18000
G1 X93.851 Y84.507 Z5.64
G1 Z5.36
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X93.851 Y77.128 E.15616
G1 X94.036 Y77.076 E.00407
G1 X94.117 Y77.207 E.00325
G1 X94.173 Y77.349 E.00324
G1 X94.202 Y77.49 E.00305
G1 X94.212 Y88.382 E.23052
G1 X93.851 Y88.382 E.00764
G1 X93.851 Y84.567 E.08075
; WIPE_START
M204 S6000
G1 X93.851 Y82.567 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X93.871 Y90.199 Z5.76 F18000
G1 X93.884 Y95.44 Z5.76
G1 Z5.36
G1 E.4 F1800
G1 F1500
M204 S500
G1 X93.944 Y95.377 E.00185
G1 X94.159 Y95.319 E.00471
G1 X94.188 Y95.519 E.00429
G1 X94.136 Y95.621 E.00241
G1 X93.858 Y95.743 E.00643
G1 X93.879 Y95.5 E.00516
; WIPE_START
M204 S6000
G1 X93.944 Y95.377 E-.0432
G1 X94.159 Y95.319 E-.06899
G1 X94.188 Y95.519 E-.0628
G1 X94.136 Y95.621 E-.03535
G1 X93.858 Y95.743 E-.09412
G1 X93.879 Y95.5 E-.07555
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X88.051 Y97.115 Z5.76 F18000
G1 Z5.36
G1 E.4 F1800
G1 F1500
M204 S500
G1 X87.93 Y97.059 E.00282
G1 X87.436 Y96.915 E.0109
G1 X87.06 Y96.864 E.00802
G1 X86.697 Y96.858 E.0077
G1 X86.156 Y96.929 E.01155
G1 X85.597 Y97.11 E.01242
G1 X85.491 Y96.949 E.0041
G1 X85.843 Y96.544 E.01135
G1 X87.821 Y96.544 E.04187
G1 X88.175 Y96.951 E.01141
G1 X88.087 Y97.068 E.00309
; WIPE_START
M204 S6000
G1 X87.93 Y97.059 E-.02987
G1 X87.436 Y96.915 E-.09784
G1 X87.06 Y96.864 E-.07202
G1 X86.697 Y96.858 E-.06909
G1 X86.156 Y96.929 E-.10366
G1 X86.118 Y96.941 E-.00753
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X88.972 Y101.409 Z5.76 F18000
G1 Z5.36
G1 E.4 F1800
G1 F1500
M204 S500
G1 X88.699 Y101.741 E.0091
G1 X88.34 Y102.046 E.00998
G1 X87.927 Y102.281 E.01005
G1 X87.641 Y102.393 E.00651
G1 X87.329 Y102.474 E.00682
G1 X86.871 Y102.522 E.00975
G1 X86.402 Y102.487 E.00995
G1 X85.947 Y102.369 E.00995
G1 X85.529 Y102.175 E.00975
G1 X85.26 Y101.997 E.00683
G1 X85.013 Y101.788 E.00686
G1 X84.708 Y101.436 E.00986
G1 X84.543 Y101.176 E.00651
G1 X84.403 Y100.886 E.00681
G1 X84.267 Y100.446 E.00976
G1 X84.211 Y99.979 E.00995
G1 X84.239 Y99.51 E.00995
G1 X84.348 Y99.063 E.00975
G1 X84.471 Y98.764 E.00683
G1 X84.628 Y98.482 E.00683
G1 X84.904 Y98.125 E.00955
G1 X85.137 Y97.902 E.00682
G1 X85.382 Y97.718 E.00651
G1 X85.8 Y97.491 E.01005
G1 X86.249 Y97.344 E.01001
G1 X86.721 Y97.283 E.01006
G1 X87.028 Y97.288 E.00651
G1 X87.347 Y97.331 E.00682
G1 X87.78 Y97.458 E.00955
G1 X88.073 Y97.593 E.00683
G1 X88.348 Y97.763 E.00683
G1 X88.699 Y98.061 E.00975
G1 X88.992 Y98.417 E.00975
G1 X89.157 Y98.693 E.00682
G1 X89.283 Y98.974 E.00651
G1 X89.411 Y99.431 E.01006
G1 X89.453 Y99.901 E.00998
G1 X89.412 Y100.36 E.00975
G1 X89.336 Y100.673 E.00682
G1 X89.228 Y100.961 E.00651
G1 X89.008 Y101.36 E.00966
M204 S250
G1 X88.656 Y101.149 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X88.407 Y101.452 E.00773
G1 X88.104 Y101.709 E.00781
G1 X87.75 Y101.911 E.00801
G1 X87.514 Y102.003 E.00498
G1 X87.256 Y102.07 E.00526
G1 X86.865 Y102.111 E.00774
G1 X86.469 Y102.082 E.0078
G1 X86.086 Y101.982 E.00779
G1 X85.729 Y101.817 E.00774
G1 X85.506 Y101.669 E.00526
G1 X85.301 Y101.496 E.00527
G1 X85.037 Y101.191 E.00795
G1 X84.901 Y100.977 E.00498
G1 X84.785 Y100.736 E.00525
G1 X84.669 Y100.361 E.00774
G1 X84.622 Y99.967 E.0078
G1 X84.645 Y99.571 E.0078
G1 X84.739 Y99.189 E.00773
G1 X84.84 Y98.942 E.00526
G1 X84.97 Y98.708 E.00526
G1 X85.209 Y98.4 E.00767
G1 X85.402 Y98.215 E.00526
G1 X85.605 Y98.063 E.00498
G1 X85.962 Y97.868 E.00801
G1 X86.34 Y97.745 E.00781
G1 X86.744 Y97.692 E.00801
G1 X86.997 Y97.697 E.00498
G1 X87.262 Y97.733 E.00526
G1 X87.636 Y97.842 E.00767
G1 X87.879 Y97.954 E.00526
G1 X88.107 Y98.095 E.00526
G1 X88.407 Y98.349 E.00774
G1 X88.656 Y98.653 E.00773
G1 X88.793 Y98.883 E.00526
G1 X88.897 Y99.114 E.00498
G1 X89.007 Y99.506 E.00801
G1 X89.042 Y99.901 E.0078
G1 X89.007 Y100.292 E.00773
G1 X88.944 Y100.552 E.00526
G1 X88.855 Y100.789 E.00498
G1 X88.686 Y101.097 E.0069
; WIPE_START
M204 S6000
G1 X88.407 Y101.452 E-.08596
G1 X88.104 Y101.709 E-.07542
G1 X87.75 Y101.911 E-.07736
G1 X87.514 Y102.003 E-.04809
G1 X87.256 Y102.07 E-.05079
G1 X87.034 Y102.094 E-.04239
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X88.075 Y96.12 Z5.76 F18000
G1 Z5.36
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X93.399 Y96.12 E.11269
G1 X93.463 Y95.392 E.01548
G1 X93.515 Y95.242 E.00336
G1 X93.563 Y95.163 E.00196
G1 X93.736 Y95.005 E.00497
G1 X93.868 Y94.947 E.00304
G1 X94.257 Y94.864 E.00842
G1 X98.576 Y88.696 E.15939
G1 X98.872 Y88.903 E.00765
G1 X94.552 Y95.073 E.15943
G1 X94.61 Y95.473 E.00856
G1 X94.603 Y95.598 E.00264
G1 X94.577 Y95.69 E.00202
G1 X94.499 Y95.842 E.00362
G1 X94.395 Y95.951 E.00319
G1 X94.31 Y96.008 E.00217
G1 X94.079 Y96.109 E.00536
G1 X93.852 Y96.308 E.00638
G1 X93.723 Y96.387 E.00322
G1 X93.582 Y96.443 E.00321
G1 X93.441 Y96.472 E.00304
G1 X88.332 Y96.485 E.10814
G1 X89.509 Y97.838 E.03795
G1 X89.734 Y98.17 E.0085
G1 X89.995 Y98.709 E.01269
G1 X90.158 Y99.299 E.01295
G1 X90.212 Y99.897 E.01271
G1 X90.16 Y100.489 E.01257
G1 X90.065 Y100.886 E.00865
G1 X89.997 Y101.085 E.00444
G1 X89.842 Y101.437 E.00814
G1 X89.638 Y101.783 E.00851
G1 X89.267 Y102.245 E.01254
G1 X88.966 Y102.521 E.00866
G1 X88.617 Y102.77 E.00906
G1 X88.28 Y102.955 E.00814
G1 X87.724 Y103.161 E.01255
G1 X87.332 Y103.243 E.00849
G1 X86.932 Y103.279 E.00849
G1 X86.531 Y103.267 E.00849
G1 X85.948 Y103.164 E.01253
G1 X85.559 Y103.032 E.00869
G1 X85.197 Y102.859 E.00849
G1 X84.858 Y102.644 E.00849
G1 X84.409 Y102.258 E.01253
G1 X84.141 Y101.947 E.00869
G1 X83.918 Y101.613 E.0085
G1 X83.736 Y101.257 E.00846
G1 X83.59 Y100.855 E.00907
G1 X83.475 Y100.3 E.012
G1 X83.452 Y99.89 E.00869
G1 X83.477 Y99.49 E.00849
G1 X83.549 Y99.095 E.00849
G1 X83.668 Y98.713 E.00846
G1 X83.844 Y98.323 E.00906
G1 X84.149 Y97.845 E.01199
G1 X85.335 Y96.482 E.03825
G1 X80.368 Y96.482 E.10513
G1 X80.039 Y96.43 E.00705
G1 X79.908 Y96.369 E.00305
G1 X79.715 Y96.227 E.00509
G1 X79.571 Y96.04 E.005
G1 X79.481 Y95.82 E.00503
G1 X79.451 Y95.565 E.00543
G1 X79.451 Y77.628 E.37964
G1 X79.487 Y77.357 E.00578
G1 X79.592 Y77.125 E.00539
G1 X79.693 Y76.998 E.00343
G1 X79.814 Y76.89 E.00343
G1 X80.038 Y76.772 E.00537
G1 X80.289 Y76.723 E.00541
G1 X93.365 Y76.722 E.27677
G1 X93.535 Y76.747 E.00365
G1 X93.68 Y76.794 E.00321
G1 X93.856 Y76.889 E.00424
G1 X93.807 Y77.082 E.0042
G1 X80.778 Y77.082 E.27579
G1 X80.489 Y77.132 E.0062
G1 X80.212 Y77.282 E.00667
G1 X79.981 Y77.525 E.00709
G1 X79.849 Y77.806 E.00656
G1 X79.812 Y78.056 E.00535
G1 X79.812 Y95.137 E.36153
G1 X79.837 Y95.346 E.00446
G1 X79.94 Y95.605 E.0059
G1 X80.093 Y95.81 E.00542
G1 X80.311 Y95.984 E.0059
G1 X80.546 Y96.085 E.00542
G1 X80.787 Y96.12 E.00514
G1 X88.015 Y96.12 E.153
; WIPE_START
M204 S6000
G1 X90.015 Y96.12 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X89.228 Y96.892 Z5.76 F18000
G1 Z5.36
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X89.833 Y97.587 E.01813
G1 X90.086 Y97.96 E.00885
G1 X90.295 Y98.362 E.00891
G1 X90.379 Y98.566 E.00435
G1 X90.458 Y98.803 E.00491
G1 X90.56 Y99.22 E.00844
G1 X90.593 Y99.437 E.00431
G1 X90.621 Y99.891 E.00896
G1 X90.613 Y100.137 E.00484
G1 X90.563 Y100.56 E.00838
G1 X90.458 Y101 E.0089
G1 X90.379 Y101.234 E.00485
G1 X90.207 Y101.624 E.00838
G1 X89.979 Y102.012 E.00885
G1 X89.705 Y102.372 E.0089
G1 X89.557 Y102.534 E.00431
G1 X89.224 Y102.84 E.0089
G1 X88.835 Y103.117 E.00939
G1 X88.462 Y103.322 E.00838
G1 X88.262 Y103.411 E.00431
G1 X87.832 Y103.556 E.00891
G1 X87.392 Y103.649 E.00885
G1 X86.944 Y103.689 E.00885
G1 X86.494 Y103.676 E.00885
G1 X86.046 Y103.608 E.00891
G1 X85.834 Y103.557 E.0043
G1 X85.405 Y103.412 E.00891
G1 X84.999 Y103.218 E.00885
G1 X84.618 Y102.977 E.00885
G1 X84.267 Y102.691 E.00891
G1 X84.11 Y102.538 E.0043
G1 X83.815 Y102.195 E.00891
G1 X83.564 Y101.821 E.00885
G1 X83.36 Y101.421 E.00884
G1 X83.197 Y100.972 E.00939
G1 X83.099 Y100.558 E.00838
G1 X83.067 Y100.341 E.0043
G1 X83.042 Y99.889 E.00891
G1 X83.07 Y99.44 E.00885
G1 X83.151 Y98.997 E.00885
G1 X83.284 Y98.568 E.00884
G1 X83.481 Y98.133 E.00939
G1 X83.699 Y97.767 E.00838
G1 X83.828 Y97.59 E.0043
G1 X84.436 Y96.891 E.01823
G1 X80.344 Y96.891 E.08049
G1 X80.028 Y96.854 E.00625
G1 X79.893 Y96.814 E.00277
G1 X79.698 Y96.723 E.00423
G1 X79.442 Y96.534 E.00626
G1 X79.346 Y96.432 E.00276
G1 X79.215 Y96.245 E.00449
G1 X79.122 Y96.048 E.00429
G1 X79.078 Y95.904 E.00296
G1 X79.042 Y95.589 E.00624
G1 X79.042 Y77.61 E.35362
G1 X79.062 Y77.374 E.00466
G1 X79.095 Y77.234 E.00283
G1 X79.181 Y77.019 E.00454
G1 X79.253 Y76.895 E.00283
G1 X79.394 Y76.716 E.00448
G1 X79.564 Y76.565 E.00448
G1 X79.684 Y76.486 E.00283
G1 X79.893 Y76.388 E.00453
G1 X80.04 Y76.345 E.00302
G1 X80.259 Y76.313 E.00435
G1 X93.394 Y76.313 E.25834
G1 X93.629 Y76.347 E.00468
G1 X93.842 Y76.417 E.00441
G1 X94.04 Y76.524 E.00442
G1 X94.216 Y76.663 E.00442
G1 X94.366 Y76.831 E.00442
G1 X94.484 Y77.022 E.00442
G1 X94.567 Y77.231 E.00442
G1 X94.612 Y77.448 E.00436
G1 X94.621 Y88.791 E.2231
G1 X93.442 Y88.791 E.02321
G1 X93.442 Y77.491 E.22226
G1 X80.813 Y77.491 E.24839
G1 X80.625 Y77.524 E.00376
G1 X80.464 Y77.611 E.00361
G1 X80.323 Y77.759 E.00401
G1 X80.245 Y77.925 E.00361
G1 X80.222 Y78.086 E.00319
G1 X80.222 Y95.113 E.33491
G1 X80.237 Y95.245 E.00261
G1 X80.3 Y95.404 E.00336
G1 X80.389 Y95.523 E.00292
G1 X80.523 Y95.629 E.00337
G1 X80.659 Y95.688 E.00292
M73 P91 R2
G1 X80.816 Y95.711 E.00313
G1 X93.024 Y95.711 E.24011
G1 X93.058 Y95.326 E.00759
G1 X93.083 Y95.221 E.00214
G1 X93.147 Y95.058 E.00345
G1 X93.236 Y94.913 E.00333
G1 X93.392 Y94.747 E.00448
G1 X93.534 Y94.647 E.00343
G1 X93.742 Y94.556 E.00447
G1 X94.014 Y94.497 E.00547
G1 X98.451 Y88.161 E.15215
G1 F1739.85
G1 X98.476 Y88.126 E.00085
G1 F2536.476
G1 X98.803 Y88.355 E.00787
G1 X99.115 Y88.573 E.00747
G1 X99.442 Y88.802 E.00787
G1 F1739.816
G1 X99.418 Y88.838 E.00085
G1 F1500
G1 X94.98 Y95.175 E.15216
G1 X95.019 Y95.444 E.00535
G1 X95.019 Y95.566 E.00239
G1 X94.961 Y95.839 E.0055
G1 X94.847 Y96.062 E.00492
G1 X94.653 Y96.27 E.00559
G1 X94.508 Y96.368 E.00344
G1 X94.301 Y96.459 E.00445
G1 X94.096 Y96.639 E.00538
G1 X93.906 Y96.755 E.00438
G1 X93.698 Y96.837 E.00438
G1 X93.483 Y96.881 E.00433
G1 X89.288 Y96.892 E.0825
; WIPE_START
M204 S6000
G1 X89.833 Y97.587 E-.16789
G1 X90.086 Y97.96 E-.08552
G1 X90.295 Y98.362 E-.08606
G1 X90.376 Y98.559 E-.04053
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




G1 X88.959 Y97.784
G1 Z5.36
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.378829
G1 F1500
M204 S6000
G1 X88.782 Y97.609 E.00438
; LINE_WIDTH: 0.419335
G1 X88.579 Y97.411 E.00557
; LINE_WIDTH: 0.468129
G1 X88.281 Y97.162 E.00857
M204 S10000
G1 X88.959 Y97.784 F18000
; LINE_WIDTH: 0.36034
G1 F1500
M204 S6000
G1 X89.293 Y98.19 E.00877
G1 X89.487 Y98.511 E.00626
G1 X89.641 Y98.857 E.00632
G1 X89.785 Y99.368 E.00886
G1 X89.833 Y99.9 E.00893
G1 X89.786 Y100.425 E.00879
G1 X89.7 Y100.781 E.00611
G1 X89.576 Y101.107 E.00583
G1 X89.325 Y101.57 E.0088
G1 X88.994 Y101.98 E.00879
G1 X88.543 Y102.362 E.00987
G1 X88.116 Y102.611 E.00825
G1 X87.747 Y102.753 E.0066
G1 X87.384 Y102.847 E.00626
G1 X86.862 Y102.9 E.00877
G1 X86.326 Y102.856 E.00897
G1 X85.835 Y102.726 E.00848
G1 X85.381 Y102.526 E.00828
G1 X85.08 Y102.335 E.00594
G1 X84.756 Y102.065 E.00704
G1 X84.444 Y101.714 E.00785
G1 X84.217 Y101.369 E.00689
G1 X84.048 Y101.013 E.00658
G1 X83.895 Y100.51 E.00877
G1 X83.837 Y100.005 E.00848
G1 X83.856 Y99.536 E.00784
G1 X83.923 Y99.186 E.00594
G1 X84.025 Y98.848 E.0059
G1 X84.181 Y98.502 E.00635
G1 X84.309 Y98.286 E.00418
G1 X84.616 Y97.882 E.00847
G1 X84.874 Y97.61 E.00627
; LINE_WIDTH: 0.406359
G1 X85.013 Y97.48 E.00361
; LINE_WIDTH: 0.443817
G1 X85.136 Y97.365 E.00352
; LINE_WIDTH: 0.478031
G1 X85.381 Y97.167 E.00709
; WIPE_START
G1 X85.136 Y97.365 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X80.307 Y96.238 Z5.76 F18000
G1 Z5.36
G1 E.4 F1800
; LINE_WIDTH: 0.0922704
G1 F1500
M204 S6000
G1 X80.176 Y96.199 E.00045
; LINE_WIDTH: 0.136076
G1 X80.05 Y96.13 E.00079
; LINE_WIDTH: 0.153292
G1 X79.886 Y95.999 E.00133
G1 X79.68 Y95.678 E.00243
M204 S10000
G1 X79.695 Y95.628 F18000
; LINE_WIDTH: 0.0931388
G1 F1500
M204 S6000
G1 X79.831 Y96.034 E.00144
; WIPE_START
G1 X79.695 Y95.628 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X87.323 Y95.911 Z5.76 F18000
G1 X93.61 Y96.144 Z5.76
G1 Z5.36
G1 E.4 F1800
; LINE_WIDTH: 0.109684
G1 F1500
M204 S6000
G1 X93.837 Y96.009 E.0011
; WIPE_START
G1 X93.61 Y96.144 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X89.028 Y90.039 Z5.76 F18000
G1 X79.689 Y77.595 Z5.76
G1 Z5.36
G1 E.4 F1800
; LINE_WIDTH: 0.106075
G1 F1500
M204 S6000
G1 X79.759 Y77.382 E.0009
; LINE_WIDTH: 0.156919
G1 X79.901 Y77.195 E.00154
G1 X80.022 Y77.083 E.00107
; LINE_WIDTH: 0.130659
G1 X80.228 Y76.989 E.00119
; LINE_WIDTH: 0.0925267
G1 X80.326 Y76.954 E.00035
; WIPE_START
G1 X80.228 Y76.989 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X86.918 Y80.663 Z5.76 F18000
G1 X99.401 Y87.518 Z5.76
G1 Z5.36
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X100.01 Y86.648 E.02248
G1 X100.306 Y86.855 E.00765
G1 X99.697 Y87.725 E.02248
G1 X99.45 Y87.552 E.00638
M204 S250
G1 X98.855 Y87.583 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X99.909 Y86.078 E.03614
G1 X100.876 Y86.755 E.02321
G1 X99.822 Y88.26 E.03614
G1 F1739.816
G1 X99.797 Y88.295 E.00085
G1 F2536.476
G1 X99.47 Y88.066 E.00787
G1 X98.845 Y87.628 E.01501
; CHANGE_LAYER
; Z_HEIGHT: 5.48
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F2536.476
M204 S6000
G1 X99.909 Y86.078 E-.3573
G1 X100.007 Y86.147 E-.0227
; WIPE_END
G1 E-.02 F1800
; layer num/total_layer_count: 45/49
; update layer progress
M73 L45
M991 S0 P44 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z5.76 I.329 J-1.172 P1  F18000
G1 X93.851 Y84.415 Z5.76
G1 Z5.48
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X93.851 Y77.128 E.15423
G1 X94.036 Y77.076 E.00407
G1 X94.117 Y77.207 E.00325
G1 X94.173 Y77.349 E.00324
G1 X94.202 Y77.49 E.00305
G1 X94.212 Y88.382 E.23052
G1 X93.851 Y88.382 E.00764
G1 X93.851 Y84.475 E.08268
; WIPE_START
M204 S6000
G1 X93.851 Y82.475 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X93.874 Y90.108 Z5.88 F18000
G1 X93.89 Y95.434 Z5.88
G1 Z5.48
G1 E.4 F1800
G1 F1500
M204 S500
G1 X93.953 Y95.367 E.00195
G1 X94.159 Y95.318 E.00447
G1 X94.184 Y95.492 E.00372
G1 X94.17 Y95.566 E.0016
G1 X94.131 Y95.612 E.00129
G1 X93.863 Y95.741 E.00629
G1 X93.885 Y95.494 E.00524
; WIPE_START
M204 S6000
G1 X93.953 Y95.367 E-.04523
G1 X94.159 Y95.318 E-.06623
G1 X94.184 Y95.492 E-.05515
G1 X94.17 Y95.566 E-.02364
G1 X94.131 Y95.612 E-.01905
G1 X93.863 Y95.741 E-.09306
G1 X93.885 Y95.494 E-.07763
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X87.992 Y97.078 Z5.88 F18000
G1 Z5.48
G1 E.4 F1800
G1 F1500
M204 S500
G1 X87.436 Y96.915 E.01228
G1 X87.06 Y96.864 E.00802
G1 X86.694 Y96.858 E.00775
G1 X86.155 Y96.929 E.01149
G1 X85.597 Y97.11 E.01242
G1 X85.49 Y96.949 E.0041
G1 X85.842 Y96.544 E.01135
G1 X87.754 Y96.544 E.04046
G1 X88.094 Y96.913 E.01063
G1 X88.024 Y97.027 E.00283
; WIPE_START
M204 S6000
G1 X87.436 Y96.915 E-.1138
G1 X87.06 Y96.864 E-.07203
G1 X86.694 Y96.858 E-.0696
G1 X86.155 Y96.929 E-.10317
G1 X86.048 Y96.964 E-.0214
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X88.973 Y101.409 Z5.88 F18000
G1 Z5.48
G1 E.4 F1800
G1 F1500
M204 S500
G1 X88.699 Y101.741 E.0091
G1 X88.341 Y102.045 E.00995
G1 X87.934 Y102.28 E.00995
G1 X87.5 Y102.435 E.00975
G1 X87.183 Y102.498 E.00683
G1 X86.861 Y102.522 E.00683
G1 X86.401 Y102.487 E.00977
G1 X85.944 Y102.366 E.01
G1 X85.659 Y102.244 E.00656
G1 X85.38 Y102.083 E.00682
G1 X85.02 Y101.796 E.00975
G1 X84.711 Y101.442 E.00995
G1 X84.47 Y101.038 E.00995
G1 X84.308 Y100.607 E.00975
G1 X84.241 Y100.291 E.00683
G1 X84.212 Y99.97 E.00683
G1 X84.239 Y99.51 E.00975
G1 X84.348 Y99.063 E.00975
G1 X84.471 Y98.764 E.00683
G1 X84.628 Y98.482 E.00683
G1 X84.904 Y98.125 E.00956
G1 X85.137 Y97.902 E.00682
G1 X85.385 Y97.716 E.00656
G1 X85.8 Y97.491 E.01
G1 X86.249 Y97.345 E.01
G1 X86.718 Y97.283 E.01001
G1 X87.028 Y97.288 E.00656
G1 X87.347 Y97.331 E.00682
G1 X87.78 Y97.458 E.00955
G1 X88.074 Y97.594 E.00684
G1 X88.348 Y97.763 E.00682
G1 X88.7 Y98.062 E.00978
G1 X88.999 Y98.428 E.01001
G1 X89.158 Y98.694 E.00656
G1 X89.289 Y98.989 E.00682
G1 X89.411 Y99.433 E.00975
G1 X89.453 Y99.901 E.00995
G1 X89.412 Y100.36 E.00975
G1 X89.336 Y100.673 E.00682
G1 X89.227 Y100.963 E.00656
G1 X89.008 Y101.36 E.0096
M204 S250
G1 X88.656 Y101.149 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X88.407 Y101.452 E.00774
G1 X88.104 Y101.709 E.0078
G1 X87.761 Y101.907 E.00779
G1 X87.391 Y102.04 E.00773
G1 X87.128 Y102.091 E.00526
G1 X86.861 Y102.111 E.00526
G1 X86.469 Y102.082 E.00774
G1 X86.078 Y101.979 E.00796
G1 X85.843 Y101.878 E.00503
G1 X85.611 Y101.744 E.00526
G1 X85.304 Y101.499 E.00773
G1 X85.043 Y101.2 E.0078
G1 X84.84 Y100.86 E.0078
G1 X84.702 Y100.492 E.00773
G1 X84.646 Y100.23 E.00526
G1 X84.622 Y99.964 E.00526
G1 X84.645 Y99.571 E.00773
G1 X84.739 Y99.189 E.00773
G1 X84.84 Y98.942 E.00526
G1 X84.97 Y98.708 E.00526
G1 X85.209 Y98.4 E.00767
G1 X85.402 Y98.215 E.00526
G1 X85.607 Y98.061 E.00503
G1 X85.962 Y97.868 E.00796
G1 X86.34 Y97.745 E.00781
G1 X86.741 Y97.693 E.00796
G1 X86.997 Y97.697 E.00503
G1 X87.262 Y97.733 E.00526
G1 X87.636 Y97.842 E.00767
G1 X87.879 Y97.955 E.00527
G1 X88.107 Y98.095 E.00526
G1 X88.407 Y98.35 E.00774
G1 X88.663 Y98.663 E.00796
G1 X88.794 Y98.883 E.00503
G1 X88.902 Y99.127 E.00526
G1 X89.007 Y99.506 E.00773
G1 X89.042 Y99.901 E.0078
G1 X89.007 Y100.292 E.00773
G1 X88.944 Y100.552 E.00526
G1 X88.854 Y100.792 E.00503
G1 X88.686 Y101.096 E.00685
; WIPE_START
M204 S6000
G1 X88.407 Y101.452 E-.08598
G1 X88.104 Y101.709 E-.07533
G1 X87.761 Y101.907 E-.0753
G1 X87.391 Y102.04 E-.07469
G1 X87.128 Y102.091 E-.05085
G1 X87.035 Y102.098 E-.01785
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X88.002 Y96.12 Z5.88 F18000
G1 Z5.48
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X93.416 Y96.12 E.11459
G1 X93.455 Y95.443 E.01436
M73 P91 R1
G1 X93.477 Y95.335 E.00232
G1 X93.563 Y95.163 E.00407
G1 X93.663 Y95.056 E.0031
G1 X93.824 Y94.962 E.00396
G1 X94.262 Y94.857 E.00952
G1 X98.597 Y88.665 E.15998
G1 X98.827 Y88.338 E.00847
G1 F600
G1 X99.15 Y87.876 E.01194
G1 F1500
G1 X99.38 Y87.548 E.00847
G1 X100.01 Y86.648 E.02325
G1 X100.306 Y86.855 E.00765
G1 X99.676 Y87.755 E.02326
G1 X99.446 Y88.083 E.00847
G1 F600
G1 X99.123 Y88.545 E.01194
G1 F1500
G1 X98.893 Y88.873 E.00847
G1 X94.552 Y95.073 E.1602
M73 P92 R1
G1 X94.61 Y95.521 E.00957
G1 X94.564 Y95.729 E.0045
G1 X94.518 Y95.813 E.00204
G1 X94.419 Y95.928 E.0032
G1 X94.302 Y96.011 E.00305
G1 X94.079 Y96.109 E.00516
G1 X93.852 Y96.308 E.00638
G1 X93.723 Y96.387 E.00321
G1 X93.581 Y96.443 E.00322
G1 X93.441 Y96.472 E.00304
G1 X88.277 Y96.485 E.1093
G1 X89.376 Y97.675 E.03428
G1 X89.73 Y98.161 E.01273
G1 X89.919 Y98.526 E.00869
G1 X90.112 Y99.086 E.01254
G1 X90.205 Y99.68 E.01273
G1 X90.206 Y100.1 E.00888
G1 X90.118 Y100.693 E.0127
G1 X90.063 Y100.891 E.00434
G1 X89.928 Y101.255 E.00823
G1 X89.644 Y101.776 E.01255
G1 X89.396 Y102.102 E.00866
G1 X89.101 Y102.405 E.00897
G1 X88.647 Y102.752 E.01209
G1 X88.113 Y103.029 E.01273
G1 X87.538 Y103.206 E.01273
G1 X87.132 Y103.267 E.00869
G1 X86.731 Y103.279 E.00849
G1 X86.332 Y103.243 E.00849
G1 X85.939 Y103.161 E.00849
G1 X85.559 Y103.032 E.00849
G1 X85.197 Y102.859 E.00849
G1 X84.858 Y102.644 E.00849
G1 X84.539 Y102.385 E.00869
G1 X84.141 Y101.947 E.01254
G1 X83.918 Y101.613 E.00849
G1 X83.736 Y101.257 E.00847
G1 X83.591 Y100.859 E.00897
G1 X83.501 Y100.481 E.00823
G1 X83.452 Y99.89 E.01254
G1 X83.477 Y99.49 E.00849
G1 X83.549 Y99.095 E.0085
G1 X83.668 Y98.713 E.00846
G1 X83.842 Y98.326 E.00897
G1 X84.149 Y97.845 E.01209
G1 X85.335 Y96.482 E.03824
G1 X80.368 Y96.482 E.10513
G1 X80.12 Y96.453 E.00527
G1 X79.892 Y96.363 E.0052
G1 X79.693 Y96.204 E.00539
G1 X79.555 Y96.011 E.00501
G1 X79.479 Y95.803 E.00469
G1 X79.451 Y95.565 E.00508
G1 X79.451 Y77.628 E.37965
G1 X79.487 Y77.357 E.00578
G1 X79.547 Y77.207 E.00343
G1 X79.627 Y77.076 E.00324
G1 X79.735 Y76.955 E.00343
G1 X79.884 Y76.844 E.00394
G1 X80.038 Y76.772 E.0036
G1 X80.289 Y76.723 E.00541
G1 X93.366 Y76.722 E.2768
G1 X93.535 Y76.747 E.00361
G1 X93.68 Y76.794 E.00322
G1 X93.856 Y76.889 E.00424
G1 X93.807 Y77.082 E.0042
G1 X80.778 Y77.082 E.27579
G1 X80.489 Y77.132 E.0062
G1 X80.211 Y77.282 E.00669
G1 X79.979 Y77.529 E.00716
G1 X79.849 Y77.807 E.00649
G1 X79.812 Y78.056 E.00533
G1 X79.812 Y95.146 E.36173
G1 X79.849 Y95.395 E.00533
G1 X79.975 Y95.665 E.0063
G1 X80.172 Y95.887 E.00629
G1 X80.441 Y96.052 E.00668
G1 X80.768 Y96.12 E.00708
G1 X87.942 Y96.12 E.15183
; WIPE_START
M204 S6000
G1 X89.942 Y96.12 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X89.21 Y96.892 Z5.88 F18000
G1 Z5.48
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X89.689 Y97.411 E.01389
G1 X89.967 Y97.772 E.00897
G1 X90.085 Y97.957 E.0043
G1 X90.293 Y98.359 E.00891
G1 X90.453 Y98.783 E.00891
G1 X90.511 Y98.994 E.00431
G1 X90.594 Y99.443 E.00897
G1 X90.614 Y99.661 E.0043
G1 X90.615 Y100.117 E.00897
G1 X90.597 Y100.335 E.0043
G1 X90.517 Y100.783 E.00896
G1 X90.453 Y101.016 E.00475
G1 X90.303 Y101.42 E.00847
G1 X90.097 Y101.824 E.00892
G1 X89.981 Y102.009 E.00431
G1 X89.707 Y102.369 E.0089
G1 X89.377 Y102.708 E.0093
G1 X89.043 Y102.979 E.00847
G1 X88.861 Y103.102 E.00431
G1 X88.462 Y103.322 E.00897
G1 X88.261 Y103.411 E.00431
G1 X87.829 Y103.557 E.00897
G1 X87.617 Y103.608 E.0043
G1 X87.169 Y103.676 E.00891
G1 X86.719 Y103.689 E.00885
G1 X86.271 Y103.649 E.00885
G1 X85.831 Y103.556 E.00885
G1 X85.405 Y103.412 E.00885
G1 X84.999 Y103.218 E.00885
G1 X84.618 Y102.977 E.00885
G1 X84.267 Y102.691 E.00891
G1 X84.11 Y102.539 E.0043
G1 X83.815 Y102.195 E.00891
G1 X83.565 Y101.821 E.00885
G1 X83.36 Y101.421 E.00884
G1 X83.199 Y100.977 E.0093
G1 X83.099 Y100.558 E.00847
G1 X83.067 Y100.341 E.0043
G1 X83.042 Y99.889 E.00891
G1 X83.07 Y99.44 E.00885
G1 X83.151 Y98.997 E.00885
G1 X83.284 Y98.568 E.00884
G1 X83.478 Y98.137 E.0093
G1 X83.699 Y97.767 E.00847
G1 X83.828 Y97.59 E.00431
G1 X84.436 Y96.891 E.01823
G1 X80.344 Y96.891 E.08049
G1 X80.031 Y96.854 E.00619
G1 X79.818 Y96.784 E.00442
G1 X79.564 Y96.637 E.00577
G1 X79.394 Y96.486 E.00448
G1 X79.253 Y96.307 E.00448
G1 X79.182 Y96.185 E.00277
G1 X79.078 Y95.898 E.00601
G1 X79.042 Y95.589 E.00613
G1 X79.042 Y77.61 E.35362
G1 X79.062 Y77.374 E.00466
G1 X79.095 Y77.234 E.00283
G1 X79.18 Y77.022 E.00448
G1 X79.297 Y76.831 E.00442
G1 X79.449 Y76.661 E.00448
G1 X79.684 Y76.486 E.00577
G1 X79.893 Y76.388 E.00453
G1 X80.039 Y76.345 E.00299
G1 X80.26 Y76.313 E.00438
G1 X93.395 Y76.313 E.25837
G1 X93.629 Y76.347 E.00465
G1 X93.842 Y76.417 E.00441
G1 X94.04 Y76.524 E.00442
G1 X94.216 Y76.663 E.00442
G1 X94.366 Y76.831 E.00442
G1 X94.484 Y77.022 E.00442
G1 X94.567 Y77.231 E.00442
G1 X94.612 Y77.448 E.00436
G1 X94.621 Y88.791 E.2231
G1 X93.442 Y88.791 E.02321
G1 X93.442 Y77.491 E.22226
G1 X80.813 Y77.491 E.24839
G1 X80.625 Y77.524 E.00376
G1 X80.463 Y77.611 E.00362
G1 X80.322 Y77.761 E.00406
G1 X80.245 Y77.925 E.00355
G1 X80.222 Y78.086 E.00319
G1 X80.222 Y95.116 E.33497
G1 X80.245 Y95.277 E.00319
G1 X80.32 Y95.437 E.00349
G1 X80.438 Y95.57 E.00349
G1 X80.594 Y95.666 E.00361
G1 X80.81 Y95.711 E.00433
G1 X93.03 Y95.711 E.24035
G1 X93.048 Y95.389 E.00634
G1 X93.084 Y95.218 E.00345
G1 X93.147 Y95.058 E.00339
G1 X93.236 Y94.914 E.00333
G1 X93.393 Y94.746 E.00451
G1 X93.536 Y94.645 E.00345
G1 X93.689 Y94.573 E.00332
G1 X94.016 Y94.495 E.00661
G1 X98.27 Y88.42 E.14588
G1 X98.499 Y88.092 E.00787
G1 F600
G1 X98.807 Y87.652 E.01057
G1 F1500
G1 X99.037 Y87.324 E.00787
G1 X99.909 Y86.078 E.02993
G1 X100.876 Y86.755 E.02321
G1 X100.003 Y88.001 E.02993
G1 X99.774 Y88.329 E.00787
G1 F600
G1 X99.466 Y88.769 E.01057
G1 F1500
G1 X99.236 Y89.097 E.00787
G1 X94.98 Y95.175 E.14595
G1 X95.019 Y95.559 E.0076
G1 X94.975 Y95.8 E.00482
G1 X94.855 Y96.048 E.00541
G1 X94.697 Y96.232 E.00477
G1 X94.505 Y96.369 E.00463
G1 X94.301 Y96.459 E.00438
G1 X94.096 Y96.639 E.00538
G1 X93.906 Y96.755 E.00438
G1 X93.698 Y96.837 E.00438
G1 X93.483 Y96.881 E.00432
G1 X89.27 Y96.892 E.08287
; WIPE_START
M204 S6000
G1 X89.689 Y97.411 E-.12676
G1 X89.967 Y97.772 E-.08668
G1 X90.085 Y97.957 E-.04157
G1 X90.293 Y98.359 E-.08608
G1 X90.365 Y98.551 E-.03891
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




G1 X88.96 Y97.785
G1 Z5.48
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.375646
G1 F1500
M204 S6000
G1 X88.781 Y97.612 E.00435
; LINE_WIDTH: 0.408422
G1 X88.574 Y97.416 E.00544
; LINE_WIDTH: 0.445808
G1 X88.393 Y97.272 E.00486
; LINE_WIDTH: 0.479765
G1 X88.212 Y97.127 E.00525
M204 S10000
G1 X88.96 Y97.785 F18000
; LINE_WIDTH: 0.359719
G1 F1500
M204 S6000
G1 X89.299 Y98.204 E.00897
G1 X89.497 Y98.53 E.00636
G1 X89.647 Y98.873 E.00625
G1 X89.782 Y99.38 E.00874
G1 X89.827 Y99.886 E.00847
G1 X89.822 Y100.081 E.00324
G1 X89.745 Y100.606 E.00885
G1 X89.58 Y101.103 E.00872
G1 X89.329 Y101.564 E.00875
G1 X89.105 Y101.851 E.00605
G1 X88.844 Y102.12 E.00626
G1 X88.444 Y102.427 E.00839
G1 X87.971 Y102.673 E.00889
G1 X87.588 Y102.8 E.00672
G1 X87.224 Y102.872 E.00618
G1 X86.743 Y102.896 E.00803
G1 X86.353 Y102.862 E.00651
G1 X85.833 Y102.727 E.00896
G1 X85.482 Y102.577 E.00636
G1 X85.083 Y102.335 E.00777
G1 X84.75 Y102.057 E.00723
G1 X84.414 Y101.676 E.00847
G1 X84.124 Y101.189 E.00945
G1 X83.956 Y100.752 E.00779
G1 X83.855 Y100.256 E.00843
G1 X83.834 Y99.891 E.00609
G1 X83.864 Y99.469 E.00706
G1 X83.986 Y98.958 E.00875
G1 X84.135 Y98.592 E.00659
G1 X84.322 Y98.266 E.00625
G1 X84.616 Y97.882 E.00805
G1 X84.874 Y97.609 E.00626
; LINE_WIDTH: 0.406606
G1 X85.014 Y97.478 E.00364
; LINE_WIDTH: 0.444427
G1 X85.139 Y97.363 E.00355
; LINE_WIDTH: 0.47837
G1 X85.38 Y97.167 E.00702
; WIPE_START
G1 X85.139 Y97.363 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X80.294 Y96.251 Z5.88 F18000
G1 Z5.48
G1 E.4 F1800
; LINE_WIDTH: 0.148602
G1 F1500
M204 S6000
G1 X79.982 Y96.09 E.00215
G1 X79.805 Y95.891 E.00163
G1 X79.76 Y95.815 E.00054
; LINE_WIDTH: 0.103859
G1 X79.693 Y95.617 E.00081
; WIPE_START
G1 X79.76 Y95.815 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X87.39 Y95.989 Z5.88 F18000
G1 X93.628 Y96.132 Z5.88
G1 Z5.48
G1 E.4 F1800
; LINE_WIDTH: 0.0967583
G1 F1500
M204 S6000
G1 X93.837 Y96.009 E.00086
; WIPE_START
G1 X93.628 Y96.132 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X89.041 Y90.032 Z5.88 F18000
G1 X79.689 Y77.595 Z5.88
G1 Z5.48
G1 E.4 F1800
; LINE_WIDTH: 0.099894
G1 F1500
M204 S6000
G1 X79.736 Y77.433 E.00062
; LINE_WIDTH: 0.146292
G1 X79.79 Y77.332 E.00069
G1 X79.935 Y77.16 E.00135
G1 X80.038 Y77.072 E.00081
G1 X80.185 Y77.001 E.00098
; LINE_WIDTH: 0.100974
G1 X80.326 Y76.954 E.00056
; CHANGE_LAYER
; Z_HEIGHT: 5.6
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F1500
G1 X80.185 Y77.001 E-.38
; WIPE_END
G1 E-.02 F1800
; layer num/total_layer_count: 46/49
; update layer progress
M73 L46
M991 S0 P45 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z5.88 I-.586 J1.067 P1  F18000
G1 X93.851 Y84.506 Z5.88
G1 Z5.6
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X93.851 Y77.128 E.15616
G1 X94.036 Y77.076 E.00407
G1 X94.117 Y77.207 E.00325
G1 X94.173 Y77.349 E.00324
G1 X94.202 Y77.49 E.00305
G1 X94.212 Y88.382 E.23052
G1 X93.851 Y88.382 E.00764
G1 X93.851 Y84.566 E.08075
; WIPE_START
M204 S6000
G1 X93.851 Y82.566 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X93.869 Y90.199 Z6 F18000
G1 X93.881 Y95.474 Z6
G1 Z5.6
G1 E.4 F1800
G1 F1500
M204 S500
G1 X93.893 Y95.432 E.00094
G1 X93.944 Y95.377 E.00158
G1 X94.159 Y95.319 E.00472
G1 X94.184 Y95.492 E.0037
G1 X94.17 Y95.566 E.0016
G1 X94.123 Y95.622 E.00154
G1 X93.857 Y95.748 E.00621
G1 X93.876 Y95.534 E.00454
; WIPE_START
M204 S6000
G1 X93.893 Y95.432 E-.03204
G1 X93.944 Y95.377 E-.02299
G1 X94.159 Y95.319 E-.0687
G1 X94.184 Y95.492 E-.05392
G1 X94.17 Y95.566 E-.0233
G1 X94.123 Y95.622 E-.02249
G1 X93.857 Y95.748 E-.09048
G1 X93.876 Y95.534 E-.06608
; WIPE_END
G1 E-.02 F1800
M204 S10000
M73 P93 R1
G1 X88.043 Y97.113 Z6 F18000
G1 Z5.6
G1 E.4 F1800
G1 F1500
M204 S500
G1 X87.947 Y97.064 E.0023
G1 X87.436 Y96.915 E.01126
G1 X87.06 Y96.864 E.00803
G1 X86.691 Y96.858 E.00781
G1 X86.155 Y96.929 E.01144
G1 X85.597 Y97.11 E.01241
G1 X85.49 Y96.949 E.0041
G1 X85.842 Y96.544 E.01135
G1 X87.821 Y96.544 E.04188
G1 X88.172 Y96.948 E.01132
G1 X88.08 Y97.066 E.00316
; WIPE_START
M204 S6000
G1 X87.947 Y97.064 E-.0254
G1 X87.436 Y96.915 E-.10107
G1 X87.06 Y96.864 E-.07212
G1 X86.691 Y96.858 E-.07013
G1 X86.155 Y96.929 E-.10271
G1 X86.112 Y96.943 E-.00856
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X88.973 Y101.408 Z6 F18000
G1 Z5.6
G1 E.4 F1800
G1 F1500
M204 S500
G1 X88.699 Y101.741 E.00911
G1 X88.341 Y102.045 E.00995
G1 X87.942 Y102.275 E.00975
G1 X87.641 Y102.393 E.00683
G1 X87.329 Y102.474 E.00683
G1 X86.871 Y102.522 E.00975
G1 X86.402 Y102.487 E.00995
G1 X85.947 Y102.369 E.00995
G1 X85.529 Y102.175 E.00975
G1 X85.26 Y101.997 E.00683
G1 X85.014 Y101.789 E.00683
G1 X84.711 Y101.442 E.00975
G1 X84.474 Y101.047 E.00975
G1 X84.352 Y100.748 E.00682
G1 X84.269 Y100.447 E.00662
G1 X84.211 Y99.979 E.00997
G1 X84.24 Y99.509 E.00997
G1 X84.306 Y99.203 E.00662
G1 X84.41 Y98.898 E.00682
G1 X84.622 Y98.49 E.00975
G1 X84.91 Y98.118 E.00995
G1 X85.252 Y97.809 E.00975
G1 X85.521 Y97.632 E.00683
G1 X85.81 Y97.487 E.00683
G1 X86.249 Y97.345 E.00977
G1 X86.715 Y97.283 E.00995
G1 X87.028 Y97.288 E.00662
G1 X87.347 Y97.331 E.00683
G1 X87.79 Y97.461 E.00977
G1 X88.21 Y97.672 E.00995
G1 X88.466 Y97.852 E.00662
G1 X88.705 Y98.068 E.00682
G1 X88.992 Y98.417 E.00955
G1 X89.157 Y98.694 E.00682
G1 X89.285 Y98.979 E.00662
G1 X89.411 Y99.432 E.00995
G1 X89.453 Y99.901 E.00997
G1 X89.412 Y100.36 E.00975
G1 X89.336 Y100.673 E.00682
G1 X89.226 Y100.966 E.00662
G1 X89.008 Y101.36 E.00954
M204 S250
G1 X88.657 Y101.149 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X88.407 Y101.452 E.00774
G1 X88.104 Y101.709 E.0078
G1 X87.764 Y101.905 E.00773
G1 X87.515 Y102.003 E.00526
G1 X87.256 Y102.07 E.00526
G1 X86.865 Y102.111 E.00774
G1 X86.469 Y102.082 E.0078
G1 X86.086 Y101.982 E.00779
G1 X85.729 Y101.817 E.00774
G1 X85.506 Y101.669 E.00526
G1 X85.302 Y101.497 E.00526
G1 X85.043 Y101.2 E.00773
G1 X84.841 Y100.863 E.00773
G1 X84.74 Y100.616 E.00526
G1 X84.671 Y100.367 E.00508
G1 X84.622 Y99.967 E.00792
G1 X84.647 Y99.565 E.00792
G1 X84.701 Y99.313 E.00507
G1 X84.787 Y99.06 E.00526
G1 X84.968 Y98.711 E.00773
G1 X85.211 Y98.397 E.0078
G1 X85.503 Y98.134 E.00773
G1 X85.726 Y97.987 E.00526
G1 X85.966 Y97.867 E.00526
G1 X86.34 Y97.745 E.00774
G1 X86.739 Y97.693 E.00792
G1 X86.997 Y97.697 E.00508
G1 X87.262 Y97.733 E.00526
G1 X87.64 Y97.843 E.00774
G1 X87.999 Y98.024 E.00792
G1 X88.21 Y98.173 E.00507
G1 X88.409 Y98.352 E.00526
G1 X88.656 Y98.653 E.00767
G1 X88.794 Y98.883 E.00526
G1 X88.899 Y99.118 E.00507
G1 X89.007 Y99.506 E.00792
G1 X89.042 Y99.901 E.0078
G1 X89.007 Y100.292 E.00773
G1 X88.944 Y100.552 E.00526
G1 X88.853 Y100.794 E.00508
G1 X88.686 Y101.096 E.0068
; WIPE_START
M204 S6000
G1 X88.407 Y101.452 E-.08602
G1 X88.104 Y101.709 E-.07533
G1 X87.764 Y101.905 E-.07468
G1 X87.515 Y102.003 E-.05084
G1 X87.256 Y102.07 E-.05082
G1 X87.034 Y102.094 E-.04232
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X88.075 Y96.12 Z6 F18000
G1 Z5.6
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X93.399 Y96.12 E.11268
G1 X93.462 Y95.401 E.01529
G1 X93.49 Y95.295 E.00232
G1 X93.563 Y95.163 E.00318
G1 X93.735 Y95.005 E.00494
G1 X93.873 Y94.945 E.00319
G1 X94.256 Y94.865 E.00827
G1 X100.01 Y86.648 E.21232
G1 X100.306 Y86.855 E.00765
G1 X94.552 Y95.073 E.21233
G1 X94.61 Y95.521 E.00957
G1 X94.564 Y95.729 E.0045
G1 X94.517 Y95.814 E.00206
G1 X94.413 Y95.935 E.00337
G1 X94.347 Y95.985 E.00175
G1 X94.072 Y96.116 E.00645
G1 X93.852 Y96.308 E.00618
G1 X93.723 Y96.387 E.00322
G1 X93.582 Y96.443 E.00321
G1 X93.441 Y96.472 E.00304
G1 X88.332 Y96.485 E.10814
G1 X89.515 Y97.845 E.03814
G1 X89.738 Y98.176 E.00846
G1 X89.919 Y98.525 E.00833
G1 X90.114 Y99.093 E.01271
G1 X90.206 Y99.697 E.01292
G1 X90.189 Y100.29 E.01256
G1 X90.118 Y100.693 E.00867
G1 X90.064 Y100.887 E.00424
G1 X89.928 Y101.256 E.00833
G1 X89.742 Y101.62 E.00867
G1 X89.396 Y102.102 E.01255
G1 X89.117 Y102.391 E.0085
G1 X88.799 Y102.649 E.00866
G1 X88.633 Y102.761 E.00424
G1 X88.288 Y102.951 E.00833
G1 X87.916 Y103.102 E.0085
G1 X87.529 Y103.208 E.00849
G1 X86.941 Y103.279 E.01254
G1 X86.531 Y103.267 E.00869
G1 X85.948 Y103.163 E.01254
G1 X85.559 Y103.032 E.00869
G1 X85.197 Y102.859 E.00849
G1 X84.858 Y102.644 E.00849
G1 X84.409 Y102.258 E.01254
G1 X84.141 Y101.947 E.00869
G1 X83.918 Y101.613 E.00849
G1 X83.736 Y101.257 E.00847
G1 X83.592 Y100.863 E.00887
G1 X83.475 Y100.3 E.01218
G1 X83.452 Y99.89 E.00869
G1 X83.477 Y99.49 E.00849
G1 X83.549 Y99.095 E.00849
G1 X83.668 Y98.713 E.00847
G1 X83.84 Y98.33 E.00887
G1 X84.149 Y97.845 E.01218
G1 X85.335 Y96.482 E.03825
G1 X80.368 Y96.482 E.10513
G1 X80.12 Y96.453 E.00527
G1 X79.975 Y96.405 E.00324
G1 X79.814 Y96.311 E.00394
G1 X79.699 Y96.21 E.00324
G1 X79.567 Y96.031 E.0047
G1 X79.481 Y95.82 E.00483
G1 X79.451 Y95.565 E.00544
G1 X79.451 Y77.62 E.37982
G1 X79.49 Y77.349 E.00579
G1 X79.596 Y77.118 E.00538
G1 X79.767 Y76.928 E.00541
G1 X79.892 Y76.84 E.00325
G1 X80.031 Y76.775 E.00324
G1 X80.28 Y76.723 E.00539
G1 X93.368 Y76.722 E.27701
G1 X93.535 Y76.746 E.00357
G1 X93.68 Y76.794 E.00322
G1 X93.856 Y76.889 E.00424
G1 X93.807 Y77.082 E.0042
G1 X80.778 Y77.082 E.27579
G1 X80.489 Y77.132 E.0062
G1 X80.211 Y77.282 E.00667
G1 X79.98 Y77.526 E.00712
G1 X79.849 Y77.806 E.00654
G1 X79.812 Y78.056 E.00534
G1 X79.812 Y95.146 E.36173
G1 X79.849 Y95.395 E.00532
G1 X79.974 Y95.664 E.00628
G1 X80.172 Y95.887 E.00633
G1 X80.443 Y96.053 E.00672
G1 X80.769 Y96.12 E.00704
G1 X88.015 Y96.12 E.15338
; WIPE_START
M204 S6000
G1 X90.015 Y96.12 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X89.228 Y96.892 Z6 F18000
G1 Z5.6
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X89.835 Y97.59 E.01819
G1 X90.093 Y97.972 E.00908
G1 X90.293 Y98.359 E.00856
G1 X90.453 Y98.783 E.00891
G1 X90.512 Y98.997 E.00436
G1 X90.561 Y99.232 E.00472
G1 X90.614 Y99.666 E.00861
G1 X90.621 Y99.903 E.00466
G1 X90.596 Y100.338 E.00856
G1 X90.517 Y100.784 E.00891
G1 X90.454 Y101.012 E.00466
G1 X90.303 Y101.42 E.00856
G1 X90.098 Y101.823 E.00891
G1 X89.971 Y102.023 E.00466
G1 X89.707 Y102.37 E.00856
G1 X89.394 Y102.693 E.00885
G1 X89.043 Y102.979 E.0089
G1 X88.846 Y103.111 E.00466
G1 X88.465 Y103.321 E.00856
G1 X88.048 Y103.49 E.00885
G1 X87.614 Y103.609 E.00885
G1 X87.166 Y103.676 E.00891
G1 X86.947 Y103.689 E.0043
G1 X86.494 Y103.676 E.00891
G1 X86.047 Y103.608 E.00891
G1 X85.834 Y103.557 E.00431
G1 X85.405 Y103.412 E.00891
G1 X84.999 Y103.218 E.00885
G1 X84.618 Y102.977 E.00885
G1 X84.267 Y102.691 E.00891
G1 X84.11 Y102.539 E.0043
G1 X83.815 Y102.195 E.00891
G1 X83.564 Y101.821 E.00885
G1 X83.36 Y101.421 E.00884
G1 X83.2 Y100.981 E.0092
G1 X83.099 Y100.558 E.00856
G1 X83.067 Y100.341 E.0043
G1 X83.042 Y99.889 E.00891
G1 X83.07 Y99.44 E.00885
G1 X83.151 Y98.997 E.00885
G1 X83.284 Y98.568 E.00884
G1 X83.476 Y98.141 E.0092
G1 X83.7 Y97.767 E.00856
G1 X83.828 Y97.59 E.0043
G1 X84.436 Y96.891 E.01823
G1 X80.344 Y96.891 E.08049
G1 X80.031 Y96.854 E.00619
G1 X79.818 Y96.784 E.00442
G1 X79.687 Y96.718 E.00289
G1 X79.564 Y96.637 E.00289
G1 X79.396 Y96.488 E.00442
G1 X79.214 Y96.243 E.00601
G1 X79.121 Y96.045 E.0043
G1 X79.078 Y95.904 E.0029
G1 X79.042 Y95.589 E.00624
G1 X79.042 Y77.607 E.35367
G1 X79.051 Y77.448 E.00314
G1 X79.097 Y77.231 E.00435
G1 X79.181 Y77.019 E.00448
G1 X79.254 Y76.893 E.00288
G1 X79.346 Y76.77 E.00302
G1 X79.503 Y76.613 E.00436
G1 X79.687 Y76.484 E.00442
G1 X79.891 Y76.389 E.00442
G1 X80.111 Y76.33 E.00448
G1 X80.257 Y76.313 E.00289
G1 X93.397 Y76.313 E.25846
G1 X93.629 Y76.347 E.00461
G1 X93.842 Y76.417 E.00441
G1 X94.04 Y76.524 E.00442
G1 X94.216 Y76.663 E.00442
G1 X94.366 Y76.831 E.00442
G1 X94.484 Y77.022 E.00442
G1 X94.567 Y77.231 E.00442
G1 X94.612 Y77.448 E.00436
G1 X94.621 Y88.791 E.2231
G1 X93.442 Y88.791 E.02321
G1 X93.442 Y77.491 E.22226
G1 X80.813 Y77.491 E.24839
G1 X80.625 Y77.524 E.00376
G1 X80.463 Y77.611 E.00361
G1 X80.323 Y77.76 E.00403
G1 X80.245 Y77.925 E.00359
G1 X80.222 Y78.086 E.00319
G1 X80.222 Y95.116 E.33498
G1 X80.245 Y95.276 E.00318
G1 X80.32 Y95.437 E.00348
G1 X80.438 Y95.57 E.00351
G1 X80.596 Y95.667 E.00364
G1 X80.81 Y95.711 E.00431
G1 X93.024 Y95.711 E.24023
G1 X93.057 Y95.329 E.00753
G1 X93.103 Y95.16 E.00344
G1 X93.236 Y94.913 E.00552
G1 X93.393 Y94.746 E.00453
G1 X93.533 Y94.647 E.00337
G1 X93.749 Y94.553 E.00462
G1 X94.014 Y94.498 E.00532
G1 X99.909 Y86.078 E.20217
G1 X100.876 Y86.755 E.02321
G1 X94.98 Y95.175 E.20217
G1 X95.019 Y95.559 E.0076
G1 X94.975 Y95.8 E.00482
G1 X94.854 Y96.049 E.00544
G1 X94.695 Y96.234 E.00481
G1 X94.561 Y96.336 E.00331
G1 X94.299 Y96.461 E.00571
G1 X94.096 Y96.639 E.00532
G1 X93.906 Y96.755 E.00438
G1 X93.698 Y96.837 E.00438
G1 X93.483 Y96.881 E.00433
G1 X89.288 Y96.892 E.0825
; WIPE_START
M204 S6000
G1 X89.835 Y97.59 E-.16849
G1 X90.093 Y97.972 E-.08767
G1 X90.293 Y98.359 E-.0827
G1 X90.37 Y98.562 E-.04114
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




G1 X88.971 Y97.797
G1 Z5.6
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.359693
G1 F1500
M204 S6000
G1 X89.293 Y98.19 E.00846
G1 X89.487 Y98.511 E.00626
G1 X89.64 Y98.863 E.0064
G1 X89.776 Y99.35 E.00842
G1 X89.822 Y99.723 E.00626
G1 X89.807 Y100.246 E.00871
G1 X89.701 Y100.775 E.009
G1 X89.58 Y101.103 E.00582
G1 X89.316 Y101.575 E.00901
G1 X89.103 Y101.854 E.00584
G1 X88.857 Y102.109 E.0059
G1 X88.571 Y102.346 E.0062
G1 X88.123 Y102.609 E.00865
G1 X87.768 Y102.75 E.00636
G1 X87.409 Y102.843 E.00618
G1 X86.862 Y102.9 E.00916
G1 X86.326 Y102.856 E.00895
G1 X85.835 Y102.726 E.00846
G1 X85.381 Y102.526 E.00826
G1 X85.08 Y102.335 E.00593
G1 X84.758 Y102.066 E.007
G1 X84.443 Y101.714 E.00786
G1 X84.249 Y101.418 E.00589
G1 X84.086 Y101.104 E.0059
G1 X83.993 Y100.861 E.00434
G1 X83.901 Y100.532 E.00568
G1 X83.837 Y100.006 E.00884
G1 X83.856 Y99.536 E.00783
G1 X83.92 Y99.186 E.00593
G1 X84.059 Y98.762 E.00743
G1 X84.3 Y98.301 E.00867
G1 X84.624 Y97.872 E.00895
G1 X84.817 Y97.673 E.00463
; LINE_WIDTH: 0.400603
G1 X84.992 Y97.496 E.00464
; LINE_WIDTH: 0.438396
G1 X85.199 Y97.319 E.00561
; LINE_WIDTH: 0.477102
G1 X85.379 Y97.165 E.00533
; WIPE_START
G1 X85.199 Y97.319 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X88.115 Y97.367 Z6 F18000
G1 Z5.6
G1 E.4 F1800
; LINE_WIDTH: 0.437145
G1 F1500
M204 S6000
G1 X88.283 Y97.336 E.0035
; LINE_WIDTH: 0.464994
G1 X88.45 Y97.305 E.00374
; LINE_WIDTH: 0.467984
G1 X88.582 Y97.417 E.00383
; LINE_WIDTH: 0.426806
G1 X88.708 Y97.531 E.00339
; LINE_WIDTH: 0.382468
G1 X88.971 Y97.797 E.00666
; WIPE_START
G1 X88.708 Y97.531 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X93.609 Y96.151 Z6 F18000
G1 Z5.6
G1 E.4 F1800
; LINE_WIDTH: 0.0923747
G1 F1500
M204 S6000
G1 X93.813 Y96.03 E.00079
; WIPE_START
G1 X93.609 Y96.151 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X85.977 Y96.208 Z6 F18000
G1 X80.295 Y96.251 Z6
G1 Z5.6
G1 E.4 F1800
; LINE_WIDTH: 0.148012
G1 F1500
M204 S6000
G1 X79.982 Y96.09 E.00215
G1 X79.75 Y95.802 E.00225
; LINE_WIDTH: 0.101589
G1 X79.693 Y95.618 E.00073
; WIPE_START
G1 X79.75 Y95.802 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X79.723 Y88.17 Z6 F18000
G1 X79.686 Y77.601 Z6
M73 P94 R1
G1 Z5.6
G1 E.4 F1800
; LINE_WIDTH: 0.0997815
G1 F1500
M204 S6000
G1 X79.741 Y77.423 E.00069
; LINE_WIDTH: 0.15343
G1 X79.873 Y77.225 E.00152
G1 X80.041 Y77.074 E.00144
; LINE_WIDTH: 0.125726
G1 X80.225 Y76.991 E.00101
; LINE_WIDTH: 0.0896062
G1 X80.328 Y76.955 E.00035
; CHANGE_LAYER
; Z_HEIGHT: 5.72
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F1500
G1 X80.225 Y76.991 E-.38
; WIPE_END
G1 E-.02 F1800
; layer num/total_layer_count: 47/49
; update layer progress
M73 L47
M991 S0 P46 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z6 I-.583 J1.068 P1  F18000
G1 X93.851 Y84.425 Z6
G1 Z5.72
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X93.851 Y77.128 E.15444
G1 X94.036 Y77.076 E.00407
G1 X94.117 Y77.207 E.00325
G1 X94.173 Y77.349 E.00324
G1 X94.202 Y77.49 E.00306
G1 X94.212 Y88.382 E.23052
G1 X93.851 Y88.382 E.00764
G1 X93.851 Y84.485 E.08248
; WIPE_START
M204 S6000
G1 X93.851 Y82.485 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X93.871 Y90.117 Z6.12 F18000
G1 X93.884 Y95.441 Z6.12
G1 Z5.72
G1 E.4 F1800
G1 F1500
M204 S500
G1 X93.943 Y95.377 E.00185
G1 X94.159 Y95.319 E.00473
G1 X94.184 Y95.492 E.00371
G1 X94.151 Y95.598 E.00234
G1 X93.858 Y95.743 E.00691
G1 X93.879 Y95.501 E.00514
; WIPE_START
M204 S6000
G1 X93.943 Y95.377 E-.04357
G1 X94.159 Y95.319 E-.06964
G1 X94.184 Y95.492 E-.05461
G1 X94.151 Y95.598 E-.03456
G1 X93.858 Y95.743 E-.10191
G1 X93.879 Y95.501 E-.07572
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X88 Y97.08 Z6.12 F18000
G1 Z5.72
G1 E.4 F1800
G1 F1500
M204 S500
G1 X87.436 Y96.915 E.01244
G1 X87.06 Y96.864 E.00803
G1 X86.688 Y96.858 E.00787
G1 X86.154 Y96.929 E.01139
G1 X85.667 Y97.088 E.01085
G1 X85.561 Y96.922 E.00416
G1 X85.91 Y96.544 E.01089
G1 X87.761 Y96.544 E.03919
G1 X88.102 Y96.916 E.01067
G1 X88.032 Y97.029 E.00282
; WIPE_START
M204 S6000
G1 X87.436 Y96.915 E-.11527
G1 X87.06 Y96.864 E-.07212
G1 X86.688 Y96.858 E-.07065
G1 X86.154 Y96.929 E-.10226
G1 X86.056 Y96.961 E-.0197
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X89.008 Y101.358 Z6.12 F18000
G1 Z5.72
G1 E.4 F1800
G1 F1500
M204 S500
G1 X88.992 Y101.385 E.00066
G1 X88.699 Y101.741 E.00976
G1 X88.341 Y102.045 E.00995
G1 X87.934 Y102.28 E.00994
G1 X87.5 Y102.435 E.00975
G1 X87.183 Y102.498 E.00683
G1 X86.861 Y102.522 E.00685
G1 X86.404 Y102.486 E.0097
G1 X86.096 Y102.416 E.00668
G1 X85.793 Y102.307 E.00682
G1 X85.387 Y102.089 E.00975
G1 X85.02 Y101.796 E.00995
G1 X84.717 Y101.449 E.00975
G1 X84.543 Y101.177 E.00683
G1 X84.403 Y100.886 E.00683
G1 X84.267 Y100.446 E.00975
G1 X84.211 Y99.979 E.00996
G1 X84.24 Y99.512 E.0099
G1 X84.306 Y99.204 E.00667
G1 X84.41 Y98.898 E.00683
G1 X84.622 Y98.49 E.00974
G1 X84.904 Y98.125 E.00976
G1 X85.137 Y97.902 E.00682
G1 X85.389 Y97.713 E.00667
G1 X85.801 Y97.49 E.0099
G1 X86.249 Y97.345 E.00997
G1 X86.713 Y97.283 E.0099
G1 X87.028 Y97.288 E.00667
G1 X87.347 Y97.331 E.00682
G1 X87.789 Y97.46 E.00975
G1 X88.202 Y97.666 E.00975
G1 X88.465 Y97.852 E.00683
G1 X88.705 Y98.068 E.00683
G1 X88.992 Y98.417 E.00955
G1 X89.157 Y98.694 E.00683
G1 X89.286 Y98.981 E.00667
G1 X89.411 Y99.432 E.0099
G1 X89.453 Y99.901 E.00996
G1 X89.411 Y100.369 E.00995
G1 X89.289 Y100.813 E.00976
G1 X89.157 Y101.108 E.00683
G1 X89.039 Y101.307 E.0049
M204 S250
G1 X88.657 Y101.148 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X88.656 Y101.149 E.00001
G1 X88.407 Y101.453 E.00774
G1 X88.104 Y101.709 E.0078
G1 X87.761 Y101.907 E.00779
G1 X87.391 Y102.04 E.00774
G1 X87.128 Y102.091 E.00526
G1 X86.861 Y102.111 E.00527
G1 X86.466 Y102.081 E.0078
G1 X86.212 Y102.023 E.00513
G1 X85.96 Y101.932 E.00526
G1 X85.614 Y101.746 E.00773
G1 X85.304 Y101.499 E.0078
G1 X85.045 Y101.203 E.00773
G1 X84.901 Y100.977 E.00526
G1 X84.785 Y100.736 E.00526
G1 X84.669 Y100.361 E.00774
G1 X84.622 Y99.967 E.0078
G1 X84.647 Y99.568 E.00787
G1 X84.701 Y99.313 E.00512
G1 X84.787 Y99.06 E.00526
G1 X84.968 Y98.711 E.00773
G1 X85.209 Y98.4 E.00774
G1 X85.402 Y98.215 E.00526
G1 X85.611 Y98.058 E.00512
G1 X85.963 Y97.868 E.00787
G1 X86.34 Y97.745 E.0078
G1 X86.736 Y97.693 E.00787
G1 X86.997 Y97.697 E.00513
G1 X87.262 Y97.733 E.00526
G1 X87.639 Y97.843 E.00773
G1 X87.991 Y98.019 E.00774
G1 X88.21 Y98.173 E.00526
G1 X88.409 Y98.352 E.00526
G1 X88.656 Y98.653 E.00767
G1 X88.793 Y98.883 E.00526
G1 X88.9 Y99.121 E.00512
G1 X89.007 Y99.506 E.00787
G1 X89.042 Y99.901 E.0078
G1 X89.007 Y100.296 E.00779
G1 X88.902 Y100.675 E.00774
G1 X88.794 Y100.919 E.00526
G1 X88.687 Y101.097 E.00407
; WIPE_START
M204 S6000
G1 X88.656 Y101.149 E-.0115
G1 X88.407 Y101.453 E-.07475
G1 X88.104 Y101.709 E-.07531
G1 X87.761 Y101.907 E-.07527
G1 X87.391 Y102.04 E-.07472
G1 X87.128 Y102.091 E-.05084
G1 X87.036 Y102.098 E-.01761
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X88.01 Y96.12 Z6.12 F18000
G1 Z5.72
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X93.399 Y96.12 E.11407
G1 X93.462 Y95.4 E.0153
G1 X93.489 Y95.297 E.00225
G1 X93.563 Y95.163 E.00323
G1 X93.735 Y95.005 E.00494
G1 X93.873 Y94.945 E.0032
G1 X94.256 Y94.865 E.00827
G1 X100.01 Y86.648 E.21232
G1 X100.306 Y86.855 E.00765
G1 X94.552 Y95.073 E.21232
G1 X94.61 Y95.521 E.00957
G1 X94.582 Y95.672 E.00325
G1 X94.523 Y95.804 E.00307
G1 X94.435 Y95.916 E.00302
G1 X94.302 Y96.011 E.00346
G1 X94.079 Y96.109 E.00516
G1 X93.852 Y96.308 E.00638
G1 X93.723 Y96.387 E.00322
G1 X93.582 Y96.443 E.00321
G1 X93.441 Y96.472 E.00304
G1 X88.283 Y96.485 E.10917
G1 X89.384 Y97.685 E.03446
G1 X89.631 Y98.006 E.00859
G1 X89.736 Y98.172 E.00415
G1 X89.992 Y98.703 E.01247
G1 X90.116 Y99.103 E.00886
G1 X90.206 Y99.697 E.01273
G1 X90.189 Y100.29 E.01255
G1 X90.117 Y100.694 E.00868
G1 X90.066 Y100.882 E.00413
G1 X89.928 Y101.256 E.00842
G1 X89.742 Y101.621 E.00867
G1 X89.391 Y102.109 E.01273
G1 X88.965 Y102.522 E.01256
G1 X88.475 Y102.855 E.01254
G1 X88.104 Y103.032 E.00869
G1 X87.724 Y103.161 E.00849
G1 X87.332 Y103.243 E.00849
G1 X86.932 Y103.279 E.00849
G1 X86.531 Y103.267 E.00849
G1 X85.948 Y103.164 E.01254
G1 X85.559 Y103.032 E.00869
G1 X85.197 Y102.859 E.0085
G1 X84.858 Y102.644 E.00849
G1 X84.409 Y102.258 E.01253
G1 X84.141 Y101.947 E.00869
G1 X83.918 Y101.613 E.00849
G1 X83.736 Y101.257 E.00848
G1 X83.593 Y100.867 E.00877
G1 X83.475 Y100.3 E.01228
G1 X83.452 Y99.89 E.00869
G1 X83.477 Y99.49 E.00849
G1 X83.549 Y99.095 E.00849
G1 X83.668 Y98.712 E.00849
G1 X83.831 Y98.346 E.00848
G1 X84.044 Y97.99 E.00877
G1 X84.287 Y97.675 E.00842
G1 X85.39 Y96.482 E.0344
G1 X80.368 Y96.482 E.1063
G1 X80.12 Y96.453 E.00527
G1 X79.975 Y96.405 E.00324
G1 X79.814 Y96.312 E.00394
G1 X79.699 Y96.21 E.00324
G1 X79.567 Y96.032 E.0047
G1 X79.481 Y95.82 E.00483
G1 X79.451 Y95.565 E.00545
G1 X79.451 Y77.62 E.37982
G1 X79.49 Y77.349 E.00579
G1 X79.592 Y77.125 E.00521
G1 X79.693 Y76.998 E.00343
G1 X79.807 Y76.896 E.00324
G1 X80.031 Y76.774 E.0054
G1 X80.289 Y76.723 E.00558
G1 X93.369 Y76.723 E.27685
G1 X93.535 Y76.746 E.00354
G1 X93.68 Y76.794 E.00323
G1 X93.856 Y76.889 E.00424
G1 X93.807 Y77.082 E.0042
G1 X80.777 Y77.082 E.27579
G1 X80.488 Y77.133 E.00621
G1 X80.219 Y77.278 E.00648
G1 X80.002 Y77.495 E.00648
G1 X79.85 Y77.797 E.00717
G1 X79.812 Y78.056 E.00553
G1 X79.812 Y95.146 E.36173
G1 X79.849 Y95.395 E.00533
G1 X79.975 Y95.665 E.00629
G1 X80.172 Y95.887 E.00629
G1 X80.441 Y96.052 E.00668
G1 X80.768 Y96.12 E.00708
G1 X87.95 Y96.12 E.152
; WIPE_START
M204 S6000
G1 X89.95 Y96.12 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X89.212 Y96.892 Z6.12 F18000
G1 Z5.72
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X89.697 Y97.421 E.01412
G1 X89.967 Y97.772 E.0087
G1 X90.091 Y97.968 E.00457
G1 X90.295 Y98.362 E.00871
G1 X90.378 Y98.564 E.0043
G1 X90.513 Y99 E.00896
G1 X90.561 Y99.227 E.00457
G1 X90.614 Y99.667 E.00871
G1 X90.621 Y99.899 E.00457
G1 X90.596 Y100.338 E.00865
G1 X90.517 Y100.784 E.00891
G1 X90.456 Y101.008 E.00457
G1 X90.303 Y101.42 E.00865
G1 X90.098 Y101.823 E.00891
G1 X89.973 Y102.02 E.00457
G1 X89.705 Y102.372 E.00871
G1 X89.548 Y102.543 E.00457
G1 X89.224 Y102.84 E.00865
G1 X88.856 Y103.105 E.00891
G1 X88.668 Y103.216 E.0043
G1 X88.259 Y103.412 E.00891
G1 X87.833 Y103.556 E.00885
G1 X87.392 Y103.649 E.00885
G1 X86.944 Y103.689 E.00885
G1 X86.494 Y103.676 E.00885
G1 X86.046 Y103.608 E.00891
G1 X85.834 Y103.557 E.00431
G1 X85.405 Y103.412 E.00891
G1 X84.999 Y103.218 E.00885
G1 X84.618 Y102.977 E.00885
G1 X84.267 Y102.691 E.00891
G1 X84.11 Y102.539 E.0043
G1 X83.815 Y102.195 E.00891
G1 X83.564 Y101.821 E.00885
G1 X83.36 Y101.421 E.00884
G1 X83.201 Y100.986 E.00911
G1 X83.099 Y100.557 E.00865
G1 X83.067 Y100.341 E.0043
G1 X83.042 Y99.889 E.00891
G1 X83.07 Y99.44 E.00885
G1 X83.151 Y98.997 E.00885
G1 X83.284 Y98.567 E.00885
G1 X83.467 Y98.157 E.00884
G1 X83.706 Y97.759 E.00911
G1 X83.974 Y97.411 E.00865
G1 X84.455 Y96.891 E.01393
G1 X80.344 Y96.891 E.08086
G1 X80.031 Y96.854 E.00619
G1 X79.818 Y96.784 E.00442
G1 X79.687 Y96.718 E.00289
G1 X79.564 Y96.637 E.00289
G1 X79.396 Y96.488 E.00442
G1 X79.214 Y96.243 E.00601
G1 X79.121 Y96.043 E.00433
G1 X79.078 Y95.904 E.00286
G1 X79.042 Y95.589 E.00625
G1 X79.042 Y77.607 E.35367
G1 X79.051 Y77.45 E.00311
G1 X79.097 Y77.231 E.00439
G1 X79.181 Y77.019 E.00448
G1 X79.253 Y76.895 E.00283
G1 X79.394 Y76.716 E.00448
G1 X79.562 Y76.567 E.00442
G1 X79.756 Y76.447 E.00448
G1 X79.891 Y76.389 E.00289
G1 X80.031 Y76.347 E.00289
G1 X80.26 Y76.313 E.00454
G1 X93.399 Y76.313 E.25844
G1 X93.629 Y76.347 E.00458
G1 X93.842 Y76.417 E.00442
G1 X94.04 Y76.524 E.00442
G1 X94.216 Y76.663 E.00442
G1 X94.366 Y76.831 E.00442
G1 X94.484 Y77.022 E.00442
G1 X94.567 Y77.231 E.00442
G1 X94.612 Y77.448 E.00436
G1 X94.621 Y88.791 E.2231
G1 X93.442 Y88.791 E.02321
G1 X93.442 Y77.491 E.22226
G1 X80.813 Y77.491 E.24839
G1 X80.625 Y77.524 E.00377
G1 X80.466 Y77.61 E.00355
G1 X80.338 Y77.737 E.00355
G1 X80.246 Y77.922 E.00407
G1 X80.222 Y78.086 E.00325
G1 X80.222 Y95.116 E.33497
G1 X80.245 Y95.277 E.00319
G1 X80.32 Y95.437 E.00349
G1 X80.438 Y95.57 E.00349
G1 X80.594 Y95.666 E.00361
G1 X80.81 Y95.711 E.00434
G1 X93.024 Y95.711 E.24024
G1 X93.057 Y95.329 E.00754
G1 X93.146 Y95.06 E.00557
G1 X93.236 Y94.914 E.00338
G1 X93.394 Y94.745 E.00455
G1 X93.533 Y94.647 E.00334
M73 P95 R1
G1 X93.749 Y94.553 E.00462
G1 X94.014 Y94.498 E.00532
G1 X99.909 Y86.078 E.20217
G1 X100.876 Y86.755 E.02321
G1 X94.98 Y95.175 E.20217
G1 X95.019 Y95.559 E.0076
G1 X94.976 Y95.794 E.00469
G1 X94.88 Y96.01 E.00464
G1 X94.702 Y96.228 E.00554
G1 X94.505 Y96.369 E.00476
G1 X94.301 Y96.459 E.00438
G1 X94.096 Y96.639 E.00538
G1 X93.906 Y96.755 E.00438
G1 X93.698 Y96.837 E.00438
G1 X93.483 Y96.881 E.00433
G1 X89.272 Y96.892 E.08283
; WIPE_START
M204 S6000
G1 X89.697 Y97.421 E-.12901
G1 X89.967 Y97.772 E-.08406
G1 X90.091 Y97.968 E-.04419
G1 X90.295 Y98.362 E-.08418
G1 X90.372 Y98.55 E-.03856
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




G1 X88.721 Y97.549
G1 Z5.72
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.360201
G1 F1500
M204 S6000
G1 X89.088 Y97.93 E.00883
G1 X89.406 Y98.365 E.00899
G1 X89.635 Y98.834 E.00871
G1 X89.781 Y99.349 E.00893
G1 X89.832 Y99.893 E.00911
G1 X89.807 Y100.246 E.0059
G1 X89.744 Y100.605 E.00608
G1 X89.645 Y100.928 E.00564
G1 X89.494 Y101.271 E.00626
G1 X89.293 Y101.612 E.00659
G1 X88.979 Y101.996 E.00827
G1 X88.545 Y102.361 E.00946
G1 X88.078 Y102.626 E.00896
G1 X87.624 Y102.794 E.00808
G1 X87.244 Y102.871 E.00647
G1 X86.873 Y102.9 E.00621
G1 X86.359 Y102.861 E.0086
G1 X86.001 Y102.778 E.00614
G1 X85.651 Y102.657 E.00617
G1 X85.168 Y102.395 E.00917
G1 X84.75 Y102.057 E.00897
G1 X84.445 Y101.716 E.00764
G1 X84.218 Y101.37 E.00691
G1 X84.048 Y101.013 E.0066
G1 X83.899 Y100.51 E.00875
G1 X83.835 Y100.004 E.0085
G1 X83.856 Y99.536 E.00782
G1 X83.92 Y99.186 E.00594
G1 X84.059 Y98.761 E.00745
G1 X84.297 Y98.299 E.00867
G1 X84.579 Y97.922 E.00786
G1 X84.877 Y97.612 E.00718
; LINE_WIDTH: 0.397452
G1 X85.02 Y97.481 E.00359
; LINE_WIDTH: 0.430474
G1 X85.148 Y97.366 E.00348
; LINE_WIDTH: 0.470426
G1 X85.444 Y97.134 E.00834
; WIPE_START
G1 X85.148 Y97.366 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X88.217 Y97.132 Z6.12 F18000
G1 Z5.72
G1 E.4 F1800
; LINE_WIDTH: 0.485608
G1 F1500
M204 S6000
G1 X88.413 Y97.279 E.00562
; LINE_WIDTH: 0.458348
G1 X88.572 Y97.417 E.00455
; LINE_WIDTH: 0.41662
G1 X88.705 Y97.534 E.00344
; LINE_WIDTH: 0.395955
G1 X88.721 Y97.549 E.00041
; WIPE_START
G1 X88.705 Y97.534 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X93.61 Y96.144 Z6.12 F18000
G1 Z5.72
G1 E.4 F1800
; LINE_WIDTH: 0.109766
G1 F1500
M204 S6000
G1 X93.837 Y96.009 E.00111
; WIPE_START
G1 X93.61 Y96.144 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X85.978 Y96.205 Z6.12 F18000
G1 X80.294 Y96.251 Z6.12
G1 Z5.72
G1 E.4 F1800
; LINE_WIDTH: 0.148061
G1 F1500
M204 S6000
G1 X79.982 Y96.09 E.00215
G1 X79.75 Y95.804 E.00224
; LINE_WIDTH: 0.102115
G1 X79.693 Y95.617 E.00074
; WIPE_START
G1 X79.75 Y95.804 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X79.723 Y88.171 Z6.12 F18000
G1 X79.686 Y77.604 Z6.12
G1 Z5.72
G1 E.4 F1800
; LINE_WIDTH: 0.089824
G1 F1500
M204 S6000
G1 X79.715 Y77.514 E.0003
; LINE_WIDTH: 0.115113
G1 X79.743 Y77.424 E.00042
; LINE_WIDTH: 0.152496
G1 X79.794 Y77.32 E.00073
G1 X79.902 Y77.193 E.00105
G1 X80.051 Y77.067 E.00124
; LINE_WIDTH: 0.127925
G1 X80.224 Y76.99 E.00096
; LINE_WIDTH: 0.0929702
G1 X80.325 Y76.954 E.00036
; CHANGE_LAYER
; Z_HEIGHT: 5.84
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F1500
G1 X80.224 Y76.99 E-.38
; WIPE_END
G1 E-.02 F1800
; layer num/total_layer_count: 48/49
; update layer progress
M73 L48
M991 S0 P47 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z6.12 I-.582 J1.069 P1  F18000
G1 X93.851 Y84.415 Z6.12
G1 Z5.84
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X93.851 Y77.128 E.15423
G1 X94.036 Y77.076 E.00407
G1 X94.117 Y77.207 E.00325
G1 X94.173 Y77.349 E.00324
G1 X94.202 Y77.49 E.00306
G1 X94.212 Y88.382 E.23052
G1 X93.851 Y88.382 E.00764
G1 X93.851 Y84.475 E.08268
; WIPE_START
M204 S6000
G1 X93.851 Y82.475 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X93.874 Y90.108 Z6.24 F18000
G1 X93.89 Y95.435 Z6.24
G1 Z5.84
G1 E.4 F1800
G1 F1500
M204 S500
G1 X93.954 Y95.367 E.00196
G1 X94.157 Y95.318 E.00442
G1 X94.183 Y95.468 E.00322
G1 X94.17 Y95.567 E.00211
G1 X94.132 Y95.612 E.00125
G1 X93.863 Y95.741 E.00631
G1 X93.885 Y95.494 E.00524
; WIPE_START
M204 S6000
G1 X93.954 Y95.367 E-.04547
G1 X94.157 Y95.318 E-.06558
G1 X94.183 Y95.468 E-.04778
G1 X94.17 Y95.567 E-.03127
G1 X94.132 Y95.612 E-.01851
G1 X93.863 Y95.741 E-.09365
G1 X93.885 Y95.494 E-.07774
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X87.992 Y97.078 Z6.24 F18000
G1 Z5.84
G1 E.4 F1800
G1 F1500
M204 S500
G1 X87.436 Y96.915 E.01227
G1 X87.059 Y96.864 E.00804
G1 X86.685 Y96.858 E.00793
G1 X86.154 Y96.929 E.01132
G1 X85.667 Y97.088 E.01086
G1 X85.561 Y96.922 E.00416
G1 X85.91 Y96.544 E.01089
G1 X87.754 Y96.544 E.03903
G1 X88.094 Y96.913 E.01063
G1 X88.024 Y97.027 E.00283
; WIPE_START
M204 S6000
G1 X87.436 Y96.915 E-.11375
G1 X87.059 Y96.864 E-.07218
G1 X86.685 Y96.858 E-.0712
G1 X86.154 Y96.929 E-.10166
G1 X86.048 Y96.964 E-.02122
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X88.973 Y101.408 Z6.24 F18000
G1 Z5.84
G1 E.4 F1800
G1 F1500
M204 S500
G1 X88.699 Y101.741 E.00912
G1 X88.341 Y102.045 E.00995
G1 X87.934 Y102.28 E.00995
G1 X87.5 Y102.435 E.00975
G1 X87.183 Y102.498 E.00683
G1 X86.871 Y102.521 E.00663
G1 X86.558 Y102.507 E.00663
G1 X86.239 Y102.454 E.00683
G1 X85.801 Y102.312 E.00975
G1 X85.387 Y102.089 E.00995
G1 X85.02 Y101.796 E.00995
G1 X84.711 Y101.442 E.00995
G1 X84.47 Y101.038 E.00995
G1 X84.308 Y100.607 E.00975
G1 X84.241 Y100.291 E.00683
G1 X84.212 Y99.97 E.00683
G1 X84.239 Y99.51 E.00975
G1 X84.351 Y99.053 E.00995
G1 X84.538 Y98.633 E.00975
G1 X84.712 Y98.361 E.00683
G1 X84.917 Y98.112 E.00683
G1 X85.252 Y97.809 E.00955
G1 X85.521 Y97.632 E.00683
G1 X85.81 Y97.487 E.00683
G1 X86.249 Y97.345 E.00976
G1 X86.71 Y97.283 E.00984
G1 X87.028 Y97.288 E.00673
G1 X87.347 Y97.331 E.00683
G1 X87.789 Y97.46 E.00975
G1 X88.201 Y97.666 E.00975
G1 X88.465 Y97.852 E.00683
G1 X88.702 Y98.065 E.00673
G1 X88.998 Y98.424 E.00985
G1 X89.227 Y98.835 E.00997
G1 X89.377 Y99.275 E.00984
G1 X89.433 Y99.588 E.00673
G1 X89.453 Y99.91 E.00683
G1 X89.412 Y100.36 E.00955
G1 X89.336 Y100.673 E.00683
G1 X89.224 Y100.971 E.00673
G1 X89.008 Y101.36 E.00942
M204 S250
G1 X88.657 Y101.148 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X88.407 Y101.452 E.00775
G1 X88.104 Y101.709 E.0078
G1 X87.761 Y101.907 E.0078
G1 X87.391 Y102.04 E.00773
G1 X87.128 Y102.091 E.00526
G1 X86.865 Y102.111 E.0052
G1 X86.601 Y102.099 E.0052
G1 X86.337 Y102.055 E.00527
G1 X85.963 Y101.934 E.00773
G1 X85.614 Y101.746 E.00779
G1 X85.304 Y101.499 E.0078
G1 X85.043 Y101.201 E.00779
G1 X84.84 Y100.86 E.0078
G1 X84.702 Y100.492 E.00773
G1 X84.646 Y100.23 E.00526
G1 X84.622 Y99.964 E.00526
G1 X84.645 Y99.571 E.00773
G1 X84.739 Y99.186 E.0078
G1 X84.899 Y98.827 E.00773
G1 X85.043 Y98.602 E.00526
G1 X85.213 Y98.395 E.00526
G1 X85.503 Y98.134 E.00767
G1 X85.726 Y97.987 E.00526
G1 X85.966 Y97.867 E.00526
G1 X86.34 Y97.745 E.00774
G1 X86.734 Y97.693 E.00782
G1 X86.997 Y97.697 E.00517
G1 X87.262 Y97.733 E.00526
G1 X87.639 Y97.843 E.00773
G1 X87.991 Y98.019 E.00773
G1 X88.21 Y98.173 E.00526
G1 X88.405 Y98.349 E.00518
G1 X88.658 Y98.655 E.00782
G1 X88.851 Y99.002 E.0078
G1 X88.979 Y99.378 E.00782
G1 X89.026 Y99.637 E.00517
G1 X89.042 Y99.904 E.00526
G1 X89.007 Y100.292 E.00767
G1 X88.944 Y100.552 E.00526
G1 X88.852 Y100.799 E.00517
G1 X88.686 Y101.096 E.00669
; WIPE_START
M204 S6000
G1 X88.407 Y101.452 E-.08608
G1 X88.104 Y101.709 E-.0753
G1 X87.761 Y101.907 E-.07532
G1 X87.391 Y102.04 E-.07469
G1 X87.128 Y102.091 E-.05085
G1 X87.035 Y102.098 E-.01776
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X88.002 Y96.12 Z6.24 F18000
G1 Z5.84
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X93.416 Y96.12 E.11459
G1 X93.455 Y95.443 E.01436
G1 X93.477 Y95.335 E.00232
G1 X93.563 Y95.164 E.00406
G1 X93.665 Y95.054 E.00317
G1 X93.824 Y94.962 E.0039
G1 X94.262 Y94.857 E.00952
G1 X100.01 Y86.648 E.21211
G1 X100.306 Y86.855 E.00765
G1 X94.546 Y95.081 E.21254
G1 X94.609 Y95.529 E.00958
G1 X94.564 Y95.728 E.00432
G1 X94.516 Y95.816 E.00212
G1 X94.419 Y95.927 E.00312
G1 X94.302 Y96.011 E.00306
G1 X94.079 Y96.109 E.00516
G1 X93.852 Y96.308 E.00638
G1 X93.723 Y96.387 E.00321
G1 X93.582 Y96.443 E.00321
G1 X93.441 Y96.472 E.00304
G1 X88.277 Y96.485 E.1093
G1 X89.376 Y97.675 E.03428
G1 X89.73 Y98.162 E.01274
G1 X89.992 Y98.703 E.01273
G1 X90.114 Y99.095 E.00869
G1 X90.205 Y99.688 E.0127
G1 X90.206 Y100.09 E.00852
G1 X90.16 Y100.489 E.0085
G1 X90.004 Y101.069 E.01271
G1 X89.741 Y101.622 E.01294
G1 X89.644 Y101.776 E.00386
G1 X89.267 Y102.245 E.01273
G1 X88.965 Y102.522 E.00869
G1 X88.639 Y102.756 E.00849
G1 X88.281 Y102.954 E.00867
G1 X87.733 Y103.159 E.01237
G1 X87.332 Y103.243 E.00869
G1 X86.932 Y103.279 E.00849
G1 X86.531 Y103.267 E.00849
G1 X85.948 Y103.164 E.01254
G1 X85.559 Y103.032 E.00869
G1 X85.197 Y102.859 E.00849
G1 X84.858 Y102.644 E.00849
G1 X84.409 Y102.258 E.01254
G1 X84.141 Y101.947 E.00869
G1 X83.918 Y101.613 E.00849
G1 X83.736 Y101.256 E.00848
G1 X83.595 Y100.872 E.00868
G1 X83.475 Y100.3 E.01237
G1 X83.452 Y99.89 E.00869
G1 X83.477 Y99.49 E.00849
G1 X83.549 Y99.095 E.00849
G1 X83.668 Y98.712 E.00849
G1 X83.831 Y98.346 E.00848
G1 X84.042 Y97.994 E.00868
G1 X84.287 Y97.675 E.00851
G1 X85.39 Y96.482 E.0344
G1 X80.368 Y96.482 E.1063
G1 X80.037 Y96.429 E.00709
G1 X79.814 Y96.311 E.00535
G1 X79.701 Y96.211 E.00318
G1 X79.567 Y96.031 E.00476
G1 X79.481 Y95.821 E.00482
G1 X79.451 Y95.565 E.00546
G1 X79.451 Y77.619 E.37983
G1 X79.492 Y77.341 E.00596
G1 X79.598 Y77.118 E.00521
G1 X79.761 Y76.932 E.00526
G1 X79.892 Y76.84 E.00338
G1 X80.039 Y76.772 E.00343
G1 X80.289 Y76.723 E.0054
G1 X93.371 Y76.723 E.27688
G1 X93.535 Y76.746 E.0035
G1 X93.679 Y76.794 E.00323
G1 X93.856 Y76.889 E.00424
G1 X93.807 Y77.082 E.0042
G1 X80.786 Y77.082 E.2756
G1 X80.528 Y77.12 E.00553
G1 X80.226 Y77.271 E.00717
G1 X80.002 Y77.495 E.00669
G1 X79.85 Y77.797 E.00717
G1 X79.812 Y78.056 E.00553
M73 P96 R1
G1 X79.812 Y95.146 E.36173
M73 P96 R0
G1 X79.849 Y95.395 E.00533
G1 X79.975 Y95.665 E.00629
G1 X80.172 Y95.887 E.00629
G1 X80.441 Y96.053 E.00669
G1 X80.768 Y96.12 E.00707
G1 X87.942 Y96.12 E.15183
; WIPE_START
M204 S6000
G1 X89.942 Y96.12 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X89.21 Y96.892 Z6.24 F18000
G1 Z5.84
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X89.689 Y97.411 E.01389
G1 X89.967 Y97.772 E.00898
G1 X90.085 Y97.957 E.0043
G1 X90.295 Y98.362 E.00897
G1 X90.378 Y98.564 E.0043
G1 X90.512 Y98.997 E.00891
G1 X90.594 Y99.443 E.00891
G1 X90.614 Y99.669 E.00447
G1 X90.615 Y100.114 E.00874
G1 X90.563 Y100.561 E.00885
G1 X90.458 Y101.001 E.00891
G1 X90.388 Y101.211 E.00436
G1 X90.301 Y101.425 E.00454
G1 X90.097 Y101.824 E.00881
G1 X89.981 Y102.009 E.0043
G1 X89.705 Y102.372 E.00897
G1 X89.557 Y102.534 E.0043
G1 X89.224 Y102.84 E.00891
G1 X88.858 Y103.103 E.00885
G1 X88.457 Y103.324 E.00902
G1 X88.045 Y103.491 E.00874
G1 X87.836 Y103.555 E.0043
G1 X87.392 Y103.649 E.00891
G1 X86.944 Y103.689 E.00885
G1 X86.494 Y103.676 E.00885
G1 X86.046 Y103.608 E.00891
G1 X85.834 Y103.557 E.0043
G1 X85.405 Y103.412 E.00891
G1 X84.999 Y103.218 E.00885
G1 X84.618 Y102.977 E.00885
G1 X84.267 Y102.691 E.00891
G1 X84.11 Y102.538 E.00431
G1 X83.815 Y102.195 E.00891
G1 X83.564 Y101.821 E.00885
G1 X83.36 Y101.421 E.00884
G1 X83.202 Y100.99 E.00902
G1 X83.099 Y100.558 E.00874
G1 X83.067 Y100.341 E.00431
G1 X83.042 Y99.889 E.00891
G1 X83.07 Y99.44 E.00885
G1 X83.151 Y98.997 E.00885
G1 X83.284 Y98.567 E.00885
G1 X83.467 Y98.156 E.00884
G1 X83.703 Y97.763 E.00902
G1 X83.974 Y97.411 E.00874
G1 X84.455 Y96.891 E.01393
G1 X80.344 Y96.891 E.08086
G1 X80.028 Y96.854 E.00625
G1 X79.891 Y96.813 E.00283
G1 X79.684 Y96.716 E.00448
G1 X79.564 Y96.637 E.00283
G1 X79.398 Y96.49 E.00436
G1 X79.214 Y96.243 E.00606
G1 X79.12 Y96.042 E.00436
G1 X79.079 Y95.904 E.00283
G1 X79.042 Y95.589 E.00625
G1 X79.042 Y77.607 E.35368
G1 X79.051 Y77.451 E.00307
G1 X79.097 Y77.228 E.00448
G1 X79.148 Y77.09 E.00289
G1 X79.254 Y76.893 E.00442
G1 X79.396 Y76.714 E.00448
G1 X79.503 Y76.613 E.00289
G1 X79.687 Y76.484 E.00442
G1 X79.893 Y76.388 E.00448
G1 X80.034 Y76.346 E.00289
G1 X80.26 Y76.313 E.00448
G1 X93.401 Y76.313 E.25847
G1 X93.629 Y76.346 E.00454
G1 X93.842 Y76.417 E.00442
G1 X94.04 Y76.524 E.00442
G1 X94.216 Y76.663 E.00442
G1 X94.366 Y76.831 E.00442
G1 X94.484 Y77.022 E.00443
G1 X94.567 Y77.231 E.00442
G1 X94.612 Y77.448 E.00436
G1 X94.621 Y88.791 E.2231
G1 X93.442 Y88.791 E.02321
G1 X93.442 Y77.491 E.22226
G1 X80.816 Y77.491 E.24833
G1 X80.653 Y77.515 E.00325
G1 X80.468 Y77.608 E.00406
G1 X80.338 Y77.738 E.00362
G1 X80.246 Y77.922 E.00406
G1 X80.222 Y78.086 E.00325
G1 X80.222 Y95.116 E.33498
G1 X80.245 Y95.276 E.00319
G1 X80.32 Y95.437 E.00349
G1 X80.438 Y95.57 E.00349
G1 X80.594 Y95.666 E.00361
G1 X80.81 Y95.711 E.00433
G1 X93.03 Y95.711 E.24035
G1 X93.048 Y95.389 E.00634
G1 X93.084 Y95.218 E.00344
G1 X93.147 Y95.058 E.00339
G1 X93.236 Y94.914 E.00333
G1 X93.395 Y94.744 E.00458
G1 X93.536 Y94.645 E.00338
G1 X93.689 Y94.573 E.00332
G1 X94.016 Y94.495 E.00662
G1 X99.909 Y86.078 E.2021
G1 X100.876 Y86.755 E.02321
G1 X94.978 Y95.178 E.20224
G1 X95.015 Y95.387 E.00418
G1 X95.019 Y95.562 E.00344
G1 X94.975 Y95.8 E.00476
G1 X94.853 Y96.051 E.00549
G1 X94.697 Y96.232 E.00469
G1 X94.505 Y96.369 E.00464
G1 X94.301 Y96.459 E.00439
G1 X94.096 Y96.639 E.00538
G1 X93.906 Y96.755 E.00438
G1 X93.698 Y96.837 E.00438
G1 X93.483 Y96.881 E.00433
G1 X89.27 Y96.892 E.08287
; WIPE_START
M204 S6000
G1 X89.689 Y97.411 E-.12675
G1 X89.967 Y97.772 E-.0867
G1 X90.085 Y97.957 E-.04157
G1 X90.295 Y98.362 E-.08669
G1 X90.371 Y98.548 E-.03829
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




G1 X88.704 Y97.534
G1 Z5.84
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.415298
G1 F1500
M204 S6000
G1 X88.572 Y97.418 E.00343
; LINE_WIDTH: 0.456382
G1 X88.412 Y97.28 E.00452
; LINE_WIDTH: 0.484584
G1 X88.211 Y97.129 E.00578
M204 S10000
G1 X88.704 Y97.534 F18000
; LINE_WIDTH: 0.360377
G1 F1500
M204 S6000
G1 X89.081 Y97.921 E.00901
G1 X89.399 Y98.356 E.009
G1 X89.575 Y98.696 E.00639
G1 X89.74 Y99.168 E.00835
G1 X89.811 Y99.545 E.00639
G1 X89.827 Y99.928 E.00641
G1 X89.786 Y100.423 E.0083
G1 X89.7 Y100.781 E.00615
G1 X89.573 Y101.118 E.00602
G1 X89.319 Y101.578 E.00876
G1 X88.994 Y101.98 E.00864
G1 X88.722 Y102.224 E.0061
G1 X88.435 Y102.432 E.00593
G1 X88.106 Y102.616 E.00629
G1 X87.633 Y102.791 E.00842
G1 X87.224 Y102.873 E.00697
G1 X86.886 Y102.899 E.00566
G1 X86.565 Y102.888 E.00537
G1 X86.203 Y102.834 E.0061
G1 X85.7 Y102.678 E.00879
G1 X85.383 Y102.522 E.0059
G1 X85.083 Y102.335 E.0059
G1 X84.684 Y101.992 E.00878
G1 X84.414 Y101.676 E.00694
G1 X84.137 Y101.215 E.00898
G1 X83.96 Y100.764 E.00809
G1 X83.867 Y100.338 E.00728
G1 X83.834 Y99.963 E.00628
G1 X83.864 Y99.469 E.00827
G1 X83.99 Y98.946 E.00898
G1 X84.17 Y98.522 E.00769
G1 X84.357 Y98.209 E.00609
G1 X84.579 Y97.922 E.00606
; LINE_WIDTH: 0.379509
G1 X85.016 Y97.481 E.01096
; LINE_WIDTH: 0.449086
G1 X85.26 Y97.274 E.00676
G1 X85.284 Y97.279 E.0005
; LINE_WIDTH: 0.435294
G1 X85.307 Y97.284 E.00049
; LINE_WIDTH: 0.397119
G1 X85.583 Y97.351 E.00526
; WIPE_START
G1 X85.307 Y97.284 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X80.28 Y96.257 Z6.24 F18000
G1 Z5.84
G1 E.4 F1800
; LINE_WIDTH: 0.1505
G1 F1500
M204 S6000
G1 X79.988 Y96.092 E.00209
G1 X79.91 Y96.018 E.00067
G1 X79.75 Y95.803 E.00166
; LINE_WIDTH: 0.102251
G1 X79.693 Y95.617 E.00074
; WIPE_START
G1 X79.75 Y95.803 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X87.38 Y95.984 Z6.24 F18000
G1 X93.628 Y96.132 Z6.24
G1 Z5.84
G1 E.4 F1800
; LINE_WIDTH: 0.0967329
G1 F1500
M204 S6000
G1 X93.837 Y96.009 E.00086
; WIPE_START
G1 X93.628 Y96.132 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X89.038 Y90.033 Z6.24 F18000
G1 X79.686 Y77.604 Z6.24
G1 Z5.84
G1 E.4 F1800
; LINE_WIDTH: 0.0910159
G1 F1500
M204 S6000
G1 X79.727 Y77.485 E.00041
; LINE_WIDTH: 0.121169
G1 X79.768 Y77.365 E.0006
; LINE_WIDTH: 0.149395
G1 X79.944 Y77.151 E.00171
G1 X80.061 Y77.058 E.00092
G1 X80.181 Y77.002 E.00082
; LINE_WIDTH: 0.0997704
G1 X80.336 Y76.955 E.0006
; CHANGE_LAYER
; Z_HEIGHT: 5.96
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F1500
G1 X80.181 Y77.002 E-.38
; WIPE_END
G1 E-.02 F1800
; layer num/total_layer_count: 49/49
; update layer progress
M73 L49
M991 S0 P48 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z6.24 I-1.148 J.403 P1  F18000
G1 X88.657 Y101.148 Z6.24
G1 Z5.96
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X88.406 Y101.453 E.00775
G1 X88.104 Y101.709 E.00779
G1 X87.764 Y101.905 E.00773
G1 X87.515 Y102.003 E.00526
G1 X87.256 Y102.07 E.00526
G1 X86.865 Y102.111 E.00773
G1 X86.472 Y102.082 E.00775
G1 X86.212 Y102.023 E.00525
G1 X85.96 Y101.932 E.00526
G1 X85.613 Y101.746 E.00774
G1 X85.304 Y101.499 E.00779
G1 X85.043 Y101.2 E.0078
G1 X84.841 Y100.861 E.00777
G1 X84.74 Y100.616 E.00521
G1 X84.669 Y100.359 E.00524
G1 X84.622 Y99.97 E.00771
G1 X84.63 Y99.703 E.00526
G1 X84.67 Y99.438 E.00527
G1 X84.786 Y99.062 E.00773
G1 X84.968 Y98.711 E.00779
G1 X85.209 Y98.399 E.00774
G1 X85.402 Y98.215 E.00525
G1 X85.615 Y98.055 E.00522
G1 X85.963 Y97.868 E.00777
G1 X86.34 Y97.745 E.00779
G1 X86.731 Y97.693 E.00777
G1 X86.997 Y97.697 E.00523
G1 X87.262 Y97.733 E.00526
G1 X87.639 Y97.843 E.00774
G1 X87.993 Y98.02 E.00777
G1 X88.21 Y98.173 E.00522
G1 X88.407 Y98.35 E.00522
G1 X88.658 Y98.655 E.00778
G1 X88.851 Y99.002 E.0078
G1 X88.978 Y99.374 E.00774
G1 X89.026 Y99.637 E.00525
G1 X89.042 Y99.904 E.00527
G1 X89.007 Y100.293 E.00767
G1 X88.944 Y100.552 E.00525
M73 P97 R0
G1 X88.851 Y100.801 E.00523
G1 X88.686 Y101.096 E.00664
; WIPE_START
M204 S6000
G1 X88.406 Y101.453 E-.08615
G1 X88.104 Y101.709 E-.07526
G1 X87.764 Y101.905 E-.07472
G1 X87.515 Y102.003 E-.05086
G1 X87.256 Y102.07 E-.05082
G1 X87.035 Y102.094 E-.04219
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X89.21 Y96.892 Z6.36 F18000
G1 Z5.96
G1 E.4 F1800
G1 F1500
M204 S500
G1 X89.691 Y97.414 E.01396
G1 X89.967 Y97.772 E.00889
G1 X90.085 Y97.957 E.00431
G1 X90.293 Y98.359 E.00891
G1 X90.453 Y98.783 E.00891
G1 X90.512 Y98.997 E.00436
G1 X90.559 Y99.218 E.00444
G1 X90.614 Y99.664 E.00884
G1 X90.615 Y100.117 E.00891
G1 X90.597 Y100.335 E.0043
G1 X90.517 Y100.784 E.00897
G1 X90.459 Y100.999 E.00438
G1 X90.303 Y101.42 E.00884
G1 X90.097 Y101.824 E.00891
G1 X89.981 Y102.009 E.00431
G1 X89.705 Y102.372 E.00897
G1 X89.557 Y102.534 E.00431
G1 X89.224 Y102.84 E.00891
G1 X88.858 Y103.103 E.00885
G1 X88.465 Y103.321 E.00885
G1 X88.044 Y103.491 E.00893
G1 X87.611 Y103.61 E.00883
G1 X87.395 Y103.649 E.00431
G1 X86.944 Y103.689 E.00891
G1 X86.494 Y103.676 E.00885
G1 X86.046 Y103.608 E.00891
G1 X85.834 Y103.557 E.0043
G1 X85.405 Y103.412 E.00891
G1 X84.999 Y103.218 E.00884
G1 X84.807 Y103.105 E.00438
G1 X84.44 Y102.84 E.00891
G1 X84.108 Y102.536 E.00885
G1 X83.815 Y102.195 E.00885
G1 X83.565 Y101.821 E.00885
G1 X83.36 Y101.42 E.00885
G1 X83.203 Y100.994 E.00892
G1 X83.099 Y100.557 E.00884
G1 X83.067 Y100.341 E.0043
G1 X83.042 Y99.889 E.00891
G1 X83.07 Y99.44 E.00885
G1 X83.151 Y98.997 E.00885
G1 X83.284 Y98.567 E.00885
G1 X83.468 Y98.156 E.00885
G1 X83.7 Y97.767 E.00891
G1 X83.828 Y97.59 E.0043
G1 X84.436 Y96.891 E.01822
G1 X80.344 Y96.891 E.08049
G1 X80.028 Y96.854 E.00625
G1 X79.892 Y96.813 E.0028
G1 X79.69 Y96.719 E.00439
G1 X79.445 Y96.536 E.00601
G1 X79.296 Y96.369 E.00442
G1 X79.215 Y96.246 E.00289
G1 X79.149 Y96.114 E.00289
G1 X79.078 Y95.902 E.00439
G1 X79.042 Y95.589 E.00622
G1 X79.042 Y77.61 E.35362
G1 X79.062 Y77.374 E.00466
G1 X79.095 Y77.234 E.00283
G1 X79.181 Y77.02 E.00454
G1 X79.254 Y76.892 E.00289
G1 X79.343 Y76.773 E.00292
G1 X79.503 Y76.613 E.00445
G1 X79.687 Y76.484 E.00442
G1 X79.893 Y76.388 E.00448
G1 X80.032 Y76.347 E.00285
G1 X80.26 Y76.313 E.00452
G1 X93.402 Y76.313 E.2585
G1 X93.629 Y76.346 E.00451
G1 X93.842 Y76.417 E.00442
G1 X94.04 Y76.524 E.00442
G1 X94.216 Y76.663 E.00442
G1 X94.366 Y76.831 E.00442
G1 X94.484 Y77.022 E.00442
G1 X94.567 Y77.231 E.00442
G1 X94.612 Y77.448 E.00436
G1 X94.621 Y88.791 E.2231
G1 X93.442 Y88.791 E.02321
G1 X93.442 Y77.491 E.22226
G1 X80.813 Y77.491 E.24839
G1 X80.625 Y77.524 E.00376
G1 X80.463 Y77.611 E.00361
G1 X80.321 Y77.762 E.00407
G1 X80.245 Y77.925 E.00355
G1 X80.222 Y78.086 E.00319
G1 X80.222 Y95.116 E.33498
G1 X80.245 Y95.277 E.00319
G1 X80.32 Y95.437 E.00349
G1 X80.438 Y95.57 E.00349
G1 X80.594 Y95.666 E.00362
G1 X80.81 Y95.711 E.00433
G1 X93.024 Y95.711 E.24024
G1 X93.057 Y95.329 E.00753
G1 X93.102 Y95.163 E.00339
G1 X93.234 Y94.916 E.00551
G1 X93.397 Y94.742 E.00469
G1 X93.533 Y94.647 E.00327
G1 X93.748 Y94.554 E.00461
G1 X94.014 Y94.498 E.00534
G1 X99.909 Y86.078 E.20217
G1 X100.876 Y86.755 E.02321
G1 X94.98 Y95.175 E.20217
G1 X95.019 Y95.559 E.0076
G1 X94.976 Y95.794 E.0047
G1 X94.88 Y96.01 E.00465
G1 X94.7 Y96.23 E.0056
G1 X94.561 Y96.336 E.00344
G1 X94.299 Y96.461 E.00571
G1 X94.096 Y96.639 E.00532
G1 X93.906 Y96.755 E.00438
G1 X93.698 Y96.837 E.00438
G1 X93.483 Y96.881 E.00433
G1 X89.27 Y96.892 E.08286
; WIPE_START
M204 S6000
G1 X89.691 Y97.414 E-.12742
G1 X89.967 Y97.772 E-.08592
G1 X90.085 Y97.957 E-.04163
G1 X90.293 Y98.359 E-.08606
G1 X90.366 Y98.551 E-.03897
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




G1 X92.978 Y76.53
G1 Z5.96
G1 E.4 F1800
; FEATURE: Top surface
G1 F1500
M204 S2000
G1 X94.395 Y77.948 E.03943
G1 X93.658 Y77.769
G1 X94.396 Y78.506 E.02051
G1 X94.396 Y79.064
G1 X93.658 Y78.326 E.02052
G1 X93.658 Y78.884
G1 X94.397 Y79.622 E.02053
G1 X94.397 Y80.18
G1 X93.658 Y79.441 E.02055
G1 X93.658 Y79.999
G1 X94.398 Y80.738 E.02056
G1 X94.398 Y81.296
G1 X93.658 Y80.556 E.02057
G1 X93.658 Y81.114
G1 X94.399 Y81.854 E.02059
G1 X94.399 Y82.412
G1 X93.658 Y81.671 E.0206
G1 X93.658 Y82.229
G1 X94.4 Y82.97 E.02061
G1 X94.4 Y83.528
G1 X93.658 Y82.787 E.02063
G1 X93.658 Y83.344
G1 X94.401 Y84.086 E.02064
G1 X94.401 Y84.644
G1 X93.658 Y83.902 E.02065
G1 X93.658 Y84.459
G1 X94.401 Y85.202 E.02067
G1 X94.402 Y85.76
G1 X93.658 Y85.017 E.02068
G1 X93.658 Y85.574
G1 X94.402 Y86.318 E.0207
G1 X94.403 Y86.876
G1 X93.658 Y86.132 E.02071
G1 X93.658 Y86.689
G1 X94.403 Y87.434 E.02072
G1 X94.404 Y87.992
G1 X93.658 Y87.247 E.02074
G1 X93.658 Y87.804
G1 X94.404 Y88.55 E.02075
; WIPE_START
M204 S6000
G1 X93.658 Y87.804 E-.20044
G1 X93.658 Y87.247 E-.10593
G1 X93.932 Y87.521 E-.07363
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X99.765 Y86.663 Z6.36 F18000
G1 Z5.96
G1 E.4 F1800
G1 F1500
M204 S2000
G1 X100.301 Y87.198 E.01491
G1 X100.071 Y87.526
G1 X99.535 Y86.991 E.01491
G1 X99.305 Y87.318
G1 X99.841 Y87.854 E.01491
G1 X99.612 Y88.182
G1 X99.076 Y87.646 E.01491
G1 X98.846 Y87.974
G1 X99.382 Y88.51 E.01491
G1 X99.153 Y88.838
G1 X98.617 Y88.302 E.01491
G1 X98.387 Y88.63
G1 X98.923 Y89.166 E.01491
G1 X98.693 Y89.494
G1 X98.157 Y88.958 E.01491
G1 X97.928 Y89.286
G1 X98.464 Y89.822 E.01491
G1 X98.234 Y90.15
G1 X97.698 Y89.614 E.01491
G1 X97.469 Y89.942
G1 X98.004 Y90.478 E.01491
G1 X97.775 Y90.806
G1 X97.239 Y90.27 E.01491
G1 X97.009 Y90.598
G1 X97.545 Y91.134 E.01491
G1 X97.316 Y91.462
G1 X96.78 Y90.926 E.01491
G1 X96.55 Y91.254
G1 X97.086 Y91.789 E.01491
G1 X96.856 Y92.117
G1 X96.32 Y91.581 E.01491
G1 X96.091 Y91.909
G1 X96.627 Y92.445 E.01491
G1 X96.397 Y92.773
G1 X95.861 Y92.237 E.01491
G1 X95.632 Y92.565
G1 X96.168 Y93.101 E.01491
G1 X95.938 Y93.429
G1 X95.402 Y92.893 E.01491
G1 X95.172 Y93.221
G1 X95.708 Y93.757 E.01491
G1 X95.479 Y94.085
G1 X94.943 Y93.549 E.01491
G1 X94.713 Y93.877
G1 X95.249 Y94.413 E.01491
G1 X95.019 Y94.741
G1 X94.484 Y94.205 E.01491
G1 X94.254 Y94.533
G1 X94.79 Y95.069 E.01491
G1 X94.787 Y95.623
G1 X93.906 Y94.742 E.02451
G1 X93.527 Y94.921
G1 X94.607 Y96.001 E.03005
G1 X94.279 Y96.23
G1 X93.302 Y95.254 E.02717
G1 X93.239 Y95.748
G1 X93.959 Y96.468 E.02005
G1 X93.574 Y96.641
G1 X92.861 Y95.928 E.01984
G1 X92.304 Y95.928
G1 X93.041 Y96.665 E.02052
G1 X92.485 Y96.667
G1 X91.746 Y95.928 E.02056
G1 X91.189 Y95.928
G1 X91.929 Y96.668 E.0206
G1 X91.373 Y96.67
G1 X90.631 Y95.928 E.02064
G1 X90.073 Y95.928
G1 X90.817 Y96.671 E.02068
G1 X90.261 Y96.673
G1 X89.516 Y95.928 E.02072
G1 X88.958 Y95.928
G1 X89.705 Y96.674 E.02076
G1 X89.149 Y96.675
G1 X88.401 Y95.928 E.0208
G1 X87.843 Y95.928
G1 X89.712 Y97.797 E.05199
G1 X90.261 Y98.903
G1 X87.286 Y95.928 E.08276
G1 X86.728 Y95.928
G1 X90.386 Y99.585 E.10174
G1 X90.395 Y100.152
G1 X88.917 Y98.674 E.04111
G1 X89.23 Y99.544
G1 X90.323 Y100.637 E.03041
G1 X90.2 Y101.073
G1 X89.241 Y100.113 E.02669
G1 X89.158 Y100.588
G1 X90.036 Y101.466 E.02443
G1 X89.839 Y101.827
G1 X88.997 Y100.984 E.02344
G1 X88.787 Y101.331
G1 X89.603 Y102.148 E.02271
G1 X89.338 Y102.441
G1 X88.53 Y101.632 E.02249
G1 X88.228 Y101.888
G1 X89.043 Y102.703 E.02268
G1 X88.716 Y102.934
G1 X87.874 Y102.092 E.02342
G1 X87.465 Y102.24
G1 X88.356 Y103.131 E.02478
G1 X87.958 Y103.29
G1 X86.985 Y102.317 E.02707
G1 X86.397 Y102.287
G1 X87.516 Y103.406 E.03113
G1 X87.017 Y103.465
G1 X85.427 Y101.874 E.04423
; WIPE_START
M204 S6000
G1 X86.841 Y103.289 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X88.048 Y97.805 Z6.36 F18000
G1 Z5.96
G1 E.4 F1800
G1 F1500
M204 S2000
G1 X86.171 Y95.928 E.05222
G1 X85.613 Y95.928
G1 X87.189 Y97.504 E.04385
G1 X86.617 Y97.489
G1 X85.056 Y95.928 E.04344
G1 X84.498 Y95.928
G1 X86.15 Y97.579 E.04594
G1 X85.749 Y97.737
G1 X84.807 Y96.794 E.02621
G1 X84.548 Y97.093
G1 X85.4 Y97.945 E.02371
G1 X85.101 Y98.203
G1 X84.289 Y97.391 E.02259
G1 X84.029 Y97.689
G1 X84.85 Y98.51 E.02283
G1 X84.645 Y98.863
G1 X83.802 Y98.019 E.02347
G1 X83.605 Y98.38
G1 X84.495 Y99.27 E.02475
G1 X84.412 Y99.744
G1 X83.446 Y98.778 E.02687
G1 X83.331 Y99.221
G1 X84.448 Y100.338 E.03108
G1 X84.846 Y101.294
G1 X83.27 Y99.718 E.04384
G1 X83.282 Y100.287
G1 X86.444 Y103.449 E.08796
G1 X85.73 Y103.293
G1 X83.436 Y100.998 E.06383
; WIPE_START
M204 S6000
G1 X84.85 Y102.413 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X84.687 Y96.674 Z6.36 F18000
G1 Z5.96
G1 E.4 F1800
G1 F1500
M204 S2000
G1 X83.941 Y95.928 E.02076
G1 X83.383 Y95.928
G1 X84.129 Y96.674 E.02076
G1 X83.572 Y96.674
G1 X82.825 Y95.928 E.02076
G1 X82.268 Y95.928
G1 X83.014 Y96.674 E.02076
G1 X82.457 Y96.674
G1 X81.71 Y95.928 E.02076
G1 X81.153 Y95.928
G1 X81.899 Y96.674 E.02076
G1 X81.342 Y96.674
G1 X80.545 Y95.878 E.02216
; WIPE_START
M204 S6000
G1 X81.342 Y96.674 E-.21402
G1 X81.899 Y96.674 E-.10593
G1 X81.676 Y96.451 E-.06005
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X85.598 Y89.903 Z6.36 F18000
G1 X93.164 Y77.274 Z6.36
G1 Z5.96
G1 E.4 F1800
G1 F1500
M204 S2000
G1 X92.42 Y76.53 E.02069
G1 X91.862 Y76.53
G1 X92.606 Y77.274 E.02069
G1 X92.049 Y77.274
G1 X91.305 Y76.53 E.02069
G1 X90.747 Y76.53
G1 X91.491 Y77.274 E.02069
G1 X90.934 Y77.274
G1 X90.19 Y76.53 E.02069
G1 X89.632 Y76.53
M73 P98 R0
G1 X90.376 Y77.274 E.02069
G1 X89.819 Y77.274
G1 X89.075 Y76.53 E.02069
G1 X88.517 Y76.53
G1 X89.261 Y77.274 E.02069
G1 X88.704 Y77.274
G1 X87.96 Y76.53 E.02069
G1 X87.402 Y76.53
G1 X88.146 Y77.274 E.02069
G1 X87.588 Y77.274
G1 X86.845 Y76.53 E.02069
G1 X86.287 Y76.53
G1 X87.031 Y77.274 E.02069
G1 X86.473 Y77.274
G1 X85.73 Y76.53 E.02069
G1 X85.172 Y76.53
G1 X85.916 Y77.274 E.02069
G1 X85.358 Y77.274
G1 X84.614 Y76.53 E.02069
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
G1 X81.269 Y76.53 E.02069
G1 X80.712 Y76.53
G1 X81.456 Y77.274 E.02069
G1 X80.898 Y77.274
G1 X80.17 Y76.546 E.02026
G1 X79.763 Y76.696
G1 X80.443 Y77.376 E.01891
G1 X80.143 Y77.634
G1 X79.472 Y76.963 E.01868
G1 X79.293 Y77.342
G1 X80.007 Y78.056 E.01986
G1 X80.005 Y78.611
G1 X79.258 Y77.865 E.02076
G1 X79.258 Y78.422
G1 X80.005 Y79.169 E.02076
G1 X80.005 Y79.726
G1 X79.258 Y78.98 E.02076
G1 X79.258 Y79.537
G1 X80.005 Y80.284 E.02076
G1 X80.005 Y80.841
G1 X79.258 Y80.095 E.02076
G1 X79.258 Y80.652
G1 X80.005 Y81.399 E.02076
G1 X80.005 Y81.956
G1 X79.258 Y81.21 E.02076
G1 X79.258 Y81.767
G1 X80.005 Y82.514 E.02076
G1 X80.005 Y83.071
G1 X79.258 Y82.325 E.02076
G1 X79.258 Y82.883
G1 X80.005 Y83.629 E.02076
G1 X80.005 Y84.186
G1 X79.258 Y83.44 E.02076
G1 X79.258 Y83.998
G1 X80.005 Y84.744 E.02076
G1 X80.005 Y85.302
G1 X79.258 Y84.555 E.02076
G1 X79.258 Y85.113
G1 X80.005 Y85.859 E.02076
G1 X80.005 Y86.417
G1 X79.258 Y85.67 E.02076
G1 X79.258 Y86.228
G1 X80.005 Y86.974 E.02076
G1 X80.005 Y87.532
G1 X79.258 Y86.785 E.02076
G1 X79.258 Y87.343
G1 X80.005 Y88.089 E.02076
G1 X80.005 Y88.647
G1 X79.258 Y87.9 E.02076
G1 X79.258 Y88.458
G1 X80.005 Y89.204 E.02076
G1 X80.005 Y89.762
G1 X79.258 Y89.015 E.02076
G1 X79.258 Y89.573
G1 X80.005 Y90.319 E.02076
G1 X80.005 Y90.877
G1 X79.258 Y90.131 E.02076
G1 X79.258 Y90.688
G1 X80.005 Y91.434 E.02076
G1 X80.005 Y91.992
G1 X79.258 Y91.246 E.02076
G1 X79.258 Y91.803
G1 X80.005 Y92.55 E.02076
G1 X80.005 Y93.107
G1 X79.258 Y92.361 E.02076
G1 X79.258 Y92.918
G1 X80.005 Y93.665 E.02076
G1 X80.005 Y94.222
G1 X79.258 Y93.476 E.02076
G1 X79.258 Y94.033
G1 X80.005 Y94.78 E.02076
G1 X80.06 Y95.392
G1 X79.258 Y94.591 E.02229
G1 X79.258 Y95.148
G1 X80.784 Y96.674 E.04244
G1 X80.209 Y96.657
G1 X79.276 Y95.723 E.02597
; WIPE_START
M204 S6000
G1 X80.209 Y96.657 E-.25086
G1 X80.784 Y96.674 E-.10925
G1 X80.71 Y96.6 E-.01989
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X86.038 Y102.065 Z6.36 F18000
G1 X86.325 Y102.36 Z6.36
G1 Z5.96
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.110952
G1 F1500
M204 S6000
G1 X86.05 Y102.197 E.00136
; WIPE_START
G1 X86.325 Y102.36 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X85.209 Y103.078 Z6.36 F18000
G1 Z5.96
G1 E.4 F1800
; LINE_WIDTH: 0.0893342
G1 F1500
M204 S6000
G1 X85.111 Y103.009 E.00038
; LINE_WIDTH: 0.118302
G1 X85.031 Y102.947 E.00047
; LINE_WIDTH: 0.143672
G1 X84.951 Y102.885 E.00059
; LINE_WIDTH: 0.173504
G1 X84.789 Y102.747 E.00157
; LINE_WIDTH: 0.20782
G1 X84.627 Y102.61 E.00193
; LINE_WIDTH: 0.230463
G1 X84.328 Y102.323 E.00423
G1 X84.046 Y102.019 E.00423
; LINE_WIDTH: 0.19093
G1 X83.913 Y101.857 E.00173
; LINE_WIDTH: 0.150116
G1 X83.78 Y101.695 E.0013
; LINE_WIDTH: 0.115566
G1 X83.719 Y101.612 E.00046
; LINE_WIDTH: 0.0872363
G1 X83.659 Y101.529 E.00031
; WIPE_START
G1 X83.719 Y101.612 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X85.364 Y101.937 Z6.36 F18000
G1 Z5.96
G1 E.4 F1800
; LINE_WIDTH: 0.216181
G1 F1500
M204 S6000
G1 X85.1 Y101.7 E.00337
G1 X84.781 Y101.359 E.00444
; WIPE_START
G1 X85.1 Y101.7 E-.2161
G1 X85.364 Y101.937 E-.1639
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X86.389 Y97.54 Z6.36 F18000
G1 Z5.96
G1 E.4 F1800
; LINE_WIDTH: 0.118078
G1 F1500
M204 S6000
G1 X86.289 Y97.506 E.00049
G1 X86.183 Y97.565 E.00056
; WIPE_START
G1 X86.289 Y97.506 E-.20351
G1 X86.389 Y97.54 E-.17649
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X88.981 Y98.61 Z6.36 F18000
G1 Z5.96
G1 E.4 F1800
; LINE_WIDTH: 0.206431
G1 F1500
M204 S6000
G1 X88.888 Y98.489 E.00137
; LINE_WIDTH: 0.172234
G1 X88.601 Y98.172 E.00313
G1 X88.375 Y97.958 E.00227
; LINE_WIDTH: 0.194337
G1 X88.115 Y97.739 E.00287
; WIPE_START
G1 X88.375 Y97.958 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X89.107 Y100.816 Z6.36 F18000
G1 Z5.96
G1 E.4 F1800
; LINE_WIDTH: 0.0743459
G1 F1500
M204 S6000
G1 X89.035 Y100.917 E.0003
M204 S10000
G1 X89.322 Y100.033 F18000
; LINE_WIDTH: 0.0874526
G1 F1500
M204 S6000
G1 X89.241 Y99.834 E.00066
; WIPE_START
G1 X89.322 Y100.033 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X82.393 Y96.831 Z6.36 F18000
G1 X80.478 Y95.945 Z6.36
G1 Z5.96
G1 E.4 F1800
; LINE_WIDTH: 0.183572
G1 F1500
M204 S6000
G1 X80.257 Y95.769 E.00222
G1 X80.096 Y95.598 E.00185
G1 X79.995 Y95.457 E.00137
; WIPE_START
G1 X80.096 Y95.598 E-.09542
G1 X80.257 Y95.769 E-.12949
G1 X80.478 Y95.945 E-.15509
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X79.683 Y96.441 Z6.36 F18000
G1 Z5.96
G1 E.4 F1800
; LINE_WIDTH: 0.079417
G1 F1500
M204 S6000
G1 X79.451 Y96.207 E.00088
; WIPE_START
G1 X79.683 Y96.441 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X84.372 Y90.418 Z6.36 F18000
G1 X94.414 Y77.517 Z6.36
G1 Z5.96
G1 E.4 F1800
; LINE_WIDTH: 0.391656
G1 F1500
M204 S6000
G1 X94.055 Y77.062 E.01057
G1 X93.83 Y76.843 E.00574
; LINE_WIDTH: 0.370256
G1 X93.383 Y76.51 E.00958
; WIPE_START
G1 X93.83 Y76.843 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X93.679 Y77.511 Z6.36 F18000
G1 Z5.96
G1 E.4 F1800
; LINE_WIDTH: 0.0846696
G1 F1500
M204 S6000
G1 X93.66 Y77.676 E.00049
M204 S10000
G1 X94.374 Y78.206 F18000
; LINE_WIDTH: 0.0847599
G1 F1500
M204 S6000
G1 X94.394 Y78.04 E.00049
; WIPE_START
G1 X94.374 Y78.206 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X98.77 Y84.445 Z6.36 F18000
G1 X100.516 Y86.925 Z6.36
G1 Z5.96
G1 E.4 F1800
; LINE_WIDTH: 0.274428
G1 F1500
M204 S6000
G1 X100.248 Y86.7 E.00435
; LINE_WIDTH: 0.225292
G1 X99.979 Y86.474 E.00349
; LINE_WIDTH: 0.178519
G1 X99.95 Y86.477 E.00022
; LINE_WIDTH: 0.137263
G1 X99.918 Y86.49 E.0002
; LINE_WIDTH: 0.0846091
G1 X99.844 Y86.553 E.00028
; close powerlost recovery
M1003 S0
; WIPE_START
G1 F1500
G1 X99.918 Y86.49 E-.38
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

