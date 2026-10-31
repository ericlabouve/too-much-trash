; HEADER_BLOCK_START
; BambuStudio 02.07.01.62
; model printing time: 17m 3s; total estimated time: 25m 7s
; total layer number: 57
; total filament length [mm] : 398.20
; total filament volume [cm^3] : 957.77
; total filament weight [g] : 1.19
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
; bridge_no_support = 1
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
M73 P0 R25
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
M73 P2 R24
    G1 E5 F49.8898
    M109 S210 ; drop nozzle temp, make filament shink a bit
    M104 S190
    G92 E0
M73 P6 R23
    G1 E-0.5 F300

M73 P7 R23
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
M73 P24 R18
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
M73 P25 R18
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
    G29 A1 X78.0944 Y76.1009 I23.8112 J27.7982
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
M73 P27 R18
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
; layer num/total_layer_count: 1/57
; update layer progress
M73 L1
M991 S0 P0 ;notify layer change
M106 S0
; OBJECT_ID: 8
G1 X95.329 Y94.905 F18000
M204 S6000
G1 Z.4
M73 P29 R17
G1 Z.2
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.5
G1 F900
M204 S500
G1 X95.423 Y95.148 E.0099
G1 X93.201 Y96.139 E.09247
G1 X92.977 Y96.294 E.01035
G1 X92.749 Y96.406 E.00967
M73 P30 R17
G1 X92.806 Y95.453 E.0363
G1 X92.826 Y95.357 E.00372
G1 X92.917 Y95.187 E.00732
G1 X92.995 Y95.112 E.00412
G1 X93.113 Y95.046 E.00514
G1 X93.233 Y95.014 E.00473
G1 X93.465 Y95.04 E.00889
G1 X93.96 Y95.354 E.02224
G1 X95.272 Y94.924 E.05249
; WIPE_START
G1 X95.423 Y95.148 E-.05135
G1 X93.843 Y95.853 E-.32865
; WIPE_END
G1 E-.02 F1800
M204 S6000
G1 X86.616 Y98.308 Z.6 F18000
G1 X83.442 Y99.386 Z.6
M73 P31 R17
G1 Z.2
G1 E.4 F1800
G1 F900
M204 S500
G1 X83.527 Y99.035 E.01372
G1 X83.654 Y98.726 E.01271
M73 P32 R17
G1 X83.816 Y98.435 E.01264
G1 X84.108 Y98.058 E.01814
G1 X84.463 Y97.738 E.01814
G1 X84.74 Y97.555 E.01263
G1 X85.039 Y97.406 E.01271
G1 X85.491 Y97.259 E.01806
G1 X85.973 Y97.194 E.01847
G1 X86.458 Y97.215 E.01846
G1 X86.93 Y97.323 E.01838
G1 X87.368 Y97.51 E.01812
G1 X87.651 Y97.685 E.01265
G1 X87.915 Y97.895 E.01279
G1 X88.231 Y98.236 E.01767
G1 X88.419 Y98.511 E.01269
G1 X88.573 Y98.809 E.01273
G1 X88.724 Y99.248 E.01765
G1 X88.783 Y99.578 E.01273
G1 X88.803 Y99.911 E.01271
G1 X88.761 Y100.376 E.01774
G1 X88.682 Y100.699 E.01263
G1 X88.565 Y101.012 E.01272
G1 X88.333 Y101.428 E.01807
G1 X88.025 Y101.803 E.01847
G1 X87.661 Y102.111 E.01813
G1 X87.378 Y102.286 E.01264
G1 X87.074 Y102.426 E.01271
G1 X86.618 Y102.56 E.01806
G1 X86.145 Y102.609 E.01807
G1 X85.811 Y102.594 E.0127
G1 X85.481 Y102.54 E.01273
G1 X85.029 Y102.393 E.01805
G1 X84.601 Y102.162 E.01847
G1 X84.221 Y101.859 E.01848
G1 X83.909 Y101.502 E.01804
G1 X83.729 Y101.22 E.01271
G1 X83.585 Y100.92 E.01265
G1 X83.444 Y100.464 E.01813
G1 X83.386 Y99.982 E.01847
G1 X83.415 Y99.497 E.01846
G1 X83.428 Y99.444 E.00207
M204 S6000
G1 X83.886 Y99.494 F18000
; FEATURE: Outer wall
G1 F900
M204 S500
G1 X83.963 Y99.177 E.01242
G1 X84.067 Y98.924 E.01038
G1 X84.199 Y98.688 E.01029
G1 X84.444 Y98.37 E.01527
G1 X84.743 Y98.101 E.01527
G1 X84.969 Y97.952 E.0103
G1 X85.213 Y97.83 E.01037
G1 X85.593 Y97.706 E.01519
G1 X85.993 Y97.652 E.01534
G1 X86.397 Y97.67 E.01534
G1 X86.788 Y97.76 E.01526
G1 X87.157 Y97.917 E.01526
G1 X87.388 Y98.06 E.0103
G1 X87.603 Y98.231 E.01045
G1 X87.873 Y98.521 E.01506
G1 X88.026 Y98.746 E.01035
G1 X88.152 Y98.989 E.01038
G1 X88.28 Y99.364 E.01505
G1 X88.329 Y99.632 E.01038
G1 X88.345 Y99.904 E.01037
G1 X88.309 Y100.301 E.01513
G1 X88.245 Y100.564 E.01029
G1 X88.149 Y100.82 E.01038
G1 X87.954 Y101.169 E.0152
G1 X87.698 Y101.481 E.01534
G1 X87.391 Y101.74 E.01526
G1 X87.161 Y101.883 E.01031
G1 X86.913 Y101.997 E.01037
G1 X86.529 Y102.109 E.0152
G1 X86.132 Y102.151 E.0152
G1 X85.859 Y102.139 E.01036
G1 X85.59 Y102.094 E.01038
G1 X85.21 Y101.971 E.01519
G1 X84.854 Y101.779 E.01534
G1 X84.539 Y101.528 E.01535
G1 X84.276 Y101.227 E.01517
G1 X84.129 Y100.997 E.01038
G1 X84.011 Y100.753 E.01031
G1 X83.893 Y100.369 E.01527
G1 X83.844 Y99.968 E.01533
G1 X83.869 Y99.565 E.01534
G1 X83.872 Y99.553 E.0005
; WIPE_START
G1 X83.963 Y99.177 E-.07348
G1 X84.067 Y98.924 E-.05187
G1 X84.199 Y98.688 E-.05146
G1 X84.444 Y98.37 E-.07631
G1 X84.743 Y98.101 E-.07634
G1 X84.965 Y97.955 E-.05054
; WIPE_END
G1 E-.02 F1800
M204 S6000
G1 X85.078 Y96.208 Z.6 F18000
G1 Z.2
G1 E.4 F1800
; FEATURE: Inner wall
G1 F900
M204 S500
G1 X87.237 Y96.208 E.08204
G1 X88.709 Y97.899 E.08522
G1 X89.022 Y98.394 E.02226
G1 X89.102 Y98.561 E.00704
G1 X89.29 Y99.112 E.02212
G1 X89.38 Y99.684 E.02201
G1 X89.366 Y100.27 E.02227
G1 X89.297 Y100.662 E.01511
G1 X89.183 Y101.04 E.01501
G1 X88.938 Y101.56 E.02187
G1 X88.715 Y101.893 E.01524
G1 X88.455 Y102.195 E.01512
G1 X88.009 Y102.58 E.0224
G1 X87.504 Y102.876 E.02225
G1 X87.344 Y102.947 E.00664
G1 X86.784 Y103.12 E.02227
G1 X86.203 Y103.191 E.02225
G1 X85.798 Y103.179 E.0154
G1 X85.405 Y103.12 E.01512
G1 X84.845 Y102.947 E.02226
G1 X84.334 Y102.682 E.02187
G1 X84.017 Y102.454 E.01486
G1 X83.729 Y102.19 E.01485
G1 X83.474 Y101.893 E.01484
G1 X83.256 Y101.569 E.01486
G1 X83.074 Y101.211 E.01525
G1 X82.894 Y100.669 E.02172
G1 X82.825 Y100.28 E.015
G1 X82.803 Y99.89 E.01484
G1 X82.827 Y99.501 E.01484
G1 X82.899 Y99.112 E.01501
G1 X83.083 Y98.571 E.02174
G1 X83.267 Y98.215 E.01524
G1 X83.487 Y97.891 E.01486
G1 X84.952 Y96.208 E.08481
G1 X85.018 Y96.208 E.00252
; WIPE_START
G1 X87.018 Y96.208 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S6000
G1 X79.76 Y96.148 Z.6 F18000
M73 P32 R16
G1 Z.2
G1 E.4 F1800
G1 F900
M204 S500
G1 X79.715 Y96.403 E.00983
G1 X79.402 Y96.367 E.01198
G1 X79.272 Y96.323 E.00524
G1 X79.044 Y96.167 E.01047
G1 X78.954 Y96.065 E.00519
G1 X78.872 Y95.923 E.00625
G1 X78.829 Y95.793 E.00519
G1 X78.793 Y95.486 E.01175
G1 X79.005 Y95.416 E.00849
G1 X79.243 Y95.829 E.01812
G1 X79.599 Y96.11 E.01725
G1 X79.702 Y96.135 E.00401
; WIPE_START
G1 X79.715 Y96.403 E-.0511
G1 X79.402 Y96.367 E-.05991
G1 X79.272 Y96.323 E-.02618
G1 X79.044 Y96.167 E-.05235
G1 X78.954 Y96.065 E-.02595
G1 X78.872 Y95.923 E-.03122
G1 X78.829 Y95.793 E-.02593
G1 X78.793 Y95.486 E-.05874
G1 X79.005 Y95.416 E-.04244
G1 X79.021 Y95.444 E-.00617
; WIPE_END
G1 E-.02 F1800
M204 S6000
G1 X79.329 Y87.818 Z.6 F18000
G1 X79.763 Y77.053 Z.6
G1 Z.2
G1 E.4 F1800
G1 F900
M204 S500
G1 X79.63 Y77.084 E.00519
G1 X79.371 Y77.255 E.0118
G1 X79.163 Y77.488 E.01187
G1 X79.016 Y77.803 E.01321
G1 X78.801 Y77.756 E.00836
G1 X78.817 Y77.454 E.01146
G1 X78.888 Y77.246 E.00837
G1 X78.961 Y77.129 E.00524
G1 X79.122 Y76.966 E.00871
G1 X79.324 Y76.858 E.00872
G1 X79.466 Y76.82 E.00558
G1 X79.735 Y76.81 E.01021
G1 X79.756 Y76.993 E.00699
; WIPE_START
G1 X79.63 Y77.084 E-.02953
G1 X79.371 Y77.255 E-.05898
G1 X79.163 Y77.488 E-.05932
G1 X79.016 Y77.803 E-.06605
G1 X78.801 Y77.756 E-.04181
G1 X78.817 Y77.454 E-.05728
G1 X78.888 Y77.246 E-.04183
G1 X78.958 Y77.133 E-.0252
; WIPE_END
G1 E-.02 F1800
M204 S6000
G1 X80.773 Y84.547 Z.6 F18000
G1 X83.787 Y96.851 Z.6
G1 Z.2
G1 E.4 F1800
; FEATURE: Outer wall
G1 F900
M204 S500
G1 X79.609 Y96.851 E.15878
G1 X79.303 Y96.815 E.01171
G1 X79.096 Y96.747 E.00828
G1 X78.976 Y96.686 E.0051
G1 X78.734 Y96.506 E.01149
G1 X78.59 Y96.344 E.00823
G1 X78.512 Y96.226 E.00538
G1 X78.448 Y96.098 E.00544
G1 X78.38 Y95.892 E.00822
G1 X78.344 Y95.586 E.01171
G1 X78.344 Y77.612 E.68315
G1 X78.364 Y77.382 E.00878
G1 X78.397 Y77.246 E.00531
G1 X78.478 Y77.04 E.0084
G1 X78.593 Y76.855 E.00828
G1 X78.74 Y76.69 E.0084
G1 X78.848 Y76.599 E.00539
G1 X78.967 Y76.521 E.00539
G1 X79.167 Y76.427 E.00841
G1 X79.38 Y76.37 E.00836
G1 X79.522 Y76.353 E.00544
G1 X92.581 Y76.351 E.49634
G1 X92.886 Y76.387 E.01166
G1 X93.089 Y76.454 E.00814
G1 X93.281 Y76.557 E.00827
G1 X93.451 Y76.692 E.00827
G1 X93.596 Y76.855 E.00828
G1 X93.711 Y77.04 E.00827
G1 X93.791 Y77.243 E.00827
G1 X93.834 Y77.452 E.00815
G1 X93.844 Y88.751 E.42941
G1 X92.744 Y88.751 E.0418
G1 X92.744 Y77.451 E.42947
G1 X80.065 Y77.451 E.48189
G1 X79.814 Y77.51 E.00981
G1 X79.672 Y77.604 E.00645
G1 X79.549 Y77.742 E.00704
G1 X79.469 Y77.914 E.0072
G1 X79.444 Y78.083 E.00649
G1 X79.444 Y95.123 E.64763
G1 X79.48 Y95.324 E.00778
G1 X79.595 Y95.524 E.00878
G1 X79.803 Y95.689 E.01007
G1 X80.065 Y95.751 E.01023
G1 X92.33 Y95.751 E.46614
G1 X92.351 Y95.392 E.01367
G1 X92.387 Y95.222 E.00657
G1 X92.452 Y95.062 E.00657
G1 X92.575 Y94.882 E.0083
G1 X92.702 Y94.759 E.00671
G1 X92.943 Y94.62 E.01057
G1 X93.209 Y94.556 E.01041
G1 X93.446 Y94.564 E.009
G1 X93.704 Y94.644 E.01027
G1 X94.025 Y94.851 E.01452
G1 X95.647 Y94.32 E.06489
G1 X100.656 Y87.166 E.33192
G1 X101.557 Y87.797 E.04181
G1 X96.349 Y95.236 E.34513
G1 X93.426 Y96.539 E.12165
G1 X93.209 Y96.689 E.01
G1 X92.882 Y96.816 E.01332
G1 X92.58 Y96.851 E.01157
G1 X88.402 Y96.851 E.15879
G1 X89.067 Y97.615 E.03849
G1 X89.193 Y97.789 E.00818
G1 X89.425 Y98.178 E.0172
G1 X89.52 Y98.375 E.00833
G1 X89.603 Y98.578 E.00832
G1 X89.735 Y99.003 E.01691
G1 X89.817 Y99.448 E.01721
G1 X89.837 Y99.663 E.00818
G1 X89.838 Y100.115 E.0172
G1 X89.82 Y100.33 E.00818
G1 X89.742 Y100.768 E.01691
G1 X89.613 Y101.198 E.01707
M73 P33 R16
G1 X89.434 Y101.605 E.01691
G1 X89.329 Y101.798 E.00833
G1 X89.079 Y102.17 E.01705
G1 X88.789 Y102.508 E.01692
G1 X88.632 Y102.661 E.00833
G1 X88.281 Y102.947 E.0172
G1 X88.103 Y103.067 E.00818
G1 X87.707 Y103.286 E.0172
G1 X87.51 Y103.373 E.00819
G1 X87.081 Y103.519 E.0172
G1 X86.872 Y103.569 E.00818
G1 X86.424 Y103.636 E.0172
G1 X86.21 Y103.649 E.00818
G1 X85.757 Y103.635 E.01721
G1 X85.317 Y103.569 E.01692
G1 X85.107 Y103.518 E.00819
G1 X84.679 Y103.373 E.01719
G1 X84.482 Y103.286 E.00819
G1 X84.089 Y103.069 E.01705
G1 X83.728 Y102.809 E.01693
G1 X83.4 Y102.508 E.01692
G1 X83.11 Y102.171 E.01691
G1 X82.862 Y101.801 E.01693
G1 X82.658 Y101.401 E.01706
G1 X82.577 Y101.201 E.00818
G1 X82.448 Y100.775 E.01691
G1 X82.37 Y100.333 E.01707
G1 X82.345 Y99.889 E.01692
G1 X82.373 Y99.445 E.01691
G1 X82.454 Y99.003 E.01707
G1 X82.585 Y98.581 E.01677
G1 X82.668 Y98.379 E.00833
G1 X82.874 Y97.98 E.01706
G1 X83.125 Y97.612 E.01692
G1 X83.747 Y96.896 E.03606
; WIPE_START
G1 X81.747 Y96.874 E-.38
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




G1 X79.966 Y96.301
G1 Z.2
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.68586
G1 F900
M204 S500
G1 X84.568 Y96.301 E.24604
; WIPE_START
G1 X82.568 Y96.301 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S6000
G1 X87.539 Y97.155 Z.6 F18000
G1 Z.2
G1 E.4 F1800
; LINE_WIDTH: 0.349477
G1 F900
M204 S500
G1 X87.652 Y97.249 E.00376
; LINE_WIDTH: 0.308767
G1 X87.745 Y97.329 E.00271
; LINE_WIDTH: 0.271945
G1 X87.838 Y97.408 E.00233
; LINE_WIDTH: 0.234882
G1 X87.981 Y97.544 E.00315
; LINE_WIDTH: 0.200132
G1 X88.114 Y97.672 E.00241
; LINE_WIDTH: 0.168305
G1 X88.461 Y98.058 E.00541
G1 X88.667 Y98.367 E.00387
G1 X88.84 Y98.69 E.00381
G1 X89.007 Y99.182 E.00542
G1 X89.085 Y99.7 E.00546
G1 X89.072 Y100.234 E.00557
G1 X89.011 Y100.593 E.0038
G1 X88.907 Y100.937 E.00374
G1 X88.683 Y101.408 E.00544
G1 X88.479 Y101.715 E.00384
G1 X88.236 Y102.003 E.00394
G1 X87.836 Y102.345 E.00548
G1 X87.511 Y102.54 E.00396
G1 X87.172 Y102.699 E.0039
G1 X86.679 Y102.843 E.00535
G1 X86.159 Y102.9 E.00546
G1 X85.785 Y102.884 E.0039
G1 X85.408 Y102.82 E.00398
G1 X84.92 Y102.661 E.00535
G1 X84.446 Y102.407 E.00561
G1 X84.026 Y102.072 E.00561
G1 X83.708 Y101.716 E.00497
G1 X83.478 Y101.364 E.00438
G1 X83.317 Y101.03 E.00387
G1 X83.162 Y100.53 E.00546
G1 X83.097 Y99.996 E.00561
G1 X83.119 Y99.536 E.0048
G1 X83.186 Y99.184 E.00374
G1 X83.351 Y98.692 E.0054
G1 X83.52 Y98.365 E.00384
G1 X83.722 Y98.073 E.00371
G1 X84.08 Y97.673 E.00559
; LINE_WIDTH: 0.210119
G1 X84.261 Y97.489 E.00359
; LINE_WIDTH: 0.227245
G1 X84.271 Y97.48 E.00021
; LINE_WIDTH: 0.253416
G1 X84.409 Y97.359 E.00321
; LINE_WIDTH: 0.303058
G1 X84.547 Y97.238 E.00396
; LINE_WIDTH: 0.330745
G1 X84.561 Y97.227 E.00042
; LINE_WIDTH: 0.35773
G1 X84.659 Y97.151 E.00325
; LINE_WIDTH: 0.405955
G1 X84.757 Y97.075 E.00375
; LINE_WIDTH: 0.454179
G1 X84.855 Y96.999 E.00424
; LINE_WIDTH: 0.486155
G1 X84.883 Y96.979 E.00126
M204 S6000
G1 X84.7 Y96.846 F18000
; LINE_WIDTH: 0.678799
G1 F900
M204 S500
G1 X85.345 Y96.743 E.03455
; LINE_WIDTH: 0.630729
G1 X85.663 Y96.719 E.01559
; LINE_WIDTH: 0.591063
G1 X85.927 Y96.702 E.01204
; LINE_WIDTH: 0.58338
G1 X86.551 Y96.716 E.02805
; LINE_WIDTH: 0.625847
G1 X87.008 Y96.767 E.0223
; LINE_WIDTH: 0.6745
G1 X87.465 Y96.819 E.02416
M204 S6000
G1 X87.621 Y96.301 F18000
; LINE_WIDTH: 0.68586
G1 F900
M204 S500
G1 X92.526 Y96.301 E.26224
; WIPE_START
G1 X90.526 Y96.301 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S6000
G1 X95.465 Y94.622 Z.6 F18000
G1 Z.2
G1 E.4 F1800
; LINE_WIDTH: 0.686843
G1 F900
M204 S500
G1 X95.897 Y94.826 E.02556
G1 X95.979 Y94.787 E.00484
G1 X96.054 Y94.698 E.00623
G1 X100.976 Y87.669 E.45945
; WIPE_START
G1 X99.829 Y89.307 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S6000
G1 X93.294 Y88.522 Z.6 F18000
G1 Z.2
G1 E.4 F1800
; LINE_WIDTH: 0.680305
G1 F900
M204 S500
G1 X93.278 Y77.396 E.58967
; LINE_WIDTH: 0.628648
G1 X93.254 Y77.27 E.00627
; LINE_WIDTH: 0.591012
G1 X93.24 Y77.222 E.00224
; LINE_WIDTH: 0.560913
G1 X93.211 Y77.142 E.00368
; LINE_WIDTH: 0.539831
G1 X93.127 Y77.036 E.00558
G1 X93.012 Y76.966 E.00557
; LINE_WIDTH: 0.569437
G1 X92.973 Y76.955 E.00177
M204 S6000
G1 X93.43 Y77.02 F18000
; LINE_WIDTH: 0.641726
G1 F900
M204 S500
G1 X92.769 Y76.914 E.03334
; LINE_WIDTH: 0.684448
G1 X92.549 Y76.901 E.01174
G1 X79.976 Y76.902 E.67071
; WIPE_START
G1 X81.976 Y76.902 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S6000
G1 X78.897 Y78.011 Z.6 F18000
G1 Z.2
G1 E.4 F1800
; LINE_WIDTH: 0.688887
G1 F900
M204 S500
G1 X78.894 Y95.212 E.92388
; CHANGE_LAYER
; Z_HEIGHT: 0.32
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F900
G1 X78.895 Y93.212 E-.38
; WIPE_END
G1 E-.02 F1800
; layer num/total_layer_count: 2/57
; update layer progress
M73 L2
M991 S0 P1 ;notify layer change
M106 S255
; open powerlost recovery
M1003 S1
; OBJECT_ID: 8
M204 S10000
G17
G3 Z.6 I.797 J.92 P1  F18000
G1 X93.468 Y80.582 Z.6
G1 Z.32
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X93.475 Y88.382 E.1651
G1 X93.114 Y88.382 E.00764
G1 X93.114 Y77.128 E.23818
G1 X93.299 Y77.076 E.00407
G1 X93.379 Y77.207 E.00325
G1 X93.436 Y77.349 E.00324
G1 X93.465 Y77.49 E.00305
G1 X93.468 Y80.522 E.06416
; WIPE_START
M204 S6000
G1 X93.469 Y82.522 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X93.575 Y90.153 Z.72 F18000
G1 X93.65 Y95.57 Z.72
G1 Z.32
G1 E.4 F1800
G1 F1500
M204 S500
G1 X93.121 Y95.806 E.01227
G1 X93.14 Y95.496 E.00657
G1 X93.166 Y95.414 E.00184
G1 X93.211 Y95.37 E.00133
G1 X93.296 Y95.348 E.00185
G1 X93.368 Y95.368 E.0016
G1 X93.602 Y95.535 E.00607
; WIPE_START
M204 S6000
G1 X93.121 Y95.806 E-.14343
G1 X93.14 Y95.496 E-.08074
G1 X93.166 Y95.414 E-.02257
G1 X93.211 Y95.37 E-.01634
G1 X93.296 Y95.348 E-.02268
G1 X93.368 Y95.368 E-.01964
G1 X93.602 Y95.535 E-.07459
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X86.092 Y96.901 Z.72 F18000
G1 X84.856 Y97.126 Z.72
G1 Z.32
G1 E.4 F1800
G1 F1500
M204 S500
G1 X84.741 Y96.963 E.00423
G1 X85.105 Y96.544 E.01174
G1 X87.084 Y96.544 E.04188
G1 X87.43 Y96.942 E.01116
G1 X87.323 Y97.104 E.0041
G1 X86.861 Y96.953 E.01029
G1 X86.488 Y96.88 E.00804
G1 X85.973 Y96.857 E.0109
G1 X85.595 Y96.897 E.00804
G1 X85.225 Y96.981 E.00804
G1 X84.912 Y97.104 E.00712
; WIPE_START
M204 S6000
G1 X84.741 Y96.963 E-.04213
G1 X85.105 Y96.544 E-.10542
G1 X86.328 Y96.544 E-.23245
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X83.524 Y99.419 Z.72 F18000
G1 Z.32
G1 E.4 F1800
G1 F1500
M204 S500
G1 X83.611 Y99.063 E.00777
G1 X83.734 Y98.764 E.00683
G1 X83.891 Y98.482 E.00683
G1 X84.172 Y98.118 E.00975
G1 X84.522 Y97.803 E.00995
G1 X84.922 Y97.556 E.00995
G1 X85.351 Y97.388 E.00975
G1 X85.665 Y97.316 E.00683
G1 X85.986 Y97.282 E.00683
G1 X86.437 Y97.302 E.00955
G1 X86.754 Y97.365 E.00683
G1 X87.061 Y97.465 E.00683
G1 X87.473 Y97.671 E.00975
G1 X87.849 Y97.953 E.00995
G1 X88.162 Y98.29 E.00975
G1 X88.344 Y98.557 E.00683
G1 X88.488 Y98.835 E.00664
G1 X88.598 Y99.129 E.00663
G1 X88.675 Y99.442 E.00683
G1 X88.716 Y99.901 E.00975
G1 X88.674 Y100.369 E.00995
G1 X88.549 Y100.822 E.00995
G1 X88.349 Y101.237 E.00975
G1 X88.167 Y101.504 E.00683
G1 X87.955 Y101.747 E.00684
G1 X87.606 Y102.042 E.00967
G1 X87.336 Y102.208 E.00671
G1 X87.043 Y102.344 E.00683
G1 X86.601 Y102.473 E.00975
G1 X86.143 Y102.521 E.00976
G1 X85.821 Y102.507 E.00682
G1 X85.508 Y102.455 E.00671
G1 X85.064 Y102.312 E.00986
G1 X84.65 Y102.089 E.00996
G1 X84.282 Y101.796 E.00995
G1 X83.979 Y101.449 E.00975
G1 X83.806 Y101.177 E.00683
G1 X83.668 Y100.892 E.00671
G1 X83.53 Y100.447 E.00986
G1 X83.474 Y99.979 E.00996
G1 X83.502 Y99.51 E.00995
G1 X83.51 Y99.477 E.00071
M204 S250
G1 X83.922 Y99.516 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X84.001 Y99.189 E.00662
G1 X84.103 Y98.942 E.00526
G1 X84.233 Y98.708 E.00526
G1 X84.474 Y98.397 E.00773
G1 X84.768 Y98.132 E.0078
G1 X85.105 Y97.924 E.0078
G1 X85.471 Y97.78 E.00773
G1 X85.732 Y97.72 E.00526
G1 X85.998 Y97.692 E.00526
G1 X86.388 Y97.71 E.00767
G1 X86.651 Y97.762 E.00527
G1 X86.905 Y97.844 E.00526
G1 X87.257 Y98.02 E.00773
G1 X87.574 Y98.258 E.0078
G1 X87.841 Y98.546 E.00773
G1 X87.992 Y98.767 E.00526
G1 X88.114 Y99.002 E.0052
G1 X88.207 Y99.249 E.0052
G1 X88.27 Y99.509 E.00526
G1 X88.305 Y99.901 E.00774
G1 X88.27 Y100.296 E.0078
G1 X88.164 Y100.678 E.0078
G1 X87.994 Y101.032 E.00773
G1 X87.843 Y101.253 E.00526
G1 X87.667 Y101.455 E.00527
G1 X87.365 Y101.71 E.00777
G1 X87.142 Y101.847 E.00515
G1 X86.899 Y101.96 E.00526
G1 X86.522 Y102.07 E.00773
G1 X86.13 Y102.111 E.00774
G1 X85.863 Y102.099 E.00526
G1 X85.605 Y102.056 E.00516
G1 X85.226 Y101.934 E.00784
G1 X84.876 Y101.746 E.0078
G1 X84.566 Y101.499 E.0078
G1 X84.308 Y101.203 E.00773
G1 X84.164 Y100.977 E.00526
G1 X84.05 Y100.741 E.00516
G1 X83.932 Y100.361 E.00783
G1 X83.885 Y99.967 E.0078
G1 X83.908 Y99.575 E.00773
; WIPE_START
M204 S6000
G1 X84.001 Y99.189 E-.0753
G1 X84.103 Y98.942 E-.05083
G1 X84.233 Y98.708 E-.05081
G1 X84.474 Y98.397 E-.07471
G1 X84.768 Y98.132 E-.0753
G1 X85.006 Y97.985 E-.05304
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X84.855 Y96.12 Z.72 F18000
G1 Z.32
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X92.677 Y96.12 E.16555
G1 X92.719 Y95.439 E.01444
G1 X92.741 Y95.332 E.00233
G1 X92.784 Y95.227 E.00239
G1 X92.852 Y95.127 E.00257
G1 X92.938 Y95.044 E.00252
G1 X93.071 Y94.968 E.00324
G1 X93.224 Y94.928 E.00336
G1 X93.325 Y94.922 E.00213
G1 X93.527 Y94.972 E.0044
G1 X93.95 Y95.264 E.01089
G1 X95.879 Y94.633 E.04295
G1 X100.747 Y87.68 E.17964
G1 X101.043 Y87.888 E.00765
G1 X96.105 Y94.94 E.18222
G1 X93.236 Y96.22 E.06648
G1 X93.077 Y96.336 E.00417
G1 X92.938 Y96.409 E.00332
G1 X92.803 Y96.453 E.00302
G1 X92.559 Y96.482 E.0052
G1 X87.591 Y96.482 E.10514
G1 X88.777 Y97.845 E.03825
G1 X88.884 Y97.992 E.00386
G1 X89.099 Y98.353 E.00888
G1 X89.326 Y98.91 E.01273
G1 X89.449 Y99.49 E.01254
G1 X89.47 Y100.091 E.01274
G1 X89.384 Y100.676 E.01252
G1 X89.265 Y101.07 E.0087
G1 X89.013 Y101.606 E.01253
G1 X88.659 Y102.104 E.01294
G1 X88.228 Y102.522 E.01271
M73 P34 R16
G1 X87.737 Y102.855 E.01254
G1 X87.188 Y103.099 E.01273
G1 X86.792 Y103.208 E.00869
G1 X86.386 Y103.269 E.00869
G1 X85.784 Y103.266 E.01274
G1 X85.202 Y103.161 E.01253
G1 X84.647 Y102.955 E.01253
G1 X84.286 Y102.756 E.00871
G1 X83.961 Y102.522 E.00848
G1 X83.666 Y102.251 E.00849
G1 X83.404 Y101.946 E.0085
G1 X83.088 Y101.445 E.01255
G1 X82.923 Y101.07 E.00867
G1 X82.807 Y100.686 E.0085
G1 X82.737 Y100.291 E.00849
G1 X82.715 Y99.89 E.00849
G1 X82.74 Y99.49 E.00848
G1 X82.815 Y99.086 E.00871
G1 X83.003 Y98.534 E.01234
G1 X83.192 Y98.17 E.00869
G1 X83.417 Y97.838 E.00849
G1 X84.597 Y96.482 E.03805
G1 X79.631 Y96.482 E.10513
G1 X79.383 Y96.453 E.00527
G1 X79.238 Y96.405 E.00324
G1 X78.979 Y96.228 E.00664
G1 X78.829 Y96.033 E.00521
G1 X78.743 Y95.812 E.00501
G1 X78.714 Y95.565 E.00527
G1 X78.714 Y77.619 E.37984
G1 X78.753 Y77.349 E.00578
G1 X78.855 Y77.125 E.00521
G1 X78.956 Y76.998 E.00343
G1 X79.074 Y76.892 E.00336
G1 X79.294 Y76.775 E.00527
G1 X79.544 Y76.723 E.0054
G1 X92.562 Y76.72 E.27553
G1 X92.805 Y76.749 E.00519
G1 X92.942 Y76.794 E.00306
G1 X93.119 Y76.889 E.00424
G1 X93.07 Y77.082 E.0042
G1 X80.058 Y77.082 E.2754
G1 X79.849 Y77.106 E.00446
G1 X79.556 Y77.223 E.00669
G1 X79.249 Y77.512 E.00892
G1 X79.112 Y77.807 E.00688
G1 X79.075 Y78.055 E.00532
G1 X79.075 Y95.155 E.36193
G1 X79.128 Y95.453 E.00639
G1 X79.311 Y95.77 E.00776
G1 X79.639 Y96.029 E.00884
G1 X80.022 Y96.12 E.00834
G1 X84.795 Y96.12 E.10103
; WIPE_START
M204 S6000
G1 X86.795 Y96.12 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X83.699 Y96.891 Z.72 F18000
G1 Z.32
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X79.607 Y96.891 E.08049
G1 X79.294 Y96.854 E.00619
G1 X79.081 Y96.784 E.00442
G1 X78.955 Y96.721 E.00277
G1 X78.705 Y96.535 E.00612
G1 X78.606 Y96.429 E.00284
G1 X78.476 Y96.243 E.00447
G1 X78.412 Y96.114 E.00283
G1 X78.341 Y95.901 E.00442
G1 X78.304 Y95.589 E.00619
G1 X78.304 Y77.607 E.35368
G1 X78.313 Y77.454 E.00301
G1 X78.359 Y77.231 E.00448
G1 X78.442 Y77.023 E.00441
G1 X78.515 Y76.895 E.0029
G1 X78.657 Y76.716 E.00448
G1 X78.824 Y76.567 E.00441
G1 X78.947 Y76.486 E.0029
G1 X79.154 Y76.389 E.00448
G1 X79.37 Y76.331 E.00441
G1 X79.52 Y76.313 E.00296
G1 X92.586 Y76.311 E.257
G1 X92.895 Y76.347 E.00611
G1 X93.105 Y76.417 E.00436
G1 X93.303 Y76.524 E.00442
G1 X93.479 Y76.663 E.00442
G1 X93.628 Y76.831 E.00442
G1 X93.746 Y77.022 E.00442
G1 X93.829 Y77.231 E.00442
G1 X93.874 Y77.448 E.00436
G1 X93.884 Y88.791 E.2231
G1 X92.704 Y88.791 E.02321
G1 X92.704 Y77.491 E.22226
G1 X80.082 Y77.491 E.24827
G1 X79.95 Y77.506 E.00261
G1 X79.78 Y77.574 E.00361
G1 X79.587 Y77.756 E.00521
G1 X79.508 Y77.925 E.00368
G1 X79.484 Y78.085 E.00318
G1 X79.484 Y95.119 E.33504
G1 X79.518 Y95.31 E.00382
G1 X79.626 Y95.498 E.00425
G1 X79.821 Y95.652 E.00489
G1 X80.07 Y95.711 E.00503
G1 X92.292 Y95.711 E.24039
G1 X92.312 Y95.384 E.00645
G1 X92.349 Y95.211 E.00348
G1 X92.417 Y95.044 E.00354
G1 X92.547 Y94.853 E.00456
G1 X92.676 Y94.728 E.00353
G1 X92.925 Y94.584 E.00565
G1 X93.161 Y94.521 E.00481
G1 X93.442 Y94.523 E.00553
G1 X93.68 Y94.59 E.00487
G1 X93.833 Y94.671 E.00341
G1 X94.023 Y94.81 E.00462
G1 X95.622 Y94.286 E.0331
G1 X100.647 Y87.111 E.1723
G1 X101.613 Y87.787 E.02321
G1 X96.375 Y95.268 E.17962
G1 X93.443 Y96.576 E.06316
G1 X93.295 Y96.684 E.0036
G1 X93.099 Y96.787 E.00436
G1 X92.891 Y96.855 E.00431
G1 X92.582 Y96.891 E.00611
G1 X88.49 Y96.891 E.08049
G1 X89.098 Y97.59 E.01823
G1 X89.226 Y97.767 E.0043
G1 X89.46 Y98.159 E.00897
G1 X89.555 Y98.356 E.0043
G1 X89.716 Y98.783 E.00897
G1 X89.774 Y98.994 E.0043
G1 X89.856 Y99.44 E.00891
G1 X89.884 Y99.882 E.00871
G1 X89.859 Y100.335 E.00892
G1 X89.782 Y100.771 E.00871
G1 X89.65 Y101.212 E.00905
G1 X89.469 Y101.627 E.00891
G1 X89.363 Y101.819 E.0043
G1 X89.115 Y102.189 E.00878
G1 X88.97 Y102.37 E.00457
G1 X88.82 Y102.534 E.00436
G1 X88.486 Y102.84 E.00891
G1 X88.119 Y103.105 E.00891
G1 X87.93 Y103.216 E.00431
G1 X87.519 Y103.413 E.00897
G1 X87.313 Y103.489 E.00431
G1 X86.877 Y103.609 E.00891
G1 X86.429 Y103.676 E.00891
G1 X86.21 Y103.689 E.0043
G1 X85.747 Y103.674 E.00911
G1 X85.309 Y103.608 E.00871
G1 X85.093 Y103.556 E.00437
G1 X84.881 Y103.491 E.00437
G1 X84.471 Y103.325 E.00871
G1 X84.068 Y103.103 E.00905
G1 X83.702 Y102.84 E.00885
G1 X83.371 Y102.536 E.00885
G1 X83.078 Y102.195 E.00885
G1 X82.831 Y101.827 E.00872
G1 X82.72 Y101.626 E.0045
G1 X82.539 Y101.212 E.0089
G1 X82.408 Y100.781 E.00885
G1 X82.33 Y100.338 E.00885
G1 X82.305 Y99.889 E.00885
G1 X82.333 Y99.44 E.00884
G1 X82.417 Y98.987 E.00905
G1 X82.548 Y98.564 E.00871
G1 X82.631 Y98.362 E.0043
G1 X82.84 Y97.96 E.00891
G1 X83.093 Y97.588 E.00885
G1 X83.659 Y96.936 E.01698
; WIPE_START
M204 S6000
G1 X81.66 Y96.914 E-.38
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




G1 X79.522 Y96.247
G1 Z.32
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.144732
G1 F1500
M204 S6000
G1 X79.316 Y96.13 E.0014
G1 X79.14 Y95.991 E.00133
G1 X79.042 Y95.85 E.00102
G1 X78.942 Y95.626 E.00145
; WIPE_START
G1 X79.042 Y95.85 E-.10599
G1 X79.14 Y95.991 E-.07449
G1 X79.316 Y96.13 E-.09704
G1 X79.522 Y96.247 E-.10247
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X84.63 Y97.174 Z.72 F18000
G1 Z.32
G1 E.4 F1800
; LINE_WIDTH: 0.473061
G1 F1500
M204 S6000
G1 X84.459 Y97.318 E.00499
; LINE_WIDTH: 0.438143
G1 X84.263 Y97.487 E.00533
; LINE_WIDTH: 0.401756
G1 X84.085 Y97.669 E.00478
; LINE_WIDTH: 0.359992
G1 X83.722 Y98.073 E.00905
G1 X83.521 Y98.363 E.0059
G1 X83.291 Y98.837 E.00878
G1 X83.188 Y99.178 E.00594
G1 X83.119 Y99.537 E.0061
G1 X83.098 Y100.005 E.00782
G1 X83.164 Y100.54 E.00898
G1 X83.313 Y101.018 E.00835
G1 X83.473 Y101.352 E.00617
G1 X83.709 Y101.717 E.00726
G1 X84.033 Y102.078 E.00808
G1 X84.454 Y102.412 E.00897
G1 X84.903 Y102.652 E.00849
G1 X85.407 Y102.82 E.00885
G1 X85.791 Y102.884 E.0065
G1 X86.142 Y102.895 E.00585
G1 X86.66 Y102.846 E.00867
G1 X87.065 Y102.736 E.00701
G1 X87.524 Y102.537 E.00834
G1 X87.835 Y102.338 E.00616
G1 X88.208 Y102.022 E.00815
G1 X88.474 Y101.728 E.00661
G1 X88.758 Y101.271 E.00898
G1 X88.909 Y100.941 E.00605
G1 X89.047 Y100.422 E.00896
G1 X89.095 Y99.895 E.00882
G1 X89.046 Y99.393 E.00842
G1 X88.964 Y99.025 E.00629
G1 X88.827 Y98.674 E.00628
G1 X88.66 Y98.357 E.00597
G1 X88.466 Y98.064 E.00586
G1 X88.097 Y97.654 E.0092
; LINE_WIDTH: 0.395503
G1 X87.972 Y97.538 E.00314
; LINE_WIDTH: 0.431469
G1 X87.847 Y97.422 E.00345
; LINE_WIDTH: 0.467661
G1 X87.721 Y97.304 E.0038
; LINE_WIDTH: 0.468431
G1 X87.559 Y97.34 E.00365
; LINE_WIDTH: 0.43353
G1 X87.398 Y97.375 E.00336
; WIPE_START
G1 X87.559 Y97.34 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X93.994 Y95.559 Z.72 F18000
G1 Z.32
G1 E.4 F1800
; LINE_WIDTH: 0.163591
G1 F1500
M204 S6000
G1 X94.335 Y95.428 E.00251
; LINE_WIDTH: 0.130054
G1 X94.676 Y95.297 E.0019
; LINE_WIDTH: 0.096516
G1 X95.017 Y95.165 E.00129
; WIPE_START
G1 X94.676 Y95.297 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X89.605 Y89.592 Z.72 F18000
G1 X78.949 Y77.601 Z.72
G1 Z.32
G1 E.4 F1800
; LINE_WIDTH: 0.0995241
G1 F1500
M204 S6000
G1 X79.004 Y77.422 E.00069
; LINE_WIDTH: 0.124836
G1 X79.038 Y77.348 E.00041
; LINE_WIDTH: 0.158436
G1 X79.166 Y77.196 E.00131
G1 X79.383 Y77.024 E.00183
; LINE_WIDTH: 0.118625
G1 X79.411 Y77.01 E.00015
; LINE_WIDTH: 0.0907209
G1 X79.591 Y76.956 E.00061
; CHANGE_LAYER
; Z_HEIGHT: 0.44
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F1500
G1 X79.411 Y77.01 E-.38
; WIPE_END
G1 E-.02 F1800
; layer num/total_layer_count: 3/57
; update layer progress
M73 L3
M991 S0 P2 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z.72 I-.3 J1.179 P1  F18000
G1 X93.468 Y80.582 Z.72
G1 Z.44
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X93.475 Y88.382 E.16509
G1 X93.114 Y88.382 E.00764
G1 X93.114 Y77.128 E.23818
G1 X93.299 Y77.076 E.00407
G1 X93.379 Y77.207 E.00325
G1 X93.436 Y77.349 E.00324
G1 X93.465 Y77.49 E.00305
G1 X93.468 Y80.522 E.06416
; WIPE_START
M204 S6000
G1 X93.469 Y82.522 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X93.58 Y90.153 Z.84 F18000
G1 X93.658 Y95.567 Z.84
G1 Z.44
G1 E.4 F1800
G1 F1500
M204 S500
G1 X93.121 Y95.806 E.01244
G1 X93.14 Y95.498 E.00653
G1 X93.173 Y95.407 E.00205
G1 X93.212 Y95.37 E.00113
G1 X93.296 Y95.348 E.00185
G1 X93.369 Y95.368 E.00161
G1 X93.609 Y95.533 E.00615
; WIPE_START
M204 S6000
G1 X93.121 Y95.806 E-.14423
G1 X93.14 Y95.498 E-.07971
G1 X93.173 Y95.407 E-.02504
G1 X93.212 Y95.37 E-.01381
G1 X93.296 Y95.348 E-.0226
G1 X93.369 Y95.368 E-.01959
G1 X93.609 Y95.533 E-.07502
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X86.1 Y96.9 Z.84 F18000
G1 X84.856 Y97.126 Z.84
M73 P35 R16
G1 Z.44
G1 E.4 F1800
G1 F1500
M204 S500
G1 X84.741 Y96.963 E.00423
G1 X85.105 Y96.544 E.01174
G1 X87.082 Y96.544 E.04184
G1 X87.435 Y96.95 E.01138
G1 X87.311 Y97.114 E.00436
G1 X86.861 Y96.953 E.01013
G1 X86.488 Y96.88 E.00804
G1 X85.973 Y96.857 E.0109
G1 X85.596 Y96.897 E.00804
G1 X85.225 Y96.981 E.00804
G1 X84.912 Y97.104 E.00712
; WIPE_START
M204 S6000
G1 X84.741 Y96.963 E-.04213
G1 X85.105 Y96.544 E-.10542
G1 X86.328 Y96.544 E-.23245
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X83.519 Y99.438 Z.84 F18000
G1 Z.44
G1 E.4 F1800
G1 F1500
M204 S500
G1 X83.568 Y99.204 E.00507
G1 X83.67 Y98.906 E.00665
G1 X83.885 Y98.49 E.00992
G1 X84.172 Y98.118 E.00996
G1 X84.522 Y97.803 E.00995
G1 X84.922 Y97.556 E.00995
G1 X85.351 Y97.388 E.00975
G1 X85.665 Y97.316 E.00683
G1 X85.986 Y97.282 E.00683
G1 X86.437 Y97.302 E.00955
G1 X86.754 Y97.365 E.00683
G1 X87.052 Y97.462 E.00664
G1 X87.336 Y97.593 E.00663
G1 X87.611 Y97.763 E.00684
G1 X87.955 Y98.055 E.00955
G1 X88.167 Y98.298 E.00683
G1 X88.349 Y98.565 E.00683
G1 X88.549 Y98.98 E.00975
G1 X88.674 Y99.433 E.00995
G1 X88.716 Y99.901 E.00994
G1 X88.674 Y100.37 E.00996
G1 X88.548 Y100.821 E.00992
G1 X88.42 Y101.108 E.00666
G1 X88.255 Y101.385 E.00682
G1 X87.962 Y101.741 E.00975
G1 X87.611 Y102.039 E.00975
G1 X87.336 Y102.208 E.00682
G1 X87.051 Y102.341 E.00666
G1 X86.602 Y102.473 E.00991
G1 X86.134 Y102.522 E.00997
G1 X85.665 Y102.487 E.00994
G1 X85.209 Y102.369 E.00997
G1 X84.785 Y102.171 E.00992
G1 X84.522 Y101.997 E.00666
G1 X84.277 Y101.789 E.00682
G1 X83.973 Y101.442 E.00975
G1 X83.737 Y101.046 E.00976
G1 X83.615 Y100.748 E.00683
G1 X83.529 Y100.437 E.00682
G1 X83.474 Y99.979 E.00975
G1 X83.501 Y99.52 E.00975
G1 X83.506 Y99.497 E.00049
M204 S250
G1 X83.919 Y99.524 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X83.964 Y99.313 E.00424
G1 X84.047 Y99.067 E.00511
G1 X84.231 Y98.711 E.00788
G1 X84.474 Y98.397 E.0078
G1 X84.768 Y98.132 E.0078
G1 X85.105 Y97.924 E.0078
G1 X85.472 Y97.78 E.00774
G1 X85.732 Y97.72 E.00526
G1 X85.998 Y97.692 E.00526
G1 X86.388 Y97.71 E.00767
G1 X86.651 Y97.762 E.00526
G1 X86.902 Y97.843 E.0052
G1 X87.142 Y97.954 E.00519
G1 X87.37 Y98.095 E.00527
G1 X87.667 Y98.347 E.00767
G1 X87.843 Y98.549 E.00526
G1 X87.994 Y98.77 E.00526
G1 X88.164 Y99.124 E.00774
G1 X88.27 Y99.506 E.0078
G1 X88.305 Y99.901 E.00779
G1 X88.27 Y100.296 E.0078
G1 X88.162 Y100.682 E.00789
G1 X88.056 Y100.919 E.00511
G1 X87.919 Y101.149 E.00526
G1 X87.669 Y101.452 E.00773
G1 X87.369 Y101.707 E.00773
G1 X87.142 Y101.847 E.00526
G1 X86.906 Y101.957 E.00511
G1 X86.522 Y102.07 E.00788
G1 X86.127 Y102.111 E.0078
G1 X85.732 Y102.082 E.00779
G1 X85.348 Y101.982 E.0078
G1 X84.985 Y101.813 E.00788
G1 X84.768 Y101.669 E.00511
G1 X84.565 Y101.497 E.00526
G1 X84.306 Y101.201 E.00773
G1 X84.104 Y100.863 E.00774
G1 X84.003 Y100.615 E.00526
G1 X83.932 Y100.357 E.00526
G1 X83.885 Y99.967 E.00773
G1 X83.908 Y99.582 E.00758
; WIPE_START
M204 S6000
G1 X83.964 Y99.313 E-.05231
G1 X84.047 Y99.067 E-.04932
G1 X84.231 Y98.711 E-.07616
G1 X84.474 Y98.397 E-.07534
G1 X84.768 Y98.132 E-.07532
G1 X84.999 Y97.989 E-.05155
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X84.855 Y96.12 Z.84 F18000
G1 Z.44
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X92.678 Y96.12 E.16557
G1 X92.718 Y95.441 E.0144
G1 X92.743 Y95.323 E.00256
G1 X92.853 Y95.126 E.00477
G1 X92.931 Y95.051 E.0023
G1 X93.062 Y94.971 E.00324
G1 X93.225 Y94.928 E.00358
G1 X93.325 Y94.922 E.0021
G1 X93.534 Y94.974 E.00456
G1 X93.961 Y95.261 E.0109
G1 X95.879 Y94.633 E.04271
G1 X100.747 Y87.68 E.17964
G1 X101.043 Y87.888 E.00765
G1 X96.105 Y94.94 E.18222
G1 X93.244 Y96.216 E.06631
G1 X93.021 Y96.37 E.00573
G1 X92.803 Y96.453 E.00495
G1 X92.559 Y96.482 E.0052
G1 X87.59 Y96.482 E.10517
G1 X88.769 Y97.834 E.03798
G1 X88.89 Y98.001 E.00437
G1 X89.182 Y98.526 E.01271
G1 X89.322 Y98.897 E.00839
G1 X89.375 Y99.087 E.00417
G1 X89.451 Y99.499 E.00886
G1 X89.469 Y100.1 E.01273
G1 X89.385 Y100.672 E.01224
G1 X89.265 Y101.071 E.00881
G1 X89.008 Y101.615 E.01273
G1 X88.667 Y102.092 E.01241
G1 X88.379 Y102.392 E.00881
G1 X88.061 Y102.65 E.00867
G1 X87.543 Y102.955 E.01273
G1 X87.188 Y103.099 E.00811
G1 X86.792 Y103.208 E.00869
G1 X86.386 Y103.269 E.00868
G1 X86.003 Y103.28 E.00811
G1 X85.594 Y103.243 E.00869
G1 X85.202 Y103.161 E.0085
G1 X84.813 Y103.029 E.00869
G1 X84.287 Y102.757 E.01253
G1 X83.961 Y102.522 E.0085
G1 X83.666 Y102.251 E.00849
G1 X83.404 Y101.947 E.00849
G1 X83.181 Y101.613 E.0085
G1 X82.995 Y101.249 E.00866
G1 X82.807 Y100.686 E.01255
G1 X82.737 Y100.29 E.0085
G1 X82.715 Y99.89 E.00849
G1 X82.74 Y99.49 E.00847
G1 X82.816 Y99.081 E.00881
G1 X83.003 Y98.534 E.01224
G1 X83.192 Y98.17 E.00868
G1 X83.417 Y97.838 E.00849
G1 X84.597 Y96.482 E.03805
G1 X79.631 Y96.482 E.10513
G1 X79.392 Y96.454 E.00508
G1 X79.193 Y96.381 E.0045
G1 X79.062 Y96.301 E.00324
G1 X78.884 Y96.119 E.00539
G1 X78.833 Y96.041 E.00197
G1 X78.743 Y95.813 E.00521
G1 X78.714 Y95.565 E.00528
G1 X78.714 Y77.619 E.37984
G1 X78.755 Y77.34 E.00596
G1 X78.861 Y77.118 E.0052
G1 X78.956 Y76.998 E.00325
G1 X79.073 Y76.893 E.00333
G1 X79.294 Y76.775 E.00529
G1 X79.543 Y76.723 E.0054
G1 X92.563 Y76.72 E.27558
G1 X92.805 Y76.749 E.00515
G1 X92.942 Y76.794 E.00306
G1 X93.119 Y76.889 E.00424
G1 X93.07 Y77.082 E.0042
G1 X80.022 Y77.082 E.27618
G1 X79.657 Y77.168 E.00794
G1 X79.398 Y77.349 E.00669
G1 X79.233 Y77.546 E.00542
G1 X79.112 Y77.807 E.00609
G1 X79.075 Y78.056 E.00532
G1 X79.075 Y95.155 E.36192
G1 X79.128 Y95.453 E.0064
G1 X79.316 Y95.778 E.00796
G1 X79.676 Y96.047 E.00951
G1 X80.031 Y96.12 E.00767
G1 X84.795 Y96.12 E.10084
; WIPE_START
M204 S6000
G1 X86.795 Y96.12 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X83.699 Y96.891 Z.84 F18000
G1 Z.44
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X79.607 Y96.891 E.08049
G1 X79.297 Y96.855 E.00613
G1 X79.013 Y96.751 E.00594
G1 X78.822 Y96.633 E.00442
G1 X78.712 Y96.541 E.00283
G1 X78.558 Y96.369 E.00454
G1 X78.478 Y96.246 E.00289
G1 X78.41 Y96.11 E.00299
G1 X78.341 Y95.901 E.00431
G1 X78.304 Y95.589 E.00619
G1 X78.304 Y77.607 E.35368
G1 X78.313 Y77.454 E.00301
G1 X78.36 Y77.228 E.00454
G1 X78.409 Y77.093 E.00283
G1 X78.517 Y76.892 E.00448
G1 X78.657 Y76.716 E.00442
G1 X78.823 Y76.568 E.00438
G1 X78.947 Y76.486 E.00294
G1 X79.154 Y76.389 E.00448
G1 X79.373 Y76.33 E.00448
G1 X79.52 Y76.313 E.00289
G1 X92.588 Y76.311 E.25704
G1 X92.895 Y76.347 E.00608
G1 X93.105 Y76.417 E.00436
G1 X93.303 Y76.524 E.00442
G1 X93.479 Y76.663 E.00442
G1 X93.629 Y76.831 E.00442
G1 X93.746 Y77.022 E.00442
G1 X93.829 Y77.231 E.00442
G1 X93.874 Y77.448 E.00436
G1 X93.884 Y88.791 E.2231
G1 X92.704 Y88.791 E.02321
G1 X92.704 Y77.491 E.22226
G1 X80.07 Y77.491 E.24851
G1 X79.827 Y77.548 E.0049
G1 X79.677 Y77.654 E.00361
G1 X79.581 Y77.767 E.00292
G1 X79.508 Y77.925 E.00343
G1 X79.484 Y78.085 E.00318
G1 X79.484 Y95.119 E.33504
G1 X79.518 Y95.311 E.00382
G1 X79.628 Y95.501 E.00432
G1 X79.848 Y95.664 E.0054
G1 X80.073 Y95.711 E.00452
G1 X92.292 Y95.711 E.24035
G1 X92.312 Y95.386 E.00639
G1 X92.349 Y95.208 E.00359
G1 X92.477 Y94.944 E.00577
G1 X92.674 Y94.73 E.00572
G1 X92.922 Y94.585 E.00565
G1 X93.162 Y94.521 E.00489
G1 X93.442 Y94.523 E.00551
G1 X93.68 Y94.59 E.00487
G1 X93.777 Y94.637 E.00213
G1 X94.027 Y94.809 E.00595
G1 X95.622 Y94.286 E.03302
G1 X100.647 Y87.111 E.1723
G1 X101.613 Y87.787 E.02321
G1 X96.375 Y95.268 E.17962
G1 X93.445 Y96.575 E.06311
G1 X93.229 Y96.723 E.00516
G1 X93.102 Y96.786 E.00279
G1 X92.891 Y96.855 E.00437
G1 X92.582 Y96.891 E.00611
G1 X88.489 Y96.891 E.0805
G1 X89.089 Y97.579 E.01794
G1 X89.348 Y97.957 E.00901
G1 X89.556 Y98.359 E.00892
G1 X89.711 Y98.769 E.00862
G1 X89.774 Y98.994 E.0046
G1 X89.856 Y99.443 E.00897
G1 X89.877 Y99.661 E.0043
G1 X89.878 Y100.117 E.00897
G1 X89.859 Y100.335 E.00431
G1 X89.783 Y100.766 E.00862
G1 X89.65 Y101.212 E.00915
G1 X89.475 Y101.613 E.00862
G1 X89.244 Y102.009 E.00901
G1 X88.979 Y102.358 E.00862
G1 X88.656 Y102.693 E.00915
G1 X88.305 Y102.979 E.00891
G1 X88.124 Y103.102 E.0043
G1 X87.725 Y103.322 E.00897
G1 X87.313 Y103.489 E.00873
G1 X86.877 Y103.609 E.00891
G1 X86.429 Y103.676 E.00891
G1 X85.985 Y103.689 E.00873
G1 X85.534 Y103.649 E.00891
G1 X85.093 Y103.556 E.00885
G1 X84.664 Y103.41 E.00891
G1 X84.464 Y103.322 E.0043
G1 X84.068 Y103.103 E.00891
G1 X83.702 Y102.84 E.00885
G1 X83.371 Y102.536 E.00885
G1 X83.078 Y102.195 E.00885
M73 P36 R16
G1 X82.827 Y101.821 E.00885
G1 X82.621 Y101.418 E.0089
G1 X82.535 Y101.201 E.0046
G1 X82.408 Y100.781 E.00862
G1 X82.33 Y100.338 E.00885
G1 X82.305 Y99.889 E.00885
G1 X82.333 Y99.44 E.00884
G1 X82.418 Y98.983 E.00914
G1 X82.548 Y98.564 E.00862
G1 X82.631 Y98.362 E.00431
G1 X82.84 Y97.96 E.00891
G1 X83.093 Y97.588 E.00885
G1 X83.659 Y96.936 E.01698
; WIPE_START
M204 S6000
G1 X81.66 Y96.914 E-.38
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
G1 X79.54 Y96.249
G1 Z.44
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.139356
G1 F1500
M204 S6000
G1 X79.317 Y96.128 E.00144
; LINE_WIDTH: 0.148711
G1 X79.102 Y95.954 E.0017
G1 X78.942 Y95.627 E.00224
; WIPE_START
G1 X79.102 Y95.954 E-.21606
G1 X79.317 Y96.128 E-.16394
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X84.63 Y97.174 Z.84 F18000
G1 Z.44
G1 E.4 F1800
; LINE_WIDTH: 0.473051
G1 F1500
M204 S6000
G1 X84.46 Y97.318 E.00499
; LINE_WIDTH: 0.438158
G1 X84.263 Y97.487 E.00533
; LINE_WIDTH: 0.401772
G1 X84.085 Y97.669 E.00478
; LINE_WIDTH: 0.359574
G1 X83.886 Y97.872 E.00473
G1 X83.559 Y98.3 E.00898
G1 X83.318 Y98.77 E.00879
G1 X83.186 Y99.173 E.00706
G1 X83.119 Y99.537 E.00617
G1 X83.098 Y100.005 E.0078
G1 X83.178 Y100.595 E.00992
G1 X83.345 Y101.095 E.00878
G1 X83.512 Y101.418 E.00606
G1 X83.708 Y101.716 E.00593
G1 X84.021 Y102.066 E.00782
G1 X84.202 Y102.226 E.00403
G1 X84.489 Y102.433 E.00589
G1 X84.957 Y102.673 E.00876
G1 X85.303 Y102.79 E.00608
G1 X85.648 Y102.867 E.00589
G1 X86.124 Y102.899 E.00795
G1 X86.69 Y102.841 E.00947
G1 X87.173 Y102.698 E.00839
G1 X87.506 Y102.543 E.00612
G1 X87.839 Y102.342 E.00648
G1 X88.22 Y102.015 E.00836
G1 X88.553 Y101.61 E.00874
G1 X88.748 Y101.29 E.00625
G1 X88.909 Y100.938 E.00644
G1 X89.047 Y100.423 E.00888
G1 X89.089 Y99.915 E.00848
G1 X89.083 Y99.702 E.00356
G1 X89.001 Y99.176 E.00886
G1 X88.894 Y98.835 E.00596
G1 X88.671 Y98.364 E.00867
G1 X88.47 Y98.069 E.00594
G1 X88.213 Y97.775 E.00651
; LINE_WIDTH: 0.380155
G1 X88.041 Y97.605 E.00428
; LINE_WIDTH: 0.419422
G1 X87.842 Y97.412 E.00544
; LINE_WIDTH: 0.455549
G1 X87.692 Y97.286 E.0042
; LINE_WIDTH: 0.480562
G1 X87.541 Y97.161 E.00444
; WIPE_START
G1 X87.692 Y97.286 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X94.012 Y95.553 Z.84 F18000
G1 Z.44
G1 E.4 F1800
; LINE_WIDTH: 0.153726
G1 F1500
M204 S6000
G1 X94.514 Y95.359 E.00344
; LINE_WIDTH: 0.104407
G1 X95.017 Y95.165 E.00211
; WIPE_START
G1 X94.514 Y95.359 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X89.483 Y89.619 Z.84 F18000
G1 X78.949 Y77.601 Z.84
G1 Z.44
G1 E.4 F1800
; LINE_WIDTH: 0.0965624
G1 F1500
M204 S6000
G1 X79.011 Y77.411 E.00071
; LINE_WIDTH: 0.15048
G1 X79.204 Y77.15 E.00202
G1 X79.548 Y76.936 E.00252
; CHANGE_LAYER
; Z_HEIGHT: 0.56
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F1500
G1 X79.204 Y77.15 E-.21107
G1 X79.011 Y77.411 E-.16893
; WIPE_END
G1 E-.02 F1800
; layer num/total_layer_count: 4/57
; update layer progress
M73 L4
M991 S0 P3 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z.84 I-.261 J1.189 P1  F18000
M73 P36 R15
G1 X93.468 Y80.581 Z.84
G1 Z.56
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X93.475 Y88.382 E.1651
G1 X93.114 Y88.382 E.00764
G1 X93.114 Y77.128 E.23818
G1 X93.299 Y77.076 E.00407
G1 X93.379 Y77.207 E.00325
G1 X93.436 Y77.349 E.00324
G1 X93.465 Y77.49 E.00306
G1 X93.468 Y80.521 E.06416
; WIPE_START
M204 S6000
G1 X93.469 Y82.521 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X93.584 Y90.153 Z.96 F18000
G1 X93.665 Y95.564 Z.96
G1 Z.56
G1 E.4 F1800
G1 F1500
M204 S500
G1 X93.121 Y95.806 E.0126
G1 X93.14 Y95.498 E.00653
G1 X93.173 Y95.407 E.00206
G1 X93.212 Y95.37 E.00113
G1 X93.32 Y95.341 E.00236
G1 X93.615 Y95.531 E.00743
; WIPE_START
M204 S6000
G1 X93.121 Y95.806 E-.14431
G1 X93.14 Y95.498 E-.0789
G1 X93.173 Y95.407 E-.02487
G1 X93.212 Y95.37 E-.01363
G1 X93.32 Y95.341 E-.02856
G1 X93.615 Y95.531 E-.08974
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X86.105 Y96.895 Z.96 F18000
G1 X84.866 Y97.12 Z.96
G1 Z.56
G1 E.4 F1800
G1 F1500
M204 S500
G1 X84.747 Y96.956 E.00429
G1 X85.105 Y96.544 E.01155
G1 X87.084 Y96.544 E.04188
G1 X87.437 Y96.951 E.0114
G1 X87.314 Y97.115 E.00436
G1 X87.193 Y97.059 E.00282
G1 X86.699 Y96.915 E.0109
G1 X86.322 Y96.864 E.00804
G1 X85.942 Y96.858 E.00804
G1 X85.432 Y96.928 E.0109
G1 X85.067 Y97.034 E.00803
G1 X84.922 Y97.096 E.00335
; WIPE_START
M204 S6000
G1 X84.747 Y96.956 E-.04255
G1 X85.105 Y96.544 E-.10364
G1 X86.336 Y96.544 E-.23381
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X83.517 Y99.447 Z.96 F18000
G1 Z.56
G1 E.4 F1800
G1 F1500
M204 S500
G1 X83.568 Y99.204 E.00526
G1 X83.669 Y98.909 E.0066
G1 X83.884 Y98.49 E.00997
G1 X84.172 Y98.118 E.00997
G1 X84.522 Y97.803 E.00995
G1 X84.914 Y97.561 E.00975
G1 X85.211 Y97.434 E.00683
G1 X85.52 Y97.344 E.00683
G1 X85.968 Y97.283 E.00956
G1 X86.29 Y97.288 E.00683
G1 X86.61 Y97.331 E.00683
G1 X87.043 Y97.458 E.00955
G1 X87.336 Y97.593 E.00683
G1 X87.611 Y97.763 E.00683
G1 X87.955 Y98.055 E.00955
G1 X88.167 Y98.298 E.00683
G1 X88.349 Y98.564 E.00683
G1 X88.549 Y98.98 E.00975
G1 X88.674 Y99.433 E.00995
G1 X88.715 Y99.892 E.00975
G1 X88.696 Y100.214 E.00683
G1 X88.638 Y100.531 E.00683
G1 X88.49 Y100.967 E.00975
G1 X88.261 Y101.378 E.00995
G1 X87.962 Y101.741 E.00995
G1 X87.611 Y102.039 E.00975
G1 X87.336 Y102.208 E.00682
G1 X87.054 Y102.34 E.0066
G1 X86.602 Y102.473 E.00997
G1 X86.143 Y102.521 E.00977
G1 X85.821 Y102.507 E.00683
G1 X85.502 Y102.454 E.00683
G1 X85.064 Y102.312 E.00975
G1 X84.65 Y102.089 E.00995
G1 X84.283 Y101.796 E.00995
G1 X83.979 Y101.449 E.00975
G1 X83.806 Y101.177 E.00682
G1 X83.67 Y100.897 E.0066
G1 X83.53 Y100.447 E.00997
G1 X83.474 Y99.979 E.00997
G1 X83.501 Y99.519 E.00975
G1 X83.504 Y99.506 E.00029
M204 S250
G1 X83.917 Y99.532 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X83.964 Y99.313 E.00441
G1 X84.046 Y99.069 E.00506
G1 X84.231 Y98.711 E.00793
G1 X84.474 Y98.397 E.0078
G1 X84.768 Y98.132 E.0078
G1 X85.103 Y97.925 E.00773
G1 X85.349 Y97.82 E.00526
G1 X85.605 Y97.745 E.00526
G1 X85.992 Y97.693 E.00767
G1 X86.26 Y97.697 E.00526
G1 X86.525 Y97.733 E.00526
G1 X86.899 Y97.842 E.00767
G1 X87.142 Y97.954 E.00526
G1 X87.369 Y98.095 E.00526
G1 X87.667 Y98.347 E.00767
G1 X87.843 Y98.549 E.00526
G1 X87.994 Y98.77 E.00526
G1 X88.164 Y99.124 E.00774
G1 X88.27 Y99.506 E.0078
G1 X88.305 Y99.898 E.00773
G1 X88.289 Y100.165 E.00526
G1 X88.241 Y100.428 E.00526
G1 X88.114 Y100.8 E.00773
G1 X87.921 Y101.146 E.0078
G1 X87.669 Y101.452 E.0078
G1 X87.369 Y101.707 E.00773
G1 X87.142 Y101.847 E.00526
G1 X86.909 Y101.956 E.00506
G1 X86.522 Y102.07 E.00793
G1 X86.131 Y102.111 E.00774
G1 X85.863 Y102.099 E.00526
G1 X85.599 Y102.055 E.00526
G1 X85.226 Y101.934 E.00773
G1 X84.877 Y101.746 E.0078
G1 X84.567 Y101.499 E.0078
G1 X84.308 Y101.203 E.00773
G1 X84.164 Y100.977 E.00526
G1 X84.052 Y100.746 E.00506
G1 X83.932 Y100.361 E.00793
G1 X83.885 Y99.967 E.0078
G1 X83.907 Y99.591 E.0074
; WIPE_START
M204 S6000
G1 X83.964 Y99.313 E-.054
G1 X84.046 Y99.069 E-.04885
G1 X84.231 Y98.711 E-.07662
G1 X84.474 Y98.397 E-.07536
G1 X84.768 Y98.132 E-.07532
G1 X84.992 Y97.994 E-.04986
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X84.855 Y96.12 Z.96 F18000
G1 Z.56
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X92.678 Y96.12 E.16557
G1 X92.718 Y95.441 E.01439
G1 X92.743 Y95.322 E.00258
G1 X92.854 Y95.125 E.00478
G1 X92.931 Y95.051 E.00228
G1 X93.063 Y94.97 E.00326
G1 X93.276 Y94.922 E.00464
G1 X93.443 Y94.941 E.00354
G1 X93.539 Y94.978 E.00219
G1 X93.972 Y95.257 E.01091
G1 X95.879 Y94.633 E.04247
G1 X100.747 Y87.68 E.17964
G1 X101.043 Y87.888 E.00765
G1 X96.105 Y94.94 E.18222
G1 X93.244 Y96.216 E.06631
G1 X93.021 Y96.37 E.00573
G1 X92.803 Y96.453 E.00494
G1 X92.559 Y96.482 E.0052
G1 X87.591 Y96.482 E.10514
G1 X88.777 Y97.845 E.03825
G1 X88.884 Y97.993 E.00386
G1 X89.099 Y98.353 E.00888
G1 X89.323 Y98.901 E.01254
G1 X89.45 Y99.489 E.01273
G1 X89.469 Y100.1 E.01292
G1 X89.385 Y100.668 E.01215
G1 X89.265 Y101.071 E.00891
G1 X89.013 Y101.607 E.01253
G1 X88.785 Y101.947 E.00866
G1 X88.517 Y102.258 E.00869
G1 X88.075 Y102.639 E.01235
G1 X87.908 Y102.753 E.00428
G1 X87.559 Y102.947 E.00846
G1 X87.374 Y103.029 E.00428
G1 X86.995 Y103.158 E.00846
G1 X86.8 Y103.207 E.00427
G1 X86.386 Y103.269 E.00885
G1 X85.794 Y103.267 E.01254
G1 X85.21 Y103.164 E.01254
G1 X84.814 Y103.029 E.00886
G1 X84.287 Y102.757 E.01255
G1 X83.961 Y102.522 E.0085
G1 X83.666 Y102.251 E.00849
G1 X83.404 Y101.947 E.00849
G1 X83.181 Y101.613 E.00849
G1 X82.994 Y101.248 E.00869
G1 X82.812 Y100.703 E.01215
G1 X82.737 Y100.289 E.0089
G1 X82.715 Y99.89 E.00847
G1 X82.74 Y99.49 E.00849
G1 X82.812 Y99.095 E.0085
G1 X82.933 Y98.704 E.00866
G1 X83.011 Y98.518 E.00427
G1 X83.192 Y98.17 E.0083
G1 X83.417 Y97.838 E.0085
G1 X84.597 Y96.482 E.03805
G1 X79.631 Y96.482 E.10513
G1 X79.383 Y96.453 E.00528
G1 X79.243 Y96.407 E.00311
G1 X78.981 Y96.229 E.0067
G1 X78.833 Y96.041 E.00508
G1 X78.743 Y95.812 E.0052
G1 X78.714 Y95.565 E.00527
G1 X78.714 Y77.619 E.37984
G1 X78.755 Y77.34 E.00597
G1 X78.865 Y77.11 E.00539
G1 X79.03 Y76.928 E.0052
G1 X79.155 Y76.84 E.00324
G1 X79.295 Y76.775 E.00325
G1 X79.544 Y76.723 E.00541
G1 X92.565 Y76.72 E.27559
G1 X92.805 Y76.749 E.00512
G1 X92.942 Y76.794 E.00306
G1 X93.119 Y76.889 E.00424
G1 X93.07 Y77.082 E.0042
G1 X80.058 Y77.082 E.2754
G1 X79.849 Y77.106 E.00446
G1 X79.556 Y77.223 E.00668
G1 X79.249 Y77.512 E.00892
G1 X79.112 Y77.806 E.00688
G1 X79.075 Y78.055 E.00533
G1 X79.075 Y95.155 E.36193
G1 X79.128 Y95.452 E.00639
G1 X79.315 Y95.778 E.00796
G1 X79.676 Y96.047 E.00952
G1 X80.031 Y96.12 E.00768
G1 X84.795 Y96.12 E.10083
; WIPE_START
M204 S6000
G1 X86.795 Y96.12 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X83.699 Y96.891 Z.96 F18000
G1 Z.56
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X79.607 Y96.891 E.08049
G1 X79.294 Y96.854 E.00619
G1 X79.087 Y96.786 E.00428
G1 X78.955 Y96.72 E.0029
G1 X78.703 Y96.532 E.0062
G1 X78.558 Y96.369 E.00428
G1 X78.477 Y96.246 E.0029
G1 X78.412 Y96.114 E.00289
G1 X78.341 Y95.901 E.00442
G1 X78.304 Y95.589 E.00619
G1 X78.304 Y77.607 E.35368
G1 X78.313 Y77.454 E.00301
G1 X78.36 Y77.228 E.00454
G1 X78.409 Y77.093 E.00283
G1 X78.519 Y76.89 E.00454
G1 X78.605 Y76.774 E.00283
G1 X78.766 Y76.613 E.00448
G1 X78.95 Y76.484 E.00442
G1 X79.154 Y76.389 E.00442
G1 X79.367 Y76.332 E.00434
G1 X79.52 Y76.313 E.00303
G1 X92.589 Y76.311 E.25706
G1 X92.894 Y76.347 E.00605
G1 X93.105 Y76.417 E.00436
G1 X93.303 Y76.524 E.00441
G1 X93.479 Y76.663 E.00443
G1 X93.629 Y76.831 E.00442
M73 P37 R15
G1 X93.746 Y77.022 E.00442
G1 X93.829 Y77.231 E.00442
G1 X93.874 Y77.448 E.00436
G1 X93.884 Y88.791 E.2231
G1 X92.704 Y88.791 E.02321
G1 X92.704 Y77.491 E.22226
G1 X80.082 Y77.491 E.24827
G1 X79.95 Y77.506 E.00262
G1 X79.78 Y77.574 E.00361
G1 X79.587 Y77.756 E.00521
G1 X79.508 Y77.925 E.00367
G1 X79.484 Y78.085 E.00318
G1 X79.484 Y95.119 E.33504
G1 X79.518 Y95.31 E.00382
G1 X79.628 Y95.5 E.00431
G1 X79.848 Y95.664 E.0054
G1 X80.073 Y95.711 E.00453
G1 X92.292 Y95.711 E.24034
G1 X92.312 Y95.387 E.00639
G1 X92.349 Y95.208 E.00359
G1 X92.477 Y94.944 E.00576
G1 X92.674 Y94.73 E.00572
G1 X92.922 Y94.584 E.00565
G1 X93.16 Y94.521 E.00486
G1 X93.451 Y94.524 E.00572
G1 X93.725 Y94.611 E.00565
G1 X94.03 Y94.807 E.00714
G1 X95.622 Y94.286 E.03295
G1 X100.647 Y87.111 E.1723
G1 X101.613 Y87.787 E.02321
G1 X96.375 Y95.268 E.17961
G1 X93.445 Y96.575 E.06311
G1 X93.229 Y96.723 E.00516
G1 X93.102 Y96.786 E.00279
G1 X92.891 Y96.855 E.00436
G1 X92.582 Y96.891 E.00611
G1 X88.49 Y96.891 E.08049
G1 X89.098 Y97.59 E.01823
G1 X89.227 Y97.767 E.0043
G1 X89.46 Y98.159 E.00897
G1 X89.555 Y98.356 E.00431
G1 X89.715 Y98.78 E.00891
G1 X89.823 Y99.22 E.00891
G1 X89.877 Y99.661 E.00873
G1 X89.878 Y100.117 E.00897
G1 X89.859 Y100.335 E.00431
G1 X89.784 Y100.762 E.00853
G1 X89.65 Y101.212 E.00924
G1 X89.477 Y101.609 E.00852
G1 X89.363 Y101.819 E.00469
G1 X89.111 Y102.195 E.0089
G1 X88.816 Y102.538 E.00891
G1 X88.659 Y102.691 E.00431
G1 X88.32 Y102.967 E.00859
G1 X88.123 Y103.102 E.00469
G1 X87.742 Y103.313 E.00858
G1 X87.524 Y103.411 E.0047
G1 X87.111 Y103.551 E.00858
G1 X86.879 Y103.609 E.00469
G1 X86.429 Y103.676 E.00896
G1 X86.21 Y103.689 E.00431
G1 X85.757 Y103.675 E.00891
G1 X85.309 Y103.608 E.00891
G1 X85.096 Y103.557 E.00431
G1 X84.665 Y103.411 E.00897
G1 X84.447 Y103.313 E.00469
G1 X84.068 Y103.103 E.00853
G1 X83.703 Y102.84 E.00885
G1 X83.371 Y102.536 E.00885
G1 X83.078 Y102.195 E.00885
G1 X82.827 Y101.821 E.00885
G1 X82.621 Y101.417 E.00891
G1 X82.54 Y101.215 E.0043
G1 X82.413 Y100.8 E.00853
G1 X82.33 Y100.337 E.00923
G1 X82.305 Y99.889 E.00884
G1 X82.333 Y99.44 E.00885
G1 X82.414 Y98.997 E.00885
G1 X82.548 Y98.565 E.0089
G1 X82.639 Y98.345 E.00469
G1 X82.84 Y97.96 E.00853
G1 X83.093 Y97.588 E.00885
G1 X83.66 Y96.936 E.01698
; WIPE_START
M204 S6000
G1 X81.66 Y96.914 E-.38
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




G1 X79.484 Y96.245
G1 Z.56
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.149903
G1 F1500
M204 S6000
G1 X79.102 Y95.954 E.00297
G1 X78.942 Y95.626 E.00226
; WIPE_START
G1 X79.102 Y95.954 E-.16415
G1 X79.484 Y96.245 E-.21585
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X84.638 Y97.167 Z.96 F18000
G1 Z.56
G1 E.4 F1800
; LINE_WIDTH: 0.475214
G1 F1500
M204 S6000
G1 X84.464 Y97.315 E.00513
; LINE_WIDTH: 0.438819
G1 X84.263 Y97.487 E.00545
; LINE_WIDTH: 0.401746
G1 X84.085 Y97.669 E.00478
; LINE_WIDTH: 0.359197
G1 X83.722 Y98.073 E.00903
G1 X83.521 Y98.364 E.00589
G1 X83.317 Y98.773 E.0076
G1 X83.183 Y99.186 E.00722
G1 X83.119 Y99.536 E.00592
G1 X83.098 Y100.005 E.00781
G1 X83.165 Y100.54 E.00897
G1 X83.315 Y101.024 E.00842
G1 X83.481 Y101.37 E.00639
G1 X83.708 Y101.716 E.00688
G1 X84.012 Y102.058 E.00761
G1 X84.43 Y102.395 E.00894
G1 X84.931 Y102.661 E.00943
G1 X85.314 Y102.795 E.00676
G1 X85.827 Y102.888 E.00867
G1 X86.349 Y102.886 E.00868
G1 X86.689 Y102.836 E.00572
G1 X87.175 Y102.693 E.00842
G1 X87.523 Y102.533 E.00637
G1 X87.85 Y102.333 E.00639
G1 X88.244 Y101.994 E.00864
G1 X88.58 Y101.577 E.0089
G1 X88.825 Y101.132 E.00845
G1 X89.001 Y100.638 E.00872
G1 X89.074 Y100.249 E.00659
G1 X89.083 Y99.696 E.0092
G1 X89.045 Y99.38 E.0053
G1 X88.956 Y99.015 E.00625
G1 X88.759 Y98.532 E.00867
G1 X88.476 Y98.077 E.00891
G1 X88.213 Y97.775 E.00667
; LINE_WIDTH: 0.380242
G1 X88.04 Y97.605 E.00429
; LINE_WIDTH: 0.419776
G1 X87.842 Y97.411 E.00545
; LINE_WIDTH: 0.468114
G1 X87.544 Y97.162 E.00858
; WIPE_START
G1 X87.842 Y97.411 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X94.029 Y95.546 Z.96 F18000
G1 Z.56
G1 E.4 F1800
; LINE_WIDTH: 0.152247
G1 F1500
M204 S6000
G1 X94.523 Y95.356 E.00334
; LINE_WIDTH: 0.103914
G1 X95.017 Y95.165 E.00206
; WIPE_START
G1 X94.523 Y95.356 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X89.49 Y89.618 Z.96 F18000
G1 X78.949 Y77.601 Z.96
G1 Z.56
G1 E.4 F1800
; LINE_WIDTH: 0.0890922
G1 F1500
M204 S6000
G1 X78.988 Y77.484 E.00039
; LINE_WIDTH: 0.115449
G1 X79.026 Y77.366 E.00056
; LINE_WIDTH: 0.159996
G1 X79.101 Y77.265 E.00084
G1 X79.3 Y77.086 E.00179
; LINE_WIDTH: 0.138217
G1 X79.387 Y77.022 E.0006
; LINE_WIDTH: 0.0990063
G1 X79.591 Y76.957 E.00078
; CHANGE_LAYER
; Z_HEIGHT: 0.68
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F1500
G1 X79.387 Y77.022 E-.38
; WIPE_END
G1 E-.02 F1800
; layer num/total_layer_count: 5/57
; update layer progress
M73 L5
M991 S0 P4 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z.96 I-.298 J1.18 P1  F18000
G1 X93.468 Y80.581 Z.96
G1 Z.68
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X93.475 Y88.382 E.1651
G1 X93.114 Y88.382 E.00764
G1 X93.114 Y77.128 E.23818
G1 X93.299 Y77.076 E.00407
G1 X93.379 Y77.207 E.00325
G1 X93.436 Y77.349 E.00324
G1 X93.465 Y77.49 E.00306
G1 X93.468 Y80.522 E.06416
; WIPE_START
M204 S6000
G1 X93.469 Y82.522 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X93.575 Y90.153 Z1.08 F18000
G1 X93.65 Y95.57 Z1.08
G1 Z.68
G1 E.4 F1800
G1 F1500
M204 S500
G1 X93.122 Y95.806 E.01226
G1 X93.14 Y95.498 E.00653
G1 X93.166 Y95.413 E.00188
G1 X93.211 Y95.37 E.00133
G1 X93.295 Y95.348 E.00183
G1 X93.379 Y95.372 E.00187
G1 X93.602 Y95.535 E.00584
; WIPE_START
M204 S6000
G1 X93.122 Y95.806 E-.14339
G1 X93.14 Y95.498 E-.08022
G1 X93.166 Y95.413 E-.02305
G1 X93.211 Y95.37 E-.01629
G1 X93.295 Y95.348 E-.02245
G1 X93.379 Y95.372 E-.0229
G1 X93.602 Y95.535 E-.0717
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X86.093 Y96.901 Z1.08 F18000
G1 X84.856 Y97.126 Z1.08
G1 Z.68
G1 E.4 F1800
G1 F1500
M204 S500
G1 X84.741 Y96.963 E.00423
G1 X85.105 Y96.544 E.01174
G1 X87.084 Y96.544 E.04188
G1 X87.43 Y96.942 E.01117
G1 X87.323 Y97.104 E.0041
G1 X86.861 Y96.953 E.0103
G1 X86.488 Y96.88 E.00804
G1 X85.973 Y96.857 E.0109
G1 X85.596 Y96.897 E.00804
G1 X85.225 Y96.981 E.00805
G1 X84.912 Y97.104 E.00712
; WIPE_START
M204 S6000
G1 X84.741 Y96.963 E-.04213
G1 X85.105 Y96.544 E-.10541
G1 X86.329 Y96.544 E-.23246
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X83.512 Y99.484 Z1.08 F18000
G1 Z.68
G1 E.4 F1800
G1 F1500
M204 S500
G1 X83.533 Y99.347 E.00294
G1 X83.669 Y98.907 E.00975
G1 X83.885 Y98.489 E.00995
G1 X84.172 Y98.118 E.00995
G1 X84.522 Y97.803 E.00995
G1 X84.922 Y97.556 E.00995
G1 X85.35 Y97.388 E.00975
G1 X85.665 Y97.316 E.00683
G1 X85.986 Y97.282 E.00683
G1 X86.437 Y97.302 E.00955
G1 X86.754 Y97.365 E.00683
G1 X87.061 Y97.465 E.00683
G1 X87.473 Y97.671 E.00975
G1 X87.841 Y97.947 E.00975
G1 X88.068 Y98.177 E.00683
G1 X88.266 Y98.433 E.00686
G1 X88.49 Y98.839 E.00982
G1 X88.598 Y99.129 E.00655
G1 X88.675 Y99.442 E.00682
G1 X88.716 Y99.901 E.00975
G1 X88.674 Y100.37 E.00997
G1 X88.546 Y100.826 E.01002
G1 X88.42 Y101.108 E.00654
G1 X88.255 Y101.385 E.00682
G1 X87.962 Y101.741 E.00975
G1 X87.611 Y102.039 E.00975
G1 X87.337 Y102.208 E.00682
G1 X87.056 Y102.338 E.00654
G1 X86.602 Y102.473 E.01002
G1 X86.143 Y102.521 E.00978
G1 X85.821 Y102.507 E.00682
G1 X85.516 Y102.457 E.00654
G1 X85.065 Y102.312 E.01002
G1 X84.65 Y102.089 E.00998
G1 X84.29 Y101.802 E.00975
G1 X84.07 Y101.565 E.00683
G1 X83.881 Y101.304 E.00683
G1 X83.669 Y100.895 E.00975
G1 X83.53 Y100.446 E.00995
G1 X83.475 Y99.989 E.00975
G1 X83.485 Y99.666 E.00683
G1 X83.503 Y99.543 E.00263
M204 S250
G1 X83.917 Y99.545 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X83.933 Y99.438 E.00213
G1 X84.049 Y99.062 E.00773
G1 X84.231 Y98.711 E.00779
G1 X84.474 Y98.397 E.00779
G1 X84.768 Y98.132 E.0078
G1 X85.105 Y97.924 E.0078
G1 X85.471 Y97.78 E.00773
G1 X85.732 Y97.72 E.00526
G1 X85.998 Y97.692 E.00526
G1 X86.388 Y97.71 E.00767
G1 X86.651 Y97.762 E.00526
G1 X86.905 Y97.844 E.00526
G1 X87.257 Y98.02 E.00774
G1 X87.571 Y98.256 E.00773
G1 X87.759 Y98.447 E.00526
G1 X87.923 Y98.659 E.00527
G1 X88.118 Y99.011 E.00792
G1 X88.207 Y99.25 E.00501
G1 X88.27 Y99.509 E.00526
G1 X88.305 Y99.901 E.00773
G1 X88.27 Y100.296 E.0078
G1 X88.16 Y100.687 E.00798
G1 X88.056 Y100.919 E.00501
G1 X87.919 Y101.149 E.00526
G1 X87.669 Y101.452 E.00773
G1 X87.369 Y101.707 E.00773
G1 X87.142 Y101.847 E.00526
G1 X86.911 Y101.955 E.00501
G1 X86.522 Y102.07 E.00798
G1 X86.131 Y102.111 E.00774
G1 X85.864 Y102.099 E.00525
G1 X85.612 Y102.058 E.00501
G1 X85.226 Y101.934 E.00798
G1 X84.876 Y101.746 E.00781
G1 X84.569 Y101.501 E.00773
G1 X84.387 Y101.305 E.00526
G1 X84.23 Y101.088 E.00526
G1 X84.049 Y100.739 E.00773
G1 X83.932 Y100.361 E.0078
G1 X83.885 Y99.97 E.00773
G1 X83.893 Y99.703 E.00526
G1 X83.908 Y99.604 E.00196
; WIPE_START
M204 S6000
G1 X83.933 Y99.438 E-.03194
G1 X84.049 Y99.062 E-.07472
G1 X84.231 Y98.711 E-.0753
G1 X84.474 Y98.397 E-.07529
G1 X84.768 Y98.132 E-.07532
G1 X84.981 Y98.001 E-.04744
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X84.855 Y96.12 Z1.08 F18000
G1 Z.68
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X92.678 Y96.12 E.16558
G1 X92.718 Y95.441 E.01439
G1 X92.742 Y95.331 E.00238
G1 X92.784 Y95.227 E.00238
G1 X92.855 Y95.124 E.00264
G1 X92.931 Y95.051 E.00225
G1 X93.063 Y94.97 E.00326
G1 X93.277 Y94.922 E.00466
G1 X93.373 Y94.929 E.00203
G1 X93.53 Y94.974 E.00345
G1 X93.95 Y95.264 E.01082
G1 X95.879 Y94.633 E.04295
G1 X100.747 Y87.68 E.17964
G1 X101.043 Y87.888 E.00765
G1 X96.105 Y94.94 E.18222
G1 X93.244 Y96.216 E.0663
G1 X93.021 Y96.37 E.00573
G1 X92.803 Y96.453 E.00495
G1 X92.559 Y96.482 E.0052
G1 X87.591 Y96.482 E.10514
G1 X88.777 Y97.845 E.03825
G1 X89.095 Y98.345 E.01254
G1 X89.253 Y98.699 E.00821
G1 X89.375 Y99.086 E.00858
G1 X89.467 Y99.68 E.01273
G1 X89.453 Y100.282 E.01274
G1 X89.386 Y100.664 E.0082
G1 X89.265 Y101.071 E.00901
G1 X89.012 Y101.607 E.01253
G1 X88.785 Y101.947 E.00865
G1 X88.517 Y102.258 E.00869
G1 X88.061 Y102.65 E.01273
G1 X87.562 Y102.945 E.01226
G1 X87.188 Y103.099 E.00857
G1 X86.792 Y103.208 E.00869
G1 X86.386 Y103.269 E.00869
G1 X85.794 Y103.267 E.01254
G1 X85.201 Y103.161 E.01273
G1 X84.638 Y102.951 E.01273
G1 X84.287 Y102.757 E.00849
G1 X83.961 Y102.522 E.00849
G1 X83.666 Y102.251 E.00849
G1 X83.404 Y101.947 E.00849
G1 X83.181 Y101.613 E.00849
G1 X82.926 Y101.078 E.01255
G1 X82.813 Y100.708 E.0082
G1 X82.737 Y100.289 E.009
G1 X82.715 Y99.89 E.00846
G1 X82.74 Y99.49 E.00849
G1 X82.812 Y99.095 E.00849
G1 X82.933 Y98.704 E.00865
M73 P38 R15
G1 X83.013 Y98.514 E.00436
G1 X83.192 Y98.17 E.00821
G1 X83.417 Y97.838 E.0085
G1 X84.597 Y96.482 E.03805
G1 X79.63 Y96.482 E.10513
G1 X79.392 Y96.454 E.00508
G1 X79.192 Y96.381 E.0045
G1 X79.062 Y96.301 E.00324
G1 X78.884 Y96.119 E.00539
G1 X78.833 Y96.042 E.00195
G1 X78.743 Y95.813 E.00521
G1 X78.714 Y95.565 E.00528
G1 X78.714 Y77.619 E.37984
G1 X78.755 Y77.34 E.00597
G1 X78.86 Y77.118 E.0052
G1 X78.956 Y76.998 E.00326
G1 X79.071 Y76.895 E.00327
G1 X79.295 Y76.775 E.00536
G1 X79.545 Y76.723 E.00541
G1 X92.567 Y76.72 E.27562
G1 X92.805 Y76.749 E.00508
G1 X92.942 Y76.794 E.00306
G1 X93.119 Y76.889 E.00424
G1 X93.07 Y77.082 E.0042
G1 X80.049 Y77.082 E.2756
G1 X79.809 Y77.117 E.00513
G1 X79.549 Y77.229 E.006
G1 X79.249 Y77.512 E.00872
G1 X79.112 Y77.807 E.00689
G1 X79.075 Y78.055 E.00532
G1 X79.075 Y95.155 E.36193
G1 X79.128 Y95.453 E.0064
G1 X79.316 Y95.778 E.00795
G1 X79.676 Y96.047 E.00951
G1 X80.031 Y96.12 E.00767
G1 X84.795 Y96.12 E.10083
; WIPE_START
M204 S6000
G1 X86.795 Y96.12 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X83.699 Y96.891 Z1.08 F18000
G1 Z.68
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X79.607 Y96.891 E.08049
G1 X79.297 Y96.855 E.00613
G1 X79.013 Y96.751 E.00595
G1 X78.822 Y96.633 E.00442
G1 X78.712 Y96.541 E.00283
G1 X78.558 Y96.368 E.00454
G1 X78.478 Y96.246 E.00288
G1 X78.408 Y96.107 E.00306
G1 X78.341 Y95.901 E.00425
G1 X78.304 Y95.589 E.00619
G1 X78.304 Y77.607 E.35368
G1 X78.313 Y77.454 E.00301
G1 X78.36 Y77.228 E.00454
G1 X78.409 Y77.093 E.00283
G1 X78.517 Y76.892 E.00448
G1 X78.657 Y76.716 E.00443
G1 X78.82 Y76.57 E.00431
G1 X78.947 Y76.486 E.003
G1 X79.154 Y76.389 E.00448
G1 X79.365 Y76.332 E.00431
G1 X79.52 Y76.313 E.00306
G1 X92.591 Y76.311 E.25709
G1 X92.894 Y76.347 E.00601
G1 X93.105 Y76.417 E.00436
G1 X93.303 Y76.524 E.00442
G1 X93.479 Y76.663 E.00442
G1 X93.629 Y76.831 E.00442
G1 X93.746 Y77.022 E.00442
G1 X93.829 Y77.231 E.00442
G1 X93.874 Y77.448 E.00436
G1 X93.884 Y88.791 E.2231
G1 X92.704 Y88.791 E.02321
G1 X92.704 Y77.491 E.22226
G1 X80.079 Y77.491 E.24833
G1 X79.922 Y77.514 E.00312
G1 X79.777 Y77.576 E.0031
G1 X79.587 Y77.756 E.00515
G1 X79.508 Y77.925 E.00368
G1 X79.484 Y78.085 E.00318
G1 X79.484 Y95.119 E.33504
G1 X79.518 Y95.311 E.00383
G1 X79.628 Y95.501 E.00431
G1 X79.848 Y95.664 E.00539
G1 X80.073 Y95.711 E.00452
G1 X92.292 Y95.711 E.24034
G1 X92.312 Y95.387 E.00639
G1 X92.349 Y95.211 E.00353
G1 X92.417 Y95.044 E.00353
G1 X92.549 Y94.85 E.00463
G1 X92.674 Y94.73 E.0034
G1 X92.922 Y94.585 E.00565
G1 X93.16 Y94.521 E.00486
G1 X93.444 Y94.523 E.00558
G1 X93.683 Y94.592 E.00489
G1 X93.833 Y94.671 E.00333
G1 X94.023 Y94.81 E.00463
G1 X95.622 Y94.286 E.0331
G1 X100.647 Y87.111 E.1723
G1 X101.613 Y87.787 E.02321
G1 X96.375 Y95.268 E.17961
G1 X93.445 Y96.574 E.0631
G1 X93.229 Y96.723 E.00516
G1 X93.102 Y96.786 E.00279
G1 X92.891 Y96.855 E.00437
G1 X92.582 Y96.891 E.00611
G1 X88.49 Y96.891 E.08049
G1 X89.098 Y97.59 E.01823
G1 X89.226 Y97.767 E.0043
G1 X89.459 Y98.156 E.00891
G1 X89.634 Y98.548 E.00844
G1 X89.774 Y98.994 E.0092
G1 X89.856 Y99.443 E.00897
G1 X89.877 Y99.661 E.0043
G1 X89.878 Y100.117 E.00897
G1 X89.859 Y100.335 E.00431
G1 X89.785 Y100.758 E.00844
G1 X89.65 Y101.212 E.00933
G1 X89.479 Y101.605 E.00843
G1 X89.363 Y101.819 E.00478
G1 X89.111 Y102.195 E.0089
G1 X88.816 Y102.538 E.00891
G1 X88.659 Y102.691 E.00431
G1 X88.305 Y102.979 E.00897
G1 X88.124 Y103.102 E.00431
G1 X87.746 Y103.311 E.0085
G1 X87.521 Y103.412 E.00485
G1 X87.314 Y103.489 E.00435
G1 X86.876 Y103.609 E.00892
G1 X86.428 Y103.676 E.00891
G1 X86.21 Y103.689 E.0043
G1 X85.757 Y103.675 E.00892
G1 X85.309 Y103.608 E.00891
G1 X85.093 Y103.556 E.00437
G1 X84.881 Y103.491 E.00436
G1 X84.461 Y103.321 E.00891
G1 X84.068 Y103.103 E.00885
G1 X83.702 Y102.84 E.00885
G1 X83.371 Y102.536 E.00885
G1 X83.078 Y102.195 E.00885
G1 X82.827 Y101.821 E.00885
G1 X82.621 Y101.417 E.00891
G1 X82.54 Y101.214 E.0043
G1 X82.415 Y100.804 E.00844
G1 X82.33 Y100.337 E.00933
G1 X82.305 Y99.889 E.00884
G1 X82.333 Y99.44 E.00885
G1 X82.414 Y98.997 E.00885
G1 X82.548 Y98.565 E.0089
G1 X82.641 Y98.34 E.00478
G1 X82.84 Y97.96 E.00844
G1 X83.093 Y97.588 E.00886
G1 X83.659 Y96.936 E.01698
; WIPE_START
M204 S6000
G1 X81.66 Y96.914 E-.38
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




G1 X79.54 Y96.249
G1 Z.68
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.139308
G1 F1500
M204 S6000
G1 X79.317 Y96.128 E.00144
; LINE_WIDTH: 0.148671
G1 X79.102 Y95.954 E.0017
G1 X78.942 Y95.627 E.00223
; WIPE_START
G1 X79.102 Y95.954 E-.21601
G1 X79.317 Y96.128 E-.16399
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X84.63 Y97.174 Z1.08 F18000
G1 Z.68
G1 E.4 F1800
; LINE_WIDTH: 0.473054
G1 F1500
M204 S6000
G1 X84.46 Y97.318 E.00499
; LINE_WIDTH: 0.438155
G1 X84.263 Y97.487 E.00533
; LINE_WIDTH: 0.401761
G1 X84.085 Y97.669 E.00478
; LINE_WIDTH: 0.360077
G1 X83.722 Y98.073 E.00905
G1 X83.521 Y98.364 E.00591
G1 X83.315 Y98.777 E.00771
G1 X83.167 Y99.251 E.00827
G1 X83.11 Y99.622 E.00627
G1 X83.099 Y100.018 E.0066
G1 X83.165 Y100.539 E.00876
G1 X83.325 Y101.052 E.00897
G1 X83.553 Y101.492 E.00826
G1 X83.773 Y101.797 E.00627
G1 X84.043 Y102.086 E.0066
G1 X84.454 Y102.412 E.00876
G1 X84.904 Y102.653 E.00851
G1 X85.415 Y102.822 E.00898
G1 X85.792 Y102.884 E.00636
G1 X86.167 Y102.9 E.00626
G1 X86.691 Y102.84 E.0088
G1 X87.179 Y102.696 E.00848
G1 X87.506 Y102.543 E.00603
G1 X87.837 Y102.343 E.00644
G1 X88.242 Y101.996 E.0089
G1 X88.479 Y101.715 E.00614
G1 X88.682 Y101.413 E.00606
G1 X88.909 Y100.939 E.00877
G1 X89.047 Y100.423 E.0089
G1 X89.089 Y99.915 E.0085
G1 X89.083 Y99.702 E.00356
G1 X89.002 Y99.172 E.00893
G1 X88.838 Y98.693 E.00845
G1 X88.585 Y98.238 E.00868
G1 X88.358 Y97.936 E.0063
G1 X88.087 Y97.645 E.00663
; LINE_WIDTH: 0.397707
G1 X87.966 Y97.532 E.00308
; LINE_WIDTH: 0.43277
G1 X87.844 Y97.419 E.00337
; LINE_WIDTH: 0.468067
G1 X87.721 Y97.304 E.00371
; LINE_WIDTH: 0.468432
G1 X87.559 Y97.34 E.00365
; LINE_WIDTH: 0.433602
G1 X87.398 Y97.375 E.00336
; WIPE_START
G1 X87.559 Y97.34 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X93.994 Y95.559 Z1.08 F18000
G1 Z.68
G1 E.4 F1800
; LINE_WIDTH: 0.163597
G1 F1500
M204 S6000
G1 X94.335 Y95.428 E.00251
; LINE_WIDTH: 0.130057
G1 X94.676 Y95.297 E.0019
; LINE_WIDTH: 0.0965169
G1 X95.017 Y95.165 E.00129
; WIPE_START
G1 X94.676 Y95.297 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X89.605 Y89.592 Z1.08 F18000
G1 X78.949 Y77.602 Z1.08
G1 Z.68
G1 E.4 F1800
; LINE_WIDTH: 0.0889687
G1 F1500
M204 S6000
G1 X78.987 Y77.485 E.00039
; LINE_WIDTH: 0.115071
G1 X79.026 Y77.368 E.00055
; LINE_WIDTH: 0.157972
G1 X79.167 Y77.194 E.00148
G1 X79.289 Y77.088 E.00107
; LINE_WIDTH: 0.14232
G1 X79.399 Y77.016 E.00077
; LINE_WIDTH: 0.0945067
G1 X79.591 Y76.956 E.00069
; CHANGE_LAYER
; Z_HEIGHT: 0.8
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F1500
G1 X79.399 Y77.016 E-.38
; WIPE_END
G1 E-.02 F1800
; layer num/total_layer_count: 6/57
; update layer progress
M73 L6
M991 S0 P5 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z1.08 I-.299 J1.18 P1  F18000
G1 X93.468 Y80.581 Z1.08
G1 Z.8
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X93.475 Y88.382 E.1651
G1 X93.114 Y88.382 E.00764
G1 X93.114 Y77.128 E.23818
G1 X93.299 Y77.076 E.00407
G1 X93.379 Y77.207 E.00325
G1 X93.436 Y77.349 E.00324
G1 X93.465 Y77.49 E.00306
G1 X93.468 Y80.521 E.06416
; WIPE_START
M204 S6000
G1 X93.469 Y82.521 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X93.575 Y90.153 Z1.2 F18000
G1 X93.65 Y95.57 Z1.2
G1 Z.8
G1 E.4 F1800
G1 F1500
M204 S500
G1 X93.122 Y95.806 E.01226
G1 X93.14 Y95.498 E.00654
G1 X93.189 Y95.377 E.00276
G1 X93.295 Y95.348 E.00232
G1 X93.38 Y95.372 E.00186
G1 X93.602 Y95.535 E.00583
; WIPE_START
M204 S6000
G1 X93.122 Y95.806 E-.14319
G1 X93.14 Y95.498 E-.08013
G1 X93.189 Y95.377 E-.03388
G1 X93.295 Y95.348 E-.0285
G1 X93.38 Y95.372 E-.02284
G1 X93.602 Y95.535 E-.07147
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X86.093 Y96.901 Z1.2 F18000
G1 X84.856 Y97.126 Z1.2
G1 Z.8
G1 E.4 F1800
G1 F1500
M204 S500
G1 X84.741 Y96.963 E.00423
G1 X85.105 Y96.544 E.01174
G1 X87.084 Y96.544 E.04188
G1 X87.43 Y96.942 E.01117
G1 X87.323 Y97.104 E.0041
G1 X86.86 Y96.953 E.0103
G1 X86.488 Y96.88 E.00804
G1 X85.973 Y96.857 E.0109
M73 P39 R15
G1 X85.596 Y96.897 E.00804
G1 X85.225 Y96.981 E.00805
G1 X84.912 Y97.104 E.00712
; WIPE_START
M204 S6000
G1 X84.741 Y96.963 E-.04213
G1 X85.105 Y96.544 E-.10541
G1 X86.329 Y96.544 E-.23245
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X83.516 Y99.454 Z1.2 F18000
G1 Z.8
G1 E.4 F1800
G1 F1500
M204 S500
G1 X83.613 Y99.054 E.00873
G1 X83.801 Y98.633 E.00976
G1 X83.975 Y98.361 E.00683
G1 X84.18 Y98.11 E.00686
G1 X84.536 Y97.793 E.01008
G1 X84.922 Y97.556 E.00961
G1 X85.35 Y97.388 E.00973
G1 X85.665 Y97.316 E.00683
G1 X85.986 Y97.282 E.00683
G1 X86.437 Y97.302 E.00955
G1 X86.754 Y97.365 E.00683
G1 X87.061 Y97.465 E.00683
G1 X87.473 Y97.671 E.00976
G1 X87.849 Y97.953 E.00994
G1 X88.162 Y98.29 E.00975
G1 X88.344 Y98.557 E.00683
G1 X88.488 Y98.835 E.00664
G1 X88.598 Y99.128 E.00662
G1 X88.671 Y99.426 E.00648
G1 X88.716 Y99.899 E.01007
G1 X88.674 Y100.369 E.00998
G1 X88.551 Y100.813 E.00975
G1 X88.42 Y101.107 E.00682
G1 X88.264 Y101.371 E.00649
G1 X87.963 Y101.74 E.01007
G1 X87.611 Y102.039 E.00978
G1 X87.337 Y102.208 E.00682
G1 X87.059 Y102.337 E.00649
G1 X86.603 Y102.473 E.01007
G1 X86.143 Y102.521 E.00979
G1 X85.821 Y102.507 E.00681
G1 X85.519 Y102.457 E.00649
G1 X85.065 Y102.312 E.01007
G1 X84.65 Y102.089 E.00998
G1 X84.283 Y101.796 E.00995
G1 X83.98 Y101.449 E.00975
G1 X83.806 Y101.178 E.00682
G1 X83.673 Y100.902 E.00649
G1 X83.53 Y100.448 E.01007
G1 X83.474 Y99.979 E.00998
G1 X83.502 Y99.513 E.00989
M204 S250
G1 X83.913 Y99.551 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X84.002 Y99.186 E.00739
G1 X84.162 Y98.827 E.00774
G1 X84.306 Y98.602 E.00526
G1 X84.476 Y98.395 E.00527
G1 X84.781 Y98.123 E.00803
G1 X85.106 Y97.923 E.0075
G1 X85.471 Y97.78 E.00773
G1 X85.732 Y97.72 E.00526
G1 X85.998 Y97.692 E.00526
G1 X86.388 Y97.71 E.00767
G1 X86.65 Y97.762 E.00526
G1 X86.905 Y97.844 E.00526
G1 X87.257 Y98.02 E.00774
G1 X87.574 Y98.258 E.00779
G1 X87.841 Y98.546 E.00773
G1 X87.992 Y98.767 E.00526
G1 X88.114 Y99.002 E.0052
G1 X88.207 Y99.249 E.0052
G1 X88.267 Y99.494 E.00496
G1 X88.305 Y99.9 E.00803
G1 X88.27 Y100.296 E.00781
G1 X88.165 Y100.675 E.00773
G1 X88.056 Y100.919 E.00526
G1 X87.927 Y101.136 E.00496
G1 X87.67 Y101.452 E.00803
G1 X87.37 Y101.707 E.00774
G1 X87.142 Y101.847 E.00526
G1 X86.913 Y101.954 E.00496
G1 X86.522 Y102.07 E.00803
G1 X86.131 Y102.111 E.00775
G1 X85.864 Y102.099 E.00525
G1 X85.615 Y102.058 E.00496
G1 X85.226 Y101.934 E.00802
G1 X84.876 Y101.746 E.00781
G1 X84.567 Y101.499 E.0078
G1 X84.308 Y101.203 E.00773
G1 X84.164 Y100.978 E.00526
G1 X84.054 Y100.75 E.00496
G1 X83.932 Y100.361 E.00802
G1 X83.885 Y99.967 E.00781
G1 X83.906 Y99.611 E.00702
; WIPE_START
M204 S6000
G1 X84.002 Y99.186 E-.08268
G1 X84.162 Y98.827 E-.07474
G1 X84.306 Y98.602 E-.05085
G1 X84.476 Y98.395 E-.05089
G1 X84.781 Y98.123 E-.07755
G1 X84.975 Y98.004 E-.04329
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X84.855 Y96.12 Z1.2 F18000
G1 Z.8
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X92.678 Y96.12 E.16557
G1 X92.718 Y95.441 E.0144
G1 X92.743 Y95.324 E.00254
G1 X92.855 Y95.124 E.00485
G1 X92.931 Y95.051 E.00223
G1 X93.061 Y94.971 E.00323
G1 X93.229 Y94.927 E.00366
G1 X93.324 Y94.922 E.00202
G1 X93.531 Y94.974 E.00451
G1 X93.95 Y95.264 E.0108
G1 X95.879 Y94.633 E.04295
G1 X100.747 Y87.68 E.17964
G1 X101.043 Y87.888 E.00765
G1 X96.105 Y94.94 E.18222
G1 X93.244 Y96.216 E.06631
G1 X93.021 Y96.37 E.00573
G1 X92.803 Y96.453 E.00495
G1 X92.559 Y96.482 E.00521
G1 X87.591 Y96.482 E.10514
G1 X88.777 Y97.845 E.03824
G1 X89.099 Y98.353 E.01273
G1 X89.255 Y98.703 E.00812
G1 X89.369 Y99.069 E.0081
G1 X89.451 Y99.5 E.0093
G1 X89.467 Y99.68 E.00382
G1 X89.453 Y100.282 E.01275
G1 X89.387 Y100.659 E.0081
G1 X89.265 Y101.072 E.00911
G1 X89.008 Y101.615 E.01272
G1 X88.658 Y102.103 E.0127
G1 X88.379 Y102.392 E.0085
G1 X88.082 Y102.634 E.00811
G1 X87.908 Y102.753 E.00447
G1 X87.543 Y102.955 E.00884
G1 X87.188 Y103.099 E.00811
G1 X86.792 Y103.208 E.00869
G1 X86.386 Y103.269 E.00869
G1 X85.794 Y103.267 E.01254
G1 X85.201 Y103.161 E.01274
G1 X84.663 Y102.962 E.01215
G1 X84.286 Y102.756 E.0091
G1 X83.961 Y102.522 E.00846
G1 X83.666 Y102.251 E.00849
G1 X83.398 Y101.939 E.00869
G1 X83.097 Y101.461 E.01196
G1 X82.923 Y101.068 E.0091
G1 X82.807 Y100.686 E.00846
G1 X82.737 Y100.291 E.00849
G1 X82.715 Y99.89 E.00849
G1 X82.74 Y99.491 E.00846
G1 X82.82 Y99.069 E.0091
G1 X83.003 Y98.534 E.01196
G1 X83.192 Y98.17 E.00869
G1 X83.418 Y97.838 E.0085
G1 X84.597 Y96.482 E.03804
G1 X79.631 Y96.482 E.10513
G1 X79.392 Y96.454 E.00508
G1 X79.119 Y96.34 E.00627
G1 X78.992 Y96.24 E.00343
G1 X78.884 Y96.119 E.00344
G1 X78.791 Y95.957 E.00394
G1 X78.743 Y95.812 E.00324
G1 X78.714 Y95.565 E.00527
G1 X78.714 Y77.619 E.37984
G1 X78.753 Y77.348 E.00579
G1 X78.856 Y77.123 E.00524
G1 X79.024 Y76.932 E.00538
G1 X79.155 Y76.84 E.0034
G1 X79.295 Y76.775 E.00326
G1 X79.545 Y76.723 E.00541
G1 X92.568 Y76.72 E.27565
G1 X92.805 Y76.749 E.00504
G1 X92.942 Y76.794 E.00307
G1 X93.119 Y76.889 E.00424
G1 X93.07 Y77.082 E.0042
G1 X80.021 Y77.082 E.2762
G1 X79.652 Y77.171 E.00803
G1 X79.397 Y77.35 E.0066
G1 X79.233 Y77.545 E.0054
G1 X79.112 Y77.807 E.0061
G1 X79.075 Y78.056 E.00533
G1 X79.075 Y95.155 E.36192
G1 X79.128 Y95.453 E.0064
G1 X79.316 Y95.778 E.00796
G1 X79.676 Y96.047 E.00951
G1 X80.031 Y96.12 E.00768
G1 X84.795 Y96.12 E.10084
; WIPE_START
M204 S6000
G1 X86.795 Y96.12 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X83.699 Y96.891 Z1.2 F18000
G1 Z.8
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X79.607 Y96.891 E.08049
G1 X79.297 Y96.855 E.00613
G1 X79.01 Y96.75 E.00601
G1 X78.888 Y96.68 E.00277
G1 X78.71 Y96.539 E.00448
G1 X78.558 Y96.368 E.00448
G1 X78.478 Y96.246 E.00289
G1 X78.412 Y96.114 E.00289
G1 X78.341 Y95.901 E.00442
G1 X78.304 Y95.589 E.00619
G1 X78.304 Y77.607 E.35368
G1 X78.313 Y77.454 E.00301
G1 X78.359 Y77.231 E.00449
G1 X78.439 Y77.028 E.00428
G1 X78.516 Y76.894 E.00304
G1 X78.652 Y76.721 E.00433
G1 X78.764 Y76.615 E.00304
G1 X78.95 Y76.484 E.00447
G1 X79.154 Y76.389 E.00443
G1 X79.364 Y76.332 E.00428
G1 X79.52 Y76.313 E.0031
G1 X92.593 Y76.311 E.25713
G1 X92.894 Y76.347 E.00598
G1 X93.105 Y76.417 E.00436
G1 X93.303 Y76.524 E.00442
G1 X93.479 Y76.663 E.00442
G1 X93.629 Y76.831 E.00442
G1 X93.746 Y77.022 E.00442
G1 X93.829 Y77.231 E.00442
G1 X93.874 Y77.448 E.00436
G1 X93.884 Y88.791 E.2231
G1 X92.704 Y88.791 E.02321
G1 X92.704 Y77.491 E.22226
G1 X80.07 Y77.491 E.24852
G1 X79.824 Y77.55 E.00497
G1 X79.677 Y77.654 E.00355
G1 X79.582 Y77.767 E.00291
G1 X79.508 Y77.925 E.00343
G1 X79.484 Y78.086 E.00319
G1 X79.484 Y95.119 E.33504
G1 X79.518 Y95.311 E.00382
G1 X79.628 Y95.501 E.00431
G1 X79.848 Y95.664 E.00539
G1 X80.073 Y95.711 E.00453
G1 X92.292 Y95.711 E.24034
G1 X92.312 Y95.386 E.00639
G1 X92.349 Y95.208 E.00358
G1 X92.477 Y94.944 E.00577
G1 X92.674 Y94.73 E.00572
G1 X92.921 Y94.585 E.00565
G1 X93.166 Y94.521 E.00497
G1 X93.441 Y94.523 E.00542
G1 X93.684 Y94.592 E.00497
G1 X93.833 Y94.671 E.00331
G1 X94.023 Y94.81 E.00463
G1 X95.622 Y94.286 E.0331
G1 X100.647 Y87.111 E.1723
G1 X101.613 Y87.787 E.02321
G1 X96.375 Y95.268 E.17961
G1 X93.445 Y96.574 E.0631
G1 X93.229 Y96.723 E.00516
G1 X93.102 Y96.786 E.00279
G1 X92.891 Y96.855 E.00436
G1 X92.582 Y96.891 E.00611
G1 X88.49 Y96.891 E.08049
G1 X89.098 Y97.59 E.01823
G1 X89.226 Y97.767 E.0043
G1 X89.46 Y98.159 E.00897
G1 X89.557 Y98.359 E.00437
G1 X89.641 Y98.564 E.00437
G1 X89.767 Y98.97 E.00835
G1 X89.856 Y99.443 E.00948
G1 X89.877 Y99.661 E.00429
G1 X89.878 Y100.117 E.00897
G1 X89.859 Y100.335 E.00431
G1 X89.786 Y100.753 E.00834
G1 X89.65 Y101.212 E.00942
G1 X89.481 Y101.601 E.00834
G1 X89.244 Y102.009 E.00928
G1 X88.969 Y102.37 E.00892
G1 X88.656 Y102.693 E.00885
G1 X88.328 Y102.962 E.00835
G1 X88.123 Y103.102 E.00488
G1 X87.725 Y103.322 E.00895
G1 X87.313 Y103.489 E.00873
G1 X86.876 Y103.609 E.00891
G1 X86.429 Y103.676 E.00891
G1 X86.21 Y103.689 E.00431
G1 X85.757 Y103.675 E.00891
G1 X85.309 Y103.608 E.00891
G1 X85.093 Y103.556 E.00437
G1 X84.881 Y103.491 E.00437
G1 X84.488 Y103.332 E.00835
G1 X84.067 Y103.103 E.00942
G1 X83.703 Y102.84 E.00884
G1 X83.371 Y102.536 E.00885
G1 X83.076 Y102.192 E.00891
G1 X82.948 Y102.014 E.00431
G1 X82.733 Y101.649 E.00835
G1 X82.538 Y101.211 E.00942
G1 X82.408 Y100.781 E.00884
G1 X82.33 Y100.338 E.00885
G1 X82.305 Y99.889 E.00885
G1 X82.333 Y99.44 E.00884
G1 X82.422 Y98.97 E.00942
G1 X82.548 Y98.564 E.00835
G1 X82.631 Y98.362 E.0043
G1 X82.84 Y97.96 E.00891
G1 X83.093 Y97.588 E.00885
G1 X83.659 Y96.936 E.01698
; WIPE_START
M204 S6000
G1 X81.66 Y96.914 E-.38
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
M73 P40 R15
G1 X-13.0 F3000 ; move to safe pos
M400
M1004 S5 P1  ; external shutter
M400 P300
M971 S11 C11 O0
G92 E0
G1 X0 F18000
M623

; SKIPTYPE: head_wrap_detect
M622.1 S1
M1002 judge_flag g39_3rd_layer_detect_flag
M622 J1
    ; enable nozzle clog detect at 3rd layer
    


    M622.1 S1
    M1002 judge_flag g39_detection_flag
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




G1 X79.54 Y96.249
G1 Z.8
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.146278
G1 F1500
M204 S6000
G1 X79.307 Y96.123 E.00159
G1 X79.118 Y95.971 E.00146
G1 X79.043 Y95.851 E.00085
G1 X78.942 Y95.627 E.00148
; WIPE_START
G1 X79.043 Y95.851 E-.10458
G1 X79.118 Y95.971 E-.05995
G1 X79.307 Y96.123 E-.10322
G1 X79.54 Y96.249 E-.11224
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X84.63 Y97.174 Z1.2 F18000
G1 Z.8
G1 E.4 F1800
; LINE_WIDTH: 0.473835
G1 F1500
M204 S6000
G1 X84.466 Y97.312 E.00479
; LINE_WIDTH: 0.441493
G1 X84.277 Y97.475 E.00518
; LINE_WIDTH: 0.405465
G1 X84.097 Y97.657 E.00485
; LINE_WIDTH: 0.360362
G1 X83.72 Y98.071 E.00934
G1 X83.521 Y98.363 E.00591
G1 X83.291 Y98.838 E.0088
G1 X83.192 Y99.162 E.00565
G1 X83.119 Y99.539 E.00641
G1 X83.098 Y100.005 E.0078
G1 X83.165 Y100.542 E.00902
G1 X83.318 Y101.029 E.00853
G1 X83.473 Y101.353 E.00599
G1 X83.701 Y101.708 E.00706
G1 X84.033 Y102.078 E.00829
G1 X84.454 Y102.412 E.00898
G1 X84.904 Y102.653 E.00852
G1 X85.418 Y102.823 E.00904
G1 X85.792 Y102.884 E.00632
G1 X86.142 Y102.895 E.00585
G1 X86.661 Y102.846 E.00871
G1 X87.068 Y102.735 E.00703
G1 X87.507 Y102.544 E.008
G1 X87.844 Y102.338 E.00659
G1 X88.242 Y101.992 E.00881
G1 X88.563 Y101.595 E.00853
G1 X88.749 Y101.288 E.00598
G1 X88.909 Y100.939 E.00641
G1 X89.047 Y100.422 E.00894
G1 X89.089 Y99.913 E.00852
G1 X89.083 Y99.702 E.00353
G1 X88.998 Y99.159 E.00918
G1 X88.837 Y98.691 E.00827
G1 X88.67 Y98.373 E.00599
G1 X88.466 Y98.064 E.00619
G1 X88.097 Y97.654 E.00921
; LINE_WIDTH: 0.395485
G1 X87.972 Y97.538 E.00314
; LINE_WIDTH: 0.431439
G1 X87.847 Y97.422 E.00345
; LINE_WIDTH: 0.467637
G1 X87.721 Y97.304 E.0038
; LINE_WIDTH: 0.468508
G1 X87.559 Y97.34 E.00365
; LINE_WIDTH: 0.433773
G1 X87.398 Y97.375 E.00337
; WIPE_START
G1 X87.559 Y97.34 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X93.994 Y95.559 Z1.2 F18000
G1 Z.8
G1 E.4 F1800
; LINE_WIDTH: 0.1636
G1 F1500
M204 S6000
G1 X94.335 Y95.428 E.00251
; LINE_WIDTH: 0.130059
G1 X94.676 Y95.297 E.0019
; LINE_WIDTH: 0.0965177
G1 X95.017 Y95.165 E.00129
; WIPE_START
G1 X94.676 Y95.297 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X89.606 Y89.592 Z1.2 F18000
G1 X78.949 Y77.601 Z1.2
G1 Z.8
G1 E.4 F1800
; LINE_WIDTH: 0.0995966
G1 F1500
M204 S6000
G1 X79.004 Y77.422 E.00069
; LINE_WIDTH: 0.150833
G1 X79.057 Y77.328 E.00067
G1 X79.203 Y77.151 E.00143
G1 X79.546 Y76.937 E.00252
; CHANGE_LAYER
; Z_HEIGHT: 0.92
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F1500
G1 X79.203 Y77.151 E-.2071
G1 X79.057 Y77.328 E-.11774
G1 X79.004 Y77.422 E-.05517
; WIPE_END
G1 E-.02 F1800
; layer num/total_layer_count: 7/57
; update layer progress
M73 L7
M991 S0 P6 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z1.2 I-.26 J1.189 P1  F18000
G1 X93.468 Y80.581 Z1.2
G1 Z.92
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X93.475 Y88.382 E.1651
G1 X93.114 Y88.382 E.00764
G1 X93.114 Y77.128 E.23818
G1 X93.299 Y77.076 E.00407
G1 X93.379 Y77.207 E.00325
G1 X93.436 Y77.349 E.00324
G1 X93.465 Y77.49 E.00306
G1 X93.468 Y80.521 E.06415
; WIPE_START
M204 S6000
G1 X93.469 Y82.521 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X93.584 Y90.153 Z1.32 F18000
G1 X93.665 Y95.564 Z1.32
G1 Z.92
G1 E.4 F1800
G1 F1500
M204 S500
G1 X93.12 Y95.807 E.01263
G1 X93.141 Y95.493 E.00666
G1 X93.166 Y95.414 E.00176
G1 X93.212 Y95.37 E.00134
G1 X93.32 Y95.341 E.00236
G1 X93.615 Y95.531 E.00743
; WIPE_START
M204 S6000
G1 X93.12 Y95.807 E-.1444
G1 X93.141 Y95.493 E-.08029
G1 X93.166 Y95.414 E-.02115
G1 X93.212 Y95.37 E-.01619
G1 X93.32 Y95.341 E-.02843
G1 X93.615 Y95.531 E-.08955
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X86.106 Y96.899 Z1.32 F18000
G1 X84.856 Y97.126 Z1.32
G1 Z.92
G1 E.4 F1800
G1 F1500
M204 S500
G1 X84.741 Y96.963 E.00423
G1 X85.105 Y96.544 E.01174
G1 X87.017 Y96.544 E.04046
G1 X87.359 Y96.916 E.01069
G1 X87.253 Y97.081 E.00416
G1 X86.861 Y96.954 E.00874
G1 X86.488 Y96.88 E.00805
G1 X85.973 Y96.857 E.0109
G1 X85.595 Y96.897 E.00804
G1 X85.225 Y96.981 E.00804
G1 X84.912 Y97.104 E.00712
; WIPE_START
M204 S6000
G1 X84.741 Y96.963 E-.04213
G1 X85.105 Y96.544 E-.10541
G1 X86.329 Y96.544 E-.23246
; WIPE_END
G1 E-.02 F1800
M204 S10000
M73 P40 R14
G1 X83.511 Y99.475 Z1.32 F18000
G1 Z.92
G1 E.4 F1800
G1 F1500
M204 S500
G1 X83.568 Y99.204 E.00587
G1 X83.666 Y98.917 E.00643
G1 X83.884 Y98.491 E.01013
G1 X84.174 Y98.116 E.01002
G1 X84.538 Y97.792 E.01033
G1 X84.923 Y97.556 E.00955
G1 X85.35 Y97.388 E.00973
G1 X85.665 Y97.316 E.00683
G1 X85.986 Y97.282 E.00683
G1 X86.437 Y97.302 E.00955
G1 X86.754 Y97.365 E.00684
G1 X87.052 Y97.462 E.00663
G1 X87.335 Y97.593 E.00662
G1 X87.594 Y97.752 E.00643
G1 X87.954 Y98.054 E.00993
G1 X88.167 Y98.297 E.00685
G1 X88.339 Y98.548 E.00643
G1 X88.549 Y98.978 E.01012
G1 X88.674 Y99.433 E.00999
G1 X88.716 Y99.901 E.00995
G1 X88.674 Y100.369 E.00995
G1 X88.551 Y100.813 E.00975
G1 X88.421 Y101.107 E.00681
G1 X88.265 Y101.368 E.00643
G1 X87.963 Y101.74 E.01013
G1 X87.611 Y102.039 E.00979
G1 X87.337 Y102.208 E.00682
G1 X87.061 Y102.336 E.00643
G1 X86.603 Y102.473 E.01013
G1 X86.143 Y102.521 E.00979
G1 X85.821 Y102.507 E.00683
G1 X85.502 Y102.454 E.00683
G1 X85.064 Y102.312 E.00975
G1 X84.65 Y102.089 E.00995
G1 X84.283 Y101.796 E.00995
G1 X83.979 Y101.449 E.00975
G1 X83.806 Y101.178 E.00681
G1 X83.674 Y100.904 E.00643
G1 X83.53 Y100.448 E.01013
G1 X83.474 Y99.979 E.00998
G1 X83.5 Y99.534 E.00943
M204 S250
G1 X83.911 Y99.561 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X83.964 Y99.313 E.00498
G1 X84.044 Y99.076 E.00491
G1 X84.231 Y98.711 E.00807
G1 X84.474 Y98.397 E.00782
G1 X84.783 Y98.122 E.00814
G1 X85.106 Y97.923 E.00745
G1 X85.471 Y97.78 E.00773
G1 X85.732 Y97.72 E.00526
G1 X85.998 Y97.692 E.00526
G1 X86.388 Y97.71 E.00767
G1 X86.651 Y97.762 E.00527
G1 X86.902 Y97.843 E.00519
G1 X87.142 Y97.954 E.0052
G1 X87.354 Y98.085 E.00491
G1 X87.667 Y98.347 E.00801
G1 X87.843 Y98.549 E.00527
G1 X87.984 Y98.755 E.00491
G1 X88.164 Y99.123 E.00807
G1 X88.27 Y99.506 E.00781
G1 X88.305 Y99.901 E.0078
G1 X88.27 Y100.296 E.0078
G1 X88.165 Y100.675 E.00773
G1 X88.056 Y100.919 E.00525
G1 X87.929 Y101.134 E.00492
G1 X87.67 Y101.452 E.00807
G1 X87.369 Y101.707 E.00774
G1 X87.142 Y101.847 E.00526
G1 X86.916 Y101.953 E.00491
G1 X86.522 Y102.07 E.00807
G1 X86.131 Y102.111 E.00775
G1 X85.863 Y102.099 E.00526
G1 X85.599 Y102.055 E.00527
G1 X85.226 Y101.934 E.00773
G1 X84.877 Y101.746 E.0078
G1 X84.567 Y101.499 E.0078
G1 X84.308 Y101.203 E.00773
G1 X84.164 Y100.977 E.00526
G1 X84.055 Y100.753 E.00491
G1 X83.932 Y100.361 E.00807
G1 X83.885 Y99.967 E.00781
G1 X83.905 Y99.62 E.00684
; WIPE_START
M204 S6000
G1 X83.964 Y99.313 E-.05939
G1 X84.044 Y99.076 E-.04745
G1 X84.231 Y98.711 E-.078
G1 X84.474 Y98.397 E-.07551
G1 X84.783 Y98.122 E-.07862
G1 X84.967 Y98.009 E-.04104
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X84.855 Y96.12 Z1.32 F18000
G1 Z.92
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X92.674 Y96.12 E.1655
G1 X92.719 Y95.434 E.01456
G1 X92.741 Y95.332 E.0022
G1 X92.784 Y95.227 E.0024
G1 X92.851 Y95.128 E.00253
G1 X92.938 Y95.044 E.00257
G1 X93.072 Y94.968 E.00325
G1 X93.279 Y94.922 E.00451
G1 X93.493 Y94.957 E.00458
G1 X93.972 Y95.257 E.01197
G1 X95.879 Y94.633 E.04247
G1 X100.747 Y87.68 E.17964
G1 X101.043 Y87.888 E.00765
G1 X96.105 Y94.94 E.18222
G1 X93.238 Y96.219 E.06646
G1 X93.071 Y96.339 E.00434
G1 X92.939 Y96.409 E.00317
G1 X92.803 Y96.453 E.00303
G1 X92.559 Y96.482 E.0052
G1 X87.536 Y96.482 E.10631
G1 X88.639 Y97.675 E.03439
G1 X88.895 Y98.008 E.00888
G1 X89.168 Y98.497 E.01187
G1 X89.327 Y98.912 E.00939
G1 X89.451 Y99.499 E.01269
G1 X89.469 Y100.1 E.01273
G1 X89.388 Y100.655 E.01187
G1 X89.265 Y101.072 E.00921
G1 X89.008 Y101.616 E.01273
G1 X88.678 Y102.078 E.01202
G1 X88.378 Y102.392 E.0092
G1 X88.061 Y102.65 E.00865
G1 X87.57 Y102.941 E.01207
G1 X87.373 Y103.03 E.00458
G1 X87.008 Y103.154 E.00816
G1 X86.799 Y103.207 E.00456
G1 X86.386 Y103.269 E.00883
G1 X85.787 Y103.267 E.01269
G1 X85.193 Y103.159 E.01277
G1 X84.667 Y102.963 E.01188
G1 X84.285 Y102.755 E.0092
G1 X83.961 Y102.522 E.00845
G1 X83.666 Y102.251 E.00849
G1 X83.404 Y101.947 E.00849
G1 X83.181 Y101.613 E.00849
G1 X82.998 Y101.256 E.00849
G1 X82.86 Y100.879 E.00849
G1 X82.766 Y100.489 E.0085
G1 X82.72 Y100.091 E.00849
G1 X82.738 Y99.499 E.01253
G1 X82.814 Y99.086 E.00889
G1 X83.007 Y98.526 E.01254
G1 X83.192 Y98.17 E.00849
G1 X83.417 Y97.838 E.00849
G1 X84.597 Y96.482 E.03805
G1 X79.631 Y96.482 E.10513
G1 X79.394 Y96.454 E.00504
G1 X79.184 Y96.376 E.00474
G1 X79.063 Y96.301 E.00301
G1 X78.921 Y96.165 E.00417
G1 X78.83 Y96.035 E.00336
G1 X78.743 Y95.813 E.00505
G1 X78.714 Y95.565 E.00529
G1 X78.714 Y77.627 E.37967
G1 X78.75 Y77.356 E.0058
G1 X78.809 Y77.207 E.00339
G1 X78.89 Y77.076 E.00324
G1 X79.069 Y76.895 E.00539
G1 X79.294 Y76.775 E.0054
G1 X79.543 Y76.723 E.00539
G1 X92.57 Y76.72 E.27572
G1 X92.805 Y76.749 E.005
G1 X92.942 Y76.794 E.00307
G1 X93.119 Y76.889 E.00424
G1 X93.07 Y77.082 E.0042
G1 X80.021 Y77.082 E.2762
G1 X79.652 Y77.171 E.00804
G1 X79.397 Y77.35 E.00659
G1 X79.234 Y77.545 E.00539
G1 X79.112 Y77.807 E.0061
G1 X79.075 Y78.056 E.00533
G1 X79.075 Y95.155 E.36192
G1 X79.128 Y95.453 E.0064
G1 X79.316 Y95.778 E.00796
G1 X79.676 Y96.047 E.00952
G1 X80.031 Y96.12 E.00767
G1 X84.795 Y96.12 E.10083
; WIPE_START
M204 S6000
G1 X86.795 Y96.12 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X83.699 Y96.891 Z1.32 F18000
G1 Z.92
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X79.607 Y96.891 E.08049
G1 X79.298 Y96.855 E.00612
G1 X79.003 Y96.746 E.00618
G1 X78.822 Y96.634 E.00418
G1 X78.71 Y96.539 E.00288
G1 X78.601 Y96.423 E.00313
G1 X78.477 Y96.244 E.00429
G1 X78.407 Y96.104 E.00308
G1 X78.341 Y95.902 E.00419
G1 X78.304 Y95.589 E.0062
G1 X78.304 Y77.61 E.35363
G1 X78.323 Y77.385 E.00443
G1 X78.358 Y77.233 E.00307
G1 X78.442 Y77.022 E.00447
G1 X78.56 Y76.831 E.00442
G1 X78.712 Y76.661 E.00448
G1 X78.824 Y76.566 E.00289
G1 X78.947 Y76.486 E.00289
G1 X79.153 Y76.389 E.00448
G1 X79.374 Y76.33 E.00448
G1 X79.519 Y76.313 E.00289
G1 X92.594 Y76.311 E.25717
G1 X92.894 Y76.347 E.00594
G1 X93.105 Y76.417 E.00437
G1 X93.303 Y76.524 E.00442
G1 X93.479 Y76.663 E.00442
G1 X93.628 Y76.831 E.00442
G1 X93.746 Y77.022 E.00442
G1 X93.829 Y77.231 E.00442
G1 X93.874 Y77.448 E.00436
G1 X93.884 Y88.791 E.2231
G1 X92.704 Y88.791 E.02321
G1 X92.704 Y77.491 E.22226
G1 X80.069 Y77.491 E.24852
G1 X79.824 Y77.55 E.00497
G1 X79.677 Y77.654 E.00354
G1 X79.582 Y77.767 E.00291
G1 X79.508 Y77.925 E.00343
G1 X79.484 Y78.085 E.00319
G1 X79.484 Y95.119 E.33504
G1 X79.518 Y95.31 E.00382
G1 X79.628 Y95.501 E.00432
G1 X79.848 Y95.664 E.0054
G1 X80.073 Y95.711 E.00452
G1 X92.291 Y95.711 E.24032
G1 X92.313 Y95.377 E.00658
G1 X92.349 Y95.211 E.00334
G1 X92.417 Y95.044 E.00354
G1 X92.545 Y94.855 E.0045
G1 X92.676 Y94.728 E.00359
G1 X92.925 Y94.584 E.00565
G1 X93.16 Y94.521 E.00479
G1 X93.448 Y94.524 E.00565
G1 X93.722 Y94.609 E.00565
G1 X94.03 Y94.807 E.00721
G1 X95.622 Y94.286 E.03294
G1 X100.647 Y87.111 E.1723
G1 X101.613 Y87.787 E.02321
G1 X96.375 Y95.268 E.17961
G1 X93.443 Y96.575 E.06315
G1 X93.288 Y96.688 E.00377
G1 X93.099 Y96.787 E.00419
G1 X92.891 Y96.855 E.00431
G1 X92.582 Y96.891 E.00611
G1 X88.471 Y96.891 E.08086
G1 X88.952 Y97.411 E.01393
M73 P41 R14
G1 X89.23 Y97.772 E.00897
G1 X89.348 Y97.957 E.00431
G1 X89.542 Y98.329 E.00825
G1 X89.716 Y98.784 E.00957
G1 X89.774 Y98.994 E.00429
G1 X89.856 Y99.443 E.00897
G1 X89.877 Y99.661 E.0043
G1 X89.878 Y100.117 E.00897
G1 X89.859 Y100.335 E.00431
G1 X89.787 Y100.748 E.00825
G1 X89.65 Y101.212 E.00952
G1 X89.483 Y101.597 E.00825
G1 X89.244 Y102.009 E.00938
G1 X88.99 Y102.344 E.00825
G1 X88.656 Y102.694 E.00952
G1 X88.305 Y102.979 E.0089
G1 X88.124 Y103.102 E.00431
G1 X87.754 Y103.307 E.00832
G1 X87.523 Y103.411 E.00498
G1 X87.124 Y103.547 E.0083
G1 X86.879 Y103.609 E.00497
G1 X86.429 Y103.676 E.00895
G1 X86.21 Y103.689 E.00431
G1 X85.755 Y103.675 E.00896
G1 X85.504 Y103.644 E.00497
G1 X85.091 Y103.555 E.00832
G1 X84.881 Y103.491 E.00431
G1 X84.492 Y103.334 E.00825
G1 X84.067 Y103.103 E.00951
G1 X83.702 Y102.84 E.00884
G1 X83.371 Y102.536 E.00885
G1 X83.078 Y102.195 E.00885
G1 X82.827 Y101.821 E.00885
G1 X82.623 Y101.42 E.00885
G1 X82.467 Y100.998 E.00885
G1 X82.363 Y100.56 E.00885
G1 X82.311 Y100.114 E.00885
G1 X82.312 Y99.661 E.00891
G1 X82.332 Y99.443 E.0043
G1 X82.415 Y98.994 E.00897
G1 X82.473 Y98.783 E.00431
G1 X82.633 Y98.359 E.00891
G1 X82.84 Y97.96 E.00885
G1 X83.093 Y97.588 E.00885
G1 X83.66 Y96.936 E.01699
; WIPE_START
M204 S6000
G1 X81.66 Y96.914 E-.38
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




G1 X79.54 Y96.249
G1 Z.92
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.139335
G1 F1500
M204 S6000
G1 X79.309 Y96.124 E.00149
; LINE_WIDTH: 0.145791
G1 X79.189 Y96.037 E.00089
G1 X79.107 Y95.949 E.00072
G1 X79.038 Y95.841 E.00077
G1 X78.942 Y95.626 E.00141
; WIPE_START
G1 X79.038 Y95.841 E-.14123
G1 X79.107 Y95.949 E-.07737
G1 X79.189 Y96.037 E-.07229
G1 X79.309 Y96.124 E-.0891
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X84.63 Y97.174 Z1.32 F18000
G1 Z.92
G1 E.4 F1800
; LINE_WIDTH: 0.473927
G1 F1500
M204 S6000
G1 X84.468 Y97.311 E.00476
; LINE_WIDTH: 0.441987
G1 X84.279 Y97.473 E.00516
; LINE_WIDTH: 0.40555
G1 X84.094 Y97.66 E.005
; LINE_WIDTH: 0.359874
G1 X83.888 Y97.871 E.0049
G1 X83.558 Y98.302 E.00905
G1 X83.357 Y98.682 E.00717
G1 X83.227 Y99.023 E.00609
G1 X83.117 Y99.548 E.00894
G1 X83.098 Y100.005 E.00763
G1 X83.143 Y100.422 E.00699
G1 X83.228 Y100.768 E.00593
G1 X83.347 Y101.103 E.00593
G1 X83.509 Y101.42 E.00593
G1 X83.67 Y101.665 E.00489
G1 X83.941 Y101.985 E.00698
G1 X84.204 Y102.224 E.00593
G1 X84.488 Y102.433 E.00588
G1 X84.903 Y102.651 E.00782
G1 X85.292 Y102.788 E.00688
G1 X85.819 Y102.887 E.00893
G1 X86.352 Y102.885 E.00888
G1 X86.692 Y102.841 E.00572
G1 X87.207 Y102.686 E.00897
G1 X87.523 Y102.532 E.00585
G1 X87.821 Y102.349 E.00584
G1 X88.221 Y102.013 E.0087
G1 X88.583 Y101.576 E.00947
G1 X88.773 Y101.249 E.00629
G1 X88.908 Y100.942 E.00559
G1 X89.045 Y100.422 E.00897
G1 X89.09 Y99.915 E.00847
G1 X89.044 Y99.38 E.00895
G1 X88.905 Y98.859 E.00899
G1 X88.673 Y98.368 E.00906
G1 X88.457 Y98.061 E.00625
G1 X88.211 Y97.773 E.00631
; LINE_WIDTH: 0.378198
G1 X88.029 Y97.6 E.00442
; LINE_WIDTH: 0.412656
G1 X87.82 Y97.403 E.00554
; LINE_WIDTH: 0.449435
G1 X87.648 Y97.265 E.00466
; LINE_WIDTH: 0.480463
G1 X87.475 Y97.128 E.005
; WIPE_START
G1 X87.648 Y97.265 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X94.029 Y95.546 Z1.32 F18000
G1 Z.92
G1 E.4 F1800
; LINE_WIDTH: 0.152238
G1 F1500
M204 S6000
G1 X94.523 Y95.356 E.00334
; LINE_WIDTH: 0.103911
G1 X95.017 Y95.165 E.00206
; WIPE_START
G1 X94.523 Y95.356 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X89.491 Y89.617 Z1.32 F18000
G1 X78.951 Y77.595 Z1.32
G1 Z.92
G1 E.4 F1800
; LINE_WIDTH: 0.0998603
G1 F1500
M204 S6000
G1 X79 Y77.431 E.00063
; LINE_WIDTH: 0.150316
G1 X79.054 Y77.333 E.0007
G1 X79.201 Y77.15 E.00146
G1 X79.546 Y76.936 E.00252
; CHANGE_LAYER
; Z_HEIGHT: 1.04
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F1500
G1 X79.201 Y77.15 E-.20474
G1 X79.054 Y77.333 E-.11854
G1 X79 Y77.431 E-.05672
; WIPE_END
G1 E-.02 F1800
; layer num/total_layer_count: 8/57
; update layer progress
M73 L8
M991 S0 P7 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z1.32 I-.259 J1.189 P1  F18000
G1 X93.468 Y80.581 Z1.32
G1 Z1.04
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X93.475 Y88.382 E.1651
G1 X93.114 Y88.382 E.00764
G1 X93.114 Y77.128 E.23818
G1 X93.299 Y77.076 E.00407
G1 X93.379 Y77.207 E.00325
G1 X93.436 Y77.349 E.00324
G1 X93.465 Y77.49 E.00306
G1 X93.468 Y80.521 E.06415
; WIPE_START
M204 S6000
G1 X93.469 Y82.521 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X93.584 Y90.153 Z1.44 F18000
G1 X93.665 Y95.564 Z1.44
G1 Z1.04
G1 E.4 F1800
G1 F1500
M204 S500
G1 X93.12 Y95.807 E.01264
G1 X93.141 Y95.492 E.00669
G1 X93.162 Y95.423 E.00154
G1 X93.203 Y95.373 E.00137
G1 X93.321 Y95.342 E.00257
G1 X93.615 Y95.531 E.0074
; WIPE_START
M204 S6000
G1 X93.12 Y95.807 E-.14441
G1 X93.141 Y95.492 E-.08052
G1 X93.162 Y95.423 E-.0185
G1 X93.203 Y95.373 E-.01648
G1 X93.321 Y95.342 E-.031
G1 X93.615 Y95.531 E-.08909
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X86.105 Y96.895 Z1.44 F18000
G1 X84.867 Y97.12 Z1.44
G1 Z1.04
G1 E.4 F1800
G1 F1500
M204 S500
G1 X84.747 Y96.956 E.00429
G1 X85.105 Y96.544 E.01154
G1 X87.017 Y96.544 E.04045
G1 X87.359 Y96.916 E.0107
G1 X87.253 Y97.081 E.00416
G1 X86.861 Y96.953 E.00874
G1 X86.488 Y96.88 E.00804
G1 X85.958 Y96.856 E.01123
G1 X85.432 Y96.928 E.01124
G1 X85.067 Y97.034 E.00804
G1 X84.922 Y97.096 E.00335
; WIPE_START
M204 S6000
G1 X84.747 Y96.956 E-.04255
G1 X85.105 Y96.544 E-.10363
G1 X86.336 Y96.544 E-.23382
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X83.511 Y99.473 Z1.44 F18000
G1 Z1.04
G1 E.4 F1800
G1 F1500
M204 S500
G1 X83.613 Y99.054 E.00914
G1 X83.801 Y98.633 E.00976
G1 X83.975 Y98.361 E.00683
G1 X84.179 Y98.111 E.00683
G1 X84.522 Y97.803 E.00975
G1 X84.914 Y97.561 E.00975
G1 X85.21 Y97.434 E.00683
G1 X85.52 Y97.344 E.00683
G1 X85.977 Y97.282 E.00976
G1 X86.437 Y97.302 E.00975
G1 X86.754 Y97.365 E.00683
G1 X87.052 Y97.462 E.00663
G1 X87.336 Y97.593 E.00663
G1 X87.611 Y97.763 E.00683
G1 X87.962 Y98.061 E.00975
G1 X88.262 Y98.426 E.00999
G1 X88.493 Y98.847 E.01018
G1 X88.599 Y99.129 E.00638
G1 X88.675 Y99.442 E.00681
G1 X88.716 Y99.901 E.00975
G1 X88.674 Y100.369 E.00995
G1 X88.551 Y100.813 E.00975
G1 X88.42 Y101.107 E.00681
G1 X88.267 Y101.366 E.00638
G1 X87.964 Y101.74 E.01018
G1 X87.611 Y102.039 E.00979
G1 X87.337 Y102.208 E.00681
G1 X87.064 Y102.335 E.00638
G1 X86.603 Y102.473 E.01018
G1 X86.134 Y102.522 E.00999
G1 X85.674 Y102.488 E.00975
G1 X85.36 Y102.416 E.00683
G1 X85.056 Y102.307 E.00683
G1 X84.65 Y102.089 E.00975
G1 X84.29 Y101.802 E.00975
G1 X84.071 Y101.566 E.00682
G1 X83.893 Y101.322 E.00637
G1 X83.669 Y100.897 E.01018
G1 X83.53 Y100.446 E.00999
G1 X83.474 Y99.979 E.00995
G1 X83.501 Y99.532 E.00948
M204 S250
G1 X83.908 Y99.57 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X84.002 Y99.186 E.00777
G1 X84.162 Y98.827 E.00774
G1 X84.306 Y98.602 E.00526
G1 X84.476 Y98.395 E.00526
G1 X84.768 Y98.132 E.00773
G1 X85.103 Y97.925 E.00774
G1 X85.349 Y97.82 E.00526
G1 X85.605 Y97.745 E.00526
G1 X85.995 Y97.692 E.00774
G1 X86.388 Y97.71 E.00773
G1 X86.651 Y97.762 E.00526
G1 X86.902 Y97.843 E.0052
G1 X87.142 Y97.954 E.0052
G1 X87.369 Y98.095 E.00526
G1 X87.669 Y98.349 E.00773
G1 X87.922 Y98.656 E.00781
G1 X88.12 Y99.018 E.00812
G1 X88.207 Y99.25 E.00487
G1 X88.27 Y99.509 E.00526
G1 X88.305 Y99.901 E.00773
G1 X88.27 Y100.296 E.0078
G1 X88.165 Y100.675 E.00774
G1 X88.056 Y100.919 E.00526
G1 X87.93 Y101.132 E.00486
G1 X87.67 Y101.452 E.00812
G1 X87.369 Y101.707 E.00774
G1 X87.142 Y101.847 E.00526
G1 X86.918 Y101.952 E.00487
G1 X86.522 Y102.07 E.00812
G1 X86.127 Y102.111 E.00781
G1 X85.736 Y102.082 E.00773
G1 X85.475 Y102.023 E.00526
G1 X85.223 Y101.932 E.00526
G1 X84.877 Y101.746 E.00773
G1 X84.569 Y101.501 E.00774
G1 X84.387 Y101.305 E.00526
G1 X84.241 Y101.105 E.00486
G1 X84.049 Y100.74 E.00812
G1 X83.932 Y100.361 E.00781
G1 X83.885 Y99.967 E.0078
G1 X83.905 Y99.63 E.00664
; WIPE_START
M204 S6000
G1 X84.002 Y99.186 E-.08632
G1 X84.162 Y98.827 E-.07476
G1 X84.306 Y98.602 E-.05082
G1 X84.476 Y98.395 E-.05082
G1 X84.768 Y98.132 E-.0747
G1 X84.959 Y98.014 E-.04259
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X84.855 Y96.12 Z1.44 F18000
G1 Z1.04
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X92.674 Y96.12 E.16549
G1 X92.719 Y95.433 E.01458
G1 X92.741 Y95.332 E.00218
G1 X92.81 Y95.184 E.00346
G1 X92.887 Y95.09 E.00257
G1 X93.07 Y94.969 E.00465
G1 X93.231 Y94.927 E.00352
G1 X93.443 Y94.941 E.0045
G1 X93.539 Y94.978 E.00219
G1 X93.972 Y95.257 E.01091
G1 X95.879 Y94.633 E.04247
G1 X100.747 Y87.68 E.17964
G1 X101.043 Y87.888 E.00765
G1 X96.105 Y94.94 E.18222
G1 X93.236 Y96.22 E.06649
G1 X93.08 Y96.334 E.0041
G1 X92.938 Y96.409 E.00339
G1 X92.803 Y96.453 E.00301
G1 X92.559 Y96.482 E.0052
G1 X87.536 Y96.482 E.10631
G1 X88.639 Y97.675 E.03439
G1 X88.895 Y98.008 E.00889
G1 X89.166 Y98.494 E.01178
G1 X89.323 Y98.903 E.00929
G1 X89.45 Y99.489 E.01269
G1 X89.469 Y100.1 E.01293
G1 X89.389 Y100.651 E.01178
G1 X89.264 Y101.072 E.00931
G1 X89.007 Y101.616 E.01272
G1 X88.681 Y102.075 E.01192
G1 X88.378 Y102.392 E.0093
G1 X88.061 Y102.65 E.00864
G1 X87.574 Y102.939 E.01199
G1 X87.188 Y103.099 E.00885
G1 X86.792 Y103.208 E.00869
G1 X86.386 Y103.269 E.00868
G1 X85.794 Y103.267 E.01254
G1 X85.202 Y103.161 E.01273
G1 X84.671 Y102.965 E.01197
G1 X84.285 Y102.755 E.00929
G1 X83.961 Y102.522 E.00845
G1 X83.666 Y102.251 E.0085
G1 X83.404 Y101.947 E.00849
G1 X83.181 Y101.613 E.00849
G1 X82.926 Y101.078 E.01255
G1 X82.816 Y100.72 E.00791
G1 X82.737 Y100.289 E.00929
G1 X82.715 Y99.89 E.00845
G1 X82.74 Y99.49 E.00849
G1 X82.812 Y99.095 E.0085
G1 X83.003 Y98.533 E.01256
G1 X83.174 Y98.201 E.00791
G1 X83.419 Y97.836 E.0093
G1 X84.597 Y96.482 E.038
G1 X79.631 Y96.482 E.10513
G1 X79.394 Y96.454 E.00504
G1 X79.182 Y96.376 E.00478
G1 X79.063 Y96.301 E.00298
G1 X78.884 Y96.119 E.00542
G1 X78.834 Y96.042 E.00193
G1 X78.743 Y95.813 E.00522
G1 X78.714 Y95.565 E.0053
G1 X78.714 Y77.619 E.37984
G1 X78.753 Y77.349 E.00578
G1 X78.809 Y77.207 E.00324
G1 X78.894 Y77.07 E.00339
G1 X79.076 Y76.891 E.00542
G1 X79.294 Y76.775 E.00522
G1 X79.543 Y76.723 E.00539
G1 X92.571 Y76.721 E.27575
G1 X92.805 Y76.749 E.00497
G1 X92.942 Y76.794 E.00308
G1 X93.119 Y76.889 E.00424
G1 X93.07 Y77.082 E.0042
G1 X80.02 Y77.082 E.27621
G1 X79.651 Y77.171 E.00805
G1 X79.397 Y77.35 E.00657
G1 X79.233 Y77.546 E.00539
G1 X79.112 Y77.807 E.0061
G1 X79.075 Y78.056 E.00533
G1 X79.075 Y95.155 E.36192
G1 X79.128 Y95.453 E.0064
G1 X79.311 Y95.77 E.00776
G1 X79.639 Y96.029 E.00884
G1 X80.022 Y96.12 E.00834
G1 X84.795 Y96.12 E.10103
; WIPE_START
M204 S6000
G1 X86.795 Y96.12 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X83.699 Y96.891 Z1.44 F18000
G1 Z1.04
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X79.607 Y96.891 E.08049
G1 X79.298 Y96.855 E.00612
G1 X79.001 Y96.745 E.00622
G1 X78.822 Y96.634 E.00415
G1 X78.712 Y96.541 E.00284
G1 X78.558 Y96.368 E.00454
G1 X78.478 Y96.246 E.00287
G1 X78.407 Y96.102 E.00316
G1 X78.341 Y95.902 E.00415
G1 X78.304 Y95.589 E.0062
G1 X78.304 Y77.607 E.35368
G1 X78.313 Y77.454 E.00301
G1 X78.359 Y77.231 E.00448
M73 P42 R14
G1 X78.442 Y77.022 E.00442
G1 X78.562 Y76.829 E.00447
G1 X78.664 Y76.709 E.0031
G1 X78.827 Y76.565 E.00428
G1 X78.947 Y76.486 E.00284
G1 X79.153 Y76.389 E.00448
G1 X79.374 Y76.33 E.00448
G1 X79.519 Y76.313 E.00289
G1 X92.596 Y76.311 E.2572
G1 X92.894 Y76.347 E.00591
G1 X93.105 Y76.417 E.00437
G1 X93.303 Y76.524 E.00442
G1 X93.479 Y76.663 E.00442
G1 X93.629 Y76.831 E.00442
G1 X93.746 Y77.022 E.00442
G1 X93.829 Y77.231 E.00442
G1 X93.874 Y77.448 E.00436
G1 X93.884 Y88.791 E.2231
G1 X92.704 Y88.791 E.02321
G1 X92.704 Y77.491 E.22226
G1 X80.069 Y77.491 E.24852
G1 X79.823 Y77.551 E.00498
G1 X79.677 Y77.654 E.00353
G1 X79.582 Y77.767 E.00291
G1 X79.508 Y77.925 E.00343
G1 X79.484 Y78.086 E.00319
G1 X79.484 Y95.119 E.33504
G1 X79.518 Y95.311 E.00382
G1 X79.626 Y95.498 E.00425
G1 X79.821 Y95.652 E.00489
G1 X80.07 Y95.711 E.00503
G1 X92.291 Y95.711 E.24038
G1 X92.313 Y95.376 E.0066
G1 X92.349 Y95.211 E.00332
G1 X92.417 Y95.044 E.00354
G1 X92.589 Y94.807 E.00577
G1 X92.674 Y94.73 E.00226
G1 X92.924 Y94.584 E.00569
G1 X93.168 Y94.52 E.00497
G1 X93.448 Y94.523 E.0055
G1 X93.725 Y94.611 E.00571
G1 X94.03 Y94.807 E.00714
G1 X95.622 Y94.286 E.03294
G1 X100.647 Y87.111 E.1723
G1 X101.613 Y87.787 E.02321
G1 X96.375 Y95.268 E.17961
G1 X93.442 Y96.576 E.06316
G1 X93.298 Y96.682 E.00353
G1 X93.099 Y96.787 E.00442
G1 X92.891 Y96.855 E.00431
G1 X92.582 Y96.891 E.00611
G1 X88.471 Y96.891 E.08086
G1 X88.952 Y97.411 E.01393
G1 X89.23 Y97.772 E.00897
G1 X89.348 Y97.957 E.00431
G1 X89.54 Y98.325 E.00816
G1 X89.715 Y98.781 E.0096
G1 X89.823 Y99.22 E.0089
G1 X89.877 Y99.661 E.00873
G1 X89.878 Y100.117 E.00897
G1 X89.859 Y100.335 E.00431
G1 X89.788 Y100.744 E.00816
G1 X89.65 Y101.212 E.00961
G1 X89.485 Y101.593 E.00815
G1 X89.244 Y102.009 E.00947
G1 X88.993 Y102.34 E.00816
G1 X88.656 Y102.694 E.00961
G1 X88.305 Y102.979 E.00889
G1 X88.124 Y103.102 E.00431
G1 X87.758 Y103.305 E.00823
G1 X87.521 Y103.412 E.00512
G1 X87.313 Y103.489 E.00435
G1 X86.876 Y103.609 E.00891
G1 X86.429 Y103.676 E.00891
G1 X86.21 Y103.689 E.00431
G1 X85.757 Y103.676 E.00891
G1 X85.309 Y103.608 E.00891
G1 X85.093 Y103.556 E.00437
G1 X84.881 Y103.491 E.00437
G1 X84.496 Y103.336 E.00816
G1 X84.067 Y103.103 E.00961
G1 X83.703 Y102.84 E.00884
G1 X83.371 Y102.536 E.00885
G1 X83.078 Y102.195 E.00885
G1 X82.827 Y101.821 E.00885
G1 X82.621 Y101.417 E.00891
G1 X82.539 Y101.214 E.00431
G1 X82.418 Y100.817 E.00816
G1 X82.33 Y100.337 E.0096
G1 X82.305 Y99.889 E.00884
G1 X82.333 Y99.44 E.00885
G1 X82.414 Y98.997 E.00885
G1 X82.548 Y98.564 E.00891
G1 X82.631 Y98.361 E.00431
G1 X82.821 Y97.993 E.00816
G1 X83.093 Y97.587 E.00961
G1 X83.66 Y96.936 E.01697
; WIPE_START
M204 S6000
G1 X81.66 Y96.914 E-.38
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




G1 X79.527 Y96.236
G1 Z1.04
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.0939587
G1 F1500
M204 S6000
G1 X79.454 Y96.206 E.00027
; LINE_WIDTH: 0.121258
G1 X79.381 Y96.165 E.0004
; LINE_WIDTH: 0.155367
G1 X79.194 Y96.04 E.00145
G1 X79.103 Y95.953 E.00081
G1 X79.04 Y95.845 E.00081
; LINE_WIDTH: 0.128542
G1 X78.998 Y95.734 E.00061
; LINE_WIDTH: 0.094456
G1 X78.955 Y95.622 E.00041
; WIPE_START
G1 X78.998 Y95.734 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X84.638 Y97.167 Z1.44 F18000
G1 Z1.04
G1 E.4 F1800
; LINE_WIDTH: 0.4752
G1 F1500
M204 S6000
G1 X84.464 Y97.315 E.00513
; LINE_WIDTH: 0.438791
G1 X84.263 Y97.487 E.00545
; LINE_WIDTH: 0.402126
G1 X84.089 Y97.664 E.00466
; LINE_WIDTH: 0.359892
G1 X83.722 Y98.068 E.00909
G1 X83.503 Y98.393 E.00652
G1 X83.292 Y98.837 E.0082
G1 X83.186 Y99.187 E.00609
G1 X83.119 Y99.536 E.00593
G1 X83.098 Y100.005 E.00783
G1 X83.165 Y100.539 E.00896
G1 X83.284 Y100.945 E.00707
G1 X83.512 Y101.421 E.00879
G1 X83.774 Y101.798 E.00765
G1 X84.043 Y102.086 E.00657
G1 X84.455 Y102.412 E.00876
G1 X84.892 Y102.646 E.00826
G1 X85.302 Y102.793 E.00727
G1 X85.828 Y102.884 E.0089
G1 X86.125 Y102.896 E.00495
G1 X86.662 Y102.846 E.009
G1 X87.067 Y102.735 E.007
G1 X87.508 Y102.544 E.008
G1 X87.821 Y102.349 E.00616
G1 X88.221 Y102.013 E.00871
G1 X88.571 Y101.593 E.00911
G1 X88.761 Y101.272 E.00622
G1 X88.908 Y100.943 E.00601
G1 X89.04 Y100.45 E.0085
G1 X89.085 Y100.081 E.0062
G1 X89.068 Y99.536 E.00909
G1 X89.042 Y99.369 E.00282
G1 X88.96 Y99.015 E.00606
G1 X88.819 Y98.65 E.00652
G1 X88.58 Y98.228 E.00808
G1 X88.222 Y97.784 E.00951
; LINE_WIDTH: 0.375783
G1 X88.043 Y97.612 E.00434
; LINE_WIDTH: 0.408474
G1 X87.836 Y97.416 E.00543
; LINE_WIDTH: 0.445775
G1 X87.656 Y97.272 E.00484
; LINE_WIDTH: 0.479631
G1 X87.475 Y97.128 E.00523
; WIPE_START
G1 X87.656 Y97.272 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X94.029 Y95.546 Z1.44 F18000
G1 Z1.04
G1 E.4 F1800
; LINE_WIDTH: 0.152249
G1 F1500
M204 S6000
G1 X94.523 Y95.356 E.00334
; LINE_WIDTH: 0.103915
G1 X95.017 Y95.165 E.00206
; WIPE_START
G1 X94.523 Y95.356 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X89.49 Y89.618 Z1.44 F18000
G1 X78.949 Y77.601 Z1.44
G1 Z1.04
G1 E.4 F1800
; LINE_WIDTH: 0.0994707
G1 F1500
M204 S6000
G1 X79.004 Y77.423 E.00069
; LINE_WIDTH: 0.151171
G1 X79.055 Y77.332 E.00065
G1 X79.203 Y77.151 E.00146
G1 X79.546 Y76.936 E.00253
; CHANGE_LAYER
; Z_HEIGHT: 1.16
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F1500
G1 X79.203 Y77.151 E-.20716
G1 X79.055 Y77.332 E-.11943
G1 X79.004 Y77.423 E-.05341
; WIPE_END
G1 E-.02 F1800
; layer num/total_layer_count: 9/57
; update layer progress
M73 L9
M991 S0 P8 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z1.44 I-.26 J1.189 P1  F18000
G1 X93.468 Y80.581 Z1.44
G1 Z1.16
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X93.475 Y88.382 E.1651
G1 X93.114 Y88.382 E.00764
G1 X93.114 Y77.128 E.23818
G1 X93.299 Y77.076 E.00407
G1 X93.379 Y77.207 E.00325
G1 X93.436 Y77.349 E.00324
G1 X93.465 Y77.49 E.00306
G1 X93.468 Y80.521 E.06416
; WIPE_START
M204 S6000
G1 X93.469 Y82.521 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X93.575 Y90.153 Z1.56 F18000
G1 X93.65 Y95.57 Z1.56
G1 Z1.16
G1 E.4 F1800
G1 F1500
M204 S500
G1 X93.122 Y95.806 E.01226
G1 X93.14 Y95.498 E.00653
G1 X93.167 Y95.413 E.00189
G1 X93.254 Y95.351 E.00226
G1 X93.318 Y95.354 E.00135
G1 X93.391 Y95.38 E.00164
G1 X93.602 Y95.535 E.00555
; WIPE_START
M204 S6000
G1 X93.122 Y95.806 E-.1436
G1 X93.14 Y95.498 E-.08034
G1 X93.167 Y95.413 E-.02328
G1 X93.254 Y95.351 E-.02777
G1 X93.318 Y95.354 E-.0166
G1 X93.391 Y95.38 E-.02022
G1 X93.602 Y95.535 E-.06821
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X86.092 Y96.897 Z1.56 F18000
G1 X84.866 Y97.12 Z1.56
G1 Z1.16
G1 E.4 F1800
G1 F1500
M204 S500
G1 X84.747 Y96.956 E.00429
G1 X85.105 Y96.544 E.01155
G1 X87.077 Y96.544 E.04174
G1 X87.429 Y96.947 E.01132
G1 X87.306 Y97.112 E.00436
G1 X86.861 Y96.953 E.01
G1 X86.488 Y96.88 E.00804
G1 X85.958 Y96.856 E.01123
G1 X85.432 Y96.928 E.01124
G1 X85.067 Y97.034 E.00803
G1 X84.922 Y97.096 E.00335
; WIPE_START
M204 S6000
G1 X84.747 Y96.956 E-.04255
G1 X85.105 Y96.544 E-.10365
G1 X86.336 Y96.544 E-.2338
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X83.499 Y99.556 Z1.56 F18000
G1 Z1.16
G1 E.4 F1800
G1 F1500
M204 S500
G1 X83.501 Y99.519 E.00077
G1 X83.568 Y99.205 E.00681
G1 X83.664 Y98.922 E.00632
G1 X83.884 Y98.491 E.01023
G1 X84.172 Y98.118 E.00999
G1 X84.522 Y97.803 E.00995
G1 X84.914 Y97.561 E.00975
G1 X85.211 Y97.434 E.00683
G1 X85.52 Y97.344 E.00683
G1 X85.977 Y97.282 E.00975
G1 X86.437 Y97.302 E.00975
G1 X86.754 Y97.365 E.00683
G1 X87.052 Y97.462 E.00663
G1 X87.336 Y97.593 E.00663
G1 X87.611 Y97.763 E.00683
G1 X87.962 Y98.061 E.00975
G1 X88.255 Y98.417 E.00975
G1 X88.42 Y98.694 E.00683
G1 X88.551 Y98.989 E.00683
G1 X88.674 Y99.433 E.00975
G1 X88.716 Y99.901 E.00995
G1 X88.674 Y100.371 E.00999
G1 X88.542 Y100.836 E.01023
G1 X88.42 Y101.109 E.00632
G1 X88.255 Y101.385 E.00681
G1 X87.962 Y101.741 E.00975
G1 X87.611 Y102.039 E.00975
G1 X87.337 Y102.208 E.00681
G1 X87.066 Y102.334 E.00632
G1 X86.603 Y102.473 E.01023
G1 X86.143 Y102.521 E.0098
G1 X85.822 Y102.507 E.00681
G1 X85.527 Y102.459 E.00632
G1 X85.066 Y102.313 E.01023
G1 X84.65 Y102.089 E.00999
G1 X84.29 Y101.802 E.00976
G1 X84.071 Y101.566 E.00681
G1 X83.895 Y101.325 E.00632
G1 X83.669 Y100.897 E.01023
G1 X83.53 Y100.446 E.00999
G1 X83.474 Y99.979 E.00995
G1 X83.496 Y99.616 E.00771
M204 S250
G1 X83.908 Y99.58 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X83.908 Y99.574 E.00011
G1 X83.964 Y99.313 E.00526
G1 X84.042 Y99.081 E.00482
G1 X84.231 Y98.711 E.00817
G1 X84.474 Y98.397 E.00781
G1 X84.768 Y98.132 E.0078
G1 X85.103 Y97.925 E.00773
G1 X85.349 Y97.82 E.00526
G1 X85.605 Y97.745 E.00526
G1 X85.995 Y97.692 E.00774
G1 X86.388 Y97.71 E.00773
G1 X86.651 Y97.762 E.00526
G1 X86.902 Y97.843 E.0052
G1 X87.142 Y97.954 E.0052
G1 X87.369 Y98.095 E.00526
G1 X87.669 Y98.349 E.00773
G1 X87.919 Y98.653 E.00773
G1 X88.056 Y98.883 E.00526
G1 X88.165 Y99.127 E.00526
G1 X88.27 Y99.506 E.00773
G1 X88.305 Y99.901 E.0078
G1 X88.27 Y100.296 E.00781
G1 X88.156 Y100.696 E.00817
M73 P43 R14
G1 X88.056 Y100.919 E.00482
G1 X87.919 Y101.149 E.00525
G1 X87.669 Y101.452 E.00773
G1 X87.369 Y101.707 E.00773
G1 X87.142 Y101.847 E.00526
G1 X86.92 Y101.951 E.00482
G1 X86.522 Y102.07 E.00817
G1 X86.131 Y102.111 E.00775
G1 X85.864 Y102.099 E.00525
G1 X85.622 Y102.06 E.00482
G1 X85.226 Y101.934 E.00817
G1 X84.877 Y101.746 E.00781
G1 X84.569 Y101.501 E.00774
G1 X84.387 Y101.305 E.00525
G1 X84.243 Y101.107 E.00482
G1 X84.049 Y100.74 E.00817
G1 X83.932 Y100.361 E.00781
G1 X83.885 Y99.967 E.0078
G1 X83.904 Y99.64 E.00644
; WIPE_START
M204 S6000
G1 X83.908 Y99.574 E-.0125
G1 X83.964 Y99.313 E-.05077
G1 X84.042 Y99.081 E-.04652
G1 X84.231 Y98.711 E-.07889
G1 X84.474 Y98.397 E-.07545
G1 X84.768 Y98.132 E-.07534
G1 X84.95 Y98.02 E-.04053
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X84.855 Y96.12 Z1.56 F18000
G1 Z1.16
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X92.678 Y96.12 E.16557
G1 X92.718 Y95.441 E.01439
G1 X92.742 Y95.331 E.00238
G1 X92.784 Y95.227 E.00238
G1 X92.857 Y95.121 E.00272
G1 X92.98 Y95.015 E.00343
G1 X93.086 Y94.961 E.00253
G1 X93.237 Y94.926 E.00327
G1 X93.384 Y94.932 E.00312
G1 X93.525 Y94.971 E.0031
G1 X93.616 Y95.019 E.00218
G1 X93.95 Y95.264 E.00878
G1 X95.879 Y94.633 E.04295
G1 X100.747 Y87.68 E.17964
G1 X101.043 Y87.888 E.00765
G1 X96.105 Y94.94 E.18222
G1 X93.244 Y96.216 E.0663
G1 X93.021 Y96.37 E.00573
G1 X92.803 Y96.453 E.00495
G1 X92.559 Y96.482 E.00521
G1 X87.586 Y96.482 E.10525
G1 X88.752 Y97.814 E.03748
G1 X88.891 Y98.002 E.00496
G1 X89.164 Y98.49 E.01182
G1 X89.323 Y98.904 E.00939
G1 X89.45 Y99.489 E.01268
G1 X89.469 Y100.1 E.01292
G1 X89.39 Y100.646 E.01168
G1 X89.264 Y101.073 E.00941
G1 X89.007 Y101.616 E.01272
G1 X88.684 Y102.071 E.01182
G1 X88.378 Y102.393 E.00939
G1 X88.061 Y102.65 E.00864
G1 X87.543 Y102.955 E.01273
G1 X87.016 Y103.152 E.01189
G1 X86.798 Y103.207 E.00476
G1 X86.386 Y103.269 E.00883
G1 X85.794 Y103.267 E.01253
G1 X85.201 Y103.161 E.01274
G1 X84.638 Y102.951 E.01273
G1 X84.287 Y102.757 E.00849
G1 X83.961 Y102.522 E.00849
G1 X83.666 Y102.251 E.0085
G1 X83.404 Y101.947 E.00849
G1 X83.181 Y101.613 E.00849
G1 X82.998 Y101.256 E.00849
G1 X82.86 Y100.88 E.00849
G1 X82.766 Y100.489 E.0085
G1 X82.719 Y100.081 E.00868
G1 X82.736 Y99.53 E.01169
G1 X82.813 Y99.093 E.00939
G1 X82.934 Y98.703 E.00864
G1 X83.172 Y98.205 E.01169
G1 X83.419 Y97.836 E.00939
G1 X84.597 Y96.482 E.038
G1 X79.631 Y96.482 E.10513
G1 X79.382 Y96.453 E.0053
G1 X79.171 Y96.37 E.0048
G1 X78.977 Y96.224 E.00515
G1 X78.885 Y96.12 E.00294
G1 X78.837 Y96.048 E.00181
G1 X78.744 Y95.821 E.0052
G1 X78.714 Y95.565 E.00547
G1 X78.714 Y77.619 E.37984
G1 X78.755 Y77.34 E.00596
G1 X78.86 Y77.118 E.0052
G1 X78.956 Y76.997 E.00327
G1 X79.067 Y76.898 E.00314
G1 X79.295 Y76.775 E.00549
G1 X79.546 Y76.723 E.00541
G1 X92.573 Y76.721 E.27574
G1 X92.804 Y76.749 E.00493
G1 X92.942 Y76.794 E.00308
G1 X93.119 Y76.889 E.00424
G1 X93.07 Y77.082 E.0042
G1 X80.058 Y77.082 E.2754
G1 X79.849 Y77.106 E.00446
G1 X79.556 Y77.223 E.00668
G1 X79.249 Y77.512 E.00893
G1 X79.112 Y77.807 E.00688
G1 X79.075 Y78.056 E.00533
G1 X79.075 Y95.155 E.36192
G1 X79.128 Y95.453 E.0064
G1 X79.316 Y95.778 E.00796
G1 X79.676 Y96.047 E.00952
G1 X80.031 Y96.12 E.00767
G1 X84.795 Y96.12 E.10083
; WIPE_START
M204 S6000
G1 X86.795 Y96.12 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X83.699 Y96.891 Z1.56 F18000
G1 Z1.16
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X79.607 Y96.891 E.08049
G1 X79.294 Y96.854 E.0062
G1 X79.095 Y96.789 E.00412
G1 X78.955 Y96.72 E.00306
G1 X78.697 Y96.526 E.00636
G1 X78.559 Y96.369 E.00412
G1 X78.479 Y96.248 E.00284
G1 X78.382 Y96.039 E.00454
G1 X78.341 Y95.904 E.00276
G1 X78.304 Y95.589 E.00625
G1 X78.304 Y77.607 E.35368
G1 X78.313 Y77.454 E.00301
G1 X78.36 Y77.228 E.00454
G1 X78.409 Y77.093 E.00283
G1 X78.517 Y76.893 E.00448
G1 X78.657 Y76.716 E.00443
G1 X78.815 Y76.574 E.00418
G1 X78.948 Y76.485 E.00314
G1 X79.154 Y76.389 E.00447
G1 X79.359 Y76.333 E.00418
G1 X79.52 Y76.313 E.0032
G1 X92.598 Y76.311 E.25722
G1 X92.894 Y76.347 E.00588
G1 X93.105 Y76.417 E.00437
G1 X93.303 Y76.524 E.00442
G1 X93.479 Y76.663 E.00442
G1 X93.628 Y76.831 E.00442
G1 X93.746 Y77.022 E.00442
G1 X93.829 Y77.231 E.00442
G1 X93.874 Y77.448 E.00436
G1 X93.884 Y88.791 E.2231
G1 X92.704 Y88.791 E.02321
G1 X92.704 Y77.491 E.22226
G1 X80.082 Y77.491 E.24827
G1 X79.95 Y77.506 E.00261
G1 X79.78 Y77.574 E.00361
G1 X79.587 Y77.756 E.00521
G1 X79.508 Y77.925 E.00368
G1 X79.484 Y78.086 E.00319
G1 X79.484 Y95.119 E.33504
G1 X79.518 Y95.311 E.00382
G1 X79.628 Y95.501 E.00431
G1 X79.848 Y95.664 E.0054
G1 X80.073 Y95.711 E.00452
G1 X92.292 Y95.711 E.24034
G1 X92.312 Y95.386 E.00639
G1 X92.349 Y95.211 E.00353
G1 X92.417 Y95.044 E.00353
G1 X92.553 Y94.846 E.00473
G1 X92.676 Y94.728 E.00335
G1 X92.93 Y94.581 E.00576
G1 X93.21 Y94.516 E.00566
G1 X93.448 Y94.524 E.00469
G1 X93.677 Y94.589 E.00468
G1 X93.833 Y94.671 E.00347
G1 X94.023 Y94.81 E.00462
G1 X95.622 Y94.286 E.0331
G1 X100.647 Y87.111 E.1723
G1 X101.613 Y87.787 E.02321
G1 X96.375 Y95.268 E.17961
G1 X93.445 Y96.574 E.0631
G1 X93.229 Y96.723 E.00516
G1 X93.102 Y96.786 E.00279
G1 X92.891 Y96.855 E.00436
G1 X92.582 Y96.891 E.00611
G1 X88.488 Y96.891 E.08053
G1 X89.071 Y97.557 E.01742
G1 X89.348 Y97.957 E.00956
G1 X89.538 Y98.321 E.00807
G1 X89.715 Y98.781 E.00969
G1 X89.823 Y99.22 E.0089
G1 X89.877 Y99.661 E.00873
G1 X89.878 Y100.117 E.00897
G1 X89.859 Y100.335 E.00431
G1 X89.789 Y100.739 E.00807
G1 X89.65 Y101.213 E.0097
G1 X89.487 Y101.588 E.00806
G1 X89.244 Y102.009 E.00956
G1 X88.996 Y102.337 E.00807
G1 X88.656 Y102.694 E.0097
G1 X88.305 Y102.979 E.0089
G1 X88.124 Y103.102 E.0043
G1 X87.725 Y103.322 E.00897
G1 X87.524 Y103.411 E.00431
G1 X87.133 Y103.545 E.00814
G1 X86.879 Y103.609 E.00515
G1 X86.428 Y103.676 E.00896
G1 X86.21 Y103.689 E.0043
G1 X85.757 Y103.676 E.00891
G1 X85.309 Y103.608 E.00891
G1 X85.093 Y103.556 E.00437
G1 X84.881 Y103.491 E.00436
G1 X84.461 Y103.321 E.00891
G1 X84.068 Y103.103 E.00885
G1 X83.703 Y102.84 E.00885
G1 X83.371 Y102.536 E.00885
G1 X83.078 Y102.195 E.00885
G1 X82.827 Y101.821 E.00885
G1 X82.623 Y101.42 E.00885
G1 X82.467 Y100.998 E.00885
G1 X82.363 Y100.56 E.00885
G1 X82.31 Y100.11 E.00891
G1 X82.305 Y99.891 E.00431
G1 X82.329 Y99.482 E.00807
G1 X82.414 Y98.996 E.0097
G1 X82.548 Y98.564 E.0089
G1 X82.631 Y98.362 E.00431
G1 X82.819 Y97.997 E.00807
G1 X83.093 Y97.587 E.0097
G1 X83.659 Y96.936 E.01697
; WIPE_START
M204 S6000
G1 X81.66 Y96.914 E-.38
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




G1 X79.486 Y96.246
G1 Z1.16
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.153058
G1 F1500
M204 S6000
G1 X79.168 Y96.017 E.00249
G1 X79.103 Y95.952 E.00059
G1 X79.018 Y95.801 E.0011
; LINE_WIDTH: 0.123725
G1 X78.987 Y95.711 E.00046
; LINE_WIDTH: 0.093729
G1 X78.956 Y95.622 E.00032
; WIPE_START
G1 X78.987 Y95.711 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X84.638 Y97.167 Z1.56 F18000
G1 Z1.16
G1 E.4 F1800
; LINE_WIDTH: 0.475208
G1 F1500
M204 S6000
G1 X84.464 Y97.315 E.00513
; LINE_WIDTH: 0.438855
G1 X84.263 Y97.487 E.00545
; LINE_WIDTH: 0.401797
G1 X84.085 Y97.669 E.00478
; LINE_WIDTH: 0.360132
G1 X83.886 Y97.872 E.00474
G1 X83.558 Y98.303 E.00903
G1 X83.311 Y98.786 E.00905
G1 X83.184 Y99.182 E.00694
G1 X83.116 Y99.574 E.00664
G1 X83.099 Y100.005 E.00719
G1 X83.158 Y100.51 E.00848
G1 X83.326 Y101.056 E.00953
G1 X83.568 Y101.514 E.00865
G1 X83.774 Y101.798 E.00585
G1 X84.043 Y102.086 E.00657
G1 X84.454 Y102.412 E.00877
G1 X84.905 Y102.653 E.00853
G1 X85.427 Y102.825 E.00916
G1 X85.792 Y102.884 E.00618
G1 X86.142 Y102.9 E.00584
G1 X86.693 Y102.84 E.00924
G1 X87.19 Y102.692 E.00865
G1 X87.507 Y102.542 E.00585
G1 X87.839 Y102.342 E.00647
G1 X88.117 Y102.111 E.00603
G1 X88.389 Y101.825 E.00659
G1 X88.677 Y101.423 E.00823
G1 X88.902 Y100.954 E.00868
G1 X89.017 Y100.559 E.00687
G1 X89.071 Y100.238 E.00543
G1 X89.083 Y99.696 E.00905
G1 X89.039 Y99.352 E.00579
G1 X88.909 Y98.873 E.00827
M73 P44 R14
G1 X88.75 Y98.511 E.0066
G1 X88.555 Y98.19 E.00627
G1 X88.222 Y97.784 E.00877
; LINE_WIDTH: 0.378551
G1 X88.045 Y97.61 E.00438
; LINE_WIDTH: 0.418278
G1 X87.841 Y97.412 E.00556
; LINE_WIDTH: 0.455035
G1 X87.689 Y97.285 E.00425
; LINE_WIDTH: 0.480812
G1 X87.536 Y97.158 E.00451
; WIPE_START
G1 X87.689 Y97.285 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X93.994 Y95.559 Z1.56 F18000
G1 Z1.16
G1 E.4 F1800
; LINE_WIDTH: 0.1636
G1 F1500
M204 S6000
G1 X94.335 Y95.428 E.00251
; LINE_WIDTH: 0.130059
G1 X94.676 Y95.297 E.0019
; LINE_WIDTH: 0.0965183
G1 X95.017 Y95.165 E.00129
; WIPE_START
G1 X94.676 Y95.297 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X89.606 Y89.592 Z1.56 F18000
G1 X78.949 Y77.601 Z1.56
G1 Z1.16
G1 E.4 F1800
; LINE_WIDTH: 0.0889508
G1 F1500
M204 S6000
G1 X78.987 Y77.485 E.00039
; LINE_WIDTH: 0.115031
G1 X79.026 Y77.368 E.00055
; LINE_WIDTH: 0.155094
G1 X79.168 Y77.194 E.00145
G1 X79.384 Y77.024 E.00178
; LINE_WIDTH: 0.118558
G1 X79.411 Y77.01 E.00014
; LINE_WIDTH: 0.0908448
G1 X79.591 Y76.956 E.00061
; CHANGE_LAYER
; Z_HEIGHT: 1.28
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F1500
G1 X79.411 Y77.01 E-.38
; WIPE_END
G1 E-.02 F1800
; layer num/total_layer_count: 10/57
; update layer progress
M73 L10
M991 S0 P9 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z1.56 I-.3 J1.179 P1  F18000
G1 X93.468 Y80.581 Z1.56
G1 Z1.28
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X93.475 Y88.382 E.1651
G1 X93.114 Y88.382 E.00764
G1 X93.114 Y77.128 E.23818
G1 X93.299 Y77.076 E.00407
G1 X93.379 Y77.207 E.00325
G1 X93.436 Y77.349 E.00324
G1 X93.465 Y77.49 E.00306
G1 X93.468 Y80.521 E.06415
; WIPE_START
M204 S6000
G1 X93.469 Y82.521 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X93.579 Y90.153 Z1.68 F18000
G1 X93.657 Y95.567 Z1.68
G1 Z1.28
G1 E.4 F1800
G1 F1500
M204 S500
G1 X93.119 Y95.807 E.01246
G1 X93.141 Y95.49 E.00672
G1 X93.166 Y95.414 E.0017
G1 X93.212 Y95.37 E.00135
G1 X93.295 Y95.347 E.00183
G1 X93.371 Y95.369 E.00166
G1 X93.608 Y95.533 E.00611
; WIPE_START
M204 S6000
G1 X93.119 Y95.807 E-.14426
G1 X93.141 Y95.49 E-.08185
G1 X93.166 Y95.414 E-.0207
G1 X93.212 Y95.37 E-.0164
G1 X93.295 Y95.347 E-.0223
G1 X93.371 Y95.369 E-.02016
G1 X93.608 Y95.533 E-.07434
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X86.098 Y96.896 Z1.68 F18000
G1 X84.866 Y97.12 Z1.68
G1 Z1.28
G1 E.4 F1800
G1 F1500
M204 S500
G1 X84.747 Y96.956 E.00429
G1 X85.105 Y96.544 E.01155
G1 X87.084 Y96.544 E.04188
G1 X87.43 Y96.942 E.01117
G1 X87.323 Y97.104 E.0041
G1 X86.861 Y96.953 E.01029
G1 X86.488 Y96.88 E.00804
G1 X85.958 Y96.856 E.01123
G1 X85.432 Y96.928 E.01124
G1 X85.067 Y97.034 E.00803
G1 X84.922 Y97.096 E.00335
; WIPE_START
M204 S6000
G1 X84.747 Y96.956 E-.04255
G1 X85.105 Y96.544 E-.10364
G1 X86.336 Y96.544 E-.23381
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X83.499 Y99.566 Z1.68 F18000
G1 Z1.28
G1 E.4 F1800
G1 F1500
M204 S500
G1 X83.501 Y99.519 E.001
G1 X83.568 Y99.205 E.00681
G1 X83.663 Y98.924 E.00626
G1 X83.884 Y98.491 E.01028
G1 X84.173 Y98.118 E.01
G1 X84.522 Y97.803 E.00995
G1 X84.914 Y97.561 E.00975
G1 X85.21 Y97.434 E.00683
G1 X85.52 Y97.344 E.00683
G1 X85.977 Y97.282 E.00976
G1 X86.437 Y97.302 E.00975
G1 X86.754 Y97.365 E.00683
G1 X87.061 Y97.465 E.00683
G1 X87.473 Y97.671 E.00975
G1 X87.841 Y97.947 E.00975
G1 X88.068 Y98.177 E.00683
G1 X88.265 Y98.432 E.00683
G1 X88.485 Y98.826 E.00956
G1 X88.598 Y99.129 E.00683
G1 X88.675 Y99.442 E.00683
G1 X88.716 Y99.903 E.0098
G1 X88.669 Y100.387 E.01029
G1 X88.598 Y100.674 E.00626
G1 X88.485 Y100.975 E.00681
G1 X88.261 Y101.378 E.00975
G1 X87.962 Y101.741 E.00995
G1 X87.611 Y102.039 E.00975
G1 X87.337 Y102.208 E.00681
G1 X87.069 Y102.333 E.00627
G1 X86.603 Y102.473 E.01028
G1 X86.143 Y102.521 E.0098
G1 X85.822 Y102.507 E.0068
G1 X85.529 Y102.459 E.00627
G1 X85.066 Y102.313 E.01028
G1 X84.65 Y102.089 E.01
G1 X84.283 Y101.796 E.00995
G1 X83.98 Y101.449 E.00975
G1 X83.806 Y101.178 E.00681
G1 X83.677 Y100.912 E.00627
G1 X83.53 Y100.448 E.01029
G1 X83.474 Y99.979 E.01
G1 X83.495 Y99.626 E.00748
M204 S250
G1 X83.907 Y99.591 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X83.908 Y99.574 E.00032
G1 X83.964 Y99.313 E.00525
G1 X84.041 Y99.084 E.00477
G1 X84.231 Y98.711 E.00822
G1 X84.474 Y98.397 E.00781
G1 X84.768 Y98.132 E.0078
G1 X85.103 Y97.925 E.00773
G1 X85.349 Y97.82 E.00526
G1 X85.605 Y97.745 E.00526
G1 X85.995 Y97.692 E.00774
G1 X86.388 Y97.71 E.00773
G1 X86.651 Y97.762 E.00526
G1 X86.905 Y97.844 E.00526
G1 X87.257 Y98.02 E.00774
G1 X87.571 Y98.256 E.00773
G1 X87.759 Y98.447 E.00526
G1 X87.923 Y98.658 E.00526
G1 X88.113 Y98.999 E.00767
G1 X88.207 Y99.249 E.00526
G1 X88.27 Y99.509 E.00526
G1 X88.305 Y99.902 E.00775
G1 X88.265 Y100.317 E.00822
G1 X88.206 Y100.553 E.00477
G1 X88.113 Y100.803 E.00526
G1 X87.921 Y101.146 E.00773
G1 X87.669 Y101.452 E.0078
G1 X87.369 Y101.707 E.00773
G1 X87.142 Y101.847 E.00526
G1 X86.923 Y101.95 E.00477
G1 X86.523 Y102.07 E.00821
G1 X86.131 Y102.111 E.00775
G1 X85.864 Y102.099 E.00525
G1 X85.624 Y102.06 E.00477
G1 X85.226 Y101.934 E.00821
G1 X84.877 Y101.746 E.00781
G1 X84.567 Y101.499 E.0078
G1 X84.308 Y101.203 E.00773
G1 X84.164 Y100.978 E.00526
G1 X84.058 Y100.76 E.00477
G1 X83.932 Y100.361 E.00822
G1 X83.885 Y99.967 E.00781
G1 X83.904 Y99.651 E.00623
; WIPE_START
M204 S6000
G1 X83.908 Y99.574 E-.01454
G1 X83.964 Y99.313 E-.05076
M73 P44 R13
G1 X84.041 Y99.084 E-.04605
G1 X84.231 Y98.711 E-.07936
G1 X84.474 Y98.397 E-.07546
G1 X84.768 Y98.132 E-.07532
G1 X84.941 Y98.025 E-.03852
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X84.855 Y96.12 Z1.68 F18000
G1 Z1.28
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X92.673 Y96.12 E.16547
G1 X92.72 Y95.431 E.01463
G1 X92.741 Y95.333 E.00213
G1 X92.784 Y95.227 E.00241
G1 X92.851 Y95.128 E.00253
G1 X92.938 Y95.044 E.00257
G1 X93.072 Y94.968 E.00324
G1 X93.283 Y94.922 E.00457
G1 X93.531 Y94.973 E.00537
G1 X93.96 Y95.261 E.01093
G1 X95.879 Y94.633 E.04274
G1 X100.747 Y87.68 E.17964
G1 X101.043 Y87.888 E.00765
G1 X96.105 Y94.94 E.18222
G1 X93.244 Y96.216 E.06631
G1 X93.021 Y96.37 E.00573
G1 X92.803 Y96.453 E.00495
G1 X92.559 Y96.482 E.0052
G1 X87.591 Y96.482 E.10514
G1 X88.778 Y97.845 E.03825
G1 X88.884 Y97.992 E.00385
G1 X89.099 Y98.353 E.00888
G1 X89.323 Y98.901 E.01254
G1 X89.45 Y99.489 E.01273
G1 X89.469 Y100.1 E.01293
G1 X89.391 Y100.642 E.01159
G1 X89.264 Y101.073 E.00951
G1 X89.011 Y101.609 E.01255
G1 X88.663 Y102.098 E.01271
G1 X88.379 Y102.391 E.00862
G1 X88.061 Y102.65 E.00868
G1 X87.543 Y102.955 E.01273
G1 X86.978 Y103.163 E.01273
G1 X86.386 Y103.269 E.01273
G1 X85.794 Y103.267 E.01254
G1 X85.201 Y103.161 E.01273
G1 X84.679 Y102.969 E.01178
G1 X84.285 Y102.755 E.00949
G1 X83.961 Y102.522 E.00844
G1 X83.666 Y102.251 E.00849
G1 X83.404 Y101.947 E.00849
G1 X83.181 Y101.613 E.0085
G1 X82.998 Y101.256 E.00849
G1 X82.86 Y100.88 E.00849
G1 X82.738 Y100.299 E.01256
G1 X82.716 Y99.935 E.00772
G1 X82.74 Y99.487 E.00949
G1 X82.812 Y99.095 E.00844
G1 X83.003 Y98.533 E.01256
G1 X83.17 Y98.209 E.00772
G1 X83.419 Y97.836 E.00949
G1 X84.597 Y96.482 E.03799
G1 X79.631 Y96.482 E.10513
G1 X79.392 Y96.454 E.00508
G1 X79.119 Y96.34 E.00626
G1 X78.992 Y96.24 E.00343
G1 X78.884 Y96.119 E.00343
G1 X78.791 Y95.957 E.00394
G1 X78.743 Y95.812 E.00324
G1 X78.714 Y95.565 E.00527
G1 X78.714 Y77.627 E.37967
G1 X78.753 Y77.346 E.00599
G1 X78.861 Y77.117 E.00537
G1 X79.024 Y76.932 E.00523
G1 X79.156 Y76.839 E.00341
G1 X79.289 Y76.777 E.00311
G1 X79.552 Y76.723 E.00569
G1 X92.575 Y76.721 E.27563
G1 X92.804 Y76.749 E.0049
G1 X92.942 Y76.794 E.00308
G1 X93.119 Y76.889 E.00424
G1 X93.07 Y77.082 E.0042
G1 X80.022 Y77.082 E.27617
G1 X79.666 Y77.166 E.00775
G1 X79.429 Y77.322 E.00601
G1 X79.237 Y77.537 E.0061
G1 X79.112 Y77.807 E.00629
G1 X79.075 Y78.056 E.00532
G1 X79.075 Y95.155 E.36192
G1 X79.128 Y95.453 E.0064
G1 X79.315 Y95.777 E.00792
G1 X79.669 Y96.043 E.00937
G1 X80.029 Y96.12 E.0078
G1 X84.795 Y96.12 E.10088
; WIPE_START
M204 S6000
G1 X86.795 Y96.12 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X83.699 Y96.891 Z1.68 F18000
G1 Z1.28
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X79.607 Y96.891 E.08049
G1 X79.297 Y96.855 E.00613
G1 X79.01 Y96.75 E.00601
G1 X78.888 Y96.68 E.00277
G1 X78.71 Y96.539 E.00448
G1 X78.558 Y96.368 E.00448
G1 X78.477 Y96.246 E.00289
G1 X78.412 Y96.114 E.00289
G1 X78.341 Y95.901 E.00442
G1 X78.304 Y95.589 E.00619
G1 X78.304 Y77.61 E.35363
G1 X78.323 Y77.39 E.00433
G1 X78.359 Y77.23 E.00323
G1 X78.409 Y77.093 E.00287
G1 X78.517 Y76.892 E.00449
G1 X78.648 Y76.726 E.00415
G1 X78.764 Y76.615 E.00317
G1 X78.95 Y76.484 E.00447
G1 X79.141 Y76.394 E.00415
G1 X79.295 Y76.347 E.00317
G1 X79.523 Y76.313 E.00453
G1 X92.599 Y76.311 E.25721
G1 X92.894 Y76.347 E.00584
G1 X93.105 Y76.417 E.00437
G1 X93.303 Y76.524 E.00442
G1 X93.479 Y76.663 E.00442
G1 X93.628 Y76.831 E.00442
G1 X93.746 Y77.022 E.00442
G1 X93.829 Y77.231 E.00442
G1 X93.874 Y77.448 E.00436
G1 X93.884 Y88.791 E.2231
G1 X92.704 Y88.791 E.02321
G1 X92.704 Y77.491 E.22226
G1 X80.07 Y77.491 E.24851
G1 X79.831 Y77.548 E.00484
G1 X79.699 Y77.634 E.0031
G1 X79.583 Y77.765 E.00343
G1 X79.508 Y77.925 E.00349
G1 X79.484 Y78.086 E.00318
G1 X79.484 Y95.119 E.33504
G1 X79.518 Y95.311 E.00383
G1 X79.628 Y95.5 E.0043
G1 X79.843 Y95.662 E.00529
G1 X80.072 Y95.711 E.00462
G1 X92.291 Y95.711 E.24032
G1 X92.314 Y95.373 E.00665
G1 X92.349 Y95.211 E.00326
G1 X92.416 Y95.045 E.00354
G1 X92.545 Y94.855 E.00451
G1 X92.676 Y94.728 E.00359
G1 X92.925 Y94.584 E.00565
G1 X93.16 Y94.521 E.00479
G1 X93.444 Y94.523 E.0056
G1 X93.679 Y94.59 E.0048
G1 X93.789 Y94.644 E.00241
G1 X94.026 Y94.809 E.00568
G1 X95.622 Y94.286 E.03303
G1 X100.647 Y87.111 E.1723
G1 X101.613 Y87.787 E.02321
G1 X96.375 Y95.268 E.17961
G1 X93.445 Y96.575 E.06311
G1 X93.229 Y96.723 E.00516
G1 X93.102 Y96.786 E.00279
G1 X92.891 Y96.855 E.00437
G1 X92.582 Y96.891 E.00611
G1 X88.49 Y96.891 E.08049
G1 X89.098 Y97.59 E.01823
G1 X89.226 Y97.767 E.0043
G1 X89.46 Y98.159 E.00897
G1 X89.555 Y98.356 E.00431
G1 X89.715 Y98.78 E.00891
G1 X89.823 Y99.22 E.00891
G1 X89.877 Y99.661 E.00873
G1 X89.878 Y100.117 E.00897
G1 X89.859 Y100.335 E.00431
G1 X89.79 Y100.735 E.00798
G1 X89.65 Y101.213 E.0098
G1 X89.489 Y101.584 E.00797
G1 X89.363 Y101.82 E.00525
G1 X89.137 Y102.159 E.00802
G1 X88.971 Y102.368 E.00525
G1 X88.656 Y102.693 E.00889
G1 X88.305 Y102.979 E.0089
G1 X88.124 Y103.102 E.00431
G1 X87.725 Y103.322 E.00897
G1 X87.524 Y103.411 E.00431
M73 P45 R13
G1 X87.092 Y103.557 E.00897
G1 X86.88 Y103.608 E.00431
G1 X86.429 Y103.676 E.00897
G1 X86.21 Y103.689 E.00431
G1 X85.757 Y103.676 E.00891
G1 X85.309 Y103.608 E.00891
G1 X85.093 Y103.556 E.00437
G1 X84.881 Y103.491 E.00437
G1 X84.505 Y103.34 E.00798
G1 X84.067 Y103.103 E.00979
G1 X83.703 Y102.84 E.00883
G1 X83.371 Y102.536 E.00885
G1 X83.078 Y102.195 E.00885
G1 X82.827 Y101.821 E.00885
G1 X82.623 Y101.42 E.00885
G1 X82.467 Y100.998 E.00885
G1 X82.362 Y100.557 E.00891
G1 X82.33 Y100.341 E.0043
G1 X82.306 Y99.936 E.00798
G1 X82.333 Y99.439 E.00979
G1 X82.414 Y98.997 E.00883
G1 X82.548 Y98.564 E.00891
G1 X82.631 Y98.362 E.00431
G1 X82.817 Y98.001 E.00798
G1 X83.093 Y97.587 E.00979
G1 X83.659 Y96.936 E.01696
; WIPE_START
M204 S6000
G1 X81.66 Y96.914 E-.38
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




G1 X79.537 Y96.248
G1 Z1.28
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.140081
G1 F1500
M204 S6000
G1 X79.307 Y96.123 E.00149
; LINE_WIDTH: 0.148657
G1 X79.102 Y95.954 E.00163
G1 X78.942 Y95.627 E.00223
; WIPE_START
G1 X79.102 Y95.954 E-.21949
G1 X79.307 Y96.123 E-.16051
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X84.638 Y97.167 Z1.68 F18000
G1 Z1.28
G1 E.4 F1800
; LINE_WIDTH: 0.475213
G1 F1500
M204 S6000
G1 X84.464 Y97.315 E.00513
; LINE_WIDTH: 0.438834
G1 X84.263 Y97.487 E.00545
; LINE_WIDTH: 0.401777
G1 X84.085 Y97.669 E.00478
; LINE_WIDTH: 0.359969
G1 X83.886 Y97.872 E.00474
G1 X83.558 Y98.303 E.00903
G1 X83.31 Y98.789 E.00909
G1 X83.183 Y99.186 E.00695
G1 X83.119 Y99.532 E.00587
G1 X83.099 Y100.005 E.0079
G1 X83.159 Y100.513 E.00853
G1 X83.33 Y101.063 E.0096
G1 X83.509 Y101.42 E.00666
G1 X83.708 Y101.716 E.00594
G1 X84.033 Y102.078 E.00812
G1 X84.454 Y102.412 E.00897
G1 X84.905 Y102.654 E.00853
G1 X85.43 Y102.825 E.0092
G1 X85.792 Y102.884 E.00613
G1 X86.167 Y102.9 E.00624
G1 X86.663 Y102.845 E.00832
G1 X86.869 Y102.794 E.00355
G1 X87.376 Y102.611 E.00898
G1 X87.839 Y102.342 E.00894
G1 X88.24 Y101.994 E.00885
G1 X88.561 Y101.6 E.00847
G1 X88.68 Y101.413 E.0037
G1 X88.906 Y100.94 E.00873
G1 X89.039 Y100.463 E.00827
G1 X89.089 Y99.92 E.00909
G1 X89.069 Y99.541 E.00632
G1 X88.963 Y99.027 E.00876
G1 X88.76 Y98.532 E.00892
G1 X88.584 Y98.236 E.00573
G1 X88.358 Y97.936 E.00626
G1 X88.087 Y97.645 E.00663
; LINE_WIDTH: 0.397712
G1 X87.966 Y97.532 E.00308
; LINE_WIDTH: 0.432784
G1 X87.844 Y97.419 E.00337
; LINE_WIDTH: 0.468089
G1 X87.721 Y97.304 E.00371
; LINE_WIDTH: 0.468441
G1 X87.559 Y97.34 E.00365
; LINE_WIDTH: 0.433605
G1 X87.398 Y97.375 E.00336
; WIPE_START
G1 X87.559 Y97.34 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X94.009 Y95.554 Z1.68 F18000
G1 Z1.28
G1 E.4 F1800
; LINE_WIDTH: 0.153955
G1 F1500
M204 S6000
G1 X94.513 Y95.359 E.00345
; LINE_WIDTH: 0.104484
G1 X95.017 Y95.165 E.00212
; WIPE_START
G1 X94.513 Y95.359 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X89.484 Y89.618 Z1.68 F18000
G1 X78.951 Y77.596 Z1.68
G1 Z1.28
G1 E.4 F1800
; LINE_WIDTH: 0.0983263
G1 F1500
M204 S6000
G1 X79.015 Y77.4 E.00075
; LINE_WIDTH: 0.152376
G1 X79.163 Y77.193 E.0016
G1 X79.242 Y77.119 E.00069
; LINE_WIDTH: 0.139681
G1 X79.471 Y76.993 E.00148
; LINE_WIDTH: 0.0935382
G1 X79.558 Y76.957 E.00032
; CHANGE_LAYER
; Z_HEIGHT: 1.4
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F1500
G1 X79.471 Y76.993 E-.38
; WIPE_END
G1 E-.02 F1800
; layer num/total_layer_count: 11/57
; update layer progress
M73 L11
M991 S0 P10 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z1.68 I-.302 J1.179 P1  F18000
G1 X93.468 Y80.581 Z1.68
G1 Z1.4
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X93.475 Y88.382 E.1651
G1 X93.114 Y88.382 E.00764
G1 X93.114 Y77.128 E.23818
G1 X93.299 Y77.076 E.00407
G1 X93.379 Y77.207 E.00325
G1 X93.436 Y77.349 E.00324
G1 X93.465 Y77.49 E.00306
G1 X93.468 Y80.521 E.06415
; WIPE_START
M204 S6000
G1 X93.469 Y82.521 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X93.584 Y90.153 Z1.8 F18000
G1 X93.665 Y95.564 Z1.8
G1 Z1.4
G1 E.4 F1800
G1 F1500
M204 S500
G1 X93.121 Y95.806 E.0126
G1 X93.14 Y95.498 E.00654
G1 X93.166 Y95.414 E.00186
G1 X93.212 Y95.37 E.00135
G1 X93.32 Y95.341 E.00236
G1 X93.615 Y95.531 E.00743
; WIPE_START
M204 S6000
G1 X93.121 Y95.806 E-.14421
G1 X93.14 Y95.498 E-.07886
G1 X93.166 Y95.414 E-.02249
G1 X93.212 Y95.37 E-.01628
G1 X93.32 Y95.341 E-.02847
G1 X93.615 Y95.531 E-.08969
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X86.106 Y96.899 Z1.8 F18000
G1 X84.856 Y97.126 Z1.8
G1 Z1.4
G1 E.4 F1800
G1 F1500
M204 S500
G1 X84.741 Y96.963 E.00423
G1 X85.105 Y96.544 E.01174
G1 X87.084 Y96.544 E.04188
G1 X87.448 Y96.964 E.01176
G1 X87.329 Y97.128 E.00429
G1 X87.036 Y97.002 E.00674
G1 X86.503 Y96.881 E.01157
G1 X85.973 Y96.857 E.01123
G1 X85.595 Y96.897 E.00804
G1 X85.225 Y96.981 E.00804
G1 X84.912 Y97.104 E.00712
; WIPE_START
M204 S6000
G1 X84.741 Y96.963 E-.04213
G1 X85.105 Y96.544 E-.10541
G1 X86.329 Y96.544 E-.23246
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X83.498 Y99.577 Z1.8 F18000
G1 Z1.4
G1 E.4 F1800
G1 F1500
M204 S500
G1 X83.501 Y99.519 E.00123
G1 X83.568 Y99.205 E.00681
G1 X83.662 Y98.927 E.00621
G1 X83.883 Y98.491 E.01034
G1 X84.172 Y98.118 E.01
G1 X84.522 Y97.803 E.00995
G1 X84.922 Y97.556 E.00995
G1 X85.35 Y97.388 E.00975
G1 X85.665 Y97.316 E.00683
G1 X85.986 Y97.282 E.00683
G1 X86.446 Y97.303 E.00975
G1 X86.905 Y97.407 E.00995
G1 X87.327 Y97.588 E.00972
G1 X87.577 Y97.741 E.00621
G1 X87.853 Y97.957 E.00742
G1 X88.162 Y98.29 E.00962
G1 X88.344 Y98.557 E.00683
G1 X88.488 Y98.835 E.00664
G1 X88.598 Y99.127 E.00661
G1 X88.669 Y99.412 E.00621
G1 X88.716 Y99.898 E.01034
G1 X88.674 Y100.369 E.01
G1 X88.551 Y100.813 E.00975
G1 X88.421 Y101.107 E.00681
G1 X88.271 Y101.359 E.00621
G1 X87.964 Y101.739 E.01034
G1 X87.611 Y102.039 E.00981
G1 X87.337 Y102.208 E.0068
G1 X87.071 Y102.332 E.00621
G1 X86.604 Y102.473 E.01034
G1 X86.143 Y102.521 E.00981
G1 X85.822 Y102.507 E.0068
G1 X85.532 Y102.46 E.00621
G1 X85.066 Y102.313 E.01034
G1 X84.65 Y102.089 E.01001
G1 X84.283 Y101.796 E.00995
G1 X83.98 Y101.449 E.00975
G1 X83.806 Y101.178 E.00681
G1 X83.678 Y100.914 E.00621
G1 X83.53 Y100.449 E.01034
G1 X83.474 Y99.979 E.01
G1 X83.494 Y99.637 E.00725
M204 S250
G1 X83.906 Y99.602 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X83.908 Y99.574 E.00054
G1 X83.964 Y99.313 E.00525
G1 X84.04 Y99.086 E.00472
G1 X84.231 Y98.711 E.00826
G1 X84.474 Y98.397 E.00781
G1 X84.768 Y98.132 E.0078
G1 X85.105 Y97.924 E.0078
G1 X85.471 Y97.78 E.00773
G1 X85.732 Y97.72 E.00526
G1 X85.998 Y97.692 E.00527
G1 X86.391 Y97.71 E.00773
G1 X86.778 Y97.798 E.0078
G1 X87.139 Y97.953 E.00772
G1 X87.343 Y98.078 E.00472
G1 X87.575 Y98.26 E.00579
G1 X87.841 Y98.546 E.00769
G1 X87.992 Y98.767 E.00526
G1 X88.114 Y99.002 E.0052
G1 X88.206 Y99.249 E.00519
G1 X88.264 Y99.482 E.00472
G1 X88.305 Y99.9 E.00826
G1 X88.27 Y100.296 E.00781
G1 X88.165 Y100.675 E.00773
G1 X88.056 Y100.919 E.00526
G1 X87.934 Y101.125 E.00472
G1 X87.67 Y101.452 E.00826
G1 X87.369 Y101.707 E.00775
G1 X87.142 Y101.847 E.00525
G1 X86.925 Y101.949 E.00472
G1 X86.523 Y102.07 E.00826
G1 X86.131 Y102.111 E.00775
G1 X85.864 Y102.099 E.00525
G1 X85.627 Y102.061 E.00472
G1 X85.226 Y101.934 E.00826
G1 X84.876 Y101.746 E.00782
G1 X84.567 Y101.499 E.00779
G1 X84.308 Y101.203 E.00773
G1 X84.164 Y100.978 E.00526
G1 X84.059 Y100.762 E.00472
G1 X83.932 Y100.361 E.00826
G1 X83.885 Y99.967 E.00781
G1 X83.903 Y99.662 E.00602
; WIPE_START
M204 S6000
G1 X83.908 Y99.574 E-.01661
G1 X83.964 Y99.313 E-.05076
G1 X84.04 Y99.086 E-.04558
G1 X84.231 Y98.711 E-.07983
G1 X84.474 Y98.397 E-.07546
G1 X84.768 Y98.132 E-.07532
G1 X84.931 Y98.031 E-.03644
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X84.855 Y96.12 Z1.8 F18000
G1 Z1.4
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X92.678 Y96.12 E.16557
G1 X92.718 Y95.441 E.0144
G1 X92.742 Y95.331 E.00238
G1 X92.784 Y95.227 E.00238
G1 X92.851 Y95.128 E.00252
G1 X92.932 Y95.05 E.00238
G1 X93.063 Y94.97 E.00324
G1 X93.228 Y94.926 E.00363
G1 X93.443 Y94.941 E.00455
G1 X93.539 Y94.978 E.00218
G1 X93.972 Y95.257 E.01091
G1 X95.879 Y94.633 E.04247
G1 X100.747 Y87.68 E.17964
G1 X101.043 Y87.888 E.00765
G1 X96.105 Y94.94 E.18222
G1 X93.244 Y96.216 E.0663
G1 X93.021 Y96.37 E.00573
G1 X92.803 Y96.453 E.00495
G1 X92.559 Y96.482 E.0052
G1 X87.591 Y96.482 E.10514
G1 X88.778 Y97.845 E.03825
G1 X88.884 Y97.992 E.00385
G1 X89.099 Y98.353 E.00888
G1 X89.326 Y98.91 E.01273
G1 X89.451 Y99.499 E.01274
G1 X89.469 Y100.091 E.01254
G1 X89.422 Y100.49 E.00851
G1 X89.267 Y101.066 E.01261
G1 X89.011 Y101.608 E.0127
G1 X88.785 Y101.947 E.00862
G1 X88.517 Y102.258 E.00869
G1 X88.1 Y102.621 E.01171
G1 X87.906 Y102.755 E.00498
G1 X87.586 Y102.933 E.00776
G1 X87.373 Y103.03 E.00495
G1 X86.978 Y103.163 E.00881
G1 X86.386 Y103.269 E.01273
G1 X85.794 Y103.267 E.01254
G1 X85.21 Y103.164 E.01254
G1 X84.824 Y103.033 E.00863
G1 X84.417 Y102.834 E.00959
G1 X83.968 Y102.528 E.0115
G1 X83.666 Y102.251 E.00869
G1 X83.404 Y101.947 E.00849
G1 X83.181 Y101.613 E.00849
G1 X82.998 Y101.256 E.00849
G1 X82.86 Y100.879 E.00849
G1 X82.738 Y100.299 E.01256
G1 X82.716 Y99.939 E.00762
G1 X82.74 Y99.487 E.00958
G1 X82.812 Y99.095 E.00844
G1 X83.003 Y98.533 E.01256
G1 X83.168 Y98.213 E.00762
G1 X83.419 Y97.836 E.00959
G1 X84.597 Y96.482 E.03799
G1 X79.63 Y96.482 E.10513
G1 X79.383 Y96.453 E.00527
G1 X79.173 Y96.372 E.00477
G1 X78.975 Y96.222 E.00526
G1 X78.884 Y96.12 E.00288
G1 X78.791 Y95.957 E.00397
G1 X78.743 Y95.812 E.00324
G1 X78.714 Y95.565 E.00527
G1 X78.714 Y77.627 E.37968
G1 X78.751 Y77.353 E.00583
G1 X78.857 Y77.123 E.00536
G1 X78.956 Y76.997 E.00341
G1 X79.065 Y76.9 E.00308
G1 X79.294 Y76.775 E.00552
G1 X79.543 Y76.723 E.00539
G1 X92.576 Y76.721 E.27585
G1 X92.804 Y76.749 E.00486
G1 X92.942 Y76.794 E.00308
G1 X93.119 Y76.889 E.00424
G1 X93.07 Y77.082 E.0042
G1 X80.056 Y77.082 E.27546
G1 X79.84 Y77.108 E.0046
G1 X79.555 Y77.224 E.00652
G1 X79.249 Y77.512 E.00889
G1 X79.112 Y77.807 E.00688
G1 X79.075 Y78.056 E.00533
G1 X79.075 Y95.155 E.36192
G1 X79.128 Y95.453 E.00639
G1 X79.315 Y95.777 E.00792
G1 X79.668 Y96.043 E.00936
G1 X80.029 Y96.12 E.00781
G1 X84.795 Y96.12 E.10088
; WIPE_START
M204 S6000
G1 X86.795 Y96.12 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X83.699 Y96.891 Z1.8 F18000
G1 Z1.4
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X79.607 Y96.891 E.08049
G1 X79.294 Y96.854 E.00619
G1 X79.081 Y96.784 E.00442
G1 X78.956 Y96.721 E.00276
G1 X78.695 Y96.523 E.00643
G1 X78.558 Y96.369 E.00406
G1 X78.478 Y96.246 E.0029
G1 X78.412 Y96.114 E.00289
G1 X78.341 Y95.901 E.00442
G1 X78.304 Y95.589 E.00619
G1 X78.304 Y77.61 E.35363
G1 X78.322 Y77.392 E.0043
G1 X78.359 Y77.233 E.00321
G1 X78.436 Y77.036 E.00416
G1 X78.516 Y76.894 E.0032
G1 X78.657 Y76.716 E.00447
G1 X78.813 Y76.576 E.00412
G1 X78.948 Y76.485 E.0032
G1 X79.154 Y76.389 E.00446
G1 X79.374 Y76.33 E.00448
G1 X79.519 Y76.313 E.00289
G1 X92.601 Y76.311 E.2573
G1 X92.894 Y76.347 E.00581
G1 X93.105 Y76.417 E.00437
G1 X93.303 Y76.524 E.00442
G1 X93.479 Y76.663 E.00442
G1 X93.628 Y76.831 E.00442
G1 X93.746 Y77.022 E.00442
G1 X93.829 Y77.231 E.00442
G1 X93.874 Y77.448 E.00436
G1 X93.884 Y88.791 E.2231
G1 X92.704 Y88.791 E.02321
G1 X92.704 Y77.491 E.22226
G1 X80.081 Y77.491 E.24828
G1 X79.944 Y77.508 E.00272
G1 X79.779 Y77.574 E.0035
G1 X79.587 Y77.756 E.0052
M73 P46 R13
G1 X79.508 Y77.925 E.00367
G1 X79.484 Y78.086 E.00319
G1 X79.484 Y95.119 E.33504
G1 X79.518 Y95.31 E.00382
G1 X79.627 Y95.5 E.0043
G1 X79.842 Y95.662 E.00528
G1 X80.072 Y95.711 E.00463
G1 X92.292 Y95.711 E.24036
G1 X92.312 Y95.386 E.00639
G1 X92.349 Y95.211 E.00353
G1 X92.417 Y95.044 E.00353
G1 X92.545 Y94.855 E.0045
G1 X92.674 Y94.73 E.00353
G1 X92.922 Y94.585 E.00565
G1 X93.16 Y94.521 E.00485
G1 X93.451 Y94.524 E.00572
G1 X93.725 Y94.611 E.00566
G1 X94.03 Y94.807 E.00715
G1 X95.622 Y94.286 E.03295
G1 X100.647 Y87.111 E.1723
G1 X101.613 Y87.787 E.02321
G1 X96.375 Y95.268 E.17961
G1 X93.445 Y96.574 E.0631
G1 X93.229 Y96.723 E.00516
G1 X93.102 Y96.786 E.00279
G1 X92.891 Y96.855 E.00437
G1 X92.582 Y96.891 E.00611
G1 X88.49 Y96.891 E.08049
G1 X89.098 Y97.59 E.01823
G1 X89.226 Y97.767 E.0043
G1 X89.46 Y98.159 E.00897
G1 X89.555 Y98.356 E.00431
G1 X89.716 Y98.783 E.00897
G1 X89.774 Y98.994 E.00431
G1 X89.856 Y99.443 E.00897
G1 X89.877 Y99.661 E.0043
G1 X89.878 Y100.114 E.00891
G1 X89.826 Y100.561 E.00885
G1 X89.734 Y100.952 E.0079
G1 X89.651 Y101.21 E.00535
G1 X89.491 Y101.58 E.00793
G1 X89.363 Y101.819 E.00534
G1 X89.111 Y102.195 E.00889
G1 X88.816 Y102.538 E.00891
G1 X88.659 Y102.691 E.00432
G1 X88.346 Y102.948 E.00795
G1 X88.122 Y103.102 E.00535
G1 X87.77 Y103.299 E.00793
G1 X87.523 Y103.411 E.00534
G1 X87.092 Y103.557 E.00895
G1 X86.879 Y103.609 E.00431
G1 X86.429 Y103.676 E.00897
G1 X86.21 Y103.689 E.00431
G1 X85.757 Y103.676 E.00891
G1 X85.309 Y103.608 E.00891
G1 X85.096 Y103.557 E.00431
G1 X84.668 Y103.412 E.00889
G1 X84.217 Y103.191 E.00988
G1 X83.879 Y102.976 E.00789
G1 X83.705 Y102.842 E.00431
G1 X83.371 Y102.536 E.00891
G1 X83.078 Y102.195 E.00885
G1 X82.827 Y101.821 E.00885
G1 X82.623 Y101.42 E.00885
G1 X82.467 Y100.998 E.00885
G1 X82.362 Y100.557 E.00891
G1 X82.33 Y100.341 E.00431
G1 X82.306 Y99.94 E.00789
G1 X82.333 Y99.439 E.00988
G1 X82.414 Y98.997 E.00883
G1 X82.548 Y98.564 E.00891
G1 X82.631 Y98.361 E.00431
G1 X82.815 Y98.005 E.00789
G1 X83.093 Y97.587 E.00988
G1 X83.66 Y96.936 E.01697
; WIPE_START
M204 S6000
G1 X81.66 Y96.914 E-.38
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




G1 X79.478 Y96.244
G1 Z1.4
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.148349
G1 F1500
M204 S6000
G1 X79.119 Y95.965 E.00278
G1 X79.042 Y95.849 E.00085
G1 X78.942 Y95.626 E.00149
; WIPE_START
G1 X79.042 Y95.849 E-.11037
G1 X79.119 Y95.965 E-.06332
G1 X79.478 Y96.244 E-.20632
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X84.63 Y97.174 Z1.8 F18000
G1 Z1.4
G1 E.4 F1800
; LINE_WIDTH: 0.473044
G1 F1500
M204 S6000
G1 X84.46 Y97.318 E.00499
; LINE_WIDTH: 0.438137
G1 X84.263 Y97.487 E.00533
; LINE_WIDTH: 0.401762
G1 X84.085 Y97.669 E.00478
; LINE_WIDTH: 0.360107
G1 X83.886 Y97.872 E.00474
G1 X83.558 Y98.304 E.00904
G1 X83.354 Y98.689 E.00727
G1 X83.182 Y99.188 E.00881
G1 X83.119 Y99.532 E.00583
G1 X83.099 Y100.005 E.00791
G1 X83.159 Y100.513 E.00854
G1 X83.331 Y101.066 E.00965
G1 X83.509 Y101.42 E.00662
G1 X83.708 Y101.716 E.00594
G1 X84.013 Y102.057 E.00763
G1 X84.455 Y102.411 E.00945
G1 X84.934 Y102.666 E.00905
G1 X85.433 Y102.825 E.00874
G1 X85.793 Y102.884 E.00608
G1 X86.167 Y102.9 E.00624
G1 X86.692 Y102.836 E.00883
G1 X87.195 Y102.69 E.00874
G1 X87.508 Y102.544 E.00576
G1 X87.843 Y102.338 E.00656
G1 X88.244 Y101.995 E.0088
G1 X88.478 Y101.714 E.0061
G1 X88.682 Y101.415 E.00602
G1 X88.911 Y100.933 E.00891
G1 X89.049 Y100.422 E.00882
G1 X89.086 Y100.069 E.00592
G1 X89.083 Y99.704 E.00609
G1 X89.002 Y99.169 E.00902
G1 X88.834 Y98.692 E.00844
G1 X88.67 Y98.373 E.00598
G1 X88.466 Y98.064 E.00618
G1 X88.105 Y97.663 E.009
; LINE_WIDTH: 0.394633
G1 X87.967 Y97.531 E.00351
; LINE_WIDTH: 0.433336
G1 X87.81 Y97.384 E.00438
; LINE_WIDTH: 0.470087
G1 X87.56 Y97.171 E.00728
; WIPE_START
G1 X87.81 Y97.384 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X94.029 Y95.546 Z1.8 F18000
G1 Z1.4
G1 E.4 F1800
; LINE_WIDTH: 0.152256
G1 F1500
M204 S6000
G1 X94.523 Y95.356 E.00334
; LINE_WIDTH: 0.103917
G1 X95.017 Y95.165 E.00206
; WIPE_START
G1 X94.523 Y95.356 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X89.491 Y89.617 Z1.8 F18000
G1 X78.951 Y77.596 Z1.8
G1 Z1.4
G1 E.4 F1800
; LINE_WIDTH: 0.106866
G1 F1500
M204 S6000
G1 X79.028 Y77.364 E.00099
; LINE_WIDTH: 0.156934
G1 X79.167 Y77.195 E.00143
G1 X79.382 Y77.024 E.0018
; LINE_WIDTH: 0.119308
G1 X79.409 Y77.011 E.00014
; LINE_WIDTH: 0.091319
G1 X79.591 Y76.956 E.00062
; CHANGE_LAYER
; Z_HEIGHT: 1.52
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F1500
G1 X79.409 Y77.011 E-.38
; WIPE_END
G1 E-.02 F1800
; layer num/total_layer_count: 12/57
; update layer progress
M73 L12
M991 S0 P11 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z1.8 I-.3 J1.18 P1  F18000
G1 X93.468 Y80.581 Z1.8
G1 Z1.52
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X93.475 Y88.382 E.1651
G1 X93.114 Y88.382 E.00764
G1 X93.114 Y77.128 E.23818
G1 X93.299 Y77.076 E.00407
G1 X93.379 Y77.207 E.00325
G1 X93.436 Y77.349 E.00324
G1 X93.465 Y77.49 E.00306
G1 X93.468 Y80.521 E.06415
; WIPE_START
M204 S6000
G1 X93.469 Y82.521 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X93.579 Y90.153 Z1.92 F18000
G1 X93.657 Y95.568 Z1.92
G1 Z1.52
G1 E.4 F1800
G1 F1500
M204 S500
G1 X93.122 Y95.806 E.01241
G1 X93.14 Y95.498 E.00653
G1 X93.167 Y95.412 E.00191
G1 X93.246 Y95.351 E.00211
G1 X93.317 Y95.354 E.00152
G1 X93.371 Y95.369 E.00118
G1 X93.608 Y95.533 E.0061
; WIPE_START
M204 S6000
G1 X93.122 Y95.806 E-.14394
G1 X93.14 Y95.498 E-.07968
G1 X93.167 Y95.412 E-.02327
G1 X93.246 Y95.351 E-.0258
G1 X93.317 Y95.354 E-.01854
G1 X93.371 Y95.369 E-.01437
G1 X93.608 Y95.533 E-.07439
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X86.098 Y96.896 Z1.92 F18000
G1 X84.866 Y97.12 Z1.92
G1 Z1.52
G1 E.4 F1800
G1 F1500
M204 S500
G1 X84.747 Y96.956 E.00429
G1 X85.105 Y96.544 E.01155
G1 X87.084 Y96.544 E.04188
G1 X87.43 Y96.942 E.01116
G1 X87.323 Y97.104 E.0041
G1 X86.861 Y96.953 E.01029
G1 X86.488 Y96.88 E.00804
G1 X85.958 Y96.856 E.01123
G1 X85.432 Y96.928 E.01123
G1 X85.067 Y97.034 E.00804
G1 X84.922 Y97.096 E.00335
; WIPE_START
M204 S6000
G1 X84.747 Y96.956 E-.04255
G1 X85.105 Y96.544 E-.10365
G1 X86.336 Y96.544 E-.2338
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X83.497 Y99.588 Z1.92 F18000
G1 Z1.52
G1 E.4 F1800
G1 F1500
M204 S500
G1 X83.502 Y99.51 E.00165
G1 X83.611 Y99.063 E.00975
G1 X83.734 Y98.764 E.00683
G1 X83.891 Y98.482 E.00683
G1 X84.172 Y98.118 E.00975
G1 X84.522 Y97.803 E.00995
G1 X84.914 Y97.561 E.00975
G1 X85.21 Y97.434 E.00683
G1 X85.52 Y97.344 E.00683
G1 X85.977 Y97.282 E.00975
G1 X86.437 Y97.302 E.00975
G1 X86.754 Y97.365 E.00683
G1 X87.061 Y97.465 E.00683
G1 X87.473 Y97.671 E.00975
G1 X87.841 Y97.947 E.00975
G1 X88.068 Y98.177 E.00683
G1 X88.265 Y98.432 E.00683
G1 X88.49 Y98.835 E.00975
G1 X88.638 Y99.271 E.00975
G1 X88.696 Y99.588 E.00683
G1 X88.715 Y99.91 E.00683
G1 X88.674 Y100.369 E.00975
G1 X88.551 Y100.813 E.00975
G1 X88.421 Y101.107 E.0068
G1 X88.273 Y101.357 E.00616
G1 X87.964 Y101.739 E.01039
G1 X87.611 Y102.039 E.00981
G1 X87.337 Y102.208 E.0068
G1 X87.074 Y102.331 E.00615
G1 X86.604 Y102.473 E.01039
G1 X86.143 Y102.521 E.00981
G1 X85.821 Y102.507 E.00683
G1 X85.502 Y102.454 E.00684
G1 X85.064 Y102.312 E.00975
G1 X84.65 Y102.089 E.00995
G1 X84.283 Y101.796 E.00995
G1 X83.98 Y101.449 E.00975
G1 X83.807 Y101.178 E.0068
G1 X83.679 Y100.917 E.00616
G1 X83.53 Y100.449 E.01039
G1 X83.474 Y99.979 E.01001
G1 X83.494 Y99.648 E.00703
M204 S250
G1 X83.906 Y99.612 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X83.908 Y99.571 E.00081
G1 X84.001 Y99.189 E.00773
G1 X84.103 Y98.942 E.00526
G1 X84.233 Y98.708 E.00526
G1 X84.474 Y98.397 E.00773
G1 X84.768 Y98.132 E.0078
G1 X85.103 Y97.925 E.00773
G1 X85.349 Y97.82 E.00526
G1 X85.606 Y97.745 E.00526
G1 X85.995 Y97.692 E.00773
G1 X86.388 Y97.71 E.00773
G1 X86.651 Y97.762 E.00526
G1 X86.905 Y97.844 E.00526
G1 X87.257 Y98.02 E.00773
G1 X87.571 Y98.256 E.00773
G1 X87.759 Y98.447 E.00526
G1 X87.923 Y98.658 E.00526
G1 X88.114 Y99.002 E.00773
G1 X88.241 Y99.374 E.00773
G1 X88.289 Y99.637 E.00526
G1 X88.305 Y99.904 E.00526
G1 X88.27 Y100.296 E.00773
G1 X88.165 Y100.675 E.00774
G1 X88.056 Y100.919 E.00525
G1 X87.936 Y101.123 E.00467
G1 X87.67 Y101.452 E.00831
G1 X87.369 Y101.707 E.00775
G1 X87.142 Y101.847 E.00525
G1 X86.927 Y101.948 E.00467
G1 X86.523 Y102.07 E.00831
G1 X86.131 Y102.111 E.00776
G1 X85.863 Y102.099 E.00526
G1 X85.599 Y102.055 E.00527
G1 X85.226 Y101.934 E.00773
G1 X84.876 Y101.746 E.0078
G1 X84.567 Y101.499 E.00779
G1 X84.308 Y101.203 E.00774
G1 X84.164 Y100.978 E.00525
G1 X84.06 Y100.764 E.00467
G1 X83.932 Y100.362 E.00831
G1 X83.885 Y99.967 E.00781
G1 X83.902 Y99.672 E.00581
; WIPE_START
M204 S6000
G1 X83.908 Y99.571 E-.01921
G1 X84.001 Y99.189 E-.0747
G1 X84.103 Y98.942 E-.05084
G1 X84.233 Y98.708 E-.05083
G1 X84.474 Y98.397 E-.07468
G1 X84.768 Y98.132 E-.07533
G1 X84.922 Y98.037 E-.03441
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X84.855 Y96.12 Z1.92 F18000
G1 Z1.52
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X92.678 Y96.12 E.16557
G1 X92.718 Y95.441 E.01439
G1 X92.742 Y95.331 E.00238
G1 X92.784 Y95.227 E.00238
G1 X92.859 Y95.119 E.00279
G1 X92.93 Y95.051 E.00208
G1 X93.077 Y94.964 E.00361
G1 X93.236 Y94.926 E.00347
G1 X93.384 Y94.932 E.00313
G1 X93.531 Y94.973 E.00323
G1 X93.959 Y95.261 E.01094
G1 X95.879 Y94.633 E.04275
G1 X98.09 Y91.475 E.0816
G1 X98.386 Y91.682 E.00765
G1 X96.105 Y94.94 E.08418
G1 X93.236 Y96.22 E.06649
G1 X93.08 Y96.334 E.0041
G1 X92.938 Y96.409 E.00339
G1 X92.803 Y96.453 E.00301
G1 X92.559 Y96.482 E.0052
G1 X87.591 Y96.482 E.10514
G1 X88.777 Y97.845 E.03825
G1 X88.884 Y97.992 E.00386
G1 X89.099 Y98.353 E.00888
G1 X89.326 Y98.91 E.01273
G1 X89.451 Y99.499 E.01274
G1 X89.469 Y100.1 E.01273
G1 X89.393 Y100.633 E.01141
G1 X89.264 Y101.074 E.00971
G1 X89.011 Y101.61 E.01255
G1 X88.81 Y101.911 E.00766
G1 X88.657 Y102.106 E.00525
G1 X88.221 Y102.529 E.01285
G1 X87.729 Y102.859 E.01254
G1 X87.367 Y103.032 E.0085
G1 X86.978 Y103.163 E.00868
G1 X86.386 Y103.269 E.01273
G1 X85.794 Y103.267 E.01254
G1 X85.201 Y103.161 E.01274
G1 X84.638 Y102.951 E.01273
G1 X84.287 Y102.757 E.00849
G1 X83.961 Y102.522 E.00849
G1 X83.666 Y102.251 E.00849
G1 X83.404 Y101.947 E.00849
G1 X83.181 Y101.613 E.0085
G1 X82.998 Y101.256 E.00849
G1 X82.86 Y100.88 E.00849
G1 X82.766 Y100.489 E.0085
G1 X82.72 Y100.091 E.00849
G1 X82.738 Y99.499 E.01253
G1 X82.812 Y99.095 E.00869
G1 X82.931 Y98.712 E.00849
G1 X83.094 Y98.345 E.00849
G1 X83.411 Y97.845 E.01254
G1 X84.597 Y96.482 E.03824
G1 X79.631 Y96.482 E.10513
G1 X79.374 Y96.452 E.00546
G1 X79.166 Y96.367 E.00476
G1 X78.974 Y96.221 E.0051
G1 X78.885 Y96.12 E.00285
G1 X78.784 Y95.942 E.00432
G1 X78.743 Y95.814 E.00285
G1 X78.714 Y95.565 E.00531
M73 P47 R13
G1 X78.714 Y77.619 E.37984
G1 X78.753 Y77.347 E.00581
G1 X78.857 Y77.123 E.00523
G1 X78.956 Y76.997 E.0034
G1 X79.063 Y76.901 E.00305
G1 X79.295 Y76.775 E.00559
G1 X79.546 Y76.723 E.00542
G1 X92.578 Y76.721 E.27582
G1 X92.804 Y76.748 E.00482
G1 X92.942 Y76.794 E.00308
G1 X93.119 Y76.889 E.00424
G1 X93.07 Y77.082 E.0042
G1 X80.056 Y77.082 E.27546
G1 X79.84 Y77.109 E.00461
G1 X79.554 Y77.224 E.00651
G1 X79.249 Y77.512 E.00888
G1 X79.112 Y77.806 E.00688
G1 X79.075 Y78.056 E.00533
G1 X79.075 Y95.155 E.36192
G1 X79.128 Y95.453 E.0064
G1 X79.315 Y95.777 E.00792
G1 X79.667 Y96.043 E.00935
G1 X80.029 Y96.12 E.00783
G1 X84.795 Y96.12 E.10089
; WIPE_START
M204 S6000
G1 X86.795 Y96.12 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X83.699 Y96.891 Z1.92 F18000
G1 Z1.52
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X79.607 Y96.891 E.08049
G1 X79.291 Y96.854 E.00625
G1 X79.156 Y96.814 E.00277
G1 X78.953 Y96.719 E.0044
G1 X78.694 Y96.522 E.00641
G1 X78.478 Y96.246 E.00689
G1 X78.404 Y96.096 E.00329
G1 X78.341 Y95.902 E.00402
G1 X78.304 Y95.589 E.0062
G1 X78.304 Y77.607 E.35368
G1 X78.313 Y77.454 E.00301
G1 X78.359 Y77.231 E.00449
G1 X78.435 Y77.037 E.00408
G1 X78.516 Y76.894 E.00323
G1 X78.657 Y76.716 E.00447
G1 X78.811 Y76.577 E.00408
G1 X78.948 Y76.485 E.00324
G1 X79.154 Y76.389 E.00447
G1 X79.354 Y76.334 E.00408
G1 X79.52 Y76.313 E.00329
G1 X92.603 Y76.311 E.25732
G1 X92.894 Y76.347 E.00577
G1 X93.105 Y76.417 E.00437
G1 X93.303 Y76.524 E.00442
G1 X93.479 Y76.663 E.00442
G1 X93.628 Y76.831 E.00442
G1 X93.747 Y77.022 E.00442
G1 X93.829 Y77.231 E.00442
G1 X93.874 Y77.448 E.00436
G1 X93.884 Y88.791 E.2231
G1 X92.704 Y88.791 E.02321
G1 X92.704 Y77.491 E.22226
G1 X80.081 Y77.491 E.24828
G1 X79.943 Y77.508 E.00274
G1 X79.779 Y77.575 E.00349
G1 X79.587 Y77.756 E.0052
G1 X79.508 Y77.925 E.00368
G1 X79.484 Y78.086 E.00319
G1 X79.484 Y95.119 E.33504
G1 X79.518 Y95.311 E.00382
G1 X79.627 Y95.5 E.0043
G1 X79.841 Y95.661 E.00527
G1 X80.072 Y95.711 E.00464
G1 X92.292 Y95.711 E.24036
G1 X92.312 Y95.387 E.00639
G1 X92.349 Y95.211 E.00353
G1 X92.416 Y95.044 E.00353
G1 X92.556 Y94.843 E.00481
G1 X92.674 Y94.731 E.00321
G1 X92.926 Y94.582 E.00576
G1 X93.21 Y94.516 E.00572
G1 X93.448 Y94.524 E.00469
G1 X93.679 Y94.59 E.00473
G1 X93.791 Y94.645 E.00246
G1 X94.026 Y94.809 E.00563
G1 X95.622 Y94.286 E.03303
G1 X100.647 Y87.111 E.1723
G1 X101.613 Y87.787 E.02321
G1 X96.375 Y95.268 E.17961
G1 X93.442 Y96.576 E.06316
G1 X93.298 Y96.682 E.00353
G1 X93.099 Y96.787 E.00443
G1 X92.891 Y96.855 E.0043
G1 X92.582 Y96.891 E.00611
G1 X88.49 Y96.891 E.08049
G1 X89.098 Y97.59 E.01823
G1 X89.226 Y97.767 E.0043
G1 X89.46 Y98.159 E.00897
G1 X89.555 Y98.356 E.00431
G1 X89.716 Y98.783 E.00897
G1 X89.774 Y98.994 E.00431
G1 X89.856 Y99.443 E.00897
G1 X89.877 Y99.661 E.0043
G1 X89.878 Y100.117 E.00897
G1 X89.859 Y100.335 E.00431
G1 X89.792 Y100.726 E.00779
G1 X89.65 Y101.213 E.00998
G1 X89.493 Y101.576 E.00778
G1 X89.362 Y101.82 E.00544
G1 X89.142 Y102.152 E.00784
G1 X88.82 Y102.534 E.00983
G1 X88.484 Y102.842 E.00898
G1 X88.31 Y102.975 E.0043
G1 X87.928 Y103.218 E.00891
G1 X87.521 Y103.412 E.00885
G1 X87.092 Y103.557 E.00891
G1 X86.879 Y103.609 E.00431
G1 X86.429 Y103.676 E.00897
G1 X86.21 Y103.689 E.00431
G1 X85.757 Y103.676 E.00891
G1 X85.309 Y103.608 E.00891
G1 X85.093 Y103.556 E.00437
G1 X84.881 Y103.491 E.00436
G1 X84.461 Y103.321 E.00891
G1 X84.068 Y103.103 E.00885
G1 X83.703 Y102.84 E.00885
G1 X83.371 Y102.536 E.00885
G1 X83.078 Y102.195 E.00885
G1 X82.827 Y101.821 E.00885
G1 X82.623 Y101.42 E.00885
G1 X82.467 Y100.998 E.00885
G1 X82.363 Y100.56 E.00885
G1 X82.311 Y100.113 E.00885
G1 X82.312 Y99.661 E.00891
G1 X82.332 Y99.443 E.0043
G1 X82.414 Y98.997 E.00891
G1 X82.547 Y98.567 E.00885
G1 X82.73 Y98.156 E.00885
G1 X82.962 Y97.767 E.00891
G1 X83.091 Y97.59 E.0043
G1 X83.659 Y96.936 E.01704
; WIPE_START
M204 S6000
G1 X81.66 Y96.914 E-.38
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




G1 X79.529 Y96.256
G1 Z1.52
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.153618
G1 F1500
M204 S6000
G1 X79.165 Y96.015 E.00279
G1 X79.103 Y95.956 E.00054
G1 X79.038 Y95.841 E.00084
; LINE_WIDTH: 0.128061
G1 X78.997 Y95.732 E.0006
; LINE_WIDTH: 0.0943591
G1 X78.955 Y95.622 E.0004
; WIPE_START
G1 X78.997 Y95.732 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X84.638 Y97.167 Z1.92 F18000
G1 Z1.52
G1 E.4 F1800
; LINE_WIDTH: 0.475191
G1 F1500
M204 S6000
G1 X84.464 Y97.315 E.00513
; LINE_WIDTH: 0.438814
G1 X84.263 Y97.487 E.00545
; LINE_WIDTH: 0.401763
G1 X84.085 Y97.669 E.00478
; LINE_WIDTH: 0.359797
G1 X83.886 Y97.872 E.00473
G1 X83.569 Y98.285 E.00867
G1 X83.433 Y98.521 E.00454
G1 X83.288 Y98.846 E.00593
G1 X83.186 Y99.184 E.00589
G1 X83.105 Y99.704 E.00876
G1 X83.101 Y100.069 E.00609
G1 X83.166 Y100.544 E.00798
G1 X83.332 Y101.068 E.00917
G1 X83.509 Y101.42 E.00656
G1 X83.708 Y101.716 E.00593
G1 X84.033 Y102.078 E.00812
G1 X84.454 Y102.412 E.00896
G1 X84.903 Y102.651 E.00847
G1 X85.303 Y102.791 E.00706
G1 X85.791 Y102.884 E.00828
G1 X86.142 Y102.895 E.00585
G1 X86.349 Y102.886 E.00346
G1 X86.693 Y102.836 E.00578
G1 X87.198 Y102.689 E.00877
G1 X87.526 Y102.536 E.00602
G1 X87.843 Y102.338 E.00624
G1 X88.223 Y102.013 E.00833
G1 X88.361 Y101.86 E.00343
G1 X88.682 Y101.415 E.00915
G1 X88.908 Y100.942 E.00873
G1 X89.042 Y100.451 E.00849
G1 X89.089 Y99.928 E.00875
G1 X89.069 Y99.553 E.00625
G1 X89.004 Y99.169 E.00649
G1 X88.825 Y98.669 E.00884
G1 X88.584 Y98.236 E.00826
G1 X88.358 Y97.936 E.00626
G1 X88.087 Y97.645 E.00662
; LINE_WIDTH: 0.397705
G1 X87.966 Y97.532 E.00308
; LINE_WIDTH: 0.432764
G1 X87.844 Y97.419 E.00337
; LINE_WIDTH: 0.468069
G1 X87.721 Y97.304 E.00372
; LINE_WIDTH: 0.468491
G1 X87.559 Y97.34 E.00365
; LINE_WIDTH: 0.433769
G1 X87.398 Y97.375 E.00337
; WIPE_START
G1 X87.559 Y97.34 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X94.009 Y95.554 Z1.92 F18000
G1 Z1.52
G1 E.4 F1800
; LINE_WIDTH: 0.153991
G1 F1500
M204 S6000
G1 X94.513 Y95.36 E.00346
; LINE_WIDTH: 0.104495
G1 X95.017 Y95.165 E.00212
; WIPE_START
G1 X94.513 Y95.36 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G17
G3 Z1.92 I.87 J.851 P1  F18000
G1 X99.898 Y89.859 Z1.92
G1 Z1.52
G1 E.4 F1800
; FEATURE: Top surface
; LINE_WIDTH: 0.42
G1 F1500
M204 S2000
G1 X98.37 Y91.387 E.04251
G1 X98.161 Y91.039
G1 X101.2 Y87.999 E.08454
G1 X101.011 Y87.631
G1 X99.463 Y89.179 E.04307
; WIPE_START
M204 S6000
G1 X100.877 Y87.765 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G17
G3 Z1.92 I-1.068 J-.583 P1  F18000
G1 X99.167 Y90.899 Z1.92
G1 Z1.52
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.0953147
G1 F1500
M204 S6000
G1 X98.979 Y91.124 E.00102
; LINE_WIDTH: 0.139824
G1 X98.79 Y91.349 E.00167
; LINE_WIDTH: 0.184333
G1 X98.601 Y91.574 E.00232
; WIPE_START
G1 X98.79 Y91.349 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G17
G3 Z1.92 I1.149 J.401 P1  F18000
G1 X99.526 Y89.242 Z1.92
G1 Z1.52
G1 E.4 F1800
; LINE_WIDTH: 0.204932
G1 F1500
M204 S6000
G1 X99.367 Y89.431 E.00221
; LINE_WIDTH: 0.167254
G1 X99.209 Y89.62 E.00174
; LINE_WIDTH: 0.129576
G1 X99.05 Y89.809 E.00128
; LINE_WIDTH: 0.0918989
G1 X98.891 Y89.999 E.00081
; WIPE_START
G1 X99.05 Y89.809 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G17
G3 Z1.92 I.58 J1.07 P1  F18000
G1 X100.469 Y89.039 Z1.92
G1 Z1.52
G1 E.4 F1800
; LINE_WIDTH: 0.0919003
G1 F1500
M204 S6000
G1 X100.311 Y89.229 E.00081
; LINE_WIDTH: 0.129581
G1 X100.152 Y89.418 E.00128
; LINE_WIDTH: 0.167262
G1 X99.993 Y89.607 E.00174
; LINE_WIDTH: 0.204943
G1 X99.835 Y89.796 E.00221
; WIPE_START
G1 X99.993 Y89.607 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G17
G3 Z1.92 I1.144 J.415 P1  F18000
G1 X100.777 Y87.443 Z1.92
G1 Z1.52
G1 E.4 F1800
; LINE_WIDTH: 0.188069
G1 F1500
M204 S6000
G1 X100.583 Y87.675 E.00245
; LINE_WIDTH: 0.142065
G1 X100.388 Y87.907 E.00176
; LINE_WIDTH: 0.0960618
G1 X100.194 Y88.139 E.00106
; WIPE_START
G1 X100.388 Y87.907 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G17
G3 Z1.92 I.567 J-1.077 P1  F18000
G1 X79.592 Y76.956 Z1.92
G1 Z1.52
G1 E.4 F1800
; LINE_WIDTH: 0.091717
G1 F1500
M204 S6000
G1 X79.408 Y77.011 E.00063
; LINE_WIDTH: 0.119305
G1 X79.384 Y77.023 E.00013
; LINE_WIDTH: 0.156742
G1 X79.167 Y77.194 E.00181
G1 X79.029 Y77.364 E.00143
; LINE_WIDTH: 0.105827
G1 X78.949 Y77.601 E.001
; CHANGE_LAYER
; Z_HEIGHT: 1.64
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F1500
G1 X79.029 Y77.364 E-.38
; WIPE_END
G1 E-.02 F1800
; layer num/total_layer_count: 13/57
; update layer progress
M73 L13
M991 S0 P12 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z1.92 I-.265 J1.188 P1  F18000
G1 X93.468 Y80.581 Z1.92
G1 Z1.64
M73 P48 R13
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X93.475 Y88.382 E.1651
G1 X93.114 Y88.382 E.00764
G1 X93.114 Y77.128 E.23818
G1 X93.299 Y77.076 E.00407
G1 X93.379 Y77.207 E.00325
G1 X93.436 Y77.349 E.00324
G1 X93.465 Y77.49 E.00306
G1 X93.468 Y80.521 E.06416
; WIPE_START
M204 S6000
G1 X93.469 Y82.521 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X93.584 Y90.153 Z2.04 F18000
G1 X93.665 Y95.564 Z2.04
G1 Z1.64
G1 E.4 F1800
G1 F1500
M204 S500
G1 X93.122 Y95.806 E.0126
G1 X93.14 Y95.498 E.00653
G1 X93.172 Y95.409 E.00201
G1 X93.212 Y95.37 E.00118
G1 X93.32 Y95.341 E.00236
G1 X93.615 Y95.531 E.00743
; WIPE_START
M204 S6000
G1 X93.122 Y95.806 E-.14429
G1 X93.14 Y95.498 E-.0789
G1 X93.172 Y95.409 E-.02425
G1 X93.212 Y95.37 E-.01431
G1 X93.32 Y95.341 E-.0285
G1 X93.615 Y95.531 E-.08975
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X86.106 Y96.899 Z2.04 F18000
G1 X84.856 Y97.126 Z2.04
G1 Z1.64
G1 E.4 F1800
G1 F1500
M204 S500
G1 X84.741 Y96.963 E.00423
G1 X85.105 Y96.544 E.01174
G1 X87.074 Y96.544 E.04167
G1 X87.42 Y96.938 E.0111
G1 X87.313 Y97.101 E.00411
G1 X86.861 Y96.953 E.01007
G1 X86.488 Y96.88 E.00804
G1 X85.973 Y96.857 E.0109
G1 X85.596 Y96.897 E.00804
G1 X85.225 Y96.981 E.00804
G1 X84.912 Y97.104 E.00712
; WIPE_START
M204 S6000
G1 X84.741 Y96.963 E-.04213
G1 X85.105 Y96.544 E-.10541
G1 X86.329 Y96.544 E-.23246
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X83.497 Y99.599 Z2.04 F18000
G1 Z1.64
G1 E.4 F1800
G1 F1500
M204 S500
G1 X83.502 Y99.51 E.00189
G1 X83.611 Y99.063 E.00975
G1 X83.734 Y98.764 E.00683
G1 X83.891 Y98.482 E.00683
G1 X84.172 Y98.118 E.00975
G1 X84.522 Y97.803 E.00995
G1 X84.922 Y97.556 E.00995
G1 X85.351 Y97.388 E.00975
G1 X85.665 Y97.316 E.00683
G1 X85.986 Y97.282 E.00683
G1 X86.437 Y97.302 E.00955
G1 X86.754 Y97.365 E.00683
G1 X87.061 Y97.465 E.00683
G1 X87.473 Y97.671 E.00975
G1 X87.849 Y97.952 E.00994
G1 X88.162 Y98.29 E.00975
G1 X88.344 Y98.557 E.00683
G1 X88.492 Y98.843 E.00683
G1 X88.638 Y99.271 E.00956
G1 X88.696 Y99.588 E.00683
G1 X88.715 Y99.901 E.00663
G1 X88.696 Y100.214 E.00663
G1 X88.638 Y100.531 E.00683
G1 X88.489 Y100.967 E.00975
G1 X88.26 Y101.378 E.00995
G1 X87.962 Y101.741 E.00994
G1 X87.61 Y102.039 E.00976
G1 X87.337 Y102.208 E.0068
G1 X87.076 Y102.33 E.0061
G1 X86.604 Y102.473 E.01044
G1 X86.143 Y102.521 E.00982
G1 X85.822 Y102.507 E.0068
G1 X85.537 Y102.461 E.0061
G1 X85.067 Y102.313 E.01044
G1 X84.65 Y102.089 E.01001
G1 X84.282 Y101.796 E.00995
G1 X83.973 Y101.442 E.00994
G1 X83.737 Y101.046 E.00975
G1 X83.615 Y100.748 E.00683
G1 X83.529 Y100.437 E.00682
G1 X83.474 Y99.979 E.00975
G1 X83.493 Y99.659 E.00679
M204 S250
G1 X83.905 Y99.624 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X83.908 Y99.571 E.00103
G1 X84.001 Y99.189 E.00773
G1 X84.103 Y98.942 E.00526
G1 X84.233 Y98.708 E.00526
G1 X84.474 Y98.397 E.00773
G1 X84.768 Y98.132 E.0078
G1 X85.105 Y97.924 E.0078
G1 X85.471 Y97.78 E.00773
G1 X85.732 Y97.72 E.00526
G1 X85.998 Y97.692 E.00526
G1 X86.388 Y97.71 E.00767
G1 X86.651 Y97.762 E.00526
G1 X86.905 Y97.844 E.00526
G1 X87.257 Y98.02 E.00773
G1 X87.574 Y98.258 E.00779
G1 X87.841 Y98.546 E.00773
G1 X87.992 Y98.767 E.00526
G1 X88.115 Y99.005 E.00526
G1 X88.241 Y99.374 E.00767
G1 X88.289 Y99.637 E.00526
G1 X88.305 Y99.901 E.0052
G1 X88.289 Y100.165 E.0052
G1 X88.241 Y100.428 E.00526
G1 X88.114 Y100.8 E.00773
G1 X87.921 Y101.146 E.0078
G1 X87.669 Y101.452 E.00779
G1 X87.369 Y101.707 E.00774
G1 X87.142 Y101.847 E.00525
G1 X86.929 Y101.947 E.00462
G1 X86.523 Y102.07 E.00836
G1 X86.131 Y102.111 E.00776
G1 X85.864 Y102.099 E.00525
G1 X85.632 Y102.062 E.00463
G1 X85.226 Y101.934 E.00836
G1 X84.876 Y101.746 E.00782
G1 X84.566 Y101.499 E.0078
G1 X84.306 Y101.2 E.00779
G1 X84.104 Y100.863 E.00774
G1 X84.003 Y100.615 E.00526
G1 X83.931 Y100.357 E.00526
G1 X83.885 Y99.967 E.00773
G1 X83.902 Y99.683 E.00559
; WIPE_START
M204 S6000
G1 X83.908 Y99.571 E-.02134
G1 X84.001 Y99.189 E-.0747
G1 X84.103 Y98.942 E-.05083
G1 X84.233 Y98.708 E-.05082
G1 X84.474 Y98.397 E-.07471
G1 X84.768 Y98.132 E-.07532
G1 X84.913 Y98.043 E-.03229
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X84.855 Y96.12 Z2.04 F18000
G1 Z1.64
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X92.678 Y96.12 E.16557
G1 X92.718 Y95.441 E.01439
G1 X92.743 Y95.325 E.00251
G1 X92.851 Y95.128 E.00475
G1 X92.932 Y95.05 E.00238
G1 X93.063 Y94.97 E.00324
G1 X93.228 Y94.926 E.00362
G1 X93.443 Y94.941 E.00456
G1 X93.539 Y94.978 E.00218
G1 X93.972 Y95.257 E.01091
G1 X95.879 Y94.633 E.04247
G1 X98.51 Y90.875 E.09709
G1 X98.806 Y91.083 E.00765
G1 X96.105 Y94.94 E.09967
G1 X93.244 Y96.216 E.0663
G1 X93.021 Y96.37 E.00573
G1 X92.803 Y96.453 E.00495
G1 X92.559 Y96.482 E.0052
G1 X87.583 Y96.482 E.10531
G1 X88.741 Y97.8 E.03714
G1 X88.886 Y97.996 E.00515
G1 X89.099 Y98.353 E.0088
G1 X89.323 Y98.901 E.01254
G1 X89.449 Y99.482 E.01257
G1 X89.469 Y100.085 E.01278
G1 X89.422 Y100.49 E.00863
G1 X89.267 Y101.066 E.01262
G1 X89.126 Y101.394 E.00756
G1 X89.007 Y101.617 E.00535
G1 X88.695 Y102.058 E.01143
G1 X88.376 Y102.394 E.00981
G1 X88.107 Y102.615 E.00738
G1 X87.907 Y102.754 E.00515
G1 X87.543 Y102.955 E.0088
G1 X87.033 Y103.147 E.01152
G1 X86.797 Y103.207 E.00515
G1 X86.386 Y103.269 E.0088
G1 X85.794 Y103.267 E.01254
G1 X85.201 Y103.161 E.01273
G1 X84.638 Y102.951 E.01273
G1 X84.287 Y102.757 E.00849
G1 X83.961 Y102.522 E.00849
G1 X83.666 Y102.251 E.0085
G1 X83.404 Y101.947 E.00849
M73 P48 R12
G1 X83.181 Y101.613 E.00849
G1 X82.998 Y101.256 E.00849
G1 X82.86 Y100.879 E.00849
G1 X82.738 Y100.299 E.01256
G1 X82.716 Y99.948 E.00744
G1 X82.74 Y99.486 E.00978
G1 X82.812 Y99.094 E.00845
G1 X83.005 Y98.531 E.01259
G1 X83.192 Y98.17 E.00861
G1 X83.417 Y97.838 E.00849
G1 X84.597 Y96.482 E.03805
G1 X79.631 Y96.482 E.10513
G1 X79.395 Y96.454 E.00502
G1 X79.176 Y96.372 E.00494
G1 X79.063 Y96.302 E.00282
G1 X78.884 Y96.119 E.00543
G1 X78.833 Y96.041 E.00197
G1 X78.743 Y95.812 E.0052
G1 X78.714 Y95.565 E.00527
G1 X78.714 Y77.619 E.37984
G1 X78.753 Y77.349 E.00578
G1 X78.855 Y77.125 E.0052
G1 X78.957 Y76.997 E.00347
G1 X79.062 Y76.901 E.00301
G1 X79.294 Y76.775 E.00558
G1 X79.543 Y76.723 E.00539
G1 X92.579 Y76.721 E.27592
G1 X92.804 Y76.748 E.00479
G1 X92.942 Y76.794 E.00309
G1 X93.119 Y76.889 E.00424
G1 X93.07 Y77.082 E.0042
G1 X80.047 Y77.082 E.27565
G1 X79.781 Y77.123 E.0057
G1 X79.484 Y77.274 E.00704
G1 X79.259 Y77.504 E.00681
G1 X79.113 Y77.8 E.00698
G1 X79.075 Y78.056 E.00548
G1 X79.075 Y95.176 E.36236
G1 X79.167 Y95.548 E.00811
G1 X79.344 Y95.799 E.0065
G1 X79.539 Y95.962 E.00537
G1 X79.8 Y96.084 E.0061
G1 X80.049 Y96.12 E.00533
G1 X84.795 Y96.12 E.10045
; WIPE_START
M204 S6000
G1 X86.795 Y96.12 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X83.699 Y96.891 Z2.04 F18000
G1 Z1.64
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X79.607 Y96.891 E.08049
G1 X79.298 Y96.855 E.00611
G1 X78.994 Y96.741 E.00638
G1 X78.712 Y96.541 E.00681
G1 X78.558 Y96.369 E.00454
G1 X78.478 Y96.246 E.00289
G1 X78.412 Y96.114 E.00289
G1 X78.341 Y95.901 E.00442
G1 X78.304 Y95.589 E.00619
G1 X78.304 Y77.607 E.35368
G1 X78.313 Y77.454 E.00301
G1 X78.359 Y77.231 E.00448
G1 X78.443 Y77.02 E.00448
G1 X78.515 Y76.895 E.00283
G1 X78.657 Y76.716 E.00449
G1 X78.81 Y76.578 E.00405
G1 X78.948 Y76.485 E.00327
G1 X79.154 Y76.389 E.00446
G1 X79.374 Y76.33 E.00448
G1 X79.519 Y76.313 E.00289
G1 X92.604 Y76.312 E.25737
G1 X92.894 Y76.347 E.00574
G1 X93.105 Y76.417 E.00437
G1 X93.303 Y76.524 E.00442
G1 X93.479 Y76.663 E.00442
G1 X93.628 Y76.831 E.00442
G1 X93.747 Y77.022 E.00442
G1 X93.829 Y77.231 E.00442
G1 X93.874 Y77.448 E.00436
G1 X93.884 Y88.791 E.2231
G1 X92.704 Y88.791 E.02321
G1 X92.704 Y77.491 E.22226
G1 X80.078 Y77.491 E.24835
G1 X79.908 Y77.517 E.00338
G1 X79.73 Y77.609 E.00395
G1 X79.597 Y77.744 E.00373
G1 X79.508 Y77.923 E.00393
G1 X79.484 Y78.086 E.00323
G1 X79.484 Y95.126 E.33518
G1 X79.545 Y95.375 E.00503
G1 X79.648 Y95.519 E.00348
G1 X79.761 Y95.614 E.0029
G1 X79.919 Y95.687 E.00343
G1 X80.079 Y95.711 E.00319
G1 X92.292 Y95.711 E.24022
G1 X92.312 Y95.386 E.00639
G1 X92.349 Y95.209 E.00357
G1 X92.396 Y95.088 E.00255
G1 X92.545 Y94.855 E.00544
G1 X92.674 Y94.73 E.00353
G1 X92.922 Y94.585 E.00565
G1 X93.16 Y94.521 E.00485
G1 X93.451 Y94.524 E.00572
G1 X93.725 Y94.611 E.00566
G1 X94.03 Y94.807 E.00714
G1 X95.622 Y94.286 E.03294
G1 X98.41 Y90.305 E.09559
G1 X99.376 Y90.982 E.02321
G1 X96.375 Y95.268 E.10291
G1 X93.445 Y96.574 E.0631
G1 X93.229 Y96.723 E.00516
G1 X93.102 Y96.786 E.0028
G1 X92.891 Y96.855 E.00436
G1 X92.582 Y96.891 E.00611
G1 X88.487 Y96.891 E.08055
G1 X89.06 Y97.543 E.01707
G1 X89.227 Y97.768 E.00552
G1 X89.46 Y98.159 E.00895
G1 X89.555 Y98.356 E.00431
G1 X89.715 Y98.78 E.00891
G1 X89.823 Y99.22 E.00891
G1 X89.882 Y99.831 E.01207
G1 X89.878 Y100.112 E.00552
G1 X89.826 Y100.561 E.00889
G1 X89.737 Y100.942 E.00771
G1 X89.651 Y101.21 E.00554
G1 X89.495 Y101.572 E.00774
G1 X89.243 Y102.009 E.00993
G1 X89.008 Y102.322 E.0077
G1 X88.655 Y102.694 E.01008
G1 X88.354 Y102.942 E.00768
G1 X88.123 Y103.102 E.00553
G1 X87.725 Y103.322 E.00895
G1 X87.151 Y103.539 E.01207
G1 X86.878 Y103.609 E.00552
G1 X86.429 Y103.676 E.00895
G1 X86.21 Y103.689 E.00431
G1 X85.757 Y103.676 E.00891
G1 X85.309 Y103.608 E.00891
G1 X85.093 Y103.556 E.00437
G1 X84.881 Y103.491 E.00436
G1 X84.461 Y103.321 E.00891
G1 X84.068 Y103.103 E.00885
G1 X83.703 Y102.84 E.00885
G1 X83.371 Y102.536 E.00885
G1 X83.078 Y102.195 E.00885
G1 X82.827 Y101.821 E.00885
G1 X82.623 Y101.42 E.00885
G1 X82.467 Y100.998 E.00885
G1 X82.362 Y100.557 E.00891
G1 X82.306 Y99.95 E.012
G1 X82.333 Y99.439 E.01007
G1 X82.414 Y98.997 E.00884
G1 X82.528 Y98.622 E.00771
G1 X82.632 Y98.361 E.00552
G1 X82.84 Y97.96 E.00889
G1 X83.093 Y97.588 E.00885
G1 X83.659 Y96.936 E.01698
; WIPE_START
M204 S6000
G1 X81.66 Y96.914 E-.38
; WIPE_END
M73 P49 R12
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




G1 X79.578 Y96.239
G1 Z1.64
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.102192
G1 F1500
M204 S6000
G1 X79.394 Y96.178 E.00074
; LINE_WIDTH: 0.154964
G1 X79.145 Y95.994 E.002
G1 X78.947 Y95.698 E.0023
; WIPE_START
G1 X79.145 Y95.994 E-.2034
G1 X79.394 Y96.178 E-.1766
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X84.63 Y97.174 Z2.04 F18000
G1 Z1.64
G1 E.4 F1800
; LINE_WIDTH: 0.473052
G1 F1500
M204 S6000
G1 X84.46 Y97.318 E.00499
; LINE_WIDTH: 0.438139
G1 X84.263 Y97.487 E.00533
; LINE_WIDTH: 0.401764
G1 X84.085 Y97.669 E.00478
; LINE_WIDTH: 0.360384
G1 X83.722 Y98.073 E.00906
G1 X83.52 Y98.365 E.00594
G1 X83.354 Y98.685 E.00602
G1 X83.186 Y99.187 E.00883
G1 X83.119 Y99.531 E.00584
G1 X83.098 Y100.005 E.00793
G1 X83.161 Y100.522 E.00869
G1 X83.225 Y100.769 E.00426
G1 X83.348 Y101.103 E.00594
G1 X83.512 Y101.419 E.00594
G1 X83.708 Y101.716 E.00594
G1 X84.033 Y102.078 E.00813
G1 X84.454 Y102.412 E.00898
G1 X84.906 Y102.654 E.00855
G1 X85.438 Y102.827 E.00935
G1 X85.825 Y102.888 E.00654
G1 X86.142 Y102.895 E.00529
G1 X86.664 Y102.846 E.00875
G1 X86.921 Y102.779 E.00444
G1 X87.377 Y102.611 E.00812
G1 X87.843 Y102.338 E.00901
G1 X88.219 Y102.014 E.00828
G1 X88.561 Y101.601 E.00897
G1 X88.674 Y101.424 E.00351
G1 X88.907 Y100.932 E.00908
G1 X89.046 Y100.422 E.00883
G1 X89.088 Y100.061 E.00608
G1 X89.093 Y99.854 E.00345
G1 X89.069 Y99.553 E.00504
G1 X89.006 Y99.188 E.00619
G1 X88.841 Y98.707 E.00848
G1 X88.672 Y98.372 E.00627
G1 X88.45 Y98.044 E.00661
G1 X88.096 Y97.654 E.0088
; LINE_WIDTH: 0.394449
G1 X87.972 Y97.538 E.00313
; LINE_WIDTH: 0.42962
G1 X87.847 Y97.422 E.00343
; LINE_WIDTH: 0.466135
G1 X87.712 Y97.298 E.00402
; LINE_WIDTH: 0.472727
G1 X87.549 Y97.336 E.00373
; LINE_WIDTH: 0.447384
G1 X87.387 Y97.375 E.00352
; WIPE_START
G1 X87.549 Y97.336 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X94.029 Y95.546 Z2.04 F18000
G1 Z1.64
G1 E.4 F1800
; LINE_WIDTH: 0.152234
G1 F1500
M204 S6000
G1 X94.523 Y95.356 E.00334
; LINE_WIDTH: 0.10391
G1 X95.017 Y95.165 E.00206
; WIPE_START
G1 X94.523 Y95.356 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X89.489 Y89.618 Z2.04 F18000
G1 X78.948 Y77.604 Z2.04
G1 Z1.64
G1 E.4 F1800
; LINE_WIDTH: 0.101771
G1 F1500
M204 S6000
G1 X79.006 Y77.423 E.00072
; LINE_WIDTH: 0.152975
G1 X79.057 Y77.32 E.00073
G1 X79.288 Y77.082 E.00211
; LINE_WIDTH: 0.128472
G1 X79.49 Y76.991 E.00113
; LINE_WIDTH: 0.089515
G1 X79.597 Y76.955 E.00036
; WIPE_START
G1 X79.49 Y76.991 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X86.307 Y80.423 Z2.04 F18000
G1 X100.371 Y87.504 Z2.04
G1 Z1.64
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X100.647 Y87.111 E.00944
G1 X100.82 Y87.232 E.00416
G1 X101.613 Y87.787 E.01905
G1 X101.338 Y88.181 E.00944
G1 X100.42 Y87.538 E.02203
M204 S10000
G1 X100.676 Y87.424 F18000
; FEATURE: Gap infill
; LINE_WIDTH: 0.0965169
G1 F1500
M204 S6000
G1 X101.308 Y87.867 E.00272
; CHANGE_LAYER
; Z_HEIGHT: 1.76
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F1500
G1 X100.676 Y87.424 E-.38
; WIPE_END
G1 E-.02 F1800
; layer num/total_layer_count: 14/57
; update layer progress
M73 L14
M991 S0 P13 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z2.04 I.838 J-.883 P1  F18000
G1 X93.468 Y80.581 Z2.04
G1 Z1.76
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X93.475 Y88.382 E.1651
G1 X93.114 Y88.382 E.00764
G1 X93.114 Y77.128 E.23818
G1 X93.299 Y77.076 E.00407
G1 X93.379 Y77.207 E.00325
G1 X93.436 Y77.349 E.00324
G1 X93.465 Y77.49 E.00306
G1 X93.468 Y80.521 E.06415
; WIPE_START
M204 S6000
G1 X93.469 Y82.521 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X93.575 Y90.153 Z2.16 F18000
G1 X93.65 Y95.57 Z2.16
G1 Z1.76
G1 E.4 F1800
G1 F1500
M204 S500
G1 X93.121 Y95.806 E.01226
G1 X93.14 Y95.498 E.00654
G1 X93.166 Y95.414 E.00186
G1 X93.246 Y95.351 E.00215
G1 X93.317 Y95.354 E.00152
G1 X93.391 Y95.38 E.00165
G1 X93.602 Y95.535 E.00554
; WIPE_START
M204 S6000
G1 X93.121 Y95.806 E-.14345
G1 X93.14 Y95.498 E-.08026
G1 X93.166 Y95.414 E-.02288
G1 X93.246 Y95.351 E-.02643
G1 X93.317 Y95.354 E-.01864
G1 X93.391 Y95.38 E-.02025
G1 X93.602 Y95.535 E-.06809
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X86.092 Y96.897 Z2.16 F18000
G1 X84.867 Y97.12 Z2.16
G1 Z1.76
G1 E.4 F1800
G1 F1500
M204 S500
G1 X84.747 Y96.956 E.00429
G1 X85.105 Y96.544 E.01155
G1 X87.084 Y96.544 E.04187
G1 X87.43 Y96.942 E.01116
G1 X87.323 Y97.104 E.0041
G1 X86.861 Y96.953 E.01029
G1 X86.488 Y96.88 E.00804
G1 X85.958 Y96.856 E.01123
G1 X85.432 Y96.928 E.01124
G1 X85.067 Y97.034 E.00804
G1 X84.922 Y97.096 E.00335
; WIPE_START
M204 S6000
G1 X84.747 Y96.956 E-.04255
G1 X85.105 Y96.544 E-.10364
G1 X86.336 Y96.544 E-.23382
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X83.496 Y99.611 Z2.16 F18000
G1 Z1.76
G1 E.4 F1800
G1 F1500
M204 S500
G1 X83.501 Y99.519 E.00194
G1 X83.568 Y99.204 E.00683
G1 X83.673 Y98.898 E.00683
G1 X83.885 Y98.489 E.00975
G1 X84.172 Y98.118 E.00995
G1 X84.522 Y97.803 E.00995
G1 X84.914 Y97.561 E.00976
G1 X85.211 Y97.434 E.00683
G1 X85.52 Y97.344 E.00683
G1 X85.977 Y97.282 E.00975
G1 X86.437 Y97.302 E.00975
G1 X86.754 Y97.365 E.00683
G1 X87.061 Y97.465 E.00683
G1 X87.473 Y97.671 E.00975
G1 X87.849 Y97.953 E.00995
G1 X88.162 Y98.29 E.00975
G1 X88.344 Y98.557 E.00683
G1 X88.488 Y98.835 E.00664
G1 X88.598 Y99.127 E.0066
G1 X88.667 Y99.404 E.00605
G1 X88.716 Y99.898 E.0105
G1 X88.674 Y100.369 E.01002
G1 X88.551 Y100.813 E.00975
G1 X88.421 Y101.107 E.0068
G1 X88.276 Y101.352 E.00605
G1 X87.965 Y101.739 E.0105
G1 X87.61 Y102.039 E.00982
G1 X87.336 Y102.208 E.00683
G1 X87.043 Y102.344 E.00683
G1 X86.601 Y102.473 E.00975
G1 X86.143 Y102.521 E.00975
G1 X85.822 Y102.507 E.00679
G1 X85.54 Y102.462 E.00605
G1 X85.067 Y102.313 E.0105
G1 X84.65 Y102.089 E.01002
G1 X84.283 Y101.796 E.00995
G1 X83.973 Y101.442 E.00995
G1 X83.737 Y101.046 E.00975
G1 X83.615 Y100.748 E.00683
G1 X83.529 Y100.437 E.00683
G1 X83.474 Y99.979 E.00975
G1 X83.492 Y99.671 E.00654
M204 S250
G1 X83.904 Y99.636 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X83.908 Y99.575 E.0012
G1 X83.964 Y99.313 E.00526
G1 X84.05 Y99.06 E.00526
G1 X84.231 Y98.711 E.00773
G1 X84.474 Y98.397 E.0078
G1 X84.768 Y98.132 E.00779
G1 X85.103 Y97.925 E.00774
G1 X85.349 Y97.82 E.00526
G1 X85.605 Y97.745 E.00526
G1 X85.995 Y97.692 E.00774
G1 X86.388 Y97.71 E.00773
G1 X86.651 Y97.762 E.00526
G1 X86.905 Y97.844 E.00526
G1 X87.257 Y98.02 E.00773
G1 X87.574 Y98.258 E.00779
G1 X87.841 Y98.546 E.00774
G1 X87.992 Y98.767 E.00526
G1 X88.114 Y99.002 E.00521
G1 X88.206 Y99.249 E.00519
G1 X88.263 Y99.475 E.00457
G1 X88.305 Y99.9 E.00841
G1 X88.27 Y100.296 E.00782
G1 X88.165 Y100.675 E.00773
G1 X88.056 Y100.919 E.00525
G1 X87.938 Y101.119 E.00457
G1 X87.67 Y101.452 E.00841
G1 X87.369 Y101.707 E.00776
G1 X87.142 Y101.847 E.00526
G1 X86.899 Y101.96 E.00526
G1 X86.522 Y102.07 E.00773
G1 X86.131 Y102.111 E.00774
G1 X85.864 Y102.099 E.00525
G1 X85.634 Y102.062 E.00458
G1 X85.227 Y101.934 E.00841
G1 X84.876 Y101.746 E.00782
G1 X84.567 Y101.499 E.00779
G1 X84.306 Y101.2 E.0078
G1 X84.104 Y100.863 E.00774
G1 X84.003 Y100.615 E.00526
G1 X83.931 Y100.357 E.00526
G1 X83.885 Y99.967 E.00773
G1 X83.901 Y99.696 E.00535
; WIPE_START
M204 S6000
G1 X83.908 Y99.575 E-.02303
G1 X83.964 Y99.313 E-.05083
G1 X84.05 Y99.06 E-.05084
G1 X84.231 Y98.711 E-.07469
G1 X84.474 Y98.397 E-.07531
G1 X84.768 Y98.132 E-.07529
G1 X84.903 Y98.049 E-.03002
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X84.855 Y96.12 Z2.16 F18000
G1 Z1.76
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X92.678 Y96.12 E.16557
G1 X92.718 Y95.441 E.0144
G1 X92.742 Y95.331 E.00238
G1 X92.784 Y95.227 E.00238
G1 X92.851 Y95.128 E.00253
G1 X92.932 Y95.05 E.00238
G1 X93.076 Y94.964 E.00356
G1 X93.236 Y94.926 E.00347
G1 X93.384 Y94.932 E.00314
G1 X93.525 Y94.971 E.0031
G1 X93.616 Y95.019 E.00218
G1 X93.95 Y95.264 E.00878
G1 X95.879 Y94.633 E.04295
G1 X98.51 Y90.875 E.09709
G1 X98.806 Y91.083 E.00765
G1 X96.105 Y94.94 E.09967
G1 X93.244 Y96.216 E.0663
G1 X93.021 Y96.37 E.00573
G1 X92.803 Y96.453 E.00495
G1 X92.559 Y96.482 E.0052
G1 X87.591 Y96.482 E.10514
G1 X88.777 Y97.845 E.03824
G1 X89.095 Y98.346 E.01257
G1 X89.238 Y98.663 E.00735
G1 X89.322 Y98.896 E.00525
G1 X89.421 Y99.3 E.00879
G1 X89.467 Y99.68 E.00811
G1 X89.453 Y100.283 E.01276
G1 X89.394 Y100.625 E.00734
G1 X89.262 Y101.082 E.01007
G1 X89.008 Y101.613 E.01246
G1 X88.785 Y101.947 E.0085
G1 X88.517 Y102.258 E.00869
G1 X88.11 Y102.613 E.01143
G1 X87.906 Y102.754 E.00525
G1 X87.543 Y102.955 E.00879
G1 X87.037 Y103.146 E.01143
G1 X86.797 Y103.207 E.00525
G1 X86.386 Y103.269 E.00879
G1 X85.794 Y103.267 E.01254
G1 X85.201 Y103.161 E.01273
G1 X84.638 Y102.951 E.01273
G1 X84.287 Y102.757 E.00849
G1 X83.961 Y102.522 E.00849
G1 X83.666 Y102.251 E.0085
G1 X83.404 Y101.947 E.00849
G1 X83.181 Y101.613 E.00849
G1 X82.998 Y101.256 E.00849
G1 X82.86 Y100.88 E.00849
G1 X82.766 Y100.489 E.0085
G1 X82.719 Y100.081 E.00869
G1 X82.734 Y99.551 E.01122
G1 X82.813 Y99.092 E.00988
G1 X82.931 Y98.712 E.00842
G1 X83.094 Y98.345 E.00849
G1 X83.411 Y97.845 E.01254
G1 X84.597 Y96.482 E.03824
G1 X79.631 Y96.482 E.10513
G1 X79.383 Y96.453 E.00527
G1 X79.238 Y96.405 E.00324
G1 X78.986 Y96.233 E.00645
G1 X78.834 Y96.043 E.00514
G1 X78.743 Y95.814 E.00523
G1 X78.714 Y95.565 E.00531
G1 X78.714 Y77.626 E.37969
G1 X78.753 Y77.345 E.006
G1 X78.86 Y77.118 E.00532
G1 X78.957 Y76.997 E.00328
G1 X79.061 Y76.902 E.00299
G1 X79.294 Y76.775 E.00561
G1 X79.543 Y76.723 E.00539
G1 X92.581 Y76.721 E.27595
G1 X92.804 Y76.748 E.00475
G1 X92.942 Y76.794 E.00309
G1 X93.119 Y76.889 E.00424
G1 X93.07 Y77.082 E.0042
G1 X80.049 Y77.082 E.2756
G1 X79.791 Y77.119 E.00552
G1 X79.486 Y77.273 E.00724
G1 X79.258 Y77.505 E.00687
G1 X79.113 Y77.8 E.00697
G1 X79.075 Y78.056 E.00548
G1 X79.075 Y95.173 E.3623
G1 X79.161 Y95.536 E.0079
G1 X79.335 Y95.788 E.00648
G1 X79.536 Y95.96 E.0056
G1 X79.8 Y96.084 E.00616
G1 X80.049 Y96.12 E.00533
G1 X84.795 Y96.12 E.10045
; WIPE_START
M204 S6000
G1 X86.795 Y96.12 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X83.699 Y96.891 Z2.16 F18000
G1 Z1.76
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X79.607 Y96.891 E.08049
G1 X79.294 Y96.854 E.00619
G1 X79.081 Y96.784 E.00442
G1 X78.955 Y96.72 E.00277
G1 X78.708 Y96.536 E.00606
G1 X78.558 Y96.369 E.00442
G1 X78.478 Y96.247 E.00287
G1 X78.403 Y96.093 E.00336
G1 X78.341 Y95.902 E.00396
G1 X78.304 Y95.589 E.0062
G1 X78.304 Y77.609 E.35363
G1 X78.322 Y77.397 E.0042
G1 X78.359 Y77.23 E.00336
G1 X78.409 Y77.093 E.00287
G1 X78.517 Y76.893 E.00448
G1 X78.657 Y76.716 E.00443
G1 X78.809 Y76.579 E.00402
G1 X78.948 Y76.485 E.0033
G1 X79.153 Y76.389 E.00446
G1 X79.374 Y76.33 E.00448
G1 X79.519 Y76.313 E.00289
G1 X92.606 Y76.312 E.2574
G1 X92.894 Y76.347 E.00571
G1 X93.105 Y76.417 E.00437
G1 X93.303 Y76.524 E.00442
G1 X93.479 Y76.663 E.00442
G1 X93.628 Y76.831 E.00442
G1 X93.746 Y77.022 E.00442
G1 X93.829 Y77.231 E.00442
G1 X93.874 Y77.448 E.00436
G1 X93.884 Y88.791 E.2231
G1 X92.704 Y88.791 E.02321
G1 X92.704 Y77.491 E.22226
G1 X80.079 Y77.491 E.24833
G1 X79.916 Y77.515 E.00325
G1 X79.73 Y77.608 E.00409
G1 X79.596 Y77.744 E.00375
G1 X79.508 Y77.923 E.00392
G1 X79.484 Y78.086 E.00323
G1 X79.484 Y95.125 E.33516
G1 X79.542 Y95.367 E.00489
G1 X79.642 Y95.512 E.00347
G1 X79.76 Y95.613 E.00306
G1 X79.919 Y95.687 E.00345
G1 X80.079 Y95.711 E.00319
G1 X92.292 Y95.711 E.24022
G1 X92.312 Y95.386 E.00639
G1 X92.349 Y95.211 E.00353
G1 X92.416 Y95.044 E.00353
G1 X92.545 Y94.855 E.0045
G1 X92.674 Y94.73 E.00353
G1 X92.926 Y94.582 E.00575
G1 X93.209 Y94.516 E.00572
G1 X93.448 Y94.524 E.00469
G1 X93.677 Y94.589 E.00468
G1 X93.833 Y94.671 E.00347
G1 X94.023 Y94.81 E.00462
G1 X95.622 Y94.286 E.0331
G1 X98.41 Y90.305 E.09559
G1 X99.376 Y90.982 E.02321
G1 X96.375 Y95.268 E.10291
G1 X93.445 Y96.574 E.0631
G1 X93.229 Y96.723 E.00516
G1 X93.102 Y96.786 E.00279
G1 X92.891 Y96.855 E.00437
M73 P50 R12
G1 X92.582 Y96.891 E.00611
G1 X88.49 Y96.891 E.08049
G1 X89.098 Y97.59 E.01822
G1 X89.227 Y97.767 E.00431
G1 X89.459 Y98.157 E.00892
G1 X89.618 Y98.51 E.00762
G1 X89.714 Y98.778 E.00561
G1 X89.823 Y99.22 E.00894
G1 X89.877 Y99.661 E.00873
G1 X89.878 Y100.117 E.00897
G1 X89.859 Y100.335 E.00432
G1 X89.794 Y100.717 E.00761
G1 X89.649 Y101.216 E.01022
G1 X89.568 Y101.417 E.00428
G1 X89.362 Y101.821 E.00891
G1 X89.111 Y102.195 E.00885
G1 X88.816 Y102.538 E.00891
G1 X88.357 Y102.939 E.01198
G1 X88.123 Y103.102 E.00562
G1 X87.725 Y103.322 E.00894
G1 X87.155 Y103.538 E.01199
G1 X86.878 Y103.609 E.00562
G1 X86.429 Y103.676 E.00894
G1 X86.21 Y103.689 E.00431
G1 X85.757 Y103.676 E.00891
G1 X85.309 Y103.608 E.00891
G1 X85.093 Y103.556 E.00437
G1 X84.881 Y103.491 E.00436
G1 X84.462 Y103.321 E.00891
G1 X84.068 Y103.103 E.00885
G1 X83.703 Y102.84 E.00885
G1 X83.371 Y102.536 E.00885
G1 X83.078 Y102.195 E.00885
G1 X82.827 Y101.821 E.00885
G1 X82.623 Y101.42 E.00885
G1 X82.467 Y100.998 E.00885
G1 X82.363 Y100.56 E.00885
G1 X82.31 Y100.11 E.00891
G1 X82.327 Y99.505 E.01191
G1 X82.414 Y98.996 E.01016
G1 X82.547 Y98.567 E.00883
G1 X82.73 Y98.156 E.00885
G1 X82.962 Y97.767 E.00891
G1 X83.091 Y97.59 E.00431
G1 X83.66 Y96.936 E.01704
; WIPE_START
M204 S6000
G1 X81.66 Y96.914 E-.38
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




G1 X79.578 Y96.239
G1 Z1.76
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.104611
G1 F1500
M204 S6000
G1 X79.388 Y96.178 E.00079
; LINE_WIDTH: 0.153384
G1 X79.134 Y95.981 E.00205
G1 X78.944 Y95.687 E.00223
; WIPE_START
G1 X79.134 Y95.981 E-.19815
G1 X79.388 Y96.178 E-.18185
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X84.638 Y97.167 Z2.16 F18000
G1 Z1.76
G1 E.4 F1800
; LINE_WIDTH: 0.475176
G1 F1500
M204 S6000
G1 X84.464 Y97.315 E.00514
; LINE_WIDTH: 0.438747
G1 X84.263 Y97.487 E.00545
; LINE_WIDTH: 0.401694
G1 X84.085 Y97.669 E.00477
; LINE_WIDTH: 0.360386
G1 X83.886 Y97.872 E.00474
G1 X83.56 Y98.299 E.00897
G1 X83.321 Y98.761 E.00868
G1 X83.184 Y99.18 E.00736
G1 X83.114 Y99.595 E.00702
G1 X83.099 Y100.005 E.00685
G1 X83.161 Y100.522 E.00868
G1 X83.225 Y100.769 E.00426
G1 X83.348 Y101.103 E.00594
G1 X83.512 Y101.418 E.00594
G1 X83.707 Y101.716 E.00594
G1 X84.033 Y102.078 E.00813
G1 X84.454 Y102.412 E.00898
G1 X84.907 Y102.654 E.00856
G1 X85.441 Y102.828 E.00939
G1 X85.825 Y102.888 E.00649
G1 X86.142 Y102.895 E.00529
G1 X86.66 Y102.846 E.00868
G1 X86.925 Y102.778 E.00457
G1 X87.377 Y102.61 E.00806
G1 X87.823 Y102.352 E.0086
G1 X88.244 Y101.995 E.00922
G1 X88.478 Y101.714 E.00611
G1 X88.678 Y101.421 E.00591
G1 X88.904 Y100.953 E.00869
G1 X89.042 Y100.451 E.00869
G1 X89.09 Y99.911 E.00905
G1 X89.068 Y99.542 E.00618
G1 X88.962 Y99.024 E.00883
G1 X88.826 Y98.674 E.00626
G1 X88.66 Y98.357 E.00598
G1 X88.466 Y98.064 E.00586
G1 X88.097 Y97.654 E.00922
; LINE_WIDTH: 0.395483
G1 X87.972 Y97.538 E.00314
; LINE_WIDTH: 0.431434
G1 X87.847 Y97.422 E.00345
; LINE_WIDTH: 0.467641
G1 X87.721 Y97.304 E.00381
; LINE_WIDTH: 0.468561
G1 X87.559 Y97.34 E.00365
; LINE_WIDTH: 0.43394
G1 X87.398 Y97.375 E.00337
; WIPE_START
G1 X87.559 Y97.34 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X93.994 Y95.559 Z2.16 F18000
G1 Z1.76
G1 E.4 F1800
; LINE_WIDTH: 0.163601
G1 F1500
M204 S6000
G1 X94.335 Y95.428 E.00251
; LINE_WIDTH: 0.13006
G1 X94.676 Y95.297 E.0019
; LINE_WIDTH: 0.0965185
G1 X95.017 Y95.165 E.00129
; WIPE_START
G1 X94.676 Y95.297 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X89.606 Y89.591 Z2.16 F18000
G1 X78.95 Y77.599 Z2.16
G1 Z1.76
G1 E.4 F1800
; LINE_WIDTH: 0.0909211
G1 F1500
M204 S6000
G1 X78.99 Y77.484 E.0004
; LINE_WIDTH: 0.119477
G1 X79.029 Y77.369 E.00057
; LINE_WIDTH: 0.154302
G1 X79.166 Y77.192 E.00144
G1 X79.288 Y77.082 E.00105
; LINE_WIDTH: 0.128002
G1 X79.491 Y76.991 E.00113
; LINE_WIDTH: 0.0894151
G1 X79.599 Y76.955 E.00036
; WIPE_START
G1 X79.491 Y76.991 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X86.308 Y80.423 Z2.16 F18000
G1 X100.371 Y87.504 Z2.16
G1 Z1.76
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X100.647 Y87.111 E.00944
G1 X100.846 Y87.25 E.00479
G1 X101.613 Y87.787 E.01842
G1 X101.338 Y88.181 E.00944
G1 X100.42 Y87.538 E.02203
M204 S10000
G1 X100.676 Y87.424 F18000
; FEATURE: Gap infill
; LINE_WIDTH: 0.0965102
G1 F1500
M204 S6000
G1 X101.308 Y87.867 E.00272
; CHANGE_LAYER
; Z_HEIGHT: 1.88
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F1500
G1 X100.676 Y87.424 E-.38
; WIPE_END
G1 E-.02 F1800
; layer num/total_layer_count: 15/57
; update layer progress
M73 L15
M991 S0 P14 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z2.16 I-1.089 J-.543 P1  F18000
G1 X100.284 Y88.212 Z2.16
G1 Z1.88
G1 E.4 F1800
; FEATURE: Support interface
; LINE_WIDTH: 0.42
G1 F1500
M204 S6000
G1 X99.347 Y88.212 E.01844
G1 X98.721 Y89.106 E.02147
G1 X101.219 Y89.106 E.04913
G1 X100.592 Y90 E.02147
G1 X99.071 Y90 E.02992
; WIPE_START
G1 X100.592 Y90 E-.28899
G1 X100.867 Y89.608 E-.09101
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X96.025 Y83.707 Z2.28 F18000
G1 X93.469 Y80.592 Z2.28
G1 Z1.88
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X93.476 Y85.92 E.11277
G1 X93.912 Y85.92 E.00923
G1 F1920
G1 X93.932 Y85.92 E.00043
G1 F2357.113
G1 X93.932 Y87.282 E.02882
G1 F1920
G1 X93.912 Y87.282 E.00043
G1 F1500
G1 X93.475 Y87.282 E.00924
G1 X93.475 Y88.382 E.02328
G1 X93.114 Y88.382 E.00765
G1 X93.114 Y77.128 E.23818
G1 X93.299 Y77.076 E.00407
G1 X93.379 Y77.207 E.00325
G1 X93.436 Y77.349 E.00324
G1 X93.465 Y77.49 E.00306
G1 X93.469 Y80.532 E.06438
; WIPE_START
M204 S6000
G1 X93.472 Y82.532 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X93.588 Y90.164 Z2.28 F18000
G1 X93.67 Y95.562 Z2.28
G1 Z1.88
G1 E.4 F1800
G1 F1500
M204 S500
G1 X93.122 Y95.806 E.01271
G1 X93.151 Y95.444 E.00768
G1 X93.204 Y95.377 E.00181
G1 X93.254 Y95.351 E.00119
G1 X93.312 Y95.353 E.00123
G1 X93.618 Y95.532 E.00749
; WIPE_START
M204 S6000
G1 X93.122 Y95.806 E-.14524
G1 X93.151 Y95.444 E-.09293
G1 X93.204 Y95.377 E-.02195
G1 X93.254 Y95.351 E-.01439
G1 X93.312 Y95.353 E-.01487
G1 X93.618 Y95.532 E-.09062
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X86.109 Y96.898 Z2.28 F18000
G1 X84.856 Y97.126 Z2.28
G1 Z1.88
G1 E.4 F1800
G1 F1500
M204 S500
G1 X84.741 Y96.963 E.00423
G1 X85.105 Y96.544 E.01174
G1 X87.084 Y96.544 E.04188
G1 X87.43 Y96.942 E.01116
G1 X87.323 Y97.104 E.0041
G1 X86.861 Y96.953 E.01029
G1 X86.488 Y96.88 E.00804
G1 X85.973 Y96.857 E.0109
G1 X85.596 Y96.897 E.00804
G1 X85.225 Y96.981 E.00804
G1 X84.912 Y97.104 E.00712
; WIPE_START
M204 S6000
G1 X84.741 Y96.963 E-.04213
G1 X85.105 Y96.544 E-.10541
G1 X86.329 Y96.544 E-.23246
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X83.495 Y99.623 Z2.28 F18000
G1 Z1.88
G1 E.4 F1800
G1 F1500
M204 S500
G1 X83.501 Y99.519 E.00219
G1 X83.568 Y99.205 E.00679
G1 X83.658 Y98.937 E.00599
G1 X83.883 Y98.492 E.01055
G1 X84.172 Y98.118 E.01002
G1 X84.522 Y97.803 E.00995
G1 X84.922 Y97.556 E.00995
G1 X85.351 Y97.388 E.00975
G1 X85.665 Y97.316 E.00683
G1 X85.986 Y97.282 E.00683
G1 X86.437 Y97.302 E.00955
G1 X86.754 Y97.365 E.00683
G1 X87.061 Y97.465 E.00683
G1 X87.473 Y97.671 E.00975
G1 X87.849 Y97.953 E.00994
G1 X88.161 Y98.289 E.00972
G1 X88.321 Y98.522 E.00598
G1 X88.491 Y98.84 E.00763
G1 X88.638 Y99.27 E.00963
G1 X88.696 Y99.588 E.00683
G1 X88.715 Y99.91 E.00683
G1 X88.674 Y100.369 E.00975
G1 X88.551 Y100.813 E.00975
G1 X88.42 Y101.108 E.00683
G1 X88.255 Y101.385 E.00683
G1 X87.962 Y101.741 E.00975
G1 X87.611 Y102.039 E.00975
G1 X87.336 Y102.208 E.00683
G1 X87.043 Y102.344 E.00683
G1 X86.601 Y102.473 E.00975
G1 X86.143 Y102.521 E.00975
G1 X85.822 Y102.507 E.00679
G1 X85.543 Y102.462 E.00599
G1 X85.067 Y102.313 E.01055
G1 X84.65 Y102.089 E.01002
G1 X84.283 Y101.796 E.00995
G1 X83.98 Y101.449 E.00975
G1 X83.806 Y101.177 E.00683
G1 X83.666 Y100.886 E.00683
G1 X83.53 Y100.446 E.00975
G1 X83.474 Y99.979 E.00995
G1 X83.492 Y99.683 E.00629
M204 S250
G1 X83.904 Y99.647 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X83.908 Y99.574 E.00144
G1 X83.964 Y99.313 E.00525
G1 X84.037 Y99.095 E.00453
G1 X84.231 Y98.712 E.00845
G1 X84.474 Y98.397 E.00782
G1 X84.768 Y98.132 E.0078
G1 X85.105 Y97.924 E.0078
G1 X85.471 Y97.78 E.00773
G1 X85.732 Y97.72 E.00526
G1 X85.998 Y97.692 E.00526
G1 X86.388 Y97.71 E.00767
G1 X86.651 Y97.762 E.00526
G1 X86.905 Y97.844 E.00526
G1 X87.257 Y98.02 E.00774
G1 X87.574 Y98.258 E.00779
G1 X87.841 Y98.546 E.00772
G1 X87.971 Y98.735 E.00452
G1 X88.115 Y99.004 E.00599
G1 X88.241 Y99.374 E.00769
G1 X88.289 Y99.637 E.00526
G1 X88.305 Y99.904 E.00526
G1 X88.27 Y100.296 E.00773
G1 X88.165 Y100.675 E.00773
G1 X88.056 Y100.919 E.00526
G1 X87.919 Y101.149 E.00526
G1 X87.669 Y101.452 E.00773
G1 X87.369 Y101.707 E.00773
G1 X87.142 Y101.847 E.00526
G1 X86.899 Y101.96 E.00526
G1 X86.522 Y102.07 E.00773
G1 X86.131 Y102.111 E.00774
G1 X85.864 Y102.099 E.00525
G1 X85.637 Y102.063 E.00453
G1 X85.227 Y101.934 E.00845
G1 X84.876 Y101.746 E.00782
G1 X84.567 Y101.499 E.0078
G1 X84.308 Y101.203 E.00773
G1 X84.164 Y100.977 E.00527
G1 X84.048 Y100.736 E.00526
G1 X83.932 Y100.361 E.00773
G1 X83.885 Y99.967 E.0078
G1 X83.9 Y99.707 E.00512
; WIPE_START
M204 S6000
G1 X83.908 Y99.574 E-.02527
G1 X83.964 Y99.313 E-.05071
G1 X84.037 Y99.095 E-.04372
G1 X84.231 Y98.712 E-.08167
G1 X84.474 Y98.397 E-.07552
G1 X84.768 Y98.132 E-.07533
G1 X84.893 Y98.055 E-.02779
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X84.855 Y96.12 Z2.28 F18000
G1 Z1.88
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X92.678 Y96.12 E.16557
G1 X92.718 Y95.441 E.01439
G1 X92.743 Y95.326 E.0025
G1 X92.862 Y95.117 E.00509
G1 X92.98 Y95.015 E.0033
G1 X93.085 Y94.961 E.0025
G1 X93.236 Y94.926 E.00327
G1 X93.381 Y94.931 E.00307
G1 X93.521 Y94.973 E.0031
G1 X93.98 Y95.254 E.0114
G1 X95.879 Y94.633 E.04229
G1 X98.51 Y90.875 E.09709
G1 X98.806 Y91.083 E.00765
G1 X96.105 Y94.94 E.09967
G1 X93.236 Y96.22 E.06649
G1 X93.08 Y96.334 E.0041
G1 X92.938 Y96.409 E.00339
G1 X92.803 Y96.453 E.00301
G1 X92.559 Y96.482 E.0052
G1 X87.591 Y96.482 E.10514
G1 X88.777 Y97.845 E.03824
G1 X88.884 Y97.992 E.00386
G1 X89.099 Y98.353 E.00888
G1 X89.323 Y98.901 E.01254
G1 X89.45 Y99.489 E.01273
G1 X89.469 Y100.1 E.01292
G1 X89.395 Y100.62 E.01113
G1 X89.264 Y101.075 E.01001
G1 X89.011 Y101.609 E.01251
G1 X88.785 Y101.947 E.0086
G1 X88.385 Y102.386 E.01257
G1 X88.113 Y102.61 E.00745
G1 X87.737 Y102.855 E.0095
G1 X87.367 Y103.032 E.00869
G1 X86.978 Y103.164 E.00869
G1 X86.386 Y103.269 E.01273
G1 X85.794 Y103.267 E.01254
G1 X85.21 Y103.163 E.01254
G1 X84.825 Y103.033 E.00861
G1 X84.402 Y102.825 E.00998
G1 X83.968 Y102.529 E.01112
G1 X83.666 Y102.251 E.00869
G1 X83.404 Y101.947 E.00849
G1 X83.181 Y101.613 E.0085
G1 X82.998 Y101.256 E.00849
G1 X82.86 Y100.879 E.0085
G1 X82.738 Y100.298 E.01257
G1 X82.717 Y99.957 E.00725
G1 X82.741 Y99.486 E.00997
G1 X82.812 Y99.095 E.00842
G1 X83.003 Y98.533 E.01257
G1 X83.159 Y98.228 E.00724
G1 X83.42 Y97.835 E.00998
G1 X84.597 Y96.482 E.03797
G1 X79.631 Y96.482 E.10513
G1 X79.392 Y96.454 E.00508
G1 X79.192 Y96.381 E.0045
G1 X79.062 Y96.301 E.00324
G1 X78.884 Y96.119 E.00539
G1 X78.832 Y96.041 E.00198
G1 X78.743 Y95.812 E.0052
G1 X78.714 Y95.565 E.00527
G1 X78.714 Y77.628 E.37965
G1 X78.752 Y77.348 E.00597
G1 X78.86 Y77.118 E.00539
G1 X78.957 Y76.997 E.00329
G1 X79.06 Y76.903 E.00295
G1 X79.296 Y76.775 E.00568
G1 X79.547 Y76.723 E.00542
G1 X92.583 Y76.721 E.27591
G1 X92.803 Y76.748 E.00471
G1 X92.942 Y76.794 E.0031
G1 X93.119 Y76.889 E.00424
G1 X93.07 Y77.082 E.0042
G1 X80.04 Y77.082 E.27579
G1 X79.752 Y77.133 E.00621
G1 X79.479 Y77.28 E.00656
G1 X79.258 Y77.505 E.00669
G1 X79.113 Y77.8 E.00695
G1 X79.075 Y78.056 E.00547
G1 X79.075 Y95.176 E.36237
G1 X79.167 Y95.55 E.00814
G1 X79.345 Y95.799 E.00647
G1 X79.539 Y95.962 E.00537
G1 X79.8 Y96.084 E.0061
G1 X80.049 Y96.12 E.00533
G1 X84.795 Y96.12 E.10045
; WIPE_START
M204 S6000
G1 X86.795 Y96.12 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X83.699 Y96.891 Z2.28 F18000
G1 Z1.88
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
M73 P51 R12
G1 X79.607 Y96.891 E.08049
G1 X79.297 Y96.855 E.00613
G1 X79.013 Y96.751 E.00594
G1 X78.822 Y96.633 E.00442
G1 X78.712 Y96.541 E.00283
G1 X78.558 Y96.368 E.00454
G1 X78.477 Y96.246 E.00289
G1 X78.412 Y96.114 E.00289
G1 X78.341 Y95.901 E.00442
G1 X78.304 Y95.589 E.00619
G1 X78.304 Y77.61 E.35362
G1 X78.325 Y77.374 E.00466
G1 X78.359 Y77.231 E.00289
G1 X78.409 Y77.093 E.00289
G1 X78.517 Y76.893 E.00448
G1 X78.657 Y76.716 E.00444
G1 X78.808 Y76.58 E.00399
G1 X78.948 Y76.485 E.00333
G1 X79.154 Y76.389 E.00447
G1 X79.349 Y76.335 E.00398
G1 X79.521 Y76.313 E.00339
G1 X92.608 Y76.312 E.25741
G1 X92.894 Y76.347 E.00567
G1 X93.105 Y76.417 E.00438
G1 X93.303 Y76.524 E.00442
G1 X93.479 Y76.663 E.00442
G1 X93.628 Y76.831 E.00442
G1 X93.746 Y77.022 E.00442
G1 X93.829 Y77.231 E.00442
G1 X93.874 Y77.448 E.00436
G1 X93.884 Y85.111 E.15071
G1 X93.885 Y85.511 E.00787
G1 F746.167
G1 X93.925 Y85.511 E.0008
G1 F600
G1 X94.294 Y85.511 E.00726
; FEATURE: Overhang wall
; LINE_WIDTH: 0.45

G1 X94.341 Y85.511 E.001
G1 X94.341 Y87.691 E.04614
G1 X94.294 Y87.691 E.001
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 X93.925 Y87.691 E.00726
G1 F747.19
G1 X93.884 Y87.691 E.00081
G1 F1500
G1 X93.884 Y88.091 E.00787
G1 X93.884 Y88.791 E.01377
G1 X92.704 Y88.791 E.02321
G1 X92.704 Y77.491 E.22226
G1 X80.076 Y77.491 E.24839
G1 X79.888 Y77.524 E.00376
G1 X79.728 Y77.61 E.00357
G1 X79.596 Y77.745 E.0037
G1 X79.508 Y77.923 E.0039
G1 X79.484 Y78.086 E.00323
G1 X79.484 Y95.126 E.33518
G1 X79.546 Y95.376 E.00505
G1 X79.648 Y95.519 E.00345
G1 X79.761 Y95.614 E.0029
G1 X79.919 Y95.687 E.00343
G1 X80.079 Y95.711 E.00319
G1 X92.292 Y95.711 E.24022
G1 X92.312 Y95.386 E.00639
G1 X92.349 Y95.209 E.00357
G1 X92.476 Y94.945 E.00576
G1 X92.676 Y94.729 E.0058
G1 X92.929 Y94.581 E.00577
G1 X93.209 Y94.516 E.00566
G1 X93.447 Y94.524 E.00467
G1 X93.689 Y94.595 E.00496
G1 X94.033 Y94.807 E.00794
G1 X95.622 Y94.286 E.03289
G1 X98.41 Y90.305 E.09559
G1 X99.376 Y90.982 E.02321
G1 X96.375 Y95.268 E.10291
G1 X93.442 Y96.576 E.06316
G1 X93.298 Y96.682 E.00353
G1 X93.099 Y96.787 E.00443
G1 X92.891 Y96.855 E.00431
G1 X92.582 Y96.891 E.00611
G1 X88.49 Y96.891 E.08049
G1 X89.098 Y97.59 E.01822
G1 X89.227 Y97.767 E.00431
G1 X89.46 Y98.159 E.00897
G1 X89.555 Y98.356 E.00431
G1 X89.715 Y98.78 E.00891
G1 X89.823 Y99.22 E.00891
G1 X89.877 Y99.661 E.00873
G1 X89.878 Y100.117 E.00897
G1 X89.795 Y100.712 E.01183
G1 X89.65 Y101.213 E.01026
G1 X89.499 Y101.563 E.0075
G1 X89.363 Y101.82 E.00571
G1 X89.111 Y102.195 E.00889
G1 X88.816 Y102.538 E.00891
G1 X88.361 Y102.937 E.01189
G1 X87.93 Y103.216 E.0101
G1 X87.521 Y103.412 E.00891
G1 X87.092 Y103.557 E.00891
G1 X86.88 Y103.608 E.0043
G1 X86.429 Y103.676 E.00897
G1 X86.21 Y103.689 E.00431
G1 X85.757 Y103.676 E.00891
G1 X85.309 Y103.608 E.00891
G1 X85.096 Y103.557 E.00431
G1 X84.668 Y103.412 E.00889
G1 X84.201 Y103.182 E.01025
G1 X83.879 Y102.976 E.00752
G1 X83.705 Y102.842 E.00431
G1 X83.371 Y102.536 E.00891
G1 X83.078 Y102.195 E.00885
G1 X82.827 Y101.821 E.00885
G1 X82.623 Y101.42 E.00885
G1 X82.467 Y100.998 E.00885
G1 X82.362 Y100.557 E.00891
G1 X82.307 Y99.959 E.01182
G1 X82.333 Y99.438 E.01025
G1 X82.414 Y98.997 E.00883
G1 X82.548 Y98.564 E.00891
G1 X82.631 Y98.361 E.00431
G1 X82.806 Y98.021 E.00752
G1 X83.094 Y97.587 E.01025
G1 X83.659 Y96.936 E.01696
; WIPE_START
M204 S6000
G1 X81.66 Y96.914 E-.38
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




G1 X79.578 Y96.239
G1 Z1.88
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.102704
G1 F1500
M204 S6000
G1 X79.394 Y96.178 E.00074
; LINE_WIDTH: 0.155074
G1 X79.145 Y95.994 E.002
G1 X78.947 Y95.698 E.0023
; WIPE_START
G1 X79.145 Y95.994 E-.20355
G1 X79.394 Y96.178 E-.17645
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X84.63 Y97.174 Z2.28 F18000
G1 Z1.88
G1 E.4 F1800
; LINE_WIDTH: 0.473065
G1 F1500
M204 S6000
G1 X84.46 Y97.318 E.00499
; LINE_WIDTH: 0.438156
G1 X84.263 Y97.487 E.00533
; LINE_WIDTH: 0.401776
G1 X84.085 Y97.669 E.00478
; LINE_WIDTH: 0.359725
G1 X83.886 Y97.872 E.00473
G1 X83.558 Y98.305 E.00906
G1 X83.304 Y98.802 E.00929
G1 X83.183 Y99.186 E.0067
G1 X83.119 Y99.53 E.00584
G1 X83.098 Y100.005 E.00792
G1 X83.158 Y100.51 E.00847
G1 X83.319 Y101.036 E.00916
G1 X83.481 Y101.37 E.00618
G1 X83.708 Y101.716 E.0069
G1 X84.033 Y102.078 E.00811
G1 X84.456 Y102.409 E.00895
G1 X84.935 Y102.667 E.00907
G1 X85.312 Y102.792 E.00662
G1 X85.793 Y102.884 E.00816
G1 X86.142 Y102.895 E.00581
G1 X86.349 Y102.886 E.00346
G1 X86.687 Y102.837 E.00569
G1 X87.164 Y102.702 E.00826
G1 X87.524 Y102.537 E.00659
G1 X87.842 Y102.337 E.00626
G1 X88.243 Y101.996 E.00876
G1 X88.479 Y101.715 E.00613
G1 X88.681 Y101.416 E.006
G1 X88.907 Y100.944 E.00873
G1 X89.042 Y100.451 E.00852
G1 X89.089 Y99.928 E.00875
G1 X89.073 Y99.541 E.00645
G1 X88.998 Y99.165 E.00639
G1 X88.829 Y98.679 E.00856
G1 X88.646 Y98.335 E.0065
G1 X88.464 Y98.061 E.00547
G1 X88.097 Y97.654 E.00915
; LINE_WIDTH: 0.395481
G1 X87.972 Y97.538 E.00314
; LINE_WIDTH: 0.431411
G1 X87.847 Y97.422 E.00345
; LINE_WIDTH: 0.467604
G1 X87.721 Y97.304 E.00381
; LINE_WIDTH: 0.468546
G1 X87.559 Y97.34 E.00365
; LINE_WIDTH: 0.433958
G1 X87.398 Y97.375 E.00337
; WIPE_START
G1 X87.559 Y97.34 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X94.042 Y95.541 Z2.28 F18000
G1 Z1.88
G1 E.4 F1800
; LINE_WIDTH: 0.151129
G1 F1500
M204 S6000
G1 X94.529 Y95.353 E.00327
; LINE_WIDTH: 0.103542
G1 X95.017 Y95.165 E.00203
; WIPE_START
G1 X94.529 Y95.353 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X93.609 Y87.776 Z2.28 F18000
G1 X93.523 Y87.07 Z2.28
G1 Z1.88
G1 E.4 F1800
; LINE_WIDTH: 0.420042
G1 F1500
M204 S6000
G1 X93.523 Y86.132 E.01844
; WIPE_START
G1 X93.523 Y87.07 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X87.346 Y82.586 Z2.28 F18000
G1 X79.591 Y76.955 Z2.28
G1 Z1.88
G1 E.4 F1800
; LINE_WIDTH: 0.0898075
G1 F1500
M204 S6000
G1 X79.488 Y76.991 E.00035
; LINE_WIDTH: 0.129885
G1 X79.288 Y77.081 E.00114
; LINE_WIDTH: 0.154182
G1 X79.167 Y77.191 E.00105
G1 X79.027 Y77.371 E.00146
; LINE_WIDTH: 0.124044
G1 X78.984 Y77.482 E.00058
; LINE_WIDTH: 0.0969446
G1 X78.951 Y77.597 E.00043
; WIPE_START
G1 X78.984 Y77.482 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X85.895 Y80.72 Z2.28 F18000
G1 X100.371 Y87.504 Z2.28
G1 Z1.88
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X100.647 Y87.111 E.00944
G1 X100.872 Y87.268 E.00542
G1 X101.613 Y87.787 E.01779
G1 X101.338 Y88.181 E.00944
G1 X100.42 Y87.538 E.02203
M204 S10000
G1 X100.676 Y87.424 F18000
; FEATURE: Gap infill
; LINE_WIDTH: 0.0964974
G1 F1500
M204 S6000
G1 X101.308 Y87.867 E.00272
; CHANGE_LAYER
; Z_HEIGHT: 2
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F1500
G1 X100.676 Y87.424 E-.38
; WIPE_END
G1 E-.02 F1800
; layer num/total_layer_count: 16/57
; update layer progress
M73 L16
M991 S0 P15 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z2.28 I.272 J-1.186 P1  F18000
G1 X94.104 Y85.92 Z2.28
G1 Z2
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X94.104 Y87.282 E.02882
G1 X93.475 Y87.282 E.0133
G1 X93.475 Y88.382 E.02328
G1 X93.114 Y88.382 E.00765
G1 X93.114 Y77.128 E.23818
G1 X93.299 Y77.076 E.00407
G1 X93.379 Y77.207 E.00325
G1 X93.436 Y77.349 E.00324
G1 X93.465 Y77.49 E.00306
G1 X93.476 Y85.92 E.17842
G1 X94.044 Y85.92 E.01201
; WIPE_START
M204 S6000
G1 X94.104 Y87.282 E-.25894
G1 X93.475 Y87.282 E-.11939
G1 X93.475 Y87.29 E-.00167
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X93.642 Y94.921 Z2.4 F18000
G1 X93.656 Y95.568 Z2.4
G1 Z2
G1 E.4 F1800
G1 F1500
M204 S500
G1 X93.121 Y95.806 E.01239
G1 X93.151 Y95.444 E.00769
G1 X93.246 Y95.351 E.00281
G1 X93.317 Y95.354 E.00152
G1 X93.372 Y95.369 E.00119
G1 X93.607 Y95.533 E.00608
; WIPE_START
M204 S6000
G1 X93.121 Y95.806 E-.14416
G1 X93.151 Y95.444 E-.09399
G1 X93.246 Y95.351 E-.03436
G1 X93.317 Y95.354 E-.01858
G1 X93.372 Y95.369 E-.01459
G1 X93.607 Y95.533 E-.07431
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X86.096 Y96.888 Z2.4 F18000
G1 X84.906 Y97.103 Z2.4
G1 Z2
G1 E.4 F1800
G1 F1500
M204 S500
G1 X84.787 Y96.937 E.00432
G1 X85.139 Y96.544 E.01116
G1 X87.084 Y96.544 E.04116
G1 X87.43 Y96.942 E.01116
G1 X87.323 Y97.104 E.0041
G1 X86.861 Y96.954 E.01029
G1 X86.488 Y96.88 E.00805
G1 X85.958 Y96.856 E.01123
G1 X85.432 Y96.928 E.01123
G1 X85.067 Y97.034 E.00804
G1 X84.961 Y97.079 E.00245
; WIPE_START
M204 S6000
G1 X84.787 Y96.937 E-.04276
G1 X85.139 Y96.544 E-.1002
G1 X86.386 Y96.544 E-.23703
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X83.495 Y99.633 Z2.4 F18000
G1 Z2
G1 E.4 F1800
G1 F1500
M204 S500
G1 X83.502 Y99.51 E.00262
G1 X83.611 Y99.063 E.00975
G1 X83.734 Y98.764 E.00683
G1 X83.891 Y98.482 E.00683
G1 X84.172 Y98.118 E.00975
G1 X84.522 Y97.803 E.00995
M73 P52 R12
G1 X84.914 Y97.561 E.00975
G1 X85.211 Y97.434 E.00683
G1 X85.52 Y97.344 E.00683
G1 X85.977 Y97.282 E.00975
G1 X86.437 Y97.302 E.00975
G1 X86.754 Y97.365 E.00683
G1 X87.061 Y97.465 E.00683
G1 X87.473 Y97.671 E.00975
G1 X87.849 Y97.953 E.00994
G1 X88.168 Y98.297 E.00995
G1 X88.416 Y98.685 E.00975
G1 X88.548 Y98.98 E.00683
G1 X88.643 Y99.289 E.00683
G1 X88.71 Y99.735 E.00955
G1 X88.71 Y100.058 E.00683
G1 X88.672 Y100.378 E.00683
G1 X88.549 Y100.822 E.00975
G1 X88.345 Y101.246 E.00995
G1 X88.074 Y101.618 E.00975
G1 X87.848 Y101.848 E.00683
G1 X87.595 Y102.049 E.00683
G1 X87.197 Y102.28 E.00975
G1 X86.754 Y102.438 E.00995
G1 X86.29 Y102.515 E.00995
G1 X85.83 Y102.508 E.00975
G1 X85.513 Y102.456 E.0068
G1 X85.243 Y102.379 E.00594
G1 X84.795 Y102.177 E.0104
G1 X84.523 Y101.998 E.00691
G1 X84.276 Y101.789 E.00683
G1 X83.973 Y101.442 E.00975
G1 X83.737 Y101.046 E.00975
G1 X83.615 Y100.748 E.00683
G1 X83.529 Y100.437 E.00683
G1 X83.474 Y99.979 E.00975
G1 X83.491 Y99.693 E.00606
M204 S250
G1 X83.903 Y99.658 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X83.908 Y99.571 E.00171
G1 X84.001 Y99.19 E.00773
G1 X84.103 Y98.942 E.00526
G1 X84.233 Y98.708 E.00526
G1 X84.474 Y98.397 E.00773
G1 X84.768 Y98.132 E.0078
G1 X85.103 Y97.925 E.00773
G1 X85.349 Y97.82 E.00526
G1 X85.606 Y97.745 E.00526
G1 X85.995 Y97.692 E.00773
G1 X86.388 Y97.71 E.00773
G1 X86.651 Y97.762 E.00526
G1 X86.905 Y97.844 E.00526
G1 X87.257 Y98.02 E.00774
G1 X87.574 Y98.258 E.00779
G1 X87.843 Y98.548 E.0078
G1 X88.055 Y98.88 E.00773
G1 X88.164 Y99.124 E.00526
G1 X88.243 Y99.38 E.00526
G1 X88.301 Y99.765 E.00767
G1 X88.301 Y100.033 E.00527
G1 X88.269 Y100.299 E.00526
G1 X88.164 Y100.678 E.00773
G1 X87.992 Y101.035 E.0078
G1 X87.761 Y101.353 E.00773
G1 X87.573 Y101.544 E.00526
G1 X87.364 Y101.71 E.00526
G1 X87.024 Y101.907 E.00773
G1 X86.651 Y102.041 E.0078
G1 X86.26 Y102.106 E.0078
G1 X85.867 Y102.1 E.00773
G1 X85.603 Y102.056 E.00525
G1 X85.384 Y101.993 E.00448
G1 X84.993 Y101.818 E.00844
G1 X84.769 Y101.669 E.00529
G1 X84.564 Y101.496 E.00526
G1 X84.306 Y101.2 E.00773
G1 X84.104 Y100.863 E.00774
G1 X84.003 Y100.615 E.00526
G1 X83.931 Y100.357 E.00526
G1 X83.885 Y99.967 E.00773
G1 X83.899 Y99.718 E.00491
; WIPE_START
M204 S6000
G1 X83.908 Y99.571 E-.02788
G1 X84.001 Y99.19 E-.07467
G1 X84.103 Y98.942 E-.05086
G1 X84.233 Y98.708 E-.05083
G1 X84.474 Y98.397 E-.07471
G1 X84.768 Y98.132 E-.07533
G1 X84.884 Y98.061 E-.02574
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X84.892 Y96.12 Z2.4 F18000
G1 Z2
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X92.678 Y96.12 E.16479
G1 X92.718 Y95.441 E.01439
G1 X92.743 Y95.326 E.0025
G1 X92.862 Y95.116 E.00512
G1 X92.93 Y95.052 E.00198
G1 X93.076 Y94.964 E.0036
G1 X93.236 Y94.926 E.00347
G1 X93.384 Y94.932 E.00314
G1 X93.53 Y94.973 E.00321
G1 X93.959 Y95.262 E.01094
G1 X95.879 Y94.633 E.04277
G1 X98.51 Y90.875 E.09709
G1 X98.806 Y91.083 E.00765
G1 X96.105 Y94.94 E.09967
G1 X93.244 Y96.216 E.0663
G1 X93.021 Y96.37 E.00573
G1 X92.803 Y96.453 E.00495
G1 X92.559 Y96.482 E.0052
G1 X87.591 Y96.482 E.10514
G1 X88.771 Y97.838 E.03805
G1 X89.095 Y98.344 E.01272
G1 X89.326 Y98.91 E.01293
G1 X89.449 Y99.491 E.01258
G1 X89.469 Y100.095 E.01278
G1 X89.396 Y100.616 E.01113
G1 X89.263 Y101.075 E.01011
G1 X89.011 Y101.609 E.01251
G1 X88.785 Y101.947 E.0086
G1 X88.387 Y102.385 E.01254
G1 X88.061 Y102.65 E.00888
G1 X87.738 Y102.855 E.0081
G1 X87.367 Y103.032 E.00869
G1 X86.978 Y103.164 E.00869
G1 X86.395 Y103.267 E.01254
G1 X85.803 Y103.269 E.01254
G1 X85.201 Y103.161 E.01293
G1 X84.638 Y102.951 E.01273
G1 X84.287 Y102.757 E.00849
G1 X83.961 Y102.522 E.00849
G1 X83.666 Y102.251 E.0085
G1 X83.404 Y101.947 E.00849
G1 X83.181 Y101.613 E.00849
G1 X82.998 Y101.256 E.00849
G1 X82.86 Y100.88 E.00849
G1 X82.766 Y100.489 E.0085
G1 X82.72 Y100.091 E.00849
G1 X82.738 Y99.499 E.01253
G1 X82.812 Y99.095 E.00869
G1 X82.931 Y98.712 E.00849
G1 X83.094 Y98.345 E.00849
G1 X83.301 Y97.999 E.00853
G1 X83.506 Y97.73 E.00716
G1 X84.625 Y96.482 E.03549
G1 X79.631 Y96.482 E.10571
G1 X79.392 Y96.454 E.00508
G1 X79.119 Y96.34 E.00626
G1 X78.992 Y96.24 E.00343
G1 X78.884 Y96.119 E.00343
G1 X78.791 Y95.957 E.00394
G1 X78.743 Y95.812 E.00324
G1 X78.714 Y95.565 E.00527
G1 X78.714 Y77.628 E.37965
G1 X78.75 Y77.355 E.00583
G1 X78.857 Y77.122 E.00542
G1 X78.957 Y76.996 E.0034
G1 X79.059 Y76.904 E.00292
G1 X79.294 Y76.775 E.00567
G1 X79.543 Y76.723 E.00539
G1 X92.584 Y76.721 E.27602
G1 X92.803 Y76.748 E.00468
G1 X92.942 Y76.794 E.0031
G1 X93.119 Y76.889 E.00424
G1 X93.07 Y77.082 E.0042
G1 X80.04 Y77.082 E.27579
G1 X79.752 Y77.132 E.0062
G1 X79.474 Y77.282 E.00669
G1 X79.241 Y77.529 E.00717
M73 P52 R11
G1 X79.112 Y77.806 E.00649
G1 X79.075 Y78.056 E.00533
G1 X79.075 Y95.173 E.36231
G1 X79.162 Y95.538 E.00794
G1 X79.343 Y95.797 E.00669
G1 X79.539 Y95.962 E.00541
G1 X79.8 Y96.084 E.0061
G1 X80.049 Y96.12 E.00533
G1 X84.832 Y96.12 E.10124
; WIPE_START
M204 S6000
G1 X86.832 Y96.12 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X83.708 Y96.891 Z2.4 F18000
G1 Z2
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X79.607 Y96.891 E.08067
G1 X79.297 Y96.855 E.00613
G1 X79.01 Y96.75 E.00601
G1 X78.888 Y96.68 E.00277
G1 X78.71 Y96.539 E.00448
G1 X78.558 Y96.368 E.00448
G1 X78.478 Y96.246 E.00289
G1 X78.412 Y96.114 E.00289
G1 X78.341 Y95.901 E.00442
G1 X78.304 Y95.589 E.00619
G1 X78.304 Y77.61 E.35362
G1 X78.325 Y77.374 E.00466
G1 X78.358 Y77.233 E.00285
G1 X78.432 Y77.043 E.00401
G1 X78.516 Y76.894 E.00336
G1 X78.657 Y76.716 E.00447
G1 X78.806 Y76.581 E.00395
G1 X78.948 Y76.485 E.00337
G1 X79.154 Y76.389 E.00445
G1 X79.374 Y76.33 E.00448
G1 X79.519 Y76.313 E.00289
G1 X92.61 Y76.312 E.25747
G1 X92.894 Y76.347 E.00564
G1 X93.105 Y76.417 E.00437
G1 X93.303 Y76.524 E.00442
G1 X93.479 Y76.663 E.00441
G1 X93.629 Y76.831 E.00442
G1 X93.746 Y77.022 E.00442
G1 X93.829 Y77.231 E.00442
G1 X93.874 Y77.448 E.00436
G1 X93.885 Y85.511 E.15858
G1 X94.382 Y85.511 E.00979
G1 F1870.275
G1 X94.513 Y85.511 E.00256
G1 F1320
G1 X94.513 Y87.691 E.04288
G1 F1668.612
G1 X94.382 Y87.691 E.00256
G1 F1500
G1 X93.884 Y87.691 E.0098
G1 X93.884 Y88.791 E.02164
G1 X92.704 Y88.791 E.02321
G1 X92.704 Y77.491 E.22226
G1 X80.076 Y77.491 E.24839
G1 X79.888 Y77.524 E.00376
G1 X79.726 Y77.611 E.00361
G1 X79.584 Y77.762 E.00406
G1 X79.508 Y77.925 E.00355
G1 X79.484 Y78.086 E.00319
G1 X79.484 Y95.125 E.33516
G1 X79.542 Y95.368 E.0049
G1 X79.647 Y95.518 E.00361
G1 X79.761 Y95.614 E.00291
G1 X79.919 Y95.687 E.00343
G1 X80.079 Y95.711 E.00319
G1 X92.292 Y95.711 E.24022
G1 X92.312 Y95.387 E.00639
G1 X92.349 Y95.209 E.00357
G1 X92.397 Y95.084 E.00263
G1 X92.476 Y94.945 E.00314
G1 X92.674 Y94.731 E.00574
G1 X92.926 Y94.582 E.00576
G1 X93.209 Y94.516 E.00572
G1 X93.448 Y94.524 E.00469
G1 X93.679 Y94.59 E.00472
G1 X93.796 Y94.648 E.00257
G1 X94.026 Y94.809 E.00552
G1 X95.622 Y94.286 E.03304
G1 X98.41 Y90.305 E.09559
G1 X99.376 Y90.982 E.02321
G1 X96.375 Y95.268 E.10291
G1 X93.445 Y96.574 E.0631
G1 X93.229 Y96.723 E.00516
G1 X93.102 Y96.786 E.00279
G1 X92.891 Y96.855 E.00436
G1 X92.582 Y96.891 E.00611
G1 X88.49 Y96.891 E.08049
G1 X89.096 Y97.588 E.01817
G1 X89.351 Y97.962 E.00891
G1 X89.555 Y98.356 E.00873
G1 X89.716 Y98.783 E.00897
G1 X89.774 Y98.994 E.00431
G1 X89.856 Y99.44 E.00892
G1 X89.882 Y99.817 E.00743
G1 X89.878 Y100.115 E.00586
G1 X89.796 Y100.708 E.01176
G1 X89.649 Y101.213 E.01036
G1 X89.501 Y101.559 E.0074
G1 X89.362 Y101.82 E.0058
G1 X89.111 Y102.195 E.00888
G1 X88.816 Y102.538 E.00891
G1 X88.659 Y102.691 E.00431
G1 X88.305 Y102.979 E.00897
G1 X87.93 Y103.216 E.00873
G1 X87.521 Y103.412 E.00891
G1 X87.092 Y103.557 E.00891
G1 X86.88 Y103.608 E.00431
G1 X86.431 Y103.676 E.00891
G1 X85.979 Y103.689 E.00891
G1 X85.76 Y103.676 E.00431
G1 X85.309 Y103.608 E.00897
G1 X84.881 Y103.491 E.00873
G1 X84.462 Y103.321 E.00891
G1 X84.068 Y103.103 E.00885
G1 X83.703 Y102.84 E.00885
G1 X83.371 Y102.536 E.00885
G1 X83.078 Y102.195 E.00885
G1 X82.827 Y101.821 E.00885
G1 X82.623 Y101.42 E.00885
G1 X82.467 Y100.998 E.00885
G1 X82.363 Y100.56 E.00885
G1 X82.311 Y100.113 E.00885
G1 X82.312 Y99.661 E.00891
G1 X82.332 Y99.443 E.0043
G1 X82.414 Y98.997 E.00891
G1 X82.547 Y98.567 E.00885
G1 X82.73 Y98.156 E.00885
G1 X82.961 Y97.769 E.00886
G1 X83.19 Y97.469 E.00743
G1 X83.668 Y96.936 E.01409
; WIPE_START
M204 S6000
G1 X81.668 Y96.914 E-.38
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




G1 X79.578 Y96.239
G1 Z2
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.102732
G1 F1500
M204 S6000
G1 X79.394 Y96.178 E.00075
; LINE_WIDTH: 0.154602
G1 X79.185 Y96.033 E.00163
G1 X79.046 Y95.853 E.00146
; LINE_WIDTH: 0.13266
G1 X79.002 Y95.753 E.00058
; LINE_WIDTH: 0.0954456
G1 X78.958 Y95.653 E.00038
; WIPE_START
G1 X79.002 Y95.753 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X84.675 Y97.145 Z2.4 F18000
G1 Z2
G1 E.4 F1800
; LINE_WIDTH: 0.474982
G1 F1500
M204 S6000
G1 X84.483 Y97.305 E.0056
; LINE_WIDTH: 0.434389
G1 X84.265 Y97.489 E.00581
; LINE_WIDTH: 0.397778
G1 X84.085 Y97.67 E.00472
; LINE_WIDTH: 0.360127
G1 X83.886 Y97.872 E.00474
G1 X83.569 Y98.285 E.00868
G1 X83.433 Y98.521 E.00455
G1 X83.288 Y98.846 E.00594
G1 X83.186 Y99.187 E.00594
G1 X83.118 Y99.545 E.0061
G1 X83.101 Y100.071 E.00878
G1 X83.161 Y100.522 E.00758
G1 X83.225 Y100.769 E.00426
G1 X83.348 Y101.103 E.00594
G1 X83.512 Y101.418 E.00593
G1 X83.708 Y101.716 E.00594
G1 X84.021 Y102.066 E.00783
G1 X84.202 Y102.226 E.00404
G1 X84.491 Y102.434 E.00594
G1 X84.802 Y102.602 E.0059
G1 X85.302 Y102.792 E.00893
G1 X85.808 Y102.886 E.00858
G1 X86.304 Y102.892 E.00827
G1 X86.864 Y102.801 E.00946
G1 X87.223 Y102.677 E.00634
G1 X87.554 Y102.517 E.00614
G1 X87.836 Y102.343 E.00552
G1 X88.129 Y102.104 E.00631
G1 X88.48 Y101.712 E.00878
G1 X88.683 Y101.418 E.00597
G1 X88.908 Y100.944 E.00874
G1 X89.039 Y100.463 E.00833
G1 X89.085 Y100.09 E.00627
G1 X89.085 Y99.694 E.0066
G1 X89.005 Y99.176 E.00874
G1 X88.895 Y98.839 E.00591
G1 X88.744 Y98.495 E.00627
G1 X88.47 Y98.067 E.00847
M73 P53 R11
G1 X88.097 Y97.654 E.0093
; LINE_WIDTH: 0.395492
G1 X87.972 Y97.538 E.00314
; LINE_WIDTH: 0.431434
G1 X87.847 Y97.422 E.00345
; LINE_WIDTH: 0.467631
G1 X87.721 Y97.304 E.00381
; LINE_WIDTH: 0.468541
G1 X87.559 Y97.34 E.00365
; LINE_WIDTH: 0.4339
G1 X87.398 Y97.375 E.00337
; WIPE_START
G1 X87.559 Y97.34 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X94.008 Y95.554 Z2.4 F18000
G1 Z2
G1 E.4 F1800
; LINE_WIDTH: 0.154095
G1 F1500
M204 S6000
G1 X94.512 Y95.36 E.00346
; LINE_WIDTH: 0.10453
G1 X95.017 Y95.165 E.00212
; WIPE_START
G1 X94.512 Y95.36 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X89.483 Y89.618 Z2.4 F18000
G1 X78.952 Y77.595 Z2.4
G1 Z2
G1 E.4 F1800
; LINE_WIDTH: 0.106466
G1 F1500
M204 S6000
G1 X79.027 Y77.373 E.00094
; LINE_WIDTH: 0.156902
G1 X79.166 Y77.192 E.00149
G1 X79.288 Y77.08 E.00108
; LINE_WIDTH: 0.131191
G1 X79.472 Y76.995 E.00106
; LINE_WIDTH: 0.0957275
G1 X79.559 Y76.963 E.00032
; LINE_WIDTH: 0.0812008
G1 X79.591 Y76.955 E.00009
; WIPE_START
G1 X79.559 Y76.963 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X86.368 Y80.412 Z2.4 F18000
G1 X100.371 Y87.504 Z2.4
G1 Z2
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X100.647 Y87.111 E.00944
G1 X100.898 Y87.287 E.00604
G1 X101.613 Y87.787 E.01716
G1 X101.338 Y88.181 E.00944
G1 X100.42 Y87.538 E.02203
M204 S10000
G1 X100.676 Y87.424 F18000
; FEATURE: Gap infill
; LINE_WIDTH: 0.0965073
G1 F1500
M204 S6000
G1 X101.308 Y87.867 E.00272
; CHANGE_LAYER
; Z_HEIGHT: 2.09
; LAYER_HEIGHT: 0.0899999
; WIPE_START
G1 F1500
G1 X100.676 Y87.424 E-.38
; WIPE_END
G1 E-.02 F1800
; layer num/total_layer_count: 17/57
; update layer progress
M73 L17
M991 S0 P16 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z2.4 I-1.216 J.034 P1  F18000
G1 X100.731 Y89.379 Z2.4
G1 Z2.09
G1 E.4 F1800
; FEATURE: Support interface
; LINE_WIDTH: 0.42
; LAYER_HEIGHT: 0.21
G1 F1500
M204 S6000
G1 X100.731 Y88.741 E.02091
G1 X99.898 Y88.157 E.0333
G1 X99.837 Y88.244 E.00348
G1 X99.837 Y90.319 E.06792
G1 X98.942 Y89.693 E.03574
G1 X98.942 Y89.212 E.01574
; WIPE_START
G1 X98.942 Y89.693 E-.09137
G1 X99.837 Y90.319 E-.20742
G1 X99.837 Y89.892 E-.08122
; WIPE_END
G1 E-.02 F1800
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
; layer num/total_layer_count: 18/57
; update layer progress
M73 L18
M991 S0 P17 ;notify layer change
; OBJECT_ID: 8
G1 X93.851 Y86.344
G1 Z2.12
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
; LAYER_HEIGHT: 0.12
G1 F1500
M204 S500
G1 X93.851 Y86.857 E.01086
G1 X93.538 Y86.857 E.00662
G1 X93.538 Y86.344 E.01086
G1 X93.791 Y86.344 E.00535
M204 S10000
G1 X94.275 Y85.92 F18000
G1 F1500
M204 S500
G1 X94.275 Y87.282 E.02882
G1 X93.475 Y87.282 E.01693
G1 X93.475 Y88.382 E.02328
G1 X93.114 Y88.382 E.00765
G1 X93.114 Y77.128 E.23818
G1 X93.299 Y77.076 E.00407
G1 X93.379 Y77.207 E.00325
G1 X93.436 Y77.349 E.00324
G1 X93.465 Y77.49 E.00306
G1 X93.476 Y85.92 E.17842
G1 X94.215 Y85.92 E.01564
; WIPE_START
M204 S6000
G1 X94.275 Y87.282 E-.25894
G1 X93.638 Y87.282 E-.12106
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X93.663 Y94.914 Z2.52 F18000
G1 X93.665 Y95.564 Z2.52
G1 Z2.12
G1 E.4 F1800
G1 F1500
M204 S500
G1 X93.122 Y95.806 E.0126
G1 X93.151 Y95.444 E.00769
G1 X93.246 Y95.351 E.00281
G1 X93.34 Y95.354 E.00201
G1 X93.615 Y95.531 E.00691
; WIPE_START
M204 S6000
G1 X93.122 Y95.806 E-.1448
G1 X93.151 Y95.444 E-.09319
G1 X93.246 Y95.351 E-.03401
G1 X93.34 Y95.354 E-.02432
G1 X93.615 Y95.531 E-.08368
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X86.106 Y96.899 Z2.52 F18000
G1 X84.856 Y97.126 Z2.52
G1 Z2.12
G1 E.4 F1800
G1 F1500
M204 S500
G1 X84.741 Y96.963 E.00423
G1 X85.105 Y96.544 E.01174
G1 X87.017 Y96.544 E.04046
G1 X87.359 Y96.916 E.0107
G1 X87.253 Y97.081 E.00416
G1 X86.861 Y96.953 E.00874
G1 X86.488 Y96.88 E.00804
G1 X85.973 Y96.857 E.0109
G1 X85.596 Y96.897 E.00804
G1 X85.225 Y96.981 E.00805
G1 X84.912 Y97.104 E.00712
; WIPE_START
M204 S6000
G1 X84.741 Y96.963 E-.04213
G1 X85.105 Y96.544 E-.1054
G1 X86.329 Y96.544 E-.23247
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X83.494 Y99.647 Z2.52 F18000
G1 Z2.12
G1 E.4 F1800
G1 F1500
M204 S500
G1 X83.501 Y99.519 E.0027
G1 X83.568 Y99.206 E.00679
G1 X83.656 Y98.942 E.00588
G1 X83.883 Y98.493 E.01065
G1 X84.172 Y98.118 E.01003
G1 X84.522 Y97.803 E.00995
G1 X84.922 Y97.556 E.00995
G1 X85.35 Y97.388 E.00975
G1 X85.665 Y97.316 E.00683
G1 X85.986 Y97.282 E.00683
G1 X86.437 Y97.302 E.00955
G1 X86.754 Y97.365 E.00683
G1 X87.061 Y97.465 E.00683
G1 X87.473 Y97.671 E.00975
G1 X87.849 Y97.953 E.00995
G1 X88.162 Y98.29 E.00975
G1 X88.344 Y98.557 E.00683
G1 X88.493 Y98.843 E.00683
G1 X88.641 Y99.279 E.00975
G1 X88.711 Y99.744 E.00995
G1 X88.697 Y100.214 E.00995
G1 X88.6 Y100.674 E.00995
G1 X88.425 Y101.1 E.00975
G1 X88.259 Y101.377 E.00683
G1 X88.062 Y101.632 E.00683
G1 X87.729 Y101.951 E.00976
G1 X87.337 Y102.21 E.00995
G1 X86.913 Y102.391 E.00975
G1 X86.601 Y102.472 E.00683
G1 X86.29 Y102.514 E.00664
G1 X85.977 Y102.519 E.00663
G1 X85.656 Y102.485 E.00683
G1 X85.219 Y102.371 E.00956
G1 X84.922 Y102.244 E.00683
G1 X84.643 Y102.083 E.00683
G1 X84.29 Y101.802 E.00956
G1 X84.07 Y101.565 E.00683
G1 X83.881 Y101.304 E.00683
G1 X83.668 Y100.895 E.00975
G1 X83.53 Y100.446 E.00995
G1 X83.474 Y99.979 E.00995
G1 X83.49 Y99.706 E.00579
M204 S250
G1 X83.902 Y99.671 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X83.908 Y99.574 E.0019
G1 X83.964 Y99.313 E.00525
G1 X84.035 Y99.1 E.00443
G1 X84.23 Y98.712 E.00855
G1 X84.474 Y98.397 E.00782
G1 X84.768 Y98.132 E.00779
G1 X85.105 Y97.924 E.0078
G1 X85.471 Y97.78 E.00773
G1 X85.732 Y97.72 E.00526
G1 X85.998 Y97.692 E.00526
G1 X86.388 Y97.71 E.00767
G1 X86.651 Y97.762 E.00526
G1 X86.905 Y97.844 E.00526
G1 X87.257 Y98.02 E.00774
G1 X87.574 Y98.258 E.0078
G1 X87.841 Y98.546 E.00773
G1 X87.992 Y98.767 E.00526
G1 X88.115 Y99.005 E.00526
G1 X88.242 Y99.377 E.00773
G1 X88.301 Y99.769 E.0078
G1 X88.289 Y100.165 E.0078
G1 X88.207 Y100.552 E.00779
G1 X88.058 Y100.916 E.00774
G1 X87.921 Y101.146 E.00526
G1 X87.757 Y101.358 E.00526
G1 X87.473 Y101.629 E.00774
G1 X87.142 Y101.848 E.00779
G1 X86.781 Y102.002 E.00773
G1 X86.522 Y102.07 E.00526
G1 X86.26 Y102.105 E.0052
G1 X85.995 Y102.109 E.0052
G1 X85.729 Y102.081 E.00526
G1 X85.352 Y101.983 E.00767
G1 X85.106 Y101.878 E.00526
G1 X84.874 Y101.744 E.00526
G1 X84.569 Y101.501 E.00768
G1 X84.387 Y101.305 E.00526
G1 X84.23 Y101.088 E.00526
G1 X84.049 Y100.739 E.00773
G1 X83.932 Y100.361 E.0078
G1 X83.885 Y99.967 E.0078
G1 X83.899 Y99.731 E.00465
; WIPE_START
M204 S6000
G1 X83.908 Y99.574 E-.02977
G1 X83.964 Y99.313 E-.0507
G1 X84.035 Y99.1 E-.04278
G1 X84.23 Y98.712 E-.08258
G1 X84.474 Y98.397 E-.07555
G1 X84.768 Y98.132 E-.0753
G1 X84.873 Y98.067 E-.02332
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X84.855 Y96.12 Z2.52 F18000
G1 Z2.12
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X92.678 Y96.12 E.16557
G1 X92.718 Y95.441 E.01439
G1 X92.743 Y95.326 E.00249
G1 X92.851 Y95.128 E.00477
G1 X92.932 Y95.05 E.00238
G1 X93.076 Y94.964 E.00355
G1 X93.235 Y94.926 E.00347
G1 X93.443 Y94.941 E.00441
G1 X93.539 Y94.978 E.00218
G1 X93.972 Y95.257 E.01091
G1 X95.879 Y94.633 E.04247
G1 X98.51 Y90.875 E.09709
G1 X98.806 Y91.083 E.00765
G1 X96.105 Y94.94 E.09967
G1 X93.244 Y96.216 E.06631
G1 X93.021 Y96.37 E.00573
G1 X92.803 Y96.453 E.00495
G1 X92.559 Y96.482 E.0052
G1 X87.536 Y96.482 E.10631
G1 X88.639 Y97.675 E.03439
G1 X88.889 Y98 E.00868
G1 X89.099 Y98.353 E.00869
G1 X89.302 Y98.839 E.01115
G1 X89.376 Y99.09 E.00554
G1 X89.451 Y99.499 E.00879
G1 X89.469 Y100.1 E.01273
G1 X89.397 Y100.612 E.01094
G1 X89.263 Y101.075 E.01021
G1 X89.006 Y101.618 E.01271
G1 X88.706 Y102.044 E.01103
G1 X88.375 Y102.395 E.01021
G1 X88.121 Y102.605 E.00698
G1 X87.737 Y102.855 E.00969
G1 X87.365 Y103.033 E.00873
G1 X87.05 Y103.142 E.00706
G1 X86.796 Y103.207 E.00554
G1 X86.386 Y103.269 E.00878
G1 X85.794 Y103.267 E.01254
G1 X85.211 Y103.164 E.01253
G1 X84.826 Y103.033 E.0086
G1 X84.395 Y102.82 E.01018
G1 X83.968 Y102.529 E.01094
G1 X83.666 Y102.251 E.00869
G1 X83.404 Y101.947 E.00849
G1 X83.181 Y101.613 E.00849
G1 X82.998 Y101.256 E.00849
G1 X82.86 Y100.879 E.0085
G1 X82.738 Y100.298 E.01257
G1 X82.717 Y99.965 E.00705
G1 X82.741 Y99.486 E.01017
G1 X82.863 Y98.91 E.01245
G1 X83.007 Y98.526 E.00868
G1 X83.192 Y98.17 E.0085
G1 X83.417 Y97.838 E.00849
G1 X84.597 Y96.482 E.03805
G1 X79.631 Y96.482 E.10513
G1 X79.392 Y96.454 E.00508
G1 X79.119 Y96.34 E.00626
G1 X78.927 Y96.173 E.0054
G1 X78.829 Y96.033 E.00362
G1 X78.743 Y95.812 E.00501
G1 X78.714 Y95.565 E.00527
G1 X78.714 Y77.619 E.37984
G1 X78.753 Y77.349 E.00578
G1 X78.809 Y77.207 E.00324
G1 X78.89 Y77.076 E.00324
G1 X79.062 Y76.901 E.0052
G1 X79.287 Y76.777 E.00544
G1 X79.547 Y76.723 E.00562
G1 X92.586 Y76.721 E.27597
G1 X92.803 Y76.748 E.00464
G1 X92.942 Y76.794 E.0031
G1 X93.119 Y76.889 E.00424
G1 X93.07 Y77.082 E.0042
G1 X80.04 Y77.082 E.27579
G1 X79.752 Y77.133 E.0062
G1 X79.479 Y77.28 E.00656
G1 X79.257 Y77.507 E.00672
G1 X79.113 Y77.8 E.00693
G1 X79.075 Y78.056 E.00546
G1 X79.075 Y95.173 E.3623
G1 X79.162 Y95.539 E.00795
G1 X79.343 Y95.797 E.00669
G1 X79.539 Y95.962 E.00542
G1 X79.8 Y96.084 E.0061
G1 X80.049 Y96.12 E.00533
G1 X84.795 Y96.12 E.10045
; WIPE_START
M204 S6000
G1 X86.795 Y96.12 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X83.699 Y96.891 Z2.52 F18000
G1 Z2.12
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X79.607 Y96.891 E.08049
G1 X79.297 Y96.855 E.00613
G1 X79.01 Y96.75 E.00601
G1 X78.888 Y96.68 E.00277
G1 X78.707 Y96.537 E.00454
G1 X78.608 Y96.432 E.00283
G1 X78.476 Y96.243 E.00454
G1 X78.412 Y96.114 E.00283
G1 X78.341 Y95.901 E.00442
G1 X78.304 Y95.589 E.00619
G1 X78.304 Y77.607 E.35368
G1 X78.313 Y77.454 E.00301
G1 X78.359 Y77.231 E.00448
G1 X78.442 Y77.022 E.00442
G1 X78.56 Y76.831 E.00442
G1 X78.712 Y76.661 E.00448
G1 X78.822 Y76.568 E.00283
G1 X79.018 Y76.447 E.00454
G1 X79.151 Y76.39 E.00285
G1 X79.346 Y76.336 E.00398
G1 X79.521 Y76.313 E.00346
G1 X92.611 Y76.312 E.25748
G1 X92.894 Y76.347 E.0056
G1 X93.105 Y76.417 E.00438
G1 X93.303 Y76.524 E.00442
G1 X93.479 Y76.663 E.00442
G1 X93.629 Y76.831 E.00442
G1 X93.747 Y77.022 E.00442
G1 X93.829 Y77.231 E.00442
G1 X93.874 Y77.448 E.00436
G1 X93.885 Y85.511 E.15858
G1 X94.554 Y85.511 E.01316
G1 F1870.275
G1 X94.684 Y85.511 E.00256
G1 F1320
G1 X94.684 Y87.691 E.04288
G1 F1668.612
G1 X94.554 Y87.691 E.00256
G1 F1500
G1 X93.884 Y87.691 E.01317
G1 X93.884 Y88.791 E.02164
G1 X92.704 Y88.791 E.02321
G1 X92.704 Y77.491 E.22226
G1 X80.076 Y77.491 E.24839
G1 X79.888 Y77.524 E.00376
G1 X79.728 Y77.61 E.00357
G1 X79.595 Y77.746 E.00373
G1 X79.508 Y77.923 E.00389
G1 X79.484 Y78.086 E.00323
G1 X79.484 Y95.125 E.33516
M73 P54 R11
G1 X79.542 Y95.368 E.0049
G1 X79.647 Y95.518 E.00361
G1 X79.761 Y95.614 E.00292
G1 X79.919 Y95.687 E.00343
G1 X80.079 Y95.711 E.00318
G1 X92.292 Y95.711 E.24022
G1 X92.312 Y95.387 E.00639
G1 X92.349 Y95.209 E.00357
G1 X92.398 Y95.083 E.00266
G1 X92.545 Y94.855 E.00533
G1 X92.674 Y94.73 E.00353
G1 X92.926 Y94.582 E.00575
G1 X93.209 Y94.516 E.00572
G1 X93.454 Y94.525 E.00482
G1 X93.725 Y94.611 E.00559
G1 X94.03 Y94.807 E.00715
G1 X95.622 Y94.286 E.03295
G1 X98.41 Y90.305 E.09559
G1 X99.376 Y90.982 E.02321
G1 X96.375 Y95.268 E.10291
G1 X93.445 Y96.575 E.0631
G1 X93.229 Y96.723 E.00516
G1 X93.102 Y96.786 E.00279
G1 X92.891 Y96.855 E.00437
G1 X92.582 Y96.891 E.00611
G1 X88.471 Y96.891 E.08086
G1 X88.952 Y97.411 E.01393
G1 X89.228 Y97.77 E.00891
G1 X89.46 Y98.159 E.00891
G1 X89.555 Y98.357 E.00432
G1 X89.69 Y98.708 E.0074
G1 X89.774 Y98.996 E.0059
G1 X89.856 Y99.443 E.00894
G1 X89.877 Y99.661 E.0043
G1 X89.878 Y100.117 E.00897
G1 X89.797 Y100.703 E.01164
G1 X89.649 Y101.213 E.01045
G1 X89.503 Y101.555 E.00731
G1 X89.361 Y101.823 E.00596
G1 X89.019 Y102.308 E.01167
G1 X88.655 Y102.694 E.01045
G1 X88.368 Y102.931 E.00731
G1 X87.93 Y103.216 E.01028
G1 X87.521 Y103.412 E.00892
G1 X87.168 Y103.534 E.00734
G1 X86.878 Y103.609 E.00589
G1 X86.429 Y103.676 E.00894
G1 X86.21 Y103.689 E.00431
G1 X85.757 Y103.676 E.00891
G1 X85.309 Y103.608 E.00891
G1 X85.097 Y103.557 E.0043
G1 X84.669 Y103.412 E.00889
G1 X84.193 Y103.177 E.01044
G1 X83.879 Y102.976 E.00733
G1 X83.705 Y102.842 E.00432
G1 X83.371 Y102.536 E.00891
G1 X83.078 Y102.195 E.00885
G1 X82.827 Y101.821 E.00885
G1 X82.623 Y101.42 E.00885
G1 X82.467 Y100.998 E.00885
G1 X82.362 Y100.557 E.00891
G1 X82.307 Y99.968 E.01164
G1 X82.333 Y99.438 E.01043
G1 X82.415 Y98.994 E.00888
G1 X82.473 Y98.783 E.00431
G1 X82.633 Y98.359 E.00891
G1 X82.84 Y97.96 E.00885
G1 X83.093 Y97.588 E.00885
G1 X83.66 Y96.936 E.01698
; WIPE_START
M204 S6000
G1 X81.66 Y96.914 E-.38
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




G1 X79.578 Y96.239
G1 Z2.12
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.102678
G1 F1500
M204 S6000
G1 X79.394 Y96.178 E.00074
; LINE_WIDTH: 0.152018
G1 X79.179 Y96.028 E.00165
G1 X79.045 Y95.85 E.0014
; LINE_WIDTH: 0.131844
G1 X79.001 Y95.752 E.00057
; LINE_WIDTH: 0.0951751
G1 X78.958 Y95.653 E.00037
; WIPE_START
G1 X79.001 Y95.752 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X84.63 Y97.174 Z2.52 F18000
G1 Z2.12
G1 E.4 F1800
; LINE_WIDTH: 0.47305
G1 F1500
M204 S6000
G1 X84.46 Y97.318 E.00499
; LINE_WIDTH: 0.438112
G1 X84.263 Y97.487 E.00533
; LINE_WIDTH: 0.401729
G1 X84.085 Y97.669 E.00477
; LINE_WIDTH: 0.360209
G1 X83.886 Y97.872 E.00474
G1 X83.555 Y98.305 E.00909
G1 X83.312 Y98.786 E.009
G1 X83.203 Y99.116 E.00579
G1 X83.119 Y99.532 E.00708
G1 X83.097 Y100.005 E.00791
G1 X83.168 Y100.538 E.00896
G1 X83.314 Y101.024 E.00848
G1 X83.553 Y101.492 E.00876
G1 X83.773 Y101.797 E.00627
G1 X84.026 Y102.068 E.00619
G1 X84.42 Y102.388 E.00847
G1 X84.746 Y102.576 E.00627
G1 X85.086 Y102.722 E.00619
G1 X85.577 Y102.854 E.00847
G1 X85.97 Y102.893 E.00659
G1 X86.352 Y102.889 E.00638
G1 X86.721 Y102.834 E.00622
G1 X87.023 Y102.752 E.00524
G1 X87.529 Y102.536 E.00918
G1 X87.892 Y102.299 E.00723
G1 X88.112 Y102.114 E.0048
G1 X88.333 Y101.892 E.00522
G1 X88.567 Y101.599 E.00627
G1 X88.768 Y101.258 E.0066
G1 X88.902 Y100.946 E.00566
G1 X89.022 Y100.528 E.00725
G1 X89.085 Y100.082 E.00753
G1 X89.084 Y99.707 E.00625
G1 X89.007 Y99.178 E.00892
G1 X88.842 Y98.707 E.00833
G1 X88.662 Y98.355 E.00659
G1 X88.449 Y98.046 E.00627
G1 X88.095 Y97.656 E.00879
; LINE_WIDTH: 0.395926
G1 X87.906 Y97.485 E.00471
; LINE_WIDTH: 0.442257
G1 X87.716 Y97.314 E.0053
; LINE_WIDTH: 0.480631
G1 X87.474 Y97.129 E.0069
; WIPE_START
G1 X87.716 Y97.314 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X94.029 Y95.546 Z2.52 F18000
G1 Z2.12
G1 E.4 F1800
; LINE_WIDTH: 0.152238
G1 F1500
M204 S6000
G1 X94.523 Y95.356 E.00334
; LINE_WIDTH: 0.103911
G1 X95.017 Y95.165 E.00206
; WIPE_START
G1 X94.523 Y95.356 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X89.489 Y89.618 Z2.52 F18000
G1 X78.949 Y77.604 Z2.52
G1 Z2.12
G1 E.4 F1800
; LINE_WIDTH: 0.101554
G1 F1500
M204 S6000
G1 X79.006 Y77.423 E.00072
; LINE_WIDTH: 0.149659
G1 X79.051 Y77.331 E.00064
G1 X79.195 Y77.162 E.00137
G1 X79.311 Y77.07 E.00091
; LINE_WIDTH: 0.127846
G1 X79.471 Y76.996 E.0009
; LINE_WIDTH: 0.0942249
G1 X79.564 Y76.962 E.00034
; LINE_WIDTH: 0.079942
G1 X79.591 Y76.955 E.00008
; WIPE_START
G1 X79.564 Y76.962 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X86.372 Y80.411 Z2.52 F18000
G1 X100.371 Y87.504 Z2.52
G1 Z2.12
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X100.647 Y87.111 E.00944
G1 X100.925 Y87.305 E.00667
G1 X101.613 Y87.787 E.01654
G1 X101.338 Y88.181 E.00944
G1 X100.42 Y87.538 E.02203
M204 S10000
G1 X100.676 Y87.424 F18000
; FEATURE: Gap infill
; LINE_WIDTH: 0.0965073
G1 F1500
M204 S6000
G1 X101.308 Y87.867 E.00272
; CHANGE_LAYER
; Z_HEIGHT: 2.24
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F1500
G1 X100.676 Y87.424 E-.38
; WIPE_END
G1 E-.02 F1800
; layer num/total_layer_count: 19/57
; update layer progress
M73 L19
M991 S0 P18 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z2.52 I.195 J-1.201 P1  F18000
G1 X94.022 Y86.344 Z2.52
G1 Z2.24
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X94.022 Y86.857 E.01086
G1 X93.538 Y86.857 E.01025
G1 X93.538 Y86.344 E.01086
G1 X93.962 Y86.344 E.00898
M204 S10000
G1 X94.446 Y85.92 F18000
G1 F1500
M204 S500
G1 X94.446 Y87.282 E.02882
G1 X93.475 Y87.282 E.02055
G1 X93.475 Y88.382 E.02328
G1 X93.114 Y88.382 E.00765
G1 X93.114 Y77.125 E.23825
G1 X93.306 Y77.077 E.0042
G1 X93.401 Y77.253 E.00424
G1 X93.446 Y77.39 E.00305
G1 X93.475 Y77.637 E.00527
G1 X93.475 Y85.92 E.17532
G1 X94.386 Y85.92 E.01929
; WIPE_START
M204 S6000
G1 X94.446 Y87.282 E-.25894
G1 X93.809 Y87.282 E-.12106
; WIPE_END
G1 E-.02 F1800
M204 S10000
G17
G3 Z2.64 I-1.217 J-.021 P1  F18000
G1 X93.665 Y95.564 Z2.64
G1 Z2.24
G1 E.4 F1800
G1 F1500
M204 S500
G1 X93.121 Y95.806 E.0126
G1 X93.14 Y95.498 E.00654
G1 X93.173 Y95.407 E.00204
G1 X93.212 Y95.37 E.00115
G1 X93.32 Y95.341 E.00236
G1 X93.615 Y95.531 E.00743
; WIPE_START
M204 S6000
G1 X93.121 Y95.806 E-.14432
G1 X93.14 Y95.498 E-.07891
G1 X93.173 Y95.407 E-.02463
G1 X93.212 Y95.37 E-.01388
G1 X93.32 Y95.341 E-.0285
G1 X93.615 Y95.531 E-.08975
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X86.105 Y96.895 Z2.64 F18000
G1 X84.866 Y97.12 Z2.64
G1 Z2.24
G1 E.4 F1800
G1 F1500
M204 S500
G1 X84.747 Y96.956 E.00429
G1 X85.105 Y96.544 E.01155
G1 X87.084 Y96.544 E.04188
G1 X87.437 Y96.951 E.0114
G1 X87.314 Y97.115 E.00436
G1 X86.861 Y96.954 E.01018
G1 X86.488 Y96.88 E.00805
G1 X85.958 Y96.856 E.01123
G1 X85.432 Y96.928 E.01124
G1 X85.067 Y97.034 E.00803
G1 X84.922 Y97.096 E.00335
; WIPE_START
M204 S6000
G1 X84.747 Y96.956 E-.04255
G1 X85.105 Y96.544 E-.10366
G1 X86.336 Y96.544 E-.2338
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X83.493 Y99.659 Z2.64 F18000
G1 Z2.24
G1 E.4 F1800
G1 F1500
M204 S500
G1 X83.501 Y99.519 E.00297
G1 X83.568 Y99.206 E.00679
G1 X83.655 Y98.945 E.00583
G1 X83.883 Y98.493 E.01071
G1 X84.172 Y98.118 E.01003
G1 X84.522 Y97.803 E.00995
G1 X84.914 Y97.561 E.00975
G1 X85.211 Y97.434 E.00683
G1 X85.52 Y97.344 E.00682
G1 X85.977 Y97.282 E.00975
G1 X86.437 Y97.302 E.00975
G1 X86.754 Y97.365 E.00683
G1 X87.052 Y97.462 E.00663
G1 X87.336 Y97.593 E.00663
G1 X87.611 Y97.763 E.00683
G1 X87.955 Y98.055 E.00956
G1 X88.166 Y98.296 E.00679
G1 X88.322 Y98.523 E.00583
G1 X88.548 Y98.976 E.01071
G1 X88.674 Y99.433 E.01003
G1 X88.716 Y99.901 E.00995
G1 X88.674 Y100.369 E.00995
G1 X88.551 Y100.813 E.00975
G1 X88.42 Y101.108 E.00683
G1 X88.255 Y101.385 E.00683
G1 X87.962 Y101.741 E.00975
G1 X87.611 Y102.039 E.00975
G1 X87.338 Y102.207 E.00678
G1 X87.089 Y102.325 E.00583
G1 X86.605 Y102.473 E.01071
G1 X86.143 Y102.521 E.00984
G1 X85.823 Y102.507 E.00678
G1 X85.551 Y102.464 E.00583
G1 X85.068 Y102.314 E.01071
G1 X84.65 Y102.089 E.01003
G1 X84.283 Y101.796 E.00995
G1 X83.973 Y101.442 E.00995
G1 X83.73 Y101.035 E.01004
G1 X83.559 Y100.559 E.01071
G1 X83.503 Y100.289 E.00582
G1 X83.474 Y99.97 E.00679
G1 X83.489 Y99.719 E.00532
M204 S250
G1 X83.902 Y99.684 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X83.908 Y99.574 E.00216
G1 X83.964 Y99.314 E.00525
G1 X84.034 Y99.102 E.00438
G1 X84.23 Y98.712 E.0086
G1 X84.474 Y98.397 E.00782
G1 X84.768 Y98.132 E.0078
G1 X85.103 Y97.925 E.00773
G1 X85.349 Y97.82 E.00526
G1 X85.605 Y97.745 E.00526
G1 X85.995 Y97.692 E.00774
G1 X86.388 Y97.71 E.00773
G1 X86.651 Y97.762 E.00526
G1 X86.902 Y97.843 E.0052
G1 X87.142 Y97.954 E.0052
G1 X87.369 Y98.095 E.00526
G1 X87.667 Y98.347 E.00767
G1 X87.843 Y98.548 E.00525
G1 X87.969 Y98.731 E.00438
G1 X88.164 Y99.123 E.0086
G1 X88.27 Y99.506 E.00782
G1 X88.305 Y99.901 E.0078
G1 X88.27 Y100.296 E.0078
G1 X88.165 Y100.675 E.00773
G1 X88.056 Y100.919 E.00526
G1 X87.919 Y101.149 E.00526
G1 X87.669 Y101.452 E.00773
G1 X87.369 Y101.707 E.00773
G1 X87.142 Y101.847 E.00525
G1 X86.941 Y101.942 E.00438
G1 X86.523 Y102.07 E.0086
G1 X86.131 Y102.111 E.00776
G1 X85.864 Y102.099 E.00524
G1 X85.644 Y102.064 E.00438
G1 X85.227 Y101.935 E.0086
G1 X84.876 Y101.746 E.00782
G1 X84.567 Y101.499 E.0078
G1 X84.306 Y101.2 E.0078
G1 X84.102 Y100.859 E.00782
G1 X83.954 Y100.448 E.0086
G1 X83.909 Y100.23 E.00438
G1 X83.885 Y99.964 E.00525
G1 X83.898 Y99.744 E.00434
; WIPE_START
M204 S6000
G1 X83.908 Y99.574 E-.03222
G1 X83.964 Y99.314 E-.05068
G1 X84.034 Y99.102 E-.04232
G1 X84.23 Y98.712 E-.08306
G1 X84.474 Y98.397 E-.07554
G1 X84.768 Y98.132 E-.07533
G1 X84.862 Y98.074 E-.02085
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X84.855 Y96.12 Z2.64 F18000
G1 Z2.24
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X92.678 Y96.12 E.16557
G1 X92.718 Y95.441 E.01439
G1 X92.743 Y95.322 E.00257
G1 X92.851 Y95.128 E.00469
G1 X92.932 Y95.05 E.00238
G1 X93.063 Y94.97 E.00324
G1 X93.291 Y94.922 E.00494
G1 X93.493 Y94.957 E.00434
G1 X93.972 Y95.257 E.01197
G1 X95.879 Y94.633 E.04247
G1 X98.51 Y90.875 E.09709
G1 X98.806 Y91.083 E.00765
G1 X96.105 Y94.94 E.09967
G1 X93.236 Y96.22 E.06649
G1 X93.08 Y96.334 E.0041
G1 X92.938 Y96.409 E.00339
G1 X92.803 Y96.453 E.00301
G1 X92.559 Y96.482 E.0052
G1 X87.591 Y96.482 E.10514
G1 X88.771 Y97.838 E.03805
G1 X89.095 Y98.344 E.01272
G1 X89.323 Y98.901 E.01274
G1 X89.45 Y99.489 E.01273
G1 X89.469 Y100.1 E.01292
G1 X89.398 Y100.607 E.01085
G1 X89.263 Y101.076 E.01031
G1 X89.011 Y101.61 E.01251
G1 X88.785 Y101.947 E.00858
G1 X88.387 Y102.385 E.01254
G1 X88.061 Y102.65 E.00888
G1 X87.738 Y102.855 E.0081
G1 X87.367 Y103.032 E.00869
G1 X86.978 Y103.164 E.00869
G1 X86.386 Y103.269 E.01272
G1 X85.794 Y103.267 E.01254
G1 X85.201 Y103.161 E.01274
G1 X84.711 Y102.983 E.01104
G1 X84.283 Y102.754 E.01027
G1 X83.961 Y102.522 E.0084
G1 X83.666 Y102.251 E.00849
G1 X83.404 Y101.947 E.00849
G1 X83.181 Y101.613 E.0085
G1 X82.998 Y101.256 E.00849
G1 X82.86 Y100.879 E.0085
G1 X82.738 Y100.298 E.01258
G1 X82.717 Y99.97 E.00695
G1 X82.741 Y99.485 E.01027
G1 X82.812 Y99.095 E.00841
G1 X82.931 Y98.712 E.00849
G1 X83.098 Y98.337 E.00869
G1 X83.417 Y97.838 E.01254
G1 X84.597 Y96.482 E.03805
G1 X79.631 Y96.482 E.10513
G1 X79.381 Y96.452 E.00532
G1 X79.261 Y96.414 E.00266
G1 X79.073 Y96.309 E.00457
G1 X78.885 Y96.121 E.00562
G1 X78.791 Y95.957 E.00399
G1 X78.743 Y95.812 E.00324
G1 X78.714 Y95.565 E.00527
G1 X78.714 Y77.619 E.37984
G1 X78.755 Y77.34 E.00597
G1 X78.86 Y77.118 E.0052
G1 X78.957 Y76.996 E.00329
G1 X79.057 Y76.906 E.00285
M73 P55 R11
G1 X79.296 Y76.774 E.00578
G1 X79.547 Y76.723 E.00543
G1 X92.597 Y76.721 E.27619
G1 X92.744 Y76.735 E.00314
G1 X92.895 Y76.775 E.0033
G1 X93.124 Y76.904 E.00556
G1 X93.068 Y77.082 E.00395
G1 X80.049 Y77.082 E.27555
G1 X79.791 Y77.12 E.00553
G1 X79.48 Y77.276 E.00737
G1 X79.241 Y77.529 E.00736
G1 X79.112 Y77.807 E.00649
G1 X79.075 Y78.056 E.00533
G1 X79.075 Y95.177 E.36238
G1 X79.169 Y95.552 E.00818
G1 X79.345 Y95.799 E.00643
G1 X79.539 Y95.962 E.00536
G1 X79.8 Y96.084 E.0061
G1 X80.049 Y96.12 E.00533
G1 X84.795 Y96.12 E.10045
; WIPE_START
M204 S6000
G1 X86.795 Y96.12 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X83.699 Y96.891 Z2.64 F18000
G1 Z2.24
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X79.607 Y96.891 E.08049
G1 X79.293 Y96.854 E.00621
G1 X79.108 Y96.795 E.00382
G1 X78.948 Y96.717 E.00349
G1 X78.691 Y96.52 E.00638
G1 X78.478 Y96.246 E.00684
G1 X78.412 Y96.114 E.00289
G1 X78.341 Y95.901 E.00442
G1 X78.304 Y95.589 E.00619
G1 X78.304 Y77.607 E.35368
G1 X78.313 Y77.454 E.00301
G1 X78.36 Y77.228 E.00454
G1 X78.409 Y77.093 E.00283
G1 X78.517 Y76.892 E.00448
G1 X78.657 Y76.716 E.00444
G1 X78.804 Y76.583 E.00389
G1 X78.948 Y76.485 E.00343
G1 X79.154 Y76.389 E.00447
G1 X79.345 Y76.336 E.00389
G1 X79.521 Y76.313 E.00349
G1 X92.616 Y76.312 E.25757
G1 X92.817 Y76.331 E.00398
G1 X93.035 Y76.389 E.00444
G1 X93.239 Y76.484 E.00442
G1 X93.426 Y76.615 E.00448
G1 X93.53 Y76.714 E.00283
G1 X93.672 Y76.893 E.00448
G1 X93.778 Y77.09 E.00442
G1 X93.848 Y77.301 E.00436
G1 X93.884 Y77.613 E.00619
G1 X93.884 Y85.511 E.15534
G1 X94.725 Y85.511 E.01654
G1 F1870.275
G1 X94.856 Y85.511 E.00256
G1 F1320
G1 X94.856 Y87.691 E.04288
G1 F1668.612
G1 X94.725 Y87.691 E.00256
G1 F1500
G1 X93.884 Y87.691 E.01654
G1 X93.884 Y88.791 E.02164
G1 X92.704 Y88.791 E.02321
G1 X92.704 Y77.491 E.22226
G1 X80.079 Y77.491 E.24833
G1 X79.916 Y77.515 E.00325
G1 X79.728 Y77.609 E.00413
G1 X79.584 Y77.762 E.00413
G1 X79.508 Y77.925 E.00355
G1 X79.484 Y78.086 E.00319
G1 X79.484 Y95.127 E.33518
G1 X79.547 Y95.377 E.00508
G1 X79.648 Y95.519 E.00343
G1 X79.761 Y95.614 E.0029
G1 X79.919 Y95.687 E.00343
G1 X80.079 Y95.711 E.00318
G1 X92.292 Y95.711 E.24022
G1 X92.312 Y95.386 E.00639
G1 X92.349 Y95.208 E.00359
G1 X92.477 Y94.943 E.00578
G1 X92.674 Y94.73 E.00571
G1 X92.922 Y94.585 E.00565
G1 X93.159 Y94.521 E.00484
G1 X93.447 Y94.524 E.00566
G1 X93.722 Y94.609 E.00567
G1 X94.03 Y94.807 E.00721
G1 X95.622 Y94.286 E.03295
G1 X98.41 Y90.305 E.09559
G1 X99.376 Y90.982 E.02321
G1 X96.375 Y95.268 E.10291
G1 X93.442 Y96.576 E.06316
G1 X93.298 Y96.682 E.00353
G1 X93.099 Y96.787 E.00443
G1 X92.891 Y96.855 E.0043
G1 X92.582 Y96.891 E.00611
G1 X88.49 Y96.891 E.08049
G1 X89.096 Y97.588 E.01817
G1 X89.351 Y97.962 E.00891
G1 X89.555 Y98.356 E.00873
G1 X89.715 Y98.78 E.00891
G1 X89.823 Y99.22 E.00891
G1 X89.877 Y99.661 E.00873
G1 X89.878 Y100.117 E.00897
G1 X89.798 Y100.698 E.01155
G1 X89.649 Y101.213 E.01054
G1 X89.504 Y101.551 E.00722
G1 X89.362 Y101.82 E.00598
G1 X89.111 Y102.195 E.00888
G1 X88.816 Y102.538 E.00891
G1 X88.659 Y102.691 E.00431
G1 X88.305 Y102.979 E.00897
G1 X87.93 Y103.216 E.00873
G1 X87.522 Y103.412 E.00891
G1 X87.092 Y103.557 E.00892
G1 X86.88 Y103.608 E.0043
G1 X86.429 Y103.676 E.00897
G1 X86.21 Y103.689 E.00431
G1 X85.757 Y103.676 E.00891
G1 X85.309 Y103.608 E.00891
G1 X85.093 Y103.556 E.00437
G1 X84.539 Y103.355 E.01161
G1 X84.067 Y103.102 E.01053
G1 X83.703 Y102.84 E.00882
G1 X83.371 Y102.536 E.00885
G1 X83.078 Y102.195 E.00885
G1 X82.827 Y101.821 E.00885
G1 X82.623 Y101.42 E.00885
G1 X82.467 Y100.998 E.00885
G1 X82.362 Y100.557 E.00891
G1 X82.307 Y99.973 E.01155
G1 X82.333 Y99.438 E.01053
G1 X82.414 Y98.997 E.00882
G1 X82.547 Y98.567 E.00885
G1 X82.732 Y98.153 E.00891
G1 X82.838 Y97.962 E.0043
G1 X83.093 Y97.588 E.00891
G1 X83.659 Y96.936 E.01698
; WIPE_START
M204 S6000
G1 X81.66 Y96.914 E-.38
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




G1 X79.578 Y96.239
G1 Z2.24
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.0981447
G1 F1500
M204 S6000
G1 X79.394 Y96.179 E.0007
; LINE_WIDTH: 0.15233
G1 X79.181 Y96.029 E.00164
G1 X78.951 Y95.718 E.00244
; WIPE_START
G1 X79.181 Y96.029 E-.2271
G1 X79.394 Y96.179 E-.1529
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X84.638 Y97.167 Z2.64 F18000
G1 Z2.24
G1 E.4 F1800
; LINE_WIDTH: 0.475197
G1 F1500
M204 S6000
G1 X84.464 Y97.315 E.00513
; LINE_WIDTH: 0.438833
G1 X84.263 Y97.487 E.00545
; LINE_WIDTH: 0.401775
G1 X84.085 Y97.669 E.00478
; LINE_WIDTH: 0.360095
G1 X83.886 Y97.872 E.00474
G1 X83.555 Y98.305 E.00909
G1 X83.302 Y98.811 E.00943
G1 X83.183 Y99.186 E.00657
G1 X83.12 Y99.529 E.00583
G1 X83.097 Y99.988 E.00766
G1 X83.131 Y100.354 E.00613
G1 X83.192 Y100.65 E.00504
G1 X83.349 Y101.103 E.00799
G1 X83.512 Y101.418 E.00593
G1 X83.708 Y101.716 E.00594
G1 X84.033 Y102.078 E.00812
G1 X84.454 Y102.412 E.00897
G1 X84.907 Y102.655 E.00857
G1 X85.453 Y102.831 E.00956
G1 X85.794 Y102.885 E.00576
G1 X86.142 Y102.9 E.00581
G1 X86.696 Y102.84 E.0093
G1 X87.215 Y102.683 E.00904
G1 X87.527 Y102.536 E.00576
G1 X87.835 Y102.345 E.00604
G1 X88.242 Y101.996 E.00895
G1 X88.479 Y101.714 E.00614
G1 X88.68 Y101.417 E.00599
G1 X88.907 Y100.945 E.00873
G1 X89.026 Y100.523 E.00733
G1 X89.071 Y100.24 E.00477
G1 X89.083 Y99.696 E.00908
G1 X89.039 Y99.352 E.00579
G1 X88.902 Y98.857 E.00857
G1 X88.752 Y98.522 E.00612
G1 X88.469 Y98.068 E.00893
G1 X88.213 Y97.775 E.00649
; LINE_WIDTH: 0.380228
G1 X88.04 Y97.605 E.00429
; LINE_WIDTH: 0.419788
G1 X87.842 Y97.411 E.00545
; LINE_WIDTH: 0.468122
G1 X87.544 Y97.162 E.00857
; WIPE_START
G1 X87.842 Y97.411 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X94.029 Y95.546 Z2.64 F18000
G1 Z2.24
G1 E.4 F1800
; LINE_WIDTH: 0.152251
G1 F1500
M204 S6000
G1 X94.523 Y95.356 E.00334
; LINE_WIDTH: 0.103915
G1 X95.017 Y95.165 E.00206
; WIPE_START
G1 X94.523 Y95.356 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X89.49 Y89.618 Z2.64 F18000
G1 X78.949 Y77.601 Z2.64
G1 Z2.24
G1 E.4 F1800
; LINE_WIDTH: 0.0995562
G1 F1500
M204 S6000
G1 X79.019 Y77.388 E.00083
; LINE_WIDTH: 0.154207
G1 X79.167 Y77.191 E.00157
G1 X79.288 Y77.08 E.00105
; LINE_WIDTH: 0.127514
G1 X79.492 Y76.99 E.00113
; LINE_WIDTH: 0.0894554
G1 X79.598 Y76.955 E.00036
; WIPE_START
G1 X79.492 Y76.99 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X86.309 Y80.423 Z2.64 F18000
G1 X100.371 Y87.504 Z2.64
G1 Z2.24
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X100.647 Y87.111 E.00944
G1 X100.951 Y87.324 E.0073
G1 X101.613 Y87.787 E.01591
G1 X101.338 Y88.181 E.00944
G1 X100.42 Y87.538 E.02203
M204 S10000
G1 X100.676 Y87.424 F18000
; FEATURE: Gap infill
; LINE_WIDTH: 0.0965082
G1 F1500
M204 S6000
G1 X101.308 Y87.867 E.00272
; CHANGE_LAYER
; Z_HEIGHT: 2.3
; LAYER_HEIGHT: 0.0599999
; WIPE_START
G1 F1500
G1 X100.676 Y87.424 E-.38
; WIPE_END
G1 E-.02 F1800
; layer num/total_layer_count: 20/57
; update layer progress
M73 L20
M991 S0 P19 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z2.64 I-1.089 J-.543 P1  F18000
G1 X100.284 Y88.212 Z2.64
G1 Z2.3
G1 E.4 F1800
; FEATURE: Support interface
; LINE_WIDTH: 0.42
; LAYER_HEIGHT: 0.21
G1 F1500
M204 S6000
G1 X99.86 Y88.212 E.0139
G1 X99.234 Y89.106 E.03574
G1 X100.706 Y89.106 E.0482
G1 X100.08 Y90 E.03574
G1 X99.071 Y90 E.03301
; WIPE_START
G1 X100.08 Y90 E-.19158
G1 X100.649 Y89.188 E-.18842
; WIPE_END
G1 E-.02 F1800
M204 S10000
G17
G3 Z2.7 I1.217 J0 P1  F18000
;===================== date: 20250206 =====================

; don't support timelapse gcode in spiral_mode and by object sequence for I3 structure printer
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
G92 E0
G1 Z2.7
G1 X0 Y90 ; move to safe pos
G1 X-13.0 F3000 ; move to safe pos
M400
M1004 S5 P1  ; external shutter
M400 P300
M971 S11 C11 O0
G92 E0
G1 X0 F18000
M623

; SKIPTYPE: head_wrap_detect
M622.1 S1
M1002 judge_flag g39_3rd_layer_detect_flag
M622 J1
    ; enable nozzle clog detect at 3rd layer
    


    M622.1 S1
    M1002 judge_flag g39_detection_flag
    M622 J1
      
        M622.1 S0
        M1002 judge_flag g39_mass_exceed_flag
        M622 J1
        
            G392 S0
            M400
            G90
            M83
            M204 S5000
            G0 Z2.7 F4000
            G39.3 S1
            G0 Z2.7 F4000
            G392 S0
          
        M623
    
    M623
M623
; SKIPPABLE_END




; CHANGE_LAYER
; Z_HEIGHT: 2.36
; LAYER_HEIGHT: 0.0599999
; layer num/total_layer_count: 21/57
; update layer progress
M73 L21
M991 S0 P20 ;notify layer change
; OBJECT_ID: 8
G1 X94.193 Y86.344
G1 Z2.36
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
; LAYER_HEIGHT: 0.12
G1 F1500
M204 S500
G1 X94.193 Y86.857 E.01086
G1 X93.538 Y86.857 E.01388
G1 X93.538 Y86.344 E.01086
G1 X94.133 Y86.344 E.01261
M204 S10000
G1 X94.618 Y85.92 F18000
G1 F1500
M204 S500
G1 X94.618 Y87.282 E.02882
M73 P56 R11
G1 X93.475 Y87.282 E.02418
G1 X93.475 Y88.382 E.02328
G1 X93.114 Y88.382 E.00765
G1 X93.114 Y77.127 E.23821
G1 X93.292 Y77.071 E.00395
G1 X93.355 Y77.162 E.00234
G1 X93.42 Y77.3 E.00324
G1 X93.459 Y77.448 E.00324
G1 X93.475 Y77.628 E.00382
G1 X93.475 Y85.92 E.17551
G1 X94.558 Y85.92 E.02291
; WIPE_START
M204 S6000
G1 X94.618 Y87.282 E-.25894
G1 X93.981 Y87.282 E-.12106
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X93.694 Y94.909 Z2.76 F18000
G1 X93.669 Y95.562 Z2.76
G1 Z2.36
G1 E.4 F1800
G1 F1500
M204 S500
G1 X93.122 Y95.806 E.0127
G1 X93.14 Y95.498 E.00653
G1 X93.162 Y95.423 E.00167
G1 X93.204 Y95.372 E.00138
G1 X93.293 Y95.348 E.00195
G1 X93.35 Y95.365 E.00127
G1 X93.618 Y95.53 E.00666
; WIPE_START
M204 S6000
G1 X93.122 Y95.806 E-.14509
G1 X93.14 Y95.498 E-.07881
G1 X93.162 Y95.423 E-.02015
G1 X93.204 Y95.372 E-.0167
G1 X93.293 Y95.348 E-.02356
G1 X93.35 Y95.365 E-.01531
G1 X93.618 Y95.53 E-.08037
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X86.107 Y96.885 Z2.76 F18000
G1 X84.86 Y97.11 Z2.76
G1 Z2.36
G1 E.4 F1800
G1 F1500
M204 S500
G1 X84.753 Y96.949 E.0041
G1 X85.105 Y96.544 E.01135
G1 X87.017 Y96.544 E.04046
G1 X87.359 Y96.916 E.0107
G1 X87.253 Y97.081 E.00416
G1 X86.861 Y96.953 E.00874
G1 X86.488 Y96.88 E.00804
G1 X85.958 Y96.856 E.01123
G1 X85.416 Y96.93 E.01157
G1 X84.917 Y97.092 E.01111
; WIPE_START
M204 S6000
G1 X84.753 Y96.949 E-.04131
G1 X85.105 Y96.544 E-.10188
G1 X86.351 Y96.544 E-.23681
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X83.492 Y99.672 Z2.76 F18000
G1 Z2.36
G1 E.4 F1800
G1 F1500
M204 S500
G1 X83.501 Y99.519 E.00323
G1 X83.568 Y99.206 E.00678
G1 X83.654 Y98.947 E.00577
G1 X83.882 Y98.493 E.01076
G1 X84.172 Y98.118 E.01003
G1 X84.515 Y97.809 E.00975
G1 X84.784 Y97.632 E.00683
G1 X85.073 Y97.487 E.00683
G1 X85.511 Y97.345 E.00975
G1 X85.977 Y97.282 E.00995
G1 X86.437 Y97.302 E.00975
G1 X86.754 Y97.365 E.00683
M73 P56 R10
G1 X87.052 Y97.462 E.00663
G1 X87.334 Y97.592 E.00659
G1 X87.567 Y97.734 E.00577
G1 X87.959 Y98.058 E.01076
G1 X88.255 Y98.417 E.00984
G1 X88.42 Y98.694 E.00683
G1 X88.551 Y98.989 E.00683
G1 X88.674 Y99.433 E.00976
G1 X88.716 Y99.901 E.00995
G1 X88.674 Y100.369 E.00995
G1 X88.551 Y100.813 E.00975
G1 X88.421 Y101.106 E.00678
G1 X88.283 Y101.341 E.00577
G1 X87.965 Y101.738 E.01076
G1 X87.611 Y102.039 E.00984
G1 X87.338 Y102.207 E.00679
G1 X87.091 Y102.324 E.00577
G1 X86.605 Y102.473 E.01076
G1 X86.143 Y102.521 E.00984
G1 X85.823 Y102.507 E.00678
G1 X85.553 Y102.464 E.00578
G1 X85.068 Y102.314 E.01076
G1 X84.65 Y102.089 E.01004
G1 X84.283 Y101.796 E.00995
G1 X83.973 Y101.442 E.00995
G1 X83.732 Y101.038 E.00995
G1 X83.57 Y100.607 E.00975
G1 X83.503 Y100.292 E.00683
G1 X83.474 Y99.97 E.00683
G1 X83.489 Y99.731 E.00506
M204 S250
G1 X83.901 Y99.696 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X83.908 Y99.574 E.0024
G1 X83.964 Y99.314 E.00525
G1 X84.033 Y99.105 E.00433
G1 X84.23 Y98.712 E.00865
G1 X84.474 Y98.397 E.00782
G1 X84.766 Y98.134 E.00774
G1 X84.989 Y97.987 E.00526
G1 X85.229 Y97.867 E.00526
G1 X85.602 Y97.746 E.00773
G1 X85.995 Y97.692 E.0078
G1 X86.388 Y97.71 E.00773
G1 X86.65 Y97.762 E.00526
G1 X86.902 Y97.843 E.0052
G1 X87.141 Y97.954 E.00519
G1 X87.329 Y98.069 E.00433
G1 X87.668 Y98.348 E.00864
G1 X87.919 Y98.653 E.00776
G1 X88.056 Y98.883 E.00526
G1 X88.165 Y99.127 E.00526
G1 X88.27 Y99.506 E.00774
G1 X88.305 Y99.901 E.00779
G1 X88.27 Y100.296 E.0078
G1 X88.165 Y100.675 E.00773
G1 X88.057 Y100.918 E.00525
G1 X87.945 Y101.108 E.00433
G1 X87.67 Y101.452 E.00865
G1 X87.369 Y101.707 E.00776
G1 X87.142 Y101.847 E.00525
G1 X86.943 Y101.941 E.00433
G1 X86.523 Y102.07 E.00864
G1 X86.131 Y102.111 E.00776
G1 X85.864 Y102.099 E.00524
G1 X85.647 Y102.065 E.00433
G1 X85.227 Y101.935 E.00864
G1 X84.876 Y101.746 E.00782
G1 X84.567 Y101.499 E.0078
G1 X84.306 Y101.2 E.0078
G1 X84.102 Y100.86 E.0078
G1 X83.964 Y100.492 E.00773
G1 X83.909 Y100.23 E.00526
G1 X83.885 Y99.964 E.00526
G1 X83.897 Y99.756 E.0041
; WIPE_START
M204 S6000
G1 X83.908 Y99.574 E-.03454
G1 X83.964 Y99.314 E-.05069
G1 X84.033 Y99.105 E-.04184
G1 X84.23 Y98.712 E-.08352
G1 X84.474 Y98.397 E-.07556
G1 X84.766 Y98.134 E-.07473
G1 X84.85 Y98.079 E-.01913
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X84.855 Y96.12 Z2.76 F18000
G1 Z2.36
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X92.678 Y96.12 E.16557
G1 X92.718 Y95.441 E.01439
G1 X92.742 Y95.331 E.00238
G1 X92.81 Y95.184 E.00344
G1 X92.887 Y95.09 E.00257
G1 X93.069 Y94.969 E.00463
G1 X93.292 Y94.922 E.00483
G1 X93.525 Y94.974 E.00505
G1 X93.979 Y95.255 E.0113
G1 X95.879 Y94.633 E.04231
G1 X98.51 Y90.875 E.09709
G1 X98.806 Y91.083 E.00765
G1 X96.105 Y94.94 E.09967
G1 X93.24 Y96.218 E.0664
G1 X93.057 Y96.348 E.00474
G1 X92.803 Y96.453 E.00583
G1 X92.559 Y96.482 E.0052
G1 X87.536 Y96.482 E.10631
G1 X88.639 Y97.675 E.03439
G1 X88.889 Y98 E.00869
G1 X89.179 Y98.517 E.01254
G1 X89.326 Y98.91 E.00888
G1 X89.451 Y99.499 E.01274
G1 X89.469 Y100.1 E.01273
G1 X89.399 Y100.603 E.01075
G1 X89.263 Y101.076 E.01041
G1 X89.009 Y101.612 E.01255
G1 X88.661 Y102.1 E.01269
G1 X88.378 Y102.393 E.00862
G1 X88.128 Y102.599 E.00687
G1 X87.738 Y102.855 E.00987
G1 X87.367 Y103.032 E.00869
G1 X86.978 Y103.164 E.00869
G1 X86.386 Y103.269 E.01273
G1 X85.794 Y103.267 E.01254
G1 X85.201 Y103.161 E.01274
G1 X84.715 Y102.985 E.01095
G1 X84.283 Y102.754 E.01036
G1 X83.961 Y102.522 E.0084
G1 X83.666 Y102.251 E.00849
G1 X83.404 Y101.947 E.00849
G1 X83.181 Y101.613 E.0085
G1 X82.998 Y101.256 E.00849
G1 X82.86 Y100.879 E.00849
G1 X82.766 Y100.489 E.0085
G1 X82.72 Y100.091 E.00849
G1 X82.738 Y99.499 E.01253
G1 X82.812 Y99.095 E.00869
G1 X82.931 Y98.711 E.00849
G1 X83.098 Y98.337 E.00869
G1 X83.417 Y97.838 E.01254
G1 X84.597 Y96.482 E.03805
G1 X79.631 Y96.482 E.10513
G1 X79.383 Y96.453 E.00527
G1 X79.238 Y96.405 E.00324
G1 X78.986 Y96.233 E.00646
G1 X78.835 Y96.044 E.00511
G1 X78.743 Y95.815 E.00524
G1 X78.714 Y95.565 E.00533
G1 X78.714 Y77.619 E.37984
G1 X78.753 Y77.349 E.00577
G1 X78.855 Y77.125 E.0052
G1 X78.957 Y76.996 E.00349
G1 X79.056 Y76.907 E.00282
G1 X79.294 Y76.775 E.00576
G1 X79.543 Y76.723 E.00539
G1 X92.598 Y76.721 E.27632
G1 X92.744 Y76.735 E.00311
G1 X92.895 Y76.775 E.0033
G1 X93.124 Y76.904 E.00556
G1 X93.068 Y77.082 E.00395
G1 X80.045 Y77.082 E.27564
G1 X79.776 Y77.125 E.00578
G1 X79.483 Y77.276 E.00698
G1 X79.256 Y77.508 E.00687
G1 X79.112 Y77.801 E.0069
G1 X79.075 Y78.056 E.00546
G1 X79.075 Y95.173 E.3623
G1 X79.16 Y95.529 E.00774
G1 X79.315 Y95.766 E.006
G1 X79.531 Y95.958 E.00611
G1 X79.8 Y96.084 E.00629
G1 X80.049 Y96.12 E.00533
G1 X84.795 Y96.12 E.10045
; WIPE_START
M204 S6000
G1 X86.795 Y96.12 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X83.699 Y96.891 Z2.76 F18000
G1 Z2.36
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X79.607 Y96.891 E.08049
G1 X79.294 Y96.854 E.00619
G1 X79.081 Y96.784 E.00442
G1 X78.955 Y96.721 E.00277
G1 X78.708 Y96.536 E.00607
G1 X78.558 Y96.368 E.00442
G1 X78.478 Y96.247 E.00286
G1 X78.4 Y96.085 E.00353
G1 X78.341 Y95.902 E.00379
G1 X78.304 Y95.589 E.00621
G1 X78.304 Y77.607 E.35368
G1 X78.313 Y77.454 E.00301
G1 X78.359 Y77.231 E.00448
G1 X78.443 Y77.019 E.00448
G1 X78.515 Y76.895 E.00283
G1 X78.657 Y76.715 E.0045
G1 X78.802 Y76.584 E.00385
G1 X78.948 Y76.485 E.00347
G1 X79.153 Y76.389 E.00445
G1 X79.374 Y76.33 E.00448
G1 X79.519 Y76.313 E.00289
G1 X92.618 Y76.312 E.25763
G1 X92.817 Y76.331 E.00394
G1 X93.035 Y76.389 E.00444
G1 X93.239 Y76.484 E.00442
G1 X93.423 Y76.613 E.00442
G1 X93.582 Y76.772 E.00442
G1 X93.711 Y76.956 E.00442
G1 X93.806 Y77.16 E.00442
G1 X93.864 Y77.377 E.00442
G1 X93.884 Y77.61 E.0046
G1 X93.884 Y85.511 E.1554
G1 X94.897 Y85.511 E.01991
G1 F1870.245
G1 X95.027 Y85.511 E.00256
G1 F1320
G1 X95.027 Y87.691 E.04288
G1 F1668.584
G1 X94.897 Y87.691 E.00256
G1 F1500
G1 X93.884 Y87.691 E.01991
G1 X93.884 Y88.791 E.02164
G1 X92.704 Y88.791 E.02321
G1 X92.704 Y77.491 E.22226
G1 X80.078 Y77.491 E.24835
G1 X79.905 Y77.518 E.00344
G1 X79.729 Y77.609 E.00389
G1 X79.595 Y77.747 E.00379
G1 X79.508 Y77.923 E.00387
G1 X79.484 Y78.086 E.00322
G1 X79.484 Y95.125 E.33516
G1 X79.541 Y95.365 E.00484
G1 X79.628 Y95.496 E.0031
G1 X79.758 Y95.612 E.00343
G1 X79.919 Y95.687 E.00349
G1 X80.079 Y95.711 E.00319
G1 X92.292 Y95.711 E.24022
G1 X92.312 Y95.387 E.00639
G1 X92.349 Y95.211 E.00353
G1 X92.417 Y95.044 E.00353
G1 X92.589 Y94.807 E.00577
G1 X92.673 Y94.731 E.00223
G1 X92.924 Y94.584 E.00572
G1 X93.159 Y94.521 E.0048
G1 X93.443 Y94.523 E.00557
G1 X93.694 Y94.598 E.00515
G1 X94.033 Y94.807 E.00783
G1 X95.622 Y94.286 E.03289
G1 X98.41 Y90.305 E.09559
G1 X99.376 Y90.982 E.02321
G1 X96.375 Y95.268 E.10291
G1 X93.444 Y96.575 E.06313
G1 X93.271 Y96.698 E.00416
G1 X93.1 Y96.787 E.00381
G1 X92.891 Y96.855 E.00432
G1 X92.582 Y96.891 E.00611
G1 X88.471 Y96.891 E.08086
G1 X88.952 Y97.411 E.01393
G1 X89.228 Y97.77 E.00891
G1 X89.46 Y98.159 E.00891
G1 X89.555 Y98.356 E.00431
G1 X89.716 Y98.783 E.00897
G1 X89.774 Y98.994 E.00431
G1 X89.856 Y99.443 E.00897
G1 X89.877 Y99.661 E.0043
G1 X89.878 Y100.117 E.00897
G1 X89.798 Y100.694 E.01146
G1 X89.649 Y101.214 E.01064
G1 X89.506 Y101.547 E.00712
G1 X89.362 Y101.82 E.00609
G1 X89.161 Y102.125 E.00718
G1 X88.97 Y102.369 E.00608
G1 X88.656 Y102.694 E.00889
G1 X88.376 Y102.925 E.00715
G1 X87.93 Y103.216 E.01046
G1 X87.522 Y103.412 E.00891
G1 X87.092 Y103.557 E.00892
G1 X86.88 Y103.609 E.00431
G1 X86.429 Y103.676 E.00897
G1 X86.21 Y103.689 E.00431
G1 X85.757 Y103.676 E.00891
G1 X85.309 Y103.608 E.00891
G1 X84.881 Y103.491 E.00874
G1 X84.543 Y103.357 E.00715
G1 X84.067 Y103.102 E.01062
G1 X83.703 Y102.84 E.00882
G1 X83.371 Y102.536 E.00885
M73 P57 R10
G1 X83.078 Y102.195 E.00885
G1 X82.827 Y101.821 E.00885
G1 X82.623 Y101.42 E.00885
G1 X82.467 Y100.998 E.00885
G1 X82.363 Y100.56 E.00885
G1 X82.311 Y100.113 E.00885
G1 X82.312 Y99.661 E.00891
G1 X82.332 Y99.443 E.0043
G1 X82.414 Y98.997 E.00891
G1 X82.547 Y98.567 E.00885
G1 X82.732 Y98.153 E.00891
G1 X82.838 Y97.962 E.0043
G1 X83.093 Y97.588 E.00891
G1 X83.659 Y96.936 E.01698
; WIPE_START
M204 S6000
G1 X81.66 Y96.914 E-.38
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




G1 X79.578 Y96.239
G1 Z2.36
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.105447
G1 F1500
M204 S6000
G1 X79.379 Y96.175 E.00083
; LINE_WIDTH: 0.153406
G1 X79.177 Y96.022 E.00161
G1 X79.106 Y95.951 E.00064
G1 X79.034 Y95.833 E.00088
; LINE_WIDTH: 0.127508
G1 X78.996 Y95.74 E.00051
; LINE_WIDTH: 0.0941348
G1 X78.957 Y95.646 E.00034
; WIPE_START
G1 X78.996 Y95.74 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X84.642 Y97.165 Z2.76 F18000
G1 Z2.36
G1 E.4 F1800
; LINE_WIDTH: 0.477116
G1 F1500
M204 S6000
G1 X84.461 Y97.319 E.00533
; LINE_WIDTH: 0.43843
G1 X84.254 Y97.496 E.00561
; LINE_WIDTH: 0.40064
G1 X84.08 Y97.673 E.00465
; LINE_WIDTH: 0.360193
G1 X83.886 Y97.872 E.00464
G1 X83.555 Y98.305 E.0091
G1 X83.301 Y98.813 E.00948
G1 X83.201 Y99.116 E.00531
G1 X83.118 Y99.545 E.00731
G1 X83.099 Y99.988 E.00739
G1 X83.131 Y100.358 E.00619
G1 X83.225 Y100.769 E.00704
G1 X83.387 Y101.189 E.0075
G1 X83.66 Y101.652 E.00897
G1 X83.941 Y101.985 E.00727
G1 X84.204 Y102.224 E.00593
G1 X84.485 Y102.431 E.00582
G1 X84.908 Y102.655 E.00798
G1 X85.302 Y102.789 E.00696
G1 X85.828 Y102.888 E.00892
G1 X86.349 Y102.886 E.0087
G1 X86.695 Y102.836 E.00583
G1 X87.224 Y102.68 E.0092
G1 X87.555 Y102.521 E.00612
G1 X87.899 Y102.294 E.00687
G1 X88.246 Y101.989 E.00772
G1 X88.587 Y101.565 E.00908
G1 X88.793 Y101.206 E.0069
G1 X88.906 Y100.948 E.00469
G1 X89.046 Y100.422 E.0091
G1 X89.09 Y99.915 E.00848
G1 X89.044 Y99.38 E.00896
G1 X88.96 Y99.026 E.00608
G1 X88.762 Y98.528 E.00894
G1 X88.572 Y98.209 E.0062
G1 X88.217 Y97.778 E.00932
; LINE_WIDTH: 0.37905
G1 X88.018 Y97.591 E.00481
; LINE_WIDTH: 0.418628
G1 X87.793 Y97.38 E.00605
; LINE_WIDTH: 0.455597
G1 X87.634 Y97.254 E.00434
; LINE_WIDTH: 0.481757
G1 X87.475 Y97.128 E.00461
; WIPE_START
G1 X87.634 Y97.254 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X94.041 Y95.542 Z2.76 F18000
G1 Z2.36
G1 E.4 F1800
; LINE_WIDTH: 0.15125
G1 F1500
M204 S6000
G1 X94.529 Y95.353 E.00327
; LINE_WIDTH: 0.103582
G1 X95.017 Y95.165 E.00203
; WIPE_START
G1 X94.529 Y95.353 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X94.052 Y87.736 Z2.76 F18000
G1 X93.981 Y86.601 Z2.76
G1 Z2.36
G1 E.4 F1800
; LINE_WIDTH: 0.114562
G1 F1500
M204 S6000
G1 X93.75 Y86.601 E.00102
; WIPE_START
G1 X93.981 Y86.601 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X87.642 Y82.35 Z2.76 F18000
G1 X79.596 Y76.955 Z2.76
G1 Z2.36
G1 E.4 F1800
; LINE_WIDTH: 0.0895478
G1 F1500
M204 S6000
G1 X79.49 Y76.991 E.00036
; LINE_WIDTH: 0.12845
G1 X79.289 Y77.081 E.00113
; LINE_WIDTH: 0.153063
G1 X79.058 Y77.32 E.00211
G1 X79.005 Y77.423 E.00073
; LINE_WIDTH: 0.101459
G1 X78.949 Y77.604 E.00071
; WIPE_START
G1 X79.005 Y77.423 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X85.908 Y80.68 Z2.76 F18000
G1 X100.371 Y87.504 Z2.76
G1 Z2.36
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X100.647 Y87.111 E.00944
G1 X100.977 Y87.342 E.00793
G1 X101.613 Y87.787 E.01528
G1 X101.338 Y88.181 E.00944
G1 X100.42 Y87.538 E.02203
M204 S10000
G1 X100.676 Y87.424 F18000
; FEATURE: Gap infill
; LINE_WIDTH: 0.0965101
G1 F1500
M204 S6000
G1 X101.308 Y87.867 E.00272
; CHANGE_LAYER
; Z_HEIGHT: 2.48
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F1500
G1 X100.676 Y87.424 E-.38
; WIPE_END
G1 E-.02 F1800
; layer num/total_layer_count: 22/57
; update layer progress
M73 L22
M991 S0 P21 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z2.76 I.205 J-1.2 P1  F18000
G1 X94.365 Y86.344 Z2.76
G1 Z2.48
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X94.365 Y86.857 E.01086
G1 X93.538 Y86.857 E.0175
G1 X93.538 Y86.344 E.01086
G1 X94.305 Y86.344 E.01623
M204 S10000
G1 X94.789 Y85.92 F18000
G1 F1500
M204 S500
G1 X94.789 Y87.282 E.02882
G1 X93.475 Y87.282 E.02781
G1 X93.475 Y88.382 E.02328
G1 X93.114 Y88.382 E.00765
G1 X93.114 Y77.127 E.23821
G1 X93.292 Y77.071 E.00395
G1 X93.355 Y77.162 E.00234
G1 X93.42 Y77.3 E.00324
G1 X93.459 Y77.448 E.00324
G1 X93.475 Y77.628 E.00381
G1 X93.475 Y85.92 E.17551
G1 X94.729 Y85.92 E.02654
; WIPE_START
M204 S6000
G1 X94.789 Y87.282 E-.25894
G1 X94.152 Y87.282 E-.12106
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X93.698 Y94.901 Z2.88 F18000
G1 X93.658 Y95.567 Z2.88
G1 Z2.48
G1 E.4 F1800
G1 F1500
M204 S500
G1 X93.122 Y95.806 E.01244
G1 X93.14 Y95.498 E.00653
G1 X93.166 Y95.414 E.00187
G1 X93.212 Y95.37 E.00135
G1 X93.296 Y95.347 E.00183
G1 X93.369 Y95.368 E.00162
G1 X93.609 Y95.533 E.00615
; WIPE_START
M204 S6000
G1 X93.122 Y95.806 E-.14412
G1 X93.14 Y95.498 E-.0796
G1 X93.166 Y95.414 E-.02278
G1 X93.212 Y95.37 E-.01641
G1 X93.296 Y95.347 E-.02236
G1 X93.369 Y95.368 E-.01976
G1 X93.609 Y95.533 E-.07498
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X86.1 Y96.9 Z2.88 F18000
G1 X84.856 Y97.126 Z2.88
G1 Z2.48
G1 E.4 F1800
G1 F1500
M204 S500
G1 X84.741 Y96.963 E.00423
G1 X85.105 Y96.544 E.01174
G1 X87.067 Y96.544 E.04153
G1 X87.413 Y96.936 E.01106
G1 X87.306 Y97.098 E.00411
G1 X86.861 Y96.953 E.00992
G1 X86.488 Y96.88 E.00804
G1 X85.973 Y96.857 E.0109
G1 X85.596 Y96.897 E.00804
G1 X85.225 Y96.981 E.00804
G1 X84.912 Y97.104 E.00712
; WIPE_START
M204 S6000
G1 X84.741 Y96.963 E-.04213
G1 X85.105 Y96.544 E-.1054
G1 X86.329 Y96.544 E-.23247
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X83.492 Y99.679 Z2.88 F18000
G1 Z2.48
G1 E.4 F1800
G1 F1500
M204 S500
G1 X83.502 Y99.51 E.00359
G1 X83.613 Y99.054 E.00995
G1 X83.801 Y98.633 E.00975
G1 X83.974 Y98.361 E.00683
G1 X84.182 Y98.108 E.00692
G1 X84.567 Y97.771 E.01083
G1 X84.924 Y97.555 E.00884
G1 X85.351 Y97.388 E.00969
G1 X85.665 Y97.316 E.00683
G1 X85.986 Y97.282 E.00683
G1 X86.437 Y97.302 E.00955
G1 X86.754 Y97.365 E.00683
G1 X87.061 Y97.465 E.00683
G1 X87.473 Y97.671 E.00975
G1 X87.849 Y97.953 E.00995
G1 X88.16 Y98.289 E.0097
G1 X88.314 Y98.51 E.00571
G1 X88.491 Y98.839 E.0079
G1 X88.638 Y99.27 E.00965
G1 X88.696 Y99.588 E.00683
G1 X88.715 Y99.91 E.00683
G1 X88.674 Y100.369 E.00975
G1 X88.547 Y100.828 E.01008
G1 X88.297 Y101.323 E.01175
G1 X87.965 Y101.738 E.01123
G1 X87.599 Y102.049 E.01018
G1 X87.113 Y102.317 E.01175
G1 X86.605 Y102.473 E.01123
G1 X86.127 Y102.523 E.01018
G1 X85.575 Y102.471 E.01175
G1 X85.068 Y102.314 E.01123
G1 X84.65 Y102.089 E.01004
G1 X84.283 Y101.796 E.00995
G1 X83.98 Y101.449 E.00975
G1 X83.806 Y101.177 E.00683
G1 X83.666 Y100.886 E.00683
G1 X83.53 Y100.446 E.00975
G1 X83.474 Y99.979 E.00995
G1 X83.488 Y99.739 E.00509
M204 S250
G1 X83.9 Y99.704 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X83.908 Y99.571 E.00261
G1 X84.002 Y99.186 E.0078
G1 X84.162 Y98.827 E.00773
G1 X84.306 Y98.602 E.00526
G1 X84.477 Y98.394 E.00529
G1 X84.81 Y98.103 E.0087
G1 X85.106 Y97.923 E.00682
G1 X85.471 Y97.78 E.00771
G1 X85.732 Y97.72 E.00526
G1 X85.998 Y97.692 E.00526
G1 X86.388 Y97.71 E.00767
G1 X86.651 Y97.762 E.00526
G1 X86.905 Y97.844 E.00526
G1 X87.257 Y98.02 E.00773
G1 X87.574 Y98.258 E.00779
G1 X87.841 Y98.545 E.00772
G1 X87.965 Y98.725 E.00428
G1 X88.115 Y99.003 E.00622
G1 X88.241 Y99.374 E.0077
G1 X88.289 Y99.637 E.00526
G1 X88.305 Y99.904 E.00526
G1 X88.27 Y100.296 E.00773
G1 X88.164 Y100.68 E.00784
G1 X87.95 Y101.101 E.00929
G1 X87.67 Y101.451 E.00882
G1 X87.365 Y101.71 E.00787
G1 X86.952 Y101.938 E.00928
G1 X86.523 Y102.07 E.00882
G1 X86.125 Y102.112 E.00787
G1 X85.655 Y102.067 E.00929
G1 X85.227 Y101.935 E.00882
G1 X84.877 Y101.746 E.00782
G1 X84.567 Y101.499 E.0078
G1 X84.308 Y101.203 E.00773
G1 X84.164 Y100.977 E.00526
G1 X84.048 Y100.736 E.00526
G1 X83.932 Y100.361 E.00773
G1 X83.885 Y99.967 E.0078
G1 X83.897 Y99.764 E.00401
; WIPE_START
M204 S6000
G1 X83.908 Y99.571 E-.03661
G1 X84.002 Y99.186 E-.0753
G1 X84.162 Y98.827 E-.07471
G1 X84.306 Y98.602 E-.05083
G1 X84.477 Y98.394 E-.0511
G1 X84.81 Y98.103 E-.08402
G1 X84.843 Y98.082 E-.00743
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X84.855 Y96.12 Z2.88 F18000
G1 Z2.48
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X92.678 Y96.12 E.16557
G1 X92.718 Y95.441 E.01439
G1 X92.742 Y95.331 E.00238
G1 X92.784 Y95.227 E.00238
G1 X92.851 Y95.128 E.00253
G1 X92.932 Y95.05 E.00238
G1 X93.063 Y94.97 E.00324
G1 X93.293 Y94.922 E.00499
G1 X93.534 Y94.974 E.0052
G1 X93.961 Y95.261 E.0109
G1 X95.879 Y94.633 E.04271
G1 X98.51 Y90.875 E.09709
G1 X98.806 Y91.083 E.00765
G1 X96.105 Y94.94 E.09967
G1 X93.244 Y96.216 E.0663
G1 X93.021 Y96.37 E.00573
G1 X92.803 Y96.453 E.00495
G1 X92.559 Y96.482 E.0052
G1 X87.578 Y96.482 E.10543
G1 X88.722 Y97.777 E.03657
G1 X88.887 Y97.997 E.00583
G1 X89.099 Y98.353 E.00877
G1 X89.323 Y98.901 E.01254
G1 X89.45 Y99.489 E.01273
G1 X89.469 Y100.084 E.01259
G1 X89.397 Y100.608 E.01119
G1 X89.263 Y101.076 E.01031
G1 X89.009 Y101.612 E.01255
G1 X88.661 Y102.1 E.01269
G1 X88.378 Y102.393 E.00863
G1 X88.131 Y102.596 E.00677
G1 X87.738 Y102.855 E.00997
G1 X87.367 Y103.032 E.00869
G1 X86.978 Y103.164 E.00869
G1 X86.386 Y103.269 E.01273
G1 X85.794 Y103.267 E.01254
G1 X85.217 Y103.165 E.01241
G1 X84.711 Y102.982 E.01139
G1 X84.283 Y102.754 E.01025
G1 X83.961 Y102.522 E.0084
G1 X83.666 Y102.251 E.00849
G1 X83.404 Y101.947 E.00849
G1 X83.181 Y101.613 E.0085
G1 X82.998 Y101.256 E.00849
G1 X82.86 Y100.879 E.00849
G1 X82.768 Y100.495 E.00836
G1 X82.718 Y99.969 E.01119
G1 X82.741 Y99.485 E.01026
G1 X82.814 Y99.086 E.00859
G1 X83.007 Y98.526 E.01253
G1 X83.192 Y98.17 E.0085
G1 X83.417 Y97.838 E.00849
G1 X84.597 Y96.482 E.03805
G1 X79.631 Y96.482 E.10513
G1 X79.392 Y96.454 E.00508
G1 X79.188 Y96.38 E.00459
G1 X79.096 Y96.324 E.00227
G1 X78.909 Y96.151 E.00539
G1 X78.832 Y96.039 E.00288
G1 X78.743 Y95.815 E.0051
G1 X78.714 Y95.565 E.00533
G1 X78.714 Y77.625 E.37971
G1 X78.753 Y77.344 E.006
G1 X78.861 Y77.118 E.0053
G1 X79.055 Y76.908 E.00606
G1 X79.294 Y76.775 E.00579
G1 X79.543 Y76.723 E.00539
G1 X92.6 Y76.721 E.27635
G1 X92.744 Y76.735 E.00307
G1 X92.895 Y76.775 E.0033
G1 X93.124 Y76.904 E.00557
G1 X93.068 Y77.082 E.00395
G1 X80.04 Y77.082 E.27574
G1 X79.752 Y77.132 E.0062
G1 X79.474 Y77.282 E.00668
G1 X79.241 Y77.529 E.00717
G1 X79.112 Y77.807 E.00649
G1 X79.075 Y78.056 E.00533
G1 X79.075 Y95.177 E.36239
G1 X79.169 Y95.553 E.0082
G1 X79.345 Y95.799 E.00641
G1 X79.539 Y95.962 E.00535
G1 X79.8 Y96.084 E.0061
G1 X80.049 Y96.12 E.00533
G1 X84.795 Y96.12 E.10045
; WIPE_START
M204 S6000
G1 X86.795 Y96.12 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X83.699 Y96.891 Z2.88 F18000
G1 Z2.48
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X79.607 Y96.891 E.08049
G1 X79.297 Y96.855 E.00613
G1 X79.012 Y96.751 E.00597
G1 X78.862 Y96.661 E.00344
G1 X78.709 Y96.538 E.00385
G1 X78.588 Y96.406 E.00352
G1 X78.477 Y96.245 E.00385
G1 X78.399 Y96.084 E.00352
G1 X78.341 Y95.902 E.00376
G1 X78.304 Y95.589 E.00621
G1 X78.304 Y77.609 E.35364
G1 X78.32 Y77.406 E.004
G1 X78.359 Y77.23 E.00356
G1 X78.409 Y77.093 E.00286
G1 X78.517 Y76.892 E.00448
G1 X78.657 Y76.715 E.00444
G1 X78.801 Y76.585 E.00382
G1 X78.948 Y76.485 E.0035
G1 X79.154 Y76.389 E.00445
G1 X79.374 Y76.33 E.00448
G1 X79.519 Y76.313 E.00289
G1 X92.619 Y76.312 E.25767
G1 X92.817 Y76.331 E.00391
G1 X93.035 Y76.389 E.00444
G1 X93.239 Y76.484 E.00442
G1 X93.423 Y76.613 E.00442
G1 X93.582 Y76.772 E.00442
G1 X93.711 Y76.956 E.00442
G1 X93.806 Y77.16 E.00442
G1 X93.864 Y77.377 E.00442
G1 X93.884 Y77.61 E.0046
G1 X93.884 Y85.511 E.1554
G1 X95.068 Y85.511 E.02328
G1 F1870.275
G1 X95.198 Y85.511 E.00256
G1 F1320
G1 X95.198 Y87.691 E.04288
G1 F1668.612
G1 X95.068 Y87.691 E.00256
G1 F1500
G1 X93.884 Y87.691 E.02328
G1 X93.884 Y88.791 E.02164
G1 X92.704 Y88.791 E.02321
G1 X92.704 Y77.491 E.22226
G1 X80.076 Y77.491 E.24839
M73 P58 R10
G1 X79.888 Y77.524 E.00376
G1 X79.726 Y77.611 E.00361
G1 X79.584 Y77.762 E.00407
G1 X79.508 Y77.925 E.00355
G1 X79.484 Y78.086 E.00319
G1 X79.484 Y95.127 E.33518
G1 X79.547 Y95.378 E.0051
G1 X79.648 Y95.519 E.0034
G1 X79.761 Y95.614 E.0029
G1 X79.919 Y95.687 E.00343
G1 X80.079 Y95.711 E.00318
G1 X92.292 Y95.711 E.24022
G1 X92.312 Y95.387 E.00639
G1 X92.349 Y95.211 E.00353
G1 X92.416 Y95.044 E.00353
G1 X92.545 Y94.855 E.0045
G1 X92.674 Y94.73 E.00353
G1 X92.922 Y94.585 E.00565
G1 X93.159 Y94.521 E.00484
G1 X93.444 Y94.523 E.0056
G1 X93.68 Y94.59 E.00483
G1 X93.777 Y94.637 E.00213
G1 X94.027 Y94.809 E.00595
G1 X95.622 Y94.286 E.03302
G1 X98.41 Y90.305 E.09559
G1 X99.376 Y90.982 E.02321
G1 X96.375 Y95.268 E.10291
G1 X93.445 Y96.575 E.0631
G1 X93.229 Y96.723 E.00516
G1 X93.102 Y96.786 E.00279
G1 X92.891 Y96.855 E.00436
G1 X92.582 Y96.891 E.00611
G1 X88.485 Y96.891 E.08058
G1 X89.039 Y97.518 E.01645
G1 X89.227 Y97.769 E.00617
G1 X89.46 Y98.159 E.00894
G1 X89.555 Y98.356 E.00431
G1 X89.715 Y98.78 E.00891
G1 X89.823 Y99.22 E.00891
G1 X89.877 Y99.661 E.00873
G1 X89.878 Y100.111 E.00886
G1 X89.798 Y100.693 E.01154
G1 X89.649 Y101.214 E.01066
G1 X89.508 Y101.542 E.00703
G1 X89.362 Y101.821 E.00619
G1 X89.163 Y102.121 E.00709
G1 X88.97 Y102.369 E.00617
G1 X88.656 Y102.694 E.00889
G1 X88.379 Y102.922 E.00706
G1 X87.93 Y103.216 E.01056
G1 X87.521 Y103.412 E.00891
G1 X87.092 Y103.557 E.00891
G1 X86.88 Y103.609 E.00431
G1 X86.429 Y103.676 E.00897
G1 X86.21 Y103.689 E.00431
G1 X85.757 Y103.676 E.00891
G1 X85.309 Y103.608 E.00891
G1 X85.098 Y103.557 E.00427
G1 X84.544 Y103.357 E.0116
G1 X84.067 Y103.102 E.01064
G1 X83.703 Y102.84 E.00882
G1 X83.371 Y102.536 E.00885
G1 X83.078 Y102.195 E.00885
G1 X82.827 Y101.821 E.00885
G1 X82.623 Y101.42 E.00885
G1 X82.467 Y100.998 E.00885
G1 X82.363 Y100.563 E.00881
G1 X82.307 Y99.979 E.01153
G1 X82.333 Y99.438 E.01065
G1 X82.415 Y98.994 E.00888
G1 X82.473 Y98.783 E.00431
G1 X82.633 Y98.359 E.00891
G1 X82.84 Y97.96 E.00885
G1 X83.093 Y97.588 E.00885
G1 X83.66 Y96.936 E.01698
; WIPE_START
M204 S6000
G1 X81.66 Y96.914 E-.38
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




G1 X79.578 Y96.239
G1 Z2.48
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.102652
G1 F1500
M204 S6000
G1 X79.394 Y96.179 E.00074
; LINE_WIDTH: 0.152973
G1 X79.147 Y95.994 E.00196
G1 X78.941 Y95.675 E.00241
; WIPE_START
G1 X79.147 Y95.994 E-.20982
G1 X79.394 Y96.179 E-.17018
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X84.63 Y97.174 Z2.88 F18000
G1 Z2.48
G1 E.4 F1800
; LINE_WIDTH: 0.46344
G1 F1500
M204 S6000
G1 X84.334 Y97.422 E.00844
; LINE_WIDTH: 0.435493
G1 X84.308 Y97.447 E.00074
; LINE_WIDTH: 0.412838
G1 X84.114 Y97.641 E.0053
; LINE_WIDTH: 0.360298
G1 X83.72 Y98.071 E.00974
G1 X83.52 Y98.365 E.00594
G1 X83.359 Y98.68 E.0059
G1 X83.188 Y99.177 E.00877
G1 X83.12 Y99.529 E.00597
G1 X83.099 Y100.005 E.00796
G1 X83.158 Y100.51 E.00848
G1 X83.319 Y101.036 E.00917
G1 X83.481 Y101.37 E.0062
G1 X83.708 Y101.716 E.00691
G1 X84.033 Y102.078 E.00813
G1 X84.455 Y102.412 E.00898
G1 X84.908 Y102.654 E.00858
G1 X85.322 Y102.795 E.0073
G1 X85.828 Y102.882 E.00856
G1 X86.113 Y102.896 E.00477
G1 X86.349 Y102.886 E.00394
G1 X86.876 Y102.792 E.00893
G1 X87.275 Y102.658 E.00703
G1 X87.825 Y102.349 E.01052
G1 X88.117 Y102.111 E.00629
G1 X88.368 Y101.85 E.00604
G1 X88.678 Y101.417 E.00889
G1 X88.906 Y100.949 E.00869
G1 X89.04 Y100.45 E.00862
G1 X89.086 Y100.061 E.00654
G1 X89.072 Y99.536 E.00877
G1 X88.998 Y99.165 E.00632
G1 X88.829 Y98.677 E.00861
G1 X88.641 Y98.321 E.00672
G1 X88.448 Y98.042 E.00566
G1 X88.096 Y97.654 E.00874
; LINE_WIDTH: 0.393761
G1 X87.971 Y97.538 E.00313
; LINE_WIDTH: 0.428444
G1 X87.846 Y97.423 E.00342
; LINE_WIDTH: 0.465681
G1 X87.706 Y97.295 E.00417
G1 X87.379 Y97.374 E.00739
; WIPE_START
G1 X87.706 Y97.295 E-.24299
G1 X87.846 Y97.423 E-.13701
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X94.012 Y95.553 Z2.88 F18000
G1 Z2.48
G1 E.4 F1800
; LINE_WIDTH: 0.153725
G1 F1500
M204 S6000
G1 X94.514 Y95.359 E.00344
; LINE_WIDTH: 0.104407
G1 X95.017 Y95.165 E.00211
; WIPE_START
G1 X94.514 Y95.359 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X94.199 Y87.733 Z2.88 F18000
G1 X94.153 Y86.601 Z2.88
G1 Z2.48
G1 E.4 F1800
; LINE_WIDTH: 0.114562
G1 F1500
M204 S6000
G1 X93.75 Y86.601 E.00178
; WIPE_START
G1 X94.153 Y86.601 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X87.79 Y82.386 Z2.88 F18000
G1 X79.591 Y76.955 Z2.88
G1 Z2.48
G1 E.4 F1800
; LINE_WIDTH: 0.0897731
G1 F1500
M204 S6000
G1 X79.487 Y76.991 E.00035
; LINE_WIDTH: 0.129382
G1 X79.289 Y77.08 E.00112
; LINE_WIDTH: 0.154191
G1 X79.167 Y77.191 E.00106
G1 X79.019 Y77.388 E.00158
; LINE_WIDTH: 0.0998212
G1 X78.951 Y77.597 E.00081
; WIPE_START
G1 X79.019 Y77.388 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X85.917 Y80.655 Z2.88 F18000
G1 X100.371 Y87.504 Z2.88
G1 Z2.48
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X100.647 Y87.111 E.00944
G1 X101.003 Y87.36 E.00856
G1 X101.613 Y87.787 E.01465
G1 X101.338 Y88.181 E.00944
G1 X100.42 Y87.538 E.02203
M204 S10000
G1 X100.676 Y87.424 F18000
; FEATURE: Gap infill
; LINE_WIDTH: 0.0965134
G1 F1500
M204 S6000
G1 X101.308 Y87.867 E.00272
; CHANGE_LAYER
; Z_HEIGHT: 2.51
; LAYER_HEIGHT: 0.03
; WIPE_START
G1 F1500
G1 X100.676 Y87.424 E-.38
; WIPE_END
G1 E-.02 F1800
; layer num/total_layer_count: 23/57
; update layer progress
M73 L23
M991 S0 P22 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z2.88 I-1.178 J-.306 P1  F18000
G1 X99.967 Y90.161 Z2.88
G1 Z2.51
G1 E.4 F1800
; FEATURE: Support
; LINE_WIDTH: 0.42
; LAYER_HEIGHT: 0.21
G1 F1500
M204 S6000
G1 X99.85 Y90.328 E.00667
G1 X99.381 Y90 E.01874
G1 X100.08 Y90 E.02287
G1 X100.885 Y88.849 E.04599
G1 X99.898 Y88.157 E.03948
G1 X98.862 Y89.637 E.05911
G1 X99.219 Y89.887 E.01429
; WIPE_START
G1 X98.862 Y89.637 E-.08292
G1 X99.759 Y88.356 E-.29708
; WIPE_END
G1 E-.02 F1800
M204 S10000
G17
G3 Z2.91 I1.217 J0 P1  F18000
;===================== date: 20250206 =====================

; don't support timelapse gcode in spiral_mode and by object sequence for I3 structure printer
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
G92 E0
G1 Z2.91
G1 X0 Y90 ; move to safe pos
G1 X-13.0 F3000 ; move to safe pos
M400
M1004 S5 P1  ; external shutter
M400 P300
M971 S11 C11 O0
G92 E0
G1 X0 F18000
M623

; SKIPTYPE: head_wrap_detect
M622.1 S1
M1002 judge_flag g39_3rd_layer_detect_flag
M622 J1
    ; enable nozzle clog detect at 3rd layer
    


    M622.1 S1
    M1002 judge_flag g39_detection_flag
    M622 J1
      
        M622.1 S0
        M1002 judge_flag g39_mass_exceed_flag
        M622 J1
        
            G392 S0
            M400
            G90
            M83
            M204 S5000
            G0 Z2.91 F4000
            G39.3 S1
            G0 Z2.91 F4000
            G392 S0
          
        M623
    
    M623
M623
; SKIPPABLE_END




; CHANGE_LAYER
; Z_HEIGHT: 2.6
; LAYER_HEIGHT: 0.0899999
; layer num/total_layer_count: 24/57
; update layer progress
M73 L24
M991 S0 P23 ;notify layer change
; OBJECT_ID: 8
G1 X94.536 Y86.344
G1 Z2.6
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
; LAYER_HEIGHT: 0.12
G1 F1500
M204 S500
G1 X94.536 Y86.857 E.01086
G1 X93.538 Y86.857 E.02113
G1 X93.538 Y86.344 E.01086
G1 X94.476 Y86.344 E.01986
M204 S10000
G1 X94.96 Y85.92 F18000
G1 F1500
M204 S500
G1 X94.96 Y87.282 E.02882
G1 X93.475 Y87.282 E.03144
G1 X93.475 Y88.382 E.02328
G1 X93.114 Y88.382 E.00765
G1 X93.114 Y77.127 E.23821
G1 X93.292 Y77.071 E.00395
G1 X93.355 Y77.162 E.00234
G1 X93.42 Y77.3 E.00324
G1 X93.459 Y77.448 E.00324
G1 X93.475 Y77.628 E.00382
G1 X93.475 Y85.92 E.17551
G1 X94.9 Y85.92 E.03017
; WIPE_START
M204 S6000
G1 X94.96 Y87.282 E-.25894
G1 X94.323 Y87.282 E-.12106
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X93.71 Y94.889 Z3 F18000
G1 X93.656 Y95.568 Z3
G1 Z2.6
G1 E.4 F1800
G1 F1500
M204 S500
G1 X93.122 Y95.806 E.01238
G1 X93.14 Y95.498 E.00653
G1 X93.166 Y95.414 E.00186
G1 X93.212 Y95.37 E.00135
G1 X93.295 Y95.347 E.00183
G1 X93.373 Y95.369 E.00169
G1 X93.607 Y95.534 E.00605
; WIPE_START
M204 S6000
G1 X93.122 Y95.806 E-.14388
G1 X93.14 Y95.498 E-.07983
G1 X93.166 Y95.414 E-.02277
G1 X93.212 Y95.37 E-.01648
G1 X93.295 Y95.347 E-.02238
G1 X93.373 Y95.369 E-.0207
G1 X93.607 Y95.534 E-.07396
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X86.095 Y96.888 Z3 F18000
G1 X84.86 Y97.11 Z3
G1 Z2.6
G1 E.4 F1800
G1 F1500
M204 S500
G1 X84.753 Y96.949 E.0041
G1 X85.105 Y96.544 E.01135
G1 X87.017 Y96.544 E.04046
G1 X87.359 Y96.916 E.0107
G1 X87.253 Y97.081 E.00416
G1 X86.861 Y96.953 E.00874
G1 X86.488 Y96.88 E.00804
G1 X85.958 Y96.856 E.01123
G1 X85.416 Y96.93 E.01157
G1 X84.917 Y97.092 E.01111
; WIPE_START
M204 S6000
G1 X84.753 Y96.949 E-.04131
G1 X85.105 Y96.544 E-.10187
G1 X86.351 Y96.544 E-.23681
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X83.491 Y99.691 Z3 F18000
G1 Z2.6
G1 E.4 F1800
G1 F1500
M204 S500
G1 X83.502 Y99.51 E.00384
G1 X83.613 Y99.054 E.00995
G1 X83.801 Y98.633 E.00975
G1 X83.975 Y98.361 E.00683
G1 X84.179 Y98.111 E.00683
G1 X84.515 Y97.809 E.00956
G1 X84.784 Y97.632 E.00683
M73 P59 R10
G1 X85.073 Y97.487 E.00683
G1 X85.511 Y97.345 E.00975
G1 X85.977 Y97.282 E.00995
G1 X86.437 Y97.302 E.00975
G1 X86.754 Y97.365 E.00683
G1 X87.061 Y97.465 E.00683
G1 X87.473 Y97.671 E.00975
G1 X87.849 Y97.953 E.00995
G1 X88.162 Y98.29 E.00975
G1 X88.344 Y98.557 E.00683
G1 X88.493 Y98.843 E.00683
G1 X88.638 Y99.27 E.00955
G1 X88.696 Y99.588 E.00683
G1 X88.715 Y99.901 E.00663
G1 X88.696 Y100.214 E.00663
G1 X88.638 Y100.531 E.00683
G1 X88.49 Y100.967 E.00975
G1 X88.261 Y101.378 E.00995
G1 X87.962 Y101.741 E.00995
G1 X87.599 Y102.049 E.01008
G1 X87.115 Y102.316 E.01169
G1 X86.606 Y102.473 E.01128
G1 X86.128 Y102.523 E.01018
G1 X85.577 Y102.471 E.0117
G1 X85.068 Y102.314 E.01128
G1 X84.65 Y102.089 E.01005
G1 X84.283 Y101.796 E.00995
G1 X83.969 Y101.437 E.01008
G1 X83.695 Y100.958 E.0117
G1 X83.53 Y100.451 E.01128
G1 X83.474 Y99.979 E.01004
G1 X83.488 Y99.751 E.00484
M204 S250
G1 X83.9 Y99.716 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X83.908 Y99.571 E.00284
G1 X84.002 Y99.186 E.0078
G1 X84.162 Y98.827 E.00773
G1 X84.306 Y98.602 E.00526
G1 X84.476 Y98.395 E.00526
G1 X84.766 Y98.134 E.00767
G1 X84.989 Y97.987 E.00526
G1 X85.229 Y97.867 E.00526
G1 X85.602 Y97.745 E.00773
G1 X85.995 Y97.692 E.0078
G1 X86.388 Y97.71 E.00773
G1 X86.651 Y97.762 E.00526
G1 X86.905 Y97.844 E.00526
G1 X87.257 Y98.02 E.00774
G1 X87.574 Y98.258 E.00779
G1 X87.841 Y98.546 E.00774
G1 X87.992 Y98.767 E.00526
G1 X88.115 Y99.005 E.00527
G1 X88.241 Y99.374 E.00767
G1 X88.289 Y99.637 E.00526
G1 X88.305 Y99.901 E.0052
G1 X88.289 Y100.165 E.0052
G1 X88.241 Y100.428 E.00526
G1 X88.114 Y100.8 E.00773
G1 X87.921 Y101.146 E.0078
G1 X87.669 Y101.452 E.00779
G1 X87.365 Y101.71 E.00784
G1 X86.954 Y101.937 E.00924
G1 X86.523 Y102.07 E.00887
G1 X86.125 Y102.112 E.00787
G1 X85.658 Y102.068 E.00924
G1 X85.227 Y101.935 E.00887
G1 X84.876 Y101.746 E.00783
G1 X84.567 Y101.499 E.0078
G1 X84.304 Y101.199 E.00784
G1 X84.071 Y100.791 E.00924
G1 X83.932 Y100.362 E.00887
G1 X83.885 Y99.967 E.00783
G1 X83.896 Y99.776 E.00377
; WIPE_START
M204 S6000
G1 X83.908 Y99.571 E-.03888
G1 X84.002 Y99.186 E-.0753
G1 X84.162 Y98.827 E-.07471
G1 X84.306 Y98.602 E-.05084
G1 X84.476 Y98.395 E-.0508
G1 X84.766 Y98.134 E-.07412
G1 X84.833 Y98.09 E-.01534
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X84.855 Y96.12 Z3 F18000
G1 Z2.6
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X92.678 Y96.12 E.16557
G1 X92.718 Y95.441 E.01439
G1 X92.742 Y95.331 E.00238
G1 X92.784 Y95.227 E.00238
G1 X92.851 Y95.128 E.00252
G1 X92.932 Y95.05 E.00238
G1 X93.063 Y94.97 E.00324
G1 X93.294 Y94.922 E.00501
G1 X93.529 Y94.972 E.00508
G1 X93.958 Y95.262 E.01095
G1 X95.879 Y94.633 E.04279
G1 X98.51 Y90.875 E.09709
G1 X98.806 Y91.083 E.00765
G1 X96.105 Y94.94 E.09967
G1 X93.24 Y96.218 E.06639
G1 X93.055 Y96.349 E.00481
G1 X92.803 Y96.453 E.00577
G1 X92.559 Y96.482 E.0052
G1 X87.536 Y96.482 E.10631
G1 X88.639 Y97.675 E.03439
G1 X88.889 Y98 E.00868
G1 X89.099 Y98.353 E.00869
G1 X89.323 Y98.901 E.01254
G1 X89.45 Y99.489 E.01273
G1 X89.469 Y100.084 E.0126
G1 X89.398 Y100.604 E.0111
G1 X89.263 Y101.077 E.01041
G1 X89.013 Y101.605 E.01237
G1 X88.71 Y102.037 E.01117
G1 X88.374 Y102.396 E.01041
G1 X88.135 Y102.594 E.00657
G1 X87.737 Y102.855 E.01006
G1 X87.365 Y103.033 E.00874
G1 X87.067 Y103.136 E.00667
G1 X86.796 Y103.207 E.00594
G1 X86.386 Y103.269 E.00876
G1 X85.794 Y103.267 E.01254
G1 X85.216 Y103.165 E.01241
G1 X84.715 Y102.984 E.01129
G1 X84.283 Y102.754 E.01035
G1 X83.961 Y102.522 E.00839
G1 X83.666 Y102.251 E.00849
G1 X83.404 Y101.947 E.00849
G1 X83.181 Y101.613 E.00849
G1 X82.998 Y101.256 E.00849
G1 X82.86 Y100.879 E.0085
G1 X82.766 Y100.489 E.0085
G1 X82.72 Y100.091 E.00849
G1 X82.738 Y99.499 E.01254
G1 X82.812 Y99.095 E.00869
G1 X82.929 Y98.717 E.00836
G1 X83.152 Y98.243 E.01109
G1 X83.421 Y97.834 E.01035
G1 X84.597 Y96.482 E.03795
G1 X79.63 Y96.482 E.10513
G1 X79.38 Y96.452 E.00533
G1 X79.265 Y96.415 E.00256
G1 X79.167 Y96.368 E.0023
G1 X78.986 Y96.233 E.00479
G1 X78.835 Y96.045 E.0051
G1 X78.743 Y95.815 E.00524
G1 X78.714 Y95.565 E.00534
G1 X78.714 Y77.619 E.37984
G1 X78.755 Y77.34 E.00597
G1 X78.86 Y77.118 E.0052
G1 X79.054 Y76.908 E.00604
G1 X79.294 Y76.775 E.00582
G1 X79.543 Y76.723 E.00539
G1 X92.601 Y76.721 E.27638
G1 X92.744 Y76.735 E.00303
G1 X92.895 Y76.775 E.0033
G1 X93.124 Y76.904 E.00557
G1 X93.068 Y77.082 E.00395
G1 X80.04 Y77.082 E.27574
G1 X79.752 Y77.132 E.0062
G1 X79.482 Y77.278 E.00649
G1 X79.265 Y77.495 E.00649
G1 X79.113 Y77.797 E.00717
G1 X79.075 Y78.056 E.00553
G1 X79.075 Y95.173 E.3623
G1 X79.16 Y95.529 E.00775
G1 X79.315 Y95.766 E.006
G1 X79.53 Y95.958 E.00609
G1 X79.8 Y96.084 E.0063
G1 X80.049 Y96.12 E.00533
G1 X84.795 Y96.12 E.10045
; WIPE_START
M204 S6000
G1 X86.795 Y96.12 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X83.699 Y96.891 Z3 F18000
G1 Z2.6
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X79.607 Y96.891 E.08049
G1 X79.293 Y96.854 E.00621
G1 X79.113 Y96.796 E.00373
G1 X78.954 Y96.72 E.00347
G1 X78.708 Y96.536 E.00604
G1 X78.558 Y96.369 E.00442
G1 X78.478 Y96.247 E.00286
G1 X78.399 Y96.083 E.00359
G1 X78.341 Y95.902 E.00373
G1 X78.304 Y95.589 E.00621
G1 X78.304 Y77.607 E.35368
G1 X78.313 Y77.454 E.00301
G1 X78.36 Y77.228 E.00454
G1 X78.409 Y77.093 E.00283
G1 X78.517 Y76.892 E.00448
G1 X78.657 Y76.715 E.00444
G1 X78.8 Y76.586 E.00379
G1 X78.948 Y76.485 E.00353
G1 X79.154 Y76.389 E.00445
G1 X79.374 Y76.33 E.00448
G1 X79.519 Y76.313 E.00289
G1 X92.621 Y76.312 E.2577
G1 X92.817 Y76.331 E.00387
G1 X93.035 Y76.389 E.00444
G1 X93.239 Y76.484 E.00442
G1 X93.423 Y76.613 E.00442
G1 X93.582 Y76.772 E.00443
G1 X93.711 Y76.956 E.00442
G1 X93.806 Y77.16 E.00442
G1 X93.864 Y77.377 E.00442
G1 X93.884 Y77.61 E.0046
G1 X93.884 Y85.511 E.1554
G1 X95.239 Y85.511 E.02665
G1 F1870.275
G1 X95.37 Y85.511 E.00256
G1 F1320
G1 X95.37 Y87.691 E.04288
G1 F1668.612
G1 X95.239 Y87.691 E.00256
G1 F1500
G1 X93.884 Y87.691 E.02665
G1 X93.884 Y88.791 E.02164
G1 X92.704 Y88.791 E.02321
G1 X92.704 Y77.491 E.22226
G1 X80.076 Y77.491 E.24839
G1 X79.888 Y77.524 E.00376
G1 X79.729 Y77.61 E.00355
G1 X79.601 Y77.738 E.00355
G1 X79.508 Y77.922 E.00406
G1 X79.484 Y78.086 E.00325
G1 X79.484 Y95.125 E.33516
G1 X79.541 Y95.365 E.00484
G1 X79.628 Y95.497 E.0031
G1 X79.758 Y95.612 E.00343
G1 X79.919 Y95.687 E.0035
G1 X80.079 Y95.711 E.00319
G1 X92.292 Y95.711 E.24022
G1 X92.312 Y95.386 E.00639
G1 X92.349 Y95.211 E.00353
G1 X92.417 Y95.044 E.00353
G1 X92.545 Y94.855 E.0045
G1 X92.674 Y94.73 E.00353
G1 X92.922 Y94.585 E.00565
G1 X93.159 Y94.521 E.00484
G1 X93.444 Y94.523 E.0056
G1 X93.679 Y94.589 E.0048
G1 X93.801 Y94.652 E.0027
G1 X94.025 Y94.809 E.00539
G1 X95.622 Y94.286 E.03305
G1 X98.41 Y90.305 E.09559
G1 X99.376 Y90.982 E.02321
G1 X96.375 Y95.268 E.10291
G1 X93.444 Y96.575 E.06313
G1 X93.269 Y96.699 E.00423
G1 X93.1 Y96.787 E.00374
G1 X92.891 Y96.855 E.00432
G1 X92.582 Y96.891 E.00611
G1 X88.471 Y96.891 E.08086
G1 X88.952 Y97.411 E.01393
G1 X89.228 Y97.77 E.00891
G1 X89.46 Y98.159 E.00891
G1 X89.555 Y98.356 E.00431
G1 X89.715 Y98.78 E.00891
G1 X89.823 Y99.22 E.00891
G1 X89.877 Y99.661 E.00873
G1 X89.878 Y100.111 E.00887
G1 X89.799 Y100.688 E.01145
G1 X89.649 Y101.214 E.01076
G1 X89.51 Y101.538 E.00694
G1 X89.363 Y101.818 E.00622
G1 X89.029 Y102.296 E.01147
G1 X88.655 Y102.695 E.01076
G1 X88.383 Y102.92 E.00694
G1 X87.93 Y103.216 E.01065
G1 X87.521 Y103.412 E.00893
G1 X87.186 Y103.528 E.00697
G1 X86.878 Y103.609 E.00626
G1 X86.429 Y103.676 E.00893
G1 X86.21 Y103.689 E.00431
G1 X85.757 Y103.676 E.00891
G1 X85.309 Y103.608 E.00891
G1 X85.098 Y103.557 E.00426
G1 X84.548 Y103.359 E.01151
G1 X84.066 Y103.102 E.01074
G1 X83.703 Y102.84 E.00882
G1 X83.371 Y102.536 E.00885
G1 X83.078 Y102.195 E.00885
G1 X82.827 Y101.821 E.00885
G1 X82.623 Y101.42 E.00885
G1 X82.467 Y100.998 E.00885
G1 X82.363 Y100.56 E.00885
G1 X82.311 Y100.114 E.00885
G1 X82.312 Y99.661 E.00891
G1 X82.332 Y99.443 E.0043
G1 X82.414 Y98.997 E.00891
G1 X82.547 Y98.569 E.00881
G1 X82.794 Y98.043 E.01144
G1 X83.094 Y97.586 E.01074
G1 X83.659 Y96.936 E.01695
; WIPE_START
M204 S6000
G1 X81.66 Y96.914 E-.38
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




G1 X79.578 Y96.239
G1 Z2.6
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.100339
G1 F1500
M204 S6000
G1 X79.38 Y96.174 E.00078
; LINE_WIDTH: 0.152045
G1 X79.176 Y96.022 E.0016
G1 X79.106 Y95.951 E.00063
G1 X79.033 Y95.831 E.00089
; LINE_WIDTH: 0.127185
G1 X78.995 Y95.739 E.0005
; LINE_WIDTH: 0.0940603
G1 X78.957 Y95.646 E.00034
; WIPE_START
G1 X78.995 Y95.739 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X84.642 Y97.165 Z3 F18000
G1 Z2.6
G1 E.4 F1800
; LINE_WIDTH: 0.477124
G1 F1500
M204 S6000
G1 X84.461 Y97.319 E.00533
; LINE_WIDTH: 0.438423
M73 P60 R10
G1 X84.254 Y97.496 E.00561
; LINE_WIDTH: 0.401008
G1 X84.085 Y97.669 E.00453
; LINE_WIDTH: 0.360462
G1 X83.725 Y98.065 E.00894
G1 X83.483 Y98.428 E.00729
G1 X83.285 Y98.855 E.00786
G1 X83.186 Y99.187 E.00578
G1 X83.118 Y99.545 E.0061
G1 X83.101 Y100.071 E.00879
G1 X83.167 Y100.547 E.00802
G1 X83.345 Y101.104 E.00977
G1 X83.514 Y101.418 E.00594
G1 X83.708 Y101.716 E.00594
G1 X84.033 Y102.078 E.00813
G1 X84.454 Y102.412 E.00898
G1 X84.908 Y102.654 E.00859
G1 X85.322 Y102.794 E.00729
G1 X85.828 Y102.882 E.00858
G1 X86.146 Y102.896 E.00531
G1 X86.666 Y102.845 E.00873
G1 X86.955 Y102.768 E.005
G1 X87.278 Y102.656 E.00571
G1 X87.825 Y102.349 E.01048
G1 X88.111 Y102.116 E.00615
G1 X88.413 Y101.795 E.00735
G1 X88.685 Y101.405 E.00795
G1 X88.828 Y101.134 E.00511
G1 X88.901 Y100.948 E.00334
G1 X89.025 Y100.526 E.00735
G1 X89.087 Y100.062 E.00782
G1 X89.072 Y99.536 E.00879
G1 X88.998 Y99.165 E.00632
G1 X88.841 Y98.707 E.00807
G1 X88.662 Y98.355 E.0066
G1 X88.449 Y98.046 E.00627
G1 X88.095 Y97.655 E.0088
; LINE_WIDTH: 0.395941
G1 X87.906 Y97.485 E.00471
; LINE_WIDTH: 0.442262
G1 X87.717 Y97.314 E.0053
; LINE_WIDTH: 0.480645
G1 X87.474 Y97.129 E.0069
; WIPE_START
G1 X87.717 Y97.314 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X94.006 Y95.555 Z3 F18000
G1 Z2.6
G1 E.4 F1800
; LINE_WIDTH: 0.154191
G1 F1500
M204 S6000
G1 X94.511 Y95.36 E.00347
; LINE_WIDTH: 0.104562
G1 X95.017 Y95.165 E.00213
; WIPE_START
G1 X94.511 Y95.36 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X94.348 Y87.729 Z3 F18000
G1 X94.324 Y86.601 Z3
G1 Z2.6
G1 E.4 F1800
; LINE_WIDTH: 0.114562
G1 F1500
M204 S6000
G1 X93.75 Y86.601 E.00254
; WIPE_START
G1 X94.324 Y86.601 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X87.938 Y82.42 Z3 F18000
G1 X79.591 Y76.955 Z3
G1 Z2.6
G1 E.4 F1800
; LINE_WIDTH: 0.0897803
M73 P60 R9
G1 F1500
M204 S6000
G1 X79.487 Y76.991 E.00035
; LINE_WIDTH: 0.129828
G1 X79.29 Y77.081 E.00113
; LINE_WIDTH: 0.153662
G1 X79.167 Y77.19 E.00105
G1 X79.029 Y77.369 E.00144
; LINE_WIDTH: 0.120638
G1 X78.989 Y77.487 E.00059
; LINE_WIDTH: 0.0908457
G1 X78.948 Y77.604 E.0004
; WIPE_START
G1 X78.989 Y77.487 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X85.9 Y80.725 Z3 F18000
G1 X100.371 Y87.504 Z3
G1 Z2.6
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X100.647 Y87.111 E.00944
G1 X101.029 Y87.379 E.00919
G1 X101.613 Y87.787 E.01402
G1 X101.338 Y88.181 E.00944
G1 X100.42 Y87.538 E.02203
M204 S10000
G1 X100.676 Y87.424 F18000
; FEATURE: Gap infill
; LINE_WIDTH: 0.0965114
G1 F1500
M204 S6000
G1 X101.308 Y87.867 E.00272
; CHANGE_LAYER
; Z_HEIGHT: 2.72
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F1500
G1 X100.676 Y87.424 E-.38
; WIPE_END
G1 E-.02 F1800
; layer num/total_layer_count: 25/57
; update layer progress
M73 L25
M991 S0 P24 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z3 I-1.178 J-.306 P1  F18000
G1 X99.967 Y90.161 Z3
G1 Z2.72
G1 E.4 F1800
; FEATURE: Support
; LINE_WIDTH: 0.42
; LAYER_HEIGHT: 0.21
G1 F1500
M204 S6000
G1 X99.85 Y90.328 E.00667
G1 X99.381 Y90 E.01874
G1 X100.08 Y90 E.02287
G1 X100.886 Y88.849 E.04599
G1 X99.898 Y88.157 E.03948
G1 X98.862 Y89.637 E.05911
G1 X99.219 Y89.887 E.01429
; WIPE_START
G1 X98.862 Y89.637 E-.08292
G1 X99.759 Y88.356 E-.29708
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X94.708 Y86.344 Z3.12 F18000
G1 Z2.72
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
; LAYER_HEIGHT: 0.12
G1 F1500
M204 S500
G1 X94.708 Y86.857 E.01086
G1 X93.538 Y86.857 E.02476
G1 X93.538 Y86.344 E.01086
G1 X94.648 Y86.344 E.02349
M204 S10000
G1 X95.132 Y85.92 F18000
G1 F1500
M204 S500
G1 X95.132 Y87.282 E.02882
G1 X93.475 Y87.282 E.03506
G1 X93.475 Y88.382 E.02328
G1 X93.114 Y88.382 E.00765
G1 X93.114 Y77.127 E.23821
G1 X93.292 Y77.071 E.00395
G1 X93.355 Y77.162 E.00234
G1 X93.42 Y77.301 E.00324
G1 X93.459 Y77.448 E.00324
G1 X93.475 Y77.628 E.00382
G1 X93.475 Y85.92 E.17551
G1 X95.072 Y85.92 E.03379
; WIPE_START
M204 S6000
G1 X95.132 Y87.282 E-.25894
G1 X94.495 Y87.282 E-.12106
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X93.728 Y94.875 Z3.12 F18000
G1 X93.658 Y95.567 Z3.12
G1 Z2.72
G1 E.4 F1800
G1 F1500
M204 S500
G1 X93.122 Y95.806 E.01244
G1 X93.14 Y95.498 E.00653
G1 X93.171 Y95.4 E.00217
G1 X93.246 Y95.351 E.00189
G1 X93.318 Y95.354 E.00152
G1 X93.369 Y95.368 E.00114
G1 X93.609 Y95.533 E.00615
; WIPE_START
M204 S6000
G1 X93.122 Y95.806 E-.14388
G1 X93.14 Y95.498 E-.0795
G1 X93.171 Y95.4 E-.02644
G1 X93.246 Y95.351 E-.02298
G1 X93.318 Y95.354 E-.01851
G1 X93.369 Y95.368 E-.01383
G1 X93.609 Y95.533 E-.07486
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X86.1 Y96.9 Z3.12 F18000
G1 X84.856 Y97.126 Z3.12
G1 Z2.72
G1 E.4 F1800
G1 F1500
M204 S500
G1 X84.741 Y96.963 E.00423
G1 X85.105 Y96.544 E.01174
G1 X87.084 Y96.544 E.04188
G1 X87.43 Y96.942 E.01116
G1 X87.323 Y97.104 E.0041
G1 X86.861 Y96.953 E.01029
G1 X86.488 Y96.88 E.00804
G1 X85.973 Y96.857 E.0109
G1 X85.596 Y96.897 E.00804
G1 X85.225 Y96.981 E.00804
G1 X84.912 Y97.104 E.00712
; WIPE_START
M204 S6000
G1 X84.741 Y96.963 E-.04213
G1 X85.105 Y96.544 E-.10542
G1 X86.329 Y96.544 E-.23245
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X83.491 Y99.7 Z3.12 F18000
G1 Z2.72
G1 E.4 F1800
G1 F1500
M204 S500
G1 X83.502 Y99.51 E.00404
G1 X83.615 Y99.048 E.01007
G1 X83.848 Y98.55 E.01164
G1 X84.169 Y98.121 E.01133
G1 X84.522 Y97.803 E.01005
G1 X84.922 Y97.556 E.00995
G1 X85.351 Y97.388 E.00975
G1 X85.665 Y97.316 E.00683
G1 X85.986 Y97.282 E.00683
G1 X86.437 Y97.302 E.00955
G1 X86.754 Y97.365 E.00683
G1 X87.061 Y97.465 E.00683
G1 X87.473 Y97.671 E.00975
G1 X87.849 Y97.953 E.00995
G1 X88.162 Y98.29 E.00975
G1 X88.344 Y98.557 E.00683
G1 X88.495 Y98.849 E.00696
G1 X88.66 Y99.363 E.01144
G1 X88.717 Y99.901 E.01144
G1 X88.66 Y100.438 E.01144
G1 X88.492 Y100.962 E.01164
G1 X88.261 Y101.378 E.01007
G1 X87.962 Y101.741 E.00995
G1 X87.599 Y102.049 E.01007
G1 X87.118 Y102.315 E.01164
G1 X86.606 Y102.473 E.01134
G1 X86.128 Y102.523 E.01018
G1 X85.58 Y102.472 E.01164
G1 X85.068 Y102.314 E.01134
G1 X84.65 Y102.089 E.01005
G1 X84.283 Y101.796 E.00995
G1 X83.973 Y101.442 E.00995
G1 X83.73 Y101.034 E.01005
G1 X83.549 Y100.53 E.01134
G1 X83.473 Y99.985 E.01164
G1 X83.487 Y99.76 E.00477
M204 S250
G1 X83.899 Y99.725 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X83.908 Y99.571 E.00303
G1 X84.003 Y99.184 E.00783
G1 X84.201 Y98.761 E.00919
G1 X84.472 Y98.398 E.00892
G1 X84.768 Y98.132 E.00783
G1 X85.105 Y97.924 E.0078
G1 X85.472 Y97.78 E.00774
G1 X85.732 Y97.72 E.00526
G1 X85.998 Y97.692 E.00526
G1 X86.388 Y97.71 E.00767
G1 X86.651 Y97.762 E.00526
G1 X86.905 Y97.844 E.00526
G1 X87.257 Y98.02 E.00773
G1 X87.574 Y98.258 E.00779
G1 X87.841 Y98.546 E.00773
G1 X87.992 Y98.767 E.00526
G1 X88.116 Y99.007 E.0053
G1 X88.258 Y99.448 E.00913
G1 X88.306 Y99.901 E.00895
G1 X88.258 Y100.353 E.00895
G1 X88.115 Y100.798 E.00919
G1 X87.921 Y101.146 E.00783
G1 X87.669 Y101.452 E.0078
G1 X87.365 Y101.71 E.00784
G1 X86.957 Y101.936 E.00919
G1 X86.523 Y102.07 E.00892
G1 X86.125 Y102.112 E.00787
G1 X85.66 Y102.068 E.00919
G1 X85.227 Y101.935 E.00892
G1 X84.877 Y101.746 E.00783
G1 X84.567 Y101.499 E.0078
G1 X84.306 Y101.2 E.0078
G1 X84.102 Y100.859 E.00783
G1 X83.949 Y100.432 E.00892
G1 X83.884 Y99.969 E.00919
G1 X83.895 Y99.785 E.00363
; WIPE_START
M204 S6000
G1 X83.908 Y99.571 E-.04064
G1 X84.003 Y99.184 E-.07567
G1 X84.201 Y98.761 E-.08878
G1 X84.472 Y98.398 E-.08614
G1 X84.768 Y98.132 E-.07564
G1 X84.827 Y98.096 E-.01313
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X84.855 Y96.12 Z3.12 F18000
G1 Z2.72
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X92.678 Y96.12 E.16557
G1 X92.718 Y95.441 E.01439
G1 X92.742 Y95.331 E.00238
G1 X92.784 Y95.227 E.00238
G1 X92.867 Y95.111 E.00302
G1 X92.929 Y95.052 E.00182
G1 X93.075 Y94.965 E.0036
G1 X93.234 Y94.926 E.00348
G1 X93.384 Y94.932 E.00316
G1 X93.534 Y94.974 E.00329
G1 X93.961 Y95.261 E.0109
G1 X95.879 Y94.633 E.04271
G1 X98.51 Y90.875 E.09709
G1 X98.806 Y91.083 E.00765
G1 X96.105 Y94.94 E.09967
G1 X93.24 Y96.218 E.06639
G1 X93.054 Y96.35 E.00484
G1 X92.803 Y96.453 E.00574
G1 X92.559 Y96.482 E.0052
G1 X87.591 Y96.482 E.10514
G1 X88.777 Y97.845 E.03824
G1 X88.884 Y97.992 E.00386
G1 X89.099 Y98.353 E.00888
G1 X89.326 Y98.91 E.01273
G1 X89.448 Y99.484 E.01241
G1 X89.47 Y100.003 E.011
G1 X89.421 Y100.497 E.0105
G1 X89.266 Y101.069 E.01255
G1 X89.009 Y101.613 E.01273
G1 X88.661 Y102.1 E.01268
G1 X88.377 Y102.393 E.00863
G1 X88.138 Y102.591 E.00658
G1 X87.737 Y102.855 E.01015
G1 X87.367 Y103.032 E.00869
G1 X86.978 Y103.164 E.00869
G1 X86.386 Y103.269 E.01273
G1 X85.794 Y103.267 E.01254
G1 X85.21 Y103.163 E.01254
G1 X84.822 Y103.032 E.00869
G1 X84.465 Y102.861 E.00837
G1 X84.031 Y102.575 E.011
G1 X83.662 Y102.247 E.01045
G1 X83.404 Y101.947 E.00839
G1 X83.181 Y101.613 E.00849
G1 X83.001 Y101.261 E.00837
G1 X82.831 Y100.77 E.011
G1 X82.737 Y100.286 E.01045
G1 X82.715 Y99.89 E.00839
G1 X82.74 Y99.49 E.00849
G1 X82.812 Y99.095 E.0085
G1 X82.929 Y98.717 E.00837
G1 X83.15 Y98.247 E.011
G1 X83.421 Y97.834 E.01045
G1 X84.597 Y96.482 E.03794
G1 X79.631 Y96.482 E.10513
G1 X79.392 Y96.454 E.00508
G1 X79.119 Y96.34 E.00626
G1 X78.927 Y96.173 E.0054
G1 X78.829 Y96.033 E.00362
G1 X78.743 Y95.812 E.00501
G1 X78.714 Y95.565 E.00527
G1 X78.714 Y77.619 E.37984
G1 X78.753 Y77.349 E.00577
G1 X78.855 Y77.125 E.0052
G1 X79.053 Y76.909 E.0062
G1 X79.297 Y76.774 E.00591
G1 X79.548 Y76.723 E.00543
G1 X92.603 Y76.721 E.27631
G1 X92.744 Y76.735 E.003
G1 X92.895 Y76.775 E.00331
G1 X93.124 Y76.904 E.00556
G1 X93.068 Y77.082 E.00395
G1 X80.04 Y77.082 E.27575
G1 X79.752 Y77.133 E.0062
G1 X79.478 Y77.28 E.00658
G1 X79.255 Y77.51 E.00679
G1 X79.112 Y77.801 E.00686
G1 X79.075 Y78.056 E.00545
G1 X79.075 Y95.173 E.3623
G1 X79.16 Y95.53 E.00775
G1 X79.315 Y95.766 E.006
G1 X79.531 Y95.958 E.0061
G1 X79.8 Y96.084 E.00629
G1 X80.049 Y96.12 E.00533
G1 X84.795 Y96.12 E.10045
; WIPE_START
M204 S6000
G1 X86.795 Y96.12 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X83.699 Y96.891 Z3.12 F18000
G1 Z2.72
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X79.607 Y96.891 E.08049
G1 X79.297 Y96.855 E.00613
G1 X79.01 Y96.75 E.00601
G1 X78.888 Y96.68 E.00277
G1 X78.707 Y96.537 E.00454
G1 X78.609 Y96.432 E.00283
G1 X78.476 Y96.243 E.00454
G1 X78.412 Y96.114 E.00283
G1 X78.341 Y95.901 E.00442
G1 X78.304 Y95.589 E.00619
G1 X78.304 Y77.607 E.35368
G1 X78.313 Y77.454 E.00301
G1 X78.359 Y77.231 E.00448
G1 X78.443 Y77.019 E.00448
G1 X78.515 Y76.895 E.00283
G1 X78.657 Y76.715 E.0045
G1 X78.799 Y76.587 E.00376
G1 X78.949 Y76.485 E.00357
G1 X79.154 Y76.389 E.00447
G1 X79.338 Y76.338 E.00376
G1 X79.521 Y76.313 E.00363
G1 X92.623 Y76.312 E.2577
G1 X92.817 Y76.331 E.00384
G1 X93.035 Y76.389 E.00444
G1 X93.239 Y76.484 E.00442
G1 X93.423 Y76.613 E.00442
G1 X93.582 Y76.772 E.00442
G1 X93.711 Y76.956 E.00442
G1 X93.806 Y77.16 E.00442
G1 X93.864 Y77.377 E.00442
G1 X93.884 Y77.61 E.0046
G1 X93.884 Y85.511 E.1554
G1 X95.411 Y85.511 E.03002
G1 F1870.275
G1 X95.541 Y85.511 E.00256
G1 F1320
G1 X95.541 Y87.691 E.04288
G1 F1668.612
G1 X95.411 Y87.691 E.00256
G1 F1500
G1 X93.884 Y87.691 E.03002
G1 X93.884 Y88.791 E.02164
G1 X92.704 Y88.791 E.02321
G1 X92.704 Y77.491 E.22226
G1 X80.076 Y77.491 E.24839
G1 X79.888 Y77.524 E.00376
G1 X79.728 Y77.61 E.00358
G1 X79.594 Y77.748 E.00378
G1 X79.508 Y77.923 E.00384
G1 X79.484 Y78.086 E.00322
G1 X79.484 Y95.125 E.33516
G1 X79.541 Y95.365 E.00484
G1 X79.628 Y95.496 E.0031
G1 X79.758 Y95.612 E.00343
G1 X79.919 Y95.687 E.00349
G1 X80.079 Y95.711 E.00319
G1 X92.292 Y95.711 E.24022
G1 X92.312 Y95.386 E.00639
G1 X92.349 Y95.211 E.00353
G1 X92.417 Y95.044 E.00353
G1 X92.564 Y94.834 E.00506
G1 X92.673 Y94.731 E.00294
G1 X92.926 Y94.583 E.00576
G1 X93.209 Y94.516 E.00572
G1 X93.448 Y94.524 E.0047
G1 X93.68 Y94.59 E.00474
G1 X93.777 Y94.637 E.00213
G1 X94.027 Y94.809 E.00595
G1 X95.622 Y94.286 E.03302
G1 X98.41 Y90.305 E.09559
M73 P61 R9
G1 X99.376 Y90.982 E.02321
G1 X96.375 Y95.268 E.10291
G1 X93.444 Y96.575 E.06313
G1 X93.267 Y96.7 E.00426
G1 X93.1 Y96.787 E.0037
G1 X92.891 Y96.855 E.00433
G1 X92.582 Y96.891 E.00611
G1 X88.49 Y96.891 E.08049
G1 X89.098 Y97.59 E.01822
G1 X89.226 Y97.767 E.00431
G1 X89.46 Y98.159 E.00897
G1 X89.555 Y98.356 E.00431
G1 X89.716 Y98.783 E.00897
G1 X89.774 Y98.994 E.00431
G1 X89.855 Y99.438 E.00887
G1 X89.88 Y100.014 E.01135
G1 X89.826 Y100.563 E.01085
G1 X89.748 Y100.902 E.00685
G1 X89.65 Y101.211 E.00637
G1 X89.512 Y101.534 E.0069
G1 X89.362 Y101.821 E.00637
G1 X89.169 Y102.114 E.0069
G1 X88.97 Y102.369 E.00636
G1 X88.656 Y102.694 E.00889
G1 X88.387 Y102.917 E.00688
G1 X87.93 Y103.216 E.01074
G1 X87.522 Y103.412 E.00891
G1 X87.092 Y103.557 E.00892
G1 X86.88 Y103.608 E.0043
G1 X86.429 Y103.676 E.00897
G1 X86.21 Y103.689 E.00431
G1 X85.757 Y103.676 E.00891
G1 X85.309 Y103.608 E.00891
G1 X85.096 Y103.557 E.00431
G1 X84.667 Y103.412 E.00891
G1 X84.263 Y103.219 E.00881
G1 X83.782 Y102.901 E.01135
G1 X83.37 Y102.535 E.01083
G1 X83.078 Y102.195 E.00882
G1 X82.827 Y101.821 E.00885
G1 X82.624 Y101.422 E.00881
G1 X82.435 Y100.877 E.01135
G1 X82.33 Y100.336 E.01083
G1 X82.305 Y99.889 E.00882
G1 X82.333 Y99.44 E.00885
G1 X82.414 Y98.997 E.00885
G1 X82.547 Y98.569 E.00881
G1 X82.792 Y98.047 E.01135
G1 X83.094 Y97.586 E.01083
G1 X83.659 Y96.936 E.01695
; WIPE_START
M204 S6000
G1 X81.66 Y96.914 E-.38
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




G1 X79.578 Y96.239
G1 Z2.72
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.103811
G1 F1500
M204 S6000
G1 X79.381 Y96.173 E.00081
; LINE_WIDTH: 0.152701
G1 X79.18 Y96.027 E.00157
G1 X79.044 Y95.851 E.00141
; LINE_WIDTH: 0.130061
G1 X79.001 Y95.749 E.00058
; LINE_WIDTH: 0.0946325
G1 X78.957 Y95.646 E.00038
; WIPE_START
G1 X79.001 Y95.749 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X84.63 Y97.174 Z3.12 F18000
G1 Z2.72
G1 E.4 F1800
; LINE_WIDTH: 0.473061
G1 F1500
M204 S6000
G1 X84.46 Y97.318 E.00499
; LINE_WIDTH: 0.438163
G1 X84.263 Y97.487 E.00533
; LINE_WIDTH: 0.40159
G1 X84.082 Y97.671 E.00484
; LINE_WIDTH: 0.360874
G1 X83.902 Y97.855 E.00431
G1 X83.728 Y98.067 E.00458
G1 X83.483 Y98.433 E.00737
G1 X83.265 Y98.907 E.00873
G1 X83.132 Y99.439 E.00917
G1 X83.097 Y99.891 E.00758
G1 X83.12 Y100.238 E.00581
G1 X83.188 Y100.636 E.00675
G1 X83.353 Y101.111 E.00841
G1 X83.512 Y101.418 E.00579
G1 X83.708 Y101.716 E.00595
G1 X84.013 Y102.057 E.00765
G1 X84.457 Y102.409 E.00946
G1 X84.908 Y102.655 E.0086
G1 X85.313 Y102.792 E.00714
G1 X85.523 Y102.841 E.00362
G1 X85.828 Y102.882 E.00514
G1 X86.146 Y102.896 E.00532
G1 X86.349 Y102.886 E.00341
G1 X86.696 Y102.835 E.00586
G1 X87.224 Y102.679 E.0092
G1 X87.552 Y102.516 E.00613
G1 X87.825 Y102.348 E.00536
G1 X88.22 Y102.015 E.00863
G1 X88.561 Y101.6 E.00899
G1 X88.678 Y101.418 E.00362
G1 X88.905 Y100.935 E.00891
G1 X89.032 Y100.499 E.00759
G1 X89.09 Y99.992 E.00854
G1 X89.065 Y99.527 E.00779
G1 X89.026 Y99.269 E.00436
G1 X88.845 Y98.717 E.00971
G1 X88.67 Y98.373 E.00646
G1 X88.466 Y98.064 E.0062
G1 X88.097 Y97.654 E.00923
; LINE_WIDTH: 0.39552
G1 X87.972 Y97.538 E.00314
; LINE_WIDTH: 0.431464
G1 X87.847 Y97.422 E.00345
; LINE_WIDTH: 0.467641
G1 X87.721 Y97.304 E.0038
; LINE_WIDTH: 0.468439
G1 X87.559 Y97.34 E.00365
; LINE_WIDTH: 0.4336
G1 X87.398 Y97.375 E.00336
; WIPE_START
G1 X87.559 Y97.34 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X94.012 Y95.553 Z3.12 F18000
G1 Z2.72
G1 E.4 F1800
; LINE_WIDTH: 0.153726
G1 F1500
M204 S6000
G1 X94.514 Y95.359 E.00344
; LINE_WIDTH: 0.104407
G1 X95.017 Y95.165 E.00211
; WIPE_START
G1 X94.514 Y95.359 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X94.498 Y87.726 Z3.12 F18000
G1 X94.495 Y86.601 Z3.12
G1 Z2.72
G1 E.4 F1800
; LINE_WIDTH: 0.114562
G1 F1500
M204 S6000
G1 X93.75 Y86.601 E.0033
; WIPE_START
G1 X94.495 Y86.601 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X88.088 Y82.454 Z3.12 F18000
G1 X79.591 Y76.955 Z3.12
G1 Z2.72
G1 E.4 F1800
; LINE_WIDTH: 0.0898152
G1 F1500
M204 S6000
G1 X79.489 Y76.991 E.00034
; LINE_WIDTH: 0.129686
G1 X79.29 Y77.08 E.00113
; LINE_WIDTH: 0.153099
G1 X79.058 Y77.32 E.00212
G1 X79.005 Y77.423 E.00073
; LINE_WIDTH: 0.101284
G1 X78.949 Y77.603 E.00071
; WIPE_START
G1 X79.005 Y77.423 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X85.908 Y80.68 Z3.12 F18000
G1 X100.371 Y87.504 Z3.12
G1 Z2.72
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X100.647 Y87.111 E.00944
G1 X101.056 Y87.397 E.00982
G1 X101.613 Y87.787 E.01339
G1 X101.338 Y88.181 E.00944
G1 X100.42 Y87.538 E.02203
M204 S10000
G1 X100.676 Y87.424 F18000
; FEATURE: Gap infill
; LINE_WIDTH: 0.0964968
G1 F1500
M204 S6000
G1 X101.308 Y87.867 E.00272
; CHANGE_LAYER
; Z_HEIGHT: 2.84
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F1500
G1 X100.676 Y87.424 E-.38
; WIPE_END
G1 E-.02 F1800
; layer num/total_layer_count: 26/57
; update layer progress
M73 L26
M991 S0 P25 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z3.12 I.223 J-1.196 P1  F18000
G1 X94.879 Y86.344 Z3.12
G1 Z2.84
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X94.879 Y86.857 E.01086
G1 X93.538 Y86.857 E.02838
G1 X93.538 Y86.344 E.01086
G1 X94.819 Y86.344 E.02711
M204 S10000
G1 X95.303 Y85.92 F18000
G1 F1500
M204 S500
G1 X95.303 Y87.282 E.02882
G1 X93.475 Y87.282 E.03869
G1 X93.475 Y88.382 E.02328
G1 X93.114 Y88.382 E.00765
G1 X93.114 Y77.127 E.23821
G1 X93.292 Y77.071 E.00395
G1 X93.355 Y77.162 E.00234
G1 X93.42 Y77.301 E.00324
G1 X93.459 Y77.448 E.00324
G1 X93.475 Y77.628 E.00382
G1 X93.475 Y85.92 E.17551
G1 X95.243 Y85.92 E.03742
; WIPE_START
M204 S6000
G1 X95.303 Y87.282 E-.25894
G1 X94.666 Y87.282 E-.12106
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X93.753 Y94.859 Z3.24 F18000
G1 X93.669 Y95.562 Z3.24
G1 Z2.84
G1 E.4 F1800
G1 F1500
M204 S500
G1 X93.122 Y95.806 E.01268
G1 X93.155 Y95.425 E.0081
G1 X93.211 Y95.37 E.00165
G1 X93.292 Y95.348 E.00178
G1 X93.353 Y95.366 E.00135
G1 X93.618 Y95.531 E.00659
; WIPE_START
M204 S6000
G1 X93.122 Y95.806 E-.145
G1 X93.155 Y95.425 E-.09779
G1 X93.211 Y95.37 E-.01996
G1 X93.292 Y95.348 E-.0215
G1 X93.353 Y95.366 E-.01627
G1 X93.618 Y95.531 E-.07948
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X86.109 Y96.897 Z3.24 F18000
G1 X84.86 Y97.124 Z3.24
G1 Z2.84
G1 E.4 F1800
G1 F1500
M204 S500
G1 X84.743 Y96.961 E.00425
G1 X85.105 Y96.544 E.01168
G1 X87.064 Y96.544 E.04146
G1 X87.423 Y96.949 E.01145
G1 X87.312 Y97.113 E.00418
G1 X86.861 Y96.951 E.01013
G1 X86.322 Y96.862 E.01156
G1 X85.767 Y96.87 E.01174
G1 X85.174 Y96.997 E.01285
G1 X84.915 Y97.102 E.0059
; WIPE_START
M204 S6000
G1 X84.743 Y96.961 E-.04228
G1 X85.105 Y96.544 E-.10484
G1 X86.331 Y96.544 E-.23288
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X83.483 Y99.747 Z3.24 F18000
G1 Z2.84
G1 E.4 F1800
G1 F1500
M204 S500
G1 X83.483 Y99.666 E.00172
G1 X83.565 Y99.213 E.00975
G1 X83.67 Y98.907 E.00683
G1 X83.81 Y98.616 E.00683
G1 X84.064 Y98.243 E.00956
G1 X84.284 Y98.007 E.00683
G1 X84.53 Y97.798 E.00683
G1 X84.919 Y97.558 E.00968
G1 X85.299 Y97.404 E.00867
G1 X85.815 Y97.294 E.01119
G1 X86.29 Y97.286 E.01005
G1 X86.754 Y97.363 E.00995
G1 X87.193 Y97.521 E.00988
G1 X87.533 Y97.712 E.00826
G1 X87.731 Y97.854 E.00515
G1 X87.961 Y98.062 E.00656
G1 X88.173 Y98.305 E.00683
G1 X88.421 Y98.693 E.00975
G1 X88.602 Y99.133 E.01007
G1 X88.706 Y99.671 E.01159
G1 X88.698 Y100.209 E.01139
G1 X88.6 Y100.674 E.01005
G1 X88.421 Y101.109 E.00995
G1 X88.168 Y101.505 E.00995
G1 X87.849 Y101.849 E.00995
G1 X87.48 Y102.126 E.00975
G1 X87.196 Y102.278 E.00683
G1 X86.896 Y102.396 E.00683
G1 X86.455 Y102.497 E.00956
G1 X86.134 Y102.521 E.00683
G1 X85.811 Y102.506 E.00683
G1 X85.359 Y102.417 E.00975
G1 X84.922 Y102.246 E.00995
G1 X84.522 Y101.999 E.00995
G1 X84.179 Y101.69 E.00975
G1 X83.975 Y101.441 E.00683
G1 X83.806 Y101.177 E.00664
G1 X83.67 Y100.895 E.00663
G1 X83.565 Y100.589 E.00684
G1 X83.483 Y100.136 E.00975
G1 X83.483 Y99.807 E.00696
M204 S250
G1 X83.892 Y99.747 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X83.892 Y99.703 E.00087
G1 X83.963 Y99.316 E.00773
G1 X84.049 Y99.063 E.00526
G1 X84.165 Y98.822 E.00526
G1 X84.385 Y98.499 E.00767
G1 X84.567 Y98.303 E.00526
G1 X84.771 Y98.13 E.00526
G1 X85.104 Y97.924 E.00771
G1 X85.419 Y97.797 E.00667
G1 X85.862 Y97.702 E.0089
G1 X86.26 Y97.696 E.00783
G1 X86.651 Y97.761 E.0078
G1 X87.023 Y97.895 E.00777
G1 X87.313 Y98.058 E.00654
G1 X87.473 Y98.173 E.0039
G1 X87.669 Y98.35 E.00518
G1 X87.845 Y98.551 E.00526
G1 X88.057 Y98.883 E.00774
G1 X88.208 Y99.251 E.00783
G1 X88.296 Y99.707 E.00914
G1 X88.29 Y100.163 E.00897
G1 X88.207 Y100.553 E.00783
G1 X88.057 Y100.919 E.0078
G1 X87.843 Y101.253 E.0078
G1 X87.574 Y101.544 E.0078
G1 X87.259 Y101.78 E.00774
G1 X87.024 Y101.906 E.00526
G1 X86.775 Y102.004 E.00526
G1 X86.394 Y102.091 E.00767
G1 X86.127 Y102.111 E.00526
G1 X85.86 Y102.099 E.00526
G1 X85.474 Y102.023 E.00774
G1 X85.106 Y101.878 E.00779
G1 X84.768 Y101.67 E.0078
G1 X84.476 Y101.407 E.00773
G1 X84.306 Y101.2 E.00526
G1 X84.164 Y100.977 E.0052
G1 X84.049 Y100.739 E.0052
G1 X83.963 Y100.486 E.00527
G1 X83.892 Y100.099 E.00773
G1 X83.892 Y99.807 E.00574
; WIPE_START
M204 S6000
G1 X83.892 Y99.703 E-.01981
G1 X83.963 Y99.316 E-.07472
G1 X84.049 Y99.063 E-.05082
G1 X84.165 Y98.822 E-.05082
G1 X84.385 Y98.499 E-.07412
G1 X84.567 Y98.303 E-.05084
G1 X84.771 Y98.13 E-.05084
G1 X84.807 Y98.108 E-.00802
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X84.855 Y96.12 Z3.24 F18000
G1 Z2.84
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X92.678 Y96.12 E.16557
G1 X92.718 Y95.441 E.01439
G1 X92.742 Y95.327 E.00247
G1 X92.851 Y95.128 E.0048
G1 X92.938 Y95.044 E.00257
G1 X93.072 Y94.968 E.00324
G1 X93.272 Y94.922 E.00435
G1 X93.37 Y94.929 E.00208
G1 X93.529 Y94.976 E.00351
G1 X93.979 Y95.255 E.0112
G1 X95.879 Y94.633 E.04233
G1 X98.51 Y90.875 E.09709
G1 X98.806 Y91.083 E.00765
G1 X96.105 Y94.94 E.09967
G1 X93.244 Y96.216 E.06631
G1 X93.021 Y96.37 E.00573
G1 X92.803 Y96.453 E.00495
G1 X92.559 Y96.482 E.0052
G1 X87.575 Y96.482 E.10548
G1 X88.713 Y97.766 E.03632
G1 X88.887 Y97.997 E.00612
G1 X89.096 Y98.347 E.00863
G1 X89.223 Y98.626 E.00648
G1 X89.375 Y99.086 E.01025
G1 X89.467 Y99.68 E.01273
G1 X89.469 Y100.085 E.00856
G1 X89.4 Y100.595 E.0109
G1 X89.263 Y101.075 E.01055
G1 X89.013 Y101.606 E.01243
G1 X88.665 Y102.096 E.01273
G1 X88.379 Y102.391 E.00869
G1 X88.061 Y102.65 E.00868
G1 X87.737 Y102.855 E.00811
G1 X87.367 Y103.032 E.00869
G1 X86.978 Y103.164 E.00869
G1 X86.386 Y103.269 E.01273
G1 X85.794 Y103.267 E.01254
G1 X85.201 Y103.161 E.01274
G1 X84.638 Y102.951 E.01272
G1 X84.287 Y102.757 E.00849
G1 X83.961 Y102.522 E.00849
G1 X83.666 Y102.251 E.00849
G1 X83.404 Y101.947 E.00849
G1 X83.181 Y101.613 E.0085
G1 X82.998 Y101.256 E.00849
G1 X82.86 Y100.879 E.00849
G1 X82.766 Y100.489 E.0085
G1 X82.72 Y100.091 E.00849
G1 X82.738 Y99.499 E.01253
G1 X82.812 Y99.095 E.00869
G1 X82.929 Y98.717 E.00837
G1 X83.148 Y98.251 E.0109
G1 X83.421 Y97.834 E.01055
G1 X84.597 Y96.482 E.03794
G1 X79.631 Y96.482 E.10513
G1 X79.392 Y96.454 E.00508
G1 X79.119 Y96.34 E.00626
G1 X78.992 Y96.24 E.00343
G1 X78.884 Y96.119 E.00343
G1 X78.744 Y95.821 E.00696
G1 X78.714 Y95.565 E.00546
G1 X78.714 Y77.625 E.37971
G1 X78.753 Y77.344 E.00601
G1 X78.86 Y77.118 E.00528
G1 X79.051 Y76.91 E.00598
G1 X79.294 Y76.775 E.00587
G1 X79.543 Y76.723 E.00539
G1 X92.605 Y76.721 E.27645
G1 X92.744 Y76.735 E.00296
G1 X92.895 Y76.775 E.00331
G1 X93.124 Y76.904 E.00556
G1 X93.068 Y77.082 E.00395
G1 X80.049 Y77.082 E.27555
G1 X79.791 Y77.119 E.00552
G1 X79.48 Y77.276 E.00736
G1 X79.241 Y77.529 E.00737
G1 X79.112 Y77.807 E.00649
G1 X79.075 Y78.056 E.00533
G1 X79.075 Y95.173 E.3623
M73 P62 R9
G1 X79.161 Y95.535 E.00787
G1 X79.33 Y95.783 E.00636
G1 X79.535 Y95.96 E.00572
G1 X79.8 Y96.084 E.0062
G1 X80.049 Y96.12 E.00533
G1 X84.795 Y96.12 E.10045
; WIPE_START
M204 S6000
G1 X86.795 Y96.12 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X83.699 Y96.891 Z3.24 F18000
G1 Z2.84
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X79.607 Y96.891 E.08049
G1 X79.297 Y96.855 E.00613
G1 X79.01 Y96.75 E.006
G1 X78.888 Y96.68 E.00277
G1 X78.71 Y96.539 E.00448
G1 X78.558 Y96.368 E.00448
G1 X78.479 Y96.248 E.00283
G1 X78.382 Y96.039 E.00454
G1 X78.341 Y95.904 E.00277
G1 X78.304 Y95.589 E.00625
G1 X78.304 Y77.609 E.35364
G1 X78.32 Y77.411 E.0039
G1 X78.36 Y77.229 E.00366
G1 X78.409 Y77.093 E.00286
G1 X78.517 Y76.892 E.00448
G1 X78.657 Y76.715 E.00444
G1 X78.797 Y76.588 E.00372
G1 X78.949 Y76.485 E.0036
G1 X79.153 Y76.389 E.00445
G1 X79.374 Y76.33 E.00448
G1 X79.519 Y76.313 E.00289
G1 X92.625 Y76.312 E.25776
G1 X92.817 Y76.331 E.00381
G1 X93.035 Y76.389 E.00444
G1 X93.239 Y76.484 E.00442
G1 X93.423 Y76.613 E.00442
G1 X93.582 Y76.772 E.00442
G1 X93.711 Y76.956 E.00442
G1 X93.806 Y77.16 E.00442
G1 X93.864 Y77.377 E.00442
G1 X93.884 Y77.61 E.0046
G1 X93.884 Y85.511 E.1554
G1 X95.582 Y85.511 E.03339
G1 F1870.245
G1 X95.712 Y85.511 E.00256
G1 F1320
G1 X95.712 Y87.691 E.04288
G1 F1668.584
G1 X95.582 Y87.691 E.00256
G1 F1500
G1 X93.884 Y87.691 E.03339
G1 X93.884 Y88.791 E.02164
G1 X92.704 Y88.791 E.02321
G1 X92.704 Y77.491 E.22226
G1 X80.079 Y77.491 E.24833
G1 X79.916 Y77.515 E.00325
G1 X79.728 Y77.609 E.00413
G1 X79.584 Y77.761 E.00413
G1 X79.508 Y77.925 E.00355
G1 X79.484 Y78.086 E.00319
G1 X79.484 Y95.125 E.33516
G1 X79.542 Y95.367 E.00488
G1 X79.638 Y95.508 E.00337
G1 X79.759 Y95.613 E.00315
G1 X79.919 Y95.687 E.00346
G1 X80.079 Y95.711 E.00319
G1 X92.292 Y95.711 E.24022
G1 X92.312 Y95.387 E.00639
G1 X92.349 Y95.209 E.00356
G1 X92.401 Y95.076 E.00282
G1 X92.545 Y94.855 E.00519
G1 X92.676 Y94.728 E.00359
G1 X92.925 Y94.584 E.00565
G1 X93.161 Y94.521 E.00481
G1 X93.443 Y94.523 E.00555
G1 X93.698 Y94.6 E.00524
G1 X94.032 Y94.807 E.00773
G1 X95.622 Y94.286 E.0329
G1 X98.41 Y90.305 E.09559
G1 X99.376 Y90.982 E.02321
G1 X96.375 Y95.268 E.10291
G1 X93.445 Y96.575 E.0631
G1 X93.229 Y96.723 E.00516
G1 X93.102 Y96.786 E.00279
G1 X92.891 Y96.855 E.00437
G1 X92.582 Y96.891 E.00611
G1 X88.484 Y96.891 E.0806
G1 X89.03 Y97.507 E.01619
G1 X89.227 Y97.769 E.00644
G1 X89.459 Y98.157 E.00889
G1 X89.602 Y98.471 E.00679
G1 X89.774 Y98.994 E.01083
G1 X89.856 Y99.443 E.00897
G1 X89.877 Y99.661 E.0043
G1 X89.878 Y100.112 E.00887
G1 X89.801 Y100.679 E.01126
G1 X89.649 Y101.213 E.01092
G1 X89.468 Y101.627 E.00888
G1 X89.363 Y101.818 E.0043
G1 X89.109 Y102.197 E.00897
G1 X88.972 Y102.368 E.00431
G1 X88.656 Y102.693 E.00891
G1 X88.305 Y102.979 E.0089
G1 X87.93 Y103.216 E.00873
G1 X87.521 Y103.412 E.00891
G1 X87.092 Y103.557 E.00891
G1 X86.88 Y103.608 E.0043
G1 X86.429 Y103.676 E.00897
G1 X86.21 Y103.689 E.00431
G1 X85.757 Y103.676 E.00891
G1 X85.309 Y103.608 E.00891
G1 X85.093 Y103.556 E.00437
G1 X84.881 Y103.491 E.00436
G1 X84.462 Y103.321 E.00891
G1 X84.068 Y103.103 E.00885
G1 X83.703 Y102.84 E.00885
G1 X83.371 Y102.536 E.00885
G1 X83.078 Y102.195 E.00885
G1 X82.827 Y101.821 E.00885
G1 X82.623 Y101.42 E.00885
G1 X82.467 Y100.998 E.00885
G1 X82.363 Y100.56 E.00885
G1 X82.311 Y100.113 E.00885
G1 X82.312 Y99.661 E.00891
G1 X82.332 Y99.443 E.0043
G1 X82.414 Y98.997 E.00891
G1 X82.547 Y98.569 E.00881
G1 X82.789 Y98.051 E.01126
G1 X83.094 Y97.586 E.01093
G1 X83.66 Y96.936 E.01695
; WIPE_START
M204 S6000
G1 X81.66 Y96.914 E-.38
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




G1 X79.578 Y96.239
G1 Z2.84
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.103312
G1 F1500
M204 S6000
G1 X79.387 Y96.176 E.00078
; LINE_WIDTH: 0.149169
G1 X79.305 Y96.127 E.00059
G1 X79.129 Y95.973 E.00144
G1 X78.941 Y95.656 E.00227
; WIPE_START
G1 X79.129 Y95.973 E-.20073
G1 X79.305 Y96.127 E-.12736
G1 X79.387 Y96.176 E-.0519
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X84.633 Y97.171 Z3.24 F18000
G1 Z2.84
G1 E.4 F1800
; LINE_WIDTH: 0.474721
G1 F1500
M204 S6000
G1 X84.466 Y97.313 E.0049
; LINE_WIDTH: 0.441722
G1 X84.277 Y97.475 E.00517
; LINE_WIDTH: 0.40847
G1 X84.151 Y97.599 E.00336
; LINE_WIDTH: 0.360073
G1 X83.761 Y98.018 E.00955
G1 X83.489 Y98.417 E.00806
G1 X83.318 Y98.774 E.0066
G1 X83.204 Y99.106 E.00586
G1 X83.107 Y99.647 E.00917
G1 X83.102 Y100.069 E.00704
G1 X83.145 Y100.422 E.00593
G1 X83.225 Y100.769 E.00594
G1 X83.348 Y101.103 E.00594
G1 X83.481 Y101.37 E.00497
G1 X83.663 Y101.655 E.00565
G1 X83.915 Y101.961 E.0066
G1 X84.203 Y102.225 E.00653
G1 X84.493 Y102.432 E.00593
G1 X84.802 Y102.607 E.00594
G1 X85.268 Y102.783 E.0083
G1 X85.828 Y102.888 E.0095
G1 X86.193 Y102.898 E.0061
G1 X86.724 Y102.829 E.00893
G1 X87.225 Y102.677 E.00874
G1 X87.555 Y102.519 E.0061
G1 X87.834 Y102.34 E.00552
G1 X88.123 Y102.111 E.00614
G1 X88.456 Y101.745 E.00826
G1 X88.76 Y101.268 E.00944
G1 X88.903 Y100.943 E.00593
G1 X89.024 Y100.517 E.00738
G1 X89.084 Y100.062 E.00766
G1 X89.071 Y99.548 E.00857
G1 X88.964 Y99.02 E.00898
G1 X88.759 Y98.521 E.00901
G1 X88.483 Y98.088 E.00855
G1 X88.225 Y97.788 E.0066
; LINE_WIDTH: 0.381595
G1 X87.974 Y97.536 E.00631
; LINE_WIDTH: 0.417548
G1 X87.875 Y97.446 E.00262
; LINE_WIDTH: 0.450038
G1 X87.756 Y97.34 E.00336
; LINE_WIDTH: 0.47768
G1 X87.535 Y97.162 E.00641
; WIPE_START
G1 X87.756 Y97.34 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X94.039 Y95.542 Z3.24 F18000
G1 Z2.84
G1 E.4 F1800
; LINE_WIDTH: 0.151366
G1 F1500
M204 S6000
G1 X94.528 Y95.354 E.00328
; LINE_WIDTH: 0.10362
G1 X95.017 Y95.165 E.00203
; WIPE_START
G1 X94.528 Y95.354 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X94.649 Y87.722 Z3.24 F18000
G1 X94.667 Y86.601 Z3.24
G1 Z2.84
G1 E.4 F1800
; LINE_WIDTH: 0.114562
G1 F1500
M204 S6000
G1 X93.75 Y86.601 E.00406
; WIPE_START
G1 X94.667 Y86.601 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X88.239 Y82.486 Z3.24 F18000
G1 X79.598 Y76.955 Z3.24
G1 Z2.84
G1 E.4 F1800
; LINE_WIDTH: 0.0893931
G1 F1500
M204 S6000
G1 X79.491 Y76.991 E.00036
; LINE_WIDTH: 0.127264
G1 X79.289 Y77.079 E.00111
; LINE_WIDTH: 0.154173
G1 X79.168 Y77.191 E.00106
G1 X79.019 Y77.387 E.00158
; LINE_WIDTH: 0.0998437
G1 X78.951 Y77.597 E.00082
; WIPE_START
G1 X79.019 Y77.387 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X85.917 Y80.655 Z3.24 F18000
G1 X100.371 Y87.504 Z3.24
G1 Z2.84
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X100.647 Y87.111 E.00944
G1 X101.082 Y87.415 E.01045
G1 X101.613 Y87.787 E.01276
G1 X101.338 Y88.181 E.00944
G1 X100.42 Y87.538 E.02203
M204 S10000
G1 X100.676 Y87.424 F18000
; FEATURE: Gap infill
; LINE_WIDTH: 0.0965152
G1 F1500
M204 S6000
G1 X101.308 Y87.867 E.00272
; CHANGE_LAYER
; Z_HEIGHT: 2.96
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F1500
G1 X100.676 Y87.424 E-.38
; WIPE_END
G1 E-.02 F1800
; layer num/total_layer_count: 27/57
; update layer progress
M73 L27
M991 S0 P26 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z3.24 I.229 J-1.195 P1  F18000
G1 X95.05 Y86.344 Z3.24
G1 Z2.96
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X95.05 Y86.857 E.01086
G1 X93.538 Y86.857 E.03201
G1 X93.538 Y86.344 E.01086
G1 X94.99 Y86.344 E.03074
M204 S10000
G1 X95.475 Y85.92 F18000
G1 F1500
M204 S500
G1 X95.475 Y87.282 E.02882
G1 X93.475 Y87.282 E.04232
G1 X93.475 Y88.382 E.02328
G1 X93.114 Y88.382 E.00765
G1 X93.114 Y77.127 E.23821
G1 X93.292 Y77.071 E.00395
G1 X93.355 Y77.162 E.00234
G1 X93.42 Y77.3 E.00324
G1 X93.459 Y77.448 E.00324
G1 X93.475 Y77.628 E.00382
G1 X93.475 Y85.92 E.17551
G1 X95.415 Y85.92 E.04105
; WIPE_START
M204 S6000
G1 X95.475 Y87.282 E-.25894
G1 X94.837 Y87.282 E-.12106
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X93.768 Y94.839 Z3.36 F18000
G1 X93.665 Y95.564 Z3.36
G1 Z2.96
G1 E.4 F1800
G1 F1500
M204 S500
G1 X93.117 Y95.808 E.0127
G1 X93.143 Y95.469 E.00719
G1 X93.171 Y95.4 E.00157
G1 X93.246 Y95.351 E.00189
G1 X93.34 Y95.354 E.00201
G1 X93.615 Y95.531 E.00691
; WIPE_START
M204 S6000
G1 X93.117 Y95.808 E-.14481
G1 X93.143 Y95.469 E-.08645
G1 X93.171 Y95.4 E-.01891
G1 X93.246 Y95.351 E-.0227
G1 X93.34 Y95.354 E-.02412
G1 X93.615 Y95.531 E-.08301
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X86.106 Y96.899 Z3.36 F18000
G1 X84.856 Y97.126 Z3.36
G1 Z2.96
G1 E.4 F1800
G1 F1500
M204 S500
G1 X84.741 Y96.963 E.00423
M73 P63 R9
G1 X85.105 Y96.544 E.01174
G1 X87.083 Y96.544 E.04187
G1 X87.437 Y96.951 E.0114
G1 X87.313 Y97.115 E.00436
G1 X86.846 Y96.949 E.01051
G1 X86.322 Y96.862 E.01123
G1 X85.776 Y96.87 E.01156
G1 X85.24 Y96.975 E.01157
G1 X84.912 Y97.104 E.00745
; WIPE_START
M204 S6000
G1 X84.741 Y96.963 E-.04213
G1 X85.105 Y96.544 E-.10541
G1 X86.329 Y96.544 E-.23246
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X83.484 Y99.767 Z3.36 F18000
G1 Z2.96
G1 E.4 F1800
G1 F1500
M204 S500
G1 X83.482 Y99.671 E.00203
G1 X83.567 Y99.203 E.01006
G1 X83.729 Y98.772 E.00975
G1 X83.886 Y98.49 E.00683
G1 X84.076 Y98.229 E.00683
G1 X84.393 Y97.908 E.00956
G1 X84.651 Y97.714 E.00683
G1 X84.93 Y97.553 E.00683
G1 X85.359 Y97.384 E.00975
G1 X85.82 Y97.294 E.00995
G1 X86.29 Y97.286 E.00995
G1 X86.745 Y97.362 E.00975
G1 X87.052 Y97.462 E.00683
G1 X87.344 Y97.597 E.00683
G1 X87.721 Y97.846 E.00956
G1 X87.961 Y98.062 E.00683
G1 X88.173 Y98.305 E.00683
G1 X88.421 Y98.693 E.00975
G1 X88.6 Y99.128 E.00995
G1 X88.697 Y99.588 E.00995
G1 X88.711 Y100.058 E.00995
G1 X88.643 Y100.513 E.00975
G1 X88.548 Y100.822 E.00683
G1 X88.416 Y101.117 E.00684
G1 X88.166 Y101.509 E.00986
G1 X87.791 Y101.899 E.01145
G1 X87.342 Y102.207 E.01154
G1 X86.905 Y102.394 E.01006
G1 X86.455 Y102.497 E.00975
G1 X86.134 Y102.521 E.00683
G1 X85.811 Y102.506 E.00683
G1 X85.359 Y102.417 E.00975
G1 X84.922 Y102.246 E.00995
G1 X84.517 Y101.996 E.01007
G1 X84.121 Y101.627 E.01145
G1 X83.841 Y101.24 E.01012
G1 X83.612 Y100.748 E.01147
G1 X83.491 Y100.212 E.01164
G1 X83.485 Y99.827 E.00814
M204 S250
G1 X83.893 Y99.76 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X83.892 Y99.704 E.00109
G1 X83.963 Y99.313 E.00783
G1 X84.101 Y98.944 E.00774
G1 X84.232 Y98.711 E.00526
G1 X84.389 Y98.495 E.00526
G1 X84.663 Y98.217 E.00768
G1 X84.877 Y98.056 E.00526
G1 X85.108 Y97.922 E.00526
G1 X85.474 Y97.779 E.00774
G1 X85.863 Y97.702 E.0078
G1 X86.26 Y97.696 E.00779
G1 X86.648 Y97.761 E.00773
G1 X86.902 Y97.843 E.00526
G1 X87.145 Y97.956 E.00526
G1 X87.47 Y98.171 E.00768
G1 X87.669 Y98.35 E.00526
G1 X87.845 Y98.551 E.00527
G1 X88.057 Y98.882 E.00773
G1 X88.207 Y99.249 E.0078
G1 X88.289 Y99.637 E.0078
G1 X88.301 Y100.033 E.0078
G1 X88.243 Y100.422 E.00773
G1 X88.164 Y100.677 E.00526
G1 X88.055 Y100.922 E.00527
G1 X87.842 Y101.255 E.00777
G1 X87.525 Y101.586 E.00902
G1 X87.144 Y101.847 E.0091
G1 X86.778 Y102.004 E.00783
G1 X86.394 Y102.091 E.00774
G1 X86.127 Y102.111 E.00526
G1 X85.86 Y102.099 E.00526
G1 X85.474 Y102.023 E.00774
G1 X85.105 Y101.878 E.0078
G1 X84.767 Y101.669 E.00783
G1 X84.43 Y101.354 E.00907
G1 X84.195 Y101.031 E.00785
G1 X84.002 Y100.615 E.00902
G1 X83.9 Y100.163 E.00913
G1 X83.894 Y99.82 E.00674
; WIPE_START
M204 S6000
G1 X83.892 Y99.704 E-.02197
G1 X83.963 Y99.313 E-.07566
G1 X84.101 Y98.944 E-.07473
G1 X84.232 Y98.711 E-.05078
G1 X84.389 Y98.495 E-.05084
G1 X84.663 Y98.217 E-.07415
G1 X84.797 Y98.116 E-.03188
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X84.855 Y96.12 Z3.36 F18000
G1 Z2.96
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X92.668 Y96.12 E.16536
G1 X92.74 Y95.335 E.0167
G1 X92.784 Y95.227 E.00246
G1 X92.868 Y95.11 E.00306
G1 X93.074 Y94.965 E.00533
G1 X93.234 Y94.926 E.00348
G1 X93.443 Y94.941 E.00443
G1 X93.539 Y94.978 E.00218
G1 X93.972 Y95.257 E.01091
G1 X95.879 Y94.633 E.04247
G1 X98.51 Y90.875 E.09709
G1 X98.806 Y91.083 E.00765
G1 X96.105 Y94.94 E.09967
G1 X93.241 Y96.218 E.06638
G1 X93.051 Y96.351 E.00491
G1 X92.803 Y96.453 E.00569
G1 X92.559 Y96.482 E.00521
G1 X87.591 Y96.482 E.10514
G1 X88.777 Y97.845 E.03825
G1 X88.884 Y97.992 E.00385
G1 X89.099 Y98.353 E.00889
G1 X89.323 Y98.901 E.01254
G1 X89.45 Y99.489 E.01273
G1 X89.469 Y100.085 E.01261
G1 X89.401 Y100.591 E.01081
G1 X89.263 Y101.078 E.01071
G1 X89.01 Y101.611 E.01249
G1 X88.668 Y102.092 E.01249
G1 X88.3 Y102.459 E.011
G1 X87.89 Y102.765 E.01084
G1 X87.737 Y102.855 E.00375
G1 X87.188 Y103.099 E.01273
G1 X86.792 Y103.208 E.00869
G1 X86.386 Y103.269 E.00869
G1 X85.794 Y103.267 E.01254
G1 X85.201 Y103.161 E.01274
G1 X84.638 Y102.951 E.01273
G1 X84.287 Y102.757 E.00849
G1 X83.961 Y102.522 E.00849
G1 X83.666 Y102.251 E.0085
G1 X83.404 Y101.947 E.00849
G1 X83.181 Y101.613 E.0085
G1 X83.001 Y101.261 E.00837
G1 X82.833 Y100.779 E.0108
G1 X82.737 Y100.285 E.01064
G1 X82.715 Y99.89 E.00838
G1 X82.74 Y99.49 E.00849
G1 X82.812 Y99.095 E.0085
G1 X82.929 Y98.717 E.00837
G1 X83.145 Y98.254 E.01081
G1 X83.421 Y97.834 E.01064
G1 X84.597 Y96.482 E.03793
G1 X79.631 Y96.482 E.10513
G1 X79.302 Y96.43 E.00703
G1 X79.163 Y96.365 E.00325
G1 X78.986 Y96.233 E.00469
G1 X78.835 Y96.045 E.00509
G1 X78.743 Y95.816 E.00524
G1 X78.714 Y95.565 E.00535
G1 X78.714 Y77.625 E.37972
G1 X78.752 Y77.349 E.00589
G1 X78.858 Y77.121 E.00532
G1 X79.05 Y76.911 E.00603
G1 X79.302 Y76.772 E.00609
G1 X79.552 Y76.723 E.0054
G1 X92.606 Y76.721 E.27629
G1 X92.744 Y76.735 E.00292
G1 X92.895 Y76.775 E.00331
G1 X93.124 Y76.904 E.00556
G1 X93.068 Y77.082 E.00395
G1 X80.04 Y77.082 E.27574
G1 X79.752 Y77.132 E.0062
G1 X79.474 Y77.283 E.00669
G1 X79.241 Y77.529 E.00717
G1 X79.112 Y77.807 E.00648
G1 X79.075 Y78.056 E.00533
G1 X79.075 Y95.137 E.36154
G1 X79.099 Y95.342 E.00436
G1 X79.192 Y95.586 E.00554
G1 X79.346 Y95.8 E.00556
G1 X79.539 Y95.962 E.00534
G1 X79.8 Y96.084 E.00611
G1 X80.049 Y96.12 E.00533
G1 X84.795 Y96.12 E.10045
; WIPE_START
M204 S6000
G1 X86.795 Y96.12 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X83.699 Y96.891 Z3.36 F18000
G1 Z2.96
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X79.607 Y96.891 E.08049
G1 X79.291 Y96.854 E.00625
G1 X79.156 Y96.814 E.00277
G1 X78.952 Y96.719 E.00442
G1 X78.708 Y96.536 E.00601
G1 X78.558 Y96.368 E.00442
G1 X78.478 Y96.247 E.00286
G1 X78.397 Y96.078 E.00369
G1 X78.341 Y95.902 E.00363
G1 X78.304 Y95.589 E.00621
G1 X78.304 Y77.609 E.35364
G1 X78.319 Y77.413 E.00387
G1 X78.359 Y77.231 E.00366
G1 X78.427 Y77.055 E.00371
G1 X78.516 Y76.894 E.00363
G1 X78.657 Y76.715 E.00447
G1 X78.796 Y76.589 E.00369
G1 X78.949 Y76.485 E.00363
G1 X79.156 Y76.388 E.00451
G1 X79.294 Y76.347 E.00283
G1 X79.522 Y76.313 E.00454
G1 X92.626 Y76.312 E.25774
G1 X92.817 Y76.331 E.00377
G1 X93.035 Y76.389 E.00444
G1 X93.239 Y76.484 E.00442
G1 X93.423 Y76.613 E.00442
G1 X93.582 Y76.772 E.00442
G1 X93.711 Y76.956 E.00442
G1 X93.806 Y77.16 E.00442
G1 X93.864 Y77.377 E.00442
G1 X93.884 Y77.61 E.0046
G1 X93.884 Y85.511 E.1554
G1 X95.753 Y85.511 E.03676
G1 F1870.275
G1 X95.884 Y85.511 E.00256
G1 F1320
G1 X95.884 Y87.691 E.04288
G1 F1668.612
G1 X95.753 Y87.691 E.00256
G1 F1500
G1 X93.884 Y87.691 E.03676
G1 X93.884 Y88.791 E.02164
G1 X92.704 Y88.791 E.02321
G1 X92.704 Y77.491 E.22226
G1 X80.076 Y77.491 E.24839
G1 X79.888 Y77.524 E.00376
G1 X79.726 Y77.611 E.00362
G1 X79.584 Y77.762 E.00407
G1 X79.508 Y77.925 E.00355
G1 X79.484 Y78.086 E.00319
G1 X79.484 Y95.113 E.33492
G1 X79.5 Y95.243 E.00258
G1 X79.556 Y95.391 E.0031
G1 X79.648 Y95.519 E.00311
G1 X79.761 Y95.614 E.00289
G1 X79.919 Y95.687 E.00343
G1 X80.079 Y95.711 E.00319
G1 X92.289 Y95.711 E.24015
G1 X92.316 Y95.355 E.00702
G1 X92.348 Y95.212 E.00289
G1 X92.417 Y95.044 E.00356
G1 X92.566 Y94.832 E.00512
G1 X92.673 Y94.731 E.00289
G1 X92.926 Y94.583 E.00576
G1 X93.209 Y94.516 E.00572
G1 X93.454 Y94.525 E.00483
G1 X93.725 Y94.611 E.00559
G1 X94.03 Y94.807 E.00714
G1 X95.622 Y94.286 E.03295
G1 X98.41 Y90.305 E.09559
G1 X99.376 Y90.982 E.02321
G1 X96.375 Y95.268 E.10291
G1 X93.444 Y96.575 E.06313
G1 X93.264 Y96.702 E.00433
G1 X93.1 Y96.787 E.00364
G1 X92.891 Y96.855 E.00433
G1 X92.582 Y96.891 E.00611
G1 X88.49 Y96.891 E.0805
G1 X89.098 Y97.59 E.01823
G1 X89.226 Y97.767 E.0043
G1 X89.46 Y98.159 E.00897
G1 X89.555 Y98.356 E.00431
G1 X89.715 Y98.78 E.00891
G1 X89.823 Y99.22 E.00891
G1 X89.877 Y99.661 E.00873
G1 X89.878 Y100.112 E.00887
G1 X89.802 Y100.675 E.01117
G1 X89.649 Y101.214 E.01103
G1 X89.516 Y101.526 E.00666
G1 X89.362 Y101.82 E.00654
G1 X89.109 Y102.197 E.00893
G1 X88.973 Y102.366 E.00427
G1 X88.568 Y102.769 E.01123
G1 X88.117 Y103.106 E.01108
G1 X87.93 Y103.216 E.00427
G1 X87.519 Y103.413 E.00897
G1 X87.314 Y103.489 E.0043
G1 X86.877 Y103.609 E.00891
G1 X86.429 Y103.676 E.00891
G1 X86.21 Y103.689 E.00431
G1 X85.757 Y103.676 E.00891
G1 X85.309 Y103.608 E.00891
G1 X84.881 Y103.491 E.00873
G1 X84.462 Y103.321 E.00891
G1 X84.068 Y103.103 E.00885
G1 X83.703 Y102.84 E.00885
G1 X83.371 Y102.536 E.00885
G1 X83.078 Y102.195 E.00885
G1 X82.827 Y101.821 E.00885
G1 X82.624 Y101.422 E.00881
G1 X82.437 Y100.886 E.01117
G1 X82.33 Y100.336 E.01101
G1 X82.305 Y99.889 E.00882
G1 X82.333 Y99.44 E.00885
G1 X82.414 Y98.997 E.00885
G1 X82.547 Y98.569 E.00881
G1 X82.787 Y98.055 E.01117
G1 X83.094 Y97.586 E.01102
G1 X83.659 Y96.936 E.01695
; WIPE_START
M204 S6000
G1 X81.66 Y96.914 E-.38
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




G1 X79.578 Y96.239
G1 Z2.96
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.102454
G1 F1500
M204 S6000
G1 X79.391 Y96.181 E.00075
; LINE_WIDTH: 0.153617
G1 X79.136 Y95.984 E.00206
G1 X78.945 Y95.689 E.00224
M204 S10000
G1 X78.959 Y95.637 F18000
; LINE_WIDTH: 0.0847819
G1 F1500
M204 S6000
G1 X79.1 Y96.042 E.00126
; WIPE_START
G1 X78.959 Y95.637 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
M73 P64 R9
G1 X84.63 Y97.174 Z3.36 F18000
G1 Z2.96
G1 E.4 F1800
; LINE_WIDTH: 0.475788
G1 F1500
M204 S6000
G1 X84.403 Y97.362 E.00662
; LINE_WIDTH: 0.44441
G1 X84.273 Y97.482 E.00369
; LINE_WIDTH: 0.404393
G1 X84.125 Y97.621 E.00385
; LINE_WIDTH: 0.360548
G1 X83.78 Y97.995 E.00849
G1 X83.565 Y98.297 E.00619
G1 X83.385 Y98.626 E.00627
G1 X83.2 Y99.117 E.00877
G1 X83.119 Y99.536 E.00713
G1 X83.101 Y99.891 E.00594
G1 X83.119 Y100.273 E.00639
G1 X83.254 Y100.853 E.00993
G1 X83.508 Y101.421 E.0104
G1 X83.71 Y101.714 E.00595
G1 X83.942 Y101.984 E.00594
G1 X84.276 Y102.285 E.00751
G1 X84.74 Y102.576 E.00915
G1 X85.144 Y102.744 E.00731
G1 X85.464 Y102.83 E.00553
G1 X85.825 Y102.888 E.00611
G1 X86.352 Y102.888 E.00879
G1 X86.713 Y102.832 E.0061
G1 X87.066 Y102.739 E.0061
G1 X87.56 Y102.518 E.00904
G1 X88.048 Y102.176 E.00996
G1 X88.384 Y101.835 E.00799
G1 X88.474 Y101.729 E.00232
G1 X88.68 Y101.415 E.00628
G1 X88.802 Y101.187 E.00431
G1 X88.904 Y100.951 E.0043
G1 X89.027 Y100.513 E.00759
G1 X89.09 Y100.062 E.0076
G1 X89.073 Y99.536 E.0088
G1 X88.961 Y99.013 E.00892
G1 X88.764 Y98.53 E.00872
G1 X88.477 Y98.077 E.00895
G1 X88.225 Y97.788 E.0064
; LINE_WIDTH: 0.384615
G1 X87.954 Y97.515 E.00688
; LINE_WIDTH: 0.43271
G1 X87.749 Y97.339 E.0055
; LINE_WIDTH: 0.476889
G1 X87.543 Y97.163 E.00609
; WIPE_START
G1 X87.749 Y97.339 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X94.029 Y95.546 Z3.36 F18000
G1 Z2.96
G1 E.4 F1800
; LINE_WIDTH: 0.152252
G1 F1500
M204 S6000
G1 X94.523 Y95.356 E.00334
; LINE_WIDTH: 0.103916
G1 X95.017 Y95.165 E.00206
; WIPE_START
G1 X94.523 Y95.356 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X94.798 Y87.728 Z3.36 F18000
G1 X94.838 Y86.601 Z3.36
G1 Z2.96
G1 E.4 F1800
; LINE_WIDTH: 0.114562
G1 F1500
M204 S6000
G1 X93.75 Y86.601 E.00482
; WIPE_START
G1 X94.838 Y86.601 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X88.388 Y82.521 Z3.36 F18000
G1 X79.588 Y76.954 Z3.36
G1 Z2.96
G1 E.4 F1800
; LINE_WIDTH: 0.0926129
G1 F1500
M204 S6000
G1 X79.491 Y76.988 E.00034
; LINE_WIDTH: 0.130115
G1 X79.289 Y77.079 E.00115
; LINE_WIDTH: 0.152774
G1 X79.167 Y77.191 E.00105
G1 X79.043 Y77.346 E.00126
G1 X79.003 Y77.423 E.00055
; LINE_WIDTH: 0.100254
M73 P64 R8
G1 X78.951 Y77.598 E.00068
; WIPE_START
G1 X79.003 Y77.423 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X85.906 Y80.679 Z3.36 F18000
G1 X100.371 Y87.504 Z3.36
G1 Z2.96
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X100.647 Y87.111 E.00944
G1 X101.108 Y87.434 E.01108
G1 X101.613 Y87.787 E.01213
G1 X101.338 Y88.181 E.00944
G1 X100.42 Y87.538 E.02203
M204 S10000
G1 X100.676 Y87.425 F18000
; FEATURE: Gap infill
; LINE_WIDTH: 0.0965091
G1 F1500
M204 S6000
G1 X101.308 Y87.867 E.00272
; CHANGE_LAYER
; Z_HEIGHT: 2.98
; LAYER_HEIGHT: 0.02
; WIPE_START
G1 F1500
G1 X100.676 Y87.425 E-.38
; WIPE_END
G1 E-.02 F1800
; layer num/total_layer_count: 28/57
; update layer progress
M73 L28
M991 S0 P27 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z3.36 I-1.178 J-.306 P1  F18000
G1 X99.967 Y90.161 Z3.36
G1 Z2.98
G1 E.4 F1800
; FEATURE: Support
; LINE_WIDTH: 0.42
; LAYER_HEIGHT: 0.26
G1 F1267.254
M204 S6000
G1 X99.85 Y90.328 E.00802
G1 X99.381 Y90 E.02254
G1 X100.08 Y90 E.02751
G1 X100.886 Y88.849 E.05531
G1 X99.898 Y88.157 E.04748
G1 X98.862 Y89.637 E.07109
G1 X99.219 Y89.887 E.01718
; WIPE_START
G1 X98.862 Y89.637 E-.08292
G1 X99.759 Y88.356 E-.29708
; WIPE_END
G1 E-.02 F1800
M204 S10000
G17
G3 Z3.38 I1.217 J0 P1  F18000
;===================== date: 20250206 =====================

; don't support timelapse gcode in spiral_mode and by object sequence for I3 structure printer
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
G92 E0
G1 Z3.38
G1 X0 Y90 ; move to safe pos
G1 X-13.0 F3000 ; move to safe pos
M400
M1004 S5 P1  ; external shutter
M400 P300
M971 S11 C11 O0
G92 E0
G1 X0 F18000
M623

; SKIPTYPE: head_wrap_detect
M622.1 S1
M1002 judge_flag g39_3rd_layer_detect_flag
M622 J1
    ; enable nozzle clog detect at 3rd layer
    


    M622.1 S1
    M1002 judge_flag g39_detection_flag
    M622 J1
      
        M622.1 S0
        M1002 judge_flag g39_mass_exceed_flag
        M622 J1
        
            G392 S0
            M400
            G90
            M83
            M204 S5000
            G0 Z3.38 F4000
            G39.3 S1
            G0 Z3.38 F4000
            G392 S0
          
        M623
    
    M623
M623
; SKIPPABLE_END




; CHANGE_LAYER
; Z_HEIGHT: 3.08
; LAYER_HEIGHT: 0.0999999
; layer num/total_layer_count: 29/57
; update layer progress
M73 L29
M991 S0 P28 ;notify layer change
; OBJECT_ID: 8
G1 X95.222 Y86.344
G1 Z3.08
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
; LAYER_HEIGHT: 0.12
G1 F1500
M204 S500
G1 X95.222 Y86.857 E.01086
G1 X93.538 Y86.857 E.03564
G1 X93.538 Y86.344 E.01086
G1 X95.162 Y86.344 E.03437
M204 S10000
G1 X95.646 Y85.92 F18000
G1 F1500
M204 S500
G1 X95.646 Y87.282 E.02882
G1 X93.475 Y87.282 E.04595
G1 X93.475 Y88.382 E.02328
G1 X93.114 Y88.382 E.00765
G1 X93.114 Y77.127 E.23821
G1 X93.292 Y77.071 E.00395
G1 X93.355 Y77.162 E.00234
G1 X93.42 Y77.3 E.00324
G1 X93.459 Y77.448 E.00324
G1 X93.475 Y77.628 E.00382
G1 X93.475 Y85.92 E.17551
G1 X95.586 Y85.92 E.04468
; WIPE_START
M204 S6000
G1 X95.646 Y87.282 E-.25894
G1 X95.009 Y87.282 E-.12106
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X93.781 Y94.815 Z3.48 F18000
G1 X93.658 Y95.567 Z3.48
G1 Z3.08
G1 E.4 F1800
G1 F1500
M204 S500
G1 X93.122 Y95.806 E.01244
G1 X93.151 Y95.447 E.00762
G1 X93.232 Y95.35 E.00267
G1 X93.317 Y95.354 E.00181
G1 X93.369 Y95.368 E.00114
G1 X93.609 Y95.533 E.00615
; WIPE_START
M204 S6000
G1 X93.122 Y95.806 E-.14388
G1 X93.151 Y95.447 E-.09279
G1 X93.232 Y95.35 E-.03252
G1 X93.317 Y95.354 E-.02209
G1 X93.369 Y95.368 E-.01387
G1 X93.609 Y95.533 E-.07486
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X86.099 Y96.898 Z3.48 F18000
G1 X84.86 Y97.124 Z3.48
G1 Z3.08
G1 E.4 F1800
G1 F1500
M204 S500
G1 X84.743 Y96.96 E.00425
G1 X85.105 Y96.544 E.01167
G1 X87.084 Y96.544 E.04188
G1 X87.437 Y96.951 E.01141
G1 X87.314 Y97.116 E.00436
G1 X86.846 Y96.949 E.01052
G1 X86.322 Y96.862 E.01123
G1 X85.767 Y96.87 E.01176
G1 X85.168 Y96.999 E.01297
G1 X84.915 Y97.101 E.00577
; WIPE_START
M204 S6000
G1 X84.743 Y96.96 E-.0423
G1 X85.105 Y96.544 E-.10479
G1 X86.331 Y96.544 E-.23292
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X83.48 Y99.779 Z3.48 F18000
G1 Z3.08
G1 E.4 F1800
G1 F1500
M204 S500
G1 X83.479 Y99.755 E.00052
G1 X83.505 Y99.498 E.00546
G1 X83.615 Y99.049 E.00979
G1 X83.84 Y98.565 E.01128
G1 X84.067 Y98.241 E.00838
G1 X84.284 Y98.007 E.00675
G1 X84.53 Y97.798 E.00683
G1 X84.918 Y97.558 E.00967
G1 X85.293 Y97.406 E.00856
G1 X85.815 Y97.294 E.0113
G1 X86.29 Y97.286 E.01006
G1 X86.745 Y97.362 E.00975
G1 X87.052 Y97.462 E.00683
G1 X87.345 Y97.597 E.00683
G1 X87.729 Y97.851 E.00975
G1 X88.073 Y98.18 E.01007
G1 X88.384 Y98.624 E.01148
G1 X88.595 Y99.114 E.0113
G1 X88.673 Y99.433 E.00694
G1 X88.711 Y99.753 E.00683
G1 X88.698 Y100.201 E.00949
G1 X88.654 Y100.456 E.00546
G1 X88.547 Y100.825 E.00815
G1 X88.345 Y101.245 E.00987
G1 X88.071 Y101.623 E.00987
G1 X87.781 Y101.906 E.00858
G1 X87.342 Y102.207 E.01127
G1 X86.913 Y102.391 E.00987
G1 X86.601 Y102.472 E.00683
G1 X86.281 Y102.515 E.00683
G1 X85.82 Y102.508 E.00975
G1 X85.359 Y102.417 E.00995
G1 X84.93 Y102.249 E.00975
G1 X84.651 Y102.088 E.00683
G1 X84.4 Y101.9 E.00664
G1 X84.174 Y101.683 E.00663
G1 X83.969 Y101.434 E.00683
G1 X83.732 Y101.038 E.00975
G1 X83.567 Y100.598 E.00995
G1 X83.484 Y100.14 E.00987
G1 X83.48 Y99.839 E.00636
M204 S250
G1 X83.889 Y99.774 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X83.889 Y99.773 E.00004
G1 X83.909 Y99.567 E.00406
G1 X84.003 Y99.185 E.00775
G1 X84.195 Y98.771 E.00899
G1 X84.386 Y98.498 E.00653
G1 X84.567 Y98.303 E.00524
G1 X84.771 Y98.13 E.00526
G1 X85.104 Y97.924 E.00771
G1 X85.414 Y97.798 E.00658
G1 X85.862 Y97.702 E.009
G1 X86.26 Y97.696 E.00783
G1 X86.648 Y97.761 E.00773
G1 X86.902 Y97.843 E.00526
G1 X87.145 Y97.956 E.00526
G1 X87.473 Y98.172 E.00773
G1 X87.761 Y98.448 E.00784
G1 X88.025 Y98.824 E.00905
G1 X88.205 Y99.245 E.009
G1 X88.269 Y99.506 E.0053
G1 X88.301 Y99.772 E.00526
G1 X88.29 Y100.161 E.00765
G1 X88.255 Y100.364 E.00406
G1 X88.164 Y100.679 E.00645
G1 X87.992 Y101.035 E.00777
G1 X87.76 Y101.354 E.00777
G1 X87.521 Y101.589 E.00659
G1 X87.144 Y101.847 E.00898
G1 X86.781 Y102.002 E.00777
G1 X86.522 Y102.07 E.00526
G1 X86.256 Y102.106 E.00526
G1 X85.863 Y102.1 E.00773
G1 X85.474 Y102.023 E.0078
G1 X85.108 Y101.879 E.00773
G1 X84.877 Y101.746 E.00526
G1 X84.665 Y101.587 E.0052
G1 X84.474 Y101.404 E.0052
G1 X84.304 Y101.198 E.00526
G1 X84.102 Y100.86 E.00774
G1 X83.963 Y100.489 E.0078
G1 X83.893 Y100.1 E.00777
G1 X83.889 Y99.834 E.00523
; WIPE_START
M204 S6000
G1 X83.889 Y99.773 E-.01174
G1 X83.909 Y99.567 E-.03919
G1 X84.003 Y99.185 E-.07482
G1 X84.195 Y98.771 E-.0868
G1 X84.386 Y98.498 E-.0631
G1 X84.567 Y98.303 E-.0506
G1 X84.771 Y98.13 E-.05082
G1 X84.784 Y98.122 E-.00292
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X84.855 Y96.12 Z3.48 F18000
G1 Z3.08
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X92.678 Y96.12 E.16558
G1 X92.718 Y95.441 E.01439
G1 X92.743 Y95.322 E.00258
G1 X92.851 Y95.128 E.00469
G1 X92.935 Y95.048 E.00246
G1 X93.08 Y94.963 E.00355
G1 X93.234 Y94.926 E.00336
G1 X93.384 Y94.932 E.00317
G1 X93.534 Y94.974 E.0033
G1 X93.961 Y95.261 E.0109
G1 X95.879 Y94.633 E.04271
G1 X98.51 Y90.875 E.09709
G1 X98.806 Y91.083 E.00765
G1 X96.105 Y94.94 E.09967
G1 X93.236 Y96.22 E.06649
G1 X93.08 Y96.334 E.0041
G1 X92.938 Y96.409 E.00339
G1 X92.803 Y96.453 E.00301
G1 X92.559 Y96.482 E.0052
G1 X87.592 Y96.482 E.10514
G1 X88.777 Y97.845 E.03824
G1 X88.884 Y97.992 E.00385
G1 X89.099 Y98.353 E.00888
G1 X89.323 Y98.901 E.01254
G1 X89.45 Y99.489 E.01273
G1 X89.469 Y100.085 E.01261
G1 X89.402 Y100.587 E.01071
G1 X89.262 Y101.078 E.01081
G1 X89.01 Y101.611 E.01248
G1 X88.785 Y101.947 E.00856
G1 X88.384 Y102.387 E.0126
G1 X88.149 Y102.583 E.00648
G1 X87.737 Y102.855 E.01044
G1 X87.188 Y103.099 E.01273
G1 X86.792 Y103.208 E.00869
G1 X86.386 Y103.269 E.00868
G1 X85.794 Y103.267 E.01254
G1 X85.201 Y103.161 E.01274
G1 X84.638 Y102.951 E.01272
G1 X84.287 Y102.757 E.0085
G1 X83.961 Y102.522 E.00849
G1 X83.666 Y102.251 E.00849
G1 X83.404 Y101.947 E.00849
G1 X83.181 Y101.613 E.0085
G1 X82.998 Y101.256 E.00849
G1 X82.86 Y100.879 E.00849
G1 X82.768 Y100.494 E.00838
G1 X82.718 Y99.991 E.01071
G1 X82.741 Y99.484 E.01074
G1 X82.814 Y99.086 E.00857
G1 X83.007 Y98.526 E.01253
G1 X83.192 Y98.17 E.0085
G1 X83.417 Y97.838 E.00849
G1 X84.597 Y96.482 E.03805
G1 X79.631 Y96.482 E.10512
G1 X79.38 Y96.452 E.00535
G1 X79.27 Y96.418 E.00243
G1 X79.074 Y96.31 E.00475
G1 X78.886 Y96.122 E.00562
G1 X78.791 Y95.957 E.00402
G1 X78.743 Y95.812 E.00324
G1 X78.714 Y95.565 E.00527
G1 X78.714 Y77.619 E.37984
G1 X78.755 Y77.34 E.00597
G1 X78.86 Y77.118 E.0052
G1 X79.049 Y76.912 E.00592
G1 X79.297 Y76.774 E.00601
G1 X79.549 Y76.723 E.00543
G1 X92.608 Y76.721 E.2764
G1 X92.743 Y76.735 E.00289
G1 X92.895 Y76.775 E.00332
G1 X93.124 Y76.904 E.00556
G1 X93.068 Y77.082 E.00395
G1 X80.04 Y77.082 E.27575
G1 X79.752 Y77.133 E.00621
G1 X79.474 Y77.282 E.00668
G1 X79.241 Y77.529 E.00717
G1 X79.112 Y77.807 E.00649
G1 X79.075 Y78.056 E.00533
G1 X79.075 Y95.173 E.3623
G1 X79.16 Y95.53 E.00775
G1 X79.316 Y95.767 E.00601
G1 X79.531 Y95.958 E.0061
G1 X79.8 Y96.084 E.00629
G1 X80.049 Y96.12 E.00533
G1 X84.795 Y96.12 E.10045
; WIPE_START
M204 S6000
G1 X86.795 Y96.12 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X83.699 Y96.891 Z3.48 F18000
G1 Z3.08
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X79.607 Y96.891 E.08049
G1 X79.293 Y96.854 E.00621
G1 X79.119 Y96.799 E.00359
G1 X78.948 Y96.717 E.00372
G1 X78.683 Y96.512 E.00659
G1 X78.478 Y96.246 E.00661
G1 X78.412 Y96.114 E.00289
G1 X78.341 Y95.901 E.00442
G1 X78.304 Y95.589 E.00619
G1 X78.304 Y77.607 E.35368
G1 X78.313 Y77.454 E.00301
G1 X78.36 Y77.228 E.00454
G1 X78.409 Y77.093 E.00283
G1 X78.517 Y76.893 E.00448
G1 X78.657 Y76.715 E.00445
G1 X78.795 Y76.59 E.00366
G1 X78.949 Y76.485 E.00367
G1 X79.155 Y76.389 E.00447
G1 X79.334 Y76.339 E.00365
G1 X79.521 Y76.313 E.00373
G1 X92.628 Y76.312 E.2578
G1 X92.817 Y76.331 E.00374
G1 X93.035 Y76.389 E.00444
G1 X93.239 Y76.484 E.00442
G1 X93.423 Y76.613 E.00442
G1 X93.582 Y76.772 E.00442
G1 X93.711 Y76.956 E.00442
G1 X93.806 Y77.16 E.00442
G1 X93.864 Y77.377 E.00442
G1 X93.884 Y77.61 E.0046
G1 X93.884 Y85.511 E.1554
G1 X95.925 Y85.511 E.04013
G1 F1870.275
G1 X96.055 Y85.511 E.00256
G1 F1320
G1 X96.055 Y87.691 E.04288
G1 F1668.612
G1 X95.925 Y87.691 E.00256
G1 F1500
G1 X93.884 Y87.691 E.04013
G1 X93.884 Y88.791 E.02164
G1 X92.704 Y88.791 E.02321
G1 X92.704 Y77.491 E.22226
G1 X80.076 Y77.491 E.24839
G1 X79.888 Y77.524 E.00376
G1 X79.726 Y77.611 E.00361
G1 X79.584 Y77.762 E.00406
M73 P65 R8
G1 X79.508 Y77.925 E.00355
G1 X79.484 Y78.086 E.00319
G1 X79.484 Y95.125 E.33516
G1 X79.541 Y95.365 E.00484
G1 X79.628 Y95.497 E.0031
G1 X79.758 Y95.612 E.00343
G1 X79.919 Y95.687 E.00349
G1 X80.079 Y95.711 E.00319
G1 X92.292 Y95.711 E.24022
G1 X92.312 Y95.386 E.00639
G1 X92.349 Y95.208 E.00359
G1 X92.477 Y94.943 E.00577
G1 X92.675 Y94.729 E.00574
G1 X92.927 Y94.582 E.00575
G1 X93.209 Y94.516 E.00569
G1 X93.448 Y94.524 E.00471
G1 X93.68 Y94.59 E.00475
G1 X93.777 Y94.637 E.00213
G1 X94.027 Y94.809 E.00595
G1 X95.622 Y94.286 E.03302
G1 X98.41 Y90.305 E.09559
G1 X99.376 Y90.982 E.02321
G1 X96.375 Y95.268 E.10291
G1 X93.442 Y96.576 E.06316
G1 X93.298 Y96.682 E.00353
G1 X93.099 Y96.787 E.00443
G1 X92.891 Y96.855 E.0043
G1 X92.582 Y96.891 E.00611
G1 X88.49 Y96.891 E.08049
G1 X89.098 Y97.59 E.01823
G1 X89.226 Y97.767 E.0043
G1 X89.46 Y98.159 E.00897
G1 X89.555 Y98.356 E.00431
G1 X89.715 Y98.78 E.00891
G1 X89.823 Y99.22 E.00891
G1 X89.877 Y99.661 E.00873
G1 X89.878 Y100.112 E.00887
G1 X89.803 Y100.67 E.01108
G1 X89.649 Y101.214 E.01113
G1 X89.518 Y101.521 E.00657
G1 X89.362 Y101.82 E.00663
G1 X89.111 Y102.195 E.00887
G1 X88.816 Y102.538 E.00891
G1 X88.398 Y102.908 E.01098
G1 X87.93 Y103.216 E.01101
G1 X87.519 Y103.413 E.00897
G1 X87.314 Y103.489 E.0043
G1 X86.877 Y103.609 E.00891
G1 X86.429 Y103.676 E.00891
G1 X86.21 Y103.689 E.00431
G1 X85.757 Y103.676 E.00891
G1 X85.309 Y103.608 E.00891
G1 X84.881 Y103.491 E.00873
G1 X84.462 Y103.321 E.00891
G1 X84.068 Y103.103 E.00885
G1 X83.703 Y102.84 E.00885
G1 X83.371 Y102.536 E.00885
G1 X83.078 Y102.195 E.00885
G1 X82.827 Y101.821 E.00885
G1 X82.623 Y101.42 E.00885
G1 X82.467 Y100.998 E.00885
G1 X82.363 Y100.562 E.00882
G1 X82.308 Y100.002 E.01107
G1 X82.333 Y99.438 E.01111
G1 X82.415 Y98.994 E.00887
G1 X82.473 Y98.783 E.00431
G1 X82.633 Y98.359 E.00891
G1 X82.84 Y97.96 E.00885
G1 X83.093 Y97.588 E.00885
G1 X83.659 Y96.936 E.01698
; WIPE_START
M204 S6000
G1 X81.66 Y96.914 E-.38
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




G1 X79.578 Y96.239
G1 Z3.08
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.100771
G1 F1500
M204 S6000
G1 X79.38 Y96.175 E.00078
; LINE_WIDTH: 0.153872
G1 X79.177 Y96.023 E.00162
G1 X79.044 Y95.851 E.00139
; LINE_WIDTH: 0.130087
G1 X79.001 Y95.749 E.00058
; LINE_WIDTH: 0.0946488
G1 X78.957 Y95.646 E.00038
; WIPE_START
G1 X79.001 Y95.749 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X84.633 Y97.171 Z3.48 F18000
G1 Z3.08
G1 E.4 F1800
; LINE_WIDTH: 0.474809
G1 F1500
M204 S6000
G1 X84.466 Y97.313 E.00491
; LINE_WIDTH: 0.441783
G1 X84.277 Y97.475 E.00517
; LINE_WIDTH: 0.408499
G1 X84.151 Y97.599 E.00337
; LINE_WIDTH: 0.359987
G1 X83.766 Y98.012 E.00943
G1 X83.518 Y98.364 E.00717
G1 X83.361 Y98.681 E.0059
G1 X83.268 Y98.91 E.00412
G1 X83.188 Y99.177 E.00465
G1 X83.12 Y99.527 E.00594
G1 X83.1 Y99.981 E.00757
G1 X83.147 Y100.431 E.00754
G1 X83.225 Y100.769 E.00579
G1 X83.387 Y101.189 E.0075
G1 X83.653 Y101.641 E.00876
G1 X83.903 Y101.948 E.0066
G1 X84.202 Y102.227 E.00682
G1 X84.491 Y102.435 E.00594
G1 X84.802 Y102.607 E.00594
G1 X85.268 Y102.783 E.0083
G1 X85.825 Y102.888 E.00946
G1 X86.316 Y102.892 E.00818
G1 X86.713 Y102.835 E.00669
G1 X87.066 Y102.739 E.0061
G1 X87.538 Y102.531 E.0086
G1 X87.916 Y102.279 E.00757
G1 X88.241 Y101.992 E.00722
G1 X88.479 Y101.714 E.00611
G1 X88.682 Y101.42 E.00597
G1 X88.906 Y100.948 E.0087
G1 X89.03 Y100.509 E.00761
G1 X89.085 Y100.063 E.00751
G1 X89.07 Y99.536 E.00878
G1 X88.96 Y99.014 E.0089
G1 X88.76 Y98.532 E.0087
G1 X88.473 Y98.08 E.00893
G1 X88.347 Y97.923 E.00336
; LINE_WIDTH: 0.376388
G1 X87.991 Y97.549 E.00903
; LINE_WIDTH: 0.403707
G1 X87.964 Y97.523 E.00071
; LINE_WIDTH: 0.43025
G1 X87.754 Y97.343 E.00558
; LINE_WIDTH: 0.476079
G1 X87.544 Y97.163 E.00622
; WIPE_START
G1 X87.754 Y97.343 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X94.012 Y95.553 Z3.48 F18000
G1 Z3.08
G1 E.4 F1800
; LINE_WIDTH: 0.153717
G1 F1500
M204 S6000
G1 X94.514 Y95.359 E.00344
; LINE_WIDTH: 0.104404
G1 X95.017 Y95.165 E.00211
; WIPE_START
G1 X94.514 Y95.359 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X94.945 Y87.739 Z3.48 F18000
G1 X95.01 Y86.601 Z3.48
G1 Z3.08
G1 E.4 F1800
; LINE_WIDTH: 0.114562
G1 F1500
M204 S6000
G1 X93.75 Y86.601 E.00558
; WIPE_START
G1 X95.01 Y86.601 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X88.539 Y82.553 Z3.48 F18000
G1 X79.59 Y76.953 Z3.48
G1 Z3.08
G1 E.4 F1800
; LINE_WIDTH: 0.0922727
G1 F1500
M204 S6000
G1 X79.489 Y76.99 E.00036
; LINE_WIDTH: 0.129857
G1 X79.29 Y77.079 E.00114
; LINE_WIDTH: 0.154145
G1 X79.168 Y77.19 E.00106
G1 X79.019 Y77.388 E.00158
; LINE_WIDTH: 0.0995622
G1 X78.949 Y77.601 E.00083
; WIPE_START
G1 X79.019 Y77.388 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X85.917 Y80.655 Z3.48 F18000
G1 X100.371 Y87.504 Z3.48
G1 Z3.08
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X100.647 Y87.111 E.00944
G1 X101.134 Y87.452 E.01171
G1 X101.613 Y87.787 E.0115
G1 X101.338 Y88.181 E.00944
G1 X100.42 Y87.538 E.02203
M204 S10000
G1 X100.676 Y87.425 F18000
; FEATURE: Gap infill
; LINE_WIDTH: 0.0965153
G1 F1500
M204 S6000
G1 X101.308 Y87.867 E.00272
; CHANGE_LAYER
; Z_HEIGHT: 3.2
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F1500
G1 X100.676 Y87.425 E-.38
; WIPE_END
G1 E-.02 F1800
; layer num/total_layer_count: 30/57
; update layer progress
M73 L30
M991 S0 P29 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z3.48 I.244 J-1.192 P1  F18000
G1 X95.393 Y86.344 Z3.48
G1 Z3.2
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X95.393 Y86.857 E.01086
G1 X93.538 Y86.857 E.03927
G1 X93.538 Y86.344 E.01086
G1 X95.333 Y86.344 E.038
M204 S10000
G1 X95.817 Y85.92 F18000
G1 F1500
M204 S500
G1 X95.817 Y87.282 E.02882
G1 X93.475 Y87.282 E.04957
G1 X93.475 Y88.382 E.02328
G1 X93.114 Y88.382 E.00765
G1 X93.114 Y77.127 E.23821
G1 X93.292 Y77.071 E.00395
G1 X93.355 Y77.162 E.00234
G1 X93.42 Y77.3 E.00324
G1 X93.459 Y77.448 E.00324
G1 X93.475 Y77.628 E.00382
G1 X93.475 Y85.92 E.17551
G1 X95.757 Y85.92 E.0483
; WIPE_START
M204 S6000
G1 X95.817 Y87.282 E-.25894
G1 X95.18 Y87.282 E-.12106
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X93.807 Y94.79 Z3.6 F18000
G1 X93.665 Y95.564 Z3.6
G1 Z3.2
G1 E.4 F1800
G1 F1500
M204 S500
G1 X93.122 Y95.806 E.0126
G1 X93.14 Y95.498 E.00653
G1 X93.162 Y95.423 E.00167
G1 X93.204 Y95.372 E.00139
G1 X93.32 Y95.341 E.00253
G1 X93.615 Y95.531 E.00743
; WIPE_START
M204 S6000
G1 X93.122 Y95.806 E-.14414
G1 X93.14 Y95.498 E-.07881
G1 X93.162 Y95.423 E-.02013
G1 X93.204 Y95.372 E-.01671
G1 X93.32 Y95.341 E-.03055
G1 X93.615 Y95.531 E-.08966
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X86.104 Y96.889 Z3.6 F18000
G1 X84.863 Y97.113 Z3.6
G1 Z3.2
G1 E.4 F1800
G1 F1500
M204 S500
G1 X84.752 Y96.951 E.00416
G1 X85.105 Y96.544 E.0114
G1 X87.083 Y96.544 E.04187
G1 X87.443 Y96.958 E.0116
G1 X87.332 Y97.12 E.00416
G1 X86.861 Y96.951 E.01059
G1 X86.322 Y96.862 E.01156
G1 X85.776 Y96.87 E.01156
G1 X85.255 Y96.972 E.01123
G1 X84.919 Y97.093 E.00756
; WIPE_START
M204 S6000
G1 X84.752 Y96.951 E-.04172
G1 X85.105 Y96.544 E-.10235
G1 X86.347 Y96.544 E-.23593
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X83.482 Y99.751 Z3.6 F18000
G1 Z3.2
G1 E.4 F1800
G1 F1500
M204 S500
G1 X83.503 Y99.51 E.00513
G1 X83.57 Y99.195 E.00683
G1 X83.732 Y98.763 E.00975
G1 X83.976 Y98.355 E.01006
G1 X84.338 Y97.955 E.01143
G1 X84.771 Y97.638 E.01135
G1 X85.065 Y97.491 E.00695
G1 X85.368 Y97.382 E.00683
G1 X85.82 Y97.294 E.00975
G1 X86.29 Y97.286 E.00995
G1 X86.754 Y97.363 E.00995
G1 X87.193 Y97.521 E.00987
G1 X87.526 Y97.708 E.00809
G1 X87.73 Y97.854 E.00531
G1 X87.961 Y98.062 E.00657
G1 X88.173 Y98.305 E.00683
G1 X88.421 Y98.693 E.00975
G1 X88.6 Y99.128 E.00995
G1 X88.697 Y99.588 E.00995
G1 X88.711 Y100.058 E.00995
G1 X88.643 Y100.513 E.00975
G1 X88.548 Y100.822 E.00683
G1 X88.416 Y101.116 E.00683
G1 X88.168 Y101.505 E.00975
G1 X87.855 Y101.842 E.00975
G1 X87.603 Y102.044 E.00683
G1 X87.328 Y102.213 E.00683
G1 X86.905 Y102.394 E.00975
G1 X86.455 Y102.497 E.00975
G1 X86.134 Y102.521 E.00683
G1 X85.811 Y102.506 E.00683
G1 X85.359 Y102.417 E.00975
G1 X84.922 Y102.246 E.00995
G1 X84.522 Y101.999 E.00995
G1 X84.179 Y101.69 E.00975
G1 X83.975 Y101.441 E.00683
G1 X83.801 Y101.169 E.00683
G1 X83.613 Y100.748 E.00975
G1 X83.502 Y100.292 E.00995
G1 X83.474 Y99.832 E.00975
G1 X83.476 Y99.811 E.00044
M204 S250
M73 P66 R8
G1 X83.889 Y99.788 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X83.909 Y99.571 E.00428
G1 X83.964 Y99.31 E.00526
G1 X84.102 Y98.942 E.00773
G1 X84.307 Y98.6 E.00783
G1 X84.613 Y98.26 E.009
G1 X84.985 Y97.989 E.00905
G1 X85.226 Y97.868 E.0053
G1 X85.478 Y97.778 E.00526
G1 X85.863 Y97.702 E.00773
G1 X86.26 Y97.696 E.00779
G1 X86.651 Y97.761 E.0078
G1 X87.023 Y97.894 E.00777
G1 X87.306 Y98.054 E.0064
G1 X87.473 Y98.173 E.00404
G1 X87.669 Y98.35 E.00518
G1 X87.845 Y98.551 E.00526
G1 X88.057 Y98.882 E.00774
G1 X88.207 Y99.249 E.0078
G1 X88.289 Y99.637 E.0078
G1 X88.301 Y100.033 E.0078
G1 X88.243 Y100.422 E.00773
G1 X88.164 Y100.678 E.00526
G1 X88.055 Y100.922 E.00526
G1 X87.843 Y101.253 E.00773
G1 X87.576 Y101.541 E.00773
G1 X87.367 Y101.708 E.00526
G1 X87.139 Y101.849 E.00526
G1 X86.778 Y102.004 E.00774
G1 X86.394 Y102.091 E.00774
G1 X86.127 Y102.111 E.00526
G1 X85.86 Y102.099 E.00526
G1 X85.474 Y102.023 E.00774
G1 X85.105 Y101.878 E.0078
G1 X84.768 Y101.67 E.0078
G1 X84.476 Y101.407 E.00773
G1 X84.306 Y101.2 E.00526
G1 X84.162 Y100.975 E.00526
G1 X84.002 Y100.615 E.00773
G1 X83.908 Y100.23 E.0078
G1 X83.885 Y99.848 E.00754
; WIPE_START
M204 S6000
G1 X83.909 Y99.571 E-.05274
G1 X83.964 Y99.31 E-.05083
G1 X84.102 Y98.942 E-.0747
G1 X84.307 Y98.6 E-.07564
G1 X84.613 Y98.26 E-.08693
G1 X84.78 Y98.139 E-.03917
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X84.856 Y96.12 Z3.6 F18000
G1 Z3.2
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X92.678 Y96.12 E.16556
G1 X92.718 Y95.441 E.01439
G1 X92.742 Y95.331 E.00238
G1 X92.81 Y95.184 E.00344
G1 X92.887 Y95.09 E.00257
G1 X93.072 Y94.968 E.00468
G1 X93.272 Y94.922 E.00435
G1 X93.443 Y94.941 E.00364
G1 X93.539 Y94.978 E.00218
G1 X93.972 Y95.257 E.01091
G1 X95.879 Y94.633 E.04247
G1 X98.51 Y90.875 E.09709
G1 X98.806 Y91.083 E.00765
G1 X96.105 Y94.94 E.09967
G1 X93.244 Y96.216 E.06631
G1 X93.021 Y96.37 E.00573
G1 X92.803 Y96.453 E.00495
G1 X92.559 Y96.482 E.0052
G1 X87.591 Y96.482 E.10514
G1 X88.777 Y97.845 E.03825
G1 X88.884 Y97.992 E.00385
G1 X89.099 Y98.353 E.00889
G1 X89.326 Y98.91 E.01273
G1 X89.451 Y99.499 E.01273
G1 X89.469 Y100.085 E.01242
G1 X89.402 Y100.582 E.01062
G1 X89.261 Y101.084 E.01103
G1 X89.011 Y101.609 E.0123
G1 X88.724 Y102.02 E.01062
G1 X88.373 Y102.397 E.0109
G1 X88.152 Y102.58 E.00607
G1 X87.737 Y102.855 E.01053
G1 X87.367 Y103.032 E.00869
G1 X86.978 Y103.164 E.00869
G1 X86.386 Y103.269 E.01273
G1 X85.794 Y103.267 E.01254
G1 X85.202 Y103.161 E.01273
G1 X84.638 Y102.951 E.01273
G1 X84.287 Y102.757 E.00849
G1 X83.961 Y102.522 E.00849
G1 X83.666 Y102.251 E.00849
G1 X83.404 Y101.947 E.00849
G1 X83.184 Y101.618 E.00838
G1 X82.963 Y101.167 E.01061
G1 X82.808 Y100.685 E.01072
G1 X82.73 Y100.196 E.01049
G1 X82.722 Y99.684 E.01084
G1 X82.77 Y99.291 E.00837
G1 X82.866 Y98.901 E.00849
G1 X83.007 Y98.526 E.00849
G1 X83.192 Y98.17 E.0085
G1 X83.417 Y97.838 E.00849
G1 X84.598 Y96.482 E.03805
G1 X79.631 Y96.482 E.10513
G1 X79.299 Y96.429 E.0071
G1 X79.065 Y96.303 E.00562
G1 X78.904 Y96.145 E.00478
G1 X78.83 Y96.036 E.00278
G1 X78.743 Y95.812 E.00509
G1 X78.714 Y95.565 E.00527
G1 X78.714 Y77.619 E.37984
G1 X78.755 Y77.34 E.00597
G1 X78.86 Y77.118 E.0052
G1 X79.048 Y76.913 E.00589
G1 X79.297 Y76.774 E.00604
G1 X79.549 Y76.723 E.00543
G1 X92.609 Y76.721 E.27643
G1 X92.743 Y76.735 E.00285
G1 X92.895 Y76.775 E.00332
G1 X93.124 Y76.904 E.00556
G1 X93.068 Y77.082 E.00395
G1 X80.044 Y77.082 E.27566
G1 X79.771 Y77.126 E.00587
G1 X79.481 Y77.277 E.00691
G1 X79.253 Y77.513 E.00694
G1 X79.112 Y77.802 E.00681
G1 X79.075 Y78.056 E.00543
G1 X79.075 Y95.173 E.3623
G1 X79.16 Y95.529 E.00775
G1 X79.315 Y95.766 E.006
G1 X79.53 Y95.958 E.0061
G1 X79.8 Y96.084 E.0063
G1 X80.049 Y96.12 E.00533
G1 X84.796 Y96.12 E.10046
; WIPE_START
M204 S6000
G1 X86.796 Y96.12 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X83.699 Y96.891 Z3.6 F18000
G1 Z3.2
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X79.607 Y96.891 E.08049
G1 X79.291 Y96.854 E.00625
G1 X78.981 Y96.734 E.00654
G1 X78.711 Y96.54 E.00654
G1 X78.582 Y96.399 E.00376
G1 X78.412 Y96.114 E.00652
G1 X78.341 Y95.901 E.00442
G1 X78.304 Y95.589 E.00619
G1 X78.304 Y77.607 E.35368
G1 X78.313 Y77.454 E.00301
G1 X78.36 Y77.228 E.00454
G1 X78.409 Y77.093 E.00283
G1 X78.517 Y76.893 E.00448
G1 X78.657 Y76.715 E.00445
G1 X78.794 Y76.591 E.00362
G1 X78.949 Y76.485 E.0037
G1 X79.155 Y76.389 E.00447
G1 X79.332 Y76.339 E.00362
G1 X79.521 Y76.313 E.00376
G1 X92.63 Y76.312 E.25783
G1 X92.817 Y76.331 E.00371
G1 X93.035 Y76.389 E.00444
G1 X93.239 Y76.484 E.00442
G1 X93.423 Y76.613 E.00442
G1 X93.582 Y76.772 E.00442
G1 X93.711 Y76.956 E.00442
G1 X93.806 Y77.16 E.00442
G1 X93.864 Y77.377 E.00442
G1 X93.884 Y77.61 E.0046
G1 X93.884 Y85.511 E.1554
G1 X96.096 Y85.511 E.0435
G1 F1737.384
G1 X96.181 Y85.511 E.00168
G1 F1680
G1 X96.227 Y85.466 E.00126
G1 F1320
G1 X96.227 Y87.736 E.04466
G1 F1680
G1 X96.181 Y87.691 E.00126
G1 F1930.655
G1 X96.096 Y87.691 E.00168
G1 F1500
G1 X93.884 Y87.691 E.0435
G1 X93.884 Y88.791 E.02164
G1 X92.704 Y88.791 E.02321
G1 X92.704 Y77.491 E.22226
G1 X80.077 Y77.491 E.24836
G1 X79.901 Y77.52 E.00351
G1 X79.728 Y77.609 E.00383
G1 X79.592 Y77.75 E.00385
G1 X79.508 Y77.924 E.00379
G1 X79.484 Y78.086 E.00322
G1 X79.484 Y95.125 E.33516
G1 X79.541 Y95.365 E.00484
G1 X79.628 Y95.496 E.0031
G1 X79.758 Y95.612 E.00343
G1 X79.919 Y95.687 E.00349
G1 X80.079 Y95.711 E.00319
G1 X92.292 Y95.711 E.24022
G1 X92.312 Y95.386 E.00639
G1 X92.349 Y95.211 E.00354
G1 X92.416 Y95.045 E.00353
G1 X92.589 Y94.807 E.00577
G1 X92.674 Y94.73 E.00226
G1 X92.925 Y94.584 E.00571
G1 X93.161 Y94.521 E.00481
G1 X93.451 Y94.524 E.00571
G1 X93.725 Y94.611 E.00565
G1 X94.03 Y94.807 E.00715
G1 X95.622 Y94.286 E.03294
G1 X98.41 Y90.305 E.09559
G1 X99.376 Y90.982 E.02321
G1 X96.375 Y95.268 E.10291
G1 X93.445 Y96.575 E.0631
G1 X93.229 Y96.723 E.00516
G1 X93.102 Y96.786 E.0028
G1 X92.891 Y96.855 E.00437
G1 X92.582 Y96.891 E.00611
G1 X88.49 Y96.891 E.08049
G1 X89.098 Y97.59 E.01823
G1 X89.226 Y97.767 E.0043
G1 X89.46 Y98.159 E.00897
G1 X89.555 Y98.356 E.00431
G1 X89.716 Y98.783 E.00897
G1 X89.774 Y98.994 E.00431
G1 X89.856 Y99.443 E.00897
G1 X89.877 Y99.661 E.0043
G1 X89.878 Y100.112 E.00887
G1 X89.804 Y100.665 E.01099
G1 X89.649 Y101.216 E.01126
G1 X89.568 Y101.417 E.00426
G1 X89.362 Y101.819 E.00887
G1 X89.043 Y102.278 E.01099
G1 X88.654 Y102.695 E.01122
G1 X88.401 Y102.906 E.00647
G1 X87.93 Y103.216 E.0111
G1 X87.521 Y103.412 E.00891
G1 X87.092 Y103.557 E.00891
G1 X86.88 Y103.608 E.00431
G1 X86.429 Y103.676 E.00897
G1 X86.21 Y103.689 E.00431
G1 X85.757 Y103.676 E.00891
G1 X85.309 Y103.608 E.00891
G1 X85.093 Y103.556 E.00437
G1 X84.881 Y103.491 E.00436
G1 X84.462 Y103.321 E.00891
G1 X84.068 Y103.103 E.00885
G1 X83.703 Y102.84 E.00885
G1 X83.371 Y102.536 E.00885
G1 X83.078 Y102.195 E.00885
G1 X82.828 Y101.823 E.00882
G1 X82.583 Y101.321 E.01098
G1 X82.409 Y100.781 E.01116
G1 X82.321 Y100.231 E.01095
G1 X82.312 Y99.662 E.0112
G1 X82.367 Y99.217 E.00881
G1 X82.474 Y98.78 E.00885
G1 X82.633 Y98.359 E.00885
G1 X82.84 Y97.96 E.00885
G1 X83.093 Y97.588 E.00885
G1 X83.66 Y96.936 E.01698
; WIPE_START
M204 S6000
G1 X81.66 Y96.914 E-.38
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




G1 X79.578 Y96.239
G1 Z3.2
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.102666
G1 F1500
M204 S6000
G1 X79.388 Y96.181 E.00076
; LINE_WIDTH: 0.152316
G1 X79.194 Y96.039 E.00152
G1 X79.044 Y95.85 E.00152
; LINE_WIDTH: 0.129927
G1 X79.001 Y95.748 E.00058
; LINE_WIDTH: 0.0945841
G1 X78.957 Y95.646 E.00038
; WIPE_START
G1 X79.001 Y95.748 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X84.635 Y97.155 Z3.6 F18000
G1 Z3.2
G1 E.4 F1800
; LINE_WIDTH: 0.470989
G1 F1500
M204 S6000
G1 X84.454 Y97.322 E.00546
; LINE_WIDTH: 0.433552
G1 X84.272 Y97.488 E.005
; LINE_WIDTH: 0.393458
G1 X84.066 Y97.68 E.00517
; LINE_WIDTH: 0.359259
G1 X83.72 Y98.071 E.00869
G1 X83.522 Y98.367 E.00592
G1 X83.356 Y98.681 E.00592
G1 X83.205 Y99.101 E.00742
G1 X83.132 Y99.444 E.00585
G1 X83.099 Y99.838 E.00658
G1 X83.135 Y100.362 E.00873
G1 X83.264 Y100.883 E.00894
G1 X83.475 Y101.358 E.00865
G1 X83.675 Y101.671 E.00618
G1 X83.939 Y101.986 E.00684
G1 X84.284 Y102.291 E.00766
G1 X84.8 Y102.606 E.01006
G1 X85.302 Y102.794 E.00892
G1 X85.828 Y102.888 E.00888
G1 X86.35 Y102.888 E.00868
G1 X86.877 Y102.794 E.00891
G1 X87.222 Y102.676 E.00607
G1 X87.554 Y102.521 E.0061
G1 X87.827 Y102.345 E.0054
G1 X88.122 Y102.111 E.00626
G1 X88.457 Y101.746 E.00824
G1 X88.752 Y101.283 E.00914
G1 X88.903 Y100.956 E.006
G1 X89.029 Y100.505 E.00779
G1 X89.09 Y100.061 E.00747
G1 X89.067 Y99.529 E.00886
G1 X88.966 Y99.03 E.00848
G1 X88.764 Y98.53 E.00897
G1 X88.477 Y98.077 E.00892
G1 X88.224 Y97.788 E.00638
; LINE_WIDTH: 0.382865
G1 X87.974 Y97.534 E.00635
; LINE_WIDTH: 0.421668
G1 X87.872 Y97.441 E.00273
; LINE_WIDTH: 0.471424
G1 X87.554 Y97.172 E.00927
; WIPE_START
G1 X87.872 Y97.441 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X94.029 Y95.546 Z3.6 F18000
G1 Z3.2
G1 E.4 F1800
; LINE_WIDTH: 0.15225
G1 F1500
M204 S6000
G1 X94.523 Y95.356 E.00334
; LINE_WIDTH: 0.103915
G1 X95.017 Y95.165 E.00206
; WIPE_START
G1 X94.523 Y95.356 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X95.095 Y87.745 Z3.6 F18000
G1 X95.181 Y86.601 Z3.6
G1 Z3.2
G1 E.4 F1800
; LINE_WIDTH: 0.114562
G1 F1500
M204 S6000
G1 X93.75 Y86.601 E.00634
; WIPE_START
G1 X95.181 Y86.601 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X88.691 Y82.584 Z3.6 F18000
G1 X79.595 Y76.955 Z3.6
G1 Z3.2
G1 E.4 F1800
; LINE_WIDTH: 0.0896656
G1 F1500
M204 S6000
G1 X79.491 Y76.99 E.00035
; LINE_WIDTH: 0.128621
G1 X79.29 Y77.08 E.00113
; LINE_WIDTH: 0.154633
G1 X79.168 Y77.19 E.00106
G1 X79.028 Y77.369 E.00146
; LINE_WIDTH: 0.118027
G1 X78.988 Y77.486 E.00057
; LINE_WIDTH: 0.0899601
G1 X78.949 Y77.603 E.0004
; WIPE_START
G1 X78.988 Y77.486 E-.38
; WIPE_END
M73 P67 R8
G1 E-.02 F1800
M204 S10000
G1 X85.9 Y80.724 Z3.6 F18000
G1 X100.371 Y87.504 Z3.6
G1 Z3.2
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X100.647 Y87.111 E.00944
G1 X101.16 Y87.47 E.01234
G1 X101.613 Y87.787 E.01087
G1 X101.338 Y88.181 E.00944
G1 X100.42 Y87.538 E.02203
M204 S10000
G1 X100.676 Y87.424 F18000
; FEATURE: Gap infill
; LINE_WIDTH: 0.0965156
G1 F1500
M204 S6000
G1 X101.308 Y87.867 E.00272
; CHANGE_LAYER
; Z_HEIGHT: 3.24
; LAYER_HEIGHT: 0.04
; WIPE_START
G1 F1500
G1 X100.676 Y87.424 E-.38
; WIPE_END
G1 E-.02 F1800
; layer num/total_layer_count: 31/57
; update layer progress
M73 L31
M991 S0 P30 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z3.6 I-1.178 J-.306 P1  F18000
G1 X99.967 Y90.161 Z3.6
G1 Z3.24
G1 E.4 F1800
; FEATURE: Support
; LINE_WIDTH: 0.42
; LAYER_HEIGHT: 0.26
G1 F1267.254
M204 S6000
G1 X99.85 Y90.328 E.00802
G1 X99.381 Y90 E.02254
G1 X100.08 Y90 E.02751
G1 X100.886 Y88.849 E.05531
G1 X99.898 Y88.157 E.04748
G1 X98.862 Y89.637 E.07109
G1 X99.219 Y89.887 E.01718
; WIPE_START
G1 X98.862 Y89.637 E-.08292
G1 X99.759 Y88.356 E-.29708
; WIPE_END
G1 E-.02 F1800
M204 S10000
G17
G3 Z3.64 I1.217 J0 P1  F18000
;===================== date: 20250206 =====================

; don't support timelapse gcode in spiral_mode and by object sequence for I3 structure printer
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
G92 E0
G1 Z3.64
G1 X0 Y90 ; move to safe pos
G1 X-13.0 F3000 ; move to safe pos
M400
M1004 S5 P1  ; external shutter
M400 P300
M971 S11 C11 O0
G92 E0
G1 X0 F18000
M623

; SKIPTYPE: head_wrap_detect
M622.1 S1
M1002 judge_flag g39_3rd_layer_detect_flag
M622 J1
    ; enable nozzle clog detect at 3rd layer
    


    M622.1 S1
    M1002 judge_flag g39_detection_flag
    M622 J1
      
        M622.1 S0
        M1002 judge_flag g39_mass_exceed_flag
        M622 J1
        
            G392 S0
            M400
            G90
            M83
            M204 S5000
            G0 Z3.64 F4000
            G39.3 S1
            G0 Z3.64 F4000
            G392 S0
          
        M623
    
    M623
M623
; SKIPPABLE_END




; CHANGE_LAYER
; Z_HEIGHT: 3.32
; LAYER_HEIGHT: 0.0799999
; layer num/total_layer_count: 32/57
; update layer progress
M73 L32
M991 S0 P31 ;notify layer change
; OBJECT_ID: 8
G1 X95.564 Y86.344
G1 Z3.32
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
; LAYER_HEIGHT: 0.12
G1 F1500
M204 S500
G1 X95.564 Y86.857 E.01086
G1 X93.538 Y86.857 E.04289
G1 X93.538 Y86.344 E.01086
G1 X95.504 Y86.344 E.04162
M204 S10000
G1 X95.989 Y85.92 F18000
G1 F1500
M204 S500
G1 X95.989 Y87.282 E.02882
G1 X93.475 Y87.282 E.0532
G1 X93.475 Y88.382 E.02328
G1 X93.114 Y88.382 E.00765
G1 X93.114 Y77.127 E.23821
G1 X93.292 Y77.071 E.00395
G1 X93.355 Y77.162 E.00234
G1 X93.42 Y77.3 E.00324
G1 X93.459 Y77.448 E.00324
G1 X93.475 Y77.628 E.00382
G1 X93.475 Y85.92 E.17551
G1 X95.929 Y85.92 E.05193
; WIPE_START
M204 S6000
G1 X95.989 Y87.282 E-.25894
G1 X95.352 Y87.282 E-.12106
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X93.831 Y94.761 Z3.72 F18000
G1 X93.668 Y95.562 Z3.72
G1 Z3.32
G1 E.4 F1800
G1 F1500
M204 S500
G1 X93.122 Y95.806 E.01267
G1 X93.154 Y95.433 E.00794
G1 X93.201 Y95.373 E.00161
G1 X93.292 Y95.348 E.002
G1 X93.356 Y95.368 E.00143
G1 X93.617 Y95.531 E.00651
; WIPE_START
M204 S6000
G1 X93.122 Y95.806 E-.1449
G1 X93.154 Y95.433 E-.09575
G1 X93.201 Y95.373 E-.01945
G1 X93.292 Y95.348 E-.0241
G1 X93.356 Y95.368 E-.01721
G1 X93.617 Y95.531 E-.07857
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X86.106 Y96.886 Z3.72 F18000
G1 X84.86 Y97.11 Z3.72
G1 Z3.32
G1 E.4 F1800
G1 F1500
M204 S500
G1 X84.753 Y96.949 E.0041
G1 X85.105 Y96.544 E.01135
G1 X87.016 Y96.544 E.04045
G1 X87.357 Y96.913 E.01063
G1 X87.255 Y97.078 E.0041
G1 X86.674 Y96.908 E.01281
G1 X86.042 Y96.853 E.01343
G1 X85.424 Y96.927 E.01318
G1 X84.917 Y97.092 E.01128
; WIPE_START
M204 S6000
G1 X84.753 Y96.949 E-.04131
G1 X85.105 Y96.544 E-.10189
G1 X86.351 Y96.544 E-.2368
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X83.486 Y99.782 Z3.72 F18000
G1 Z3.32
G1 E.4 F1800
G1 F1500
M204 S500
G1 X83.502 Y99.51 E.00577
G1 X83.613 Y99.054 E.00994
G1 X83.801 Y98.633 E.00975
G1 X83.975 Y98.361 E.00683
G1 X84.179 Y98.111 E.00683
G1 X84.515 Y97.809 E.00956
G1 X84.784 Y97.632 E.00683
G1 X85.073 Y97.487 E.00683
G1 X85.516 Y97.343 E.00985
G1 X86.049 Y97.28 E.01137
G1 X86.596 Y97.327 E.01161
G1 X87.043 Y97.458 E.00987
G1 X87.336 Y97.593 E.00683
G1 X87.611 Y97.763 E.00683
G1 X87.962 Y98.061 E.00975
G1 X88.255 Y98.417 E.00975
G1 X88.42 Y98.694 E.00683
G1 X88.551 Y98.989 E.00683
G1 X88.674 Y99.433 E.00975
G1 X88.716 Y99.901 E.00995
G1 X88.674 Y100.369 E.00995
G1 X88.549 Y100.822 E.00995
G1 X88.349 Y101.237 E.00975
G1 X88.167 Y101.504 E.00683
G1 X87.955 Y101.747 E.00683
G1 X87.6 Y102.048 E.00986
G1 X87.13 Y102.309 E.01137
G1 X86.607 Y102.473 E.01161
G1 X86.129 Y102.523 E.01018
G1 X85.594 Y102.474 E.01137
G1 X85.069 Y102.314 E.01161
G1 X84.65 Y102.089 E.01007
G1 X84.283 Y101.796 E.00995
G1 X83.973 Y101.442 E.00995
G1 X83.737 Y101.046 E.00975
G1 X83.615 Y100.748 E.00683
G1 X83.529 Y100.437 E.00683
G1 X83.474 Y99.979 E.00975
G1 X83.482 Y99.842 E.00291
M204 S250
G1 X83.894 Y99.807 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X83.908 Y99.571 E.00464
G1 X84.002 Y99.186 E.00779
G1 X84.162 Y98.827 E.00774
G1 X84.306 Y98.602 E.00526
G1 X84.476 Y98.395 E.00526
G1 X84.766 Y98.134 E.00767
G1 X84.989 Y97.987 E.00526
G1 X85.228 Y97.867 E.00526
G1 X85.604 Y97.745 E.00776
G1 X86.056 Y97.691 E.00895
G1 X86.52 Y97.731 E.00916
G1 X86.899 Y97.842 E.00777
G1 X87.142 Y97.954 E.00526
G1 X87.369 Y98.095 E.00526
G1 X87.669 Y98.349 E.00773
G1 X87.919 Y98.653 E.00773
G1 X88.056 Y98.883 E.00526
G1 X88.165 Y99.127 E.00526
G1 X88.27 Y99.506 E.00773
G1 X88.305 Y99.901 E.00779
G1 X88.27 Y100.296 E.0078
G1 X88.164 Y100.678 E.0078
G1 X87.994 Y101.032 E.00773
G1 X87.843 Y101.253 E.00526
G1 X87.667 Y101.455 E.00526
G1 X87.366 Y101.71 E.00777
G1 X86.968 Y101.931 E.00895
G1 X86.524 Y102.07 E.00916
G1 X86.126 Y102.112 E.00787
G1 X85.673 Y102.07 E.00895
G1 X85.227 Y101.935 E.00916
G1 X84.877 Y101.746 E.00783
G1 X84.567 Y101.499 E.0078
G1 X84.306 Y101.2 E.0078
G1 X84.104 Y100.863 E.00774
G1 X84.003 Y100.615 E.00526
G1 X83.931 Y100.357 E.00526
G1 X83.885 Y99.967 E.00773
G1 X83.891 Y99.867 E.00198
; WIPE_START
M204 S6000
G1 X83.908 Y99.571 E-.05618
G1 X84.002 Y99.186 E-.07527
G1 X84.162 Y98.827 E-.07474
G1 X84.306 Y98.602 E-.05082
G1 X84.476 Y98.395 E-.05082
G1 X84.758 Y98.141 E-.07216
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X84.855 Y96.12 Z3.72 F18000
G1 Z3.32
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X92.678 Y96.12 E.16557
G1 X92.718 Y95.441 E.01439
G1 X92.742 Y95.328 E.00245
G1 X92.815 Y95.177 E.00355
G1 X92.87 Y95.107 E.00189
G1 X93.063 Y94.97 E.00499
G1 X93.272 Y94.922 E.00455
G1 X93.369 Y94.929 E.00206
G1 X93.533 Y94.978 E.00362
G1 X93.978 Y95.255 E.0111
G1 X95.879 Y94.633 E.04234
G1 X98.51 Y90.875 E.09709
G1 X98.806 Y91.083 E.00765
G1 X96.105 Y94.94 E.09967
G1 X93.241 Y96.217 E.06637
G1 X93.048 Y96.354 E.00501
G1 X92.803 Y96.453 E.0056
G1 X92.559 Y96.482 E.0052
G1 X87.536 Y96.482 E.10631
G1 X88.639 Y97.675 E.03439
G1 X88.889 Y98 E.00868
G1 X89.099 Y98.353 E.00869
G1 X89.323 Y98.901 E.01254
G1 X89.449 Y99.484 E.01261
G1 X89.469 Y100.083 E.01268
G1 X89.403 Y100.578 E.01058
G1 X89.262 Y101.078 E.01101
G1 X89.012 Y101.606 E.01237
G1 X88.727 Y102.017 E.01058
G1 X88.375 Y102.395 E.01093
G1 X88.061 Y102.65 E.00856
G1 X87.737 Y102.855 E.00811
G1 X87.367 Y103.032 E.00868
G1 X86.978 Y103.164 E.00869
G1 X86.386 Y103.269 E.01273
G1 X85.794 Y103.267 E.01254
G1 X85.201 Y103.161 E.01274
G1 X84.638 Y102.951 E.01272
G1 X84.287 Y102.757 E.0085
G1 X83.961 Y102.522 E.00849
G1 X83.666 Y102.251 E.0085
G1 X83.404 Y101.947 E.00849
G1 X83.181 Y101.613 E.0085
G1 X82.998 Y101.256 E.00849
G1 X82.86 Y100.879 E.00849
G1 X82.767 Y100.494 E.00839
G1 X82.718 Y100 E.01051
G1 X82.741 Y99.484 E.01093
G1 X82.811 Y99.1 E.00826
G1 X82.966 Y98.628 E.01052
G1 X83.195 Y98.165 E.01093
G1 X83.417 Y97.838 E.00837
G1 X84.597 Y96.482 E.03805
G1 X79.631 Y96.482 E.10513
G1 X79.392 Y96.454 E.00508
G1 X79.189 Y96.38 E.00457
G1 X79.088 Y96.319 E.00251
G1 X78.903 Y96.143 E.00539
G1 X78.791 Y95.957 E.0046
G1 X78.743 Y95.812 E.00324
G1 X78.714 Y95.565 E.00527
G1 X78.714 Y77.624 E.37973
G1 X78.752 Y77.352 E.00581
G1 X78.809 Y77.207 E.00331
G1 X78.89 Y77.076 E.00324
G1 X79.062 Y76.901 E.0052
G1 X79.285 Y76.778 E.0054
G1 X79.543 Y76.723 E.00559
G1 X92.611 Y76.721 E.27658
G1 X92.743 Y76.735 E.00281
G1 X92.895 Y76.775 E.00333
G1 X93.124 Y76.904 E.00556
G1 X93.068 Y77.082 E.00395
G1 X80.04 Y77.082 E.27574
G1 X79.752 Y77.132 E.0062
G1 X79.474 Y77.282 E.00669
G1 X79.241 Y77.529 E.00717
G1 X79.112 Y77.807 E.00649
G1 X79.075 Y78.056 E.00533
G1 X79.075 Y95.137 E.36154
G1 X79.099 Y95.342 E.00437
G1 X79.194 Y95.589 E.00559
G1 X79.346 Y95.8 E.00553
G1 X79.539 Y95.962 E.00533
G1 X79.8 Y96.084 E.0061
G1 X80.049 Y96.12 E.00533
G1 X84.795 Y96.12 E.10045
; WIPE_START
M204 S6000
G1 X86.795 Y96.12 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X83.699 Y96.891 Z3.72 F18000
G1 Z3.32
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X79.607 Y96.891 E.08049
G1 X79.297 Y96.855 E.00613
G1 X79.012 Y96.751 E.00597
G1 X78.852 Y96.655 E.00367
G1 X78.71 Y96.539 E.00361
G1 X78.581 Y96.398 E.00376
G1 X78.412 Y96.114 E.00649
G1 X78.341 Y95.901 E.00442
G1 X78.304 Y95.589 E.00619
G1 X78.304 Y77.609 E.35365
G1 X78.319 Y77.418 E.00377
G1 X78.359 Y77.232 E.00373
G1 X78.442 Y77.022 E.00444
G1 X78.56 Y76.831 E.00442
G1 X78.712 Y76.661 E.00448
G1 X78.822 Y76.568 E.00283
G1 X79.018 Y76.447 E.00454
G1 X79.15 Y76.39 E.00283
G1 X79.374 Y76.33 E.00454
G1 X79.519 Y76.313 E.00289
G1 X92.631 Y76.312 E.2579
G1 X92.817 Y76.331 E.00367
G1 X93.035 Y76.389 E.00445
G1 X93.239 Y76.484 E.00442
G1 X93.423 Y76.613 E.00442
G1 X93.582 Y76.772 E.00442
G1 X93.711 Y76.956 E.00442
G1 X93.806 Y77.16 E.00442
G1 X93.864 Y77.377 E.00442
G1 X93.884 Y77.61 E.0046
G1 X93.884 Y85.511 E.1554
G1 X96.181 Y85.511 E.04518
G1 X96.268 Y85.425 E.0024
G1 F2035.599
G1 X96.398 Y85.294 E.00363
G1 F1320
G1 X96.398 Y87.907 E.0514
G1 F1824.963
G1 X96.268 Y87.777 E.00363
G1 F1500
G1 X96.181 Y87.691 E.0024
G1 X93.884 Y87.691 E.04518
G1 X93.884 Y88.791 E.02164
G1 X92.704 Y88.791 E.02321
G1 X92.704 Y77.491 E.22226
G1 X80.076 Y77.491 E.24839
G1 X79.888 Y77.524 E.00376
G1 X79.726 Y77.611 E.00362
G1 X79.584 Y77.762 E.00407
G1 X79.508 Y77.925 E.00356
G1 X79.484 Y78.086 E.00319
G1 X79.484 Y95.113 E.33492
G1 X79.5 Y95.244 E.00258
G1 X79.557 Y95.392 E.00313
G1 X79.648 Y95.519 E.00309
G1 X79.761 Y95.614 E.00289
G1 X79.919 Y95.687 E.00343
G1 X80.079 Y95.711 E.00318
G1 X92.292 Y95.711 E.24022
G1 X92.312 Y95.387 E.00639
G1 X92.349 Y95.21 E.00356
G1 X92.404 Y95.071 E.00293
G1 X92.569 Y94.829 E.00577
G1 X92.673 Y94.731 E.00281
G1 X92.922 Y94.585 E.00568
G1 X93.161 Y94.521 E.00487
G1 X93.443 Y94.523 E.00555
G1 X93.703 Y94.602 E.00535
G1 X94.032 Y94.807 E.00762
G1 X95.622 Y94.286 E.03291
G1 X98.41 Y90.305 E.09559
M73 P68 R8
G1 X99.376 Y90.982 E.02321
G1 X96.375 Y95.268 E.10291
G1 X93.444 Y96.575 E.06313
G1 X93.26 Y96.704 E.00442
G1 X93.1 Y96.787 E.00354
G1 X92.891 Y96.855 E.00434
G1 X92.582 Y96.891 E.00611
G1 X88.471 Y96.891 E.08086
G1 X88.952 Y97.411 E.01393
G1 X89.228 Y97.77 E.00891
G1 X89.46 Y98.159 E.00891
G1 X89.555 Y98.356 E.00431
G1 X89.715 Y98.78 E.00891
G1 X89.823 Y99.22 E.00891
G1 X89.88 Y99.766 E.0108
G1 X89.878 Y100.111 E.00678
G1 X89.805 Y100.661 E.01091
G1 X89.649 Y101.215 E.01131
G1 X89.522 Y101.513 E.00638
G1 X89.363 Y101.819 E.00678
G1 X89.046 Y102.274 E.01091
G1 X88.655 Y102.694 E.01129
G1 X88.305 Y102.979 E.00887
G1 X87.93 Y103.216 E.00873
G1 X87.521 Y103.412 E.00891
G1 X87.092 Y103.557 E.00891
G1 X86.88 Y103.608 E.0043
G1 X86.429 Y103.676 E.00897
G1 X86.21 Y103.689 E.00431
G1 X85.757 Y103.676 E.00891
G1 X85.309 Y103.608 E.00891
G1 X85.093 Y103.556 E.00437
G1 X84.881 Y103.491 E.00436
G1 X84.462 Y103.321 E.00891
G1 X84.068 Y103.103 E.00885
G1 X83.703 Y102.84 E.00885
G1 X83.371 Y102.536 E.00885
G1 X83.078 Y102.195 E.00885
G1 X82.827 Y101.821 E.00885
G1 X82.623 Y101.42 E.00885
M73 P68 R7
G1 X82.467 Y100.998 E.00885
G1 X82.363 Y100.562 E.00882
G1 X82.308 Y100.011 E.01089
G1 X82.333 Y99.438 E.01129
G1 X82.414 Y98.999 E.00878
G1 X82.586 Y98.472 E.01089
G1 X82.841 Y97.958 E.01129
G1 X83.093 Y97.588 E.00881
G1 X83.659 Y96.936 E.01698
; WIPE_START
M204 S6000
G1 X81.66 Y96.914 E-.38
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




G1 X79.578 Y96.239
G1 Z3.32
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.102679
G1 F1500
M204 S6000
G1 X79.394 Y96.179 E.00074
; LINE_WIDTH: 0.148265
G1 X79.188 Y96.036 E.00153
G1 X79.043 Y95.848 E.00145
G1 X78.996 Y95.756 E.00063
; LINE_WIDTH: 0.0934264
G1 X78.959 Y95.636 E.00042
; WIPE_START
G1 X78.996 Y95.756 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X84.642 Y97.165 Z3.72 F18000
G1 Z3.32
G1 E.4 F1800
; LINE_WIDTH: 0.477114
G1 F1500
M204 S6000
G1 X84.461 Y97.319 E.00533
; LINE_WIDTH: 0.438414
G1 X84.254 Y97.496 E.00561
; LINE_WIDTH: 0.401007
G1 X84.085 Y97.669 E.00453
; LINE_WIDTH: 0.359959
G1 X83.72 Y98.071 E.00905
G1 X83.525 Y98.357 E.00578
G1 X83.32 Y98.773 E.00772
G1 X83.184 Y99.195 E.0074
G1 X83.12 Y99.527 E.00564
G1 X83.096 Y99.989 E.00772
G1 X83.156 Y100.498 E.00853
G1 X83.261 Y100.879 E.00659
G1 X83.406 Y101.226 E.00627
G1 X83.708 Y101.716 E.0096
G1 X84.012 Y102.058 E.00763
G1 X84.43 Y102.395 E.00896
G1 X84.91 Y102.654 E.00909
G1 X85.303 Y102.789 E.00693
G1 X85.538 Y102.843 E.00402
G1 X85.828 Y102.882 E.00488
G1 X86.116 Y102.896 E.0048
G1 X86.349 Y102.886 E.0039
G1 X86.876 Y102.792 E.00892
G1 X87.294 Y102.649 E.00737
G1 X87.828 Y102.35 E.0102
G1 X88.209 Y102.022 E.00838
G1 X88.459 Y101.742 E.00626
G1 X88.687 Y101.41 E.00672
G1 X88.905 Y100.953 E.00844
G1 X89.041 Y100.45 E.00868
G1 X89.086 Y100.06 E.00656
G1 X89.067 Y99.529 E.00886
G1 X89.039 Y99.352 E.00299
G1 X88.956 Y99.015 E.00579
G1 X88.762 Y98.528 E.00873
G1 X88.572 Y98.209 E.0062
G1 X88.222 Y97.784 E.00918
; LINE_WIDTH: 0.375748
G1 X88.043 Y97.612 E.00434
; LINE_WIDTH: 0.408414
G1 X87.836 Y97.416 E.00543
; LINE_WIDTH: 0.445749
G1 X87.655 Y97.272 E.00486
; LINE_WIDTH: 0.479732
G1 X87.474 Y97.127 E.00525
; WIPE_START
G1 X87.655 Y97.272 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X94.038 Y95.543 Z3.72 F18000
G1 Z3.32
G1 E.4 F1800
; LINE_WIDTH: 0.151482
G1 F1500
M204 S6000
G1 X94.527 Y95.354 E.00329
; LINE_WIDTH: 0.103659
G1 X95.017 Y95.165 E.00204
; WIPE_START
G1 X94.527 Y95.354 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X95.244 Y87.755 Z3.72 F18000
G1 X95.352 Y86.601 Z3.72
G1 Z3.32
G1 E.4 F1800
; LINE_WIDTH: 0.114562
G1 F1500
M204 S6000
G1 X93.75 Y86.601 E.0071
; WIPE_START
G1 X95.352 Y86.601 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X88.842 Y82.617 Z3.72 F18000
G1 X79.591 Y76.955 Z3.72
G1 Z3.32
G1 E.4 F1800
; LINE_WIDTH: 0.0812055
G1 F1500
M204 S6000
G1 X79.559 Y76.963 E.00009
; LINE_WIDTH: 0.0961843
G1 X79.468 Y76.997 E.00034
; LINE_WIDTH: 0.128535
G1 X79.303 Y77.074 E.00093
; LINE_WIDTH: 0.150159
G1 X79.196 Y77.162 E.00086
G1 X79.053 Y77.332 E.00138
G1 X79.002 Y77.427 E.00067
; LINE_WIDTH: 0.099716
G1 X78.95 Y77.598 E.00066
; WIPE_START
G1 X79.002 Y77.427 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X85.905 Y80.682 Z3.72 F18000
G1 X100.371 Y87.504 Z3.72
G1 Z3.32
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X100.647 Y87.111 E.00944
G1 X101.187 Y87.489 E.01297
G1 X101.613 Y87.787 E.01024
G1 X101.338 Y88.181 E.00944
G1 X100.42 Y87.538 E.02203
M204 S10000
G1 X100.676 Y87.424 F18000
; FEATURE: Gap infill
; LINE_WIDTH: 0.0965175
G1 F1500
M204 S6000
G1 X101.308 Y87.867 E.00272
; CHANGE_LAYER
; Z_HEIGHT: 3.44
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F1500
G1 X100.676 Y87.424 E-.38
; WIPE_END
G1 E-.02 F1800
; layer num/total_layer_count: 33/57
; update layer progress
M73 L33
M991 S0 P32 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z3.72 I.26 J-1.189 P1  F18000
G1 X95.736 Y86.344 Z3.72
G1 Z3.44
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X95.736 Y86.857 E.01086
G1 X93.538 Y86.857 E.04652
G1 X93.538 Y86.344 E.01086
G1 X95.676 Y86.344 E.04525
M204 S10000
G1 X96.16 Y85.92 F18000
G1 F1500
M204 S500
G1 X96.16 Y87.282 E.02882
G1 X93.475 Y87.282 E.05683
G1 X93.475 Y88.382 E.02328
G1 X93.114 Y88.382 E.00765
G1 X93.114 Y77.127 E.23821
G1 X93.292 Y77.071 E.00395
G1 X93.355 Y77.162 E.00234
G1 X93.42 Y77.3 E.00324
G1 X93.459 Y77.448 E.00324
G1 X93.475 Y77.628 E.00382
G1 X93.475 Y85.92 E.17551
G1 X96.1 Y85.92 E.05556
; WIPE_START
M204 S6000
G1 X96.16 Y87.282 E-.25894
G1 X95.523 Y87.282 E-.12106
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X93.852 Y94.729 Z3.84 F18000
G1 X93.665 Y95.564 Z3.84
G1 Z3.44
G1 E.4 F1800
G1 F1500
M204 S500
G1 X93.117 Y95.808 E.01271
G1 X93.144 Y95.469 E.00722
G1 X93.162 Y95.423 E.00105
G1 X93.221 Y95.351 E.00195
G1 X93.34 Y95.354 E.00252
G1 X93.615 Y95.531 E.00693
; WIPE_START
M204 S6000
G1 X93.117 Y95.808 E-.14449
G1 X93.144 Y95.469 E-.08645
G1 X93.162 Y95.423 E-.01257
G1 X93.221 Y95.351 E-.02332
G1 X93.34 Y95.354 E-.03018
G1 X93.615 Y95.531 E-.083
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X86.103 Y96.886 Z3.84 F18000
G1 X84.86 Y97.11 Z3.84
G1 Z3.44
G1 E.4 F1800
G1 F1500
M204 S500
G1 X84.753 Y96.949 E.0041
G1 X85.105 Y96.544 E.01135
G1 X87.084 Y96.544 E.04188
G1 X87.437 Y96.951 E.0114
G1 X87.314 Y97.115 E.00436
G1 X87.193 Y97.059 E.00282
G1 X86.674 Y96.908 E.01144
G1 X86.039 Y96.853 E.01348
G1 X85.424 Y96.927 E.01312
G1 X84.917 Y97.092 E.01128
; WIPE_START
M204 S6000
G1 X84.753 Y96.949 E-.04131
G1 X85.105 Y96.544 E-.10188
G1 X86.351 Y96.544 E-.23681
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X83.488 Y99.784 Z3.84 F18000
G1 Z3.44
G1 E.4 F1800
G1 F1500
M204 S500
G1 X83.513 Y99.441 E.00727
G1 X83.666 Y98.912 E.01167
G1 X83.885 Y98.489 E.01007
G1 X84.176 Y98.113 E.01007
G1 X84.592 Y97.752 E.01166
G1 X85.059 Y97.492 E.01132
G1 X85.515 Y97.343 E.01015
G1 X86.046 Y97.28 E.01132
G1 X86.595 Y97.327 E.01166
G1 X87.043 Y97.458 E.00988
G1 X87.336 Y97.593 E.00683
G1 X87.611 Y97.763 E.00683
G1 X87.955 Y98.055 E.00955
G1 X88.167 Y98.298 E.00683
G1 X88.349 Y98.565 E.00683
G1 X88.549 Y98.98 E.00975
G1 X88.674 Y99.433 E.00995
G1 X88.716 Y99.901 E.00995
G1 X88.674 Y100.369 E.00995
G1 X88.551 Y100.813 E.00975
G1 X88.42 Y101.108 E.00683
G1 X88.255 Y101.385 E.00683
G1 X87.962 Y101.741 E.00975
G1 X87.6 Y102.048 E.01005
G1 X87.133 Y102.308 E.01132
G1 X86.607 Y102.473 E.01166
G1 X86.129 Y102.523 E.01018
G1 X85.596 Y102.475 E.01132
G1 X85.069 Y102.314 E.01166
G1 X84.65 Y102.089 E.01008
G1 X84.283 Y101.796 E.00995
G1 X83.973 Y101.442 E.00994
G1 X83.732 Y101.039 E.00995
G1 X83.57 Y100.607 E.00975
G1 X83.503 Y100.291 E.00683
G1 X83.474 Y99.965 E.00693
G1 X83.483 Y99.844 E.00258
M204 S250
G1 X83.896 Y99.815 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X83.918 Y99.514 E.00593
G1 X84.048 Y99.064 E.00921
G1 X84.231 Y98.711 E.00783
G1 X84.475 Y98.396 E.00784
G1 X84.829 Y98.089 E.00921
G1 X85.224 Y97.868 E.0089
G1 X85.604 Y97.745 E.00786
G1 X86.053 Y97.691 E.00891
G1 X86.52 Y97.731 E.00921
G1 X86.899 Y97.842 E.00777
G1 X87.142 Y97.954 E.00526
G1 X87.369 Y98.095 E.00526
G1 X87.667 Y98.347 E.00767
G1 X87.843 Y98.549 E.00526
G1 X87.994 Y98.77 E.00526
G1 X88.164 Y99.124 E.00774
G1 X88.27 Y99.506 E.0078
G1 X88.305 Y99.901 E.0078
G1 X88.27 Y100.296 E.0078
G1 X88.165 Y100.675 E.00773
G1 X88.056 Y100.919 E.00526
G1 X87.919 Y101.149 E.00526
G1 X87.669 Y101.452 E.00774
G1 X87.366 Y101.71 E.00783
G1 X86.97 Y101.93 E.0089
G1 X86.524 Y102.07 E.00921
G1 X86.126 Y102.112 E.00787
G1 X85.675 Y102.071 E.0089
G1 X85.227 Y101.935 E.00921
G1 X84.876 Y101.746 E.00784
G1 X84.567 Y101.499 E.0078
G1 X84.306 Y101.2 E.00779
G1 X84.103 Y100.86 E.0078
G1 X83.964 Y100.492 E.00774
G1 X83.909 Y100.23 E.00526
G1 X83.885 Y99.962 E.00529
G1 X83.891 Y99.874 E.00173
; WIPE_START
M204 S6000
G1 X83.918 Y99.514 E-.06866
G1 X84.048 Y99.064 E-.08896
G1 X84.231 Y98.711 E-.07567
G1 X84.475 Y98.396 E-.07569
G1 X84.757 Y98.151 E-.07102
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X84.855 Y96.12 Z3.84 F18000
G1 Z3.44
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X92.666 Y96.12 E.16533
G1 X92.74 Y95.335 E.01669
G1 X92.81 Y95.184 E.00353
G1 X92.887 Y95.089 E.00258
G1 X93.079 Y94.964 E.00486
G1 X93.233 Y94.926 E.00337
G1 X93.443 Y94.941 E.00444
G1 X93.539 Y94.978 E.00218
G1 X93.972 Y95.257 E.01091
G1 X95.879 Y94.633 E.04247
G1 X98.51 Y90.875 E.09709
G1 X98.806 Y91.083 E.00765
G1 X96.105 Y94.94 E.09967
G1 X93.244 Y96.216 E.0663
G1 X93.021 Y96.37 E.00573
G1 X92.803 Y96.453 E.00495
G1 X92.559 Y96.482 E.0052
G1 X87.591 Y96.482 E.10514
G1 X88.777 Y97.845 E.03825
G1 X88.884 Y97.992 E.00385
G1 X89.099 Y98.353 E.00889
G1 X89.326 Y98.91 E.01273
G1 X89.451 Y99.499 E.01273
G1 X89.469 Y100.086 E.01243
G1 X89.404 Y100.574 E.01042
G1 X89.262 Y101.079 E.01111
G1 X89.008 Y101.614 E.01255
G1 X88.66 Y102.101 E.01266
G1 X88.379 Y102.391 E.00855
G1 X88.061 Y102.65 E.00868
G1 X87.737 Y102.855 E.00811
G1 X87.367 Y103.032 E.00869
G1 X86.978 Y103.164 E.00869
G1 X86.386 Y103.269 E.01273
M73 P69 R7
G1 X85.794 Y103.267 E.01254
G1 X85.215 Y103.165 E.01243
G1 X84.743 Y102.996 E.01061
G1 X84.282 Y102.753 E.01103
G1 X83.961 Y102.522 E.00837
G1 X83.666 Y102.251 E.00849
G1 X83.404 Y101.947 E.00849
G1 X83.181 Y101.613 E.0085
G1 X82.998 Y101.256 E.00849
G1 X82.86 Y100.879 E.00849
G1 X82.766 Y100.489 E.0085
G1 X82.72 Y100.091 E.00849
G1 X82.738 Y99.499 E.01253
G1 X82.812 Y99.095 E.00869
G1 X82.929 Y98.716 E.00839
G1 X83.137 Y98.27 E.01042
G1 X83.421 Y97.833 E.01103
G1 X84.597 Y96.482 E.03792
G1 X79.63 Y96.482 E.10513
G1 X79.392 Y96.454 E.00508
G1 X79.19 Y96.38 E.00457
G1 X79.087 Y96.318 E.00254
G1 X78.902 Y96.142 E.00539
G1 X78.834 Y96.041 E.00259
G1 X78.743 Y95.816 E.00513
G1 X78.714 Y95.565 E.00536
G1 X78.714 Y77.624 E.37973
G1 X78.753 Y77.348 E.0059
G1 X78.859 Y77.121 E.00531
G1 X79.046 Y76.914 E.00589
G1 X79.294 Y76.775 E.00602
G1 X79.543 Y76.723 E.00539
G1 X92.612 Y76.722 E.27662
G1 X92.743 Y76.735 E.00277
G1 X92.895 Y76.775 E.00333
G1 X93.124 Y76.904 E.00556
G1 X93.068 Y77.082 E.00395
G1 X80.04 Y77.082 E.27574
G1 X79.752 Y77.133 E.0062
G1 X79.474 Y77.282 E.00668
G1 X79.241 Y77.529 E.00718
G1 X79.112 Y77.807 E.00649
G1 X79.075 Y78.056 E.00532
G1 X79.075 Y95.137 E.36154
G1 X79.099 Y95.342 E.00438
G1 X79.194 Y95.589 E.0056
G1 X79.346 Y95.8 E.00551
G1 X79.539 Y95.962 E.00532
G1 X79.8 Y96.084 E.0061
G1 X80.049 Y96.12 E.00533
G1 X84.795 Y96.12 E.10045
; WIPE_START
M204 S6000
G1 X86.795 Y96.12 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X83.699 Y96.891 Z3.84 F18000
G1 Z3.44
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X79.607 Y96.891 E.08049
G1 X79.297 Y96.855 E.00613
G1 X79.012 Y96.751 E.00597
G1 X78.851 Y96.654 E.0037
G1 X78.71 Y96.539 E.00358
G1 X78.58 Y96.396 E.00379
G1 X78.478 Y96.246 E.00358
G1 X78.395 Y96.072 E.00379
G1 X78.341 Y95.903 E.00349
G1 X78.304 Y95.589 E.00622
G1 X78.304 Y77.609 E.35365
G1 X78.318 Y77.419 E.00374
G1 X78.359 Y77.231 E.00379
G1 X78.424 Y77.061 E.00358
G1 X78.517 Y76.893 E.00377
G1 X78.658 Y76.715 E.00447
G1 X78.791 Y76.593 E.00356
G1 X78.949 Y76.485 E.00377
G1 X79.154 Y76.389 E.00444
G1 X79.374 Y76.33 E.00448
G1 X79.519 Y76.313 E.00289
G1 X92.633 Y76.312 E.25793
G1 X92.817 Y76.331 E.00364
G1 X93.035 Y76.389 E.00445
G1 X93.239 Y76.484 E.00442
G1 X93.423 Y76.613 E.00442
G1 X93.582 Y76.772 E.00442
G1 X93.711 Y76.956 E.00442
G1 X93.806 Y77.16 E.00442
G1 X93.864 Y77.377 E.00442
G1 X93.884 Y77.61 E.0046
G1 X93.884 Y85.511 E.1554
G1 X96.181 Y85.511 E.04518
G1 X96.439 Y85.253 E.00716
G1 F1717.838
G1 X96.494 Y85.198 E.00154
G1 F1800
G1 X96.569 Y85.273 E.00208
G1 F1320
G1 X96.569 Y87.929 E.05224
G1 F1800
G1 X96.494 Y88.004 E.00208
G1 F2037.925
G1 X96.439 Y87.948 E.00154
G1 F1500
G1 X96.181 Y87.691 E.00716
G1 X93.884 Y87.691 E.04518
G1 X93.884 Y88.791 E.02164
G1 X92.704 Y88.791 E.02321
G1 X92.704 Y77.491 E.22226
G1 X80.076 Y77.491 E.24839
G1 X79.888 Y77.524 E.00376
G1 X79.726 Y77.611 E.00361
G1 X79.584 Y77.762 E.00407
G1 X79.508 Y77.926 E.00356
G1 X79.484 Y78.086 E.00318
G1 X79.484 Y95.113 E.33492
G1 X79.5 Y95.244 E.00259
G1 X79.557 Y95.393 E.00314
G1 X79.648 Y95.519 E.00307
G1 X79.761 Y95.614 E.00289
G1 X79.919 Y95.687 E.00343
G1 X80.079 Y95.711 E.00319
G1 X92.288 Y95.711 E.24014
G1 X92.317 Y95.35 E.00712
G1 X92.348 Y95.212 E.00278
G1 X92.417 Y95.044 E.00356
G1 X92.589 Y94.807 E.00577
G1 X92.672 Y94.731 E.00221
G1 X92.927 Y94.582 E.00581
G1 X93.209 Y94.516 E.00569
G1 X93.454 Y94.525 E.00483
G1 X93.725 Y94.611 E.00559
G1 X94.03 Y94.807 E.00715
G1 X95.622 Y94.286 E.03294
G1 X98.41 Y90.305 E.09559
G1 X99.376 Y90.982 E.02321
G1 X96.375 Y95.268 E.10291
G1 X93.445 Y96.574 E.0631
G1 X93.229 Y96.723 E.00516
G1 X93.102 Y96.786 E.00279
G1 X92.891 Y96.855 E.00436
G1 X92.582 Y96.891 E.00611
G1 X88.49 Y96.891 E.08049
G1 X89.098 Y97.59 E.01823
G1 X89.226 Y97.767 E.0043
G1 X89.46 Y98.159 E.00897
G1 X89.555 Y98.356 E.00431
G1 X89.716 Y98.783 E.00897
G1 X89.774 Y98.994 E.00431
G1 X89.856 Y99.443 E.00897
G1 X89.877 Y99.661 E.0043
G1 X89.878 Y100.112 E.00888
G1 X89.806 Y100.656 E.0108
G1 X89.649 Y101.215 E.01141
G1 X89.524 Y101.509 E.00628
G1 X89.362 Y101.821 E.00693
G1 X89.185 Y102.091 E.00634
G1 X88.97 Y102.369 E.00691
G1 X88.657 Y102.693 E.00887
G1 X88.305 Y102.979 E.00891
G1 X88.121 Y103.103 E.00437
G1 X87.93 Y103.216 E.00436
G1 X87.521 Y103.412 E.00891
G1 X87.092 Y103.557 E.00891
G1 X86.88 Y103.608 E.0043
G1 X86.429 Y103.676 E.00897
G1 X86.21 Y103.689 E.00431
G1 X85.757 Y103.676 E.00891
G1 X85.309 Y103.608 E.00891
G1 X85.098 Y103.557 E.00427
G1 X84.578 Y103.372 E.01086
G1 X84.066 Y103.102 E.01138
G1 X83.703 Y102.84 E.00881
G1 X83.371 Y102.536 E.00885
G1 X83.078 Y102.195 E.00885
G1 X82.827 Y101.821 E.00885
G1 X82.623 Y101.42 E.00885
G1 X82.467 Y100.998 E.00885
G1 X82.363 Y100.56 E.00885
G1 X82.311 Y100.113 E.00885
G1 X82.312 Y99.661 E.00891
G1 X82.332 Y99.443 E.0043
G1 X82.414 Y98.997 E.00891
G1 X82.547 Y98.569 E.00882
G1 X82.778 Y98.071 E.0108
G1 X83.094 Y97.586 E.01138
G1 X83.659 Y96.936 E.01694
; WIPE_START
M204 S6000
G1 X81.66 Y96.914 E-.38
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




G1 X79.578 Y96.239
G1 Z3.44
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.102675
G1 F1500
M204 S6000
G1 X79.394 Y96.178 E.00074
; LINE_WIDTH: 0.152536
G1 X79.148 Y95.995 E.00194
G1 X78.943 Y95.678 E.00239
M204 S10000
G1 X78.959 Y95.636 F18000
; LINE_WIDTH: 0.0860297
G1 F1500
M204 S6000
G1 X79.095 Y96.033 E.00126
; WIPE_START
G1 X78.959 Y95.636 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X84.644 Y97.168 Z3.84 F18000
G1 Z3.44
G1 E.4 F1800
; LINE_WIDTH: 0.470515
G1 F1500
M204 S6000
G1 X84.367 Y97.393 E.00791
; LINE_WIDTH: 0.444188
G1 X84.335 Y97.421 E.0009
; LINE_WIDTH: 0.418023
G1 X84.124 Y97.632 E.00582
; LINE_WIDTH: 0.361219
G1 X83.892 Y97.866 E.00553
G1 X83.562 Y98.301 E.00912
G1 X83.311 Y98.787 E.00917
G1 X83.186 Y99.187 E.007
G1 X83.12 Y99.546 E.00611
G1 X83.098 Y99.981 E.0073
G1 X83.131 Y100.358 E.00632
G1 X83.225 Y100.769 E.00706
G1 X83.387 Y101.189 E.00753
G1 X83.66 Y101.652 E.009
G1 X83.941 Y101.985 E.00729
G1 X84.204 Y102.224 E.00595
G1 X84.482 Y102.43 E.00579
G1 X84.909 Y102.656 E.00809
G1 X85.32 Y102.793 E.00725
G1 X85.541 Y102.844 E.00379
G1 X85.828 Y102.882 E.00484
; LINE_WIDTH: 0.359413
G1 X86.349 Y102.886 E.00868
G1 X86.698 Y102.835 E.00587
G1 X87.224 Y102.679 E.00912
G1 X87.553 Y102.515 E.00612
G1 X87.837 Y102.344 E.00552
G1 X88.24 Y101.994 E.00889
G1 X88.553 Y101.61 E.00825
G1 X88.757 Y101.272 E.00657
G1 X88.905 Y100.95 E.0059
G1 X89.046 Y100.422 E.0091
G1 X89.092 Y99.886 E.00895
G1 X89.044 Y99.38 E.00846
G1 X88.961 Y99.031 E.00597
G1 X88.759 Y98.532 E.00896
G1 X88.476 Y98.077 E.00891
G1 X88.213 Y97.775 E.00667
; LINE_WIDTH: 0.380239
G1 X88.04 Y97.605 E.00429
; LINE_WIDTH: 0.419788
G1 X87.842 Y97.411 E.00545
; LINE_WIDTH: 0.468136
G1 X87.544 Y97.162 E.00858
; WIPE_START
G1 X87.842 Y97.411 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X94.029 Y95.546 Z3.84 F18000
G1 Z3.44
G1 E.4 F1800
; LINE_WIDTH: 0.152252
G1 F1500
M204 S6000
G1 X94.523 Y95.356 E.00334
; LINE_WIDTH: 0.103916
G1 X95.017 Y95.165 E.00206
; WIPE_START
G1 X94.523 Y95.356 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X95.39 Y87.773 Z3.84 F18000
G1 X95.524 Y86.601 Z3.84
G1 Z3.44
G1 E.4 F1800
; LINE_WIDTH: 0.114562
G1 F1500
M204 S6000
G1 X93.75 Y86.601 E.00786
; WIPE_START
G1 X95.524 Y86.601 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X88.995 Y82.648 Z3.84 F18000
G1 X79.591 Y76.955 Z3.84
G1 Z3.44
G1 E.4 F1800
; LINE_WIDTH: 0.0897812
G1 F1500
M204 S6000
G1 X79.487 Y76.991 E.00035
; LINE_WIDTH: 0.129244
G1 X79.29 Y77.079 E.00111
; LINE_WIDTH: 0.152725
G1 X79.168 Y77.19 E.00105
G1 X79.004 Y77.421 E.00179
; LINE_WIDTH: 0.100322
G1 X78.95 Y77.598 E.00069
; WIPE_START
G1 X79.004 Y77.421 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X85.906 Y80.678 Z3.84 F18000
G1 X100.371 Y87.504 Z3.84
G1 Z3.44
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X100.647 Y87.111 E.00944
G1 X101.213 Y87.507 E.0136
G1 X101.613 Y87.787 E.00961
G1 X101.338 Y88.181 E.00944
G1 X100.42 Y87.538 E.02203
M204 S10000
M73 P70 R7
G1 X100.676 Y87.424 F18000
; FEATURE: Gap infill
; LINE_WIDTH: 0.0965191
G1 F1500
M204 S6000
G1 X101.308 Y87.867 E.00272
; CHANGE_LAYER
; Z_HEIGHT: 3.5
; LAYER_HEIGHT: 0.0599999
; WIPE_START
G1 F1500
G1 X100.676 Y87.424 E-.38
; WIPE_END
G1 E-.02 F1800
; layer num/total_layer_count: 34/57
; update layer progress
M73 L34
M991 S0 P33 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z3.84 I-1.178 J-.306 P1  F18000
G1 X99.967 Y90.161 Z3.84
G1 Z3.5
G1 E.4 F1800
; FEATURE: Support
; LINE_WIDTH: 0.42
; LAYER_HEIGHT: 0.26
G1 F1267.254
M204 S6000
G1 X99.85 Y90.328 E.00802
G1 X99.381 Y90 E.02254
G1 X100.08 Y90 E.02751
G1 X100.886 Y88.849 E.05531
G1 X99.898 Y88.157 E.04748
G1 X98.862 Y89.637 E.07109
G1 X99.219 Y89.887 E.01718
; WIPE_START
G1 X98.862 Y89.637 E-.08292
G1 X99.759 Y88.356 E-.29708
; WIPE_END
G1 E-.02 F1800
M204 S10000
G17
G3 Z3.9 I1.217 J0 P1  F18000
;===================== date: 20250206 =====================

; don't support timelapse gcode in spiral_mode and by object sequence for I3 structure printer
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
G92 E0
G1 Z3.9
G1 X0 Y90 ; move to safe pos
G1 X-13.0 F3000 ; move to safe pos
M400
M1004 S5 P1  ; external shutter
M400 P300
M971 S11 C11 O0
G92 E0
G1 X0 F18000
M623

; SKIPTYPE: head_wrap_detect
M622.1 S1
M1002 judge_flag g39_3rd_layer_detect_flag
M622 J1
    ; enable nozzle clog detect at 3rd layer
    


    M622.1 S1
    M1002 judge_flag g39_detection_flag
    M622 J1
      
        M622.1 S0
        M1002 judge_flag g39_mass_exceed_flag
        M622 J1
        
            G392 S0
            M400
            G90
            M83
            M204 S5000
            G0 Z3.9 F4000
            G39.3 S1
            G0 Z3.9 F4000
            G392 S0
          
        M623
    
    M623
M623
; SKIPPABLE_END




; CHANGE_LAYER
; Z_HEIGHT: 3.56
; LAYER_HEIGHT: 0.0599999
; layer num/total_layer_count: 35/57
; update layer progress
M73 L35
M991 S0 P34 ;notify layer change
; OBJECT_ID: 8
G1 X95.907 Y86.344
G1 Z3.56
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
; LAYER_HEIGHT: 0.12
G1 F1500
M204 S500
G1 X95.907 Y86.857 E.01086
G1 X93.538 Y86.857 E.05015
G1 X93.538 Y86.344 E.01086
G1 X95.847 Y86.344 E.04888
M204 S10000
G1 X96.331 Y85.92 F18000
G1 F1500
M204 S500
G1 X96.331 Y87.282 E.02882
G1 X93.475 Y87.282 E.06046
G1 X93.475 Y88.382 E.02328
G1 X93.114 Y88.382 E.00765
G1 X93.114 Y77.127 E.23821
G1 X93.292 Y77.071 E.00395
G1 X93.355 Y77.162 E.00234
G1 X93.42 Y77.3 E.00324
G1 X93.459 Y77.448 E.00324
G1 X93.475 Y77.628 E.00382
G1 X93.475 Y85.92 E.17551
G1 X96.271 Y85.92 E.05919
; WIPE_START
M204 S6000
G1 X96.331 Y87.282 E-.25894
G1 X95.694 Y87.282 E-.12106
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X93.873 Y94.694 Z3.96 F18000
G1 X93.658 Y95.567 Z3.96
G1 Z3.56
G1 E.4 F1800
G1 F1500
M204 S500
G1 X93.122 Y95.806 E.01244
G1 X93.14 Y95.498 E.00654
G1 X93.162 Y95.423 E.00167
G1 X93.204 Y95.372 E.00138
G1 X93.295 Y95.347 E.00201
G1 X93.369 Y95.368 E.00162
G1 X93.609 Y95.533 E.00615
; WIPE_START
M204 S6000
G1 X93.122 Y95.806 E-.14404
G1 X93.14 Y95.498 E-.07963
G1 X93.162 Y95.423 E-.0203
G1 X93.204 Y95.372 E-.01687
G1 X93.295 Y95.347 E-.02447
G1 X93.369 Y95.368 E-.01976
G1 X93.609 Y95.533 E-.07494
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X86.097 Y96.887 Z3.96 F18000
G1 X84.86 Y97.11 Z3.96
G1 Z3.56
G1 E.4 F1800
G1 F1500
M204 S500
G1 X84.753 Y96.949 E.0041
G1 X85.105 Y96.544 E.01135
G1 X87.084 Y96.544 E.04188
G1 X87.437 Y96.951 E.0114
G1 X87.314 Y97.115 E.00436
G1 X87.193 Y97.06 E.00282
G1 X86.674 Y96.908 E.01145
G1 X86.036 Y96.853 E.01354
G1 X85.423 Y96.927 E.01306
G1 X84.917 Y97.092 E.01127
; WIPE_START
M204 S6000
G1 X84.753 Y96.949 E-.04131
G1 X85.105 Y96.544 E-.10189
G1 X86.351 Y96.544 E-.2368
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X83.484 Y99.805 Z3.96 F18000
G1 Z3.56
G1 E.4 F1800
G1 F1500
M204 S500
G1 X83.502 Y99.51 E.00625
G1 X83.613 Y99.054 E.00994
G1 X83.801 Y98.633 E.00976
G1 X83.975 Y98.361 E.00683
G1 X84.179 Y98.111 E.00683
G1 X84.515 Y97.809 E.00955
G1 X84.784 Y97.632 E.00683
G1 X85.073 Y97.487 E.00683
G1 X85.515 Y97.344 E.00984
G1 X86.044 Y97.28 E.01127
G1 X86.595 Y97.327 E.01172
G1 X87.043 Y97.458 E.00988
G1 X87.336 Y97.593 E.00683
G1 X87.611 Y97.763 E.00683
G1 X87.962 Y98.061 E.00975
G1 X88.261 Y98.424 E.00995
G1 X88.49 Y98.835 E.00995
G1 X88.638 Y99.27 E.00975
G1 X88.696 Y99.588 E.00683
G1 X88.715 Y99.91 E.00683
G1 X88.674 Y100.369 E.00975
G1 X88.549 Y100.822 E.00995
G1 X88.349 Y101.237 E.00976
G1 X88.167 Y101.504 E.00683
G1 X87.955 Y101.747 E.00683
G1 X87.6 Y102.048 E.00985
G1 X87.135 Y102.307 E.01127
G1 X86.607 Y102.473 E.01171
G1 X86.129 Y102.523 E.01018
G1 X85.599 Y102.475 E.01126
G1 X85.069 Y102.315 E.01172
G1 X84.65 Y102.089 E.01008
G1 X84.283 Y101.796 E.00995
G1 X83.973 Y101.442 E.00995
G1 X83.732 Y101.038 E.00995
G1 X83.57 Y100.607 E.00975
G1 X83.503 Y100.291 E.00683
G1 X83.474 Y99.97 E.00683
G1 X83.481 Y99.865 E.00223
M204 S250
G1 X83.893 Y99.829 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X83.908 Y99.571 E.00508
G1 X84.002 Y99.186 E.00779
G1 X84.162 Y98.827 E.00774
G1 X84.306 Y98.602 E.00526
G1 X84.476 Y98.395 E.00526
G1 X84.766 Y98.134 E.00767
G1 X84.989 Y97.987 E.00526
G1 X85.228 Y97.867 E.00526
G1 X85.604 Y97.745 E.00776
G1 X86.051 Y97.691 E.00886
G1 X86.52 Y97.731 E.00926
G1 X86.899 Y97.842 E.00778
G1 X87.142 Y97.954 E.00526
G1 X87.369 Y98.095 E.00526
G1 X87.669 Y98.349 E.00773
G1 X87.921 Y98.656 E.0078
G1 X88.114 Y99.002 E.00779
G1 X88.241 Y99.374 E.00773
G1 X88.289 Y99.637 E.00526
G1 X88.305 Y99.904 E.00526
G1 X88.27 Y100.296 E.00773
G1 X88.164 Y100.678 E.0078
G1 X87.994 Y101.032 E.00774
G1 X87.843 Y101.253 E.00526
G1 X87.667 Y101.455 E.00526
G1 X87.366 Y101.71 E.00776
G1 X86.973 Y101.929 E.00885
G1 X86.524 Y102.07 E.00925
G1 X86.126 Y102.112 E.00787
G1 X85.678 Y102.071 E.00885
G1 X85.227 Y101.935 E.00926
G1 X84.877 Y101.746 E.00783
G1 X84.567 Y101.499 E.0078
G1 X84.306 Y101.2 E.0078
G1 X84.102 Y100.86 E.0078
G1 X83.964 Y100.492 E.00773
G1 X83.909 Y100.23 E.00526
G1 X83.885 Y99.964 E.00526
G1 X83.889 Y99.889 E.00147
; WIPE_START
M204 S6000
G1 X83.908 Y99.571 E-.06051
G1 X84.002 Y99.186 E-.07528
G1 X84.162 Y98.827 E-.07476
G1 X84.306 Y98.602 E-.05081
G1 X84.476 Y98.395 E-.05081
G1 X84.741 Y98.156 E-.06783
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X84.855 Y96.12 Z3.96 F18000
G1 Z3.56
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X92.678 Y96.12 E.16557
G1 X92.718 Y95.441 E.0144
G1 X92.742 Y95.331 E.00238
G1 X92.81 Y95.184 E.00344
G1 X92.887 Y95.089 E.00258
G1 X93.063 Y94.97 E.0045
G1 X93.272 Y94.922 E.00455
G1 X93.375 Y94.929 E.00218
G1 X93.534 Y94.974 E.00349
G1 X93.961 Y95.261 E.0109
G1 X95.879 Y94.633 E.04271
G1 X98.51 Y90.875 E.09709
G1 X98.806 Y91.083 E.00765
G1 X96.105 Y94.94 E.09967
G1 X93.241 Y96.217 E.06637
G1 X93.046 Y96.355 E.00507
G1 X92.803 Y96.453 E.00554
G1 X92.559 Y96.482 E.0052
G1 X87.591 Y96.482 E.10514
G1 X88.777 Y97.845 E.03825
G1 X88.884 Y97.992 E.00386
G1 X89.097 Y98.348 E.00877
G1 X89.322 Y98.899 E.0126
G1 X89.448 Y99.476 E.01249
G1 X89.471 Y99.972 E.01052
G1 X89.421 Y100.499 E.01121
G1 X89.265 Y101.071 E.01255
G1 X89.008 Y101.615 E.01273
G1 X88.66 Y102.101 E.01265
G1 X88.377 Y102.394 E.00863
G1 X88.163 Y102.572 E.0059
G1 X87.737 Y102.855 E.01081
G1 X87.367 Y103.032 E.00868
G1 X86.978 Y103.164 E.00869
G1 X86.386 Y103.269 E.01273
G1 X85.794 Y103.267 E.01254
G1 X85.215 Y103.165 E.01244
G1 X84.747 Y102.998 E.01051
G1 X84.282 Y102.753 E.01113
G1 X83.961 Y102.522 E.00836
G1 X83.666 Y102.251 E.00849
G1 X83.404 Y101.947 E.00849
G1 X83.181 Y101.613 E.0085
G1 X83 Y101.26 E.00839
G1 X82.839 Y100.8 E.01032
G1 X82.737 Y100.284 E.01113
G1 X82.715 Y99.89 E.00836
G1 X82.74 Y99.49 E.00849
G1 X82.812 Y99.095 E.0085
G1 X82.93 Y98.716 E.00839
G1 X83.135 Y98.274 E.01032
G1 X83.422 Y97.833 E.01113
G1 X84.597 Y96.482 E.03791
G1 X79.631 Y96.482 E.10513
G1 X79.392 Y96.454 E.00508
G1 X79.119 Y96.34 E.00626
G1 X78.992 Y96.24 E.00343
G1 X78.884 Y96.119 E.00343
G1 X78.791 Y95.957 E.00394
G1 X78.743 Y95.812 E.00324
G1 X78.714 Y95.565 E.00527
G1 X78.714 Y77.619 E.37984
G1 X78.755 Y77.34 E.00597
G1 X78.861 Y77.118 E.0052
G1 X79.022 Y76.933 E.0052
G1 X79.265 Y76.786 E.00599
G1 X79.389 Y76.747 E.00276
G1 X79.552 Y76.723 E.0035
G1 X92.614 Y76.722 E.27646
G1 X92.743 Y76.735 E.00274
G1 X92.895 Y76.775 E.00334
G1 X93.124 Y76.904 E.00556
G1 X93.068 Y77.082 E.00395
G1 X80.044 Y77.082 E.27567
G1 X79.768 Y77.127 E.00591
G1 X79.477 Y77.279 E.00696
G1 X79.241 Y77.529 E.00726
G1 X79.112 Y77.807 E.00649
G1 X79.075 Y78.056 E.00533
G1 X79.075 Y95.173 E.3623
G1 X79.162 Y95.539 E.00795
G1 X79.343 Y95.797 E.00668
G1 X79.539 Y95.962 E.00542
G1 X79.8 Y96.084 E.0061
G1 X80.049 Y96.12 E.00533
G1 X84.795 Y96.12 E.10045
; WIPE_START
M204 S6000
G1 X86.795 Y96.12 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X83.699 Y96.891 Z3.96 F18000
G1 Z3.56
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X79.607 Y96.891 E.08049
G1 X79.297 Y96.855 E.00613
G1 X79.01 Y96.75 E.006
G1 X78.888 Y96.68 E.00277
G1 X78.71 Y96.539 E.00448
G1 X78.558 Y96.368 E.00448
G1 X78.412 Y96.114 E.00577
G1 X78.341 Y95.901 E.00442
G1 X78.304 Y95.589 E.00619
G1 X78.304 Y77.607 E.35368
G1 X78.313 Y77.454 E.00301
G1 X78.36 Y77.228 E.00454
G1 X78.409 Y77.093 E.00283
G1 X78.517 Y76.892 E.00448
G1 X78.659 Y76.714 E.00448
G1 X78.763 Y76.615 E.00283
G1 X78.951 Y76.484 E.00451
G1 X79.112 Y76.406 E.00352
G1 X79.296 Y76.347 E.0038
G1 X79.523 Y76.313 E.0045
G1 X92.635 Y76.312 E.2579
G1 X92.817 Y76.331 E.0036
G1 X93.035 Y76.389 E.00445
G1 X93.239 Y76.484 E.00442
G1 X93.423 Y76.613 E.00442
G1 X93.582 Y76.772 E.00442
G1 X93.711 Y76.956 E.00442
G1 X93.806 Y77.16 E.00442
G1 X93.864 Y77.377 E.00442
G1 X93.884 Y77.61 E.0046
G1 X93.884 Y85.511 E.1554
G1 X96.181 Y85.511 E.04518
G1 X96.494 Y85.198 E.00871
G1 X96.61 Y85.314 E.00322
G1 F2035.599
G1 X96.741 Y85.444 E.00363
G1 F1320
G1 X96.741 Y87.758 E.0455
G1 F1824.963
G1 X96.61 Y87.888 E.00363
G1 F1500
G1 X96.494 Y88.004 E.00322
G1 X96.181 Y87.691 E.00871
G1 X93.884 Y87.691 E.04518
G1 X93.884 Y88.791 E.02164
G1 X92.704 Y88.791 E.02321
G1 X92.704 Y77.491 E.22226
G1 X80.077 Y77.491 E.24837
G1 X79.899 Y77.52 E.00355
G1 X79.727 Y77.61 E.00383
G1 X79.584 Y77.762 E.00409
G1 X79.508 Y77.925 E.00355
G1 X79.484 Y78.086 E.00319
G1 X79.484 Y95.125 E.33516
G1 X79.542 Y95.368 E.0049
G1 X79.647 Y95.518 E.00361
G1 X79.761 Y95.614 E.00292
G1 X79.919 Y95.687 E.00343
G1 X80.079 Y95.711 E.00319
G1 X92.292 Y95.711 E.24022
G1 X92.312 Y95.386 E.00639
G1 X92.349 Y95.211 E.00353
G1 X92.416 Y95.045 E.00353
G1 X92.589 Y94.807 E.00577
G1 X92.672 Y94.732 E.0022
G1 X92.922 Y94.585 E.00571
G1 X93.161 Y94.521 E.00487
G1 X93.445 Y94.523 E.00559
G1 X93.68 Y94.59 E.00481
G1 X93.777 Y94.637 E.00213
G1 X94.027 Y94.809 E.00595
G1 X95.622 Y94.286 E.03302
G1 X98.41 Y90.305 E.09559
G1 X99.376 Y90.982 E.02321
G1 X96.375 Y95.268 E.10291
G1 X93.444 Y96.575 E.06312
G1 X93.258 Y96.706 E.00449
G1 X93.1 Y96.787 E.00348
G1 X92.891 Y96.855 E.00434
G1 X92.582 Y96.891 E.00611
G1 X88.49 Y96.891 E.08049
G1 X89.098 Y97.59 E.01823
G1 X89.226 Y97.767 E.0043
G1 X89.459 Y98.157 E.00894
G1 X89.592 Y98.445 E.00623
G1 X89.714 Y98.779 E.007
G1 X89.823 Y99.22 E.00892
G1 X89.855 Y99.435 E.00427
G1 X89.881 Y99.982 E.01077
G1 X89.826 Y100.564 E.0115
G1 X89.756 Y100.871 E.00619
G1 X89.65 Y101.212 E.00703
G1 X89.526 Y101.505 E.00625
G1 X89.361 Y101.821 E.00703
G1 X89.188 Y102.087 E.00625
G1 X88.97 Y102.369 E.007
G1 X88.656 Y102.694 E.00889
M73 P71 R7
G1 X88.412 Y102.897 E.00623
G1 X88.119 Y103.104 E.00707
G1 X87.93 Y103.216 E.00432
G1 X87.522 Y103.412 E.00891
G1 X87.092 Y103.557 E.00892
G1 X86.88 Y103.608 E.0043
G1 X86.429 Y103.676 E.00897
G1 X86.21 Y103.689 E.00431
G1 X85.757 Y103.676 E.00891
G1 X85.309 Y103.608 E.00891
G1 X85.098 Y103.557 E.00428
G1 X84.582 Y103.374 E.01077
G1 X84.066 Y103.102 E.01148
G1 X83.703 Y102.84 E.00881
G1 X83.371 Y102.536 E.00885
G1 X83.078 Y102.195 E.00885
G1 X82.827 Y101.821 E.00885
G1 X82.623 Y101.422 E.00882
G1 X82.443 Y100.908 E.01071
G1 X82.33 Y100.336 E.01147
G1 X82.305 Y99.889 E.00881
G1 X82.333 Y99.44 E.00885
G1 X82.414 Y98.997 E.00885
G1 X82.547 Y98.569 E.00882
G1 X82.776 Y98.075 E.01071
G1 X83.094 Y97.586 E.01148
G1 X83.659 Y96.936 E.01694
; WIPE_START
M204 S6000
G1 X81.66 Y96.914 E-.38
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




G1 X79.578 Y96.239
G1 Z3.56
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.102658
G1 F1500
M204 S6000
G1 X79.394 Y96.179 E.00074
; LINE_WIDTH: 0.154578
G1 X79.185 Y96.033 E.00164
G1 X79.046 Y95.853 E.00146
; LINE_WIDTH: 0.132626
G1 X79.002 Y95.753 E.00058
; LINE_WIDTH: 0.0954283
G1 X78.958 Y95.653 E.00038
; WIPE_START
G1 X79.002 Y95.753 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X84.642 Y97.165 Z3.96 F18000
G1 Z3.56
G1 E.4 F1800
; LINE_WIDTH: 0.477113
G1 F1500
M204 S6000
G1 X84.461 Y97.319 E.00534
; LINE_WIDTH: 0.438405
G1 X84.254 Y97.496 E.00562
; LINE_WIDTH: 0.400994
G1 X84.085 Y97.669 E.00453
; LINE_WIDTH: 0.359705
G1 X83.726 Y98.063 E.00887
G1 X83.466 Y98.457 E.00787
G1 X83.261 Y98.918 E.0084
G1 X83.132 Y99.439 E.00895
G1 X83.097 Y99.891 E.00755
G1 X83.116 Y100.237 E.00576
G1 X83.204 Y100.7 E.00787
G1 X83.352 Y101.11 E.00725
G1 X83.512 Y101.418 E.0058
G1 X83.708 Y101.716 E.00593
G1 X84.033 Y102.078 E.00811
G1 X84.455 Y102.412 E.00896
G1 X84.91 Y102.656 E.0086
G1 X85.32 Y102.793 E.00721
G1 X85.544 Y102.845 E.00383
G1 X85.828 Y102.883 E.00477
G1 X86.116 Y102.896 E.00481
G1 X86.349 Y102.886 E.00389
G1 X86.876 Y102.792 E.00891
G1 X87.3 Y102.647 E.00746
G1 X87.826 Y102.347 E.0101
G1 X88.211 Y102.024 E.00836
G1 X88.458 Y101.741 E.00626
G1 X88.68 Y101.423 E.00647
G1 X88.909 Y100.941 E.00888
G1 X89.047 Y100.439 E.00867
G1 X89.091 Y99.963 E.00797
G1 X89.071 Y99.533 E.00717
G1 X89.003 Y99.188 E.00586
G1 X88.955 Y99.012 E.00304
G1 X88.756 Y98.526 E.00875
G1 X88.562 Y98.201 E.0063
G1 X88.222 Y97.784 E.00897
; LINE_WIDTH: 0.378814
G1 X88.045 Y97.609 E.00438
; LINE_WIDTH: 0.41929
G1 X87.842 Y97.411 E.00556
; LINE_WIDTH: 0.468115
G1 X87.544 Y97.162 E.00858
; WIPE_START
G1 X87.842 Y97.411 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X94.012 Y95.553 Z3.96 F18000
G1 Z3.56
G1 E.4 F1800
; LINE_WIDTH: 0.153724
G1 F1500
M204 S6000
G1 X94.514 Y95.359 E.00344
; LINE_WIDTH: 0.104406
G1 X95.017 Y95.165 E.00211
; WIPE_START
G1 X94.514 Y95.359 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X95.534 Y87.795 Z3.96 F18000
G1 X95.695 Y86.601 Z3.96
G1 Z3.56
G1 E.4 F1800
; LINE_WIDTH: 0.114562
G1 F1500
M204 S6000
G1 X93.75 Y86.601 E.00862
; WIPE_START
G1 X95.695 Y86.601 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X89.148 Y82.678 Z3.96 F18000
G1 X79.593 Y76.954 Z3.96
G1 Z3.56
G1 E.4 F1800
; LINE_WIDTH: 0.100515
G1 F1500
M204 S6000
G1 X79.449 Y77 E.00056
; LINE_WIDTH: 0.149564
G1 X79.305 Y77.068 E.00099
G1 X79.206 Y77.152 E.0008
G1 X79.019 Y77.388 E.00185
; LINE_WIDTH: 0.0995338
G1 X78.949 Y77.602 E.00083
; WIPE_START
G1 X79.019 Y77.388 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X85.917 Y80.655 Z3.96 F18000
G1 X100.371 Y87.504 Z3.96
G1 Z3.56
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X100.647 Y87.111 E.00944
G1 X101.239 Y87.525 E.01423
G1 X101.613 Y87.787 E.00898
G1 X101.338 Y88.181 E.00944
G1 X100.42 Y87.538 E.02203
M204 S10000
G1 X100.676 Y87.424 F18000
; FEATURE: Gap infill
; LINE_WIDTH: 0.0964945
G1 F1500
M204 S6000
G1 X101.308 Y87.867 E.00272
; CHANGE_LAYER
; Z_HEIGHT: 3.68
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F1500
G1 X100.676 Y87.424 E-.38
; WIPE_END
G1 E-.02 F1800
; layer num/total_layer_count: 36/57
; update layer progress
M73 L36
M991 S0 P35 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z3.96 I.277 J-1.185 P1  F18000
G1 X96.051 Y86.344 Z3.96
G1 Z3.68
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X96.051 Y86.857 E.01086
G1 X93.538 Y86.857 E.05319
G1 X93.538 Y86.344 E.01086
G1 X95.991 Y86.344 E.05192
M204 S10000
G1 X96.475 Y85.92 F18000
G1 F1500
M204 S500
G1 X96.475 Y87.282 E.02882
G1 X93.475 Y87.282 E.0635
G1 X93.475 Y88.382 E.02328
G1 X93.114 Y88.382 E.00765
G1 X93.114 Y77.127 E.23821
G1 X93.292 Y77.071 E.00395
G1 X93.355 Y77.162 E.00234
G1 X93.42 Y77.3 E.00324
G1 X93.459 Y77.448 E.00324
G1 X93.475 Y77.628 E.00382
G1 X93.475 Y85.92 E.17551
G1 X96.415 Y85.92 E.06223
; WIPE_START
M204 S6000
G1 X96.475 Y87.282 E-.25894
G1 X95.838 Y87.282 E-.12106
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X93.896 Y94.663 Z4.08 F18000
G1 X93.658 Y95.567 Z4.08
G1 Z3.68
G1 E.4 F1800
G1 F1500
M204 S500
G1 X93.122 Y95.806 E.01244
G1 X93.156 Y95.424 E.00813
G1 X93.212 Y95.37 E.00165
G1 X93.295 Y95.347 E.00183
G1 X93.369 Y95.368 E.00162
G1 X93.609 Y95.533 E.00615
; WIPE_START
M204 S6000
G1 X93.122 Y95.806 E-.14397
G1 X93.156 Y95.424 E-.09893
G1 X93.212 Y95.37 E-.02014
G1 X93.295 Y95.347 E-.02229
G1 X93.369 Y95.368 E-.01977
G1 X93.609 Y95.533 E-.07489
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X86.682 Y96.544 Z4.08 F18000
G1 Z3.68
G1 E.4 F1800
G1 F1500
M204 S500
G1 X87.115 Y96.544 E.00916
G1 X87.475 Y96.97 E.0118
G1 X87.351 Y97.133 E.00433
G1 X87.193 Y97.06 E.00369
G1 X86.673 Y96.908 E.01145
G1 X86.033 Y96.853 E.0136
G1 X85.423 Y96.927 E.01301
G1 X84.86 Y97.11 E.01253
G1 X84.753 Y96.949 E.0041
G1 X85.105 Y96.544 E.01135
G1 X86.622 Y96.544 E.03211
; WIPE_START
M204 S6000
G1 X87.115 Y96.544 E-.09363
G1 X87.475 Y96.97 E-.10592
G1 X87.351 Y97.133 E-.03883
G1 X87.193 Y97.06 E-.0331
G1 X86.673 Y96.908 E-.10283
G1 X86.644 Y96.905 E-.0057
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X83.483 Y99.821 Z4.08 F18000
G1 Z3.68
G1 E.4 F1800
G1 F1500
M204 S500
G1 X83.502 Y99.51 E.00659
G1 X83.613 Y99.054 E.00994
G1 X83.801 Y98.633 E.00976
G1 X83.975 Y98.361 E.00683
G1 X84.179 Y98.111 E.00683
G1 X84.515 Y97.809 E.00956
G1 X84.784 Y97.632 E.00683
G1 X85.073 Y97.487 E.00683
G1 X85.515 Y97.344 E.00984
G1 X86.041 Y97.28 E.01121
G1 X86.595 Y97.327 E.01177
G1 X87.043 Y97.458 E.00988
G1 X87.336 Y97.593 E.00683
G1 X87.611 Y97.763 E.00683
G1 X87.962 Y98.061 E.00975
G1 X88.255 Y98.417 E.00975
G1 X88.42 Y98.694 E.00683
G1 X88.551 Y98.989 E.00683
G1 X88.674 Y99.433 E.00975
G1 X88.715 Y99.892 E.00975
G1 X88.696 Y100.214 E.00683
G1 X88.638 Y100.531 E.00683
G1 X88.489 Y100.967 E.00975
G1 X88.261 Y101.378 E.00995
G1 X87.962 Y101.741 E.00995
G1 X87.61 Y102.039 E.00976
G1 X87.336 Y102.208 E.00683
G1 X87.043 Y102.344 E.00683
G1 X86.601 Y102.473 E.00975
G1 X86.129 Y102.523 E.01004
G1 X85.602 Y102.476 E.01121
G1 X85.07 Y102.315 E.01177
G1 X84.65 Y102.089 E.01008
G1 X84.283 Y101.796 E.00995
G1 X83.971 Y101.439 E.01004
G1 X83.705 Y100.98 E.01121
G1 X83.531 Y100.452 E.01177
G1 X83.474 Y99.979 E.01008
G1 X83.48 Y99.881 E.00209
M204 S250
G1 X83.892 Y99.846 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X83.908 Y99.571 E.0054
G1 X84.002 Y99.186 E.00779
G1 X84.162 Y98.827 E.00774
G1 X84.306 Y98.602 E.00526
G1 X84.476 Y98.395 E.00526
G1 X84.766 Y98.134 E.00767
G1 X84.989 Y97.987 E.00526
G1 X85.228 Y97.867 E.00526
G1 X85.604 Y97.745 E.00776
G1 X86.048 Y97.691 E.00881
G1 X86.52 Y97.731 E.0093
G1 X86.899 Y97.842 E.00778
G1 X87.142 Y97.954 E.00526
G1 X87.369 Y98.095 E.00526
G1 X87.669 Y98.349 E.00773
G1 X87.919 Y98.653 E.00773
G1 X88.056 Y98.883 E.00526
G1 X88.165 Y99.127 E.00526
G1 X88.27 Y99.506 E.00773
G1 X88.305 Y99.898 E.00773
G1 X88.289 Y100.165 E.00526
G1 X88.241 Y100.428 E.00526
G1 X88.114 Y100.8 E.00773
G1 X87.921 Y101.146 E.00779
G1 X87.669 Y101.452 E.00779
G1 X87.369 Y101.707 E.00774
G1 X87.142 Y101.847 E.00526
G1 X86.899 Y101.96 E.00526
G1 X86.522 Y102.07 E.00774
G1 X86.126 Y102.112 E.00783
G1 X85.68 Y102.072 E.00881
G1 X85.227 Y101.935 E.0093
G1 X84.877 Y101.746 E.00784
G1 X84.567 Y101.499 E.0078
G1 X84.305 Y101.199 E.00783
G1 X84.081 Y100.812 E.00881
G1 X83.932 Y100.363 E.0093
G1 X83.885 Y99.967 E.00784
G1 X83.888 Y99.905 E.00121
; WIPE_START
M204 S6000
G1 X83.908 Y99.571 E-.06359
G1 X84.002 Y99.186 E-.07527
G1 X84.162 Y98.827 E-.07474
G1 X84.306 Y98.602 E-.05083
G1 X84.476 Y98.395 E-.05084
G1 X84.729 Y98.167 E-.06472
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X84.855 Y96.12 Z4.08 F18000
G1 Z3.68
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X92.678 Y96.12 E.16557
G1 X92.718 Y95.441 E.01439
G1 X92.742 Y95.328 E.00244
G1 X92.851 Y95.128 E.00482
G1 X92.934 Y95.048 E.00244
G1 X93.067 Y94.969 E.00328
G1 X93.272 Y94.922 E.00445
G1 X93.375 Y94.929 E.00218
G1 X93.534 Y94.974 E.00349
G1 X93.961 Y95.261 E.0109
G1 X95.879 Y94.633 E.04271
G1 X98.51 Y90.875 E.09709
G1 X98.806 Y91.083 E.00765
G1 X96.105 Y94.94 E.09967
G1 X93.236 Y96.22 E.06649
G1 X93.08 Y96.334 E.0041
G1 X92.938 Y96.409 E.00338
G1 X92.803 Y96.453 E.00302
G1 X92.559 Y96.482 E.0052
G1 X87.618 Y96.482 E.10459
G1 X88.816 Y97.901 E.03933
G1 X89.097 Y98.351 E.01122
G1 X89.262 Y98.72 E.00855
G1 X89.375 Y99.086 E.00811
G1 X89.451 Y99.499 E.00888
G1 X89.469 Y100.086 E.01244
G1 X89.406 Y100.565 E.01023
G1 X89.262 Y101.08 E.01131
G1 X89.012 Y101.607 E.01236
G1 X88.735 Y102.007 E.01028
G1 X88.372 Y102.398 E.01131
G1 X88.166 Y102.57 E.00567
G1 X87.738 Y102.855 E.0109
G1 X87.367 Y103.032 E.00869
G1 X86.978 Y103.164 E.00869
G1 X86.386 Y103.269 E.01273
G1 X85.794 Y103.267 E.01254
G1 X85.215 Y103.165 E.01244
G1 X84.751 Y103 E.01042
G1 X84.282 Y102.753 E.01122
G1 X83.961 Y102.522 E.00836
G1 X83.666 Y102.251 E.00849
G1 X83.404 Y101.947 E.00849
G1 X83.181 Y101.613 E.0085
G1 X83 Y101.26 E.0084
G1 X82.84 Y100.804 E.01022
G1 X82.737 Y100.284 E.01122
G1 X82.715 Y99.89 E.00836
G1 X82.74 Y99.49 E.00849
G1 X82.812 Y99.095 E.0085
G1 X82.931 Y98.711 E.00849
G1 X83.094 Y98.345 E.00849
G1 X83.411 Y97.845 E.01254
G1 X84.597 Y96.482 E.03824
G1 X79.631 Y96.482 E.10513
G1 X79.3 Y96.429 E.00709
G1 X79.066 Y96.304 E.00562
G1 X78.901 Y96.14 E.00491
G1 X78.831 Y96.037 E.00265
G1 X78.743 Y95.812 E.00511
G1 X78.714 Y95.565 E.00527
G1 X78.714 Y77.619 E.37984
G1 X78.753 Y77.349 E.00577
G1 X78.809 Y77.207 E.00324
G1 X78.895 Y77.069 E.00343
G1 X79.07 Y76.896 E.00521
G1 X79.285 Y76.778 E.0052
G1 X79.543 Y76.723 E.00558
G1 X92.615 Y76.722 E.27668
G1 X92.742 Y76.735 E.0027
G1 X92.895 Y76.775 E.00334
G1 X93.124 Y76.904 E.00557
G1 X93.068 Y77.082 E.00395
G1 X80.043 Y77.082 E.27568
G1 X79.767 Y77.127 E.00593
G1 X79.479 Y77.278 E.00688
G1 X79.251 Y77.515 E.00698
G1 X79.112 Y77.803 E.00675
G1 X79.075 Y78.056 E.00541
G1 X79.075 Y95.173 E.36231
G1 X79.161 Y95.534 E.00784
G1 X79.326 Y95.779 E.00626
G1 X79.533 Y95.959 E.00582
G1 X79.8 Y96.084 E.00623
G1 X80.049 Y96.12 E.00533
G1 X84.795 Y96.12 E.10045
; WIPE_START
M204 S6000
G1 X86.795 Y96.12 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X83.699 Y96.891 Z4.08 F18000
G1 Z3.68
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X79.607 Y96.891 E.08049
G1 X79.291 Y96.854 E.00625
G1 X78.975 Y96.731 E.00666
G1 X78.711 Y96.54 E.00641
G1 X78.578 Y96.394 E.00389
G1 X78.412 Y96.114 E.0064
G1 X78.341 Y95.901 E.00442
G1 X78.304 Y95.589 E.00619
G1 X78.304 Y77.607 E.35368
G1 X78.313 Y77.454 E.00301
G1 X78.359 Y77.231 E.00448
G1 X78.442 Y77.022 E.00442
G1 X78.562 Y76.828 E.00448
G1 X78.654 Y76.718 E.00283
G1 X78.825 Y76.567 E.00448
G1 X79.018 Y76.447 E.00448
G1 X79.151 Y76.39 E.00283
M73 P72 R7
G1 X79.374 Y76.33 E.00454
G1 X79.519 Y76.313 E.00289
G1 X92.636 Y76.312 E.258
G1 X92.817 Y76.331 E.00357
G1 X93.035 Y76.389 E.00445
G1 X93.239 Y76.484 E.00442
G1 X93.423 Y76.613 E.00442
G1 X93.582 Y76.772 E.00442
G1 X93.711 Y76.956 E.00442
G1 X93.806 Y77.16 E.00442
G1 X93.864 Y77.377 E.00442
G1 X93.884 Y77.61 E.0046
G1 X93.884 Y85.511 E.1554
G1 X96.181 Y85.511 E.04518
G1 X96.494 Y85.198 E.00871
G1 X96.782 Y85.485 E.00799
G1 F1915.118
G1 X96.884 Y85.588 E.00286
G1 F1680
G1 X96.884 Y87.614 E.03985
G1 F2117.844
G1 X96.782 Y87.717 E.00286
G1 F1500
G1 X96.494 Y88.004 E.00799
G1 X96.181 Y87.691 E.00871
G1 X93.884 Y87.691 E.04518
G1 X93.884 Y88.791 E.02164
G1 X92.704 Y88.791 E.02321
G1 X92.704 Y77.491 E.22226
G1 X80.077 Y77.491 E.24837
G1 X79.899 Y77.52 E.00355
G1 X79.728 Y77.61 E.00379
G1 X79.591 Y77.752 E.00389
G1 X79.508 Y77.924 E.00375
G1 X79.484 Y78.086 E.00321
G1 X79.484 Y95.125 E.33516
G1 X79.542 Y95.366 E.00487
G1 X79.635 Y95.505 E.0033
G1 X79.759 Y95.613 E.00322
G1 X79.919 Y95.687 E.00347
G1 X80.079 Y95.711 E.00319
G1 X92.292 Y95.711 E.24022
G1 X92.312 Y95.386 E.00639
G1 X92.349 Y95.21 E.00355
G1 X92.405 Y95.068 E.00301
G1 X92.545 Y94.855 E.005
G1 X92.675 Y94.73 E.00355
G1 X92.923 Y94.584 E.00566
G1 X93.161 Y94.521 E.00484
G1 X93.445 Y94.523 E.00559
G1 X93.68 Y94.59 E.00481
M73 P72 R6
G1 X93.777 Y94.637 E.00213
G1 X94.027 Y94.809 E.00595
G1 X95.622 Y94.286 E.03302
G1 X98.41 Y90.305 E.09559
G1 X99.376 Y90.982 E.02321
G1 X96.375 Y95.268 E.10291
G1 X93.442 Y96.576 E.06316
G1 X93.298 Y96.682 E.00353
G1 X93.099 Y96.787 E.00442
G1 X92.891 Y96.855 E.00431
G1 X92.582 Y96.891 E.00611
G1 X88.499 Y96.891 E.08032
G1 X89.148 Y97.659 E.01979
G1 X89.459 Y98.158 E.01157
G1 X89.643 Y98.57 E.00887
G1 X89.774 Y98.994 E.00873
G1 X89.856 Y99.443 E.00897
G1 X89.877 Y99.661 E.0043
G1 X89.878 Y100.112 E.00888
G1 X89.808 Y100.647 E.01062
G1 X89.649 Y101.215 E.01159
G1 X89.528 Y101.5 E.0061
G1 X89.363 Y101.819 E.00706
G1 X89.055 Y102.264 E.01064
G1 X88.654 Y102.695 E.01159
G1 X88.416 Y102.894 E.0061
G1 X87.93 Y103.216 E.01147
G1 X87.522 Y103.412 E.00891
G1 X87.092 Y103.557 E.00892
G1 X86.88 Y103.608 E.0043
G1 X86.429 Y103.676 E.00897
G1 X86.21 Y103.689 E.00431
G1 X85.757 Y103.676 E.00891
G1 X85.309 Y103.608 E.00891
G1 X85.098 Y103.557 E.00427
G1 X84.586 Y103.376 E.01068
G1 X84.066 Y103.102 E.01157
G1 X83.703 Y102.84 E.00881
G1 X83.371 Y102.536 E.00885
G1 X83.078 Y102.195 E.00885
G1 X82.827 Y101.821 E.00885
G1 X82.623 Y101.422 E.00882
G1 X82.444 Y100.913 E.01061
G1 X82.33 Y100.336 E.01157
G1 X82.305 Y99.889 E.00881
G1 X82.333 Y99.44 E.00885
G1 X82.414 Y98.997 E.00885
G1 X82.547 Y98.567 E.00885
G1 X82.73 Y98.156 E.00885
G1 X82.962 Y97.767 E.00891
G1 X83.091 Y97.59 E.0043
G1 X83.659 Y96.936 E.01705
; WIPE_START
M204 S6000
G1 X81.66 Y96.914 E-.38
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




G1 X79.578 Y96.239
G1 Z3.68
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.102541
G1 F1500
M204 S6000
G1 X79.389 Y96.181 E.00076
; LINE_WIDTH: 0.155681
G1 X79.191 Y96.038 E.00159
G1 X79.121 Y95.969 E.00063
G1 X79.045 Y95.852 E.0009
; LINE_WIDTH: 0.131495
G1 X79.002 Y95.751 E.00058
; LINE_WIDTH: 0.0950902
G1 X78.958 Y95.649 E.00038
; WIPE_START
G1 X79.002 Y95.751 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X84.642 Y97.165 Z4.08 F18000
G1 Z3.68
G1 E.4 F1800
; LINE_WIDTH: 0.477107
G1 F1500
M204 S6000
G1 X84.461 Y97.319 E.00533
; LINE_WIDTH: 0.438429
G1 X84.254 Y97.496 E.00561
; LINE_WIDTH: 0.401028
G1 X84.085 Y97.669 E.00453
; LINE_WIDTH: 0.359624
G1 X83.713 Y98.078 E.00921
G1 X83.476 Y98.444 E.00726
G1 X83.288 Y98.846 E.00739
G1 X83.186 Y99.186 E.00592
G1 X83.119 Y99.536 E.00593
G1 X83.098 Y100.005 E.00782
G1 X83.17 Y100.549 E.00914
G1 X83.349 Y101.11 E.00981
G1 X83.513 Y101.418 E.00581
G1 X83.708 Y101.716 E.00593
G1 X84.033 Y102.078 E.00811
G1 X84.455 Y102.412 E.00896
G1 X84.91 Y102.656 E.00861
G1 X85.32 Y102.793 E.0072
G1 X85.547 Y102.845 E.00388
G1 X85.828 Y102.883 E.00472
G1 X86.117 Y102.896 E.00481
G1 X86.349 Y102.886 E.00388
G1 X86.659 Y102.842 E.00521
G1 X87.165 Y102.702 E.00874
G1 X87.524 Y102.537 E.00659
G1 X87.821 Y102.349 E.00585
G1 X88.107 Y102.12 E.00612
G1 X88.436 Y101.766 E.00804
G1 X88.681 Y101.411 E.00718
G1 X88.837 Y101.106 E.00571
G1 X88.997 Y100.637 E.00826
G1 X89.069 Y100.249 E.00658
G1 X89.092 Y99.874 E.00626
G1 X89.039 Y99.352 E.00874
G1 X88.958 Y99.02 E.00569
G1 X88.761 Y98.527 E.00884
G1 X88.508 Y98.126 E.0079
G1 X88.222 Y97.784 E.00742
; LINE_WIDTH: 0.379973
G1 X88.046 Y97.608 E.0044
; LINE_WIDTH: 0.424071
G1 X87.847 Y97.411 E.00557
; LINE_WIDTH: 0.468512
G1 X87.581 Y97.181 E.00776
; WIPE_START
G1 X87.847 Y97.411 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X94.012 Y95.553 Z4.08 F18000
G1 Z3.68
G1 E.4 F1800
; LINE_WIDTH: 0.153724
G1 F1500
M204 S6000
G1 X94.514 Y95.359 E.00344
; LINE_WIDTH: 0.104406
G1 X95.017 Y95.165 E.00211
; WIPE_START
G1 X94.514 Y95.359 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X95.656 Y87.812 Z4.08 F18000
G1 X95.839 Y86.601 Z4.08
G1 Z3.68
G1 E.4 F1800
; LINE_WIDTH: 0.114562
G1 F1500
M204 S6000
G1 X93.75 Y86.601 E.00925
; WIPE_START
G1 X95.75 Y86.601 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X89.197 Y82.688 Z4.08 F18000
G1 X79.594 Y76.955 Z4.08
G1 Z3.68
G1 E.4 F1800
; LINE_WIDTH: 0.0820031
G1 F1500
M204 S6000
G1 X79.559 Y76.964 E.0001
; LINE_WIDTH: 0.0972499
G1 X79.467 Y76.997 E.00035
; LINE_WIDTH: 0.128518
G1 X79.31 Y77.067 E.00088
; LINE_WIDTH: 0.153105
G1 X79.157 Y77.201 E.00129
G1 X79.052 Y77.33 E.00106
G1 X79.005 Y77.423 E.00066
; LINE_WIDTH: 0.100818
G1 X78.949 Y77.603 E.00071
; WIPE_START
G1 X79.005 Y77.423 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X85.908 Y80.68 Z4.08 F18000
G1 X100.371 Y87.504 Z4.08
G1 Z3.68
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X100.647 Y87.111 E.00944
G1 X101.265 Y87.544 E.01486
G1 X101.613 Y87.787 E.00835
G1 X101.338 Y88.181 E.00944
G1 X100.42 Y87.538 E.02203
M204 S10000
G1 X100.676 Y87.424 F18000
; FEATURE: Gap infill
; LINE_WIDTH: 0.0965184
G1 F1500
M204 S6000
G1 X101.308 Y87.867 E.00272
; CHANGE_LAYER
; Z_HEIGHT: 3.76
; LAYER_HEIGHT: 0.0799999
; WIPE_START
G1 F1500
G1 X100.676 Y87.424 E-.38
; WIPE_END
G1 E-.02 F1800
; layer num/total_layer_count: 37/57
; update layer progress
M73 L37
M991 S0 P36 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z4.08 I-1.216 J.05 P1  F18000
G1 X100.731 Y88.741 Z4.08
G1 Z3.76
G1 E.4 F1800
; FEATURE: Support transition
; LINE_WIDTH: 0.42
; LAYER_HEIGHT: 0.26
G1 F1267.254
M204 S6000
G1 X100.731 Y89.07 E.01297
G1 X99.85 Y90.328 E.06048
G1 X99.837 Y90.319 E.00063
G1 X99.837 Y88.244 E.08169
G1 X98.942 Y89.521 E.06138
G1 X98.942 Y89.693 E.00676
; WIPE_START
G1 X98.942 Y89.521 E-.03261
G1 X99.837 Y88.244 E-.29622
G1 X99.837 Y88.514 E-.05117
; WIPE_END
G1 E-.02 F1800
M204 S10000
G17
G3 Z4.16 I1.217 J0 P1  F18000
;===================== date: 20250206 =====================

; don't support timelapse gcode in spiral_mode and by object sequence for I3 structure printer
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
G92 E0
G1 Z4.16
G1 X0 Y90 ; move to safe pos
G1 X-13.0 F3000 ; move to safe pos
M400
M1004 S5 P1  ; external shutter
M400 P300
M971 S11 C11 O0
G92 E0
G1 X0 F18000
M623

; SKIPTYPE: head_wrap_detect
M622.1 S1
M1002 judge_flag g39_3rd_layer_detect_flag
M622 J1
    ; enable nozzle clog detect at 3rd layer
    


    M622.1 S1
    M1002 judge_flag g39_detection_flag
    M622 J1
      
        M622.1 S0
        M1002 judge_flag g39_mass_exceed_flag
        M622 J1
        
            G392 S0
            M400
            G90
            M83
            M204 S5000
            G0 Z4.16 F4000
            G39.3 S1
            G0 Z4.16 F4000
            G392 S0
          
        M623
    
    M623
M623
; SKIPPABLE_END




; CHANGE_LAYER
; Z_HEIGHT: 3.8
; LAYER_HEIGHT: 0.04
; layer num/total_layer_count: 38/57
; update layer progress
M73 L38
M991 S0 P37 ;notify layer change
; OBJECT_ID: 8
G1 X96.051 Y86.344
G1 Z3.8
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
; LAYER_HEIGHT: 0.12
G1 F1500
M204 S500
G1 X96.051 Y86.857 E.01086
G1 X93.538 Y86.857 E.05319
G1 X93.538 Y86.344 E.01086
G1 X95.991 Y86.344 E.05192
M204 S10000
G1 X96.475 Y85.92 F18000
G1 F1500
M204 S500
G1 X96.475 Y87.282 E.02882
G1 X93.475 Y87.282 E.0635
G1 X93.475 Y88.382 E.02328
G1 X93.114 Y88.382 E.00765
G1 X93.114 Y77.127 E.23821
G1 X93.292 Y77.071 E.00395
G1 X93.355 Y77.162 E.00234
G1 X93.42 Y77.301 E.00324
G1 X93.459 Y77.448 E.00324
G1 X93.475 Y77.628 E.00382
G1 X93.475 Y85.92 E.17551
G1 X96.415 Y85.92 E.06223
; WIPE_START
M204 S6000
G1 X96.475 Y87.282 E-.25894
G1 X95.838 Y87.282 E-.12106
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X93.903 Y94.665 Z4.2 F18000
G1 X93.668 Y95.563 Z4.2
G1 Z3.8
G1 E.4 F1800
G1 F1500
M204 S500
G1 X93.122 Y95.806 E.01266
G1 X93.149 Y95.456 E.00743
G1 X93.191 Y95.387 E.00171
G1 X93.246 Y95.351 E.00139
G1 X93.307 Y95.353 E.00129
G1 X93.359 Y95.369 E.00116
M73 P73 R6
G1 X93.617 Y95.531 E.00644
; WIPE_START
M204 S6000
G1 X93.122 Y95.806 E-.14511
G1 X93.149 Y95.456 E-.0899
G1 X93.191 Y95.387 E-.02067
G1 X93.246 Y95.351 E-.0168
G1 X93.307 Y95.353 E-.01565
G1 X93.359 Y95.369 E-.01403
G1 X93.617 Y95.531 E-.07785
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X86.106 Y96.886 Z4.2 F18000
G1 X84.86 Y97.11 Z4.2
G1 Z3.8
G1 E.4 F1800
G1 F1500
M204 S500
G1 X84.753 Y96.949 E.0041
G1 X85.105 Y96.544 E.01135
G1 X87.084 Y96.544 E.04188
G1 X87.433 Y96.946 E.01127
G1 X87.303 Y97.112 E.00445
G1 X87.215 Y97.066 E.00211
G1 X86.699 Y96.915 E.01137
G1 X86.326 Y96.865 E.00797
G1 X85.998 Y96.857 E.00694
G1 X85.423 Y96.927 E.01226
G1 X84.917 Y97.092 E.01126
; WIPE_START
M204 S6000
G1 X84.753 Y96.949 E-.04131
G1 X85.105 Y96.544 E-.10189
G1 X86.351 Y96.544 E-.2368
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X83.483 Y99.83 Z4.2 F18000
G1 Z3.8
G1 E.4 F1800
G1 F1500
M204 S500
G1 X83.502 Y99.506 E.00686
G1 X83.629 Y99.014 E.01075
G1 X83.735 Y98.762 E.00579
G1 X83.891 Y98.482 E.00678
G1 X84.172 Y98.118 E.00975
G1 X84.515 Y97.809 E.00975
G1 X84.784 Y97.632 E.00683
G1 X85.073 Y97.487 E.00683
G1 X85.515 Y97.344 E.00984
G1 X86.019 Y97.282 E.01075
G1 X86.292 Y97.288 E.00579
G1 X86.61 Y97.331 E.00679
G1 X87.056 Y97.462 E.00983
G1 X87.507 Y97.695 E.01075
G1 X87.73 Y97.854 E.00579
G1 X87.961 Y98.062 E.00659
G1 X88.167 Y98.298 E.00663
G1 X88.349 Y98.565 E.00683
G1 X88.549 Y98.98 E.00976
G1 X88.674 Y99.433 E.00995
G1 X88.715 Y99.892 E.00975
G1 X88.696 Y100.212 E.00678
G1 X88.649 Y100.481 E.00579
G1 X88.492 Y100.964 E.01075
G1 X88.261 Y101.378 E.01003
G1 X87.962 Y101.741 E.00995
G1 X87.603 Y102.045 E.00995
G1 X87.205 Y102.275 E.00975
G1 X86.904 Y102.393 E.00683
G1 X86.592 Y102.474 E.00683
G1 X86.143 Y102.521 E.00956
G1 X85.821 Y102.507 E.00683
G1 X85.502 Y102.454 E.00684
G1 X85.064 Y102.312 E.00975
G1 X84.65 Y102.089 E.00994
G1 X84.283 Y101.796 E.00995
G1 X83.973 Y101.442 E.00995
G1 X83.732 Y101.039 E.00994
G1 X83.57 Y100.607 E.00975
G1 X83.503 Y100.291 E.00683
G1 X83.474 Y99.97 E.00683
G1 X83.479 Y99.889 E.00171
M204 S250
G1 X83.891 Y99.854 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X83.908 Y99.57 E.0056
G1 X84.018 Y99.145 E.00863
G1 X84.103 Y98.941 E.00435
G1 X84.233 Y98.708 E.00524
G1 X84.474 Y98.397 E.00773
G1 X84.766 Y98.134 E.00774
G1 X84.989 Y97.987 E.00526
G1 X85.228 Y97.867 E.00526
G1 X85.604 Y97.745 E.00776
G1 X86.039 Y97.692 E.00863
G1 X86.26 Y97.697 E.00435
G1 X86.525 Y97.733 E.00525
G1 X86.903 Y97.843 E.00776
G1 X87.293 Y98.045 E.00863
G1 X87.473 Y98.173 E.00435
G1 X87.669 Y98.35 E.00518
G1 X87.843 Y98.549 E.0052
G1 X87.994 Y98.77 E.00526
G1 X88.164 Y99.124 E.00774
G1 X88.27 Y99.506 E.00779
G1 X88.305 Y99.898 E.00773
G1 X88.289 Y100.164 E.00525
G1 X88.251 Y100.382 E.00435
G1 X88.115 Y100.799 E.00863
G1 X87.921 Y101.146 E.00782
G1 X87.669 Y101.452 E.0078
G1 X87.367 Y101.709 E.0078
G1 X87.027 Y101.905 E.00773
G1 X86.777 Y102.003 E.00526
G1 X86.519 Y102.07 E.00526
G1 X86.131 Y102.111 E.00767
G1 X85.863 Y102.099 E.00526
G1 X85.599 Y102.055 E.00527
G1 X85.225 Y101.934 E.00773
G1 X84.877 Y101.746 E.00779
G1 X84.566 Y101.499 E.0078
G1 X84.306 Y101.2 E.00779
G1 X84.103 Y100.86 E.00779
G1 X83.964 Y100.492 E.00774
G1 X83.909 Y100.23 E.00526
G1 X83.885 Y99.964 E.00526
G1 X83.888 Y99.914 E.00098
; WIPE_START
M204 S6000
G1 X83.908 Y99.57 E-.06548
G1 X84.018 Y99.145 E-.08335
G1 X84.103 Y98.941 E-.04203
G1 X84.233 Y98.708 E-.05066
G1 X84.474 Y98.397 E-.0747
G1 X84.723 Y98.173 E-.06378
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X84.855 Y96.12 Z4.2 F18000
G1 Z3.8
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X92.678 Y96.12 E.16557
G1 X92.718 Y95.441 E.01439
G1 X92.742 Y95.331 E.00238
G1 X92.81 Y95.184 E.00344
G1 X92.887 Y95.09 E.00257
G1 X93.073 Y94.965 E.00475
G1 X93.233 Y94.926 E.00348
G1 X93.378 Y94.931 E.00306
G1 X93.537 Y94.98 E.00352
G1 X93.977 Y95.256 E.01099
G1 X95.879 Y94.633 E.04236
G1 X98.51 Y90.875 E.09709
G1 X98.806 Y91.083 E.00765
G1 X96.105 Y94.94 E.09967
G1 X93.244 Y96.216 E.0663
G1 X93.021 Y96.37 E.00573
G1 X92.803 Y96.453 E.00495
G1 X92.559 Y96.482 E.0052
G1 X87.591 Y96.482 E.10514
G1 X88.771 Y97.838 E.03805
G1 X89.091 Y98.337 E.01254
G1 X89.262 Y98.72 E.00888
G1 X89.421 Y99.3 E.01273
G1 X89.45 Y99.49 E.00406
G1 X89.469 Y100.086 E.01263
G1 X89.406 Y100.57 E.01034
G1 X89.268 Y101.065 E.01087
G1 X89.009 Y101.611 E.01279
G1 X88.785 Y101.947 E.00854
G1 X88.517 Y102.258 E.00869
G1 X88.061 Y102.65 E.01273
G1 X87.543 Y102.955 E.01274
G1 X87.188 Y103.099 E.00811
G1 X86.792 Y103.208 E.00869
G1 X86.386 Y103.269 E.00868
G1 X85.794 Y103.267 E.01254
G1 X85.215 Y103.165 E.01245
G1 X84.746 Y102.998 E.01053
G1 X84.294 Y102.762 E.01079
G1 X83.961 Y102.522 E.00869
G1 X83.666 Y102.251 E.00849
G1 X83.404 Y101.947 E.00849
G1 X83.183 Y101.617 E.0084
G1 X82.967 Y101.179 E.01034
G1 X82.81 Y100.699 E.01069
G1 X82.73 Y100.208 E.01053
G1 X82.72 Y99.698 E.01079
G1 X82.77 Y99.291 E.00869
G1 X82.866 Y98.901 E.00849
G1 X83.007 Y98.526 E.00849
G1 X83.192 Y98.17 E.0085
G1 X83.417 Y97.838 E.00849
G1 X84.597 Y96.482 E.03805
G1 X79.631 Y96.482 E.10513
G1 X79.3 Y96.429 E.00709
G1 X79.066 Y96.304 E.00562
G1 X78.884 Y96.119 E.00549
G1 X78.744 Y95.821 E.00696
G1 X78.714 Y95.565 E.00546
G1 X78.714 Y77.619 E.37984
G1 X78.754 Y77.344 E.00588
G1 X78.859 Y77.12 E.00524
G1 X79.043 Y76.917 E.0058
G1 X79.153 Y76.841 E.00283
G1 X79.298 Y76.773 E.0034
G1 X79.55 Y76.723 E.00543
G1 X92.617 Y76.722 E.27658
G1 X92.742 Y76.735 E.00266
G1 X92.895 Y76.775 E.00334
G1 X93.124 Y76.904 E.00556
G1 X93.068 Y77.082 E.00395
G1 X80.04 Y77.082 E.27575
G1 X79.752 Y77.133 E.0062
G1 X79.474 Y77.283 E.00669
G1 X79.241 Y77.529 E.00717
G1 X79.112 Y77.807 E.00649
G1 X79.075 Y78.056 E.00533
G1 X79.075 Y95.173 E.36231
G1 X79.161 Y95.534 E.00784
G1 X79.326 Y95.778 E.00625
G1 X79.533 Y95.959 E.00583
G1 X79.8 Y96.084 E.00623
G1 X80.049 Y96.12 E.00533
G1 X84.795 Y96.12 E.10045
; WIPE_START
M204 S6000
G1 X86.795 Y96.12 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X83.699 Y96.891 Z4.2 F18000
G1 Z3.8
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X79.607 Y96.891 E.08049
G1 X79.291 Y96.854 E.00625
G1 X78.974 Y96.731 E.0067
G1 X78.712 Y96.541 E.00636
G1 X78.558 Y96.369 E.00454
G1 X78.479 Y96.248 E.00283
G1 X78.382 Y96.039 E.00454
G1 X78.341 Y95.904 E.00277
G1 X78.304 Y95.589 E.00625
G1 X78.304 Y77.607 E.35368
G1 X78.313 Y77.454 E.00301
G1 X78.36 Y77.23 E.00451
G1 X78.422 Y77.065 E.00345
G1 X78.517 Y76.893 E.00387
G1 X78.658 Y76.715 E.00447
G1 X78.787 Y76.596 E.00346
G1 X78.949 Y76.485 E.00386
G1 X79.155 Y76.389 E.00447
G1 X79.324 Y76.341 E.00346
G1 X79.522 Y76.313 E.00392
G1 X92.638 Y76.312 E.25799
G1 X92.817 Y76.331 E.00353
G1 X93.035 Y76.389 E.00445
G1 X93.239 Y76.484 E.00442
G1 X93.423 Y76.613 E.00442
G1 X93.582 Y76.772 E.00442
G1 X93.711 Y76.956 E.00442
G1 X93.806 Y77.16 E.00442
G1 X93.864 Y77.377 E.00442
G1 X93.884 Y77.61 E.0046
G1 X93.884 Y85.511 E.1554
G1 X96.181 Y85.511 E.04518
G1 X96.494 Y85.198 E.00871
G1 X96.884 Y85.588 E.01085
G1 X96.884 Y87.614 E.03985
G1 X96.494 Y88.004 E.01085
G1 X96.181 Y87.691 E.00871
G1 X93.884 Y87.691 E.04518
G1 X93.884 Y88.791 E.02164
G1 X92.704 Y88.791 E.02321
G1 X92.704 Y77.491 E.22226
G1 X80.076 Y77.491 E.24839
G1 X79.888 Y77.524 E.00376
G1 X79.726 Y77.611 E.00362
G1 X79.584 Y77.762 E.00406
G1 X79.508 Y77.925 E.00355
G1 X79.484 Y78.086 E.00318
G1 X79.484 Y95.125 E.33516
G1 X79.542 Y95.366 E.00487
G1 X79.635 Y95.505 E.00329
G1 X79.759 Y95.613 E.00323
G1 X79.919 Y95.687 E.00347
G1 X80.079 Y95.711 E.00319
G1 X92.292 Y95.711 E.24022
G1 X92.312 Y95.387 E.00639
G1 X92.349 Y95.211 E.00353
G1 X92.417 Y95.044 E.00354
G1 X92.589 Y94.807 E.00577
G1 X92.672 Y94.732 E.00219
G1 X92.925 Y94.583 E.00579
G1 X93.208 Y94.516 E.00572
G1 X93.446 Y94.524 E.00467
G1 X93.708 Y94.604 E.00539
G1 X94.032 Y94.807 E.00752
G1 X95.622 Y94.286 E.03291
G1 X98.41 Y90.305 E.09559
G1 X99.376 Y90.982 E.02321
G1 X96.375 Y95.268 E.10291
G1 X93.445 Y96.574 E.0631
G1 X93.229 Y96.723 E.00516
G1 X93.102 Y96.786 E.00279
G1 X92.891 Y96.855 E.00437
G1 X92.582 Y96.891 E.00611
G1 X88.49 Y96.891 E.08049
G1 X89.096 Y97.588 E.01816
G1 X89.351 Y97.962 E.00891
G1 X89.457 Y98.153 E.00431
G1 X89.643 Y98.57 E.00897
G1 X89.714 Y98.777 E.00431
G1 X89.823 Y99.22 E.00897
G1 X89.877 Y99.661 E.00873
G1 X89.878 Y100.112 E.00888
G1 X89.808 Y100.646 E.01059
G1 X89.721 Y101 E.00718
G1 X89.53 Y101.496 E.01045
G1 X89.362 Y101.82 E.00719
G1 X89.111 Y102.195 E.00886
G1 X88.816 Y102.538 E.00891
G1 X88.659 Y102.691 E.00431
G1 X88.305 Y102.979 E.00897
G1 X88.124 Y103.102 E.00431
G1 X87.725 Y103.322 E.00897
G1 X87.313 Y103.489 E.00873
G1 X86.876 Y103.609 E.00891
G1 X86.429 Y103.676 E.00891
G1 X86.21 Y103.689 E.00431
G1 X85.757 Y103.676 E.00891
G1 X85.309 Y103.608 E.00891
G1 X85.098 Y103.557 E.00428
G1 X84.588 Y103.376 E.01065
G1 X84.259 Y103.217 E.00718
G1 X84.07 Y103.105 E.00432
G1 X83.703 Y102.84 E.00891
G1 X83.371 Y102.536 E.00885
G1 X83.078 Y102.195 E.00885
G1 X82.828 Y101.822 E.00882
G1 X82.59 Y101.339 E.01059
G1 X82.409 Y100.785 E.01146
G1 X82.323 Y100.251 E.01065
G1 X82.305 Y99.886 E.00718
G1 X82.312 Y99.667 E.00432
G1 X82.367 Y99.217 E.00891
G1 X82.474 Y98.78 E.00885
G1 X82.633 Y98.359 E.00885
G1 X82.84 Y97.96 E.00885
G1 X83.093 Y97.588 E.00885
G1 X83.659 Y96.936 E.01698
; WIPE_START
M204 S6000
G1 X81.66 Y96.914 E-.38
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
M73 P74 R6
G1 X0 F18000
M623

; SKIPTYPE: head_wrap_detect
M622.1 S1
M1002 judge_flag g39_3rd_layer_detect_flag
M622 J1
    ; enable nozzle clog detect at 3rd layer
    


    M622.1 S1
    M1002 judge_flag g39_detection_flag
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




G1 X79.578 Y96.239
G1 Z3.8
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.102558
G1 F1500
M204 S6000
G1 X79.389 Y96.181 E.00076
; LINE_WIDTH: 0.149631
G1 X79.195 Y96.041 E.00148
G1 X79.113 Y95.955 E.00073
G1 X78.941 Y95.655 E.00214
; WIPE_START
G1 X79.113 Y95.955 E-.18661
G1 X79.195 Y96.041 E-.06413
G1 X79.389 Y96.181 E-.12926
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X84.642 Y97.165 Z4.2 F18000
G1 Z3.8
G1 E.4 F1800
; LINE_WIDTH: 0.477118
G1 F1500
M204 S6000
G1 X84.461 Y97.319 E.00533
; LINE_WIDTH: 0.438435
G1 X84.254 Y97.496 E.00561
; LINE_WIDTH: 0.400638
G1 X84.08 Y97.673 E.00465
; LINE_WIDTH: 0.359882
G1 X83.886 Y97.872 E.00463
G1 X83.569 Y98.285 E.00867
G1 X83.356 Y98.681 E.00751
G1 X83.233 Y99.015 E.00593
G1 X83.132 Y99.432 E.00715
G1 X83.099 Y99.963 E.00888
G1 X83.131 Y100.338 E.00626
G1 X83.22 Y100.758 E.00717
G1 X83.402 Y101.214 E.00817
G1 X83.66 Y101.651 E.00847
G1 X83.941 Y101.985 E.00727
G1 X84.202 Y102.223 E.00589
G1 X84.457 Y102.408 E.00525
G1 X84.902 Y102.653 E.00847
G1 X85.319 Y102.796 E.00735
G1 X85.828 Y102.888 E.00862
G1 X86.352 Y102.885 E.00874
G1 X86.713 Y102.835 E.00609
G1 X87.068 Y102.737 E.00614
G1 X87.374 Y102.615 E.00549
G1 X87.809 Y102.362 E.00838
G1 X88.242 Y101.996 E.00946
G1 X88.479 Y101.714 E.00613
G1 X88.677 Y101.418 E.00594
G1 X88.827 Y101.127 E.00546
G1 X88.907 Y100.93 E.00355
G1 X89.012 Y100.584 E.00603
G1 X89.067 Y100.264 E.00541
G1 X89.092 Y99.874 E.00652
G1 X89.048 Y99.372 E.0084
G1 X88.904 Y98.862 E.00883
G1 X88.749 Y98.511 E.0064
G1 X88.469 Y98.068 E.00874
G1 X88.225 Y97.788 E.00619
; LINE_WIDTH: 0.382969
G1 X87.973 Y97.533 E.00638
; LINE_WIDTH: 0.423619
G1 X87.861 Y97.432 E.003
; LINE_WIDTH: 0.477396
G1 X87.535 Y97.16 E.00956
; WIPE_START
G1 X87.861 Y97.432 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X94.036 Y95.543 Z4.2 F18000
G1 Z3.8
G1 E.4 F1800
; LINE_WIDTH: 0.151611
G1 F1500
M204 S6000
G1 X94.526 Y95.354 E.0033
; LINE_WIDTH: 0.103702
G1 X95.017 Y95.165 E.00204
; WIPE_START
G1 X94.526 Y95.354 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X95.658 Y87.806 Z4.2 F18000
G1 X95.839 Y86.601 Z4.2
G1 Z3.8
G1 E.4 F1800
; LINE_WIDTH: 0.114562
G1 F1500
M204 S6000
G1 X93.75 Y86.601 E.00925
; WIPE_START
G1 X95.75 Y86.601 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X89.196 Y82.689 Z4.2 F18000
G1 X79.59 Y76.954 Z4.2
G1 Z3.8
G1 E.4 F1800
; LINE_WIDTH: 0.0923629
G1 F1500
M204 S6000
G1 X79.49 Y76.989 E.00035
; LINE_WIDTH: 0.12983
G1 X79.291 Y77.078 E.00113
; LINE_WIDTH: 0.155982
G1 X79.169 Y77.19 E.00107
G1 X79.027 Y77.374 E.00151
; LINE_WIDTH: 0.0986179
G1 X78.949 Y77.601 E.00087
; WIPE_START
G1 X79.027 Y77.374 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X85.923 Y80.647 Z4.2 F18000
G1 X100.371 Y87.504 Z4.2
G1 Z3.8
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X100.647 Y87.111 E.00944
G1 X101.291 Y87.562 E.01549
G1 X101.613 Y87.787 E.00772
G1 X101.338 Y88.181 E.00944
G1 X100.42 Y87.538 E.02203
M204 S10000
G1 X100.676 Y87.425 F18000
; FEATURE: Gap infill
; LINE_WIDTH: 0.0965122
G1 F1500
M204 S6000
G1 X101.308 Y87.867 E.00272
; CHANGE_LAYER
; Z_HEIGHT: 3.92
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F1500
G1 X100.676 Y87.425 E-.38
; WIPE_END
G1 E-.02 F1800
; layer num/total_layer_count: 39/57
; update layer progress
M73 L39
M991 S0 P38 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z4.2 I.277 J-1.185 P1  F18000
G1 X96.051 Y86.344 Z4.2
G1 Z3.92
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X96.051 Y86.857 E.01086
G1 X93.538 Y86.857 E.05319
G1 X93.538 Y86.344 E.01086
G1 X95.991 Y86.344 E.05192
M204 S10000
G1 X96.475 Y85.92 F18000
G1 F1500
M204 S500
G1 X96.475 Y87.282 E.02882
G1 X93.475 Y87.282 E.0635
G1 X93.475 Y88.382 E.02328
G1 X93.114 Y88.382 E.00765
G1 X93.114 Y77.127 E.23821
G1 X93.292 Y77.071 E.00395
G1 X93.355 Y77.162 E.00234
G1 X93.42 Y77.3 E.00324
G1 X93.459 Y77.448 E.00324
G1 X93.475 Y77.628 E.00382
G1 X93.475 Y85.92 E.17551
G1 X96.415 Y85.92 E.06223
; WIPE_START
M204 S6000
G1 X96.475 Y87.282 E-.25894
G1 X95.838 Y87.282 E-.12106
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X93.903 Y94.665 Z4.32 F18000
G1 X93.668 Y95.563 Z4.32
G1 Z3.92
G1 E.4 F1800
G1 F1500
M204 S500
G1 X93.116 Y95.809 E.01278
G1 X93.144 Y95.468 E.00724
G1 X93.166 Y95.414 E.00123
G1 X93.212 Y95.37 E.00135
G1 X93.291 Y95.349 E.00174
G1 X93.36 Y95.369 E.00152
G1 X93.617 Y95.531 E.00642
; WIPE_START
M204 S6000
G1 X93.116 Y95.809 E-.14566
G1 X93.144 Y95.468 E-.087
G1 X93.166 Y95.414 E-.01479
G1 X93.212 Y95.37 E-.0162
G1 X93.291 Y95.349 E-.02091
G1 X93.36 Y95.369 E-.01829
G1 X93.617 Y95.531 E-.07715
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X86.106 Y96.886 Z4.32 F18000
G1 X84.86 Y97.11 Z4.32
G1 Z3.92
G1 E.4 F1800
G1 F1500
M204 S500
G1 X84.753 Y96.949 E.0041
G1 X85.105 Y96.544 E.01135
G1 X87.084 Y96.544 E.04187
G1 X87.433 Y96.946 E.01127
G1 X87.303 Y97.112 E.00445
G1 X87.214 Y97.066 E.00212
G1 X86.699 Y96.915 E.01137
G1 X86.325 Y96.864 E.00797
G1 X85.995 Y96.857 E.007
G1 X85.422 Y96.928 E.0122
G1 X84.917 Y97.092 E.01125
; WIPE_START
M204 S6000
G1 X84.753 Y96.949 E-.04131
G1 X85.105 Y96.544 E-.10188
G1 X86.352 Y96.544 E-.23681
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X83.482 Y99.842 Z4.32 F18000
G1 Z3.92
G1 E.4 F1800
G1 F1500
M204 S500
G1 X83.502 Y99.506 E.00711
G1 X83.628 Y99.017 E.01069
G1 X83.735 Y98.762 E.00585
G1 X83.891 Y98.482 E.00679
G1 X84.173 Y98.118 E.00975
G1 X84.515 Y97.809 E.00975
G1 X84.784 Y97.632 E.00683
G1 X85.073 Y97.487 E.00683
G1 X85.515 Y97.344 E.00983
G1 X86.016 Y97.282 E.01069
G1 X86.292 Y97.288 E.00584
G1 X86.61 Y97.331 E.00679
G1 X87.056 Y97.461 E.00983
G1 X87.505 Y97.693 E.01069
G1 X87.73 Y97.854 E.00584
G1 X87.961 Y98.062 E.00659
G1 X88.167 Y98.298 E.00663
G1 X88.349 Y98.564 E.00683
G1 X88.549 Y98.98 E.00975
G1 X88.674 Y99.433 E.00995
G1 X88.715 Y99.892 E.00975
G1 X88.696 Y100.212 E.00679
G1 X88.649 Y100.484 E.00585
G1 X88.491 Y100.964 E.01069
G1 X88.261 Y101.378 E.01003
G1 X87.962 Y101.741 E.00995
G1 X87.6 Y102.047 E.01004
G1 X87.16 Y102.294 E.01069
G1 X86.902 Y102.393 E.00584
G1 X86.592 Y102.474 E.00679
G1 X86.134 Y102.522 E.00975
G1 X85.665 Y102.487 E.00995
G1 X85.219 Y102.371 E.00975
G1 X84.922 Y102.245 E.00683
G1 X84.643 Y102.083 E.00683
G1 X84.283 Y101.796 E.00975
G1 X83.973 Y101.442 E.00995
G1 X83.732 Y101.038 E.00995
G1 X83.57 Y100.607 E.00975
G1 X83.503 Y100.291 E.00683
G1 X83.474 Y99.97 E.00683
G1 X83.479 Y99.901 E.00145
M204 S250
G1 X83.891 Y99.866 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X83.908 Y99.57 E.00583
G1 X84.017 Y99.148 E.00858
G1 X84.103 Y98.941 E.0044
G1 X84.233 Y98.708 E.00525
G1 X84.474 Y98.397 E.00774
G1 X84.766 Y98.134 E.00773
G1 X84.989 Y97.987 E.00526
G1 X85.228 Y97.867 E.00526
G1 X85.604 Y97.745 E.00776
G1 X86.037 Y97.692 E.00858
G1 X86.26 Y97.697 E.0044
G1 X86.525 Y97.733 E.00525
G1 X86.903 Y97.843 E.00776
G1 X87.291 Y98.043 E.00858
G1 X87.473 Y98.173 E.0044
G1 X87.669 Y98.35 E.00519
G1 X87.843 Y98.549 E.0052
G1 X87.994 Y98.77 E.00526
G1 X88.164 Y99.124 E.00774
G1 X88.27 Y99.506 E.0078
G1 X88.305 Y99.898 E.00773
G1 X88.289 Y100.164 E.00525
G1 X88.251 Y100.384 E.0044
G1 X88.115 Y100.799 E.00858
G1 X87.921 Y101.146 E.00782
G1 X87.669 Y101.452 E.0078
G1 X87.366 Y101.71 E.00783
G1 X86.985 Y101.923 E.00858
G1 X86.777 Y102.003 E.0044
G1 X86.519 Y102.07 E.00525
G1 X86.127 Y102.111 E.00774
G1 X85.732 Y102.082 E.0078
G1 X85.352 Y101.983 E.00773
G1 X85.106 Y101.878 E.00526
G1 X84.874 Y101.744 E.00526
G1 X84.567 Y101.499 E.00773
G1 X84.306 Y101.2 E.0078
G1 X84.102 Y100.86 E.0078
G1 X83.964 Y100.492 E.00773
G1 X83.909 Y100.23 E.00526
G1 X83.885 Y99.964 E.00526
G1 X83.887 Y99.926 E.00075
; WIPE_START
M204 S6000
G1 X83.908 Y99.57 E-.06774
G1 X84.017 Y99.148 E-.08289
G1 X84.103 Y98.941 E-.04247
G1 X84.233 Y98.708 E-.0507
G1 X84.474 Y98.397 E-.07472
G1 X84.714 Y98.181 E-.06148
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X84.855 Y96.12 Z4.32 F18000
G1 Z3.92
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X92.665 Y96.12 E.1653
G1 X92.74 Y95.336 E.01667
G1 X92.784 Y95.227 E.00248
G1 X92.851 Y95.128 E.00253
G1 X92.939 Y95.044 E.00258
G1 X93.072 Y94.968 E.00324
G1 X93.272 Y94.922 E.00435
G1 X93.368 Y94.929 E.00204
G1 X93.538 Y94.98 E.00375
G1 X93.977 Y95.256 E.01097
G1 X95.879 Y94.633 E.04237
G1 X98.51 Y90.875 E.09709
G1 X98.806 Y91.083 E.00765
G1 X96.105 Y94.94 E.09967
G1 X93.244 Y96.216 E.06631
G1 X93.021 Y96.37 E.00573
G1 X92.803 Y96.453 E.00495
G1 X92.559 Y96.482 E.0052
G1 X87.591 Y96.482 E.10514
G1 X88.777 Y97.845 E.03825
G1 X88.884 Y97.992 E.00386
G1 X89.097 Y98.349 E.00878
G1 X89.322 Y98.9 E.0126
G1 X89.45 Y99.489 E.01277
G1 X89.469 Y100.086 E.01264
G1 X89.406 Y100.566 E.01024
G1 X89.268 Y101.066 E.01097
G1 X89.009 Y101.612 E.01279
G1 X88.665 Y102.096 E.01258
G1 X88.379 Y102.391 E.00869
G1 X88.061 Y102.65 E.00869
G1 X87.738 Y102.855 E.0081
G1 X87.188 Y103.099 E.01274
G1 X86.792 Y103.208 E.00869
G1 X86.386 Y103.269 E.00868
G1 X85.794 Y103.267 E.01254
G1 X85.214 Y103.164 E.01245
G1 X84.75 Y103 E.01043
G1 X84.294 Y102.762 E.01088
G1 X83.961 Y102.522 E.00869
G1 X83.666 Y102.251 E.00849
G1 X83.404 Y101.947 E.00849
G1 X83.181 Y101.613 E.00849
G1 X82.998 Y101.256 E.00849
G1 X82.86 Y100.879 E.00849
G1 X82.767 Y100.493 E.00841
G1 X82.718 Y100.012 E.01023
G1 X82.738 Y99.499 E.01088
G1 X82.814 Y99.086 E.00888
G1 X83.007 Y98.526 E.01253
G1 X83.192 Y98.17 E.0085
G1 X83.417 Y97.838 E.00849
G1 X84.597 Y96.482 E.03805
G1 X79.63 Y96.482 E.10513
G1 X79.392 Y96.454 E.00508
G1 X79.119 Y96.34 E.00626
G1 X78.992 Y96.24 E.00344
G1 X78.884 Y96.119 E.00343
G1 X78.744 Y95.821 E.00696
G1 X78.714 Y95.565 E.00546
G1 X78.714 Y77.619 E.37984
G1 X78.755 Y77.34 E.00597
G1 X78.865 Y77.11 E.00539
G1 X79.03 Y76.928 E.0052
G1 X79.155 Y76.84 E.00324
G1 X79.299 Y76.773 E.00335
G1 X79.55 Y76.723 E.00543
G1 X92.619 Y76.722 E.27661
G1 X92.742 Y76.735 E.00263
G1 X92.895 Y76.775 E.00335
G1 X93.124 Y76.904 E.00557
G1 X93.068 Y77.082 E.00395
G1 X80.04 Y77.082 E.27574
G1 X79.752 Y77.133 E.0062
G1 X79.474 Y77.282 E.00669
G1 X79.241 Y77.529 E.00717
G1 X79.112 Y77.807 E.00649
G1 X79.075 Y78.056 E.00533
G1 X79.075 Y95.146 E.36173
G1 X79.11 Y95.386 E.00514
G1 X79.223 Y95.646 E.006
G1 X79.506 Y95.946 E.00873
G1 X79.8 Y96.084 E.00688
G1 X80.049 Y96.12 E.00533
G1 X84.795 Y96.12 E.10045
; WIPE_START
M204 S6000
G1 X86.795 Y96.12 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X83.699 Y96.891 Z4.32 F18000
G1 Z3.92
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X79.607 Y96.891 E.08049
G1 X79.297 Y96.855 E.00613
G1 X79.01 Y96.75 E.00601
G1 X78.888 Y96.68 E.00277
G1 X78.71 Y96.539 E.00448
G1 X78.558 Y96.368 E.00448
G1 X78.479 Y96.248 E.00283
G1 X78.382 Y96.039 E.00454
G1 X78.341 Y95.904 E.00277
G1 X78.304 Y95.589 E.00625
G1 X78.304 Y77.607 E.35368
G1 X78.313 Y77.454 E.00301
G1 X78.36 Y77.228 E.00454
G1 X78.409 Y77.093 E.00283
G1 X78.519 Y76.89 E.00454
G1 X78.605 Y76.774 E.00283
G1 X78.766 Y76.613 E.00448
G1 X78.95 Y76.484 E.00442
G1 X79.155 Y76.389 E.00445
G1 X79.322 Y76.341 E.00342
G1 X79.522 Y76.313 E.00396
G1 X92.64 Y76.313 E.25802
G1 X92.817 Y76.331 E.0035
G1 X93.035 Y76.389 E.00445
G1 X93.239 Y76.484 E.00443
G1 X93.423 Y76.613 E.00442
G1 X93.582 Y76.772 E.00442
G1 X93.711 Y76.956 E.00442
G1 X93.806 Y77.16 E.00442
G1 X93.864 Y77.377 E.00442
G1 X93.884 Y77.61 E.0046
G1 X93.884 Y85.511 E.1554
G1 X96.181 Y85.511 E.04518
G1 X96.494 Y85.198 E.00871
G1 X96.884 Y85.588 E.01085
G1 X96.884 Y87.614 E.03985
G1 X96.494 Y88.004 E.01085
G1 X96.181 Y87.691 E.00871
G1 X93.884 Y87.691 E.04518
G1 X93.884 Y88.791 E.02164
G1 X92.704 Y88.791 E.02321
G1 X92.704 Y77.491 E.22226
G1 X80.076 Y77.491 E.24839
G1 X79.888 Y77.524 E.00376
G1 X79.726 Y77.611 E.00361
G1 X79.584 Y77.762 E.00407
G1 X79.508 Y77.925 E.00355
G1 X79.484 Y78.086 E.00319
G1 X79.484 Y95.116 E.33498
G1 X79.507 Y95.273 E.00313
G1 X79.57 Y95.418 E.0031
G1 X79.749 Y95.608 E.00515
G1 X79.919 Y95.687 E.00368
G1 X80.079 Y95.711 E.00319
G1 X92.288 Y95.711 E.24014
G1 X92.318 Y95.345 E.00722
G1 X92.348 Y95.212 E.00268
G1 X92.416 Y95.044 E.00356
G1 X92.545 Y94.855 E.0045
M73 P75 R6
G1 X92.676 Y94.728 E.00359
G1 X92.925 Y94.584 E.00565
G1 X93.161 Y94.521 E.00481
G1 X93.443 Y94.523 E.00554
G1 X93.709 Y94.605 E.00548
G1 X94.032 Y94.807 E.00749
G1 X95.622 Y94.286 E.03291
G1 X98.41 Y90.305 E.09559
G1 X99.376 Y90.982 E.02321
G1 X96.375 Y95.268 E.10291
G1 X93.445 Y96.575 E.0631
G1 X93.229 Y96.723 E.00516
G1 X93.102 Y96.786 E.00279
G1 X92.891 Y96.855 E.00437
G1 X92.582 Y96.891 E.00611
G1 X88.49 Y96.891 E.08049
G1 X89.098 Y97.59 E.01823
G1 X89.226 Y97.767 E.0043
G1 X89.459 Y98.158 E.00894
G1 X89.586 Y98.432 E.00595
G1 X89.714 Y98.78 E.00728
G1 X89.823 Y99.22 E.00892
G1 X89.877 Y99.661 E.00873
G1 X89.878 Y100.112 E.00888
G1 X89.809 Y100.641 E.0105
G1 X89.721 Y101.001 E.00727
G1 X89.532 Y101.492 E.01036
G1 X89.362 Y101.82 E.00728
G1 X89.109 Y102.197 E.00892
G1 X88.972 Y102.368 E.00431
G1 X88.657 Y102.693 E.00891
G1 X88.305 Y102.979 E.00891
G1 X88.121 Y103.103 E.00437
G1 X87.93 Y103.216 E.00436
G1 X87.519 Y103.413 E.00898
G1 X87.313 Y103.489 E.00431
G1 X86.877 Y103.609 E.00891
G1 X86.429 Y103.676 E.00891
G1 X86.21 Y103.689 E.00431
G1 X85.757 Y103.676 E.00891
G1 X85.309 Y103.608 E.00891
G1 X85.098 Y103.557 E.00428
G1 X84.592 Y103.378 E.01056
G1 X84.259 Y103.217 E.00727
G1 X84.07 Y103.105 E.00432
G1 X83.703 Y102.84 E.00891
G1 X83.371 Y102.536 E.00885
G1 X83.078 Y102.195 E.00885
G1 X82.827 Y101.821 E.00885
G1 X82.623 Y101.42 E.00885
G1 X82.467 Y100.998 E.00885
G1 X82.363 Y100.562 E.00882
G1 X82.309 Y100.031 E.01049
G1 X82.312 Y99.661 E.00727
G1 X82.332 Y99.443 E.00432
G1 X82.415 Y98.994 E.00897
G1 X82.473 Y98.783 E.0043
G1 X82.633 Y98.359 E.00891
G1 X82.84 Y97.96 E.00885
G1 X83.093 Y97.588 E.00885
G1 X83.66 Y96.936 E.01698
; WIPE_START
M204 S6000
G1 X81.66 Y96.914 E-.38
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




G1 X79.578 Y96.239
G1 Z3.92
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.106865
G1 F1500
M204 S6000
G1 X79.342 Y96.156 E.00101
; LINE_WIDTH: 0.162547
G1 X79.19 Y96.03 E.00135
G1 X79.082 Y95.908 E.00111
; LINE_WIDTH: 0.142929
G1 X79.008 Y95.797 E.00078
; LINE_WIDTH: 0.0977454
G1 X78.958 Y95.626 E.00064
; WIPE_START
G1 X79.008 Y95.797 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X84.642 Y97.165 Z4.32 F18000
G1 Z3.92
G1 E.4 F1800
; LINE_WIDTH: 0.477097
G1 F1500
M204 S6000
G1 X84.461 Y97.319 E.00533
; LINE_WIDTH: 0.43839
G1 X84.254 Y97.496 E.00562
; LINE_WIDTH: 0.400607
G1 X84.08 Y97.673 E.00464
; LINE_WIDTH: 0.36022
G1 X83.722 Y98.073 E.00895
G1 X83.569 Y98.285 E.00436
G1 X83.399 Y98.589 E.00581
G1 X83.23 Y99.024 E.00779
G1 X83.134 Y99.433 E.007
G1 X83.096 Y99.963 E.00888
G1 X83.132 Y100.357 E.0066
G1 X83.211 Y100.725 E.00627
G1 X83.349 Y101.103 E.00671
G1 X83.512 Y101.418 E.00594
G1 X83.708 Y101.716 E.00594
G1 X84.033 Y102.078 E.00813
G1 X84.442 Y102.398 E.00867
G1 X84.639 Y102.522 E.00387
G1 X84.897 Y102.648 E.0048
G1 X85.319 Y102.794 E.00745
G1 X85.618 Y102.858 E.0051
G1 X86.125 Y102.896 E.00848
G1 X86.647 Y102.848 E.00875
G1 X87.027 Y102.751 E.00654
G1 X87.329 Y102.628 E.00545
G1 X87.803 Y102.367 E.00902
G1 X88.118 Y102.11 E.00679
G1 X88.474 Y101.722 E.00878
G1 X88.679 Y101.416 E.00615
G1 X88.843 Y101.1 E.00594
G1 X89.012 Y100.587 E.00902
G1 X89.07 Y100.246 E.00577
G1 X89.092 Y99.874 E.00622
G1 X89.048 Y99.371 E.00841
G1 X88.904 Y98.862 E.00884
G1 X88.756 Y98.527 E.00611
G1 X88.476 Y98.077 E.00883
G1 X88.225 Y97.788 E.0064
; LINE_WIDTH: 0.382975
G1 X87.973 Y97.533 E.00638
; LINE_WIDTH: 0.423837
G1 X87.86 Y97.43 E.00303
; LINE_WIDTH: 0.477706
G1 X87.535 Y97.16 E.00953
; WIPE_START
G1 X87.86 Y97.43 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X94.036 Y95.543 Z4.32 F18000
G1 Z3.92
G1 E.4 F1800
; LINE_WIDTH: 0.151626
G1 F1500
M204 S6000
G1 X94.526 Y95.354 E.0033
; LINE_WIDTH: 0.103707
G1 X95.017 Y95.165 E.00204
; WIPE_START
G1 X94.526 Y95.354 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X95.658 Y87.806 Z4.32 F18000
G1 X95.839 Y86.601 Z4.32
G1 Z3.92
G1 E.4 F1800
; LINE_WIDTH: 0.114562
G1 F1500
M204 S6000
G1 X93.75 Y86.601 E.00925
; WIPE_START
G1 X95.75 Y86.601 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X89.196 Y82.689 Z4.32 F18000
G1 X79.59 Y76.954 Z4.32
G1 Z3.92
G1 E.4 F1800
; LINE_WIDTH: 0.0986971
G1 F1500
M204 S6000
G1 X79.462 Y76.995 E.00049
; LINE_WIDTH: 0.129651
G1 X79.291 Y77.079 E.00099
; LINE_WIDTH: 0.15735
G1 X79.102 Y77.266 E.00174
G1 X79.019 Y77.388 E.00097
; LINE_WIDTH: 0.0995562
G1 X78.949 Y77.601 E.00083
; WIPE_START
G1 X79.019 Y77.388 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X85.917 Y80.655 Z4.32 F18000
G1 X100.371 Y87.504 Z4.32
G1 Z3.92
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X100.647 Y87.111 E.00944
G1 X101.318 Y87.58 E.01612
G1 X101.613 Y87.787 E.00709
G1 X101.338 Y88.181 E.00944
G1 X100.42 Y87.538 E.02203
M204 S10000
G1 X100.676 Y87.425 F18000
; FEATURE: Gap infill
; LINE_WIDTH: 0.0965137
G1 F1500
M204 S6000
G1 X101.308 Y87.867 E.00272
; CHANGE_LAYER
; Z_HEIGHT: 4.02
; LAYER_HEIGHT: 0.0999999
; WIPE_START
G1 F1500
G1 X100.676 Y87.425 E-.38
; WIPE_END
G1 E-.02 F1800
; layer num/total_layer_count: 40/57
; update layer progress
M73 L40
M991 S0 P39 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z4.32 I-1.216 J.034 P1  F18000
G1 X100.731 Y89.379 Z4.32
G1 Z4.02
G1 E.4 F1800
; FEATURE: Support interface
; LINE_WIDTH: 0.42
; LAYER_HEIGHT: 0.26
G1 F1267.254
M204 S6000
G1 X100.731 Y88.741 E.02514
G1 X99.898 Y88.157 E.04005
G1 X99.837 Y88.244 E.00419
G1 X99.837 Y90.319 E.08169
G1 X98.942 Y89.693 E.04298
G1 X98.942 Y89.212 E.01893
; WIPE_START
G1 X98.942 Y89.693 E-.09138
G1 X99.837 Y90.319 E-.20742
G1 X99.837 Y89.892 E-.08121
; WIPE_END
G1 E-.02 F1800
M204 S10000
G17
G3 Z4.42 I1.217 J0 P1  F18000
;===================== date: 20250206 =====================

; don't support timelapse gcode in spiral_mode and by object sequence for I3 structure printer
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firmware, default turned on
M1002 judge_flag timelapse_record_flag
M622 J1
G92 E0
G1 Z4.42
G1 X0 Y90 ; move to safe pos
G1 X-13.0 F3000 ; move to safe pos
M400
M1004 S5 P1  ; external shutter
M400 P300
M971 S11 C11 O0
G92 E0
G1 X0 F18000
M623

; SKIPTYPE: head_wrap_detect
M622.1 S1
M1002 judge_flag g39_3rd_layer_detect_flag
M622 J1
    ; enable nozzle clog detect at 3rd layer
    


    M622.1 S1
    M1002 judge_flag g39_detection_flag
    M622 J1
      
        M622.1 S0
        M1002 judge_flag g39_mass_exceed_flag
        M622 J1
        
            G392 S0
            M400
            G90
            M83
            M204 S5000
            G0 Z4.42 F4000
            G39.3 S1
            G0 Z4.42 F4000
            G392 S0
          
        M623
    
    M623
M623
; SKIPPABLE_END




; CHANGE_LAYER
; Z_HEIGHT: 4.04
; LAYER_HEIGHT: 0.02
; layer num/total_layer_count: 41/57
; update layer progress
M73 L41
M991 S0 P40 ;notify layer change
; OBJECT_ID: 8
G1 X96.051 Y86.344
G1 Z4.04
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
; LAYER_HEIGHT: 0.12
G1 F1500
M204 S500
G1 X96.051 Y86.857 E.01086
G1 X93.538 Y86.857 E.05319
G1 X93.538 Y86.344 E.01086
G1 X95.991 Y86.344 E.05192
M204 S10000
G1 X96.475 Y85.92 F18000
G1 F1500
M204 S500
G1 X96.475 Y87.282 E.02882
G1 X93.475 Y87.282 E.0635
G1 X93.475 Y88.382 E.02328
G1 X93.114 Y88.382 E.00765
G1 X93.114 Y77.127 E.23821
G1 X93.292 Y77.071 E.00395
G1 X93.355 Y77.162 E.00234
G1 X93.42 Y77.3 E.00324
G1 X93.459 Y77.448 E.00324
G1 X93.475 Y77.628 E.00382
G1 X93.475 Y85.92 E.17551
G1 X96.415 Y85.92 E.06223
; WIPE_START
M204 S6000
G1 X96.475 Y87.282 E-.25894
G1 X95.838 Y87.282 E-.12106
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X93.896 Y94.663 Z4.44 F18000
G1 X93.658 Y95.567 Z4.44
G1 Z4.04
G1 E.4 F1800
G1 F1500
M204 S500
G1 X93.122 Y95.806 E.01243
G1 X93.14 Y95.498 E.00654
G1 X93.161 Y95.423 E.00165
G1 X93.202 Y95.372 E.00138
G1 X93.295 Y95.347 E.00204
G1 X93.369 Y95.368 E.00162
G1 X93.609 Y95.533 E.00615
; WIPE_START
M204 S6000
G1 X93.122 Y95.806 E-.14396
G1 X93.14 Y95.498 E-.07961
G1 X93.161 Y95.423 E-.02006
G1 X93.202 Y95.372 E-.01681
G1 X93.295 Y95.347 E-.02489
G1 X93.369 Y95.368 E-.01976
G1 X93.609 Y95.533 E-.07491
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X86.097 Y96.886 Z4.44 F18000
G1 X84.873 Y97.106 Z4.44
G1 Z4.04
G1 E.4 F1800
G1 F1500
M204 S500
G1 X84.767 Y96.944 E.00411
G1 X85.118 Y96.544 E.01127
G1 X87.084 Y96.544 E.0416
G1 X87.433 Y96.946 E.01128
G1 X87.304 Y97.112 E.00445
G1 X87.214 Y97.066 E.00213
G1 X86.699 Y96.915 E.01136
G1 X86.325 Y96.864 E.00798
G1 X85.992 Y96.857 E.00706
G1 X85.422 Y96.928 E.01215
G1 X84.93 Y97.088 E.01095
; WIPE_START
M204 S6000
G1 X84.767 Y96.944 E-.04139
G1 X85.118 Y96.544 E-.10112
G1 X86.368 Y96.544 E-.23748
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X83.481 Y99.853 Z4.44 F18000
G1 Z4.04
G1 E.4 F1800
G1 F1500
M204 S500
G1 X83.502 Y99.51 E.00727
G1 X83.611 Y99.062 E.00975
G1 X83.734 Y98.764 E.00683
G1 X83.891 Y98.482 E.00683
G1 X84.172 Y98.118 E.00975
G1 X84.515 Y97.809 E.00975
G1 X84.784 Y97.632 E.00683
G1 X85.073 Y97.487 E.00683
G1 X85.514 Y97.344 E.00983
G1 X86.013 Y97.282 E.01064
G1 X86.292 Y97.288 E.0059
G1 X86.61 Y97.331 E.00679
G1 X87.056 Y97.461 E.00983
G1 X87.503 Y97.692 E.01064
G1 X87.73 Y97.853 E.0059
G1 X87.968 Y98.068 E.00679
G1 X88.255 Y98.417 E.00955
G1 X88.42 Y98.694 E.00683
G1 X88.551 Y98.989 E.00683
G1 X88.674 Y99.433 E.00975
G1 X88.715 Y99.892 E.00975
G1 X88.696 Y100.212 E.00679
G1 X88.648 Y100.486 E.0059
G1 X88.491 Y100.964 E.01064
G1 X88.261 Y101.378 E.01003
G1 X87.962 Y101.741 E.00995
G1 X87.601 Y102.047 E.01003
G1 X87.162 Y102.293 E.01063
M73 P76 R6
G1 X86.902 Y102.393 E.0059
G1 X86.592 Y102.474 E.00679
G1 X86.134 Y102.522 E.00975
G1 X85.661 Y102.487 E.01003
G1 X85.176 Y102.355 E.01064
G1 X84.921 Y102.244 E.0059
G1 X84.643 Y102.083 E.00679
G1 X84.283 Y101.796 E.00975
G1 X83.973 Y101.442 E.00995
G1 X83.737 Y101.046 E.00975
G1 X83.615 Y100.75 E.00679
G1 X83.54 Y100.481 E.0059
M73 P76 R5
G1 X83.474 Y99.983 E.01064
G1 X83.478 Y99.913 E.00149
M204 S250
G1 X83.89 Y99.877 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X83.908 Y99.571 E.00603
G1 X84.002 Y99.189 E.00774
G1 X84.103 Y98.942 E.00526
G1 X84.233 Y98.708 E.00526
G1 X84.474 Y98.397 E.00773
G1 X84.766 Y98.134 E.00774
G1 X84.989 Y97.987 E.00526
G1 X85.228 Y97.867 E.00526
G1 X85.604 Y97.745 E.00776
G1 X86.034 Y97.692 E.00854
G1 X86.26 Y97.697 E.00445
G1 X86.525 Y97.733 E.00525
G1 X86.903 Y97.843 E.00776
G1 X87.289 Y98.042 E.00853
G1 X87.473 Y98.173 E.00445
G1 X87.671 Y98.352 E.00525
G1 X87.919 Y98.653 E.00767
G1 X88.056 Y98.883 E.00526
G1 X88.165 Y99.127 E.00526
G1 X88.27 Y99.506 E.00773
G1 X88.305 Y99.898 E.00773
G1 X88.289 Y100.164 E.00525
G1 X88.25 Y100.387 E.00445
G1 X88.115 Y100.799 E.00853
G1 X87.921 Y101.146 E.00782
G1 X87.669 Y101.452 E.0078
G1 X87.366 Y101.71 E.00782
G1 X86.988 Y101.922 E.00853
G1 X86.777 Y102.003 E.00444
G1 X86.519 Y102.07 E.00525
G1 X86.127 Y102.111 E.00774
G1 X85.731 Y102.082 E.00782
G1 X85.312 Y101.968 E.00853
G1 X85.105 Y101.877 E.00445
G1 X84.874 Y101.744 E.00525
G1 X84.567 Y101.499 E.00773
G1 X84.306 Y101.2 E.0078
G1 X84.104 Y100.863 E.00773
G1 X84.003 Y100.616 E.00525
G1 X83.941 Y100.398 E.00445
G1 X83.884 Y99.968 E.00853
G1 X83.886 Y99.937 E.00062
; WIPE_START
M204 S6000
G1 X83.908 Y99.571 E-.06962
G1 X84.002 Y99.189 E-.07474
G1 X84.103 Y98.942 E-.05081
G1 X84.233 Y98.708 E-.05081
G1 X84.474 Y98.397 E-.07471
G1 X84.706 Y98.188 E-.05932
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X84.87 Y96.12 Z4.44 F18000
G1 Z4.04
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X92.678 Y96.12 E.16527
G1 X92.718 Y95.441 E.0144
G1 X92.742 Y95.329 E.00243
G1 X92.813 Y95.179 E.00352
G1 X92.875 Y95.103 E.00206
G1 X93.067 Y94.969 E.00494
G1 X93.272 Y94.922 E.00446
G1 X93.375 Y94.929 E.00218
G1 X93.534 Y94.974 E.00349
G1 X93.961 Y95.261 E.0109
G1 X95.879 Y94.633 E.04271
G1 X98.51 Y90.875 E.09709
G1 X98.806 Y91.083 E.00765
G1 X96.105 Y94.94 E.09967
G1 X93.242 Y96.217 E.06635
G1 X93.041 Y96.358 E.0052
G1 X92.803 Y96.453 E.00543
G1 X92.559 Y96.482 E.0052
G1 X87.591 Y96.482 E.10514
G1 X88.774 Y97.841 E.03814
G1 X89.099 Y98.351 E.01279
G1 X89.326 Y98.91 E.01277
G1 X89.451 Y99.499 E.01274
G1 X89.469 Y100.087 E.01245
G1 X89.407 Y100.562 E.01014
G1 X89.268 Y101.066 E.01107
G1 X89.163 Y101.314 E.0057
G1 X89.007 Y101.616 E.00719
G1 X88.66 Y102.101 E.01263
G1 X88.379 Y102.391 E.00853
G1 X88.061 Y102.65 E.00869
G1 X87.737 Y102.855 E.0081
G1 X87.188 Y103.099 E.01273
G1 X86.792 Y103.208 E.00869
G1 X86.386 Y103.269 E.00869
G1 X85.794 Y103.267 E.01254
G1 X85.21 Y103.163 E.01254
G1 X84.813 Y103.029 E.00888
G1 X84.351 Y102.794 E.01097
G1 X83.958 Y102.52 E.01014
G1 X83.666 Y102.251 E.00841
G1 X83.404 Y101.947 E.00849
G1 X83.181 Y101.613 E.00849
G1 X83 Y101.26 E.00841
G1 X82.84 Y100.808 E.01014
G1 X82.738 Y100.3 E.01097
G1 X82.715 Y99.89 E.00869
G1 X82.74 Y99.49 E.00849
G1 X82.812 Y99.095 E.0085
G1 X82.931 Y98.712 E.00849
G1 X83.094 Y98.345 E.00849
G1 X83.302 Y97.997 E.00859
G1 X83.458 Y97.788 E.00551
G1 X84.608 Y96.482 E.03684
G1 X79.631 Y96.482 E.10536
G1 X79.3 Y96.43 E.00708
G1 X79.066 Y96.304 E.00562
G1 X78.898 Y96.137 E.00501
G1 X78.831 Y96.037 E.00255
G1 X78.743 Y95.812 E.00512
G1 X78.714 Y95.565 E.00527
G1 X78.714 Y77.619 E.37984
G1 X78.753 Y77.349 E.00577
G1 X78.855 Y77.125 E.0052
G1 X79.022 Y76.933 E.00539
G1 X79.259 Y76.789 E.00588
G1 X79.39 Y76.746 E.00289
G1 X79.552 Y76.723 E.00348
G1 X92.62 Y76.722 E.27659
G1 X92.742 Y76.734 E.00259
G1 X92.895 Y76.775 E.00335
G1 X93.124 Y76.904 E.00556
G1 X93.068 Y77.082 E.00395
G1 X80.043 Y77.082 E.27569
G1 X79.765 Y77.128 E.00597
G1 X79.476 Y77.28 E.0069
G1 X79.241 Y77.529 E.00724
G1 X79.112 Y77.807 E.0065
G1 X79.075 Y78.056 E.00533
G1 X79.075 Y95.173 E.3623
G1 X79.16 Y95.533 E.00782
G1 X79.325 Y95.777 E.00623
G1 X79.533 Y95.959 E.00586
G1 X79.8 Y96.084 E.00624
G1 X80.049 Y96.12 E.00533
G1 X84.81 Y96.12 E.10076
; WIPE_START
M204 S6000
G1 X86.81 Y96.12 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X83.703 Y96.891 Z4.44 F18000
G1 Z4.04
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X79.607 Y96.891 E.08056
G1 X79.291 Y96.854 E.00625
G1 X78.971 Y96.729 E.00676
G1 X78.711 Y96.54 E.00631
G1 X78.575 Y96.39 E.00399
G1 X78.477 Y96.245 E.00345
G1 X78.412 Y96.114 E.00286
G1 X78.341 Y95.901 E.00442
G1 X78.304 Y95.589 E.00619
G1 X78.304 Y77.607 E.35368
G1 X78.313 Y77.454 E.00301
G1 X78.359 Y77.231 E.00448
G1 X78.443 Y77.019 E.00448
G1 X78.515 Y76.895 E.00283
G1 X78.659 Y76.714 E.00454
G1 X78.763 Y76.615 E.00283
G1 X78.951 Y76.483 E.00452
G1 X79.106 Y76.408 E.00339
G1 X79.296 Y76.347 E.00393
G1 X79.522 Y76.313 E.00449
G1 X92.641 Y76.313 E.25804
G1 X92.817 Y76.331 E.00347
G1 X93.035 Y76.389 E.00446
G1 X93.239 Y76.484 E.00442
G1 X93.423 Y76.613 E.00442
G1 X93.582 Y76.772 E.00442
G1 X93.711 Y76.956 E.00442
G1 X93.806 Y77.16 E.00442
G1 X93.864 Y77.377 E.00442
G1 X93.884 Y77.61 E.0046
G1 X93.884 Y85.511 E.1554
G1 X96.181 Y85.511 E.04518
G1 X96.494 Y85.198 E.00871
G1 X96.884 Y85.588 E.01085
G1 X96.884 Y87.614 E.03985
G1 X96.494 Y88.004 E.01085
G1 X96.181 Y87.691 E.00871
G1 X93.884 Y87.691 E.04518
G1 X93.884 Y88.791 E.02164
G1 X92.704 Y88.791 E.02321
G1 X92.704 Y77.491 E.22226
G1 X80.077 Y77.491 E.24837
G1 X79.897 Y77.521 E.00359
G1 X79.727 Y77.61 E.00378
G1 X79.584 Y77.762 E.00409
G1 X79.508 Y77.925 E.00356
G1 X79.484 Y78.086 E.00318
G1 X79.484 Y95.125 E.33516
G1 X79.541 Y95.366 E.00486
G1 X79.634 Y95.504 E.00327
G1 X79.759 Y95.613 E.00325
G1 X79.919 Y95.687 E.00347
G1 X80.079 Y95.711 E.00319
G1 X92.292 Y95.711 E.24022
G1 X92.312 Y95.386 E.00639
G1 X92.349 Y95.21 E.00355
G1 X92.407 Y95.064 E.00309
G1 X92.475 Y94.947 E.00267
G1 X92.673 Y94.731 E.00577
G1 X92.923 Y94.584 E.00569
G1 X93.161 Y94.521 E.00484
G1 X93.445 Y94.523 E.00559
G1 X93.68 Y94.59 E.00481
G1 X93.777 Y94.637 E.00213
G1 X94.027 Y94.809 E.00595
G1 X95.622 Y94.286 E.03302
G1 X98.41 Y90.305 E.09559
G1 X99.376 Y90.982 E.02321
G1 X96.375 Y95.268 E.10291
G1 X93.445 Y96.575 E.06312
G1 X93.252 Y96.709 E.00462
G1 X93.101 Y96.787 E.00335
G1 X92.891 Y96.855 E.00434
G1 X92.582 Y96.891 E.00611
G1 X88.49 Y96.891 E.08049
G1 X89.097 Y97.589 E.01819
G1 X89.268 Y97.833 E.00587
G1 X89.555 Y98.356 E.01174
G1 X89.716 Y98.783 E.00897
G1 X89.774 Y98.994 E.00431
G1 X89.856 Y99.443 E.00897
G1 X89.877 Y99.661 E.0043
G1 X89.878 Y100.112 E.00888
G1 X89.81 Y100.637 E.01041
G1 X89.721 Y101.001 E.00737
G1 X89.534 Y101.488 E.01026
G1 X89.361 Y101.822 E.0074
G1 X89.198 Y102.072 E.00588
G1 X88.97 Y102.369 E.00737
G1 X88.657 Y102.693 E.00886
G1 X88.305 Y102.979 E.00891
G1 X88.121 Y103.103 E.00436
G1 X87.93 Y103.216 E.00437
G1 X87.519 Y103.413 E.00897
G1 X87.314 Y103.489 E.0043
G1 X86.877 Y103.609 E.00891
G1 X86.429 Y103.676 E.00891
G1 X86.21 Y103.689 E.00431
G1 X85.757 Y103.676 E.00891
G1 X85.309 Y103.608 E.00891
G1 X85.096 Y103.557 E.00431
G1 X84.664 Y103.411 E.00897
G1 X84.135 Y103.143 E.01167
G1 X83.702 Y102.839 E.0104
G1 X83.371 Y102.536 E.00882
G1 X83.078 Y102.195 E.00885
G1 X82.827 Y101.821 E.00885
G1 X82.623 Y101.422 E.00882
G1 X82.447 Y100.923 E.01041
G1 X82.362 Y100.558 E.00737
G1 X82.33 Y100.341 E.00431
G1 X82.305 Y99.889 E.00891
G1 X82.333 Y99.44 E.00885
G1 X82.414 Y98.997 E.00885
G1 X82.547 Y98.567 E.00885
G1 X82.73 Y98.156 E.00885
G1 X82.962 Y97.768 E.00888
G1 X83.14 Y97.53 E.00586
G1 X83.663 Y96.936 E.01556
; WIPE_START
M204 S6000
G1 X81.663 Y96.914 E-.38
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




G1 X79.578 Y96.239
G1 Z4.04
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.10356
G1 F1500
M204 S6000
G1 X79.382 Y96.177 E.0008
; LINE_WIDTH: 0.156209
G1 X79.192 Y96.038 E.00154
G1 X79.119 Y95.966 E.00067
G1 X79.045 Y95.853 E.00088
; LINE_WIDTH: 0.131423
G1 X79.001 Y95.751 E.00058
; LINE_WIDTH: 0.09507
G1 X78.958 Y95.649 E.00038
; WIPE_START
G1 X79.001 Y95.751 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X84.654 Y97.159 Z4.44 F18000
G1 Z4.04
G1 E.4 F1800
; LINE_WIDTH: 0.476979
G1 F1500
M204 S6000
G1 X84.468 Y97.316 E.00548
; LINE_WIDTH: 0.436782
G1 X84.255 Y97.497 E.00573
; LINE_WIDTH: 0.399162
G1 X84.08 Y97.674 E.00463
; LINE_WIDTH: 0.36017
G1 X83.756 Y98.03 E.00804
G1 X83.582 Y98.264 E.00486
G1 X83.433 Y98.521 E.00496
G1 X83.256 Y98.934 E.0075
M73 P77 R5
G1 X83.132 Y99.439 E.00868
G1 X83.097 Y99.891 E.00756
G1 X83.121 Y100.256 E.00611
G1 X83.207 Y100.703 E.00759
G1 X83.351 Y101.109 E.00718
G1 X83.512 Y101.418 E.00583
G1 X83.708 Y101.716 E.00594
G1 X84.033 Y102.078 E.00812
G1 X84.441 Y102.4 E.00867
G1 X84.808 Y102.61 E.00705
G1 X85.315 Y102.792 E.00898
G1 X85.613 Y102.857 E.00509
G1 X86.125 Y102.896 E.00856
G1 X86.647 Y102.848 E.00875
G1 X87.027 Y102.751 E.00655
G1 X87.332 Y102.627 E.00549
G1 X87.803 Y102.367 E.00898
G1 X88.12 Y102.109 E.00682
G1 X88.367 Y101.852 E.00594
G1 X88.577 Y101.576 E.00579
G1 X88.831 Y101.13 E.00857
G1 X89.012 Y100.59 E.0095
G1 X89.07 Y100.246 E.00581
G1 X89.092 Y99.874 E.00623
G1 X89.039 Y99.352 E.00875
G1 X88.961 Y99.031 E.0055
G1 X88.762 Y98.528 E.00903
G1 X88.554 Y98.191 E.00661
G1 X88.233 Y97.797 E.00848
; LINE_WIDTH: 0.382232
G1 X87.973 Y97.533 E.0066
; LINE_WIDTH: 0.424073
G1 X87.859 Y97.429 E.00306
; LINE_WIDTH: 0.478012
G1 X87.535 Y97.16 E.0095
; WIPE_START
G1 X87.859 Y97.429 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X94.012 Y95.553 Z4.44 F18000
G1 Z4.04
G1 E.4 F1800
; LINE_WIDTH: 0.153729
G1 F1500
M204 S6000
G1 X94.514 Y95.359 E.00344
; LINE_WIDTH: 0.104408
G1 X95.017 Y95.165 E.00211
; WIPE_START
G1 X94.514 Y95.359 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X95.656 Y87.812 Z4.44 F18000
G1 X95.839 Y86.601 Z4.44
G1 Z4.04
G1 E.4 F1800
; LINE_WIDTH: 0.114562
G1 F1500
M204 S6000
G1 X93.75 Y86.601 E.00925
; WIPE_START
G1 X95.75 Y86.601 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X89.197 Y82.688 Z4.44 F18000
G1 X79.592 Y76.954 Z4.44
G1 Z4.04
G1 E.4 F1800
; LINE_WIDTH: 0.100349
G1 F1500
M204 S6000
G1 X79.45 Y77 E.00056
; LINE_WIDTH: 0.146636
G1 X79.304 Y77.069 E.00097
G1 X79.207 Y77.151 E.00077
G1 X79.059 Y77.322 E.00136
G1 X79.004 Y77.423 E.00069
; LINE_WIDTH: 0.0994855
G1 X78.949 Y77.602 E.00069
; WIPE_START
G1 X79.004 Y77.423 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X85.906 Y80.679 Z4.44 F18000
G1 X100.371 Y87.504 Z4.44
G1 Z4.04
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X100.647 Y87.111 E.00944
G1 X101.344 Y87.599 E.01674
G1 X101.613 Y87.787 E.00646
G1 X101.338 Y88.181 E.00944
G1 X100.42 Y87.538 E.02203
M204 S10000
G1 X100.676 Y87.425 F18000
; FEATURE: Gap infill
; LINE_WIDTH: 0.0965081
G1 F1500
M204 S6000
G1 X101.308 Y87.867 E.00272
; CHANGE_LAYER
; Z_HEIGHT: 4.16
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F1500
G1 X100.676 Y87.425 E-.38
; WIPE_END
G1 E-.02 F1800
; layer num/total_layer_count: 42/57
; update layer progress
M73 L42
M991 S0 P41 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z4.44 I.277 J-1.185 P1  F18000
G1 X96.051 Y86.344 Z4.44
G1 Z4.16
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X96.051 Y86.857 E.01086
G1 X93.538 Y86.857 E.05319
G1 X93.538 Y86.344 E.01086
G1 X95.991 Y86.344 E.05192
M204 S10000
G1 X96.475 Y85.92 F18000
G1 F1500
M204 S500
G1 X96.475 Y87.282 E.02882
G1 X93.475 Y87.282 E.0635
G1 X93.475 Y88.382 E.02328
G1 X93.114 Y88.382 E.00765
G1 X93.114 Y77.127 E.23821
G1 X93.292 Y77.071 E.00395
G1 X93.355 Y77.162 E.00234
G1 X93.42 Y77.3 E.00324
G1 X93.459 Y77.448 E.00324
G1 X93.475 Y77.628 E.00382
G1 X93.475 Y85.92 E.17551
G1 X96.415 Y85.92 E.06223
; WIPE_START
M204 S6000
G1 X96.475 Y87.282 E-.25894
G1 X95.838 Y87.282 E-.12106
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X93.901 Y94.664 Z4.56 F18000
G1 X93.665 Y95.564 Z4.56
G1 Z4.16
G1 E.4 F1800
G1 F1500
M204 S500
G1 X93.116 Y95.809 E.01273
G1 X93.144 Y95.466 E.00729
G1 X93.204 Y95.372 E.00235
G1 X93.32 Y95.341 E.00253
G1 X93.615 Y95.531 E.00743
; WIPE_START
M204 S6000
G1 X93.116 Y95.809 E-.14489
G1 X93.144 Y95.466 E-.08739
G1 X93.204 Y95.372 E-.02821
G1 X93.32 Y95.341 E-.03038
G1 X93.615 Y95.531 E-.08913
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X86.103 Y96.886 Z4.56 F18000
G1 X84.86 Y97.11 Z4.56
G1 Z4.16
G1 E.4 F1800
G1 F1500
M204 S500
G1 X84.753 Y96.949 E.0041
G1 X85.105 Y96.544 E.01135
G1 X87.084 Y96.544 E.04188
G1 X87.437 Y96.951 E.0114
G1 X87.314 Y97.115 E.00436
G1 X87.193 Y97.059 E.00282
G1 X86.699 Y96.915 E.01089
G1 X86.325 Y96.864 E.00798
G1 X85.989 Y96.858 E.00711
G1 X85.422 Y96.928 E.01209
G1 X84.917 Y97.092 E.01124
; WIPE_START
M204 S6000
G1 X84.753 Y96.949 E-.04131
G1 X85.105 Y96.544 E-.10188
G1 X86.351 Y96.544 E-.23681
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X83.481 Y99.865 Z4.56 F18000
G1 Z4.16
G1 E.4 F1800
G1 F1500
M204 S500
G1 X83.502 Y99.51 E.00752
G1 X83.614 Y99.05 E.01002
G1 X83.823 Y98.596 E.01059
G1 X83.976 Y98.359 E.00596
G1 X84.174 Y98.119 E.0066
G1 X84.4 Y97.902 E.00663
G1 X84.658 Y97.708 E.00683
G1 X85.064 Y97.49 E.00975
G1 X85.514 Y97.344 E.01002
G1 X86.011 Y97.282 E.01059
G1 X86.292 Y97.288 E.00595
G1 X86.61 Y97.331 E.0068
G1 X87.043 Y97.458 E.00955
G1 X87.336 Y97.593 E.00683
G1 X87.611 Y97.763 E.00683
G1 X87.962 Y98.061 E.00975
G1 X88.261 Y98.424 E.00995
G1 X88.489 Y98.835 E.00995
G1 X88.638 Y99.27 E.00975
G1 X88.696 Y99.588 E.00683
G1 X88.715 Y99.901 E.00663
G1 X88.696 Y100.214 E.00663
G1 X88.638 Y100.531 E.00683
G1 X88.49 Y100.967 E.00975
G1 X88.261 Y101.378 E.00995
G1 X87.962 Y101.741 E.00995
G1 X87.601 Y102.047 E.01002
G1 X87.165 Y102.292 E.01059
G1 X86.902 Y102.393 E.00595
G1 X86.592 Y102.474 E.00679
G1 X86.13 Y102.523 E.00983
G1 X85.632 Y102.48 E.01058
G1 X85.358 Y102.415 E.00595
G1 X85.056 Y102.307 E.00679
G1 X84.65 Y102.089 E.00975
G1 X84.283 Y101.796 E.00995
G1 X83.973 Y101.442 E.00995
G1 X83.732 Y101.039 E.00994
G1 X83.57 Y100.607 E.00975
G1 X83.503 Y100.291 E.00683
G1 X83.474 Y99.97 E.00683
G1 X83.477 Y99.925 E.00096
M204 S250
G1 X83.889 Y99.889 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X83.908 Y99.571 E.00627
G1 X84.002 Y99.185 E.00782
G1 X84.182 Y98.793 E.00849
G1 X84.307 Y98.601 E.0045
G1 X84.474 Y98.397 E.00519
G1 X84.665 Y98.215 E.0052
G1 X84.879 Y98.054 E.00526
G1 X85.225 Y97.868 E.00773
G1 X85.604 Y97.745 E.00782
G1 X86.032 Y97.692 E.00849
G1 X86.26 Y97.697 E.00449
G1 X86.525 Y97.733 E.00525
G1 X86.899 Y97.842 E.00767
G1 X87.142 Y97.954 E.00526
G1 X87.369 Y98.095 E.00526
G1 X87.669 Y98.349 E.00773
G1 X87.921 Y98.656 E.0078
G1 X88.114 Y99.002 E.00779
G1 X88.241 Y99.374 E.00773
G1 X88.289 Y99.637 E.00526
G1 X88.305 Y99.901 E.0052
G1 X88.289 Y100.165 E.0052
G1 X88.241 Y100.428 E.00526
G1 X88.114 Y100.8 E.00773
G1 X87.921 Y101.146 E.00779
G1 X87.669 Y101.452 E.0078
G1 X87.366 Y101.71 E.00782
G1 X86.99 Y101.921 E.00849
G1 X86.777 Y102.003 E.00449
G1 X86.519 Y102.07 E.00525
G1 X86.126 Y102.112 E.00776
G1 X85.696 Y102.074 E.00848
G1 X85.474 Y102.022 E.00449
G1 X85.223 Y101.932 E.00525
G1 X84.877 Y101.746 E.00773
G1 X84.567 Y101.499 E.0078
G1 X84.306 Y101.2 E.00779
G1 X84.103 Y100.86 E.00779
G1 X83.964 Y100.492 E.00774
G1 X83.909 Y100.23 E.00526
G1 X83.885 Y99.964 E.00526
G1 X83.886 Y99.949 E.00029
; WIPE_START
M204 S6000
G1 X83.908 Y99.571 E-.07194
G1 X84.002 Y99.185 E-.07552
G1 X84.182 Y98.793 E-.08198
G1 X84.307 Y98.601 E-.04343
G1 X84.474 Y98.397 E-.05011
G1 X84.665 Y98.215 E-.05022
G1 X84.694 Y98.193 E-.00679
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X84.855 Y96.12 Z4.56 F18000
G1 Z4.16
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X92.664 Y96.12 E.16529
G1 X92.74 Y95.334 E.01671
G1 X92.812 Y95.181 E.00359
G1 X92.887 Y95.089 E.0025
G1 X93.062 Y94.971 E.00449
G1 X93.272 Y94.922 E.00455
G1 X93.443 Y94.941 E.00364
G1 X93.539 Y94.978 E.00218
G1 X93.972 Y95.257 E.01091
G1 X95.879 Y94.633 E.04247
G1 X98.51 Y90.875 E.09709
G1 X98.806 Y91.083 E.00765
G1 X96.105 Y94.94 E.09967
G1 X93.242 Y96.217 E.06635
G1 X93.04 Y96.359 E.00523
G1 X92.803 Y96.453 E.0054
G1 X92.559 Y96.482 E.0052
G1 X87.591 Y96.482 E.10514
G1 X88.777 Y97.845 E.03824
G1 X88.884 Y97.993 E.00386
G1 X89.099 Y98.353 E.00888
G1 X89.326 Y98.91 E.01273
G1 X89.451 Y99.499 E.01274
G1 X89.469 Y100.087 E.01245
G1 X89.408 Y100.557 E.01004
G1 X89.269 Y101.061 E.01107
G1 X89.015 Y101.602 E.01265
G1 X88.741 Y102.001 E.01024
G1 X88.519 Y102.257 E.00717
G1 X88.18 Y102.559 E.0096
G1 X87.903 Y102.756 E.00719
G1 X87.543 Y102.955 E.00872
G1 X87.188 Y103.099 E.0081
G1 X86.792 Y103.208 E.00869
G1 X86.386 Y103.269 E.00869
G1 X85.794 Y103.267 E.01254
G1 X85.202 Y103.161 E.01273
G1 X84.638 Y102.951 E.01273
G1 X84.287 Y102.757 E.00849
G1 X83.961 Y102.522 E.0085
G1 X83.666 Y102.251 E.00849
G1 X83.404 Y101.947 E.00849
G1 X83.181 Y101.613 E.0085
G1 X82.998 Y101.256 E.00849
G1 X82.86 Y100.879 E.00849
G1 X82.767 Y100.493 E.00842
G1 X82.718 Y100.021 E.01004
G1 X82.738 Y99.499 E.01106
G1 X82.812 Y99.095 E.00869
G1 X82.93 Y98.715 E.00841
G1 X83.128 Y98.284 E.01004
G1 X83.411 Y97.845 E.01106
G1 X84.597 Y96.482 E.03824
G1 X79.631 Y96.482 E.10513
G1 X79.302 Y96.43 E.00703
G1 X79.163 Y96.365 E.00324
G1 X78.984 Y96.232 E.00474
G1 X78.831 Y96.037 E.00524
G1 X78.743 Y95.812 E.00512
G1 X78.714 Y95.565 E.00527
G1 X78.714 Y77.619 E.37984
G1 X78.755 Y77.34 E.00597
G1 X78.865 Y77.11 E.00539
G1 X79.03 Y76.928 E.0052
G1 X79.238 Y76.797 E.0052
G1 X79.392 Y76.746 E.00343
G1 X79.552 Y76.723 E.00343
G1 X92.622 Y76.722 E.27662
G1 X92.742 Y76.734 E.00256
G1 X92.895 Y76.775 E.00335
G1 X93.124 Y76.904 E.00557
G1 X93.068 Y77.082 E.00395
G1 X80.04 Y77.082 E.27574
G1 X79.752 Y77.133 E.00621
G1 X79.474 Y77.282 E.00668
G1 X79.241 Y77.529 E.00717
G1 X79.112 Y77.807 E.00649
G1 X79.075 Y78.056 E.00533
G1 X79.075 Y95.173 E.3623
G1 X79.16 Y95.529 E.00775
G1 X79.315 Y95.766 E.006
G1 X79.531 Y95.958 E.0061
G1 X79.8 Y96.084 E.00629
G1 X80.049 Y96.12 E.00533
G1 X84.795 Y96.12 E.10045
; WIPE_START
M204 S6000
G1 X86.795 Y96.12 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X83.699 Y96.891 Z4.56 F18000
G1 Z4.16
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X79.607 Y96.891 E.08049
G1 X79.291 Y96.854 E.00625
G1 X79.156 Y96.814 E.00277
G1 X78.953 Y96.719 E.00442
G1 X78.707 Y96.536 E.00602
G1 X78.574 Y96.389 E.0039
G1 X78.477 Y96.244 E.00342
G1 X78.412 Y96.114 E.00286
G1 X78.341 Y95.901 E.00442
G1 X78.304 Y95.589 E.00619
G1 X78.304 Y77.607 E.35368
G1 X78.313 Y77.454 E.00301
G1 X78.36 Y77.228 E.00454
G1 X78.409 Y77.093 E.00283
G1 X78.519 Y76.89 E.00454
G1 X78.605 Y76.774 E.00283
G1 X78.766 Y76.613 E.00448
G1 X78.952 Y76.483 E.00448
G1 X79.081 Y76.418 E.00283
G1 X79.297 Y76.346 E.00448
G1 X79.522 Y76.313 E.00448
G1 X92.643 Y76.313 E.25807
G1 X92.817 Y76.331 E.00343
G1 X93.035 Y76.389 E.00445
G1 X93.239 Y76.484 E.00442
G1 X93.423 Y76.613 E.00442
G1 X93.582 Y76.772 E.00442
G1 X93.711 Y76.956 E.00442
G1 X93.806 Y77.16 E.00442
G1 X93.864 Y77.377 E.00442
G1 X93.884 Y77.61 E.0046
G1 X93.884 Y85.511 E.1554
G1 X96.181 Y85.511 E.04518
G1 X96.494 Y85.198 E.00871
G1 X96.884 Y85.588 E.01085
G1 X96.884 Y87.614 E.03985
G1 X96.494 Y88.004 E.01085
G1 X96.181 Y87.691 E.00871
G1 X93.884 Y87.691 E.04518
G1 X93.884 Y88.791 E.02164
G1 X92.704 Y88.791 E.02321
G1 X92.704 Y77.491 E.22226
G1 X80.076 Y77.491 E.24839
G1 X79.888 Y77.524 E.00376
G1 X79.726 Y77.611 E.00361
G1 X79.584 Y77.762 E.00406
G1 X79.508 Y77.925 E.00355
G1 X79.484 Y78.086 E.00319
G1 X79.484 Y95.125 E.33516
G1 X79.541 Y95.365 E.00484
G1 X79.628 Y95.496 E.0031
G1 X79.758 Y95.612 E.00343
G1 X79.919 Y95.687 E.00349
G1 X80.079 Y95.711 E.00319
G1 X92.288 Y95.711 E.24013
G1 X92.318 Y95.342 E.00727
G1 X92.408 Y95.063 E.00577
G1 X92.474 Y94.948 E.00262
G1 X92.589 Y94.807 E.00357
G1 X92.672 Y94.732 E.00219
G1 X92.922 Y94.585 E.00571
G1 X93.161 Y94.521 E.00487
G1 X93.451 Y94.524 E.00571
G1 X93.725 Y94.611 E.00565
G1 X94.03 Y94.807 E.00715
G1 X95.622 Y94.286 E.03294
G1 X98.41 Y90.305 E.09559
G1 X99.376 Y90.982 E.02321
G1 X96.375 Y95.268 E.10291
G1 X93.445 Y96.575 E.06312
G1 X93.251 Y96.71 E.00465
G1 X93.101 Y96.787 E.00331
G1 X92.891 Y96.855 E.00434
G1 X92.582 Y96.891 E.00611
G1 X88.49 Y96.891 E.08049
G1 X89.098 Y97.59 E.01822
G1 X89.227 Y97.767 E.00431
G1 X89.46 Y98.159 E.00897
G1 X89.555 Y98.356 E.00431
G1 X89.716 Y98.783 E.00897
G1 X89.774 Y98.994 E.00431
G1 X89.856 Y99.443 E.00897
G1 X89.877 Y99.661 E.0043
G1 X89.878 Y100.112 E.00888
G1 X89.811 Y100.632 E.01031
G1 X89.721 Y101.001 E.00746
G1 X89.651 Y101.209 E.00431
M73 P78 R5
G1 X89.468 Y101.627 E.00897
G1 X89.364 Y101.817 E.00428
G1 X89.065 Y102.252 E.01037
G1 X88.658 Y102.692 E.0118
G1 X88.431 Y102.883 E.00583
G1 X88.122 Y103.103 E.00746
G1 X87.725 Y103.322 E.00892
G1 X87.522 Y103.412 E.00437
G1 X87.314 Y103.489 E.00436
G1 X86.877 Y103.609 E.00891
G1 X86.429 Y103.676 E.00891
G1 X86.21 Y103.689 E.00431
G1 X85.757 Y103.676 E.00891
G1 X85.309 Y103.608 E.00891
G1 X85.093 Y103.556 E.00437
G1 X84.881 Y103.491 E.00437
G1 X84.461 Y103.321 E.00891
G1 X84.068 Y103.103 E.00885
G1 X83.702 Y102.84 E.00885
G1 X83.371 Y102.536 E.00885
G1 X83.078 Y102.195 E.00885
G1 X82.827 Y101.821 E.00885
G1 X82.623 Y101.42 E.00885
G1 X82.467 Y100.998 E.00885
G1 X82.363 Y100.562 E.00883
G1 X82.309 Y100.04 E.01031
G1 X82.312 Y99.661 E.00746
G1 X82.332 Y99.443 E.00431
G1 X82.414 Y98.997 E.00891
G1 X82.547 Y98.568 E.00883
G1 X82.766 Y98.092 E.01031
G1 X82.962 Y97.768 E.00746
G1 X83.091 Y97.59 E.00431
G1 X83.659 Y96.936 E.01705
; WIPE_START
M204 S6000
G1 X81.66 Y96.914 E-.38
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




G1 X79.578 Y96.239
G1 Z4.16
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.104205
G1 F1500
M204 S6000
G1 X79.379 Y96.175 E.00082
; LINE_WIDTH: 0.152297
G1 X79.179 Y96.024 E.00159
G1 X79.044 Y95.851 E.00139
; LINE_WIDTH: 0.130008
G1 X79.001 Y95.749 E.00058
; LINE_WIDTH: 0.0946312
G1 X78.957 Y95.646 E.00038
; WIPE_START
G1 X79.001 Y95.749 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X84.643 Y97.167 Z4.56 F18000
G1 Z4.16
G1 E.4 F1800
; LINE_WIDTH: 0.4798
G1 F1500
M204 S6000
G1 X84.412 Y97.353 E.00673
; LINE_WIDTH: 0.447016
G1 X84.283 Y97.473 E.00371
; LINE_WIDTH: 0.407514
G1 X84.138 Y97.609 E.00378
; LINE_WIDTH: 0.360409
G1 X83.713 Y98.079 E.01057
G1 X83.498 Y98.404 E.00651
G1 X83.286 Y98.852 E.00827
G1 X83.186 Y99.187 E.00584
G1 X83.117 Y99.546 E.00611
G1 X83.097 Y100.005 E.00767
G1 X83.132 Y100.357 E.00591
G1 X83.205 Y100.701 E.00587
G1 X83.349 Y101.103 E.00712
G1 X83.512 Y101.418 E.00594
G1 X83.708 Y101.716 E.00594
G1 X84.033 Y102.078 E.00813
G1 X84.455 Y102.412 E.00898
G1 X84.891 Y102.647 E.00828
G1 X85.242 Y102.775 E.00624
G1 X85.584 Y102.854 E.00586
G1 X86.118 Y102.896 E.00894
G1 X86.647 Y102.848 E.00887
G1 X87.027 Y102.751 E.00655
G1 X87.375 Y102.612 E.00625
G1 X87.803 Y102.365 E.00824
G1 X88.221 Y102.017 E.00909
G1 X88.437 Y101.766 E.00553
G1 X88.685 Y101.405 E.0073
G1 X88.837 Y101.106 E.0056
G1 X89.004 Y100.614 E.00868
G1 X89.087 Y100.063 E.0093
G1 X89.086 Y99.704 E.006
G1 X89.008 Y99.187 E.00872
G1 X88.837 Y98.696 E.00869
G1 X88.759 Y98.532 E.00303
G1 X88.562 Y98.201 E.00643
G1 X88.222 Y97.784 E.00899
; LINE_WIDTH: 0.37882
G1 X88.045 Y97.609 E.00438
; LINE_WIDTH: 0.419309
G1 X87.842 Y97.411 E.00557
; LINE_WIDTH: 0.468125
G1 X87.544 Y97.162 E.00858
; WIPE_START
G1 X87.842 Y97.411 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X94.029 Y95.546 Z4.56 F18000
G1 Z4.16
G1 E.4 F1800
; LINE_WIDTH: 0.152233
G1 F1500
M204 S6000
G1 X94.523 Y95.356 E.00334
; LINE_WIDTH: 0.103909
G1 X95.017 Y95.165 E.00206
; WIPE_START
G1 X94.523 Y95.356 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X95.657 Y87.808 Z4.56 F18000
G1 X95.839 Y86.601 Z4.56
G1 Z4.16
G1 E.4 F1800
; LINE_WIDTH: 0.114562
G1 F1500
M204 S6000
G1 X93.75 Y86.601 E.00925
; WIPE_START
G1 X95.75 Y86.601 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X89.196 Y82.689 Z4.56 F18000
G1 X79.588 Y76.954 Z4.56
G1 Z4.16
G1 E.4 F1800
; LINE_WIDTH: 0.0998273
G1 F1500
M204 S6000
G1 X79.453 Y76.999 E.00053
; LINE_WIDTH: 0.149703
G1 X79.3 Y77.071 E.00104
G1 X79.214 Y77.145 E.0007
G1 X79.102 Y77.265 E.00102
G1 X79.019 Y77.388 E.00091
; LINE_WIDTH: 0.0995552
G1 X78.949 Y77.602 E.00083
; WIPE_START
G1 X79.019 Y77.388 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X85.917 Y80.655 Z4.56 F18000
G1 X100.371 Y87.504 Z4.56
G1 Z4.16
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X100.647 Y87.111 E.00944
G1 X101.37 Y87.617 E.01737
G1 X101.613 Y87.787 E.00584
G1 X101.338 Y88.181 E.00944
G1 X100.42 Y87.538 E.02203
M204 S10000
G1 X100.676 Y87.424 F18000
; FEATURE: Gap infill
; LINE_WIDTH: 0.0965142
G1 F1500
M204 S6000
G1 X101.308 Y87.867 E.00272
; CHANGE_LAYER
; Z_HEIGHT: 4.28
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F1500
G1 X100.676 Y87.424 E-.38
; WIPE_END
G1 E-.02 F1800
; layer num/total_layer_count: 43/57
; update layer progress
M73 L43
M991 S0 P42 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z4.56 I-1.089 J-.543 P1  F18000
G1 X100.284 Y88.212 Z4.56
G1 Z4.28
G1 E.4 F1800
; FEATURE: Support interface
; LINE_WIDTH: 0.42
; LAYER_HEIGHT: 0.26
G1 F1267.254
M204 S6000
G1 X99.86 Y88.212 E.01672
G1 X99.234 Y89.106 E.04298
G1 X100.706 Y89.106 E.05796
G1 X100.08 Y90 E.04298
G1 X99.071 Y90 E.03969
; WIPE_START
G1 X100.08 Y90 E-.19156
G1 X100.648 Y89.188 E-.18844
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X96.624 Y82.702 Z4.68 F18000
G1 X93.475 Y77.628 Z4.68
G1 Z4.28
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
; LAYER_HEIGHT: 0.12
G1 F1500
M204 S500
G1 X93.475 Y83.71 E.12872
G1 X93.114 Y83.71 E.00765
G1 X93.114 Y77.127 E.13932
G1 X93.292 Y77.071 E.00395
G1 X93.355 Y77.162 E.00234
G1 X93.42 Y77.3 E.00324
G1 X93.459 Y77.448 E.00324
G1 X93.47 Y77.568 E.00255
; WIPE_START
M204 S6000
G1 X93.472 Y79.568 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X93.565 Y87.2 Z4.68 F18000
G1 X93.667 Y95.563 Z4.68
G1 Z4.28
G1 E.4 F1800
G1 F1500
M204 S500
G1 X93.116 Y95.809 E.01278
G1 X93.144 Y95.467 E.00725
G1 X93.166 Y95.414 E.00122
G1 X93.212 Y95.37 E.00135
G1 X93.291 Y95.349 E.00173
G1 X93.362 Y95.37 E.00158
G1 X93.617 Y95.531 E.00636
; WIPE_START
M204 S6000
G1 X93.116 Y95.809 E-.14569
G1 X93.144 Y95.467 E-.08717
G1 X93.166 Y95.414 E-.01464
G1 X93.212 Y95.37 E-.01623
G1 X93.291 Y95.349 E-.02081
G1 X93.362 Y95.37 E-.01899
G1 X93.617 Y95.531 E-.07648
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X86.105 Y96.886 Z4.68 F18000
G1 X84.86 Y97.11 Z4.68
G1 Z4.28
G1 E.4 F1800
G1 F1500
M204 S500
G1 X84.753 Y96.949 E.0041
G1 X85.105 Y96.544 E.01135
G1 X87.084 Y96.544 E.04188
G1 X87.437 Y96.951 E.0114
G1 X87.314 Y97.115 E.00436
G1 X87.193 Y97.059 E.00282
G1 X86.699 Y96.915 E.01089
G1 X86.325 Y96.864 E.00799
G1 X85.986 Y96.858 E.00717
G1 X85.421 Y96.928 E.01204
G1 X84.917 Y97.092 E.01123
; WIPE_START
M204 S6000
G1 X84.753 Y96.949 E-.04131
G1 X85.105 Y96.544 E-.10188
G1 X86.351 Y96.544 E-.23681
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X83.48 Y99.878 Z4.68 F18000
G1 Z4.28
G1 E.4 F1800
G1 F1500
M204 S500
G1 X83.502 Y99.507 E.00786
G1 X83.625 Y99.025 E.01053
G1 X83.734 Y98.763 E.00601
G1 X83.891 Y98.482 E.0068
G1 X84.173 Y98.118 E.00975
G1 X84.515 Y97.809 E.00975
G1 X84.784 Y97.632 E.00683
G1 X85.073 Y97.487 E.00683
G1 X85.514 Y97.344 E.00982
G1 X86.008 Y97.282 E.01054
G1 X86.292 Y97.288 E.00601
G1 X86.61 Y97.331 E.0068
G1 X87.043 Y97.458 E.00955
G1 X87.336 Y97.593 E.00683
G1 X87.611 Y97.763 E.00683
G1 X87.962 Y98.061 E.00975
G1 X88.255 Y98.417 E.00975
G1 X88.42 Y98.694 E.00683
G1 X88.551 Y98.989 E.00683
G1 X88.674 Y99.433 E.00975
G1 X88.716 Y99.901 E.00995
G1 X88.674 Y100.369 E.00995
G1 X88.551 Y100.813 E.00975
G1 X88.42 Y101.108 E.00683
G1 X88.255 Y101.385 E.00683
G1 X87.962 Y101.741 E.00975
G1 X87.611 Y102.039 E.00975
G1 X87.336 Y102.208 E.00684
G1 X87.043 Y102.344 E.00683
G1 X86.601 Y102.473 E.00975
G1 X86.134 Y102.522 E.00995
G1 X85.674 Y102.488 E.00975
G1 X85.36 Y102.416 E.00683
G1 X85.056 Y102.307 E.00683
G1 X84.65 Y102.089 E.00975
G1 X84.283 Y101.796 E.00995
G1 X83.971 Y101.439 E.01002
G1 X83.721 Y101.009 E.01053
G1 X83.614 Y100.746 E.00601
G1 X83.529 Y100.437 E.0068
G1 X83.474 Y99.979 E.00975
G1 X83.476 Y99.938 E.00089
M204 S250
G1 X83.888 Y99.902 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X83.908 Y99.57 E.00654
G1 X84.015 Y99.155 E.00844
G1 X84.103 Y98.941 E.00454
G1 X84.233 Y98.708 E.00525
G1 X84.474 Y98.397 E.00774
G1 X84.766 Y98.134 E.00773
G1 X84.989 Y97.987 E.00526
G1 X85.228 Y97.867 E.00526
G1 X85.603 Y97.745 E.00775
G1 X86.029 Y97.692 E.00844
G1 X86.26 Y97.697 E.00454
G1 X86.525 Y97.733 E.00525
G1 X86.899 Y97.842 E.00767
G1 X87.142 Y97.954 E.00526
G1 X87.369 Y98.095 E.00526
G1 X87.669 Y98.349 E.00773
G1 X87.919 Y98.653 E.00773
G1 X88.056 Y98.883 E.00526
G1 X88.165 Y99.127 E.00526
G1 X88.27 Y99.506 E.00773
G1 X88.305 Y99.901 E.0078
G1 X88.27 Y100.296 E.0078
G1 X88.165 Y100.675 E.00773
G1 X88.056 Y100.919 E.00526
G1 X87.919 Y101.149 E.00526
G1 X87.669 Y101.452 E.00773
G1 X87.37 Y101.707 E.00773
G1 X87.142 Y101.847 E.00526
G1 X86.899 Y101.96 E.00526
G1 X86.522 Y102.07 E.00773
G1 X86.127 Y102.111 E.0078
G1 X85.735 Y102.082 E.00773
G1 X85.475 Y102.023 E.00526
G1 X85.223 Y101.932 E.00526
G1 X84.877 Y101.746 E.00773
G1 X84.567 Y101.499 E.0078
G1 X84.305 Y101.199 E.00782
G1 X84.089 Y100.829 E.00844
G1 X84.002 Y100.615 E.00454
G1 X83.931 Y100.357 E.00525
G1 X83.885 Y99.967 E.00773
G1 X83.885 Y99.962 E.0001
; WIPE_START
M204 S6000
G1 X83.908 Y99.57 E-.07457
G1 X84.015 Y99.155 E-.0815
G1 X84.103 Y98.941 E-.04387
G1 X84.233 Y98.708 E-.05073
G1 X84.474 Y98.397 E-.07472
G1 X84.687 Y98.205 E-.05461
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X84.855 Y96.12 Z4.68 F18000
G1 Z4.28
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X92.664 Y96.12 E.16529
G1 X92.739 Y95.336 E.01666
G1 X92.784 Y95.227 E.0025
G1 X92.851 Y95.128 E.00252
G1 X92.933 Y95.049 E.00243
G1 X93.066 Y94.969 E.00328
G1 X93.272 Y94.922 E.00447
G1 X93.368 Y94.929 E.00203
G1 X93.541 Y94.981 E.00382
G1 X93.976 Y95.256 E.01089
M73 P79 R5
G1 X95.879 Y94.633 E.04238
G1 X98.51 Y90.875 E.09709
G1 X98.806 Y91.083 E.00765
G1 X96.105 Y94.94 E.09967
G1 X93.244 Y96.216 E.06631
G1 X93.021 Y96.37 E.00573
G1 X92.803 Y96.453 E.00495
G1 X92.559 Y96.482 E.0052
G1 X87.591 Y96.482 E.10514
G1 X88.777 Y97.845 E.03824
G1 X88.884 Y97.992 E.00386
G1 X89.099 Y98.353 E.00888
G1 X89.326 Y98.91 E.01273
G1 X89.451 Y99.499 E.01274
G1 X89.469 Y100.087 E.01246
G1 X89.409 Y100.553 E.00995
G1 X89.268 Y101.066 E.01126
G1 X89.167 Y101.306 E.00551
G1 X89.007 Y101.616 E.00739
G1 X88.66 Y102.102 E.01263
G1 X88.376 Y102.395 E.00864
G1 X88.184 Y102.556 E.00531
G1 X87.737 Y102.855 E.01137
G1 X87.188 Y103.099 E.01273
G1 X86.792 Y103.208 E.00868
G1 X86.386 Y103.269 E.00869
G1 X85.794 Y103.267 E.01254
G1 X85.211 Y103.164 E.01254
G1 X84.813 Y103.029 E.00888
G1 X84.287 Y102.757 E.01254
G1 X83.961 Y102.522 E.00849
G1 X83.666 Y102.251 E.00849
G1 X83.404 Y101.947 E.00849
G1 X83.181 Y101.613 E.0085
G1 X83 Y101.259 E.00841
G1 X82.842 Y100.816 E.00995
G1 X82.738 Y100.3 E.01115
G1 X82.715 Y99.89 E.00869
G1 X82.74 Y99.49 E.00849
G1 X82.812 Y99.095 E.00849
G1 X82.93 Y98.715 E.00842
G1 X83.126 Y98.288 E.00994
G1 X83.411 Y97.845 E.01116
G1 X84.597 Y96.482 E.03824
G1 X79.63 Y96.482 E.10513
G1 X79.392 Y96.454 E.00508
G1 X79.119 Y96.34 E.00626
G1 X78.992 Y96.24 E.00344
G1 X78.884 Y96.119 E.00343
G1 X78.773 Y95.912 E.00497
G1 X78.743 Y95.818 E.00209
G1 X78.714 Y95.565 E.00539
G1 X78.714 Y77.619 E.37984
G1 X78.753 Y77.349 E.00578
G1 X78.855 Y77.125 E.0052
G1 X79.038 Y76.92 E.00582
G1 X79.153 Y76.841 E.00296
G1 X79.294 Y76.775 E.00328
G1 X79.543 Y76.723 E.00539
G1 X92.623 Y76.722 E.27685
G1 X92.742 Y76.734 E.00252
G1 X92.895 Y76.775 E.00336
G1 X93.124 Y76.904 E.00556
G1 X93.068 Y77.082 E.00395
G1 X80.04 Y77.082 E.27574
G1 X79.752 Y77.132 E.0062
G1 X79.474 Y77.282 E.00669
G1 X79.241 Y77.529 E.00717
G1 X79.112 Y77.807 E.00649
G1 X79.075 Y78.056 E.00533
G1 X79.075 Y95.137 E.36154
G1 X79.099 Y95.344 E.00441
G1 X79.21 Y95.629 E.00648
G1 X79.503 Y95.945 E.00911
G1 X79.8 Y96.084 E.00695
G1 X80.049 Y96.12 E.00533
G1 X84.795 Y96.12 E.10045
; WIPE_START
M204 S6000
G1 X86.795 Y96.12 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X83.699 Y96.891 Z4.68 F18000
G1 Z4.28
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X79.607 Y96.891 E.08049
G1 X79.297 Y96.855 E.00613
G1 X79.01 Y96.75 E.00601
G1 X78.888 Y96.68 E.00277
G1 X78.71 Y96.539 E.00448
G1 X78.558 Y96.369 E.00448
G1 X78.479 Y96.248 E.00284
G1 X78.39 Y96.061 E.00406
G1 X78.341 Y95.903 E.00326
G1 X78.304 Y95.589 E.00623
G1 X78.304 Y77.607 E.35368
G1 X78.313 Y77.454 E.00301
G1 X78.359 Y77.231 E.00448
G1 X78.443 Y77.019 E.00448
G1 X78.515 Y76.895 E.00283
G1 X78.658 Y76.715 E.00452
G1 X78.782 Y76.6 E.00332
G1 X78.949 Y76.485 E.004
G1 X79.153 Y76.389 E.00443
G1 X79.373 Y76.33 E.00448
G1 X79.519 Y76.313 E.00289
G1 X92.645 Y76.313 E.25816
G1 X92.816 Y76.331 E.0034
G1 X93.035 Y76.389 E.00446
G1 X93.239 Y76.484 E.00442
G1 X93.423 Y76.613 E.00442
G1 X93.582 Y76.772 E.00442
G1 X93.711 Y76.956 E.00442
G1 X93.806 Y77.16 E.00442
G1 X93.864 Y77.377 E.00442
G1 X93.884 Y77.61 E.0046
G1 X93.884 Y85.511 E.1554
G1 X96.181 Y85.511 E.04518
G1 X96.494 Y85.198 E.00871
G1 X96.764 Y85.468 E.00751
G1 X96.764 Y87.734 E.04457
G1 X96.494 Y88.004 E.00751
G1 X96.181 Y87.691 E.00871
G1 X93.884 Y87.691 E.04518
G1 X93.884 Y88.791 E.02164
G1 X92.704 Y88.791 E.02321
G1 X92.704 Y77.491 E.22226
G1 X80.076 Y77.491 E.24839
G1 X79.888 Y77.524 E.00376
G1 X79.726 Y77.611 E.00362
G1 X79.584 Y77.762 E.00406
G1 X79.508 Y77.925 E.00355
G1 X79.484 Y78.086 E.00319
G1 X79.484 Y95.113 E.33492
G1 X79.5 Y95.244 E.0026
G1 X79.563 Y95.408 E.00346
G1 X79.748 Y95.608 E.00536
G1 X79.919 Y95.687 E.0037
G1 X80.079 Y95.711 E.00319
G1 X92.288 Y95.711 E.24013
G1 X92.318 Y95.341 E.0073
G1 X92.348 Y95.212 E.0026
G1 X92.417 Y95.044 E.00357
G1 X92.545 Y94.855 E.0045
G1 X92.675 Y94.73 E.00355
G1 X92.923 Y94.584 E.00566
G1 X93.161 Y94.521 E.00484
G1 X93.442 Y94.523 E.00554
G1 X93.713 Y94.606 E.00556
G1 X94.031 Y94.807 E.00741
G1 X95.622 Y94.286 E.03292
G1 X98.41 Y90.305 E.09559
G1 X99.376 Y90.982 E.02321
G1 X96.375 Y95.268 E.10291
G1 X93.445 Y96.575 E.0631
G1 X93.229 Y96.723 E.00516
G1 X93.102 Y96.786 E.0028
G1 X92.891 Y96.855 E.00436
G1 X92.582 Y96.891 E.00611
G1 X88.49 Y96.891 E.08049
G1 X89.098 Y97.59 E.01823
G1 X89.226 Y97.767 E.0043
G1 X89.46 Y98.159 E.00897
G1 X89.555 Y98.356 E.00431
G1 X89.716 Y98.783 E.00897
G1 X89.774 Y98.994 E.00431
G1 X89.856 Y99.443 E.00897
G1 X89.877 Y99.661 E.0043
G1 X89.878 Y100.112 E.00888
G1 X89.812 Y100.628 E.01022
G1 X89.721 Y101.001 E.00755
G1 X89.538 Y101.48 E.01008
G1 X89.361 Y101.822 E.00758
G1 X89.204 Y102.065 E.00569
G1 X88.97 Y102.369 E.00755
G1 X88.655 Y102.694 E.0089
G1 X88.435 Y102.88 E.00567
G1 X88.119 Y103.105 E.00762
G1 X87.93 Y103.216 E.00431
G1 X87.519 Y103.413 E.00897
G1 X87.313 Y103.489 E.00431
G1 X86.877 Y103.609 E.00891
G1 X86.429 Y103.676 E.00891
G1 X86.21 Y103.689 E.00431
G1 X85.757 Y103.676 E.00891
G1 X85.309 Y103.608 E.00891
G1 X85.097 Y103.557 E.0043
G1 X84.664 Y103.411 E.00898
G1 X84.464 Y103.322 E.0043
G1 X84.068 Y103.103 E.00891
G1 X83.703 Y102.84 E.00885
G1 X83.371 Y102.536 E.00885
G1 X83.078 Y102.195 E.00885
G1 X82.827 Y101.821 E.00885
G1 X82.623 Y101.421 E.00882
G1 X82.449 Y100.932 E.01022
G1 X82.362 Y100.558 E.00755
G1 X82.33 Y100.341 E.00431
G1 X82.305 Y99.889 E.00891
G1 X82.333 Y99.44 E.00885
G1 X82.414 Y98.997 E.00885
G1 X82.547 Y98.568 E.00883
G1 X82.764 Y98.096 E.01022
G1 X82.962 Y97.768 E.00755
G1 X83.091 Y97.59 E.00431
G1 X83.659 Y96.936 E.01705
; WIPE_START
M204 S6000
G1 X81.66 Y96.914 E-.38
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




G1 X79.578 Y96.239
G1 Z4.28
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.107191
G1 F1500
M204 S6000
G1 X79.338 Y96.154 E.00103
; LINE_WIDTH: 0.160099
G1 X79.189 Y96.029 E.00131
G1 X79.022 Y95.817 E.00181
; LINE_WIDTH: 0.11455
G1 X78.993 Y95.757 E.0003
; LINE_WIDTH: 0.0880783
G1 X78.959 Y95.633 E.0004
; WIPE_START
G1 X78.993 Y95.757 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X84.08 Y97.673 Z4.68 F18000
G1 Z4.28
G1 E.4 F1800
; LINE_WIDTH: 0.400629
G1 F1500
M204 S6000
G1 X84.254 Y97.496 E.00464
; LINE_WIDTH: 0.438424
G1 X84.461 Y97.319 E.00561
; LINE_WIDTH: 0.477114
G1 X84.642 Y97.165 E.00533
M204 S10000
G1 X84.08 Y97.673 F18000
; LINE_WIDTH: 0.359818
G1 F1500
M204 S6000
G1 X83.716 Y98.081 E.00911
G1 X83.462 Y98.469 E.00772
G1 X83.27 Y98.894 E.00777
G1 X83.133 Y99.433 E.00928
G1 X83.097 Y99.891 E.00765
G1 X83.12 Y100.256 E.0061
G1 X83.209 Y100.711 E.00772
G1 X83.35 Y101.108 E.00702
G1 X83.513 Y101.418 E.00583
G1 X83.708 Y101.716 E.00593
G1 X84.033 Y102.078 E.00812
G1 X84.455 Y102.412 E.00896
G1 X84.892 Y102.646 E.00826
G1 X85.314 Y102.796 E.00747
G1 X85.828 Y102.884 E.00869
G1 X86.125 Y102.896 E.00495
G1 X86.66 Y102.846 E.00895
G1 X87.065 Y102.736 E.007
G1 X87.524 Y102.537 E.00834
G1 X87.841 Y102.335 E.00626
G1 X88.22 Y102.015 E.00826
G1 X88.553 Y101.61 E.00875
G1 X88.75 Y101.291 E.00626
G1 X88.901 Y100.951 E.00619
G1 X89.036 Y100.484 E.00811
G1 X89.086 Y100.063 E.00706
G1 X89.084 Y99.704 E.00599
G1 X89.039 Y99.352 E.00591
G1 X88.961 Y99.031 E.0055
G1 X88.763 Y98.53 E.00898
G1 X88.474 Y98.08 E.00893
G1 X88.222 Y97.784 E.00647
; LINE_WIDTH: 0.378794
G1 X88.045 Y97.609 E.00438
; LINE_WIDTH: 0.419282
G1 X87.842 Y97.411 E.00556
; LINE_WIDTH: 0.46811
G1 X87.544 Y97.162 E.00858
; WIPE_START
G1 X87.842 Y97.411 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X94.035 Y95.544 Z4.68 F18000
G1 Z4.28
G1 E.4 F1800
; LINE_WIDTH: 0.151734
G1 F1500
M204 S6000
G1 X94.526 Y95.354 E.00331
; LINE_WIDTH: 0.103744
G1 X95.017 Y95.165 E.00205
; WIPE_START
G1 X94.526 Y95.354 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X96.177 Y87.903 Z4.68 F18000
G1 X96.548 Y86.233 Z4.68
G1 Z4.28
G1 E.4 F1800
; FEATURE: Top surface
; LINE_WIDTH: 0.42
G1 F1500
M204 S2000
G1 X96.042 Y85.728 E.01406
G1 X95.485 Y85.728
G1 X96.548 Y86.791 E.02957
G1 X96.548 Y87.348
G1 X94.927 Y85.728 E.04508
G1 X94.369 Y85.728
G1 X96.116 Y87.474 E.04858
G1 X95.558 Y87.474
G1 X93.812 Y85.728 E.04858
; WIPE_START
M204 S6000
G1 X95.226 Y87.142 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X93.668 Y84.468 Z4.68 F18000
G1 Z4.28
G1 E.4 F1800
G1 F1500
M204 S2000
G1 X93.29 Y84.091 E.0105
G1 X92.975 Y84.333
G1 X93.668 Y85.026 E.01926
G1 X93.668 Y85.583
G1 X92.975 Y84.891 E.01926
G1 X92.975 Y85.448
G1 X95.001 Y87.474 E.05634
G1 X94.443 Y87.474
G1 X92.975 Y86.006 E.04084
G1 X92.975 Y86.564
G1 X93.886 Y87.474 E.02533
G1 X93.668 Y87.813
G1 X92.975 Y87.121 E.01926
G1 X92.975 Y87.679
G1 X93.668 Y88.371 E.01926
; WIPE_START
M204 S6000
G1 X92.975 Y87.679 E-.18605
G1 X92.975 Y87.121 E-.10593
G1 X93.303 Y87.449 E-.08801
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X93.817 Y85.723 Z4.68 F18000
G1 Z4.28
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.153358
G1 F1500
M204 S6000
G1 X93.673 Y85.773 E.00097
G1 X93.622 Y85.723 E.00045
G1 X93.673 Y85.578 E.00097
; WIPE_START
G1 X93.622 Y85.723 E-.15417
G1 X93.673 Y85.773 E-.07161
G1 X93.817 Y85.723 E-.15422
; WIPE_END
G1 E-.02 F1800
M204 S10000
M73 P80 R5
G1 X96.567 Y87.343 Z4.68 F18000
G1 Z4.28
G1 E.4 F1800
; LINE_WIDTH: 0.216367
G1 F1500
M204 S6000
G1 X96.47 Y87.563 E.00228
; LINE_WIDTH: 0.198537
G1 X96.42 Y87.544 E.00046
; LINE_WIDTH: 0.144588
G1 X96.37 Y87.525 E.00032
G1 X96.263 Y87.431 E.00085
G1 X96.189 Y87.401 E.00047
; WIPE_START
G1 X96.263 Y87.431 E-.10993
G1 X96.37 Y87.525 E-.19679
G1 X96.42 Y87.544 E-.07328
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X93.687 Y88.545 Z4.68 F18000
G1 Z4.28
G1 E.4 F1800
; LINE_WIDTH: 0.123333
G1 F1500
M204 S6000
G1 X92.955 Y88.545 E.00356
; WIPE_START
G1 X93.687 Y88.545 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X93.065 Y84.031 Z4.68 F18000
G1 Z4.28
G1 E.4 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.365752
G1 F1500
M204 S6000
G1 X93.566 Y83.988 E.00854
; WIPE_START
G1 X93.065 Y84.031 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X86.307 Y80.482 Z4.68 F18000
G1 X79.591 Y76.955 Z4.68
G1 Z4.28
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.0897751
G1 F1500
M204 S6000
G1 X79.487 Y76.991 E.00035
; LINE_WIDTH: 0.12912
G1 X79.291 Y77.078 E.0011
; LINE_WIDTH: 0.156363
G1 X79.168 Y77.19 E.00108
G1 X79.019 Y77.387 E.00161
; LINE_WIDTH: 0.103536
G1 X78.949 Y77.601 E.00087
; WIPE_START
G1 X79.019 Y77.387 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X85.916 Y80.655 Z4.68 F18000
G1 X100.371 Y87.504 Z4.68
G1 Z4.28
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X100.647 Y87.111 E.00944
G1 X101.396 Y87.636 E.018
G1 X101.613 Y87.787 E.00521
G1 X101.338 Y88.181 E.00944
G1 X100.42 Y87.538 E.02203
M204 S10000
G1 X100.676 Y87.424 F18000
; FEATURE: Gap infill
; LINE_WIDTH: 0.0965193
G1 F1500
M204 S6000
G1 X101.308 Y87.867 E.00272
; CHANGE_LAYER
; Z_HEIGHT: 4.4
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F1500
G1 X100.676 Y87.424 E-.38
; WIPE_END
G1 E-.02 F1800
; layer num/total_layer_count: 44/57
; update layer progress
M73 L44
M991 S0 P43 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z4.68 I.838 J-.883 P1  F18000
G1 X93.468 Y80.581 Z4.68
G1 Z4.4
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X93.475 Y88.382 E.1651
G1 X93.114 Y88.382 E.00764
G1 X93.114 Y77.128 E.23818
G1 X93.299 Y77.076 E.00407
G1 X93.379 Y77.207 E.00325
G1 X93.436 Y77.349 E.00324
G1 X93.465 Y77.49 E.00305
G1 X93.468 Y80.521 E.06416
; WIPE_START
M204 S6000
G1 X93.469 Y82.521 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
M73 P80 R4
G1 X93.58 Y90.153 Z4.8 F18000
G1 X93.658 Y95.567 Z4.8
G1 Z4.4
G1 E.4 F1800
G1 F1500
M204 S500
G1 X93.122 Y95.806 E.01243
G1 X93.14 Y95.498 E.00653
G1 X93.163 Y95.421 E.0017
G1 X93.202 Y95.372 E.00133
G1 X93.295 Y95.347 E.00204
G1 X93.369 Y95.368 E.00162
G1 X93.609 Y95.533 E.00615
; WIPE_START
M204 S6000
G1 X93.122 Y95.806 E-.14399
G1 X93.14 Y95.498 E-.07959
G1 X93.163 Y95.421 E-.02071
G1 X93.202 Y95.372 E-.01616
G1 X93.295 Y95.347 E-.02486
G1 X93.369 Y95.368 E-.01977
G1 X93.609 Y95.533 E-.07492
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X86.097 Y96.887 Z4.8 F18000
G1 X84.86 Y97.11 Z4.8
G1 Z4.4
G1 E.4 F1800
G1 F1500
M204 S500
G1 X84.753 Y96.949 E.0041
G1 X85.105 Y96.544 E.01135
G1 X87.084 Y96.544 E.04188
G1 X87.437 Y96.951 E.0114
G1 X87.314 Y97.115 E.00436
G1 X87.193 Y97.059 E.00282
G1 X86.699 Y96.915 E.01089
G1 X86.325 Y96.864 E.00799
G1 X85.983 Y96.858 E.00723
G1 X85.421 Y96.928 E.01198
G1 X84.917 Y97.092 E.01122
; WIPE_START
M204 S6000
G1 X84.753 Y96.949 E-.04131
G1 X85.105 Y96.544 E-.10189
G1 X86.351 Y96.544 E-.2368
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X83.479 Y99.889 Z4.8 F18000
G1 Z4.4
G1 E.4 F1800
G1 F1500
M204 S500
G1 X83.502 Y99.51 E.00803
G1 X83.613 Y99.054 E.00994
G1 X83.801 Y98.633 E.00976
G1 X83.974 Y98.361 E.00683
G1 X84.179 Y98.111 E.00683
G1 X84.515 Y97.809 E.00956
G1 X84.784 Y97.632 E.00683
G1 X85.073 Y97.487 E.00683
G1 X85.514 Y97.344 E.00981
G1 X86.005 Y97.282 E.01048
G1 X86.292 Y97.288 E.00607
G1 X86.61 Y97.331 E.0068
G1 X87.043 Y97.458 E.00955
G1 X87.336 Y97.593 E.00683
G1 X87.611 Y97.763 E.00683
G1 X87.955 Y98.055 E.00955
G1 X88.167 Y98.298 E.00683
G1 X88.349 Y98.565 E.00683
G1 X88.549 Y98.98 E.00975
G1 X88.674 Y99.433 E.00995
G1 X88.715 Y99.892 E.00975
G1 X88.696 Y100.212 E.0068
G1 X88.646 Y100.494 E.00606
G1 X88.491 Y100.964 E.01048
G1 X88.26 Y101.378 E.01002
G1 X87.962 Y101.741 E.00994
G1 X87.601 Y102.047 E.01001
G1 X87.17 Y102.29 E.01048
G1 X86.903 Y102.393 E.00606
G1 X86.592 Y102.474 E.0068
G1 X86.13 Y102.523 E.00982
G1 X85.637 Y102.481 E.01048
G1 X85.358 Y102.416 E.00606
G1 X85.056 Y102.307 E.0068
G1 X84.65 Y102.089 E.00975
G1 X84.283 Y101.796 E.00995
G1 X83.973 Y101.442 E.00995
G1 X83.737 Y101.046 E.00975
G1 X83.615 Y100.748 E.00683
G1 X83.529 Y100.437 E.00683
G1 X83.474 Y99.979 E.00975
G1 X83.476 Y99.949 E.00065
M204 S250
G1 X83.888 Y99.913 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X83.908 Y99.571 E.00674
G1 X84.002 Y99.186 E.00779
G1 X84.162 Y98.827 E.00774
G1 X84.306 Y98.602 E.00526
G1 X84.476 Y98.395 E.00526
G1 X84.766 Y98.134 E.00767
G1 X84.989 Y97.987 E.00526
G1 X85.228 Y97.867 E.00526
G1 X85.603 Y97.745 E.00775
G1 X86.027 Y97.692 E.00839
G1 X86.26 Y97.697 E.00459
G1 X86.525 Y97.733 E.00525
G1 X86.899 Y97.842 E.00767
G1 X87.142 Y97.954 E.00526
G1 X87.369 Y98.095 E.00526
G1 X87.667 Y98.347 E.00767
G1 X87.843 Y98.549 E.00526
G1 X87.994 Y98.77 E.00526
G1 X88.164 Y99.124 E.00773
G1 X88.27 Y99.506 E.0078
G1 X88.305 Y99.898 E.00773
G1 X88.289 Y100.164 E.00525
G1 X88.248 Y100.394 E.00459
G1 X88.115 Y100.799 E.00839
G1 X87.921 Y101.146 E.00782
G1 X87.669 Y101.452 E.00779
G1 X87.366 Y101.709 E.00782
G1 X86.995 Y101.919 E.00839
G1 X86.777 Y102.003 E.00459
G1 X86.519 Y102.07 E.00525
G1 X86.126 Y102.112 E.00776
G1 X85.701 Y102.075 E.00839
G1 X85.474 Y102.022 E.00459
G1 X85.223 Y101.932 E.00525
G1 X84.876 Y101.746 E.00773
G1 X84.567 Y101.499 E.00779
G1 X84.306 Y101.2 E.0078
G1 X84.104 Y100.863 E.00774
G1 X84.003 Y100.615 E.00526
G1 X83.931 Y100.357 E.00526
G1 X83.885 Y99.973 E.00761
; WIPE_START
M204 S6000
G1 X83.908 Y99.571 E-.07646
G1 X84.002 Y99.186 E-.07528
G1 X84.162 Y98.827 E-.07474
G1 X84.306 Y98.602 E-.05082
G1 X84.476 Y98.395 E-.05082
G1 X84.679 Y98.212 E-.05188
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X84.855 Y96.12 Z4.8 F18000
G1 Z4.4
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X92.678 Y96.12 E.16558
G1 X92.718 Y95.441 E.01439
G1 X92.742 Y95.331 E.00238
G1 X92.784 Y95.227 E.00238
G1 X92.877 Y95.1 E.00333
G1 X93.063 Y94.97 E.00479
G1 X93.272 Y94.922 E.00455
G1 X93.375 Y94.929 E.00218
G1 X93.534 Y94.974 E.00349
G1 X93.961 Y95.261 E.0109
G1 X95.879 Y94.633 E.04271
G1 X98.51 Y90.875 E.09709
G1 X98.806 Y91.083 E.00765
G1 X96.105 Y94.94 E.09967
G1 X93.244 Y96.216 E.0663
G1 X93.021 Y96.37 E.00573
G1 X92.803 Y96.453 E.00495
G1 X92.559 Y96.482 E.0052
G1 X87.591 Y96.482 E.10514
G1 X88.775 Y97.842 E.03816
G1 X89.099 Y98.352 E.01278
G1 X89.323 Y98.901 E.01257
G1 X89.45 Y99.489 E.01273
G1 X89.469 Y100.087 E.01266
G1 X89.41 Y100.549 E.00985
G1 X89.268 Y101.066 E.01136
G1 X89.009 Y101.612 E.01279
G1 X88.665 Y102.096 E.01257
G1 X88.379 Y102.391 E.00869
G1 X88.061 Y102.65 E.00869
G1 X87.737 Y102.855 E.00811
G1 X87.188 Y103.099 E.01273
G1 X86.792 Y103.208 E.00869
G1 X86.386 Y103.269 E.00868
G1 X85.794 Y103.267 E.01254
G1 X85.202 Y103.161 E.01273
G1 X84.638 Y102.951 E.01273
G1 X84.287 Y102.757 E.0085
G1 X83.961 Y102.522 E.00849
G1 X83.666 Y102.251 E.00849
G1 X83.404 Y101.947 E.00849
G1 X83.181 Y101.613 E.0085
G1 X83 Y101.259 E.00842
G1 X82.844 Y100.821 E.00985
G1 X82.738 Y100.3 E.01125
G1 X82.715 Y99.89 E.00869
G1 X82.74 Y99.49 E.00849
G1 X82.812 Y99.095 E.0085
G1 X82.93 Y98.715 E.00842
G1 X83.124 Y98.292 E.00984
G1 X83.411 Y97.845 E.01125
G1 X84.597 Y96.482 E.03824
G1 X79.631 Y96.482 E.10513
G1 X79.383 Y96.453 E.00527
G1 X79.238 Y96.405 E.00324
G1 X79.022 Y96.269 E.00539
G1 X78.895 Y96.133 E.00394
G1 X78.814 Y96.003 E.00324
G1 X78.741 Y95.803 E.0045
G1 X78.714 Y95.565 E.00508
G1 X78.714 Y77.619 E.37984
G1 X78.754 Y77.343 E.0059
G1 X78.859 Y77.12 E.00523
G1 X79.037 Y76.921 E.00564
G1 X79.154 Y76.841 E.00299
G1 X79.299 Y76.773 E.0034
G1 X79.55 Y76.723 E.00542
G1 X92.615 Y76.722 E.27653
G1 X92.8 Y76.747 E.00394
G1 X92.942 Y76.794 E.00318
G1 X93.119 Y76.889 E.00424
G1 X93.07 Y77.082 E.0042
G1 X80.04 Y77.082 E.27579
G1 X79.752 Y77.132 E.0062
G1 X79.474 Y77.282 E.00669
G1 X79.241 Y77.529 E.00717
G1 X79.112 Y77.807 E.00649
G1 X79.075 Y78.056 E.00533
G1 X79.075 Y95.137 E.36154
G1 X79.099 Y95.344 E.00441
G1 X79.211 Y95.63 E.00649
G1 X79.503 Y95.945 E.0091
G1 X79.8 Y96.084 E.00695
G1 X80.049 Y96.12 E.00533
G1 X84.795 Y96.12 E.10045
; WIPE_START
M204 S6000
G1 X86.795 Y96.12 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X83.699 Y96.891 Z4.8 F18000
G1 Z4.4
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X79.607 Y96.891 E.08049
G1 X79.294 Y96.854 E.00619
G1 X79.081 Y96.784 E.00442
G1 X78.952 Y96.719 E.00283
G1 X78.763 Y96.587 E.00454
G1 X78.656 Y96.486 E.00289
G1 X78.562 Y96.373 E.00289
G1 X78.444 Y96.182 E.00442
G1 X78.341 Y95.898 E.00595
G1 X78.304 Y95.589 E.00613
G1 X78.304 Y77.607 E.35368
G1 X78.313 Y77.454 E.00301
G1 X78.36 Y77.229 E.00452
G1 X78.419 Y77.073 E.00329
G1 X78.517 Y76.893 E.00403
G1 X78.658 Y76.715 E.00447
G1 X78.781 Y76.601 E.00329
G1 X78.949 Y76.485 E.00403
G1 X79.155 Y76.389 E.00447
G1 X79.316 Y76.342 E.00329
G1 X79.522 Y76.313 E.00409
G1 X92.643 Y76.313 E.25809
G1 X92.893 Y76.347 E.00495
G1 X93.105 Y76.417 E.0044
G1 X93.303 Y76.524 E.00442
G1 X93.479 Y76.663 E.00442
G1 X93.629 Y76.831 E.00442
G1 X93.746 Y77.022 E.00442
G1 X93.829 Y77.231 E.00442
G1 X93.874 Y77.448 E.00436
G1 X93.884 Y88.791 E.2231
G1 X92.704 Y88.791 E.02321
G1 X92.704 Y77.491 E.22226
G1 X80.076 Y77.491 E.24839
G1 X79.888 Y77.524 E.00376
G1 X79.726 Y77.611 E.00362
G1 X79.584 Y77.762 E.00406
G1 X79.508 Y77.925 E.00355
G1 X79.484 Y78.086 E.00319
G1 X79.484 Y95.113 E.33492
G1 X79.5 Y95.244 E.00259
G1 X79.564 Y95.409 E.00347
G1 X79.748 Y95.608 E.00535
G1 X79.919 Y95.687 E.0037
G1 X80.079 Y95.711 E.00318
G1 X92.292 Y95.711 E.24022
G1 X92.312 Y95.386 E.00639
G1 X92.349 Y95.211 E.00353
G1 X92.417 Y95.044 E.00353
G1 X92.577 Y94.82 E.00542
G1 X92.673 Y94.731 E.00257
G1 X92.922 Y94.585 E.00569
G1 X93.161 Y94.521 E.00487
G1 X93.445 Y94.523 E.00559
G1 X93.68 Y94.59 E.00481
G1 X93.777 Y94.637 E.00213
G1 X94.027 Y94.809 E.00595
G1 X95.622 Y94.286 E.03302
G1 X98.41 Y90.305 E.09559
G1 X99.376 Y90.982 E.02321
G1 X96.375 Y95.268 E.10291
G1 X93.445 Y96.574 E.0631
G1 X93.229 Y96.723 E.00516
G1 X93.102 Y96.786 E.0028
G1 X92.891 Y96.855 E.00436
G1 X92.582 Y96.891 E.00611
G1 X88.49 Y96.891 E.08049
G1 X89.097 Y97.589 E.0182
G1 X89.261 Y97.821 E.00558
G1 X89.46 Y98.158 E.00771
G1 X89.555 Y98.356 E.00432
G1 X89.715 Y98.78 E.00891
G1 X89.823 Y99.22 E.00891
G1 X89.877 Y99.661 E.00873
G1 X89.878 Y100.112 E.00889
G1 X89.813 Y100.623 E.01013
G1 X89.721 Y101.001 E.00764
G1 X89.54 Y101.475 E.00999
G1 X89.362 Y101.821 E.00764
G1 X89.109 Y102.197 E.00892
G1 X88.972 Y102.368 E.00431
G1 X88.657 Y102.693 E.00891
G1 X88.305 Y102.979 E.00891
G1 X88.121 Y103.103 E.00437
G1 X87.93 Y103.216 E.00437
G1 X87.519 Y103.413 E.00897
G1 X87.313 Y103.489 E.00431
G1 X86.877 Y103.609 E.00891
G1 X86.429 Y103.676 E.00891
G1 X86.21 Y103.689 E.00431
G1 X85.757 Y103.676 E.00891
G1 X85.309 Y103.608 E.00891
G1 X85.093 Y103.556 E.00436
G1 X84.881 Y103.491 E.00437
G1 X84.462 Y103.321 E.00891
G1 X84.068 Y103.103 E.00885
G1 X83.703 Y102.84 E.00885
G1 X83.371 Y102.536 E.00885
G1 X83.078 Y102.195 E.00885
G1 X82.827 Y101.821 E.00885
G1 X82.623 Y101.421 E.00883
G1 X82.45 Y100.936 E.01013
G1 X82.362 Y100.558 E.00765
G1 X82.33 Y100.341 E.00431
G1 X82.305 Y99.889 E.00891
G1 X82.333 Y99.44 E.00885
G1 X82.414 Y98.997 E.00885
G1 X82.547 Y98.568 E.00883
G1 X82.761 Y98.1 E.01012
G1 X82.962 Y97.767 E.00764
G1 X83.091 Y97.59 E.00431
G1 X83.659 Y96.936 E.01705
; WIPE_START
M204 S6000
G1 X81.66 Y96.914 E-.38
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




G1 X79.578 Y96.239
G1 Z4.4
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.107775
G1 F1500
M204 S6000
G1 X79.354 Y96.166 E.00096
; LINE_WIDTH: 0.129934
G1 X79.337 Y96.156 E.0001
; LINE_WIDTH: 0.162463
G1 X79.164 Y96.004 E.00157
G1 X78.947 Y95.733 E.00237
M204 S10000
G1 X78.959 Y95.633 F18000
; LINE_WIDTH: 0.101074
G1 F1500
M204 S6000
G1 X78.992 Y95.758 E.00049
G1 X79.155 Y96.091 E.00139
; WIPE_START
G1 X78.992 Y95.758 E-.28151
G1 X78.959 Y95.633 E-.09849
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X84.642 Y97.165 Z4.8 F18000
G1 Z4.4
M73 P81 R4
G1 E.4 F1800
; LINE_WIDTH: 0.477099
G1 F1500
M204 S6000
G1 X84.461 Y97.319 E.00533
; LINE_WIDTH: 0.438416
G1 X84.254 Y97.496 E.00561
; LINE_WIDTH: 0.401018
G1 X84.085 Y97.669 E.00453
; LINE_WIDTH: 0.360095
G1 X83.713 Y98.078 E.00922
G1 X83.458 Y98.471 E.00781
G1 X83.261 Y98.918 E.00814
G1 X83.132 Y99.439 E.00896
G1 X83.097 Y99.891 E.00756
G1 X83.12 Y100.256 E.0061
G1 X83.211 Y100.715 E.0078
G1 X83.35 Y101.108 E.00695
G1 X83.512 Y101.418 E.00584
G1 X83.708 Y101.716 E.00594
G1 X84.033 Y102.078 E.00812
G1 X84.454 Y102.412 E.00897
G1 X84.892 Y102.645 E.00827
G1 X85.302 Y102.793 E.00728
G1 X85.828 Y102.883 E.00889
G1 X86.119 Y102.896 E.00486
G1 X86.647 Y102.848 E.00885
G1 X87.028 Y102.751 E.00656
G1 X87.34 Y102.623 E.00563
G1 X87.804 Y102.366 E.00885
G1 X88.218 Y102.014 E.00907
G1 X88.474 Y101.722 E.00647
G1 X88.678 Y101.417 E.00613
G1 X88.843 Y101.102 E.00592
G1 X89.01 Y100.598 E.00885
G1 X89.07 Y100.247 E.00595
G1 X89.092 Y99.874 E.00623
G1 X89.048 Y99.371 E.00841
G1 X88.904 Y98.862 E.00883
G1 X88.758 Y98.53 E.00604
G1 X88.473 Y98.073 E.00899
G1 X88.213 Y97.775 E.0066
; LINE_WIDTH: 0.380229
G1 X88.04 Y97.605 E.00429
; LINE_WIDTH: 0.419789
G1 X87.842 Y97.411 E.00545
; LINE_WIDTH: 0.46813
G1 X87.544 Y97.162 E.00858
; WIPE_START
G1 X87.842 Y97.411 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X94.012 Y95.553 Z4.8 F18000
G1 Z4.4
G1 E.4 F1800
; LINE_WIDTH: 0.15373
G1 F1500
M204 S6000
G1 X94.514 Y95.359 E.00344
; LINE_WIDTH: 0.104409
G1 X95.017 Y95.165 E.00211
; WIPE_START
G1 X94.514 Y95.359 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X89.483 Y89.619 Z4.8 F18000
G1 X78.949 Y77.602 Z4.8
G1 Z4.4
G1 E.4 F1800
; LINE_WIDTH: 0.0977149
G1 F1500
M204 S6000
G1 X79.021 Y77.388 E.00081
; LINE_WIDTH: 0.122921
G1 X79.027 Y77.374 E.00008
; LINE_WIDTH: 0.155791
G1 X79.169 Y77.189 E.00151
G1 X79.291 Y77.078 E.00107
; LINE_WIDTH: 0.129787
G1 X79.49 Y76.989 E.00113
; LINE_WIDTH: 0.0924315
G1 X79.589 Y76.954 E.00035
; WIPE_START
G1 X79.49 Y76.989 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X85.901 Y81.131 Z4.8 F18000
G1 X96.323 Y87.863 Z4.8
G1 Z4.4
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.376624
G1 F1500
M204 S500
G1 X96.323 Y85.339 E.04418
G1 X96.494 Y85.167 E.00425
G1 X96.666 Y85.339 E.00425
G1 X96.666 Y87.863 E.04418
G1 X96.494 Y88.035 E.00425
G1 X96.365 Y87.905 E.0032
; WIPE_START
M204 S6000
G1 X96.332 Y85.906 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X100.371 Y87.504 Z4.8 F18000
G1 Z4.4
G1 E.4 F1800
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X100.647 Y87.111 E.00944
G1 X101.423 Y87.654 E.01863
G1 X101.613 Y87.787 E.00458
G1 X101.338 Y88.181 E.00944
G1 X100.42 Y87.538 E.02203
M204 S10000
G1 X100.676 Y87.424 F18000
; FEATURE: Gap infill
; LINE_WIDTH: 0.0960424
G1 F1500
M204 S6000
G1 X101.279 Y87.846 E.00258
G1 X101.328 Y87.838 E.00017
; CHANGE_LAYER
; Z_HEIGHT: 4.52
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F1500
G1 X101.279 Y87.846 E-.02413
G1 X100.676 Y87.424 E-.35587
; WIPE_END
G1 E-.02 F1800
; layer num/total_layer_count: 45/57
; update layer progress
M73 L45
M991 S0 P44 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z4.8 I.844 J-.877 P1  F18000
G1 X93.468 Y80.492 Z4.8
G1 Z4.52
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X93.475 Y88.382 E.16698
G1 X93.114 Y88.382 E.00764
G1 X93.114 Y77.128 E.23818
G1 X93.299 Y77.076 E.00407
G1 X93.379 Y77.207 E.00325
G1 X93.436 Y77.349 E.00324
G1 X93.465 Y77.49 E.00306
G1 X93.468 Y80.432 E.06227
; WIPE_START
M204 S6000
G1 X93.469 Y82.432 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X93.576 Y90.064 Z4.92 F18000
G1 X93.653 Y95.569 Z4.92
G1 Z4.52
G1 E.4 F1800
G1 F1500
M204 S500
G1 X93.122 Y95.806 E.01232
G1 X93.14 Y95.498 E.00654
G1 X93.165 Y95.415 E.00183
G1 X93.212 Y95.37 E.00138
G1 X93.295 Y95.347 E.00183
G1 X93.375 Y95.37 E.00176
G1 X93.604 Y95.534 E.00597
; WIPE_START
M204 S6000
G1 X93.122 Y95.806 E-.14361
G1 X93.14 Y95.498 E-.08006
G1 X93.165 Y95.415 E-.02236
G1 X93.212 Y95.37 E-.01695
G1 X93.295 Y95.347 E-.02247
G1 X93.375 Y95.37 E-.02151
G1 X93.604 Y95.534 E-.07305
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X86.091 Y96.88 Z4.92 F18000
G1 X84.929 Y97.088 Z4.92
G1 Z4.52
G1 E.4 F1800
G1 F1500
M204 S500
G1 X84.823 Y96.922 E.00416
G1 X85.172 Y96.544 E.01089
G1 X87.084 Y96.544 E.04046
G1 X87.434 Y96.947 E.01129
G1 X87.304 Y97.112 E.00445
G1 X87.213 Y97.065 E.00218
G1 X86.699 Y96.915 E.01133
G1 X86.324 Y96.864 E.00799
G1 X85.98 Y96.858 E.00729
G1 X85.421 Y96.928 E.01193
G1 X84.986 Y97.069 E.00967
; WIPE_START
M204 S6000
G1 X84.823 Y96.922 E-.04172
G1 X85.172 Y96.544 E-.09776
G1 X86.438 Y96.544 E-.24053
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X83.479 Y99.9 Z4.92 F18000
G1 Z4.52
G1 E.4 F1800
G1 F1500
M204 S500
G1 X83.502 Y99.51 E.00826
G1 X83.613 Y99.054 E.00994
G1 X83.801 Y98.633 E.00976
G1 X83.974 Y98.361 E.00683
G1 X84.174 Y98.119 E.00663
G1 X84.399 Y97.903 E.0066
G1 X84.63 Y97.729 E.00612
G1 X85.061 Y97.491 E.01043
G1 X85.514 Y97.344 E.01007
G1 X86.002 Y97.282 E.01043
G1 X86.292 Y97.288 E.00612
G1 X86.61 Y97.331 E.0068
G1 X87.055 Y97.461 E.00981
G1 X87.494 Y97.686 E.01043
G1 X87.729 Y97.853 E.00612
G1 X87.968 Y98.068 E.0068
G1 X88.261 Y98.424 E.00975
G1 X88.489 Y98.835 E.00995
G1 X88.638 Y99.27 E.00975
G1 X88.696 Y99.588 E.00683
G1 X88.715 Y99.901 E.00663
G1 X88.696 Y100.214 E.00663
G1 X88.638 Y100.531 E.00683
G1 X88.49 Y100.967 E.00975
G1 X88.261 Y101.378 E.00995
G1 X87.962 Y101.741 E.00995
G1 X87.601 Y102.047 E.01001
G1 X87.172 Y102.289 E.01043
G1 X86.903 Y102.393 E.00612
G1 X86.592 Y102.474 E.0068
G1 X86.131 Y102.523 E.00981
G1 X85.64 Y102.481 E.01043
G1 X85.358 Y102.416 E.00612
G1 X85.056 Y102.307 E.0068
G1 X84.65 Y102.089 E.00975
G1 X84.283 Y101.796 E.00995
G1 X83.973 Y101.442 E.00995
G1 X83.732 Y101.039 E.00995
G1 X83.57 Y100.607 E.00975
G1 X83.503 Y100.291 E.00683
G1 X83.474 Y99.97 E.00683
G1 X83.475 Y99.959 E.00022
M204 S250
G1 X83.887 Y99.924 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X83.908 Y99.571 E.00695
G1 X84.002 Y99.186 E.00779
G1 X84.162 Y98.827 E.00774
G1 X84.306 Y98.602 E.00526
G1 X84.474 Y98.397 E.0052
G1 X84.665 Y98.215 E.00519
G1 X84.853 Y98.073 E.00464
G1 X85.225 Y97.868 E.00834
G1 X85.603 Y97.745 E.00783
G1 X86.024 Y97.692 E.00835
G1 X86.26 Y97.697 E.00464
G1 X86.525 Y97.733 E.00525
G1 X86.903 Y97.843 E.00775
G1 X87.281 Y98.036 E.00834
G1 X87.473 Y98.173 E.00464
G1 X87.671 Y98.352 E.00525
G1 X87.921 Y98.656 E.00773
G1 X88.114 Y99.002 E.0078
G1 X88.241 Y99.374 E.00773
G1 X88.289 Y99.637 E.00526
G1 X88.305 Y99.901 E.0052
G1 X88.289 Y100.165 E.0052
G1 X88.241 Y100.428 E.00526
G1 X88.114 Y100.8 E.00773
G1 X87.921 Y101.146 E.0078
G1 X87.669 Y101.452 E.0078
G1 X87.366 Y101.709 E.00782
G1 X86.997 Y101.918 E.00834
G1 X86.777 Y102.003 E.00464
G1 X86.519 Y102.07 E.00525
G1 X86.126 Y102.112 E.00776
G1 X85.704 Y102.076 E.00834
G1 X85.474 Y102.022 E.00464
G1 X85.223 Y101.932 E.00525
G1 X84.877 Y101.746 E.00773
G1 X84.567 Y101.499 E.0078
G1 X84.306 Y101.2 E.0078
G1 X84.103 Y100.86 E.00779
G1 X83.964 Y100.492 E.00774
G1 X83.909 Y100.23 E.00526
G1 X83.887 Y99.984 E.00487
; WIPE_START
M204 S6000
G1 X83.908 Y99.571 E-.07848
G1 X84.002 Y99.186 E-.07528
G1 X84.162 Y98.827 E-.07474
G1 X84.306 Y98.602 E-.05082
G1 X84.474 Y98.397 E-.05024
G1 X84.665 Y98.215 E-.05014
G1 X84.666 Y98.214 E-.0003
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X84.929 Y96.12 Z4.92 F18000
G1 Z4.52
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X92.678 Y96.12 E.16402
G1 X92.718 Y95.441 E.0144
G1 X92.742 Y95.33 E.00241
G1 X92.851 Y95.128 E.00484
G1 X92.932 Y95.05 E.00238
G1 X93.063 Y94.971 E.00324
G1 X93.272 Y94.922 E.00455
G1 X93.375 Y94.929 E.00218
G1 X93.526 Y94.972 E.00333
G1 X93.954 Y95.263 E.01095
G1 X95.879 Y94.633 E.04287
G1 X98.51 Y90.875 E.09709
G1 X98.806 Y91.083 E.00765
G1 X96.105 Y94.94 E.09967
G1 X93.244 Y96.216 E.06631
G1 X93.021 Y96.37 E.00573
G1 X92.803 Y96.453 E.00495
G1 X92.559 Y96.482 E.0052
G1 X87.591 Y96.482 E.10514
G1 X88.777 Y97.845 E.03824
G1 X89.099 Y98.353 E.01273
G1 X89.273 Y98.756 E.00929
G1 X89.376 Y99.094 E.00748
G1 X89.451 Y99.499 E.00872
G1 X89.469 Y100.087 E.01247
G1 X89.411 Y100.545 E.00975
G1 X89.269 Y101.061 E.01134
G1 X89.011 Y101.61 E.01285
G1 X88.661 Y102.099 E.01272
G1 X88.337 Y102.428 E.00978
G1 X88.062 Y102.649 E.00746
G1 X87.737 Y102.855 E.00813
G1 X87.367 Y103.032 E.00869
G1 X86.978 Y103.164 E.00869
G1 X86.386 Y103.269 E.01273
G1 X85.794 Y103.267 E.01254
G1 X85.202 Y103.161 E.01273
G1 X84.638 Y102.951 E.01273
G1 X84.287 Y102.757 E.00849
G1 X83.961 Y102.522 E.00849
G1 X83.666 Y102.251 E.0085
G1 X83.404 Y101.947 E.00849
G1 X83.181 Y101.613 E.0085
G1 X82.998 Y101.256 E.00849
G1 X82.86 Y100.879 E.00849
G1 X82.766 Y100.489 E.00849
G1 X82.72 Y100.091 E.00849
G1 X82.738 Y99.499 E.01253
G1 X82.812 Y99.095 E.00869
G1 X82.931 Y98.712 E.00849
G1 X83.093 Y98.348 E.00843
G1 X83.333 Y97.955 E.00975
G1 X83.549 Y97.676 E.00747
G1 X84.653 Y96.482 E.03442
G1 X79.631 Y96.482 E.10629
G1 X79.301 Y96.43 E.00707
G1 X79.179 Y96.374 E.00282
G1 X78.984 Y96.231 E.00512
G1 X78.833 Y96.041 E.00514
G1 X78.743 Y95.812 E.0052
G1 X78.714 Y95.565 E.00527
G1 X78.714 Y77.622 E.37977
G1 X78.752 Y77.351 E.0058
G1 X78.865 Y77.111 E.00561
G1 X78.954 Y76.999 E.00302
G1 X79.07 Y76.896 E.00328
G1 X79.291 Y76.775 E.00533
G1 X79.551 Y76.723 E.00561
G1 X92.617 Y76.722 E.27656
G1 X92.8 Y76.747 E.0039
G1 X92.942 Y76.794 E.00318
G1 X93.119 Y76.889 E.00424
G1 X93.07 Y77.082 E.0042
G1 X80.049 Y77.082 E.2756
G1 X79.791 Y77.119 E.00552
G1 X79.489 Y77.271 E.00717
G1 X79.265 Y77.495 E.00669
G1 X79.113 Y77.797 E.00717
G1 X79.075 Y78.056 E.00553
G1 X79.075 Y95.173 E.36231
G1 X79.16 Y95.532 E.00781
G1 X79.323 Y95.774 E.00617
G1 X79.532 Y95.959 E.00591
G1 X79.8 Y96.084 E.00625
G1 X80.049 Y96.12 E.00533
G1 X84.869 Y96.12 E.10201
; WIPE_START
M204 S6000
G1 X86.869 Y96.12 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X83.718 Y96.891 Z4.92 F18000
G1 Z4.52
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X79.607 Y96.891 E.08086
G1 X79.291 Y96.854 E.00625
G1 X78.971 Y96.729 E.00676
G1 X78.707 Y96.536 E.00643
G1 X78.558 Y96.368 E.00441
G1 X78.478 Y96.246 E.00289
G1 X78.412 Y96.114 E.00289
G1 X78.341 Y95.901 E.00442
G1 X78.304 Y95.589 E.00619
G1 X78.304 Y77.608 E.35366
G1 X78.316 Y77.434 E.00344
G1 X78.359 Y77.232 E.00406
G1 X78.443 Y77.02 E.00447
G1 X78.527 Y76.878 E.00326
G1 X78.656 Y76.717 E.00406
G1 X78.824 Y76.567 E.00443
G1 X79.018 Y76.447 E.00448
G1 X79.152 Y76.389 E.00287
G1 X79.314 Y76.343 E.00332
G1 X79.522 Y76.313 E.00412
G1 X92.645 Y76.313 E.25812
G1 X92.893 Y76.347 E.00492
G1 X93.105 Y76.417 E.0044
G1 X93.303 Y76.524 E.00442
G1 X93.479 Y76.663 E.00442
G1 X93.628 Y76.831 E.00442
G1 X93.746 Y77.022 E.00442
G1 X93.829 Y77.231 E.00442
G1 X93.874 Y77.448 E.00436
G1 X93.884 Y88.791 E.2231
G1 X92.704 Y88.791 E.02321
G1 X92.704 Y77.491 E.22226
G1 X80.079 Y77.491 E.24833
G1 X79.916 Y77.515 E.00325
G1 X79.731 Y77.607 E.00406
G1 X79.601 Y77.737 E.00362
G1 X79.508 Y77.922 E.00406
G1 X79.484 Y78.086 E.00325
G1 X79.484 Y95.125 E.33516
G1 X79.541 Y95.366 E.00486
G1 X79.633 Y95.502 E.00323
G1 X79.759 Y95.613 E.00329
G1 X79.919 Y95.687 E.00348
G1 X80.079 Y95.711 E.00319
G1 X92.292 Y95.711 E.24022
G1 X92.312 Y95.386 E.00639
G1 X92.349 Y95.21 E.00354
G1 X92.409 Y95.059 E.00319
G1 X92.545 Y94.855 E.00483
G1 X92.674 Y94.73 E.00353
G1 X92.922 Y94.585 E.00565
G1 X93.161 Y94.521 E.00487
G1 X93.445 Y94.523 E.00558
G1 X93.678 Y94.589 E.00476
G1 X93.819 Y94.662 E.00313
G1 X94.024 Y94.81 E.00496
G1 X95.622 Y94.286 E.03307
G1 X98.41 Y90.305 E.09559
G1 X99.376 Y90.982 E.02321
G1 X96.375 Y95.268 E.10291
G1 X93.445 Y96.575 E.0631
G1 X93.229 Y96.723 E.00516
G1 X93.102 Y96.786 E.00279
G1 X92.891 Y96.855 E.00437
G1 X92.582 Y96.891 E.00611
G1 X88.49 Y96.891 E.08049
G1 X89.098 Y97.59 E.01822
G1 X89.227 Y97.767 E.00431
G1 X89.46 Y98.159 E.00897
G1 X89.556 Y98.358 E.00434
G1 X89.66 Y98.62 E.00555
G1 X89.775 Y98.997 E.00774
G1 X89.856 Y99.443 E.00892
G1 X89.877 Y99.661 E.0043
G1 X89.878 Y100.112 E.00889
G1 X89.814 Y100.619 E.01004
G1 X89.721 Y101.001 E.00773
G1 X89.651 Y101.209 E.00431
G1 X89.469 Y101.627 E.00897
G1 X89.209 Y102.057 E.00989
G1 X88.97 Y102.369 E.00772
G1 X88.612 Y102.732 E.01004
G1 X88.306 Y102.979 E.00773
G1 X88.121 Y103.103 E.00438
G1 X87.93 Y103.216 E.00436
G1 X87.521 Y103.412 E.00891
M73 P82 R4
G1 X87.092 Y103.557 E.00891
G1 X86.88 Y103.608 E.0043
G1 X86.429 Y103.676 E.00897
G1 X86.21 Y103.689 E.00431
G1 X85.757 Y103.676 E.00891
G1 X85.309 Y103.608 E.00891
G1 X85.093 Y103.556 E.00436
G1 X84.881 Y103.491 E.00437
G1 X84.462 Y103.321 E.00891
G1 X84.068 Y103.103 E.00885
G1 X83.703 Y102.84 E.00885
G1 X83.371 Y102.536 E.00885
G1 X83.078 Y102.195 E.00885
G1 X82.827 Y101.821 E.00885
G1 X82.623 Y101.42 E.00885
G1 X82.467 Y100.998 E.00885
G1 X82.363 Y100.561 E.00885
G1 X82.311 Y100.113 E.00885
G1 X82.312 Y99.661 E.00891
G1 X82.332 Y99.443 E.0043
G1 X82.414 Y98.997 E.00891
G1 X82.547 Y98.567 E.00885
G1 X82.73 Y98.157 E.00883
G1 X82.996 Y97.722 E.01003
G1 X83.237 Y97.411 E.00773
G1 X83.677 Y96.935 E.01275
; WIPE_START
M204 S6000
G1 X81.677 Y96.913 E-.38
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




G1 X79.578 Y96.239
G1 Z4.52
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.103736
G1 F1500
M204 S6000
G1 X79.381 Y96.177 E.0008
; LINE_WIDTH: 0.154658
G1 X79.175 Y96.021 E.00166
G1 X79.045 Y95.853 E.00136
; LINE_WIDTH: 0.131402
G1 X79.002 Y95.751 E.00059
; LINE_WIDTH: 0.0950613
G1 X78.958 Y95.648 E.00039
; WIPE_START
G1 X79.002 Y95.751 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X84.707 Y97.135 Z4.92 F18000
G1 Z4.52
G1 E.4 F1800
; LINE_WIDTH: 0.469953
G1 F1500
M204 S6000
G1 X84.412 Y97.365 E.0083
; LINE_WIDTH: 0.443709
G1 X84.389 Y97.385 E.00063
; LINE_WIDTH: 0.425831
G1 X84.271 Y97.492 E.00317
; LINE_WIDTH: 0.395888
G1 X84.139 Y97.613 E.00332
; LINE_WIDTH: 0.360073
G1 X83.889 Y97.868 E.00596
G1 X83.646 Y98.171 E.00648
G1 X83.431 Y98.525 E.00692
G1 X83.252 Y98.946 E.00762
G1 X83.127 Y99.469 E.00896
G1 X83.099 Y99.963 E.00827
G1 X83.131 Y100.357 E.0066
G1 X83.225 Y100.769 E.00704
G1 X83.387 Y101.189 E.0075
G1 X83.66 Y101.652 E.00896
G1 X83.941 Y101.985 E.00727
G1 X84.204 Y102.224 E.00593
G1 X84.491 Y102.435 E.00593
G1 X84.915 Y102.655 E.00796
G1 X85.302 Y102.793 E.00687
G1 X85.828 Y102.883 E.00889
G1 X86.349 Y102.886 E.0087
G1 X86.67 Y102.84 E.00541
G1 X86.877 Y102.795 E.00353
G1 X87.223 Y102.678 E.00609
G1 X87.554 Y102.516 E.00614
G1 X87.839 Y102.343 E.00556
G1 X88.239 Y101.993 E.00886
G1 X88.577 Y101.576 E.00896
G1 X88.825 Y101.133 E.00848
G1 X89 Y100.638 E.00875
G1 X89.07 Y100.249 E.0066
G1 X89.086 Y99.704 E.0091
G1 X89.008 Y99.187 E.00871
G1 X88.912 Y98.885 E.00529
G1 X88.76 Y98.533 E.00638
G1 X88.562 Y98.201 E.00646
G1 X88.233 Y97.797 E.00868
; LINE_WIDTH: 0.38233
G1 X87.972 Y97.532 E.00662
; LINE_WIDTH: 0.425051
G1 X87.854 Y97.425 E.00318
; LINE_WIDTH: 0.474934
G1 X87.718 Y97.303 E.00409
G1 X87.368 Y97.376 E.00803
; WIPE_START
G1 X87.718 Y97.303 E-.25171
G1 X87.854 Y97.425 E-.12829
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X94 Y95.557 Z4.92 F18000
G1 Z4.52
G1 E.4 F1800
; LINE_WIDTH: 0.15471
G1 F1500
M204 S6000
G1 X94.508 Y95.361 E.0035
; LINE_WIDTH: 0.104735
G1 X95.017 Y95.165 E.00215
; WIPE_START
G1 X94.508 Y95.361 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X89.479 Y89.62 Z4.92 F18000
G1 X78.949 Y77.603 Z4.92
G1 Z4.52
G1 E.4 F1800
; LINE_WIDTH: 0.0900018
G1 F1500
M204 S6000
G1 X78.977 Y77.514 E.0003
; LINE_WIDTH: 0.115049
G1 X79.005 Y77.426 E.00041
; LINE_WIDTH: 0.151923
G1 X79.054 Y77.323 E.00072
G1 X79.163 Y77.195 E.00106
G1 X79.324 Y77.059 E.00133
; LINE_WIDTH: 0.124448
G1 X79.49 Y76.991 E.00088
; LINE_WIDTH: 0.0898072
G1 X79.598 Y76.955 E.00037
; WIPE_START
G1 X79.49 Y76.991 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X85.894 Y81.144 Z4.92 F18000
G1 X96.443 Y87.983 Z4.92
G1 Z4.52
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.376624
G1 F1500
M204 S500
G1 X96.443 Y85.219 E.04838
G1 X96.494 Y85.167 E.00128
G1 X96.546 Y85.219 E.00128
G1 X96.546 Y87.983 E.04838
G1 X96.494 Y88.035 E.00128
G1 X96.485 Y88.025 E.00023
; WIPE_START
M204 S6000
G1 X96.455 Y86.026 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X100.371 Y87.504 Z4.92 F18000
G1 Z4.52
G1 E.4 F1800
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X100.647 Y87.111 E.00944
G1 X101.449 Y87.672 E.01926
G1 X101.613 Y87.787 E.00395
G1 X101.338 Y88.181 E.00944
G1 X100.42 Y87.538 E.02203
M204 S10000
G1 X100.676 Y87.424 F18000
; FEATURE: Gap infill
; LINE_WIDTH: 0.0965254
G1 F1500
M204 S6000
G1 X101.308 Y87.867 E.00272
; CHANGE_LAYER
; Z_HEIGHT: 4.64
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F1500
G1 X100.676 Y87.424 E-.38
; WIPE_END
G1 E-.02 F1800
; layer num/total_layer_count: 46/57
; update layer progress
M73 L46
M991 S0 P45 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z4.92 I.838 J-.883 P1  F18000
G1 X93.468 Y80.581 Z4.92
G1 Z4.64
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X93.475 Y88.382 E.1651
G1 X93.114 Y88.382 E.00764
G1 X93.114 Y77.128 E.23818
G1 X93.299 Y77.076 E.00407
G1 X93.379 Y77.207 E.00325
G1 X93.436 Y77.349 E.00325
G1 X93.465 Y77.49 E.00305
G1 X93.468 Y80.521 E.06416
; WIPE_START
M204 S6000
G1 X93.469 Y82.521 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X93.575 Y90.153 Z5.04 F18000
G1 X93.651 Y95.57 Z5.04
G1 Z4.64
G1 E.4 F1800
G1 F1500
M204 S500
G1 X93.122 Y95.806 E.01226
G1 X93.14 Y95.498 E.00653
G1 X93.165 Y95.415 E.00183
G1 X93.212 Y95.37 E.00138
G1 X93.295 Y95.347 E.00183
G1 X93.367 Y95.368 E.00157
G1 X93.602 Y95.535 E.00611
; WIPE_START
M204 S6000
G1 X93.122 Y95.806 E-.14335
G1 X93.14 Y95.498 E-.08026
G1 X93.165 Y95.415 E-.02254
G1 X93.212 Y95.37 E-.01699
G1 X93.295 Y95.347 E-.02251
G1 X93.367 Y95.368 E-.01931
G1 X93.602 Y95.535 E-.07504
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X86.09 Y96.889 Z5.04 F18000
G1 X84.86 Y97.11 Z5.04
G1 Z4.64
G1 E.4 F1800
G1 F1500
M204 S500
G1 X84.753 Y96.949 E.0041
G1 X85.105 Y96.544 E.01135
G1 X87.084 Y96.544 E.04188
G1 X87.434 Y96.947 E.01129
G1 X87.305 Y97.112 E.00444
G1 X87.212 Y97.065 E.0022
G1 X86.699 Y96.915 E.01132
G1 X86.324 Y96.864 E.008
G1 X85.977 Y96.858 E.00735
G1 X85.421 Y96.928 E.01187
G1 X84.917 Y97.092 E.01121
; WIPE_START
M204 S6000
G1 X84.753 Y96.949 E-.04131
G1 X85.105 Y96.544 E-.10188
G1 X86.351 Y96.544 E-.23681
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X83.478 Y99.911 Z5.04 F18000
G1 Z4.64
G1 E.4 F1800
G1 F1500
M204 S500
G1 X83.501 Y99.519 E.0083
G1 X83.568 Y99.204 E.00683
G1 X83.673 Y98.898 E.00684
G1 X83.885 Y98.489 E.00975
G1 X84.173 Y98.118 E.00994
G1 X84.515 Y97.809 E.00975
G1 X84.784 Y97.632 E.00683
G1 X85.073 Y97.487 E.00683
G1 X85.514 Y97.344 E.00981
G1 X86 Y97.282 E.01037
G1 X86.292 Y97.288 E.00618
G1 X86.61 Y97.331 E.00681
G1 X87.055 Y97.461 E.0098
G1 X87.491 Y97.684 E.01038
G1 X87.729 Y97.853 E.00617
G1 X87.97 Y98.07 E.00686
G1 X88.272 Y98.444 E.01018
G1 X88.421 Y98.695 E.00617
G1 X88.551 Y98.989 E.0068
G1 X88.674 Y99.433 E.00975
G1 X88.716 Y99.901 E.00995
G1 X88.674 Y100.369 E.00995
G1 X88.548 Y100.825 E.01001
G1 X88.332 Y101.264 E.01038
G1 X88.166 Y101.505 E.00617
G1 X87.955 Y101.747 E.0068
G1 X87.601 Y102.046 E.00981
G1 X87.175 Y102.288 E.01037
G1 X86.903 Y102.393 E.00617
G1 X86.592 Y102.474 E.0068
G1 X86.134 Y102.522 E.00975
G1 X85.662 Y102.487 E.01
G1 X85.189 Y102.36 E.01037
G1 X84.921 Y102.244 E.00618
G1 X84.643 Y102.083 E.0068
G1 X84.283 Y101.796 E.00975
G1 X83.972 Y101.44 E.01
G1 X83.724 Y101.017 E.01038
G1 X83.614 Y100.747 E.00617
G1 X83.529 Y100.437 E.0068
G1 X83.474 Y99.979 E.00975
G1 X83.474 Y99.971 E.00018
M204 S250
G1 X83.886 Y99.935 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X83.908 Y99.574 E.00711
G1 X83.964 Y99.313 E.00526
G1 X84.05 Y99.06 E.00527
G1 X84.231 Y98.711 E.00773
G1 X84.474 Y98.397 E.00779
G1 X84.766 Y98.134 E.00774
G1 X84.989 Y97.987 E.00526
G1 X85.228 Y97.867 E.00526
G1 X85.603 Y97.745 E.00775
G1 X86.022 Y97.692 E.0083
G1 X86.26 Y97.697 E.00469
G1 X86.525 Y97.733 E.00525
G1 X86.903 Y97.843 E.00775
G1 X87.279 Y98.035 E.0083
G1 X87.473 Y98.173 E.00469
G1 X87.672 Y98.352 E.00527
G1 X87.935 Y98.678 E.00823
G1 X88.056 Y98.883 E.00469
G1 X88.165 Y99.127 E.00525
G1 X88.27 Y99.506 E.00773
G1 X88.305 Y99.901 E.0078
G1 X88.27 Y100.296 E.0078
G1 X88.164 Y100.679 E.00781
G1 X87.978 Y101.057 E.0083
G1 X87.843 Y101.253 E.00469
G1 X87.667 Y101.455 E.00525
G1 X87.366 Y101.709 E.00775
G1 X86.999 Y101.917 E.0083
G1 X86.777 Y102.003 E.00469
G1 X86.519 Y102.07 E.00525
G1 X86.127 Y102.111 E.00774
G1 X85.731 Y102.082 E.00781
G1 X85.324 Y101.972 E.00829
G1 X85.105 Y101.878 E.00469
M73 P83 R4
G1 X84.874 Y101.744 E.00525
G1 X84.567 Y101.499 E.00773
G1 X84.305 Y101.2 E.00781
G1 X84.092 Y100.836 E.0083
G1 X84.003 Y100.615 E.00469
G1 X83.931 Y100.357 E.00525
G1 X83.888 Y99.995 E.00718
; WIPE_START
M204 S6000
G1 X83.908 Y99.574 E-.08
G1 X83.964 Y99.313 E-.05081
G1 X84.05 Y99.06 E-.05087
G1 X84.231 Y98.711 E-.07471
G1 X84.474 Y98.397 E-.07526
G1 X84.663 Y98.227 E-.04835
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X84.855 Y96.12 Z5.04 F18000
G1 Z4.64
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X92.678 Y96.12 E.16557
G1 X92.718 Y95.441 E.01439
G1 X92.742 Y95.33 E.00241
G1 X92.851 Y95.128 E.00485
G1 X92.933 Y95.049 E.00241
G1 X93.066 Y94.97 E.00327
G1 X93.272 Y94.922 E.00449
G1 X93.375 Y94.929 E.00218
G1 X93.525 Y94.971 E.0033
G1 X93.616 Y95.019 E.00218
G1 X93.951 Y95.264 E.00878
G1 X95.879 Y94.633 E.04295
G1 X98.531 Y90.845 E.09787
G1 X98.761 Y90.517 E.00847
G1 F720
G1 X98.98 Y90.204 E.0081
; FEATURE: Overhang wall
G1 F2357.113
G1 X100.471 Y88.074 E.05503
; FEATURE: Inner wall
G1 F600
G1 X100.691 Y87.761 E.0081
G1 F1500
G1 X100.747 Y87.68 E.00208
G1 X101.043 Y87.888 E.00765
G1 X100.987 Y87.968 E.00208
G1 F600
G1 X100.767 Y88.282 E.0081
; FEATURE: Overhang wall
G1 F2357.113
G1 X99.276 Y90.411 E.05503
; FEATURE: Inner wall
G1 F720
G1 X99.057 Y90.725 E.0081
G1 F1500
G1 X98.827 Y91.052 E.00847
G1 X96.105 Y94.94 E.10045
G1 X93.244 Y96.216 E.06631
G1 X93.021 Y96.37 E.00573
G1 X92.803 Y96.453 E.00495
G1 X92.559 Y96.482 E.0052
G1 X87.591 Y96.482 E.10514
G1 X88.777 Y97.845 E.03824
G1 X89.099 Y98.353 E.01273
G1 X89.272 Y98.751 E.00919
G1 X89.376 Y99.094 E.00758
G1 X89.448 Y99.487 E.00846
G1 X89.473 Y99.942 E.00965
G1 X89.451 Y100.299 E.00757
G1 X89.371 Y100.726 E.00921
G1 X89.266 Y101.069 E.00757
G1 X89.101 Y101.446 E.00872
G1 X88.785 Y101.947 E.01254
G1 X88.517 Y102.258 E.00869
G1 X88.061 Y102.65 E.01273
G1 X87.737 Y102.855 E.00811
G1 X87.362 Y103.034 E.00881
G1 X86.793 Y103.208 E.01258
G1 X86.386 Y103.269 E.00871
G1 X85.794 Y103.267 E.01254
G1 X85.211 Y103.164 E.01253
G1 X84.822 Y103.032 E.00869
G1 X84.46 Y102.859 E.00849
G1 X84.121 Y102.644 E.00849
G1 X83.809 Y102.391 E.00849
G1 X83.53 Y102.103 E.00849
G1 X83.284 Y101.779 E.00862
G1 X83.16 Y101.576 E.00502
G1 X82.999 Y101.257 E.00757
G1 X82.86 Y100.879 E.00852
G1 X82.767 Y100.492 E.00844
G1 X82.719 Y100.039 E.00965
G1 X82.721 Y99.681 E.00756
G1 X82.812 Y99.095 E.01256
G1 X82.934 Y98.703 E.00869
G1 X83.192 Y98.17 E.01253
G1 X83.417 Y97.838 E.00849
G1 X84.597 Y96.482 E.03805
G1 X79.631 Y96.482 E.10513
G1 X79.374 Y96.452 E.00547
G1 X79.178 Y96.373 E.00447
G1 X78.984 Y96.231 E.0051
G1 X78.884 Y96.119 E.00319
G1 X78.791 Y95.957 E.00394
G1 X78.743 Y95.812 E.00324
G1 X78.714 Y95.565 E.00527
G1 X78.714 Y77.619 E.37984
G1 X78.755 Y77.34 E.00596
G1 X78.863 Y77.113 E.00533
G1 X79.029 Y76.929 E.00523
G1 X79.16 Y76.837 E.00341
G1 X79.39 Y76.746 E.00523
G1 X79.552 Y76.723 E.00347
G1 X92.618 Y76.722 E.27656
G1 X92.8 Y76.747 E.00387
G1 X92.942 Y76.794 E.00318
G1 X93.119 Y76.889 E.00424
G1 X93.07 Y77.082 E.0042
G1 X80.058 Y77.082 E.2754
G1 X79.85 Y77.106 E.00445
G1 X79.556 Y77.223 E.00669
G1 X79.249 Y77.512 E.00893
G1 X79.112 Y77.807 E.00688
G1 X79.075 Y78.056 E.00533
G1 X79.075 Y95.155 E.36192
G1 X79.128 Y95.452 E.00639
G1 X79.311 Y95.77 E.00776
G1 X79.639 Y96.029 E.00884
G1 X80.022 Y96.12 E.00834
G1 X84.795 Y96.12 E.10103
; WIPE_START
M204 S6000
G1 X86.795 Y96.12 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X83.699 Y96.891 Z5.04 F18000
G1 Z4.64
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X79.607 Y96.891 E.08049
G1 X79.291 Y96.854 E.00625
G1 X78.97 Y96.728 E.00679
G1 X78.707 Y96.536 E.0064
G1 X78.558 Y96.368 E.0044
G1 X78.412 Y96.114 E.00577
G1 X78.341 Y95.901 E.00442
G1 X78.304 Y95.589 E.00619
G1 X78.304 Y77.607 E.35368
G1 X78.313 Y77.454 E.00301
G1 X78.36 Y77.228 E.00454
G1 X78.409 Y77.093 E.00283
G1 X78.518 Y76.891 E.00452
G1 X78.617 Y76.76 E.00322
G1 X78.765 Y76.614 E.0041
G1 X78.952 Y76.483 E.00447
G1 X79.099 Y76.411 E.00322
G1 X79.297 Y76.347 E.00409
G1 X79.522 Y76.313 E.00449
G1 X92.647 Y76.313 E.25814
G1 X92.893 Y76.347 E.00489
G1 X93.105 Y76.417 E.0044
G1 X93.303 Y76.524 E.00442
G1 X93.479 Y76.663 E.00442
G1 X93.629 Y76.831 E.00442
G1 X93.746 Y77.022 E.00442
G1 X93.829 Y77.231 E.00442
G1 X93.874 Y77.448 E.00436
G1 X93.884 Y88.791 E.2231
G1 X92.704 Y88.791 E.02321
G1 X92.704 Y77.491 E.22226
G1 X80.082 Y77.491 E.24827
G1 X79.95 Y77.506 E.00261
G1 X79.78 Y77.574 E.00362
G1 X79.587 Y77.756 E.00521
G1 X79.508 Y77.925 E.00367
G1 X79.484 Y78.086 E.00319
G1 X79.484 Y95.119 E.33504
G1 X79.518 Y95.31 E.00382
G1 X79.626 Y95.498 E.00425
G1 X79.821 Y95.652 E.00489
G1 X80.07 Y95.711 E.00503
G1 X92.292 Y95.711 E.2404
G1 X92.312 Y95.386 E.00639
G1 X92.349 Y95.21 E.00354
G1 X92.41 Y95.058 E.00322
G1 X92.545 Y94.855 E.0048
G1 X92.675 Y94.73 E.00354
G1 X92.923 Y94.584 E.00566
G1 X93.161 Y94.521 E.00485
G1 X93.445 Y94.523 E.00559
G1 X93.677 Y94.589 E.00475
G1 X93.833 Y94.671 E.00347
G1 X94.023 Y94.81 E.00462
G1 X95.622 Y94.286 E.0331
G1 X98.204 Y90.599 E.08853
G1 X98.433 Y90.272 E.00787
G1 F600
G1 X98.645 Y89.969 E.00726
; FEATURE: Overhang wall
; LINE_WIDTH: 0.45
G1 F2357.113
G1 X100.136 Y87.84 E.05503
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F600
G1 X100.348 Y87.537 E.00726
G1 F1500
G1 X100.647 Y87.111 E.01025
G1 X101.613 Y87.787 E.02321
G1 X101.314 Y88.214 E.01025
G1 F600
G1 X101.103 Y88.516 E.00726
; FEATURE: Overhang wall
; LINE_WIDTH: 0.45
G1 F2357.113
G1 X99.611 Y90.646 E.05503
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F600
G1 X99.4 Y90.948 E.00726
G1 F1500
G1 X99.17 Y91.276 E.00787
G1 X96.375 Y95.268 E.09584
G1 X93.445 Y96.575 E.06311
G1 X93.229 Y96.723 E.00516
G1 X93.102 Y96.786 E.0028
G1 X92.891 Y96.855 E.00436
G1 X92.582 Y96.891 E.00611
G1 X88.49 Y96.891 E.08049
G1 X89.098 Y97.59 E.01823
G1 X89.227 Y97.767 E.00431
G1 X89.46 Y98.159 E.00897
G1 X89.658 Y98.616 E.0098
G1 X89.775 Y98.997 E.00783
G1 X89.856 Y99.439 E.00884
G1 X89.883 Y99.943 E.00994
G1 X89.859 Y100.341 E.00783
G1 X89.767 Y100.831 E.0098
G1 X89.65 Y101.211 E.00783
G1 X89.468 Y101.627 E.00892
G1 X89.363 Y101.818 E.0043
G1 X89.111 Y102.195 E.00891
G1 X88.816 Y102.538 E.00891
G1 X88.659 Y102.691 E.00431
G1 X88.305 Y102.979 E.00897
G1 X87.93 Y103.216 E.00873
G1 X87.52 Y103.412 E.00895
G1 X87.261 Y103.505 E.0054
G1 X86.877 Y103.609 E.00783
G1 X86.429 Y103.676 E.00892
G1 X86.21 Y103.689 E.00431
G1 X85.757 Y103.676 E.00891
G1 X85.309 Y103.608 E.00891
G1 X85.097 Y103.557 E.0043
G1 X84.667 Y103.412 E.00891
G1 X84.261 Y103.218 E.00885
G1 X83.881 Y102.977 E.00885
G1 X83.532 Y102.693 E.00885
G1 X83.219 Y102.37 E.00885
G1 X82.946 Y102.01 E.00889
G1 X82.802 Y101.776 E.0054
G1 X82.623 Y101.421 E.00783
G1 X82.467 Y100.998 E.00886
G1 X82.363 Y100.561 E.00883
G1 X82.309 Y100.059 E.00994
G1 X82.312 Y99.661 E.00783
G1 X82.332 Y99.443 E.00431
G1 X82.414 Y98.997 E.00891
G1 X82.548 Y98.564 E.00891
G1 X82.631 Y98.362 E.0043
G1 X82.84 Y97.96 E.00891
G1 X83.093 Y97.588 E.00885
G1 X83.659 Y96.936 E.01698
; WIPE_START
M204 S6000
G1 X81.66 Y96.914 E-.38
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




G1 X79.521 Y96.249
G1 Z4.64
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.146278
G1 F1500
M204 S6000
G1 X79.319 Y96.131 E.00141
G1 X79.103 Y95.953 E.00168
G1 X78.942 Y95.626 E.00219
; WIPE_START
G1 X79.103 Y95.953 E-.15746
G1 X79.319 Y96.131 E-.12119
G1 X79.521 Y96.249 E-.10134
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X84.642 Y97.165 Z5.04 F18000
G1 Z4.64
G1 E.4 F1800
; LINE_WIDTH: 0.477113
G1 F1500
M204 S6000
G1 X84.461 Y97.319 E.00533
; LINE_WIDTH: 0.438408
G1 X84.254 Y97.496 E.00561
; LINE_WIDTH: 0.400624
G1 X84.08 Y97.673 E.00464
; LINE_WIDTH: 0.360597
G1 X83.722 Y98.073 E.00896
G1 X83.521 Y98.363 E.00591
G1 X83.291 Y98.837 E.00879
G1 X83.183 Y99.186 E.00611
G1 X83.117 Y99.546 E.00611
G1 X83.098 Y100.022 E.00796
G1 X83.161 Y100.522 E.00841
G1 X83.225 Y100.769 E.00426
G1 X83.349 Y101.105 E.00598
G1 X83.6 Y101.562 E.00872
G1 X83.822 Y101.852 E.0061
G1 X84.067 Y102.11 E.00594
G1 X84.441 Y102.401 E.00791
G1 X84.644 Y102.524 E.00398
G1 X84.965 Y102.678 E.00594
G1 X85.313 Y102.792 E.0061
G1 X85.614 Y102.857 E.00516
G1 X86.125 Y102.896 E.00855
G1 X86.647 Y102.848 E.00876
G1 X87.025 Y102.752 E.00651
G1 X87.347 Y102.624 E.00579
G1 X87.831 Y102.348 E.0093
G1 X88.21 Y102.023 E.00834
G1 X88.482 Y101.716 E.00684
G1 X88.757 Y101.271 E.00875
G1 X88.896 Y100.973 E.00548
G1 X88.999 Y100.631 E.00597
G1 X89.069 Y100.256 E.00638
G1 X89.093 Y99.886 E.00619
G1 X89.041 Y99.351 E.00898
G1 X88.915 Y98.879 E.00816
G1 X88.764 Y98.532 E.00633
G1 X88.472 Y98.08 E.00898
G1 X88.236 Y97.8 E.00613
; LINE_WIDTH: 0.382113
G1 X87.972 Y97.532 E.00668
; LINE_WIDTH: 0.425269
G1 X87.853 Y97.424 E.00321
; LINE_WIDTH: 0.473243
G1 X87.718 Y97.303 E.00404
G1 X87.369 Y97.375 E.00797
; WIPE_START
G1 X87.718 Y97.303 E-.25208
G1 X87.853 Y97.424 E-.12792
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X93.995 Y95.559 Z5.04 F18000
G1 Z4.64
G1 E.4 F1800
; LINE_WIDTH: 0.163576
G1 F1500
M204 S6000
G1 X94.335 Y95.428 E.00251
; LINE_WIDTH: 0.130045
G1 X94.676 Y95.297 E.0019
; LINE_WIDTH: 0.0965137
G1 X95.017 Y95.165 E.00129
; WIPE_START
G1 X94.676 Y95.297 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X89.606 Y89.592 Z5.04 F18000
G1 X78.949 Y77.601 Z5.04
G1 Z4.64
G1 E.4 F1800
; LINE_WIDTH: 0.0890845
G1 F1500
M204 S6000
G1 X78.988 Y77.484 E.00039
; LINE_WIDTH: 0.115428
G1 X79.026 Y77.366 E.00056
; LINE_WIDTH: 0.159465
G1 X79.215 Y77.149 E.00192
G1 X79.356 Y77.045 E.00117
; LINE_WIDTH: 0.122677
G1 X79.411 Y77.01 E.00032
; LINE_WIDTH: 0.0965309
G1 X79.588 Y76.956 E.00065
; CHANGE_LAYER
; Z_HEIGHT: 4.76
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F1500
G1 X79.411 Y77.01 E-.38
; WIPE_END
G1 E-.02 F1800
; layer num/total_layer_count: 47/57
; update layer progress
M73 L47
M991 S0 P46 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z5.04 I-.3 J1.179 P1  F18000
G1 X93.468 Y80.581 Z5.04
G1 Z4.76
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X93.475 Y88.382 E.1651
G1 X93.114 Y88.382 E.00764
G1 X93.114 Y77.128 E.23818
G1 X93.299 Y77.076 E.00407
G1 X93.379 Y77.207 E.00325
G1 X93.436 Y77.349 E.00324
G1 X93.465 Y77.49 E.00305
G1 X93.468 Y80.521 E.06416
; WIPE_START
M204 S6000
G1 X93.469 Y82.521 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X93.58 Y90.153 Z5.16 F18000
G1 X93.658 Y95.567 Z5.16
G1 Z4.76
G1 E.4 F1800
G1 F1500
M204 S500
G1 X93.115 Y95.809 E.01258
G1 X93.145 Y95.467 E.00727
G1 X93.166 Y95.414 E.0012
G1 X93.212 Y95.37 E.00135
G1 X93.295 Y95.347 E.00183
G1 X93.369 Y95.368 E.00162
G1 X93.609 Y95.533 E.00615
; WIPE_START
M204 S6000
G1 X93.115 Y95.809 E-.14481
G1 X93.145 Y95.467 E-.08804
G1 X93.166 Y95.414 E-.01457
G1 X93.212 Y95.37 E-.0163
G1 X93.295 Y95.347 E-.02219
G1 X93.369 Y95.368 E-.01965
G1 X93.609 Y95.533 E-.07445
; WIPE_END
M73 P84 R4
G1 E-.02 F1800
M204 S10000
G1 X86.097 Y96.887 Z5.16 F18000
G1 X84.86 Y97.11 Z5.16
G1 Z4.76
G1 E.4 F1800
M73 P84 R3
G1 F1500
M204 S500
G1 X84.753 Y96.949 E.0041
G1 X85.105 Y96.544 E.01135
G1 X87.084 Y96.544 E.04188
G1 X87.437 Y96.951 E.0114
G1 X87.314 Y97.115 E.00436
G1 X87.193 Y97.059 E.00282
G1 X86.699 Y96.915 E.01089
G1 X86.324 Y96.864 E.00801
G1 X85.974 Y96.858 E.00741
G1 X85.42 Y96.928 E.01182
G1 X84.917 Y97.092 E.0112
; WIPE_START
M204 S6000
G1 X84.753 Y96.949 E-.04131
G1 X85.105 Y96.544 E-.10189
G1 X86.351 Y96.544 E-.2368
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X83.477 Y99.922 Z5.16 F18000
G1 Z4.76
G1 E.4 F1800
G1 F1500
M204 S500
G1 X83.502 Y99.508 E.00879
G1 X83.622 Y99.035 E.01032
G1 X83.734 Y98.763 E.00623
G1 X83.891 Y98.482 E.00681
G1 X84.173 Y98.118 E.00975
G1 X84.515 Y97.809 E.00975
G1 X84.784 Y97.632 E.00683
G1 X85.073 Y97.487 E.00683
G1 X85.513 Y97.344 E.0098
G1 X85.997 Y97.283 E.01032
G1 X86.291 Y97.288 E.00623
G1 X86.61 Y97.331 E.00681
G1 X87.043 Y97.458 E.00955
G1 X87.336 Y97.593 E.00683
G1 X87.611 Y97.763 E.00683
G1 X87.964 Y98.063 E.0098
G1 X88.271 Y98.442 E.01032
G1 X88.421 Y98.695 E.00623
G1 X88.551 Y98.989 E.00681
G1 X88.674 Y99.433 E.00975
G1 X88.716 Y99.901 E.00995
G1 X88.674 Y100.369 E.00995
G1 X88.548 Y100.824 E.01
G1 X88.333 Y101.262 E.01032
G1 X88.167 Y101.505 E.00623
G1 X87.955 Y101.747 E.00681
G1 X87.602 Y102.046 E.00981
G1 X87.177 Y102.287 E.01032
G1 X86.903 Y102.393 E.00623
G1 X86.592 Y102.474 E.00681
G1 X86.143 Y102.521 E.00955
G1 X85.821 Y102.507 E.00683
G1 X85.502 Y102.454 E.00683
G1 X85.064 Y102.312 E.00975
G1 X84.65 Y102.089 E.00995
G1 X84.283 Y101.796 E.00995
G1 X83.972 Y101.44 E.01
G1 X83.725 Y101.019 E.01032
G1 X83.614 Y100.747 E.00623
G1 X83.529 Y100.437 E.00681
G1 X83.474 Y99.982 E.00969
M204 S250
G1 X83.886 Y99.947 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X83.908 Y99.571 E.00741
G1 X84.011 Y99.164 E.00825
G1 X84.103 Y98.942 E.00474
G1 X84.233 Y98.708 E.00526
G1 X84.474 Y98.397 E.00773
G1 X84.766 Y98.134 E.00773
G1 X84.989 Y97.987 E.00526
G1 X85.228 Y97.867 E.00526
G1 X85.603 Y97.745 E.00775
G1 X86.019 Y97.692 E.00825
G1 X86.26 Y97.697 E.00474
G1 X86.525 Y97.733 E.00526
G1 X86.899 Y97.842 E.00767
G1 X87.142 Y97.954 E.00526
G1 X87.369 Y98.095 E.00526
G1 X87.67 Y98.35 E.00775
G1 X87.934 Y98.676 E.00825
G1 X88.056 Y98.883 E.00474
G1 X88.165 Y99.127 E.00525
G1 X88.27 Y99.506 E.00774
G1 X88.305 Y99.901 E.0078
G1 X88.27 Y100.296 E.0078
G1 X88.164 Y100.679 E.00781
G1 X87.979 Y101.055 E.00825
G1 X87.843 Y101.253 E.00473
G1 X87.667 Y101.455 E.00526
G1 X87.366 Y101.709 E.00775
G1 X87.002 Y101.916 E.00825
G1 X86.777 Y102.003 E.00474
G1 X86.519 Y102.07 E.00525
G1 X86.131 Y102.111 E.00767
G1 X85.863 Y102.099 E.00526
G1 X85.599 Y102.055 E.00527
G1 X85.225 Y101.934 E.00773
G1 X84.877 Y101.746 E.00779
G1 X84.567 Y101.499 E.0078
G1 X84.305 Y101.2 E.00781
G1 X84.093 Y100.838 E.00825
G1 X84.003 Y100.615 E.00474
G1 X83.931 Y100.357 E.00526
G1 X83.889 Y100.006 E.00696
; WIPE_START
M204 S6000
G1 X83.908 Y99.571 E-.08287
G1 X84.011 Y99.164 E-.07967
G1 X84.103 Y98.942 E-.04574
G1 X84.233 Y98.708 E-.0508
G1 X84.474 Y98.397 E-.07469
G1 X84.655 Y98.234 E-.04623
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X84.855 Y96.12 Z5.16 F18000
G1 Z4.76
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X92.663 Y96.12 E.16527
G1 X92.739 Y95.337 E.01665
G1 X92.784 Y95.227 E.00252
G1 X92.851 Y95.128 E.00253
G1 X92.933 Y95.049 E.00241
G1 X93.065 Y94.97 E.00327
G1 X93.272 Y94.922 E.00449
G1 X93.375 Y94.929 E.00218
G1 X93.534 Y94.974 E.00349
G1 X93.961 Y95.261 E.0109
G1 X95.879 Y94.633 E.04271
G1 X100.747 Y87.68 E.17964
G1 X101.043 Y87.888 E.00765
G1 X96.105 Y94.94 E.18222
G1 X93.244 Y96.216 E.0663
G1 X93.021 Y96.37 E.00573
G1 X92.803 Y96.453 E.00495
G1 X92.559 Y96.482 E.0052
G1 X87.591 Y96.482 E.10514
G1 X88.771 Y97.838 E.03805
G1 X89.094 Y98.342 E.01267
G1 X89.196 Y98.561 E.00511
G1 X89.326 Y98.909 E.00786
G1 X89.451 Y99.499 E.01276
G1 X89.469 Y100.088 E.01248
G1 X89.413 Y100.536 E.00956
G1 X89.269 Y101.061 E.01153
G1 X89.101 Y101.446 E.00888
G1 X88.785 Y101.947 E.01254
G1 X88.382 Y102.389 E.01266
G1 X88.198 Y102.546 E.00512
G1 X87.737 Y102.855 E.01174
G1 X87.362 Y103.034 E.00881
G1 X87.143 Y103.113 E.00492
G1 X86.793 Y103.208 E.00767
G1 X86.386 Y103.269 E.00871
G1 X85.794 Y103.267 E.01254
G1 X85.211 Y103.164 E.01253
G1 X84.822 Y103.032 E.00869
G1 X84.462 Y102.86 E.00843
G1 X84.083 Y102.615 E.00956
G1 X83.672 Y102.258 E.01153
G1 X83.404 Y101.947 E.00868
G1 X83.181 Y101.613 E.0085
G1 X83 Y101.258 E.00843
G1 X82.847 Y100.833 E.00956
G1 X82.738 Y100.3 E.01153
G1 X82.715 Y99.89 E.00869
G1 X82.74 Y99.49 E.00849
G1 X82.812 Y99.095 E.0085
G1 X82.931 Y98.712 E.00849
G1 X83.094 Y98.345 E.0085
G1 X83.411 Y97.845 E.01254
G1 X84.597 Y96.482 E.03824
G1 X79.631 Y96.482 E.10513
G1 X79.302 Y96.43 E.00703
G1 X79.075 Y96.311 E.00543
G1 X78.973 Y96.22 E.00289
G1 X78.823 Y96.022 E.00525
G1 X78.743 Y95.812 E.00477
G1 X78.714 Y95.565 E.00527
G1 X78.714 Y77.619 E.37984
G1 X78.753 Y77.349 E.00577
G1 X78.855 Y77.125 E.0052
G1 X79.034 Y76.924 E.0057
G1 X79.154 Y76.841 E.00309
G1 X79.3 Y76.773 E.0034
G1 X79.551 Y76.723 E.00542
G1 X92.62 Y76.722 E.27662
G1 X92.799 Y76.747 E.00383
G1 X92.942 Y76.794 E.00319
G1 X93.119 Y76.889 E.00424
G1 X93.07 Y77.082 E.0042
G1 X80.058 Y77.082 E.2754
G1 X79.851 Y77.106 E.00442
G1 X79.563 Y77.218 E.00654
G1 X79.25 Y77.51 E.00906
G1 X79.112 Y77.807 E.00692
G1 X79.075 Y78.056 E.00533
G1 X79.075 Y95.155 E.36192
G1 X79.128 Y95.453 E.00639
G1 X79.316 Y95.778 E.00796
G1 X79.676 Y96.047 E.00952
G1 X80.031 Y96.12 E.00767
G1 X84.795 Y96.12 E.10083
; WIPE_START
M204 S6000
G1 X86.795 Y96.12 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X83.699 Y96.891 Z5.16 F18000
G1 Z4.76
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X79.607 Y96.891 E.08049
G1 X79.291 Y96.854 E.00625
G1 X79.156 Y96.814 E.00277
G1 X78.947 Y96.716 E.00454
G1 X78.671 Y96.5 E.00689
G1 X78.474 Y96.24 E.00643
G1 X78.412 Y96.114 E.00275
G1 X78.341 Y95.901 E.00442
G1 X78.304 Y95.589 E.00619
G1 X78.304 Y77.607 E.35368
G1 X78.313 Y77.454 E.00301
G1 X78.359 Y77.231 E.00448
G1 X78.443 Y77.019 E.00448
G1 X78.515 Y76.895 E.00283
G1 X78.658 Y76.715 E.00452
G1 X78.777 Y76.604 E.00319
G1 X78.949 Y76.485 E.00413
G1 X79.155 Y76.389 E.00447
G1 X79.311 Y76.343 E.00319
G1 X79.522 Y76.313 E.00418
G1 X92.648 Y76.313 E.25818
G1 X92.892 Y76.347 E.00485
G1 X93.105 Y76.417 E.00441
G1 X93.303 Y76.524 E.00442
G1 X93.479 Y76.663 E.00442
G1 X93.629 Y76.831 E.00442
G1 X93.746 Y77.022 E.00442
G1 X93.829 Y77.231 E.00442
G1 X93.874 Y77.448 E.00436
G1 X93.884 Y88.791 E.2231
G1 X92.704 Y88.791 E.02321
G1 X92.704 Y77.491 E.22226
G1 X80.082 Y77.491 E.24827
G1 X79.951 Y77.506 E.0026
G1 X79.785 Y77.571 E.0035
G1 X79.587 Y77.755 E.00532
G1 X79.508 Y77.925 E.00369
G1 X79.484 Y78.086 E.00319
G1 X79.484 Y95.119 E.33504
G1 X79.518 Y95.311 E.00382
G1 X79.628 Y95.501 E.00431
G1 X79.848 Y95.664 E.0054
G1 X80.073 Y95.711 E.00452
G1 X92.287 Y95.711 E.24025
G1 X92.319 Y95.336 E.0074
G1 X92.417 Y95.044 E.00605
G1 X92.545 Y94.855 E.0045
G1 X92.675 Y94.73 E.00354
G1 X92.923 Y94.584 E.00566
G1 X93.161 Y94.521 E.00485
G1 X93.445 Y94.523 E.00558
G1 X93.68 Y94.59 E.00481
G1 X93.777 Y94.637 E.00213
G1 X94.027 Y94.809 E.00595
G1 X95.622 Y94.286 E.03302
G1 X100.647 Y87.111 E.1723
G1 X101.613 Y87.787 E.02321
G1 X96.375 Y95.268 E.17961
G1 X93.445 Y96.574 E.0631
G1 X93.229 Y96.723 E.00516
G1 X93.102 Y96.786 E.00279
G1 X92.891 Y96.855 E.00436
G1 X92.582 Y96.891 E.00611
G1 X88.49 Y96.891 E.08049
G1 X89.096 Y97.588 E.01816
G1 X89.351 Y97.962 E.00891
G1 X89.574 Y98.402 E.00971
G1 X89.716 Y98.783 E.00798
G1 X89.774 Y98.994 E.00431
G1 X89.856 Y99.443 E.00897
G1 X89.877 Y99.661 E.0043
G1 X89.878 Y100.113 E.00889
G1 X89.816 Y100.61 E.00985
G1 X89.721 Y101.001 E.00792
G1 X89.651 Y101.209 E.00431
G1 X89.469 Y101.627 E.00897
G1 X89.363 Y101.818 E.00431
G1 X89.111 Y102.195 E.00891
G1 X88.816 Y102.538 E.00891
G1 X88.658 Y102.692 E.00434
G1 X88.449 Y102.869 E.00537
G1 X88.119 Y103.105 E.00798
G1 X87.93 Y103.216 E.00431
G1 X87.52 Y103.412 E.00895
G1 X87.266 Y103.504 E.00531
G1 X86.877 Y103.609 E.00792
G1 X86.429 Y103.676 E.00892
G1 X86.21 Y103.689 E.00431
G1 X85.757 Y103.676 E.00891
G1 X85.309 Y103.608 E.00891
G1 X85.097 Y103.557 E.0043
G1 X84.667 Y103.412 E.00891
G1 X84.262 Y103.218 E.00883
G1 X83.841 Y102.947 E.00985
G1 X83.53 Y102.691 E.00792
G1 X83.373 Y102.538 E.00431
G1 X83.078 Y102.195 E.00891
G1 X82.827 Y101.821 E.00885
G1 X82.623 Y101.421 E.00883
G1 X82.454 Y100.95 E.00985
G1 X82.362 Y100.558 E.00792
G1 X82.33 Y100.341 E.00431
G1 X82.305 Y99.889 E.00891
G1 X82.333 Y99.44 E.00885
G1 X82.414 Y98.997 E.00885
G1 X82.547 Y98.567 E.00885
G1 X82.73 Y98.156 E.00885
G1 X82.962 Y97.767 E.00891
G1 X83.091 Y97.59 E.0043
G1 X83.659 Y96.936 E.01705
; WIPE_START
M204 S6000
G1 X81.66 Y96.914 E-.38
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




G1 X79.531 Y96.256
G1 Z4.76
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.148692
G1 F1500
M204 S6000
G1 X79.288 Y96.111 E.00174
G1 X79.12 Y95.967 E.00136
G1 X79.042 Y95.848 E.00087
G1 X78.942 Y95.627 E.00149
; WIPE_START
G1 X79.042 Y95.848 E-.10383
G1 X79.12 Y95.967 E-.0608
G1 X79.288 Y96.111 E-.09447
G1 X79.531 Y96.256 E-.1209
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X84.642 Y97.165 Z5.16 F18000
G1 Z4.76
G1 E.4 F1800
; LINE_WIDTH: 0.477106
G1 F1500
M204 S6000
G1 X84.461 Y97.319 E.00533
; LINE_WIDTH: 0.438417
G1 X84.254 Y97.496 E.00561
; LINE_WIDTH: 0.40064
G1 X84.08 Y97.673 E.00464
; LINE_WIDTH: 0.359819
G1 X83.716 Y98.08 E.0091
G1 X83.432 Y98.523 E.00877
G1 X83.288 Y98.846 E.0059
G1 X83.186 Y99.187 E.00593
G1 X83.119 Y99.536 E.00593
G1 X83.097 Y99.976 E.00734
G1 X83.159 Y100.497 E.00875
G1 X83.255 Y100.859 E.00623
G1 X83.392 Y101.197 E.00608
G1 X83.675 Y101.673 E.00923
G1 X83.947 Y101.992 E.00699
G1 X84.31 Y102.307 E.00801
G1 X84.65 Y102.524 E.00672
G1 X84.965 Y102.679 E.00586
G1 X85.401 Y102.816 E.00762
M73 P85 R3
G1 X85.827 Y102.888 E.00721
G1 X86.352 Y102.885 E.00874
G1 X86.715 Y102.835 E.00612
G1 X87.214 Y102.682 E.0087
G1 X87.552 Y102.517 E.00625
G1 X87.828 Y102.344 E.00543
G1 X88.21 Y102.023 E.00832
G1 X88.482 Y101.716 E.00683
G1 X88.757 Y101.273 E.00869
G1 X88.903 Y100.943 E.00601
G1 X89.047 Y100.422 E.00902
G1 X89.092 Y99.886 E.00896
G1 X89.044 Y99.38 E.00847
G1 X88.961 Y99.03 E.006
G1 X88.756 Y98.516 E.00922
G1 X88.465 Y98.071 E.00886
G1 X88.224 Y97.786 E.00621
; LINE_WIDTH: 0.378418
G1 X88.046 Y97.611 E.0044
; LINE_WIDTH: 0.419152
G1 X87.842 Y97.411 E.0056
; LINE_WIDTH: 0.468112
G1 X87.544 Y97.162 E.00858
; WIPE_START
G1 X87.842 Y97.411 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X94.012 Y95.553 Z5.16 F18000
G1 Z4.76
G1 E.4 F1800
; LINE_WIDTH: 0.153738
G1 F1500
M204 S6000
G1 X94.514 Y95.359 E.00344
; LINE_WIDTH: 0.104412
G1 X95.017 Y95.165 E.00211
; WIPE_START
G1 X94.514 Y95.359 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X89.483 Y89.619 Z5.16 F18000
G1 X78.949 Y77.601 Z5.16
G1 Z4.76
G1 E.4 F1800
; LINE_WIDTH: 0.0994848
G1 F1500
M204 S6000
G1 X79.004 Y77.423 E.00069
; LINE_WIDTH: 0.12486
G1 X79.039 Y77.344 E.00043
; LINE_WIDTH: 0.162838
G1 X79.171 Y77.191 E.00138
G1 X79.296 Y77.084 E.00113
; LINE_WIDTH: 0.144794
G1 X79.39 Y77.021 E.00067
; LINE_WIDTH: 0.0961264
G1 X79.586 Y76.956 E.00073
; CHANGE_LAYER
; Z_HEIGHT: 4.88
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F1500
G1 X79.39 Y77.021 E-.38
; WIPE_END
G1 E-.02 F1800
; layer num/total_layer_count: 48/57
; update layer progress
M73 L48
M991 S0 P47 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z5.16 I-.298 J1.18 P1  F18000
G1 X93.468 Y80.581 Z5.16
G1 Z4.88
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X93.475 Y88.382 E.1651
G1 X93.114 Y88.382 E.00764
G1 X93.114 Y77.128 E.23818
G1 X93.299 Y77.076 E.00407
G1 X93.379 Y77.207 E.00325
G1 X93.436 Y77.349 E.00324
G1 X93.465 Y77.49 E.00305
G1 X93.468 Y80.522 E.06416
; WIPE_START
M204 S6000
G1 X93.469 Y82.522 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X93.584 Y90.153 Z5.28 F18000
G1 X93.665 Y95.564 Z5.28
G1 Z4.88
G1 E.4 F1800
G1 F1500
M204 S500
G1 X93.122 Y95.806 E.0126
G1 X93.14 Y95.498 E.00653
G1 X93.166 Y95.414 E.00186
G1 X93.212 Y95.37 E.00135
G1 X93.32 Y95.341 E.00236
G1 X93.615 Y95.531 E.00743
; WIPE_START
M204 S6000
G1 X93.122 Y95.806 E-.14421
G1 X93.14 Y95.498 E-.07886
G1 X93.166 Y95.414 E-.02248
G1 X93.212 Y95.37 E-.01625
G1 X93.32 Y95.341 E-.02852
G1 X93.615 Y95.531 E-.08968
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X86.103 Y96.886 Z5.28 F18000
G1 X84.86 Y97.11 Z5.28
G1 Z4.88
G1 E.4 F1800
G1 F1500
M204 S500
G1 X84.753 Y96.949 E.0041
G1 X85.105 Y96.544 E.01135
G1 X87.084 Y96.544 E.04188
G1 X87.437 Y96.951 E.01141
G1 X87.314 Y97.115 E.00436
G1 X87.193 Y97.06 E.00282
G1 X86.699 Y96.915 E.0109
G1 X86.324 Y96.864 E.00801
G1 X85.971 Y96.858 E.00746
G1 X85.42 Y96.928 E.01177
G1 X84.917 Y97.092 E.01119
; WIPE_START
M204 S6000
G1 X84.753 Y96.949 E-.04131
G1 X85.105 Y96.544 E-.10189
G1 X86.351 Y96.544 E-.2368
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X83.477 Y99.933 Z5.28 F18000
G1 Z4.88
G1 E.4 F1800
G1 F1500
M204 S500
G1 X83.502 Y99.508 E.00901
G1 X83.621 Y99.037 E.01027
G1 X83.734 Y98.763 E.00628
G1 X83.891 Y98.482 E.00681
G1 X84.172 Y98.118 E.00975
G1 X84.515 Y97.809 E.00975
G1 X84.784 Y97.632 E.00683
G1 X85.073 Y97.487 E.00683
G1 X85.513 Y97.344 E.0098
G1 X85.994 Y97.283 E.01027
G1 X86.291 Y97.288 E.00629
G1 X86.61 Y97.331 E.00681
G1 X87.043 Y97.458 E.00955
G1 X87.336 Y97.593 E.00683
G1 X87.611 Y97.763 E.00683
G1 X87.964 Y98.062 E.0098
G1 X88.269 Y98.439 E.01027
G1 X88.421 Y98.695 E.00628
G1 X88.551 Y98.989 E.00681
G1 X88.674 Y99.433 E.00975
G1 X88.715 Y99.892 E.00975
G1 X88.696 Y100.214 E.00683
G1 X88.638 Y100.531 E.00683
G1 X88.49 Y100.967 E.00975
G1 X88.261 Y101.378 E.00995
G1 X87.962 Y101.741 E.00995
G1 X87.602 Y102.046 E.01
G1 X87.18 Y102.286 E.01027
G1 X86.903 Y102.393 E.00628
G1 X86.592 Y102.474 E.00681
G1 X86.134 Y102.522 E.00975
G1 X85.663 Y102.487 E.01
G1 X85.194 Y102.362 E.01027
G1 X84.921 Y102.244 E.00628
G1 X84.643 Y102.083 E.00681
G1 X84.283 Y101.796 E.00975
G1 X83.973 Y101.442 E.00995
G1 X83.732 Y101.039 E.00995
G1 X83.57 Y100.607 E.00975
G1 X83.503 Y100.291 E.00683
G1 X83.476 Y99.992 E.00635
M204 S250
G1 X83.885 Y99.957 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X83.908 Y99.571 E.00762
G1 X84.01 Y99.166 E.0082
G1 X84.103 Y98.941 E.00479
G1 X84.233 Y98.708 E.00525
G1 X84.474 Y98.397 E.00773
G1 X84.766 Y98.134 E.00774
G1 X84.989 Y97.987 E.00526
G1 X85.228 Y97.867 E.00526
G1 X85.603 Y97.745 E.00775
G1 X86.017 Y97.692 E.0082
G1 X86.26 Y97.697 E.00478
G1 X86.525 Y97.733 E.00526
G1 X86.899 Y97.842 E.00767
G1 X87.142 Y97.954 E.00526
G1 X87.369 Y98.095 E.00526
G1 X87.67 Y98.35 E.00775
G1 X87.932 Y98.674 E.0082
G1 X88.056 Y98.883 E.00478
G1 X88.165 Y99.127 E.00526
G1 X88.27 Y99.506 E.00773
G1 X88.305 Y99.898 E.00773
G1 X88.289 Y100.165 E.00526
G1 X88.241 Y100.428 E.00526
G1 X88.114 Y100.8 E.00773
G1 X87.921 Y101.146 E.0078
G1 X87.669 Y101.452 E.0078
G1 X87.366 Y101.709 E.00781
G1 X87.004 Y101.915 E.0082
G1 X86.777 Y102.003 E.00478
G1 X86.519 Y102.07 E.00525
G1 X86.127 Y102.111 E.00774
G1 X85.731 Y102.082 E.00781
G1 X85.329 Y101.974 E.0082
G1 X85.105 Y101.878 E.00478
G1 X84.874 Y101.744 E.00526
G1 X84.567 Y101.499 E.00773
G1 X84.306 Y101.2 E.0078
G1 X84.103 Y100.86 E.00779
G1 X83.964 Y100.492 E.00774
G1 X83.909 Y100.23 E.00526
G1 X83.89 Y100.017 E.00422
; WIPE_START
M204 S6000
G1 X83.908 Y99.571 E-.08486
G1 X84.01 Y99.166 E-.07921
G1 X84.103 Y98.941 E-.04623
G1 X84.233 Y98.708 E-.05074
G1 X84.474 Y98.397 E-.07471
G1 X84.647 Y98.241 E-.04426
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X84.855 Y96.12 Z5.28 F18000
G1 Z4.88
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X92.678 Y96.12 E.16557
G1 X92.718 Y95.441 E.0144
G1 X92.742 Y95.331 E.00238
G1 X92.784 Y95.227 E.00238
G1 X92.851 Y95.128 E.00253
G1 X92.933 Y95.05 E.0024
G1 X93.065 Y94.97 E.00327
G1 X93.272 Y94.922 E.0045
G1 X93.493 Y94.957 E.00474
G1 X93.972 Y95.257 E.01196
G1 X95.879 Y94.633 E.04247
G1 X100.747 Y87.68 E.17964
G1 X101.043 Y87.888 E.00765
G1 X96.105 Y94.94 E.18222
G1 X93.236 Y96.22 E.06649
G1 X93.08 Y96.334 E.0041
G1 X92.938 Y96.409 E.00339
G1 X92.803 Y96.453 E.00301
G1 X92.559 Y96.482 E.0052
G1 X87.591 Y96.482 E.10514
G1 X88.777 Y97.845 E.03824
G1 X88.884 Y97.992 E.00386
G1 X89.098 Y98.35 E.00882
G1 X89.326 Y98.909 E.01277
G1 X89.451 Y99.499 E.01276
G1 X89.469 Y100.088 E.01248
G1 X89.414 Y100.531 E.00946
G1 X89.266 Y101.07 E.01182
G1 X89.009 Y101.611 E.01268
G1 X88.758 Y101.98 E.00945
G1 X88.382 Y102.39 E.01176
G1 X88.201 Y102.543 E.00502
G1 X87.737 Y102.855 E.01183
G1 X87.188 Y103.099 E.01273
G1 X86.792 Y103.208 E.00869
G1 X86.386 Y103.269 E.00868
G1 X85.794 Y103.267 E.01254
G1 X85.211 Y103.164 E.01254
G1 X84.822 Y103.032 E.00869
G1 X84.46 Y102.859 E.00849
G1 X84.121 Y102.644 E.00849
G1 X83.809 Y102.391 E.00849
G1 X83.532 Y102.104 E.00844
G1 X83.265 Y101.747 E.00946
G1 X83.002 Y101.265 E.01162
G1 X82.86 Y100.879 E.00869
G1 X82.766 Y100.489 E.0085
G1 X82.72 Y100.091 E.00849
G1 X82.738 Y99.499 E.01254
G1 X82.812 Y99.095 E.00869
G1 X82.934 Y98.703 E.00869
G1 X83.192 Y98.17 E.01253
G1 X83.417 Y97.838 E.00849
G1 X84.597 Y96.482 E.03805
G1 X79.631 Y96.482 E.10512
G1 X79.392 Y96.454 E.00508
G1 X79.119 Y96.34 E.00626
G1 X78.991 Y96.239 E.00346
G1 X78.892 Y96.129 E.00312
G1 X78.791 Y95.957 E.00423
G1 X78.743 Y95.812 E.00324
G1 X78.714 Y95.565 E.00527
G1 X78.714 Y77.621 E.37979
G1 X78.754 Y77.344 E.00594
G1 X78.86 Y77.119 E.00525
G1 X79.033 Y76.925 E.00551
G1 X79.154 Y76.841 E.00312
G1 X79.3 Y76.773 E.00341
G1 X79.551 Y76.723 E.00542
G1 X92.622 Y76.722 E.27665
G1 X92.799 Y76.747 E.00379
G1 X92.942 Y76.794 E.00319
G1 X93.119 Y76.889 E.00424
G1 X93.07 Y77.082 E.0042
G1 X80.058 Y77.082 E.2754
G1 X79.851 Y77.106 E.00443
G1 X79.563 Y77.219 E.00655
G1 X79.25 Y77.51 E.00905
G1 X79.112 Y77.807 E.00692
G1 X79.075 Y78.056 E.00533
G1 X79.075 Y95.155 E.36192
G1 X79.128 Y95.453 E.0064
G1 X79.312 Y95.772 E.00781
G1 X79.646 Y96.033 E.00896
G1 X80.024 Y96.12 E.00821
G1 X84.795 Y96.12 E.10099
; WIPE_START
M204 S6000
G1 X86.795 Y96.12 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X83.699 Y96.891 Z5.28 F18000
G1 Z4.88
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X79.607 Y96.891 E.08049
G1 X79.297 Y96.855 E.00613
G1 X79.01 Y96.75 E.00601
G1 X78.888 Y96.68 E.00277
G1 X78.709 Y96.538 E.00449
G1 X78.568 Y96.381 E.00416
G1 X78.477 Y96.245 E.00322
G1 X78.412 Y96.114 E.00287
G1 X78.341 Y95.901 E.00442
G1 X78.304 Y95.589 E.00619
G1 X78.304 Y77.608 E.35366
G1 X78.316 Y77.438 E.00334
G1 X78.36 Y77.229 E.0042
G1 X78.416 Y77.079 E.00317
G1 X78.517 Y76.893 E.00416
G1 X78.658 Y76.714 E.00447
G1 X78.776 Y76.605 E.00316
G1 X78.949 Y76.485 E.00416
G1 X79.156 Y76.388 E.00447
G1 X79.31 Y76.344 E.00315
G1 X79.522 Y76.313 E.00422
G1 X92.65 Y76.313 E.25821
G1 X92.892 Y76.347 E.00482
G1 X93.105 Y76.417 E.0044
G1 X93.303 Y76.524 E.00442
G1 X93.479 Y76.663 E.00442
G1 X93.629 Y76.831 E.00442
G1 X93.746 Y77.022 E.00442
G1 X93.829 Y77.231 E.00442
G1 X93.874 Y77.448 E.00436
G1 X93.884 Y88.791 E.2231
G1 X92.704 Y88.791 E.02321
G1 X92.704 Y77.491 E.22226
G1 X80.082 Y77.491 E.24827
G1 X79.951 Y77.506 E.0026
G1 X79.784 Y77.571 E.00351
G1 X79.587 Y77.755 E.00531
G1 X79.508 Y77.925 E.00369
G1 X79.484 Y78.086 E.00319
G1 X79.484 Y95.119 E.33504
G1 X79.518 Y95.311 E.00382
G1 X79.627 Y95.499 E.00427
G1 X79.826 Y95.654 E.00498
G1 X80.07 Y95.711 E.00493
G1 X92.292 Y95.711 E.24039
G1 X92.312 Y95.386 E.00639
G1 X92.349 Y95.211 E.00353
G1 X92.417 Y95.044 E.00354
G1 X92.545 Y94.855 E.0045
G1 X92.674 Y94.73 E.00354
G1 X92.922 Y94.584 E.00566
G1 X93.161 Y94.521 E.00485
G1 X93.448 Y94.524 E.00565
G1 X93.722 Y94.609 E.00565
G1 X94.03 Y94.807 E.00721
G1 X95.622 Y94.286 E.03294
G1 X100.647 Y87.111 E.1723
G1 X101.613 Y87.787 E.02321
G1 X96.375 Y95.268 E.17961
G1 X93.442 Y96.576 E.06316
G1 X93.298 Y96.682 E.00353
G1 X93.099 Y96.787 E.00442
G1 X92.891 Y96.855 E.0043
G1 X92.582 Y96.891 E.00611
G1 X88.49 Y96.891 E.08049
G1 X89.098 Y97.59 E.01823
G1 X89.226 Y97.767 E.0043
G1 X89.46 Y98.158 E.00895
G1 X89.572 Y98.398 E.00522
G1 X89.716 Y98.783 E.00807
G1 X89.774 Y98.994 E.00432
G1 X89.856 Y99.443 E.00897
G1 X89.877 Y99.661 E.0043
G1 X89.878 Y100.113 E.00889
G1 X89.817 Y100.605 E.00976
G1 X89.721 Y101.001 E.00801
G1 X89.568 Y101.417 E.00873
G1 X89.362 Y101.82 E.0089
G1 X89.082 Y102.23 E.00976
G1 X88.816 Y102.538 E.00801
G1 X88.453 Y102.866 E.00962
G1 X88.119 Y103.105 E.00807
G1 X87.93 Y103.216 E.00432
G1 X87.519 Y103.413 E.00897
G1 X87.313 Y103.489 E.00431
G1 X86.877 Y103.609 E.00891
G1 X86.429 Y103.676 E.00891
G1 X86.21 Y103.689 E.00431
G1 X85.757 Y103.676 E.00891
G1 X85.309 Y103.608 E.00891
G1 X85.097 Y103.557 E.0043
G1 X84.667 Y103.412 E.00891
G1 X84.261 Y103.218 E.00885
G1 X83.881 Y102.977 E.00885
G1 X83.532 Y102.693 E.00885
G1 X83.22 Y102.37 E.00883
G1 X82.923 Y101.973 E.00976
G1 X82.718 Y101.621 E.00801
G1 X82.624 Y101.423 E.00431
G1 X82.467 Y100.998 E.00892
M73 P86 R3
G1 X82.363 Y100.56 E.00885
G1 X82.311 Y100.114 E.00885
G1 X82.312 Y99.661 E.00891
G1 X82.332 Y99.443 E.0043
G1 X82.414 Y98.997 E.00891
G1 X82.548 Y98.564 E.00891
G1 X82.631 Y98.362 E.0043
G1 X82.84 Y97.96 E.00891
G1 X83.093 Y97.588 E.00885
G1 X83.659 Y96.936 E.01698
; WIPE_START
M204 S6000
G1 X81.66 Y96.914 E-.38
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




G1 X79.527 Y96.246
G1 Z4.88
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.12417
G1 F1500
M204 S6000
G1 X79.417 Y96.185 E.00062
; LINE_WIDTH: 0.149101
G1 X79.307 Y96.124 E.00077
G1 X79.11 Y95.962 E.00157
G1 X78.942 Y95.627 E.00231
; WIPE_START
G1 X79.11 Y95.962 E-.18876
G1 X79.307 Y96.124 E-.12799
G1 X79.417 Y96.185 E-.06324
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X84.642 Y97.165 Z5.28 F18000
G1 Z4.88
G1 E.4 F1800
; LINE_WIDTH: 0.477114
G1 F1500
M204 S6000
G1 X84.461 Y97.319 E.00533
; LINE_WIDTH: 0.438428
G1 X84.254 Y97.496 E.00561
; LINE_WIDTH: 0.400651
G1 X84.08 Y97.673 E.00464
; LINE_WIDTH: 0.359887
G1 X83.722 Y98.073 E.00894
G1 X83.521 Y98.363 E.00589
G1 X83.291 Y98.837 E.00877
G1 X83.132 Y99.435 E.01032
G1 X83.099 Y99.988 E.00923
G1 X83.131 Y100.358 E.00619
G1 X83.224 Y100.767 E.007
G1 X83.387 Y101.189 E.00754
G1 X83.584 Y101.535 E.00664
G1 X83.825 Y101.855 E.00668
G1 X84.067 Y102.11 E.00586
G1 X84.441 Y102.401 E.0079
G1 X84.645 Y102.525 E.00397
G1 X84.965 Y102.678 E.00593
G1 X85.313 Y102.792 E.00609
G1 X85.615 Y102.857 E.00515
G1 X86.125 Y102.896 E.00852
G1 X86.647 Y102.848 E.00874
G1 X87.029 Y102.75 E.00657
G1 X87.351 Y102.618 E.0058
G1 X87.803 Y102.361 E.00867
G1 X88.121 Y102.109 E.00676
G1 X88.455 Y101.744 E.00825
G1 X88.679 Y101.415 E.00663
G1 X88.848 Y101.092 E.00607
G1 X89 Y100.638 E.00799
G1 X89.07 Y100.249 E.00659
G1 X89.092 Y99.874 E.00626
G1 X89.039 Y99.352 E.00874
G1 X88.961 Y99.03 E.00552
G1 X88.761 Y98.527 E.00903
G1 X88.473 Y98.08 E.00887
G1 X88.224 Y97.786 E.00642
; LINE_WIDTH: 0.378492
G1 X88.046 Y97.61 E.0044
; LINE_WIDTH: 0.419228
G1 X87.842 Y97.411 E.00559
; LINE_WIDTH: 0.468149
G1 X87.544 Y97.162 E.00857
; WIPE_START
G1 X87.842 Y97.411 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X94.029 Y95.546 Z5.28 F18000
G1 Z4.88
G1 E.4 F1800
; LINE_WIDTH: 0.152252
G1 F1500
M204 S6000
G1 X94.523 Y95.356 E.00334
; LINE_WIDTH: 0.103916
G1 X95.017 Y95.165 E.00206
; WIPE_START
G1 X94.523 Y95.356 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X89.49 Y89.618 Z5.28 F18000
G1 X78.95 Y77.6 Z5.28
G1 Z4.88
G1 E.4 F1800
; LINE_WIDTH: 0.0886571
G1 F1500
M204 S6000
G1 X78.989 Y77.481 E.00039
; LINE_WIDTH: 0.114251
G1 X79.029 Y77.362 E.00055
; LINE_WIDTH: 0.128119
G1 X79.032 Y77.355 E.00004
; LINE_WIDTH: 0.160258
G1 X79.217 Y77.147 E.00187
G1 X79.356 Y77.046 E.00116
; LINE_WIDTH: 0.122191
G1 X79.419 Y77.006 E.00036
; LINE_WIDTH: 0.0955523
G1 X79.587 Y76.956 E.00061
; CHANGE_LAYER
; Z_HEIGHT: 5
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F1500
G1 X79.419 Y77.006 E-.38
; WIPE_END
G1 E-.02 F1800
; layer num/total_layer_count: 49/57
; update layer progress
M73 L49
M991 S0 P48 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z5.28 I-.3 J1.179 P1  F18000
G1 X93.468 Y80.581 Z5.28
G1 Z5
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X93.475 Y88.382 E.1651
G1 X93.114 Y88.382 E.00764
G1 X93.114 Y77.128 E.23818
G1 X93.299 Y77.076 E.00407
G1 X93.379 Y77.207 E.00325
G1 X93.436 Y77.349 E.00324
G1 X93.465 Y77.49 E.00305
G1 X93.468 Y80.521 E.06416
; WIPE_START
M204 S6000
G1 X93.469 Y82.521 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X93.585 Y90.153 Z5.4 F18000
G1 X93.666 Y95.563 Z5.4
G1 Z5
G1 E.4 F1800
G1 F1500
M204 S500
G1 X93.122 Y95.806 E.01263
G1 X93.14 Y95.498 E.00654
G1 X93.166 Y95.414 E.00186
G1 X93.212 Y95.37 E.00135
G1 X93.318 Y95.341 E.00232
G1 X93.616 Y95.531 E.00748
; WIPE_START
M204 S6000
G1 X93.122 Y95.806 E-.14436
G1 X93.14 Y95.498 E-.07882
G1 X93.166 Y95.414 E-.02245
G1 X93.212 Y95.37 E-.01623
G1 X93.318 Y95.341 E-.028
G1 X93.616 Y95.531 E-.09014
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X86.105 Y96.886 Z5.4 F18000
G1 X84.86 Y97.11 Z5.4
G1 Z5
G1 E.4 F1800
G1 F1500
M204 S500
G1 X84.753 Y96.949 E.0041
G1 X85.105 Y96.544 E.01135
G1 X87.084 Y96.544 E.04188
G1 X87.437 Y96.951 E.0114
G1 X87.314 Y97.115 E.00436
G1 X87.193 Y97.059 E.00282
G1 X86.699 Y96.915 E.01089
G1 X86.324 Y96.864 E.00801
G1 X85.968 Y96.858 E.00752
G1 X85.419 Y96.929 E.01171
G1 X84.917 Y97.092 E.01118
; WIPE_START
M204 S6000
G1 X84.753 Y96.949 E-.04131
G1 X85.105 Y96.544 E-.10188
G1 X86.351 Y96.544 E-.23681
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X83.478 Y100.017 Z5.4 F18000
G1 Z5
G1 E.4 F1800
G1 F1500
M204 S500
G1 X83.474 Y99.979 E.00079
G1 X83.502 Y99.508 E.00999
G1 X83.62 Y99.04 E.01022
G1 X83.734 Y98.763 E.00634
G1 X83.891 Y98.482 E.00681
G1 X84.167 Y98.125 E.00956
G1 X84.399 Y97.903 E.00681
G1 X84.639 Y97.722 E.00634
G1 X85.062 Y97.491 E.01021
G1 X85.513 Y97.344 E.01003
G1 X85.992 Y97.283 E.01022
G1 X86.291 Y97.288 E.00634
G1 X86.61 Y97.331 E.00681
G1 X87.043 Y97.458 E.00955
G1 X87.336 Y97.593 E.00683
G1 X87.611 Y97.763 E.00683
G1 X87.962 Y98.061 E.00975
G1 X88.255 Y98.417 E.00975
G1 X88.42 Y98.694 E.00683
G1 X88.551 Y98.989 E.00683
G1 X88.674 Y99.433 E.00975
G1 X88.716 Y99.901 E.00995
G1 X88.674 Y100.369 E.00995
G1 X88.548 Y100.824 E.00999
G1 X88.336 Y101.258 E.01022
G1 X88.167 Y101.504 E.00634
G1 X87.961 Y101.74 E.00661
G1 X87.729 Y101.949 E.00661
G1 X87.484 Y102.122 E.00634
G1 X87.054 Y102.341 E.01022
G1 X86.601 Y102.473 E.00999
G1 X86.131 Y102.523 E.00999
G1 X85.651 Y102.483 E.01021
G1 X85.359 Y102.416 E.00634
G1 X85.056 Y102.307 E.00681
G1 X84.65 Y102.089 E.00975
G1 X84.283 Y101.796 E.00995
G1 X83.972 Y101.44 E.00999
G1 X83.727 Y101.024 E.01021
G1 X83.614 Y100.747 E.00634
G1 X83.529 Y100.437 E.00681
G1 X83.485 Y100.076 E.00769
M204 S250
G1 X83.885 Y99.967 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X83.908 Y99.571 E.00781
G1 X84.009 Y99.169 E.00815
G1 X84.103 Y98.942 E.00483
G1 X84.233 Y98.708 E.00526
G1 X84.472 Y98.4 E.00767
G1 X84.665 Y98.215 E.00525
G1 X84.861 Y98.067 E.00483
G1 X85.225 Y97.868 E.00815
G1 X85.603 Y97.745 E.00782
G1 X86.014 Y97.692 E.00815
G1 X86.26 Y97.697 E.00483
G1 X86.525 Y97.733 E.00526
G1 X86.899 Y97.842 E.00767
G1 X87.142 Y97.954 E.00526
G1 X87.369 Y98.095 E.00526
G1 X87.669 Y98.349 E.00774
G1 X87.919 Y98.653 E.00773
G1 X88.056 Y98.883 E.00526
G1 X88.165 Y99.127 E.00526
G1 X88.27 Y99.506 E.00773
G1 X88.305 Y99.901 E.0078
G1 X88.27 Y100.296 E.0078
G1 X88.164 Y100.678 E.00781
G1 X87.982 Y101.051 E.00816
G1 X87.843 Y101.253 E.00483
G1 X87.669 Y101.452 E.0052
G1 X87.473 Y101.629 E.00519
G1 X87.272 Y101.771 E.00483
G1 X86.903 Y101.959 E.00815
G1 X86.522 Y102.07 E.00781
G1 X86.127 Y102.112 E.00781
G1 X85.714 Y102.078 E.00815
G1 X85.474 Y102.022 E.00483
G1 X85.223 Y101.932 E.00526
G1 X84.877 Y101.746 E.00773
G1 X84.567 Y101.499 E.0078
G1 X84.305 Y101.2 E.00781
G1 X84.095 Y100.843 E.00815
G1 X84.003 Y100.615 E.00484
G1 X83.931 Y100.357 E.00525
G1 X83.892 Y100.027 E.00655
; WIPE_START
M204 S6000
G1 X83.908 Y99.571 E-.08669
G1 X84.009 Y99.169 E-.07876
G1 X84.103 Y98.942 E-.04668
G1 X84.233 Y98.708 E-.05078
G1 X84.472 Y98.4 E-.07412
G1 X84.635 Y98.243 E-.04298
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X84.855 Y96.12 Z5.4 F18000
G1 Z5
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X92.678 Y96.12 E.16558
G1 X92.718 Y95.441 E.0144
G1 X92.742 Y95.331 E.00238
G1 X92.784 Y95.227 E.00238
G1 X92.851 Y95.128 E.00252
G1 X92.939 Y95.044 E.00258
G1 X93.072 Y94.968 E.00324
G1 X93.272 Y94.922 E.00435
G1 X93.444 Y94.941 E.00366
G1 X93.53 Y94.974 E.00196
G1 X93.975 Y95.256 E.01114
G1 X95.879 Y94.633 E.04242
G1 X100.747 Y87.68 E.17964
G1 X101.043 Y87.888 E.00765
G1 X96.105 Y94.94 E.18222
G1 X93.236 Y96.22 E.0665
G1 X93.08 Y96.334 E.0041
G1 X92.938 Y96.409 E.00339
G1 X92.803 Y96.453 E.00301
G1 X92.559 Y96.482 E.0052
G1 X87.591 Y96.482 E.10514
G1 X88.776 Y97.843 E.03818
G1 X89.099 Y98.352 E.01277
G1 X89.326 Y98.91 E.01275
G1 X89.451 Y99.499 E.01274
G1 X89.469 Y100.088 E.01249
G1 X89.415 Y100.527 E.00936
G1 X89.269 Y101.061 E.01172
G1 X89.013 Y101.606 E.01273
G1 X88.785 Y101.947 E.00868
G1 X88.517 Y102.258 E.00869
G1 X88.205 Y102.54 E.00891
G1 X87.903 Y102.756 E.00786
G1 X87.543 Y102.955 E.00871
G1 X86.978 Y103.164 E.01273
G1 X86.386 Y103.269 E.01273
G1 X85.794 Y103.267 E.01254
G1 X85.213 Y103.164 E.01249
G1 X84.786 Y103.016 E.00956
G1 X84.452 Y102.855 E.00785
G1 X83.961 Y102.522 E.01256
G1 X83.666 Y102.251 E.00849
G1 X83.404 Y101.947 E.00849
G1 X83.181 Y101.613 E.00849
G1 X82.999 Y101.258 E.00845
G1 X82.849 Y100.842 E.00936
G1 X82.738 Y100.3 E.01172
G1 X82.715 Y99.89 E.00869
G1 X82.74 Y99.49 E.00849
G1 X82.812 Y99.095 E.0085
G1 X82.93 Y98.714 E.00845
G1 X83.113 Y98.311 E.00936
G1 X83.411 Y97.845 E.01171
G1 X84.597 Y96.482 E.03824
G1 X79.63 Y96.482 E.10513
G1 X79.383 Y96.453 E.00527
G1 X79.238 Y96.405 E.00324
G1 X79.076 Y96.311 E.00396
G1 X78.971 Y96.218 E.00296
G1 X78.823 Y96.023 E.00519
G1 X78.743 Y95.812 E.00478
G1 X78.714 Y95.565 E.00527
G1 X78.714 Y77.621 E.37979
G1 X78.754 Y77.341 E.00599
G1 X78.86 Y77.118 E.00522
G1 X79.032 Y76.926 E.00546
G1 X79.154 Y76.841 E.00315
G1 X79.3 Y76.773 E.00341
G1 X79.551 Y76.723 E.00541
G1 X92.623 Y76.722 E.27668
G1 X92.799 Y76.747 E.00376
G1 X92.942 Y76.794 E.0032
G1 X93.119 Y76.889 E.00424
G1 X93.07 Y77.082 E.0042
G1 X80.058 Y77.082 E.2754
G1 X79.851 Y77.106 E.00443
G1 X79.562 Y77.219 E.00656
G1 X79.25 Y77.51 E.00903
G1 X79.112 Y77.807 E.00692
G1 X79.075 Y78.056 E.00533
G1 X79.075 Y95.155 E.36192
G1 X79.128 Y95.453 E.00639
G1 X79.316 Y95.778 E.00796
G1 X79.676 Y96.047 E.00951
G1 X80.031 Y96.12 E.00767
G1 X84.795 Y96.12 E.10083
; WIPE_START
M204 S6000
G1 X86.795 Y96.12 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X83.699 Y96.891 Z5.4 F18000
G1 Z5
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X79.607 Y96.891 E.08049
G1 X79.294 Y96.854 E.00619
M73 P87 R3
G1 X79.081 Y96.784 E.00442
G1 X78.95 Y96.718 E.00289
G1 X78.827 Y96.637 E.0029
G1 X78.669 Y96.498 E.00413
G1 X78.474 Y96.24 E.00636
G1 X78.412 Y96.114 E.00275
G1 X78.341 Y95.901 E.00442
G1 X78.304 Y95.589 E.00619
G1 X78.304 Y77.608 E.35366
G1 X78.315 Y77.44 E.00331
G1 X78.36 Y77.229 E.00425
G1 X78.409 Y77.093 E.00284
G1 X78.517 Y76.893 E.00448
G1 X78.658 Y76.714 E.00447
G1 X78.774 Y76.606 E.00313
G1 X78.949 Y76.485 E.00419
G1 X79.156 Y76.388 E.00448
G1 X79.308 Y76.344 E.00312
G1 X79.522 Y76.313 E.00425
G1 X92.652 Y76.313 E.25824
G1 X92.892 Y76.347 E.00478
G1 X93.105 Y76.417 E.0044
G1 X93.303 Y76.524 E.00442
G1 X93.479 Y76.663 E.00442
G1 X93.628 Y76.831 E.00442
G1 X93.746 Y77.022 E.00442
G1 X93.829 Y77.231 E.00442
G1 X93.874 Y77.448 E.00436
G1 X93.884 Y88.791 E.2231
G1 X92.704 Y88.791 E.02321
G1 X92.704 Y77.491 E.22226
G1 X80.082 Y77.491 E.24827
G1 X79.951 Y77.506 E.0026
G1 X79.784 Y77.572 E.00352
G1 X79.587 Y77.755 E.0053
G1 X79.508 Y77.925 E.00369
G1 X79.484 Y78.086 E.00319
G1 X79.484 Y95.119 E.33504
G1 X79.518 Y95.311 E.00382
G1 X79.628 Y95.5 E.00431
G1 X79.848 Y95.664 E.0054
G1 X80.073 Y95.711 E.00452
G1 X92.292 Y95.711 E.24034
G1 X92.312 Y95.386 E.00639
G1 X92.349 Y95.211 E.00353
G1 X92.417 Y95.044 E.00354
G1 X92.545 Y94.855 E.0045
G1 X92.676 Y94.728 E.0036
G1 X92.925 Y94.584 E.00565
G1 X93.161 Y94.521 E.00481
G1 X93.451 Y94.524 E.00571
G1 X93.714 Y94.606 E.00542
G1 X94.031 Y94.807 E.00738
G1 X95.622 Y94.286 E.03293
G1 X100.647 Y87.111 E.1723
G1 X101.613 Y87.787 E.02321
G1 X96.375 Y95.268 E.17961
G1 X93.442 Y96.576 E.06316
G1 X93.298 Y96.682 E.00353
G1 X93.099 Y96.787 E.00443
G1 X92.891 Y96.855 E.00431
G1 X92.582 Y96.891 E.00611
G1 X88.49 Y96.891 E.08049
G1 X89.098 Y97.589 E.01821
G1 X89.248 Y97.801 E.00512
G1 X89.46 Y98.159 E.00817
G1 X89.555 Y98.356 E.00431
G1 X89.716 Y98.783 E.00897
G1 X89.774 Y98.994 E.00431
G1 X89.856 Y99.443 E.00897
G1 X89.877 Y99.661 E.0043
G1 X89.878 Y100.113 E.00889
G1 X89.818 Y100.601 E.00967
G1 X89.721 Y101.001 E.0081
G1 X89.651 Y101.209 E.00431
G1 X89.469 Y101.627 E.00897
G1 X89.363 Y101.819 E.00431
G1 X89.111 Y102.195 E.00891
G1 X88.816 Y102.538 E.00891
G1 X88.657 Y102.693 E.00435
G1 X88.457 Y102.863 E.00518
G1 X88.121 Y103.103 E.0081
G1 X87.725 Y103.322 E.00892
G1 X87.524 Y103.411 E.0043
G1 X87.092 Y103.557 E.00897
G1 X86.88 Y103.608 E.0043
G1 X86.429 Y103.676 E.00897
G1 X86.21 Y103.689 E.00431
G1 X85.757 Y103.676 E.00891
G1 X85.309 Y103.608 E.00891
G1 X85.097 Y103.557 E.00429
G1 X84.63 Y103.395 E.00973
G1 X84.259 Y103.217 E.0081
G1 X84.07 Y103.105 E.00431
G1 X83.702 Y102.84 E.00891
G1 X83.371 Y102.536 E.00885
G1 X83.078 Y102.195 E.00885
G1 X82.827 Y101.821 E.00885
G1 X82.623 Y101.421 E.00884
G1 X82.456 Y100.959 E.00967
G1 X82.362 Y100.558 E.00811
G1 X82.33 Y100.341 E.0043
G1 X82.305 Y99.889 E.00891
G1 X82.333 Y99.44 E.00885
G1 X82.414 Y98.997 E.00885
G1 X82.547 Y98.568 E.00884
G1 X82.75 Y98.121 E.00966
G1 X82.962 Y97.767 E.0081
G1 X83.091 Y97.59 E.00431
G1 X83.659 Y96.936 E.01705
; WIPE_START
M204 S6000
G1 X81.66 Y96.914 E-.38
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




G1 X79.481 Y96.245
G1 Z5
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.148509
G1 F1500
M204 S6000
G1 X79.12 Y95.967 E.00279
G1 X79.042 Y95.848 E.00087
G1 X78.942 Y95.627 E.00149
; WIPE_START
G1 X79.042 Y95.848 E-.10996
G1 X79.12 Y95.967 E-.06432
G1 X79.481 Y96.245 E-.20573
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X84.643 Y97.167 Z5.4 F18000
G1 Z5
G1 E.4 F1800
; LINE_WIDTH: 0.477231
G1 F1500
M204 S6000
G1 X84.393 Y97.37 E.00726
; LINE_WIDTH: 0.442315
G1 X84.272 Y97.483 E.00342
; LINE_WIDTH: 0.405874
G1 X84.137 Y97.61 E.00353
; LINE_WIDTH: 0.359955
G1 X83.879 Y97.882 E.00625
G1 X83.572 Y98.286 E.00846
G1 X83.45 Y98.491 E.00397
G1 X83.287 Y98.849 E.00657
G1 X83.186 Y99.187 E.00587
G1 X83.119 Y99.536 E.00594
G1 X83.098 Y99.976 E.00734
G1 X83.156 Y100.498 E.00875
G1 X83.262 Y100.877 E.00656
G1 X83.394 Y101.202 E.00586
G1 X83.708 Y101.716 E.01003
G1 X84.012 Y102.058 E.00763
G1 X84.43 Y102.395 E.00897
G1 X84.913 Y102.657 E.00916
G1 X85.263 Y102.776 E.00615
G1 X85.604 Y102.858 E.00586
G1 X86.121 Y102.9 E.00864
G1 X86.725 Y102.833 E.01014
G1 X87.24 Y102.673 E.00899
G1 X87.7 Y102.435 E.00864
G1 X87.969 Y102.242 E.00552
G1 X88.224 Y102.013 E.00572
G1 X88.472 Y101.729 E.00629
G1 X88.684 Y101.412 E.00636
G1 X88.907 Y100.944 E.00865
G1 X89.042 Y100.457 E.00842
G1 X89.086 Y100.065 E.00657
G1 X89.084 Y99.704 E.00603
G1 X89 Y99.17 E.00901
G1 X88.908 Y98.874 E.00517
G1 X88.762 Y98.528 E.00626
G1 X88.471 Y98.077 E.00895
G1 X88.222 Y97.784 E.00641
; LINE_WIDTH: 0.378827
G1 X88.045 Y97.609 E.00438
; LINE_WIDTH: 0.419328
G1 X87.842 Y97.411 E.00557
; LINE_WIDTH: 0.468122
G1 X87.544 Y97.162 E.00857
; WIPE_START
G1 X87.842 Y97.411 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X94.033 Y95.545 Z5.4 F18000
G1 Z5
G1 E.4 F1800
; LINE_WIDTH: 0.151941
G1 F1500
M204 S6000
G1 X94.525 Y95.355 E.00332
; LINE_WIDTH: 0.103812
G1 X95.017 Y95.165 E.00205
; WIPE_START
G1 X94.525 Y95.355 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X89.491 Y89.617 Z5.4 F18000
G1 X78.949 Y77.6 Z5.4
G1 Z5
G1 E.4 F1800
; LINE_WIDTH: 0.0892548
G1 F1500
M204 S6000
G1 X78.988 Y77.483 E.00039
; LINE_WIDTH: 0.115505
G1 X79.026 Y77.366 E.00055
; LINE_WIDTH: 0.159348
G1 X79.216 Y77.148 E.00192
G1 X79.356 Y77.046 E.00115
; LINE_WIDTH: 0.122385
G1 X79.419 Y77.006 E.00036
; LINE_WIDTH: 0.0956885
G1 X79.587 Y76.956 E.00061
; CHANGE_LAYER
; Z_HEIGHT: 5.12
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F1500
G1 X79.419 Y77.006 E-.38
; WIPE_END
G1 E-.02 F1800
; layer num/total_layer_count: 50/57
; update layer progress
M73 L50
M991 S0 P49 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z5.4 I-.3 J1.179 P1  F18000
G1 X93.468 Y80.582 Z5.4
G1 Z5.12
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X93.475 Y88.382 E.1651
G1 X93.114 Y88.382 E.00764
G1 X93.114 Y77.128 E.23818
G1 X93.299 Y77.076 E.00407
G1 X93.379 Y77.207 E.00325
G1 X93.436 Y77.349 E.00324
G1 X93.465 Y77.49 E.00306
G1 X93.468 Y80.522 E.06416
; WIPE_START
M204 S6000
G1 X93.469 Y82.522 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X93.584 Y90.153 Z5.52 F18000
G1 X93.665 Y95.564 Z5.52
G1 Z5.12
G1 E.4 F1800
G1 F1500
M204 S500
G1 X93.115 Y95.809 E.01275
G1 X93.145 Y95.466 E.00729
G1 X93.204 Y95.372 E.00235
G1 X93.32 Y95.341 E.00254
G1 X93.615 Y95.531 E.00743
; WIPE_START
M204 S6000
G1 X93.115 Y95.809 E-.14499
G1 X93.145 Y95.466 E-.08736
G1 X93.204 Y95.372 E-.02818
G1 X93.32 Y95.341 E-.0304
G1 X93.615 Y95.531 E-.08908
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X86.103 Y96.886 Z5.52 F18000
G1 X84.86 Y97.11 Z5.52
G1 Z5.12
G1 E.4 F1800
G1 F1500
M204 S500
G1 X84.753 Y96.949 E.0041
G1 X85.105 Y96.544 E.01135
G1 X87.084 Y96.544 E.04188
G1 X87.437 Y96.951 E.0114
G1 X87.314 Y97.115 E.00436
G1 X87.193 Y97.059 E.00282
G1 X86.699 Y96.915 E.0109
G1 X86.323 Y96.864 E.00802
G1 X85.965 Y96.858 E.00758
G1 X85.419 Y96.929 E.01165
G1 X84.917 Y97.092 E.01118
; WIPE_START
M204 S6000
G1 X84.753 Y96.949 E-.04131
G1 X85.105 Y96.544 E-.10188
G1 X86.351 Y96.544 E-.23681
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X83.48 Y100.027 Z5.52 F18000
G1 Z5.12
G1 E.4 F1800
G1 F1500
M204 S500
G1 X83.474 Y99.979 E.00101
G1 X83.502 Y99.51 E.00995
G1 X83.611 Y99.063 E.00975
G1 X83.733 Y98.764 E.00683
G1 X83.891 Y98.482 E.00683
G1 X84.172 Y98.118 E.00975
G1 X84.515 Y97.809 E.00975
G1 X84.784 Y97.632 E.00683
G1 X85.073 Y97.487 E.00683
G1 X85.513 Y97.344 E.00979
G1 X85.989 Y97.283 E.01016
G1 X86.291 Y97.288 E.00639
M73 P88 R3
G1 X86.61 Y97.331 E.00682
G1 X87.043 Y97.458 E.00955
G1 X87.336 Y97.593 E.00683
G1 X87.611 Y97.763 E.00683
G1 X87.962 Y98.061 E.00975
G1 X88.261 Y98.424 E.00995
G1 X88.489 Y98.835 E.00995
G1 X88.638 Y99.27 E.00975
G1 X88.696 Y99.588 E.00683
G1 X88.715 Y99.901 E.00663
G1 X88.696 Y100.214 E.00663
G1 X88.638 Y100.531 E.00683
G1 X88.489 Y100.967 E.00975
G1 X88.261 Y101.378 E.00995
G1 X87.962 Y101.741 E.00995
G1 X87.61 Y102.039 E.00975
G1 X87.336 Y102.208 E.00683
G1 X87.043 Y102.344 E.00683
G1 X86.601 Y102.473 E.00975
G1 X86.143 Y102.521 E.00975
G1 X85.821 Y102.507 E.00683
G1 X85.502 Y102.454 E.00683
G1 X85.064 Y102.312 E.00975
G1 X84.65 Y102.089 E.00995
G1 X84.283 Y101.796 E.00995
G1 X83.972 Y101.441 E.00999
G1 X83.728 Y101.027 E.01016
G1 X83.614 Y100.747 E.0064
G1 X83.529 Y100.437 E.00681
G1 X83.487 Y100.086 E.00747
M204 S250
G1 X83.886 Y99.978 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X83.885 Y99.967 E.00021
G1 X83.908 Y99.571 E.0078
G1 X84.001 Y99.189 E.00773
G1 X84.103 Y98.942 E.00526
G1 X84.233 Y98.708 E.00526
G1 X84.474 Y98.397 E.00773
G1 X84.766 Y98.134 E.00774
G1 X84.989 Y97.987 E.00526
G1 X85.229 Y97.867 E.00526
G1 X85.603 Y97.745 E.00775
G1 X86.012 Y97.692 E.0081
G1 X86.26 Y97.697 E.00488
G1 X86.525 Y97.733 E.00526
G1 X86.899 Y97.842 E.00767
G1 X87.142 Y97.954 E.00526
G1 X87.369 Y98.095 E.00526
G1 X87.669 Y98.349 E.00774
G1 X87.921 Y98.655 E.00779
G1 X88.114 Y99.002 E.0078
G1 X88.241 Y99.374 E.00773
G1 X88.289 Y99.637 E.00526
G1 X88.305 Y99.901 E.0052
G1 X88.289 Y100.165 E.0052
G1 X88.241 Y100.428 E.00526
G1 X88.114 Y100.8 E.00773
G1 X87.921 Y101.146 E.0078
G1 X87.669 Y101.452 E.00779
G1 X87.369 Y101.707 E.00774
G1 X87.142 Y101.847 E.00526
G1 X86.899 Y101.96 E.00526
G1 X86.522 Y102.07 E.00773
G1 X86.131 Y102.111 E.00774
G1 X85.863 Y102.099 E.00526
M73 P88 R2
G1 X85.599 Y102.055 E.00527
G1 X85.225 Y101.934 E.00773
G1 X84.876 Y101.746 E.00779
G1 X84.567 Y101.499 E.0078
G1 X84.305 Y101.2 E.00781
G1 X84.096 Y100.845 E.00811
G1 X84.003 Y100.615 E.00488
G1 X83.931 Y100.357 E.00526
G1 X83.893 Y100.037 E.00634
; WIPE_START
M204 S6000
G1 X83.885 Y99.967 E-.01346
G1 X83.908 Y99.571 E-.07533
G1 X84.001 Y99.189 E-.07469
G1 X84.103 Y98.942 E-.05081
G1 X84.233 Y98.708 E-.05086
G1 X84.474 Y98.397 E-.07469
G1 X84.631 Y98.256 E-.04016
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X84.855 Y96.12 Z5.52 F18000
G1 Z5.12
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X92.662 Y96.12 E.16525
G1 X92.739 Y95.338 E.01663
G1 X92.81 Y95.184 E.00359
G1 X92.887 Y95.089 E.00257
G1 X93.063 Y94.97 E.00449
G1 X93.272 Y94.922 E.00455
G1 X93.443 Y94.941 E.00363
G1 X93.539 Y94.978 E.00218
G1 X93.972 Y95.257 E.01091
G1 X95.879 Y94.633 E.04247
G1 X100.747 Y87.68 E.17964
G1 X101.043 Y87.888 E.00765
G1 X96.105 Y94.94 E.18222
G1 X93.236 Y96.22 E.06649
G1 X93.08 Y96.334 E.0041
G1 X92.938 Y96.409 E.00339
G1 X92.803 Y96.453 E.00301
G1 X92.559 Y96.482 E.0052
G1 X87.591 Y96.482 E.10514
G1 X88.771 Y97.838 E.03805
G1 X89.095 Y98.345 E.01273
G1 X89.326 Y98.91 E.01293
G1 X89.451 Y99.499 E.01274
G1 X89.469 Y100.089 E.01249
G1 X89.415 Y100.523 E.00926
G1 X89.267 Y101.068 E.01195
G1 X89.009 Y101.613 E.01277
G1 X88.785 Y101.947 E.00851
G1 X88.517 Y102.258 E.00869
G1 X88.061 Y102.65 E.01274
G1 X87.543 Y102.955 E.01272
G1 X87.155 Y103.109 E.00882
G1 X86.793 Y103.208 E.00795
G1 X86.386 Y103.269 E.0087
G1 X85.794 Y103.267 E.01254
G1 X85.213 Y103.164 E.01249
G1 X84.79 Y103.018 E.00946
G1 X84.294 Y102.762 E.01181
G1 X83.961 Y102.522 E.00869
G1 X83.666 Y102.251 E.00849
G1 X83.404 Y101.947 E.00849
G1 X83.181 Y101.613 E.00849
G1 X82.998 Y101.256 E.00849
G1 X82.859 Y100.879 E.0085
G1 X82.766 Y100.489 E.0085
G1 X82.72 Y100.091 E.00849
G1 X82.738 Y99.499 E.01254
G1 X82.812 Y99.095 E.00869
G1 X82.93 Y98.713 E.00845
G1 X83.111 Y98.315 E.00926
G1 X83.411 Y97.845 E.01181
G1 X84.597 Y96.482 E.03824
G1 X79.631 Y96.482 E.10512
G1 X79.383 Y96.453 E.00527
G1 X79.238 Y96.405 E.00324
G1 X79.076 Y96.311 E.00397
G1 X78.97 Y96.217 E.00299
G1 X78.824 Y96.023 E.00515
G1 X78.743 Y95.812 E.00478
G1 X78.714 Y95.565 E.00527
G1 X78.714 Y77.619 E.37984
G1 X78.755 Y77.34 E.00597
G1 X78.864 Y77.112 E.00535
G1 X79.029 Y76.929 E.00522
G1 X79.248 Y76.793 E.00545
G1 X79.391 Y76.746 E.00319
G1 X79.552 Y76.723 E.00345
G1 X92.625 Y76.722 E.27669
G1 X92.799 Y76.747 E.00372
G1 X92.942 Y76.794 E.0032
G1 X93.119 Y76.889 E.00424
G1 X93.07 Y77.082 E.0042
G1 X80.058 Y77.082 E.2754
G1 X79.85 Y77.106 E.00443
G1 X79.561 Y77.22 E.00657
G1 X79.25 Y77.51 E.00902
G1 X79.112 Y77.807 E.00692
G1 X79.075 Y78.056 E.00533
G1 X79.075 Y95.155 E.36192
G1 X79.128 Y95.453 E.0064
G1 X79.311 Y95.77 E.00775
G1 X79.639 Y96.029 E.00885
G1 X80.022 Y96.12 E.00834
G1 X84.795 Y96.12 E.10102
; WIPE_START
M204 S6000
G1 X86.795 Y96.12 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X83.699 Y96.891 Z5.52 F18000
G1 Z5.12
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X79.607 Y96.891 E.08049
G1 X79.294 Y96.854 E.00619
G1 X79.081 Y96.784 E.00442
G1 X78.95 Y96.718 E.00289
G1 X78.826 Y96.637 E.0029
G1 X78.668 Y96.497 E.00416
G1 X78.475 Y96.24 E.00633
G1 X78.412 Y96.114 E.00276
G1 X78.341 Y95.901 E.00442
G1 X78.304 Y95.589 E.00619
G1 X78.304 Y77.607 E.35368
G1 X78.313 Y77.454 E.00301
G1 X78.36 Y77.228 E.00454
G1 X78.409 Y77.093 E.00283
G1 X78.518 Y76.89 E.00453
G1 X78.613 Y76.765 E.00309
G1 X78.765 Y76.614 E.00422
G1 X78.952 Y76.483 E.00447
G1 X79.093 Y76.413 E.00309
G1 X79.297 Y76.346 E.00423
G1 X79.522 Y76.313 E.00449
G1 X92.653 Y76.313 E.25827
G1 X92.892 Y76.347 E.00475
G1 X93.105 Y76.417 E.00441
G1 X93.303 Y76.524 E.00442
G1 X93.479 Y76.663 E.00442
G1 X93.628 Y76.831 E.00442
G1 X93.746 Y77.022 E.00442
G1 X93.829 Y77.231 E.00442
G1 X93.874 Y77.448 E.00436
G1 X93.884 Y88.791 E.2231
G1 X92.704 Y88.791 E.02321
G1 X92.704 Y77.491 E.22226
G1 X80.082 Y77.491 E.24827
G1 X79.951 Y77.506 E.0026
G1 X79.784 Y77.572 E.00353
G1 X79.587 Y77.755 E.00529
G1 X79.508 Y77.925 E.00369
G1 X79.484 Y78.086 E.00319
G1 X79.484 Y95.119 E.33504
G1 X79.518 Y95.311 E.00382
G1 X79.626 Y95.498 E.00425
G1 X79.821 Y95.652 E.00489
G1 X80.07 Y95.711 E.00503
G1 X92.287 Y95.711 E.2403
G1 X92.32 Y95.332 E.00748
G1 X92.417 Y95.044 E.00597
G1 X92.589 Y94.807 E.00577
G1 X92.672 Y94.732 E.00219
G1 X92.922 Y94.585 E.00571
G1 X93.161 Y94.521 E.00487
G1 X93.451 Y94.524 E.00571
G1 X93.725 Y94.611 E.00565
G1 X94.03 Y94.807 E.00714
G1 X95.622 Y94.286 E.03294
G1 X100.647 Y87.111 E.1723
G1 X101.613 Y87.787 E.02321
G1 X96.375 Y95.268 E.17961
G1 X93.442 Y96.576 E.06316
G1 X93.298 Y96.682 E.00353
G1 X93.099 Y96.787 E.00442
G1 X92.891 Y96.855 E.00431
G1 X92.582 Y96.891 E.00611
G1 X88.49 Y96.891 E.08049
G1 X89.096 Y97.588 E.01817
G1 X89.351 Y97.962 E.00891
G1 X89.555 Y98.356 E.00873
G1 X89.716 Y98.783 E.00897
G1 X89.774 Y98.994 E.00431
G1 X89.856 Y99.443 E.00897
G1 X89.877 Y99.661 E.0043
G1 X89.878 Y100.113 E.0089
G1 X89.819 Y100.596 E.00957
G1 X89.721 Y101.001 E.00819
G1 X89.552 Y101.45 E.00944
G1 X89.362 Y101.821 E.00819
G1 X89.111 Y102.195 E.00886
G1 X88.816 Y102.538 E.00891
G1 X88.659 Y102.691 E.0043
G1 X88.305 Y102.979 E.00898
G1 X88.124 Y103.102 E.0043
G1 X87.725 Y103.322 E.00897
G1 X87.279 Y103.5 E.00944
G1 X86.877 Y103.609 E.0082
G1 X86.429 Y103.676 E.00892
G1 X86.21 Y103.689 E.00431
G1 X85.757 Y103.676 E.00891
G1 X85.309 Y103.608 E.00891
G1 X85.097 Y103.557 E.00429
G1 X84.634 Y103.397 E.00964
G1 X84.259 Y103.216 E.0082
G1 X84.07 Y103.105 E.00431
G1 X83.703 Y102.84 E.00891
G1 X83.371 Y102.536 E.00885
G1 X83.078 Y102.195 E.00885
G1 X82.827 Y101.821 E.00885
G1 X82.623 Y101.42 E.00885
G1 X82.467 Y100.998 E.00885
G1 X82.363 Y100.56 E.00885
G1 X82.311 Y100.114 E.00885
G1 X82.312 Y99.661 E.00891
G1 X82.332 Y99.443 E.0043
G1 X82.414 Y98.997 E.00891
G1 X82.547 Y98.568 E.00884
G1 X82.748 Y98.125 E.00957
G1 X82.962 Y97.767 E.0082
G1 X83.091 Y97.59 E.00431
G1 X83.659 Y96.936 E.01705
; WIPE_START
M204 S6000
G1 X81.66 Y96.914 E-.38
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




G1 X79.474 Y96.244
G1 Z5.12
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.148515
G1 F1500
M204 S6000
G1 X79.176 Y96.023 E.00227
G1 X79.113 Y95.955 E.00057
G1 X79.042 Y95.848 E.00079
G1 X78.942 Y95.627 E.00149
; WIPE_START
G1 X79.042 Y95.848 E-.11067
G1 X79.113 Y95.955 E-.05842
G1 X79.176 Y96.023 E-.04221
G1 X79.474 Y96.244 E-.16869
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X84.642 Y97.165 Z5.52 F18000
G1 Z5.12
G1 E.4 F1800
; LINE_WIDTH: 0.477119
G1 F1500
M204 S6000
G1 X84.461 Y97.319 E.00533
; LINE_WIDTH: 0.438439
G1 X84.254 Y97.496 E.00561
; LINE_WIDTH: 0.400653
G1 X84.08 Y97.673 E.00465
; LINE_WIDTH: 0.359514
G1 X83.716 Y98.08 E.0091
G1 X83.448 Y98.494 E.00821
G1 X83.256 Y98.934 E.00799
G1 X83.132 Y99.439 E.00866
G1 X83.098 Y100.005 E.00944
G1 X83.143 Y100.423 E.00699
G1 X83.225 Y100.769 E.00593
G1 X83.348 Y101.103 E.00593
G1 X83.513 Y101.418 E.00592
G1 X83.708 Y101.716 E.00592
G1 X84.033 Y102.078 E.00811
G1 X84.454 Y102.412 E.00895
G1 X84.929 Y102.665 E.00895
G1 X85.401 Y102.817 E.00826
G1 X85.791 Y102.884 E.00659
G1 X86.142 Y102.9 E.00585
G1 X86.689 Y102.841 E.00916
G1 X87.037 Y102.745 E.00602
G1 X87.374 Y102.612 E.00602
G1 X87.837 Y102.343 E.00892
G1 X88.242 Y101.996 E.00889
G1 X88.479 Y101.714 E.00613
G1 X88.676 Y101.42 E.0059
G1 X88.836 Y101.106 E.00587
G1 X89.004 Y100.614 E.00866
G1 X89.087 Y100.066 E.00923
G1 X89.086 Y99.704 E.00603
G1 X89.008 Y99.187 E.0087
G1 X88.836 Y98.696 E.00867
G1 X88.754 Y98.521 E.00321
G1 X88.561 Y98.201 E.00622
G1 X88.222 Y97.784 E.00896
; LINE_WIDTH: 0.378831
G1 X88.045 Y97.609 E.00438
; LINE_WIDTH: 0.419338
G1 X87.842 Y97.411 E.00557
; LINE_WIDTH: 0.468141
G1 X87.544 Y97.162 E.00857
; WIPE_START
G1 X87.842 Y97.411 E-.38
; WIPE_END
M73 P89 R2
G1 E-.02 F1800
M204 S10000
G1 X94.029 Y95.546 Z5.52 F18000
G1 Z5.12
G1 E.4 F1800
; LINE_WIDTH: 0.152256
G1 F1500
M204 S6000
G1 X94.523 Y95.356 E.00334
; LINE_WIDTH: 0.103917
G1 X95.017 Y95.165 E.00206
; WIPE_START
G1 X94.523 Y95.356 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X89.49 Y89.618 Z5.52 F18000
G1 X78.949 Y77.602 Z5.52
G1 Z5.12
G1 E.4 F1800
; LINE_WIDTH: 0.0891064
G1 F1500
M204 S6000
G1 X78.988 Y77.484 E.00039
; LINE_WIDTH: 0.115496
G1 X79.027 Y77.366 E.00056
; LINE_WIDTH: 0.159532
G1 X79.216 Y77.149 E.00192
G1 X79.36 Y77.043 E.00119
; LINE_WIDTH: 0.121932
G1 X79.418 Y77.007 E.00033
; LINE_WIDTH: 0.0954833
G1 X79.586 Y76.956 E.00061
; CHANGE_LAYER
; Z_HEIGHT: 5.24
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F1500
G1 X79.418 Y77.007 E-.38
; WIPE_END
G1 E-.02 F1800
; layer num/total_layer_count: 51/57
; update layer progress
M73 L51
M991 S0 P50 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z5.52 I-.3 J1.179 P1  F18000
G1 X93.468 Y80.581 Z5.52
G1 Z5.24
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X93.475 Y88.382 E.1651
G1 X93.114 Y88.382 E.00764
G1 X93.114 Y77.128 E.23818
G1 X93.299 Y77.076 E.00407
G1 X93.379 Y77.207 E.00325
G1 X93.436 Y77.349 E.00324
G1 X93.465 Y77.49 E.00306
G1 X93.468 Y80.521 E.06415
; WIPE_START
M204 S6000
G1 X93.469 Y82.521 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X93.584 Y90.153 Z5.64 F18000
G1 X93.665 Y95.564 Z5.64
G1 Z5.24
G1 E.4 F1800
G1 F1500
M204 S500
G1 X93.115 Y95.809 E.01275
G1 X93.145 Y95.466 E.00729
G1 X93.203 Y95.372 E.00234
G1 X93.32 Y95.341 E.00255
G1 X93.615 Y95.531 E.00743
; WIPE_START
M204 S6000
G1 X93.115 Y95.809 E-.14499
G1 X93.145 Y95.466 E-.08737
G1 X93.203 Y95.372 E-.02804
G1 X93.32 Y95.341 E-.03053
G1 X93.615 Y95.531 E-.08906
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X86.103 Y96.886 Z5.64 F18000
G1 X84.86 Y97.11 Z5.64
G1 Z5.24
G1 E.4 F1800
G1 F1500
M204 S500
G1 X84.753 Y96.949 E.0041
G1 X85.105 Y96.544 E.01135
G1 X87.084 Y96.544 E.04188
G1 X87.437 Y96.951 E.01141
G1 X87.314 Y97.116 E.00436
G1 X87.193 Y97.059 E.00282
G1 X86.698 Y96.915 E.0109
G1 X86.323 Y96.864 E.00802
G1 X85.962 Y96.858 E.00764
G1 X85.419 Y96.929 E.0116
G1 X84.917 Y97.092 E.01116
; WIPE_START
M204 S6000
G1 X84.753 Y96.949 E-.04131
G1 X85.105 Y96.544 E-.10189
G1 X86.351 Y96.544 E-.2368
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X83.479 Y100.025 Z5.64 F18000
G1 Z5.24
G1 E.4 F1800
G1 F1500
M204 S500
G1 X83.474 Y99.97 E.00116
G1 X83.502 Y99.51 E.00975
G1 X83.611 Y99.063 E.00975
G1 X83.734 Y98.764 E.00684
G1 X83.891 Y98.482 E.00683
G1 X84.173 Y98.118 E.00975
G1 X84.515 Y97.809 E.00975
G1 X84.784 Y97.632 E.00683
G1 X85.073 Y97.487 E.00683
G1 X85.512 Y97.344 E.00979
G1 X85.986 Y97.283 E.01011
G1 X86.291 Y97.288 E.00645
G1 X86.61 Y97.331 E.00682
G1 X87.043 Y97.458 E.00955
G1 X87.336 Y97.593 E.00683
G1 X87.61 Y97.763 E.00683
G1 X87.962 Y98.061 E.00976
G1 X88.261 Y98.424 E.00995
G1 X88.485 Y98.826 E.00975
G1 X88.598 Y99.128 E.00683
G1 X88.675 Y99.442 E.00683
G1 X88.716 Y99.901 E.00975
G1 X88.674 Y100.369 E.00995
G1 X88.551 Y100.813 E.00975
G1 X88.42 Y101.108 E.00683
G1 X88.255 Y101.385 E.00683
G1 X87.962 Y101.741 E.00975
G1 X87.603 Y102.045 E.00995
G1 X87.205 Y102.275 E.00975
G1 X86.904 Y102.393 E.00683
G1 X86.592 Y102.474 E.00683
G1 X86.134 Y102.522 E.00976
G1 X85.665 Y102.487 E.00995
G1 X85.219 Y102.371 E.00975
G1 X84.923 Y102.245 E.00682
G1 X84.659 Y102.093 E.00645
G1 X84.284 Y101.797 E.01011
G1 X83.973 Y101.442 E.00999
G1 X83.732 Y101.039 E.00994
G1 X83.57 Y100.607 E.00975
G1 X83.503 Y100.291 E.00683
G1 X83.485 Y100.084 E.0044
M204 S250
G1 X83.887 Y99.988 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X83.885 Y99.964 E.00047
G1 X83.908 Y99.571 E.00774
G1 X84.001 Y99.189 E.00773
G1 X84.103 Y98.942 E.00527
G1 X84.233 Y98.708 E.00526
G1 X84.474 Y98.397 E.00774
G1 X84.766 Y98.134 E.00774
G1 X84.989 Y97.987 E.00526
G1 X85.228 Y97.867 E.00526
G1 X85.603 Y97.745 E.00775
G1 X86.009 Y97.692 E.00806
G1 X86.26 Y97.697 E.00493
G1 X86.525 Y97.733 E.00526
G1 X86.899 Y97.842 E.00767
G1 X87.142 Y97.954 E.00526
G1 X87.369 Y98.095 E.00526
G1 X87.669 Y98.349 E.00774
G1 X87.921 Y98.656 E.0078
G1 X88.113 Y98.999 E.00773
G1 X88.207 Y99.249 E.00526
G1 X88.27 Y99.509 E.00526
G1 X88.305 Y99.901 E.00773
G1 X88.27 Y100.296 E.0078
G1 X88.165 Y100.675 E.00773
G1 X88.056 Y100.919 E.00526
G1 X87.919 Y101.149 E.00526
G1 X87.669 Y101.452 E.00773
G1 X87.367 Y101.709 E.0078
G1 X87.027 Y101.905 E.00773
G1 X86.777 Y102.003 E.00527
G1 X86.519 Y102.07 E.00526
G1 X86.127 Y102.111 E.00774
G1 X85.732 Y102.082 E.00779
G1 X85.352 Y101.983 E.00773
G1 X85.106 Y101.878 E.00526
G1 X84.889 Y101.753 E.00493
G1 X84.567 Y101.499 E.00806
G1 X84.306 Y101.2 E.00781
G1 X84.103 Y100.86 E.00779
G1 X83.964 Y100.492 E.00774
G1 X83.909 Y100.23 E.00526
G1 X83.892 Y100.048 E.00361
; WIPE_START
M204 S6000
G1 X83.885 Y99.964 E-.01598
G1 X83.908 Y99.571 E-.07472
G1 X84.001 Y99.189 E-.07469
G1 X84.103 Y98.942 E-.05087
G1 X84.233 Y98.708 E-.0508
G1 X84.474 Y98.397 E-.07472
G1 X84.623 Y98.262 E-.03823
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X84.855 Y96.12 Z5.64 F18000
G1 Z5.24
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X92.662 Y96.12 E.16524
G1 X92.739 Y95.338 E.01663
G1 X92.784 Y95.227 E.00254
G1 X92.882 Y95.095 E.00349
G1 X92.98 Y95.015 E.00267
G1 X93.072 Y94.968 E.00218
G1 X93.272 Y94.922 E.00435
G1 X93.486 Y94.955 E.00459
G1 X93.972 Y95.257 E.01211
G1 X95.879 Y94.633 E.04247
G1 X100.747 Y87.68 E.17964
G1 X101.043 Y87.888 E.00765
G1 X96.105 Y94.94 E.18222
G1 X93.244 Y96.216 E.0663
G1 X93.021 Y96.37 E.00573
G1 X92.803 Y96.453 E.00495
G1 X92.559 Y96.482 E.0052
G1 X87.592 Y96.482 E.10514
G1 X88.777 Y97.845 E.03824
G1 X89.098 Y98.351 E.01268
G1 X89.19 Y98.545 E.00453
G1 X89.375 Y99.086 E.01211
G1 X89.467 Y99.68 E.01273
G1 X89.469 Y100.091 E.00869
G1 X89.421 Y100.498 E.00868
G1 X89.323 Y100.899 E.00873
G1 X89.191 Y101.255 E.00805
G1 X89.004 Y101.622 E.00871
G1 X88.658 Y102.103 E.01253
G1 X88.379 Y102.391 E.00849
G1 X88.061 Y102.65 E.00868
G1 X87.737 Y102.855 E.00811
G1 X87.361 Y103.035 E.00883
G1 X87.16 Y103.108 E.00453
G1 X86.793 Y103.208 E.00805
G1 X86.386 Y103.269 E.0087
G1 X85.794 Y103.267 E.01254
G1 X85.211 Y103.164 E.01254
G1 X84.822 Y103.032 E.00869
G1 X84.46 Y102.859 E.0085
G1 X84.121 Y102.644 E.00849
G1 X83.809 Y102.391 E.00849
G1 X83.53 Y102.103 E.00849
G1 X83.185 Y101.621 E.01254
G1 X82.998 Y101.256 E.00869
G1 X82.86 Y100.879 E.00849
G1 X82.767 Y100.491 E.00846
G1 X82.719 Y100.061 E.00916
G1 X82.738 Y99.499 E.0119
G1 X82.812 Y99.097 E.00865
G1 X82.942 Y98.684 E.00917
G1 X83.098 Y98.337 E.00804
G1 X83.417 Y97.838 E.01255
G1 X84.597 Y96.482 E.03805
G1 X79.631 Y96.482 E.10513
G1 X79.383 Y96.453 E.00527
G1 X79.238 Y96.405 E.00324
G1 X79.076 Y96.311 E.00396
G1 X78.969 Y96.216 E.00302
G1 X78.824 Y96.023 E.00512
G1 X78.743 Y95.812 E.00479
G1 X78.714 Y95.565 E.00527
G1 X78.714 Y77.628 E.37965
G1 X78.751 Y77.35 E.00593
G1 X78.86 Y77.119 E.00541
G1 X79.022 Y76.933 E.00522
G1 X79.246 Y76.794 E.00559
G1 X79.391 Y76.746 E.00322
G1 X79.552 Y76.723 E.00345
G1 X92.626 Y76.722 E.27672
G1 X92.799 Y76.747 E.00369
G1 X92.942 Y76.794 E.00321
G1 X93.119 Y76.889 E.00424
G1 X93.07 Y77.082 E.0042
G1 X80.05 Y77.082 E.27557
G1 X79.815 Y77.115 E.00504
G1 X79.55 Y77.228 E.00609
G1 X79.249 Y77.512 E.00876
G1 X79.112 Y77.807 E.00688
G1 X79.075 Y78.056 E.00533
G1 X79.075 Y95.155 E.36192
G1 X79.128 Y95.453 E.0064
G1 X79.316 Y95.778 E.00796
G1 X79.676 Y96.047 E.00952
G1 X80.031 Y96.12 E.00767
G1 X84.795 Y96.12 E.10083
; WIPE_START
M204 S6000
G1 X86.795 Y96.12 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X83.699 Y96.891 Z5.64 F18000
G1 Z5.24
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X79.607 Y96.891 E.08049
G1 X79.294 Y96.854 E.00619
G1 X79.081 Y96.784 E.00442
G1 X78.95 Y96.718 E.00289
G1 X78.826 Y96.637 E.0029
G1 X78.667 Y96.495 E.00419
G1 X78.475 Y96.24 E.00629
G1 X78.412 Y96.114 E.00276
G1 X78.341 Y95.901 E.00442
G1 X78.304 Y95.589 E.00619
G1 X78.304 Y77.61 E.35362
G1 X78.325 Y77.374 E.00466
G1 X78.359 Y77.232 E.00288
G1 X78.414 Y77.083 E.00312
G1 X78.517 Y76.893 E.00426
G1 X78.659 Y76.714 E.00449
G1 X78.763 Y76.615 E.00283
G1 X78.952 Y76.483 E.00453
G1 X79.091 Y76.414 E.00305
G1 X79.297 Y76.346 E.00426
G1 X79.522 Y76.313 E.00449
G1 X92.655 Y76.313 E.2583
G1 X92.892 Y76.347 E.00472
G1 X93.105 Y76.417 E.00441
G1 X93.303 Y76.524 E.00442
G1 X93.479 Y76.663 E.00442
G1 X93.628 Y76.831 E.00442
G1 X93.746 Y77.022 E.00442
G1 X93.829 Y77.231 E.00442
G1 X93.874 Y77.448 E.00437
G1 X93.884 Y88.791 E.2231
G1 X92.704 Y88.791 E.02321
G1 X92.704 Y77.491 E.22226
G1 X80.079 Y77.491 E.24832
G1 X79.926 Y77.513 E.00305
G1 X79.778 Y77.576 E.00317
G1 X79.587 Y77.756 E.00516
G1 X79.508 Y77.925 E.00367
G1 X79.484 Y78.086 E.00319
G1 X79.484 Y95.119 E.33504
G1 X79.518 Y95.311 E.00382
G1 X79.628 Y95.501 E.00432
G1 X79.848 Y95.664 E.0054
G1 X80.073 Y95.711 E.00452
G1 X92.287 Y95.711 E.24024
G1 X92.32 Y95.331 E.0075
G1 X92.417 Y95.044 E.00594
G1 X92.583 Y94.813 E.0056
G1 X92.674 Y94.73 E.00244
G1 X92.925 Y94.584 E.0057
G1 X93.161 Y94.521 E.00481
G1 X93.448 Y94.524 E.00565
G1 X93.723 Y94.609 E.00566
G1 X94.03 Y94.807 E.00719
G1 X95.622 Y94.286 E.03294
G1 X100.647 Y87.111 E.1723
G1 X101.613 Y87.787 E.02321
G1 X96.375 Y95.268 E.17961
G1 X93.445 Y96.575 E.0631
G1 X93.229 Y96.723 E.00516
G1 X93.102 Y96.786 E.00279
G1 X92.891 Y96.855 E.00437
G1 X92.582 Y96.891 E.00611
G1 X88.49 Y96.891 E.08049
G1 X89.098 Y97.59 E.01823
G1 X89.226 Y97.767 E.0043
G1 X89.46 Y98.158 E.00896
G1 X89.567 Y98.385 E.00494
G1 X89.716 Y98.783 E.00835
G1 X89.774 Y98.994 E.00431
G1 X89.856 Y99.443 E.00897
G1 X89.877 Y99.661 E.0043
G1 X89.878 Y100.114 E.00891
G1 X89.826 Y100.564 E.00891
G1 X89.781 Y100.78 E.00435
G1 X89.713 Y101.025 E.005
G1 X89.566 Y101.42 E.00829
G1 X89.36 Y101.824 E.00892
G1 X89.244 Y102.009 E.0043
G1 X88.969 Y102.37 E.00891
G1 X88.657 Y102.693 E.00885
G1 X88.305 Y102.979 E.00891
G1 X87.93 Y103.216 E.00873
G1 X87.519 Y103.413 E.00896
G1 X87.283 Y103.499 E.00494
G1 X86.877 Y103.609 E.00829
G1 X86.429 Y103.676 E.00891
G1 X86.21 Y103.689 E.00431
G1 X85.757 Y103.676 E.00891
G1 X85.309 Y103.608 E.00891
G1 X85.096 Y103.557 E.00431
G1 X84.667 Y103.412 E.00891
G1 X84.261 Y103.218 E.00885
G1 X83.881 Y102.977 E.00885
G1 X83.532 Y102.693 E.00885
G1 X83.219 Y102.37 E.00885
G1 X82.945 Y102.009 E.00892
G1 X82.829 Y101.824 E.0043
G1 X82.623 Y101.42 E.00891
G1 X82.467 Y100.998 E.00885
G1 X82.363 Y100.561 E.00884
G1 X82.31 Y100.082 E.00948
G1 X82.312 Y99.661 E.00828
G1 X82.332 Y99.443 E.00431
G1 X82.414 Y98.998 E.0089
G1 X82.559 Y98.538 E.00948
G1 X82.731 Y98.154 E.00828
G1 X82.838 Y97.962 E.00431
G1 X83.093 Y97.588 E.00891
G1 X83.659 Y96.936 E.01698
; WIPE_START
M204 S6000
G1 X81.66 Y96.914 E-.38
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




G1 X79.481 Y96.245
G1 Z5.24
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.148454
G1 F1500
M204 S6000
G1 X79.12 Y95.967 E.00278
G1 X79.042 Y95.848 E.00087
G1 X78.942 Y95.627 E.00149
; WIPE_START
G1 X79.042 Y95.848 E-.10995
G1 X79.12 Y95.967 E-.06454
G1 X79.481 Y96.245 E-.20551
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X84.642 Y97.165 Z5.64 F18000
M73 P90 R2
G1 Z5.24
G1 E.4 F1800
; LINE_WIDTH: 0.47711
G1 F1500
M204 S6000
G1 X84.461 Y97.319 E.00533
; LINE_WIDTH: 0.438439
G1 X84.254 Y97.496 E.00561
; LINE_WIDTH: 0.400647
G1 X84.08 Y97.673 E.00464
; LINE_WIDTH: 0.360129
G1 X83.722 Y98.073 E.00895
G1 X83.514 Y98.374 E.0061
G1 X83.392 Y98.61 E.00444
G1 X83.257 Y98.935 E.00586
G1 X83.132 Y99.439 E.00868
G1 X83.098 Y99.988 E.00917
G1 X83.132 Y100.357 E.00619
G1 X83.211 Y100.725 E.00627
G1 X83.349 Y101.103 E.0067
G1 X83.517 Y101.427 E.00609
G1 X83.824 Y101.854 E.00878
G1 X84.067 Y102.11 E.0059
G1 X84.458 Y102.412 E.00823
G1 X84.746 Y102.578 E.00555
G1 X84.966 Y102.678 E.00403
G1 X85.312 Y102.792 E.00609
G1 X85.618 Y102.858 E.00521
G1 X86.125 Y102.896 E.00848
G1 X86.647 Y102.848 E.00875
G1 X87.031 Y102.75 E.0066
G1 X87.379 Y102.609 E.00627
G1 X87.809 Y102.363 E.00826
G1 X88.12 Y102.109 E.0067
G1 X88.365 Y101.854 E.0059
G1 X88.674 Y101.428 E.00877
G1 X88.841 Y101.102 E.00612
G1 X88.957 Y100.783 E.00566
G1 X89.049 Y100.422 E.00622
G1 X89.092 Y99.886 E.00896
G1 X89.042 Y99.369 E.00867
G1 X88.964 Y99.026 E.00586
G1 X88.758 Y98.529 E.00897
G1 X88.562 Y98.201 E.00638
G1 X88.222 Y97.784 E.00898
; LINE_WIDTH: 0.378833
G1 X88.045 Y97.609 E.00438
; LINE_WIDTH: 0.419351
G1 X87.842 Y97.411 E.00557
; LINE_WIDTH: 0.468136
G1 X87.544 Y97.162 E.00857
; WIPE_START
G1 X87.842 Y97.411 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X94.029 Y95.546 Z5.64 F18000
G1 Z5.24
G1 E.4 F1800
; LINE_WIDTH: 0.152257
G1 F1500
M204 S6000
G1 X94.523 Y95.356 E.00334
; LINE_WIDTH: 0.103918
G1 X95.017 Y95.165 E.00206
; WIPE_START
G1 X94.523 Y95.356 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X89.491 Y89.616 Z5.64 F18000
G1 X78.952 Y77.595 Z5.64
G1 Z5.24
G1 E.4 F1800
; LINE_WIDTH: 0.108001
G1 F1500
M204 S6000
G1 X79.028 Y77.364 E.001
; LINE_WIDTH: 0.161727
G1 X79.208 Y77.155 E.00187
G1 X79.302 Y77.079 E.00082
; LINE_WIDTH: 0.137107
G1 X79.402 Y77.015 E.00066
; LINE_WIDTH: 0.0990529
G1 X79.589 Y76.956 E.00072
; CHANGE_LAYER
; Z_HEIGHT: 5.36
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F1500
G1 X79.402 Y77.015 E-.38
; WIPE_END
G1 E-.02 F1800
; layer num/total_layer_count: 52/57
; update layer progress
M73 L52
M991 S0 P51 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z5.64 I-.299 J1.18 P1  F18000
G1 X93.468 Y80.581 Z5.64
G1 Z5.36
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X93.475 Y88.382 E.1651
G1 X93.114 Y88.382 E.00764
G1 X93.114 Y77.128 E.23818
G1 X93.299 Y77.076 E.00407
G1 X93.379 Y77.207 E.00325
G1 X93.436 Y77.349 E.00324
G1 X93.465 Y77.49 E.00305
G1 X93.468 Y80.521 E.06416
; WIPE_START
M204 S6000
G1 X93.469 Y82.521 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X93.584 Y90.153 Z5.76 F18000
G1 X93.665 Y95.564 Z5.76
G1 Z5.36
G1 E.4 F1800
G1 F1500
M204 S500
G1 X93.115 Y95.809 E.01275
G1 X93.145 Y95.466 E.0073
G1 X93.166 Y95.414 E.00118
G1 X93.212 Y95.37 E.00135
G1 X93.32 Y95.341 E.00236
G1 X93.615 Y95.531 E.00743
; WIPE_START
M204 S6000
G1 X93.115 Y95.809 E-.14496
G1 X93.145 Y95.466 E-.08742
G1 X93.166 Y95.414 E-.01413
G1 X93.212 Y95.37 E-.01615
G1 X93.32 Y95.341 E-.02829
G1 X93.615 Y95.531 E-.08904
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X86.103 Y96.886 Z5.76 F18000
G1 X84.86 Y97.11 Z5.76
G1 Z5.36
G1 E.4 F1800
G1 F1500
M204 S500
G1 X84.753 Y96.949 E.0041
G1 X85.105 Y96.544 E.01135
G1 X87.084 Y96.544 E.04188
G1 X87.437 Y96.951 E.0114
G1 X87.314 Y97.115 E.00436
G1 X87.193 Y97.059 E.00282
G1 X86.698 Y96.915 E.0109
G1 X86.323 Y96.864 E.00802
G1 X85.959 Y96.858 E.0077
G1 X85.418 Y96.929 E.01155
G1 X84.917 Y97.092 E.01116
; WIPE_START
M204 S6000
G1 X84.753 Y96.949 E-.04131
G1 X85.105 Y96.544 E-.10189
G1 X86.351 Y96.544 E-.2368
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X83.482 Y100.046 Z5.76 F18000
G1 Z5.36
G1 E.4 F1800
G1 F1500
M204 S500
G1 X83.474 Y99.979 E.00142
G1 X83.502 Y99.51 E.00995
G1 X83.611 Y99.063 E.00975
G1 X83.734 Y98.764 E.00683
G1 X83.891 Y98.482 E.00683
G1 X84.173 Y98.118 E.00975
G1 X84.515 Y97.809 E.00975
G1 X84.784 Y97.632 E.00683
G1 X85.073 Y97.487 E.00683
G1 X85.512 Y97.344 E.00978
G1 X85.983 Y97.283 E.01006
G1 X86.291 Y97.288 E.00651
G1 X86.61 Y97.331 E.00682
G1 X87.043 Y97.458 E.00955
G1 X87.336 Y97.593 E.00683
G1 X87.61 Y97.763 E.00683
G1 X87.955 Y98.055 E.00956
G1 X88.167 Y98.298 E.00683
G1 X88.349 Y98.565 E.00683
G1 X88.549 Y98.98 E.00975
G1 X88.674 Y99.433 E.00995
G1 X88.716 Y99.901 E.00995
G1 X88.674 Y100.369 E.00995
G1 X88.549 Y100.823 E.00998
G1 X88.34 Y101.251 E.01006
G1 X88.167 Y101.504 E.0065
G1 X87.955 Y101.747 E.00682
G1 X87.603 Y102.045 E.00975
G1 X87.196 Y102.28 E.00995
G1 X86.763 Y102.435 E.00975
G1 X86.446 Y102.498 E.00683
G1 X86.123 Y102.522 E.00686
G1 X85.659 Y102.485 E.00986
G1 X85.359 Y102.416 E.00651
G1 X85.056 Y102.307 E.00682
G1 X84.65 Y102.089 E.00975
G1 X84.283 Y101.796 E.00995
G1 X83.973 Y101.442 E.00995
G1 X83.737 Y101.046 E.00975
G1 X83.615 Y100.748 E.00683
G1 X83.529 Y100.437 E.00683
G1 X83.489 Y100.106 E.00706
M204 S250
G1 X83.888 Y99.997 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X83.885 Y99.967 E.0006
G1 X83.908 Y99.571 E.0078
G1 X84.001 Y99.189 E.00773
G1 X84.103 Y98.942 E.00526
G1 X84.233 Y98.708 E.00526
G1 X84.474 Y98.397 E.00773
G1 X84.766 Y98.134 E.00773
G1 X84.989 Y97.987 E.00526
G1 X85.228 Y97.867 E.00526
G1 X85.603 Y97.745 E.00774
G1 X86.007 Y97.692 E.00801
G1 X86.26 Y97.697 E.00498
G1 X86.525 Y97.733 E.00526
G1 X86.899 Y97.842 E.00767
G1 X87.142 Y97.954 E.00526
G1 X87.369 Y98.095 E.00526
G1 X87.667 Y98.347 E.00768
G1 X87.843 Y98.549 E.00526
G1 X87.994 Y98.77 E.00526
G1 X88.164 Y99.124 E.00774
G1 X88.27 Y99.506 E.00779
G1 X88.305 Y99.901 E.0078
G1 X88.27 Y100.296 E.0078
G1 X88.164 Y100.678 E.0078
G1 X87.986 Y101.044 E.00801
G1 X87.843 Y101.253 E.00498
G1 X87.667 Y101.455 E.00526
G1 X87.367 Y101.709 E.00774
G1 X87.024 Y101.907 E.00779
G1 X86.654 Y102.04 E.00773
G1 X86.391 Y102.091 E.00526
G1 X86.124 Y102.111 E.00527
G1 X85.721 Y102.079 E.00795
G1 X85.474 Y102.022 E.00498
G1 X85.223 Y101.932 E.00526
G1 X84.877 Y101.746 E.00773
G1 X84.567 Y101.499 E.0078
G1 X84.306 Y101.2 E.0078
G1 X84.104 Y100.863 E.00773
G1 X84.003 Y100.615 E.00526
G1 X83.931 Y100.357 E.00526
G1 X83.895 Y100.057 E.00596
; WIPE_START
M204 S6000
G1 X83.885 Y99.967 E-.01718
G1 X83.908 Y99.571 E-.07531
G1 X84.001 Y99.189 E-.0747
G1 X84.103 Y98.942 E-.05084
G1 X84.233 Y98.708 E-.05084
G1 X84.474 Y98.397 E-.07471
G1 X84.616 Y98.269 E-.03642
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X84.855 Y96.12 Z5.76 F18000
G1 Z5.36
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X92.662 Y96.12 E.16524
G1 X92.739 Y95.338 E.01662
G1 X92.784 Y95.227 E.00254
G1 X92.851 Y95.128 E.00252
G1 X92.932 Y95.05 E.00238
G1 X93.063 Y94.97 E.00324
G1 X93.272 Y94.922 E.00455
G1 X93.493 Y94.957 E.00474
G1 X93.972 Y95.257 E.01196
G1 X95.879 Y94.633 E.04247
G1 X100.747 Y87.68 E.17964
G1 X101.043 Y87.888 E.00765
G1 X96.105 Y94.94 E.18222
G1 X93.236 Y96.22 E.0665
G1 X93.08 Y96.334 E.0041
G1 X92.938 Y96.409 E.00339
G1 X92.803 Y96.453 E.00301
G1 X92.559 Y96.482 E.0052
G1 X87.591 Y96.482 E.10514
G1 X88.777 Y97.845 E.03824
G1 X88.884 Y97.993 E.00386
G1 X89.098 Y98.351 E.00884
G1 X89.323 Y98.901 E.01257
G1 X89.449 Y99.487 E.0127
G1 X89.469 Y100.088 E.01273
G1 X89.417 Y100.514 E.00908
G1 X89.266 Y101.07 E.01219
G1 X89.008 Y101.613 E.01273
G1 X88.785 Y101.947 E.00849
G1 X88.381 Y102.39 E.01269
G1 X88.215 Y102.532 E.00463
G1 X87.737 Y102.855 E.0122
G1 X87.188 Y103.099 E.01273
G1 X86.792 Y103.208 E.00868
G1 X86.386 Y103.269 E.00869
G1 X85.794 Y103.267 E.01254
G1 X85.211 Y103.164 E.01254
G1 X84.822 Y103.032 E.00869
G1 X84.461 Y102.86 E.00846
G1 X84.1 Y102.629 E.00906
G1 X83.672 Y102.258 E.012
G1 X83.404 Y101.947 E.00869
G1 X83.181 Y101.613 E.0085
G1 X82.998 Y101.256 E.00849
G1 X82.86 Y100.879 E.00849
G1 X82.766 Y100.489 E.0085
G1 X82.72 Y100.091 E.00849
G1 X82.738 Y99.499 E.01254
G1 X82.814 Y99.088 E.00884
G1 X83.007 Y98.526 E.01257
G1 X83.192 Y98.17 E.0085
G1 X83.417 Y97.838 E.00849
G1 X84.597 Y96.482 E.03805
G1 X79.631 Y96.482 E.10513
G1 X79.392 Y96.454 E.00508
G1 X79.192 Y96.381 E.00452
G1 X79.069 Y96.305 E.00306
G1 X78.927 Y96.173 E.00411
G1 X78.829 Y96.033 E.00362
G1 X78.743 Y95.812 E.00501
G1 X78.714 Y95.565 E.00527
G1 X78.714 Y77.619 E.37984
G1 X78.755 Y77.34 E.00597
G1 X78.86 Y77.118 E.0052
G1 X79.022 Y76.933 E.00521
G1 X79.245 Y76.794 E.00556
G1 X79.391 Y76.746 E.00325
G1 X79.552 Y76.723 E.00345
G1 X92.628 Y76.722 E.27675
G1 X92.798 Y76.747 E.00365
G1 X92.942 Y76.794 E.00321
G1 X93.119 Y76.889 E.00424
G1 X93.07 Y77.082 E.0042
G1 X80.058 Y77.082 E.2754
G1 X79.85 Y77.106 E.00445
G1 X79.556 Y77.223 E.00669
G1 X79.249 Y77.512 E.00893
G1 X79.112 Y77.807 E.00688
G1 X79.075 Y78.056 E.00533
G1 X79.075 Y95.155 E.36193
G1 X79.128 Y95.452 E.00638
G1 X79.308 Y95.767 E.00768
G1 X79.637 Y96.029 E.00891
G1 X80.022 Y96.12 E.00837
G1 X84.795 Y96.12 E.10103
; WIPE_START
M204 S6000
G1 X86.795 Y96.12 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X83.699 Y96.891 Z5.76 F18000
G1 Z5.36
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X79.607 Y96.891 E.08049
G1 X79.297 Y96.855 E.00613
G1 X79.013 Y96.751 E.00595
G1 X78.83 Y96.639 E.00423
G1 X78.709 Y96.539 E.00308
G1 X78.609 Y96.432 E.00288
G1 X78.476 Y96.243 E.00454
G1 X78.412 Y96.114 E.00283
G1 X78.341 Y95.901 E.00442
G1 X78.304 Y95.589 E.00619
G1 X78.304 Y77.607 E.35368
G1 X78.313 Y77.454 E.00301
G1 X78.36 Y77.228 E.00454
G1 X78.409 Y77.093 E.00283
G1 X78.517 Y76.892 E.00448
G1 X78.659 Y76.714 E.00448
G1 X78.763 Y76.615 E.00283
G1 X78.952 Y76.483 E.00453
G1 X79.09 Y76.415 E.00303
G1 X79.297 Y76.346 E.00429
G1 X79.522 Y76.313 E.00448
G1 X92.657 Y76.313 E.25834
G1 X92.892 Y76.347 E.00468
G1 X93.105 Y76.417 E.00441
G1 X93.303 Y76.524 E.00442
G1 X93.479 Y76.663 E.00442
G1 X93.628 Y76.831 E.00442
G1 X93.746 Y77.022 E.00442
G1 X93.829 Y77.231 E.00442
G1 X93.874 Y77.448 E.00436
G1 X93.884 Y88.791 E.2231
G1 X92.704 Y88.791 E.02321
G1 X92.704 Y77.491 E.22226
G1 X80.082 Y77.491 E.24827
G1 X79.95 Y77.506 E.00261
G1 X79.78 Y77.574 E.00362
G1 X79.587 Y77.756 E.00521
G1 X79.508 Y77.925 E.00368
G1 X79.484 Y78.086 E.00318
G1 X79.484 Y95.119 E.33504
G1 X79.518 Y95.31 E.00381
G1 X79.624 Y95.495 E.00419
G1 X79.821 Y95.652 E.00494
G1 X80.07 Y95.711 E.00504
G1 X92.287 Y95.711 E.2403
G1 X92.32 Y95.33 E.00753
G1 X92.417 Y95.044 E.00592
G1 X92.545 Y94.855 E.0045
G1 X92.674 Y94.73 E.00353
G1 X92.922 Y94.585 E.00565
G1 X93.161 Y94.521 E.00487
G1 X93.448 Y94.524 E.00565
G1 X93.722 Y94.609 E.00565
G1 X94.03 Y94.807 E.00721
G1 X95.622 Y94.286 E.03294
G1 X100.647 Y87.111 E.1723
G1 X101.613 Y87.787 E.02321
G1 X96.375 Y95.268 E.17961
M73 P91 R2
G1 X93.442 Y96.576 E.06316
G1 X93.298 Y96.682 E.00353
G1 X93.099 Y96.787 E.00442
G1 X92.891 Y96.855 E.00431
G1 X92.582 Y96.891 E.00611
G1 X88.49 Y96.891 E.08049
G1 X89.098 Y97.59 E.01822
G1 X89.227 Y97.767 E.00431
G1 X89.46 Y98.158 E.00896
G1 X89.565 Y98.381 E.00485
G1 X89.714 Y98.78 E.00838
G1 X89.823 Y99.22 E.00891
G1 X89.877 Y99.688 E.00926
G1 X89.878 Y100.113 E.00837
G1 X89.821 Y100.587 E.00939
G1 X89.721 Y101.001 E.00837
G1 X89.568 Y101.417 E.00873
G1 X89.362 Y101.821 E.00891
G1 X89.111 Y102.195 E.00885
G1 X88.816 Y102.538 E.00891
G1 X88.468 Y102.855 E.00925
G1 X88.119 Y103.105 E.00844
G1 X87.93 Y103.216 E.00431
G1 X87.519 Y103.413 E.00897
G1 X87.314 Y103.489 E.0043
G1 X86.877 Y103.609 E.00891
G1 X86.429 Y103.676 E.00891
G1 X86.21 Y103.689 E.00431
G1 X85.757 Y103.676 E.00891
G1 X85.309 Y103.608 E.00891
G1 X85.096 Y103.557 E.00431
G1 X84.667 Y103.412 E.00891
G1 X84.262 Y103.218 E.00884
G1 X83.86 Y102.961 E.00939
G1 X83.53 Y102.691 E.00838
G1 X83.373 Y102.539 E.00431
G1 X83.078 Y102.195 E.00891
G1 X82.827 Y101.821 E.00885
G1 X82.623 Y101.42 E.00885
G1 X82.467 Y100.998 E.00885
G1 X82.363 Y100.56 E.00885
G1 X82.311 Y100.114 E.00885
G1 X82.312 Y99.661 E.00891
G1 X82.332 Y99.443 E.0043
G1 X82.415 Y98.995 E.00896
G1 X82.482 Y98.758 E.00485
G1 X82.633 Y98.359 E.00838
G1 X82.84 Y97.96 E.00885
G1 X83.093 Y97.588 E.00885
G1 X83.659 Y96.936 E.01699
; WIPE_START
M204 S6000
G1 X81.66 Y96.914 E-.38
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




G1 X79.525 Y96.236
G1 Z5.36
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.0944311
G1 F1500
M204 S6000
G1 X79.451 Y96.205 E.00028
; LINE_WIDTH: 0.13389
G1 X79.317 Y96.13 E.00083
; LINE_WIDTH: 0.146921
G1 X79.094 Y95.936 E.00178
G1 X78.942 Y95.626 E.00209
; WIPE_START
G1 X79.094 Y95.936 E-.20486
G1 X79.317 Y96.13 E-.17514
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X84.642 Y97.165 Z5.76 F18000
G1 Z5.36
G1 E.4 F1800
; LINE_WIDTH: 0.477099
G1 F1500
M204 S6000
G1 X84.461 Y97.319 E.00533
; LINE_WIDTH: 0.438402
G1 X84.254 Y97.496 E.00561
; LINE_WIDTH: 0.400617
G1 X84.08 Y97.673 E.00464
; LINE_WIDTH: 0.359807
G1 X83.722 Y98.073 E.00894
G1 X83.52 Y98.365 E.00593
G1 X83.355 Y98.682 E.00595
G1 X83.248 Y98.958 E.00493
G1 X83.188 Y99.175 E.00376
G1 X83.118 Y99.546 E.00629
G1 X83.098 Y100.005 E.00767
G1 X83.156 Y100.498 E.00826
G1 X83.261 Y100.879 E.0066
G1 X83.406 Y101.226 E.00626
G1 X83.708 Y101.716 E.00959
G1 X84.012 Y102.057 E.00763
G1 X84.431 Y102.394 E.00896
G1 X84.891 Y102.647 E.00874
G1 X85.262 Y102.782 E.00658
G1 X85.613 Y102.856 E.00599
G1 X86.11 Y102.895 E.00829
G1 X86.506 Y102.87 E.00663
G1 X86.851 Y102.801 E.00586
G1 X87.065 Y102.735 E.00373
G1 X87.554 Y102.517 E.00892
G1 X87.83 Y102.342 E.00545
G1 X88.119 Y102.11 E.00617
G1 X88.483 Y101.714 E.00897
G1 X88.68 Y101.421 E.0059
G1 X88.896 Y100.971 E.00831
G1 X89.045 Y100.447 E.00908
G1 X89.086 Y100.068 E.00635
G1 X89.068 Y99.534 E.00891
G1 X89.039 Y99.352 E.00307
G1 X88.904 Y98.862 E.00847
G1 X88.758 Y98.53 E.00604
G1 X88.476 Y98.077 E.00889
G1 X88.213 Y97.775 E.00668
; LINE_WIDTH: 0.380241
G1 X88.04 Y97.605 E.00429
; LINE_WIDTH: 0.419801
G1 X87.842 Y97.411 E.00545
; LINE_WIDTH: 0.468129
G1 X87.544 Y97.162 E.00857
; WIPE_START
G1 X87.842 Y97.411 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X94.029 Y95.546 Z5.76 F18000
G1 Z5.36
G1 E.4 F1800
; LINE_WIDTH: 0.152239
G1 F1500
M204 S6000
G1 X94.523 Y95.356 E.00334
; LINE_WIDTH: 0.103912
G1 X95.017 Y95.165 E.00206
; WIPE_START
G1 X94.523 Y95.356 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X89.49 Y89.618 Z5.76 F18000
G1 X78.949 Y77.602 Z5.76
G1 Z5.36
G1 E.4 F1800
; LINE_WIDTH: 0.0890875
G1 F1500
M204 S6000
G1 X78.988 Y77.484 E.00039
; LINE_WIDTH: 0.115438
G1 X79.026 Y77.366 E.00056
; LINE_WIDTH: 0.161479
G1 X79.208 Y77.155 E.00188
G1 X79.302 Y77.078 E.00082
; LINE_WIDTH: 0.134994
G1 X79.411 Y77.01 E.0007
; LINE_WIDTH: 0.0964395
G1 X79.588 Y76.956 E.00065
; CHANGE_LAYER
; Z_HEIGHT: 5.48
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F1500
G1 X79.411 Y77.01 E-.38
; WIPE_END
G1 E-.02 F1800
; layer num/total_layer_count: 53/57
; update layer progress
M73 L53
M991 S0 P52 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z5.76 I-.3 J1.179 P1  F18000
G1 X93.468 Y80.581 Z5.76
G1 Z5.48
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X93.475 Y88.382 E.1651
G1 X93.114 Y88.382 E.00764
G1 X93.114 Y77.128 E.23818
G1 X93.299 Y77.076 E.00407
G1 X93.379 Y77.207 E.00325
G1 X93.436 Y77.349 E.00324
G1 X93.465 Y77.49 E.00306
G1 X93.468 Y80.521 E.06415
; WIPE_START
M204 S6000
G1 X93.469 Y82.521 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X93.584 Y90.153 Z5.88 F18000
G1 X93.665 Y95.564 Z5.88
G1 Z5.48
G1 E.4 F1800
G1 F1500
M204 S500
G1 X93.121 Y95.806 E.0126
G1 X93.14 Y95.498 E.00653
G1 X93.166 Y95.414 E.00187
G1 X93.212 Y95.37 E.00135
G1 X93.32 Y95.341 E.00236
G1 X93.615 Y95.531 E.00743
; WIPE_START
M204 S6000
G1 X93.121 Y95.806 E-.14421
G1 X93.14 Y95.498 E-.07884
G1 X93.166 Y95.414 E-.02253
G1 X93.212 Y95.37 E-.01624
G1 X93.32 Y95.341 E-.02847
G1 X93.615 Y95.531 E-.08969
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X86.103 Y96.886 Z5.88 F18000
G1 X84.86 Y97.11 Z5.88
G1 Z5.48
G1 E.4 F1800
G1 F1500
M204 S500
G1 X84.753 Y96.949 E.0041
G1 X85.105 Y96.544 E.01135
G1 X87.093 Y96.544 E.04206
G1 X87.448 Y96.956 E.01152
G1 X87.324 Y97.12 E.00435
G1 X87.193 Y97.059 E.00307
G1 X86.699 Y96.915 E.01089
G1 X86.323 Y96.864 E.00803
G1 X85.956 Y96.858 E.00775
G1 X85.418 Y96.929 E.01149
G1 X84.917 Y97.092 E.01115
; WIPE_START
M204 S6000
G1 X84.753 Y96.949 E-.04131
G1 X85.105 Y96.544 E-.10188
G1 X86.352 Y96.544 E-.23681
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X83.483 Y100.055 Z5.88 F18000
G1 Z5.48
G1 E.4 F1800
G1 F1500
M204 S500
G1 X83.474 Y99.979 E.00162
G1 X83.502 Y99.51 E.00995
G1 X83.614 Y99.052 E.00997
G1 X83.807 Y98.621 E.01001
G1 X83.975 Y98.36 E.00656
G1 X84.174 Y98.119 E.00663
G1 X84.4 Y97.902 E.00662
G1 X84.647 Y97.716 E.00656
G1 X85.063 Y97.491 E.01
G1 X85.512 Y97.345 E.01
G1 X85.981 Y97.283 E.01
G1 X86.291 Y97.288 E.00656
G1 X86.61 Y97.331 E.00682
G1 X87.043 Y97.458 E.00955
G1 X87.336 Y97.593 E.00683
G1 X87.611 Y97.763 E.00683
G1 X87.963 Y98.062 E.00978
G1 X88.262 Y98.428 E.01
G1 X88.42 Y98.694 E.00656
G1 X88.551 Y98.989 E.00682
G1 X88.674 Y99.433 E.00975
G1 X88.715 Y99.892 E.00975
G1 X88.696 Y100.214 E.00683
G1 X88.638 Y100.531 E.00683
G1 X88.49 Y100.967 E.00975
G1 X88.261 Y101.378 E.00995
G1 X87.962 Y101.741 E.00995
G1 X87.61 Y102.039 E.00975
G1 X87.336 Y102.208 E.00683
G1 X87.043 Y102.344 E.00683
G1 X86.601 Y102.473 E.00975
G1 X86.134 Y102.522 E.00995
G1 X85.664 Y102.487 E.00997
G1 X85.207 Y102.366 E.01
G1 X84.922 Y102.244 E.00656
G1 X84.643 Y102.083 E.00682
G1 X84.283 Y101.796 E.00975
G1 X83.973 Y101.441 E.00997
G1 X83.732 Y101.034 E.01001
G1 X83.615 Y100.747 E.00656
G1 X83.529 Y100.437 E.00682
G1 X83.49 Y100.115 E.00686
M204 S250
G1 X83.889 Y100.007 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X83.885 Y99.967 E.00078
G1 X83.908 Y99.571 E.0078
G1 X84.002 Y99.186 E.0078
G1 X84.168 Y98.817 E.00796
G1 X84.306 Y98.602 E.00503
G1 X84.474 Y98.397 E.0052
G1 X84.665 Y98.215 E.0052
G1 X84.869 Y98.061 E.00503
G1 X85.225 Y97.868 E.00796
G1 X85.603 Y97.745 E.00781
G1 X86.004 Y97.693 E.00796
G1 X86.26 Y97.697 E.00503
G1 X86.525 Y97.733 E.00526
G1 X86.899 Y97.842 E.00767
G1 X87.142 Y97.954 E.00526
G1 X87.369 Y98.095 E.00526
G1 X87.67 Y98.35 E.00774
G1 X87.926 Y98.663 E.00796
G1 X88.056 Y98.883 E.00503
G1 X88.165 Y99.127 E.00526
G1 X88.27 Y99.506 E.00773
G1 X88.305 Y99.898 E.00773
G1 X88.289 Y100.165 E.00526
G1 X88.241 Y100.428 E.00526
G1 X88.114 Y100.8 E.00773
G1 X87.921 Y101.146 E.0078
G1 X87.669 Y101.452 E.0078
G1 X87.369 Y101.707 E.00774
G1 X87.142 Y101.847 E.00526
G1 X86.899 Y101.96 E.00526
G1 X86.522 Y102.07 E.00773
G1 X86.127 Y102.111 E.0078
G1 X85.732 Y102.082 E.0078
G1 X85.34 Y101.979 E.00796
G1 X85.106 Y101.878 E.00503
G1 X84.874 Y101.744 E.00526
G1 X84.567 Y101.499 E.00773
G1 X84.306 Y101.2 E.00781
G1 X84.099 Y100.852 E.00796
M73 P92 R2
G1 X84.003 Y100.615 E.00503
G1 X83.931 Y100.357 E.00526
G1 X83.896 Y100.066 E.00577
; WIPE_START
M204 S6000
G1 X83.885 Y99.967 E-.01896
G1 X83.908 Y99.571 E-.07531
G1 X84.002 Y99.186 E-.07536
G1 X84.168 Y98.817 E-.07694
G1 X84.306 Y98.602 E-.04856
G1 X84.474 Y98.397 E-.05021
G1 X84.606 Y98.271 E-.03465
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X84.855 Y96.12 Z5.88 F18000
G1 Z5.48
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X92.678 Y96.12 E.16557
G1 X92.718 Y95.441 E.01439
G1 X92.742 Y95.331 E.00238
G1 X92.784 Y95.227 E.00238
G1 X92.851 Y95.128 E.00252
G1 X92.939 Y95.044 E.00257
G1 X93.072 Y94.968 E.00324
G1 X93.272 Y94.922 E.00435
G1 X93.443 Y94.941 E.00364
G1 X93.539 Y94.978 E.00218
G1 X93.972 Y95.257 E.01091
G1 X95.879 Y94.633 E.04247
G1 X100.747 Y87.68 E.17964
G1 X101.043 Y87.888 E.00765
G1 X96.105 Y94.94 E.18222
G1 X93.244 Y96.216 E.0663
G1 X93.021 Y96.37 E.00573
G1 X92.803 Y96.453 E.00495
G1 X92.559 Y96.482 E.0052
G1 X87.599 Y96.482 E.10498
G1 X88.784 Y97.855 E.03839
G1 X89.095 Y98.345 E.01229
G1 X89.326 Y98.91 E.01292
G1 X89.451 Y99.499 E.01274
G1 X89.469 Y100.089 E.01251
G1 X89.418 Y100.51 E.00897
G1 X89.267 Y101.069 E.01225
G1 X89.004 Y101.621 E.01294
G1 X88.659 Y102.102 E.01252
G1 X88.363 Y102.405 E.00897
G1 X88.061 Y102.65 E.00823
M73 P92 R1
G1 X87.543 Y102.955 E.01275
G1 X87.188 Y103.099 E.0081
G1 X86.792 Y103.208 E.00869
G1 X86.386 Y103.269 E.00869
G1 X85.794 Y103.267 E.01254
G1 X85.211 Y103.164 E.01254
G1 X84.822 Y103.032 E.00869
G1 X84.294 Y102.762 E.01254
G1 X83.961 Y102.522 E.00869
G1 X83.666 Y102.251 E.00849
G1 X83.404 Y101.947 E.00849
G1 X83.181 Y101.613 E.00849
G1 X82.998 Y101.256 E.00849
G1 X82.859 Y100.879 E.00849
G1 X82.767 Y100.49 E.00847
G1 X82.719 Y100.069 E.00897
G1 X82.738 Y99.499 E.01209
G1 X82.812 Y99.096 E.00866
G1 X82.939 Y98.692 E.00897
G1 X83.098 Y98.337 E.00823
G1 X83.417 Y97.838 E.01255
G1 X84.597 Y96.482 E.03805
G1 X79.631 Y96.482 E.10513
G1 X79.392 Y96.454 E.00508
G1 X79.192 Y96.381 E.0045
G1 X79.062 Y96.301 E.00324
G1 X78.888 Y96.124 E.00526
G1 X78.832 Y96.04 E.00214
G1 X78.743 Y95.812 E.00517
G1 X78.714 Y95.565 E.00527
G1 X78.714 Y77.619 E.37984
G1 X78.753 Y77.349 E.00577
G1 X78.855 Y77.125 E.0052
G1 X79.027 Y76.929 E.00553
G1 X79.155 Y76.84 E.00329
G1 X79.302 Y76.772 E.00344
G1 X79.552 Y76.723 E.00539
G1 X92.629 Y76.722 E.27678
G1 X92.798 Y76.747 E.00361
G1 X92.942 Y76.794 E.00322
G1 X93.119 Y76.889 E.00424
G1 X93.07 Y77.082 E.0042
G1 X80.058 Y77.082 E.27541
G1 X79.85 Y77.106 E.00444
G1 X79.559 Y77.221 E.00662
G1 X79.25 Y77.511 E.00898
G1 X79.112 Y77.807 E.0069
G1 X79.075 Y78.056 E.00533
G1 X79.075 Y95.155 E.36192
G1 X79.128 Y95.453 E.00639
G1 X79.311 Y95.77 E.00776
G1 X79.639 Y96.029 E.00884
G1 X80.022 Y96.12 E.00834
G1 X84.795 Y96.12 E.10103
; WIPE_START
M204 S6000
G1 X86.795 Y96.12 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X83.699 Y96.891 Z5.88 F18000
G1 Z5.48
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X79.607 Y96.891 E.08049
G1 X79.297 Y96.855 E.00613
G1 X79.013 Y96.751 E.00594
G1 X78.822 Y96.633 E.00442
G1 X78.712 Y96.541 E.00283
G1 X78.563 Y96.375 E.00438
G1 X78.477 Y96.245 E.00305
G1 X78.412 Y96.114 E.00288
G1 X78.341 Y95.901 E.00442
G1 X78.304 Y95.589 E.00619
G1 X78.304 Y77.607 E.35368
G1 X78.313 Y77.454 E.00301
G1 X78.359 Y77.231 E.00448
G1 X78.443 Y77.019 E.00448
G1 X78.515 Y76.895 E.00283
G1 X78.658 Y76.714 E.00453
G1 X78.769 Y76.61 E.00299
G1 X78.95 Y76.484 E.00433
G1 X79.156 Y76.388 E.00448
G1 X79.294 Y76.347 E.00283
G1 X79.522 Y76.313 E.00454
G1 X92.658 Y76.313 E.25837
G1 X92.892 Y76.347 E.00465
G1 X93.105 Y76.417 E.00441
G1 X93.303 Y76.524 E.00442
G1 X93.479 Y76.663 E.00443
G1 X93.628 Y76.831 E.00442
G1 X93.746 Y77.022 E.00442
G1 X93.829 Y77.231 E.00442
G1 X93.874 Y77.448 E.00436
G1 X93.884 Y88.791 E.2231
G1 X92.704 Y88.791 E.02321
G1 X92.704 Y77.491 E.22226
G1 X80.082 Y77.491 E.24827
G1 X79.95 Y77.506 E.00261
G1 X79.782 Y77.573 E.00356
G1 X79.587 Y77.756 E.00525
G1 X79.508 Y77.925 E.00368
G1 X79.484 Y78.086 E.00319
G1 X79.484 Y95.119 E.33504
G1 X79.518 Y95.31 E.00382
G1 X79.626 Y95.498 E.00426
G1 X79.821 Y95.652 E.00489
G1 X80.07 Y95.711 E.00503
G1 X92.292 Y95.711 E.2404
G1 X92.312 Y95.387 E.00639
G1 X92.349 Y95.211 E.00353
G1 X92.417 Y95.044 E.00354
G1 X92.545 Y94.855 E.0045
G1 X92.676 Y94.728 E.00359
G1 X92.925 Y94.584 E.00565
G1 X93.161 Y94.521 E.00481
G1 X93.451 Y94.524 E.00571
G1 X93.725 Y94.611 E.00565
G1 X94.03 Y94.807 E.00715
G1 X95.622 Y94.286 E.03294
G1 X100.647 Y87.111 E.1723
G1 X101.613 Y87.787 E.02321
G1 X96.375 Y95.268 E.17961
G1 X93.445 Y96.574 E.0631
G1 X93.229 Y96.723 E.00516
G1 X93.102 Y96.786 E.0028
G1 X92.891 Y96.855 E.00436
G1 X92.582 Y96.891 E.00611
G1 X88.492 Y96.891 E.08044
G1 X89.109 Y97.606 E.01857
G1 X89.351 Y97.962 E.00847
G1 X89.555 Y98.356 E.00873
G1 X89.716 Y98.783 E.00897
G1 X89.774 Y98.994 E.00431
G1 X89.856 Y99.443 E.00897
G1 X89.877 Y99.661 E.0043
G1 X89.878 Y100.113 E.0089
G1 X89.822 Y100.582 E.0093
G1 X89.721 Y101.001 E.00847
G1 X89.558 Y101.438 E.00917
G1 X89.36 Y101.824 E.00853
G1 X89.244 Y102.009 E.00431
G1 X88.97 Y102.369 E.0089
G1 X88.64 Y102.708 E.0093
G1 X88.305 Y102.979 E.00847
G1 X88.124 Y103.102 E.00431
G1 X87.725 Y103.322 E.00897
G1 X87.314 Y103.489 E.00873
G1 X86.877 Y103.609 E.00891
G1 X86.428 Y103.676 E.00891
G1 X86.21 Y103.689 E.0043
G1 X85.757 Y103.676 E.00891
G1 X85.309 Y103.608 E.00891
G1 X85.096 Y103.557 E.0043
G1 X84.667 Y103.412 E.00891
G1 X84.258 Y103.216 E.00891
G1 X84.07 Y103.105 E.00431
G1 X83.702 Y102.84 E.00891
G1 X83.371 Y102.536 E.00885
G1 X83.078 Y102.195 E.00885
G1 X82.827 Y101.821 E.00885
G1 X82.623 Y101.42 E.00885
G1 X82.467 Y100.998 E.00885
G1 X82.363 Y100.561 E.00884
G1 X82.31 Y100.091 E.00929
G1 X82.312 Y99.661 E.00847
G1 X82.332 Y99.443 E.00431
G1 X82.414 Y98.998 E.0089
G1 X82.556 Y98.547 E.0093
G1 X82.731 Y98.154 E.00847
G1 X82.838 Y97.962 E.00431
G1 X83.093 Y97.588 E.00891
G1 X83.66 Y96.936 E.01698
; WIPE_START
M204 S6000
G1 X81.66 Y96.914 E-.38
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




G1 X79.523 Y96.245
G1 Z5.48
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.134236
G1 F1500
M204 S6000
G1 X79.316 Y96.129 E.00128
; LINE_WIDTH: 0.149175
G1 X79.106 Y95.957 E.00167
G1 X78.942 Y95.626 E.00228
; WIPE_START
G1 X79.106 Y95.957 E-.21914
G1 X79.316 Y96.129 E-.16086
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X84.643 Y97.167 Z5.88 F18000
G1 Z5.48
G1 E.4 F1800
; LINE_WIDTH: 0.478369
G1 F1500
M204 S6000
G1 X84.401 Y97.363 E.00702
; LINE_WIDTH: 0.444422
G1 X84.277 Y97.479 E.00355
; LINE_WIDTH: 0.406599
G1 X84.137 Y97.61 E.00364
; LINE_WIDTH: 0.359707
G1 X83.72 Y98.071 E.01036
G1 X83.514 Y98.373 E.0061
G1 X83.296 Y98.83 E.00843
G1 X83.185 Y99.189 E.00626
G1 X83.118 Y99.546 E.00606
G1 X83.1 Y100.051 E.00843
G1 X83.156 Y100.498 E.00749
G1 X83.261 Y100.878 E.00657
G1 X83.399 Y101.213 E.00604
G1 X83.708 Y101.716 E.00983
G1 X84.012 Y102.058 E.00763
G1 X84.42 Y102.388 E.00875
G1 X84.763 Y102.583 E.00657
G1 X85.096 Y102.725 E.00603
G1 X85.587 Y102.856 E.00846
G1 X86.124 Y102.9 E.00899
G1 X86.689 Y102.841 E.00945
G1 X87.068 Y102.735 E.00656
G1 X87.373 Y102.612 E.00548
G1 X87.84 Y102.342 E.00899
G1 X88.105 Y102.122 E.00574
G1 X88.367 Y101.852 E.00626
G1 X88.671 Y101.428 E.0087
G1 X88.837 Y101.106 E.00604
G1 X88.997 Y100.637 E.00826
G1 X89.071 Y100.249 E.00658
G1 X89.092 Y99.874 E.00626
G1 X89.039 Y99.352 E.00874
G1 X88.961 Y99.031 E.0055
G1 X88.758 Y98.52 E.00917
G1 X88.478 Y98.087 E.00859
G1 X88.223 Y97.785 E.00657
; LINE_WIDTH: 0.378992
G1 X88.046 Y97.61 E.0044
; LINE_WIDTH: 0.420676
G1 X87.843 Y97.411 E.00559
; LINE_WIDTH: 0.46842
G1 X87.554 Y97.168 E.00833
; WIPE_START
G1 X87.843 Y97.411 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X94.029 Y95.546 Z5.88 F18000
G1 Z5.48
G1 E.4 F1800
; LINE_WIDTH: 0.152255
G1 F1500
M204 S6000
G1 X94.523 Y95.356 E.00334
; LINE_WIDTH: 0.103917
G1 X95.017 Y95.165 E.00206
; WIPE_START
G1 X94.523 Y95.356 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X89.49 Y89.618 Z5.88 F18000
G1 X78.949 Y77.601 Z5.88
G1 Z5.48
G1 E.4 F1800
; LINE_WIDTH: 0.0995051
G1 F1500
M204 S6000
G1 X79.004 Y77.423 E.00069
; LINE_WIDTH: 0.124867
G1 X79.039 Y77.346 E.00042
; LINE_WIDTH: 0.159225
G1 X79.214 Y77.15 E.00175
G1 X79.354 Y77.046 E.00116
; LINE_WIDTH: 0.123776
G1 X79.414 Y77.007 E.00035
; LINE_WIDTH: 0.0964924
G1 X79.587 Y76.956 E.00064
; CHANGE_LAYER
; Z_HEIGHT: 5.6
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F1500
G1 X79.414 Y77.007 E-.38
; WIPE_END
G1 E-.02 F1800
; layer num/total_layer_count: 54/57
; update layer progress
M73 L54
M991 S0 P53 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z5.88 I-.3 J1.179 P1  F18000
G1 X93.468 Y80.578 Z5.88
G1 Z5.6
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X93.475 Y88.382 E.16518
G1 X93.114 Y88.382 E.00764
G1 X93.114 Y77.128 E.23818
G1 X93.299 Y77.076 E.00407
G1 X93.379 Y77.207 E.00325
G1 X93.436 Y77.349 E.00324
G1 X93.465 Y77.49 E.00306
G1 X93.468 Y80.518 E.06408
; WIPE_START
M204 S6000
G1 X93.469 Y82.518 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X93.576 Y90.149 Z6 F18000
G1 X93.651 Y95.57 Z6
G1 Z5.6
G1 E.4 F1800
G1 F1500
M204 S500
G1 X93.122 Y95.806 E.01228
G1 X93.14 Y95.498 E.00653
G1 X93.166 Y95.414 E.00186
G1 X93.212 Y95.37 E.00136
G1 X93.295 Y95.347 E.00183
G1 X93.367 Y95.368 E.00158
G1 X93.602 Y95.535 E.00611
; WIPE_START
M204 S6000
G1 X93.122 Y95.806 E-.14344
G1 X93.14 Y95.498 E-.0802
G1 X93.166 Y95.414 E-.02281
G1 X93.212 Y95.37 E-.01665
G1 X93.295 Y95.347 E-.0225
G1 X93.367 Y95.368 E-.01938
G1 X93.602 Y95.535 E-.07501
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X86.091 Y96.888 Z6 F18000
G1 X84.863 Y97.109 Z6
G1 Z5.6
G1 E.4 F1800
G1 F1500
M204 S500
G1 X84.756 Y96.948 E.0041
G1 X85.108 Y96.544 E.01133
G1 X87.084 Y96.544 E.04182
G1 X87.435 Y96.948 E.01132
M73 P93 R1
G1 X87.306 Y97.113 E.00443
G1 X87.209 Y97.064 E.0023
G1 X86.699 Y96.915 E.01126
G1 X86.323 Y96.864 E.00803
G1 X85.954 Y96.858 E.00781
G1 X85.418 Y96.929 E.01144
G1 X84.92 Y97.091 E.01108
; WIPE_START
M204 S6000
G1 X84.756 Y96.948 E-.04133
G1 X85.108 Y96.544 E-.10173
G1 X86.355 Y96.544 E-.23694
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X83.482 Y100.053 Z6 F18000
G1 Z5.6
G1 E.4 F1800
G1 F1500
M204 S500
G1 X83.474 Y99.97 E.00176
G1 X83.502 Y99.509 E.00977
G1 X83.615 Y99.053 E.00995
G1 X83.734 Y98.764 E.00662
G1 X83.891 Y98.482 E.00682
G1 X84.173 Y98.118 E.00975
G1 X84.515 Y97.809 E.00975
G1 X84.784 Y97.632 E.00683
G1 X85.073 Y97.487 E.00683
G1 X85.512 Y97.345 E.00977
G1 X85.978 Y97.283 E.00995
G1 X86.291 Y97.288 E.00662
G1 X86.61 Y97.331 E.00683
G1 X87.053 Y97.461 E.00977
G1 X87.473 Y97.672 E.00995
G1 X87.728 Y97.852 E.00662
G1 X87.968 Y98.068 E.00682
G1 X88.261 Y98.424 E.00975
G1 X88.49 Y98.835 E.00997
G1 X88.641 Y99.281 E.00995
G1 X88.696 Y99.588 E.00662
G1 X88.715 Y99.91 E.00682
G1 X88.675 Y100.36 E.00955
G1 X88.598 Y100.673 E.00682
G1 X88.489 Y100.966 E.00662
G1 X88.261 Y101.377 E.00995
G1 X87.962 Y101.741 E.00997
G1 X87.603 Y102.045 E.00995
G1 X87.204 Y102.275 E.00975
G1 X86.904 Y102.393 E.00682
G1 X86.602 Y102.472 E.00662
G1 X86.144 Y102.521 E.00975
G1 X85.821 Y102.507 E.00685
G1 X85.502 Y102.454 E.00683
G1 X85.064 Y102.312 E.00975
G1 X84.65 Y102.089 E.00995
G1 X84.283 Y101.796 E.00995
G1 X83.973 Y101.442 E.00994
G1 X83.732 Y101.039 E.00995
G1 X83.57 Y100.607 E.00975
G1 X83.503 Y100.291 E.00683
G1 X83.487 Y100.113 E.0038
M204 S250
G1 X83.889 Y100.016 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X83.885 Y99.964 E.00104
G1 X83.908 Y99.571 E.00774
G1 X84.005 Y99.18 E.00791
G1 X84.103 Y98.942 E.00508
G1 X84.233 Y98.708 E.00526
G1 X84.474 Y98.397 E.00774
G1 X84.766 Y98.134 E.00773
G1 X84.989 Y97.987 E.00526
G1 X85.228 Y97.867 E.00526
G1 X85.603 Y97.745 E.00774
G1 X86.002 Y97.693 E.00792
G1 X86.26 Y97.697 E.00508
G1 X86.525 Y97.733 E.00526
G1 X86.902 Y97.843 E.00774
G1 X87.262 Y98.024 E.00792
G1 X87.473 Y98.173 E.00507
G1 X87.671 Y98.352 E.00526
G1 X87.921 Y98.655 E.00773
G1 X88.114 Y99.002 E.00781
G1 X88.243 Y99.383 E.00791
G1 X88.289 Y99.637 E.00508
G1 X88.305 Y99.904 E.00526
G1 X88.27 Y100.292 E.00767
G1 X88.207 Y100.552 E.00526
G1 X88.116 Y100.794 E.00508
G1 X87.921 Y101.146 E.00792
G1 X87.669 Y101.452 E.0078
G1 X87.367 Y101.709 E.0078
G1 X87.026 Y101.905 E.00773
G1 X86.778 Y102.003 E.00526
G1 X86.528 Y102.068 E.00508
G1 X86.131 Y102.111 E.00785
G1 X85.863 Y102.099 E.00527
G1 X85.599 Y102.055 E.00526
G1 X85.225 Y101.934 E.00773
G1 X84.877 Y101.746 E.00779
G1 X84.567 Y101.499 E.0078
G1 X84.306 Y101.2 E.00779
G1 X84.103 Y100.86 E.00779
G1 X83.964 Y100.492 E.00774
G1 X83.909 Y100.23 E.00526
G1 X83.895 Y100.076 E.00304
; WIPE_START
M204 S6000
G1 X83.885 Y99.964 E-.0214
G1 X83.908 Y99.571 E-.07477
G1 X84.005 Y99.18 E-.07646
G1 X84.103 Y98.942 E-.04906
G1 X84.233 Y98.708 E-.05077
G1 X84.474 Y98.397 E-.07473
G1 X84.602 Y98.282 E-.03281
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X84.858 Y96.12 Z6 F18000
G1 Z5.6
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X92.678 Y96.12 E.16551
G1 X92.718 Y95.441 E.01439
G1 X92.742 Y95.331 E.00239
G1 X92.851 Y95.128 E.00487
G1 X92.932 Y95.05 E.00238
G1 X93.063 Y94.97 E.00325
G1 X93.272 Y94.922 E.00455
G1 X93.375 Y94.929 E.00218
G1 X93.525 Y94.971 E.00331
G1 X93.952 Y95.264 E.01094
G1 X95.879 Y94.633 E.04293
G1 X100.747 Y87.68 E.17964
G1 X101.043 Y87.888 E.00765
G1 X96.105 Y94.94 E.18222
G1 X93.244 Y96.216 E.0663
G1 X93.021 Y96.37 E.00573
G1 X92.803 Y96.453 E.00495
G1 X92.559 Y96.482 E.0052
G1 X87.591 Y96.482 E.10514
G1 X88.777 Y97.844 E.03822
G1 X88.893 Y98.006 E.00423
G1 X89.099 Y98.351 E.0085
G1 X89.323 Y98.901 E.01257
G1 X89.45 Y99.49 E.01274
G1 X89.469 Y100.09 E.01271
G1 X89.419 Y100.506 E.00887
G1 X89.266 Y101.07 E.01238
G1 X89.008 Y101.613 E.01273
G1 X88.785 Y101.947 E.0085
G1 X88.381 Y102.391 E.0127
G1 X88.222 Y102.527 E.00443
G1 X87.738 Y102.855 E.01238
G1 X87.188 Y103.099 E.01273
G1 X86.792 Y103.208 E.00869
G1 X86.386 Y103.269 E.00869
G1 X85.794 Y103.267 E.01254
G1 X85.211 Y103.164 E.01254
G1 X84.822 Y103.032 E.00869
G1 X84.451 Y102.855 E.00869
G1 X83.961 Y102.522 E.01254
G1 X83.666 Y102.251 E.00849
G1 X83.404 Y101.947 E.00849
G1 X83.181 Y101.613 E.00849
G1 X82.999 Y101.257 E.00847
G1 X82.855 Y100.863 E.00887
G1 X82.738 Y100.3 E.01218
G1 X82.715 Y99.89 E.00869
G1 X82.74 Y99.49 E.00849
G1 X82.812 Y99.095 E.0085
G1 X82.931 Y98.712 E.00849
G1 X83.094 Y98.345 E.00849
G1 X83.304 Y97.994 E.00866
G1 X83.422 Y97.832 E.00423
G1 X84.6 Y96.482 E.03793
G1 X79.631 Y96.482 E.10517
G1 X79.392 Y96.454 E.00508
G1 X79.192 Y96.381 E.00451
G1 X79.066 Y96.304 E.00312
G1 X78.927 Y96.173 E.00405
G1 X78.828 Y96.033 E.00363
G1 X78.743 Y95.812 E.00501
G1 X78.714 Y95.565 E.00527
G1 X78.714 Y77.619 E.37984
G1 X78.755 Y77.34 E.00597
G1 X78.86 Y77.118 E.0052
G1 X79.026 Y76.93 E.00531
G1 X79.155 Y76.84 E.00331
G1 X79.294 Y76.775 E.00325
G1 X79.543 Y76.723 E.00539
G1 X92.631 Y76.722 E.27701
G1 X92.798 Y76.746 E.00357
G1 X92.942 Y76.794 E.00322
G1 X93.119 Y76.889 E.00424
G1 X93.07 Y77.082 E.0042
G1 X80.041 Y77.082 E.27578
G1 X79.753 Y77.132 E.00619
G1 X79.482 Y77.278 E.00651
G1 X79.265 Y77.495 E.00649
G1 X79.113 Y77.798 E.00718
G1 X79.075 Y78.056 E.00553
G1 X79.075 Y95.146 E.36173
G1 X79.112 Y95.395 E.00533
G1 X79.238 Y95.666 E.00632
G1 X79.435 Y95.887 E.00627
G1 X79.704 Y96.053 E.00669
G1 X80.031 Y96.12 E.00707
G1 X84.798 Y96.12 E.10089
; WIPE_START
M204 S6000
G1 X86.798 Y96.12 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X83.7 Y96.891 Z6 F18000
G1 Z5.6
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X79.607 Y96.891 E.0805
G1 X79.297 Y96.855 E.00613
G1 X79.013 Y96.751 E.00595
G1 X78.827 Y96.637 E.0043
G1 X78.709 Y96.539 E.00302
G1 X78.609 Y96.432 E.00288
G1 X78.476 Y96.243 E.00454
G1 X78.412 Y96.114 E.00283
G1 X78.341 Y95.901 E.00442
G1 X78.304 Y95.589 E.00619
G1 X78.304 Y77.607 E.35368
G1 X78.313 Y77.454 E.00301
G1 X78.36 Y77.228 E.00454
G1 X78.409 Y77.093 E.00283
G1 X78.517 Y76.893 E.00448
G1 X78.658 Y76.714 E.00447
G1 X78.768 Y76.611 E.00296
G1 X78.95 Y76.484 E.00436
G1 X79.153 Y76.389 E.00442
G1 X79.374 Y76.33 E.00448
G1 X79.519 Y76.313 E.00289
G1 X92.66 Y76.313 E.25846
G1 X92.892 Y76.347 E.00461
G1 X93.105 Y76.417 E.00441
G1 X93.303 Y76.524 E.00442
G1 X93.479 Y76.663 E.00442
G1 X93.628 Y76.831 E.00442
G1 X93.746 Y77.022 E.00442
G1 X93.829 Y77.231 E.00442
G1 X93.874 Y77.448 E.00436
G1 X93.884 Y88.791 E.2231
G1 X92.704 Y88.791 E.02321
G1 X92.704 Y77.491 E.22226
G1 X80.076 Y77.491 E.24839
G1 X79.888 Y77.524 E.00375
G1 X79.729 Y77.61 E.00357
G1 X79.601 Y77.737 E.00355
G1 X79.508 Y77.922 E.00407
G1 X79.484 Y78.086 E.00325
G1 X79.484 Y95.116 E.33498
G1 X79.508 Y95.276 E.00318
G1 X79.584 Y95.438 E.00352
G1 X79.701 Y95.57 E.00347
G1 X79.858 Y95.666 E.00362
G1 X80.073 Y95.711 E.00433
G1 X92.292 Y95.711 E.24034
G1 X92.312 Y95.387 E.00639
G1 X92.349 Y95.211 E.00354
G1 X92.414 Y95.049 E.00343
G1 X92.545 Y94.855 E.0046
G1 X92.674 Y94.73 E.00353
G1 X92.922 Y94.584 E.00565
G1 X93.161 Y94.521 E.00487
G1 X93.445 Y94.524 E.00558
G1 X93.677 Y94.589 E.00475
G1 X93.829 Y94.668 E.00337
G1 X94.023 Y94.81 E.00472
G1 X95.622 Y94.286 E.03309
G1 X100.647 Y87.111 E.1723
G1 X101.613 Y87.787 E.02321
G1 X96.375 Y95.268 E.17961
G1 X93.445 Y96.574 E.0631
G1 X93.229 Y96.723 E.00516
G1 X93.102 Y96.786 E.0028
G1 X92.891 Y96.855 E.00436
G1 X92.582 Y96.891 E.00611
G1 X88.49 Y96.891 E.08049
G1 X89.098 Y97.59 E.01822
G1 X89.236 Y97.782 E.00466
G1 X89.46 Y98.158 E.00862
G1 X89.562 Y98.372 E.00466
G1 X89.715 Y98.78 E.00856
G1 X89.823 Y99.22 E.00891
G1 X89.877 Y99.661 E.00873
G1 X89.878 Y100.113 E.0089
G1 X89.823 Y100.578 E.0092
G1 X89.721 Y101.001 E.00856
G1 X89.568 Y101.418 E.00873
G1 X89.362 Y101.821 E.00891
G1 X89.111 Y102.195 E.00885
G1 X88.816 Y102.539 E.00891
G1 X88.475 Y102.849 E.00907
G1 X88.119 Y103.105 E.00863
G1 X87.93 Y103.216 E.0043
G1 X87.519 Y103.413 E.00898
G1 X87.314 Y103.489 E.0043
G1 X86.877 Y103.609 E.00891
G1 X86.428 Y103.676 E.00891
G1 X86.21 Y103.689 E.0043
G1 X85.757 Y103.676 E.00891
G1 X85.309 Y103.608 E.00891
G1 X85.096 Y103.557 E.00431
G1 X84.667 Y103.412 E.00891
G1 X84.259 Y103.216 E.00891
G1 X84.07 Y103.105 E.00431
G1 X83.702 Y102.84 E.00891
G1 X83.371 Y102.536 E.00885
G1 X83.078 Y102.195 E.00885
G1 X82.827 Y101.821 E.00885
G1 X82.623 Y101.421 E.00884
G1 X82.462 Y100.981 E.0092
G1 X82.362 Y100.558 E.00856
G1 X82.33 Y100.341 E.0043
G1 X82.305 Y99.889 E.00891
G1 X82.333 Y99.44 E.00885
G1 X82.414 Y98.997 E.00885
G1 X82.547 Y98.567 E.00885
G1 X82.73 Y98.156 E.00885
G1 X82.962 Y97.768 E.0089
G1 X83.102 Y97.576 E.00466
G1 X83.66 Y96.936 E.01671
; WIPE_START
M204 S6000
G1 X81.66 Y96.914 E-.38
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




G1 X79.557 Y96.251
G1 Z5.6
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.136686
G1 F1500
M204 S6000
G1 X79.252 Y96.092 E.0019
; LINE_WIDTH: 0.152723
G1 X79.187 Y96.034 E.00055
G1 X79.015 Y95.805 E.00181
; LINE_WIDTH: 0.104349
G1 X78.956 Y95.617 E.00077
; WIPE_START
G1 X79.015 Y95.805 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X84.644 Y97.164 Z6 F18000
G1 Z5.6
G1 E.4 F1800
; LINE_WIDTH: 0.47709
G1 F1500
M204 S6000
G1 X84.463 Y97.318 E.00536
; LINE_WIDTH: 0.438067
G1 X84.254 Y97.496 E.00564
; LINE_WIDTH: 0.400309
G1 X84.08 Y97.673 E.00464
; LINE_WIDTH: 0.359947
G1 X83.886 Y97.872 E.00463
G1 X83.586 Y98.267 E.00827
G1 X83.398 Y98.591 E.00625
G1 X83.253 Y98.947 E.00642
G1 X83.127 Y99.467 E.00892
G1 X83.097 Y99.891 E.00708
G1 X83.117 Y100.256 E.0061
G1 X83.22 Y100.756 E.00851
G1 X83.387 Y101.189 E.00773
G1 X83.66 Y101.652 E.00896
G1 X83.941 Y101.985 E.00726
G1 X84.202 Y102.222 E.00589
G1 X84.457 Y102.408 E.00526
G1 X84.929 Y102.665 E.00896
G1 X85.401 Y102.816 E.00827
G1 X85.827 Y102.888 E.00721
G1 X86.352 Y102.885 E.00874
G1 X86.713 Y102.835 E.00609
G1 X87.066 Y102.738 E.0061
G1 X87.554 Y102.517 E.00893
G1 X87.986 Y102.223 E.00872
G1 X88.239 Y101.993 E.00569
G1 X88.564 Y101.601 E.00849
G1 X88.838 Y101.113 E.00933
G1 X88.963 Y100.781 E.00591
G1 X89.05 Y100.409 E.00636
G1 X89.092 Y99.903 E.00846
G1 X89.045 Y99.372 E.00889
G1 X88.956 Y99.017 E.00611
G1 X88.758 Y98.53 E.00876
M73 P94 R1
G1 X88.561 Y98.201 E.00639
G1 X88.233 Y97.797 E.00868
; LINE_WIDTH: 0.382444
G1 X87.971 Y97.531 E.00666
; LINE_WIDTH: 0.426799
G1 X87.845 Y97.417 E.00339
; LINE_WIDTH: 0.467967
G1 X87.713 Y97.305 E.00383
; LINE_WIDTH: 0.465143
G1 X87.545 Y97.336 E.00374
; LINE_WIDTH: 0.437282
G1 X87.378 Y97.367 E.0035
; WIPE_START
G1 X87.545 Y97.336 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X93.996 Y95.559 Z6 F18000
G1 Z5.6
G1 E.4 F1800
; LINE_WIDTH: 0.163432
G1 F1500
M204 S6000
G1 X94.336 Y95.427 E.0025
; LINE_WIDTH: 0.129958
G1 X94.677 Y95.296 E.00189
; LINE_WIDTH: 0.0964845
G1 X95.017 Y95.165 E.00129
; WIPE_START
G1 X94.677 Y95.296 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X89.605 Y89.592 Z6 F18000
G1 X78.948 Y77.604 Z6
G1 Z5.6
G1 E.4 F1800
; LINE_WIDTH: 0.0909981
G1 F1500
M204 S6000
G1 X78.989 Y77.486 E.00041
; LINE_WIDTH: 0.12113
G1 X79.03 Y77.367 E.0006
; LINE_WIDTH: 0.154299
G1 X79.207 Y77.151 E.00179
G1 X79.316 Y77.068 E.00088
; LINE_WIDTH: 0.125196
G1 X79.488 Y76.991 E.00094
; LINE_WIDTH: 0.0895908
G1 X79.591 Y76.955 E.00035
; CHANGE_LAYER
; Z_HEIGHT: 5.72
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F1500
G1 X79.488 Y76.991 E-.38
; WIPE_END
G1 E-.02 F1800
; layer num/total_layer_count: 55/57
; update layer progress
M73 L55
M991 S0 P54 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z6 I-.303 J1.179 P1  F18000
G1 X93.468 Y80.581 Z6
G1 Z5.72
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X93.475 Y88.382 E.1651
G1 X93.114 Y88.382 E.00764
G1 X93.114 Y77.128 E.23818
G1 X93.299 Y77.076 E.00407
G1 X93.379 Y77.207 E.00325
G1 X93.436 Y77.349 E.00324
G1 X93.465 Y77.49 E.00306
G1 X93.468 Y80.521 E.06416
; WIPE_START
M204 S6000
G1 X93.469 Y82.521 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X93.576 Y90.153 Z6.12 F18000
G1 X93.651 Y95.57 Z6.12
G1 Z5.72
G1 E.4 F1800
G1 F1500
M204 S500
G1 X93.122 Y95.806 E.01227
G1 X93.14 Y95.498 E.00653
G1 X93.166 Y95.414 E.00187
G1 X93.212 Y95.37 E.00135
G1 X93.295 Y95.347 E.00183
G1 X93.367 Y95.368 E.00158
G1 X93.602 Y95.535 E.00611
; WIPE_START
M204 S6000
G1 X93.122 Y95.806 E-.14343
G1 X93.14 Y95.498 E-.08023
G1 X93.166 Y95.414 E-.0229
G1 X93.212 Y95.37 E-.01655
G1 X93.295 Y95.347 E-.0225
G1 X93.367 Y95.368 E-.01941
G1 X93.602 Y95.535 E-.07498
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X86.091 Y96.889 Z6.12 F18000
G1 X84.86 Y97.11 Z6.12
G1 Z5.72
G1 E.4 F1800
G1 F1500
M204 S500
G1 X84.753 Y96.949 E.0041
G1 X85.105 Y96.544 E.01135
G1 X87.084 Y96.544 E.04188
G1 X87.435 Y96.948 E.01133
G1 X87.307 Y97.113 E.00442
G1 X87.208 Y97.064 E.00235
G1 X86.698 Y96.915 E.01123
G1 X86.322 Y96.864 E.00803
G1 X85.95 Y96.858 E.00787
G1 X85.417 Y96.929 E.01139
G1 X84.917 Y97.092 E.01113
; WIPE_START
M204 S6000
G1 X84.753 Y96.949 E-.04131
G1 X85.105 Y96.544 E-.10187
G1 X86.351 Y96.544 E-.23682
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X83.485 Y100.073 Z6.12 F18000
G1 Z5.72
G1 E.4 F1800
G1 F1500
M204 S500
G1 X83.474 Y99.979 E.002
G1 X83.502 Y99.509 E.00996
G1 X83.614 Y99.055 E.0099
G1 X83.734 Y98.764 E.00667
G1 X83.891 Y98.482 E.00682
G1 X84.167 Y98.125 E.00956
G1 X84.4 Y97.902 E.00683
G1 X84.658 Y97.708 E.00683
G1 X85.064 Y97.49 E.00975
G1 X85.512 Y97.345 E.00996
G1 X85.975 Y97.283 E.0099
G1 X86.29 Y97.288 E.00667
G1 X86.61 Y97.331 E.00682
G1 X87.052 Y97.46 E.00975
G1 X87.464 Y97.666 E.00975
G1 X87.728 Y97.852 E.00683
G1 X87.968 Y98.068 E.00683
G1 X88.255 Y98.417 E.00955
G1 X88.42 Y98.694 E.00683
G1 X88.551 Y98.989 E.00683
G1 X88.674 Y99.433 E.00975
G1 X88.716 Y99.901 E.00995
G1 X88.675 Y100.36 E.00975
G1 X88.598 Y100.673 E.00682
G1 X88.488 Y100.968 E.00668
G1 X88.261 Y101.377 E.0099
G1 X87.962 Y101.741 E.00996
G1 X87.603 Y102.045 E.00995
G1 X87.205 Y102.275 E.00975
G1 X86.904 Y102.393 E.00683
G1 X86.592 Y102.474 E.00683
G1 X86.134 Y102.522 E.00975
G1 X85.674 Y102.488 E.00975
G1 X85.36 Y102.416 E.00683
G1 X85.056 Y102.307 E.00683
G1 X84.65 Y102.089 E.00975
G1 X84.283 Y101.796 E.00995
G1 X83.973 Y101.441 E.00996
G1 X83.734 Y101.039 E.0099
G1 X83.615 Y100.748 E.00667
G1 X83.529 Y100.437 E.00683
G1 X83.492 Y100.133 E.00648
M204 S250
G1 X83.891 Y100.024 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X83.885 Y99.967 E.00113
G1 X83.908 Y99.571 E.0078
G1 X84.004 Y99.183 E.00787
G1 X84.103 Y98.942 E.00512
G1 X84.233 Y98.708 E.00526
G1 X84.472 Y98.4 E.00768
G1 X84.665 Y98.215 E.00526
G1 X84.879 Y98.054 E.00526
G1 X85.226 Y97.868 E.00774
G1 X85.603 Y97.745 E.0078
G1 X85.999 Y97.693 E.00787
G1 X86.26 Y97.697 E.00512
G1 X86.525 Y97.733 E.00526
G1 X86.902 Y97.843 E.00774
G1 X87.254 Y98.019 E.00773
G1 X87.473 Y98.173 E.00526
G1 X87.671 Y98.352 E.00526
G1 X87.919 Y98.653 E.00767
G1 X88.056 Y98.883 E.00526
G1 X88.165 Y99.127 E.00526
G1 X88.27 Y99.506 E.00774
G1 X88.305 Y99.901 E.00779
G1 X88.27 Y100.292 E.00773
G1 X88.207 Y100.552 E.00526
G1 X88.115 Y100.796 E.00513
G1 X87.921 Y101.146 E.00787
G1 X87.669 Y101.452 E.0078
G1 X87.367 Y101.709 E.0078
G1 X87.027 Y101.905 E.00773
G1 X86.777 Y102.003 E.00526
G1 X86.519 Y102.07 E.00526
G1 X86.127 Y102.111 E.00774
G1 X85.735 Y102.082 E.00773
G1 X85.474 Y102.023 E.00526
G1 X85.223 Y101.932 E.00526
G1 X84.877 Y101.746 E.00773
G1 X84.567 Y101.499 E.0078
G1 X84.306 Y101.2 E.0078
G1 X84.101 Y100.856 E.00787
G1 X84.003 Y100.615 E.00512
G1 X83.931 Y100.357 E.00526
G1 X83.899 Y100.084 E.00542
; WIPE_START
M204 S6000
G1 X83.885 Y99.967 E-.02236
G1 X83.908 Y99.571 E-.07537
G1 X84.004 Y99.183 E-.07598
G1 X84.103 Y98.942 E-.04949
G1 X84.233 Y98.708 E-.05081
G1 X84.472 Y98.4 E-.07416
G1 X84.593 Y98.284 E-.03182
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X84.855 Y96.12 Z6.12 F18000
G1 Z5.72
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X92.678 Y96.12 E.16557
G1 X92.718 Y95.441 E.01439
G1 X92.742 Y95.331 E.00238
G1 X92.784 Y95.227 E.00238
G1 X92.851 Y95.128 E.00252
G1 X92.939 Y95.044 E.00258
G1 X93.072 Y94.968 E.00324
G1 X93.272 Y94.922 E.00435
G1 X93.375 Y94.929 E.00218
G1 X93.525 Y94.971 E.0033
G1 X93.951 Y95.264 E.01094
G1 X95.879 Y94.633 E.04293
G1 X100.747 Y87.68 E.17964
G1 X101.043 Y87.888 E.00765
G1 X96.105 Y94.94 E.18222
G1 X93.244 Y96.216 E.06631
G1 X93.021 Y96.37 E.00573
G1 X92.803 Y96.453 E.00495
G1 X92.559 Y96.482 E.0052
G1 X87.591 Y96.482 E.10514
G1 X88.777 Y97.845 E.03824
G1 X89.1 Y98.356 E.0128
G1 X89.262 Y98.72 E.00842
G1 X89.421 Y99.3 E.01274
G1 X89.474 Y99.902 E.0128
G1 X89.423 Y100.488 E.01245
G1 X89.266 Y101.07 E.01275
G1 X89.009 Y101.613 E.01271
G1 X88.654 Y102.109 E.01292
G1 X88.228 Y102.522 E.01256
G1 X87.737 Y102.855 E.01254
G1 X87.367 Y103.032 E.00868
G1 X86.987 Y103.161 E.0085
G1 X86.585 Y103.245 E.00868
G1 X86.204 Y103.279 E.00811
G1 X85.794 Y103.267 E.00869
G1 X85.211 Y103.164 E.01254
G1 X84.822 Y103.032 E.00869
G1 X84.46 Y102.859 E.00849
G1 X84.121 Y102.644 E.0085
G1 X83.809 Y102.391 E.00849
G1 X83.53 Y102.103 E.00849
G1 X83.288 Y101.784 E.00848
G1 X83.079 Y101.426 E.00877
G1 X82.92 Y101.062 E.00842
G1 X82.766 Y100.489 E.01255
G1 X82.72 Y100.091 E.00849
G1 X82.738 Y99.499 E.01254
G1 X82.814 Y99.087 E.00886
G1 X83.007 Y98.526 E.01255
G1 X83.192 Y98.169 E.0085
G1 X83.417 Y97.838 E.00849
G1 X84.597 Y96.482 E.03805
G1 X79.631 Y96.482 E.10512
G1 X79.392 Y96.454 E.00508
G1 X79.192 Y96.381 E.0045
G1 X79.062 Y96.301 E.00324
G1 X78.884 Y96.119 E.0054
G1 X78.744 Y95.821 E.00696
G1 X78.714 Y95.565 E.00546
G1 X78.714 Y77.62 E.37982
G1 X78.755 Y77.34 E.00597
G1 X78.86 Y77.118 E.00521
G1 X79.022 Y76.933 E.00521
G1 X79.241 Y76.796 E.00547
G1 X79.391 Y76.746 E.00334
G1 X79.552 Y76.723 E.00344
G1 X92.632 Y76.723 E.27685
G1 X92.798 Y76.746 E.00354
G1 X92.942 Y76.794 E.00322
G1 X93.119 Y76.889 E.00424
G1 X93.07 Y77.082 E.0042
G1 X80.049 Y77.082 E.2756
G1 X79.791 Y77.119 E.00552
G1 X79.48 Y77.276 E.00737
G1 X79.241 Y77.529 E.00736
G1 X79.112 Y77.807 E.00649
G1 X79.075 Y78.056 E.00533
G1 X79.075 Y95.146 E.36172
G1 X79.112 Y95.395 E.00533
G1 X79.237 Y95.665 E.00629
G1 X79.435 Y95.886 E.00628
G1 X79.703 Y96.052 E.00668
G1 X80.031 Y96.12 E.00708
G1 X84.795 Y96.12 E.10083
; WIPE_START
M204 S6000
G1 X86.795 Y96.12 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X83.699 Y96.891 Z6.12 F18000
G1 Z5.72
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X79.607 Y96.891 E.08049
G1 X79.297 Y96.855 E.00613
G1 X79.013 Y96.751 E.00594
G1 X78.822 Y96.633 E.00442
G1 X78.712 Y96.541 E.00283
G1 X78.558 Y96.368 E.00454
G1 X78.479 Y96.248 E.00283
G1 X78.382 Y96.039 E.00454
G1 X78.341 Y95.904 E.00277
G1 X78.304 Y95.589 E.00625
G1 X78.304 Y77.607 E.35368
G1 X78.314 Y77.45 E.00311
G1 X78.36 Y77.228 E.00445
G1 X78.409 Y77.093 E.00283
G1 X78.517 Y76.892 E.00448
G1 X78.659 Y76.714 E.00448
G1 X78.763 Y76.615 E.00283
G1 X78.952 Y76.483 E.00453
G1 X79.085 Y76.416 E.00292
G1 X79.297 Y76.346 E.00439
G1 X79.522 Y76.313 E.00448
G1 X92.662 Y76.313 E.25843
G1 X92.892 Y76.347 E.00458
G1 X93.105 Y76.417 E.00441
G1 X93.303 Y76.524 E.00442
G1 X93.479 Y76.663 E.00442
G1 X93.629 Y76.831 E.00442
G1 X93.746 Y77.022 E.00442
G1 X93.829 Y77.231 E.00442
G1 X93.874 Y77.448 E.00436
G1 X93.884 Y88.791 E.2231
G1 X92.704 Y88.791 E.02321
G1 X92.704 Y77.491 E.22226
G1 X80.079 Y77.491 E.24833
G1 X79.916 Y77.515 E.00325
G1 X79.728 Y77.609 E.00413
G1 X79.584 Y77.762 E.00413
G1 X79.508 Y77.925 E.00355
G1 X79.484 Y78.086 E.00319
G1 X79.484 Y95.116 E.33497
G1 X79.508 Y95.277 E.00319
G1 X79.583 Y95.437 E.00349
G1 X79.701 Y95.57 E.00349
G1 X79.857 Y95.666 E.00361
G1 X80.073 Y95.711 E.00434
G1 X92.292 Y95.711 E.24034
G1 X92.312 Y95.386 E.00639
G1 X92.349 Y95.211 E.00353
G1 X92.417 Y95.044 E.00353
G1 X92.545 Y94.855 E.0045
G1 X92.677 Y94.728 E.0036
G1 X92.925 Y94.584 E.00565
G1 X93.161 Y94.521 E.00481
G1 X93.445 Y94.523 E.00559
G1 X93.677 Y94.589 E.00475
G1 X93.83 Y94.669 E.00339
G1 X94.023 Y94.81 E.0047
G1 X95.622 Y94.286 E.03309
G1 X100.647 Y87.111 E.1723
G1 X101.613 Y87.787 E.02321
G1 X96.375 Y95.268 E.17961
G1 X93.445 Y96.575 E.06311
G1 X93.229 Y96.723 E.00516
G1 X93.102 Y96.786 E.00279
G1 X92.891 Y96.855 E.00437
G1 X92.582 Y96.891 E.00611
G1 X88.49 Y96.891 E.08049
G1 X89.098 Y97.59 E.01822
G1 X89.226 Y97.767 E.0043
G1 X89.464 Y98.168 E.00917
G1 X89.643 Y98.57 E.00865
G1 X89.714 Y98.777 E.00431
G1 X89.823 Y99.22 E.00897
G1 X89.856 Y99.436 E.0043
G1 X89.884 Y99.902 E.00917
G1 X89.859 Y100.341 E.00865
G1 X89.827 Y100.56 E.00436
G1 X89.778 Y100.79 E.00463
G1 X89.65 Y101.211 E.00865
G1 X89.469 Y101.627 E.00891
G1 X89.236 Y102.02 E.00898
G1 X88.968 Y102.372 E.00871
G1 X88.811 Y102.543 E.00457
G1 X88.486 Y102.84 E.00865
G1 X88.119 Y103.105 E.00891
G1 X87.93 Y103.216 E.00431
G1 X87.522 Y103.412 E.00891
G1 X87.095 Y103.556 E.00885
G1 X86.652 Y103.649 E.00891
G1 X86.432 Y103.676 E.00437
G1 X86.21 Y103.689 E.00436
G1 X85.757 Y103.676 E.00891
G1 X85.309 Y103.608 E.00891
G1 X85.097 Y103.557 E.0043
G1 X84.667 Y103.412 E.00891
G1 X84.261 Y103.218 E.00885
G1 X83.881 Y102.977 E.00885
G1 X83.532 Y102.693 E.00885
G1 X83.219 Y102.37 E.00885
G1 X82.947 Y102.012 E.00885
G1 X82.713 Y101.612 E.00911
G1 X82.537 Y101.209 E.00865
G1 X82.468 Y101.001 E.0043
G1 X82.363 Y100.56 E.00891
G1 X82.311 Y100.114 E.00885
G1 X82.312 Y99.661 E.00891
G1 X82.332 Y99.443 E.00431
G1 X82.415 Y98.994 E.00897
G1 X82.477 Y98.771 E.00457
G1 X82.633 Y98.359 E.00865
G1 X82.84 Y97.96 E.00885
G1 X83.093 Y97.588 E.00885
G1 X83.659 Y96.936 E.01698
; WIPE_START
M204 S6000
M73 P95 R1
G1 X81.66 Y96.914 E-.38
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




G1 X79.557 Y96.251
G1 Z5.72
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.146391
G1 F1500
M204 S6000
G1 X79.251 Y96.091 E.00208
G1 X79.111 Y95.949 E.0012
G1 X79.012 Y95.802 E.00107
; LINE_WIDTH: 0.102266
G1 X78.956 Y95.617 E.00074
; WIPE_START
G1 X79.012 Y95.802 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X84.643 Y97.167 Z6.12 F18000
G1 Z5.72
G1 E.4 F1800
; LINE_WIDTH: 0.47981
G1 F1500
M204 S6000
G1 X84.412 Y97.353 E.00672
; LINE_WIDTH: 0.447045
G1 X84.283 Y97.473 E.00371
; LINE_WIDTH: 0.407544
G1 X84.138 Y97.609 E.00378
; LINE_WIDTH: 0.360174
G1 X83.722 Y98.073 E.01039
G1 X83.52 Y98.365 E.00593
G1 X83.357 Y98.679 E.00591
G1 X83.188 Y99.179 E.00879
G1 X83.118 Y99.546 E.00623
G1 X83.098 Y100.005 E.00768
G1 X83.156 Y100.497 E.00827
G1 X83.262 Y100.878 E.00659
G1 X83.42 Y101.255 E.00682
G1 X83.677 Y101.674 E.0082
G1 X84.032 Y102.079 E.00898
G1 X84.43 Y102.395 E.00848
G1 X84.891 Y102.647 E.00876
G1 X85.263 Y102.782 E.0066
G1 X85.63 Y102.859 E.00626
G1 X86.124 Y102.9 E.00827
G1 X86.647 Y102.847 E.00876
G1 X87.011 Y102.754 E.00627
G1 X87.379 Y102.609 E.0066
G1 X87.806 Y102.358 E.00827
G1 X88.249 Y101.988 E.00963
G1 X88.588 Y101.569 E.00899
G1 X88.835 Y101.115 E.00863
G1 X89.01 Y100.596 E.00914
G1 X89.069 Y100.258 E.00572
G1 X89.095 Y99.903 E.00594
G1 X89.045 Y99.38 E.00876
G1 X88.953 Y99.004 E.00647
G1 X88.762 Y98.531 E.00851
G1 X88.554 Y98.191 E.00665
G1 X88.234 Y97.797 E.00847
; LINE_WIDTH: 0.382482
G1 X87.97 Y97.53 E.00667
; LINE_WIDTH: 0.4269
G1 X87.845 Y97.417 E.00338
; LINE_WIDTH: 0.468081
G1 X87.72 Y97.304 E.00372
G1 X87.697 Y97.308 E.0005
; LINE_WIDTH: 0.44301
G1 X87.538 Y97.338 E.00337
; LINE_WIDTH: 0.416278
G1 X87.379 Y97.367 E.00316
; WIPE_START
G1 X87.538 Y97.338 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X93.996 Y95.559 Z6.12 F18000
G1 Z5.72
G1 E.4 F1800
; LINE_WIDTH: 0.163452
G1 F1500
M204 S6000
G1 X94.336 Y95.428 E.0025
; LINE_WIDTH: 0.12997
G1 X94.676 Y95.296 E.0019
; LINE_WIDTH: 0.0964888
G1 X95.017 Y95.165 E.00129
; WIPE_START
G1 X94.676 Y95.296 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X89.606 Y89.592 Z6.12 F18000
G1 X78.949 Y77.601 Z6.12
G1 Z5.72
G1 E.4 F1800
; LINE_WIDTH: 0.0995577
G1 F1500
M204 S6000
G1 X79.019 Y77.388 E.00083
; LINE_WIDTH: 0.157058
G1 X79.095 Y77.275 E.00089
G1 X79.299 Y77.071 E.00188
; LINE_WIDTH: 0.12938
G1 X79.452 Y77 E.00087
; LINE_WIDTH: 0.0983177
G1 X79.599 Y76.955 E.00055
; CHANGE_LAYER
; Z_HEIGHT: 5.84
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F1500
G1 X79.452 Y77 E-.38
; WIPE_END
G1 E-.02 F1800
; layer num/total_layer_count: 56/57
; update layer progress
M73 L56
M991 S0 P55 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z6.12 I-.301 J1.179 P1  F18000
G1 X93.468 Y80.581 Z6.12
G1 Z5.84
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X93.475 Y88.382 E.1651
G1 X93.114 Y88.382 E.00764
G1 X93.114 Y77.128 E.23818
G1 X93.299 Y77.076 E.00407
G1 X93.379 Y77.207 E.00325
G1 X93.436 Y77.349 E.00324
G1 X93.465 Y77.49 E.00305
G1 X93.468 Y80.521 E.06415
; WIPE_START
M204 S6000
G1 X93.469 Y82.521 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X93.584 Y90.153 Z6.24 F18000
G1 X93.665 Y95.564 Z6.24
G1 Z5.84
G1 E.4 F1800
G1 F1500
M204 S500
G1 X93.115 Y95.809 E.01276
G1 X93.145 Y95.465 E.00732
G1 X93.166 Y95.414 E.00116
G1 X93.212 Y95.37 E.00135
G1 X93.32 Y95.341 E.00236
G1 X93.615 Y95.531 E.00743
; WIPE_START
M204 S6000
G1 X93.115 Y95.809 E-.14501
G1 X93.145 Y95.465 E-.08767
G1 X93.166 Y95.414 E-.01386
G1 X93.212 Y95.37 E-.01617
G1 X93.32 Y95.341 E-.02828
G1 X93.615 Y95.531 E-.089
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X86.103 Y96.886 Z6.24 F18000
G1 X84.86 Y97.11 Z6.24
G1 Z5.84
G1 E.4 F1800
G1 F1500
M204 S500
G1 X84.753 Y96.949 E.0041
G1 X85.105 Y96.544 E.01135
G1 X87.084 Y96.544 E.04187
G1 X87.435 Y96.948 E.01133
G1 X87.307 Y97.113 E.00442
G1 X87.208 Y97.064 E.00234
G1 X86.699 Y96.915 E.01123
G1 X86.322 Y96.864 E.00804
G1 X85.948 Y96.858 E.00793
G1 X85.417 Y96.929 E.01133
G1 X84.917 Y97.092 E.01113
; WIPE_START
M204 S6000
G1 X84.753 Y96.949 E-.04131
G1 X85.105 Y96.544 E-.10188
G1 X86.352 Y96.544 E-.23681
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X83.486 Y100.082 Z6.24 F18000
G1 Z5.84
G1 E.4 F1800
G1 F1500
M204 S500
G1 X83.474 Y99.979 E.00218
G1 X83.502 Y99.51 E.00995
G1 X83.613 Y99.054 E.00995
G1 X83.801 Y98.633 E.00975
G1 X83.974 Y98.361 E.00683
G1 X84.179 Y98.111 E.00683
G1 X84.515 Y97.809 E.00955
G1 X84.784 Y97.632 E.00683
G1 X85.073 Y97.487 E.00683
G1 X85.512 Y97.345 E.00976
G1 X85.973 Y97.283 E.00984
G1 X86.29 Y97.288 E.00673
G1 X86.61 Y97.331 E.00683
G1 X87.052 Y97.46 E.00975
G1 X87.464 Y97.666 E.00975
G1 X87.728 Y97.852 E.00683
G1 X87.968 Y98.069 E.00684
G1 X88.257 Y98.421 E.00965
G1 X88.42 Y98.694 E.00673
G1 X88.551 Y98.989 E.00683
G1 X88.674 Y99.433 E.00975
G1 X88.716 Y99.901 E.00995
G1 X88.674 Y100.369 E.00995
G1 X88.549 Y100.822 E.00996
G1 X88.346 Y101.241 E.00985
G1 X88.167 Y101.504 E.00673
G1 X87.955 Y101.747 E.00682
G1 X87.603 Y102.045 E.00976
G1 X87.2 Y102.277 E.00985
G1 X86.904 Y102.393 E.00673
G1 X86.592 Y102.474 E.00682
G1 X86.143 Y102.521 E.00956
G1 X85.821 Y102.507 E.00683
G1 X85.502 Y102.454 E.00684
G1 X85.064 Y102.312 E.00975
G1 X84.65 Y102.089 E.00995
G1 X84.283 Y101.796 E.00995
G1 X83.973 Y101.442 E.00996
G1 X83.735 Y101.042 E.00985
G1 X83.615 Y100.748 E.00673
G1 X83.529 Y100.437 E.00683
G1 X83.493 Y100.141 E.0063
M204 S250
G1 X83.892 Y100.033 F18000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X83.885 Y99.967 E.0013
G1 X83.908 Y99.571 E.0078
G1 X84.002 Y99.186 E.0078
G1 X84.162 Y98.827 E.00773
G1 X84.306 Y98.602 E.00526
G1 X84.476 Y98.395 E.00526
G1 X84.766 Y98.134 E.00767
G1 X84.989 Y97.987 E.00526
G1 X85.228 Y97.867 E.00526
G1 X85.603 Y97.745 E.00774
G1 X85.997 Y97.693 E.00782
G1 X86.26 Y97.697 E.00517
G1 X86.525 Y97.733 E.00526
G1 X86.902 Y97.843 E.00773
G1 X87.254 Y98.019 E.00773
G1 X87.473 Y98.173 E.00526
G1 X87.672 Y98.352 E.00527
G1 X87.922 Y98.657 E.00776
G1 X88.056 Y98.883 E.00517
G1 X88.165 Y99.127 E.00526
G1 X88.27 Y99.506 E.00773
G1 X88.305 Y99.901 E.00779
G1 X88.27 Y100.296 E.0078
G1 X88.164 Y100.678 E.0078
G1 X87.991 Y101.036 E.00782
G1 X87.843 Y101.253 E.00518
G1 X87.667 Y101.454 E.00526
G1 X87.367 Y101.709 E.00774
G1 X87.022 Y101.907 E.00782
G1 X86.777 Y102.003 E.00518
G1 X86.519 Y102.07 E.00526
G1 X86.131 Y102.111 E.00768
G1 X85.863 Y102.099 E.00526
G1 X85.599 Y102.055 E.00527
G1 X85.225 Y101.934 E.00773
G1 X84.876 Y101.746 E.0078
G1 X84.567 Y101.499 E.0078
G1 X84.306 Y101.2 E.0078
G1 X84.102 Y100.859 E.00782
G1 X84.003 Y100.615 E.00517
G1 X83.931 Y100.357 E.00526
G1 X83.9 Y100.092 E.00525
; WIPE_START
M204 S6000
G1 X83.885 Y99.967 E-.02398
G1 X83.908 Y99.571 E-.07533
G1 X84.002 Y99.186 E-.0753
G1 X84.162 Y98.827 E-.07469
G1 X84.306 Y98.602 E-.05084
G1 X84.476 Y98.395 E-.05083
G1 X84.59 Y98.293 E-.02903
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X84.855 Y96.12 Z6.24 F18000
G1 Z5.84
G1 E.4 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F1500
M204 S500
G1 X92.661 Y96.12 E.16522
G1 X92.738 Y95.339 E.01661
G1 X92.783 Y95.229 E.00252
G1 X92.851 Y95.128 E.00257
G1 X92.932 Y95.05 E.00238
G1 X93.063 Y94.97 E.00324
G1 X93.272 Y94.922 E.00455
G1 X93.443 Y94.941 E.00364
G1 X93.539 Y94.978 E.00218
G1 X93.972 Y95.257 E.01091
G1 X95.879 Y94.633 E.04247
G1 X100.747 Y87.68 E.17964
G1 X101.043 Y87.888 E.00765
G1 X96.105 Y94.94 E.18222
G1 X93.244 Y96.216 E.0663
G1 X93.021 Y96.37 E.00573
G1 X92.803 Y96.453 E.00495
G1 X92.559 Y96.482 E.0052
G1 X87.591 Y96.482 E.10514
G1 X88.777 Y97.845 E.03824
G1 X88.993 Y98.161 E.00811
G1 X89.258 Y98.71 E.0129
G1 X89.376 Y99.095 E.00852
G1 X89.449 Y99.49 E.0085
G1 X89.475 Y99.899 E.00868
G1 X89.421 Y100.497 E.01271
G1 X89.266 Y101.069 E.01255
G1 X89.008 Y101.613 E.01274
G1 X88.779 Y101.954 E.00869
G1 X88.53 Y102.245 E.0081
G1 X88.228 Y102.522 E.00868
G1 X87.895 Y102.761 E.00867
G1 X87.543 Y102.955 E.00851
G1 X86.978 Y103.164 E.01274
G1 X86.386 Y103.269 E.01273
G1 X85.794 Y103.267 E.01254
G1 X85.211 Y103.164 E.01254
G1 X84.822 Y103.032 E.00869
G1 X84.46 Y102.859 E.00848
G1 X84.114 Y102.639 E.00867
G1 X83.672 Y102.258 E.01237
G1 X83.404 Y101.947 E.00869
G1 X83.181 Y101.613 E.00849
G1 X82.998 Y101.256 E.00849
G1 X82.857 Y100.872 E.00867
G1 X82.738 Y100.3 E.01237
G1 X82.715 Y99.89 E.00869
G1 X82.74 Y99.49 E.00849
G1 X82.812 Y99.095 E.00849
G1 X82.934 Y98.704 E.00867
G1 X83.098 Y98.337 E.00851
G1 X83.417 Y97.838 E.01254
G1 X84.597 Y96.482 E.03805
G1 X79.63 Y96.482 E.10513
G1 X79.383 Y96.453 E.00527
G1 X79.238 Y96.405 E.00324
G1 X79.024 Y96.27 E.00534
G1 X78.83 Y96.032 E.00651
G1 X78.744 Y95.821 E.00482
G1 X78.714 Y95.565 E.00546
G1 X78.714 Y77.619 E.37983
G1 X78.755 Y77.341 E.00596
G1 X78.86 Y77.118 E.00521
G1 X79.024 Y76.932 E.00526
G1 X79.155 Y76.84 E.00338
G1 X79.302 Y76.772 E.00342
G1 X79.552 Y76.723 E.0054
G1 X92.634 Y76.723 E.27688
G1 X92.797 Y76.746 E.0035
G1 X92.942 Y76.794 E.00323
G1 X93.119 Y76.889 E.00424
G1 X93.07 Y77.082 E.0042
G1 X80.049 Y77.082 E.2756
G1 X79.791 Y77.12 E.00553
G1 X79.48 Y77.276 E.00736
G1 X79.241 Y77.529 E.00736
G1 X79.112 Y77.807 E.00649
G1 X79.075 Y78.056 E.00533
G1 X79.075 Y95.146 E.36173
G1 X79.112 Y95.395 E.00532
G1 X79.237 Y95.664 E.00629
G1 X79.435 Y95.887 E.0063
G1 X79.704 Y96.053 E.00668
G1 X80.031 Y96.12 E.00708
G1 X84.795 Y96.12 E.10084
; WIPE_START
M204 S6000
G1 X86.795 Y96.12 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X83.699 Y96.891 Z6.24 F18000
G1 Z5.84
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X79.607 Y96.891 E.08049
G1 X79.294 Y96.854 E.00619
G1 X79.081 Y96.784 E.00442
G1 X78.952 Y96.719 E.00283
G1 X78.766 Y96.589 E.00448
G1 X78.661 Y96.49 E.00283
G1 X78.477 Y96.243 E.00606
G1 X78.383 Y96.042 E.00436
M73 P96 R1
G1 X78.341 Y95.904 E.00283
G1 X78.304 Y95.589 E.00625
G1 X78.304 Y77.607 E.35368
G1 X78.314 Y77.451 E.00307
G1 X78.36 Y77.228 E.00448
G1 X78.41 Y77.09 E.00289
G1 X78.517 Y76.893 E.00442
G1 X78.658 Y76.714 E.00448
G1 X78.765 Y76.613 E.00289
G1 X78.95 Y76.484 E.00442
G1 X79.156 Y76.388 E.00448
G1 X79.297 Y76.346 E.00289
G1 X79.522 Y76.313 E.00448
G1 X92.663 Y76.313 E.25847
G1 X92.892 Y76.346 E.00454
G1 X93.105 Y76.417 E.00441
G1 X93.303 Y76.524 E.00442
G1 X93.479 Y76.663 E.00442
G1 X93.629 Y76.831 E.00442
G1 X93.746 Y77.022 E.00442
G1 X93.829 Y77.231 E.00442
G1 X93.874 Y77.448 E.00436
G1 X93.884 Y88.791 E.2231
G1 X92.704 Y88.791 E.02321
G1 X92.704 Y77.491 E.22226
G1 X80.079 Y77.491 E.24833
G1 X79.916 Y77.515 E.00325
G1 X79.728 Y77.609 E.00412
G1 X79.584 Y77.762 E.00413
G1 X79.508 Y77.925 E.00355
G1 X79.484 Y78.086 E.00319
G1 X79.484 Y95.116 E.33498
G1 X79.508 Y95.276 E.00318
G1 X79.583 Y95.437 E.00349
G1 X79.701 Y95.57 E.00349
G1 X79.857 Y95.666 E.00361
G1 X80.073 Y95.711 E.00433
M73 P96 R0
G1 X92.287 Y95.711 E.24023
G1 X92.321 Y95.324 E.00763
G1 X92.416 Y95.047 E.00577
G1 X92.545 Y94.855 E.00455
G1 X92.674 Y94.73 E.00353
G1 X92.922 Y94.585 E.00565
G1 X93.161 Y94.521 E.00487
G1 X93.451 Y94.524 E.00571
G1 X93.725 Y94.611 E.00565
G1 X94.03 Y94.807 E.00714
G1 X95.622 Y94.286 E.03294
G1 X100.647 Y87.111 E.1723
G1 X101.613 Y87.787 E.02321
G1 X96.375 Y95.268 E.17961
G1 X93.445 Y96.574 E.0631
G1 X93.229 Y96.723 E.00516
G1 X93.102 Y96.786 E.00279
G1 X92.891 Y96.855 E.00436
G1 X92.582 Y96.891 E.00611
G1 X88.49 Y96.891 E.08049
G1 X89.098 Y97.59 E.01822
G1 X89.348 Y97.957 E.00873
G1 X89.558 Y98.362 E.00897
G1 X89.643 Y98.572 E.00447
G1 X89.775 Y98.997 E.00874
G1 X89.856 Y99.44 E.00885
G1 X89.884 Y99.892 E.0089
G1 X89.878 Y100.11 E.0043
G1 X89.824 Y100.569 E.00908
G1 X89.721 Y101.001 E.00874
G1 X89.564 Y101.425 E.00889
G1 X89.362 Y101.821 E.00875
G1 X89.109 Y102.197 E.00891
G1 X88.82 Y102.534 E.00872
G1 X88.487 Y102.84 E.00891
G1 X88.114 Y103.107 E.00902
G1 X87.725 Y103.322 E.00874
G1 X87.524 Y103.411 E.00431
G1 X87.092 Y103.557 E.00897
G1 X86.88 Y103.608 E.0043
G1 X86.428 Y103.676 E.00898
G1 X86.21 Y103.689 E.0043
G1 X85.757 Y103.676 E.00891
G1 X85.309 Y103.608 E.00891
G1 X85.096 Y103.557 E.0043
G1 X84.667 Y103.412 E.00891
G1 X84.262 Y103.218 E.00885
G1 X83.874 Y102.972 E.00902
G1 X83.53 Y102.691 E.00874
G1 X83.373 Y102.538 E.00431
G1 X83.078 Y102.195 E.00891
G1 X82.827 Y101.821 E.00885
G1 X82.623 Y101.42 E.00885
G1 X82.465 Y100.99 E.00902
G1 X82.362 Y100.558 E.00874
G1 X82.33 Y100.341 E.00431
G1 X82.305 Y99.889 E.00891
G1 X82.333 Y99.44 E.00885
G1 X82.414 Y98.997 E.00885
G1 X82.55 Y98.559 E.00902
G1 X82.731 Y98.154 E.00874
G1 X82.838 Y97.962 E.00431
G1 X83.093 Y97.588 E.00891
G1 X83.66 Y96.936 E.01698
; WIPE_START
M204 S6000
G1 X81.66 Y96.914 E-.38
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




G1 X79.557 Y96.251
G1 Z5.84
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.146551
G1 F1500
M204 S6000
G1 X79.253 Y96.09 E.00207
G1 X79.177 Y96.023 E.00061
G1 X79.013 Y95.803 E.00165
; LINE_WIDTH: 0.102217
G1 X78.956 Y95.617 E.00074
; WIPE_START
G1 X79.013 Y95.803 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X84.642 Y97.165 Z6.24 F18000
G1 Z5.84
G1 E.4 F1800
; LINE_WIDTH: 0.477102
G1 F1500
M204 S6000
G1 X84.461 Y97.319 E.00534
; LINE_WIDTH: 0.438379
G1 X84.254 Y97.496 E.00562
; LINE_WIDTH: 0.40096
G1 X84.085 Y97.669 E.00453
; LINE_WIDTH: 0.359927
G1 X83.72 Y98.071 E.00905
G1 X83.514 Y98.373 E.0061
G1 X83.291 Y98.841 E.00865
G1 X83.186 Y99.187 E.00603
G1 X83.119 Y99.536 E.00592
G1 X83.1 Y100.005 E.00783
G1 X83.161 Y100.522 E.00867
G1 X83.255 Y100.86 E.00585
G1 X83.348 Y101.104 E.00435
G1 X83.512 Y101.418 E.00592
G1 X83.706 Y101.714 E.00589
G1 X84.06 Y102.105 E.00878
G1 X84.455 Y102.411 E.00834
G1 X84.929 Y102.665 E.00896
G1 X85.401 Y102.817 E.00826
G1 X85.791 Y102.884 E.0066
G1 X86.142 Y102.9 E.00585
G1 X86.647 Y102.844 E.00847
G1 X87.01 Y102.753 E.00625
G1 X87.379 Y102.612 E.00657
G1 X87.807 Y102.361 E.00828
G1 X88.211 Y102.025 E.00877
G1 X88.473 Y101.729 E.00659
G1 X88.68 Y101.423 E.00615
G1 X88.909 Y100.942 E.00888
G1 X89.048 Y100.431 E.00883
G1 X89.094 Y99.916 E.00862
G1 X89.041 Y99.351 E.00945
G1 X88.908 Y98.874 E.00826
G1 X88.75 Y98.512 E.00658
G1 X88.559 Y98.194 E.00618
G1 X88.234 Y97.798 E.00855
; LINE_WIDTH: 0.382442
G1 X87.97 Y97.53 E.00668
; LINE_WIDTH: 0.426894
G1 X87.845 Y97.417 E.00338
; LINE_WIDTH: 0.468081
G1 X87.72 Y97.304 E.00372
G1 X87.697 Y97.308 E.0005
; LINE_WIDTH: 0.443182
G1 X87.538 Y97.338 E.00338
; LINE_WIDTH: 0.416402
G1 X87.379 Y97.367 E.00316
; WIPE_START
G1 X87.538 Y97.338 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X94.029 Y95.546 Z6.24 F18000
G1 Z5.84
G1 E.4 F1800
; LINE_WIDTH: 0.152233
G1 F1500
M204 S6000
G1 X94.523 Y95.356 E.00334
; LINE_WIDTH: 0.103909
G1 X95.017 Y95.165 E.00206
; WIPE_START
G1 X94.523 Y95.356 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X89.49 Y89.618 Z6.24 F18000
G1 X78.949 Y77.601 Z6.24
G1 Z5.84
G1 E.4 F1800
; LINE_WIDTH: 0.0993531
G1 F1500
M204 S6000
G1 X79.02 Y77.387 E.00083
; LINE_WIDTH: 0.149525
G1 X79.207 Y77.151 E.00187
G1 X79.311 Y77.065 E.00083
G1 X79.444 Y77.002 E.00091
; LINE_WIDTH: 0.0997428
G1 X79.598 Y76.955 E.0006
; CHANGE_LAYER
; Z_HEIGHT: 5.96
; LAYER_HEIGHT: 0.12
; WIPE_START
G1 F1500
G1 X79.444 Y77.002 E-.38
; WIPE_END
G1 E-.02 F1800
; layer num/total_layer_count: 57/57
; update layer progress
M73 L57
M991 S0 P56 ;notify layer change
; OBJECT_ID: 8
M204 S10000
G17
G3 Z6.24 I-1.195 J.231 P1  F18000
G1 X83.893 Y100.041 Z6.24
G1 Z5.96
G1 E.4 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F1500
M204 S500
G1 X83.885 Y99.967 E.00146
G1 X83.908 Y99.572 E.00779
G1 X84.001 Y99.189 E.00774
G1 X84.103 Y98.942 E.00527
G1 X84.233 Y98.708 E.00526
G1 X84.472 Y98.399 E.00768
G1 X84.665 Y98.215 E.00525
G1 X84.878 Y98.055 E.00522
G1 X85.225 Y97.868 E.00777
G1 X85.602 Y97.745 E.0078
G1 X85.994 Y97.693 E.00777
G1 X86.26 Y97.697 E.00522
G1 X86.524 Y97.733 E.00525
G1 X86.902 Y97.843 E.00774
G1 X87.254 Y98.019 E.00774
G1 X87.472 Y98.173 E.00525
G1 X87.67 Y98.35 E.00522
G1 X87.921 Y98.655 E.00777
G1 X88.114 Y99.002 E.0078
G1 X88.241 Y99.374 E.00773
G1 X88.289 Y99.637 E.00526
G1 X88.305 Y99.901 E.0052
G1 X88.289 Y100.165 E.0052
G1 X88.241 Y100.428 E.00526
G1 X88.114 Y100.8 E.00773
G1 X87.921 Y101.146 E.00779
G1 X87.669 Y101.453 E.0078
G1 X87.367 Y101.709 E.00779
G1 X87.024 Y101.907 E.00779
G1 X86.654 Y102.04 E.00774
G1 X86.391 Y102.091 E.00526
G1 X86.124 Y102.111 E.00527
G1 X85.731 Y102.082 E.00775
G1 X85.35 Y101.982 E.00776
G1 X85.106 Y101.878 E.00522
G1 X84.874 Y101.744 E.00526
G1 X84.567 Y101.499 E.00773
G1 X84.306 Y101.2 E.0078
G1 X84.103 Y100.861 E.00777
G1 X84.003 Y100.616 E.00522
G1 X83.932 Y100.359 E.00523
G1 X83.901 Y100.101 E.00513
; WIPE_START
M204 S6000
G1 X83.885 Y99.967 E-.02553
G1 X83.908 Y99.572 E-.07529
G1 X84.001 Y99.189 E-.07474
G1 X84.103 Y98.942 E-.05089
G1 X84.233 Y98.708 E-.05079
G1 X84.472 Y98.399 E-.07417
G1 X84.581 Y98.295 E-.0286
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X83.699 Y96.891 Z6.36 F18000
G1 Z5.96
G1 E.4 F1800
G1 F1500
M204 S500
G1 X79.607 Y96.891 E.08049
G1 X79.291 Y96.854 E.00625
G1 X79.155 Y96.813 E.0028
G1 X78.953 Y96.719 E.00439
M73 P97 R0
G1 X78.708 Y96.536 E.00601
G1 X78.558 Y96.369 E.00442
G1 X78.478 Y96.246 E.00289
G1 X78.412 Y96.114 E.00289
G1 X78.341 Y95.901 E.00442
G1 X78.304 Y95.589 E.00619
G1 X78.304 Y77.61 E.35362
G1 X78.325 Y77.374 E.00466
G1 X78.358 Y77.234 E.00283
G1 X78.443 Y77.019 E.00454
G1 X78.515 Y76.895 E.00283
G1 X78.658 Y76.714 E.00454
G1 X78.764 Y76.614 E.00286
G1 X78.95 Y76.484 E.00445
G1 X79.156 Y76.388 E.00448
G1 X79.294 Y76.347 E.00283
G1 X79.522 Y76.313 E.00454
G1 X92.665 Y76.313 E.2585
G1 X92.892 Y76.346 E.00451
G1 X93.105 Y76.417 E.00442
G1 X93.303 Y76.524 E.00442
G1 X93.479 Y76.663 E.00442
G1 X93.629 Y76.831 E.00442
G1 X93.746 Y77.022 E.00442
G1 X93.829 Y77.231 E.00442
G1 X93.874 Y77.448 E.00436
G1 X93.884 Y88.791 E.2231
G1 X92.704 Y88.791 E.02321
G1 X92.704 Y77.491 E.22226
G1 X80.076 Y77.491 E.24839
G1 X79.888 Y77.524 E.00376
G1 X79.726 Y77.611 E.00361
G1 X79.584 Y77.762 E.00407
G1 X79.508 Y77.925 E.00355
G1 X79.484 Y78.086 E.00319
G1 X79.484 Y95.116 E.33498
G1 X79.508 Y95.277 E.00319
G1 X79.583 Y95.437 E.00349
G1 X79.701 Y95.57 E.00349
G1 X79.857 Y95.666 E.00362
G1 X80.073 Y95.711 E.00433
G1 X92.286 Y95.711 E.24023
G1 X92.321 Y95.323 E.00766
G1 X92.416 Y95.045 E.00579
G1 X92.545 Y94.855 E.00451
G1 X92.674 Y94.73 E.00353
G1 X92.922 Y94.585 E.00565
G1 X93.158 Y94.521 E.00481
G1 X93.448 Y94.523 E.00571
G1 X93.724 Y94.61 E.00569
G1 X94.03 Y94.807 E.00717
G1 X95.622 Y94.286 E.03294
G1 X100.647 Y87.111 E.1723
G1 X101.613 Y87.787 E.02321
G1 X96.375 Y95.268 E.17961
G1 X93.445 Y96.574 E.0631
G1 X93.229 Y96.723 E.00516
G1 X93.102 Y96.786 E.0028
G1 X92.891 Y96.855 E.00436
G1 X92.582 Y96.891 E.00611
G1 X88.471 Y96.891 E.08086
G1 X88.952 Y97.411 E.01393
G1 X89.23 Y97.772 E.00897
G1 X89.348 Y97.957 E.00431
G1 X89.558 Y98.362 E.00897
G1 X89.642 Y98.568 E.00438
G1 X89.775 Y98.997 E.00884
G1 X89.856 Y99.443 E.00891
G1 X89.877 Y99.661 E.0043
G1 X89.878 Y100.114 E.00891
G1 X89.826 Y100.563 E.00891
G1 X89.78 Y100.782 E.00438
G1 X89.649 Y101.214 E.00889
G1 X89.566 Y101.421 E.00438
G1 X89.362 Y101.821 E.00883
G1 X89.109 Y102.198 E.00893
G1 X88.816 Y102.538 E.00883
G1 X88.486 Y102.841 E.0088
G1 X88.121 Y103.103 E.00883
G1 X87.725 Y103.322 E.00891
G1 X87.524 Y103.411 E.00431
G1 X87.092 Y103.557 E.00897
G1 X86.88 Y103.608 E.0043
G1 X86.428 Y103.676 E.00898
G1 X86.21 Y103.689 E.0043
G1 X85.757 Y103.676 E.00891
G1 X85.309 Y103.608 E.00891
G1 X85.097 Y103.557 E.0043
G1 X84.667 Y103.412 E.00891
G1 X84.261 Y103.218 E.00885
G1 X83.878 Y102.975 E.00892
G1 X83.53 Y102.691 E.00883
G1 X83.373 Y102.539 E.0043
G1 X83.078 Y102.195 E.00891
G1 X82.825 Y101.818 E.00893
G1 X82.621 Y101.417 E.00884
G1 X82.54 Y101.215 E.0043
G1 X82.408 Y100.781 E.00891
G1 X82.33 Y100.338 E.00885
G1 X82.305 Y99.889 E.00885
G1 X82.333 Y99.437 E.00891
G1 X82.366 Y99.22 E.00431
G1 X82.473 Y98.784 E.00883
G1 X82.633 Y98.359 E.00893
G1 X82.84 Y97.96 E.00885
G1 X83.093 Y97.588 E.00885
G1 X83.659 Y96.936 E.01698
; WIPE_START
M204 S6000
G1 X81.66 Y96.914 E-.38
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




G1 X93.658 Y77.768
G1 Z5.96
G1 E.4 F1800
; FEATURE: Top surface
G1 F1500
M204 S2000
G1 X92.42 Y76.53 E.03443
G1 X92.606 Y77.274
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
G1 X79.143 Y76.634
G1 X79.824 Y77.315 E.01895
G1 X79.493 Y77.542
G1 X78.816 Y76.865 E.01885
G1 X78.602 Y77.208
G1 X79.293 Y77.899 E.01921
G1 X79.268 Y78.431
G1 X78.521 Y77.685 E.02076
G1 X78.521 Y78.243
G1 X79.268 Y78.989 E.02076
G1 X79.268 Y79.546
G1 X78.521 Y78.8 E.02076
G1 X78.521 Y79.358
G1 X79.268 Y80.104 E.02076
G1 X79.268 Y80.662
G1 X78.521 Y79.915 E.02076
G1 X78.521 Y80.473
G1 X79.268 Y81.219 E.02076
G1 X79.268 Y81.777
G1 X78.521 Y81.03 E.02076
G1 X78.521 Y81.588
G1 X79.268 Y82.334 E.02076
G1 X79.268 Y82.892
G1 X78.521 Y82.145 E.02076
G1 X78.521 Y82.703
G1 X79.268 Y83.449 E.02076
G1 X79.268 Y84.007
G1 X78.521 Y83.26 E.02076
G1 X78.521 Y83.818
G1 X79.268 Y84.564 E.02076
G1 X79.268 Y85.122
G1 X78.521 Y84.375 E.02076
G1 X78.521 Y84.933
G1 X79.268 Y85.679 E.02076
G1 X79.268 Y86.237
G1 X78.521 Y85.491 E.02076
G1 X78.521 Y86.048
G1 X79.268 Y86.794 E.02076
G1 X79.268 Y87.352
G1 X78.521 Y86.606 E.02076
G1 X78.521 Y87.163
G1 X79.268 Y87.91 E.02076
G1 X79.268 Y88.467
G1 X78.521 Y87.721 E.02076
G1 X78.521 Y88.278
G1 X79.268 Y89.025 E.02076
G1 X79.268 Y89.582
G1 X78.521 Y88.836 E.02076
G1 X78.521 Y89.393
G1 X79.268 Y90.14 E.02076
G1 X79.268 Y90.697
G1 X78.521 Y89.951 E.02076
G1 X78.521 Y90.508
G1 X79.268 Y91.255 E.02076
G1 X79.268 Y91.812
G1 X78.521 Y91.066 E.02076
G1 X78.521 Y91.623
G1 X79.268 Y92.37 E.02076
G1 X79.268 Y92.927
G1 X78.521 Y92.181 E.02076
G1 X78.521 Y92.739
G1 X79.268 Y93.485 E.02076
G1 X79.268 Y94.042
G1 X78.521 Y93.296 E.02076
G1 X78.521 Y93.854
G1 X79.268 Y94.6 E.02076
G1 X79.272 Y95.162
G1 X78.521 Y94.411 E.02088
; WIPE_START
M204 S6000
G1 X79.272 Y95.162 E-.20172
G1 X79.268 Y94.6 E-.10677
G1 X79.001 Y94.334 E-.07151
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X83.881 Y88.465 Z6.36 F18000
G1 X92.921 Y77.589 Z6.36
G1 Z5.96
G1 E.4 F1800
G1 F1500
M204 S2000
G1 X93.658 Y78.326 E.0205
G1 X93.659 Y78.884
G1 X92.921 Y78.147 E.02051
G1 X92.921 Y78.704
G1 X93.659 Y79.442 E.02053
G1 X93.66 Y80
G1 X92.921 Y79.262 E.02054
G1 X92.921 Y79.819
G1 X93.66 Y80.558 E.02055
G1 X93.661 Y81.116
G1 X92.921 Y80.377 E.02057
G1 X92.921 Y80.934
G1 X93.661 Y81.674 E.02058
G1 X93.662 Y82.232
G1 X92.921 Y81.492 E.0206
G1 X92.921 Y82.049
G1 X93.662 Y82.79 E.02061
G1 X93.663 Y83.348
G1 X92.921 Y82.607 E.02062
G1 X92.921 Y83.164
G1 X93.663 Y83.906 E.02064
G1 X93.664 Y84.464
G1 X92.921 Y83.722 E.02065
G1 X92.921 Y84.279
G1 X93.664 Y85.022 E.02066
G1 X93.665 Y85.58
G1 X92.921 Y84.837 E.02068
G1 X92.921 Y85.395
G1 X93.665 Y86.138 E.02069
G1 X93.666 Y86.696
G1 X92.921 Y85.952 E.0207
G1 X92.921 Y86.51
G1 X93.666 Y87.254 E.02072
G1 X93.667 Y87.812
G1 X92.921 Y87.067 E.02073
G1 X92.921 Y87.625
G1 X93.667 Y88.37 E.02075
G1 X93.313 Y88.574
G1 X92.921 Y88.182 E.0109
; WIPE_START
M204 S6000
G1 X93.313 Y88.574 E-.10529
G1 X93.667 Y88.37 E-.07758
G1 X92.933 Y87.637 E-.19713
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X100.565 Y87.522 Z6.36 F18000
G1 X100.624 Y87.521 Z6.36
G1 Z5.96
G1 E.4 F1800
G1 F1500
M204 S2000
G1 X101.159 Y88.057 E.01491
G1 X100.93 Y88.385
G1 X100.394 Y87.849 E.01491
G1 X100.164 Y88.177
G1 X100.7 Y88.713 E.01491
G1 X100.471 Y89.041
G1 X99.935 Y88.505 E.01491
G1 X99.705 Y88.833
G1 X100.241 Y89.369 E.01491
G1 X100.011 Y89.697
G1 X99.475 Y89.161 E.01491
G1 X99.246 Y89.489
G1 X99.782 Y90.025 E.01491
G1 X99.552 Y90.353
G1 X99.016 Y89.817 E.01491
G1 X98.787 Y90.145
G1 X99.322 Y90.681 E.01491
G1 X99.093 Y91.009
G1 X98.557 Y90.473 E.01491
G1 X98.327 Y90.801
G1 X98.863 Y91.337 E.01491
G1 X98.634 Y91.664
G1 X98.098 Y91.129 E.01491
G1 X97.868 Y91.457
G1 X98.404 Y91.992 E.01491
G1 X98.174 Y92.32
G1 X97.639 Y91.784 E.01491
G1 X97.409 Y92.112
G1 X97.945 Y92.648 E.01491
G1 X97.715 Y92.976
G1 X97.179 Y92.44 E.01491
G1 X96.95 Y92.768
G1 X97.486 Y93.304 E.01491
G1 X97.256 Y93.632
G1 X96.72 Y93.096 E.01491
G1 X96.49 Y93.424
G1 X97.026 Y93.96 E.01491
G1 X96.797 Y94.288
G1 X96.261 Y93.752 E.01491
G1 X96.031 Y94.08
G1 X96.567 Y94.616 E.01491
G1 X96.337 Y94.944
G1 X95.802 Y94.408 E.01491
G1 X95.418 Y94.581
G1 X96.023 Y95.187 E.01685
G1 X95.638 Y95.359
G1 X94.998 Y94.719 E.01781
G1 X94.578 Y94.856
G1 X95.252 Y95.531 E.01877
G1 X94.867 Y95.703
G1 X94.158 Y94.994 E.01973
G1 X93.346 Y94.739
G1 X94.481 Y95.875 E.03159
G1 X94.096 Y96.047
G1 X92.898 Y94.85 E.0333
G1 X92.621 Y95.13
G1 X93.71 Y96.219 E.0303
G1 X93.326 Y96.393
G1 X92.516 Y95.582 E.02255
G1 X92.304 Y95.928
G1 X92.975 Y96.6 E.01869
G1 X92.492 Y96.674
G1 X91.746 Y95.928 E.02076
G1 X91.189 Y95.928
G1 X91.935 Y96.674 E.02076
G1 X91.377 Y96.674
G1 X90.631 Y95.928 E.02076
G1 X90.073 Y95.928
G1 X90.82 Y96.674 E.02076
G1 X90.262 Y96.674
G1 X89.516 Y95.928 E.02076
G1 X88.958 Y95.928
G1 X89.705 Y96.674 E.02076
M73 P98 R0
G1 X89.147 Y96.674
G1 X88.401 Y95.928 E.02076
G1 X87.843 Y95.928
G1 X88.59 Y96.674 E.02076
G1 X88.032 Y96.674
G1 X87.286 Y95.928 E.02076
G1 X86.728 Y95.928
G1 X89.435 Y98.634 E.07529
G1 X89.625 Y99.382
G1 X86.171 Y95.928 E.09608
G1 X85.613 Y95.928
G1 X89.661 Y99.975 E.11259
; WIPE_START
M204 S6000
G1 X88.247 Y98.561 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X88.453 Y99.325 Z6.36 F18000
G1 Z5.96
G1 E.4 F1800
G1 F1500
M204 S2000
G1 X89.616 Y100.488 E.03237
G1 X89.507 Y100.937
G1 X88.519 Y99.949 E.02748
G1 X88.458 Y100.446
G1 X89.36 Y101.347 E.02508
G1 X89.171 Y101.716
G1 X88.321 Y100.866 E.02365
G1 X88.124 Y101.227
G1 X88.947 Y102.049 E.02288
G1 X88.691 Y102.351
G1 X87.879 Y101.539 E.02259
G1 X87.588 Y101.806
G1 X88.404 Y102.622 E.0227
G1 X88.086 Y102.861
G1 X87.251 Y102.026 E.02323
G1 X86.863 Y102.195
G1 X87.736 Y103.068 E.02429
G1 X87.351 Y103.241
G1 X86.417 Y102.307 E.02598
G1 X85.861 Y102.309
G1 X86.927 Y103.374 E.02963
G1 X86.449 Y103.454
G1 X85.111 Y102.116 E.03721
; WIPE_START
M204 S6000
G1 X86.449 Y103.454 E-.35949
G1 X86.555 Y103.436 E-.02051
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X86.68 Y97.552 Z6.36 F18000
G1 Z5.96
G1 E.4 F1800
G1 F1500
M204 S2000
G1 X85.056 Y95.928 E.04519
G1 X84.498 Y95.928
G1 X86.047 Y97.477 E.04308
G1 X85.548 Y97.535
G1 X83.941 Y95.928 E.04471
G1 X84.129 Y96.674
G1 X83.383 Y95.928 E.02076
G1 X82.825 Y95.928
G1 X83.572 Y96.674 E.02076
G1 X83.014 Y96.674
G1 X82.268 Y95.928 E.02076
G1 X81.71 Y95.928
G1 X82.457 Y96.674 E.02076
G1 X81.899 Y96.674
G1 X81.153 Y95.928 E.02076
G1 X80.595 Y95.928
G1 X81.342 Y96.674 E.02076
G1 X80.784 Y96.674
G1 X80.034 Y95.924 E.02085
G1 X80.227 Y96.674
G1 X78.521 Y94.969 E.04744
G1 X78.521 Y95.526
G1 X79.669 Y96.674 E.03193
; WIPE_START
M204 S6000
G1 X78.521 Y95.526 E-.30842
G1 X78.521 Y95.149 E-.07158
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X84.154 Y96.698 Z6.36 F18000
G1 Z5.96
G1 E.4 F1800
G1 F1500
M204 S2000
G1 X85.129 Y97.674 E.02713
G1 X84.767 Y97.869
G1 X83.894 Y96.997 E.02427
G1 X83.635 Y97.295
G1 X84.455 Y98.115 E.02282
G1 X84.191 Y98.408
G1 X83.376 Y97.593 E.02268
G1 X83.135 Y97.91
G1 X83.966 Y98.741 E.02311
G1 X83.794 Y99.126
G1 X82.928 Y98.26 E.02408
G1 X82.756 Y98.646
G1 X83.69 Y99.58 E.02598
G1 X83.686 Y100.134
G1 X82.626 Y99.073 E.02951
G1 X82.543 Y99.548
G1 X83.878 Y100.883 E.03712
; WIPE_START
M204 S6000
G1 X82.543 Y99.548 E-.35862
G1 X82.563 Y99.437 E-.02139
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X82.534 Y100.096 Z6.36 F18000
G1 Z5.96
G1 E.4 F1800
G1 F1500
M204 S2000
G1 X85.9 Y103.463 E.09365
G1 X85.251 Y103.371
G1 X82.624 Y100.744 E.07309
; WIPE_START
M204 S6000
G1 X84.038 Y102.158 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X88.594 Y99.745 Z6.36 F18000
G1 Z5.96
G1 E.4 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.0792583
G1 F1500
M204 S6000
G1 X88.502 Y99.966 E.00064
; WIPE_START
G1 X88.594 Y99.745 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X84.806 Y103.231 Z6.36 F18000
G1 Z5.96
G1 E.4 F1800
; LINE_WIDTH: 0.0816956
G1 F1500
M204 S6000
G1 X84.754 Y103.199 E.00017
; LINE_WIDTH: 0.114277
G1 X84.638 Y103.117 E.00063
; LINE_WIDTH: 0.162152
G1 X84.523 Y103.035 E.00096
; LINE_WIDTH: 0.210027
G1 X84.407 Y102.954 E.0013
; LINE_WIDTH: 0.256925
G1 X84.244 Y102.823 E.00241
; LINE_WIDTH: 0.302852
G1 X84.081 Y102.693 E.00289
; LINE_WIDTH: 0.354129
G1 X83.643 Y102.285 E.0098
G1 X83.36 Y101.98 E.00681
; LINE_WIDTH: 0.318553
G1 X83.228 Y101.82 E.00304
; LINE_WIDTH: 0.277966
G1 X83.096 Y101.659 E.00262
; LINE_WIDTH: 0.235536
G1 X82.982 Y101.503 E.00202
; LINE_WIDTH: 0.191272
G1 X82.869 Y101.347 E.00159
; LINE_WIDTH: 0.147007
G1 X82.756 Y101.191 E.00117
; WIPE_START
G1 X82.869 Y101.347 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X85.121 Y102.106 Z6.36 F18000
G1 Z5.96
G1 E.4 F1800
; LINE_WIDTH: 0.192822
G1 F1500
M204 S6000
G1 X84.971 Y102.13 E.00126
; LINE_WIDTH: 0.18338
G1 X84.855 Y102.04 E.00116
; LINE_WIDTH: 0.143953
G1 X84.732 Y101.946 E.00091
; LINE_WIDTH: 0.0955966
G1 X84.411 Y101.659 E.0015
G1 X84.111 Y101.337 E.00153
; LINE_WIDTH: 0.131252
G1 X83.988 Y101.18 E.00105
; LINE_WIDTH: 0.180558
G1 X83.866 Y101.022 E.00154
G1 X83.87 Y100.983 E.00031
; LINE_WIDTH: 0.149687
G1 X83.888 Y100.873 E.00069
M204 S10000
G1 X83.729 Y100.43 F18000
; LINE_WIDTH: 0.0768719
G1 F1500
M204 S6000
G1 X83.61 Y100.21 E.00064
; WIPE_START
G1 X83.729 Y100.43 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X86.315 Y97.489 Z6.36 F18000
G1 Z5.96
G1 E.4 F1800
; LINE_WIDTH: 0.0843665
G1 F1500
M204 S6000
G1 X86.124 Y97.4 E.00062
M204 S10000
G1 X87.055 Y97.677 F18000
; LINE_WIDTH: 0.0904847
G1 F1500
M204 S6000
G1 X86.755 Y97.477 E.00116
; WIPE_START
G1 X87.055 Y97.677 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X94.395 Y95.584 Z6.36 F18000
G1 X96.259 Y95.053 Z6.36
G1 Z5.96
G1 E.4 F1800
; LINE_WIDTH: 0.0838291
G1 F1500
M204 S6000
G1 X96.214 Y95.099 E.00019
G1 X96.163 Y95.104 E.00015
G1 X96.072 Y95.166 E.00032
; WIPE_START
G1 X96.163 Y95.104 E-.18543
G1 X96.214 Y95.099 E-.08666
G1 X96.259 Y95.053 E-.1079
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X100.652 Y88.812 Z6.36 F18000
G1 X101.314 Y87.871 Z6.36
G1 Z5.96
G1 E.4 F1800
; LINE_WIDTH: 0.089315
G1 F1500
M204 S6000
G1 X101.122 Y87.71 E.00079
; WIPE_START
G1 X101.314 Y87.871 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X96.063 Y93.411 Z6.36 F18000
G1 X93.145 Y96.49 Z6.36
G1 Z5.96
G1 E.4 F1800
; LINE_WIDTH: 0.092188
G1 F1500
M204 S6000
G1 X93.016 Y96.587 E.00053
; WIPE_START
G1 X93.145 Y96.49 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X89.129 Y98.02 Z6.36 F18000
G1 Z5.96
G1 E.4 F1800
; LINE_WIDTH: 0.0861945
G1 F1500
M204 S6000
G1 X89.038 Y97.907 E.00044
; LINE_WIDTH: 0.113328
G1 X88.895 Y97.743 E.00095
; LINE_WIDTH: 0.141319
G1 X88.751 Y97.58 E.00125
; LINE_WIDTH: 0.17259
G1 X88.032 Y96.832 E.0076
; WIPE_START
G1 X88.751 Y97.58 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X83.852 Y95.929 Z6.36 F18000
G1 Z5.96
G1 E.4 F1800
; LINE_WIDTH: 0.085438
G1 F1500
M204 S6000
G1 X83.684 Y95.95 E.0005
; WIPE_START
G1 X83.852 Y95.929 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X79.329 Y96.649 Z6.36 F18000
G1 Z5.96
G1 E.4 F1800
; LINE_WIDTH: 0.129394
G1 F1500
M204 S6000
G1 X79.211 Y96.566 E.00074
; LINE_WIDTH: 0.160747
G1 X79.093 Y96.484 E.00097
; LINE_WIDTH: 0.19806
G1 X78.905 Y96.321 E.00214
G1 X78.715 Y96.108 E.00245
; LINE_WIDTH: 0.161785
G1 X78.545 Y95.872 E.00197
; WIPE_START
G1 X78.715 Y96.108 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X80.483 Y96.652 Z6.36 F18000
G1 Z5.96
G1 E.4 F1800
; LINE_WIDTH: 0.0856904
G1 F1500
M204 S6000
G1 X80.314 Y96.673 E.00051
M204 S10000
G1 X79.886 Y95.962 F18000
; LINE_WIDTH: 0.0929036
G1 F1500
M204 S6000
G1 X79.665 Y95.804 E.00091
M204 S10000
G1 X79.385 Y95.526 F18000
; LINE_WIDTH: 0.0889218
G1 F1500
M204 S6000
G1 X79.326 Y95.442 E.00033
; LINE_WIDTH: 0.123518
G1 X79.258 Y95.342 E.00059
; LINE_WIDTH: 0.159431
G1 X79.202 Y95.231 E.00083
; WIPE_START
G1 X79.258 Y95.342 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X79.19 Y87.71 Z6.36 F18000
G1 X79.091 Y76.658 Z6.36
G1 Z5.96
G1 E.4 F1800
; LINE_WIDTH: 0.0818288
G1 F1500
M204 S6000
G1 X78.978 Y76.748 E.0004
; WIPE_START
G1 X79.091 Y76.658 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X86.723 Y76.775 Z6.36 F18000
G1 X93.406 Y76.878 Z6.36
G1 Z5.96
G1 E.4 F1800
; LINE_WIDTH: 0.0835049
G1 F1500
M204 S6000
G1 X92.73 Y76.538 E.00218
; WIPE_START
G1 X93.406 Y76.878 E-.38
; WIPE_END
G1 E-.02 F1800
M204 S10000
G1 X93.662 Y77.394 Z6.36 F18000
G1 Z5.96
G1 E.4 F1800
; LINE_WIDTH: 0.264814
G1 F1500
M204 S6000
G1 X93.369 Y77.024 E.00562
G1 X93.128 Y76.79 E.00401
; LINE_WIDTH: 0.252993
G1 X92.953 Y76.659 E.00247
; LINE_WIDTH: 0.227858
G1 X92.778 Y76.529 E.0022
M204 S10000
G1 X92.33 Y76.531 F18000
; LINE_WIDTH: 0.0852312
G1 F1500
M204 S6000
G1 X92.163 Y76.552 E.0005
M204 S10000
G1 X92.863 Y77.252 F18000
; LINE_WIDTH: 0.0852212
G1 F1500
M204 S6000
G1 X92.696 Y77.273 E.0005
; close powerlost recovery
M1003 S0
; WIPE_START
G1 F1500
G1 X92.863 Y77.252 E-.38
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

