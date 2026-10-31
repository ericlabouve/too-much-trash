; HEADER_BLOCK_START
; BambuStudio 02.07.01.62
; model printing time: 20m 8s; total estimated time: 28m 13s
; total layer number: 49
; total filament length [mm] : 470.09
; total filament volume [cm^3] : 1130.71
; total filament weight [g] : 1.40
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
M73 P0 R28
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
M73 P1 R27
    G1 E50 F200
    M400
    M1002 set_filament_type:TPU

    M104 S250

    G92 E0
    G1 E50 F49.8898
    M400
    M106 P1 S178
    G92 E0
M73 P2 R27
    G1 E5 F49.8898
    M109 S210 ; drop nozzle temp, make filament shink a bit
    M104 S190
    G92 E0
M73 P6 R26
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
M73 P22 R22
G1 Z2 F1200
G1 X91 F10000
G380 S3 Z-5 F1200
M73 P22 R21
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
    G29 A1 X79.55 Y75.4009 I20.9 J29.1982
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
    
M73 P23 R21
    G1 X-13.5 F3000
    M400
    M984 A0.1 E1 S1 F0.49281 H0.4
    M106 P1 S178
    M400 S7
    G1 X0 F18000
M73 P24 R21
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
G1 X94.357 Y90.594 F18000
M204 S6000
G1 Z.4
M73 P25 R20
G1 Z.2
M73 P26 R20
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.5
G1 F900
M204 S500
G1 X94.357 Y90.308 E.01087
G1 X95.343 Y90.308 E.03747
G1 X95.343 Y90.594 E.01087
G1 X94.417 Y90.594 E.03519
; WIPE_START
G1 X94.357 Y90.308 E-.0555
G1 X95.343 Y90.308 E-.18732
G1 X95.343 Y90.594 E-.05432
G1 X94.907 Y90.594 E-.08287
; WIPE_END
G1 E-.02 F1800
M204 S6000
G1 X95.957 Y87.808 Z.6 F18000
G1 Z.2
G1 E.4 F1800
G1 F900
M204 S500
G1 X95.957 Y87.608 E.0076
G1 X98.143 Y87.608 E.08308
M73 P27 R20
G1 X98.143 Y87.808 E.0076
G1 X97.05 Y88.901 E.05874
G1 X95.999 Y87.85 E.05646
; WIPE_START
M73 P28 R20
G1 X95.957 Y87.608 E-.04677
G1 X97.711 Y87.608 E-.33323
; WIPE_END
G1 E-.02 F1800
M204 S6000
G1 X98.757 Y90.308 Z.6 F18000
G1 Z.2
G1 E.4 F1800
G1 F900
M204 S500
G1 X99.743 Y90.308 E.03747
G1 X99.743 Y90.594 E.01087
G1 X98.757 Y90.594 E.03747
G1 X98.757 Y90.368 E.00858
; WIPE_START
G1 X99.743 Y90.308 E-.18766
G1 X99.743 Y90.594 E-.05432
G1 X99.017 Y90.594 E-.13802
; WIPE_END
G1 E-.02 F1800
M204 S6000
G1 X98.723 Y94.974 Z.6 F18000
G1 Z.2
G1 E.4 F1800
G1 F900
M204 S500
G1 X99.286 Y94.411 E.03024
G1 X99.286 Y95.237 E.03137
G1 X98.46 Y95.237 E.03137
G1 X98.681 Y95.016 E.01184
M204 S6000
G1 X98.4 Y94.651 F18000
G1 F900
M204 S500
G1 X99.743 Y93.308 E.07218
G1 X99.743 Y95.694 E.09068
G1 X97.357 Y95.694 E.09068
G1 X98.358 Y94.693 E.05378
; WIPE_START
G1 X99.743 Y93.308 E-.37226
G1 X99.743 Y93.349 E-.00774
; WIPE_END
G1 E-.02 F1800
M204 S6000
G1 X94.814 Y94.411 Z.6 F18000
G1 Z.2
G1 E.4 F1800
G1 F900
M204 S500
G1 X95.64 Y95.237 E.04436
G1 X94.814 Y95.237 E.03137
G1 X94.814 Y94.471 E.02909
; WIPE_START
G1 X95.64 Y95.237 E-.21387
G1 X94.814 Y95.237 E-.15682
G1 X94.814 Y95.188 E-.0093
; WIPE_END
G1 E-.02 F1800
M204 S6000
G1 X94.357 Y93.308 Z.6 F18000
G1 Z.2
G1 E.4 F1800
G1 F900
M204 S500
G1 X96.743 Y95.694 E.12824
G1 X94.357 Y95.694 E.09068
G1 X94.357 Y93.368 E.0884
; WIPE_START
G1 X95.789 Y94.764 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S6000
G1 X89.428 Y98.654 Z.6 F18000
G1 Z.2
G1 E.4 F1800
G1 F900
M204 S500
G1 X89.48 Y98.699 E.00262
G1 X89.789 Y99.074 E.01848
G1 X90.026 Y99.498 E.01845
G1 X90.179 Y99.949 E.01808
G1 X90.239 Y100.278 E.01272
G1 X90.259 Y100.611 E.0127
G1 X90.216 Y101.085 E.01807
G1 X90.089 Y101.545 E.01814
G1 X89.954 Y101.849 E.01264
G1 X89.782 Y102.136 E.01272
G1 X89.481 Y102.502 E.01804
G1 X89.117 Y102.811 E.01814
G1 X88.834 Y102.986 E.01265
G1 X88.532 Y103.125 E.01263
G1 X88.074 Y103.26 E.01814
G1 X87.601 Y103.309 E.01808
G1 X87.267 Y103.294 E.0127
G1 X86.937 Y103.24 E.01273
G1 X86.485 Y103.093 E.01805
G1 X86.057 Y102.862 E.01849
G1 X85.677 Y102.56 E.01845
G1 X85.365 Y102.202 E.01805
G1 X85.185 Y101.92 E.01272
G1 X85.039 Y101.619 E.01271
G1 X84.899 Y101.164 E.01807
G1 X84.841 Y100.682 E.01847
G1 X84.87 Y100.208 E.01805
G1 X84.939 Y99.881 E.01272
G1 X85.047 Y99.566 E.01264
G1 X85.266 Y99.142 E.01813
G1 X85.564 Y98.758 E.01848
G1 X85.926 Y98.431 E.01855
G1 X86.329 Y98.183 E.01797
G1 X86.636 Y98.051 E.01271
G1 X86.957 Y97.958 E.01271
G1 X87.418 Y97.895 E.01766
G1 X87.753 Y97.9 E.01272
G1 X88.084 Y97.945 E.01271
G1 X88.531 Y98.076 E.01769
G1 X88.834 Y98.216 E.01269
G1 X89.116 Y98.391 E.01261
G1 X89.382 Y98.616 E.01324
M204 S6000
G1 X89.132 Y99.003 F18000
; FEATURE: Outer wall
G1 F900
M204 S500
G1 X89.154 Y99.021 E.00105
G1 X89.41 Y99.333 E.01535
G1 X89.606 Y99.685 E.01532
G1 X89.736 Y100.064 E.01521
G1 X89.784 Y100.332 E.01037
G1 X89.801 Y100.604 E.01036
G1 X89.765 Y101.003 E.0152
G1 X89.658 Y101.39 E.01527
G1 X89.547 Y101.638 E.0103
G1 X89.407 Y101.872 E.01038
G1 X89.154 Y102.18 E.01518
G1 X88.847 Y102.44 E.01526
G1 X88.617 Y102.583 E.01031
G1 X88.371 Y102.696 E.01029
G1 X87.985 Y102.809 E.01527
G1 X87.587 Y102.851 E.0152
G1 X87.315 Y102.839 E.01036
G1 X87.045 Y102.794 E.01039
G1 X86.665 Y102.671 E.01518
G1 X86.31 Y102.479 E.01536
G1 X85.994 Y102.228 E.01532
G1 X85.731 Y101.927 E.01519
G1 X85.585 Y101.697 E.01037
G1 X85.466 Y101.451 E.01037
G1 X85.348 Y101.069 E.0152
G1 X85.3 Y100.668 E.01534
G1 X85.324 Y100.269 E.01518
G1 X85.381 Y100.002 E.01038
G1 X85.468 Y99.746 E.0103
G1 X85.653 Y99.389 E.01526
G1 X85.9 Y99.07 E.01534
G1 X86.202 Y98.799 E.01542
G1 X86.54 Y98.59 E.01511
G1 X86.791 Y98.482 E.01037
G1 X87.053 Y98.406 E.01037
G1 X87.445 Y98.353 E.01506
G1 X87.718 Y98.357 E.01038
G1 X87.989 Y98.393 E.01037
G1 X88.37 Y98.505 E.01509
G1 X88.617 Y98.619 E.01035
G1 X88.847 Y98.761 E.01028
G1 X89.087 Y98.964 E.01194
M204 S6000
G1 X89.723 Y98.305 F18000
; FEATURE: Inner wall
G1 F900
M204 S500
G1 X89.385 Y98.02 E.01682
G1 X89.051 Y97.813 E.01494
G1 X88.692 Y97.647 E.01503
G1 X88.179 Y97.497 E.0203
G1 X87.787 Y97.444 E.01506
G1 X87.391 Y97.438 E.01506
G1 X86.862 Y97.509 E.02027
G1 X86.482 Y97.62 E.01505
G1 X86.118 Y97.776 E.01505
G1 X85.651 Y98.064 E.02083
G1 X85.227 Y98.445 E.02168
G1 X84.903 Y98.864 E.02012
G1 X84.718 Y98.801 E.00745
G1 X84.713 Y95.963 E.10788
G1 X90.386 Y95.958 E.21559
G1 X90.386 Y99.081 E.11868
G1 X89.807 Y98.377 E.03463
G1 X89.769 Y98.344 E.00191
; WIPE_START
G1 X89.385 Y98.02 E-.09546
G1 X89.051 Y97.813 E-.07471
G1 X88.692 Y97.647 E-.07513
G1 X88.179 Y97.497 E-.10149
G1 X88.006 Y97.473 E-.03321
; WIPE_END
G1 E-.02 F1800
M204 S6000
G1 X88.854 Y95.502 Z.6 F18000
G1 Z.2
G1 E.4 F1800
G1 F900
M204 S500
G1 X90.843 Y95.501 E.0756
G1 X90.843 Y100.58 E.19304
G1 X90.818 Y100.997 E.01589
G1 X90.698 Y101.562 E.02195
G1 X90.562 Y101.928 E.01482
G1 X90.384 Y102.275 E.01483
G1 X90.051 Y102.742 E.02183
G1 X89.772 Y103.03 E.01521
G1 X89.469 Y103.276 E.01483
G1 X88.966 Y103.574 E.02222
G1 X88.408 Y103.779 E.0226
G1 X87.846 Y103.879 E.02168
G1 X87.448 Y103.891 E.01512
G1 X87.054 Y103.856 E.01507
G1 X86.496 Y103.719 E.02183
G1 X86.134 Y103.573 E.01482
G1 X85.793 Y103.384 E.01482
G1 X85.476 Y103.157 E.01483
M73 P29 R20
G1 X85.188 Y102.894 E.01482
G1 X84.934 Y102.598 E.01482
G1 X84.71 Y102.266 E.01521
G1 X84.464 Y101.747 E.02183
G1 X84.35 Y101.374 E.01484
G1 X84.28 Y100.983 E.01508
G1 X84.264 Y100.806 E.00679
G1 X84.256 Y95.506 E.20143
G1 X88.794 Y95.502 E.17248
; WIPE_START
G1 X90.794 Y95.501 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S6000
G1 X92.34 Y88.026 Z.6 F18000
G1 X94.607 Y77.067 Z.6
G1 Z.2
G1 E.4 F1800
G1 F900
M204 S500
G1 X94.816 Y76.98 E.00862
G1 X95.023 Y77.294 E.01429
G1 X94.654 Y77.294 E.01403
G1 X94.619 Y77.125 E.00653
; WIPE_START
G1 X94.816 Y76.98 E-.08019
G1 X95.023 Y77.294 E-.12291
G1 X94.654 Y77.294 E-.12069
G1 X94.619 Y77.125 E-.05621
; WIPE_END
G1 E-.02 F1800
M204 S6000
G1 X94.718 Y84.757 Z.6 F18000
G1 X94.8 Y91.051 Z.6
G1 Z.2
G1 E.4 F1800
; FEATURE: Outer wall
G1 F900
M204 S500
G1 X94.8 Y93.104 E.07805
G1 X97.05 Y95.354 E.12094
G1 X99.3 Y93.104 E.12094
G1 X99.3 Y91.051 E.07805
G1 X98.3 Y91.051 E.03801
G1 X98.3 Y89.851 E.04561
G1 X100.2 Y89.851 E.07221
G1 X100.2 Y96.151 E.23944
G1 X91.3 Y96.151 E.33826
G1 X91.3 Y100.593 E.16884
G1 X91.273 Y101.044 E.01717
M73 P29 R19
G1 X91.241 Y101.261 E.00831
G1 X91.136 Y101.696 E.01702
G1 X90.981 Y102.112 E.01688
G1 X90.779 Y102.508 E.01689
G1 X90.53 Y102.876 E.01688
G1 X90.393 Y103.046 E.00831
G1 X90.081 Y103.367 E.01702
G1 X89.736 Y103.647 E.01689
G1 X89.36 Y103.885 E.01687
G1 X89.163 Y103.986 E.00846
G1 X88.963 Y104.074 E.00831
G1 X88.535 Y104.219 E.01716
G1 X88.326 Y104.269 E.00817
G1 X87.887 Y104.335 E.01688
G1 X87.435 Y104.349 E.01719
G1 X86.993 Y104.309 E.01687
G1 X86.781 Y104.271 E.00816
G1 X86.349 Y104.153 E.01703
G1 X85.937 Y103.986 E.01688
G1 X85.548 Y103.771 E.01689
G1 X85.187 Y103.512 E.01688
G1 X84.86 Y103.213 E.01688
G1 X84.57 Y102.876 E.01688
G1 X84.319 Y102.505 E.01702
G1 X84.214 Y102.313 E.00832
G1 X84.035 Y101.907 E.01687
G1 X83.905 Y101.481 E.0169
G1 X83.827 Y101.044 E.01687
G1 X83.807 Y100.826 E.00832
G1 X83.8 Y96.151 E.17769
G1 X81.449 Y96.148 E.08935
G1 X81.248 Y96.124 E.00767
G1 X80.948 Y96.044 E.01179
G1 X80.588 Y95.863 E.01531
G1 X80.277 Y95.601 E.01544
G1 X80.037 Y95.279 E.0153
G1 X79.905 Y94.996 E.01187
G1 X79.848 Y94.804 E.00759
G1 X79.812 Y94.604 E.00774
G1 X79.8 Y94.393 E.00801
G1 X79.8 Y77.408 E.64555
G1 X79.812 Y77.198 E.00801
G1 X79.848 Y76.997 E.00773
G1 X79.905 Y76.806 E.00759
G1 X80.037 Y76.523 E.01187
G1 X80.145 Y76.359 E.00745
G1 X80.35 Y76.129 E.01173
G1 X80.589 Y75.94 E.01158
G1 X80.859 Y75.794 E.01166
G1 X81.045 Y75.726 E.00753
G1 X81.351 Y75.663 E.01186
G1 X93.541 Y75.651 E.4633
G1 X93.857 Y75.679 E.01207
G1 X94.052 Y75.725 E.0076
G1 X94.425 Y75.886 E.01544
G1 X94.748 Y76.126 E.0153
G1 X94.955 Y76.359 E.01187
G1 X95.147 Y76.651 E.01327
G1 X97.6 Y76.651 E.09322
G1 X97.6 Y87.151 E.39907
G1 X98.6 Y87.151 E.03801
G1 X98.6 Y87.997 E.03217
G1 X97.05 Y89.547 E.08331
G1 X95.5 Y87.997 E.08331
G1 X95.5 Y87.151 E.03217
G1 X96.5 Y87.151 E.03801
G1 X96.5 Y77.751 E.35726
G1 X94.2 Y77.751 E.08743
G1 X94.199 Y77.352 E.01516
G1 X94.163 Y77.178 E.00676
G1 X94.074 Y77.011 E.00719
G1 X93.94 Y76.877 E.00719
G1 X93.773 Y76.788 E.00719
G1 X93.599 Y76.752 E.00676
G1 X81.532 Y76.751 E.45863
G1 X81.359 Y76.776 E.00663
G1 X81.159 Y76.876 E.00849
G1 X81.004 Y77.042 E.00863
G1 X80.911 Y77.257 E.00891
G1 X80.9 Y94.43 E.65269
G1 X80.96 Y94.685 E.00994
G1 X81.073 Y94.846 E.00748
G1 X81.195 Y94.948 E.00604
G1 X81.363 Y95.026 E.00704
G1 X81.532 Y95.051 E.0065
G1 X93.9 Y95.041 E.47007
G1 X93.9 Y89.851 E.19726
G1 X95.8 Y89.851 E.07221
G1 X95.8 Y91.051 E.04561
G1 X94.86 Y91.051 E.03573
; WIPE_START
G1 X94.802 Y93.05 E-.38
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




G1 X94.35 Y92.977
G1 Z.2
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.48586
G1 F900
M204 S500
G1 X94.35 Y90.822 E.07937
; WIPE_START
G1 X94.35 Y92.822 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S6000
G1 X97.05 Y87.379 Z.6 F18000
G1 Z.2
G1 E.4 F1800
; LINE_WIDTH: 0.68586
G1 F900
M204 S500
G1 X97.05 Y77.522 E.52696
; LINE_WIDTH: 0.704247
G1 X97.032 Y77.434 E.00499
; LINE_WIDTH: 0.74102
G1 F859.476
G1 X97.013 Y77.345 E.00526
; LINE_WIDTH: 0.777794
G1 F816.467
G1 X96.995 Y77.256 E.00554
; LINE_WIDTH: 0.777776
G1 X96.906 Y77.238 E.00554
; LINE_WIDTH: 0.74101
G1 F859.489
G1 X96.817 Y77.219 E.00526
; LINE_WIDTH: 0.686913
G1 F900
G1 X96.729 Y77.201 E.00485
G1 X95.236 Y77.201 E.07994
M204 S6000
G1 X94.633 Y76.808 F18000
; LINE_WIDTH: 0.687769
G1 F900
M204 S500
G1 X94.37 Y76.529 E.02059
G1 X94.149 Y76.365 E.01478
G1 X93.885 Y76.25 E.01542
G1 X93.517 Y76.201 E.01991
G1 X81.515 Y76.203 E.64352
G1 X81.194 Y76.253 E.01741
G1 X80.891 Y76.399 E.01806
G1 X80.729 Y76.531 E.01119
G1 X80.517 Y76.788 E.01787
G1 X80.381 Y77.114 E.01895
G1 X80.355 Y77.434 E.0172
G1 X80.35 Y94.368 E.90803
G1 X80.391 Y94.686 E.01716
G1 X80.489 Y94.961 E.01567
G1 X80.677 Y95.225 E.01734
G1 X80.89 Y95.404 E.01497
G1 X81.138 Y95.527 E.01483
G1 X81.251 Y95.56 E.00629
M73 P30 R19
G1 X81.516 Y95.599 E.01436
G1 X84.027 Y95.6 E.13467
; WIPE_START
G1 X82.027 Y95.599 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S6000
G1 X85.269 Y98.063 Z.6 F18000
G1 Z.2
G1 E.4 F1800
; LINE_WIDTH: 0.127845
G1 F900
M204 S500
G1 X85.022 Y98.248 E.00218
; LINE_WIDTH: 0.157556
G1 X84.946 Y98.317 E.00098
M204 S6000
G1 X84.743 Y99.051 F18000
; LINE_WIDTH: 0.403496
G1 F900
M204 S500
G1 X84.668 Y99.418 E.01124
; LINE_WIDTH: 0.377768
G1 X84.648 Y99.54 E.00342
; LINE_WIDTH: 0.337361
G1 X84.628 Y99.661 E.00301
; LINE_WIDTH: 0.294694
G1 X84.606 Y99.796 E.00286
; LINE_WIDTH: 0.253623
G1 X84.587 Y99.978 E.00322
; LINE_WIDTH: 0.213774
G1 X84.567 Y100.173 E.00277
; LINE_WIDTH: 0.169365
G1 X84.558 Y100.79 E.00649
G1 X84.636 Y101.306 E.00548
G1 X84.74 Y101.645 E.00373
G1 X84.887 Y101.978 E.00383
G1 X85.167 Y102.421 E.00551
G1 X85.474 Y102.765 E.00484
G1 X85.663 Y102.927 E.00262
G1 X85.902 Y103.107 E.00315
G1 X86.261 Y103.307 E.00432
G1 X86.59 Y103.438 E.00372
G1 X86.873 Y103.518 E.0031
G1 X87.095 Y103.564 E.00238
G1 X87.457 Y103.597 E.00383
G1 X87.82 Y103.584 E.00381
G1 X88.136 Y103.543 E.00335
G1 X88.692 Y103.374 E.00611
G1 X88.967 Y103.24 E.00322
G1 X89.291 Y103.044 E.00399
G1 X89.69 Y102.701 E.00553
G1 X90.014 Y102.304 E.00539
G1 X90.131 Y102.125 E.00225
G1 X90.362 Y101.638 E.00566
G1 X90.506 Y101.119 E.00566
G1 X90.55 Y100.611 E.00537
G1 X90.54 Y100.237 E.00393
; LINE_WIDTH: 0.208687
G1 X90.523 Y100.054 E.00253
; LINE_WIDTH: 0.243065
G1 X90.505 Y99.856 E.00332
; LINE_WIDTH: 0.277432
G1 X90.49 Y99.763 E.00182
; LINE_WIDTH: 0.273651
G1 X90.437 Y99.67 E.00205
; LINE_WIDTH: 0.235435
G1 X90.385 Y99.576 E.00171
; LINE_WIDTH: 0.19722
G1 X90.333 Y99.483 E.00137
; LINE_WIDTH: 0.157483
G1 X90.277 Y99.382 E.0011
; LINE_WIDTH: 0.120242
G1 X90.151 Y99.198 E.00144
; WIPE_START
G1 X90.277 Y99.382 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S6000
G1 X89.188 Y96.142 Z.6 F18000
G1 Z.2
G1 E.4 F1800
; FEATURE: Bottom surface
; LINE_WIDTH: 0.54344
G1 F900
M204 S500
G1 X89.997 Y96.951 E.04765
G1 X89.997 Y97.659 E.02946
G1 X88.686 Y96.348 E.07719
G1 X87.979 Y96.348 E.02944
G1 X88.984 Y97.354 E.05917
G1 X88.829 Y97.282 E.00711
G1 X88.26 Y97.116 E.02466
G1 X88.003 Y97.081 E.0108
G1 X87.271 Y96.349 E.04307
G1 X86.564 Y96.35 E.02944
G1 X87.276 Y97.061 E.04188
G1 X86.781 Y97.128 E.02077
G1 X86.668 Y97.161 E.00491
G1 X85.857 Y96.35 E.04774
G1 X85.15 Y96.351 E.02944
G1 X86.142 Y97.343 E.05841
G1 X85.938 Y97.43 E.00921
G1 X85.68 Y97.589 E.01262
G1 X84.898 Y96.807 E.04608
; WIPE_START
G1 X85.68 Y97.589 E-.21035
G1 X85.938 Y97.43 E-.0576
G1 X86.142 Y97.343 E-.04206
G1 X85.882 Y97.083 E-.06998
; WIPE_END
G1 E-.02 F1800
M204 S6000
G1 X91.072 Y95.597 Z.6 F18000
G1 Z.2
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.69467
G1 F900
M204 S500
G1 X94.128 Y95.596 E.16566
; WIPE_START
G1 X92.128 Y95.597 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S6000
G1 X99.347 Y93.116 Z.6 F18000
G1 X99.75 Y92.977 Z.6
G1 Z.2
G1 E.4 F1800
; LINE_WIDTH: 0.48586
G1 F900
M204 S500
G1 X99.75 Y90.822 E.07937
; CHANGE_LAYER
; Z_HEIGHT: 0.32
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F900
G1 X99.75 Y92.822 E-.38
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
G3 Z.6 I.454 J-1.129 P1  F18000
G1 X94.431 Y90.682 Z.6
G1 Z.32
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X94.269 Y90.682 E.00342
G1 X94.269 Y90.22 E.00977
G1 X95.431 Y90.22 E.02458
G1 X95.431 Y90.682 E.00977
G1 X94.491 Y90.682 E.0199
; WIPE_START
M204 S6000
G1 X94.269 Y90.682 E-.04209
G1 X94.269 Y90.22 E-.08769
G1 X95.431 Y90.22 E-.22069
G1 X95.431 Y90.376 E-.02952
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X98.669 Y90.22 Z.72 F18000
G1 Z.32
G1 E.4 F1800
G1 F1500
M204 S500
G1 X99.831 Y90.22 E.02458
G1 X99.831 Y90.682 E.00977
G1 X98.669 Y90.682 E.02458
G1 X98.669 Y90.28 E.0085
; WIPE_START
M204 S6000
G1 X99.831 Y90.22 E-.22098
G1 X99.831 Y90.682 E-.08769
G1 X99.455 Y90.682 E-.07132
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X98.638 Y94.889 Z.72 F18000
G1 Z.32
G1 E.4 F1800
G1 F1500
M204 S500
G1 X99.407 Y94.12 E.02301
G1 X99.407 Y95.357 E.02619
G1 X98.169 Y95.357 E.02619
G1 X98.595 Y94.931 E.01276
M204 S10000
G1 X98.338 Y94.589 F18000
G1 F1500
M204 S500
G1 X99.831 Y93.096 E.04469
G1 X99.831 Y95.782 E.05685
G1 X97.145 Y95.782 E.05685
G1 X98.295 Y94.631 E.03444
; WIPE_START
M204 S6000
G1 X99.71 Y93.217 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X96.569 Y87.944 Z.72 F18000
G1 Z.32
G1 E.4 F1800
G1 F1500
M204 S500
G1 X97.531 Y87.944 E.02035
G1 X97.05 Y88.425 E.01439
G1 X96.612 Y87.987 E.01312
; WIPE_START
M204 S6000
G1 X97.531 Y87.944 E-.17484
G1 X97.05 Y88.425 E-.1292
G1 X96.767 Y88.143 E-.07596
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X94.693 Y94.12 Z.72 F18000
G1 Z.32
G1 E.4 F1800
G1 F1500
M204 S500
G1 X95.931 Y95.357 E.03704
G1 X94.693 Y95.357 E.02619
G1 X94.693 Y94.18 E.02492
; WIPE_START
M204 S6000
G1 X95.931 Y95.357 E-.32452
G1 X95.639 Y95.357 E-.05549
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X89.702 Y98.458 Z.72 F18000
G1 Z.32
G1 E.4 F1800
G1 F1500
M204 S500
G1 X89.589 Y98.336 E.00353
G1 X89.152 Y98.008 E.01156
G1 X88.677 Y97.771 E.01123
G1 X88.316 Y97.654 E.00803
G1 X87.943 Y97.58 E.00805
G1 X87.413 Y97.556 E.01123
G1 X86.872 Y97.63 E.01157
G1 X86.352 Y97.798 E.01156
G1 X85.885 Y98.05 E.01123
G1 X85.581 Y98.278 E.00804
G1 X85.318 Y98.529 E.00771
G1 X85.086 Y98.811 E.00771
G1 X84.882 Y99.131 E.00804
G1 X84.8 Y99.316 E.00428
G1 X84.598 Y99.273 E.00436
G1 X84.593 Y95.842 E.07262
G1 X90.507 Y95.837 E.12517
G1 X90.507 Y99.269 E.07264
G1 X90.301 Y99.31 E.00443
G1 X90.255 Y99.196 E.0026
G1 X89.957 Y98.731 E.01168
G1 X89.743 Y98.502 E.00664
M204 S10000
G1 X89.392 Y98.747 F18000
G1 F1500
M204 S500
G1 X89.62 Y98.992 E.0071
G1 X89.877 Y99.393 E.01006
G1 X90.052 Y99.82 E.00977
G1 X90.128 Y100.133 E.00682
G1 X90.166 Y100.448 E.00671
G1 X90.153 Y100.913 E.00986
G1 X90.057 Y101.364 E.00976
G1 X89.944 Y101.667 E.00683
G1 X89.795 Y101.953 E.00683
G1 X89.529 Y102.319 E.00957
G1 X89.299 Y102.552 E.00694
G1 X89.051 Y102.75 E.00671
G1 X88.652 Y102.98 E.00974
G1 X88.21 Y103.138 E.00995
G1 X87.746 Y103.215 E.00995
G1 X87.276 Y103.208 E.00995
G1 X86.824 Y103.119 E.00975
G1 X86.52 Y103.01 E.00683
G1 X86.231 Y102.866 E.00683
G1 X85.855 Y102.601 E.00975
G1 X85.531 Y102.273 E.00975
G1 X85.342 Y102.011 E.00683
G1 X85.185 Y101.73 E.00683
G1 X85.023 Y101.298 E.00975
G1 X84.94 Y100.845 E.00975
G1 X84.931 Y100.522 E.00683
G1 X84.96 Y100.201 E.00683
G1 X85.069 Y99.754 E.00974
G1 X85.256 Y99.333 E.00976
G1 X85.43 Y99.061 E.00683
G1 X85.629 Y98.819 E.00664
G1 X85.856 Y98.602 E.00663
G1 X86.114 Y98.408 E.00683
G1 X86.52 Y98.19 E.00975
G1 X86.966 Y98.045 E.00994
G1 X87.432 Y97.982 E.00995
G1 X87.893 Y98.002 E.00975
G1 X88.209 Y98.065 E.00684
G1 X88.516 Y98.165 E.00683
G1 X88.928 Y98.37 E.00975
G1 X89.304 Y98.652 E.00994
G1 X89.351 Y98.703 E.00146
M204 S250
G1 X89.092 Y99.025 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X89.295 Y99.244 E.00588
G1 X89.512 Y99.582 E.0079
G1 X89.661 Y99.946 E.00774
G1 X89.725 Y100.206 E.00526
G1 X89.756 Y100.466 E.00516
G1 X89.745 Y100.865 E.00783
G1 X89.663 Y101.249 E.00774
G1 X89.569 Y101.5 E.00526
G1 X89.446 Y101.737 E.00526
G1 X89.217 Y102.053 E.00768
G1 X89.025 Y102.247 E.00536
G1 X88.82 Y102.41 E.00516
G1 X88.479 Y102.607 E.00773
G1 X88.106 Y102.741 E.0078
G1 X87.715 Y102.806 E.00779
G1 X87.319 Y102.8 E.0078
G1 X86.933 Y102.724 E.00774
G1 X86.681 Y102.633 E.00526
G1 X86.442 Y102.514 E.00526
G1 X86.12 Y102.287 E.00773
G1 X85.845 Y102.007 E.00773
G1 X85.687 Y101.791 E.00526
G1 X85.557 Y101.557 E.00526
G1 X85.419 Y101.189 E.00773
G1 X85.349 Y100.802 E.00773
G1 X85.341 Y100.535 E.00526
G1 X85.365 Y100.268 E.00526
G1 X85.458 Y99.887 E.00773
G1 X85.618 Y99.527 E.00774
G1 X85.762 Y99.302 E.00526
G1 X85.93 Y99.097 E.0052
G1 X86.121 Y98.915 E.0052
G1 X86.335 Y98.754 E.00526
G1 X86.681 Y98.568 E.00773
G1 X87.058 Y98.445 E.00779
G1 X87.451 Y98.392 E.0078
G1 X87.844 Y98.41 E.00773
G1 X88.106 Y98.462 E.00527
G1 X88.361 Y98.544 E.00526
G1 X88.712 Y98.72 E.00773
G1 X89.029 Y98.958 E.0078
G1 X89.051 Y98.981 E.00063
; WIPE_START
M204 S6000
G1 X89.295 Y99.244 E-.06818
G1 X89.512 Y99.582 E-.0763
G1 X89.661 Y99.946 E-.07476
G1 X89.725 Y100.206 E-.05081
G1 X89.756 Y100.466 E-.04982
G1 X89.747 Y100.783 E-.06014
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X93.012 Y93.884 Z.72 F18000
G1 X95.869 Y87.844 Z.72
G1 Z.32
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X95.869 Y87.52 E.00686
G1 X96.869 Y87.52 E.02117
G1 X96.869 Y77.382 E.21459
G1 X94.582 Y77.382 E.0484
G1 X94.514 Y77.05 E.00717
G1 X94.373 Y76.788 E.00629
G1 X94.163 Y76.578 E.00629
G1 X93.901 Y76.437 E.00629
G1 X93.637 Y76.382 E.00571
G1 X81.496 Y76.382 E.25697
G1 X81.207 Y76.432 E.0062
G1 X80.929 Y76.582 E.00668
G1 X80.691 Y76.835 E.00737
G1 X80.542 Y77.181 E.00795
G1 X80.531 Y94.437 E.36524
G1 X80.555 Y94.646 E.00446
G1 X80.672 Y94.94 E.00668
G1 X80.961 Y95.246 E.00892
G1 X81.255 Y95.384 E.00687
G1 X81.505 Y95.42 E.00534
G1 X94.269 Y95.41 E.27016
G1 X94.269 Y93.096 E.04898
G1 X96.955 Y95.782 E.08039
G1 X90.931 Y95.782 E.12751
G1 X90.931 Y100.582 E.10161
G1 X90.906 Y101.001 E.00887
G1 X90.835 Y101.395 E.00848
G1 X90.647 Y101.956 E.01252
G1 X90.46 Y102.32 E.00865
G1 X90.116 Y102.801 E.01252
G1 X89.679 Y103.226 E.01291
G1 X89.182 Y103.561 E.01269
G1 X88.821 Y103.733 E.00846
G1 X88.432 Y103.863 E.00869
G1 X88.04 Y103.945 E.00847
G1 X87.659 Y103.979 E.0081
G1 X87.25 Y103.967 E.00867
G1 X86.854 Y103.908 E.00848
G1 X86.468 Y103.803 E.00848
G1 X86.097 Y103.652 E.00847
G1 X85.746 Y103.459 E.00846
G1 X85.413 Y103.219 E.00869
G1 X84.995 Y102.814 E.01231
G1 X84.747 Y102.489 E.00867
G1 X84.543 Y102.144 E.00848
G1 X84.32 Y101.597 E.01251
G1 X84.226 Y101.208 E.00847
G1 X84.176 Y100.8 E.0087
G1 X84.168 Y95.783 E.1062
G1 X81.47 Y95.778 E.05711
G1 X81.32 Y95.761 E.00321
G1 X81.07 Y95.694 E.00547
G1 X80.792 Y95.554 E.00659
G1 X80.55 Y95.351 E.00668
G1 X80.393 Y95.151 E.00538
G1 X80.317 Y95.02 E.00321
G1 X80.208 Y94.719 E.00678
G1 X80.169 Y94.383 E.00717
G1 X80.169 Y77.419 E.35905
G1 X80.206 Y77.092 E.00697
G1 X80.284 Y76.855 E.00528
G1 X80.403 Y76.635 E.00528
G1 X80.488 Y76.521 E.00301
G1 X80.67 Y76.339 E.00547
G1 X80.785 Y76.254 E.00301
G1 X81.004 Y76.135 E.00528
G1 X81.237 Y76.058 E.00518
G1 X81.391 Y76.03 E.00331
G1 X93.528 Y76.02 E.25689
G1 X93.798 Y76.044 E.00575
G1 X93.946 Y76.079 E.00321
G1 X94.24 Y76.206 E.00678
G1 X94.374 Y76.294 E.00339
G1 X94.49 Y76.391 E.0032
G1 X94.662 Y76.584 E.00547
G1 X94.948 Y77.02 E.01104
G1 X97.231 Y77.02 E.04831
G1 X97.231 Y87.52 E.22224
G1 X98.231 Y87.52 E.02117
G1 X98.231 Y87.844 E.00686
G1 X97.05 Y89.025 E.03534
G1 X95.912 Y87.887 E.03407
; WIPE_START
M204 S6000
G1 X95.869 Y87.52 E-.07014
G1 X96.869 Y87.52 E-.19
G1 X96.869 Y86.889 E-.11986
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X94.84 Y91.091 Z.72 F18000
G1 Z.32
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X94.84 Y93.088 E.03928
G1 X97.05 Y95.298 E.06147
G1 X99.26 Y93.088 E.06147
G1 X99.26 Y91.091 E.03928
G1 X98.26 Y91.091 E.01967
G1 X98.26 Y89.811 E.02518
G1 X100.24 Y89.811 E.03895
G1 X100.24 Y96.191 E.12549
G1 X91.34 Y96.191 E.17505
G1 X91.34 Y100.594 E.08661
G1 X91.313 Y101.049 E.00896
G1 X91.234 Y101.491 E.00883
G1 X91.105 Y101.914 E.0087
G1 X91.019 Y102.126 E.0045
G1 X90.813 Y102.528 E.00889
G1 X90.561 Y102.903 E.00889
G1 X90.423 Y103.073 E.0043
G1 X90.113 Y103.392 E.00876
G1 X89.938 Y103.544 E.00455
M73 P31 R19
G1 X89.762 Y103.678 E.00436
G1 X89.38 Y103.92 E.00889
G1 X88.974 Y104.113 E.00883
G1 X88.539 Y104.259 E.00903
G1 X88.107 Y104.35 E.00869
G1 X87.887 Y104.376 E.00436
G1 X87.665 Y104.389 E.00436
G1 X87.214 Y104.376 E.00889
G1 X86.77 Y104.309 E.00883
G1 X86.336 Y104.191 E.00884
G1 X85.92 Y104.022 E.00883
G1 X85.527 Y103.805 E.00883
G1 X85.155 Y103.537 E.00903
G1 X84.829 Y103.238 E.0087
G1 X84.681 Y103.077 E.0043
G1 X84.407 Y102.718 E.00889
G1 X84.179 Y102.331 E.00883
G1 X83.996 Y101.918 E.00889
G1 X83.926 Y101.711 E.00429
G1 X83.822 Y101.281 E.0087
G1 X83.767 Y100.825 E.00903
G1 X83.76 Y96.191 E.09114
G1 X81.446 Y96.188 E.04551
G1 X81.242 Y96.164 E.00403
G1 X80.935 Y96.081 E.00626
G1 X80.747 Y96 E.00403
G1 X80.567 Y95.896 E.00409
G1 X80.4 Y95.772 E.00409
G1 X80.247 Y95.628 E.00413
G1 X80.053 Y95.382 E.00616
G1 X79.951 Y95.204 E.00403
G1 X79.868 Y95.013 E.0041
G1 X79.809 Y94.814 E.00409
G1 X79.772 Y94.609 E.0041
G1 X79.76 Y94.395 E.00422
G1 X79.76 Y77.407 E.33413
G1 X79.772 Y77.193 E.00422
G1 X79.808 Y76.991 E.00403
G1 X79.907 Y76.692 E.00619
G1 X80.057 Y76.415 E.0062
G1 X80.177 Y76.253 E.00397
G1 X80.402 Y76.028 E.00626
G1 X80.564 Y75.907 E.00397
G1 X80.841 Y75.758 E.0062
G1 X81.136 Y75.66 E.0061
G1 X81.343 Y75.623 E.00413
G1 X81.556 Y75.611 E.00421
G1 X93.546 Y75.611 E.23582
G1 X93.864 Y75.639 E.00628
G1 X94.063 Y75.686 E.00403
G1 X94.259 Y75.758 E.0041
G1 X94.445 Y75.851 E.00409
G1 X94.619 Y75.965 E.00409
G1 X94.776 Y76.097 E.00403
G1 X94.987 Y76.335 E.00625
G1 X95.169 Y76.611 E.0065
G1 X97.64 Y76.611 E.04861
G1 X97.64 Y87.111 E.20653
G1 X98.64 Y87.111 E.01967
G1 X98.64 Y88.014 E.01776
G1 X97.05 Y89.604 E.04423
G1 X95.46 Y88.014 E.04423
G1 X95.46 Y87.111 E.01776
G1 X96.46 Y87.111 E.01967
G1 X96.46 Y77.791 E.18332
G1 X94.16 Y77.791 E.04524
G1 X94.159 Y77.356 E.00855
G1 X94.125 Y77.191 E.00331
G1 X94.041 Y77.035 E.00349
G1 X93.916 Y76.91 E.00349
G1 X93.76 Y76.826 E.00349
G1 X93.595 Y76.792 E.00331
G1 X81.532 Y76.791 E.23727
G1 X81.343 Y76.824 E.00376
G1 X81.182 Y76.911 E.00361
G1 X81.038 Y77.064 E.00413
G1 X80.951 Y77.265 E.00431
G1 X80.94 Y94.413 E.33728
G1 X80.955 Y94.545 E.00262
G1 X81.023 Y94.716 E.00361
G1 X81.205 Y94.908 E.00521
G1 X81.374 Y94.987 E.00367
G1 X81.535 Y95.011 E.00319
G1 X93.86 Y95.001 E.24243
G1 X93.86 Y89.811 E.10209
G1 X95.84 Y89.811 E.03895
G1 X95.84 Y91.091 E.02518
G1 X94.9 Y91.091 E.01849
; WIPE_START
M204 S6000
G1 X94.84 Y93.088 E-.3796
G1 X94.842 Y93.089 E-.0004
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




G1 X94.35 Y92.887
G1 Z.32
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.596522
G1 F1500
M204 S6000
G1 X94.35 Y90.886 E.05697
; WIPE_START
G1 X94.35 Y92.886 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X95.077 Y94.958 Z.72 F18000
G1 Z.32
G1 E.4 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.365752
G1 F1500
M204 S6000
G1 X95.013 Y94.995 E.00125
G1 X95.062 Y95.023 E.00095
; WIPE_START
G1 X95.013 Y94.995 E-.16436
G1 X95.077 Y94.958 E-.21564
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X99.065 Y94.958 Z.72 F18000
G1 Z.32
G1 E.4 F1800
G1 F1500
M204 S6000
G1 X99.002 Y94.995 E.00125
G1 X99.05 Y95.023 E.00095
; WIPE_START
G1 X99.002 Y94.995 E-.16436
G1 X99.065 Y94.958 E-.21564
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X99.75 Y92.887 Z.72 F18000
G1 Z.32
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.596522
G1 F1500
M204 S6000
G1 X99.75 Y90.886 E.05697
; WIPE_START
G1 X99.75 Y92.886 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X93.25 Y96.887 Z.72 F18000
G1 X90.294 Y98.706 Z.72
G1 Z.32
G1 E.4 F1800
; LINE_WIDTH: 0.145845
G1 F1500
M204 S6000
G1 X90.163 Y98.566 E.00115
; LINE_WIDTH: 0.10451
G1 X89.937 Y98.362 E.0012
; WIPE_START
G1 X90.163 Y98.566 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X90.187 Y99.548 Z.72 F18000
G1 Z.32
G1 E.4 F1800
; LINE_WIDTH: 0.39818
G1 F1500
M204 S6000
G1 X90.321 Y99.627 E.00287
; LINE_WIDTH: 0.423774
G1 X90.454 Y99.705 E.00307
; LINE_WIDTH: 0.469448
G1 X90.486 Y99.726 E.00086
G1 X90.506 Y99.888 E.0036
; LINE_WIDTH: 0.432076
G1 X90.525 Y100.049 E.0033
; LINE_WIDTH: 0.389149
G1 X90.548 Y100.417 E.00669
; LINE_WIDTH: 0.360803
G1 X90.527 Y100.973 E.0093
G1 X90.42 Y101.458 E.0083
G1 X90.299 Y101.802 E.0061
G1 X90.124 Y102.142 E.00638
G1 X89.926 Y102.426 E.0058
G1 X89.569 Y102.82 E.00888
G1 X89.271 Y103.052 E.00631
G1 X88.994 Y103.225 E.00547
G1 X88.677 Y103.377 E.00588
G1 X88.332 Y103.497 E.0061
G1 X87.789 Y103.59 E.00921
G1 X87.284 Y103.588 E.00845
G1 X86.933 Y103.532 E.00594
G1 X86.59 Y103.441 E.00594
G1 X86.261 Y103.307 E.00594
G1 X86.049 Y103.196 E.004
G1 X85.622 Y102.898 E.0087
G1 X85.236 Y102.507 E.00919
G1 X85.063 Y102.276 E.00482
G1 X84.883 Y101.97 E.00594
G1 X84.739 Y101.635 E.00609
G1 X84.667 Y101.411 E.00392
G1 X84.604 Y101.137 E.00471
G1 X84.557 Y100.777 E.00607
G1 X84.571 Y100.123 E.01094
; LINE_WIDTH: 0.417369
G1 X84.608 Y99.811 E.00612
; LINE_WIDTH: 0.464785
G1 X84.646 Y99.5 E.00687
; WIPE_START
G1 X84.608 Y99.811 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X86.705 Y96.742 Z.72 F18000
G1 Z.32
G1 E.4 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.596712
G1 F1500
M204 S6000
G1 X87.011 Y96.722 E.00874
; LINE_WIDTH: 0.549592
G1 X87.317 Y96.701 E.00802
G1 X88.077 Y96.716 E.01988
; WIPE_START
G1 X87.317 Y96.701 E-.27081
G1 X87.011 Y96.722 E-.10919
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X86.705 Y96.742 Z.72 F18000
G1 Z.32
G1 E.4 F1800
; LINE_WIDTH: 0.598686
G1 F1500
M204 S6000
G1 X86.477 Y96.724 E.00652
; LINE_WIDTH: 0.561312
G1 X86.25 Y96.705 E.00609
; LINE_WIDTH: 0.507325
G1 X86.023 Y96.687 E.00548
G1 X85.44 Y96.687 E.014
G1 X85.441 Y97.332 E.01549
G1 X85.968 Y97.044 E.01442
; LINE_WIDTH: 0.52642
G1 X86.292 Y96.912 E.00874
; LINE_WIDTH: 0.568755
G1 X86.615 Y96.779 E.00948
; LINE_WIDTH: 0.603647
G1 X86.649 Y96.765 E.00105
; WIPE_START
G1 X86.615 Y96.779 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X89.66 Y96.685 Z.72 F18000
G1 Z.32
G1 E.4 F1800
; LINE_WIDTH: 0.506982
G1 F1500
M204 S6000
G1 X88.953 Y96.685 E.01697
; LINE_WIDTH: 0.52434
G1 X88.545 Y96.703 E.01015
; LINE_WIDTH: 0.547483
G1 X88.137 Y96.721 E.01063
G1 X88.918 Y96.96 E.02125
; LINE_WIDTH: 0.506982
G1 X89.656 Y97.323 E.01975
G1 X89.66 Y96.745 E.01388
M204 S10000
G1 X90.097 Y96.247 F18000
; LINE_WIDTH: 0.419992
G1 F1500
M204 S6000
G1 X85.002 Y96.251 E.10021
G1 X85.007 Y98.261 E.03953
G1 X85.643 Y97.72 E.01642
G1 X86.175 Y97.429 E.01193
G1 X86.763 Y97.235 E.01219
G1 X87.377 Y97.148 E.01219
G1 X87.978 Y97.172 E.01181
G1 X88.808 Y97.383 E.01685
G1 X89.352 Y97.651 E.01193
G1 X89.751 Y97.956 E.00989
G1 X89.882 Y97.841 E.00343
G1 X90.097 Y97.873 E.00428
G1 X90.097 Y96.307 E.0308
; CHANGE_LAYER
; Z_HEIGHT: 0.44
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F1500
G1 X90.097 Y97.873 E-.29753
G1 X89.882 Y97.841 E-.04136
G1 X89.751 Y97.956 E-.03313
G1 X89.718 Y97.931 E-.00798
; WIPE_END
G1 E-.02 F1800
; layer num/total_layer_count: 3/49
; update layer progress
M73 L3
M991 S0 P2 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z.72 I1.02 J.663 P1  F18000
G1 X94.431 Y90.682 Z.72
G1 Z.44
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X94.269 Y90.682 E.00342
G1 X94.269 Y90.22 E.00977
G1 X95.431 Y90.22 E.02458
G1 X95.431 Y90.682 E.00977
G1 X94.491 Y90.682 E.0199
; WIPE_START
M204 S6000
G1 X94.269 Y90.682 E-.04209
G1 X94.269 Y90.22 E-.08769
G1 X95.431 Y90.22 E-.22069
G1 X95.431 Y90.376 E-.02952
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X98.669 Y90.22 Z.84 F18000
G1 Z.44
G1 E.4 F1800
G1 F1500
M204 S500
G1 X99.831 Y90.22 E.02458
G1 X99.831 Y90.682 E.00977
G1 X98.669 Y90.682 E.02458
G1 X98.669 Y90.28 E.0085
; WIPE_START
M204 S6000
G1 X99.831 Y90.22 E-.22098
G1 X99.831 Y90.682 E-.08769
G1 X99.455 Y90.682 E-.07132
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X98.638 Y94.889 Z.84 F18000
G1 Z.44
G1 E.4 F1800
G1 F1500
M204 S500
G1 X99.407 Y94.12 E.02301
G1 X99.407 Y95.357 E.02619
G1 X98.169 Y95.357 E.02619
G1 X98.595 Y94.931 E.01276
M204 S10000
G1 X98.338 Y94.589 F18000
G1 F1500
M204 S500
G1 X99.831 Y93.096 E.04469
G1 X99.831 Y95.782 E.05685
G1 X97.145 Y95.782 E.05685
G1 X98.295 Y94.631 E.03444
; WIPE_START
M204 S6000
G1 X99.71 Y93.217 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X96.569 Y87.944 Z.84 F18000
G1 Z.44
G1 E.4 F1800
G1 F1500
M204 S500
G1 X97.531 Y87.944 E.02035
G1 X97.05 Y88.425 E.01439
G1 X96.612 Y87.987 E.01312
; WIPE_START
M204 S6000
G1 X97.531 Y87.944 E-.17484
G1 X97.05 Y88.425 E-.1292
G1 X96.767 Y88.143 E-.07596
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X94.693 Y94.12 Z.84 F18000
G1 Z.44
G1 E.4 F1800
G1 F1500
M204 S500
G1 X95.931 Y95.357 E.03704
G1 X94.693 Y95.357 E.02619
G1 X94.693 Y94.18 E.02492
; WIPE_START
M204 S6000
G1 X95.931 Y95.357 E-.32452
G1 X95.639 Y95.357 E-.05549
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X89.632 Y98.387 Z.84 F18000
G1 Z.44
G1 E.4 F1800
G1 F1500
M204 S500
G1 X89.309 Y98.114 E.00896
G1 X88.993 Y97.919 E.00785
G1 X88.648 Y97.759 E.00803
G1 X88.154 Y97.615 E.0109
G1 X87.778 Y97.564 E.00804
G1 X87.398 Y97.558 E.00804
G1 X86.872 Y97.63 E.01124
G1 X86.367 Y97.794 E.01123
G1 X86.027 Y97.964 E.00804
G1 X85.71 Y98.173 E.00804
G1 X85.316 Y98.528 E.01123
G1 X84.981 Y98.961 E.01159
G1 X84.792 Y99.327 E.0087
G1 X84.598 Y99.28 E.00423
G1 X84.593 Y95.842 E.07276
G1 X90.507 Y95.837 E.12517
G1 X90.507 Y99.281 E.07289
G1 X90.316 Y99.33 E.00417
G1 X90.069 Y98.885 E.01077
G1 X89.72 Y98.461 E.01162
G1 X89.678 Y98.425 E.00118
M204 S10000
G1 X89.358 Y98.711 F18000
G1 F1500
M204 S500
G1 X89.417 Y98.76 E.00163
G1 X89.717 Y99.125 E.00998
G1 X89.944 Y99.534 E.00992
G1 X90.054 Y99.829 E.00666
G1 X90.13 Y100.142 E.00682
G1 X90.172 Y100.601 E.00975
G1 X90.13 Y101.07 E.00997
G1 X90.004 Y101.521 E.00992
G1 X89.876 Y101.808 E.00665
G1 X89.71 Y102.085 E.00683
G1 X89.418 Y102.441 E.00975
G1 X89.066 Y102.739 E.00975
G1 X88.792 Y102.908 E.00682
G1 X88.507 Y103.041 E.00666
G1 X88.057 Y103.173 E.00992
G1 X87.589 Y103.222 E.00997
G1 X87.121 Y103.187 E.00994
G1 X86.665 Y103.069 E.00996
G1 X86.248 Y102.875 E.00975
G1 X85.978 Y102.697 E.00683
G1 X85.732 Y102.489 E.00683
G1 X85.429 Y102.142 E.00975
G1 X85.188 Y101.738 E.00995
G1 X85.026 Y101.307 E.00975
G1 X84.959 Y100.991 E.00683
G1 X84.93 Y100.67 E.00683
G1 X84.957 Y100.219 E.00956
G1 X85.024 Y99.904 E.00682
G1 X85.125 Y99.606 E.00665
G1 X85.34 Y99.19 E.00992
G1 X85.628 Y98.818 E.00996
G1 X85.97 Y98.509 E.00975
G1 X86.24 Y98.332 E.00683
G1 X86.528 Y98.187 E.00683
G1 X86.966 Y98.045 E.00975
G1 X87.423 Y97.983 E.00975
G1 X87.746 Y97.988 E.00683
G1 X88.066 Y98.031 E.00683
G1 X88.499 Y98.158 E.00955
G1 X88.791 Y98.293 E.00682
G1 X89.059 Y98.458 E.00665
G1 X89.313 Y98.672 E.00702
M204 S250
G1 X89.095 Y99.024 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X89.125 Y99.049 E.00078
G1 X89.377 Y99.356 E.00781
G1 X89.571 Y99.706 E.00788
G1 X89.662 Y99.95 E.00511
G1 X89.726 Y100.209 E.00526
G1 X89.761 Y100.601 E.00773
G1 X89.725 Y100.996 E.0078
G1 X89.618 Y101.382 E.00788
G1 X89.512 Y101.619 E.00511
G1 X89.375 Y101.849 E.00526
G1 X89.125 Y102.152 E.00773
G1 X88.825 Y102.407 E.00773
G1 X88.598 Y102.547 E.00526
G1 X88.362 Y102.657 E.00511
G1 X87.978 Y102.77 E.00788
G1 X87.583 Y102.811 E.0078
G1 X87.188 Y102.782 E.00779
G1 X86.804 Y102.682 E.0078
G1 X86.447 Y102.517 E.00773
G1 X86.224 Y102.369 E.00526
G1 X86.02 Y102.197 E.00526
G1 X85.761 Y101.9 E.00774
G1 X85.558 Y101.56 E.0078
G1 X85.42 Y101.192 E.00773
G1 X85.364 Y100.93 E.00526
G1 X85.34 Y100.664 E.00526
G1 X85.364 Y100.274 E.00768
G1 X85.419 Y100.013 E.00526
G1 X85.503 Y99.767 E.00511
G1 X85.687 Y99.411 E.00788
G1 X85.929 Y99.097 E.0078
G1 X86.222 Y98.834 E.00773
G1 X86.445 Y98.687 E.00526
G1 X86.684 Y98.567 E.00526
G1 X87.058 Y98.445 E.00773
G1 X87.448 Y98.393 E.00774
G1 X87.715 Y98.397 E.00526
G1 X87.98 Y98.433 E.00526
G1 X88.355 Y98.542 E.00767
G1 X88.597 Y98.654 E.00526
G1 X88.818 Y98.791 E.00511
G1 X89.049 Y98.985 E.00593
; WIPE_START
M204 S6000
G1 X89.125 Y99.049 E-.01891
G1 X89.377 Y99.356 E-.07542
G1 X89.571 Y99.706 E-.07615
G1 X89.662 Y99.95 E-.04936
G1 X89.726 Y100.209 E-.05079
G1 X89.761 Y100.601 E-.07471
M73 P32 R19
G1 X89.744 Y100.783 E-.03467
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X93.01 Y93.884 Z.84 F18000
G1 X95.869 Y87.844 Z.84
G1 Z.44
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X95.869 Y87.52 E.00686
G1 X96.869 Y87.52 E.02117
G1 X96.869 Y77.382 E.21459
G1 X94.582 Y77.382 E.0484
G1 X94.514 Y77.05 E.00717
G1 X94.373 Y76.788 E.00629
G1 X94.163 Y76.578 E.00629
G1 X93.901 Y76.437 E.00629
G1 X93.637 Y76.382 E.00572
G1 X81.496 Y76.382 E.25698
G1 X81.207 Y76.433 E.0062
G1 X80.929 Y76.583 E.00669
G1 X80.69 Y76.836 E.00736
G1 X80.542 Y77.181 E.00795
G1 X80.531 Y94.473 E.36601
G1 X80.615 Y94.829 E.00775
G1 X80.771 Y95.066 E.00601
G1 X80.986 Y95.258 E.0061
G1 X81.256 Y95.384 E.00629
G1 X81.505 Y95.42 E.00533
G1 X94.269 Y95.41 E.27017
G1 X94.269 Y93.096 E.04898
G1 X96.955 Y95.782 E.08039
G1 X90.931 Y95.782 E.12751
G1 X90.931 Y100.583 E.10162
G1 X90.878 Y101.191 E.01292
G1 X90.782 Y101.588 E.00865
G1 X90.643 Y101.963 E.00847
G1 X90.46 Y102.32 E.00848
G1 X90.236 Y102.652 E.00848
G1 X89.969 Y102.962 E.00866
G1 X89.52 Y103.347 E.01252
G1 X89.174 Y103.566 E.00867
G1 X88.637 Y103.801 E.01242
G1 X88.44 Y103.862 E.00436
G1 X87.841 Y103.969 E.01288
G1 X87.25 Y103.967 E.01251
G1 X86.854 Y103.908 E.00848
G1 X86.468 Y103.803 E.00848
G1 X86.096 Y103.652 E.00848
G1 X85.747 Y103.459 E.00846
G1 X85.41 Y103.216 E.00878
G1 X84.995 Y102.815 E.01222
G1 X84.747 Y102.489 E.00867
G1 X84.543 Y102.144 E.00847
G1 X84.32 Y101.597 E.01252
G1 X84.226 Y101.212 E.00837
G1 X84.176 Y100.8 E.00879
G1 X84.168 Y95.783 E.10619
G1 X81.479 Y95.778 E.05691
G1 X81.223 Y95.741 E.00548
G1 X80.931 Y95.634 E.00659
G1 X80.792 Y95.554 E.0034
G1 X80.549 Y95.349 E.00672
G1 X80.393 Y95.151 E.00533
G1 X80.317 Y95.02 E.00321
G1 X80.207 Y94.719 E.00678
G1 X80.169 Y94.383 E.00717
G1 X80.169 Y77.419 E.35905
G1 X80.207 Y77.083 E.00716
G1 X80.251 Y76.938 E.00321
G1 X80.356 Y76.712 E.00528
G1 X80.499 Y76.508 E.00526
G1 X80.602 Y76.4 E.00316
G1 X80.792 Y76.249 E.00514
G1 X81.004 Y76.135 E.00509
G1 X81.241 Y76.057 E.00528
G1 X81.39 Y76.03 E.00321
G1 X93.53 Y76.02 E.25695
G1 X93.798 Y76.044 E.00569
G1 X93.946 Y76.079 E.00322
G1 X94.239 Y76.206 E.00677
G1 X94.371 Y76.293 E.00335
G1 X94.559 Y76.461 E.00534
G1 X94.657 Y76.577 E.00321
G1 X94.948 Y77.02 E.01123
G1 X97.231 Y77.02 E.04831
G1 X97.231 Y87.52 E.22224
G1 X98.231 Y87.52 E.02117
G1 X98.231 Y87.844 E.00686
G1 X97.05 Y89.025 E.03534
G1 X95.912 Y87.887 E.03407
; WIPE_START
M204 S6000
G1 X95.869 Y87.52 E-.07014
G1 X96.869 Y87.52 E-.19
G1 X96.869 Y86.889 E-.11986
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X94.84 Y91.091 Z.84 F18000
G1 Z.44
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X94.84 Y93.088 E.03928
G1 X97.05 Y95.298 E.06147
G1 X99.26 Y93.088 E.06147
G1 X99.26 Y91.091 E.03928
G1 X98.26 Y91.091 E.01967
G1 X98.26 Y89.811 E.02518
G1 X100.24 Y89.811 E.03895
G1 X100.24 Y96.191 E.12549
G1 X91.34 Y96.191 E.17505
G1 X91.34 Y100.595 E.08662
G1 X91.314 Y101.038 E.00873
G1 X91.281 Y101.268 E.00459
G1 X91.174 Y101.708 E.00889
G1 X91.018 Y102.129 E.00883
G1 X90.813 Y102.528 E.00883
G1 X90.562 Y102.9 E.00883
G1 X90.267 Y103.243 E.00889
G1 X90.11 Y103.395 E.0043
G1 X89.759 Y103.68 E.00889
G1 X89.377 Y103.921 E.00889
G1 X89.182 Y104.021 E.0043
G1 X88.774 Y104.187 E.00866
G1 X88.549 Y104.257 E.00465
G1 X88.334 Y104.309 E.00435
G1 X87.883 Y104.376 E.00895
G1 X87.665 Y104.389 E.0043
G1 X87.214 Y104.376 E.00889
G1 X86.77 Y104.309 E.00883
G1 X86.336 Y104.191 E.00883
G1 X85.92 Y104.022 E.00883
G1 X85.527 Y103.805 E.00883
G1 X85.151 Y103.534 E.00912
G1 X84.829 Y103.239 E.0086
G1 X84.681 Y103.077 E.0043
G1 X84.407 Y102.718 E.00889
G1 X84.179 Y102.331 E.00883
G1 X83.996 Y101.918 E.00889
G1 X83.926 Y101.711 E.0043
G1 X83.823 Y101.286 E.0086
G1 X83.767 Y100.825 E.00913
G1 X83.76 Y96.191 E.09114
G1 X81.449 Y96.188 E.04544
G1 X81.134 Y96.141 E.00626
G1 X80.938 Y96.083 E.00403
G1 X80.747 Y96 E.00409
G1 X80.567 Y95.896 E.00409
G1 X80.4 Y95.772 E.00409
G1 X80.246 Y95.626 E.00418
G1 X80.053 Y95.382 E.00612
G1 X79.951 Y95.204 E.00403
G1 X79.868 Y95.013 E.0041
G1 X79.809 Y94.814 E.00409
G1 X79.772 Y94.609 E.00409
G1 X79.76 Y94.395 E.00422
G1 X79.76 Y77.407 E.33413
G1 X79.772 Y77.193 E.00422
G1 X79.809 Y76.988 E.00409
G1 X79.867 Y76.792 E.00404
G1 X80.001 Y76.506 E.0062
G1 X80.181 Y76.248 E.00619
G1 X80.325 Y76.097 E.00411
G1 X80.567 Y75.906 E.00606
G1 X80.841 Y75.758 E.00614
G1 X81.14 Y75.659 E.00619
G1 X81.342 Y75.623 E.00403
G1 X81.556 Y75.611 E.00421
G1 X93.548 Y75.611 E.23587
G1 X93.864 Y75.639 E.00623
G1 X94.063 Y75.686 E.00404
G1 X94.259 Y75.758 E.00409
G1 X94.445 Y75.851 E.00409
G1 X94.622 Y75.968 E.00417
G1 X94.854 Y76.175 E.00612
G1 X94.986 Y76.332 E.00403
G1 X95.169 Y76.611 E.00656
G1 X97.64 Y76.611 E.04861
G1 X97.64 Y87.111 E.20653
G1 X98.64 Y87.111 E.01967
G1 X98.64 Y88.014 E.01776
G1 X97.05 Y89.604 E.04423
G1 X95.46 Y88.014 E.04423
G1 X95.46 Y87.111 E.01776
G1 X96.46 Y87.111 E.01967
G1 X96.46 Y77.791 E.18332
G1 X94.16 Y77.791 E.04524
G1 X94.159 Y77.356 E.00855
G1 X94.125 Y77.191 E.00331
G1 X94.041 Y77.035 E.00349
G1 X93.916 Y76.91 E.00349
G1 X93.76 Y76.826 E.00349
G1 X93.595 Y76.792 E.00331
G1 X81.531 Y76.791 E.23728
G1 X81.343 Y76.824 E.00376
G1 X81.181 Y76.911 E.00362
G1 X81.038 Y77.064 E.00412
G1 X80.951 Y77.265 E.00431
G1 X80.94 Y94.425 E.33752
G1 X80.997 Y94.665 E.00484
G1 X81.083 Y94.796 E.0031
G1 X81.214 Y94.912 E.00343
G1 X81.374 Y94.987 E.00349
G1 X81.535 Y95.011 E.00319
G1 X93.86 Y95.001 E.24243
G1 X93.86 Y89.811 E.10209
G1 X95.84 Y89.811 E.03895
G1 X95.84 Y91.091 E.02518
G1 X94.9 Y91.091 E.01849
; WIPE_START
M204 S6000
G1 X94.84 Y93.088 E-.3796
G1 X94.842 Y93.089 E-.0004
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
M73 P32 R18
G1 X-13.0 F3000 ; move to safe pos
M400
M1004 S5 P1  ; external shutter
M400 P300
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
G1 X94.35 Y92.887
G1 Z.44
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.596522
G1 F1500
M204 S6000
G1 X94.35 Y90.886 E.05697
; WIPE_START
G1 X94.35 Y92.886 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X95.077 Y94.958 Z.84 F18000
G1 Z.44
G1 E.4 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.365752
G1 F1500
M204 S6000
G1 X95.013 Y94.995 E.00125
G1 X95.062 Y95.023 E.00095
; WIPE_START
G1 X95.013 Y94.995 E-.16436
G1 X95.077 Y94.958 E-.21564
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X99.065 Y94.958 Z.84 F18000
G1 Z.44
G1 E.4 F1800
G1 F1500
M204 S6000
G1 X99.002 Y94.995 E.00125
G1 X99.05 Y95.023 E.00095
; WIPE_START
G1 X99.002 Y94.995 E-.16436
G1 X99.065 Y94.958 E-.21564
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X99.75 Y92.887 Z.84 F18000
G1 Z.44
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.596522
G1 F1500
M204 S6000
G1 X99.75 Y90.886 E.05697
; WIPE_START
G1 X99.75 Y92.886 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X93.26 Y96.903 Z.84 F18000
G1 X90.294 Y98.739 Z.84
G1 Z.44
M73 P33 R18
G1 E.4 F1800
; LINE_WIDTH: 0.101096
G1 F1500
M204 S6000
G1 X90.062 Y98.504 E.00124
; WIPE_START
G1 X90.294 Y98.739 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X90.2 Y99.579 Z.84 F18000
G1 Z.44
G1 E.4 F1800
; LINE_WIDTH: 0.4007
G1 F1500
M204 S6000
G1 X90.45 Y99.719 E.00536
; LINE_WIDTH: 0.464273
G1 X90.488 Y99.743 E.00099
G1 X90.508 Y99.902 E.00351
; LINE_WIDTH: 0.428763
G1 X90.527 Y100.062 E.00323
; LINE_WIDTH: 0.384706
G1 X90.551 Y100.569 E.0091
; LINE_WIDTH: 0.360483
G1 X90.505 Y101.124 E.00929
G1 X90.415 Y101.476 E.00607
G1 X90.293 Y101.809 E.00593
G1 X90.131 Y102.125 E.00593
G1 X90.011 Y102.312 E.0037
G1 X89.694 Y102.693 E.00828
G1 X89.58 Y102.805 E.00268
G1 X89.299 Y103.038 E.00609
G1 X88.99 Y103.233 E.0061
G1 X88.505 Y103.441 E.0088
G1 X88.116 Y103.545 E.00673
G1 X87.648 Y103.599 E.00786
G1 X87.284 Y103.584 E.00609
G1 X86.933 Y103.533 E.00593
G1 X86.59 Y103.442 E.00593
G1 X86.053 Y103.198 E.00984
G1 X85.653 Y102.922 E.00813
G1 X85.461 Y102.747 E.00434
G1 X85.133 Y102.375 E.00828
G1 X84.854 Y101.915 E.00898
G1 X84.664 Y101.4 E.00917
G1 X84.602 Y101.142 E.00444
G1 X84.557 Y100.776 E.00615
G1 X84.567 Y100.18 E.00996
; LINE_WIDTH: 0.404498
G1 X84.587 Y99.978 E.00384
; LINE_WIDTH: 0.444381
G1 X84.605 Y99.802 E.00369
; LINE_WIDTH: 0.475631
G1 X84.653 Y99.511 E.00662
M204 S10000
G1 X84.828 Y98.783 F18000
; LINE_WIDTH: 0.0935231
G1 F1500
M204 S6000
G1 X84.85 Y98.717 E.00024
G1 X84.973 Y98.585 E.00061
; WIPE_START
G1 X84.85 Y98.717 E-.27441
G1 X84.828 Y98.783 E-.10559
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X86.705 Y96.742 Z.84 F18000
G1 Z.44
G1 E.4 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.597362
G1 F1500
M204 S6000
G1 X87.001 Y96.722 E.00848
; LINE_WIDTH: 0.563925
G1 X87.298 Y96.702 E.00798
G1 X88.189 Y96.728 E.02395
; WIPE_START
G1 X87.298 Y96.702 E-.28501
G1 X87.001 Y96.722 E-.09499
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X86.705 Y96.742 Z.84 F18000
G1 Z.44
G1 E.4 F1800
; LINE_WIDTH: 0.599369
G1 F1500
M204 S6000
G1 X86.484 Y96.725 E.00634
; LINE_WIDTH: 0.563322
G1 X86.263 Y96.707 E.00595
; LINE_WIDTH: 0.511166
G1 X86.042 Y96.689 E.00537
G1 X85.442 Y96.689 E.01452
G1 X85.443 Y97.349 E.01598
G1 X85.968 Y97.046 E.01469
; LINE_WIDTH: 0.52967
G1 X86.292 Y96.912 E.0088
; LINE_WIDTH: 0.570505
G1 X86.615 Y96.778 E.00951
; LINE_WIDTH: 0.604157
G1 X86.649 Y96.765 E.00105
; WIPE_START
G1 X86.615 Y96.778 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X89.657 Y96.688 Z.84 F18000
G1 Z.44
G1 E.4 F1800
; LINE_WIDTH: 0.512392
G1 F1500
M204 S6000
G1 X88.939 Y96.688 E.01742
; LINE_WIDTH: 0.525615
G1 X88.666 Y96.702 E.00683
; LINE_WIDTH: 0.55206
G1 X88.392 Y96.715 E.00719
; LINE_WIDTH: 0.580137
G1 X88.249 Y96.73 E.00398
; LINE_WIDTH: 0.574342
G1 X88.576 Y96.839 E.00942
; LINE_WIDTH: 0.516378
G1 X88.902 Y96.948 E.00843
G1 X89.657 Y97.338 E.02079
G1 X89.657 Y96.748 E.01445
M204 S10000
G1 X90.097 Y96.247 F18000
; LINE_WIDTH: 0.419992
G1 F1500
M204 S6000
G1 X85.002 Y96.251 E.10021
G1 X85.005 Y98.1 E.03638
G1 X85.115 Y98.158 E.00244
G1 X85.482 Y97.834 E.00962
G1 X86.188 Y97.426 E.01604
G1 X86.763 Y97.235 E.01193
G1 X87.358 Y97.151 E.01182
G1 X88.213 Y97.21 E.01685
G1 X88.779 Y97.371 E.01156
G1 X89.526 Y97.768 E.01665
G1 X89.901 Y98.088 E.00969
G1 X90.001 Y97.998 E.00264
G1 X90.097 Y98.011 E.00192
G1 X90.097 Y96.307 E.03352
; CHANGE_LAYER
; Z_HEIGHT: 0.56
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F1500
G1 X90.097 Y98.011 E-.32381
G1 X90.001 Y97.998 E-.01854
G1 X89.901 Y98.088 E-.02547
G1 X89.852 Y98.046 E-.01218
; WIPE_END
G1 E-.02 F1800
; layer num/total_layer_count: 4/49
; update layer progress
M73 L4
M991 S0 P3 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z.84 I1.034 J.643 P1  F18000
G1 X94.431 Y90.682 Z.84
G1 Z.56
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X94.269 Y90.682 E.00342
G1 X94.269 Y90.22 E.00977
G1 X95.431 Y90.22 E.02458
G1 X95.431 Y90.682 E.00977
G1 X94.491 Y90.682 E.0199
; WIPE_START
M204 S6000
G1 X94.269 Y90.682 E-.04209
G1 X94.269 Y90.22 E-.08769
G1 X95.431 Y90.22 E-.22069
G1 X95.431 Y90.376 E-.02952
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X98.669 Y90.22 Z.96 F18000
G1 Z.56
G1 E.4 F1800
G1 F1500
M204 S500
G1 X99.831 Y90.22 E.02458
G1 X99.831 Y90.682 E.00977
G1 X98.669 Y90.682 E.02458
G1 X98.669 Y90.28 E.0085
; WIPE_START
M204 S6000
G1 X99.831 Y90.22 E-.22098
G1 X99.831 Y90.682 E-.08769
G1 X99.455 Y90.682 E-.07132
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X98.638 Y94.889 Z.96 F18000
G1 Z.56
G1 E.4 F1800
G1 F1500
M204 S500
G1 X99.407 Y94.12 E.02301
G1 X99.407 Y95.357 E.02619
G1 X98.169 Y95.357 E.02619
G1 X98.595 Y94.931 E.01276
M204 S10000
G1 X98.338 Y94.589 F18000
G1 F1500
M204 S500
G1 X99.831 Y93.096 E.04469
G1 X99.831 Y95.782 E.05685
G1 X97.145 Y95.782 E.05685
G1 X98.295 Y94.631 E.03444
; WIPE_START
M204 S6000
G1 X99.71 Y93.217 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X96.569 Y87.944 Z.96 F18000
G1 Z.56
G1 E.4 F1800
G1 F1500
M204 S500
G1 X97.531 Y87.944 E.02035
G1 X97.05 Y88.425 E.01439
G1 X96.612 Y87.987 E.01312
; WIPE_START
M204 S6000
G1 X97.531 Y87.944 E-.17484
G1 X97.05 Y88.425 E-.1292
G1 X96.767 Y88.143 E-.07596
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X94.693 Y94.12 Z.96 F18000
G1 Z.56
G1 E.4 F1800
G1 F1500
M204 S500
G1 X95.931 Y95.357 E.03704
G1 X94.693 Y95.357 E.02619
G1 X94.693 Y94.18 E.02492
; WIPE_START
M204 S6000
G1 X95.931 Y95.357 E-.32452
G1 X95.639 Y95.357 E-.05549
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X89.694 Y98.449 Z.96 F18000
G1 Z.56
G1 E.4 F1800
G1 F1500
M204 S500
G1 X89.589 Y98.336 E.00327
G1 X89.152 Y98.008 E.01156
G1 X88.663 Y97.764 E.01157
G1 X88.154 Y97.615 E.01123
G1 X87.778 Y97.564 E.00804
G1 X87.413 Y97.559 E.00771
G1 X87.051 Y97.597 E.00771
G1 X86.681 Y97.681 E.00803
G1 X86.187 Y97.875 E.01124
G1 X85.722 Y98.162 E.01156
G1 X85.328 Y98.517 E.01123
G1 X85.086 Y98.811 E.00804
G1 X84.882 Y99.131 E.00804
G1 X84.799 Y99.316 E.00428
G1 X84.598 Y99.273 E.00436
G1 X84.593 Y95.842 E.07262
G1 X90.507 Y95.837 E.12517
G1 X90.507 Y99.277 E.0728
G1 X90.312 Y99.324 E.00423
G1 X90.164 Y99.039 E.0068
G1 X89.95 Y98.725 E.00804
G1 X89.735 Y98.493 E.0067
M204 S10000
G1 X89.383 Y98.738 F18000
G1 F1500
M204 S500
G1 X89.618 Y98.99 E.00729
G1 X89.799 Y99.257 E.00683
G1 X89.944 Y99.535 E.00663
G1 X90.054 Y99.829 E.00664
G1 X90.13 Y100.142 E.00683
G1 X90.172 Y100.602 E.00977
G1 X90.128 Y101.071 E.00997
G1 X90.054 Y101.374 E.0066
G1 X89.941 Y101.675 E.00682
G1 X89.716 Y102.078 E.00975
G1 X89.418 Y102.441 E.00995
G1 X89.066 Y102.739 E.00975
G1 X88.792 Y102.908 E.00682
G1 X88.509 Y103.04 E.0066
G1 X88.058 Y103.173 E.00997
G1 X87.589 Y103.222 E.00997
G1 X87.13 Y103.188 E.00975
G1 X86.816 Y103.116 E.00682
G1 X86.522 Y103.011 E.0066
G1 X86.107 Y102.79 E.00997
G1 X85.738 Y102.496 E.00997
G1 X85.429 Y102.142 E.00995
G1 X85.193 Y101.746 E.00975
G1 X85.07 Y101.448 E.00683
G1 X84.984 Y101.137 E.00683
G1 X84.929 Y100.679 E.00975
G1 X84.958 Y100.21 E.00995
G1 X85.069 Y99.754 E.00995
G1 X85.256 Y99.333 E.00976
G1 X85.43 Y99.061 E.00683
G1 X85.635 Y98.811 E.00683
G1 X85.977 Y98.503 E.00975
G1 X86.377 Y98.256 E.00995
G1 X86.806 Y98.088 E.00976
G1 X87.121 Y98.016 E.00682
G1 X87.432 Y97.983 E.00663
G1 X87.746 Y97.988 E.00664
G1 X88.066 Y98.031 E.00683
G1 X88.508 Y98.16 E.00975
G1 X88.928 Y98.371 E.00995
G1 X89.304 Y98.653 E.00995
G1 X89.342 Y98.694 E.00119
M204 S250
G1 X89.083 Y99.016 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X89.297 Y99.246 E.00618
G1 X89.447 Y99.467 E.00526
G1 X89.569 Y99.702 E.0052
G1 X89.662 Y99.949 E.0052
G1 X89.726 Y100.209 E.00526
G1 X89.761 Y100.601 E.00774
G1 X89.723 Y101.003 E.00793
G1 X89.662 Y101.252 E.00506
G1 X89.568 Y101.503 E.00526
G1 X89.377 Y101.846 E.00773
G1 X89.125 Y102.153 E.0078
G1 X88.825 Y102.407 E.00773
G1 X88.598 Y102.547 E.00526
G1 X88.364 Y102.656 E.00506
G1 X87.978 Y102.77 E.00793
G1 X87.583 Y102.811 E.0078
G1 X87.191 Y102.782 E.00773
G1 X86.93 Y102.723 E.00526
G1 X86.688 Y102.636 E.00506
G1 X86.332 Y102.446 E.00793
G1 X86.022 Y102.199 E.0078
G1 X85.761 Y101.9 E.00779
G1 X85.56 Y101.563 E.00773
G1 X85.458 Y101.315 E.00526
G1 X85.387 Y101.057 E.00526
G1 X85.34 Y100.667 E.00773
G1 X85.364 Y100.271 E.0078
G1 X85.458 Y99.886 E.00779
G1 X85.618 Y99.527 E.00774
G1 X85.762 Y99.302 E.00526
G1 X85.932 Y99.095 E.00526
G1 X86.224 Y98.832 E.00773
G1 X86.561 Y98.624 E.0078
G1 X86.927 Y98.48 E.00774
G1 X87.188 Y98.42 E.00526
G1 X87.451 Y98.393 E.0052
G1 X87.715 Y98.397 E.0052
G1 X87.98 Y98.433 E.00526
G1 X88.358 Y98.543 E.00773
G1 X88.712 Y98.72 E.0078
G1 X89.029 Y98.958 E.00779
G1 X89.042 Y98.972 E.00038
; WIPE_START
M204 S6000
G1 X89.297 Y99.246 E-.07106
G1 X89.447 Y99.467 E-.0508
G1 X89.569 Y99.702 E-.05025
G1 X89.662 Y99.949 E-.05025
G1 X89.726 Y100.209 E-.05083
G1 X89.761 Y100.601 E-.07476
G1 X89.745 Y100.769 E-.03206
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X93.013 Y93.872 Z.96 F18000
G1 X95.869 Y87.844 Z.96
G1 Z.56
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X95.869 Y87.52 E.00686
G1 X96.869 Y87.52 E.02117
G1 X96.869 Y77.382 E.21459
G1 X94.582 Y77.382 E.04842
G1 X94.514 Y77.051 E.00715
G1 X94.373 Y76.789 E.0063
G1 X94.163 Y76.578 E.0063
G1 X93.901 Y76.437 E.0063
G1 X93.637 Y76.382 E.00571
G1 X81.496 Y76.382 E.25697
G1 X81.198 Y76.434 E.0064
G1 X80.897 Y76.608 E.00737
G1 X80.687 Y76.844 E.00669
G1 X80.542 Y77.181 E.00776
G1 X80.531 Y94.474 E.36603
G1 X80.619 Y94.841 E.00798
G1 X80.797 Y95.095 E.00658
G1 X80.994 Y95.261 E.00546
G1 X81.256 Y95.384 E.00612
G1 X81.505 Y95.42 E.00534
G1 X94.269 Y95.41 E.27016
G1 X94.269 Y93.096 E.04898
G1 X96.955 Y95.782 E.08039
G1 X90.931 Y95.782 E.12751
G1 X90.931 Y100.583 E.10162
G1 X90.878 Y101.191 E.01292
G1 X90.782 Y101.588 E.00864
G1 X90.643 Y101.963 E.00847
G1 X90.46 Y102.32 E.00848
G1 X90.116 Y102.802 E.01253
G1 X89.831 Y103.095 E.00864
G1 X89.513 Y103.353 E.00867
G1 X89.19 Y103.557 E.0081
G1 X88.82 Y103.733 E.00866
G1 X88.441 Y103.861 E.00848
G1 X88.04 Y103.945 E.00867
G1 X87.659 Y103.979 E.00809
G1 X87.25 Y103.967 E.00867
G1 X86.854 Y103.908 E.00848
G1 X86.468 Y103.803 E.00848
G1 X86.097 Y103.652 E.00847
G1 X85.747 Y103.459 E.00845
G1 X85.407 Y103.213 E.00888
G1 X84.996 Y102.815 E.01212
G1 X84.747 Y102.489 E.00868
G1 X84.543 Y102.144 E.00847
G1 X84.32 Y101.597 E.01251
G1 X84.227 Y101.217 E.00828
G1 X84.176 Y100.799 E.0089
G1 X84.168 Y95.783 E.10618
G1 X81.479 Y95.778 E.05691
G1 X81.223 Y95.741 E.00548
G1 X80.931 Y95.634 E.00659
G1 X80.792 Y95.554 E.0034
G1 X80.546 Y95.348 E.00678
G1 X80.356 Y95.091 E.00676
G1 X80.251 Y94.864 E.00529
G1 X80.208 Y94.719 E.00321
G1 X80.169 Y94.383 E.00717
G1 X80.169 Y77.419 E.35905
G1 X80.206 Y77.092 E.00697
G1 X80.284 Y76.855 E.00528
G1 X80.403 Y76.635 E.00528
G1 X80.488 Y76.521 E.00301
G1 X80.67 Y76.339 E.00544
G1 X80.791 Y76.249 E.0032
G1 X81.012 Y76.131 E.00529
G1 X81.146 Y76.082 E.00302
G1 X81.399 Y76.03 E.00547
G1 X93.532 Y76.02 E.25681
G1 X93.798 Y76.044 E.00565
G1 X93.946 Y76.079 E.00322
G1 X94.097 Y76.134 E.0034
G1 X94.374 Y76.294 E.00678
G1 X94.601 Y76.507 E.00659
G1 X94.96 Y77.02 E.01325
G1 X97.231 Y77.02 E.04807
G1 X97.231 Y87.52 E.22224
G1 X98.231 Y87.52 E.02117
G1 X98.231 Y87.844 E.00686
G1 X97.05 Y89.025 E.03534
G1 X95.912 Y87.887 E.03407
; WIPE_START
M204 S6000
G1 X95.869 Y87.52 E-.07014
G1 X96.869 Y87.52 E-.19
G1 X96.869 Y86.889 E-.11986
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X94.84 Y91.091 Z.96 F18000
G1 Z.56
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X94.84 Y93.088 E.03928
G1 X97.05 Y95.298 E.06147
G1 X99.26 Y93.088 E.06147
G1 X99.26 Y91.091 E.03928
G1 X98.26 Y91.091 E.01967
G1 X98.26 Y89.811 E.02518
G1 X100.24 Y89.811 E.03895
G1 X100.24 Y96.191 E.12549
G1 X91.34 Y96.191 E.17505
G1 X91.34 Y100.595 E.08662
G1 X91.315 Y101.033 E.00864
G1 X91.281 Y101.269 E.00468
G1 X91.174 Y101.708 E.00888
G1 X91.018 Y102.129 E.00883
G1 X90.813 Y102.528 E.00884
G1 X90.572 Y102.887 E.00851
G1 X90.423 Y103.073 E.00468
G1 X90.108 Y103.397 E.00888
G1 X89.757 Y103.682 E.00889
G1 X89.573 Y103.806 E.00436
G1 X89.382 Y103.918 E.00436
G1 X88.974 Y104.113 E.00889
G1 X88.549 Y104.257 E.00883
G1 X88.107 Y104.35 E.00889
G1 X87.886 Y104.376 E.00436
G1 X87.665 Y104.389 E.00436
G1 X87.214 Y104.376 E.00889
G1 X86.77 Y104.309 E.00883
G1 X86.336 Y104.191 E.00884
G1 X85.92 Y104.022 E.00883
G1 X85.527 Y103.805 E.00883
G1 X85.148 Y103.531 E.00921
G1 X84.829 Y103.238 E.00851
G1 X84.681 Y103.077 E.00429
G1 X84.407 Y102.718 E.0089
G1 X84.178 Y102.331 E.00883
G1 X83.996 Y101.917 E.00889
G1 X83.926 Y101.711 E.00429
G1 X83.824 Y101.29 E.00852
G1 X83.767 Y100.825 E.00922
G1 X83.76 Y96.191 E.09114
G1 X81.449 Y96.188 E.04545
G1 X81.134 Y96.141 E.00626
M73 P34 R18
G1 X80.938 Y96.083 E.00403
G1 X80.747 Y96 E.00409
G1 X80.567 Y95.896 E.0041
G1 X80.4 Y95.772 E.00409
G1 X80.248 Y95.629 E.00409
G1 X80.115 Y95.47 E.00409
G1 X79.997 Y95.29 E.00422
G1 X79.867 Y95.01 E.00607
G1 X79.809 Y94.814 E.00403
G1 X79.772 Y94.609 E.0041
G1 X79.76 Y94.395 E.00421
G1 X79.76 Y77.407 E.33413
G1 X79.772 Y77.193 E.00422
G1 X79.808 Y76.991 E.00403
G1 X79.907 Y76.692 E.00619
G1 X80.057 Y76.415 E.0062
G1 X80.177 Y76.253 E.00397
G1 X80.402 Y76.028 E.00625
G1 X80.572 Y75.903 E.00416
G1 X80.844 Y75.757 E.00607
G1 X81.034 Y75.687 E.00398
G1 X81.345 Y75.623 E.00626
G1 X81.556 Y75.611 E.00415
G1 X93.55 Y75.611 E.23591
G1 X93.864 Y75.639 E.00619
G1 X94.063 Y75.686 E.00404
G1 X94.259 Y75.758 E.00409
G1 X94.445 Y75.851 E.00409
G1 X94.619 Y75.965 E.00409
G1 X94.778 Y76.099 E.00409
G1 X94.919 Y76.248 E.00403
G1 X95.173 Y76.611 E.00871
G1 X97.64 Y76.611 E.04853
G1 X97.64 Y87.111 E.20653
G1 X98.64 Y87.111 E.01967
G1 X98.64 Y88.014 E.01776
G1 X97.05 Y89.604 E.04423
G1 X95.46 Y88.014 E.04423
G1 X95.46 Y87.111 E.01776
G1 X96.46 Y87.111 E.01967
G1 X96.46 Y77.791 E.18332
G1 X94.16 Y77.791 E.04524
G1 X94.159 Y77.358 E.00851
G1 X94.125 Y77.192 E.00334
G1 X94.041 Y77.036 E.00349
G1 X93.916 Y76.91 E.00349
G1 X93.759 Y76.826 E.00349
G1 X93.595 Y76.792 E.0033
G1 X81.532 Y76.791 E.23727
G1 X81.34 Y76.825 E.00382
G1 X81.159 Y76.93 E.00413
G1 X81.036 Y77.067 E.00362
G1 X80.951 Y77.265 E.00425
G1 X80.94 Y94.426 E.33753
G1 X80.998 Y94.67 E.00494
G1 X81.101 Y94.817 E.00353
G1 X81.216 Y94.914 E.00295
G1 X81.374 Y94.987 E.00344
G1 X81.535 Y95.011 E.00319
G1 X93.86 Y95.001 E.24242
G1 X93.86 Y89.811 E.10209
G1 X95.84 Y89.811 E.03895
G1 X95.84 Y91.091 E.02518
G1 X94.9 Y91.091 E.01849
; WIPE_START
M204 S6000
G1 X94.84 Y93.088 E-.3796
G1 X94.842 Y93.089 E-.0004
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




G1 X94.35 Y92.887
G1 Z.56
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.596522
G1 F1500
M204 S6000
G1 X94.35 Y90.886 E.05697
; WIPE_START
G1 X94.35 Y92.886 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X95.077 Y94.958 Z.96 F18000
G1 Z.56
G1 E.4 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.365752
G1 F1500
M204 S6000
G1 X95.013 Y94.995 E.00125
G1 X95.062 Y95.023 E.00095
; WIPE_START
G1 X95.013 Y94.995 E-.16436
G1 X95.077 Y94.958 E-.21564
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X99.065 Y94.958 Z.96 F18000
G1 Z.56
G1 E.4 F1800
G1 F1500
M204 S6000
G1 X99.002 Y94.995 E.00125
G1 X99.05 Y95.023 E.00095
; WIPE_START
G1 X99.002 Y94.995 E-.16436
G1 X99.065 Y94.958 E-.21564
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X99.75 Y92.887 Z.96 F18000
G1 Z.56
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.596522
G1 F1500
M204 S6000
G1 X99.75 Y90.886 E.05697
; WIPE_START
G1 X99.75 Y92.886 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X93.25 Y96.886 Z.96 F18000
G1 X90.294 Y98.704 Z.96
G1 Z.56
G1 E.4 F1800
; LINE_WIDTH: 0.14471
G1 F1500
M204 S6000
G1 X90.154 Y98.558 E.00121
; LINE_WIDTH: 0.10361
G1 X89.936 Y98.362 E.00114
; WIPE_START
G1 X90.154 Y98.558 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X90.197 Y99.571 Z.96 F18000
G1 Z.56
G1 E.4 F1800
; LINE_WIDTH: 0.411638
G1 F1500
M204 S6000
G1 X90.455 Y99.718 E.00572
; LINE_WIDTH: 0.466605
G1 X90.488 Y99.738 E.00084
G1 X90.507 Y99.9 E.00359
; LINE_WIDTH: 0.429072
G1 X90.527 Y100.062 E.00329
; LINE_WIDTH: 0.384687
G1 X90.551 Y100.57 E.00911
; LINE_WIDTH: 0.360965
G1 X90.504 Y101.124 E.0093
G1 X90.419 Y101.477 E.00607
G1 X90.295 Y101.81 E.00594
G1 X90.019 Y102.302 E.00943
G1 X89.694 Y102.693 E.0085
G1 X89.57 Y102.813 E.00288
G1 X89.289 Y103.046 E.0061
G1 X89.009 Y103.222 E.00554
G1 X88.632 Y103.398 E.00696
G1 X88.339 Y103.49 E.00513
G1 X87.98 Y103.566 E.00614
G1 X87.61 Y103.6 E.00622
G1 X87.284 Y103.584 E.00545
G1 X86.933 Y103.534 E.00594
G1 X86.59 Y103.441 E.00594
G1 X86.261 Y103.306 E.00594
G1 X85.951 Y103.137 E.00591
G1 X85.491 Y102.776 E.00979
G1 X85.133 Y102.375 E.00898
G1 X84.85 Y101.904 E.00919
G1 X84.736 Y101.636 E.00487
G1 X84.618 Y101.221 E.00721
G1 X84.553 Y100.705 E.0087
G1 X84.57 Y100.135 E.00954
; LINE_WIDTH: 0.415095
G1 X84.608 Y99.818 E.00621
; LINE_WIDTH: 0.464044
G1 X84.646 Y99.5 E.00699
M204 S10000
G1 X84.829 Y98.784 F18000
; LINE_WIDTH: 0.0941649
G1 F1500
M204 S6000
G1 X84.85 Y98.717 E.00024
G1 X84.942 Y98.612 E.00048
; WIPE_START
G1 X84.85 Y98.717 E-.25272
G1 X84.829 Y98.784 E-.12728
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X86.702 Y96.753 Z.96 F18000
G1 Z.56
G1 E.4 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.614327
G1 F1500
M204 S6000
G1 X86.999 Y96.728 E.00875
; LINE_WIDTH: 0.567196
G1 X87.296 Y96.704 E.00805
G1 X88.19 Y96.728 E.02416
; WIPE_START
G1 X87.296 Y96.704 E-.28505
G1 X86.999 Y96.728 E-.09495
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X86.702 Y96.753 Z.96 F18000
G1 Z.56
G1 E.4 F1800
; LINE_WIDTH: 0.617135
G1 F1500
M204 S6000
G1 X86.636 Y96.731 E.00206
; LINE_WIDTH: 0.57362
G1 X86.57 Y96.71 E.0019
; LINE_WIDTH: 0.530105
G1 X86.504 Y96.688 E.00175
; LINE_WIDTH: 0.48659
G1 X86.438 Y96.666 E.0016
; LINE_WIDTH: 0.443075
G1 X86.371 Y96.645 E.00145
; LINE_WIDTH: 0.39956
G1 X86.305 Y96.623 E.0013
; LINE_WIDTH: 0.402465
G1 X86.044 Y96.648 E.00493
; LINE_WIDTH: 0.45179
G1 X85.783 Y96.673 E.00558
; LINE_WIDTH: 0.49365
G1 X85.438 Y96.685 E.00806
G1 X85.439 Y97.346 E.01542
G1 X85.865 Y97.108 E.0114
; LINE_WIDTH: 0.45179
G1 X86.117 Y97.035 E.00558
; LINE_WIDTH: 0.402465
G1 X86.37 Y96.963 E.00493
; LINE_WIDTH: 0.39956
G1 X86.417 Y96.933 E.00104
; LINE_WIDTH: 0.443075
G1 X86.464 Y96.904 E.00116
; LINE_WIDTH: 0.48659
G1 X86.511 Y96.874 E.00128
; LINE_WIDTH: 0.530105
G1 X86.558 Y96.844 E.0014
; LINE_WIDTH: 0.57362
G1 X86.605 Y96.815 E.00152
; LINE_WIDTH: 0.617135
G1 X86.652 Y96.785 E.00164
; WIPE_START
G1 X86.605 Y96.815 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X89.66 Y96.685 Z.96 F18000
G1 Z.56
G1 E.4 F1800
; LINE_WIDTH: 0.506992
G1 F1500
M204 S6000
G1 X88.958 Y96.685 E.01685
; LINE_WIDTH: 0.521147
G1 X88.675 Y96.7 E.007
; LINE_WIDTH: 0.549457
G1 X88.392 Y96.714 E.0074
; LINE_WIDTH: 0.579352
G1 X88.25 Y96.73 E.00396
; LINE_WIDTH: 0.573067
G1 X88.585 Y96.843 E.00965
; LINE_WIDTH: 0.511426
G1 X88.919 Y96.956 E.00856
G1 X89.656 Y97.323 E.01994
G1 X89.66 Y96.745 E.01401
M204 S10000
G1 X90.097 Y96.247 F18000
; LINE_WIDTH: 0.419992
G1 F1500
M204 S6000
G1 X85.002 Y96.251 E.10021
G1 X85.005 Y98.135 E.03706
G1 X85.081 Y98.189 E.00182
G1 X85.462 Y97.845 E.01009
G1 X85.988 Y97.517 E.01219
G1 X86.506 Y97.31 E.01097
G1 X87.371 Y97.152 E.0173
G1 X88.213 Y97.21 E.0166
G1 X88.797 Y97.376 E.01193
G1 X89.352 Y97.651 E.01219
G1 X89.751 Y97.956 E.00987
G1 X89.881 Y97.841 E.00342
G1 X90.097 Y97.872 E.00429
G1 X90.097 Y96.307 E.03079
; CHANGE_LAYER
; Z_HEIGHT: 0.68
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F1500
G1 X90.097 Y97.872 E-.29747
G1 X89.881 Y97.841 E-.04145
G1 X89.751 Y97.956 E-.03308
G1 X89.717 Y97.93 E-.008
; WIPE_END
G1 E-.02 F1800
; layer num/total_layer_count: 5/49
; update layer progress
M73 L5
M991 S0 P4 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z.96 I1.02 J.663 P1  F18000
G1 X94.431 Y90.682 Z.96
G1 Z.68
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X94.269 Y90.682 E.00342
G1 X94.269 Y90.22 E.00977
G1 X95.431 Y90.22 E.02458
G1 X95.431 Y90.682 E.00977
G1 X94.491 Y90.682 E.0199
; WIPE_START
M204 S6000
G1 X94.269 Y90.682 E-.04209
G1 X94.269 Y90.22 E-.08769
G1 X95.431 Y90.22 E-.22069
G1 X95.431 Y90.376 E-.02952
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X98.669 Y90.22 Z1.08 F18000
G1 Z.68
G1 E.4 F1800
G1 F1500
M204 S500
G1 X99.831 Y90.22 E.02458
G1 X99.831 Y90.682 E.00977
G1 X98.669 Y90.682 E.02458
G1 X98.669 Y90.28 E.0085
; WIPE_START
M204 S6000
G1 X99.831 Y90.22 E-.22098
G1 X99.831 Y90.682 E-.08769
G1 X99.455 Y90.682 E-.07132
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X98.638 Y94.889 Z1.08 F18000
G1 Z.68
G1 E.4 F1800
G1 F1500
M204 S500
G1 X99.407 Y94.12 E.02301
G1 X99.407 Y95.357 E.02619
G1 X98.169 Y95.357 E.02619
G1 X98.595 Y94.931 E.01276
M204 S10000
G1 X98.338 Y94.589 F18000
G1 F1500
M204 S500
G1 X99.831 Y93.096 E.04469
G1 X99.831 Y95.782 E.05685
G1 X97.145 Y95.782 E.05685
G1 X98.295 Y94.631 E.03444
; WIPE_START
M204 S6000
G1 X99.71 Y93.217 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X96.569 Y87.944 Z1.08 F18000
G1 Z.68
G1 E.4 F1800
G1 F1500
M204 S500
G1 X97.531 Y87.944 E.02035
G1 X97.05 Y88.425 E.01439
G1 X96.612 Y87.987 E.01312
; WIPE_START
M204 S6000
G1 X97.531 Y87.944 E-.17484
G1 X97.05 Y88.425 E-.1292
G1 X96.767 Y88.143 E-.07596
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X94.693 Y94.12 Z1.08 F18000
G1 Z.68
G1 E.4 F1800
G1 F1500
M204 S500
G1 X95.931 Y95.357 E.03704
G1 X94.693 Y95.357 E.02619
G1 X94.693 Y94.18 E.02492
; WIPE_START
M204 S6000
G1 X95.931 Y95.357 E-.32452
G1 X95.639 Y95.357 E-.05549
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X89.689 Y98.444 Z1.08 F18000
G1 Z.68
G1 E.4 F1800
G1 F1500
M204 S500
G1 X89.589 Y98.336 E.00311
G1 X89.152 Y98.008 E.01157
G1 X88.663 Y97.764 E.01157
G1 X88.154 Y97.615 E.01123
G1 X87.778 Y97.564 E.00804
G1 X87.398 Y97.558 E.00804
G1 X86.872 Y97.63 E.01123
G1 X86.367 Y97.794 E.01123
G1 X86.028 Y97.963 E.00803
G1 X85.723 Y98.164 E.00774
G1 X85.329 Y98.516 E.01118
G1 X85.086 Y98.811 E.00808
G1 X84.882 Y99.131 E.00804
G1 X84.799 Y99.316 E.00429
G1 X84.598 Y99.273 E.00436
G1 X84.593 Y95.842 E.07262
G1 X90.507 Y95.837 E.12517
G1 X90.507 Y99.276 E.07279
G1 X90.313 Y99.324 E.00423
G1 X90.164 Y99.038 E.00681
G1 X89.95 Y98.725 E.00802
G1 X89.73 Y98.488 E.00685
M204 S10000
G1 X89.378 Y98.732 F18000
G1 F1500
M204 S500
G1 X89.618 Y98.99 E.00745
G1 X89.799 Y99.257 E.00682
G1 X89.938 Y99.522 E.00634
G1 X90.054 Y99.827 E.00691
G1 X90.13 Y100.142 E.00686
G1 X90.172 Y100.601 E.00975
G1 X90.13 Y101.07 E.00997
G1 X90.002 Y101.526 E.01002
G1 X89.876 Y101.808 E.00654
G1 X89.71 Y102.085 E.00682
G1 X89.418 Y102.441 E.00975
G1 X89.066 Y102.739 E.00975
G1 X88.792 Y102.908 E.00682
G1 X88.512 Y103.038 E.00654
G1 X88.058 Y103.173 E.01002
G1 X87.589 Y103.222 E.00998
G1 X87.13 Y103.188 E.00975
G1 X86.816 Y103.116 E.00682
G1 X86.524 Y103.012 E.00654
G1 X86.107 Y102.79 E.01002
G1 X85.738 Y102.496 E.00998
G1 X85.429 Y102.142 E.00995
G1 X85.188 Y101.738 E.00995
G1 X85.026 Y101.307 E.00975
G1 X84.959 Y100.991 E.00683
G1 X84.93 Y100.67 E.00683
G1 X84.958 Y100.21 E.00975
G1 X85.069 Y99.754 E.00995
G1 X85.256 Y99.332 E.00976
G1 X85.43 Y99.061 E.00683
G1 X85.636 Y98.811 E.00685
G1 X85.982 Y98.501 E.00983
G1 X86.24 Y98.331 E.00654
G1 X86.529 Y98.187 E.00682
G1 X86.966 Y98.045 E.00975
G1 X87.423 Y97.983 E.00975
G1 X87.746 Y97.988 E.00683
G1 X88.066 Y98.031 E.00683
G1 X88.508 Y98.16 E.00975
G1 X88.928 Y98.371 E.00995
G1 X89.304 Y98.653 E.00995
G1 X89.337 Y98.688 E.00103
M204 S250
G1 X89.078 Y99.011 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X89.297 Y99.246 E.00632
G1 X89.447 Y99.467 E.00526
G1 X89.564 Y99.69 E.00495
G1 X89.662 Y99.949 E.00545
G1 X89.726 Y100.209 E.00527
G1 X89.761 Y100.601 E.00773
G1 X89.725 Y100.996 E.0078
G1 X89.616 Y101.387 E.00798
G1 X89.512 Y101.619 E.00501
G1 X89.375 Y101.849 E.00526
G1 X89.125 Y102.152 E.00773
G1 X88.825 Y102.407 E.00773
G1 X88.598 Y102.547 E.00526
G1 X88.367 Y102.655 E.00501
G1 X87.978 Y102.77 E.00798
G1 X87.583 Y102.811 E.00781
G1 X87.191 Y102.782 E.00773
G1 X86.93 Y102.723 E.00526
G1 X86.69 Y102.637 E.00501
G1 X86.332 Y102.446 E.00798
G1 X86.022 Y102.199 E.00781
G1 X85.761 Y101.9 E.0078
G1 X85.558 Y101.56 E.0078
G1 X85.42 Y101.192 E.00774
G1 X85.364 Y100.93 E.00526
G1 X85.34 Y100.664 E.00526
G1 X85.364 Y100.271 E.00774
G1 X85.458 Y99.886 E.00779
G1 X85.618 Y99.527 E.00774
G1 X85.762 Y99.302 E.00526
G1 X85.932 Y99.095 E.00527
G1 X86.232 Y98.827 E.00792
G1 X86.445 Y98.687 E.00501
G1 X86.684 Y98.567 E.00526
G1 X87.058 Y98.445 E.00773
G1 X87.448 Y98.393 E.00774
G1 X87.715 Y98.397 E.00526
G1 X87.98 Y98.433 E.00526
G1 X88.358 Y98.543 E.00773
G1 X88.712 Y98.72 E.0078
G1 X89.029 Y98.958 E.0078
G1 X89.037 Y98.967 E.00023
; WIPE_START
M204 S6000
G1 X89.297 Y99.246 E-.07244
G1 X89.447 Y99.467 E-.05079
G1 X89.564 Y99.69 E-.04779
G1 X89.662 Y99.949 E-.05264
G1 X89.726 Y100.209 E-.0509
G1 X89.761 Y100.601 E-.07469
G1 X89.746 Y100.762 E-.03074
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X93.015 Y93.865 Z1.08 F18000
G1 X95.869 Y87.844 Z1.08
G1 Z.68
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X95.869 Y87.52 E.00686
G1 X96.869 Y87.52 E.02117
G1 X96.869 Y77.382 E.21459
G1 X94.582 Y77.382 E.04842
G1 X94.514 Y77.051 E.00715
G1 X94.373 Y76.788 E.00632
G1 X94.162 Y76.578 E.00629
G1 X93.901 Y76.437 E.00629
G1 X93.637 Y76.382 E.00571
G1 X81.496 Y76.382 E.25697
G1 X81.206 Y76.433 E.00623
G1 X80.926 Y76.585 E.00675
G1 X80.69 Y76.836 E.00729
G1 X80.542 Y77.181 E.00793
G1 X80.531 Y94.437 E.36524
G1 X80.555 Y94.646 E.00446
G1 X80.672 Y94.94 E.00669
G1 X80.961 Y95.246 E.00892
G1 X81.256 Y95.384 E.00689
G1 X81.505 Y95.42 E.00533
G1 X94.269 Y95.41 E.27016
G1 X94.269 Y93.096 E.04898
G1 X96.955 Y95.782 E.08039
G1 X90.931 Y95.782 E.12751
G1 X90.931 Y100.583 E.10162
G1 X90.878 Y101.191 E.01293
G1 X90.782 Y101.588 E.00864
G1 X90.643 Y101.963 E.00847
G1 X90.456 Y102.328 E.00868
G1 X90.11 Y102.808 E.01252
G1 X89.679 Y103.227 E.01273
G1 X89.182 Y103.561 E.01267
G1 X88.82 Y103.733 E.00848
G1 X88.255 Y103.907 E.01251
G1 X87.659 Y103.979 E.01271
G1 X87.25 Y103.967 E.00867
G1 X86.854 Y103.908 E.00847
G1 X86.468 Y103.803 E.00848
G1 X86.097 Y103.652 E.00847
G1 X85.746 Y103.459 E.00848
G1 X85.421 Y103.225 E.00848
G1 X85.125 Y102.955 E.00848
G1 X84.752 Y102.497 E.01251
G1 X84.543 Y102.144 E.00867
G1 X84.32 Y101.597 E.01252
G1 X84.228 Y101.221 E.00819
M73 P35 R18
G1 X84.176 Y100.799 E.00899
G1 X84.168 Y95.783 E.10618
G1 X81.479 Y95.778 E.05691
G1 X81.223 Y95.741 E.00548
G1 X80.931 Y95.634 E.00659
G1 X80.792 Y95.554 E.00339
G1 X80.546 Y95.348 E.00678
G1 X80.355 Y95.089 E.0068
G1 X80.251 Y94.865 E.00524
G1 X80.207 Y94.719 E.00322
G1 X80.169 Y94.383 E.00716
G1 X80.169 Y77.419 E.35905
G1 X80.206 Y77.092 E.00697
G1 X80.284 Y76.855 E.00528
G1 X80.398 Y76.643 E.00509
G1 X80.553 Y76.448 E.00528
G1 X80.663 Y76.344 E.00321
G1 X80.785 Y76.254 E.0032
G1 X81.004 Y76.135 E.00528
G1 X81.241 Y76.057 E.00528
G1 X81.39 Y76.03 E.00321
G1 X93.534 Y76.02 E.25705
G1 X93.798 Y76.044 E.0056
G1 X93.946 Y76.079 E.00322
G1 X94.239 Y76.206 E.00676
G1 X94.374 Y76.295 E.00344
G1 X94.559 Y76.461 E.00524
G1 X94.657 Y76.577 E.00322
G1 X94.948 Y77.02 E.01123
G1 X97.231 Y77.02 E.04831
G1 X97.231 Y87.52 E.22224
G1 X98.231 Y87.52 E.02117
G1 X98.231 Y87.844 E.00686
G1 X97.05 Y89.025 E.03534
G1 X95.912 Y87.887 E.03407
; WIPE_START
M204 S6000
G1 X95.869 Y87.52 E-.07014
G1 X96.869 Y87.52 E-.19
G1 X96.869 Y86.889 E-.11986
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X94.84 Y91.091 Z1.08 F18000
G1 Z.68
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X94.84 Y93.088 E.03928
G1 X97.05 Y95.298 E.06147
G1 X99.26 Y93.088 E.06147
G1 X99.26 Y91.091 E.03928
G1 X98.26 Y91.091 E.01967
G1 X98.26 Y89.811 E.02518
G1 X100.24 Y89.811 E.03895
G1 X100.24 Y96.191 E.12549
G1 X91.34 Y96.191 E.17505
G1 X91.34 Y100.595 E.08662
G1 X91.315 Y101.029 E.00855
G1 X91.28 Y101.269 E.00477
G1 X91.174 Y101.708 E.00888
G1 X91.018 Y102.128 E.00883
G1 X90.812 Y102.531 E.0089
G1 X90.695 Y102.716 E.00429
G1 X90.421 Y103.075 E.00889
G1 X90.123 Y103.383 E.00842
G1 X89.938 Y103.544 E.00483
G1 X89.762 Y103.678 E.00435
G1 X89.38 Y103.92 E.00889
G1 X88.974 Y104.113 E.00883
G1 X88.546 Y104.258 E.00889
G1 X88.334 Y104.309 E.00429
G1 X87.883 Y104.376 E.00896
G1 X87.665 Y104.389 E.00429
G1 X87.214 Y104.376 E.00889
G1 X86.77 Y104.309 E.00883
G1 X86.336 Y104.191 E.00883
G1 X85.92 Y104.022 E.00883
G1 X85.527 Y103.805 E.00883
G1 X85.162 Y103.544 E.00883
G1 X84.831 Y103.24 E.00883
G1 X84.536 Y102.898 E.00889
G1 X84.408 Y102.721 E.0043
G1 X84.179 Y102.331 E.0089
G1 X83.996 Y101.917 E.00889
G1 X83.926 Y101.711 E.00429
G1 X83.825 Y101.295 E.00842
G1 X83.767 Y100.825 E.00931
G1 X83.76 Y96.191 E.09114
G1 X81.449 Y96.188 E.04545
G1 X81.134 Y96.141 E.00626
G1 X80.938 Y96.083 E.00403
G1 X80.747 Y96 E.00409
G1 X80.567 Y95.896 E.00409
G1 X80.4 Y95.772 E.0041
G1 X80.248 Y95.629 E.00409
G1 X80.115 Y95.47 E.00409
G1 X79.996 Y95.288 E.00426
G1 X79.867 Y95.01 E.00603
G1 X79.809 Y94.814 E.00404
G1 X79.772 Y94.608 E.0041
G1 X79.76 Y94.395 E.00421
G1 X79.76 Y77.407 E.33413
G1 X79.772 Y77.193 E.00422
G1 X79.808 Y76.991 E.00403
G1 X79.907 Y76.692 E.00619
G1 X80.055 Y76.418 E.00614
G1 X80.25 Y76.171 E.00619
G1 X80.4 Y76.03 E.00403
G1 X80.564 Y75.908 E.00403
G1 X80.841 Y75.758 E.0062
G1 X81.14 Y75.659 E.00619
G1 X81.342 Y75.623 E.00403
G1 X81.556 Y75.611 E.00422
G1 X93.553 Y75.611 E.23596
G1 X93.864 Y75.639 E.00614
G1 X94.063 Y75.686 E.00404
G1 X94.259 Y75.758 E.00409
G1 X94.445 Y75.851 E.00409
G1 X94.625 Y75.971 E.00426
G1 X94.854 Y76.175 E.00603
G1 X94.986 Y76.332 E.00404
G1 X95.169 Y76.611 E.00656
G1 X97.64 Y76.611 E.04861
G1 X97.64 Y87.111 E.20653
G1 X98.64 Y87.111 E.01967
G1 X98.64 Y88.014 E.01776
G1 X97.05 Y89.604 E.04423
G1 X95.46 Y88.014 E.04423
G1 X95.46 Y87.111 E.01776
G1 X96.46 Y87.111 E.01967
G1 X96.46 Y77.791 E.18332
G1 X94.16 Y77.791 E.04524
G1 X94.159 Y77.359 E.0085
G1 X94.125 Y77.192 E.00335
G1 X94.041 Y77.035 E.0035
G1 X93.915 Y76.91 E.00349
G1 X93.759 Y76.826 E.00349
G1 X93.595 Y76.792 E.00331
G1 X81.532 Y76.791 E.23727
G1 X81.343 Y76.824 E.00377
G1 X81.179 Y76.913 E.00367
G1 X81.037 Y77.064 E.00407
G1 X80.951 Y77.265 E.0043
G1 X80.94 Y94.413 E.33728
G1 X80.955 Y94.545 E.00261
G1 X81.023 Y94.716 E.00362
G1 X81.205 Y94.908 E.0052
G1 X81.375 Y94.987 E.00368
G1 X81.535 Y95.011 E.00319
G1 X93.86 Y95.001 E.24243
G1 X93.86 Y89.811 E.10209
G1 X95.84 Y89.811 E.03895
G1 X95.84 Y91.091 E.02518
G1 X94.9 Y91.091 E.01849
; WIPE_START
M204 S6000
G1 X94.84 Y93.088 E-.3796
G1 X94.842 Y93.089 E-.0004
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




G1 X94.35 Y92.887
G1 Z.68
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.596522
G1 F1500
M204 S6000
G1 X94.35 Y90.886 E.05697
; WIPE_START
G1 X94.35 Y92.886 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X95.077 Y94.958 Z1.08 F18000
G1 Z.68
G1 E.4 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.365752
G1 F1500
M204 S6000
G1 X95.013 Y94.995 E.00125
G1 X95.062 Y95.023 E.00095
; WIPE_START
G1 X95.013 Y94.995 E-.16436
G1 X95.077 Y94.958 E-.21564
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X99.065 Y94.958 Z1.08 F18000
G1 Z.68
G1 E.4 F1800
G1 F1500
M204 S6000
G1 X99.002 Y94.995 E.00125
G1 X99.05 Y95.023 E.00095
; WIPE_START
G1 X99.002 Y94.995 E-.16436
G1 X99.065 Y94.958 E-.21564
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X99.75 Y92.887 Z1.08 F18000
G1 Z.68
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.596522
G1 F1500
M204 S6000
G1 X99.75 Y90.886 E.05697
; WIPE_START
G1 X99.75 Y92.886 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X93.25 Y96.886 Z1.08 F18000
G1 X90.294 Y98.704 Z1.08
G1 Z.68
G1 E.4 F1800
; LINE_WIDTH: 0.144676
G1 F1500
M204 S6000
G1 X90.154 Y98.558 E.00121
; LINE_WIDTH: 0.103581
G1 X89.936 Y98.362 E.00114
; WIPE_START
G1 X90.154 Y98.558 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X90.196 Y99.571 Z1.08 F18000
G1 Z.68
G1 E.4 F1800
; LINE_WIDTH: 0.408779
G1 F1500
M204 S6000
G1 X90.454 Y99.716 E.00565
; LINE_WIDTH: 0.466416
G1 X90.488 Y99.737 E.00088
G1 X90.507 Y99.899 E.00359
; LINE_WIDTH: 0.429102
G1 X90.527 Y100.062 E.00329
; LINE_WIDTH: 0.384692
G1 X90.551 Y100.57 E.0091
; LINE_WIDTH: 0.360057
G1 X90.505 Y101.125 E.00929
G1 X90.415 Y101.476 E.00604
G1 X90.294 Y101.807 E.00588
G1 X90.027 Y102.293 E.00925
G1 X89.673 Y102.713 E.00916
G1 X89.276 Y103.048 E.00867
G1 X88.996 Y103.228 E.00556
G1 X88.657 Y103.388 E.00624
G1 X88.117 Y103.545 E.00939
G1 X87.648 Y103.599 E.00786
G1 X87.284 Y103.584 E.00608
G1 X86.933 Y103.534 E.00592
G1 X86.59 Y103.441 E.00593
G1 X86.261 Y103.306 E.00592
G1 X85.949 Y103.137 E.00592
G1 X85.489 Y102.778 E.00973
G1 X85.161 Y102.413 E.00818
G1 X84.854 Y101.915 E.00975
G1 X84.664 Y101.4 E.00916
G1 X84.603 Y101.15 E.00429
G1 X84.557 Y100.775 E.00629
G1 X84.57 Y100.135 E.01068
; LINE_WIDTH: 0.41511
G1 X84.608 Y99.818 E.00621
; LINE_WIDTH: 0.464049
G1 X84.646 Y99.5 E.00699
M204 S10000
G1 X84.829 Y98.784 F18000
; LINE_WIDTH: 0.0951019
G1 F1500
M204 S6000
G1 X84.851 Y98.714 E.00025
G1 X84.95 Y98.604 E.00051
; WIPE_START
G1 X84.851 Y98.714 E-.25475
G1 X84.829 Y98.784 E-.12525
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X86.705 Y96.742 Z1.08 F18000
G1 Z.68
G1 E.4 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.597347
G1 F1500
M204 S6000
G1 X87.001 Y96.722 E.00848
; LINE_WIDTH: 0.563924
G1 X87.298 Y96.702 E.00798
G1 X88.189 Y96.728 E.02394
; WIPE_START
G1 X87.298 Y96.702 E-.28501
G1 X87.001 Y96.722 E-.09499
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X86.705 Y96.742 Z1.08 F18000
G1 Z.68
G1 E.4 F1800
; LINE_WIDTH: 0.599327
G1 F1500
M204 S6000
G1 X86.484 Y96.725 E.00634
; LINE_WIDTH: 0.563237
G1 X86.263 Y96.707 E.00594
; LINE_WIDTH: 0.511018
G1 X86.042 Y96.689 E.00537
G1 X85.442 Y96.689 E.01452
G1 X85.443 Y97.348 E.01595
M73 P36 R18
G1 X85.97 Y97.045 E.0147
; LINE_WIDTH: 0.529545
G1 X86.292 Y96.912 E.00878
; LINE_WIDTH: 0.57043
G1 X86.615 Y96.778 E.00949
; LINE_WIDTH: 0.604122
G1 X86.649 Y96.765 E.00105
; WIPE_START
G1 X86.615 Y96.778 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X89.66 Y96.685 Z1.08 F18000
G1 Z.68
G1 E.4 F1800
; LINE_WIDTH: 0.506982
G1 F1500
M204 S6000
G1 X88.958 Y96.685 E.01684
; LINE_WIDTH: 0.52107
G1 X88.675 Y96.7 E.007
; LINE_WIDTH: 0.549245
G1 X88.392 Y96.714 E.0074
; LINE_WIDTH: 0.579162
G1 X88.249 Y96.73 E.00398
; LINE_WIDTH: 0.57299
G1 X88.584 Y96.843 E.00966
; LINE_WIDTH: 0.511417
G1 X88.919 Y96.956 E.00857
G1 X89.656 Y97.323 E.01994
G1 X89.66 Y96.745 E.01401
M204 S10000
G1 X90.097 Y96.247 F18000
; LINE_WIDTH: 0.419992
G1 F1500
M204 S6000
G1 X85.002 Y96.251 E.10021
G1 X85.005 Y98.127 E.03689
G1 X85.09 Y98.18 E.00197
G1 X85.495 Y97.824 E.0106
G1 X86.188 Y97.426 E.01573
G1 X86.763 Y97.235 E.01192
G1 X87.358 Y97.151 E.01182
G1 X88.213 Y97.21 E.01685
G1 X88.797 Y97.376 E.01193
G1 X89.352 Y97.651 E.01219
G1 X89.751 Y97.956 E.00988
G1 X89.882 Y97.841 E.00342
G1 X90.097 Y97.873 E.00429
G1 X90.097 Y96.307 E.0308
; CHANGE_LAYER
; Z_HEIGHT: 0.8
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F1500
G1 X90.097 Y97.873 E-.29751
G1 X89.882 Y97.841 E-.04143
G1 X89.751 Y97.956 E-.03308
G1 X89.718 Y97.93 E-.00798
; WIPE_END
G1 E-.02 F1800
; layer num/total_layer_count: 6/49
; update layer progress
M73 L6
M991 S0 P5 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z1.08 I1.02 J.663 P1  F18000
G1 X94.431 Y90.682 Z1.08
G1 Z.8
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X94.269 Y90.682 E.00342
G1 X94.269 Y90.22 E.00977
G1 X95.431 Y90.22 E.02458
G1 X95.431 Y90.682 E.00977
G1 X94.491 Y90.682 E.0199
; WIPE_START
M204 S6000
G1 X94.269 Y90.682 E-.04209
G1 X94.269 Y90.22 E-.08769
G1 X95.431 Y90.22 E-.22069
G1 X95.431 Y90.376 E-.02952
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X98.669 Y90.22 Z1.2 F18000
G1 Z.8
G1 E.4 F1800
G1 F1500
M204 S500
G1 X99.831 Y90.22 E.02458
G1 X99.831 Y90.682 E.00977
G1 X98.669 Y90.682 E.02458
G1 X98.669 Y90.28 E.0085
; WIPE_START
M204 S6000
G1 X99.831 Y90.22 E-.22098
G1 X99.831 Y90.682 E-.08769
G1 X99.455 Y90.682 E-.07132
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X98.638 Y94.889 Z1.2 F18000
G1 Z.8
G1 E.4 F1800
G1 F1500
M204 S500
G1 X99.407 Y94.12 E.02301
G1 X99.407 Y95.357 E.02619
G1 X98.169 Y95.357 E.02619
G1 X98.595 Y94.931 E.01276
M204 S10000
G1 X98.338 Y94.589 F18000
G1 F1500
M204 S500
G1 X99.831 Y93.096 E.04469
G1 X99.831 Y95.782 E.05685
G1 X97.145 Y95.782 E.05685
G1 X98.295 Y94.631 E.03444
; WIPE_START
M204 S6000
G1 X99.71 Y93.217 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X96.569 Y87.944 Z1.2 F18000
G1 Z.8
G1 E.4 F1800
G1 F1500
M204 S500
G1 X97.531 Y87.944 E.02035
G1 X97.05 Y88.425 E.01439
G1 X96.612 Y87.987 E.01312
; WIPE_START
M204 S6000
G1 X97.531 Y87.944 E-.17484
G1 X97.05 Y88.425 E-.1292
G1 X96.767 Y88.143 E-.07596
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X94.693 Y94.12 Z1.2 F18000
G1 Z.8
G1 E.4 F1800
G1 F1500
M204 S500
G1 X95.931 Y95.357 E.03704
G1 X94.693 Y95.357 E.02619
G1 X94.693 Y94.18 E.02492
; WIPE_START
M204 S6000
G1 X95.931 Y95.357 E-.32452
G1 X95.639 Y95.357 E-.05549
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X89.669 Y98.42 Z1.2 F18000
G1 Z.8
G1 E.4 F1800
G1 F1500
M204 S500
G1 X89.577 Y98.327 E.00277
G1 X89.152 Y98.008 E.01123
G1 X88.663 Y97.764 E.01157
G1 X88.154 Y97.615 E.01123
G1 X87.778 Y97.564 E.00804
G1 X87.398 Y97.558 E.00804
G1 X86.887 Y97.628 E.0109
G1 X86.523 Y97.734 E.00804
G1 X86.175 Y97.883 E.00801
G1 X85.737 Y98.152 E.01087
G1 X85.317 Y98.526 E.0119
G1 X84.98 Y98.962 E.01167
G1 X84.793 Y99.328 E.00869
G1 X84.598 Y99.281 E.00424
G1 X84.593 Y95.842 E.07278
G1 X90.507 Y95.837 E.12517
G1 X90.507 Y99.283 E.07292
G1 X90.315 Y99.332 E.00418
G1 X90.077 Y98.9 E.01044
G1 X89.843 Y98.597 E.00809
G1 X89.711 Y98.463 E.004
M204 S10000
G1 X89.366 Y98.718 F18000
G1 F1500
M204 S500
G1 X89.523 Y98.877 E.00473
G1 X89.722 Y99.133 E.00686
G1 X89.947 Y99.542 E.00988
G1 X90.054 Y99.829 E.00649
G1 X90.13 Y100.142 E.00682
G1 X90.172 Y100.602 E.00978
G1 X90.127 Y101.076 E.01007
G1 X90.054 Y101.374 E.00649
G1 X89.941 Y101.675 E.00682
G1 X89.716 Y102.078 E.00975
G1 X89.417 Y102.442 E.00998
G1 X89.052 Y102.748 E.01007
G1 X88.791 Y102.909 E.00649
G1 X88.499 Y103.044 E.00681
G1 X88.057 Y103.173 E.00975
G1 X87.589 Y103.222 E.00995
G1 X87.13 Y103.188 E.00975
G1 X86.816 Y103.116 E.00682
G1 X86.527 Y103.013 E.00649
G1 X86.107 Y102.79 E.01007
G1 X85.738 Y102.496 E.00998
G1 X85.429 Y102.142 E.00995
G1 X85.193 Y101.746 E.00975
M73 P36 R17
G1 X85.07 Y101.448 E.00683
G1 X84.984 Y101.137 E.00682
G1 X84.929 Y100.679 E.00975
G1 X84.957 Y100.219 E.00975
G1 X85.024 Y99.904 E.00682
G1 X85.122 Y99.614 E.00649
G1 X85.34 Y99.191 E.01007
G1 X85.629 Y98.817 E.01001
G1 X85.991 Y98.493 E.01028
G1 X86.37 Y98.261 E.00941
G1 X86.666 Y98.134 E.00681
G1 X86.976 Y98.044 E.00683
G1 X87.423 Y97.983 E.00956
G1 X87.746 Y97.988 E.00683
G1 X88.066 Y98.031 E.00683
G1 X88.508 Y98.16 E.00975
G1 X88.928 Y98.371 E.00995
G1 X89.297 Y98.647 E.00975
G1 X89.324 Y98.675 E.00083
M204 S250
G1 X89.075 Y99.005 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X89.215 Y99.147 E.00392
G1 X89.379 Y99.359 E.00527
G1 X89.574 Y99.713 E.00796
G1 X89.662 Y99.95 E.00496
G1 X89.726 Y100.209 E.00526
G1 X89.761 Y100.601 E.00774
G1 X89.722 Y101.008 E.00803
G1 X89.662 Y101.253 E.00496
G1 X89.568 Y101.503 E.00526
G1 X89.377 Y101.846 E.00773
G1 X89.125 Y102.153 E.00781
G1 X88.812 Y102.415 E.00802
G1 X88.597 Y102.547 E.00496
G1 X88.355 Y102.66 E.00526
G1 X87.977 Y102.77 E.00773
G1 X87.583 Y102.811 E.0078
G1 X87.191 Y102.782 E.00773
G1 X86.93 Y102.723 E.00526
G1 X86.693 Y102.638 E.00496
G1 X86.332 Y102.446 E.00802
G1 X86.022 Y102.199 E.00781
G1 X85.761 Y101.9 E.0078
G1 X85.56 Y101.563 E.00773
G1 X85.458 Y101.315 E.00526
G1 X85.387 Y101.058 E.00526
G1 X85.34 Y100.667 E.00773
G1 X85.364 Y100.274 E.00774
G1 X85.419 Y100.013 E.00526
G1 X85.5 Y99.774 E.00496
G1 X85.687 Y99.411 E.00802
G1 X85.93 Y99.097 E.00782
G1 X86.237 Y98.823 E.00809
G1 X86.559 Y98.625 E.00744
G1 X86.804 Y98.52 E.00525
G1 X87.061 Y98.445 E.00526
G1 X87.448 Y98.393 E.00767
G1 X87.715 Y98.397 E.00526
G1 X87.98 Y98.433 E.00526
G1 X88.358 Y98.543 E.00773
G1 X88.712 Y98.72 E.0078
G1 X89.027 Y98.956 E.00773
G1 X89.033 Y98.962 E.00017
; WIPE_START
M204 S6000
G1 X89.215 Y99.147 E-.04922
G1 X89.379 Y99.359 E-.05091
G1 X89.574 Y99.713 E-.07694
G1 X89.662 Y99.95 E-.04793
G1 X89.726 Y100.209 E-.05082
G1 X89.761 Y100.601 E-.07479
G1 X89.746 Y100.755 E-.0294
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X93.017 Y93.859 Z1.2 F18000
G1 X95.869 Y87.844 Z1.2
G1 Z.8
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X95.869 Y87.52 E.00686
G1 X96.869 Y87.52 E.02117
G1 X96.869 Y77.382 E.21459
G1 X94.581 Y77.382 E.04842
G1 X94.515 Y77.051 E.00714
G1 X94.373 Y76.788 E.00632
G1 X94.162 Y76.578 E.00629
G1 X93.901 Y76.437 E.00629
G1 X93.637 Y76.382 E.00572
G1 X81.496 Y76.382 E.25697
G1 X81.198 Y76.434 E.0064
G1 X80.888 Y76.613 E.00757
G1 X80.665 Y76.879 E.00736
G1 X80.542 Y77.19 E.00707
G1 X80.531 Y94.473 E.36581
G1 X80.617 Y94.839 E.00795
G1 X80.799 Y95.097 E.00669
G1 X80.994 Y95.262 E.00541
G1 X81.256 Y95.384 E.0061
G1 X81.505 Y95.42 E.00534
G1 X94.269 Y95.41 E.27016
G1 X94.269 Y93.096 E.04898
G1 X96.955 Y95.782 E.08039
G1 X90.931 Y95.782 E.12751
G1 X90.931 Y100.583 E.10162
G1 X90.878 Y101.192 E.01293
G1 X90.782 Y101.588 E.00863
G1 X90.643 Y101.963 E.00847
G1 X90.46 Y102.32 E.00848
G1 X90.232 Y102.658 E.00863
G1 X90.099 Y102.82 E.00446
G1 X89.832 Y103.094 E.00809
G1 X89.52 Y103.347 E.00849
G1 X89.174 Y103.566 E.00867
G1 X88.829 Y103.73 E.00809
G1 X88.432 Y103.864 E.00886
G1 X87.877 Y103.964 E.01194
G1 X87.448 Y103.979 E.0091
G1 X86.861 Y103.91 E.0125
G1 X86.468 Y103.803 E.00863
G1 X86.097 Y103.652 E.00847
G1 X85.747 Y103.459 E.00844
G1 X85.4 Y103.208 E.00908
G1 X84.996 Y102.815 E.01193
G1 X84.747 Y102.489 E.00868
G1 X84.543 Y102.144 E.00847
G1 X84.32 Y101.597 E.01252
G1 X84.229 Y101.225 E.00809
G1 X84.176 Y100.799 E.00909
G1 X84.168 Y95.783 E.10617
G1 X81.479 Y95.778 E.05691
G1 X81.223 Y95.741 E.00548
G1 X80.931 Y95.634 E.00659
G1 X80.792 Y95.554 E.0034
G1 X80.546 Y95.348 E.00678
G1 X80.354 Y95.088 E.00684
G1 X80.251 Y94.865 E.0052
G1 X80.207 Y94.719 E.00322
G1 X80.169 Y94.383 E.00716
G1 X80.169 Y77.419 E.35906
G1 X80.206 Y77.092 E.00697
G1 X80.284 Y76.855 E.00528
G1 X80.399 Y76.643 E.0051
G1 X80.545 Y76.457 E.00501
G1 X80.664 Y76.343 E.00349
G1 X80.785 Y76.254 E.00317
G1 X81.004 Y76.135 E.00528
G1 X81.241 Y76.057 E.00528
G1 X81.39 Y76.03 E.00321
G1 X93.536 Y76.021 E.25709
G1 X93.798 Y76.044 E.00555
G1 X93.946 Y76.079 E.00322
G1 X94.097 Y76.134 E.0034
G1 X94.374 Y76.294 E.00678
G1 X94.49 Y76.391 E.0032
G1 X94.662 Y76.584 E.00547
G1 X94.948 Y77.02 E.01104
G1 X97.231 Y77.02 E.04831
G1 X97.231 Y87.52 E.22224
G1 X98.231 Y87.52 E.02117
G1 X98.231 Y87.844 E.00686
G1 X97.05 Y89.025 E.03534
G1 X95.912 Y87.887 E.03407
; WIPE_START
M204 S6000
G1 X95.869 Y87.52 E-.07014
G1 X96.869 Y87.52 E-.19
G1 X96.869 Y86.889 E-.11986
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X94.84 Y91.091 Z1.2 F18000
G1 Z.8
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X94.84 Y93.088 E.03928
G1 X97.05 Y95.298 E.06147
G1 X99.26 Y93.088 E.06147
G1 X99.26 Y91.091 E.03928
G1 X98.26 Y91.091 E.01967
G1 X98.26 Y89.811 E.02518
G1 X100.24 Y89.811 E.03895
G1 X100.24 Y96.191 E.12549
G1 X91.34 Y96.191 E.17505
G1 X91.34 Y100.595 E.08662
G1 X91.315 Y101.024 E.00846
G1 X91.28 Y101.269 E.00486
G1 X91.174 Y101.708 E.00888
G1 X91.018 Y102.129 E.00883
G1 X90.813 Y102.528 E.00883
G1 X90.561 Y102.902 E.00888
G1 X90.404 Y103.094 E.00487
G1 X90.108 Y103.397 E.00833
G1 X89.759 Y103.68 E.00884
G1 X89.377 Y103.921 E.00889
G1 X89.18 Y104.022 E.00435
G1 X88.977 Y104.112 E.00436
G1 X88.546 Y104.257 E.00895
G1 X88.333 Y104.309 E.0043
G1 X87.915 Y104.372 E.00833
G1 X87.437 Y104.389 E.00941
G1 X87.016 Y104.352 E.00832
G1 X86.772 Y104.31 E.00486
G1 X86.336 Y104.191 E.00888
G1 X85.92 Y104.022 E.00883
G1 X85.527 Y103.806 E.00882
G1 X85.141 Y103.525 E.0094
G1 X84.829 Y103.239 E.00833
G1 X84.681 Y103.077 E.00429
G1 X84.407 Y102.718 E.0089
G1 X84.179 Y102.331 E.00883
G1 X83.996 Y101.918 E.00889
G1 X83.926 Y101.711 E.0043
G1 X83.826 Y101.299 E.00833
G1 X83.767 Y100.825 E.0094
G1 X83.76 Y96.191 E.09113
G1 X81.449 Y96.188 E.04545
G1 X81.134 Y96.141 E.00626
G1 X80.938 Y96.083 E.00403
G1 X80.747 Y96 E.00409
G1 X80.567 Y95.896 E.00409
G1 X80.4 Y95.772 E.0041
G1 X80.248 Y95.629 E.00409
G1 X80.115 Y95.47 E.00408
G1 X79.995 Y95.286 E.00431
G1 X79.867 Y95.01 E.00599
G1 X79.809 Y94.814 E.00404
G1 X79.772 Y94.609 E.00409
G1 X79.76 Y94.395 E.00422
G1 X79.76 Y77.407 E.33413
G1 X79.772 Y77.193 E.00421
G1 X79.808 Y76.991 E.00403
G1 X79.907 Y76.692 E.00619
G1 X80.055 Y76.417 E.00614
G1 X80.241 Y76.181 E.00592
G1 X80.4 Y76.03 E.00431
G1 X80.564 Y75.907 E.00402
G1 X80.841 Y75.758 E.0062
G1 X81.14 Y75.659 E.00619
G1 X81.342 Y75.623 E.00404
G1 X81.556 Y75.611 E.00421
G1 X93.555 Y75.611 E.236
G1 X93.863 Y75.639 E.00609
G1 X94.063 Y75.686 E.00404
G1 X94.259 Y75.758 E.0041
G1 X94.445 Y75.851 E.00409
G1 X94.619 Y75.965 E.0041
G1 X94.776 Y76.097 E.00403
G1 X94.987 Y76.335 E.00625
G1 X95.169 Y76.611 E.0065
G1 X97.64 Y76.611 E.04861
G1 X97.64 Y87.111 E.20653
G1 X98.64 Y87.111 E.01967
G1 X98.64 Y88.014 E.01776
G1 X97.05 Y89.604 E.04423
G1 X95.46 Y88.014 E.04423
G1 X95.46 Y87.111 E.01776
G1 X96.46 Y87.111 E.01967
G1 X96.46 Y77.791 E.18332
G1 X94.16 Y77.791 E.04524
G1 X94.159 Y77.359 E.00849
G1 X94.126 Y77.192 E.00336
G1 X94.041 Y77.035 E.0035
G1 X93.916 Y76.91 E.00349
G1 X93.76 Y76.826 E.00349
G1 X93.595 Y76.792 E.00331
G1 X81.532 Y76.791 E.23727
G1 X81.34 Y76.825 E.00382
G1 X81.156 Y76.931 E.0042
G1 X81.021 Y77.092 E.00412
G1 X80.951 Y77.268 E.00374
G1 X80.94 Y94.425 E.33746
G1 X80.997 Y94.668 E.0049
G1 X81.103 Y94.818 E.00361
G1 X81.216 Y94.914 E.00291
G1 X81.374 Y94.987 E.00343
G1 X81.535 Y95.011 E.00319
G1 X93.86 Y95.001 E.24242
G1 X93.86 Y89.811 E.10209
G1 X95.84 Y89.811 E.03895
G1 X95.84 Y91.091 E.02518
G1 X94.9 Y91.091 E.01849
; WIPE_START
M204 S6000
G1 X94.84 Y93.088 E-.3796
G1 X94.842 Y93.089 E-.0004
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
M73 P37 R17
G1 X-13.0 F3000 ; move to safe pos
M400
M1004 S5 P1  ; external shutter
M400 P300
M971 S11 C11 O0
G92 E0
G1 X0 F18000
M623

; SKIPTYPE: head_wrap_detect
M622.1 S1
M1002 judge_flag g39_3rd_layer_detect_flag
M622 J1
    ; enable nozzle clog detect at 3rd layer
    


    M622.1 S1
    M1002 judge_flag g39_detection_flag
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




G1 X94.35 Y92.887
G1 Z.8
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.596522
G1 F1500
M204 S6000
G1 X94.35 Y90.886 E.05697
; WIPE_START
G1 X94.35 Y92.886 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X95.077 Y94.958 Z1.2 F18000
G1 Z.8
G1 E.4 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.365752
G1 F1500
M204 S6000
G1 X95.013 Y94.995 E.00125
G1 X95.062 Y95.023 E.00095
; WIPE_START
G1 X95.013 Y94.995 E-.16436
G1 X95.077 Y94.958 E-.21564
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X99.065 Y94.958 Z1.2 F18000
G1 Z.8
G1 E.4 F1800
G1 F1500
M204 S6000
G1 X99.002 Y94.995 E.00125
G1 X99.05 Y95.023 E.00095
; WIPE_START
G1 X99.002 Y94.995 E-.16436
G1 X99.065 Y94.958 E-.21564
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X99.75 Y92.887 Z1.2 F18000
G1 Z.8
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.596522
G1 F1500
M204 S6000
G1 X99.75 Y90.886 E.05697
; WIPE_START
G1 X99.75 Y92.886 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X93.599 Y97.405 Z1.2 F18000
G1 X90.449 Y99.72 Z1.2
G1 Z.8
G1 E.4 F1800
; LINE_WIDTH: 0.398769
G1 F1500
M204 S6000
G1 X90.2 Y99.581 E.0053
M204 S10000
G1 X90.449 Y99.72 F18000
; LINE_WIDTH: 0.46374
G1 F1500
M204 S6000
G1 X90.489 Y99.744 E.00102
G1 X90.508 Y99.903 E.0035
; LINE_WIDTH: 0.428681
G1 X90.527 Y100.062 E.00322
; LINE_WIDTH: 0.384694
G1 X90.551 Y100.57 E.00911
; LINE_WIDTH: 0.360408
G1 X90.498 Y101.151 E.00975
G1 X90.419 Y101.477 E.00559
G1 X90.295 Y101.81 E.00593
G1 X90.019 Y102.302 E.00942
G1 X89.672 Y102.716 E.00902
G1 X89.264 Y103.062 E.00894
G1 X88.979 Y103.238 E.00559
G1 X88.643 Y103.394 E.00618
G1 X88.115 Y103.543 E.00917
G1 X87.839 Y103.582 E.00465
G1 X87.46 Y103.596 E.00633
G1 X86.939 Y103.536 E.00875
G1 X86.59 Y103.441 E.00605
G1 X86.364 Y103.354 E.00405
G1 X85.888 Y103.096 E.00904
G1 X85.643 Y102.91 E.00513
G1 X85.393 Y102.682 E.00565
G1 X85.063 Y102.273 E.00878
G1 X84.86 Y101.926 E.00671
G1 X84.716 Y101.579 E.00628
G1 X84.612 Y101.198 E.0066
G1 X84.557 Y100.775 E.00711
G1 X84.567 Y100.18 E.00993
; LINE_WIDTH: 0.404463
G1 X84.587 Y99.978 E.00384
; LINE_WIDTH: 0.444305
G1 X84.605 Y99.803 E.00368
; LINE_WIDTH: 0.47543
G1 X84.652 Y99.512 E.0066
M204 S10000
G1 X84.828 Y98.783 F18000
; LINE_WIDTH: 0.0945957
G1 F1500
M204 S6000
G1 X84.851 Y98.714 E.00025
G1 X84.98 Y98.576 E.00065
; WIPE_START
G1 X84.851 Y98.714 E-.27403
G1 X84.828 Y98.783 E-.10597
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X86.724 Y96.741 Z1.2 F18000
G1 Z.8
G1 E.4 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.595442
G1 F1500
M204 S6000
G1 X87.011 Y96.722 E.00818
; LINE_WIDTH: 0.563822
G1 X87.298 Y96.702 E.00772
G1 X88.189 Y96.728 E.02394
; WIPE_START
G1 X87.298 Y96.702 E-.2873
G1 X87.011 Y96.722 E-.0927
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X86.724 Y96.741 Z1.2 F18000
G1 Z.8
G1 E.4 F1800
; LINE_WIDTH: 0.595841
G1 F1500
M204 S6000
G1 X86.413 Y96.722 E.00885
; LINE_WIDTH: 0.557857
G1 X86.102 Y96.704 E.00826
; LINE_WIDTH: 0.504138
G1 X85.438 Y96.685 E.01587
G1 X85.439 Y97.344 E.01573
G1 X85.864 Y97.099 E.01171
; LINE_WIDTH: 0.5209
G1 X86.24 Y96.943 E.01006
; LINE_WIDTH: 0.560935
G1 X86.617 Y96.787 E.01088
; LINE_WIDTH: 0.597892
G1 X86.668 Y96.765 E.00161
; WIPE_START
G1 X86.617 Y96.787 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X89.66 Y96.685 Z1.2 F18000
G1 Z.8
G1 E.4 F1800
; LINE_WIDTH: 0.506992
G1 F1500
M204 S6000
G1 X88.958 Y96.685 E.01684
; LINE_WIDTH: 0.521077
G1 X88.675 Y96.7 E.007
; LINE_WIDTH: 0.549247
G1 X88.392 Y96.714 E.0074
; LINE_WIDTH: 0.579162
G1 X88.249 Y96.73 E.00398
; LINE_WIDTH: 0.572992
G1 X88.584 Y96.843 E.00966
; LINE_WIDTH: 0.511459
G1 X88.919 Y96.956 E.00857
G1 X89.66 Y97.312 E.0199
G1 X89.66 Y96.745 E.01374
M204 S10000
G1 X90.097 Y96.247 F18000
; LINE_WIDTH: 0.419992
G1 F1500
M204 S6000
G1 X85.002 Y96.251 E.10021
G1 X85.005 Y98.09 E.03618
G1 X85.069 Y98.1 E.00126
G1 X85.123 Y98.151 E.00147
G1 X85.507 Y97.813 E.01005
G1 X85.974 Y97.526 E.01078
G1 X86.777 Y97.234 E.0168
G1 X87.358 Y97.151 E.01156
G1 X88.213 Y97.21 E.01685
G1 X88.797 Y97.376 E.01193
G1 X89.352 Y97.651 E.01219
G1 X89.835 Y98.009 E.01182
G1 X90.097 Y98.3 E.00771
G1 X90.097 Y96.307 E.0392
; CHANGE_LAYER
; Z_HEIGHT: 0.92
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F1500
G1 X90.097 Y98.3 E-.3787
G1 X90.093 Y98.295 E-.0013
; WIPE_END
G1 E-.02 F1800
; layer num/total_layer_count: 7/49
; update layer progress
M73 L7
M991 S0 P6 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z1.2 I1.057 J.602 P1  F18000
G1 X94.431 Y90.682 Z1.2
G1 Z.92
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X94.269 Y90.682 E.00342
G1 X94.269 Y90.22 E.00977
G1 X95.431 Y90.22 E.02458
G1 X95.431 Y90.682 E.00977
G1 X94.491 Y90.682 E.0199
; WIPE_START
M204 S6000
G1 X94.269 Y90.682 E-.04209
G1 X94.269 Y90.22 E-.08769
G1 X95.431 Y90.22 E-.22069
G1 X95.431 Y90.376 E-.02952
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X98.669 Y90.22 Z1.32 F18000
G1 Z.92
G1 E.4 F1800
G1 F1500
M204 S500
G1 X99.831 Y90.22 E.02458
G1 X99.831 Y90.682 E.00977
G1 X98.669 Y90.682 E.02458
G1 X98.669 Y90.28 E.0085
; WIPE_START
M204 S6000
G1 X99.831 Y90.22 E-.22098
G1 X99.831 Y90.682 E-.08769
G1 X99.455 Y90.682 E-.07132
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X98.638 Y94.889 Z1.32 F18000
G1 Z.92
G1 E.4 F1800
G1 F1500
M204 S500
G1 X99.407 Y94.12 E.02301
G1 X99.407 Y95.357 E.02619
G1 X98.169 Y95.357 E.02619
G1 X98.595 Y94.931 E.01276
M204 S10000
G1 X98.338 Y94.589 F18000
G1 F1500
M204 S500
G1 X99.831 Y93.096 E.04469
G1 X99.831 Y95.782 E.05685
G1 X97.145 Y95.782 E.05685
G1 X98.295 Y94.631 E.03444
; WIPE_START
M204 S6000
G1 X99.71 Y93.217 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X96.569 Y87.944 Z1.32 F18000
G1 Z.92
G1 E.4 F1800
G1 F1500
M204 S500
G1 X97.531 Y87.944 E.02035
G1 X97.05 Y88.425 E.01439
G1 X96.612 Y87.987 E.01312
; WIPE_START
M204 S6000
G1 X97.531 Y87.944 E-.17484
G1 X97.05 Y88.425 E-.1292
G1 X96.767 Y88.143 E-.07596
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X94.693 Y94.12 Z1.32 F18000
G1 Z.92
G1 E.4 F1800
G1 F1500
M204 S500
G1 X95.931 Y95.357 E.03704
G1 X94.693 Y95.357 E.02619
G1 X94.693 Y94.18 E.02492
; WIPE_START
M204 S6000
G1 X95.931 Y95.357 E-.32452
G1 X95.639 Y95.357 E-.05549
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X89.663 Y98.414 Z1.32 F18000
G1 Z.92
G1 E.4 F1800
G1 F1500
M204 S500
G1 X89.577 Y98.327 E.0026
G1 X89.152 Y98.008 E.01123
G1 X88.663 Y97.764 E.01157
G1 X88.154 Y97.615 E.01123
G1 X87.778 Y97.564 E.00804
G1 X87.398 Y97.558 E.00804
G1 X86.872 Y97.63 E.01124
G1 X86.352 Y97.798 E.01156
G1 X85.885 Y98.05 E.01123
G1 X85.581 Y98.278 E.00805
G1 X85.306 Y98.54 E.00804
G1 X84.98 Y98.962 E.01129
G1 X84.793 Y99.328 E.00869
G1 X84.598 Y99.281 E.00424
G1 X84.593 Y95.842 E.07279
G1 X90.507 Y95.837 E.12517
G1 X90.507 Y99.283 E.07293
G1 X90.315 Y99.332 E.00418
G1 X90.078 Y98.9 E.01044
G1 X89.843 Y98.597 E.0081
G1 X89.705 Y98.457 E.00417
M204 S10000
G1 X89.361 Y98.712 F18000
G1 F1500
M204 S500
G1 X89.523 Y98.877 E.0049
G1 X89.722 Y99.134 E.00687
G1 X89.948 Y99.544 E.00993
G1 X90.054 Y99.829 E.00643
G1 X90.13 Y100.142 E.00682
G1 X90.172 Y100.601 E.00975
G1 X90.13 Y101.069 E.00995
G1 X90.007 Y101.513 E.00975
G1 X89.876 Y101.808 E.00683
G1 X89.71 Y102.085 E.00683
G1 X89.417 Y102.442 E.00979
G1 X89.05 Y102.749 E.01013
G1 X88.791 Y102.909 E.00643
G1 X88.499 Y103.044 E.00682
G1 X88.057 Y103.173 E.00975
G1 X87.589 Y103.222 E.00995
G1 X87.121 Y103.187 E.00995
G1 X86.666 Y103.069 E.00995
G1 X86.248 Y102.875 E.00975
G1 X85.978 Y102.697 E.00683
G1 X85.732 Y102.489 E.00683
G1 X85.429 Y102.142 E.00975
G1 X85.193 Y101.746 E.00975
G1 X85.07 Y101.448 E.00683
G1 X84.984 Y101.137 E.00683
G1 X84.929 Y100.679 E.00975
G1 X84.957 Y100.219 E.00975
G1 X85.024 Y99.904 E.00682
G1 X85.121 Y99.617 E.00643
G1 X85.34 Y99.191 E.01013
G1 X85.622 Y98.825 E.00978
G1 X85.856 Y98.602 E.00683
G1 X86.114 Y98.408 E.00683
G1 X86.52 Y98.19 E.00975
G1 X86.966 Y98.045 E.00994
G1 X87.423 Y97.983 E.00975
G1 X87.746 Y97.988 E.00683
G1 X88.066 Y98.031 E.00683
G1 X88.508 Y98.16 E.00975
G1 X88.928 Y98.371 E.00996
G1 X89.297 Y98.647 E.00975
G1 X89.319 Y98.669 E.00066
M204 S250
G1 X89.069 Y98.999 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X89.215 Y99.147 E.00407
G1 X89.379 Y99.359 E.00527
G1 X89.575 Y99.716 E.00801
G1 X89.662 Y99.95 E.00491
G1 X89.726 Y100.209 E.00526
G1 X89.761 Y100.601 E.00773
G1 X89.725 Y100.996 E.00779
G1 X89.621 Y101.375 E.00774
G1 X89.512 Y101.619 E.00526
G1 X89.375 Y101.849 E.00526
G1 X89.125 Y102.153 E.00775
G1 X88.81 Y102.417 E.00807
G1 X88.597 Y102.547 E.00491
G1 X88.355 Y102.66 E.00526
G1 X87.977 Y102.77 E.00773
G1 X87.583 Y102.811 E.0078
G1 X87.188 Y102.782 E.00779
G1 X86.804 Y102.682 E.0078
G1 X86.447 Y102.517 E.00773
G1 X86.224 Y102.369 E.00526
G1 X86.02 Y102.197 E.00526
G1 X85.761 Y101.9 E.00773
G1 X85.56 Y101.563 E.00773
G1 X85.458 Y101.315 E.00526
G1 X85.387 Y101.057 E.00526
G1 X85.34 Y100.667 E.00773
G1 X85.364 Y100.274 E.00774
G1 X85.419 Y100.013 E.00526
G1 X85.499 Y99.776 E.00491
G1 X85.687 Y99.411 E.00807
G1 X85.927 Y99.1 E.00774
G1 X86.121 Y98.915 E.00526
G1 X86.335 Y98.754 E.00526
G1 X86.681 Y98.568 E.00773
G1 X87.058 Y98.445 E.00779
G1 X87.448 Y98.393 E.00774
G1 X87.715 Y98.397 E.00526
G1 X87.98 Y98.433 E.00526
G1 X88.358 Y98.543 E.00773
G1 X88.712 Y98.72 E.0078
G1 X89.027 Y98.956 E.00773
G1 X89.027 Y98.956 E.00001
; WIPE_START
M204 S6000
G1 X89.215 Y99.147 E-.05071
G1 X89.379 Y99.359 E-.05095
G1 X89.575 Y99.716 E-.07738
G1 X89.662 Y99.95 E-.04746
G1 X89.726 Y100.209 E-.05081
G1 X89.761 Y100.601 E-.07469
G1 X89.748 Y100.748 E-.02801
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X93.019 Y93.852 Z1.32 F18000
G1 X95.869 Y87.844 Z1.32
G1 Z.92
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X95.869 Y87.52 E.00686
G1 X96.869 Y87.52 E.02117
G1 X96.869 Y77.382 E.21459
G1 X94.581 Y77.382 E.04843
G1 X94.515 Y77.052 E.00713
G1 X94.373 Y76.788 E.00632
G1 X94.163 Y76.578 E.00629
G1 X93.901 Y76.437 E.0063
G1 X93.637 Y76.382 E.00571
G1 X81.505 Y76.382 E.25678
G1 X81.247 Y76.419 E.00553
G1 X80.936 Y76.576 E.00737
G1 X80.69 Y76.836 E.00757
G1 X80.542 Y77.181 E.00795
G1 X80.531 Y94.437 E.36524
G1 X80.555 Y94.646 E.00446
G1 X80.672 Y94.94 E.00669
G1 X80.961 Y95.246 E.00892
G1 X81.256 Y95.384 E.00688
G1 X81.505 Y95.42 E.00534
G1 X94.269 Y95.41 E.27016
G1 X94.269 Y93.096 E.04898
G1 X96.955 Y95.782 E.08039
G1 X90.931 Y95.782 E.12751
G1 X90.931 Y100.583 E.10163
G1 X90.878 Y101.192 E.01293
G1 X90.782 Y101.588 E.00862
G1 X90.643 Y101.963 E.00847
G1 X90.46 Y102.32 E.00848
G1 X90.118 Y102.799 E.01247
G1 X89.807 Y103.115 E.00937
G1 X89.514 Y103.352 E.00799
G1 X89.19 Y103.557 E.00811
G1 X88.82 Y103.733 E.00867
G1 X88.255 Y103.907 E.01251
G1 X87.659 Y103.979 E.01271
G1 X87.25 Y103.967 E.00866
G1 X86.854 Y103.908 E.00848
G1 X86.468 Y103.803 E.00848
G1 X86.097 Y103.652 E.00847
G1 X85.747 Y103.46 E.00844
G1 X85.397 Y103.205 E.00918
G1 X84.995 Y102.815 E.01185
G1 X84.747 Y102.489 E.00867
G1 X84.543 Y102.144 E.00848
G1 X84.32 Y101.596 E.01252
G1 X84.23 Y101.229 E.008
G1 X84.176 Y100.799 E.00919
G1 X84.168 Y95.783 E.10617
G1 X81.479 Y95.778 E.05691
G1 X81.223 Y95.741 E.00548
G1 X80.931 Y95.634 E.00659
G1 X80.8 Y95.558 E.00321
G1 X80.597 Y95.398 E.00547
G1 X80.397 Y95.159 E.00659
G1 X80.317 Y95.02 E.0034
G1 X80.207 Y94.719 E.00678
G1 X80.169 Y94.383 E.00716
G1 X80.169 Y77.419 E.35905
G1 X80.206 Y77.092 E.00697
G1 X80.284 Y76.855 E.00528
G1 X80.403 Y76.636 E.00527
G1 X80.488 Y76.521 E.00302
G1 X80.664 Y76.345 E.00528
G1 X80.868 Y76.202 E.00527
G1 X80.995 Y76.138 E.00301
G1 X81.241 Y76.057 E.00547
G1 X81.39 Y76.03 E.00321
G1 X93.539 Y76.021 E.25714
G1 X93.797 Y76.044 E.0055
M73 P38 R17
G1 X93.946 Y76.079 E.00322
G1 X94.096 Y76.134 E.0034
G1 X94.374 Y76.294 E.00678
G1 X94.49 Y76.391 E.0032
G1 X94.662 Y76.585 E.00547
G1 X94.948 Y77.02 E.01103
G1 X97.231 Y77.02 E.04831
G1 X97.231 Y87.52 E.22224
G1 X98.231 Y87.52 E.02117
G1 X98.231 Y87.844 E.00686
G1 X97.05 Y89.025 E.03534
G1 X95.912 Y87.887 E.03407
; WIPE_START
M204 S6000
G1 X95.869 Y87.52 E-.07014
G1 X96.869 Y87.52 E-.19
G1 X96.869 Y86.889 E-.11986
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X94.84 Y91.091 Z1.32 F18000
G1 Z.92
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X94.84 Y93.088 E.03928
G1 X97.05 Y95.298 E.06147
G1 X99.26 Y93.088 E.06147
G1 X99.26 Y91.091 E.03928
G1 X98.26 Y91.091 E.01967
G1 X98.26 Y89.811 E.02518
G1 X100.24 Y89.811 E.03895
G1 X100.24 Y96.191 E.12549
G1 X91.34 Y96.191 E.17505
G1 X91.34 Y100.595 E.08662
G1 X91.316 Y101.019 E.00836
G1 X91.28 Y101.269 E.00496
G1 X91.174 Y101.708 E.00888
G1 X91.018 Y102.129 E.00883
G1 X90.813 Y102.528 E.00883
G1 X90.561 Y102.903 E.00889
G1 X90.423 Y103.072 E.00428
G1 X90.083 Y103.419 E.00956
G1 X89.757 Y103.682 E.00824
G1 X89.573 Y103.806 E.00436
G1 X89.382 Y103.918 E.00436
G1 X88.974 Y104.113 E.00889
G1 X88.546 Y104.257 E.00889
G1 X88.334 Y104.309 E.0043
G1 X87.883 Y104.376 E.00896
G1 X87.665 Y104.389 E.00429
G1 X87.214 Y104.376 E.00889
G1 X86.769 Y104.309 E.00883
G1 X86.336 Y104.191 E.00883
G1 X85.92 Y104.022 E.00883
G1 X85.528 Y103.806 E.00882
G1 X85.137 Y103.522 E.00949
G1 X84.829 Y103.239 E.00824
G1 X84.681 Y103.077 E.0043
G1 X84.407 Y102.718 E.00889
G1 X84.179 Y102.331 E.00883
G1 X83.996 Y101.918 E.00889
G1 X83.926 Y101.711 E.00429
G1 X83.827 Y101.304 E.00824
G1 X83.767 Y100.825 E.0095
G1 X83.76 Y96.191 E.09113
G1 X81.449 Y96.188 E.04545
G1 X81.134 Y96.141 E.00626
G1 X80.938 Y96.083 E.00403
G1 X80.747 Y96 E.00409
G1 X80.569 Y95.898 E.00404
G1 X80.32 Y95.7 E.00625
G1 X80.179 Y95.551 E.00403
G1 X80.055 Y95.384 E.00409
G1 X79.951 Y95.204 E.0041
G1 X79.868 Y95.013 E.00409
G1 X79.809 Y94.814 E.00409
G1 X79.772 Y94.609 E.00409
G1 X79.76 Y94.395 E.00422
G1 X79.76 Y77.407 E.33413
G1 X79.772 Y77.193 E.00422
G1 X79.808 Y76.991 E.00403
G1 X79.907 Y76.692 E.00619
G1 X80.057 Y76.415 E.00619
G1 X80.177 Y76.253 E.00397
G1 X80.4 Y76.03 E.0062
G1 X80.658 Y75.85 E.00619
G1 X80.838 Y75.759 E.00397
G1 X81.14 Y75.659 E.00625
G1 X81.342 Y75.623 E.00404
G1 X81.556 Y75.611 E.00421
G1 X93.557 Y75.611 E.23605
G1 X93.863 Y75.639 E.00605
G1 X94.063 Y75.686 E.00404
G1 X94.259 Y75.758 E.0041
G1 X94.445 Y75.851 E.00409
G1 X94.619 Y75.965 E.00409
G1 X94.776 Y76.097 E.00403
G1 X94.987 Y76.335 E.00626
G1 X95.169 Y76.611 E.0065
G1 X97.64 Y76.611 E.04861
G1 X97.64 Y87.111 E.20653
G1 X98.64 Y87.111 E.01967
G1 X98.64 Y88.014 E.01776
G1 X97.05 Y89.604 E.04423
G1 X95.46 Y88.014 E.04423
G1 X95.46 Y87.111 E.01776
G1 X96.46 Y87.111 E.01967
G1 X96.46 Y77.791 E.18332
G1 X94.16 Y77.791 E.04524
G1 X94.159 Y77.36 E.00848
G1 X94.126 Y77.192 E.00337
G1 X94.041 Y77.035 E.0035
G1 X93.916 Y76.91 E.00349
G1 X93.759 Y76.826 E.0035
G1 X93.595 Y76.792 E.0033
G1 X81.535 Y76.791 E.23721
G1 X81.371 Y76.815 E.00325
G1 X81.184 Y76.909 E.00413
G1 X81.038 Y77.064 E.00419
G1 X80.951 Y77.265 E.00431
G1 X80.94 Y94.413 E.33728
G1 X80.955 Y94.545 E.00261
G1 X81.023 Y94.716 E.00361
G1 X81.205 Y94.908 E.00521
G1 X81.374 Y94.987 E.00367
G1 X81.535 Y95.011 E.00319
G1 X93.86 Y95.001 E.24242
G1 X93.86 Y89.811 E.10209
G1 X95.84 Y89.811 E.03895
G1 X95.84 Y91.091 E.02518
G1 X94.9 Y91.091 E.01849
; WIPE_START
M204 S6000
G1 X94.84 Y93.088 E-.3796
G1 X94.842 Y93.089 E-.0004
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




G1 X94.35 Y92.887
G1 Z.92
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.596522
G1 F1500
M204 S6000
G1 X94.35 Y90.886 E.05697
; WIPE_START
G1 X94.35 Y92.886 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X95.077 Y94.958 Z1.32 F18000
G1 Z.92
G1 E.4 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.365752
G1 F1500
M204 S6000
G1 X95.013 Y94.995 E.00125
G1 X95.062 Y95.023 E.00095
; WIPE_START
G1 X95.013 Y94.995 E-.16436
G1 X95.077 Y94.958 E-.21564
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X99.065 Y94.958 Z1.32 F18000
G1 Z.92
G1 E.4 F1800
G1 F1500
M204 S6000
G1 X99.002 Y94.995 E.00125
G1 X99.05 Y95.023 E.00095
; WIPE_START
G1 X99.002 Y94.995 E-.16436
G1 X99.065 Y94.958 E-.21564
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X99.75 Y92.887 Z1.32 F18000
G1 Z.92
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.596522
G1 F1500
M204 S6000
G1 X99.75 Y90.886 E.05697
; WIPE_START
G1 X99.75 Y92.886 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X93.599 Y97.405 Z1.32 F18000
G1 X90.448 Y99.72 Z1.32
G1 Z.92
G1 E.4 F1800
; LINE_WIDTH: 0.398283
G1 F1500
M204 S6000
G1 X90.2 Y99.581 E.00529
M204 S10000
G1 X90.448 Y99.72 F18000
; LINE_WIDTH: 0.463583
G1 F1500
M204 S6000
G1 X90.489 Y99.744 E.00103
G1 X90.508 Y99.903 E.00349
; LINE_WIDTH: 0.428656
G1 X90.527 Y100.062 E.00321
; LINE_WIDTH: 0.384682
G1 X90.551 Y100.57 E.00911
; LINE_WIDTH: 0.360544
G1 X90.505 Y101.125 E.00931
G1 X90.415 Y101.476 E.00604
G1 X90.293 Y101.809 E.00593
G1 X90.131 Y102.125 E.00593
G1 X90.011 Y102.312 E.0037
G1 X89.692 Y102.694 E.00832
G1 X89.548 Y102.832 E.00334
G1 X89.282 Y103.05 E.00574
G1 X89.009 Y103.222 E.00539
G1 X88.62 Y103.402 E.00716
G1 X88.143 Y103.537 E.00828
G1 X87.799 Y103.586 E.00581
G1 X87.61 Y103.6 E.00317
G1 X87.284 Y103.584 E.00544
G1 X86.933 Y103.533 E.00593
G1 X86.589 Y103.442 E.00593
G1 X86.053 Y103.198 E.00983
G1 X85.745 Y102.993 E.0062
G1 X85.476 Y102.766 E.00587
G1 X85.135 Y102.374 E.00869
G1 X84.85 Y101.904 E.00918
G1 X84.716 Y101.579 E.00587
G1 X84.618 Y101.222 E.00619
G1 X84.553 Y100.705 E.00869
G1 X84.567 Y100.18 E.00878
; LINE_WIDTH: 0.404465
G1 X84.587 Y99.978 E.00384
; LINE_WIDTH: 0.444305
G1 X84.605 Y99.803 E.00368
; LINE_WIDTH: 0.475375
G1 X84.652 Y99.512 E.0066
M204 S10000
G1 X84.828 Y98.783 F18000
; LINE_WIDTH: 0.0867373
G1 F1500
M204 S6000
G1 X84.843 Y98.737 E.00015
G1 X84.924 Y98.647 E.00037
; WIPE_START
G1 X84.843 Y98.737 E-.27087
G1 X84.828 Y98.783 E-.10913
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X86.705 Y96.742 Z1.32 F18000
G1 Z.92
G1 E.4 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.597362
G1 F1500
M204 S6000
G1 X87.001 Y96.722 E.00848
; LINE_WIDTH: 0.563925
G1 X87.298 Y96.702 E.00798
G1 X88.189 Y96.728 E.02395
; WIPE_START
G1 X87.298 Y96.702 E-.28501
G1 X87.001 Y96.722 E-.09499
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X86.705 Y96.742 Z1.32 F18000
G1 Z.92
G1 E.4 F1800
; LINE_WIDTH: 0.598704
G1 F1500
M204 S6000
G1 X86.477 Y96.724 E.00652
; LINE_WIDTH: 0.561327
G1 X86.25 Y96.705 E.00609
; LINE_WIDTH: 0.507334
G1 X86.023 Y96.687 E.00548
G1 X85.44 Y96.687 E.01401
G1 X85.441 Y97.332 E.01549
G1 X85.968 Y97.044 E.01443
; LINE_WIDTH: 0.526435
G1 X86.292 Y96.912 E.00874
; LINE_WIDTH: 0.56878
G1 X86.615 Y96.779 E.00948
; LINE_WIDTH: 0.603672
G1 X86.649 Y96.765 E.00105
; WIPE_START
G1 X86.615 Y96.779 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X89.66 Y96.685 Z1.32 F18000
G1 Z.92
G1 E.4 F1800
; LINE_WIDTH: 0.506992
G1 F1500
M204 S6000
G1 X88.958 Y96.685 E.01685
; LINE_WIDTH: 0.521077
G1 X88.675 Y96.7 E.007
; LINE_WIDTH: 0.549247
G1 X88.392 Y96.714 E.00739
; LINE_WIDTH: 0.579162
G1 X88.249 Y96.73 E.00398
; LINE_WIDTH: 0.572992
G1 X88.584 Y96.843 E.00966
; LINE_WIDTH: 0.511458
G1 X88.919 Y96.956 E.00857
G1 X89.66 Y97.312 E.0199
G1 X89.66 Y96.745 E.01374
M204 S10000
G1 X90.097 Y96.247 F18000
; LINE_WIDTH: 0.419992
G1 F1500
M204 S6000
G1 X85.002 Y96.251 E.10021
G1 X85.006 Y98.172 E.03779
G1 X85.057 Y98.217 E.00134
G1 X85.643 Y97.72 E.0151
G1 X86.175 Y97.429 E.01193
G1 X86.763 Y97.235 E.01219
G1 X87.358 Y97.151 E.01182
G1 X88.213 Y97.21 E.01685
G1 X88.797 Y97.376 E.01193
G1 X89.352 Y97.651 E.01219
G1 X89.835 Y98.009 E.01182
G1 X90.097 Y98.3 E.00771
G1 X90.097 Y96.307 E.0392
; CHANGE_LAYER
; Z_HEIGHT: 1.04
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F1500
G1 X90.097 Y98.3 E-.37869
G1 X90.093 Y98.295 E-.00131
; WIPE_END
G1 E-.02 F1800
; layer num/total_layer_count: 8/49
; update layer progress
M73 L8
M991 S0 P7 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z1.32 I1.057 J.602 P1  F18000
G1 X94.431 Y90.682 Z1.32
G1 Z1.04
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X94.269 Y90.682 E.00342
G1 X94.269 Y90.22 E.00977
G1 X95.431 Y90.22 E.02458
G1 X95.431 Y90.682 E.00977
G1 X94.491 Y90.682 E.0199
; WIPE_START
M204 S6000
G1 X94.269 Y90.682 E-.04209
G1 X94.269 Y90.22 E-.08769
G1 X95.431 Y90.22 E-.22069
G1 X95.431 Y90.375 E-.02952
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X98.669 Y90.22 Z1.44 F18000
G1 Z1.04
G1 E.4 F1800
G1 F1500
M204 S500
G1 X99.831 Y90.22 E.02458
G1 X99.831 Y90.682 E.00977
G1 X98.669 Y90.682 E.02458
G1 X98.669 Y90.28 E.0085
; WIPE_START
M204 S6000
G1 X99.831 Y90.22 E-.22098
G1 X99.831 Y90.682 E-.08769
G1 X99.455 Y90.682 E-.07132
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X98.638 Y94.889 Z1.44 F18000
G1 Z1.04
G1 E.4 F1800
G1 F1500
M204 S500
G1 X99.407 Y94.12 E.02301
G1 X99.407 Y95.357 E.02619
G1 X98.169 Y95.357 E.02619
G1 X98.595 Y94.931 E.01276
M204 S10000
G1 X98.338 Y94.589 F18000
G1 F1500
M204 S500
G1 X99.831 Y93.096 E.04469
G1 X99.831 Y95.782 E.05685
G1 X97.145 Y95.782 E.05685
G1 X98.295 Y94.631 E.03444
; WIPE_START
M204 S6000
G1 X99.71 Y93.217 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X96.569 Y87.944 Z1.44 F18000
G1 Z1.04
G1 E.4 F1800
G1 F1500
M204 S500
G1 X97.531 Y87.944 E.02035
G1 X97.05 Y88.425 E.01439
G1 X96.612 Y87.987 E.01312
; WIPE_START
M204 S6000
G1 X97.531 Y87.944 E-.17484
G1 X97.05 Y88.425 E-.1292
G1 X96.767 Y88.143 E-.07596
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X94.693 Y94.12 Z1.44 F18000
G1 Z1.04
G1 E.4 F1800
G1 F1500
M204 S500
G1 X95.931 Y95.357 E.03704
G1 X94.693 Y95.357 E.02619
G1 X94.693 Y94.18 E.02492
; WIPE_START
M204 S6000
G1 X95.931 Y95.357 E-.32453
G1 X95.639 Y95.357 E-.05547
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X89.619 Y98.374 Z1.44 F18000
G1 Z1.04
G1 E.4 F1800
G1 F1500
M204 S500
G1 X89.449 Y98.22 E.00486
G1 X89.138 Y98.001 E.00804
G1 X88.663 Y97.764 E.01124
G1 X88.154 Y97.615 E.01123
G1 X87.778 Y97.564 E.00804
G1 X87.398 Y97.558 E.00804
G1 X86.887 Y97.628 E.0109
G1 X86.523 Y97.734 E.00804
G1 X86.175 Y97.883 E.008
G1 X85.742 Y98.148 E.01075
G1 X85.318 Y98.525 E.01202
G1 X84.98 Y98.963 E.0117
M73 P39 R17
G1 X84.793 Y99.328 E.00868
G1 X84.598 Y99.281 E.00424
G1 X84.593 Y95.842 E.0728
G1 X90.507 Y95.837 E.12519
G1 X90.502 Y99.282 E.07291
G1 X90.305 Y99.328 E.00428
G1 X90.16 Y99.031 E.00698
G1 X89.958 Y98.737 E.00756
G1 X89.719 Y98.464 E.00768
G1 X89.664 Y98.414 E.00158
M204 S10000
G1 X89.336 Y98.689 F18000
G1 F1500
M204 S500
G1 X89.417 Y98.762 E.00231
G1 X89.622 Y98.997 E.00662
G1 X89.793 Y99.246 E.00638
G1 X90.004 Y99.678 E.01018
G1 X90.13 Y100.133 E.00999
G1 X90.172 Y100.601 E.00995
G1 X90.13 Y101.069 E.00995
G1 X90.007 Y101.513 E.00975
G1 X89.876 Y101.808 E.00683
G1 X89.71 Y102.085 E.00683
G1 X89.418 Y102.441 E.00975
G1 X89.066 Y102.739 E.00975
G1 X88.792 Y102.908 E.00683
G1 X88.499 Y103.044 E.00683
G1 X88.057 Y103.173 E.00975
G1 X87.598 Y103.221 E.00975
G1 X87.276 Y103.207 E.00683
G1 X86.958 Y103.154 E.00683
G1 X86.52 Y103.012 E.00975
G1 X86.106 Y102.789 E.00995
G1 X85.738 Y102.496 E.00995
G1 X85.429 Y102.142 E.00995
G1 X85.187 Y101.737 E.00999
G1 X85.021 Y101.285 E.01018
G1 X84.959 Y100.991 E.00638
G1 X84.93 Y100.67 E.00681
G1 X84.957 Y100.219 E.00956
G1 X85.024 Y99.904 E.00682
G1 X85.121 Y99.619 E.00637
G1 X85.339 Y99.191 E.01018
G1 X85.629 Y98.816 E.01003
G1 X85.996 Y98.49 E.01038
G1 X86.37 Y98.261 E.0093
G1 X86.666 Y98.134 E.00681
G1 X86.976 Y98.044 E.00683
G1 X87.423 Y97.983 E.00956
G1 X87.746 Y97.988 E.00683
G1 X88.066 Y98.031 E.00683
G1 X88.508 Y98.16 E.00975
G1 X88.92 Y98.367 E.00975
G1 X89.184 Y98.552 E.00683
G1 X89.291 Y98.649 E.00305
M204 S250
G1 X89.062 Y98.993 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X89.125 Y99.05 E.00166
G1 X89.298 Y99.249 E.0052
G1 X89.438 Y99.453 E.00486
G1 X89.62 Y99.823 E.00812
G1 X89.725 Y100.206 E.00781
G1 X89.761 Y100.601 E.00779
G1 X89.725 Y100.996 E.00779
G1 X89.621 Y101.375 E.00774
G1 X89.512 Y101.619 E.00526
G1 X89.375 Y101.849 E.00526
G1 X89.125 Y102.152 E.00773
G1 X88.825 Y102.407 E.00773
G1 X88.597 Y102.547 E.00526
G1 X88.355 Y102.66 E.00526
G1 X87.977 Y102.77 E.00773
G1 X87.586 Y102.811 E.00774
G1 X87.319 Y102.799 E.00526
G1 X87.055 Y102.755 E.00527
G1 X86.681 Y102.634 E.00773
G1 X86.332 Y102.446 E.00779
G1 X86.022 Y102.199 E.0078
G1 X85.761 Y101.9 E.0078
G1 X85.558 Y101.56 E.00781
G1 X85.415 Y101.172 E.00812
G1 X85.364 Y100.93 E.00486
G1 X85.34 Y100.664 E.00526
G1 X85.364 Y100.274 E.00767
G1 X85.419 Y100.013 E.00526
G1 X85.499 Y99.779 E.00486
G1 X85.686 Y99.411 E.00812
G1 X85.93 Y99.097 E.00782
G1 X86.241 Y98.82 E.00819
G1 X86.559 Y98.625 E.00734
G1 X86.804 Y98.52 E.00525
G1 X87.061 Y98.445 E.00526
G1 X87.448 Y98.393 E.00767
G1 X87.715 Y98.397 E.00526
G1 X87.98 Y98.433 E.00526
G1 X88.358 Y98.543 E.00773
G1 X88.709 Y98.719 E.00774
G1 X88.928 Y98.873 E.00526
G1 X89.017 Y98.953 E.00235
; WIPE_START
M204 S6000
G1 X89.125 Y99.05 E-.02748
G1 X89.298 Y99.249 E-.05019
G1 X89.438 Y99.453 E-.04699
G1 X89.62 Y99.823 E-.07844
G1 X89.725 Y100.206 E-.07545
G1 X89.761 Y100.601 E-.07529
G1 X89.749 Y100.738 E-.02615
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X93.022 Y93.843 Z1.44 F18000
G1 X95.869 Y87.844 Z1.44
G1 Z1.04
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X95.869 Y87.52 E.00686
G1 X96.869 Y87.52 E.02117
G1 X96.869 Y77.382 E.21459
G1 X94.582 Y77.382 E.0484
G1 X94.514 Y77.05 E.00717
G1 X94.373 Y76.788 E.00629
G1 X94.163 Y76.578 E.00629
G1 X93.901 Y76.437 E.00629
G1 X93.636 Y76.382 E.00572
G1 X81.496 Y76.382 E.25696
G1 X81.206 Y76.433 E.00624
G1 X80.924 Y76.587 E.00679
G1 X80.69 Y76.837 E.00725
G1 X80.542 Y77.181 E.00793
G1 X80.531 Y94.437 E.36524
G1 X80.555 Y94.646 E.00446
G1 X80.672 Y94.94 E.00669
G1 X80.961 Y95.246 E.00893
G1 X81.256 Y95.384 E.00688
G1 X81.505 Y95.42 E.00533
G1 X94.269 Y95.41 E.27016
G1 X94.269 Y93.096 E.04898
G1 X96.955 Y95.782 E.08039
G1 X90.932 Y95.782 E.12749
G1 X90.924 Y100.801 E.10623
G1 X90.876 Y101.199 E.00849
G1 X90.782 Y101.588 E.00847
G1 X90.643 Y101.963 E.00848
G1 X90.456 Y102.328 E.00867
G1 X90.111 Y102.806 E.01246
G1 X89.804 Y103.118 E.00928
G1 X89.514 Y103.352 E.0079
G1 X89.19 Y103.557 E.00811
G1 X88.822 Y103.732 E.00862
G1 X88.406 Y103.869 E.00927
G1 X88.041 Y103.945 E.0079
G1 X87.659 Y103.979 E.00811
G1 X87.25 Y103.967 E.00866
G1 X86.854 Y103.908 E.00848
G1 X86.468 Y103.803 E.00848
G1 X85.926 Y103.565 E.01251
G1 X85.58 Y103.347 E.00867
G1 X85.269 Y103.094 E.00848
G1 X84.99 Y102.807 E.00847
G1 X84.747 Y102.489 E.00847
G1 X84.543 Y102.144 E.00848
G1 X84.32 Y101.596 E.01252
G1 X84.231 Y101.234 E.0079
G1 X84.176 Y100.798 E.00929
G1 X84.168 Y95.783 E.10616
G1 X81.479 Y95.778 E.05691
G1 X81.223 Y95.741 E.00548
G1 X80.931 Y95.634 E.00659
G1 X80.792 Y95.554 E.0034
G1 X80.546 Y95.348 E.00678
G1 X80.36 Y95.098 E.00659
G1 X80.251 Y94.864 E.00547
G1 X80.207 Y94.719 E.0032
G1 X80.169 Y94.383 E.00717
G1 X80.169 Y77.419 E.35905
G1 X80.206 Y77.092 E.00697
G1 X80.287 Y76.848 E.00543
G1 X80.359 Y76.706 E.00339
G1 X80.493 Y76.516 E.00492
G1 X80.67 Y76.339 E.0053
G1 X80.785 Y76.254 E.00302
G1 X81.004 Y76.135 E.00528
G1 X81.241 Y76.057 E.00528
G1 X81.39 Y76.03 E.00321
G1 X93.541 Y76.021 E.25719
G1 X93.797 Y76.044 E.00545
G1 X93.946 Y76.079 E.00323
G1 X94.24 Y76.206 E.00678
G1 X94.374 Y76.294 E.0034
G1 X94.601 Y76.507 E.00659
G1 X94.96 Y77.02 E.01325
G1 X97.231 Y77.02 E.04807
G1 X97.231 Y87.52 E.22224
G1 X98.231 Y87.52 E.02117
G1 X98.231 Y87.844 E.00686
G1 X97.05 Y89.025 E.03534
G1 X95.912 Y87.887 E.03407
; WIPE_START
M204 S6000
G1 X95.869 Y87.52 E-.07014
G1 X96.869 Y87.52 E-.19
G1 X96.869 Y86.889 E-.11986
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X94.84 Y91.091 Z1.44 F18000
G1 Z1.04
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X94.84 Y93.088 E.03928
G1 X97.05 Y95.298 E.06147
G1 X99.26 Y93.088 E.06147
G1 X99.26 Y91.091 E.03928
G1 X98.26 Y91.091 E.01967
G1 X98.26 Y89.811 E.02518
G1 X100.24 Y89.811 E.03895
G1 X100.24 Y96.191 E.12549
G1 X91.34 Y96.191 E.17505
G1 X91.333 Y100.825 E.09115
G1 X91.28 Y101.271 E.00883
G1 X91.174 Y101.708 E.00883
G1 X91.018 Y102.129 E.00883
G1 X90.812 Y102.531 E.00889
G1 X90.695 Y102.715 E.00429
G1 X90.421 Y103.074 E.00888
G1 X90.079 Y103.422 E.00959
G1 X89.757 Y103.682 E.00815
G1 X89.573 Y103.806 E.00436
G1 X89.382 Y103.918 E.00436
G1 X88.975 Y104.112 E.00888
G1 X88.512 Y104.265 E.00958
G1 X88.107 Y104.35 E.00815
G1 X87.886 Y104.376 E.00436
G1 X87.665 Y104.389 E.00436
G1 X87.214 Y104.376 E.00889
G1 X86.769 Y104.309 E.00883
G1 X86.336 Y104.191 E.00883
G1 X85.917 Y104.021 E.00889
G1 X85.723 Y103.921 E.0043
G1 X85.341 Y103.68 E.00889
G1 X84.992 Y103.397 E.00883
G1 X84.679 Y103.075 E.00883
G1 X84.407 Y102.718 E.00883
G1 X84.179 Y102.331 E.00883
G1 X83.996 Y101.918 E.00889
G1 X83.926 Y101.711 E.0043
G1 X83.828 Y101.308 E.00815
G1 X83.767 Y100.824 E.00959
G1 X83.76 Y96.191 E.09113
G1 X81.449 Y96.188 E.04545
G1 X81.134 Y96.141 E.00626
G1 X80.938 Y96.083 E.00403
G1 X80.747 Y96 E.0041
G1 X80.566 Y95.896 E.0041
G1 X80.4 Y95.772 E.00409
G1 X80.248 Y95.629 E.00409
G1 X80.114 Y95.47 E.00409
G1 X80.002 Y95.298 E.00403
G1 X79.867 Y95.01 E.00626
G1 X79.809 Y94.814 E.00403
G1 X79.772 Y94.609 E.00409
G1 X79.76 Y94.395 E.00422
G1 X79.76 Y77.407 E.33413
G1 X79.772 Y77.193 E.00422
G1 X79.808 Y76.991 E.00403
G1 X79.908 Y76.69 E.00624
G1 X80.008 Y76.494 E.00434
G1 X80.179 Y76.251 E.00584
G1 X80.402 Y76.028 E.0062
G1 X80.564 Y75.907 E.00397
G1 X80.841 Y75.758 E.00619
G1 X81.14 Y75.659 E.0062
G1 X81.342 Y75.623 E.00403
G1 X81.556 Y75.611 E.00421
G1 X93.559 Y75.611 E.23609
G1 X93.863 Y75.639 E.006
G1 X94.063 Y75.686 E.00404
G1 X94.259 Y75.758 E.00409
G1 X94.445 Y75.851 E.00409
G1 X94.619 Y75.965 E.00409
G1 X94.778 Y76.099 E.00409
G1 X94.919 Y76.248 E.00404
G1 X95.173 Y76.611 E.00871
G1 X97.64 Y76.611 E.04853
G1 X97.64 Y87.111 E.20653
G1 X98.64 Y87.111 E.01967
G1 X98.64 Y88.014 E.01776
G1 X97.05 Y89.604 E.04423
G1 X95.46 Y88.014 E.04423
G1 X95.46 Y87.111 E.01776
G1 X96.46 Y87.111 E.01967
G1 X96.46 Y77.791 E.18332
G1 X94.16 Y77.791 E.04524
G1 X94.159 Y77.356 E.00855
G1 X94.125 Y77.191 E.0033
G1 X94.041 Y77.035 E.00349
G1 X93.916 Y76.91 E.00349
G1 X93.76 Y76.826 E.00349
G1 X93.595 Y76.792 E.00331
G1 X81.532 Y76.791 E.23727
G1 X81.343 Y76.824 E.00377
G1 X81.178 Y76.914 E.0037
G1 X81.038 Y77.064 E.00404
G1 X80.951 Y77.265 E.00431
G1 X80.94 Y94.413 E.33728
M73 P39 R16
G1 X80.955 Y94.545 E.00261
G1 X81.023 Y94.716 E.00362
G1 X81.205 Y94.909 E.00521
G1 X81.375 Y94.987 E.00367
G1 X81.535 Y95.011 E.00319
G1 X93.86 Y95.001 E.24243
G1 X93.86 Y89.811 E.10209
G1 X95.84 Y89.811 E.03895
G1 X95.84 Y91.091 E.02518
G1 X94.9 Y91.091 E.01849
; WIPE_START
M204 S6000
G1 X94.84 Y93.088 E-.3796
G1 X94.842 Y93.089 E-.0004
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




G1 X94.35 Y92.887
G1 Z1.04
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.596542
G1 F1500
M204 S6000
G1 X94.35 Y90.886 E.05697
; WIPE_START
G1 X94.35 Y92.886 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X95.077 Y94.958 Z1.44 F18000
G1 Z1.04
G1 E.4 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.365752
G1 F1500
M204 S6000
G1 X95.013 Y94.995 E.00125
G1 X95.062 Y95.023 E.00095
; WIPE_START
G1 X95.013 Y94.995 E-.16436
G1 X95.077 Y94.958 E-.21564
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X99.065 Y94.958 Z1.44 F18000
G1 Z1.04
G1 E.4 F1800
G1 F1500
M204 S6000
G1 X99.002 Y94.995 E.00125
G1 X99.05 Y95.023 E.00095
; WIPE_START
G1 X99.002 Y94.995 E-.16436
G1 X99.065 Y94.958 E-.21564
; WIPE_END
M73 P40 R16
G1 E-.02 F1800
M204 S10000
G1 X99.75 Y92.887 Z1.44 F18000
G1 Z1.04
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.596522
G1 F1500
M204 S6000
G1 X99.75 Y90.886 E.05697
; WIPE_START
G1 X99.75 Y92.886 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X93.19 Y96.787 Z1.44 F18000
G1 X90.147 Y98.596 Z1.44
G1 Z1.04
G1 E.4 F1800
; LINE_WIDTH: 0.0947242
G1 F1500
M204 S6000
G1 X90.249 Y98.711 E.00053
G1 X90.272 Y98.785 E.00027
M204 S10000
G1 X90.448 Y99.512 F18000
; LINE_WIDTH: 0.470421
G1 F1500
M204 S6000
G1 X90.485 Y99.777 E.00593
; LINE_WIDTH: 0.428096
G1 X90.522 Y100.042 E.00537
; LINE_WIDTH: 0.403548
G1 X90.526 Y100.078 E.00068
; LINE_WIDTH: 0.376948
G1 X90.548 Y100.586 E.00891
; LINE_WIDTH: 0.360506
G1 X90.503 Y101.132 E.00914
G1 X90.415 Y101.476 E.00593
G1 X90.294 Y101.807 E.00589
G1 X90.027 Y102.293 E.00925
G1 X89.821 Y102.554 E.00555
G1 X89.548 Y102.832 E.00651
G1 X89.151 Y103.136 E.00835
G1 X88.62 Y103.402 E.00992
G1 X88.307 Y103.499 E.00548
G1 X87.982 Y103.566 E.00555
G1 X87.622 Y103.6 E.00603
G1 X87.284 Y103.588 E.00565
G1 X86.856 Y103.518 E.00724
G1 X86.591 Y103.438 E.00463
G1 X86.253 Y103.302 E.00609
G1 X85.887 Y103.094 E.00703
G1 X85.526 Y102.813 E.00764
G1 X85.133 Y102.375 E.00983
G1 X84.854 Y101.913 E.00902
G1 X84.655 Y101.378 E.00953
G1 X84.588 Y101.056 E.0055
G1 X84.557 Y100.774 E.00473
G1 X84.567 Y100.18 E.00992
; LINE_WIDTH: 0.404454
G1 X84.587 Y99.978 E.00384
; LINE_WIDTH: 0.44427
G1 X84.605 Y99.803 E.00368
; LINE_WIDTH: 0.475302
G1 X84.652 Y99.513 E.00659
M204 S10000
G1 X84.828 Y98.783 F18000
; LINE_WIDTH: 0.0948991
G1 F1500
M204 S6000
G1 X84.851 Y98.713 E.00025
G1 X84.981 Y98.574 E.00066
; WIPE_START
G1 X84.851 Y98.713 E-.27394
G1 X84.828 Y98.783 E-.10606
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X86.724 Y96.741 Z1.44 F18000
G1 Z1.04
G1 E.4 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.595442
G1 F1500
M204 S6000
G1 X87.011 Y96.722 E.00818
; LINE_WIDTH: 0.563822
G1 X87.298 Y96.702 E.00772
G1 X88.189 Y96.728 E.02394
; WIPE_START
G1 X87.298 Y96.702 E-.28732
G1 X87.011 Y96.722 E-.09268
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X86.724 Y96.741 Z1.44 F18000
G1 Z1.04
G1 E.4 F1800
; LINE_WIDTH: 0.595844
G1 F1500
M204 S6000
G1 X86.413 Y96.722 E.00884
; LINE_WIDTH: 0.557867
G1 X86.103 Y96.704 E.00826
; LINE_WIDTH: 0.504155
G1 X85.438 Y96.685 E.01588
G1 X85.439 Y97.344 E.01573
G1 X85.864 Y97.099 E.01172
; LINE_WIDTH: 0.52092
G1 X86.24 Y96.943 E.01006
; LINE_WIDTH: 0.560955
G1 X86.617 Y96.787 E.01087
; LINE_WIDTH: 0.597902
G1 X86.668 Y96.765 E.00161
; WIPE_START
G1 X86.617 Y96.787 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X89.659 Y96.685 Z1.44 F18000
G1 Z1.04
G1 E.4 F1800
; LINE_WIDTH: 0.506822
G1 F1500
M204 S6000
G1 X88.958 Y96.685 E.01683
; LINE_WIDTH: 0.520935
G1 X88.675 Y96.7 E.00699
; LINE_WIDTH: 0.54916
G1 X88.392 Y96.714 E.00739
; LINE_WIDTH: 0.579132
G1 X88.249 Y96.73 E.00398
; LINE_WIDTH: 0.57295
G1 X88.584 Y96.843 E.00966
; LINE_WIDTH: 0.511226
G1 X88.919 Y96.956 E.00857
G1 X89.531 Y97.251 E.01645
G1 X89.658 Y97.332 E.00364
G1 X89.659 Y96.745 E.01421
M204 S10000
G1 X90.098 Y96.247 F18000
; LINE_WIDTH: 0.419992
G1 F1500
M204 S6000
G1 X85.002 Y96.251 E.10021
G1 X85.005 Y98.088 E.03613
G1 X85.071 Y98.097 E.0013
G1 X85.126 Y98.149 E.00148
G1 X85.512 Y97.809 E.01012
G1 X85.974 Y97.526 E.01067
G1 X86.777 Y97.234 E.01679
G1 X87.358 Y97.151 E.01156
G1 X88.213 Y97.21 E.01685
G1 X88.797 Y97.376 E.01193
G1 X89.335 Y97.642 E.01182
G1 X89.719 Y97.912 E.00922
G1 X89.997 Y98.183 E.00764
G1 X90.095 Y98.069 E.00295
G1 X90.097 Y96.307 E.03466
; CHANGE_LAYER
; Z_HEIGHT: 1.16
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F1500
G1 X90.095 Y98.069 E-.33481
G1 X89.997 Y98.183 E-.02852
G1 X89.934 Y98.122 E-.01667
; WIPE_END
G1 E-.02 F1800
; layer num/total_layer_count: 9/49
; update layer progress
M73 L9
M991 S0 P8 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z1.44 I1.042 J.629 P1  F18000
G1 X94.431 Y90.682 Z1.44
G1 Z1.16
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X94.269 Y90.682 E.00342
G1 X94.269 Y90.22 E.00977
G1 X95.431 Y90.22 E.02458
G1 X95.431 Y90.682 E.00977
G1 X94.491 Y90.682 E.0199
; WIPE_START
M204 S6000
G1 X94.269 Y90.682 E-.04209
G1 X94.269 Y90.22 E-.08769
G1 X95.431 Y90.22 E-.22069
G1 X95.431 Y90.376 E-.02952
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X98.669 Y90.22 Z1.56 F18000
G1 Z1.16
G1 E.4 F1800
G1 F1500
M204 S500
G1 X99.831 Y90.22 E.02458
G1 X99.831 Y90.682 E.00977
G1 X98.669 Y90.682 E.02458
G1 X98.669 Y90.28 E.0085
; WIPE_START
M204 S6000
G1 X99.831 Y90.22 E-.22098
G1 X99.831 Y90.682 E-.08769
G1 X99.455 Y90.682 E-.07132
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X98.638 Y94.889 Z1.56 F18000
G1 Z1.16
G1 E.4 F1800
G1 F1500
M204 S500
G1 X99.407 Y94.12 E.02301
G1 X99.407 Y95.357 E.02619
G1 X98.169 Y95.357 E.02619
G1 X98.595 Y94.931 E.01276
M204 S10000
G1 X98.338 Y94.589 F18000
G1 F1500
M204 S500
G1 X99.831 Y93.096 E.04469
G1 X99.831 Y95.782 E.05685
G1 X97.145 Y95.782 E.05685
G1 X98.295 Y94.631 E.03444
; WIPE_START
M204 S6000
G1 X99.71 Y93.217 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X96.569 Y87.944 Z1.56 F18000
G1 Z1.16
G1 E.4 F1800
G1 F1500
M204 S500
G1 X97.531 Y87.944 E.02035
G1 X97.05 Y88.425 E.01439
G1 X96.612 Y87.987 E.01312
; WIPE_START
M204 S6000
G1 X97.531 Y87.944 E-.17484
G1 X97.05 Y88.425 E-.1292
G1 X96.767 Y88.143 E-.07596
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X94.693 Y94.12 Z1.56 F18000
G1 Z1.16
G1 E.4 F1800
G1 F1500
M204 S500
G1 X95.931 Y95.357 E.03704
G1 X94.693 Y95.357 E.02619
G1 X94.693 Y94.18 E.02492
; WIPE_START
M204 S6000
G1 X95.931 Y95.357 E-.32452
G1 X95.639 Y95.357 E-.05549
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X89.652 Y98.403 Z1.56 F18000
G1 Z1.16
G1 E.4 F1800
G1 F1500
M204 S500
G1 X89.577 Y98.327 E.00226
G1 X89.152 Y98.008 E.01123
G1 X88.663 Y97.764 E.01157
G1 X88.154 Y97.615 E.01123
G1 X87.778 Y97.564 E.00804
G1 X87.398 Y97.558 E.00804
G1 X86.872 Y97.63 E.01124
G1 X86.367 Y97.794 E.01123
G1 X86.029 Y97.963 E.00801
G1 X85.732 Y98.157 E.0075
G1 X85.318 Y98.525 E.01173
G1 X84.979 Y98.963 E.01172
G1 X84.793 Y99.328 E.00868
G1 X84.598 Y99.282 E.00424
G1 X84.593 Y95.842 E.0728
G1 X90.507 Y95.838 E.12519
G1 X90.502 Y99.276 E.07278
G1 X90.311 Y99.325 E.00418
G1 X90.078 Y98.901 E.01024
G1 X89.843 Y98.597 E.00812
G1 X89.694 Y98.445 E.00451
M204 S10000
G1 X89.35 Y98.7 F18000
G1 F1500
M204 S500
G1 X89.523 Y98.877 E.00524
G1 X89.722 Y99.134 E.00688
G1 X89.95 Y99.549 E.01003
G1 X90.054 Y99.829 E.00632
G1 X90.13 Y100.142 E.00681
G1 X90.172 Y100.601 E.00975
G1 X90.129 Y101.071 E.00999
G1 X89.998 Y101.536 E.01023
G1 X89.875 Y101.809 E.00632
G1 X89.71 Y102.085 E.00681
G1 X89.418 Y102.441 E.00975
G1 X89.066 Y102.739 E.00975
G1 X88.792 Y102.908 E.00681
G1 X88.522 Y103.034 E.00632
G1 X88.059 Y103.173 E.01023
G1 X87.589 Y103.222 E.01
G1 X87.121 Y103.187 E.00995
G1 X86.664 Y103.068 E.01
G1 X86.226 Y102.862 E.01023
G1 X85.978 Y102.697 E.00632
G1 X85.732 Y102.489 E.00681
G1 X85.429 Y102.142 E.00975
G1 X85.193 Y101.746 E.00975
G1 X85.07 Y101.448 E.00683
G1 X84.984 Y101.137 E.00683
G1 X84.929 Y100.679 E.00975
G1 X84.957 Y100.219 E.00975
G1 X85.024 Y99.905 E.00681
G1 X85.12 Y99.622 E.00632
G1 X85.339 Y99.191 E.01023
G1 X85.629 Y98.816 E.01004
G1 X85.991 Y98.495 E.01023
G1 X86.241 Y98.331 E.00632
G1 X86.528 Y98.187 E.00681
G1 X86.966 Y98.045 E.00975
G1 X87.423 Y97.983 E.00975
G1 X87.746 Y97.988 E.00683
G1 X88.066 Y98.031 E.00683
G1 X88.508 Y98.16 E.00975
G1 X88.928 Y98.371 E.00995
G1 X89.297 Y98.647 E.00975
G1 X89.307 Y98.658 E.00032
M204 S250
G1 X89.058 Y98.988 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X89.215 Y99.147 E.00439
G1 X89.379 Y99.359 E.00528
G1 X89.577 Y99.72 E.00811
G1 X89.662 Y99.95 E.00482
G1 X89.726 Y100.209 E.00526
G1 X89.761 Y100.601 E.00773
G1 X89.725 Y100.996 E.00781
G1 X89.612 Y101.396 E.00817
G1 X89.512 Y101.619 E.00482
G1 X89.375 Y101.849 E.00526
G1 X89.125 Y102.153 E.00774
G1 X88.825 Y102.407 E.00773
G1 X88.598 Y102.547 E.00525
G1 X88.376 Y102.651 E.00482
G1 X87.978 Y102.77 E.00817
G1 X87.583 Y102.811 E.00781
G1 X87.188 Y102.782 E.00779
G1 X86.803 Y102.682 E.00781
G1 X86.428 Y102.505 E.00817
G1 X86.224 Y102.369 E.00482
G1 X86.02 Y102.197 E.00525
G1 X85.761 Y101.9 E.00773
G1 X85.56 Y101.563 E.00774
G1 X85.458 Y101.315 E.00526
G1 X85.387 Y101.057 E.00526
G1 X85.34 Y100.667 E.00773
G1 X85.364 Y100.274 E.00774
G1 X85.419 Y100.013 E.00525
G1 X85.498 Y99.781 E.00482
G1 X85.686 Y99.411 E.00817
G1 X85.93 Y99.097 E.00782
G1 X86.24 Y98.821 E.00817
G1 X86.445 Y98.687 E.00481
G1 X86.684 Y98.567 E.00526
G1 X87.058 Y98.445 E.00773
G1 X87.448 Y98.393 E.00774
G1 X87.715 Y98.397 E.00526
G1 X87.98 Y98.433 E.00526
G1 X88.358 Y98.543 E.00773
G1 X88.712 Y98.72 E.0078
G1 X89.014 Y98.947 E.00743
; WIPE_START
M204 S6000
G1 X89.215 Y99.147 E-.05376
G1 X89.379 Y99.359 E-.05097
G1 X89.577 Y99.72 E-.07831
G1 X89.662 Y99.95 E-.04652
G1 X89.726 Y100.209 E-.05079
G1 X89.761 Y100.601 E-.07469
G1 X89.749 Y100.732 E-.02496
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X93.023 Y93.837 Z1.56 F18000
G1 X95.869 Y87.844 Z1.56
G1 Z1.16
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X95.869 Y87.52 E.00686
G1 X96.869 Y87.52 E.02117
G1 X96.869 Y77.382 E.21459
G1 X94.582 Y77.382 E.0484
G1 X94.514 Y77.05 E.00717
G1 X94.373 Y76.788 E.00629
G1 X94.162 Y76.578 E.0063
G1 X93.901 Y76.437 E.00629
G1 X93.637 Y76.382 E.00571
G1 X81.496 Y76.382 E.25697
G1 X81.205 Y76.433 E.00624
G1 X80.923 Y76.587 E.0068
G1 X80.69 Y76.837 E.00724
G1 X80.542 Y77.181 E.00792
G1 X80.531 Y94.475 E.36605
G1 X80.621 Y94.845 E.00807
G1 X80.8 Y95.098 E.00656
G1 X80.995 Y95.262 E.00539
G1 X81.256 Y95.384 E.0061
G1 X81.505 Y95.42 E.00534
G1 X94.269 Y95.411 E.27016
G1 X94.269 Y93.096 E.04899
G1 X96.955 Y95.782 E.08039
G1 X90.932 Y95.782 E.12749
G1 X90.924 Y100.801 E.10623
G1 X90.876 Y101.199 E.00849
G1 X90.782 Y101.588 E.00848
G1 X90.643 Y101.963 E.00847
G1 X90.359 Y102.482 E.01252
G1 X90.11 Y102.807 E.00867
G1 X89.831 Y103.095 E.00848
G1 X89.52 Y103.347 E.00849
G1 X89.009 Y103.65 E.01255
G1 X88.441 Y103.862 E.01284
G1 X87.89 Y103.962 E.01186
G1 X87.447 Y103.979 E.00939
G1 X86.86 Y103.91 E.0125
G1 X86.468 Y103.803 E.00861
G1 X86.088 Y103.649 E.00867
G1 X85.58 Y103.347 E.01251
G1 X85.269 Y103.095 E.00848
G1 X84.99 Y102.807 E.00848
G1 X84.747 Y102.489 E.00847
G1 X84.543 Y102.144 E.00847
G1 X84.32 Y101.596 E.01253
G1 X84.232 Y101.238 E.0078
G1 X84.176 Y100.798 E.00938
G1 X84.168 Y95.783 E.10616
G1 X81.479 Y95.778 E.05691
G1 X81.223 Y95.741 E.00548
G1 X80.931 Y95.634 E.00659
G1 X80.792 Y95.554 E.0034
G1 X80.541 Y95.341 E.00696
G1 X80.393 Y95.152 E.00507
G1 X80.317 Y95.02 E.00323
G1 X80.207 Y94.719 E.00678
G1 X80.169 Y94.383 E.00716
G1 X80.169 Y77.419 E.35906
G1 X80.206 Y77.092 E.00697
G1 X80.284 Y76.855 E.00528
G1 X80.403 Y76.635 E.00528
G1 X80.488 Y76.521 E.00302
G1 X80.669 Y76.34 E.00542
G1 X80.8 Y76.244 E.00344
G1 X81.011 Y76.131 E.00507
G1 X81.146 Y76.082 E.00304
G1 X81.399 Y76.03 E.00547
G1 X93.543 Y76.021 E.25704
G1 X93.797 Y76.044 E.0054
G1 X93.946 Y76.079 E.00323
G1 X94.24 Y76.206 E.00678
G1 X94.374 Y76.294 E.0034
G1 X94.49 Y76.391 E.00321
G1 X94.662 Y76.585 E.00547
G1 X94.948 Y77.02 E.01103
G1 X97.231 Y77.02 E.04831
G1 X97.231 Y87.52 E.22224
G1 X98.231 Y87.52 E.02117
G1 X98.231 Y87.844 E.00686
G1 X97.05 Y89.025 E.03534
G1 X95.912 Y87.887 E.03407
; WIPE_START
M204 S6000
G1 X95.869 Y87.52 E-.07014
G1 X96.869 Y87.52 E-.19
G1 X96.869 Y86.889 E-.11986
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X94.84 Y91.091 Z1.56 F18000
G1 Z1.16
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X94.84 Y93.088 E.03928
G1 X97.05 Y95.298 E.06147
G1 X99.26 Y93.088 E.06147
G1 X99.26 Y91.091 E.03928
G1 X98.26 Y91.091 E.01967
G1 X98.26 Y89.811 E.02518
G1 X100.24 Y89.811 E.03895
G1 X100.24 Y96.191 E.12549
G1 X91.34 Y96.191 E.17505
G1 X91.333 Y100.825 E.09115
G1 X91.28 Y101.271 E.00883
G1 X91.174 Y101.708 E.00883
G1 X91.018 Y102.129 E.00883
G1 X90.812 Y102.531 E.00889
G1 X90.695 Y102.716 E.0043
G1 X90.421 Y103.075 E.00889
G1 X90.108 Y103.397 E.00883
G1 X89.759 Y103.68 E.00884
G1 X89.413 Y103.9 E.00806
G1 X89.182 Y104.021 E.00514
G1 X88.761 Y104.192 E.00893
G1 X88.549 Y104.257 E.00436
G1 X88.333 Y104.309 E.00436
G1 X87.929 Y104.371 E.00806
G1 X87.437 Y104.389 E.00968
G1 X87.029 Y104.354 E.00804
G1 X86.772 Y104.31 E.00514
G1 X86.336 Y104.191 E.00887
G1 X85.917 Y104.021 E.00889
G1 X85.723 Y103.921 E.0043
G1 X85.341 Y103.68 E.00889
G1 X84.992 Y103.397 E.00883
G1 X84.679 Y103.075 E.00883
G1 X84.407 Y102.718 E.00883
G1 X84.179 Y102.331 E.00883
M73 P41 R16
G1 X83.996 Y101.918 E.00889
G1 X83.926 Y101.71 E.0043
G1 X83.829 Y101.313 E.00805
G1 X83.767 Y100.824 E.00968
G1 X83.76 Y96.191 E.09113
G1 X81.449 Y96.188 E.04545
G1 X81.134 Y96.141 E.00626
G1 X80.938 Y96.083 E.00403
G1 X80.747 Y96 E.00409
G1 X80.567 Y95.896 E.0041
G1 X80.4 Y95.772 E.00408
G1 X80.237 Y95.616 E.00444
G1 X80.053 Y95.382 E.00585
G1 X79.951 Y95.204 E.00404
G1 X79.868 Y95.013 E.0041
G1 X79.809 Y94.814 E.00409
G1 X79.772 Y94.609 E.00409
G1 X79.76 Y94.395 E.00422
G1 X79.76 Y77.407 E.33413
G1 X79.772 Y77.193 E.00422
G1 X79.808 Y76.991 E.00403
G1 X79.907 Y76.692 E.00619
G1 X80.057 Y76.415 E.00619
G1 X80.177 Y76.253 E.00398
G1 X80.401 Y76.029 E.00624
G1 X80.581 Y75.897 E.00439
G1 X80.844 Y75.757 E.00585
G1 X81.034 Y75.687 E.00398
G1 X81.345 Y75.623 E.00626
G1 X81.556 Y75.611 E.00415
G1 X93.562 Y75.611 E.23614
G1 X93.863 Y75.639 E.00596
G1 X94.063 Y75.686 E.00404
G1 X94.259 Y75.758 E.00409
G1 X94.445 Y75.851 E.00409
G1 X94.619 Y75.965 E.00409
G1 X94.776 Y76.097 E.00403
G1 X94.987 Y76.335 E.00626
G1 X95.169 Y76.611 E.0065
G1 X97.64 Y76.611 E.04861
G1 X97.64 Y87.111 E.20653
G1 X98.64 Y87.111 E.01967
G1 X98.64 Y88.014 E.01776
G1 X97.05 Y89.604 E.04423
G1 X95.46 Y88.014 E.04423
G1 X95.46 Y87.111 E.01776
G1 X96.46 Y87.111 E.01967
G1 X96.46 Y77.791 E.18332
G1 X94.16 Y77.791 E.04524
G1 X94.159 Y77.356 E.00856
G1 X94.125 Y77.191 E.0033
G1 X94.041 Y77.035 E.00349
G1 X93.915 Y76.91 E.0035
G1 X93.759 Y76.826 E.00349
G1 X93.595 Y76.792 E.0033
G1 X81.532 Y76.791 E.23727
G1 X81.343 Y76.824 E.00377
G1 X81.177 Y76.915 E.00371
G1 X81.037 Y77.064 E.00403
G1 X80.951 Y77.265 E.0043
G1 X80.94 Y94.426 E.33754
G1 X81 Y94.673 E.00499
G1 X81.103 Y94.819 E.00352
G1 X81.216 Y94.914 E.00291
G1 X81.374 Y94.987 E.00343
G1 X81.535 Y95.011 E.00319
G1 X93.86 Y95.002 E.24242
G1 X93.86 Y89.811 E.1021
G1 X95.84 Y89.811 E.03895
G1 X95.84 Y91.091 E.02518
G1 X94.9 Y91.091 E.01849
; WIPE_START
M204 S6000
G1 X94.84 Y93.088 E-.3796
G1 X94.842 Y93.089 E-.0004
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




G1 X94.35 Y92.887
G1 Z1.16
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.596522
G1 F1500
M204 S6000
G1 X94.35 Y90.886 E.05697
; WIPE_START
G1 X94.35 Y92.886 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X95.077 Y94.958 Z1.56 F18000
G1 Z1.16
G1 E.4 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.365752
G1 F1500
M204 S6000
G1 X95.013 Y94.995 E.00125
G1 X95.062 Y95.023 E.00095
; WIPE_START
G1 X95.013 Y94.995 E-.16436
G1 X95.077 Y94.958 E-.21564
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X99.065 Y94.958 Z1.56 F18000
G1 Z1.16
G1 E.4 F1800
G1 F1500
M204 S6000
G1 X99.002 Y94.995 E.00125
G1 X99.05 Y95.023 E.00095
; WIPE_START
G1 X99.002 Y94.995 E-.16436
G1 X99.065 Y94.958 E-.21564
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X99.75 Y92.887 Z1.56 F18000
G1 Z1.16
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.596522
G1 F1500
M204 S6000
G1 X99.75 Y90.886 E.05697
; WIPE_START
G1 X99.75 Y92.886 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X93.601 Y97.407 Z1.56 F18000
G1 X90.457 Y99.718 Z1.56
G1 Z1.16
G1 E.4 F1800
; LINE_WIDTH: 0.414447
G1 F1500
M204 S6000
G1 X90.198 Y99.573 E.00576
M204 S10000
G1 X90.457 Y99.718 F18000
; LINE_WIDTH: 0.462458
G1 F1500
M204 S6000
G1 X90.485 Y99.735 E.00072
G1 X90.504 Y99.899 E.00359
; LINE_WIDTH: 0.423487
G1 X90.524 Y100.062 E.00327
; LINE_WIDTH: 0.377721
G1 X90.548 Y100.586 E.00921
; LINE_WIDTH: 0.36067
G1 X90.504 Y101.132 E.00914
G1 X90.414 Y101.475 E.00594
G1 X90.293 Y101.809 E.00593
G1 X90.126 Y102.133 E.00609
G1 X90.023 Y102.29 E.00314
G1 X89.675 Y102.715 E.00918
G1 X89.299 Y103.038 E.00828
G1 X88.962 Y103.242 E.00658
G1 X88.667 Y103.382 E.00545
G1 X88.148 Y103.541 E.00907
G1 X87.854 Y103.58 E.00497
G1 X87.459 Y103.596 E.00661
G1 X86.938 Y103.535 E.00875
G1 X86.549 Y103.429 E.00674
G1 X86.254 Y103.301 E.00539
G1 X85.758 Y103.005 E.00964
G1 X85.476 Y102.766 E.00617
G1 X85.281 Y102.556 E.00479
G1 X85.116 Y102.352 E.0044
G1 X84.883 Y101.97 E.00747
G1 X84.711 Y101.56 E.00743
G1 X84.606 Y101.167 E.00681
G1 X84.557 Y100.774 E.00661
G1 X84.567 Y100.18 E.00992
; LINE_WIDTH: 0.404439
G1 X84.587 Y99.978 E.00384
; LINE_WIDTH: 0.444226
G1 X84.605 Y99.803 E.00367
; LINE_WIDTH: 0.475215
G1 X84.652 Y99.513 E.00659
M204 S10000
G1 X84.828 Y98.783 F18000
; LINE_WIDTH: 0.0950827
G1 F1500
M204 S6000
G1 X84.852 Y98.712 E.00026
G1 X84.982 Y98.572 E.00066
; WIPE_START
G1 X84.852 Y98.712 E-.27386
G1 X84.828 Y98.783 E-.10614
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X86.705 Y96.743 Z1.56 F18000
G1 Z1.16
G1 E.4 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.597127
G1 F1500
M204 S6000
G1 X87.001 Y96.722 E.00847
; LINE_WIDTH: 0.563697
G1 X87.298 Y96.702 E.00798
G1 X88.189 Y96.728 E.02394
; WIPE_START
G1 X87.298 Y96.702 E-.28503
G1 X87.001 Y96.722 E-.09497
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X86.705 Y96.743 Z1.56 F18000
G1 Z1.16
G1 E.4 F1800
; LINE_WIDTH: 0.599114
G1 F1500
M204 S6000
G1 X86.484 Y96.725 E.00634
; LINE_WIDTH: 0.563037
G1 X86.263 Y96.707 E.00594
; LINE_WIDTH: 0.510838
G1 X86.042 Y96.689 E.00536
G1 X85.442 Y96.689 E.01452
G1 X85.443 Y97.347 E.01592
G1 X85.97 Y97.045 E.01471
; LINE_WIDTH: 0.529357
G1 X86.293 Y96.912 E.00877
; LINE_WIDTH: 0.570227
G1 X86.615 Y96.778 E.00948
; LINE_WIDTH: 0.603907
G1 X86.649 Y96.765 E.00105
; WIPE_START
G1 X86.615 Y96.778 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X89.659 Y96.685 Z1.56 F18000
G1 Z1.16
G1 E.4 F1800
; LINE_WIDTH: 0.506712
G1 F1500
M204 S6000
G1 X88.958 Y96.686 E.01683
; LINE_WIDTH: 0.520805
G1 X88.675 Y96.7 E.00699
; LINE_WIDTH: 0.54899
G1 X88.392 Y96.714 E.00739
; LINE_WIDTH: 0.578917
G1 X88.249 Y96.73 E.00398
; LINE_WIDTH: 0.572742
G1 X88.584 Y96.843 E.00965
; LINE_WIDTH: 0.511181
G1 X88.919 Y96.956 E.00856
G1 X89.658 Y97.313 E.01987
G1 X89.659 Y96.745 E.01375
M204 S10000
G1 X90.098 Y96.247 F18000
; LINE_WIDTH: 0.419992
G1 F1500
M204 S6000
G1 X85.002 Y96.251 E.10021
G1 X85.005 Y98.086 E.03609
G1 X85.072 Y98.096 E.00133
G1 X85.127 Y98.147 E.00148
G1 X85.505 Y97.817 E.00987
G1 X86.188 Y97.426 E.01549
G1 X86.763 Y97.235 E.01192
G1 X87.358 Y97.151 E.01182
G1 X88.213 Y97.21 E.01685
G1 X88.797 Y97.376 E.01193
G1 X89.352 Y97.651 E.01219
G1 X89.835 Y98.009 E.01181
G1 X90.094 Y98.296 E.00762
G1 X90.097 Y96.307 E.03912
; CHANGE_LAYER
; Z_HEIGHT: 1.28
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F1500
G1 X90.094 Y98.296 E-.37794
G1 X90.087 Y98.288 E-.00207
; WIPE_END
G1 E-.02 F1800
; layer num/total_layer_count: 10/49
; update layer progress
M73 L10
M991 S0 P9 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z1.56 I1.057 J.603 P1  F18000
G1 X94.431 Y90.682 Z1.56
G1 Z1.28
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X94.269 Y90.682 E.00342
G1 X94.269 Y90.22 E.00977
G1 X95.431 Y90.22 E.02458
G1 X95.431 Y90.682 E.00977
G1 X94.491 Y90.682 E.0199
; WIPE_START
M204 S6000
G1 X94.269 Y90.682 E-.04209
G1 X94.269 Y90.22 E-.08769
G1 X95.431 Y90.22 E-.22069
G1 X95.431 Y90.376 E-.02952
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X98.669 Y90.22 Z1.68 F18000
G1 Z1.28
G1 E.4 F1800
G1 F1500
M204 S500
G1 X99.831 Y90.22 E.02458
G1 X99.831 Y90.682 E.00977
G1 X98.669 Y90.682 E.02458
G1 X98.669 Y90.28 E.0085
; WIPE_START
M204 S6000
G1 X99.831 Y90.22 E-.22098
G1 X99.831 Y90.682 E-.08769
G1 X99.455 Y90.682 E-.07132
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X98.638 Y94.889 Z1.68 F18000
G1 Z1.28
G1 E.4 F1800
G1 F1500
M204 S500
G1 X99.407 Y94.12 E.02301
G1 X99.407 Y95.357 E.02619
G1 X98.169 Y95.357 E.02619
G1 X98.595 Y94.931 E.01276
M204 S10000
G1 X98.338 Y94.589 F18000
G1 F1500
M204 S500
G1 X99.831 Y93.096 E.04469
G1 X99.831 Y95.782 E.05685
G1 X97.145 Y95.782 E.05685
G1 X98.295 Y94.631 E.03444
; WIPE_START
M204 S6000
G1 X99.71 Y93.217 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X96.569 Y87.944 Z1.68 F18000
G1 Z1.28
G1 E.4 F1800
G1 F1500
M204 S500
G1 X97.531 Y87.944 E.02035
G1 X97.05 Y88.425 E.01439
G1 X96.612 Y87.987 E.01312
; WIPE_START
M204 S6000
G1 X97.531 Y87.944 E-.17484
G1 X97.05 Y88.425 E-.1292
G1 X96.767 Y88.143 E-.07596
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X94.693 Y94.12 Z1.68 F18000
G1 Z1.28
G1 E.4 F1800
G1 F1500
M204 S500
G1 X95.931 Y95.357 E.03704
G1 X94.693 Y95.357 E.02619
G1 X94.693 Y94.18 E.02492
; WIPE_START
M204 S6000
G1 X95.931 Y95.357 E-.32452
G1 X95.639 Y95.357 E-.05549
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X89.662 Y98.415 Z1.68 F18000
G1 Z1.28
G1 E.4 F1800
G1 F1500
M204 S500
G1 X89.589 Y98.336 E.00227
G1 X89.152 Y98.008 E.01156
G1 X88.663 Y97.764 E.01157
G1 X88.154 Y97.615 E.01123
G1 X87.778 Y97.564 E.00804
G1 X87.398 Y97.558 E.00804
G1 X86.872 Y97.63 E.01124
G1 X86.367 Y97.794 E.01123
G1 X86.029 Y97.963 E.00801
G1 X85.735 Y98.156 E.00744
G1 X85.318 Y98.525 E.01178
G1 X84.979 Y98.963 E.01174
G1 X84.793 Y99.329 E.00868
G1 X84.598 Y99.282 E.00424
G1 X84.593 Y95.842 E.07282
G1 X90.507 Y95.837 E.12519
G1 X90.502 Y99.259 E.07242
G1 X90.297 Y99.299 E.00443
G1 X90.255 Y99.197 E.00233
G1 X89.961 Y98.737 E.01156
G1 X89.703 Y98.459 E.00803
M204 S10000
G1 X89.351 Y98.703 F18000
G1 F1500
M204 S500
G1 X89.624 Y98.997 E.00849
G1 X89.877 Y99.393 E.00995
G1 X90.052 Y99.82 E.00975
G1 X90.128 Y100.132 E.00681
G1 X90.164 Y100.426 E.00627
G1 X90.153 Y100.912 E.01029
G1 X90.057 Y101.364 E.0098
G1 X89.944 Y101.667 E.00683
G1 X89.795 Y101.953 E.00683
G1 X89.524 Y102.326 E.00975
G1 X89.191 Y102.644 E.00975
G1 X88.928 Y102.83 E.00683
G1 X88.643 Y102.983 E.00683
G1 X88.21 Y103.138 E.00975
G1 X87.755 Y103.214 E.00975
G1 X87.432 Y103.219 E.00683
G1 X87.112 Y103.185 E.00683
G1 X86.666 Y103.069 E.00975
G1 X86.239 Y102.871 E.00995
G1 X85.862 Y102.606 E.00975
G1 X85.629 Y102.383 E.00683
G1 X85.424 Y102.134 E.00683
G1 X85.193 Y101.746 E.00955
G1 X85.07 Y101.448 E.00683
G1 X84.984 Y101.137 E.00683
G1 X84.929 Y100.679 E.00975
G1 X84.957 Y100.219 E.00975
G1 X85.024 Y99.905 E.00681
G1 X85.119 Y99.624 E.00626
G1 X85.339 Y99.191 E.01028
G1 X85.63 Y98.816 E.01005
G1 X85.993 Y98.493 E.01029
G1 X86.241 Y98.331 E.00627
G1 X86.529 Y98.187 E.00681
G1 X86.966 Y98.045 E.00975
G1 X87.423 Y97.983 E.00975
G1 X87.746 Y97.988 E.00683
G1 X88.066 Y98.031 E.00683
G1 X88.508 Y98.16 E.00975
G1 X88.928 Y98.371 E.00995
G1 X89.304 Y98.653 E.00995
G1 X89.31 Y98.659 E.00019
M204 S250
G1 X89.051 Y98.981 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X89.299 Y99.249 E.00717
G1 X89.512 Y99.582 E.00779
G1 X89.661 Y99.946 E.00774
G1 X89.725 Y100.206 E.00526
G1 X89.755 Y100.446 E.00477
G1 X89.745 Y100.864 E.00822
G1 X89.663 Y101.249 E.00775
G1 X89.569 Y101.5 E.00526
G1 X89.446 Y101.737 E.00526
G1 X89.215 Y102.055 E.00773
G1 X88.931 Y102.327 E.00773
G1 X88.712 Y102.481 E.00526
G1 X88.476 Y102.608 E.00526
G1 X88.106 Y102.741 E.00774
G1 X87.718 Y102.805 E.00773
G1 X87.451 Y102.809 E.00526
G1 X87.185 Y102.781 E.00526
G1 X86.804 Y102.682 E.00773
G1 X86.445 Y102.516 E.0078
G1 X86.123 Y102.289 E.00773
G1 X85.93 Y102.104 E.00526
G1 X85.76 Y101.898 E.00526
G1 X85.56 Y101.563 E.00767
G1 X85.458 Y101.315 E.00526
G1 X85.387 Y101.057 E.00526
G1 X85.34 Y100.667 E.00773
G1 X85.364 Y100.274 E.00774
G1 X85.419 Y100.013 E.00526
G1 X85.497 Y99.784 E.00477
G1 X85.686 Y99.411 E.00821
G1 X85.93 Y99.097 E.00783
G1 X86.242 Y98.819 E.00822
G1 X86.445 Y98.687 E.00477
M73 P42 R16
G1 X86.684 Y98.567 E.00526
G1 X87.058 Y98.445 E.00773
G1 X87.448 Y98.393 E.00774
G1 X87.715 Y98.397 E.00526
G1 X87.98 Y98.433 E.00526
G1 X88.358 Y98.543 E.00773
G1 X88.712 Y98.72 E.00779
G1 X89.007 Y98.941 E.00725
; WIPE_START
M204 S6000
G1 X89.299 Y99.249 E-.08054
G1 X89.512 Y99.582 E-.07529
G1 X89.661 Y99.946 E-.07472
G1 X89.725 Y100.206 E-.05077
G1 X89.755 Y100.446 E-.04604
G1 X89.748 Y100.723 E-.05263
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X93.025 Y93.83 Z1.68 F18000
G1 X95.869 Y87.844 Z1.68
G1 Z1.28
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X95.869 Y87.52 E.00686
G1 X96.869 Y87.52 E.02117
G1 X96.869 Y77.382 E.21459
G1 X94.583 Y77.382 E.0484
G1 X94.514 Y77.05 E.00718
G1 X94.373 Y76.788 E.00629
G1 X94.163 Y76.578 E.00629
G1 X93.901 Y76.437 E.0063
G1 X93.637 Y76.382 E.00571
G1 X81.496 Y76.382 E.25697
G1 X81.207 Y76.432 E.0062
G1 X80.929 Y76.582 E.00669
G1 X80.691 Y76.835 E.00737
G1 X80.542 Y77.181 E.00795
G1 X80.531 Y94.473 E.36601
G1 X80.617 Y94.839 E.00795
G1 X80.799 Y95.097 E.00669
G1 X80.995 Y95.262 E.00541
G1 X81.256 Y95.384 E.0061
G1 X81.505 Y95.42 E.00533
G1 X94.269 Y95.41 E.27016
G1 X94.269 Y93.096 E.04898
G1 X96.955 Y95.782 E.08039
G1 X90.932 Y95.782 E.12749
G1 X90.924 Y100.801 E.10623
G1 X90.876 Y101.199 E.00848
G1 X90.782 Y101.588 E.00848
G1 X90.643 Y101.963 E.00847
G1 X90.456 Y102.328 E.00867
G1 X90.138 Y102.773 E.01157
G1 X89.829 Y103.096 E.00947
G1 X89.52 Y103.347 E.00842
G1 X89.174 Y103.566 E.00868
G1 X88.829 Y103.73 E.00808
G1 X88.432 Y103.864 E.00886
G1 X87.894 Y103.962 E.01157
G1 X87.446 Y103.979 E.00949
G1 X86.86 Y103.91 E.0125
G1 X86.468 Y103.803 E.00861
G1 X86.097 Y103.652 E.00847
G1 X85.748 Y103.46 E.00843
G1 X85.387 Y103.196 E.00947
G1 X84.996 Y102.815 E.01156
G1 X84.747 Y102.489 E.00867
G1 X84.543 Y102.144 E.00847
G1 X84.381 Y101.777 E.0085
G1 X84.224 Y101.205 E.01256
G1 X84.176 Y100.801 E.00862
G1 X84.168 Y95.783 E.10621
G1 X81.479 Y95.778 E.05691
G1 X81.223 Y95.741 E.00548
G1 X80.931 Y95.634 E.00659
G1 X80.792 Y95.554 E.0034
G1 X80.546 Y95.348 E.00678
G1 X80.351 Y95.081 E.00701
G1 X80.251 Y94.865 E.00503
G1 X80.207 Y94.719 E.00323
G1 X80.169 Y94.383 E.00716
G1 X80.169 Y77.419 E.35905
G1 X80.206 Y77.092 E.00697
G1 X80.284 Y76.855 E.00528
G1 X80.403 Y76.636 E.00527
G1 X80.488 Y76.521 E.00302
G1 X80.67 Y76.339 E.00546
G1 X80.785 Y76.254 E.00302
G1 X81.004 Y76.135 E.00528
G1 X81.241 Y76.057 E.00528
G1 X81.39 Y76.03 E.00321
G1 X93.545 Y76.021 E.25728
G1 X93.797 Y76.044 E.00536
G1 X94.096 Y76.134 E.00662
G1 X94.232 Y76.202 E.00321
G1 X94.443 Y76.35 E.00546
G1 X94.657 Y76.577 E.00659
G1 X94.948 Y77.02 E.01123
G1 X97.231 Y77.02 E.04831
G1 X97.231 Y87.52 E.22224
G1 X98.231 Y87.52 E.02117
G1 X98.231 Y87.844 E.00686
G1 X97.05 Y89.025 E.03534
G1 X95.912 Y87.887 E.03407
; WIPE_START
M204 S6000
G1 X95.869 Y87.52 E-.07014
G1 X96.869 Y87.52 E-.19
G1 X96.869 Y86.889 E-.11986
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X94.84 Y91.091 Z1.68 F18000
G1 Z1.28
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X94.84 Y93.088 E.03928
G1 X97.05 Y95.298 E.06147
G1 X99.26 Y93.088 E.06147
G1 X99.26 Y91.091 E.03928
G1 X98.26 Y91.091 E.01967
G1 X98.26 Y89.811 E.02518
G1 X100.24 Y89.811 E.03895
G1 X100.24 Y96.191 E.12549
G1 X91.34 Y96.191 E.17505
G1 X91.333 Y100.825 E.09115
G1 X91.28 Y101.271 E.00883
G1 X91.174 Y101.708 E.00883
G1 X91.018 Y102.128 E.00883
G1 X90.812 Y102.531 E.00889
G1 X90.695 Y102.716 E.0043
G1 X90.45 Y103.038 E.00796
G1 X90.107 Y103.398 E.00977
G1 X89.759 Y103.68 E.00881
G1 X89.377 Y103.921 E.0089
G1 X88.977 Y104.112 E.00871
G1 X88.546 Y104.257 E.00895
G1 X88.333 Y104.309 E.0043
G1 X87.933 Y104.37 E.00797
G1 X87.436 Y104.389 E.00977
G1 X87.034 Y104.354 E.00795
G1 X86.771 Y104.31 E.00523
G1 X86.336 Y104.191 E.00887
G1 X85.92 Y104.022 E.00883
G1 X85.528 Y103.806 E.00882
G1 X85.127 Y103.513 E.00977
G1 X84.829 Y103.239 E.00796
G1 X84.681 Y103.077 E.0043
G1 X84.407 Y102.718 E.0089
G1 X84.179 Y102.331 E.00883
G1 X83.997 Y101.92 E.00884
G1 X83.878 Y101.533 E.00796
G1 X83.82 Y101.273 E.00524
G1 X83.767 Y100.825 E.00888
G1 X83.76 Y96.191 E.09115
G1 X81.449 Y96.188 E.04545
G1 X81.134 Y96.141 E.00626
G1 X80.938 Y96.083 E.00403
G1 X80.747 Y96 E.00409
G1 X80.567 Y95.896 E.00409
G1 X80.4 Y95.772 E.0041
G1 X80.248 Y95.629 E.00409
G1 X80.115 Y95.47 E.00408
G1 X79.991 Y95.279 E.00449
G1 X79.868 Y95.01 E.00581
G1 X79.809 Y94.814 E.00404
G1 X79.772 Y94.609 E.00409
G1 X79.76 Y94.395 E.00422
G1 X79.76 Y77.407 E.33413
G1 X79.772 Y77.193 E.00422
G1 X79.808 Y76.991 E.00403
G1 X79.907 Y76.692 E.00619
G1 X80.057 Y76.415 E.00619
G1 X80.177 Y76.253 E.00398
G1 X80.402 Y76.028 E.00625
G1 X80.564 Y75.907 E.00398
G1 X80.841 Y75.758 E.0062
G1 X81.14 Y75.659 E.00619
G1 X81.342 Y75.623 E.00403
G1 X81.556 Y75.611 E.00422
G1 X93.564 Y75.612 E.23618
G1 X93.863 Y75.639 E.00591
G1 X94.063 Y75.686 E.00404
G1 X94.442 Y75.85 E.00811
G1 X94.703 Y76.032 E.00625
G1 X94.852 Y76.173 E.00403
G1 X94.985 Y76.332 E.00409
G1 X95.169 Y76.611 E.00656
G1 X97.64 Y76.611 E.04861
G1 X97.64 Y87.111 E.20653
G1 X98.64 Y87.111 E.01967
G1 X98.64 Y88.014 E.01776
G1 X97.05 Y89.604 E.04423
G1 X95.46 Y88.014 E.04423
G1 X95.46 Y87.111 E.01776
G1 X96.46 Y87.111 E.01967
G1 X96.46 Y77.791 E.18332
G1 X94.16 Y77.791 E.04524
G1 X94.159 Y77.356 E.00856
G1 X94.125 Y77.191 E.00331
G1 X94.041 Y77.035 E.00349
G1 X93.916 Y76.91 E.00349
G1 X93.759 Y76.826 E.00349
G1 X93.595 Y76.792 E.0033
G1 X81.532 Y76.791 E.23727
G1 X81.343 Y76.824 E.00376
G1 X81.182 Y76.911 E.00362
G1 X81.038 Y77.064 E.00413
G1 X80.951 Y77.265 E.00431
G1 X80.94 Y94.425 E.33752
G1 X80.998 Y94.668 E.0049
G1 X81.103 Y94.819 E.00362
G1 X81.216 Y94.914 E.00291
G1 X81.374 Y94.987 E.00343
G1 X81.535 Y95.011 E.00319
G1 X93.86 Y95.001 E.24242
G1 X93.86 Y89.811 E.10209
G1 X95.84 Y89.811 E.03895
G1 X95.84 Y91.091 E.02518
G1 X94.9 Y91.091 E.01849
; WIPE_START
M204 S6000
G1 X94.84 Y93.088 E-.3796
G1 X94.842 Y93.089 E-.0004
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




G1 X94.35 Y92.887
G1 Z1.28
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.596522
G1 F1500
M204 S6000
G1 X94.35 Y90.886 E.05697
; WIPE_START
G1 X94.35 Y92.886 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X95.077 Y94.958 Z1.68 F18000
G1 Z1.28
G1 E.4 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.365752
G1 F1500
M204 S6000
G1 X95.013 Y94.995 E.00125
G1 X95.062 Y95.023 E.00095
; WIPE_START
G1 X95.013 Y94.995 E-.16436
G1 X95.077 Y94.958 E-.21564
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X99.065 Y94.958 Z1.68 F18000
G1 Z1.28
G1 E.4 F1800
G1 F1500
M204 S6000
G1 X99.002 Y94.995 E.00125
G1 X99.05 Y95.023 E.00095
; WIPE_START
G1 X99.002 Y94.995 E-.16436
G1 X99.065 Y94.958 E-.21564
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X99.75 Y92.887 Z1.68 F18000
G1 Z1.28
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.596522
G1 F1500
M204 S6000
G1 X99.75 Y90.886 E.05697
; WIPE_START
G1 X99.75 Y92.886 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X93.248 Y96.884 Z1.68 F18000
G1 X90.291 Y98.702 Z1.68
G1 Z1.28
G1 E.4 F1800
; LINE_WIDTH: 0.145648
G1 F1500
M204 S6000
G1 X90.168 Y98.571 E.00108
; LINE_WIDTH: 0.118116
G1 X90.052 Y98.466 E.00072
; LINE_WIDTH: 0.0925445
G1 X89.936 Y98.362 E.00052
; WIPE_START
G1 X90.052 Y98.466 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X90.184 Y99.537 Z1.68 F18000
G1 Z1.28
G1 E.4 F1800
; LINE_WIDTH: 0.417824
G1 F1500
M204 S6000
G1 X90.324 Y99.62 E.00318
; LINE_WIDTH: 0.444732
G1 X90.464 Y99.703 E.0034
; LINE_WIDTH: 0.468347
G1 X90.482 Y99.714 E.00048
M73 P43 R16
G1 X90.502 Y99.881 E.00372
; LINE_WIDTH: 0.427296
G1 X90.522 Y100.049 E.00337
; LINE_WIDTH: 0.384248
G1 X90.544 Y100.394 E.0062
; LINE_WIDTH: 0.3602
G1 X90.529 Y100.94 E.00911
G1 X90.419 Y101.477 E.00915
G1 X90.294 Y101.812 E.00596
G1 X90.128 Y102.135 E.00607
G1 X89.798 Y102.584 E.0093
G1 X89.569 Y102.814 E.00541
G1 X89.299 Y103.035 E.00581
G1 X88.786 Y103.334 E.00991
G1 X88.175 Y103.532 E.01072
G1 X87.801 Y103.588 E.00631
G1 X87.458 Y103.598 E.00573
G1 X86.938 Y103.535 E.00874
G1 X86.552 Y103.429 E.00667
G1 X86.262 Y103.305 E.00527
G1 X85.954 Y103.137 E.00586
G1 X85.627 Y102.903 E.0067
G1 X85.346 Y102.632 E.00651
G1 X85.063 Y102.273 E.00763
G1 X84.86 Y101.926 E.00671
G1 X84.717 Y101.579 E.00627
G1 X84.612 Y101.197 E.0066
G1 X84.557 Y100.778 E.00706
G1 X84.567 Y100.18 E.00997
; LINE_WIDTH: 0.404439
G1 X84.587 Y99.978 E.00384
; LINE_WIDTH: 0.444213
G1 X84.605 Y99.803 E.00367
; LINE_WIDTH: 0.475157
G1 X84.652 Y99.513 E.00658
M204 S10000
G1 X84.828 Y98.783 F18000
; LINE_WIDTH: 0.0952359
G1 F1500
M204 S6000
G1 X84.852 Y98.712 E.00026
G1 X84.983 Y98.571 E.00067
; WIPE_START
G1 X84.852 Y98.712 E-.27378
G1 X84.828 Y98.783 E-.10622
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X86.705 Y96.742 Z1.68 F18000
G1 Z1.28
G1 E.4 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.597367
G1 F1500
M204 S6000
G1 X87.001 Y96.722 E.00848
; LINE_WIDTH: 0.563944
G1 X87.298 Y96.702 E.00798
G1 X88.189 Y96.728 E.02395
; WIPE_START
G1 X87.298 Y96.702 E-.28501
G1 X87.001 Y96.722 E-.09499
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X86.705 Y96.742 Z1.68 F18000
G1 Z1.28
G1 E.4 F1800
; LINE_WIDTH: 0.599321
G1 F1500
M204 S6000
G1 X86.484 Y96.724 E.00634
; LINE_WIDTH: 0.563177
G1 X86.263 Y96.707 E.00594
; LINE_WIDTH: 0.510881
G1 X86.042 Y96.689 E.00536
G1 X85.442 Y96.689 E.01452
G1 X85.443 Y97.347 E.01592
G1 X85.971 Y97.045 E.01471
; LINE_WIDTH: 0.529435
G1 X86.293 Y96.912 E.00877
; LINE_WIDTH: 0.57038
G1 X86.615 Y96.778 E.00948
; LINE_WIDTH: 0.604122
G1 X86.649 Y96.765 E.00105
; WIPE_START
G1 X86.615 Y96.778 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X89.659 Y96.685 Z1.68 F18000
G1 Z1.28
G1 E.4 F1800
; LINE_WIDTH: 0.506832
G1 F1500
M204 S6000
G1 X88.958 Y96.685 E.01683
; LINE_WIDTH: 0.520947
G1 X88.675 Y96.7 E.007
; LINE_WIDTH: 0.549177
G1 X88.392 Y96.714 E.0074
; LINE_WIDTH: 0.579152
G1 X88.249 Y96.73 E.00398
; LINE_WIDTH: 0.572967
G1 X88.584 Y96.843 E.00966
; LINE_WIDTH: 0.511274
G1 X88.919 Y96.956 E.00857
G1 X89.655 Y97.324 E.01992
G1 X89.659 Y96.745 E.01402
M204 S10000
G1 X90.098 Y96.247 F18000
; LINE_WIDTH: 0.419992
G1 F1500
M204 S6000
G1 X85.002 Y96.251 E.10021
G1 X85.005 Y98.085 E.03607
G1 X85.073 Y98.095 E.00135
G1 X85.128 Y98.146 E.00149
G1 X85.508 Y97.816 E.0099
G1 X86.189 Y97.426 E.01543
G1 X86.763 Y97.235 E.01192
G1 X87.358 Y97.151 E.01182
G1 X88.213 Y97.21 E.01685
G1 X88.797 Y97.376 E.01193
G1 X89.352 Y97.651 E.01219
G1 X89.751 Y97.956 E.00987
G1 X89.876 Y97.849 E.00324
G1 X90.095 Y97.871 E.00432
G1 X90.097 Y96.307 E.03077
; CHANGE_LAYER
; Z_HEIGHT: 1.4
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F1500
G1 X90.095 Y97.871 E-.29721
G1 X89.876 Y97.849 E-.04175
G1 X89.751 Y97.956 E-.03126
G1 X89.71 Y97.924 E-.00978
; WIPE_END
G1 E-.02 F1800
; layer num/total_layer_count: 11/49
; update layer progress
M73 L11
M991 S0 P10 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z1.68 I1.02 J.665 P1  F18000
G1 X94.431 Y90.682 Z1.68
G1 Z1.4
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X94.269 Y90.682 E.00342
G1 X94.269 Y90.22 E.00977
G1 X95.431 Y90.22 E.02458
G1 X95.431 Y90.682 E.00977
G1 X94.491 Y90.682 E.0199
; WIPE_START
M204 S6000
G1 X94.269 Y90.682 E-.04209
G1 X94.269 Y90.22 E-.08769
G1 X95.431 Y90.22 E-.22069
G1 X95.431 Y90.376 E-.02952
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X98.669 Y90.22 Z1.8 F18000
G1 Z1.4
G1 E.4 F1800
G1 F1500
M204 S500
G1 X99.831 Y90.22 E.02458
G1 X99.831 Y90.682 E.00977
G1 X98.669 Y90.682 E.02458
G1 X98.669 Y90.28 E.0085
; WIPE_START
M204 S6000
G1 X99.831 Y90.22 E-.22098
G1 X99.831 Y90.682 E-.08769
G1 X99.455 Y90.682 E-.07132
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X98.638 Y94.889 Z1.8 F18000
G1 Z1.4
G1 E.4 F1800
G1 F1500
M204 S500
G1 X99.407 Y94.12 E.02301
G1 X99.407 Y95.357 E.02619
G1 X98.169 Y95.357 E.02619
G1 X98.595 Y94.931 E.01276
M204 S10000
G1 X98.338 Y94.589 F18000
G1 F1500
M204 S500
G1 X99.831 Y93.096 E.04469
G1 X99.831 Y95.782 E.05685
G1 X97.145 Y95.782 E.05685
G1 X98.295 Y94.631 E.03444
; WIPE_START
M204 S6000
G1 X99.71 Y93.217 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X96.569 Y87.944 Z1.8 F18000
G1 Z1.4
G1 E.4 F1800
G1 F1500
M204 S500
G1 X97.531 Y87.944 E.02035
G1 X97.05 Y88.425 E.01439
G1 X96.612 Y87.987 E.01312
; WIPE_START
M204 S6000
G1 X97.531 Y87.944 E-.17484
G1 X97.05 Y88.425 E-.1292
G1 X96.767 Y88.143 E-.07596
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X94.693 Y94.12 Z1.8 F18000
G1 Z1.4
G1 E.4 F1800
G1 F1500
M204 S500
G1 X95.931 Y95.357 E.03704
G1 X94.693 Y95.357 E.02619
G1 X94.693 Y94.18 E.02492
; WIPE_START
M204 S6000
G1 X95.931 Y95.357 E-.32452
G1 X95.639 Y95.357 E-.05549
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X89.586 Y98.348 Z1.8 F18000
G1 Z1.4
G1 E.4 F1800
G1 F1500
M204 S500
G1 X89.316 Y98.119 E.00749
G1 X88.993 Y97.919 E.00804
G1 X88.663 Y97.766 E.00771
G1 X88.316 Y97.654 E.00771
G1 X87.943 Y97.58 E.00804
G1 X87.413 Y97.556 E.01123
G1 X86.887 Y97.628 E.01124
G1 X86.523 Y97.734 E.00804
G1 X86.173 Y97.883 E.00804
G1 X85.722 Y98.162 E.01123
G1 X85.316 Y98.528 E.01157
G1 X84.979 Y98.964 E.01166
G1 X84.793 Y99.329 E.00868
G1 X84.598 Y99.283 E.00425
G1 X84.593 Y95.842 E.07282
G1 X90.507 Y95.837 E.12517
G1 X90.507 Y99.285 E.07298
G1 X90.315 Y99.334 E.00418
G1 X90.071 Y98.887 E.01077
G1 X89.721 Y98.462 E.01166
G1 X89.632 Y98.386 E.00247
M204 S10000
G1 X89.312 Y98.671 F18000
G1 F1500
M204 S500
G1 X89.418 Y98.761 E.00294
G1 X89.718 Y99.126 E.01
G1 X89.952 Y99.555 E.01034
G1 X90.054 Y99.83 E.00621
G1 X90.13 Y100.142 E.0068
G1 X90.172 Y100.601 E.00975
G1 X90.129 Y101.072 E.01
G1 X89.996 Y101.541 E.01034
G1 X89.875 Y101.809 E.00621
G1 X89.71 Y102.085 E.00681
G1 X89.418 Y102.441 E.00975
G1 X89.066 Y102.739 E.00975
G1 X88.793 Y102.908 E.0068
G1 X88.527 Y103.032 E.00621
G1 X88.059 Y103.173 E.01034
G1 X87.589 Y103.222 E.01001
G1 X87.121 Y103.187 E.00995
G1 X86.675 Y103.071 E.00975
G1 X86.378 Y102.944 E.00683
M73 P43 R15
G1 X86.099 Y102.783 E.00682
G1 X85.745 Y102.502 E.00956
G1 X85.527 Y102.266 E.0068
G1 X85.353 Y102.029 E.00621
G1 X85.125 Y101.598 E.01034
G1 X84.986 Y101.146 E.01001
G1 X84.929 Y100.679 E.00995
G1 X84.957 Y100.219 E.00975
G1 X85.024 Y99.905 E.00681
G1 X85.118 Y99.627 E.00621
G1 X85.339 Y99.192 E.01034
G1 X85.628 Y98.818 E.01
G1 X85.977 Y98.503 E.00995
G1 X86.369 Y98.261 E.00975
G1 X86.666 Y98.134 E.00683
G1 X86.976 Y98.044 E.00683
G1 X87.432 Y97.982 E.00976
G1 X87.893 Y98.002 E.00975
G1 X88.209 Y98.065 E.00683
G1 X88.507 Y98.162 E.00663
G1 X88.792 Y98.293 E.00664
G1 X89.066 Y98.463 E.00683
G1 X89.266 Y98.632 E.00554
M204 S250
G1 X89.047 Y98.983 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X89.125 Y99.049 E.00201
G1 X89.377 Y99.356 E.00781
G1 X89.579 Y99.725 E.00826
G1 X89.662 Y99.95 E.00472
G1 X89.726 Y100.209 E.00525
G1 X89.761 Y100.601 E.00773
G1 X89.725 Y100.996 E.00781
G1 X89.61 Y101.401 E.00827
G1 X89.512 Y101.619 E.00472
G1 X89.375 Y101.849 E.00526
G1 X89.125 Y102.153 E.00774
G1 X88.825 Y102.407 E.00773
G1 X88.598 Y102.547 E.00525
G1 X88.38 Y102.649 E.00472
G1 X87.978 Y102.77 E.00826
G1 X87.583 Y102.811 E.00782
G1 X87.188 Y102.782 E.0078
G1 X86.807 Y102.683 E.00773
G1 X86.561 Y102.578 E.00526
G1 X86.33 Y102.444 E.00526
G1 X86.025 Y102.201 E.00768
G1 X85.843 Y102.005 E.00525
G1 X85.701 Y101.811 E.00472
G1 X85.505 Y101.44 E.00826
G1 X85.387 Y101.061 E.00782
G1 X85.34 Y100.667 E.00779
G1 X85.364 Y100.274 E.00774
G1 X85.419 Y100.013 E.00525
G1 X85.496 Y99.786 E.00472
G1 X85.686 Y99.411 E.00826
G1 X85.929 Y99.097 E.00781
G1 X86.224 Y98.832 E.0078
G1 X86.558 Y98.625 E.00773
G1 X86.804 Y98.52 E.00526
G1 X87.061 Y98.445 E.00526
G1 X87.451 Y98.392 E.00774
G1 X87.844 Y98.41 E.00773
G1 X88.106 Y98.462 E.00526
G1 X88.358 Y98.543 E.0052
G1 X88.598 Y98.654 E.0052
G1 X88.825 Y98.795 E.00526
G1 X89.001 Y98.945 E.00455
; WIPE_START
M204 S6000
G1 X89.125 Y99.049 E-.03077
G1 X89.377 Y99.356 E-.07548
G1 X89.579 Y99.725 E-.07983
G1 X89.662 Y99.95 E-.04561
G1 X89.726 Y100.209 E-.05075
G1 X89.761 Y100.601 E-.07469
G1 X89.75 Y100.721 E-.02287
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X93.026 Y93.827 Z1.8 F18000
G1 X95.869 Y87.844 Z1.8
G1 Z1.4
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X95.869 Y87.52 E.00686
G1 X96.869 Y87.52 E.02117
G1 X96.869 Y77.382 E.21459
G1 X94.582 Y77.382 E.0484
G1 X94.514 Y77.05 E.00717
G1 X94.373 Y76.788 E.00629
G1 X94.163 Y76.578 E.00629
G1 X93.901 Y76.437 E.00629
G1 X93.637 Y76.382 E.00571
G1 X81.496 Y76.382 E.25697
G1 X81.205 Y76.433 E.00626
G1 X80.922 Y76.588 E.00683
G1 X80.69 Y76.837 E.0072
G1 X80.542 Y77.181 E.00792
G1 X80.531 Y94.475 E.36606
G1 X80.621 Y94.846 E.00809
G1 X80.8 Y95.098 E.00653
G1 X80.995 Y95.262 E.00538
G1 X81.256 Y95.384 E.0061
G1 X81.505 Y95.42 E.00534
G1 X94.269 Y95.41 E.27016
G1 X94.269 Y93.096 E.04898
G1 X96.955 Y95.782 E.08039
G1 X90.931 Y95.782 E.12751
G1 X90.931 Y100.584 E.10164
G1 X90.878 Y101.193 E.01295
G1 X90.782 Y101.588 E.00859
G1 X90.643 Y101.963 E.00848
G1 X90.46 Y102.32 E.00848
G1 X90.233 Y102.657 E.0086
G1 X90.084 Y102.836 E.00495
G1 X89.832 Y103.094 E.00762
G1 X89.52 Y103.347 E.0085
G1 X89.174 Y103.566 E.00867
G1 X88.829 Y103.73 E.00809
G1 X88.432 Y103.864 E.00886
G1 X87.899 Y103.961 E.01148
G1 X87.446 Y103.979 E.00959
G1 X86.86 Y103.91 E.01249
G1 X86.468 Y103.803 E.0086
G1 X86.095 Y103.652 E.0085
G1 X85.584 Y103.351 E.01256
G1 X85.269 Y103.094 E.0086
G1 X84.99 Y102.807 E.00847
G1 X84.747 Y102.489 E.00848
G1 X84.543 Y102.144 E.00847
G1 X84.319 Y101.596 E.01254
G1 X84.234 Y101.247 E.00761
G1 X84.176 Y100.798 E.00958
G1 X84.168 Y95.783 E.10615
G1 X81.479 Y95.778 E.05691
G1 X81.223 Y95.741 E.00548
G1 X80.931 Y95.634 E.00659
G1 X80.792 Y95.554 E.0034
G1 X80.67 Y95.463 E.0032
G1 X80.488 Y95.281 E.00547
G1 X80.317 Y95.02 E.00659
G1 X80.207 Y94.719 E.00678
G1 X80.169 Y94.383 E.00717
G1 X80.169 Y77.419 E.35905
G1 X80.206 Y77.09 E.007
G1 X80.279 Y76.867 E.00498
G1 X80.353 Y76.717 E.00353
G1 X80.494 Y76.515 E.00522
G1 X80.668 Y76.34 E.00522
G1 X80.803 Y76.242 E.00353
G1 X81.003 Y76.136 E.00478
G1 X81.241 Y76.057 E.00531
G1 X81.39 Y76.03 E.00321
G1 X93.547 Y76.021 E.25732
G1 X93.797 Y76.044 E.00531
G1 X93.946 Y76.079 E.00323
G1 X94.097 Y76.134 E.0034
G1 X94.372 Y76.293 E.00672
G1 X94.505 Y76.407 E.00372
G1 X94.661 Y76.583 E.00498
G1 X94.948 Y77.02 E.01107
G1 X97.231 Y77.02 E.04831
G1 X97.231 Y87.52 E.22224
G1 X98.231 Y87.52 E.02117
G1 X98.231 Y87.844 E.00686
G1 X97.05 Y89.025 E.03534
G1 X95.912 Y87.887 E.03407
; WIPE_START
M204 S6000
G1 X95.869 Y87.52 E-.07014
G1 X96.869 Y87.52 E-.19
G1 X96.869 Y86.889 E-.11986
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X94.84 Y91.091 Z1.8 F18000
G1 Z1.4
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X94.84 Y93.088 E.03928
G1 X97.05 Y95.298 E.06147
G1 X99.26 Y93.088 E.06147
G1 X99.26 Y91.091 E.03928
G1 X98.26 Y91.091 E.01967
G1 X98.26 Y89.811 E.02518
G1 X100.24 Y89.811 E.03895
G1 X100.24 Y96.191 E.12549
G1 X91.34 Y96.191 E.17505
G1 X91.34 Y100.595 E.08662
G1 X91.317 Y101.001 E.008
G1 X91.28 Y101.269 E.00533
G1 X91.174 Y101.708 E.00887
G1 X91.018 Y102.129 E.00883
G1 X90.813 Y102.528 E.00883
G1 X90.561 Y102.902 E.00887
G1 X90.388 Y103.111 E.00533
G1 X90.108 Y103.397 E.00787
G1 X89.759 Y103.68 E.00884
G1 X89.377 Y103.921 E.00889
G1 X89.18 Y104.022 E.00436
G1 X88.977 Y104.112 E.00436
G1 X88.546 Y104.257 E.00895
G1 X88.333 Y104.309 E.0043
G1 X87.938 Y104.369 E.00787
G1 X87.436 Y104.389 E.00987
G1 X87.038 Y104.355 E.00785
G1 X86.771 Y104.31 E.00533
G1 X86.336 Y104.191 E.00887
G1 X85.92 Y104.022 E.00884
G1 X85.568 Y103.83 E.00788
G1 X85.342 Y103.681 E.00533
G1 X84.992 Y103.397 E.00887
G1 X84.679 Y103.075 E.00883
G1 X84.407 Y102.718 E.00883
G1 X84.179 Y102.331 E.00883
G1 X83.996 Y101.918 E.00889
G1 X83.926 Y101.71 E.0043
G1 X83.831 Y101.322 E.00787
G1 X83.767 Y100.824 E.00987
G1 X83.76 Y96.191 E.09113
G1 X81.449 Y96.188 E.04545
G1 X81.134 Y96.141 E.00626
G1 X80.938 Y96.083 E.00403
G1 X80.747 Y96 E.00409
G1 X80.567 Y95.896 E.00409
G1 X80.402 Y95.774 E.00403
G1 X80.177 Y95.549 E.00625
G1 X80.055 Y95.384 E.00403
G1 X79.951 Y95.204 E.00409
G1 X79.868 Y95.013 E.0041
G1 X79.809 Y94.814 E.00409
G1 X79.772 Y94.609 E.0041
G1 X79.76 Y94.395 E.00422
G1 X79.76 Y77.407 E.33413
G1 X79.772 Y77.193 E.00422
G1 X79.808 Y76.991 E.00404
G1 X79.899 Y76.712 E.00576
G1 X79.999 Y76.508 E.00448
G1 X80.179 Y76.251 E.00618
G1 X80.401 Y76.029 E.00617
G1 X80.585 Y75.895 E.00447
G1 X80.841 Y75.758 E.0057
G1 X81.14 Y75.659 E.0062
G1 X81.342 Y75.623 E.00404
G1 X81.556 Y75.611 E.00422
G1 X93.566 Y75.612 E.23623
G1 X93.863 Y75.639 E.00587
G1 X94.063 Y75.686 E.00404
G1 X94.259 Y75.758 E.0041
G1 X94.445 Y75.851 E.00409
G1 X94.618 Y75.965 E.00407
G1 X94.793 Y76.115 E.00453
G1 X94.987 Y76.334 E.00576
G1 X95.169 Y76.611 E.00651
G1 X97.64 Y76.611 E.04861
G1 X97.64 Y87.111 E.20653
G1 X98.64 Y87.111 E.01967
G1 X98.64 Y88.014 E.01776
G1 X97.05 Y89.604 E.04423
G1 X95.46 Y88.014 E.04423
G1 X95.46 Y87.111 E.01776
G1 X96.46 Y87.111 E.01967
G1 X96.46 Y77.791 E.18332
G1 X94.16 Y77.791 E.04524
G1 X94.159 Y77.356 E.00855
G1 X94.125 Y77.192 E.0033
G1 X94.041 Y77.035 E.00349
G1 X93.916 Y76.91 E.00349
M73 P44 R15
G1 X93.76 Y76.826 E.00349
G1 X93.595 Y76.792 E.00331
G1 X81.532 Y76.791 E.23727
G1 X81.342 Y76.824 E.00378
G1 X81.176 Y76.915 E.00372
G1 X81.038 Y77.064 E.00401
G1 X80.951 Y77.265 E.0043
G1 X80.94 Y94.426 E.33754
G1 X81 Y94.674 E.00501
G1 X81.103 Y94.819 E.0035
G1 X81.216 Y94.914 E.0029
G1 X81.374 Y94.987 E.00343
G1 X81.535 Y95.011 E.00319
G1 X93.86 Y95.001 E.24243
G1 X93.86 Y89.811 E.10209
G1 X95.84 Y89.811 E.03895
G1 X95.84 Y91.091 E.02518
G1 X94.9 Y91.091 E.01849
; WIPE_START
M204 S6000
G1 X94.84 Y93.088 E-.3796
G1 X94.842 Y93.089 E-.0004
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




G1 X94.35 Y92.887
G1 Z1.4
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.596522
G1 F1500
M204 S6000
G1 X94.35 Y90.886 E.05697
; WIPE_START
G1 X94.35 Y92.886 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X95.077 Y94.958 Z1.8 F18000
G1 Z1.4
G1 E.4 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.365752
G1 F1500
M204 S6000
G1 X95.013 Y94.995 E.00125
G1 X95.062 Y95.023 E.00095
; WIPE_START
G1 X95.013 Y94.995 E-.16436
G1 X95.077 Y94.958 E-.21564
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X99.065 Y94.958 Z1.8 F18000
G1 Z1.4
G1 E.4 F1800
G1 F1500
M204 S6000
G1 X99.002 Y94.995 E.00125
G1 X99.05 Y95.023 E.00095
; WIPE_START
G1 X99.002 Y94.995 E-.16436
G1 X99.065 Y94.958 E-.21564
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X99.75 Y92.887 Z1.8 F18000
G1 Z1.4
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.596522
G1 F1500
M204 S6000
G1 X99.75 Y90.886 E.05697
; WIPE_START
G1 X99.75 Y92.886 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X93.261 Y96.904 Z1.8 F18000
G1 X90.294 Y98.741 Z1.8
G1 Z1.4
G1 E.4 F1800
; LINE_WIDTH: 0.100455
G1 F1500
M204 S6000
G1 X90.066 Y98.508 E.00121
; WIPE_START
G1 X90.294 Y98.741 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X90.201 Y99.582 Z1.8 F18000
G1 Z1.4
G1 E.4 F1800
; LINE_WIDTH: 0.396691
G1 F1500
M204 S6000
G1 X90.448 Y99.721 E.00524
; LINE_WIDTH: 0.463027
G1 X90.489 Y99.746 E.00105
G1 X90.508 Y99.904 E.00347
; LINE_WIDTH: 0.428576
G1 X90.527 Y100.062 E.0032
; LINE_WIDTH: 0.384648
G1 X90.551 Y100.571 E.00912
; LINE_WIDTH: 0.360481
G1 X90.504 Y101.127 E.00932
G1 X90.345 Y101.682 E.00964
G1 X90.205 Y101.992 E.00568
G1 X90.025 Y102.292 E.00584
G1 X89.674 Y102.714 E.00917
G1 X89.278 Y103.052 E.00869
G1 X88.988 Y103.234 E.00573
G1 X88.674 Y103.382 E.0058
G1 X88.118 Y103.542 E.00965
G1 X87.86 Y103.579 E.00436
G1 X87.457 Y103.596 E.00672
G1 X86.938 Y103.535 E.00874
G1 X86.564 Y103.433 E.00647
G1 X86.261 Y103.308 E.00547
G1 X85.807 Y103.039 E.00882
G1 X85.497 Y102.787 E.00666
G1 X85.279 Y102.558 E.00528
G1 X85.027 Y102.22 E.00705
G1 X84.886 Y101.968 E.00481
G1 X84.737 Y101.635 E.00609
G1 X84.614 Y101.21 E.00739
G1 X84.557 Y100.773 E.00736
G1 X84.567 Y100.18 E.0099
; LINE_WIDTH: 0.404439
G1 X84.587 Y99.978 E.00383
; LINE_WIDTH: 0.444229
G1 X84.605 Y99.803 E.00367
; LINE_WIDTH: 0.475117
G1 X84.652 Y99.514 E.00658
M204 S10000
G1 X84.828 Y98.783 F18000
; LINE_WIDTH: 0.0935159
G1 F1500
M204 S6000
G1 X84.85 Y98.717 E.00023
G1 X84.973 Y98.585 E.00061
; WIPE_START
G1 X84.85 Y98.717 E-.27442
G1 X84.828 Y98.783 E-.10558
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X86.724 Y96.741 Z1.8 F18000
G1 Z1.4
G1 E.4 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.594822
G1 F1500
M204 S6000
G1 X87.02 Y96.721 E.00844
; LINE_WIDTH: 0.549338
G1 X87.317 Y96.701 E.00776
G1 X88.076 Y96.716 E.01985
; WIPE_START
G1 X87.317 Y96.701 E-.27315
G1 X87.02 Y96.721 E-.10685
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X86.724 Y96.741 Z1.8 F18000
G1 Z1.4
G1 E.4 F1800
; LINE_WIDTH: 0.595849
G1 F1500
M204 S6000
G1 X86.412 Y96.722 E.00886
; LINE_WIDTH: 0.557842
G1 X86.101 Y96.704 E.00827
; LINE_WIDTH: 0.504098
G1 X85.438 Y96.685 E.01584
G1 X85.439 Y97.345 E.01575
G1 X85.862 Y97.1 E.01168
; LINE_WIDTH: 0.520857
G1 X86.239 Y96.943 E.01008
; LINE_WIDTH: 0.560907
G1 X86.616 Y96.787 E.0109
; LINE_WIDTH: 0.597892
G1 X86.668 Y96.765 E.00161
; WIPE_START
G1 X86.616 Y96.787 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X89.657 Y96.688 Z1.8 F18000
G1 Z1.4
G1 E.4 F1800
; LINE_WIDTH: 0.512252
G1 F1500
M204 S6000
G1 X88.933 Y96.688 E.01757
; LINE_WIDTH: 0.528222
G1 X88.535 Y96.704 E.01
; LINE_WIDTH: 0.549516
G1 X88.136 Y96.721 E.01042
G1 X88.9 Y96.951 E.02084
; LINE_WIDTH: 0.512252
G1 X89.657 Y97.339 E.02065
G1 X89.657 Y96.748 E.01435
M204 S10000
G1 X90.097 Y96.247 F18000
; LINE_WIDTH: 0.419992
G1 F1500
M204 S6000
G1 X85.002 Y96.251 E.10021
G1 X85.005 Y98.101 E.03638
G1 X85.115 Y98.158 E.00243
G1 X85.491 Y97.824 E.00989
G1 X85.972 Y97.527 E.01113
G1 X86.777 Y97.234 E.01684
G1 X87.377 Y97.148 E.01194
G1 X87.978 Y97.172 E.01182
G1 X88.79 Y97.377 E.01647
G1 X89.535 Y97.773 E.0166
G1 X89.905 Y98.092 E.00961
G1 X90.003 Y98.003 E.0026
G1 X90.097 Y98.016 E.00186
G1 X90.097 Y96.307 E.03361
; CHANGE_LAYER
; Z_HEIGHT: 1.52
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F1500
G1 X90.097 Y98.016 E-.32467
G1 X90.003 Y98.003 E-.01798
G1 X89.905 Y98.092 E-.02516
G1 X89.856 Y98.05 E-.0122
; WIPE_END
G1 E-.02 F1800
; layer num/total_layer_count: 12/49
; update layer progress
M73 L12
M991 S0 P11 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z1.8 I1.034 J.642 P1  F18000
G1 X94.431 Y90.682 Z1.8
G1 Z1.52
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X94.269 Y90.682 E.00342
G1 X94.269 Y90.22 E.00977
G1 X95.431 Y90.22 E.02458
G1 X95.431 Y90.682 E.00977
G1 X94.491 Y90.682 E.0199
; WIPE_START
M204 S6000
G1 X94.269 Y90.682 E-.04209
G1 X94.269 Y90.22 E-.08769
G1 X95.431 Y90.22 E-.22069
G1 X95.431 Y90.376 E-.02952
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X98.669 Y90.22 Z1.92 F18000
G1 Z1.52
G1 E.4 F1800
G1 F1500
M204 S500
G1 X99.831 Y90.22 E.02458
G1 X99.831 Y90.682 E.00977
G1 X98.669 Y90.682 E.02458
G1 X98.669 Y90.28 E.0085
; WIPE_START
M204 S6000
G1 X99.831 Y90.22 E-.22098
G1 X99.831 Y90.682 E-.08769
G1 X99.455 Y90.682 E-.07132
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X98.638 Y94.889 Z1.92 F18000
G1 Z1.52
G1 E.4 F1800
G1 F1500
M204 S500
G1 X99.407 Y94.12 E.02301
G1 X99.407 Y95.357 E.02619
G1 X98.169 Y95.357 E.02619
G1 X98.595 Y94.931 E.01276
M204 S10000
G1 X98.338 Y94.589 F18000
G1 F1500
M204 S500
G1 X99.831 Y93.096 E.04469
G1 X99.831 Y95.782 E.05685
G1 X97.145 Y95.782 E.05685
G1 X98.295 Y94.631 E.03444
; WIPE_START
M204 S6000
G1 X99.71 Y93.217 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X96.569 Y87.944 Z1.92 F18000
G1 Z1.52
G1 E.4 F1800
G1 F1500
M204 S500
G1 X97.531 Y87.944 E.02035
G1 X97.05 Y88.425 E.01439
G1 X96.612 Y87.987 E.01312
; WIPE_START
M204 S6000
G1 X97.531 Y87.944 E-.17484
G1 X97.05 Y88.425 E-.1292
G1 X96.767 Y88.143 E-.07596
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X94.693 Y94.12 Z1.92 F18000
G1 Z1.52
G1 E.4 F1800
G1 F1500
M204 S500
G1 X95.931 Y95.357 E.03704
G1 X94.693 Y95.357 E.02619
G1 X94.693 Y94.18 E.02492
; WIPE_START
M204 S6000
G1 X95.931 Y95.357 E-.32452
G1 X95.639 Y95.357 E-.05549
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X89.644 Y98.399 Z1.92 F18000
G1 Z1.52
G1 E.4 F1800
G1 F1500
M204 S500
G1 X89.573 Y98.324 E.00219
G1 X89.301 Y98.109 E.00733
G1 X88.98 Y97.911 E.008
G1 X88.492 Y97.702 E.01123
G1 X87.959 Y97.581 E.01156
G1 X87.413 Y97.556 E.01156
G1 X86.872 Y97.63 E.01157
G1 X86.367 Y97.794 E.01123
G1 X86.029 Y97.963 E.008
G1 X85.74 Y98.152 E.00732
G1 X85.319 Y98.524 E.01189
G1 X84.979 Y98.964 E.01176
G1 X84.793 Y99.329 E.00868
G1 X84.598 Y99.283 E.00425
G1 X84.593 Y95.842 E.07283
G1 X90.507 Y95.837 E.12517
G1 X90.507 Y99.272 E.0727
G1 X90.305 Y99.315 E.00436
G1 X90.247 Y99.184 E.00304
G1 X89.958 Y98.733 E.01133
G1 X89.685 Y98.443 E.00844
M204 S10000
G1 X89.335 Y98.691 F18000
G1 F1500
M204 S500
G1 X89.623 Y98.995 E.00886
G1 X89.872 Y99.385 E.00981
G1 X90.003 Y99.68 E.00683
G1 X90.098 Y99.989 E.00683
G1 X90.167 Y100.444 E.00975
G1 X90.153 Y100.914 E.00995
G1 X90.057 Y101.365 E.00975
G1 X89.944 Y101.667 E.00683
G1 X89.795 Y101.953 E.00683
G1 X89.524 Y102.326 E.00975
G1 X89.191 Y102.644 E.00975
G1 X88.928 Y102.83 E.00683
G1 X88.643 Y102.983 E.00683
G1 X88.21 Y103.138 E.00975
G1 X87.748 Y103.215 E.00992
G1 X87.309 Y103.211 E.00927
G1 X86.817 Y103.118 E.0106
G1 X86.386 Y102.949 E.00981
G1 X86.106 Y102.788 E.00683
G1 X85.856 Y102.6 E.00663
G1 X85.629 Y102.383 E.00663
G1 X85.424 Y102.134 E.00683
G1 X85.188 Y101.738 E.00975
G1 X85.026 Y101.307 E.00975
G1 X84.959 Y100.991 E.00683
G1 X84.93 Y100.67 E.00683
G1 X84.957 Y100.219 E.00955
G1 X85.024 Y99.905 E.0068
G1 X85.117 Y99.629 E.00616
G1 X85.339 Y99.192 E.01039
G1 X85.63 Y98.815 E.01007
G1 X85.998 Y98.49 E.01039
G1 X86.241 Y98.331 E.00615
G1 X86.529 Y98.187 E.00681
G1 X86.967 Y98.045 E.00975
G1 X87.432 Y97.982 E.00995
G1 X87.902 Y98.003 E.00995
G1 X88.36 Y98.107 E.00995
G1 X88.784 Y98.288 E.00975
G1 X89.057 Y98.457 E.00681
G1 X89.285 Y98.638 E.00616
G1 X89.294 Y98.647 E.00027
M204 S250
G1 X89.038 Y98.972 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X89.298 Y99.248 E.00747
G1 X89.511 Y99.58 E.00775
G1 X89.619 Y99.824 E.00526
G1 X89.698 Y100.08 E.00526
G1 X89.757 Y100.469 E.00773
G1 X89.745 Y100.865 E.0078
G1 X89.663 Y101.249 E.00773
G1 X89.569 Y101.5 E.00526
G1 X89.446 Y101.737 E.00526
G1 X89.215 Y102.055 E.00773
G1 X88.931 Y102.327 E.00773
G1 X88.712 Y102.481 E.00526
G1 X88.476 Y102.608 E.00526
G1 X88.106 Y102.741 E.00773
G1 X87.716 Y102.805 E.00779
G1 X87.349 Y102.802 E.00721
G1 X86.931 Y102.723 E.00838
G1 X86.564 Y102.579 E.00775
G1 X86.332 Y102.446 E.00526
G1 X86.121 Y102.287 E.0052
G1 X85.93 Y102.104 E.0052
G1 X85.76 Y101.898 E.00526
G1 X85.558 Y101.56 E.00773
G1 X85.42 Y101.192 E.00773
G1 X85.364 Y100.93 E.00526
G1 X85.34 Y100.664 E.00526
G1 X85.364 Y100.274 E.00767
G1 X85.419 Y100.013 E.00525
G1 X85.495 Y99.788 E.00467
G1 X85.686 Y99.411 E.00831
G1 X85.93 Y99.096 E.00783
G1 X86.246 Y98.816 E.00831
G1 X86.445 Y98.686 E.00467
G1 X86.684 Y98.567 E.00526
G1 X87.058 Y98.445 E.00773
G1 X87.451 Y98.392 E.0078
G1 X87.847 Y98.41 E.00779
G1 X88.233 Y98.498 E.00779
G1 X88.595 Y98.653 E.00773
G1 X88.822 Y98.793 E.00526
G1 X88.995 Y98.93 E.00433
; WIPE_START
M204 S6000
G1 X89.298 Y99.248 E-.08352
G1 X89.511 Y99.58 E-.07487
G1 X89.619 Y99.824 E-.05083
G1 X89.698 Y100.08 E-.05084
G1 X89.757 Y100.469 E-.07468
G1 X89.75 Y100.707 E-.04525
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X93.029 Y93.814 Z1.92 F18000
G1 X95.869 Y87.844 Z1.92
G1 Z1.52
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X95.869 Y87.52 E.00686
G1 X96.869 Y87.52 E.02117
G1 X96.869 Y77.382 E.21459
G1 X94.582 Y77.382 E.0484
G1 X94.514 Y77.05 E.00717
G1 X94.373 Y76.788 E.0063
G1 X94.162 Y76.578 E.00629
G1 X93.901 Y76.437 E.00629
G1 X93.636 Y76.382 E.00571
G1 X81.496 Y76.382 E.25696
G1 X81.198 Y76.434 E.0064
G1 X80.889 Y76.613 E.00757
G1 X80.665 Y76.879 E.00736
G1 X80.542 Y77.19 E.00707
G1 X80.531 Y94.475 E.36586
G1 X80.622 Y94.847 E.0081
G1 X80.8 Y95.098 E.00651
G1 X80.994 Y95.262 E.00537
G1 X81.256 Y95.384 E.0061
G1 X81.505 Y95.42 E.00534
G1 X94.269 Y95.41 E.27016
G1 X94.269 Y93.096 E.04898
G1 X96.955 Y95.782 E.08039
G1 X90.931 Y95.782 E.12751
G1 X90.931 Y100.584 E.10164
G1 X90.878 Y101.193 E.01295
G1 X90.782 Y101.588 E.0086
G1 X90.643 Y101.963 E.00848
G1 X90.456 Y102.328 E.00867
G1 X90.112 Y102.805 E.01245
G1 X89.791 Y103.129 E.00966
G1 X89.514 Y103.352 E.00751
G1 X89.19 Y103.557 E.00812
G1 X88.823 Y103.732 E.00861
G1 X88.389 Y103.874 E.00966
G1 X88.041 Y103.945 E.00751
G1 X87.659 Y103.979 E.00812
G1 X87.25 Y103.967 E.00866
G1 X86.854 Y103.908 E.00848
G1 X86.468 Y103.803 E.00848
G1 X86.095 Y103.652 E.0085
G1 X85.584 Y103.35 E.01256
G1 X85.269 Y103.095 E.00859
G1 X84.99 Y102.807 E.00847
G1 X84.747 Y102.489 E.00848
G1 X84.543 Y102.144 E.00847
G1 X84.381 Y101.777 E.0085
G1 X84.224 Y101.204 E.01256
G1 X84.176 Y100.801 E.00861
G1 X84.168 Y95.783 E.10621
G1 X81.479 Y95.778 E.05691
G1 X81.223 Y95.741 E.00548
G1 X80.931 Y95.634 E.00659
G1 X80.792 Y95.554 E.0034
G1 X80.546 Y95.348 E.00678
G1 X80.349 Y95.077 E.00709
G1 X80.251 Y94.866 E.00493
G1 X80.207 Y94.719 E.00324
G1 X80.169 Y94.383 E.00716
G1 X80.169 Y77.419 E.35905
G1 X80.206 Y77.092 E.00697
G1 X80.284 Y76.855 E.00528
G1 X80.403 Y76.635 E.00528
G1 X80.488 Y76.521 E.00301
G1 X80.668 Y76.341 E.00541
M73 P45 R15
G1 X80.805 Y76.241 E.00357
G1 X81.011 Y76.131 E.00494
G1 X81.146 Y76.082 E.00304
G1 X81.399 Y76.03 E.00547
G1 X93.55 Y76.021 E.25718
G1 X93.797 Y76.044 E.00525
G1 X93.946 Y76.079 E.00324
G1 X94.24 Y76.206 E.00678
G1 X94.374 Y76.294 E.00339
G1 X94.601 Y76.508 E.00659
G1 X94.96 Y77.02 E.01324
G1 X97.231 Y77.02 E.04806
G1 X97.231 Y87.52 E.22224
G1 X98.231 Y87.52 E.02117
G1 X98.231 Y87.844 E.00686
G1 X97.05 Y89.025 E.03534
G1 X95.912 Y87.887 E.03407
; WIPE_START
M204 S6000
G1 X95.869 Y87.52 E-.07014
G1 X96.869 Y87.52 E-.19
G1 X96.869 Y86.889 E-.11986
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X94.84 Y91.091 Z1.92 F18000
G1 Z1.52
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X94.84 Y93.088 E.03928
G1 X97.05 Y95.298 E.06147
G1 X99.26 Y93.088 E.06147
G1 X99.26 Y91.091 E.03928
G1 X98.26 Y91.091 E.01967
G1 X98.26 Y89.811 E.02518
G1 X100.24 Y89.811 E.03895
G1 X100.24 Y96.191 E.12549
G1 X91.34 Y96.191 E.17505
G1 X91.34 Y100.595 E.08662
G1 X91.318 Y100.996 E.00791
G1 X91.28 Y101.269 E.00542
G1 X91.174 Y101.708 E.00887
G1 X91.018 Y102.129 E.00883
G1 X90.812 Y102.531 E.00889
G1 X90.695 Y102.716 E.0043
G1 X90.421 Y103.074 E.00887
G1 X90.065 Y103.434 E.00995
G1 X89.757 Y103.682 E.00778
G1 X89.573 Y103.806 E.00436
G1 X89.382 Y103.918 E.00436
G1 X88.975 Y104.112 E.00887
G1 X88.494 Y104.27 E.00995
G1 X88.107 Y104.35 E.00778
G1 X87.886 Y104.376 E.00437
G1 X87.665 Y104.389 E.00436
G1 X87.214 Y104.376 E.00889
G1 X86.769 Y104.309 E.00884
G1 X86.336 Y104.191 E.00883
G1 X85.92 Y104.022 E.00884
G1 X85.573 Y103.832 E.00778
G1 X85.342 Y103.681 E.00542
G1 X84.992 Y103.397 E.00887
G1 X84.679 Y103.075 E.00883
G1 X84.407 Y102.718 E.00884
G1 X84.179 Y102.331 E.00883
G1 X83.997 Y101.92 E.00884
G1 X83.88 Y101.542 E.00778
G1 X83.82 Y101.273 E.00542
G1 X83.767 Y100.825 E.00887
G1 X83.76 Y96.191 E.09115
G1 X81.449 Y96.188 E.04545
G1 X81.134 Y96.141 E.00626
G1 X80.938 Y96.083 E.00403
G1 X80.747 Y96 E.0041
G1 X80.567 Y95.896 E.00409
G1 X80.4 Y95.772 E.00409
G1 X80.248 Y95.629 E.00409
G1 X80.115 Y95.47 E.00407
G1 X79.989 Y95.275 E.00458
G1 X79.868 Y95.011 E.00572
G1 X79.809 Y94.814 E.00404
G1 X79.772 Y94.609 E.00409
G1 X79.76 Y94.395 E.00422
G1 X79.76 Y77.407 E.33413
G1 X79.772 Y77.193 E.00422
G1 X79.808 Y76.991 E.00403
G1 X79.907 Y76.692 E.00619
G1 X80.057 Y76.415 E.0062
G1 X80.177 Y76.253 E.00397
G1 X80.401 Y76.029 E.00624
G1 X80.587 Y75.893 E.00452
G1 X80.844 Y75.757 E.00572
G1 X81.034 Y75.687 E.00398
G1 X81.345 Y75.623 E.00626
G1 X81.556 Y75.611 E.00415
G1 X93.569 Y75.612 E.23627
G1 X93.863 Y75.639 E.00582
G1 X94.063 Y75.686 E.00405
G1 X94.259 Y75.758 E.00409
G1 X94.445 Y75.851 E.00409
G1 X94.619 Y75.965 E.00409
G1 X94.778 Y76.099 E.00409
G1 X94.919 Y76.248 E.00404
G1 X95.173 Y76.611 E.00871
G1 X97.64 Y76.611 E.04853
G1 X97.64 Y87.111 E.20653
G1 X98.64 Y87.111 E.01967
G1 X98.64 Y88.014 E.01776
G1 X97.05 Y89.604 E.04423
G1 X95.46 Y88.014 E.04423
G1 X95.46 Y87.111 E.01776
G1 X96.46 Y87.111 E.01967
G1 X96.46 Y77.791 E.18332
G1 X94.16 Y77.791 E.04524
G1 X94.159 Y77.356 E.00855
G1 X94.125 Y77.192 E.0033
G1 X94.041 Y77.035 E.00349
G1 X93.915 Y76.91 E.00349
G1 X93.759 Y76.826 E.00349
G1 X93.595 Y76.792 E.00331
G1 X81.532 Y76.791 E.23727
G1 X81.34 Y76.825 E.00382
G1 X81.156 Y76.931 E.00419
G1 X81.021 Y77.092 E.00412
G1 X80.951 Y77.268 E.00374
G1 X80.94 Y94.426 E.33748
G1 X81.001 Y94.674 E.00502
G1 X81.103 Y94.819 E.00349
G1 X81.216 Y94.914 E.0029
G1 X81.374 Y94.987 E.00343
G1 X81.535 Y95.011 E.00319
G1 X93.86 Y95.001 E.24242
G1 X93.86 Y89.811 E.10209
G1 X95.84 Y89.811 E.03895
G1 X95.84 Y91.091 E.02518
G1 X94.9 Y91.091 E.01849
; WIPE_START
M204 S6000
G1 X94.84 Y93.088 E-.3796
G1 X94.842 Y93.089 E-.0004
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




G1 X94.35 Y92.887
G1 Z1.52
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.596522
G1 F1500
M204 S6000
G1 X94.35 Y90.886 E.05697
; WIPE_START
G1 X94.35 Y92.886 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X95.077 Y94.958 Z1.92 F18000
G1 Z1.52
G1 E.4 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.365752
G1 F1500
M204 S6000
G1 X95.013 Y94.995 E.00125
G1 X95.062 Y95.023 E.00095
; WIPE_START
G1 X95.013 Y94.995 E-.16436
G1 X95.077 Y94.958 E-.21564
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X99.065 Y94.958 Z1.92 F18000
G1 Z1.52
G1 E.4 F1800
G1 F1500
M204 S6000
G1 X99.002 Y94.995 E.00125
G1 X99.05 Y95.023 E.00095
; WIPE_START
G1 X99.002 Y94.995 E-.16436
G1 X99.065 Y94.958 E-.21564
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X99.75 Y92.887 Z1.92 F18000
G1 Z1.52
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.596522
G1 F1500
M204 S6000
G1 X99.75 Y90.886 E.05697
; WIPE_START
G1 X99.75 Y92.886 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X93.53 Y97.31 Z1.92 F18000
G1 X90.448 Y99.501 Z1.92
G1 Z1.52
G1 E.4 F1800
; LINE_WIDTH: 0.47166
G1 F1500
M204 S6000
G1 X90.507 Y99.876 E.00843
; LINE_WIDTH: 0.425155
G1 X90.53 Y100.158 E.00564
; LINE_WIDTH: 0.385234
G1 X90.548 Y100.406 E.00446
; LINE_WIDTH: 0.360703
G1 X90.525 Y100.944 E.009
G1 X90.5 Y101.126 E.00307
G1 X90.419 Y101.477 E.00602
G1 X90.296 Y101.808 E.0059
G1 X90.04 Y102.267 E.00878
G1 X89.819 Y102.563 E.00618
G1 X89.534 Y102.845 E.00669
G1 X89.289 Y103.043 E.00526
G1 X89.008 Y103.22 E.00556
G1 X88.681 Y103.376 E.00606
G1 X88.319 Y103.5 E.00639
G1 X87.791 Y103.59 E.00895
G1 X87.284 Y103.589 E.00848
G1 X86.728 Y103.484 E.00945
G1 X86.233 Y103.295 E.00886
G1 X85.806 Y103.039 E.00832
G1 X85.527 Y102.813 E.00601
G1 X85.279 Y102.558 E.00593
G1 X85.064 Y102.275 E.00594
G1 X84.883 Y101.97 E.00594
G1 X84.743 Y101.644 E.00592
G1 X84.671 Y101.423 E.00388
G1 X84.6 Y101.136 E.00495
G1 X84.557 Y100.778 E.00603
G1 X84.567 Y100.18 E.00999
; LINE_WIDTH: 0.404424
G1 X84.587 Y99.978 E.00383
; LINE_WIDTH: 0.444169
G1 X84.605 Y99.803 E.00367
; LINE_WIDTH: 0.475032
G1 X84.652 Y99.514 E.00658
M204 S10000
G1 X84.828 Y98.783 F18000
; LINE_WIDTH: 0.0955738
G1 F1500
M204 S6000
G1 X84.852 Y98.711 E.00026
G1 X84.985 Y98.569 E.00068
; WIPE_START
G1 X84.852 Y98.711 E-.27362
G1 X84.828 Y98.783 E-.10638
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X86.705 Y96.742 Z1.92 F18000
G1 Z1.52
G1 E.4 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.596727
G1 F1500
M204 S6000
G1 X87.011 Y96.722 E.00874
; LINE_WIDTH: 0.549409
G1 X87.317 Y96.701 E.00801
G1 X88.076 Y96.715 E.01985
; WIPE_START
G1 X87.317 Y96.701 E-.27071
G1 X87.011 Y96.722 E-.10929
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X86.705 Y96.742 Z1.92 F18000
G1 Z1.52
G1 E.4 F1800
; LINE_WIDTH: 0.599311
G1 F1500
M204 S6000
G1 X86.484 Y96.725 E.00634
; LINE_WIDTH: 0.563147
G1 X86.263 Y96.707 E.00594
; LINE_WIDTH: 0.510822
G1 X86.042 Y96.689 E.00536
G1 X85.442 Y96.689 E.01452
G1 X85.443 Y97.346 E.01591
G1 X85.971 Y97.045 E.01472
; LINE_WIDTH: 0.529387
G1 X86.293 Y96.912 E.00876
; LINE_WIDTH: 0.570357
G1 X86.615 Y96.778 E.00947
; LINE_WIDTH: 0.604117
G1 X86.649 Y96.765 E.00105
; WIPE_START
G1 X86.615 Y96.778 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X89.662 Y96.683 Z1.92 F18000
G1 Z1.52
G1 E.4 F1800
; LINE_WIDTH: 0.503072
G1 F1500
M204 S6000
G1 X88.721 Y96.684 E.02241
; LINE_WIDTH: 0.520417
G1 X88.428 Y96.701 E.00723
; LINE_WIDTH: 0.543544
G1 X88.136 Y96.719 E.00756
G1 X88.698 Y96.883 E.01513
; LINE_WIDTH: 0.503072
G1 X89.326 Y97.14 E.01616
G1 X89.662 Y97.358 E.00952
G1 X89.662 Y96.743 E.01464
M204 S10000
G1 X90.097 Y96.247 F18000
; LINE_WIDTH: 0.419992
G1 F1500
M204 S6000
G1 X85.002 Y96.251 E.10021
G1 X85.005 Y98.082 E.03601
G1 X85.075 Y98.092 E.00139
G1 X85.131 Y98.144 E.0015
G1 X85.513 Y97.812 E.00996
G1 X86.189 Y97.426 E.01531
G1 X86.763 Y97.235 E.01191
G1 X87.377 Y97.148 E.01219
G1 X87.996 Y97.173 E.01219
G1 X88.601 Y97.308 E.01219
G1 X89.155 Y97.541 E.01182
G1 X89.829 Y98.006 E.0161
G1 X90.097 Y98.304 E.0079
G1 X90.097 Y96.307 E.03929
; CHANGE_LAYER
; Z_HEIGHT: 1.64
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F1500
G1 X90.097 Y98.304 E-.37953
G1 X90.096 Y98.302 E-.00047
; WIPE_END
G1 E-.02 F1800
; layer num/total_layer_count: 13/49
; update layer progress
M73 L13
M991 S0 P12 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z1.92 I1.058 J.602 P1  F18000
G1 X94.431 Y90.682 Z1.92
G1 Z1.64
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X94.269 Y90.682 E.00342
G1 X94.269 Y90.22 E.00977
G1 X95.431 Y90.22 E.02458
G1 X95.431 Y90.682 E.00977
G1 X94.491 Y90.682 E.0199
; WIPE_START
M204 S6000
G1 X94.269 Y90.682 E-.04209
G1 X94.269 Y90.22 E-.08769
G1 X95.431 Y90.22 E-.22069
G1 X95.431 Y90.376 E-.02952
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X98.669 Y90.22 Z2.04 F18000
G1 Z1.64
G1 E.4 F1800
G1 F1500
M204 S500
G1 X99.831 Y90.22 E.02458
G1 X99.831 Y90.682 E.00977
G1 X98.669 Y90.682 E.02458
G1 X98.669 Y90.28 E.0085
; WIPE_START
M204 S6000
G1 X99.831 Y90.22 E-.22098
G1 X99.831 Y90.682 E-.08769
G1 X99.455 Y90.682 E-.07132
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X98.638 Y94.889 Z2.04 F18000
G1 Z1.64
G1 E.4 F1800
G1 F1500
M204 S500
G1 X99.407 Y94.12 E.02301
G1 X99.407 Y95.357 E.02619
G1 X98.169 Y95.357 E.02619
G1 X98.595 Y94.931 E.01276
M204 S10000
M73 P46 R15
G1 X98.338 Y94.589 F18000
G1 F1500
M204 S500
G1 X99.831 Y93.096 E.04469
G1 X99.831 Y95.782 E.05685
G1 X97.145 Y95.782 E.05685
G1 X98.295 Y94.631 E.03444
; WIPE_START
M204 S6000
G1 X99.71 Y93.217 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X96.569 Y87.944 Z2.04 F18000
G1 Z1.64
G1 E.4 F1800
G1 F1500
M204 S500
G1 X97.531 Y87.944 E.02035
G1 X97.05 Y88.425 E.01439
G1 X96.612 Y87.987 E.01312
; WIPE_START
M204 S6000
G1 X97.531 Y87.944 E-.17484
G1 X97.05 Y88.425 E-.1292
G1 X96.767 Y88.143 E-.07596
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X94.693 Y94.12 Z2.04 F18000
G1 Z1.64
G1 E.4 F1800
G1 F1500
M204 S500
G1 X95.931 Y95.357 E.03704
G1 X94.693 Y95.357 E.02619
G1 X94.693 Y94.18 E.02492
; WIPE_START
M204 S6000
G1 X95.931 Y95.357 E-.32452
G1 X95.639 Y95.357 E-.05549
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X89.645 Y98.396 Z2.04 F18000
G1 Z1.64
G1 E.4 F1800
G1 F1500
M204 S500
G1 X89.589 Y98.336 E.00173
G1 X89.152 Y98.008 E.01156
G1 X88.678 Y97.771 E.01123
G1 X88.316 Y97.654 E.00804
G1 X87.943 Y97.58 E.00805
G1 X87.413 Y97.556 E.01123
G1 X86.887 Y97.628 E.01124
G1 X86.523 Y97.734 E.00804
G1 X86.173 Y97.883 E.00804
G1 X85.722 Y98.162 E.01123
G1 X85.316 Y98.528 E.01157
G1 X84.979 Y98.964 E.01167
G1 X84.793 Y99.33 E.00867
G1 X84.598 Y99.283 E.00425
G1 X84.593 Y95.842 E.07284
G1 X90.507 Y95.837 E.12517
G1 X90.507 Y99.269 E.07264
G1 X90.301 Y99.31 E.00443
G1 X90.255 Y99.197 E.00258
G1 X89.961 Y98.737 E.01156
G1 X89.686 Y98.44 E.00856
M204 S10000
G1 X89.334 Y98.684 F18000
G1 F1500
M204 S500
G1 X89.624 Y98.997 E.00903
G1 X89.877 Y99.393 E.00995
G1 X90.052 Y99.82 E.00975
G1 X90.128 Y100.132 E.0068
G1 X90.163 Y100.416 E.00606
G1 X90.157 Y100.875 E.00972
G1 X90.058 Y101.362 E.01052
G1 X89.944 Y101.667 E.00689
G1 X89.795 Y101.953 E.00683
G1 X89.524 Y102.326 E.00975
G1 X89.191 Y102.644 E.00976
G1 X88.928 Y102.83 E.00682
G1 X88.643 Y102.983 E.00683
G1 X88.21 Y103.138 E.00975
G1 X87.755 Y103.214 E.00975
G1 X87.432 Y103.219 E.00683
G1 X87.112 Y103.185 E.00683
G1 X86.666 Y103.069 E.00975
G1 X86.239 Y102.871 E.00995
G1 X85.862 Y102.606 E.00975
G1 X85.629 Y102.383 E.00683
G1 X85.424 Y102.134 E.00683
G1 X85.193 Y101.746 E.00955
G1 X85.07 Y101.448 E.00683
G1 X84.984 Y101.137 E.00683
G1 X84.929 Y100.679 E.00975
G1 X84.957 Y100.219 E.00975
G1 X85.024 Y99.905 E.0068
G1 X85.116 Y99.632 E.0061
G1 X85.339 Y99.192 E.01044
G1 X85.628 Y98.818 E.01001
G1 X85.977 Y98.503 E.00995
G1 X86.369 Y98.261 E.00975
G1 X86.666 Y98.134 E.00683
G1 X86.976 Y98.044 E.00683
G1 X87.432 Y97.982 E.00976
G1 X87.893 Y98.002 E.00975
G1 X88.209 Y98.065 E.00683
G1 X88.516 Y98.165 E.00683
G1 X88.928 Y98.371 E.00975
G1 X89.291 Y98.643 E.0096
M204 S250
G1 X89.034 Y98.963 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X89.299 Y99.248 E.00766
G1 X89.512 Y99.582 E.0078
G1 X89.661 Y99.946 E.00774
G1 X89.725 Y100.206 E.00525
G1 X89.754 Y100.438 E.00461
G1 X89.748 Y100.831 E.00772
G1 X89.664 Y101.248 E.00838
G1 X89.569 Y101.5 E.00528
G1 X89.446 Y101.737 E.00526
G1 X89.215 Y102.055 E.00773
G1 X88.931 Y102.327 E.00774
G1 X88.712 Y102.481 E.00526
G1 X88.476 Y102.608 E.00526
G1 X88.106 Y102.741 E.00774
G1 X87.718 Y102.805 E.00773
G1 X87.451 Y102.809 E.00526
G1 X87.185 Y102.781 E.00526
G1 X86.804 Y102.682 E.00773
G1 X86.445 Y102.515 E.0078
G1 X86.123 Y102.289 E.00773
G1 X85.93 Y102.104 E.00526
G1 X85.76 Y101.898 E.00526
G1 X85.56 Y101.563 E.00767
G1 X85.458 Y101.315 E.00526
G1 X85.387 Y101.057 E.00526
G1 X85.34 Y100.667 E.00773
G1 X85.364 Y100.274 E.00774
G1 X85.419 Y100.013 E.00525
G1 X85.494 Y99.791 E.00462
G1 X85.686 Y99.412 E.00836
G1 X85.929 Y99.097 E.00782
G1 X86.224 Y98.832 E.0078
G1 X86.558 Y98.625 E.00773
G1 X86.804 Y98.52 E.00526
G1 X87.061 Y98.445 E.00526
G1 X87.451 Y98.392 E.00774
G1 X87.844 Y98.41 E.00773
G1 X88.106 Y98.462 E.00526
G1 X88.361 Y98.544 E.00526
G1 X88.712 Y98.72 E.00774
G1 X88.987 Y98.926 E.00674
; WIPE_START
M204 S6000
G1 X89.299 Y99.248 E-.08529
G1 X89.512 Y99.582 E-.07531
G1 X89.661 Y99.946 E-.07472
G1 X89.725 Y100.206 E-.05074
G1 X89.754 Y100.438 E-.04452
G1 X89.75 Y100.698 E-.04941
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X93.031 Y93.807 Z2.04 F18000
G1 X95.869 Y87.844 Z2.04
G1 Z1.64
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X95.869 Y87.52 E.00686
G1 X96.869 Y87.52 E.02117
G1 X96.869 Y77.382 E.21459
G1 X94.582 Y77.382 E.0484
G1 X94.514 Y77.05 E.00716
G1 X94.373 Y76.788 E.00629
G1 X94.163 Y76.578 E.0063
G1 X93.901 Y76.437 E.0063
G1 X93.636 Y76.382 E.00571
G1 X81.496 Y76.382 E.25696
G1 X81.198 Y76.434 E.0064
G1 X80.897 Y76.608 E.00737
G1 X80.687 Y76.844 E.00669
G1 X80.542 Y77.181 E.00776
G1 X80.531 Y94.446 E.36543
G1 X80.566 Y94.686 E.00514
G1 X80.678 Y94.947 E.00601
G1 X80.961 Y95.246 E.00872
G1 X81.256 Y95.384 E.00687
G1 X81.505 Y95.42 E.00534
G1 X94.269 Y95.41 E.27016
G1 X94.269 Y93.096 E.04898
G1 X96.955 Y95.782 E.08039
G1 X90.931 Y95.782 E.12751
G1 X90.931 Y100.584 E.10164
G1 X90.878 Y101.193 E.01295
G1 X90.782 Y101.588 E.00859
G1 X90.643 Y101.963 E.00847
G1 X90.459 Y102.321 E.0085
G1 X90.114 Y102.803 E.01257
G1 X89.831 Y103.094 E.00859
G1 X89.52 Y103.347 E.00848
G1 X89.174 Y103.566 E.00867
G1 X88.829 Y103.73 E.00809
G1 X88.44 Y103.861 E.0087
G1 X88.096 Y103.935 E.00743
G1 X87.659 Y103.979 E.0093
G1 X87.25 Y103.967 E.00866
G1 X86.854 Y103.908 E.00848
G1 X86.468 Y103.803 E.00848
G1 X86.097 Y103.652 E.00847
G1 X85.749 Y103.46 E.00841
G1 X85.377 Y103.188 E.00976
G1 X84.995 Y102.815 E.01129
G1 X84.747 Y102.489 E.00867
G1 X84.543 Y102.144 E.00847
G1 X84.319 Y101.595 E.01255
G1 X84.236 Y101.255 E.00741
G1 X84.176 Y100.797 E.00977
G1 X84.168 Y95.783 E.10614
G1 X81.479 Y95.778 E.05691
G1 X81.223 Y95.741 E.00548
G1 X80.931 Y95.634 E.00659
G1 X80.792 Y95.554 E.0034
G1 X80.546 Y95.348 E.00678
G1 X80.36 Y95.098 E.00659
G1 X80.251 Y94.864 E.00547
G1 X80.207 Y94.719 E.0032
G1 X80.169 Y94.383 E.00716
G1 X80.169 Y77.419 E.35906
G1 X80.207 Y77.083 E.00716
G1 X80.251 Y76.938 E.0032
G1 X80.356 Y76.712 E.00528
G1 X80.497 Y76.51 E.00521
G1 X80.616 Y76.387 E.00362
G1 X80.791 Y76.25 E.00469
G1 X81.012 Y76.131 E.00531
G1 X81.146 Y76.082 E.00302
G1 X81.399 Y76.03 E.00547
G1 X93.552 Y76.021 E.25723
G1 X93.797 Y76.044 E.0052
G1 X93.946 Y76.079 E.00324
G1 X94.096 Y76.134 E.00339
G1 X94.371 Y76.292 E.00671
G1 X94.508 Y76.41 E.00382
G1 X94.661 Y76.583 E.00489
G1 X94.948 Y77.02 E.01107
G1 X97.231 Y77.02 E.04831
G1 X97.231 Y87.52 E.22224
G1 X98.231 Y87.52 E.02117
G1 X98.231 Y87.844 E.00686
G1 X97.05 Y89.025 E.03534
G1 X95.912 Y87.887 E.03407
; WIPE_START
M204 S6000
G1 X95.869 Y87.52 E-.07014
G1 X96.869 Y87.52 E-.19
G1 X96.869 Y86.889 E-.11986
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X94.84 Y91.091 Z2.04 F18000
G1 Z1.64
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X94.84 Y93.088 E.03928
G1 X97.05 Y95.298 E.06147
G1 X99.26 Y93.088 E.06147
G1 X99.26 Y91.091 E.03928
G1 X98.26 Y91.091 E.01967
G1 X98.26 Y89.811 E.02518
G1 X100.24 Y89.811 E.03895
G1 X100.24 Y96.191 E.12549
G1 X91.34 Y96.191 E.17505
G1 X91.34 Y100.595 E.08662
G1 X91.318 Y100.992 E.00782
G1 X91.28 Y101.269 E.00551
G1 X91.174 Y101.708 E.00887
G1 X91.018 Y102.128 E.00883
G1 X90.813 Y102.528 E.00884
G1 X90.596 Y102.854 E.00769
G1 X90.422 Y103.074 E.00551
G1 X90.108 Y103.397 E.00886
G1 X89.759 Y103.68 E.00883
G1 X89.377 Y103.921 E.00889
G1 X88.977 Y104.112 E.00871
G1 X88.549 Y104.257 E.0089
G1 X88.166 Y104.339 E.00769
G1 X87.885 Y104.376 E.00558
G1 X87.665 Y104.389 E.00433
G1 X87.214 Y104.376 E.00889
G1 X86.769 Y104.309 E.00883
G1 X86.336 Y104.191 E.00883
G1 X85.92 Y104.022 E.00883
G1 X85.528 Y103.806 E.00881
G1 X85.116 Y103.504 E.01004
G1 X84.681 Y103.077 E.01198
G1 X84.407 Y102.718 E.00889
G1 X84.179 Y102.331 E.00883
G1 X83.996 Y101.918 E.00889
G1 X83.833 Y101.331 E.01198
G1 X83.767 Y100.824 E.01005
G1 X83.76 Y96.191 E.09112
G1 X81.449 Y96.188 E.04545
G1 X81.134 Y96.141 E.00626
G1 X80.938 Y96.083 E.00403
G1 X80.747 Y96 E.00409
G1 X80.567 Y95.896 E.00409
G1 X80.4 Y95.772 E.00409
G1 X80.248 Y95.629 E.00409
G1 X80.114 Y95.47 E.00409
G1 X80.002 Y95.298 E.00403
G1 X79.867 Y95.01 E.00625
G1 X79.809 Y94.814 E.00403
G1 X79.772 Y94.609 E.00409
G1 X79.76 Y94.395 E.00422
G1 X79.76 Y77.407 E.33413
G1 X79.772 Y77.193 E.00422
G1 X79.809 Y76.988 E.00409
G1 X79.867 Y76.792 E.00403
G1 X80 Y76.506 E.00619
G1 X80.181 Y76.249 E.00618
G1 X80.341 Y76.082 E.00456
G1 X80.566 Y75.906 E.00561
G1 X80.844 Y75.757 E.00621
G1 X81.034 Y75.687 E.00397
G1 X81.345 Y75.623 E.00626
G1 X81.556 Y75.611 E.00415
G1 X93.571 Y75.612 E.23632
G1 X93.863 Y75.639 E.00577
G1 X94.063 Y75.686 E.00405
G1 X94.259 Y75.758 E.00409
G1 X94.445 Y75.851 E.0041
G1 X94.618 Y75.965 E.00407
G1 X94.796 Y76.118 E.00462
G1 X94.987 Y76.334 E.00567
G1 X95.169 Y76.611 E.00651
G1 X97.64 Y76.611 E.04861
G1 X97.64 Y87.111 E.20653
G1 X98.64 Y87.111 E.01967
G1 X98.64 Y88.014 E.01776
G1 X97.05 Y89.604 E.04423
G1 X95.46 Y88.014 E.04423
G1 X95.46 Y87.111 E.01776
G1 X96.46 Y87.111 E.01967
G1 X96.46 Y77.791 E.18332
G1 X94.16 Y77.791 E.04524
G1 X94.159 Y77.356 E.00855
G1 X94.125 Y77.192 E.0033
G1 X94.041 Y77.035 E.00349
G1 X93.916 Y76.91 E.00349
G1 X93.759 Y76.826 E.00349
G1 X93.595 Y76.792 E.00331
G1 X81.532 Y76.791 E.23727
G1 X81.34 Y76.825 E.00382
G1 X81.159 Y76.93 E.00413
G1 X81.036 Y77.067 E.00361
G1 X80.951 Y77.265 E.00425
G1 X80.94 Y94.416 E.33734
G1 X80.963 Y94.573 E.00312
G1 X81.025 Y94.718 E.0031
G1 X81.205 Y94.908 E.00515
G1 X81.374 Y94.987 E.00367
G1 X81.535 Y95.011 E.00319
G1 X93.86 Y95.001 E.24243
G1 X93.86 Y89.811 E.10209
G1 X95.84 Y89.811 E.03895
G1 X95.84 Y91.091 E.02518
G1 X94.9 Y91.091 E.01849
; WIPE_START
M204 S6000
M73 P46 R14
G1 X94.84 Y93.088 E-.3796
G1 X94.842 Y93.089 E-.0004
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




G1 X94.35 Y92.887
G1 Z1.64
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.596522
G1 F1500
M204 S6000
G1 X94.35 Y90.886 E.05697
; WIPE_START
G1 X94.35 Y92.886 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X95.077 Y94.958 Z2.04 F18000
G1 Z1.64
G1 E.4 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.365752
G1 F1500
M204 S6000
G1 X95.013 Y94.995 E.00125
G1 X95.062 Y95.023 E.00095
; WIPE_START
G1 X95.013 Y94.995 E-.16436
G1 X95.077 Y94.958 E-.21564
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X99.065 Y94.958 Z2.04 F18000
G1 Z1.64
G1 E.4 F1800
M73 P47 R14
G1 F1500
M204 S6000
G1 X99.002 Y94.995 E.00125
G1 X99.05 Y95.023 E.00095
; WIPE_START
G1 X99.002 Y94.995 E-.16436
G1 X99.065 Y94.958 E-.21564
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X99.75 Y92.887 Z2.04 F18000
G1 Z1.64
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.596522
G1 F1500
M204 S6000
G1 X99.75 Y90.886 E.05697
; WIPE_START
G1 X99.75 Y92.886 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X93.25 Y96.887 Z2.04 F18000
G1 X90.294 Y98.706 Z2.04
G1 Z1.64
G1 E.4 F1800
; LINE_WIDTH: 0.146346
G1 F1500
M204 S6000
G1 X90.168 Y98.57 E.00112
; LINE_WIDTH: 0.118073
G1 X90.052 Y98.466 E.00072
; LINE_WIDTH: 0.0925285
G1 X89.936 Y98.362 E.00052
; WIPE_START
G1 X90.052 Y98.466 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X90.187 Y99.548 Z2.04 F18000
G1 Z1.64
G1 E.4 F1800
; LINE_WIDTH: 0.398156
G1 F1500
M204 S6000
G1 X90.32 Y99.627 E.00287
; LINE_WIDTH: 0.42374
G1 X90.454 Y99.705 E.00307
; LINE_WIDTH: 0.469512
G1 X90.486 Y99.726 E.00086
G1 X90.506 Y99.887 E.00358
; LINE_WIDTH: 0.432356
G1 X90.525 Y100.047 E.00328
; LINE_WIDTH: 0.390942
G1 X90.547 Y100.383 E.00612
; LINE_WIDTH: 0.361104
G1 X90.527 Y100.929 E.00915
G1 X90.419 Y101.477 E.00934
G1 X90.294 Y101.812 E.00598
G1 X90.132 Y102.128 E.00595
G1 X89.799 Y102.586 E.00946
G1 X89.572 Y102.811 E.00536
G1 X89.297 Y103.036 E.00594
G1 X88.987 Y103.232 E.00615
G1 X88.786 Y103.333 E.00376
G1 X88.29 Y103.508 E.00879
G1 X87.801 Y103.587 E.00829
G1 X87.425 Y103.595 E.00629
G1 X86.933 Y103.533 E.00831
G1 X86.552 Y103.429 E.0066
G1 X86.262 Y103.305 E.00528
G1 X85.955 Y103.138 E.00585
G1 X85.632 Y102.906 E.00665
G1 X85.346 Y102.632 E.00662
G1 X85.063 Y102.273 E.00765
G1 X84.86 Y101.926 E.00672
G1 X84.716 Y101.579 E.00629
G1 X84.611 Y101.198 E.00662
G1 X84.557 Y100.772 E.00717
G1 X84.567 Y100.18 E.00991
; LINE_WIDTH: 0.404409
G1 X84.587 Y99.978 E.00383
; LINE_WIDTH: 0.444132
G1 X84.605 Y99.804 E.00367
; LINE_WIDTH: 0.474946
G1 X84.652 Y99.514 E.00657
M204 S10000
G1 X84.828 Y98.783 F18000
; LINE_WIDTH: 0.0935071
G1 F1500
M204 S6000
G1 X84.85 Y98.717 E.00023
G1 X84.973 Y98.585 E.00061
; WIPE_START
G1 X84.85 Y98.717 E-.27442
G1 X84.828 Y98.783 E-.10558
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X86.724 Y96.741 Z2.04 F18000
G1 Z1.64
G1 E.4 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.594817
G1 F1500
M204 S6000
G1 X87.02 Y96.721 E.00844
; LINE_WIDTH: 0.549337
G1 X87.317 Y96.701 E.00776
G1 X88.077 Y96.716 E.01987
; WIPE_START
G1 X87.317 Y96.701 E-.27325
G1 X87.02 Y96.721 E-.10675
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X86.724 Y96.741 Z2.04 F18000
G1 Z1.64
G1 E.4 F1800
; LINE_WIDTH: 0.595849
G1 F1500
M204 S6000
G1 X86.412 Y96.722 E.00887
; LINE_WIDTH: 0.557842
G1 X86.101 Y96.704 E.00828
; LINE_WIDTH: 0.5041
G1 X85.438 Y96.685 E.01584
G1 X85.439 Y97.345 E.01575
G1 X85.862 Y97.1 E.01168
; LINE_WIDTH: 0.520855
G1 X86.239 Y96.943 E.01008
; LINE_WIDTH: 0.5609
G1 X86.616 Y96.787 E.0109
; LINE_WIDTH: 0.597887
G1 X86.668 Y96.765 E.00161
; WIPE_START
G1 X86.616 Y96.787 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X89.66 Y96.685 Z2.04 F18000
G1 Z1.64
G1 E.4 F1800
; LINE_WIDTH: 0.506982
G1 F1500
M204 S6000
G1 X88.953 Y96.685 E.01696
; LINE_WIDTH: 0.52433
G1 X88.545 Y96.703 E.01016
; LINE_WIDTH: 0.54746
G1 X88.137 Y96.721 E.01063
G1 X88.918 Y96.96 E.02126
; LINE_WIDTH: 0.506982
G1 X89.656 Y97.323 E.01975
G1 X89.66 Y96.745 E.01388
M204 S10000
G1 X90.097 Y96.247 F18000
; LINE_WIDTH: 0.419992
G1 F1500
M204 S6000
G1 X85.002 Y96.251 E.10021
G1 X85.005 Y98.101 E.03638
G1 X85.115 Y98.158 E.00243
G1 X85.491 Y97.824 E.00989
G1 X85.972 Y97.527 E.01112
G1 X86.777 Y97.234 E.01685
G1 X87.377 Y97.148 E.01193
G1 X87.977 Y97.172 E.01181
G1 X88.808 Y97.383 E.01686
G1 X89.352 Y97.651 E.01193
G1 X89.751 Y97.956 E.00987
G1 X89.877 Y97.849 E.00324
G1 X90.097 Y97.87 E.00436
G1 X90.097 Y96.307 E.03075
; CHANGE_LAYER
; Z_HEIGHT: 1.76
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F1500
G1 X90.097 Y97.87 E-.29704
G1 X89.877 Y97.849 E-.04209
G1 X89.751 Y97.956 E-.03132
G1 X89.711 Y97.925 E-.00955
; WIPE_END
G1 E-.02 F1800
; layer num/total_layer_count: 14/49
; update layer progress
M73 L14
M991 S0 P13 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z2.04 I1.02 J.664 P1  F18000
G1 X94.431 Y90.682 Z2.04
G1 Z1.76
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X94.269 Y90.682 E.00342
G1 X94.269 Y90.22 E.00977
G1 X95.431 Y90.22 E.02458
G1 X95.431 Y90.682 E.00977
G1 X94.491 Y90.682 E.0199
; WIPE_START
M204 S6000
G1 X94.269 Y90.682 E-.04209
G1 X94.269 Y90.22 E-.08769
G1 X95.431 Y90.22 E-.22069
G1 X95.431 Y90.376 E-.02952
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X98.669 Y90.22 Z2.16 F18000
G1 Z1.76
G1 E.4 F1800
G1 F1500
M204 S500
G1 X99.831 Y90.22 E.02458
G1 X99.831 Y90.682 E.00977
G1 X98.669 Y90.682 E.02458
G1 X98.669 Y90.28 E.0085
; WIPE_START
M204 S6000
G1 X99.831 Y90.22 E-.22098
G1 X99.831 Y90.682 E-.08769
G1 X99.455 Y90.682 E-.07132
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X98.638 Y94.889 Z2.16 F18000
G1 Z1.76
G1 E.4 F1800
G1 F1500
M204 S500
G1 X99.407 Y94.12 E.02301
G1 X99.407 Y95.357 E.02619
G1 X98.169 Y95.357 E.02619
G1 X98.595 Y94.931 E.01276
M204 S10000
G1 X98.338 Y94.589 F18000
G1 F1500
M204 S500
G1 X99.831 Y93.096 E.04469
G1 X99.831 Y95.782 E.05685
G1 X97.145 Y95.782 E.05685
G1 X98.295 Y94.631 E.03444
; WIPE_START
M204 S6000
G1 X99.71 Y93.217 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X96.569 Y87.944 Z2.16 F18000
G1 Z1.76
G1 E.4 F1800
G1 F1500
M204 S500
G1 X97.531 Y87.944 E.02035
G1 X97.05 Y88.425 E.01439
G1 X96.612 Y87.987 E.01312
; WIPE_START
M204 S6000
G1 X97.531 Y87.944 E-.17484
G1 X97.05 Y88.425 E-.1292
G1 X96.767 Y88.143 E-.07596
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X94.693 Y94.12 Z2.16 F18000
G1 Z1.76
G1 E.4 F1800
G1 F1500
M204 S500
G1 X95.931 Y95.357 E.03704
G1 X94.693 Y95.357 E.02619
G1 X94.693 Y94.18 E.02492
; WIPE_START
M204 S6000
G1 X95.931 Y95.357 E-.32452
G1 X95.639 Y95.357 E-.05549
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X89.528 Y98.29 Z2.16 F18000
G1 Z1.76
G1 E.4 F1800
G1 F1500
M204 S500
G1 X89.152 Y98.008 E.00993
G1 X88.663 Y97.764 E.01157
G1 X88.154 Y97.615 E.01123
G1 X87.778 Y97.564 E.00804
G1 X87.398 Y97.558 E.00804
G1 X86.872 Y97.63 E.01124
G1 X86.367 Y97.794 E.01123
G1 X86.027 Y97.964 E.00804
G1 X85.71 Y98.173 E.00804
G1 X85.316 Y98.528 E.01124
G1 X84.978 Y98.965 E.01168
G1 X84.793 Y99.33 E.00867
G1 X84.598 Y99.284 E.00425
G1 X84.593 Y95.842 E.07284
G1 X90.507 Y95.837 E.12517
G1 X90.507 Y99.269 E.07264
G1 X90.301 Y99.309 E.00443
G1 X90.255 Y99.197 E.00257
G1 X89.961 Y98.737 E.01157
G1 X89.589 Y98.336 E.01157
G1 X89.576 Y98.326 E.00036
M204 S10000
G1 X89.273 Y98.629 F18000
G1 F1500
M204 S500
G1 X89.304 Y98.653 E.00082
G1 X89.624 Y98.997 E.00995
G1 X89.877 Y99.393 E.00995
G1 X90.052 Y99.82 E.00975
G1 X90.128 Y100.132 E.0068
G1 X90.163 Y100.415 E.00604
G1 X90.154 Y100.909 E.01046
G1 X90.066 Y101.336 E.00923
G1 X89.882 Y101.797 E.0105
G1 X89.716 Y102.076 E.00687
G1 X89.542 Y102.302 E.00605
G1 X89.187 Y102.649 E.01049
G1 X88.801 Y102.904 E.00979
G1 X88.543 Y103.025 E.00604
G1 X88.204 Y103.139 E.00758
G1 X87.755 Y103.214 E.00963
G1 X87.432 Y103.219 E.00683
G1 X87.112 Y103.185 E.00683
G1 X86.666 Y103.069 E.00975
G1 X86.239 Y102.871 E.00995
G1 X85.862 Y102.606 E.00975
G1 X85.629 Y102.383 E.00683
G1 X85.424 Y102.134 E.00683
G1 X85.193 Y101.746 E.00956
G1 X85.07 Y101.448 E.00683
G1 X84.984 Y101.137 E.00683
G1 X84.929 Y100.679 E.00975
G1 X84.957 Y100.219 E.00975
G1 X85.024 Y99.905 E.0068
G1 X85.115 Y99.635 E.00604
G1 X85.339 Y99.192 E.01049
G1 X85.628 Y98.818 E.01002
G1 X85.971 Y98.509 E.00975
G1 X86.24 Y98.332 E.00683
G1 X86.528 Y98.187 E.00683
G1 X86.966 Y98.045 E.00975
G1 X87.423 Y97.983 E.00975
G1 X87.746 Y97.988 E.00683
G1 X88.066 Y98.031 E.00683
G1 X88.508 Y98.16 E.00975
G1 X88.928 Y98.371 E.00995
G1 X89.225 Y98.593 E.00785
M204 S250
G1 X89.028 Y98.957 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X89.029 Y98.958 E.00004
G1 X89.299 Y99.248 E.0078
G1 X89.512 Y99.582 E.00779
G1 X89.661 Y99.946 E.00774
G1 X89.725 Y100.206 E.00525
G1 X89.754 Y100.436 E.00457
G1 X89.745 Y100.863 E.00839
G1 X89.672 Y101.218 E.00713
G1 X89.514 Y101.615 E.00841
G1 X89.377 Y101.846 E.00527
G1 X89.235 Y102.03 E.00457
G1 X88.929 Y102.329 E.00841
G1 X88.601 Y102.546 E.00775
G1 X88.39 Y102.644 E.00457
G1 X88.104 Y102.741 E.00594
G1 X87.718 Y102.805 E.0077
G1 X87.451 Y102.809 E.00526
G1 X87.185 Y102.781 E.00526
G1 X86.804 Y102.682 E.00773
G1 X86.445 Y102.516 E.0078
G1 X86.123 Y102.289 E.00773
G1 X85.93 Y102.104 E.00526
G1 X85.76 Y101.898 E.00526
G1 X85.56 Y101.563 E.00768
G1 X85.458 Y101.315 E.00526
G1 X85.387 Y101.057 E.00526
G1 X85.34 Y100.667 E.00773
G1 X85.364 Y100.274 E.00774
G1 X85.419 Y100.013 E.00525
G1 X85.493 Y99.793 E.00457
G1 X85.686 Y99.412 E.0084
G1 X85.929 Y99.097 E.00782
G1 X86.222 Y98.834 E.00774
G1 X86.445 Y98.687 E.00526
G1 X86.684 Y98.567 E.00526
G1 X87.058 Y98.445 E.00773
G1 X87.448 Y98.393 E.00774
G1 X87.715 Y98.397 E.00526
G1 X87.98 Y98.433 E.00526
G1 X88.358 Y98.543 E.00773
G1 X88.712 Y98.72 E.0078
G1 X88.98 Y98.921 E.00657
; WIPE_START
M204 S6000
G1 X89.029 Y98.958 E-.01177
G1 X89.299 Y99.248 E-.07532
G1 X89.512 Y99.582 E-.0753
G1 X89.661 Y99.946 E-.07473
G1 X89.725 Y100.206 E-.05073
G1 X89.754 Y100.436 E-.04417
G1 X89.749 Y100.689 E-.04798
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X93.032 Y93.799 Z2.16 F18000
G1 X95.869 Y87.844 Z2.16
G1 Z1.76
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X95.869 Y87.52 E.00686
G1 X96.869 Y87.52 E.02117
G1 X96.869 Y77.382 E.21459
G1 X94.582 Y77.382 E.0484
G1 X94.514 Y77.05 E.00716
G1 X94.373 Y76.788 E.0063
G1 X94.163 Y76.578 E.00629
G1 X93.901 Y76.437 E.00629
G1 X93.636 Y76.382 E.00572
G1 X81.496 Y76.382 E.25697
G1 X81.204 Y76.433 E.00627
G1 X80.92 Y76.59 E.00687
G1 X80.689 Y76.838 E.00717
G1 X80.542 Y77.181 E.0079
G1 X80.531 Y94.446 E.36543
G1 X80.566 Y94.686 E.00514
G1 X80.678 Y94.946 E.00601
G1 X80.961 Y95.246 E.00873
G1 X81.256 Y95.384 E.00688
G1 X81.505 Y95.42 E.00534
G1 X94.269 Y95.41 E.27016
G1 X94.269 Y93.096 E.04898
G1 X96.955 Y95.782 E.08039
G1 X90.931 Y95.782 E.12751
G1 X90.931 Y100.584 E.10164
G1 X90.878 Y101.194 E.01295
G1 X90.782 Y101.588 E.00859
G1 X90.643 Y101.963 E.00847
G1 X90.46 Y102.32 E.00848
G1 X90.119 Y102.798 E.01244
G1 X89.784 Y103.135 E.01005
G1 X89.514 Y103.352 E.00732
G1 X89.19 Y103.557 E.00812
G1 X88.823 Y103.731 E.00859
G1 X88.38 Y103.876 E.00986
G1 X88.042 Y103.945 E.00732
G1 X87.659 Y103.979 E.00812
G1 X87.25 Y103.967 E.00866
G1 X86.854 Y103.908 E.00848
G1 X86.468 Y103.803 E.00848
G1 X86.097 Y103.652 E.00847
G1 X85.746 Y103.459 E.00848
G1 X85.274 Y103.1 E.01254
G1 X85.032 Y102.853 E.00732
G1 X84.745 Y102.486 E.00986
G1 X84.543 Y102.144 E.0084
G1 X84.319 Y101.595 E.01255
G1 X84.236 Y101.26 E.00732
G1 X84.176 Y100.797 E.00987
G1 X84.168 Y95.783 E.10614
G1 X81.479 Y95.778 E.05691
G1 X81.223 Y95.741 E.00548
G1 X80.931 Y95.634 E.00659
G1 X80.792 Y95.554 E.00339
G1 X80.546 Y95.348 E.00678
G1 X80.36 Y95.098 E.00659
G1 X80.251 Y94.864 E.00547
G1 X80.208 Y94.719 E.0032
G1 X80.169 Y94.383 E.00717
G1 X80.169 Y77.419 E.35906
G1 X80.206 Y77.092 E.00697
G1 X80.284 Y76.855 E.00528
G1 X80.398 Y76.643 E.00509
G1 X80.553 Y76.448 E.00528
G1 X80.663 Y76.344 E.0032
G1 X80.785 Y76.254 E.0032
G1 X81.012 Y76.131 E.00547
G1 X81.146 Y76.082 E.00301
G1 X81.399 Y76.03 E.00547
G1 X93.554 Y76.021 E.25727
G1 X93.796 Y76.044 E.00516
G1 X93.946 Y76.079 E.00325
G1 X94.24 Y76.206 E.00678
G1 X94.374 Y76.294 E.0034
G1 X94.49 Y76.391 E.0032
G1 X94.662 Y76.585 E.00547
G1 X94.948 Y77.02 E.01104
G1 X97.231 Y77.02 E.04831
G1 X97.231 Y87.52 E.22224
G1 X98.231 Y87.52 E.02117
G1 X98.231 Y87.844 E.00686
G1 X97.05 Y89.025 E.03534
G1 X95.912 Y87.887 E.03407
; WIPE_START
M204 S6000
G1 X95.869 Y87.52 E-.07014
G1 X96.869 Y87.52 E-.19
G1 X96.869 Y86.889 E-.11986
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X94.84 Y91.091 Z2.16 F18000
G1 Z1.76
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X94.84 Y93.088 E.03928
G1 X97.05 Y95.298 E.06147
G1 X99.26 Y93.088 E.06147
G1 X99.26 Y91.091 E.03928
G1 X98.26 Y91.091 E.01967
G1 X98.26 Y89.811 E.02518
G1 X100.24 Y89.811 E.03895
G1 X100.24 Y96.191 E.12549
G1 X91.34 Y96.191 E.17505
G1 X91.34 Y100.595 E.08663
G1 X91.319 Y100.987 E.00772
G1 X91.28 Y101.269 E.0056
G1 X91.174 Y101.708 E.00887
G1 X91.018 Y102.129 E.00883
G1 X90.813 Y102.528 E.00883
G1 X90.561 Y102.903 E.00889
G1 X90.424 Y103.072 E.00428
G1 X90.058 Y103.44 E.0102
G1 X89.573 Y103.806 E.01195
G1 X89.382 Y103.918 E.00436
G1 X88.975 Y104.112 E.00887
G1 X88.485 Y104.272 E.01014
G1 X87.886 Y104.376 E.01195
M73 P48 R14
G1 X87.665 Y104.389 E.00436
G1 X87.214 Y104.376 E.00889
G1 X86.769 Y104.309 E.00883
G1 X86.336 Y104.191 E.00883
G1 X85.92 Y104.022 E.00883
G1 X85.527 Y103.805 E.00883
G1 X85.16 Y103.542 E.00889
G1 X84.994 Y103.399 E.0043
G1 X84.724 Y103.123 E.00759
G1 X84.406 Y102.717 E.01014
G1 X84.179 Y102.331 E.00881
G1 X83.996 Y101.918 E.0089
G1 X83.834 Y101.335 E.01189
G1 X83.767 Y100.824 E.01014
G1 X83.76 Y96.191 E.09112
G1 X81.449 Y96.188 E.04545
G1 X81.134 Y96.141 E.00626
G1 X80.938 Y96.083 E.00403
G1 X80.747 Y96 E.00409
G1 X80.567 Y95.896 E.00409
G1 X80.4 Y95.772 E.0041
G1 X80.248 Y95.629 E.00409
G1 X80.114 Y95.47 E.00409
G1 X80.002 Y95.298 E.00403
G1 X79.867 Y95.01 E.00626
G1 X79.809 Y94.814 E.00403
G1 X79.772 Y94.609 E.0041
G1 X79.76 Y94.395 E.00422
G1 X79.76 Y77.407 E.33413
G1 X79.772 Y77.193 E.00422
G1 X79.808 Y76.991 E.00403
G1 X79.907 Y76.692 E.0062
G1 X80.055 Y76.418 E.00613
G1 X80.25 Y76.171 E.00619
G1 X80.4 Y76.03 E.00403
G1 X80.564 Y75.908 E.00403
G1 X80.844 Y75.757 E.00626
G1 X81.034 Y75.687 E.00397
G1 X81.345 Y75.623 E.00626
G1 X81.556 Y75.611 E.00415
G1 X93.573 Y75.612 E.23636
G1 X93.863 Y75.639 E.00573
G1 X94.063 Y75.686 E.00405
G1 X94.259 Y75.758 E.00409
G1 X94.445 Y75.851 E.00409
G1 X94.619 Y75.965 E.0041
G1 X94.776 Y76.097 E.00403
G1 X94.987 Y76.335 E.00626
G1 X95.169 Y76.611 E.0065
G1 X97.64 Y76.611 E.04861
G1 X97.64 Y87.111 E.20653
G1 X98.64 Y87.111 E.01967
G1 X98.64 Y88.014 E.01776
G1 X97.05 Y89.604 E.04423
G1 X95.46 Y88.014 E.04423
G1 X95.46 Y87.111 E.01776
G1 X96.46 Y87.111 E.01967
G1 X96.46 Y77.791 E.18332
G1 X94.16 Y77.791 E.04524
G1 X94.159 Y77.356 E.00856
G1 X94.125 Y77.192 E.0033
G1 X94.041 Y77.035 E.00349
G1 X93.916 Y76.91 E.00349
G1 X93.76 Y76.826 E.00349
G1 X93.595 Y76.792 E.00331
G1 X81.532 Y76.791 E.23727
G1 X81.342 Y76.824 E.00378
G1 X81.175 Y76.916 E.00376
G1 X81.037 Y77.065 E.00398
G1 X80.951 Y77.265 E.00429
G1 X80.94 Y94.416 E.33734
G1 X80.963 Y94.573 E.00313
G1 X81.025 Y94.718 E.0031
G1 X81.205 Y94.908 E.00515
G1 X81.374 Y94.987 E.00367
G1 X81.535 Y95.011 E.00319
G1 X93.86 Y95.001 E.24243
G1 X93.86 Y89.811 E.10209
G1 X95.84 Y89.811 E.03895
G1 X95.84 Y91.091 E.02518
G1 X94.9 Y91.091 E.01849
; WIPE_START
M204 S6000
G1 X94.84 Y93.088 E-.3796
G1 X94.842 Y93.089 E-.0004
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




G1 X94.35 Y92.887
G1 Z1.76
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.596522
G1 F1500
M204 S6000
G1 X94.35 Y90.886 E.05697
; WIPE_START
G1 X94.35 Y92.886 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X95.077 Y94.958 Z2.16 F18000
G1 Z1.76
G1 E.4 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.365752
G1 F1500
M204 S6000
G1 X95.013 Y94.995 E.00125
G1 X95.062 Y95.023 E.00095
; WIPE_START
G1 X95.013 Y94.995 E-.16436
G1 X95.077 Y94.958 E-.21564
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X99.065 Y94.958 Z2.16 F18000
G1 Z1.76
G1 E.4 F1800
G1 F1500
M204 S6000
G1 X99.002 Y94.995 E.00125
G1 X99.05 Y95.023 E.00095
; WIPE_START
G1 X99.002 Y94.995 E-.16436
G1 X99.065 Y94.958 E-.21564
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X99.75 Y92.887 Z2.16 F18000
G1 Z1.76
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.596522
G1 F1500
M204 S6000
G1 X99.75 Y90.886 E.05697
; WIPE_START
G1 X99.75 Y92.886 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X93.25 Y96.887 Z2.16 F18000
G1 X90.294 Y98.706 Z2.16
G1 Z1.76
G1 E.4 F1800
; LINE_WIDTH: 0.146342
G1 F1500
M204 S6000
G1 X90.168 Y98.571 E.00112
; LINE_WIDTH: 0.118073
G1 X90.052 Y98.466 E.00072
; LINE_WIDTH: 0.0925279
G1 X89.936 Y98.362 E.00052
; WIPE_START
G1 X90.052 Y98.466 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X90.187 Y99.548 Z2.16 F18000
G1 Z1.76
G1 E.4 F1800
; LINE_WIDTH: 0.398276
G1 F1500
M204 S6000
G1 X90.32 Y99.627 E.00287
; LINE_WIDTH: 0.423851
G1 X90.454 Y99.705 E.00307
; LINE_WIDTH: 0.469529
G1 X90.486 Y99.726 E.00086
G1 X90.506 Y99.887 E.00358
; LINE_WIDTH: 0.432371
G1 X90.525 Y100.047 E.00328
; LINE_WIDTH: 0.390929
G1 X90.547 Y100.382 E.00612
; LINE_WIDTH: 0.360773
G1 X90.523 Y100.965 E.00975
G1 X90.418 Y101.477 E.00873
G1 X90.291 Y101.808 E.00594
G1 X90.131 Y102.125 E.00593
G1 X89.928 Y102.427 E.00608
G1 X89.814 Y102.559 E.00292
G1 X89.526 Y102.852 E.00686
G1 X89.289 Y103.041 E.00507
G1 X88.997 Y103.228 E.00579
G1 X88.682 Y103.378 E.00583
G1 X88.283 Y103.509 E.00702
G1 X87.983 Y103.565 E.00511
G1 X87.777 Y103.591 E.00347
G1 X87.425 Y103.595 E.00588
G1 X86.933 Y103.533 E.0083
G1 X86.552 Y103.429 E.00659
G1 X86.262 Y103.305 E.00528
G1 X85.952 Y103.136 E.0059
G1 X85.634 Y102.904 E.00659
G1 X85.318 Y102.603 E.00729
G1 X85.109 Y102.341 E.0056
G1 X84.883 Y101.97 E.00726
G1 X84.716 Y101.579 E.0071
G1 X84.609 Y101.187 E.00679
G1 X84.557 Y100.772 E.00699
G1 X84.567 Y100.18 E.0099
; LINE_WIDTH: 0.404398
G1 X84.587 Y99.978 E.00383
; LINE_WIDTH: 0.444118
G1 X84.605 Y99.804 E.00367
; LINE_WIDTH: 0.474901
G1 X84.652 Y99.514 E.00656
M204 S10000
G1 X84.828 Y98.783 F18000
; LINE_WIDTH: 0.0935075
G1 F1500
M204 S6000
G1 X84.85 Y98.717 E.00023
G1 X84.973 Y98.585 E.00061
; WIPE_START
G1 X84.85 Y98.717 E-.27443
G1 X84.828 Y98.783 E-.10557
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X86.705 Y96.742 Z2.16 F18000
G1 Z1.76
G1 E.4 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.597342
G1 F1500
M204 S6000
G1 X87.001 Y96.722 E.00848
; LINE_WIDTH: 0.563913
G1 X87.298 Y96.702 E.00798
G1 X88.189 Y96.728 E.02395
; WIPE_START
G1 X87.298 Y96.702 E-.28502
G1 X87.001 Y96.722 E-.09498
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X86.705 Y96.742 Z2.16 F18000
G1 Z1.76
G1 E.4 F1800
; LINE_WIDTH: 0.599351
G1 F1500
M204 S6000
G1 X86.484 Y96.725 E.00634
; LINE_WIDTH: 0.563307
G1 X86.263 Y96.707 E.00594
; LINE_WIDTH: 0.511155
G1 X86.042 Y96.689 E.00537
G1 X85.442 Y96.689 E.01452
G1 X85.443 Y97.349 E.01598
G1 X85.968 Y97.046 E.01469
; LINE_WIDTH: 0.52966
G1 X86.292 Y96.912 E.0088
; LINE_WIDTH: 0.570495
G1 X86.615 Y96.778 E.00951
; LINE_WIDTH: 0.604142
G1 X86.649 Y96.765 E.00105
; WIPE_START
G1 X86.615 Y96.778 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X89.66 Y96.685 Z2.16 F18000
G1 Z1.76
G1 E.4 F1800
; LINE_WIDTH: 0.506992
G1 F1500
M204 S6000
G1 X88.958 Y96.685 E.01684
; LINE_WIDTH: 0.521075
G1 X88.675 Y96.7 E.007
; LINE_WIDTH: 0.54924
G1 X88.392 Y96.714 E.0074
; LINE_WIDTH: 0.579157
G1 X88.249 Y96.73 E.00398
; LINE_WIDTH: 0.572992
G1 X88.584 Y96.843 E.00966
; LINE_WIDTH: 0.511426
G1 X88.919 Y96.956 E.00857
G1 X89.656 Y97.323 E.01994
G1 X89.66 Y96.745 E.01401
M204 S10000
G1 X90.097 Y96.247 F18000
; LINE_WIDTH: 0.419992
G1 F1500
M204 S6000
G1 X85.002 Y96.251 E.10021
G1 X85.005 Y98.101 E.03638
G1 X85.115 Y98.158 E.00243
G1 X85.482 Y97.834 E.00963
G1 X86.188 Y97.426 E.01604
G1 X86.763 Y97.235 E.01193
G1 X87.358 Y97.151 E.01182
G1 X88.213 Y97.21 E.01685
G1 X88.797 Y97.376 E.01193
G1 X89.352 Y97.651 E.01219
G1 X89.751 Y97.956 E.00987
G1 X89.877 Y97.849 E.00324
G1 X90.097 Y97.87 E.00436
G1 X90.097 Y96.307 E.03075
; CHANGE_LAYER
; Z_HEIGHT: 1.88
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F1500
G1 X90.097 Y97.87 E-.29701
G1 X89.877 Y97.849 E-.04211
G1 X89.751 Y97.956 E-.03132
G1 X89.711 Y97.925 E-.00956
; WIPE_END
G1 E-.02 F1800
; layer num/total_layer_count: 15/49
; update layer progress
M73 L15
M991 S0 P14 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z2.16 I1.02 J.664 P1  F18000
G1 X94.431 Y90.682 Z2.16
G1 Z1.88
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X94.269 Y90.682 E.00342
G1 X94.269 Y90.22 E.00977
G1 X95.431 Y90.22 E.02458
G1 X95.431 Y90.682 E.00977
G1 X94.491 Y90.682 E.0199
; WIPE_START
M204 S6000
G1 X94.269 Y90.682 E-.04209
G1 X94.269 Y90.22 E-.08769
G1 X95.431 Y90.22 E-.22069
G1 X95.431 Y90.376 E-.02952
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X98.669 Y90.22 Z2.28 F18000
G1 Z1.88
G1 E.4 F1800
G1 F1500
M204 S500
G1 X99.831 Y90.22 E.02458
G1 X99.831 Y90.682 E.00977
G1 X98.669 Y90.682 E.02458
G1 X98.669 Y90.28 E.0085
; WIPE_START
M204 S6000
G1 X99.831 Y90.22 E-.22098
G1 X99.831 Y90.682 E-.08769
G1 X99.455 Y90.682 E-.07132
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X98.638 Y94.889 Z2.28 F18000
G1 Z1.88
G1 E.4 F1800
G1 F1500
M204 S500
G1 X99.407 Y94.12 E.02301
G1 X99.407 Y95.357 E.02619
G1 X98.169 Y95.357 E.02619
G1 X98.595 Y94.931 E.01276
M204 S10000
G1 X98.338 Y94.589 F18000
G1 F1500
M204 S500
G1 X99.831 Y93.096 E.04469
G1 X99.831 Y95.782 E.05685
G1 X97.145 Y95.782 E.05685
G1 X98.295 Y94.631 E.03444
; WIPE_START
M204 S6000
G1 X99.71 Y93.217 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X96.569 Y87.944 Z2.28 F18000
G1 Z1.88
G1 E.4 F1800
G1 F1500
M204 S500
G1 X97.531 Y87.944 E.02035
G1 X97.05 Y88.425 E.01439
G1 X96.612 Y87.987 E.01312
; WIPE_START
M204 S6000
G1 X97.531 Y87.944 E-.17484
G1 X97.05 Y88.425 E-.1292
G1 X96.767 Y88.143 E-.07596
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X94.693 Y94.12 Z2.28 F18000
G1 Z1.88
G1 E.4 F1800
G1 F1500
M204 S500
G1 X95.931 Y95.357 E.03704
G1 X94.693 Y95.357 E.02619
G1 X94.693 Y94.18 E.02492
; WIPE_START
M204 S6000
G1 X95.931 Y95.357 E-.32452
G1 X95.639 Y95.357 E-.05549
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X89.52 Y98.284 Z2.28 F18000
G1 Z1.88
G1 E.4 F1800
G1 F1500
M204 S500
G1 X89.152 Y98.008 E.00974
G1 X88.663 Y97.764 E.01157
G1 X88.154 Y97.615 E.01123
G1 X87.778 Y97.564 E.00804
G1 X87.398 Y97.558 E.00804
G1 X86.887 Y97.628 E.0109
G1 X86.523 Y97.734 E.00804
G1 X86.173 Y97.883 E.00804
G1 X85.722 Y98.162 E.01123
G1 X85.316 Y98.528 E.01157
G1 X84.978 Y98.965 E.01168
G1 X84.793 Y99.33 E.00867
G1 X84.598 Y99.284 E.00425
G1 X84.593 Y95.842 E.07285
G1 X90.507 Y95.837 E.12517
G1 X90.507 Y99.269 E.07264
G1 X90.301 Y99.309 E.00443
G1 X90.253 Y99.192 E.0027
G1 X89.932 Y98.701 E.0124
G1 X89.586 Y98.334 E.01068
G1 X89.569 Y98.32 E.00047
M204 S10000
G1 X89.266 Y98.624 F18000
G1 F1500
M204 S500
G1 X89.303 Y98.651 E.00097
G1 X89.597 Y98.965 E.00911
G1 X89.876 Y99.39 E.01076
G1 X90.052 Y99.819 E.00982
G1 X90.128 Y100.131 E.0068
G1 X90.163 Y100.412 E.00599
G1 X90.154 Y100.911 E.01055
G1 X90.055 Y101.377 E.01009
G1 X89.854 Y101.852 E.01091
G1 X89.556 Y102.289 E.01119
G1 X89.188 Y102.649 E.01091
G1 X88.801 Y102.904 E.00979
G1 X88.546 Y103.024 E.00598
G1 X88.204 Y103.139 E.00763
G1 X87.755 Y103.214 E.00963
G1 X87.432 Y103.219 E.00683
M73 P49 R14
G1 X87.112 Y103.185 E.00683
G1 X86.666 Y103.069 E.00975
G1 X86.248 Y102.875 E.00975
G1 X85.978 Y102.697 E.00683
G1 X85.739 Y102.495 E.00663
G1 X85.526 Y102.265 E.00663
G1 X85.336 Y102.004 E.00683
G1 X85.124 Y101.595 E.00975
G1 X84.986 Y101.146 E.00995
G1 X84.929 Y100.679 E.00995
G1 X84.957 Y100.219 E.00975
G1 X85.024 Y99.905 E.0068
G1 X85.114 Y99.637 E.00599
G1 X85.338 Y99.192 E.01055
G1 X85.628 Y98.818 E.01002
G1 X85.977 Y98.503 E.00995
G1 X86.369 Y98.261 E.00975
G1 X86.666 Y98.134 E.00683
G1 X86.976 Y98.044 E.00683
G1 X87.423 Y97.983 E.00956
G1 X87.746 Y97.988 E.00683
G1 X88.066 Y98.031 E.00683
G1 X88.508 Y98.16 E.00975
G1 X88.928 Y98.371 E.00995
G1 X89.218 Y98.588 E.00767
M204 S250
G1 X89.021 Y98.951 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X89.029 Y98.957 E.0002
G1 X89.275 Y99.219 E.00706
G1 X89.512 Y99.581 E.00852
G1 X89.661 Y99.946 E.00776
G1 X89.725 Y100.206 E.00525
G1 X89.753 Y100.434 E.00452
G1 X89.745 Y100.864 E.00845
G1 X89.662 Y101.254 E.00784
G1 X89.493 Y101.655 E.00857
G1 X89.241 Y102.024 E.00879
G1 X88.929 Y102.329 E.00857
G1 X88.601 Y102.546 E.00775
G1 X88.393 Y102.643 E.00452
G1 X88.104 Y102.741 E.00598
G1 X87.718 Y102.805 E.0077
G1 X87.451 Y102.809 E.00526
G1 X87.185 Y102.781 E.00526
G1 X86.804 Y102.682 E.00773
G1 X86.447 Y102.517 E.00773
G1 X86.224 Y102.369 E.00526
G1 X86.022 Y102.199 E.0052
G1 X85.843 Y102.005 E.0052
G1 X85.685 Y101.788 E.00526
G1 X85.504 Y101.439 E.00773
G1 X85.387 Y101.061 E.0078
G1 X85.34 Y100.667 E.0078
G1 X85.364 Y100.274 E.00774
G1 X85.419 Y100.013 E.00525
G1 X85.492 Y99.795 E.00452
G1 X85.686 Y99.412 E.00845
G1 X85.929 Y99.097 E.00782
G1 X86.224 Y98.832 E.0078
G1 X86.558 Y98.625 E.00773
G1 X86.804 Y98.52 E.00526
G1 X87.061 Y98.445 E.00526
G1 X87.448 Y98.393 E.00767
G1 X87.715 Y98.397 E.00526
G1 X87.98 Y98.433 E.00526
G1 X88.358 Y98.543 E.00773
G1 X88.712 Y98.72 E.0078
G1 X88.973 Y98.915 E.0064
; WIPE_START
M204 S6000
G1 X89.029 Y98.957 E-.01335
G1 X89.275 Y99.219 E-.06821
G1 X89.512 Y99.581 E-.08229
G1 X89.661 Y99.946 E-.07493
G1 X89.725 Y100.206 E-.05074
G1 X89.753 Y100.434 E-.04371
G1 X89.749 Y100.68 E-.04677
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X93.034 Y93.791 Z2.28 F18000
G1 X95.869 Y87.844 Z2.28
G1 Z1.88
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X95.869 Y87.52 E.00686
G1 X96.869 Y87.52 E.02117
G1 X96.869 Y77.382 E.21459
G1 X94.582 Y77.382 E.0484
G1 X94.514 Y77.05 E.00717
G1 X94.373 Y76.788 E.0063
G1 X94.163 Y76.578 E.00629
G1 X93.901 Y76.437 E.0063
G1 X93.636 Y76.382 E.00571
G1 X81.502 Y76.382 E.25684
G1 X81.235 Y76.423 E.00572
G1 X80.934 Y76.577 E.00715
G1 X80.691 Y76.835 E.00751
G1 X80.542 Y77.18 E.00795
G1 X80.531 Y94.473 E.36601
G1 X80.617 Y94.838 E.00795
G1 X80.798 Y95.097 E.00669
G1 X80.995 Y95.262 E.00542
G1 X81.256 Y95.384 E.0061
G1 X81.505 Y95.42 E.00534
G1 X94.269 Y95.41 E.27016
G1 X94.269 Y93.096 E.04898
G1 X96.955 Y95.782 E.08039
G1 X90.931 Y95.782 E.12751
G1 X90.931 Y100.584 E.10165
G1 X90.878 Y101.194 E.01296
G1 X90.782 Y101.588 E.00858
G1 X90.643 Y101.963 E.00848
G1 X90.456 Y102.328 E.00867
G1 X90.112 Y102.804 E.01244
G1 X89.781 Y103.138 E.00996
G1 X89.515 Y103.352 E.00723
G1 X89.19 Y103.557 E.00813
G1 X88.82 Y103.733 E.00867
G1 X88.255 Y103.907 E.01251
G1 X87.659 Y103.979 E.01271
G1 X87.25 Y103.967 E.00867
G1 X86.854 Y103.908 E.00848
G1 X86.468 Y103.803 E.00848
G1 X86.097 Y103.652 E.00847
G1 X85.749 Y103.46 E.0084
G1 X85.37 Y103.182 E.00995
G1 X84.996 Y102.815 E.0111
G1 X84.747 Y102.489 E.00867
G1 X84.543 Y102.144 E.00848
G1 X84.381 Y101.776 E.00851
G1 X84.224 Y101.204 E.01256
G1 X84.176 Y100.801 E.00859
G1 X84.168 Y95.783 E.10621
G1 X81.474 Y95.778 E.05703
G1 X81.29 Y95.755 E.00391
G1 X81.072 Y95.695 E.0048
G1 X80.931 Y95.634 E.00325
G1 X80.792 Y95.554 E.00339
G1 X80.546 Y95.348 E.00678
G1 X80.346 Y95.072 E.00721
G1 X80.251 Y94.866 E.0048
G1 X80.207 Y94.719 E.00325
G1 X80.169 Y94.383 E.00716
G1 X80.169 Y77.419 E.35906
G1 X80.206 Y77.092 E.00697
G1 X80.284 Y76.855 E.00528
G1 X80.403 Y76.635 E.00528
G1 X80.488 Y76.521 E.00301
G1 X80.67 Y76.339 E.00547
G1 X80.785 Y76.254 E.00301
G1 X81.012 Y76.131 E.00547
G1 X81.146 Y76.082 E.00301
G1 X81.399 Y76.03 E.00547
G1 X93.556 Y76.021 E.25732
G1 X93.796 Y76.044 E.0051
G1 X93.946 Y76.079 E.00325
G1 X94.096 Y76.134 E.00339
G1 X94.371 Y76.292 E.00671
G1 X94.511 Y76.412 E.0039
G1 X94.661 Y76.583 E.0048
G1 X94.948 Y77.02 E.01108
G1 X97.231 Y77.02 E.04831
G1 X97.231 Y87.52 E.22224
G1 X98.231 Y87.52 E.02117
G1 X98.231 Y87.844 E.00686
G1 X97.05 Y89.025 E.03534
G1 X95.912 Y87.887 E.03407
; WIPE_START
M204 S6000
G1 X95.869 Y87.52 E-.07014
G1 X96.869 Y87.52 E-.19
G1 X96.869 Y86.889 E-.11986
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X94.84 Y91.091 Z2.28 F18000
G1 Z1.88
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X94.84 Y93.088 E.03928
G1 X97.05 Y95.298 E.06147
G1 X99.26 Y93.088 E.06147
G1 X99.26 Y91.091 E.03928
G1 X98.26 Y91.091 E.01967
G1 X98.26 Y89.811 E.02518
G1 X100.24 Y89.811 E.03895
G1 X100.24 Y96.191 E.12549
G1 X91.34 Y96.191 E.17505
G1 X91.34 Y100.595 E.08663
G1 X91.319 Y100.983 E.00763
G1 X91.28 Y101.27 E.00569
G1 X91.174 Y101.708 E.00887
G1 X91.018 Y102.129 E.00883
G1 X90.812 Y102.531 E.00889
G1 X90.695 Y102.715 E.0043
G1 X90.421 Y103.074 E.00887
G1 X90.055 Y103.443 E.01023
G1 X89.573 Y103.806 E.01186
G1 X89.382 Y103.918 E.00436
G1 X88.974 Y104.113 E.00889
G1 X88.546 Y104.257 E.00889
G1 X88.334 Y104.309 E.0043
G1 X87.883 Y104.376 E.00896
G1 X87.665 Y104.389 E.00429
G1 X87.214 Y104.376 E.00889
G1 X86.769 Y104.309 E.00883
G1 X86.336 Y104.191 E.00883
G1 X85.92 Y104.022 E.00883
G1 X85.528 Y103.806 E.00881
G1 X85.109 Y103.498 E.01023
G1 X84.681 Y103.077 E.0118
G1 X84.407 Y102.718 E.0089
G1 X84.179 Y102.331 E.00883
G1 X83.997 Y101.92 E.00884
G1 X83.884 Y101.556 E.0075
G1 X83.82 Y101.273 E.0057
G1 X83.767 Y100.825 E.00887
G1 X83.76 Y96.191 E.09115
G1 X81.447 Y96.188 E.04548
G1 X81.21 Y96.157 E.00471
G1 X80.936 Y96.082 E.00559
G1 X80.747 Y96 E.00405
G1 X80.567 Y95.896 E.00409
G1 X80.4 Y95.772 E.0041
G1 X80.248 Y95.629 E.00409
G1 X80.115 Y95.47 E.00407
G1 X79.986 Y95.269 E.00471
G1 X79.868 Y95.011 E.00558
G1 X79.809 Y94.814 E.00405
G1 X79.772 Y94.609 E.00409
G1 X79.76 Y94.395 E.00422
G1 X79.76 Y77.407 E.33413
G1 X79.772 Y77.193 E.00422
G1 X79.808 Y76.991 E.00403
G1 X79.907 Y76.692 E.00619
G1 X80.057 Y76.415 E.00619
G1 X80.177 Y76.253 E.00397
G1 X80.402 Y76.028 E.00626
G1 X80.564 Y75.907 E.00397
G1 X80.844 Y75.757 E.00625
G1 X81.034 Y75.687 E.00397
G1 X81.345 Y75.623 E.00626
G1 X81.556 Y75.611 E.00415
G1 X93.575 Y75.612 E.23641
G1 X93.863 Y75.639 E.00568
G1 X94.063 Y75.686 E.00405
G1 X94.259 Y75.758 E.00409
G1 X94.445 Y75.851 E.00409
G1 X94.618 Y75.965 E.00407
G1 X94.799 Y76.121 E.00471
G1 X94.987 Y76.334 E.00559
G1 X95.169 Y76.611 E.00651
G1 X97.64 Y76.611 E.04861
G1 X97.64 Y87.111 E.20653
G1 X98.64 Y87.111 E.01967
G1 X98.64 Y88.014 E.01776
G1 X97.05 Y89.604 E.04423
G1 X95.46 Y88.014 E.04423
G1 X95.46 Y87.111 E.01776
G1 X96.46 Y87.111 E.01967
G1 X96.46 Y77.791 E.18332
G1 X94.16 Y77.791 E.04524
G1 X94.159 Y77.356 E.00855
G1 X94.125 Y77.192 E.0033
G1 X94.041 Y77.035 E.00349
G1 X93.916 Y76.91 E.00349
G1 X93.759 Y76.826 E.00349
G1 X93.595 Y76.792 E.00331
G1 X81.534 Y76.791 E.23723
G1 X81.363 Y76.818 E.0034
G1 X81.183 Y76.91 E.00397
G1 X81.038 Y77.064 E.00417
G1 X80.951 Y77.265 E.00431
G1 X80.94 Y94.425 E.33753
G1 X80.997 Y94.668 E.0049
G1 X81.103 Y94.818 E.00362
G1 X81.216 Y94.914 E.00292
G1 X81.374 Y94.987 E.00343
G1 X81.535 Y95.011 E.00319
G1 X93.86 Y95.001 E.24243
G1 X93.86 Y89.811 E.10209
G1 X95.84 Y89.811 E.03895
G1 X95.84 Y91.091 E.02518
G1 X94.9 Y91.091 E.01849
; WIPE_START
M204 S6000
G1 X94.84 Y93.088 E-.3796
G1 X94.842 Y93.089 E-.0004
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




G1 X94.35 Y92.887
G1 Z1.88
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.596522
G1 F1500
M204 S6000
G1 X94.35 Y90.886 E.05697
; WIPE_START
G1 X94.35 Y92.886 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X95.077 Y94.958 Z2.28 F18000
G1 Z1.88
G1 E.4 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.365752
G1 F1500
M204 S6000
G1 X95.013 Y94.995 E.00125
G1 X95.062 Y95.023 E.00095
; WIPE_START
G1 X95.013 Y94.995 E-.16436
G1 X95.077 Y94.958 E-.21564
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X99.065 Y94.958 Z2.28 F18000
G1 Z1.88
G1 E.4 F1800
G1 F1500
M204 S6000
G1 X99.002 Y94.995 E.00125
G1 X99.05 Y95.023 E.00095
; WIPE_START
G1 X99.002 Y94.995 E-.16436
G1 X99.065 Y94.958 E-.21564
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X99.75 Y92.887 Z2.28 F18000
G1 Z1.88
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.596522
G1 F1500
M204 S6000
G1 X99.75 Y90.886 E.05697
; WIPE_START
G1 X99.75 Y92.886 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X93.251 Y96.888 Z2.28 F18000
G1 X90.294 Y98.709 Z2.28
G1 Z1.88
G1 E.4 F1800
; LINE_WIDTH: 0.142403
G1 F1500
M204 S6000
G1 X90.133 Y98.537 E.00137
; LINE_WIDTH: 0.0995857
G1 X89.942 Y98.366 E.00095
; WIPE_START
G1 X90.133 Y98.537 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X90.187 Y99.548 Z2.28 F18000
G1 Z1.88
G1 E.4 F1800
; LINE_WIDTH: 0.398049
G1 F1500
M204 S6000
M73 P50 R14
G1 X90.32 Y99.627 E.00287
; LINE_WIDTH: 0.423591
G1 X90.453 Y99.705 E.00307
; LINE_WIDTH: 0.46952
G1 X90.486 Y99.726 E.00086
G1 X90.506 Y99.887 E.00358
; LINE_WIDTH: 0.432416
G1 X90.525 Y100.047 E.00328
; LINE_WIDTH: 0.39109
G1 X90.546 Y100.38 E.00607
; LINE_WIDTH: 0.361019
G1 X90.523 Y100.968 E.00986
G1 X90.42 Y101.477 E.00869
G1 X90.291 Y101.806 E.0059
G1 X90.174 Y102.044 E.00444
G1 X90.039 Y102.265 E.00434
G1 X89.826 Y102.555 E.006
G1 X89.525 Y102.853 E.00709
G1 X89.289 Y103.041 E.00504
G1 X88.997 Y103.228 E.0058
G1 X88.679 Y103.38 E.0059
G1 X88.184 Y103.53 E.00865
G1 X87.777 Y103.588 E.00688
G1 X87.425 Y103.595 E.00588
G1 X86.933 Y103.533 E.0083
G1 X86.552 Y103.429 E.0066
G1 X86.262 Y103.305 E.00528
G1 X85.955 Y103.139 E.00584
G1 X85.745 Y102.992 E.00428
G1 X85.471 Y102.761 E.006
G1 X85.243 Y102.51 E.00567
G1 X85.062 Y102.274 E.00498
G1 X84.885 Y101.968 E.00591
G1 X84.74 Y101.645 E.00593
G1 X84.622 Y101.238 E.00708
G1 X84.553 Y100.705 E.00899
G1 X84.567 Y100.18 E.00879
; LINE_WIDTH: 0.4044
G1 X84.587 Y99.979 E.00383
; LINE_WIDTH: 0.44409
G1 X84.605 Y99.804 E.00366
; LINE_WIDTH: 0.474826
G1 X84.651 Y99.515 E.00656
M204 S10000
G1 X84.828 Y98.783 F18000
; LINE_WIDTH: 0.0935124
G1 F1500
M204 S6000
G1 X84.85 Y98.717 E.00023
G1 X84.973 Y98.585 E.00061
; WIPE_START
G1 X84.85 Y98.717 E-.27439
G1 X84.828 Y98.783 E-.10561
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X86.724 Y96.741 Z2.28 F18000
G1 Z1.88
G1 E.4 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.595442
G1 F1500
M204 S6000
G1 X87.011 Y96.722 E.00818
; LINE_WIDTH: 0.563822
G1 X87.298 Y96.702 E.00772
G1 X88.189 Y96.728 E.02394
; WIPE_START
G1 X87.298 Y96.702 E-.2873
G1 X87.011 Y96.722 E-.0927
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X86.724 Y96.741 Z2.28 F18000
G1 Z1.88
G1 E.4 F1800
; LINE_WIDTH: 0.595832
G1 F1500
M204 S6000
G1 X86.412 Y96.722 E.00887
; LINE_WIDTH: 0.557832
G1 X86.101 Y96.704 E.00828
; LINE_WIDTH: 0.504099
G1 X85.438 Y96.685 E.01584
G1 X85.439 Y97.345 E.01575
G1 X85.862 Y97.1 E.01168
; LINE_WIDTH: 0.520852
G1 X86.239 Y96.943 E.01008
; LINE_WIDTH: 0.560892
G1 X86.616 Y96.787 E.0109
; LINE_WIDTH: 0.597872
G1 X86.668 Y96.765 E.00161
; WIPE_START
G1 X86.616 Y96.787 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X89.66 Y96.685 Z2.28 F18000
G1 Z1.88
G1 E.4 F1800
; LINE_WIDTH: 0.506982
G1 F1500
M204 S6000
G1 X88.958 Y96.685 E.01684
; LINE_WIDTH: 0.52107
G1 X88.675 Y96.7 E.007
; LINE_WIDTH: 0.549245
G1 X88.392 Y96.714 E.0074
; LINE_WIDTH: 0.579162
G1 X88.249 Y96.73 E.00398
; LINE_WIDTH: 0.57299
G1 X88.584 Y96.843 E.00966
; LINE_WIDTH: 0.511409
G1 X88.919 Y96.956 E.00857
G1 X89.657 Y97.324 E.01997
G1 X89.66 Y96.745 E.01404
M204 S10000
G1 X90.097 Y96.247 F18000
; LINE_WIDTH: 0.419992
G1 F1500
M204 S6000
G1 X85.002 Y96.251 E.10021
G1 X85.005 Y98.101 E.03638
G1 X85.115 Y98.158 E.00243
G1 X85.491 Y97.824 E.00989
G1 X85.972 Y97.527 E.01112
G1 X86.777 Y97.234 E.01685
G1 X87.358 Y97.151 E.01156
G1 X88.213 Y97.21 E.01685
G1 X88.797 Y97.376 E.01193
G1 X89.352 Y97.651 E.01219
G1 X89.756 Y97.961 E.01
G1 X89.885 Y97.847 E.00339
G1 X90.093 Y97.879 E.00414
G1 X90.097 Y96.307 E.03093
; CHANGE_LAYER
; Z_HEIGHT: 2
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F1500
G1 X90.093 Y97.879 E-.29877
G1 X89.885 Y97.847 E-.04002
G1 X89.756 Y97.961 E-.03275
G1 X89.72 Y97.934 E-.00846
; WIPE_END
G1 E-.02 F1800
; layer num/total_layer_count: 16/49
; update layer progress
M73 L16
M991 S0 P15 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z2.28 I1.021 J.663 P1  F18000
G1 X94.431 Y90.682 Z2.28
G1 Z2
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X94.269 Y90.682 E.00342
G1 X94.269 Y90.22 E.00977
G1 X95.431 Y90.22 E.02458
G1 X95.431 Y90.682 E.00977
G1 X94.491 Y90.682 E.0199
; WIPE_START
M204 S6000
G1 X94.269 Y90.682 E-.04209
G1 X94.269 Y90.22 E-.08769
G1 X95.431 Y90.22 E-.22069
G1 X95.431 Y90.376 E-.02952
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X98.669 Y90.22 Z2.4 F18000
G1 Z2
G1 E.4 F1800
G1 F1500
M204 S500
G1 X99.831 Y90.22 E.02458
G1 X99.831 Y90.682 E.00977
G1 X98.669 Y90.682 E.02458
G1 X98.669 Y90.28 E.0085
; WIPE_START
M204 S6000
G1 X99.831 Y90.22 E-.22098
G1 X99.831 Y90.682 E-.08769
G1 X99.455 Y90.682 E-.07132
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X98.638 Y94.889 Z2.4 F18000
G1 Z2
G1 E.4 F1800
G1 F1500
M204 S500
G1 X99.407 Y94.12 E.02301
G1 X99.407 Y95.357 E.02619
G1 X98.169 Y95.357 E.02619
G1 X98.595 Y94.931 E.01276
M204 S10000
G1 X98.338 Y94.589 F18000
G1 F1500
M204 S500
G1 X99.831 Y93.096 E.04469
G1 X99.831 Y95.782 E.05685
G1 X97.145 Y95.782 E.05685
G1 X98.295 Y94.631 E.03444
; WIPE_START
M204 S6000
G1 X99.71 Y93.217 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X96.569 Y87.944 Z2.4 F18000
G1 Z2
G1 E.4 F1800
G1 F1500
M204 S500
G1 X97.531 Y87.944 E.02035
G1 X97.05 Y88.425 E.01439
G1 X96.612 Y87.987 E.01312
; WIPE_START
M204 S6000
G1 X97.531 Y87.944 E-.17484
G1 X97.05 Y88.425 E-.1292
G1 X96.767 Y88.143 E-.07596
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X94.693 Y94.12 Z2.4 F18000
G1 Z2
G1 E.4 F1800
G1 F1500
M204 S500
G1 X95.931 Y95.357 E.03704
G1 X94.693 Y95.357 E.02619
G1 X94.693 Y94.18 E.02492
; WIPE_START
M204 S6000
G1 X95.931 Y95.357 E-.32452
G1 X95.639 Y95.357 E-.05549
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X89.541 Y98.311 Z2.4 F18000
G1 Z2
G1 E.4 F1800
G1 F1500
M204 S500
G1 X89.276 Y98.092 E.00726
G1 X88.99 Y97.918 E.0071
G1 X88.648 Y97.759 E.00797
G1 X88.154 Y97.615 E.01089
G1 X87.778 Y97.564 E.00804
G1 X87.398 Y97.558 E.00804
G1 X86.872 Y97.63 E.01124
G1 X86.367 Y97.794 E.01123
G1 X86.03 Y97.962 E.00798
G1 X85.749 Y98.145 E.00709
G1 X85.32 Y98.523 E.01211
G1 X84.982 Y98.96 E.01169
G1 X84.792 Y99.325 E.00871
G1 X84.598 Y99.278 E.00423
G1 X84.593 Y95.842 E.07273
G1 X90.507 Y95.837 E.12519
G1 X90.502 Y99.262 E.07249
G1 X90.301 Y99.305 E.00436
G1 X90.058 Y98.872 E.0105
G1 X89.717 Y98.457 E.01136
G1 X89.587 Y98.349 E.00358
M204 S10000
G1 X89.27 Y98.638 F18000
G1 F1500
M204 S500
G1 X89.415 Y98.758 E.00399
G1 X89.71 Y99.117 E.00983
G1 X89.876 Y99.394 E.00683
G1 X90.007 Y99.689 E.00683
G1 X90.13 Y100.133 E.00975
G1 X90.172 Y100.601 E.00995
G1 X90.13 Y101.069 E.00995
G1 X90.007 Y101.513 E.00975
G1 X89.876 Y101.808 E.00683
G1 X89.71 Y102.085 E.00683
G1 X89.418 Y102.441 E.00976
G1 X89.066 Y102.739 E.00975
G1 X88.793 Y102.907 E.00679
G1 X88.539 Y103.027 E.00593
G1 X88.06 Y103.173 E.0106
G1 X87.589 Y103.222 E.01003
G1 X87.121 Y103.187 E.00995
M73 P50 R13
G1 X86.662 Y103.068 E.01003
G1 X86.21 Y102.852 E.0106
G1 X85.977 Y102.696 E.00593
G1 X85.732 Y102.489 E.00679
G1 X85.435 Y102.149 E.00956
G1 X85.261 Y101.877 E.00683
G1 X85.121 Y101.586 E.00683
G1 X84.986 Y101.146 E.00975
G1 X84.931 Y100.689 E.00975
G1 X84.94 Y100.366 E.00683
G1 X84.988 Y100.047 E.00683
G1 X85.124 Y99.606 E.00976
G1 X85.341 Y99.19 E.00994
G1 X85.63 Y98.815 E.01002
G1 X86.007 Y98.484 E.01061
G1 X86.241 Y98.331 E.00593
G1 X86.528 Y98.187 E.0068
G1 X86.966 Y98.045 E.00975
G1 X87.423 Y97.983 E.00975
G1 X87.746 Y97.988 E.00683
G1 X88.066 Y98.031 E.00683
G1 X88.499 Y98.158 E.00955
G1 X88.79 Y98.293 E.00679
G1 X89.029 Y98.439 E.00594
G1 X89.224 Y98.6 E.00534
M204 S250
G1 X89.009 Y98.953 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X89.124 Y99.048 E.00293
G1 X89.375 Y99.353 E.00776
G1 X89.512 Y99.583 E.00526
G1 X89.621 Y99.827 E.00526
G1 X89.725 Y100.206 E.00774
G1 X89.761 Y100.601 E.00779
G1 X89.725 Y100.996 E.00779
G1 X89.621 Y101.375 E.00774
G1 X89.512 Y101.619 E.00526
G1 X89.375 Y101.849 E.00526
G1 X89.125 Y102.153 E.00774
G1 X88.825 Y102.407 E.00773
G1 X88.598 Y102.547 E.00525
G1 X88.392 Y102.644 E.00448
G1 X87.979 Y102.77 E.0085
G1 X87.583 Y102.811 E.00782
G1 X87.188 Y102.782 E.00779
G1 X86.803 Y102.682 E.00782
G1 X86.413 Y102.496 E.0085
G1 X86.224 Y102.369 E.00448
G1 X86.02 Y102.196 E.00525
G1 X85.763 Y101.903 E.00767
G1 X85.619 Y101.677 E.00526
G1 X85.503 Y101.436 E.00526
G1 X85.387 Y101.061 E.00773
G1 X85.341 Y100.67 E.00773
G1 X85.349 Y100.403 E.00526
G1 X85.388 Y100.138 E.00526
G1 X85.504 Y99.762 E.00774
G1 X85.687 Y99.411 E.00779
G1 X85.93 Y99.096 E.00782
G1 X86.255 Y98.811 E.0085
G1 X86.445 Y98.686 E.00447
G1 X86.684 Y98.567 E.00525
G1 X87.058 Y98.445 E.00773
G1 X87.448 Y98.393 E.00774
G1 X87.715 Y98.397 E.00526
G1 X87.98 Y98.433 E.00526
G1 X88.355 Y98.542 E.00767
G1 X88.597 Y98.654 E.00525
G1 X88.791 Y98.773 E.00448
G1 X88.963 Y98.915 E.00439
; WIPE_START
M204 S6000
G1 X89.124 Y99.048 E-.03974
G1 X89.375 Y99.353 E-.07494
G1 X89.512 Y99.583 E-.05083
G1 X89.621 Y99.827 E-.05083
G1 X89.725 Y100.206 E-.07473
G1 X89.761 Y100.601 E-.07529
G1 X89.754 Y100.672 E-.01364
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X93.039 Y93.783 Z2.4 F18000
G1 X95.869 Y87.844 Z2.4
G1 Z2
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X95.869 Y87.52 E.00686
G1 X96.869 Y87.52 E.02117
G1 X96.869 Y77.382 E.21459
G1 X94.582 Y77.382 E.0484
G1 X94.514 Y77.05 E.00717
G1 X94.373 Y76.788 E.00629
G1 X94.163 Y76.578 E.0063
G1 X93.901 Y76.437 E.00629
G1 X93.636 Y76.382 E.00572
G1 X81.505 Y76.382 E.25677
G1 X81.247 Y76.419 E.00553
G1 X80.936 Y76.576 E.00737
G1 X80.691 Y76.835 E.00756
G1 X80.542 Y77.181 E.00796
G1 X80.531 Y94.476 E.36607
G1 X80.623 Y94.85 E.00816
G1 X80.801 Y95.099 E.00646
G1 X80.994 Y95.262 E.00536
G1 X81.255 Y95.384 E.0061
G1 X81.505 Y95.42 E.00534
G1 X94.269 Y95.41 E.27016
G1 X94.269 Y93.096 E.04898
G1 X96.955 Y95.782 E.08039
G1 X90.932 Y95.782 E.12749
G1 X90.924 Y100.801 E.10623
G1 X90.876 Y101.199 E.00848
G1 X90.782 Y101.588 E.00848
G1 X90.643 Y101.963 E.00848
G1 X90.456 Y102.328 E.00867
G1 X90.112 Y102.804 E.01243
G1 X89.777 Y103.141 E.01005
G1 X89.515 Y103.352 E.00713
G1 X89.19 Y103.557 E.00813
G1 X88.82 Y103.733 E.00867
G1 X88.255 Y103.907 E.01251
G1 X87.659 Y103.979 E.01271
G1 X87.25 Y103.967 E.00866
G1 X86.854 Y103.908 E.00848
G1 X86.468 Y103.803 E.00848
G1 X86.096 Y103.652 E.00848
G1 X85.749 Y103.461 E.00839
G1 X85.367 Y103.179 E.01005
G1 X84.996 Y102.815 E.011
G1 X84.747 Y102.489 E.00868
G1 X84.543 Y102.144 E.00848
G1 X84.381 Y101.776 E.00852
G1 X84.224 Y101.203 E.01256
G1 X84.176 Y100.801 E.00859
G1 X84.168 Y95.783 E.10621
G1 X81.479 Y95.778 E.05691
G1 X81.223 Y95.741 E.00548
G1 X80.931 Y95.634 E.00659
G1 X80.792 Y95.554 E.00339
G1 X80.553 Y95.354 E.00659
G1 X80.393 Y95.151 E.00547
G1 X80.317 Y95.02 E.0032
G1 X80.207 Y94.719 E.00678
G1 X80.169 Y94.383 E.00716
G1 X80.169 Y77.419 E.35906
G1 X80.206 Y77.092 E.00697
G1 X80.284 Y76.855 E.00528
G1 X80.403 Y76.635 E.00528
G1 X80.488 Y76.521 E.00301
G1 X80.664 Y76.345 E.00528
G1 X80.868 Y76.202 E.00528
G1 X80.995 Y76.138 E.00301
G1 X81.241 Y76.057 E.00547
G1 X81.39 Y76.03 E.00321
G1 X93.558 Y76.021 E.25756
G1 X93.796 Y76.044 E.00506
G1 X94.096 Y76.134 E.00664
G1 X94.232 Y76.202 E.00321
G1 X94.443 Y76.35 E.00547
G1 X94.657 Y76.577 E.00659
G1 X94.948 Y77.02 E.01122
G1 X97.231 Y77.02 E.04831
G1 X97.231 Y87.52 E.22224
G1 X98.231 Y87.52 E.02117
G1 X98.231 Y87.844 E.00686
G1 X97.05 Y89.025 E.03534
G1 X95.912 Y87.887 E.03407
; WIPE_START
M204 S6000
G1 X95.869 Y87.52 E-.07014
G1 X96.869 Y87.52 E-.19
G1 X96.869 Y86.889 E-.11986
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X94.84 Y91.091 Z2.4 F18000
G1 Z2
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X94.84 Y93.088 E.03928
G1 X97.05 Y95.298 E.06147
G1 X99.26 Y93.088 E.06147
G1 X99.26 Y91.091 E.03928
G1 X98.26 Y91.091 E.01967
G1 X98.26 Y89.811 E.02518
G1 X100.24 Y89.811 E.03895
G1 X100.24 Y96.191 E.12549
G1 X91.34 Y96.191 E.17505
G1 X91.333 Y100.825 E.09115
G1 X91.28 Y101.271 E.00883
G1 X91.174 Y101.708 E.00883
G1 X91.018 Y102.129 E.00883
G1 X90.812 Y102.531 E.00889
G1 X90.695 Y102.715 E.00429
G1 X90.421 Y103.074 E.00887
G1 X90.051 Y103.446 E.01032
G1 X89.573 Y103.806 E.01177
G1 X89.382 Y103.918 E.00436
G1 X88.974 Y104.113 E.00889
G1 X88.546 Y104.257 E.00889
G1 X88.334 Y104.309 E.0043
G1 X87.883 Y104.376 E.00896
G1 X87.665 Y104.389 E.00429
G1 X87.214 Y104.376 E.00889
G1 X86.769 Y104.309 E.00883
G1 X86.336 Y104.191 E.00883
G1 X85.92 Y104.022 E.00883
G1 X85.528 Y103.806 E.00881
G1 X85.106 Y103.495 E.01032
G1 X84.681 Y103.078 E.01171
G1 X84.407 Y102.718 E.0089
G1 X84.179 Y102.331 E.00883
G1 X83.997 Y101.92 E.00884
G1 X83.885 Y101.56 E.00742
G1 X83.82 Y101.273 E.00579
G1 X83.767 Y100.825 E.00887
G1 X83.76 Y96.191 E.09115
G1 X81.449 Y96.188 E.04545
G1 X81.134 Y96.141 E.00626
G1 X80.938 Y96.083 E.00403
G1 X80.747 Y96 E.00409
G1 X80.567 Y95.896 E.00409
G1 X80.4 Y95.772 E.0041
G1 X80.25 Y95.631 E.00403
G1 X80.053 Y95.382 E.00626
G1 X79.951 Y95.204 E.00403
G1 X79.868 Y95.013 E.0041
G1 X79.809 Y94.814 E.00409
G1 X79.772 Y94.609 E.00409
G1 X79.76 Y94.395 E.00422
G1 X79.76 Y77.407 E.33413
G1 X79.772 Y77.193 E.00422
G1 X79.808 Y76.991 E.00403
G1 X79.907 Y76.692 E.0062
G1 X80.057 Y76.415 E.00619
G1 X80.177 Y76.253 E.00397
G1 X80.4 Y76.03 E.00619
G1 X80.658 Y75.85 E.0062
M73 P51 R13
G1 X80.838 Y75.759 E.00397
G1 X81.14 Y75.659 E.00625
G1 X81.342 Y75.623 E.00404
G1 X81.556 Y75.611 E.00422
G1 X93.578 Y75.612 E.23645
G1 X93.863 Y75.639 E.00564
G1 X94.063 Y75.686 E.00405
G1 X94.259 Y75.758 E.00409
G1 X94.442 Y75.85 E.00403
G1 X94.703 Y76.032 E.00626
G1 X94.852 Y76.173 E.00403
G1 X94.986 Y76.332 E.0041
G1 X95.169 Y76.611 E.00656
G1 X97.64 Y76.611 E.04861
G1 X97.64 Y87.111 E.20653
G1 X98.64 Y87.111 E.01967
G1 X98.64 Y88.014 E.01776
G1 X97.05 Y89.604 E.04423
G1 X95.46 Y88.014 E.04423
G1 X95.46 Y87.111 E.01776
G1 X96.46 Y87.111 E.01967
G1 X96.46 Y77.791 E.18332
G1 X94.16 Y77.791 E.04524
G1 X94.159 Y77.356 E.00855
G1 X94.125 Y77.192 E.0033
G1 X94.041 Y77.035 E.00349
G1 X93.916 Y76.91 E.00349
G1 X93.759 Y76.826 E.00349
G1 X93.595 Y76.792 E.00331
G1 X81.535 Y76.791 E.23721
G1 X81.371 Y76.815 E.00325
G1 X81.184 Y76.909 E.00413
G1 X81.038 Y77.064 E.00418
G1 X80.951 Y77.265 E.00432
G1 X80.94 Y94.426 E.33754
G1 X81.002 Y94.676 E.00506
G1 X81.104 Y94.819 E.00345
G1 X81.216 Y94.914 E.00289
G1 X81.374 Y94.987 E.00343
G1 X81.535 Y95.011 E.00319
G1 X93.86 Y95.001 E.24243
G1 X93.86 Y89.811 E.10209
G1 X95.84 Y89.811 E.03895
G1 X95.84 Y91.091 E.02518
G1 X94.9 Y91.091 E.01849
; WIPE_START
M204 S6000
G1 X94.84 Y93.088 E-.3796
G1 X94.842 Y93.089 E-.0004
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




G1 X94.35 Y92.887
G1 Z2
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.596522
G1 F1500
M204 S6000
G1 X94.35 Y90.886 E.05697
; WIPE_START
G1 X94.35 Y92.886 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X95.077 Y94.958 Z2.4 F18000
G1 Z2
G1 E.4 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.365752
G1 F1500
M204 S6000
G1 X95.013 Y94.995 E.00125
G1 X95.062 Y95.023 E.00095
; WIPE_START
G1 X95.013 Y94.995 E-.16436
G1 X95.077 Y94.958 E-.21564
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X99.065 Y94.958 Z2.4 F18000
G1 Z2
G1 E.4 F1800
G1 F1500
M204 S6000
G1 X99.002 Y94.995 E.00125
G1 X99.05 Y95.023 E.00095
; WIPE_START
G1 X99.002 Y94.995 E-.16436
G1 X99.065 Y94.958 E-.21564
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X99.75 Y92.887 Z2.4 F18000
G1 Z2
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.596522
G1 F1500
M204 S6000
G1 X99.75 Y90.886 E.05697
; WIPE_START
G1 X99.75 Y92.886 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X93.258 Y96.9 Z2.4 F18000
G1 X90.291 Y98.735 Z2.4
G1 Z2
G1 E.4 F1800
; LINE_WIDTH: 0.117835
G1 F1500
M204 S6000
G1 X90.17 Y98.612 E.00079
; LINE_WIDTH: 0.0927341
G1 X90.049 Y98.488 E.00058
; WIPE_START
G1 X90.17 Y98.612 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X90.443 Y99.492 Z2.4 F18000
G1 Z2
G1 E.4 F1800
; LINE_WIDTH: 0.476279
G1 F1500
M204 S6000
G1 X90.482 Y99.766 E.00623
; LINE_WIDTH: 0.430341
G1 X90.522 Y100.04 E.0056
; LINE_WIDTH: 0.403767
G1 X90.526 Y100.078 E.00071
; LINE_WIDTH: 0.376943
G1 X90.548 Y100.586 E.00891
; LINE_WIDTH: 0.360618
G1 X90.503 Y101.132 E.00914
G1 X90.415 Y101.476 E.00594
G1 X90.293 Y101.809 E.00593
G1 X90.126 Y102.133 E.00609
G1 X90.009 Y102.31 E.00354
G1 X89.821 Y102.553 E.00513
G1 X89.521 Y102.855 E.00712
G1 X89.292 Y103.044 E.00496
G1 X89.009 Y103.222 E.00558
G1 X88.665 Y103.385 E.00636
G1 X88.12 Y103.545 E.00948
G1 X87.648 Y103.599 E.00793
G1 X87.284 Y103.584 E.00609
G1 X86.933 Y103.533 E.00593
G1 X86.59 Y103.442 E.00593
G1 X86.034 Y103.186 E.01022
G1 X85.612 Y102.886 E.00865
G1 X85.288 Y102.564 E.00763
G1 X85.141 Y102.385 E.00388
G1 X84.927 Y102.052 E.00661
G1 X84.775 Y101.735 E.00587
G1 X84.622 Y101.238 E.00869
G1 X84.554 Y100.718 E.00877
G1 X84.572 Y100.146 E.00956
; LINE_WIDTH: 0.40857
G1 X84.585 Y99.97 E.00337
; LINE_WIDTH: 0.441569
G1 X84.621 Y99.725 E.00514
; LINE_WIDTH: 0.474146
G1 X84.653 Y99.51 E.00487
M204 S10000
G1 X84.828 Y98.783 F18000
; LINE_WIDTH: 0.0961491
G1 F1500
M204 S6000
G1 X84.853 Y98.709 E.00027
G1 X84.989 Y98.564 E.0007
; WIPE_START
G1 X84.853 Y98.709 E-.27331
G1 X84.828 Y98.783 E-.10669
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X86.705 Y96.742 Z2.4 F18000
G1 Z2
G1 E.4 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.597347
G1 F1500
M204 S6000
G1 X87.001 Y96.722 E.00848
; LINE_WIDTH: 0.563924
G1 X87.298 Y96.702 E.00798
G1 X88.189 Y96.728 E.02395
; WIPE_START
G1 X87.298 Y96.702 E-.28502
G1 X87.001 Y96.722 E-.09498
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X86.705 Y96.742 Z2.4 F18000
G1 Z2
G1 E.4 F1800
; LINE_WIDTH: 0.599267
G1 F1500
M204 S6000
G1 X86.484 Y96.724 E.00634
; LINE_WIDTH: 0.563057
G1 X86.263 Y96.707 E.00594
; LINE_WIDTH: 0.510666
G1 X86.042 Y96.689 E.00536
G1 X85.442 Y96.689 E.01451
G1 X85.443 Y97.346 E.01588
G1 X85.972 Y97.044 E.01473
; LINE_WIDTH: 0.529252
G1 X86.294 Y96.911 E.00874
; LINE_WIDTH: 0.570272
G1 X86.615 Y96.778 E.00946
; LINE_WIDTH: 0.604077
G1 X86.649 Y96.765 E.00105
; WIPE_START
G1 X86.615 Y96.778 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X89.657 Y96.687 Z2.4 F18000
G1 Z2
G1 E.4 F1800
; LINE_WIDTH: 0.511582
G1 F1500
M204 S6000
G1 X88.939 Y96.688 E.0174
; LINE_WIDTH: 0.524932
G1 X88.666 Y96.701 E.00681
; LINE_WIDTH: 0.551632
G1 X88.392 Y96.715 E.00718
; LINE_WIDTH: 0.579987
G1 X88.249 Y96.73 E.00398
; LINE_WIDTH: 0.57414
G1 X88.575 Y96.839 E.00942
; LINE_WIDTH: 0.51562
G1 X88.902 Y96.949 E.00841
G1 X89.656 Y97.334 E.02069
G1 X89.657 Y96.747 E.01434
M204 S10000
G1 X90.098 Y96.247 F18000
; LINE_WIDTH: 0.419992
G1 F1500
M204 S6000
G1 X85.002 Y96.251 E.10021
G1 X85.005 Y98.077 E.03592
G1 X85.079 Y98.088 E.00146
G1 X85.135 Y98.14 E.00151
G1 X85.523 Y97.805 E.01009
G1 X86.189 Y97.425 E.01507
G1 X86.763 Y97.234 E.01191
G1 X87.358 Y97.151 E.01182
G1 X88.213 Y97.21 E.01685
G1 X88.778 Y97.371 E.01156
G1 X89.492 Y97.745 E.01585
G1 X89.891 Y98.07 E.01012
G1 X89.99 Y97.983 E.00258
G1 X90.095 Y97.996 E.00208
G1 X90.097 Y96.307 E.03323
; CHANGE_LAYER
; Z_HEIGHT: 2.12
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F1500
G1 X90.095 Y97.996 E-.32102
G1 X89.99 Y97.983 E-.02011
G1 X89.891 Y98.07 E-.02492
G1 X89.834 Y98.024 E-.01395
; WIPE_END
G1 E-.02 F1800
; layer num/total_layer_count: 17/49
; update layer progress
M73 L17
M991 S0 P16 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z2.4 I1.031 J.646 P1  F18000
G1 X94.431 Y90.682 Z2.4
G1 Z2.12
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X94.269 Y90.682 E.00342
G1 X94.269 Y90.22 E.00977
G1 X95.431 Y90.22 E.02458
G1 X95.431 Y90.682 E.00977
G1 X94.491 Y90.682 E.0199
; WIPE_START
M204 S6000
G1 X94.269 Y90.682 E-.04209
G1 X94.269 Y90.22 E-.08769
G1 X95.431 Y90.22 E-.22069
G1 X95.431 Y90.376 E-.02952
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X98.669 Y90.22 Z2.52 F18000
G1 Z2.12
G1 E.4 F1800
G1 F1500
M204 S500
G1 X99.831 Y90.22 E.02458
G1 X99.831 Y90.682 E.00977
G1 X98.669 Y90.682 E.02458
G1 X98.669 Y90.28 E.0085
; WIPE_START
M204 S6000
G1 X99.831 Y90.22 E-.22098
G1 X99.831 Y90.682 E-.08769
G1 X99.455 Y90.682 E-.07132
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X98.638 Y94.889 Z2.52 F18000
G1 Z2.12
G1 E.4 F1800
G1 F1500
M204 S500
G1 X99.407 Y94.12 E.02301
G1 X99.407 Y95.357 E.02619
G1 X98.169 Y95.357 E.02619
G1 X98.595 Y94.931 E.01276
M204 S10000
G1 X98.338 Y94.589 F18000
G1 F1500
M204 S500
G1 X99.831 Y93.096 E.04469
G1 X99.831 Y95.782 E.05685
G1 X97.145 Y95.782 E.05685
G1 X98.295 Y94.631 E.03444
; WIPE_START
M204 S6000
G1 X99.71 Y93.217 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X96.569 Y87.944 Z2.52 F18000
G1 Z2.12
G1 E.4 F1800
G1 F1500
M204 S500
G1 X97.531 Y87.944 E.02035
G1 X97.05 Y88.425 E.01439
G1 X96.612 Y87.987 E.01312
; WIPE_START
M204 S6000
G1 X97.531 Y87.944 E-.17484
G1 X97.05 Y88.425 E-.1292
G1 X96.767 Y88.143 E-.07596
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X94.693 Y94.12 Z2.52 F18000
G1 Z2.12
G1 E.4 F1800
G1 F1500
M204 S500
G1 X95.931 Y95.357 E.03704
G1 X94.693 Y95.357 E.02619
G1 X94.693 Y94.18 E.02492
; WIPE_START
M204 S6000
G1 X95.931 Y95.357 E-.32452
G1 X95.639 Y95.357 E-.05549
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X89.609 Y98.364 Z2.52 F18000
G1 Z2.12
G1 E.4 F1800
G1 F1500
M204 S500
G1 X89.55 Y98.303 E.0018
G1 X89.148 Y98.006 E.01056
G1 X88.677 Y97.771 E.01115
G1 X88.316 Y97.653 E.00804
G1 X87.943 Y97.58 E.00804
G1 X87.413 Y97.556 E.01123
G1 X86.872 Y97.63 E.01157
G1 X86.367 Y97.794 E.01123
G1 X86.03 Y97.962 E.00798
G1 X85.752 Y98.143 E.00703
G1 X85.332 Y98.513 E.01184
G1 X85.086 Y98.811 E.00817
G1 X84.882 Y99.131 E.00804
G1 X84.799 Y99.316 E.00428
G1 X84.598 Y99.273 E.00436
G1 X84.593 Y95.842 E.07262
G1 X90.507 Y95.837 E.12519
G1 X90.502 Y99.259 E.07241
G1 X90.297 Y99.299 E.00443
G1 X90.255 Y99.197 E.00233
G1 X89.957 Y98.731 E.0117
G1 X89.65 Y98.408 E.00944
M204 S10000
G1 X89.301 Y98.657 F18000
G1 F1500
M204 S500
G1 X89.622 Y98.994 E.00985
G1 X89.877 Y99.393 E.01003
G1 X90.052 Y99.82 E.00975
G1 X90.128 Y100.131 E.00679
G1 X90.162 Y100.404 E.00583
G1 X90.158 Y100.863 E.00971
G1 X90.059 Y101.361 E.01075
G1 X89.944 Y101.667 E.00691
G1 X89.795 Y101.953 E.00683
G1 X89.524 Y102.326 E.00975
G1 X89.191 Y102.644 E.00975
G1 X88.927 Y102.83 E.00683
G1 X88.643 Y102.983 E.00683
G1 X88.21 Y103.138 E.00975
G1 X87.746 Y103.215 E.00995
G1 X87.276 Y103.208 E.00995
G1 X86.824 Y103.119 E.00975
G1 X86.52 Y103.01 E.00683
G1 X86.231 Y102.866 E.00683
G1 X85.862 Y102.606 E.00955
G1 X85.629 Y102.383 E.00683
G1 X85.424 Y102.134 E.00683
G1 X85.189 Y101.74 E.0097
G1 X85.037 Y101.344 E.009
G1 X84.941 Y100.849 E.01067
G1 X84.931 Y100.522 E.00691
G1 X84.96 Y100.201 E.00683
G1 X85.069 Y99.754 E.00975
G1 X85.256 Y99.333 E.00976
G1 X85.43 Y99.061 E.00683
G1 X85.637 Y98.809 E.00691
G1 X86.009 Y98.482 E.01046
G1 X86.241 Y98.331 E.00588
G1 X86.529 Y98.187 E.00679
G1 X86.966 Y98.045 E.00975
G1 X87.432 Y97.982 E.00995
G1 X87.893 Y98.002 E.00975
G1 X88.209 Y98.065 E.00683
G1 X88.516 Y98.165 E.00683
G1 X88.926 Y98.37 E.0097
G1 X89.259 Y98.615 E.00874
M204 S250
G1 X89.005 Y98.939 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X89.298 Y99.247 E.00838
G1 X89.512 Y99.582 E.00782
G1 X89.661 Y99.946 E.00774
G1 X89.725 Y100.206 E.00525
G1 X89.753 Y100.428 E.00441
G1 X89.749 Y100.82 E.00772
G1 X89.664 Y101.248 E.00858
G1 X89.569 Y101.5 E.00529
G1 X89.446 Y101.737 E.00526
G1 X89.215 Y102.055 E.00773
G1 X88.931 Y102.327 E.00773
G1 X88.712 Y102.481 E.00526
G1 X88.476 Y102.608 E.00526
G1 X88.106 Y102.741 E.00774
G1 X87.715 Y102.806 E.0078
G1 X87.319 Y102.8 E.00779
G1 X86.933 Y102.724 E.00774
G1 X86.681 Y102.633 E.00526
G1 X86.442 Y102.514 E.00526
G1 X86.123 Y102.289 E.00767
G1 X85.93 Y102.104 E.00526
G1 X85.76 Y101.898 E.00526
G1 X85.559 Y101.561 E.00772
G1 X85.432 Y101.23 E.00696
G1 X85.349 Y100.803 E.00855
G1 X85.341 Y100.535 E.00529
G1 X85.365 Y100.268 E.00526
G1 X85.458 Y99.886 E.00773
G1 X85.618 Y99.527 E.00774
G1 X85.762 Y99.302 E.00526
G1 X85.932 Y99.094 E.00528
G1 X86.257 Y98.809 E.00849
G1 X86.445 Y98.686 E.00443
G1 X86.684 Y98.567 E.00525
G1 X87.058 Y98.445 E.00773
G1 X87.451 Y98.392 E.0078
G1 X87.844 Y98.41 E.00773
G1 X88.106 Y98.462 E.00526
G1 X88.36 Y98.544 E.00526
G1 X88.711 Y98.72 E.00772
G1 X88.958 Y98.902 E.00602
; WIPE_START
M204 S6000
G1 X89.298 Y99.247 E-.09221
G1 X89.512 Y99.582 E-.07554
G1 X89.661 Y99.946 E-.07473
G1 X89.725 Y100.206 E-.0507
G1 X89.753 Y100.428 E-.0426
G1 X89.751 Y100.661 E-.04421
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X93.039 Y93.773 Z2.52 F18000
G1 X95.869 Y87.844 Z2.52
G1 Z2.12
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X95.869 Y87.52 E.00686
G1 X96.869 Y87.52 E.02117
G1 X96.869 Y77.382 E.21459
G1 X94.582 Y77.382 E.0484
G1 X94.514 Y77.05 E.00717
G1 X94.373 Y76.788 E.0063
G1 X94.163 Y76.578 E.00629
G1 X93.901 Y76.437 E.00629
G1 X93.636 Y76.382 E.00572
G1 X81.496 Y76.382 E.25697
G1 X81.198 Y76.434 E.0064
G1 X80.894 Y76.61 E.00744
G1 X80.679 Y76.856 E.00691
G1 X80.542 Y77.184 E.00751
G1 X80.531 Y94.446 E.36537
G1 X80.566 Y94.686 E.00513
G1 X80.678 Y94.946 E.00601
G1 X80.961 Y95.246 E.00873
G1 X81.256 Y95.384 E.00688
G1 X81.505 Y95.42 E.00533
G1 X94.269 Y95.41 E.27016
G1 X94.269 Y93.096 E.04898
G1 X96.955 Y95.782 E.08039
G1 X90.932 Y95.782 E.12749
G1 X90.924 Y100.801 E.10623
G1 X90.876 Y101.199 E.00848
G1 X90.782 Y101.588 E.00848
G1 X90.643 Y101.963 E.00848
G1 X90.459 Y102.321 E.00852
G1 X90.116 Y102.801 E.01249
G1 X89.774 Y103.144 E.01025
G1 X89.515 Y103.352 E.00703
G1 X89.19 Y103.557 E.00813
G1 X88.824 Y103.731 E.00859
G1 X88.368 Y103.879 E.01015
M73 P52 R13
G1 X88.042 Y103.945 E.00703
G1 X87.659 Y103.979 E.00813
G1 X87.25 Y103.967 E.00866
G1 X86.854 Y103.908 E.00848
G1 X86.468 Y103.803 E.00848
G1 X86.096 Y103.652 E.00848
G1 X85.749 Y103.461 E.00839
G1 X85.363 Y103.176 E.01015
G1 X84.995 Y102.814 E.01092
G1 X84.747 Y102.489 E.00867
G1 X84.543 Y102.144 E.00848
G1 X84.319 Y101.595 E.01255
G1 X84.239 Y101.272 E.00703
G1 X84.176 Y100.797 E.01016
G1 X84.168 Y95.783 E.10612
G1 X81.479 Y95.778 E.05691
G1 X81.223 Y95.741 E.00548
G1 X80.931 Y95.634 E.00659
G1 X80.792 Y95.554 E.0034
G1 X80.546 Y95.348 E.00678
G1 X80.344 Y95.069 E.00729
G1 X80.252 Y94.866 E.00471
G1 X80.207 Y94.719 E.00325
G1 X80.169 Y94.383 E.00716
G1 X80.169 Y77.419 E.35906
G1 X80.206 Y77.092 E.00697
G1 X80.284 Y76.855 E.00528
G1 X80.403 Y76.636 E.00527
G1 X80.488 Y76.521 E.00302
G1 X80.668 Y76.341 E.00538
G1 X80.813 Y76.236 E.00381
G1 X81.01 Y76.132 E.00471
G1 X81.146 Y76.082 E.00306
G1 X81.399 Y76.03 E.00547
G1 X93.561 Y76.021 E.25741
G1 X93.796 Y76.044 E.005
G1 X93.946 Y76.079 E.00326
G1 X94.24 Y76.206 E.00678
G1 X94.374 Y76.294 E.0034
G1 X94.622 Y76.534 E.00729
G1 X94.957 Y77.02 E.0125
G1 X97.231 Y77.02 E.04813
G1 X97.231 Y87.52 E.22224
G1 X98.231 Y87.52 E.02117
G1 X98.231 Y87.844 E.00686
G1 X97.05 Y89.025 E.03534
G1 X95.912 Y87.887 E.03407
; WIPE_START
M204 S6000
G1 X95.869 Y87.52 E-.07014
G1 X96.869 Y87.52 E-.19
G1 X96.869 Y86.889 E-.11986
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X94.84 Y91.091 Z2.52 F18000
G1 Z2.12
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X94.84 Y93.088 E.03928
G1 X97.05 Y95.298 E.06147
G1 X99.26 Y93.088 E.06147
G1 X99.26 Y91.091 E.03928
G1 X98.26 Y91.091 E.01967
G1 X98.26 Y89.811 E.02518
G1 X100.24 Y89.811 E.03895
G1 X100.24 Y96.191 E.12549
G1 X91.34 Y96.191 E.17505
G1 X91.333 Y100.825 E.09115
G1 X91.28 Y101.271 E.00883
G1 X91.174 Y101.708 E.00883
G1 X91.018 Y102.129 E.00883
G1 X90.813 Y102.529 E.00884
G1 X90.607 Y102.839 E.00732
G1 X90.423 Y103.073 E.00586
G1 X90.048 Y103.449 E.01044
G1 X89.573 Y103.806 E.01168
G1 X89.382 Y103.918 E.00436
G1 X88.975 Y104.112 E.00887
G1 X88.472 Y104.275 E.01041
G1 X87.886 Y104.376 E.01168
G1 X87.665 Y104.389 E.00436
G1 X87.214 Y104.376 E.00889
G1 X86.769 Y104.309 E.00883
G1 X86.336 Y104.191 E.00883
G1 X85.92 Y104.022 E.00883
G1 X85.528 Y103.806 E.00881
G1 X85.102 Y103.492 E.01041
G1 X84.681 Y103.077 E.01162
G1 X84.407 Y102.718 E.00889
G1 X84.179 Y102.331 E.00883
G1 X83.996 Y101.918 E.00889
G1 X83.836 Y101.349 E.01162
G1 X83.767 Y100.824 E.01042
G1 X83.76 Y96.191 E.09112
G1 X81.449 Y96.188 E.04545
G1 X81.134 Y96.141 E.00626
G1 X80.938 Y96.083 E.00403
G1 X80.747 Y96 E.00409
G1 X80.566 Y95.896 E.0041
G1 X80.4 Y95.772 E.00409
G1 X80.248 Y95.629 E.00409
G1 X80.115 Y95.471 E.00407
G1 X79.984 Y95.265 E.0048
G1 X79.868 Y95.011 E.0055
G1 X79.809 Y94.814 E.00405
G1 X79.772 Y94.609 E.00409
G1 X79.76 Y94.395 E.00422
G1 X79.76 Y77.407 E.33413
G1 X79.772 Y77.193 E.00422
G1 X79.808 Y76.991 E.00403
G1 X79.907 Y76.692 E.0062
G1 X80.057 Y76.415 E.00619
G1 X80.177 Y76.253 E.00398
G1 X80.401 Y76.029 E.00622
G1 X80.596 Y75.888 E.00474
G1 X80.843 Y75.757 E.0055
G1 X81.034 Y75.687 E.00399
G1 X81.345 Y75.623 E.00626
G1 X81.556 Y75.611 E.00415
G1 X93.58 Y75.612 E.2365
G1 X93.863 Y75.639 E.00559
G1 X94.063 Y75.686 E.00405
G1 X94.259 Y75.758 E.00409
G1 X94.445 Y75.851 E.00409
G1 X94.619 Y75.965 E.00409
G1 X94.777 Y76.098 E.00406
G1 X94.942 Y76.278 E.0048
G1 X95.172 Y76.611 E.00795
G1 X97.64 Y76.611 E.04855
G1 X97.64 Y87.111 E.20653
G1 X98.64 Y87.111 E.01967
G1 X98.64 Y88.014 E.01776
G1 X97.05 Y89.604 E.04423
G1 X95.46 Y88.014 E.04423
G1 X95.46 Y87.111 E.01776
G1 X96.46 Y87.111 E.01967
G1 X96.46 Y77.791 E.18332
G1 X94.16 Y77.791 E.04524
G1 X94.159 Y77.356 E.00855
G1 X94.125 Y77.191 E.0033
G1 X94.041 Y77.035 E.00349
G1 X93.916 Y76.91 E.00349
G1 X93.759 Y76.826 E.00349
G1 X93.595 Y76.792 E.00331
G1 X81.532 Y76.791 E.23727
G1 X81.34 Y76.825 E.00382
G1 X81.158 Y76.93 E.00415
G1 X81.031 Y77.075 E.00379
G1 X80.951 Y77.266 E.00407
G1 X80.94 Y94.416 E.33732
G1 X80.963 Y94.573 E.00312
G1 X81.025 Y94.718 E.0031
G1 X81.205 Y94.908 E.00515
G1 X81.374 Y94.987 E.00367
G1 X81.535 Y95.011 E.00319
G1 X93.86 Y95.001 E.24243
G1 X93.86 Y89.811 E.10209
G1 X95.84 Y89.811 E.03895
G1 X95.84 Y91.091 E.02518
G1 X94.9 Y91.091 E.01849
; WIPE_START
M204 S6000
G1 X94.84 Y93.088 E-.3796
G1 X94.842 Y93.089 E-.0004
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




G1 X94.35 Y92.887
G1 Z2.12
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.596522
G1 F1500
M204 S6000
G1 X94.35 Y90.886 E.05697
; WIPE_START
G1 X94.35 Y92.886 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X95.077 Y94.958 Z2.52 F18000
G1 Z2.12
G1 E.4 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.365752
G1 F1500
M204 S6000
G1 X95.013 Y94.995 E.00125
G1 X95.062 Y95.023 E.00095
; WIPE_START
G1 X95.013 Y94.995 E-.16436
G1 X95.077 Y94.958 E-.21564
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X99.065 Y94.958 Z2.52 F18000
G1 Z2.12
G1 E.4 F1800
G1 F1500
M204 S6000
G1 X99.002 Y94.995 E.00125
G1 X99.05 Y95.023 E.00095
; WIPE_START
G1 X99.002 Y94.995 E-.16436
G1 X99.065 Y94.958 E-.21564
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X99.75 Y92.887 Z2.52 F18000
G1 Z2.12
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.596522
G1 F1500
M204 S6000
G1 X99.75 Y90.886 E.05697
; WIPE_START
G1 X99.75 Y92.886 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X93.597 Y97.403 Z2.52 F18000
G1 X90.464 Y99.703 Z2.52
G1 Z2.12
G1 E.4 F1800
; LINE_WIDTH: 0.444821
G1 F1500
M204 S6000
G1 X90.324 Y99.62 E.0034
; LINE_WIDTH: 0.417917
G1 X90.184 Y99.537 E.00319
M204 S10000
G1 X90.464 Y99.703 F18000
; LINE_WIDTH: 0.468429
G1 F1500
M204 S6000
G1 X90.482 Y99.714 E.00047
G1 X90.502 Y99.881 E.00371
; LINE_WIDTH: 0.427519
G1 X90.522 Y100.047 E.00336
; LINE_WIDTH: 0.385537
G1 X90.543 Y100.371 E.00581
; LINE_WIDTH: 0.361087
G1 X90.531 Y100.917 E.00914
G1 X90.419 Y101.477 E.00956
G1 X90.295 Y101.81 E.00595
G1 X90.133 Y102.126 E.00595
G1 X89.799 Y102.585 E.00949
G1 X89.519 Y102.859 E.00656
G1 X89.29 Y103.042 E.00489
G1 X89.008 Y103.22 E.00558
G1 X88.682 Y103.375 E.00604
G1 X88.29 Y103.507 E.00692
G1 X87.983 Y103.565 E.00523
G1 X87.651 Y103.596 E.00558
G1 X87.284 Y103.588 E.00615
G1 X86.933 Y103.532 E.00594
G1 X86.59 Y103.441 E.00594
G1 X86.261 Y103.307 E.00594
G1 X86.049 Y103.196 E.00401
G1 X85.607 Y102.885 E.00903
G1 X85.346 Y102.632 E.00608
G1 X85.123 Y102.361 E.00588
M73 P53 R13
G1 X84.856 Y101.918 E.00865
G1 X84.672 Y101.433 E.00867
G1 X84.617 Y101.198 E.00404
G1 X84.557 Y100.771 E.00722
G1 X84.571 Y100.123 E.01085
; LINE_WIDTH: 0.417393
G1 X84.608 Y99.811 E.00612
; LINE_WIDTH: 0.46481
G1 X84.646 Y99.5 E.00687
M204 S10000
G1 X84.829 Y98.784 F18000
; LINE_WIDTH: 0.0970914
G1 F1500
M204 S6000
G1 X84.853 Y98.709 E.00028
G1 X84.965 Y98.585 E.00059
; WIPE_START
G1 X84.853 Y98.709 E-.25801
G1 X84.829 Y98.784 E-.12199
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X86.705 Y96.742 Z2.52 F18000
G1 Z2.12
G1 E.4 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.596692
G1 F1500
M204 S6000
G1 X87.011 Y96.722 E.00874
; LINE_WIDTH: 0.549563
G1 X87.317 Y96.701 E.00802
G1 X88.077 Y96.716 E.01988
; WIPE_START
G1 X87.317 Y96.701 E-.27081
G1 X87.011 Y96.722 E-.10919
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X86.705 Y96.742 Z2.52 F18000
G1 Z2.12
G1 E.4 F1800
; LINE_WIDTH: 0.599249
G1 F1500
M204 S6000
G1 X86.484 Y96.724 E.00634
; LINE_WIDTH: 0.563042
G1 X86.263 Y96.707 E.00594
; LINE_WIDTH: 0.510655
G1 X86.042 Y96.689 E.00536
G1 X85.442 Y96.689 E.01452
G1 X85.443 Y97.345 E.01587
G1 X85.972 Y97.044 E.01473
; LINE_WIDTH: 0.52924
G1 X86.294 Y96.911 E.00874
; LINE_WIDTH: 0.570255
G1 X86.615 Y96.778 E.00945
; LINE_WIDTH: 0.604057
G1 X86.649 Y96.765 E.00105
; WIPE_START
G1 X86.615 Y96.778 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X89.659 Y96.685 Z2.52 F18000
G1 Z2.12
G1 E.4 F1800
; LINE_WIDTH: 0.506812
G1 F1500
M204 S6000
G1 X88.953 Y96.685 E.01695
; LINE_WIDTH: 0.524197
G1 X88.545 Y96.703 E.01015
; LINE_WIDTH: 0.547377
G1 X88.137 Y96.721 E.01062
G1 X88.918 Y96.96 E.02125
; LINE_WIDTH: 0.506812
G1 X89.658 Y97.303 E.01959
G1 X89.659 Y96.745 E.0134
M204 S10000
G1 X90.098 Y96.247 F18000
; LINE_WIDTH: 0.419992
G1 F1500
M204 S6000
G1 X85.002 Y96.251 E.10021
G1 X85.005 Y98.105 E.03648
G1 X85.109 Y98.163 E.00233
G1 X85.493 Y97.826 E.01006
G1 X86.226 Y97.409 E.01657
G1 X86.763 Y97.235 E.01112
G1 X87.377 Y97.148 E.01219
G1 X87.977 Y97.172 E.01181
G1 X88.808 Y97.383 E.01685
G1 X89.348 Y97.649 E.01184
G1 X89.808 Y97.984 E.0112
G1 X90.094 Y98.302 E.00842
G1 X90.097 Y96.307 E.03925
; CHANGE_LAYER
; Z_HEIGHT: 2.24
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F1500
G1 X90.094 Y98.302 E-.37917
G1 X90.091 Y98.299 E-.00083
; WIPE_END
G1 E-.02 F1800
; layer num/total_layer_count: 18/49
; update layer progress
M73 L18
M991 S0 P17 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z2.52 I1.057 J.602 P1  F18000
G1 X94.431 Y90.682 Z2.52
G1 Z2.24
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X94.269 Y90.682 E.00342
G1 X94.269 Y90.22 E.00977
G1 X95.431 Y90.22 E.02458
G1 X95.431 Y90.682 E.00977
G1 X94.491 Y90.682 E.0199
; WIPE_START
M204 S6000
G1 X94.269 Y90.682 E-.04209
G1 X94.269 Y90.22 E-.08769
G1 X95.431 Y90.22 E-.22069
G1 X95.431 Y90.376 E-.02952
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X98.669 Y90.22 Z2.64 F18000
G1 Z2.24
G1 E.4 F1800
G1 F1500
M204 S500
G1 X99.831 Y90.22 E.02458
G1 X99.831 Y90.682 E.00977
G1 X98.669 Y90.682 E.02458
G1 X98.669 Y90.28 E.0085
; WIPE_START
M204 S6000
G1 X99.831 Y90.22 E-.22098
G1 X99.831 Y90.682 E-.08769
G1 X99.455 Y90.682 E-.07132
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X98.638 Y94.889 Z2.64 F18000
G1 Z2.24
G1 E.4 F1800
G1 F1500
M204 S500
G1 X99.407 Y94.12 E.02301
G1 X99.407 Y95.357 E.02619
G1 X98.169 Y95.357 E.02619
G1 X98.595 Y94.931 E.01276
M204 S10000
G1 X98.338 Y94.589 F18000
G1 F1500
M204 S500
G1 X99.831 Y93.096 E.04469
G1 X99.831 Y95.782 E.05685
G1 X97.145 Y95.782 E.05685
G1 X98.295 Y94.631 E.03444
; WIPE_START
M204 S6000
G1 X99.71 Y93.217 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X96.569 Y87.944 Z2.64 F18000
G1 Z2.24
G1 E.4 F1800
G1 F1500
M204 S500
G1 X97.531 Y87.944 E.02035
G1 X97.05 Y88.425 E.01439
G1 X96.612 Y87.987 E.01312
; WIPE_START
M204 S6000
G1 X97.531 Y87.944 E-.17484
G1 X97.05 Y88.425 E-.1292
G1 X96.767 Y88.143 E-.07596
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X94.693 Y94.12 Z2.64 F18000
G1 Z2.24
G1 E.4 F1800
G1 F1500
M204 S500
G1 X95.931 Y95.357 E.03704
G1 X94.693 Y95.357 E.02619
G1 X94.693 Y94.18 E.02492
; WIPE_START
M204 S6000
G1 X95.931 Y95.357 E-.32452
G1 X95.639 Y95.357 E-.05549
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X89.498 Y98.268 Z2.64 F18000
G1 Z2.24
G1 E.4 F1800
G1 F1500
M204 S500
G1 X89.152 Y98.008 E.00916
G1 X88.663 Y97.764 E.01157
G1 X88.154 Y97.615 E.01123
G1 X87.778 Y97.564 E.00804
G1 X87.398 Y97.558 E.00804
G1 X86.872 Y97.63 E.01124
G1 X86.367 Y97.794 E.01123
G1 X86.03 Y97.962 E.00797
G1 X85.754 Y98.142 E.00698
G1 X85.332 Y98.512 E.01189
G1 X85.086 Y98.811 E.00818
G1 X84.882 Y99.131 E.00804
G1 X84.8 Y99.316 E.00428
G1 X84.598 Y99.273 E.00436
G1 X84.593 Y95.842 E.07262
G1 X90.507 Y95.837 E.12519
G1 X90.502 Y99.259 E.07241
G1 X90.297 Y99.299 E.00443
G1 X90.255 Y99.197 E.00233
G1 X89.961 Y98.737 E.01156
G1 X89.589 Y98.336 E.01157
G1 X89.546 Y98.304 E.00113
M204 S10000
G1 X89.244 Y98.607 F18000
G1 F1500
M204 S500
G1 X89.304 Y98.653 E.00159
G1 X89.624 Y98.997 E.00995
G1 X89.877 Y99.393 E.00995
G1 X90.052 Y99.819 E.00975
G1 X90.128 Y100.133 E.00683
G1 X90.167 Y100.453 E.00683
G1 X90.153 Y100.905 E.00955
G1 X90.096 Y101.222 E.00683
G1 X90.001 Y101.531 E.00683
G1 X89.801 Y101.946 E.00975
G1 X89.524 Y102.326 E.00995
G1 X89.185 Y102.651 E.00995
G1 X88.802 Y102.903 E.00971
G1 X88.553 Y103.021 E.00582
G1 X88.205 Y103.139 E.00779
G1 X87.746 Y103.215 E.00984
G1 X87.276 Y103.208 E.00995
G1 X86.826 Y103.12 E.00971
G1 X86.567 Y103.029 E.00582
G1 X86.235 Y102.868 E.00779
G1 X85.862 Y102.606 E.00964
G1 X85.629 Y102.383 E.00683
G1 X85.424 Y102.134 E.00683
G1 X85.188 Y101.739 E.00975
G1 X85.023 Y101.299 E.00995
G1 X84.94 Y100.845 E.00976
G1 X84.931 Y100.523 E.00683
G1 X84.96 Y100.201 E.00683
G1 X85.069 Y99.754 E.00975
G1 X85.256 Y99.333 E.00975
G1 X85.43 Y99.061 E.00683
G1 X85.638 Y98.808 E.00691
G1 X86.011 Y98.481 E.01051
G1 X86.242 Y98.331 E.00583
G1 X86.528 Y98.187 E.00679
G1 X86.966 Y98.045 E.00975
G1 X87.423 Y97.983 E.00975
G1 X87.746 Y97.988 E.00683
G1 X88.066 Y98.031 E.00683
G1 X88.508 Y98.16 E.00975
G1 X88.928 Y98.371 E.00996
G1 X89.196 Y98.571 E.00708
M204 S250
G1 X88.999 Y98.935 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X89.029 Y98.958 E.00076
G1 X89.299 Y99.248 E.0078
G1 X89.512 Y99.582 E.00779
G1 X89.661 Y99.946 E.00773
G1 X89.725 Y100.206 E.00526
G1 X89.757 Y100.472 E.00526
G1 X89.745 Y100.862 E.00767
G1 X89.697 Y101.125 E.00526
G1 X89.618 Y101.381 E.00526
G1 X89.448 Y101.735 E.00773
G1 X89.215 Y102.055 E.00779
G1 X88.928 Y102.329 E.0078
G1 X88.601 Y102.546 E.00772
G1 X88.399 Y102.641 E.00438
G1 X88.105 Y102.741 E.00613
G1 X87.715 Y102.806 E.00776
G1 X87.319 Y102.8 E.00779
G1 X86.934 Y102.724 E.00772
G1 X86.724 Y102.65 E.00438
G1 X86.443 Y102.515 E.00613
G1 X86.123 Y102.289 E.0077
G1 X85.93 Y102.104 E.00526
G1 X85.76 Y101.898 E.00526
G1 X85.558 Y101.56 E.00773
G1 X85.419 Y101.189 E.0078
G1 X85.349 Y100.802 E.00774
G1 X85.341 Y100.535 E.00526
G1 X85.365 Y100.268 E.00526
G1 X85.458 Y99.886 E.00773
G1 X85.618 Y99.527 E.00774
G1 X85.762 Y99.302 E.00526
G1 X85.933 Y99.094 E.00529
G1 X86.259 Y98.808 E.00854
G1 X86.445 Y98.686 E.00438
G1 X86.684 Y98.567 E.00525
G1 X87.058 Y98.445 E.00773
G1 X87.448 Y98.393 E.00774
G1 X87.715 Y98.397 E.00526
G1 X87.98 Y98.433 E.00526
G1 X88.358 Y98.543 E.00773
G1 X88.712 Y98.72 E.0078
G1 X88.951 Y98.899 E.00585
; WIPE_START
M204 S6000
G1 X89.029 Y98.958 E-.01872
G1 X89.299 Y99.248 E-.07532
G1 X89.512 Y99.582 E-.0753
G1 X89.661 Y99.946 E-.0747
G1 X89.725 Y100.206 E-.05086
G1 X89.757 Y100.472 E-.0508
G1 X89.751 Y100.652 E-.03431
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X93.041 Y93.765 Z2.64 F18000
G1 X95.869 Y87.844 Z2.64
G1 Z2.24
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X95.869 Y87.52 E.00686
G1 X96.869 Y87.52 E.02117
G1 X96.869 Y77.382 E.21459
G1 X94.582 Y77.382 E.0484
G1 X94.514 Y77.05 E.00717
G1 X94.373 Y76.788 E.00629
G1 X94.162 Y76.578 E.0063
G1 X93.901 Y76.437 E.00629
G1 X93.636 Y76.382 E.00571
G1 X81.496 Y76.382 E.25696
G1 X81.198 Y76.434 E.00639
G1 X80.894 Y76.61 E.00745
G1 X80.679 Y76.857 E.00693
G1 X80.542 Y77.184 E.0075
G1 X80.531 Y94.473 E.36594
G1 X80.617 Y94.836 E.00789
G1 X80.789 Y95.086 E.00643
G1 X80.991 Y95.26 E.00565
G1 X81.256 Y95.384 E.00618
G1 X81.505 Y95.42 E.00534
G1 X94.269 Y95.41 E.27016
G1 X94.269 Y93.096 E.04898
G1 X96.955 Y95.782 E.08039
G1 X90.932 Y95.782 E.12749
G1 X90.924 Y100.801 E.10623
G1 X90.876 Y101.199 E.00848
G1 X90.782 Y101.588 E.00848
G1 X90.643 Y101.963 E.00848
G1 X90.456 Y102.328 E.00867
G1 X90.113 Y102.804 E.01242
G1 X89.771 Y103.147 E.01025
G1 X89.515 Y103.351 E.00694
G1 X89.19 Y103.557 E.00813
G1 X88.82 Y103.733 E.00867
G1 X88.255 Y103.907 E.01251
G1 X87.659 Y103.979 E.01271
G1 X87.25 Y103.967 E.00866
G1 X86.854 Y103.908 E.00848
G1 X86.468 Y103.803 E.00848
G1 X86.097 Y103.652 E.00847
G1 X85.749 Y103.461 E.00839
G1 X85.36 Y103.173 E.01024
G1 X84.995 Y102.815 E.01083
G1 X84.747 Y102.489 E.00867
G1 X84.543 Y102.144 E.00848
G1 X84.381 Y101.776 E.00852
G1 X84.224 Y101.203 E.01257
G1 X84.176 Y100.801 E.00858
G1 X84.168 Y95.783 E.10621
G1 X81.479 Y95.778 E.05691
G1 X81.223 Y95.741 E.00548
G1 X80.931 Y95.634 E.00659
G1 X80.792 Y95.554 E.0034
G1 X80.546 Y95.348 E.00678
G1 X80.36 Y95.098 E.00659
G1 X80.251 Y94.864 E.00547
G1 X80.207 Y94.719 E.0032
G1 X80.169 Y94.383 E.00717
G1 X80.169 Y77.419 E.35906
G1 X80.206 Y77.092 E.00697
G1 X80.284 Y76.855 E.00528
G1 X80.403 Y76.636 E.00528
G1 X80.488 Y76.521 E.00302
G1 X80.667 Y76.342 E.00537
G1 X80.815 Y76.235 E.00386
G1 X81.01 Y76.132 E.00466
G1 X81.146 Y76.082 E.00307
G1 X81.399 Y76.03 E.00547
G1 X93.563 Y76.021 E.25746
G1 X93.796 Y76.044 E.00496
G1 X93.946 Y76.079 E.00326
G1 X94.24 Y76.206 E.00678
G1 X94.374 Y76.294 E.0034
G1 X94.623 Y76.535 E.00733
G1 X94.957 Y77.02 E.01246
G1 X97.231 Y77.02 E.04814
G1 X97.231 Y87.52 E.22224
G1 X98.231 Y87.52 E.02117
G1 X98.231 Y87.844 E.00686
G1 X97.05 Y89.025 E.03534
G1 X95.912 Y87.887 E.03407
; WIPE_START
M204 S6000
G1 X95.869 Y87.52 E-.07014
G1 X96.869 Y87.52 E-.19
G1 X96.869 Y86.889 E-.11986
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X94.84 Y91.091 Z2.64 F18000
G1 Z2.24
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X94.84 Y93.088 E.03928
G1 X97.05 Y95.298 E.06147
G1 X99.26 Y93.088 E.06147
G1 X99.26 Y91.091 E.03928
G1 X98.26 Y91.091 E.01967
G1 X98.26 Y89.811 E.02518
G1 X100.24 Y89.811 E.03895
G1 X100.24 Y96.191 E.12549
G1 X91.34 Y96.191 E.17505
G1 X91.333 Y100.825 E.09115
G1 X91.28 Y101.271 E.00883
G1 X91.174 Y101.708 E.00883
G1 X91.018 Y102.129 E.00883
G1 X90.812 Y102.531 E.00889
G1 X90.695 Y102.715 E.00429
G1 X90.422 Y103.074 E.00886
G1 X90.044 Y103.452 E.01051
G1 X89.573 Y103.806 E.01159
G1 X89.382 Y103.918 E.00436
G1 X88.974 Y104.113 E.00889
G1 X88.546 Y104.257 E.00889
G1 X88.334 Y104.309 E.0043
G1 X87.883 Y104.376 E.00896
G1 X87.665 Y104.389 E.00429
G1 X87.214 Y104.376 E.00889
G1 X86.769 Y104.309 E.00883
G1 X86.336 Y104.191 E.00883
G1 X85.92 Y104.022 E.00883
G1 X85.528 Y103.806 E.0088
G1 X85.099 Y103.489 E.0105
G1 X84.681 Y103.077 E.01153
G1 X84.407 Y102.718 E.00889
G1 X84.179 Y102.331 E.00883
G1 X83.997 Y101.92 E.00885
G1 X83.888 Y101.569 E.00723
G1 X83.82 Y101.273 E.00597
G1 X83.767 Y100.825 E.00886
G1 X83.76 Y96.191 E.09115
G1 X81.449 Y96.188 E.04545
G1 X81.134 Y96.141 E.00626
G1 X80.938 Y96.083 E.00403
G1 X80.747 Y96 E.0041
G1 X80.567 Y95.896 E.00409
G1 X80.4 Y95.772 E.00409
G1 X80.248 Y95.629 E.00409
G1 X80.114 Y95.47 E.00409
G1 X80.002 Y95.298 E.00403
G1 X79.867 Y95.01 E.00625
G1 X79.809 Y94.814 E.00403
G1 X79.772 Y94.609 E.0041
G1 X79.76 Y94.395 E.00422
G1 X79.76 Y77.407 E.33413
G1 X79.772 Y77.193 E.00422
G1 X79.808 Y76.991 E.00403
G1 X79.907 Y76.692 E.00619
G1 X80.057 Y76.415 E.00619
G1 X80.177 Y76.253 E.00398
G1 X80.401 Y76.029 E.00622
G1 X80.598 Y75.886 E.00479
G1 X80.843 Y75.757 E.00545
G1 X81.034 Y75.687 E.00399
G1 X81.345 Y75.623 E.00626
G1 X81.556 Y75.611 E.00415
G1 X93.582 Y75.612 E.23654
G1 X93.863 Y75.639 E.00554
G1 X94.063 Y75.686 E.00405
G1 X94.259 Y75.758 E.00409
G1 X94.445 Y75.851 E.00409
G1 X94.619 Y75.965 E.0041
G1 X94.777 Y76.098 E.00406
G1 X94.944 Y76.28 E.00485
G1 X95.172 Y76.611 E.00791
G1 X97.64 Y76.611 E.04855
G1 X97.64 Y87.111 E.20653
G1 X98.64 Y87.111 E.01967
G1 X98.64 Y88.014 E.01776
G1 X97.05 Y89.604 E.04423
G1 X95.46 Y88.014 E.04423
G1 X95.46 Y87.111 E.01776
G1 X96.46 Y87.111 E.01967
G1 X96.46 Y77.791 E.18332
G1 X94.16 Y77.791 E.04524
G1 X94.159 Y77.356 E.00855
G1 X94.125 Y77.191 E.0033
G1 X94.041 Y77.035 E.00349
G1 X93.915 Y76.91 E.0035
G1 X93.759 Y76.826 E.00349
G1 X93.595 Y76.792 E.00331
G1 X81.532 Y76.791 E.23727
G1 X81.34 Y76.825 E.00382
G1 X81.158 Y76.93 E.00415
G1 X81.031 Y77.076 E.0038
G1 X80.951 Y77.266 E.00406
G1 X80.94 Y94.425 E.3375
G1 X80.997 Y94.667 E.00489
G1 X81.096 Y94.81 E.00342
G1 X81.215 Y94.913 E.0031
G1 X81.374 Y94.987 E.00345
G1 X81.535 Y95.011 E.00319
G1 X93.86 Y95.001 E.24243
M73 P53 R12
G1 X93.86 Y89.811 E.10209
G1 X95.84 Y89.811 E.03895
G1 X95.84 Y91.091 E.02518
G1 X94.9 Y91.091 E.01849
; WIPE_START
M204 S6000
G1 X94.84 Y93.088 E-.3796
G1 X94.842 Y93.089 E-.0004
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




G1 X94.35 Y92.887
G1 Z2.24
M73 P54 R12
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.596522
G1 F1500
M204 S6000
G1 X94.35 Y90.886 E.05697
; WIPE_START
G1 X94.35 Y92.886 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X95.077 Y94.958 Z2.64 F18000
G1 Z2.24
G1 E.4 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.365752
G1 F1500
M204 S6000
G1 X95.013 Y94.995 E.00125
G1 X95.062 Y95.023 E.00095
; WIPE_START
G1 X95.013 Y94.995 E-.16436
G1 X95.077 Y94.958 E-.21564
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X99.065 Y94.958 Z2.64 F18000
G1 Z2.24
G1 E.4 F1800
G1 F1500
M204 S6000
G1 X99.002 Y94.995 E.00125
G1 X99.05 Y95.023 E.00095
; WIPE_START
G1 X99.002 Y94.995 E-.16436
G1 X99.065 Y94.958 E-.21564
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X99.75 Y92.887 Z2.64 F18000
G1 Z2.24
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.596522
G1 F1500
M204 S6000
G1 X99.75 Y90.886 E.05697
; WIPE_START
G1 X99.75 Y92.886 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X93.248 Y96.884 Z2.64 F18000
G1 X90.291 Y98.702 Z2.64
G1 Z2.24
G1 E.4 F1800
; LINE_WIDTH: 0.145624
G1 F1500
M204 S6000
G1 X90.168 Y98.571 E.00108
; LINE_WIDTH: 0.118083
G1 X90.052 Y98.466 E.00072
; LINE_WIDTH: 0.0925322
G1 X89.936 Y98.362 E.00052
; WIPE_START
G1 X90.052 Y98.466 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X90.184 Y99.537 Z2.64 F18000
G1 Z2.24
G1 E.4 F1800
; LINE_WIDTH: 0.417554
G1 F1500
M204 S6000
G1 X90.324 Y99.62 E.00318
; LINE_WIDTH: 0.444419
G1 X90.464 Y99.702 E.0034
; LINE_WIDTH: 0.468284
G1 X90.482 Y99.714 E.00048
G1 X90.502 Y99.882 E.00373
; LINE_WIDTH: 0.427051
G1 X90.522 Y100.05 E.00338
; LINE_WIDTH: 0.382715
G1 X90.545 Y100.424 E.00667
; LINE_WIDTH: 0.360583
G1 X90.541 Y100.778 E.00591
G1 X90.5 Y101.131 E.00594
G1 X90.417 Y101.476 E.00593
G1 X90.347 Y101.68 E.00359
G1 X90.118 Y102.152 E.00878
G1 X89.825 Y102.556 E.00832
G1 X89.516 Y102.862 E.00728
G1 X89.289 Y103.041 E.00481
G1 X89.009 Y103.222 E.00558
G1 X88.679 Y103.379 E.0061
G1 X88.179 Y103.531 E.00874
G1 X87.76 Y103.59 E.00707
G1 X87.284 Y103.588 E.00795
G1 X86.933 Y103.532 E.00593
G1 X86.59 Y103.441 E.00593
G1 X86.261 Y103.306 E.00593
G1 X86.056 Y103.2 E.00387
G1 X85.604 Y102.883 E.00922
G1 X85.346 Y102.632 E.006
G1 X85.123 Y102.361 E.00587
G1 X84.855 Y101.916 E.00869
G1 X84.659 Y101.384 E.00946
G1 X84.603 Y101.134 E.00428
G1 X84.557 Y100.778 E.006
G1 X84.571 Y100.123 E.01095
; LINE_WIDTH: 0.417391
G1 X84.608 Y99.811 E.00612
; LINE_WIDTH: 0.464809
G1 X84.646 Y99.5 E.00687
M204 S10000
G1 X84.829 Y98.784 F18000
; LINE_WIDTH: 0.0972312
G1 F1500
M204 S6000
G1 X84.853 Y98.708 E.00028
G1 X84.966 Y98.584 E.0006
; WIPE_START
G1 X84.853 Y98.708 E-.25817
G1 X84.829 Y98.784 E-.12183
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X86.705 Y96.742 Z2.64 F18000
G1 Z2.24
G1 E.4 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.597342
G1 F1500
M204 S6000
G1 X87.001 Y96.722 E.00848
; LINE_WIDTH: 0.563913
G1 X87.298 Y96.702 E.00798
G1 X88.189 Y96.728 E.02394
; WIPE_START
G1 X87.298 Y96.702 E-.28501
G1 X87.001 Y96.722 E-.09499
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X86.705 Y96.742 Z2.64 F18000
G1 Z2.24
G1 E.4 F1800
; LINE_WIDTH: 0.599257
G1 F1500
M204 S6000
G1 X86.484 Y96.724 E.00634
; LINE_WIDTH: 0.563027
G1 X86.263 Y96.707 E.00594
; LINE_WIDTH: 0.510607
G1 X86.042 Y96.689 E.00536
G1 X85.442 Y96.689 E.01451
G1 X85.443 Y97.345 E.01587
G1 X85.972 Y97.044 E.01473
; LINE_WIDTH: 0.529205
G1 X86.294 Y96.911 E.00874
; LINE_WIDTH: 0.57025
G1 X86.615 Y96.778 E.00945
; LINE_WIDTH: 0.604072
G1 X86.649 Y96.765 E.00105
; WIPE_START
G1 X86.615 Y96.778 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X89.659 Y96.685 Z2.64 F18000
G1 Z2.24
G1 E.4 F1800
; LINE_WIDTH: 0.506832
G1 F1500
M204 S6000
G1 X88.958 Y96.685 E.01683
; LINE_WIDTH: 0.520945
G1 X88.675 Y96.7 E.00699
; LINE_WIDTH: 0.54917
G1 X88.392 Y96.714 E.00739
; LINE_WIDTH: 0.579137
G1 X88.249 Y96.73 E.00398
; LINE_WIDTH: 0.572952
G1 X88.584 Y96.843 E.00965
; LINE_WIDTH: 0.511271
G1 X88.919 Y96.956 E.00857
G1 X89.655 Y97.324 E.01993
G1 X89.659 Y96.745 E.01402
M204 S10000
G1 X90.098 Y96.247 F18000
; LINE_WIDTH: 0.419992
G1 F1500
M204 S6000
G1 X85.002 Y96.251 E.10021
G1 X85.005 Y98.104 E.03644
G1 X85.11 Y98.162 E.00236
G1 X85.496 Y97.824 E.01009
G1 X86.225 Y97.409 E.01651
G1 X86.763 Y97.235 E.01113
G1 X87.358 Y97.151 E.01182
G1 X88.213 Y97.21 E.01685
G1 X88.796 Y97.376 E.01193
G1 X89.352 Y97.651 E.0122
G1 X89.751 Y97.956 E.00987
G1 X89.876 Y97.849 E.00324
G1 X90.095 Y97.871 E.00432
G1 X90.097 Y96.307 E.03077
; CHANGE_LAYER
; Z_HEIGHT: 2.36
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F1500
G1 X90.095 Y97.871 E-.29722
G1 X89.876 Y97.849 E-.04174
G1 X89.751 Y97.956 E-.03125
G1 X89.71 Y97.924 E-.00978
; WIPE_END
G1 E-.02 F1800
; layer num/total_layer_count: 19/49
; update layer progress
M73 L19
M991 S0 P18 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z2.64 I1.02 J.665 P1  F18000
G1 X94.431 Y90.682 Z2.64
G1 Z2.36
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X94.269 Y90.682 E.00342
G1 X94.269 Y90.22 E.00977
G1 X95.431 Y90.22 E.02458
G1 X95.431 Y90.682 E.00977
G1 X94.491 Y90.682 E.0199
; WIPE_START
M204 S6000
G1 X94.269 Y90.682 E-.04209
G1 X94.269 Y90.22 E-.08769
G1 X95.431 Y90.22 E-.22069
G1 X95.431 Y90.376 E-.02952
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X98.669 Y90.22 Z2.76 F18000
G1 Z2.36
G1 E.4 F1800
G1 F1500
M204 S500
G1 X99.831 Y90.22 E.02458
G1 X99.831 Y90.682 E.00977
G1 X98.669 Y90.682 E.02458
G1 X98.669 Y90.28 E.0085
; WIPE_START
M204 S6000
G1 X99.831 Y90.22 E-.22098
G1 X99.831 Y90.682 E-.08769
G1 X99.455 Y90.682 E-.07132
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X98.638 Y94.889 Z2.76 F18000
G1 Z2.36
G1 E.4 F1800
G1 F1500
M204 S500
G1 X99.407 Y94.12 E.02301
G1 X99.407 Y95.357 E.02619
G1 X98.169 Y95.357 E.02619
G1 X98.595 Y94.931 E.01276
M204 S10000
G1 X98.338 Y94.589 F18000
G1 F1500
M204 S500
G1 X99.831 Y93.096 E.04469
G1 X99.831 Y95.782 E.05685
G1 X97.145 Y95.782 E.05685
G1 X98.295 Y94.631 E.03444
; WIPE_START
M204 S6000
G1 X99.71 Y93.217 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X96.569 Y87.944 Z2.76 F18000
G1 Z2.36
G1 E.4 F1800
G1 F1500
M204 S500
G1 X97.531 Y87.944 E.02035
G1 X97.05 Y88.425 E.01439
G1 X96.612 Y87.987 E.01312
; WIPE_START
M204 S6000
G1 X97.531 Y87.944 E-.17484
G1 X97.05 Y88.425 E-.1292
G1 X96.767 Y88.143 E-.07596
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X94.693 Y94.12 Z2.76 F18000
G1 Z2.36
G1 E.4 F1800
G1 F1500
M204 S500
G1 X95.931 Y95.357 E.03704
G1 X94.693 Y95.357 E.02619
G1 X94.693 Y94.18 E.02492
; WIPE_START
M204 S6000
G1 X95.931 Y95.357 E-.32452
G1 X95.639 Y95.357 E-.05549
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X89.527 Y98.298 Z2.76 F18000
G1 Z2.36
G1 E.4 F1800
G1 F1500
M204 S500
G1 X89.316 Y98.119 E.00586
G1 X88.993 Y97.919 E.00804
G1 X88.648 Y97.759 E.00804
G1 X88.154 Y97.615 E.0109
G1 X87.778 Y97.564 E.00804
G1 X87.398 Y97.558 E.00804
G1 X86.872 Y97.63 E.01124
G1 X86.367 Y97.794 E.01123
G1 X86.027 Y97.964 E.00804
G1 X85.71 Y98.173 E.00804
G1 X85.316 Y98.528 E.01124
G1 X84.977 Y98.966 E.01172
G1 X84.794 Y99.331 E.00866
G1 X84.598 Y99.285 E.00426
G1 X84.593 Y95.842 E.07288
G1 X90.507 Y95.837 E.12519
G1 X90.502 Y99.285 E.07298
G1 X90.306 Y99.331 E.00426
G1 X90.143 Y99.004 E.00774
G1 X89.957 Y98.735 E.00692
G1 X89.709 Y98.452 E.00797
G1 X89.573 Y98.337 E.00377
M204 S10000
G1 X89.253 Y98.621 F18000
G1 F1500
M204 S500
G1 X89.411 Y98.755 E.00437
G1 X89.621 Y98.996 E.00679
G1 X89.777 Y99.22 E.00577
G1 X90.003 Y99.676 E.01076
G1 X90.13 Y100.133 E.01004
G1 X90.172 Y100.601 E.00995
G1 X90.13 Y101.069 E.00995
G1 X90.005 Y101.522 E.00995
G1 X89.805 Y101.937 E.00976
G1 X89.623 Y102.204 E.00683
G1 X89.411 Y102.447 E.00683
G1 X89.066 Y102.739 E.00955
G1 X88.794 Y102.907 E.00678
G1 X88.547 Y103.024 E.00577
G1 X88.061 Y103.173 E.01076
G1 X87.589 Y103.222 E.01004
G1 X87.121 Y103.187 E.00995
G1 X86.666 Y103.069 E.00995
G1 X86.248 Y102.875 E.00975
G1 X85.978 Y102.698 E.00683
G1 X85.732 Y102.489 E.00683
G1 X85.429 Y102.142 E.00975
G1 X85.193 Y101.747 E.00975
G1 X85.07 Y101.448 E.00684
G1 X84.984 Y101.137 E.00682
G1 X84.929 Y100.679 E.00975
G1 X84.957 Y100.219 E.00975
G1 X85.024 Y99.906 E.00678
G1 X85.11 Y99.647 E.00577
G1 X85.338 Y99.193 E.01076
G1 X85.628 Y98.818 E.01004
G1 X85.971 Y98.509 E.00975
G1 X86.24 Y98.332 E.00683
G1 X86.528 Y98.187 E.00683
G1 X86.966 Y98.045 E.00975
G1 X87.423 Y97.983 E.00975
G1 X87.746 Y97.988 E.00683
G1 X88.066 Y98.031 E.00683
G1 X88.499 Y98.158 E.00955
G1 X88.792 Y98.293 E.00683
G1 X89.066 Y98.463 E.00683
G1 X89.207 Y98.583 E.00392
M204 S250
G1 X88.988 Y98.934 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X89.123 Y99.047 E.00346
G1 X89.298 Y99.248 E.00525
G1 X89.423 Y99.429 E.00433
G1 X89.62 Y99.823 E.00865
G1 X89.725 Y100.206 E.00782
G1 X89.761 Y100.601 E.00779
G1 X89.725 Y100.996 E.00779
G1 X89.62 Y101.378 E.0078
G1 X89.449 Y101.732 E.00774
G1 X89.299 Y101.953 E.00526
G1 X89.123 Y102.155 E.00526
G1 X88.825 Y102.407 E.00767
G1 X88.598 Y102.547 E.00525
G1 X88.399 Y102.641 E.00433
G1 X87.979 Y102.77 E.00864
G1 X87.583 Y102.811 E.00783
G1 X87.188 Y102.782 E.00779
G1 X86.804 Y102.682 E.0078
G1 X86.447 Y102.517 E.00773
G1 X86.224 Y102.369 E.00526
G1 X86.02 Y102.197 E.00526
G1 X85.761 Y101.9 E.00774
G1 X85.56 Y101.563 E.00773
G1 X85.458 Y101.315 E.00527
G1 X85.387 Y101.057 E.00526
G1 X85.34 Y100.667 E.00773
G1 X85.364 Y100.274 E.00774
G1 X85.419 Y100.014 E.00525
G1 X85.489 Y99.805 E.00433
G1 X85.686 Y99.412 E.00864
G1 X85.929 Y99.097 E.00783
G1 X86.222 Y98.834 E.00774
G1 X86.445 Y98.687 E.00526
G1 X86.684 Y98.567 E.00526
G1 X87.058 Y98.445 E.00773
G1 X87.448 Y98.393 E.00774
G1 X87.715 Y98.397 E.00526
G1 X87.98 Y98.433 E.00526
G1 X88.355 Y98.542 E.00767
G1 X88.597 Y98.654 E.00526
G1 X88.825 Y98.795 E.00526
G1 X88.943 Y98.895 E.00303
; WIPE_START
M204 S6000
G1 X89.123 Y99.047 E-.04479
G1 X89.298 Y99.248 E-.0507
G1 X89.423 Y99.429 E-.04184
G1 X89.62 Y99.823 E-.08352
G1 X89.725 Y100.206 E-.07559
G1 X89.761 Y100.601 E-.07529
G1 X89.757 Y100.644 E-.00827
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X93.046 Y93.757 Z2.76 F18000
G1 X95.869 Y87.844 Z2.76
G1 Z2.36
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X95.869 Y87.52 E.00686
G1 X96.869 Y87.52 E.02117
G1 X96.869 Y77.382 E.21459
G1 X94.582 Y77.382 E.0484
G1 X94.514 Y77.05 E.00717
G1 X94.373 Y76.788 E.0063
G1 X94.162 Y76.578 E.0063
G1 X93.901 Y76.437 E.00629
G1 X93.636 Y76.382 E.00572
G1 X81.505 Y76.382 E.25677
G1 X81.247 Y76.419 E.00552
G1 X80.936 Y76.576 E.00737
G1 X80.69 Y76.836 E.00756
G1 X80.542 Y77.181 E.00795
G1 X80.531 Y94.473 E.36601
G1 X80.617 Y94.835 E.00788
G1 X80.788 Y95.085 E.00642
G1 X80.991 Y95.26 E.00567
G1 X81.255 Y95.384 E.00618
G1 X81.505 Y95.42 E.00534
G1 X94.269 Y95.41 E.27016
G1 X94.269 Y93.096 E.04898
G1 X96.955 Y95.782 E.08039
G1 X90.932 Y95.782 E.12749
G1 X90.924 Y100.801 E.10623
G1 X90.876 Y101.199 E.00848
G1 X90.782 Y101.588 E.00848
G1 X90.643 Y101.963 E.00847
G1 X90.456 Y102.328 E.00867
G1 X90.113 Y102.804 E.01242
G1 X89.767 Y103.15 E.01035
G1 X89.515 Y103.351 E.00684
G1 X89.19 Y103.557 E.00814
G1 X88.824 Y103.731 E.00857
G1 X88.368 Y103.878 E.01014
G1 X87.834 Y103.969 E.01146
G1 X87.25 Y103.967 E.01237
G1 X86.854 Y103.908 E.00848
G1 X86.468 Y103.803 E.00848
G1 X86.097 Y103.652 E.00847
G1 X85.75 Y103.461 E.00838
G1 X85.365 Y103.176 E.01014
G1 X84.986 Y102.802 E.01126
G1 X84.747 Y102.489 E.00834
G1 X84.543 Y102.144 E.00847
G1 X84.381 Y101.776 E.00852
G1 X84.224 Y101.203 E.01257
G1 X84.176 Y100.801 E.00858
G1 X84.168 Y95.783 E.10621
G1 X81.479 Y95.778 E.05691
G1 X81.223 Y95.741 E.00548
G1 X80.931 Y95.634 E.00659
G1 X80.792 Y95.554 E.00339
G1 X80.546 Y95.348 E.00678
G1 X80.342 Y95.065 E.00738
G1 X80.252 Y94.867 E.00462
G1 X80.207 Y94.719 E.00326
G1 X80.169 Y94.383 E.00716
G1 X80.169 Y77.419 E.35905
G1 X80.206 Y77.092 E.00697
G1 X80.284 Y76.855 E.00528
G1 X80.403 Y76.636 E.00528
G1 X80.488 Y76.521 E.00302
G1 X80.67 Y76.339 E.00547
G1 X80.785 Y76.254 E.00301
G1 X81.004 Y76.135 E.00528
G1 X81.241 Y76.057 E.00528
G1 X81.39 Y76.03 E.00321
G1 X93.565 Y76.021 E.25769
G1 X93.796 Y76.044 E.00491
G1 X93.946 Y76.079 E.00326
G1 X94.24 Y76.206 E.00678
G1 X94.374 Y76.294 E.00339
G1 X94.601 Y76.507 E.00659
G1 X94.96 Y77.02 E.01325
G1 X97.231 Y77.02 E.04807
G1 X97.231 Y87.52 E.22224
G1 X98.231 Y87.52 E.02117
G1 X98.231 Y87.844 E.00686
G1 X97.05 Y89.025 E.03534
G1 X95.912 Y87.887 E.03407
; WIPE_START
M204 S6000
G1 X95.869 Y87.52 E-.07014
G1 X96.869 Y87.52 E-.19
G1 X96.869 Y86.889 E-.11986
; WIPE_END
G1 E-.02 F1800
M204 S10000
M73 P55 R12
G1 X94.84 Y91.091 Z2.76 F18000
G1 Z2.36
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X94.84 Y93.088 E.03928
G1 X97.05 Y95.298 E.06147
G1 X99.26 Y93.088 E.06147
G1 X99.26 Y91.091 E.03928
G1 X98.26 Y91.091 E.01967
G1 X98.26 Y89.811 E.02518
G1 X100.24 Y89.811 E.03895
G1 X100.24 Y96.191 E.12549
G1 X91.34 Y96.191 E.17505
G1 X91.333 Y100.825 E.09115
G1 X91.28 Y101.271 E.00883
G1 X91.174 Y101.708 E.00883
G1 X91.018 Y102.129 E.00883
G1 X90.812 Y102.531 E.00889
G1 X90.695 Y102.715 E.0043
G1 X90.422 Y103.074 E.00886
G1 X90.041 Y103.455 E.0106
G1 X89.573 Y103.806 E.0115
G1 X89.382 Y103.918 E.00436
G1 X88.976 Y104.112 E.00886
G1 X88.466 Y104.276 E.01053
G1 X87.881 Y104.376 E.01167
G1 X87.665 Y104.389 E.00425
G1 X87.214 Y104.376 E.00889
G1 X86.769 Y104.309 E.00883
G1 X86.336 Y104.191 E.00883
G1 X85.92 Y104.022 E.00883
G1 X85.528 Y103.806 E.0088
G1 X85.098 Y103.488 E.01053
G1 X84.678 Y103.073 E.0116
G1 X84.407 Y102.718 E.00879
G1 X84.179 Y102.331 E.00883
G1 X83.997 Y101.92 E.00885
G1 X83.889 Y101.573 E.00714
G1 X83.82 Y101.273 E.00607
G1 X83.767 Y100.825 E.00886
G1 X83.76 Y96.191 E.09115
G1 X81.449 Y96.188 E.04545
G1 X81.134 Y96.141 E.00626
G1 X80.938 Y96.083 E.00403
G1 X80.747 Y96 E.00409
G1 X80.567 Y95.896 E.00409
G1 X80.4 Y95.772 E.0041
G1 X80.248 Y95.629 E.00409
G1 X80.115 Y95.471 E.00407
G1 X79.982 Y95.261 E.00489
G1 X79.868 Y95.011 E.00541
G1 X79.809 Y94.814 E.00405
G1 X79.772 Y94.609 E.00409
G1 X79.76 Y94.395 E.00422
G1 X79.76 Y77.407 E.33413
G1 X79.772 Y77.193 E.00422
G1 X79.808 Y76.991 E.00403
G1 X79.907 Y76.692 E.00619
G1 X80.057 Y76.415 E.00619
G1 X80.177 Y76.253 E.00398
G1 X80.402 Y76.028 E.00625
G1 X80.564 Y75.907 E.00397
G1 X80.841 Y75.758 E.00619
G1 X81.14 Y75.659 E.00619
G1 X81.342 Y75.623 E.00403
G1 X81.556 Y75.611 E.00422
G1 X93.584 Y75.612 E.23659
G1 X93.863 Y75.639 E.0055
G1 X94.063 Y75.686 E.00405
G1 X94.259 Y75.758 E.00409
G1 X94.445 Y75.851 E.00409
G1 X94.619 Y75.965 E.00409
G1 X94.778 Y76.099 E.00409
G1 X94.919 Y76.248 E.00403
G1 X95.173 Y76.611 E.00871
G1 X97.64 Y76.611 E.04853
G1 X97.64 Y87.111 E.20653
G1 X98.64 Y87.111 E.01967
G1 X98.64 Y88.014 E.01776
G1 X97.05 Y89.604 E.04423
G1 X95.46 Y88.014 E.04423
G1 X95.46 Y87.111 E.01776
G1 X96.46 Y87.111 E.01967
G1 X96.46 Y77.791 E.18332
G1 X94.16 Y77.791 E.04524
G1 X94.159 Y77.356 E.00855
G1 X94.125 Y77.191 E.0033
G1 X94.041 Y77.035 E.00349
G1 X93.915 Y76.91 E.00349
G1 X93.76 Y76.826 E.00348
G1 X93.595 Y76.792 E.00331
G1 X81.535 Y76.791 E.23721
G1 X81.371 Y76.815 E.00325
G1 X81.184 Y76.909 E.00413
G1 X81.038 Y77.064 E.00419
G1 X80.951 Y77.265 E.00431
G1 X80.94 Y94.425 E.33752
G1 X80.997 Y94.667 E.00488
G1 X81.095 Y94.81 E.00342
G1 X81.215 Y94.913 E.00311
G1 X81.374 Y94.987 E.00345
G1 X81.535 Y95.011 E.00319
G1 X93.86 Y95.001 E.24243
G1 X93.86 Y89.811 E.10209
G1 X95.84 Y89.811 E.03895
G1 X95.84 Y91.091 E.02518
G1 X94.9 Y91.091 E.01849
; WIPE_START
M204 S6000
G1 X94.84 Y93.088 E-.3796
G1 X94.842 Y93.089 E-.0004
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




G1 X94.35 Y92.887
G1 Z2.36
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.596522
G1 F1500
M204 S6000
G1 X94.35 Y90.886 E.05697
; WIPE_START
G1 X94.35 Y92.886 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X95.077 Y94.958 Z2.76 F18000
G1 Z2.36
G1 E.4 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.365752
G1 F1500
M204 S6000
G1 X95.013 Y94.995 E.00125
G1 X95.062 Y95.023 E.00095
; WIPE_START
G1 X95.013 Y94.995 E-.16436
G1 X95.077 Y94.958 E-.21564
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X99.065 Y94.958 Z2.76 F18000
G1 Z2.36
G1 E.4 F1800
G1 F1500
M204 S6000
G1 X99.002 Y94.995 E.00125
G1 X99.05 Y95.023 E.00095
; WIPE_START
G1 X99.002 Y94.995 E-.16436
G1 X99.065 Y94.958 E-.21564
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X99.75 Y92.887 Z2.76 F18000
G1 Z2.36
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.596522
G1 F1500
M204 S6000
G1 X99.75 Y90.886 E.05697
; WIPE_START
G1 X99.75 Y92.886 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X93.261 Y96.904 Z2.76 F18000
G1 X90.291 Y98.743 Z2.76
G1 Z2.36
G1 E.4 F1800
; LINE_WIDTH: 0.10366
G1 F1500
M204 S6000
G1 X90.097 Y98.535 E.0011
; WIPE_START
G1 X90.291 Y98.743 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X90.451 Y99.515 Z2.76 F18000
G1 Z2.36
G1 E.4 F1800
; LINE_WIDTH: 0.467402
G1 F1500
M204 S6000
G1 X90.487 Y99.78 E.00588
; LINE_WIDTH: 0.426668
G1 X90.523 Y100.044 E.00534
; LINE_WIDTH: 0.403221
G1 X90.526 Y100.078 E.00064
; LINE_WIDTH: 0.376944
G1 X90.548 Y100.586 E.00891
; LINE_WIDTH: 0.360155
G1 X90.503 Y101.132 E.00913
G1 X90.415 Y101.476 E.00593
G1 X90.293 Y101.807 E.00588
G1 X90.123 Y102.135 E.00617
G1 X89.927 Y102.427 E.00586
G1 X89.682 Y102.705 E.00619
G1 X89.513 Y102.862 E.00384
G1 X89.151 Y103.135 E.00757
G1 X88.673 Y103.381 E.00897
G1 X88.12 Y103.542 E.00959
G1 X87.654 Y103.598 E.00784
G1 X87.284 Y103.584 E.00617
G1 X86.933 Y103.533 E.00592
G1 X86.59 Y103.442 E.00593
G1 X86.053 Y103.198 E.00983
G1 X85.613 Y102.886 E.00901
G1 X85.275 Y102.548 E.00798
G1 X85.133 Y102.375 E.00373
G1 X84.85 Y101.904 E.00917
G1 X84.717 Y101.579 E.00587
G1 X84.618 Y101.221 E.00618
G1 X84.553 Y100.705 E.00868
G1 X84.567 Y100.18 E.00877
; LINE_WIDTH: 0.404356
G1 X84.587 Y99.979 E.00382
; LINE_WIDTH: 0.443949
G1 X84.605 Y99.805 E.00365
; LINE_WIDTH: 0.474533
G1 X84.651 Y99.516 E.00655
M204 S10000
G1 X84.828 Y98.783 F18000
; LINE_WIDTH: 0.0935164
G1 F1500
M204 S6000
G1 X84.85 Y98.717 E.00023
G1 X84.973 Y98.585 E.00061
; WIPE_START
G1 X84.85 Y98.717 E-.2744
G1 X84.828 Y98.783 E-.1056
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X86.705 Y96.742 Z2.76 F18000
G1 Z2.36
G1 E.4 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.597362
G1 F1500
M204 S6000
G1 X87.001 Y96.722 E.00848
; LINE_WIDTH: 0.563932
G1 X87.298 Y96.702 E.00798
G1 X88.189 Y96.728 E.02395
; WIPE_START
G1 X87.298 Y96.702 E-.28501
G1 X87.001 Y96.722 E-.09499
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X86.705 Y96.742 Z2.76 F18000
G1 Z2.36
G1 E.4 F1800
; LINE_WIDTH: 0.599367
G1 F1500
M204 S6000
G1 X86.484 Y96.725 E.00634
; LINE_WIDTH: 0.563317
G1 X86.263 Y96.707 E.00595
; LINE_WIDTH: 0.511156
G1 X86.042 Y96.689 E.00537
G1 X85.442 Y96.689 E.01452
G1 X85.443 Y97.349 E.01598
G1 X85.968 Y97.046 E.01469
; LINE_WIDTH: 0.529662
G1 X86.292 Y96.912 E.0088
; LINE_WIDTH: 0.570502
G1 X86.615 Y96.778 E.00951
; LINE_WIDTH: 0.604157
G1 X86.649 Y96.765 E.00105
; WIPE_START
G1 X86.615 Y96.778 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X89.656 Y96.688 Z2.76 F18000
G1 Z2.36
G1 E.4 F1800
; LINE_WIDTH: 0.512372
G1 F1500
M204 S6000
G1 X88.939 Y96.688 E.01741
; LINE_WIDTH: 0.5256
G1 X88.666 Y96.702 E.00682
; LINE_WIDTH: 0.552055
G1 X88.392 Y96.715 E.00719
; LINE_WIDTH: 0.580147
G1 X88.249 Y96.73 E.00398
; LINE_WIDTH: 0.574352
G1 X88.576 Y96.839 E.00942
; LINE_WIDTH: 0.516361
G1 X88.902 Y96.948 E.00842
G1 X89.655 Y97.338 E.02076
G1 X89.656 Y96.748 E.01445
M204 S10000
G1 X90.098 Y96.247 F18000
; LINE_WIDTH: 0.419992
G1 F1500
M204 S6000
G1 X85.002 Y96.251 E.10021
G1 X85.005 Y98.101 E.03638
G1 X85.115 Y98.158 E.00243
G1 X85.482 Y97.834 E.00963
G1 X86.188 Y97.426 E.01604
G1 X86.763 Y97.235 E.01193
G1 X87.358 Y97.151 E.01182
G1 X88.213 Y97.21 E.01685
G1 X88.778 Y97.371 E.01156
G1 X89.535 Y97.773 E.01684
G1 X89.936 Y98.126 E.01052
G1 X90.03 Y98.041 E.00248
G1 X90.095 Y98.047 E.00128
G1 X90.097 Y96.307 E.03423
; CHANGE_LAYER
; Z_HEIGHT: 2.48
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F1500
G1 X90.095 Y98.047 E-.33065
G1 X90.03 Y98.041 E-.0124
G1 X89.936 Y98.126 E-.02395
G1 X89.885 Y98.081 E-.01299
; WIPE_END
G1 E-.02 F1800
; layer num/total_layer_count: 20/49
; update layer progress
M73 L20
M991 S0 P19 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z2.76 I1.037 J.637 P1  F18000
G1 X94.431 Y90.682 Z2.76
G1 Z2.48
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X94.269 Y90.682 E.00342
G1 X94.269 Y90.22 E.00977
G1 X95.431 Y90.22 E.02458
G1 X95.431 Y90.682 E.00977
G1 X94.491 Y90.682 E.0199
; WIPE_START
M204 S6000
G1 X94.269 Y90.682 E-.04209
G1 X94.269 Y90.22 E-.08769
G1 X95.431 Y90.22 E-.22069
G1 X95.431 Y90.376 E-.02952
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X98.669 Y90.22 Z2.88 F18000
G1 Z2.48
G1 E.4 F1800
G1 F1500
M204 S500
G1 X99.831 Y90.22 E.02458
G1 X99.831 Y90.682 E.00977
G1 X98.669 Y90.682 E.02458
G1 X98.669 Y90.28 E.0085
; WIPE_START
M204 S6000
G1 X99.831 Y90.22 E-.22098
G1 X99.831 Y90.682 E-.08769
G1 X99.455 Y90.682 E-.07132
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X98.638 Y94.889 Z2.88 F18000
G1 Z2.48
G1 E.4 F1800
G1 F1500
M204 S500
G1 X99.407 Y94.12 E.02301
G1 X99.407 Y95.357 E.02619
G1 X98.169 Y95.357 E.02619
G1 X98.595 Y94.931 E.01276
M204 S10000
G1 X98.338 Y94.589 F18000
G1 F1500
M204 S500
G1 X99.831 Y93.096 E.04469
G1 X99.831 Y95.782 E.05685
G1 X97.145 Y95.782 E.05685
G1 X98.295 Y94.631 E.03444
; WIPE_START
M204 S6000
G1 X99.71 Y93.217 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X96.569 Y87.944 Z2.88 F18000
G1 Z2.48
G1 E.4 F1800
G1 F1500
M204 S500
G1 X97.531 Y87.944 E.02035
G1 X97.05 Y88.425 E.01439
G1 X96.612 Y87.987 E.01312
; WIPE_START
M204 S6000
G1 X97.531 Y87.944 E-.17484
G1 X97.05 Y88.425 E-.1292
G1 X96.767 Y88.143 E-.07596
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X94.693 Y94.12 Z2.88 F18000
G1 Z2.48
G1 E.4 F1800
G1 F1500
M204 S500
G1 X95.931 Y95.357 E.03704
G1 X94.693 Y95.357 E.02619
G1 X94.693 Y94.18 E.02492
; WIPE_START
M204 S6000
G1 X95.931 Y95.357 E-.32452
M73 P56 R12
G1 X95.639 Y95.357 E-.05549
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X89.522 Y98.293 Z2.88 F18000
G1 Z2.48
G1 E.4 F1800
G1 F1500
M204 S500
G1 X89.316 Y98.119 E.0057
G1 X88.993 Y97.919 E.00804
G1 X88.662 Y97.766 E.00771
G1 X88.316 Y97.654 E.00771
G1 X87.943 Y97.58 E.00804
G1 X87.413 Y97.556 E.01123
G1 X86.887 Y97.628 E.01124
G1 X86.523 Y97.734 E.00804
G1 X86.178 Y97.881 E.00794
G1 X85.771 Y98.127 E.01006
G1 X85.32 Y98.522 E.01269
G1 X84.977 Y98.966 E.01188
G1 X84.794 Y99.332 E.00865
G1 X84.598 Y99.286 E.00426
G1 X84.593 Y95.842 E.07289
G1 X90.507 Y95.837 E.12519
G1 X90.502 Y99.262 E.07249
G1 X90.301 Y99.305 E.00436
G1 X90.058 Y98.872 E.0105
G1 X89.721 Y98.462 E.01124
G1 X89.567 Y98.332 E.00426
M204 S10000
G1 X89.247 Y98.617 F18000
G1 F1500
M204 S500
G1 X89.418 Y98.761 E.00473
G1 X89.71 Y99.117 E.00975
G1 X89.876 Y99.394 E.00683
G1 X90.007 Y99.689 E.00683
G1 X90.13 Y100.133 E.00975
G1 X90.172 Y100.601 E.00995
G1 X90.129 Y101.073 E.01004
G1 X89.981 Y101.583 E.01123
G1 X89.72 Y102.073 E.01176
G1 X89.418 Y102.441 E.01008
G1 X89.054 Y102.749 E.01008
G1 X88.568 Y103.017 E.01175
G1 X88.061 Y103.173 E.01123
G1 X87.598 Y103.221 E.00985
G1 X87.276 Y103.207 E.00683
G1 X86.958 Y103.154 E.00684
G1 X86.52 Y103.012 E.00975
G1 X86.106 Y102.789 E.00995
G1 X85.738 Y102.496 E.00995
G1 X85.429 Y102.142 E.00995
G1 X85.193 Y101.746 E.00975
G1 X85.07 Y101.448 E.00684
G1 X84.984 Y101.137 E.00683
G1 X84.929 Y100.679 E.00975
G1 X84.958 Y100.204 E.01008
G1 X85.1 Y99.667 E.01175
G1 X85.338 Y99.193 E.01123
G1 X85.631 Y98.814 E.01013
G1 X86.023 Y98.471 E.01103
G1 X86.372 Y98.26 E.00864
G1 X86.666 Y98.134 E.00677
G1 X86.976 Y98.044 E.00683
G1 X87.432 Y97.982 E.00975
G1 X87.893 Y98.002 E.00975
G1 X88.209 Y98.065 E.00683
G1 X88.507 Y98.162 E.00663
G1 X88.792 Y98.293 E.00664
G1 X89.066 Y98.463 E.00683
G1 X89.201 Y98.578 E.00375
M204 S250
G1 X88.983 Y98.929 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X89.125 Y99.049 E.00367
G1 X89.375 Y99.353 E.00773
G1 X89.512 Y99.583 E.00526
G1 X89.621 Y99.827 E.00526
G1 X89.725 Y100.206 E.00774
G1 X89.761 Y100.601 E.00779
G1 X89.725 Y100.997 E.00782
G1 X89.6 Y101.428 E.00882
G1 X89.378 Y101.845 E.00929
G1 X89.125 Y102.152 E.00784
G1 X88.821 Y102.41 E.00784
G1 X88.407 Y102.638 E.00928
G1 X87.979 Y102.77 E.00882
G1 X87.586 Y102.811 E.00777
G1 X87.319 Y102.799 E.00526
G1 X87.055 Y102.755 E.00527
G1 X86.681 Y102.634 E.00773
G1 X86.332 Y102.446 E.0078
G1 X86.022 Y102.199 E.00779
G1 X85.761 Y101.9 E.0078
G1 X85.56 Y101.563 E.00773
G1 X85.458 Y101.315 E.00526
G1 X85.387 Y101.057 E.00526
G1 X85.34 Y100.667 E.00773
G1 X85.364 Y100.269 E.00784
G1 X85.485 Y99.813 E.00929
G1 X85.686 Y99.412 E.00882
G1 X85.93 Y99.096 E.00785
G1 X86.265 Y98.803 E.00876
G1 X86.559 Y98.625 E.00676
G1 X86.804 Y98.52 E.00524
G1 X87.061 Y98.445 E.00526
G1 X87.451 Y98.392 E.00774
G1 X87.844 Y98.41 E.00773
G1 X88.106 Y98.462 E.00526
G1 X88.357 Y98.543 E.0052
G1 X88.597 Y98.654 E.0052
G1 X88.825 Y98.795 E.00526
G1 X88.937 Y98.89 E.00289
; WIPE_START
M204 S6000
G1 X89.125 Y99.049 E-.04684
G1 X89.375 Y99.353 E-.07471
G1 X89.512 Y99.583 E-.05083
G1 X89.621 Y99.827 E-.05083
G1 X89.725 Y100.206 E-.07473
G1 X89.761 Y100.601 E-.07529
G1 X89.758 Y100.636 E-.00677
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X93.048 Y93.75 Z2.88 F18000
G1 X95.869 Y87.844 Z2.88
G1 Z2.48
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X95.869 Y87.52 E.00686
G1 X96.869 Y87.52 E.02117
G1 X96.869 Y77.382 E.21459
G1 X94.583 Y77.382 E.0484
G1 X94.514 Y77.05 E.00717
G1 X94.373 Y76.788 E.00629
G1 X94.162 Y76.578 E.0063
G1 X93.901 Y76.437 E.00629
G1 X93.636 Y76.382 E.00571
G1 X81.496 Y76.382 E.25696
G1 X81.203 Y76.433 E.00629
G1 X80.916 Y76.593 E.00695
G1 X80.689 Y76.839 E.00708
G1 X80.542 Y77.18 E.00788
G1 X80.531 Y94.477 E.3661
G1 X80.625 Y94.853 E.00821
G1 X80.801 Y95.099 E.00641
G1 X80.995 Y95.262 E.00535
G1 X81.256 Y95.384 E.0061
G1 X81.505 Y95.42 E.00533
G1 X94.269 Y95.41 E.27016
G1 X94.269 Y93.096 E.04898
G1 X96.955 Y95.782 E.08039
G1 X90.932 Y95.782 E.12749
G1 X90.924 Y100.801 E.10623
G1 X90.876 Y101.199 E.00848
G1 X90.782 Y101.588 E.00848
G1 X90.643 Y101.963 E.00847
G1 X90.463 Y102.314 E.00834
G1 X90.159 Y102.745 E.01117
G1 X89.828 Y103.097 E.01024
G1 X89.52 Y103.347 E.00838
G1 X89.174 Y103.566 E.00867
G1 X88.829 Y103.73 E.00809
G1 X88.447 Y103.859 E.00853
G1 X87.928 Y103.957 E.01117
G1 X87.443 Y103.979 E.01029
G1 X86.858 Y103.909 E.01247
G1 X86.468 Y103.803 E.00856
G1 X86.088 Y103.649 E.00867
G1 X85.58 Y103.347 E.01251
G1 X85.269 Y103.095 E.00848
G1 X84.99 Y102.807 E.00848
G1 X84.747 Y102.489 E.00848
G1 X84.543 Y102.144 E.00847
G1 X84.384 Y101.783 E.00834
G1 X84.241 Y101.276 E.01117
G1 X84.176 Y100.796 E.01025
G1 X84.168 Y95.783 E.10611
G1 X81.479 Y95.778 E.05691
G1 X81.223 Y95.741 E.00548
G1 X80.931 Y95.634 E.00659
G1 X80.792 Y95.554 E.0034
G1 X80.546 Y95.348 E.00678
G1 X80.341 Y95.064 E.00742
G1 X80.252 Y94.867 E.00458
G1 X80.207 Y94.719 E.00326
G1 X80.169 Y94.383 E.00716
G1 X80.169 Y77.419 E.35906
G1 X80.206 Y77.092 E.00697
G1 X80.284 Y76.855 E.00528
G1 X80.398 Y76.643 E.00509
G1 X80.553 Y76.448 E.00528
G1 X80.66 Y76.347 E.00311
G1 X80.818 Y76.233 E.00414
G1 X81.004 Y76.135 E.00444
G1 X81.203 Y76.067 E.00444
G1 X81.394 Y76.03 E.00414
G1 X93.567 Y76.021 E.25764
G1 X93.796 Y76.044 E.00486
G1 X93.946 Y76.079 E.00327
G1 X94.096 Y76.134 E.0034
G1 X94.366 Y76.289 E.00659
G1 X94.559 Y76.461 E.00547
G1 X94.657 Y76.577 E.0032
G1 X94.948 Y77.02 E.01122
G1 X97.231 Y77.02 E.04831
G1 X97.231 Y87.52 E.22224
G1 X98.231 Y87.52 E.02117
G1 X98.231 Y87.844 E.00686
G1 X97.05 Y89.025 E.03534
G1 X95.912 Y87.887 E.03407
; WIPE_START
M204 S6000
G1 X95.869 Y87.52 E-.07014
G1 X96.869 Y87.52 E-.19
G1 X96.869 Y86.889 E-.11986
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X94.84 Y91.091 Z2.88 F18000
G1 Z2.48
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X94.84 Y93.088 E.03928
G1 X97.05 Y95.298 E.06147
G1 X99.26 Y93.088 E.06147
G1 X99.26 Y91.091 E.03928
G1 X98.26 Y91.091 E.01967
G1 X98.26 Y89.811 E.02518
G1 X100.24 Y89.811 E.03895
G1 X100.24 Y96.191 E.12549
G1 X91.34 Y96.191 E.17505
G1 X91.333 Y100.825 E.09115
G1 X91.28 Y101.271 E.00883
G1 X91.174 Y101.708 E.00883
G1 X91.018 Y102.128 E.00883
G1 X90.814 Y102.526 E.00879
G1 X90.477 Y103.005 E.01151
G1 X90.107 Y103.398 E.01063
G1 X89.759 Y103.68 E.0088
G1 X89.377 Y103.921 E.00889
G1 X89.18 Y104.022 E.00435
G1 X88.977 Y104.112 E.00436
G1 X88.551 Y104.256 E.00885
G1 X87.976 Y104.365 E.01151
G1 X87.435 Y104.389 E.01064
G1 X87.08 Y104.36 E.00702
G1 X86.771 Y104.31 E.00616
G1 X86.336 Y104.191 E.00886
G1 X85.917 Y104.021 E.00889
G1 X85.723 Y103.921 E.0043
G1 X85.341 Y103.68 E.00889
G1 X84.992 Y103.397 E.00883
G1 X84.679 Y103.075 E.00883
G1 X84.407 Y102.718 E.00883
G1 X84.179 Y102.331 E.00883
G1 X83.998 Y101.922 E.00879
G1 X83.839 Y101.359 E.01151
G1 X83.767 Y100.824 E.01063
G1 X83.76 Y96.191 E.09111
G1 X81.449 Y96.188 E.04545
G1 X81.134 Y96.141 E.00626
G1 X80.938 Y96.083 E.00403
G1 X80.747 Y96 E.00409
G1 X80.567 Y95.896 E.00409
G1 X80.4 Y95.772 E.0041
G1 X80.248 Y95.629 E.00409
G1 X80.115 Y95.471 E.00406
G1 X79.981 Y95.259 E.00493
G1 X79.868 Y95.011 E.00537
G1 X79.809 Y94.814 E.00405
G1 X79.772 Y94.609 E.00409
G1 X79.76 Y94.395 E.00422
G1 X79.76 Y77.407 E.33413
G1 X79.772 Y77.193 E.00422
G1 X79.808 Y76.991 E.00403
G1 X79.907 Y76.692 E.0062
G1 X80.055 Y76.418 E.00613
G1 X80.25 Y76.171 E.00619
G1 X80.398 Y76.031 E.004
G1 X80.602 Y75.884 E.00494
G1 X80.841 Y75.758 E.00532
G1 X81.097 Y75.67 E.00532
G1 X81.344 Y75.623 E.00493
G1 X81.556 Y75.611 E.00418
G1 X93.587 Y75.612 E.23663
G1 X93.863 Y75.639 E.00545
G1 X94.063 Y75.686 E.00406
G1 X94.259 Y75.758 E.00409
G1 X94.445 Y75.851 E.00409
G1 X94.616 Y75.964 E.00404
G1 X94.854 Y76.175 E.00625
G1 X94.986 Y76.332 E.00403
G1 X95.169 Y76.611 E.00656
G1 X97.64 Y76.611 E.04861
G1 X97.64 Y87.111 E.20653
G1 X98.64 Y87.111 E.01967
G1 X98.64 Y88.014 E.01776
G1 X97.05 Y89.604 E.04423
G1 X95.46 Y88.014 E.04423
G1 X95.46 Y87.111 E.01776
G1 X96.46 Y87.111 E.01967
G1 X96.46 Y77.791 E.18332
G1 X94.16 Y77.791 E.04524
G1 X94.159 Y77.356 E.00856
G1 X94.125 Y77.191 E.0033
G1 X94.041 Y77.035 E.00349
G1 X93.915 Y76.91 E.0035
G1 X93.759 Y76.826 E.00349
G1 X93.595 Y76.792 E.00331
G1 X81.532 Y76.791 E.23727
G1 X81.342 Y76.824 E.00379
G1 X81.172 Y76.919 E.00382
G1 X81.037 Y77.065 E.00392
G1 X80.951 Y77.265 E.00429
G1 X80.94 Y94.427 E.33755
G1 X81.003 Y94.678 E.0051
G1 X81.104 Y94.819 E.00341
G1 X81.216 Y94.914 E.00289
G1 X81.375 Y94.987 E.00343
G1 X81.535 Y95.011 E.00319
G1 X93.86 Y95.001 E.24242
G1 X93.86 Y89.811 E.10209
G1 X95.84 Y89.811 E.03895
G1 X95.84 Y91.091 E.02518
G1 X94.9 Y91.091 E.01849
; WIPE_START
M204 S6000
G1 X94.84 Y93.088 E-.3796
G1 X94.842 Y93.089 E-.0004
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




G1 X94.35 Y92.887
G1 Z2.48
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.596522
G1 F1500
M204 S6000
G1 X94.35 Y90.886 E.05697
; WIPE_START
G1 X94.35 Y92.886 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X95.077 Y94.958 Z2.88 F18000
G1 Z2.48
G1 E.4 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.365752
G1 F1500
M204 S6000
G1 X95.013 Y94.995 E.00125
G1 X95.062 Y95.023 E.00095
; WIPE_START
G1 X95.013 Y94.995 E-.16436
G1 X95.077 Y94.958 E-.21564
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X99.065 Y94.958 Z2.88 F18000
G1 Z2.48
G1 E.4 F1800
G1 F1500
M204 S6000
G1 X99.002 Y94.995 E.00125
G1 X99.05 Y95.023 E.00095
; WIPE_START
G1 X99.002 Y94.995 E-.16436
G1 X99.065 Y94.958 E-.21564
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X99.75 Y92.887 Z2.88 F18000
G1 Z2.48
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.596522
G1 F1500
M204 S6000
G1 X99.75 Y90.886 E.05697
; WIPE_START
G1 X99.75 Y92.886 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X93.26 Y96.903 Z2.88 F18000
G1 X90.291 Y98.741 Z2.88
G1 Z2.48
G1 E.4 F1800
; LINE_WIDTH: 0.10232
G1 F1500
M204 S6000
M73 P57 R12
G1 X90.066 Y98.508 E.00124
; WIPE_START
G1 X90.291 Y98.741 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X90.443 Y99.492 Z2.88 F18000
G1 Z2.48
G1 E.4 F1800
; LINE_WIDTH: 0.476279
G1 F1500
M204 S6000
G1 X90.482 Y99.766 E.00623
; LINE_WIDTH: 0.430341
G1 X90.522 Y100.04 E.0056
; LINE_WIDTH: 0.403767
G1 X90.526 Y100.078 E.00071
; LINE_WIDTH: 0.376944
G1 X90.548 Y100.586 E.00891
; LINE_WIDTH: 0.360635
G1 X90.504 Y101.132 E.00914
G1 X90.324 Y101.74 E.0106
G1 X90.04 Y102.267 E.01
G1 X89.674 Y102.714 E.00964
G1 X89.282 Y103.05 E.00863
G1 X88.73 Y103.355 E.01054
G1 X88.347 Y103.487 E.00677
G1 X88.121 Y103.541 E.00389
G1 X87.884 Y103.576 E.00399
G1 X87.453 Y103.597 E.00721
G1 X86.88 Y103.524 E.00965
G1 X86.591 Y103.438 E.00504
G1 X86.253 Y103.302 E.00609
G1 X85.801 Y103.035 E.00877
G1 X85.488 Y102.779 E.00675
G1 X85.281 Y102.556 E.00508
G1 X85.116 Y102.351 E.0044
G1 X84.883 Y101.97 E.00747
G1 X84.712 Y101.56 E.00742
G1 X84.611 Y101.199 E.00626
G1 X84.557 Y100.77 E.00722
G1 X84.57 Y100.123 E.01081
; LINE_WIDTH: 0.416723
G1 X84.61 Y99.819 E.00597
; LINE_WIDTH: 0.465999
G1 X84.649 Y99.516 E.00673
M204 S10000
G1 X84.828 Y98.783 F18000
; LINE_WIDTH: 0.0967141
G1 F1500
M204 S6000
G1 X84.853 Y98.708 E.00028
G1 X84.992 Y98.56 E.00072
; WIPE_START
G1 X84.853 Y98.708 E-.27298
G1 X84.828 Y98.783 E-.10702
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X86.724 Y96.741 Z2.88 F18000
G1 Z2.48
G1 E.4 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.594822
G1 F1500
M204 S6000
G1 X87.02 Y96.721 E.00844
; LINE_WIDTH: 0.549339
G1 X87.317 Y96.701 E.00777
G1 X88.076 Y96.716 E.01985
; WIPE_START
G1 X87.317 Y96.701 E-.27314
G1 X87.02 Y96.721 E-.10686
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X86.724 Y96.741 Z2.88 F18000
G1 Z2.48
G1 E.4 F1800
; LINE_WIDTH: 0.595882
G1 F1500
M204 S6000
G1 X86.414 Y96.722 E.00881
; LINE_WIDTH: 0.557942
G1 X86.105 Y96.704 E.00822
; LINE_WIDTH: 0.504263
G1 X85.438 Y96.685 E.01594
G1 X85.439 Y97.342 E.01568
G1 X85.868 Y97.097 E.01179
; LINE_WIDTH: 0.521042
G1 X86.242 Y96.942 E.01001
; LINE_WIDTH: 0.561062
G1 X86.617 Y96.787 E.01082
; LINE_WIDTH: 0.597962
G1 X86.668 Y96.765 E.00161
; WIPE_START
G1 X86.617 Y96.787 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X89.657 Y96.687 Z2.88 F18000
G1 Z2.48
G1 E.4 F1800
; LINE_WIDTH: 0.512082
G1 F1500
M204 S6000
G1 X88.933 Y96.688 E.01756
; LINE_WIDTH: 0.5281
G1 X88.535 Y96.704 E.00999
; LINE_WIDTH: 0.549456
G1 X88.136 Y96.721 E.01042
G1 X88.9 Y96.951 E.02084
; LINE_WIDTH: 0.512082
G1 X89.656 Y97.338 E.0206
G1 X89.656 Y96.747 E.01433
M204 S10000
G1 X90.098 Y96.247 F18000
; LINE_WIDTH: 0.419992
G1 F1500
M204 S6000
G1 X85.002 Y96.251 E.10021
G1 X85.005 Y98.072 E.03582
G1 X85.083 Y98.084 E.00154
G1 X85.139 Y98.137 E.00153
G1 X85.516 Y97.807 E.00985
G1 X85.979 Y97.524 E.01068
G1 X86.777 Y97.234 E.0167
G1 X87.377 Y97.148 E.01193
G1 X87.978 Y97.172 E.01181
G1 X88.789 Y97.377 E.01647
G1 X89.535 Y97.773 E.0166
G1 X89.906 Y98.093 E.00963
G1 X90.005 Y98.004 E.00261
G1 X90.095 Y98.016 E.00178
G1 X90.097 Y96.307 E.03361
; CHANGE_LAYER
; Z_HEIGHT: 2.6
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F1500
G1 X90.095 Y98.016 E-.3247
G1 X90.005 Y98.004 E-.01724
G1 X89.906 Y98.093 E-.0252
G1 X89.855 Y98.049 E-.01286
; WIPE_END
G1 E-.02 F1800
; layer num/total_layer_count: 21/49
; update layer progress
M73 L21
M991 S0 P20 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z2.88 I1.034 J.642 P1  F18000
G1 X94.431 Y90.682 Z2.88
G1 Z2.6
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X94.269 Y90.682 E.00342
G1 X94.269 Y90.22 E.00977
G1 X95.431 Y90.22 E.02458
G1 X95.431 Y90.682 E.00977
G1 X94.491 Y90.682 E.0199
; WIPE_START
M204 S6000
G1 X94.269 Y90.682 E-.04209
G1 X94.269 Y90.22 E-.08769
G1 X95.431 Y90.22 E-.22069
G1 X95.431 Y90.376 E-.02952
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X98.669 Y90.22 Z3 F18000
G1 Z2.6
G1 E.4 F1800
G1 F1500
M204 S500
G1 X99.831 Y90.22 E.02458
G1 X99.831 Y90.682 E.00977
G1 X98.669 Y90.682 E.02458
G1 X98.669 Y90.28 E.0085
; WIPE_START
M204 S6000
G1 X99.831 Y90.22 E-.22098
G1 X99.831 Y90.682 E-.08769
G1 X99.455 Y90.682 E-.07132
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X98.638 Y94.889 Z3 F18000
G1 Z2.6
G1 E.4 F1800
G1 F1500
M204 S500
G1 X99.407 Y94.12 E.02301
G1 X99.407 Y95.357 E.02619
G1 X98.169 Y95.357 E.02619
G1 X98.595 Y94.931 E.01276
M204 S10000
G1 X98.338 Y94.589 F18000
G1 F1500
M204 S500
G1 X99.831 Y93.096 E.04469
G1 X99.831 Y95.782 E.05685
G1 X97.145 Y95.782 E.05685
G1 X98.295 Y94.631 E.03444
; WIPE_START
M204 S6000
G1 X99.71 Y93.217 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X96.569 Y87.944 Z3 F18000
G1 Z2.6
G1 E.4 F1800
G1 F1500
M204 S500
G1 X97.531 Y87.944 E.02035
G1 X97.05 Y88.425 E.01439
G1 X96.612 Y87.987 E.01312
; WIPE_START
M204 S6000
G1 X97.531 Y87.944 E-.17484
G1 X97.05 Y88.425 E-.1292
G1 X96.767 Y88.143 E-.07596
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X94.693 Y94.12 Z3 F18000
G1 Z2.6
G1 E.4 F1800
G1 F1500
M204 S500
G1 X95.931 Y95.357 E.03704
G1 X94.693 Y95.357 E.02619
G1 X94.693 Y94.18 E.02492
; WIPE_START
M204 S6000
G1 X95.931 Y95.357 E-.32452
G1 X95.639 Y95.357 E-.05549
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X89.476 Y98.251 Z3 F18000
G1 Z2.6
G1 E.4 F1800
G1 F1500
M204 S500
G1 X89.152 Y98.008 E.00856
G1 X88.677 Y97.771 E.01123
G1 X88.316 Y97.654 E.00804
G1 X87.943 Y97.58 E.00805
G1 X87.413 Y97.556 E.01123
G1 X86.887 Y97.628 E.01124
G1 X86.523 Y97.734 E.00804
G1 X86.178 Y97.881 E.00793
G1 X85.774 Y98.126 E.01
G1 X85.332 Y98.511 E.01241
G1 X85.086 Y98.811 E.0082
G1 X84.882 Y99.131 E.00805
G1 X84.8 Y99.316 E.00428
G1 X84.598 Y99.273 E.00436
G1 X84.593 Y95.842 E.07262
G1 X90.507 Y95.837 E.12517
G1 X90.507 Y99.269 E.07264
G1 X90.301 Y99.31 E.00443
G1 X90.252 Y99.19 E.00274
G1 X89.921 Y98.687 E.01274
G1 X89.585 Y98.333 E.01033
G1 X89.524 Y98.287 E.00162
M204 S10000
G1 X89.221 Y98.59 F18000
G1 F1500
M204 S500
G1 X89.302 Y98.651 E.00213
G1 X89.587 Y98.952 E.00878
G1 X89.875 Y99.389 E.01108
G1 X90.058 Y99.834 E.01017
G1 X90.162 Y100.376 E.0117
G1 X90.154 Y100.909 E.01128
G1 X90.055 Y101.374 E.01004
G1 X89.875 Y101.814 E.01008
G1 X89.568 Y102.274 E.0117
G1 X89.189 Y102.648 E.01128
G1 X88.802 Y102.903 E.0098
G1 X88.561 Y103.017 E.00565
G1 X88.205 Y103.139 E.00795
G1 X87.755 Y103.214 E.00966
G1 X87.432 Y103.219 E.00683
G1 X87.112 Y103.185 E.00683
M73 P57 R11
G1 X86.666 Y103.069 E.00975
G1 X86.239 Y102.871 E.00995
G1 X85.862 Y102.606 E.00975
G1 X85.629 Y102.383 E.00683
G1 X85.424 Y102.134 E.00683
G1 X85.188 Y101.738 E.00975
G1 X85.023 Y101.298 E.00995
G1 X84.94 Y100.845 E.00975
G1 X84.931 Y100.523 E.00683
G1 X84.96 Y100.201 E.00683
G1 X85.069 Y99.754 E.00975
G1 X85.256 Y99.333 E.00975
G1 X85.43 Y99.061 E.00683
G1 X85.638 Y98.808 E.00693
G1 X86.025 Y98.47 E.01088
G1 X86.372 Y98.26 E.00859
G1 X86.666 Y98.134 E.00676
G1 X86.976 Y98.044 E.00683
G1 X87.432 Y97.982 E.00976
G1 X87.893 Y98.002 E.00975
G1 X88.209 Y98.065 E.00683
G1 X88.516 Y98.165 E.00683
G1 X88.928 Y98.371 E.00975
G1 X89.173 Y98.554 E.00648
M204 S250
G1 X88.976 Y98.918 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X89.029 Y98.957 E.0013
G1 X89.265 Y99.207 E.00677
G1 X89.512 Y99.581 E.00881
G1 X89.663 Y99.951 E.00787
G1 X89.752 Y100.412 E.00924
G1 X89.745 Y100.863 E.00887
G1 X89.663 Y101.252 E.00783
G1 X89.512 Y101.621 E.00784
G1 X89.251 Y102.012 E.00924
G1 X88.93 Y102.328 E.00887
G1 X88.601 Y102.546 E.00775
G1 X88.406 Y102.638 E.00423
G1 X88.105 Y102.741 E.00627
G1 X87.718 Y102.805 E.0077
G1 X87.451 Y102.809 E.00526
G1 X87.185 Y102.781 E.00526
G1 X86.804 Y102.682 E.00773
G1 X86.445 Y102.516 E.0078
G1 X86.123 Y102.289 E.00773
G1 X85.93 Y102.104 E.00526
G1 X85.76 Y101.898 E.00526
G1 X85.558 Y101.56 E.00773
G1 X85.419 Y101.189 E.0078
G1 X85.349 Y100.802 E.00773
G1 X85.341 Y100.535 E.00526
G1 X85.365 Y100.268 E.00526
G1 X85.458 Y99.886 E.00773
G1 X85.618 Y99.527 E.00773
G1 X85.762 Y99.302 E.00526
G1 X85.933 Y99.094 E.00529
G1 X86.267 Y98.801 E.00875
G1 X86.559 Y98.625 E.00671
G1 X86.804 Y98.52 E.00524
G1 X87.061 Y98.445 E.00526
G1 X87.451 Y98.392 E.00774
G1 X87.844 Y98.41 E.00773
G1 X88.106 Y98.462 E.00526
G1 X88.36 Y98.544 E.00526
G1 X88.712 Y98.72 E.00774
G1 X88.928 Y98.882 E.0053
; WIPE_START
M204 S6000
G1 X89.029 Y98.957 E-.02392
G1 X89.265 Y99.207 E-.06539
G1 X89.512 Y99.581 E-.08507
G1 X89.663 Y99.951 E-.07599
G1 X89.752 Y100.412 E-.08926
G1 X89.749 Y100.625 E-.04038
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X93.045 Y93.741 Z3 F18000
G1 X95.869 Y87.844 Z3
G1 Z2.6
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X95.869 Y87.52 E.00686
G1 X96.869 Y87.52 E.02117
G1 X96.869 Y77.382 E.21459
G1 X94.582 Y77.382 E.0484
G1 X94.514 Y77.05 E.00717
G1 X94.373 Y76.788 E.00629
G1 X94.163 Y76.578 E.0063
G1 X93.901 Y76.437 E.0063
G1 X93.636 Y76.382 E.00571
G1 X81.496 Y76.382 E.25696
G1 X81.203 Y76.433 E.00629
G1 X80.916 Y76.593 E.00697
G1 X80.689 Y76.839 E.00707
G1 X80.542 Y77.18 E.00787
G1 X80.531 Y94.477 E.3661
G1 X80.625 Y94.854 E.00822
G1 X80.801 Y95.1 E.0064
G1 X80.995 Y95.262 E.00535
G1 X81.256 Y95.384 E.0061
G1 X81.505 Y95.42 E.00533
G1 X94.269 Y95.41 E.27016
G1 X94.269 Y93.096 E.04898
G1 X96.955 Y95.782 E.08039
G1 X90.931 Y95.782 E.12751
G1 X90.931 Y100.585 E.10166
G1 X90.914 Y100.918 E.00705
G1 X90.877 Y101.195 E.00592
G1 X90.782 Y101.588 E.00856
G1 X90.643 Y101.963 E.00848
G1 X90.456 Y102.328 E.00867
G1 X90.113 Y102.803 E.01241
G1 X89.768 Y103.148 E.01033
G1 X89.341 Y103.467 E.01127
G1 X89.19 Y103.557 E.00372
G1 X88.82 Y103.733 E.00867
G1 X88.255 Y103.907 E.01251
G1 X87.659 Y103.979 E.01271
G1 X87.25 Y103.967 E.00867
G1 X86.854 Y103.908 E.00848
G1 X86.468 Y103.803 E.00848
G1 X86.097 Y103.652 E.00847
G1 X85.75 Y103.461 E.00838
G1 X85.358 Y103.17 E.01033
G1 X84.986 Y102.802 E.01107
G1 X84.747 Y102.489 E.00834
G1 X84.543 Y102.144 E.00848
G1 X84.381 Y101.775 E.00853
G1 X84.224 Y101.202 E.01257
G1 X84.176 Y100.801 E.00857
G1 X84.168 Y95.783 E.10621
G1 X81.479 Y95.778 E.05691
G1 X81.223 Y95.741 E.00548
G1 X80.931 Y95.634 E.00659
G1 X80.792 Y95.554 E.00339
G1 X80.546 Y95.348 E.00678
G1 X80.358 Y95.095 E.00668
G1 X80.272 Y94.917 E.00418
G1 X80.206 Y94.713 E.00453
G1 X80.169 Y94.383 E.00703
G1 X80.169 Y77.419 E.35906
G1 X80.206 Y77.092 E.00697
G1 X80.286 Y76.851 E.00537
G1 X80.373 Y76.684 E.00399
G1 X80.492 Y76.517 E.00434
G1 X80.664 Y76.345 E.00515
G1 X80.868 Y76.202 E.00528
G1 X81.004 Y76.134 E.0032
G1 X81.146 Y76.082 E.0032
G1 X81.399 Y76.03 E.00547
G1 X93.569 Y76.022 E.25759
G1 X93.795 Y76.044 E.00481
G1 X93.946 Y76.079 E.00327
G1 X94.096 Y76.134 E.00339
G1 X94.366 Y76.289 E.00659
G1 X94.559 Y76.461 E.00547
G1 X94.657 Y76.577 E.00321
G1 X94.948 Y77.02 E.01122
G1 X97.231 Y77.02 E.04831
G1 X97.231 Y87.52 E.22224
G1 X98.231 Y87.52 E.02117
G1 X98.231 Y87.844 E.00686
G1 X97.05 Y89.025 E.03534
G1 X95.912 Y87.887 E.03407
; WIPE_START
M204 S6000
G1 X95.869 Y87.52 E-.07014
G1 X96.869 Y87.52 E-.19
G1 X96.869 Y86.889 E-.11986
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X94.84 Y91.091 Z3 F18000
G1 Z2.6
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X94.84 Y93.088 E.03928
G1 X97.05 Y95.298 E.06147
G1 X99.26 Y93.088 E.06147
G1 X99.26 Y91.091 E.03928
G1 X98.26 Y91.091 E.01967
G1 X98.26 Y89.811 E.02518
G1 X100.24 Y89.811 E.03895
G1 X100.24 Y96.191 E.12549
G1 X91.34 Y96.191 E.17505
G1 X91.34 Y100.595 E.08663
G1 X91.322 Y100.955 E.00708
G1 X91.28 Y101.27 E.00625
G1 X91.174 Y101.708 E.00886
G1 X91.018 Y102.129 E.00883
G1 X90.812 Y102.531 E.00889
G1 X90.695 Y102.715 E.0043
G1 X90.422 Y103.074 E.00886
G1 X90.036 Y103.459 E.01071
G1 X89.569 Y103.808 E.01148
G1 X89.382 Y103.918 E.00426
G1 X88.974 Y104.113 E.00889
G1 X88.546 Y104.257 E.00889
G1 X88.334 Y104.309 E.0043
G1 X87.883 Y104.376 E.00896
G1 X87.665 Y104.389 E.00429
G1 X87.214 Y104.376 E.00889
G1 X86.769 Y104.309 E.00883
G1 X86.336 Y104.191 E.00883
G1 X85.92 Y104.022 E.00883
G1 X85.528 Y103.806 E.0088
G1 X85.091 Y103.482 E.01072
G1 X84.678 Y103.073 E.01142
G1 X84.407 Y102.718 E.00879
G1 X84.179 Y102.331 E.00883
G1 X83.997 Y101.92 E.00885
G1 X83.891 Y101.582 E.00695
G1 X83.82 Y101.272 E.00625
G1 X83.767 Y100.825 E.00886
G1 X83.76 Y96.191 E.09115
G1 X81.449 Y96.188 E.04545
M73 P58 R11
G1 X81.134 Y96.141 E.00626
G1 X80.938 Y96.083 E.00403
G1 X80.747 Y96 E.00409
G1 X80.567 Y95.896 E.00409
G1 X80.4 Y95.772 E.0041
G1 X80.248 Y95.629 E.00409
G1 X80.114 Y95.47 E.0041
G1 X80.001 Y95.297 E.00406
G1 X79.891 Y95.069 E.00498
G1 X79.808 Y94.812 E.00532
G1 X79.772 Y94.609 E.00405
G1 X79.76 Y94.395 E.00422
G1 X79.76 Y77.407 E.33413
G1 X79.772 Y77.193 E.00422
G1 X79.808 Y76.991 E.00403
G1 X79.908 Y76.691 E.00622
G1 X80.023 Y76.469 E.00492
G1 X80.179 Y76.251 E.00526
G1 X80.4 Y76.03 E.00615
G1 X80.658 Y75.85 E.0062
G1 X80.841 Y75.758 E.00403
G1 X81.034 Y75.687 E.00403
G1 X81.345 Y75.623 E.00626
G1 X81.556 Y75.611 E.00415
G1 X93.589 Y75.612 E.23667
G1 X93.863 Y75.639 E.00541
G1 X94.063 Y75.686 E.00406
G1 X94.259 Y75.758 E.00409
G1 X94.445 Y75.851 E.0041
G1 X94.616 Y75.964 E.00403
G1 X94.854 Y76.175 E.00625
G1 X94.986 Y76.332 E.00403
G1 X95.169 Y76.611 E.00656
G1 X97.64 Y76.611 E.04861
G1 X97.64 Y87.111 E.20653
G1 X98.64 Y87.111 E.01967
G1 X98.64 Y88.014 E.01776
G1 X97.05 Y89.604 E.04423
G1 X95.46 Y88.014 E.04423
G1 X95.46 Y87.111 E.01776
G1 X96.46 Y87.111 E.01967
G1 X96.46 Y77.791 E.18332
G1 X94.16 Y77.791 E.04524
G1 X94.159 Y77.356 E.00855
G1 X94.125 Y77.191 E.0033
G1 X94.041 Y77.035 E.00349
G1 X93.916 Y76.91 E.00349
G1 X93.759 Y76.826 E.00349
G1 X93.595 Y76.792 E.00331
G1 X81.532 Y76.791 E.23727
G1 X81.342 Y76.824 E.00379
G1 X81.172 Y76.919 E.00383
G1 X81.037 Y77.065 E.00391
G1 X80.951 Y77.265 E.00429
G1 X80.94 Y94.427 E.33755
G1 X81.003 Y94.679 E.00511
G1 X81.104 Y94.819 E.0034
G1 X81.216 Y94.914 E.00289
G1 X81.375 Y94.987 E.00343
G1 X81.535 Y95.011 E.00318
G1 X93.86 Y95.001 E.24242
G1 X93.86 Y89.811 E.10209
G1 X95.84 Y89.811 E.03895
G1 X95.84 Y91.091 E.02518
G1 X94.9 Y91.091 E.01849
; WIPE_START
M204 S6000
G1 X94.84 Y93.088 E-.3796
G1 X94.842 Y93.089 E-.0004
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




G1 X94.35 Y92.887
G1 Z2.6
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.596522
G1 F1500
M204 S6000
G1 X94.35 Y90.886 E.05697
; WIPE_START
G1 X94.35 Y92.886 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X95.077 Y94.958 Z3 F18000
G1 Z2.6
G1 E.4 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.365752
G1 F1500
M204 S6000
G1 X95.013 Y94.995 E.00125
G1 X95.062 Y95.023 E.00095
; WIPE_START
G1 X95.013 Y94.995 E-.16436
G1 X95.077 Y94.958 E-.21564
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X99.065 Y94.958 Z3 F18000
G1 Z2.6
G1 E.4 F1800
G1 F1500
M204 S6000
G1 X99.002 Y94.995 E.00125
G1 X99.05 Y95.023 E.00095
; WIPE_START
G1 X99.002 Y94.995 E-.16436
G1 X99.065 Y94.958 E-.21564
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X99.75 Y92.887 Z3 F18000
G1 Z2.6
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.596522
G1 F1500
M204 S6000
G1 X99.75 Y90.886 E.05697
; WIPE_START
G1 X99.75 Y92.886 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X93.61 Y97.42 Z3 F18000
G1 X90.488 Y99.724 Z3
G1 Z2.6
G1 E.4 F1800
; LINE_WIDTH: 0.470501
G1 F1500
M204 S6000
G1 X90.34 Y99.636 E.00382
; LINE_WIDTH: 0.436173
G1 X90.192 Y99.547 E.00353
M204 S10000
G1 X90.488 Y99.724 F18000
; LINE_WIDTH: 0.46824
G1 F1500
M204 S6000
G1 X90.507 Y99.928 E.00451
; LINE_WIDTH: 0.429913
G1 X90.526 Y100.126 E.00402
; LINE_WIDTH: 0.392034
G1 X90.545 Y100.325 E.00365
; LINE_WIDTH: 0.36096
G1 X90.523 Y100.967 E.01074
G1 X90.42 Y101.477 E.00871
G1 X90.197 Y102.003 E.00956
G1 X90.038 Y102.265 E.00512
G1 X89.827 Y102.553 E.00597
G1 X89.412 Y102.948 E.00959
G1 X89.011 Y103.221 E.0081
G1 X88.695 Y103.372 E.00587
G1 X88.327 Y103.499 E.00651
G1 X88.184 Y103.53 E.00244
G1 X87.777 Y103.588 E.00688
G1 X87.425 Y103.595 E.00588
G1 X86.933 Y103.533 E.0083
G1 X86.552 Y103.429 E.0066
G1 X86.262 Y103.305 E.00528
G1 X85.957 Y103.139 E.00581
G1 X85.633 Y102.905 E.00669
G1 X85.273 Y102.55 E.00845
G1 X85.064 Y102.275 E.00577
G1 X84.883 Y101.97 E.00594
G1 X84.742 Y101.643 E.00595
G1 X84.667 Y101.412 E.00407
G1 X84.564 Y100.872 E.00918
G1 X84.553 Y100.521 E.00587
G1 X84.571 Y100.123 E.00667
; LINE_WIDTH: 0.417393
G1 X84.608 Y99.811 E.00612
; LINE_WIDTH: 0.464814
G1 X84.646 Y99.5 E.00687
M204 S10000
G1 X84.829 Y98.784 F18000
; LINE_WIDTH: 0.0976562
G1 F1500
M204 S6000
G1 X84.853 Y98.707 E.00029
G1 X84.969 Y98.58 E.00062
; WIPE_START
G1 X84.853 Y98.707 E-.25866
G1 X84.829 Y98.784 E-.12134
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X86.724 Y96.741 Z3 F18000
G1 Z2.6
G1 E.4 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.594802
G1 F1500
M204 S6000
G1 X87.02 Y96.721 E.00844
; LINE_WIDTH: 0.549344
G1 X87.317 Y96.701 E.00777
G1 X88.077 Y96.716 E.01988
; WIPE_START
G1 X87.317 Y96.701 E-.27325
G1 X87.02 Y96.721 E-.10675
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X86.724 Y96.741 Z3 F18000
G1 Z2.6
G1 E.4 F1800
; LINE_WIDTH: 0.595866
G1 F1500
M204 S6000
G1 X86.415 Y96.722 E.0088
; LINE_WIDTH: 0.557932
G1 X86.106 Y96.704 E.00822
; LINE_WIDTH: 0.504259
G1 X85.438 Y96.685 E.01595
G1 X85.439 Y97.342 E.01568
G1 X85.868 Y97.097 E.0118
; LINE_WIDTH: 0.521042
G1 X86.243 Y96.942 E.01001
; LINE_WIDTH: 0.561062
G1 X86.617 Y96.787 E.01082
; LINE_WIDTH: 0.597952
G1 X86.668 Y96.765 E.0016
; WIPE_START
G1 X86.617 Y96.787 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X89.66 Y96.685 Z3 F18000
G1 Z2.6
G1 E.4 F1800
; LINE_WIDTH: 0.506982
G1 F1500
M204 S6000
G1 X88.953 Y96.685 E.01697
; LINE_WIDTH: 0.52434
G1 X88.545 Y96.703 E.01015
; LINE_WIDTH: 0.547483
G1 X88.137 Y96.721 E.01063
G1 X88.918 Y96.96 E.02125
; LINE_WIDTH: 0.506982
G1 X89.66 Y97.312 E.01971
G1 X89.66 Y96.745 E.01361
M204 S10000
G1 X90.097 Y96.247 F18000
; LINE_WIDTH: 0.419992
G1 F1500
M204 S6000
G1 X85.002 Y96.251 E.10021
G1 X85.005 Y98.099 E.03635
G1 X85.114 Y98.159 E.00244
G1 X85.518 Y97.805 E.01057
G1 X85.979 Y97.523 E.01063
G1 X86.777 Y97.234 E.01669
G1 X87.377 Y97.148 E.01193
G1 X87.978 Y97.172 E.01182
G1 X88.808 Y97.383 E.01685
G1 X89.352 Y97.651 E.01193
G1 X89.845 Y98.016 E.01207
G1 X90.097 Y98.279 E.00716
G1 X90.097 Y96.307 E.03878
; CHANGE_LAYER
; Z_HEIGHT: 2.72
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F1500
G1 X90.097 Y98.279 E-.37466
G1 X90.078 Y98.258 E-.00535
; WIPE_END
G1 E-.02 F1800
; layer num/total_layer_count: 22/49
; update layer progress
M73 L22
M991 S0 P21 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z3 I1.055 J.606 P1  F18000
G1 X94.431 Y90.682 Z3
G1 Z2.72
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X94.269 Y90.682 E.00342
G1 X94.269 Y90.22 E.00977
G1 X95.431 Y90.22 E.02458
G1 X95.431 Y90.682 E.00977
G1 X94.491 Y90.682 E.0199
; WIPE_START
M204 S6000
G1 X94.269 Y90.682 E-.04209
G1 X94.269 Y90.22 E-.08769
G1 X95.431 Y90.22 E-.22069
G1 X95.431 Y90.376 E-.02952
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X98.669 Y90.22 Z3.12 F18000
G1 Z2.72
G1 E.4 F1800
G1 F1500
M204 S500
G1 X99.831 Y90.22 E.02458
G1 X99.831 Y90.682 E.00977
G1 X98.669 Y90.682 E.02458
G1 X98.669 Y90.28 E.0085
; WIPE_START
M204 S6000
G1 X99.831 Y90.22 E-.22098
G1 X99.831 Y90.682 E-.08769
G1 X99.455 Y90.682 E-.07132
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X98.638 Y94.889 Z3.12 F18000
G1 Z2.72
G1 E.4 F1800
G1 F1500
M204 S500
G1 X99.407 Y94.12 E.02301
G1 X99.407 Y95.357 E.02619
G1 X98.169 Y95.357 E.02619
G1 X98.595 Y94.931 E.01276
M204 S10000
G1 X98.338 Y94.589 F18000
G1 F1500
M204 S500
G1 X99.831 Y93.096 E.04469
G1 X99.831 Y95.782 E.05685
G1 X97.145 Y95.782 E.05685
G1 X98.295 Y94.631 E.03444
; WIPE_START
M204 S6000
G1 X99.71 Y93.217 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X96.569 Y87.944 Z3.12 F18000
G1 Z2.72
G1 E.4 F1800
G1 F1500
M204 S500
G1 X97.531 Y87.944 E.02035
G1 X97.05 Y88.425 E.01439
G1 X96.612 Y87.987 E.01312
; WIPE_START
M204 S6000
G1 X97.531 Y87.944 E-.17484
G1 X97.05 Y88.425 E-.1292
G1 X96.767 Y88.143 E-.07596
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X94.693 Y94.12 Z3.12 F18000
G1 Z2.72
G1 E.4 F1800
G1 F1500
M204 S500
G1 X95.931 Y95.357 E.03704
G1 X94.693 Y95.357 E.02619
G1 X94.693 Y94.18 E.02492
; WIPE_START
M204 S6000
G1 X95.931 Y95.357 E-.32452
G1 X95.639 Y95.357 E-.05549
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X89.468 Y98.245 Z3.12 F18000
G1 Z2.72
G1 E.4 F1800
G1 F1500
M204 S500
G1 X89.152 Y98.008 E.00836
G1 X88.663 Y97.764 E.01157
G1 X88.154 Y97.615 E.01123
G1 X87.778 Y97.564 E.00804
G1 X87.398 Y97.558 E.00804
G1 X86.872 Y97.63 E.01124
G1 X86.367 Y97.794 E.01123
G1 X86.027 Y97.964 E.00805
G1 X85.71 Y98.173 E.00804
G1 X85.327 Y98.518 E.0109
G1 X85.086 Y98.811 E.00804
G1 X84.882 Y99.131 E.00804
G1 X84.8 Y99.316 E.00428
G1 X84.598 Y99.273 E.00436
G1 X84.593 Y95.842 E.07262
G1 X90.507 Y95.837 E.12517
G1 X90.507 Y99.269 E.07264
G1 X90.301 Y99.31 E.00443
G1 X90.255 Y99.197 E.00257
G1 X89.961 Y98.737 E.01156
G1 X89.589 Y98.336 E.01157
G1 X89.516 Y98.281 E.00193
M204 S10000
G1 X89.214 Y98.585 F18000
G1 F1500
M204 S500
G1 X89.304 Y98.653 E.00239
G1 X89.624 Y98.997 E.00995
G1 X89.877 Y99.393 E.00995
G1 X90.058 Y99.834 E.01007
G1 X90.161 Y100.37 E.01157
G1 X90.159 Y100.848 E.01012
G1 X90.059 Y101.36 E.01104
G1 X89.944 Y101.667 E.00693
G1 X89.795 Y101.953 E.00683
G1 X89.524 Y102.326 E.00975
G1 X89.185 Y102.651 E.00995
G1 X88.802 Y102.903 E.0097
G1 X88.563 Y103.016 E.0056
G1 X88.205 Y103.139 E.008
G1 X87.755 Y103.214 E.00966
G1 X87.432 Y103.219 E.00683
G1 X87.112 Y103.185 E.00683
G1 X86.661 Y103.068 E.00985
G1 X86.187 Y102.839 E.01113
G1 X85.855 Y102.6 E.00866
G1 X85.565 Y102.312 E.00866
G1 X85.267 Y101.89 E.01093
G1 X85.125 Y101.595 E.00693
G1 X85.021 Y101.289 E.00683
G1 X84.94 Y100.845 E.00956
G1 X84.931 Y100.523 E.00683
G1 X84.96 Y100.201 E.00683
G1 X85.069 Y99.754 E.00975
G1 X85.256 Y99.333 E.00975
G1 X85.43 Y99.061 E.00683
G1 X85.635 Y98.812 E.00683
G1 X85.97 Y98.509 E.00955
G1 X86.24 Y98.332 E.00683
G1 X86.529 Y98.187 E.00683
G1 X86.966 Y98.045 E.00975
G1 X87.423 Y97.983 E.00975
G1 X87.746 Y97.988 E.00683
G1 X88.066 Y98.031 E.00683
G1 X88.508 Y98.16 E.00975
G1 X88.928 Y98.371 E.00995
G1 X89.166 Y98.549 E.00628
M204 S250
G1 X88.968 Y98.912 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X89.029 Y98.958 E.0015
G1 X89.299 Y99.248 E.0078
G1 X89.512 Y99.582 E.00779
G1 X89.663 Y99.951 E.00784
G1 X89.752 Y100.409 E.00917
G1 X89.75 Y100.808 E.00785
G1 X89.664 Y101.248 E.00882
G1 X89.569 Y101.5 E.00529
G1 X89.446 Y101.737 E.00526
M73 P59 R11
G1 X89.215 Y102.055 E.00773
G1 X88.928 Y102.329 E.0078
G1 X88.601 Y102.545 E.00772
G1 X88.409 Y102.637 E.00419
G1 X88.105 Y102.741 E.00632
G1 X87.718 Y102.805 E.00771
G1 X87.451 Y102.809 E.00526
G1 X87.185 Y102.781 E.00526
G1 X86.803 Y102.682 E.00777
G1 X86.397 Y102.486 E.00885
G1 X86.121 Y102.287 E.0067
G1 X85.879 Y102.047 E.0067
G1 X85.622 Y101.682 E.00879
G1 X85.505 Y101.439 E.00529
G1 X85.418 Y101.186 E.00526
G1 X85.349 Y100.802 E.00767
G1 X85.341 Y100.535 E.00526
G1 X85.365 Y100.268 E.00526
G1 X85.458 Y99.886 E.00773
G1 X85.618 Y99.527 E.00774
G1 X85.762 Y99.302 E.00526
G1 X85.932 Y99.095 E.00526
G1 X86.221 Y98.834 E.00767
G1 X86.445 Y98.687 E.00526
G1 X86.684 Y98.567 E.00526
G1 X87.058 Y98.445 E.00773
G1 X87.448 Y98.393 E.00774
G1 X87.715 Y98.397 E.00526
G1 X87.98 Y98.433 E.00526
G1 X88.358 Y98.543 E.00773
G1 X88.712 Y98.72 E.0078
G1 X88.92 Y98.876 E.00511
; WIPE_START
M204 S6000
G1 X89.029 Y98.958 E-.02589
G1 X89.299 Y99.248 E-.07532
G1 X89.512 Y99.582 E-.0753
G1 X89.663 Y99.951 E-.0757
G1 X89.752 Y100.409 E-.08855
G1 X89.751 Y100.615 E-.03925
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X93.049 Y93.732 Z3.12 F18000
G1 X95.869 Y87.844 Z3.12
G1 Z2.72
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X95.869 Y87.52 E.00686
G1 X96.869 Y87.52 E.02117
G1 X96.869 Y77.382 E.21459
G1 X94.582 Y77.382 E.0484
G1 X94.514 Y77.05 E.00717
G1 X94.373 Y76.788 E.00629
G1 X94.163 Y76.578 E.00629
G1 X93.901 Y76.437 E.0063
G1 X93.636 Y76.382 E.00572
G1 X81.505 Y76.382 E.25677
G1 X81.247 Y76.419 E.00552
G1 X80.936 Y76.576 E.00736
G1 X80.691 Y76.835 E.00756
G1 X80.542 Y77.18 E.00796
G1 X80.531 Y94.437 E.36524
G1 X80.555 Y94.641 E.00436
G1 X80.647 Y94.885 E.00552
G1 X80.801 Y95.1 E.00559
G1 X80.994 Y95.262 E.00534
G1 X81.256 Y95.384 E.00611
G1 X81.505 Y95.42 E.00533
G1 X94.269 Y95.41 E.27016
G1 X94.269 Y93.096 E.04898
G1 X96.955 Y95.782 E.08039
G1 X90.931 Y95.782 E.12751
G1 X90.931 Y100.585 E.10167
G1 X90.914 Y100.913 E.00696
G1 X90.877 Y101.195 E.00601
G1 X90.782 Y101.588 E.00855
G1 X90.643 Y101.963 E.00847
G1 X90.463 Y102.314 E.00835
G1 X90.165 Y102.739 E.01098
G1 X89.827 Y103.098 E.01043
G1 X89.52 Y103.347 E.00837
G1 X89.174 Y103.566 E.00867
G1 X88.829 Y103.73 E.00809
G1 X88.447 Y103.859 E.00854
G1 X87.937 Y103.956 E.01098
G1 X87.442 Y103.979 E.01049
G1 X86.857 Y103.909 E.01247
G1 X86.468 Y103.803 E.00855
G1 X86.097 Y103.652 E.00847
G1 X85.75 Y103.461 E.00837
G1 X85.355 Y103.167 E.01043
G1 X84.986 Y102.802 E.01098
G1 X84.747 Y102.489 E.00835
G1 X84.543 Y102.144 E.00848
G1 X84.381 Y101.775 E.00853
G1 X84.224 Y101.202 E.01257
G1 X84.176 Y100.801 E.00856
G1 X84.168 Y95.783 E.10621
G1 X81.479 Y95.778 E.05691
G1 X81.223 Y95.741 E.00548
G1 X80.931 Y95.634 E.00659
G1 X80.792 Y95.554 E.00339
G1 X80.524 Y95.321 E.00751
G1 X80.394 Y95.154 E.00448
G1 X80.317 Y95.02 E.00327
G1 X80.207 Y94.719 E.00678
G1 X80.169 Y94.383 E.00716
G1 X80.169 Y77.419 E.35905
G1 X80.206 Y77.092 E.00697
G1 X80.284 Y76.855 E.00527
G1 X80.4 Y76.641 E.00515
G1 X80.524 Y76.48 E.00429
G1 X80.661 Y76.347 E.00404
G1 X80.868 Y76.202 E.00537
G1 X80.996 Y76.138 E.00301
G1 X81.241 Y76.057 E.00547
G1 X81.39 Y76.03 E.00321
G1 X93.571 Y76.022 E.25783
G1 X93.795 Y76.043 E.00476
G1 X93.946 Y76.079 E.00327
G1 X94.235 Y76.204 E.00668
G1 X94.401 Y76.316 E.00423
G1 X94.557 Y76.459 E.00449
G1 X94.657 Y76.577 E.00327
G1 X94.948 Y77.02 E.01123
G1 X97.231 Y77.02 E.04831
G1 X97.231 Y87.52 E.22224
G1 X98.231 Y87.52 E.02117
G1 X98.231 Y87.844 E.00686
G1 X97.05 Y89.025 E.03534
G1 X95.912 Y87.887 E.03407
; WIPE_START
M204 S6000
G1 X95.869 Y87.52 E-.07014
G1 X96.869 Y87.52 E-.19
G1 X96.869 Y86.889 E-.11986
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X94.84 Y91.091 Z3.12 F18000
G1 Z2.72
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X94.84 Y93.088 E.03928
G1 X97.05 Y95.298 E.06147
G1 X99.26 Y93.088 E.06147
G1 X99.26 Y91.091 E.03928
G1 X98.26 Y91.091 E.01967
G1 X98.26 Y89.811 E.02518
G1 X100.24 Y89.811 E.03895
G1 X100.24 Y96.191 E.12549
G1 X91.34 Y96.191 E.17505
G1 X91.34 Y100.595 E.08663
G1 X91.322 Y100.95 E.00699
G1 X91.28 Y101.27 E.00634
G1 X91.174 Y101.708 E.00886
G1 X91.018 Y102.128 E.00883
G1 X90.814 Y102.526 E.00879
G1 X90.483 Y102.998 E.01133
G1 X90.107 Y103.398 E.01081
G1 X89.759 Y103.68 E.0088
G1 X89.377 Y103.921 E.00889
G1 X89.18 Y104.022 E.00435
G1 X88.977 Y104.112 E.00436
G1 X88.551 Y104.256 E.00885
G1 X87.985 Y104.364 E.01133
G1 X87.435 Y104.389 E.01083
G1 X87.089 Y104.361 E.00683
G1 X86.771 Y104.31 E.00634
G1 X86.336 Y104.191 E.00886
G1 X85.92 Y104.022 E.00883
G1 X85.528 Y103.806 E.0088
G1 X85.087 Y103.479 E.01081
G1 X84.678 Y103.073 E.01133
G1 X84.407 Y102.718 E.00879
G1 X84.179 Y102.331 E.00883
G1 X83.997 Y101.919 E.00885
G1 X83.892 Y101.587 E.00686
G1 X83.82 Y101.272 E.00635
G1 X83.767 Y100.825 E.00886
G1 X83.76 Y96.191 E.09115
G1 X81.449 Y96.188 E.04545
G1 X81.134 Y96.141 E.00626
G1 X80.938 Y96.083 E.00403
G1 X80.747 Y96 E.00409
G1 X80.567 Y95.896 E.00409
G1 X80.401 Y95.773 E.00407
G1 X80.218 Y95.595 E.00502
G1 X80.054 Y95.383 E.00528
G1 X79.951 Y95.204 E.00406
G1 X79.868 Y95.013 E.0041
G1 X79.809 Y94.814 E.00409
G1 X79.772 Y94.609 E.00409
G1 X79.76 Y94.395 E.00422
G1 X79.76 Y77.407 E.33413
G1 X79.772 Y77.193 E.00422
G1 X79.808 Y76.991 E.00403
G1 X79.907 Y76.692 E.00619
G1 X80.056 Y76.417 E.00615
G1 X80.218 Y76.207 E.00522
G1 X80.399 Y76.031 E.00496
G1 X80.658 Y75.85 E.00622
G1 X80.838 Y75.759 E.00397
G1 X81.14 Y75.659 E.00625
G1 X81.342 Y75.623 E.00403
G1 X81.556 Y75.611 E.00421
G1 X93.591 Y75.612 E.23672
G1 X93.863 Y75.639 E.00536
G1 X94.063 Y75.686 E.00406
G1 X94.259 Y75.758 E.00409
G1 X94.443 Y75.85 E.00406
G1 X94.654 Y75.994 E.00502
G1 X94.853 Y76.174 E.00528
G1 X94.986 Y76.332 E.00405
G1 X95.169 Y76.611 E.00656
G1 X97.64 Y76.611 E.04861
G1 X97.64 Y87.111 E.20653
G1 X98.64 Y87.111 E.01967
G1 X98.64 Y88.014 E.01776
G1 X97.05 Y89.604 E.04423
G1 X95.46 Y88.014 E.04423
G1 X95.46 Y87.111 E.01776
G1 X96.46 Y87.111 E.01967
G1 X96.46 Y77.791 E.18332
G1 X94.16 Y77.791 E.04524
G1 X94.159 Y77.356 E.00855
G1 X94.125 Y77.191 E.00331
G1 X94.041 Y77.035 E.00349
G1 X93.916 Y76.91 E.00349
G1 X93.759 Y76.826 E.00349
G1 X93.595 Y76.792 E.00331
G1 X81.535 Y76.791 E.23721
G1 X81.371 Y76.815 E.00325
G1 X81.184 Y76.909 E.00413
G1 X81.038 Y77.064 E.00419
G1 X80.951 Y77.265 E.00431
G1 X80.94 Y94.413 E.33728
G1 X80.955 Y94.543 E.00258
G1 X81.011 Y94.69 E.00308
G1 X81.104 Y94.819 E.00314
G1 X81.216 Y94.914 E.00289
G1 X81.374 Y94.987 E.00343
G1 X81.535 Y95.011 E.00319
G1 X93.86 Y95.001 E.24243
G1 X93.86 Y89.811 E.10209
G1 X95.84 Y89.811 E.03895
G1 X95.84 Y91.091 E.02518
G1 X94.9 Y91.091 E.01849
; WIPE_START
M204 S6000
G1 X94.84 Y93.088 E-.3796
G1 X94.842 Y93.089 E-.0004
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




G1 X94.35 Y92.887
G1 Z2.72
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.596522
G1 F1500
M204 S6000
G1 X94.35 Y90.886 E.05697
; WIPE_START
G1 X94.35 Y92.886 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X95.077 Y94.958 Z3.12 F18000
G1 Z2.72
G1 E.4 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.365752
G1 F1500
M204 S6000
G1 X95.013 Y94.995 E.00125
G1 X95.062 Y95.023 E.00095
; WIPE_START
G1 X95.013 Y94.995 E-.16436
G1 X95.077 Y94.958 E-.21564
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X99.065 Y94.958 Z3.12 F18000
G1 Z2.72
G1 E.4 F1800
G1 F1500
M204 S6000
G1 X99.002 Y94.995 E.00125
G1 X99.05 Y95.023 E.00095
; WIPE_START
G1 X99.002 Y94.995 E-.16436
G1 X99.065 Y94.958 E-.21564
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X99.75 Y92.887 Z3.12 F18000
G1 Z2.72
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.596522
G1 F1500
M204 S6000
G1 X99.75 Y90.886 E.05697
; WIPE_START
G1 X99.75 Y92.886 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X93.25 Y96.887 Z3.12 F18000
G1 X90.294 Y98.706 Z3.12
G1 Z2.72
G1 E.4 F1800
; LINE_WIDTH: 0.146364
G1 F1500
M204 S6000
G1 X90.168 Y98.571 E.00112
; LINE_WIDTH: 0.118095
G1 X90.052 Y98.466 E.00072
; LINE_WIDTH: 0.092537
G1 X89.936 Y98.362 E.00052
; WIPE_START
G1 X90.052 Y98.466 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X90.192 Y99.547 Z3.12 F18000
G1 Z2.72
G1 E.4 F1800
; LINE_WIDTH: 0.436069
G1 F1500
M204 S6000
G1 X90.34 Y99.636 E.00353
; LINE_WIDTH: 0.470477
G1 X90.488 Y99.725 E.00382
; LINE_WIDTH: 0.468466
G1 X90.507 Y99.925 E.00445
; LINE_WIDTH: 0.430531
G1 X90.526 Y100.121 E.00398
; LINE_WIDTH: 0.393024
G1 X90.544 Y100.317 E.00361
; LINE_WIDTH: 0.360572
G1 X90.529 Y100.9 E.00974
G1 X90.419 Y101.477 E.00981
G1 X90.295 Y101.81 E.00594
G1 X90.137 Y102.118 E.00578
G1 X89.797 Y102.583 E.00963
G1 X89.566 Y102.816 E.00549
G1 X89.297 Y103.035 E.00579
G1 X88.988 Y103.234 E.00614
G1 X88.698 Y103.372 E.00536
G1 X88.284 Y103.507 E.00726
G1 X87.893 Y103.577 E.00665
G1 X87.452 Y103.598 E.00737
G1 X86.935 Y103.534 E.0087
G1 X86.546 Y103.427 E.00674
G1 X86.263 Y103.304 E.00517
G1 X85.956 Y103.141 E.0058
G1 X85.621 Y102.896 E.00692
M73 P60 R11
G1 X85.271 Y102.552 E.00821
G1 X85.067 Y102.274 E.00577
G1 X84.883 Y101.97 E.00593
G1 X84.739 Y101.644 E.00595
G1 X84.663 Y101.395 E.00435
G1 X84.602 Y101.133 E.00449
G1 X84.557 Y100.778 E.00598
G1 X84.571 Y100.123 E.01095
; LINE_WIDTH: 0.41739
G1 X84.608 Y99.811 E.00612
; LINE_WIDTH: 0.464806
G1 X84.646 Y99.5 E.00687
M204 S10000
G1 X84.829 Y98.784 F18000
; LINE_WIDTH: 0.0941292
G1 F1500
M204 S6000
G1 X84.85 Y98.717 E.00024
G1 X84.942 Y98.613 E.00047
; WIPE_START
G1 X84.85 Y98.717 E-.25264
G1 X84.829 Y98.784 E-.12736
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X86.705 Y96.742 Z3.12 F18000
G1 Z2.72
G1 E.4 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.597362
G1 F1500
M204 S6000
G1 X87.001 Y96.722 E.00848
; LINE_WIDTH: 0.563925
G1 X87.298 Y96.702 E.00798
G1 X88.189 Y96.728 E.02395
; WIPE_START
G1 X87.298 Y96.702 E-.28501
G1 X87.001 Y96.722 E-.09499
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X86.705 Y96.742 Z3.12 F18000
G1 Z2.72
G1 E.4 F1800
; LINE_WIDTH: 0.599369
G1 F1500
M204 S6000
G1 X86.484 Y96.725 E.00634
; LINE_WIDTH: 0.563322
G1 X86.263 Y96.707 E.00594
; LINE_WIDTH: 0.511165
G1 X86.042 Y96.689 E.00537
G1 X85.442 Y96.689 E.01453
G1 X85.443 Y97.349 E.01598
G1 X85.968 Y97.046 E.01469
; LINE_WIDTH: 0.529672
G1 X86.292 Y96.912 E.0088
; LINE_WIDTH: 0.570512
G1 X86.615 Y96.778 E.00951
; LINE_WIDTH: 0.604162
G1 X86.649 Y96.765 E.00105
; WIPE_START
G1 X86.615 Y96.778 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X89.66 Y96.685 Z3.12 F18000
G1 Z2.72
G1 E.4 F1800
; LINE_WIDTH: 0.506992
G1 F1500
M204 S6000
G1 X88.958 Y96.685 E.01684
; LINE_WIDTH: 0.521077
G1 X88.675 Y96.7 E.007
; LINE_WIDTH: 0.549247
G1 X88.392 Y96.714 E.0074
; LINE_WIDTH: 0.579162
G1 X88.249 Y96.73 E.00398
; LINE_WIDTH: 0.572992
G1 X88.584 Y96.843 E.00966
; LINE_WIDTH: 0.511426
G1 X88.919 Y96.956 E.00857
G1 X89.656 Y97.323 E.01994
G1 X89.66 Y96.745 E.01401
M204 S10000
G1 X90.097 Y96.247 F18000
; LINE_WIDTH: 0.419992
G1 F1500
M204 S6000
G1 X85.002 Y96.251 E.10021
G1 X85.005 Y98.135 E.03707
G1 X85.081 Y98.189 E.00182
G1 X85.482 Y97.834 E.01053
G1 X86.188 Y97.426 E.01604
G1 X86.763 Y97.235 E.01193
G1 X87.358 Y97.151 E.01182
G1 X88.213 Y97.21 E.01685
G1 X88.797 Y97.376 E.01193
G1 X89.352 Y97.651 E.01219
G1 X89.751 Y97.956 E.00987
G1 X89.877 Y97.849 E.00324
G1 X90.097 Y97.87 E.00436
G1 X90.097 Y96.307 E.03074
; CHANGE_LAYER
; Z_HEIGHT: 2.84
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F1500
G1 X90.097 Y97.87 E-.29699
G1 X89.877 Y97.849 E-.04212
G1 X89.751 Y97.956 E-.03132
G1 X89.711 Y97.925 E-.00957
; WIPE_END
G1 E-.02 F1800
; layer num/total_layer_count: 23/49
; update layer progress
M73 L23
M991 S0 P22 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z3.12 I1.02 J.664 P1  F18000
G1 X94.431 Y90.682 Z3.12
G1 Z2.84
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X94.269 Y90.682 E.00342
G1 X94.269 Y90.22 E.00977
G1 X95.431 Y90.22 E.02458
G1 X95.431 Y90.682 E.00977
G1 X94.491 Y90.682 E.0199
; WIPE_START
M204 S6000
G1 X94.269 Y90.682 E-.04209
G1 X94.269 Y90.22 E-.08769
G1 X95.431 Y90.22 E-.22069
G1 X95.431 Y90.376 E-.02952
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X98.669 Y90.22 Z3.24 F18000
G1 Z2.84
G1 E.4 F1800
G1 F1500
M204 S500
G1 X99.831 Y90.22 E.02458
G1 X99.831 Y90.682 E.00977
G1 X98.669 Y90.682 E.02458
G1 X98.669 Y90.28 E.0085
; WIPE_START
M204 S6000
G1 X99.831 Y90.22 E-.22098
G1 X99.831 Y90.682 E-.08769
G1 X99.455 Y90.682 E-.07132
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X98.638 Y94.889 Z3.24 F18000
G1 Z2.84
G1 E.4 F1800
G1 F1500
M204 S500
G1 X99.407 Y94.12 E.02301
G1 X99.407 Y95.357 E.02619
G1 X98.169 Y95.357 E.02619
G1 X98.595 Y94.931 E.01276
M204 S10000
G1 X98.338 Y94.589 F18000
G1 F1500
M204 S500
G1 X99.831 Y93.096 E.04469
G1 X99.831 Y95.782 E.05685
G1 X97.145 Y95.782 E.05685
G1 X98.295 Y94.631 E.03444
; WIPE_START
M204 S6000
G1 X99.71 Y93.217 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X96.569 Y87.944 Z3.24 F18000
G1 Z2.84
G1 E.4 F1800
G1 F1500
M204 S500
G1 X97.531 Y87.944 E.02035
G1 X97.05 Y88.425 E.01439
G1 X96.612 Y87.987 E.01312
; WIPE_START
M204 S6000
G1 X97.531 Y87.944 E-.17484
G1 X97.05 Y88.425 E-.1292
G1 X96.767 Y88.143 E-.07596
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X94.693 Y94.12 Z3.24 F18000
G1 Z2.84
G1 E.4 F1800
G1 F1500
M204 S500
G1 X95.931 Y95.357 E.03704
G1 X94.693 Y95.357 E.02619
G1 X94.693 Y94.18 E.02492
; WIPE_START
M204 S6000
G1 X95.931 Y95.357 E-.32452
G1 X95.639 Y95.357 E-.05549
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X89.545 Y98.31 Z3.24 F18000
G1 Z2.84
G1 E.4 F1800
G1 F1500
M204 S500
G1 X89.458 Y98.223 E.00259
G1 X88.987 Y97.912 E.01195
G1 X88.41 Y97.677 E.0132
G1 X87.787 Y97.562 E.0134
G1 X87.232 Y97.57 E.01177
G1 X86.695 Y97.675 E.01156
G1 X86.187 Y97.875 E.01157
G1 X85.735 Y98.154 E.01123
G1 X85.446 Y98.4 E.00804
G1 X85.187 Y98.678 E.00804
G1 X84.892 Y99.111 E.01109
G1 X84.798 Y99.315 E.00476
G1 X84.598 Y99.271 E.00433
G1 X84.593 Y95.842 E.07259
G1 X90.507 Y95.837 E.12517
G1 X90.507 Y99.269 E.07264
G1 X90.301 Y99.31 E.00443
G1 X90.252 Y99.189 E.00275
G1 X89.908 Y98.669 E.0132
G1 X89.588 Y98.352 E.00954
M204 S10000
G1 X89.246 Y98.611 F18000
G1 F1500
M204 S500
G1 X89.578 Y98.94 E.00989
G1 X89.875 Y99.389 E.01139
G1 X90.057 Y99.833 E.01018
G1 X90.162 Y100.371 E.01159
G1 X90.154 Y100.909 E.01139
G1 X90.055 Y101.374 E.01005
G1 X89.877 Y101.809 E.00995
G1 X89.621 Y102.209 E.01005
G1 X89.252 Y102.595 E.01131
G1 X88.856 Y102.873 E.01023
G1 X88.425 Y103.072 E.01004
G1 X87.901 Y103.2 E.01142
G1 X87.359 Y103.215 E.01149
G1 X86.957 Y103.155 E.00859
G1 X86.443 Y102.977 E.0115
G1 X85.976 Y102.699 E.01151
G1 X85.572 Y102.322 E.0117
G1 X85.262 Y101.882 E.01139
G1 X85.067 Y101.443 E.01018
G1 X84.947 Y100.909 E.01159
G1 X84.938 Y100.371 E.01139
G1 X85.021 Y99.915 E.0098
G1 X85.103 Y99.667 E.00555
G1 X85.262 Y99.321 E.00806
G1 X85.52 Y98.944 E.00966
G1 X85.739 Y98.707 E.00683
G1 X85.985 Y98.498 E.00683
G1 X86.377 Y98.256 E.00975
G1 X86.815 Y98.084 E.00995
G1 X87.276 Y97.993 E.00995
G1 X87.752 Y97.986 E.01007
G1 X88.29 Y98.086 E.01159
G1 X88.788 Y98.289 E.01139
G1 X89.189 Y98.554 E.01017
G1 X89.204 Y98.569 E.00043
M204 S250
G1 X88.958 Y98.901 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X89.26 Y99.201 E.00836
G1 X89.512 Y99.581 E.00897
G1 X89.663 Y99.951 E.00787
G1 X89.752 Y100.407 E.00914
G1 X89.745 Y100.863 E.00897
G1 X89.663 Y101.252 E.00783
G1 X89.512 Y101.619 E.0078
G1 X89.298 Y101.955 E.00783
G1 X88.984 Y102.283 E.00894
G1 X88.651 Y102.517 E.008
G1 X88.29 Y102.683 E.00782
G1 X87.847 Y102.792 E.00898
G1 X87.383 Y102.804 E.00911
G1 X87.055 Y102.756 E.00654
G1 X86.617 Y102.604 E.00911
G1 X86.224 Y102.37 E.009
G1 X85.883 Y102.052 E.00918
G1 X85.62 Y101.679 E.00897
G1 X85.457 Y101.314 E.00787
G1 X85.355 Y100.86 E.00914
G1 X85.348 Y100.404 E.00897
G1 X85.418 Y100.017 E.00775
G1 X85.484 Y99.817 E.00414
G1 X85.62 Y99.523 E.00637
G1 X85.84 Y99.199 E.0077
G1 X86.023 Y99.003 E.00527
G1 X86.227 Y98.83 E.00526
G1 X86.561 Y98.623 E.00774
G1 X86.93 Y98.479 E.00779
G1 X87.319 Y98.402 E.0078
G1 X87.717 Y98.396 E.00783
G1 X88.174 Y98.481 E.00914
G1 X88.596 Y98.653 E.00897
G1 X88.913 Y98.862 E.00747
; WIPE_START
M204 S6000
G1 X89.26 Y99.201 E-.0921
G1 X89.512 Y99.581 E-.08661
G1 X89.663 Y99.951 E-.07602
G1 X89.752 Y100.407 E-.0883
G1 X89.749 Y100.602 E-.03697
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X93.05 Y93.72 Z3.24 F18000
G1 X95.869 Y87.844 Z3.24
G1 Z2.84
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X95.869 Y87.52 E.00686
G1 X96.869 Y87.52 E.02117
G1 X96.869 Y77.382 E.21459
G1 X94.582 Y77.382 E.0484
G1 X94.514 Y77.05 E.00716
G1 X94.373 Y76.788 E.0063
G1 X94.163 Y76.578 E.00629
G1 X93.901 Y76.437 E.0063
G1 X93.636 Y76.382 E.00571
G1 X81.496 Y76.382 E.25696
G1 X81.207 Y76.432 E.0062
G1 X80.929 Y76.582 E.00669
G1 X80.69 Y76.836 E.00736
G1 X80.542 Y77.181 E.00795
G1 X80.531 Y94.442 E.36535
G1 X80.561 Y94.667 E.00481
G1 X80.675 Y94.943 E.0063
G1 X80.961 Y95.246 E.00883
G1 X81.256 Y95.384 E.00689
G1 X81.505 Y95.42 E.00534
G1 X94.269 Y95.41 E.27016
G1 X94.269 Y93.096 E.04898
G1 X96.955 Y95.782 E.08039
G1 X90.931 Y95.782 E.12751
G1 X90.931 Y100.585 E.10167
G1 X90.914 Y100.909 E.00686
G1 X90.877 Y101.195 E.00611
G1 X90.782 Y101.588 E.00855
G1 X90.643 Y101.963 E.00848
G1 X90.456 Y102.328 E.00867
G1 X90.113 Y102.803 E.0124
G1 X89.761 Y103.154 E.01053
G1 X89.342 Y103.467 E.01108
G1 X89.19 Y103.557 E.00373
G1 X88.825 Y103.731 E.00856
G1 X88.351 Y103.882 E.01053
G1 X87.835 Y103.969 E.01108
G1 X87.25 Y103.967 E.01238
G1 X86.854 Y103.908 E.00848
G1 X86.468 Y103.803 E.00848
G1 X86.097 Y103.652 E.00847
G1 X85.75 Y103.461 E.00837
G1 X85.351 Y103.165 E.01052
G1 X84.986 Y102.803 E.01088
G1 X84.747 Y102.489 E.00835
G1 X84.543 Y102.144 E.00848
G1 X84.384 Y101.783 E.00835
G1 X84.243 Y101.289 E.01088
G1 X84.176 Y100.795 E.01054
G1 X84.168 Y95.783 E.1061
G1 X81.479 Y95.778 E.05691
G1 X81.223 Y95.741 E.00548
G1 X80.931 Y95.634 E.00659
G1 X80.792 Y95.554 E.00339
G1 X80.546 Y95.348 E.00678
G1 X80.449 Y95.232 E.0032
G1 X80.313 Y95.012 E.00547
G1 X80.207 Y94.719 E.00659
G1 X80.169 Y94.383 E.00716
G1 X80.169 Y77.419 E.35906
G1 X80.206 Y77.092 E.00697
G1 X80.284 Y76.855 E.00528
G1 X80.403 Y76.635 E.00528
G1 X80.488 Y76.521 E.00301
G1 X80.664 Y76.345 E.00528
G1 X80.868 Y76.202 E.00528
G1 X80.996 Y76.138 E.00302
G1 X81.241 Y76.057 E.00547
G1 X81.39 Y76.03 E.0032
G1 X93.574 Y76.022 E.25788
G1 X93.795 Y76.043 E.00471
G1 X93.946 Y76.079 E.00328
G1 X94.235 Y76.204 E.00667
G1 X94.402 Y76.317 E.00427
G1 X94.657 Y76.577 E.0077
G1 X94.948 Y77.02 E.01122
G1 X97.231 Y77.02 E.04831
G1 X97.231 Y87.52 E.22224
G1 X98.231 Y87.52 E.02117
G1 X98.231 Y87.844 E.00686
G1 X97.05 Y89.025 E.03534
G1 X95.912 Y87.887 E.03407
; WIPE_START
M204 S6000
G1 X95.869 Y87.52 E-.07014
G1 X96.869 Y87.52 E-.19
G1 X96.869 Y86.889 E-.11986
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X94.84 Y91.091 Z3.24 F18000
G1 Z2.84
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X94.84 Y93.088 E.03928
G1 X97.05 Y95.298 E.06147
G1 X99.26 Y93.088 E.06147
G1 X99.26 Y91.091 E.03928
G1 X98.26 Y91.091 E.01967
G1 X98.26 Y89.811 E.02518
G1 X100.24 Y89.811 E.03895
G1 X100.24 Y96.191 E.12549
G1 X91.34 Y96.191 E.17505
G1 X91.34 Y100.595 E.08663
G1 X91.322 Y100.946 E.0069
G1 X91.28 Y101.27 E.00643
G1 X91.174 Y101.708 E.00886
G1 X91.018 Y102.129 E.00883
G1 X90.812 Y102.531 E.00889
G1 X90.695 Y102.715 E.0043
G1 X90.422 Y103.073 E.00886
G1 X90.029 Y103.465 E.0109
G1 X89.569 Y103.808 E.0113
G1 X89.382 Y103.918 E.00426
G1 X88.976 Y104.112 E.00886
G1 X88.448 Y104.281 E.0109
G1 X87.881 Y104.376 E.0113
G1 X87.665 Y104.389 E.00426
G1 X87.214 Y104.376 E.00889
G1 X86.769 Y104.309 E.00883
G1 X86.336 Y104.191 E.00883
G1 X85.92 Y104.022 E.00883
G1 X85.529 Y103.806 E.0088
G1 X85.084 Y103.476 E.0109
G1 X84.678 Y103.073 E.01124
G1 X84.407 Y102.718 E.00879
G1 X84.179 Y102.331 E.00883
G1 X83.998 Y101.922 E.00879
G1 X83.842 Y101.373 E.01124
G1 X83.767 Y100.823 E.01091
G1 X83.76 Y96.191 E.09111
G1 X81.449 Y96.188 E.04545
G1 X81.134 Y96.141 E.00626
G1 X80.938 Y96.083 E.00403
G1 X80.747 Y96 E.0041
G1 X80.567 Y95.896 E.00409
G1 X80.4 Y95.772 E.0041
G1 X80.248 Y95.629 E.00409
G1 X80.116 Y95.472 E.00403
G1 X79.949 Y95.201 E.00626
G1 X79.868 Y95.013 E.00403
G1 X79.809 Y94.814 E.00409
G1 X79.772 Y94.609 E.0041
G1 X79.76 Y94.395 E.00422
G1 X79.76 Y77.407 E.33413
G1 X79.772 Y77.193 E.00422
G1 X79.808 Y76.991 E.00403
G1 X79.907 Y76.692 E.0062
G1 X80.057 Y76.415 E.00619
G1 X80.177 Y76.253 E.00397
G1 X80.4 Y76.03 E.0062
G1 X80.658 Y75.85 E.00619
G1 X80.838 Y75.759 E.00397
G1 X81.14 Y75.659 E.00625
G1 X81.342 Y75.623 E.00403
G1 X81.556 Y75.611 E.00422
G1 X93.594 Y75.612 E.23676
G1 X93.863 Y75.639 E.00532
G1 X94.063 Y75.686 E.00406
G1 X94.259 Y75.758 E.00409
G1 X94.443 Y75.85 E.00406
G1 X94.656 Y75.995 E.00507
G1 X94.853 Y76.174 E.00523
G1 X94.986 Y76.332 E.00405
G1 X95.169 Y76.611 E.00656
G1 X97.64 Y76.611 E.04861
G1 X97.64 Y87.111 E.20653
G1 X98.64 Y87.111 E.01967
G1 X98.64 Y88.014 E.01776
G1 X97.05 Y89.604 E.04423
G1 X95.46 Y88.014 E.04423
G1 X95.46 Y87.111 E.01776
G1 X96.46 Y87.111 E.01967
G1 X96.46 Y77.791 E.18332
M73 P61 R11
G1 X94.16 Y77.791 E.04524
G1 X94.159 Y77.356 E.00855
G1 X94.125 Y77.192 E.0033
G1 X94.041 Y77.035 E.0035
G1 X93.916 Y76.91 E.00349
G1 X93.759 Y76.826 E.0035
G1 X93.595 Y76.792 E.00331
G1 X81.532 Y76.791 E.23727
M73 P61 R10
G1 X81.343 Y76.824 E.00376
G1 X81.182 Y76.911 E.00362
G1 X81.038 Y77.064 E.00412
G1 X80.951 Y77.265 E.00431
G1 X80.94 Y94.415 E.33732
G1 X80.96 Y94.56 E.00288
G1 X81.024 Y94.717 E.00333
G1 X81.205 Y94.908 E.00518
G1 X81.374 Y94.987 E.00368
G1 X81.535 Y95.011 E.00319
G1 X93.86 Y95.001 E.24243
G1 X93.86 Y89.811 E.10209
G1 X95.84 Y89.811 E.03895
G1 X95.84 Y91.091 E.02518
G1 X94.9 Y91.091 E.01849
; WIPE_START
M204 S6000
G1 X94.84 Y93.088 E-.3796
G1 X94.842 Y93.089 E-.0004
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




G1 X94.35 Y92.887
G1 Z2.84
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.596522
G1 F1500
M204 S6000
G1 X94.35 Y90.886 E.05697
; WIPE_START
G1 X94.35 Y92.886 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X95.077 Y94.958 Z3.24 F18000
G1 Z2.84
G1 E.4 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.365752
G1 F1500
M204 S6000
G1 X95.013 Y94.995 E.00125
G1 X95.062 Y95.023 E.00095
; WIPE_START
G1 X95.013 Y94.995 E-.16436
G1 X95.077 Y94.958 E-.21564
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X99.065 Y94.958 Z3.24 F18000
G1 Z2.84
G1 E.4 F1800
G1 F1500
M204 S6000
G1 X99.002 Y94.995 E.00125
G1 X99.05 Y95.023 E.00095
; WIPE_START
G1 X99.002 Y94.995 E-.16436
G1 X99.065 Y94.958 E-.21564
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X99.75 Y92.887 Z3.24 F18000
G1 Z2.84
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.596522
G1 F1500
M204 S6000
G1 X99.75 Y90.886 E.05697
; WIPE_START
G1 X99.75 Y92.886 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X93.61 Y97.42 Z3.24 F18000
G1 X90.488 Y99.725 Z3.24
G1 Z2.84
G1 E.4 F1800
; LINE_WIDTH: 0.470434
G1 F1500
M204 S6000
G1 X90.34 Y99.636 E.00382
; LINE_WIDTH: 0.435839
G1 X90.192 Y99.547 E.00352
M204 S10000
G1 X90.488 Y99.725 F18000
; LINE_WIDTH: 0.468431
G1 F1500
M204 S6000
G1 X90.507 Y99.925 E.00446
; LINE_WIDTH: 0.430285
G1 X90.526 Y100.122 E.00399
; LINE_WIDTH: 0.392533
G1 X90.545 Y100.319 E.00362
; LINE_WIDTH: 0.361591
G1 X90.531 Y100.935 E.01033
G1 X90.42 Y101.477 E.00927
G1 X90.215 Y101.968 E.00891
G1 X89.907 Y102.454 E.00964
G1 X89.51 Y102.871 E.00965
G1 X89.031 Y103.206 E.0098
G1 X88.534 Y103.43 E.00913
G1 X88.26 Y103.508 E.00477
G1 X87.792 Y103.587 E.00796
G1 X87.284 Y103.588 E.00851
G1 X86.882 Y103.525 E.00681
G1 X86.591 Y103.437 E.00509
G1 X86.26 Y103.309 E.00595
G1 X85.959 Y103.137 E.00581
G1 X85.602 Y102.873 E.00744
G1 X85.271 Y102.552 E.00772
G1 X85.067 Y102.274 E.00579
G1 X84.883 Y101.969 E.00595
G1 X84.706 Y101.546 E.0077
G1 X84.62 Y101.21 E.00581
G1 X84.56 Y100.769 E.00745
; LINE_WIDTH: 0.374618
G1 X84.557 Y100.356 E.00719
G1 X84.58 Y100.074 E.00493
; LINE_WIDTH: 0.434322
G1 X84.602 Y99.824 E.0051
; LINE_WIDTH: 0.474491
G1 X84.655 Y99.501 E.00733
M204 S10000
G1 X84.809 Y98.744 F18000
; LINE_WIDTH: 0.1181
G1 F1500
M204 S6000
G1 X84.908 Y98.634 E.00068
; LINE_WIDTH: 0.0925396
G1 X85.007 Y98.524 E.00049
; WIPE_START
G1 X84.908 Y98.634 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X87.095 Y96.71 Z3.24 F18000
G1 Z2.84
G1 E.4 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.543815
G1 F1500
M204 S6000
G1 X87.864 Y96.703 E.01988
M204 S10000
G1 X87.095 Y96.71 F18000
; LINE_WIDTH: 0.540032
G1 F1500
M204 S6000
G1 X86.796 Y96.697 E.00768
; LINE_WIDTH: 0.501592
G1 X85.438 Y96.685 E.03225
G1 X85.439 Y97.346 E.01569
G1 X85.861 Y97.097 E.01164
G1 X86.405 Y96.883 E.01388
; LINE_WIDTH: 0.513112
G1 X86.721 Y96.803 E.00792
; LINE_WIDTH: 0.538712
G1 X87.037 Y96.723 E.00834
; WIPE_START
G1 X86.721 Y96.803 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X89.662 Y96.683 Z3.24 F18000
G1 Z2.84
G1 E.4 F1800
; LINE_WIDTH: 0.509315
G1 F1500
M204 S6000
G1 X88.6 Y96.683 E.02561
G1 X87.924 Y96.706 E.01632
G1 X88.585 Y96.85 E.01632
G1 X89.326 Y97.138 E.01918
G1 X89.662 Y97.346 E.00952
G1 X89.662 Y96.743 E.01455
M204 S10000
G1 X90.097 Y96.247 F18000
; LINE_WIDTH: 0.419992
G1 F1500
M204 S6000
G1 X85.002 Y96.251 E.10021
G1 X85.005 Y98.04 E.0352
G1 X85.089 Y98.047 E.00165
G1 X85.169 Y98.119 E.00211
G1 X85.507 Y97.814 E.00895
G1 X85.988 Y97.517 E.01113
G1 X86.564 Y97.288 E.01219
G1 X87.171 Y97.165 E.01219
G1 X87.802 Y97.152 E.01242
G1 X88.506 Y97.278 E.01406
G1 X89.161 Y97.541 E.01389
G1 X89.701 Y97.893 E.01268
G1 X90.097 Y98.281 E.01089
G1 X90.097 Y96.307 E.03882
; CHANGE_LAYER
; Z_HEIGHT: 2.96
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F1500
G1 X90.097 Y98.281 E-.37504
G1 X90.079 Y98.262 E-.00496
; WIPE_END
G1 E-.02 F1800
; layer num/total_layer_count: 24/49
; update layer progress
M73 L24
M991 S0 P23 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z3.24 I1.055 J.606 P1  F18000
G1 X94.431 Y90.682 Z3.24
G1 Z2.96
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X94.269 Y90.682 E.00342
G1 X94.269 Y90.22 E.00977
G1 X95.431 Y90.22 E.02458
G1 X95.431 Y90.682 E.00977
G1 X94.491 Y90.682 E.0199
; WIPE_START
M204 S6000
G1 X94.269 Y90.682 E-.04209
G1 X94.269 Y90.22 E-.08769
G1 X95.431 Y90.22 E-.22069
G1 X95.431 Y90.376 E-.02952
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X98.669 Y90.22 Z3.36 F18000
G1 Z2.96
G1 E.4 F1800
G1 F1500
M204 S500
G1 X99.831 Y90.22 E.02458
G1 X99.831 Y90.682 E.00977
G1 X98.669 Y90.682 E.02458
G1 X98.669 Y90.28 E.0085
; WIPE_START
M204 S6000
G1 X99.831 Y90.22 E-.22098
G1 X99.831 Y90.682 E-.08769
G1 X99.455 Y90.682 E-.07132
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X98.638 Y94.889 Z3.36 F18000
G1 Z2.96
G1 E.4 F1800
G1 F1500
M204 S500
G1 X99.407 Y94.12 E.02301
G1 X99.407 Y95.357 E.02619
G1 X98.169 Y95.357 E.02619
G1 X98.595 Y94.931 E.01276
M204 S10000
G1 X98.338 Y94.589 F18000
G1 F1500
M204 S500
G1 X99.831 Y93.096 E.04469
G1 X99.831 Y95.782 E.05685
G1 X97.145 Y95.782 E.05685
G1 X98.295 Y94.631 E.03444
; WIPE_START
M204 S6000
G1 X99.71 Y93.217 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X96.569 Y87.944 Z3.36 F18000
G1 Z2.96
G1 E.4 F1800
G1 F1500
M204 S500
G1 X97.531 Y87.944 E.02035
G1 X97.05 Y88.425 E.01439
G1 X96.612 Y87.987 E.01312
; WIPE_START
M204 S6000
G1 X97.531 Y87.944 E-.17484
G1 X97.05 Y88.425 E-.1292
G1 X96.767 Y88.143 E-.07596
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X94.693 Y94.12 Z3.36 F18000
G1 Z2.96
G1 E.4 F1800
G1 F1500
M204 S500
G1 X95.931 Y95.357 E.03704
G1 X94.693 Y95.357 E.02619
G1 X94.693 Y94.18 E.02492
; WIPE_START
M204 S6000
G1 X95.931 Y95.357 E-.32452
G1 X95.639 Y95.357 E-.05549
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X89.527 Y98.291 Z3.36 F18000
G1 Z2.96
G1 E.4 F1800
G1 F1500
M204 S500
G1 X89.45 Y98.218 E.00224
G1 X89.007 Y97.926 E.01124
G1 X88.663 Y97.766 E.00804
G1 X88.301 Y97.649 E.00804
G1 X87.778 Y97.562 E.01123
G1 X87.223 Y97.57 E.01175
G1 X86.61 Y97.701 E.01326
G1 X86.034 Y97.956 E.01335
G1 X85.592 Y98.267 E.01142
G1 X85.318 Y98.529 E.00804
G1 X85.076 Y98.823 E.00804
G1 X84.785 Y99.311 E.01203
G1 X84.598 Y99.26 E.0041
G1 X84.593 Y95.842 E.07234
G1 X90.507 Y95.837 E.12517
G1 X90.507 Y99.269 E.07264
G1 X90.301 Y99.31 E.00443
G1 X90.108 Y98.95 E.00864
G1 X89.841 Y98.591 E.00946
G1 X89.57 Y98.333 E.00793
M204 S10000
G1 X89.234 Y98.598 F18000
G1 F1500
M204 S500
G1 X89.522 Y98.873 E.00844
G1 X89.753 Y99.184 E.00821
G1 X89.882 Y99.405 E.0054
G1 X90.057 Y99.833 E.0098
G1 X90.161 Y100.364 E.01146
G1 X90.16 Y100.842 E.01011
G1 X90.057 Y101.369 E.01136
G1 X89.877 Y101.809 E.01006
G1 X89.624 Y102.205 E.00995
G1 X89.307 Y102.546 E.00987
G1 X89.003 Y102.78 E.00812
G1 X88.776 Y102.917 E.00561
G1 X88.292 Y103.114 E.01107
G1 X87.898 Y103.199 E.00853
G1 X87.432 Y103.22 E.00986
G1 X86.966 Y103.157 E.00995
G1 X86.532 Y103.016 E.00968
G1 X86.302 Y102.904 E.0054
G1 X85.975 Y102.696 E.0082
G1 X85.635 Y102.39 E.00967
G1 X85.43 Y102.141 E.00683
G1 X85.253 Y101.865 E.00695
G1 X85.048 Y101.38 E.01113
G1 X84.957 Y100.988 E.00853
G1 X84.929 Y100.522 E.00987
G1 X84.985 Y100.059 E.00987
G1 X85.095 Y99.688 E.0082
G1 X85.194 Y99.453 E.0054
G1 X85.424 Y99.068 E.00949
G1 X85.629 Y98.819 E.00683
G1 X85.863 Y98.595 E.00683
G1 X86.244 Y98.327 E.00986
G1 X86.742 Y98.107 E.01154
G1 X87.271 Y97.994 E.01145
G1 X87.746 Y97.986 E.01006
G1 X88.2 Y98.062 E.00975
G1 X88.507 Y98.162 E.00683
G1 X88.8 Y98.297 E.00683
G1 X89.185 Y98.551 E.00976
G1 X89.19 Y98.556 E.00016
M204 S250
G1 X88.951 Y98.894 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X89.214 Y99.145 E.00717
G1 X89.411 Y99.41 E.0065
G1 X89.514 Y99.586 E.00401
G1 X89.663 Y99.951 E.00775
G1 X89.751 Y100.404 E.00907
G1 X89.751 Y100.802 E.00785
G1 X89.663 Y101.251 E.00899
G1 X89.512 Y101.619 E.00783
G1 X89.299 Y101.953 E.00779
G1 X89.03 Y102.243 E.00777
G1 X88.772 Y102.442 E.00642
G1 X88.592 Y102.55 E.00412
G1 X88.171 Y102.722 E.00895
G1 X87.845 Y102.792 E.00655
G1 X87.451 Y102.81 E.00777
G1 X87.058 Y102.756 E.0078
G1 X86.685 Y102.635 E.00771
G1 X86.502 Y102.546 E.00401
G1 X86.223 Y102.369 E.0065
G1 X85.932 Y102.107 E.00771
G1 X85.762 Y101.9 E.00526
G1 X85.617 Y101.673 E.0053
G1 X85.439 Y101.253 E.00897
G1 X85.364 Y100.929 E.00654
G1 X85.34 Y100.535 E.00777
G1 X85.387 Y100.142 E.00777
G1 X85.481 Y99.826 E.0065
G1 X85.56 Y99.638 E.00401
G1 X85.76 Y99.304 E.00765
G1 X85.93 Y99.097 E.00526
G1 X86.123 Y98.912 E.00526
G1 X86.446 Y98.685 E.00777
G1 X86.869 Y98.498 E.0091
G1 X87.317 Y98.402 E.00902
G1 X87.715 Y98.396 E.00783
G1 X88.103 Y98.461 E.00773
G1 X88.357 Y98.543 E.00526
G1 X88.6 Y98.656 E.00526
G1 X88.904 Y98.856 E.00716
; WIPE_START
M204 S6000
G1 X89.214 Y99.145 E-.08055
G1 X89.411 Y99.41 E-.06275
G1 X89.514 Y99.586 E-.03872
G1 X89.663 Y99.951 E-.07483
G1 X89.751 Y100.404 E-.08763
G1 X89.751 Y100.591 E-.03552
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X93.054 Y93.71 Z3.36 F18000
G1 X95.869 Y87.844 Z3.36
G1 Z2.96
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X95.869 Y87.52 E.00686
G1 X96.869 Y87.52 E.02117
G1 X96.869 Y77.382 E.21459
G1 X94.582 Y77.382 E.0484
G1 X94.514 Y77.05 E.00717
G1 X94.373 Y76.788 E.00629
G1 X94.163 Y76.578 E.00629
G1 X93.901 Y76.437 E.0063
G1 X93.636 Y76.382 E.00571
G1 X81.496 Y76.382 E.25696
G1 X81.198 Y76.434 E.0064
G1 X80.897 Y76.608 E.00737
G1 X80.687 Y76.844 E.00669
G1 X80.542 Y77.181 E.00775
G1 X80.531 Y94.437 E.36524
G1 X80.555 Y94.642 E.00437
G1 X80.648 Y94.886 E.00554
G1 X80.802 Y95.1 E.00556
G1 X80.995 Y95.262 E.00533
G1 X81.256 Y95.384 E.0061
G1 X81.505 Y95.42 E.00534
G1 X94.269 Y95.41 E.27016
G1 X94.269 Y93.096 E.04898
G1 X96.955 Y95.782 E.08039
G1 X90.931 Y95.782 E.12751
G1 X90.931 Y100.585 E.10168
G1 X90.915 Y100.904 E.00676
G1 X90.877 Y101.196 E.00621
G1 X90.782 Y101.588 E.00854
G1 X90.643 Y101.963 E.00848
G1 X90.463 Y102.315 E.00836
G1 X90.17 Y102.732 E.01078
G1 X89.827 Y103.098 E.01062
G1 X89.513 Y103.353 E.00856
G1 X89.19 Y103.557 E.00809
G1 X88.82 Y103.733 E.00867
G1 X88.255 Y103.907 E.01251
G1 X87.659 Y103.979 E.01271
G1 X87.25 Y103.967 E.00866
G1 X86.854 Y103.908 E.00848
G1 X86.468 Y103.803 E.00848
G1 X86.097 Y103.652 E.00847
G1 X85.751 Y103.461 E.00836
G1 X85.348 Y103.162 E.01062
G1 X84.986 Y102.803 E.01078
G1 X84.747 Y102.489 E.00835
G1 X84.543 Y102.144 E.00848
G1 X84.381 Y101.775 E.00854
G1 X84.224 Y101.202 E.01258
G1 X84.176 Y100.801 E.00856
G1 X84.168 Y95.783 E.10621
G1 X81.479 Y95.778 E.05691
G1 X81.223 Y95.741 E.00548
G1 X80.931 Y95.634 E.00659
G1 X80.792 Y95.554 E.00339
G1 X80.521 Y95.318 E.00759
G1 X80.317 Y95.02 E.00766
G1 X80.208 Y94.719 E.00678
G1 X80.169 Y94.383 E.00717
G1 X80.169 Y77.419 E.35906
G1 X80.206 Y77.092 E.00697
G1 X80.284 Y76.855 E.00528
G1 X80.403 Y76.636 E.00527
G1 X80.488 Y76.521 E.00302
G1 X80.67 Y76.339 E.00547
G1 X80.785 Y76.254 E.00301
G1 X81.004 Y76.135 E.00528
G1 X81.241 Y76.057 E.00527
G1 X81.39 Y76.03 E.00321
G1 X93.576 Y76.022 E.25792
G1 X93.795 Y76.043 E.00466
G1 X93.946 Y76.079 E.00328
G1 X94.235 Y76.204 E.00667
G1 X94.404 Y76.319 E.00432
G1 X94.657 Y76.577 E.00765
G1 X94.948 Y77.02 E.01123
G1 X97.231 Y77.02 E.04831
M73 P62 R10
G1 X97.231 Y87.52 E.22224
G1 X98.231 Y87.52 E.02117
G1 X98.231 Y87.844 E.00686
G1 X97.05 Y89.025 E.03534
G1 X95.912 Y87.887 E.03407
; WIPE_START
M204 S6000
G1 X95.869 Y87.52 E-.07014
G1 X96.869 Y87.52 E-.19
G1 X96.869 Y86.889 E-.11986
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X94.84 Y91.091 Z3.36 F18000
G1 Z2.96
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X94.84 Y93.088 E.03928
G1 X97.05 Y95.298 E.06147
G1 X99.26 Y93.088 E.06147
G1 X99.26 Y91.091 E.03928
G1 X98.26 Y91.091 E.01967
G1 X98.26 Y89.811 E.02518
G1 X100.24 Y89.811 E.03895
G1 X100.24 Y96.191 E.12549
G1 X91.34 Y96.191 E.17505
G1 X91.34 Y100.596 E.08664
G1 X91.323 Y100.941 E.0068
G1 X91.28 Y101.27 E.00653
G1 X91.174 Y101.708 E.00886
G1 X91.018 Y102.129 E.00883
G1 X90.814 Y102.526 E.00879
G1 X90.489 Y102.99 E.01114
G1 X90.107 Y103.398 E.01099
G1 X89.757 Y103.682 E.00886
G1 X89.573 Y103.806 E.00436
G1 X89.382 Y103.918 E.00436
G1 X88.974 Y104.113 E.00889
G1 X88.546 Y104.257 E.00889
G1 X88.334 Y104.309 E.0043
G1 X87.883 Y104.376 E.00896
G1 X87.665 Y104.389 E.00429
G1 X87.214 Y104.376 E.00889
G1 X86.769 Y104.309 E.00883
G1 X86.336 Y104.191 E.00883
G1 X85.92 Y104.022 E.00883
G1 X85.529 Y103.806 E.0088
G1 X85.08 Y103.473 E.01099
G1 X84.678 Y103.073 E.01115
G1 X84.407 Y102.718 E.00879
G1 X84.179 Y102.331 E.00883
G1 X83.997 Y101.92 E.00885
G1 X83.895 Y101.596 E.00668
G1 X83.82 Y101.272 E.00653
G1 X83.767 Y100.825 E.00886
G1 X83.76 Y96.191 E.09115
G1 X81.449 Y96.188 E.04545
G1 X81.134 Y96.141 E.00626
G1 X80.938 Y96.083 E.00403
G1 X80.747 Y96 E.00409
G1 X80.567 Y95.896 E.00409
G1 X80.401 Y95.773 E.00406
G1 X80.215 Y95.591 E.00511
G1 X80.054 Y95.383 E.00519
G1 X79.951 Y95.204 E.00406
G1 X79.868 Y95.013 E.00409
G1 X79.809 Y94.814 E.00409
G1 X79.772 Y94.609 E.00409
G1 X79.76 Y94.395 E.00422
G1 X79.76 Y77.407 E.33413
G1 X79.772 Y77.193 E.00422
G1 X79.808 Y76.991 E.00403
G1 X79.907 Y76.692 E.0062
G1 X80.057 Y76.415 E.00619
G1 X80.177 Y76.253 E.00398
G1 X80.402 Y76.028 E.00625
G1 X80.564 Y75.908 E.00397
G1 X80.841 Y75.758 E.0062
G1 X81.14 Y75.659 E.00619
G1 X81.342 Y75.623 E.00403
G1 X81.556 Y75.611 E.00422
G1 X93.596 Y75.613 E.23681
G1 X93.863 Y75.639 E.00527
G1 X94.063 Y75.686 E.00406
G1 X94.259 Y75.758 E.00409
G1 X94.443 Y75.85 E.00406
G1 X94.658 Y75.997 E.00511
G1 X94.853 Y76.174 E.00519
G1 X94.986 Y76.332 E.00405
G1 X95.169 Y76.611 E.00656
G1 X97.64 Y76.611 E.04861
G1 X97.64 Y87.111 E.20653
G1 X98.64 Y87.111 E.01967
G1 X98.64 Y88.014 E.01776
G1 X97.05 Y89.604 E.04423
G1 X95.46 Y88.014 E.04423
G1 X95.46 Y87.111 E.01776
G1 X96.46 Y87.111 E.01967
G1 X96.46 Y77.791 E.18332
G1 X94.16 Y77.791 E.04524
G1 X94.159 Y77.356 E.00855
G1 X94.125 Y77.191 E.00331
G1 X94.041 Y77.035 E.00349
G1 X93.916 Y76.91 E.00349
G1 X93.759 Y76.826 E.00349
G1 X93.595 Y76.792 E.00331
G1 X81.532 Y76.791 E.23727
G1 X81.34 Y76.825 E.00382
G1 X81.158 Y76.93 E.00413
G1 X81.036 Y77.067 E.00361
G1 X80.951 Y77.265 E.00425
G1 X80.94 Y94.413 E.33728
G1 X80.955 Y94.544 E.00259
G1 X81.011 Y94.691 E.0031
G1 X81.104 Y94.819 E.00312
G1 X81.216 Y94.914 E.00289
G1 X81.374 Y94.987 E.00343
G1 X81.535 Y95.011 E.00319
G1 X93.86 Y95.001 E.24243
G1 X93.86 Y89.811 E.10209
G1 X95.84 Y89.811 E.03895
G1 X95.84 Y91.091 E.02518
G1 X94.9 Y91.091 E.01849
; WIPE_START
M204 S6000
G1 X94.84 Y93.088 E-.3796
G1 X94.842 Y93.089 E-.0004
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




G1 X94.35 Y92.887
G1 Z2.96
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.596522
G1 F1500
M204 S6000
G1 X94.35 Y90.886 E.05697
; WIPE_START
G1 X94.35 Y92.886 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X95.077 Y94.958 Z3.36 F18000
G1 Z2.96
G1 E.4 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.365752
G1 F1500
M204 S6000
G1 X95.013 Y94.995 E.00125
G1 X95.062 Y95.023 E.00095
; WIPE_START
G1 X95.013 Y94.995 E-.16436
G1 X95.077 Y94.958 E-.21564
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X99.065 Y94.958 Z3.36 F18000
G1 Z2.96
G1 E.4 F1800
G1 F1500
M204 S6000
G1 X99.002 Y94.995 E.00125
G1 X99.05 Y95.023 E.00095
; WIPE_START
G1 X99.002 Y94.995 E-.16436
G1 X99.065 Y94.958 E-.21564
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X99.75 Y92.887 Z3.36 F18000
G1 Z2.96
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.596522
G1 F1500
M204 S6000
G1 X99.75 Y90.886 E.05697
; WIPE_START
G1 X99.75 Y92.886 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X93.221 Y96.84 Z3.36 F18000
G1 X90.196 Y98.672 Z3.36
G1 Z2.96
G1 E.4 F1800
; LINE_WIDTH: 0.0858022
G1 F1500
M204 S6000
G1 X90.261 Y98.746 E.0003
G1 X90.276 Y98.79 E.00014
M204 S10000
G1 X90.192 Y99.547 F18000
; LINE_WIDTH: 0.435349
G1 F1500
M204 S6000
G1 X90.34 Y99.636 E.00352
; LINE_WIDTH: 0.470309
G1 X90.488 Y99.725 E.00382
; LINE_WIDTH: 0.468736
G1 X90.507 Y99.922 E.00439
; LINE_WIDTH: 0.431007
G1 X90.525 Y100.117 E.00395
; LINE_WIDTH: 0.393618
G1 X90.544 Y100.311 E.00358
; LINE_WIDTH: 0.360627
G1 X90.538 Y100.871 E.00936
G1 X90.415 Y101.493 E.01059
G1 X90.291 Y101.809 E.00566
G1 X90.134 Y102.117 E.00578
G1 X89.912 Y102.446 E.00664
G1 X89.57 Y102.819 E.00845
G1 X89.151 Y103.136 E.00879
G1 X88.675 Y103.375 E.0089
G1 X88.389 Y103.476 E.00507
G1 X87.96 Y103.571 E.00734
G1 X87.43 Y103.594 E.00886
G1 X86.897 Y103.528 E.00898
G1 X86.591 Y103.438 E.00533
G1 X86.261 Y103.307 E.00593
G1 X85.958 Y103.139 E.00579
G1 X85.738 Y102.986 E.00448
G1 X85.598 Y102.871 E.00302
G1 X85.273 Y102.551 E.00762
G1 X85.064 Y102.276 E.00578
G1 X84.913 Y102.028 E.00484
G1 X84.696 Y101.51 E.00939
G1 X84.582 Y101.028 E.00827
G1 X84.552 Y100.526 E.0084
G1 X84.568 Y100.245 E.00471
; LINE_WIDTH: 0.401491
G1 X84.583 Y99.993 E.00473
; LINE_WIDTH: 0.438914
G1 X84.621 Y99.726 E.00555
; LINE_WIDTH: 0.476488
G1 X84.656 Y99.496 E.00525
; WIPE_START
G1 X84.621 Y99.726 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X87.085 Y96.71 Z3.36 F18000
G1 Z2.96
G1 E.4 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.544292
G1 F1500
M204 S6000
G1 X87.784 Y96.7 E.0181
; LINE_WIDTH: 0.552269
G1 X87.992 Y96.716 E.00547
; LINE_WIDTH: 0.586462
G1 X88.199 Y96.731 E.00582
; LINE_WIDTH: 0.620656
G1 X88.407 Y96.747 E.00617
; WIPE_START
G1 X88.199 Y96.731 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X87.085 Y96.71 Z3.36 F18000
G1 Z2.96
G1 E.4 F1800
; LINE_WIDTH: 0.513166
G1 F1500
M204 S6000
G1 X86.391 Y96.686 E.01687
G1 X85.44 Y96.687 E.02314
G1 X85.441 Y97.339 E.01586
G1 X85.776 Y97.145 E.00943
G1 X86.288 Y96.919 E.01362
G1 X87.026 Y96.722 E.01857
; WIPE_START
G1 X86.288 Y96.919 E-.14506
G1 X85.776 Y97.145 E-.10638
G1 X85.441 Y97.339 E-.07365
G1 X85.44 Y97.05 E-.05491
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X89.661 Y96.684 Z3.36 F18000
G1 Z2.96
G1 E.4 F1800
; LINE_WIDTH: 0.525607
G1 F1500
M204 S6000
G1 X89.138 Y96.705 E.01305
; LINE_WIDTH: 0.567177
G1 X88.615 Y96.726 E.01414
; LINE_WIDTH: 0.612857
G1 X88.466 Y96.751 E.00441
; LINE_WIDTH: 0.615597
G1 X88.755 Y96.883 E.00935
; LINE_WIDTH: 0.571287
G1 X89.045 Y97.015 E.00865
; LINE_WIDTH: 0.51024
G1 X89.334 Y97.147 E.00768
G1 X89.661 Y97.343 E.00923
G1 X89.661 Y96.744 E.0145
M204 S10000
G1 X90.097 Y96.247 F18000
; LINE_WIDTH: 0.419992
G1 F1500
M204 S6000
G1 X85.002 Y96.251 E.10021
G1 X85.006 Y98.234 E.039
G1 X85.815 Y97.609 E.02011
G1 X86.465 Y97.318 E.014
G1 X87.158 Y97.165 E.01395
G1 X87.791 Y97.152 E.01246
G1 X88.384 Y97.248 E.01182
G1 X89.174 Y97.553 E.01666
G1 X89.692 Y97.887 E.01212
M73 P63 R10
G1 X90.058 Y98.247 E.0101
G1 X90.097 Y98.196 E.00127
G1 X90.097 Y96.307 E.03715
; CHANGE_LAYER
; Z_HEIGHT: 3.08
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F1500
G1 X90.097 Y98.196 E-.35889
G1 X90.058 Y98.247 E-.01228
G1 X90.025 Y98.215 E-.00883
; WIPE_END
G1 E-.02 F1800
; layer num/total_layer_count: 25/49
; update layer progress
M73 L25
M991 S0 P24 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z3.36 I1.05 J.614 P1  F18000
G1 X94.431 Y90.682 Z3.36
G1 Z3.08
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X94.269 Y90.682 E.00342
G1 X94.269 Y90.22 E.00977
G1 X95.431 Y90.22 E.02458
G1 X95.431 Y90.682 E.00977
G1 X94.491 Y90.682 E.0199
; WIPE_START
M204 S6000
G1 X94.269 Y90.682 E-.04209
G1 X94.269 Y90.22 E-.08769
G1 X95.431 Y90.22 E-.22069
G1 X95.431 Y90.376 E-.02952
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X98.669 Y90.22 Z3.48 F18000
G1 Z3.08
G1 E.4 F1800
G1 F1500
M204 S500
G1 X99.831 Y90.22 E.02458
G1 X99.831 Y90.682 E.00977
G1 X98.669 Y90.682 E.02458
G1 X98.669 Y90.28 E.0085
; WIPE_START
M204 S6000
G1 X99.831 Y90.22 E-.22098
G1 X99.831 Y90.682 E-.08769
G1 X99.455 Y90.682 E-.07132
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X98.638 Y94.889 Z3.48 F18000
G1 Z3.08
G1 E.4 F1800
G1 F1500
M204 S500
G1 X99.407 Y94.12 E.02301
G1 X99.407 Y95.357 E.02619
G1 X98.169 Y95.357 E.02619
G1 X98.595 Y94.931 E.01276
M204 S10000
G1 X98.338 Y94.589 F18000
G1 F1500
M204 S500
G1 X99.831 Y93.096 E.04469
G1 X99.831 Y95.782 E.05685
G1 X97.145 Y95.782 E.05685
G1 X98.295 Y94.631 E.03444
; WIPE_START
M204 S6000
G1 X99.71 Y93.217 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X96.569 Y87.944 Z3.48 F18000
G1 Z3.08
G1 E.4 F1800
G1 F1500
M204 S500
G1 X97.531 Y87.944 E.02035
G1 X97.05 Y88.425 E.01439
G1 X96.612 Y87.987 E.01312
; WIPE_START
M204 S6000
G1 X97.531 Y87.944 E-.17484
G1 X97.05 Y88.425 E-.1292
G1 X96.767 Y88.143 E-.07596
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X94.693 Y94.12 Z3.48 F18000
G1 Z3.08
G1 E.4 F1800
G1 F1500
M204 S500
G1 X95.931 Y95.357 E.03704
G1 X94.693 Y95.357 E.02619
G1 X94.693 Y94.18 E.02492
; WIPE_START
M204 S6000
G1 X95.931 Y95.357 E-.32452
G1 X95.639 Y95.357 E-.05549
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X89.52 Y98.284 Z3.48 F18000
G1 Z3.08
G1 E.4 F1800
G1 F1500
M204 S500
G1 X89.45 Y98.218 E.00203
G1 X89.007 Y97.926 E.01124
G1 X88.663 Y97.766 E.00804
G1 X88.301 Y97.649 E.00804
G1 X87.778 Y97.562 E.01123
G1 X87.223 Y97.57 E.01176
G1 X86.608 Y97.702 E.01331
G1 X86.033 Y97.956 E.01329
G1 X85.572 Y98.281 E.01194
G1 X85.138 Y98.737 E.01331
G1 X84.783 Y99.31 E.01428
G1 X84.598 Y99.257 E.00406
G1 X84.593 Y95.842 E.07229
G1 X90.507 Y95.837 E.12519
G1 X90.502 Y99.265 E.07254
G1 X90.309 Y99.313 E.00421
G1 X90.154 Y99.021 E.007
G1 X89.845 Y98.596 E.01112
G1 X89.563 Y98.326 E.00826
M204 S10000
G1 X89.226 Y98.591 F18000
G1 F1500
M204 S500
G1 X89.524 Y98.876 E.00872
G1 X89.793 Y99.246 E.00968
G1 X89.914 Y99.473 E.00544
G1 X90.058 Y99.837 E.00828
G1 X90.16 Y100.361 E.01131
G1 X90.16 Y100.839 E.01011
G1 X90.06 Y101.356 E.01115
G1 X89.97 Y101.604 E.00557
G1 X89.798 Y101.949 E.00815
G1 X89.524 Y102.326 E.00987
G1 X89.185 Y102.651 E.00995
G1 X88.792 Y102.91 E.00995
G1 X88.369 Y103.091 E.00975
G1 X88.056 Y103.172 E.00683
G1 X87.746 Y103.214 E.00663
G1 X87.432 Y103.219 E.00664
G1 X87.112 Y103.185 E.00683
G1 X86.666 Y103.069 E.00975
G1 X86.239 Y102.871 E.00995
G1 X85.858 Y102.603 E.00987
G1 X85.584 Y102.332 E.00815
G1 X85.423 Y102.131 E.00545
G1 X85.188 Y101.739 E.00969
G1 X85.023 Y101.298 E.00995
G1 X84.939 Y100.84 E.00987
G1 X84.935 Y100.435 E.00856
G1 X85.021 Y99.908 E.0113
G1 X85.19 Y99.458 E.01017
G1 X85.476 Y98.998 E.01148
G1 X85.85 Y98.604 E.0115
G1 X86.243 Y98.327 E.01017
G1 X86.739 Y98.108 E.01148
G1 X87.271 Y97.994 E.0115
G1 X87.746 Y97.986 E.01006
G1 X88.2 Y98.062 E.00975
G1 X88.507 Y98.162 E.00683
G1 X88.8 Y98.297 E.00683
G1 X89.183 Y98.55 E.00971
M204 S250
G1 X88.944 Y98.887 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X89.215 Y99.146 E.00738
G1 X89.445 Y99.463 E.00771
G1 X89.542 Y99.645 E.00404
G1 X89.664 Y99.952 E.0065
G1 X89.751 Y100.401 E.00899
G1 X89.751 Y100.8 E.00785
G1 X89.664 Y101.247 E.00895
G1 X89.593 Y101.442 E.00409
G1 X89.447 Y101.736 E.00645
G1 X89.215 Y102.055 E.00777
G1 X88.928 Y102.329 E.0078
G1 X88.598 Y102.548 E.00779
G1 X88.236 Y102.702 E.00773
G1 X87.977 Y102.77 E.00526
G1 X87.715 Y102.805 E.0052
G1 X87.451 Y102.809 E.0052
G1 X87.185 Y102.781 E.00526
G1 X86.804 Y102.682 E.00773
G1 X86.445 Y102.515 E.0078
G1 X86.121 Y102.288 E.00777
G1 X85.889 Y102.057 E.00645
G1 X85.759 Y101.897 E.00405
G1 X85.558 Y101.56 E.00771
G1 X85.419 Y101.189 E.0078
G1 X85.348 Y100.8 E.00777
G1 X85.344 Y100.466 E.00658
G1 X85.418 Y100.014 E.009
G1 X85.559 Y99.64 E.00787
G1 X85.801 Y99.249 E.00904
G1 X86.119 Y98.915 E.00906
G1 X86.446 Y98.685 E.00787
G1 X86.867 Y98.499 E.00905
G1 X87.317 Y98.402 E.00907
G1 X87.715 Y98.396 E.00783
G1 X88.103 Y98.461 E.00773
G1 X88.358 Y98.543 E.00526
G1 X88.6 Y98.656 E.00526
G1 X88.896 Y98.851 E.00697
; WIPE_START
M204 S6000
G1 X89.215 Y99.146 E-.08261
G1 X89.445 Y99.463 E-.07449
G1 X89.542 Y99.645 E-.03904
G1 X89.664 Y99.952 E-.0628
G1 X89.751 Y100.401 E-.08688
G1 X89.751 Y100.581 E-.03418
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X93.056 Y93.701 Z3.48 F18000
G1 X95.869 Y87.844 Z3.48
G1 Z3.08
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X95.869 Y87.52 E.00686
G1 X96.869 Y87.52 E.02117
G1 X96.869 Y77.382 E.21459
G1 X94.582 Y77.382 E.0484
G1 X94.514 Y77.05 E.00717
G1 X94.373 Y76.788 E.0063
G1 X94.163 Y76.578 E.00629
G1 X93.901 Y76.437 E.00629
G1 X93.637 Y76.382 E.00571
G1 X81.5 Y76.382 E.25688
G1 X81.227 Y76.426 E.00586
G1 X80.933 Y76.579 E.00702
G1 X80.69 Y76.836 E.00747
G1 X80.542 Y77.18 E.00795
G1 X80.531 Y94.437 E.36524
G1 X80.555 Y94.642 E.00438
G1 X80.649 Y94.887 E.00555
G1 X80.802 Y95.1 E.00555
G1 X80.995 Y95.262 E.00533
G1 X81.256 Y95.384 E.0061
G1 X81.505 Y95.42 E.00533
G1 X94.269 Y95.41 E.27016
G1 X94.269 Y93.096 E.04898
G1 X96.955 Y95.782 E.08039
G1 X90.932 Y95.782 E.12749
G1 X90.924 Y100.801 E.10623
G1 X90.876 Y101.199 E.00848
G1 X90.782 Y101.588 E.00848
G1 X90.643 Y101.963 E.00847
G1 X90.459 Y102.322 E.00854
G1 X90.116 Y102.801 E.01246
G1 X89.754 Y103.16 E.01078
G1 X89.342 Y103.467 E.01088
G1 X89.19 Y103.557 E.00373
G1 X88.825 Y103.73 E.00855
G1 X88.343 Y103.884 E.01072
G1 X87.835 Y103.969 E.01088
G1 X87.25 Y103.967 E.01239
G1 X86.854 Y103.908 E.00848
G1 X86.468 Y103.803 E.00848
G1 X86.097 Y103.652 E.00847
G1 X85.751 Y103.461 E.00836
G1 X85.345 Y103.159 E.01072
G1 X84.987 Y102.803 E.01069
G1 X84.747 Y102.489 E.00836
G1 X84.543 Y102.144 E.00848
G1 X84.381 Y101.775 E.00854
G1 X84.224 Y101.202 E.01257
G1 X84.176 Y100.801 E.00855
G1 X84.168 Y95.783 E.10621
G1 X81.479 Y95.778 E.05691
G1 X81.223 Y95.741 E.00548
G1 X80.931 Y95.634 E.00659
G1 X80.792 Y95.554 E.0034
G1 X80.546 Y95.348 E.00678
G1 X80.449 Y95.232 E.0032
G1 X80.313 Y95.012 E.00547
G1 X80.207 Y94.719 E.00659
G1 X80.169 Y94.383 E.00716
G1 X80.169 Y77.419 E.35906
G1 X80.206 Y77.092 E.00697
G1 X80.285 Y76.852 E.00535
G1 X80.377 Y76.677 E.00417
G1 X80.492 Y76.517 E.00416
G1 X80.67 Y76.339 E.00535
G1 X80.785 Y76.254 E.00302
G1 X81.004 Y76.135 E.00528
G1 X81.241 Y76.057 E.00528
G1 X81.39 Y76.03 E.00321
G1 X93.578 Y76.022 E.25796
G1 X93.795 Y76.043 E.00462
G1 X93.946 Y76.079 E.00328
G1 X94.24 Y76.206 E.00678
G1 X94.374 Y76.294 E.00339
G1 X94.601 Y76.507 E.00659
G1 X94.96 Y77.02 E.01325
G1 X97.231 Y77.02 E.04807
G1 X97.231 Y87.52 E.22224
G1 X98.231 Y87.52 E.02117
G1 X98.231 Y87.844 E.00686
G1 X97.05 Y89.025 E.03534
G1 X95.912 Y87.887 E.03407
; WIPE_START
M204 S6000
G1 X95.869 Y87.52 E-.07014
G1 X96.869 Y87.52 E-.19
G1 X96.869 Y86.889 E-.11986
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X94.84 Y91.091 Z3.48 F18000
G1 Z3.08
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X94.84 Y93.088 E.03928
G1 X97.05 Y95.298 E.06147
G1 X99.26 Y93.088 E.06147
G1 X99.26 Y91.091 E.03928
G1 X98.26 Y91.091 E.01967
G1 X98.26 Y89.811 E.02518
G1 X100.24 Y89.811 E.03895
G1 X100.24 Y96.191 E.12549
G1 X91.34 Y96.191 E.17505
G1 X91.333 Y100.825 E.09115
G1 X91.28 Y101.271 E.00883
G1 X91.174 Y101.708 E.00883
G1 X91.018 Y102.129 E.00883
G1 X90.813 Y102.529 E.00885
G1 X90.628 Y102.809 E.00659
G1 X90.422 Y103.073 E.00659
G1 X90.022 Y103.471 E.0111
G1 X89.569 Y103.808 E.01111
G1 X89.382 Y103.918 E.00426
G1 X88.976 Y104.112 E.00886
G1 X88.439 Y104.283 E.01109
G1 X87.881 Y104.376 E.01112
G1 X87.665 Y104.389 E.00426
G1 X87.214 Y104.376 E.00889
G1 X86.769 Y104.309 E.00883
G1 X86.336 Y104.191 E.00883
G1 X85.92 Y104.022 E.00883
G1 X85.529 Y103.806 E.0088
G1 X85.077 Y103.47 E.01108
G1 X84.678 Y103.073 E.01106
G1 X84.407 Y102.718 E.00879
G1 X84.179 Y102.331 E.00883
G1 X83.997 Y101.919 E.00885
G1 X83.896 Y101.6 E.00659
G1 X83.82 Y101.272 E.00662
G1 X83.767 Y100.825 E.00886
G1 X83.76 Y96.191 E.09115
G1 X81.449 Y96.188 E.04545
G1 X81.134 Y96.141 E.00626
G1 X80.938 Y96.083 E.00403
G1 X80.747 Y96 E.00409
G1 X80.567 Y95.896 E.00409
G1 X80.4 Y95.772 E.00409
G1 X80.248 Y95.629 E.00409
G1 X80.116 Y95.472 E.00403
G1 X79.95 Y95.201 E.00625
G1 X79.868 Y95.013 E.00403
G1 X79.809 Y94.814 E.00409
G1 X79.772 Y94.609 E.0041
G1 X79.76 Y94.395 E.00422
G1 X79.76 Y77.407 E.33413
G1 X79.772 Y77.193 E.00422
G1 X79.808 Y76.991 E.00403
G1 X79.908 Y76.691 E.00622
G1 X80.028 Y76.462 E.0051
G1 X80.179 Y76.252 E.00508
G1 X80.402 Y76.028 E.00621
G1 X80.564 Y75.907 E.00398
G1 X80.841 Y75.758 E.00619
G1 X81.14 Y75.659 E.00619
G1 X81.342 Y75.623 E.00403
G1 X81.556 Y75.611 E.00421
G1 X93.598 Y75.613 E.23685
G1 X93.862 Y75.639 E.00523
G1 X94.063 Y75.686 E.00406
G1 X94.259 Y75.758 E.00409
G1 X94.445 Y75.851 E.00409
G1 X94.619 Y75.965 E.00409
G1 X94.778 Y76.099 E.00409
G1 X94.919 Y76.248 E.00403
G1 X95.173 Y76.611 E.00871
G1 X97.64 Y76.611 E.04853
G1 X97.64 Y87.111 E.20653
G1 X98.64 Y87.111 E.01967
G1 X98.64 Y88.014 E.01776
G1 X97.05 Y89.604 E.04423
G1 X95.46 Y88.014 E.04423
G1 X95.46 Y87.111 E.01776
G1 X96.46 Y87.111 E.01967
G1 X96.46 Y77.791 E.18332
G1 X94.16 Y77.791 E.04524
G1 X94.159 Y77.356 E.00855
G1 X94.125 Y77.191 E.00331
G1 X94.041 Y77.035 E.00349
G1 X93.916 Y76.91 E.00349
G1 X93.759 Y76.826 E.00349
G1 X93.595 Y76.792 E.00331
G1 X81.533 Y76.791 E.23724
G1 X81.357 Y76.819 E.0035
G1 X81.183 Y76.91 E.00387
G1 X81.038 Y77.064 E.00416
G1 X80.951 Y77.265 E.00431
G1 X80.94 Y94.413 E.33728
G1 X80.955 Y94.544 E.00259
G1 X81.012 Y94.691 E.0031
G1 X81.104 Y94.819 E.0031
G1 X81.216 Y94.914 E.00289
G1 X81.374 Y94.987 E.00343
G1 X81.535 Y95.011 E.00319
G1 X93.86 Y95.001 E.24243
G1 X93.86 Y89.811 E.10209
G1 X95.84 Y89.811 E.03895
G1 X95.84 Y91.091 E.02518
G1 X94.9 Y91.091 E.01849
; WIPE_START
M204 S6000
G1 X94.84 Y93.088 E-.3796
G1 X94.842 Y93.089 E-.0004
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




G1 X94.35 Y92.887
G1 Z3.08
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.596522
G1 F1500
M204 S6000
G1 X94.35 Y90.886 E.05697
; WIPE_START
G1 X94.35 Y92.886 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X95.077 Y94.958 Z3.48 F18000
G1 Z3.08
G1 E.4 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.365752
G1 F1500
M204 S6000
G1 X95.013 Y94.995 E.00125
G1 X95.062 Y95.023 E.00095
; WIPE_START
G1 X95.013 Y94.995 E-.16436
G1 X95.077 Y94.958 E-.21564
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X99.065 Y94.958 Z3.48 F18000
G1 Z3.08
G1 E.4 F1800
G1 F1500
M204 S6000
G1 X99.002 Y94.995 E.00125
G1 X99.05 Y95.023 E.00095
; WIPE_START
G1 X99.002 Y94.995 E-.16436
G1 X99.065 Y94.958 E-.21564
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X99.75 Y92.887 Z3.48 F18000
G1 Z3.08
M73 P64 R10
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.596522
G1 F1500
M204 S6000
G1 X99.75 Y90.886 E.05697
; WIPE_START
G1 X99.75 Y92.886 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X93.217 Y96.832 Z3.48 F18000
G1 X90.186 Y98.663 Z3.48
G1 Z3.08
G1 E.4 F1800
; LINE_WIDTH: 0.0868993
G1 F1500
M204 S6000
G1 X90.257 Y98.743 E.00033
G1 X90.272 Y98.791 E.00015
M204 S10000
G1 X90.194 Y99.56 F18000
; LINE_WIDTH: 0.440733
G1 F1500
M204 S6000
G1 X90.339 Y99.642 E.00345
; LINE_WIDTH: 0.46895
G1 X90.485 Y99.723 E.00369
; LINE_WIDTH: 0.463208
G1 X90.504 Y99.925 E.00442
; LINE_WIDTH: 0.424939
G1 X90.522 Y100.117 E.00383
; LINE_WIDTH: 0.387664
G1 X90.541 Y100.308 E.00347
; LINE_WIDTH: 0.360165
G1 X90.537 Y100.86 E.0092
G1 X90.419 Y101.477 E.01049
G1 X90.293 Y101.809 E.00593
G1 X90.131 Y102.131 E.00601
G1 X89.831 Y102.549 E.00858
G1 X89.43 Y102.935 E.00929
G1 X89.134 Y103.144 E.00605
G1 X88.957 Y103.245 E.0034
G1 X88.478 Y103.448 E.00867
G1 X88.139 Y103.538 E.00586
G1 X87.784 Y103.592 E.00598
G1 X87.284 Y103.587 E.00835
G1 X86.933 Y103.533 E.00593
G1 X86.589 Y103.442 E.00593
G1 X86.038 Y103.19 E.01011
G1 X85.592 Y102.872 E.00914
G1 X85.297 Y102.578 E.00694
G1 X85.12 Y102.356 E.00474
G1 X84.855 Y101.916 E.00858
G1 X84.659 Y101.384 E.00945
G1 X84.602 Y101.132 E.0043
G1 X84.557 Y100.778 E.00596
; LINE_WIDTH: 0.372372
G1 X84.555 Y100.421 E.00617
G1 X84.579 Y100.105 E.00548
; LINE_WIDTH: 0.43323
G1 X84.602 Y99.818 E.00585
; LINE_WIDTH: 0.47565
G1 X84.659 Y99.495 E.00737
; WIPE_START
G1 X84.602 Y99.818 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X87.084 Y96.71 Z3.48 F18000
G1 Z3.08
G1 E.4 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.544282
G1 F1500
M204 S6000
G1 X87.784 Y96.7 E.01811
; LINE_WIDTH: 0.552252
G1 X87.992 Y96.716 E.00547
; LINE_WIDTH: 0.586452
G1 X88.199 Y96.731 E.00582
; LINE_WIDTH: 0.620652
G1 X88.407 Y96.747 E.00618
; WIPE_START
G1 X88.199 Y96.731 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X87.084 Y96.71 Z3.48 F18000
G1 Z3.08
G1 E.4 F1800
; LINE_WIDTH: 0.513207
G1 F1500
M204 S6000
G1 X86.388 Y96.686 E.01694
G1 X85.44 Y96.687 E.02306
G1 X85.441 Y97.339 E.01586
G1 X85.776 Y97.145 E.00943
G1 X86.285 Y96.92 E.01353
G1 X87.026 Y96.722 E.01864
; WIPE_START
G1 X86.285 Y96.92 E-.14563
G1 X85.776 Y97.145 E-.1057
G1 X85.441 Y97.339 E-.07368
G1 X85.44 Y97.05 E-.055
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X89.66 Y96.684 Z3.48 F18000
G1 Z3.08
G1 E.4 F1800
; LINE_WIDTH: 0.525485
G1 F1500
M204 S6000
G1 X89.138 Y96.705 E.01304
; LINE_WIDTH: 0.56711
G1 X88.615 Y96.726 E.01413
; LINE_WIDTH: 0.612837
G1 X88.466 Y96.751 E.00441
; LINE_WIDTH: 0.615572
G1 X88.755 Y96.883 E.00934
; LINE_WIDTH: 0.571212
G1 X89.044 Y97.015 E.00864
; LINE_WIDTH: 0.5101
G1 X89.333 Y97.146 E.00767
G1 X89.659 Y97.343 E.0092
G1 X89.66 Y96.744 E.01447
M204 S10000
G1 X90.098 Y96.247 F18000
; LINE_WIDTH: 0.419992
G1 F1500
M204 S6000
G1 X85.002 Y96.251 E.10021
G1 X85.006 Y98.283 E.03996
G1 X85.319 Y97.959 E.00887
G1 X85.815 Y97.61 E.01192
G1 X86.462 Y97.319 E.01395
G1 X87.157 Y97.165 E.014
G1 X87.791 Y97.152 E.01247
G1 X88.384 Y97.248 E.01182
G1 X89.173 Y97.553 E.01665
G1 X89.692 Y97.887 E.01213
G1 X90.051 Y98.237 E.00987
G1 X90.094 Y98.18 E.00141
G1 X90.097 Y96.307 E.03685
; CHANGE_LAYER
; Z_HEIGHT: 3.2
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F1500
G1 X90.094 Y98.18 E-.356
G1 X90.051 Y98.237 E-.01363
G1 X90.012 Y98.199 E-.01038
; WIPE_END
G1 E-.02 F1800
; layer num/total_layer_count: 26/49
; update layer progress
M73 L26
M991 S0 P25 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z3.48 I1.049 J.617 P1  F18000
G1 X94.431 Y90.682 Z3.48
G1 Z3.2
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X94.269 Y90.682 E.00342
G1 X94.269 Y90.22 E.00977
G1 X95.431 Y90.22 E.02458
G1 X95.431 Y90.682 E.00977
G1 X94.491 Y90.682 E.0199
; WIPE_START
M204 S6000
G1 X94.269 Y90.682 E-.04209
G1 X94.269 Y90.22 E-.08769
G1 X95.431 Y90.22 E-.22069
G1 X95.431 Y90.376 E-.02952
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X98.669 Y90.22 Z3.6 F18000
G1 Z3.2
G1 E.4 F1800
G1 F1500
M204 S500
G1 X99.831 Y90.22 E.02458
G1 X99.831 Y90.682 E.00977
G1 X98.669 Y90.682 E.02458
G1 X98.669 Y90.28 E.0085
; WIPE_START
M204 S6000
G1 X99.831 Y90.22 E-.22098
G1 X99.831 Y90.682 E-.08769
G1 X99.455 Y90.682 E-.07132
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X98.638 Y94.889 Z3.6 F18000
G1 Z3.2
G1 E.4 F1800
G1 F1500
M204 S500
G1 X99.407 Y94.12 E.02301
G1 X99.407 Y95.357 E.02619
G1 X98.169 Y95.357 E.02619
G1 X98.595 Y94.931 E.01276
M204 S10000
G1 X98.338 Y94.589 F18000
G1 F1500
M204 S500
G1 X99.831 Y93.096 E.04469
G1 X99.831 Y95.782 E.05685
G1 X97.145 Y95.782 E.05685
G1 X98.295 Y94.631 E.03444
; WIPE_START
M204 S6000
G1 X99.71 Y93.217 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X96.569 Y87.944 Z3.6 F18000
G1 Z3.2
G1 E.4 F1800
G1 F1500
M204 S500
G1 X97.531 Y87.944 E.02035
G1 X97.05 Y88.425 E.01439
G1 X96.612 Y87.987 E.01312
; WIPE_START
M204 S6000
G1 X97.531 Y87.944 E-.17484
G1 X97.05 Y88.425 E-.1292
G1 X96.767 Y88.143 E-.07596
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X94.693 Y94.12 Z3.6 F18000
G1 Z3.2
G1 E.4 F1800
G1 F1500
M204 S500
G1 X95.931 Y95.357 E.03704
G1 X94.693 Y95.357 E.02619
G1 X94.693 Y94.18 E.02492
; WIPE_START
M204 S6000
G1 X95.931 Y95.357 E-.32452
G1 X95.639 Y95.357 E-.05549
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X89.512 Y98.278 Z3.6 F18000
G1 Z3.2
G1 E.4 F1800
G1 F1500
M204 S500
G1 X89.45 Y98.218 E.00182
G1 X88.986 Y97.912 E.01176
G1 X88.401 Y97.674 E.01337
G1 X87.786 Y97.562 E.01323
G1 X87.232 Y97.57 E.01175
G1 X86.695 Y97.675 E.01157
G1 X86.193 Y97.873 E.01143
G1 X85.814 Y98.1 E.00935
G1 X85.565 Y98.291 E.00665
G1 X85.196 Y98.665 E.01113
G1 X84.891 Y99.112 E.01144
G1 X84.798 Y99.315 E.00474
G1 X84.598 Y99.272 E.00433
G1 X84.593 Y95.842 E.07259
G1 X90.507 Y95.837 E.12519
G1 X90.502 Y99.279 E.07285
G1 X90.304 Y99.324 E.00429
G1 X90.166 Y99.038 E.00673
G1 X89.845 Y98.596 E.01156
G1 X89.556 Y98.319 E.00847
M204 S10000
G1 X89.219 Y98.584 F18000
G1 F1500
M204 S500
G1 X89.524 Y98.876 E.00893
G1 X89.801 Y99.256 E.00995
G1 X90.005 Y99.68 E.00995
G1 X90.126 Y100.121 E.00969
G1 X90.158 Y100.363 E.00517
G1 X90.171 Y100.613 E.0053
G1 X90.13 Y101.069 E.00969
G1 X90.005 Y101.522 E.00995
G1 X89.801 Y101.946 E.00995
G1 X89.524 Y102.326 E.00994
G1 X89.188 Y102.648 E.00986
G1 X88.871 Y102.863 E.0081
G1 X88.641 Y102.984 E.00551
G1 X88.21 Y103.138 E.00969
G1 X87.755 Y103.214 E.00975
G1 X87.432 Y103.219 E.00683
G1 X87.112 Y103.185 E.00683
G1 X86.666 Y103.069 E.00975
G1 X86.239 Y102.871 E.00995
G1 X85.858 Y102.603 E.00986
G1 X85.572 Y102.32 E.00851
G1 X85.268 Y101.89 E.01115
M73 P64 R9
G1 X85.125 Y101.595 E.00695
G1 X85.021 Y101.289 E.00683
G1 X84.939 Y100.836 E.00975
G1 X84.939 Y100.366 E.00994
G1 X85.02 Y99.916 E.00968
G1 X85.1 Y99.674 E.00538
G1 X85.262 Y99.321 E.00822
G1 X85.525 Y98.936 E.00987
G1 X85.846 Y98.61 E.00969
G1 X86.053 Y98.452 E.00551
G1 X86.381 Y98.255 E.0081
G1 X86.815 Y98.084 E.00987
G1 X87.276 Y97.993 E.00995
G1 X87.751 Y97.986 E.01006
G1 X88.282 Y98.084 E.01142
G1 X88.788 Y98.289 E.01156
G1 X89.175 Y98.545 E.00981
M204 S250
G1 X88.937 Y98.88 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X89.215 Y99.146 E.00758
G1 X89.448 Y99.467 E.00779
G1 X89.62 Y99.824 E.0078
G1 X89.724 Y100.202 E.00771
G1 X89.75 Y100.4 E.00393
G1 X89.76 Y100.605 E.00404
G1 X89.725 Y100.996 E.00771
G1 X89.62 Y101.378 E.0078
G1 X89.448 Y101.735 E.0078
G1 X89.215 Y102.055 E.00779
G1 X88.929 Y102.328 E.00777
G1 X88.66 Y102.511 E.0064
G1 X88.475 Y102.608 E.00411
G1 X88.106 Y102.741 E.00771
G1 X87.718 Y102.805 E.00773
G1 X87.451 Y102.809 E.00526
G1 X87.185 Y102.781 E.00526
G1 X86.804 Y102.682 E.00773
G1 X86.445 Y102.516 E.0078
G1 X86.122 Y102.288 E.00777
G1 X85.886 Y102.055 E.00653
G1 X85.622 Y101.682 E.00898
G1 X85.505 Y101.439 E.0053
G1 X85.418 Y101.186 E.00527
G1 X85.348 Y100.799 E.00773
G1 X85.348 Y100.403 E.00779
G1 X85.418 Y100.017 E.00771
G1 X85.482 Y99.824 E.00399
G1 X85.62 Y99.523 E.00651
G1 X85.842 Y99.197 E.00777
G1 X86.118 Y98.917 E.00772
G1 X86.283 Y98.791 E.00411
G1 X86.562 Y98.623 E.0064
G1 X86.93 Y98.479 E.00777
G1 X87.319 Y98.402 E.0078
G1 X87.717 Y98.396 E.00783
G1 X88.167 Y98.479 E.009
G1 X88.596 Y98.653 E.00911
G1 X88.888 Y98.845 E.00687
; WIPE_START
M204 S6000
G1 X89.215 Y99.146 E-.08446
G1 X89.448 Y99.467 E-.07529
G1 X89.62 Y99.824 E-.07532
G1 X89.724 Y100.202 E-.07451
G1 X89.75 Y100.4 E-.03792
G1 X89.759 Y100.571 E-.0325
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X93.062 Y93.69 Z3.6 F18000
G1 X95.869 Y87.844 Z3.6
G1 Z3.2
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X95.869 Y87.52 E.00686
G1 X96.869 Y87.52 E.02117
G1 X96.869 Y77.382 E.21459
G1 X94.582 Y77.382 E.0484
G1 X94.514 Y77.05 E.00717
G1 X94.373 Y76.788 E.00629
G1 X94.163 Y76.578 E.00629
G1 X93.901 Y76.437 E.00629
G1 X93.637 Y76.382 E.00571
G1 X81.496 Y76.382 E.25697
G1 X81.202 Y76.433 E.00631
G1 X80.912 Y76.596 E.00703
G1 X80.689 Y76.84 E.007
G1 X80.542 Y77.181 E.00786
G1 X80.531 Y94.446 E.36543
G1 X80.566 Y94.686 E.00514
G1 X80.678 Y94.946 E.006
G1 X80.961 Y95.246 E.00872
G1 X81.256 Y95.384 E.00688
G1 X81.505 Y95.42 E.00534
G1 X94.269 Y95.41 E.27016
G1 X94.269 Y93.096 E.04898
G1 X96.955 Y95.782 E.08039
G1 X90.932 Y95.782 E.12749
G1 X90.924 Y100.801 E.10623
G1 X90.876 Y101.199 E.00848
G1 X90.782 Y101.588 E.00848
G1 X90.643 Y101.963 E.00847
G1 X90.46 Y102.32 E.00848
G1 X90.236 Y102.652 E.00848
G1 X89.969 Y102.962 E.00867
G1 X89.513 Y103.353 E.01271
G1 X89.19 Y103.557 E.00809
G1 X88.82 Y103.733 E.00866
G1 X88.441 Y103.861 E.00848
G1 X88.04 Y103.945 E.00867
G1 X87.659 Y103.979 E.00809
G1 X87.25 Y103.967 E.00866
G1 X86.854 Y103.908 E.00848
G1 X86.468 Y103.803 E.00848
G1 X86.096 Y103.652 E.00847
G1 X85.751 Y103.461 E.00835
G1 X85.341 Y103.156 E.01081
G1 X84.987 Y102.803 E.01059
G1 X84.747 Y102.489 E.00836
G1 X84.543 Y102.144 E.00848
G1 X84.384 Y101.783 E.00836
G1 X84.246 Y101.302 E.01059
G1 X84.176 Y100.795 E.01083
G1 X84.168 Y95.783 E.10609
G1 X81.479 Y95.778 E.05691
G1 X81.223 Y95.741 E.00548
G1 X80.931 Y95.634 E.00659
G1 X80.792 Y95.554 E.0034
G1 X80.546 Y95.348 E.00678
G1 X80.336 Y95.053 E.00767
G1 X80.207 Y94.719 E.00757
G1 X80.169 Y94.383 E.00716
G1 X80.169 Y77.419 E.35906
G1 X80.206 Y77.092 E.00697
G1 X80.284 Y76.855 E.00528
G1 X80.398 Y76.643 E.00508
G1 X80.553 Y76.448 E.00528
G1 X80.663 Y76.344 E.0032
G1 X80.785 Y76.254 E.00321
G1 X81.012 Y76.131 E.00547
G1 X81.146 Y76.082 E.00301
G1 X81.399 Y76.03 E.00547
G1 X93.58 Y76.022 E.25782
G1 X93.795 Y76.043 E.00457
G1 X93.946 Y76.079 E.00329
G1 X94.24 Y76.206 E.00678
G1 X94.374 Y76.294 E.0034
G1 X94.601 Y76.507 E.00659
G1 X94.96 Y77.02 E.01325
G1 X97.231 Y77.02 E.04807
G1 X97.231 Y87.52 E.22224
G1 X98.231 Y87.52 E.02117
G1 X98.231 Y87.844 E.00686
G1 X97.05 Y89.025 E.03534
G1 X95.912 Y87.887 E.03407
; WIPE_START
M204 S6000
G1 X95.869 Y87.52 E-.07014
G1 X96.869 Y87.52 E-.19
G1 X96.869 Y86.889 E-.11986
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X94.84 Y91.091 Z3.6 F18000
G1 Z3.2
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X94.84 Y93.088 E.03928
G1 X97.05 Y95.298 E.06147
G1 X99.26 Y93.088 E.06147
G1 X99.26 Y91.091 E.03928
G1 X98.26 Y91.091 E.01967
G1 X98.26 Y89.811 E.02518
G1 X100.24 Y89.811 E.03895
G1 X100.24 Y96.191 E.12549
G1 X91.34 Y96.191 E.17505
G1 X91.333 Y100.825 E.09115
G1 X91.28 Y101.271 E.00883
G1 X91.174 Y101.708 E.00883
G1 X91.018 Y102.129 E.00883
M73 P65 R9
G1 X90.813 Y102.528 E.00883
G1 X90.562 Y102.9 E.00883
G1 X90.267 Y103.243 E.00889
G1 X90.11 Y103.395 E.0043
G1 X89.757 Y103.682 E.00895
G1 X89.573 Y103.806 E.00436
G1 X89.382 Y103.918 E.00436
G1 X88.974 Y104.113 E.00889
G1 X88.549 Y104.256 E.00883
G1 X88.107 Y104.35 E.00889
G1 X87.886 Y104.376 E.00436
G1 X87.665 Y104.389 E.00436
G1 X87.214 Y104.376 E.00889
G1 X86.769 Y104.309 E.00883
G1 X86.336 Y104.191 E.00883
G1 X85.92 Y104.022 E.00883
G1 X85.529 Y103.806 E.00879
G1 X85.073 Y103.467 E.01117
G1 X84.678 Y103.073 E.01096
G1 X84.407 Y102.718 E.00879
G1 X84.179 Y102.331 E.00883
G1 X83.998 Y101.922 E.0088
G1 X83.845 Y101.386 E.01096
G1 X83.767 Y100.823 E.01118
G1 X83.76 Y96.191 E.09111
G1 X81.449 Y96.188 E.04545
G1 X81.134 Y96.141 E.00626
G1 X80.938 Y96.083 E.00403
G1 X80.747 Y96 E.00409
G1 X80.567 Y95.896 E.0041
G1 X80.4 Y95.772 E.00409
G1 X80.248 Y95.629 E.00409
G1 X80.116 Y95.471 E.00406
G1 X79.974 Y95.248 E.0052
G1 X79.868 Y95.011 E.0051
G1 X79.809 Y94.814 E.00406
G1 X79.772 Y94.609 E.00409
G1 X79.76 Y94.395 E.00422
G1 X79.76 Y77.407 E.33413
G1 X79.772 Y77.193 E.00422
G1 X79.808 Y76.991 E.00404
G1 X79.907 Y76.692 E.00619
G1 X80.055 Y76.418 E.00613
G1 X80.251 Y76.171 E.0062
G1 X80.4 Y76.03 E.00403
G1 X80.564 Y75.907 E.00404
G1 X80.844 Y75.757 E.00625
G1 X81.034 Y75.687 E.00397
G1 X81.345 Y75.623 E.00626
G1 X81.556 Y75.611 E.00415
G1 X93.6 Y75.613 E.2369
G1 X93.862 Y75.639 E.00518
G1 X94.063 Y75.686 E.00406
G1 X94.259 Y75.758 E.00409
G1 X94.445 Y75.851 E.00409
G1 X94.619 Y75.965 E.0041
G1 X94.778 Y76.099 E.00409
G1 X94.919 Y76.248 E.00403
G1 X95.173 Y76.611 E.00871
G1 X97.64 Y76.611 E.04853
G1 X97.64 Y87.111 E.20653
G1 X98.64 Y87.111 E.01967
G1 X98.64 Y88.014 E.01776
G1 X97.05 Y89.604 E.04423
G1 X95.46 Y88.014 E.04423
G1 X95.46 Y87.111 E.01776
G1 X96.46 Y87.111 E.01967
G1 X96.46 Y77.791 E.18332
G1 X94.16 Y77.791 E.04524
G1 X94.159 Y77.356 E.00855
G1 X94.125 Y77.192 E.00331
G1 X94.041 Y77.035 E.00349
G1 X93.916 Y76.91 E.00349
G1 X93.759 Y76.826 E.00349
G1 X93.595 Y76.792 E.00331
G1 X81.532 Y76.791 E.23727
G1 X81.342 Y76.824 E.00379
G1 X81.17 Y76.921 E.00388
G1 X81.037 Y77.065 E.00385
G1 X80.951 Y77.265 E.00428
G1 X80.94 Y94.416 E.33734
G1 X80.963 Y94.573 E.00313
G1 X81.025 Y94.718 E.0031
G1 X81.205 Y94.908 E.00514
G1 X81.374 Y94.987 E.00368
G1 X81.535 Y95.011 E.00319
G1 X93.86 Y95.001 E.24243
G1 X93.86 Y89.811 E.10209
G1 X95.84 Y89.811 E.03895
G1 X95.84 Y91.091 E.02518
G1 X94.9 Y91.091 E.01849
; WIPE_START
M204 S6000
G1 X94.84 Y93.088 E-.3796
G1 X94.842 Y93.089 E-.0004
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




G1 X94.35 Y92.887
G1 Z3.2
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.596522
G1 F1500
M204 S6000
G1 X94.35 Y90.886 E.05697
; WIPE_START
G1 X94.35 Y92.886 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X95.077 Y94.958 Z3.6 F18000
G1 Z3.2
G1 E.4 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.365752
G1 F1500
M204 S6000
G1 X95.013 Y94.995 E.00125
G1 X95.062 Y95.023 E.00095
; WIPE_START
G1 X95.013 Y94.995 E-.16436
G1 X95.077 Y94.958 E-.21564
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X99.065 Y94.958 Z3.6 F18000
G1 Z3.2
G1 E.4 F1800
G1 F1500
M204 S6000
G1 X99.002 Y94.995 E.00125
G1 X99.05 Y95.023 E.00095
; WIPE_START
G1 X99.002 Y94.995 E-.16436
G1 X99.065 Y94.958 E-.21564
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X99.75 Y92.887 Z3.6 F18000
G1 Z3.2
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.596522
G1 F1500
M204 S6000
G1 X99.75 Y90.886 E.05697
; WIPE_START
G1 X99.75 Y92.886 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X93.217 Y96.832 Z3.6 F18000
G1 X90.186 Y98.663 Z3.6
G1 Z3.2
G1 E.4 F1800
; LINE_WIDTH: 0.086895
G1 F1500
M204 S6000
G1 X90.257 Y98.743 E.00033
G1 X90.272 Y98.791 E.00015
M204 S10000
G1 X90.447 Y99.509 F18000
; LINE_WIDTH: 0.472484
G1 F1500
M204 S6000
G1 X90.483 Y99.767 E.0058
; LINE_WIDTH: 0.431922
G1 X90.52 Y100.025 E.00527
; LINE_WIDTH: 0.389924
G1 X90.54 Y100.321 E.0054
; LINE_WIDTH: 0.360413
G1 X90.547 Y100.632 E.00519
G1 X90.505 Y101.122 E.00821
G1 X90.415 Y101.476 E.0061
G1 X90.292 Y101.809 E.00593
G1 X90.134 Y102.127 E.00593
G1 X89.817 Y102.562 E.00899
G1 X89.693 Y102.695 E.00303
G1 X89.283 Y103.046 E.00901
G1 X89.073 Y103.181 E.00418
G1 X88.802 Y103.322 E.0051
G1 X88.319 Y103.5 E.00859
G1 X87.777 Y103.591 E.00918
G1 X87.284 Y103.587 E.00823
G1 X86.933 Y103.533 E.00593
G1 X86.589 Y103.442 E.00593
G1 X86.038 Y103.19 E.01012
G1 X85.589 Y102.869 E.00921
G1 X85.272 Y102.552 E.00748
G1 X85.067 Y102.274 E.00578
G1 X84.883 Y101.97 E.00593
G1 X84.743 Y101.653 E.00579
G1 X84.656 Y101.372 E.00491
G1 X84.557 Y100.768 E.01021
; LINE_WIDTH: 0.373561
G1 X84.557 Y100.347 E.00731
G1 X84.58 Y100.071 E.00481
; LINE_WIDTH: 0.434553
G1 X84.602 Y99.825 E.00503
; LINE_WIDTH: 0.474551
G1 X84.655 Y99.501 E.00734
; WIPE_START
G1 X84.602 Y99.825 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X87.095 Y96.71 Z3.6 F18000
G1 Z3.2
G1 E.4 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.543809
G1 F1500
M204 S6000
G1 X87.862 Y96.703 E.01982
M204 S10000
G1 X87.095 Y96.71 F18000
; LINE_WIDTH: 0.540137
G1 F1500
M204 S6000
G1 X86.796 Y96.697 E.00768
; LINE_WIDTH: 0.501992
G1 X85.438 Y96.685 E.03228
G1 X85.439 Y97.362 E.01609
G1 X85.868 Y97.094 E.01203
G1 X86.405 Y96.883 E.0137
; LINE_WIDTH: 0.513432
G1 X86.721 Y96.803 E.00793
; LINE_WIDTH: 0.538832
G1 X87.037 Y96.723 E.00834
; WIPE_START
G1 X86.721 Y96.803 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X89.662 Y96.682 Z3.6 F18000
G1 Z3.2
G1 E.4 F1800
; LINE_WIDTH: 0.508998
G1 F1500
M204 S6000
G1 X88.59 Y96.683 E.02584
G1 X87.922 Y96.706 E.01611
G1 X88.575 Y96.847 E.01611
G1 X89.324 Y97.138 E.01937
G1 X89.661 Y97.345 E.00953
G1 X89.661 Y96.742 E.01453
M204 S10000
G1 X90.098 Y96.247 F18000
; LINE_WIDTH: 0.419992
G1 F1500
M204 S6000
G1 X85.002 Y96.251 E.10021
G1 X85.006 Y98.275 E.03982
G1 X85.315 Y97.967 E.00858
G1 X85.99 Y97.518 E.01595
G1 X86.564 Y97.288 E.01216
G1 X87.171 Y97.165 E.01219
G1 X87.801 Y97.152 E.01239
G1 X88.496 Y97.275 E.01389
G1 X89.16 Y97.541 E.01406
G1 X89.692 Y97.887 E.01248
G1 X90.051 Y98.237 E.00987
G1 X90.094 Y98.181 E.00141
G1 X90.097 Y96.307 E.03685
; CHANGE_LAYER
; Z_HEIGHT: 3.32
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F1500
G1 X90.094 Y98.181 E-.35601
G1 X90.051 Y98.237 E-.01362
G1 X90.012 Y98.199 E-.01037
; WIPE_END
G1 E-.02 F1800
; layer num/total_layer_count: 27/49
; update layer progress
M73 L27
M991 S0 P26 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z3.6 I1.049 J.617 P1  F18000
G1 X94.431 Y90.682 Z3.6
G1 Z3.32
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X94.269 Y90.682 E.00342
G1 X94.269 Y90.22 E.00977
G1 X95.431 Y90.22 E.02458
G1 X95.431 Y90.682 E.00977
G1 X94.491 Y90.682 E.0199
; WIPE_START
M204 S6000
G1 X94.269 Y90.682 E-.04209
G1 X94.269 Y90.22 E-.08769
G1 X95.431 Y90.22 E-.22069
G1 X95.431 Y90.376 E-.02952
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X98.669 Y90.22 Z3.72 F18000
G1 Z3.32
G1 E.4 F1800
G1 F1500
M204 S500
G1 X99.831 Y90.22 E.02458
G1 X99.831 Y90.682 E.00977
G1 X98.669 Y90.682 E.02458
G1 X98.669 Y90.28 E.0085
; WIPE_START
M204 S6000
G1 X99.831 Y90.22 E-.22098
G1 X99.831 Y90.682 E-.08769
G1 X99.455 Y90.682 E-.07132
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X98.638 Y94.889 Z3.72 F18000
G1 Z3.32
G1 E.4 F1800
G1 F1500
M204 S500
G1 X99.407 Y94.12 E.02301
G1 X99.407 Y95.357 E.02619
G1 X98.169 Y95.357 E.02619
G1 X98.595 Y94.931 E.01276
M204 S10000
G1 X98.338 Y94.589 F18000
G1 F1500
M204 S500
G1 X99.831 Y93.096 E.04469
G1 X99.831 Y95.782 E.05685
G1 X97.145 Y95.782 E.05685
G1 X98.295 Y94.631 E.03444
; WIPE_START
M204 S6000
G1 X99.71 Y93.217 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X96.569 Y87.944 Z3.72 F18000
G1 Z3.32
G1 E.4 F1800
G1 F1500
M204 S500
G1 X97.531 Y87.944 E.02035
G1 X97.05 Y88.425 E.01439
G1 X96.612 Y87.987 E.01312
; WIPE_START
M204 S6000
G1 X97.531 Y87.944 E-.17484
G1 X97.05 Y88.425 E-.1292
G1 X96.767 Y88.143 E-.07596
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X94.693 Y94.12 Z3.72 F18000
G1 Z3.32
G1 E.4 F1800
G1 F1500
M204 S500
G1 X95.931 Y95.357 E.03704
G1 X94.693 Y95.357 E.02619
G1 X94.693 Y94.18 E.02492
; WIPE_START
M204 S6000
G1 X95.931 Y95.357 E-.32452
G1 X95.639 Y95.357 E-.05549
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X89.46 Y98.241 Z3.72 F18000
G1 Z3.32
G1 E.4 F1800
G1 F1500
M204 S500
G1 X89.316 Y98.119 E.004
G1 X88.993 Y97.919 E.00804
G1 X88.648 Y97.759 E.00804
G1 X88.13 Y97.608 E.01143
G1 X87.498 Y97.553 E.01343
G1 X86.88 Y97.627 E.01318
G1 X86.344 Y97.801 E.01191
G1 X85.801 Y98.105 E.01318
G1 X85.322 Y98.52 E.01342
G1 X84.976 Y98.968 E.01198
G1 X84.794 Y99.333 E.00864
G1 X84.598 Y99.288 E.00427
G1 X84.593 Y95.842 E.07293
G1 X90.507 Y95.837 E.12519
G1 X90.502 Y99.284 E.07295
G1 X90.309 Y99.332 E.0042
G1 X90.074 Y98.892 E.01057
G1 X89.721 Y98.462 E.01177
G1 X89.506 Y98.28 E.00596
M204 S10000
G1 X89.186 Y98.565 F18000
G1 F1500
M204 S500
G1 X89.418 Y98.761 E.00643
G1 X89.72 Y99.128 E.01007
G1 X89.978 Y99.612 E.01161
G1 X90.129 Y100.128 E.01137
G1 X90.172 Y100.601 E.01005
G1 X90.13 Y101.069 E.00995
G1 X90.007 Y101.513 E.00975
G1 X89.876 Y101.808 E.00683
G1 X89.71 Y102.085 E.00683
G1 X89.418 Y102.441 E.00975
G1 X89.056 Y102.748 E.01005
G1 X88.586 Y103.009 E.01138
G1 X88.062 Y103.173 E.01161
G1 X87.584 Y103.223 E.01018
G1 X87.049 Y103.174 E.01137
G1 X86.525 Y103.014 E.01161
G1 X86.106 Y102.789 E.01007
G1 X85.745 Y102.502 E.00975
G1 X85.526 Y102.265 E.00683
G1 X85.336 Y102.004 E.00683
G1 X85.124 Y101.595 E.00975
G1 X84.986 Y101.146 E.00995
G1 X84.929 Y100.679 E.00995
M73 P66 R9
G1 X84.958 Y100.205 E.01005
G1 X85.093 Y99.685 E.01137
G1 X85.337 Y99.194 E.0116
G1 X85.632 Y98.813 E.01019
G1 X86.046 Y98.454 E.01161
G1 X86.515 Y98.192 E.01137
G1 X86.971 Y98.043 E.01015
G1 X87.505 Y97.98 E.01137
G1 X88.051 Y98.027 E.01161
G1 X88.499 Y98.158 E.00987
G1 X88.792 Y98.293 E.00683
G1 X89.066 Y98.463 E.00683
G1 X89.14 Y98.526 E.00206
M204 S250
G1 X88.921 Y98.877 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X89.125 Y99.049 E.00525
G1 X89.378 Y99.357 E.00783
G1 X89.597 Y99.768 E.00916
G1 X89.725 Y100.205 E.00895
G1 X89.761 Y100.601 E.00783
G1 X89.725 Y100.996 E.00779
G1 X89.621 Y101.375 E.00773
G1 X89.512 Y101.619 E.00526
G1 X89.375 Y101.849 E.00526
G1 X89.125 Y102.152 E.00773
G1 X88.821 Y102.41 E.00783
G1 X88.424 Y102.631 E.00895
G1 X87.979 Y102.77 E.00916
G1 X87.581 Y102.812 E.00787
G1 X87.128 Y102.77 E.00895
G1 X86.683 Y102.635 E.00916
G1 X86.332 Y102.446 E.00784
G1 X86.025 Y102.201 E.00773
G1 X85.843 Y102.005 E.00526
G1 X85.685 Y101.788 E.00526
G1 X85.504 Y101.439 E.00773
G1 X85.387 Y101.061 E.0078
G1 X85.34 Y100.667 E.0078
G1 X85.364 Y100.27 E.00783
G1 X85.479 Y99.829 E.00895
G1 X85.686 Y99.412 E.00916
G1 X85.93 Y99.096 E.00787
G1 X86.282 Y98.79 E.00916
G1 X86.679 Y98.568 E.00895
G1 X87.06 Y98.445 E.00786
G1 X87.511 Y98.391 E.00895
G1 X87.975 Y98.431 E.00916
G1 X88.355 Y98.542 E.00777
G1 X88.597 Y98.654 E.00526
G1 X88.825 Y98.795 E.00526
G1 X88.876 Y98.838 E.00131
; WIPE_START
M204 S6000
G1 X89.125 Y99.049 E-.06209
G1 X89.378 Y99.357 E-.07568
G1 X89.597 Y99.768 E-.08847
G1 X89.725 Y100.205 E-.08648
G1 X89.757 Y100.557 E-.06728
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X93.064 Y93.679 Z3.72 F18000
G1 X95.869 Y87.844 Z3.72
G1 Z3.32
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X95.869 Y87.52 E.00686
G1 X96.869 Y87.52 E.02117
G1 X96.869 Y77.382 E.21459
G1 X94.582 Y77.382 E.0484
G1 X94.514 Y77.05 E.00717
G1 X94.373 Y76.788 E.00629
G1 X94.162 Y76.578 E.0063
G1 X93.901 Y76.437 E.00629
G1 X93.637 Y76.382 E.00571
G1 X81.5 Y76.382 E.25689
G1 X81.225 Y76.427 E.00588
G1 X80.932 Y76.579 E.00699
G1 X80.69 Y76.836 E.00746
G1 X80.542 Y77.181 E.00795
G1 X80.531 Y94.437 E.36524
G1 X80.555 Y94.642 E.00438
G1 X80.649 Y94.889 E.00558
G1 X80.802 Y95.1 E.00552
G1 X80.995 Y95.262 E.00533
G1 X81.256 Y95.384 E.0061
G1 X81.505 Y95.42 E.00533
G1 X94.269 Y95.41 E.27016
G1 X94.269 Y93.096 E.04898
G1 X96.955 Y95.782 E.08039
G1 X90.932 Y95.782 E.12749
G1 X90.924 Y100.801 E.10623
G1 X90.876 Y101.199 E.00848
G1 X90.782 Y101.588 E.00848
G1 X90.643 Y101.963 E.00848
G1 X90.459 Y102.323 E.00855
G1 X90.116 Y102.8 E.01245
G1 X89.748 Y103.166 E.01097
G1 X89.342 Y103.467 E.01069
G1 X89.19 Y103.557 E.00374
G1 X88.82 Y103.733 E.00867
G1 X88.255 Y103.907 E.01251
G1 X87.659 Y103.979 E.01271
G1 X87.25 Y103.967 E.00867
G1 X86.854 Y103.908 E.00848
G1 X86.468 Y103.803 E.00848
G1 X86.097 Y103.652 E.00847
G1 X85.751 Y103.462 E.00835
G1 X85.338 Y103.153 E.01091
G1 X84.987 Y102.803 E.01049
G1 X84.747 Y102.489 E.00837
G1 X84.543 Y102.144 E.00848
G1 X84.38 Y101.774 E.00855
G1 X84.224 Y101.201 E.01257
G1 X84.176 Y100.801 E.00854
G1 X84.168 Y95.783 E.10621
G1 X81.479 Y95.778 E.05691
G1 X81.223 Y95.741 E.00548
G1 X80.931 Y95.634 E.00659
G1 X80.792 Y95.554 E.0034
G1 X80.546 Y95.348 E.00678
G1 X80.449 Y95.232 E.00321
G1 X80.313 Y95.012 E.00547
G1 X80.208 Y94.719 E.00659
G1 X80.169 Y94.383 E.00716
G1 X80.169 Y77.419 E.35906
G1 X80.206 Y77.092 E.00697
G1 X80.284 Y76.855 E.00527
G1 X80.403 Y76.635 E.00528
G1 X80.488 Y76.521 E.00301
G1 X80.666 Y76.343 E.00535
G1 X80.83 Y76.225 E.00426
G1 X81.008 Y76.132 E.00426
G1 X81.146 Y76.082 E.0031
G1 X81.399 Y76.03 E.00547
G1 X93.582 Y76.022 E.25787
G1 X93.946 Y76.079 E.00779
G1 X94.24 Y76.206 E.00678
G1 X94.374 Y76.294 E.0034
G1 X94.49 Y76.391 E.0032
G1 X94.662 Y76.585 E.00547
G1 X94.948 Y77.02 E.01103
G1 X97.231 Y77.02 E.04831
G1 X97.231 Y87.52 E.22224
G1 X98.231 Y87.52 E.02117
G1 X98.231 Y87.844 E.00686
G1 X97.05 Y89.025 E.03534
G1 X95.912 Y87.887 E.03407
; WIPE_START
M204 S6000
G1 X95.869 Y87.52 E-.07014
G1 X96.869 Y87.52 E-.19
G1 X96.869 Y86.889 E-.11986
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X94.84 Y91.091 Z3.72 F18000
G1 Z3.32
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X94.84 Y93.088 E.03928
G1 X97.05 Y95.298 E.06147
G1 X99.26 Y93.088 E.06147
G1 X99.26 Y91.091 E.03928
G1 X98.26 Y91.091 E.01967
G1 X98.26 Y89.811 E.02518
G1 X100.24 Y89.811 E.03895
G1 X100.24 Y96.191 E.12549
G1 X91.34 Y96.191 E.17505
G1 X91.333 Y100.825 E.09115
G1 X91.28 Y101.271 E.00883
G1 X91.174 Y101.708 E.00883
G1 X91.018 Y102.129 E.00883
G1 X90.813 Y102.529 E.00885
G1 X90.634 Y102.801 E.00641
G1 X90.423 Y103.073 E.00676
G1 X90.015 Y103.477 E.01129
G1 X89.569 Y103.808 E.01093
G1 X89.382 Y103.918 E.00426
G1 X88.974 Y104.113 E.00889
G1 X88.546 Y104.257 E.00889
G1 X88.334 Y104.309 E.0043
G1 X87.883 Y104.376 E.00896
G1 X87.665 Y104.389 E.00429
G1 X87.214 Y104.376 E.00889
G1 X86.769 Y104.309 E.00883
G1 X86.336 Y104.191 E.00883
G1 X85.92 Y104.022 E.00883
G1 X85.529 Y103.806 E.0088
G1 X85.07 Y103.464 E.01127
G1 X84.678 Y103.074 E.01087
G1 X84.407 Y102.718 E.0088
G1 X84.179 Y102.331 E.00883
G1 X83.997 Y101.919 E.00886
G1 X83.899 Y101.609 E.0064
G1 X83.82 Y101.272 E.0068
G1 X83.767 Y100.825 E.00885
G1 X83.76 Y96.191 E.09115
G1 X81.449 Y96.188 E.04545
G1 X81.134 Y96.141 E.00626
G1 X80.938 Y96.083 E.00403
G1 X80.747 Y96 E.00409
G1 X80.567 Y95.896 E.00409
G1 X80.4 Y95.772 E.00409
G1 X80.248 Y95.629 E.00409
G1 X80.116 Y95.472 E.00403
G1 X79.949 Y95.201 E.00625
G1 X79.868 Y95.013 E.00404
G1 X79.809 Y94.814 E.00409
G1 X79.772 Y94.609 E.00409
G1 X79.76 Y94.395 E.00422
G1 X79.76 Y77.407 E.33413
G1 X79.772 Y77.193 E.00422
G1 X79.808 Y76.991 E.00404
G1 X79.907 Y76.692 E.00619
G1 X80.057 Y76.415 E.0062
G1 X80.177 Y76.253 E.00397
G1 X80.401 Y76.03 E.00622
G1 X80.615 Y75.876 E.00519
G1 X80.843 Y75.757 E.00506
G1 X81.034 Y75.687 E.004
G1 X81.345 Y75.623 E.00626
G1 X81.556 Y75.611 E.00415
G1 X93.603 Y75.613 E.23694
G1 X93.862 Y75.639 E.00513
G1 X94.063 Y75.686 E.00406
G1 X94.259 Y75.758 E.00409
G1 X94.445 Y75.851 E.00409
G1 X94.619 Y75.965 E.0041
G1 X94.776 Y76.097 E.00403
G1 X94.987 Y76.335 E.00626
G1 X95.169 Y76.611 E.0065
G1 X97.64 Y76.611 E.04861
G1 X97.64 Y87.111 E.20653
G1 X98.64 Y87.111 E.01967
G1 X98.64 Y88.014 E.01776
G1 X97.05 Y89.604 E.04423
G1 X95.46 Y88.014 E.04423
G1 X95.46 Y87.111 E.01776
G1 X96.46 Y87.111 E.01967
G1 X96.46 Y77.791 E.18332
G1 X94.16 Y77.791 E.04524
G1 X94.159 Y77.356 E.00855
G1 X94.125 Y77.191 E.00331
G1 X94.041 Y77.035 E.00349
G1 X93.916 Y76.91 E.00349
G1 X93.759 Y76.826 E.00349
G1 X93.595 Y76.792 E.0033
G1 X81.533 Y76.791 E.23725
G1 X81.356 Y76.82 E.00352
G1 X81.183 Y76.91 E.00385
G1 X81.038 Y77.064 E.00415
G1 X80.951 Y77.265 E.00431
G1 X80.94 Y94.413 E.33728
G1 X80.955 Y94.544 E.00259
G1 X81.012 Y94.692 E.00313
G1 X81.104 Y94.819 E.00308
G1 X81.216 Y94.914 E.00289
G1 X81.374 Y94.987 E.00343
G1 X81.535 Y95.011 E.00319
G1 X93.86 Y95.001 E.24243
G1 X93.86 Y89.811 E.10209
G1 X95.84 Y89.811 E.03895
G1 X95.84 Y91.091 E.02518
G1 X94.9 Y91.091 E.01849
; WIPE_START
M204 S6000
G1 X94.84 Y93.088 E-.3796
G1 X94.842 Y93.089 E-.0004
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




G1 X94.35 Y92.887
G1 Z3.32
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.596522
G1 F1500
M204 S6000
G1 X94.35 Y90.886 E.05697
; WIPE_START
G1 X94.35 Y92.886 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X95.077 Y94.958 Z3.72 F18000
G1 Z3.32
G1 E.4 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.365752
G1 F1500
M204 S6000
G1 X95.013 Y94.995 E.00125
G1 X95.062 Y95.023 E.00095
; WIPE_START
G1 X95.013 Y94.995 E-.16436
G1 X95.077 Y94.958 E-.21564
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X99.065 Y94.958 Z3.72 F18000
G1 Z3.32
G1 E.4 F1800
G1 F1500
M204 S6000
G1 X99.002 Y94.995 E.00125
G1 X99.05 Y95.023 E.00095
; WIPE_START
G1 X99.002 Y94.995 E-.16436
G1 X99.065 Y94.958 E-.21564
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X99.75 Y92.887 Z3.72 F18000
G1 Z3.32
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.596522
G1 F1500
M204 S6000
G1 X99.75 Y90.886 E.05697
; WIPE_START
G1 X99.75 Y92.886 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X93.259 Y96.901 Z3.72 F18000
G1 X90.291 Y98.737 Z3.72
G1 Z3.32
G1 E.4 F1800
; LINE_WIDTH: 0.100039
G1 F1500
M204 S6000
G1 X90.066 Y98.508 E.00119
; WIPE_START
G1 X90.291 Y98.737 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X90.448 Y99.516 Z3.72 F18000
G1 Z3.32
G1 E.4 F1800
; LINE_WIDTH: 0.469904
G1 F1500
M204 S6000
G1 X90.485 Y99.775 E.0058
; LINE_WIDTH: 0.428495
G1 X90.522 Y100.034 E.00526
; LINE_WIDTH: 0.40428
G1 X90.525 Y100.071 E.0007
; LINE_WIDTH: 0.377247
G1 X90.548 Y100.586 E.00904
; LINE_WIDTH: 0.361514
G1 X90.503 Y101.132 E.00917
G1 X90.415 Y101.476 E.00595
G1 X90.293 Y101.809 E.00595
G1 X90.128 Y102.13 E.00604
G1 X90.012 Y102.313 E.00363
G1 X89.674 Y102.713 E.00879
G1 X89.256 Y103.065 E.00915
G1 X89.008 Y103.216 E.00485
G1 X88.677 Y103.379 E.00619
G1 X88.123 Y103.544 E.00969
G1 X87.648 Y103.599 E.008
G1 X87.284 Y103.583 E.0061
G1 X86.932 Y103.536 E.00595
M73 P67 R9
G1 X86.591 Y103.437 E.00595
G1 X86.261 Y103.307 E.00594
G1 X85.911 Y103.111 E.00672
G1 X85.588 Y102.864 E.00681
G1 X85.24 Y102.513 E.00828
G1 X85.022 Y102.213 E.00622
G1 X84.885 Y101.969 E.00469
G1 X84.739 Y101.643 E.00598
G1 X84.622 Y101.238 E.00705
G1 X84.553 Y100.705 E.009
G1 X84.567 Y100.161 E.00912
; LINE_WIDTH: 0.406014
G1 X84.598 Y99.922 E.00458
; LINE_WIDTH: 0.442705
G1 X84.624 Y99.72 E.00423
; LINE_WIDTH: 0.476283
G1 X84.651 Y99.518 E.00458
M204 S10000
G1 X84.809 Y98.752 F18000
; LINE_WIDTH: 0.0976619
G1 F1500
M204 S6000
G1 X84.997 Y98.553 E.00098
; WIPE_START
G1 X84.809 Y98.752 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X86.714 Y96.741 Z3.72 F18000
G1 Z3.32
G1 E.4 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.593197
G1 F1500
M204 S6000
G1 X87.066 Y96.72 E.00997
; LINE_WIDTH: 0.55616
G1 X87.418 Y96.698 E.00932
G1 X88.167 Y96.724 E.01985
; WIPE_START
G1 X87.418 Y96.698 E-.25857
G1 X87.066 Y96.72 E-.12143
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X86.714 Y96.741 Z3.72 F18000
G1 Z3.32
G1 E.4 F1800
; LINE_WIDTH: 0.596161
G1 F1500
M204 S6000
G1 X86.481 Y96.723 E.00667
; LINE_WIDTH: 0.559977
G1 X86.247 Y96.705 E.00625
; LINE_WIDTH: 0.507784
G1 X86.013 Y96.687 E.00564
G1 X85.44 Y96.688 E.01377
G1 X85.441 Y97.336 E.01559
G1 X85.95 Y97.052 E.014
; LINE_WIDTH: 0.526212
G1 X86.287 Y96.914 E.00911
; LINE_WIDTH: 0.567232
G1 X86.625 Y96.777 E.00985
; LINE_WIDTH: 0.600997
G1 X86.659 Y96.763 E.00104
; WIPE_START
G1 X86.625 Y96.777 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X89.656 Y96.688 Z3.72 F18000
G1 Z3.32
G1 E.4 F1800
; LINE_WIDTH: 0.523391
G1 F1500
M204 S6000
G1 X88.939 Y96.688 E.01781
G1 X88.362 Y96.713 E.01434
; LINE_WIDTH: 0.553661
G1 X88.227 Y96.726 E.00356
G1 X88.902 Y96.948 E.01871
; LINE_WIDTH: 0.512362
G1 X89.655 Y97.338 E.02059
G1 X89.656 Y96.748 E.01433
M204 S10000
G1 X90.098 Y96.247 F18000
; LINE_WIDTH: 0.419992
G1 F1500
M204 S6000
G1 X85.002 Y96.251 E.10021
G1 X85.005 Y98.064 E.03567
G1 X85.089 Y98.077 E.00166
G1 X85.146 Y98.131 E.00155
G1 X85.549 Y97.781 E.01049
G1 X86.198 Y97.418 E.01463
G1 X86.773 Y97.231 E.01189
G1 X87.471 Y97.144 E.01384
G1 X88.186 Y97.202 E.01411
G1 X88.778 Y97.371 E.01211
G1 X89.534 Y97.773 E.01684
G1 X89.905 Y98.092 E.00962
G1 X90.003 Y98.004 E.00259
G1 X90.095 Y98.016 E.00182
G1 X90.097 Y96.307 E.03361
; CHANGE_LAYER
; Z_HEIGHT: 3.44
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F1500
G1 X90.095 Y98.016 E-.32468
G1 X90.003 Y98.004 E-.01762
G1 X89.905 Y98.092 E-.025
G1 X89.854 Y98.048 E-.01271
; WIPE_END
G1 E-.02 F1800
; layer num/total_layer_count: 28/49
; update layer progress
M73 L28
M991 S0 P27 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z3.72 I1.034 J.642 P1  F18000
G1 X94.431 Y90.682 Z3.72
G1 Z3.44
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X94.269 Y90.682 E.00342
G1 X94.269 Y90.22 E.00977
G1 X95.431 Y90.22 E.02458
G1 X95.431 Y90.682 E.00977
G1 X94.491 Y90.682 E.0199
; WIPE_START
M204 S6000
G1 X94.269 Y90.682 E-.04209
G1 X94.269 Y90.22 E-.08769
G1 X95.431 Y90.22 E-.22069
G1 X95.431 Y90.376 E-.02952
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X98.669 Y90.22 Z3.84 F18000
G1 Z3.44
G1 E.4 F1800
G1 F1500
M204 S500
G1 X99.831 Y90.22 E.02458
G1 X99.831 Y90.682 E.00977
G1 X98.669 Y90.682 E.02458
G1 X98.669 Y90.28 E.0085
; WIPE_START
M204 S6000
G1 X99.831 Y90.22 E-.22098
G1 X99.831 Y90.682 E-.08769
G1 X99.455 Y90.682 E-.07132
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X98.638 Y94.889 Z3.84 F18000
G1 Z3.44
G1 E.4 F1800
G1 F1500
M204 S500
G1 X99.407 Y94.12 E.02301
G1 X99.407 Y95.357 E.02619
G1 X98.169 Y95.357 E.02619
G1 X98.595 Y94.931 E.01276
M204 S10000
G1 X98.338 Y94.589 F18000
G1 F1500
M204 S500
G1 X99.831 Y93.096 E.04469
G1 X99.831 Y95.782 E.05685
G1 X97.145 Y95.782 E.05685
G1 X98.295 Y94.631 E.03444
; WIPE_START
M204 S6000
G1 X99.71 Y93.217 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X96.569 Y87.944 Z3.84 F18000
G1 Z3.44
G1 E.4 F1800
G1 F1500
M204 S500
G1 X97.531 Y87.944 E.02035
G1 X97.05 Y88.425 E.01439
G1 X96.612 Y87.987 E.01312
; WIPE_START
M204 S6000
G1 X97.531 Y87.944 E-.17484
G1 X97.05 Y88.425 E-.1292
G1 X96.767 Y88.143 E-.07596
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X94.693 Y94.12 Z3.84 F18000
G1 Z3.44
G1 E.4 F1800
G1 F1500
M204 S500
G1 X95.931 Y95.357 E.03704
G1 X94.693 Y95.357 E.02619
G1 X94.693 Y94.18 E.02492
; WIPE_START
M204 S6000
G1 X95.931 Y95.357 E-.32452
G1 X95.639 Y95.357 E-.05549
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X89.453 Y98.235 Z3.84 F18000
G1 Z3.44
G1 E.4 F1800
G1 F1500
M204 S500
G1 X89.316 Y98.119 E.00379
G1 X88.993 Y97.919 E.00804
G1 X88.648 Y97.759 E.00804
G1 X88.129 Y97.608 E.01144
G1 X87.495 Y97.553 E.01348
G1 X86.879 Y97.627 E.01312
G1 X86.352 Y97.798 E.01173
G1 X85.885 Y98.05 E.01123
G1 X85.581 Y98.278 E.00804
G1 X85.306 Y98.54 E.00804
G1 X84.982 Y98.96 E.01123
G1 X84.792 Y99.325 E.00871
G1 X84.598 Y99.278 E.00423
G1 X84.593 Y95.842 E.07273
G1 X90.507 Y95.837 E.12519
G1 X90.502 Y99.262 E.07249
G1 X90.301 Y99.305 E.00436
G1 X90.058 Y98.872 E.0105
G1 X89.721 Y98.462 E.01123
G1 X89.499 Y98.274 E.00617
M204 S10000
G1 X89.179 Y98.558 F18000
G1 F1500
M204 S500
G1 X89.418 Y98.761 E.00663
G1 X89.71 Y99.117 E.00975
G1 X89.876 Y99.394 E.00683
G1 X90.007 Y99.689 E.00683
G1 X90.13 Y100.133 E.00975
G1 X90.172 Y100.601 E.00995
G1 X90.13 Y101.069 E.00995
G1 X90.003 Y101.527 E.01005
G1 X89.764 Y102.005 E.01132
G1 X89.422 Y102.437 E.01166
G1 X89.055 Y102.748 E.01018
G1 X88.588 Y103.008 E.01131
G1 X88.063 Y103.173 E.01166
G1 X87.589 Y103.222 E.01008
G1 X87.121 Y103.187 E.00995
G1 X86.666 Y103.069 E.00995
G1 X86.248 Y102.875 E.00975
G1 X85.978 Y102.698 E.00683
G1 X85.732 Y102.489 E.00683
G1 X85.429 Y102.142 E.00975
G1 X85.188 Y101.739 E.00994
G1 X85.026 Y101.307 E.00975
G1 X84.959 Y100.991 E.00683
G1 X84.931 Y100.679 E.00663
G1 X84.94 Y100.366 E.00663
G1 X84.988 Y100.047 E.00683
G1 X85.124 Y99.607 E.00975
G1 X85.341 Y99.189 E.00995
G1 X85.622 Y98.825 E.00975
G1 X85.856 Y98.602 E.00683
G1 X86.114 Y98.408 E.00683
G1 X86.52 Y98.19 E.00975
G1 X86.971 Y98.043 E.01004
G1 X87.502 Y97.98 E.01132
G1 X88.051 Y98.027 E.01166
G1 X88.499 Y98.158 E.00987
G1 X88.792 Y98.293 E.00683
G1 X89.066 Y98.463 E.00683
G1 X89.133 Y98.52 E.00185
M204 S250
G1 X88.914 Y98.871 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X89.125 Y99.049 E.00544
G1 X89.375 Y99.353 E.00773
G1 X89.512 Y99.583 E.00526
G1 X89.621 Y99.827 E.00526
G1 X89.725 Y100.206 E.00773
G1 X89.761 Y100.601 E.0078
G1 X89.725 Y100.996 E.00779
G1 X89.619 Y101.379 E.00783
G1 X89.417 Y101.784 E.0089
G1 X89.126 Y102.151 E.00921
G1 X88.821 Y102.41 E.00787
G1 X88.426 Y102.63 E.0089
G1 X87.979 Y102.77 E.00921
G1 X87.583 Y102.811 E.00784
G1 X87.188 Y102.782 E.00779
G1 X86.804 Y102.682 E.0078
G1 X86.447 Y102.517 E.00773
G1 X86.224 Y102.37 E.00526
G1 X86.02 Y102.197 E.00526
G1 X85.761 Y101.9 E.00774
G1 X85.558 Y101.56 E.00779
G1 X85.42 Y101.192 E.00774
G1 X85.364 Y100.93 E.00526
G1 X85.341 Y100.667 E.0052
G1 X85.349 Y100.403 E.0052
G1 X85.388 Y100.138 E.00526
G1 X85.504 Y99.762 E.00773
G1 X85.687 Y99.411 E.0078
G1 X85.927 Y99.1 E.00773
G1 X86.121 Y98.915 E.00526
G1 X86.335 Y98.754 E.00526
G1 X86.681 Y98.568 E.00774
G1 X87.059 Y98.445 E.00782
G1 X87.509 Y98.391 E.0089
G1 X87.975 Y98.431 E.00921
G1 X88.355 Y98.542 E.00777
G1 X88.597 Y98.654 E.00526
G1 X88.825 Y98.795 E.00526
G1 X88.868 Y98.832 E.00112
; WIPE_START
M204 S6000
G1 X89.125 Y99.049 E-.06394
G1 X89.375 Y99.353 E-.07471
G1 X89.512 Y99.583 E-.05083
G1 X89.621 Y99.827 E-.05083
G1 X89.725 Y100.206 E-.07472
G1 X89.756 Y100.547 E-.06497
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X93.066 Y93.669 Z3.84 F18000
G1 X95.869 Y87.844 Z3.84
G1 Z3.44
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X95.869 Y87.52 E.00686
G1 X96.869 Y87.52 E.02117
G1 X96.869 Y77.382 E.21459
G1 X94.582 Y77.382 E.0484
G1 X94.514 Y77.05 E.00717
G1 X94.373 Y76.788 E.00629
G1 X94.163 Y76.578 E.0063
G1 X93.901 Y76.437 E.00629
G1 X93.637 Y76.382 E.00571
G1 X81.496 Y76.382 E.25697
G1 X81.202 Y76.433 E.00632
G1 X80.911 Y76.597 E.00706
G1 X80.688 Y76.84 E.00697
G1 X80.542 Y77.181 E.00785
G1 X80.531 Y94.437 E.36524
G1 X80.555 Y94.646 E.00446
G1 X80.672 Y94.94 E.00669
G1 X80.961 Y95.246 E.00892
G1 X81.256 Y95.384 E.00688
G1 X81.505 Y95.42 E.00533
G1 X94.269 Y95.41 E.27016
G1 X94.269 Y93.096 E.04898
G1 X96.955 Y95.782 E.08039
G1 X90.932 Y95.782 E.12749
G1 X90.924 Y100.801 E.10623
G1 X90.876 Y101.199 E.00848
G1 X90.782 Y101.588 E.00848
G1 X90.643 Y101.963 E.00848
G1 X90.456 Y102.328 E.00867
G1 X90.11 Y102.807 E.01251
G1 X89.829 Y103.097 E.00856
G1 X89.611 Y103.278 E.00598
G1 X89.19 Y103.557 E.0107
G1 X88.826 Y103.73 E.00853
G1 X88.33 Y103.887 E.01101
G1 X87.836 Y103.969 E.01059
G1 X87.25 Y103.967 E.0124
G1 X86.854 Y103.908 E.00848
G1 X86.468 Y103.803 E.00848
G1 X86.097 Y103.652 E.00847
G1 X85.751 Y103.462 E.00835
G1 X85.335 Y103.15 E.01101
G1 X84.987 Y102.803 E.0104
G1 X84.747 Y102.489 E.00837
G1 X84.543 Y102.144 E.00848
G1 X84.38 Y101.774 E.00855
G1 X84.224 Y101.201 E.01257
G1 X84.176 Y100.801 E.00854
G1 X84.168 Y95.783 E.10621
G1 X81.479 Y95.778 E.05691
G1 X81.223 Y95.741 E.00548
G1 X80.931 Y95.634 E.00659
G1 X80.792 Y95.554 E.00339
G1 X80.546 Y95.348 E.00678
G1 X80.36 Y95.098 E.00659
G1 X80.251 Y94.864 E.00547
G1 X80.207 Y94.719 E.00321
G1 X80.169 Y94.383 E.00716
G1 X80.169 Y77.419 E.35906
G1 X80.207 Y77.083 E.00716
G1 X80.251 Y76.938 E.0032
G1 X80.356 Y76.712 E.00528
G1 X80.496 Y76.512 E.00515
G1 X80.638 Y76.367 E.00431
G1 X80.789 Y76.251 E.00402
G1 X81.012 Y76.131 E.00537
G1 X81.146 Y76.082 E.00301
G1 X81.399 Y76.03 E.00547
G1 X93.584 Y76.022 E.25791
G1 X93.946 Y76.079 E.00774
G1 X94.096 Y76.134 E.0034
G1 X94.369 Y76.291 E.00666
G1 X94.529 Y76.431 E.0045
G1 X94.659 Y76.581 E.00421
G1 X94.948 Y77.02 E.01112
G1 X97.231 Y77.02 E.04831
G1 X97.231 Y87.52 E.22224
G1 X98.231 Y87.52 E.02117
G1 X98.231 Y87.844 E.00686
G1 X97.05 Y89.025 E.03534
G1 X95.912 Y87.887 E.03407
; WIPE_START
M204 S6000
G1 X95.869 Y87.52 E-.07014
G1 X96.869 Y87.52 E-.19
G1 X96.869 Y86.889 E-.11986
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X94.84 Y91.091 Z3.84 F18000
G1 Z3.44
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X94.84 Y93.088 E.03928
G1 X97.05 Y95.298 E.06147
G1 X99.26 Y93.088 E.06147
G1 X99.26 Y91.091 E.03928
G1 X98.26 Y91.091 E.01967
G1 X98.26 Y89.811 E.02518
G1 X100.24 Y89.811 E.03895
G1 X100.24 Y96.191 E.12549
G1 X91.34 Y96.191 E.17505
G1 X91.333 Y100.825 E.09115
G1 X91.28 Y101.271 E.00883
G1 X91.174 Y101.708 E.00883
G1 X91.018 Y102.129 E.00883
G1 X90.812 Y102.531 E.00889
G1 X90.695 Y102.715 E.0043
G1 X90.421 Y103.075 E.00889
G1 X90.107 Y103.398 E.00886
G1 X89.86 Y103.603 E.00631
G1 X89.571 Y103.807 E.00696
G1 X89.382 Y103.918 E.00432
G1 X88.976 Y104.112 E.00885
G1 X88.425 Y104.286 E.01136
G1 X87.882 Y104.376 E.01084
G1 X87.665 Y104.389 E.00426
G1 X87.214 Y104.376 E.00889
G1 X86.769 Y104.309 E.00883
G1 X86.336 Y104.191 E.00883
G1 X85.92 Y104.022 E.00883
G1 X85.529 Y103.806 E.00879
G1 X85.066 Y103.461 E.01136
G1 X84.678 Y103.074 E.01078
G1 X84.407 Y102.718 E.0088
G1 X84.179 Y102.331 E.00883
G1 X83.997 Y101.919 E.00886
G1 X83.9 Y101.614 E.00631
G1 X83.82 Y101.272 E.0069
G1 X83.767 Y100.825 E.00885
G1 X83.76 Y96.191 E.09115
G1 X81.449 Y96.188 E.04545
G1 X81.134 Y96.141 E.00626
G1 X80.938 Y96.083 E.00403
G1 X80.747 Y96 E.00409
G1 X80.567 Y95.896 E.00409
G1 X80.4 Y95.772 E.00409
G1 X80.248 Y95.629 E.0041
G1 X80.115 Y95.47 E.00409
G1 X80.002 Y95.298 E.00404
G1 X79.867 Y95.01 E.00625
G1 X79.809 Y94.814 E.00403
G1 X79.772 Y94.609 E.00409
G1 X79.76 Y94.395 E.00422
G1 X79.76 Y77.407 E.33413
G1 X79.772 Y77.193 E.00422
G1 X79.809 Y76.988 E.00409
G1 X79.867 Y76.792 E.00403
G1 X80.001 Y76.506 E.0062
G1 X80.18 Y76.25 E.00616
G1 X80.366 Y76.06 E.00523
G1 X80.565 Y75.907 E.00495
G1 X80.844 Y75.757 E.00622
G1 X81.034 Y75.687 E.00397
G1 X81.345 Y75.623 E.00626
G1 X81.556 Y75.611 E.00415
G1 X93.605 Y75.613 E.23699
G1 X93.862 Y75.639 E.00509
G1 X94.063 Y75.686 E.00406
G1 X94.259 Y75.758 E.00409
G1 X94.445 Y75.851 E.00409
G1 X94.617 Y75.964 E.00405
G1 X94.82 Y76.141 E.00529
M73 P68 R9
G1 X94.986 Y76.334 E.00501
G1 X95.169 Y76.611 E.00653
G1 X97.64 Y76.611 E.04861
G1 X97.64 Y87.111 E.20653
G1 X98.64 Y87.111 E.01967
G1 X98.64 Y88.014 E.01776
G1 X97.05 Y89.604 E.04423
G1 X95.46 Y88.014 E.04423
G1 X95.46 Y87.111 E.01776
G1 X96.46 Y87.111 E.01967
G1 X96.46 Y77.791 E.18332
G1 X94.16 Y77.791 E.04524
G1 X94.159 Y77.356 E.00855
G1 X94.125 Y77.191 E.00331
G1 X94.041 Y77.035 E.00349
G1 X93.916 Y76.91 E.00349
G1 X93.759 Y76.826 E.00349
G1 X93.595 Y76.792 E.0033
G1 X81.532 Y76.791 E.23727
G1 X81.342 Y76.824 E.0038
G1 X81.169 Y76.922 E.0039
G1 X81.037 Y77.065 E.00384
M73 P68 R8
G1 X80.951 Y77.265 E.00428
G1 X80.94 Y94.413 E.33728
G1 X80.955 Y94.545 E.00261
G1 X81.023 Y94.716 E.00361
G1 X81.205 Y94.908 E.00521
G1 X81.375 Y94.987 E.00368
G1 X81.535 Y95.011 E.00319
G1 X93.86 Y95.001 E.24243
G1 X93.86 Y89.811 E.10209
G1 X95.84 Y89.811 E.03895
G1 X95.84 Y91.091 E.02518
G1 X94.9 Y91.091 E.01849
; WIPE_START
M204 S6000
G1 X94.84 Y93.088 E-.3796
G1 X94.842 Y93.089 E-.0004
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




G1 X94.35 Y92.887
G1 Z3.44
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.596522
G1 F1500
M204 S6000
G1 X94.35 Y90.886 E.05697
; WIPE_START
G1 X94.35 Y92.886 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X95.077 Y94.958 Z3.84 F18000
G1 Z3.44
G1 E.4 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.365752
G1 F1500
M204 S6000
G1 X95.013 Y94.995 E.00125
G1 X95.062 Y95.023 E.00095
; WIPE_START
G1 X95.013 Y94.995 E-.16436
G1 X95.077 Y94.958 E-.21564
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X99.065 Y94.958 Z3.84 F18000
G1 Z3.44
G1 E.4 F1800
G1 F1500
M204 S6000
G1 X99.002 Y94.995 E.00125
G1 X99.05 Y95.023 E.00095
; WIPE_START
G1 X99.002 Y94.995 E-.16436
G1 X99.065 Y94.958 E-.21564
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X99.75 Y92.887 Z3.84 F18000
G1 Z3.44
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.596522
G1 F1500
M204 S6000
G1 X99.75 Y90.886 E.05697
; WIPE_START
G1 X99.75 Y92.886 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X93.26 Y96.903 Z3.84 F18000
G1 X90.291 Y98.741 Z3.84
G1 Z3.44
G1 E.4 F1800
; LINE_WIDTH: 0.102295
G1 F1500
M204 S6000
G1 X90.066 Y98.508 E.00123
; WIPE_START
G1 X90.291 Y98.741 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X90.443 Y99.492 Z3.84 F18000
G1 Z3.44
G1 E.4 F1800
; LINE_WIDTH: 0.476265
G1 F1500
M204 S6000
G1 X90.482 Y99.766 E.00623
; LINE_WIDTH: 0.430341
G1 X90.522 Y100.04 E.0056
; LINE_WIDTH: 0.403777
G1 X90.526 Y100.078 E.00071
; LINE_WIDTH: 0.376954
G1 X90.548 Y100.586 E.00891
; LINE_WIDTH: 0.361244
G1 X90.503 Y101.132 E.00916
G1 X90.415 Y101.476 E.00595
G1 X90.291 Y101.808 E.00594
G1 X90.072 Y102.22 E.00781
G1 X89.817 Y102.557 E.00707
G1 X89.568 Y102.816 E.006
G1 X89.256 Y103.065 E.00669
G1 X89.004 Y103.218 E.00492
G1 X88.686 Y103.376 E.00595
G1 X88.123 Y103.542 E.00983
G1 X87.654 Y103.598 E.00791
G1 X87.284 Y103.584 E.00619
G1 X86.933 Y103.533 E.00594
G1 X86.589 Y103.442 E.00595
G1 X86.053 Y103.198 E.00986
G1 X85.584 Y102.862 E.00966
G1 X85.276 Y102.55 E.00734
G1 X85.133 Y102.375 E.00378
G1 X84.855 Y101.916 E.00899
G1 X84.664 Y101.4 E.00919
G1 X84.599 Y101.132 E.00462
G1 X84.557 Y100.778 E.00597
G1 X84.572 Y100.146 E.01058
; LINE_WIDTH: 0.408568
G1 X84.585 Y99.97 E.00337
; LINE_WIDTH: 0.441565
G1 X84.621 Y99.725 E.00514
; LINE_WIDTH: 0.474133
G1 X84.653 Y99.51 E.00487
M204 S10000
G1 X84.828 Y98.783 F18000
; LINE_WIDTH: 0.0867393
G1 F1500
M204 S6000
G1 X84.843 Y98.737 E.00015
G1 X84.924 Y98.647 E.00037
; WIPE_START
G1 X84.843 Y98.737 E-.27086
G1 X84.828 Y98.783 E-.10914
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X86.714 Y96.741 Z3.84 F18000
G1 Z3.44
G1 E.4 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.593282
G1 F1500
M204 S6000
G1 X87.064 Y96.72 E.00993
; LINE_WIDTH: 0.556149
G1 X87.414 Y96.698 E.00928
G1 X88.167 Y96.724 E.01992
; WIPE_START
G1 X87.414 Y96.698 E-.25923
G1 X87.064 Y96.72 E-.12077
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X86.714 Y96.741 Z3.84 F18000
G1 Z3.44
G1 E.4 F1800
; LINE_WIDTH: 0.596169
G1 F1500
M204 S6000
G1 X86.484 Y96.723 E.00658
; LINE_WIDTH: 0.559802
G1 X86.253 Y96.705 E.00616
; LINE_WIDTH: 0.507292
G1 X86.023 Y96.687 E.00555
G1 X85.44 Y96.687 E.014
G1 X85.441 Y97.332 E.01549
G1 X85.968 Y97.044 E.01443
; LINE_WIDTH: 0.525865
G1 X86.296 Y96.911 E.00885
; LINE_WIDTH: 0.56709
G1 X86.625 Y96.777 E.00958
; LINE_WIDTH: 0.601027
G1 X86.658 Y96.763 E.00104
; WIPE_START
G1 X86.625 Y96.777 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X89.656 Y96.688 Z3.84 F18000
G1 Z3.44
G1 E.4 F1800
; LINE_WIDTH: 0.523356
G1 F1500
M204 S6000
G1 X88.939 Y96.688 E.01781
G1 X88.361 Y96.713 E.01435
; LINE_WIDTH: 0.553571
G1 X88.227 Y96.726 E.00357
G1 X88.902 Y96.948 E.01872
; LINE_WIDTH: 0.512362
G1 X89.655 Y97.338 E.02059
G1 X89.656 Y96.748 E.01433
M204 S10000
G1 X90.098 Y96.247 F18000
; LINE_WIDTH: 0.419992
G1 F1500
M204 S6000
G1 X85.002 Y96.251 E.10021
G1 X85.006 Y98.172 E.03779
G1 X85.057 Y98.217 E.00134
G1 X85.643 Y97.72 E.0151
G1 X86.175 Y97.429 E.01193
G1 X86.773 Y97.232 E.01238
G1 X87.468 Y97.144 E.01378
G1 X88.186 Y97.202 E.01416
G1 X88.778 Y97.371 E.01213
G1 X89.535 Y97.773 E.01684
G1 X89.906 Y98.093 E.00965
G1 X90.005 Y98.004 E.00261
G1 X90.095 Y98.016 E.00178
G1 X90.097 Y96.307 E.03362
; CHANGE_LAYER
; Z_HEIGHT: 3.56
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F1500
G1 X90.095 Y98.016 E-.32473
G1 X90.005 Y98.004 E-.01722
G1 X89.906 Y98.093 E-.02518
G1 X89.855 Y98.049 E-.01287
; WIPE_END
G1 E-.02 F1800
; layer num/total_layer_count: 29/49
; update layer progress
M73 L29
M991 S0 P28 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z3.84 I1.034 J.642 P1  F18000
G1 X94.431 Y90.682 Z3.84
G1 Z3.56
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X94.269 Y90.682 E.00342
G1 X94.269 Y90.22 E.00977
G1 X95.431 Y90.22 E.02458
G1 X95.431 Y90.682 E.00977
G1 X94.491 Y90.682 E.0199
; WIPE_START
M204 S6000
G1 X94.269 Y90.682 E-.04209
G1 X94.269 Y90.22 E-.08769
G1 X95.431 Y90.22 E-.22069
G1 X95.431 Y90.376 E-.02952
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X98.669 Y90.22 Z3.96 F18000
G1 Z3.56
G1 E.4 F1800
G1 F1500
M204 S500
G1 X99.831 Y90.22 E.02458
G1 X99.831 Y90.682 E.00977
G1 X98.669 Y90.682 E.02458
G1 X98.669 Y90.28 E.0085
; WIPE_START
M204 S6000
G1 X99.831 Y90.22 E-.22098
G1 X99.831 Y90.682 E-.08769
G1 X99.455 Y90.682 E-.07132
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X98.638 Y94.889 Z3.96 F18000
G1 Z3.56
G1 E.4 F1800
G1 F1500
M204 S500
G1 X99.407 Y94.12 E.02301
G1 X99.407 Y95.357 E.02619
G1 X98.169 Y95.357 E.02619
G1 X98.595 Y94.931 E.01276
M204 S10000
G1 X98.338 Y94.589 F18000
G1 F1500
M204 S500
G1 X99.831 Y93.096 E.04469
G1 X99.831 Y95.782 E.05685
G1 X97.145 Y95.782 E.05685
G1 X98.295 Y94.631 E.03444
; WIPE_START
M204 S6000
G1 X99.71 Y93.217 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X96.569 Y87.944 Z3.96 F18000
G1 Z3.56
G1 E.4 F1800
G1 F1500
M204 S500
G1 X97.531 Y87.944 E.02035
G1 X97.05 Y88.425 E.01439
G1 X96.612 Y87.987 E.01312
; WIPE_START
M204 S6000
G1 X97.531 Y87.944 E-.17484
G1 X97.05 Y88.425 E-.1292
G1 X96.767 Y88.143 E-.07596
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X94.693 Y94.12 Z3.96 F18000
G1 Z3.56
G1 E.4 F1800
G1 F1500
M204 S500
G1 X95.931 Y95.357 E.03704
G1 X94.693 Y95.357 E.02619
G1 X94.693 Y94.18 E.02492
; WIPE_START
M204 S6000
G1 X95.931 Y95.357 E-.32452
G1 X95.639 Y95.357 E-.05549
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X89.393 Y98.181 Z3.96 F18000
G1 Z3.56
G1 E.4 F1800
G1 F1500
M204 S500
G1 X89.138 Y98.001 E.00659
G1 X88.663 Y97.764 E.01123
G1 X88.129 Y97.608 E.01178
G1 X87.492 Y97.553 E.01354
G1 X86.879 Y97.627 E.01306
G1 X86.345 Y97.801 E.01189
G1 X85.806 Y98.101 E.01306
G1 X85.322 Y98.52 E.01354
G1 X84.975 Y98.968 E.012
G1 X84.795 Y99.334 E.00863
G1 X84.598 Y99.288 E.00427
G1 X84.593 Y95.842 E.07294
G1 X90.507 Y95.837 E.12519
G1 X90.502 Y99.271 E.07269
G1 X90.312 Y99.321 E.00416
G1 X90.068 Y98.884 E.01058
G1 X89.731 Y98.474 E.01123
G1 X89.449 Y98.22 E.00804
G1 X89.442 Y98.215 E.00018
M204 S10000
G1 X89.149 Y98.527 F18000
G1 F1500
M204 S500
G1 X89.184 Y98.552 E.00091
G1 X89.424 Y98.768 E.00683
G1 X89.716 Y99.124 E.00975
G1 X89.947 Y99.539 E.01005
G1 X90.112 Y100.045 E.01126
G1 X90.172 Y100.595 E.01172
G1 X90.13 Y101.069 E.01008
G1 X90.005 Y101.522 E.00995
G1 X89.805 Y101.937 E.00975
G1 X89.623 Y102.204 E.00683
G1 X89.411 Y102.447 E.00683
G1 X89.056 Y102.748 E.00985
G1 X88.591 Y103.007 E.01126
G1 X88.063 Y103.173 E.01171
G1 X87.589 Y103.222 E.01008
G1 X87.121 Y103.187 E.00995
G1 X86.66 Y103.067 E.01008
G1 X86.162 Y102.825 E.01171
G1 X85.741 Y102.499 E.01127
G1 X85.429 Y102.142 E.01004
G1 X85.188 Y101.738 E.00995
G1 X85.026 Y101.307 E.00975
G1 X84.959 Y100.991 E.00683
G1 X84.93 Y100.67 E.00683
G1 X84.958 Y100.206 E.00985
G1 X85.092 Y99.69 E.01126
G1 X85.337 Y99.194 E.01172
G1 X85.632 Y98.813 E.0102
G1 X86.05 Y98.451 E.01172
G1 X86.515 Y98.191 E.01127
G1 X86.971 Y98.043 E.01014
G1 X87.499 Y97.98 E.01126
G1 X88.051 Y98.027 E.01172
G1 X88.508 Y98.16 E.01008
G1 X88.92 Y98.367 E.00975
G1 X89.099 Y98.493 E.00465
M204 S250
G1 X88.913 Y98.862 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X88.928 Y98.873 E.00037
G1 X89.127 Y99.052 E.00526
G1 X89.377 Y99.355 E.00773
G1 X89.57 Y99.703 E.00783
G1 X89.71 Y100.131 E.00885
G1 X89.761 Y100.599 E.00926
G1 X89.725 Y100.996 E.00784
G1 X89.62 Y101.378 E.0078
G1 X89.449 Y101.732 E.00773
G1 X89.299 Y101.953 E.00526
G1 X89.123 Y102.154 E.00526
G1 X88.821 Y102.41 E.00777
G1 X88.428 Y102.629 E.00885
G1 X87.979 Y102.77 E.00925
G1 X87.583 Y102.811 E.00784
G1 X87.188 Y102.782 E.00779
G1 X86.802 Y102.682 E.00784
G1 X86.379 Y102.476 E.00925
G1 X86.023 Y102.2 E.00886
G1 X85.761 Y101.9 E.00783
G1 X85.558 Y101.56 E.0078
G1 X85.42 Y101.192 E.00773
G1 X85.364 Y100.93 E.00526
G1 X85.34 Y100.664 E.00526
G1 X85.364 Y100.27 E.00777
G1 X85.477 Y99.834 E.00885
G1 X85.686 Y99.412 E.00925
G1 X85.931 Y99.096 E.00788
G1 X86.286 Y98.788 E.00926
G1 X86.68 Y98.568 E.00886
G1 X87.059 Y98.445 E.00785
G1 X87.506 Y98.391 E.00886
G1 X87.975 Y98.431 E.00926
G1 X88.358 Y98.543 E.00784
G1 X88.709 Y98.719 E.00773
G1 X88.864 Y98.828 E.00372
; WIPE_START
M204 S6000
G1 X88.928 Y98.873 E-.01494
G1 X89.127 Y99.052 E-.05082
G1 X89.377 Y99.355 E-.07471
G1 X89.57 Y99.703 E-.07561
G1 X89.71 Y100.131 E-.08552
G1 X89.755 Y100.541 E-.0784
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X93.066 Y93.665 Z3.96 F18000
G1 X95.869 Y87.844 Z3.96
G1 Z3.56
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X95.869 Y87.52 E.00686
G1 X96.869 Y87.52 E.02117
M73 P69 R8
G1 X96.869 Y77.382 E.21459
G1 X94.582 Y77.382 E.0484
G1 X94.514 Y77.05 E.00717
G1 X94.373 Y76.788 E.0063
G1 X94.163 Y76.578 E.00629
G1 X93.901 Y76.437 E.00629
G1 X93.637 Y76.382 E.00571
G1 X81.499 Y76.382 E.2569
G1 X81.224 Y76.427 E.00591
G1 X80.932 Y76.579 E.00696
G1 X80.69 Y76.836 E.00746
G1 X80.542 Y77.181 E.00795
G1 X80.531 Y94.441 E.36533
G1 X80.56 Y94.663 E.00473
G1 X80.674 Y94.942 E.00639
G1 X80.961 Y95.246 E.00885
G1 X81.256 Y95.384 E.00688
G1 X81.505 Y95.42 E.00534
G1 X94.269 Y95.41 E.27016
G1 X94.269 Y93.096 E.04898
G1 X96.955 Y95.782 E.08039
G1 X90.932 Y95.782 E.12749
G1 X90.924 Y100.801 E.10623
G1 X90.876 Y101.199 E.00849
G1 X90.782 Y101.588 E.00848
G1 X90.643 Y101.963 E.00848
G1 X90.458 Y102.323 E.00856
G1 X90.116 Y102.801 E.01244
G1 X89.741 Y103.171 E.01116
G1 X89.343 Y103.466 E.01049
G1 X89.19 Y103.557 E.00376
G1 X88.826 Y103.73 E.00853
G1 X88.326 Y103.888 E.01111
G1 X87.836 Y103.969 E.0105
G1 X87.25 Y103.967 E.01241
G1 X86.854 Y103.908 E.00848
G1 X86.468 Y103.803 E.00848
G1 X86.097 Y103.652 E.00847
G1 X85.751 Y103.462 E.00835
G1 X85.331 Y103.147 E.0111
G1 X84.987 Y102.803 E.0103
G1 X84.747 Y102.489 E.00837
G1 X84.543 Y102.144 E.00847
G1 X84.384 Y101.782 E.00837
G1 X84.249 Y101.314 E.0103
G1 X84.176 Y100.794 E.01112
G1 X84.168 Y95.783 E.10608
G1 X81.479 Y95.778 E.05691
G1 X81.223 Y95.741 E.00548
G1 X80.931 Y95.634 E.00659
G1 X80.792 Y95.554 E.00339
G1 X80.546 Y95.348 E.00678
G1 X80.36 Y95.098 E.00659
G1 X80.251 Y94.864 E.00547
G1 X80.207 Y94.719 E.00321
G1 X80.169 Y94.383 E.00716
G1 X80.169 Y77.419 E.35906
G1 X80.206 Y77.092 E.00697
G1 X80.287 Y76.846 E.00547
G1 X80.351 Y76.719 E.00302
G1 X80.496 Y76.513 E.00534
G1 X80.64 Y76.366 E.00435
G1 X80.789 Y76.251 E.00397
G1 X81.004 Y76.135 E.00518
G1 X81.241 Y76.057 E.00528
G1 X81.39 Y76.03 E.00321
G1 X93.586 Y76.022 E.25815
G1 X93.794 Y76.043 E.00442
G1 X94.096 Y76.134 E.00668
G1 X94.234 Y76.203 E.00327
G1 X94.411 Y76.325 E.00455
G1 X94.657 Y76.577 E.00745
G1 X94.948 Y77.02 E.01122
G1 X97.231 Y77.02 E.04831
G1 X97.231 Y87.52 E.22224
G1 X98.231 Y87.52 E.02117
G1 X98.231 Y87.844 E.00686
G1 X97.05 Y89.025 E.03534
G1 X95.912 Y87.887 E.03407
; WIPE_START
M204 S6000
G1 X95.869 Y87.52 E-.07014
G1 X96.869 Y87.52 E-.19
G1 X96.869 Y86.889 E-.11986
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X94.84 Y91.091 Z3.96 F18000
G1 Z3.56
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X94.84 Y93.088 E.03928
G1 X97.05 Y95.298 E.06147
G1 X99.26 Y93.088 E.06147
G1 X99.26 Y91.091 E.03928
G1 X98.26 Y91.091 E.01967
G1 X98.26 Y89.811 E.02518
G1 X100.24 Y89.811 E.03895
G1 X100.24 Y96.191 E.12549
G1 X91.34 Y96.191 E.17505
G1 X91.333 Y100.825 E.09115
G1 X91.28 Y101.271 E.00884
G1 X91.174 Y101.708 E.00883
G1 X91.018 Y102.129 E.00883
G1 X90.812 Y102.529 E.00886
G1 X90.639 Y102.794 E.00622
G1 X90.423 Y103.073 E.00695
G1 X90.008 Y103.483 E.01147
G1 X89.569 Y103.808 E.01075
G1 X89.382 Y103.918 E.00426
G1 X88.976 Y104.112 E.00885
G1 X88.421 Y104.287 E.01145
G1 X87.882 Y104.376 E.01075
G1 X87.665 Y104.389 E.00426
G1 X87.214 Y104.376 E.00889
G1 X86.769 Y104.309 E.00883
G1 X86.336 Y104.191 E.00883
G1 X85.92 Y104.022 E.00883
G1 X85.529 Y103.806 E.00879
G1 X85.063 Y103.458 E.01145
G1 X84.678 Y103.073 E.01069
G1 X84.407 Y102.718 E.0088
G1 X84.179 Y102.331 E.00883
G1 X83.998 Y101.922 E.0088
G1 X83.847 Y101.4 E.01069
G1 X83.767 Y100.823 E.01146
G1 X83.76 Y96.191 E.0911
G1 X81.449 Y96.188 E.04545
G1 X81.134 Y96.141 E.00626
G1 X80.938 Y96.083 E.00403
G1 X80.747 Y96 E.00409
G1 X80.567 Y95.896 E.00409
G1 X80.4 Y95.772 E.0041
G1 X80.248 Y95.629 E.00409
G1 X80.115 Y95.47 E.00409
G1 X80.002 Y95.298 E.00403
G1 X79.867 Y95.01 E.00626
G1 X79.809 Y94.814 E.00403
G1 X79.772 Y94.609 E.00409
G1 X79.76 Y94.395 E.00422
G1 X79.76 Y77.407 E.33413
G1 X79.772 Y77.193 E.00422
G1 X79.808 Y76.991 E.00403
G1 X79.908 Y76.689 E.00625
G1 X79.999 Y76.509 E.00398
G1 X80.18 Y76.25 E.00621
G1 X80.368 Y76.059 E.00528
G1 X80.565 Y75.907 E.0049
G1 X80.841 Y75.758 E.00617
G1 X81.14 Y75.659 E.00619
G1 X81.342 Y75.623 E.00403
G1 X81.556 Y75.611 E.00421
G1 X93.607 Y75.613 E.23703
G1 X93.862 Y75.639 E.00504
G1 X94.063 Y75.686 E.00406
G1 X94.259 Y75.758 E.00409
G1 X94.443 Y75.85 E.00405
G1 X94.667 Y76.004 E.00534
G1 X94.853 Y76.174 E.00496
G1 X94.986 Y76.332 E.00406
G1 X95.169 Y76.611 E.00656
G1 X97.64 Y76.611 E.04861
G1 X97.64 Y87.111 E.20653
G1 X98.64 Y87.111 E.01967
G1 X98.64 Y88.014 E.01776
G1 X97.05 Y89.604 E.04423
G1 X95.46 Y88.014 E.04423
G1 X95.46 Y87.111 E.01776
G1 X96.46 Y87.111 E.01967
G1 X96.46 Y77.791 E.18332
G1 X94.16 Y77.791 E.04524
G1 X94.159 Y77.356 E.00855
G1 X94.125 Y77.192 E.00331
G1 X94.041 Y77.035 E.00349
G1 X93.916 Y76.91 E.00349
G1 X93.759 Y76.826 E.00349
G1 X93.595 Y76.792 E.0033
G1 X81.533 Y76.791 E.23725
G1 X81.355 Y76.82 E.00354
G1 X81.183 Y76.91 E.00382
G1 X81.038 Y77.064 E.00416
G1 X80.951 Y77.265 E.00431
G1 X80.94 Y94.414 E.33731
G1 X80.959 Y94.557 E.00282
G1 X81.024 Y94.717 E.0034
G1 X81.205 Y94.908 E.00519
G1 X81.374 Y94.987 E.00368
G1 X81.535 Y95.011 E.00319
G1 X93.86 Y95.001 E.24243
G1 X93.86 Y89.811 E.10209
G1 X95.84 Y89.811 E.03895
G1 X95.84 Y91.091 E.02518
G1 X94.9 Y91.091 E.01849
; WIPE_START
M204 S6000
G1 X94.84 Y93.088 E-.3796
G1 X94.842 Y93.089 E-.0004
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




G1 X94.35 Y92.887
G1 Z3.56
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.596522
G1 F1500
M204 S6000
G1 X94.35 Y90.886 E.05697
; WIPE_START
G1 X94.35 Y92.886 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X95.077 Y94.958 Z3.96 F18000
G1 Z3.56
G1 E.4 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.365752
G1 F1500
M204 S6000
G1 X95.013 Y94.995 E.00125
G1 X95.062 Y95.023 E.00095
; WIPE_START
G1 X95.013 Y94.995 E-.16436
G1 X95.077 Y94.958 E-.21564
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X99.065 Y94.958 Z3.96 F18000
G1 Z3.56
G1 E.4 F1800
G1 F1500
M204 S6000
G1 X99.002 Y94.995 E.00125
G1 X99.05 Y95.023 E.00095
; WIPE_START
G1 X99.002 Y94.995 E-.16436
G1 X99.065 Y94.958 E-.21564
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X99.75 Y92.887 Z3.96 F18000
G1 Z3.56
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.596522
G1 F1500
M204 S6000
G1 X99.75 Y90.886 E.05697
; WIPE_START
G1 X99.75 Y92.886 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X93.263 Y96.908 Z3.96 F18000
G1 X90.291 Y98.752 Z3.96
G1 Z3.56
G1 E.4 F1800
; LINE_WIDTH: 0.0923287
G1 F1500
M204 S6000
G1 X90.116 Y98.569 E.00084
M204 S10000
G1 X90.444 Y99.506 F18000
; LINE_WIDTH: 0.476126
G1 F1500
M204 S6000
G1 X90.478 Y99.722 E.00491
; LINE_WIDTH: 0.444214
G1 X90.512 Y99.937 E.00456
; LINE_WIDTH: 0.40547
G1 X90.532 Y100.277 E.00644
; LINE_WIDTH: 0.369863
G1 X90.548 Y100.575 E.00513
; LINE_WIDTH: 0.361242
G1 X90.503 Y101.132 E.00935
G1 X90.352 Y101.668 E.00933
G1 X90.13 Y102.132 E.0086
G1 X89.915 Y102.443 E.00633
G1 X89.664 Y102.722 E.00628
G1 X89.256 Y103.065 E.00893
G1 X89.008 Y103.216 E.00486
G1 X88.686 Y103.375 E.00602
G1 X88.123 Y103.542 E.00983
G1 X87.654 Y103.598 E.00791
G1 X87.284 Y103.584 E.00619
G1 X86.933 Y103.533 E.00594
G1 X86.589 Y103.442 E.00595
G1 X86.263 Y103.303 E.00594
G1 X85.977 Y103.155 E.00539
G1 X85.496 Y102.783 E.01018
G1 X85.133 Y102.375 E.00913
G1 X84.854 Y101.915 E.009
G1 X84.663 Y101.4 E.0092
G1 X84.59 Y101.057 E.00588
G1 X84.557 Y100.768 E.00487
G1 X84.567 Y100.161 E.01015
; LINE_WIDTH: 0.406021
G1 X84.598 Y99.922 E.00458
; LINE_WIDTH: 0.44277
G1 X84.625 Y99.72 E.00423
; LINE_WIDTH: 0.476395
G1 X84.652 Y99.519 E.00458
M204 S10000
G1 X84.809 Y98.752 F18000
; LINE_WIDTH: 0.0979183
G1 F1500
M204 S6000
G1 X84.999 Y98.552 E.00099
; WIPE_START
G1 X84.809 Y98.752 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X86.714 Y96.741 Z3.96 F18000
G1 Z3.56
G1 E.4 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.593452
G1 F1500
M204 S6000
G1 X87.062 Y96.72 E.00989
; LINE_WIDTH: 0.556217
G1 X87.411 Y96.698 E.00924
G1 X88.166 Y96.724 E.02
; WIPE_START
G1 X87.411 Y96.698 E-.25991
G1 X87.062 Y96.72 E-.12009
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X86.714 Y96.741 Z3.96 F18000
G1 Z3.56
G1 E.4 F1800
; LINE_WIDTH: 0.596391
M73 P70 R8
G1 F1500
M204 S6000
G1 X86.48 Y96.723 E.00666
; LINE_WIDTH: 0.560107
G1 X86.247 Y96.705 E.00624
; LINE_WIDTH: 0.507764
G1 X86.014 Y96.687 E.00563
G1 X85.44 Y96.688 E.01379
G1 X85.441 Y97.335 E.01558
G1 X85.951 Y97.051 E.01403
; LINE_WIDTH: 0.52625
G1 X86.288 Y96.914 E.00908
; LINE_WIDTH: 0.567385
G1 X86.625 Y96.777 E.00983
; LINE_WIDTH: 0.601242
G1 X86.658 Y96.763 E.00104
; WIPE_START
G1 X86.625 Y96.777 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X89.659 Y96.685 Z3.96 F18000
G1 Z3.56
G1 E.4 F1800
; LINE_WIDTH: 0.506822
G1 F1500
M204 S6000
G1 X88.958 Y96.685 E.01683
; LINE_WIDTH: 0.520017
G1 X88.66 Y96.699 E.00737
; LINE_WIDTH: 0.546407
G1 X88.361 Y96.712 E.00776
; LINE_WIDTH: 0.573187
G1 X88.226 Y96.726 E.00371
; LINE_WIDTH: 0.566785
G1 X88.573 Y96.841 E.00986
; LINE_WIDTH: 0.510921
G1 X88.919 Y96.956 E.00884
G1 X89.531 Y97.251 E.01644
G1 X89.658 Y97.332 E.00364
G1 X89.659 Y96.745 E.01421
M204 S10000
G1 X90.098 Y96.247 F18000
; LINE_WIDTH: 0.419992
G1 F1500
M204 S6000
G1 X85.002 Y96.251 E.10021
G1 X85.005 Y98.062 E.03563
G1 X85.09 Y98.075 E.00169
G1 X85.148 Y98.129 E.00156
G1 X85.554 Y97.777 E.01058
G1 X86.199 Y97.418 E.01451
G1 X86.772 Y97.232 E.01186
G1 X87.464 Y97.144 E.01372
G1 X88.185 Y97.202 E.01422
G1 X88.797 Y97.376 E.01251
G1 X89.335 Y97.642 E.01182
G1 X89.718 Y97.912 E.00921
G1 X89.964 Y98.149 E.00671
G1 X90.041 Y98.077 E.00208
G1 X90.095 Y98.082 E.00105
G1 X90.097 Y96.307 E.03492
; CHANGE_LAYER
; Z_HEIGHT: 3.68
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F1500
G1 X90.095 Y98.082 E-.33732
G1 X90.041 Y98.077 E-.01017
G1 X89.964 Y98.149 E-.02007
G1 X89.917 Y98.103 E-.01243
; WIPE_END
G1 E-.02 F1800
; layer num/total_layer_count: 30/49
; update layer progress
M73 L30
M991 S0 P29 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z3.96 I1.04 J.632 P1  F18000
G1 X94.431 Y90.682 Z3.96
G1 Z3.68
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X94.269 Y90.682 E.00342
G1 X94.269 Y90.22 E.00977
G1 X95.431 Y90.22 E.02458
G1 X95.431 Y90.682 E.00977
G1 X94.491 Y90.682 E.0199
; WIPE_START
M204 S6000
G1 X94.269 Y90.682 E-.04209
G1 X94.269 Y90.22 E-.08769
G1 X95.431 Y90.22 E-.22069
G1 X95.431 Y90.376 E-.02952
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X98.669 Y90.22 Z4.08 F18000
G1 Z3.68
G1 E.4 F1800
G1 F1500
M204 S500
G1 X99.831 Y90.22 E.02458
G1 X99.831 Y90.682 E.00977
G1 X98.669 Y90.682 E.02458
G1 X98.669 Y90.28 E.0085
; WIPE_START
M204 S6000
G1 X99.831 Y90.22 E-.22098
G1 X99.831 Y90.682 E-.08769
G1 X99.455 Y90.682 E-.07132
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X98.638 Y94.889 Z4.08 F18000
G1 Z3.68
G1 E.4 F1800
G1 F1500
M204 S500
G1 X99.407 Y94.12 E.02301
G1 X99.407 Y95.357 E.02619
G1 X98.169 Y95.357 E.02619
G1 X98.595 Y94.931 E.01276
M204 S10000
G1 X98.338 Y94.589 F18000
G1 F1500
M204 S500
G1 X99.831 Y93.096 E.04469
G1 X99.831 Y95.782 E.05685
G1 X97.145 Y95.782 E.05685
G1 X98.295 Y94.631 E.03444
; WIPE_START
M204 S6000
G1 X99.71 Y93.217 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X96.569 Y87.944 Z4.08 F18000
G1 Z3.68
G1 E.4 F1800
G1 F1500
M204 S500
G1 X97.531 Y87.944 E.02035
G1 X97.05 Y88.425 E.01439
G1 X96.612 Y87.987 E.01312
; WIPE_START
M204 S6000
G1 X97.531 Y87.944 E-.17484
G1 X97.05 Y88.425 E-.1292
G1 X96.767 Y88.143 E-.07596
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X94.693 Y94.12 Z4.08 F18000
G1 Z3.68
G1 E.4 F1800
G1 F1500
M204 S500
G1 X95.931 Y95.357 E.03704
G1 X94.693 Y95.357 E.02619
G1 X94.693 Y94.18 E.02492
; WIPE_START
M204 S6000
G1 X95.931 Y95.357 E-.32452
G1 X95.639 Y95.357 E-.05549
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X89.385 Y98.175 Z4.08 F18000
G1 Z3.68
G1 E.4 F1800
G1 F1500
M204 S500
G1 X89.138 Y98.001 E.00639
G1 X88.663 Y97.764 E.01123
G1 X88.129 Y97.608 E.01179
G1 X87.489 Y97.553 E.0136
G1 X86.879 Y97.627 E.01301
G1 X86.345 Y97.801 E.01187
G1 X85.808 Y98.099 E.01301
G1 X85.322 Y98.52 E.0136
G1 X84.975 Y98.969 E.01201
G1 X84.795 Y99.334 E.00863
G1 X84.598 Y99.289 E.00427
G1 X84.593 Y95.842 E.07295
G1 X90.507 Y95.837 E.12517
G1 X90.507 Y99.293 E.07315
G1 X90.314 Y99.341 E.00421
G1 X90.075 Y98.892 E.01077
G1 X89.731 Y98.474 E.01146
G1 X89.449 Y98.22 E.00804
G1 X89.434 Y98.209 E.00039
M204 S10000
G1 X89.141 Y98.522 F18000
G1 F1500
M204 S500
G1 X89.184 Y98.552 E.00112
G1 X89.424 Y98.768 E.00683
G1 X89.72 Y99.129 E.00988
G1 X89.981 Y99.62 E.01177
G1 X90.129 Y100.128 E.01121
G1 X90.172 Y100.607 E.01017
G1 X90.111 Y101.16 E.01177
G1 X89.947 Y101.663 E.01121
G1 X89.716 Y102.078 E.01004
G1 X89.418 Y102.441 E.00995
G1 X89.056 Y102.748 E.01004
G1 X88.593 Y103.006 E.01121
G1 X88.063 Y103.173 E.01177
G1 X87.589 Y103.222 E.01008
G1 X87.121 Y103.187 E.00995
G1 X86.66 Y103.067 E.01008
G1 X86.16 Y102.824 E.01177
G1 X85.741 Y102.499 E.01121
G1 X85.429 Y102.142 E.01004
G1 X85.188 Y101.739 E.00995
G1 X85.026 Y101.307 E.00976
G1 X84.959 Y100.991 E.00683
G1 X84.93 Y100.67 E.00683
G1 X84.958 Y100.206 E.00985
G1 X85.091 Y99.693 E.01121
G1 X85.337 Y99.195 E.01177
G1 X85.632 Y98.813 E.01021
G1 X86.053 Y98.449 E.01177
G1 X86.515 Y98.191 E.01121
G1 X86.971 Y98.044 E.01013
G1 X87.497 Y97.98 E.01121
G1 X88.051 Y98.027 E.01177
G1 X88.508 Y98.16 E.01008
G1 X88.92 Y98.366 E.00975
G1 X89.092 Y98.487 E.00445
M204 S250
G1 X88.905 Y98.856 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X88.928 Y98.873 E.00056
G1 X89.127 Y99.052 E.00526
G1 X89.378 Y99.357 E.00778
G1 X89.6 Y99.775 E.0093
G1 X89.725 Y100.205 E.00881
G1 X89.761 Y100.603 E.00787
G1 X89.709 Y101.073 E.0093
G1 X89.57 Y101.499 E.00881
G1 X89.377 Y101.846 E.00782
G1 X89.125 Y102.152 E.0078
G1 X88.821 Y102.41 E.00783
G1 X88.431 Y102.628 E.0088
G1 X87.979 Y102.77 E.0093
G1 X87.583 Y102.811 E.00784
G1 X87.188 Y102.782 E.00779
G1 X86.802 Y102.682 E.00784
G1 X86.377 Y102.474 E.0093
G1 X86.023 Y102.2 E.00881
G1 X85.761 Y101.9 E.00783
G1 X85.558 Y101.56 E.0078
G1 X85.42 Y101.192 E.00774
G1 X85.364 Y100.93 E.00526
G1 X85.34 Y100.664 E.00526
G1 X85.364 Y100.27 E.00777
G1 X85.476 Y99.836 E.0088
G1 X85.686 Y99.412 E.0093
G1 X85.931 Y99.095 E.00788
G1 X86.288 Y98.786 E.0093
G1 X86.68 Y98.568 E.00881
G1 X87.059 Y98.445 E.00785
G1 X87.504 Y98.391 E.00881
G1 X87.975 Y98.431 E.0093
G1 X88.358 Y98.543 E.00784
G1 X88.709 Y98.719 E.00773
G1 X88.856 Y98.822 E.00353
; WIPE_START
M204 S6000
G1 X88.928 Y98.873 E-.01677
G1 X89.127 Y99.052 E-.05082
G1 X89.378 Y99.357 E-.07511
G1 X89.6 Y99.775 E-.08987
G1 X89.725 Y100.205 E-.08508
G1 X89.755 Y100.532 E-.06235
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X93.068 Y93.656 Z4.08 F18000
G1 X95.869 Y87.844 Z4.08
G1 Z3.68
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X95.869 Y87.52 E.00686
G1 X96.869 Y87.52 E.02117
G1 X96.869 Y77.382 E.21459
G1 X94.582 Y77.382 E.0484
G1 X94.514 Y77.05 E.00716
G1 X94.373 Y76.788 E.0063
G1 X94.162 Y76.578 E.00629
G1 X93.901 Y76.437 E.00629
G1 X93.637 Y76.382 E.00571
G1 X81.505 Y76.382 E.25678
G1 X81.247 Y76.419 E.00553
G1 X80.936 Y76.576 E.00737
G1 X80.69 Y76.836 E.00756
G1 X80.542 Y77.181 E.00795
G1 X80.531 Y94.437 E.36524
G1 X80.555 Y94.643 E.0044
G1 X80.664 Y94.925 E.00641
G1 X80.957 Y95.244 E.00918
G1 X81.256 Y95.384 E.00697
G1 X81.505 Y95.42 E.00534
G1 X94.269 Y95.41 E.27016
G1 X94.269 Y93.096 E.04898
G1 X96.955 Y95.782 E.08039
G1 X90.931 Y95.782 E.12751
G1 X90.931 Y100.586 E.1017
G1 X90.917 Y100.878 E.00618
G1 X90.877 Y101.196 E.00679
G1 X90.782 Y101.588 E.00853
G1 X90.643 Y101.963 E.00848
G1 X90.456 Y102.328 E.00867
G1 X90.114 Y102.802 E.01238
G1 X89.738 Y103.174 E.0112
G1 X89.343 Y103.466 E.0104
G1 X89.19 Y103.557 E.00376
G1 X88.826 Y103.73 E.00853
G1 X88.321 Y103.889 E.0112
G1 X87.836 Y103.969 E.0104
G1 X87.25 Y103.967 E.01241
G1 X86.854 Y103.908 E.00848
G1 X86.468 Y103.803 E.00848
G1 X86.097 Y103.652 E.00847
G1 X85.751 Y103.462 E.00834
G1 X85.328 Y103.145 E.0112
G1 X84.987 Y102.804 E.0102
G1 X84.747 Y102.489 E.00838
G1 X84.543 Y102.144 E.00847
G1 X84.38 Y101.774 E.00856
G1 X84.224 Y101.201 E.01257
G1 X84.176 Y100.801 E.00854
G1 X84.168 Y95.783 E.10621
G1 X81.479 Y95.778 E.05691
G1 X81.223 Y95.741 E.00548
G1 X80.931 Y95.634 E.00659
G1 X80.792 Y95.554 E.0034
G1 X80.546 Y95.348 E.00678
G1 X80.36 Y95.098 E.00659
G1 X80.251 Y94.864 E.00547
G1 X80.207 Y94.719 E.0032
G1 X80.169 Y94.383 E.00716
G1 X80.169 Y77.419 E.35905
G1 X80.206 Y77.092 E.00697
G1 X80.284 Y76.855 E.00528
G1 X80.403 Y76.636 E.00527
G1 X80.488 Y76.521 E.00301
G1 X80.67 Y76.339 E.00547
G1 X80.784 Y76.254 E.00301
G1 X81.012 Y76.131 E.00547
G1 X81.146 Y76.082 E.00301
G1 X81.399 Y76.03 E.00547
G1 X93.588 Y76.022 E.258
G1 X93.946 Y76.079 E.00766
G1 X94.096 Y76.134 E.0034
G1 X94.369 Y76.291 E.00665
G1 X94.532 Y76.433 E.00459
G1 X94.659 Y76.581 E.00412
G1 X94.948 Y77.02 E.01113
G1 X97.231 Y77.02 E.04831
G1 X97.231 Y87.52 E.22224
G1 X98.231 Y87.52 E.02117
G1 X98.231 Y87.844 E.00686
G1 X97.05 Y89.025 E.03534
G1 X95.912 Y87.887 E.03407
; WIPE_START
M204 S6000
G1 X95.869 Y87.52 E-.07014
G1 X96.869 Y87.52 E-.19
G1 X96.869 Y86.889 E-.11986
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X94.84 Y91.091 Z4.08 F18000
G1 Z3.68
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X94.84 Y93.088 E.03928
G1 X97.05 Y95.298 E.06147
G1 X99.26 Y93.088 E.06147
G1 X99.26 Y91.091 E.03928
G1 X98.26 Y91.091 E.01967
G1 X98.26 Y89.811 E.02518
G1 X100.24 Y89.811 E.03895
G1 X100.24 Y96.191 E.12549
G1 X91.34 Y96.191 E.17505
G1 X91.34 Y100.596 E.08664
G1 X91.325 Y100.913 E.00625
G1 X91.28 Y101.27 E.00708
G1 X91.174 Y101.708 E.00885
G1 X91.018 Y102.129 E.00883
G1 X90.812 Y102.531 E.00889
G1 X90.695 Y102.715 E.0043
G1 X90.422 Y103.073 E.00885
G1 X90.005 Y103.486 E.01154
G1 X89.569 Y103.808 E.01065
G1 X89.382 Y103.918 E.00427
G1 X88.976 Y104.112 E.00885
G1 X88.416 Y104.288 E.01154
G1 X87.882 Y104.376 E.01066
G1 X87.665 Y104.389 E.00426
G1 X87.214 Y104.376 E.00889
G1 X86.769 Y104.309 E.00883
G1 X86.336 Y104.191 E.00883
G1 X85.92 Y104.022 E.00883
G1 X85.529 Y103.806 E.00879
G1 X85.059 Y103.455 E.01154
G1 X84.678 Y103.074 E.01059
G1 X84.407 Y102.718 E.0088
G1 X84.179 Y102.331 E.00883
G1 X83.997 Y101.919 E.00886
G1 X83.902 Y101.622 E.00613
G1 X83.82 Y101.272 E.00708
G1 X83.767 Y100.825 E.00885
G1 X83.76 Y96.191 E.09115
G1 X81.449 Y96.188 E.04545
G1 X81.134 Y96.141 E.00626
G1 X80.938 Y96.083 E.00403
G1 X80.747 Y96 E.00409
G1 X80.567 Y95.896 E.00409
G1 X80.4 Y95.772 E.0041
G1 X80.248 Y95.629 E.00409
G1 X80.114 Y95.47 E.00409
G1 X80.002 Y95.298 E.00403
G1 X79.867 Y95.01 E.00626
G1 X79.809 Y94.814 E.00403
G1 X79.772 Y94.609 E.00409
G1 X79.76 Y94.395 E.00422
G1 X79.76 Y77.407 E.33413
G1 X79.772 Y77.193 E.00422
G1 X79.808 Y76.991 E.00404
G1 X79.907 Y76.692 E.00619
G1 X80.057 Y76.415 E.00619
G1 X80.177 Y76.253 E.00398
G1 X80.402 Y76.028 E.00625
G1 X80.564 Y75.908 E.00397
G1 X80.844 Y75.757 E.00626
G1 X81.034 Y75.687 E.00397
G1 X81.345 Y75.623 E.00626
G1 X81.556 Y75.611 E.00415
G1 X93.609 Y75.613 E.23708
G1 X93.862 Y75.639 E.005
G1 X94.063 Y75.686 E.00407
G1 X94.259 Y75.758 E.00409
G1 X94.445 Y75.851 E.00409
G1 X94.617 Y75.964 E.00405
G1 X94.823 Y76.144 E.00538
G1 X94.986 Y76.334 E.00492
G1 X95.169 Y76.611 E.00653
G1 X97.64 Y76.611 E.04861
G1 X97.64 Y87.111 E.20653
G1 X98.64 Y87.111 E.01967
G1 X98.64 Y88.014 E.01776
G1 X97.05 Y89.604 E.04423
G1 X95.46 Y88.014 E.04423
G1 X95.46 Y87.111 E.01776
G1 X96.46 Y87.111 E.01967
G1 X96.46 Y77.791 E.18332
G1 X94.16 Y77.791 E.04524
G1 X94.159 Y77.356 E.00855
G1 X94.125 Y77.192 E.0033
G1 X94.041 Y77.035 E.0035
G1 X93.916 Y76.91 E.00349
G1 X93.759 Y76.826 E.00349
G1 X93.595 Y76.792 E.0033
G1 X81.535 Y76.791 E.23721
G1 X81.371 Y76.815 E.00325
G1 X81.184 Y76.909 E.00413
G1 X81.038 Y77.064 E.00419
G1 X80.951 Y77.265 E.00431
G1 X80.94 Y94.413 E.33728
G1 X80.955 Y94.544 E.00259
G1 X81.018 Y94.706 E.00341
G1 X81.204 Y94.908 E.00541
G1 X81.374 Y94.987 E.0037
G1 X81.535 Y95.011 E.00319
G1 X93.86 Y95.001 E.24243
G1 X93.86 Y89.811 E.10209
G1 X95.84 Y89.811 E.03895
G1 X95.84 Y91.091 E.02518
G1 X94.9 Y91.091 E.01849
; WIPE_START
M204 S6000
G1 X94.84 Y93.088 E-.3796
G1 X94.842 Y93.089 E-.0004
; WIPE_END
M73 P71 R8
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




G1 X94.35 Y92.887
G1 Z3.68
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.596522
G1 F1500
M204 S6000
G1 X94.35 Y90.886 E.05697
; WIPE_START
G1 X94.35 Y92.886 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X95.077 Y94.958 Z4.08 F18000
G1 Z3.68
G1 E.4 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.365752
G1 F1500
M204 S6000
G1 X95.013 Y94.995 E.00125
G1 X95.062 Y95.023 E.00095
; WIPE_START
G1 X95.013 Y94.995 E-.16436
G1 X95.077 Y94.958 E-.21564
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X99.065 Y94.958 Z4.08 F18000
G1 Z3.68
G1 E.4 F1800
G1 F1500
M204 S6000
G1 X99.002 Y94.995 E.00125
G1 X99.05 Y95.023 E.00095
; WIPE_START
G1 X99.002 Y94.995 E-.16436
G1 X99.065 Y94.958 E-.21564
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X99.75 Y92.887 Z4.08 F18000
G1 Z3.68
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.596522
G1 F1500
M204 S6000
G1 X99.75 Y90.886 E.05697
; WIPE_START
G1 X99.75 Y92.886 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X93.265 Y96.912 Z4.08 F18000
G1 X90.294 Y98.756 Z4.08
G1 Z3.68
G1 E.4 F1800
; LINE_WIDTH: 0.0926914
G1 F1500
M204 S6000
G1 X90.116 Y98.569 E.00086
; WIPE_START
G1 X90.294 Y98.756 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X90.452 Y99.526 Z4.08 F18000
G1 Z3.68
G1 E.4 F1800
; LINE_WIDTH: 0.469534
G1 F1500
M204 S6000
G1 X90.487 Y99.781 E.0057
; LINE_WIDTH: 0.428542
G1 X90.522 Y100.036 E.00517
; LINE_WIDTH: 0.389934
G1 X90.536 Y100.333 E.00542
; LINE_WIDTH: 0.362027
G1 X90.546 Y100.595 E.00439
; LINE_WIDTH: 0.361191
G1 X90.483 Y101.223 E.01056
G1 X90.297 Y101.809 E.01029
G1 X90.037 Y102.279 E.00899
G1 X89.673 Y102.713 E.00948
G1 X89.256 Y103.065 E.00913
G1 X88.684 Y103.376 E.0109
G1 X88.123 Y103.542 E.00979
G1 X87.654 Y103.598 E.00791
G1 X87.284 Y103.584 E.00619
G1 X86.933 Y103.533 E.00594
G1 X86.544 Y103.427 E.00674
G1 X85.957 Y103.144 E.01091
G1 X85.495 Y102.783 E.00981
G1 X85.133 Y102.375 E.00912
G1 X84.855 Y101.916 E.00899
G1 X84.664 Y101.4 E.00919
G1 X84.599 Y101.132 E.00462
G1 X84.557 Y100.778 E.00597
G1 X84.567 Y100.162 E.01031
; LINE_WIDTH: 0.406046
G1 X84.598 Y99.922 E.00458
; LINE_WIDTH: 0.442835
G1 X84.625 Y99.721 E.00423
; LINE_WIDTH: 0.476486
G1 X84.652 Y99.519 E.00458
M204 S10000
G1 X84.809 Y98.751 F18000
; LINE_WIDTH: 0.0980445
G1 F1500
M204 S6000
G1 X84.999 Y98.551 E.001
; WIPE_START
G1 X84.809 Y98.751 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X86.713 Y96.741 Z4.08 F18000
G1 Z3.68
G1 E.4 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.593567
G1 F1500
M204 S6000
G1 X87.06 Y96.72 E.00985
; LINE_WIDTH: 0.556255
G1 X87.407 Y96.698 E.0092
G1 X88.165 Y96.724 E.02007
; WIPE_START
G1 X87.407 Y96.698 E-.26056
G1 X87.06 Y96.72 E-.11944
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X86.713 Y96.741 Z4.08 F18000
G1 Z3.68
G1 E.4 F1800
; LINE_WIDTH: 0.596489
G1 F1500
M204 S6000
G1 X86.48 Y96.723 E.00666
; LINE_WIDTH: 0.560162
G1 X86.247 Y96.705 E.00623
; LINE_WIDTH: 0.507754
G1 X86.014 Y96.687 E.00562
G1 X85.44 Y96.688 E.0138
G1 X85.441 Y97.335 E.01557
G1 X85.952 Y97.051 E.01405
; LINE_WIDTH: 0.526262
G1 X86.288 Y96.914 E.00907
; LINE_WIDTH: 0.567442
G1 X86.624 Y96.777 E.00981
; LINE_WIDTH: 0.601342
G1 X86.658 Y96.763 E.00104
; WIPE_START
G1 X86.624 Y96.777 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X89.66 Y96.685 Z4.08 F18000
G1 Z3.68
G1 E.4 F1800
; LINE_WIDTH: 0.506982
G1 F1500
M204 S6000
G1 X88.958 Y96.685 E.01684
; LINE_WIDTH: 0.520112
G1 X88.659 Y96.699 E.00737
; LINE_WIDTH: 0.546372
G1 X88.361 Y96.712 E.00776
; LINE_WIDTH: 0.573077
G1 X88.225 Y96.726 E.00372
; LINE_WIDTH: 0.566735
G1 X88.572 Y96.841 E.00987
; LINE_WIDTH: 0.511064
G1 X88.919 Y96.956 E.00886
G1 X89.531 Y97.251 E.01644
G1 X89.66 Y97.333 E.00369
G1 X89.66 Y96.745 E.01423
M204 S10000
G1 X90.097 Y96.247 F18000
; LINE_WIDTH: 0.419992
G1 F1500
M204 S6000
G1 X85.002 Y96.251 E.10021
G1 X85.005 Y98.061 E.03561
G1 X85.091 Y98.074 E.0017
G1 X85.149 Y98.129 E.00156
G1 X85.557 Y97.776 E.01061
G1 X86.199 Y97.418 E.01446
G1 X86.772 Y97.232 E.01184
G1 X87.461 Y97.144 E.01367
G1 X88.185 Y97.202 E.01427
G1 X88.797 Y97.376 E.01252
G1 X89.335 Y97.642 E.01181
G1 X89.718 Y97.912 E.00921
G1 X89.964 Y98.149 E.00671
G1 X90.042 Y98.077 E.0021
G1 X90.097 Y98.082 E.00109
G1 X90.097 Y96.307 E.03491
; CHANGE_LAYER
; Z_HEIGHT: 3.8
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F1500
G1 X90.097 Y98.082 E-.33724
G1 X90.042 Y98.077 E-.0105
G1 X89.964 Y98.149 E-.0203
G1 X89.918 Y98.105 E-.01196
; WIPE_END
G1 E-.02 F1800
; layer num/total_layer_count: 31/49
; update layer progress
M73 L31
M991 S0 P30 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z4.08 I1.04 J.632 P1  F18000
G1 X94.431 Y90.682 Z4.08
G1 Z3.8
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X94.269 Y90.682 E.00342
G1 X94.269 Y90.22 E.00977
G1 X95.431 Y90.22 E.02458
G1 X95.431 Y90.682 E.00977
G1 X94.491 Y90.682 E.0199
; WIPE_START
M204 S6000
G1 X94.269 Y90.682 E-.04209
G1 X94.269 Y90.22 E-.08769
G1 X95.431 Y90.22 E-.22069
G1 X95.431 Y90.376 E-.02952
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X98.669 Y90.22 Z4.2 F18000
G1 Z3.8
G1 E.4 F1800
G1 F1500
M204 S500
G1 X99.831 Y90.22 E.02458
G1 X99.831 Y90.682 E.00977
G1 X98.669 Y90.682 E.02458
G1 X98.669 Y90.28 E.0085
; WIPE_START
M204 S6000
G1 X99.831 Y90.22 E-.22098
G1 X99.831 Y90.682 E-.08769
G1 X99.455 Y90.682 E-.07132
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X98.638 Y94.889 Z4.2 F18000
G1 Z3.8
G1 E.4 F1800
G1 F1500
M204 S500
G1 X99.407 Y94.12 E.02301
G1 X99.407 Y95.357 E.02619
G1 X98.169 Y95.357 E.02619
G1 X98.595 Y94.931 E.01276
M204 S10000
G1 X98.338 Y94.589 F18000
G1 F1500
M204 S500
G1 X99.831 Y93.096 E.04469
G1 X99.831 Y95.782 E.05685
G1 X97.145 Y95.782 E.05685
G1 X98.295 Y94.631 E.03444
; WIPE_START
M204 S6000
G1 X99.71 Y93.217 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X96.569 Y87.944 Z4.2 F18000
G1 Z3.8
G1 E.4 F1800
G1 F1500
M204 S500
G1 X97.531 Y87.944 E.02035
G1 X97.05 Y88.425 E.01439
G1 X96.612 Y87.987 E.01312
; WIPE_START
M204 S6000
G1 X97.531 Y87.944 E-.17484
G1 X97.05 Y88.425 E-.1292
G1 X96.767 Y88.143 E-.07596
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X94.693 Y94.12 Z4.2 F18000
G1 Z3.8
G1 E.4 F1800
G1 F1500
M204 S500
G1 X95.931 Y95.357 E.03704
G1 X94.693 Y95.357 E.02619
G1 X94.693 Y94.18 E.02492
; WIPE_START
M204 S6000
G1 X95.931 Y95.357 E-.32452
G1 X95.639 Y95.357 E-.05549
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X89.377 Y98.169 Z4.2 F18000
G1 Z3.8
G1 E.4 F1800
G1 F1500
M204 S500
G1 X89.138 Y98.001 E.00617
G1 X88.663 Y97.764 E.01124
G1 X88.154 Y97.615 E.01123
G1 X87.781 Y97.565 E.00797
G1 X87.453 Y97.557 E.00694
G1 X86.878 Y97.627 E.01226
G1 X86.352 Y97.798 E.01171
G1 X85.885 Y98.05 E.01123
G1 X85.581 Y98.278 E.00804
G1 X85.306 Y98.54 E.00804
G1 X84.991 Y98.948 E.0109
G1 X84.788 Y99.312 E.00882
G1 X84.598 Y99.262 E.00416
G1 X84.593 Y95.842 E.07239
G1 X90.507 Y95.837 E.12517
G1 X90.507 Y99.288 E.07304
G1 X90.309 Y99.333 E.0043
G1 X90.173 Y99.052 E.00661
G1 X89.959 Y98.738 E.00804
G1 X89.719 Y98.464 E.00771
G1 X89.449 Y98.22 E.00771
G1 X89.426 Y98.204 E.0006
M204 S10000
G1 X89.133 Y98.516 F18000
G1 F1500
M204 S500
G1 X89.184 Y98.552 E.00133
G1 X89.417 Y98.762 E.00663
G1 X89.623 Y98.998 E.00663
G1 X89.805 Y99.265 E.00683
G1 X90.005 Y99.68 E.00976
G1 X90.13 Y100.133 E.00995
G1 X90.172 Y100.601 E.00995
G1 X90.13 Y101.069 E.00995
G1 X90.005 Y101.522 E.00995
G1 X89.805 Y101.937 E.00975
G1 X89.623 Y102.204 E.00683
G1 X89.411 Y102.447 E.00683
G1 X89.056 Y102.748 E.00984
G1 X88.613 Y102.995 E.01074
G1 X88.358 Y103.094 E.00579
G1 X88.047 Y103.174 E.00678
G1 X87.589 Y103.222 E.00975
G1 X87.121 Y103.187 E.00995
G1 X86.675 Y103.071 E.00975
G1 X86.38 Y102.945 E.00679
M73 P71 R7
G1 X86.142 Y102.81 E.00579
G1 X85.741 Y102.499 E.01075
G1 X85.429 Y102.142 E.01003
G1 X85.193 Y101.747 E.00975
G1 X85.07 Y101.448 E.00683
G1 X84.984 Y101.137 E.00683
G1 X84.929 Y100.679 E.00975
G1 X84.958 Y100.206 E.01004
G1 X85.085 Y99.714 E.01075
G1 X85.19 Y99.462 E.00579
G1 X85.346 Y99.182 E.00678
G1 X85.622 Y98.825 E.00955
G1 X85.856 Y98.602 E.00683
G1 X86.114 Y98.408 E.00683
G1 X86.52 Y98.19 E.00975
G1 X86.97 Y98.044 E.01003
G1 X87.474 Y97.982 E.01075
G1 X87.748 Y97.988 E.00579
G1 X88.066 Y98.031 E.00679
G1 X88.508 Y98.16 E.00975
G1 X88.92 Y98.367 E.00976
G1 X89.083 Y98.482 E.00423
M204 S250
G1 X88.897 Y98.851 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X88.928 Y98.873 E.00075
G1 X89.125 Y99.05 E.0052
G1 X89.299 Y99.249 E.0052
G1 X89.449 Y99.47 E.00526
G1 X89.62 Y99.824 E.00774
G1 X89.725 Y100.206 E.0078
G1 X89.761 Y100.601 E.00779
G1 X89.725 Y100.996 E.00779
G1 X89.62 Y101.378 E.0078
G1 X89.449 Y101.732 E.00773
G1 X89.299 Y101.953 E.00526
G1 X89.123 Y102.155 E.00526
G1 X88.821 Y102.41 E.00776
G1 X88.439 Y102.624 E.00863
G1 X88.232 Y102.703 E.00435
G1 X87.974 Y102.77 E.00524
G1 X87.583 Y102.811 E.00774
G1 X87.188 Y102.782 E.00779
G1 X86.807 Y102.683 E.00773
G1 X86.562 Y102.578 E.00525
G1 X86.37 Y102.469 E.00435
G1 X86.023 Y102.2 E.00863
G1 X85.761 Y101.9 E.00782
G1 X85.56 Y101.563 E.00773
G1 X85.458 Y101.315 E.00526
G1 X85.387 Y101.057 E.00526
G1 X85.34 Y100.667 E.00773
G1 X85.364 Y100.27 E.00783
G1 X85.474 Y99.845 E.00863
G1 X85.559 Y99.641 E.00435
G1 X85.689 Y99.408 E.00524
G1 X85.927 Y99.1 E.00767
G1 X86.121 Y98.915 E.00527
G1 X86.335 Y98.754 E.00526
G1 X86.681 Y98.568 E.00773
G1 X87.059 Y98.445 E.00782
G1 X87.495 Y98.392 E.00863
G1 X87.716 Y98.397 E.00435
G1 X87.98 Y98.433 E.00525
G1 X88.358 Y98.543 E.00773
G1 X88.709 Y98.719 E.00774
G1 X88.848 Y98.816 E.00333
; WIPE_START
M204 S6000
G1 X88.928 Y98.873 E-.01865
G1 X89.125 Y99.05 E-.05022
G1 X89.299 Y99.249 E-.05023
G1 X89.449 Y99.47 E-.05083
G1 X89.62 Y99.824 E-.07473
G1 X89.725 Y100.206 E-.07531
G1 X89.754 Y100.521 E-.06003
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X93.07 Y93.647 Z4.2 F18000
G1 X95.869 Y87.844 Z4.2
G1 Z3.8
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X95.869 Y87.52 E.00686
G1 X96.869 Y87.52 E.02117
G1 X96.869 Y77.382 E.21459
G1 X94.582 Y77.382 E.0484
G1 X94.514 Y77.05 E.00717
G1 X94.373 Y76.788 E.00629
G1 X94.163 Y76.578 E.0063
G1 X93.901 Y76.437 E.00629
G1 X93.637 Y76.382 E.00572
G1 X81.496 Y76.382 E.25697
G1 X81.201 Y76.434 E.00634
G1 X80.909 Y76.599 E.0071
G1 X80.688 Y76.841 E.00693
G1 X80.542 Y77.181 E.00784
G1 X80.531 Y94.437 E.36524
G1 X80.555 Y94.643 E.0044
G1 X80.664 Y94.926 E.00643
G1 X80.958 Y95.245 E.00917
G1 X81.256 Y95.384 E.00696
G1 X81.505 Y95.42 E.00533
G1 X94.269 Y95.41 E.27016
G1 X94.269 Y93.096 E.04898
G1 X96.955 Y95.782 E.08039
G1 X90.931 Y95.782 E.12751
G1 X90.931 Y100.587 E.1017
G1 X90.918 Y100.874 E.00608
G1 X90.877 Y101.197 E.00689
G1 X90.782 Y101.588 E.00852
G1 X90.643 Y101.963 E.00847
G1 X90.46 Y102.32 E.00848
G1 X90.235 Y102.653 E.00852
G1 X90.024 Y102.901 E.00689
G1 X89.832 Y103.095 E.00578
G1 X89.622 Y103.27 E.00578
G1 X89.19 Y103.557 E.01097
G1 X88.639 Y103.801 E.01275
G1 X88.327 Y103.889 E.00687
G1 X87.837 Y103.969 E.01051
G1 X87.25 Y103.967 E.01241
G1 X86.854 Y103.908 E.00848
G1 X86.468 Y103.803 E.00848
G1 X86.096 Y103.652 E.00848
G1 X85.738 Y103.454 E.00867
G1 X85.332 Y103.149 E.01076
G1 X84.987 Y102.804 E.01031
G1 X84.747 Y102.489 E.00838
G1 X84.543 Y102.144 E.00847
G1 X84.38 Y101.774 E.00857
G1 X84.224 Y101.201 E.01257
G1 X84.176 Y100.801 E.00853
G1 X84.168 Y95.783 E.10621
G1 X81.479 Y95.778 E.05691
G1 X81.223 Y95.741 E.00548
G1 X80.931 Y95.634 E.00659
G1 X80.792 Y95.554 E.00339
G1 X80.546 Y95.348 E.00678
G1 X80.447 Y95.23 E.00326
G1 X80.331 Y95.044 E.00464
G1 X80.207 Y94.719 E.00736
G1 X80.169 Y94.383 E.00716
G1 X80.169 Y77.419 E.35905
G1 X80.206 Y77.092 E.00697
G1 X80.284 Y76.855 E.00528
G1 X80.403 Y76.636 E.00527
G1 X80.488 Y76.521 E.00302
G1 X80.67 Y76.339 E.00546
G1 X80.785 Y76.254 E.00302
G1 X81.012 Y76.131 E.00547
G1 X81.146 Y76.082 E.00302
G1 X81.399 Y76.03 E.00547
G1 X93.591 Y76.022 E.25805
G1 X93.794 Y76.043 E.00432
G1 X94.097 Y76.134 E.00669
G1 X94.232 Y76.202 E.0032
G1 X94.443 Y76.35 E.00547
G1 X94.657 Y76.577 E.00659
G1 X94.948 Y77.02 E.01123
G1 X97.231 Y77.02 E.04831
G1 X97.231 Y87.52 E.22224
G1 X98.231 Y87.52 E.02117
G1 X98.231 Y87.844 E.00686
G1 X97.05 Y89.025 E.03534
G1 X95.912 Y87.887 E.03407
; WIPE_START
M204 S6000
G1 X95.869 Y87.52 E-.07014
G1 X96.869 Y87.52 E-.19
G1 X96.869 Y86.889 E-.11986
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X94.84 Y91.091 Z4.2 F18000
G1 Z3.8
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X94.84 Y93.088 E.03928
G1 X97.05 Y95.298 E.06147
G1 X99.26 Y93.088 E.06147
G1 X99.26 Y91.091 E.03928
G1 X98.26 Y91.091 E.01967
G1 X98.26 Y89.811 E.02518
G1 X100.24 Y89.811 E.03895
G1 X100.24 Y96.191 E.12549
G1 X91.34 Y96.191 E.17505
G1 X91.34 Y100.596 E.08664
G1 X91.326 Y100.909 E.00616
M73 P72 R7
G1 X91.28 Y101.271 E.00717
G1 X91.174 Y101.708 E.00885
G1 X91.018 Y102.129 E.00883
G1 X90.813 Y102.528 E.00883
G1 X90.562 Y102.901 E.00884
G1 X90.326 Y103.179 E.00717
G1 X90.108 Y103.397 E.00606
G1 X89.871 Y103.595 E.00606
G1 X89.571 Y103.807 E.00723
G1 X89.382 Y103.918 E.00431
G1 X88.972 Y104.114 E.00895
G1 X88.415 Y104.289 E.01147
G1 X87.882 Y104.376 E.01063
G1 X87.665 Y104.389 E.00426
G1 X87.214 Y104.376 E.00889
G1 X86.769 Y104.309 E.00883
G1 X86.336 Y104.191 E.00883
G1 X85.92 Y104.022 E.00883
G1 X85.524 Y103.804 E.00889
G1 X85.058 Y103.454 E.01147
G1 X84.678 Y103.074 E.01057
G1 X84.407 Y102.718 E.0088
G1 X84.179 Y102.331 E.00883
G1 X83.997 Y101.919 E.00886
G1 X83.903 Y101.627 E.00604
G1 X83.82 Y101.272 E.00717
G1 X83.767 Y100.825 E.00885
G1 X83.76 Y96.191 E.09115
G1 X81.449 Y96.188 E.04545
G1 X81.134 Y96.141 E.00626
G1 X80.938 Y96.083 E.00403
G1 X80.747 Y96 E.0041
G1 X80.567 Y95.896 E.00409
G1 X80.4 Y95.772 E.0041
G1 X80.248 Y95.629 E.0041
G1 X80.116 Y95.471 E.00405
G1 X79.969 Y95.238 E.00542
G1 X79.868 Y95.011 E.00488
G1 X79.809 Y94.814 E.00406
G1 X79.772 Y94.609 E.00409
G1 X79.76 Y94.395 E.00422
G1 X79.76 Y77.407 E.33413
G1 X79.772 Y77.193 E.00422
G1 X79.808 Y76.991 E.00403
G1 X79.907 Y76.692 E.0062
G1 X80.057 Y76.415 E.00619
G1 X80.177 Y76.253 E.00398
G1 X80.402 Y76.028 E.00625
G1 X80.564 Y75.907 E.00398
G1 X80.844 Y75.757 E.00625
G1 X81.034 Y75.687 E.00397
G1 X81.345 Y75.623 E.00626
G1 X81.556 Y75.611 E.00415
G1 X93.612 Y75.613 E.23712
G1 X93.862 Y75.639 E.00495
G1 X94.063 Y75.686 E.00407
G1 X94.259 Y75.758 E.0041
G1 X94.442 Y75.85 E.00403
G1 X94.703 Y76.032 E.00625
G1 X94.852 Y76.173 E.00404
G1 X94.986 Y76.332 E.00409
G1 X95.169 Y76.611 E.00656
G1 X97.64 Y76.611 E.04861
G1 X97.64 Y87.111 E.20653
G1 X98.64 Y87.111 E.01967
G1 X98.64 Y88.014 E.01776
G1 X97.05 Y89.604 E.04423
G1 X95.46 Y88.014 E.04423
G1 X95.46 Y87.111 E.01776
G1 X96.46 Y87.111 E.01967
G1 X96.46 Y77.791 E.18332
G1 X94.16 Y77.791 E.04524
G1 X94.159 Y77.356 E.00855
G1 X94.125 Y77.192 E.00331
G1 X94.041 Y77.035 E.00349
G1 X93.916 Y76.91 E.00349
G1 X93.76 Y76.826 E.00349
G1 X93.595 Y76.792 E.00331
G1 X81.532 Y76.791 E.23727
G1 X81.341 Y76.825 E.0038
G1 X81.167 Y76.923 E.00393
G1 X81.037 Y77.066 E.00381
G1 X80.951 Y77.265 E.00428
G1 X80.94 Y94.413 E.33728
G1 X80.955 Y94.544 E.00259
G1 X81.018 Y94.706 E.00342
G1 X81.204 Y94.908 E.0054
G1 X81.374 Y94.987 E.0037
G1 X81.535 Y95.011 E.00319
G1 X93.86 Y95.001 E.24243
G1 X93.86 Y89.811 E.10209
G1 X95.84 Y89.811 E.03895
G1 X95.84 Y91.091 E.02518
G1 X94.9 Y91.091 E.01849
; WIPE_START
M204 S6000
G1 X94.84 Y93.088 E-.3796
G1 X94.842 Y93.089 E-.0004
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




G1 X94.35 Y92.887
G1 Z3.8
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.596522
G1 F1500
M204 S6000
G1 X94.35 Y90.886 E.05697
; WIPE_START
G1 X94.35 Y92.886 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X95.077 Y94.958 Z4.2 F18000
G1 Z3.8
G1 E.4 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.365752
G1 F1500
M204 S6000
G1 X95.013 Y94.995 E.00125
G1 X95.062 Y95.023 E.00095
; WIPE_START
G1 X95.013 Y94.995 E-.16436
G1 X95.077 Y94.958 E-.21564
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X99.065 Y94.958 Z4.2 F18000
G1 Z3.8
G1 E.4 F1800
G1 F1500
M204 S6000
G1 X99.002 Y94.995 E.00125
G1 X99.05 Y95.023 E.00095
; WIPE_START
G1 X99.002 Y94.995 E-.16436
G1 X99.065 Y94.958 E-.21564
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X99.75 Y92.887 Z4.2 F18000
G1 Z3.8
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.596522
G1 F1500
M204 S6000
G1 X99.75 Y90.886 E.05697
; WIPE_START
G1 X99.75 Y92.886 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X93.19 Y96.787 Z4.2 F18000
G1 X90.148 Y98.596 Z4.2
G1 Z3.8
G1 E.4 F1800
; LINE_WIDTH: 0.0953879
G1 F1500
M204 S6000
G1 X90.252 Y98.715 E.00055
G1 X90.275 Y98.792 E.00028
M204 S10000
G1 X90.454 Y99.518 F18000
; LINE_WIDTH: 0.468759
G1 F1500
M204 S6000
G1 X90.488 Y99.781 E.00586
; LINE_WIDTH: 0.427453
G1 X90.523 Y100.044 E.00532
; LINE_WIDTH: 0.389695
G1 X90.536 Y100.332 E.00524
; LINE_WIDTH: 0.36273
G1 X90.546 Y100.586 E.00428
; LINE_WIDTH: 0.360122
G1 X90.504 Y101.128 E.00907
G1 X90.415 Y101.476 E.00598
G1 X90.292 Y101.809 E.00592
G1 X90.133 Y102.127 E.00593
G1 X89.934 Y102.421 E.00593
G1 X89.572 Y102.812 E.00888
G1 X89.142 Y103.139 E.00902
G1 X88.762 Y103.341 E.00717
G1 X88.481 Y103.448 E.00502
G1 X88.126 Y103.541 E.00612
G1 X87.8 Y103.586 E.0055
G1 X87.282 Y103.584 E.00864
G1 X86.933 Y103.533 E.00589
G1 X86.59 Y103.442 E.00593
G1 X86.204 Y103.279 E.00698
G1 X85.924 Y103.116 E.00541
G1 X85.587 Y102.863 E.00703
G1 X85.277 Y102.551 E.00735
G1 X85.133 Y102.375 E.00378
G1 X84.85 Y101.904 E.00917
G1 X84.717 Y101.579 E.00586
G1 X84.618 Y101.221 E.00619
G1 X84.553 Y100.705 E.00868
G1 X84.567 Y100.162 E.00907
; LINE_WIDTH: 0.407227
G1 X84.599 Y99.914 E.00475
; LINE_WIDTH: 0.446423
G1 X84.628 Y99.705 E.00443
; LINE_WIDTH: 0.482325
G1 X84.656 Y99.497 E.0048
M204 S10000
G1 X84.828 Y98.783 F18000
; LINE_WIDTH: 0.0867627
G1 F1500
M204 S6000
G1 X84.843 Y98.737 E.00015
G1 X84.924 Y98.647 E.00037
; WIPE_START
G1 X84.843 Y98.737 E-.27092
G1 X84.828 Y98.783 E-.10908
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X86.713 Y96.741 Z4.2 F18000
G1 Z3.8
G1 E.4 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.594857
G1 F1500
M204 S6000
G1 X87.039 Y96.721 E.00926
; LINE_WIDTH: 0.562367
G1 X87.364 Y96.701 E.00874
G1 X88.194 Y96.728 E.02223
; WIPE_START
G1 X87.364 Y96.701 E-.27279
G1 X87.039 Y96.721 E-.10721
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X86.713 Y96.741 Z4.2 F18000
G1 Z3.8
G1 E.4 F1800
; LINE_WIDTH: 0.596521
G1 F1500
M204 S6000
G1 X86.483 Y96.723 E.00657
; LINE_WIDTH: 0.560017
G1 X86.253 Y96.705 E.00615
; LINE_WIDTH: 0.507308
G1 X86.023 Y96.687 E.00554
G1 X85.44 Y96.687 E.014
G1 X85.441 Y97.332 E.01549
G1 X85.968 Y97.044 E.01442
; LINE_WIDTH: 0.525952
G1 X86.296 Y96.911 E.00883
; LINE_WIDTH: 0.567332
G1 X86.624 Y96.777 E.00957
; LINE_WIDTH: 0.601397
G1 X86.657 Y96.764 E.00104
; WIPE_START
G1 X86.624 Y96.777 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X89.66 Y96.685 Z4.2 F18000
G1 Z3.8
G1 E.4 F1800
; LINE_WIDTH: 0.507002
G1 F1500
M204 S6000
G1 X88.958 Y96.685 E.01685
; LINE_WIDTH: 0.52142
G1 X88.675 Y96.7 E.007
; LINE_WIDTH: 0.550255
G1 X88.392 Y96.715 E.00741
; LINE_WIDTH: 0.580032
G1 X88.254 Y96.73 E.00385
; LINE_WIDTH: 0.573295
G1 X88.587 Y96.843 E.0096
; LINE_WIDTH: 0.511387
G1 X88.919 Y96.956 E.00851
G1 X89.531 Y97.251 E.01646
G1 X89.66 Y97.333 E.00369
G1 X89.66 Y96.745 E.01424
M204 S10000
G1 X90.097 Y96.247 F18000
; LINE_WIDTH: 0.419992
G1 F1500
M204 S6000
G1 X85.002 Y96.251 E.10021
G1 X85.006 Y98.172 E.03778
G1 X85.058 Y98.216 E.00135
G1 X85.643 Y97.72 E.01509
G1 X86.175 Y97.429 E.01193
G1 X86.771 Y97.232 E.01236
G1 X87.419 Y97.149 E.01284
G1 X88.214 Y97.211 E.01569
G1 X88.796 Y97.376 E.0119
G1 X89.335 Y97.642 E.01182
G1 X89.719 Y97.912 E.00922
G1 X89.998 Y98.184 E.00765
G1 X90.097 Y98.066 E.00303
G1 X90.097 Y96.307 E.0346
; CHANGE_LAYER
; Z_HEIGHT: 3.92
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F1500
G1 X90.097 Y98.066 E-.33428
G1 X89.998 Y98.184 E-.02926
G1 X89.936 Y98.123 E-.01646
; WIPE_END
G1 E-.02 F1800
; layer num/total_layer_count: 32/49
; update layer progress
M73 L32
M991 S0 P31 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z4.2 I1.042 J.629 P1  F18000
G1 X94.431 Y90.682 Z4.2
G1 Z3.92
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X94.269 Y90.682 E.00342
G1 X94.269 Y90.22 E.00977
G1 X95.431 Y90.22 E.02458
G1 X95.431 Y90.682 E.00977
G1 X94.491 Y90.682 E.0199
; WIPE_START
M204 S6000
G1 X94.269 Y90.682 E-.04209
G1 X94.269 Y90.22 E-.08769
G1 X95.431 Y90.22 E-.22069
G1 X95.431 Y90.376 E-.02952
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X98.669 Y90.22 Z4.32 F18000
G1 Z3.92
G1 E.4 F1800
G1 F1500
M204 S500
G1 X99.831 Y90.22 E.02458
G1 X99.831 Y90.682 E.00977
G1 X98.669 Y90.682 E.02458
G1 X98.669 Y90.28 E.0085
; WIPE_START
M204 S6000
G1 X99.831 Y90.22 E-.22098
G1 X99.831 Y90.682 E-.08769
G1 X99.455 Y90.682 E-.07132
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X98.638 Y94.889 Z4.32 F18000
G1 Z3.92
G1 E.4 F1800
G1 F1500
M204 S500
G1 X99.407 Y94.12 E.02301
G1 X99.407 Y95.357 E.02619
G1 X98.169 Y95.357 E.02619
G1 X98.595 Y94.931 E.01276
M204 S10000
G1 X98.338 Y94.589 F18000
G1 F1500
M204 S500
G1 X99.831 Y93.096 E.04469
G1 X99.831 Y95.782 E.05685
G1 X97.145 Y95.782 E.05685
G1 X98.295 Y94.631 E.03444
; WIPE_START
M204 S6000
G1 X99.71 Y93.217 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X96.569 Y87.944 Z4.32 F18000
G1 Z3.92
G1 E.4 F1800
G1 F1500
M204 S500
G1 X97.531 Y87.944 E.02035
G1 X97.05 Y88.425 E.01439
G1 X96.612 Y87.987 E.01312
; WIPE_START
M204 S6000
G1 X97.531 Y87.944 E-.17484
G1 X97.05 Y88.425 E-.1292
M73 P73 R7
G1 X96.767 Y88.143 E-.07596
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X94.693 Y94.12 Z4.32 F18000
G1 Z3.92
G1 E.4 F1800
G1 F1500
M204 S500
G1 X95.931 Y95.357 E.03704
G1 X94.693 Y95.357 E.02619
G1 X94.693 Y94.18 E.02492
; WIPE_START
M204 S6000
G1 X95.931 Y95.357 E-.32452
G1 X95.639 Y95.357 E-.05549
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X89.374 Y98.167 Z4.32 F18000
G1 Z3.92
G1 E.4 F1800
G1 F1500
M204 S500
G1 X89.182 Y98.03 E.00499
G1 X88.67 Y97.766 E.0122
G1 X88.154 Y97.615 E.01137
G1 X87.781 Y97.565 E.00797
G1 X87.45 Y97.557 E.007
G1 X86.878 Y97.628 E.0122
G1 X86.352 Y97.798 E.0117
G1 X85.885 Y98.05 E.01123
G1 X85.581 Y98.278 E.00805
G1 X85.306 Y98.54 E.00804
G1 X84.991 Y98.948 E.0109
G1 X84.788 Y99.312 E.00881
G1 X84.598 Y99.262 E.00416
G1 X84.593 Y95.842 E.07239
G1 X90.507 Y95.837 E.12517
G1 X90.507 Y99.272 E.0727
G1 X90.305 Y99.315 E.00436
G1 X90.087 Y98.916 E.00961
G1 X89.736 Y98.479 E.01187
G1 X89.451 Y98.222 E.00811
G1 X89.423 Y98.202 E.00074
M204 S10000
G1 X89.127 Y98.512 F18000
G1 F1500
M204 S500
G1 X89.185 Y98.554 E.0015
G1 X89.427 Y98.771 E.00687
G1 X89.737 Y99.158 E.01049
G1 X89.877 Y99.396 E.00584
G1 X90.007 Y99.689 E.00679
G1 X90.13 Y100.133 E.00975
G1 X90.172 Y100.601 E.00995
G1 X90.13 Y101.06 E.00975
G1 X90.054 Y101.371 E.00679
G1 X89.959 Y101.63 E.00584
G1 X89.719 Y102.075 E.0107
G1 X89.418 Y102.441 E.01003
G1 X89.056 Y102.747 E.01003
G1 X88.615 Y102.994 E.01069
G1 X88.358 Y103.093 E.00584
G1 X88.047 Y103.174 E.00679
G1 X87.589 Y103.222 E.00975
G1 X87.121 Y103.187 E.00995
G1 X86.666 Y103.069 E.00995
G1 X86.248 Y102.875 E.00975
G1 X85.978 Y102.698 E.00683
G1 X85.732 Y102.489 E.00683
G1 X85.429 Y102.142 E.00975
G1 X85.193 Y101.746 E.00975
G1 X85.07 Y101.448 E.00683
G1 X84.984 Y101.137 E.00683
G1 X84.929 Y100.679 E.00975
G1 X84.958 Y100.206 E.01003
G1 X85.084 Y99.717 E.01069
G1 X85.19 Y99.462 E.00584
G1 X85.346 Y99.182 E.00679
G1 X85.622 Y98.825 E.00955
G1 X85.856 Y98.602 E.00683
G1 X86.114 Y98.408 E.00683
G1 X86.52 Y98.19 E.00975
G1 X86.97 Y98.044 E.01003
G1 X87.472 Y97.982 E.01069
G1 X87.748 Y97.988 E.00585
G1 X88.066 Y98.031 E.00679
G1 X88.512 Y98.161 E.00983
G1 X88.961 Y98.393 E.01069
G1 X89.079 Y98.477 E.00307
M204 S250
G1 X88.89 Y98.845 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X88.929 Y98.873 E.00094
G1 X89.128 Y99.053 E.00527
G1 X89.399 Y99.391 E.00852
G1 X89.512 Y99.583 E.0044
G1 X89.621 Y99.827 E.00525
G1 X89.725 Y100.206 E.00773
G1 X89.761 Y100.601 E.00779
G1 X89.726 Y100.992 E.00773
G1 X89.662 Y101.252 E.00525
G1 X89.585 Y101.462 E.0044
G1 X89.377 Y101.845 E.00858
G1 X89.125 Y102.153 E.00782
G1 X88.822 Y102.41 E.00782
G1 X88.441 Y102.623 E.00858
G1 X88.232 Y102.703 E.0044
G1 X87.974 Y102.77 E.00525
G1 X87.583 Y102.811 E.00774
G1 X87.188 Y102.782 E.0078
G1 X86.804 Y102.682 E.0078
G1 X86.447 Y102.517 E.00773
G1 X86.224 Y102.369 E.00526
G1 X86.02 Y102.197 E.00526
G1 X85.761 Y101.9 E.00774
G1 X85.56 Y101.563 E.00773
G1 X85.458 Y101.315 E.00526
G1 X85.387 Y101.057 E.00526
G1 X85.34 Y100.667 E.00773
G1 X85.364 Y100.27 E.00782
G1 X85.473 Y99.848 E.00858
G1 X85.559 Y99.641 E.0044
G1 X85.689 Y99.408 E.00525
G1 X85.927 Y99.1 E.00767
G1 X86.121 Y98.915 E.00526
G1 X86.335 Y98.754 E.00526
G1 X86.681 Y98.568 E.00773
G1 X87.059 Y98.445 E.00782
G1 X87.492 Y98.392 E.00858
G1 X87.716 Y98.397 E.0044
G1 X87.98 Y98.433 E.00525
G1 X88.359 Y98.543 E.00776
G1 X88.747 Y98.743 E.00858
G1 X88.841 Y98.811 E.00228
; WIPE_START
M204 S6000
G1 X88.929 Y98.873 E-.0205
G1 X89.128 Y99.053 E-.05095
G1 X89.399 Y99.391 E-.0823
G1 X89.512 Y99.583 E-.04247
G1 X89.621 Y99.827 E-.05071
G1 X89.725 Y100.206 E-.07472
G1 X89.753 Y100.512 E-.05836
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X93.071 Y93.639 Z4.32 F18000
G1 X95.869 Y87.844 Z4.32
G1 Z3.92
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X95.869 Y87.52 E.00686
G1 X96.869 Y87.52 E.02117
G1 X96.869 Y77.382 E.21459
G1 X94.582 Y77.382 E.0484
G1 X94.514 Y77.05 E.00717
G1 X94.373 Y76.788 E.0063
G1 X94.163 Y76.578 E.00629
G1 X93.901 Y76.437 E.00629
G1 X93.636 Y76.382 E.00572
G1 X81.496 Y76.382 E.25697
G1 X81.207 Y76.433 E.0062
G1 X80.929 Y76.583 E.00669
G1 X80.691 Y76.836 E.00736
G1 X80.542 Y77.18 E.00795
G1 X80.531 Y94.446 E.36544
G1 X80.566 Y94.686 E.00514
G1 X80.678 Y94.946 E.006
G1 X80.961 Y95.246 E.00873
G1 X81.256 Y95.384 E.00688
G1 X81.505 Y95.42 E.00534
G1 X94.269 Y95.41 E.27016
G1 X94.269 Y93.096 E.04898
G1 X96.955 Y95.782 E.08039
G1 X90.931 Y95.782 E.12751
G1 X90.931 Y100.587 E.1017
G1 X90.918 Y100.869 E.00598
G1 X90.877 Y101.197 E.00699
G1 X90.782 Y101.588 E.00852
G1 X90.643 Y101.963 E.00847
G1 X90.462 Y102.316 E.00839
G1 X90.187 Y102.713 E.01022
G1 X89.97 Y102.961 E.00697
G1 X89.513 Y103.353 E.01275
G1 X89.121 Y103.592 E.00973
G1 X88.822 Y103.732 E.00698
G1 X88.432 Y103.864 E.00871
G1 X87.841 Y103.969 E.01271
G1 X87.25 Y103.967 E.01251
G1 X86.854 Y103.908 E.00848
G1 X86.468 Y103.803 E.00848
G1 X86.097 Y103.652 E.00847
G1 X85.738 Y103.454 E.00867
G1 X85.328 Y103.146 E.01085
G1 X84.987 Y102.804 E.01022
G1 X84.747 Y102.489 E.00839
G1 X84.543 Y102.144 E.00847
G1 X84.384 Y101.781 E.00839
G1 X84.249 Y101.318 E.01022
G1 X84.176 Y100.81 E.01087
G1 X84.168 Y95.783 E.1064
G1 X81.479 Y95.778 E.05691
G1 X81.223 Y95.741 E.00548
G1 X80.931 Y95.634 E.00659
G1 X80.792 Y95.554 E.0034
G1 X80.546 Y95.348 E.00678
G1 X80.359 Y95.096 E.00664
G1 X80.264 Y94.897 E.00468
G1 X80.207 Y94.715 E.00403
G1 X80.169 Y94.383 E.00708
G1 X80.169 Y77.419 E.35906
G1 X80.206 Y77.092 E.00697
G1 X80.284 Y76.855 E.00527
G1 X80.403 Y76.635 E.00528
G1 X80.488 Y76.521 E.00301
G1 X80.67 Y76.339 E.00547
G1 X80.785 Y76.254 E.00301
G1 X81.012 Y76.131 E.00547
G1 X81.146 Y76.082 E.00301
G1 X81.399 Y76.03 E.00547
G1 X93.593 Y76.022 E.25809
G1 X93.794 Y76.043 E.00427
G1 X94.096 Y76.134 E.00669
G1 X94.234 Y76.203 E.00326
G1 X94.416 Y76.328 E.00468
G1 X94.657 Y76.577 E.00732
G1 X94.948 Y77.02 E.01123
G1 X97.231 Y77.02 E.04831
G1 X97.231 Y87.52 E.22224
G1 X98.231 Y87.52 E.02117
G1 X98.231 Y87.844 E.00686
G1 X97.05 Y89.025 E.03534
G1 X95.912 Y87.887 E.03407
; WIPE_START
M204 S6000
G1 X95.869 Y87.52 E-.07014
G1 X96.869 Y87.52 E-.19
G1 X96.869 Y86.889 E-.11986
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X94.84 Y91.091 Z4.32 F18000
G1 Z3.92
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X94.84 Y93.088 E.03928
G1 X97.05 Y95.298 E.06147
G1 X99.26 Y93.088 E.06147
G1 X99.26 Y91.091 E.03928
G1 X98.26 Y91.091 E.01967
G1 X98.26 Y89.811 E.02518
G1 X100.24 Y89.811 E.03895
G1 X100.24 Y96.191 E.12549
G1 X91.34 Y96.191 E.17505
G1 X91.34 Y100.596 E.08664
G1 X91.326 Y100.904 E.00607
G1 X91.28 Y101.271 E.00726
G1 X91.174 Y101.708 E.00885
G1 X91.018 Y102.129 E.00883
G1 X90.814 Y102.527 E.0088
G1 X90.51 Y102.964 E.01048
G1 X90.11 Y103.395 E.01156
G1 X89.757 Y103.682 E.00895
G1 X89.575 Y103.805 E.00432
G1 X89.309 Y103.956 E.00601
G1 X88.975 Y104.113 E.00726
G1 X88.546 Y104.257 E.0089
G1 X88.334 Y104.309 E.0043
G1 X87.883 Y104.376 E.00896
G1 X87.665 Y104.389 E.00429
G1 X87.214 Y104.376 E.00889
G1 X86.769 Y104.309 E.00883
G1 X86.336 Y104.191 E.00883
G1 X85.92 Y104.022 E.00883
G1 X85.524 Y103.804 E.00889
G1 X85.054 Y103.451 E.01156
G1 X84.679 Y103.074 E.01047
G1 X84.407 Y102.718 E.00881
G1 X84.179 Y102.331 E.00883
G1 X83.998 Y101.922 E.0088
G1 X83.849 Y101.41 E.01047
G1 X83.767 Y100.828 E.01156
G1 X83.76 Y96.191 E.09121
G1 X81.449 Y96.188 E.04545
G1 X81.134 Y96.141 E.00626
G1 X80.938 Y96.083 E.00403
G1 X80.747 Y96 E.00409
G1 X80.567 Y95.896 E.00409
G1 X80.4 Y95.772 E.00409
G1 X80.248 Y95.629 E.00409
G1 X80.115 Y95.47 E.00409
G1 X80.001 Y95.298 E.00405
G1 X79.882 Y95.047 E.00547
G1 X79.808 Y94.812 E.00483
G1 X79.772 Y94.609 E.00407
G1 X79.76 Y94.395 E.00422
G1 X79.76 Y77.407 E.33413
G1 X79.772 Y77.193 E.00422
G1 X79.808 Y76.991 E.00404
G1 X79.907 Y76.692 E.00619
G1 X80.057 Y76.415 E.00619
G1 X80.177 Y76.253 E.00397
G1 X80.402 Y76.028 E.00626
G1 X80.564 Y75.908 E.00397
G1 X80.844 Y75.757 E.00626
G1 X81.034 Y75.687 E.00397
G1 X81.345 Y75.623 E.00626
G1 X81.556 Y75.611 E.00415
G1 X93.614 Y75.613 E.23716
G1 X93.862 Y75.639 E.00491
G1 X94.063 Y75.686 E.00407
G1 X94.259 Y75.758 E.00409
G1 X94.443 Y75.85 E.00405
G1 X94.672 Y76.008 E.00547
G1 X94.853 Y76.174 E.00483
G1 X94.986 Y76.332 E.00407
G1 X95.169 Y76.611 E.00656
G1 X97.64 Y76.611 E.04861
G1 X97.64 Y87.111 E.20653
G1 X98.64 Y87.111 E.01967
G1 X98.64 Y88.014 E.01776
G1 X97.05 Y89.604 E.04423
G1 X95.46 Y88.014 E.04423
G1 X95.46 Y87.111 E.01776
G1 X96.46 Y87.111 E.01967
G1 X96.46 Y77.791 E.18332
G1 X94.16 Y77.791 E.04524
G1 X94.159 Y77.356 E.00855
G1 X94.125 Y77.191 E.00331
G1 X94.041 Y77.035 E.00349
G1 X93.916 Y76.91 E.00349
G1 X93.759 Y76.826 E.00349
G1 X93.595 Y76.792 E.00331
G1 X81.532 Y76.791 E.23727
G1 X81.343 Y76.824 E.00376
G1 X81.182 Y76.911 E.00362
G1 X81.038 Y77.064 E.00412
G1 X80.951 Y77.265 E.00431
G1 X80.94 Y94.416 E.33735
G1 X80.963 Y94.573 E.00313
G1 X81.025 Y94.718 E.0031
G1 X81.205 Y94.908 E.00515
G1 X81.374 Y94.987 E.00367
G1 X81.535 Y95.011 E.00319
G1 X93.86 Y95.001 E.24243
G1 X93.86 Y89.811 E.10209
G1 X95.84 Y89.811 E.03895
G1 X95.84 Y91.091 E.02518
G1 X94.9 Y91.091 E.01849
; WIPE_START
M204 S6000
G1 X94.84 Y93.088 E-.3796
G1 X94.842 Y93.089 E-.0004
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




G1 X94.35 Y92.887
G1 Z3.92
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.596522
G1 F1500
M204 S6000
G1 X94.35 Y90.886 E.05697
; WIPE_START
G1 X94.35 Y92.886 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X95.077 Y94.958 Z4.32 F18000
G1 Z3.92
G1 E.4 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.365752
G1 F1500
M204 S6000
G1 X95.013 Y94.995 E.00125
G1 X95.062 Y95.023 E.00095
; WIPE_START
G1 X95.013 Y94.995 E-.16436
G1 X95.077 Y94.958 E-.21564
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X99.065 Y94.958 Z4.32 F18000
G1 Z3.92
G1 E.4 F1800
G1 F1500
M204 S6000
G1 X99.002 Y94.995 E.00125
G1 X99.05 Y95.023 E.00095
; WIPE_START
G1 X99.002 Y94.995 E-.16436
G1 X99.065 Y94.958 E-.21564
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X99.75 Y92.887 Z4.32 F18000
G1 Z3.92
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.596522
G1 F1500
M204 S6000
G1 X99.75 Y90.886 E.05697
; WIPE_START
G1 X99.75 Y92.886 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X93.169 Y96.753 Z4.32 F18000
G1 X90.101 Y98.555 Z4.32
G1 Z3.92
G1 E.4 F1800
; LINE_WIDTH: 0.0953604
G1 F1500
M204 S6000
G1 X90.252 Y98.715 E.00076
G1 X90.276 Y98.785 E.00026
M204 S10000
G1 X90.447 Y99.501 F18000
; LINE_WIDTH: 0.4757
G1 F1500
M204 S6000
G1 X90.485 Y99.771 E.00611
; LINE_WIDTH: 0.430461
G1 X90.522 Y100.041 E.0055
; LINE_WIDTH: 0.390054
G1 X90.536 Y100.332 E.0053
; LINE_WIDTH: 0.362966
G1 X90.546 Y100.586 E.00428
; LINE_WIDTH: 0.360327
G1 X90.504 Y101.129 E.00908
G1 X90.419 Y101.477 E.00598
G1 X90.309 Y101.775 E.00531
G1 X90.038 Y102.271 E.00943
G1 X89.676 Y102.717 E.00958
G1 X89.259 Y103.067 E.0091
G1 X88.679 Y103.378 E.01098
G1 X88.103 Y103.547 E.01002
M73 P74 R7
G1 X87.648 Y103.599 E.00763
G1 X87.284 Y103.584 E.00608
G1 X86.933 Y103.533 E.00593
G1 X86.59 Y103.442 E.00593
G1 X86.076 Y103.207 E.00942
G1 X85.807 Y103.041 E.00528
G1 X85.583 Y102.862 E.00479
G1 X85.277 Y102.551 E.00728
G1 X85.133 Y102.375 E.00379
G1 X84.85 Y101.904 E.00918
G1 X84.717 Y101.579 E.00587
G1 X84.619 Y101.235 E.00597
G1 X84.553 Y100.705 E.00891
G1 X84.567 Y100.162 E.00907
; LINE_WIDTH: 0.407198
G1 X84.599 Y99.915 E.00475
; LINE_WIDTH: 0.446423
G1 X84.628 Y99.706 E.00443
; LINE_WIDTH: 0.482352
G1 X84.656 Y99.497 E.00481
M204 S10000
G1 X84.828 Y98.783 F18000
; LINE_WIDTH: 0.0867303
G1 F1500
M204 S6000
G1 X84.843 Y98.737 E.00015
G1 X84.924 Y98.647 E.00037
; WIPE_START
G1 X84.843 Y98.737 E-.27089
G1 X84.828 Y98.783 E-.10911
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X86.712 Y96.741 Z4.32 F18000
G1 Z3.92
G1 E.4 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.594977
G1 F1500
M204 S6000
G1 X87.037 Y96.721 E.00922
; LINE_WIDTH: 0.562455
G1 X87.361 Y96.701 E.0087
G1 X88.194 Y96.728 E.02232
; WIPE_START
G1 X87.361 Y96.701 E-.27345
G1 X87.037 Y96.721 E-.10655
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X86.712 Y96.741 Z4.32 F18000
G1 Z3.92
G1 E.4 F1800
; LINE_WIDTH: 0.596619
G1 F1500
M204 S6000
G1 X86.483 Y96.723 E.00657
; LINE_WIDTH: 0.560072
G1 X86.253 Y96.705 E.00615
; LINE_WIDTH: 0.507299
G1 X86.023 Y96.687 E.00554
G1 X85.44 Y96.687 E.014
G1 X85.441 Y97.332 E.01549
G1 X85.968 Y97.044 E.01442
; LINE_WIDTH: 0.525967
G1 X86.296 Y96.911 E.00883
; LINE_WIDTH: 0.567397
G1 X86.623 Y96.777 E.00956
; LINE_WIDTH: 0.601502
G1 X86.657 Y96.764 E.00104
; WIPE_START
G1 X86.623 Y96.777 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X89.659 Y96.685 Z4.32 F18000
G1 Z3.92
G1 E.4 F1800
; LINE_WIDTH: 0.508032
G1 F1500
M204 S6000
G1 X88.966 Y96.686 E.01668
; LINE_WIDTH: 0.522262
G1 X88.679 Y96.7 E.00711
; LINE_WIDTH: 0.550722
G1 X88.392 Y96.715 E.00752
; LINE_WIDTH: 0.580162
G1 X88.254 Y96.73 E.00386
; LINE_WIDTH: 0.573537
G1 X88.59 Y96.844 E.00971
; LINE_WIDTH: 0.51244
G1 X88.927 Y96.958 E.00863
G1 X89.659 Y97.33 E.01993
G1 X89.659 Y96.745 E.01418
M204 S10000
G1 X90.097 Y96.247 F18000
; LINE_WIDTH: 0.419992
G1 F1500
M204 S6000
G1 X85.002 Y96.251 E.10021
G1 X85.006 Y98.172 E.03779
G1 X85.057 Y98.217 E.00134
G1 X85.643 Y97.72 E.0151
G1 X86.175 Y97.429 E.01193
G1 X86.771 Y97.232 E.01235
G1 X87.416 Y97.149 E.01278
G1 X88.214 Y97.211 E.01576
G1 X88.804 Y97.379 E.01206
G1 X89.383 Y97.673 E.01279
G1 X89.951 Y98.134 E.01438
G1 X90.034 Y98.059 E.00221
G1 X90.097 Y98.066 E.00124
G1 X90.097 Y96.307 E.03461
; CHANGE_LAYER
; Z_HEIGHT: 4.04
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F1500
G1 X90.097 Y98.066 E-.33429
G1 X90.034 Y98.059 E-.01202
G1 X89.951 Y98.134 E-.02136
G1 X89.901 Y98.094 E-.01233
; WIPE_END
G1 E-.02 F1800
; layer num/total_layer_count: 33/49
; update layer progress
M73 L33
M991 S0 P32 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z4.32 I1.038 J.635 P1  F18000
G1 X94.431 Y90.682 Z4.32
G1 Z4.04
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X94.269 Y90.682 E.00342
G1 X94.269 Y90.22 E.00977
G1 X95.431 Y90.22 E.02458
G1 X95.431 Y90.682 E.00977
G1 X94.491 Y90.682 E.0199
; WIPE_START
M204 S6000
G1 X94.269 Y90.682 E-.04209
G1 X94.269 Y90.22 E-.08769
G1 X95.431 Y90.22 E-.22069
G1 X95.431 Y90.376 E-.02952
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X98.669 Y90.22 Z4.44 F18000
G1 Z4.04
G1 E.4 F1800
G1 F1500
M204 S500
G1 X99.831 Y90.22 E.02458
G1 X99.831 Y90.682 E.00977
G1 X98.669 Y90.682 E.02458
G1 X98.669 Y90.28 E.0085
; WIPE_START
M204 S6000
G1 X99.831 Y90.22 E-.22098
G1 X99.831 Y90.682 E-.08769
G1 X99.455 Y90.682 E-.07132
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X98.638 Y94.889 Z4.44 F18000
G1 Z4.04
G1 E.4 F1800
G1 F1500
M204 S500
G1 X99.407 Y94.12 E.02301
G1 X99.407 Y95.357 E.02619
G1 X98.169 Y95.357 E.02619
G1 X98.595 Y94.931 E.01276
M204 S10000
G1 X98.338 Y94.589 F18000
G1 F1500
M204 S500
G1 X99.831 Y93.096 E.04469
G1 X99.831 Y95.782 E.05685
G1 X97.145 Y95.782 E.05685
G1 X98.295 Y94.631 E.03444
; WIPE_START
M204 S6000
G1 X99.71 Y93.217 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X96.569 Y87.944 Z4.44 F18000
G1 Z4.04
G1 E.4 F1800
G1 F1500
M204 S500
G1 X97.531 Y87.944 E.02035
G1 X97.05 Y88.425 E.01439
G1 X96.612 Y87.987 E.01312
; WIPE_START
M204 S6000
G1 X97.531 Y87.944 E-.17484
G1 X97.05 Y88.425 E-.1292
G1 X96.767 Y88.143 E-.07596
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X94.693 Y94.12 Z4.44 F18000
G1 Z4.04
G1 E.4 F1800
G1 F1500
M204 S500
G1 X95.931 Y95.357 E.03704
G1 X94.693 Y95.357 E.02619
G1 X94.693 Y94.18 E.02492
; WIPE_START
M204 S6000
G1 X95.931 Y95.357 E-.32452
G1 X95.639 Y95.357 E-.05549
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X89.366 Y98.161 Z4.44 F18000
G1 Z4.04
G1 E.4 F1800
G1 F1500
M204 S500
G1 X89.18 Y98.028 E.00484
G1 X88.67 Y97.766 E.01215
G1 X88.154 Y97.615 E.01136
G1 X87.781 Y97.564 E.00798
G1 X87.447 Y97.557 E.00706
G1 X86.878 Y97.628 E.01215
G1 X86.346 Y97.8 E.01183
G1 X85.844 Y98.078 E.01215
G1 X85.579 Y98.28 E.00706
G1 X85.306 Y98.54 E.00798
G1 X84.991 Y98.948 E.0109
G1 X84.788 Y99.312 E.00881
G1 X84.598 Y99.262 E.00416
G1 X84.593 Y95.842 E.07239
G1 X90.507 Y95.837 E.12517
G1 X90.507 Y99.272 E.0727
G1 X90.305 Y99.315 E.00436
G1 X90.058 Y98.872 E.01073
G1 X89.731 Y98.474 E.0109
G1 X89.451 Y98.222 E.00797
G1 X89.415 Y98.196 E.00095
M204 S10000
G1 X89.119 Y98.507 F18000
G1 F1500
M204 S500
G1 X89.185 Y98.554 E.00171
G1 X89.424 Y98.768 E.00679
G1 X89.71 Y99.117 E.00955
G1 X89.876 Y99.394 E.00683
G1 X90.007 Y99.689 E.00683
G1 X90.13 Y100.133 E.00975
G1 X90.171 Y100.592 E.00975
G1 X90.152 Y100.912 E.00679
G1 X90.104 Y101.186 E.0059
G1 X89.947 Y101.664 E.01064
G1 X89.716 Y102.078 E.01003
G1 X89.418 Y102.441 E.00995
G1 X89.056 Y102.747 E.01003
G1 X88.618 Y102.993 E.01064
G1 X88.358 Y103.093 E.0059
G1 X88.047 Y103.174 E.00679
G1 X87.589 Y103.222 E.00975
G1 X87.12 Y103.187 E.00995
G1 X86.675 Y103.071 E.00975
G1 X86.38 Y102.945 E.00679
G1 X86.137 Y102.807 E.0059
G1 X85.741 Y102.499 E.01064
G1 X85.435 Y102.149 E.00983
G1 X85.261 Y101.877 E.00683
G1 X85.121 Y101.586 E.00683
G1 X84.986 Y101.146 E.00976
G1 X84.929 Y100.679 E.00995
G1 X84.958 Y100.206 E.01003
G1 X85.083 Y99.72 E.01064
G1 X85.19 Y99.462 E.0059
G1 X85.346 Y99.182 E.00679
G1 X85.622 Y98.825 E.00955
G1 X85.854 Y98.603 E.00679
G1 X86.076 Y98.435 E.0059
G1 X86.516 Y98.191 E.01064
G1 X86.97 Y98.044 E.0101
G1 X87.469 Y97.982 E.01064
G1 X87.748 Y97.988 E.0059
G1 X88.066 Y98.031 E.00679
G1 X88.511 Y98.161 E.00983
G1 X88.958 Y98.392 E.01064
G1 X89.071 Y98.472 E.00292
M204 S250
G1 X88.882 Y98.84 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X88.929 Y98.873 E.00113
G1 X89.127 Y99.052 E.00525
G1 X89.375 Y99.353 E.00767
G1 X89.512 Y99.583 E.00526
G1 X89.621 Y99.827 E.00526
G1 X89.725 Y100.206 E.00774
G1 X89.761 Y100.598 E.00773
G1 X89.745 Y100.864 E.00525
G1 X89.706 Y101.087 E.00444
G1 X89.57 Y101.499 E.00853
G1 X89.377 Y101.846 E.00782
G1 X89.125 Y102.152 E.0078
G1 X88.822 Y102.41 E.00782
G1 X88.443 Y102.622 E.00853
G1 X88.232 Y102.703 E.00445
G1 X87.974 Y102.77 E.00525
G1 X87.583 Y102.811 E.00774
G1 X87.188 Y102.782 E.0078
G1 X86.807 Y102.683 E.00773
G1 X86.562 Y102.578 E.00525
G1 X86.365 Y102.466 E.00445
G1 X86.023 Y102.2 E.00853
G1 X85.763 Y101.903 E.00776
G1 X85.619 Y101.677 E.00526
G1 X85.503 Y101.436 E.00526
G1 X85.387 Y101.06 E.00774
G1 X85.34 Y100.667 E.00779
G1 X85.364 Y100.27 E.00782
G1 X85.472 Y99.85 E.00853
G1 X85.559 Y99.641 E.00444
G1 X85.689 Y99.408 E.00525
G1 X85.927 Y99.1 E.00767
G1 X86.12 Y98.915 E.00525
G1 X86.3 Y98.779 E.00445
G1 X86.68 Y98.568 E.00854
G1 X87.059 Y98.445 E.00784
G1 X87.49 Y98.392 E.00854
G1 X87.716 Y98.397 E.00445
G1 X87.98 Y98.433 E.00525
G1 X88.359 Y98.543 E.00776
G1 X88.745 Y98.742 E.00853
G1 X88.833 Y98.805 E.00214
; WIPE_START
M204 S6000
G1 X88.929 Y98.873 E-.02232
G1 X89.127 Y99.052 E-.0507
G1 X89.375 Y99.353 E-.07411
G1 X89.512 Y99.583 E-.05083
G1 X89.621 Y99.827 E-.05083
G1 X89.725 Y100.206 E-.07473
G1 X89.752 Y100.502 E-.05648
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X93.073 Y93.63 Z4.44 F18000
G1 X95.869 Y87.844 Z4.44
G1 Z4.04
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X95.869 Y87.52 E.00686
G1 X96.869 Y87.52 E.02117
G1 X96.869 Y77.382 E.21459
G1 X94.583 Y77.382 E.0484
G1 X94.514 Y77.05 E.00717
G1 X94.373 Y76.788 E.00629
G1 X94.163 Y76.578 E.00629
G1 X93.901 Y76.437 E.00629
G1 X93.636 Y76.382 E.00571
G1 X81.496 Y76.382 E.25697
G1 X81.201 Y76.434 E.00634
G1 X80.908 Y76.6 E.00713
G1 X80.688 Y76.841 E.0069
G1 X80.542 Y77.18 E.00783
G1 X80.531 Y94.437 E.36524
G1 X80.555 Y94.643 E.0044
G1 X80.665 Y94.928 E.00645
G1 X80.958 Y95.245 E.00914
G1 X81.256 Y95.384 E.00695
G1 X81.505 Y95.42 E.00533
G1 X94.269 Y95.41 E.27016
G1 X94.269 Y93.096 E.04898
G1 X96.955 Y95.782 E.08039
G1 X90.931 Y95.782 E.12751
G1 X90.918 Y100.865 E.1076
G1 X90.877 Y101.197 E.00708
G1 X90.782 Y101.588 E.00852
G1 X90.643 Y101.963 E.00847
G1 X90.456 Y102.328 E.00867
G1 X90.105 Y102.815 E.01271
G1 X89.736 Y103.177 E.01095
G1 X89.343 Y103.466 E.01031
G1 X88.812 Y103.737 E.01262
G1 X88.318 Y103.891 E.01095
G1 X87.837 Y103.969 E.01031
G1 X87.659 Y103.979 E.00377
G1 X87.25 Y103.967 E.00866
G1 X86.668 Y103.864 E.01252
G1 X86.28 Y103.733 E.00866
G1 X85.918 Y103.561 E.00848
G1 X85.58 Y103.347 E.00847
G1 X85.269 Y103.094 E.00848
G1 X84.99 Y102.807 E.00848
G1 X84.747 Y102.489 E.00847
G1 X84.543 Y102.144 E.00848
G1 X84.38 Y101.773 E.00857
G1 X84.3 Y101.526 E.0055
G1 X84.224 Y101.201 E.00708
G1 X84.176 Y100.801 E.00853
G1 X84.168 Y95.783 E.10621
G1 X81.479 Y95.778 E.05691
G1 X81.223 Y95.741 E.00548
G1 X80.931 Y95.634 E.00659
G1 X80.792 Y95.554 E.00339
G1 X80.546 Y95.348 E.00678
G1 X80.448 Y95.23 E.00325
G1 X80.329 Y95.041 E.00472
G1 X80.207 Y94.719 E.00728
G1 X80.169 Y94.383 E.00716
G1 X80.169 Y77.419 E.35905
G1 X80.206 Y77.092 E.00697
G1 X80.285 Y76.853 E.00533
G1 X80.385 Y76.664 E.00453
G1 X80.49 Y76.519 E.00379
G1 X80.666 Y76.343 E.00524
G1 X80.84 Y76.219 E.00453
G1 X80.999 Y76.137 E.00379
G1 X81.241 Y76.057 E.00538
G1 X81.39 Y76.03 E.00321
G1 X93.595 Y76.022 E.25833
G1 X93.946 Y76.079 E.00752
G1 X94.24 Y76.206 E.00678
G1 X94.374 Y76.294 E.0034
G1 X94.49 Y76.391 E.0032
G1 X94.662 Y76.585 E.00547
G1 X94.948 Y77.02 E.01103
G1 X97.231 Y77.02 E.04831
G1 X97.231 Y87.52 E.22224
G1 X98.231 Y87.52 E.02117
G1 X98.231 Y87.844 E.00686
G1 X97.05 Y89.025 E.03534
G1 X95.912 Y87.887 E.03407
; WIPE_START
M204 S6000
G1 X95.869 Y87.52 E-.07014
G1 X96.869 Y87.52 E-.19
G1 X96.869 Y86.889 E-.11986
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X94.84 Y91.091 Z4.44 F18000
G1 Z4.04
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X94.84 Y93.088 E.03928
G1 X97.05 Y95.298 E.06147
G1 X99.26 Y93.088 E.06147
G1 X99.26 Y91.091 E.03928
G1 X98.26 Y91.091 E.01967
G1 X98.26 Y89.811 E.02518
G1 X100.24 Y89.811 E.03895
G1 X100.24 Y96.191 E.12549
G1 X91.34 Y96.191 E.17505
G1 X91.34 Y100.596 E.08664
G1 X91.326 Y100.9 E.00598
G1 X91.28 Y101.271 E.00735
G1 X91.174 Y101.708 E.00885
G1 X91.018 Y102.129 E.00883
G1 X90.812 Y102.531 E.00889
G1 X90.695 Y102.715 E.0043
G1 X90.419 Y103.077 E.00896
G1 X89.997 Y103.493 E.01165
G1 X89.569 Y103.808 E.01045
G1 X89.382 Y103.918 E.00427
G1 X88.971 Y104.114 E.00895
G1 X88.406 Y104.291 E.01165
G1 X87.882 Y104.376 E.01045
G1 X87.665 Y104.389 E.00427
G1 X87.214 Y104.376 E.00889
G1 X86.766 Y104.309 E.0089
G1 X86.554 Y104.257 E.0043
G1 X86.126 Y104.113 E.00889
G1 X85.72 Y103.92 E.00883
G1 X85.341 Y103.68 E.00883
G1 X84.992 Y103.397 E.00883
G1 X84.679 Y103.075 E.00883
G1 X84.407 Y102.718 E.00883
G1 X84.179 Y102.331 E.00883
G1 X83.997 Y101.919 E.00886
G1 X83.906 Y101.636 E.00585
G1 X83.82 Y101.272 E.00736
G1 X83.767 Y100.825 E.00885
G1 X83.76 Y96.191 E.09115
G1 X81.449 Y96.188 E.04545
G1 X81.134 Y96.141 E.00626
G1 X80.938 Y96.083 E.00403
G1 X80.747 Y96 E.0041
G1 X80.567 Y95.896 E.00409
G1 X80.4 Y95.772 E.0041
G1 X80.248 Y95.629 E.00409
G1 X80.116 Y95.471 E.00405
G1 X79.967 Y95.234 E.00551
G1 X79.868 Y95.012 E.00479
G1 X79.809 Y94.814 E.00406
G1 X79.772 Y94.609 E.0041
G1 X79.76 Y94.395 E.00422
G1 X79.76 Y77.407 E.33413
M73 P75 R7
G1 X79.772 Y77.193 E.00422
G1 X79.808 Y76.991 E.00403
G1 X79.907 Y76.691 E.00621
G1 X80.037 Y76.447 E.00545
G1 X80.178 Y76.252 E.00472
G1 X80.4 Y76.03 E.00618
G1 X80.626 Y75.869 E.00545
G1 X80.84 Y75.759 E.00473
G1 X81.14 Y75.659 E.00623
G1 X81.342 Y75.623 E.00403
G1 X81.556 Y75.611 E.00421
G1 X93.616 Y75.613 E.23721
G1 X93.862 Y75.639 E.00486
G1 X94.063 Y75.686 E.00407
G1 X94.259 Y75.758 E.00409
G1 X94.445 Y75.851 E.00409
G1 X94.619 Y75.965 E.0041
G1 X94.776 Y76.097 E.00403
G1 X94.987 Y76.335 E.00626
G1 X95.169 Y76.611 E.0065
G1 X97.64 Y76.611 E.04861
G1 X97.64 Y87.111 E.20653
G1 X98.64 Y87.111 E.01967
G1 X98.64 Y88.014 E.01776
G1 X97.05 Y89.604 E.04423
G1 X95.46 Y88.014 E.04423
G1 X95.46 Y87.111 E.01776
G1 X96.46 Y87.111 E.01967
G1 X96.46 Y77.791 E.18332
G1 X94.16 Y77.791 E.04524
G1 X94.159 Y77.356 E.00856
G1 X94.125 Y77.191 E.00331
G1 X94.041 Y77.035 E.00349
G1 X93.916 Y76.91 E.00349
G1 X93.759 Y76.826 E.00349
G1 X93.595 Y76.792 E.00331
G1 X81.532 Y76.791 E.23727
G1 X81.341 Y76.824 E.0038
G1 X81.166 Y76.923 E.00395
G1 X81.037 Y77.066 E.00378
G1 X80.951 Y77.265 E.00428
G1 X80.94 Y94.413 E.33728
G1 X80.955 Y94.544 E.0026
G1 X81.019 Y94.707 E.00344
G1 X81.204 Y94.908 E.00538
G1 X81.374 Y94.987 E.0037
G1 X81.535 Y95.011 E.00319
G1 X93.86 Y95.001 E.24243
M73 P75 R6
G1 X93.86 Y89.811 E.10209
G1 X95.84 Y89.811 E.03895
G1 X95.84 Y91.091 E.02518
G1 X94.9 Y91.091 E.01849
; WIPE_START
M204 S6000
G1 X94.84 Y93.088 E-.3796
G1 X94.842 Y93.089 E-.0004
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




G1 X94.35 Y92.887
G1 Z4.04
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.596522
G1 F1500
M204 S6000
G1 X94.35 Y90.886 E.05697
; WIPE_START
G1 X94.35 Y92.886 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X95.077 Y94.958 Z4.44 F18000
G1 Z4.04
G1 E.4 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.365752
G1 F1500
M204 S6000
G1 X95.013 Y94.995 E.00125
G1 X95.062 Y95.023 E.00095
; WIPE_START
G1 X95.013 Y94.995 E-.16436
G1 X95.077 Y94.958 E-.21564
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X99.065 Y94.958 Z4.44 F18000
G1 Z4.04
G1 E.4 F1800
G1 F1500
M204 S6000
G1 X99.002 Y94.995 E.00125
G1 X99.05 Y95.023 E.00095
; WIPE_START
G1 X99.002 Y94.995 E-.16436
G1 X99.065 Y94.958 E-.21564
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X99.75 Y92.887 Z4.44 F18000
G1 Z4.04
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.596522
G1 F1500
M204 S6000
G1 X99.75 Y90.886 E.05697
; WIPE_START
G1 X99.75 Y92.886 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X93.176 Y96.764 Z4.44 F18000
G1 X90.116 Y98.569 Z4.44
G1 Z4.04
G1 E.4 F1800
; LINE_WIDTH: 0.0958861
G1 F1500
M204 S6000
G1 X90.252 Y98.715 E.0007
G1 X90.275 Y98.782 E.00025
M204 S10000
G1 X90.447 Y99.501 F18000
; LINE_WIDTH: 0.475769
G1 F1500
M204 S6000
G1 X90.485 Y99.771 E.00611
; LINE_WIDTH: 0.430564
G1 X90.523 Y100.041 E.0055
; LINE_WIDTH: 0.4043
G1 X90.526 Y100.078 E.00071
; LINE_WIDTH: 0.376289
G1 X90.546 Y100.574 E.00868
; LINE_WIDTH: 0.360168
G1 X90.538 Y100.836 E.00437
G1 X90.501 Y101.128 E.00491
G1 X90.414 Y101.475 E.00597
G1 X90.297 Y101.809 E.00589
G1 X90.037 Y102.279 E.00896
G1 X89.677 Y102.717 E.00947
G1 X89.257 Y103.064 E.00908
G1 X88.665 Y103.384 E.01123
G1 X88.236 Y103.518 E.00751
G1 X88.102 Y103.544 E.00227
G1 X87.647 Y103.599 E.00765
G1 X87.284 Y103.584 E.00606
G1 X86.923 Y103.531 E.00608
G1 X86.565 Y103.43 E.00622
G1 X86.103 Y103.226 E.00843
G1 X85.804 Y103.034 E.00592
G1 X85.526 Y102.813 E.00593
G1 X85.141 Y102.385 E.00961
G1 X84.927 Y102.052 E.0066
G1 X84.775 Y101.735 E.00586
G1 X84.622 Y101.238 E.00868
G1 X84.553 Y100.705 E.00896
G1 X84.567 Y100.163 E.00906
; LINE_WIDTH: 0.407222
G1 X84.599 Y99.915 E.00475
; LINE_WIDTH: 0.44647
G1 X84.628 Y99.706 E.00443
; LINE_WIDTH: 0.482417
G1 X84.656 Y99.497 E.00481
M204 S10000
G1 X84.828 Y98.783 F18000
; LINE_WIDTH: 0.0867479
G1 F1500
M204 S6000
G1 X84.843 Y98.737 E.00015
G1 X84.924 Y98.647 E.00037
; WIPE_START
G1 X84.843 Y98.737 E-.2709
G1 X84.828 Y98.783 E-.1091
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X86.712 Y96.741 Z4.44 F18000
G1 Z4.04
G1 E.4 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.595067
G1 F1500
M204 S6000
G1 X87.035 Y96.721 E.00918
; LINE_WIDTH: 0.56254
G1 X87.357 Y96.701 E.00865
G1 X88.193 Y96.728 E.02241
; WIPE_START
G1 X87.357 Y96.701 E-.27412
G1 X87.035 Y96.721 E-.10588
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X86.712 Y96.741 Z4.44 F18000
G1 Z4.04
G1 E.4 F1800
; LINE_WIDTH: 0.596747
G1 F1500
M204 S6000
G1 X86.48 Y96.723 E.00664
; LINE_WIDTH: 0.560297
G1 X86.248 Y96.705 E.00621
; LINE_WIDTH: 0.507703
G1 X86.015 Y96.687 E.0056
G1 X85.44 Y96.688 E.01383
G1 X85.441 Y97.334 E.01555
G1 X85.954 Y97.05 E.01409
; LINE_WIDTH: 0.52628
G1 X86.289 Y96.914 E.00902
; LINE_WIDTH: 0.567595
G1 X86.623 Y96.777 E.00977
; LINE_WIDTH: 0.601612
G1 X86.657 Y96.764 E.00104
; WIPE_START
G1 X86.623 Y96.777 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X89.659 Y96.685 Z4.44 F18000
G1 Z4.04
G1 E.4 F1800
; LINE_WIDTH: 0.507982
G1 F1500
M204 S6000
G1 X88.966 Y96.686 E.01668
; LINE_WIDTH: 0.522202
G1 X88.679 Y96.7 E.00711
; LINE_WIDTH: 0.550642
G1 X88.392 Y96.715 E.00752
; LINE_WIDTH: 0.580107
G1 X88.253 Y96.73 E.00387
; LINE_WIDTH: 0.57351
G1 X88.59 Y96.844 E.00971
; LINE_WIDTH: 0.512391
G1 X88.927 Y96.958 E.00863
G1 X89.659 Y97.33 E.01994
G1 X89.659 Y96.745 E.01418
M204 S10000
G1 X90.097 Y96.247 F18000
; LINE_WIDTH: 0.419992
G1 F1500
M204 S6000
G1 X85.002 Y96.251 E.10021
G1 X85.006 Y98.172 E.03778
G1 X85.057 Y98.216 E.00134
G1 X85.6 Y97.751 E.01406
G1 X86.166 Y97.433 E.01277
G1 X86.771 Y97.232 E.01254
G1 X87.412 Y97.149 E.01273
G1 X88.214 Y97.211 E.01582
G1 X88.804 Y97.379 E.01206
G1 X89.381 Y97.672 E.01273
G1 X89.965 Y98.15 E.01486
G1 X90.045 Y98.078 E.00212
G1 X90.097 Y98.083 E.00103
G1 X90.097 Y96.307 E.03493
; CHANGE_LAYER
; Z_HEIGHT: 4.16
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F1500
G1 X90.097 Y98.083 E-.33746
G1 X90.045 Y98.078 E-.00999
G1 X89.965 Y98.15 E-.02044
G1 X89.916 Y98.11 E-.01211
; WIPE_END
G1 E-.02 F1800
; layer num/total_layer_count: 34/49
; update layer progress
M73 L34
M991 S0 P33 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z4.44 I1.04 J.632 P1  F18000
G1 X94.431 Y90.682 Z4.44
G1 Z4.16
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X94.269 Y90.682 E.00342
G1 X94.269 Y90.22 E.00977
G1 X95.431 Y90.22 E.02458
G1 X95.431 Y90.682 E.00977
G1 X94.491 Y90.682 E.0199
; WIPE_START
M204 S6000
G1 X94.269 Y90.682 E-.04209
G1 X94.269 Y90.22 E-.08769
G1 X95.431 Y90.22 E-.22069
G1 X95.431 Y90.376 E-.02952
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X98.669 Y90.22 Z4.56 F18000
G1 Z4.16
G1 E.4 F1800
G1 F1500
M204 S500
G1 X99.831 Y90.22 E.02458
G1 X99.831 Y90.682 E.00977
G1 X98.669 Y90.682 E.02458
G1 X98.669 Y90.28 E.0085
; WIPE_START
M204 S6000
G1 X99.831 Y90.22 E-.22098
G1 X99.831 Y90.682 E-.08769
G1 X99.455 Y90.682 E-.07132
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X98.638 Y94.889 Z4.56 F18000
G1 Z4.16
G1 E.4 F1800
G1 F1500
M204 S500
G1 X99.407 Y94.12 E.02301
G1 X99.407 Y95.357 E.02619
G1 X98.169 Y95.357 E.02619
G1 X98.595 Y94.931 E.01276
M204 S10000
G1 X98.338 Y94.589 F18000
G1 F1500
M204 S500
G1 X99.831 Y93.096 E.04469
G1 X99.831 Y95.782 E.05685
G1 X97.145 Y95.782 E.05685
G1 X98.295 Y94.631 E.03444
; WIPE_START
M204 S6000
G1 X99.71 Y93.217 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X96.569 Y87.944 Z4.56 F18000
G1 Z4.16
G1 E.4 F1800
G1 F1500
M204 S500
G1 X97.531 Y87.944 E.02035
G1 X97.05 Y88.425 E.01439
G1 X96.612 Y87.987 E.01312
; WIPE_START
M204 S6000
G1 X97.531 Y87.944 E-.17484
G1 X97.05 Y88.425 E-.1292
G1 X96.767 Y88.143 E-.07596
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X94.693 Y94.12 Z4.56 F18000
G1 Z4.16
G1 E.4 F1800
G1 F1500
M204 S500
G1 X95.931 Y95.357 E.03704
G1 X94.693 Y95.357 E.02619
G1 X94.693 Y94.18 E.02492
; WIPE_START
M204 S6000
G1 X95.931 Y95.357 E-.32452
G1 X95.639 Y95.357 E-.05549
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X89.358 Y98.156 Z4.56 F18000
G1 Z4.16
G1 E.4 F1800
G1 F1500
M204 S500
G1 X89.177 Y98.027 E.00469
G1 X88.669 Y97.766 E.01209
G1 X88.154 Y97.615 E.01135
G1 X87.78 Y97.564 E.00798
G1 X87.445 Y97.558 E.00711
G1 X86.877 Y97.628 E.0121
G1 X86.347 Y97.8 E.01181
G1 X85.847 Y98.077 E.01209
G1 X85.579 Y98.28 E.00712
G1 X85.306 Y98.54 E.00798
G1 X84.991 Y98.948 E.0109
G1 X84.788 Y99.312 E.00882
G1 X84.598 Y99.262 E.00416
G1 X84.593 Y95.842 E.07239
G1 X90.507 Y95.837 E.12517
G1 X90.507 Y99.272 E.0727
G1 X90.305 Y99.315 E.00436
G1 X90.058 Y98.872 E.01073
G1 X89.731 Y98.474 E.0109
G1 X89.451 Y98.222 E.00797
G1 X89.407 Y98.19 E.00115
M204 S10000
G1 X89.112 Y98.501 F18000
G1 F1500
M204 S500
G1 X89.185 Y98.553 E.00191
G1 X89.424 Y98.768 E.00679
G1 X89.71 Y99.117 E.00955
G1 X89.876 Y99.394 E.00683
G1 X90.007 Y99.689 E.00683
G1 X90.13 Y100.133 E.00975
G1 X90.172 Y100.601 E.00995
G1 X90.13 Y101.06 E.00975
G1 X90.054 Y101.371 E.00679
G1 X89.957 Y101.635 E.00596
G1 X89.718 Y102.075 E.01058
G1 X89.418 Y102.441 E.01002
G1 X89.056 Y102.747 E.01002
G1 X88.62 Y102.992 E.01059
G1 X88.358 Y103.093 E.00595
G1 X88.047 Y103.174 E.00679
G1 X87.589 Y103.222 E.00975
G1 X87.121 Y103.187 E.00995
G1 X86.666 Y103.069 E.00995
G1 X86.248 Y102.875 E.00975
G1 X85.978 Y102.698 E.00683
G1 X85.732 Y102.489 E.00683
G1 X85.429 Y102.142 E.00975
G1 X85.188 Y101.738 E.00995
G1 X85.026 Y101.307 E.00975
G1 X84.959 Y100.991 E.00683
G1 X84.93 Y100.67 E.00683
G1 X84.958 Y100.206 E.00983
G1 X85.082 Y99.722 E.01058
G1 X85.19 Y99.462 E.00595
G1 X85.346 Y99.182 E.00679
G1 X85.622 Y98.825 E.00955
G1 X85.854 Y98.603 E.00679
G1 X86.079 Y98.433 E.00596
G1 X86.516 Y98.191 E.01059
G1 X86.97 Y98.044 E.0101
G1 X87.466 Y97.982 E.01059
G1 X87.748 Y97.988 E.00595
G1 X88.066 Y98.031 E.0068
G1 X88.511 Y98.161 E.00982
G1 X88.956 Y98.39 E.01059
G1 X89.063 Y98.466 E.00278
M204 S250
G1 X88.874 Y98.834 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X88.929 Y98.873 E.00131
G1 X89.127 Y99.052 E.00525
G1 X89.375 Y99.353 E.00767
G1 X89.512 Y99.583 E.00526
G1 X89.621 Y99.827 E.00526
G1 X89.725 Y100.206 E.00774
G1 X89.761 Y100.601 E.0078
M73 P76 R6
G1 X89.726 Y100.992 E.00773
G1 X89.662 Y101.252 E.00525
G1 X89.583 Y101.466 E.0045
G1 X89.377 Y101.845 E.00849
G1 X89.125 Y102.152 E.00782
G1 X88.822 Y102.41 E.00782
G1 X88.446 Y102.621 E.00849
G1 X88.232 Y102.703 E.00449
G1 X87.974 Y102.77 E.00525
G1 X87.583 Y102.811 E.00774
G1 X87.188 Y102.782 E.00779
G1 X86.804 Y102.682 E.0078
G1 X86.447 Y102.517 E.00773
G1 X86.224 Y102.369 E.00526
G1 X86.02 Y102.197 E.00526
G1 X85.761 Y101.9 E.00773
G1 X85.558 Y101.56 E.0078
G1 X85.42 Y101.192 E.00774
G1 X85.364 Y100.93 E.00526
G1 X85.34 Y100.664 E.00526
G1 X85.364 Y100.27 E.00776
G1 X85.471 Y99.852 E.00848
G1 X85.559 Y99.641 E.00449
G1 X85.689 Y99.408 E.00525
G1 X85.927 Y99.1 E.00767
G1 X86.12 Y98.915 E.00525
G1 X86.302 Y98.777 E.00449
G1 X86.68 Y98.568 E.00849
G1 X87.059 Y98.445 E.00784
G1 X87.487 Y98.392 E.00849
G1 X87.716 Y98.397 E.00449
G1 X87.98 Y98.433 E.00525
G1 X88.359 Y98.543 E.00775
G1 X88.743 Y98.741 E.00849
G1 X88.825 Y98.8 E.002
; WIPE_START
M204 S6000
G1 X88.929 Y98.873 E-.0241
G1 X89.127 Y99.052 E-.0507
G1 X89.375 Y99.353 E-.07411
G1 X89.512 Y99.583 E-.05083
G1 X89.621 Y99.827 E-.05083
G1 X89.725 Y100.206 E-.07472
G1 X89.751 Y100.493 E-.05471
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X93.075 Y93.622 Z4.56 F18000
G1 X95.869 Y87.844 Z4.56
G1 Z4.16
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X95.869 Y87.52 E.00686
G1 X96.869 Y87.52 E.02117
G1 X96.869 Y77.382 E.21459
G1 X94.582 Y77.382 E.0484
G1 X94.514 Y77.05 E.00717
G1 X94.373 Y76.788 E.00629
G1 X94.162 Y76.578 E.0063
G1 X93.901 Y76.437 E.00629
G1 X93.637 Y76.382 E.00571
G1 X81.496 Y76.382 E.25697
G1 X81.198 Y76.434 E.00639
G1 X80.897 Y76.608 E.00737
G1 X80.687 Y76.844 E.00669
G1 X80.542 Y77.181 E.00775
G1 X80.531 Y94.437 E.36524
G1 X80.555 Y94.643 E.0044
G1 X80.665 Y94.928 E.00647
G1 X80.958 Y95.245 E.00913
G1 X81.256 Y95.384 E.00694
G1 X81.505 Y95.42 E.00534
G1 X94.269 Y95.41 E.27016
G1 X94.269 Y93.096 E.04898
G1 X96.955 Y95.782 E.08039
G1 X90.931 Y95.782 E.12751
G1 X90.919 Y100.861 E.1075
G1 X90.877 Y101.197 E.00718
G1 X90.782 Y101.588 E.00851
G1 X90.643 Y101.963 E.00848
G1 X90.458 Y102.324 E.00858
G1 X90.108 Y102.81 E.01267
G1 X89.674 Y103.23 E.01279
G1 X89.182 Y103.561 E.01255
G1 X88.64 Y103.801 E.01255
G1 X88.314 Y103.892 E.00716
G1 X87.837 Y103.969 E.01022
G1 X87.25 Y103.967 E.01243
G1 X86.854 Y103.908 E.00848
G1 X86.468 Y103.803 E.00848
G1 X86.097 Y103.652 E.00848
G1 X85.738 Y103.454 E.00867
G1 X85.321 Y103.14 E.01104
G1 X84.987 Y102.804 E.01002
G1 X84.747 Y102.489 E.00839
G1 X84.543 Y102.144 E.00847
G1 X84.38 Y101.773 E.00858
G1 X84.224 Y101.2 E.01257
G1 X84.176 Y100.801 E.00852
G1 X84.168 Y95.783 E.10621
G1 X81.479 Y95.778 E.05691
G1 X81.223 Y95.741 E.00548
G1 X80.931 Y95.634 E.00659
G1 X80.792 Y95.554 E.0034
G1 X80.546 Y95.348 E.00678
G1 X80.36 Y95.098 E.00659
G1 X80.251 Y94.864 E.00547
G1 X80.207 Y94.719 E.00321
G1 X80.169 Y94.383 E.00716
G1 X80.169 Y77.419 E.35906
G1 X80.207 Y77.083 E.00716
G1 X80.251 Y76.938 E.00321
G1 X80.356 Y76.712 E.00528
G1 X80.495 Y76.513 E.00513
G1 X80.647 Y76.359 E.00458
G1 X80.788 Y76.252 E.00374
G1 X81.009 Y76.133 E.00532
G1 X81.176 Y76.074 E.00374
G1 X81.397 Y76.03 E.00477
G1 X93.597 Y76.022 E.25823
G1 X93.946 Y76.079 E.00748
G1 X94.096 Y76.134 E.0034
G1 X94.368 Y76.29 E.00664
G1 X94.537 Y76.439 E.00477
G1 X94.659 Y76.58 E.00393
G1 X94.948 Y77.02 E.01115
G1 X97.231 Y77.02 E.04831
G1 X97.231 Y87.52 E.22224
G1 X98.231 Y87.52 E.02117
G1 X98.231 Y87.844 E.00686
G1 X97.05 Y89.025 E.03534
G1 X95.912 Y87.887 E.03407
; WIPE_START
M204 S6000
G1 X95.869 Y87.52 E-.07014
G1 X96.869 Y87.52 E-.19
G1 X96.869 Y86.889 E-.11986
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X94.84 Y91.091 Z4.56 F18000
G1 Z4.16
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X94.84 Y93.088 E.03928
G1 X97.05 Y95.298 E.06147
G1 X99.26 Y93.088 E.06147
G1 X99.26 Y91.091 E.03928
G1 X98.26 Y91.091 E.01967
G1 X98.26 Y89.811 E.02518
G1 X100.24 Y89.811 E.03895
G1 X100.24 Y96.191 E.12549
G1 X91.34 Y96.191 E.17505
G1 X91.34 Y100.596 E.08665
G1 X91.327 Y100.895 E.00588
G1 X91.28 Y101.271 E.00745
G1 X91.174 Y101.708 E.00885
G1 X91.018 Y102.129 E.00883
G1 X90.812 Y102.529 E.00886
G1 X90.653 Y102.775 E.00576
G1 X90.42 Y103.076 E.00748
G1 X90.219 Y103.289 E.00577
G1 X89.936 Y103.545 E.00751
G1 X89.762 Y103.678 E.0043
G1 X89.38 Y103.92 E.00889
G1 X88.972 Y104.114 E.00889
G1 X88.402 Y104.292 E.01174
G1 X87.882 Y104.376 E.01035
G1 X87.665 Y104.389 E.00427
G1 X87.214 Y104.376 E.00889
G1 X86.769 Y104.309 E.00883
G1 X86.336 Y104.191 E.00883
G1 X85.92 Y104.022 E.00883
G1 X85.524 Y103.804 E.00889
G1 X85.048 Y103.445 E.01174
G1 X84.678 Y103.074 E.01029
G1 X84.407 Y102.718 E.00881
G1 X84.179 Y102.331 E.00883
G1 X83.997 Y101.919 E.00887
G1 X83.907 Y101.64 E.00576
G1 X83.82 Y101.272 E.00745
G1 X83.767 Y100.825 E.00885
G1 X83.76 Y96.191 E.09115
G1 X81.449 Y96.188 E.04545
G1 X81.134 Y96.141 E.00626
G1 X80.938 Y96.083 E.00403
G1 X80.747 Y96 E.00409
G1 X80.567 Y95.896 E.0041
G1 X80.4 Y95.772 E.00409
G1 X80.248 Y95.629 E.00409
G1 X80.115 Y95.47 E.00409
G1 X80.002 Y95.298 E.00404
G1 X79.867 Y95.01 E.00625
G1 X79.809 Y94.814 E.00403
G1 X79.772 Y94.609 E.00409
G1 X79.76 Y94.395 E.00422
G1 X79.76 Y77.407 E.33413
G1 X79.772 Y77.193 E.00422
G1 X79.809 Y76.988 E.00409
G1 X79.867 Y76.792 E.00403
G1 X80.001 Y76.506 E.0062
G1 X80.18 Y76.25 E.00615
G1 X80.376 Y76.051 E.0055
G1 X80.565 Y75.907 E.00468
G1 X80.843 Y75.757 E.00621
G1 X81.068 Y75.678 E.00468
G1 X81.345 Y75.623 E.00556
G1 X81.556 Y75.611 E.00417
G1 X93.618 Y75.613 E.23725
G1 X93.862 Y75.639 E.00482
G1 X94.063 Y75.686 E.00407
G1 X94.259 Y75.758 E.00409
G1 X94.445 Y75.851 E.00409
G1 X94.617 Y75.964 E.00405
G1 X94.829 Y76.15 E.00556
G1 X94.986 Y76.333 E.00474
G1 X95.169 Y76.611 E.00654
G1 X97.64 Y76.611 E.04861
G1 X97.64 Y87.111 E.20653
G1 X98.64 Y87.111 E.01967
G1 X98.64 Y88.014 E.01776
G1 X97.05 Y89.604 E.04423
G1 X95.46 Y88.014 E.04423
G1 X95.46 Y87.111 E.01776
G1 X96.46 Y87.111 E.01967
G1 X96.46 Y77.791 E.18332
G1 X94.16 Y77.791 E.04524
G1 X94.159 Y77.356 E.00856
G1 X94.125 Y77.191 E.0033
G1 X94.041 Y77.035 E.00349
G1 X93.915 Y76.91 E.0035
G1 X93.759 Y76.826 E.00349
G1 X93.595 Y76.792 E.0033
G1 X81.532 Y76.791 E.23727
G1 X81.34 Y76.825 E.00382
G1 X81.159 Y76.929 E.00413
G1 X81.036 Y77.067 E.00362
G1 X80.951 Y77.265 E.00425
G1 X80.94 Y94.413 E.33728
G1 X80.955 Y94.544 E.00259
G1 X81.019 Y94.708 E.00345
G1 X81.204 Y94.908 E.00537
G1 X81.374 Y94.987 E.00369
G1 X81.535 Y95.011 E.00319
G1 X93.86 Y95.001 E.24243
G1 X93.86 Y89.811 E.10209
G1 X95.84 Y89.811 E.03895
G1 X95.84 Y91.091 E.02518
G1 X94.9 Y91.091 E.01849
; WIPE_START
M204 S6000
G1 X94.84 Y93.088 E-.3796
G1 X94.842 Y93.089 E-.0004
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




G1 X94.35 Y92.887
G1 Z4.16
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.596522
G1 F1500
M204 S6000
G1 X94.35 Y90.886 E.05697
; WIPE_START
G1 X94.35 Y92.886 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X95.077 Y94.958 Z4.56 F18000
G1 Z4.16
G1 E.4 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.365752
G1 F1500
M204 S6000
G1 X95.013 Y94.995 E.00125
G1 X95.062 Y95.023 E.00095
; WIPE_START
G1 X95.013 Y94.995 E-.16436
G1 X95.077 Y94.958 E-.21564
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X99.065 Y94.958 Z4.56 F18000
G1 Z4.16
G1 E.4 F1800
G1 F1500
M204 S6000
G1 X99.002 Y94.995 E.00125
G1 X99.05 Y95.023 E.00095
; WIPE_START
G1 X99.002 Y94.995 E-.16436
G1 X99.065 Y94.958 E-.21564
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X99.75 Y92.887 Z4.56 F18000
G1 Z4.16
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.596522
G1 F1500
M204 S6000
G1 X99.75 Y90.886 E.05697
; WIPE_START
G1 X99.75 Y92.886 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X93.176 Y96.764 Z4.56 F18000
G1 X90.116 Y98.569 Z4.56
G1 Z4.16
G1 E.4 F1800
; LINE_WIDTH: 0.0958804
G1 F1500
M204 S6000
G1 X90.252 Y98.715 E.0007
G1 X90.275 Y98.782 E.00025
M204 S10000
G1 X90.447 Y99.501 F18000
; LINE_WIDTH: 0.475869
G1 F1500
M204 S6000
G1 X90.485 Y99.771 E.00611
; LINE_WIDTH: 0.43072
G1 X90.523 Y100.041 E.0055
; LINE_WIDTH: 0.404467
G1 X90.526 Y100.078 E.00071
; LINE_WIDTH: 0.375913
G1 X90.547 Y100.586 E.00889
; LINE_WIDTH: 0.360819
G1 X90.503 Y101.129 E.0091
G1 X90.419 Y101.477 E.00599
G1 X90.307 Y101.781 E.00541
G1 X90.023 Y102.299 E.00988
G1 X89.669 Y102.725 E.00925
G1 X89.259 Y103.066 E.00891
G1 X88.996 Y103.223 E.00513
G1 X88.667 Y103.383 E.0061
G1 X88.102 Y103.546 E.00983
G1 X87.609 Y103.596 E.00829
G1 X87.282 Y103.584 E.00547
G1 X86.933 Y103.533 E.0059
G1 X86.59 Y103.442 E.00594
G1 X86.076 Y103.208 E.00943
G1 X85.807 Y103.041 E.00528
G1 X85.576 Y102.856 E.00495
G1 X85.277 Y102.551 E.00714
G1 X85.133 Y102.375 E.0038
G1 X84.855 Y101.915 E.00899
G1 X84.664 Y101.4 E.00918
G1 X84.599 Y101.131 E.00463
G1 X84.557 Y100.778 E.00595
G1 X84.567 Y100.163 E.01028
; LINE_WIDTH: 0.407217
G1 X84.599 Y99.915 E.00476
; LINE_WIDTH: 0.446492
G1 X84.628 Y99.706 E.00443
; LINE_WIDTH: 0.482468
G1 X84.656 Y99.497 E.00481
M204 S10000
G1 X84.828 Y98.783 F18000
; LINE_WIDTH: 0.0867215
G1 F1500
M204 S6000
G1 X84.843 Y98.737 E.00015
G1 X84.924 Y98.647 E.00037
; WIPE_START
G1 X84.843 Y98.737 E-.27086
G1 X84.828 Y98.783 E-.10914
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X86.712 Y96.741 Z4.56 F18000
G1 Z4.16
G1 E.4 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.595202
G1 F1500
M204 S6000
M73 P77 R6
G1 X87.033 Y96.721 E.00914
; LINE_WIDTH: 0.562627
G1 X87.354 Y96.701 E.00862
G1 X88.193 Y96.728 E.02249
; WIPE_START
G1 X87.354 Y96.701 E-.27474
G1 X87.033 Y96.721 E-.10526
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X86.712 Y96.741 Z4.56 F18000
G1 Z4.16
G1 E.4 F1800
; LINE_WIDTH: 0.596861
G1 F1500
M204 S6000
G1 X86.48 Y96.723 E.00663
; LINE_WIDTH: 0.560357
G1 X86.248 Y96.705 E.00621
; LINE_WIDTH: 0.507683
G1 X86.016 Y96.687 E.00559
G1 X85.44 Y96.688 E.01384
G1 X85.441 Y97.334 E.01554
G1 X85.955 Y97.05 E.01411
; LINE_WIDTH: 0.52629
G1 X86.289 Y96.914 E.009
; LINE_WIDTH: 0.567665
G1 X86.622 Y96.777 E.00975
; LINE_WIDTH: 0.601732
G1 X86.656 Y96.764 E.00104
; WIPE_START
G1 X86.622 Y96.777 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X89.659 Y96.685 Z4.56 F18000
G1 Z4.16
G1 E.4 F1800
; LINE_WIDTH: 0.507942
G1 F1500
M204 S6000
G1 X88.965 Y96.686 E.01669
; LINE_WIDTH: 0.52215
G1 X88.679 Y96.7 E.0071
; LINE_WIDTH: 0.550565
G1 X88.392 Y96.715 E.00751
; LINE_WIDTH: 0.580052
G1 X88.253 Y96.73 E.00387
; LINE_WIDTH: 0.573485
G1 X88.59 Y96.844 E.00971
; LINE_WIDTH: 0.512365
G1 X88.926 Y96.958 E.00863
G1 X89.657 Y97.326 E.01988
G1 X89.659 Y96.745 E.01411
M204 S10000
G1 X90.097 Y96.247 F18000
; LINE_WIDTH: 0.419992
G1 F1500
M204 S6000
G1 X85.002 Y96.251 E.10021
G1 X85.006 Y98.172 E.03779
G1 X85.057 Y98.216 E.00134
G1 X85.602 Y97.749 E.01413
G1 X86.166 Y97.432 E.01272
G1 X86.77 Y97.232 E.01251
G1 X87.409 Y97.15 E.01268
G1 X88.214 Y97.211 E.01588
G1 X88.803 Y97.378 E.01205
G1 X89.378 Y97.67 E.01267
G1 X89.965 Y98.151 E.01493
G1 X90.045 Y98.078 E.00212
G1 X90.097 Y98.083 E.00103
G1 X90.097 Y96.307 E.03494
; CHANGE_LAYER
; Z_HEIGHT: 4.28
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F1500
G1 X90.097 Y98.083 E-.33747
G1 X90.045 Y98.078 E-.00998
G1 X89.965 Y98.151 E-.02044
G1 X89.916 Y98.11 E-.0121
; WIPE_END
G1 E-.02 F1800
; layer num/total_layer_count: 35/49
; update layer progress
M73 L35
M991 S0 P34 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z4.56 I1.04 J.632 P1  F18000
G1 X94.431 Y90.682 Z4.56
G1 Z4.28
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X94.269 Y90.682 E.00342
G1 X94.269 Y90.22 E.00977
G1 X95.431 Y90.22 E.02458
G1 X95.431 Y90.682 E.00977
G1 X94.491 Y90.682 E.0199
; WIPE_START
M204 S6000
G1 X94.269 Y90.682 E-.04209
G1 X94.269 Y90.22 E-.08769
G1 X95.431 Y90.22 E-.22069
G1 X95.431 Y90.376 E-.02952
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X98.669 Y90.22 Z4.68 F18000
G1 Z4.28
G1 E.4 F1800
G1 F1500
M204 S500
G1 X99.831 Y90.22 E.02458
G1 X99.831 Y90.682 E.00977
G1 X98.669 Y90.682 E.02458
G1 X98.669 Y90.28 E.0085
; WIPE_START
M204 S6000
G1 X99.831 Y90.22 E-.22098
G1 X99.831 Y90.682 E-.08769
G1 X99.455 Y90.682 E-.07132
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X98.638 Y94.889 Z4.68 F18000
G1 Z4.28
G1 E.4 F1800
G1 F1500
M204 S500
G1 X99.407 Y94.12 E.02301
G1 X99.407 Y95.357 E.02619
G1 X98.169 Y95.357 E.02619
G1 X98.595 Y94.931 E.01276
M204 S10000
G1 X98.338 Y94.589 F18000
G1 F1500
M204 S500
G1 X99.831 Y93.096 E.04469
G1 X99.831 Y95.782 E.05685
G1 X97.145 Y95.782 E.05685
G1 X98.295 Y94.631 E.03444
; WIPE_START
M204 S6000
G1 X99.71 Y93.217 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X96.569 Y87.944 Z4.68 F18000
G1 Z4.28
G1 E.4 F1800
G1 F1500
M204 S500
G1 X97.531 Y87.944 E.02035
G1 X97.05 Y88.425 E.01439
G1 X96.612 Y87.987 E.01312
; WIPE_START
M204 S6000
G1 X97.531 Y87.944 E-.17484
G1 X97.05 Y88.425 E-.1292
G1 X96.767 Y88.143 E-.07596
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X94.693 Y94.12 Z4.68 F18000
G1 Z4.28
G1 E.4 F1800
G1 F1500
M204 S500
G1 X95.931 Y95.357 E.03704
G1 X94.693 Y95.357 E.02619
G1 X94.693 Y94.18 E.02492
; WIPE_START
M204 S6000
G1 X95.931 Y95.357 E-.32452
G1 X95.639 Y95.357 E-.05549
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X89.35 Y98.15 Z4.68 F18000
G1 Z4.28
G1 E.4 F1800
G1 F1500
M204 S500
G1 X89.175 Y98.025 E.00455
G1 X88.669 Y97.765 E.01204
G1 X88.154 Y97.615 E.01135
G1 X87.78 Y97.564 E.00799
G1 X87.442 Y97.558 E.00717
G1 X86.877 Y97.628 E.01204
G1 X86.352 Y97.798 E.01168
G1 X85.885 Y98.05 E.01123
G1 X85.581 Y98.278 E.00804
G1 X85.306 Y98.54 E.00804
G1 X84.982 Y98.96 E.01123
G1 X84.792 Y99.325 E.00871
G1 X84.598 Y99.278 E.00423
G1 X84.593 Y95.842 E.07273
G1 X90.507 Y95.837 E.12517
G1 X90.507 Y99.272 E.0727
G1 X90.306 Y99.315 E.00435
G1 X90.058 Y98.872 E.01075
G1 X89.731 Y98.474 E.0109
G1 X89.451 Y98.222 E.00798
G1 X89.399 Y98.185 E.00135
M204 S10000
G1 X89.104 Y98.496 F18000
G1 F1500
M204 S500
G1 X89.185 Y98.553 E.00211
G1 X89.424 Y98.768 E.00679
G1 X89.71 Y99.117 E.00956
G1 X89.875 Y99.392 E.0068
G1 X89.992 Y99.651 E.00601
G1 X90.129 Y100.129 E.01053
G1 X90.172 Y100.601 E.01002
G1 X90.13 Y101.069 E.00995
G1 X90.005 Y101.522 E.00995
G1 X89.805 Y101.937 E.00975
G1 X89.623 Y102.204 E.00683
G1 X89.411 Y102.447 E.00683
G1 X89.057 Y102.747 E.00982
G1 X88.623 Y102.991 E.01053
G1 X88.358 Y103.093 E.00601
G1 X88.047 Y103.174 E.0068
G1 X87.586 Y103.223 E.00982
G1 X87.09 Y103.18 E.01053
G1 X86.814 Y103.116 E.00601
G1 X86.511 Y103.007 E.0068
G1 X86.106 Y102.789 E.00975
G1 X85.738 Y102.496 E.00995
G1 X85.435 Y102.149 E.00975
G1 X85.261 Y101.877 E.00683
G1 X85.121 Y101.586 E.00683
G1 X84.986 Y101.146 E.00975
G1 X84.931 Y100.689 E.00975
G1 X84.94 Y100.366 E.00683
G1 X84.988 Y100.047 E.00683
G1 X85.124 Y99.607 E.00975
G1 X85.341 Y99.189 E.00995
G1 X85.622 Y98.825 E.00975
G1 X85.856 Y98.602 E.00683
G1 X86.114 Y98.408 E.00683
G1 X86.52 Y98.19 E.00975
G1 X86.97 Y98.044 E.01002
G1 X87.464 Y97.982 E.01053
G1 X87.747 Y97.988 E.00601
G1 X88.066 Y98.031 E.0068
G1 X88.511 Y98.161 E.00982
G1 X88.954 Y98.389 E.01053
G1 X89.055 Y98.461 E.00263
M204 S250
G1 X88.867 Y98.829 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X88.929 Y98.873 E.0015
G1 X89.127 Y99.052 E.00525
G1 X89.375 Y99.353 E.00767
G1 X89.512 Y99.582 E.00525
G1 X89.607 Y99.793 E.00454
G1 X89.725 Y100.205 E.00844
G1 X89.761 Y100.601 E.00782
G1 X89.725 Y100.996 E.00779
G1 X89.62 Y101.378 E.0078
G1 X89.449 Y101.732 E.00773
G1 X89.299 Y101.953 E.00526
G1 X89.123 Y102.154 E.00526
G1 X88.822 Y102.409 E.00776
G1 X88.448 Y102.62 E.00844
G1 X88.233 Y102.703 E.00454
G1 X87.974 Y102.77 E.00525
G1 X87.582 Y102.812 E.00776
G1 X87.154 Y102.775 E.00844
G1 X86.93 Y102.722 E.00454
G1 X86.678 Y102.632 E.00525
G1 X86.332 Y102.446 E.00773
G1 X86.022 Y102.199 E.00779
G1 X85.763 Y101.903 E.00774
G1 X85.619 Y101.677 E.00526
G1 X85.503 Y101.436 E.00526
G1 X85.387 Y101.061 E.00773
G1 X85.341 Y100.67 E.00773
G1 X85.349 Y100.403 E.00526
G1 X85.388 Y100.138 E.00526
G1 X85.504 Y99.762 E.00774
G1 X85.687 Y99.411 E.00779
G1 X85.927 Y99.1 E.00774
G1 X86.121 Y98.915 E.00526
G1 X86.335 Y98.754 E.00526
G1 X86.681 Y98.568 E.00773
G1 X87.059 Y98.445 E.00781
G1 X87.485 Y98.392 E.00844
G1 X87.716 Y98.397 E.00454
G1 X87.98 Y98.433 E.00525
G1 X88.359 Y98.543 E.00775
G1 X88.74 Y98.739 E.00844
G1 X88.818 Y98.794 E.00187
; WIPE_START
M204 S6000
G1 X88.929 Y98.873 E-.02585
G1 X89.127 Y99.052 E-.05072
G1 X89.375 Y99.353 E-.07411
G1 X89.512 Y99.582 E-.05072
G1 X89.607 Y99.793 E-.04388
G1 X89.725 Y100.205 E-.08153
G1 X89.75 Y100.484 E-.0532
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X93.076 Y93.614 Z4.68 F18000
G1 X95.869 Y87.844 Z4.68
G1 Z4.28
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X95.869 Y87.52 E.00686
G1 X96.869 Y87.52 E.02117
G1 X96.869 Y77.382 E.21459
G1 X94.582 Y77.382 E.0484
G1 X94.514 Y77.05 E.00717
G1 X94.373 Y76.788 E.00629
G1 X94.163 Y76.578 E.00629
G1 X93.901 Y76.437 E.00629
G1 X93.637 Y76.382 E.00571
G1 X81.498 Y76.382 E.25692
G1 X81.219 Y76.429 E.00599
G1 X80.931 Y76.58 E.00688
G1 X80.69 Y76.836 E.00744
G1 X80.542 Y77.181 E.00795
G1 X80.531 Y94.446 E.36543
G1 X80.566 Y94.686 E.00514
G1 X80.678 Y94.946 E.00599
G1 X80.961 Y95.246 E.00873
G1 X81.256 Y95.384 E.00688
G1 X81.505 Y95.42 E.00534
G1 X94.269 Y95.41 E.27016
G1 X94.269 Y93.096 E.04898
G1 X96.955 Y95.782 E.08039
G1 X90.931 Y95.782 E.12751
G1 X90.931 Y100.582 E.10161
G1 X90.906 Y101.001 E.00887
G1 X90.835 Y101.395 E.00847
G1 X90.717 Y101.783 E.00858
G1 X90.619 Y102.013 E.0053
G1 X90.359 Y102.482 E.01135
G1 X89.981 Y102.95 E.01274
G1 X89.729 Y103.183 E.00726
G1 X89.344 Y103.466 E.01012
G1 X89.19 Y103.557 E.00377
G1 X88.82 Y103.733 E.00867
G1 X88.255 Y103.907 E.01251
G1 X87.658 Y103.979 E.01274
G1 X87.315 Y103.971 E.00726
G1 X86.85 Y103.907 E.00993
G1 X86.468 Y103.803 E.0084
G1 X86.097 Y103.652 E.00848
G1 X85.738 Y103.454 E.00867
G1 X85.318 Y103.137 E.01113
G1 X84.988 Y102.804 E.00992
G1 X84.747 Y102.489 E.0084
G1 X84.543 Y102.144 E.00848
G1 X84.383 Y101.781 E.0084
G1 X84.251 Y101.331 E.00992
G1 X84.176 Y100.81 E.01115
G1 X84.168 Y95.783 E.1064
G1 X81.479 Y95.778 E.05691
G1 X81.223 Y95.741 E.00548
G1 X80.931 Y95.634 E.00659
G1 X80.792 Y95.554 E.0034
G1 X80.546 Y95.348 E.00678
G1 X80.449 Y95.232 E.0032
G1 X80.313 Y95.012 E.00547
G1 X80.207 Y94.719 E.00659
G1 X80.169 Y94.383 E.00716
G1 X80.169 Y77.419 E.35906
G1 X80.207 Y77.083 E.00716
G1 X80.251 Y76.938 E.0032
G1 X80.356 Y76.712 E.00528
G1 X80.495 Y76.513 E.00512
G1 X80.649 Y76.358 E.00462
G1 X80.788 Y76.252 E.0037
G1 X81.004 Y76.135 E.0052
G1 X81.241 Y76.057 E.00528
G1 X81.39 Y76.03 E.0032
G1 X93.599 Y76.022 E.25842
G1 X93.946 Y76.079 E.00743
G1 X94.097 Y76.134 E.0034
G1 X94.374 Y76.294 E.00678
G1 X94.49 Y76.391 E.0032
G1 X94.662 Y76.585 E.00547
G1 X94.948 Y77.02 E.01103
G1 X97.231 Y77.02 E.04831
G1 X97.231 Y87.52 E.22224
G1 X98.231 Y87.52 E.02117
G1 X98.231 Y87.844 E.00686
G1 X97.05 Y89.025 E.03534
G1 X95.912 Y87.887 E.03407
; WIPE_START
M204 S6000
G1 X95.869 Y87.52 E-.07014
G1 X96.869 Y87.52 E-.19
G1 X96.869 Y86.889 E-.11986
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X94.84 Y91.091 Z4.68 F18000
G1 Z4.28
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X94.84 Y93.088 E.03928
G1 X97.05 Y95.298 E.06147
G1 X99.26 Y93.088 E.06147
G1 X99.26 Y91.091 E.03928
G1 X98.26 Y91.091 E.01967
G1 X98.26 Y89.811 E.02518
G1 X100.24 Y89.811 E.03895
G1 X100.24 Y96.191 E.12549
G1 X91.34 Y96.191 E.17505
G1 X91.34 Y100.594 E.08661
G1 X91.313 Y101.049 E.00896
G1 X91.234 Y101.491 E.00883
G1 X91.102 Y101.922 E.00887
G1 X90.99 Y102.188 E.00567
G1 X90.812 Y102.53 E.0076
G1 X90.695 Y102.715 E.00431
G1 X90.419 Y103.077 E.00896
G1 X89.99 Y103.499 E.01183
G1 X89.569 Y103.808 E.01026
G1 X89.382 Y103.918 E.00427
G1 X88.974 Y104.113 E.00889
G1 X88.546 Y104.257 E.00889
G1 X88.334 Y104.309 E.0043
G1 X87.883 Y104.376 E.00896
G1 X87.282 Y104.38 E.01183
G1 X86.768 Y104.309 E.0102
G1 X86.336 Y104.191 E.00881
G1 X85.92 Y104.022 E.00883
G1 X85.524 Y103.804 E.00889
G1 X85.044 Y103.442 E.01183
G1 X84.679 Y103.074 E.0102
G1 X84.407 Y102.718 E.00881
G1 X84.179 Y102.331 E.00883
G1 X83.998 Y101.921 E.00881
G1 X83.852 Y101.424 E.0102
G1 X83.767 Y100.828 E.01184
G1 X83.76 Y96.191 E.09121
G1 X81.449 Y96.188 E.04545
G1 X81.134 Y96.141 E.00626
G1 X80.938 Y96.083 E.00403
G1 X80.747 Y96 E.00409
G1 X80.567 Y95.896 E.00409
G1 X80.4 Y95.772 E.0041
G1 X80.248 Y95.629 E.00409
G1 X80.117 Y95.472 E.00403
G1 X79.95 Y95.201 E.00626
G1 X79.868 Y95.013 E.00404
G1 X79.809 Y94.814 E.00409
G1 X79.772 Y94.609 E.00409
G1 X79.76 Y94.395 E.00422
G1 X79.76 Y77.407 E.33413
G1 X79.772 Y77.193 E.00422
G1 X79.809 Y76.988 E.0041
G1 X79.867 Y76.792 E.00403
G1 X80.001 Y76.506 E.0062
G1 X80.18 Y76.25 E.00614
G1 X80.378 Y76.05 E.00554
G1 X80.565 Y75.907 E.00464
G1 X80.841 Y75.758 E.00617
G1 X81.14 Y75.659 E.00619
G1 X81.342 Y75.623 E.00403
G1 X81.556 Y75.611 E.00422
G1 X93.621 Y75.613 E.2373
G1 X93.862 Y75.639 E.00477
G1 X94.063 Y75.686 E.00407
G1 X94.259 Y75.758 E.00409
G1 X94.445 Y75.851 E.00409
G1 X94.619 Y75.965 E.00409
G1 X94.776 Y76.097 E.00403
G1 X94.987 Y76.335 E.00626
G1 X95.169 Y76.611 E.0065
G1 X97.64 Y76.611 E.04861
G1 X97.64 Y87.111 E.20653
G1 X98.64 Y87.111 E.01967
G1 X98.64 Y88.014 E.01776
G1 X97.05 Y89.604 E.04423
G1 X95.46 Y88.014 E.04423
G1 X95.46 Y87.111 E.01776
G1 X96.46 Y87.111 E.01967
G1 X96.46 Y77.791 E.18332
G1 X94.16 Y77.791 E.04524
G1 X94.159 Y77.356 E.00856
G1 X94.125 Y77.191 E.0033
G1 X94.041 Y77.035 E.00349
G1 X93.916 Y76.91 E.00349
G1 X93.759 Y76.826 E.00349
G1 X93.595 Y76.792 E.0033
G1 X81.532 Y76.791 E.23726
G1 X81.352 Y76.821 E.00361
G1 X81.182 Y76.911 E.00376
G1 X81.038 Y77.064 E.00415
G1 X80.951 Y77.265 E.00431
G1 X80.94 Y94.416 E.33734
G1 X80.963 Y94.574 E.00313
G1 X81.025 Y94.718 E.00309
G1 X81.205 Y94.908 E.00515
G1 X81.374 Y94.987 E.00368
M73 P78 R6
G1 X81.535 Y95.011 E.00319
G1 X93.86 Y95.001 E.24243
G1 X93.86 Y89.811 E.10209
G1 X95.84 Y89.811 E.03895
G1 X95.84 Y91.091 E.02518
G1 X94.9 Y91.091 E.01849
; WIPE_START
M204 S6000
G1 X94.84 Y93.088 E-.3796
G1 X94.842 Y93.089 E-.0004
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




G1 X94.35 Y92.887
G1 Z4.28
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.596522
G1 F1500
M204 S6000
G1 X94.35 Y90.886 E.05697
; WIPE_START
G1 X94.35 Y92.886 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X95.077 Y94.958 Z4.68 F18000
G1 Z4.28
G1 E.4 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.365752
G1 F1500
M204 S6000
G1 X95.013 Y94.995 E.00125
G1 X95.062 Y95.023 E.00095
; WIPE_START
G1 X95.013 Y94.995 E-.16436
G1 X95.077 Y94.958 E-.21564
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X99.065 Y94.958 Z4.68 F18000
G1 Z4.28
G1 E.4 F1800
G1 F1500
M204 S6000
G1 X99.002 Y94.995 E.00125
G1 X99.05 Y95.023 E.00095
; WIPE_START
G1 X99.002 Y94.995 E-.16436
G1 X99.065 Y94.958 E-.21564
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X99.75 Y92.887 Z4.68 F18000
G1 Z4.28
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.596522
G1 F1500
M204 S6000
G1 X99.75 Y90.886 E.05697
; WIPE_START
G1 X99.75 Y92.886 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X93.176 Y96.764 Z4.68 F18000
G1 X90.116 Y98.569 Z4.68
G1 Z4.28
G1 E.4 F1800
; LINE_WIDTH: 0.0958906
G1 F1500
M204 S6000
G1 X90.252 Y98.715 E.0007
G1 X90.275 Y98.782 E.00025
M204 S10000
G1 X90.45 Y99.501 F18000
; LINE_WIDTH: 0.476789
G1 F1500
M204 S6000
G1 X90.487 Y99.769 E.00608
; LINE_WIDTH: 0.434382
G1 X90.525 Y100.037 E.00551
; LINE_WIDTH: 0.409798
G1 X90.528 Y100.073 E.0007
; LINE_WIDTH: 0.38406
G1 X90.551 Y100.571 E.00891
; LINE_WIDTH: 0.359612
G1 X90.525 Y100.955 E.00642
G1 X90.462 Y101.305 E.00591
G1 X90.36 Y101.653 E.00605
G1 X90.123 Y102.135 E.00895
G1 X89.915 Y102.442 E.00618
G1 X89.665 Y102.722 E.00625
G1 X89.281 Y103.043 E.00833
G1 X89.003 Y103.219 E.00548
; LINE_WIDTH: 0.361076
G1 X88.677 Y103.379 E.00608
G1 X88.331 Y103.495 E.0061
G1 X87.799 Y103.586 E.00903
G1 X87.605 Y103.6 E.00325
G1 X87.346 Y103.588 E.00434
G1 X86.927 Y103.533 E.00707
G1 X86.59 Y103.441 E.00584
G1 X86.263 Y103.307 E.0059
G1 X85.808 Y103.04 E.00883
G1 X85.469 Y102.757 E.0074
G1 X85.141 Y102.385 E.00829
G1 X84.927 Y102.052 E.00662
G1 X84.775 Y101.735 E.00588
G1 X84.62 Y101.245 E.0086
G1 X84.574 Y100.943 E.00511
G1 X84.553 Y100.693 E.00419
G1 X84.572 Y100.146 E.00916
; LINE_WIDTH: 0.40855
G1 X84.585 Y99.97 E.00337
; LINE_WIDTH: 0.44155
G1 X84.621 Y99.725 E.00514
; LINE_WIDTH: 0.474118
G1 X84.653 Y99.51 E.00487
M204 S10000
G1 X84.828 Y98.783 F18000
; LINE_WIDTH: 0.0867693
G1 F1500
M204 S6000
G1 X84.843 Y98.737 E.00015
G1 X84.924 Y98.647 E.00037
; WIPE_START
G1 X84.843 Y98.737 E-.27095
G1 X84.828 Y98.783 E-.10905
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X86.711 Y96.741 Z4.68 F18000
G1 Z4.28
G1 E.4 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.595307
G1 F1500
M204 S6000
G1 X87.031 Y96.721 E.0091
; LINE_WIDTH: 0.56268
G1 X87.35 Y96.701 E.00858
G1 X88.193 Y96.728 E.02258
; WIPE_START
G1 X87.35 Y96.701 E-.27542
G1 X87.031 Y96.721 E-.10458
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X86.711 Y96.741 Z4.68 F18000
G1 Z4.28
G1 E.4 F1800
; LINE_WIDTH: 0.596902
G1 F1500
M204 S6000
G1 X86.482 Y96.723 E.00656
; LINE_WIDTH: 0.560242
G1 X86.252 Y96.705 E.00614
; LINE_WIDTH: 0.507302
G1 X86.023 Y96.687 E.00553
G1 X85.44 Y96.687 E.014
G1 X85.441 Y97.332 E.01549
G1 X85.968 Y97.044 E.01443
; LINE_WIDTH: 0.526027
G1 X86.295 Y96.911 E.00881
; LINE_WIDTH: 0.567577
G1 X86.622 Y96.777 E.00955
; LINE_WIDTH: 0.601792
G1 X86.656 Y96.764 E.00104
; WIPE_START
G1 X86.622 Y96.777 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X89.659 Y96.685 Z4.68 F18000
G1 Z4.28
G1 E.4 F1800
; LINE_WIDTH: 0.507882
G1 F1500
M204 S6000
G1 X88.965 Y96.686 E.0167
; LINE_WIDTH: 0.522082
G1 X88.679 Y96.7 E.00709
; LINE_WIDTH: 0.550482
G1 X88.392 Y96.715 E.0075
; LINE_WIDTH: 0.579997
G1 X88.253 Y96.73 E.00388
; LINE_WIDTH: 0.573455
G1 X88.589 Y96.844 E.00971
; LINE_WIDTH: 0.51232
G1 X88.926 Y96.958 E.00862
G1 X89.656 Y97.323 E.01981
G1 X89.659 Y96.745 E.01403
M204 S10000
G1 X90.097 Y96.247 F18000
; LINE_WIDTH: 0.419992
G1 F1500
M204 S6000
G1 X85.002 Y96.251 E.10021
G1 X85.006 Y98.172 E.03778
G1 X85.058 Y98.216 E.00135
G1 X85.643 Y97.72 E.01509
G1 X86.175 Y97.429 E.01194
G1 X86.77 Y97.232 E.01232
G1 X87.406 Y97.15 E.01262
G1 X88.214 Y97.211 E.01594
G1 X88.803 Y97.378 E.01204
G1 X89.375 Y97.668 E.01262
G1 X89.965 Y98.15 E.01498
G1 X90.045 Y98.078 E.00212
G1 X90.097 Y98.083 E.00104
G1 X90.097 Y96.307 E.03493
; CHANGE_LAYER
; Z_HEIGHT: 4.4
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F1500
G1 X90.097 Y98.083 E-.33744
G1 X90.045 Y98.078 E-.01
G1 X89.965 Y98.15 E-.02045
G1 X89.916 Y98.11 E-.01211
; WIPE_END
G1 E-.02 F1800
; layer num/total_layer_count: 36/49
; update layer progress
M73 L36
M991 S0 P35 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z4.68 I1.04 J.632 P1  F18000
G1 X94.431 Y90.682 Z4.68
G1 Z4.4
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X94.269 Y90.682 E.00342
G1 X94.269 Y90.22 E.00977
G1 X95.431 Y90.22 E.02458
G1 X95.431 Y90.682 E.00977
G1 X94.491 Y90.682 E.0199
; WIPE_START
M204 S6000
G1 X94.269 Y90.682 E-.04209
G1 X94.269 Y90.22 E-.08769
G1 X95.431 Y90.22 E-.22069
G1 X95.431 Y90.376 E-.02952
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X98.669 Y90.22 Z4.8 F18000
G1 Z4.4
G1 E.4 F1800
G1 F1500
M204 S500
G1 X99.831 Y90.22 E.02458
G1 X99.831 Y90.682 E.00977
G1 X98.669 Y90.682 E.02458
G1 X98.669 Y90.28 E.0085
; WIPE_START
M204 S6000
G1 X99.831 Y90.22 E-.22098
G1 X99.831 Y90.682 E-.08769
G1 X99.455 Y90.682 E-.07132
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X98.638 Y94.889 Z4.8 F18000
G1 Z4.4
G1 E.4 F1800
G1 F1500
M204 S500
G1 X99.407 Y94.12 E.02301
G1 X99.407 Y95.357 E.02619
G1 X98.169 Y95.357 E.02619
G1 X98.595 Y94.931 E.01276
M204 S10000
G1 X98.338 Y94.589 F18000
G1 F1500
M204 S500
G1 X99.831 Y93.096 E.04469
G1 X99.831 Y95.782 E.05685
G1 X97.145 Y95.782 E.05685
G1 X98.295 Y94.631 E.03444
; WIPE_START
M204 S6000
G1 X99.71 Y93.217 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X96.569 Y87.944 Z4.8 F18000
G1 Z4.4
G1 E.4 F1800
G1 F1500
M204 S500
G1 X97.531 Y87.944 E.02035
G1 X97.05 Y88.425 E.01439
G1 X96.612 Y87.987 E.01312
; WIPE_START
M204 S6000
G1 X97.531 Y87.944 E-.17484
G1 X97.05 Y88.425 E-.1292
G1 X96.767 Y88.143 E-.07596
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X94.693 Y94.12 Z4.8 F18000
G1 Z4.4
G1 E.4 F1800
G1 F1500
M204 S500
G1 X95.931 Y95.357 E.03704
G1 X94.693 Y95.357 E.02619
G1 X94.693 Y94.18 E.02492
; WIPE_START
M204 S6000
G1 X95.931 Y95.357 E-.32452
G1 X95.639 Y95.357 E-.05549
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X89.339 Y98.142 Z4.8 F18000
G1 Z4.4
G1 E.4 F1800
G1 F1500
M204 S500
G1 X89.138 Y98.001 E.00519
G1 X88.663 Y97.764 E.01124
G1 X88.154 Y97.615 E.01123
G1 X87.78 Y97.564 E.00799
G1 X87.438 Y97.558 E.00723
G1 X86.877 Y97.628 E.01198
G1 X86.367 Y97.794 E.01135
G1 X86.027 Y97.964 E.00804
G1 X85.71 Y98.173 E.00804
G1 X85.316 Y98.528 E.01123
G1 X84.991 Y98.948 E.01123
G1 X84.788 Y99.312 E.00881
G1 X84.598 Y99.262 E.00416
G1 X84.593 Y95.842 E.07239
G1 X90.507 Y95.837 E.12517
G1 X90.507 Y99.272 E.0727
G1 X90.306 Y99.315 E.00435
G1 X90.058 Y98.872 E.01075
G1 X89.731 Y98.474 E.0109
G1 X89.449 Y98.22 E.00804
G1 X89.388 Y98.177 E.00158
M204 S10000
G1 X89.095 Y98.489 F18000
G1 F1500
M204 S500
G1 X89.184 Y98.552 E.00231
G1 X89.424 Y98.768 E.00683
G1 X89.71 Y99.117 E.00955
G1 X89.875 Y99.393 E.0068
G1 X89.993 Y99.654 E.00606
G1 X90.129 Y100.13 E.01048
G1 X90.172 Y100.601 E.01001
G1 X90.13 Y101.06 E.00975
G1 X90.054 Y101.372 E.0068
G1 X89.955 Y101.64 E.00606
G1 X89.718 Y102.075 E.01048
G1 X89.418 Y102.441 E.01001
G1 X89.057 Y102.747 E.01002
G1 X88.625 Y102.99 E.01048
G1 X88.358 Y103.093 E.00606
G1 X88.048 Y103.174 E.0068
G1 X87.598 Y103.221 E.00956
G1 X87.276 Y103.207 E.00683
G1 X86.958 Y103.154 E.00683
G1 X86.519 Y103.012 E.00975
G1 X86.106 Y102.789 E.00995
G1 X85.746 Y102.502 E.00975
G1 X85.526 Y102.265 E.00683
G1 X85.336 Y102.004 E.00683
G1 X85.124 Y101.595 E.00975
G1 X84.986 Y101.146 E.00995
G1 X84.929 Y100.679 E.00995
G1 X84.958 Y100.207 E.01002
M73 P78 R5
G1 X85.08 Y99.727 E.01048
G1 X85.19 Y99.463 E.00606
G1 X85.346 Y99.182 E.0068
G1 X85.628 Y98.818 E.00975
G1 X85.97 Y98.509 E.00975
G1 X86.24 Y98.332 E.00683
G1 X86.528 Y98.187 E.00683
G1 X86.97 Y98.044 E.00982
G1 X87.461 Y97.982 E.01048
G1 X87.747 Y97.988 E.00607
G1 X88.066 Y98.031 E.0068
G1 X88.508 Y98.16 E.00975
G1 X88.92 Y98.367 E.00975
G1 X89.045 Y98.455 E.00325
M204 S250
G1 X88.859 Y98.824 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X88.928 Y98.873 E.00167
G1 X89.127 Y99.052 E.00526
G1 X89.375 Y99.353 E.00767
G1 X89.512 Y99.582 E.00526
G1 X89.608 Y99.795 E.00459
G1 X89.725 Y100.205 E.00839
G1 X89.761 Y100.601 E.00782
G1 X89.726 Y100.992 E.00773
G1 X89.662 Y101.252 E.00525
G1 X89.581 Y101.471 E.00459
G1 X89.377 Y101.845 E.00839
G1 X89.125 Y102.152 E.00782
G1 X88.822 Y102.41 E.00782
G1 X88.45 Y102.619 E.00839
G1 X88.233 Y102.703 E.00459
G1 X87.974 Y102.77 E.00525
G1 X87.586 Y102.811 E.00768
G1 X87.319 Y102.799 E.00526
G1 X87.055 Y102.755 E.00527
G1 X86.681 Y102.634 E.00773
G1 X86.332 Y102.446 E.0078
G1 X86.025 Y102.201 E.00773
G1 X85.843 Y102.005 E.00526
G1 X85.685 Y101.788 E.00526
G1 X85.504 Y101.439 E.00773
G1 X85.387 Y101.061 E.0078
G1 X85.34 Y100.667 E.0078
G1 X85.364 Y100.27 E.00782
G1 X85.469 Y99.857 E.00839
G1 X85.559 Y99.641 E.00459
G1 X85.689 Y99.408 E.00525
G1 X85.929 Y99.097 E.00773
G1 X86.221 Y98.834 E.00773
G1 X86.445 Y98.687 E.00526
G1 X86.684 Y98.567 E.00526
G1 X87.059 Y98.445 E.00775
G1 X87.482 Y98.392 E.00839
G1 X87.716 Y98.397 E.00459
G1 X87.98 Y98.433 E.00525
G1 X88.358 Y98.543 E.00773
G1 X88.709 Y98.719 E.00774
G1 X88.81 Y98.789 E.00242
; WIPE_START
M204 S6000
G1 X88.928 Y98.873 E-.02749
G1 X89.127 Y99.052 E-.05082
G1 X89.375 Y99.353 E-.07408
G1 X89.512 Y99.582 E-.05078
G1 X89.608 Y99.795 E-.04433
G1 X89.725 Y100.205 E-.08106
G1 X89.749 Y100.475 E-.05144
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X93.078 Y93.606 Z4.8 F18000
G1 X95.869 Y87.844 Z4.8
G1 Z4.4
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X95.869 Y87.52 E.00686
G1 X96.869 Y87.52 E.02117
G1 X96.869 Y77.382 E.21459
G1 X94.582 Y77.382 E.0484
G1 X94.514 Y77.05 E.00717
G1 X94.373 Y76.788 E.0063
G1 X94.162 Y76.578 E.00629
G1 X93.901 Y76.437 E.00629
G1 X93.637 Y76.382 E.00571
G1 X81.496 Y76.382 E.25697
G1 X81.2 Y76.434 E.00635
G1 X80.906 Y76.601 E.00717
G1 X80.688 Y76.842 E.00687
G1 X80.542 Y77.181 E.00781
G1 X80.531 Y94.437 E.36524
G1 X80.555 Y94.644 E.00441
G1 X80.666 Y94.93 E.00649
G1 X80.959 Y95.245 E.0091
G1 X81.256 Y95.384 E.00695
G1 X81.505 Y95.42 E.00533
G1 X94.269 Y95.41 E.27016
G1 X94.269 Y93.096 E.04898
G1 X96.955 Y95.782 E.08039
G1 X90.931 Y95.782 E.12751
G1 X90.931 Y100.582 E.10161
G1 X90.906 Y101.001 E.00887
G1 X90.835 Y101.395 E.00847
G1 X90.717 Y101.783 E.00859
G1 X90.621 Y102.009 E.00521
G1 X90.359 Y102.482 E.01143
G1 X89.981 Y102.95 E.01274
G1 X89.726 Y103.186 E.00736
G1 X89.344 Y103.466 E.01002
G1 X89.19 Y103.557 E.00378
G1 X88.64 Y103.801 E.01273
G1 X88.305 Y103.894 E.00735
G1 X87.847 Y103.967 E.00983
G1 X87.259 Y103.969 E.01244
G1 X86.854 Y103.908 E.00867
G1 X86.468 Y103.803 E.00848
G1 X86.097 Y103.652 E.00847
G1 X85.738 Y103.454 E.00867
G1 X85.315 Y103.134 E.01123
G1 X84.988 Y102.804 E.00983
G1 X84.747 Y102.489 E.00841
G1 X84.543 Y102.144 E.00847
G1 X84.38 Y101.773 E.00859
G1 X84.224 Y101.2 E.01256
G1 X84.176 Y100.801 E.00852
G1 X84.168 Y95.783 E.10621
G1 X81.479 Y95.778 E.05691
G1 X81.223 Y95.741 E.00548
G1 X80.931 Y95.634 E.00659
G1 X80.792 Y95.554 E.00339
G1 X80.546 Y95.348 E.00678
G1 X80.448 Y95.23 E.00325
G1 X80.326 Y95.036 E.00485
G1 X80.208 Y94.719 E.00716
G1 X80.169 Y94.383 E.00717
G1 X80.169 Y77.419 E.35905
G1 X80.206 Y77.092 E.00697
G1 X80.285 Y76.853 E.00532
G1 X80.388 Y76.658 E.00467
G1 X80.49 Y76.519 E.00365
G1 X80.665 Y76.344 E.00525
G1 X80.845 Y76.216 E.00467
G1 X80.999 Y76.137 E.00365
G1 X81.241 Y76.057 E.0054
G1 X81.39 Y76.03 E.00321
G1 X93.601 Y76.023 E.25846
G1 X93.946 Y76.079 E.00739
G1 X94.24 Y76.206 E.00678
M73 P79 R5
G1 X94.374 Y76.294 E.0034
G1 X94.49 Y76.391 E.0032
G1 X94.662 Y76.585 E.00547
G1 X94.948 Y77.02 E.01103
G1 X97.231 Y77.02 E.04831
G1 X97.231 Y87.52 E.22224
G1 X98.231 Y87.52 E.02117
G1 X98.231 Y87.844 E.00686
G1 X97.05 Y89.025 E.03534
G1 X95.912 Y87.887 E.03407
; WIPE_START
M204 S6000
G1 X95.869 Y87.52 E-.07014
G1 X96.869 Y87.52 E-.19
G1 X96.869 Y86.889 E-.11986
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X94.84 Y91.091 Z4.8 F18000
G1 Z4.4
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X94.84 Y93.088 E.03928
G1 X97.05 Y95.298 E.06147
G1 X99.26 Y93.088 E.06147
G1 X99.26 Y91.091 E.03928
G1 X98.26 Y91.091 E.01967
G1 X98.26 Y89.811 E.02518
G1 X100.24 Y89.811 E.03895
G1 X100.24 Y96.191 E.12549
G1 X91.34 Y96.191 E.17505
G1 X91.34 Y100.594 E.08661
G1 X91.313 Y101.049 E.00896
G1 X91.234 Y101.491 E.00883
G1 X91.102 Y101.922 E.00887
G1 X90.992 Y102.183 E.00557
G1 X90.812 Y102.53 E.00769
G1 X90.695 Y102.715 E.0043
G1 X90.419 Y103.077 E.00896
G1 X89.986 Y103.502 E.01192
G1 X89.57 Y103.808 E.01017
G1 X89.382 Y103.918 E.00428
G1 X88.972 Y104.114 E.00895
G1 X88.393 Y104.294 E.01192
G1 X87.885 Y104.376 E.01011
G1 X87.435 Y104.389 E.00887
G1 X87.217 Y104.376 E.00429
G1 X86.769 Y104.309 E.00889
G1 X86.336 Y104.191 E.00883
G1 X85.92 Y104.022 E.00883
G1 X85.524 Y103.804 E.00889
G1 X85.041 Y103.439 E.01192
G1 X84.679 Y103.074 E.01011
G1 X84.407 Y102.718 E.00881
G1 X84.179 Y102.331 E.00883
G1 X83.997 Y101.919 E.00887
G1 X83.91 Y101.649 E.00557
G1 X83.82 Y101.272 E.00763
G1 X83.767 Y100.825 E.00885
G1 X83.76 Y96.191 E.09115
G1 X81.449 Y96.188 E.04545
G1 X81.134 Y96.141 E.00626
G1 X80.938 Y96.083 E.00403
G1 X80.747 Y96 E.00409
G1 X80.567 Y95.896 E.00409
G1 X80.4 Y95.772 E.0041
G1 X80.248 Y95.629 E.00409
G1 X80.116 Y95.471 E.00405
G1 X79.964 Y95.228 E.00564
G1 X79.868 Y95.012 E.00465
G1 X79.809 Y94.814 E.00407
G1 X79.772 Y94.609 E.0041
G1 X79.76 Y94.395 E.00422
G1 X79.76 Y77.407 E.33413
G1 X79.772 Y77.193 E.00422
G1 X79.808 Y76.991 E.00403
G1 X79.907 Y76.691 E.00621
G1 X80.041 Y76.441 E.00558
G1 X80.178 Y76.252 E.00459
G1 X80.4 Y76.03 E.00619
G1 X80.632 Y75.866 E.00559
G1 X80.839 Y75.759 E.00459
G1 X81.14 Y75.659 E.00623
G1 X81.342 Y75.623 E.00403
G1 X81.556 Y75.611 E.00421
G1 X93.623 Y75.613 E.23734
G1 X93.862 Y75.639 E.00473
G1 X94.063 Y75.686 E.00407
G1 X94.259 Y75.758 E.00409
G1 X94.445 Y75.851 E.00409
G1 X94.619 Y75.965 E.0041
G1 X94.776 Y76.097 E.00403
G1 X94.987 Y76.335 E.00626
G1 X95.169 Y76.611 E.0065
G1 X97.64 Y76.611 E.04861
G1 X97.64 Y87.111 E.20653
G1 X98.64 Y87.111 E.01967
G1 X98.64 Y88.014 E.01776
G1 X97.05 Y89.604 E.04423
G1 X95.46 Y88.014 E.04423
G1 X95.46 Y87.111 E.01776
G1 X96.46 Y87.111 E.01967
G1 X96.46 Y77.791 E.18332
G1 X94.16 Y77.791 E.04524
G1 X94.159 Y77.356 E.00855
G1 X94.125 Y77.191 E.0033
G1 X94.041 Y77.035 E.00349
G1 X93.915 Y76.91 E.00349
G1 X93.759 Y76.826 E.00349
G1 X93.595 Y76.792 E.0033
G1 X81.532 Y76.791 E.23727
G1 X81.341 Y76.824 E.00381
G1 X81.165 Y76.925 E.00398
G1 X81.037 Y77.066 E.00375
G1 X80.951 Y77.265 E.00427
G1 X80.94 Y94.413 E.33728
G1 X80.955 Y94.544 E.0026
G1 X81.019 Y94.709 E.00347
G1 X81.204 Y94.908 E.00535
G1 X81.375 Y94.987 E.0037
G1 X81.535 Y95.011 E.00319
G1 X93.86 Y95.001 E.24243
G1 X93.86 Y89.811 E.10209
G1 X95.84 Y89.811 E.03895
G1 X95.84 Y91.091 E.02518
G1 X94.9 Y91.091 E.01849
; WIPE_START
M204 S6000
G1 X94.84 Y93.088 E-.3796
G1 X94.842 Y93.089 E-.0004
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




G1 X94.35 Y92.887
G1 Z4.4
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.596522
G1 F1500
M204 S6000
G1 X94.35 Y90.886 E.05697
; WIPE_START
G1 X94.35 Y92.886 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X95.077 Y94.958 Z4.8 F18000
G1 Z4.4
G1 E.4 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.365752
G1 F1500
M204 S6000
G1 X95.013 Y94.995 E.00125
G1 X95.062 Y95.023 E.00095
; WIPE_START
G1 X95.013 Y94.995 E-.16436
G1 X95.077 Y94.958 E-.21564
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X99.065 Y94.958 Z4.8 F18000
G1 Z4.4
G1 E.4 F1800
G1 F1500
M204 S6000
G1 X99.002 Y94.995 E.00125
G1 X99.05 Y95.023 E.00095
; WIPE_START
G1 X99.002 Y94.995 E-.16436
G1 X99.065 Y94.958 E-.21564
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X99.75 Y92.887 Z4.8 F18000
G1 Z4.4
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.596522
G1 F1500
M204 S6000
G1 X99.75 Y90.886 E.05697
; WIPE_START
G1 X99.75 Y92.886 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X93.176 Y96.764 Z4.8 F18000
G1 X90.116 Y98.569 Z4.8
G1 Z4.4
G1 E.4 F1800
; LINE_WIDTH: 0.0958889
G1 F1500
M204 S6000
G1 X90.252 Y98.715 E.0007
G1 X90.275 Y98.782 E.00025
M204 S10000
G1 X90.45 Y99.501 F18000
; LINE_WIDTH: 0.476702
G1 F1500
M204 S6000
G1 X90.487 Y99.769 E.00609
; LINE_WIDTH: 0.434321
G1 X90.525 Y100.037 E.00551
; LINE_WIDTH: 0.409758
G1 X90.528 Y100.073 E.0007
; LINE_WIDTH: 0.38405
G1 X90.551 Y100.571 E.0089
; LINE_WIDTH: 0.360237
G1 X90.5 Y101.133 E.00942
G1 X90.359 Y101.649 E.00892
G1 X90.048 Y102.263 E.01149
G1 X89.698 Y102.696 E.00929
G1 X89.258 Y103.064 E.00956
G1 X88.665 Y103.384 E.01124
G1 X88.127 Y103.542 E.00937
G1 X87.81 Y103.585 E.00533
G1 X87.452 Y103.597 E.00599
G1 X86.88 Y103.524 E.00961
G1 X86.591 Y103.438 E.00504
G1 X86.261 Y103.307 E.00592
G1 X85.91 Y103.112 E.0067
G1 X85.569 Y102.849 E.00719
G1 X85.24 Y102.513 E.00784
G1 X85.022 Y102.213 E.0062
G1 X84.885 Y101.969 E.00467
G1 X84.739 Y101.64 E.006
G1 X84.622 Y101.238 E.00699
G1 X84.553 Y100.705 E.00897
G1 X84.567 Y100.163 E.00905
; LINE_WIDTH: 0.405503
G1 X84.596 Y99.918 E.00469
; LINE_WIDTH: 0.441925
G1 X84.623 Y99.706 E.00442
; LINE_WIDTH: 0.475627
G1 X84.649 Y99.495 E.00478
M204 S10000
G1 X84.828 Y98.783 F18000
; LINE_WIDTH: 0.0935115
G1 F1500
M204 S6000
G1 X84.85 Y98.717 E.00023
G1 X84.973 Y98.585 E.00061
; WIPE_START
G1 X84.85 Y98.717 E-.27441
G1 X84.828 Y98.783 E-.10559
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X86.711 Y96.741 Z4.8 F18000
G1 Z4.4
G1 E.4 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.595437
G1 F1500
M204 S6000
G1 X87.029 Y96.721 E.00905
; LINE_WIDTH: 0.562782
G1 X87.347 Y96.701 E.00853
G1 X88.193 Y96.728 E.02268
; WIPE_START
G1 X87.347 Y96.701 E-.2761
G1 X87.029 Y96.721 E-.1039
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X86.711 Y96.741 Z4.8 F18000
G1 Z4.4
G1 E.4 F1800
; LINE_WIDTH: 0.597667
G1 F1500
M204 S6000
G1 X86.488 Y96.724 E.00638
; LINE_WIDTH: 0.562297
G1 X86.265 Y96.706 E.00599
; LINE_WIDTH: 0.511136
G1 X86.042 Y96.689 E.00542
G1 X85.442 Y96.689 E.01452
G1 X85.443 Y97.349 E.01598
G1 X85.968 Y97.046 E.01468
; LINE_WIDTH: 0.529285
G1 X86.295 Y96.912 E.00887
; LINE_WIDTH: 0.56937
G1 X86.622 Y96.777 E.00958
; LINE_WIDTH: 0.602382
G1 X86.655 Y96.764 E.00104
; WIPE_START
G1 X86.622 Y96.777 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X89.66 Y96.685 Z4.8 F18000
G1 Z4.4
M73 P80 R5
G1 E.4 F1800
; LINE_WIDTH: 0.506992
G1 F1500
M204 S6000
G1 X88.958 Y96.685 E.01685
; LINE_WIDTH: 0.521312
G1 X88.675 Y96.7 E.007
; LINE_WIDTH: 0.549952
G1 X88.392 Y96.715 E.0074
; LINE_WIDTH: 0.579772
G1 X88.253 Y96.73 E.00389
; LINE_WIDTH: 0.573202
G1 X88.586 Y96.843 E.00961
; LINE_WIDTH: 0.511379
G1 X88.919 Y96.956 E.00853
G1 X89.531 Y97.251 E.01645
G1 X89.66 Y97.333 E.00369
G1 X89.66 Y96.745 E.01424
M204 S10000
G1 X90.097 Y96.247 F18000
; LINE_WIDTH: 0.419992
G1 F1500
M204 S6000
G1 X85.002 Y96.251 E.10021
G1 X85.005 Y98.101 E.03638
G1 X85.115 Y98.158 E.00244
G1 X85.481 Y97.834 E.00962
G1 X86.188 Y97.426 E.01604
G1 X86.77 Y97.233 E.01206
G1 X87.403 Y97.15 E.01256
G1 X88.214 Y97.211 E.016
G1 X88.797 Y97.376 E.01191
G1 X89.335 Y97.642 E.01182
G1 X89.718 Y97.912 E.00921
G1 X89.965 Y98.15 E.00675
G1 X90.045 Y98.078 E.00212
G1 X90.097 Y98.083 E.00103
G1 X90.097 Y96.307 E.03493
; CHANGE_LAYER
; Z_HEIGHT: 4.52
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F1500
G1 X90.097 Y98.083 E-.33746
G1 X90.045 Y98.078 E-.00999
G1 X89.965 Y98.15 E-.02045
G1 X89.919 Y98.106 E-.0121
; WIPE_END
G1 E-.02 F1800
; layer num/total_layer_count: 37/49
; update layer progress
M73 L37
M991 S0 P36 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z4.8 I1.04 J.632 P1  F18000
G1 X94.431 Y90.682 Z4.8
G1 Z4.52
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X94.269 Y90.682 E.00342
G1 X94.269 Y90.22 E.00977
G1 X95.431 Y90.22 E.02458
G1 X95.431 Y90.682 E.00977
G1 X94.491 Y90.682 E.0199
; WIPE_START
M204 S6000
G1 X94.269 Y90.682 E-.04209
G1 X94.269 Y90.22 E-.08769
G1 X95.431 Y90.22 E-.22069
G1 X95.431 Y90.376 E-.02952
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X98.669 Y90.22 Z4.92 F18000
G1 Z4.52
G1 E.4 F1800
G1 F1500
M204 S500
G1 X99.831 Y90.22 E.02458
G1 X99.831 Y90.682 E.00977
G1 X98.669 Y90.682 E.02458
G1 X98.669 Y90.28 E.0085
; WIPE_START
M204 S6000
G1 X99.831 Y90.22 E-.22098
G1 X99.831 Y90.682 E-.08769
G1 X99.455 Y90.682 E-.07132
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X98.638 Y94.889 Z4.92 F18000
G1 Z4.52
G1 E.4 F1800
G1 F1500
M204 S500
G1 X99.407 Y94.12 E.02301
G1 X99.407 Y95.357 E.02619
G1 X98.169 Y95.357 E.02619
G1 X98.595 Y94.931 E.01276
M204 S10000
G1 X98.338 Y94.589 F18000
G1 F1500
M204 S500
G1 X99.831 Y93.096 E.04469
G1 X99.831 Y95.782 E.05685
G1 X97.145 Y95.782 E.05685
G1 X98.295 Y94.631 E.03444
; WIPE_START
M204 S6000
G1 X99.71 Y93.217 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X96.569 Y87.944 Z4.92 F18000
G1 Z4.52
G1 E.4 F1800
G1 F1500
M204 S500
G1 X97.531 Y87.944 E.02035
G1 X97.05 Y88.425 E.01439
G1 X96.612 Y87.987 E.01312
; WIPE_START
M204 S6000
G1 X97.531 Y87.944 E-.17484
G1 X97.05 Y88.425 E-.1292
G1 X96.767 Y88.143 E-.07596
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X94.693 Y94.12 Z4.92 F18000
G1 Z4.52
G1 E.4 F1800
G1 F1500
M204 S500
G1 X95.931 Y95.357 E.03704
G1 X94.693 Y95.357 E.02619
G1 X94.693 Y94.18 E.02492
; WIPE_START
M204 S6000
G1 X95.931 Y95.357 E-.32452
G1 X95.639 Y95.357 E-.05549
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X89.331 Y98.137 Z4.92 F18000
G1 Z4.52
G1 E.4 F1800
G1 F1500
M204 S500
G1 X89.138 Y98.001 E.005
G1 X88.663 Y97.764 E.01123
G1 X88.154 Y97.615 E.01123
G1 X87.78 Y97.564 E.00799
G1 X87.436 Y97.558 E.00729
G1 X86.877 Y97.628 E.01193
G1 X86.367 Y97.794 E.01133
G1 X86.027 Y97.964 E.00805
G1 X85.71 Y98.173 E.00804
G1 X85.316 Y98.528 E.01123
G1 X84.991 Y98.948 E.01123
G1 X84.788 Y99.312 E.00882
G1 X84.598 Y99.262 E.00416
G1 X84.593 Y95.842 E.07239
G1 X90.507 Y95.837 E.12519
G1 X90.502 Y99.262 E.07249
G1 X90.301 Y99.305 E.00436
G1 X90.058 Y98.872 E.0105
G1 X89.731 Y98.474 E.0109
G1 X89.449 Y98.22 E.00804
G1 X89.38 Y98.172 E.00177
M204 S10000
G1 X89.087 Y98.484 F18000
G1 F1500
M204 S500
G1 X89.184 Y98.552 E.0025
G1 X89.424 Y98.768 E.00683
G1 X89.71 Y99.117 E.00955
G1 X89.876 Y99.394 E.00683
G1 X90.007 Y99.689 E.00683
G1 X90.13 Y100.133 E.00975
G1 X90.171 Y100.592 E.00975
G1 X90.152 Y100.912 E.0068
G1 X90.101 Y101.197 E.00612
G1 X89.947 Y101.665 E.01043
G1 X89.716 Y102.078 E.01001
G1 X89.418 Y102.441 E.00995
G1 X89.057 Y102.747 E.01001
G1 X88.628 Y102.989 E.01042
G1 X88.358 Y103.093 E.00612
G1 X88.047 Y103.174 E.0068
G1 X87.589 Y103.222 E.00975
G1 X87.12 Y103.187 E.00995
G1 X86.666 Y103.069 E.00995
G1 X86.248 Y102.875 E.00975
G1 X85.978 Y102.698 E.00683
G1 X85.732 Y102.489 E.00683
G1 X85.429 Y102.142 E.00975
G1 X85.188 Y101.739 E.00995
G1 X85.026 Y101.307 E.00975
G1 X84.959 Y100.991 E.00683
G1 X84.93 Y100.67 E.00683
G1 X84.958 Y100.207 E.00982
G1 X85.079 Y99.73 E.01042
G1 X85.19 Y99.463 E.00612
G1 X85.346 Y99.182 E.0068
G1 X85.628 Y98.818 E.00975
G1 X85.97 Y98.509 E.00975
G1 X86.24 Y98.332 E.00683
G1 X86.529 Y98.187 E.00683
G1 X86.969 Y98.044 E.00981
G1 X87.458 Y97.982 E.01043
G1 X87.747 Y97.988 E.00612
G1 X88.066 Y98.031 E.0068
G1 X88.508 Y98.16 E.00975
G1 X88.92 Y98.366 E.00975
G1 X89.038 Y98.45 E.00306
M204 S250
G1 X88.852 Y98.819 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X88.928 Y98.873 E.00184
G1 X89.127 Y99.052 E.00526
G1 X89.375 Y99.353 E.00767
G1 X89.512 Y99.583 E.00526
G1 X89.621 Y99.827 E.00526
G1 X89.725 Y100.206 E.00774
G1 X89.761 Y100.598 E.00773
G1 X89.745 Y100.864 E.00525
G1 X89.704 Y101.097 E.00464
G1 X89.57 Y101.499 E.00834
G1 X89.377 Y101.846 E.00781
G1 X89.125 Y102.152 E.0078
G1 X88.822 Y102.409 E.00782
G1 X88.453 Y102.618 E.00834
G1 X88.232 Y102.703 E.00464
G1 X87.974 Y102.77 E.00525
G1 X87.583 Y102.811 E.00774
G1 X87.188 Y102.782 E.0078
G1 X86.804 Y102.682 E.00779
G1 X86.447 Y102.517 E.00773
G1 X86.224 Y102.369 E.00526
G1 X86.02 Y102.197 E.00526
G1 X85.761 Y101.9 E.00773
G1 X85.558 Y101.56 E.00779
G1 X85.42 Y101.192 E.00774
G1 X85.364 Y100.93 E.00526
G1 X85.34 Y100.664 E.00526
G1 X85.364 Y100.27 E.00776
G1 X85.468 Y99.859 E.00834
G1 X85.559 Y99.641 E.00464
G1 X85.689 Y99.408 E.00525
G1 X85.929 Y99.097 E.00774
G1 X86.221 Y98.834 E.00773
G1 X86.445 Y98.687 E.00526
G1 X86.684 Y98.567 E.00526
G1 X87.059 Y98.445 E.00775
G1 X87.48 Y98.392 E.00834
G1 X87.716 Y98.397 E.00464
G1 X87.98 Y98.433 E.00525
G1 X88.358 Y98.543 E.00773
G1 X88.709 Y98.719 E.00773
G1 X88.802 Y98.784 E.00224
; WIPE_START
M204 S6000
G1 X88.928 Y98.873 E-.0292
G1 X89.127 Y99.052 E-.05085
G1 X89.375 Y99.353 E-.07408
G1 X89.512 Y99.583 E-.05085
G1 X89.621 Y99.827 E-.05082
G1 X89.725 Y100.206 E-.07473
G1 X89.749 Y100.466 E-.04948
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X93.079 Y93.598 Z4.92 F18000
G1 X95.869 Y87.844 Z4.92
G1 Z4.52
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X95.869 Y87.52 E.00686
G1 X96.869 Y87.52 E.02117
G1 X96.869 Y77.382 E.21459
G1 X94.582 Y77.382 E.0484
G1 X94.514 Y77.05 E.00717
G1 X94.373 Y76.788 E.00629
G1 X94.163 Y76.578 E.00629
G1 X93.901 Y76.437 E.0063
G1 X93.636 Y76.382 E.00571
G1 X81.505 Y76.382 E.25677
G1 X81.247 Y76.419 E.00553
G1 X80.936 Y76.576 E.00736
G1 X80.691 Y76.835 E.00756
G1 X80.542 Y77.181 E.00796
G1 X80.531 Y94.446 E.36543
G1 X80.566 Y94.686 E.00514
G1 X80.678 Y94.946 E.006
G1 X80.961 Y95.246 E.00872
G1 X81.256 Y95.384 E.00688
G1 X81.505 Y95.42 E.00534
G1 X94.269 Y95.41 E.27016
G1 X94.269 Y93.096 E.04898
G1 X96.955 Y95.782 E.08039
G1 X90.932 Y95.782 E.12749
G1 X90.924 Y100.801 E.10623
G1 X90.876 Y101.199 E.00848
G1 X90.782 Y101.588 E.00848
G1 X90.643 Y101.963 E.00847
G1 X90.359 Y102.482 E.01251
G1 X90.105 Y102.815 E.00887
G1 X89.722 Y103.189 E.01132
G1 X89.344 Y103.466 E.00992
G1 X89.19 Y103.557 E.00379
G1 X88.64 Y103.801 E.01273
G1 X88.301 Y103.895 E.00745
G1 X87.838 Y103.969 E.00992
G1 X87.25 Y103.967 E.01244
G1 X86.854 Y103.908 E.00848
G1 X86.468 Y103.803 E.00848
G1 X86.097 Y103.652 E.00847
G1 X85.738 Y103.454 E.00867
G1 X85.312 Y103.131 E.01132
G1 X84.988 Y102.805 E.00973
G1 X84.747 Y102.489 E.00841
G1 X84.543 Y102.144 E.00848
G1 X84.38 Y101.773 E.00859
G1 X84.224 Y101.2 E.01256
G1 X84.176 Y100.801 E.00852
G1 X84.168 Y95.783 E.10621
G1 X81.478 Y95.778 E.05695
G1 X81.248 Y95.746 E.00491
G1 X80.931 Y95.634 E.00711
G1 X80.792 Y95.554 E.00339
G1 X80.546 Y95.348 E.00679
G1 X80.36 Y95.098 E.00659
G1 X80.251 Y94.864 E.00547
G1 X80.207 Y94.719 E.0032
G1 X80.169 Y94.383 E.00716
G1 X80.169 Y77.419 E.35906
G1 X80.206 Y77.092 E.00697
G1 X80.285 Y76.853 E.00531
G1 X80.389 Y76.657 E.00471
G1 X80.49 Y76.519 E.00361
G1 X80.67 Y76.339 E.0054
G1 X80.785 Y76.254 E.00302
G1 X81.012 Y76.131 E.00547
G1 X81.146 Y76.082 E.00301
G1 X81.399 Y76.03 E.00547
G1 X93.603 Y76.023 E.25832
G1 X93.946 Y76.079 E.00734
G1 X94.096 Y76.134 E.0034
G1 X94.366 Y76.289 E.00659
G1 X94.56 Y76.461 E.00548
G1 X94.657 Y76.577 E.0032
G1 X94.948 Y77.02 E.01123
G1 X97.231 Y77.02 E.04831
G1 X97.231 Y87.52 E.22224
G1 X98.231 Y87.52 E.02117
G1 X98.231 Y87.844 E.00686
G1 X97.05 Y89.025 E.03534
G1 X95.912 Y87.887 E.03407
; WIPE_START
M204 S6000
G1 X95.869 Y87.52 E-.07014
G1 X96.869 Y87.52 E-.19
G1 X96.869 Y86.889 E-.11986
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X94.84 Y91.091 Z4.92 F18000
G1 Z4.52
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X94.84 Y93.088 E.03928
G1 X97.05 Y95.298 E.06147
G1 X99.26 Y93.088 E.06147
G1 X99.26 Y91.091 E.03928
G1 X98.26 Y91.091 E.01967
G1 X98.26 Y89.811 E.02518
G1 X100.24 Y89.811 E.03895
G1 X100.24 Y96.191 E.12549
G1 X91.34 Y96.191 E.17505
G1 X91.333 Y100.825 E.09115
G1 X91.28 Y101.271 E.00883
G1 X91.174 Y101.708 E.00884
G1 X91.018 Y102.129 E.00883
G1 X90.812 Y102.531 E.00889
G1 X90.695 Y102.715 E.00429
G1 X90.419 Y103.077 E.00896
G1 X89.983 Y103.505 E.01201
G1 X89.57 Y103.808 E.01007
G1 X89.382 Y103.918 E.00428
G1 X88.971 Y104.114 E.00895
G1 X88.388 Y104.295 E.01201
G1 X87.882 Y104.376 E.01008
G1 X87.665 Y104.389 E.00427
G1 X87.214 Y104.376 E.00889
G1 X86.769 Y104.309 E.00883
G1 X86.336 Y104.191 E.00883
G1 X85.92 Y104.022 E.00883
G1 X85.524 Y103.804 E.00889
G1 X85.037 Y103.436 E.01201
G1 X84.679 Y103.074 E.01001
G1 X84.407 Y102.718 E.00881
G1 X84.179 Y102.331 E.00883
G1 X83.997 Y101.919 E.00887
G1 X83.911 Y101.654 E.00548
G1 X83.82 Y101.272 E.00772
G1 X83.767 Y100.825 E.00884
G1 X83.76 Y96.191 E.09115
G1 X81.449 Y96.188 E.04546
G1 X81.162 Y96.147 E.00569
G1 X80.937 Y96.082 E.00461
G1 X80.747 Y96 E.00407
G1 X80.567 Y95.896 E.00409
G1 X80.4 Y95.772 E.0041
G1 X80.248 Y95.629 E.00409
G1 X80.114 Y95.47 E.00409
G1 X80.002 Y95.298 E.00403
G1 X79.867 Y95.01 E.00625
G1 X79.809 Y94.814 E.00403
G1 X79.772 Y94.609 E.00409
G1 X79.76 Y94.395 E.00422
G1 X79.76 Y77.407 E.33413
G1 X79.772 Y77.193 E.00421
G1 X79.808 Y76.991 E.00403
G1 X79.907 Y76.692 E.00621
G1 X80.042 Y76.439 E.00563
G1 X80.178 Y76.252 E.00455
G1 X80.402 Y76.028 E.00623
G1 X80.564 Y75.907 E.00398
G1 X80.844 Y75.757 E.00625
G1 X81.034 Y75.687 E.00397
G1 X81.345 Y75.623 E.00626
G1 X81.556 Y75.611 E.00416
G1 X93.625 Y75.613 E.23739
G1 X93.862 Y75.639 E.00468
G1 X94.063 Y75.686 E.00407
G1 X94.259 Y75.758 E.00409
G1 X94.445 Y75.851 E.0041
G1 X94.616 Y75.964 E.00403
G1 X94.854 Y76.175 E.00626
G1 X94.986 Y76.332 E.00403
G1 X95.169 Y76.611 E.00656
G1 X97.64 Y76.611 E.04861
G1 X97.64 Y87.111 E.20653
G1 X98.64 Y87.111 E.01967
G1 X98.64 Y88.014 E.01776
G1 X97.05 Y89.604 E.04423
G1 X95.46 Y88.014 E.04423
G1 X95.46 Y87.111 E.01776
G1 X96.46 Y87.111 E.01967
G1 X96.46 Y77.791 E.18332
G1 X94.16 Y77.791 E.04524
G1 X94.159 Y77.356 E.00855
G1 X94.125 Y77.191 E.0033
G1 X94.041 Y77.035 E.00349
G1 X93.916 Y76.91 E.00349
G1 X93.759 Y76.826 E.00349
G1 X93.595 Y76.792 E.00331
G1 X81.535 Y76.791 E.23721
G1 X81.371 Y76.815 E.00325
G1 X81.184 Y76.909 E.00412
G1 X81.038 Y77.064 E.00419
G1 X80.951 Y77.265 E.00431
G1 X80.94 Y94.416 E.33734
G1 X80.963 Y94.573 E.00313
G1 X81.025 Y94.718 E.0031
G1 X81.205 Y94.908 E.00515
G1 X81.374 Y94.987 E.00368
G1 X81.535 Y95.011 E.00319
G1 X93.86 Y95.001 E.24243
G1 X93.86 Y89.811 E.10209
G1 X95.84 Y89.811 E.03895
G1 X95.84 Y91.091 E.02518
G1 X94.9 Y91.091 E.01849
; WIPE_START
M204 S6000
G1 X94.84 Y93.088 E-.3796
G1 X94.842 Y93.089 E-.0004
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




G1 X94.35 Y92.887
G1 Z4.52
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.596522
G1 F1500
M204 S6000
G1 X94.35 Y90.886 E.05697
; WIPE_START
G1 X94.35 Y92.886 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X95.077 Y94.958 Z4.92 F18000
G1 Z4.52
G1 E.4 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.365752
G1 F1500
M204 S6000
G1 X95.013 Y94.995 E.00125
G1 X95.062 Y95.023 E.00095
; WIPE_START
G1 X95.013 Y94.995 E-.16436
G1 X95.077 Y94.958 E-.21564
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X99.065 Y94.958 Z4.92 F18000
G1 Z4.52
G1 E.4 F1800
G1 F1500
M204 S6000
G1 X99.002 Y94.995 E.00125
G1 X99.05 Y95.023 E.00095
; WIPE_START
G1 X99.002 Y94.995 E-.16436
G1 X99.065 Y94.958 E-.21564
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X99.75 Y92.887 Z4.92 F18000
G1 Z4.52
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.596522
G1 F1500
M204 S6000
G1 X99.75 Y90.886 E.05697
; WIPE_START
G1 X99.75 Y92.886 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X93.176 Y96.764 Z4.92 F18000
G1 X90.116 Y98.569 Z4.92
G1 Z4.52
G1 E.4 F1800
; LINE_WIDTH: 0.0951007
G1 F1500
M204 S6000
G1 X90.249 Y98.711 E.00067
G1 X90.271 Y98.776 E.00024
M204 S10000
G1 X90.443 Y99.492 F18000
; LINE_WIDTH: 0.476269
M73 P81 R5
G1 F1500
M204 S6000
G1 X90.482 Y99.766 E.00623
; LINE_WIDTH: 0.430351
G1 X90.522 Y100.04 E.0056
; LINE_WIDTH: 0.403767
G1 X90.526 Y100.078 E.00071
; LINE_WIDTH: 0.377526
G1 X90.547 Y100.574 E.00871
; LINE_WIDTH: 0.360061
G1 X90.5 Y101.131 E.00933
G1 X90.414 Y101.476 E.00592
G1 X90.297 Y101.809 E.00589
G1 X90.038 Y102.279 E.00895
G1 X89.674 Y102.714 E.00946
G1 X89.478 Y102.892 E.00442
G1 X89.257 Y103.06 E.00463
G1 X89.005 Y103.218 E.00496
G1 X88.518 Y103.44 E.00893
G1 X88.127 Y103.542 E.00674
G1 X87.802 Y103.586 E.00547
G1 X87.282 Y103.584 E.00867
G1 X86.933 Y103.533 E.00588
G1 X86.59 Y103.442 E.00593
G1 X86.076 Y103.208 E.00941
G1 X85.808 Y103.042 E.00526
G1 X85.567 Y102.848 E.00516
G1 X85.278 Y102.552 E.0069
G1 X85.133 Y102.375 E.00381
G1 X84.855 Y101.916 E.00896
G1 X84.664 Y101.4 E.00916
G1 X84.599 Y101.131 E.00462
G1 X84.557 Y100.778 E.00593
G1 X84.567 Y100.164 E.01024
; LINE_WIDTH: 0.405436
G1 X84.596 Y99.918 E.00469
; LINE_WIDTH: 0.441797
G1 X84.623 Y99.706 E.00442
; LINE_WIDTH: 0.475454
G1 X84.649 Y99.495 E.00478
M204 S10000
G1 X84.828 Y98.783 F18000
; LINE_WIDTH: 0.0935277
G1 F1500
M204 S6000
G1 X84.85 Y98.717 E.00024
G1 X84.973 Y98.584 E.00061
; WIPE_START
G1 X84.85 Y98.717 E-.27442
G1 X84.828 Y98.783 E-.10558
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X86.711 Y96.741 Z4.92 F18000
G1 Z4.52
G1 E.4 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.595532
G1 F1500
M204 S6000
G1 X87.027 Y96.721 E.00901
; LINE_WIDTH: 0.562837
G1 X87.343 Y96.701 E.00849
G1 X88.192 Y96.728 E.02277
; WIPE_START
G1 X87.343 Y96.701 E-.27677
G1 X87.027 Y96.721 E-.10323
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X86.711 Y96.741 Z4.92 F18000
G1 Z4.52
G1 E.4 F1800
; LINE_WIDTH: 0.597751
G1 F1500
M204 S6000
G1 X86.488 Y96.724 E.00638
; LINE_WIDTH: 0.562347
G1 X86.265 Y96.706 E.00599
; LINE_WIDTH: 0.511136
G1 X86.042 Y96.689 E.00541
G1 X85.442 Y96.689 E.01452
G1 X85.443 Y97.349 E.01598
G1 X85.968 Y97.046 E.01469
; LINE_WIDTH: 0.529305
G1 X86.295 Y96.912 E.00887
; LINE_WIDTH: 0.56943
G1 X86.621 Y96.777 E.00957
; LINE_WIDTH: 0.602472
G1 X86.655 Y96.764 E.00104
; WIPE_START
G1 X86.621 Y96.777 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X89.659 Y96.685 Z4.92 F18000
G1 Z4.52
G1 E.4 F1800
; LINE_WIDTH: 0.506812
G1 F1500
M204 S6000
G1 X88.958 Y96.685 E.01683
; LINE_WIDTH: 0.521142
G1 X88.675 Y96.7 E.007
; LINE_WIDTH: 0.549802
G1 X88.392 Y96.714 E.0074
; LINE_WIDTH: 0.579682
G1 X88.252 Y96.73 E.0039
; LINE_WIDTH: 0.573127
G1 X88.586 Y96.843 E.00962
; LINE_WIDTH: 0.511213
G1 X88.919 Y96.956 E.00853
G1 X89.531 Y97.251 E.01644
G1 X89.658 Y97.332 E.00365
G1 X89.659 Y96.745 E.01421
M204 S10000
G1 X90.098 Y96.247 F18000
; LINE_WIDTH: 0.419992
G1 F1500
M204 S6000
G1 X85.002 Y96.251 E.10021
G1 X85.005 Y98.1 E.03638
G1 X85.115 Y98.158 E.00244
G1 X85.482 Y97.834 E.00962
G1 X86.188 Y97.426 E.01604
G1 X86.769 Y97.233 E.01205
G1 X87.4 Y97.15 E.0125
G1 X88.214 Y97.21 E.01606
G1 X88.797 Y97.376 E.01191
G1 X89.335 Y97.642 E.01181
G1 X89.718 Y97.912 E.00922
G1 X89.965 Y98.15 E.00675
G1 X90.044 Y98.079 E.00209
G1 X90.095 Y98.083 E.00101
G1 X90.097 Y96.307 E.03494
; CHANGE_LAYER
; Z_HEIGHT: 4.64
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F1500
G1 X90.095 Y98.083 E-.33753
G1 X90.044 Y98.079 E-.00973
G1 X89.965 Y98.15 E-.02019
G1 X89.918 Y98.104 E-.01255
; WIPE_END
G1 E-.02 F1800
; layer num/total_layer_count: 38/49
; update layer progress
M73 L38
M991 S0 P37 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z4.92 I1.04 J.632 P1  F18000
G1 X94.431 Y90.682 Z4.92
G1 Z4.64
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X94.269 Y90.682 E.00342
G1 X94.269 Y90.22 E.00977
G1 X95.431 Y90.22 E.02458
G1 X95.431 Y90.682 E.00977
G1 X94.491 Y90.682 E.0199
; WIPE_START
M204 S6000
G1 X94.269 Y90.682 E-.04209
G1 X94.269 Y90.22 E-.08769
G1 X95.431 Y90.22 E-.22069
G1 X95.431 Y90.376 E-.02952
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X98.669 Y90.22 Z5.04 F18000
G1 Z4.64
G1 E.4 F1800
G1 F1500
M204 S500
G1 X99.831 Y90.22 E.02458
G1 X99.831 Y90.682 E.00977
G1 X98.669 Y90.682 E.02458
G1 X98.669 Y90.28 E.0085
; WIPE_START
M204 S6000
G1 X99.831 Y90.22 E-.22098
G1 X99.831 Y90.682 E-.08769
G1 X99.455 Y90.682 E-.07132
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X98.638 Y94.889 Z5.04 F18000
G1 Z4.64
G1 E.4 F1800
G1 F1500
M204 S500
G1 X99.407 Y94.12 E.02301
G1 X99.407 Y95.357 E.02619
G1 X98.169 Y95.357 E.02619
G1 X98.595 Y94.931 E.01276
M204 S10000
G1 X98.338 Y94.589 F18000
G1 F1500
M204 S500
G1 X99.831 Y93.096 E.04469
G1 X99.831 Y95.782 E.05685
G1 X97.145 Y95.782 E.05685
G1 X98.295 Y94.631 E.03444
; WIPE_START
M204 S6000
G1 X99.71 Y93.217 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X96.569 Y87.944 Z5.04 F18000
G1 Z4.64
G1 E.4 F1800
G1 F1500
M204 S500
G1 X97.531 Y87.944 E.02035
G1 X97.05 Y88.425 E.01439
G1 X96.612 Y87.987 E.01312
; WIPE_START
M204 S6000
G1 X97.531 Y87.944 E-.17484
G1 X97.05 Y88.425 E-.1292
G1 X96.767 Y88.143 E-.07596
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X94.693 Y94.12 Z5.04 F18000
G1 Z4.64
G1 E.4 F1800
G1 F1500
M204 S500
G1 X95.931 Y95.357 E.03704
G1 X94.693 Y95.357 E.02619
G1 X94.693 Y94.18 E.02492
; WIPE_START
M204 S6000
G1 X95.931 Y95.357 E-.32452
G1 X95.639 Y95.357 E-.05549
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X89.324 Y98.132 Z5.04 F18000
G1 Z4.64
G1 E.4 F1800
G1 F1500
M204 S500
G1 X89.138 Y98.001 E.00482
G1 X88.663 Y97.764 E.01123
G1 X88.154 Y97.615 E.01123
G1 X87.78 Y97.564 E.008
G1 X87.433 Y97.558 E.00735
G1 X86.876 Y97.628 E.01187
G1 X86.348 Y97.8 E.01176
G1 X85.856 Y98.07 E.01187
G1 X85.579 Y98.279 E.00735
G1 X85.306 Y98.54 E.008
G1 X84.991 Y98.948 E.0109
G1 X84.788 Y99.312 E.00882
G1 X84.598 Y99.262 E.00416
G1 X84.593 Y95.842 E.07239
G1 X90.507 Y95.837 E.12517
G1 X90.507 Y99.272 E.0727
G1 X90.305 Y99.315 E.00435
G1 X90.058 Y98.872 E.01075
G1 X89.731 Y98.474 E.0109
G1 X89.449 Y98.22 E.00804
G1 X89.373 Y98.167 E.00196
M204 S10000
G1 X89.08 Y98.479 F18000
G1 F1500
M204 S500
G1 X89.184 Y98.552 E.00269
G1 X89.424 Y98.768 E.00683
G1 X89.71 Y99.117 E.00955
G1 X89.875 Y99.393 E.00681
G1 X89.995 Y99.659 E.00618
G1 X90.129 Y100.13 E.01037
G1 X90.172 Y100.601 E.01001
G1 X90.13 Y101.069 E.00995
G1 X90.007 Y101.513 E.00975
G1 X89.876 Y101.808 E.00683
G1 X89.71 Y102.085 E.00683
G1 X89.418 Y102.441 E.00975
G1 X89.057 Y102.746 E.01001
G1 X88.63 Y102.988 E.01037
G1 X88.359 Y103.093 E.00617
G1 X88.047 Y103.174 E.0068
G1 X87.586 Y103.223 E.00981
G1 X87.098 Y103.182 E.01037
G1 X86.814 Y103.116 E.00617
G1 X86.511 Y103.007 E.00681
G1 X86.106 Y102.789 E.00975
G1 X85.738 Y102.496 E.00995
G1 X85.429 Y102.142 E.00995
G1 X85.188 Y101.739 E.00995
G1 X85.026 Y101.307 E.00976
G1 X84.959 Y100.992 E.00683
G1 X84.93 Y100.67 E.00683
G1 X84.958 Y100.207 E.00981
G1 X85.078 Y99.732 E.01037
G1 X85.19 Y99.463 E.00617
G1 X85.346 Y99.182 E.00681
G1 X85.622 Y98.825 E.00955
G1 X85.855 Y98.603 E.00681
G1 X86.088 Y98.427 E.00618
G1 X86.517 Y98.191 E.01037
G1 X86.969 Y98.044 E.01006
G1 X87.455 Y97.982 E.01037
G1 X87.747 Y97.988 E.00618
G1 X88.066 Y98.031 E.00681
G1 X88.508 Y98.16 E.00975
G1 X88.92 Y98.366 E.00975
G1 X89.031 Y98.445 E.00287
M204 S250
G1 X88.844 Y98.814 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X88.928 Y98.873 E.00202
G1 X89.127 Y99.052 E.00526
G1 X89.375 Y99.353 E.00767
G1 X89.512 Y99.582 E.00525
G1 X89.609 Y99.8 E.00469
G1 X89.725 Y100.205 E.0083
G1 X89.761 Y100.601 E.00781
G1 X89.725 Y100.996 E.00779
G1 X89.621 Y101.375 E.00774
G1 X89.512 Y101.619 E.00526
G1 X89.375 Y101.849 E.00526
G1 X89.125 Y102.152 E.00774
G1 X88.822 Y102.409 E.00781
G1 X88.455 Y102.617 E.0083
G1 X88.233 Y102.703 E.00469
G1 X87.974 Y102.77 E.00525
G1 X87.582 Y102.812 E.00775
G1 X87.162 Y102.776 E.00829
G1 X86.93 Y102.722 E.00469
G1 X86.678 Y102.632 E.00525
G1 X86.332 Y102.446 E.00773
G1 X86.022 Y102.199 E.00779
G1 X85.761 Y101.9 E.0078
G1 X85.558 Y101.56 E.0078
G1 X85.42 Y101.192 E.00774
G1 X85.364 Y100.93 E.00526
G1 X85.34 Y100.664 E.00526
G1 X85.364 Y100.27 E.00775
G1 X85.467 Y99.862 E.0083
G1 X85.559 Y99.642 E.00469
G1 X85.689 Y99.408 E.00526
G1 X85.927 Y99.1 E.00767
G1 X86.12 Y98.915 E.00526
G1 X86.311 Y98.771 E.00469
G1 X86.68 Y98.568 E.00829
G1 X87.059 Y98.445 E.00783
G1 X87.477 Y98.392 E.0083
G1 X87.716 Y98.397 E.00469
G1 X87.98 Y98.433 E.00525
G1 X88.358 Y98.543 E.00773
G1 X88.709 Y98.719 E.00773
G1 X88.795 Y98.779 E.00207
; WIPE_START
M204 S6000
G1 X88.928 Y98.873 E-.0309
G1 X89.127 Y99.052 E-.05082
G1 X89.375 Y99.353 E-.0741
G1 X89.512 Y99.582 E-.05075
G1 X89.609 Y99.8 E-.04528
G1 X89.725 Y100.205 E-.08015
G1 X89.748 Y100.457 E-.048
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X93.08 Y93.59 Z5.04 F18000
G1 X95.869 Y87.844 Z5.04
G1 Z4.64
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X95.869 Y87.52 E.00686
G1 X96.869 Y87.52 E.02117
G1 X96.869 Y77.382 E.21459
G1 X94.582 Y77.382 E.0484
G1 X94.514 Y77.05 E.00717
G1 X94.373 Y76.788 E.00629
G1 X94.163 Y76.578 E.00629
G1 X93.901 Y76.437 E.0063
G1 X93.636 Y76.382 E.00572
G1 X81.496 Y76.382 E.25697
G1 X81.2 Y76.434 E.00636
G1 X80.904 Y76.602 E.0072
G1 X80.688 Y76.842 E.00684
G1 X80.542 Y77.18 E.00781
G1 X80.531 Y94.446 E.36543
G1 X80.566 Y94.686 E.00514
G1 X80.678 Y94.947 E.006
G1 X80.961 Y95.246 E.00872
G1 X81.256 Y95.384 E.00688
G1 X81.505 Y95.42 E.00534
G1 X94.269 Y95.41 E.27016
G1 X94.269 Y93.096 E.04898
G1 X96.955 Y95.782 E.08039
G1 X90.931 Y95.782 E.12751
G1 X90.931 Y100.582 E.10161
G1 X90.906 Y101.001 E.00887
G1 X90.834 Y101.4 E.00859
G1 X90.769 Y101.628 E.00501
G1 X90.643 Y101.962 E.00756
G1 X90.456 Y102.328 E.0087
G1 X90.105 Y102.815 E.01271
G1 X89.719 Y103.191 E.01141
G1 X89.344 Y103.466 E.00983
G1 X88.812 Y103.737 E.01264
G1 X88.297 Y103.896 E.01142
G1 X87.847 Y103.967 E.00963
G1 X87.25 Y103.968 E.01264
G1 X86.659 Y103.861 E.0127
G1 X86.28 Y103.733 E.00847
G1 X85.918 Y103.561 E.00848
G1 X85.58 Y103.347 E.00848
G1 X85.269 Y103.094 E.00848
G1 X84.99 Y102.807 E.00847
G1 X84.747 Y102.489 E.00847
G1 X84.543 Y102.144 E.00848
G1 X84.383 Y101.78 E.00841
G1 X84.254 Y101.344 E.00964
G1 X84.176 Y100.81 E.01142
G1 X84.168 Y95.783 E.1064
G1 X81.478 Y95.778 E.05695
G1 X81.246 Y95.746 E.00496
G1 X80.931 Y95.634 E.00707
G1 X80.792 Y95.554 E.00339
G1 X80.546 Y95.348 E.00679
G1 X80.448 Y95.231 E.00324
G1 X80.324 Y95.032 E.00495
G1 X80.207 Y94.719 E.00707
G1 X80.169 Y94.383 E.00716
G1 X80.169 Y77.419 E.35906
G1 X80.206 Y77.092 E.00697
G1 X80.285 Y76.853 E.00531
G1 X80.391 Y76.655 E.00476
G1 X80.49 Y76.519 E.00356
G1 X80.67 Y76.339 E.0054
G1 X80.785 Y76.254 E.00302
G1 X81.004 Y76.135 E.00528
G1 X81.241 Y76.057 E.00528
G1 X81.39 Y76.03 E.0032
G1 X93.605 Y76.023 E.25855
G1 X93.792 Y76.043 E.00398
G1 X94.097 Y76.134 E.00672
G1 X94.233 Y76.203 E.00324
G1 X94.425 Y76.336 E.00495
G1 X94.657 Y76.577 E.00708
G1 X94.948 Y77.02 E.01122
G1 X97.231 Y77.02 E.04831
G1 X97.231 Y87.52 E.22224
G1 X98.231 Y87.52 E.02117
G1 X98.231 Y87.844 E.00686
G1 X97.05 Y89.025 E.03534
G1 X95.912 Y87.887 E.03407
; WIPE_START
M204 S6000
G1 X95.869 Y87.52 E-.07014
G1 X96.869 Y87.52 E-.19
G1 X96.869 Y86.889 E-.11986
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X94.84 Y91.091 Z5.04 F18000
G1 Z4.64
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X94.84 Y93.088 E.03928
G1 X97.05 Y95.298 E.06147
G1 X99.26 Y93.088 E.06147
G1 X99.26 Y91.091 E.03928
G1 X98.26 Y91.091 E.01967
G1 X98.26 Y89.811 E.02518
G1 X100.24 Y89.811 E.03895
G1 X100.24 Y96.191 E.12549
G1 X91.34 Y96.191 E.17505
G1 X91.34 Y100.594 E.08661
G1 X91.313 Y101.049 E.00896
G1 X91.233 Y101.493 E.00887
G1 X91.158 Y101.756 E.00539
G1 X91.018 Y102.128 E.00781
G1 X90.812 Y102.531 E.0089
G1 X90.695 Y102.715 E.0043
G1 X90.419 Y103.077 E.00896
G1 X89.979 Y103.508 E.0121
G1 X89.57 Y103.808 E.00999
G1 X89.382 Y103.918 E.00427
G1 X88.972 Y104.114 E.00895
G1 X88.384 Y104.296 E.01211
G1 X87.885 Y104.376 E.00992
G1 X87.435 Y104.389 E.00887
G1 X87.214 Y104.376 E.00436
G1 X86.993 Y104.35 E.00436
G1 X86.551 Y104.257 E.00889
G1 X86.126 Y104.113 E.00883
G1 X85.72 Y103.92 E.00883
G1 X85.341 Y103.68 E.00883
G1 X84.992 Y103.397 E.00883
G1 X84.679 Y103.075 E.00883
G1 X84.407 Y102.718 E.00883
G1 X84.179 Y102.331 E.00883
M73 P82 R5
G1 X83.998 Y101.921 E.00881
G1 X83.855 Y101.437 E.00993
G1 X83.767 Y100.828 E.01211
G1 X83.76 Y96.191 E.09121
G1 X81.449 Y96.188 E.04546
G1 X81.16 Y96.147 E.00574
G1 X80.937 Y96.082 E.00456
G1 X80.747 Y96 E.00408
G1 X80.567 Y95.896 E.00409
G1 X80.4 Y95.772 E.0041
G1 X80.248 Y95.629 E.00409
G1 X80.116 Y95.472 E.00404
G1 X79.962 Y95.224 E.00573
G1 X79.868 Y95.012 E.00457
G1 X79.809 Y94.814 E.00407
G1 X79.772 Y94.609 E.00409
G1 X79.76 Y94.395 E.00422
G1 X79.76 Y77.407 E.33413
G1 X79.772 Y77.193 E.00422
G1 X79.808 Y76.991 E.00403
G1 X79.907 Y76.692 E.00621
G1 X80.043 Y76.437 E.00567
G1 X80.178 Y76.252 E.0045
G1 X80.402 Y76.028 E.00623
G1 X80.564 Y75.907 E.00398
G1 X80.841 Y75.758 E.00619
G1 X81.14 Y75.659 E.00619
G1 X81.342 Y75.623 E.00403
G1 X81.556 Y75.611 E.00422
G1 X93.627 Y75.613 E.23743
G1 X93.862 Y75.639 E.00463
G1 X94.063 Y75.686 E.00408
G1 X94.259 Y75.758 E.00409
G1 X94.443 Y75.85 E.00404
G1 X94.682 Y76.016 E.00573
G1 X94.852 Y76.174 E.00457
G1 X94.986 Y76.332 E.00407
G1 X95.169 Y76.611 E.00656
G1 X97.64 Y76.611 E.04861
G1 X97.64 Y87.111 E.20653
G1 X98.64 Y87.111 E.01967
G1 X98.64 Y88.014 E.01776
G1 X97.05 Y89.604 E.04423
G1 X95.46 Y88.014 E.04423
G1 X95.46 Y87.111 E.01776
G1 X96.46 Y87.111 E.01967
G1 X96.46 Y77.791 E.18332
G1 X94.16 Y77.791 E.04524
G1 X94.159 Y77.356 E.00855
G1 X94.125 Y77.191 E.0033
G1 X94.041 Y77.035 E.00349
G1 X93.916 Y76.91 E.00349
G1 X93.759 Y76.826 E.00349
G1 X93.595 Y76.792 E.00331
G1 X81.532 Y76.791 E.23727
G1 X81.341 Y76.825 E.00381
G1 X81.164 Y76.925 E.004
G1 X81.037 Y77.066 E.00373
G1 X80.951 Y77.265 E.00427
G1 X80.94 Y94.416 E.33734
G1 X80.963 Y94.574 E.00313
G1 X81.026 Y94.718 E.0031
G1 X81.205 Y94.908 E.00515
G1 X81.374 Y94.987 E.00367
G1 X81.535 Y95.011 E.00319
G1 X93.86 Y95.001 E.24243
G1 X93.86 Y89.811 E.10209
G1 X95.84 Y89.811 E.03895
G1 X95.84 Y91.091 E.02518
G1 X94.9 Y91.091 E.01849
; WIPE_START
M204 S6000
G1 X94.84 Y93.088 E-.3796
G1 X94.842 Y93.089 E-.0004
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
M73 P82 R4
G1 X-13.0 F3000 ; move to safe pos
M400
M1004 S5 P1  ; external shutter
M400 P300
M971 S11 C11 O0
G92 E0
G1 X0 F18000
M623

; SKIPTYPE: head_wrap_detect
M622.1 S1
M1002 judge_flag g39_3rd_layer_detect_flag
M622 J1
    ; enable nozzle clog detect at 3rd layer
    


    M622.1 S1
    M1002 judge_flag g39_detection_flag
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




G1 X94.35 Y92.887
G1 Z4.64
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.596522
G1 F1500
M204 S6000
G1 X94.35 Y90.886 E.05697
; WIPE_START
G1 X94.35 Y92.886 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X95.077 Y94.958 Z5.04 F18000
G1 Z4.64
G1 E.4 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.365752
G1 F1500
M204 S6000
G1 X95.013 Y94.995 E.00125
G1 X95.062 Y95.023 E.00095
; WIPE_START
G1 X95.013 Y94.995 E-.16436
G1 X95.077 Y94.958 E-.21564
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X99.065 Y94.958 Z5.04 F18000
G1 Z4.64
G1 E.4 F1800
G1 F1500
M204 S6000
G1 X99.002 Y94.995 E.00125
G1 X99.05 Y95.023 E.00095
; WIPE_START
G1 X99.002 Y94.995 E-.16436
G1 X99.065 Y94.958 E-.21564
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X99.75 Y92.887 Z5.04 F18000
G1 Z4.64
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.596522
G1 F1500
M204 S6000
G1 X99.75 Y90.886 E.05697
; WIPE_START
G1 X99.75 Y92.886 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X93.176 Y96.765 Z5.04 F18000
G1 X90.117 Y98.57 Z5.04
G1 Z4.64
G1 E.4 F1800
; LINE_WIDTH: 0.095849
G1 F1500
M204 S6000
G1 X90.252 Y98.715 E.0007
G1 X90.275 Y98.782 E.00025
M204 S10000
G1 X90.45 Y99.501 F18000
; LINE_WIDTH: 0.47649
G1 F1500
M204 S6000
G1 X90.487 Y99.77 E.00609
; LINE_WIDTH: 0.434164
G1 X90.525 Y100.038 E.00552
; LINE_WIDTH: 0.409678
G1 X90.528 Y100.074 E.00069
; LINE_WIDTH: 0.384021
G1 X90.551 Y100.571 E.00889
; LINE_WIDTH: 0.360449
G1 X90.497 Y101.151 E.00972
G1 X90.363 Y101.628 E.00828
G1 X90.294 Y101.808 E.00322
G1 X90.044 Y102.267 E.00872
G1 X89.698 Y102.696 E.00921
G1 X89.259 Y103.063 E.00955
G1 X88.666 Y103.383 E.01126
G1 X88.127 Y103.542 E.00938
G1 X87.811 Y103.585 E.00531
G1 X87.449 Y103.596 E.00605
G1 X87.051 Y103.557 E.00667
G1 X86.76 Y103.494 E.00498
G1 X86.347 Y103.347 E.00732
G1 X86.104 Y103.224 E.00454
G1 X85.803 Y103.036 E.00593
G1 X85.488 Y102.779 E.00678
G1 X85.281 Y102.556 E.00508
G1 X85.116 Y102.352 E.0044
G1 X84.883 Y101.97 E.00747
G1 X84.669 Y101.424 E.00979
G1 X84.59 Y101.057 E.00627
G1 X84.558 Y100.788 E.00453
G1 X84.567 Y100.164 E.01042
; LINE_WIDTH: 0.405365
G1 X84.596 Y99.918 E.00469
; LINE_WIDTH: 0.441668
G1 X84.622 Y99.706 E.00443
; LINE_WIDTH: 0.475281
G1 X84.649 Y99.495 E.00478
M204 S10000
G1 X84.828 Y98.783 F18000
; LINE_WIDTH: 0.0867387
G1 F1500
M204 S6000
G1 X84.843 Y98.737 E.00015
G1 X84.924 Y98.647 E.00037
; WIPE_START
G1 X84.843 Y98.737 E-.27085
G1 X84.828 Y98.783 E-.10915
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X86.71 Y96.742 Z5.04 F18000
G1 Z4.64
G1 E.4 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.595702
G1 F1500
M204 S6000
G1 X87.025 Y96.721 E.00897
; LINE_WIDTH: 0.562945
G1 X87.34 Y96.701 E.00845
G1 X88.192 Y96.728 E.02286
; WIPE_START
G1 X87.34 Y96.701 E-.27739
G1 X87.025 Y96.721 E-.10261
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X86.71 Y96.742 Z5.04 F18000
G1 Z4.64
G1 E.4 F1800
; LINE_WIDTH: 0.597282
G1 F1500
M204 S6000
G1 X86.479 Y96.723 E.0066
; LINE_WIDTH: 0.560582
G1 X86.248 Y96.705 E.00618
; LINE_WIDTH: 0.507613
G1 X86.017 Y96.687 E.00557
G1 X85.44 Y96.688 E.01387
G1 X85.441 Y97.332 E.0155
G1 X85.958 Y97.049 E.01417
; LINE_WIDTH: 0.52633
G1 X86.289 Y96.913 E.00894
; LINE_WIDTH: 0.567925
G1 X86.621 Y96.778 E.00969
; LINE_WIDTH: 0.602177
G1 X86.654 Y96.764 E.00104
; WIPE_START
G1 X86.621 Y96.778 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X89.66 Y96.685 Z5.04 F18000
G1 Z4.64
G1 E.4 F1800
; LINE_WIDTH: 0.506972
G1 F1500
M204 S6000
G1 X88.958 Y96.685 E.01684
; LINE_WIDTH: 0.52126
G1 X88.675 Y96.7 E.007
; LINE_WIDTH: 0.549835
G1 X88.392 Y96.714 E.0074
; LINE_WIDTH: 0.579677
G1 X88.252 Y96.73 E.0039
; LINE_WIDTH: 0.573167
G1 X88.586 Y96.843 E.00962
; LINE_WIDTH: 0.511361
G1 X88.919 Y96.956 E.00853
G1 X89.531 Y97.251 E.01645
G1 X89.66 Y97.333 E.00369
G1 X89.66 Y96.745 E.01424
M204 S10000
G1 X90.097 Y96.247 F18000
; LINE_WIDTH: 0.419992
G1 F1500
M204 S6000
G1 X85.002 Y96.251 E.10021
G1 X85.006 Y98.172 E.03779
G1 X85.057 Y98.216 E.00134
G1 X85.612 Y97.742 E.01437
G1 X86.168 Y97.432 E.01252
G1 X86.769 Y97.233 E.01244
G1 X87.396 Y97.15 E.01245
G1 X88.214 Y97.21 E.01612
G1 X88.797 Y97.376 E.01191
G1 X89.335 Y97.642 E.01181
G1 X89.718 Y97.912 E.00921
G1 X89.966 Y98.151 E.00676
G1 X90.045 Y98.079 E.00211
G1 X90.097 Y98.083 E.00103
G1 X90.097 Y96.307 E.03494
; CHANGE_LAYER
; Z_HEIGHT: 4.76
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F1500
G1 X90.097 Y98.083 E-.33754
G1 X90.045 Y98.079 E-.00995
G1 X89.966 Y98.151 E-.02042
G1 X89.92 Y98.107 E-.01209
; WIPE_END
G1 E-.02 F1800
; layer num/total_layer_count: 39/49
; update layer progress
M73 L39
M991 S0 P38 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z5.04 I1.04 J.632 P1  F18000
G1 X94.431 Y90.682 Z5.04
G1 Z4.76
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X94.269 Y90.682 E.00342
G1 X94.269 Y90.22 E.00977
G1 X95.431 Y90.22 E.02458
G1 X95.431 Y90.682 E.00977
G1 X94.491 Y90.682 E.0199
; WIPE_START
M204 S6000
G1 X94.269 Y90.682 E-.04209
G1 X94.269 Y90.22 E-.08769
G1 X95.431 Y90.22 E-.22069
G1 X95.431 Y90.376 E-.02952
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X98.669 Y90.22 Z5.16 F18000
G1 Z4.76
G1 E.4 F1800
G1 F1500
M204 S500
G1 X99.831 Y90.22 E.02458
G1 X99.831 Y90.682 E.00977
G1 X98.669 Y90.682 E.02458
G1 X98.669 Y90.28 E.0085
; WIPE_START
M204 S6000
G1 X99.831 Y90.22 E-.22098
G1 X99.831 Y90.682 E-.08769
G1 X99.455 Y90.682 E-.07132
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X98.638 Y94.889 Z5.16 F18000
G1 Z4.76
G1 E.4 F1800
G1 F1500
M204 S500
G1 X99.407 Y94.12 E.02301
G1 X99.407 Y95.357 E.02619
G1 X98.169 Y95.357 E.02619
G1 X98.595 Y94.931 E.01276
M204 S10000
G1 X98.338 Y94.589 F18000
G1 F1500
M204 S500
G1 X99.831 Y93.096 E.04469
G1 X99.831 Y95.782 E.05685
G1 X97.145 Y95.782 E.05685
G1 X98.295 Y94.631 E.03444
; WIPE_START
M204 S6000
G1 X99.71 Y93.217 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X96.569 Y87.944 Z5.16 F18000
G1 Z4.76
G1 E.4 F1800
G1 F1500
M204 S500
G1 X97.531 Y87.944 E.02035
G1 X97.05 Y88.425 E.01439
G1 X96.612 Y87.987 E.01312
; WIPE_START
M204 S6000
G1 X97.531 Y87.944 E-.17484
G1 X97.05 Y88.425 E-.1292
G1 X96.767 Y88.143 E-.07596
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X94.693 Y94.12 Z5.16 F18000
G1 Z4.76
G1 E.4 F1800
G1 F1500
M204 S500
G1 X95.931 Y95.357 E.03704
G1 X94.693 Y95.357 E.02619
G1 X94.693 Y94.18 E.02492
; WIPE_START
M204 S6000
G1 X95.931 Y95.357 E-.32452
G1 X95.639 Y95.357 E-.05549
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X89.32 Y98.129 Z5.16 F18000
G1 Z4.76
G1 E.4 F1800
G1 F1500
M204 S500
G1 X89.165 Y98.019 E.00401
G1 X88.667 Y97.765 E.01182
G1 X88.154 Y97.615 E.01132
G1 X87.78 Y97.564 E.008
G1 X87.43 Y97.558 E.00741
G1 X86.876 Y97.628 E.01182
G1 X86.352 Y97.798 E.01165
G1 X85.885 Y98.05 E.01124
G1 X85.581 Y98.278 E.00804
G1 X85.306 Y98.54 E.00804
G1 X84.982 Y98.96 E.01124
G1 X84.792 Y99.325 E.00871
G1 X84.598 Y99.278 E.00423
G1 X84.593 Y95.842 E.07273
G1 X90.507 Y95.837 E.12517
G1 X90.507 Y99.279 E.07285
G1 X90.316 Y99.329 E.00417
G1 X90.068 Y98.884 E.01077
G1 X89.731 Y98.474 E.01124
G1 X89.45 Y98.221 E.00799
G1 X89.369 Y98.163 E.00212
M204 S10000
G1 X89.074 Y98.475 F18000
G1 F1500
M204 S500
G1 X89.185 Y98.553 E.00287
G1 X89.423 Y98.768 E.0068
G1 X89.716 Y99.124 E.00976
G1 X89.946 Y99.537 E.01
G1 X90.1 Y99.999 E.01032
G1 X90.152 Y100.289 E.00623
G1 X90.171 Y100.61 E.00681
G1 X90.13 Y101.069 E.00975
G1 X90.004 Y101.525 E.01
G1 X89.789 Y101.962 E.01032
G1 X89.622 Y102.205 E.00623
G1 X89.41 Y102.447 E.00681
G1 X89.059 Y102.745 E.00975
G1 X88.66 Y102.975 E.00975
G1 X88.36 Y103.093 E.00683
G1 X88.047 Y103.174 E.00683
G1 X87.589 Y103.222 E.00975
M73 P83 R4
G1 X87.121 Y103.187 E.00995
G1 X86.666 Y103.069 E.00995
G1 X86.248 Y102.875 E.00975
G1 X85.978 Y102.698 E.00683
G1 X85.73 Y102.487 E.00688
G1 X85.418 Y102.124 E.01013
G1 X85.261 Y101.876 E.00623
G1 X85.121 Y101.586 E.00681
G1 X84.986 Y101.146 E.00975
G1 X84.931 Y100.689 E.00975
G1 X84.94 Y100.366 E.00683
G1 X84.988 Y100.047 E.00683
G1 X85.124 Y99.607 E.00975
G1 X85.341 Y99.19 E.00994
G1 X85.623 Y98.825 E.00976
G1 X85.856 Y98.602 E.00683
G1 X86.114 Y98.408 E.00683
G1 X86.52 Y98.19 E.00975
G1 X86.969 Y98.044 E.01
G1 X87.453 Y97.983 E.01032
G1 X87.747 Y97.988 E.00623
G1 X88.066 Y98.031 E.00681
G1 X88.51 Y98.161 E.0098
G1 X88.945 Y98.383 E.01032
G1 X89.025 Y98.44 E.00209
M204 S250
G1 X88.837 Y98.808 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X88.928 Y98.873 E.0022
G1 X89.127 Y99.052 E.00525
G1 X89.377 Y99.356 E.00774
G1 X89.57 Y99.702 E.00781
G1 X89.702 Y100.1 E.00825
G1 X89.745 Y100.337 E.00473
G1 X89.761 Y100.604 E.00526
G1 X89.725 Y100.996 E.00773
G1 X89.62 Y101.379 E.00782
G1 X89.435 Y101.755 E.00825
G1 X89.298 Y101.953 E.00474
G1 X89.122 Y102.155 E.00526
G1 X88.822 Y102.409 E.00773
G1 X88.482 Y102.605 E.00773
G1 X88.233 Y102.703 E.00526
G1 X87.974 Y102.77 E.00526
G1 X87.583 Y102.811 E.00774
G1 X87.188 Y102.782 E.0078
G1 X86.804 Y102.682 E.0078
G1 X86.447 Y102.517 E.00773
G1 X86.224 Y102.37 E.00526
G1 X86.02 Y102.196 E.00528
G1 X85.748 Y101.88 E.00819
G1 X85.619 Y101.677 E.00474
G1 X85.503 Y101.436 E.00525
G1 X85.387 Y101.061 E.00774
G1 X85.341 Y100.67 E.00773
G1 X85.349 Y100.403 E.00526
G1 X85.388 Y100.138 E.00526
G1 X85.504 Y99.762 E.00774
G1 X85.687 Y99.411 E.00779
G1 X85.927 Y99.1 E.00774
G1 X86.121 Y98.915 E.00526
G1 X86.335 Y98.754 E.00526
G1 X86.681 Y98.568 E.00774
G1 X87.059 Y98.445 E.00781
G1 X87.475 Y98.392 E.00825
G1 X87.716 Y98.397 E.00474
G1 X87.98 Y98.433 E.00526
G1 X88.359 Y98.543 E.00775
G1 X88.732 Y98.734 E.00825
G1 X88.788 Y98.774 E.00136
; WIPE_START
M204 S6000
G1 X88.928 Y98.873 E-.03263
G1 X89.127 Y99.052 E-.05072
G1 X89.377 Y99.356 E-.07475
G1 X89.57 Y99.702 E-.07546
G1 X89.702 Y100.1 E-.07966
G1 X89.745 Y100.337 E-.04574
G1 X89.751 Y100.448 E-.02103
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X93.084 Y93.582 Z5.16 F18000
G1 X95.869 Y87.844 Z5.16
G1 Z4.76
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X95.869 Y87.52 E.00686
G1 X96.869 Y87.52 E.02117
G1 X96.869 Y77.382 E.21459
G1 X94.582 Y77.382 E.0484
G1 X94.514 Y77.05 E.00716
G1 X94.373 Y76.788 E.00629
G1 X94.163 Y76.578 E.0063
G1 X93.901 Y76.437 E.0063
G1 X93.636 Y76.382 E.00571
G1 X81.496 Y76.382 E.25696
G1 X81.198 Y76.434 E.0064
G1 X80.889 Y76.613 E.00756
G1 X80.665 Y76.879 E.00737
G1 X80.542 Y77.19 E.00707
G1 X80.531 Y94.473 E.36581
G1 X80.616 Y94.832 E.0078
G1 X80.777 Y95.073 E.00615
G1 X80.988 Y95.259 E.00594
G1 X81.256 Y95.384 E.00626
G1 X81.505 Y95.42 E.00534
G1 X94.269 Y95.41 E.27016
G1 X94.269 Y93.096 E.04898
G1 X96.955 Y95.782 E.08039
G1 X90.931 Y95.782 E.12751
G1 X90.931 Y100.582 E.10161
G1 X90.906 Y101.001 E.00887
G1 X90.835 Y101.395 E.00847
G1 X90.718 Y101.778 E.00848
G1 X90.553 Y102.153 E.00867
G1 X90.359 Y102.482 E.00809
G1 X90.105 Y102.815 E.00887
G1 X89.673 Y103.231 E.01271
G1 X89.182 Y103.561 E.01251
G1 X88.812 Y103.737 E.00868
G1 X88.292 Y103.897 E.0115
G1 X87.847 Y103.967 E.00954
G1 X87.253 Y103.968 E.01257
G1 X86.66 Y103.861 E.01275
G1 X86.28 Y103.733 E.0085
G1 X85.918 Y103.561 E.00848
G1 X85.58 Y103.347 E.00848
G1 X85.269 Y103.095 E.00847
G1 X84.99 Y102.807 E.00848
G1 X84.747 Y102.489 E.00847
G1 X84.543 Y102.144 E.00847
G1 X84.379 Y101.772 E.00861
G1 X84.307 Y101.552 E.00491
G1 X84.224 Y101.2 E.00766
G1 X84.176 Y100.801 E.00851
G1 X84.168 Y95.783 E.10621
G1 X81.479 Y95.778 E.05691
G1 X81.223 Y95.741 E.00548
G1 X80.931 Y95.634 E.00659
G1 X80.792 Y95.554 E.0034
G1 X80.546 Y95.348 E.00678
G1 X80.449 Y95.232 E.0032
G1 X80.314 Y95.012 E.00546
G1 X80.208 Y94.719 E.00659
G1 X80.169 Y94.383 E.00717
G1 X80.169 Y77.419 E.35905
G1 X80.206 Y77.092 E.00697
G1 X80.285 Y76.854 E.0053
G1 X80.392 Y76.653 E.0048
G1 X80.49 Y76.519 E.00351
G1 X80.67 Y76.339 E.00541
G1 X80.785 Y76.254 E.00302
G1 X81.01 Y76.132 E.00541
G1 X81.166 Y76.077 E.00351
G1 X81.398 Y76.03 E.00499
G1 X93.608 Y76.023 E.25843
G1 X93.792 Y76.043 E.00393
G1 X94.097 Y76.134 E.00672
G1 X94.233 Y76.203 E.00323
G1 X94.427 Y76.337 E.00499
G1 X94.657 Y76.577 E.00703
G1 X94.948 Y77.02 E.01123
G1 X97.231 Y77.02 E.04831
G1 X97.231 Y87.52 E.22224
G1 X98.231 Y87.52 E.02117
G1 X98.231 Y87.844 E.00686
G1 X97.05 Y89.025 E.03534
G1 X95.912 Y87.887 E.03407
; WIPE_START
M204 S6000
G1 X95.869 Y87.52 E-.07014
G1 X96.869 Y87.52 E-.19
G1 X96.869 Y86.889 E-.11986
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X94.84 Y91.091 Z5.16 F18000
G1 Z4.76
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X94.84 Y93.088 E.03928
G1 X97.05 Y95.298 E.06147
G1 X99.26 Y93.088 E.06147
G1 X99.26 Y91.091 E.03928
G1 X98.26 Y91.091 E.01967
G1 X98.26 Y89.811 E.02518
G1 X100.24 Y89.811 E.03895
G1 X100.24 Y96.191 E.12549
G1 X91.34 Y96.191 E.17505
G1 X91.34 Y100.594 E.08661
G1 X91.313 Y101.049 E.00896
G1 X91.234 Y101.491 E.00883
G1 X91.102 Y101.92 E.00883
G1 X90.92 Y102.334 E.00889
G1 X90.813 Y102.528 E.00436
G1 X90.695 Y102.715 E.00435
G1 X90.419 Y103.077 E.00895
G1 X90.271 Y103.238 E.0043
G1 X89.935 Y103.546 E.00896
G1 X89.762 Y103.678 E.0043
G1 X89.38 Y103.92 E.00889
G1 X88.971 Y104.114 E.0089
G1 X88.766 Y104.19 E.0043
G1 X88.379 Y104.297 E.0079
G1 X87.885 Y104.376 E.00983
G1 X87.435 Y104.389 E.00887
G1 X87.215 Y104.376 E.00433
G1 X86.944 Y104.341 E.00536
G1 X86.551 Y104.257 E.0079
G1 X86.126 Y104.113 E.00884
G1 X85.72 Y103.92 E.00883
G1 X85.341 Y103.68 E.00883
G1 X84.992 Y103.397 E.00883
G1 X84.679 Y103.075 E.00883
G1 X84.407 Y102.718 E.00883
G1 X84.179 Y102.331 E.00883
G1 X83.997 Y101.919 E.00887
G1 X83.913 Y101.663 E.00529
G1 X83.82 Y101.272 E.00791
G1 X83.767 Y100.825 E.00884
G1 X83.76 Y96.191 E.09115
G1 X81.449 Y96.188 E.04545
G1 X81.134 Y96.141 E.00626
G1 X80.938 Y96.083 E.00403
G1 X80.747 Y96 E.00409
G1 X80.567 Y95.896 E.00409
G1 X80.4 Y95.772 E.00409
G1 X80.248 Y95.629 E.0041
G1 X80.116 Y95.472 E.00403
G1 X79.95 Y95.201 E.00625
G1 X79.868 Y95.013 E.00403
G1 X79.809 Y94.814 E.00409
G1 X79.772 Y94.609 E.0041
G1 X79.76 Y94.395 E.00422
G1 X79.76 Y77.407 E.33413
G1 X79.772 Y77.193 E.00422
G1 X79.808 Y76.991 E.00403
G1 X79.907 Y76.692 E.0062
G1 X80.044 Y76.435 E.00572
G1 X80.178 Y76.252 E.00446
G1 X80.402 Y76.028 E.00624
G1 X80.564 Y75.907 E.00398
G1 X80.843 Y75.757 E.00624
G1 X81.057 Y75.681 E.00446
G1 X81.345 Y75.623 E.00578
G1 X81.556 Y75.611 E.00416
G1 X93.63 Y75.614 E.23747
G1 X93.862 Y75.639 E.00459
G1 X94.063 Y75.686 E.00407
G1 X94.259 Y75.758 E.00409
G1 X94.443 Y75.85 E.00404
G1 X94.684 Y76.017 E.00578
G1 X94.852 Y76.174 E.00452
G1 X94.986 Y76.332 E.00407
G1 X95.169 Y76.611 E.00656
G1 X97.64 Y76.611 E.04861
G1 X97.64 Y87.111 E.20653
G1 X98.64 Y87.111 E.01967
G1 X98.64 Y88.014 E.01776
G1 X97.05 Y89.604 E.04423
G1 X95.46 Y88.014 E.04423
G1 X95.46 Y87.111 E.01776
G1 X96.46 Y87.111 E.01967
G1 X96.46 Y77.791 E.18332
G1 X94.16 Y77.791 E.04524
G1 X94.159 Y77.356 E.00855
G1 X94.125 Y77.192 E.0033
G1 X94.041 Y77.035 E.00349
G1 X93.916 Y76.91 E.00349
G1 X93.759 Y76.826 E.0035
G1 X93.595 Y76.792 E.00331
G1 X81.532 Y76.791 E.23727
G1 X81.34 Y76.825 E.00382
G1 X81.156 Y76.931 E.00419
G1 X81.021 Y77.092 E.00413
G1 X80.951 Y77.268 E.00374
G1 X80.94 Y94.425 E.33746
G1 X80.997 Y94.666 E.00486
G1 X81.088 Y94.801 E.00321
G1 X81.214 Y94.913 E.00332
G1 X81.374 Y94.987 E.00348
G1 X81.535 Y95.011 E.00319
G1 X93.86 Y95.001 E.24243
G1 X93.86 Y89.811 E.10209
G1 X95.84 Y89.811 E.03895
G1 X95.84 Y91.091 E.02518
G1 X94.9 Y91.091 E.01849
; WIPE_START
M204 S6000
G1 X94.84 Y93.088 E-.3796
G1 X94.842 Y93.089 E-.0004
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




G1 X94.35 Y92.887
G1 Z4.76
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.596522
G1 F1500
M204 S6000
G1 X94.35 Y90.886 E.05697
; WIPE_START
G1 X94.35 Y92.886 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X95.077 Y94.958 Z5.16 F18000
G1 Z4.76
G1 E.4 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.365752
G1 F1500
M204 S6000
G1 X95.013 Y94.995 E.00125
G1 X95.062 Y95.023 E.00095
; WIPE_START
G1 X95.013 Y94.995 E-.16436
G1 X95.077 Y94.958 E-.21564
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X99.065 Y94.958 Z5.16 F18000
G1 Z4.76
G1 E.4 F1800
G1 F1500
M204 S6000
G1 X99.002 Y94.995 E.00125
G1 X99.05 Y95.023 E.00095
; WIPE_START
G1 X99.002 Y94.995 E-.16436
G1 X99.065 Y94.958 E-.21564
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X99.75 Y92.887 Z5.16 F18000
G1 Z4.76
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.596522
G1 F1500
M204 S6000
G1 X99.75 Y90.886 E.05697
; WIPE_START
G1 X99.75 Y92.886 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X93.176 Y96.764 Z5.16 F18000
G1 X90.116 Y98.569 Z5.16
G1 Z4.76
G1 E.4 F1800
; LINE_WIDTH: 0.0948049
G1 F1500
M204 S6000
G1 X90.253 Y98.714 E.00069
G1 X90.275 Y98.776 E.00023
M204 S10000
G1 X90.448 Y99.514 F18000
; LINE_WIDTH: 0.470774
G1 F1500
M204 S6000
G1 X90.507 Y99.88 E.00824
; LINE_WIDTH: 0.429959
G1 X90.525 Y100.072 E.00388
; LINE_WIDTH: 0.398689
G1 X90.539 Y100.233 E.00301
; LINE_WIDTH: 0.36129
G1 X90.55 Y100.603 E.00621
G1 X90.525 Y100.955 E.00591
G1 X90.462 Y101.305 E.00594
G1 X90.363 Y101.646 E.00595
G1 X90.109 Y102.163 E.00965
G1 X89.815 Y102.565 E.00834
G1 X89.429 Y102.934 E.00894
G1 X89.286 Y103.042 E.00299
G1 X88.812 Y103.32 E.00919
G1 X88.485 Y103.446 E.00588
G1 X88.209 Y103.525 E.00479
G1 X87.811 Y103.585 E.00673
G1 X87.58 Y103.599 E.00388
G1 X87.044 Y103.557 E.009
G1 X86.762 Y103.491 E.00485
G1 X86.424 Y103.378 E.00597
G1 X86.074 Y103.212 E.00648
G1 X85.802 Y103.037 E.00541
G1 X85.526 Y102.813 E.00595
G1 X85.282 Y102.556 E.00595
G1 X85.108 Y102.34 E.00464
G1 X84.936 Y102.067 E.00539
G1 X84.738 Y101.64 E.00789
G1 X84.615 Y101.21 E.00748
G1 X84.557 Y100.778 E.0073
G1 X84.572 Y100.146 E.01058
; LINE_WIDTH: 0.408568
G1 X84.585 Y99.97 E.00337
; LINE_WIDTH: 0.441565
G1 X84.621 Y99.725 E.00514
; LINE_WIDTH: 0.474134
G1 X84.653 Y99.51 E.00487
M204 S10000
G1 X84.828 Y98.783 F18000
; LINE_WIDTH: 0.0867602
G1 F1500
M204 S6000
G1 X84.843 Y98.737 E.00015
G1 X84.924 Y98.647 E.00037
; WIPE_START
G1 X84.843 Y98.737 E-.27094
G1 X84.828 Y98.783 E-.10906
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X86.71 Y96.742 Z5.16 F18000
M73 P84 R4
G1 Z4.76
G1 E.4 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.595867
G1 F1500
M204 S6000
G1 X87.023 Y96.721 E.00893
; LINE_WIDTH: 0.563035
G1 X87.336 Y96.701 E.00841
G1 X88.192 Y96.728 E.02295
; WIPE_START
G1 X87.336 Y96.701 E-.27805
G1 X87.023 Y96.721 E-.10195
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X86.71 Y96.742 Z5.16 F18000
G1 Z4.76
G1 E.4 F1800
; LINE_WIDTH: 0.597387
G1 F1500
M204 S6000
G1 X86.481 Y96.723 E.00655
; LINE_WIDTH: 0.560537
G1 X86.252 Y96.705 E.00612
; LINE_WIDTH: 0.507318
G1 X86.023 Y96.687 E.00552
G1 X85.44 Y96.687 E.01401
G1 X85.441 Y97.332 E.01549
G1 X85.968 Y97.044 E.01443
; LINE_WIDTH: 0.526145
G1 X86.294 Y96.911 E.00879
; LINE_WIDTH: 0.56791
G1 X86.62 Y96.778 E.00953
; LINE_WIDTH: 0.602302
G1 X86.654 Y96.764 E.00104
; WIPE_START
G1 X86.62 Y96.778 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X89.659 Y96.685 Z5.16 F18000
G1 Z4.76
G1 E.4 F1800
; LINE_WIDTH: 0.507662
G1 F1500
M204 S6000
G1 X88.963 Y96.686 E.01674
; LINE_WIDTH: 0.521822
G1 X88.678 Y96.7 E.00707
; LINE_WIDTH: 0.550142
G1 X88.392 Y96.715 E.00747
; LINE_WIDTH: 0.579757
G1 X88.252 Y96.73 E.00391
; LINE_WIDTH: 0.573325
G1 X88.588 Y96.844 E.0097
; LINE_WIDTH: 0.512139
G1 X88.924 Y96.957 E.00861
G1 X89.659 Y97.31 E.01978
G1 X89.659 Y96.745 E.01371
M204 S10000
G1 X90.097 Y96.247 F18000
; LINE_WIDTH: 0.419992
G1 F1500
M204 S6000
G1 X85.002 Y96.251 E.10021
G1 X85.006 Y98.172 E.03778
G1 X85.058 Y98.216 E.00135
G1 X85.643 Y97.72 E.01509
G1 X86.175 Y97.429 E.01194
G1 X86.768 Y97.233 E.01229
G1 X87.393 Y97.15 E.0124
G1 X88.214 Y97.21 E.01619
G1 X88.801 Y97.378 E.01202
G1 X89.365 Y97.661 E.0124
G1 X89.964 Y98.15 E.01521
G1 X90.044 Y98.077 E.00211
G1 X90.097 Y98.082 E.00106
G1 X90.097 Y96.307 E.03492
; CHANGE_LAYER
; Z_HEIGHT: 4.88
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F1500
G1 X90.097 Y98.082 E-.3373
G1 X90.044 Y98.077 E-.01023
G1 X89.964 Y98.15 E-.02041
G1 X89.915 Y98.109 E-.01206
; WIPE_END
G1 E-.02 F1800
; layer num/total_layer_count: 40/49
; update layer progress
M73 L40
M991 S0 P39 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z5.16 I1.04 J.632 P1  F18000
G1 X94.431 Y90.682 Z5.16
G1 Z4.88
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X94.269 Y90.682 E.00342
G1 X94.269 Y90.22 E.00977
G1 X95.431 Y90.22 E.02458
G1 X95.431 Y90.682 E.00977
G1 X94.491 Y90.682 E.0199
; WIPE_START
M204 S6000
G1 X94.269 Y90.682 E-.04209
G1 X94.269 Y90.22 E-.08769
G1 X95.431 Y90.22 E-.22069
G1 X95.431 Y90.376 E-.02952
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X98.669 Y90.22 Z5.28 F18000
G1 Z4.88
G1 E.4 F1800
G1 F1500
M204 S500
G1 X99.831 Y90.22 E.02458
G1 X99.831 Y90.682 E.00977
G1 X98.669 Y90.682 E.02458
G1 X98.669 Y90.28 E.0085
; WIPE_START
M204 S6000
G1 X99.831 Y90.22 E-.22098
G1 X99.831 Y90.682 E-.08769
G1 X99.455 Y90.682 E-.07132
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X98.638 Y94.889 Z5.28 F18000
G1 Z4.88
G1 E.4 F1800
G1 F1500
M204 S500
G1 X99.407 Y94.12 E.02301
G1 X99.407 Y95.357 E.02619
G1 X98.169 Y95.357 E.02619
G1 X98.595 Y94.931 E.01276
M204 S10000
G1 X98.338 Y94.589 F18000
G1 F1500
M204 S500
G1 X99.831 Y93.096 E.04469
G1 X99.831 Y95.782 E.05685
G1 X97.145 Y95.782 E.05685
G1 X98.295 Y94.631 E.03444
; WIPE_START
M204 S6000
G1 X99.71 Y93.217 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X96.569 Y87.944 Z5.28 F18000
G1 Z4.88
G1 E.4 F1800
G1 F1500
M204 S500
G1 X97.531 Y87.944 E.02035
G1 X97.05 Y88.425 E.01439
G1 X96.612 Y87.987 E.01312
; WIPE_START
M204 S6000
G1 X97.531 Y87.944 E-.17484
G1 X97.05 Y88.425 E-.1292
G1 X96.767 Y88.143 E-.07596
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X94.693 Y94.12 Z5.28 F18000
G1 Z4.88
G1 E.4 F1800
G1 F1500
M204 S500
G1 X95.931 Y95.357 E.03704
G1 X94.693 Y95.357 E.02619
G1 X94.693 Y94.18 E.02492
; WIPE_START
M204 S6000
G1 X95.931 Y95.357 E-.32452
G1 X95.639 Y95.357 E-.05549
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X89.312 Y98.123 Z5.28 F18000
G1 Z4.88
G1 E.4 F1800
G1 F1500
M204 S500
G1 X89.162 Y98.017 E.00389
G1 X88.667 Y97.765 E.01177
G1 X88.154 Y97.615 E.01131
G1 X87.779 Y97.564 E.00801
G1 X87.427 Y97.558 E.00746
G1 X86.875 Y97.628 E.01177
G1 X86.367 Y97.794 E.01131
G1 X86.027 Y97.964 E.00804
G1 X85.71 Y98.173 E.00805
G1 X85.316 Y98.528 E.01123
G1 X84.991 Y98.948 E.01123
G1 X84.788 Y99.312 E.00881
G1 X84.598 Y99.262 E.00416
G1 X84.593 Y95.842 E.07239
G1 X90.508 Y95.837 E.1252
G1 X90.499 Y99.257 E.07238
G1 X90.298 Y99.3 E.00435
G1 X90.058 Y98.872 E.01038
G1 X89.731 Y98.474 E.0109
G1 X89.45 Y98.221 E.008
G1 X89.361 Y98.158 E.00231
M204 S10000
G1 X89.067 Y98.47 F18000
G1 F1500
M204 S500
G1 X89.185 Y98.553 E.00305
G1 X89.424 Y98.768 E.00681
G1 X89.71 Y99.117 E.00956
G1 X89.875 Y99.393 E.00681
G1 X89.997 Y99.664 E.00628
G1 X90.129 Y100.13 E.01027
G1 X90.172 Y100.601 E.01
G1 X90.13 Y101.06 E.00975
G1 X90.054 Y101.372 E.00681
G1 X89.951 Y101.651 E.00629
G1 X89.718 Y102.076 E.01027
G1 X89.418 Y102.441 E.01
G1 X89.066 Y102.739 E.00975
G1 X88.792 Y102.908 E.00683
G1 X88.499 Y103.044 E.00683
G1 X88.057 Y103.173 E.00975
G1 X87.589 Y103.222 E.00995
G1 X87.121 Y103.187 E.00995
G1 X86.666 Y103.069 E.00995
G1 X86.248 Y102.875 E.00975
G1 X85.978 Y102.698 E.00683
G1 X85.732 Y102.489 E.00683
G1 X85.429 Y102.142 E.00975
G1 X85.188 Y101.739 E.00995
G1 X85.026 Y101.307 E.00975
G1 X84.959 Y100.991 E.00683
G1 X84.93 Y100.67 E.00683
G1 X84.958 Y100.208 E.0098
G1 X85.076 Y99.737 E.01027
G1 X85.19 Y99.463 E.00629
G1 X85.346 Y99.182 E.0068
G1 X85.628 Y98.818 E.00975
G1 X85.97 Y98.509 E.00975
G1 X86.24 Y98.332 E.00683
G1 X86.528 Y98.187 E.00683
G1 X86.969 Y98.044 E.0098
G1 X87.45 Y97.983 E.01027
G1 X87.747 Y97.988 E.00628
G1 X88.066 Y98.031 E.00681
G1 X88.51 Y98.161 E.0098
G1 X88.942 Y98.381 E.01027
G1 X89.018 Y98.435 E.00196
M204 S250
G1 X88.83 Y98.803 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X88.928 Y98.873 E.00237
G1 X89.127 Y99.052 E.00525
G1 X89.375 Y99.353 E.00767
G1 X89.512 Y99.583 E.00526
G1 X89.611 Y99.804 E.00478
G1 X89.725 Y100.205 E.0082
G1 X89.761 Y100.601 E.00781
G1 X89.726 Y100.992 E.00773
G1 X89.662 Y101.252 E.00526
G1 X89.578 Y101.48 E.00479
G1 X89.377 Y101.846 E.0082
G1 X89.125 Y102.152 E.00781
G1 X88.825 Y102.407 E.00774
G1 X88.597 Y102.547 E.00526
G1 X88.355 Y102.66 E.00526
G1 X87.977 Y102.77 E.00774
G1 X87.583 Y102.811 E.0078
G1 X87.188 Y102.782 E.00779
G1 X86.804 Y102.682 E.0078
G1 X86.447 Y102.517 E.00773
G1 X86.224 Y102.37 E.00526
G1 X86.02 Y102.197 E.00526
G1 X85.761 Y101.9 E.00774
G1 X85.558 Y101.56 E.00779
G1 X85.42 Y101.192 E.00774
G1 X85.364 Y100.93 E.00526
G1 X85.34 Y100.664 E.00526
G1 X85.364 Y100.271 E.00775
G1 X85.466 Y99.866 E.0082
G1 X85.559 Y99.641 E.00479
G1 X85.689 Y99.408 E.00525
G1 X85.929 Y99.097 E.00773
G1 X86.221 Y98.834 E.00773
G1 X86.445 Y98.687 E.00526
G1 X86.684 Y98.567 E.00526
G1 X87.059 Y98.445 E.00775
G1 X87.472 Y98.392 E.0082
G1 X87.716 Y98.397 E.00478
G1 X87.98 Y98.433 E.00526
G1 X88.358 Y98.543 E.00775
G1 X88.73 Y98.732 E.0082
G1 X88.781 Y98.769 E.00124
; WIPE_START
M204 S6000
G1 X88.928 Y98.873 E-.03426
G1 X89.127 Y99.052 E-.05075
G1 X89.375 Y99.353 E-.07413
G1 X89.512 Y99.583 E-.05077
G1 X89.611 Y99.804 E-.04619
G1 X89.725 Y100.205 E-.07921
G1 X89.746 Y100.44 E-.04468
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X93.083 Y93.575 Z5.28 F18000
G1 X95.869 Y87.844 Z5.28
G1 Z4.88
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X95.869 Y87.52 E.00686
G1 X96.869 Y87.52 E.02117
G1 X96.869 Y77.382 E.21459
G1 X94.582 Y77.382 E.0484
G1 X94.514 Y77.05 E.00717
G1 X94.373 Y76.788 E.00629
G1 X94.163 Y76.578 E.0063
G1 X93.901 Y76.437 E.00629
G1 X93.636 Y76.382 E.00571
G1 X81.496 Y76.382 E.25696
G1 X81.2 Y76.434 E.00637
G1 X80.903 Y76.603 E.00723
G1 X80.688 Y76.842 E.00681
G1 X80.542 Y77.181 E.00781
G1 X80.531 Y94.473 E.36601
G1 X80.615 Y94.829 E.00775
G1 X80.771 Y95.067 E.00601
G1 X80.986 Y95.258 E.00609
G1 X81.256 Y95.384 E.00629
G1 X81.505 Y95.42 E.00534
G1 X94.269 Y95.41 E.27016
G1 X94.269 Y93.096 E.04898
G1 X96.955 Y95.782 E.08039
G1 X90.932 Y95.782 E.12748
G1 X90.92 Y100.846 E.10719
G1 X90.877 Y101.198 E.00751
G1 X90.782 Y101.588 E.0085
G1 X90.643 Y101.963 E.00847
G1 X90.456 Y102.328 E.00867
G1 X90.105 Y102.815 E.01271
G1 X89.712 Y103.197 E.0116
G1 X89.345 Y103.465 E.00963
G1 X88.812 Y103.737 E.01265
G1 X88.288 Y103.898 E.0116
G1 X87.847 Y103.967 E.00944
G1 X87.253 Y103.968 E.01258
G1 X86.66 Y103.861 E.01275
G1 X86.28 Y103.733 E.00849
G1 X85.918 Y103.561 E.00848
G1 X85.58 Y103.347 E.00848
G1 X85.269 Y103.095 E.00847
G1 X84.99 Y102.807 E.00848
G1 X84.747 Y102.489 E.00848
G1 X84.543 Y102.144 E.00847
G1 X84.379 Y101.772 E.00861
G1 X84.309 Y101.556 E.00481
G1 X84.224 Y101.2 E.00775
G1 X84.176 Y100.801 E.00851
G1 X84.168 Y95.783 E.10621
G1 X81.479 Y95.778 E.05691
G1 X81.223 Y95.741 E.00548
G1 X80.931 Y95.634 E.00659
G1 X80.792 Y95.554 E.00339
G1 X80.546 Y95.348 E.00678
G1 X80.448 Y95.231 E.00323
G1 X80.323 Y95.029 E.00504
G1 X80.207 Y94.719 E.00699
G1 X80.169 Y94.383 E.00716
G1 X80.169 Y77.419 E.35906
G1 X80.206 Y77.092 E.00697
G1 X80.285 Y76.854 E.00531
G1 X80.393 Y76.652 E.00484
G1 X80.489 Y76.52 E.00347
G1 X80.665 Y76.344 E.00525
G1 X80.852 Y76.212 E.00484
G1 X80.998 Y76.137 E.00347
G1 X81.241 Y76.057 E.00541
G1 X81.39 Y76.03 E.00321
G1 X93.61 Y76.023 E.25864
G1 X93.792 Y76.043 E.00388
G1 X94.096 Y76.134 E.00673
G1 X94.232 Y76.202 E.00321
G1 X94.443 Y76.35 E.00547
G1 X94.657 Y76.577 E.00659
G1 X94.948 Y77.02 E.01123
G1 X97.231 Y77.02 E.04831
G1 X97.231 Y87.52 E.22224
G1 X98.231 Y87.52 E.02117
G1 X98.231 Y87.844 E.00686
G1 X97.05 Y89.025 E.03534
G1 X95.912 Y87.887 E.03407
; WIPE_START
M204 S6000
G1 X95.869 Y87.52 E-.07014
G1 X96.869 Y87.52 E-.19
G1 X96.869 Y86.889 E-.11986
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X94.84 Y91.091 Z5.28 F18000
G1 Z4.88
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X94.84 Y93.088 E.03928
G1 X97.05 Y95.298 E.06147
G1 X99.26 Y93.088 E.06147
G1 X99.26 Y91.091 E.03928
G1 X98.26 Y91.091 E.01967
G1 X98.26 Y89.811 E.02518
G1 X100.24 Y89.811 E.03895
G1 X100.24 Y96.191 E.12549
G1 X91.341 Y96.191 E.17504
G1 X91.329 Y100.871 E.09206
G1 X91.28 Y101.271 E.00792
G1 X91.174 Y101.708 E.00884
G1 X91.018 Y102.129 E.00883
G1 X90.812 Y102.531 E.00889
G1 X90.695 Y102.715 E.0043
G1 X90.419 Y103.077 E.00895
G1 X90.271 Y103.239 E.0043
G1 X89.972 Y103.514 E.00799
G1 X89.57 Y103.808 E.0098
G1 X89.382 Y103.918 E.00428
G1 X88.972 Y104.114 E.00895
G1 X88.766 Y104.19 E.00431
G1 X88.375 Y104.299 E.00799
G1 X87.885 Y104.376 E.00974
G1 X87.435 Y104.389 E.00887
G1 X87.215 Y104.376 E.00434
G1 X86.949 Y104.342 E.00527
G1 X86.551 Y104.257 E.008
G1 X86.126 Y104.113 E.00884
G1 X85.72 Y103.92 E.00883
G1 X85.341 Y103.68 E.00883
G1 X84.992 Y103.397 E.00883
G1 X84.679 Y103.075 E.00883
G1 X84.407 Y102.718 E.00883
G1 X84.179 Y102.331 E.00883
G1 X83.997 Y101.918 E.00887
G1 X83.914 Y101.667 E.0052
G1 X83.82 Y101.271 E.008
G1 X83.767 Y100.825 E.00884
G1 X83.76 Y96.191 E.09115
G1 X81.449 Y96.188 E.04545
G1 X81.134 Y96.141 E.00626
G1 X80.938 Y96.083 E.00403
G1 X80.747 Y96 E.00409
G1 X80.567 Y95.896 E.00409
G1 X80.4 Y95.772 E.00409
G1 X80.248 Y95.629 E.00409
G1 X80.116 Y95.472 E.00404
G1 X79.96 Y95.22 E.00582
G1 X79.868 Y95.012 E.00447
G1 X79.809 Y94.814 E.00408
G1 X79.772 Y94.609 E.0041
G1 X79.76 Y94.395 E.00422
G1 X79.76 Y77.407 E.33413
G1 X79.772 Y77.193 E.00421
G1 X79.808 Y76.991 E.00403
G1 X79.907 Y76.692 E.0062
G1 X80.045 Y76.433 E.00576
G1 X80.178 Y76.252 E.00441
G1 X80.4 Y76.03 E.00619
G1 X80.639 Y75.861 E.00576
G1 X80.839 Y75.759 E.00441
G1 X81.14 Y75.659 E.00624
G1 X81.342 Y75.623 E.00404
G1 X81.556 Y75.611 E.00421
G1 X93.632 Y75.614 E.23752
G1 X93.862 Y75.639 E.00454
G1 X94.063 Y75.686 E.00408
G1 X94.259 Y75.758 E.00409
G1 X94.442 Y75.85 E.00404
G1 X94.703 Y76.032 E.00625
G1 X94.852 Y76.173 E.00403
G1 X94.985 Y76.332 E.00409
G1 X95.169 Y76.611 E.00656
G1 X97.64 Y76.611 E.04861
G1 X97.64 Y87.111 E.20653
G1 X98.64 Y87.111 E.01967
G1 X98.64 Y88.014 E.01776
G1 X97.05 Y89.604 E.04423
G1 X95.46 Y88.014 E.04423
G1 X95.46 Y87.111 E.01776
G1 X96.46 Y87.111 E.01967
G1 X96.46 Y77.791 E.18332
G1 X94.16 Y77.791 E.04524
G1 X94.159 Y77.356 E.00855
G1 X94.125 Y77.191 E.0033
M73 P85 R4
G1 X94.041 Y77.035 E.00349
G1 X93.916 Y76.91 E.00349
G1 X93.759 Y76.826 E.00349
G1 X93.595 Y76.792 E.00331
G1 X81.532 Y76.791 E.23727
G1 X81.341 Y76.825 E.00381
G1 X81.163 Y76.926 E.00402
G1 X81.037 Y77.066 E.00371
G1 X80.951 Y77.265 E.00427
G1 X80.94 Y94.425 E.33752
G1 X80.997 Y94.665 E.00484
G1 X81.083 Y94.797 E.0031
G1 X81.214 Y94.912 E.00343
G1 X81.374 Y94.987 E.00349
G1 X81.535 Y95.011 E.00319
G1 X93.86 Y95.001 E.24243
G1 X93.86 Y89.811 E.10209
G1 X95.84 Y89.811 E.03895
G1 X95.84 Y91.091 E.02518
G1 X94.9 Y91.091 E.01849
; WIPE_START
M204 S6000
G1 X94.84 Y93.088 E-.3796
G1 X94.842 Y93.089 E-.0004
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




G1 X94.35 Y92.887
G1 Z4.88
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.596522
G1 F1500
M204 S6000
G1 X94.35 Y90.886 E.05697
; WIPE_START
G1 X94.35 Y92.886 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X95.077 Y94.958 Z5.28 F18000
G1 Z4.88
G1 E.4 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.365752
G1 F1500
M204 S6000
G1 X95.013 Y94.995 E.00125
G1 X95.062 Y95.023 E.00095
; WIPE_START
G1 X95.013 Y94.995 E-.16436
G1 X95.077 Y94.958 E-.21564
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X99.065 Y94.958 Z5.28 F18000
G1 Z4.88
G1 E.4 F1800
G1 F1500
M204 S6000
G1 X99.002 Y94.995 E.00125
G1 X99.05 Y95.023 E.00095
; WIPE_START
G1 X99.002 Y94.995 E-.16436
G1 X99.065 Y94.958 E-.21564
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X99.75 Y92.887 Z5.28 F18000
G1 Z4.88
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.596522
G1 F1500
M204 S6000
G1 X99.75 Y90.886 E.05697
; WIPE_START
G1 X99.75 Y92.886 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X93.176 Y96.764 Z5.28 F18000
G1 X90.116 Y98.569 Z5.28
G1 Z4.88
G1 E.4 F1800
; LINE_WIDTH: 0.0946417
G1 F1500
M204 S6000
G1 X90.247 Y98.709 E.00066
G1 X90.269 Y98.772 E.00023
M204 S10000
G1 X90.441 Y99.486 F18000
; LINE_WIDTH: 0.474377
G1 F1500
M204 S6000
G1 X90.48 Y99.762 E.00623
; LINE_WIDTH: 0.42769
G1 X90.52 Y100.037 E.00558
; LINE_WIDTH: 0.400715
G1 X90.524 Y100.075 E.0007
; LINE_WIDTH: 0.361147
G1 X90.546 Y100.586 E.00856
G1 X90.537 Y100.822 E.00394
G1 X90.503 Y101.13 E.00519
G1 X90.419 Y101.477 E.00597
G1 X90.296 Y101.808 E.00591
G1 X90.045 Y102.267 E.00876
G1 X89.708 Y102.685 E.00898
G1 X89.469 Y102.9 E.00539
G1 X89.139 Y103.143 E.00685
G1 X88.666 Y103.385 E.00889
G1 X88.144 Y103.54 E.00912
G1 X87.58 Y103.599 E.00949
G1 X87.044 Y103.557 E.009
G1 X86.762 Y103.491 E.00485
G1 X86.424 Y103.378 E.00597
G1 X86.074 Y103.212 E.00648
G1 X85.802 Y103.037 E.00541
G1 X85.526 Y102.813 E.00594
G1 X85.281 Y102.556 E.00594
G1 X85.116 Y102.351 E.00441
G1 X84.883 Y101.97 E.00748
G1 X84.74 Y101.639 E.00604
G1 X84.671 Y101.423 E.00378
G1 X84.599 Y101.13 E.00505
G1 X84.557 Y100.778 E.00594
G1 X84.567 Y100.165 E.01026
; LINE_WIDTH: 0.405265
G1 X84.596 Y99.919 E.00469
; LINE_WIDTH: 0.441437
G1 X84.622 Y99.707 E.00443
; LINE_WIDTH: 0.474951
G1 X84.648 Y99.495 E.00479
M204 S10000
G1 X84.828 Y98.783 F18000
; LINE_WIDTH: 0.0935232
G1 F1500
M204 S6000
G1 X84.85 Y98.717 E.00024
G1 X84.973 Y98.585 E.00061
; WIPE_START
G1 X84.85 Y98.717 E-.27442
G1 X84.828 Y98.783 E-.10558
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X86.709 Y96.742 Z5.28 F18000
G1 Z4.88
G1 E.4 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.595987
G1 F1500
M204 S6000
G1 X87.021 Y96.722 E.00889
; LINE_WIDTH: 0.563119
G1 X87.333 Y96.701 E.00838
G1 X88.191 Y96.728 E.02303
; WIPE_START
G1 X87.333 Y96.701 E-.27866
G1 X87.021 Y96.722 E-.10134
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X86.709 Y96.742 Z5.28 F18000
G1 Z4.88
G1 E.4 F1800
; LINE_WIDTH: 0.598152
G1 F1500
M204 S6000
G1 X86.487 Y96.724 E.00637
; LINE_WIDTH: 0.562592
G1 X86.264 Y96.706 E.00598
; LINE_WIDTH: 0.511151
G1 X86.042 Y96.689 E.0054
G1 X85.442 Y96.689 E.01452
G1 X85.443 Y97.349 E.01598
G1 X85.968 Y97.046 E.01469
; LINE_WIDTH: 0.529402
G1 X86.294 Y96.912 E.00885
; LINE_WIDTH: 0.569702
G1 X86.62 Y96.777 E.00956
; LINE_WIDTH: 0.602892
G1 X86.653 Y96.764 E.00104
; WIPE_START
G1 X86.62 Y96.777 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X89.659 Y96.685 Z5.28 F18000
G1 Z4.88
G1 E.4 F1800
; LINE_WIDTH: 0.507352
G1 F1500
M204 S6000
G1 X88.963 Y96.686 E.01672
; LINE_WIDTH: 0.521542
G1 X88.677 Y96.7 E.00706
; LINE_WIDTH: 0.549922
G1 X88.392 Y96.714 E.00747
; LINE_WIDTH: 0.579652
G1 X88.251 Y96.73 E.00392
; LINE_WIDTH: 0.573232
G1 X88.588 Y96.844 E.00969
; LINE_WIDTH: 0.511854
G1 X88.924 Y96.957 E.00861
G1 X89.657 Y97.308 E.01971
G1 X89.659 Y96.745 E.01366
M204 S10000
G1 X90.098 Y96.247 F18000
; LINE_WIDTH: 0.419992
G1 F1500
M204 S6000
G1 X85.002 Y96.251 E.10022
G1 X85.005 Y98.1 E.03638
G1 X85.115 Y98.158 E.00244
G1 X85.481 Y97.834 E.00962
G1 X86.188 Y97.426 E.01604
G1 X86.768 Y97.233 E.01202
G1 X87.39 Y97.15 E.01235
G1 X88.214 Y97.21 E.01624
G1 X88.801 Y97.378 E.01201
G1 X89.362 Y97.66 E.01235
G1 X89.965 Y98.15 E.01529
G1 X90.043 Y98.079 E.00207
G1 X90.093 Y98.083 E.00099
G1 X90.098 Y96.307 E.03495
; CHANGE_LAYER
; Z_HEIGHT: 5
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F1500
G1 X90.093 Y98.083 E-.33757
G1 X90.043 Y98.079 E-.00958
G1 X89.965 Y98.15 E-.02004
G1 X89.913 Y98.108 E-.01281
; WIPE_END
G1 E-.02 F1800
; layer num/total_layer_count: 41/49
; update layer progress
M73 L41
M991 S0 P40 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z5.28 I1.04 J.633 P1  F18000
G1 X94.431 Y90.682 Z5.28
G1 Z5
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X94.269 Y90.682 E.00342
G1 X94.269 Y90.22 E.00977
G1 X95.431 Y90.22 E.02458
G1 X95.431 Y90.682 E.00977
G1 X94.491 Y90.682 E.0199
; WIPE_START
M204 S6000
G1 X94.269 Y90.682 E-.04209
G1 X94.269 Y90.22 E-.08769
G1 X95.431 Y90.22 E-.22069
G1 X95.431 Y90.376 E-.02952
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X98.669 Y90.22 Z5.4 F18000
G1 Z5
G1 E.4 F1800
G1 F1500
M204 S500
G1 X99.831 Y90.22 E.02458
G1 X99.831 Y90.682 E.00977
G1 X98.669 Y90.682 E.02458
G1 X98.669 Y90.28 E.0085
; WIPE_START
M204 S6000
G1 X99.831 Y90.22 E-.22098
G1 X99.831 Y90.682 E-.08769
G1 X99.455 Y90.682 E-.07132
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X98.638 Y94.889 Z5.4 F18000
G1 Z5
G1 E.4 F1800
G1 F1500
M204 S500
G1 X99.407 Y94.12 E.02301
G1 X99.407 Y95.357 E.02619
G1 X98.169 Y95.357 E.02619
G1 X98.595 Y94.931 E.01276
M204 S10000
G1 X98.338 Y94.589 F18000
G1 F1500
M204 S500
G1 X99.831 Y93.096 E.04469
G1 X99.831 Y95.782 E.05685
G1 X97.145 Y95.782 E.05685
G1 X98.295 Y94.631 E.03444
; WIPE_START
M204 S6000
G1 X99.71 Y93.217 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X96.569 Y87.944 Z5.4 F18000
G1 Z5
G1 E.4 F1800
G1 F1500
M204 S500
G1 X97.531 Y87.944 E.02035
G1 X97.05 Y88.425 E.01439
G1 X96.612 Y87.987 E.01312
; WIPE_START
M204 S6000
G1 X97.531 Y87.944 E-.17484
G1 X97.05 Y88.425 E-.1292
G1 X96.767 Y88.143 E-.07596
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X94.693 Y94.12 Z5.4 F18000
G1 Z5
G1 E.4 F1800
G1 F1500
M204 S500
G1 X95.931 Y95.357 E.03704
G1 X94.693 Y95.357 E.02619
G1 X94.693 Y94.18 E.02492
; WIPE_START
M204 S6000
G1 X95.931 Y95.357 E-.32452
G1 X95.639 Y95.357 E-.05549
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X89.305 Y98.119 Z5.4 F18000
G1 Z5
G1 E.4 F1800
G1 F1500
M204 S500
G1 X89.16 Y98.016 E.00377
G1 X88.667 Y97.765 E.01171
G1 X88.154 Y97.615 E.0113
G1 X87.779 Y97.564 E.00801
G1 X87.424 Y97.558 E.00752
G1 X86.875 Y97.629 E.01171
G1 X86.349 Y97.8 E.01171
G1 X85.864 Y98.065 E.01171
G1 X85.58 Y98.279 E.00752
G1 X85.306 Y98.54 E.00801
G1 X84.991 Y98.948 E.0109
G1 X84.788 Y99.312 E.00881
G1 X84.598 Y99.262 E.00416
G1 X84.593 Y95.842 E.07239
G1 X90.508 Y95.837 E.1252
G1 X90.5 Y99.257 E.07239
G1 X90.298 Y99.3 E.00436
G1 X90.072 Y98.894 E.00983
G1 X89.734 Y98.477 E.01137
G1 X89.45 Y98.221 E.00809
G1 X89.354 Y98.153 E.00248
M204 S10000
G1 X89.06 Y98.465 F18000
G1 F1500
M204 S500
G1 X89.184 Y98.553 E.00322
G1 X89.425 Y98.77 E.00686
G1 X89.723 Y99.137 E.01002
G1 X89.876 Y99.395 E.00634
G1 X90.007 Y99.689 E.00681
G1 X90.13 Y100.133 E.00975
G1 X90.172 Y100.601 E.00995
G1 X90.13 Y101.06 E.00975
G1 X90.054 Y101.372 E.00681
G1 X89.95 Y101.653 E.00634
G1 X89.718 Y102.076 E.01021
G1 X89.418 Y102.441 E.01
G1 X89.057 Y102.746 E.01
G1 X88.638 Y102.985 E.01021
G1 X88.359 Y103.093 E.00634
G1 X88.047 Y103.174 E.00681
G1 X87.589 Y103.222 E.00975
G1 X87.118 Y103.187 E.00999
G1 X86.652 Y103.063 E.01021
G1 X86.377 Y102.944 E.00634
G1 X86.098 Y102.783 E.00681
G1 X85.745 Y102.502 E.00956
G1 X85.526 Y102.265 E.00683
G1 X85.336 Y102.004 E.00683
G1 X85.124 Y101.595 E.00975
G1 X84.986 Y101.146 E.00995
G1 X84.929 Y100.679 E.00995
G1 X84.958 Y100.208 E.00999
G1 X85.075 Y99.74 E.01021
G1 X85.19 Y99.463 E.00634
M73 P85 R3
G1 X85.346 Y99.182 E.00681
G1 X85.623 Y98.825 E.00956
G1 X85.855 Y98.603 E.00681
G1 X86.094 Y98.422 E.00634
G1 X86.518 Y98.191 E.01021
G1 X86.968 Y98.044 E.01003
G1 X87.447 Y97.983 E.01022
G1 X87.747 Y97.988 E.00634
G1 X88.066 Y98.031 E.00681
G1 X88.51 Y98.161 E.00979
G1 X88.94 Y98.38 E.01022
G1 X89.011 Y98.43 E.00185
M204 S250
G1 X88.824 Y98.799 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X88.928 Y98.873 E.00253
G1 X89.127 Y99.052 E.00527
G1 X89.387 Y99.372 E.00809
G1 X89.512 Y99.583 E.00483
G1 X89.621 Y99.827 E.00525
G1 X89.725 Y100.206 E.00774
G1 X89.761 Y100.601 E.00779
G1 X89.726 Y100.992 E.00773
G1 X89.662 Y101.252 E.00526
G1 X89.577 Y101.482 E.00483
G1 X89.377 Y101.846 E.00815
G1 X89.125 Y102.152 E.00781
G1 X88.822 Y102.409 E.00781
G1 X88.462 Y102.614 E.00815
G1 X88.233 Y102.703 E.00483
G1 X87.974 Y102.77 E.00525
G1 X87.583 Y102.811 E.00774
G1 X87.187 Y102.782 E.00781
G1 X86.787 Y102.675 E.00815
G1 X86.561 Y102.578 E.00483
G1 X86.33 Y102.444 E.00525
G1 X86.025 Y102.201 E.00767
G1 X85.843 Y102.005 E.00526
G1 X85.685 Y101.788 E.00526
G1 X85.504 Y101.439 E.00773
G1 X85.387 Y101.06 E.0078
G1 X85.34 Y100.667 E.00779
G1 X85.364 Y100.271 E.00781
G1 X85.465 Y99.869 E.00815
G1 X85.559 Y99.642 E.00483
G1 X85.689 Y99.408 E.00525
G1 X85.927 Y99.1 E.00768
G1 X86.121 Y98.915 E.00526
G1 X86.317 Y98.767 E.00483
G1 X86.68 Y98.568 E.00815
G1 X87.059 Y98.445 E.00782
G1 X87.47 Y98.392 E.00815
G1 X87.716 Y98.397 E.00483
G1 X87.98 Y98.433 E.00526
G1 X88.358 Y98.543 E.00775
G1 X88.728 Y98.731 E.00815
G1 X88.775 Y98.764 E.00113
; WIPE_START
M204 S6000
G1 X88.928 Y98.873 E-.0358
G1 X89.127 Y99.052 E-.0509
G1 X89.387 Y99.372 E-.07815
G1 X89.512 Y99.583 E-.04669
G1 X89.621 Y99.827 E-.05076
G1 X89.725 Y100.206 E-.07473
G1 X89.746 Y100.431 E-.04296
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X93.085 Y93.568 Z5.4 F18000
G1 X95.869 Y87.844 Z5.4
G1 Z5
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
M73 P86 R3
G1 X95.869 Y87.52 E.00686
G1 X96.869 Y87.52 E.02117
G1 X96.869 Y77.382 E.21459
G1 X94.582 Y77.382 E.0484
G1 X94.514 Y77.05 E.00717
G1 X94.373 Y76.788 E.00629
G1 X94.163 Y76.578 E.00629
G1 X93.901 Y76.437 E.0063
G1 X93.636 Y76.382 E.00571
G1 X81.496 Y76.382 E.25696
G1 X81.2 Y76.434 E.00637
G1 X80.903 Y76.604 E.00724
G1 X80.688 Y76.842 E.0068
G1 X80.542 Y77.181 E.0078
G1 X80.531 Y94.473 E.36601
G1 X80.617 Y94.839 E.00795
G1 X80.799 Y95.097 E.00668
G1 X80.995 Y95.262 E.00542
G1 X81.256 Y95.384 E.0061
G1 X81.505 Y95.42 E.00533
G1 X94.269 Y95.41 E.27016
G1 X94.269 Y93.096 E.04898
G1 X96.955 Y95.782 E.08039
G1 X90.932 Y95.782 E.12748
G1 X90.92 Y100.841 E.10709
G1 X90.877 Y101.198 E.00761
G1 X90.782 Y101.588 E.0085
G1 X90.643 Y101.963 E.00848
G1 X90.456 Y102.328 E.00867
G1 X90.105 Y102.815 E.01271
G1 X89.709 Y103.2 E.01169
G1 X89.347 Y103.464 E.00948
G1 X88.813 Y103.736 E.0127
G1 X88.284 Y103.899 E.01171
G1 X87.839 Y103.969 E.00954
G1 X87.659 Y103.979 E.0038
G1 X87.244 Y103.967 E.0088
G1 X86.66 Y103.861 E.01256
G1 X86.28 Y103.733 E.00849
G1 X85.918 Y103.561 E.00848
G1 X85.58 Y103.347 E.00848
G1 X85.269 Y103.094 E.00848
G1 X84.99 Y102.807 E.00847
G1 X84.747 Y102.489 E.00847
G1 X84.543 Y102.144 E.00848
G1 X84.383 Y101.78 E.00843
G1 X84.257 Y101.357 E.00934
G1 X84.176 Y100.81 E.0117
G1 X84.168 Y95.783 E.1064
G1 X81.479 Y95.778 E.05691
G1 X81.223 Y95.741 E.00548
G1 X80.931 Y95.634 E.00659
G1 X80.792 Y95.554 E.0034
G1 X80.67 Y95.463 E.00323
G1 X80.499 Y95.293 E.00509
G1 X80.317 Y95.02 E.00695
G1 X80.207 Y94.719 E.00678
G1 X80.169 Y94.383 E.00716
G1 X80.169 Y77.419 E.35906
G1 X80.207 Y77.085 E.00712
G1 X80.257 Y76.922 E.00361
G1 X80.356 Y76.713 E.00489
G1 X80.495 Y76.514 E.00513
G1 X80.657 Y76.35 E.00489
G1 X80.786 Y76.253 E.00342
G1 X81.012 Y76.131 E.00542
G1 X81.146 Y76.082 E.00301
G1 X81.399 Y76.03 E.00547
G1 X93.612 Y76.023 E.2585
G1 X93.946 Y76.079 E.00717
G1 X94.096 Y76.134 E.0034
G1 X94.374 Y76.294 E.00678
G1 X94.491 Y76.392 E.00323
G1 X94.651 Y76.571 E.00508
G1 X94.951 Y77.02 E.01143
G1 X97.231 Y77.02 E.04825
G1 X97.231 Y87.52 E.22224
G1 X98.231 Y87.52 E.02117
G1 X98.231 Y87.844 E.00686
G1 X97.05 Y89.025 E.03534
G1 X95.912 Y87.887 E.03407
; WIPE_START
M204 S6000
G1 X95.869 Y87.52 E-.07014
G1 X96.869 Y87.52 E-.19
G1 X96.869 Y86.889 E-.11986
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X94.84 Y91.091 Z5.4 F18000
G1 Z5
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X94.84 Y93.088 E.03928
G1 X97.05 Y95.298 E.06147
G1 X99.26 Y93.088 E.06147
G1 X99.26 Y91.091 E.03928
G1 X98.26 Y91.091 E.01967
G1 X98.26 Y89.811 E.02518
G1 X100.24 Y89.811 E.03895
G1 X100.24 Y96.191 E.12549
G1 X91.341 Y96.191 E.17505
G1 X91.329 Y100.866 E.09197
G1 X91.28 Y101.271 E.00801
G1 X91.174 Y101.708 E.00884
G1 X91.018 Y102.129 E.00883
G1 X90.812 Y102.531 E.00889
G1 X90.695 Y102.715 E.00429
G1 X90.419 Y103.077 E.00896
G1 X90.271 Y103.239 E.0043
G1 X89.969 Y103.517 E.00809
G1 X89.571 Y103.807 E.00969
G1 X89.346 Y103.937 E.0051
G1 X88.972 Y104.114 E.00815
G1 X88.766 Y104.19 E.00431
G1 X88.37 Y104.3 E.00808
G1 X87.883 Y104.376 E.00971
G1 X87.665 Y104.389 E.00428
G1 X87.211 Y104.375 E.00893
G1 X86.954 Y104.342 E.00511
G1 X86.551 Y104.257 E.00809
G1 X86.126 Y104.113 E.00884
G1 X85.72 Y103.92 E.00883
G1 X85.341 Y103.68 E.00883
G1 X84.992 Y103.397 E.00883
G1 X84.679 Y103.075 E.00883
G1 X84.407 Y102.718 E.00883
G1 X84.179 Y102.331 E.00883
G1 X83.998 Y101.921 E.00882
G1 X83.858 Y101.451 E.00965
G1 X83.786 Y101.046 E.00808
G1 X83.767 Y100.828 E.00431
G1 X83.76 Y96.191 E.09121
G1 X81.449 Y96.188 E.04545
G1 X81.134 Y96.141 E.00626
G1 X80.938 Y96.083 E.00403
G1 X80.747 Y96 E.00409
G1 X80.567 Y95.896 E.00409
G1 X80.402 Y95.773 E.00404
G1 X80.19 Y95.563 E.00587
G1 X80.054 Y95.384 E.00443
G1 X79.951 Y95.204 E.00408
G1 X79.868 Y95.013 E.00409
G1 X79.809 Y94.814 E.00409
G1 X79.772 Y94.609 E.00409
G1 X79.76 Y94.395 E.00422
G1 X79.76 Y77.407 E.33413
G1 X79.772 Y77.193 E.00422
G1 X79.808 Y76.989 E.00408
G1 X79.875 Y76.774 E.00443
G1 X80 Y76.507 E.00581
G1 X80.18 Y76.25 E.00615
G1 X80.388 Y76.041 E.00581
G1 X80.565 Y75.907 E.00437
G1 X80.844 Y75.757 E.00624
G1 X81.034 Y75.687 E.00397
G1 X81.345 Y75.623 E.00626
G1 X81.556 Y75.611 E.00415
G1 X93.634 Y75.614 E.23756
G1 X93.861 Y75.639 E.0045
G1 X94.063 Y75.686 E.00408
G1 X94.259 Y75.758 E.00409
G1 X94.445 Y75.851 E.0041
G1 X94.619 Y75.965 E.00409
G1 X94.776 Y76.097 E.00404
G1 X94.975 Y76.32 E.00587
G1 X95.17 Y76.611 E.00689
G1 X97.64 Y76.611 E.04859
G1 X97.64 Y87.111 E.20653
G1 X98.64 Y87.111 E.01967
G1 X98.64 Y88.014 E.01776
G1 X97.05 Y89.604 E.04423
G1 X95.46 Y88.014 E.04423
G1 X95.46 Y87.111 E.01776
G1 X96.46 Y87.111 E.01967
G1 X96.46 Y77.791 E.18332
G1 X94.16 Y77.791 E.04524
G1 X94.159 Y77.356 E.00855
G1 X94.125 Y77.192 E.0033
G1 X94.041 Y77.035 E.00349
G1 X93.916 Y76.91 E.00349
G1 X93.759 Y76.826 E.00349
G1 X93.595 Y76.792 E.00331
G1 X81.532 Y76.791 E.23727
G1 X81.341 Y76.825 E.00381
G1 X81.163 Y76.926 E.00404
G1 X81.037 Y77.066 E.0037
G1 X80.951 Y77.265 E.00426
G1 X80.94 Y94.425 E.33752
G1 X80.998 Y94.668 E.00491
G1 X81.103 Y94.818 E.00361
G1 X81.216 Y94.914 E.00291
G1 X81.375 Y94.987 E.00343
G1 X81.535 Y95.011 E.00319
G1 X93.86 Y95.001 E.24243
G1 X93.86 Y89.811 E.10209
G1 X95.84 Y89.811 E.03895
G1 X95.84 Y91.091 E.02518
G1 X94.9 Y91.091 E.01849
; WIPE_START
M204 S6000
G1 X94.84 Y93.088 E-.3796
G1 X94.842 Y93.089 E-.0004
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




G1 X94.35 Y92.887
G1 Z5
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.596522
G1 F1500
M204 S6000
G1 X94.35 Y90.886 E.05697
; WIPE_START
G1 X94.35 Y92.886 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X95.077 Y94.958 Z5.4 F18000
G1 Z5
G1 E.4 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.365752
G1 F1500
M204 S6000
G1 X95.013 Y94.995 E.00125
G1 X95.062 Y95.023 E.00095
; WIPE_START
G1 X95.013 Y94.995 E-.16436
G1 X95.077 Y94.958 E-.21564
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X99.065 Y94.958 Z5.4 F18000
G1 Z5
G1 E.4 F1800
G1 F1500
M204 S6000
G1 X99.002 Y94.995 E.00125
G1 X99.05 Y95.023 E.00095
; WIPE_START
G1 X99.002 Y94.995 E-.16436
G1 X99.065 Y94.958 E-.21564
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X99.75 Y92.887 Z5.4 F18000
G1 Z5
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.596522
G1 F1500
M204 S6000
G1 X99.75 Y90.886 E.05697
; WIPE_START
G1 X99.75 Y92.886 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X93.263 Y96.908 Z5.4 F18000
G1 X90.289 Y98.752 Z5.4
G1 Z5
G1 E.4 F1800
; LINE_WIDTH: 0.0934921
G1 F1500
M204 S6000
G1 X90.108 Y98.562 E.00089
M204 S10000
G1 X90.44 Y99.487 F18000
; LINE_WIDTH: 0.475032
G1 F1500
M204 S6000
G1 X90.48 Y99.764 E.00627
; LINE_WIDTH: 0.427949
G1 X90.521 Y100.041 E.00562
; LINE_WIDTH: 0.400775
G1 X90.524 Y100.078 E.00071
; LINE_WIDTH: 0.361052
G1 X90.546 Y100.586 E.00851
G1 X90.537 Y100.817 E.00387
G1 X90.503 Y101.13 E.00526
G1 X90.419 Y101.477 E.00597
G1 X90.296 Y101.808 E.00591
G1 X90.045 Y102.267 E.00875
G1 X89.708 Y102.685 E.00897
G1 X89.26 Y103.063 E.00981
G1 X88.667 Y103.383 E.01128
G1 X88.203 Y103.526 E.00811
G1 X87.61 Y103.6 E.01001
G1 X87.07 Y103.562 E.00904
G1 X86.762 Y103.49 E.0053
G1 X86.423 Y103.379 E.00596
G1 X86.103 Y103.226 E.00594
G1 X85.803 Y103.036 E.00594
G1 X85.497 Y102.787 E.00659
G1 X85.279 Y102.558 E.0053
G1 X85.063 Y102.276 E.00594
G1 X84.885 Y101.969 E.00594
G1 X84.741 Y101.648 E.00588
G1 X84.627 Y101.272 E.00658
G1 X84.553 Y100.705 E.00955
G1 X84.567 Y100.165 E.00905
; LINE_WIDTH: 0.405193
G1 X84.596 Y99.919 E.00469
; LINE_WIDTH: 0.441298
G1 X84.622 Y99.707 E.00443
; LINE_WIDTH: 0.47476
G1 X84.648 Y99.494 E.00479
M204 S10000
G1 X84.828 Y98.783 F18000
; LINE_WIDTH: 0.0867588
G1 F1500
M204 S6000
G1 X84.843 Y98.737 E.00015
G1 X84.924 Y98.647 E.00037
; WIPE_START
G1 X84.843 Y98.737 E-.27093
G1 X84.828 Y98.783 E-.10907
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X86.709 Y96.742 Z5.4 F18000
G1 Z5
G1 E.4 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.596102
G1 F1500
M204 S6000
G1 X87.019 Y96.722 E.00885
; LINE_WIDTH: 0.563185
G1 X87.329 Y96.701 E.00834
G1 X88.191 Y96.728 E.02312
; WIPE_START
G1 X87.329 Y96.701 E-.27929
G1 X87.019 Y96.722 E-.10071
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X86.709 Y96.742 Z5.4 F18000
G1 Z5
G1 E.4 F1800
; LINE_WIDTH: 0.597624
G1 F1500
M204 S6000
G1 X86.479 Y96.724 E.00658
; LINE_WIDTH: 0.560767
G1 X86.249 Y96.705 E.00616
; LINE_WIDTH: 0.507568
G1 X86.019 Y96.687 E.00555
G1 X85.44 Y96.687 E.01391
G1 X85.443 Y97.328 E.0154
G1 X85.96 Y97.048 E.01415
; LINE_WIDTH: 0.526365
G1 X86.29 Y96.913 E.00889
; LINE_WIDTH: 0.56813
G1 X86.619 Y96.778 E.00964
; LINE_WIDTH: 0.602532
G1 X86.653 Y96.764 E.00104
; WIPE_START
G1 X86.619 Y96.778 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X89.659 Y96.685 Z5.4 F18000
G1 Z5
G1 E.4 F1800
; LINE_WIDTH: 0.507302
G1 F1500
M204 S6000
G1 X88.962 Y96.686 E.01674
; LINE_WIDTH: 0.521482
M73 P87 R3
G1 X88.677 Y96.7 E.00706
; LINE_WIDTH: 0.549842
G1 X88.392 Y96.714 E.00746
; LINE_WIDTH: 0.579587
G1 X88.251 Y96.73 E.00392
; LINE_WIDTH: 0.57319
G1 X88.587 Y96.844 E.00969
; LINE_WIDTH: 0.511814
G1 X88.923 Y96.957 E.0086
G1 X89.657 Y97.305 E.01969
G1 X89.659 Y96.745 E.01357
M204 S10000
G1 X90.098 Y96.247 F18000
; LINE_WIDTH: 0.419992
G1 F1500
M204 S6000
G1 X85.002 Y96.251 E.10022
G1 X85.006 Y98.172 E.03778
G1 X85.058 Y98.216 E.00134
G1 X85.62 Y97.736 E.01455
G1 X86.17 Y97.431 E.01237
G1 X86.767 Y97.233 E.01238
G1 X87.387 Y97.15 E.0123
G1 X88.214 Y97.21 E.0163
G1 X88.801 Y97.378 E.012
G1 X89.359 Y97.658 E.01229
G1 X89.957 Y98.141 E.01512
G1 X90.037 Y98.068 E.00213
G1 X90.093 Y98.074 E.00112
G1 X90.098 Y96.307 E.03476
; CHANGE_LAYER
; Z_HEIGHT: 5.12
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F1500
G1 X90.093 Y98.074 E-.33578
G1 X90.037 Y98.068 E-.0108
G1 X89.957 Y98.141 E-.02054
G1 X89.904 Y98.099 E-.01288
; WIPE_END
G1 E-.02 F1800
; layer num/total_layer_count: 42/49
; update layer progress
M73 L42
M991 S0 P41 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z5.4 I1.039 J.634 P1  F18000
G1 X94.431 Y90.682 Z5.4
G1 Z5.12
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X94.269 Y90.682 E.00342
G1 X94.269 Y90.22 E.00977
G1 X95.431 Y90.22 E.02458
G1 X95.431 Y90.682 E.00977
G1 X94.491 Y90.682 E.0199
; WIPE_START
M204 S6000
G1 X94.269 Y90.682 E-.04209
G1 X94.269 Y90.22 E-.08769
G1 X95.431 Y90.22 E-.22069
G1 X95.431 Y90.376 E-.02952
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X98.669 Y90.22 Z5.52 F18000
G1 Z5.12
G1 E.4 F1800
G1 F1500
M204 S500
G1 X99.831 Y90.22 E.02458
G1 X99.831 Y90.682 E.00977
G1 X98.669 Y90.682 E.02458
G1 X98.669 Y90.28 E.0085
; WIPE_START
M204 S6000
G1 X99.831 Y90.22 E-.22098
G1 X99.831 Y90.682 E-.08769
G1 X99.455 Y90.682 E-.07132
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X98.638 Y94.889 Z5.52 F18000
G1 Z5.12
G1 E.4 F1800
G1 F1500
M204 S500
G1 X99.407 Y94.12 E.02301
G1 X99.407 Y95.357 E.02619
G1 X98.169 Y95.357 E.02619
G1 X98.595 Y94.931 E.01276
M204 S10000
G1 X98.338 Y94.589 F18000
G1 F1500
M204 S500
G1 X99.831 Y93.096 E.04469
G1 X99.831 Y95.782 E.05685
G1 X97.145 Y95.782 E.05685
G1 X98.295 Y94.631 E.03444
; WIPE_START
M204 S6000
G1 X99.71 Y93.217 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X96.569 Y87.944 Z5.52 F18000
G1 Z5.12
G1 E.4 F1800
G1 F1500
M204 S500
G1 X97.531 Y87.944 E.02035
G1 X97.05 Y88.425 E.01439
G1 X96.612 Y87.987 E.01312
; WIPE_START
M204 S6000
G1 X97.531 Y87.944 E-.17484
G1 X97.05 Y88.425 E-.1292
G1 X96.767 Y88.143 E-.07596
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X94.693 Y94.12 Z5.52 F18000
G1 Z5.12
G1 E.4 F1800
G1 F1500
M204 S500
G1 X95.931 Y95.357 E.03704
G1 X94.693 Y95.357 E.02619
G1 X94.693 Y94.18 E.02492
; WIPE_START
M204 S6000
G1 X95.931 Y95.357 E-.32452
G1 X95.639 Y95.357 E-.05549
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X89.253 Y98.08 Z5.52 F18000
G1 Z5.12
G1 E.4 F1800
G1 F1500
M204 S500
G1 X88.993 Y97.919 E.00648
G1 X88.648 Y97.759 E.00804
G1 X88.154 Y97.615 E.0109
G1 X87.779 Y97.564 E.00802
G1 X87.421 Y97.558 E.00758
G1 X86.875 Y97.629 E.01166
G1 X86.349 Y97.799 E.01169
G1 X85.866 Y98.063 E.01165
G1 X85.58 Y98.279 E.00758
G1 X85.306 Y98.54 E.00802
G1 X84.991 Y98.948 E.0109
G1 X84.788 Y99.312 E.00881
G1 X84.598 Y99.262 E.00416
G1 X84.593 Y95.842 E.07239
G1 X90.508 Y95.837 E.1252
G1 X90.5 Y99.258 E.0724
G1 X90.299 Y99.3 E.00436
G1 X90.058 Y98.872 E.0104
G1 X89.721 Y98.462 E.01123
G1 X89.316 Y98.119 E.01123
G1 X89.304 Y98.111 E.0003
M204 S10000
G1 X89.03 Y98.441 F18000
G1 F1500
M204 S500
G1 X89.066 Y98.463 E.00089
G1 X89.418 Y98.761 E.00975
G1 X89.71 Y99.117 E.00975
G1 X89.876 Y99.394 E.00683
G1 X90.007 Y99.689 E.00683
G1 X90.13 Y100.133 E.00975
G1 X90.172 Y100.601 E.00995
G1 X90.13 Y101.069 E.00995
G1 X90.007 Y101.513 E.00976
G1 X89.876 Y101.808 E.00683
G1 X89.71 Y102.085 E.00683
G1 X89.418 Y102.441 E.00975
G1 X89.058 Y102.746 E.00999
G1 X88.64 Y102.984 E.01016
G1 X88.359 Y103.093 E.00639
G1 X88.047 Y103.174 E.00682
G1 X87.589 Y103.222 E.00975
G1 X87.121 Y103.187 E.00995
G1 X86.666 Y103.069 E.00995
G1 X86.248 Y102.875 E.00975
G1 X85.978 Y102.697 E.00683
G1 X85.732 Y102.489 E.00683
G1 X85.435 Y102.149 E.00955
G1 X85.261 Y101.877 E.00683
G1 X85.121 Y101.586 E.00683
G1 X84.986 Y101.146 E.00976
G1 X84.929 Y100.679 E.00995
G1 X84.958 Y100.208 E.00999
G1 X85.074 Y99.743 E.01016
G1 X85.189 Y99.463 E.00639
G1 X85.346 Y99.182 E.00681
G1 X85.622 Y98.825 E.00955
G1 X85.855 Y98.602 E.00682
G1 X86.096 Y98.421 E.00639
G1 X86.518 Y98.191 E.01016
G1 X86.968 Y98.044 E.01002
G1 X87.445 Y97.983 E.01016
G1 X87.747 Y97.988 E.00639
G1 X88.066 Y98.031 E.00682
G1 X88.499 Y98.158 E.00955
G1 X88.792 Y98.293 E.00683
G1 X88.979 Y98.409 E.00467
M204 S250
G1 X88.815 Y98.789 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X88.825 Y98.795 E.00023
G1 X89.125 Y99.049 E.00774
G1 X89.375 Y99.353 E.00773
G1 X89.512 Y99.583 E.00526
G1 X89.621 Y99.827 E.00526
G1 X89.725 Y100.206 E.00774
G1 X89.761 Y100.601 E.00779
G1 X89.725 Y100.996 E.00779
G1 X89.621 Y101.375 E.00774
G1 X89.512 Y101.619 E.00526
G1 X89.375 Y101.849 E.00526
G1 X89.125 Y102.152 E.00773
G1 X88.822 Y102.409 E.00781
G1 X88.464 Y102.613 E.0081
G1 X88.233 Y102.703 E.00488
G1 X87.974 Y102.77 E.00526
G1 X87.583 Y102.811 E.00773
G1 X87.188 Y102.782 E.00779
G1 X86.804 Y102.682 E.0078
G1 X86.447 Y102.517 E.00773
G1 X86.224 Y102.369 E.00527
G1 X86.02 Y102.197 E.00526
G1 X85.763 Y101.903 E.00767
G1 X85.619 Y101.677 E.00526
G1 X85.503 Y101.436 E.00526
G1 X85.387 Y101.06 E.00774
G1 X85.34 Y100.667 E.00779
G1 X85.364 Y100.271 E.00781
G1 X85.464 Y99.871 E.0081
G1 X85.559 Y99.642 E.00488
G1 X85.689 Y99.408 E.00526
G1 X85.927 Y99.1 E.00767
G1 X86.121 Y98.915 E.00526
G1 X86.319 Y98.766 E.00488
G1 X86.681 Y98.568 E.00811
G1 X87.059 Y98.445 E.00782
G1 X87.467 Y98.392 E.00811
G1 X87.715 Y98.397 E.00488
G1 X87.98 Y98.433 E.00526
G1 X88.355 Y98.542 E.00767
G1 X88.597 Y98.654 E.00526
G1 X88.764 Y98.757 E.00386
; WIPE_START
M204 S6000
G1 X88.825 Y98.795 E-.01358
G1 X89.125 Y99.049 E-.07473
G1 X89.375 Y99.353 E-.0747
G1 X89.512 Y99.583 E-.05084
G1 X89.621 Y99.827 E-.05083
G1 X89.725 Y100.206 E-.07473
G1 X89.744 Y100.419 E-.04059
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X93.087 Y93.557 Z5.52 F18000
G1 X95.869 Y87.844 Z5.52
G1 Z5.12
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X95.869 Y87.52 E.00686
G1 X96.869 Y87.52 E.02117
G1 X96.869 Y77.382 E.21459
G1 X94.582 Y77.382 E.0484
G1 X94.514 Y77.05 E.00717
G1 X94.373 Y76.788 E.00629
G1 X94.163 Y76.578 E.00629
G1 X93.901 Y76.437 E.00629
G1 X93.636 Y76.382 E.00572
G1 X81.496 Y76.382 E.25696
G1 X81.207 Y76.432 E.0062
G1 X80.929 Y76.583 E.00669
G1 X80.69 Y76.836 E.00737
G1 X80.542 Y77.181 E.00795
G1 X80.531 Y94.437 E.36524
G1 X80.555 Y94.645 E.00444
G1 X80.669 Y94.934 E.00657
G1 X80.96 Y95.246 E.00902
G1 X81.256 Y95.384 E.00692
G1 X81.505 Y95.42 E.00533
G1 X94.269 Y95.41 E.27016
G1 X94.269 Y93.096 E.04898
G1 X96.955 Y95.782 E.08039
G1 X90.932 Y95.782 E.12748
G1 X90.921 Y100.837 E.10699
G1 X90.877 Y101.198 E.0077
G1 X90.782 Y101.588 E.0085
G1 X90.643 Y101.963 E.00847
G1 X90.456 Y102.328 E.00867
G1 X90.105 Y102.814 E.01271
G1 X89.673 Y103.232 E.01271
G1 X89.182 Y103.561 E.01251
G1 X88.82 Y103.733 E.00848
G1 X88.249 Y103.908 E.01265
G1 X87.653 Y103.979 E.0127
G1 X87.216 Y103.963 E.00926
G1 X86.668 Y103.864 E.01179
G1 X86.28 Y103.733 E.00867
G1 X85.918 Y103.561 E.00848
G1 X85.58 Y103.347 E.00848
G1 X85.269 Y103.095 E.00847
G1 X84.99 Y102.807 E.00847
G1 X84.747 Y102.489 E.00848
G1 X84.543 Y102.144 E.00847
G1 X84.383 Y101.78 E.00843
G1 X84.258 Y101.361 E.00924
G1 X84.176 Y100.81 E.0118
G1 X84.168 Y95.783 E.1064
G1 X81.479 Y95.778 E.05691
G1 X81.223 Y95.741 E.00548
G1 X80.931 Y95.634 E.00659
G1 X80.792 Y95.554 E.0034
G1 X80.546 Y95.348 E.00678
G1 X80.36 Y95.098 E.00659
G1 X80.251 Y94.864 E.00547
G1 X80.207 Y94.719 E.00321
G1 X80.169 Y94.383 E.00716
G1 X80.169 Y77.419 E.35905
G1 X80.206 Y77.092 E.00697
G1 X80.284 Y76.855 E.00528
G1 X80.403 Y76.635 E.00528
G1 X80.488 Y76.521 E.00301
G1 X80.664 Y76.345 E.00528
G1 X80.868 Y76.202 E.00528
G1 X80.995 Y76.138 E.00302
G1 X81.241 Y76.057 E.00547
G1 X81.39 Y76.03 E.00321
G1 X93.614 Y76.023 E.25873
G1 X93.946 Y76.079 E.00712
G1 X94.097 Y76.134 E.0034
G1 X94.374 Y76.294 E.00678
G1 X94.601 Y76.507 E.00659
G1 X94.96 Y77.02 E.01325
G1 X97.231 Y77.02 E.04807
G1 X97.231 Y87.52 E.22224
G1 X98.231 Y87.52 E.02117
G1 X98.231 Y87.844 E.00686
G1 X97.05 Y89.025 E.03534
G1 X95.912 Y87.887 E.03407
; WIPE_START
M204 S6000
G1 X95.869 Y87.52 E-.07014
G1 X96.869 Y87.52 E-.19
G1 X96.869 Y86.889 E-.11986
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X94.84 Y91.091 Z5.52 F18000
G1 Z5.12
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X94.84 Y93.088 E.03928
G1 X97.05 Y95.298 E.06147
G1 X99.26 Y93.088 E.06147
G1 X99.26 Y91.091 E.03928
G1 X98.26 Y91.091 E.01967
G1 X98.26 Y89.811 E.02518
G1 X100.24 Y89.811 E.03895
G1 X100.24 Y96.191 E.12549
G1 X91.34 Y96.191 E.17505
G1 X91.33 Y100.862 E.09187
G1 X91.28 Y101.271 E.00811
G1 X91.174 Y101.708 E.00884
G1 X91.018 Y102.129 E.00883
G1 X90.812 Y102.531 E.00889
G1 X90.695 Y102.715 E.0043
G1 X90.419 Y103.077 E.00895
G1 X90.271 Y103.239 E.0043
G1 X89.935 Y103.546 E.00895
G1 X89.762 Y103.678 E.00429
G1 X89.38 Y103.92 E.00889
G1 X88.974 Y104.113 E.00883
G1 X88.546 Y104.257 E.00889
G1 X88.331 Y104.309 E.00434
G1 X88.077 Y104.353 E.00508
G1 X87.663 Y104.389 E.00816
G1 X87.178 Y104.371 E.00956
G1 X86.767 Y104.309 E.00818
G1 X86.554 Y104.257 E.0043
G1 X86.126 Y104.113 E.00889
G1 X85.72 Y103.92 E.00883
G1 X85.341 Y103.68 E.00883
G1 X84.992 Y103.397 E.00883
G1 X84.679 Y103.075 E.00883
G1 X84.407 Y102.718 E.00883
G1 X84.179 Y102.331 E.00883
G1 X83.998 Y101.921 E.00882
G1 X83.859 Y101.456 E.00956
G1 X83.786 Y101.046 E.00817
G1 X83.767 Y100.828 E.00431
G1 X83.76 Y96.191 E.09121
G1 X81.449 Y96.188 E.04545
G1 X81.134 Y96.141 E.00626
G1 X80.938 Y96.083 E.00403
G1 X80.747 Y96 E.0041
G1 X80.567 Y95.896 E.00409
G1 X80.4 Y95.772 E.00409
G1 X80.248 Y95.629 E.00409
G1 X80.114 Y95.47 E.0041
G1 X80.002 Y95.298 E.00403
G1 X79.867 Y95.01 E.00625
G1 X79.809 Y94.814 E.00403
G1 X79.772 Y94.609 E.00409
G1 X79.76 Y94.395 E.00422
G1 X79.76 Y77.407 E.33413
G1 X79.772 Y77.193 E.00422
G1 X79.808 Y76.991 E.00403
G1 X79.907 Y76.692 E.00619
G1 X80.057 Y76.415 E.0062
G1 X80.177 Y76.253 E.00397
G1 X80.4 Y76.03 E.00619
G1 X80.658 Y75.85 E.00619
G1 X80.838 Y75.759 E.00397
G1 X81.14 Y75.659 E.00625
G1 X81.342 Y75.623 E.00403
G1 X81.556 Y75.611 E.00422
G1 X93.636 Y75.614 E.23761
G1 X93.861 Y75.639 E.00445
G1 X94.063 Y75.686 E.00408
G1 X94.259 Y75.758 E.00409
G1 X94.445 Y75.851 E.00409
G1 X94.619 Y75.965 E.00409
G1 X94.778 Y76.099 E.00409
G1 X94.919 Y76.248 E.00403
G1 X95.173 Y76.611 E.00871
G1 X97.64 Y76.611 E.04853
G1 X97.64 Y87.111 E.20653
G1 X98.64 Y87.111 E.01967
G1 X98.64 Y88.014 E.01776
G1 X97.05 Y89.604 E.04423
G1 X95.46 Y88.014 E.04423
G1 X95.46 Y87.111 E.01776
G1 X96.46 Y87.111 E.01967
G1 X96.46 Y77.791 E.18332
G1 X94.16 Y77.791 E.04524
G1 X94.159 Y77.356 E.00855
G1 X94.125 Y77.191 E.00331
G1 X94.041 Y77.035 E.00349
G1 X93.916 Y76.91 E.00349
G1 X93.759 Y76.826 E.00349
G1 X93.595 Y76.792 E.00331
G1 X81.532 Y76.791 E.23727
G1 X81.343 Y76.824 E.00376
G1 X81.182 Y76.911 E.00362
G1 X81.038 Y77.064 E.00413
G1 X80.951 Y77.265 E.00431
G1 X80.94 Y94.413 E.33728
G1 X80.955 Y94.545 E.00261
G1 X81.021 Y94.712 E.00353
G1 X81.205 Y94.908 E.00529
G1 X81.374 Y94.987 E.00369
G1 X81.535 Y95.011 E.00319
G1 X93.86 Y95.001 E.24243
G1 X93.86 Y89.811 E.10209
G1 X95.84 Y89.811 E.03895
G1 X95.84 Y91.091 E.02518
G1 X94.9 Y91.091 E.01849
; WIPE_START
M204 S6000
G1 X94.84 Y93.088 E-.3796
G1 X94.842 Y93.089 E-.0004
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




G1 X94.35 Y92.887
G1 Z5.12
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.596522
G1 F1500
M204 S6000
G1 X94.35 Y90.886 E.05697
; WIPE_START
M73 P88 R3
G1 X94.35 Y92.886 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X95.077 Y94.958 Z5.52 F18000
G1 Z5.12
G1 E.4 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.365752
G1 F1500
M204 S6000
G1 X95.013 Y94.995 E.00125
G1 X95.062 Y95.023 E.00095
; WIPE_START
G1 X95.013 Y94.995 E-.16436
G1 X95.077 Y94.958 E-.21564
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X99.065 Y94.958 Z5.52 F18000
G1 Z5.12
G1 E.4 F1800
G1 F1500
M204 S6000
G1 X99.002 Y94.995 E.00125
G1 X99.05 Y95.023 E.00095
; WIPE_START
G1 X99.002 Y94.995 E-.16436
G1 X99.065 Y94.958 E-.21564
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X99.75 Y92.887 Z5.52 F18000
G1 Z5.12
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.596522
G1 F1500
M204 S6000
G1 X99.75 Y90.886 E.05697
; WIPE_START
G1 X99.75 Y92.886 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X93.259 Y96.901 Z5.52 F18000
G1 X90.289 Y98.739 Z5.52
G1 Z5.12
G1 E.4 F1800
; LINE_WIDTH: 0.101914
G1 F1500
M204 S6000
G1 X90.066 Y98.508 E.00122
; WIPE_START
G1 X90.289 Y98.739 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X90.441 Y99.487 Z5.52 F18000
G1 Z5.12
G1 E.4 F1800
; LINE_WIDTH: 0.475168
G1 F1500
M204 S6000
G1 X90.481 Y99.764 E.00627
; LINE_WIDTH: 0.42822
G1 X90.521 Y100.041 E.00561
; LINE_WIDTH: 0.401109
G1 X90.524 Y100.078 E.00071
; LINE_WIDTH: 0.360745
G1 X90.547 Y100.586 E.0085
G1 X90.537 Y100.813 E.00379
G1 X90.504 Y101.13 E.00534
G1 X90.415 Y101.476 E.00596
G1 X90.294 Y101.807 E.00589
G1 X90.044 Y102.267 E.00874
G1 X89.711 Y102.682 E.0089
G1 X89.287 Y103.047 E.00935
G1 X88.792 Y103.329 E.00952
G1 X88.483 Y103.446 E.00552
G1 X88.171 Y103.535 E.00543
G1 X87.61 Y103.6 E.00944
G1 X87.044 Y103.556 E.00948
G1 X86.422 Y103.377 E.01083
G1 X86.074 Y103.212 E.00643
G1 X85.802 Y103.037 E.0054
G1 X85.526 Y102.813 E.00594
G1 X85.281 Y102.556 E.00593
G1 X85.064 Y102.276 E.00594
G1 X84.883 Y101.97 E.00593
G1 X84.741 Y101.648 E.00588
G1 X84.628 Y101.276 E.0065
G1 X84.553 Y100.705 E.00962
G1 X84.567 Y100.165 E.00903
; LINE_WIDTH: 0.405125
G1 X84.596 Y99.919 E.00469
; LINE_WIDTH: 0.441166
G1 X84.622 Y99.707 E.00443
; LINE_WIDTH: 0.474581
G1 X84.648 Y99.494 E.00479
M204 S10000
G1 X84.828 Y98.783 F18000
; LINE_WIDTH: 0.086756
G1 F1500
M204 S6000
G1 X84.843 Y98.737 E.00015
G1 X84.924 Y98.647 E.00037
; WIPE_START
G1 X84.843 Y98.737 E-.2709
G1 X84.828 Y98.783 E-.1091
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X86.708 Y96.742 Z5.52 F18000
G1 Z5.12
G1 E.4 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.596262
G1 F1500
M204 S6000
G1 X87.017 Y96.722 E.00881
; LINE_WIDTH: 0.56327
G1 X87.326 Y96.701 E.0083
G1 X88.191 Y96.728 E.02322
; WIPE_START
G1 X87.326 Y96.701 E-.27996
G1 X87.017 Y96.722 E-.10004
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X86.708 Y96.742 Z5.52 F18000
G1 Z5.12
G1 E.4 F1800
; LINE_WIDTH: 0.597771
G1 F1500
M204 S6000
G1 X86.479 Y96.724 E.00657
; LINE_WIDTH: 0.560847
G1 X86.249 Y96.705 E.00615
; LINE_WIDTH: 0.507555
G1 X86.019 Y96.687 E.00554
G1 X85.44 Y96.687 E.01392
G1 X85.445 Y97.324 E.01531
G1 X85.961 Y97.047 E.01409
; LINE_WIDTH: 0.526385
G1 X86.29 Y96.913 E.00888
; LINE_WIDTH: 0.56823
G1 X86.619 Y96.778 E.00962
; LINE_WIDTH: 0.602692
G1 X86.653 Y96.764 E.00104
; WIPE_START
G1 X86.619 Y96.778 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X89.656 Y96.688 Z5.52 F18000
G1 Z5.12
G1 E.4 F1800
; LINE_WIDTH: 0.512292
G1 F1500
M204 S6000
G1 X88.939 Y96.688 E.01741
; LINE_WIDTH: 0.525655
G1 X88.666 Y96.702 E.00683
; LINE_WIDTH: 0.55238
G1 X88.392 Y96.715 E.00719
; LINE_WIDTH: 0.580447
G1 X88.251 Y96.73 E.00393
; LINE_WIDTH: 0.574437
G1 X88.576 Y96.839 E.0094
; LINE_WIDTH: 0.516285
G1 X88.902 Y96.948 E.0084
G1 X89.655 Y97.338 E.02074
G1 X89.656 Y96.748 E.01444
M204 S10000
G1 X90.098 Y96.247 F18000
; LINE_WIDTH: 0.419992
G1 F1500
M204 S6000
G1 X85.002 Y96.251 E.10021
G1 X85.006 Y98.172 E.03779
G1 X85.057 Y98.216 E.00134
G1 X85.623 Y97.734 E.01461
G1 X86.171 Y97.431 E.01232
G1 X86.767 Y97.233 E.01236
G1 X87.384 Y97.15 E.01224
G1 X88.214 Y97.21 E.01637
G1 X88.778 Y97.371 E.01155
G1 X89.535 Y97.773 E.01684
G1 X89.906 Y98.093 E.00964
G1 X90.004 Y98.005 E.0026
G1 X90.094 Y98.016 E.00177
G1 X90.097 Y96.307 E.03362
; CHANGE_LAYER
; Z_HEIGHT: 5.24
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F1500
G1 X90.094 Y98.016 E-.32474
G1 X90.004 Y98.005 E-.01708
G1 X89.906 Y98.093 E-.02509
G1 X89.854 Y98.048 E-.01309
; WIPE_END
G1 E-.02 F1800
; layer num/total_layer_count: 43/49
; update layer progress
M73 L43
M991 S0 P42 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z5.52 I1.034 J.642 P1  F18000
G1 X94.431 Y90.682 Z5.52
G1 Z5.24
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X94.269 Y90.682 E.00342
G1 X94.269 Y90.22 E.00977
G1 X95.431 Y90.22 E.02458
G1 X95.431 Y90.682 E.00977
G1 X94.491 Y90.682 E.0199
; WIPE_START
M204 S6000
G1 X94.269 Y90.682 E-.04209
G1 X94.269 Y90.22 E-.08769
G1 X95.431 Y90.22 E-.22069
G1 X95.431 Y90.376 E-.02952
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X98.669 Y90.22 Z5.64 F18000
G1 Z5.24
G1 E.4 F1800
G1 F1500
M204 S500
G1 X99.831 Y90.22 E.02458
G1 X99.831 Y90.682 E.00977
G1 X98.669 Y90.682 E.02458
G1 X98.669 Y90.28 E.0085
; WIPE_START
M204 S6000
G1 X99.831 Y90.22 E-.22098
G1 X99.831 Y90.682 E-.08769
G1 X99.455 Y90.682 E-.07132
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X98.638 Y94.889 Z5.64 F18000
G1 Z5.24
G1 E.4 F1800
G1 F1500
M204 S500
G1 X99.407 Y94.12 E.02301
G1 X99.407 Y95.357 E.02619
G1 X98.169 Y95.357 E.02619
G1 X98.595 Y94.931 E.01276
M204 S10000
G1 X98.338 Y94.589 F18000
G1 F1500
M204 S500
G1 X99.831 Y93.096 E.04469
G1 X99.831 Y95.782 E.05685
G1 X97.145 Y95.782 E.05685
G1 X98.295 Y94.631 E.03444
; WIPE_START
M204 S6000
G1 X99.71 Y93.217 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X96.569 Y87.944 Z5.64 F18000
G1 Z5.24
G1 E.4 F1800
G1 F1500
M204 S500
G1 X97.531 Y87.944 E.02035
G1 X97.05 Y88.425 E.01439
G1 X96.612 Y87.987 E.01312
; WIPE_START
M204 S6000
G1 X97.531 Y87.944 E-.17484
G1 X97.05 Y88.425 E-.1292
G1 X96.767 Y88.143 E-.07596
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X94.693 Y94.12 Z5.64 F18000
G1 Z5.24
G1 E.4 F1800
G1 F1500
M204 S500
G1 X95.931 Y95.357 E.03704
G1 X94.693 Y95.357 E.02619
G1 X94.693 Y94.18 E.02492
; WIPE_START
M204 S6000
G1 X95.931 Y95.357 E-.32452
G1 X95.639 Y95.357 E-.05549
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X89.287 Y98.106 Z5.64 F18000
G1 Z5.24
G1 E.4 F1800
G1 F1500
M204 S500
G1 X89.155 Y98.012 E.00342
G1 X88.666 Y97.765 E.0116
G1 X88.154 Y97.615 E.01129
G1 X87.779 Y97.564 E.00802
G1 X87.418 Y97.558 E.00764
G1 X86.874 Y97.629 E.0116
G1 X86.35 Y97.799 E.01168
G1 X85.868 Y98.062 E.0116
G1 X85.58 Y98.279 E.00764
G1 X85.318 Y98.53 E.00769
G1 X85.086 Y98.811 E.00771
G1 X84.882 Y99.131 E.00804
G1 X84.8 Y99.316 E.00428
G1 X84.598 Y99.273 E.00436
G1 X84.593 Y95.842 E.07262
G1 X90.508 Y95.837 E.1252
G1 X90.5 Y99.258 E.07241
G1 X90.299 Y99.301 E.00435
G1 X90.058 Y98.872 E.01042
G1 X89.731 Y98.474 E.0109
G1 X89.45 Y98.221 E.00801
G1 X89.336 Y98.14 E.00295
M204 S10000
G1 X89.042 Y98.452 F18000
G1 F1500
M204 S500
G1 X89.184 Y98.553 E.00369
G1 X89.424 Y98.768 E.00681
G1 X89.71 Y99.117 E.00955
G1 X89.875 Y99.393 E.00682
G1 X90 Y99.671 E.00645
G1 X90.129 Y100.131 E.01011
G1 X90.172 Y100.601 E.00998
G1 X90.13 Y101.069 E.00995
G1 X90.007 Y101.513 E.00975
G1 X89.876 Y101.808 E.00683
G1 X89.71 Y102.085 E.00683
G1 X89.418 Y102.441 E.00975
G1 X89.058 Y102.746 E.00998
G1 X88.643 Y102.982 E.01011
G1 X88.359 Y103.093 E.00645
G1 X88.047 Y103.174 E.00681
G1 X87.589 Y103.222 E.00975
G1 X87.119 Y103.187 E.00998
G1 X86.657 Y103.065 E.01011
G1 X86.377 Y102.944 E.00645
G1 X86.098 Y102.783 E.00681
G1 X85.738 Y102.496 E.00975
G1 X85.429 Y102.142 E.00995
G1 X85.188 Y101.739 E.00994
G1 X85.026 Y101.307 E.00975
G1 X84.959 Y100.991 E.00683
G1 X84.93 Y100.67 E.00683
G1 X84.958 Y100.21 E.00975
G1 X85.069 Y99.754 E.00995
G1 X85.256 Y99.333 E.00975
G1 X85.43 Y99.061 E.00683
G1 X85.629 Y98.819 E.00663
G1 X85.855 Y98.602 E.00662
G1 X86.099 Y98.419 E.00645
G1 X86.518 Y98.191 E.01011
G1 X86.968 Y98.044 E.01002
G1 X87.442 Y97.983 E.01011
G1 X87.746 Y97.988 E.00645
G1 X88.066 Y98.031 E.00682
G1 X88.509 Y98.161 E.00978
G1 X88.935 Y98.377 E.01011
G1 X88.993 Y98.417 E.00149
M204 S250
G1 X88.806 Y98.786 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X88.928 Y98.873 E.00296
G1 X89.127 Y99.052 E.00526
G1 X89.375 Y99.353 E.00767
G1 X89.512 Y99.582 E.00526
G1 X89.614 Y99.811 E.00493
G1 X89.725 Y100.206 E.00806
G1 X89.761 Y100.601 E.00781
G1 X89.725 Y100.996 E.00779
G1 X89.621 Y101.375 E.00774
G1 X89.512 Y101.619 E.00526
G1 X89.375 Y101.849 E.00526
G1 X89.125 Y102.152 E.00773
G1 X88.822 Y102.409 E.00781
G1 X88.466 Y102.612 E.00806
G1 X88.233 Y102.703 E.00493
G1 X87.974 Y102.77 E.00526
G1 X87.583 Y102.811 E.00774
G1 X87.187 Y102.782 E.00781
G1 X86.791 Y102.677 E.00806
G1 X86.561 Y102.578 E.00493
G1 X86.33 Y102.444 E.00526
G1 X86.022 Y102.199 E.00773
G1 X85.761 Y101.9 E.0078
G1 X85.558 Y101.56 E.00779
G1 X85.42 Y101.192 E.00774
G1 X85.364 Y100.93 E.00526
G1 X85.34 Y100.664 E.00526
G1 X85.364 Y100.271 E.00774
G1 X85.458 Y99.886 E.00779
G1 X85.618 Y99.527 E.00773
G1 X85.762 Y99.302 E.00526
G1 X85.93 Y99.097 E.0052
G1 X86.121 Y98.915 E.0052
G1 X86.321 Y98.764 E.00493
G1 X86.681 Y98.568 E.00806
G1 X87.058 Y98.445 E.00782
G1 X87.465 Y98.392 E.00806
G1 X87.715 Y98.397 E.00493
G1 X87.98 Y98.433 E.00526
G1 X88.358 Y98.543 E.00774
G1 X88.724 Y98.728 E.00806
G1 X88.757 Y98.751 E.00079
; WIPE_START
M204 S6000
G1 X88.928 Y98.873 E-.03997
G1 X89.127 Y99.052 E-.05078
G1 X89.375 Y99.353 E-.0741
G1 X89.512 Y99.582 E-.05079
G1 X89.614 Y99.811 E-.04762
G1 X89.725 Y100.206 E-.07785
G1 X89.744 Y100.409 E-.03889
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X93.088 Y93.549 Z5.64 F18000
G1 X95.869 Y87.844 Z5.64
G1 Z5.24
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X95.869 Y87.52 E.00686
G1 X96.869 Y87.52 E.02117
G1 X96.869 Y77.382 E.21459
G1 X94.582 Y77.382 E.0484
G1 X94.514 Y77.05 E.00716
G1 X94.373 Y76.788 E.0063
G1 X94.163 Y76.578 E.00629
G1 X93.901 Y76.437 E.00629
G1 X93.637 Y76.382 E.00571
G1 X81.497 Y76.382 E.25695
G1 X81.213 Y76.431 E.00611
G1 X80.93 Y76.581 E.00677
G1 X80.69 Y76.836 E.0074
G1 X80.542 Y77.181 E.00795
G1 X80.531 Y94.437 E.36524
G1 X80.555 Y94.645 E.00444
G1 X80.669 Y94.935 E.00659
G1 X80.96 Y95.246 E.009
G1 X81.256 Y95.384 E.00692
G1 X81.505 Y95.42 E.00533
G1 X94.269 Y95.41 E.27016
G1 X94.269 Y93.096 E.04898
G1 X96.955 Y95.782 E.08039
G1 X90.932 Y95.782 E.12748
G1 X90.921 Y100.832 E.10689
G1 X90.877 Y101.198 E.0078
G1 X90.782 Y101.588 E.00849
G1 X90.643 Y101.963 E.00848
G1 X90.46 Y102.32 E.00847
G1 X90.117 Y102.801 E.01251
G1 X89.825 Y103.101 E.00886
G1 X89.688 Y103.219 E.00382
G1 X89.328 Y103.474 E.00934
G1 X88.821 Y103.733 E.01207
G1 X88.275 Y103.901 E.01208
G1 X87.839 Y103.969 E.00934
G1 X87.659 Y103.979 E.00382
G1 X87.243 Y103.967 E.00881
G1 X86.66 Y103.861 E.01255
G1 X86.28 Y103.733 E.00849
G1 X85.918 Y103.561 E.00848
G1 X85.58 Y103.347 E.00847
G1 X85.269 Y103.094 E.00848
G1 X84.99 Y102.807 E.00848
G1 X84.747 Y102.489 E.00847
G1 X84.543 Y102.144 E.00847
G1 X84.32 Y101.597 E.01251
G1 X84.224 Y101.199 E.00867
G1 X84.176 Y100.801 E.00849
G1 X84.168 Y95.783 E.10621
G1 X81.479 Y95.778 E.05691
G1 X81.223 Y95.741 E.00548
G1 X80.931 Y95.634 E.00659
G1 X80.792 Y95.554 E.0034
G1 X80.553 Y95.354 E.00659
G1 X80.393 Y95.151 E.00547
G1 X80.317 Y95.02 E.0032
G1 X80.207 Y94.719 E.00678
G1 X80.169 Y94.383 E.00716
G1 X80.169 Y77.419 E.35906
G1 X80.206 Y77.092 E.00697
G1 X80.284 Y76.855 E.00528
G1 X80.403 Y76.635 E.00528
G1 X80.488 Y76.521 E.00301
G1 X80.67 Y76.339 E.00547
G1 X80.784 Y76.254 E.00301
G1 X81.011 Y76.132 E.00544
G1 X81.159 Y76.079 E.00333
G1 X81.398 Y76.03 E.00516
G1 X93.616 Y76.023 E.25861
G1 X93.946 Y76.079 E.00708
G1 X94.096 Y76.134 E.00339
G1 X94.366 Y76.289 E.00659
G1 X94.559 Y76.461 E.00547
G1 X94.657 Y76.577 E.0032
G1 X94.948 Y77.02 E.01123
G1 X97.231 Y77.02 E.04831
G1 X97.231 Y87.52 E.22224
G1 X98.231 Y87.52 E.02117
G1 X98.231 Y87.844 E.00686
G1 X97.05 Y89.025 E.03534
G1 X95.912 Y87.887 E.03407
; WIPE_START
M204 S6000
G1 X95.869 Y87.52 E-.07014
G1 X96.869 Y87.52 E-.19
G1 X96.869 Y86.889 E-.11986
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X94.84 Y91.091 Z5.64 F18000
G1 Z5.24
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X94.84 Y93.088 E.03928
G1 X97.05 Y95.298 E.06147
G1 X99.26 Y93.088 E.06147
G1 X99.26 Y91.091 E.03928
G1 X98.26 Y91.091 E.01967
G1 X98.26 Y89.811 E.02518
G1 X100.24 Y89.811 E.03895
G1 X100.24 Y96.191 E.12549
G1 X91.34 Y96.191 E.17505
G1 X91.33 Y100.857 E.09178
G1 X91.28 Y101.271 E.0082
G1 X91.174 Y101.708 E.00884
G1 X91.018 Y102.129 E.00883
G1 X90.813 Y102.528 E.00883
G1 X90.56 Y102.903 E.00889
G1 X90.423 Y103.073 E.0043
G1 X90.106 Y103.399 E.00895
G1 X89.941 Y103.541 E.00429
G1 X89.546 Y103.821 E.00952
G1 X89.177 Y104.024 E.00827
G1 X88.975 Y104.113 E.00436
G1 X88.766 Y104.19 E.00437
G1 X88.361 Y104.302 E.00827
G1 X87.883 Y104.376 E.00952
G1 X87.665 Y104.389 E.00428
G1 X87.211 Y104.375 E.00894
M73 P89 R3
G1 X86.963 Y104.344 E.00493
G1 X86.551 Y104.257 E.00827
G1 X86.126 Y104.113 E.00883
G1 X85.72 Y103.92 E.00883
G1 X85.341 Y103.68 E.00883
G1 X84.992 Y103.397 E.00883
G1 X84.679 Y103.075 E.00883
G1 X84.407 Y102.718 E.00883
G1 X84.179 Y102.331 E.00883
G1 X83.996 Y101.918 E.00889
G1 X83.926 Y101.711 E.00429
G1 X83.82 Y101.271 E.00889
G1 X83.767 Y100.825 E.00884
G1 X83.76 Y96.191 E.09115
G1 X81.449 Y96.188 E.04545
G1 X81.134 Y96.141 E.00626
G1 X80.938 Y96.083 E.00403
G1 X80.747 Y96 E.00409
G1 X80.567 Y95.896 E.00409
G1 X80.4 Y95.772 E.0041
G1 X80.251 Y95.631 E.00403
G1 X80.053 Y95.382 E.00626
G1 X79.951 Y95.204 E.00403
G1 X79.868 Y95.013 E.00409
G1 X79.809 Y94.813 E.0041
G1 X79.772 Y94.609 E.00409
G1 X79.76 Y94.395 E.00422
G1 X79.76 Y77.407 E.33413
G1 X79.772 Y77.193 E.00421
G1 X79.808 Y76.991 E.00403
G1 X79.907 Y76.692 E.00619
G1 X80.057 Y76.415 E.0062
G1 X80.177 Y76.253 E.00397
G1 X80.402 Y76.028 E.00625
G1 X80.564 Y75.908 E.00397
G1 X80.844 Y75.757 E.00625
G1 X81.048 Y75.684 E.00428
G1 X81.345 Y75.623 E.00595
G1 X81.556 Y75.611 E.00416
G1 X93.639 Y75.614 E.23765
G1 X93.861 Y75.639 E.00441
G1 X94.063 Y75.686 E.00408
G1 X94.259 Y75.758 E.00409
G1 X94.445 Y75.851 E.00409
G1 X94.616 Y75.964 E.00403
G1 X94.854 Y76.175 E.00626
G1 X94.986 Y76.332 E.00403
G1 X95.169 Y76.611 E.00656
G1 X97.64 Y76.611 E.04861
G1 X97.64 Y87.111 E.20653
G1 X98.64 Y87.111 E.01967
G1 X98.64 Y88.014 E.01776
G1 X97.05 Y89.604 E.04423
G1 X95.46 Y88.014 E.04423
G1 X95.46 Y87.111 E.01776
G1 X96.46 Y87.111 E.01967
G1 X96.46 Y77.791 E.18332
G1 X94.16 Y77.791 E.04524
G1 X94.159 Y77.356 E.00856
G1 X94.125 Y77.192 E.0033
G1 X94.041 Y77.035 E.00349
G1 X93.916 Y76.91 E.00349
G1 X93.759 Y76.826 E.00349
G1 X93.595 Y76.792 E.0033
G1 X81.532 Y76.791 E.23727
G1 X81.347 Y76.823 E.00369
G1 X81.182 Y76.911 E.00368
G1 X81.038 Y77.064 E.00414
G1 X80.951 Y77.265 E.00431
G1 X80.94 Y94.413 E.33728
G1 X80.955 Y94.545 E.00261
G1 X81.021 Y94.712 E.00354
G1 X81.205 Y94.908 E.00527
G1 X81.374 Y94.987 E.00369
G1 X81.535 Y95.011 E.00319
G1 X93.86 Y95.001 E.24243
G1 X93.86 Y89.811 E.10209
G1 X95.84 Y89.811 E.03895
G1 X95.84 Y91.091 E.02518
G1 X94.9 Y91.091 E.01849
; WIPE_START
M204 S6000
G1 X94.84 Y93.088 E-.3796
G1 X94.842 Y93.089 E-.0004
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




G1 X94.35 Y92.887
G1 Z5.24
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.596522
G1 F1500
M204 S6000
G1 X94.35 Y90.886 E.05697
; WIPE_START
M73 P89 R2
G1 X94.35 Y92.886 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X95.077 Y94.958 Z5.64 F18000
G1 Z5.24
G1 E.4 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.365752
G1 F1500
M204 S6000
G1 X95.013 Y94.995 E.00125
G1 X95.062 Y95.023 E.00095
; WIPE_START
G1 X95.013 Y94.995 E-.16436
G1 X95.077 Y94.958 E-.21564
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X99.065 Y94.958 Z5.64 F18000
G1 Z5.24
G1 E.4 F1800
G1 F1500
M204 S6000
G1 X99.002 Y94.995 E.00125
G1 X99.05 Y95.023 E.00095
; WIPE_START
G1 X99.002 Y94.995 E-.16436
G1 X99.065 Y94.958 E-.21564
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X99.75 Y92.887 Z5.64 F18000
G1 Z5.24
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.596522
G1 F1500
M204 S6000
G1 X99.75 Y90.886 E.05697
; WIPE_START
G1 X99.75 Y92.886 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X93.176 Y96.764 Z5.64 F18000
G1 X90.116 Y98.569 Z5.64
G1 Z5.24
G1 E.4 F1800
; LINE_WIDTH: 0.0947836
G1 F1500
M204 S6000
G1 X90.248 Y98.71 E.00066
G1 X90.27 Y98.773 E.00023
M204 S10000
G1 X90.441 Y99.488 F18000
; LINE_WIDTH: 0.47496
G1 F1500
M204 S6000
G1 X90.481 Y99.763 E.00623
; LINE_WIDTH: 0.428486
G1 X90.521 Y100.038 E.00559
; LINE_WIDTH: 0.401631
G1 X90.524 Y100.076 E.00071
; LINE_WIDTH: 0.374544
G1 X90.547 Y100.586 E.00889
; LINE_WIDTH: 0.360636
G1 X90.504 Y101.131 E.00912
G1 X90.415 Y101.476 E.00595
G1 X90.293 Y101.809 E.00593
G1 X90.132 Y102.123 E.0059
G1 X90.023 Y102.29 E.00333
G1 X89.827 Y102.548 E.00541
G1 X89.673 Y102.713 E.00377
G1 X89.447 Y102.919 E.00512
G1 X89.125 Y103.149 E.00661
G1 X88.817 Y103.32 E.00587
G1 X88.521 Y103.438 E.00533
G1 X88.103 Y103.545 E.00722
G1 X87.648 Y103.599 E.00765
G1 X87.278 Y103.584 E.00619
G1 X87.042 Y103.552 E.00397
G1 X86.545 Y103.425 E.00857
G1 X86.103 Y103.226 E.00811
G1 X85.803 Y103.036 E.00593
G1 X85.526 Y102.813 E.00594
G1 X85.133 Y102.375 E.00983
G1 X84.855 Y101.916 E.00898
G1 X84.664 Y101.4 E.00918
G1 X84.599 Y101.129 E.00466
G1 X84.557 Y100.778 E.00591
G1 X84.57 Y100.135 E.01074
; LINE_WIDTH: 0.415097
G1 X84.608 Y99.818 E.00621
; LINE_WIDTH: 0.464046
G1 X84.646 Y99.5 E.00699
; WIPE_START
G1 X84.608 Y99.818 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X86.708 Y96.742 Z5.64 F18000
G1 Z5.24
G1 E.4 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.596367
G1 F1500
M204 S6000
G1 X87.015 Y96.722 E.00876
; LINE_WIDTH: 0.563353
G1 X87.322 Y96.701 E.00826
G1 X88.191 Y96.728 E.02331
; WIPE_START
G1 X87.322 Y96.701 E-.28061
G1 X87.015 Y96.722 E-.09939
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X86.708 Y96.742 Z5.64 F18000
G1 Z5.24
G1 E.4 F1800
; LINE_WIDTH: 0.597849
G1 F1500
M204 S6000
G1 X86.478 Y96.724 E.00657
; LINE_WIDTH: 0.560882
G1 X86.249 Y96.705 E.00614
; LINE_WIDTH: 0.50751
G1 X86.02 Y96.687 E.00553
G1 X85.44 Y96.687 E.01393
G1 X85.441 Y97.332 E.01549
G1 X85.962 Y97.047 E.01427
; LINE_WIDTH: 0.526375
G1 X86.29 Y96.912 E.00886
; LINE_WIDTH: 0.56826
G1 X86.619 Y96.778 E.0096
; LINE_WIDTH: 0.602767
G1 X86.652 Y96.764 E.00104
; WIPE_START
G1 X86.619 Y96.778 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X89.659 Y96.685 Z5.64 F18000
G1 Z5.24
G1 E.4 F1800
; LINE_WIDTH: 0.507192
G1 F1500
M204 S6000
G1 X88.961 Y96.686 E.01675
; LINE_WIDTH: 0.521357
G1 X88.677 Y96.7 E.00704
; LINE_WIDTH: 0.549687
G1 X88.392 Y96.714 E.00745
; LINE_WIDTH: 0.579492
G1 X88.251 Y96.73 E.00394
; LINE_WIDTH: 0.573147
G1 X88.587 Y96.844 E.00968
; LINE_WIDTH: 0.511611
G1 X88.923 Y96.957 E.00859
G1 X89.657 Y97.33 E.01997
G1 X89.659 Y96.745 E.01418
M204 S10000
G1 X90.098 Y96.247 F18000
; LINE_WIDTH: 0.419992
G1 F1500
M204 S6000
G1 X85.002 Y96.251 E.10021
G1 X85.007 Y98.261 E.03953
G1 X85.625 Y97.732 E.016
G1 X86.171 Y97.431 E.01226
G1 X86.767 Y97.233 E.01234
G1 X87.381 Y97.15 E.01219
G1 X88.214 Y97.21 E.01643
G1 X88.8 Y97.377 E.01199
G1 X89.354 Y97.654 E.01218
G1 X89.719 Y97.913 E.00881
G1 X89.965 Y98.15 E.00672
G1 X90.043 Y98.079 E.00208
G1 X90.094 Y98.083 E.001
G1 X90.097 Y96.307 E.03494
; CHANGE_LAYER
; Z_HEIGHT: 5.36
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F1500
G1 X90.094 Y98.083 E-.33755
G1 X90.043 Y98.079 E-.00963
G1 X89.965 Y98.15 E-.02009
G1 X89.917 Y98.104 E-.01273
; WIPE_END
G1 E-.02 F1800
; layer num/total_layer_count: 44/49
; update layer progress
M73 L44
M991 S0 P43 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z5.64 I1.04 J.632 P1  F18000
G1 X94.431 Y90.682 Z5.64
G1 Z5.36
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X94.269 Y90.682 E.00342
G1 X94.269 Y90.22 E.00977
G1 X95.431 Y90.22 E.02458
G1 X95.431 Y90.682 E.00977
G1 X94.491 Y90.682 E.0199
; WIPE_START
M204 S6000
G1 X94.269 Y90.682 E-.04209
G1 X94.269 Y90.22 E-.08769
G1 X95.431 Y90.22 E-.22069
G1 X95.431 Y90.376 E-.02952
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X98.669 Y90.22 Z5.76 F18000
G1 Z5.36
G1 E.4 F1800
G1 F1500
M204 S500
G1 X99.831 Y90.22 E.02458
G1 X99.831 Y90.682 E.00977
G1 X98.669 Y90.682 E.02458
G1 X98.669 Y90.28 E.0085
; WIPE_START
M204 S6000
G1 X99.831 Y90.22 E-.22098
G1 X99.831 Y90.682 E-.08769
G1 X99.455 Y90.682 E-.07132
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X98.638 Y94.889 Z5.76 F18000
G1 Z5.36
G1 E.4 F1800
G1 F1500
M204 S500
G1 X99.407 Y94.12 E.02301
G1 X99.407 Y95.357 E.02619
G1 X98.169 Y95.357 E.02619
G1 X98.595 Y94.931 E.01276
M204 S10000
G1 X98.338 Y94.589 F18000
G1 F1500
M204 S500
G1 X99.831 Y93.096 E.04469
G1 X99.831 Y95.782 E.05685
G1 X97.145 Y95.782 E.05685
G1 X98.295 Y94.631 E.03444
; WIPE_START
M204 S6000
M73 P90 R2
G1 X99.71 Y93.217 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X96.569 Y87.944 Z5.76 F18000
G1 Z5.36
G1 E.4 F1800
G1 F1500
M204 S500
G1 X97.531 Y87.944 E.02035
G1 X97.05 Y88.425 E.01439
G1 X96.612 Y87.987 E.01312
; WIPE_START
M204 S6000
G1 X97.531 Y87.944 E-.17484
G1 X97.05 Y88.425 E-.1292
G1 X96.767 Y88.143 E-.07596
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X94.693 Y94.12 Z5.76 F18000
G1 Z5.36
G1 E.4 F1800
G1 F1500
M204 S500
G1 X95.931 Y95.357 E.03704
G1 X94.693 Y95.357 E.02619
G1 X94.693 Y94.18 E.02492
; WIPE_START
M204 S6000
G1 X95.931 Y95.357 E-.32452
G1 X95.639 Y95.357 E-.05549
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X89.28 Y98.101 Z5.76 F18000
G1 Z5.36
G1 E.4 F1800
G1 F1500
M204 S500
G1 X89.153 Y98.011 E.00331
G1 X88.666 Y97.765 E.01155
G1 X88.154 Y97.615 E.01128
G1 X87.778 Y97.564 E.00802
G1 X87.415 Y97.558 E.0077
G1 X86.874 Y97.629 E.01155
G1 X86.35 Y97.799 E.01166
G1 X85.871 Y98.06 E.01154
G1 X85.58 Y98.278 E.00769
G1 X85.306 Y98.54 E.00802
G1 X84.991 Y98.948 E.0109
G1 X84.788 Y99.312 E.00882
G1 X84.598 Y99.262 E.00416
G1 X84.593 Y95.842 E.07239
G1 X90.507 Y95.837 E.12517
G1 X90.507 Y99.279 E.07285
G1 X90.316 Y99.329 E.00417
G1 X90.068 Y98.884 E.01077
G1 X89.731 Y98.474 E.01123
G1 X89.449 Y98.221 E.00802
G1 X89.329 Y98.135 E.00312
M204 S10000
G1 X89.035 Y98.447 F18000
G1 F1500
M204 S500
G1 X89.184 Y98.553 E.00386
G1 X89.424 Y98.768 E.00682
G1 X89.716 Y99.124 E.00975
G1 X89.946 Y99.536 E.00998
G1 X90.097 Y99.986 E.01005
G1 X90.152 Y100.289 E.00651
G1 X90.171 Y100.61 E.00682
G1 X90.13 Y101.06 E.00955
G1 X90.054 Y101.373 E.00682
G1 X89.947 Y101.661 E.00651
G1 X89.717 Y102.077 E.01006
G1 X89.418 Y102.441 E.00998
G1 X89.059 Y102.745 E.00995
G1 X88.652 Y102.98 E.00995
G1 X88.218 Y103.135 E.00975
G1 X87.902 Y103.198 E.00683
G1 X87.58 Y103.222 E.00683
G1 X87.119 Y103.187 E.00978
G1 X86.66 Y103.065 E.01005
G1 X86.377 Y102.944 E.00651
G1 X86.098 Y102.783 E.00682
G1 X85.738 Y102.496 E.00975
G1 X85.435 Y102.149 E.00975
G1 X85.261 Y101.877 E.00683
G1 X85.121 Y101.586 E.00683
G1 X84.986 Y101.146 E.00975
G1 X84.929 Y100.679 E.00995
G1 X84.958 Y100.209 E.00998
G1 X85.072 Y99.748 E.01005
G1 X85.19 Y99.463 E.00651
G1 X85.346 Y99.182 E.00681
G1 X85.622 Y98.825 E.00956
G1 X85.855 Y98.602 E.00682
G1 X86.101 Y98.418 E.00651
G1 X86.518 Y98.191 E.01005
G1 X86.968 Y98.044 E.01001
G1 X87.439 Y97.983 E.01006
G1 X87.746 Y97.988 E.00651
G1 X88.066 Y98.031 E.00682
G1 X88.509 Y98.161 E.00978
G1 X88.933 Y98.375 E.01006
G1 X88.986 Y98.413 E.00137
M204 S250
G1 X88.799 Y98.782 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X88.928 Y98.873 E.00312
G1 X89.127 Y99.052 E.00526
G1 X89.377 Y99.355 E.00773
G1 X89.57 Y99.702 E.00781
G1 X89.7 Y100.088 E.00801
G1 X89.745 Y100.337 E.00498
G1 X89.761 Y100.604 E.00526
G1 X89.726 Y100.992 E.00767
G1 X89.662 Y101.252 E.00526
G1 X89.574 Y101.489 E.00498
G1 X89.377 Y101.846 E.00801
G1 X89.125 Y102.152 E.0078
G1 X88.822 Y102.409 E.0078
G1 X88.479 Y102.607 E.00779
G1 X88.109 Y102.74 E.00773
G1 X87.847 Y102.791 E.00526
G1 X87.58 Y102.811 E.00526
G1 X87.187 Y102.782 E.00774
G1 X86.794 Y102.678 E.00801
G1 X86.561 Y102.578 E.00498
G1 X86.33 Y102.444 E.00526
G1 X86.022 Y102.199 E.00773
G1 X85.763 Y101.903 E.00774
G1 X85.619 Y101.677 E.00526
G1 X85.503 Y101.436 E.00526
G1 X85.387 Y101.061 E.00773
G1 X85.34 Y100.667 E.00779
G1 X85.364 Y100.271 E.00781
G1 X85.462 Y99.876 E.00801
G1 X85.559 Y99.642 E.00498
G1 X85.689 Y99.408 E.00526
G1 X85.927 Y99.1 E.00767
G1 X86.121 Y98.915 E.00526
G1 X86.323 Y98.763 E.00498
G1 X86.681 Y98.568 E.00801
G1 X87.058 Y98.445 E.00781
G1 X87.462 Y98.392 E.00801
G1 X87.715 Y98.397 E.00498
G1 X87.98 Y98.433 E.00526
G1 X88.358 Y98.543 E.00774
G1 X88.722 Y98.727 E.00801
G1 X88.75 Y98.747 E.00068
; WIPE_START
M204 S6000
G1 X88.928 Y98.873 E-.0415
G1 X89.127 Y99.052 E-.05077
G1 X89.377 Y99.355 E-.0747
G1 X89.57 Y99.702 E-.07542
G1 X89.7 Y100.088 E-.07736
G1 X89.745 Y100.337 E-.04808
G1 X89.748 Y100.401 E-.01216
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X93.093 Y93.54 Z5.76 F18000
G1 X95.869 Y87.844 Z5.76
G1 Z5.36
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X95.869 Y87.52 E.00686
G1 X96.869 Y87.52 E.02117
G1 X96.869 Y77.382 E.21459
G1 X94.583 Y77.382 E.0484
G1 X94.514 Y77.05 E.00717
G1 X94.373 Y76.788 E.00629
G1 X94.163 Y76.578 E.0063
G1 X93.901 Y76.437 E.0063
G1 X93.637 Y76.382 E.00571
G1 X81.496 Y76.382 E.25697
G1 X81.198 Y76.434 E.00639
G1 X80.889 Y76.613 E.00756
G1 X80.665 Y76.879 E.00737
G1 X80.542 Y77.19 E.00708
G1 X80.531 Y94.473 E.36581
G1 X80.617 Y94.839 E.00795
G1 X80.799 Y95.097 E.00669
G1 X80.995 Y95.262 E.00542
G1 X81.256 Y95.384 E.0061
G1 X81.505 Y95.42 E.00533
G1 X94.269 Y95.41 E.27016
G1 X94.269 Y93.096 E.04898
G1 X96.955 Y95.782 E.08039
G1 X90.931 Y95.782 E.12751
G1 X90.931 Y100.582 E.10161
G1 X90.906 Y101.001 E.00887
G1 X90.834 Y101.402 E.00863
G1 X90.778 Y101.603 E.00442
G1 X90.643 Y101.963 E.00813
G1 X90.46 Y102.32 E.00849
G1 X90.111 Y102.808 E.01271
G1 X89.699 Y103.209 E.01216
G1 X89.353 Y103.46 E.00905
G1 X88.829 Y103.73 E.01248
G1 X88.257 Y103.906 E.01267
G1 X87.825 Y103.969 E.00924
G1 X87.252 Y103.968 E.01213
G1 X86.66 Y103.861 E.01273
G1 X86.28 Y103.733 E.00849
G1 X85.918 Y103.561 E.00848
G1 X85.58 Y103.347 E.00847
G1 X85.269 Y103.095 E.00848
G1 X84.99 Y102.807 E.00848
G1 X84.747 Y102.489 E.00848
G1 X84.543 Y102.144 E.00847
G1 X84.382 Y101.779 E.00844
G1 X84.26 Y101.37 E.00905
G1 X84.176 Y100.81 E.01198
G1 X84.168 Y95.783 E.1064
G1 X81.479 Y95.778 E.05691
G1 X81.223 Y95.741 E.00548
G1 X81.087 Y95.7 E.00301
G1 X80.853 Y95.591 E.00547
G1 X80.603 Y95.404 E.00659
G1 X80.397 Y95.159 E.00678
G1 X80.253 Y94.873 E.00678
G1 X80.208 Y94.719 E.00339
G1 X80.169 Y94.383 E.00717
G1 X80.169 Y77.419 E.35905
G1 X80.207 Y77.083 E.00716
G1 X80.251 Y76.938 E.0032
G1 X80.356 Y76.712 E.00528
G1 X80.495 Y76.514 E.0051
G1 X80.662 Y76.346 E.00502
G1 X80.786 Y76.253 E.00328
G1 X81.012 Y76.131 E.00544
G1 X81.146 Y76.082 E.00302
G1 X81.399 Y76.03 E.00547
G1 X93.618 Y76.023 E.25863
G1 X93.791 Y76.042 E.00369
G1 X94.097 Y76.134 E.00675
G1 X94.233 Y76.202 E.00322
G1 X94.435 Y76.343 E.00521
G1 X94.657 Y76.577 E.00683
G1 X94.948 Y77.02 E.01122
G1 X97.231 Y77.02 E.04831
G1 X97.231 Y87.52 E.22224
G1 X98.231 Y87.52 E.02117
G1 X98.231 Y87.844 E.00686
G1 X97.05 Y89.025 E.03534
G1 X95.912 Y87.887 E.03407
; WIPE_START
M204 S6000
G1 X95.869 Y87.52 E-.07014
G1 X96.869 Y87.52 E-.19
G1 X96.869 Y86.889 E-.11986
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X94.84 Y91.091 Z5.76 F18000
G1 Z5.36
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X94.84 Y93.088 E.03928
G1 X97.05 Y95.298 E.06147
G1 X99.26 Y93.088 E.06147
G1 X99.26 Y91.091 E.03928
G1 X98.26 Y91.091 E.01967
G1 X98.26 Y89.811 E.02518
G1 X100.24 Y89.811 E.03895
G1 X100.24 Y96.191 E.12549
G1 X91.34 Y96.191 E.17505
G1 X91.34 Y100.594 E.08661
G1 X91.313 Y101.049 E.00896
G1 X91.233 Y101.493 E.00888
G1 X91.167 Y101.73 E.00483
G1 X91.018 Y102.128 E.00836
G1 X90.813 Y102.528 E.00884
G1 X90.561 Y102.903 E.00889
G1 X90.421 Y103.075 E.00436
G1 X90.271 Y103.238 E.00435
G1 X89.958 Y103.526 E.00836
G1 X89.572 Y103.806 E.00937
G1 X89.177 Y104.024 E.00888
G1 X88.977 Y104.112 E.0043
G1 X88.546 Y104.257 E.00895
G1 X88.334 Y104.309 E.00429
G1 X87.86 Y104.377 E.00943
G1 X87.435 Y104.389 E.00836
G1 X87.214 Y104.376 E.00435
G1 X86.967 Y104.345 E.0049
G1 X86.551 Y104.257 E.00836
G1 X86.126 Y104.113 E.00883
G1 X85.72 Y103.92 E.00883
G1 X85.341 Y103.68 E.00883
G1 X84.992 Y103.397 E.00883
G1 X84.679 Y103.075 E.00883
G1 X84.407 Y102.718 E.00883
G1 X84.179 Y102.331 E.00883
G1 X83.998 Y101.921 E.00882
G1 X83.861 Y101.465 E.00937
G1 X83.786 Y101.046 E.00836
G1 X83.767 Y100.828 E.00431
G1 X83.76 Y96.191 E.09121
G1 X81.449 Y96.188 E.04545
G1 X81.134 Y96.141 E.00626
G1 X80.941 Y96.083 E.00397
G1 X80.653 Y95.949 E.00625
G1 X80.481 Y95.836 E.00403
G1 X80.322 Y95.703 E.0041
G1 X80.179 Y95.551 E.00409
G1 X80.055 Y95.384 E.0041
G1 X79.951 Y95.204 E.00409
G1 X79.868 Y95.013 E.00409
G1 X79.809 Y94.814 E.00409
G1 X79.772 Y94.609 E.00409
G1 X79.76 Y94.395 E.00422
G1 X79.76 Y77.407 E.33413
G1 X79.772 Y77.193 E.00421
G1 X79.809 Y76.988 E.0041
G1 X79.867 Y76.792 E.00403
G1 X80.001 Y76.506 E.00619
G1 X80.18 Y76.251 E.00614
G1 X80.393 Y76.037 E.00594
G1 X80.565 Y75.907 E.00423
G1 X80.844 Y75.757 E.00624
G1 X81.034 Y75.687 E.00397
G1 X81.345 Y75.623 E.00625
G1 X81.556 Y75.611 E.00416
G1 X93.641 Y75.614 E.2377
G1 X93.861 Y75.639 E.00436
G1 X94.063 Y75.686 E.00408
G1 X94.259 Y75.758 E.0041
G1 X94.442 Y75.85 E.00404
G1 X94.693 Y76.024 E.006
G1 X94.852 Y76.173 E.00429
G1 X94.986 Y76.332 E.00409
G1 X95.169 Y76.611 E.00656
G1 X97.64 Y76.611 E.04861
G1 X97.64 Y87.111 E.20653
G1 X98.64 Y87.111 E.01967
G1 X98.64 Y88.014 E.01776
G1 X97.05 Y89.604 E.04423
G1 X95.46 Y88.014 E.04423
G1 X95.46 Y87.111 E.01776
G1 X96.46 Y87.111 E.01967
G1 X96.46 Y77.791 E.18332
G1 X94.16 Y77.791 E.04524
G1 X94.159 Y77.356 E.00856
G1 X94.125 Y77.191 E.0033
G1 X94.041 Y77.035 E.00349
G1 X93.916 Y76.91 E.00349
G1 X93.759 Y76.826 E.00349
G1 X93.595 Y76.792 E.0033
G1 X81.532 Y76.791 E.23727
G1 X81.34 Y76.825 E.00382
G1 X81.156 Y76.931 E.00419
G1 X81.021 Y77.092 E.00413
G1 X80.951 Y77.269 E.00374
G1 X80.94 Y94.425 E.33746
G1 X80.998 Y94.668 E.00491
G1 X81.103 Y94.818 E.00361
G1 X81.216 Y94.914 E.00291
G1 X81.375 Y94.987 E.00343
G1 X81.535 Y95.011 E.00319
G1 X93.86 Y95.001 E.24242
G1 X93.86 Y89.811 E.10209
G1 X95.84 Y89.811 E.03895
G1 X95.84 Y91.091 E.02518
G1 X94.9 Y91.091 E.01849
; WIPE_START
M204 S6000
G1 X94.84 Y93.088 E-.3796
G1 X94.842 Y93.089 E-.0004
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




G1 X94.35 Y92.887
G1 Z5.36
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.596522
G1 F1500
M204 S6000
G1 X94.35 Y90.886 E.05697
; WIPE_START
G1 X94.35 Y92.886 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X95.077 Y94.958 Z5.76 F18000
G1 Z5.36
G1 E.4 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.365752
G1 F1500
M204 S6000
G1 X95.013 Y94.995 E.00125
G1 X95.062 Y95.023 E.00095
; WIPE_START
G1 X95.013 Y94.995 E-.16436
G1 X95.077 Y94.958 E-.21564
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X99.065 Y94.958 Z5.76 F18000
G1 Z5.36
G1 E.4 F1800
G1 F1500
M204 S6000
G1 X99.002 Y94.995 E.00125
G1 X99.05 Y95.023 E.00095
; WIPE_START
G1 X99.002 Y94.995 E-.16436
G1 X99.065 Y94.958 E-.21564
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X99.75 Y92.887 Z5.76 F18000
G1 Z5.36
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.596522
G1 F1500
M204 S6000
G1 X99.75 Y90.886 E.05697
; WIPE_START
G1 X99.75 Y92.886 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X93.176 Y96.764 Z5.76 F18000
G1 X90.116 Y98.569 Z5.76
G1 Z5.36
G1 E.4 F1800
; LINE_WIDTH: 0.0947988
G1 F1500
M204 S6000
G1 X90.253 Y98.714 E.00069
G1 X90.275 Y98.776 E.00023
M204 S10000
G1 X90.448 Y99.514 F18000
; LINE_WIDTH: 0.471949
G1 F1500
M204 S6000
G1 X90.505 Y99.865 E.00793
; LINE_WIDTH: 0.432382
G1 X90.524 Y100.064 E.00405
; LINE_WIDTH: 0.399544
G1 X90.539 Y100.232 E.00314
; LINE_WIDTH: 0.361364
G1 X90.55 Y100.603 E.00623
G1 X90.525 Y100.955 E.00591
G1 X90.462 Y101.312 E.00606
G1 X90.409 Y101.492 E.00314
G1 X90.295 Y101.812 E.00569
G1 X90.129 Y102.124 E.00592
G1 X89.924 Y102.429 E.00615
G1 X89.711 Y102.682 E.00555
G1 X89.263 Y103.061 E.00981
G1 X88.687 Y103.374 E.01098
G1 X88.179 Y103.532 E.00891
G1 X87.792 Y103.588 E.00655
G1 X87.568 Y103.599 E.00376
G1 X87.041 Y103.557 E.00884
G1 X86.548 Y103.426 E.00854
G1 X86.217 Y103.285 E.00602
G1 X85.803 Y103.036 E.0081
G1 X85.488 Y102.779 E.0068
G1 X85.281 Y102.556 E.00509
G1 X85.064 Y102.276 E.00595
G1 X84.883 Y101.97 E.00594
G1 X84.741 Y101.647 E.00591
G1 X84.63 Y101.284 E.00636
G1 X84.553 Y100.705 E.00977
G1 X84.57 Y100.132 E.0096
; LINE_WIDTH: 0.415923
G1 X84.609 Y99.813 E.00626
; LINE_WIDTH: 0.465886
G1 X84.648 Y99.494 E.00706
M204 S10000
G1 X84.828 Y98.783 F18000
; LINE_WIDTH: 0.08678
G1 F1500
M204 S6000
M73 P91 R2
G1 X84.843 Y98.737 E.00015
G1 X84.924 Y98.647 E.00037
; WIPE_START
G1 X84.843 Y98.737 E-.27097
G1 X84.828 Y98.783 E-.10903
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X86.707 Y96.742 Z5.76 F18000
G1 Z5.36
G1 E.4 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.596512
G1 F1500
M204 S6000
G1 X87.013 Y96.722 E.00872
; LINE_WIDTH: 0.56342
G1 X87.319 Y96.702 E.00822
G1 X88.19 Y96.728 E.0234
; WIPE_START
G1 X87.319 Y96.702 E-.28124
G1 X87.013 Y96.722 E-.09876
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X86.707 Y96.742 Z5.76 F18000
G1 Z5.36
G1 E.4 F1800
; LINE_WIDTH: 0.597976
G1 F1500
M204 S6000
G1 X86.478 Y96.724 E.00656
; LINE_WIDTH: 0.560942
G1 X86.249 Y96.705 E.00614
; LINE_WIDTH: 0.50747
G1 X86.02 Y96.687 E.00552
G1 X85.44 Y96.687 E.01393
G1 X85.441 Y97.332 E.01549
G1 X85.963 Y97.047 E.01429
; LINE_WIDTH: 0.526375
G1 X86.29 Y96.912 E.00884
; LINE_WIDTH: 0.56834
G1 X86.618 Y96.778 E.00959
; LINE_WIDTH: 0.602907
G1 X86.652 Y96.765 E.00105
; WIPE_START
G1 X86.618 Y96.778 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X89.659 Y96.685 Z5.76 F18000
G1 Z5.36
G1 E.4 F1800
; LINE_WIDTH: 0.507362
G1 F1500
M204 S6000
G1 X88.961 Y96.686 E.01678
; LINE_WIDTH: 0.521482
G1 X88.677 Y96.7 E.00704
; LINE_WIDTH: 0.549722
G1 X88.392 Y96.714 E.00744
; LINE_WIDTH: 0.579467
G1 X88.25 Y96.73 E.00394
; LINE_WIDTH: 0.57316
G1 X88.586 Y96.843 E.00968
; LINE_WIDTH: 0.511758
G1 X88.922 Y96.957 E.0086
G1 X89.549 Y97.262 E.0169
G1 X89.659 Y97.332 E.00317
G1 X89.659 Y96.745 E.01422
M204 S10000
G1 X90.097 Y96.247 F18000
; LINE_WIDTH: 0.419992
G1 F1500
M204 S6000
G1 X85.002 Y96.251 E.10021
G1 X85.006 Y98.172 E.03778
G1 X85.058 Y98.216 E.00135
G1 X85.628 Y97.731 E.01472
G1 X86.171 Y97.43 E.01222
G1 X86.766 Y97.234 E.01232
G1 X87.377 Y97.15 E.01213
G1 X88.213 Y97.21 E.01649
G1 X88.799 Y97.377 E.01198
G1 X89.351 Y97.653 E.01213
G1 X89.719 Y97.913 E.00887
G1 X89.965 Y98.15 E.00671
G1 X90.044 Y98.077 E.00211
G1 X90.097 Y98.082 E.00106
G1 X90.097 Y96.307 E.03492
; CHANGE_LAYER
; Z_HEIGHT: 5.48
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F1500
G1 X90.097 Y98.082 E-.33734
G1 X90.044 Y98.077 E-.01021
G1 X89.965 Y98.15 E-.0204
G1 X89.919 Y98.106 E-.01205
; WIPE_END
G1 E-.02 F1800
; layer num/total_layer_count: 45/49
; update layer progress
M73 L45
M991 S0 P44 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z5.76 I1.04 J.632 P1  F18000
G1 X94.431 Y90.682 Z5.76
G1 Z5.48
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X94.269 Y90.682 E.00342
G1 X94.269 Y90.22 E.00977
G1 X95.431 Y90.22 E.02458
G1 X95.431 Y90.682 E.00977
G1 X94.491 Y90.682 E.0199
; WIPE_START
M204 S6000
G1 X94.269 Y90.682 E-.04209
G1 X94.269 Y90.22 E-.08769
G1 X95.431 Y90.22 E-.22069
G1 X95.431 Y90.376 E-.02952
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X98.669 Y90.22 Z5.88 F18000
G1 Z5.48
G1 E.4 F1800
G1 F1500
M204 S500
G1 X99.831 Y90.22 E.02458
G1 X99.831 Y90.682 E.00977
G1 X98.669 Y90.682 E.02458
G1 X98.669 Y90.28 E.0085
; WIPE_START
M204 S6000
G1 X99.831 Y90.22 E-.22098
G1 X99.831 Y90.682 E-.08769
G1 X99.455 Y90.682 E-.07132
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X98.638 Y94.889 Z5.88 F18000
G1 Z5.48
G1 E.4 F1800
G1 F1500
M204 S500
G1 X99.407 Y94.12 E.02301
G1 X99.407 Y95.357 E.02619
G1 X98.169 Y95.357 E.02619
G1 X98.595 Y94.931 E.01276
M204 S10000
G1 X98.338 Y94.589 F18000
G1 F1500
M204 S500
G1 X99.831 Y93.096 E.04469
G1 X99.831 Y95.782 E.05685
G1 X97.145 Y95.782 E.05685
G1 X98.295 Y94.631 E.03444
; WIPE_START
M204 S6000
G1 X99.71 Y93.217 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X96.569 Y87.944 Z5.88 F18000
G1 Z5.48
G1 E.4 F1800
G1 F1500
M204 S500
G1 X97.531 Y87.944 E.02035
G1 X97.05 Y88.425 E.01439
G1 X96.612 Y87.987 E.01312
; WIPE_START
M204 S6000
G1 X97.531 Y87.944 E-.17484
G1 X97.05 Y88.425 E-.1292
G1 X96.767 Y88.143 E-.07596
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X94.693 Y94.12 Z5.88 F18000
G1 Z5.48
G1 E.4 F1800
G1 F1500
M204 S500
G1 X95.931 Y95.357 E.03704
G1 X94.693 Y95.357 E.02619
G1 X94.693 Y94.18 E.02492
; WIPE_START
M204 S6000
G1 X95.931 Y95.357 E-.32452
G1 X95.639 Y95.357 E-.05549
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X89.274 Y98.096 Z5.88 F18000
G1 Z5.48
G1 E.4 F1800
G1 F1500
M204 S500
G1 X89.15 Y98.009 E.0032
G1 X88.665 Y97.764 E.0115
G1 X88.154 Y97.615 E.01127
G1 X87.778 Y97.564 E.00803
G1 X87.412 Y97.558 E.00775
G1 X86.874 Y97.629 E.01149
G1 X86.367 Y97.794 E.01127
G1 X86.027 Y97.964 E.00804
G1 X85.71 Y98.173 E.00805
G1 X85.316 Y98.528 E.01122
G1 X84.982 Y98.96 E.01157
G1 X84.792 Y99.325 E.00871
G1 X84.598 Y99.278 E.00423
G1 X84.593 Y95.842 E.07273
G1 X90.507 Y95.837 E.12517
G1 X90.507 Y99.288 E.07304
G1 X90.309 Y99.333 E.0043
G1 X90.173 Y99.052 E.00661
G1 X89.959 Y98.738 E.00804
G1 X89.719 Y98.464 E.00771
G1 X89.449 Y98.22 E.00769
G1 X89.323 Y98.131 E.00329
M204 S10000
G1 X89.029 Y98.443 F18000
G1 F1500
M204 S500
G1 X89.184 Y98.553 E.00403
G1 X89.417 Y98.762 E.00662
G1 X89.623 Y98.998 E.00664
G1 X89.805 Y99.265 E.00683
G1 X90.005 Y99.68 E.00975
G1 X90.13 Y100.133 E.00995
G1 X90.172 Y100.601 E.00995
G1 X90.13 Y101.06 E.00975
G1 X90.054 Y101.373 E.00682
G1 X89.946 Y101.663 E.00656
G1 X89.717 Y102.077 E.01001
G1 X89.418 Y102.441 E.00997
G1 X89.059 Y102.745 E.00995
G1 X88.652 Y102.98 E.00995
G1 X88.218 Y103.135 E.00975
G1 X87.902 Y103.198 E.00683
G1 X87.58 Y103.222 E.00683
G1 X87.119 Y103.187 E.00977
G1 X86.662 Y103.066 E.01
G1 X86.377 Y102.944 E.00656
G1 X86.099 Y102.783 E.00682
G1 X85.738 Y102.496 E.00975
G1 X85.429 Y102.142 E.00995
G1 X85.188 Y101.738 E.00995
G1 X85.026 Y101.307 E.00975
G1 X84.959 Y100.991 E.00683
G1 X84.931 Y100.679 E.00663
G1 X84.94 Y100.366 E.00663
G1 X84.988 Y100.047 E.00683
G1 X85.124 Y99.607 E.00976
G1 X85.341 Y99.19 E.00994
G1 X85.628 Y98.818 E.00995
G1 X85.97 Y98.51 E.00974
G1 X86.24 Y98.332 E.00683
G1 X86.529 Y98.187 E.00683
G1 X86.968 Y98.045 E.00977
G1 X87.436 Y97.983 E.01001
G1 X87.746 Y97.988 E.00656
G1 X88.066 Y98.031 E.00682
G1 X88.509 Y98.161 E.00977
G1 X88.931 Y98.374 E.01001
G1 X88.98 Y98.408 E.00126
M204 S250
G1 X88.793 Y98.777 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X88.928 Y98.873 E.00327
G1 X89.125 Y99.05 E.0052
G1 X89.299 Y99.249 E.0052
G1 X89.449 Y99.47 E.00526
G1 X89.62 Y99.824 E.00773
G1 X89.725 Y100.206 E.0078
G1 X89.761 Y100.601 E.0078
G1 X89.726 Y100.993 E.00774
G1 X89.662 Y101.252 E.00526
G1 X89.573 Y101.492 E.00503
G1 X89.377 Y101.846 E.00796
G1 X89.125 Y102.152 E.0078
G1 X88.822 Y102.409 E.0078
G1 X88.479 Y102.607 E.00779
G1 X88.109 Y102.74 E.00773
G1 X87.847 Y102.791 E.00526
G1 X87.58 Y102.811 E.00526
G1 X87.187 Y102.782 E.00774
G1 X86.796 Y102.679 E.00796
G1 X86.561 Y102.578 E.00503
G1 X86.33 Y102.444 E.00526
G1 X86.022 Y102.199 E.00773
G1 X85.761 Y101.9 E.0078
G1 X85.558 Y101.56 E.0078
G1 X85.42 Y101.192 E.00774
G1 X85.364 Y100.93 E.00526
G1 X85.341 Y100.667 E.0052
G1 X85.349 Y100.403 E.0052
G1 X85.388 Y100.138 E.00526
G1 X85.504 Y99.762 E.00774
G1 X85.687 Y99.411 E.00779
G1 X85.929 Y99.097 E.0078
G1 X86.221 Y98.834 E.00773
G1 X86.445 Y98.687 E.00526
G1 X86.684 Y98.567 E.00526
G1 X87.058 Y98.445 E.00774
G1 X87.46 Y98.393 E.00796
G1 X87.715 Y98.397 E.00503
G1 X87.98 Y98.433 E.00526
G1 X88.358 Y98.543 E.00774
G1 X88.72 Y98.725 E.00796
G1 X88.744 Y98.742 E.00058
; WIPE_START
M204 S6000
G1 X88.928 Y98.873 E-.04296
G1 X89.125 Y99.05 E-.05019
G1 X89.299 Y99.249 E-.05024
G1 X89.449 Y99.47 E-.05081
G1 X89.62 Y99.824 E-.07471
G1 X89.725 Y100.206 E-.0753
G1 X89.742 Y100.394 E-.03578
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X93.091 Y93.535 Z5.88 F18000
G1 X95.869 Y87.844 Z5.88
G1 Z5.48
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X95.869 Y87.52 E.00686
G1 X96.869 Y87.52 E.02117
G1 X96.869 Y77.382 E.21459
G1 X94.583 Y77.382 E.0484
G1 X94.514 Y77.05 E.00716
G1 X94.373 Y76.788 E.0063
G1 X94.162 Y76.578 E.0063
G1 X93.901 Y76.437 E.00628
G1 X93.637 Y76.382 E.00571
G1 X81.496 Y76.382 E.25697
G1 X81.198 Y76.434 E.00639
G1 X80.9 Y76.606 E.00729
G1 X80.687 Y76.843 E.00674
G1 X80.542 Y77.181 E.00779
G1 X80.531 Y94.438 E.36526
G1 X80.556 Y94.649 E.00451
G1 X80.671 Y94.937 E.00656
G1 X80.96 Y95.246 E.00896
G1 X81.256 Y95.384 E.0069
G1 X81.505 Y95.42 E.00534
G1 X94.269 Y95.41 E.27016
G1 X94.269 Y93.096 E.04898
G1 X96.955 Y95.782 E.08039
G1 X90.931 Y95.782 E.12751
G1 X90.931 Y100.582 E.10161
G1 X90.906 Y101.001 E.00887
G1 X90.835 Y101.395 E.00847
G1 X90.716 Y101.785 E.00864
G1 X90.46 Y102.319 E.01253
G1 X90.231 Y102.659 E.00868
G1 X89.831 Y103.094 E.01251
G1 X89.355 Y103.459 E.01271
G1 X88.82 Y103.733 E.01271
G1 X88.255 Y103.907 E.01251
G1 X87.829 Y103.968 E.00911
G1 X87.252 Y103.968 E.01222
G1 X86.66 Y103.861 E.01273
G1 X86.28 Y103.733 E.00849
G1 X85.918 Y103.561 E.00848
G1 X85.58 Y103.347 E.00847
G1 X85.269 Y103.094 E.00848
G1 X84.99 Y102.807 E.00847
G1 X84.747 Y102.489 E.00847
G1 X84.543 Y102.144 E.00847
G1 X84.379 Y101.771 E.00864
G1 X84.314 Y101.577 E.00432
G1 X84.224 Y101.199 E.00822
G1 X84.176 Y100.801 E.0085
G1 X84.168 Y95.783 E.10621
G1 X81.47 Y95.778 E.05711
G1 X81.319 Y95.761 E.00321
G1 X81.07 Y95.694 E.00547
G1 X80.792 Y95.554 E.00659
G1 X80.546 Y95.348 E.00678
G1 X80.449 Y95.231 E.00322
G1 X80.318 Y95.02 E.00526
G1 X80.207 Y94.719 E.00679
G1 X80.169 Y94.383 E.00716
G1 X80.169 Y77.419 E.35905
G1 X80.207 Y77.083 E.00716
G1 X80.251 Y76.938 E.0032
G1 X80.356 Y76.712 E.00528
G1 X80.494 Y76.514 E.0051
G1 X80.663 Y76.345 E.00507
G1 X80.786 Y76.253 E.00324
G1 X81.004 Y76.135 E.00525
G1 X81.241 Y76.057 E.00528
G1 X81.39 Y76.03 E.0032
G1 X93.62 Y76.023 E.25886
G1 X93.946 Y76.079 E.00699
G1 X94.096 Y76.134 E.0034
G1 X94.367 Y76.29 E.0066
G1 X94.553 Y76.454 E.00526
G1 X94.657 Y76.578 E.00343
G1 X94.948 Y77.02 E.0112
G1 X97.231 Y77.02 E.04831
G1 X97.231 Y87.52 E.22224
G1 X98.231 Y87.52 E.02117
G1 X98.231 Y87.844 E.00686
G1 X97.05 Y89.025 E.03534
G1 X95.912 Y87.887 E.03407
; WIPE_START
M204 S6000
G1 X95.869 Y87.52 E-.07014
G1 X96.869 Y87.52 E-.19
G1 X96.869 Y86.889 E-.11986
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X94.84 Y91.091 Z5.88 F18000
G1 Z5.48
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X94.84 Y93.088 E.03928
G1 X97.05 Y95.298 E.06147
G1 X99.26 Y93.088 E.06147
G1 X99.26 Y91.091 E.03928
G1 X98.26 Y91.091 E.01967
G1 X98.26 Y89.811 E.02518
G1 X100.24 Y89.811 E.03895
G1 X100.24 Y96.191 E.12549
G1 X91.34 Y96.191 E.17505
G1 X91.34 Y100.594 E.08661
G1 X91.313 Y101.049 E.00896
G1 X91.234 Y101.491 E.00883
G1 X91.102 Y101.923 E.00888
G1 X91.01 Y102.146 E.00474
G1 X90.813 Y102.528 E.00845
G1 X90.561 Y102.903 E.00889
G1 X90.423 Y103.073 E.0043
G1 X90.108 Y103.397 E.00889
G1 X89.757 Y103.682 E.00889
G1 X89.573 Y103.806 E.00436
G1 X89.382 Y103.918 E.00435
G1 X88.974 Y104.113 E.0089
G1 X88.567 Y104.251 E.00845
G1 X88.333 Y104.309 E.00474
G1 X87.864 Y104.377 E.00933
G1 X87.435 Y104.389 E.00845
G1 X87.214 Y104.376 E.00435
G1 X86.972 Y104.346 E.0048
G1 X86.551 Y104.257 E.00845
G1 X86.126 Y104.113 E.00884
G1 X85.72 Y103.92 E.00883
G1 X85.341 Y103.68 E.00883
G1 X84.992 Y103.397 E.00884
G1 X84.679 Y103.075 E.00883
G1 X84.407 Y102.718 E.00883
G1 X84.179 Y102.331 E.00883
G1 X83.996 Y101.918 E.00889
G1 X83.92 Y101.689 E.00474
G1 X83.82 Y101.271 E.00845
G1 X83.767 Y100.825 E.00884
G1 X83.76 Y96.191 E.09115
G1 X81.446 Y96.188 E.04551
G1 X81.242 Y96.164 E.00403
G1 X80.935 Y96.081 E.00625
G1 X80.747 Y96 E.00404
G1 X80.567 Y95.896 E.00409
G1 X80.4 Y95.772 E.00409
G1 X80.248 Y95.629 E.00409
G1 X80.116 Y95.472 E.00404
G1 X79.955 Y95.211 E.00604
G1 X79.868 Y95.013 E.00425
G1 X79.809 Y94.814 E.00409
G1 X79.772 Y94.609 E.00409
G1 X79.76 Y94.395 E.00422
G1 X79.76 Y77.407 E.33413
G1 X79.772 Y77.193 E.00422
G1 X79.809 Y76.988 E.0041
M73 P92 R2
G1 X79.867 Y76.792 E.00403
G1 X80.001 Y76.506 E.0062
G1 X80.179 Y76.251 E.00614
G1 X80.394 Y76.035 E.00598
G1 X80.565 Y75.907 E.00419
G1 X80.841 Y75.758 E.00619
G1 X81.14 Y75.659 E.00619
G1 X81.342 Y75.623 E.00403
G1 X81.556 Y75.611 E.00422
G1 X93.643 Y75.614 E.23774
G1 X93.861 Y75.639 E.00432
G1 X94.063 Y75.686 E.00408
G1 X94.259 Y75.758 E.0041
G1 X94.445 Y75.851 E.00409
G1 X94.616 Y75.964 E.00404
G1 X94.846 Y76.168 E.00604
G1 X94.986 Y76.333 E.00425
G1 X95.169 Y76.611 E.00655
G1 X97.64 Y76.611 E.04861
G1 X97.64 Y87.111 E.20653
G1 X98.64 Y87.111 E.01967
G1 X98.64 Y88.014 E.01776
G1 X97.05 Y89.604 E.04423
G1 X95.46 Y88.014 E.04423
G1 X95.46 Y87.111 E.01776
G1 X96.46 Y87.111 E.01967
G1 X96.46 Y77.791 E.18332
G1 X94.16 Y77.791 E.04524
G1 X94.159 Y77.356 E.00856
G1 X94.125 Y77.192 E.0033
G1 X94.041 Y77.035 E.0035
G1 X93.915 Y76.91 E.00349
G1 X93.759 Y76.826 E.00348
G1 X93.595 Y76.792 E.00331
G1 X81.532 Y76.791 E.23727
G1 X81.34 Y76.825 E.00382
G1 X81.161 Y76.928 E.00407
G1 X81.037 Y77.066 E.00366
G1 X80.951 Y77.265 E.00426
G1 X80.94 Y94.413 E.33728
G1 X80.956 Y94.547 E.00266
G1 X81.022 Y94.714 E.00352
G1 X81.205 Y94.908 E.00525
G1 X81.374 Y94.987 E.00368
G1 X81.535 Y95.011 E.00319
G1 X93.86 Y95.001 E.24243
G1 X93.86 Y89.811 E.10209
G1 X95.84 Y89.811 E.03895
G1 X95.84 Y91.091 E.02518
G1 X94.9 Y91.091 E.01849
; WIPE_START
M204 S6000
G1 X94.84 Y93.088 E-.3796
G1 X94.842 Y93.089 E-.0004
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




G1 X94.35 Y92.887
G1 Z5.48
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.596522
G1 F1500
M204 S6000
G1 X94.35 Y90.886 E.05697
; WIPE_START
G1 X94.35 Y92.886 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X95.077 Y94.958 Z5.88 F18000
G1 Z5.48
G1 E.4 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.365752
G1 F1500
M204 S6000
G1 X95.013 Y94.995 E.00125
G1 X95.062 Y95.023 E.00095
; WIPE_START
G1 X95.013 Y94.995 E-.16436
G1 X95.077 Y94.958 E-.21564
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X99.065 Y94.958 Z5.88 F18000
G1 Z5.48
G1 E.4 F1800
G1 F1500
M204 S6000
G1 X99.002 Y94.995 E.00125
G1 X99.05 Y95.023 E.00095
; WIPE_START
G1 X99.002 Y94.995 E-.16436
G1 X99.065 Y94.958 E-.21564
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X99.75 Y92.887 Z5.88 F18000
G1 Z5.48
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.596522
G1 F1500
M204 S6000
G1 X99.75 Y90.886 E.05697
; WIPE_START
G1 X99.75 Y92.886 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X93.19 Y96.787 Z5.88 F18000
G1 X90.148 Y98.596 Z5.88
G1 Z5.48
G1 E.4 F1800
; LINE_WIDTH: 0.0954041
G1 F1500
M204 S6000
G1 X90.252 Y98.715 E.00055
G1 X90.275 Y98.792 E.00028
M204 S10000
G1 X90.454 Y99.518 F18000
; LINE_WIDTH: 0.471888
G1 F1500
M204 S6000
G1 X90.49 Y99.781 E.0059
; LINE_WIDTH: 0.432119
G1 X90.525 Y100.043 E.00538
; LINE_WIDTH: 0.409148
G1 X90.529 Y100.078 E.00066
; LINE_WIDTH: 0.383881
G1 X90.551 Y100.571 E.00883
; LINE_WIDTH: 0.360317
G1 X90.5 Y101.134 E.00943
G1 X90.357 Y101.652 E.00897
G1 X90.28 Y101.83 E.00325
G1 X90.036 Y102.276 E.00848
G1 X89.674 Y102.714 E.00949
G1 X89.286 Y103.042 E.00849
G1 X89.15 Y103.135 E.00275
G1 X88.676 Y103.378 E.00889
G1 X88.177 Y103.532 E.00872
G1 X87.796 Y103.588 E.00642
G1 X87.45 Y103.596 E.00578
G1 X87.072 Y103.562 E.00634
G1 X86.761 Y103.49 E.00532
G1 X86.528 Y103.419 E.00407
G1 X86.217 Y103.286 E.00565
G1 X85.803 Y103.036 E.00807
G1 X85.488 Y102.779 E.00678
G1 X85.281 Y102.556 E.00508
G1 X85.116 Y102.352 E.00439
G1 X84.883 Y101.97 E.00746
G1 X84.74 Y101.637 E.00605
G1 X84.671 Y101.423 E.00375
G1 X84.599 Y101.13 E.00505
G1 X84.557 Y100.778 E.00592
G1 X84.572 Y100.146 E.01055
; LINE_WIDTH: 0.408568
G1 X84.585 Y99.97 E.00336
; LINE_WIDTH: 0.441569
G1 X84.621 Y99.725 E.00514
; LINE_WIDTH: 0.474143
G1 X84.653 Y99.51 E.00487
M204 S10000
G1 X84.828 Y98.783 F18000
; LINE_WIDTH: 0.0935411
G1 F1500
M204 S6000
G1 X84.85 Y98.717 E.00024
G1 X84.973 Y98.584 E.00061
; WIPE_START
G1 X84.85 Y98.717 E-.27444
G1 X84.828 Y98.783 E-.10556
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X86.707 Y96.742 Z5.88 F18000
G1 Z5.48
G1 E.4 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.596637
G1 F1500
M204 S6000
G1 X87.011 Y96.722 E.00868
; LINE_WIDTH: 0.563516
G1 X87.315 Y96.702 E.00818
G1 X88.19 Y96.728 E.02349
; WIPE_START
G1 X87.315 Y96.702 E-.28189
G1 X87.011 Y96.722 E-.09811
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X86.707 Y96.742 Z5.88 F18000
G1 Z5.48
G1 E.4 F1800
; LINE_WIDTH: 0.598721
G1 F1500
M204 S6000
G1 X86.485 Y96.724 E.00636
; LINE_WIDTH: 0.562937
G1 X86.264 Y96.707 E.00596
; LINE_WIDTH: 0.511167
G1 X86.042 Y96.689 E.00539
G1 X85.442 Y96.689 E.01453
G1 X85.443 Y97.349 E.01598
G1 X85.968 Y97.046 E.01469
; LINE_WIDTH: 0.529535
G1 X86.293 Y96.912 E.00883
; LINE_WIDTH: 0.57008
G1 X86.618 Y96.778 E.00954
; LINE_WIDTH: 0.603482
G1 X86.651 Y96.764 E.00105
; WIPE_START
G1 X86.618 Y96.778 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X89.659 Y96.685 Z5.88 F18000
G1 Z5.48
G1 E.4 F1800
; LINE_WIDTH: 0.507312
G1 F1500
M204 S6000
G1 X88.96 Y96.686 E.0168
; LINE_WIDTH: 0.521422
G1 X88.676 Y96.7 E.00703
; LINE_WIDTH: 0.549642
G1 X88.392 Y96.714 E.00743
; LINE_WIDTH: 0.579412
G1 X88.25 Y96.73 E.00395
; LINE_WIDTH: 0.573132
G1 X88.586 Y96.843 E.00967
; LINE_WIDTH: 0.511705
G1 X88.921 Y96.957 E.00859
G1 X89.546 Y97.26 E.01683
G1 X89.659 Y97.332 E.00326
G1 X89.659 Y96.745 E.01422
M204 S10000
G1 X90.097 Y96.247 F18000
; LINE_WIDTH: 0.419992
G1 F1500
M204 S6000
G1 X85.002 Y96.251 E.10021
G1 X85.005 Y98.1 E.03637
G1 X85.115 Y98.158 E.00244
G1 X85.481 Y97.834 E.00962
G1 X86.188 Y97.426 E.01605
G1 X86.766 Y97.234 E.01198
G1 X87.374 Y97.15 E.01208
G1 X88.213 Y97.21 E.01655
G1 X88.799 Y97.377 E.01197
G1 X89.348 Y97.651 E.01208
G1 X89.719 Y97.913 E.00893
G1 X89.998 Y98.184 E.00763
G1 X90.097 Y98.066 E.00303
G1 X90.097 Y96.307 E.0346
; CHANGE_LAYER
; Z_HEIGHT: 5.6
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F1500
G1 X90.097 Y98.066 E-.33426
G1 X89.998 Y98.184 E-.02928
G1 X89.936 Y98.123 E-.01646
; WIPE_END
G1 E-.02 F1800
; layer num/total_layer_count: 46/49
; update layer progress
M73 L46
M991 S0 P45 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z5.88 I1.042 J.629 P1  F18000
G1 X94.431 Y90.682 Z5.88
G1 Z5.6
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X94.269 Y90.682 E.00342
G1 X94.269 Y90.22 E.00977
G1 X95.431 Y90.22 E.02458
G1 X95.431 Y90.682 E.00977
G1 X94.491 Y90.682 E.0199
; WIPE_START
M204 S6000
G1 X94.269 Y90.682 E-.04209
G1 X94.269 Y90.22 E-.08769
G1 X95.431 Y90.22 E-.22069
G1 X95.431 Y90.376 E-.02952
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X98.669 Y90.22 Z6 F18000
G1 Z5.6
G1 E.4 F1800
G1 F1500
M204 S500
G1 X99.831 Y90.22 E.02458
G1 X99.831 Y90.682 E.00977
G1 X98.669 Y90.682 E.02458
G1 X98.669 Y90.28 E.0085
; WIPE_START
M204 S6000
G1 X99.831 Y90.22 E-.22098
G1 X99.831 Y90.682 E-.08769
G1 X99.455 Y90.682 E-.07132
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X98.638 Y94.889 Z6 F18000
G1 Z5.6
G1 E.4 F1800
G1 F1500
M204 S500
G1 X99.407 Y94.12 E.02301
G1 X99.407 Y95.357 E.02619
G1 X98.169 Y95.357 E.02619
G1 X98.595 Y94.931 E.01276
M204 S10000
G1 X98.338 Y94.589 F18000
G1 F1500
M204 S500
G1 X99.831 Y93.096 E.04469
G1 X99.831 Y95.782 E.05685
G1 X97.145 Y95.782 E.05685
G1 X98.295 Y94.631 E.03444
; WIPE_START
M204 S6000
G1 X99.71 Y93.217 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X96.569 Y87.944 Z6 F18000
G1 Z5.6
G1 E.4 F1800
G1 F1500
M204 S500
G1 X97.531 Y87.944 E.02035
G1 X97.05 Y88.425 E.01439
G1 X96.612 Y87.987 E.01312
; WIPE_START
M204 S6000
G1 X97.531 Y87.944 E-.17484
G1 X97.05 Y88.425 E-.1292
G1 X96.767 Y88.143 E-.07596
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X94.693 Y94.12 Z6 F18000
G1 Z5.6
G1 E.4 F1800
G1 F1500
M204 S500
G1 X95.931 Y95.357 E.03704
G1 X94.693 Y95.357 E.02619
G1 X94.693 Y94.18 E.02492
; WIPE_START
M204 S6000
G1 X95.931 Y95.357 E-.32452
G1 X95.639 Y95.357 E-.05549
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X89.267 Y98.092 Z6 F18000
G1 Z5.6
G1 E.4 F1800
G1 F1500
M204 S500
G1 X89.148 Y98.007 E.00309
G1 X88.665 Y97.764 E.01144
G1 X88.154 Y97.615 E.01126
G1 X87.778 Y97.564 E.00803
G1 X87.409 Y97.558 E.00781
G1 X86.873 Y97.629 E.01144
G1 X86.351 Y97.799 E.01163
G1 X85.876 Y98.056 E.01144
G1 X85.581 Y98.278 E.00781
G1 X85.306 Y98.54 E.00803
G1 X84.991 Y98.948 E.0109
G1 X84.788 Y99.312 E.00882
G1 X84.598 Y99.262 E.00416
G1 X84.593 Y95.842 E.07239
G1 X90.507 Y95.837 E.12519
G1 X90.502 Y99.262 E.07249
G1 X90.301 Y99.305 E.00436
G1 X90.058 Y98.872 E.0105
G1 X89.731 Y98.474 E.0109
G1 X89.449 Y98.22 E.00802
G1 X89.316 Y98.126 E.00345
M204 S10000
G1 X89.022 Y98.438 F18000
G1 F1500
M204 S500
G1 X89.184 Y98.553 E.00419
G1 X89.424 Y98.768 E.00682
G1 X89.71 Y99.117 E.00955
G1 X89.876 Y99.394 E.00683
G1 X90.007 Y99.689 E.00683
G1 X90.13 Y100.133 E.00975
G1 X90.171 Y100.592 E.00975
G1 X90.152 Y100.913 E.00682
G1 X90.096 Y101.221 E.00662
G1 X89.946 Y101.666 E.00995
G1 X89.716 Y102.078 E.00997
G1 X89.418 Y102.441 E.00995
G1 X89.058 Y102.745 E.00997
G1 X88.651 Y102.979 E.00995
G1 X88.359 Y103.093 E.00662
G1 X88.047 Y103.174 E.00682
G1 X87.589 Y103.222 E.00975
G1 X87.12 Y103.187 E.00997
G1 X86.665 Y103.068 E.00995
G1 X86.378 Y102.944 E.00662
G1 X86.098 Y102.783 E.00682
G1 X85.737 Y102.495 E.00977
G1 X85.429 Y102.14 E.00995
G1 X85.261 Y101.877 E.00662
G1 X85.121 Y101.586 E.00682
G1 X84.986 Y101.146 E.00976
G1 X84.929 Y100.679 E.00994
G1 X84.958 Y100.21 E.00995
G1 X85.067 Y99.763 E.00975
G1 X85.189 Y99.464 E.00683
G1 X85.346 Y99.182 E.00683
G1 X85.622 Y98.825 E.00956
G1 X85.856 Y98.602 E.00682
G1 X86.105 Y98.414 E.00661
M73 P92 R1
G1 X86.519 Y98.19 E.00995
G1 X86.967 Y98.045 E.00999
G1 X87.434 Y97.983 E.00995
G1 X87.746 Y97.988 E.00662
G1 X88.066 Y98.031 E.00683
G1 X88.509 Y98.161 E.00977
G1 X88.929 Y98.372 E.00995
G1 X88.973 Y98.404 E.00116
M204 S250
G1 X88.786 Y98.773 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X88.928 Y98.873 E.00342
G1 X89.127 Y99.052 E.00526
G1 X89.375 Y99.353 E.00767
G1 X89.512 Y99.583 E.00526
G1 X89.621 Y99.827 E.00526
G1 X89.725 Y100.206 E.00773
G1 X89.761 Y100.598 E.00773
G1 X89.745 Y100.865 E.00526
G1 X89.699 Y101.119 E.00508
G1 X89.57 Y101.5 E.00792
G1 X89.377 Y101.846 E.0078
G1 X89.125 Y102.152 E.00779
G1 X88.822 Y102.409 E.0078
G1 X88.473 Y102.609 E.00792
G1 X88.233 Y102.703 E.00507
G1 X87.974 Y102.77 E.00526
G1 X87.583 Y102.811 E.00774
G1 X87.187 Y102.782 E.0078
G1 X86.798 Y102.679 E.00791
G1 X86.561 Y102.578 E.00508
G1 X86.33 Y102.444 E.00526
M73 P93 R1
G1 X86.022 Y102.199 E.00774
G1 X85.758 Y101.895 E.00791
G1 X85.619 Y101.677 E.00508
G1 X85.503 Y101.436 E.00526
G1 X85.387 Y101.06 E.00774
G1 X85.34 Y100.667 E.00779
G1 X85.364 Y100.271 E.0078
G1 X85.457 Y99.889 E.00773
G1 X85.559 Y99.642 E.00526
G1 X85.689 Y99.408 E.00526
G1 X85.927 Y99.1 E.00768
G1 X86.121 Y98.915 E.00526
G1 X86.327 Y98.76 E.00507
G1 X86.681 Y98.568 E.00791
G1 X87.058 Y98.445 E.00781
G1 X87.457 Y98.393 E.00792
G1 X87.715 Y98.397 E.00508
G1 X87.98 Y98.433 E.00526
G1 X88.358 Y98.543 E.00774
G1 X88.717 Y98.724 E.00792
G1 X88.737 Y98.738 E.00048
; WIPE_START
M204 S6000
G1 X88.928 Y98.873 E-.04441
G1 X89.127 Y99.052 E-.05079
G1 X89.375 Y99.353 E-.0741
G1 X89.512 Y99.583 E-.05086
G1 X89.621 Y99.827 E-.05083
G1 X89.725 Y100.206 E-.07471
G1 X89.742 Y100.386 E-.03431
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X93.092 Y93.528 Z6 F18000
G1 X95.869 Y87.844 Z6
G1 Z5.6
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X95.869 Y87.52 E.00686
G1 X96.869 Y87.52 E.02117
G1 X96.869 Y77.382 E.21459
G1 X94.582 Y77.382 E.0484
G1 X94.514 Y77.049 E.00719
G1 X94.373 Y76.788 E.00628
G1 X94.162 Y76.578 E.0063
G1 X93.901 Y76.437 E.00629
G1 X93.637 Y76.382 E.00571
G1 X81.496 Y76.382 E.25697
G1 X81.199 Y76.434 E.00639
G1 X80.899 Y76.606 E.00732
G1 X80.687 Y76.844 E.00674
G1 X80.541 Y77.181 E.00778
G1 X80.531 Y94.437 E.36523
G1 X80.555 Y94.646 E.00446
G1 X80.672 Y94.94 E.00668
G1 X80.961 Y95.246 E.00892
G1 X81.256 Y95.384 E.00689
G1 X81.505 Y95.42 E.00533
G1 X94.269 Y95.41 E.27016
G1 X94.269 Y93.096 E.04898
G1 X96.955 Y95.782 E.08039
G1 X90.932 Y95.782 E.12749
G1 X90.924 Y100.801 E.10623
G1 X90.876 Y101.199 E.00848
G1 X90.782 Y101.588 E.00848
G1 X90.643 Y101.963 E.00848
G1 X90.461 Y102.319 E.00845
G1 X90.226 Y102.665 E.00885
G1 X89.838 Y103.089 E.01216
G1 X89.356 Y103.459 E.01288
G1 X88.821 Y103.733 E.01272
G1 X88.256 Y103.906 E.0125
G1 X87.833 Y103.968 E.00905
G1 X87.25 Y103.968 E.01235
G1 X86.659 Y103.861 E.01271
G1 X86.28 Y103.733 E.00847
G1 X85.918 Y103.561 E.00848
G1 X85.58 Y103.347 E.00847
G1 X85.269 Y103.094 E.00848
G1 X84.99 Y102.807 E.00847
G1 X84.747 Y102.489 E.00848
G1 X84.543 Y102.144 E.00847
G1 X84.382 Y101.778 E.00848
G1 X84.225 Y101.208 E.01251
G1 X84.176 Y100.801 E.00868
G1 X84.168 Y95.783 E.10621
G1 X81.479 Y95.778 E.05691
G1 X81.223 Y95.741 E.00548
G1 X80.931 Y95.634 E.00659
G1 X80.792 Y95.554 E.00339
G1 X80.546 Y95.348 E.00679
G1 X80.449 Y95.232 E.0032
G1 X80.313 Y95.012 E.00547
G1 X80.207 Y94.719 E.00659
G1 X80.169 Y94.383 E.00716
G1 X80.169 Y77.419 E.35906
G1 X80.206 Y77.092 E.00697
G1 X80.284 Y76.855 E.00528
G1 X80.403 Y76.635 E.00528
G1 X80.488 Y76.521 E.00301
G1 X80.67 Y76.339 E.00547
G1 X80.784 Y76.254 E.00301
G1 X81.004 Y76.135 E.00528
G1 X81.241 Y76.057 E.00528
G1 X81.39 Y76.03 E.00321
G1 X93.622 Y76.023 E.25891
G1 X93.946 Y76.079 E.00695
G1 X94.097 Y76.134 E.0034
G1 X94.366 Y76.289 E.00659
G1 X94.56 Y76.461 E.00547
G1 X94.657 Y76.577 E.0032
G1 X94.948 Y77.02 E.01123
G1 X97.231 Y77.02 E.04831
G1 X97.231 Y87.52 E.22224
G1 X98.231 Y87.52 E.02117
G1 X98.231 Y87.844 E.00686
G1 X97.05 Y89.025 E.03534
G1 X95.912 Y87.887 E.03407
; WIPE_START
M204 S6000
G1 X95.869 Y87.52 E-.07014
G1 X96.869 Y87.52 E-.19
G1 X96.869 Y86.889 E-.11986
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X94.84 Y91.091 Z6 F18000
G1 Z5.6
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X94.84 Y93.088 E.03928
G1 X97.05 Y95.298 E.06147
G1 X99.26 Y93.088 E.06147
G1 X99.26 Y91.091 E.03928
G1 X98.26 Y91.091 E.01967
G1 X98.26 Y89.811 E.02518
G1 X100.24 Y89.811 E.03895
G1 X100.24 Y96.191 E.12549
G1 X91.34 Y96.191 E.17505
G1 X91.333 Y100.825 E.09115
G1 X91.28 Y101.271 E.00883
G1 X91.174 Y101.708 E.00884
G1 X91.018 Y102.129 E.00883
G1 X90.813 Y102.528 E.00882
G1 X90.551 Y102.914 E.00919
G1 X90.267 Y103.243 E.00854
G1 X90.11 Y103.395 E.0043
G1 X89.757 Y103.682 E.00895
G1 X89.573 Y103.805 E.00435
G1 X89.367 Y103.926 E.00471
G1 X88.974 Y104.113 E.00854
G1 X88.546 Y104.257 E.0089
G1 X88.334 Y104.309 E.00429
G1 X87.869 Y104.377 E.00924
G1 X87.435 Y104.389 E.00854
G1 X87.214 Y104.376 E.00436
G1 X86.993 Y104.35 E.00436
G1 X86.551 Y104.256 E.00889
G1 X86.126 Y104.113 E.00883
G1 X85.72 Y103.92 E.00883
G1 X85.341 Y103.68 E.00883
G1 X84.992 Y103.397 E.00883
G1 X84.679 Y103.075 E.00883
G1 X84.407 Y102.718 E.00883
G1 X84.179 Y102.331 E.00883
G1 X83.998 Y101.92 E.00884
G1 X83.865 Y101.488 E.00889
G1 X83.82 Y101.274 E.00429
G1 X83.767 Y100.825 E.0089
G1 X83.76 Y96.191 E.09115
G1 X81.449 Y96.188 E.04545
G1 X81.134 Y96.141 E.00626
G1 X80.938 Y96.083 E.00403
G1 X80.747 Y96 E.0041
G1 X80.567 Y95.896 E.00409
G1 X80.4 Y95.772 E.0041
G1 X80.248 Y95.629 E.0041
G1 X80.116 Y95.472 E.00403
G1 X79.95 Y95.201 E.00625
G1 X79.868 Y95.013 E.00403
G1 X79.809 Y94.814 E.00409
G1 X79.772 Y94.609 E.00409
G1 X79.76 Y94.395 E.00422
G1 X79.76 Y77.407 E.33413
G1 X79.772 Y77.193 E.00421
G1 X79.808 Y76.991 E.00403
G1 X79.907 Y76.692 E.0062
G1 X80.057 Y76.415 E.00619
G1 X80.177 Y76.253 E.00397
G1 X80.402 Y76.028 E.00625
G1 X80.564 Y75.908 E.00397
G1 X80.841 Y75.758 E.0062
G1 X81.14 Y75.659 E.00619
G1 X81.342 Y75.623 E.00403
G1 X81.556 Y75.611 E.00422
G1 X93.645 Y75.614 E.23778
G1 X93.861 Y75.638 E.00427
G1 X94.063 Y75.686 E.00409
G1 X94.259 Y75.758 E.0041
G1 X94.445 Y75.851 E.00409
G1 X94.616 Y75.964 E.00403
G1 X94.854 Y76.175 E.00626
G1 X94.985 Y76.332 E.00403
G1 X95.169 Y76.611 E.00656
G1 X97.64 Y76.611 E.04861
G1 X97.64 Y87.111 E.20653
G1 X98.64 Y87.111 E.01967
G1 X98.64 Y88.014 E.01776
G1 X97.05 Y89.604 E.04423
G1 X95.46 Y88.014 E.04423
G1 X95.46 Y87.111 E.01776
G1 X96.46 Y87.111 E.01967
G1 X96.46 Y77.791 E.18332
G1 X94.16 Y77.791 E.04524
G1 X94.159 Y77.356 E.00855
G1 X94.125 Y77.191 E.00332
G1 X94.041 Y77.035 E.00348
G1 X93.915 Y76.91 E.0035
G1 X93.759 Y76.826 E.00349
G1 X93.595 Y76.792 E.0033
G1 X81.532 Y76.791 E.23727
G1 X81.341 Y76.825 E.00382
G1 X81.16 Y76.928 E.00409
G1 X81.036 Y77.067 E.00366
G1 X80.951 Y77.266 E.00426
G1 X80.94 Y94.413 E.33727
G1 X80.955 Y94.545 E.00261
G1 X81.023 Y94.716 E.00361
G1 X81.205 Y94.908 E.00521
G1 X81.375 Y94.987 E.00368
G1 X81.535 Y95.011 E.00319
G1 X93.86 Y95.001 E.24242
G1 X93.86 Y89.811 E.10209
G1 X95.84 Y89.811 E.03895
G1 X95.84 Y91.091 E.02518
G1 X94.9 Y91.091 E.01849
; WIPE_START
M204 S6000
G1 X94.84 Y93.088 E-.3796
G1 X94.842 Y93.089 E-.0004
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




G1 X94.35 Y92.887
G1 Z5.6
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.596522
G1 F1500
M204 S6000
G1 X94.35 Y90.886 E.05697
; WIPE_START
G1 X94.35 Y92.886 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X95.077 Y94.958 Z6 F18000
G1 Z5.6
G1 E.4 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.365752
G1 F1500
M204 S6000
G1 X95.013 Y94.995 E.00125
G1 X95.062 Y95.023 E.00095
; WIPE_START
G1 X95.013 Y94.995 E-.16436
G1 X95.077 Y94.958 E-.21564
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X99.065 Y94.958 Z6 F18000
G1 Z5.6
G1 E.4 F1800
G1 F1500
M204 S6000
G1 X99.002 Y94.995 E.00125
G1 X99.05 Y95.023 E.00095
; WIPE_START
G1 X99.002 Y94.995 E-.16436
G1 X99.065 Y94.958 E-.21564
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X99.75 Y92.887 Z6 F18000
G1 Z5.6
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.596522
G1 F1500
M204 S6000
G1 X99.75 Y90.886 E.05697
; WIPE_START
G1 X99.75 Y92.886 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X93.176 Y96.764 Z6 F18000
G1 X90.116 Y98.569 Z6
G1 Z5.6
G1 E.4 F1800
; LINE_WIDTH: 0.0950993
G1 F1500
M204 S6000
G1 X90.249 Y98.711 E.00067
G1 X90.271 Y98.776 E.00024
M204 S10000
G1 X90.443 Y99.492 F18000
; LINE_WIDTH: 0.476261
G1 F1500
M204 S6000
G1 X90.482 Y99.766 E.00623
; LINE_WIDTH: 0.430326
G1 X90.522 Y100.04 E.0056
; LINE_WIDTH: 0.403746
G1 X90.526 Y100.078 E.00071
; LINE_WIDTH: 0.377496
G1 X90.547 Y100.574 E.00871
; LINE_WIDTH: 0.361004
G1 X90.5 Y101.131 E.00935
G1 X90.415 Y101.476 E.00594
G1 X90.296 Y101.811 E.00594
G1 X90.035 Y102.277 E.00895
G1 X89.697 Y102.697 E.00901
G1 X89.264 Y103.064 E.0095
G1 X88.677 Y103.378 E.01113
G1 X88.127 Y103.544 E.0096
G1 X87.8 Y103.586 E.00552
G1 X87.45 Y103.596 E.00586
G1 X87.072 Y103.562 E.00634
G1 X86.761 Y103.49 E.00535
G1 X86.531 Y103.42 E.00402
G1 X86.217 Y103.286 E.0057
G1 X85.803 Y103.036 E.0081
G1 X85.487 Y102.778 E.00682
G1 X85.281 Y102.556 E.00506
G1 X85.12 Y102.356 E.0043
G1 X84.936 Y102.069 E.0057
G1 X84.741 Y101.647 E.00778
G1 X84.614 Y101.21 E.00761
G1 X84.557 Y100.778 E.00729
G1 X84.57 Y100.135 E.01075
; LINE_WIDTH: 0.415371
G1 X84.608 Y99.815 E.00628
; LINE_WIDTH: 0.464847
G1 X84.646 Y99.494 E.00707
M204 S10000
G1 X84.828 Y98.783 F18000
; LINE_WIDTH: 0.086768
G1 F1500
M204 S6000
G1 X84.843 Y98.737 E.00015
G1 X84.924 Y98.647 E.00037
; WIPE_START
G1 X84.843 Y98.737 E-.2709
G1 X84.828 Y98.783 E-.1091
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X86.706 Y96.742 Z6 F18000
G1 Z5.6
G1 E.4 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.596797
G1 F1500
M204 S6000
G1 X87.009 Y96.722 E.00864
; LINE_WIDTH: 0.563607
G1 X87.311 Y96.702 E.00814
G1 X88.19 Y96.728 E.02359
; WIPE_START
G1 X87.311 Y96.702 E-.28255
G1 X87.009 Y96.722 E-.09745
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X86.706 Y96.742 Z6 F18000
G1 Z5.6
G1 E.4 F1800
; LINE_WIDTH: 0.598219
G1 F1500
M204 S6000
G1 X86.478 Y96.724 E.00655
; LINE_WIDTH: 0.561072
G1 X86.249 Y96.705 E.00612
; LINE_WIDTH: 0.507428
G1 X86.021 Y96.687 E.00551
G1 X85.44 Y96.687 E.01396
G1 X85.441 Y97.332 E.01549
G1 X85.965 Y97.046 E.01433
; LINE_WIDTH: 0.526397
G1 X86.291 Y96.912 E.00881
; LINE_WIDTH: 0.568487
G1 X86.617 Y96.778 E.00955
; LINE_WIDTH: 0.603162
G1 X86.651 Y96.765 E.00105
; WIPE_START
M73 P94 R1
G1 X86.617 Y96.778 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X89.659 Y96.685 Z6 F18000
G1 Z5.6
G1 E.4 F1800
; LINE_WIDTH: 0.507082
G1 F1500
M204 S6000
G1 X88.96 Y96.685 E.01679
; LINE_WIDTH: 0.52122
G1 X88.676 Y96.7 E.00702
; LINE_WIDTH: 0.549495
G1 X88.393 Y96.714 E.00742
; LINE_WIDTH: 0.579362
G1 X88.25 Y96.73 E.00396
; LINE_WIDTH: 0.57309
G1 X88.586 Y96.843 E.00967
; LINE_WIDTH: 0.511491
G1 X88.921 Y96.957 E.00858
G1 X89.543 Y97.258 E.01674
G1 X89.658 Y97.331 E.0033
G1 X89.659 Y96.745 E.0142
M204 S10000
G1 X90.098 Y96.247 F18000
; LINE_WIDTH: 0.419992
G1 F1500
M204 S6000
G1 X85.002 Y96.251 E.10021
G1 X85.006 Y98.172 E.03778
G1 X85.058 Y98.216 E.00135
G1 X85.633 Y97.727 E.01485
G1 X86.173 Y97.43 E.01212
G1 X86.765 Y97.234 E.01228
G1 X87.371 Y97.15 E.01203
G1 X88.213 Y97.21 E.01661
G1 X88.798 Y97.377 E.01196
G1 X89.346 Y97.649 E.01202
G1 X89.719 Y97.913 E.00898
G1 X89.965 Y98.15 E.00673
G1 X90.044 Y98.079 E.00209
G1 X90.095 Y98.083 E.00101
G1 X90.097 Y96.307 E.03494
; CHANGE_LAYER
; Z_HEIGHT: 5.72
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F1500
G1 X90.095 Y98.083 E-.33754
G1 X90.044 Y98.079 E-.00973
G1 X89.965 Y98.15 E-.02019
G1 X89.918 Y98.104 E-.01254
; WIPE_END
G1 E-.02 F1800
; layer num/total_layer_count: 47/49
; update layer progress
M73 L47
M991 S0 P46 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z6 I1.04 J.632 P1  F18000
G1 X94.431 Y90.682 Z6
G1 Z5.72
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X94.269 Y90.682 E.00342
G1 X94.269 Y90.22 E.00977
G1 X95.431 Y90.22 E.02458
G1 X95.431 Y90.682 E.00977
G1 X94.491 Y90.682 E.0199
; WIPE_START
M204 S6000
G1 X94.269 Y90.682 E-.04209
G1 X94.269 Y90.22 E-.08769
G1 X95.431 Y90.22 E-.22069
G1 X95.431 Y90.376 E-.02952
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X98.669 Y90.22 Z6.12 F18000
G1 Z5.72
G1 E.4 F1800
G1 F1500
M204 S500
G1 X99.831 Y90.22 E.02458
G1 X99.831 Y90.682 E.00977
G1 X98.669 Y90.682 E.02458
G1 X98.669 Y90.28 E.0085
; WIPE_START
M204 S6000
G1 X99.831 Y90.22 E-.22098
G1 X99.831 Y90.682 E-.08769
G1 X99.455 Y90.682 E-.07132
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X98.638 Y94.889 Z6.12 F18000
G1 Z5.72
G1 E.4 F1800
G1 F1500
M204 S500
G1 X99.407 Y94.12 E.02301
G1 X99.407 Y95.357 E.02619
G1 X98.169 Y95.357 E.02619
G1 X98.595 Y94.931 E.01276
M204 S10000
G1 X98.338 Y94.589 F18000
G1 F1500
M204 S500
G1 X99.831 Y93.096 E.04469
G1 X99.831 Y95.782 E.05685
G1 X97.145 Y95.782 E.05685
G1 X98.295 Y94.631 E.03444
; WIPE_START
M204 S6000
G1 X99.71 Y93.217 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X96.569 Y87.944 Z6.12 F18000
G1 Z5.72
G1 E.4 F1800
G1 F1500
M204 S500
G1 X97.531 Y87.944 E.02035
G1 X97.05 Y88.425 E.01439
G1 X96.612 Y87.987 E.01312
; WIPE_START
M204 S6000
G1 X97.531 Y87.944 E-.17484
G1 X97.05 Y88.425 E-.1292
G1 X96.767 Y88.143 E-.07596
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X94.693 Y94.12 Z6.12 F18000
G1 Z5.72
G1 E.4 F1800
G1 F1500
M204 S500
G1 X95.931 Y95.357 E.03704
G1 X94.693 Y95.357 E.02619
G1 X94.693 Y94.18 E.02492
; WIPE_START
M204 S6000
G1 X95.931 Y95.357 E-.32452
G1 X95.639 Y95.357 E-.05549
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X89.259 Y98.086 Z6.12 F18000
G1 Z5.72
G1 E.4 F1800
G1 F1500
M204 S500
G1 X89.138 Y98.001 E.00312
G1 X88.663 Y97.764 E.01123
G1 X88.154 Y97.615 E.01123
G1 X87.778 Y97.564 E.00804
G1 X87.406 Y97.558 E.00787
G1 X86.873 Y97.629 E.01139
G1 X86.351 Y97.799 E.01161
G1 X85.878 Y98.055 E.01138
G1 X85.581 Y98.278 E.00787
G1 X85.306 Y98.54 E.00803
G1 X84.991 Y98.948 E.0109
G1 X84.788 Y99.312 E.00882
G1 X84.598 Y99.262 E.00416
G1 X84.593 Y95.842 E.07239
G1 X90.507 Y95.837 E.12519
G1 X90.502 Y99.262 E.07249
G1 X90.301 Y99.305 E.00436
G1 X90.063 Y98.879 E.01032
G1 X89.732 Y98.475 E.01105
G1 X89.449 Y98.22 E.00806
G1 X89.308 Y98.121 E.00365
M204 S10000
G1 X89.014 Y98.433 F18000
G1 F1500
M204 S500
G1 X89.184 Y98.552 E.00439
G1 X89.424 Y98.769 E.00684
G1 X89.714 Y99.123 E.0097
G1 X89.876 Y99.394 E.00667
G1 X90.007 Y99.689 E.00682
G1 X90.13 Y100.133 E.00975
G1 X90.172 Y100.601 E.00995
G1 X90.13 Y101.069 E.00995
G1 X90.004 Y101.523 E.00997
G1 X89.801 Y101.944 E.0099
G1 X89.623 Y102.204 E.00667
G1 X89.411 Y102.447 E.00683
G1 X89.058 Y102.745 E.00977
G1 X88.653 Y102.978 E.0099
G1 X88.359 Y103.093 E.00667
G1 X88.047 Y103.174 E.00682
G1 X87.589 Y103.222 E.00975
G1 X87.121 Y103.187 E.00995
G1 X86.675 Y103.071 E.00975
G1 X86.378 Y102.945 E.00682
G1 X86.105 Y102.787 E.00667
G1 X85.739 Y102.496 E.0099
G1 X85.429 Y102.141 E.00997
G1 X85.19 Y101.739 E.0099
G1 X85.07 Y101.448 E.00667
G1 X84.984 Y101.137 E.00682
G1 X84.929 Y100.679 E.00975
G1 X84.958 Y100.21 E.00995
G1 X85.067 Y99.763 E.00975
G1 X85.189 Y99.464 E.00683
G1 X85.346 Y99.182 E.00683
G1 X85.622 Y98.825 E.00956
G1 X85.856 Y98.602 E.00683
G1 X86.108 Y98.413 E.00667
G1 X86.519 Y98.19 E.0099
G1 X86.967 Y98.045 E.00998
G1 X87.431 Y97.983 E.0099
G1 X87.746 Y97.988 E.00667
G1 X88.066 Y98.031 E.00683
G1 X88.508 Y98.16 E.00975
G1 X88.92 Y98.367 E.00975
G1 X88.965 Y98.398 E.00117
M204 S250
G1 X88.779 Y98.768 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X88.928 Y98.873 E.00359
G1 X89.127 Y99.052 E.00527
G1 X89.379 Y99.359 E.00781
G1 X89.512 Y99.583 E.00513
G1 X89.621 Y99.827 E.00526
G1 X89.725 Y100.206 E.00774
G1 X89.761 Y100.601 E.00779
G1 X89.725 Y100.996 E.00779
G1 X89.62 Y101.378 E.0078
G1 X89.445 Y101.738 E.00787
G1 X89.299 Y101.953 E.00512
G1 X89.123 Y102.155 E.00526
G1 X88.822 Y102.409 E.00774
G1 X88.476 Y102.608 E.00787
G1 X88.233 Y102.703 E.00513
G1 X87.974 Y102.77 E.00526
G1 X87.583 Y102.811 E.00774
G1 X87.188 Y102.782 E.0078
G1 X86.807 Y102.683 E.00773
G1 X86.561 Y102.578 E.00526
G1 X86.336 Y102.448 E.00513
G1 X86.022 Y102.199 E.00787
G1 X85.761 Y101.9 E.0078
G1 X85.557 Y101.556 E.00787
G1 X85.458 Y101.315 E.00512
G1 X85.387 Y101.057 E.00526
G1 X85.34 Y100.667 E.00773
G1 X85.364 Y100.271 E.0078
G1 X85.457 Y99.889 E.00773
G1 X85.559 Y99.642 E.00526
G1 X85.689 Y99.408 E.00526
G1 X85.927 Y99.1 E.00767
G1 X86.121 Y98.915 E.00526
G1 X86.329 Y98.758 E.00512
G1 X86.681 Y98.568 E.00787
G1 X87.058 Y98.445 E.00781
G1 X87.455 Y98.393 E.00787
G1 X87.715 Y98.397 E.00512
G1 X87.98 Y98.433 E.00526
G1 X88.358 Y98.543 E.00773
G1 X88.709 Y98.719 E.00774
G1 X88.73 Y98.733 E.00049
; WIPE_START
M204 S6000
G1 X88.928 Y98.873 E-.04612
G1 X89.127 Y99.052 E-.05087
G1 X89.379 Y99.359 E-.07541
G1 X89.512 Y99.583 E-.04951
G1 X89.621 Y99.827 E-.0508
G1 X89.725 Y100.206 E-.07473
G1 X89.741 Y100.377 E-.03257
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X93.094 Y93.52 Z6.12 F18000
G1 X95.869 Y87.844 Z6.12
G1 Z5.72
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X95.869 Y87.52 E.00686
G1 X96.869 Y87.52 E.02117
G1 X96.869 Y77.382 E.21459
G1 X94.583 Y77.382 E.0484
G1 X94.514 Y77.05 E.00717
G1 X94.373 Y76.788 E.0063
G1 X94.163 Y76.578 E.00629
G1 X93.901 Y76.437 E.0063
G1 X93.637 Y76.382 E.00571
G1 X81.496 Y76.382 E.25697
G1 X81.198 Y76.434 E.0064
G1 X80.897 Y76.608 E.00736
G1 X80.687 Y76.844 E.00669
G1 X80.542 Y77.18 E.00776
G1 X80.531 Y94.437 E.36524
G1 X80.555 Y94.646 E.00446
G1 X80.672 Y94.939 E.00669
G1 X80.961 Y95.246 E.00893
G1 X81.256 Y95.384 E.00689
G1 X81.505 Y95.42 E.00533
G1 X94.269 Y95.41 E.27016
G1 X94.269 Y93.096 E.04898
G1 X96.955 Y95.782 E.08039
G1 X90.932 Y95.782 E.12749
G1 X90.924 Y100.801 E.10623
G1 X90.876 Y101.199 E.00848
G1 X90.782 Y101.588 E.00848
G1 X90.643 Y101.963 E.00847
G1 X90.46 Y102.319 E.00847
G1 X90.111 Y102.807 E.01269
G1 X89.68 Y103.225 E.0127
G1 X89.344 Y103.465 E.00876
G1 X88.829 Y103.73 E.01225
G1 X88.255 Y103.907 E.01271
G1 X87.838 Y103.968 E.00893
G1 X87.25 Y103.968 E.01244
G1 X86.659 Y103.861 E.0127
G1 X86.28 Y103.733 E.00847
G1 X85.918 Y103.561 E.00848
G1 X85.58 Y103.347 E.00847
G1 X85.269 Y103.094 E.00848
G1 X84.99 Y102.807 E.00847
G1 X84.747 Y102.489 E.00848
G1 X84.543 Y102.144 E.00848
G1 X84.32 Y101.597 E.01251
G1 X84.224 Y101.199 E.00867
G1 X84.176 Y100.801 E.00849
G1 X84.168 Y95.783 E.10621
G1 X81.479 Y95.778 E.05691
G1 X81.223 Y95.741 E.00548
G1 X80.931 Y95.634 E.00659
G1 X80.792 Y95.554 E.00339
G1 X80.67 Y95.463 E.00321
G1 X80.491 Y95.285 E.00534
G1 X80.317 Y95.02 E.00671
G1 X80.207 Y94.719 E.00678
G1 X80.169 Y94.383 E.00717
G1 X80.169 Y77.419 E.35905
G1 X80.206 Y77.092 E.00697
G1 X80.284 Y76.855 E.00529
G1 X80.4 Y76.64 E.00515
G1 X80.488 Y76.521 E.00315
G1 X80.664 Y76.345 E.00526
G1 X80.868 Y76.202 E.00528
G1 X81.003 Y76.134 E.0032
G1 X81.146 Y76.082 E.00321
G1 X81.399 Y76.03 E.00547
G1 X93.624 Y76.023 E.25876
G1 X93.946 Y76.079 E.00691
G1 X94.096 Y76.134 E.00339
G1 X94.367 Y76.289 E.0066
G1 X94.555 Y76.457 E.00534
G1 X94.657 Y76.578 E.00334
G1 X94.948 Y77.02 E.01121
G1 X97.231 Y77.02 E.04831
G1 X97.231 Y87.52 E.22224
G1 X98.231 Y87.52 E.02117
G1 X98.231 Y87.844 E.00686
G1 X97.05 Y89.025 E.03534
G1 X95.912 Y87.887 E.03407
; WIPE_START
M204 S6000
G1 X95.869 Y87.52 E-.07014
G1 X96.869 Y87.52 E-.19
G1 X96.869 Y86.889 E-.11986
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X94.84 Y91.091 Z6.12 F18000
G1 Z5.72
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X94.84 Y93.088 E.03928
G1 X97.05 Y95.298 E.06147
G1 X99.26 Y93.088 E.06147
G1 X99.26 Y91.091 E.03928
G1 X98.26 Y91.091 E.01967
G1 X98.26 Y89.811 E.02518
G1 X100.24 Y89.811 E.03895
G1 X100.24 Y96.191 E.12549
G1 X91.34 Y96.191 E.17505
G1 X91.333 Y100.825 E.09115
G1 X91.28 Y101.271 E.00883
G1 X91.174 Y101.708 E.00883
G1 X91.018 Y102.129 E.00883
G1 X90.813 Y102.528 E.00883
G1 X90.56 Y102.903 E.0089
G1 X90.421 Y103.075 E.00435
G1 X90.262 Y103.248 E.00462
G1 X89.938 Y103.543 E.00863
G1 X89.562 Y103.812 E.0091
G1 X89.177 Y104.024 E.00864
G1 X88.977 Y104.112 E.0043
G1 X88.558 Y104.254 E.0087
G1 X88.334 Y104.309 E.00455
G1 X87.873 Y104.376 E.00915
G1 X87.435 Y104.389 E.00863
G1 X87.213 Y104.376 E.00436
G1 X86.993 Y104.35 E.00436
G1 X86.551 Y104.256 E.00889
G1 X86.126 Y104.113 E.00883
G1 X85.72 Y103.92 E.00883
G1 X85.341 Y103.68 E.00883
G1 X84.992 Y103.397 E.00884
G1 X84.679 Y103.075 E.00883
G1 X84.407 Y102.718 E.00883
G1 X84.179 Y102.331 E.00883
G1 X83.996 Y101.917 E.0089
G1 X83.926 Y101.711 E.00429
G1 X83.82 Y101.271 E.00889
G1 X83.767 Y100.825 E.00883
G1 X83.76 Y96.191 E.09115
G1 X81.449 Y96.188 E.04545
G1 X81.134 Y96.141 E.00626
G1 X80.938 Y96.083 E.00403
G1 X80.747 Y96 E.0041
G1 X80.567 Y95.896 E.00409
G1 X80.402 Y95.774 E.00404
G1 X80.181 Y95.553 E.00613
G1 X80.055 Y95.384 E.00416
G1 X79.951 Y95.204 E.00409
G1 X79.868 Y95.013 E.00409
G1 X79.809 Y94.814 E.0041
G1 X79.772 Y94.609 E.00409
G1 X79.76 Y94.395 E.00422
G1 X79.76 Y77.407 E.33413
G1 X79.772 Y77.193 E.00421
G1 X79.808 Y76.991 E.00403
G1 X79.907 Y76.692 E.0062
G1 X80.053 Y76.42 E.00607
G1 X80.177 Y76.253 E.0041
G1 X80.4 Y76.03 E.00619
G1 X80.658 Y75.85 E.0062
G1 X80.841 Y75.758 E.00403
G1 X81.034 Y75.687 E.00403
G1 X81.345 Y75.623 E.00626
G1 X81.556 Y75.611 E.00415
G1 X93.648 Y75.614 E.23783
G1 X93.861 Y75.638 E.00422
G1 X94.063 Y75.686 E.00409
G1 X94.259 Y75.758 E.00409
G1 X94.445 Y75.851 E.00409
G1 X94.616 Y75.964 E.00404
G1 X94.849 Y76.171 E.00613
G1 X94.986 Y76.332 E.00416
G1 X95.169 Y76.611 E.00655
G1 X97.64 Y76.611 E.04861
G1 X97.64 Y87.111 E.20653
G1 X98.64 Y87.111 E.01967
G1 X98.64 Y88.014 E.01776
G1 X97.05 Y89.604 E.04423
G1 X95.46 Y88.014 E.04423
G1 X95.46 Y87.111 E.01776
G1 X96.46 Y87.111 E.01967
G1 X96.46 Y77.791 E.18332
G1 X94.16 Y77.791 E.04524
G1 X94.159 Y77.356 E.00856
G1 X94.125 Y77.192 E.0033
G1 X94.041 Y77.035 E.00349
G1 X93.916 Y76.91 E.00349
G1 X93.759 Y76.826 E.00349
G1 X93.595 Y76.792 E.00331
G1 X81.532 Y76.791 E.23727
G1 X81.34 Y76.825 E.00382
G1 X81.159 Y76.929 E.00412
G1 X81.037 Y77.067 E.00362
G1 X80.951 Y77.265 E.00425
G1 X80.94 Y94.413 E.33728
G1 X80.955 Y94.545 E.00261
G1 X81.023 Y94.716 E.00361
G1 X81.205 Y94.908 E.00521
G1 X81.375 Y94.987 E.00368
G1 X81.535 Y95.011 E.00318
G1 X93.86 Y95.001 E.24243
G1 X93.86 Y89.811 E.10209
G1 X95.84 Y89.811 E.03895
G1 X95.84 Y91.091 E.02518
G1 X94.9 Y91.091 E.01849
; WIPE_START
M204 S6000
G1 X94.84 Y93.088 E-.3796
G1 X94.842 Y93.089 E-.0004
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
M73 P95 R1
G1 X0 Y90 ; move to safe pos
G1 X-13.0 F3000 ; move to safe pos
M400
M1004 S5 P1  ; external shutter
M400 P300
M971 S11 C11 O0
G92 E0
G1 X0 F18000
M623

; SKIPTYPE: head_wrap_detect
M622.1 S1
M1002 judge_flag g39_3rd_layer_detect_flag
M622 J1
    ; enable nozzle clog detect at 3rd layer
    


    M622.1 S1
    M1002 judge_flag g39_detection_flag
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




G1 X94.35 Y92.887
G1 Z5.72
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.596522
G1 F1500
M204 S6000
G1 X94.35 Y90.886 E.05697
; WIPE_START
G1 X94.35 Y92.886 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X95.077 Y94.958 Z6.12 F18000
G1 Z5.72
G1 E.4 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.365752
G1 F1500
M204 S6000
G1 X95.013 Y94.995 E.00125
G1 X95.062 Y95.023 E.00095
; WIPE_START
G1 X95.013 Y94.995 E-.16436
G1 X95.077 Y94.958 E-.21564
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X99.065 Y94.958 Z6.12 F18000
G1 Z5.72
G1 E.4 F1800
G1 F1500
M204 S6000
G1 X99.002 Y94.995 E.00125
G1 X99.05 Y95.023 E.00095
; WIPE_START
G1 X99.002 Y94.995 E-.16436
G1 X99.065 Y94.958 E-.21564
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X99.75 Y92.887 Z6.12 F18000
G1 Z5.72
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.596522
G1 F1500
M204 S6000
G1 X99.75 Y90.886 E.05697
; WIPE_START
G1 X99.75 Y92.886 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X93.175 Y96.762 Z6.12 F18000
G1 X90.113 Y98.567 Z6.12
G1 Z5.72
G1 E.4 F1800
; LINE_WIDTH: 0.0949911
G1 F1500
M204 S6000
G1 X90.249 Y98.711 E.00069
G1 X90.271 Y98.775 E.00023
M204 S10000
G1 X90.443 Y99.492 F18000
; LINE_WIDTH: 0.476279
G1 F1500
M204 S6000
G1 X90.482 Y99.766 E.00623
; LINE_WIDTH: 0.430341
G1 X90.522 Y100.04 E.0056
; LINE_WIDTH: 0.403747
G1 X90.526 Y100.078 E.00071
; LINE_WIDTH: 0.376934
G1 X90.548 Y100.586 E.00891
; LINE_WIDTH: 0.361206
G1 X90.503 Y101.132 E.00916
G1 X90.351 Y101.669 E.00935
G1 X90.122 Y102.144 E.00883
G1 X89.927 Y102.431 E.0058
G1 X89.685 Y102.708 E.00616
G1 X89.262 Y103.061 E.00923
G1 X88.687 Y103.375 E.01096
G1 X88.127 Y103.544 E.0098
G1 X87.804 Y103.585 E.00545
G1 X87.449 Y103.596 E.00594
G1 X87.073 Y103.562 E.00632
G1 X86.761 Y103.49 E.00537
G1 X86.541 Y103.424 E.00383
G1 X86.218 Y103.286 E.00587
G1 X85.803 Y103.036 E.00812
G1 X85.489 Y102.78 E.00678
G1 X85.281 Y102.556 E.0051
G1 X85.115 Y102.35 E.00443
G1 X84.883 Y101.97 E.00746
G1 X84.711 Y101.56 E.00744
G1 X84.613 Y101.197 E.00628
G1 X84.557 Y100.778 E.00709
G1 X84.57 Y100.135 E.01076
; LINE_WIDTH: 0.415367
G1 X84.608 Y99.815 E.00627
; LINE_WIDTH: 0.464835
G1 X84.646 Y99.494 E.00707
M204 S10000
G1 X84.828 Y98.783 F18000
; LINE_WIDTH: 0.0867266
G1 F1500
M204 S6000
G1 X84.843 Y98.737 E.00015
G1 X84.924 Y98.647 E.00037
; WIPE_START
G1 X84.843 Y98.737 E-.27086
G1 X84.828 Y98.783 E-.10914
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X86.706 Y96.742 Z6.12 F18000
G1 Z5.72
G1 E.4 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.596902
G1 F1500
M204 S6000
G1 X87.007 Y96.722 E.0086
; LINE_WIDTH: 0.563674
G1 X87.308 Y96.702 E.0081
G1 X88.19 Y96.728 E.02367
; WIPE_START
G1 X87.308 Y96.702 E-.28317
G1 X87.007 Y96.722 E-.09683
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X86.706 Y96.742 Z6.12 F18000
G1 Z5.72
G1 E.4 F1800
; LINE_WIDTH: 0.598299
G1 F1500
M204 S6000
G1 X86.478 Y96.724 E.00654
; LINE_WIDTH: 0.561112
G1 X86.25 Y96.705 E.00611
; LINE_WIDTH: 0.507406
G1 X86.022 Y96.687 E.0055
G1 X85.44 Y96.687 E.01397
G1 X85.441 Y97.332 E.01549
G1 X85.965 Y97.045 E.01436
; LINE_WIDTH: 0.5264
G1 X86.291 Y96.912 E.00879
; LINE_WIDTH: 0.568535
G1 X86.617 Y96.778 E.00953
; LINE_WIDTH: 0.603247
G1 X86.65 Y96.765 E.00105
; WIPE_START
G1 X86.617 Y96.778 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X89.659 Y96.685 Z6.12 F18000
G1 Z5.72
G1 E.4 F1800
; LINE_WIDTH: 0.506822
G1 F1500
M204 S6000
G1 X88.958 Y96.685 E.01683
; LINE_WIDTH: 0.52098
G1 X88.675 Y96.7 E.007
; LINE_WIDTH: 0.549295
G1 X88.392 Y96.714 E.0074
; LINE_WIDTH: 0.579242
G1 X88.25 Y96.73 E.00396
; LINE_WIDTH: 0.57298
G1 X88.585 Y96.843 E.00965
; LINE_WIDTH: 0.511226
G1 X88.919 Y96.956 E.00856
G1 X89.531 Y97.251 E.01645
G1 X89.658 Y97.332 E.00365
G1 X89.659 Y96.745 E.01421
M204 S10000
G1 X90.098 Y96.247 F18000
; LINE_WIDTH: 0.419992
G1 F1500
M204 S6000
G1 X85.002 Y96.251 E.10021
G1 X85.006 Y98.172 E.03779
G1 X85.057 Y98.217 E.00134
G1 X85.636 Y97.725 E.01492
G1 X86.173 Y97.43 E.01207
G1 X86.765 Y97.234 E.01225
G1 X87.368 Y97.15 E.01197
G1 X88.213 Y97.21 E.01667
G1 X88.797 Y97.376 E.01193
G1 X89.335 Y97.642 E.01182
G1 X89.718 Y97.912 E.00921
G1 X89.962 Y98.147 E.00667
G1 X90.042 Y98.075 E.00211
G1 X90.095 Y98.08 E.00105
G1 X90.097 Y96.307 E.03487
; CHANGE_LAYER
; Z_HEIGHT: 5.84
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F1500
G1 X90.095 Y98.08 E-.33689
G1 X90.042 Y98.075 E-.01013
G1 X89.962 Y98.147 E-.02038
G1 X89.915 Y98.101 E-.0126
; WIPE_END
G1 E-.02 F1800
; layer num/total_layer_count: 48/49
; update layer progress
M73 L48
M991 S0 P47 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z6.12 I1.04 J.633 P1  F18000
G1 X94.431 Y90.682 Z6.12
G1 Z5.84
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X94.269 Y90.682 E.00342
G1 X94.269 Y90.22 E.00977
G1 X95.431 Y90.22 E.02458
G1 X95.431 Y90.682 E.00977
G1 X94.491 Y90.682 E.0199
; WIPE_START
M204 S6000
G1 X94.269 Y90.682 E-.04209
G1 X94.269 Y90.22 E-.08769
G1 X95.431 Y90.22 E-.22069
G1 X95.431 Y90.376 E-.02952
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X98.669 Y90.22 Z6.24 F18000
G1 Z5.84
G1 E.4 F1800
G1 F1500
M204 S500
G1 X99.831 Y90.22 E.02458
G1 X99.831 Y90.682 E.00977
G1 X98.669 Y90.682 E.02458
G1 X98.669 Y90.28 E.0085
; WIPE_START
M204 S6000
G1 X99.831 Y90.22 E-.22098
G1 X99.831 Y90.682 E-.08769
G1 X99.455 Y90.682 E-.07132
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X98.638 Y94.889 Z6.24 F18000
G1 Z5.84
G1 E.4 F1800
G1 F1500
M204 S500
G1 X99.407 Y94.12 E.02301
G1 X99.407 Y95.357 E.02619
G1 X98.169 Y95.357 E.02619
G1 X98.595 Y94.931 E.01276
M204 S10000
G1 X98.338 Y94.589 F18000
G1 F1500
M204 S500
G1 X99.831 Y93.096 E.04469
G1 X99.831 Y95.782 E.05685
G1 X97.145 Y95.782 E.05685
G1 X98.295 Y94.631 E.03444
; WIPE_START
M204 S6000
G1 X99.71 Y93.217 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X96.569 Y87.944 Z6.24 F18000
G1 Z5.84
G1 E.4 F1800
G1 F1500
M204 S500
G1 X97.531 Y87.944 E.02035
G1 X97.05 Y88.425 E.01439
G1 X96.612 Y87.987 E.01312
; WIPE_START
M204 S6000
G1 X97.531 Y87.944 E-.17484
G1 X97.05 Y88.425 E-.1292
G1 X96.767 Y88.143 E-.07596
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X94.693 Y94.12 Z6.24 F18000
G1 Z5.84
G1 E.4 F1800
G1 F1500
M204 S500
G1 X95.931 Y95.357 E.03704
G1 X94.693 Y95.357 E.02619
G1 X94.693 Y94.18 E.02492
; WIPE_START
M204 S6000
G1 X95.931 Y95.357 E-.32452
G1 X95.639 Y95.357 E-.05549
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X89.208 Y98.052 Z6.24 F18000
G1 Z5.84
G1 E.4 F1800
G1 F1500
M204 S500
G1 X88.993 Y97.919 E.00536
G1 X88.648 Y97.759 E.00804
G1 X88.154 Y97.615 E.01089
G1 X87.778 Y97.564 E.00804
G1 X87.403 Y97.558 E.00793
G1 X86.873 Y97.629 E.01133
G1 X86.352 Y97.798 E.01158
G1 X85.885 Y98.05 E.01123
G1 X85.581 Y98.278 E.00804
G1 X85.318 Y98.529 E.00771
G1 X85.086 Y98.811 E.00771
G1 X84.882 Y99.131 E.00804
G1 X84.8 Y99.316 E.00428
G1 X84.598 Y99.273 E.00436
G1 X84.593 Y95.842 E.07262
G1 X90.507 Y95.837 E.12519
G1 X90.502 Y99.262 E.07249
G1 X90.301 Y99.305 E.00436
G1 X90.058 Y98.872 E.0105
G1 X89.721 Y98.462 E.01124
G1 X89.316 Y98.119 E.01124
G1 X89.259 Y98.084 E.00141
M204 S10000
G1 X88.985 Y98.413 F18000
G1 F1500
M204 S500
G1 X89.066 Y98.463 E.00201
G1 X89.418 Y98.761 E.00975
G1 X89.71 Y99.117 E.00975
G1 X89.876 Y99.394 E.00683
G1 X90.005 Y99.684 E.00673
G1 X90.13 Y100.132 E.00985
G1 X90.172 Y100.601 E.00996
G1 X90.13 Y101.069 E.00995
G1 X90.005 Y101.522 E.00995
G1 X89.805 Y101.937 E.00975
G1 X89.623 Y102.204 E.00683
G1 X89.411 Y102.447 E.00683
G1 X89.059 Y102.745 E.00976
G1 X88.652 Y102.98 E.00994
G1 X88.218 Y103.135 E.00975
G1 X87.902 Y103.198 E.00683
G1 X87.58 Y103.222 E.00683
G1 X87.12 Y103.187 E.00976
G1 X86.67 Y103.07 E.00984
G1 X86.378 Y102.944 E.00673
G1 X86.098 Y102.783 E.00683
G1 X85.738 Y102.496 E.00975
G1 X85.429 Y102.142 E.00995
G1 X85.188 Y101.738 E.00995
G1 X85.026 Y101.307 E.00975
G1 X84.959 Y100.991 E.00683
G1 X84.93 Y100.67 E.00683
G1 X84.958 Y100.21 E.00975
G1 X85.069 Y99.753 E.00995
G1 X85.256 Y99.333 E.00975
G1 X85.43 Y99.061 E.00683
G1 X85.629 Y98.819 E.00664
G1 X85.856 Y98.602 E.00663
G1 X86.114 Y98.408 E.00683
G1 X86.52 Y98.19 E.00975
G1 X86.967 Y98.045 E.00996
G1 X87.428 Y97.983 E.00984
G1 X87.746 Y97.988 E.00673
G1 X88.066 Y98.031 E.00683
G1 X88.499 Y98.158 E.00955
G1 X88.792 Y98.293 E.00683
G1 X88.934 Y98.381 E.00355
M204 S250
G1 X88.77 Y98.761 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X88.825 Y98.795 E.00126
G1 X89.125 Y99.049 E.00774
G1 X89.375 Y99.353 E.00774
G1 X89.512 Y99.583 E.00526
G1 X89.619 Y99.823 E.00517
G1 X89.725 Y100.206 E.00782
G1 X89.761 Y100.601 E.0078
G1 X89.725 Y100.996 E.00779
G1 X89.62 Y101.378 E.0078
G1 X89.449 Y101.732 E.00773
G1 X89.299 Y101.953 E.00526
G1 X89.123 Y102.154 E.00526
G1 X88.823 Y102.409 E.00774
G1 X88.479 Y102.607 E.00779
G1 X88.109 Y102.74 E.00773
G1 X87.847 Y102.791 E.00526
G1 X87.58 Y102.811 E.00526
G1 X87.188 Y102.782 E.00774
G1 X86.803 Y102.681 E.00782
G1 X86.561 Y102.578 E.00517
G1 X86.33 Y102.444 E.00526
G1 X86.022 Y102.199 E.00773
G1 X85.761 Y101.9 E.00779
G1 X85.558 Y101.56 E.0078
G1 X85.42 Y101.192 E.00773
G1 X85.364 Y100.93 E.00526
G1 X85.34 Y100.664 E.00526
G1 X85.364 Y100.272 E.00773
G1 X85.458 Y99.886 E.0078
G1 X85.618 Y99.527 E.00773
G1 X85.762 Y99.302 E.00526
G1 X85.93 Y99.097 E.0052
G1 X86.121 Y98.915 E.0052
G1 X86.335 Y98.754 E.00526
G1 X86.681 Y98.568 E.00773
G1 X87.058 Y98.445 E.0078
G1 X87.452 Y98.393 E.00782
G1 X87.715 Y98.397 E.00517
G1 X87.98 Y98.433 E.00526
G1 X88.355 Y98.542 E.00767
G1 X88.597 Y98.654 E.00526
G1 X88.719 Y98.73 E.00282
; WIPE_START
M204 S6000
G1 X88.825 Y98.795 E-.02361
G1 X89.125 Y99.049 E-.07474
G1 X89.375 Y99.353 E-.07473
G1 X89.512 Y99.583 E-.05082
G1 X89.619 Y99.823 E-.04995
G1 X89.725 Y100.206 E-.07555
G1 X89.74 Y100.366 E-.03061
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X93.095 Y93.511 Z6.24 F18000
G1 X95.869 Y87.844 Z6.24
G1 Z5.84
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X95.869 Y87.52 E.00686
G1 X96.869 Y87.52 E.02117
G1 X96.869 Y77.382 E.21459
G1 X94.583 Y77.382 E.0484
G1 X94.514 Y77.05 E.00716
G1 X94.373 Y76.788 E.0063
G1 X94.163 Y76.578 E.00629
G1 X93.901 Y76.437 E.0063
G1 X93.637 Y76.382 E.00571
G1 X81.496 Y76.382 E.25697
G1 X81.198 Y76.434 E.0064
G1 X80.897 Y76.608 E.00736
G1 X80.687 Y76.844 E.00668
G1 X80.542 Y77.18 E.00776
G1 X80.531 Y94.437 E.36524
G1 X80.555 Y94.646 E.00446
G1 X80.672 Y94.94 E.00669
G1 X80.961 Y95.246 E.00892
G1 X81.255 Y95.384 E.00688
G1 X81.505 Y95.42 E.00534
G1 X94.269 Y95.41 E.27016
G1 X94.269 Y93.096 E.04898
G1 X96.955 Y95.782 E.08039
G1 X90.932 Y95.782 E.12749
G1 X90.924 Y100.801 E.10623
G1 X90.876 Y101.199 E.00849
G1 X90.782 Y101.588 E.00848
G1 X90.643 Y101.963 E.00848
G1 X90.46 Y102.319 E.00846
G1 X90.231 Y102.658 E.00865
G1 X89.838 Y103.089 E.01234
G1 X89.355 Y103.459 E.0129
G1 X88.82 Y103.733 E.0127
G1 X88.256 Y103.907 E.0125
G1 X87.842 Y103.968 E.00885
G1 X87.25 Y103.968 E.01254
G1 X86.659 Y103.861 E.0127
G1 X86.28 Y103.733 E.00847
G1 X85.918 Y103.561 E.00848
G1 X85.58 Y103.347 E.00847
G1 X85.269 Y103.095 E.00848
G1 X84.99 Y102.807 E.00847
G1 X84.747 Y102.489 E.00848
G1 X84.543 Y102.144 E.00847
G1 X84.382 Y101.778 E.00848
G1 X84.262 Y101.386 E.00866
G1 X84.176 Y100.801 E.01253
G1 X84.168 Y95.783 E.10621
G1 X81.479 Y95.778 E.05692
G1 X81.227 Y95.742 E.0054
G1 X80.931 Y95.634 E.00667
M73 P96 R1
G1 X80.792 Y95.554 E.0034
G1 X80.67 Y95.463 E.0032
G1 X80.488 Y95.28 E.00547
G1 X80.317 Y95.02 E.00659
G1 X80.207 Y94.719 E.00678
G1 X80.169 Y94.383 E.00716
G1 X80.169 Y77.419 E.35906
G1 X80.206 Y77.092 E.00697
G1 X80.284 Y76.855 E.00528
G1 X80.402 Y76.636 E.00526
G1 X80.49 Y76.519 E.0031
G1 X80.67 Y76.339 E.00539
G1 X80.785 Y76.254 E.00302
G1 X81.012 Y76.131 E.00546
G1 X81.149 Y76.081 E.0031
G1 X81.399 Y76.03 E.00539
G1 X93.626 Y76.023 E.25881
G1 X93.946 Y76.079 E.00686
G1 X94.24 Y76.206 E.00678
G1 X94.374 Y76.294 E.0034
G1 X94.49 Y76.391 E.0032
G1 X94.662 Y76.585 E.00547
G1 X94.948 Y77.02 E.01103
G1 X97.231 Y77.02 E.04831
G1 X97.231 Y87.52 E.22224
G1 X98.231 Y87.52 E.02117
G1 X98.231 Y87.844 E.00686
G1 X97.05 Y89.025 E.03534
G1 X95.912 Y87.887 E.03407
; WIPE_START
M204 S6000
G1 X95.869 Y87.52 E-.07014
G1 X96.869 Y87.52 E-.19
G1 X96.869 Y86.889 E-.11986
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X94.84 Y91.091 Z6.24 F18000
G1 Z5.84
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X94.84 Y93.088 E.03928
G1 X97.05 Y95.298 E.06147
G1 X99.26 Y93.088 E.06147
G1 X99.26 Y91.091 E.03928
G1 X98.26 Y91.091 E.01967
G1 X98.26 Y89.811 E.02518
G1 X100.24 Y89.811 E.03895
G1 X100.24 Y96.191 E.12549
G1 X91.34 Y96.191 E.17505
G1 X91.333 Y100.825 E.09115
G1 X91.28 Y101.271 E.00883
G1 X91.174 Y101.708 E.00883
G1 X91.018 Y102.129 E.00883
G1 X90.813 Y102.528 E.00883
G1 X90.557 Y102.907 E.009
G1 X90.267 Y103.243 E.00873
G1 X90.11 Y103.395 E.00429
G1 X89.757 Y103.682 E.00895
G1 X89.573 Y103.806 E.00436
G1 X89.382 Y103.918 E.00436
G1 X88.974 Y104.113 E.00889
G1 X88.546 Y104.257 E.00889
G1 X88.334 Y104.309 E.00429
G1 X87.878 Y104.376 E.00906
G1 X87.435 Y104.389 E.00873
G1 X87.213 Y104.376 E.00436
G1 X86.993 Y104.35 E.00436
G1 X86.551 Y104.257 E.00889
G1 X86.126 Y104.113 E.00883
G1 X85.72 Y103.92 E.00883
G1 X85.341 Y103.68 E.00883
G1 X84.992 Y103.397 E.00883
G1 X84.679 Y103.075 E.00883
G1 X84.407 Y102.718 E.00883
G1 X84.179 Y102.331 E.00883
G1 X83.998 Y101.92 E.00883
G1 X83.866 Y101.488 E.00889
G1 X83.819 Y101.266 E.00446
G1 X83.767 Y100.825 E.00873
G1 X83.76 Y96.191 E.09115
G1 X81.449 Y96.188 E.04545
G1 X81.138 Y96.142 E.00618
G1 X80.938 Y96.083 E.00412
G1 X80.747 Y96 E.00409
G1 X80.567 Y95.896 E.00409
G1 X80.402 Y95.774 E.00403
G1 X80.177 Y95.549 E.00626
G1 X80.055 Y95.384 E.00403
G1 X79.951 Y95.204 E.00409
G1 X79.868 Y95.013 E.00409
G1 X79.809 Y94.814 E.00409
G1 X79.772 Y94.609 E.0041
G1 X79.76 Y94.395 E.00422
G1 X79.76 Y77.407 E.33413
G1 X79.772 Y77.193 E.00421
G1 X79.808 Y76.991 E.00404
G1 X79.907 Y76.692 E.0062
G1 X80.056 Y76.415 E.00619
G1 X80.18 Y76.25 E.00406
G1 X80.402 Y76.028 E.00617
G1 X80.564 Y75.907 E.00398
G1 X80.844 Y75.757 E.00625
G1 X81.038 Y75.686 E.00405
G1 X81.345 Y75.623 E.00617
G1 X81.556 Y75.611 E.00416
G1 X93.65 Y75.614 E.23787
G1 X93.861 Y75.638 E.00418
G1 X94.063 Y75.686 E.00409
G1 X94.259 Y75.758 E.00409
G1 X94.445 Y75.851 E.00409
G1 X94.619 Y75.965 E.00409
G1 X94.776 Y76.097 E.00403
G1 X94.987 Y76.335 E.00626
G1 X95.169 Y76.611 E.0065
G1 X97.64 Y76.611 E.04861
G1 X97.64 Y87.111 E.20653
G1 X98.64 Y87.111 E.01967
G1 X98.64 Y88.014 E.01776
G1 X97.05 Y89.604 E.04423
G1 X95.46 Y88.014 E.04423
G1 X95.46 Y87.111 E.01776
G1 X96.46 Y87.111 E.01967
G1 X96.46 Y77.791 E.18332
G1 X94.16 Y77.791 E.04524
G1 X94.159 Y77.356 E.00856
G1 X94.125 Y77.192 E.0033
G1 X94.041 Y77.035 E.00349
G1 X93.916 Y76.91 E.00349
G1 X93.759 Y76.826 E.00349
G1 X93.595 Y76.792 E.00331
G1 X81.532 Y76.791 E.23727
G1 X81.34 Y76.825 E.00382
G1 X81.159 Y76.929 E.00413
G1 X81.037 Y77.067 E.00361
G1 X80.951 Y77.265 E.00425
G1 X80.94 Y94.413 E.33728
G1 X80.955 Y94.545 E.00261
G1 X81.023 Y94.716 E.00361
G1 X81.205 Y94.908 E.00521
G1 X81.374 Y94.987 E.00368
G1 X81.535 Y95.011 E.00319
G1 X93.86 Y95.001 E.24243
G1 X93.86 Y89.811 E.10209
G1 X95.84 Y89.811 E.03895
G1 X95.84 Y91.091 E.02518
G1 X94.9 Y91.091 E.01849
; WIPE_START
M204 S6000
G1 X94.84 Y93.088 E-.3796
G1 X94.842 Y93.089 E-.0004
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




G1 X94.35 Y92.887
G1 Z5.84
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.596522
G1 F1500
M204 S6000
G1 X94.35 Y90.886 E.05697
; WIPE_START
G1 X94.35 Y92.886 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X95.077 Y94.958 Z6.24 F18000
G1 Z5.84
G1 E.4 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.365752
G1 F1500
M204 S6000
G1 X95.013 Y94.995 E.00125
G1 X95.062 Y95.023 E.00095
; WIPE_START
M73 P96 R0
G1 X95.013 Y94.995 E-.16436
G1 X95.077 Y94.958 E-.21564
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X99.065 Y94.958 Z6.24 F18000
G1 Z5.84
G1 E.4 F1800
G1 F1500
M204 S6000
G1 X99.002 Y94.995 E.00125
G1 X99.05 Y95.023 E.00095
; WIPE_START
G1 X99.002 Y94.995 E-.16436
G1 X99.065 Y94.958 E-.21564
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X99.75 Y92.887 Z6.24 F18000
G1 Z5.84
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.596522
G1 F1500
M204 S6000
G1 X99.75 Y90.886 E.05697
; WIPE_START
G1 X99.75 Y92.886 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X93.26 Y96.903 Z6.24 F18000
G1 X90.291 Y98.741 Z6.24
G1 Z5.84
G1 E.4 F1800
; LINE_WIDTH: 0.102315
G1 F1500
M204 S6000
G1 X90.066 Y98.508 E.00124
; WIPE_START
G1 X90.291 Y98.741 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X90.443 Y99.492 Z6.24 F18000
G1 Z5.84
G1 E.4 F1800
; LINE_WIDTH: 0.47619
G1 F1500
M204 S6000
G1 X90.482 Y99.766 E.00622
; LINE_WIDTH: 0.430354
G1 X90.522 Y100.04 E.00559
; LINE_WIDTH: 0.403828
G1 X90.526 Y100.077 E.00071
; LINE_WIDTH: 0.376965
G1 X90.548 Y100.586 E.00892
; LINE_WIDTH: 0.361141
G1 X90.503 Y101.132 E.00916
G1 X90.352 Y101.668 E.00933
G1 X90.134 Y102.126 E.00848
G1 X89.93 Y102.427 E.00609
G1 X89.685 Y102.708 E.00623
G1 X89.288 Y103.047 E.00875
G1 X89.007 Y103.218 E.0055
G1 X88.678 Y103.377 E.00611
G1 X88.178 Y103.532 E.00877
G1 X87.809 Y103.587 E.00624
G1 X87.449 Y103.596 E.00602
G1 X87.073 Y103.562 E.00633
G1 X86.761 Y103.49 E.00536
G1 X86.536 Y103.422 E.00392
G1 X86.218 Y103.286 E.0058
G1 X85.803 Y103.036 E.0081
G1 X85.488 Y102.779 E.0068
G1 X85.281 Y102.556 E.00509
G1 X85.116 Y102.352 E.0044
G1 X84.883 Y101.97 E.00748
G1 X84.743 Y101.646 E.0059
G1 X84.671 Y101.423 E.00392
G1 X84.599 Y101.133 E.005
G1 X84.557 Y100.778 E.00599
G1 X84.57 Y100.135 E.01075
; LINE_WIDTH: 0.415084
G1 X84.608 Y99.818 E.00621
; LINE_WIDTH: 0.464047
G1 X84.646 Y99.5 E.00699
; WIPE_START
G1 X84.608 Y99.818 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X86.706 Y96.742 Z6.24 F18000
G1 Z5.84
G1 E.4 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.597072
G1 F1500
M204 S6000
G1 X87.005 Y96.722 E.00855
; LINE_WIDTH: 0.56378
G1 X87.304 Y96.702 E.00805
G1 X88.19 Y96.728 E.02377
; WIPE_START
G1 X87.304 Y96.702 E-.28386
G1 X87.005 Y96.722 E-.09614
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X86.706 Y96.742 Z6.24 F18000
G1 Z5.84
G1 E.4 F1800
; LINE_WIDTH: 0.598437
G1 F1500
M204 S6000
G1 X86.478 Y96.724 E.00652
; LINE_WIDTH: 0.561167
G1 X86.251 Y96.705 E.0061
; LINE_WIDTH: 0.507331
G1 X86.023 Y96.687 E.00549
G1 X85.44 Y96.687 E.01401
G1 X85.441 Y97.332 E.01549
G1 X85.968 Y97.044 E.01443
; LINE_WIDTH: 0.526377
G1 X86.292 Y96.911 E.00875
; LINE_WIDTH: 0.568607
G1 X86.616 Y96.779 E.00949
; LINE_WIDTH: 0.603397
G1 X86.65 Y96.765 E.00105
; WIPE_START
G1 X86.616 Y96.779 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X89.656 Y96.688 Z6.24 F18000
G1 Z5.84
G1 E.4 F1800
; LINE_WIDTH: 0.512362
G1 F1500
M204 S6000
G1 X88.939 Y96.688 E.01741
; LINE_WIDTH: 0.525615
G1 X88.666 Y96.702 E.00682
; LINE_WIDTH: 0.55212
G1 X88.392 Y96.715 E.00719
; LINE_WIDTH: 0.580202
G1 X88.25 Y96.73 E.00397
; LINE_WIDTH: 0.574365
G1 X88.576 Y96.839 E.00942
; LINE_WIDTH: 0.516351
G1 X88.902 Y96.948 E.00842
G1 X89.655 Y97.338 E.02076
G1 X89.656 Y96.748 E.01445
M204 S10000
G1 X90.098 Y96.247 F18000
; LINE_WIDTH: 0.419992
G1 F1500
M204 S6000
G1 X85.002 Y96.251 E.10021
G1 X85.007 Y98.261 E.03953
G1 X85.643 Y97.72 E.01642
G1 X86.175 Y97.429 E.01193
G1 X86.764 Y97.234 E.01221
G1 X87.364 Y97.151 E.01191
G1 X88.213 Y97.21 E.01674
G1 X88.778 Y97.371 E.01156
G1 X89.535 Y97.773 E.01684
M73 P97 R0
G1 X89.906 Y98.093 E.00964
G1 X90.005 Y98.004 E.00261
G1 X90.095 Y98.016 E.00178
G1 X90.097 Y96.307 E.03361
; CHANGE_LAYER
; Z_HEIGHT: 5.96
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F1500
G1 X90.095 Y98.016 E-.3247
G1 X90.005 Y98.004 E-.01723
G1 X89.906 Y98.093 E-.02519
G1 X89.855 Y98.049 E-.01288
; WIPE_END
G1 E-.02 F1800
; layer num/total_layer_count: 49/49
; update layer progress
M73 L49
M991 S0 P48 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z6.24 I-.664 J-1.02 P1  F18000
G1 X88.765 Y98.758 Z6.24
G1 Z5.96
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X88.825 Y98.795 E.00139
G1 X89.123 Y99.047 E.00768
G1 X89.299 Y99.249 E.00526
G1 X89.449 Y99.47 E.00526
G1 X89.62 Y99.824 E.00774
G1 X89.725 Y100.206 E.00779
G1 X89.761 Y100.598 E.00775
G1 X89.745 Y100.865 E.00526
G1 X89.697 Y101.126 E.00522
G1 X89.569 Y101.501 E.00779
G1 X89.377 Y101.846 E.00778
G1 X89.125 Y102.153 E.0078
G1 X88.825 Y102.407 E.00773
G1 X88.598 Y102.547 E.00526
G1 X88.355 Y102.66 E.00526
G1 X87.977 Y102.77 E.00774
G1 X87.583 Y102.811 E.0078
G1 X87.188 Y102.782 E.00779
G1 X86.807 Y102.683 E.00774
G1 X86.561 Y102.578 E.00526
G1 X86.331 Y102.445 E.00523
G1 X86.025 Y102.201 E.00771
G1 X85.843 Y102.005 E.00526
G1 X85.685 Y101.788 E.00527
G1 X85.504 Y101.439 E.00773
G1 X85.387 Y101.06 E.0078
G1 X85.34 Y100.667 E.00779
G1 X85.364 Y100.271 E.0078
G1 X85.458 Y99.886 E.0078
G1 X85.618 Y99.527 E.00773
G1 X85.762 Y99.301 E.00526
G1 X85.93 Y99.097 E.0052
G1 X86.121 Y98.915 E.0052
G1 X86.333 Y98.755 E.00523
G1 X86.681 Y98.568 E.00777
G1 X87.058 Y98.445 E.00779
G1 X87.45 Y98.393 E.00777
G1 X87.715 Y98.397 E.00522
G1 X87.98 Y98.433 E.00526
G1 X88.355 Y98.542 E.00767
G1 X88.598 Y98.654 E.00526
G1 X88.714 Y98.726 E.00268
; WIPE_START
M204 S6000
G1 X88.825 Y98.795 E-.02487
G1 X89.123 Y99.047 E-.07418
G1 X89.299 Y99.249 E-.05078
G1 X89.449 Y99.47 E-.05078
G1 X89.62 Y99.824 E-.07475
G1 X89.725 Y100.206 E-.0752
G1 X89.739 Y100.36 E-.02944
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X93.419 Y93.673 Z6.36 F18000
G1 X94.84 Y91.091 Z6.36
G1 Z5.96
G1 E.4 F1800
G1 F1500
M204 S500
G1 X94.84 Y93.088 E.03928
G1 X97.05 Y95.298 E.06147
G1 X99.26 Y93.088 E.06147
G1 X99.26 Y91.091 E.03928
G1 X98.26 Y91.091 E.01967
G1 X98.26 Y89.811 E.02518
G1 X100.24 Y89.811 E.03895
G1 X100.24 Y96.191 E.12549
G1 X91.34 Y96.191 E.17505
G1 X91.34 Y100.594 E.08661
G1 X91.313 Y101.049 E.00896
G1 X91.234 Y101.491 E.00883
G1 X91.102 Y101.92 E.00883
G1 X90.92 Y102.334 E.00889
G1 X90.813 Y102.529 E.00437
G1 X90.56 Y102.903 E.00888
G1 X90.421 Y103.075 E.00436
G1 X90.271 Y103.238 E.00436
G1 X89.941 Y103.541 E.00882
G1 X89.573 Y103.805 E.00891
G1 X89.177 Y104.024 E.00889
G1 X88.974 Y104.113 E.00436
G1 X88.767 Y104.19 E.00436
G1 X88.334 Y104.308 E.00881
G1 X87.886 Y104.376 E.00891
G1 X87.435 Y104.389 E.00889
G1 X87.214 Y104.376 E.00435
G1 X86.99 Y104.349 E.00443
G1 X86.551 Y104.257 E.00881
G1 X86.126 Y104.113 E.00883
G1 X85.72 Y103.92 E.00883
G1 X85.341 Y103.68 E.00883
G1 X84.992 Y103.397 E.00883
G1 X84.679 Y103.075 E.00883
G1 X84.407 Y102.718 E.00883
G1 X84.179 Y102.331 E.00883
G1 X83.998 Y101.92 E.00883
G1 X83.866 Y101.487 E.00891
G1 X83.786 Y101.046 E.00881
G1 X83.767 Y100.828 E.00431
G1 X83.76 Y96.191 E.09121
G1 X81.449 Y96.188 E.04544
G1 X81.134 Y96.141 E.00626
G1 X80.938 Y96.083 E.00403
G1 X80.747 Y96 E.0041
G1 X80.567 Y95.896 E.00409
G1 X80.4 Y95.772 E.00409
G1 X80.248 Y95.629 E.00409
G1 X80.114 Y95.47 E.00409
G1 X80.002 Y95.298 E.00404
G1 X79.868 Y95.012 E.00622
G1 X79.809 Y94.813 E.00407
G1 X79.772 Y94.609 E.00409
G1 X79.76 Y94.395 E.00422
G1 X79.76 Y77.407 E.33413
G1 X79.772 Y77.193 E.00421
G1 X79.808 Y76.991 E.00404
G1 X79.907 Y76.692 E.0062
G1 X80.055 Y76.418 E.00613
G1 X80.25 Y76.171 E.00619
G1 X80.397 Y76.032 E.00398
G1 X80.658 Y75.85 E.00625
G1 X80.841 Y75.758 E.00404
G1 X81.034 Y75.687 E.00403
G1 X81.345 Y75.623 E.00625
G1 X81.556 Y75.611 E.00416
G1 X93.652 Y75.614 E.23792
G1 X93.861 Y75.638 E.00413
G1 X94.063 Y75.686 E.00409
G1 X94.259 Y75.758 E.0041
G1 X94.445 Y75.851 E.00409
G1 X94.616 Y75.964 E.00403
G1 X94.852 Y76.174 E.00621
G1 X94.986 Y76.332 E.00407
G1 X95.169 Y76.611 E.00656
G1 X97.64 Y76.611 E.04861
G1 X97.64 Y87.111 E.20653
G1 X98.64 Y87.111 E.01967
G1 X98.64 Y88.014 E.01776
G1 X97.05 Y89.604 E.04423
G1 X95.46 Y88.014 E.04423
G1 X95.46 Y87.111 E.01776
G1 X96.46 Y87.111 E.01967
G1 X96.46 Y77.791 E.18332
G1 X94.16 Y77.791 E.04524
G1 X94.159 Y77.356 E.00856
G1 X94.125 Y77.192 E.0033
G1 X94.041 Y77.035 E.00349
G1 X93.916 Y76.91 E.00349
G1 X93.759 Y76.826 E.00349
G1 X93.595 Y76.792 E.00331
G1 X81.532 Y76.791 E.23727
G1 X81.34 Y76.825 E.00382
G1 X81.156 Y76.931 E.00419
G1 X81.021 Y77.092 E.00413
G1 X80.951 Y77.269 E.00374
G1 X80.94 Y94.425 E.33746
G1 X80.997 Y94.668 E.0049
G1 X81.103 Y94.818 E.00362
G1 X81.217 Y94.914 E.00292
G1 X81.374 Y94.987 E.00343
G1 X81.535 Y95.011 E.00319
G1 X93.86 Y95.001 E.24243
G1 X93.86 Y89.811 E.10209
G1 X95.84 Y89.811 E.03895
G1 X95.84 Y91.091 E.02518
G1 X94.9 Y91.091 E.01849
; WIPE_START
M204 S6000
G1 X94.84 Y93.088 E-.3796
G1 X94.842 Y93.089 E-.0004
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




G1 X94.35 Y92.887
G1 Z5.96
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.596522
G1 F1500
M204 S6000
G1 X94.35 Y90.886 E.05697
; WIPE_START
G1 X94.35 Y92.886 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X95.613 Y90.874 Z6.36 F18000
G1 Z5.96
G1 E.4 F1800
; FEATURE: Top surface
; LINE_WIDTH: 0.42
G1 F1500
M204 S2000
G1 X94.767 Y90.028 E.02354
G1 X94.209 Y90.028
G1 X94.851 Y90.67 E.01785
; WIPE_START
M204 S6000
G1 X94.209 Y90.028 E-.17247
G1 X94.767 Y90.028 E-.10593
G1 X95.145 Y90.406 E-.1016
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X99.75 Y90.886 Z6.36 F18000
G1 Z5.96
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.596522
G1 F1500
M204 S6000
G1 X99.75 Y92.887 E.05697
; WIPE_START
G1 X99.75 Y90.887 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X99.869 Y90.67 Z6.36 F18000
G1 Z5.96
G1 E.4 F1800
; FEATURE: Top surface
; LINE_WIDTH: 0.42
G1 F1500
M204 S2000
G1 X99.227 Y90.028 E.01785
G1 X98.67 Y90.028
G1 X99.311 Y90.67 E.01785
G1 X98.958 Y90.874
G1 X98.477 Y90.393 E.01339
M204 S10000
G1 X98.5 Y90.008 F18000
; FEATURE: Gap infill
; LINE_WIDTH: 0.111171
G1 F1500
M204 S6000
G1 X98.5 Y90.37 E.00154
; WIPE_START
G1 X98.5 Y90.008 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X97.838 Y82.404 Z6.36 F18000
G1 X97.423 Y77.631 Z6.36
G1 Z5.96
G1 E.4 F1800
; FEATURE: Top surface
; LINE_WIDTH: 0.42
G1 F1500
M204 S2000
G1 X96.62 Y76.828 E.02233
G1 X96.063 Y76.828
G1 X97.423 Y78.188 E.03784
G1 X96.677 Y77.999
G1 X97.423 Y78.746 E.02076
G1 X97.423 Y79.303
G1 X96.677 Y78.557 E.02076
G1 X96.677 Y79.114
G1 X97.423 Y79.861 E.02076
G1 X97.423 Y80.418
G1 X96.677 Y79.672 E.02076
G1 X96.677 Y80.229
G1 X97.423 Y80.976 E.02076
G1 X97.423 Y81.533
G1 X96.677 Y80.787 E.02076
G1 X96.677 Y81.345
G1 X97.423 Y82.091 E.02076
G1 X97.423 Y82.648
G1 X96.677 Y81.902 E.02076
G1 X96.677 Y82.46
G1 X97.423 Y83.206 E.02076
G1 X97.423 Y83.764
G1 X96.677 Y83.017 E.02076
G1 X96.677 Y83.575
G1 X97.423 Y84.321 E.02076
G1 X97.423 Y84.879
G1 X96.677 Y84.132 E.02076
G1 X96.677 Y84.69
G1 X97.423 Y85.436 E.02076
G1 X97.423 Y85.994
G1 X96.677 Y85.247 E.02076
G1 X96.677 Y85.805
G1 X97.423 Y86.551 E.02076
G1 X97.423 Y87.109
G1 X96.677 Y86.362 E.02076
; WIPE_START
M204 S6000
G1 X97.423 Y87.109 E-.20055
G1 X97.423 Y86.551 E-.10593
G1 X97.15 Y86.278 E-.07352
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X97.642 Y87.328 Z6.36 F18000
G1 Z5.96
G1 E.4 F1800
G1 F1500
M204 S2000
G1 X98.331 Y88.016 E.01916
G1 X98.052 Y88.295
G1 X96.677 Y86.92 E.03825
G1 X96.527 Y87.328
G1 X97.773 Y88.574 E.03467
G1 X97.495 Y88.853
G1 X95.969 Y87.328 E.04242
G1 X95.677 Y87.593
G1 X97.216 Y89.132 E.04281
; WIPE_START
M204 S6000
G1 X95.802 Y87.717 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X99.516 Y93.104 Z6.36 F18000
G1 Z5.96
G1 E.4 F1800
G1 F1500
M204 S2000
G1 X100.023 Y93.612 E.01412
G1 X100.023 Y94.169
G1 X99.254 Y93.4 E.02139
G1 X98.976 Y93.679
G1 X100.023 Y94.727 E.02914
G1 X100.023 Y95.284
G1 X98.697 Y93.958 E.0369
G1 X98.418 Y94.237
G1 X100.023 Y95.842 E.04465
G1 X99.598 Y95.974
G1 X98.139 Y94.515 E.04058
G1 X97.86 Y94.794
G1 X99.04 Y95.974 E.03282
G1 X98.483 Y95.974
G1 X97.582 Y95.073 E.02507
G1 X97.303 Y95.352
G1 X97.925 Y95.974 E.01731
G1 X97.368 Y95.974
G1 X94.498 Y93.104 E.07984
; WIPE_START
M204 S6000
G1 X95.912 Y94.518 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X96.81 Y95.974 Z6.36 F18000
G1 Z5.96
G1 E.4 F1800
G1 F1500
M204 S2000
G1 X94.077 Y93.241 E.07603
G1 X94.077 Y93.798
G1 X96.253 Y95.974 E.06053
G1 X95.695 Y95.974
G1 X94.077 Y94.356 E.04502
G1 X94.077 Y94.913
G1 X95.138 Y95.974 E.02951
G1 X94.58 Y95.974
G1 X93.824 Y95.218 E.02103
G1 X93.267 Y95.218
G1 X94.023 Y95.974 E.02102
G1 X93.465 Y95.974
G1 X92.71 Y95.219 E.02101
G1 X92.153 Y95.219
G1 X92.908 Y95.974 E.02099
G1 X92.35 Y95.974
G1 X91.596 Y95.22 E.02098
G1 X91.039 Y95.22
G1 X91.792 Y95.974 E.02097
G1 X91.235 Y95.974
G1 X90.481 Y95.221 E.02096
G1 X89.924 Y95.221
G1 X91.123 Y96.42 E.03335
G1 X91.123 Y96.977
G1 X89.367 Y95.222 E.04884
G1 X88.81 Y95.222
G1 X91.123 Y97.535 E.06434
G1 X91.123 Y98.093
G1 X88.253 Y95.222 E.07984
G1 X87.696 Y95.223
G1 X91.123 Y98.65 E.09533
G1 X91.123 Y99.208
G1 X87.139 Y95.223 E.11083
G1 X86.582 Y95.224
G1 X91.123 Y99.765 E.12632
G1 X91.123 Y100.323
G1 X86.025 Y95.224 E.14182
G1 X85.468 Y95.225
G1 X88.715 Y98.472 E.09034
G1 X87.887 Y98.201
G1 X84.91 Y95.225 E.08278
G1 X84.353 Y95.225
G1 X87.319 Y98.191 E.0825
G1 X86.854 Y98.284
G1 X83.796 Y95.226 E.08506
G1 X83.239 Y95.226
G1 X86.456 Y98.443 E.08948
G1 X86.108 Y98.653
G1 X83.977 Y96.522 E.05929
G1 X83.978 Y97.08
G1 X85.81 Y98.912 E.05096
G1 X85.558 Y99.218
G1 X83.979 Y97.639 E.04393
G1 X83.98 Y98.197
G1 X85.359 Y99.576 E.03836
G1 X85.21 Y99.985
G1 X83.981 Y98.755 E.03421
G1 X83.981 Y99.314
G1 X85.135 Y100.467 E.03208
G1 X85.169 Y101.059
G1 X83.982 Y99.872 E.033
G1 X83.983 Y100.431
G1 X85.621 Y102.069 E.04556
; WIPE_START
M204 S6000
G1 X84.207 Y100.654 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X89.669 Y99.426 Z6.36 F18000
G1 Z5.96
G1 E.4 F1800
G1 F1500
M204 S2000
G1 X91.107 Y100.864 E.04
G1 X91.038 Y101.353
G1 X89.948 Y100.263 E.03032
G1 X89.964 Y100.836
G1 X90.916 Y101.788 E.0265
G1 X90.751 Y102.181
G1 X89.868 Y101.297 E.02456
G1 X89.709 Y101.696
G1 X90.547 Y102.535 E.02332
G1 X90.316 Y102.86
G1 X89.497 Y102.042 E.02278
G1 X89.238 Y102.341
G1 X90.047 Y103.15 E.0225
G1 X89.751 Y103.411
G1 X88.934 Y102.594 E.02271
G1 X88.578 Y102.795
G1 X89.423 Y103.64 E.02351
G1 X89.062 Y103.837
M73 P98 R0
G1 X88.166 Y102.941 E.02494
G1 X87.686 Y103.019
G1 X88.662 Y103.994 E.02713
G1 X88.217 Y104.107
G1 X87.091 Y102.981 E.03132
G1 X86.054 Y102.501
G1 X87.716 Y104.164 E.04624
G1 X87.144 Y104.149
G1 X84.001 Y101.006 E.08744
G1 X84.166 Y101.728
G1 X86.421 Y103.984 E.06274
; WIPE_START
M204 S6000
G1 X85.007 Y102.569 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X83.429 Y95.974 Z6.36 F18000
G1 Z5.96
G1 E.4 F1800
G1 F1500
M204 S2000
G1 X82.682 Y95.227 E.02078
G1 X82.125 Y95.227
G1 X82.871 Y95.973 E.02074
G1 X82.312 Y95.972
G1 X81.568 Y95.228 E.02071
; WIPE_START
M204 S6000
G1 X82.312 Y95.972 E-.20002
G1 X82.871 Y95.973 E-.1061
G1 X82.596 Y95.698 E-.07388
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X87.189 Y89.602 Z6.36 F18000
G1 X96.252 Y77.574 Z6.36
G1 Z5.96
G1 E.4 F1800
G1 F1500
M204 S2000
G1 X95.505 Y76.828 E.02076
; WIPE_START
M204 S6000
G1 X96.252 Y77.574 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X94.022 Y75.902 Z6.36 F18000
G1 Z5.96
G1 E.4 F1800
G1 F1500
M204 S2000
G1 X95.694 Y77.574 E.0465
G1 X95.136 Y77.574
G1 X93.393 Y75.831 E.04849
G1 X92.836 Y75.831
G1 X93.58 Y76.575 E.02069
G1 X93.022 Y76.575
G1 X92.278 Y75.831 E.0207
G1 X91.72 Y75.83
G1 X92.464 Y76.575 E.0207
G1 X91.907 Y76.575
G1 X91.163 Y75.83 E.0207
G1 X90.605 Y75.83
G1 X91.349 Y76.575 E.02071
G1 X90.792 Y76.575
G1 X90.047 Y75.83 E.02071
G1 X89.49 Y75.83
G1 X90.234 Y76.575 E.02071
G1 X89.677 Y76.575
G1 X88.932 Y75.83 E.02072
G1 X88.374 Y75.83
G1 X89.119 Y76.574 E.02072
G1 X88.561 Y76.574
G1 X87.816 Y75.829 E.02072
G1 X87.259 Y75.829
G1 X88.004 Y76.574 E.02073
G1 X87.446 Y76.574
G1 X86.701 Y75.829 E.02073
G1 X86.143 Y75.829
G1 X86.889 Y76.574 E.02073
G1 X86.331 Y76.574
G1 X85.586 Y75.829 E.02074
G1 X85.028 Y75.829
G1 X85.774 Y76.574 E.02074
G1 X85.216 Y76.574
G1 X84.47 Y75.829 E.02074
G1 X83.913 Y75.828
G1 X84.658 Y76.574 E.02075
G1 X84.101 Y76.574
G1 X83.355 Y75.828 E.02075
G1 X82.797 Y75.828
G1 X83.543 Y76.574 E.02075
G1 X82.986 Y76.574
G1 X82.24 Y75.828 E.02076
G1 X81.682 Y75.828
G1 X82.428 Y76.574 E.02076
G1 X81.871 Y76.574
G1 X81.176 Y75.88 E.01932
G1 X80.773 Y76.034
G1 X81.343 Y76.604 E.01585
G1 X80.982 Y76.801
G1 X80.456 Y76.275 E.01463
G1 X80.21 Y76.587
G1 X80.767 Y77.143 E.01549
G1 X80.734 Y77.667
G1 X80.042 Y76.975 E.01925
G1 X79.977 Y77.468
G1 X80.733 Y78.225 E.02104
G1 X80.733 Y78.782
G1 X79.977 Y78.026 E.02103
G1 X79.977 Y78.583
G1 X80.733 Y79.339 E.02102
G1 X80.732 Y79.896
G1 X79.977 Y79.141 E.02101
G1 X79.977 Y79.698
G1 X80.732 Y80.453 E.021
G1 X80.732 Y81.01
G1 X79.977 Y80.256 E.021
G1 X79.977 Y80.813
G1 X80.731 Y81.568 E.02099
G1 X80.731 Y82.125
G1 X79.977 Y81.371 E.02098
G1 X79.977 Y81.928
G1 X80.731 Y82.682 E.02097
G1 X80.73 Y83.239
G1 X79.977 Y82.486 E.02096
G1 X79.977 Y83.043
G1 X80.73 Y83.796 E.02095
G1 X80.73 Y84.354
G1 X79.977 Y83.601 E.02094
G1 X79.977 Y84.158
G1 X80.729 Y84.911 E.02093
G1 X80.729 Y85.468
G1 X79.977 Y84.716 E.02092
G1 X79.977 Y85.274
G1 X80.728 Y86.025 E.02091
G1 X80.728 Y86.582
G1 X79.977 Y85.831 E.0209
G1 X79.977 Y86.389
G1 X80.728 Y87.14 E.02089
G1 X80.727 Y87.697
G1 X79.977 Y86.946 E.02088
G1 X79.977 Y87.504
G1 X80.727 Y88.254 E.02087
G1 X80.727 Y88.811
G1 X79.977 Y88.061 E.02086
G1 X79.977 Y88.619
G1 X80.726 Y89.368 E.02085
G1 X80.726 Y89.925
G1 X79.977 Y89.176 E.02084
G1 X79.977 Y89.734
G1 X80.726 Y90.483 E.02083
G1 X80.725 Y91.04
G1 X79.977 Y90.291 E.02082
G1 X79.977 Y90.849
G1 X80.725 Y91.597 E.02081
G1 X80.725 Y92.154
G1 X79.977 Y91.406 E.0208
G1 X79.977 Y91.964
G1 X80.724 Y92.711 E.02079
G1 X80.724 Y93.269
G1 X79.977 Y92.522 E.02078
G1 X79.977 Y93.079
G1 X80.724 Y93.826 E.02077
G1 X80.723 Y94.383
G1 X79.977 Y93.637 E.02076
G1 X79.977 Y94.194
G1 X81.754 Y95.971 E.04943
G1 X81.143 Y95.918
G1 X80.033 Y94.808 E.03086
; WIPE_START
M204 S6000
G1 X81.143 Y95.918 E-.29807
G1 X81.572 Y95.955 E-.08193
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X81.485 Y95.311 Z6.36 F18000
G1 Z5.96
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.0830679
G1 F1500
M204 S6000
G1 X81.264 Y95.175 E.00074
M204 S10000
G1 X81.583 Y95.213 F18000
; LINE_WIDTH: 0.0832607
G1 F1500
M204 S6000
G1 X81.358 Y95.296 E.00069
; WIPE_START
G1 X81.583 Y95.213 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X80.734 Y94.372 Z6.36 F18000
G1 Z5.96
G1 E.4 F1800
; LINE_WIDTH: 0.100349
G1 F1500
M204 S6000
G1 X80.657 Y94.595 E.00088
; WIPE_START
G1 X80.734 Y94.372 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X85.238 Y88.211 Z6.36 F18000
G1 X93.792 Y76.509 Z6.36
G1 Z5.96
G1 E.4 F1800
; LINE_WIDTH: 0.0734707
G1 F1500
M204 S6000
G1 X93.565 Y76.589 E.00057
M204 S10000
G1 X93.92 Y76.665 F18000
; LINE_WIDTH: 0.092278
G1 F1500
M204 S6000
G1 X93.662 Y76.493 E.00103
; WIPE_START
G1 X93.92 Y76.665 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X94.651 Y77.594 Z6.36 F18000
G1 Z5.96
G1 E.4 F1800
; LINE_WIDTH: 0.0943533
G1 F1500
M204 S6000
G1 X94.285 Y77.031 E.0023
M204 S10000
G1 X94.588 Y77.594 F18000
; LINE_WIDTH: 0.235743
G1 F1500
M204 S6000
G1 X94.326 Y77.043 E.00639
; WIPE_START
G1 X94.588 Y77.594 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X96.699 Y77.743 Z6.36 F18000
G1 Z5.96
G1 E.4 F1800
; LINE_WIDTH: 0.0854238
G1 F1500
M204 S6000
G1 X96.678 Y77.911 E.0005
M204 S10000
G1 X97.401 Y78.445 F18000
G1 F1500
M204 S6000
G1 X97.422 Y78.277 E.0005
; WIPE_START
G1 X97.401 Y78.445 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X97.512 Y86.076 Z6.36 F18000
G1 X97.532 Y87.438 Z6.36
G1 Z5.96
G1 E.4 F1800
; LINE_WIDTH: 0.107846
G1 F1500
M204 S6000
G1 X97.313 Y87.219 E.00127
; WIPE_START
G1 X97.532 Y87.438 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X97.07 Y89.305 Z6.36 F18000
G1 Z5.96
G1 E.4 F1800
; LINE_WIDTH: 0.0826529
G1 F1500
M204 S6000
G1 X95.657 Y87.892 E.00567
; WIPE_START
G1 X97.07 Y89.305 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X93.658 Y96.132 Z6.36 F18000
G1 X91.037 Y101.377 Z6.36
G1 Z5.96
G1 E.4 F1800
; LINE_WIDTH: 0.0857391
G1 F1500
M204 S6000
G1 X90.95 Y101.543 E.00056
M204 S10000
G1 X90.728 Y102.232 F18000
; LINE_WIDTH: 0.085096
G1 F1500
M204 S6000
G1 X90.64 Y102.349 E.00043
; WIPE_START
G1 X90.728 Y102.232 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X89.736 Y99.359 Z6.36 F18000
G1 Z5.96
G1 E.4 F1800
; LINE_WIDTH: 0.188065
G1 F1500
M204 S6000
G1 X89.507 Y99.083 E.0029
; LINE_WIDTH: 0.158245
G1 X89.3 Y98.862 E.002
G1 X88.982 Y98.569 E.00285
; LINE_WIDTH: 0.198974
G1 X88.779 Y98.409 E.00224
; WIPE_START
G1 X88.982 Y98.569 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X85.113 Y101.281 Z6.36 F18000
G1 Z5.96
G1 E.4 F1800
; LINE_WIDTH: 0.0879432
G1 F1500
M204 S6000
G1 X85.182 Y101.046 E.00076
; WIPE_START
G1 X85.113 Y101.281 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X85.991 Y102.564 Z6.36 F18000
G1 Z5.96
G1 E.4 F1800
; LINE_WIDTH: 0.217164
G1 F1500
M204 S6000
G1 X85.625 Y102.208 E.00488
G1 X85.631 Y102.058 E.00143
; WIPE_START
G1 X85.625 Y102.208 E-.08605
G1 X85.991 Y102.564 E-.29395
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X85.892 Y103.761 Z6.36 F18000
G1 Z5.96
G1 E.4 F1800
; LINE_WIDTH: 0.0816373
G1 F1500
M204 S6000
G1 X85.831 Y103.718 E.00021
; LINE_WIDTH: 0.113605
G1 X85.667 Y103.587 E.00092
; LINE_WIDTH: 0.160367
G1 X85.502 Y103.455 E.00142
; LINE_WIDTH: 0.214492
G1 X85.193 Y103.177 E.00391
G1 X84.903 Y102.882 E.0039
; LINE_WIDTH: 0.206828
G1 X84.766 Y102.725 E.00188
; LINE_WIDTH: 0.179062
G1 X84.629 Y102.569 E.00159
; LINE_WIDTH: 0.142143
G1 X84.509 Y102.414 E.00113
; LINE_WIDTH: 0.096086
G1 X84.389 Y102.26 E.00068
; WIPE_START
G1 X84.509 Y102.414 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X88.527 Y102.819 Z6.36 F18000
G1 Z5.96
G1 E.4 F1800
; LINE_WIDTH: 0.0927241
G1 F1500
M204 S6000
G1 X88.439 Y102.88 E.00036
G1 X88.368 Y102.864 E.00024
; close powerlost recovery
M1003 S0
; WIPE_START
G1 F1500
G1 X88.439 Y102.88 E-.15281
G1 X88.527 Y102.819 E-.22719
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

