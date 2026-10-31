; HEADER_BLOCK_START
; BambuStudio 02.07.01.62
; model printing time: 27m 0s; total estimated time: 35m 4s
; total layer number: 51
; total filament length [mm] : 697.38
; total filament volume [cm^3] : 1677.39
; total filament weight [g] : 2.08
; model label id: 8,12
; object max height: 4.40,5.24
; filament_density: 1.24
; filament_diameter: 1.75
; max_z_height: 5.24
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
M73 P0 R35
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
M73 P1 R34
    G1 E50 F200
    M400
    M1002 set_filament_type:TPU

    M104 S250

    G92 E0
    G1 E50 F49.8898
    M400
    M106 P1 S178
    G92 E0
M73 P2 R34
    G1 E5 F49.8898
    M109 S210 ; drop nozzle temp, make filament shink a bit
    M104 S190
    G92 E0
M73 P4 R33
    G1 E-0.5 F300

M73 P5 R33
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
M73 P17 R28
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
M73 P18 R28
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
    G29 A1 X53.2 Y64.0008 I74.02 J42.6984
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
    
    G1 X-13.5 F3000
    M400
    M984 A0.1 E1 S1 F0.49281 H0.4
    M106 P1 S178
    M400 S7
    G1 X0 F18000
M73 P19 R28
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
; layer num/total_layer_count: 1/51
; update layer progress
M73 L1
M991 S0 P0 ;notify layer change
M106 S0
; OBJECT_ID: 12
; start printing object, unique label id: 12
M624 AgAAAAAAAAA=
G1 X89.327 Y105.346 F18000
M204 S6000
G1 Z.4
M73 P20 R27
G1 Z.2
M73 P21 R27
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.5
G1 F900
M204 S500
G1 X89.119 Y105.272 E.00836
G1 X88.76 Y105.08 E.01548
G1 X88.444 Y104.828 E.01535
G1 X88.179 Y104.524 E.01533
G1 X87.972 Y104.177 E.01534
G1 X87.831 Y103.803 E.01519
G1 X87.775 Y103.536 E.01038
G1 X87.75 Y103.264 E.01037
G1 X87.774 Y102.869 E.01506
G1 X87.831 Y102.602 E.01037
G1 X87.916 Y102.351 E.01007
G1 X88.103 Y101.989 E.01548
G1 X88.348 Y101.673 E.01521
G1 X88.545 Y101.484 E.01036
G1 X88.757 Y101.325 E.01008
G1 X89.115 Y101.131 E.01548
G1 X89.499 Y101.006 E.01535
G1 X89.899 Y100.952 E.01534
M73 P22 R27
G1 X90.298 Y100.97 E.01519
G1 X90.566 Y101.023 E.01036
G1 X90.826 Y101.107 E.01037
G1 X91.18 Y101.284 E.01506
G1 X91.403 Y101.441 E.01037
G1 X91.606 Y101.624 E.01037
G1 X91.857 Y101.93 E.01506
G1 X91.997 Y102.164 E.01037
G1 X92.108 Y102.413 E.01037
M73 P23 R27
G1 X92.215 Y102.799 E.0152
G1 X92.251 Y103.201 E.01533
G1 X92.215 Y103.599 E.0152
G1 X92.151 Y103.864 E.01036
G1 X92.058 Y104.112 E.01008
G1 X91.86 Y104.469 E.01549
G1 X91.603 Y104.781 E.01535
G1 X91.298 Y105.039 E.01519
G1 X91.067 Y105.182 E.01036
G1 X90.826 Y105.294 E.01008
G1 X90.435 Y105.409 E.01548
G1 X90.034 Y105.452 E.01535
G1 X89.635 Y105.422 E.01519
G1 X89.384 Y105.364 E.0098
; WIPE_START
G1 X89.119 Y105.272 E-.0532
G1 X88.76 Y105.08 E-.0774
G1 X88.444 Y104.828 E-.07674
G1 X88.179 Y104.524 E-.07664
G1 X87.972 Y104.177 E-.07671
G1 X87.936 Y104.082 E-.01932
; WIPE_END
G1 E-.02 F1800
M204 S6000
G1 X89.222 Y99.537 Z.6 F18000
G1 Z.2
G1 E.4 F1800
; FEATURE: Inner wall
G1 F900
M204 S500
G1 X54.364 Y99.537 E1.32484
G1 X54.364 Y95.865 E.13955
G1 X121.964 Y95.865 E2.56923
G1 X121.964 Y94.465 E.05321
G1 X125.636 Y94.465 E.13955
G1 X125.636 Y100.937 E.24597
G1 X121.964 Y100.937 E.13955
G1 X121.964 Y99.537 E.05321
G1 X89.282 Y99.537 E1.24211
; WIPE_START
G1 X87.282 Y99.537 E-.38
; WIPE_END
M73 P23 R26
G1 E-.02 F1800
M204 S6000
G1 X90.856 Y99.994 Z.6 F18000
G1 Z.2
G1 E.4 F1800
G1 F900
M204 S500
G1 X91.463 Y100.665 E.03441
G1 X91.326 Y100.846 E.00865
G1 X90.999 Y100.683 E.01387
G1 X90.681 Y100.58 E.01271
G1 X90.353 Y100.515 E.01271
G1 X89.878 Y100.494 E.01806
G1 X89.397 Y100.559 E.01847
G1 X88.934 Y100.709 E.0185
G1 X88.679 Y100.847 E.01102
G1 X88.536 Y100.665 E.00879
G1 X89.144 Y99.994 E.03443
G1 X53.907 Y99.994 E1.33924
G1 X53.907 Y95.408 E.17429
G1 X121.507 Y95.408 E2.56923
G1 X121.507 Y94.008 E.05321
G1 X126.093 Y94.008 E.17429
G1 X126.093 Y101.394 E.28071
G1 X121.507 Y101.394 E.17429
G1 X121.507 Y99.994 E.05321
G1 X90.916 Y99.994 E1.16266
; WIPE_START
G1 X91.463 Y100.665 E-.16457
G1 X91.326 Y100.846 E-.04323
G1 X90.999 Y100.683 E-.06933
G1 X90.681 Y100.58 E-.06356
G1 X90.478 Y100.54 E-.03931
; WIPE_END
G1 E-.02 F1800
M204 S6000
G1 X91.886 Y100.451 Z.6 F18000
G1 Z.2
G1 E.4 F1800
; FEATURE: Outer wall
G1 F900
M204 S500
G1 X92.535 Y101.168 E.03678
G1 X92.755 Y101.478 E.01445
G1 X92.856 Y101.651 E.0076
G1 X93.087 Y102.186 E.02216
G1 X93.188 Y102.569 E.01505
G1 X93.249 Y103.146 E.02204
G1 X93.207 Y103.724 E.02204
G1 X93.062 Y104.289 E.02216
G1 X92.913 Y104.639 E.01446
G1 X92.712 Y104.991 E.01543
G1 X92.348 Y105.447 E.02215
G1 X91.922 Y105.821 E.02154
G1 X91.581 Y106.04 E.01542
G1 X91.063 Y106.271 E.02154
G1 X90.676 Y106.379 E.01529
G1 X90.101 Y106.449 E.02202
G1 X89.708 Y106.437 E.01492
G1 X89.138 Y106.334 E.02204
G1 X88.763 Y106.206 E.01506
M73 P24 R26
G1 X88.26 Y105.945 E.02155
G1 X87.931 Y105.707 E.01543
G1 X87.528 Y105.309 E.02153
G1 X87.286 Y104.988 E.01528
G1 X87.092 Y104.651 E.01477
G1 X86.88 Y104.111 E.02203
G1 X86.796 Y103.74 E.01444
G1 X86.753 Y103.341 E.01528
G1 X86.76 Y102.952 E.01478
G1 X86.813 Y102.566 E.01479
G1 X86.913 Y102.186 E.01493
G1 X87.144 Y101.651 E.02215
G1 X87.245 Y101.478 E.0076
G1 X87.465 Y101.168 E.01445
G1 X88.114 Y100.451 E.03678
G1 X53.45 Y100.451 E1.31745
G1 X53.45 Y94.951 E.20904
G1 X121.05 Y94.951 E2.56923
G1 X121.05 Y93.551 E.05321
G1 X126.55 Y93.551 E.20904
G1 X126.55 Y101.851 E.31545
G1 X121.05 Y101.851 E.20904
G1 X121.05 Y100.451 E.05321
G1 X91.946 Y100.451 E1.10614
; WIPE_START
G1 X92.535 Y101.168 E-.17643
G1 X92.755 Y101.478 E-.07226
G1 X92.856 Y101.651 E-.038
G1 X93.051 Y102.102 E-.09332
; WIPE_END
G1 E-.02 F1800
M204 S6000
G17
G3 Z.6 I1.217 J0 P1  F18000
; stop printing object, unique label id: 12
M625
; object ids of layer 1 start: 8,12
M624 AwAAAAAAAAA=
;===================== date: 20250206 =====================

; don't support timelapse gcode in spiral_mode and by object sequence for I3 structure printer
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
G92 E0
G1 Z0.6
G1 X0 Y85.35 ; move to safe pos
G1 X-13.0 F3000 ; move to safe pos
M400
M1004 S5 P1  ; external shutter
M400 P300
M971 S11 C11 O0
G92 E0
G1 X0 F18000
M623

; SKIPTYPE: head_wrap_detect
M622.1 S1
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




; object ids of this layer1 end: 8,12
M625
; start printing object, unique label id: 12
M624 AgAAAAAAAAA=
G1 X91.578 Y100.892
G1 Z.2
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.583496
G1 F900
M204 S500
G1 X91.979 Y101.295 E.02555
G1 X92.25 Y101.629 E.01935
G1 X92.432 Y101.921 E.01543
G1 X92.609 Y102.34 E.02046
G1 X92.706 Y102.734 E.01825
G1 X92.749 Y103.177 E.01998
G1 X92.731 Y103.486 E.01392
G1 X92.638 Y103.974 E.02235
G1 X92.463 Y104.416 E.02134
G1 X92.256 Y104.767 E.01834
G1 X91.94 Y105.145 E.02216
G1 X91.627 Y105.416 E.01861
G1 X91.337 Y105.603 E.0155
G1 X90.983 Y105.765 E.0175
G1 X90.571 Y105.89 E.01934
G1 X90.255 Y105.934 E.01434
G1 X89.753 Y105.935 E.02256
G1 X89.274 Y105.852 E.02188
G1 X88.9 Y105.717 E.01783
G1 X88.507 Y105.509 E.02001
G1 X88.12 Y105.201 E.02221
G1 X87.792 Y104.835 E.02211
G1 X87.54 Y104.427 E.02154
G1 X87.413 Y104.12 E.01493
G1 X87.289 Y103.654 E.02168
G1 X87.253 Y103.252 E.01817
G1 X87.263 Y102.99 E.01176
G1 X87.305 Y102.664 E.01479
G1 X87.389 Y102.343 E.01491
G1 X87.454 Y102.176 E.00806
G1 X87.588 Y101.889 E.01424
G1 X87.7 Y101.704 E.00971
G1 X87.965 Y101.355 E.0197
G1 X88.222 Y101.09 E.01661
G1 X88.617 Y101.139 E.0179
; WIPE_START
G1 X88.222 Y101.09 E-.07566
G1 X87.965 Y101.355 E-.07021
G1 X87.7 Y101.704 E-.08327
G1 X87.588 Y101.889 E-.04103
G1 X87.454 Y102.176 E-.0602
G1 X87.389 Y102.343 E-.03408
G1 X87.369 Y102.422 E-.01555
; WIPE_END
G1 E-.02 F1800
M204 S6000
G1 X89.406 Y100.045 Z.6 F18000
G1 Z.2
G1 E.4 F1800
; LINE_WIDTH: 0.549213
G1 F900
M204 S500
G1 X89.879 Y100.015 E.01996
G1 X90.581 Y100.031 E.02954
M204 S6000
G1 X90.873 Y100.354 F18000
; LINE_WIDTH: 0.407711
G1 F900
M204 S500
G1 X89.753 Y99.765 E.03838
; WIPE_START
G1 X90.873 Y100.354 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S6000
G1 X98.434 Y99.308 Z.6 F18000
G1 X125.453 Y95.573 Z.6
G1 Z.2
G1 E.4 F1800
; FEATURE: Bottom surface
; LINE_WIDTH: 0.50044
G1 F900
M204 S500
G1 X124.734 Y94.853 E.0387
G1 X124.087 Y94.853 E.02461
G1 X125.247 Y96.014 E.06244
G1 X125.247 Y96.661 E.02461
G1 X123.44 Y94.853 E.09725
G1 X122.793 Y94.853 E.02461
G1 X125.247 Y97.308 E.13206
G1 X125.247 Y97.955 E.02461
G1 X122.353 Y95.06 E.15574
G1 X122.353 Y95.707 E.02461
G1 X125.247 Y98.602 E.15574
G1 X125.247 Y99.249 E.02461
G1 X122.252 Y96.253 E.16117
G1 X121.605 Y96.253 E.02461
G1 X125.247 Y99.896 E.19598
G1 X125.247 Y100.543 E.02461
G1 X120.958 Y96.253 E.2308
G1 X120.311 Y96.253 E.02461
G1 X124.605 Y100.548 E.23106
G1 X123.958 Y100.548 E.02461
G1 X119.663 Y96.253 E.23106
G1 X119.016 Y96.253 E.02461
G1 X121.911 Y99.148 E.15574
G1 X122.353 Y99.148 E.01679
G1 X122.353 Y99.59 E.01679
G1 X123.311 Y100.548 E.05157
G1 X122.664 Y100.548 E.02462
G1 X122.147 Y100.031 E.02782
M204 S6000
G1 X121.47 Y99.354 F18000
G1 F900
M204 S500
G1 X118.369 Y96.253 E.1668
G1 X117.722 Y96.253 E.02461
G1 X120.617 Y99.148 E.15574
G1 X119.97 Y99.148 E.02461
G1 X117.075 Y96.253 E.15574
G1 X116.428 Y96.253 E.02461
G1 X119.323 Y99.148 E.15574
G1 X118.676 Y99.148 E.02461
G1 X115.781 Y96.253 E.15574
G1 X115.134 Y96.253 E.02461
G1 X118.029 Y99.148 E.15574
G1 X117.382 Y99.148 E.02462
G1 X114.487 Y96.253 E.15574
G1 X113.84 Y96.253 E.02461
G1 X116.735 Y99.148 E.15574
G1 X116.088 Y99.148 E.02461
G1 X113.193 Y96.253 E.15574
G1 X112.546 Y96.253 E.02461
G1 X115.441 Y99.148 E.15574
G1 X114.794 Y99.148 E.02461
G1 X111.899 Y96.253 E.15574
G1 X111.252 Y96.253 E.02461
G1 X114.147 Y99.148 E.15574
G1 X113.5 Y99.148 E.02461
G1 X110.605 Y96.253 E.15574
G1 X109.958 Y96.253 E.02461
M73 P25 R26
G1 X112.853 Y99.148 E.15574
G1 X112.206 Y99.148 E.02461
G1 X109.311 Y96.253 E.15574
G1 X108.664 Y96.253 E.02461
G1 X111.559 Y99.148 E.15574
G1 X110.912 Y99.148 E.02462
G1 X108.017 Y96.253 E.15574
G1 X107.37 Y96.253 E.02461
G1 X110.265 Y99.148 E.15574
G1 X109.618 Y99.148 E.02461
G1 X106.723 Y96.253 E.15574
G1 X106.076 Y96.253 E.02461
G1 X108.971 Y99.148 E.15574
G1 X108.324 Y99.148 E.02461
G1 X105.429 Y96.253 E.15574
G1 X104.782 Y96.253 E.02462
G1 X107.677 Y99.148 E.15574
G1 X107.029 Y99.148 E.02461
G1 X104.135 Y96.253 E.15574
G1 X103.488 Y96.253 E.02461
G1 X106.382 Y99.148 E.15574
G1 X105.735 Y99.148 E.02461
G1 X102.841 Y96.253 E.15574
G1 X102.194 Y96.253 E.02461
G1 X105.088 Y99.148 E.15574
G1 X104.441 Y99.148 E.02461
G1 X101.547 Y96.253 E.15574
G1 X100.9 Y96.253 E.02461
G1 X103.794 Y99.148 E.15574
G1 X103.147 Y99.148 E.02461
G1 X100.253 Y96.253 E.15574
G1 X99.606 Y96.253 E.02461
G1 X102.5 Y99.148 E.15574
G1 X101.853 Y99.148 E.02461
G1 X98.959 Y96.253 E.15574
G1 X98.311 Y96.253 E.02462
G1 X101.206 Y99.148 E.15574
G1 X100.559 Y99.148 E.02461
G1 X97.664 Y96.253 E.15574
G1 X97.017 Y96.253 E.02461
G1 X99.912 Y99.148 E.15574
G1 X99.265 Y99.148 E.02461
G1 X96.37 Y96.253 E.15574
G1 X95.723 Y96.253 E.02461
G1 X98.618 Y99.148 E.15574
G1 X97.971 Y99.148 E.02461
G1 X95.076 Y96.253 E.15574
G1 X94.429 Y96.253 E.02461
G1 X97.324 Y99.148 E.15574
G1 X96.677 Y99.148 E.02461
G1 X93.782 Y96.253 E.15574
G1 X93.135 Y96.253 E.02461
G1 X96.03 Y99.148 E.15574
G1 X95.383 Y99.148 E.02462
G1 X92.488 Y96.253 E.15574
G1 X91.841 Y96.253 E.02462
G1 X94.736 Y99.148 E.15574
G1 X94.089 Y99.148 E.02461
G1 X91.194 Y96.253 E.15574
G1 X90.547 Y96.253 E.02461
G1 X93.442 Y99.148 E.15574
G1 X92.795 Y99.148 E.02461
G1 X89.9 Y96.253 E.15574
G1 X89.253 Y96.253 E.02461
G1 X92.148 Y99.148 E.15574
G1 X91.501 Y99.148 E.02461
G1 X88.606 Y96.253 E.15574
G1 X87.959 Y96.253 E.02461
G1 X90.854 Y99.148 E.15574
G1 X90.207 Y99.148 E.02461
G1 X87.312 Y96.253 E.15574
G1 X86.665 Y96.253 E.02461
G1 X89.56 Y99.148 E.15574
G1 X88.913 Y99.148 E.02462
G1 X86.018 Y96.253 E.15574
G1 X85.371 Y96.253 E.02462
G1 X88.266 Y99.148 E.15574
G1 X87.619 Y99.148 E.02461
G1 X84.724 Y96.253 E.15574
G1 X84.077 Y96.253 E.02461
G1 X86.972 Y99.148 E.15574
G1 X86.324 Y99.148 E.02461
G1 X83.43 Y96.253 E.15574
G1 X82.783 Y96.253 E.02461
G1 X85.677 Y99.148 E.15574
G1 X85.03 Y99.148 E.02461
G1 X82.136 Y96.253 E.15574
G1 X81.489 Y96.253 E.02461
G1 X84.383 Y99.148 E.15574
G1 X83.736 Y99.148 E.02461
G1 X80.842 Y96.253 E.15574
G1 X80.195 Y96.253 E.02461
G1 X83.089 Y99.148 E.15574
G1 X82.442 Y99.148 E.02462
G1 X79.548 Y96.253 E.15574
G1 X78.901 Y96.253 E.02462
G1 X81.795 Y99.148 E.15574
G1 X81.148 Y99.148 E.02461
G1 X78.254 Y96.253 E.15574
G1 X77.606 Y96.253 E.02461
G1 X80.501 Y99.148 E.15574
G1 X79.854 Y99.148 E.02461
G1 X76.959 Y96.253 E.15574
G1 X76.312 Y96.253 E.02461
G1 X79.207 Y99.148 E.15574
G1 X78.56 Y99.148 E.02461
G1 X75.665 Y96.253 E.15574
G1 X75.018 Y96.253 E.02461
G1 X77.913 Y99.148 E.15574
G1 X77.266 Y99.148 E.02461
G1 X74.371 Y96.253 E.15574
G1 X73.724 Y96.253 E.02461
G1 X76.619 Y99.148 E.15574
G1 X75.972 Y99.148 E.02462
G1 X73.077 Y96.253 E.15574
G1 X72.43 Y96.253 E.02462
G1 X75.325 Y99.148 E.15574
G1 X74.678 Y99.148 E.02461
G1 X71.783 Y96.253 E.15574
G1 X71.136 Y96.253 E.02461
G1 X74.031 Y99.148 E.15574
G1 X73.384 Y99.148 E.02461
G1 X70.489 Y96.253 E.15574
M73 P25 R25
G1 X69.842 Y96.253 E.02461
G1 X72.737 Y99.148 E.15574
G1 X72.09 Y99.148 E.02461
G1 X69.195 Y96.253 E.15574
G1 X68.548 Y96.253 E.02461
G1 X71.443 Y99.148 E.15574
G1 X70.796 Y99.148 E.02461
G1 X67.901 Y96.253 E.15574
G1 X67.254 Y96.253 E.02462
G1 X70.149 Y99.148 E.15574
G1 X69.502 Y99.148 E.02461
M73 P26 R25
G1 X66.607 Y96.253 E.15574
G1 X65.96 Y96.253 E.02461
G1 X68.855 Y99.148 E.15574
G1 X68.208 Y99.148 E.02461
G1 X65.313 Y96.253 E.15574
G1 X64.666 Y96.253 E.02461
G1 X67.561 Y99.148 E.15574
G1 X66.914 Y99.148 E.02461
G1 X64.019 Y96.253 E.15574
G1 X63.372 Y96.253 E.02461
G1 X66.267 Y99.148 E.15574
G1 X65.619 Y99.148 E.02461
G1 X62.725 Y96.253 E.15574
G1 X62.078 Y96.253 E.02461
G1 X64.972 Y99.148 E.15574
G1 X64.325 Y99.148 E.02461
G1 X61.431 Y96.253 E.15574
G1 X60.784 Y96.253 E.02462
G1 X63.678 Y99.148 E.15574
G1 X63.031 Y99.148 E.02461
G1 X60.137 Y96.253 E.15574
G1 X59.49 Y96.253 E.02461
G1 X62.384 Y99.148 E.15574
G1 X61.737 Y99.148 E.02461
G1 X58.843 Y96.253 E.15574
G1 X58.196 Y96.253 E.02461
G1 X61.09 Y99.148 E.15574
G1 X60.443 Y99.148 E.02461
G1 X57.549 Y96.253 E.15574
G1 X56.902 Y96.253 E.02461
G1 X59.796 Y99.148 E.15574
G1 X59.149 Y99.148 E.02461
G1 X56.254 Y96.253 E.15574
G1 X55.607 Y96.253 E.02461
G1 X58.502 Y99.148 E.15574
G1 X57.855 Y99.148 E.02461
G1 X54.96 Y96.253 E.15574
G1 X54.753 Y96.253 E.0079
G1 X54.753 Y96.693 E.01671
G1 X57.208 Y99.148 E.1321
G1 X56.561 Y99.148 E.02461
G1 X54.753 Y97.34 E.09729
G1 X54.753 Y97.987 E.02462
G1 X55.914 Y99.148 E.06248
G1 X55.267 Y99.148 E.02461
G1 X54.547 Y98.428 E.03874
; OBJECT_ID: 8
; WIPE_START
G1 X55.267 Y99.148 E-.19347
G1 X55.914 Y99.148 E-.12294
G1 X55.677 Y98.911 E-.0636
; WIPE_END
G1 E-.02 F1800
; stop printing object, unique label id: 12
M625
; start printing object, unique label id: 8
M624 AQAAAAAAAAA=
M204 S6000
G1 X61.78 Y94.327 Z.6 F18000
G1 X92.052 Y71.586 Z.6
G1 Z.2
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.5
G1 F900
M204 S500
G1 X92.108 Y71.713 E.00531
G1 X92.215 Y72.099 E.0152
G1 X92.251 Y72.501 E.01533
G1 X92.215 Y72.899 E.0152
G1 X92.151 Y73.164 E.01036
G1 X92.058 Y73.412 E.01008
G1 X91.86 Y73.769 E.01549
G1 X91.603 Y74.081 E.01535
G1 X91.298 Y74.339 E.01519
G1 X91.067 Y74.482 E.01036
G1 X90.826 Y74.594 E.01008
G1 X90.435 Y74.709 E.01548
G1 X90.034 Y74.752 E.01535
G1 X89.635 Y74.722 E.01519
G1 X89.369 Y74.661 E.01037
G1 X89.119 Y74.572 E.01008
G1 X88.76 Y74.38 E.01548
G1 X88.444 Y74.128 E.01535
G1 X88.179 Y73.824 E.01533
G1 X87.972 Y73.477 E.01534
G1 X87.831 Y73.103 E.01519
G1 X87.775 Y72.836 E.01038
G1 X87.75 Y72.564 E.01037
G1 X87.774 Y72.169 E.01506
G1 X87.831 Y71.902 E.01037
G1 X87.916 Y71.651 E.01007
G1 X88.103 Y71.289 E.01548
G1 X88.348 Y70.973 E.01521
G1 X88.545 Y70.784 E.01036
G1 X88.757 Y70.625 E.01008
G1 X89.115 Y70.431 E.01548
G1 X89.499 Y70.306 E.01535
G1 X89.899 Y70.252 E.01534
G1 X90.298 Y70.27 E.01519
G1 X90.566 Y70.323 E.01036
G1 X90.826 Y70.407 E.01037
G1 X91.18 Y70.584 E.01506
G1 X91.403 Y70.741 E.01037
G1 X91.606 Y70.924 E.01037
G1 X91.857 Y71.23 E.01506
G1 X91.997 Y71.464 E.01037
G1 X92.027 Y71.531 E.00278
; WIPE_START
G1 X92.108 Y71.713 E-.03795
G1 X92.215 Y72.099 E-.07598
G1 X92.251 Y72.501 E-.07665
G1 X92.215 Y72.899 E-.07597
G1 X92.151 Y73.164 E-.05181
G1 X92.058 Y73.412 E-.0504
G1 X92.029 Y73.464 E-.01124
; WIPE_END
G1 E-.02 F1800
M204 S6000
G1 X99.563 Y72.244 Z.6 F18000
G1 X121.136 Y68.751 Z.6
G1 Z.2
G1 E.4 F1800
; FEATURE: Inner wall
G1 F900
M204 S500
G1 X121.136 Y68.837 E.00326
G1 X54.364 Y68.837 E2.53775
G1 X54.364 Y65.165 E.13955
G1 X121.136 Y65.165 E2.53775
G1 X121.136 Y68.691 E.134
M204 S6000
G1 X121.593 Y68.751 F18000
G1 F900
M204 S500
G1 X121.593 Y69.294 E.02064
G1 X90.856 Y69.294 E1.16821
G1 X91.463 Y69.965 E.03441
G1 X91.326 Y70.146 E.00865
G1 X90.999 Y69.983 E.01387
G1 X90.681 Y69.88 E.01271
G1 X90.353 Y69.815 E.01271
G1 X89.878 Y69.794 E.01806
G1 X89.397 Y69.859 E.01847
G1 X88.934 Y70.009 E.0185
G1 X88.679 Y70.147 E.01102
G1 X88.536 Y69.965 E.00879
G1 X89.144 Y69.294 E.03443
G1 X53.907 Y69.294 E1.33924
G1 X53.907 Y64.708 E.17429
G1 X121.593 Y64.708 E2.57249
G1 X121.593 Y68.691 E.15138
; WIPE_START
G1 X121.593 Y69.294 E-.11456
G1 X120.196 Y69.294 E-.26544
; WIPE_END
G1 E-.02 F1800
M204 S6000
G1 X125.55 Y68.751 Z.6 F18000
G1 Z.2
G1 E.4 F1800
; FEATURE: Outer wall
G1 F900
M204 S500
G1 X122.05 Y68.751 E.13302
G1 X122.05 Y65.251 E.13302
G1 X125.55 Y65.251 E.13302
G1 X125.55 Y68.691 E.13074
; WIPE_START
M73 P27 R25
G1 X123.55 Y68.725 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S6000
G1 X115.921 Y68.946 Z.6 F18000
G1 X88.114 Y69.751 Z.6
G1 Z.2
G1 E.4 F1800
G1 F900
M204 S500
G1 X53.45 Y69.751 E1.31745
G1 X53.45 Y64.251 E.20903
G1 X126.55 Y64.251 E2.77826
G1 X126.55 Y69.751 E.20903
G1 X91.886 Y69.751 E1.31745
G1 X92.535 Y70.468 E.03678
G1 X92.755 Y70.778 E.01445
G1 X92.856 Y70.951 E.0076
G1 X93.087 Y71.486 E.02216
G1 X93.188 Y71.869 E.01505
G1 X93.249 Y72.446 E.02204
G1 X93.207 Y73.024 E.02204
G1 X93.062 Y73.589 E.02216
G1 X92.913 Y73.939 E.01446
G1 X92.712 Y74.291 E.01543
G1 X92.348 Y74.747 E.02215
G1 X91.922 Y75.121 E.02154
G1 X91.581 Y75.34 E.01542
G1 X91.063 Y75.571 E.02154
G1 X90.676 Y75.679 E.01529
G1 X90.101 Y75.749 E.02202
G1 X89.708 Y75.737 E.01492
G1 X89.138 Y75.634 E.02204
G1 X88.763 Y75.506 E.01506
G1 X88.26 Y75.245 E.02155
G1 X87.931 Y75.007 E.01543
G1 X87.528 Y74.609 E.02153
G1 X87.286 Y74.288 E.01528
G1 X87.092 Y73.951 E.01478
G1 X86.88 Y73.411 E.02203
G1 X86.796 Y73.04 E.01444
G1 X86.753 Y72.641 E.01528
G1 X86.76 Y72.252 E.01478
G1 X86.813 Y71.866 E.01479
G1 X86.913 Y71.486 E.01493
M73 P28 R25
G1 X87.144 Y70.951 E.02215
G1 X87.245 Y70.778 E.0076
G1 X87.465 Y70.468 E.01445
G1 X88.074 Y69.795 E.0345
M204 S6000
G1 X88.618 Y70.439 F18000
; FEATURE: Gap infill
; LINE_WIDTH: 0.583495
G1 F900
M204 S500
G1 X88.222 Y70.39 E.01792
G1 X87.965 Y70.655 E.01661
G1 X87.7 Y71.004 E.0197
G1 X87.588 Y71.189 E.00971
G1 X87.454 Y71.476 E.01424
G1 X87.389 Y71.643 E.00806
G1 X87.305 Y71.964 E.01491
G1 X87.263 Y72.29 E.01479
G1 X87.253 Y72.552 E.01176
G1 X87.289 Y72.954 E.01817
G1 X87.413 Y73.42 E.02167
G1 X87.539 Y73.727 E.01492
G1 X87.792 Y74.135 E.02155
G1 X88.12 Y74.501 E.02211
G1 X88.507 Y74.809 E.02221
G1 X88.9 Y75.017 E.02001
G1 X89.274 Y75.152 E.01783
G1 X89.753 Y75.235 E.02188
G1 X90.255 Y75.234 E.02256
G1 X90.571 Y75.19 E.01434
G1 X90.983 Y75.065 E.01934
G1 X91.337 Y74.903 E.0175
G1 X91.627 Y74.716 E.0155
G1 X91.94 Y74.445 E.01861
G1 X92.256 Y74.067 E.02216
G1 X92.463 Y73.716 E.01834
G1 X92.638 Y73.274 E.02134
G1 X92.731 Y72.786 E.02235
G1 X92.749 Y72.477 E.01392
G1 X92.706 Y72.034 E.01998
G1 X92.609 Y71.64 E.01825
G1 X92.432 Y71.221 E.02046
G1 X92.25 Y70.929 E.01543
G1 X91.979 Y70.595 E.01935
G1 X91.578 Y70.192 E.02555
; WIPE_START
G1 X91.979 Y70.595 E-.108
G1 X92.25 Y70.929 E-.08179
G1 X92.432 Y71.221 E-.06523
G1 X92.609 Y71.64 E-.08647
G1 X92.657 Y71.837 E-.03852
; WIPE_END
G1 E-.02 F1800
M204 S6000
G1 X89.753 Y69.065 Z.6 F18000
G1 Z.2
G1 E.4 F1800
; LINE_WIDTH: 0.407723
G1 F900
M204 S500
G1 X90.873 Y69.654 E.03838
M204 S6000
G1 X90.581 Y69.331 F18000
; LINE_WIDTH: 0.549214
G1 F900
M204 S500
G1 X89.879 Y69.315 E.02954
G1 X89.406 Y69.345 E.01996
; WIPE_START
G1 X89.879 Y69.315 E-.15322
G1 X90.581 Y69.331 E-.22678
; WIPE_END
G1 E-.02 F1800
M204 S6000
G1 X98.213 Y69.311 Z.6 F18000
G1 X121.822 Y69.251 Z.6
G1 Z.2
G1 E.4 F1800
; LINE_WIDTH: 0.58586
G1 F900
M204 S500
G1 X125.779 Y69.251 E.17864
; LINE_WIDTH: 0.60915
G1 X125.891 Y69.227 E.00541
; LINE_WIDTH: 0.640199
G1 X126.003 Y69.204 E.0057
G1 X126.05 Y68.979 E.01141
; LINE_WIDTH: 0.58586
G1 X126.05 Y65.022 E.17864
; LINE_WIDTH: 0.60915
G1 X126.027 Y64.91 E.00541
; LINE_WIDTH: 0.640199
G1 X126.003 Y64.797 E.0057
G1 X125.779 Y64.751 E.01141
; LINE_WIDTH: 0.58586
G1 X121.822 Y64.751 E.17864
; WIPE_START
G1 X123.822 Y64.751 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S6000
G1 X120.02 Y65.348 Z.6 F18000
G1 Z.2
G1 E.4 F1800
; FEATURE: Bottom surface
; LINE_WIDTH: 0.50421
G1 F900
M204 S500
G1 X120.747 Y66.075 E.03945
G1 X120.747 Y66.727 E.02502
G1 X119.573 Y65.553 E.06368
G1 X118.921 Y65.553 E.02502
G1 X120.747 Y67.38 E.09906
G1 X120.747 Y68.032 E.02502
G1 X118.269 Y65.553 E.13445
G1 X117.616 Y65.553 E.02502
G1 X120.511 Y68.448 E.15702
G1 X119.859 Y68.448 E.02502
G1 X116.964 Y65.553 E.15702
G1 X116.312 Y65.553 E.02502
G1 X119.206 Y68.448 E.15702
G1 X118.554 Y68.448 E.02502
G1 X115.659 Y65.553 E.15702
G1 X115.007 Y65.553 E.02502
G1 X117.902 Y68.448 E.15702
G1 X117.249 Y68.448 E.02502
G1 X114.355 Y65.553 E.15702
G1 X113.702 Y65.553 E.02502
G1 X116.597 Y68.448 E.15702
G1 X115.945 Y68.448 E.02502
G1 X113.05 Y65.553 E.15702
G1 X112.397 Y65.553 E.02502
G1 X115.292 Y68.448 E.15702
G1 X114.64 Y68.448 E.02502
G1 X111.745 Y65.553 E.15702
G1 X111.093 Y65.553 E.02502
G1 X113.987 Y68.448 E.15702
G1 X113.335 Y68.448 E.02502
G1 X110.44 Y65.553 E.15702
G1 X109.788 Y65.553 E.02502
G1 X112.683 Y68.448 E.15702
G1 X112.03 Y68.448 E.02502
G1 X109.136 Y65.553 E.15702
G1 X108.483 Y65.553 E.02502
G1 X111.378 Y68.448 E.15702
G1 X110.726 Y68.448 E.02502
G1 X107.831 Y65.553 E.15702
G1 X107.179 Y65.553 E.02502
G1 X110.073 Y68.448 E.15702
G1 X109.421 Y68.448 E.02502
G1 X106.526 Y65.553 E.15702
G1 X105.874 Y65.553 E.02502
G1 X108.769 Y68.448 E.15702
G1 X108.116 Y68.448 E.02502
G1 X105.221 Y65.553 E.15702
G1 X104.569 Y65.553 E.02502
G1 X107.464 Y68.448 E.15702
G1 X106.811 Y68.448 E.02502
G1 X103.917 Y65.553 E.15702
G1 X103.264 Y65.553 E.02502
G1 X106.159 Y68.448 E.15702
G1 X105.507 Y68.448 E.02502
G1 X102.612 Y65.553 E.15702
G1 X101.96 Y65.553 E.02502
G1 X104.854 Y68.448 E.15702
G1 X104.202 Y68.448 E.02502
G1 X101.307 Y65.553 E.15702
G1 X100.655 Y65.553 E.02502
G1 X103.55 Y68.448 E.15702
G1 X102.897 Y68.448 E.02502
G1 X100.003 Y65.553 E.15702
G1 X99.35 Y65.553 E.02502
G1 X102.245 Y68.448 E.15702
G1 X101.593 Y68.448 E.02502
G1 X98.698 Y65.553 E.15702
G1 X98.046 Y65.553 E.02502
G1 X100.94 Y68.448 E.15702
G1 X100.288 Y68.448 E.02502
G1 X97.393 Y65.553 E.15702
G1 X96.741 Y65.553 E.02502
G1 X99.635 Y68.448 E.15702
G1 X98.983 Y68.448 E.02502
G1 X96.088 Y65.553 E.15702
G1 X95.436 Y65.553 E.02502
G1 X98.331 Y68.448 E.15702
G1 X97.678 Y68.448 E.02502
G1 X94.784 Y65.553 E.15702
G1 X94.131 Y65.553 E.02502
G1 X97.026 Y68.448 E.15702
G1 X96.374 Y68.448 E.02502
G1 X93.479 Y65.553 E.15702
G1 X92.827 Y65.553 E.02502
G1 X95.721 Y68.448 E.15702
G1 X95.069 Y68.448 E.02502
G1 X92.174 Y65.553 E.15702
G1 X91.522 Y65.553 E.02502
G1 X94.417 Y68.448 E.15702
G1 X93.764 Y68.448 E.02502
G1 X90.87 Y65.553 E.15702
G1 X90.217 Y65.553 E.02502
G1 X93.112 Y68.448 E.15702
G1 X92.459 Y68.448 E.02502
M73 P28 R24
G1 X89.565 Y65.553 E.15702
G1 X88.912 Y65.553 E.02502
G1 X91.807 Y68.448 E.15702
G1 X91.155 Y68.448 E.02502
G1 X88.26 Y65.553 E.15702
G1 X87.608 Y65.553 E.02502
G1 X90.502 Y68.448 E.15702
G1 X89.85 Y68.448 E.02502
G1 X86.955 Y65.553 E.15702
G1 X86.303 Y65.553 E.02502
G1 X89.198 Y68.448 E.15702
G1 X88.545 Y68.448 E.02502
G1 X85.651 Y65.553 E.15702
G1 X84.998 Y65.553 E.02502
G1 X87.893 Y68.448 E.15702
G1 X87.241 Y68.448 E.02502
G1 X84.346 Y65.553 E.15702
G1 X83.694 Y65.553 E.02502
G1 X86.588 Y68.448 E.15702
G1 X85.936 Y68.448 E.02502
G1 X83.041 Y65.553 E.15702
G1 X82.389 Y65.553 E.02502
G1 X85.283 Y68.448 E.15702
G1 X84.631 Y68.448 E.02502
G1 X81.736 Y65.553 E.15702
G1 X81.084 Y65.553 E.02502
G1 X83.979 Y68.448 E.15702
G1 X83.326 Y68.448 E.02502
G1 X80.432 Y65.553 E.15702
G1 X79.779 Y65.553 E.02502
G1 X82.674 Y68.448 E.15702
G1 X82.022 Y68.448 E.02502
M73 P29 R24
G1 X79.127 Y65.553 E.15702
G1 X78.475 Y65.553 E.02502
G1 X81.369 Y68.448 E.15702
G1 X80.717 Y68.448 E.02502
G1 X77.822 Y65.553 E.15702
G1 X77.17 Y65.553 E.02502
G1 X80.065 Y68.448 E.15702
G1 X79.412 Y68.448 E.02502
G1 X76.518 Y65.553 E.15702
G1 X75.865 Y65.553 E.02502
G1 X78.76 Y68.448 E.15702
G1 X78.108 Y68.448 E.02502
G1 X75.213 Y65.553 E.15702
G1 X74.56 Y65.553 E.02502
G1 X77.455 Y68.448 E.15702
G1 X76.803 Y68.448 E.02502
G1 X73.908 Y65.553 E.15702
G1 X73.256 Y65.553 E.02502
G1 X76.15 Y68.448 E.15702
G1 X75.498 Y68.448 E.02502
G1 X72.603 Y65.553 E.15702
G1 X71.951 Y65.553 E.02502
G1 X74.846 Y68.448 E.15702
G1 X74.193 Y68.448 E.02502
G1 X71.299 Y65.553 E.15702
G1 X70.646 Y65.553 E.02502
G1 X73.541 Y68.448 E.15702
G1 X72.889 Y68.448 E.02502
G1 X69.994 Y65.553 E.15702
G1 X69.342 Y65.553 E.02502
G1 X72.236 Y68.448 E.15702
G1 X71.584 Y68.448 E.02502
G1 X68.689 Y65.553 E.15702
G1 X68.037 Y65.553 E.02502
G1 X70.932 Y68.448 E.15702
G1 X70.279 Y68.448 E.02502
G1 X67.384 Y65.553 E.15702
G1 X66.732 Y65.553 E.02502
G1 X69.627 Y68.448 E.15702
G1 X68.974 Y68.448 E.02502
G1 X66.08 Y65.553 E.15702
G1 X65.427 Y65.553 E.02502
G1 X68.322 Y68.448 E.15702
G1 X67.67 Y68.448 E.02502
G1 X64.775 Y65.553 E.15702
G1 X64.123 Y65.553 E.02502
G1 X67.017 Y68.448 E.15702
G1 X66.365 Y68.448 E.02502
G1 X63.47 Y65.553 E.15702
G1 X62.818 Y65.553 E.02502
G1 X65.713 Y68.448 E.15702
G1 X65.06 Y68.448 E.02502
G1 X62.166 Y65.553 E.15702
G1 X61.513 Y65.553 E.02502
G1 X64.408 Y68.448 E.15702
G1 X63.756 Y68.448 E.02502
G1 X60.861 Y65.553 E.15702
G1 X60.208 Y65.553 E.02502
G1 X63.103 Y68.448 E.15702
G1 X62.451 Y68.448 E.02502
G1 X59.556 Y65.553 E.15702
G1 X58.904 Y65.553 E.02502
G1 X61.798 Y68.448 E.15702
G1 X61.146 Y68.448 E.02502
G1 X58.251 Y65.553 E.15702
G1 X57.599 Y65.553 E.02502
G1 X60.494 Y68.448 E.15702
G1 X59.841 Y68.448 E.02502
G1 X56.947 Y65.553 E.15702
G1 X56.294 Y65.553 E.02502
G1 X59.189 Y68.448 E.15702
G1 X58.537 Y68.448 E.02502
G1 X55.642 Y65.553 E.15702
G1 X54.99 Y65.553 E.02502
G1 X57.884 Y68.448 E.15702
G1 X57.232 Y68.448 E.02502
G1 X54.753 Y65.969 E.13448
G1 X54.753 Y66.621 E.02502
G1 X56.58 Y68.448 E.0991
G1 X55.927 Y68.448 E.02502
G1 X54.753 Y67.274 E.06371
G1 X54.753 Y67.926 E.02502
G1 X55.48 Y68.654 E.03948
; CHANGE_LAYER
; Z_HEIGHT: 0.32
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F900
G1 X54.753 Y67.926 E-.19557
G1 X54.753 Y67.274 E-.12395
G1 X54.978 Y67.499 E-.06048
; WIPE_END
G1 E-.02 F1800
; stop printing object, unique label id: 8
M625
; layer num/total_layer_count: 2/51
; update layer progress
M73 L2
M991 S0 P1 ;notify layer change
M106 S255
; open powerlost recovery
M1003 S1
; OBJECT_ID: 12
; start printing object, unique label id: 12
M624 AgAAAAAAAAA=
M204 S10000
G17
G3 Z.6 I-.901 J.818 P1  F18000
G1 X89.325 Y105.301 Z.6
G1 Z.32
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X89.257 Y105.283 E.00139
G1 X89.011 Y105.178 E.00526
G1 X88.78 Y105.044 E.00526
G1 X88.472 Y104.799 E.00773
G1 X88.213 Y104.503 E.00773
G1 X88.069 Y104.277 E.00526
G1 X87.953 Y104.036 E.00526
G1 X87.837 Y103.66 E.00774
G1 X87.791 Y103.27 E.00773
G1 X87.799 Y103.003 E.00526
G1 X87.838 Y102.738 E.00526
G1 X87.954 Y102.362 E.00774
G1 X88.137 Y102.011 E.00779
G1 X88.377 Y101.699 E.00774
G1 X88.571 Y101.515 E.00526
G1 X88.785 Y101.354 E.00526
G1 X89.131 Y101.168 E.00773
G1 X89.508 Y101.045 E.00779
G1 X89.898 Y100.993 E.00774
G1 X90.165 Y100.997 E.00526
G1 X90.43 Y101.033 E.00526
G1 X90.808 Y101.143 E.00773
G1 X91.16 Y101.319 E.00774
G1 X91.378 Y101.473 E.00526
G1 X91.577 Y101.652 E.00526
G1 X91.827 Y101.955 E.00774
G1 X92.02 Y102.302 E.0078
G1 X92.147 Y102.674 E.00773
G1 X92.195 Y102.937 E.00527
G1 X92.211 Y103.204 E.00526
G1 X92.176 Y103.592 E.00767
G1 X92.112 Y103.852 E.00526
G1 X92.026 Y104.084 E.00487
G1 X91.827 Y104.446 E.00812
G1 X91.575 Y104.752 E.00781
G1 X91.275 Y105.007 E.00773
G1 X91.048 Y105.147 E.00526
G1 X90.823 Y105.252 E.00487
G1 X90.428 Y105.37 E.00812
G1 X90.033 Y105.411 E.00781
G1 X89.638 Y105.382 E.00779
G1 X89.384 Y105.316 E.00517
M204 S10000
G1 X89.223 Y105.697 F18000
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X89.57 Y105.787 E.00761
G1 X90.039 Y105.822 E.00995
G1 X90.509 Y105.773 E.00999
G1 X91.058 Y105.609 E.01214
G1 X91.141 Y105.832 E.00504
G1 X90.952 Y105.917 E.0044
G1 X90.597 Y106.018 E.00782
G1 X90.093 Y106.079 E.01074
G1 X89.741 Y106.069 E.00746
G1 X89.421 Y106.021 E.00683
G1 X88.915 Y105.867 E.01121
G1 X88.696 Y105.755 E.00521
G1 X88.722 Y105.698 E.00133
G1 X88.692 Y105.753 E.00133
G1 X88.486 Y105.65 E.00488
G1 X88.168 Y105.422 E.00828
G1 X87.917 Y105.189 E.00726
G1 X87.695 Y104.927 E.00725
G1 X87.495 Y104.618 E.0078
G1 X87.403 Y104.418 E.00465
G1 X87.632 Y104.311 E.00533
G1 X87.711 Y104.477 E.00389
G1 X87.885 Y104.749 E.00683
G1 X88.188 Y105.096 E.00975
G1 X88.548 Y105.383 E.00975
G1 X88.81 Y105.537 E.00643
G1 X89.125 Y105.671 E.00723
G1 X89.164 Y105.682 E.00087
; WIPE_START
M204 S6000
G1 X89.57 Y105.787 E-.0797
G1 X90.039 Y105.822 E-.0893
G1 X90.509 Y105.773 E-.0897
G1 X91.058 Y105.609 E-.10897
G1 X91.081 Y105.669 E-.01233
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X91.137 Y105.573 Z.72 F18000
G1 Z.32
G1 E.4 F1800
G1 F1500
M204 S500
G1 X91.516 Y105.339 E.00943
G1 X91.868 Y105.041 E.00975
G1 X92.167 Y104.676 E.00999
G1 X92.444 Y104.173 E.01216
G1 X92.66 Y104.273 E.00504
G1 X92.585 Y104.466 E.00436
G1 X92.399 Y104.794 E.008
G1 X92.083 Y105.189 E.0107
G1 X91.702 Y105.524 E.01075
G1 X91.411 Y105.711 E.00732
G1 X91.249 Y105.783 E.00376
G1 X91.165 Y105.626 E.00378
; WIPE_START
M204 S6000
G1 X91.516 Y105.339 E-.08617
G1 X91.868 Y105.041 E-.0875
G1 X92.167 Y104.676 E-.08968
G1 X92.444 Y104.173 E-.10916
G1 X92.48 Y104.189 E-.00749
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X89.393 Y100.22 Z.72 F18000
G1 Z.32
G1 E.4 F1800
G1 F1500
M204 S500
G1 X89.903 Y99.657 E.01606
G1 X54.243 Y99.657 E.75475
G1 X54.243 Y95.744 E.08282
G1 X121.843 Y95.744 E1.43081
G1 X121.843 Y94.344 E.02963
G1 X125.757 Y94.344 E.08282
G1 X125.757 Y101.057 E.14209
G1 X121.843 Y101.057 E.08282
G1 X121.843 Y99.657 E.02963
G1 X89.999 Y99.657 E.67401
G1 X90.49 Y100.168 E.01499
G1 X89.848 Y100.158 E.01359
G1 X89.453 Y100.212 E.00844
; WIPE_START
M204 S6000
G1 X89.903 Y99.657 E-.13564
G1 X88.616 Y99.657 E-.24436
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X90.995 Y100.082 Z.72 F18000
G1 Z.32
G1 E.4 F1800
G1 F1500
M204 S500
G1 X92.129 Y101.261 E.03463
G1 X92.351 Y101.537 E.00749
G1 X92.528 Y101.823 E.00713
G1 X92.729 Y102.285 E.01065
G1 X92.825 Y102.641 E.0078
G1 X92.88 Y103.143 E.0107
G1 X92.844 Y103.659 E.01094
G1 X92.767 Y103.996 E.00732
G1 X92.703 Y104.163 E.00378
G1 X92.475 Y104.091 E.00505
G1 X92.58 Y103.66 E.00941
G1 X92.621 Y103.21 E.00955
G1 X92.602 Y102.888 E.00683
M73 P30 R24
G1 X92.544 Y102.57 E.00684
G1 X92.395 Y102.134 E.00975
G1 X92.166 Y101.724 E.00995
G1 X91.873 Y101.368 E.00975
G1 X91.634 Y101.152 E.00683
G1 X91.37 Y100.966 E.00683
G1 X90.958 Y100.76 E.00976
G1 X90.516 Y100.631 E.00975
G1 X90.196 Y100.588 E.00683
G1 X89.873 Y100.583 E.00683
G1 X89.416 Y100.645 E.00975
G1 X88.97 Y100.79 E.00994
G1 X88.564 Y101.008 E.00975
G1 X88.306 Y101.202 E.00683
G1 X88.072 Y101.425 E.00683
G1 X87.791 Y101.789 E.00975
G1 X87.574 Y102.207 E.00994
G1 X87.438 Y102.647 E.00975
G1 X87.39 Y102.966 E.00683
G1 X87.381 Y103.289 E.00683
G1 X87.436 Y103.746 E.00975
G1 X87.597 Y104.269 E.01159
G1 X87.374 Y104.354 E.00505
G1 X87.285 Y104.16 E.00451
G1 X87.191 Y103.836 E.00714
G1 X87.123 Y103.332 E.01078
G1 X87.129 Y102.98 E.00744
G1 X87.176 Y102.639 E.00729
G1 X87.263 Y102.305 E.0073
G1 X87.462 Y101.838 E.01074
G1 X87.747 Y101.406 E.01095
G1 X88.946 Y100.082 E.03782
G1 X53.819 Y100.082 E.74349
G1 X53.819 Y95.32 E.10078
G1 X121.419 Y95.32 E1.43081
G1 X121.419 Y93.92 E.02963
G1 X126.181 Y93.92 E.10078
G1 X126.181 Y101.482 E.16005
G1 X121.419 Y101.482 E.10078
G1 X121.419 Y100.082 E.02963
G1 X91.055 Y100.082 E.64268
M204 S250
G1 X91.956 Y100.491 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X92.437 Y100.991 E.01364
G1 X92.685 Y101.3 E.0078
G1 X92.892 Y101.633 E.0077
G1 X93.116 Y102.149 E.01108
G1 X93.226 Y102.559 E.00835
G1 X93.289 Y103.142 E.01154
G1 X93.272 Y103.542 E.00787
G1 X93.16 Y104.116 E.0115
G1 X92.956 Y104.641 E.01108
G1 X92.746 Y105.013 E.00841
G1 X92.38 Y105.472 E.01154
G1 X91.938 Y105.859 E.01155
G1 X91.606 Y106.071 E.00775
G1 X91.092 Y106.303 E.01108
G1 X90.684 Y106.419 E.00835
G1 X90.101 Y106.489 E.01155
G1 X89.705 Y106.477 E.0078
G1 X89.126 Y106.372 E.01156
G1 X88.754 Y106.245 E.00774
G1 X88.253 Y105.987 E.01108
G1 X87.908 Y105.74 E.00834
G1 X87.62 Y105.472 E.00774
G1 X87.366 Y105.172 E.00773
G1 X87.135 Y104.816 E.00835
G1 X86.901 Y104.303 E.01108
G1 X86.792 Y103.928 E.0077
G1 X86.713 Y103.345 E.01156
G1 X86.72 Y102.949 E.0078
G1 X86.774 Y102.559 E.00774
G1 X86.874 Y102.177 E.00775
G1 X87.105 Y101.638 E.01155
G1 X87.316 Y101.298 E.00787
G1 X87.431 Y101.145 E.00375
G1 X88.024 Y100.491 E.01737
G1 X53.41 Y100.491 E.68082
G1 X53.41 Y94.911 E.10975
G1 X121.01 Y94.911 E1.32963
G1 X121.01 Y93.511 E.02754
G1 X126.59 Y93.511 E.10975
G1 X126.59 Y101.891 E.16483
G1 X121.01 Y101.891 E.10975
G1 X121.01 Y100.491 E.02754
G1 X92.016 Y100.491 E.57028
; WIPE_START
M204 S6000
G1 X92.437 Y100.991 E-.12413
G1 X92.685 Y101.3 E-.07539
G1 X92.892 Y101.633 E-.07436
G1 X93.114 Y102.145 E-.10611
; WIPE_END
G1 E-.02 F1800
M204 S10000
G17
G3 Z.72 I1.217 J0 P1  F18000
; stop printing object, unique label id: 12
M625
; object ids of layer 2 start: 8,12
M624 AwAAAAAAAAA=
;===================== date: 20250206 =====================

; don't support timelapse gcode in spiral_mode and by object sequence for I3 structure printer
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
G92 E0
G1 Z0.72
G1 X0 Y85.35 ; move to safe pos
G1 X-13.0 F3000 ; move to safe pos
M400
M1004 S5 P1  ; external shutter
M400 P300
M971 S11 C11 O0
G92 E0
G1 X0 F18000
M623

; SKIPTYPE: head_wrap_detect
M622.1 S1
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




; object ids of this layer2 end: 8,12
M625
; start printing object, unique label id: 12
M624 AgAAAAAAAAA=
G1 X91.175 Y100.607
G1 Z.32
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.113854
G1 F1500
M204 S6000
G1 X90.856 Y100.386 E.0017
M204 S10000
G1 X91.085 Y100.481 F18000
; LINE_WIDTH: 0.152041
G1 F1500
M204 S6000
G1 X90.833 Y100.443 E.0016
; LINE_WIDTH: 0.103847
G1 X90.581 Y100.405 E.00099
; WIPE_START
G1 X90.833 Y100.443 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X89.101 Y100.498 Z.72 F18000
G1 Z.32
G1 E.4 F1800
; LINE_WIDTH: 0.0985559
G1 F1500
M204 S6000
G1 X88.869 Y100.551 E.00087
G1 X88.761 Y100.636 E.0005
; WIPE_START
G1 X88.869 Y100.551 E-.13923
G1 X89.101 Y100.498 E-.24077
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X81.496 Y99.852 Z.72 F18000
G1 X56.2 Y97.701 Z.72
G1 Z.32
G1 E.4 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.360652
G1 F1500
M204 S6000
G1 X121.996 Y97.701 E1.09933
; WIPE_START
G1 X119.996 Y97.701 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G17
G3 Z.72 I-.731 J.973 P1  F18000
M73 P31 R24
G1 X122.056 Y99.248 Z.72
G1 Z.32
G1 E.4 F1800
; LINE_WIDTH: 0.419992
G1 F1500
M204 S6000
G1 X122.174 Y99.287 E.00245
G1 X122.253 Y99.445 E.00347
G1 X122.253 Y100.648 E.02366
G1 X125.347 Y100.648 E.06087
G1 X125.347 Y94.753 E.11594
G1 X122.253 Y94.753 E.06087
G1 X122.253 Y95.956 E.02366
G1 X122.174 Y96.114 E.00347
G1 X122.056 Y96.153 E.00245
G1 X54.653 Y96.153 E1.32573
G1 X54.653 Y99.248 E.06087
G1 X121.996 Y99.248 E1.32455
M204 S10000
G1 X122.056 Y98.854 F18000
G1 F1500
M204 S6000
G1 X122.263 Y98.891 E.00415
G1 X122.41 Y98.972 E.0033
G1 X122.548 Y99.118 E.00394
G1 X122.647 Y99.445 E.00673
G1 X122.647 Y100.254 E.01591
G1 X124.953 Y100.254 E.04536
G1 X124.953 Y95.148 E.10043
G1 X122.647 Y95.148 E.04536
G1 X122.647 Y95.956 E.0159
G1 X122.548 Y96.284 E.00673
G1 X122.41 Y96.429 E.00394
G1 X122.263 Y96.51 E.0033
G1 X122.056 Y96.548 E.00415
G1 X55.047 Y96.548 E1.31797
G1 X55.047 Y98.854 E.04536
G1 X121.996 Y98.854 E1.31679
M204 S10000
G1 X122.056 Y98.46 F18000
G1 F1500
M204 S6000
G1 X122.402 Y98.522 E.00692
G1 X122.647 Y98.657 E.0055
G1 X122.876 Y98.9 E.00657
G1 X123.02 Y99.242 E.00731
G1 X123.041 Y99.86 E.01215
G1 X124.559 Y99.86 E.02985
G1 X124.559 Y95.542 E.08492
G1 X123.041 Y95.542 E.02985
G1 X123.02 Y96.159 E.01215
G1 X122.876 Y96.502 E.00731
G1 X122.647 Y96.745 E.00657
G1 X122.402 Y96.879 E.0055
G1 X122.056 Y96.942 E.00692
G1 X55.441 Y96.942 E1.31022
G1 X55.441 Y98.46 E.02985
G1 X121.996 Y98.46 E1.30904
M204 S10000
G1 X122.056 Y98.065 F18000
G1 F1500
M204 S6000
G1 X122.54 Y98.153 E.00968
G1 X122.884 Y98.341 E.0077
G1 X123.205 Y98.681 E.0092
G1 X123.406 Y99.161 E.01023
G1 X123.456 Y99.465 E.00607
G1 X124.165 Y99.465 E.01394
G1 X124.165 Y95.936 E.06941
G1 X123.435 Y95.936 E.01434
G1 X123.406 Y96.241 E.00602
M73 P31 R23
G1 X123.205 Y96.72 E.01023
G1 X122.884 Y97.06 E.0092
G1 X122.54 Y97.248 E.0077
G1 X122.056 Y97.336 E.00968
G1 X55.835 Y97.336 E1.30247
G1 X55.835 Y98.065 E.01434
G1 X121.996 Y98.065 E1.30129
M204 S10000
G1 X122.056 Y97.701 F18000
; LINE_WIDTH: 0.375487
G1 F1500
M204 S6000
G1 X122.367 Y97.742 E.00548
; LINE_WIDTH: 0.419265
G1 X122.679 Y97.784 E.00617
G1 X123.12 Y98.026 E.00988
G1 X123.533 Y98.463 E.01181
G1 X123.77 Y99.029 E.01205
G1 X123.77 Y96.373 E.05215
G1 X123.533 Y96.939 E.01205
G1 X123.12 Y97.376 E.01181
G1 X122.679 Y97.618 E.00988
; LINE_WIDTH: 0.405157
G1 X122.397 Y97.655 E.00538
; LINE_WIDTH: 0.375487
G1 X122.115 Y97.693 E.00496
; WIPE_START
M73 P32 R23
G1 X122.397 Y97.655 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G17
G3 Z.72 I0 J1.217 P1  F18000
G1 X123.39 Y97.655 Z.72
G1 Z.32
G1 E.4 F1800
; LINE_WIDTH: 0.444372
G1 F1500
M204 S6000
G1 X123.338 Y97.655 E.00109
G1 X123.312 Y97.701 E.00109
G1 X123.338 Y97.746 E.00109
G1 X123.382 Y97.746 E.00093
; OBJECT_ID: 8
; WIPE_START
G1 X123.338 Y97.746 E-.08413
G1 X123.312 Y97.701 E-.09862
G1 X123.338 Y97.655 E-.09862
G1 X123.39 Y97.655 E-.09862
; WIPE_END
G1 E-.02 F1800
; stop printing object, unique label id: 12
M625
; start printing object, unique label id: 8
M624 AQAAAAAAAAA=
M204 S10000
G17
G3 Z.72 I.778 J-.936 P1  F18000
G1 X92.02 Y71.603 Z.72
G1 Z.32
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X92.147 Y71.974 E.0077
G1 X92.195 Y72.237 E.00527
G1 X92.211 Y72.504 E.00526
G1 X92.176 Y72.892 E.00767
G1 X92.112 Y73.152 E.00526
G1 X92.026 Y73.384 E.00487
G1 X91.827 Y73.746 E.00812
G1 X91.575 Y74.052 E.00781
G1 X91.275 Y74.307 E.00773
G1 X91.048 Y74.447 E.00526
G1 X90.823 Y74.552 E.00487
G1 X90.428 Y74.67 E.00812
G1 X90.033 Y74.711 E.00781
G1 X89.638 Y74.682 E.00779
G1 X89.257 Y74.583 E.00773
G1 X89.011 Y74.478 E.00526
G1 X88.78 Y74.344 E.00526
G1 X88.472 Y74.099 E.00774
G1 X88.213 Y73.803 E.00773
G1 X88.069 Y73.577 E.00526
G1 X87.953 Y73.336 E.00526
G1 X87.837 Y72.96 E.00774
G1 X87.791 Y72.57 E.00773
G1 X87.799 Y72.303 E.00526
G1 X87.838 Y72.038 E.00526
G1 X87.954 Y71.662 E.00774
G1 X88.137 Y71.311 E.00779
G1 X88.377 Y70.999 E.00774
G1 X88.571 Y70.815 E.00526
G1 X88.785 Y70.654 E.00526
G1 X89.131 Y70.468 E.00773
G1 X89.508 Y70.345 E.00779
G1 X89.898 Y70.293 E.00774
G1 X90.165 Y70.297 E.00526
G1 X90.43 Y70.333 E.00526
G1 X90.808 Y70.443 E.00773
G1 X91.16 Y70.619 E.00774
G1 X91.378 Y70.773 E.00526
G1 X91.577 Y70.952 E.00526
G1 X91.827 Y71.255 E.00774
G1 X91.991 Y71.551 E.00665
; WIPE_START
M204 S6000
G1 X92.147 Y71.974 E-.08563
G1 X92.195 Y72.237 E-.05087
G1 X92.211 Y72.504 E-.05081
G1 X92.176 Y72.892 E-.07409
G1 X92.112 Y73.152 E-.0508
G1 X92.026 Y73.384 E-.04701
G1 X91.973 Y73.48 E-.02079
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X91.058 Y74.909 Z.72 F18000
G1 Z.32
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X91.141 Y75.132 E.00504
G1 X90.952 Y75.217 E.0044
G1 X90.597 Y75.318 E.00782
G1 X90.093 Y75.379 E.01074
G1 X89.741 Y75.369 E.00746
G1 X89.421 Y75.321 E.00683
G1 X88.915 Y75.167 E.01121
G1 X88.696 Y75.055 E.00521
G1 X88.723 Y74.997 E.00135
G1 X88.692 Y75.053 E.00135
G1 X88.486 Y74.95 E.00488
G1 X88.168 Y74.722 E.00829
G1 X87.917 Y74.489 E.00726
G1 X87.695 Y74.227 E.00725
G1 X87.495 Y73.918 E.0078
G1 X87.403 Y73.718 E.00465
G1 X87.632 Y73.611 E.00533
G1 X87.711 Y73.777 E.00389
G1 X87.885 Y74.049 E.00683
G1 X88.188 Y74.396 E.00975
G1 X88.548 Y74.683 E.00975
G1 X88.81 Y74.837 E.00643
G1 X89.125 Y74.971 E.00724
G1 X89.57 Y75.087 E.00975
G1 X90.039 Y75.122 E.00995
G1 X90.509 Y75.073 E.00999
G1 X91.001 Y74.926 E.01087
; WIPE_START
M204 S6000
G1 X91.141 Y75.132 E-.0474
G1 X90.952 Y75.217 E-.0395
G1 X90.597 Y75.318 E-.07016
G1 X90.093 Y75.379 E-.09639
G1 X89.741 Y75.369 E-.06692
G1 X89.43 Y75.323 E-.05963
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X96.903 Y73.77 Z.72 F18000
G1 X121.257 Y68.711 Z.72
G1 Z.32
G1 E.4 F1800
G1 F1500
M204 S500
G1 X121.257 Y68.957 E.00522
G1 X89.999 Y68.957 E.66159
G1 X90.49 Y69.468 E.01499
G1 X89.848 Y69.458 E.0136
G1 X89.393 Y69.52 E.00971
G1 X89.902 Y68.957 E.01606
G1 X54.243 Y68.957 E.75475
G1 X54.243 Y65.044 E.08282
G1 X121.257 Y65.044 E1.41839
G1 X121.257 Y68.651 E.07633
; WIPE_START
M204 S6000
G1 X121.257 Y68.957 E-.05824
G1 X119.563 Y68.957 E-.32176
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X125.51 Y69.12 Z.72 F18000
G1 Z.32
G1 E.4 F1800
G1 F1500
M204 S500
G1 X121.681 Y69.12 E.08105
G1 X121.681 Y64.882 E.08971
G1 X125.919 Y64.882 E.08971
G1 X125.919 Y69.12 E.08971
G1 X125.57 Y69.12 E.00739
M204 S250
G1 X125.51 Y68.711 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X122.09 Y68.711 E.06727
G1 X122.09 Y65.291 E.06727
G1 X125.51 Y65.291 E.06727
G1 X125.51 Y68.651 E.06609
; WIPE_START
M204 S6000
G1 X123.51 Y68.686 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X115.879 Y68.839 Z.72 F18000
G1 X88.946 Y69.382 Z.72
G1 Z.32
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X53.819 Y69.382 E.74349
G1 X53.819 Y64.62 E.10078
G1 X126.181 Y64.62 E1.53159
G1 X126.181 Y69.382 E.10078
G1 X90.995 Y69.382 E.74473
G1 X92.129 Y70.561 E.03463
G1 X92.35 Y70.837 E.00749
G1 X92.528 Y71.123 E.00713
G1 X92.729 Y71.585 E.01065
G1 X92.825 Y71.941 E.0078
G1 X92.88 Y72.443 E.0107
G1 X92.864 Y72.806 E.00769
G1 X92.765 Y73.305 E.01076
G1 X92.581 Y73.78 E.01078
G1 X92.4 Y74.093 E.00764
G1 X92.083 Y74.489 E.01074
G1 X91.824 Y74.73 E.0075
G1 X91.411 Y75.011 E.01057
G1 X91.249 Y75.083 E.00376
G1 X91.137 Y74.873 E.00505
G1 X91.516 Y74.639 E.00943
G1 X91.868 Y74.341 E.00975
G1 X92.167 Y73.976 E.00999
G1 X92.399 Y73.555 E.01018
G1 X92.504 Y73.272 E.00638
G1 X92.58 Y72.96 E.00681
G1 X92.621 Y72.51 E.00955
G1 X92.602 Y72.188 E.00683
G1 X92.544 Y71.87 E.00684
G1 X92.395 Y71.434 E.00975
G1 X92.166 Y71.024 E.00995
G1 X91.873 Y70.668 E.00975
G1 X91.634 Y70.452 E.00683
G1 X91.37 Y70.266 E.00683
M73 P33 R23
G1 X90.958 Y70.06 E.00976
G1 X90.516 Y69.931 E.00975
G1 X90.196 Y69.888 E.00683
G1 X89.873 Y69.883 E.00683
G1 X89.416 Y69.945 E.00975
G1 X88.97 Y70.09 E.00994
G1 X88.564 Y70.308 E.00975
G1 X88.306 Y70.502 E.00683
G1 X88.072 Y70.725 E.00683
G1 X87.791 Y71.089 E.00975
G1 X87.574 Y71.506 E.00994
G1 X87.438 Y71.947 E.00975
G1 X87.39 Y72.266 E.00683
G1 X87.381 Y72.589 E.00683
G1 X87.436 Y73.046 E.00975
G1 X87.597 Y73.569 E.01159
G1 X87.374 Y73.654 E.00505
G1 X87.285 Y73.46 E.00451
G1 X87.191 Y73.136 E.00714
G1 X87.138 Y72.818 E.00683
G1 X87.123 Y72.632 E.00396
G1 X87.129 Y72.28 E.00744
G1 X87.176 Y71.939 E.00729
G1 X87.263 Y71.605 E.0073
G1 X87.393 Y71.275 E.0075
G1 X87.627 Y70.873 E.00985
G1 X87.747 Y70.706 E.00435
G1 X88.906 Y69.426 E.03655
M204 S250
G1 X88.024 Y69.791 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X53.41 Y69.791 E.68082
G1 X53.41 Y64.211 E.10975
G1 X126.59 Y64.211 E1.43939
G1 X126.59 Y69.791 E.10975
G1 X91.956 Y69.791 E.68121
G1 X92.437 Y70.291 E.01364
G1 X92.685 Y70.6 E.00781
G1 X92.892 Y70.933 E.0077
G1 X93.116 Y71.449 E.01108
G1 X93.226 Y71.859 E.00835
G1 X93.289 Y72.442 E.01154
G1 X93.247 Y73.031 E.01161
G1 X93.159 Y73.419 E.00781
G1 X93.038 Y73.762 E.00716
G1 X92.945 Y73.966 E.00441
G1 X92.746 Y74.313 E.00786
G1 X92.38 Y74.772 E.01155
G1 X92.089 Y75.042 E.00781
G1 X91.606 Y75.371 E.0115
G1 X91.092 Y75.603 E.01108
G1 X90.684 Y75.719 E.00835
G1 X90.101 Y75.789 E.01155
G1 X89.705 Y75.777 E.0078
G1 X89.126 Y75.672 E.01156
G1 X88.754 Y75.545 E.00774
G1 X88.253 Y75.287 E.01108
G1 X87.908 Y75.04 E.00834
G1 X87.62 Y74.772 E.00774
G1 X87.366 Y74.472 E.00773
G1 X87.135 Y74.116 E.00835
G1 X86.901 Y73.603 E.01108
G1 X86.792 Y73.228 E.0077
G1 X86.713 Y72.645 E.01156
G1 X86.72 Y72.249 E.0078
G1 X86.774 Y71.859 E.00774
G1 X86.874 Y71.477 E.00775
G1 X87.105 Y70.938 E.01155
G1 X87.316 Y70.598 E.00787
G1 X87.431 Y70.445 E.00375
G1 X87.984 Y69.835 E.01619
M204 S10000
G1 X88.761 Y69.936 F18000
; FEATURE: Gap infill
; LINE_WIDTH: 0.0985587
G1 F1500
M204 S6000
G1 X88.869 Y69.851 E.0005
G1 X89.101 Y69.798 E.00087
; WIPE_START
G1 X88.869 Y69.851 E-.24076
G1 X88.761 Y69.936 E-.13924
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X90.581 Y69.705 Z.72 F18000
G1 Z.32
G1 E.4 F1800
; LINE_WIDTH: 0.103848
G1 F1500
M204 S6000
G1 X90.833 Y69.743 E.00099
; LINE_WIDTH: 0.152045
G1 X91.085 Y69.781 E.0016
M204 S10000
G1 X91.175 Y69.907 F18000
; LINE_WIDTH: 0.113861
G1 F1500
M204 S6000
G1 X90.856 Y69.686 E.0017
; WIPE_START
G1 X91.175 Y69.907 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X83.568 Y69.275 Z.72 F18000
G1 X56.2 Y67.001 Z.72
G1 Z.32
G1 E.4 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.360632
G1 F1500
M204 S6000
G1 X119.24 Y67.001 E1.05322
M204 S10000
G1 X119.665 Y67.365 F18000
; LINE_WIDTH: 0.419992
G1 F1500
M204 S6000
G1 X119.665 Y66.636 E.01434
G1 X55.835 Y66.636 E1.25544
G1 X55.835 Y67.365 E.01434
G1 X119.605 Y67.365 E1.25426
M204 S10000
G1 X120.059 Y67.76 F18000
G1 F1500
M204 S6000
G1 X120.059 Y66.242 E.02985
G1 X55.441 Y66.242 E1.27095
G1 X55.441 Y67.76 E.02985
G1 X119.999 Y67.76 E1.26977
M204 S10000
G1 X120.453 Y68.154 F18000
G1 F1500
M204 S6000
G1 X120.453 Y65.848 E.04536
G1 X55.047 Y65.848 E1.28645
G1 X55.047 Y68.154 E.04536
G1 X120.393 Y68.154 E1.28527
M204 S10000
G1 X120.847 Y68.548 F18000
G1 F1500
M204 S6000
G1 X120.847 Y65.453 E.06087
G1 X54.653 Y65.453 E1.30196
G1 X54.653 Y68.548 E.06087
G1 X120.787 Y68.548 E1.30078
; CHANGE_LAYER
; Z_HEIGHT: 0.44
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F1500
G1 X118.787 Y68.548 E-.38
; WIPE_END
G1 E-.02 F1800
; stop printing object, unique label id: 8
M625
; layer num/total_layer_count: 3/51
; update layer progress
M73 L3
M991 S0 P2 ;notify layer change
; OBJECT_ID: 12
; start printing object, unique label id: 12
M624 AgAAAAAAAAA=
M204 S10000
G17
G3 Z.72 I-.949 J-.761 P1  F18000
G1 X89.317 Y105.298 Z.72
G1 Z.44
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X89.257 Y105.283 E.00121
G1 X89.011 Y105.178 E.00526
G1 X88.78 Y105.044 E.00526
G1 X88.472 Y104.799 E.00774
G1 X88.211 Y104.5 E.00779
G1 X88.01 Y104.163 E.00773
G1 X87.908 Y103.916 E.00525
G1 X87.844 Y103.686 E.00468
G1 X87.79 Y103.268 E.0083
G1 X87.814 Y102.874 E.00775
G1 X87.869 Y102.613 E.00525
M73 P34 R23
G1 X87.945 Y102.387 E.00468
G1 X88.136 Y102.011 E.0083
G1 X88.377 Y101.699 E.00775
G1 X88.571 Y101.515 E.00526
G1 X88.785 Y101.354 E.00526
G1 X89.131 Y101.168 E.00773
G1 X89.508 Y101.045 E.00779
G1 X89.898 Y100.993 E.00774
G1 X90.165 Y100.997 E.00526
G1 X90.43 Y101.033 E.00526
M73 P34 R22
G1 X90.808 Y101.143 E.00773
G1 X91.159 Y101.319 E.00773
G1 X91.378 Y101.473 E.00526
G1 X91.577 Y101.652 E.00526
G1 X91.825 Y101.953 E.00767
G1 X91.962 Y102.182 E.00525
G1 X92.059 Y102.399 E.00469
G1 X92.175 Y102.805 E.0083
G1 X92.211 Y103.201 E.00781
G1 X92.175 Y103.595 E.00779
G1 X92.071 Y103.975 E.00774
G1 X91.962 Y104.219 E.00525
G1 X91.841 Y104.424 E.00468
G1 X91.576 Y104.752 E.0083
G1 X91.275 Y105.007 E.00775
G1 X91.048 Y105.147 E.00525
G1 X90.832 Y105.248 E.00469
G1 X90.428 Y105.37 E.0083
G1 X90.033 Y105.411 E.00782
G1 X89.638 Y105.382 E.00779
G1 X89.375 Y105.313 E.00535
M204 S10000
G1 X88.911 Y105.592 F18000
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X88.802 Y105.807 E.0051
G1 X88.628 Y105.731 E.00401
G1 X88.303 Y105.527 E.00812
G1 X88.039 Y105.309 E.00726
G1 X87.734 Y104.986 E.0094
G1 X87.488 Y104.606 E.00959
G1 X87.289 Y104.168 E.01018
G1 X87.24 Y103.982 E.00406
G1 X87.484 Y103.916 E.00535
G1 X87.521 Y104.049 E.00292
G1 X87.622 Y104.312 E.00597
G1 X87.879 Y104.742 E.01059
G1 X88.188 Y105.096 E.00995
G1 X88.549 Y105.383 E.00975
G1 X88.859 Y105.562 E.00759
M204 S10000
G1 X89.002 Y105.639 F18000
G1 F1500
M204 S500
G1 X89.57 Y105.787 E.01244
G1 X90.039 Y105.822 E.00995
G1 X90.51 Y105.773 E.01001
G1 X91.071 Y105.603 E.01241
G1 X91.155 Y105.827 E.00504
G1 X90.965 Y105.912 E.0044
G1 X90.595 Y106.018 E.00814
G1 X90.092 Y106.079 E.01073
G1 X89.742 Y106.069 E.00742
G1 X89.401 Y106.017 E.0073
G1 X89.076 Y105.928 E.00713
G1 X88.925 Y105.861 E.00349
G1 X88.982 Y105.696 E.0037
; WIPE_START
M204 S6000
G1 X89.57 Y105.787 E-.11311
G1 X90.039 Y105.822 E-.08929
G1 X90.51 Y105.773 E-.08986
G1 X90.952 Y105.639 E-.08773
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X89.393 Y100.22 Z.84 F18000
G1 Z.44
G1 E.4 F1800
G1 F1500
M204 S500
G1 X89.903 Y99.657 E.01606
G1 X54.243 Y99.657 E.75475
G1 X54.243 Y95.744 E.08282
G1 X121.843 Y95.744 E1.43081
G1 X121.843 Y94.344 E.02963
G1 X125.757 Y94.344 E.08282
G1 X125.757 Y101.057 E.14209
G1 X121.843 Y101.057 E.08282
G1 X121.843 Y99.657 E.02963
G1 X90.085 Y99.657 E.6722
G1 X90.592 Y100.213 E.01593
G1 X90.228 Y100.164 E.00778
G1 X89.848 Y100.158 E.00804
G1 X89.453 Y100.212 E.00843
; WIPE_START
M204 S6000
G1 X89.903 Y99.657 E-.13564
G1 X88.616 Y99.657 E-.24436
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X91.046 Y100.082 Z.84 F18000
G1 Z.44
G1 E.4 F1800
G1 F1500
M204 S500
G1 X92.224 Y101.372 E.03698
G1 X92.348 Y101.532 E.00429
G1 X92.533 Y101.831 E.00745
G1 X92.735 Y102.3 E.01079
G1 X92.827 Y102.648 E.00761
G1 X92.879 Y103.152 E.01074
G1 X92.864 Y103.506 E.00749
G1 X92.767 Y103.997 E.01058
G1 X92.592 Y104.453 E.01034
G1 X92.399 Y104.795 E.00832
G1 X92.083 Y105.189 E.01068
G1 X91.83 Y105.424 E.00733
G1 X91.569 Y105.616 E.00684
G1 X91.248 Y105.784 E.00768
G1 X91.136 Y105.574 E.00505
G1 X91.516 Y105.339 E.00947
G1 X91.87 Y105.039 E.00981
G1 X92.178 Y104.658 E.01038
G1 X92.326 Y104.407 E.00617
G1 X92.454 Y104.122 E.0066
M73 P35 R22
G1 X92.58 Y103.669 E.00996
G1 X92.622 Y103.201 E.00995
G1 X92.579 Y102.73 E.01001
G1 X92.445 Y102.259 E.01038
G1 X92.325 Y101.993 E.00617
G1 X92.16 Y101.717 E.0068
G1 X91.874 Y101.368 E.00956
G1 X91.634 Y101.152 E.00683
G1 X91.37 Y100.966 E.00683
G1 X90.958 Y100.76 E.00975
G1 X90.516 Y100.631 E.00975
G1 X90.196 Y100.588 E.00683
G1 X89.873 Y100.583 E.00683
G1 X89.416 Y100.645 E.00975
G1 X88.97 Y100.79 E.00995
G1 X88.564 Y101.008 E.00975
G1 X88.306 Y101.202 E.00683
G1 X88.072 Y101.425 E.00683
G1 X87.789 Y101.792 E.00981
G1 X87.567 Y102.229 E.01037
G1 X87.474 Y102.505 E.00617
G1 X87.407 Y102.819 E.0068
G1 X87.379 Y103.282 E.00981
G1 X87.454 Y103.861 E.01236
G1 X87.22 Y103.907 E.00505
G1 X87.166 Y103.703 E.00447
G1 X87.123 Y103.322 E.00812
G1 X87.129 Y102.98 E.00724
G1 X87.176 Y102.639 E.00729
G1 X87.263 Y102.305 E.0073
G1 X87.393 Y101.976 E.0075
G1 X87.549 Y101.689 E.00691
G1 X87.753 Y101.4 E.00749
G1 X88.946 Y100.082 E.03763
G1 X53.819 Y100.082 E.74349
G1 X53.819 Y95.32 E.10078
G1 X121.419 Y95.32 E1.43081
G1 X121.419 Y93.92 E.02963
G1 X126.181 Y93.92 E.10078
G1 X126.181 Y101.482 E.16005
G1 X121.419 Y101.482 E.10078
G1 X121.419 Y100.082 E.02963
G1 X91.106 Y100.082 E.6416
M204 S250
G1 X91.974 Y100.491 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X92.538 Y101.109 E.01646
G1 X92.684 Y101.299 E.00472
G1 X92.893 Y101.635 E.00779
G1 X93.126 Y102.176 E.01157
G1 X93.227 Y102.562 E.00785
G1 X93.289 Y103.146 E.01155
G1 X93.272 Y103.542 E.00781
G1 X93.16 Y104.116 E.0115
G1 X92.963 Y104.627 E.01078
G1 X92.745 Y105.013 E.00871
G1 X92.636 Y105.169 E.00373
G1 X92.38 Y105.472 E.00781
G1 X92.091 Y105.74 E.00776
G1 X91.81 Y105.947 E.00686
G1 X91.608 Y106.071 E.00467
G1 X91.107 Y106.297 E.01082
G1 X90.683 Y106.419 E.00866
G1 X90.1 Y106.489 E.01155
G1 X89.705 Y106.477 E.00778
G1 X89.315 Y106.418 E.00775
G1 X88.938 Y106.314 E.0077
G1 X88.436 Y106.094 E.01078
G1 X88.064 Y105.86 E.00865
G1 X87.76 Y105.61 E.00774
G1 X87.367 Y105.174 E.01155
G1 X87.128 Y104.802 E.00869
G1 X86.902 Y104.306 E.01073
G1 X86.763 Y103.779 E.01072
G1 X86.713 Y103.342 E.00865
G1 X86.72 Y102.949 E.00773
G1 X86.774 Y102.559 E.00774
G1 X86.874 Y102.177 E.00775
G1 X87.02 Y101.808 E.00781
G1 X87.204 Y101.467 E.00762
G1 X87.433 Y101.143 E.00781
G1 X88.024 Y100.491 E.01731
G1 X53.41 Y100.491 E.68082
G1 X53.41 Y94.911 E.10975
G1 X121.01 Y94.911 E1.32963
G1 X121.01 Y93.511 E.02754
G1 X126.59 Y93.511 E.10975
G1 X126.59 Y101.891 E.16483
G1 X121.01 Y101.891 E.10975
G1 X121.01 Y100.491 E.02754
G1 X92.034 Y100.491 E.56994
; WIPE_START
M204 S6000
G1 X92.538 Y101.109 E-.1515
G1 X92.684 Y101.299 E-.04562
G1 X92.893 Y101.635 E-.0753
G1 X93.117 Y102.155 E-.10758
; WIPE_END
G1 E-.02 F1800
M204 S10000
G17
G3 Z.84 I1.217 J0 P1  F18000
; stop printing object, unique label id: 12
M625
; object ids of layer 3 start: 8,12
M624 AwAAAAAAAAA=
;===================== date: 20250206 =====================

; don't support timelapse gcode in spiral_mode and by object sequence for I3 structure printer
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
G92 E0
G1 Z0.84
G1 X0 Y85.35 ; move to safe pos
G1 X-13.0 F3000 ; move to safe pos
M400
M1004 S5 P1  ; external shutter
M400 P300
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
; object ids of this layer3 end: 8,12
M625
; start printing object, unique label id: 12
M624 AgAAAAAAAAA=
G1 X91.237 Y100.638
G1 Z.44
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.098757
G1 F1500
M204 S6000
G1 X91.118 Y100.549 E.00054
G1 X90.888 Y100.493 E.00086
; WIPE_START
G1 X91.118 Y100.549 E-.23377
G1 X91.237 Y100.638 E-.14623
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X89.101 Y100.498 Z.84 F18000
G1 Z.44
G1 E.4 F1800
; LINE_WIDTH: 0.0985472
G1 F1500
M204 S6000
G1 X88.869 Y100.551 E.00086
G1 X88.761 Y100.636 E.0005
; WIPE_START
G1 X88.869 Y100.551 E-.13919
G1 X89.101 Y100.498 E-.24081
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X81.496 Y99.852 Z.84 F18000
G1 X56.2 Y97.701 Z.84
G1 Z.44
G1 E.4 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.360652
G1 F1500
M204 S6000
G1 X121.996 Y97.701 E1.09933
; WIPE_START
G1 X119.996 Y97.701 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G17
G3 Z.84 I-.731 J.973 P1  F18000
G1 X122.056 Y99.248 Z.84
G1 Z.44
G1 E.4 F1800
; LINE_WIDTH: 0.419992
G1 F1500
M204 S6000
G1 X122.174 Y99.287 E.00245
G1 X122.253 Y99.445 E.00347
G1 X122.253 Y100.648 E.02366
G1 X125.347 Y100.648 E.06087
G1 X125.347 Y94.753 E.11594
G1 X122.253 Y94.753 E.06087
G1 X122.253 Y95.956 E.02366
G1 X122.174 Y96.114 E.00347
G1 X122.056 Y96.153 E.00245
G1 X54.653 Y96.153 E1.32573
G1 X54.653 Y99.248 E.06087
G1 X121.996 Y99.248 E1.32455
M204 S10000
G1 X122.056 Y98.854 F18000
G1 F1500
M204 S6000
G1 X122.263 Y98.891 E.00415
G1 X122.41 Y98.972 E.0033
G1 X122.548 Y99.118 E.00394
G1 X122.647 Y99.445 E.00673
G1 X122.647 Y100.254 E.01591
G1 X124.953 Y100.254 E.04536
G1 X124.953 Y95.148 E.10043
G1 X122.647 Y95.148 E.04536
G1 X122.647 Y95.956 E.0159
G1 X122.548 Y96.284 E.00673
G1 X122.41 Y96.429 E.00394
G1 X122.263 Y96.51 E.0033
G1 X122.056 Y96.548 E.00415
M73 P36 R22
G1 X55.047 Y96.548 E1.31797
G1 X55.047 Y98.854 E.04536
G1 X121.996 Y98.854 E1.31679
M204 S10000
G1 X122.056 Y98.46 F18000
G1 F1500
M204 S6000
G1 X122.402 Y98.522 E.00692
G1 X122.647 Y98.657 E.0055
G1 X122.876 Y98.9 E.00657
G1 X123.02 Y99.242 E.00731
G1 X123.041 Y99.86 E.01215
G1 X124.559 Y99.86 E.02985
G1 X124.559 Y95.542 E.08492
G1 X123.041 Y95.542 E.02985
G1 X123.02 Y96.159 E.01215
G1 X122.876 Y96.502 E.00731
G1 X122.647 Y96.745 E.00657
G1 X122.402 Y96.879 E.0055
G1 X122.056 Y96.942 E.00692
G1 X55.441 Y96.942 E1.31022
G1 X55.441 Y98.46 E.02985
G1 X121.996 Y98.46 E1.30904
M204 S10000
G1 X122.056 Y98.065 F18000
G1 F1500
M204 S6000
G1 X122.54 Y98.153 E.00968
G1 X122.884 Y98.341 E.0077
G1 X123.205 Y98.681 E.0092
G1 X123.406 Y99.161 E.01023
G1 X123.456 Y99.465 E.00607
G1 X124.165 Y99.465 E.01394
G1 X124.165 Y95.936 E.06941
G1 X123.435 Y95.936 E.01434
G1 X123.406 Y96.241 E.00602
G1 X123.205 Y96.72 E.01023
G1 X122.884 Y97.06 E.0092
G1 X122.54 Y97.248 E.0077
G1 X122.056 Y97.336 E.00968
G1 X55.835 Y97.336 E1.30247
G1 X55.835 Y98.065 E.01434
G1 X121.996 Y98.065 E1.30129
M204 S10000
G1 X122.056 Y97.701 F18000
; LINE_WIDTH: 0.375487
G1 F1500
M204 S6000
G1 X122.367 Y97.742 E.00548
; LINE_WIDTH: 0.419265
G1 X122.679 Y97.784 E.00617
G1 X123.12 Y98.026 E.00988
G1 X123.533 Y98.463 E.01181
G1 X123.77 Y99.029 E.01205
G1 X123.77 Y96.373 E.05215
G1 X123.533 Y96.939 E.01205
G1 X123.12 Y97.376 E.01181
G1 X122.679 Y97.618 E.00988
; LINE_WIDTH: 0.405157
G1 X122.397 Y97.655 E.00538
; LINE_WIDTH: 0.375487
G1 X122.115 Y97.693 E.00496
; WIPE_START
G1 X122.397 Y97.655 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G17
G3 Z.84 I0 J1.217 P1  F18000
G1 X123.39 Y97.655 Z.84
G1 Z.44
G1 E.4 F1800
; LINE_WIDTH: 0.444372
G1 F1500
M204 S6000
G1 X123.338 Y97.655 E.00109
G1 X123.312 Y97.701 E.00109
G1 X123.338 Y97.746 E.00109
G1 X123.382 Y97.746 E.00093
; OBJECT_ID: 8
; WIPE_START
G1 X123.338 Y97.746 E-.08413
G1 X123.312 Y97.701 E-.09862
G1 X123.338 Y97.655 E-.09862
G1 X123.39 Y97.655 E-.09862
; WIPE_END
G1 E-.02 F1800
; stop printing object, unique label id: 12
M625
; start printing object, unique label id: 8
M624 AQAAAAAAAAA=
M204 S10000
G17
G3 Z.84 I.777 J-.936 P1  F18000
G1 X92.017 Y71.606 Z.84
G1 Z.44
M73 P37 R22
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X92.059 Y71.699 E.00202
G1 X92.175 Y72.105 E.0083
G1 X92.211 Y72.501 E.00781
G1 X92.175 Y72.895 E.00779
G1 X92.071 Y73.275 E.00774
G1 X91.962 Y73.519 E.00525
G1 X91.841 Y73.724 E.00468
G1 X91.576 Y74.052 E.0083
G1 X91.275 Y74.307 E.00775
G1 X91.048 Y74.447 E.00525
G1 X90.832 Y74.548 E.00469
G1 X90.428 Y74.67 E.0083
G1 X90.033 Y74.711 E.00782
G1 X89.638 Y74.682 E.00779
G1 X89.257 Y74.583 E.00773
G1 X89.011 Y74.478 E.00526
G1 X88.78 Y74.344 E.00526
G1 X88.472 Y74.099 E.00774
G1 X88.211 Y73.8 E.00779
G1 X88.01 Y73.463 E.00773
G1 X87.908 Y73.216 E.00525
G1 X87.844 Y72.986 E.00468
G1 X87.79 Y72.568 E.0083
G1 X87.814 Y72.174 E.00775
G1 X87.869 Y71.913 E.00525
G1 X87.945 Y71.687 E.00468
G1 X88.136 Y71.311 E.0083
G1 X88.377 Y70.999 E.00775
G1 X88.571 Y70.815 E.00526
G1 X88.785 Y70.654 E.00526
G1 X89.131 Y70.468 E.00773
G1 X89.508 Y70.345 E.00779
G1 X89.898 Y70.293 E.00774
G1 X90.165 Y70.297 E.00526
G1 X90.43 Y70.333 E.00526
G1 X90.808 Y70.443 E.00773
G1 X91.159 Y70.619 E.00773
G1 X91.378 Y70.773 E.00526
G1 X91.577 Y70.952 E.00526
G1 X91.825 Y71.253 E.00767
G1 X91.962 Y71.482 E.00525
G1 X91.993 Y71.551 E.00149
; WIPE_START
M204 S6000
G1 X92.059 Y71.699 E-.03089
G1 X92.175 Y72.105 E-.08017
G1 X92.211 Y72.501 E-.07547
G1 X92.175 Y72.895 E-.07529
G1 X92.071 Y73.275 E-.07473
G1 X91.978 Y73.484 E-.04346
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X88.911 Y74.892 Z.84 F18000
G1 Z.44
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X88.802 Y75.107 E.0051
G1 X88.628 Y75.031 E.00401
G1 X88.303 Y74.827 E.00812
G1 X88.039 Y74.609 E.00726
G1 X87.734 Y74.286 E.0094
G1 X87.488 Y73.906 E.00959
G1 X87.289 Y73.468 E.01018
G1 X87.24 Y73.282 E.00406
G1 X87.484 Y73.216 E.00535
G1 X87.521 Y73.349 E.00292
G1 X87.622 Y73.612 E.00597
G1 X87.879 Y74.042 E.01059
G1 X88.188 Y74.396 E.00995
G1 X88.549 Y74.683 E.00975
G1 X88.859 Y74.862 E.00759
; WIPE_START
M204 S6000
G1 X88.802 Y75.107 E-.04778
G1 X88.628 Y75.031 E-.03603
G1 X88.303 Y74.827 E-.07288
G1 X88.039 Y74.609 E-.06518
G1 X87.734 Y74.286 E-.08441
G1 X87.523 Y73.96 E-.07372
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X91.071 Y74.903 Z.84 F18000
G1 Z.44
G1 E.4 F1800
G1 F1500
M204 S500
G1 X91.155 Y75.127 E.00504
G1 X90.965 Y75.212 E.0044
G1 X90.595 Y75.318 E.00814
G1 X90.092 Y75.379 E.01073
G1 X89.742 Y75.369 E.00742
G1 X89.401 Y75.317 E.0073
G1 X89.076 Y75.228 E.00713
G1 X88.925 Y75.161 E.00349
G1 X89.002 Y74.939 E.00497
G1 X89.57 Y75.087 E.01244
G1 X90.039 Y75.122 E.00995
G1 X90.51 Y75.073 E.01001
G1 X91.013 Y74.921 E.01114
; WIPE_START
M204 S6000
G1 X91.155 Y75.127 E-.04741
G1 X90.965 Y75.212 E-.03948
G1 X90.595 Y75.318 E-.0731
G1 X90.092 Y75.379 E-.09633
G1 X89.742 Y75.369 E-.06659
G1 X89.445 Y75.324 E-.05708
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X96.917 Y73.771 Z.84 F18000
G1 X121.257 Y68.711 Z.84
G1 Z.44
G1 E.4 F1800
G1 F1500
M204 S500
G1 X121.257 Y68.957 E.00522
G1 X90.085 Y68.957 E.65978
G1 X90.592 Y69.513 E.01593
G1 X90.228 Y69.464 E.00778
G1 X89.848 Y69.458 E.00804
G1 X89.393 Y69.52 E.0097
G1 X89.903 Y68.957 E.01606
G1 X54.243 Y68.957 E.75475
G1 X54.243 Y65.044 E.08282
G1 X121.257 Y65.044 E1.41839
G1 X121.257 Y68.651 E.07633
; WIPE_START
M204 S6000
G1 X121.257 Y68.957 E-.05824
G1 X119.563 Y68.957 E-.32176
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X125.51 Y69.12 Z.84 F18000
G1 Z.44
G1 E.4 F1800
G1 F1500
M204 S500
G1 X121.681 Y69.12 E.08105
G1 X121.681 Y64.882 E.08971
G1 X125.919 Y64.882 E.08971
G1 X125.919 Y69.12 E.08971
G1 X125.57 Y69.12 E.00739
M204 S250
G1 X125.51 Y68.711 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X122.09 Y68.711 E.06727
G1 X122.09 Y65.291 E.06727
G1 X125.51 Y65.291 E.06727
G1 X125.51 Y68.651 E.06609
; WIPE_START
M204 S6000
G1 X123.51 Y68.686 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X115.879 Y68.839 Z.84 F18000
G1 X88.946 Y69.382 Z.84
M73 P37 R21
G1 Z.44
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X53.819 Y69.382 E.74349
G1 X53.819 Y64.62 E.10078
G1 X126.181 Y64.62 E1.53159
G1 X126.181 Y69.382 E.10078
G1 X91.046 Y69.382 E.74366
G1 X92.224 Y70.672 E.03698
G1 X92.348 Y70.832 E.00429
G1 X92.533 Y71.131 E.00745
G1 X92.735 Y71.6 E.01079
G1 X92.827 Y71.948 E.00761
G1 X92.879 Y72.452 E.01074
G1 X92.864 Y72.806 E.00749
G1 X92.767 Y73.297 E.01058
G1 X92.592 Y73.753 E.01034
G1 X92.399 Y74.095 E.00832
G1 X92.083 Y74.489 E.01068
G1 X91.83 Y74.724 E.00733
G1 X91.569 Y74.916 E.00684
G1 X91.248 Y75.084 E.00768
G1 X91.136 Y74.874 E.00505
G1 X91.516 Y74.639 E.00947
G1 X91.87 Y74.339 E.00981
G1 X92.178 Y73.958 E.01038
G1 X92.326 Y73.707 E.00617
G1 X92.454 Y73.422 E.0066
G1 X92.58 Y72.969 E.00996
G1 X92.622 Y72.501 E.00995
G1 X92.579 Y72.03 E.01
G1 X92.445 Y71.559 E.01038
G1 X92.325 Y71.293 E.00617
G1 X92.16 Y71.017 E.0068
G1 X91.874 Y70.668 E.00956
G1 X91.634 Y70.452 E.00683
G1 X91.37 Y70.266 E.00683
G1 X90.958 Y70.06 E.00975
G1 X90.516 Y69.931 E.00975
G1 X90.196 Y69.888 E.00683
G1 X89.873 Y69.883 E.00683
G1 X89.416 Y69.945 E.00975
G1 X88.97 Y70.09 E.00995
G1 X88.564 Y70.308 E.00975
G1 X88.306 Y70.502 E.00683
G1 X88.073 Y70.725 E.00683
G1 X87.789 Y71.092 E.00981
G1 X87.567 Y71.529 E.01037
G1 X87.474 Y71.805 E.00617
G1 X87.407 Y72.119 E.0068
G1 X87.379 Y72.582 E.00981
G1 X87.454 Y73.161 E.01236
G1 X87.22 Y73.207 E.00505
G1 X87.166 Y73.003 E.00447
G1 X87.123 Y72.622 E.00812
G1 X87.129 Y72.28 E.00724
G1 X87.176 Y71.939 E.00729
G1 X87.263 Y71.605 E.0073
G1 X87.393 Y71.276 E.0075
G1 X87.549 Y70.989 E.00691
G1 X87.753 Y70.699 E.0075
G1 X88.906 Y69.426 E.03636
M204 S250
G1 X88.024 Y69.791 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
M73 P38 R21
G1 F1500
M204 S500
G1 X53.41 Y69.791 E.68082
G1 X53.41 Y64.211 E.10975
G1 X126.59 Y64.211 E1.43939
G1 X126.59 Y69.791 E.10975
G1 X91.974 Y69.791 E.68087
G1 X92.538 Y70.409 E.01646
G1 X92.684 Y70.599 E.00472
G1 X92.893 Y70.935 E.00779
G1 X93.126 Y71.476 E.01157
G1 X93.227 Y71.862 E.00785
G1 X93.289 Y72.446 E.01155
G1 X93.272 Y72.842 E.00781
G1 X93.16 Y73.416 E.0115
G1 X92.963 Y73.927 E.01078
G1 X92.745 Y74.313 E.00871
G1 X92.636 Y74.469 E.00373
G1 X92.38 Y74.772 E.00781
G1 X92.091 Y75.04 E.00776
G1 X91.81 Y75.247 E.00686
G1 X91.608 Y75.371 E.00467
G1 X91.107 Y75.597 E.01082
G1 X90.683 Y75.719 E.00866
G1 X90.1 Y75.789 E.01155
G1 X89.705 Y75.777 E.00778
G1 X89.315 Y75.718 E.00775
G1 X88.938 Y75.614 E.0077
G1 X88.436 Y75.394 E.01078
G1 X88.064 Y75.16 E.00865
G1 X87.76 Y74.91 E.00774
G1 X87.367 Y74.474 E.01155
G1 X87.128 Y74.102 E.00869
G1 X86.902 Y73.606 E.01073
G1 X86.763 Y73.079 E.01072
G1 X86.713 Y72.642 E.00865
G1 X86.72 Y72.249 E.00773
G1 X86.774 Y71.859 E.00774
G1 X86.874 Y71.477 E.00775
G1 X87.02 Y71.108 E.00781
G1 X87.204 Y70.767 E.00762
G1 X87.433 Y70.443 E.00781
G1 X87.984 Y69.835 E.01613
M204 S10000
G1 X88.761 Y69.936 F18000
; FEATURE: Gap infill
; LINE_WIDTH: 0.0985338
G1 F1500
M204 S6000
G1 X88.869 Y69.851 E.0005
G1 X89.101 Y69.798 E.00086
; WIPE_START
G1 X88.869 Y69.851 E-.24079
G1 X88.761 Y69.936 E-.13921
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X90.887 Y69.793 Z.84 F18000
G1 Z.44
G1 E.4 F1800
; LINE_WIDTH: 0.0987942
G1 F1500
M204 S6000
G1 X91.118 Y69.848 E.00087
G1 X91.237 Y69.938 E.00054
; WIPE_START
G1 X91.118 Y69.848 E-.14616
G1 X90.887 Y69.793 E-.23384
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X83.28 Y69.18 Z.84 F18000
G1 X56.2 Y67.001 Z.84
G1 Z.44
G1 E.4 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.360632
G1 F1500
M204 S6000
G1 X119.24 Y67.001 E1.05322
M204 S10000
G1 X119.665 Y67.365 F18000
; LINE_WIDTH: 0.419992
G1 F1500
M204 S6000
G1 X119.665 Y66.636 E.01434
G1 X55.835 Y66.636 E1.25544
G1 X55.835 Y67.365 E.01434
G1 X119.605 Y67.365 E1.25426
M204 S10000
G1 X120.059 Y67.76 F18000
G1 F1500
M204 S6000
G1 X120.059 Y66.242 E.02985
G1 X55.441 Y66.242 E1.27095
G1 X55.441 Y67.76 E.02985
G1 X119.999 Y67.76 E1.26977
M204 S10000
G1 X120.453 Y68.154 F18000
G1 F1500
M204 S6000
G1 X120.453 Y65.848 E.04536
G1 X55.047 Y65.848 E1.28645
G1 X55.047 Y68.154 E.04536
G1 X120.393 Y68.154 E1.28527
M204 S10000
G1 X120.847 Y68.548 F18000
G1 F1500
M204 S6000
G1 X120.847 Y65.453 E.06087
G1 X54.653 Y65.453 E1.30196
G1 X54.653 Y68.548 E.06087
G1 X120.787 Y68.548 E1.30078
; CHANGE_LAYER
; Z_HEIGHT: 0.56
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F1500
G1 X118.787 Y68.548 E-.38
; WIPE_END
G1 E-.02 F1800
; stop printing object, unique label id: 8
M625
; layer num/total_layer_count: 4/51
; update layer progress
M73 L4
M991 S0 P3 ;notify layer change
; OBJECT_ID: 12
; start printing object, unique label id: 12
M624 AgAAAAAAAAA=
M204 S10000
G17
G3 Z.84 I-.892 J-.828 P1  F18000
G1 X89.405 Y100.207 Z.84
G1 Z.56
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X89.903 Y99.657 E.01568
G1 X54.243 Y99.657 E.75475
G1 X54.243 Y95.744 E.08282
G1 X121.843 Y95.744 E1.43081
G1 X121.843 Y94.344 E.02963
G1 X125.757 Y94.344 E.08282
G1 X125.757 Y101.057 E.14209
G1 X121.843 Y101.057 E.08282
G1 X121.843 Y99.657 E.02963
G1 X89.999 Y99.657 E.67402
G1 X90.506 Y100.185 E.01549
G1 X89.879 Y100.157 E.01329
G1 X89.465 Y100.2 E.00881
; WIPE_START
M204 S6000
G1 X89.903 Y99.657 E-.13251
M73 P39 R21
G1 X88.6 Y99.657 E-.24749
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X89.173 Y105.683 Z.96 F18000
G1 Z.56
G1 E.4 F1800
G1 F1500
M204 S500
G1 X88.961 Y105.607 E.00477
G1 X88.556 Y105.389 E.00975
G1 X88.188 Y105.096 E.00995
G1 X87.879 Y104.742 E.00995
G1 X87.638 Y104.338 E.00995
G1 X87.476 Y103.906 E.00978
G1 X87.409 Y103.591 E.0068
G1 X87.38 Y103.27 E.00683
G1 X87.409 Y102.788 E.01023
G1 X87.474 Y102.505 E.00613
G1 X87.563 Y102.238 E.00596
G1 X87.788 Y101.792 E.01057
G1 X88.078 Y101.418 E.01002
G1 X88.427 Y101.103 E.00995
G1 X88.827 Y100.856 E.00995
G1 X89.256 Y100.688 E.00975
G1 X89.571 Y100.616 E.00683
G1 X89.892 Y100.582 E.00683
G1 X90.343 Y100.602 E.00955
G1 X90.659 Y100.665 E.00683
G1 X90.966 Y100.764 E.00683
G1 X91.37 Y100.966 E.00955
G1 X91.634 Y101.152 E.00683
G1 X91.867 Y101.362 E.00663
G1 X92.072 Y101.597 E.0066
G1 X92.232 Y101.829 E.00596
G1 X92.454 Y102.276 E.01057
G1 X92.58 Y102.733 E.01002
G1 X92.622 Y103.201 E.00995
G1 X92.58 Y103.669 E.00995
G1 X92.457 Y104.113 E.00975
G1 X92.326 Y104.408 E.00683
G1 X92.16 Y104.685 E.00683
G1 X91.868 Y105.041 E.00975
G1 X91.516 Y105.339 E.00975
G1 X91.243 Y105.507 E.0068
G1 X90.988 Y105.627 E.00597
G1 X90.51 Y105.773 E.01057
G1 X90.039 Y105.822 E.01003
G1 X89.58 Y105.788 E.00975
G1 X89.265 Y105.716 E.00683
G1 X89.23 Y105.703 E.00079
M204 S250
G1 X89.311 Y105.298 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X89.128 Y105.232 E.00383
G1 X88.782 Y105.046 E.00773
G1 X88.472 Y104.799 E.0078
G1 X88.211 Y104.5 E.0078
G1 X88.008 Y104.16 E.0078
G1 X87.87 Y103.792 E.00773
G1 X87.814 Y103.53 E.00526
G1 X87.79 Y103.264 E.00526
G1 X87.814 Y102.874 E.00767
G1 X87.869 Y102.613 E.00525
G1 X87.942 Y102.396 E.0045
G1 X88.136 Y102.012 E.00847
G1 X88.379 Y101.697 E.00782
G1 X88.674 Y101.432 E.00779
G1 X89.011 Y101.223 E.0078
G1 X89.377 Y101.08 E.00774
G1 X89.638 Y101.02 E.00526
G1 X89.904 Y100.992 E.00526
G1 X90.294 Y101.01 E.00767
G1 X90.556 Y101.062 E.00527
G1 X90.811 Y101.144 E.00526
G1 X91.159 Y101.319 E.00767
G1 X91.378 Y101.473 E.00526
G1 X91.575 Y101.65 E.0052
G1 X91.748 Y101.848 E.00519
G1 X91.878 Y102.037 E.0045
G1 X92.07 Y102.423 E.00848
G1 X92.175 Y102.806 E.00782
G1 X92.211 Y103.201 E.00779
G1 X92.175 Y103.595 E.00779
G1 X92.071 Y103.975 E.00774
G1 X91.962 Y104.219 E.00526
G1 X91.825 Y104.449 E.00526
G1 X91.575 Y104.752 E.00773
G1 X91.275 Y105.007 E.00773
G1 X91.048 Y105.147 E.00525
G1 X90.841 Y105.244 E.0045
G1 X90.429 Y105.37 E.00847
G1 X90.033 Y105.411 E.00782
G1 X89.641 Y105.382 E.00773
G1 X89.38 Y105.322 E.00526
G1 X89.368 Y105.318 E.00026
; WIPE_START
M204 S6000
G1 X89.128 Y105.232 E-.04835
G1 X88.782 Y105.046 E-.07472
G1 X88.472 Y104.799 E-.07532
G1 X88.211 Y104.5 E-.0753
G1 X88.008 Y104.16 E-.07531
G1 X87.951 Y104.007 E-.031
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X90.995 Y100.082 Z.96 F18000
G1 Z.56
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X92.129 Y101.261 E.03463
G1 X92.351 Y101.537 E.00749
G1 X92.529 Y101.824 E.00715
G1 X92.719 Y102.258 E.01002
G1 X92.826 Y102.647 E.00854
G1 X92.859 Y102.858 E.00453
G1 X92.879 Y103.151 E.0062
G1 X92.864 Y103.497 E.00734
G1 X92.807 Y103.846 E.0075
G1 X92.77 Y103.989 E.0031
G1 X92.598 Y104.44 E.01022
G1 X92.403 Y104.787 E.00844
G1 X92.095 Y105.177 E.01052
G1 X91.734 Y105.498 E.01022
G1 X91.393 Y105.722 E.00863
G1 X90.932 Y105.926 E.01067
G1 X90.598 Y106.018 E.00733
G1 X90.308 Y106.063 E.0062
G1 X90.091 Y106.079 E.00461
G1 X89.742 Y106.069 E.0074
G1 X89.404 Y106.018 E.00722
G1 X89.021 Y105.907 E.00844
G1 X88.59 Y105.711 E.01002
G1 X88.312 Y105.533 E.007
G1 X87.953 Y105.224 E.01002
G1 X87.691 Y104.921 E.00847
G1 X87.425 Y104.49 E.01073
G1 X87.291 Y104.175 E.00725
G1 X87.169 Y103.717 E.01002
G1 X87.124 Y103.325 E.00835
G1 X87.135 Y102.93 E.00836
G1 X87.217 Y102.462 E.01006
G1 X87.388 Y101.989 E.01065
G1 X87.554 Y101.681 E.0074
G1 X87.753 Y101.4 E.0073
G1 X88.946 Y100.082 E.03763
G1 X53.819 Y100.082 E.74349
G1 X53.819 Y95.32 E.10078
G1 X121.419 Y95.32 E1.43081
G1 X121.419 Y93.92 E.02963
G1 X126.181 Y93.92 E.10078
G1 X126.181 Y101.482 E.16005
G1 X121.419 Y101.482 E.10078
G1 X121.419 Y100.082 E.02963
G1 X91.055 Y100.082 E.64268
M204 S250
G1 X91.956 Y100.491 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X92.437 Y100.991 E.01364
G1 X92.685 Y101.3 E.00781
G1 X92.892 Y101.633 E.0077
G1 X93.106 Y102.121 E.01047
G1 X93.227 Y102.561 E.00899
G1 X93.289 Y103.145 E.01154
G1 X93.272 Y103.539 E.00776
G1 X93.161 Y104.113 E.0115
G1 X92.969 Y104.614 E.01054
G1 X92.747 Y105.011 E.00896
G1 X92.384 Y105.468 E.01148
G1 X91.983 Y105.824 E.01053
G1 X91.6 Y106.075 E.00902
G1 X91.064 Y106.313 E.01153
G1 X90.684 Y106.419 E.00776
G1 X90.355 Y106.47 E.00655
G1 X90.1 Y106.489 E.00503
G1 X89.705 Y106.477 E.00778
G1 X89.317 Y106.419 E.00773
G1 X88.879 Y106.292 E.00896
G1 X88.394 Y106.072 E.01047
G1 X88.066 Y105.862 E.00766
G1 X87.663 Y105.514 E.01047
G1 X87.365 Y105.17 E.00897
M73 P40 R21
G1 X87.057 Y104.67 E.01155
G1 X86.903 Y104.308 E.00774
M73 P40 R20
G1 X86.766 Y103.794 E.01047
G1 X86.714 Y103.343 E.00893
G1 X86.727 Y102.889 E.00893
G1 X86.819 Y102.364 E.01048
G1 X87.018 Y101.813 E.01152
G1 X87.206 Y101.465 E.00778
G1 X87.433 Y101.143 E.00775
G1 X88.024 Y100.491 E.01731
G1 X53.41 Y100.491 E.68082
G1 X53.41 Y94.911 E.10975
G1 X121.01 Y94.911 E1.32963
G1 X121.01 Y93.511 E.02754
G1 X126.59 Y93.511 E.10975
G1 X126.59 Y101.891 E.16483
G1 X121.01 Y101.891 E.10975
G1 X121.01 Y100.491 E.02754
G1 X92.016 Y100.491 E.57028
; WIPE_START
M204 S6000
G1 X92.437 Y100.991 E-.12412
G1 X92.685 Y101.3 E-.07542
G1 X92.892 Y101.633 E-.07442
G1 X93.106 Y102.121 E-.10118
G1 X93.112 Y102.145 E-.00487
; WIPE_END
G1 E-.02 F1800
M204 S10000
G17
G3 Z.96 I1.217 J0 P1  F18000
; stop printing object, unique label id: 12
M625
; object ids of layer 4 start: 8,12
M624 AwAAAAAAAAA=
;===================== date: 20250206 =====================

; don't support timelapse gcode in spiral_mode and by object sequence for I3 structure printer
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
G92 E0
G1 Z0.96
G1 X0 Y85.35 ; move to safe pos
G1 X-13.0 F3000 ; move to safe pos
M400
M1004 S5 P1  ; external shutter
M400 P300
M971 S11 C11 O0
G92 E0
G1 X0 F18000
M623

; SKIPTYPE: head_wrap_detect
M622.1 S1
M1002 judge_flag g39_3rd_layer_detect_flag
M622 J1
    ; enable nozzle clog detect at 3rd layer
    


    M622.1 S1
    M1002 judge_flag g39_detection_flag
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




; object ids of this layer4 end: 8,12
M625
; start printing object, unique label id: 12
M624 AgAAAAAAAAA=
G1 X91.174 Y100.606
G1 Z.56
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.109549
G1 F1500
M204 S6000
G1 X90.902 Y100.415 E.00139
M204 S10000
G1 X90.697 Y100.429 F18000
; LINE_WIDTH: 0.0985029
G1 F1500
M204 S6000
G1 X90.902 Y100.467 E.00076
; LINE_WIDTH: 0.136004
G1 X91.107 Y100.504 E.00115
; WIPE_START
G1 X90.902 Y100.467 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X89.171 Y100.468 Z.96 F18000
G1 Z.56
G1 E.4 F1800
; LINE_WIDTH: 0.0963
G1 F1500
M204 S6000
G1 X88.986 Y100.513 E.00067
; LINE_WIDTH: 0.129416
G1 X88.801 Y100.558 E.00098
; WIPE_START
G1 X88.986 Y100.513 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X81.381 Y99.861 Z.96 F18000
G1 X56.2 Y97.701 Z.96
G1 Z.56
G1 E.4 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.360652
G1 F1500
M204 S6000
G1 X121.996 Y97.701 E1.09933
; WIPE_START
G1 X119.996 Y97.701 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G17
G3 Z.96 I-.731 J.973 P1  F18000
G1 X122.056 Y99.248 Z.96
G1 Z.56
G1 E.4 F1800
; LINE_WIDTH: 0.419992
G1 F1500
M204 S6000
G1 X122.174 Y99.287 E.00245
G1 X122.253 Y99.445 E.00347
G1 X122.253 Y100.648 E.02366
G1 X125.347 Y100.648 E.06087
G1 X125.347 Y94.753 E.11594
G1 X122.253 Y94.753 E.06087
G1 X122.253 Y95.956 E.02366
G1 X122.174 Y96.114 E.00347
G1 X122.056 Y96.153 E.00245
G1 X54.653 Y96.153 E1.32573
G1 X54.653 Y99.248 E.06087
G1 X121.996 Y99.248 E1.32455
M204 S10000
G1 X122.056 Y98.854 F18000
G1 F1500
M204 S6000
G1 X122.263 Y98.891 E.00415
G1 X122.41 Y98.972 E.0033
G1 X122.548 Y99.118 E.00394
G1 X122.647 Y99.445 E.00673
G1 X122.647 Y100.254 E.01591
G1 X124.953 Y100.254 E.04536
G1 X124.953 Y95.148 E.10043
G1 X122.647 Y95.148 E.04536
G1 X122.647 Y95.956 E.0159
G1 X122.548 Y96.284 E.00673
G1 X122.41 Y96.429 E.00394
G1 X122.263 Y96.51 E.0033
G1 X122.056 Y96.548 E.00415
G1 X55.047 Y96.548 E1.31797
G1 X55.047 Y98.854 E.04536
G1 X121.996 Y98.854 E1.31679
M204 S10000
G1 X122.056 Y98.46 F18000
G1 F1500
M204 S6000
G1 X122.402 Y98.522 E.00692
G1 X122.647 Y98.657 E.0055
G1 X122.876 Y98.9 E.00657
G1 X123.02 Y99.242 E.00731
G1 X123.041 Y99.86 E.01215
G1 X124.559 Y99.86 E.02985
G1 X124.559 Y95.542 E.08492
G1 X123.041 Y95.542 E.02985
G1 X123.02 Y96.159 E.01215
G1 X122.876 Y96.502 E.00731
G1 X122.647 Y96.745 E.00657
G1 X122.402 Y96.879 E.0055
G1 X122.056 Y96.942 E.00692
G1 X55.441 Y96.942 E1.31022
M73 P41 R20
G1 X55.441 Y98.46 E.02985
G1 X121.996 Y98.46 E1.30904
M204 S10000
G1 X122.056 Y98.065 F18000
G1 F1500
M204 S6000
G1 X122.54 Y98.153 E.00968
G1 X122.884 Y98.341 E.0077
G1 X123.205 Y98.681 E.0092
G1 X123.406 Y99.161 E.01023
G1 X123.456 Y99.465 E.00607
G1 X124.165 Y99.465 E.01394
G1 X124.165 Y95.936 E.06941
G1 X123.435 Y95.936 E.01434
G1 X123.406 Y96.241 E.00602
G1 X123.205 Y96.72 E.01023
G1 X122.884 Y97.06 E.0092
G1 X122.54 Y97.248 E.0077
G1 X122.056 Y97.336 E.00968
G1 X55.835 Y97.336 E1.30247
G1 X55.835 Y98.065 E.01434
G1 X121.996 Y98.065 E1.30129
M204 S10000
G1 X122.056 Y97.701 F18000
; LINE_WIDTH: 0.375487
G1 F1500
M204 S6000
G1 X122.367 Y97.742 E.00548
; LINE_WIDTH: 0.419265
G1 X122.679 Y97.784 E.00617
G1 X123.12 Y98.026 E.00988
G1 X123.533 Y98.463 E.01181
G1 X123.77 Y99.029 E.01205
G1 X123.77 Y96.373 E.05215
G1 X123.533 Y96.939 E.01205
G1 X123.12 Y97.376 E.01181
G1 X122.679 Y97.618 E.00988
; LINE_WIDTH: 0.405157
G1 X122.397 Y97.655 E.00538
; LINE_WIDTH: 0.375487
G1 X122.115 Y97.693 E.00496
; WIPE_START
G1 X122.397 Y97.655 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G17
G3 Z.96 I0 J1.217 P1  F18000
G1 X123.39 Y97.655 Z.96
G1 Z.56
G1 E.4 F1800
; LINE_WIDTH: 0.444372
G1 F1500
M204 S6000
G1 X123.338 Y97.655 E.00109
G1 X123.312 Y97.701 E.00109
G1 X123.338 Y97.746 E.00109
G1 X123.382 Y97.746 E.00093
; OBJECT_ID: 8
; WIPE_START
G1 X123.338 Y97.746 E-.08413
G1 X123.312 Y97.701 E-.09862
G1 X123.338 Y97.655 E-.09862
G1 X123.39 Y97.655 E-.09862
; WIPE_END
G1 E-.02 F1800
; stop printing object, unique label id: 12
M625
; start printing object, unique label id: 8
M624 AQAAAAAAAAA=
M204 S10000
G17
G3 Z.96 I.777 J-.936 P1  F18000
G1 X92.014 Y71.61 Z.96
G1 Z.56
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X92.07 Y71.723 E.00247
G1 X92.175 Y72.106 E.00782
M73 P42 R20
G1 X92.211 Y72.501 E.00779
G1 X92.175 Y72.895 E.00779
G1 X92.071 Y73.275 E.00774
G1 X91.962 Y73.519 E.00526
G1 X91.825 Y73.749 E.00526
G1 X91.575 Y74.052 E.00773
G1 X91.275 Y74.307 E.00773
G1 X91.048 Y74.447 E.00525
G1 X90.841 Y74.544 E.0045
G1 X90.429 Y74.67 E.00847
G1 X90.033 Y74.711 E.00782
G1 X89.641 Y74.682 E.00773
G1 X89.38 Y74.622 E.00526
G1 X89.128 Y74.532 E.00526
G1 X88.782 Y74.346 E.00773
G1 X88.472 Y74.099 E.0078
G1 X88.211 Y73.8 E.0078
G1 X88.008 Y73.46 E.0078
G1 X87.87 Y73.092 E.00773
G1 X87.814 Y72.83 E.00526
G1 X87.79 Y72.564 E.00526
G1 X87.814 Y72.174 E.00767
G1 X87.869 Y71.913 E.00525
G1 X87.942 Y71.696 E.0045
G1 X88.136 Y71.312 E.00847
G1 X88.379 Y70.997 E.00782
G1 X88.674 Y70.732 E.00779
G1 X89.011 Y70.523 E.0078
G1 X89.377 Y70.38 E.00774
G1 X89.638 Y70.32 E.00526
G1 X89.904 Y70.292 E.00526
G1 X90.294 Y70.31 E.00767
G1 X90.556 Y70.362 E.00527
G1 X90.811 Y70.444 E.00526
G1 X91.159 Y70.619 E.00767
G1 X91.378 Y70.773 E.00526
G1 X91.575 Y70.95 E.0052
G1 X91.748 Y71.148 E.00519
G1 X91.878 Y71.337 E.0045
G1 X91.987 Y71.556 E.00482
; WIPE_START
M204 S6000
G1 X92.07 Y71.723 E-.03529
G1 X92.175 Y72.106 E-.07555
G1 X92.211 Y72.501 E-.07529
G1 X92.175 Y72.895 E-.07529
G1 X92.071 Y73.275 E-.07473
G1 X91.977 Y73.485 E-.04385
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X99.51 Y72.257 Z.96 F18000
G1 X121.257 Y68.711 Z.96
G1 Z.56
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X121.257 Y68.957 E.00522
G1 X89.999 Y68.957 E.66159
G1 X90.506 Y69.485 E.01549
G1 X89.879 Y69.457 E.01329
G1 X89.405 Y69.507 E.01008
G1 X89.903 Y68.957 E.01568
G1 X54.243 Y68.957 E.75475
G1 X54.243 Y65.044 E.08282
G1 X121.257 Y65.044 E1.41839
G1 X121.257 Y68.651 E.07633
; WIPE_START
M204 S6000
G1 X121.257 Y68.957 E-.05824
G1 X119.563 Y68.957 E-.32176
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X125.51 Y69.12 Z.96 F18000
G1 Z.56
G1 E.4 F1800
G1 F1500
M204 S500
G1 X121.681 Y69.12 E.08105
G1 X121.681 Y64.882 E.08971
G1 X125.919 Y64.882 E.08971
G1 X125.919 Y69.12 E.08971
G1 X125.57 Y69.12 E.00739
M204 S250
G1 X125.51 Y68.711 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X122.09 Y68.711 E.06727
G1 X122.09 Y65.291 E.06727
G1 X125.51 Y65.291 E.06727
G1 X125.51 Y68.651 E.06609
; WIPE_START
M204 S6000
G1 X123.51 Y68.686 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X115.879 Y68.839 Z.96 F18000
G1 X88.946 Y69.382 Z.96
G1 Z.56
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X53.819 Y69.382 E.74349
G1 X53.819 Y64.62 E.10078
G1 X126.181 Y64.62 E1.53159
G1 X126.181 Y69.382 E.10078
G1 X90.995 Y69.382 E.74473
G1 X92.129 Y70.561 E.03463
G1 X92.351 Y70.837 E.00749
G1 X92.529 Y71.124 E.00715
G1 X92.719 Y71.558 E.01002
G1 X92.826 Y71.947 E.00854
G1 X92.859 Y72.158 E.00453
G1 X92.879 Y72.451 E.0062
G1 X92.864 Y72.797 E.00734
G1 X92.807 Y73.146 E.0075
G1 X92.77 Y73.289 E.0031
G1 X92.598 Y73.74 E.01022
G1 X92.403 Y74.087 E.00844
G1 X92.193 Y74.368 E.00741
G1 X92.095 Y74.477 E.00311
G1 X91.734 Y74.798 E.01022
G1 X91.406 Y75.013 E.00829
G1 X91.233 Y75.092 E.00403
G1 X91.127 Y74.862 E.00535
G1 X91.516 Y74.639 E.0095
G1 X91.868 Y74.341 E.00975
G1 X92.16 Y73.985 E.00975
G1 X92.326 Y73.708 E.00683
G1 X92.457 Y73.413 E.00683
G1 X92.58 Y72.969 E.00975
G1 X92.622 Y72.501 E.00995
G1 X92.58 Y72.033 E.00995
G1 X92.454 Y71.576 E.01002
G1 X92.232 Y71.129 E.01057
G1 X92.072 Y70.897 E.00596
G1 X91.867 Y70.662 E.0066
G1 X91.634 Y70.452 E.00663
G1 X91.37 Y70.266 E.00683
G1 X90.966 Y70.064 E.00955
G1 X90.659 Y69.965 E.00683
G1 X90.343 Y69.902 E.00683
G1 X89.892 Y69.882 E.00955
G1 X89.571 Y69.916 E.00683
G1 X89.256 Y69.988 E.00683
G1 X88.827 Y70.156 E.00975
G1 X88.427 Y70.403 E.00995
G1 X88.078 Y70.718 E.00995
G1 X87.788 Y71.092 E.01002
G1 X87.563 Y71.538 E.01057
G1 X87.474 Y71.805 E.00596
G1 X87.409 Y72.088 E.00613
G1 X87.38 Y72.57 E.01023
G1 X87.409 Y72.891 E.00683
G1 X87.476 Y73.206 E.0068
G1 X87.638 Y73.638 E.00978
G1 X87.879 Y74.042 E.00995
G1 X88.188 Y74.396 E.00995
G1 X88.556 Y74.689 E.00995
G1 X88.961 Y74.907 E.00975
G1 X89.265 Y75.016 E.00683
G1 X89.58 Y75.088 E.00683
G1 X90.039 Y75.122 E.00975
G1 X90.51 Y75.073 E.01003
G1 X91.083 Y74.898 E.01268
G1 X91.168 Y75.121 E.00505
G1 X90.979 Y75.207 E.00439
G1 X90.594 Y75.318 E.00847
G1 X90.091 Y75.379 E.01072
G1 X89.742 Y75.369 E.0074
G1 X89.404 Y75.318 E.00722
G1 X89.021 Y75.207 E.00844
G1 X88.59 Y75.011 E.01002
G1 X88.312 Y74.833 E.007
G1 X87.953 Y74.524 E.01002
G1 X87.691 Y74.221 E.00847
G1 X87.425 Y73.79 E.01072
G1 X87.291 Y73.475 E.00725
G1 X87.169 Y73.017 E.01002
G1 X87.124 Y72.625 E.00835
G1 X87.135 Y72.23 E.00836
G1 X87.217 Y71.762 E.01006
G1 X87.388 Y71.289 E.01065
G1 X87.554 Y70.981 E.0074
G1 X87.753 Y70.7 E.0073
G1 X88.906 Y69.426 E.03636
M204 S250
G1 X88.024 Y69.791 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X53.41 Y69.791 E.68082
G1 X53.41 Y64.211 E.10975
G1 X126.59 Y64.211 E1.43939
G1 X126.59 Y69.791 E.10975
G1 X91.956 Y69.791 E.68121
G1 X92.437 Y70.291 E.01364
G1 X92.685 Y70.6 E.00781
G1 X92.892 Y70.933 E.0077
G1 X93.106 Y71.421 E.01047
G1 X93.227 Y71.861 E.00899
G1 X93.289 Y72.445 E.01154
G1 X93.272 Y72.839 E.00776
G1 X93.161 Y73.413 E.0115
G1 X92.969 Y73.914 E.01054
G1 X92.747 Y74.311 E.00896
G1 X92.384 Y74.768 E.01148
G1 X91.983 Y75.124 E.01053
G1 X91.605 Y75.372 E.00891
G1 X91.121 Y75.592 E.01045
G1 X90.683 Y75.719 E.00897
G1 X90.1 Y75.789 E.01154
G1 X89.705 Y75.777 E.00778
G1 X89.317 Y75.719 E.00773
G1 X88.879 Y75.592 E.00896
G1 X88.394 Y75.372 E.01047
G1 X88.066 Y75.162 E.00766
G1 X87.663 Y74.814 E.01047
G1 X87.365 Y74.47 E.00897
G1 X87.057 Y73.97 E.01154
G1 X86.903 Y73.608 E.00774
G1 X86.766 Y73.094 E.01047
G1 X86.714 Y72.643 E.00893
G1 X86.727 Y72.189 E.00893
G1 X86.819 Y71.664 E.01048
G1 X87.018 Y71.113 E.01152
G1 X87.206 Y70.765 E.00778
G1 X87.433 Y70.443 E.00775
G1 X87.984 Y69.835 E.01613
M204 S10000
G1 X88.801 Y69.858 F18000
; FEATURE: Gap infill
; LINE_WIDTH: 0.129416
M73 P43 R19
G1 F1500
M204 S6000
G1 X88.986 Y69.813 E.00098
; LINE_WIDTH: 0.0963
G1 X89.171 Y69.768 E.00067
; WIPE_START
G1 X88.986 Y69.813 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X90.697 Y69.729 Z.96 F18000
G1 Z.56
G1 E.4 F1800
; LINE_WIDTH: 0.0985029
G1 F1500
M204 S6000
G1 X90.902 Y69.767 E.00076
; LINE_WIDTH: 0.136004
G1 X91.107 Y69.804 E.00115
M204 S10000
G1 X91.174 Y69.906 F18000
; LINE_WIDTH: 0.109548
G1 F1500
M204 S6000
G1 X90.902 Y69.715 E.00139
; WIPE_START
G1 X91.174 Y69.906 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X83.568 Y69.274 Z.96 F18000
G1 X56.2 Y67.001 Z.96
G1 Z.56
G1 E.4 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.360642
G1 F1500
M204 S6000
G1 X119.24 Y67.001 E1.05326
M204 S10000
G1 X119.665 Y67.365 F18000
; LINE_WIDTH: 0.419992
G1 F1500
M204 S6000
G1 X119.665 Y66.636 E.01434
G1 X55.835 Y66.636 E1.25544
G1 X55.835 Y67.365 E.01434
G1 X119.605 Y67.365 E1.25426
M204 S10000
G1 X120.059 Y67.76 F18000
G1 F1500
M204 S6000
G1 X120.059 Y66.242 E.02985
G1 X55.441 Y66.242 E1.27095
G1 X55.441 Y67.76 E.02985
G1 X119.999 Y67.76 E1.26977
M204 S10000
G1 X120.453 Y68.154 F18000
G1 F1500
M204 S6000
G1 X120.453 Y65.848 E.04536
G1 X55.047 Y65.848 E1.28645
G1 X55.047 Y68.154 E.04536
G1 X120.393 Y68.154 E1.28527
M204 S10000
G1 X120.847 Y68.548 F18000
G1 F1500
M204 S6000
G1 X120.847 Y65.453 E.06087
G1 X54.653 Y65.453 E1.30196
G1 X54.653 Y68.548 E.06087
G1 X120.787 Y68.548 E1.30078
; CHANGE_LAYER
; Z_HEIGHT: 0.68
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F1500
G1 X118.787 Y68.548 E-.38
; WIPE_END
G1 E-.02 F1800
; stop printing object, unique label id: 8
M625
; layer num/total_layer_count: 5/51
; update layer progress
M73 L5
M991 S0 P4 ;notify layer change
; OBJECT_ID: 12
; start printing object, unique label id: 12
M624 AgAAAAAAAAA=
M204 S10000
G17
G3 Z.96 I-.949 J-.762 P1  F18000
G1 X89.302 Y105.294 Z.96
G1 Z.68
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X89.128 Y105.232 E.00363
G1 X88.782 Y105.046 E.00774
G1 X88.475 Y104.801 E.00773
G1 X88.293 Y104.605 E.00526
G1 X88.135 Y104.388 E.00526
G1 X87.954 Y104.039 E.00773
G1 X87.837 Y103.66 E.0078
G1 X87.79 Y103.267 E.0078
G1 X87.814 Y102.874 E.00774
G1 X87.869 Y102.614 E.00525
G1 X87.939 Y102.405 E.00432
G1 X88.136 Y102.012 E.00866
G1 X88.379 Y101.697 E.00782
G1 X88.674 Y101.432 E.0078
G1 X89.008 Y101.225 E.00774
G1 X89.254 Y101.12 E.00526
G1 X89.511 Y101.045 E.00526
G1 X89.901 Y100.992 E.00774
G1 X90.294 Y101.01 E.00773
G1 X90.556 Y101.062 E.00526
G1 X90.811 Y101.144 E.00526
G1 X91.159 Y101.319 E.00767
M73 P44 R19
G1 X91.378 Y101.473 E.00526
G1 X91.577 Y101.652 E.00526
G1 X91.828 Y101.957 E.00778
G1 X92.05 Y102.376 E.00932
G1 X92.175 Y102.805 E.00879
G1 X92.211 Y103.198 E.00776
G1 X92.195 Y103.464 E.00525
G1 X92.157 Y103.68 E.00432
G1 X92.02 Y104.099 E.00865
G1 X91.827 Y104.446 E.00783
G1 X91.575 Y104.752 E.0078
G1 X91.275 Y105.007 E.00773
G1 X91.048 Y105.147 E.00524
G1 X90.849 Y105.241 E.00432
G1 X90.429 Y105.37 E.00865
G1 X90.033 Y105.411 E.00783
G1 X89.641 Y105.382 E.00773
G1 X89.38 Y105.322 E.00526
G1 X89.358 Y105.315 E.00045
; WIPE_START
M204 S6000
G1 X89.128 Y105.232 E-.04645
G1 X88.782 Y105.046 E-.07472
G1 X88.475 Y104.801 E-.07472
G1 X88.293 Y104.605 E-.05082
G1 X88.135 Y104.388 E-.05085
G1 X87.954 Y104.039 E-.07467
G1 X87.942 Y104 E-.00778
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X89.393 Y100.22 Z1.08 F18000
G1 Z.68
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X89.903 Y99.657 E.01606
G1 X54.243 Y99.657 E.75475
G1 X54.243 Y95.744 E.08282
G1 X121.843 Y95.744 E1.43081
G1 X121.843 Y94.344 E.02963
G1 X125.757 Y94.344 E.08282
G1 X125.757 Y101.057 E.14209
G1 X121.843 Y101.057 E.08282
G1 X121.843 Y99.657 E.02963
G1 X90.097 Y99.657 E.67193
G1 X90.578 Y100.188 E.01516
G1 X89.863 Y100.156 E.01514
G1 X89.453 Y100.212 E.00877
; WIPE_START
M204 S6000
G1 X89.903 Y99.657 E-.13565
G1 X88.616 Y99.657 E-.24435
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X91.054 Y100.082 Z1.08 F18000
G1 Z.68
G1 E.4 F1800
G1 F1500
M204 S500
G1 X92.247 Y101.4 E.03763
G1 X92.451 Y101.689 E.00749
G1 X92.525 Y101.816 E.00312
G1 X92.714 Y102.244 E.0099
G1 X92.852 Y102.799 E.01211
G1 X92.879 Y103.152 E.00749
G1 X92.864 Y103.499 E.00735
G1 X92.768 Y103.994 E.01067
G1 X92.604 Y104.427 E.0098
G1 X92.402 Y104.788 E.00876
G1 X92.193 Y105.068 E.0074
G1 X91.968 Y105.304 E.00691
G1 X91.694 Y105.529 E.00749
G1 X91.409 Y105.712 E.00716
G1 X91.213 Y105.801 E.00458
G1 X91.106 Y105.572 E.00535
G1 X91.516 Y105.339 E.00999
G1 X91.868 Y105.041 E.00975
G1 X92.166 Y104.678 E.00995
G1 X92.397 Y104.263 E.01004
G1 X92.555 Y103.78 E.01077
G1 X92.602 Y103.511 E.00576
G1 X92.621 Y103.192 E.00678
G1 X92.579 Y102.728 E.00984
G1 X92.432 Y102.221 E.01119
G1 X92.17 Y101.729 E.01179
G1 X91.874 Y101.368 E.00989
G1 X91.634 Y101.152 E.00683
G1 X91.37 Y100.966 E.00683
G1 X90.966 Y100.764 E.00955
G1 X90.659 Y100.665 E.00683
G1 X90.343 Y100.602 E.00683
G1 X89.882 Y100.582 E.00975
G1 X89.426 Y100.644 E.00975
G1 X89.116 Y100.734 E.00683
G1 X88.819 Y100.861 E.00683
G1 X88.427 Y101.103 E.00975
G1 X88.078 Y101.418 E.00995
G1 X87.788 Y101.793 E.01004
G1 X87.56 Y102.248 E.01077
G1 X87.474 Y102.506 E.00576
G1 X87.407 Y102.819 E.00678
G1 X87.379 Y103.279 E.00975
G1 X87.436 Y103.746 E.00995
G1 X87.574 Y104.195 E.00995
G1 X87.786 Y104.604 E.00975
G1 X87.976 Y104.865 E.00683
G1 X88.196 Y105.102 E.00683
G1 X88.556 Y105.389 E.00975
G1 X88.961 Y105.607 E.00975
G1 X89.265 Y105.716 E.00683
G1 X89.58 Y105.788 E.00683
G1 X90.039 Y105.822 E.00975
G1 X90.511 Y105.773 E.01004
G1 X91.096 Y105.593 E.01296
G1 X91.181 Y105.816 E.00505
G1 X90.992 Y105.902 E.00439
G1 X90.593 Y106.019 E.0088
G1 X90.09 Y106.079 E.01071
G1 X89.739 Y106.069 E.00743
G1 X89.237 Y105.978 E.01081
G1 X88.921 Y105.871 E.00706
G1 X88.504 Y105.659 E.0099
G1 X88.166 Y105.421 E.00876
G1 X87.917 Y105.189 E.0072
G1 X87.697 Y104.929 E.00721
G1 X87.475 Y104.58 E.00875
G1 X87.286 Y104.162 E.00971
G1 X87.191 Y103.835 E.00721
G1 X87.144 Y103.561 E.00588
G1 X87.123 Y103.329 E.00493
G1 X87.129 Y102.98 E.00739
G1 X87.175 Y102.645 E.00716
G1 X87.278 Y102.253 E.00858
G1 X87.472 Y101.823 E.00999
G1 X87.752 Y101.401 E.01071
G1 X88.946 Y100.082 E.03768
G1 X53.819 Y100.082 E.74349
G1 X53.819 Y95.32 E.10078
G1 X121.419 Y95.32 E1.43081
G1 X121.419 Y93.92 E.02963
G1 X126.181 Y93.92 E.10078
G1 X126.181 Y101.482 E.16005
G1 X121.419 Y101.482 E.10078
G1 X121.419 Y100.082 E.02963
G1 X91.114 Y100.082 E.64144
M204 S250
G1 X91.976 Y100.491 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X92.567 Y101.143 E.01731
G1 X92.796 Y101.467 E.00781
G1 X92.891 Y101.63 E.00371
G1 X93.1 Y102.106 E.01023
G1 X93.227 Y102.563 E.00932
G1 X93.289 Y103.146 E.01152
G1 X93.272 Y103.54 E.00776
G1 X93.16 Y104.115 E.01153
G1 X92.976 Y104.6 E.0102
G1 X92.747 Y105.011 E.00926
G1 X92.38 Y105.472 E.01159
G1 X91.936 Y105.861 E.01161
G1 X91.606 Y106.072 E.0077
G1 X91.135 Y106.287 E.01017
G1 X90.682 Y106.419 E.00928
G1 X90.1 Y106.489 E.01154
G1 X89.704 Y106.477 E.00779
G1 X89.125 Y106.372 E.01157
G1 X88.753 Y106.245 E.00773
G1 X88.292 Y106.01 E.01017
G1 X87.908 Y105.739 E.00926
G1 X87.62 Y105.472 E.00772
G1 X87.367 Y105.172 E.00772
G1 X87.114 Y104.775 E.00926
G1 X86.901 Y104.304 E.01018
G1 X86.792 Y103.927 E.00772
G1 X86.713 Y103.344 E.01157
G1 X86.72 Y102.949 E.00778
G1 X86.773 Y102.561 E.0077
G1 X86.915 Y102.063 E.01017
G1 X87.108 Y101.633 E.00929
M73 P45 R19
G1 X87.248 Y101.402 E.0053
G1 X87.433 Y101.144 E.00625
G1 X88.024 Y100.491 E.01732
G1 X53.41 Y100.491 E.68082
G1 X53.41 Y94.911 E.10975
G1 X121.01 Y94.911 E1.32963
G1 X121.01 Y93.511 E.02754
G1 X126.59 Y93.511 E.10975
G1 X126.59 Y101.891 E.16483
G1 X121.01 Y101.891 E.10975
G1 X121.01 Y100.491 E.02754
G1 X92.036 Y100.491 E.56989
; WIPE_START
M204 S6000
G1 X92.567 Y101.143 E-.15977
G1 X92.796 Y101.467 E-.07542
G1 X92.891 Y101.63 E-.03585
G1 X93.1 Y102.106 E-.09883
G1 X93.115 Y102.158 E-.01012
; WIPE_END
G1 E-.02 F1800
M204 S10000
G17
G3 Z1.08 I1.217 J0 P1  F18000
; stop printing object, unique label id: 12
M625
; object ids of layer 5 start: 8,12
M624 AwAAAAAAAAA=
;===================== date: 20250206 =====================

; don't support timelapse gcode in spiral_mode and by object sequence for I3 structure printer
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
G92 E0
G1 Z1.08
G1 X0 Y85.35 ; move to safe pos
G1 X-13.0 F3000 ; move to safe pos
M400
M1004 S5 P1  ; external shutter
M400 P300
M971 S11 C11 O0
G92 E0
G1 X0 F18000
M623

; SKIPTYPE: head_wrap_detect
M622.1 S1
M1002 judge_flag g39_3rd_layer_detect_flag
M622 J1
    ; enable nozzle clog detect at 3rd layer
    


    M622.1 S1
    M1002 judge_flag g39_detection_flag
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




; object ids of this layer5 end: 8,12
M625
; start printing object, unique label id: 12
M624 AgAAAAAAAAA=
G1 X91.245 Y100.642
G1 Z.68
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.0970844
G1 F1500
M204 S6000
G1 X91.16 Y100.577 E.00038
; LINE_WIDTH: 0.133338
G1 X91.067 Y100.507 E.00063
; LINE_WIDTH: 0.160253
G1 X91.044 Y100.492 E.00018
; LINE_WIDTH: 0.145327
G1 X90.871 Y100.461 E.00105
; LINE_WIDTH: 0.10161
G1 X90.697 Y100.429 E.00067
; WIPE_START
G1 X90.871 Y100.461 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X89.057 Y100.503 Z1.08 F18000
G1 Z.68
G1 E.4 F1800
; LINE_WIDTH: 0.102081
G1 F1500
M204 S6000
G1 X88.782 Y100.579 E.00109
; WIPE_START
G1 X89.057 Y100.503 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X81.452 Y99.855 Z1.08 F18000
G1 X56.2 Y97.701 Z1.08
G1 Z.68
G1 E.4 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.360652
G1 F1500
M204 S6000
G1 X121.996 Y97.701 E1.09933
; WIPE_START
G1 X119.996 Y97.701 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G17
G3 Z1.08 I-.731 J.973 P1  F18000
G1 X122.056 Y99.248 Z1.08
G1 Z.68
G1 E.4 F1800
; LINE_WIDTH: 0.419992
G1 F1500
M204 S6000
G1 X122.174 Y99.287 E.00245
G1 X122.253 Y99.445 E.00347
G1 X122.253 Y100.648 E.02366
G1 X125.347 Y100.648 E.06087
G1 X125.347 Y94.753 E.11594
G1 X122.253 Y94.753 E.06087
G1 X122.253 Y95.956 E.02366
G1 X122.174 Y96.114 E.00347
G1 X122.056 Y96.153 E.00245
G1 X54.653 Y96.153 E1.32573
G1 X54.653 Y99.248 E.06087
G1 X121.996 Y99.248 E1.32455
M204 S10000
G1 X122.056 Y98.854 F18000
G1 F1500
M204 S6000
G1 X122.263 Y98.891 E.00415
G1 X122.41 Y98.972 E.0033
G1 X122.548 Y99.118 E.00394
G1 X122.647 Y99.445 E.00673
G1 X122.647 Y100.254 E.01591
G1 X124.953 Y100.254 E.04536
G1 X124.953 Y95.148 E.10043
G1 X122.647 Y95.148 E.04536
G1 X122.647 Y95.956 E.0159
G1 X122.548 Y96.284 E.00673
G1 X122.41 Y96.429 E.00394
G1 X122.263 Y96.51 E.0033
G1 X122.056 Y96.548 E.00415
G1 X55.047 Y96.548 E1.31797
G1 X55.047 Y98.854 E.04536
G1 X121.996 Y98.854 E1.31679
M204 S10000
G1 X122.056 Y98.46 F18000
G1 F1500
M204 S6000
G1 X122.402 Y98.522 E.00692
G1 X122.647 Y98.657 E.0055
G1 X122.876 Y98.9 E.00657
G1 X123.02 Y99.242 E.00731
G1 X123.041 Y99.86 E.01215
G1 X124.559 Y99.86 E.02985
G1 X124.559 Y95.542 E.08492
G1 X123.041 Y95.542 E.02985
G1 X123.02 Y96.159 E.01215
G1 X122.876 Y96.502 E.00731
G1 X122.647 Y96.745 E.00657
G1 X122.402 Y96.879 E.0055
G1 X122.056 Y96.942 E.00692
G1 X55.441 Y96.942 E1.31022
G1 X55.441 Y98.46 E.02985
G1 X121.996 Y98.46 E1.30904
M204 S10000
G1 X122.056 Y98.065 F18000
G1 F1500
M204 S6000
M73 P45 R18
G1 X122.54 Y98.153 E.00968
G1 X122.884 Y98.341 E.0077
G1 X123.205 Y98.681 E.0092
G1 X123.406 Y99.161 E.01023
G1 X123.456 Y99.465 E.00607
G1 X124.165 Y99.465 E.01394
G1 X124.165 Y95.936 E.06941
G1 X123.435 Y95.936 E.01434
G1 X123.406 Y96.241 E.00602
G1 X123.205 Y96.72 E.01023
G1 X122.884 Y97.06 E.0092
G1 X122.54 Y97.248 E.0077
G1 X122.056 Y97.336 E.00968
G1 X55.835 Y97.336 E1.30247
G1 X55.835 Y98.065 E.01434
G1 X121.996 Y98.065 E1.30129
M204 S10000
M73 P46 R18
G1 X122.056 Y97.701 F18000
; LINE_WIDTH: 0.375487
G1 F1500
M204 S6000
G1 X122.367 Y97.742 E.00548
; LINE_WIDTH: 0.419265
G1 X122.679 Y97.784 E.00617
G1 X123.12 Y98.026 E.00988
G1 X123.533 Y98.463 E.01181
G1 X123.77 Y99.029 E.01205
G1 X123.77 Y96.373 E.05215
G1 X123.533 Y96.939 E.01205
G1 X123.12 Y97.376 E.01181
G1 X122.679 Y97.618 E.00988
; LINE_WIDTH: 0.405157
G1 X122.397 Y97.655 E.00538
; LINE_WIDTH: 0.375487
G1 X122.115 Y97.693 E.00496
; WIPE_START
G1 X122.397 Y97.655 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G17
G3 Z1.08 I0 J1.217 P1  F18000
G1 X123.39 Y97.655 Z1.08
G1 Z.68
G1 E.4 F1800
; LINE_WIDTH: 0.444372
G1 F1500
M204 S6000
G1 X123.338 Y97.655 E.00109
G1 X123.312 Y97.701 E.00109
G1 X123.338 Y97.746 E.00109
G1 X123.382 Y97.746 E.00093
; OBJECT_ID: 8
; WIPE_START
G1 X123.338 Y97.746 E-.08413
G1 X123.312 Y97.701 E-.09862
G1 X123.338 Y97.655 E-.09862
G1 X123.39 Y97.655 E-.09862
; WIPE_END
G1 E-.02 F1800
; stop printing object, unique label id: 12
M625
; start printing object, unique label id: 8
M624 AQAAAAAAAAA=
M204 S10000
G17
G3 Z1.08 I.777 J-.936 P1  F18000
G1 X92.014 Y71.607 Z1.08
G1 Z.68
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X92.05 Y71.676 E.00153
G1 X92.175 Y72.105 E.00879
G1 X92.211 Y72.498 E.00776
G1 X92.195 Y72.764 E.00525
G1 X92.157 Y72.98 E.00432
G1 X92.02 Y73.399 E.00865
G1 X91.827 Y73.746 E.00783
G1 X91.575 Y74.052 E.0078
G1 X91.275 Y74.307 E.00773
G1 X91.048 Y74.447 E.00524
G1 X90.849 Y74.541 E.00432
G1 X90.429 Y74.67 E.00865
G1 X90.033 Y74.711 E.00783
G1 X89.641 Y74.682 E.00773
G1 X89.38 Y74.622 E.00526
G1 X89.128 Y74.532 E.00526
G1 X88.782 Y74.346 E.00774
G1 X88.475 Y74.101 E.00773
G1 X88.293 Y73.905 E.00526
G1 X88.135 Y73.688 E.00526
G1 X87.954 Y73.339 E.00773
G1 X87.837 Y72.96 E.0078
G1 X87.79 Y72.567 E.0078
G1 X87.814 Y72.174 E.00774
G1 X87.869 Y71.913 E.00525
G1 X87.939 Y71.705 E.00432
G1 X88.136 Y71.312 E.00866
G1 X88.379 Y70.997 E.00782
G1 X88.674 Y70.732 E.0078
G1 X89.008 Y70.525 E.00774
G1 X89.254 Y70.42 E.00526
G1 X89.511 Y70.345 E.00526
G1 X89.901 Y70.292 E.00774
G1 X90.294 Y70.31 E.00773
G1 X90.556 Y70.362 E.00526
G1 X90.811 Y70.444 E.00526
G1 X91.159 Y70.619 E.00767
G1 X91.378 Y70.773 E.00526
G1 X91.577 Y70.952 E.00526
G1 X91.828 Y71.257 E.00778
G1 X91.986 Y71.554 E.00662
; WIPE_START
M204 S6000
G1 X92.05 Y71.676 E-.02616
G1 X92.175 Y72.105 E-.08487
G1 X92.211 Y72.498 E-.07497
G1 X92.195 Y72.764 E-.05069
G1 X92.157 Y72.98 E-.04175
G1 X92.02 Y73.399 E-.0836
G1 X91.974 Y73.481 E-.01797
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X90.578 Y69.488 Z1.08 F18000
G1 Z.68
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X89.863 Y69.456 E.01514
G1 X89.393 Y69.52 E.01004
G1 X89.903 Y68.957 E.01606
G1 X54.243 Y68.957 E.75475
G1 X54.243 Y65.044 E.08282
G1 X121.257 Y65.044 E1.41839
G1 X121.257 Y68.957 E.08282
G1 X90.097 Y68.957 E.65951
G1 X90.538 Y69.444 E.01389
; WIPE_START
M204 S6000
G1 X89.863 Y69.456 E-.12815
G1 X89.393 Y69.52 E-.09011
G1 X89.903 Y68.957 E-.14416
G1 X89.81 Y68.957 E-.01757
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X97.442 Y68.992 Z1.08 F18000
G1 X125.51 Y69.12 Z1.08
G1 Z.68
G1 E.4 F1800
G1 F1500
M204 S500
G1 X121.681 Y69.12 E.08105
G1 X121.681 Y64.882 E.08971
G1 X125.919 Y64.882 E.08971
G1 X125.919 Y69.12 E.08971
G1 X125.57 Y69.12 E.00739
M204 S250
G1 X125.51 Y68.711 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X122.09 Y68.711 E.06727
G1 X122.09 Y65.291 E.06727
G1 X125.51 Y65.291 E.06727
G1 X125.51 Y68.651 E.06609
; WIPE_START
M204 S6000
G1 X123.51 Y68.686 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X115.879 Y68.839 Z1.08 F18000
G1 X88.946 Y69.382 Z1.08
G1 Z.68
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X53.819 Y69.382 E.74349
G1 X53.819 Y64.62 E.10078
G1 X126.181 Y64.62 E1.53159
G1 X126.181 Y69.382 E.10078
G1 X91.054 Y69.382 E.74349
G1 X92.247 Y70.7 E.03763
G1 X92.451 Y70.989 E.00749
M73 P47 R18
G1 X92.525 Y71.116 E.00312
G1 X92.714 Y71.544 E.0099
G1 X92.852 Y72.099 E.01211
G1 X92.879 Y72.452 E.00749
G1 X92.864 Y72.799 E.00735
G1 X92.768 Y73.294 E.01067
G1 X92.604 Y73.727 E.0098
G1 X92.402 Y74.088 E.00876
G1 X92.193 Y74.368 E.0074
G1 X91.968 Y74.604 E.00691
G1 X91.694 Y74.829 E.00749
G1 X91.409 Y75.012 E.00716
G1 X91.213 Y75.101 E.00458
G1 X91.106 Y74.872 E.00535
G1 X91.516 Y74.639 E.00999
G1 X91.868 Y74.341 E.00975
G1 X92.166 Y73.978 E.00995
G1 X92.397 Y73.563 E.01004
G1 X92.555 Y73.08 E.01077
G1 X92.602 Y72.811 E.00576
G1 X92.621 Y72.492 E.00678
G1 X92.579 Y72.028 E.00984
G1 X92.432 Y71.521 E.01119
G1 X92.17 Y71.029 E.01179
G1 X91.874 Y70.668 E.00989
G1 X91.634 Y70.452 E.00683
G1 X91.37 Y70.266 E.00683
G1 X90.966 Y70.064 E.00955
G1 X90.659 Y69.965 E.00683
G1 X90.343 Y69.902 E.00683
G1 X89.882 Y69.882 E.00975
G1 X89.426 Y69.944 E.00975
G1 X89.116 Y70.034 E.00683
G1 X88.819 Y70.161 E.00683
G1 X88.427 Y70.403 E.00975
G1 X88.078 Y70.718 E.00995
G1 X87.788 Y71.093 E.01004
G1 X87.56 Y71.548 E.01077
G1 X87.474 Y71.806 E.00576
G1 X87.407 Y72.119 E.00678
G1 X87.379 Y72.579 E.00975
G1 X87.436 Y73.046 E.00995
G1 X87.574 Y73.495 E.00995
G1 X87.786 Y73.904 E.00975
G1 X87.976 Y74.165 E.00683
G1 X88.195 Y74.402 E.00683
G1 X88.556 Y74.689 E.00975
G1 X88.961 Y74.907 E.00975
G1 X89.265 Y75.016 E.00683
G1 X89.58 Y75.088 E.00683
G1 X90.039 Y75.122 E.00975
G1 X90.511 Y75.073 E.01004
G1 X91.096 Y74.893 E.01296
G1 X91.181 Y75.116 E.00505
G1 X90.992 Y75.202 E.00439
G1 X90.593 Y75.319 E.0088
G1 X90.09 Y75.379 E.01071
G1 X89.739 Y75.369 E.00743
G1 X89.237 Y75.278 E.01081
G1 X88.907 Y75.165 E.00739
G1 X88.602 Y75.018 E.00716
G1 X88.221 Y74.763 E.00971
G1 X87.857 Y74.418 E.01061
G1 X87.697 Y74.229 E.00524
G1 X87.475 Y73.88 E.00875
G1 X87.286 Y73.462 E.00971
G1 X87.191 Y73.135 E.00721
G1 X87.123 Y72.629 E.01081
G1 X87.129 Y72.28 E.00739
G1 X87.175 Y71.945 E.00716
G1 X87.278 Y71.553 E.00858
G1 X87.472 Y71.123 E.00999
G1 X87.752 Y70.701 E.01071
G1 X88.906 Y69.426 E.03641
M204 S250
G1 X88.024 Y69.791 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X53.41 Y69.791 E.68082
G1 X53.41 Y64.211 E.10975
G1 X126.59 Y64.211 E1.43939
G1 X126.59 Y69.791 E.10975
G1 X91.976 Y69.791 E.68082
G1 X92.567 Y70.443 E.01731
G1 X92.796 Y70.767 E.00781
G1 X92.891 Y70.93 E.00371
G1 X93.1 Y71.406 E.01023
G1 X93.227 Y71.863 E.00932
G1 X93.289 Y72.446 E.01152
G1 X93.272 Y72.84 E.00776
G1 X93.16 Y73.415 E.01153
G1 X92.976 Y73.9 E.0102
G1 X92.747 Y74.311 E.00926
G1 X92.38 Y74.772 E.01159
G1 X91.936 Y75.161 E.01161
G1 X91.606 Y75.372 E.0077
G1 X91.135 Y75.587 E.01017
G1 X90.682 Y75.719 E.00928
G1 X90.1 Y75.789 E.01154
G1 X89.704 Y75.777 E.00779
G1 X89.125 Y75.672 E.01157
G1 X88.751 Y75.544 E.00778
G1 X88.398 Y75.374 E.0077
G1 X87.969 Y75.086 E.01017
G1 X87.619 Y74.771 E.00926
G1 X87.367 Y74.472 E.00769
G1 X87.114 Y74.075 E.00926
G1 X86.901 Y73.604 E.01018
G1 X86.792 Y73.227 E.00772
G1 X86.713 Y72.644 E.01157
G1 X86.72 Y72.249 E.00778
G1 X86.773 Y71.861 E.0077
G1 X86.915 Y71.363 E.01017
G1 X87.108 Y70.932 E.00929
G1 X87.248 Y70.702 E.0053
G1 X87.433 Y70.444 E.00625
G1 X87.984 Y69.835 E.01614
M204 S10000
G1 X88.782 Y69.879 F18000
; FEATURE: Gap infill
; LINE_WIDTH: 0.102062
G1 F1500
M204 S6000
G1 X89.057 Y69.803 E.00109
; WIPE_START
G1 X88.782 Y69.879 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X90.697 Y69.729 Z1.08 F18000
G1 Z.68
G1 E.4 F1800
; LINE_WIDTH: 0.10161
G1 F1500
M204 S6000
G1 X90.871 Y69.761 E.00067
; LINE_WIDTH: 0.145326
G1 X91.044 Y69.792 E.00105
; LINE_WIDTH: 0.160253
G1 X91.067 Y69.807 E.00018
; LINE_WIDTH: 0.133338
G1 X91.16 Y69.877 E.00063
; LINE_WIDTH: 0.0970844
G1 X91.245 Y69.942 E.00038
; WIPE_START
G1 X91.16 Y69.877 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X83.553 Y69.252 Z1.08 F18000
G1 X56.2 Y67.001 Z1.08
G1 Z.68
G1 E.4 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.360642
G1 F1500
M204 S6000
G1 X119.24 Y67.001 E1.05326
M204 S10000
G1 X119.665 Y67.365 F18000
; LINE_WIDTH: 0.419992
G1 F1500
M204 S6000
G1 X119.665 Y66.636 E.01434
G1 X55.835 Y66.636 E1.25544
G1 X55.835 Y67.365 E.01434
G1 X119.605 Y67.365 E1.25426
M204 S10000
G1 X120.059 Y67.76 F18000
G1 F1500
M204 S6000
G1 X120.059 Y66.242 E.02985
G1 X55.441 Y66.242 E1.27095
G1 X55.441 Y67.76 E.02985
G1 X119.999 Y67.76 E1.26977
M204 S10000
G1 X120.453 Y68.154 F18000
G1 F1500
M204 S6000
G1 X120.453 Y65.848 E.04536
G1 X55.047 Y65.848 E1.28645
G1 X55.047 Y68.154 E.04536
G1 X120.393 Y68.154 E1.28527
M204 S10000
G1 X120.847 Y68.548 F18000
G1 F1500
M204 S6000
G1 X120.847 Y65.453 E.06087
G1 X54.653 Y65.453 E1.30196
G1 X54.653 Y68.548 E.06087
G1 X120.787 Y68.548 E1.30078
; CHANGE_LAYER
; Z_HEIGHT: 0.8
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F1500
G1 X118.787 Y68.548 E-.38
; WIPE_END
G1 E-.02 F1800
; stop printing object, unique label id: 8
M625
; layer num/total_layer_count: 6/51
; update layer progress
M73 L6
M991 S0 P5 ;notify layer change
; OBJECT_ID: 12
; start printing object, unique label id: 12
M624 AgAAAAAAAAA=
M204 S10000
G17
G3 Z1.08 I-.892 J-.828 P1  F18000
G1 X89.393 Y100.22 Z1.08
G1 Z.8
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X89.903 Y99.657 E.01606
G1 X54.243 Y99.657 E.75475
G1 X54.243 Y95.744 E.08282
G1 X121.843 Y95.744 E1.43081
G1 X121.843 Y94.344 E.02963
G1 X125.757 Y94.344 E.08282
M73 P48 R18
G1 X125.757 Y101.057 E.14209
G1 X121.843 Y101.057 E.08282
G1 X121.843 Y99.657 E.02963
G1 X90.069 Y99.657 E.67254
G1 X90.557 Y100.187 E.01526
G1 X89.863 Y100.156 E.0147
G1 X89.453 Y100.212 E.00877
; WIPE_START
M204 S6000
G1 X89.903 Y99.657 E-.13565
G1 X88.616 Y99.657 E-.24435
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X89.186 Y105.687 Z1.2 F18000
G1 Z.8
G1 E.4 F1800
G1 F1500
M204 S500
G1 X89.116 Y105.669 E.00154
G1 X88.698 Y105.475 E.00975
G1 X88.428 Y105.297 E.00683
M73 P48 R17
G1 X88.254 Y105.15 E.00482
G1 X88.245 Y105.161 E.0003
G1 X87.879 Y104.742 E.01178
G1 X87.638 Y104.338 E.00995
G1 X87.476 Y103.907 E.00975
G1 X87.409 Y103.591 E.00683
G1 X87.38 Y103.27 E.00683
M73 P49 R17
G1 X87.408 Y102.804 E.00987
G1 X87.547 Y102.275 E.01159
G1 X87.787 Y101.793 E.01139
G1 X88.078 Y101.418 E.01005
G1 X88.42 Y101.109 E.00975
G1 X88.69 Y100.932 E.00683
G1 X88.979 Y100.787 E.00683
G1 X89.416 Y100.645 E.00975
G1 X89.882 Y100.582 E.00995
G1 X90.352 Y100.603 E.00995
G1 X90.801 Y100.705 E.00975
G1 X91.101 Y100.823 E.00683
G1 X91.386 Y100.976 E.00683
G1 X91.754 Y101.253 E.00975
G1 X92.077 Y101.601 E.01005
G1 X92.349 Y102.042 E.01097
G1 X92.458 Y102.291 E.00575
G1 X92.58 Y102.733 E.00969
G1 X92.622 Y103.206 E.01007
G1 X92.563 Y103.751 E.01159
G1 X92.398 Y104.263 E.01139
G1 X92.166 Y104.678 E.01005
G1 X91.868 Y105.041 E.00995
G1 X91.505 Y105.348 E.01007
G1 X91.026 Y105.613 E.01159
G1 X90.512 Y105.773 E.01139
G1 X90.039 Y105.822 E.01006
G1 X89.57 Y105.787 E.00995
G1 X89.244 Y105.702 E.00714
M204 S250
G1 X89.289 Y105.291 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X89.254 Y105.282 E.00071
G1 X88.897 Y105.117 E.00773
G1 X88.674 Y104.969 E.00526
G1 X88.47 Y104.796 E.00526
G1 X88.211 Y104.5 E.00774
G1 X88.008 Y104.16 E.0078
G1 X87.87 Y103.792 E.00773
G1 X87.814 Y103.53 E.00526
G1 X87.79 Y103.264 E.00526
G1 X87.814 Y102.869 E.00777
G1 X87.932 Y102.42 E.00914
G1 X88.136 Y102.012 E.00896
G1 X88.379 Y101.697 E.00783
G1 X88.671 Y101.434 E.00773
G1 X88.895 Y101.287 E.00526
G1 X89.134 Y101.167 E.00526
G1 X89.508 Y101.045 E.00773
G1 X89.901 Y100.992 E.0078
G1 X90.297 Y101.01 E.00779
G1 X90.68 Y101.097 E.00774
G1 X90.929 Y101.195 E.00526
G1 X91.165 Y101.322 E.00526
G1 X91.479 Y101.558 E.00773
G1 X91.75 Y101.85 E.00783
G1 X91.986 Y102.232 E.00883
G1 X92.071 Y102.428 E.0042
G1 X92.175 Y102.806 E.00772
G1 X92.211 Y103.203 E.00783
G1 X92.161 Y103.665 E.00914
G1 X92.021 Y104.099 E.00896
G1 X91.827 Y104.446 E.00783
G1 X91.575 Y104.752 E.0078
G1 X91.271 Y105.01 E.00783
G1 X90.864 Y105.235 E.00914
G1 X90.429 Y105.37 E.00896
G1 X90.033 Y105.411 E.00783
G1 X89.638 Y105.382 E.00779
G1 X89.347 Y105.306 E.00591
; WIPE_START
M204 S6000
G1 X89.254 Y105.282 E-.01822
G1 X88.897 Y105.117 E-.0747
G1 X88.674 Y104.969 E-.05083
G1 X88.47 Y104.796 E-.05084
G1 X88.211 Y104.5 E-.07472
G1 X88.008 Y104.16 E-.07531
G1 X87.943 Y103.986 E-.03538
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X91.037 Y100.082 Z1.2 F18000
G1 Z.8
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X92.196 Y101.339 E.0362
G1 X92.35 Y101.535 E.00528
G1 X92.607 Y101.975 E.01079
G1 X92.738 Y102.309 E.0076
G1 X92.825 Y102.642 E.00727
G1 X92.862 Y102.887 E.00525
G1 X92.882 Y103.1 E.00452
G1 X92.864 Y103.5 E.00847
G1 X92.824 Y103.76 E.00557
G1 X92.768 Y103.995 E.00512
G1 X92.61 Y104.413 E.00946
G1 X92.397 Y104.797 E.00927
G1 X92.077 Y105.196 E.01083
G1 X91.743 Y105.498 E.00954
G1 X91.409 Y105.712 E.00839
G1 X91.006 Y105.897 E.00939
G1 X90.591 Y106.019 E.00914
G1 X90.09 Y106.079 E.0107
G1 X89.742 Y106.069 E.00737
G1 X89.406 Y106.018 E.00718
G1 X88.97 Y105.89 E.00962
G1 X88.591 Y105.712 E.00885
G1 X88.311 Y105.532 E.00705
G1 X87.974 Y105.244 E.00939
G1 X87.718 Y104.962 E.00804
G1 X87.468 Y104.568 E.0099
G1 X87.286 Y104.163 E.00939
G1 X87.191 Y103.835 E.00723
G1 X87.146 Y103.575 E.00557
G1 X87.123 Y103.328 E.00525
G1 X87.129 Y102.98 E.00737
G1 X87.176 Y102.639 E.00729
G1 X87.264 Y102.302 E.00736
G1 X87.47 Y101.825 E.011
G1 X87.753 Y101.4 E.01082
G1 X88.946 Y100.082 E.03763
G1 X53.819 Y100.082 E.74349
G1 X53.819 Y95.32 E.10078
G1 X121.419 Y95.32 E1.43081
G1 X121.419 Y93.92 E.02963
G1 X126.181 Y93.92 E.10078
G1 X126.181 Y101.482 E.16005
G1 X121.419 Y101.482 E.10078
G1 X121.419 Y100.082 E.02963
G1 X91.097 Y100.082 E.6418
M204 S250
G1 X91.97 Y100.491 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X92.508 Y101.074 E.0156
G1 X92.685 Y101.299 E.00564
G1 X92.895 Y101.638 E.00784
G1 X93.126 Y102.178 E.01155
G1 X93.227 Y102.56 E.00777
G1 X93.289 Y103.145 E.01157
G1 X93.272 Y103.54 E.00779
G1 X93.16 Y104.116 E.01153
G1 X92.982 Y104.586 E.00989
G1 X92.745 Y105.014 E.00963
G1 X92.378 Y105.474 E.01158
G1 X91.936 Y105.861 E.01155
G1 X91.605 Y106.072 E.00771
G1 X91.149 Y106.281 E.00987
G1 X90.682 Y106.419 E.00958
G1 X90.1 Y106.489 E.01154
G1 X89.705 Y106.477 E.00777
G1 X89.317 Y106.419 E.00771
G1 X88.851 Y106.281 E.00957
G1 X88.395 Y106.072 E.00987
G1 X88.066 Y105.862 E.00767
G1 X87.685 Y105.536 E.00987
G1 X87.366 Y105.171 E.00953
G1 X87.106 Y104.762 E.00953
G1 X86.901 Y104.304 E.00987
G1 X86.791 Y103.927 E.00773
G1 X86.713 Y103.344 E.01157
G1 X86.72 Y102.949 E.00777
G1 X86.774 Y102.559 E.00775
G1 X86.874 Y102.177 E.00777
G1 X86.982 Y101.895 E.00594
G1 X87.204 Y101.467 E.00947
G1 X87.433 Y101.143 E.00781
G1 X88.024 Y100.491 E.01731
G1 X53.41 Y100.491 E.68082
G1 X53.41 Y94.911 E.10975
G1 X121.01 Y94.911 E1.32963
G1 X121.01 Y93.511 E.02754
G1 X126.59 Y93.511 E.10975
G1 X126.59 Y101.891 E.16483
G1 X121.01 Y101.891 E.10975
G1 X121.01 Y100.491 E.02754
G1 X92.03 Y100.491 E.57
; WIPE_START
M204 S6000
G1 X92.508 Y101.074 E-.14318
G1 X92.685 Y101.299 E-.05447
G1 X92.895 Y101.638 E-.07569
G1 X93.116 Y102.154 E-.10667
; WIPE_END
G1 E-.02 F1800
M204 S10000
G17
G3 Z1.2 I1.217 J0 P1  F18000
; stop printing object, unique label id: 12
M625
; object ids of layer 6 start: 8,12
M624 AwAAAAAAAAA=
;===================== date: 20250206 =====================

; don't support timelapse gcode in spiral_mode and by object sequence for I3 structure printer
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
G92 E0
G1 Z1.2
G1 X0 Y85.35 ; move to safe pos
G1 X-13.0 F3000 ; move to safe pos
M400
M1004 S5 P1  ; external shutter
M400 P300
M971 S11 C11 O0
G92 E0
G1 X0 F18000
M623

; SKIPTYPE: head_wrap_detect
M622.1 S1
M1002 judge_flag g39_3rd_layer_detect_flag
M622 J1
    ; enable nozzle clog detect at 3rd layer
    


    M622.1 S1
    M1002 judge_flag g39_detection_flag
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




; object ids of this layer6 end: 8,12
M625
; start printing object, unique label id: 12
M624 AgAAAAAAAAA=
G1 X91.149 Y100.517
G1 Z.8
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.154243
G1 F1500
M204 S6000
G1 X91.015 Y100.488 E.00088
; LINE_WIDTH: 0.128547
G1 X90.874 Y100.459 E.00074
; LINE_WIDTH: 0.0973305
G1 X90.653 Y100.429 E.0008
; WIPE_START
G1 X90.874 Y100.459 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X89.101 Y100.498 Z1.2 F18000
G1 Z.8
G1 E.4 F1800
; LINE_WIDTH: 0.0988961
G1 F1500
M204 S6000
G1 X88.869 Y100.552 E.00087
G1 X88.763 Y100.633 E.00049
; WIPE_START
G1 X88.869 Y100.552 E-.13703
G1 X89.101 Y100.498 E-.24297
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X81.473 Y100.227 Z1.2 F18000
G1 X55.249 Y99.294 Z1.2
G1 Z.8
G1 E.4 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
M73 P50 R17
G1 F1500
M204 S6000
G1 X54.606 Y99.294 E.0136
G1 X54.606 Y98.24 E.02232
G1 X54.644 Y98.179 E.00151
G1 X54.96 Y97.269 E.0204
G1 X54.99 Y96.814 E.00966
G1 X54.71 Y96.358 E.01131
G1 X54.606 Y96.298 E.00254
G1 X54.606 Y96.107 E.00405
G1 X55.946 Y96.107 E.02835
G1 X56.1 Y96.358 E.00625
G1 X56.888 Y96.814 E.01926
G1 X57.571 Y97.269 E.01737
G1 X58.004 Y97.724 E.01331
G1 X58.285 Y98.179 E.01132
G1 X58.602 Y99.09 E.0204
G1 X58.615 Y99.294 E.00434
G1 X60.905 Y99.294 E.04846
G1 X61.212 Y99.09 E.00781
G1 X61.646 Y98.634 E.01331
G1 X61.927 Y98.179 E.01132
G1 X62.243 Y97.269 E.0204
G1 X62.274 Y96.814 E.00966
G1 X61.994 Y96.358 E.01131
G1 X61.558 Y96.107 E.01064
G1 X63.229 Y96.107 E.03535
G1 X63.383 Y96.358 E.00625
G1 X64.171 Y96.814 E.01926
G1 X64.854 Y97.269 E.01737
G1 X65.288 Y97.724 E.01331
G1 X65.569 Y98.179 E.01132
G1 X65.885 Y99.09 E.0204
G1 X65.899 Y99.294 E.00434
G1 X68.188 Y99.294 E.04846
G1 X68.495 Y99.09 E.00781
G1 X68.929 Y98.634 E.01331
G1 X69.21 Y98.179 E.01132
G1 X69.527 Y97.269 E.0204
G1 X69.557 Y96.814 E.00966
G1 X69.277 Y96.358 E.01131
G1 X68.842 Y96.107 E.01064
G1 X70.512 Y96.107 E.03535
G1 X70.667 Y96.358 E.00625
G1 X71.454 Y96.814 E.01926
G1 X72.137 Y97.269 E.01737
G1 X72.571 Y97.724 E.01331
G1 X72.852 Y98.179 E.01132
G1 X73.168 Y99.09 E.0204
G1 X73.182 Y99.294 E.00434
G1 X75.471 Y99.294 E.04846
G1 X75.779 Y99.09 E.00781
G1 X76.212 Y98.634 E.01331
G1 X76.493 Y98.179 E.01132
G1 X76.81 Y97.269 E.0204
G1 X76.84 Y96.814 E.00966
G1 X76.56 Y96.358 E.01131
G1 X76.125 Y96.107 E.01064
G1 X77.795 Y96.107 E.03535
G1 X77.95 Y96.358 E.00625
G1 X78.738 Y96.814 E.01926
G1 X79.42 Y97.269 E.01737
G1 X79.854 Y97.724 E.01331
G1 X80.135 Y98.179 E.01132
G1 X80.451 Y99.09 E.0204
G1 X80.465 Y99.294 E.00434
G1 X82.755 Y99.294 E.04846
G1 X83.062 Y99.09 E.00781
G1 X83.495 Y98.634 E.01331
G1 X83.776 Y98.179 E.01132
G1 X84.093 Y97.269 E.0204
G1 X84.123 Y96.814 E.00966
G1 X83.843 Y96.358 E.01131
G1 X83.408 Y96.107 E.01064
G1 X85.078 Y96.107 E.03535
G1 X85.233 Y96.358 E.00625
G1 X86.021 Y96.814 E.01926
G1 X86.703 Y97.269 E.01737
G1 X87.137 Y97.724 E.01331
G1 X87.418 Y98.179 E.01132
G1 X87.734 Y99.09 E.0204
G1 X87.748 Y99.294 E.00434
G1 X90.038 Y99.294 E.04846
G1 X90.345 Y99.09 E.00781
G1 X90.778 Y98.634 E.01331
G1 X91.06 Y98.179 E.01132
G1 X91.376 Y97.269 E.0204
G1 X91.406 Y96.814 E.00966
G1 X91.126 Y96.358 E.01131
G1 X90.691 Y96.107 E.01064
G1 X92.361 Y96.107 E.03535
G1 X92.516 Y96.358 E.00625
G1 X93.304 Y96.814 E.01926
G1 X93.986 Y97.269 E.01737
G1 X94.42 Y97.724 E.01331
G1 X94.701 Y98.179 E.01132
G1 X95.018 Y99.09 E.0204
G1 X95.031 Y99.294 E.00434
G1 X97.321 Y99.294 E.04846
G1 X97.628 Y99.09 E.00781
G1 X98.062 Y98.634 E.01331
G1 X98.343 Y98.179 E.01132
G1 X98.659 Y97.269 E.0204
G1 X98.689 Y96.814 E.00966
G1 X98.409 Y96.358 E.01131
G1 X97.974 Y96.107 E.01064
G1 X99.644 Y96.107 E.03535
G1 X99.799 Y96.358 E.00625
G1 X100.587 Y96.814 E.01926
G1 X101.27 Y97.269 E.01737
G1 X101.703 Y97.724 E.01331
G1 X101.984 Y98.179 E.01132
G1 X102.301 Y99.09 E.0204
G1 X102.314 Y99.294 E.00434
G1 X104.604 Y99.294 E.04846
G1 X104.911 Y99.09 E.00781
G1 X105.345 Y98.634 E.01331
G1 X105.626 Y98.179 E.01132
G1 X105.942 Y97.269 E.0204
G1 X105.972 Y96.814 E.00966
G1 X105.692 Y96.358 E.01131
G1 X105.257 Y96.107 E.01064
G1 X106.928 Y96.107 E.03535
G1 X107.082 Y96.358 E.00625
G1 X107.87 Y96.814 E.01926
G1 X108.553 Y97.269 E.01737
G1 X108.986 Y97.724 E.01331
G1 X109.267 Y98.179 E.01132
G1 X109.584 Y99.09 E.0204
G1 X109.597 Y99.294 E.00434
G1 X111.887 Y99.294 E.04846
G1 X112.194 Y99.09 E.00781
G1 X112.628 Y98.634 E.01331
G1 X112.909 Y98.179 E.01132
G1 X113.225 Y97.269 E.0204
G1 X113.256 Y96.814 E.00966
G1 X112.975 Y96.358 E.01131
G1 X112.54 Y96.107 E.01064
G1 X114.211 Y96.107 E.03535
G1 X114.365 Y96.358 E.00625
G1 X115.153 Y96.814 E.01926
G1 X115.836 Y97.269 E.01737
G1 X116.269 Y97.724 E.01331
G1 X116.551 Y98.179 E.01132
G1 X116.867 Y99.09 E.0204
G1 X116.881 Y99.294 E.00434
G1 X119.17 Y99.294 E.04846
G1 X119.477 Y99.09 E.00781
G1 X119.911 Y98.634 E.01331
G1 X120.192 Y98.179 E.01132
G1 X120.509 Y97.269 E.0204
G1 X120.539 Y96.814 E.00966
G1 X120.259 Y96.358 E.01131
G1 X119.824 Y96.107 E.01064
G1 X121.494 Y96.107 E.03535
G1 X121.648 Y96.358 E.00625
G1 X122.436 Y96.814 E.01926
G1 X123.119 Y97.269 E.01737
G1 X123.553 Y97.724 E.01331
G1 X123.834 Y98.179 E.01132
G1 X124.15 Y99.09 E.0204
G1 X124.18 Y99.545 E.00966
G1 X123.9 Y100 E.01131
G1 X123.112 Y100.455 E.01926
G1 X122.754 Y100.694 E.00913
G1 X125.026 Y100.694 E.04809
G1 X125.01 Y100.455 E.00507
G1 X125.29 Y100 E.01131
G1 X125.394 Y99.708 E.00656
G1 X125.394 Y98.011 E.03592
; OBJECT_ID: 8
; WIPE_START
G1 X125.394 Y99.708 E-.32243
G1 X125.292 Y99.994 E-.05757
; WIPE_END
G1 E-.02 F1800
; stop printing object, unique label id: 12
M625
; start printing object, unique label id: 8
M624 AQAAAAAAAAA=
M204 S10000
G17
G3 Z1.2 I.798 J-.919 P1  F18000
G1 X92.395 Y71.452 Z1.2
G1 Z.8
G1 E.4 F1800
; FEATURE: Inner wall
G1 F1500
M204 S500
G1 X92.503 Y71.723 E.00616
G1 X92.58 Y72.042 E.00695
G1 X92.622 Y72.506 E.00987
G1 X92.563 Y73.051 E.01159
G1 X92.398 Y73.563 E.01139
G1 X92.166 Y73.978 E.01005
G1 X91.868 Y74.341 E.00995
G1 X91.505 Y74.648 E.01007
G1 X91.026 Y74.913 E.01159
G1 X90.512 Y75.073 E.01139
G1 X90.034 Y75.123 E.01018
G1 X89.488 Y75.072 E.01159
G1 X88.974 Y74.914 E.01139
G1 X88.556 Y74.689 E.01005
G1 X88.188 Y74.396 E.00995
G1 X87.879 Y74.042 E.00995
G1 X87.638 Y73.638 E.00995
G1 X87.476 Y73.207 E.00975
G1 X87.409 Y72.891 E.00683
G1 X87.38 Y72.57 E.00683
G1 X87.408 Y72.104 E.00987
G1 X87.547 Y71.575 E.01159
G1 X87.787 Y71.093 E.01139
G1 X88.078 Y70.718 E.01006
G1 X88.42 Y70.409 E.00975
G1 X88.69 Y70.231 E.00683
G1 X88.979 Y70.087 E.00683
G1 X89.416 Y69.945 E.00975
G1 X89.882 Y69.882 E.00995
G1 X90.352 Y69.903 E.00995
G1 X90.801 Y70.005 E.00975
G1 X91.101 Y70.123 E.00683
G1 X91.386 Y70.276 E.00683
G1 X91.754 Y70.553 E.00975
G1 X92.077 Y70.901 E.01005
G1 X92.355 Y71.351 E.01118
G1 X92.373 Y71.396 E.00104
M204 S250
G1 X92.015 Y71.603 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X92.112 Y71.847 E.00517
G1 X92.176 Y72.109 E.0053
G1 X92.211 Y72.503 E.00777
G1 X92.161 Y72.965 E.00914
G1 X92.021 Y73.398 E.00896
G1 X91.827 Y73.746 E.00783
G1 X91.575 Y74.052 E.0078
G1 X91.271 Y74.31 E.00783
G1 X90.864 Y74.535 E.00914
G1 X90.429 Y74.67 E.00896
G1 X90.031 Y74.712 E.00787
G1 X89.568 Y74.668 E.00914
G1 X89.133 Y74.535 E.00896
G1 X88.782 Y74.346 E.00783
G1 X88.472 Y74.099 E.0078
G1 X88.211 Y73.8 E.0078
G1 X88.008 Y73.46 E.0078
G1 X87.87 Y73.092 E.00773
G1 X87.814 Y72.83 E.00526
G1 X87.79 Y72.564 E.00526
G1 X87.814 Y72.169 E.00777
G1 X87.932 Y71.72 E.00914
G1 X88.136 Y71.312 E.00896
G1 X88.379 Y70.997 E.00783
G1 X88.671 Y70.734 E.00773
G1 X88.895 Y70.587 E.00526
G1 X89.134 Y70.467 E.00526
G1 X89.508 Y70.345 E.00773
G1 X89.901 Y70.292 E.0078
G1 X90.297 Y70.31 E.00779
G1 X90.68 Y70.397 E.00774
G1 X90.929 Y70.495 E.00526
G1 X91.165 Y70.622 E.00526
G1 X91.479 Y70.858 E.00773
G1 X91.75 Y71.15 E.00783
G1 X91.988 Y71.535 E.0089
G1 X91.993 Y71.547 E.00027
; WIPE_START
M204 S6000
G1 X92.112 Y71.847 E-.06133
G1 X92.176 Y72.109 E-.05121
G1 X92.211 Y72.503 E-.07506
G1 X92.161 Y72.965 E-.08834
G1 X92.021 Y73.398 E-.08659
G1 X91.976 Y73.479 E-.01748
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X99.509 Y72.252 Z1.2 F18000
G1 X121.257 Y68.711 Z1.2
G1 Z.8
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X121.257 Y68.957 E.00522
G1 X90.069 Y68.957 E.66012
G1 X90.557 Y69.487 E.01526
G1 X89.863 Y69.456 E.0147
G1 X89.393 Y69.52 E.01004
G1 X89.903 Y68.957 E.01606
G1 X54.243 Y68.957 E.75475
G1 X54.243 Y65.044 E.08282
G1 X121.257 Y65.044 E1.41839
G1 X121.257 Y68.651 E.07633
; WIPE_START
M204 S6000
G1 X121.257 Y68.957 E-.05824
G1 X119.563 Y68.957 E-.32176
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X125.51 Y69.12 Z1.2 F18000
G1 Z.8
G1 E.4 F1800
G1 F1500
M204 S500
G1 X121.681 Y69.12 E.08105
G1 X121.681 Y64.882 E.08971
G1 X125.919 Y64.882 E.08971
G1 X125.919 Y69.12 E.08971
G1 X125.57 Y69.12 E.00739
M204 S250
G1 X125.51 Y68.711 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X122.09 Y68.711 E.06727
G1 X122.09 Y65.291 E.06727
G1 X125.51 Y65.291 E.06727
G1 X125.51 Y68.651 E.06609
; WIPE_START
M204 S6000
G1 X123.51 Y68.686 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X115.879 Y68.839 Z1.2 F18000
G1 X88.946 Y69.382 Z1.2
G1 Z.8
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X53.819 Y69.382 E.74349
G1 X53.819 Y64.62 E.10078
G1 X126.181 Y64.62 E1.53159
G1 X126.181 Y69.382 E.10078
G1 X91.037 Y69.382 E.74386
G1 X92.196 Y70.639 E.0362
G1 X92.35 Y70.835 E.00528
G1 X92.607 Y71.275 E.01079
G1 X92.737 Y71.605 E.0075
G1 X92.825 Y71.942 E.00737
G1 X92.862 Y72.187 E.00525
G1 X92.882 Y72.4 E.00452
G1 X92.864 Y72.8 E.00847
G1 X92.824 Y73.06 E.00557
G1 X92.768 Y73.295 E.00512
G1 X92.61 Y73.713 E.00946
G1 X92.397 Y74.097 E.00927
G1 X92.077 Y74.496 E.01083
G1 X91.743 Y74.798 E.00954
G1 X91.409 Y75.012 E.00839
G1 X91.006 Y75.197 E.00939
G1 X90.591 Y75.319 E.00914
G1 X90.147 Y75.381 E.0095
G1 X89.742 Y75.369 E.00858
G1 X89.406 Y75.318 E.00718
G1 X88.994 Y75.197 E.00908
G1 X88.591 Y75.012 E.00939
M73 P51 R17
G1 X88.311 Y74.832 E.00705
G1 X87.974 Y74.544 E.00939
G1 X87.718 Y74.262 E.00804
G1 X87.468 Y73.868 E.0099
G1 X87.286 Y73.463 E.00939
G1 X87.191 Y73.135 E.00723
G1 X87.146 Y72.875 E.00557
G1 X87.123 Y72.628 E.00525
G1 X87.129 Y72.28 E.00737
G1 X87.176 Y71.939 E.00729
G1 X87.264 Y71.602 E.00736
G1 X87.47 Y71.125 E.011
G1 X87.753 Y70.7 E.01082
G1 X88.906 Y69.426 E.03636
M204 S250
G1 X88.024 Y69.791 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X53.41 Y69.791 E.68082
G1 X53.41 Y64.211 E.10975
G1 X126.59 Y64.211 E1.43939
G1 X126.59 Y69.791 E.10975
G1 X91.97 Y69.791 E.68094
G1 X92.508 Y70.374 E.0156
G1 X92.685 Y70.599 E.00564
G1 X92.895 Y70.938 E.00784
G1 X93.126 Y71.478 E.01155
G1 X93.227 Y71.86 E.00777
G1 X93.289 Y72.445 E.01157
G1 X93.272 Y72.84 E.00779
G1 X93.16 Y73.416 E.01153
G1 X92.982 Y73.886 E.00989
G1 X92.745 Y74.314 E.00963
G1 X92.378 Y74.774 E.01158
G1 X91.936 Y75.161 E.01155
G1 X91.605 Y75.372 E.00771
G1 X91.149 Y75.581 E.00987
G1 X90.682 Y75.719 E.00958
G1 X90.1 Y75.789 E.01154
G1 X89.705 Y75.777 E.00777
G1 X89.317 Y75.719 E.00771
G1 X88.851 Y75.581 E.00957
G1 X88.395 Y75.372 E.00987
G1 X88.066 Y75.162 E.00767
G1 X87.685 Y74.836 E.00987
G1 X87.366 Y74.471 E.00953
G1 X87.106 Y74.062 E.00953
G1 X86.901 Y73.604 E.00987
G1 X86.791 Y73.227 E.00773
G1 X86.713 Y72.644 E.01157
G1 X86.72 Y72.249 E.00777
G1 X86.774 Y71.858 E.00775
G1 X86.874 Y71.477 E.00777
G1 X86.982 Y71.195 E.00594
G1 X87.204 Y70.767 E.00947
G1 X87.433 Y70.443 E.00781
G1 X87.984 Y69.835 E.01613
M204 S10000
G1 X88.763 Y69.933 F18000
; FEATURE: Gap infill
; LINE_WIDTH: 0.0988871
G1 F1500
M204 S6000
G1 X88.869 Y69.852 E.00049
G1 X89.101 Y69.798 E.00087
; WIPE_START
M73 P51 R16
G1 X88.869 Y69.852 E-.24297
G1 X88.763 Y69.933 E-.13703
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X90.653 Y69.729 Z1.2 F18000
G1 Z.8
G1 E.4 F1800
; LINE_WIDTH: 0.0973306
G1 F1500
M204 S6000
G1 X90.874 Y69.759 E.0008
; LINE_WIDTH: 0.128549
G1 X91.015 Y69.788 E.00074
; LINE_WIDTH: 0.154249
G1 X91.149 Y69.817 E.00088
; WIPE_START
G1 X91.015 Y69.788 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X98.564 Y68.665 Z1.2 F18000
G1 X120.446 Y65.407 Z1.2
G1 Z.8
G1 E.4 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F1500
M204 S6000
G1 X118.749 Y65.407 E.03592
G1 X119.471 Y65.903 E.01854
G1 X120.259 Y66.358 E.01926
G1 X120.539 Y66.814 E.01131
G1 X120.509 Y67.269 E.00966
G1 X120.192 Y68.179 E.0204
G1 X119.895 Y68.594 E.01081
G1 X116.706 Y68.594 E.06749
G1 X116.551 Y68.179 E.00938
G1 X116.269 Y67.724 E.01132
G1 X115.836 Y67.269 E.01331
G1 X115.153 Y66.814 E.01737
G1 X114.365 Y66.358 E.01926
G1 X114.085 Y65.903 E.01131
G1 X114.13 Y65.407 E.01054
G1 X111.466 Y65.407 E.05638
G1 X112.188 Y65.903 E.01854
G1 X112.975 Y66.358 E.01926
G1 X113.256 Y66.814 E.01131
G1 X113.225 Y67.269 E.00966
G1 X112.909 Y68.179 E.0204
G1 X112.611 Y68.594 E.01081
G1 X109.423 Y68.594 E.06749
G1 X109.267 Y68.179 E.00938
G1 X108.986 Y67.724 E.01132
G1 X108.553 Y67.269 E.01331
G1 X107.87 Y66.814 E.01737
G1 X107.082 Y66.358 E.01926
G1 X106.802 Y65.903 E.01131
G1 X106.846 Y65.407 E.01054
G1 X104.183 Y65.407 E.05638
G1 X104.904 Y65.903 E.01854
G1 X105.692 Y66.358 E.01926
G1 X105.972 Y66.814 E.01131
G1 X105.942 Y67.269 E.00966
G1 X105.626 Y68.179 E.0204
G1 X105.328 Y68.594 E.01081
G1 X102.14 Y68.594 E.06749
G1 X101.984 Y68.179 E.00938
G1 X101.703 Y67.724 E.01132
G1 X101.27 Y67.269 E.01331
G1 X100.587 Y66.814 E.01737
G1 X99.799 Y66.358 E.01926
G1 X99.519 Y65.903 E.01131
G1 X99.563 Y65.407 E.01054
G1 X96.9 Y65.407 E.05638
G1 X97.621 Y65.903 E.01854
G1 X98.409 Y66.358 E.01926
G1 X98.689 Y66.814 E.01131
G1 X98.659 Y67.269 E.00966
G1 X98.343 Y68.179 E.0204
G1 X98.045 Y68.594 E.01081
G1 X94.856 Y68.594 E.06749
G1 X94.701 Y68.179 E.00938
G1 X94.42 Y67.724 E.01132
G1 X93.986 Y67.269 E.01331
G1 X93.304 Y66.814 E.01737
G1 X92.516 Y66.358 E.01926
G1 X92.236 Y65.903 E.01131
G1 X92.28 Y65.407 E.01054
G1 X89.617 Y65.407 E.05638
G1 X90.338 Y65.903 E.01854
G1 X91.126 Y66.358 E.01926
G1 X91.406 Y66.814 E.01131
G1 X91.376 Y67.269 E.00966
G1 X91.06 Y68.179 E.0204
G1 X90.762 Y68.594 E.01081
G1 X87.573 Y68.594 E.06749
G1 X87.418 Y68.179 E.00938
G1 X87.137 Y67.724 E.01132
G1 X86.703 Y67.269 E.01331
G1 X86.021 Y66.814 E.01737
G1 X85.233 Y66.358 E.01926
G1 X84.953 Y65.903 E.01131
G1 X84.997 Y65.407 E.01054
G1 X82.333 Y65.407 E.05638
G1 X83.055 Y65.903 E.01854
G1 X83.843 Y66.358 E.01926
G1 X84.123 Y66.814 E.01131
G1 X84.093 Y67.269 E.00966
G1 X83.776 Y68.179 E.0204
G1 X83.479 Y68.594 E.01081
G1 X80.29 Y68.594 E.06749
G1 X80.135 Y68.179 E.00938
G1 X79.854 Y67.724 E.01132
G1 X79.42 Y67.269 E.01331
G1 X78.738 Y66.814 E.01737
G1 X77.95 Y66.358 E.01926
G1 X77.67 Y65.903 E.01131
G1 X77.714 Y65.407 E.01054
G1 X75.05 Y65.407 E.05638
G1 X75.772 Y65.903 E.01854
G1 X76.56 Y66.358 E.01926
G1 X76.84 Y66.814 E.01131
G1 X76.81 Y67.269 E.00966
G1 X76.493 Y68.179 E.0204
G1 X76.196 Y68.594 E.01081
G1 X73.007 Y68.594 E.06749
G1 X72.852 Y68.179 E.00938
G1 X72.571 Y67.724 E.01132
G1 X72.137 Y67.269 E.01331
G1 X71.454 Y66.814 E.01737
G1 X70.667 Y66.358 E.01926
G1 X70.387 Y65.903 E.01131
G1 X70.431 Y65.407 E.01054
G1 X67.767 Y65.407 E.05638
G1 X68.489 Y65.903 E.01854
G1 X69.277 Y66.358 E.01926
G1 X69.557 Y66.814 E.01131
G1 X69.527 Y67.269 E.00966
G1 X69.21 Y68.179 E.0204
G1 X68.913 Y68.594 E.01081
G1 X65.724 Y68.594 E.06749
G1 X65.569 Y68.179 E.00938
G1 X65.288 Y67.724 E.01132
G1 X64.854 Y67.269 E.01331
G1 X64.171 Y66.814 E.01737
G1 X63.383 Y66.358 E.01926
G1 X63.103 Y65.903 E.01131
G1 X63.148 Y65.407 E.01054
G1 X60.484 Y65.407 E.05638
G1 X61.206 Y65.903 E.01854
G1 X61.994 Y66.358 E.01926
G1 X62.274 Y66.814 E.01131
G1 X62.243 Y67.269 E.00966
G1 X61.927 Y68.179 E.0204
G1 X61.629 Y68.594 E.01081
G1 X58.441 Y68.594 E.06749
G1 X58.285 Y68.179 E.00938
G1 X58.004 Y67.724 E.01132
G1 X57.571 Y67.269 E.01331
G1 X56.888 Y66.814 E.01737
G1 X56.1 Y66.358 E.01926
G1 X55.82 Y65.903 E.01131
G1 X55.865 Y65.407 E.01054
G1 X54.606 Y65.407 E.02663
G1 X54.606 Y66.298 E.01886
G1 X54.71 Y66.358 E.00254
G1 X54.99 Y66.814 E.01131
G1 X54.96 Y67.269 E.00966
G1 X54.644 Y68.179 E.0204
G1 X54.606 Y68.232 E.00136
G1 X54.606 Y68.594 E.00768
G1 X55.941 Y68.594 E.02824
; CHANGE_LAYER
; Z_HEIGHT: 0.92
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F1500
G1 X54.606 Y68.594 E-.2535
G1 X54.606 Y68.232 E-.06893
G1 X54.644 Y68.179 E-.01225
G1 X54.722 Y67.954 E-.04532
; WIPE_END
G1 E-.02 F1800
; stop printing object, unique label id: 8
M625
; layer num/total_layer_count: 7/51
; update layer progress
M73 L7
M991 S0 P6 ;notify layer change
; OBJECT_ID: 12
; start printing object, unique label id: 12
M624 AgAAAAAAAAA=
M204 S10000
G17
G3 Z1.2 I-.829 J.891 P1  F18000
G1 X89.394 Y100.219 Z1.2
G1 Z.92
G1 E.4 F1800
; FEATURE: Inner wall
G1 F1500
M204 S500
G1 X89.903 Y99.657 E.01604
G1 X54.243 Y99.657 E.75475
G1 X54.243 Y95.744 E.08282
G1 X121.843 Y95.744 E1.43081
G1 X121.843 Y94.344 E.02963
G1 X125.757 Y94.344 E.08282
G1 X125.757 Y101.057 E.14209
G1 X121.843 Y101.057 E.08282
G1 X121.843 Y99.657 E.02963
G1 X90.062 Y99.657 E.67268
G1 X90.571 Y100.207 E.01586
G1 X89.949 Y100.153 E.01322
G1 X89.453 Y100.212 E.01056
; WIPE_START
M204 S6000
G1 X89.903 Y99.657 E-.13563
G1 X88.616 Y99.657 E-.24437
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X89.179 Y105.685 Z1.32 F18000
G1 Z.92
G1 E.4 F1800
G1 F1500
M204 S500
G1 X89.116 Y105.669 E.00138
G1 X88.698 Y105.475 E.00975
G1 X88.428 Y105.297 E.00683
G1 X88.182 Y105.089 E.00683
G1 X87.879 Y104.742 E.00975
G1 X87.643 Y104.346 E.00975
G1 X87.52 Y104.048 E.00683
G1 X87.434 Y103.737 E.00683
G1 X87.381 Y103.289 E.00955
G1 X87.39 Y102.966 E.00683
G1 X87.438 Y102.647 E.00683
G1 X87.574 Y102.206 E.00975
G1 X87.791 Y101.789 E.00994
G1 X88.081 Y101.414 E.01006
G1 X88.487 Y101.06 E.01139
G1 X88.964 Y100.792 E.01159
G1 X89.421 Y100.643 E.01017
G1 X89.956 Y100.58 E.01139
G1 X90.501 Y100.627 E.01159
G1 X90.958 Y100.76 E.01007
G1 X91.37 Y100.966 E.00975
G1 X91.634 Y101.152 E.00683
M73 P52 R16
G1 X91.874 Y101.368 E.00683
G1 X92.166 Y101.724 E.00975
G1 X92.391 Y102.126 E.00975
G1 X92.504 Y102.428 E.00683
G1 X92.58 Y102.742 E.00683
G1 X92.622 Y103.201 E.00975
G1 X92.579 Y103.674 E.01005
G1 X92.428 Y104.19 E.01139
G1 X92.17 Y104.673 E.01159
G1 X91.868 Y105.041 E.01007
G1 X91.505 Y105.348 E.01005
G1 X91.035 Y105.609 E.01139
G1 X90.512 Y105.773 E.01159
G1 X90.039 Y105.822 E.01007
G1 X89.57 Y105.787 E.00995
G1 X89.237 Y105.7 E.0073
M204 S250
G1 X89.282 Y105.289 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X89.254 Y105.282 E.00056
G1 X88.897 Y105.117 E.00773
G1 X88.674 Y104.969 E.00526
G1 X88.47 Y104.796 E.00526
G1 X88.211 Y104.5 E.00774
G1 X88.01 Y104.163 E.00773
G1 X87.908 Y103.915 E.00526
G1 X87.837 Y103.657 E.00526
G1 X87.791 Y103.27 E.00767
G1 X87.799 Y103.003 E.00526
G1 X87.838 Y102.738 E.00526
G1 X87.954 Y102.362 E.00774
G1 X88.137 Y102.011 E.00779
G1 X88.38 Y101.696 E.00783
G1 X88.724 Y101.396 E.00896
G1 X89.129 Y101.168 E.00914
G1 X89.51 Y101.045 E.00787
G1 X89.962 Y100.991 E.00897
G1 X90.425 Y101.031 E.00915
G1 X90.808 Y101.143 E.00783
G1 X91.159 Y101.319 E.00773
G1 X91.378 Y101.473 E.00526
G1 X91.577 Y101.652 E.00526
G1 X91.827 Y101.955 E.00773
G1 X92.018 Y102.299 E.00774
G1 X92.112 Y102.549 E.00526
G1 X92.176 Y102.809 E.00526
G1 X92.211 Y103.201 E.00773
G1 X92.175 Y103.597 E.00783
G1 X92.047 Y104.035 E.00897
G1 X91.828 Y104.445 E.00915
G1 X91.575 Y104.752 E.00783
G1 X91.271 Y105.01 E.00783
G1 X90.873 Y105.231 E.00897
G1 X90.429 Y105.37 E.00914
G1 X90.033 Y105.411 E.00784
G1 X89.638 Y105.382 E.0078
G1 X89.34 Y105.304 E.00606
; WIPE_START
M204 S6000
G1 X89.254 Y105.282 E-.01683
G1 X88.897 Y105.117 E-.07469
G1 X88.674 Y104.969 E-.05085
G1 X88.47 Y104.796 E-.05083
G1 X88.211 Y104.5 E-.07472
G1 X88.01 Y104.163 E-.07469
G1 X87.935 Y103.981 E-.0374
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X91.033 Y100.082 Z1.32 F18000
G1 Z.92
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X92.186 Y101.328 E.03595
G1 X92.349 Y101.535 E.00557
G1 X92.534 Y101.833 E.00743
G1 X92.642 Y102.057 E.00525
G1 X92.736 Y102.302 E.00557
G1 X92.824 Y102.639 E.00736
G1 X92.872 Y102.989 E.00749
G1 X92.879 Y103.137 E.00314
G1 X92.851 Y103.589 E.00959
G1 X92.763 Y104.012 E.00915
G1 X92.581 Y104.478 E.01059
G1 X92.346 Y104.871 E.00967
G1 X92.073 Y105.2 E.00906
G1 X91.745 Y105.497 E.00936
G1 X91.408 Y105.712 E.00846
G1 X91.019 Y105.892 E.00907
G1 X90.59 Y106.019 E.00947
G1 X90.089 Y106.079 E.01068
G1 X89.742 Y106.069 E.00736
G1 X89.407 Y106.018 E.00717
G1 X88.981 Y105.892 E.0094
G1 X88.592 Y105.712 E.00908
G1 X88.306 Y105.529 E.00719
G1 X88.037 Y105.308 E.00737
G1 X87.693 Y104.925 E.01088
G1 X87.424 Y104.488 E.01087
G1 X87.288 Y104.168 E.00736
G1 X87.191 Y103.834 E.00737
G1 X87.148 Y103.59 E.00525
G1 X87.123 Y103.328 E.00557
G1 X87.129 Y102.98 E.00736
G1 X87.176 Y102.639 E.00729
G1 X87.263 Y102.305 E.0073
G1 X87.462 Y101.838 E.01074
G1 X87.747 Y101.406 E.01094
G1 X88.946 Y100.082 E.03783
G1 X53.819 Y100.082 E.74349
G1 X53.819 Y95.32 E.10078
G1 X121.419 Y95.32 E1.43081
G1 X121.419 Y93.92 E.02963
G1 X126.181 Y93.92 E.10078
G1 X126.181 Y101.482 E.16005
G1 X121.419 Y101.482 E.10078
G1 X121.419 Y100.082 E.02963
G1 X91.093 Y100.082 E.64189
M204 S250
G1 X91.969 Y100.491 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X92.498 Y101.062 E.01531
G1 X92.685 Y101.3 E.00594
G1 X92.894 Y101.636 E.00779
G1 X93.126 Y102.177 E.01157
G1 X93.226 Y102.559 E.00777
G1 X93.289 Y103.14 E.01151
G1 X93.258 Y103.644 E.00993
G1 X93.158 Y104.121 E.00959
G1 X93.065 Y104.391 E.0056
G1 X92.945 Y104.666 E.00591
G1 X92.695 Y105.084 E.00958
G1 X92.376 Y105.476 E.00993
G1 X91.936 Y105.861 E.01151
G1 X91.605 Y106.072 E.00771
G1 X91.164 Y106.276 E.00956
G1 X90.682 Y106.419 E.00989
G1 X90.099 Y106.489 E.01153
G1 X89.705 Y106.477 E.00777
G1 X89.317 Y106.419 E.00771
G1 X88.836 Y106.276 E.00987
G1 X88.395 Y106.072 E.00957
G1 X88.064 Y105.861 E.00771
G1 X87.759 Y105.61 E.00777
G1 X87.366 Y105.171 E.01159
G1 X87.205 Y104.933 E.00566
G1 X87.056 Y104.669 E.00594
G1 X86.902 Y104.306 E.00777
G1 X86.791 Y103.927 E.00777
G1 X86.713 Y103.344 E.01157
G1 X86.72 Y102.949 E.00777
G1 X86.774 Y102.559 E.00774
G1 X86.874 Y102.178 E.00775
G1 X87.105 Y101.638 E.01155
G1 X87.317 Y101.298 E.00788
G1 X87.431 Y101.145 E.00375
G1 X88.024 Y100.491 E.01737
G1 X53.41 Y100.491 E.68082
G1 X53.41 Y94.911 E.10975
G1 X121.01 Y94.911 E1.32963
G1 X121.01 Y93.511 E.02754
G1 X126.59 Y93.511 E.10975
G1 X126.59 Y101.891 E.16483
G1 X121.01 Y101.891 E.10975
G1 X121.01 Y100.491 E.02754
G1 X92.029 Y100.491 E.57003
; WIPE_START
M204 S6000
G1 X92.498 Y101.062 E-.14042
G1 X92.685 Y101.3 E-.05742
G1 X92.894 Y101.636 E-.07526
G1 X93.116 Y102.153 E-.1069
; WIPE_END
G1 E-.02 F1800
M204 S10000
G17
G3 Z1.32 I1.217 J0 P1  F18000
; stop printing object, unique label id: 12
M625
; object ids of layer 7 start: 8,12
M624 AwAAAAAAAAA=
;===================== date: 20250206 =====================

; don't support timelapse gcode in spiral_mode and by object sequence for I3 structure printer
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
G92 E0
G1 Z1.32
G1 X0 Y85.35 ; move to safe pos
G1 X-13.0 F3000 ; move to safe pos
M400
M1004 S5 P1  ; external shutter
M400 P300
M971 S11 C11 O0
G92 E0
G1 X0 F18000
M623

; SKIPTYPE: head_wrap_detect
M622.1 S1
M1002 judge_flag g39_3rd_layer_detect_flag
M622 J1
    ; enable nozzle clog detect at 3rd layer
    


    M622.1 S1
    M1002 judge_flag g39_detection_flag
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




; object ids of this layer7 end: 8,12
M625
; start printing object, unique label id: 12
M624 AgAAAAAAAAA=
G1 X91.221 Y100.63
G1 Z.92
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.093869
G1 F1500
M204 S6000
G1 X91.147 Y100.575 E.00031
; LINE_WIDTH: 0.124137
G1 X91.05 Y100.513 E.00057
; LINE_WIDTH: 0.103849
G1 X90.783 Y100.463 E.00106
; WIPE_START
G1 X91.05 Y100.513 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X89.131 Y100.489 Z1.32 F18000
G1 Z.92
G1 E.4 F1800
; LINE_WIDTH: 0.101161
G1 F1500
M204 S6000
G1 X88.88 Y100.544 E.00097
G1 X88.76 Y100.637 E.00057
; WIPE_START
G1 X88.88 Y100.544 E-.14152
G1 X89.131 Y100.489 E-.23848
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X96.761 Y100.288 Z1.32 F18000
G1 X122.206 Y99.619 Z1.32
G1 Z.92
G1 E.4 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F1500
M204 S6000
G1 X122.206 Y100.694 E.02277
G1 X122.828 Y100.694 E.01315
G1 X123.685 Y100.317 E.01983
M73 P53 R16
G1 X124.14 Y100.174 E.0101
G1 X124.595 Y100.211 E.00967
G1 X124.95 Y100.694 E.0127
G1 X125.394 Y100.694 E.00939
G1 X125.394 Y99.719 E.02065
G1 X125.05 Y99.826 E.00762
G1 X124.595 Y99.79 E.00967
G1 X124.14 Y98.684 E.0253
G1 X123.685 Y97.872 E.0197
G1 X123.23 Y97.389 E.01405
G1 X122.774 Y97.076 E.01169
G1 X121.864 Y96.675 E.02106
G1 X121.409 Y96.532 E.0101
G1 X120.954 Y96.569 E.00967
G1 X120.498 Y97.674 E.0253
G1 X120.043 Y98.486 E.0197
G1 X119.588 Y98.969 E.01405
G1 X119.105 Y99.294 E.01233
G1 X117.108 Y99.294 E.04226
G1 X116.857 Y98.684 E.01397
G1 X116.402 Y97.872 E.0197
G1 X115.946 Y97.389 E.01405
G1 X115.491 Y97.076 E.01169
G1 X114.581 Y96.675 E.02106
G1 X114.126 Y96.532 E.0101
G1 X113.67 Y96.569 E.00967
G1 X113.215 Y97.674 E.0253
G1 X112.76 Y98.486 E.0197
G1 X112.305 Y98.969 E.01405
G1 X111.822 Y99.294 E.01233
G1 X109.825 Y99.294 E.04226
G1 X109.574 Y98.684 E.01397
G1 X109.118 Y97.872 E.0197
G1 X108.663 Y97.389 E.01405
G1 X108.208 Y97.076 E.01169
G1 X107.298 Y96.675 E.02106
G1 X106.842 Y96.532 E.0101
G1 X106.387 Y96.569 E.00967
G1 X105.932 Y97.674 E.0253
G1 X105.477 Y98.486 E.0197
G1 X105.022 Y98.969 E.01405
G1 X104.539 Y99.294 E.01233
G1 X102.542 Y99.294 E.04226
G1 X102.291 Y98.684 E.01397
G1 X101.835 Y97.872 E.0197
G1 X101.38 Y97.389 E.01405
G1 X100.925 Y97.076 E.01169
G1 X100.015 Y96.675 E.02106
G1 X99.559 Y96.532 E.0101
G1 X99.104 Y96.569 E.00967
G1 X98.649 Y97.674 E.0253
G1 X98.194 Y98.486 E.0197
G1 X97.739 Y98.969 E.01405
G1 X97.255 Y99.294 E.01233
G1 X95.259 Y99.294 E.04226
G1 X95.007 Y98.684 E.01397
G1 X94.552 Y97.872 E.0197
G1 X94.097 Y97.389 E.01405
G1 X93.642 Y97.076 E.01169
G1 X92.731 Y96.675 E.02106
G1 X92.276 Y96.532 E.0101
G1 X91.821 Y96.569 E.00967
G1 X91.366 Y97.674 E.0253
G1 X90.911 Y98.486 E.0197
G1 X90.455 Y98.969 E.01405
G1 X89.972 Y99.294 E.01233
G1 X87.976 Y99.294 E.04226
G1 X87.724 Y98.684 E.01397
G1 X87.269 Y97.872 E.0197
G1 X86.814 Y97.389 E.01405
G1 X86.359 Y97.076 E.01169
G1 X85.448 Y96.675 E.02106
G1 X84.993 Y96.532 E.0101
G1 X84.538 Y96.569 E.00967
G1 X84.083 Y97.674 E.0253
G1 X83.627 Y98.486 E.0197
G1 X83.172 Y98.969 E.01405
G1 X82.689 Y99.294 E.01233
G1 X80.692 Y99.294 E.04226
G1 X80.441 Y98.684 E.01397
G1 X79.986 Y97.872 E.0197
G1 X79.531 Y97.389 E.01405
G1 X79.076 Y97.076 E.01169
G1 X78.165 Y96.675 E.02106
G1 X77.71 Y96.532 E.0101
G1 X77.255 Y96.569 E.00967
G1 X76.8 Y97.674 E.0253
G1 X76.344 Y98.486 E.0197
G1 X75.889 Y98.969 E.01405
G1 X75.406 Y99.294 E.01233
G1 X73.409 Y99.294 E.04226
G1 X73.158 Y98.684 E.01397
G1 X72.703 Y97.872 E.0197
G1 X72.248 Y97.389 E.01405
G1 X71.792 Y97.076 E.01169
G1 X70.882 Y96.675 E.02106
G1 X70.427 Y96.532 E.0101
G1 X69.972 Y96.569 E.00967
G1 X69.516 Y97.674 E.0253
G1 X69.061 Y98.486 E.0197
G1 X68.606 Y98.969 E.01405
G1 X68.123 Y99.294 E.01233
G1 X66.126 Y99.294 E.04226
G1 X65.875 Y98.684 E.01397
G1 X65.42 Y97.872 E.0197
G1 X64.964 Y97.389 E.01405
G1 X64.509 Y97.076 E.01169
G1 X63.599 Y96.675 E.02106
G1 X63.144 Y96.532 E.0101
G1 X62.688 Y96.569 E.00967
G1 X62.233 Y97.674 E.0253
G1 X61.778 Y98.486 E.0197
G1 X61.323 Y98.969 E.01405
G1 X60.84 Y99.294 E.01233
G1 X58.843 Y99.294 E.04226
G1 X58.592 Y98.684 E.01397
G1 X58.137 Y97.872 E.0197
G1 X57.681 Y97.389 E.01405
G1 X57.226 Y97.076 E.01169
G1 X56.316 Y96.675 E.02106
G1 X55.861 Y96.532 E.0101
G1 X55.405 Y96.569 E.00967
G1 X54.95 Y97.674 E.0253
G1 X54.606 Y98.288 E.01488
G1 X54.606 Y96.107 E.04615
G1 X54.703 Y96.107 E.00204
G1 X54.95 Y96.185 E.00549
G1 X55.405 Y96.148 E.00967
G1 X55.422 Y96.107 E.00094
G1 X61.986 Y96.107 E.13892
G1 X62.233 Y96.185 E.00549
G1 X62.688 Y96.148 E.00967
G1 X62.705 Y96.107 E.00094
G1 X69.269 Y96.107 E.13892
G1 X69.516 Y96.185 E.00549
G1 X69.972 Y96.148 E.00967
G1 X69.988 Y96.107 E.00094
G1 X76.552 Y96.107 E.13892
G1 X76.8 Y96.185 E.00549
G1 X77.255 Y96.148 E.00967
G1 X77.272 Y96.107 E.00094
G1 X83.835 Y96.107 E.13892
G1 X84.083 Y96.185 E.00549
G1 X84.538 Y96.148 E.00967
G1 X84.555 Y96.107 E.00094
G1 X91.118 Y96.107 E.13892
G1 X91.366 Y96.185 E.00549
G1 X91.821 Y96.148 E.00967
G1 X91.838 Y96.107 E.00094
G1 X98.401 Y96.107 E.13892
G1 X98.649 Y96.185 E.00549
G1 X99.104 Y96.148 E.00967
G1 X99.121 Y96.107 E.00094
G1 X105.684 Y96.107 E.13892
G1 X105.932 Y96.185 E.00549
G1 X106.387 Y96.148 E.00967
G1 X106.404 Y96.107 E.00094
G1 X112.968 Y96.107 E.13892
G1 X113.215 Y96.185 E.00549
G1 X113.67 Y96.148 E.00967
G1 X113.687 Y96.107 E.00094
G1 X120.251 Y96.107 E.13892
G1 X120.498 Y96.185 E.00549
G1 X120.954 Y96.148 E.00967
G1 X120.97 Y96.107 E.00094
G1 X122.206 Y96.107 E.02616
G1 X122.206 Y95.646 E.00976
; OBJECT_ID: 8
; WIPE_START
G1 X122.206 Y96.107 E-.08759
G1 X120.97 Y96.107 E-.23483
G1 X120.954 Y96.148 E-.0084
G1 X120.696 Y96.169 E-.04917
; WIPE_END
G1 E-.02 F1800
; stop printing object, unique label id: 12
M625
; start printing object, unique label id: 8
M624 AQAAAAAAAAA=
M204 S10000
G1 X114.947 Y91.148 Z1.32 F18000
G1 X92.403 Y71.458 Z1.32
G1 Z.92
G1 E.4 F1800
; FEATURE: Inner wall
G1 F1500
M204 S500
G1 X92.504 Y71.728 E.00611
G1 X92.58 Y72.042 E.00683
G1 X92.622 Y72.501 E.00975
G1 X92.58 Y72.969 E.00995
G1 X92.455 Y73.422 E.00995
G1 X92.255 Y73.837 E.00975
G1 X92.073 Y74.104 E.00683
G1 X91.861 Y74.347 E.00683
G1 X91.505 Y74.648 E.00985
G1 X91.035 Y74.909 E.01139
G1 X90.512 Y75.072 E.01159
G1 X90.039 Y75.122 E.01007
G1 X89.57 Y75.087 E.00995
G1 X89.116 Y74.969 E.00995
G1 X88.698 Y74.775 E.00975
G1 X88.428 Y74.597 E.00683
G1 X88.182 Y74.389 E.00683
G1 X87.879 Y74.042 E.00975
G1 X87.643 Y73.646 E.00975
G1 X87.52 Y73.348 E.00683
G1 X87.434 Y73.037 E.00683
G1 X87.381 Y72.589 E.00955
G1 X87.39 Y72.266 E.00683
G1 X87.438 Y71.947 E.00683
G1 X87.574 Y71.506 E.00975
G1 X87.791 Y71.089 E.00994
G1 X88.081 Y70.714 E.01006
G1 X88.487 Y70.36 E.01139
G1 X88.964 Y70.092 E.01159
G1 X89.421 Y69.943 E.01017
G1 X89.956 Y69.88 E.01139
G1 X90.501 Y69.927 E.01159
G1 X90.958 Y70.06 E.01007
G1 X91.37 Y70.266 E.00975
G1 X91.634 Y70.452 E.00683
G1 X91.874 Y70.668 E.00683
G1 X92.166 Y71.024 E.00975
G1 X92.378 Y71.404 E.00921
M204 S250
G1 X92.019 Y71.602 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X92.112 Y71.849 E.00519
G1 X92.176 Y72.109 E.00526
G1 X92.211 Y72.501 E.00773
G1 X92.175 Y72.895 E.0078
G1 X92.07 Y73.278 E.0078
G1 X91.899 Y73.632 E.00773
G1 X91.749 Y73.853 E.00526
G1 X91.573 Y74.054 E.00526
G1 X91.271 Y74.31 E.00777
G1 X90.873 Y74.531 E.00897
G1 X90.429 Y74.67 E.00914
G1 X90.033 Y74.711 E.00784
G1 X89.638 Y74.682 E.0078
G1 X89.254 Y74.582 E.0078
G1 X88.897 Y74.417 E.00773
G1 X88.674 Y74.269 E.00526
G1 X88.47 Y74.096 E.00526
G1 X88.211 Y73.8 E.00774
G1 X88.01 Y73.463 E.00773
G1 X87.908 Y73.215 E.00526
G1 X87.837 Y72.957 E.00526
G1 X87.791 Y72.57 E.00767
G1 X87.799 Y72.303 E.00526
G1 X87.838 Y72.038 E.00526
G1 X87.954 Y71.662 E.00774
G1 X88.137 Y71.311 E.00779
G1 X88.38 Y70.996 E.00783
G1 X88.724 Y70.696 E.00896
G1 X89.129 Y70.468 E.00914
G1 X89.51 Y70.345 E.00787
G1 X89.962 Y70.291 E.00897
G1 X90.425 Y70.331 E.00915
G1 X90.808 Y70.443 E.00783
G1 X91.159 Y70.619 E.00773
G1 X91.378 Y70.773 E.00526
G1 X91.577 Y70.952 E.00526
G1 X91.827 Y71.255 E.00773
G1 X91.991 Y71.549 E.00662
; WIPE_START
M204 S6000
G1 X92.112 Y71.849 E-.06147
G1 X92.176 Y72.109 E-.05085
G1 X92.211 Y72.501 E-.0747
G1 X92.175 Y72.895 E-.0753
G1 X92.07 Y73.278 E-.07532
G1 X91.973 Y73.479 E-.04236
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X99.506 Y72.252 Z1.32 F18000
G1 X121.257 Y68.711 Z1.32
G1 Z.92
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X121.257 Y68.957 E.00522
G1 X90.062 Y68.957 E.66026
G1 X90.571 Y69.507 E.01586
G1 X89.949 Y69.453 E.01322
G1 X89.394 Y69.519 E.01183
G1 X89.903 Y68.957 E.01604
G1 X54.243 Y68.957 E.75475
G1 X54.243 Y65.044 E.08282
G1 X121.257 Y65.044 E1.41839
G1 X121.257 Y68.651 E.07633
; WIPE_START
M204 S6000
G1 X121.257 Y68.957 E-.05824
G1 X119.563 Y68.957 E-.32176
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X125.51 Y69.12 Z1.32 F18000
G1 Z.92
G1 E.4 F1800
G1 F1500
M204 S500
G1 X121.681 Y69.12 E.08105
G1 X121.681 Y64.882 E.08971
G1 X125.919 Y64.882 E.08971
G1 X125.919 Y69.12 E.08971
G1 X125.57 Y69.12 E.00739
M204 S250
G1 X125.51 Y68.711 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X122.09 Y68.711 E.06727
G1 X122.09 Y65.291 E.06727
G1 X125.51 Y65.291 E.06727
G1 X125.51 Y68.651 E.06609
; WIPE_START
M204 S6000
G1 X123.51 Y68.686 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X115.879 Y68.839 Z1.32 F18000
G1 X88.946 Y69.382 Z1.32
G1 Z.92
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X53.819 Y69.382 E.74349
G1 X53.819 Y64.62 E.10078
G1 X126.181 Y64.62 E1.53159
G1 X126.181 Y69.382 E.10078
G1 X91.033 Y69.382 E.74394
G1 X92.186 Y70.628 E.03595
G1 X92.349 Y70.835 E.00557
G1 X92.534 Y71.133 E.00743
G1 X92.736 Y71.602 E.01081
G1 X92.824 Y71.939 E.00736
G1 X92.872 Y72.289 E.00749
G1 X92.864 Y72.806 E.01094
G1 X92.844 Y72.959 E.00326
G1 X92.767 Y73.299 E.00738
G1 X92.616 Y73.7 E.00908
G1 X92.347 Y74.162 E.01131
G1 X92.193 Y74.368 E.00544
G1 X91.968 Y74.604 E.00691
G1 X91.745 Y74.797 E.00623
G1 X91.408 Y75.012 E.00846
G1 X91.019 Y75.192 E.00907
G1 X90.59 Y75.319 E.00947
G1 X90.089 Y75.379 E.01068
G1 X89.742 Y75.369 E.00736
G1 X89.407 Y75.318 E.00717
G1 X88.981 Y75.192 E.0094
G1 X88.592 Y75.012 E.00908
G1 X88.306 Y74.829 E.00719
G1 X88.037 Y74.608 E.00737
G1 X87.712 Y74.253 E.01018
G1 X87.461 Y73.855 E.00996
G1 X87.286 Y73.463 E.00908
G1 X87.191 Y73.134 E.00726
G1 X87.123 Y72.628 E.01081
G1 X87.129 Y72.28 E.00736
G1 X87.176 Y71.939 E.00729
G1 X87.263 Y71.605 E.0073
G1 X87.393 Y71.275 E.0075
M73 P54 R16
G1 X87.654 Y70.829 E.01094
G1 X87.747 Y70.706 E.00326
G1 X88.906 Y69.426 E.03655
M204 S250
G1 X88.024 Y69.791 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X53.41 Y69.791 E.68082
G1 X53.41 Y64.211 E.10975
G1 X126.59 Y64.211 E1.43939
G1 X126.59 Y69.791 E.10975
G1 X91.969 Y69.791 E.68096
G1 X92.498 Y70.362 E.01531
G1 X92.685 Y70.6 E.00594
G1 X92.894 Y70.936 E.00779
G1 X93.126 Y71.477 E.01157
G1 X93.226 Y71.859 E.00777
G1 X93.289 Y72.442 E.01155
G1 X93.272 Y72.842 E.00787
G1 X93.159 Y73.417 E.01152
G1 X92.988 Y73.872 E.00957
G1 X92.746 Y74.311 E.00987
G1 X92.38 Y74.772 E.01158
G1 X91.936 Y75.161 E.01161
G1 X91.605 Y75.372 E.00771
G1 X91.164 Y75.576 E.00956
G1 X90.682 Y75.719 E.00989
G1 X90.099 Y75.789 E.01153
G1 X89.705 Y75.777 E.00777
G1 X89.317 Y75.719 E.00771
G1 X88.836 Y75.576 E.00987
G1 X88.395 Y75.372 E.00957
G1 X88.064 Y75.161 E.00771
G1 X87.759 Y74.91 E.00777
G1 X87.368 Y74.474 E.01153
G1 X87.099 Y74.048 E.00989
G1 X86.901 Y73.604 E.00957
G1 X86.791 Y73.227 E.00773
G1 X86.713 Y72.644 E.01157
G1 X86.72 Y72.249 E.00777
G1 X86.774 Y71.859 E.00774
G1 X86.874 Y71.478 E.00775
G1 X87.105 Y70.938 E.01155
G1 X87.317 Y70.598 E.00788
G1 X87.431 Y70.445 E.00375
G1 X87.984 Y69.835 E.01619
M204 S10000
G1 X88.76 Y69.937 F18000
; FEATURE: Gap infill
; LINE_WIDTH: 0.101151
G1 F1500
M204 S6000
G1 X88.88 Y69.844 E.00057
G1 X89.131 Y69.789 E.00097
; WIPE_START
G1 X88.88 Y69.844 E-.23847
G1 X88.76 Y69.937 E-.14153
; WIPE_END
M73 P54 R15
G1 E-.02 F1800
M204 S10000
G1 X90.783 Y69.763 Z1.32 F18000
G1 Z.92
G1 E.4 F1800
; LINE_WIDTH: 0.103849
G1 F1500
M204 S6000
G1 X91.05 Y69.813 E.00106
; LINE_WIDTH: 0.124143
G1 X91.147 Y69.875 E.00057
; LINE_WIDTH: 0.0938706
G1 X91.221 Y69.93 E.00031
; WIPE_START
G1 X91.147 Y69.875 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X83.587 Y68.829 Z1.32 F18000
G1 X58.831 Y65.407 Z1.32
G1 Z.92
G1 E.4 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F1500
M204 S6000
G1 X60.528 Y65.407 E.03592
G1 X60.868 Y65.641 E.00872
G1 X61.778 Y66.042 E.02106
G1 X62.233 Y66.185 E.0101
G1 X62.688 Y66.148 E.00967
G1 X62.994 Y65.407 E.01696
G1 X67.811 Y65.407 E.10197
G1 X68.151 Y65.641 E.00872
G1 X69.061 Y66.042 E.02106
G1 X69.516 Y66.185 E.0101
G1 X69.972 Y66.148 E.00967
G1 X70.277 Y65.407 E.01696
G1 X75.094 Y65.407 E.10197
G1 X75.434 Y65.641 E.00872
G1 X76.344 Y66.042 E.02106
G1 X76.8 Y66.185 E.0101
G1 X77.255 Y66.148 E.00967
G1 X77.56 Y65.407 E.01696
G1 X82.377 Y65.407 E.10197
G1 X82.717 Y65.641 E.00872
G1 X83.627 Y66.042 E.02106
G1 X84.083 Y66.185 E.0101
G1 X84.538 Y66.148 E.00967
G1 X84.843 Y65.407 E.01696
G1 X89.661 Y65.407 E.10197
G1 X90 Y65.641 E.00872
G1 X90.911 Y66.042 E.02106
G1 X91.366 Y66.185 E.0101
G1 X91.821 Y66.148 E.00967
G1 X92.126 Y65.407 E.01696
G1 X96.944 Y65.407 E.10197
G1 X97.283 Y65.641 E.00872
G1 X98.194 Y66.042 E.02106
G1 X98.649 Y66.185 E.0101
G1 X99.104 Y66.148 E.00967
G1 X99.409 Y65.407 E.01696
G1 X104.227 Y65.407 E.10197
G1 X104.566 Y65.641 E.00872
G1 X105.477 Y66.042 E.02106
G1 X105.932 Y66.185 E.0101
G1 X106.387 Y66.148 E.00967
G1 X106.692 Y65.407 E.01696
G1 X111.51 Y65.407 E.10197
G1 X111.85 Y65.641 E.00872
G1 X112.76 Y66.042 E.02106
G1 X113.215 Y66.185 E.0101
G1 X113.67 Y66.148 E.00967
G1 X113.976 Y65.407 E.01696
G1 X118.793 Y65.407 E.10197
G1 X119.133 Y65.641 E.00872
G1 X120.043 Y66.042 E.02106
G1 X120.498 Y66.185 E.0101
G1 X120.894 Y66.153 E.00839
G1 X120.894 Y66.714 E.01188
G1 X120.498 Y67.674 E.02197
G1 X120.043 Y68.486 E.0197
G1 X119.941 Y68.594 E.00315
G1 X116.806 Y68.594 E.06635
G1 X116.402 Y67.872 E.01752
G1 X115.946 Y67.389 E.01405
G1 X115.491 Y67.076 E.01169
G1 X114.581 Y66.675 E.02106
G1 X114.126 Y66.532 E.0101
G1 X113.67 Y66.569 E.00967
G1 X113.215 Y67.674 E.0253
G1 X112.76 Y68.486 E.0197
G1 X112.658 Y68.594 E.00315
G1 X109.523 Y68.594 E.06635
G1 X109.118 Y67.872 E.01752
G1 X108.663 Y67.389 E.01405
G1 X108.208 Y67.076 E.01169
G1 X107.298 Y66.675 E.02106
G1 X106.842 Y66.532 E.0101
G1 X106.387 Y66.569 E.00967
G1 X105.932 Y67.674 E.0253
G1 X105.477 Y68.486 E.0197
G1 X105.375 Y68.594 E.00315
G1 X102.24 Y68.594 E.06635
G1 X101.835 Y67.872 E.01752
G1 X101.38 Y67.389 E.01405
G1 X100.925 Y67.076 E.01169
G1 X100.015 Y66.675 E.02106
G1 X99.559 Y66.532 E.0101
G1 X99.104 Y66.569 E.00967
G1 X98.649 Y67.674 E.0253
G1 X98.194 Y68.486 E.0197
G1 X98.092 Y68.594 E.00315
G1 X94.957 Y68.594 E.06635
G1 X94.552 Y67.872 E.01752
G1 X94.097 Y67.389 E.01405
G1 X93.642 Y67.076 E.01169
G1 X92.731 Y66.675 E.02106
G1 X92.276 Y66.532 E.0101
G1 X91.821 Y66.569 E.00967
G1 X91.366 Y67.674 E.0253
G1 X90.911 Y68.486 E.0197
G1 X90.809 Y68.594 E.00315
G1 X87.674 Y68.594 E.06635
G1 X87.269 Y67.872 E.01752
G1 X86.814 Y67.389 E.01405
G1 X86.359 Y67.076 E.01169
G1 X85.448 Y66.675 E.02106
G1 X84.993 Y66.532 E.0101
G1 X84.538 Y66.569 E.00967
G1 X84.083 Y67.674 E.0253
G1 X83.627 Y68.486 E.0197
G1 X83.526 Y68.594 E.00315
G1 X80.391 Y68.594 E.06635
G1 X79.986 Y67.872 E.01752
G1 X79.531 Y67.389 E.01405
G1 X79.076 Y67.076 E.01169
G1 X78.165 Y66.675 E.02106
G1 X77.71 Y66.532 E.0101
G1 X77.255 Y66.569 E.00967
G1 X76.8 Y67.674 E.0253
G1 X76.344 Y68.486 E.0197
G1 X76.242 Y68.594 E.00315
G1 X73.108 Y68.594 E.06635
G1 X72.703 Y67.872 E.01752
G1 X72.248 Y67.389 E.01405
G1 X71.792 Y67.076 E.01169
G1 X70.882 Y66.675 E.02106
G1 X70.427 Y66.532 E.0101
G1 X69.972 Y66.569 E.00967
G1 X69.516 Y67.674 E.0253
G1 X69.061 Y68.486 E.0197
G1 X68.959 Y68.594 E.00315
G1 X65.824 Y68.594 E.06635
G1 X65.42 Y67.872 E.01752
G1 X64.964 Y67.389 E.01405
G1 X64.509 Y67.076 E.01169
G1 X63.599 Y66.675 E.02106
G1 X63.144 Y66.532 E.0101
G1 X62.688 Y66.569 E.00967
G1 X62.233 Y67.674 E.0253
G1 X61.778 Y68.486 E.0197
G1 X61.676 Y68.594 E.00315
G1 X58.541 Y68.594 E.06635
G1 X58.137 Y67.872 E.01752
G1 X57.681 Y67.389 E.01405
G1 X57.226 Y67.076 E.01169
G1 X56.316 Y66.675 E.02106
G1 X55.861 Y66.532 E.0101
G1 X55.405 Y66.569 E.00967
G1 X54.95 Y67.674 E.0253
G1 X54.606 Y68.288 E.01488
G1 X54.606 Y66.077 E.04679
G1 X54.95 Y66.185 E.00763
G1 X55.405 Y66.148 E.00967
G1 X55.71 Y65.407 E.01696
G1 X57.407 Y65.407 E.03592
; CHANGE_LAYER
; Z_HEIGHT: 1.04
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F1500
G1 X55.71 Y65.407 E-.32243
G1 X55.595 Y65.687 E-.05757
; WIPE_END
G1 E-.02 F1800
; stop printing object, unique label id: 8
M625
; layer num/total_layer_count: 8/51
; update layer progress
M73 L8
M991 S0 P7 ;notify layer change
; OBJECT_ID: 12
; start printing object, unique label id: 12
M624 AgAAAAAAAAA=
M204 S10000
G17
G3 Z1.32 I-.834 J.886 P1  F18000
G1 X91.677 Y99.657 Z1.32
G1 Z1.04
G1 E.4 F1800
; FEATURE: Inner wall
G1 F1500
M204 S500
G1 X90.098 Y99.657 E.03342
G1 X90.602 Y100.215 E.01591
G1 X90.231 Y100.164 E.00792
G1 X89.905 Y100.157 E.00691
G1 X89.394 Y100.219 E.0109
G1 X89.903 Y99.657 E.01605
G1 X54.243 Y99.657 E.75476
G1 X54.243 Y95.744 E.08282
G1 X121.843 Y95.744 E1.43081
G1 X121.843 Y94.344 E.02963
G1 X125.757 Y94.344 E.08282
G1 X125.757 Y101.057 E.14209
G1 X121.843 Y101.057 E.08282
G1 X121.843 Y99.657 E.02963
G1 X91.737 Y99.657 E.63724
; WIPE_START
M204 S6000
G1 X90.098 Y99.657 E-.31143
G1 X90.34 Y99.925 E-.06857
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X91.572 Y101.108 Z1.44 F18000
G1 Z1.04
G1 E.4 F1800
G1 F1500
M204 S500
G1 X91.634 Y101.152 E.00161
G1 X91.874 Y101.368 E.00683
G1 X92.16 Y101.717 E.00955
G1 X92.326 Y101.994 E.00683
G1 X92.457 Y102.289 E.00683
G1 X92.58 Y102.733 E.00975
G1 X92.622 Y103.201 E.00995
G1 X92.579 Y103.673 E.01004
G1 X92.432 Y104.181 E.01119
G1 X92.17 Y104.673 E.01179
G1 X91.868 Y105.041 E.01008
G1 X91.506 Y105.347 E.01004
G1 X91.045 Y105.605 E.01118
G1 X90.513 Y105.772 E.01179
G1 X90.035 Y105.823 E.01018
G1 X89.528 Y105.778 E.01077
G1 X89.263 Y105.715 E.00576
M73 P55 R15
G1 X88.961 Y105.607 E.00678
G1 X88.556 Y105.389 E.00975
G1 X88.188 Y105.096 E.00995
G1 X87.876 Y104.739 E.01004
G1 X87.611 Y104.281 E.01119
G1 X87.436 Y103.752 E.0118
G1 X87.381 Y103.289 E.00988
G1 X87.39 Y102.966 E.00683
G1 X87.438 Y102.647 E.00683
G1 X87.574 Y102.207 E.00975
G1 X87.791 Y101.789 E.00995
G1 X88.081 Y101.414 E.01004
G1 X88.464 Y101.079 E.01078
G1 X88.692 Y100.931 E.00576
G1 X88.978 Y100.787 E.00679
G1 X89.42 Y100.644 E.00984
G1 X89.926 Y100.582 E.01078
G1 X90.198 Y100.588 E.00576
G1 X90.516 Y100.631 E.00678
G1 X90.958 Y100.76 E.00975
G1 X91.37 Y100.966 E.00975
G1 X91.523 Y101.074 E.00396
M204 S250
G1 X91.336 Y101.443 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X91.378 Y101.473 E.00101
G1 X91.577 Y101.652 E.00526
G1 X91.825 Y101.953 E.00767
G1 X91.962 Y102.183 E.00526
G1 X92.071 Y102.427 E.00526
G1 X92.175 Y102.806 E.00773
G1 X92.211 Y103.201 E.00779
G1 X92.175 Y103.597 E.00782
G1 X92.05 Y104.026 E.00879
G1 X91.828 Y104.444 E.00932
G1 X91.575 Y104.752 E.00784
G1 X91.271 Y105.01 E.00783
G1 X90.882 Y105.228 E.00878
G1 X90.429 Y105.37 E.00932
G1 X90.032 Y105.412 E.00787
G1 X89.593 Y105.373 E.00865
G1 X89.379 Y105.322 E.00432
G1 X89.128 Y105.232 E.00525
G1 X88.782 Y105.046 E.00773
G1 X88.472 Y104.799 E.00779
G1 X88.21 Y104.499 E.00783
G1 X87.987 Y104.113 E.00878
G1 X87.838 Y103.663 E.00933
G1 X87.791 Y103.27 E.00778
G1 X87.799 Y103.003 E.00526
G1 X87.838 Y102.738 E.00526
G1 X87.954 Y102.362 E.00774
G1 X88.137 Y102.011 E.00779
G1 X88.38 Y101.696 E.00782
G1 X88.711 Y101.406 E.00866
G1 X88.895 Y101.286 E.00432
G1 X89.134 Y101.167 E.00525
G1 X89.509 Y101.045 E.00776
G1 X89.946 Y100.992 E.00866
G1 X90.166 Y100.997 E.00432
G1 X90.43 Y101.033 E.00525
G1 X90.808 Y101.143 E.00773
G1 X91.159 Y101.319 E.00773
G1 X91.287 Y101.408 E.00307
; WIPE_START
M204 S6000
G1 X91.378 Y101.473 E-.02119
G1 X91.577 Y101.652 E-.05082
G1 X91.825 Y101.953 E-.07408
G1 X91.962 Y102.183 E-.05085
G1 X92.071 Y102.427 E-.05084
G1 X92.175 Y102.806 E-.07472
G1 X92.202 Y103.108 E-.0575
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X99.794 Y102.321 Z1.44 F18000
G1 X121.419 Y100.082 Z1.44
G1 Z1.04
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X91.054 Y100.082 E.64271
G1 X92.253 Y101.407 E.03783
G1 X92.53 Y101.826 E.01065
G1 X92.699 Y102.204 E.00875
G1 X92.828 Y102.654 E.00991
G1 X92.879 Y103.152 E.01061
G1 X92.864 Y103.501 E.00738
G1 X92.767 Y103.998 E.01071
G1 X92.622 Y104.387 E.00881
G1 X92.399 Y104.793 E.00979
G1 X92.082 Y105.19 E.01076
G1 X91.747 Y105.496 E.00959
G1 X91.408 Y105.713 E.00853
G1 X91.221 Y105.799 E.00436
G1 X91.032 Y105.887 E.00439
G1 X90.589 Y106.02 E.0098
G1 X90.152 Y106.081 E.00934
G1 X89.738 Y106.069 E.00877
G1 X89.507 Y106.037 E.00493
G1 X89.235 Y105.977 E.00589
G1 X88.907 Y105.865 E.00735
G1 X88.6 Y105.717 E.0072
G1 X88.255 Y105.489 E.00876
G1 X87.912 Y105.184 E.00971
G1 X87.702 Y104.937 E.00686
G1 X87.454 Y104.542 E.00987
G1 X87.288 Y104.168 E.00866
G1 X87.169 Y103.733 E.00955
G1 X87.123 Y103.318 E.00883
G1 X87.129 Y102.98 E.00716
G1 X87.16 Y102.698 E.006
G1 X87.286 Y102.244 E.00997
G1 X87.475 Y101.816 E.00991
G1 X87.753 Y101.4 E.01061
G1 X88.946 Y100.082 E.03763
G1 X53.819 Y100.082 E.74349
G1 X53.819 Y95.32 E.10078
G1 X121.419 Y95.32 E1.43081
G1 X121.419 Y93.92 E.02963
G1 X126.181 Y93.92 E.10078
G1 X126.181 Y101.482 E.16005
G1 X121.419 Y101.482 E.10078
G1 X121.419 Y100.142 E.02836
M204 S250
G1 X121.01 Y100.491 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X91.976 Y100.491 E.57107
G1 X92.569 Y101.145 E.01737
G1 X92.892 Y101.634 E.01152
G1 X93.085 Y102.063 E.00926
G1 X93.227 Y102.564 E.01023
G1 X93.289 Y103.146 E.01151
G1 X93.272 Y103.54 E.00777
G1 X93.16 Y104.116 E.01154
G1 X92.995 Y104.558 E.00928
G1 X92.746 Y105.013 E.0102
G1 X92.379 Y105.472 E.01156
G1 X91.936 Y105.86 E.01158
G1 X91.605 Y106.072 E.00774
G1 X91.178 Y106.27 E.00926
G1 X90.681 Y106.419 E.0102
G1 X90.099 Y106.489 E.01153
G1 X89.703 Y106.477 E.00779
G1 X89.125 Y106.372 E.01157
G1 X88.751 Y106.244 E.00776
G1 X88.398 Y106.074 E.00772
G1 X88.005 Y105.814 E.00926
G1 X87.619 Y105.47 E.01017
G1 X87.367 Y105.173 E.00766
G1 X87.092 Y104.735 E.01017
G1 X86.902 Y104.306 E.00923
G1 X86.777 Y103.854 E.00923
G1 X86.713 Y103.34 E.01017
G1 X86.72 Y102.949 E.00771
G1 X86.773 Y102.56 E.00771
G1 X86.9 Y102.106 E.00926
G1 X87.109 Y101.63 E.01023
G1 X87.204 Y101.467 E.00371
G1 X87.433 Y101.143 E.00781
G1 X88.024 Y100.491 E.01731
G1 X53.41 Y100.491 E.68082
G1 X53.41 Y94.911 E.10975
G1 X121.01 Y94.911 E1.32963
G1 X121.01 Y93.511 E.02754
G1 X126.59 Y93.511 E.10975
G1 X126.59 Y101.891 E.16483
G1 X121.01 Y101.891 E.10975
G1 X121.01 Y100.551 E.02636
; WIPE_START
M204 S6000
G1 X119.01 Y100.547 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G17
G3 Z1.44 I1.217 J0 P1  F18000
; stop printing object, unique label id: 12
M625
; object ids of layer 8 start: 8,12
M624 AwAAAAAAAAA=
;===================== date: 20250206 =====================

; don't support timelapse gcode in spiral_mode and by object sequence for I3 structure printer
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
G92 E0
G1 Z1.44
G1 X0 Y85.35 ; move to safe pos
G1 X-13.0 F3000 ; move to safe pos
M400
M1004 S5 P1  ; external shutter
M400 P300
M971 S11 C11 O0
G92 E0
G1 X0 F18000
M623

; SKIPTYPE: head_wrap_detect
M622.1 S1
M1002 judge_flag g39_3rd_layer_detect_flag
M622 J1
    ; enable nozzle clog detect at 3rd layer
    


    M622.1 S1
    M1002 judge_flag g39_detection_flag
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




; object ids of this layer8 end: 8,12
M625
; start printing object, unique label id: 12
M624 AgAAAAAAAAA=
G1 X122.222 Y95.956
G1 Z1.04
G1 E.4 F1800
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.378272
G1 F1200
M204 S6000
G1 X122.208 Y96.025 E.00124
; LINE_WIDTH: 0.394966
G1 X122.194 Y96.094 E.0013
G1 X122.056 Y96.123 E.00259
; LINE_WIDTH: 0.365752
G1 X54.789 Y96.123 E1.14103
; LINE_WIDTH: 0.378272
G1 X54.72 Y96.137 E.00124
; LINE_WIDTH: 0.394966
G1 X54.651 Y96.151 E.0013
G1 X54.622 Y96.289 E.00259
; LINE_WIDTH: 0.365752
G1 X54.622 Y99.112 E.04788
; LINE_WIDTH: 0.378272
G1 X54.636 Y99.181 E.00124
; LINE_WIDTH: 0.394966
G1 X54.651 Y99.25 E.0013
G1 X54.789 Y99.279 E.00259
; LINE_WIDTH: 0.365752
G1 X122.056 Y99.279 E1.14103
; LINE_WIDTH: 0.378272
G1 X122.125 Y99.293 E.00124
; LINE_WIDTH: 0.394966
G1 X122.194 Y99.307 E.0013
G1 X122.222 Y99.445 E.00259
; LINE_WIDTH: 0.365752
G1 X122.222 Y100.512 E.0181
; LINE_WIDTH: 0.378272
G1 X122.236 Y100.581 E.00124
; LINE_WIDTH: 0.394966
G1 X122.251 Y100.65 E.0013
G1 X122.389 Y100.679 E.00259
; LINE_WIDTH: 0.365752
G1 X125.211 Y100.679 E.04788
; LINE_WIDTH: 0.378272
G1 X125.28 Y100.664 E.00124
; LINE_WIDTH: 0.394966
G1 X125.349 Y100.65 E.0013
G1 X125.378 Y100.512 E.00259
; LINE_WIDTH: 0.365752
G1 X125.378 Y94.889 E.09538
; LINE_WIDTH: 0.378272
G1 X125.364 Y94.82 E.00124
; LINE_WIDTH: 0.394966
G1 X125.349 Y94.751 E.0013
M73 P56 R15
G1 X125.211 Y94.723 E.00259
; LINE_WIDTH: 0.365752
G1 X122.389 Y94.723 E.04788
; LINE_WIDTH: 0.378272
G1 X122.32 Y94.737 E.00124
; LINE_WIDTH: 0.394966
G1 X122.251 Y94.751 E.0013
G1 X122.222 Y94.889 E.00259
; LINE_WIDTH: 0.365752
G1 X122.222 Y95.896 E.01708
; WIPE_START
G1 X122.222 Y94.889 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G17
G3 Z1.44 I-.883 J.838 P1  F18000
G1 X124.999 Y97.816 Z1.44
G1 Z1.04
G1 E.4 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F1500
M204 S6000
G1 X124.999 Y99.513 E.03592
G1 X124.595 Y99.25 E.0102
G1 X124.14 Y98.49 E.01875
G1 X123.685 Y97.827 E.01702
G1 X123.23 Y97.403 E.01318
G1 X122.774 Y97.127 E.01126
G1 X121.864 Y96.826 E.0203
G1 X121.409 Y96.813 E.00964
G1 X120.954 Y97.108 E.01149
G1 X120.498 Y97.868 E.01875
G1 X120.043 Y98.531 E.01702
G1 X119.648 Y98.9 E.01144
G1 X117.102 Y98.9 E.05388
G1 X116.857 Y98.49 E.01011
G1 X116.402 Y97.827 E.01702
G1 X115.946 Y97.403 E.01318
G1 X115.491 Y97.127 E.01126
G1 X114.581 Y96.826 E.0203
G1 X114.126 Y96.813 E.00964
G1 X113.67 Y97.108 E.01149
G1 X113.215 Y97.868 E.01875
G1 X112.76 Y98.531 E.01702
G1 X112.365 Y98.9 E.01144
G1 X109.819 Y98.9 E.05388
G1 X109.574 Y98.49 E.01011
G1 X109.118 Y97.827 E.01702
G1 X108.663 Y97.403 E.01318
G1 X108.208 Y97.127 E.01126
G1 X107.298 Y96.826 E.0203
G1 X106.842 Y96.813 E.00964
G1 X106.387 Y97.108 E.01149
G1 X105.932 Y97.868 E.01875
G1 X105.477 Y98.531 E.01702
G1 X105.082 Y98.9 E.01144
G1 X102.536 Y98.9 E.05388
G1 X102.291 Y98.49 E.01011
G1 X101.835 Y97.827 E.01702
G1 X101.38 Y97.403 E.01318
G1 X100.925 Y97.127 E.01126
G1 X100.015 Y96.826 E.0203
G1 X99.559 Y96.813 E.00964
G1 X99.104 Y97.108 E.01149
G1 X98.649 Y97.868 E.01875
G1 X98.194 Y98.531 E.01702
G1 X97.798 Y98.9 E.01144
G1 X95.253 Y98.9 E.05388
G1 X95.007 Y98.49 E.01011
G1 X94.552 Y97.827 E.01702
G1 X94.097 Y97.403 E.01318
G1 X93.642 Y97.127 E.01126
G1 X92.731 Y96.826 E.0203
G1 X92.276 Y96.813 E.00964
G1 X91.821 Y97.108 E.01149
G1 X91.366 Y97.868 E.01875
G1 X90.911 Y98.531 E.01702
G1 X90.515 Y98.9 E.01144
G1 X87.97 Y98.9 E.05388
G1 X87.724 Y98.49 E.01011
G1 X87.269 Y97.827 E.01702
G1 X86.814 Y97.403 E.01318
G1 X86.359 Y97.127 E.01126
G1 X85.448 Y96.826 E.0203
G1 X84.993 Y96.813 E.00964
G1 X84.538 Y97.108 E.01149
G1 X84.083 Y97.868 E.01875
G1 X83.627 Y98.531 E.01702
G1 X83.232 Y98.9 E.01144
G1 X80.686 Y98.9 E.05388
G1 X80.441 Y98.49 E.01011
G1 X79.986 Y97.827 E.01702
G1 X79.531 Y97.403 E.01318
G1 X79.076 Y97.127 E.01126
G1 X78.165 Y96.826 E.0203
G1 X77.71 Y96.813 E.00964
G1 X77.255 Y97.108 E.01149
G1 X76.8 Y97.868 E.01875
G1 X76.344 Y98.531 E.01702
G1 X75.949 Y98.9 E.01144
G1 X73.403 Y98.9 E.05388
G1 X73.158 Y98.49 E.01011
G1 X72.703 Y97.827 E.01702
G1 X72.248 Y97.403 E.01318
G1 X71.792 Y97.127 E.01126
G1 X70.882 Y96.826 E.0203
G1 X70.427 Y96.813 E.00964
G1 X69.972 Y97.108 E.01149
G1 X69.516 Y97.868 E.01875
G1 X69.061 Y98.531 E.01702
G1 X68.666 Y98.9 E.01144
G1 X66.12 Y98.9 E.05388
G1 X65.875 Y98.49 E.01011
G1 X65.42 Y97.827 E.01702
G1 X64.964 Y97.403 E.01318
G1 X64.509 Y97.127 E.01126
G1 X63.599 Y96.826 E.0203
G1 X63.144 Y96.813 E.00964
G1 X62.688 Y97.108 E.01149
G1 X62.233 Y97.868 E.01875
G1 X61.778 Y98.531 E.01702
G1 X61.383 Y98.9 E.01144
G1 X58.837 Y98.9 E.05388
G1 X58.592 Y98.49 E.01011
G1 X58.137 Y97.827 E.01702
G1 X57.681 Y97.403 E.01318
G1 X57.226 Y97.127 E.01126
G1 X56.316 Y96.826 E.0203
G1 X55.861 Y96.813 E.00964
G1 X55.405 Y97.108 E.01149
G1 X55.001 Y97.784 E.01667
G1 X55.001 Y98.9 E.02363
G1 X55.581 Y98.9 E.01229
; WIPE_START
G1 X55.001 Y98.9 E-.1103
G1 X55.001 Y97.784 E-.21213
G1 X55.156 Y97.524 E-.05757
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X62.756 Y98.227 Z1.44 F18000
G1 X88.763 Y100.633 Z1.44
G1 Z1.04
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.101595
G1 F1500
M204 S6000
G1 X88.879 Y100.545 E.00055
G1 X89.127 Y100.49 E.00096
; WIPE_START
G1 X88.879 Y100.545 E-.24147
G1 X88.763 Y100.633 E-.13853
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X90.888 Y100.493 Z1.44 F18000
G1 Z1.04
G1 E.4 F1800
; LINE_WIDTH: 0.0995903
G1 F1500
M204 S6000
G1 X91.124 Y100.55 E.0009
G1 X91.246 Y100.642 E.00056
; OBJECT_ID: 8
; WIPE_START
G1 X91.124 Y100.55 E-.14634
G1 X90.888 Y100.493 E-.23366
; WIPE_END
G1 E-.02 F1800
; stop printing object, unique label id: 12
M625
; start printing object, unique label id: 8
M624 AQAAAAAAAAA=
M204 S10000
G1 X91.281 Y92.871 Z1.44 F18000
G1 X92.388 Y71.433 Z1.44
G1 Z1.04
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X92.457 Y71.589 E.0036
G1 X92.58 Y72.033 E.00975
G1 X92.622 Y72.505 E.01004
G1 X92.57 Y73.011 E.01077
G1 X92.503 Y73.275 E.00576
G1 X92.391 Y73.575 E.00678
G1 X92.166 Y73.978 E.00975
G1 X91.868 Y74.341 E.00995
G1 X91.506 Y74.647 E.01004
G1 X91.045 Y74.905 E.01118
G1 X90.513 Y75.072 E.01179
G1 X90.039 Y75.122 E.01009
G1 X89.58 Y75.088 E.00975
G1 X89.265 Y75.016 E.00683
G1 X88.961 Y74.907 E.00683
G1 X88.556 Y74.689 E.00975
G1 X88.188 Y74.396 E.00995
G1 X87.876 Y74.039 E.01004
G1 X87.611 Y73.581 E.01119
G1 X87.436 Y73.052 E.0118
G1 X87.381 Y72.589 E.00988
G1 X87.39 Y72.266 E.00683
G1 X87.438 Y71.947 E.00683
G1 X87.574 Y71.507 E.00975
G1 X87.791 Y71.089 E.00995
G1 X88.081 Y70.714 E.01004
G1 X88.464 Y70.379 E.01078
G1 X88.692 Y70.231 E.00576
G1 X88.978 Y70.087 E.00679
G1 X89.42 Y69.944 E.00984
G1 X89.926 Y69.882 E.01078
G1 X90.198 Y69.888 E.00576
G1 X90.516 Y69.931 E.00678
G1 X90.958 Y70.06 E.00975
G1 X91.37 Y70.266 E.00975
G1 X91.634 Y70.452 E.00683
G1 X91.874 Y70.668 E.00683
G1 X92.16 Y71.017 E.00955
G1 X92.326 Y71.294 E.00683
G1 X92.364 Y71.379 E.00197
M204 S250
G1 X92.014 Y71.6 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X92.071 Y71.727 E.00274
G1 X92.175 Y72.106 E.00773
G1 X92.211 Y72.502 E.00782
G1 X92.166 Y72.94 E.00866
G1 X92.112 Y73.153 E.00432
G1 X92.018 Y73.403 E.00525
G1 X91.827 Y73.746 E.00773
G1 X91.575 Y74.052 E.0078
G1 X91.271 Y74.31 E.00783
G1 X90.882 Y74.528 E.00878
G1 X90.429 Y74.67 E.00932
G1 X90.033 Y74.711 E.00784
G1 X89.641 Y74.682 E.00773
G1 X89.38 Y74.622 E.00526
G1 X89.128 Y74.532 E.00526
G1 X88.782 Y74.346 E.00773
G1 X88.472 Y74.099 E.00779
G1 X88.21 Y73.799 E.00783
G1 X87.987 Y73.413 E.00878
G1 X87.838 Y72.963 E.00933
G1 X87.791 Y72.57 E.00778
G1 X87.799 Y72.303 E.00526
G1 X87.838 Y72.038 E.00526
G1 X87.954 Y71.662 E.00774
G1 X88.137 Y71.311 E.00779
G1 X88.38 Y70.996 E.00782
G1 X88.711 Y70.706 E.00866
G1 X88.895 Y70.586 E.00432
G1 X89.134 Y70.467 E.00525
G1 X89.509 Y70.345 E.00776
G1 X89.946 Y70.292 E.00866
G1 X90.166 Y70.297 E.00432
G1 X90.43 Y70.333 E.00525
G1 X90.808 Y70.443 E.00773
G1 X91.159 Y70.619 E.00773
G1 X91.378 Y70.773 E.00526
G1 X91.577 Y70.952 E.00526
G1 X91.825 Y71.253 E.00767
G1 X91.962 Y71.483 E.00526
G1 X91.99 Y71.545 E.00134
; WIPE_START
M204 S6000
G1 X92.071 Y71.727 E-.03785
G1 X92.175 Y72.106 E-.07472
G1 X92.211 Y72.502 E-.07557
G1 X92.166 Y72.94 E-.08361
G1 X92.112 Y73.153 E-.04176
G1 X92.018 Y73.403 E-.05067
G1 X91.978 Y73.475 E-.01583
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X99.511 Y72.25 Z1.44 F18000
G1 X121.257 Y68.711 Z1.44
G1 Z1.04
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X121.257 Y68.957 E.00522
G1 X90.098 Y68.957 E.65951
G1 X90.602 Y69.515 E.01591
G1 X90.231 Y69.464 E.00792
G1 X89.905 Y69.457 E.00691
G1 X89.394 Y69.519 E.0109
G1 X89.903 Y68.957 E.01605
G1 X54.243 Y68.957 E.75476
G1 X54.243 Y65.044 E.08282
G1 X121.257 Y65.044 E1.41839
G1 X121.257 Y68.651 E.07633
; WIPE_START
M204 S6000
G1 X121.257 Y68.957 E-.05824
G1 X119.563 Y68.957 E-.32176
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X125.51 Y69.12 Z1.44 F18000
G1 Z1.04
G1 E.4 F1800
G1 F1500
M204 S500
G1 X121.681 Y69.12 E.08105
G1 X121.681 Y64.882 E.08971
G1 X125.919 Y64.882 E.08971
G1 X125.919 Y69.12 E.08971
G1 X125.57 Y69.12 E.00739
M204 S250
G1 X125.51 Y68.711 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X122.09 Y68.711 E.06727
G1 X122.09 Y65.291 E.06727
G1 X125.51 Y65.291 E.06727
G1 X125.51 Y68.651 E.06609
; WIPE_START
M204 S6000
G1 X123.51 Y68.686 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X115.879 Y68.839 Z1.44 F18000
G1 X88.946 Y69.382 Z1.44
G1 Z1.04
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X53.819 Y69.382 E.74349
G1 X53.819 Y64.62 E.10078
G1 X126.181 Y64.62 E1.53159
G1 X126.181 Y69.382 E.10078
G1 X91.054 Y69.382 E.74349
G1 X92.253 Y70.706 E.03783
G1 X92.53 Y71.126 E.01065
G1 X92.699 Y71.504 E.00875
G1 X92.828 Y71.954 E.00991
G1 X92.852 Y72.099 E.00312
G1 X92.882 Y72.395 E.00628
G1 X92.864 Y72.801 E.00861
G1 X92.829 Y73.031 E.00493
G1 X92.767 Y73.298 E.00579
G1 X92.622 Y73.687 E.0088
G1 X92.399 Y74.093 E.00979
M73 P57 R15
G1 X92.113 Y74.461 E.00987
G1 X91.779 Y74.763 E.00951
G1 X91.402 Y75.015 E.00961
G1 X91.032 Y75.187 E.00862
G1 X90.589 Y75.32 E.0098
G1 X90.088 Y75.379 E.01067
G1 X89.738 Y75.369 E.00743
G1 X89.235 Y75.277 E.01081
G1 X88.907 Y75.165 E.00735
G1 X88.6 Y75.017 E.0072
G1 X88.255 Y74.789 E.00876
G1 X87.912 Y74.484 E.00971
G1 X87.702 Y74.237 E.00686
G1 X87.454 Y73.842 E.00987
G1 X87.288 Y73.468 E.00866
G1 X87.169 Y73.033 E.00955
G1 X87.123 Y72.618 E.00883
G1 X87.129 Y72.28 E.00716
G1 X87.16 Y71.998 E.006
G1 X87.286 Y71.544 E.00997
G1 X87.475 Y71.116 E.00991
G1 X87.753 Y70.7 E.01061
G1 X88.906 Y69.426 E.03636
M204 S250
G1 X88.024 Y69.791 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X53.41 Y69.791 E.68082
G1 X53.41 Y64.211 E.10975
G1 X126.59 Y64.211 E1.43939
G1 X126.59 Y69.791 E.10975
M73 P57 R14
G1 X91.976 Y69.791 E.68082
G1 X92.569 Y70.445 E.01737
G1 X92.892 Y70.934 E.01152
G1 X93.085 Y71.363 E.00926
G1 X93.227 Y71.864 E.01023
G1 X93.289 Y72.446 E.01151
G1 X93.272 Y72.84 E.00777
G1 X93.16 Y73.416 E.01154
G1 X92.995 Y73.858 E.00928
G1 X92.746 Y74.313 E.0102
G1 X92.381 Y74.77 E.0115
G1 X92.031 Y75.086 E.00928
G1 X91.603 Y75.373 E.01014
G1 X91.178 Y75.57 E.00922
G1 X90.681 Y75.719 E.0102
G1 X90.099 Y75.789 E.01153
G1 X89.703 Y75.777 E.00779
G1 X89.125 Y75.672 E.01157
G1 X88.751 Y75.544 E.00776
G1 X88.398 Y75.374 E.00772
G1 X88.005 Y75.114 E.00926
G1 X87.619 Y74.77 E.01017
G1 X87.367 Y74.473 E.00766
G1 X87.092 Y74.035 E.01017
G1 X86.902 Y73.606 E.00923
G1 X86.777 Y73.154 E.00923
G1 X86.713 Y72.64 E.01017
G1 X86.72 Y72.249 E.00771
G1 X86.773 Y71.86 E.00771
G1 X86.9 Y71.406 E.00926
G1 X87.109 Y70.93 E.01023
G1 X87.204 Y70.767 E.00371
G1 X87.433 Y70.443 E.00781
G1 X87.984 Y69.835 E.01613
M204 S10000
G1 X88.763 Y69.933 F18000
; FEATURE: Gap infill
; LINE_WIDTH: 0.101593
G1 F1500
M204 S6000
G1 X88.879 Y69.845 E.00055
G1 X89.127 Y69.79 E.00096
; WIPE_START
G1 X88.879 Y69.845 E-.24147
G1 X88.763 Y69.933 E-.13853
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X90.887 Y69.793 Z1.44 F18000
G1 Z1.04
G1 E.4 F1800
; LINE_WIDTH: 0.0996165
G1 F1500
M204 S6000
G1 X91.124 Y69.85 E.0009
G1 X91.246 Y69.942 E.00056
; WIPE_START
G1 X91.124 Y69.85 E-.14628
G1 X90.887 Y69.793 E-.23372
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X98.439 Y68.686 Z1.44 F18000
G1 X120.711 Y65.423 Z1.44
G1 Z1.04
G1 E.4 F1800
; FEATURE: Floating vertical shell
; LINE_WIDTH: 0.365752
G1 F1200
M204 S6000
G1 X54.789 Y65.423 E1.11823
; LINE_WIDTH: 0.378272
G1 X54.72 Y65.437 E.00124
; LINE_WIDTH: 0.394966
G1 X54.651 Y65.451 E.0013
G1 X54.622 Y65.589 E.00259
; LINE_WIDTH: 0.365752
G1 X54.622 Y68.412 E.04788
; LINE_WIDTH: 0.378272
G1 X54.636 Y68.481 E.00124
; LINE_WIDTH: 0.394966
G1 X54.651 Y68.55 E.0013
G1 X54.789 Y68.579 E.00259
; LINE_WIDTH: 0.365752
G1 X120.711 Y68.579 E1.11823
; LINE_WIDTH: 0.378272
G1 X120.78 Y68.564 E.00124
; LINE_WIDTH: 0.394966
G1 X120.849 Y68.55 E.0013
G1 X120.878 Y68.412 E.00259
; LINE_WIDTH: 0.365752
G1 X120.878 Y65.589 E.04788
; LINE_WIDTH: 0.378272
G1 X120.864 Y65.52 E.00124
; LINE_WIDTH: 0.396621
G1 X120.849 Y65.451 E.0013
G1 X120.77 Y65.435 E.0015
; WIPE_START
G1 X120.849 Y65.451 E-.20309
G1 X120.864 Y65.52 E-.17691
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X113.231 Y65.556 Z1.44 F18000
G1 X59.811 Y65.801 Z1.44
G1 Z1.04
G1 E.4 F1800
; FEATURE: Sparse infill
; LINE_WIDTH: 0.45
G1 F1500
M204 S6000
G1 X61.508 Y65.801 E.03592
G1 X61.778 Y65.891 E.00601
G1 X62.233 Y65.904 E.00964
G1 X62.392 Y65.801 E.004
G1 X68.792 Y65.801 E.13546
G1 X69.061 Y65.891 E.00601
G1 X69.516 Y65.904 E.00964
G1 X69.675 Y65.801 E.004
G1 X76.075 Y65.801 E.13546
G1 X76.344 Y65.891 E.00601
G1 X76.8 Y65.904 E.00964
G1 X76.958 Y65.801 E.004
G1 X83.358 Y65.801 E.13546
G1 X83.627 Y65.891 E.00601
G1 X84.083 Y65.904 E.00964
G1 X84.241 Y65.801 E.004
G1 X90.641 Y65.801 E.13546
G1 X90.911 Y65.891 E.00601
G1 X91.366 Y65.904 E.00964
G1 X91.524 Y65.801 E.004
G1 X97.924 Y65.801 E.13546
M73 P58 R14
G1 X98.194 Y65.891 E.00601
G1 X98.649 Y65.904 E.00964
G1 X98.808 Y65.801 E.004
G1 X105.207 Y65.801 E.13546
G1 X105.477 Y65.891 E.00601
G1 X105.932 Y65.904 E.00964
G1 X106.091 Y65.801 E.004
G1 X112.49 Y65.801 E.13546
G1 X112.76 Y65.891 E.00601
G1 X113.215 Y65.904 E.00964
G1 X113.374 Y65.801 E.004
G1 X119.774 Y65.801 E.13546
G1 X120.043 Y65.891 E.00601
G1 X120.499 Y65.904 E.00966
G1 X120.499 Y67.866 E.04154
G1 X120.264 Y68.2 E.00864
G1 X116.657 Y68.2 E.07633
G1 X116.402 Y67.827 E.00957
G1 X115.946 Y67.403 E.01318
G1 X115.491 Y67.127 E.01126
G1 X114.581 Y66.826 E.0203
G1 X114.126 Y66.812 E.00964
G1 X113.67 Y67.108 E.01149
G1 X113.215 Y67.868 E.01875
G1 X112.981 Y68.2 E.0086
G1 X109.374 Y68.2 E.07633
G1 X109.118 Y67.827 E.00957
G1 X108.663 Y67.403 E.01318
G1 X108.208 Y67.127 E.01126
G1 X107.298 Y66.826 E.0203
G1 X106.842 Y66.812 E.00964
G1 X106.387 Y67.108 E.01149
G1 X105.932 Y67.868 E.01875
G1 X105.698 Y68.2 E.0086
G1 X102.091 Y68.2 E.07633
G1 X101.835 Y67.827 E.00957
G1 X101.38 Y67.403 E.01318
G1 X100.925 Y67.127 E.01126
G1 X100.015 Y66.826 E.0203
G1 X99.559 Y66.812 E.00964
G1 X99.104 Y67.108 E.01149
G1 X98.649 Y67.868 E.01875
G1 X98.414 Y68.2 E.0086
G1 X94.808 Y68.2 E.07633
G1 X94.552 Y67.827 E.00957
G1 X94.097 Y67.403 E.01318
G1 X93.642 Y67.127 E.01126
G1 X92.731 Y66.826 E.0203
G1 X92.276 Y66.812 E.00964
G1 X91.821 Y67.108 E.01149
G1 X91.366 Y67.868 E.01875
G1 X91.131 Y68.2 E.0086
G1 X87.525 Y68.2 E.07633
G1 X87.269 Y67.827 E.00957
G1 X86.814 Y67.403 E.01318
G1 X86.359 Y67.127 E.01126
G1 X85.448 Y66.826 E.0203
G1 X84.993 Y66.812 E.00964
G1 X84.538 Y67.108 E.01149
G1 X84.083 Y67.868 E.01875
G1 X83.848 Y68.2 E.0086
G1 X80.242 Y68.2 E.07633
G1 X79.986 Y67.827 E.00957
G1 X79.531 Y67.403 E.01318
G1 X79.076 Y67.127 E.01126
G1 X78.165 Y66.826 E.0203
G1 X77.71 Y66.812 E.00964
G1 X77.255 Y67.108 E.01149
G1 X76.8 Y67.868 E.01875
G1 X76.565 Y68.2 E.0086
G1 X72.959 Y68.2 E.07633
G1 X72.703 Y67.827 E.00957
G1 X72.248 Y67.403 E.01318
G1 X71.792 Y67.127 E.01126
G1 X70.882 Y66.826 E.0203
G1 X70.427 Y66.812 E.00964
G1 X69.972 Y67.108 E.01149
G1 X69.516 Y67.868 E.01875
G1 X69.282 Y68.2 E.0086
G1 X65.676 Y68.2 E.07633
G1 X65.42 Y67.827 E.00957
G1 X64.964 Y67.403 E.01318
G1 X64.509 Y67.127 E.01126
G1 X63.599 Y66.826 E.0203
G1 X63.144 Y66.812 E.00964
G1 X62.688 Y67.108 E.01149
G1 X62.233 Y67.868 E.01875
G1 X61.999 Y68.2 E.0086
G1 X58.392 Y68.2 E.07633
G1 X58.137 Y67.827 E.00957
G1 X57.681 Y67.403 E.01318
G1 X57.226 Y67.127 E.01126
G1 X56.316 Y66.826 E.0203
G1 X55.861 Y66.812 E.00964
G1 X55.405 Y67.108 E.01149
G1 X55.001 Y67.784 E.01667
G1 X55.001 Y66.087 E.03592
; CHANGE_LAYER
; Z_HEIGHT: 1.16
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F1500
G1 X55.001 Y67.784 E-.32243
G1 X55.156 Y67.524 E-.05757
; WIPE_END
G1 E-.02 F1800
; stop printing object, unique label id: 8
M625
; layer num/total_layer_count: 9/51
; update layer progress
M73 L9
M991 S0 P8 ;notify layer change
; OBJECT_ID: 12
; start printing object, unique label id: 12
M624 AgAAAAAAAAA=
M204 S10000
G17
G3 Z1.44 I-.825 J.895 P1  F18000
G1 X90.602 Y100.215 Z1.44
G1 Z1.16
G1 E.4 F1800
; FEATURE: Inner wall
G1 F1500
M204 S500
G1 X90.23 Y100.164 E.00794
G1 X89.894 Y100.157 E.00712
G1 X89.394 Y100.219 E.01067
G1 X89.902 Y99.657 E.01605
G1 X54.243 Y99.657 E.75475
G1 X54.243 Y95.744 E.08282
G1 X121.843 Y95.744 E1.43081
G1 X121.843 Y94.344 E.02963
G1 X125.757 Y94.344 E.08282
G1 X125.757 Y101.057 E.14209
G1 X121.843 Y101.057 E.08282
G1 X121.843 Y99.657 E.02963
G1 X90.097 Y99.657 E.67193
G1 X90.562 Y100.17 E.01464
; WIPE_START
M204 S6000
G1 X90.23 Y100.164 E-.06295
G1 X89.894 Y100.157 E-.06395
G1 X89.394 Y100.219 E-.09579
G1 X89.902 Y99.657 E-.14407
G1 X89.833 Y99.657 E-.01325
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X91.58 Y101.114 Z1.56 F18000
G1 Z1.16
G1 E.4 F1800
G1 F1500
M204 S500
G1 X91.634 Y101.152 E.00139
G1 X91.874 Y101.368 E.00683
G1 X92.168 Y101.727 E.00982
G1 X92.407 Y102.166 E.01057
G1 X92.504 Y102.43 E.00597
G1 X92.58 Y102.742 E.00679
G1 X92.622 Y103.201 E.00975
G1 X92.579 Y103.672 E.01002
G1 X92.441 Y104.152 E.01058
G1 X92.325 Y104.409 E.00597
G1 X92.16 Y104.685 E.00679
G1 X91.868 Y105.041 E.00975
G1 X91.509 Y105.345 E.00995
G1 X91.102 Y105.58 E.00995
G1 X90.668 Y105.735 E.00975
G1 X90.352 Y105.797 E.00683
G1 X90.03 Y105.822 E.00683
G1 X89.58 Y105.788 E.00955
G1 X89.265 Y105.716 E.00683
G1 X88.961 Y105.607 E.00683
G1 X88.556 Y105.389 E.00975
G1 X88.188 Y105.096 E.00995
G1 X87.877 Y104.739 E.01002
G1 X87.625 Y104.307 E.01058
G1 X87.52 Y104.046 E.00597
G1 X87.434 Y103.737 E.00679
G1 X87.379 Y103.279 E.00975
G1 X87.408 Y102.806 E.01002
G1 X87.532 Y102.323 E.01057
G1 X87.64 Y102.062 E.00596
G1 X87.796 Y101.782 E.00679
G1 X88.08 Y101.415 E.00983
G1 X88.455 Y101.085 E.01058
G1 X88.691 Y100.931 E.00596
G1 X88.979 Y100.787 E.0068
G1 X89.42 Y100.644 E.00982
G1 X89.916 Y100.582 E.01058
G1 X90.198 Y100.588 E.00596
G1 X90.516 Y100.631 E.0068
G1 X90.958 Y100.76 E.00975
G1 X91.37 Y100.966 E.00975
G1 X91.531 Y101.08 E.00417
M204 S250
G1 X91.344 Y101.449 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X91.378 Y101.473 E.00081
G1 X91.577 Y101.652 E.00526
G1 X91.827 Y101.956 E.00775
G1 X92.033 Y102.335 E.00848
G1 X92.112 Y102.55 E.0045
G1 X92.176 Y102.809 E.00525
G1 X92.211 Y103.201 E.00773
G1 X92.175 Y103.597 E.00782
G1 X92.056 Y104.011 E.00848
G1 X91.962 Y104.219 E.0045
G1 X91.825 Y104.449 E.00525
G1 X91.575 Y104.752 E.00773
G1 X91.273 Y105.009 E.0078
G1 X90.929 Y105.207 E.0078
G1 X90.559 Y105.339 E.00773
G1 X90.297 Y105.391 E.00526
G1 X90.03 Y105.411 E.00526
G1 X89.641 Y105.382 E.00767
G1 X89.38 Y105.322 E.00526
G1 X89.128 Y105.232 E.00526
G1 X88.782 Y105.046 E.00773
G1 X88.472 Y104.799 E.0078
G1 X88.211 Y104.499 E.00782
G1 X87.994 Y104.127 E.00848
G1 X87.908 Y103.915 E.0045
G1 X87.837 Y103.657 E.00525
G1 X87.79 Y103.267 E.00773
G1 X87.814 Y102.87 E.00782
G1 X87.921 Y102.453 E.00847
G1 X88.009 Y102.241 E.0045
G1 X88.139 Y102.008 E.00525
G1 X88.38 Y101.696 E.00776
G1 X88.704 Y101.411 E.00848
G1 X88.895 Y101.286 E.0045
G1 X89.134 Y101.167 E.00525
G1 X89.509 Y101.045 E.00775
G1 X89.937 Y100.992 E.00848
G1 X90.166 Y100.997 E.0045
G1 X90.43 Y101.033 E.00525
G1 X90.808 Y101.143 E.00773
G1 X91.159 Y101.319 E.00773
G1 X91.295 Y101.414 E.00327
; WIPE_START
M204 S6000
G1 X91.378 Y101.473 E-.01926
G1 X91.577 Y101.652 E-.05084
G1 X91.827 Y101.956 E-.0749
G1 X92.033 Y102.335 E-.08188
G1 X92.112 Y102.55 E-.04351
G1 X92.176 Y102.809 E-.05074
G1 X92.203 Y103.118 E-.05887
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X99.795 Y102.329 Z1.56 F18000
G1 X121.419 Y100.082 Z1.56
G1 Z1.16
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X91.054 Y100.082 E.64271
G1 X92.253 Y101.406 E.03783
G1 X92.537 Y101.838 E.01094
G1 X92.737 Y102.305 E.01075
G1 X92.824 Y102.639 E.0073
G1 X92.879 Y103.136 E.01059
G1 X92.847 Y103.618 E.01023
G1 X92.763 Y104.013 E.00854
G1 X92.576 Y104.489 E.01083
G1 X92.307 Y104.924 E.01084
G1 X92.083 Y105.189 E.00734
G1 X91.824 Y105.43 E.00749
G1 X91.407 Y105.713 E.01067
G1 X91.046 Y105.882 E.00843
G1 X90.588 Y106.02 E.01013
G1 X90.38 Y106.055 E.00446
G1 X90.088 Y106.079 E.0062
G1 X89.742 Y106.069 E.00733
G1 X89.242 Y105.979 E.01074
G1 X88.907 Y105.865 E.0075
G1 X88.6 Y105.717 E.00722
G1 X88.266 Y105.498 E.00844
G1 X87.912 Y105.183 E.01002
G1 X87.699 Y104.931 E.007
G1 X87.447 Y104.53 E.01003
G1 X87.288 Y104.168 E.00836
G1 X87.183 Y103.788 E.00836
G1 X87.123 Y103.318 E.01002
G1 X87.129 Y102.98 E.00715
G1 X87.176 Y102.639 E.0073
G1 X87.263 Y102.305 E.0073
G1 X87.393 Y101.975 E.0075
G1 X87.549 Y101.689 E.0069
G1 X87.753 Y101.4 E.00749
G1 X88.946 Y100.082 E.03763
G1 X53.819 Y100.082 E.74349
G1 X53.819 Y95.32 E.10078
G1 X121.419 Y95.32 E1.43081
G1 X121.419 Y93.92 E.02963
G1 X126.181 Y93.92 E.10078
G1 X126.181 Y101.482 E.16005
G1 X121.419 Y101.482 E.10078
G1 X121.419 Y100.142 E.02836
M204 S250
G1 X121.01 Y100.491 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
M73 P59 R14
G1 X91.976 Y100.491 E.57107
G1 X92.569 Y101.145 E.01737
G1 X92.684 Y101.298 E.00375
G1 X92.895 Y101.638 E.00787
G1 X93.126 Y102.177 E.01155
G1 X93.226 Y102.559 E.00775
G1 X93.289 Y103.14 E.0115
G1 X93.254 Y103.675 E.01054
G1 X93.158 Y104.121 E.00899
G1 X93.077 Y104.362 E.005
G1 X92.944 Y104.67 E.00659
G1 X92.819 Y104.894 E.00504
G1 X92.635 Y105.171 E.00655
G1 X92.38 Y105.472 E.00776
G1 X92.089 Y105.742 E.00781
G1 X91.605 Y106.072 E.01153
G1 X91.192 Y106.265 E.00895
G1 X90.681 Y106.419 E.01051
G1 X90.099 Y106.489 E.01152
G1 X89.705 Y106.477 E.00776
G1 X89.127 Y106.373 E.01155
G1 X88.751 Y106.244 E.00781
G1 X88.397 Y106.074 E.00773
G1 X88.017 Y105.824 E.00895
G1 X87.619 Y105.47 E.01047
G1 X87.367 Y105.173 E.00765
G1 X87.085 Y104.722 E.01048
G1 X86.902 Y104.306 E.00893
G1 X86.78 Y103.869 E.00893
G1 X86.713 Y103.34 E.01047
G1 X86.72 Y102.949 E.0077
G1 X86.774 Y102.558 E.00775
G1 X86.874 Y102.177 E.00775
G1 X87.02 Y101.808 E.00781
G1 X87.204 Y101.467 E.00762
G1 X87.433 Y101.143 E.00781
G1 X88.024 Y100.491 E.01731
G1 X53.41 Y100.491 E.68082
G1 X53.41 Y94.911 E.10975
G1 X121.01 Y94.911 E1.32963
G1 X121.01 Y93.511 E.02754
G1 X126.59 Y93.511 E.10975
G1 X126.59 Y101.891 E.16483
G1 X121.01 Y101.891 E.10975
G1 X121.01 Y100.551 E.02636
; WIPE_START
M204 S6000
G1 X119.01 Y100.547 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G17
G3 Z1.56 I1.217 J0 P1  F18000
; stop printing object, unique label id: 12
M625
; object ids of layer 9 start: 8,12
M624 AwAAAAAAAAA=
;===================== date: 20250206 =====================

; don't support timelapse gcode in spiral_mode and by object sequence for I3 structure printer
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
G92 E0
G1 Z1.56
G1 X0 Y85.35 ; move to safe pos
G1 X-13.0 F3000 ; move to safe pos
M400
M1004 S5 P1  ; external shutter
M400 P300
M971 S11 C11 O0
G92 E0
G1 X0 F18000
M623

; SKIPTYPE: head_wrap_detect
M622.1 S1
M1002 judge_flag g39_3rd_layer_detect_flag
M622 J1
    ; enable nozzle clog detect at 3rd layer
    


    M622.1 S1
    M1002 judge_flag g39_detection_flag
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




; object ids of this layer9 end: 8,12
M625
; start printing object, unique label id: 12
M624 AgAAAAAAAAA=
G1 X122.415 Y100.884
G1 Z1.16
G1 E.4 F1800
; FEATURE: Bridge
; LINE_WIDTH: 0.40159
; LAYER_HEIGHT: 0.4
G1 F947.383
M204 S6000
G1 X122.219 Y100.651 E.01602
G1 X122.219 Y99.948 E.03703
G1 X122.834 Y100.682 E.05042
G1 X123.423 Y100.682 E.03102
G1 X119.602 Y96.12 E.31338
G1 X119.012 Y96.12 E.03102
G1 X121.661 Y99.282 E.2172
G1 X121.072 Y99.282 E.03102
G1 X118.423 Y96.12 E.2172
G1 X117.834 Y96.12 E.03102
G1 X120.483 Y99.282 E.2172
G1 X119.894 Y99.282 E.03102
G1 X117.245 Y96.12 E.2172
G1 X116.656 Y96.12 E.03102
G1 X119.305 Y99.282 E.2172
G1 X118.716 Y99.282 E.03102
G1 X116.067 Y96.12 E.2172
G1 X115.478 Y96.12 E.03102
G1 X118.126 Y99.282 E.2172
G1 X117.537 Y99.282 E.03102
G1 X114.889 Y96.12 E.2172
G1 X114.299 Y96.12 E.03102
G1 X116.948 Y99.282 E.2172
G1 X116.359 Y99.282 E.03102
G1 X113.71 Y96.12 E.2172
G1 X113.121 Y96.12 E.03102
G1 X115.77 Y99.282 E.2172
G1 X115.181 Y99.282 E.03102
G1 X112.532 Y96.12 E.2172
G1 X111.943 Y96.12 E.03102
G1 X114.592 Y99.282 E.2172
G1 X114.002 Y99.282 E.03102
G1 X111.354 Y96.12 E.2172
G1 X110.765 Y96.12 E.03102
G1 X113.413 Y99.282 E.2172
G1 X112.824 Y99.282 E.03102
G1 X110.175 Y96.12 E.2172
G1 X109.586 Y96.12 E.03102
G1 X112.235 Y99.282 E.2172
G1 X111.646 Y99.282 E.03102
G1 X108.997 Y96.12 E.2172
G1 X108.408 Y96.12 E.03102
G1 X111.057 Y99.282 E.2172
G1 X110.468 Y99.282 E.03102
G1 X107.819 Y96.12 E.2172
G1 X107.23 Y96.12 E.03102
G1 X109.879 Y99.282 E.2172
G1 X109.289 Y99.282 E.03102
G1 X106.641 Y96.12 E.2172
G1 X106.052 Y96.12 E.03102
G1 X108.7 Y99.282 E.2172
G1 X108.111 Y99.282 E.03102
G1 X105.462 Y96.12 E.2172
G1 X104.873 Y96.12 E.03102
G1 X107.522 Y99.282 E.2172
G1 X106.933 Y99.282 E.03102
G1 X104.284 Y96.12 E.2172
G1 X103.695 Y96.12 E.03102
G1 X106.344 Y99.282 E.2172
G1 X105.755 Y99.282 E.03102
G1 X103.106 Y96.12 E.2172
G1 X102.517 Y96.12 E.03102
G1 X105.166 Y99.282 E.2172
G1 X104.576 Y99.282 E.03102
G1 X101.928 Y96.12 E.2172
G1 X101.339 Y96.12 E.03102
G1 X103.987 Y99.282 E.2172
G1 X103.398 Y99.282 E.03102
G1 X100.749 Y96.12 E.2172
G1 X100.16 Y96.12 E.03102
G1 X102.809 Y99.282 E.2172
G1 X102.22 Y99.282 E.03102
G1 X99.571 Y96.12 E.2172
G1 X98.982 Y96.12 E.03102
G1 X101.631 Y99.282 E.2172
G1 X101.042 Y99.282 E.03102
G1 X98.393 Y96.12 E.2172
M73 P60 R14
G1 X97.804 Y96.12 E.03102
G1 X100.452 Y99.282 E.2172
G1 X99.863 Y99.282 E.03102
G1 X97.215 Y96.12 E.2172
G1 X96.625 Y96.12 E.03102
G1 X99.274 Y99.282 E.2172
G1 X98.685 Y99.282 E.03102
G1 X96.036 Y96.12 E.2172
G1 X95.447 Y96.12 E.03102
G1 X98.096 Y99.282 E.2172
G1 X97.507 Y99.282 E.03102
G1 X94.858 Y96.12 E.2172
G1 X94.269 Y96.12 E.03102
G1 X96.918 Y99.282 E.2172
G1 X96.329 Y99.282 E.03102
G1 X93.68 Y96.12 E.2172
G1 X93.091 Y96.12 E.03102
M73 P60 R13
G1 X95.739 Y99.282 E.2172
G1 X95.15 Y99.282 E.03102
G1 X92.502 Y96.12 E.2172
G1 X91.912 Y96.12 E.03102
G1 X94.561 Y99.282 E.2172
G1 X93.972 Y99.282 E.03102
G1 X91.323 Y96.12 E.2172
G1 X90.734 Y96.12 E.03102
G1 X93.383 Y99.282 E.2172
G1 X92.794 Y99.282 E.03102
G1 X90.145 Y96.12 E.2172
G1 X89.556 Y96.12 E.03102
G1 X92.205 Y99.282 E.2172
G1 X91.616 Y99.282 E.03102
G1 X88.967 Y96.12 E.2172
G1 X88.378 Y96.12 E.03102
G1 X91.026 Y99.282 E.2172
G1 X90.437 Y99.282 E.03102
G1 X87.789 Y96.12 E.2172
G1 X87.199 Y96.12 E.03102
G1 X89.848 Y99.282 E.2172
G1 X89.259 Y99.282 E.03102
G1 X86.61 Y96.12 E.2172
G1 X86.021 Y96.12 E.03102
G1 X88.67 Y99.282 E.2172
G1 X88.081 Y99.282 E.03102
G1 X85.432 Y96.12 E.2172
G1 X84.843 Y96.12 E.03102
G1 X87.492 Y99.282 E.2172
G1 X86.902 Y99.282 E.03102
G1 X84.254 Y96.12 E.2172
G1 X83.665 Y96.12 E.03102
G1 X86.313 Y99.282 E.2172
G1 X85.724 Y99.282 E.03102
G1 X83.075 Y96.12 E.2172
G1 X82.486 Y96.12 E.03102
G1 X85.135 Y99.282 E.2172
G1 X84.546 Y99.282 E.03102
G1 X81.897 Y96.12 E.2172
G1 X81.308 Y96.12 E.03102
G1 X83.957 Y99.282 E.2172
G1 X83.368 Y99.282 E.03102
G1 X80.719 Y96.12 E.2172
G1 X80.13 Y96.12 E.03102
G1 X82.779 Y99.282 E.2172
G1 X82.189 Y99.282 E.03102
G1 X79.541 Y96.12 E.2172
G1 X78.952 Y96.12 E.03102
G1 X81.6 Y99.282 E.2172
G1 X81.011 Y99.282 E.03102
G1 X78.362 Y96.12 E.2172
G1 X77.773 Y96.12 E.03102
G1 X80.422 Y99.282 E.2172
G1 X79.833 Y99.282 E.03102
G1 X77.184 Y96.12 E.2172
G1 X76.595 Y96.12 E.03102
G1 X79.244 Y99.282 E.2172
G1 X78.655 Y99.282 E.03102
G1 X76.006 Y96.12 E.2172
G1 X75.417 Y96.12 E.03102
G1 X78.066 Y99.282 E.2172
G1 X77.476 Y99.282 E.03102
G1 X74.828 Y96.12 E.2172
G1 X74.239 Y96.12 E.03102
G1 X76.887 Y99.282 E.2172
G1 X76.298 Y99.282 E.03102
G1 X73.649 Y96.12 E.2172
G1 X73.06 Y96.12 E.03102
G1 X75.709 Y99.282 E.2172
G1 X75.12 Y99.282 E.03102
G1 X72.471 Y96.12 E.2172
G1 X71.882 Y96.12 E.03102
G1 X74.531 Y99.282 E.2172
G1 X73.942 Y99.282 E.03102
G1 X71.293 Y96.12 E.2172
G1 X70.704 Y96.12 E.03102
G1 X73.352 Y99.282 E.2172
G1 X72.763 Y99.282 E.03102
G1 X70.115 Y96.12 E.2172
G1 X69.525 Y96.12 E.03102
G1 X72.174 Y99.282 E.2172
G1 X71.585 Y99.282 E.03102
G1 X68.936 Y96.12 E.2172
G1 X68.347 Y96.12 E.03102
G1 X70.996 Y99.282 E.2172
G1 X70.407 Y99.282 E.03102
G1 X67.758 Y96.12 E.2172
G1 X67.169 Y96.12 E.03102
G1 X69.818 Y99.282 E.2172
G1 X69.229 Y99.282 E.03102
G1 X66.58 Y96.12 E.2172
G1 X65.991 Y96.12 E.03102
G1 X68.639 Y99.282 E.2172
G1 X68.05 Y99.282 E.03102
G1 X65.402 Y96.12 E.2172
G1 X64.812 Y96.12 E.03102
G1 X67.461 Y99.282 E.2172
G1 X66.872 Y99.282 E.03102
G1 X64.223 Y96.12 E.2172
G1 X63.634 Y96.12 E.03102
G1 X66.283 Y99.282 E.2172
G1 X65.694 Y99.282 E.03102
G1 X63.045 Y96.12 E.2172
G1 X62.456 Y96.12 E.03102
G1 X65.105 Y99.282 E.2172
G1 X64.516 Y99.282 E.03102
G1 X61.867 Y96.12 E.2172
G1 X61.278 Y96.12 E.03102
G1 X63.926 Y99.282 E.2172
G1 X63.337 Y99.282 E.03102
G1 X60.689 Y96.12 E.2172
G1 X60.099 Y96.12 E.03102
G1 X62.748 Y99.282 E.2172
G1 X62.159 Y99.282 E.03102
G1 X59.51 Y96.12 E.2172
G1 X58.921 Y96.12 E.03102
G1 X61.57 Y99.282 E.2172
G1 X60.981 Y99.282 E.03102
G1 X58.332 Y96.12 E.2172
G1 X57.743 Y96.12 E.03102
G1 X60.392 Y99.282 E.2172
G1 X59.803 Y99.282 E.03102
G1 X57.154 Y96.12 E.2172
G1 X56.565 Y96.12 E.03102
G1 X59.213 Y99.282 E.2172
M73 P61 R13
G1 X58.624 Y99.282 E.03102
G1 X55.975 Y96.12 E.2172
G1 X55.386 Y96.12 E.03102
G1 X58.035 Y99.282 E.2172
G1 X57.446 Y99.282 E.03102
G1 X54.797 Y96.12 E.2172
G1 X54.619 Y96.12 E.00938
G1 X54.619 Y96.611 E.02584
G1 X56.857 Y99.282 E.18349
G1 X56.268 Y99.282 E.03102
G1 X54.619 Y97.314 E.13518
G1 X54.619 Y98.017 E.03703
G1 X55.679 Y99.282 E.08687
G1 X55.089 Y99.282 E.03102
G1 X54.417 Y98.479 E.05517
; WIPE_START
G1 X55.089 Y99.282 E-.19904
G1 X55.679 Y99.282 E-.11193
G1 X55.445 Y99.003 E-.06903
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X63.069 Y99.376 Z1.56 F18000
G1 X88.763 Y100.633 Z1.56
G1 Z1.16
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.101159
; LAYER_HEIGHT: 0.12
G1 F1500
M204 S6000
G1 X88.877 Y100.546 E.00054
G1 X89.123 Y100.492 E.00095
; WIPE_START
G1 X88.877 Y100.546 E-.24177
G1 X88.763 Y100.633 E-.13823
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X90.888 Y100.493 Z1.56 F18000
G1 Z1.16
G1 E.4 F1800
; LINE_WIDTH: 0.099588
G1 F1500
M204 S6000
G1 X91.124 Y100.55 E.0009
G1 X91.246 Y100.642 E.00056
; WIPE_START
G1 X91.124 Y100.55 E-.14633
G1 X90.888 Y100.493 E-.23367
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X98.428 Y99.309 Z1.56 F18000
G1 X120.021 Y95.917 Z1.56
G1 Z1.16
G1 E.4 F1800
; FEATURE: Bridge
; LINE_WIDTH: 0.40159
; LAYER_HEIGHT: 0.4
G1 F947.383
M204 S6000
G1 X124.012 Y100.682 E.32729
G1 X124.601 Y100.682 E.03102
G1 X120.78 Y96.12 E.31338
G1 X121.369 Y96.12 E.03102
G1 X125.191 Y100.682 E.31338
G1 X125.381 Y100.682 E.01001
G1 X125.381 Y100.205 E.02508
G1 X121.958 Y96.12 E.28067
G1 X122.219 Y96.12 E.01375
G1 X122.219 Y95.729 E.02061
G1 X125.381 Y99.502 E.25925
G1 X125.381 Y98.799 E.03703
G1 X122.219 Y95.025 E.25925
G1 X122.219 Y94.72 E.01608
G1 X122.553 Y94.72 E.01755
G1 X125.381 Y98.096 E.23192
G1 X125.381 Y97.393 E.03703
G1 X123.142 Y94.72 E.18361
G1 X123.731 Y94.72 E.03102
G1 X125.381 Y96.689 E.1353
G1 X125.381 Y95.986 E.03703
G1 X124.32 Y94.72 E.08699
G1 X124.909 Y94.72 E.03102
G1 X125.583 Y95.525 E.05529
; OBJECT_ID: 8
; WIPE_START
G1 X124.909 Y94.72 E-.19947
G1 X124.32 Y94.72 E-.11193
G1 X124.552 Y94.997 E-.06859
; WIPE_END
G1 E-.02 F1800
; stop printing object, unique label id: 12
M625
; start printing object, unique label id: 8
M624 AQAAAAAAAAA=
M204 S10000
G1 X118.396 Y90.484 Z1.56 F18000
G1 X92.376 Y71.408 Z1.56
G1 Z1.16
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
; LAYER_HEIGHT: 0.12
G1 F1500
M204 S500
G1 X92.407 Y71.466 E.00138
G1 X92.504 Y71.73 E.00597
G1 X92.58 Y72.042 E.00679
G1 X92.622 Y72.501 E.00975
G1 X92.579 Y72.972 E.01002
G1 X92.441 Y73.452 E.01057
G1 X92.319 Y73.721 E.00625
G1 X92.16 Y73.985 E.00652
G1 X91.868 Y74.341 E.00975
G1 X91.509 Y74.645 E.00995
G1 X91.102 Y74.88 E.00995
G1 X90.668 Y75.035 E.00975
G1 X90.352 Y75.097 E.00683
G1 X90.03 Y75.122 E.00683
G1 X89.58 Y75.088 E.00955
G1 X89.265 Y75.016 E.00683
G1 X88.961 Y74.907 E.00683
G1 X88.556 Y74.689 E.00975
G1 X88.188 Y74.396 E.00995
G1 X87.877 Y74.039 E.01002
G1 X87.625 Y73.607 E.01058
G1 X87.52 Y73.346 E.00597
G1 X87.434 Y73.037 E.00679
G1 X87.379 Y72.579 E.00975
G1 X87.408 Y72.106 E.01002
G1 X87.532 Y71.623 E.01057
G1 X87.64 Y71.362 E.00596
G1 X87.796 Y71.082 E.00679
G1 X88.08 Y70.715 E.00983
G1 X88.455 Y70.385 E.01057
G1 X88.691 Y70.231 E.00596
G1 X88.979 Y70.087 E.0068
G1 X89.42 Y69.944 E.00982
G1 X89.916 Y69.882 E.01058
G1 X90.198 Y69.888 E.00596
G1 X90.516 Y69.931 E.0068
G1 X90.958 Y70.06 E.00975
G1 X91.37 Y70.266 E.00975
G1 X91.634 Y70.452 E.00683
G1 X91.874 Y70.668 E.00683
G1 X92.168 Y71.027 E.00982
G1 X92.347 Y71.356 E.00792
M204 S250
G1 X92.016 Y71.604 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X92.033 Y71.635 E.0007
G1 X92.112 Y71.85 E.0045
G1 X92.176 Y72.109 E.00525
G1 X92.211 Y72.501 E.00773
G1 X92.175 Y72.897 E.00782
G1 X92.056 Y73.311 E.00848
G1 X91.962 Y73.519 E.0045
G1 X91.825 Y73.749 E.00525
G1 X91.575 Y74.052 E.00773
G1 X91.273 Y74.309 E.0078
G1 X90.929 Y74.507 E.0078
G1 X90.559 Y74.639 E.00773
G1 X90.297 Y74.691 E.00526
G1 X90.03 Y74.711 E.00526
G1 X89.641 Y74.682 E.00767
G1 X89.38 Y74.622 E.00526
G1 X89.128 Y74.532 E.00526
G1 X88.782 Y74.346 E.00773
G1 X88.472 Y74.099 E.0078
G1 X88.211 Y73.799 E.00782
G1 X87.994 Y73.427 E.00848
G1 X87.908 Y73.215 E.0045
G1 X87.837 Y72.957 E.00525
G1 X87.79 Y72.567 E.00773
G1 X87.814 Y72.17 E.00782
G1 X87.921 Y71.753 E.00847
G1 X88.009 Y71.541 E.0045
G1 X88.139 Y71.308 E.00525
G1 X88.38 Y70.996 E.00776
G1 X88.704 Y70.711 E.00848
G1 X88.895 Y70.586 E.0045
G1 X89.134 Y70.467 E.00525
G1 X89.509 Y70.345 E.00775
G1 X89.937 Y70.292 E.00848
G1 X90.166 Y70.297 E.0045
G1 X90.43 Y70.333 E.00525
G1 X90.808 Y70.443 E.00773
G1 X91.159 Y70.619 E.00773
G1 X91.378 Y70.773 E.00526
G1 X91.577 Y70.952 E.00526
G1 X91.827 Y71.256 E.00775
G1 X91.987 Y71.551 E.00659
; WIPE_START
M204 S6000
G1 X92.033 Y71.635 E-.0182
G1 X92.112 Y71.85 E-.04351
G1 X92.176 Y72.109 E-.05074
G1 X92.211 Y72.501 E-.07469
G1 X92.175 Y72.897 E-.07552
G1 X92.056 Y73.311 E-.0819
G1 X91.979 Y73.481 E-.03545
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X90.602 Y69.515 Z1.56 F18000
G1 Z1.16
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X90.23 Y69.464 E.00794
G1 X89.894 Y69.457 E.00712
G1 X89.394 Y69.519 E.01067
G1 X89.902 Y68.957 E.01605
G1 X54.243 Y68.957 E.75475
G1 X54.243 Y65.044 E.08282
G1 X121.257 Y65.044 E1.41839
G1 X121.257 Y68.957 E.08282
G1 X90.097 Y68.957 E.65951
G1 X90.562 Y69.47 E.01464
; WIPE_START
M204 S6000
G1 X90.23 Y69.464 E-.06295
G1 X89.894 Y69.457 E-.06395
G1 X89.394 Y69.519 E-.09579
G1 X89.902 Y68.957 E-.14407
G1 X89.833 Y68.957 E-.01324
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X97.465 Y68.992 Z1.56 F18000
G1 X125.51 Y69.12 Z1.56
G1 Z1.16
G1 E.4 F1800
G1 F1500
M204 S500
G1 X121.681 Y69.12 E.08105
G1 X121.681 Y64.882 E.08971
G1 X125.919 Y64.882 E.08971
G1 X125.919 Y69.12 E.08971
G1 X125.57 Y69.12 E.00739
M204 S250
G1 X125.51 Y68.711 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X122.09 Y68.711 E.06727
G1 X122.09 Y65.291 E.06727
G1 X125.51 Y65.291 E.06727
G1 X125.51 Y68.651 E.06609
; WIPE_START
M204 S6000
G1 X123.51 Y68.686 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X115.879 Y68.839 Z1.56 F18000
G1 X88.946 Y69.382 Z1.56
G1 Z1.16
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X53.819 Y69.382 E.74349
G1 X53.819 Y64.62 E.10078
G1 X126.181 Y64.62 E1.53159
G1 X126.181 Y69.382 E.10078
G1 X91.054 Y69.382 E.74349
G1 X92.253 Y70.706 E.03783
G1 X92.537 Y71.138 E.01094
G1 X92.737 Y71.605 E.01075
G1 X92.824 Y71.939 E.0073
G1 X92.88 Y72.443 E.01074
G1 X92.855 Y72.908 E.00985
G1 X92.766 Y73.301 E.00853
G1 X92.628 Y73.674 E.00843
G1 X92.396 Y74.098 E.01023
G1 X92.083 Y74.489 E.0106
G1 X91.824 Y74.73 E.00749
G1 X91.407 Y75.013 E.01067
G1 X91.046 Y75.182 E.00843
G1 X90.588 Y75.32 E.01013
G1 X90.38 Y75.355 E.00446
G1 X90.088 Y75.379 E.0062
G1 X89.742 Y75.369 E.00733
G1 X89.242 Y75.279 E.01074
G1 X88.907 Y75.165 E.0075
G1 X88.6 Y75.017 E.00722
G1 X88.266 Y74.798 E.00844
G1 X87.912 Y74.483 E.01002
G1 X87.699 Y74.231 E.007
G1 X87.447 Y73.83 E.01003
G1 X87.288 Y73.468 E.00836
M73 P62 R13
G1 X87.183 Y73.088 E.00836
G1 X87.123 Y72.618 E.01002
G1 X87.129 Y72.28 E.00715
G1 X87.176 Y71.939 E.0073
G1 X87.263 Y71.605 E.0073
G1 X87.393 Y71.275 E.0075
G1 X87.549 Y70.989 E.0069
G1 X87.753 Y70.7 E.00749
G1 X88.906 Y69.426 E.03636
M204 S250
G1 X88.024 Y69.791 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X53.41 Y69.791 E.68082
G1 X53.41 Y64.211 E.10975
G1 X126.59 Y64.211 E1.43939
G1 X126.59 Y69.791 E.10975
G1 X91.976 Y69.791 E.68082
G1 X92.569 Y70.445 E.01737
G1 X92.895 Y70.938 E.01161
G1 X93.126 Y71.477 E.01155
G1 X93.226 Y71.859 E.00775
G1 X93.289 Y72.442 E.01155
G1 X93.272 Y72.842 E.00787
G1 X93.159 Y73.417 E.01153
G1 X93.001 Y73.844 E.00895
G1 X92.745 Y74.315 E.01054
G1 X92.38 Y74.772 E.01151
G1 X92.089 Y75.042 E.00781
G1 X91.605 Y75.372 E.01153
G1 X91.192 Y75.565 E.00895
G1 X90.681 Y75.719 E.01051
G1 X90.099 Y75.789 E.01152
G1 X89.705 Y75.777 E.00776
G1 X89.127 Y75.673 E.01155
G1 X88.751 Y75.544 E.00781
G1 X88.397 Y75.374 E.00773
G1 X88.017 Y75.124 E.00895
G1 X87.619 Y74.77 E.01047
G1 X87.367 Y74.473 E.00765
G1 X87.085 Y74.022 E.01048
G1 X86.902 Y73.606 E.00893
G1 X86.78 Y73.169 E.00893
G1 X86.713 Y72.64 E.01047
G1 X86.72 Y72.249 E.0077
G1 X86.774 Y71.858 E.00775
G1 X86.874 Y71.477 E.00775
G1 X87.02 Y71.108 E.00781
G1 X87.204 Y70.767 E.00762
G1 X87.433 Y70.443 E.00781
G1 X87.984 Y69.835 E.01613
M204 S10000
G1 X88.763 Y69.933 F18000
; FEATURE: Gap infill
; LINE_WIDTH: 0.101171
G1 F1500
M204 S6000
G1 X88.877 Y69.846 E.00054
G1 X89.123 Y69.792 E.00095
; WIPE_START
G1 X88.877 Y69.846 E-.24175
G1 X88.763 Y69.933 E-.13825
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X90.888 Y69.793 Z1.56 F18000
G1 Z1.16
G1 E.4 F1800
; LINE_WIDTH: 0.0995881
G1 F1500
M204 S6000
G1 X91.124 Y69.85 E.0009
G1 X91.246 Y69.942 E.00056
; WIPE_START
G1 X91.124 Y69.85 E-.14633
G1 X90.888 Y69.793 E-.23367
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X98.516 Y69.532 Z1.56 F18000
G1 X120.406 Y68.784 Z1.56
G1 Z1.16
G1 E.4 F1800
; FEATURE: Bridge
; LINE_WIDTH: 0.40075
; LAYER_HEIGHT: 0.4
G1 F951.359
M204 S6000
G1 X120.881 Y67.212 E.0861
G1 X120.881 Y65.653 E.08179
G1 X119.997 Y68.582 E.16045
G1 X119.526 Y68.582 E.02469
G1 X120.48 Y65.42 E.17319
G1 X120.009 Y65.42 E.02469
G1 X119.055 Y68.582 E.17319
G1 X118.584 Y68.582 E.02469
G1 X119.538 Y65.42 E.17319
G1 X119.068 Y65.42 E.02469
G1 X118.113 Y68.582 E.17319
G1 X117.642 Y68.582 E.02469
G1 X118.597 Y65.42 E.17319
G1 X118.126 Y65.42 E.02469
G1 X117.172 Y68.582 E.17319
G1 X116.701 Y68.582 E.02469
G1 X117.655 Y65.42 E.17319
G1 X117.184 Y65.42 E.02469
G1 X116.23 Y68.582 E.17319
G1 X115.759 Y68.582 E.02469
G1 X116.713 Y65.42 E.17319
G1 X116.243 Y65.42 E.02469
G1 X115.288 Y68.582 E.17319
G1 X114.817 Y68.582 E.02469
G1 X115.772 Y65.42 E.17319
G1 X115.301 Y65.42 E.02469
G1 X114.346 Y68.582 E.17319
G1 X113.876 Y68.582 E.02469
G1 X114.83 Y65.42 E.17319
G1 X114.359 Y65.42 E.02469
G1 X113.405 Y68.582 E.17319
G1 X112.934 Y68.582 E.02469
G1 X113.888 Y65.42 E.17319
G1 X113.418 Y65.42 E.02469
G1 X112.463 Y68.582 E.17319
G1 X111.992 Y68.582 E.02469
G1 X112.947 Y65.42 E.17319
G1 X112.476 Y65.42 E.02469
G1 X111.521 Y68.582 E.17319
G1 X111.051 Y68.582 E.02469
G1 X112.005 Y65.42 E.17319
G1 X111.534 Y65.42 E.02469
G1 X110.58 Y68.582 E.17319
G1 X110.109 Y68.582 E.02469
G1 X111.063 Y65.42 E.17319
G1 X110.592 Y65.42 E.02469
G1 X109.638 Y68.582 E.17319
G1 X109.167 Y68.582 E.02469
G1 X110.122 Y65.42 E.17319
G1 X109.651 Y65.42 E.02469
G1 X108.696 Y68.582 E.17319
G1 X108.226 Y68.582 E.02469
G1 X109.18 Y65.42 E.17319
G1 X108.709 Y65.42 E.02469
G1 X107.755 Y68.582 E.17319
G1 X107.284 Y68.582 E.02469
G1 X108.238 Y65.42 E.17319
G1 X107.767 Y65.42 E.02469
G1 X106.813 Y68.582 E.17319
G1 X106.342 Y68.582 E.02469
G1 X107.297 Y65.42 E.17319
G1 X106.826 Y65.42 E.02469
G1 X105.871 Y68.582 E.17319
G1 X105.4 Y68.582 E.02469
G1 X106.355 Y65.42 E.17319
G1 X105.884 Y65.42 E.02469
G1 X104.93 Y68.582 E.17319
G1 X104.459 Y68.582 E.02469
G1 X105.413 Y65.42 E.17319
G1 X104.942 Y65.42 E.02469
G1 X103.988 Y68.582 E.17319
G1 X103.517 Y68.582 E.02469
G1 X104.472 Y65.42 E.17319
G1 X104.001 Y65.42 E.02469
G1 X103.046 Y68.582 E.17319
G1 X102.575 Y68.582 E.02469
G1 X103.53 Y65.42 E.17319
G1 X103.059 Y65.42 E.02469
G1 X102.105 Y68.582 E.17319
G1 X101.634 Y68.582 E.02469
G1 X102.588 Y65.42 E.17319
G1 X102.117 Y65.42 E.02469
G1 X101.163 Y68.582 E.17319
G1 X100.692 Y68.582 E.02469
G1 X101.646 Y65.42 E.17319
G1 X101.176 Y65.42 E.02469
G1 X100.221 Y68.582 E.17319
M73 P62 R12
G1 X99.75 Y68.582 E.02469
G1 X100.705 Y65.42 E.17319
G1 X100.234 Y65.42 E.02469
G1 X99.28 Y68.582 E.17319
G1 X98.809 Y68.582 E.02469
M73 P63 R12
G1 X99.763 Y65.42 E.17319
G1 X99.292 Y65.42 E.02469
G1 X98.338 Y68.582 E.17319
G1 X97.867 Y68.582 E.02469
G1 X98.821 Y65.42 E.17319
G1 X98.351 Y65.42 E.02469
G1 X97.396 Y68.582 E.17319
G1 X96.925 Y68.582 E.02469
G1 X97.88 Y65.42 E.17319
G1 X97.409 Y65.42 E.02469
G1 X96.455 Y68.582 E.17319
G1 X95.984 Y68.582 E.02469
G1 X96.938 Y65.42 E.17319
G1 X96.467 Y65.42 E.02469
G1 X95.513 Y68.582 E.17319
G1 X95.042 Y68.582 E.02469
G1 X95.996 Y65.42 E.17319
G1 X95.526 Y65.42 E.02469
G1 X94.571 Y68.582 E.17319
G1 X94.1 Y68.582 E.02469
G1 X95.055 Y65.42 E.17319
G1 X94.584 Y65.42 E.02469
G1 X93.629 Y68.582 E.17319
G1 X93.159 Y68.582 E.02469
G1 X94.113 Y65.42 E.17319
G1 X93.642 Y65.42 E.02469
G1 X92.688 Y68.582 E.17319
G1 X92.217 Y68.582 E.02469
G1 X93.171 Y65.42 E.17319
G1 X92.701 Y65.42 E.02469
G1 X91.746 Y68.582 E.17319
G1 X91.275 Y68.582 E.02469
G1 X92.23 Y65.42 E.17319
G1 X91.759 Y65.42 E.02469
G1 X90.804 Y68.582 E.17319
G1 X90.334 Y68.582 E.02469
G1 X91.288 Y65.42 E.17319
G1 X90.817 Y65.42 E.02469
G1 X89.863 Y68.582 E.17319
G1 X89.392 Y68.582 E.02469
G1 X90.346 Y65.42 E.17319
G1 X89.875 Y65.42 E.02469
G1 X88.921 Y68.582 E.17319
G1 X88.45 Y68.582 E.02469
G1 X89.405 Y65.42 E.17319
G1 X88.934 Y65.42 E.02469
G1 X87.979 Y68.582 E.17319
G1 X87.509 Y68.582 E.02469
G1 X88.463 Y65.42 E.17319
G1 X87.992 Y65.42 E.02469
G1 X87.038 Y68.582 E.17319
G1 X86.567 Y68.582 E.02469
G1 X87.521 Y65.42 E.17319
G1 X87.05 Y65.42 E.02469
G1 X86.096 Y68.582 E.17319
G1 X85.625 Y68.582 E.02469
G1 X86.58 Y65.42 E.17319
G1 X86.109 Y65.42 E.02469
G1 X85.154 Y68.582 E.17319
G1 X84.683 Y68.582 E.02469
G1 X85.638 Y65.42 E.17319
G1 X85.167 Y65.42 E.02469
G1 X84.213 Y68.582 E.17319
G1 X83.742 Y68.582 E.02469
G1 X84.696 Y65.42 E.17319
G1 X84.225 Y65.42 E.02469
G1 X83.271 Y68.582 E.17319
G1 X82.8 Y68.582 E.02469
G1 X83.755 Y65.42 E.17319
G1 X83.284 Y65.42 E.02469
G1 X82.329 Y68.582 E.17319
G1 X81.858 Y68.582 E.02469
G1 X82.813 Y65.42 E.17319
G1 X82.342 Y65.42 E.02469
G1 X81.388 Y68.582 E.17319
G1 X80.917 Y68.582 E.02469
G1 X81.871 Y65.42 E.17319
G1 X81.4 Y65.42 E.02469
G1 X80.446 Y68.582 E.17319
G1 X79.975 Y68.582 E.02469
G1 X80.929 Y65.42 E.17319
G1 X80.459 Y65.42 E.02469
G1 X79.504 Y68.582 E.17319
G1 X79.033 Y68.582 E.02469
G1 X79.988 Y65.42 E.17319
G1 X79.517 Y65.42 E.02469
G1 X78.563 Y68.582 E.17319
G1 X78.092 Y68.582 E.02469
G1 X79.046 Y65.42 E.17319
G1 X78.575 Y65.42 E.02469
G1 X77.621 Y68.582 E.17319
G1 X77.15 Y68.582 E.02469
G1 X78.104 Y65.42 E.17319
G1 X77.634 Y65.42 E.02469
G1 X76.679 Y68.582 E.17319
G1 X76.208 Y68.582 E.02469
G1 X77.163 Y65.42 E.17319
G1 X76.692 Y65.42 E.02469
G1 X75.737 Y68.582 E.17319
G1 X75.267 Y68.582 E.02469
G1 X76.221 Y65.42 E.17319
G1 X75.75 Y65.42 E.02469
G1 X74.796 Y68.582 E.17319
G1 X74.325 Y68.582 E.02469
G1 X75.279 Y65.42 E.17319
G1 X74.809 Y65.42 E.02469
G1 X73.854 Y68.582 E.17319
G1 X73.383 Y68.582 E.02469
G1 X74.338 Y65.42 E.17319
G1 X73.867 Y65.42 E.02469
G1 X72.912 Y68.582 E.17319
G1 X72.442 Y68.582 E.02469
G1 X73.396 Y65.42 E.17319
G1 X72.925 Y65.42 E.02469
G1 X71.971 Y68.582 E.17319
G1 X71.5 Y68.582 E.02469
G1 X72.454 Y65.42 E.17319
G1 X71.984 Y65.42 E.02469
G1 X71.029 Y68.582 E.17319
G1 X70.558 Y68.582 E.02469
G1 X71.513 Y65.42 E.17319
G1 X71.042 Y65.42 E.02469
G1 X70.087 Y68.582 E.17319
G1 X69.617 Y68.582 E.02469
G1 X70.571 Y65.42 E.17319
G1 X70.1 Y65.42 E.02469
G1 X69.146 Y68.582 E.17319
G1 X68.675 Y68.582 E.02469
G1 X69.629 Y65.42 E.17319
G1 X69.158 Y65.42 E.02469
G1 X68.204 Y68.582 E.17319
G1 X67.733 Y68.582 E.02469
G1 X68.688 Y65.42 E.17319
G1 X68.217 Y65.42 E.02469
G1 X67.262 Y68.582 E.17319
G1 X66.792 Y68.582 E.02469
G1 X67.746 Y65.42 E.17319
G1 X67.275 Y65.42 E.02469
G1 X66.321 Y68.582 E.17319
G1 X65.85 Y68.582 E.02469
G1 X66.804 Y65.42 E.17319
G1 X66.333 Y65.42 E.02469
G1 X65.379 Y68.582 E.17319
G1 X64.908 Y68.582 E.02469
G1 X65.863 Y65.42 E.17319
G1 X65.392 Y65.42 E.02469
G1 X64.437 Y68.582 E.17319
G1 X63.966 Y68.582 E.02469
G1 X64.921 Y65.42 E.17319
G1 X64.45 Y65.42 E.02469
G1 X63.496 Y68.582 E.17319
G1 X63.025 Y68.582 E.02469
G1 X63.979 Y65.42 E.17319
G1 X63.508 Y65.42 E.02469
G1 X62.554 Y68.582 E.17319
G1 X62.083 Y68.582 E.02469
G1 X63.038 Y65.42 E.17319
G1 X62.567 Y65.42 E.02469
G1 X61.612 Y68.582 E.17319
G1 X61.141 Y68.582 E.02469
G1 X62.096 Y65.42 E.17319
G1 X61.625 Y65.42 E.02469
G1 X60.671 Y68.582 E.17319
G1 X60.2 Y68.582 E.02469
G1 X61.154 Y65.42 E.17319
G1 X60.683 Y65.42 E.02469
G1 X59.729 Y68.582 E.17319
G1 X59.258 Y68.582 E.02469
G1 X60.212 Y65.42 E.17319
G1 X59.742 Y65.42 E.02469
G1 X58.787 Y68.582 E.17319
G1 X58.316 Y68.582 E.02469
G1 X59.271 Y65.42 E.17319
G1 X58.8 Y65.42 E.02469
G1 X57.846 Y68.582 E.17319
G1 X57.375 Y68.582 E.02469
G1 X58.329 Y65.42 E.17319
M73 P64 R12
G1 X57.858 Y65.42 E.02469
G1 X56.904 Y68.582 E.17319
G1 X56.433 Y68.582 E.02469
G1 X57.387 Y65.42 E.17319
G1 X56.917 Y65.42 E.02469
G1 X55.962 Y68.582 E.17319
G1 X55.491 Y68.582 E.02469
G1 X56.446 Y65.42 E.17319
G1 X55.975 Y65.42 E.02469
G1 X55.02 Y68.582 E.17319
G1 X54.619 Y68.582 E.02104
G1 X54.619 Y68.351 E.01209
G1 X55.504 Y65.42 E.16056
G1 X55.033 Y65.42 E.02469
G1 X54.417 Y67.462 E.11187
; CHANGE_LAYER
; Z_HEIGHT: 1.28
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F951.359
G1 X54.995 Y65.548 E-.38
; WIPE_END
G1 E-.02 F1800
; stop printing object, unique label id: 8
M625
; layer num/total_layer_count: 10/51
; update layer progress
M73 L10
M991 S0 P9 ;notify layer change
; OBJECT_ID: 12
; start printing object, unique label id: 12
M624 AgAAAAAAAAA=
M204 S10000
G17
G3 Z1.56 I-.849 J.872 P1  F18000
G1 X90.602 Y100.215 Z1.56
G1 Z1.28
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X90.23 Y100.164 E.00795
G1 X89.883 Y100.158 E.00735
G1 X89.394 Y100.22 E.01044
G1 X89.902 Y99.657 E.01605
G1 X54.243 Y99.657 E.75475
G1 X54.243 Y95.744 E.08282
G1 X121.843 Y95.744 E1.43081
G1 X121.843 Y94.344 E.02963
G1 X125.757 Y94.344 E.08282
G1 X125.757 Y101.057 E.14209
G1 X121.843 Y101.057 E.08282
G1 X121.843 Y99.657 E.02963
G1 X90.098 Y99.657 E.67193
G1 X90.562 Y100.17 E.01464
; WIPE_START
M204 S6000
G1 X90.23 Y100.164 E-.06311
G1 X89.883 Y100.158 E-.06594
G1 X89.394 Y100.22 E-.09369
G1 X89.902 Y99.657 E-.1441
G1 X89.833 Y99.657 E-.01316
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X91.588 Y101.12 Z1.68 F18000
G1 Z1.28
G1 E.4 F1800
G1 F1500
M204 S500
G1 X91.634 Y101.152 E.00119
G1 X91.874 Y101.368 E.00683
G1 X92.166 Y101.724 E.00975
G1 X92.391 Y102.126 E.00975
G1 X92.503 Y102.427 E.0068
G1 X92.574 Y102.71 E.00617
G1 X92.622 Y103.201 E.01043
G1 X92.574 Y103.691 E.01043
G1 X92.504 Y103.974 E.00617
G1 X92.391 Y104.275 E.00681
G1 X92.166 Y104.678 E.00975
G1 X91.868 Y105.041 E.00995
G1 X91.507 Y105.346 E.01001
G1 X91.08 Y105.588 E.01038
G1 X90.785 Y105.702 E.0067
G1 X90.497 Y105.774 E.00628
G1 X90.039 Y105.822 E.00975
G1 X89.57 Y105.787 E.00995
G1 X89.113 Y105.668 E.01
G1 X88.67 Y105.458 E.01038
G1 X88.427 Y105.297 E.00617
G1 X88.182 Y105.089 E.0068
G1 X87.877 Y104.74 E.00981
G1 X87.629 Y104.317 E.01038
G1 X87.52 Y104.046 E.00617
G1 X87.434 Y103.737 E.0068
G1 X87.381 Y103.289 E.00955
G1 X87.39 Y102.966 E.00683
G1 X87.438 Y102.647 E.00683
G1 X87.574 Y102.206 E.00975
G1 X87.791 Y101.789 E.00995
G1 X88.078 Y101.418 E.00995
G1 X88.42 Y101.109 E.00975
G1 X88.69 Y100.932 E.00683
G1 X88.978 Y100.787 E.00683
G1 X89.419 Y100.644 E.00981
G1 X89.905 Y100.582 E.01038
G1 X90.197 Y100.588 E.00617
G1 X90.516 Y100.631 E.00681
G1 X90.958 Y100.76 E.00975
G1 X91.37 Y100.966 E.00975
G1 X91.539 Y101.085 E.00437
M204 S250
G1 X91.352 Y101.454 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X91.378 Y101.473 E.00062
G1 X91.577 Y101.652 E.00526
G1 X91.827 Y101.955 E.00773
G1 X92.018 Y102.299 E.00773
G1 X92.112 Y102.549 E.00525
G1 X92.169 Y102.78 E.00469
G1 X92.211 Y103.201 E.00832
G1 X92.169 Y103.622 E.00832
G1 X92.112 Y103.853 E.00468
G1 X92.018 Y104.103 E.00526
G1 X91.827 Y104.446 E.00773
G1 X91.575 Y104.752 E.0078
G1 X91.272 Y105.009 E.00781
G1 X90.905 Y105.217 E.0083
G1 X90.683 Y105.303 E.00469
G1 X90.424 Y105.37 E.00525
G1 X90.033 Y105.411 E.00774
G1 X89.638 Y105.382 E.0078
G1 X89.253 Y105.282 E.00781
G1 X88.872 Y105.101 E.0083
G1 X88.674 Y104.969 E.00469
G1 X88.47 Y104.796 E.00525
G1 X88.211 Y104.5 E.00775
G1 X87.998 Y104.136 E.0083
G1 X87.908 Y103.915 E.00469
G1 X87.837 Y103.657 E.00525
G1 X87.791 Y103.27 E.00767
G1 X87.799 Y103.003 E.00526
G1 X87.838 Y102.738 E.00526
G1 X87.954 Y102.362 E.00774
G1 X88.137 Y102.011 E.0078
G1 X88.379 Y101.697 E.00779
G1 X88.671 Y101.434 E.00773
G1 X88.895 Y101.287 E.00526
G1 X89.134 Y101.167 E.00526
G1 X89.509 Y101.045 E.00775
G1 X89.927 Y100.992 E.0083
G1 X90.166 Y100.997 E.00469
G1 X90.43 Y101.033 E.00525
G1 X90.808 Y101.143 E.00773
G1 X91.159 Y101.319 E.00774
G1 X91.303 Y101.42 E.00346
; WIPE_START
M204 S6000
G1 X91.378 Y101.473 E-.0174
G1 X91.577 Y101.652 E-.05084
G1 X91.827 Y101.955 E-.07471
G1 X92.018 Y102.299 E-.07472
G1 X92.112 Y102.549 E-.05073
G1 X92.169 Y102.78 E-.04527
G1 X92.204 Y103.127 E-.06633
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X99.795 Y102.336 Z1.68 F18000
G1 X121.419 Y100.082 Z1.68
G1 Z1.28
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X91.054 Y100.082 E.64271
G1 X92.251 Y101.404 E.03775
G1 X92.371 Y101.567 E.00428
G1 X92.607 Y101.976 E.00999
G1 X92.737 Y102.305 E.0075
G1 X92.824 Y102.639 E.0073
G1 X92.872 Y102.989 E.00749
G1 X92.864 Y103.503 E.01087
G1 X92.835 Y103.703 E.00429
G1 X92.766 Y104 E.00646
G1 X92.634 Y104.361 E.00814
G1 X92.4 Y104.791 E.01034
G1 X92.127 Y105.149 E.00955
G1 X91.802 Y105.445 E.0093
G1 X91.399 Y105.717 E.01028
G1 X91.059 Y105.877 E.00796
G1 X90.586 Y106.02 E.01046
G1 X90.088 Y106.079 E.01063
G1 X89.736 Y106.069 E.00745
G1 X89.234 Y105.977 E.01079
G1 X88.757 Y105.799 E.01077
G1 X88.448 Y105.627 E.0075
G1 X88.169 Y105.424 E.0073
G1 X87.917 Y105.189 E.0073
G1 X87.699 Y104.931 E.00713
G1 X87.441 Y104.517 E.01034
G1 X87.287 Y104.166 E.00811
G1 X87.19 Y103.832 E.00736
G1 X87.153 Y103.633 E.00428
G1 X87.123 Y103.326 E.00652
G1 X87.129 Y102.98 E.00733
G1 X87.176 Y102.639 E.0073
G1 X87.263 Y102.305 E.0073
G1 X87.462 Y101.838 E.01074
G1 X87.747 Y101.406 E.01095
G1 X88.946 Y100.082 E.03782
G1 X53.819 Y100.082 E.74349
G1 X53.819 Y95.32 E.10078
G1 X121.419 Y95.32 E1.43081
G1 X121.419 Y93.92 E.02963
G1 X126.181 Y93.92 E.10078
G1 X126.181 Y101.482 E.16005
G1 X121.419 Y101.482 E.10078
G1 X121.419 Y100.142 E.02836
M204 S250
G1 X121.01 Y100.491 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X91.976 Y100.491 E.57107
G1 X92.568 Y101.145 E.01734
G1 X92.895 Y101.637 E.01163
G1 X93.126 Y102.177 E.01156
G1 X93.226 Y102.559 E.00775
G1 X93.289 Y103.142 E.01155
G1 X93.272 Y103.541 E.00785
G1 X93.159 Y104.117 E.01155
G1 X93.007 Y104.53 E.00866
G1 X92.746 Y105.012 E.01078
G1 X92.383 Y105.469 E.01148
G1 X92.055 Y105.767 E.00871
G1 X91.602 Y106.074 E.01076
G1 X91.207 Y106.26 E.0086
G1 X90.68 Y106.419 E.01082
G1 X90.099 Y106.489 E.01152
G1 X89.703 Y106.477 E.00779
G1 X89.124 Y106.372 E.01157
G1 X88.748 Y106.243 E.00782
G1 X88.227 Y105.972 E.01155
G1 X87.909 Y105.74 E.00775
G1 X87.62 Y105.472 E.00775
G1 X87.367 Y105.173 E.0077
G1 X87.077 Y104.708 E.01078
G1 X86.901 Y104.305 E.00865
G1 X86.791 Y103.926 E.00777
G1 X86.713 Y103.343 E.01157
G1 X86.72 Y102.949 E.00776
G1 X86.774 Y102.558 E.00775
G1 X86.874 Y102.177 E.00775
G1 X87.105 Y101.638 E.01155
G1 X87.316 Y101.298 E.00787
G1 X87.431 Y101.145 E.00375
G1 X88.024 Y100.491 E.01737
G1 X53.41 Y100.491 E.68082
G1 X53.41 Y94.911 E.10975
G1 X121.01 Y94.911 E1.32963
G1 X121.01 Y93.511 E.02754
G1 X126.59 Y93.511 E.10975
M73 P65 R12
G1 X126.59 Y101.891 E.16483
G1 X121.01 Y101.891 E.10975
G1 X121.01 Y100.551 E.02636
; WIPE_START
M204 S6000
G1 X119.01 Y100.547 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G17
G3 Z1.68 I1.217 J0 P1  F18000
; stop printing object, unique label id: 12
M625
; object ids of layer 10 start: 8,12
M624 AwAAAAAAAAA=
;===================== date: 20250206 =====================

; don't support timelapse gcode in spiral_mode and by object sequence for I3 structure printer
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
G92 E0
G1 Z1.68
G1 X0 Y85.35 ; move to safe pos
G1 X-13.0 F3000 ; move to safe pos
M400
M1004 S5 P1  ; external shutter
M400 P300
M971 S11 C11 O0
G92 E0
G1 X0 F18000
M623

; SKIPTYPE: head_wrap_detect
M622.1 S1
M1002 judge_flag g39_3rd_layer_detect_flag
M622 J1
    ; enable nozzle clog detect at 3rd layer
    


    M622.1 S1
    M1002 judge_flag g39_detection_flag
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




; object ids of this layer10 end: 8,12
M625
; start printing object, unique label id: 12
M624 AgAAAAAAAAA=
G1 X91.246 Y100.642
G1 Z1.28
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.0995862
G1 F1500
M204 S6000
G1 X91.124 Y100.55 E.00056
G1 X90.888 Y100.493 E.0009
; WIPE_START
G1 X91.124 Y100.55 E-.23362
G1 X91.246 Y100.642 E-.14638
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X89.118 Y100.493 Z1.68 F18000
G1 Z1.28
G1 E.4 F1800
; LINE_WIDTH: 0.100661
G1 F1500
M204 S6000
G1 X88.875 Y100.548 E.00093
G1 X88.763 Y100.633 E.00053
; WIPE_START
G1 X88.875 Y100.548 E-.1379
G1 X89.118 Y100.493 E-.2421
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X81.513 Y99.848 Z1.68 F18000
G1 X56.2 Y97.701 Z1.68
G1 Z1.28
G1 E.4 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.360652
G1 F1500
M204 S6000
G1 X121.996 Y97.701 E1.09933
; WIPE_START
G1 X119.996 Y97.701 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G17
G3 Z1.68 I-.731 J.973 P1  F18000
G1 X122.056 Y99.248 Z1.68
G1 Z1.28
G1 E.4 F1800
; LINE_WIDTH: 0.419992
G1 F1500
M204 S6000
G1 X122.174 Y99.287 E.00245
G1 X122.253 Y99.445 E.00347
G1 X122.253 Y100.648 E.02366
G1 X125.347 Y100.648 E.06087
G1 X125.347 Y94.753 E.11594
G1 X122.253 Y94.753 E.06087
G1 X122.253 Y95.956 E.02366
G1 X122.174 Y96.114 E.00347
G1 X122.056 Y96.153 E.00245
G1 X54.653 Y96.153 E1.32573
G1 X54.653 Y99.248 E.06087
G1 X121.996 Y99.248 E1.32455
M204 S10000
G1 X122.056 Y98.854 F18000
G1 F1500
M204 S6000
G1 X122.263 Y98.891 E.00415
G1 X122.41 Y98.972 E.0033
G1 X122.548 Y99.118 E.00394
G1 X122.647 Y99.445 E.00673
G1 X122.647 Y100.254 E.01591
G1 X124.953 Y100.254 E.04536
G1 X124.953 Y95.148 E.10043
G1 X122.647 Y95.148 E.04536
G1 X122.647 Y95.956 E.0159
G1 X122.548 Y96.284 E.00673
G1 X122.41 Y96.429 E.00394
G1 X122.263 Y96.51 E.0033
G1 X122.056 Y96.548 E.00415
G1 X55.047 Y96.548 E1.31797
G1 X55.047 Y98.854 E.04536
G1 X121.996 Y98.854 E1.31679
M204 S10000
G1 X122.056 Y98.46 F18000
G1 F1500
M204 S6000
G1 X122.402 Y98.522 E.00692
G1 X122.647 Y98.657 E.0055
G1 X122.876 Y98.9 E.00657
G1 X123.02 Y99.242 E.00731
G1 X123.041 Y99.86 E.01215
G1 X124.559 Y99.86 E.02985
G1 X124.559 Y95.542 E.08492
G1 X123.041 Y95.542 E.02985
G1 X123.02 Y96.159 E.01215
G1 X122.876 Y96.502 E.00731
G1 X122.647 Y96.745 E.00657
G1 X122.402 Y96.879 E.0055
G1 X122.056 Y96.942 E.00692
G1 X55.441 Y96.942 E1.31022
G1 X55.441 Y98.46 E.02985
G1 X121.996 Y98.46 E1.30904
M204 S10000
G1 X122.056 Y98.065 F18000
G1 F1500
M204 S6000
G1 X122.54 Y98.153 E.00968
G1 X122.884 Y98.341 E.0077
G1 X123.205 Y98.681 E.0092
G1 X123.406 Y99.161 E.01023
G1 X123.456 Y99.465 E.00607
G1 X124.165 Y99.465 E.01394
G1 X124.165 Y95.936 E.06941
G1 X123.435 Y95.936 E.01434
M73 P65 R11
G1 X123.406 Y96.241 E.00602
G1 X123.205 Y96.72 E.01023
M73 P66 R11
G1 X122.884 Y97.06 E.0092
G1 X122.54 Y97.248 E.0077
G1 X122.056 Y97.336 E.00968
G1 X55.835 Y97.336 E1.30247
G1 X55.835 Y98.065 E.01434
G1 X121.996 Y98.065 E1.30129
M204 S10000
G1 X122.056 Y97.701 F18000
; LINE_WIDTH: 0.375487
G1 F1500
M204 S6000
G1 X122.367 Y97.742 E.00548
; LINE_WIDTH: 0.419265
G1 X122.679 Y97.784 E.00617
G1 X123.12 Y98.026 E.00988
G1 X123.533 Y98.463 E.01181
G1 X123.77 Y99.029 E.01205
G1 X123.77 Y96.373 E.05215
G1 X123.533 Y96.939 E.01205
G1 X123.12 Y97.376 E.01181
G1 X122.679 Y97.618 E.00988
; LINE_WIDTH: 0.405157
G1 X122.397 Y97.655 E.00538
; LINE_WIDTH: 0.375487
G1 X122.115 Y97.693 E.00496
; WIPE_START
G1 X122.397 Y97.655 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G17
G3 Z1.68 I0 J1.217 P1  F18000
G1 X123.39 Y97.655 Z1.68
G1 Z1.28
G1 E.4 F1800
; LINE_WIDTH: 0.444372
G1 F1500
M204 S6000
G1 X123.338 Y97.655 E.00109
G1 X123.312 Y97.701 E.00109
G1 X123.338 Y97.746 E.00109
G1 X123.382 Y97.746 E.00093
; OBJECT_ID: 8
; WIPE_START
G1 X123.338 Y97.746 E-.08413
G1 X123.312 Y97.701 E-.09862
G1 X123.338 Y97.655 E-.09862
G1 X123.39 Y97.655 E-.09862
; WIPE_END
G1 E-.02 F1800
; stop printing object, unique label id: 12
M625
; start printing object, unique label id: 8
M624 AQAAAAAAAAA=
M204 S10000
G17
G3 Z1.68 I.786 J-.929 P1  F18000
G1 X92.402 Y71.457 Z1.68
G1 Z1.28
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X92.503 Y71.727 E.0061
G1 X92.574 Y72.01 E.00617
G1 X92.622 Y72.501 E.01043
G1 X92.574 Y72.991 E.01043
G1 X92.504 Y73.274 E.00617
G1 X92.391 Y73.575 E.00681
G1 X92.166 Y73.978 E.00975
G1 X91.868 Y74.341 E.00995
G1 X91.507 Y74.646 E.01001
G1 X91.08 Y74.888 E.01038
G1 X90.785 Y75.002 E.0067
G1 X90.497 Y75.074 E.00628
G1 X90.039 Y75.122 E.00975
G1 X89.57 Y75.087 E.00995
G1 X89.113 Y74.968 E.01
G1 X88.67 Y74.758 E.01038
G1 X88.427 Y74.597 E.00617
G1 X88.182 Y74.389 E.0068
G1 X87.877 Y74.04 E.00981
G1 X87.629 Y73.617 E.01038
G1 X87.52 Y73.346 E.00617
G1 X87.434 Y73.037 E.0068
G1 X87.381 Y72.588 E.00955
G1 X87.39 Y72.266 E.00683
G1 X87.438 Y71.947 E.00683
G1 X87.574 Y71.506 E.00975
G1 X87.791 Y71.089 E.00995
G1 X88.078 Y70.718 E.00995
G1 X88.42 Y70.409 E.00975
G1 X88.69 Y70.232 E.00683
G1 X88.978 Y70.087 E.00683
G1 X89.419 Y69.944 E.00981
G1 X89.905 Y69.882 E.01038
G1 X90.197 Y69.888 E.00617
G1 X90.516 Y69.931 E.00681
G1 X90.958 Y70.06 E.00975
G1 X91.37 Y70.266 E.00975
G1 X91.634 Y70.452 E.00683
G1 X91.874 Y70.668 E.00683
G1 X92.166 Y71.024 E.00975
G1 X92.377 Y71.403 E.00918
M204 S250
G1 X92.019 Y71.601 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X92.112 Y71.849 E.0052
G1 X92.169 Y72.08 E.00469
G1 X92.211 Y72.501 E.00832
G1 X92.169 Y72.922 E.00832
G1 X92.112 Y73.153 E.00468
G1 X92.018 Y73.403 E.00526
G1 X91.827 Y73.746 E.00773
G1 X91.575 Y74.052 E.0078
G1 X91.272 Y74.309 E.00781
G1 X90.905 Y74.517 E.0083
G1 X90.683 Y74.603 E.00469
G1 X90.424 Y74.67 E.00525
G1 X90.033 Y74.711 E.00774
G1 X89.638 Y74.682 E.0078
G1 X89.253 Y74.582 E.00781
G1 X88.872 Y74.401 E.0083
G1 X88.674 Y74.269 E.00469
G1 X88.47 Y74.096 E.00525
G1 X88.211 Y73.8 E.00775
G1 X87.998 Y73.436 E.0083
G1 X87.908 Y73.215 E.00469
G1 X87.837 Y72.957 E.00525
G1 X87.791 Y72.57 E.00767
G1 X87.799 Y72.303 E.00526
G1 X87.838 Y72.038 E.00526
G1 X87.954 Y71.662 E.00774
G1 X88.137 Y71.311 E.0078
G1 X88.379 Y70.997 E.00779
G1 X88.671 Y70.734 E.00773
G1 X88.895 Y70.587 E.00526
G1 X89.134 Y70.467 E.00526
G1 X89.509 Y70.345 E.00775
G1 X89.927 Y70.292 E.0083
G1 X90.166 Y70.297 E.00469
G1 X90.43 Y70.333 E.00525
G1 X90.808 Y70.443 E.00773
G1 X91.159 Y70.619 E.00774
G1 X91.378 Y70.773 E.00526
G1 X91.577 Y70.952 E.00526
G1 X91.827 Y71.255 E.00773
G1 X91.99 Y71.549 E.0066
; WIPE_START
M204 S6000
G1 X92.112 Y71.849 E-.06155
G1 X92.169 Y72.08 E-.04527
G1 X92.211 Y72.501 E-.08033
G1 X92.169 Y72.922 E-.08033
G1 X92.112 Y73.153 E-.04524
G1 X92.018 Y73.403 E-.05076
G1 X91.976 Y73.479 E-.01652
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X99.509 Y72.252 Z1.68 F18000
G1 X121.257 Y68.711 Z1.68
G1 Z1.28
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X121.257 Y68.957 E.00522
G1 X90.098 Y68.957 E.65951
G1 X90.602 Y69.515 E.01591
G1 X90.23 Y69.464 E.00795
G1 X89.883 Y69.458 E.00735
G1 X89.394 Y69.52 E.01044
G1 X89.902 Y68.957 E.01605
G1 X54.243 Y68.957 E.75475
G1 X54.243 Y65.044 E.08282
G1 X121.257 Y65.044 E1.41839
G1 X121.257 Y68.651 E.07633
; WIPE_START
M204 S6000
G1 X121.257 Y68.957 E-.05824
G1 X119.563 Y68.957 E-.32176
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X125.51 Y69.12 Z1.68 F18000
G1 Z1.28
G1 E.4 F1800
G1 F1500
M204 S500
G1 X121.681 Y69.12 E.08105
G1 X121.681 Y64.882 E.08971
G1 X125.919 Y64.882 E.08971
G1 X125.919 Y69.12 E.08971
G1 X125.57 Y69.12 E.00739
M204 S250
G1 X125.51 Y68.711 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X122.09 Y68.711 E.06727
G1 X122.09 Y65.291 E.06727
G1 X125.51 Y65.291 E.06727
G1 X125.51 Y68.651 E.06609
; WIPE_START
M204 S6000
G1 X123.51 Y68.686 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X115.879 Y68.839 Z1.68 F18000
G1 X88.946 Y69.382 Z1.68
G1 Z1.28
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X53.819 Y69.382 E.74349
G1 X53.819 Y64.62 E.10078
G1 X126.181 Y64.62 E1.53159
G1 X126.181 Y69.382 E.10078
G1 X91.054 Y69.382 E.74349
G1 X92.251 Y70.704 E.03775
G1 X92.371 Y70.867 E.00429
G1 X92.607 Y71.276 E.00999
G1 X92.737 Y71.605 E.0075
G1 X92.824 Y71.939 E.0073
G1 X92.872 Y72.289 E.00749
G1 X92.864 Y72.803 E.01087
G1 X92.835 Y73.003 E.00429
G1 X92.766 Y73.3 E.00646
M73 P67 R11
G1 X92.634 Y73.661 E.00814
G1 X92.4 Y74.091 E.01034
G1 X92.127 Y74.449 E.00955
G1 X91.802 Y74.745 E.0093
G1 X91.399 Y75.017 E.01028
G1 X91.059 Y75.177 E.00796
G1 X90.586 Y75.32 E.01046
G1 X90.088 Y75.379 E.01063
G1 X89.742 Y75.369 E.00733
G1 X89.408 Y75.319 E.00713
G1 X88.941 Y75.177 E.01034
G1 X88.594 Y75.013 E.00812
G1 X88.308 Y74.831 E.00717
G1 X88.014 Y74.584 E.00812
G1 X87.686 Y74.215 E.01046
G1 X87.423 Y73.787 E.01063
G1 X87.288 Y73.468 E.00733
G1 X87.19 Y73.132 E.00742
G1 X87.153 Y72.933 E.00428
G1 X87.123 Y72.626 E.00652
G1 X87.129 Y72.28 E.00733
G1 X87.176 Y71.939 E.0073
G1 X87.263 Y71.605 E.0073
G1 X87.462 Y71.138 E.01074
G1 X87.747 Y70.706 E.01095
G1 X88.906 Y69.426 E.03655
M204 S250
G1 X88.024 Y69.791 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X53.41 Y69.791 E.68082
G1 X53.41 Y64.211 E.10975
G1 X126.59 Y64.211 E1.43939
G1 X126.59 Y69.791 E.10975
G1 X91.976 Y69.791 E.68082
G1 X92.568 Y70.445 E.01734
G1 X92.895 Y70.937 E.01163
G1 X93.126 Y71.477 E.01156
G1 X93.226 Y71.859 E.00775
G1 X93.289 Y72.442 E.01155
G1 X93.272 Y72.841 E.00785
G1 X93.159 Y73.417 E.01155
G1 X93.007 Y73.83 E.00866
G1 X92.746 Y74.312 E.01078
G1 X92.383 Y74.769 E.01148
G1 X92.055 Y75.067 E.00871
G1 X91.602 Y75.374 E.01076
G1 X91.207 Y75.56 E.0086
G1 X90.68 Y75.719 E.01082
G1 X90.099 Y75.789 E.01152
G1 X89.705 Y75.777 E.00776
G1 X89.318 Y75.719 E.0077
G1 X88.793 Y75.56 E.01078
G1 X88.395 Y75.372 E.00865
G1 X88.065 Y75.161 E.00771
G1 X87.728 Y74.878 E.00865
G1 X87.363 Y74.467 E.01082
G1 X87.056 Y73.969 E.01151
G1 X86.902 Y73.606 E.00776
G1 X86.791 Y73.226 E.00779
G1 X86.713 Y72.643 E.01157
G1 X86.72 Y72.249 E.00776
G1 X86.774 Y71.858 E.00775
G1 X86.874 Y71.477 E.00775
G1 X87.105 Y70.938 E.01155
G1 X87.316 Y70.598 E.00787
G1 X87.431 Y70.445 E.00375
G1 X87.984 Y69.835 E.01619
M204 S10000
G1 X88.763 Y69.933 F18000
; FEATURE: Gap infill
; LINE_WIDTH: 0.100673
G1 F1500
M204 S6000
G1 X88.875 Y69.848 E.00053
G1 X89.118 Y69.793 E.00093
; WIPE_START
G1 X88.875 Y69.848 E-.2421
G1 X88.763 Y69.933 E-.1379
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X90.888 Y69.793 Z1.68 F18000
G1 Z1.28
G1 E.4 F1800
; LINE_WIDTH: 0.0995966
G1 F1500
M204 S6000
G1 X91.124 Y69.85 E.0009
G1 X91.246 Y69.942 E.00056
; WIPE_START
G1 X91.124 Y69.85 E-.14636
G1 X90.888 Y69.793 E-.23364
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X83.28 Y69.18 Z1.68 F18000
G1 X56.2 Y67.001 Z1.68
G1 Z1.28
G1 E.4 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.360632
G1 F1500
M204 S6000
G1 X119.24 Y67.001 E1.05322
M204 S10000
G1 X119.665 Y67.365 F18000
; LINE_WIDTH: 0.419992
G1 F1500
M204 S6000
G1 X119.665 Y66.636 E.01434
G1 X55.835 Y66.636 E1.25544
G1 X55.835 Y67.365 E.01434
G1 X119.605 Y67.365 E1.25426
M204 S10000
G1 X120.059 Y67.76 F18000
G1 F1500
M204 S6000
G1 X120.059 Y66.242 E.02985
G1 X55.441 Y66.242 E1.27095
G1 X55.441 Y67.76 E.02985
G1 X119.999 Y67.76 E1.26977
M204 S10000
G1 X120.453 Y68.154 F18000
G1 F1500
M204 S6000
G1 X120.453 Y65.848 E.04536
G1 X55.047 Y65.848 E1.28645
G1 X55.047 Y68.154 E.04536
G1 X120.393 Y68.154 E1.28527
M204 S10000
G1 X120.847 Y68.548 F18000
G1 F1500
M204 S6000
G1 X120.847 Y65.453 E.06087
G1 X54.653 Y65.453 E1.30196
G1 X54.653 Y68.548 E.06087
G1 X120.787 Y68.548 E1.30078
; CHANGE_LAYER
; Z_HEIGHT: 1.4
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F1500
G1 X118.787 Y68.548 E-.38
; WIPE_END
G1 E-.02 F1800
; stop printing object, unique label id: 8
M625
; layer num/total_layer_count: 11/51
; update layer progress
M73 L11
M991 S0 P10 ;notify layer change
; OBJECT_ID: 12
; start printing object, unique label id: 12
M624 AgAAAAAAAAA=
M204 S10000
G17
G3 Z1.68 I-.909 J-.809 P1  F18000
G1 X90.602 Y100.215 Z1.68
G1 Z1.4
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X90.229 Y100.164 E.00797
G1 X89.872 Y100.158 E.00756
G1 X89.394 Y100.22 E.0102
G1 X89.903 Y99.657 E.01606
G1 X54.243 Y99.657 E.75476
G1 X54.243 Y95.744 E.08282
G1 X121.843 Y95.744 E1.43081
G1 X121.843 Y94.344 E.02963
G1 X125.757 Y94.344 E.08282
G1 X125.757 Y101.057 E.14209
G1 X121.843 Y101.057 E.08282
G1 X121.843 Y99.657 E.02963
M73 P68 R11
G1 X90.097 Y99.657 E.67193
G1 X90.562 Y100.17 E.01464
; WIPE_START
M204 S6000
G1 X90.229 Y100.164 E-.06322
G1 X89.872 Y100.158 E-.06789
G1 X89.394 Y100.22 E-.09157
G1 X89.903 Y99.657 E-.14412
G1 X89.833 Y99.657 E-.0132
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X91.596 Y101.125 Z1.8 F18000
G1 Z1.4
G1 E.4 F1800
G1 F1500
M204 S500
G1 X91.634 Y101.153 E.001
G1 X91.874 Y101.368 E.00681
G1 X92.167 Y101.725 E.00979
G1 X92.399 Y102.147 E.01018
G1 X92.514 Y102.456 E.00698
G1 X92.58 Y102.742 E.00622
G1 X92.622 Y103.201 E.00975
G1 X92.579 Y103.671 E.00999
M73 P68 R10
G1 X92.449 Y104.134 E.01018
G1 X92.325 Y104.409 E.00638
G1 X92.16 Y104.685 E.00681
G1 X91.866 Y105.042 E.00979
G1 X91.498 Y105.351 E.01018
G1 X91.241 Y105.509 E.00638
M73 P69 R10
G1 X90.949 Y105.644 E.00681
G1 X90.507 Y105.773 E.00975
G1 X90.039 Y105.822 E.00995
G1 X89.58 Y105.788 E.00975
G1 X89.265 Y105.716 E.00683
G1 X88.961 Y105.607 E.00683
G1 X88.556 Y105.389 E.00975
G1 X88.188 Y105.096 E.00995
G1 X87.879 Y104.742 E.00995
G1 X87.637 Y104.337 E.00999
G1 X87.471 Y103.885 E.01018
G1 X87.409 Y103.591 E.00638
G1 X87.38 Y103.27 E.00681
G1 X87.407 Y102.819 E.00956
G1 X87.483 Y102.463 E.00771
G1 X87.578 Y102.198 E.00596
G1 X87.791 Y101.789 E.00975
G1 X88.079 Y101.416 E.00999
G1 X88.439 Y101.096 E.01018
G1 X88.691 Y100.931 E.00638
G1 X88.978 Y100.787 E.00681
G1 X89.418 Y100.644 E.00979
G1 X89.895 Y100.583 E.01018
G1 X90.197 Y100.588 E.00638
G1 X90.516 Y100.631 E.00681
G1 X90.96 Y100.761 E.00979
G1 X91.388 Y100.979 E.01018
G1 X91.547 Y101.091 E.0041
M204 S250
G1 X91.359 Y101.459 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X91.378 Y101.473 E.00046
G1 X91.577 Y101.652 E.00526
G1 X91.827 Y101.956 E.00775
G1 X92.026 Y102.318 E.00812
G1 X92.112 Y102.55 E.00487
G1 X92.176 Y102.809 E.00526
G1 X92.211 Y103.201 E.00773
G1 X92.175 Y103.596 E.00781
G1 X92.063 Y103.993 E.00812
G1 X91.962 Y104.219 E.00487
G1 X91.825 Y104.449 E.00526
G1 X91.575 Y104.753 E.00775
G1 X91.258 Y105.018 E.00812
G1 X91.047 Y105.147 E.00487
G1 X90.805 Y105.26 E.00525
G1 X90.427 Y105.37 E.00773
G1 X90.033 Y105.411 E.0078
G1 X89.641 Y105.382 E.00774
G1 X89.38 Y105.322 E.00526
G1 X89.128 Y105.232 E.00526
G1 X88.782 Y105.046 E.00773
G1 X88.472 Y104.799 E.0078
G1 X88.211 Y104.5 E.00779
G1 X88.008 Y104.16 E.00781
G1 X87.865 Y103.772 E.00812
G1 X87.814 Y103.53 E.00487
G1 X87.79 Y103.264 E.00526
G1 X87.814 Y102.874 E.00767
G1 X87.869 Y102.613 E.00526
G1 X87.956 Y102.359 E.00527
G1 X88.137 Y102.011 E.00773
G1 X88.38 Y101.697 E.00781
G1 X88.688 Y101.422 E.00812
G1 X88.895 Y101.286 E.00487
G1 X89.134 Y101.167 E.00526
G1 X89.509 Y101.045 E.00775
G1 X89.918 Y100.992 E.00812
G1 X90.165 Y100.997 E.00487
G1 X90.43 Y101.033 E.00526
G1 X90.808 Y101.143 E.00775
G1 X91.176 Y101.33 E.00812
G1 X91.31 Y101.425 E.00322
; WIPE_START
M204 S6000
G1 X91.378 Y101.473 E-.01586
G1 X91.577 Y101.652 E-.05078
G1 X91.827 Y101.956 E-.07483
G1 X92.026 Y102.318 E-.07843
G1 X92.112 Y102.55 E-.04703
G1 X92.176 Y102.809 E-.05078
G1 X92.205 Y103.136 E-.06229
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X99.796 Y102.342 Z1.8 F18000
G1 X121.419 Y100.082 Z1.8
G1 Z1.4
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X91.054 Y100.082 E.64271
G1 X92.247 Y101.4 E.03763
G1 X92.528 Y101.82 E.0107
G1 X92.685 Y102.163 E.00799
G1 X92.749 Y102.385 E.00488
G1 X92.62 Y102.428 E.00288
G1 X92.751 Y102.393 E.00288
G1 X92.825 Y102.647 E.00561
G1 X92.879 Y103.135 E.01039
G1 X92.846 Y103.637 E.01065
G1 X92.763 Y104.013 E.00815
G1 X92.705 Y104.188 E.00392
G1 X92.578 Y104.483 E.00678
G1 X92.405 Y104.786 E.00739
G1 X92.073 Y105.2 E.01123
G1 X91.695 Y105.529 E.0106
G1 X91.406 Y105.714 E.00727
G1 X91.104 Y105.862 E.00711
G1 X90.585 Y106.021 E.01149
G1 X90.087 Y106.079 E.01061
G1 X89.742 Y106.069 E.00732
G1 X89.394 Y106.016 E.00744
G1 X88.909 Y105.866 E.01074
G1 X88.578 Y105.703 E.00781
G1 X88.163 Y105.418 E.01065
G1 X87.917 Y105.189 E.00713
G1 X87.699 Y104.932 E.00712
G1 X87.442 Y104.523 E.01022
G1 X87.287 Y104.166 E.00824
G1 X87.155 Y103.647 E.01134
G1 X87.123 Y103.326 E.00683
G1 X87.129 Y102.982 E.00727
G1 X87.181 Y102.618 E.0078
G1 X87.246 Y102.399 E.00482
G1 X87.427 Y102.445 E.00394
G1 X87.25 Y102.389 E.00394
G1 X87.325 Y102.135 E.0056
G1 X87.471 Y101.822 E.00732
G1 X87.753 Y101.399 E.01075
G1 X88.946 Y100.082 E.03763
G1 X53.819 Y100.082 E.7435
G1 X53.819 Y95.32 E.10078
G1 X121.419 Y95.32 E1.43081
G1 X121.419 Y93.92 E.02963
G1 X126.181 Y93.92 E.10078
G1 X126.181 Y101.482 E.16005
G1 X121.419 Y101.482 E.10078
G1 X121.419 Y100.142 E.02836
M204 S250
G1 X121.01 Y100.491 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X91.976 Y100.491 E.57107
G1 X92.567 Y101.143 E.01731
G1 X92.796 Y101.467 E.00781
G1 X92.892 Y101.632 E.00374
G1 X93.069 Y102.02 E.0084
G1 X93.227 Y102.561 E.01108
G1 X93.289 Y103.14 E.01144
G1 X93.25 Y103.705 E.01114
G1 X93.158 Y104.122 E.00839
G1 X93.088 Y104.334 E.0044
G1 X92.944 Y104.668 E.00714
G1 X92.73 Y105.034 E.00835
G1 X92.376 Y105.476 E.01113
G1 X91.936 Y105.861 E.01151
G1 X91.604 Y106.073 E.00774
G1 X91.221 Y106.254 E.00835
G1 X90.68 Y106.419 E.01113
G1 X90.099 Y106.489 E.01151
G1 X89.705 Y106.477 E.00775
G1 X89.313 Y106.418 E.00779
G1 X88.752 Y106.244 E.01155
G1 X88.371 Y106.057 E.00835
G1 X87.907 Y105.738 E.01108
G1 X87.62 Y105.472 E.0077
G1 X87.368 Y105.173 E.00769
G1 X87.07 Y104.695 E.01108
G1 X86.901 Y104.305 E.00835
G1 X86.791 Y103.926 E.00778
G1 X86.713 Y103.343 E.01156
G1 X86.72 Y102.949 E.00774
G1 X86.781 Y102.529 E.00834
G1 X86.942 Y101.99 E.01108
G1 X87.204 Y101.467 E.0115
G1 X87.433 Y101.143 E.00781
G1 X88.024 Y100.491 E.01731
G1 X53.41 Y100.491 E.68082
G1 X53.41 Y94.911 E.10975
G1 X121.01 Y94.911 E1.32963
G1 X121.01 Y93.511 E.02754
G1 X126.59 Y93.511 E.10975
G1 X126.59 Y101.891 E.16483
G1 X121.01 Y101.891 E.10975
G1 X121.01 Y100.551 E.02636
; WIPE_START
M204 S6000
G1 X119.01 Y100.547 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G17
G3 Z1.8 I1.217 J0 P1  F18000
; stop printing object, unique label id: 12
M625
; object ids of layer 11 start: 8,12
M624 AwAAAAAAAAA=
;===================== date: 20250206 =====================

; don't support timelapse gcode in spiral_mode and by object sequence for I3 structure printer
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
G92 E0
G1 Z1.8
G1 X0 Y85.35 ; move to safe pos
G1 X-13.0 F3000 ; move to safe pos
M400
M1004 S5 P1  ; external shutter
M400 P300
M971 S11 C11 O0
G92 E0
G1 X0 F18000
M623

; SKIPTYPE: head_wrap_detect
M622.1 S1
M1002 judge_flag g39_3rd_layer_detect_flag
M622 J1
    ; enable nozzle clog detect at 3rd layer
    


    M622.1 S1
    M1002 judge_flag g39_detection_flag
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




; object ids of this layer11 end: 8,12
M625
; start printing object, unique label id: 12
M624 AgAAAAAAAAA=
G1 X91.247 Y100.644
G1 Z1.4
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.0995714
G1 F1500
M204 S6000
G1 X91.124 Y100.55 E.00057
G1 X90.887 Y100.493 E.0009
; WIPE_START
G1 X91.124 Y100.55 E-.2325
G1 X91.247 Y100.644 E-.1475
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X89.113 Y100.495 Z1.8 F18000
G1 Z1.4
G1 E.4 F1800
; LINE_WIDTH: 0.100118
G1 F1500
M204 S6000
G1 X88.874 Y100.549 E.00091
G1 X88.763 Y100.633 E.00052
; WIPE_START
G1 X88.874 Y100.549 E-.13757
G1 X89.113 Y100.495 E-.24243
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X81.508 Y99.849 Z1.8 F18000
G1 X56.2 Y97.701 Z1.8
G1 Z1.4
G1 E.4 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.360652
G1 F1500
M204 S6000
G1 X121.996 Y97.701 E1.09933
; WIPE_START
G1 X119.996 Y97.701 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G17
M73 P70 R10
G3 Z1.8 I-.731 J.973 P1  F18000
G1 X122.056 Y99.248 Z1.8
G1 Z1.4
G1 E.4 F1800
; LINE_WIDTH: 0.419992
G1 F1500
M204 S6000
G1 X122.174 Y99.287 E.00245
G1 X122.253 Y99.445 E.00347
G1 X122.253 Y100.648 E.02366
G1 X125.347 Y100.648 E.06087
G1 X125.347 Y94.753 E.11594
G1 X122.253 Y94.753 E.06087
G1 X122.253 Y95.956 E.02366
G1 X122.174 Y96.114 E.00347
G1 X122.056 Y96.153 E.00245
G1 X54.653 Y96.153 E1.32573
G1 X54.653 Y99.248 E.06087
G1 X121.996 Y99.248 E1.32455
M204 S10000
G1 X122.056 Y98.854 F18000
G1 F1500
M204 S6000
G1 X122.263 Y98.891 E.00415
G1 X122.41 Y98.972 E.0033
G1 X122.548 Y99.118 E.00394
G1 X122.647 Y99.445 E.00673
G1 X122.647 Y100.254 E.01591
G1 X124.953 Y100.254 E.04536
G1 X124.953 Y95.148 E.10043
G1 X122.647 Y95.148 E.04536
G1 X122.647 Y95.956 E.0159
G1 X122.548 Y96.284 E.00673
G1 X122.41 Y96.429 E.00394
G1 X122.263 Y96.51 E.0033
G1 X122.056 Y96.548 E.00415
G1 X55.047 Y96.548 E1.31797
G1 X55.047 Y98.854 E.04536
G1 X121.996 Y98.854 E1.31679
M204 S10000
G1 X122.056 Y98.46 F18000
G1 F1500
M204 S6000
G1 X122.402 Y98.522 E.00692
G1 X122.647 Y98.657 E.0055
G1 X122.876 Y98.9 E.00657
G1 X123.02 Y99.242 E.00731
G1 X123.041 Y99.86 E.01215
G1 X124.559 Y99.86 E.02985
G1 X124.559 Y95.542 E.08492
G1 X123.041 Y95.542 E.02985
G1 X123.02 Y96.159 E.01215
G1 X122.876 Y96.502 E.00731
G1 X122.647 Y96.745 E.00657
G1 X122.402 Y96.879 E.0055
G1 X122.056 Y96.942 E.00692
G1 X55.441 Y96.942 E1.31022
G1 X55.441 Y98.46 E.02985
G1 X121.996 Y98.46 E1.30904
M204 S10000
G1 X122.056 Y98.065 F18000
G1 F1500
M204 S6000
G1 X122.54 Y98.153 E.00968
G1 X122.884 Y98.341 E.0077
G1 X123.205 Y98.681 E.0092
G1 X123.406 Y99.161 E.01023
G1 X123.456 Y99.465 E.00607
G1 X124.165 Y99.465 E.01394
G1 X124.165 Y95.936 E.06941
G1 X123.435 Y95.936 E.01434
G1 X123.406 Y96.241 E.00602
G1 X123.205 Y96.72 E.01023
G1 X122.884 Y97.06 E.0092
G1 X122.54 Y97.248 E.0077
G1 X122.056 Y97.336 E.00968
G1 X55.835 Y97.336 E1.30247
G1 X55.835 Y98.065 E.01434
G1 X121.996 Y98.065 E1.30129
M204 S10000
G1 X122.056 Y97.701 F18000
; LINE_WIDTH: 0.375487
G1 F1500
M204 S6000
G1 X122.367 Y97.742 E.00548
; LINE_WIDTH: 0.419265
G1 X122.679 Y97.784 E.00617
G1 X123.12 Y98.026 E.00988
G1 X123.533 Y98.463 E.01181
G1 X123.77 Y99.029 E.01205
G1 X123.77 Y96.373 E.05215
G1 X123.533 Y96.939 E.01205
G1 X123.12 Y97.376 E.01181
G1 X122.679 Y97.618 E.00988
; LINE_WIDTH: 0.405157
G1 X122.397 Y97.655 E.00538
; LINE_WIDTH: 0.375487
G1 X122.115 Y97.693 E.00496
; WIPE_START
G1 X122.397 Y97.655 E-.38
; WIPE_END
M73 P71 R10
G1 E-.02 F1800
M204 S10000
G17
G3 Z1.8 I0 J1.217 P1  F18000
G1 X123.39 Y97.655 Z1.8
G1 Z1.4
G1 E.4 F1800
; LINE_WIDTH: 0.444372
G1 F1500
M204 S6000
G1 X123.338 Y97.655 E.00109
G1 X123.312 Y97.701 E.00109
G1 X123.338 Y97.746 E.00109
G1 X123.382 Y97.746 E.00093
; OBJECT_ID: 8
; WIPE_START
G1 X123.338 Y97.746 E-.08413
G1 X123.312 Y97.701 E-.09862
G1 X123.338 Y97.655 E-.09862
G1 X123.39 Y97.655 E-.09862
; WIPE_END
G1 E-.02 F1800
; stop printing object, unique label id: 12
M625
; start printing object, unique label id: 8
M624 AQAAAAAAAAA=
M204 S10000
G17
G3 Z1.8 I.786 J-.929 P1  F18000
G1 X92.376 Y71.405 Z1.8
G1 Z1.4
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X92.399 Y71.447 E.00102
G1 X92.514 Y71.756 E.00698
G1 X92.58 Y72.042 E.00622
G1 X92.622 Y72.501 E.00975
G1 X92.579 Y72.971 E.00999
G1 X92.449 Y73.433 E.01018
G1 X92.313 Y73.737 E.00704
G1 X92.16 Y73.985 E.00616
G1 X91.866 Y74.342 E.00979
G1 X91.498 Y74.651 E.01018
G1 X91.241 Y74.809 E.00638
G1 X90.949 Y74.944 E.00681
G1 X90.507 Y75.073 E.00975
G1 X90.039 Y75.122 E.00995
M73 P71 R9
G1 X89.58 Y75.088 E.00975
G1 X89.265 Y75.016 E.00683
G1 X88.961 Y74.907 E.00683
G1 X88.556 Y74.689 E.00975
G1 X88.188 Y74.396 E.00995
G1 X87.879 Y74.042 E.00995
G1 X87.637 Y73.637 E.00999
G1 X87.471 Y73.185 E.01018
G1 X87.409 Y72.891 E.00638
G1 X87.38 Y72.57 E.00681
G1 X87.407 Y72.119 E.00956
G1 X87.483 Y71.763 E.00771
G1 X87.578 Y71.498 E.00596
G1 X87.791 Y71.089 E.00975
G1 X88.079 Y70.716 E.00999
G1 X88.439 Y70.396 E.01018
G1 X88.691 Y70.231 E.00638
G1 X88.978 Y70.087 E.00681
G1 X89.418 Y69.944 E.00979
G1 X89.895 Y69.883 E.01018
G1 X90.197 Y69.888 E.00638
G1 X90.516 Y69.931 E.00681
G1 X90.96 Y70.061 E.00979
G1 X91.388 Y70.279 E.01018
G1 X91.634 Y70.453 E.00638
G1 X91.874 Y70.668 E.00681
G1 X92.167 Y71.025 E.00979
G1 X92.347 Y71.352 E.00789
M204 S250
G1 X92.017 Y71.602 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X92.026 Y71.618 E.00036
G1 X92.112 Y71.85 E.00487
G1 X92.176 Y72.109 E.00526
G1 X92.211 Y72.501 E.00773
G1 X92.175 Y72.896 E.00781
G1 X92.063 Y73.293 E.00812
G1 X91.962 Y73.519 E.00487
G1 X91.825 Y73.749 E.00526
G1 X91.575 Y74.053 E.00775
G1 X91.258 Y74.318 E.00812
G1 X91.047 Y74.447 E.00487
G1 X90.805 Y74.56 E.00525
G1 X90.427 Y74.67 E.00773
G1 X90.033 Y74.711 E.0078
G1 X89.641 Y74.682 E.00774
G1 X89.38 Y74.622 E.00526
G1 X89.128 Y74.532 E.00526
G1 X88.782 Y74.346 E.00773
G1 X88.472 Y74.099 E.0078
G1 X88.211 Y73.8 E.00779
G1 X88.008 Y73.46 E.00781
G1 X87.865 Y73.072 E.00812
G1 X87.814 Y72.83 E.00487
G1 X87.79 Y72.564 E.00526
G1 X87.814 Y72.174 E.00767
G1 X87.869 Y71.913 E.00526
G1 X87.956 Y71.659 E.00527
G1 X88.137 Y71.311 E.00773
G1 X88.38 Y70.997 E.00781
G1 X88.688 Y70.722 E.00812
G1 X88.895 Y70.586 E.00487
G1 X89.134 Y70.467 E.00526
G1 X89.509 Y70.345 E.00775
G1 X89.918 Y70.292 E.00812
G1 X90.165 Y70.297 E.00487
G1 X90.43 Y70.333 E.00526
G1 X90.808 Y70.443 E.00775
G1 X91.176 Y70.63 E.00812
G1 X91.378 Y70.773 E.00487
G1 X91.577 Y70.952 E.00526
G1 X91.827 Y71.256 E.00775
G1 X91.988 Y71.549 E.00658
; WIPE_START
M204 S6000
G1 X92.026 Y71.618 E-.01485
G1 X92.112 Y71.85 E-.04703
G1 X92.176 Y72.109 E-.05078
G1 X92.211 Y72.501 E-.0747
G1 X92.175 Y72.896 E-.07542
G1 X92.063 Y73.293 E-.07844
G1 X91.979 Y73.48 E-.03879
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X99.513 Y72.253 Z1.8 F18000
G1 X121.257 Y68.711 Z1.8
G1 Z1.4
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X121.257 Y68.957 E.00522
G1 X90.097 Y68.957 E.65951
G1 X90.602 Y69.515 E.01591
G1 X90.229 Y69.464 E.00797
G1 X89.872 Y69.458 E.00756
G1 X89.394 Y69.52 E.0102
G1 X89.903 Y68.957 E.01606
G1 X54.243 Y68.957 E.75476
G1 X54.243 Y65.044 E.08282
G1 X121.257 Y65.044 E1.41839
G1 X121.257 Y68.651 E.07633
; WIPE_START
M204 S6000
G1 X121.257 Y68.957 E-.05824
G1 X119.563 Y68.957 E-.32176
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X125.51 Y69.12 Z1.8 F18000
G1 Z1.4
G1 E.4 F1800
G1 F1500
M204 S500
G1 X121.681 Y69.12 E.08105
G1 X121.681 Y64.882 E.08971
G1 X125.919 Y64.882 E.08971
G1 X125.919 Y69.12 E.08971
G1 X125.57 Y69.12 E.00739
M204 S250
G1 X125.51 Y68.711 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X122.09 Y68.711 E.06727
G1 X122.09 Y65.291 E.06727
G1 X125.51 Y65.291 E.06727
G1 X125.51 Y68.651 E.06609
; WIPE_START
M204 S6000
G1 X123.51 Y68.686 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X115.879 Y68.839 Z1.8 F18000
G1 X88.946 Y69.382 Z1.8
G1 Z1.4
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X53.819 Y69.382 E.7435
G1 X53.819 Y64.62 E.10078
G1 X126.181 Y64.62 E1.53159
G1 X126.181 Y69.382 E.10078
G1 X91.054 Y69.382 E.74349
G1 X92.247 Y70.7 E.03763
G1 X92.528 Y71.12 E.0107
G1 X92.685 Y71.463 E.00799
G1 X92.749 Y71.685 E.00488
G1 X92.62 Y71.728 E.00288
G1 X92.751 Y71.692 E.00288
G1 X92.825 Y71.947 E.00561
G1 X92.88 Y72.443 E.01057
G1 X92.864 Y72.804 E.00764
G1 X92.838 Y72.989 E.00396
G1 X92.766 Y73.302 E.00679
G1 X92.64 Y73.648 E.00781
G1 X92.53 Y73.85 E.00486
G1 X92.394 Y73.783 E.00323
G1 X92.526 Y73.858 E.00323
G1 X92.397 Y74.097 E.00574
G1 X92.079 Y74.493 E.01075
G1 X91.695 Y74.829 E.0108
G1 X91.406 Y75.014 E.00727
M73 P72 R9
G1 X91.105 Y75.162 E.0071
G1 X90.585 Y75.321 E.01151
G1 X90.087 Y75.379 E.01061
G1 X89.742 Y75.369 E.00732
G1 X89.394 Y75.316 E.00744
G1 X88.909 Y75.166 E.01074
G1 X88.578 Y75.003 E.00781
G1 X88.163 Y74.718 E.01065
G1 X87.917 Y74.489 E.00713
G1 X87.699 Y74.232 E.00712
G1 X87.442 Y73.823 E.01022
G1 X87.287 Y73.466 E.00824
G1 X87.155 Y72.947 E.01135
G1 X87.123 Y72.626 E.00683
G1 X87.129 Y72.282 E.00727
G1 X87.181 Y71.918 E.0078
G1 X87.246 Y71.699 E.00482
G1 X87.427 Y71.745 E.00394
G1 X87.25 Y71.689 E.00394
G1 X87.325 Y71.435 E.0056
G1 X87.471 Y71.122 E.00732
G1 X87.753 Y70.699 E.01075
G1 X88.906 Y69.426 E.03636
M204 S250
G1 X88.024 Y69.791 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X53.41 Y69.791 E.68082
G1 X53.41 Y64.211 E.10975
G1 X126.59 Y64.211 E1.43939
G1 X126.59 Y69.791 E.10975
G1 X91.976 Y69.791 E.68082
G1 X92.567 Y70.443 E.01731
G1 X92.796 Y70.767 E.00781
G1 X92.892 Y70.932 E.00374
G1 X93.069 Y71.32 E.0084
G1 X93.227 Y71.861 E.01108
G1 X93.289 Y72.442 E.0115
G1 X93.272 Y72.841 E.00785
G1 X93.159 Y73.418 E.01155
G1 X93.014 Y73.817 E.00835
G1 X92.745 Y74.314 E.01112
G1 X92.379 Y74.773 E.01156
G1 X91.936 Y75.161 E.01157
G1 X91.604 Y75.373 E.00774
G1 X91.221 Y75.554 E.00835
G1 X90.68 Y75.719 E.01113
G1 X90.099 Y75.789 E.01151
G1 X89.705 Y75.777 E.00775
G1 X89.313 Y75.718 E.00779
G1 X88.752 Y75.544 E.01155
G1 X88.371 Y75.357 E.00835
G1 X87.907 Y75.038 E.01108
G1 X87.62 Y74.772 E.0077
G1 X87.368 Y74.473 E.00769
G1 X87.07 Y73.995 E.01108
G1 X86.901 Y73.605 E.00835
G1 X86.791 Y73.226 E.00778
G1 X86.713 Y72.643 E.01156
G1 X86.72 Y72.249 E.00774
G1 X86.781 Y71.829 E.00834
G1 X86.942 Y71.29 E.01108
G1 X87.204 Y70.767 E.0115
G1 X87.433 Y70.443 E.00781
G1 X87.984 Y69.835 E.01613
M204 S10000
G1 X88.763 Y69.933 F18000
; FEATURE: Gap infill
; LINE_WIDTH: 0.100118
G1 F1500
M204 S6000
G1 X88.874 Y69.849 E.00052
G1 X89.113 Y69.795 E.00091
; WIPE_START
G1 X88.874 Y69.849 E-.24242
G1 X88.763 Y69.933 E-.13758
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X90.887 Y69.793 Z1.8 F18000
G1 Z1.4
G1 E.4 F1800
; LINE_WIDTH: 0.0995713
G1 F1500
M204 S6000
G1 X91.124 Y69.85 E.0009
G1 X91.247 Y69.944 E.00057
; WIPE_START
G1 X91.124 Y69.85 E-.1475
G1 X90.887 Y69.793 E-.2325
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X83.28 Y69.18 Z1.8 F18000
G1 X56.2 Y67.001 Z1.8
G1 Z1.4
G1 E.4 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.360642
G1 F1500
M204 S6000
G1 X119.24 Y67.001 E1.05326
M204 S10000
G1 X119.665 Y67.365 F18000
; LINE_WIDTH: 0.419992
G1 F1500
M204 S6000
G1 X119.665 Y66.636 E.01434
G1 X55.835 Y66.636 E1.25544
G1 X55.835 Y67.365 E.01434
G1 X119.605 Y67.365 E1.25426
M204 S10000
G1 X120.059 Y67.76 F18000
G1 F1500
M204 S6000
G1 X120.059 Y66.242 E.02985
G1 X55.441 Y66.242 E1.27095
G1 X55.441 Y67.76 E.02985
G1 X119.999 Y67.76 E1.26977
M204 S10000
G1 X120.453 Y68.154 F18000
G1 F1500
M204 S6000
G1 X120.453 Y65.848 E.04536
G1 X55.047 Y65.848 E1.28645
G1 X55.047 Y68.154 E.04536
G1 X120.393 Y68.154 E1.28527
M204 S10000
G1 X120.847 Y68.548 F18000
G1 F1500
M204 S6000
G1 X120.847 Y65.453 E.06087
G1 X54.653 Y65.453 E1.30196
G1 X54.653 Y68.548 E.06087
G1 X120.787 Y68.548 E1.30078
; CHANGE_LAYER
; Z_HEIGHT: 1.52
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F1500
G1 X118.787 Y68.548 E-.38
; WIPE_END
G1 E-.02 F1800
; stop printing object, unique label id: 8
M625
; layer num/total_layer_count: 12/51
; update layer progress
M73 L12
M991 S0 P11 ;notify layer change
; OBJECT_ID: 12
; start printing object, unique label id: 12
M624 AgAAAAAAAAA=
M204 S10000
G17
G3 Z1.8 I-.909 J-.809 P1  F18000
G1 X90.602 Y100.215 Z1.8
G1 Z1.52
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X90.228 Y100.164 E.00798
G1 X89.861 Y100.158 E.00778
G1 X89.393 Y100.22 E.00998
G1 X89.903 Y99.657 E.01606
G1 X54.243 Y99.657 E.75475
G1 X54.243 Y95.744 E.08282
G1 X121.843 Y95.744 E1.43081
G1 X121.843 Y94.344 E.02963
G1 X125.757 Y94.344 E.08282
G1 X125.757 Y101.057 E.14209
G1 X121.843 Y101.057 E.08282
G1 X121.843 Y99.657 E.02963
G1 X90.097 Y99.657 E.67193
G1 X90.562 Y100.17 E.01464
; WIPE_START
M204 S6000
G1 X90.228 Y100.164 E-.06335
G1 X89.861 Y100.158 E-.06984
G1 X89.393 Y100.22 E-.08956
G1 X89.903 Y99.657 E-.14414
G1 X89.834 Y99.657 E-.01312
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X91.602 Y101.13 Z1.92 F18000
G1 Z1.52
M73 P73 R9
G1 E.4 F1800
G1 F1500
M204 S500
G1 X91.634 Y101.152 E.00082
G1 X91.874 Y101.368 E.00683
G1 X92.167 Y101.725 E.00977
G1 X92.395 Y102.137 E.00998
G1 X92.504 Y102.429 E.00659
G1 X92.58 Y102.742 E.00682
G1 X92.622 Y103.201 E.00975
G1 X92.58 Y103.67 E.00997
G1 X92.453 Y104.124 E.00998
G1 X92.326 Y104.408 E.00659
G1 X92.16 Y104.685 E.00682
G1 X91.868 Y105.041 E.00975
G1 X91.509 Y105.345 E.00995
G1 X91.11 Y105.575 E.00975
G1 X90.81 Y105.693 E.00683
G1 X90.497 Y105.774 E.00683
G1 X90.039 Y105.822 E.00975
G1 X89.571 Y105.787 E.00995
G1 X89.116 Y105.669 E.00995
G1 X88.697 Y105.475 E.00976
G1 X88.428 Y105.297 E.00683
G1 X88.182 Y105.089 E.00683
G1 X87.879 Y104.742 E.00975
G1 X87.643 Y104.346 E.00975
G1 X87.52 Y104.048 E.00683
G1 X87.434 Y103.737 E.00684
G1 X87.379 Y103.279 E.00975
G1 X87.408 Y102.809 E.00997
G1 X87.521 Y102.351 E.00998
G1 X87.639 Y102.064 E.00659
G1 X87.796 Y101.782 E.00682
M73 P74 R9
G1 X88.079 Y101.417 E.00977
G1 X88.43 Y101.102 E.00998
G1 X88.69 Y100.931 E.00659
G1 X88.978 Y100.787 E.00682
G1 X89.417 Y100.644 E.00978
G1 X89.885 Y100.583 E.00998
G1 X90.196 Y100.588 E.00659
G1 X90.516 Y100.631 E.00682
G1 X90.958 Y100.76 E.00975
G1 X91.37 Y100.966 E.00975
G1 X91.553 Y101.095 E.00474
M204 S250
G1 X91.367 Y101.465 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X91.378 Y101.473 E.00028
G1 X91.577 Y101.652 E.00526
G1 X91.827 Y101.956 E.00774
G1 X92.022 Y102.309 E.00794
G1 X92.112 Y102.549 E.00505
G1 X92.176 Y102.809 E.00526
G1 X92.211 Y103.201 E.00773
G1 X92.175 Y103.596 E.0078
G1 X92.067 Y103.985 E.00794
G1 X91.962 Y104.219 E.00505
G1 X91.825 Y104.449 E.00526
G1 X91.575 Y104.752 E.00773
G1 X91.273 Y105.009 E.0078
G1 X90.932 Y105.205 E.00774
G1 X90.683 Y105.303 E.00526
G1 X90.424 Y105.37 E.00526
G1 X90.033 Y105.411 E.00773
G1 X89.638 Y105.382 E.0078
G1 X89.254 Y105.282 E.00779
G1 X88.897 Y105.117 E.00774
G1 X88.674 Y104.969 E.00526
G1 X88.47 Y104.796 E.00526
G1 X88.211 Y104.5 E.00773
G1 X88.01 Y104.163 E.00774
G1 X87.908 Y103.915 E.00526
G1 X87.837 Y103.657 E.00527
G1 X87.79 Y103.267 E.00773
G1 X87.814 Y102.871 E.0078
G1 X87.911 Y102.479 E.00794
G1 X88.009 Y102.242 E.00505
G1 X88.139 Y102.008 E.00526
G1 X88.38 Y101.697 E.00774
G1 X88.681 Y101.428 E.00794
G1 X88.895 Y101.286 E.00505
G1 X89.134 Y101.167 E.00526
G1 X89.508 Y101.045 E.00774
G1 X89.909 Y100.992 E.00794
G1 X90.165 Y100.997 E.00505
G1 X90.43 Y101.033 E.00526
G1 X90.808 Y101.143 E.00773
G1 X91.159 Y101.319 E.00773
G1 X91.318 Y101.43 E.0038
; WIPE_START
M204 S6000
G1 X91.378 Y101.473 E-.01409
G1 X91.577 Y101.652 E-.05082
G1 X91.827 Y101.956 E-.07477
G1 X92.022 Y102.309 E-.07671
G1 X92.112 Y102.549 E-.04879
G1 X92.176 Y102.809 E-.05081
G1 X92.206 Y103.145 E-.06401
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X99.797 Y102.349 Z1.92 F18000
G1 X121.419 Y100.082 Z1.92
G1 Z1.52
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X91.054 Y100.082 E.64271
G1 X92.253 Y101.406 E.03782
G1 X92.537 Y101.837 E.01091
G1 X92.737 Y102.304 E.01076
G1 X92.824 Y102.639 E.00731
G1 X92.88 Y103.152 E.01094
G1 X92.851 Y103.62 E.00991
G1 X92.763 Y104.014 E.00856
G1 X92.577 Y104.486 E.01072
G1 X92.312 Y104.918 E.01074
G1 X92.083 Y105.189 E.0075
G1 X91.824 Y105.43 E.00749
G1 X91.405 Y105.714 E.01072
G1 X91.078 Y105.871 E.00768
G1 X90.759 Y105.979 E.00713
G1 X90.423 Y106.049 E.00726
G1 X90.087 Y106.079 E.00713
G1 X89.742 Y106.069 E.00731
G1 X89.391 Y106.016 E.0075
G1 X88.908 Y105.865 E.01072
G1 X88.582 Y105.706 E.00768
G1 X88.298 Y105.524 E.00713
G1 X87.917 Y105.189 E.01075
G1 X87.6 Y104.792 E.01075
G1 X87.423 Y104.486 E.00749
G1 X87.288 Y104.168 E.0073
G1 X87.157 Y103.661 E.01109
G1 X87.123 Y103.325 E.00714
G1 X87.129 Y102.981 E.00729
G1 X87.18 Y102.622 E.00767
G1 X87.318 Y102.151 E.01039
G1 X87.471 Y101.822 E.00769
G1 X87.753 Y101.4 E.01074
G1 X88.946 Y100.082 E.03763
G1 X53.819 Y100.082 E.74349
G1 X53.819 Y95.32 E.10078
G1 X121.419 Y95.32 E1.43081
G1 X121.419 Y93.92 E.02963
G1 X126.181 Y93.92 E.10078
G1 X126.181 Y101.482 E.16005
G1 X121.419 Y101.482 E.10078
M73 P74 R8
G1 X121.419 Y100.142 E.02836
M204 S250
G1 X121.01 Y100.491 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X91.976 Y100.491 E.57107
G1 X92.569 Y101.145 E.01737
G1 X92.684 Y101.298 E.00375
G1 X92.895 Y101.637 E.00786
G1 X93.126 Y102.177 E.01156
G1 X93.226 Y102.559 E.00775
G1 X93.289 Y103.146 E.01161
G1 X93.248 Y103.717 E.01126
G1 X93.158 Y104.122 E.00817
G1 X93.1 Y104.303 E.00374
G1 X92.944 Y104.669 E.00781
G1 X92.636 Y105.169 E.01155
G1 X92.38 Y105.472 E.00781
G1 X91.938 Y105.859 E.01155
G1 X91.604 Y106.073 E.0078
G1 X91.232 Y106.25 E.00811
G1 X90.873 Y106.373 E.00746
G1 X90.476 Y106.455 E.00797
G1 X90.099 Y106.489 E.00746
G1 X89.705 Y106.477 E.00775
G1 X89.312 Y106.418 E.00781
G1 X88.752 Y106.244 E.01154
G1 X88.381 Y106.064 E.0081
G1 X87.911 Y105.742 E.01121
G1 X87.62 Y105.472 E.00781
G1 X87.254 Y105.013 E.01156
G1 X87.056 Y104.669 E.00781
G1 X86.902 Y104.306 E.00775
G1 X86.791 Y103.925 E.0078
G1 X86.713 Y103.343 E.01156
G1 X86.72 Y102.949 E.00775
G1 X86.778 Y102.541 E.0081
G1 X86.874 Y102.175 E.00746
G1 X87.108 Y101.632 E.01162
G1 X87.204 Y101.467 E.00376
G1 X87.433 Y101.143 E.00781
G1 X88.024 Y100.491 E.01731
G1 X53.41 Y100.491 E.68082
G1 X53.41 Y94.911 E.10975
G1 X121.01 Y94.911 E1.32963
G1 X121.01 Y93.511 E.02754
G1 X126.59 Y93.511 E.10975
G1 X126.59 Y101.891 E.16483
G1 X121.01 Y101.891 E.10975
G1 X121.01 Y100.551 E.02636
; WIPE_START
M204 S6000
G1 X119.01 Y100.547 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G17
G3 Z1.92 I1.217 J0 P1  F18000
; stop printing object, unique label id: 12
M625
; object ids of layer 12 start: 8,12
M624 AwAAAAAAAAA=
;===================== date: 20250206 =====================

; don't support timelapse gcode in spiral_mode and by object sequence for I3 structure printer
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
G92 E0
G1 Z1.92
G1 X0 Y85.35 ; move to safe pos
G1 X-13.0 F3000 ; move to safe pos
M400
M1004 S5 P1  ; external shutter
M400 P300
M971 S11 C11 O0
G92 E0
G1 X0 F18000
M623

; SKIPTYPE: head_wrap_detect
M622.1 S1
M1002 judge_flag g39_3rd_layer_detect_flag
M622 J1
    ; enable nozzle clog detect at 3rd layer
    


    M622.1 S1
    M1002 judge_flag g39_detection_flag
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




; object ids of this layer12 end: 8,12
M625
; start printing object, unique label id: 12
M624 AgAAAAAAAAA=
G1 X91.246 Y100.642
G1 Z1.52
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.0995963
G1 F1500
M204 S6000
G1 X91.124 Y100.55 E.00056
G1 X90.888 Y100.493 E.0009
; WIPE_START
G1 X91.124 Y100.55 E-.23365
G1 X91.246 Y100.642 E-.14635
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X89.108 Y100.496 Z1.92 F18000
G1 Z1.52
G1 E.4 F1800
; LINE_WIDTH: 0.099604
G1 F1500
M204 S6000
G1 X88.872 Y100.55 E.00089
G1 X88.763 Y100.633 E.0005
; WIPE_START
G1 X88.872 Y100.55 E-.13729
G1 X89.108 Y100.496 E-.24271
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X81.503 Y99.85 Z1.92 F18000
G1 X56.2 Y97.701 Z1.92
G1 Z1.52
G1 E.4 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.360652
G1 F1500
M204 S6000
G1 X121.996 Y97.701 E1.09933
; WIPE_START
G1 X119.996 Y97.701 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G17
G3 Z1.92 I-.731 J.973 P1  F18000
G1 X122.056 Y99.248 Z1.92
G1 Z1.52
G1 E.4 F1800
; LINE_WIDTH: 0.419992
G1 F1500
M204 S6000
G1 X122.174 Y99.287 E.00245
G1 X122.253 Y99.445 E.00347
G1 X122.253 Y100.648 E.02366
G1 X125.347 Y100.648 E.06087
G1 X125.347 Y94.753 E.11594
G1 X122.253 Y94.753 E.06087
G1 X122.253 Y95.956 E.02366
M73 P75 R8
G1 X122.174 Y96.114 E.00347
G1 X122.056 Y96.153 E.00245
G1 X54.653 Y96.153 E1.32573
G1 X54.653 Y99.248 E.06087
G1 X121.996 Y99.248 E1.32455
M204 S10000
G1 X122.056 Y98.854 F18000
G1 F1500
M204 S6000
G1 X122.263 Y98.891 E.00415
G1 X122.41 Y98.972 E.0033
G1 X122.548 Y99.118 E.00394
G1 X122.647 Y99.445 E.00673
G1 X122.647 Y100.254 E.01591
G1 X124.953 Y100.254 E.04536
G1 X124.953 Y95.148 E.10043
G1 X122.647 Y95.148 E.04536
G1 X122.647 Y95.956 E.0159
G1 X122.548 Y96.284 E.00673
G1 X122.41 Y96.429 E.00394
G1 X122.263 Y96.51 E.0033
G1 X122.056 Y96.548 E.00415
G1 X55.047 Y96.548 E1.31797
G1 X55.047 Y98.854 E.04536
G1 X121.996 Y98.854 E1.31679
M204 S10000
G1 X122.056 Y98.46 F18000
G1 F1500
M204 S6000
G1 X122.402 Y98.522 E.00692
G1 X122.647 Y98.657 E.0055
G1 X122.876 Y98.9 E.00657
G1 X123.02 Y99.242 E.00731
G1 X123.041 Y99.86 E.01215
G1 X124.559 Y99.86 E.02985
G1 X124.559 Y95.542 E.08492
G1 X123.041 Y95.542 E.02985
G1 X123.02 Y96.159 E.01215
G1 X122.876 Y96.502 E.00731
G1 X122.647 Y96.745 E.00657
G1 X122.402 Y96.879 E.0055
G1 X122.056 Y96.942 E.00692
G1 X55.441 Y96.942 E1.31022
G1 X55.441 Y98.46 E.02985
G1 X121.996 Y98.46 E1.30904
M204 S10000
G1 X122.056 Y98.065 F18000
G1 F1500
M204 S6000
G1 X122.54 Y98.153 E.00968
G1 X122.884 Y98.341 E.0077
G1 X123.205 Y98.681 E.0092
G1 X123.406 Y99.161 E.01023
G1 X123.456 Y99.465 E.00607
G1 X124.165 Y99.465 E.01394
G1 X124.165 Y95.936 E.06941
G1 X123.435 Y95.936 E.01434
G1 X123.406 Y96.241 E.00602
G1 X123.205 Y96.72 E.01023
G1 X122.884 Y97.06 E.0092
G1 X122.54 Y97.248 E.0077
G1 X122.056 Y97.336 E.00968
G1 X55.835 Y97.336 E1.30247
G1 X55.835 Y98.065 E.01434
G1 X121.996 Y98.065 E1.30129
M204 S10000
G1 X122.056 Y97.701 F18000
; LINE_WIDTH: 0.375487
G1 F1500
M204 S6000
G1 X122.367 Y97.742 E.00548
; LINE_WIDTH: 0.419265
G1 X122.679 Y97.784 E.00617
G1 X123.12 Y98.026 E.00988
G1 X123.533 Y98.463 E.01181
G1 X123.77 Y99.029 E.01205
G1 X123.77 Y96.373 E.05215
G1 X123.533 Y96.939 E.01205
G1 X123.12 Y97.376 E.01181
G1 X122.679 Y97.618 E.00988
; LINE_WIDTH: 0.405157
G1 X122.397 Y97.655 E.00538
; LINE_WIDTH: 0.375487
G1 X122.115 Y97.693 E.00496
; WIPE_START
G1 X122.397 Y97.655 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G17
G3 Z1.92 I0 J1.217 P1  F18000
G1 X123.39 Y97.655 Z1.92
G1 Z1.52
G1 E.4 F1800
; LINE_WIDTH: 0.444372
G1 F1500
M204 S6000
G1 X123.338 Y97.655 E.00109
G1 X123.312 Y97.701 E.00109
G1 X123.338 Y97.746 E.00109
G1 X123.382 Y97.746 E.00093
; OBJECT_ID: 8
; WIPE_START
G1 X123.338 Y97.746 E-.08413
G1 X123.312 Y97.701 E-.09862
G1 X123.338 Y97.655 E-.09862
G1 X123.39 Y97.655 E-.09862
; WIPE_END
G1 E-.02 F1800
; stop printing object, unique label id: 12
M625
; start printing object, unique label id: 8
M624 AQAAAAAAAAA=
M204 S10000
G17
G3 Z1.92 I.786 J-.929 P1  F18000
G1 X92.376 Y71.403 Z1.92
G1 Z1.52
M73 P76 R8
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X92.395 Y71.437 E.00084
G1 X92.504 Y71.729 E.00659
G1 X92.58 Y72.042 E.00682
G1 X92.622 Y72.501 E.00975
G1 X92.58 Y72.97 E.00997
G1 X92.453 Y73.424 E.00998
G1 X92.326 Y73.708 E.00659
G1 X92.16 Y73.985 E.00682
G1 X91.868 Y74.341 E.00975
G1 X91.509 Y74.645 E.00995
G1 X91.11 Y74.875 E.00975
G1 X90.81 Y74.993 E.00683
G1 X90.497 Y75.074 E.00683
G1 X90.039 Y75.122 E.00975
G1 X89.571 Y75.087 E.00995
G1 X89.116 Y74.969 E.00995
G1 X88.697 Y74.775 E.00976
G1 X88.428 Y74.597 E.00683
G1 X88.182 Y74.389 E.00683
G1 X87.879 Y74.042 E.00975
G1 X87.643 Y73.646 E.00975
G1 X87.52 Y73.348 E.00683
G1 X87.434 Y73.037 E.00684
G1 X87.379 Y72.579 E.00975
G1 X87.408 Y72.109 E.00997
G1 X87.521 Y71.651 E.00998
G1 X87.639 Y71.364 E.00659
G1 X87.796 Y71.082 E.00682
G1 X88.079 Y70.717 E.00977
G1 X88.43 Y70.402 E.00998
G1 X88.69 Y70.231 E.00659
G1 X88.978 Y70.087 E.00682
G1 X89.417 Y69.944 E.00978
G1 X89.885 Y69.883 E.00998
G1 X90.196 Y69.888 E.00659
G1 X90.516 Y69.931 E.00682
G1 X90.958 Y70.06 E.00975
G1 X91.37 Y70.266 E.00975
G1 X91.634 Y70.452 E.00683
G1 X91.874 Y70.668 E.00683
G1 X92.167 Y71.025 E.00977
G1 X92.347 Y71.35 E.00787
M204 S250
G1 X92.018 Y71.601 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X92.022 Y71.609 E.00018
G1 X92.112 Y71.849 E.00505
G1 X92.176 Y72.109 E.00526
G1 X92.211 Y72.501 E.00773
G1 X92.175 Y72.896 E.0078
G1 X92.067 Y73.285 E.00794
G1 X91.962 Y73.519 E.00505
G1 X91.825 Y73.749 E.00526
G1 X91.575 Y74.052 E.00773
G1 X91.273 Y74.309 E.0078
G1 X90.932 Y74.505 E.00774
G1 X90.683 Y74.603 E.00526
G1 X90.424 Y74.67 E.00526
G1 X90.033 Y74.711 E.00773
G1 X89.638 Y74.682 E.0078
G1 X89.254 Y74.582 E.00779
G1 X88.897 Y74.417 E.00774
G1 X88.674 Y74.269 E.00526
G1 X88.47 Y74.096 E.00526
G1 X88.211 Y73.8 E.00773
G1 X88.01 Y73.463 E.00774
G1 X87.908 Y73.215 E.00526
G1 X87.837 Y72.957 E.00527
G1 X87.79 Y72.567 E.00773
G1 X87.814 Y72.171 E.0078
G1 X87.911 Y71.779 E.00794
G1 X88.009 Y71.542 E.00505
G1 X88.139 Y71.308 E.00526
G1 X88.38 Y70.997 E.00774
G1 X88.681 Y70.728 E.00794
G1 X88.895 Y70.586 E.00505
G1 X89.134 Y70.467 E.00526
G1 X89.508 Y70.345 E.00774
G1 X89.909 Y70.292 E.00794
G1 X90.165 Y70.297 E.00505
G1 X90.43 Y70.333 E.00526
G1 X90.808 Y70.443 E.00773
G1 X91.159 Y70.619 E.00773
G1 X91.378 Y70.773 E.00526
G1 X91.577 Y70.952 E.00526
G1 X91.827 Y71.256 E.00774
G1 X91.989 Y71.548 E.00658
; WIPE_START
M204 S6000
G1 X92.022 Y71.609 E-.01316
G1 X92.112 Y71.849 E-.04879
G1 X92.176 Y72.109 E-.05081
G1 X92.211 Y72.501 E-.07469
G1 X92.175 Y72.896 E-.07536
G1 X92.067 Y73.285 E-.07672
G1 X91.98 Y73.479 E-.04047
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X99.513 Y72.252 Z1.92 F18000
G1 X121.257 Y68.711 Z1.92
G1 Z1.52
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X121.257 Y68.957 E.00522
G1 X90.097 Y68.957 E.65951
G1 X90.602 Y69.515 E.01591
G1 X90.228 Y69.464 E.00798
G1 X89.861 Y69.458 E.00778
G1 X89.393 Y69.52 E.00998
G1 X89.903 Y68.957 E.01606
G1 X54.243 Y68.957 E.75475
G1 X54.243 Y65.044 E.08282
G1 X121.257 Y65.044 E1.41839
G1 X121.257 Y68.651 E.07633
; WIPE_START
M204 S6000
G1 X121.257 Y68.957 E-.05824
G1 X119.563 Y68.957 E-.32176
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X125.51 Y69.12 Z1.92 F18000
G1 Z1.52
G1 E.4 F1800
G1 F1500
M204 S500
G1 X121.681 Y69.12 E.08105
G1 X121.681 Y64.882 E.08971
G1 X125.919 Y64.882 E.08971
G1 X125.919 Y69.12 E.08971
G1 X125.57 Y69.12 E.00739
M204 S250
G1 X125.51 Y68.711 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X122.09 Y68.711 E.06727
G1 X122.09 Y65.291 E.06727
G1 X125.51 Y65.291 E.06727
G1 X125.51 Y68.651 E.06609
; WIPE_START
M204 S6000
G1 X123.51 Y68.686 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X115.879 Y68.839 Z1.92 F18000
G1 X88.946 Y69.382 Z1.92
G1 Z1.52
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X53.819 Y69.382 E.74349
G1 X53.819 Y64.62 E.10078
G1 X126.181 Y64.62 E1.53159
G1 X126.181 Y69.382 E.10078
G1 X91.054 Y69.382 E.74349
G1 X92.253 Y70.706 E.03782
G1 X92.537 Y71.137 E.01091
G1 X92.613 Y71.291 E.00364
G1 X92.737 Y71.604 E.00714
G1 X92.824 Y71.939 E.00731
G1 X92.872 Y72.289 E.00749
G1 X92.878 Y72.616 E.00692
G1 X92.851 Y72.92 E.00645
G1 X92.716 Y73.46 E.01178
G1 X92.573 Y73.794 E.0077
G1 X92.306 Y74.226 E.01074
G1 X92.083 Y74.489 E.0073
G1 X91.824 Y74.73 E.00749
G1 X91.405 Y75.014 E.01072
G1 X91.078 Y75.171 E.00768
G1 X90.601 Y75.318 E.01055
G1 X90.087 Y75.379 E.01096
G1 X89.742 Y75.369 E.00731
G1 X89.242 Y75.279 E.01075
G1 X88.908 Y75.165 E.00747
G1 X88.582 Y75.006 E.00768
G1 X88.176 Y74.73 E.01039
G1 X87.917 Y74.489 E.00749
G1 X87.688 Y74.219 E.00749
G1 X87.423 Y73.786 E.01075
G1 X87.288 Y73.468 E.0073
G1 X87.189 Y73.13 E.00746
G1 X87.123 Y72.625 E.01077
G1 X87.129 Y72.281 E.00729
G1 X87.18 Y71.922 E.00767
G1 X87.318 Y71.451 E.01039
G1 X87.549 Y70.989 E.01094
G1 X87.753 Y70.7 E.00749
G1 X88.906 Y69.426 E.03636
M204 S250
G1 X88.024 Y69.791 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X53.41 Y69.791 E.68082
G1 X53.41 Y64.211 E.10975
G1 X126.59 Y64.211 E1.43939
G1 X126.59 Y69.791 E.10975
G1 X91.976 Y69.791 E.68082
G1 X92.569 Y70.445 E.01737
G1 X92.684 Y70.598 E.00375
G1 X92.895 Y70.937 E.00786
G1 X93.126 Y71.477 E.01156
G1 X93.226 Y71.859 E.00775
G1 X93.289 Y72.446 E.01161
G1 X93.248 Y73.017 E.01126
M73 P77 R8
G1 X93.158 Y73.422 E.00817
G1 X93.1 Y73.603 E.00374
G1 X92.943 Y73.972 E.00787
G1 X92.634 Y74.471 E.01155
M73 P77 R7
G1 X92.38 Y74.772 E.00775
G1 X91.938 Y75.159 E.01155
G1 X91.604 Y75.373 E.0078
G1 X91.232 Y75.55 E.00811
G1 X90.873 Y75.673 E.00746
G1 X90.476 Y75.755 E.00797
G1 X90.099 Y75.789 E.00746
G1 X89.705 Y75.777 E.00775
G1 X89.312 Y75.718 E.00781
G1 X88.752 Y75.544 E.01154
G1 X88.381 Y75.364 E.0081
G1 X87.911 Y75.042 E.01121
G1 X87.62 Y74.772 E.00781
G1 X87.254 Y74.313 E.01155
G1 X87.056 Y73.968 E.00781
G1 X86.902 Y73.606 E.00775
G1 X86.791 Y73.225 E.0078
G1 X86.713 Y72.643 E.01156
G1 X86.72 Y72.249 E.00775
G1 X86.778 Y71.841 E.0081
G1 X86.874 Y71.475 E.00746
G1 X87.108 Y70.932 E.01162
G1 X87.204 Y70.767 E.00376
G1 X87.433 Y70.443 E.00781
G1 X87.984 Y69.835 E.01613
M204 S10000
G1 X88.763 Y69.933 F18000
; FEATURE: Gap infill
; LINE_WIDTH: 0.0996177
G1 F1500
M204 S6000
G1 X88.872 Y69.85 E.00051
G1 X89.108 Y69.796 E.00089
; WIPE_START
G1 X88.872 Y69.85 E-.24272
G1 X88.763 Y69.933 E-.13728
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X90.887 Y69.793 Z1.92 F18000
G1 Z1.52
G1 E.4 F1800
; LINE_WIDTH: 0.0996257
G1 F1500
M204 S6000
G1 X91.124 Y69.85 E.0009
G1 X91.246 Y69.942 E.00056
; WIPE_START
G1 X91.124 Y69.85 E-.14629
G1 X90.887 Y69.793 E-.23371
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X83.279 Y69.18 Z1.92 F18000
G1 X56.2 Y67.001 Z1.92
G1 Z1.52
G1 E.4 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.360632
G1 F1500
M204 S6000
G1 X119.24 Y67.001 E1.05322
M204 S10000
G1 X119.665 Y67.365 F18000
; LINE_WIDTH: 0.419992
G1 F1500
M204 S6000
G1 X119.665 Y66.636 E.01434
G1 X55.835 Y66.636 E1.25544
G1 X55.835 Y67.365 E.01434
G1 X119.605 Y67.365 E1.25426
M204 S10000
G1 X120.059 Y67.76 F18000
G1 F1500
M204 S6000
G1 X120.059 Y66.242 E.02985
G1 X55.441 Y66.242 E1.27095
G1 X55.441 Y67.76 E.02985
G1 X119.999 Y67.76 E1.26977
M204 S10000
G1 X120.453 Y68.154 F18000
G1 F1500
M204 S6000
G1 X120.453 Y65.848 E.04536
G1 X55.047 Y65.848 E1.28645
G1 X55.047 Y68.154 E.04536
G1 X120.393 Y68.154 E1.28527
M204 S10000
G1 X120.847 Y68.548 F18000
G1 F1500
M204 S6000
G1 X120.847 Y65.453 E.06087
G1 X54.653 Y65.453 E1.30196
G1 X54.653 Y68.548 E.06087
G1 X120.787 Y68.548 E1.30078
; CHANGE_LAYER
; Z_HEIGHT: 1.64
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F1500
G1 X118.787 Y68.548 E-.38
; WIPE_END
G1 E-.02 F1800
; stop printing object, unique label id: 8
M625
; layer num/total_layer_count: 13/51
; update layer progress
M73 L13
M991 S0 P12 ;notify layer change
; OBJECT_ID: 12
; start printing object, unique label id: 12
M624 AgAAAAAAAAA=
M204 S10000
G17
G3 Z1.92 I-.935 J-.779 P1  F18000
G1 X91.357 Y101.464 Z1.92
G1 Z1.64
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X91.575 Y101.649 E.00563
G1 X91.827 Y101.955 E.00779
G1 X92.018 Y102.299 E.00774
G1 X92.112 Y102.549 E.00526
G1 X92.176 Y102.809 E.00526
G1 X92.211 Y103.201 E.00773
G1 X92.175 Y103.596 E.0078
G1 X92.071 Y103.975 E.00773
G1 X91.962 Y104.219 E.00526
G1 X91.825 Y104.449 E.00526
G1 X91.575 Y104.752 E.00773
G1 X91.272 Y105.009 E.00782
G1 X90.932 Y105.205 E.00771
G1 X90.683 Y105.303 E.00526
G1 X90.424 Y105.37 E.00526
G1 X90.033 Y105.411 E.00773
G1 X89.641 Y105.382 E.00773
G1 X89.38 Y105.322 E.00526
G1 X89.128 Y105.232 E.00526
G1 X88.782 Y105.046 E.00774
G1 X88.472 Y104.799 E.00779
G1 X88.211 Y104.5 E.0078
G1 X88.01 Y104.163 E.00774
G1 X87.908 Y103.915 E.00526
G1 X87.837 Y103.657 E.00526
G1 X87.79 Y103.267 E.00773
G1 X87.814 Y102.871 E.0078
G1 X87.908 Y102.486 E.0078
G1 X88.068 Y102.127 E.00774
G1 X88.212 Y101.902 E.00526
M73 P78 R7
G1 X88.382 Y101.695 E.00526
G1 X88.674 Y101.432 E.00774
G1 X89.011 Y101.223 E.0078
G1 X89.377 Y101.08 E.00773
G1 X89.638 Y101.02 E.00526
G1 X89.904 Y100.992 E.00526
G1 X90.294 Y101.01 E.00767
G1 X90.557 Y101.062 E.00527
G1 X90.808 Y101.143 E.00519
G1 X91.048 Y101.254 E.0052
G1 X91.275 Y101.395 E.00526
G1 X91.311 Y101.425 E.00093
; WIPE_START
M204 S6000
G1 X91.575 Y101.649 E-.06577
G1 X91.827 Y101.955 E-.07528
G1 X92.018 Y102.299 E-.07474
G1 X92.112 Y102.549 E-.05082
G1 X92.176 Y102.809 E-.05084
G1 X92.205 Y103.137 E-.06256
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X99.806 Y102.439 Z2.04 F18000
G1 X121.01 Y100.491 Z2.04
G1 Z1.64
G1 E.4 F1800
G1 F1500
M204 S500
G1 X91.957 Y100.491 E.57145
G1 X92.438 Y100.993 E.01368
G1 X92.685 Y101.3 E.00776
G1 X92.981 Y101.808 E.01155
G1 X93.128 Y102.18 E.00787
G1 X93.259 Y102.75 E.0115
G1 X93.287 Y103.34 E.0116
G1 X93.246 Y103.738 E.00787
G1 X93.099 Y104.304 E.0115
G1 X92.944 Y104.669 E.0078
G1 X92.748 Y105.01 E.00775
G1 X92.38 Y105.472 E.01162
G1 X91.936 Y105.861 E.01161
G1 X91.604 Y106.073 E.00775
G1 X91.247 Y106.245 E.0078
G1 X90.873 Y106.373 E.00776
G1 X90.494 Y106.453 E.00762
G1 X90.099 Y106.489 E.00781
G1 X89.705 Y106.477 E.00774
G1 X89.312 Y106.418 E.00781
G1 X88.753 Y106.245 E.0115
G1 X88.396 Y106.073 E.0078
G1 X88.062 Y105.859 E.0078
G1 X87.622 Y105.474 E.0115
G1 X87.364 Y105.169 E.00787
G1 X87.057 Y104.671 E.01151
G1 X86.842 Y104.122 E.0116
G1 X86.754 Y103.735 E.00781
G1 X86.713 Y103.343 E.00775
G1 X86.72 Y102.949 E.00775
G1 X86.774 Y102.556 E.0078
G1 X86.874 Y102.175 E.00776
G1 X87.108 Y101.632 E.01162
G1 X87.204 Y101.467 E.00375
G1 X87.433 Y101.143 E.00781
G1 X88.024 Y100.491 E.01731
G1 X53.41 Y100.491 E.68082
G1 X53.41 Y94.911 E.10975
G1 X121.01 Y94.911 E1.32963
G1 X121.01 Y93.511 E.02754
G1 X126.59 Y93.511 E.10975
G1 X126.59 Y101.891 E.16483
G1 X121.01 Y101.891 E.10975
G1 X121.01 Y100.551 E.02636
; WIPE_START
M204 S6000
G1 X119.01 Y100.547 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G17
G3 Z2.04 I1.217 J0 P1  F18000
; stop printing object, unique label id: 12
M625
; object ids of layer 13 start: 8,12
M624 AwAAAAAAAAA=
;===================== date: 20250206 =====================

; don't support timelapse gcode in spiral_mode and by object sequence for I3 structure printer
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
G92 E0
G1 Z2.04
G1 X0 Y85.35 ; move to safe pos
G1 X-13.0 F3000 ; move to safe pos
M400
M1004 S5 P1  ; external shutter
M400 P300
M971 S11 C11 O0
G92 E0
G1 X0 F18000
M623

; SKIPTYPE: head_wrap_detect
M622.1 S1
M1002 judge_flag g39_3rd_layer_detect_flag
M622 J1
    ; enable nozzle clog detect at 3rd layer
    


    M622.1 S1
    M1002 judge_flag g39_detection_flag
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




; object ids of this layer13 end: 8,12
M625
; start printing object, unique label id: 12
M624 AgAAAAAAAAA=
G1 X126.373 Y94.279
G1 Z1.64
G1 E.4 F1800
; FEATURE: Top surface
G1 F1500
M204 S2000
G1 X125.822 Y93.728 E.01534
G1 X125.264 Y93.728
G1 X126.373 Y94.837 E.03085
G1 X126.373 Y95.394
G1 X124.707 Y93.728 E.04636
G1 X124.149 Y93.728
G1 X126.373 Y95.952 E.06186
G1 X126.373 Y96.509
G1 X123.592 Y93.728 E.07737
G1 X123.034 Y93.728
G1 X126.373 Y97.067 E.09288
G1 X126.373 Y97.624
G1 X122.477 Y93.728 E.10839
G1 X121.919 Y93.728
G1 X126.373 Y98.182 E.1239
G1 X126.373 Y98.739
G1 X121.361 Y93.728 E.13941
G1 X121.227 Y94.151
G1 X126.373 Y99.297 E.14315
G1 X126.373 Y99.854
G1 X121.227 Y94.708 E.14315
G1 X121.089 Y95.128
G1 X126.373 Y100.412 E.14699
G1 X126.373 Y100.969
G1 X120.531 Y95.128 E.1625
G1 X119.974 Y95.128
G1 X126.373 Y101.527 E.17801
G1 X125.963 Y101.674
G1 X119.416 Y95.128 E.1821
G1 X118.859 Y95.128
G1 X125.405 Y101.674 E.1821
G1 X124.847 Y101.674
G1 X118.301 Y95.128 E.1821
G1 X117.744 Y95.128
G1 X124.29 Y101.674 E.1821
G1 X123.732 Y101.674
M73 P79 R7
G1 X117.186 Y95.128 E.1821
G1 X116.629 Y95.128
G1 X123.175 Y101.674 E.1821
G1 X122.617 Y101.674
G1 X121.227 Y100.283 E.03868
G1 X121.227 Y100.841
G1 X122.06 Y101.674 E.02317
; WIPE_START
M204 S6000
G1 X121.227 Y100.841 E-.22382
G1 X121.227 Y100.283 E-.10593
G1 X121.414 Y100.47 E-.05024
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X121.217 Y100.274 Z2.04 F18000
G1 Z1.64
G1 E.4 F1800
G1 F1500
M204 S2000
G1 X116.071 Y95.128 E.14315
G1 X115.513 Y95.128
G1 X120.66 Y100.274 E.14315
G1 X120.102 Y100.274
G1 X114.956 Y95.128 E.14315
G1 X114.398 Y95.128
G1 X119.545 Y100.274 E.14315
G1 X118.987 Y100.274
G1 X113.841 Y95.128 E.14315
G1 X113.283 Y95.128
G1 X118.43 Y100.274 E.14315
G1 X117.872 Y100.274
G1 X112.726 Y95.128 E.14315
G1 X112.168 Y95.128
G1 X117.315 Y100.274 E.14315
G1 X116.757 Y100.274
G1 X111.611 Y95.128 E.14315
G1 X111.053 Y95.128
G1 X116.199 Y100.274 E.14315
G1 X115.642 Y100.274
G1 X110.496 Y95.128 E.14315
G1 X109.938 Y95.128
G1 X115.084 Y100.274 E.14315
G1 X114.527 Y100.274
G1 X109.381 Y95.128 E.14315
G1 X108.823 Y95.128
G1 X113.969 Y100.274 E.14315
G1 X113.412 Y100.274
G1 X108.265 Y95.128 E.14315
G1 X107.708 Y95.128
G1 X112.854 Y100.274 E.14315
G1 X112.297 Y100.274
G1 X107.15 Y95.128 E.14315
G1 X106.593 Y95.128
G1 X111.739 Y100.274 E.14315
G1 X111.182 Y100.274
G1 X106.035 Y95.128 E.14315
G1 X105.478 Y95.128
G1 X110.624 Y100.274 E.14315
G1 X110.067 Y100.274
G1 X104.92 Y95.128 E.14315
G1 X104.363 Y95.128
G1 X109.509 Y100.274 E.14315
G1 X108.951 Y100.274
G1 X103.805 Y95.128 E.14315
G1 X103.248 Y95.128
G1 X108.394 Y100.274 E.14315
G1 X107.836 Y100.274
G1 X102.69 Y95.128 E.14315
G1 X102.132 Y95.128
G1 X107.279 Y100.274 E.14315
G1 X106.721 Y100.274
G1 X101.575 Y95.128 E.14315
G1 X101.017 Y95.128
G1 X106.164 Y100.274 E.14315
G1 X105.606 Y100.274
G1 X100.46 Y95.128 E.14315
G1 X99.902 Y95.128
G1 X105.049 Y100.274 E.14315
G1 X104.491 Y100.274
G1 X99.345 Y95.128 E.14315
G1 X98.787 Y95.128
G1 X103.934 Y100.274 E.14315
G1 X103.376 Y100.274
G1 X98.23 Y95.128 E.14315
G1 X97.672 Y95.128
G1 X102.819 Y100.274 E.14315
G1 X102.261 Y100.274
G1 X97.115 Y95.128 E.14315
G1 X96.557 Y95.128
G1 X101.703 Y100.274 E.14315
G1 X101.146 Y100.274
G1 X96 Y95.128 E.14315
G1 X95.442 Y95.128
G1 X100.588 Y100.274 E.14315
G1 X100.031 Y100.274
G1 X94.884 Y95.128 E.14315
G1 X94.327 Y95.128
G1 X99.473 Y100.274 E.14315
G1 X98.916 Y100.274
G1 X93.769 Y95.128 E.14315
G1 X93.212 Y95.128
G1 X98.358 Y100.274 E.14315
G1 X97.801 Y100.274
G1 X92.654 Y95.128 E.14315
G1 X92.097 Y95.128
G1 X97.243 Y100.274 E.14315
G1 X96.686 Y100.274
G1 X91.539 Y95.128 E.14315
G1 X90.982 Y95.128
G1 X96.128 Y100.274 E.14315
G1 X95.571 Y100.274
G1 X90.424 Y95.128 E.14315
G1 X89.867 Y95.128
G1 X95.013 Y100.274 E.14315
G1 X94.455 Y100.274
G1 X89.309 Y95.128 E.14315
G1 X88.752 Y95.128
G1 X93.898 Y100.274 E.14315
G1 X93.34 Y100.274
G1 X88.194 Y95.128 E.14315
G1 X87.636 Y95.128
G1 X92.783 Y100.274 E.14315
G1 X92.225 Y100.274
G1 X87.079 Y95.128 E.14315
G1 X86.521 Y95.128
G1 X91.668 Y100.274 E.14315
; WIPE_START
M204 S6000
M73 P80 R7
G1 X90.254 Y98.86 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X92.815 Y101.978 Z2.04 F18000
G1 Z1.64
G1 E.4 F1800
G1 F1500
M204 S2000
G1 X85.964 Y95.128 E.19056
G1 X85.406 Y95.128
G1 X93.04 Y102.761 E.21233
G1 X92.356 Y102.635
M73 P80 R6
G1 X93.068 Y103.347 E.0198
G1 X93.005 Y103.841
G1 X92.423 Y103.26 E.01617
G1 X92.357 Y103.751
G1 X92.877 Y104.271 E.01447
G1 X92.702 Y104.654
G1 X92.22 Y104.172 E.01341
G1 X92.026 Y104.535
G1 X92.487 Y104.996 E.01283
G1 X92.239 Y105.305
G1 X91.779 Y104.846 E.01278
G1 X91.487 Y105.111
G1 X91.947 Y105.571 E.01279
G1 X91.622 Y105.804
G1 X91.149 Y105.33 E.01317
G1 X90.765 Y105.504
G1 X91.259 Y105.998 E.01375
G1 X90.854 Y106.15
G1 X90.304 Y105.601 E.01528
G1 X89.754 Y105.608
G1 X90.391 Y106.245 E.01772
G1 X89.853 Y106.265
G1 X88.995 Y105.407 E.02387
; WIPE_START
M204 S6000
G1 X89.853 Y106.265 E-.23054
G1 X90.391 Y106.245 E-.10225
G1 X90.215 Y106.069 E-.04721
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X90.563 Y100.842 Z2.04 F18000
G1 Z1.64
G1 E.4 F1800
G1 F1500
M204 S2000
G1 X84.849 Y95.128 E.15895
G1 X84.291 Y95.128
G1 X89.941 Y100.777 E.15714
G1 X89.447 Y100.841
G1 X83.734 Y95.128 E.15894
G1 X83.176 Y95.128
G1 X88.323 Y100.274 E.14315
G1 X87.765 Y100.274
G1 X82.619 Y95.128 E.14315
G1 X82.061 Y95.128
G1 X87.207 Y100.274 E.14315
G1 X86.65 Y100.274
G1 X81.504 Y95.128 E.14315
G1 X80.946 Y95.128
G1 X86.092 Y100.274 E.14315
G1 X85.535 Y100.274
G1 X80.388 Y95.128 E.14315
G1 X79.831 Y95.128
G1 X84.977 Y100.274 E.14315
G1 X84.42 Y100.274
G1 X79.273 Y95.128 E.14315
G1 X78.716 Y95.128
G1 X83.862 Y100.274 E.14315
G1 X83.305 Y100.274
G1 X78.158 Y95.128 E.14315
G1 X77.601 Y95.128
G1 X82.747 Y100.274 E.14315
G1 X82.19 Y100.274
G1 X77.043 Y95.128 E.14315
G1 X76.486 Y95.128
G1 X81.632 Y100.274 E.14315
G1 X81.074 Y100.274
G1 X75.928 Y95.128 E.14315
G1 X75.371 Y95.128
G1 X80.517 Y100.274 E.14315
G1 X79.959 Y100.274
G1 X74.813 Y95.128 E.14315
G1 X74.256 Y95.128
G1 X79.402 Y100.274 E.14315
G1 X78.844 Y100.274
G1 X73.698 Y95.128 E.14315
G1 X73.14 Y95.128
G1 X78.287 Y100.274 E.14315
G1 X77.729 Y100.274
G1 X72.583 Y95.128 E.14315
G1 X72.025 Y95.128
G1 X77.172 Y100.274 E.14315
G1 X76.614 Y100.274
G1 X71.468 Y95.128 E.14315
G1 X70.91 Y95.128
G1 X76.057 Y100.274 E.14315
G1 X75.499 Y100.274
G1 X70.353 Y95.128 E.14315
G1 X69.795 Y95.128
G1 X74.942 Y100.274 E.14315
G1 X74.384 Y100.274
G1 X69.238 Y95.128 E.14315
G1 X68.68 Y95.128
G1 X73.826 Y100.274 E.14315
G1 X73.269 Y100.274
G1 X68.123 Y95.128 E.14315
G1 X67.565 Y95.128
G1 X72.711 Y100.274 E.14315
G1 X72.154 Y100.274
G1 X67.008 Y95.128 E.14315
G1 X66.45 Y95.128
G1 X71.596 Y100.274 E.14315
G1 X71.039 Y100.274
G1 X65.892 Y95.128 E.14315
G1 X65.335 Y95.128
G1 X70.481 Y100.274 E.14315
G1 X69.924 Y100.274
G1 X64.777 Y95.128 E.14315
G1 X64.22 Y95.128
G1 X69.366 Y100.274 E.14315
G1 X68.809 Y100.274
G1 X63.662 Y95.128 E.14315
G1 X63.105 Y95.128
G1 X68.251 Y100.274 E.14315
G1 X67.694 Y100.274
G1 X62.547 Y95.128 E.14315
G1 X61.99 Y95.128
G1 X67.136 Y100.274 E.14315
G1 X66.578 Y100.274
G1 X61.432 Y95.128 E.14315
G1 X60.875 Y95.128
G1 X66.021 Y100.274 E.14315
G1 X65.463 Y100.274
G1 X60.317 Y95.128 E.14315
G1 X59.759 Y95.128
G1 X64.906 Y100.274 E.14315
G1 X64.348 Y100.274
G1 X59.202 Y95.128 E.14315
G1 X58.644 Y95.128
G1 X63.791 Y100.274 E.14315
G1 X63.233 Y100.274
G1 X58.087 Y95.128 E.14315
G1 X57.529 Y95.128
G1 X62.676 Y100.274 E.14315
G1 X62.118 Y100.274
G1 X56.972 Y95.128 E.14315
G1 X56.414 Y95.128
G1 X61.561 Y100.274 E.14315
G1 X61.003 Y100.274
G1 X55.857 Y95.128 E.14315
G1 X55.299 Y95.128
G1 X60.446 Y100.274 E.14315
G1 X59.888 Y100.274
G1 X54.742 Y95.128 E.14315
G1 X54.184 Y95.128
G1 X59.33 Y100.274 E.14315
G1 X58.773 Y100.274
G1 X53.627 Y95.128 E.14315
G1 X53.627 Y95.685
G1 X58.215 Y100.274 E.12764
G1 X57.658 Y100.274
G1 X53.627 Y96.243 E.11213
M73 P81 R6
G1 X53.627 Y96.801
G1 X57.1 Y100.274 E.09662
G1 X56.543 Y100.274
G1 X53.627 Y97.358 E.08111
G1 X53.627 Y97.916
G1 X55.985 Y100.274 E.0656
G1 X55.428 Y100.274
G1 X53.627 Y98.473 E.05009
G1 X53.627 Y99.031
G1 X54.87 Y100.274 E.03458
G1 X54.313 Y100.274
G1 X53.627 Y99.588 E.01908
; WIPE_START
M204 S6000
G1 X54.313 Y100.274 E-.18427
G1 X54.87 Y100.274 E-.10593
G1 X54.536 Y99.94 E-.0898
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X62.168 Y100.038 Z2.04 F18000
G1 X88.422 Y100.374 Z2.04
G1 Z1.64
G1 E.4 F1800
G1 F1500
M204 S2000
G1 X89.031 Y100.983 E.01694
G1 X88.67 Y101.179
G1 X88.157 Y100.666 E.01427
G1 X87.892 Y100.959
G1 X88.358 Y101.425 E.01295
G1 X88.087 Y101.711
G1 X87.628 Y101.252 E.01279
G1 X87.393 Y101.575
G1 X87.866 Y102.047 E.01314
G1 X87.697 Y102.436
G1 X87.203 Y101.942 E.01374
G1 X87.053 Y102.349
G1 X87.595 Y102.892 E.0151
G1 X87.594 Y103.448
G1 X86.958 Y102.812 E.01768
G1 X86.931 Y103.343
G1 X87.792 Y104.204 E.02395
G1 X87.038 Y104.007
G1 X89.197 Y106.166 E.06005
; WIPE_START
M204 S6000
G1 X87.783 Y104.752 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X90.79 Y100.79 Z2.04 F18000
G1 Z1.64
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.093528
G1 F1500
M204 S6000
G1 X90.549 Y100.856 E.00084
M204 S10000
G1 X90.936 Y100.964 F18000
; LINE_WIDTH: 0.0834503
G1 F1500
M204 S6000
G1 X90.638 Y100.767 E.00103
; WIPE_START
G1 X90.936 Y100.964 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X91.941 Y100.793 Z2.04 F18000
G1 Z1.64
G1 E.4 F1800
; LINE_WIDTH: 0.0782645
G1 F1500
M204 S6000
G1 X91.549 Y100.393 E.00147
; WIPE_START
G1 X91.941 Y100.793 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X92.395 Y102.44 Z2.04 F18000
G1 Z1.64
G1 E.4 F1800
; LINE_WIDTH: 0.0467218
G1 F1500
M204 S6000
G1 X92.383 Y102.429 E.00002
; LINE_WIDTH: 0.0755273
G1 X92.371 Y102.417 E.00004
; LINE_WIDTH: 0.103259
G1 X92.354 Y102.419 E.00007
; LINE_WIDTH: 0.117756
G1 X92.337 Y102.42 E.00008
G1 X92.348 Y102.593 E.00079
M204 S10000
G1 X93.047 Y102.836 F18000
; LINE_WIDTH: 0.0893113
G1 F1500
M204 S6000
G1 X93.04 Y102.962 E.0004
G1 X93.025 Y102.979 E.00007
; LINE_WIDTH: 0.0755273
G1 X93.013 Y102.967 E.00004
; LINE_WIDTH: 0.0467218
G1 X93.001 Y102.956 E.00002
M204 S10000
G1 X92.499 Y103.056 F18000
; LINE_WIDTH: 0.0866498
G1 F1500
M204 S6000
G1 X92.409 Y103.274 E.00072
; WIPE_START
G1 X92.499 Y103.056 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X88.705 Y105.981 Z2.04 F18000
G1 Z1.64
G1 E.4 F1800
; LINE_WIDTH: 0.0900022
G1 F1500
M204 S6000
G1 X88.613 Y105.916 E.00036
; LINE_WIDTH: 0.123877
G1 X88.521 Y105.85 E.00055
; LINE_WIDTH: 0.160491
G1 X88.378 Y105.736 E.00123
; LINE_WIDTH: 0.199851
G1 X88.236 Y105.621 E.00159
; LINE_WIDTH: 0.241512
G1 X87.851 Y105.262 E.00566
G1 X87.599 Y104.988 E.00402
; LINE_WIDTH: 0.209908
G1 X87.491 Y104.859 E.00154
; LINE_WIDTH: 0.17115
G1 X87.379 Y104.713 E.00134
; LINE_WIDTH: 0.12281
G1 X87.267 Y104.566 E.00089
; LINE_WIDTH: 0.0858373
G1 X87.216 Y104.491 E.00027
; WIPE_START
G1 X87.267 Y104.566 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X88.931 Y105.471 Z2.04 F18000
G1 Z1.64
G1 E.4 F1800
; LINE_WIDTH: 0.192475
G1 F1500
M204 S6000
G1 X88.789 Y105.365 E.00147
; LINE_WIDTH: 0.153616
G1 X88.639 Y105.253 E.00119
; LINE_WIDTH: 0.104602
G1 X88.313 Y104.961 E.00172
G1 X88.013 Y104.64 E.00173
; LINE_WIDTH: 0.134211
G1 X87.888 Y104.479 E.0011
; LINE_WIDTH: 0.171579
G1 X87.762 Y104.318 E.00148
M204 S10000
G1 X87.639 Y103.747 F18000
; LINE_WIDTH: 0.0864153
G1 F1500
M204 S6000
G1 X87.518 Y103.524 E.00077
; OBJECT_ID: 8
; WIPE_START
G1 X87.639 Y103.747 E-.38
; WIPE_END
G1 E-.02 F1800
; stop printing object, unique label id: 12
M625
; start printing object, unique label id: 8
M624 AQAAAAAAAAA=
M204 S10000
G1 X88.669 Y96.184 Z2.04 F18000
G1 X92.019 Y71.601 Z2.04
G1 Z1.64
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X92.112 Y71.849 E.00522
G1 X92.176 Y72.109 E.00526
G1 X92.211 Y72.501 E.00773
G1 X92.175 Y72.896 E.0078
G1 X92.071 Y73.275 E.00773
G1 X91.962 Y73.519 E.00526
G1 X91.825 Y73.749 E.00526
G1 X91.575 Y74.052 E.00773
G1 X91.272 Y74.309 E.00782
G1 X90.932 Y74.505 E.00771
G1 X90.683 Y74.603 E.00526
G1 X90.424 Y74.67 E.00526
G1 X90.033 Y74.711 E.00773
G1 X89.641 Y74.682 E.00773
G1 X89.38 Y74.622 E.00526
G1 X89.128 Y74.532 E.00526
G1 X88.782 Y74.346 E.00774
G1 X88.472 Y74.099 E.00779
G1 X88.211 Y73.8 E.0078
G1 X88.01 Y73.463 E.00774
G1 X87.908 Y73.215 E.00526
G1 X87.837 Y72.957 E.00526
G1 X87.79 Y72.567 E.00773
G1 X87.814 Y72.171 E.0078
G1 X87.908 Y71.786 E.0078
G1 X88.068 Y71.427 E.00774
G1 X88.212 Y71.202 E.00526
G1 X88.382 Y70.995 E.00526
G1 X88.674 Y70.732 E.00774
G1 X89.011 Y70.523 E.0078
G1 X89.377 Y70.38 E.00773
G1 X89.638 Y70.32 E.00526
G1 X89.904 Y70.292 E.00526
G1 X90.294 Y70.31 E.00767
G1 X90.557 Y70.362 E.00527
G1 X90.808 Y70.443 E.00519
G1 X91.048 Y70.554 E.0052
G1 X91.275 Y70.695 E.00526
G1 X91.575 Y70.949 E.00773
G1 X91.827 Y71.255 E.00779
G1 X91.99 Y71.548 E.00659
; WIPE_START
M204 S6000
G1 X92.112 Y71.849 E-.06177
G1 X92.176 Y72.109 E-.05084
G1 X92.211 Y72.501 E-.07472
G1 X92.175 Y72.896 E-.07531
G1 X92.071 Y73.275 E-.07471
G1 X91.979 Y73.48 E-.04266
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X99.536 Y72.405 Z2.04 F18000
G1 X125.51 Y68.711 Z2.04
G1 Z1.64
G1 E.4 F1800
G1 F1500
M204 S500
G1 X122.09 Y68.711 E.06727
G1 X122.09 Y65.291 E.06727
G1 X125.51 Y65.291 E.06727
G1 X125.51 Y68.651 E.06609
; WIPE_START
M204 S6000
G1 X123.51 Y68.686 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X115.882 Y68.923 Z2.04 F18000
G1 X88.024 Y69.791 Z2.04
G1 Z1.64
G1 E.4 F1800
G1 F1500
M204 S500
G1 X53.41 Y69.791 E.68082
G1 X53.41 Y64.211 E.10975
G1 X126.59 Y64.211 E1.43939
G1 X126.59 Y69.791 E.10975
G1 X91.957 Y69.791 E.6812
G1 X92.438 Y70.293 E.01368
G1 X92.685 Y70.6 E.00776
G1 X92.893 Y70.935 E.00774
G1 X93.06 Y71.292 E.00775
G1 X93.183 Y71.669 E.00781
G1 X93.28 Y72.252 E.01161
G1 X93.272 Y72.842 E.01161
G1 X93.159 Y73.418 E.01155
G1 X93.026 Y73.792 E.0078
G1 X92.749 Y74.307 E.0115
G1 X92.51 Y74.628 E.00787
G1 X92.091 Y75.04 E.01155
G1 X91.607 Y75.372 E.01155
G1 X91.247 Y75.545 E.00786
G1 X90.685 Y75.719 E.01156
G1 X90.099 Y75.789 E.01161
G1 X89.705 Y75.777 E.00774
G1 X89.312 Y75.718 E.00781
G1 X88.753 Y75.545 E.0115
G1 X88.396 Y75.373 E.0078
G1 X88.062 Y75.159 E.0078
G1 X87.622 Y74.774 E.0115
G1 X87.364 Y74.469 E.00787
G1 X87.057 Y73.971 E.0115
G1 X86.842 Y73.422 E.0116
G1 X86.754 Y73.034 E.00781
G1 X86.713 Y72.643 E.00775
G1 X86.72 Y72.249 E.00775
G1 X86.774 Y71.856 E.0078
G1 X86.874 Y71.475 E.00776
G1 X87.108 Y70.932 E.01162
G1 X87.204 Y70.767 E.00375
G1 X87.433 Y70.443 E.00781
G1 X87.984 Y69.835 E.01613
; WIPE_START
M204 S6000
G1 X85.984 Y69.833 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X93.558 Y68.896 Z2.04 F18000
G1 X126.373 Y64.837 Z2.04
G1 Z1.64
G1 E.4 F1800
; FEATURE: Top surface
G1 F1500
M204 S2000
G1 X125.964 Y64.428 E.01138
G1 X125.407 Y64.428
G1 X126.373 Y65.394 E.02688
G1 X125.727 Y65.305
G1 X126.373 Y65.952 E.01798
G1 X126.373 Y66.509
G1 X125.727 Y65.863 E.01798
G1 X125.727 Y66.42
G1 X126.373 Y67.067 E.01798
G1 X126.373 Y67.624
G1 X125.727 Y66.978 E.01798
G1 X125.727 Y67.535
G1 X126.373 Y68.182 E.01798
G1 X126.373 Y68.739
G1 X125.727 Y68.093 E.01798
G1 X125.727 Y68.651
G1 X126.373 Y69.297 E.01798
G1 X126.093 Y69.574
G1 X125.446 Y68.928 E.01798
G1 X124.889 Y68.928
G1 X125.535 Y69.574 E.01798
G1 X124.978 Y69.574
G1 X124.331 Y68.928 E.01798
G1 X123.774 Y68.928
G1 X124.42 Y69.574 E.01798
G1 X123.863 Y69.574
G1 X123.216 Y68.928 E.01798
G1 X122.659 Y68.928
G1 X123.305 Y69.574 E.01798
G1 X122.747 Y69.574
G1 X122.101 Y68.928 E.01798
; WIPE_START
M204 S6000
G1 X122.747 Y69.574 E-.17367
G1 X123.305 Y69.574 E-.10593
G1 X122.931 Y69.2 E-.10039
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X124.849 Y64.428 Z2.04 F18000
G1 Z1.64
G1 E.4 F1800
G1 F1500
M204 S2000
G1 X125.496 Y65.074 E.01798
G1 X124.938 Y65.074
G1 X124.292 Y64.428 E.01798
G1 X123.734 Y64.428
G1 X124.38 Y65.074 E.01798
G1 X123.823 Y65.074
G1 X123.177 Y64.428 E.01798
G1 X122.619 Y64.428
G1 X123.265 Y65.074 E.01798
G1 X122.708 Y65.074
G1 X122.061 Y64.428 E.01798
G1 X121.504 Y64.428
G1 X122.15 Y65.074 E.01798
G1 X121.873 Y65.354
G1 X120.946 Y64.428 E.02578
G1 X120.389 Y64.428
G1 X121.873 Y65.912 E.04129
G1 X121.873 Y66.469
G1 X119.831 Y64.428 E.0568
G1 X119.274 Y64.428
G1 X121.873 Y67.027 E.07231
G1 X121.873 Y67.585
G1 X118.716 Y64.428 E.08781
G1 X118.159 Y64.428
G1 X121.873 Y68.142 E.10332
G1 X121.873 Y68.7
G1 X117.601 Y64.428 E.11883
G1 X117.044 Y64.428
G1 X122.19 Y69.574 E.14315
G1 X121.632 Y69.574
G1 X116.486 Y64.428 E.14315
G1 X115.929 Y64.428
M73 P82 R6
G1 X121.075 Y69.574 E.14315
G1 X120.517 Y69.574
G1 X115.371 Y64.428 E.14315
G1 X114.813 Y64.428
G1 X119.96 Y69.574 E.14315
G1 X119.402 Y69.574
G1 X114.256 Y64.428 E.14315
G1 X113.698 Y64.428
G1 X118.845 Y69.574 E.14315
G1 X118.287 Y69.574
G1 X113.141 Y64.428 E.14315
G1 X112.583 Y64.428
G1 X117.73 Y69.574 E.14315
G1 X117.172 Y69.574
G1 X112.026 Y64.428 E.14315
G1 X111.468 Y64.428
G1 X116.615 Y69.574 E.14315
G1 X116.057 Y69.574
G1 X110.911 Y64.428 E.14315
G1 X110.353 Y64.428
G1 X115.499 Y69.574 E.14315
G1 X114.942 Y69.574
G1 X109.796 Y64.428 E.14315
G1 X109.238 Y64.428
G1 X114.384 Y69.574 E.14315
G1 X113.827 Y69.574
G1 X108.681 Y64.428 E.14315
G1 X108.123 Y64.428
G1 X113.269 Y69.574 E.14315
G1 X112.712 Y69.574
G1 X107.565 Y64.428 E.14315
G1 X107.008 Y64.428
G1 X112.154 Y69.574 E.14315
G1 X111.597 Y69.574
G1 X106.45 Y64.428 E.14315
G1 X105.893 Y64.428
G1 X111.039 Y69.574 E.14315
G1 X110.482 Y69.574
G1 X105.335 Y64.428 E.14315
G1 X104.778 Y64.428
G1 X109.924 Y69.574 E.14315
G1 X109.367 Y69.574
G1 X104.22 Y64.428 E.14315
G1 X103.663 Y64.428
G1 X108.809 Y69.574 E.14315
G1 X108.251 Y69.574
G1 X103.105 Y64.428 E.14315
G1 X102.548 Y64.428
G1 X107.694 Y69.574 E.14315
G1 X107.136 Y69.574
G1 X101.99 Y64.428 E.14315
G1 X101.433 Y64.428
G1 X106.579 Y69.574 E.14315
G1 X106.021 Y69.574
G1 X100.875 Y64.428 E.14315
G1 X100.317 Y64.428
G1 X105.464 Y69.574 E.14315
G1 X104.906 Y69.574
G1 X99.76 Y64.428 E.14315
G1 X99.202 Y64.428
G1 X104.349 Y69.574 E.14315
G1 X103.791 Y69.574
G1 X98.645 Y64.428 E.14315
G1 X98.087 Y64.428
G1 X103.234 Y69.574 E.14315
G1 X102.676 Y69.574
G1 X97.53 Y64.428 E.14315
G1 X96.972 Y64.428
G1 X102.119 Y69.574 E.14315
G1 X101.561 Y69.574
G1 X96.415 Y64.428 E.14315
G1 X95.857 Y64.428
G1 X101.003 Y69.574 E.14315
G1 X100.446 Y69.574
G1 X95.3 Y64.428 E.14315
G1 X94.742 Y64.428
G1 X99.888 Y69.574 E.14315
G1 X99.331 Y69.574
G1 X94.184 Y64.428 E.14315
G1 X93.627 Y64.428
G1 X98.773 Y69.574 E.14315
G1 X98.216 Y69.574
G1 X93.069 Y64.428 E.14315
G1 X92.512 Y64.428
G1 X97.658 Y69.574 E.14315
G1 X97.101 Y69.574
G1 X91.954 Y64.428 E.14315
G1 X91.397 Y64.428
G1 X96.543 Y69.574 E.14315
G1 X95.986 Y69.574
G1 X90.839 Y64.428 E.14315
G1 X90.282 Y64.428
G1 X95.428 Y69.574 E.14315
G1 X94.871 Y69.574
G1 X89.724 Y64.428 E.14315
G1 X89.167 Y64.428
G1 X94.313 Y69.574 E.14315
G1 X93.755 Y69.574
G1 X88.609 Y64.428 E.14315
G1 X88.052 Y64.428
G1 X93.198 Y69.574 E.14315
G1 X92.64 Y69.574
G1 X87.494 Y64.428 E.14315
G1 X86.936 Y64.428
G1 X92.083 Y69.574 E.14315
G1 X91.525 Y69.574
G1 X86.379 Y64.428 E.14315
G1 X85.821 Y64.428
G1 X92.902 Y71.508 E.19696
G1 X92.054 Y71.218
G1 X93.057 Y72.221 E.02791
G1 X93.058 Y72.779
G1 X92.394 Y72.115 E.01847
G1 X92.411 Y72.69
G1 X92.974 Y73.253 E.01565
G1 X92.838 Y73.674
G1 X92.326 Y73.163 E.01422
G1 X92.176 Y73.57
G1 X92.654 Y74.048 E.0133
G1 X92.426 Y74.378
G1 X91.966 Y73.918 E.01279
G1 X91.712 Y74.221
G1 X92.166 Y74.675 E.01263
G1 X91.868 Y74.934
G1 X91.41 Y74.476 E.01274
G1 X91.059 Y74.683
G1 X91.537 Y75.161 E.0133
G1 X91.163 Y75.344
G1 X90.653 Y74.835 E.01418
G1 X90.175 Y74.914
G1 X90.742 Y75.481 E.01577
G1 X90.26 Y75.557
G1 X89.598 Y74.895 E.01842
G1 X88.686 Y74.541
G1 X89.703 Y75.558 E.02829
; WIPE_START
M204 S6000
G1 X88.686 Y74.541 E-.27327
G1 X89.21 Y74.744 E-.10673
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X91.278 Y70.442 Z2.04 F18000
G1 Z1.64
G1 E.4 F1800
G1 F1500
M204 S2000
G1 X85.264 Y64.428 E.1673
G1 X84.706 Y64.428
G1 X90.386 Y70.107 E.15798
G1 X89.806 Y70.085
G1 X84.149 Y64.428 E.15736
G1 X83.591 Y64.428
G1 X89.331 Y70.168 E.15967
G1 X88.929 Y70.323
G1 X88.355 Y69.749 E.01597
G1 X88.09 Y70.041
G1 X88.582 Y70.534 E.0137
G1 X88.283 Y70.792
G1 X87.825 Y70.334 E.01275
M73 P82 R5
G1 X87.565 Y70.632
G1 X88.025 Y71.091 E.01278
G1 X87.822 Y71.446
G1 X87.34 Y70.964 E.0134
G1 X87.158 Y71.339
G1 X87.669 Y71.851 E.01422
G1 X87.587 Y72.326
G1 X87.023 Y71.762 E.0157
G1 X86.941 Y72.237
G1 X87.613 Y72.91 E.01871
G1 X87.978 Y73.832
G1 X86.948 Y72.802 E.02865
G1 X87.098 Y73.51
G1 X88.982 Y75.394 E.05241
; WIPE_START
M204 S6000
G1 X87.568 Y73.98 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
M73 P83 R5
G1 X88.18 Y69.574 Z2.04 F18000
G1 Z1.64
G1 E.4 F1800
G1 F1500
M204 S2000
G1 X83.034 Y64.428 E.14315
G1 X82.476 Y64.428
G1 X87.622 Y69.574 E.14315
G1 X87.065 Y69.574
G1 X81.919 Y64.428 E.14315
G1 X81.361 Y64.428
G1 X86.507 Y69.574 E.14315
G1 X85.95 Y69.574
G1 X80.804 Y64.428 E.14315
G1 X80.246 Y64.428
G1 X85.392 Y69.574 E.14315
G1 X84.835 Y69.574
G1 X79.688 Y64.428 E.14315
G1 X79.131 Y64.428
G1 X84.277 Y69.574 E.14315
G1 X83.72 Y69.574
G1 X78.573 Y64.428 E.14315
G1 X78.016 Y64.428
G1 X83.162 Y69.574 E.14315
G1 X82.605 Y69.574
G1 X77.458 Y64.428 E.14315
G1 X76.901 Y64.428
G1 X82.047 Y69.574 E.14315
G1 X81.49 Y69.574
G1 X76.343 Y64.428 E.14315
G1 X75.786 Y64.428
G1 X80.932 Y69.574 E.14315
G1 X80.374 Y69.574
G1 X75.228 Y64.428 E.14315
G1 X74.671 Y64.428
G1 X79.817 Y69.574 E.14315
G1 X79.259 Y69.574
G1 X74.113 Y64.428 E.14315
G1 X73.556 Y64.428
G1 X78.702 Y69.574 E.14315
G1 X78.144 Y69.574
G1 X72.998 Y64.428 E.14315
G1 X72.44 Y64.428
G1 X77.587 Y69.574 E.14315
G1 X77.029 Y69.574
G1 X71.883 Y64.428 E.14315
G1 X71.325 Y64.428
G1 X76.472 Y69.574 E.14315
G1 X75.914 Y69.574
G1 X70.768 Y64.428 E.14315
G1 X70.21 Y64.428
G1 X75.357 Y69.574 E.14315
G1 X74.799 Y69.574
G1 X69.653 Y64.428 E.14315
G1 X69.095 Y64.428
G1 X74.242 Y69.574 E.14315
G1 X73.684 Y69.574
G1 X68.538 Y64.428 E.14315
G1 X67.98 Y64.428
G1 X73.126 Y69.574 E.14315
G1 X72.569 Y69.574
G1 X67.423 Y64.428 E.14315
G1 X66.865 Y64.428
G1 X72.011 Y69.574 E.14315
G1 X71.454 Y69.574
G1 X66.308 Y64.428 E.14315
G1 X65.75 Y64.428
G1 X70.896 Y69.574 E.14315
G1 X70.339 Y69.574
G1 X65.192 Y64.428 E.14315
G1 X64.635 Y64.428
G1 X69.781 Y69.574 E.14315
G1 X69.224 Y69.574
G1 X64.077 Y64.428 E.14315
G1 X63.52 Y64.428
G1 X68.666 Y69.574 E.14315
G1 X68.109 Y69.574
G1 X62.962 Y64.428 E.14315
G1 X62.405 Y64.428
G1 X67.551 Y69.574 E.14315
G1 X66.994 Y69.574
G1 X61.847 Y64.428 E.14315
G1 X61.29 Y64.428
G1 X66.436 Y69.574 E.14315
G1 X65.878 Y69.574
G1 X60.732 Y64.428 E.14315
G1 X60.175 Y64.428
G1 X65.321 Y69.574 E.14315
G1 X64.763 Y69.574
G1 X59.617 Y64.428 E.14315
G1 X59.06 Y64.428
G1 X64.206 Y69.574 E.14315
G1 X63.648 Y69.574
G1 X58.502 Y64.428 E.14315
G1 X57.944 Y64.428
G1 X63.091 Y69.574 E.14315
G1 X62.533 Y69.574
G1 X57.387 Y64.428 E.14315
G1 X56.829 Y64.428
G1 X61.976 Y69.574 E.14315
G1 X61.418 Y69.574
G1 X56.272 Y64.428 E.14315
G1 X55.714 Y64.428
G1 X60.861 Y69.574 E.14315
G1 X60.303 Y69.574
G1 X55.157 Y64.428 E.14315
G1 X54.599 Y64.428
G1 X59.746 Y69.574 E.14315
G1 X59.188 Y69.574
G1 X54.042 Y64.428 E.14315
G1 X53.627 Y64.57
G1 X56.019 Y66.963 E.06655
G1 X56.238 Y67.182
G1 X58.63 Y69.574 E.06655
G1 X58.073 Y69.574
G1 X53.627 Y65.128 E.12367
G1 X53.627 Y65.685
G1 X57.515 Y69.574 E.10816
G1 X56.958 Y69.574
G1 X53.627 Y66.243 E.09266
G1 X53.627 Y66.8
G1 X56.4 Y69.574 E.07715
G1 X55.843 Y69.574
G1 X53.627 Y67.358 E.06164
G1 X53.627 Y67.916
G1 X55.285 Y69.574 E.04613
G1 X54.728 Y69.574
G1 X53.627 Y68.473 E.03062
G1 X53.627 Y69.031
G1 X54.17 Y69.574 E.01511
; WIPE_START
M204 S6000
G1 X53.627 Y69.031 E-.14598
G1 X53.627 Y68.473 E-.10593
G1 X54.104 Y68.95 E-.12809
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X61.732 Y69.207 Z2.04 F18000
G1 X90.722 Y70.185 Z2.04
G1 Z1.64
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.11804
G1 F1500
M204 S6000
G1 X90.458 Y70.034 E.0014
; WIPE_START
G1 X90.722 Y70.185 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X92.635 Y70.932 Z2.04 F18000
G1 Z1.64
G1 E.4 F1800
; LINE_WIDTH: 0.0855756
G1 F1500
M204 S6000
G1 X92.56 Y70.838 E.00036
; LINE_WIDTH: 0.110584
G1 X92.484 Y70.743 E.00051
; LINE_WIDTH: 0.143329
G1 X92.238 Y70.468 E.00216
; LINE_WIDTH: 0.172433
G1 X91.525 Y69.74 E.00746
; WIPE_START
G1 X92.238 Y70.468 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X99.862 Y70.102 Z2.04 F18000
G1 X121.988 Y69.041 Z2.04
G1 Z1.64
G1 E.4 F1800
; LINE_WIDTH: 0.100376
G1 F1500
M204 S6000
G1 X121.76 Y68.813 E.0012
; WIPE_START
G1 X121.988 Y69.041 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X125.737 Y65.082 Z2.04 F18000
G1 Z1.64
G1 E.4 F1800
; LINE_WIDTH: 0.0937648
G1 F1500
M204 S6000
G1 X125.6 Y64.97 E.0006
; WIPE_START
G1 X125.737 Y65.082 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X118.224 Y66.429 Z2.04 F18000
G1 X92.09 Y71.112 Z2.04
G1 Z1.64
G1 E.4 F1800
; LINE_WIDTH: 0.19441
G1 F1500
M204 S6000
M73 P84 R5
G1 X91.764 Y70.754 E.00408
G1 X91.342 Y70.379 E.00475
; WIPE_START
G1 X91.764 Y70.754 E-.20445
G1 X92.09 Y71.112 E-.17555
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X92.454 Y71.897 Z2.04 F18000
G1 Z1.64
G1 E.4 F1800
; LINE_WIDTH: 0.0810011
G1 F1500
M204 S6000
G1 X92.379 Y72.13 E.00067
; WIPE_START
G1 X92.454 Y71.897 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X90.928 Y75.389 Z2.04 F18000
G1 Z1.64
G1 E.4 F1800
; LINE_WIDTH: 0.0785552
G1 F1500
M204 S6000
G1 X90.771 Y75.477 E.00047
M204 S10000
G1 X90.188 Y74.901 F18000
; LINE_WIDTH: 0.14339
G1 F1500
M204 S6000
G1 X90.036 Y74.969 E.00098
G1 X89.886 Y74.904 E.00096
; WIPE_START
G1 X90.036 Y74.969 E-.18802
G1 X90.188 Y74.901 E-.19198
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X88.388 Y75.109 Z2.04 F18000
G1 Z1.64
G1 E.4 F1800
; LINE_WIDTH: 0.0956737
G1 F1500
M204 S6000
G1 X88.206 Y74.962 E.00082
; LINE_WIDTH: 0.140633
G1 X87.814 Y74.596 E.00307
G1 X87.559 Y74.319 E.00216
; LINE_WIDTH: 0.108426
G1 X87.448 Y74.186 E.00071
; LINE_WIDTH: 0.0832404
G1 X87.386 Y74.106 E.00029
; WIPE_START
G1 X87.448 Y74.186 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X88.622 Y74.605 Z2.04 F18000
G1 Z1.64
G1 E.4 F1800
; LINE_WIDTH: 0.204327
G1 F1500
M204 S6000
G1 X88.285 Y74.305 E.00402
G1 X87.973 Y73.971 E.00407
G1 X87.989 Y73.82 E.00135
; CHANGE_LAYER
; Z_HEIGHT: 1.76
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F1500
G1 X87.973 Y73.971 E-.05441
G1 X88.285 Y74.305 E-.1638
G1 X88.622 Y74.605 E-.16179
; WIPE_END
G1 E-.02 F1800
; stop printing object, unique label id: 8
M625
; layer num/total_layer_count: 14/51
; update layer progress
M73 L14
M991 S0 P13 ;notify layer change
; OBJECT_ID: 12
; start printing object, unique label id: 12
M624 AgAAAAAAAAA=
M204 S10000
G17
G3 Z2.04 I-.708 J-.99 P1  F18000
G1 X55.828 Y98.072 Z2.04
G1 Z1.76
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F659
M204 S500
G1 X55.828 Y97.329 E.01573
G1 X56.572 Y97.329 E.01573
G1 X56.572 Y98.072 E.01573
G1 X55.888 Y98.072 E.01446
M204 S250
G1 X55.419 Y98.482 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F659
M204 S500
G1 X55.419 Y96.92 E.03072
G1 X56.981 Y96.92 E.03072
G1 X56.981 Y98.482 E.03072
G1 X55.479 Y98.482 E.02954
; WIPE_START
G1 F1500
M204 S6000
G1 X55.419 Y96.92 E-.29696
G1 X55.856 Y96.92 E-.08304
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X63.473 Y97.41 Z2.16 F18000
G1 X121.01 Y101.111 Z2.16
G1 Z1.76
G1 E.4 F1800
G1 F659
M204 S500
G1 X126.59 Y101.111 E.10975
G1 X126.59 Y101.891 E.01534
G1 X121.01 Y101.891 E.10975
G1 X121.01 Y101.171 E.01416
; WIPE_START
G1 F1500
M204 S6000
G1 X123.01 Y101.149 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G17
G3 Z2.16 I1.217 J0 P1  F18000
; stop printing object, unique label id: 12
M625
; object ids of layer 14 start: 8,12
M624 AwAAAAAAAAA=
;===================== date: 20250206 =====================

; don't support timelapse gcode in spiral_mode and by object sequence for I3 structure printer
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
G92 E0
G1 Z2.16
G1 X0 Y85.35 ; move to safe pos
G1 X-13.0 F3000 ; move to safe pos
M400
M1004 S5 P1  ; external shutter
M400 P300
M971 S11 C11 O0
G92 E0
G1 X0 F18000
M623

; SKIPTYPE: head_wrap_detect
M622.1 S1
M1002 judge_flag g39_3rd_layer_detect_flag
M622 J1
    ; enable nozzle clog detect at 3rd layer
    


    M622.1 S1
    M1002 judge_flag g39_detection_flag
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




; object ids of this layer14 end: 8,12
M625
; start printing object, unique label id: 12
M624 AgAAAAAAAAA=
G1 X121.215 Y101.501
G1 Z1.76
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.396522
G1 F659
M204 S6000
G1 X126.385 Y101.501 E.09565
; WIPE_START
G1 F1500
G1 X124.385 Y101.501 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G17
G3 Z2.16 I1.102 J-.516 P1  F18000
G1 X121.01 Y94.291 Z2.16
G1 Z1.76
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F659
M204 S500
G1 X121.01 Y93.511 E.01534
G1 X126.59 Y93.511 E.10975
G1 X126.59 Y94.291 E.01534
G1 X121.07 Y94.291 E.10857
M204 S10000
G1 X121.215 Y93.901 F18000
; FEATURE: Gap infill
; LINE_WIDTH: 0.396532
G1 F659
M204 S6000
G1 X126.385 Y93.901 E.09565
; OBJECT_ID: 8
; WIPE_START
G1 F1500
G1 X124.385 Y93.901 E-.38
; WIPE_END
G1 E-.02 F1800
; stop printing object, unique label id: 12
M625
; start printing object, unique label id: 8
M624 AQAAAAAAAAA=
M204 S10000
G1 X117.28 Y91.114 Z2.16 F18000
G1 X56.457 Y67.257 Z2.16
G1 Z1.76
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F659
M204 S500
G1 X55.943 Y67.257 E.01086
G1 X55.943 Y66.744 E.01086
G1 X56.457 Y66.744 E.01086
G1 X56.457 Y67.197 E.00959
M204 S10000
G1 X56.881 Y67.682 F18000
G1 F659
M204 S500
G1 X55.519 Y67.682 E.02882
G1 X55.519 Y66.32 E.02882
G1 X56.881 Y66.32 E.02882
G1 X56.881 Y67.622 E.02755
M204 S250
G1 X57.29 Y68.091 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F659
M204 S500
G1 X55.11 Y68.091 E.04288
G1 X55.11 Y65.911 E.04288
G1 X57.29 Y65.911 E.04288
G1 X57.29 Y68.031 E.0417
; CHANGE_LAYER
; Z_HEIGHT: 1.88
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F1500
M204 S6000
G1 X55.291 Y68.086 E-.38
; WIPE_END
G1 E-.02 F1800
; stop printing object, unique label id: 8
M625
; layer num/total_layer_count: 15/51
; update layer progress
M73 L15
M991 S0 P14 ;notify layer change
; OBJECT_ID: 12
; start printing object, unique label id: 12
M624 AgAAAAAAAAA=
M204 S10000
G17
G3 Z2.16 I-1.217 J.022 P1  F18000
G1 X55.839 Y98.062 Z2.16
G1 Z1.88
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F655
M204 S500
G1 X55.839 Y97.34 E.01527
G1 X56.561 Y97.34 E.01527
G1 X56.561 Y98.062 E.01527
G1 X55.899 Y98.062 E.014
M204 S250
G1 X55.43 Y98.471 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F655
M204 S500
G1 X55.43 Y96.931 E.03029
G1 X56.97 Y96.931 E.03029
G1 X56.97 Y98.471 E.03029
G1 X55.49 Y98.471 E.02911
; WIPE_START
G1 F1500
M204 S6000
G1 X55.43 Y96.931 E-.29282
G1 X55.889 Y96.931 E-.08718
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X63.506 Y97.42 Z2.28 F18000
G1 X121.01 Y101.111 Z2.28
G1 Z1.88
G1 E.4 F1800
G1 F655
M204 S500
G1 X126.59 Y101.111 E.10975
G1 X126.59 Y101.891 E.01534
G1 X121.01 Y101.891 E.10975
G1 X121.01 Y101.171 E.01416
; WIPE_START
G1 F1500
M204 S6000
G1 X123.01 Y101.149 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G17
G3 Z2.28 I1.217 J0 P1  F18000
; stop printing object, unique label id: 12
M625
; object ids of layer 15 start: 8,12
M624 AwAAAAAAAAA=
;===================== date: 20250206 =====================

; don't support timelapse gcode in spiral_mode and by object sequence for I3 structure printer
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
G92 E0
G1 Z2.28
G1 X0 Y85.35 ; move to safe pos
G1 X-13.0 F3000 ; move to safe pos
M400
M1004 S5 P1  ; external shutter
M400 P300
M971 S11 C11 O0
G92 E0
G1 X0 F18000
M623

; SKIPTYPE: head_wrap_detect
M622.1 S1
M1002 judge_flag g39_3rd_layer_detect_flag
M622 J1
    ; enable nozzle clog detect at 3rd layer
    


    M622.1 S1
    M1002 judge_flag g39_detection_flag
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




; object ids of this layer15 end: 8,12
M625
; start printing object, unique label id: 12
M624 AgAAAAAAAAA=
G1 X121.215 Y101.501
G1 Z1.88
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.396522
G1 F655
M204 S6000
G1 X126.385 Y101.501 E.09565
; WIPE_START
G1 F1500
G1 X124.385 Y101.501 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X121.149 Y94.588 Z2.28 F18000
G1 X121.01 Y94.291 Z2.28
G1 Z1.88
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F655
M204 S500
G1 X121.01 Y93.511 E.01534
G1 X126.59 Y93.511 E.10975
G1 X126.59 Y94.291 E.01534
G1 X121.07 Y94.291 E.10857
M204 S10000
G1 X121.215 Y93.901 F18000
; FEATURE: Gap infill
; LINE_WIDTH: 0.396532
G1 F655
M204 S6000
G1 X126.385 Y93.901 E.09565
; OBJECT_ID: 8
; WIPE_START
G1 F1500
G1 X124.385 Y93.901 E-.38
; WIPE_END
G1 E-.02 F1800
; stop printing object, unique label id: 12
M625
; start printing object, unique label id: 8
M624 AQAAAAAAAAA=
M204 S10000
G1 X117.28 Y91.114 Z2.28 F18000
G1 X56.457 Y67.257 Z2.28
G1 Z1.88
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F655
M204 S500
G1 X55.943 Y67.257 E.01086
G1 X55.943 Y66.744 E.01086
G1 X56.457 Y66.744 E.01086
G1 X56.457 Y67.197 E.00959
M204 S10000
G1 X56.881 Y67.682 F18000
G1 F655
M204 S500
G1 X55.519 Y67.682 E.02882
G1 X55.519 Y66.32 E.02882
G1 X56.881 Y66.32 E.02882
G1 X56.881 Y67.622 E.02755
M204 S250
G1 X57.29 Y68.091 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F655
M204 S500
G1 X55.11 Y68.091 E.04288
G1 X55.11 Y65.911 E.04288
G1 X57.29 Y65.911 E.04288
G1 X57.29 Y68.031 E.0417
; CHANGE_LAYER
; Z_HEIGHT: 2
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F1500
M204 S6000
G1 X55.291 Y68.086 E-.38
; WIPE_END
G1 E-.02 F1800
; stop printing object, unique label id: 8
M625
; layer num/total_layer_count: 16/51
; update layer progress
M73 L16
M991 S0 P15 ;notify layer change
; OBJECT_ID: 12
; start printing object, unique label id: 12
M624 AgAAAAAAAAA=
M204 S10000
G17
G3 Z2.28 I-.446 J1.132 P1  F18000
G1 X127.2 Y96.423 Z2.28
G1 Z2
G1 E.4 F1800
; FEATURE: Support interface
G1 F1049
M204 S6000
G1 X120.577 Y96.423 E.13028
G1 X120.577 Y97.317 E.01759
G1 X127.023 Y97.317 E.12679
G1 X127.023 Y98.212 E.01759
G1 X120.577 Y98.212 E.12679
G1 X120.577 Y99.106 E.01759
G1 X122.808 Y99.106 E.04388
G1 X122.947 Y98.966 E.00388
G1 X123.229 Y98.849 E.00601
G1 X124.371 Y98.85 E.02245
G1 X124.653 Y98.966 E.00601
G1 X124.793 Y99.106 E.00388
G1 X127.2 Y99.106 E.04736
; WIPE_START
G1 F1500
G1 X125.2 Y99.106 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X117.569 Y98.99 Z2.4 F18000
G1 X55.85 Y98.051 Z2.4
G1 Z2
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1049
M204 S500
G1 X55.85 Y97.351 E.01481
G1 X56.55 Y97.351 E.01481
G1 X56.55 Y98.051 E.01481
G1 X55.91 Y98.051 E.01354
M204 S250
G1 X55.441 Y98.46 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1049
M204 S500
G1 X55.441 Y96.942 E.02986
G1 X56.959 Y96.942 E.02986
G1 X56.959 Y98.46 E.02986
G1 X55.501 Y98.46 E.02868
; WIPE_START
M73 P85 R5
G1 F1500
M204 S6000
G1 X55.441 Y96.942 E-.28868
G1 X55.922 Y96.942 E-.09132
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X63.538 Y97.43 Z2.4 F18000
G1 X121.01 Y101.111 Z2.4
G1 Z2
G1 E.4 F1800
G1 F1049
M204 S500
G1 X126.59 Y101.111 E.10975
G1 X126.59 Y101.891 E.01534
G1 X121.01 Y101.891 E.10975
G1 X121.01 Y101.171 E.01416
; WIPE_START
G1 F1500
M204 S6000
G1 X123.01 Y101.149 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G17
G3 Z2.4 I1.217 J0 P1  F18000
; stop printing object, unique label id: 12
M625
; object ids of layer 16 start: 8,12
M624 AwAAAAAAAAA=
;===================== date: 20250206 =====================

; don't support timelapse gcode in spiral_mode and by object sequence for I3 structure printer
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
G92 E0
G1 Z2.4
G1 X0 Y85.35 ; move to safe pos
G1 X-13.0 F3000 ; move to safe pos
M400
M1004 S5 P1  ; external shutter
M400 P300
M971 S11 C11 O0
G92 E0
G1 X0 F18000
M623

; SKIPTYPE: head_wrap_detect
M622.1 S1
M1002 judge_flag g39_3rd_layer_detect_flag
M622 J1
    ; enable nozzle clog detect at 3rd layer
    


    M622.1 S1
    M1002 judge_flag g39_detection_flag
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




; object ids of this layer16 end: 8,12
M625
; start printing object, unique label id: 12
M624 AgAAAAAAAAA=
G1 X121.215 Y101.501
G1 Z2
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.396522
G1 F1049
M204 S6000
G1 X126.385 Y101.501 E.09565
; WIPE_START
G1 F1500
G1 X124.385 Y101.501 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X121.149 Y94.588 Z2.4 F18000
G1 X121.01 Y94.291 Z2.4
G1 Z2
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1049
M204 S500
G1 X121.01 Y93.511 E.01534
G1 X126.59 Y93.511 E.10975
G1 X126.59 Y94.291 E.01534
G1 X121.07 Y94.291 E.10857
M204 S10000
G1 X121.215 Y93.901 F18000
; FEATURE: Gap infill
; LINE_WIDTH: 0.396532
G1 F1049
M204 S6000
G1 X126.385 Y93.901 E.09565
; OBJECT_ID: 8
; WIPE_START
G1 F1500
G1 X124.385 Y93.901 E-.38
; WIPE_END
G1 E-.02 F1800
; stop printing object, unique label id: 12
M625
; start printing object, unique label id: 8
M624 AQAAAAAAAAA=
M204 S10000
G1 X117.28 Y91.114 Z2.4 F18000
G1 X56.457 Y67.257 Z2.4
G1 Z2
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1049
M204 S500
G1 X55.943 Y67.257 E.01086
G1 X55.943 Y66.744 E.01086
G1 X56.457 Y66.744 E.01086
G1 X56.457 Y67.197 E.00959
M204 S10000
G1 X56.881 Y67.682 F18000
G1 F1049
M204 S500
G1 X55.519 Y67.682 E.02882
G1 X55.519 Y66.32 E.02882
G1 X56.881 Y66.32 E.02882
G1 X56.881 Y67.622 E.02755
M204 S250
G1 X57.29 Y68.091 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1049
M204 S500
G1 X55.11 Y68.091 E.04288
G1 X55.11 Y65.911 E.04288
G1 X57.29 Y65.911 E.04288
G1 X57.29 Y68.031 E.0417
; CHANGE_LAYER
; Z_HEIGHT: 2.12
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F1500
M204 S6000
G1 X55.291 Y68.086 E-.38
; WIPE_END
G1 E-.02 F1800
; stop printing object, unique label id: 8
M625
; layer num/total_layer_count: 17/51
; update layer progress
M73 L17
M991 S0 P16 ;notify layer change
; OBJECT_ID: 12
; start printing object, unique label id: 12
M624 AgAAAAAAAAA=
M204 S10000
G17
G3 Z2.4 I-1.217 J.023 P1  F18000
G1 X55.861 Y98.04 Z2.4
G1 Z2.12
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F651
M204 S500
G1 X55.861 Y97.362 E.01435
G1 X56.539 Y97.362 E.01435
G1 X56.539 Y98.04 E.01435
G1 X55.921 Y98.04 E.01308
M204 S250
G1 X55.452 Y98.449 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F651
M204 S500
G1 X55.452 Y96.953 E.02943
G1 X56.948 Y96.953 E.02943
G1 X56.948 Y98.449 E.02943
G1 X55.512 Y98.449 E.02825
; WIPE_START
G1 F1500
M204 S6000
G1 X55.452 Y96.953 E-.28454
G1 X55.954 Y96.953 E-.09546
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X63.571 Y97.439 Z2.52 F18000
G1 X121.01 Y101.111 Z2.52
G1 Z2.12
G1 E.4 F1800
G1 F651
M204 S500
G1 X126.59 Y101.111 E.10975
G1 X126.59 Y101.891 E.01534
G1 X121.01 Y101.891 E.10975
G1 X121.01 Y101.171 E.01416
; WIPE_START
G1 F1500
M204 S6000
G1 X123.01 Y101.149 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G17
G3 Z2.52 I1.217 J0 P1  F18000
; stop printing object, unique label id: 12
M625
; object ids of layer 17 start: 8,12
M624 AwAAAAAAAAA=
;===================== date: 20250206 =====================

; don't support timelapse gcode in spiral_mode and by object sequence for I3 structure printer
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
G92 E0
G1 Z2.52
G1 X0 Y85.35 ; move to safe pos
G1 X-13.0 F3000 ; move to safe pos
M400
M1004 S5 P1  ; external shutter
M400 P300
M971 S11 C11 O0
G92 E0
G1 X0 F18000
M623

; SKIPTYPE: head_wrap_detect
M622.1 S1
M1002 judge_flag g39_3rd_layer_detect_flag
M622 J1
    ; enable nozzle clog detect at 3rd layer
    


    M622.1 S1
    M1002 judge_flag g39_detection_flag
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




; object ids of this layer17 end: 8,12
M625
; start printing object, unique label id: 12
M624 AgAAAAAAAAA=
G1 X121.215 Y101.501
G1 Z2.12
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.396522
G1 F651
M204 S6000
G1 X126.385 Y101.501 E.09565
; WIPE_START
G1 F1500
G1 X124.385 Y101.501 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X121.149 Y94.588 Z2.52 F18000
G1 X121.01 Y94.291 Z2.52
G1 Z2.12
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F651
M204 S500
G1 X121.01 Y93.511 E.01534
G1 X126.59 Y93.511 E.10975
G1 X126.59 Y94.291 E.01534
G1 X121.07 Y94.291 E.10857
M204 S10000
G1 X121.215 Y93.901 F18000
; FEATURE: Gap infill
; LINE_WIDTH: 0.396532
G1 F651
M204 S6000
G1 X126.385 Y93.901 E.09565
; OBJECT_ID: 8
; WIPE_START
G1 F1500
G1 X124.385 Y93.901 E-.38
; WIPE_END
G1 E-.02 F1800
; stop printing object, unique label id: 12
M625
; start printing object, unique label id: 8
M624 AQAAAAAAAAA=
M204 S10000
G1 X117.28 Y91.114 Z2.52 F18000
G1 X56.457 Y67.257 Z2.52
G1 Z2.12
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F651
M204 S500
G1 X55.943 Y67.257 E.01086
G1 X55.943 Y66.744 E.01086
G1 X56.457 Y66.744 E.01086
G1 X56.457 Y67.197 E.00959
M204 S10000
G1 X56.881 Y67.682 F18000
G1 F651
M204 S500
G1 X55.519 Y67.682 E.02882
G1 X55.519 Y66.32 E.02882
G1 X56.881 Y66.32 E.02882
G1 X56.881 Y67.622 E.02755
M204 S250
G1 X57.29 Y68.091 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F651
M204 S500
G1 X55.11 Y68.091 E.04288
G1 X55.11 Y65.911 E.04288
G1 X57.29 Y65.911 E.04288
G1 X57.29 Y68.031 E.0417
; CHANGE_LAYER
; Z_HEIGHT: 2.24
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F1500
M204 S6000
G1 X55.291 Y68.086 E-.38
; WIPE_END
G1 E-.02 F1800
; stop printing object, unique label id: 8
M625
; layer num/total_layer_count: 18/51
; update layer progress
M73 L18
M991 S0 P17 ;notify layer change
; OBJECT_ID: 12
; start printing object, unique label id: 12
M624 AgAAAAAAAAA=
M204 S10000
G17
G3 Z2.52 I-1.217 J.024 P1  F18000
G1 X55.872 Y98.029 Z2.52
G1 Z2.24
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F650
M204 S500
G1 X55.872 Y97.373 E.01389
G1 X56.528 Y97.373 E.01389
G1 X56.528 Y98.029 E.01389
G1 X55.932 Y98.029 E.01262
M204 S250
G1 X55.463 Y98.438 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F650
M204 S500
G1 X55.463 Y96.964 E.029
G1 X56.937 Y96.964 E.029
G1 X56.937 Y98.438 E.029
G1 X55.523 Y98.438 E.02782
; WIPE_START
G1 F1500
M204 S6000
M73 P85 R4
G1 X55.463 Y96.964 E-.2804
G1 X55.987 Y96.964 E-.0996
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X63.604 Y97.449 Z2.64 F18000
G1 X121.01 Y101.111 Z2.64
G1 Z2.24
G1 E.4 F1800
G1 F650
M204 S500
G1 X126.59 Y101.111 E.10975
G1 X126.59 Y101.891 E.01534
G1 X121.01 Y101.891 E.10975
G1 X121.01 Y101.171 E.01416
; WIPE_START
G1 F1500
M204 S6000
G1 X123.01 Y101.149 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G17
G3 Z2.64 I1.217 J0 P1  F18000
; stop printing object, unique label id: 12
M625
; object ids of layer 18 start: 8,12
M624 AwAAAAAAAAA=
;===================== date: 20250206 =====================

; don't support timelapse gcode in spiral_mode and by object sequence for I3 structure printer
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
G92 E0
G1 Z2.64
G1 X0 Y85.35 ; move to safe pos
G1 X-13.0 F3000 ; move to safe pos
M400
M1004 S5 P1  ; external shutter
M400 P300
M971 S11 C11 O0
G92 E0
G1 X0 F18000
M623

; SKIPTYPE: head_wrap_detect
M622.1 S1
M1002 judge_flag g39_3rd_layer_detect_flag
M622 J1
    ; enable nozzle clog detect at 3rd layer
    


    M622.1 S1
    M1002 judge_flag g39_detection_flag
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




; object ids of this layer18 end: 8,12
M625
; start printing object, unique label id: 12
M624 AgAAAAAAAAA=
G1 X121.215 Y101.501
G1 Z2.24
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.396522
G1 F650
M204 S6000
G1 X126.385 Y101.501 E.09565
; WIPE_START
G1 F1500
G1 X124.385 Y101.501 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X121.149 Y94.588 Z2.64 F18000
G1 X121.01 Y94.291 Z2.64
G1 Z2.24
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F650
M204 S500
G1 X121.01 Y93.511 E.01534
M73 P86 R4
G1 X126.59 Y93.511 E.10975
G1 X126.59 Y94.291 E.01534
G1 X121.07 Y94.291 E.10857
M204 S10000
G1 X121.215 Y93.901 F18000
; FEATURE: Gap infill
; LINE_WIDTH: 0.396532
G1 F650
M204 S6000
G1 X126.385 Y93.901 E.09565
; OBJECT_ID: 8
; WIPE_START
G1 F1500
G1 X124.385 Y93.901 E-.38
; WIPE_END
G1 E-.02 F1800
; stop printing object, unique label id: 12
M625
; start printing object, unique label id: 8
M624 AQAAAAAAAAA=
M204 S10000
G1 X117.28 Y91.114 Z2.64 F18000
G1 X56.457 Y67.257 Z2.64
G1 Z2.24
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F650
M204 S500
G1 X55.943 Y67.257 E.01086
G1 X55.943 Y66.744 E.01086
G1 X56.457 Y66.744 E.01086
G1 X56.457 Y67.197 E.00959
M204 S10000
G1 X56.881 Y67.682 F18000
G1 F650
M204 S500
G1 X55.519 Y67.682 E.02882
G1 X55.519 Y66.32 E.02882
G1 X56.881 Y66.32 E.02882
G1 X56.881 Y67.622 E.02755
M204 S250
G1 X57.29 Y68.091 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F650
M204 S500
G1 X55.11 Y68.091 E.04288
G1 X55.11 Y65.911 E.04288
G1 X57.29 Y65.911 E.04288
G1 X57.29 Y68.031 E.0417
; CHANGE_LAYER
; Z_HEIGHT: 2.264
; LAYER_HEIGHT: 0.0239999
; WIPE_START
G1 F1500
M204 S6000
G1 X55.291 Y68.086 E-.38
; WIPE_END
G1 E-.02 F1800
; stop printing object, unique label id: 8
M625
; layer num/total_layer_count: 19/51
; update layer progress
M73 L19
M991 S0 P18 ;notify layer change
; OBJECT_ID: 12
; start printing object, unique label id: 12
M624 AgAAAAAAAAA=
M204 S10000
G17
G3 Z2.64 I-.516 J1.102 P1  F18000
G1 X121.298 Y98.995 Z2.64
G1 Z2.264
G1 E.4 F1800
; FEATURE: Support interface
; LAYER_HEIGHT: 0.264
G1 F1042
M204 S6000
G1 X121.298 Y96.583 E.09619
G1 X122.193 Y96.583 E.03566
G1 X122.193 Y98.818 E.08911
G1 X122.502 Y98.818 E.01233
G1 X122.709 Y98.61 E.0117
G1 X123.087 Y98.454 E.0163
G1 X123.087 Y96.948 E.06006
G1 X123.146 Y96.972 E.00254
G1 X123.981 Y96.972 E.03331
G1 X123.981 Y98.43 E.05812
G1 X124.455 Y98.43 E.01888
G1 X124.875 Y98.604 E.01817
G1 X124.875 Y96.798 E.07203
G1 X125.099 Y96.583 E.01235
G1 X125.77 Y96.583 E.02675
G1 X125.77 Y98.996 E.0962
; WIPE_START
G1 F1251.002
G1 X125.77 Y96.996 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G17
G3 Z2.664 I1.217 J0 P1  F18000
; stop printing object, unique label id: 12
M625
; object ids of layer 19 start: 12
M624 AgAAAAAAAAA=
;===================== date: 20250206 =====================

; don't support timelapse gcode in spiral_mode and by object sequence for I3 structure printer
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
G92 E0
G1 Z2.664
G1 X0 Y85.35 ; move to safe pos
G1 X-13.0 F3000 ; move to safe pos
M400
M1004 S5 P1  ; external shutter
M400 P300
M971 S11 C11 O0
G92 E0
G1 X0 F18000
M623

; SKIPTYPE: head_wrap_detect
M622.1 S1
M1002 judge_flag g39_3rd_layer_detect_flag
M622 J1
    ; enable nozzle clog detect at 3rd layer
    


    M622.1 S1
    M1002 judge_flag g39_detection_flag
    M622 J1
      
        M622.1 S0
        M1002 judge_flag g39_mass_exceed_flag
        M622 J1
        
            G392 S0
            M400
            G90
            M83
            M204 S5000
            G0 Z2.664 F4000
            G39.3 S1
            G0 Z2.664 F4000
            G392 S0
          
        M623
    
    M623
M623
; SKIPPABLE_END




; object ids of this layer19 end: 12
M625
; CHANGE_LAYER
; Z_HEIGHT: 2.36
; LAYER_HEIGHT: 0.096
; layer num/total_layer_count: 20/51
; update layer progress
M73 L20
M991 S0 P19 ;notify layer change
; OBJECT_ID: 12
; start printing object, unique label id: 12
M624 AgAAAAAAAAA=
G1 X55.883 Y98.018
G1 Z2.36
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
; LAYER_HEIGHT: 0.12
G1 F1042
M204 S500
G1 X55.883 Y97.384 E.01342
G1 X56.517 Y97.384 E.01342
G1 X56.517 Y98.018 E.01342
G1 X55.943 Y98.018 E.01215
M204 S250
G1 X55.474 Y98.427 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1042
M204 S500
G1 X55.474 Y96.974 E.02857
G1 X56.926 Y96.974 E.02857
G1 X56.926 Y98.427 E.02857
G1 X55.534 Y98.427 E.02739
; WIPE_START
G1 F1500
M204 S6000
G1 X55.474 Y96.974 E-.27626
G1 X56.02 Y96.974 E-.10375
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X63.637 Y97.459 Z2.76 F18000
G1 X121.01 Y101.111 Z2.76
G1 Z2.36
G1 E.4 F1800
G1 F1042
M204 S500
G1 X126.59 Y101.111 E.10975
G1 X126.59 Y101.891 E.01534
G1 X121.01 Y101.891 E.10975
G1 X121.01 Y101.171 E.01416
; WIPE_START
G1 F1500
M204 S6000
G1 X123.01 Y101.149 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G17
G3 Z2.76 I1.217 J0 P1  F18000
; stop printing object, unique label id: 12
M625
; object ids of layer 20 start: 8,12
M624 AwAAAAAAAAA=
;===================== date: 20250206 =====================

; don't support timelapse gcode in spiral_mode and by object sequence for I3 structure printer
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
G92 E0
G1 Z2.76
G1 X0 Y85.35 ; move to safe pos
G1 X-13.0 F3000 ; move to safe pos
M400
M1004 S5 P1  ; external shutter
M400 P300
M971 S11 C11 O0
G92 E0
G1 X0 F18000
M623

; SKIPTYPE: head_wrap_detect
M622.1 S1
M1002 judge_flag g39_3rd_layer_detect_flag
M622 J1
    ; enable nozzle clog detect at 3rd layer
    


    M622.1 S1
    M1002 judge_flag g39_detection_flag
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




; object ids of this layer20 end: 8,12
M625
; start printing object, unique label id: 12
M624 AgAAAAAAAAA=
G1 X121.215 Y101.501
G1 Z2.36
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.396522
G1 F1042
M204 S6000
G1 X126.385 Y101.501 E.09565
; WIPE_START
G1 F1500
G1 X124.385 Y101.501 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X121.149 Y94.588 Z2.76 F18000
G1 X121.01 Y94.291 Z2.76
G1 Z2.36
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1042
M204 S500
G1 X121.01 Y93.511 E.01534
G1 X126.59 Y93.511 E.10975
G1 X126.59 Y94.291 E.01534
G1 X121.07 Y94.291 E.10857
M204 S10000
G1 X121.215 Y93.901 F18000
; FEATURE: Gap infill
; LINE_WIDTH: 0.396532
G1 F1042
M204 S6000
G1 X126.385 Y93.901 E.09565
; OBJECT_ID: 8
; WIPE_START
G1 F1500
G1 X124.385 Y93.901 E-.38
; WIPE_END
G1 E-.02 F1800
; stop printing object, unique label id: 12
M625
; start printing object, unique label id: 8
M624 AQAAAAAAAAA=
M204 S10000
G1 X117.28 Y91.114 Z2.76 F18000
G1 X56.457 Y67.257 Z2.76
G1 Z2.36
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1042
M204 S500
G1 X55.943 Y67.257 E.01086
G1 X55.943 Y66.744 E.01086
G1 X56.457 Y66.744 E.01086
G1 X56.457 Y67.197 E.00959
M204 S10000
G1 X56.881 Y67.682 F18000
G1 F1042
M204 S500
G1 X55.519 Y67.682 E.02882
G1 X55.519 Y66.32 E.02882
G1 X56.881 Y66.32 E.02882
G1 X56.881 Y67.622 E.02755
M204 S250
G1 X57.29 Y68.091 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1042
M204 S500
G1 X55.11 Y68.091 E.04288
G1 X55.11 Y65.911 E.04288
G1 X57.29 Y65.911 E.04288
G1 X57.29 Y68.031 E.0417
; CHANGE_LAYER
; Z_HEIGHT: 2.48
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F1500
M204 S6000
G1 X55.291 Y68.086 E-.38
; WIPE_END
G1 E-.02 F1800
; stop printing object, unique label id: 8
M625
; layer num/total_layer_count: 21/51
; update layer progress
M73 L21
M991 S0 P20 ;notify layer change
; OBJECT_ID: 12
; start printing object, unique label id: 12
M624 AgAAAAAAAAA=
M204 S10000
G17
G3 Z2.76 I-1.217 J.025 P1  F18000
G1 X55.894 Y98.007 Z2.76
G1 Z2.48
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F646
M204 S500
G1 X55.894 Y97.395 E.01296
G1 X56.506 Y97.395 E.01296
G1 X56.506 Y98.007 E.01296
G1 X55.954 Y98.007 E.01169
M204 S250
G1 X55.485 Y98.416 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F646
M204 S500
G1 X55.485 Y96.985 E.02814
G1 X56.915 Y96.985 E.02814
G1 X56.915 Y98.416 E.02814
G1 X55.545 Y98.416 E.02696
; WIPE_START
G1 F1500
M204 S6000
G1 X55.485 Y96.985 E-.27211
G1 X56.052 Y96.985 E-.10789
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X63.669 Y97.469 Z2.88 F18000
G1 X121.01 Y101.111 Z2.88
G1 Z2.48
G1 E.4 F1800
G1 F646
M204 S500
G1 X126.59 Y101.111 E.10975
G1 X126.59 Y101.891 E.01534
G1 X121.01 Y101.891 E.10975
G1 X121.01 Y101.171 E.01416
; WIPE_START
G1 F1500
M204 S6000
G1 X123.01 Y101.149 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G17
G3 Z2.88 I1.217 J0 P1  F18000
; stop printing object, unique label id: 12
M625
; object ids of layer 21 start: 8,12
M624 AwAAAAAAAAA=
;===================== date: 20250206 =====================

; don't support timelapse gcode in spiral_mode and by object sequence for I3 structure printer
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
G92 E0
G1 Z2.88
G1 X0 Y85.35 ; move to safe pos
G1 X-13.0 F3000 ; move to safe pos
M400
M1004 S5 P1  ; external shutter
M400 P300
M971 S11 C11 O0
G92 E0
G1 X0 F18000
M623

; SKIPTYPE: head_wrap_detect
M622.1 S1
M1002 judge_flag g39_3rd_layer_detect_flag
M622 J1
    ; enable nozzle clog detect at 3rd layer
    


    M622.1 S1
    M1002 judge_flag g39_detection_flag
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




; object ids of this layer21 end: 8,12
M625
; start printing object, unique label id: 12
M624 AgAAAAAAAAA=
G1 X121.215 Y101.501
G1 Z2.48
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.396522
G1 F646
M204 S6000
G1 X126.385 Y101.501 E.09565
; WIPE_START
M73 P87 R4
G1 F1500
G1 X124.385 Y101.501 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X121.149 Y94.588 Z2.88 F18000
G1 X121.01 Y94.291 Z2.88
G1 Z2.48
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F646
M204 S500
G1 X121.01 Y93.511 E.01534
G1 X126.59 Y93.511 E.10975
G1 X126.59 Y94.291 E.01534
G1 X121.07 Y94.291 E.10857
M204 S10000
G1 X121.215 Y93.901 F18000
; FEATURE: Gap infill
; LINE_WIDTH: 0.396532
G1 F646
M204 S6000
G1 X126.385 Y93.901 E.09565
; OBJECT_ID: 8
; WIPE_START
G1 F1500
G1 X124.385 Y93.901 E-.38
; WIPE_END
G1 E-.02 F1800
; stop printing object, unique label id: 12
M625
; start printing object, unique label id: 8
M624 AQAAAAAAAAA=
M204 S10000
G1 X117.28 Y91.114 Z2.88 F18000
G1 X56.457 Y67.257 Z2.88
G1 Z2.48
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F646
M204 S500
G1 X55.943 Y67.257 E.01086
G1 X55.943 Y66.744 E.01086
G1 X56.457 Y66.744 E.01086
G1 X56.457 Y67.197 E.00959
M204 S10000
G1 X56.881 Y67.682 F18000
G1 F646
M204 S500
G1 X55.519 Y67.682 E.02882
G1 X55.519 Y66.32 E.02882
G1 X56.881 Y66.32 E.02882
G1 X56.881 Y67.622 E.02755
M204 S250
G1 X57.29 Y68.091 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F646
M204 S500
G1 X55.11 Y68.091 E.04288
G1 X55.11 Y65.911 E.04288
G1 X57.29 Y65.911 E.04288
G1 X57.29 Y68.031 E.0417
; CHANGE_LAYER
; Z_HEIGHT: 2.528
; LAYER_HEIGHT: 0.0480001
; WIPE_START
G1 F1500
M204 S6000
G1 X55.291 Y68.086 E-.38
; WIPE_END
G1 E-.02 F1800
; stop printing object, unique label id: 8
M625
; layer num/total_layer_count: 22/51
; update layer progress
M73 L22
M991 S0 P21 ;notify layer change
; OBJECT_ID: 12
; start printing object, unique label id: 12
M624 AgAAAAAAAAA=
M204 S10000
G17
G3 Z2.88 I-.461 J1.126 P1  F18000
G1 X126.78 Y97.317 Z2.88
G1 Z2.528
G1 E.4 F1800
; FEATURE: Support interface
; LAYER_HEIGHT: 0.264
G1 F987
M204 S6000
G1 X120.997 Y97.317 E.23065
G1 X120.997 Y98.212 E.03566
G1 X126.78 Y98.212 E.23065
; WIPE_START
G1 F1251.002
G1 X124.78 Y98.212 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G17
G3 Z2.928 I1.217 J0 P1  F18000
; stop printing object, unique label id: 12
M625
; object ids of layer 22 start: 12
M624 AgAAAAAAAAA=
;===================== date: 20250206 =====================

; don't support timelapse gcode in spiral_mode and by object sequence for I3 structure printer
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
G92 E0
G1 Z2.928
G1 X0 Y85.35 ; move to safe pos
G1 X-13.0 F3000 ; move to safe pos
M400
M1004 S5 P1  ; external shutter
M400 P300
M971 S11 C11 O0
G92 E0
G1 X0 F18000
M623

; SKIPTYPE: head_wrap_detect
M622.1 S1
M1002 judge_flag g39_3rd_layer_detect_flag
M622 J1
    ; enable nozzle clog detect at 3rd layer
    


    M622.1 S1
    M1002 judge_flag g39_detection_flag
    M622 J1
      
        M622.1 S0
        M1002 judge_flag g39_mass_exceed_flag
        M622 J1
        
            G392 S0
            M400
            G90
            M83
            M204 S5000
            G0 Z2.928 F4000
            G39.3 S1
            G0 Z2.928 F4000
            G392 S0
          
        M623
    
    M623
M623
; SKIPPABLE_END




; object ids of this layer22 end: 12
M625
; CHANGE_LAYER
; Z_HEIGHT: 2.6
; LAYER_HEIGHT: 0.0719998
; layer num/total_layer_count: 23/51
; update layer progress
M73 L23
M991 S0 P22 ;notify layer change
; OBJECT_ID: 12
; start printing object, unique label id: 12
M624 AgAAAAAAAAA=
G1 X55.905 Y97.996
G1 Z2.6
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
; LAYER_HEIGHT: 0.12
G1 F987
M204 S500
G1 X55.905 Y97.405 E.0125
G1 X56.495 Y97.405 E.0125
G1 X56.495 Y97.996 E.0125
G1 X55.965 Y97.996 E.01123
M204 S250
G1 X55.495 Y98.405 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F987
M204 S500
G1 X55.495 Y96.996 E.02772
G1 X56.905 Y96.996 E.02772
G1 X56.905 Y98.405 E.02772
G1 X55.555 Y98.405 E.02654
; WIPE_START
G1 F1500
M204 S6000
G1 X55.495 Y96.996 E-.26797
G1 X56.085 Y96.996 E-.11203
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X63.702 Y97.479 Z3 F18000
G1 X121.01 Y101.111 Z3
G1 Z2.6
G1 E.4 F1800
G1 F987
M204 S500
G1 X126.59 Y101.111 E.10975
G1 X126.59 Y101.891 E.01534
G1 X121.01 Y101.891 E.10975
G1 X121.01 Y101.171 E.01416
; WIPE_START
G1 F1500
M204 S6000
G1 X123.01 Y101.149 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G17
G3 Z3 I1.217 J0 P1  F18000
; stop printing object, unique label id: 12
M625
; object ids of layer 23 start: 8,12
M624 AwAAAAAAAAA=
;===================== date: 20250206 =====================

; don't support timelapse gcode in spiral_mode and by object sequence for I3 structure printer
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
G92 E0
G1 Z3
G1 X0 Y85.35 ; move to safe pos
G1 X-13.0 F3000 ; move to safe pos
M400
M1004 S5 P1  ; external shutter
M400 P300
M971 S11 C11 O0
G92 E0
G1 X0 F18000
M623

; SKIPTYPE: head_wrap_detect
M622.1 S1
M1002 judge_flag g39_3rd_layer_detect_flag
M622 J1
    ; enable nozzle clog detect at 3rd layer
    


    M622.1 S1
    M1002 judge_flag g39_detection_flag
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




; object ids of this layer23 end: 8,12
M625
; start printing object, unique label id: 12
M624 AgAAAAAAAAA=
G1 X121.215 Y101.501
G1 Z2.6
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.396522
G1 F987
M204 S6000
G1 X126.385 Y101.501 E.09565
; WIPE_START
G1 F1500
G1 X124.385 Y101.501 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X121.149 Y94.588 Z3 F18000
G1 X121.01 Y94.291 Z3
G1 Z2.6
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F987
M204 S500
G1 X121.01 Y93.511 E.01534
G1 X126.59 Y93.511 E.10975
G1 X126.59 Y94.291 E.01534
G1 X121.07 Y94.291 E.10857
M204 S10000
G1 X121.215 Y93.901 F18000
; FEATURE: Gap infill
; LINE_WIDTH: 0.396532
G1 F987
M204 S6000
G1 X126.385 Y93.901 E.09565
; OBJECT_ID: 8
; WIPE_START
G1 F1500
G1 X124.385 Y93.901 E-.38
; WIPE_END
G1 E-.02 F1800
; stop printing object, unique label id: 12
M625
; start printing object, unique label id: 8
M624 AQAAAAAAAAA=
M204 S10000
G1 X117.28 Y91.114 Z3 F18000
G1 X56.457 Y67.257 Z3
G1 Z2.6
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F987
M204 S500
G1 X55.943 Y67.257 E.01086
G1 X55.943 Y66.744 E.01086
G1 X56.457 Y66.744 E.01086
G1 X56.457 Y67.197 E.00959
M204 S10000
G1 X56.881 Y67.682 F18000
G1 F987
M204 S500
G1 X55.519 Y67.682 E.02882
G1 X55.519 Y66.32 E.02882
G1 X56.881 Y66.32 E.02882
G1 X56.881 Y67.622 E.02755
M204 S250
G1 X57.29 Y68.091 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F987
M204 S500
G1 X55.11 Y68.091 E.04288
G1 X55.11 Y65.911 E.04288
G1 X57.29 Y65.911 E.04288
G1 X57.29 Y68.031 E.0417
; CHANGE_LAYER
; Z_HEIGHT: 2.72
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F1500
M204 S6000
G1 X55.291 Y68.086 E-.38
; WIPE_END
G1 E-.02 F1800
; stop printing object, unique label id: 8
M625
; layer num/total_layer_count: 24/51
; update layer progress
M73 L24
M991 S0 P23 ;notify layer change
; OBJECT_ID: 12
; start printing object, unique label id: 12
M624 AgAAAAAAAAA=
M204 S10000
G17
G3 Z3 I-1.217 J.025 P1  F18000
G1 X55.916 Y97.985 Z3
G1 Z2.72
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F642
M204 S500
G1 X55.916 Y97.416 E.01204
G1 X56.484 Y97.416 E.01204
G1 X56.484 Y97.985 E.01204
G1 X55.976 Y97.985 E.01077
M204 S250
G1 X55.506 Y98.394 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F642
M204 S500
G1 X55.506 Y97.007 E.02729
G1 X56.894 Y97.007 E.02729
G1 X56.894 Y98.394 E.02729
G1 X55.566 Y98.394 E.02611
; WIPE_START
G1 F1500
M204 S6000
G1 X55.506 Y97.007 E-.26383
G1 X56.118 Y97.007 E-.11617
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X63.735 Y97.489 Z3.12 F18000
G1 X121.01 Y101.111 Z3.12
G1 Z2.72
G1 E.4 F1800
G1 F642
M204 S500
G1 X126.59 Y101.111 E.10975
G1 X126.59 Y101.891 E.01534
G1 X121.01 Y101.891 E.10975
G1 X121.01 Y101.171 E.01416
; WIPE_START
G1 F1500
M204 S6000
G1 X123.01 Y101.149 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G17
G3 Z3.12 I1.217 J0 P1  F18000
; stop printing object, unique label id: 12
M625
; object ids of layer 24 start: 8,12
M624 AwAAAAAAAAA=
;===================== date: 20250206 =====================

; don't support timelapse gcode in spiral_mode and by object sequence for I3 structure printer
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
G92 E0
G1 Z3.12
G1 X0 Y85.35 ; move to safe pos
G1 X-13.0 F3000 ; move to safe pos
M400
M1004 S5 P1  ; external shutter
M400 P300
M971 S11 C11 O0
G92 E0
G1 X0 F18000
M623

; SKIPTYPE: head_wrap_detect
M622.1 S1
M1002 judge_flag g39_3rd_layer_detect_flag
M622 J1
    ; enable nozzle clog detect at 3rd layer
    


    M622.1 S1
    M1002 judge_flag g39_detection_flag
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




; object ids of this layer24 end: 8,12
M625
; start printing object, unique label id: 12
M624 AgAAAAAAAAA=
G1 X121.215 Y101.501
G1 Z2.72
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.396522
G1 F642
M204 S6000
G1 X126.385 Y101.501 E.09565
; WIPE_START
G1 F1500
G1 X124.385 Y101.501 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
M73 P88 R4
G1 X121.149 Y94.588 Z3.12 F18000
G1 X121.01 Y94.291 Z3.12
G1 Z2.72
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F642
M204 S500
G1 X121.01 Y93.511 E.01534
G1 X126.59 Y93.511 E.10975
G1 X126.59 Y94.291 E.01534
G1 X121.07 Y94.291 E.10857
M204 S10000
G1 X121.215 Y93.901 F18000
; FEATURE: Gap infill
; LINE_WIDTH: 0.396532
G1 F642
M204 S6000
G1 X126.385 Y93.901 E.09565
; OBJECT_ID: 8
; WIPE_START
G1 F1500
G1 X124.385 Y93.901 E-.38
; WIPE_END
G1 E-.02 F1800
; stop printing object, unique label id: 12
M625
; start printing object, unique label id: 8
M624 AQAAAAAAAAA=
M204 S10000
G1 X117.28 Y91.114 Z3.12 F18000
G1 X56.457 Y67.257 Z3.12
G1 Z2.72
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F642
M204 S500
G1 X55.943 Y67.257 E.01086
G1 X55.943 Y66.744 E.01086
G1 X56.457 Y66.744 E.01086
G1 X56.457 Y67.197 E.00959
M204 S10000
G1 X56.881 Y67.682 F18000
G1 F642
M204 S500
G1 X55.519 Y67.682 E.02882
G1 X55.519 Y66.32 E.02882
G1 X56.881 Y66.32 E.02882
G1 X56.881 Y67.622 E.02755
M204 S250
G1 X57.29 Y68.091 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F642
M204 S500
G1 X55.11 Y68.091 E.04288
G1 X55.11 Y65.911 E.04288
G1 X57.29 Y65.911 E.04288
G1 X57.29 Y68.031 E.0417
; CHANGE_LAYER
; Z_HEIGHT: 2.792
; LAYER_HEIGHT: 0.072
; WIPE_START
G1 F1500
M204 S6000
G1 X55.291 Y68.086 E-.38
; WIPE_END
G1 E-.02 F1800
; stop printing object, unique label id: 8
M625
; layer num/total_layer_count: 25/51
; update layer progress
M73 L25
M991 S0 P24 ;notify layer change
; OBJECT_ID: 12
; start printing object, unique label id: 12
M624 AgAAAAAAAAA=
M204 S10000
G17
G3 Z3.12 I-.464 J1.125 P1  F18000
G1 X124.892 Y96.79 Z3.12
G1 Z2.792
G1 E.4 F1800
; FEATURE: Support
; LAYER_HEIGHT: 0.264
G1 F1041
M204 S6000
G1 X125.099 Y96.584 E.01166
G1 X126.603 Y96.584 E.05998
G1 X126.603 Y97.106 E.02083
G1 X120.997 Y97.106 E.22357
G1 X120.997 Y98.818 E.06828
G1 X122.502 Y98.818 E.06001
G1 X122.709 Y98.61 E.0117
G1 X123.146 Y98.429 E.01885
G1 X124.455 Y98.429 E.05219
G1 X124.891 Y98.61 E.01885
G1 X125.099 Y98.818 E.01172
G1 X126.603 Y98.818 E.05998
G1 X126.603 Y97.303 E.06042
; WIPE_START
G1 F1251.002
G1 X126.603 Y98.818 E-.28788
G1 X126.118 Y98.818 E-.09212
; WIPE_END
G1 E-.02 F1800
M204 S10000
G17
G3 Z3.192 I1.217 J0 P1  F18000
; stop printing object, unique label id: 12
M625
; object ids of layer 25 start: 12
M624 AgAAAAAAAAA=
;===================== date: 20250206 =====================

; don't support timelapse gcode in spiral_mode and by object sequence for I3 structure printer
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
G92 E0
G1 Z3.192
G1 X0 Y85.35 ; move to safe pos
G1 X-13.0 F3000 ; move to safe pos
M400
M1004 S5 P1  ; external shutter
M400 P300
M971 S11 C11 O0
G92 E0
G1 X0 F18000
M623

; SKIPTYPE: head_wrap_detect
M622.1 S1
M1002 judge_flag g39_3rd_layer_detect_flag
M622 J1
    ; enable nozzle clog detect at 3rd layer
    


    M622.1 S1
    M1002 judge_flag g39_detection_flag
    M622 J1
      
        M622.1 S0
        M1002 judge_flag g39_mass_exceed_flag
        M622 J1
        
            G392 S0
            M400
            G90
            M83
            M204 S5000
            G0 Z3.192 F4000
            G39.3 S1
            G0 Z3.192 F4000
            G392 S0
          
        M623
    
    M623
M623
; SKIPPABLE_END




; object ids of this layer25 end: 12
M625
; CHANGE_LAYER
; Z_HEIGHT: 2.84
; LAYER_HEIGHT: 0.0479999
; layer num/total_layer_count: 26/51
; update layer progress
M73 L26
M991 S0 P25 ;notify layer change
; OBJECT_ID: 12
; start printing object, unique label id: 12
M624 AgAAAAAAAAA=
G1 X55.927 Y97.974
G1 Z2.84
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
; LAYER_HEIGHT: 0.12
G1 F1041
M204 S500
G1 X55.927 Y97.427 E.01158
G1 X56.473 Y97.427 E.01158
G1 X56.473 Y97.974 E.01158
G1 X55.987 Y97.974 E.01031
M204 S250
G1 X55.517 Y98.384 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1041
M204 S500
G1 X55.517 Y97.018 E.02686
G1 X56.883 Y97.018 E.02686
G1 X56.883 Y98.384 E.02686
G1 X55.577 Y98.384 E.02568
; WIPE_START
G1 F1500
M204 S6000
G1 X55.517 Y97.018 E-.25969
G1 X56.15 Y97.018 E-.12031
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X63.768 Y97.499 Z3.24 F18000
G1 X121.01 Y101.111 Z3.24
G1 Z2.84
G1 E.4 F1800
G1 F1041
M204 S500
G1 X126.59 Y101.111 E.10975
G1 X126.59 Y101.891 E.01534
G1 X121.01 Y101.891 E.10975
G1 X121.01 Y101.171 E.01416
; WIPE_START
G1 F1500
M204 S6000
G1 X123.01 Y101.149 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G17
G3 Z3.24 I1.217 J0 P1  F18000
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
G1 Z3.24
G1 X0 Y85.35 ; move to safe pos
G1 X-13.0 F3000 ; move to safe pos
M400
M1004 S5 P1  ; external shutter
M400 P300
M971 S11 C11 O0
G92 E0
G1 X0 F18000
M623

; SKIPTYPE: head_wrap_detect
M622.1 S1
M1002 judge_flag g39_3rd_layer_detect_flag
M622 J1
    ; enable nozzle clog detect at 3rd layer
    


    M622.1 S1
    M1002 judge_flag g39_detection_flag
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




; object ids of this layer26 end: 8,12
M625
; start printing object, unique label id: 12
M624 AgAAAAAAAAA=
G1 X121.215 Y101.501
G1 Z2.84
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.396522
G1 F1041
M204 S6000
G1 X126.385 Y101.501 E.09565
; WIPE_START
G1 F1500
G1 X124.385 Y101.501 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X121.149 Y94.588 Z3.24 F18000
G1 X121.01 Y94.291 Z3.24
G1 Z2.84
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1041
M204 S500
G1 X121.01 Y93.511 E.01534
G1 X126.59 Y93.511 E.10975
G1 X126.59 Y94.291 E.01534
G1 X121.07 Y94.291 E.10857
M204 S10000
G1 X121.215 Y93.901 F18000
; FEATURE: Gap infill
; LINE_WIDTH: 0.396532
G1 F1041
M204 S6000
G1 X126.385 Y93.901 E.09565
; OBJECT_ID: 8
; WIPE_START
G1 F1500
G1 X124.385 Y93.901 E-.38
; WIPE_END
G1 E-.02 F1800
; stop printing object, unique label id: 12
M625
; start printing object, unique label id: 8
M624 AQAAAAAAAAA=
M204 S10000
M73 P88 R3
G1 X117.28 Y91.114 Z3.24 F18000
G1 X56.457 Y67.257 Z3.24
G1 Z2.84
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1041
M204 S500
G1 X55.943 Y67.257 E.01086
G1 X55.943 Y66.744 E.01086
G1 X56.457 Y66.744 E.01086
G1 X56.457 Y67.197 E.00959
M204 S10000
G1 X56.881 Y67.682 F18000
G1 F1041
M204 S500
G1 X55.519 Y67.682 E.02882
G1 X55.519 Y66.32 E.02882
G1 X56.881 Y66.32 E.02882
G1 X56.881 Y67.622 E.02755
M204 S250
G1 X57.29 Y68.091 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1041
M204 S500
G1 X55.11 Y68.091 E.04288
G1 X55.11 Y65.911 E.04288
G1 X57.29 Y65.911 E.04288
G1 X57.29 Y68.031 E.0417
; CHANGE_LAYER
; Z_HEIGHT: 2.96
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F1500
M204 S6000
G1 X55.291 Y68.086 E-.38
; WIPE_END
G1 E-.02 F1800
; stop printing object, unique label id: 8
M625
; layer num/total_layer_count: 27/51
; update layer progress
M73 L27
M991 S0 P26 ;notify layer change
; OBJECT_ID: 12
; start printing object, unique label id: 12
M624 AgAAAAAAAAA=
M204 S10000
G17
G3 Z3.24 I-1.217 J.026 P1  F18000
G1 X55.937 Y97.963 Z3.24
G1 Z2.96
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F639
M204 S500
G1 X55.937 Y97.438 E.01112
G1 X56.463 Y97.438 E.01112
G1 X56.463 Y97.963 E.01112
G1 X55.997 Y97.963 E.00985
M204 S250
G1 X55.528 Y98.373 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F639
M204 S500
G1 X55.528 Y97.029 E.02643
G1 X56.872 Y97.029 E.02643
G1 X56.872 Y98.373 E.02643
G1 X55.588 Y98.373 E.02525
; WIPE_START
G1 F1500
M204 S6000
G1 X55.528 Y97.029 E-.25555
G1 X56.183 Y97.029 E-.12446
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X63.801 Y97.509 Z3.36 F18000
G1 X121.01 Y101.111 Z3.36
G1 Z2.96
G1 E.4 F1800
G1 F639
M204 S500
G1 X126.59 Y101.111 E.10975
G1 X126.59 Y101.891 E.01534
G1 X121.01 Y101.891 E.10975
G1 X121.01 Y101.171 E.01416
; WIPE_START
G1 F1500
M204 S6000
G1 X123.01 Y101.149 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G17
G3 Z3.36 I1.217 J0 P1  F18000
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
G1 Z3.36
G1 X0 Y85.35 ; move to safe pos
G1 X-13.0 F3000 ; move to safe pos
M400
M1004 S5 P1  ; external shutter
M400 P300
M971 S11 C11 O0
G92 E0
G1 X0 F18000
M623

; SKIPTYPE: head_wrap_detect
M622.1 S1
M1002 judge_flag g39_3rd_layer_detect_flag
M622 J1
    ; enable nozzle clog detect at 3rd layer
    


    M622.1 S1
    M1002 judge_flag g39_detection_flag
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




; object ids of this layer27 end: 8,12
M625
; start printing object, unique label id: 12
M624 AgAAAAAAAAA=
G1 X121.215 Y101.501
G1 Z2.96
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.396522
G1 F639
M204 S6000
M73 P89 R3
G1 X126.385 Y101.501 E.09565
; WIPE_START
G1 F1500
G1 X124.385 Y101.501 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X121.149 Y94.588 Z3.36 F18000
G1 X121.01 Y94.291 Z3.36
G1 Z2.96
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F639
M204 S500
G1 X121.01 Y93.511 E.01534
G1 X126.59 Y93.511 E.10975
G1 X126.59 Y94.291 E.01534
G1 X121.07 Y94.291 E.10857
M204 S10000
G1 X121.215 Y93.901 F18000
; FEATURE: Gap infill
; LINE_WIDTH: 0.396532
G1 F639
M204 S6000
G1 X126.385 Y93.901 E.09565
; OBJECT_ID: 8
; WIPE_START
G1 F1500
G1 X124.385 Y93.901 E-.38
; WIPE_END
G1 E-.02 F1800
; stop printing object, unique label id: 12
M625
; start printing object, unique label id: 8
M624 AQAAAAAAAAA=
M204 S10000
G1 X117.28 Y91.114 Z3.36 F18000
G1 X56.457 Y67.257 Z3.36
G1 Z2.96
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F639
M204 S500
G1 X55.943 Y67.257 E.01086
G1 X55.943 Y66.744 E.01086
G1 X56.457 Y66.744 E.01086
G1 X56.457 Y67.197 E.00959
M204 S10000
G1 X56.881 Y67.682 F18000
G1 F639
M204 S500
G1 X55.519 Y67.682 E.02882
G1 X55.519 Y66.32 E.02882
G1 X56.881 Y66.32 E.02882
G1 X56.881 Y67.622 E.02755
M204 S250
G1 X57.29 Y68.091 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F639
M204 S500
G1 X55.11 Y68.091 E.04288
G1 X55.11 Y65.911 E.04288
G1 X57.29 Y65.911 E.04288
G1 X57.29 Y68.031 E.0417
; CHANGE_LAYER
; Z_HEIGHT: 3.056
; LAYER_HEIGHT: 0.096
; WIPE_START
G1 F1500
M204 S6000
G1 X55.291 Y68.086 E-.38
; WIPE_END
G1 E-.02 F1800
; stop printing object, unique label id: 8
M625
; layer num/total_layer_count: 28/51
; update layer progress
M73 L28
M991 S0 P27 ;notify layer change
; OBJECT_ID: 12
; start printing object, unique label id: 12
M624 AgAAAAAAAAA=
M204 S10000
G17
G3 Z3.36 I-.464 J1.125 P1  F18000
G1 X124.892 Y96.79 Z3.36
G1 Z3.056
G1 E.4 F1800
; FEATURE: Support
; LAYER_HEIGHT: 0.264
G1 F1036
M204 S6000
G1 X125.099 Y96.584 E.01166
G1 X126.603 Y96.584 E.05998
G1 X126.603 Y97.106 E.02083
G1 X120.997 Y97.106 E.22357
G1 X120.997 Y98.818 E.06828
G1 X122.502 Y98.818 E.06001
G1 X122.709 Y98.61 E.0117
G1 X123.146 Y98.429 E.01885
G1 X124.455 Y98.429 E.05219
G1 X124.891 Y98.61 E.01885
G1 X125.099 Y98.818 E.01172
G1 X126.603 Y98.818 E.05998
G1 X126.603 Y97.303 E.06042
; WIPE_START
G1 F1251.002
G1 X126.603 Y98.818 E-.28788
G1 X126.118 Y98.818 E-.09212
; WIPE_END
G1 E-.02 F1800
M204 S10000
G17
G3 Z3.456 I1.217 J0 P1  F18000
; stop printing object, unique label id: 12
M625
; object ids of layer 28 start: 12
M624 AgAAAAAAAAA=
;===================== date: 20250206 =====================

; don't support timelapse gcode in spiral_mode and by object sequence for I3 structure printer
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
G92 E0
G1 Z3.456
G1 X0 Y85.35 ; move to safe pos
G1 X-13.0 F3000 ; move to safe pos
M400
M1004 S5 P1  ; external shutter
M400 P300
M971 S11 C11 O0
G92 E0
G1 X0 F18000
M623

; SKIPTYPE: head_wrap_detect
M622.1 S1
M1002 judge_flag g39_3rd_layer_detect_flag
M622 J1
    ; enable nozzle clog detect at 3rd layer
    


    M622.1 S1
    M1002 judge_flag g39_detection_flag
    M622 J1
      
        M622.1 S0
        M1002 judge_flag g39_mass_exceed_flag
        M622 J1
        
            G392 S0
            M400
            G90
            M83
            M204 S5000
            G0 Z3.456 F4000
            G39.3 S1
            G0 Z3.456 F4000
            G392 S0
          
        M623
    
    M623
M623
; SKIPPABLE_END




; object ids of this layer28 end: 12
M625
; CHANGE_LAYER
; Z_HEIGHT: 3.08
; LAYER_HEIGHT: 0.0239999
; layer num/total_layer_count: 29/51
; update layer progress
M73 L29
M991 S0 P28 ;notify layer change
; OBJECT_ID: 12
; start printing object, unique label id: 12
M624 AgAAAAAAAAA=
G1 X55.948 Y97.952
G1 Z3.08
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
; LAYER_HEIGHT: 0.12
G1 F1036
M204 S500
G1 X55.948 Y97.449 E.01065
G1 X56.452 Y97.449 E.01065
G1 X56.452 Y97.952 E.01065
G1 X56.008 Y97.952 E.00938
M204 S250
G1 X55.539 Y98.362 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1036
M204 S500
G1 X55.539 Y97.04 E.026
G1 X56.861 Y97.04 E.026
G1 X56.861 Y98.362 E.026
G1 X55.599 Y98.362 E.02482
; WIPE_START
G1 F1500
M204 S6000
G1 X55.539 Y97.04 E-.2514
G1 X56.216 Y97.04 E-.1286
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X63.833 Y97.518 Z3.48 F18000
G1 X121.01 Y101.111 Z3.48
G1 Z3.08
G1 E.4 F1800
G1 F1036
M204 S500
G1 X126.59 Y101.111 E.10975
G1 X126.59 Y101.891 E.01534
G1 X121.01 Y101.891 E.10975
G1 X121.01 Y101.171 E.01416
; WIPE_START
G1 F1500
M204 S6000
G1 X123.01 Y101.149 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G17
G3 Z3.48 I1.217 J0 P1  F18000
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
G1 Z3.48
G1 X0 Y85.35 ; move to safe pos
G1 X-13.0 F3000 ; move to safe pos
M400
M1004 S5 P1  ; external shutter
M400 P300
M971 S11 C11 O0
G92 E0
G1 X0 F18000
M623

; SKIPTYPE: head_wrap_detect
M622.1 S1
M1002 judge_flag g39_3rd_layer_detect_flag
M622 J1
    ; enable nozzle clog detect at 3rd layer
    


    M622.1 S1
    M1002 judge_flag g39_detection_flag
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




; object ids of this layer29 end: 8,12
M625
; start printing object, unique label id: 12
M624 AgAAAAAAAAA=
G1 X121.215 Y101.501
G1 Z3.08
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.396522
G1 F1036
M204 S6000
G1 X126.385 Y101.501 E.09565
; WIPE_START
G1 F1500
G1 X124.385 Y101.501 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X121.149 Y94.588 Z3.48 F18000
G1 X121.01 Y94.291 Z3.48
G1 Z3.08
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1036
M204 S500
G1 X121.01 Y93.511 E.01534
G1 X126.59 Y93.511 E.10975
G1 X126.59 Y94.291 E.01534
G1 X121.07 Y94.291 E.10857
M204 S10000
G1 X121.215 Y93.901 F18000
; FEATURE: Gap infill
; LINE_WIDTH: 0.396532
G1 F1036
M204 S6000
G1 X126.385 Y93.901 E.09565
; OBJECT_ID: 8
; WIPE_START
G1 F1500
G1 X124.385 Y93.901 E-.38
; WIPE_END
G1 E-.02 F1800
; stop printing object, unique label id: 12
M625
; start printing object, unique label id: 8
M624 AQAAAAAAAAA=
M204 S10000
G1 X117.28 Y91.114 Z3.48 F18000
G1 X56.457 Y67.257 Z3.48
G1 Z3.08
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1036
M204 S500
G1 X55.943 Y67.257 E.01086
G1 X55.943 Y66.744 E.01086
G1 X56.457 Y66.744 E.01086
G1 X56.457 Y67.197 E.00959
M204 S10000
G1 X56.881 Y67.682 F18000
G1 F1036
M204 S500
G1 X55.519 Y67.682 E.02882
G1 X55.519 Y66.32 E.02882
G1 X56.881 Y66.32 E.02882
G1 X56.881 Y67.622 E.02755
M204 S250
G1 X57.29 Y68.091 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1036
M204 S500
G1 X55.11 Y68.091 E.04288
G1 X55.11 Y65.911 E.04288
G1 X57.29 Y65.911 E.04288
G1 X57.29 Y68.031 E.0417
; CHANGE_LAYER
; Z_HEIGHT: 3.2
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F1500
M204 S6000
G1 X55.291 Y68.086 E-.38
; WIPE_END
G1 E-.02 F1800
; stop printing object, unique label id: 8
M625
; layer num/total_layer_count: 30/51
; update layer progress
M73 L30
M991 S0 P29 ;notify layer change
; OBJECT_ID: 12
; start printing object, unique label id: 12
M624 AgAAAAAAAAA=
M204 S10000
G17
G3 Z3.48 I-1.217 J.027 P1  F18000
G1 X55.959 Y97.942 Z3.48
G1 Z3.2
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F635
M204 S500
G1 X55.959 Y97.46 E.01019
G1 X56.441 Y97.46 E.01019
G1 X56.441 Y97.942 E.01019
G1 X56.019 Y97.942 E.00892
M204 S250
G1 X55.55 Y98.351 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F635
M204 S500
G1 X55.55 Y97.051 E.02557
G1 X56.85 Y97.051 E.02557
G1 X56.85 Y98.351 E.02557
G1 X55.61 Y98.351 E.02439
; WIPE_START
G1 F1500
M204 S6000
G1 X55.55 Y97.051 E-.24726
G1 X56.249 Y97.051 E-.13274
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X63.866 Y97.528 Z3.6 F18000
G1 X121.01 Y101.111 Z3.6
G1 Z3.2
G1 E.4 F1800
G1 F635
M204 S500
G1 X126.59 Y101.111 E.10975
G1 X126.59 Y101.891 E.01534
G1 X121.01 Y101.891 E.10975
G1 X121.01 Y101.171 E.01416
; WIPE_START
G1 F1500
M204 S6000
G1 X123.01 Y101.149 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G17
G3 Z3.6 I1.217 J0 P1  F18000
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
G1 Z3.6
G1 X0 Y85.35 ; move to safe pos
G1 X-13.0 F3000 ; move to safe pos
M400
M1004 S5 P1  ; external shutter
M400 P300
M971 S11 C11 O0
G92 E0
G1 X0 F18000
M623

; SKIPTYPE: head_wrap_detect
M622.1 S1
M1002 judge_flag g39_3rd_layer_detect_flag
M622 J1
    ; enable nozzle clog detect at 3rd layer
    


    M622.1 S1
    M1002 judge_flag g39_detection_flag
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




; object ids of this layer30 end: 8,12
M625
; start printing object, unique label id: 12
M624 AgAAAAAAAAA=
G1 X121.215 Y101.501
G1 Z3.2
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.396522
G1 F635
M204 S6000
M73 P90 R3
G1 X126.385 Y101.501 E.09565
; WIPE_START
G1 F1500
G1 X124.385 Y101.501 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X121.149 Y94.588 Z3.6 F18000
G1 X121.01 Y94.291 Z3.6
G1 Z3.2
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F635
M204 S500
G1 X121.01 Y93.511 E.01534
G1 X126.59 Y93.511 E.10975
G1 X126.59 Y94.291 E.01534
G1 X121.07 Y94.291 E.10857
M204 S10000
G1 X121.215 Y93.901 F18000
; FEATURE: Gap infill
; LINE_WIDTH: 0.396532
G1 F635
M204 S6000
G1 X126.385 Y93.901 E.09565
; OBJECT_ID: 8
; WIPE_START
G1 F1500
G1 X124.385 Y93.901 E-.38
; WIPE_END
G1 E-.02 F1800
; stop printing object, unique label id: 12
M625
; start printing object, unique label id: 8
M624 AQAAAAAAAAA=
M204 S10000
G1 X117.28 Y91.114 Z3.6 F18000
G1 X56.457 Y67.257 Z3.6
G1 Z3.2
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F635
M204 S500
G1 X55.943 Y67.257 E.01086
G1 X55.943 Y66.744 E.01086
G1 X56.457 Y66.744 E.01086
G1 X56.457 Y67.197 E.00959
M204 S10000
G1 X56.881 Y67.682 F18000
G1 F635
M204 S500
G1 X55.519 Y67.682 E.02882
G1 X55.519 Y66.32 E.02882
G1 X56.881 Y66.32 E.02882
G1 X56.881 Y67.622 E.02755
M204 S250
G1 X57.29 Y68.091 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F635
M204 S500
G1 X55.11 Y68.091 E.04288
G1 X55.11 Y65.911 E.04288
G1 X57.29 Y65.911 E.04288
G1 X57.29 Y68.031 E.0417
; CHANGE_LAYER
; Z_HEIGHT: 3.32
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F1500
M204 S6000
G1 X55.291 Y68.086 E-.38
; WIPE_END
G1 E-.02 F1800
; stop printing object, unique label id: 8
M625
; layer num/total_layer_count: 31/51
; update layer progress
M73 L31
M991 S0 P30 ;notify layer change
; OBJECT_ID: 12
; start printing object, unique label id: 12
M624 AgAAAAAAAAA=
M204 S10000
G17
G3 Z3.6 I-.464 J1.125 P1  F18000
G1 X124.892 Y96.79 Z3.6
G1 Z3.32
G1 E.4 F1800
; FEATURE: Support
; LAYER_HEIGHT: 0.264
G1 F892
M204 S6000
G1 X125.099 Y96.584 E.01166
G1 X126.603 Y96.584 E.05998
G1 X126.603 Y97.106 E.02083
G1 X120.997 Y97.106 E.22357
G1 X120.997 Y98.818 E.06829
G1 X122.502 Y98.818 E.06001
G1 X122.709 Y98.61 E.0117
G1 X123.146 Y98.429 E.01885
G1 X124.455 Y98.429 E.05219
G1 X124.891 Y98.61 E.01885
G1 X125.099 Y98.818 E.01172
G1 X126.603 Y98.818 E.05998
G1 X126.603 Y97.303 E.06042
; WIPE_START
G1 F1251.002
G1 X126.603 Y98.818 E-.28788
G1 X126.118 Y98.818 E-.09212
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X118.486 Y98.722 Z3.72 F18000
G1 X55.97 Y97.931 Z3.72
G1 Z3.32
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
; LAYER_HEIGHT: 0.12
G1 F892
M204 S500
G1 X55.97 Y97.471 E.00973
G1 X56.43 Y97.471 E.00973
G1 X56.43 Y97.931 E.00973
G1 X56.03 Y97.931 E.00846
M204 S250
G1 X55.561 Y98.34 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F892
M204 S500
G1 X55.561 Y97.062 E.02514
G1 X56.839 Y97.062 E.02514
G1 X56.839 Y98.34 E.02514
G1 X55.621 Y98.34 E.02396
; WIPE_START
G1 F1500
M204 S6000
G1 X55.561 Y97.062 E-.24313
G1 X56.281 Y97.062 E-.13688
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X63.899 Y97.538 Z3.72 F18000
G1 X121.01 Y101.111 Z3.72
G1 Z3.32
G1 E.4 F1800
G1 F892
M204 S500
G1 X126.59 Y101.111 E.10975
G1 X126.59 Y101.891 E.01534
G1 X121.01 Y101.891 E.10975
G1 X121.01 Y101.171 E.01416
; WIPE_START
G1 F1500
M204 S6000
G1 X123.01 Y101.149 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G17
G3 Z3.72 I1.217 J0 P1  F18000
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
G1 Z3.72
G1 X0 Y85.35 ; move to safe pos
G1 X-13.0 F3000 ; move to safe pos
M400
M1004 S5 P1  ; external shutter
M400 P300
M971 S11 C11 O0
G92 E0
G1 X0 F18000
M623

; SKIPTYPE: head_wrap_detect
M622.1 S1
M1002 judge_flag g39_3rd_layer_detect_flag
M622 J1
    ; enable nozzle clog detect at 3rd layer
    


    M622.1 S1
    M1002 judge_flag g39_detection_flag
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




; object ids of this layer31 end: 8,12
M625
; start printing object, unique label id: 12
M624 AgAAAAAAAAA=
G1 X121.215 Y101.501
G1 Z3.32
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.396522
G1 F892
M204 S6000
G1 X126.385 Y101.501 E.09565
; WIPE_START
G1 F1500
G1 X124.385 Y101.501 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X121.149 Y94.588 Z3.72 F18000
G1 X121.01 Y94.291 Z3.72
G1 Z3.32
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F892
M204 S500
G1 X121.01 Y93.511 E.01534
G1 X126.59 Y93.511 E.10975
G1 X126.59 Y94.291 E.01534
G1 X121.07 Y94.291 E.10857
M204 S10000
G1 X121.215 Y93.901 F18000
; FEATURE: Gap infill
; LINE_WIDTH: 0.396532
G1 F892
M204 S6000
G1 X126.385 Y93.901 E.09565
; OBJECT_ID: 8
; WIPE_START
G1 F1500
G1 X124.385 Y93.901 E-.38
; WIPE_END
G1 E-.02 F1800
; stop printing object, unique label id: 12
M625
; start printing object, unique label id: 8
M624 AQAAAAAAAAA=
M204 S10000
G1 X117.28 Y91.114 Z3.72 F18000
G1 X56.457 Y67.257 Z3.72
G1 Z3.32
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F892
M204 S500
G1 X55.943 Y67.257 E.01086
G1 X55.943 Y66.744 E.01086
G1 X56.457 Y66.744 E.01086
G1 X56.457 Y67.197 E.00959
M204 S10000
G1 X56.881 Y67.682 F18000
G1 F892
M204 S500
G1 X55.519 Y67.682 E.02882
G1 X55.519 Y66.32 E.02882
G1 X56.881 Y66.32 E.02882
G1 X56.881 Y67.622 E.02755
M204 S250
G1 X57.29 Y68.091 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F892
M204 S500
G1 X55.11 Y68.091 E.04288
G1 X55.11 Y65.911 E.04288
G1 X57.29 Y65.911 E.04288
G1 X57.29 Y68.031 E.0417
; CHANGE_LAYER
; Z_HEIGHT: 3.44
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F1500
M204 S6000
G1 X55.291 Y68.086 E-.38
; WIPE_END
G1 E-.02 F1800
; stop printing object, unique label id: 8
M625
; layer num/total_layer_count: 32/51
; update layer progress
M73 L32
M991 S0 P31 ;notify layer change
; OBJECT_ID: 12
; start printing object, unique label id: 12
M624 AgAAAAAAAAA=
M204 S10000
G17
G3 Z3.72 I-1.217 J.028 P1  F18000
G1 X55.981 Y97.92 Z3.72
G1 Z3.44
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F631
M204 S500
G1 X55.981 Y97.482 E.00927
G1 X56.419 Y97.482 E.00927
G1 X56.419 Y97.92 E.00927
G1 X56.041 Y97.92 E.008
M204 S250
G1 X55.572 Y98.329 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F631
M204 S500
G1 X55.572 Y97.073 E.02471
G1 X56.828 Y97.073 E.02471
G1 X56.828 Y98.329 E.02471
G1 X55.632 Y98.329 E.02353
; WIPE_START
G1 F1500
M204 S6000
G1 X55.572 Y97.073 E-.23898
G1 X56.314 Y97.073 E-.14102
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X63.932 Y97.548 Z3.84 F18000
G1 X121.01 Y101.111 Z3.84
G1 Z3.44
G1 E.4 F1800
G1 F631
M204 S500
G1 X126.59 Y101.111 E.10975
G1 X126.59 Y101.891 E.01534
G1 X121.01 Y101.891 E.10975
G1 X121.01 Y101.171 E.01416
; WIPE_START
G1 F1500
M204 S6000
G1 X123.01 Y101.149 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G17
G3 Z3.84 I1.217 J0 P1  F18000
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
G1 Z3.84
G1 X0 Y85.35 ; move to safe pos
G1 X-13.0 F3000 ; move to safe pos
M400
M1004 S5 P1  ; external shutter
M400 P300
M971 S11 C11 O0
G92 E0
G1 X0 F18000
M623

; SKIPTYPE: head_wrap_detect
M622.1 S1
M1002 judge_flag g39_3rd_layer_detect_flag
M622 J1
    ; enable nozzle clog detect at 3rd layer
    


    M622.1 S1
    M1002 judge_flag g39_detection_flag
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




; object ids of this layer32 end: 8,12
M625
; start printing object, unique label id: 12
M624 AgAAAAAAAAA=
G1 X121.215 Y101.501
G1 Z3.44
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.396522
G1 F631
M204 S6000
G1 X126.385 Y101.501 E.09565
; WIPE_START
G1 F1500
G1 X124.385 Y101.501 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X121.149 Y94.588 Z3.84 F18000
G1 X121.01 Y94.291 Z3.84
G1 Z3.44
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F631
M204 S500
G1 X121.01 Y93.511 E.01534
G1 X126.59 Y93.511 E.10975
G1 X126.59 Y94.291 E.01534
G1 X121.07 Y94.291 E.10857
M204 S10000
G1 X121.215 Y93.901 F18000
; FEATURE: Gap infill
; LINE_WIDTH: 0.396532
G1 F631
M204 S6000
G1 X126.385 Y93.901 E.09565
; OBJECT_ID: 8
; WIPE_START
G1 F1500
G1 X124.385 Y93.901 E-.38
; WIPE_END
M73 P91 R3
G1 E-.02 F1800
; stop printing object, unique label id: 12
M625
; start printing object, unique label id: 8
M624 AQAAAAAAAAA=
M204 S10000
G1 X117.28 Y91.114 Z3.84 F18000
G1 X56.457 Y67.257 Z3.84
G1 Z3.44
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F631
M204 S500
G1 X55.943 Y67.257 E.01086
G1 X55.943 Y66.744 E.01086
G1 X56.457 Y66.744 E.01086
G1 X56.457 Y67.197 E.00959
M204 S10000
G1 X56.881 Y67.682 F18000
G1 F631
M204 S500
G1 X55.519 Y67.682 E.02882
G1 X55.519 Y66.32 E.02882
G1 X56.881 Y66.32 E.02882
G1 X56.881 Y67.622 E.02755
M204 S250
G1 X57.29 Y68.091 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F631
M204 S500
G1 X55.11 Y68.091 E.04288
G1 X55.11 Y65.911 E.04288
G1 X57.29 Y65.911 E.04288
G1 X57.29 Y68.031 E.0417
; CHANGE_LAYER
; Z_HEIGHT: 3.56
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F1500
M204 S6000
G1 X55.291 Y68.086 E-.38
; WIPE_END
G1 E-.02 F1800
; stop printing object, unique label id: 8
M625
; layer num/total_layer_count: 33/51
; update layer progress
M73 L33
M991 S0 P32 ;notify layer change
; OBJECT_ID: 12
; start printing object, unique label id: 12
M624 AgAAAAAAAAA=
M204 S10000
G17
G3 Z3.84 I-1.217 J.029 P1  F18000
G1 X55.992 Y97.909 Z3.84
G1 Z3.56
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F629
M204 S500
G1 X55.992 Y97.493 E.00881
G1 X56.408 Y97.493 E.00881
G1 X56.408 Y97.909 E.00881
G1 X56.052 Y97.909 E.00754
M204 S250
G1 X55.583 Y98.318 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F629
M204 S500
G1 X55.583 Y97.084 E.02428
G1 X56.817 Y97.084 E.02428
G1 X56.817 Y98.318 E.02428
G1 X55.643 Y98.318 E.0231
; WIPE_START
G1 F1500
M204 S6000
G1 X55.583 Y97.084 E-.23484
G1 X56.347 Y97.084 E-.14516
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X63.964 Y97.558 Z3.96 F18000
G1 X121.01 Y101.111 Z3.96
G1 Z3.56
G1 E.4 F1800
G1 F629
M204 S500
G1 X126.59 Y101.111 E.10975
G1 X126.59 Y101.891 E.01534
G1 X121.01 Y101.891 E.10975
G1 X121.01 Y101.171 E.01416
; WIPE_START
G1 F1500
M204 S6000
G1 X123.01 Y101.149 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G17
G3 Z3.96 I1.217 J0 P1  F18000
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
G1 Z3.96
G1 X0 Y85.35 ; move to safe pos
G1 X-13.0 F3000 ; move to safe pos
M400
M1004 S5 P1  ; external shutter
M400 P300
M971 S11 C11 O0
G92 E0
G1 X0 F18000
M623

; SKIPTYPE: head_wrap_detect
M622.1 S1
M1002 judge_flag g39_3rd_layer_detect_flag
M622 J1
    ; enable nozzle clog detect at 3rd layer
    


    M622.1 S1
    M1002 judge_flag g39_detection_flag
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




; object ids of this layer33 end: 8,12
M625
; start printing object, unique label id: 12
M624 AgAAAAAAAAA=
G1 X121.215 Y101.501
G1 Z3.56
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.396532
G1 F629
M204 S6000
G1 X126.385 Y101.501 E.09565
; WIPE_START
G1 F1500
G1 X124.385 Y101.501 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X121.149 Y94.588 Z3.96 F18000
G1 X121.01 Y94.291 Z3.96
G1 Z3.56
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F629
M204 S500
G1 X121.01 Y93.511 E.01534
G1 X126.59 Y93.511 E.10975
G1 X126.59 Y94.291 E.01534
G1 X121.07 Y94.291 E.10857
M204 S10000
G1 X121.215 Y93.901 F18000
; FEATURE: Gap infill
; LINE_WIDTH: 0.396532
G1 F629
M204 S6000
G1 X126.385 Y93.901 E.09565
; OBJECT_ID: 8
; WIPE_START
G1 F1500
G1 X124.385 Y93.901 E-.38
; WIPE_END
G1 E-.02 F1800
; stop printing object, unique label id: 12
M625
; start printing object, unique label id: 8
M624 AQAAAAAAAAA=
M204 S10000
G1 X117.28 Y91.114 Z3.96 F18000
G1 X56.457 Y67.257 Z3.96
G1 Z3.56
M73 P91 R2
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F629
M204 S500
G1 X55.943 Y67.257 E.01086
G1 X55.943 Y66.744 E.01086
G1 X56.457 Y66.744 E.01086
G1 X56.457 Y67.197 E.00959
M204 S10000
G1 X56.881 Y67.682 F18000
G1 F629
M204 S500
G1 X55.519 Y67.682 E.02882
G1 X55.519 Y66.32 E.02882
G1 X56.881 Y66.32 E.02882
G1 X56.881 Y67.622 E.02755
M204 S250
G1 X57.29 Y68.091 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F629
M204 S500
G1 X55.11 Y68.091 E.04288
G1 X55.11 Y65.911 E.04288
G1 X57.29 Y65.911 E.04288
G1 X57.29 Y68.031 E.0417
; CHANGE_LAYER
; Z_HEIGHT: 3.584
; LAYER_HEIGHT: 0.0240002
; WIPE_START
G1 F1500
M204 S6000
G1 X55.291 Y68.086 E-.38
; WIPE_END
G1 E-.02 F1800
; stop printing object, unique label id: 8
M625
; layer num/total_layer_count: 34/51
; update layer progress
M73 L34
M991 S0 P33 ;notify layer change
; OBJECT_ID: 12
; start printing object, unique label id: 12
M624 AgAAAAAAAAA=
M204 S10000
G17
G3 Z3.96 I-.464 J1.125 P1  F18000
G1 X124.892 Y96.79 Z3.96
G1 Z3.584
G1 E.4 F1800
; FEATURE: Support
; LAYER_HEIGHT: 0.264
G1 F1061
M204 S6000
G1 X125.099 Y96.584 E.01166
G1 X126.603 Y96.584 E.05998
G1 X126.603 Y97.106 E.02083
G1 X120.997 Y97.106 E.22357
G1 X120.997 Y98.818 E.06829
G1 X122.502 Y98.818 E.06
G1 X122.709 Y98.61 E.0117
G1 X123.146 Y98.429 E.01885
G1 X124.455 Y98.429 E.05219
G1 X124.891 Y98.61 E.01885
G1 X125.099 Y98.818 E.01172
G1 X126.603 Y98.818 E.05998
G1 X126.603 Y97.303 E.06042
; WIPE_START
G1 F1251.002
G1 X126.603 Y98.818 E-.28788
G1 X126.118 Y98.818 E-.09212
; WIPE_END
G1 E-.02 F1800
M204 S10000
G17
G3 Z3.984 I1.217 J0 P1  F18000
; stop printing object, unique label id: 12
M625
; object ids of layer 34 start: 12
M624 AgAAAAAAAAA=
;===================== date: 20250206 =====================

; don't support timelapse gcode in spiral_mode and by object sequence for I3 structure printer
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
G92 E0
G1 Z3.984
G1 X0 Y85.35 ; move to safe pos
G1 X-13.0 F3000 ; move to safe pos
M400
M1004 S5 P1  ; external shutter
M400 P300
M971 S11 C11 O0
G92 E0
G1 X0 F18000
M623

; SKIPTYPE: head_wrap_detect
M622.1 S1
M1002 judge_flag g39_3rd_layer_detect_flag
M622 J1
    ; enable nozzle clog detect at 3rd layer
    


    M622.1 S1
    M1002 judge_flag g39_detection_flag
    M622 J1
      
        M622.1 S0
        M1002 judge_flag g39_mass_exceed_flag
        M622 J1
        
            G392 S0
            M400
            G90
            M83
            M204 S5000
            G0 Z3.984 F4000
            G39.3 S1
            G0 Z3.984 F4000
            G392 S0
          
        M623
    
    M623
M623
; SKIPPABLE_END




; object ids of this layer34 end: 12
M625
; CHANGE_LAYER
; Z_HEIGHT: 3.68
; LAYER_HEIGHT: 0.096
; layer num/total_layer_count: 35/51
; update layer progress
M73 L35
M991 S0 P34 ;notify layer change
; OBJECT_ID: 12
; start printing object, unique label id: 12
M624 AgAAAAAAAAA=
G1 X56.003 Y97.898
G1 Z3.68
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
; LAYER_HEIGHT: 0.12
G1 F1061
M204 S500
G1 X56.003 Y97.504 E.00834
G1 X56.397 Y97.504 E.00834
G1 X56.397 Y97.898 E.00834
G1 X56.063 Y97.898 E.00707
M204 S250
G1 X55.594 Y98.307 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1061
M204 S500
G1 X55.594 Y97.094 E.02385
G1 X56.806 Y97.094 E.02385
G1 X56.806 Y98.307 E.02385
G1 X55.654 Y98.307 E.02267
; WIPE_START
G1 F1500
M204 S6000
G1 X55.594 Y97.094 E-.2307
G1 X56.379 Y97.094 E-.1493
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X63.997 Y97.563 Z4.08 F18000
G1 X121.01 Y101.07 Z4.08
G1 Z3.68
G1 E.4 F1800
G1 F1061
M204 S500
G1 X121.01 Y100.939 E.00257
G1 X126.59 Y100.939 E.10975
G1 X126.59 Y101.07 E.00257
G1 X126.59 Y101.891 E.01615
G1 X121.01 Y101.891 E.10975
G1 X121.01 Y101.13 E.01497
; WIPE_START
G1 F1500
M204 S6000
G1 X121.01 Y100.939 E-.03618
G1 X122.82 Y100.939 E-.34382
; WIPE_END
G1 E-.02 F1800
M204 S10000
G17
G3 Z4.08 I1.217 J0 P1  F18000
; stop printing object, unique label id: 12
M625
; object ids of layer 35 start: 8,12
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
G1 X0 Y85.35 ; move to safe pos
G1 X-13.0 F3000 ; move to safe pos
M400
M1004 S5 P1  ; external shutter
M400 P300
M971 S11 C11 O0
G92 E0
G1 X0 F18000
M623

; SKIPTYPE: head_wrap_detect
M622.1 S1
M1002 judge_flag g39_3rd_layer_detect_flag
M622 J1
    ; enable nozzle clog detect at 3rd layer
    


    M622.1 S1
    M1002 judge_flag g39_detection_flag
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




; object ids of this layer35 end: 8,12
M625
; start printing object, unique label id: 12
M624 AgAAAAAAAAA=
G1 X121.215 Y101.415
G1 Z3.68
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.567952
G1 F1061
M204 S6000
G1 X126.385 Y101.415 E.13987
; WIPE_START
G1 F1500
G1 X124.385 Y101.415 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X121.102 Y94.525 Z4.08 F18000
G1 X121.01 Y94.332 Z4.08
G1 Z3.68
M73 P92 R2
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1061
M204 S500
G1 X121.01 Y93.511 E.01615
G1 X126.59 Y93.511 E.10975
G1 X126.59 Y94.332 E.01615
G1 X126.59 Y94.462 E.00257
G1 X121.01 Y94.462 E.10975
G1 X121.01 Y94.392 E.00139
M204 S10000
G1 X121.215 Y93.986 F18000
; FEATURE: Gap infill
; LINE_WIDTH: 0.567952
G1 F1061
M204 S6000
G1 X126.385 Y93.986 E.13987
; OBJECT_ID: 8
; WIPE_START
G1 F1500
G1 X124.385 Y93.986 E-.38
; WIPE_END
G1 E-.02 F1800
; stop printing object, unique label id: 12
M625
; start printing object, unique label id: 8
M624 AQAAAAAAAAA=
M204 S10000
G1 X117.281 Y91.196 Z4.08 F18000
G1 X56.537 Y67.337 Z4.08
G1 Z3.68
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1061
M204 S500
G1 X55.863 Y67.337 E.01425
G1 X55.863 Y66.664 E.01425
G1 X56.537 Y66.664 E.01425
G1 X56.537 Y67.277 E.01298
M204 S10000
G1 X56.961 Y67.762 F18000
G1 F1061
M204 S500
G1 X55.439 Y67.762 E.0322
G1 X55.439 Y66.24 E.0322
G1 X56.961 Y66.24 E.0322
G1 X56.961 Y67.702 E.03093
M204 S250
G1 X57.37 Y68.171 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1061
M204 S500
G1 X55.03 Y68.171 E.04603
G1 X55.03 Y65.831 E.04603
G1 X57.37 Y65.831 E.04603
G1 X57.37 Y68.111 E.04485
; CHANGE_LAYER
; Z_HEIGHT: 3.8
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F2536.476
M204 S6000
G1 X55.371 Y68.162 E-.38
; WIPE_END
G1 E-.02 F1800
; stop printing object, unique label id: 8
M625
; layer num/total_layer_count: 36/51
; update layer progress
M73 L36
M991 S0 P35 ;notify layer change
; OBJECT_ID: 12
; start printing object, unique label id: 12
M624 AgAAAAAAAAA=
M204 S10000
G17
G3 Z4.08 I-1.217 J.009 P1  F18000
G1 X55.605 Y98.296 Z4.08
G1 Z3.8
G1 E.4 F1800
G1 F715
M204 S500
G1 X55.605 Y97.105 E.02342
G1 X56.795 Y97.105 E.02342
G1 X56.795 Y98.296 E.02342
G1 X55.665 Y98.296 E.02224
; WIPE_START
G1 F1500
M204 S6000
G1 X55.605 Y97.105 E-.22656
G1 X56.412 Y97.105 E-.15344
; WIPE_END
G1 E-.02 F1800
M204 S10000
G17
G3 Z4.2 I1.217 J0 P1  F18000
; stop printing object, unique label id: 12
M625
; object ids of layer 36 start: 8,12
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
G1 X0 Y85.35 ; move to safe pos
G1 X-13.0 F3000 ; move to safe pos
M400
M1004 S5 P1  ; external shutter
M400 P300
M971 S11 C11 O0
G92 E0
G1 X0 F18000
M623

; SKIPTYPE: head_wrap_detect
M622.1 S1
M1002 judge_flag g39_3rd_layer_detect_flag
M622 J1
    ; enable nozzle clog detect at 3rd layer
    


    M622.1 S1
    M1002 judge_flag g39_detection_flag
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




; object ids of this layer36 end: 8,12
M625
; start printing object, unique label id: 12
M624 AgAAAAAAAAA=
G1 X55.821 Y97.322
G1 Z3.8
G1 E.4 F1800
; FEATURE: Top surface
G1 F715
M204 S2000
G1 X56.578 Y98.079 E.02106
; WIPE_START
G1 F1500
M204 S6000
G1 X55.821 Y97.322 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X63.441 Y97.77 Z4.2 F18000
G1 X121.419 Y101.177 Z4.2
G1 Z3.8
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F715
M204 S500
G1 X126.181 Y101.177 E.10078
G1 X126.181 Y101.482 E.00644
G1 X121.419 Y101.482 E.10078
G1 X121.419 Y101.237 E.00517
M204 S250
G1 X121.01 Y100.898 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F715
M204 S500
G1 X121.01 Y100.768 E.00257
G1 X126.59 Y100.768 E.10975
G1 X126.59 Y100.898 E.00257
G1 X126.59 Y101.891 E.01952
G1 X121.01 Y101.891 E.10975
G1 X121.01 Y100.958 E.01834
; WIPE_START
G1 F1500
M204 S6000
G1 X121.01 Y100.768 E-.03618
G1 X122.82 Y100.768 E-.34382
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X121.419 Y94.224 Z4.2 F18000
G1 Z3.8
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F715
M204 S500
G1 X121.419 Y93.92 E.00644
G1 X126.181 Y93.92 E.10078
G1 X126.181 Y94.224 E.00644
G1 X121.479 Y94.224 E.09951
M204 S250
G1 X121.01 Y94.503 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F715
M204 S500
G1 X121.01 Y93.511 E.01952
G1 X126.59 Y93.511 E.10975
G1 X126.59 Y94.503 E.01952
G1 X126.59 Y94.634 E.00257
G1 X121.01 Y94.634 E.10975
G1 X121.01 Y94.563 E.00139
; OBJECT_ID: 8
; WIPE_START
G1 F1698.374
M204 S6000
G1 X121.01 Y93.511 E-.19996
G1 X121.958 Y93.511 E-.18004
; WIPE_END
G1 E-.02 F1800
; stop printing object, unique label id: 12
M625
; start printing object, unique label id: 8
M624 AQAAAAAAAAA=
M204 S10000
G1 X114.869 Y90.68 Z4.2 F18000
G1 X56.617 Y67.417 Z4.2
G1 Z3.8
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F715
M204 S500
G1 X55.783 Y67.417 E.01763
G1 X55.783 Y66.584 E.01763
G1 X56.617 Y66.584 E.01763
G1 X56.617 Y67.357 E.01636
M204 S10000
G1 X57.041 Y67.842 F18000
G1 F715
M204 S500
G1 X55.359 Y67.842 E.03559
G1 X55.359 Y66.16 E.03559
G1 X57.041 Y66.16 E.03559
G1 X57.041 Y67.782 E.03432
M204 S250
G1 X57.45 Y68.251 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F715
M204 S500
G1 X54.95 Y68.251 E.04917
G1 X54.95 Y65.751 E.04917
G1 X57.45 Y65.751 E.04917
G1 X57.45 Y68.191 E.04799
; CHANGE_LAYER
; Z_HEIGHT: 3.848
; LAYER_HEIGHT: 0.0480001
; WIPE_START
G1 F2536.476
M204 S6000
G1 X55.451 Y68.239 E-.38
; WIPE_END
G1 E-.02 F1800
; stop printing object, unique label id: 8
M625
; layer num/total_layer_count: 37/51
; update layer progress
M73 L37
M991 S0 P36 ;notify layer change
; OBJECT_ID: 12
; start printing object, unique label id: 12
M624 AgAAAAAAAAA=
M204 S10000
G17
G3 Z4.2 I-.463 J1.126 P1  F18000
G1 X124.892 Y96.79 Z4.2
G1 Z3.848
G1 E.4 F1800
; FEATURE: Support
; LAYER_HEIGHT: 0.264
G1 F993
M204 S6000
G1 X125.099 Y96.584 E.01166
G1 X126.603 Y96.584 E.05998
G1 X126.603 Y97.106 E.02083
G1 X120.997 Y97.106 E.22357
G1 X120.997 Y98.818 E.06829
G1 X122.501 Y98.818 E.06
G1 X122.709 Y98.61 E.0117
G1 X123.145 Y98.429 E.01885
G1 X124.454 Y98.429 E.0522
G1 X124.891 Y98.61 E.01885
G1 X125.099 Y98.818 E.01172
G1 X126.603 Y98.818 E.05998
G1 X126.603 Y97.303 E.06042
; WIPE_START
G1 F1251.002
G1 X126.603 Y98.818 E-.28788
G1 X126.118 Y98.818 E-.09212
; WIPE_END
G1 E-.02 F1800
M204 S10000
G17
G3 Z4.248 I1.217 J0 P1  F18000
; stop printing object, unique label id: 12
M625
; object ids of layer 37 start: 12
M624 AgAAAAAAAAA=
;===================== date: 20250206 =====================

; don't support timelapse gcode in spiral_mode and by object sequence for I3 structure printer
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
G92 E0
G1 Z4.248
G1 X0 Y85.35 ; move to safe pos
G1 X-13.0 F3000 ; move to safe pos
M400
M1004 S5 P1  ; external shutter
M400 P300
M971 S11 C11 O0
G92 E0
G1 X0 F18000
M623

; SKIPTYPE: head_wrap_detect
M622.1 S1
M1002 judge_flag g39_3rd_layer_detect_flag
M622 J1
    ; enable nozzle clog detect at 3rd layer
    


    M622.1 S1
    M1002 judge_flag g39_detection_flag
    M622 J1
      
        M622.1 S0
        M1002 judge_flag g39_mass_exceed_flag
        M622 J1
        
            G392 S0
            M400
            G90
            M83
            M204 S5000
            G0 Z4.248 F4000
            G39.3 S1
            G0 Z4.248 F4000
            G392 S0
          
        M623
    
    M623
M623
; SKIPPABLE_END




; object ids of this layer37 end: 12
M625
; CHANGE_LAYER
; Z_HEIGHT: 3.92
; LAYER_HEIGHT: 0.072
; layer num/total_layer_count: 38/51
; update layer progress
M73 L38
M991 S0 P37 ;notify layer change
; OBJECT_ID: 12
; start printing object, unique label id: 12
M624 AgAAAAAAAAA=
G1 X121.419 Y101.006
G1 Z3.92
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
; LAYER_HEIGHT: 0.12
G1 F993
M204 S500
G1 X126.181 Y101.006 E.10078
G1 X126.181 Y101.482 E.01007
G1 X121.419 Y101.482 E.10078
G1 X121.419 Y101.066 E.0088
M204 S250
G1 X121.01 Y100.727 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F993
M204 S500
G1 X121.01 Y100.597 E.00257
G1 X126.59 Y100.597 E.10975
G1 X126.59 Y100.727 E.00257
G1 X126.59 Y101.891 E.02289
G1 X121.01 Y101.891 E.10975
G1 X121.01 Y100.787 E.02171
; WIPE_START
G1 F1500
M204 S6000
G1 X121.01 Y100.597 E-.03618
G1 X122.82 Y100.597 E-.34382
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X121.419 Y94.396 Z4.32 F18000
G1 Z3.92
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F993
M204 S500
G1 X121.419 Y93.92 E.01007
G1 X126.181 Y93.92 E.10078
G1 X126.181 Y94.396 E.01007
G1 X121.479 Y94.396 E.09951
M204 S250
G1 X121.01 Y94.675 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F993
M204 S500
G1 X121.01 Y93.511 E.02289
G1 X126.59 Y93.511 E.10975
G1 X126.59 Y94.675 E.02289
G1 X126.59 Y94.805 E.00257
G1 X121.01 Y94.805 E.10975
G1 X121.01 Y94.735 E.00139
; OBJECT_ID: 8
; WIPE_START
G1 F1698.374
M204 S6000
G1 X121.01 Y93.511 E-.23254
G1 X121.786 Y93.511 E-.14746
; WIPE_END
G1 E-.02 F1800
; stop printing object, unique label id: 12
M625
; start printing object, unique label id: 8
M624 AQAAAAAAAAA=
M204 S10000
G1 X114.699 Y90.678 Z4.32 F18000
G1 X56.697 Y67.497 Z4.32
G1 Z3.92
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F993
M204 S500
G1 X55.703 Y67.497 E.02102
G1 X55.703 Y66.504 E.02102
G1 X56.697 Y66.504 E.02102
G1 X56.697 Y67.437 E.01975
M204 S10000
G1 X57.121 Y67.922 F18000
G1 F993
M204 S500
G1 X55.279 Y67.922 E.03898
G1 X55.279 Y66.08 E.03898
G1 X57.121 Y66.08 E.03898
G1 X57.121 Y67.862 E.03771
M204 S250
G1 X57.53 Y68.331 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F993
M204 S500
G1 X54.87 Y68.331 E.05232
G1 X54.87 Y65.671 E.05232
G1 X57.53 Y65.671 E.05232
G1 X57.53 Y68.271 E.05114
; WIPE_START
M73 P93 R2
G1 F2536.476
M204 S6000
G1 X55.531 Y68.316 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G17
G3 Z4.32 I1.217 J0 P1  F18000
; stop printing object, unique label id: 8
M625
; object ids of layer 38 start: 8,12
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
G1 X0 Y85.35 ; move to safe pos
G1 X-13.0 F3000 ; move to safe pos
M400
M1004 S5 P1  ; external shutter
M400 P300
M971 S11 C11 O0
G92 E0
G1 X0 F18000
M623

; SKIPTYPE: head_wrap_detect
M622.1 S1
M1002 judge_flag g39_3rd_layer_detect_flag
M622 J1
    ; enable nozzle clog detect at 3rd layer
    


    M622.1 S1
    M1002 judge_flag g39_detection_flag
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




; object ids of this layer38 end: 8,12
M625
; CHANGE_LAYER
; Z_HEIGHT: 4.04
; LAYER_HEIGHT: 0.12
; layer num/total_layer_count: 39/51
; update layer progress
M73 L39
M991 S0 P38 ;notify layer change
; OBJECT_ID: 12
; start printing object, unique label id: 12
M624 AgAAAAAAAAA=
G1 X121.419 Y100.834 F18000
G1 Z4.04
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F848
M204 S500
G1 X126.181 Y100.834 E.10078
G1 X126.181 Y101.482 E.0137
G1 X121.419 Y101.482 E.10078
G1 X121.419 Y100.894 E.01243
M204 S250
G1 X121.01 Y100.556 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F848
M204 S500
G1 X121.01 Y100.425 E.00257
G1 X126.59 Y100.425 E.10975
G1 X126.59 Y100.556 E.00257
G1 X126.59 Y101.891 E.02626
G1 X121.01 Y101.891 E.10975
G1 X121.01 Y100.616 E.02508
; WIPE_START
G1 F1500
M204 S6000
G1 X121.01 Y100.425 E-.03618
G1 X122.82 Y100.425 E-.34382
; WIPE_END
G1 E-.02 F1800
M204 S10000
G17
G3 Z4.44 I1.217 J0 P1  F18000
; stop printing object, unique label id: 12
M625
; object ids of layer 39 start: 8,12
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
G1 X0 Y85.35 ; move to safe pos
G1 X-13.0 F3000 ; move to safe pos
M400
M1004 S5 P1  ; external shutter
M400 P300
M971 S11 C11 O0
G92 E0
G1 X0 F18000
M623

; SKIPTYPE: head_wrap_detect
M622.1 S1
M1002 judge_flag g39_3rd_layer_detect_flag
M622 J1
    ; enable nozzle clog detect at 3rd layer
    


    M622.1 S1
    M1002 judge_flag g39_detection_flag
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




; object ids of this layer39 end: 8,12
M625
; start printing object, unique label id: 12
M624 AgAAAAAAAAA=
G1 X121.631 Y101.158
G1 Z4.04
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.248762
G1 F848
M204 S6000
G1 X125.969 Y101.158 E.04826
; WIPE_START
G1 F1500
G1 X123.969 Y101.158 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X121.419 Y94.567 Z4.44 F18000
G1 Z4.04
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F848
M204 S500
G1 X121.419 Y93.92 E.0137
G1 X126.181 Y93.92 E.10078
G1 X126.181 Y94.567 E.0137
G1 X121.479 Y94.567 E.09951
M204 S250
G1 X121.01 Y94.846 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F848
M204 S500
G1 X121.01 Y93.511 E.02626
G1 X126.59 Y93.511 E.10975
G1 X126.59 Y94.846 E.02626
G1 X126.59 Y94.977 E.00257
G1 X121.01 Y94.977 E.10975
G1 X121.01 Y94.906 E.00139
M204 S10000
G1 X121.631 Y94.244 F18000
; FEATURE: Gap infill
; LINE_WIDTH: 0.248762
G1 F848
M204 S6000
G1 X125.969 Y94.244 E.04826
; OBJECT_ID: 8
; WIPE_START
G1 F1500
G1 X123.969 Y94.244 E-.38
; WIPE_END
G1 E-.02 F1800
; stop printing object, unique label id: 12
M625
; start printing object, unique label id: 8
M624 AQAAAAAAAAA=
M204 S10000
G1 X116.875 Y91.426 Z4.44 F18000
G1 X56.73 Y67.531 Z4.44
G1 Z4.04
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F848
M204 S500
G1 X55.67 Y67.531 E.02243
G1 X55.67 Y66.471 E.02243
G1 X56.73 Y66.471 E.02243
G1 X56.73 Y67.471 E.02116
M204 S10000
G1 X57.154 Y67.955 F18000
G1 F848
M204 S500
G1 X55.246 Y67.955 E.04039
G1 X55.246 Y66.047 E.04039
G1 X57.154 Y66.047 E.04039
G1 X57.154 Y67.895 E.03912
M204 S250
G1 X57.563 Y68.364 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F848
M204 S500
G1 X54.837 Y68.364 E.05363
G1 X54.837 Y65.637 E.05363
G1 X57.563 Y65.637 E.05363
G1 X57.563 Y68.304 E.05245
; CHANGE_LAYER
; Z_HEIGHT: 4.112
; LAYER_HEIGHT: 0.072
; WIPE_START
G1 F1500
M204 S6000
G1 X55.564 Y68.348 E-.38
; WIPE_END
G1 E-.02 F1800
; stop printing object, unique label id: 8
M625
; layer num/total_layer_count: 40/51
; update layer progress
M73 L40
M991 S0 P39 ;notify layer change
; OBJECT_ID: 12
; start printing object, unique label id: 12
M624 AgAAAAAAAAA=
M204 S10000
G17
G3 Z4.44 I-.49 J1.114 P1  F18000
G1 X120.997 Y97.161 Z4.44
G1 Z4.112
G1 E.4 F1800
; FEATURE: Support transition
; LAYER_HEIGHT: 0.264
G1 F1251.002
M204 S6000
G1 X120.997 Y96.583 E.02303
G1 X121.298 Y96.583 E.01202
G1 X121.298 Y98.818 E.08912
G1 X122.193 Y98.818 E.03566
G1 X122.193 Y96.583 E.08912
G1 X122.501 Y96.583 E.0123
G1 X122.709 Y96.791 E.01173
G1 X123.087 Y96.948 E.01631
G1 X123.087 Y98.454 E.06006
G1 X123.145 Y98.43 E.00252
G1 X123.981 Y98.429 E.03333
G1 X123.981 Y96.972 E.05812
G1 X124.455 Y96.972 E.0189
G1 X124.875 Y96.798 E.01815
G1 X124.875 Y98.604 E.07203
G1 X125.099 Y98.818 E.01235
G1 X125.77 Y98.818 E.02675
G1 X125.77 Y96.583 E.08912
G1 X126.603 Y96.583 E.03324
G1 X126.603 Y98.818 E.08912
G1 X125.967 Y98.818 E.02538
; WIPE_START
G1 X126.603 Y98.818 E-.12091
G1 X126.603 Y97.455 E-.25909
; WIPE_END
G1 E-.02 F1800
M204 S10000
G17
G3 Z4.512 I1.217 J0 P1  F18000
; stop printing object, unique label id: 12
M625
; object ids of layer 40 start: 12
M624 AgAAAAAAAAA=
;===================== date: 20250206 =====================

; don't support timelapse gcode in spiral_mode and by object sequence for I3 structure printer
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
G92 E0
G1 Z4.512
G1 X0 Y85.35 ; move to safe pos
G1 X-13.0 F3000 ; move to safe pos
M400
M1004 S5 P1  ; external shutter
M400 P300
M971 S11 C11 O0
G92 E0
G1 X0 F18000
M623

; SKIPTYPE: head_wrap_detect
M622.1 S1
M1002 judge_flag g39_3rd_layer_detect_flag
M622 J1
    ; enable nozzle clog detect at 3rd layer
    


    M622.1 S1
    M1002 judge_flag g39_detection_flag
    M622 J1
      
        M622.1 S0
        M1002 judge_flag g39_mass_exceed_flag
        M622 J1
        
            G392 S0
            M400
            G90
            M83
            M204 S5000
            G0 Z4.512 F4000
            G39.3 S1
            G0 Z4.512 F4000
            G392 S0
          
        M623
    
    M623
M623
; SKIPPABLE_END




; object ids of this layer40 end: 12
M625
; CHANGE_LAYER
; Z_HEIGHT: 4.16
; LAYER_HEIGHT: 0.0479999
; layer num/total_layer_count: 41/51
; update layer progress
M73 L41
M991 S0 P40 ;notify layer change
; OBJECT_ID: 12
; start printing object, unique label id: 12
M624 AgAAAAAAAAA=
G1 X121.419 Y100.663
G1 Z4.16
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
; LAYER_HEIGHT: 0.12
G1 F1352
M204 S500
G1 X126.181 Y100.663 E.10078
G1 X126.181 Y101.482 E.01733
G1 X121.419 Y101.482 E.10078
G1 X121.419 Y100.723 E.01606
M204 S250
G1 X121.01 Y100.384 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1352
M204 S500
G1 X121.01 Y100.254 E.00257
G1 F1320
G1 X126.59 Y100.254 E.10975
G1 F1352
G1 X126.59 Y100.384 E.00257
G1 X126.59 Y101.891 E.02964
G1 X121.01 Y101.891 E.10975
G1 X121.01 Y100.444 E.02846
; WIPE_START
G1 F1500
M204 S6000
G1 X121.01 Y100.254 E-.03618
G1 X122.82 Y100.254 E-.34382
; WIPE_END
G1 E-.02 F1800
M204 S10000
G17
G3 Z4.56 I1.217 J0 P1  F18000
; stop printing object, unique label id: 12
M625
; object ids of layer 41 start: 8,12
M624 AwAAAAAAAAA=
;===================== date: 20250206 =====================

; don't support timelapse gcode in spiral_mode and by object sequence for I3 structure printer
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
G92 E0
G1 Z4.56
G1 X0 Y85.35 ; move to safe pos
G1 X-13.0 F3000 ; move to safe pos
M400
M1004 S5 P1  ; external shutter
M400 P300
M971 S11 C11 O0
G92 E0
G1 X0 F18000
M623

; SKIPTYPE: head_wrap_detect
M622.1 S1
M1002 judge_flag g39_3rd_layer_detect_flag
M622 J1
    ; enable nozzle clog detect at 3rd layer
    


    M622.1 S1
    M1002 judge_flag g39_detection_flag
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




; object ids of this layer41 end: 8,12
M625
; start printing object, unique label id: 12
M624 AgAAAAAAAAA=
G1 X121.631 Y101.072
G1 Z4.16
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.420192
G1 F1352
M204 S6000
G1 X125.969 Y101.072 E.08535
; WIPE_START
G1 F1500
G1 X123.969 Y101.072 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X121.419 Y94.739 Z4.56 F18000
G1 Z4.16
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1352
M204 S500
G1 X121.419 Y93.92 E.01733
G1 X126.181 Y93.92 E.10078
G1 X126.181 Y94.739 E.01733
G1 X121.479 Y94.739 E.09951
M204 S250
G1 X121.01 Y95.018 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1352
M204 S500
G1 X121.01 Y93.511 E.02964
G1 X126.59 Y93.511 E.10975
G1 X126.59 Y95.018 E.02964
G1 X126.59 Y95.148 E.00257
G1 F1320
G1 X121.01 Y95.148 E.10975
G1 F1352
G1 X121.01 Y95.078 E.00139
M204 S10000
G1 X121.631 Y94.329 F18000
; FEATURE: Gap infill
; LINE_WIDTH: 0.420192
G1 F1352
M204 S6000
G1 X125.969 Y94.329 E.08535
; OBJECT_ID: 8
; WIPE_START
G1 F1500
G1 X123.969 Y94.329 E-.38
; WIPE_END
G1 E-.02 F1800
; stop printing object, unique label id: 12
M625
; start printing object, unique label id: 8
M624 AQAAAAAAAAA=
M204 S10000
G1 X116.881 Y91.498 Z4.56 F18000
G1 X56.623 Y67.424 Z4.56
M73 P94 R2
G1 Z4.16
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1352
M204 S500
G1 X55.777 Y67.424 E.01791
G1 X55.777 Y66.578 E.01791
G1 X56.623 Y66.578 E.01791
G1 X56.623 Y67.364 E.01664
M204 S10000
G1 X57.047 Y67.848 F18000
G1 F1352
M204 S500
G1 X55.353 Y67.848 E.03587
G1 X55.353 Y66.153 E.03587
G1 X57.047 Y66.153 E.03587
G1 X57.047 Y67.788 E.0346
M204 S250
G1 X57.457 Y68.257 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1352
M204 S500
G1 X54.943 Y68.257 E.04944
G1 X54.943 Y65.744 E.04944
G1 X57.457 Y65.744 E.04944
G1 X57.457 Y68.197 E.04825
; CHANGE_LAYER
; Z_HEIGHT: 4.28
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F1500
M204 S6000
G1 X55.457 Y68.245 E-.38
; WIPE_END
G1 E-.02 F1800
; stop printing object, unique label id: 8
M625
; layer num/total_layer_count: 42/51
; update layer progress
M73 L42
M991 S0 P41 ;notify layer change
; OBJECT_ID: 12
; start printing object, unique label id: 12
M624 AgAAAAAAAAA=
M204 S10000
G17
G3 Z4.56 I-.534 J1.093 P1  F18000
G1 X121.419 Y100.491 Z4.56
G1 Z4.28
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F833
M204 S500
G1 X126.181 Y100.491 E.10078
G1 X126.181 Y101.482 E.02096
G1 X121.419 Y101.482 E.10078
G1 X121.419 Y100.551 E.01969
M204 S250
G1 X121.01 Y100.213 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F833
M204 S500
G1 X121.01 Y100.082 E.00257
G1 X126.59 Y100.082 E.10975
G1 X126.59 Y100.213 E.00257
G1 X126.59 Y101.891 E.03301
G1 X121.01 Y101.891 E.10975
G1 X121.01 Y100.273 E.03183
; WIPE_START
G1 F1500
M204 S6000
G1 X121.01 Y100.082 E-.03618
G1 X122.82 Y100.082 E-.34382
; WIPE_END
G1 E-.02 F1800
M204 S10000
G17
G3 Z4.68 I1.217 J0 P1  F18000
; stop printing object, unique label id: 12
M625
; object ids of layer 42 start: 8,12
M624 AwAAAAAAAAA=
;===================== date: 20250206 =====================

; don't support timelapse gcode in spiral_mode and by object sequence for I3 structure printer
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
G92 E0
G1 Z4.68
G1 X0 Y85.35 ; move to safe pos
G1 X-13.0 F3000 ; move to safe pos
M400
M1004 S5 P1  ; external shutter
M400 P300
M971 S11 C11 O0
G92 E0
G1 X0 F18000
M623

; SKIPTYPE: head_wrap_detect
M622.1 S1
M1002 judge_flag g39_3rd_layer_detect_flag
M622 J1
    ; enable nozzle clog detect at 3rd layer
    


    M622.1 S1
    M1002 judge_flag g39_detection_flag
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




; object ids of this layer42 end: 8,12
M625
; start printing object, unique label id: 12
M624 AgAAAAAAAAA=
G1 X121.631 Y100.987
G1 Z4.28
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.591622
G1 F833
M204 S6000
G1 X125.969 Y100.987 E.12245
; WIPE_START
G1 F1500
G1 X123.969 Y100.987 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X121.419 Y94.91 Z4.68 F18000
G1 Z4.28
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F833
M204 S500
G1 X121.419 Y93.92 E.02096
G1 X126.181 Y93.92 E.10078
G1 X126.181 Y94.91 E.02096
G1 X121.479 Y94.91 E.09951
M204 S250
M73 P94 R1
G1 X121.01 Y95.189 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F833
M204 S500
G1 X121.01 Y93.511 E.03301
G1 X126.59 Y93.511 E.10975
G1 X126.59 Y95.189 E.03301
G1 X126.59 Y95.319 E.00257
G1 X121.01 Y95.319 E.10975
G1 X121.01 Y95.249 E.00139
; WIPE_START
G1 F1698.374
M204 S6000
G1 X121.01 Y93.511 E-.33025
G1 X121.272 Y93.511 E-.04975
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X121.631 Y94.415 Z4.68 F18000
G1 Z4.28
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.591622
G1 F833
M204 S6000
G1 X125.969 Y94.415 E.12245
; OBJECT_ID: 8
; WIPE_START
G1 F1500
G1 X123.969 Y94.415 E-.38
; WIPE_END
G1 E-.02 F1800
; stop printing object, unique label id: 12
M625
; start printing object, unique label id: 8
M624 AQAAAAAAAAA=
M204 S10000
G1 X116.886 Y91.57 Z4.68 F18000
G1 X56.517 Y67.317 Z4.68
G1 Z4.28
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F833
M204 S500
G1 X55.883 Y67.317 E.0134
G1 X55.883 Y66.684 E.0134
G1 X56.517 Y66.684 E.0134
G1 X56.517 Y67.257 E.01213
M204 S10000
G1 X56.941 Y67.742 F18000
G1 F833
M204 S500
G1 X55.459 Y67.742 E.03136
G1 X55.459 Y66.26 E.03136
G1 X56.941 Y66.26 E.03136
G1 X56.941 Y67.682 E.03009
M204 S250
G1 X57.35 Y68.151 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F833
M204 S500
G1 X55.05 Y68.151 E.04524
G1 X55.05 Y65.851 E.04524
G1 X57.35 Y65.851 E.04524
G1 X57.35 Y68.091 E.04406
; CHANGE_LAYER
; Z_HEIGHT: 4.376
; LAYER_HEIGHT: 0.0959997
; WIPE_START
G1 F1500
M204 S6000
G1 X55.351 Y68.143 E-.38
; WIPE_END
G1 E-.02 F1800
; stop printing object, unique label id: 8
M625
; layer num/total_layer_count: 43/51
; update layer progress
M73 L43
M991 S0 P42 ;notify layer change
; OBJECT_ID: 12
; start printing object, unique label id: 12
M624 AgAAAAAAAAA=
M204 S10000
G17
G3 Z4.68 I-.516 J1.102 P1  F18000
G1 X121.298 Y98.996 Z4.68
G1 Z4.376
G1 E.4 F1800
; FEATURE: Support interface
; LAYER_HEIGHT: 0.264
G1 F1241
M204 S6000
G1 X121.298 Y96.583 E.0962
G1 X122.193 Y96.583 E.03566
G1 X122.193 Y98.818 E.08912
G1 X122.501 Y98.818 E.01231
G1 X122.709 Y98.611 E.0117
G1 X123.087 Y98.454 E.01633
G1 X123.087 Y96.948 E.06006
G1 X123.146 Y96.972 E.00254
G1 X123.981 Y96.972 E.03331
G1 X123.981 Y98.429 E.05812
G1 X124.454 Y98.429 E.01887
G1 X124.875 Y98.604 E.01818
G1 X124.875 Y96.798 E.07203
G1 X125.099 Y96.583 E.01235
G1 X125.77 Y96.583 E.02675
G1 X125.77 Y98.996 E.0962
; WIPE_START
G1 F1251.002
G1 X125.77 Y96.996 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G17
G3 Z4.776 I1.217 J0 P1  F18000
; stop printing object, unique label id: 12
M625
; object ids of layer 43 start: 12
M624 AgAAAAAAAAA=
;===================== date: 20250206 =====================

; don't support timelapse gcode in spiral_mode and by object sequence for I3 structure printer
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
G92 E0
G1 Z4.776
G1 X0 Y85.35 ; move to safe pos
G1 X-13.0 F3000 ; move to safe pos
M400
M1004 S5 P1  ; external shutter
M400 P300
M971 S11 C11 O0
G92 E0
G1 X0 F18000
M623

; SKIPTYPE: head_wrap_detect
M622.1 S1
M1002 judge_flag g39_3rd_layer_detect_flag
M622 J1
    ; enable nozzle clog detect at 3rd layer
    


    M622.1 S1
    M1002 judge_flag g39_detection_flag
    M622 J1
      
        M622.1 S0
        M1002 judge_flag g39_mass_exceed_flag
        M622 J1
        
            G392 S0
            M400
            G90
            M83
            M204 S5000
            G0 Z4.776 F4000
            G39.3 S1
            G0 Z4.776 F4000
            G392 S0
          
        M623
    
    M623
M623
; SKIPPABLE_END




; object ids of this layer43 end: 12
M625
; CHANGE_LAYER
; Z_HEIGHT: 4.4
; LAYER_HEIGHT: 0.0240002
; layer num/total_layer_count: 44/51
; update layer progress
M73 L44
M991 S0 P43 ;notify layer change
; OBJECT_ID: 12
; start printing object, unique label id: 12
M624 AgAAAAAAAAA=
G1 X121.843 Y100.744
G1 Z4.4
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
; LAYER_HEIGHT: 0.12
G1 F1241
M204 S500
G1 X125.757 Y100.744 E.08282
G1 X125.757 Y101.057 E.00663
G1 X121.843 Y101.057 E.08282
G1 X121.843 Y100.804 E.00536
M204 S10000
G1 X121.419 Y100.32 F18000
G1 F1241
M204 S500
G1 X126.181 Y100.32 E.10078
G1 X126.181 Y101.482 E.02459
G1 X121.419 Y101.482 E.10078
G1 X121.419 Y100.38 E.02332
M204 S250
G1 X121.01 Y100.041 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1241
M204 S500
G1 X121.01 Y99.911 E.00257
G1 X126.59 Y99.911 E.10975
G1 X126.59 Y100.041 E.00257
G1 X126.59 Y101.891 E.03638
G1 X121.01 Y101.891 E.10975
G1 X121.01 Y100.101 E.0352
; WIPE_START
G1 F1500
M204 S6000
G1 X121.01 Y99.911 E-.03618
G1 X122.82 Y99.911 E-.34382
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X121.843 Y94.657 Z4.8 F18000
G1 Z4.4
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1241
M204 S500
G1 X121.843 Y94.344 E.00663
G1 X125.757 Y94.344 E.08282
G1 X125.757 Y94.657 E.00663
G1 X121.903 Y94.657 E.08155
M204 S10000
G1 X121.419 Y95.082 F18000
G1 F1241
M204 S500
G1 X121.419 Y93.92 E.02458
G1 X126.181 Y93.92 E.10078
G1 X126.181 Y95.082 E.02458
G1 X121.479 Y95.082 E.09951
M204 S250
G1 X121.01 Y95.36 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1241
M204 S500
G1 X121.01 Y93.511 E.03638
M73 P95 R1
G1 X126.59 Y93.511 E.10975
G1 X126.59 Y95.36 E.03638
G1 X126.59 Y95.491 E.00257
G1 X121.01 Y95.491 E.10975
G1 X121.01 Y95.42 E.00139
; OBJECT_ID: 8
; WIPE_START
G1 F1698.374
M204 S6000
G1 X121.01 Y93.511 E-.36282
G1 X121.1 Y93.511 E-.01718
; WIPE_END
G1 E-.02 F1800
; stop printing object, unique label id: 12
M625
; start printing object, unique label id: 8
M624 AQAAAAAAAAA=
M204 S10000
G1 X114.011 Y90.683 Z4.8 F18000
G1 X57.243 Y68.044 Z4.8
G1 Z4.4
G1 E.4 F1800
G1 F1241
M204 S500
G1 X55.157 Y68.044 E.04104
G1 X55.157 Y65.957 E.04104
G1 X57.243 Y65.957 E.04104
G1 X57.243 Y66.121 E.00321
G1 X57.243 Y67.984 E.03665
; WIPE_START
G1 F1500
M204 S6000
G1 X55.244 Y68.042 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G17
G3 Z4.8 I1.217 J0 P1  F18000
; stop printing object, unique label id: 8
M625
; object ids of layer 44 start: 8,12
M624 AwAAAAAAAAA=
;===================== date: 20250206 =====================

; don't support timelapse gcode in spiral_mode and by object sequence for I3 structure printer
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
G92 E0
G1 Z4.8
G1 X0 Y85.35 ; move to safe pos
G1 X-13.0 F3000 ; move to safe pos
M400
M1004 S5 P1  ; external shutter
M400 P300
M971 S11 C11 O0
G92 E0
G1 X0 F18000
M623

; SKIPTYPE: head_wrap_detect
M622.1 S1
M1002 judge_flag g39_3rd_layer_detect_flag
M622 J1
    ; enable nozzle clog detect at 3rd layer
    


    M622.1 S1
    M1002 judge_flag g39_detection_flag
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




; object ids of this layer44 end: 8,12
M625
; start printing object, unique label id: 8
M624 AQAAAAAAAAA=
G1 X57.027 Y67.012
G1 Z4.4
G1 E.4 F1800
; FEATURE: Top surface
G1 F1241
M204 S2000
G1 X56.211 Y67.827 E.02268
G1 X55.654 Y67.827
G1 X57.027 Y66.455 E.03818
G1 X56.749 Y66.174
G1 X55.374 Y67.55 E.03827
G1 X55.373 Y66.993
G1 X56.192 Y66.174 E.02276
; CHANGE_LAYER
; Z_HEIGHT: 4.52
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F1500
M204 S6000
G1 X55.373 Y66.993 E-.21986
G1 X55.374 Y67.55 E-.10593
G1 X55.575 Y67.348 E-.05421
; WIPE_END
G1 E-.02 F1800
; stop printing object, unique label id: 8
M625
; layer num/total_layer_count: 45/51
; update layer progress
M73 L45
M991 S0 P44 ;notify layer change
; OBJECT_ID: 12
; start printing object, unique label id: 12
M624 AgAAAAAAAAA=
M204 S10000
G17
G3 Z4.8 I-.545 J1.088 P1  F18000
G1 X121.843 Y100.573 Z4.8
G1 Z4.52
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F793
M204 S500
G1 X125.757 Y100.573 E.08282
G1 X125.757 Y101.057 E.01025
G1 X121.843 Y101.057 E.08282
G1 X121.843 Y100.633 E.00898
M204 S10000
G1 X121.419 Y100.149 F18000
G1 F793
M204 S500
G1 X126.181 Y100.149 E.10078
G1 X126.181 Y101.482 E.02821
G1 X121.419 Y101.482 E.10078
G1 X121.419 Y100.209 E.02694
M204 S250
G1 X121.01 Y99.87 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F793
M204 S500
G1 X121.01 Y99.739 E.00257
G1 X126.59 Y99.739 E.10975
G1 X126.59 Y99.87 E.00257
G1 X126.59 Y101.891 E.03975
G1 X121.01 Y101.891 E.10975
G1 X121.01 Y99.93 E.03857
; WIPE_START
G1 F1500
M204 S6000
G1 X121.01 Y99.739 E-.03618
G1 X122.82 Y99.739 E-.34382
; WIPE_END
G1 E-.02 F1800
M204 S10000
G17
G3 Z4.92 I1.217 J0 P1  F18000
; stop printing object, unique label id: 12
M625
; object ids of layer 45 start: 12
M624 AgAAAAAAAAA=
;===================== date: 20250206 =====================

; don't support timelapse gcode in spiral_mode and by object sequence for I3 structure printer
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
G92 E0
G1 Z4.92
G1 X0 Y85.35 ; move to safe pos
G1 X-13.0 F3000 ; move to safe pos
M400
M1004 S5 P1  ; external shutter
M400 P300
M971 S11 C11 O0
G92 E0
G1 X0 F18000
M623

; SKIPTYPE: head_wrap_detect
M622.1 S1
M1002 judge_flag g39_3rd_layer_detect_flag
M622 J1
    ; enable nozzle clog detect at 3rd layer
    


    M622.1 S1
    M1002 judge_flag g39_detection_flag
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




; object ids of this layer45 end: 12
M625
; start printing object, unique label id: 12
M624 AgAAAAAAAAA=
G1 X122.056 Y100.815
G1 Z4.52
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.0860022
G1 F793
M204 S6000
G1 X125.544 Y100.815 E.01049
; WIPE_START
G1 F1500
G1 X123.544 Y100.815 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X121.843 Y94.829 Z4.92 F18000
G1 Z4.52
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F793
M204 S500
G1 X121.843 Y94.344 E.01025
G1 X125.757 Y94.344 E.08282
G1 X125.757 Y94.829 E.01025
G1 X121.903 Y94.829 E.08155
M204 S10000
G1 X121.419 Y95.253 F18000
G1 F793
M204 S500
G1 X121.419 Y93.92 E.02821
G1 X126.181 Y93.92 E.10078
G1 X126.181 Y95.253 E.02821
G1 X121.479 Y95.253 E.09951
M204 S250
G1 X121.01 Y95.532 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F793
M204 S500
G1 X121.01 Y93.511 E.03975
G1 X126.59 Y93.511 E.10975
G1 X126.59 Y95.532 E.03975
G1 X126.59 Y95.662 E.00257
G1 X121.01 Y95.662 E.10975
G1 X121.01 Y95.592 E.00139
; WIPE_START
G1 F1698.317
M204 S6000
G1 X121.01 Y93.592 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X122.056 Y94.586 Z4.92 F18000
G1 Z4.52
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.0859922
G1 F793
M204 S6000
G1 X125.544 Y94.586 E.01049
; CHANGE_LAYER
; Z_HEIGHT: 4.64
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F1500
G1 X123.544 Y94.586 E-.38
; WIPE_END
G1 E-.02 F1800
; stop printing object, unique label id: 12
M625
; layer num/total_layer_count: 46/51
; update layer progress
M73 L46
M991 S0 P45 ;notify layer change
; OBJECT_ID: 12
; start printing object, unique label id: 12
M624 AgAAAAAAAAA=
M204 S10000
G17
G3 Z4.92 I-.785 J.93 P1  F18000
G1 X126.78 Y97.317 Z4.92
G1 Z4.64
G1 E.4 F1800
; FEATURE: Support interface
; LINE_WIDTH: 0.42
; LAYER_HEIGHT: 0.264
G1 F923
M204 S6000
G1 X120.997 Y97.317 E.23064
G1 X120.997 Y98.212 E.03566
G1 X126.78 Y98.212 E.23064
; WIPE_START
G1 F1251.002
G1 X124.78 Y98.212 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X121.843 Y100.401 Z5.04 F18000
G1 Z4.64
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
; LAYER_HEIGHT: 0.12
G1 F923
M204 S500
G1 X125.757 Y100.401 E.08282
G1 X125.757 Y101.057 E.01388
G1 X121.843 Y101.057 E.08282
G1 X121.843 Y100.461 E.01261
M204 S10000
G1 X121.419 Y99.977 F18000
G1 F923
M204 S500
G1 X126.181 Y99.977 E.10078
G1 X126.181 Y101.482 E.03184
G1 X121.419 Y101.482 E.10078
G1 X121.419 Y100.037 E.03057
M204 S250
G1 X121.01 Y99.698 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F923
M204 S500
G1 X121.01 Y99.568 E.00257
G1 X126.59 Y99.568 E.10975
G1 X126.59 Y99.698 E.00257
G1 X126.59 Y101.891 E.04312
G1 X121.01 Y101.891 E.10975
G1 X121.01 Y99.758 E.04194
; WIPE_START
G1 F1500
M204 S6000
G1 X121.01 Y99.568 E-.03618
G1 X122.82 Y99.568 E-.34382
; WIPE_END
G1 E-.02 F1800
M204 S10000
G17
G3 Z5.04 I1.217 J0 P1  F18000
; stop printing object, unique label id: 12
M625
; object ids of layer 46 start: 12
M624 AgAAAAAAAAA=
;===================== date: 20250206 =====================

; don't support timelapse gcode in spiral_mode and by object sequence for I3 structure printer
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
G92 E0
G1 Z5.04
G1 X0 Y85.35 ; move to safe pos
G1 X-13.0 F3000 ; move to safe pos
M400
M1004 S5 P1  ; external shutter
M400 P300
M971 S11 C11 O0
G92 E0
G1 X0 F18000
M623

; SKIPTYPE: head_wrap_detect
M622.1 S1
M1002 judge_flag g39_3rd_layer_detect_flag
M622 J1
    ; enable nozzle clog detect at 3rd layer
    


    M622.1 S1
    M1002 judge_flag g39_detection_flag
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




; object ids of this layer46 end: 12
M625
; start printing object, unique label id: 12
M624 AgAAAAAAAAA=
G1 X122.056 Y100.729
G1 Z4.64
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.257432
G1 F923
M204 S6000
G1 X125.544 Y100.729 E.04033
; WIPE_START
G1 F1500
G1 X123.544 Y100.729 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X121.843 Y95 Z5.04 F18000
G1 Z4.64
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F923
M204 S500
G1 X121.843 Y94.344 E.01388
G1 X125.757 Y94.344 E.08282
G1 X125.757 Y95 E.01388
G1 X121.903 Y95 E.08155
M204 S10000
G1 X121.419 Y95.424 F18000
G1 F923
M204 S500
G1 X121.419 Y93.92 E.03184
G1 X126.181 Y93.92 E.10078
G1 X126.181 Y95.424 E.03184
G1 X121.479 Y95.424 E.09951
M204 S250
G1 X121.01 Y95.703 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F923
M204 S500
G1 X121.01 Y93.511 E.04312
G1 X126.59 Y93.511 E.10975
G1 X126.59 Y95.703 E.04312
G1 X126.59 Y95.834 E.00257
G1 X121.01 Y95.834 E.10975
G1 X121.01 Y95.763 E.00139
; WIPE_START
G1 F1698.374
M204 S6000
G1 X121.01 Y93.763 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X122.056 Y94.672 Z5.04 F18000
G1 Z4.64
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.257422
G1 F923
M204 S6000
G1 X125.544 Y94.672 E.04032
; CHANGE_LAYER
; Z_HEIGHT: 4.76
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F1500
G1 X123.544 Y94.672 E-.38
; WIPE_END
G1 E-.02 F1800
; stop printing object, unique label id: 12
M625
; layer num/total_layer_count: 47/51
; update layer progress
M73 L47
M991 S0 P46 ;notify layer change
; OBJECT_ID: 12
; start printing object, unique label id: 12
M624 AgAAAAAAAAA=
M204 S10000
G17
G3 Z5.04 I-1.164 J-.356 P1  F18000
M73 P96 R1
G1 X121.843 Y100.23 Z5.04
G1 Z4.76
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F804
M204 S500
G1 X125.757 Y100.23 E.08282
G1 X125.757 Y101.057 E.01751
G1 X121.843 Y101.057 E.08282
G1 X121.843 Y100.29 E.01624
M204 S10000
G1 X121.419 Y99.806 F18000
G1 F804
M204 S500
G1 X126.181 Y99.806 E.10078
G1 X126.181 Y101.482 E.03547
G1 X121.419 Y101.482 E.10078
G1 X121.419 Y99.866 E.0342
M204 S250
G1 X121.01 Y99.527 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F804
M204 S500
G1 X121.01 Y99.396 E.00257
G1 X126.59 Y99.396 E.10975
G1 X126.59 Y99.527 E.00257
G1 X126.59 Y101.891 E.0465
G1 X121.01 Y101.891 E.10975
G1 X121.01 Y99.587 E.04532
; WIPE_START
G1 F1500
M204 S6000
G1 X121.01 Y99.396 E-.03618
G1 X122.82 Y99.396 E-.34382
; WIPE_END
G1 E-.02 F1800
M204 S10000
G17
G3 Z5.16 I1.217 J0 P1  F18000
; stop printing object, unique label id: 12
M625
; object ids of layer 47 start: 12
M624 AgAAAAAAAAA=
;===================== date: 20250206 =====================

; don't support timelapse gcode in spiral_mode and by object sequence for I3 structure printer
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
G92 E0
G1 Z5.16
G1 X0 Y85.35 ; move to safe pos
G1 X-13.0 F3000 ; move to safe pos
M400
M1004 S5 P1  ; external shutter
M400 P300
M971 S11 C11 O0
G92 E0
G1 X0 F18000
M623

; SKIPTYPE: head_wrap_detect
M622.1 S1
M1002 judge_flag g39_3rd_layer_detect_flag
M622 J1
    ; enable nozzle clog detect at 3rd layer
    


    M622.1 S1
    M1002 judge_flag g39_detection_flag
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




; object ids of this layer47 end: 12
M625
; start printing object, unique label id: 12
M624 AgAAAAAAAAA=
G1 X122.056 Y100.644
G1 Z4.76
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.428862
G1 F804
M204 S6000
G1 X125.544 Y100.644 E.07016
; WIPE_START
G1 F1500
G1 X123.544 Y100.644 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X121.843 Y95.172 Z5.16 F18000
G1 Z4.76
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F804
M204 S500
G1 X121.843 Y94.344 E.01751
G1 X125.757 Y94.344 E.08282
G1 X125.757 Y95.172 E.01751
G1 X121.903 Y95.172 E.08155
M204 S10000
G1 X121.419 Y95.596 F18000
G1 F804
M204 S500
G1 X121.419 Y93.92 E.03547
G1 X126.181 Y93.92 E.10078
G1 X126.181 Y95.596 E.03547
G1 X121.479 Y95.596 E.09951
M204 S250
G1 X121.01 Y95.875 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F804
M204 S500
G1 X121.01 Y93.511 E.0465
G1 X126.59 Y93.511 E.10975
G1 X126.59 Y95.875 E.0465
G1 X126.59 Y96.005 E.00257
G1 X121.01 Y96.005 E.10975
G1 X121.01 Y95.935 E.00139
; WIPE_START
G1 F1698.374
M204 S6000
G1 X121.01 Y93.935 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X122.056 Y94.758 Z5.16 F18000
G1 Z4.76
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.428852
G1 F804
M204 S6000
G1 X125.544 Y94.758 E.07016
; CHANGE_LAYER
; Z_HEIGHT: 4.88
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F1500
G1 X123.544 Y94.758 E-.38
; WIPE_END
G1 E-.02 F1800
; stop printing object, unique label id: 12
M625
; layer num/total_layer_count: 48/51
; update layer progress
M73 L48
M991 S0 P47 ;notify layer change
; OBJECT_ID: 12
; start printing object, unique label id: 12
M624 AgAAAAAAAAA=
M204 S10000
G17
G3 Z5.16 I-1.159 J-.372 P1  F18000
G1 X121.843 Y100.059 Z5.16
G1 Z4.88
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F823
M204 S500
G1 X125.757 Y100.059 E.08282
G1 X125.757 Y101.057 E.02114
G1 X121.843 Y101.057 E.08282
G1 X121.843 Y100.119 E.01987
M204 S10000
G1 X121.419 Y99.634 F18000
G1 F823
M204 S500
G1 X126.181 Y99.634 E.10078
G1 X126.181 Y101.482 E.0391
G1 X121.419 Y101.482 E.10078
G1 X121.419 Y99.694 E.03783
M204 S250
G1 X121.01 Y99.356 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F823
M204 S500
G1 X121.01 Y99.225 E.00257
G1 X126.59 Y99.225 E.10975
G1 X126.59 Y99.356 E.00257
G1 X126.59 Y101.891 E.04987
G1 X121.01 Y101.891 E.10975
G1 X121.01 Y99.416 E.04869
; WIPE_START
G1 F1500
M204 S6000
G1 X121.01 Y99.225 E-.03618
G1 X122.82 Y99.225 E-.34382
; WIPE_END
G1 E-.02 F1800
M204 S10000
G17
G3 Z5.28 I1.217 J0 P1  F18000
; stop printing object, unique label id: 12
M625
; object ids of layer 48 start: 12
M624 AgAAAAAAAAA=
;===================== date: 20250206 =====================

; don't support timelapse gcode in spiral_mode and by object sequence for I3 structure printer
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
G92 E0
G1 Z5.28
G1 X0 Y85.35 ; move to safe pos
G1 X-13.0 F3000 ; move to safe pos
M400
M1004 S5 P1  ; external shutter
M400 P300
M971 S11 C11 O0
G92 E0
G1 X0 F18000
M623

; SKIPTYPE: head_wrap_detect
M622.1 S1
M1002 judge_flag g39_3rd_layer_detect_flag
M622 J1
    ; enable nozzle clog detect at 3rd layer
    


    M622.1 S1
    M1002 judge_flag g39_detection_flag
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




; object ids of this layer48 end: 12
M625
; start printing object, unique label id: 12
M624 AgAAAAAAAAA=
G1 X122.056 Y100.558
G1 Z4.88
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.600292
G1 F823
M204 S6000
G1 X125.544 Y100.558 E.1
; WIPE_START
G1 F1500
G1 X123.544 Y100.558 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X121.843 Y95.343 Z5.28 F18000
G1 Z4.88
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F823
M204 S500
G1 X121.843 Y94.344 E.02114
G1 X125.757 Y94.344 E.08282
G1 X125.757 Y95.343 E.02114
G1 X121.903 Y95.343 E.08155
M204 S10000
G1 X121.419 Y95.767 F18000
G1 F823
M204 S500
G1 X121.419 Y93.92 E.0391
G1 X126.181 Y93.92 E.10078
G1 X126.181 Y95.767 E.0391
G1 X121.479 Y95.767 E.09951
M204 S250
G1 X121.01 Y96.046 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F823
M204 S500
G1 X121.01 Y93.511 E.04987
G1 X126.59 Y93.511 E.10975
G1 X126.59 Y96.046 E.04987
G1 X126.59 Y96.177 E.00257
G1 X121.01 Y96.177 E.10975
G1 X121.01 Y96.106 E.00139
; WIPE_START
G1 F1698.374
M204 S6000
G1 X121.01 Y94.106 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X122.056 Y94.844 Z5.28 F18000
G1 Z4.88
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.600282
G1 F823
M204 S6000
G1 X125.544 Y94.844 E.1
; CHANGE_LAYER
; Z_HEIGHT: 5
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F1500
G1 X123.544 Y94.844 E-.38
; WIPE_END
G1 E-.02 F1800
; stop printing object, unique label id: 12
M625
; layer num/total_layer_count: 49/51
; update layer progress
M73 L49
M991 S0 P48 ;notify layer change
; OBJECT_ID: 12
; start printing object, unique label id: 12
M624 AgAAAAAAAAA=
M204 S10000
G17
G3 Z5.28 I-.799 J-.918 P1  F18000
G1 X121.881 Y96.291 Z5.28
G1 Z5
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F600
M204 S500
G1 X121.881 Y96.204 E.00184
G1 F1136
G1 X121.881 Y95.882 E.00682
G1 X125.719 Y95.882 E.08124
G1 X125.719 Y96.204 E.00682
G1 F600
G1 X125.719 Y96.587 E.0081
; FEATURE: Overhang wall
G1 F2357.113
G1 X125.719 Y98.815 E.04717
; FEATURE: Inner wall
G1 F600
G1 X125.719 Y99.198 E.0081
G1 F1136
G1 X125.719 Y99.52 E.00682
G1 X121.881 Y99.52 E.08124
G1 X121.881 Y99.198 E.00682
G1 F600
G1 X121.881 Y98.815 E.0081
; FEATURE: Overhang wall
G1 F2357.113
G1 X121.881 Y96.587 E.04717
; FEATURE: Inner wall
G1 F600
M73 P97 R1
G1 X121.881 Y96.351 E.00499
M204 S250
G1 X122.29 Y96.291 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1136
M204 S500
G1 X124.91 Y96.291 E.05153
G1 X125.31 Y96.291 E.00787
G1 F600
G1 X125.31 Y96.587 E.00582
; FEATURE: Overhang wall
; LINE_WIDTH: 0.45
G1 F2357.113
G1 X125.31 Y98.815 E.04717
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F600
G1 X125.31 Y99.111 E.00582
G1 F1136
G1 X124.91 Y99.111 E.00787
G1 X122.69 Y99.111 E.04367
G1 X122.29 Y99.111 E.00787
G1 F600
G1 X122.29 Y98.815 E.00582
; FEATURE: Overhang wall
; LINE_WIDTH: 0.45
G1 F2357.113
G1 X122.29 Y96.587 E.04717
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F600
G1 X122.29 Y96.351 E.00464
; WIPE_START
M204 S6000
G1 X124.289 Y96.305 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G17
G3 Z5.4 I-1.022 J-.661 P1  F18000
G1 X121.843 Y100.084 Z5.4
G1 Z5
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1136
M204 S500
G1 X121.843 Y99.944 E.00297
G1 X125.757 Y99.944 E.08282
G1 X125.757 Y101.057 E.02356
G1 X121.843 Y101.057 E.08282
G1 X121.843 Y100.144 E.01932
; WIPE_START
G1 F1500
M204 S6000
G1 X121.843 Y99.944 E-.03802
G1 X123.643 Y99.944 E-.34198
; WIPE_END
M73 P97 R0
G1 E-.02 F1800
M204 S10000
G17
G3 Z5.4 I1.165 J-.351 P1  F18000
G1 X122.29 Y95.457 Z5.4
G1 Z5
G1 E.4 F1800
G1 F1136
M204 S500
G1 X121.843 Y95.457 E.00945
G1 X121.843 Y94.344 E.02356
G1 X125.757 Y94.344 E.08282
G1 X125.757 Y95.457 E.02356
G1 X122.35 Y95.457 E.0721
; WIPE_START
G1 F1500
M204 S6000
G1 X121.843 Y95.457 E-.09624
G1 X121.843 Y94.344 E-.21148
G1 X122.224 Y94.344 E-.07228
; WIPE_END
G1 E-.02 F1800
M204 S10000
G17
G3 Z5.4 I-1.205 J-.169 P1  F18000
G1 X121.419 Y100.084 Z5.4
G1 Z5
G1 E.4 F1800
G1 F1136
M204 S500
G1 X121.419 Y99.598 E.0103
G1 X121.419 Y99.198 E.00847
G1 F600
G1 X121.419 Y98.815 E.0081
; FEATURE: Overhang wall
G1 F2357.113
G1 X121.419 Y96.587 E.04717
; FEATURE: Inner wall
G1 F600
G1 X121.419 Y96.204 E.0081
G1 F1136
G1 X121.419 Y95.804 E.00847
G1 X121.419 Y93.92 E.03988
G1 X126.181 Y93.92 E.10078
G1 X126.181 Y95.804 E.03988
G1 X126.181 Y96.204 E.00847
G1 F600
G1 X126.181 Y96.587 E.0081
; FEATURE: Overhang wall
G1 F2357.113
G1 X126.181 Y98.815 E.04717
; FEATURE: Inner wall
G1 F600
G1 X126.181 Y99.198 E.0081
G1 F1136
G1 X126.181 Y99.598 E.00847
G1 X126.181 Y101.482 E.03988
G1 X121.419 Y101.482 E.10078
G1 X121.419 Y100.144 E.0283
M204 S250
G1 X121.01 Y100.084 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1136
M204 S500
G1 X121.01 Y99.584 E.00984
G1 X121.01 Y99.184 E.00787
G1 F600
G1 X121.01 Y98.815 E.00726
; FEATURE: Overhang wall
; LINE_WIDTH: 0.45
G1 F2357.113
G1 X121.01 Y96.587 E.04717
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F600
G1 X121.01 Y96.218 E.00726
G1 F1136
G1 X121.01 Y95.818 E.00787
G1 X121.01 Y93.511 E.04537
G1 X126.59 Y93.511 E.10975
G1 X126.59 Y95.818 E.04537
G1 X126.59 Y96.218 E.00787
G1 F600
G1 X126.59 Y96.587 E.00726
; FEATURE: Overhang wall
; LINE_WIDTH: 0.45
G1 F2357.113
G1 X126.59 Y98.815 E.04717
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F600
G1 X126.59 Y99.184 E.00726
G1 F1136
G1 X126.59 Y99.584 E.00787
G1 X126.59 Y101.891 E.04537
G1 X121.01 Y101.891 E.10975
G1 X121.01 Y100.144 E.03435
; WIPE_START
G1 F1500
M204 S6000
G1 X121.01 Y99.584 E-.10646
G1 X121.01 Y99.184 E-.076
G1 X121.01 Y98.815 E-.07011
G1 X121.01 Y98.144 E-.12743
; WIPE_END
G1 E-.02 F1800
M204 S10000
G17
G3 Z5.4 I1.217 J0 P1  F18000
; stop printing object, unique label id: 12
M625
; object ids of layer 49 start: 12
M624 AgAAAAAAAAA=
;===================== date: 20250206 =====================

; don't support timelapse gcode in spiral_mode and by object sequence for I3 structure printer
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
G92 E0
G1 Z5.4
G1 X0 Y85.35 ; move to safe pos
G1 X-13.0 F3000 ; move to safe pos
M400
M1004 S5 P1  ; external shutter
M400 P300
M971 S11 C11 O0
G92 E0
G1 X0 F18000
M623

; SKIPTYPE: head_wrap_detect
M622.1 S1
M1002 judge_flag g39_3rd_layer_detect_flag
M622 J1
    ; enable nozzle clog detect at 3rd layer
    


    M622.1 S1
    M1002 judge_flag g39_detection_flag
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




; object ids of this layer49 end: 12
M625
; start printing object, unique label id: 12
M624 AgAAAAAAAAA=
G1 X122.228 Y100.329
G1 Z5
G1 E.4 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.370162
G1 F1136
M204 S6000
G1 X122.228 Y100.673 E.00592
G1 X125.372 Y100.673 E.05403
G1 X125.372 Y100.329 E.00592
G1 X122.288 Y100.329 E.053
; WIPE_START
G1 F1500
G1 X124.288 Y100.329 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G17
G3 Z5.4 I1.133 J-.444 P1  F18000
G1 X122.228 Y95.073 Z5.4
G1 Z5
G1 E.4 F1800
G1 F1136
M204 S6000
G1 X125.372 Y95.073 E.05403
G1 X125.372 Y94.729 E.00592
G1 X122.228 Y94.729 E.05403
G1 X122.228 Y95.013 E.00489
; CHANGE_LAYER
; Z_HEIGHT: 5.12
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F1500
G1 X122.228 Y94.729 E-.05404
G1 X123.943 Y94.729 E-.32596
; WIPE_END
G1 E-.02 F1800
; stop printing object, unique label id: 12
M625
; layer num/total_layer_count: 50/51
; update layer progress
M73 L50
M991 S0 P49 ;notify layer change
; OBJECT_ID: 12
; start printing object, unique label id: 12
M624 AgAAAAAAAAA=
M204 S10000
G17
G3 Z5.4 I-1.15 J-.397 P1  F18000
G1 X122.29 Y99.52 Z5.4
G1 Z5.12
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1142
M204 S500
G1 X121.881 Y99.52 E.00866
G1 X121.881 Y95.882 E.07701
G1 X125.719 Y95.882 E.08124
G1 X125.719 Y99.52 E.07701
G1 X122.35 Y99.52 E.07131
M204 S250
G1 X122.29 Y99.111 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1142
M204 S500
G1 X122.29 Y96.291 E.05547
G1 X125.31 Y96.291 E.0594
G1 X125.31 Y99.111 E.05547
G1 X122.35 Y99.111 E.05822
; WIPE_START
G1 F1500
M204 S6000
G1 X122.307 Y97.111 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G17
G3 Z5.52 I1.217 J-.013 P1  F18000
G1 X122.29 Y95.457 Z5.52
G1 Z5.12
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1142
M204 S500
G1 X121.843 Y95.457 E.00945
G1 X121.843 Y94.344 E.02356
G1 X125.757 Y94.344 E.08282
G1 X125.757 Y95.457 E.02356
G1 X122.35 Y95.457 E.0721
; WIPE_START
G1 F1500
M204 S6000
G1 X121.843 Y95.457 E-.09624
G1 X121.843 Y94.344 E-.21148
G1 X122.224 Y94.344 E-.07228
; WIPE_END
G1 E-.02 F1800
M204 S10000
G17
G3 Z5.52 I-1.214 J-.082 P1  F18000
G1 X121.843 Y99.944 Z5.52
G1 Z5.12
G1 E.4 F1800
G1 F1142
M204 S500
G1 X125.757 Y99.944 E.08282
G1 X125.757 Y101.057 E.02356
G1 X121.843 Y101.057 E.08282
G1 X121.843 Y100.004 E.02229
; WIPE_START
G1 F1500
M204 S6000
G1 X123.843 Y99.974 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G17
G3 Z5.52 I1.13 J-.452 P1  F18000
G1 X121.419 Y93.92 Z5.52
G1 Z5.12
G1 E.4 F1800
G1 F1142
M204 S500
G1 X126.181 Y93.92 E.10078
G1 X126.181 Y101.482 E.16005
G1 X121.419 Y101.482 E.10078
G1 X121.419 Y93.98 E.15878
M204 S250
G1 X121.01 Y93.511 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1142
M204 S500
G1 X126.59 Y93.511 E.10975
G1 X126.59 Y101.891 E.16483
G1 X121.01 Y101.891 E.10975
G1 X121.01 Y93.571 E.16365
; WIPE_START
G1 F1500
M204 S6000
G1 X123.01 Y93.549 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G17
G3 Z5.52 I1.217 J0 P1  F18000
; stop printing object, unique label id: 12
M625
; object ids of layer 50 start: 12
M624 AgAAAAAAAAA=
;===================== date: 20250206 =====================

; don't support timelapse gcode in spiral_mode and by object sequence for I3 structure printer
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
G92 E0
G1 Z5.52
G1 X0 Y85.35 ; move to safe pos
G1 X-13.0 F3000 ; move to safe pos
M400
M1004 S5 P1  ; external shutter
M400 P300
M971 S11 C11 O0
G92 E0
G1 X0 F18000
M623

; SKIPTYPE: head_wrap_detect
M622.1 S1
M1002 judge_flag g39_3rd_layer_detect_flag
M622 J1
    ; enable nozzle clog detect at 3rd layer
    


    M622.1 S1
    M1002 judge_flag g39_detection_flag
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




; object ids of this layer50 end: 12
M625
; start printing object, unique label id: 12
M624 AgAAAAAAAAA=
G1 X122.228 Y95.073
G1 Z5.12
G1 E.4 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.370162
G1 F1142
M204 S6000
G1 X125.372 Y95.073 E.05403
G1 X125.372 Y94.729 E.00592
G1 X122.228 Y94.729 E.05403
G1 X122.228 Y95.013 E.00489
; WIPE_START
G1 F1500
G1 X122.228 Y94.729 E-.05404
G1 X123.943 Y94.729 E-.32596
; WIPE_END
G1 E-.02 F1800
M204 S10000
G17
G3 Z5.52 I-1.164 J-.356 P1  F18000
G1 X122.228 Y100.329 Z5.52
G1 Z5.12
G1 E.4 F1800
G1 F1142
M204 S6000
G1 X122.228 Y100.673 E.00592
G1 X125.372 Y100.673 E.05403
G1 X125.372 Y100.329 E.00592
G1 X122.288 Y100.329 E.053
; CHANGE_LAYER
; Z_HEIGHT: 5.24
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F1500
G1 X124.288 Y100.329 E-.38
; WIPE_END
G1 E-.02 F1800
; stop printing object, unique label id: 12
M625
; layer num/total_layer_count: 51/51
; update layer progress
M73 L51
M991 S0 P50 ;notify layer change
; OBJECT_ID: 12
; start printing object, unique label id: 12
M624 AgAAAAAAAAA=
M204 S10000
G17
G3 Z5.52 I.633 J-1.039 P1  F18000
G1 X122.29 Y99.111 Z5.52
G1 Z5.24
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1381
M204 S500
G1 X122.29 Y96.291 E.05547
G1 X125.31 Y96.291 E.0594
G1 X125.31 Y99.111 E.05547
G1 X122.35 Y99.111 E.05822
; WIPE_START
G1 F1500
M204 S6000
M73 P98 R0
G1 X122.307 Y97.111 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G17
G3 Z5.64 I1.145 J-.413 P1  F18000
G1 X121.01 Y93.511 Z5.64
G1 Z5.24
G1 E.4 F1800
G1 F1381
M204 S500
G1 X126.59 Y93.511 E.10975
G1 X126.59 Y101.891 E.16483
G1 X121.01 Y101.891 E.10975
G1 X121.01 Y93.571 E.16365
; WIPE_START
G1 F1500
M204 S6000
G1 X123.01 Y93.549 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G17
G3 Z5.64 I1.217 J0 P1  F18000
; stop printing object, unique label id: 12
M625
; object ids of layer 51 start: 12
M624 AgAAAAAAAAA=
;===================== date: 20250206 =====================

; don't support timelapse gcode in spiral_mode and by object sequence for I3 structure printer
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
G92 E0
G1 Z5.64
G1 X0 Y85.35 ; move to safe pos
G1 X-13.0 F3000 ; move to safe pos
M400
M1004 S5 P1  ; external shutter
M400 P300
M971 S11 C11 O0
G92 E0
G1 X0 F18000
M623

; SKIPTYPE: head_wrap_detect
M622.1 S1
M1002 judge_flag g39_3rd_layer_detect_flag
M622 J1
    ; enable nozzle clog detect at 3rd layer
    


    M622.1 S1
    M1002 judge_flag g39_detection_flag
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




; object ids of this layer51 end: 12
M625
; start printing object, unique label id: 12
M624 AgAAAAAAAAA=
G1 X125.822 Y93.728
G1 Z5.24
G1 E.4 F1800
; FEATURE: Top surface
G1 F1381
M204 S2000
G1 X126.373 Y94.279 E.01534
G1 X126.373 Y94.837
G1 X125.264 Y93.728 E.03085
G1 X124.707 Y93.728
G1 X126.373 Y95.394 E.04636
G1 X126.373 Y95.952
G1 X124.149 Y93.728 E.06186
G1 X123.592 Y93.728
G1 X126.373 Y96.509 E.07737
G1 X125.527 Y96.22
G1 X126.373 Y97.067 E.02354
G1 X126.373 Y97.624
G1 X125.527 Y96.778 E.02354
G1 X125.527 Y97.335
G1 X126.373 Y98.182 E.02354
G1 X126.373 Y98.739
G1 X125.527 Y97.893 E.02354
G1 X125.527 Y98.451
G1 X126.373 Y99.297 E.02354
G1 X126.373 Y99.854
G1 X125.527 Y99.008 E.02354
G1 X125.289 Y99.328
G1 X126.373 Y100.412 E.03016
G1 X126.373 Y100.969
G1 X124.731 Y99.328 E.04567
G1 X124.174 Y99.328
G1 X126.373 Y101.527 E.06118
G1 X125.963 Y101.674
G1 X123.616 Y99.328 E.06527
G1 X123.059 Y99.328
G1 X125.405 Y101.674 E.06527
G1 X124.847 Y101.674
G1 X122.501 Y99.328 E.06527
; WIPE_START
G1 F1500
M204 S6000
G1 X123.915 Y100.742 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X125.38 Y96.074 Z5.64 F18000
G1 Z5.24
G1 E.4 F1800
G1 F1381
M204 S2000
G1 X123.034 Y93.728 E.06527
G1 X122.477 Y93.728
G1 X124.823 Y96.074 E.06527
G1 X124.265 Y96.074
G1 X121.919 Y93.728 E.06527
G1 X121.361 Y93.728
G1 X123.708 Y96.074 E.06527
G1 X123.15 Y96.074
G1 X121.227 Y94.151 E.0535
G1 X121.227 Y94.708
G1 X122.593 Y96.074 E.03799
G1 X122.073 Y96.112
G1 X121.227 Y95.266 E.02354
G1 X121.227 Y95.823
G1 X122.073 Y96.669 E.02354
G1 X122.073 Y97.227
G1 X121.227 Y96.381 E.02354
G1 X121.227 Y96.938
G1 X122.073 Y97.785 E.02354
G1 X122.073 Y98.342
G1 X121.227 Y97.496 E.02354
G1 X121.227 Y98.053
G1 X122.073 Y98.9 E.02354
G1 X121.227 Y98.611
G1 X124.29 Y101.674 E.0852
G1 X123.732 Y101.674
G1 X121.227 Y99.168 E.0697
G1 X121.227 Y99.726
G1 X123.175 Y101.674 E.05419
G1 X122.617 Y101.674
G1 X121.227 Y100.283 E.03868
G1 X121.227 Y100.841
G1 X122.06 Y101.674 E.02317
; WIPE_START
G1 F1500
M204 S6000
G1 X121.227 Y100.841 E-.22382
G1 X121.227 Y100.283 E-.10593
G1 X121.414 Y100.47 E-.05025
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X122.042 Y99.147 Z5.64 F18000
G1 Z5.24
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.0915779
G1 F1381
M204 S6000
G1 X122.073 Y98.961 E.00062
; WIPE_START
G1 F1500
G1 X122.042 Y99.147 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G17
G3 Z5.64 I.86 J-.861 P1  F18000
G1 X121.258 Y98.363 Z5.64
G1 Z5.24
G1 E.4 F1800
G1 F1381
M204 S6000
G1 X121.227 Y98.549 E.00062
; WIPE_START
G1 F1500
G1 X121.258 Y98.363 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G17
G3 Z5.64 I1.127 J.459 P1  F18000
G1 X122.093 Y96.311 Z5.64
G1 Z5.24
G1 E.4 F1800
; LINE_WIDTH: 0.0504414
G1 F1381
M204 S6000
G1 X122.076 Y96.319 E.00002
; LINE_WIDTH: 0.0967942
G1 X122.058 Y96.327 E.00007
G1 X121.982 Y96.203 E.00052
; WIPE_START
G1 F1500
G1 X122.058 Y96.327 E-.3363
G1 X122.076 Y96.319 E-.0437
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X125.374 Y96.081 Z5.64 F18000
G1 Z5.24
G1 E.4 F1800
; LINE_WIDTH: 0.152858
G1 F1381
M204 S6000
G1 X125.523 Y96.03 E.001
; LINE_WIDTH: 0.139232
G1 X125.53 Y96.062 E.00019
; LINE_WIDTH: 0.0880662
G1 X125.527 Y96.159 E.0003
; WIPE_START
G1 F1500
G1 X125.53 Y96.062 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G17
G3 Z5.64 I-.791 J.925 P1  F18000
G1 X126.342 Y96.757 Z5.64
G1 Z5.24
G1 E.4 F1800
; LINE_WIDTH: 0.0915779
G1 F1381
M204 S6000
G1 X126.373 Y96.571 E.00062
; close powerlost recovery
M1003 S0
; WIPE_START
G1 F1500
G1 X126.342 Y96.757 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G17
G3 Z5.64 I1.217 J0 P1  F18000
; stop printing object, unique label id: 12
M625
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
G1 X0 Y85.35 F18000 ; move to safe pos
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

